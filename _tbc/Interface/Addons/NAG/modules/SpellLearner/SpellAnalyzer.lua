--- ============================ HEADER ============================
--[[
    SpellAnalyzer.lua - Spell Effect Analysis Module for NAG

    Analyzes spell effects by comparing pre-cast and post-cast state snapshots.
    Detects resource costs/gains, buff/debuff applications/removals, and cooldown changes.

    Authors: NAG Team
    License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
    Status: Development

    Part of the SpellLearner system refactor - handles pure analytical comparison
    of state snapshots without confidence scoring or machine learning.
]]

--- ============================ LOCALIZE ============================
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type OptionsFactory
local OptionsFactory


local L = ns.AceLocale:GetLocale("NAG", true)

local WoWAPI = ns.WoWAPI

-- Lua APIs (WoW optimized versions)
local format = string.format
local abs = math.abs
local max = math.max
local min = math.min

-- Table operations
local pairs = pairs
local type = type

--- ============================ CONTENT ============================

-- Default settings
local defaults = {
    global = {
        version = 1,
    },
    char = {
        enabled = false,         -- Disabled by default - use commands to enable
        analysisThreshold = 0.1, -- Minimum change to consider significant
    }
}

--- @class SpellAnalyzer: CoreModule
local SpellAnalyzer = NAG:CreateModule("SpellAnalyzer", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = "spelllearner",
    optionsOrder = 1,
    childGroups = "tab",
    optionsComposers = {
        ["spelllearner"] = true  -- Inject into unified SpellLearner category
    },
})
local module = SpellAnalyzer
ns.SpellAnalyzer = SpellAnalyzer

do -- Ace3 lifecycle methods
    --- Initialize the module
    function SpellAnalyzer:ModuleInitialize()
        -- ============================ MODULE ASSIGNMENT ============================
        -- Assign Ace3 modules directly (no metatable access)
        OptionsFactory = NAG:GetModule("OptionsFactory")

    end

    --- Enable the module
    function SpellAnalyzer:ModuleEnable()
        -- Check if module is enabled


        -- ============================ MODULE INITIALIZATION ============================
        if not self.db.char.enabled then
            self:Debug("SpellAnalyzer is disabled by default. Use a command to enable it.")
            return
        end
    end

    --- Disable the module
    function SpellAnalyzer:ModuleDisable()
    end
end

