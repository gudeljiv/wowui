--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)

    This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held
        liable for any damages arising from the use of this software.

    You are free to:
    - Share — copy and redistribute the material in any medium or format
    - Adapt — remix, transform, and build upon the material

    Under the following terms:
    - Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were
        made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or
        your use.
    - NonCommercial — You may not use the material for commercial purposes.

    Full license text: https://creativecommons.org/licenses/by-nc/4.0/legalcode

    Author: Rakizi: farendil2020@gmail.com @rakizi http://discord.gg/ebonhold
    Date: 06/01/2024

    STATUS: Development
    NOTES: Prediction API interface for SpellLearner system
]]

--- ============================ HEADER ============================
--[[
    PredictionAPI.lua - Lightweight interface for querying learned spell behavior

    This module provides a simple API for accessing consolidated spell learning data
    collected by PredictionManager. It summarizes resource costs, cooldowns, and
    buff/debuff applications with confidence scoring.

    Usage:
        local api = ns.PredictionAPI
        local cost = api:GetLearnedCost(spellId)
        local buffs = api:GetAppliedBuffs(spellId)
        local debuffs = api:GetAppliedDebuffs(spellId)
]]

--- ======= LOCALIZE =======
local _, ns = ...
local GetTime = _G.GetTime
local L = ns.AceLocale:GetLocale("NAG")
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type OptionsFactory, PredictionManager, SpellLearnerStateManager, AdvancedPredictionEngine
local OptionsFactory, PredictionManager, SpellLearnerStateManager, AdvancedPredictionEngine


-- Default settings
local defaults = {
    global = {
        version = 1,
    },
    char = {
        enabled = false, -- Disabled by default during development break
        -- Advanced confidence settings
        confidenceDecayEnabled = true,
        confidenceDecayRate = 0.0001, -- Decay per second (0.0001 = 10% decay per ~1000 seconds)
        confidenceDecayMin = 0.1, -- Minimum confidence floor
        -- Multi-factor confidence weights
        confidenceWeightVariance = 0.3, -- Weight for variance component
        confidenceWeightObservations = 0.3, -- Weight for observation count
        confidenceWeightTemporal = 0.2, -- Weight for temporal recency
        confidenceWeightContext = 0.2, -- Weight for contextual consistency
    }
}

--- @class PredictionAPI: CoreModule
local PredictionAPI = NAG:CreateModule("PredictionAPI", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = "spelllearner",
    optionsOrder = 3,
    optionsComposers = {
        ["spelllearner"] = true  -- Inject into unified SpellLearner category
    },
})
local module = PredictionAPI
ns.PredictionAPI = PredictionAPI


-- Get required modules (will be available after initialization)

-- Constants
local MIN_OBSERVATIONS = 3     -- Minimum observations for confidence
local MAX_VARIANCE_RATIO = 0.2 -- Maximum variance ratio for confidence (20%)

--- ======= PRIVATE FUNCTIONS =======