do -- Core Analysis Functions
    --- Analyze differences between pre-cast and post-cast states
    --- @param preState table State snapshot before spell cast
    --- @param postState table State snapshot after spell cast
    --- @return table Structured analysis results with cost, generates, applies, consumes
    function SpellAnalyzer:Analyze(preState, postState)
        -- Check if module is enabled
        if not self.db.char.enabled then
            return self:CreateEmptyAnalysis()
        end

        -- 🔍 DEBUG: Add debug logging to track analysis
        self:Debug("🔍 SpellAnalyzer:Analyze called with preState: %s, postState: %s", preState and "exists" or "nil",
            postState and "exists" or "nil")

        if not preState or not postState then
            self:Debug("🚨 SpellAnalyzer:Analyze - nil state data, returning empty analysis")
            return self:CreateEmptyAnalysis()
        end

        self:Debug("🔍 SpellAnalyzer:Analyze - analyzing resources, buffs, debuffs, cooldowns")

        -- Initialize analysis structure
        local analysis = {
            cost = { resources = {} },
            generates = { resources = {} },
            applies = { buffs = {}, debuffs = {} },
            consumes = { buffs = {}, debuffs = {} },
            cooldowns = {}
        }

        -- Analyze each aspect
        local hasChanges = false

        -- Analyze resource costs and generation
        local costChanges, generateChanges = self:AnalyzeResources(preState, postState)
        if costChanges and next(costChanges) then
            analysis.cost.resources = costChanges
            hasChanges = true
        end
        if generateChanges and next(generateChanges) then
            analysis.generates.resources = generateChanges
            hasChanges = true
        end

        -- Analyze buff applications and removals
        local buffChanges = self:AnalyzeBuffs(preState, postState)
        if buffChanges and next(buffChanges) then
            analysis.applies.buffs = buffChanges.applies or {}
            analysis.consumes.buffs = buffChanges.consumes or {}
            hasChanges = true
        end

        -- Analyze debuff applications and removals
        local debuffChanges = self:AnalyzeDebuffs(preState, postState)
        if debuffChanges and next(debuffChanges) then
            analysis.applies.debuffs = debuffChanges.applies or {}
            analysis.consumes.debuffs = debuffChanges.consumes or {}
            hasChanges = true
        end

        -- Analyze cooldown changes
        local cooldownChanges = self:AnalyzeCooldowns(preState, postState)
        if cooldownChanges and next(cooldownChanges) then
            analysis.cooldowns = cooldownChanges
            hasChanges = true
        end

        self:Debug("🔍 SpellAnalyzer:Analyze - analysis complete, has changes: %s", hasChanges)

        if hasChanges then
            self:Debug("🔍 SpellAnalyzer:Analyze - returning analysis with changes")
            return analysis
        else
            self:Debug("🔍 SpellAnalyzer:Analyze - returning empty analysis (no changes detected)")
            return self:CreateEmptyAnalysis()
        end
    end

    --- Create an empty analysis structure
    --- @return table Empty analysis results
    function SpellAnalyzer:CreateEmptyAnalysis()
        return {
            cost = {
                resources = {},
                secondary = {}
            },
            generates = {
                resources = {},
                secondary = {}
            },
            applies = {
                buffs = {},
                debuffs = {}
            },
            consumes = {
                buffs = {},
                debuffs = {}
            },
            cooldowns = {
                triggered = {},
                reset = {}
            }
        }
    end

    --- Analyze resource changes between states
    --- @param preState table Pre-cast state
    --- @param postState table Post-cast state
    --- @return table costChanges, table generateChanges
    function SpellAnalyzer:AnalyzeResources(preState, postState)
        -- 🔍 DEBUG: Log resource analysis
        self:Debug("🔍 SpellAnalyzer:AnalyzeResources - checking resource changes")

        local costChanges = {}
        local generateChanges = {}

        -- Analyze primary resources (mana, energy, rage, etc.)
        if preState.resources and postState.resources then
            self:Debug("🔍 SpellAnalyzer:AnalyzeResources - both states have resources, comparing")
            self:CompareResourceTable(preState.resources, postState.resources, costChanges, generateChanges, "resources")
        else
            self:Debug("🔍 SpellAnalyzer:AnalyzeResources - missing resources in one or both states")
            self:Debug("🔍 PreState resources: %s", preState.resources and "exists" or "nil")
            self:Debug("🔍 PostState resources: %s", postState.resources and "exists" or "nil")
        end

        -- Analyze secondary resources (combo points, soul shards, etc.)
        if preState.secondary and postState.secondary then
            self:Debug("🔍 SpellAnalyzer:AnalyzeResources - both states have secondary resources, comparing")
            self:CompareResourceTable(preState.secondary, postState.secondary, costChanges, generateChanges, "secondary")
        else
            self:Debug("🔍 SpellAnalyzer:AnalyzeResources - missing secondary resources in one or both states")
        end

        -- Analyze runes for Death Knights
        if preState.runes and postState.runes then
            self:Debug("🔍 SpellAnalyzer:AnalyzeResources - both states have runes, analyzing")
            self:AnalyzeRuneChanges(preState.runes, postState.runes, costChanges, generateChanges)
        else
            self:Debug("🔍 SpellAnalyzer:AnalyzeResources - missing runes in one or both states")
        end

        return costChanges, generateChanges
    end

    --- Compare resource tables and populate analysis
    --- @param preResources table Pre-cast resources
    --- @param postResources table Post-cast resources
    --- @param costChanges table Analysis results to populate for cost
    --- @param generateChanges table Analysis results to populate for generation
    --- @param resourceType string Type of resource being compared
    function SpellAnalyzer:CompareResourceTable(preResources, postResources, costChanges, generateChanges, resourceType)
        -- 🔍 DEBUG: Log resource comparison
        self:Debug("🔍 SpellAnalyzer:CompareResourceTable - comparing %s resources", resourceType)
        self:Debug("🔍 PreResources keys: %s", next(preResources) and "has data" or "empty")
        self:Debug("🔍 PostResources keys: %s", next(postResources) and "has data" or "empty")

        for resourceName, preValue in pairs(preResources) do
            local postValue = postResources[resourceName]

            -- 🔧 FIX: Accept valid values even if some fields are missing
            -- Extract numerical values from complex resource structures
            local preNum = self:ExtractResourceValue(preValue)
            local postNum = self:ExtractResourceValue(postValue)

            if preNum and postNum then
                local delta = postNum - preNum

                self:Debug("🔍 Resource %s: %f -> %f delta: %f threshold: %f", resourceName, preNum, postNum, delta,
                    self.db.char.analysisThreshold)

                if abs(delta) >= self.db.char.analysisThreshold then
                    if delta < 0 then
                        -- Resource was consumed
                        costChanges[resourceName] = abs(delta)
                        self:Debug("🔍 Recorded cost for %s: %f", resourceName, abs(delta))
                    else
                        -- Resource was gained
                        generateChanges[resourceName] = delta
                        self:Debug("🔍 Recorded generation for %s: %f", resourceName, delta)
                    end
                else
                    self:Debug("🔍 Delta %f below threshold %f for %s", delta, self.db.char.analysisThreshold,
                        resourceName)
                end
            else
                self:Debug("🔍 Could not extract numerical values for %s - pre: %s, post: %s", resourceName,
                    tostring(preValue), tostring(postValue))
            end
        end
    end

    --- Extract numerical value from resource data
    --- @param value any The resource value (could be number, table with .current, etc.)
    --- @return number|nil The numerical value or nil if not extractable
    function SpellAnalyzer:ExtractResourceValue(value)
        if type(value) == "number" then
            return value
        elseif type(value) == "table" then
            -- Handle resource structures like { current = 100, max = 200 }
            if value.current and type(value.current) == "number" then
                return value.current
            elseif value.amount and type(value.amount) == "number" then
                return value.amount
            elseif value.value and type(value.value) == "number" then
                return value.value
            end
        end
        return nil
    end

    --- Analyze rune changes for Death Knights
    --- @param preRunes table Pre-cast rune state
    --- @param postRunes table Post-cast rune state
    --- @param costChanges table Analysis results to populate for cost
    --- @param generateChanges table Analysis results to populate for generation
    function SpellAnalyzer:AnalyzeRuneChanges(preRunes, postRunes, costChanges, generateChanges)
        self:Debug("🔍 SpellAnalyzer:AnalyzeRuneChanges - analyzing rune usage")

        local runesSpent = {}
        local runesGenerated = {}

        -- Check each rune slot
        for i = 1, 6 do
            local preRune = preRunes[i]
            local postRune = postRunes[i]

            if preRune and postRune then
                self:Debug("🔍 Rune %d: pre-ready=%s, post-ready=%s, pre-type=%s, post-type=%s",
                    i, preRune.ready and "true" or "false", postRune.ready and "true" or "false",
                    preRune.type or "nil", postRune.type or "nil")

                -- 🔧 FIX: Enhanced rune consumption detection
                -- Check if rune was spent (ready -> not ready OR cooldown increased)
                local runeWasSpent = false

                if preRune.ready and not postRune.ready then
                    runeWasSpent = true
                    self:Debug("🔍 Rune %d was spent (ready -> not ready)", i)
                elseif preRune.cooldown and postRune.cooldown then
                    -- Check if cooldown time increased significantly
                    local cooldownDelta = postRune.cooldown - preRune.cooldown
                    if cooldownDelta > 5 then -- More than 5 seconds added
                        runeWasSpent = true
                        self:Debug("🔍 Rune %d was spent (cooldown increased by %.1fs)", i, cooldownDelta)
                    end
                end

                if runeWasSpent then
                    local runeTypeName = self:GetRuneTypeName(preRune.type or postRune.type)
                    runesSpent[runeTypeName] = (runesSpent[runeTypeName] or 0) + 1
                    self:Debug("🔍 Rune %d (%s) was spent", i, runeTypeName)
                end

                -- Check if rune became ready (not ready -> ready)
                if not preRune.ready and postRune.ready then
                    local runeTypeName = self:GetRuneTypeName(postRune.type)
                    runesGenerated[runeTypeName] = (runesGenerated[runeTypeName] or 0) + 1
                    self:Debug("🔍 Rune %d (%s) became ready", i, runeTypeName)
                end
            end
        end

        -- 🔧 FIX: Store runes under a dedicated "runes" key
        if next(runesSpent) then
            if not costChanges.runes then
                costChanges.runes = {}
            end
            for runeType, count in pairs(runesSpent) do
                costChanges.runes[runeType] = count
                self:Debug("🔍 Recorded rune cost: %s x%d", runeType, count)
            end
        end

        if next(runesGenerated) then
            if not generateChanges.runes then
                generateChanges.runes = {}
            end
            for runeType, count in pairs(runesGenerated) do
                generateChanges.runes[runeType] = count
                self:Debug("🔍 Recorded rune generation: %s x%d", runeType, count)
            end
        end
    end

    --- Get rune type name from rune type ID
    --- @param runeType number The rune type ID
    --- @return string The rune type name
    function SpellAnalyzer:GetRuneTypeName(runeType)
        local runeTypes = {
            [1] = "Blood",
            [2] = "Frost",
            [3] = "Unholy",
            [4] = "Death"
        }
        return runeTypes[runeType] or "Unknown"
    end

    --- Analyze buff changes between states
    --- @param preState table Pre-cast state
    --- @param postState table Post-cast state
    --- @return table buffChanges
    function SpellAnalyzer:AnalyzeBuffs(preState, postState)
        if not preState.buffs or not postState.buffs then
            return {}
        end

        local buffChanges = {
            applies = {},
            consumes = {}
        }

        -- Find buffs that were applied (present in post but not pre)
        for buffId, postBuff in pairs(postState.buffs) do
            local preBuff = preState.buffs[buffId]
            if not preBuff then
                -- Buff was applied
                buffChanges.applies[buffId] = {
                    stacks = postBuff.stacks or 1,
                    duration = postBuff.duration or 0,
                    source = postBuff.source
                }
            elseif preBuff.stacks and postBuff.stacks and postBuff.stacks > preBuff.stacks then
                -- Buff stacks increased
                buffChanges.applies[buffId] = {
                    stacksAdded = postBuff.stacks - preBuff.stacks,
                    duration = postBuff.duration or 0,
                    source = postBuff.source
                }
            end
        end

        -- Find buffs that were consumed (present in pre but not post)
        for buffId, preBuff in pairs(preState.buffs) do
            local postBuff = postState.buffs[buffId]
            if not postBuff then
                -- Buff was consumed/removed
                buffChanges.consumes[buffId] = {
                    stacks = preBuff.stacks or 1,
                    source = preBuff.source
                }
            elseif preBuff.stacks and postBuff.stacks and postBuff.stacks < preBuff.stacks then
                -- Buff stacks decreased
                buffChanges.consumes[buffId] = {
                    stacksRemoved = preBuff.stacks - postBuff.stacks,
                    source = preBuff.source
                }
            end
        end

        return buffChanges
    end

    --- Analyze debuff changes between states
    --- @param preState table Pre-cast state
    --- @param postState table Post-cast state
    --- @return table debuffChanges
    function SpellAnalyzer:AnalyzeDebuffs(preState, postState)
        if not preState.debuffs or not postState.debuffs then
            return {}
        end

        local debuffChanges = {
            applies = {},
            consumes = {}
        }

        -- Find debuffs that were applied (present in post but not pre)
        for debuffId, postDebuff in pairs(postState.debuffs) do
            local preDebuff = preState.debuffs[debuffId]
            if not preDebuff then
                -- Debuff was applied
                debuffChanges.applies[debuffId] = {
                    stacks = postDebuff.stacks or 1,
                    duration = postDebuff.duration or 0,
                    target = postDebuff.target
                }
            elseif preDebuff.stacks and postDebuff.stacks and postDebuff.stacks > preDebuff.stacks then
                -- Debuff stacks increased
                debuffChanges.applies[debuffId] = {
                    stacksAdded = postDebuff.stacks - preDebuff.stacks,
                    duration = postDebuff.duration or 0,
                    target = postDebuff.target
                }
            end
        end

        -- Find debuffs that were consumed (present in pre but not post)
        for debuffId, preDebuff in pairs(preState.debuffs) do
            local postDebuff = postState.debuffs[debuffId]
            if not postDebuff then
                -- Debuff was consumed/removed
                debuffChanges.consumes[debuffId] = {
                    stacks = preDebuff.stacks or 1,
                    target = preDebuff.target
                }
            elseif preDebuff.stacks and postDebuff.stacks and postDebuff.stacks < preDebuff.stacks then
                -- Debuff stacks decreased
                debuffChanges.consumes[debuffId] = {
                    stacksRemoved = preDebuff.stacks - postDebuff.stacks,
                    target = preDebuff.target
                }
            end
        end

        return debuffChanges
    end

    --- Analyze cooldown changes between states
    --- @param preState table Pre-cast state
    --- @param postState table Post-cast state
    --- @return table cooldownChanges
    function SpellAnalyzer:AnalyzeCooldowns(preState, postState)
        if not preState.cooldowns or not postState.cooldowns then
            return {}
        end

        local cooldownChanges = {
            triggered = {},
            reset = {}
        }

        -- Find cooldowns that were triggered
        for spellId, postCooldown in pairs(postState.cooldowns) do
            local preCooldown = preState.cooldowns[spellId]

            if not preCooldown and postCooldown.remaining and postCooldown.remaining > 0 then
                -- Cooldown was triggered
                cooldownChanges.triggered[spellId] = {
                    duration = postCooldown.duration or 0,
                    remaining = postCooldown.remaining
                }
            elseif preCooldown and postCooldown.remaining and preCooldown.remaining > postCooldown.remaining then
                -- Cooldown was reset (remaining time decreased)
                cooldownChanges.reset[spellId] = {
                    oldRemaining = preCooldown.remaining,
                    newRemaining = postCooldown.remaining
                }
            end
        end

        return cooldownChanges
    end