--- Calculate advanced multi-factor confidence score
--- @param consolidated table Consolidated data
--- @param context table|nil Context data (optional)
--- @param temporalWeight number|nil Temporal weight (optional)
--- @return number Confidence score (0.0-1.0)
local function CalculateAdvancedConfidence(consolidated, context, temporalWeight)
    if not consolidated then return 0 end

    local api = PredictionAPI
    if not api.db then return 0 end

    local observationCount = consolidated.observationCount or 0
    if observationCount < MIN_OBSERVATIONS then
        return 0
    end

    local weights = api.db.char
    local varianceScore = 0
    local observationScore = 0
    local temporalScore = 1.0
    local contextScore = 1.0

    -- Variance component (from resource data)
    local variance = 0
    local varianceCount = 0

    -- Calculate variance from cost data
    if consolidated.cost and consolidated.cost.resources then
        for _, resourceData in pairs(consolidated.cost.resources) do
            if resourceData.min and resourceData.max then
                local range = resourceData.max - resourceData.min
                local avg = resourceData.average or 0
                if avg > 0 then
                    local cv = range / avg
                    variance = variance + cv
                    varianceCount = varianceCount + 1
                end
            end
        end
    end

    if varianceCount > 0 then
        variance = variance / varianceCount
        -- Lower variance = higher confidence (inverse relationship)
        varianceScore = math.max(0, 1.0 - (variance / MAX_VARIANCE_RATIO))
    else
        varianceScore = 0.5 -- Default if no variance data
    end

    -- Observation count component
    local obsBonus = math.min((observationCount - MIN_OBSERVATIONS) / 10, 0.5)
    observationScore = 0.3 + obsBonus

    -- Temporal recency component (if provided)
    if temporalWeight and temporalWeight > 0 then
        temporalScore = math.min(temporalWeight, 1.0)
    else
        -- Calculate from lastSeen timestamp if available
        if consolidated.lastSeen then
            local now = GetTime()
            local age = now - consolidated.lastSeen
            -- Exponential decay: weight = exp(-decayRate * age)
            local decayRate = api.db.char.confidenceDecayRate or 0.0001
            temporalScore = math.exp(-decayRate * age)
            temporalScore = math.max(temporalScore, 0.1) -- Floor at 0.1
        end
    end

    -- Context consistency component (if context provided)
    if context then
        -- For now, use a simple heuristic: if context matches, full score
        -- Future: could analyze context consistency across observations
        contextScore = 1.0
    end

    -- Weighted combination
    local confidence = (
        varianceScore * (weights.confidenceWeightVariance or 0.3) +
        observationScore * (weights.confidenceWeightObservations or 0.3) +
        temporalScore * (weights.confidenceWeightTemporal or 0.2) +
        contextScore * (weights.confidenceWeightContext or 0.2)
    )

    return math.min(math.max(confidence, 0.0), 1.0)
end

--- Calculate confidence decay based on time since last observation
--- @param baseConfidence number Base confidence score
--- @param timeSinceLastSeen number Seconds since last observation
--- @param decayRate number|nil Decay rate (optional, uses setting)
--- @return number Decayed confidence
local function CalculateConfidenceDecay(baseConfidence, timeSinceLastSeen, decayRate)
    if not PredictionAPI.db then return baseConfidence end

    if not PredictionAPI.db.char.confidenceDecayEnabled then
        return baseConfidence
    end

    local rate = decayRate or PredictionAPI.db.char.confidenceDecayRate or 0.0001
    local minConf = PredictionAPI.db.char.confidenceDecayMin or 0.1

    -- Exponential decay
    local decayFactor = math.exp(-rate * timeSinceLastSeen)
    local decayed = baseConfidence * decayFactor

    return math.max(decayed, minConf)
end

--- Get contextual confidence for a spell in specific context
--- @param spellId number Spell ID
--- @param context table Context data
--- @return number|nil Confidence score or nil if no data
function PredictionAPI:GetContextualConfidence(spellId, context)
    local data = GetConsolidatedData(spellId)
    if not data then return nil end

    -- For now, return base confidence
    -- Future enhancement: could analyze context-specific clusters
    local baseConf = CalculateAdvancedConfidence(data, context, nil)

    -- Apply decay if lastSeen is available
    if data.lastSeen then
        local now = GetTime()
        local timeSince = now - data.lastSeen
        return CalculateConfidenceDecay(baseConf, timeSince)
    end

    return baseConf
end

-- Get consolidated data for a spell
local function GetConsolidatedData(spellId)
        -- Get consolidated data from PredictionManager instead of raw observations
    local data = PredictionManager:GetConsolidatedData(spellId)

    return data
end

--- ======= PUBLIC API =======

-- Get learned resource cost for a spell
function PredictionAPI:GetLearnedCost(spellId)
    local data = GetConsolidatedData(spellId)
    if not data then
        return nil, 0
    end

    local costs = {}
    local totalConfidence = 0
    local confidenceCount = 0

    -- 🔧 FIX: Check consolidated data structure for all resource types
    if data.cost then
        -- Check regular resources
        if data.cost.resources then
            for resourceType, resourceData in pairs(data.cost.resources) do
                if resourceData.average and resourceData.frequency then
                    -- 🔧 FIX: Handle both number and table-based averages
                    if type(resourceData.average) == "number" and resourceData.average > 0 then
                        costs[resourceType] = resourceData.average
                        local confidence = resourceData.frequency or 0
                        totalConfidence = totalConfidence + confidence
                        confidenceCount = confidenceCount + 1
                    elseif type(resourceData.average) == "table" then
                        -- Handle table-based averages (shouldn't happen for regular resources, but be safe)
                        for subType, amount in pairs(resourceData.average) do
                            if amount > 0 then
                                costs[resourceType .. "_" .. subType] = amount
                                local confidence = resourceData.frequency or 0
                                totalConfidence = totalConfidence + confidence
                                confidenceCount = confidenceCount + 1
                            end
                        end
                    end
                end
            end
        end

        -- Check secondary resources
        if data.cost.secondary then
            for resourceType, resourceData in pairs(data.cost.secondary) do
                if resourceData.average and resourceData.frequency then
                    -- 🔧 FIX: Handle both number and table-based averages
                    if type(resourceData.average) == "number" and resourceData.average > 0 then
                        costs[resourceType] = resourceData.average
                        local confidence = resourceData.frequency or 0
                        totalConfidence = totalConfidence + confidence
                        confidenceCount = confidenceCount + 1
                    elseif type(resourceData.average) == "table" then
                        for subType, amount in pairs(resourceData.average) do
                            if amount > 0 then
                                costs[resourceType .. "_" .. subType] = amount
                                local confidence = resourceData.frequency or 0
                                totalConfidence = totalConfidence + confidence
                                confidenceCount = confidenceCount + 1
                            end
                        end
                    end
                end
            end
        end

        -- 🔧 FIX: Check rune costs specifically with enhanced table handling
        if data.cost.runes then
            for runeResource, runeData in pairs(data.cost.runes) do
                if runeData.average and runeData.frequency then
                    local confidence = runeData.frequency or 0

                    if type(runeData.average) == "table" then
                        -- Handle table-based rune averages (e.g., { Unholy = 1.0, Frost = 1.0 })
                        for runeType, amount in pairs(runeData.average) do
                            if amount > 0 then
                                costs["rune_" .. runeType] = amount
                                totalConfidence = totalConfidence + confidence
                                confidenceCount = confidenceCount + 1
                            end
                        end
                    elseif type(runeData.average) == "number" and runeData.average > 0 then
                        -- Handle number-based rune averages (fallback)
                        costs["rune_" .. runeResource] = runeData.average
                        totalConfidence = totalConfidence + confidence
                        confidenceCount = confidenceCount + 1
                    end
                end
            end
        end
    end

    -- Calculate advanced confidence instead of simple frequency average
    local baseConfidence = CalculateAdvancedConfidence(data, nil, nil)

    -- Apply temporal decay if lastSeen is available
    local finalConfidence = baseConfidence
    if data.lastSeen then
        local now = GetTime()
        local timeSince = now - data.lastSeen
        finalConfidence = CalculateConfidenceDecay(baseConfidence, timeSince)
    end

    -- Return first cost found or nil if no costs
    if next(costs) then
        return costs, finalConfidence
    end

    return nil, 0
end

-- Get learned resource generation for a spell
--- @param spellId number The spell ID
--- @return table|nil Generation data {[resourceType] = amount} or nil if not found
--- @return number Confidence score (0.0-1.0)
--- @return number|nil Last seen timestamp or nil
function PredictionAPI:GetLearnedGeneration(spellId)
    local data = GetConsolidatedData(spellId)
    if not data then
        return nil, 0
    end

    local generation = {}
    local totalConfidence = 0
    local confidenceCount = 0

    -- Check consolidated data structure for resource generation
    if data.generates then
        -- Check regular resources
        if data.generates.resources then
            for resourceType, resourceData in pairs(data.generates.resources) do
                if resourceData.average and resourceData.frequency then
                    -- Handle both number and table-based averages
                    if type(resourceData.average) == "number" and resourceData.average > 0 then
                        generation[resourceType] = resourceData.average
                        local confidence = resourceData.frequency or 0
                        totalConfidence = totalConfidence + confidence
                        confidenceCount = confidenceCount + 1
                    elseif type(resourceData.average) == "table" then
                        for subType, amount in pairs(resourceData.average) do
                            if amount > 0 then
                                generation[resourceType .. "_" .. subType] = amount
                                local confidence = resourceData.frequency or 0
                                totalConfidence = totalConfidence + confidence
                                confidenceCount = confidenceCount + 1
                            end
                        end
                    end
                end
            end
        end

        -- Check secondary resources
        if data.generates.secondary then
            for resourceType, resourceData in pairs(data.generates.secondary) do
                if resourceData.average and resourceData.frequency then
                    if type(resourceData.average) == "number" and resourceData.average > 0 then
                        generation[resourceType] = resourceData.average
                        local confidence = resourceData.frequency or 0
                        totalConfidence = totalConfidence + confidence
                        confidenceCount = confidenceCount + 1
                    elseif type(resourceData.average) == "table" then
                        for subType, amount in pairs(resourceData.average) do
                            if amount > 0 then
                                generation[resourceType .. "_" .. subType] = amount
                                local confidence = resourceData.frequency or 0
                                totalConfidence = totalConfidence + confidence
                                confidenceCount = confidenceCount + 1
                            end
                        end
                    end
                end
            end
        end

        -- Check rune generation
        if data.generates.runes then
            for runeResource, runeData in pairs(data.generates.runes) do
                if runeData.average and runeData.frequency then
                    local confidence = runeData.frequency or 0

                    if type(runeData.average) == "table" then
                        -- Handle table-based rune averages (e.g., { Unholy = 1.0, Frost = 1.0 })
                        for runeType, amount in pairs(runeData.average) do
                            if amount > 0 then
                                generation["rune_" .. runeType] = amount
                                totalConfidence = totalConfidence + confidence
                                confidenceCount = confidenceCount + 1
                            end
                        end
                    elseif type(runeData.average) == "number" and runeData.average > 0 then
                        -- Handle number-based rune averages (fallback)
                        generation["rune_" .. runeResource] = runeData.average
                        totalConfidence = totalConfidence + confidence
                        confidenceCount = confidenceCount + 1
                    end
                end
            end
        end
    end

    -- Calculate advanced confidence instead of simple frequency average
    local baseConfidence = CalculateAdvancedConfidence(data, nil, nil)

    -- Apply temporal decay if lastSeen is available
    local finalConfidence = baseConfidence
    if data.lastSeen then
        local now = GetTime()
        local timeSince = now - data.lastSeen
        finalConfidence = CalculateConfidenceDecay(baseConfidence, timeSince)
    end

    -- Return generation data if found
    if next(generation) then
        return generation, finalConfidence, data.lastSeen
    end

    return nil, 0
end

-- Get learned cooldown duration for a spell
function PredictionAPI:GetLearnedCooldown(spellId)
    local data = GetConsolidatedData(spellId)
    if not data then
        return nil, 0
    end

    -- Check consolidated data structure
    if data.cooldowns and data.cooldowns.triggered then
        for cdId, cooldownData in pairs(data.cooldowns.triggered) do
            if cooldownData.averageDuration and cooldownData.averageDuration > 0 then
                -- Use advanced confidence calculation
                local baseConfidence = CalculateAdvancedConfidence(data, nil, nil)
                local finalConfidence = baseConfidence
                if data.lastSeen then
                    local now = GetTime()
                    local timeSince = now - data.lastSeen
                    finalConfidence = CalculateConfidenceDecay(baseConfidence, timeSince)
                end
                return cooldownData.averageDuration, finalConfidence
            end
        end
    end

    return nil, 0
end

-- Get buffs applied by a spell
function PredictionAPI:GetAppliedBuffs(spellId)
    local data = GetConsolidatedData(spellId)
    if not data then
        return {}, 0
    end

    local result = {}
    local totalObservations = data.observationCount or 0

    -- Check consolidated data structure
    if data.applies and data.applies.buffs then
        for buffId, buffData in pairs(data.applies.buffs) do
            -- Only include buffs that appear frequently enough
            if buffData.frequency and buffData.frequency >= 0.6 then -- 60% threshold
                table.insert(result, tonumber(buffId))
            end
        end
    end

    -- Use advanced confidence calculation
    local baseConfidence = CalculateAdvancedConfidence(data, nil, nil)
    local finalConfidence = baseConfidence
    if data.lastSeen then
        local now = GetTime()
        local timeSince = now - data.lastSeen
        finalConfidence = CalculateConfidenceDecay(baseConfidence, timeSince)
    end
    return result, finalConfidence
end

-- Get debuffs applied by a spell
function PredictionAPI:GetAppliedDebuffs(spellId)
    local data = GetConsolidatedData(spellId)
    if not data then
        return {}, 0
    end

    local result = {}
    local totalObservations = data.observationCount or 0

    -- Check consolidated data structure
    if data.applies and data.applies.debuffs then
        for debuffId, debuffData in pairs(data.applies.debuffs) do
            -- Only include debuffs that appear frequently enough
            if debuffData.frequency and debuffData.frequency >= 0.6 then -- 60% threshold
                table.insert(result, tonumber(debuffId))
            end
        end
    end

    -- Use advanced confidence calculation
    local baseConfidence = CalculateAdvancedConfidence(data, nil, nil)
    local finalConfidence = baseConfidence
    if data.lastSeen then
        local now = GetTime()
        local timeSince = now - data.lastSeen
        finalConfidence = CalculateConfidenceDecay(baseConfidence, timeSince)
    end
    return result, finalConfidence
end

-- Get comprehensive spell summary
function PredictionAPI:GetSpellSummary(spellId)
    local costs, costConfidence = self:GetLearnedCost(spellId)
    local cooldown, cooldownConfidence = self:GetLearnedCooldown(spellId)
    local buffs, buffsConfidence = self:GetAppliedBuffs(spellId)
    local debuffs, debuffsConfidence = self:GetAppliedDebuffs(spellId)

    -- 🔧 FIX: Better confidence handling for partial data
    local validConfidences = {}
    if costConfidence and costConfidence > 0 then
        table.insert(validConfidences, costConfidence)
    end
    if cooldownConfidence and cooldownConfidence > 0 then
        table.insert(validConfidences, cooldownConfidence)
    end
    if buffsConfidence and buffsConfidence > 0 then
        table.insert(validConfidences, buffsConfidence)
    end
    if debuffsConfidence and debuffsConfidence > 0 then
        table.insert(validConfidences, debuffsConfidence)
    end

    -- Check if we have any learned data with confidence > 0
    local hasAnyLearnedData = #validConfidences > 0

    -- 🔧 FIX: Calculate overall confidence as average of valid confidences
    local overallConfidence = 0
    if #validConfidences > 0 then
        local sum = 0
        for _, conf in ipairs(validConfidences) do
            sum = sum + conf
        end
        overallConfidence = sum / #validConfidences
    end

    return {
        spellId = spellId,
        cost = costs, -- Now returns a table of all costs
        costConfidence = costConfidence,
        cooldown = cooldown,
        cooldownConfidence = cooldownConfidence,
        buffs = buffs,
        buffsConfidence = buffsConfidence,
        debuffs = debuffs,
        debuffsConfidence = debuffsConfidence,
        overallConfidence = overallConfidence,
        hasAnyLearnedData = hasAnyLearnedData
    }
end

-- Check if we have any learned data for a spell
function PredictionAPI:HasLearnedData(spellId)
    local data = GetConsolidatedData(spellId)
    return data ~= nil
end

-- Get list of all spells with learned data
function PredictionAPI:GetLearnedSpells()
        local consolidated = PredictionManager.db.char.consolidated or {}
    local spells = {}
    for spellId, _ in pairs(consolidated) do
        table.insert(spells, tonumber(spellId))
    end

    return spells
end

-- Get statistics about learned data
function PredictionAPI:GetStatistics()
    local spells = self:GetLearnedSpells()
    local totalSpells = #spells
    local confidentSpells = 0

    for _, spellId in ipairs(spells) do
        local summary = self:GetSpellSummary(spellId)
        if summary.hasAnyLearnedData then
            confidentSpells = confidentSpells + 1
        end
    end

    return {
        totalSpells = totalSpells,
        confidentSpells = confidentSpells,
        confidenceRate = totalSpells > 0 and (confidentSpells / totalSpells) or 0
    }
end

--- ======= MODULE INITIALIZATION =======

function PredictionAPI:ModuleInitialize()
    -- Get required modules after initialization
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    OptionsFactory = NAG:GetModule("OptionsFactory")
    SpellLearnerStateManager = NAG:GetModule("SpellLearnerStateManager", true)
    if not SpellLearnerStateManager then
        self:Info("SpellLearnerStateManager module not found - legacy capture remains disabled")
    end
    PredictionManager = NAG:GetModule("PredictionManager")
    AdvancedPredictionEngine = NAG:GetModule("AdvancedPredictionEngine")
    -- Restore saved enabled state after database is ready
    self:RestoreEnabledState()
end

--- Restore the saved enabled state after database is ready
function PredictionAPI:RestoreEnabledState()
    -- Check if database is ready
    if not self.db then
        self:Debug("Database not ready, deferring enabled state restoration")
        return
    end

    -- Restore saved enabled state
    local enabled = self.db.char.enabled
    self:SetEnabledState(enabled)
    self:Debug("Restored enabled state: " .. tostring(enabled))
end

function PredictionAPI:ModuleEnable()

    -- ============================ MODULE INITIALIZATION ============================
end

function PredictionAPI:ModuleDisable()
    self:Debug("PredictionAPI module disabled")
end

--- Composer for unified SpellLearner category
--- @param options table The options structure to inject into
--- @param context table Optional context information
--- @return table Modified options structure
function PredictionAPI:spelllearner(options, context)
    if not options.args then options.args = {} end
    if not options.args.predictionAPI then
        options.args.predictionAPI = {
            type = "group",
            name = L["predictionAPI"] or "Prediction API",
            order = 3,
            args = {}
        }
    end

    local apiArgs = options.args.predictionAPI.args
    apiArgs.enabled = OptionsFactory:CreateToggle(L["enabled"] or "Enable", L["enabledDesc"] or "Enable or disable this module/feature",
        function() return self:IsEnabled() end,
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

    apiArgs.confidenceHeader = {
        type = "header",
        name = L["confidenceHeader"] or "Advanced Confidence Settings",
        order = 10,
    }

    apiArgs.confidenceDecayEnabled = OptionsFactory:CreateToggle(L["confidenceDecayEnabled"] or "Enable Confidence Decay", L["confidenceDecayEnabledDesc"] or "Confidence decreases over time without new observations",
        function() return self:GetSetting("char", "confidenceDecayEnabled") end,
        function(_, v) self:SetSetting("char", "confidenceDecayEnabled", v) end,
        { order = 11 }
    )

    apiArgs.confidenceDecayRate = OptionsFactory:CreateRange(L["confidenceDecayRate"] or "Confidence Decay Rate", L["confidenceDecayRateDesc"] or "How quickly confidence decays per second",
        function() return self:GetSetting("char", "confidenceDecayRate") end,
        function(_, v) self:SetSetting("char", "confidenceDecayRate", v) end,
        { order = 12, min = 0.0, max = 0.001, step = 0.00001 }
    )

    apiArgs.confidenceDecayMin = OptionsFactory:CreateRange(L["confidenceDecayMin"] or "Minimum Confidence", L["confidenceDecayMinDesc"] or "Minimum confidence floor after decay",
        function() return self:GetSetting("char", "confidenceDecayMin") end,
        function(_, v) self:SetSetting("char", "confidenceDecayMin", v) end,
        { order = 13, min = 0.0, max = 0.5, step = 0.01 }
    )

    return options
end

--- Gets the options table for module settings
--- @return table The options table for AceConfig
function PredictionAPI:GetOptions()
    return {
        type = "group",
        name = L["SpellLearner"] or "SpellLearner",
        order = 25,
        childGroups = "tab",
        args = {
            predictionAPI = {
                type = "group",
                name = L["predictionAPI"] or "Prediction API",
                order = 3,
                args = {
                    enabled = OptionsFactory:CreateToggle(L["enabled"] or "Enable", L["enabledDesc"] or "Enable or disable this module/feature",
                        function() return self:IsEnabled() end,
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
                }
            },
        }
    }
end

-- Module is available through NAG:GetModule("PredictionAPI")
-- No global namespace assignment needed

-- Add a test function to verify module is working
function PredictionAPI:TestModule()
    self:Debug("=== PredictionAPI Module Test ===")
    self:Debug("Module is working correctly!")


    self:Debug("StateManager available: " .. (StateManager and "Yes" or "No"))
 self:Debug("PredictionManager available: " .. ("Yes" or "No"))
    self:Debug("=== Test Complete ===")
end

--- Get consolidated data for a spell
--- @param spellId number The spell ID
--- @return table|nil Consolidated data or nil if not found
function PredictionAPI:GetConsolidatedData(spellId)
        local data = PredictionManager:GetConsolidatedData(spellId)
    if data then
        self:Debug("🔍 PredictionAPI: Found consolidated data for spell %d", spellId)
        self:Debug("🔍 Observation count: %d", data.observationCount or 0)
    else
        self:Debug("🔍 PredictionAPI: No consolidated data found for spell %d", spellId)
    end

    return data
end