end

do -- Utility Functions
    --- Debug print analysis results
    --- @param analysis table Analysis results to print
    --- @param spellId number Optional spell ID for context
    function SpellAnalyzer:PrintAnalysis(analysis, spellId)
        if not NAG:IsDevModeEnabled() then
            return
        end

        local spellInfo = spellId and WoWAPI.GetSpellInfo(spellId)
        local spellName = spellInfo and spellInfo.name or "Unknown Spell"
        self:Info(format("=== Analysis Results for %s (%s) ===", spellName, tostring(spellId)))

        -- Print resource costs
        if next(analysis.cost.resources) or next(analysis.cost.secondary) then
            self:Info("Resource Costs:")
            for resource, amount in pairs(analysis.cost.resources) do
                self:Info(format("  %s: %.1f", resource, amount))
            end
            for resource, amount in pairs(analysis.cost.secondary) do
                self:Info(format("  %s (secondary): %.1f", resource, amount))
            end
        end

        -- Print resource generation
        if next(analysis.generates.resources) or next(analysis.generates.secondary) then
            self:Info("Resource Generation:")
            for resource, amount in pairs(analysis.generates.resources) do
                self:Info(format("  %s: +%.1f", resource, amount))
            end
            for resource, amount in pairs(analysis.generates.secondary) do
                self:Info(format("  %s (secondary): +%.1f", resource, amount))
            end
        end

        -- Print applied effects
        if next(analysis.applies.buffs) or next(analysis.applies.debuffs) then
            self:Info("Applied Effects:")
            for buffId, data in pairs(analysis.applies.buffs) do
                local spellInfo = WoWAPI.GetSpellInfo(buffId)
                local buffName = spellInfo and spellInfo.name or tostring(buffId)
                self:Info(format("  Buff: %s (stacks: %d)", buffName, data.stacks or data.stacksAdded or 1))
            end
            for debuffId, data in pairs(analysis.applies.debuffs) do
                local spellInfo = WoWAPI.GetSpellInfo(debuffId)
                local debuffName = spellInfo and spellInfo.name or tostring(debuffId)
                self:Info(format("  Debuff: %s (stacks: %d)", debuffName, data.stacks or data.stacksAdded or 1))
            end
        end

        -- Print consumed effects
        if next(analysis.consumes.buffs) or next(analysis.consumes.debuffs) then
            self:Info("Consumed Effects:")
            for buffId, data in pairs(analysis.consumes.buffs) do
                local spellInfo = WoWAPI.GetSpellInfo(buffId)
                local buffName = spellInfo and spellInfo.name or tostring(buffId)
                self:Info(format("  Buff: %s (stacks: %d)", buffName, data.stacks or data.stacksRemoved or 1))
            end
            for debuffId, data in pairs(analysis.consumes.debuffs) do
                local spellInfo = WoWAPI.GetSpellInfo(debuffId)
                local debuffName = spellInfo and spellInfo.name or tostring(debuffId)
                self:Info(format("  Debuff: %s (stacks: %d)", debuffName, data.stacks or data.stacksRemoved or 1))
            end
        end

        -- Print cooldown changes
        if next(analysis.cooldowns.triggered) or next(analysis.cooldowns.reset) then
            self:Info("Cooldown Effects:")
            for spellId, data in pairs(analysis.cooldowns.triggered) do
                local spellInfo = WoWAPI.GetSpellInfo(spellId)
                local cdSpellName = spellInfo and spellInfo.name or tostring(spellId)
                self:Info(format("  Triggered: %s (%.1fs)", cdSpellName, data.duration))
            end
            for spellId, data in pairs(analysis.cooldowns.reset) do
                local spellInfo = WoWAPI.GetSpellInfo(spellId)
                local cdSpellName = spellInfo and spellInfo.name or tostring(spellId)
                self:Info(format("  Reset: %s (saved %.1fs)", cdSpellName, data.resetTime))
            end
        end

        self:Info("=== End Analysis ===")
    end
end

do -- Options UI
    --- Composer for unified SpellLearner category
    --- @param options table The options structure to inject into
    --- @param context table Optional context information
    --- @return table Modified options structure
    function SpellAnalyzer:spelllearner(options, context)
        if not options.args then options.args = {} end
        if not options.args.spellAnalyzer then
            options.args.spellAnalyzer = {
                type = "group",
                name = L["spellAnalyzer"] or "Spell Analyzer",
                order = 1,
                args = {}
            }
        end

        local analyzerArgs = options.args.spellAnalyzer.args
        analyzerArgs.enabled = OptionsFactory:CreateToggle(
            L["enabled"] or "Enabled",
            L["enabledDesc"] or "Enable or disable this module/feature",
            function() return self:GetSetting("char", "enabled") end,
            function(_, value)
                self:SetSetting("char", "enabled", value)
                if value then
                    self:Enable()
                else
                    self:Disable()
                end
            end,
            { order = 1 }
        )
        analyzerArgs.analysisThreshold = OptionsFactory:CreateRange(L["analysisThreshold"] or "Analysis Threshold", L["analysisThresholdDesc"] or "Minimum change required to consider a resource change significant",
            function() return self:GetSetting("char", "analysisThreshold") end,
            function(_, value)
                self:SetSetting("char", "analysisThreshold", value)
            end,
            {
                order = 2,
                min = 0.01,
                max = 10.0,
                step = 0.01
            }
        )

        return options
    end

    --- Gets the options table for module settings
    --- @return table The options table for AceConfig
    function SpellAnalyzer:GetOptions()
        return {
            type = "group",
            name = L["SpellLearner"] or "SpellLearner",
            order = 25,
            childGroups = "tab",
            args = {
                spellAnalyzer = {
                    type = "group",
                    name = L["spellAnalyzer"] or "Spell Analyzer",
                    order = 1,
                    args = {
                        enabled = OptionsFactory:CreateToggle(
                            L["enabled"] or "Enabled",
                            L["enabledDesc"] or "Enable or disable this module/feature",
                            function() return self:GetSetting("char", "enabled") end,
                            function(_, value)
                                self:SetSetting("char", "enabled", value)
                                if value then
                                    self:Enable()
                                else
                                    self:Disable()
                                end
                            end,
                            { order = 1 }
                        ),
                        analysisThreshold = OptionsFactory:CreateRange(L["analysisThreshold"] or "Analysis Threshold", L["analysisThresholdDesc"] or "Minimum change required to consider a resource change significant",
                            function() return self:GetSetting("char", "analysisThreshold") end,
                            function(_, value)
                                self:SetSetting("char", "analysisThreshold", value)
                            end,
                            {
                                order = 2,
                                min = 0.01,
                                max = 10.0,
                                step = 0.01
                            }
                        ),
                    }
                },
            }
        }
    end
end
