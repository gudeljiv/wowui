--- @module "NAG.DruidSneakWeaveModule"
--- Logic-only module that auto-summons Albino Snake on Bear→Cat when beneficial
--- License: CC BY-NC 4.0

-- ============================ LOCALIZE ============================
local _, ns = ...
local GetTime = _G.GetTime
local UnitGUID = _G.UnitGUID
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitAttackSpeed = _G.UnitAttackSpeed
local IsInRaid = _G.IsInRaid
local GetNumCompanions = _G.GetNumCompanions
local GetCompanionInfo = _G.GetCompanionInfo
local L = ns.AceLocale:GetLocale("NAG")
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in ModuleInitialize to avoid expensive metatable access

--- @type StateManager
local StateManager

--- @type OptionsFactory
--- @type TimerManager
local OptionsFactory, TimerManager

--- @type SpecCompat
local SpecCompat


local WoWAPI = ns.WoWAPI

-- WoW API
local CallCompanion = _G.CallCompanion

-- Lua utils
local max = math.max
local min = math.min
local format = string.format

local function clamp(value, lower, upper)
    if value < lower then return lower end
    if value > upper then return upper end
    return value
end

-- ============================ CONSTANTS ============================
local CAT_FORM_SPELLID = 768
local BEAR_FORM_SPELLID = 5487
local DIRE_BEAR_FORM_SPELLID = 9634

local DEFAULT_CAT_PERIOD = 1.00
local CAT_SAMPLE_INTERVAL = 0.30
local CAT_PERIOD_STALE_SEC = 3.0
local MISSING_SPELL_WARN_COOLDOWN = 1800.0 -- 30 minutes
local SNAKE_SPELL_ID = 10713               -- Albino Snake companion spell ID (for name resolution)
local NO_RESET_WARN_COOLDOWN = 1800.0      -- 30 minutes

-- ============================ DEFAULTS ============================
local defaults = {
    class = {
        enabled = true,
        autoSummon = true,
        lockout = 0.70,     -- seconds
        extraMargin = 0.00, -- seconds
        onlyInRaids = false,
        snakeSpellName = "Albino Snake",
        debug = false,
    }
}

-- ============================ MODULE ============================
--- @class DruidSneakWeaveModule:CoreModule
local DruidSneakWeaveModule = NAG:CreateModule("DruidSneakWeaveModule", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "DRUID",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    debugCategories = { ns.DEBUG_CATEGORIES.CLASS, ns.DEBUG_CATEGORIES.FEATURES },
    eventHandlers = {
        PLAYER_ENTERING_WORLD = true,
        UPDATE_SHAPESHIFT_FORM = true,
        PLAYER_REGEN_ENABLED = true,
        COMPANION_UPDATE = true,
    },
    cleuHandlers = {
        SWING_DAMAGE = "HandleCLEU",
        SWING_MISSED = "HandleCLEU",
    },
    messageHandlers = {
        NAG_SPEC_UPDATED = true,
    },
    defaultState = {
        lastForm = "OTHER",
        lastCatPeriod = DEFAULT_CAT_PERIOD,
        lastCatPeriodTS = 0,
        lastSummon = 0,
        missingWarnTS = 0,
        lastBearTS = 0,
        lastBearRemaining = 0,
        lastBearRemainingTS = 0,
        lastSummonAttemptTS = 0,
        lastSummonCompanion = nil,
        lastNoResetWarnTS = 0,
        verifyPending = false,
        verifySummonTS = 0,
        verifyPreRemaining = 0,
        verifyCatPeriod = 0,
        snakeIndex = nil,
    }
})
-- Expose in namespace
ns.DruidSneakWeaveModule = DruidSneakWeaveModule
local module = DruidSneakWeaveModule

-- ============================ INTERNAL HELPERS ============================
function DruidSneakWeaveModule:IsInCatForm()
    return not not NAG:UnitBuff("player", CAT_FORM_SPELLID)
end

function DruidSneakWeaveModule:IsInBearForm()
    -- Check both Bear Form and Dire Bear Form (uses optimized fast path for multiple IDs)
    return not not NAG:UnitBuffMulti("player", BEAR_FORM_SPELLID, DIRE_BEAR_FORM_SPELLID)
end

function DruidSneakWeaveModule:GetCurrentFormTag()
    if self:IsInCatForm() then return "CAT" end
    if self:IsInBearForm() then return "BEAR" end
    return "OTHER"
end

function DruidSneakWeaveModule:RefreshCatPeriod()
    if not UnitAffectingCombat("player") then return end
    if not self:IsInCatForm() then return end

    local mh = UnitAttackSpeed("player")
    if mh and mh > 0 then
        local old = self.defaultState.lastCatPeriod or 0
        self.defaultState.lastCatPeriod = mh
        self.defaultState.lastCatPeriodTS = GetTime()
        --if self.db.class.debug and math.abs((old or 0) - mh) > 0.01 then
        -- print(format("[SneakWeave] Cat period updated: old=%.3f new=%.3f", old, mh))
        --end
    end
end

function DruidSneakWeaveModule:RefreshBearRemaining()
    if not UnitAffectingCombat("player") then return end
    if not self:IsInBearForm() then return end

    local _, rawLeft = NAG:AutoTimeToNext()
    if rawLeft and rawLeft > 0 then
        self.defaultState.lastBearRemaining = rawLeft
        self.defaultState.lastBearRemainingTS = GetTime()
        --if self.db.class.debug then
        -- print(string.format("[SneakWeave] Bear swing remaining sampled: %.3f", rawLeft))
        --end
    end
end

function DruidSneakWeaveModule:GetCatPeriod()
    local now = GetTime()
    if (now - (self.defaultState.lastCatPeriodTS or 0)) > CAT_PERIOD_STALE_SEC
        or (not self.defaultState.lastCatPeriod) or self.defaultState.lastCatPeriod <= 0 then
        local mh = UnitAttackSpeed("player")
        self.defaultState.lastCatPeriod = (mh and mh > 0) and mh or DEFAULT_CAT_PERIOD
        self.defaultState.lastCatPeriodTS = now
    end
    return self.defaultState.lastCatPeriod or DEFAULT_CAT_PERIOD
end

function DruidSneakWeaveModule:LatencyBuffer()
    local inputDelay = (NAG.InputDelay and NAG:InputDelay()) or 0
    local ping = (NAG.GetNetStats and NAG:GetNetStats()) or 0
    -- Add 0.05s safety, clamp to [0.10, 0.25]
    local buffer = inputDelay + ping + 0.05
    return clamp(buffer, 0.10, 0.25)
end

function DruidSneakWeaveModule:SummonSnake()
    local now = GetTime()
    self.defaultState.lastSummon = now
    local configured = self.db.class.snakeSpellName or "Albino Snake" -- TODO: Localize this

    local snakeInfo = WoWAPI.GetSpellInfo(configured)
    local snakeName = snakeInfo and snakeInfo.name or nil
    local snakeInfoById = WoWAPI.GetSpellInfo(SNAKE_SPELL_ID)
    local snakeNameById = snakeInfoById and snakeInfoById.name or nil

    if not snakeName and not snakeNameById then
        -- Throttled warning
        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if specIndex == 2 and (now - (self.defaultState.missingWarnTS or 0)) >= MISSING_SPELL_WARN_COOLDOWN then
            self.defaultState.missingWarnTS = now
            print(
                "|cffF772E6[Fonsas]|r I can't find your Albino Snake. Please learn/buy it and set the correct name in options if needed. You can find the vendor in Dalaran. I can optimize your bearweaving if you have it learned. You will need one per toon.")
        end
        return
    end

    -- if self.db.class.debug then
    --     print(format("[SneakWeave] Attempting summon: configured=\"%s\" resolvedName=\"%s\" idName=\"%s\"",
    --         tostring(configured), tostring(snakeName), tostring(snakeNameById)))
    -- end

    -- Prefer cached index if available
    local foundIndex = self.defaultState.snakeIndex
    if GetNumCompanions and GetCompanionInfo and CallCompanion then
        local count = GetNumCompanions("CRITTER") or 0
        if not foundIndex or foundIndex < 1 or foundIndex > count then
            for i = 1, count do
                local _, name, _, _, active = GetCompanionInfo("CRITTER", i)
                if (snakeName and name == snakeName) or (snakeNameById and name == snakeNameById) then
                    foundIndex = i
                    self.defaultState.snakeIndex = i
                    -- if self.db.class.debug then
                    --     print(format("[SneakWeave] Found snake in companions at index %d (active=%s)", i, tostring(active)))
                    -- end
                    break
                end
            end
        end
        if foundIndex then
            self.defaultState.lastSummonAttemptTS = now
            self.defaultState.lastSummonCompanion = snakeName or snakeNameById
            CallCompanion("CRITTER", foundIndex)
        end
    end

    if not foundIndex then
        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if specIndex == 2 and (now - (self.defaultState.missingWarnTS or 0)) >= MISSING_SPELL_WARN_COOLDOWN then
            self.defaultState.missingWarnTS = now
            -- print("|cffF772E6[Fonsas]|r I couldn't summon Albino Snake from your companions. Make sure it's learned on this character.")
        end
    end
end

-- Fires after companion changes; verify summon success if recent
function DruidSneakWeaveModule:COMPANION_UPDATE(event, creatureType)
    if creatureType ~= "CRITTER" then return end
    if not self.db.class.debug then return end
    local now = GetTime()
    if (now - (self.defaultState.lastSummonAttemptTS or 0)) > 1.0 then return end

    local configured = self.db.class.snakeSpellName or "Albino Snake"
    local spellInfo1 = WoWAPI.GetSpellInfo(configured)
    local spellInfo2 = WoWAPI.GetSpellInfo(SNAKE_SPELL_ID)
    local snakeName = (spellInfo1 and spellInfo1.name) or (spellInfo2 and spellInfo2.name)
    local snakeActive = false
    if snakeName and GetNumCompanions and GetCompanionInfo then
        local count = GetNumCompanions("CRITTER") or 0
        for i = 1, count do
            local _, name, _, _, active = GetCompanionInfo("CRITTER", i)
            if name == snakeName then
                snakeActive = not not active
                break
            end
        end
    end
end

-- Verify on SWING events; this tells us the new cycle actually ticked
function DruidSneakWeaveModule:HandleCLEU(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, arg12, arg13, arg14, arg15, arg16, arg17, arg18,
    arg19, arg20, arg21, arg22, arg23, arg24)
    if not self.defaultState.verifyPending then return end
    if sourceGUID ~= NAG.state.player.guid then return end
    if subEvent ~= "SWING_DAMAGE" and subEvent ~= "SWING_MISSED" then return end

    local now = GetTime()
    local delta = now - (self.defaultState.verifySummonTS or now)
    -- At the swing, expected times since summon:
    local expectedReset = max(0, (self.defaultState.verifyCatPeriod or 0) - delta)
    local expectedNoReset = max(0, (self.defaultState.verifyPreRemaining or 0) - delta)

    -- After a swing event, the remaining should be close to full period again.
    local _, postRawLeft = NAG:AutoTimeToNext()
    local isReset = false
    local isNoReset = false
    if postRawLeft then
        -- If reset, we expect full cat period (within epsilon)
        if math.abs(postRawLeft - (self.defaultState.verifyCatPeriod or 0)) <= 0.25 then
            isReset = true
            -- If not reset, we'd see bear residual behavior; classify if closer to previous-behavior window
        elseif math.abs(postRawLeft - expectedNoReset) <= 0.35 then
            isNoReset = true
        end
    end

    -- print(string.format("[SneakWeave] SWING verify: Δ=%.3f post=%.3f cat=%.3f pre=%.3f expectReset=%.3f expectNoReset=%.3f isReset=%s isNoReset=%s",
    --     delta, postRawLeft or -1, self.defaultState.verifyCatPeriod or -1, self.defaultState.verifyPreRemaining or -1,
    --     expectedReset, expectedNoReset, tostring(isReset), tostring(isNoReset)))

    if isNoReset and (now - (self.defaultState.lastNoResetWarnTS or 0)) >= NO_RESET_WARN_COOLDOWN then
        self.defaultState.lastNoResetWarnTS = now
        -- print("|cffF772E6[Fonsas]|r Snake was summoned but swing timer did not reset. Try re-summoning or ensure Albino Snake is properly learned.")
    end

    -- Clear verification flag after first player swing observed post-summon
    self.defaultState.verifyPending = false
end

function DruidSneakWeaveModule:SchedulePostSummonCheck(preRawLeft, catPeriod)
    if not self.db.class.debug then return end
    local now = GetTime()
    local timerName = "DruidSneakWeavePostCheck_" .. tostring(math.floor(now * 1000))
    local function oneShotCheck(label)
        local checkAt = GetTime()
        local _, postRawLeft = NAG:AutoTimeToNext()
        local delta = checkAt - (self.defaultState.lastSummonAttemptTS or checkAt)
        local expectedNoReset = max(0, (preRawLeft or 0) - delta)
        local expectedReset = max(0, (catPeriod or 0) - delta)
        local resetEps = 0.25
        local noResetEps = 0.25

        local isReset = false
        local isNoReset = false
        if postRawLeft then
            if math.abs(postRawLeft - expectedReset) <= resetEps then
                isReset = true
            elseif math.abs(postRawLeft - expectedNoReset) <= noResetEps then
                isNoReset = true
            end
        end

        -- Companion active status check
        local configured = self.db.class.snakeSpellName or "Albino Snake"
        local spellInfo1 = WoWAPI.GetSpellInfo(configured)
    local spellInfo2 = WoWAPI.GetSpellInfo(SNAKE_SPELL_ID)
    local snakeName = (spellInfo1 and spellInfo1.name) or (spellInfo2 and spellInfo2.name)
        local snakeActive = false
        if snakeName and GetNumCompanions and GetCompanionInfo then
            local count = GetNumCompanions("CRITTER") or 0
            for i = 1, count do
                local _, name, _, _, active = GetCompanionInfo("CRITTER", i)
                if name == snakeName then
                    snakeActive = not not active
                    break
                end
            end
        end

        --print(string.format("[SneakWeave] Post-summon %s: pre=%.3f post=%.3f cat=%.3f Δ=%.3f expectReset=%.3f expectNoReset=%.3f isReset=%s isNoReset=%s snakeActive=%s",
        --   label, preRawLeft or -1, postRawLeft or -1, catPeriod or -1, delta or 0, expectedReset, expectedNoReset, tostring(isReset), tostring(isNoReset), tostring(snakeActive)))

        if isNoReset and (GetTime() - (self.defaultState.lastNoResetWarnTS or 0)) >= NO_RESET_WARN_COOLDOWN then
            local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
            if specIndex == 2 then
                self.defaultState.lastNoResetWarnTS = GetTime()
                --print("|cffF772E6 [Fonsas] whispers: I summoned your Albino Snake, but your swing didn’t reset. Make sure the pet is learned and try re-summoning between Bear→Cat weaves.|r")
            end
        end
    end

    -- Check soon after, and slightly later to confirm
    TimerManager:Create(TimerManager.Categories.COMBAT, timerName .. "_A", function() oneShotCheck("checkA") end, 0.12,
        false)
    TimerManager:Create(TimerManager.Categories.COMBAT, timerName .. "_B", function() oneShotCheck("checkB") end, 0.40,
        false)
end

function DruidSneakWeaveModule:MaybeSummonOnBearToCat()
    -- Gates
    if not self.db.class.enabled then
        -- if self.db.class.debug then print("[SneakWeave] Skip: module disabled") end
        return
    end
    if not self.db.class.autoSummon then
        --if self.db.class.debug then print("[SneakWeave] Skip: autoSummon disabled") end
        return
    end
    if not UnitAffectingCombat("player") then
        --if self.db.class.debug then print("[SneakWeave] Skip: not in combat") end
        return
    end
    if self.db.class.onlyInRaids and not IsInRaid() then
        --if self.db.class.debug then print("[SneakWeave] Skip: onlyInRaids enabled and not in raid") end
        return
    end

    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if specIndex ~= 2 then
        --if self.db.class.debug then print(format("[SneakWeave] Skip: specIndex=%s (need 2 for Feral)", tostring(specIndex))) end
        return
    end -- Feral (Cat) only - specIndex 2

    local now = GetTime()
    local lockout = self.db.class.lockout or 0.70
    local since = now - (self.defaultState.lastSummon or 0)
    if since < lockout then
        -- if self.db.class.debug then print(format("[SneakWeave] Skip: lockout active (%.2fs < %.2fs)", since, lockout)) end
        return
    end

    -- Remaining swing time, same accessor used elsewhere
    local _, rawSwingTimeLeft = NAG:AutoTimeToNext()
    if not rawSwingTimeLeft or rawSwingTimeLeft <= 0 then
        -- if self.db.class.debug then print("[SneakWeave] Skip: swing time unavailable") end
        return
    end
    -- if self.db.class.debug then
    --print(format("[SneakWeave] Swing read: rawRemaining=%.3f", rawSwingTimeLeft))
    --end

    local catPeriod = self:GetCatPeriod() or DEFAULT_CAT_PERIOD
    local latencyBuffer = self:LatencyBuffer()
    local extraMargin = self.db.class.extraMargin or 0
    local threshold = (catPeriod or DEFAULT_CAT_PERIOD) + latencyBuffer + extraMargin

    -- if self.db.class.debug then
    --    print(format("[SneakWeave] bearRemaining=%.3f, catPeriod=%.3f, latency=%.3f, margin=%.3f, threshold=%.3f",
    --        rawSwingTimeLeft, catPeriod, latencyBuffer, extraMargin, threshold))
    --end

    if rawSwingTimeLeft > threshold then
        --if self.db.class.debug then print("[SneakWeave] Decision: SUMMON") end
        -- Arm swing verification around next MH swing
        self.defaultState.verifyPending = true
        self.defaultState.verifySummonTS = GetTime()
        self.defaultState.verifyPreRemaining = rawSwingTimeLeft
        self.defaultState.verifyCatPeriod = catPeriod
        -- Failsafe: clear verification if no swing observed soon
        TimerManager:Create(TimerManager.Categories.COMBAT, "DruidSneakWeaveVerifyTimeout", function()
            if self.defaultState.verifyPending then
                --if self.db.class.debug then
                --print("[SneakWeave] Verify timeout without swing; clearing pending state")
                --end
                self.defaultState.verifyPending = false
            end
        end, 2.0, false)
        self:SummonSnake()
        --else
        --if self.db.class.debug then print("[SneakWeave] Decision: DO NOT SUMMON") end
    end
end

-- ============================ LIFECYCLE ============================
function DruidSneakWeaveModule:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    StateManager = NAG:GetModule("StateManager")
    OptionsFactory = NAG:GetModule("OptionsFactory")
    TimerManager = NAG:GetModule("TimerManager")
    SpecCompat = NAG:GetModule("SpecCompat")

    -- Ensure class matches
    local playerClass = NAG.CLASS_FILENAME
    if playerClass ~= "DRUID" then
        self:SetEnabledState(false)
        return
    end
end

function DruidSneakWeaveModule:ModuleEnable()
    -- Start sampler timer

    -- ============================ MODULE INITIALIZATION ============================
    TimerManager:Create(TimerManager.Categories.COMBAT, "DruidSneakWeaveSampler", function()
        self:RefreshCatPeriod()
        self:RefreshBearRemaining()
    end, CAT_SAMPLE_INTERVAL, true)

    -- Initialize form state
    self.defaultState.lastForm = self:GetCurrentFormTag()
    -- if self.db.class.debug then
    --print("[SneakWeave] Enabled; initial form=" .. self.defaultState.lastForm)
    -- end
end

function DruidSneakWeaveModule:ModuleDisable()
    TimerManager:Cancel(TimerManager.Categories.COMBAT, "DruidSneakWeaveSampler")
    -- if self.db.class.debug then
    --    print("[SneakWeave] Disabled")
    -- end
end

-- ============================ EVENTS ============================
function DruidSneakWeaveModule:PLAYER_ENTERING_WORLD(event)
    self.defaultState.lastForm = self:GetCurrentFormTag()
    --    if self.db.class.debug then
    --        print("[SneakWeave] PLAYER_ENTERING_WORLD; form=" .. self.defaultState.lastForm)
    --    end
end

function DruidSneakWeaveModule:PLAYER_REGEN_ENABLED(event)
    self.defaultState.lastSummon = 0
end

function DruidSneakWeaveModule:UPDATE_SHAPESHIFT_FORM(event)
    local previous = self.defaultState.lastForm or "OTHER"
    local current = self:GetCurrentFormTag()
    self.defaultState.lastForm = current

    -- if self.db.class.debug then
    --    print(format("[SneakWeave] UPDATE_SHAPESHIFT_FORM: %s -> %s", previous, current))
    -- end

    if current == "CAT" then
        -- Refresh cat period immediately when entering Cat
        self:RefreshCatPeriod()
        local now = GetTime()
        local sinceBear = now - (self.defaultState.lastBearTS or 0)
        local cameFromBear = (previous == "BEAR") or (sinceBear <= 1.0)
        --if self.db.class.debug then
        --print(string.format("[SneakWeave] Entered CAT: cameFromBear=%s prev=%s sinceBear=%.2fs",
        -- tostring(cameFromBear), tostring(previous), sinceBear))
        --end
        if cameFromBear then
            self:MaybeSummonOnBearToCat()
        end
    elseif current == "BEAR" then
        self.defaultState.lastBearTS = GetTime()
        -- Auto-remove critter pet when entering Bear
        if DismissCompanion then
            DismissCompanion("CRITTER")
        end
    end
end

function DruidSneakWeaveModule:NAG_SPEC_UPDATED(message)
    -- Activate/deactivate sampler depending on spec to reduce overhead
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    local timerName = "DruidSneakWeaveSampler"
    if specIndex == 2 then
        if not TimerManager:IsTimerActive(TimerManager.Categories.COMBAT, timerName) then
            TimerManager:Create(TimerManager.Categories.COMBAT, timerName, function()
                self:RefreshCatPeriod()
                self:RefreshBearRemaining()
            end, CAT_SAMPLE_INTERVAL, true)
            --if self.db.class.debug then
            --print("[SneakWeave] Sampler enabled for Feral spec")
            --end
        end
    else
        if TimerManager:IsTimerActive(TimerManager.Categories.COMBAT, timerName) then
            TimerManager:Cancel(TimerManager.Categories.COMBAT, timerName)
            --if self.db.class.debug then
            --    print("[SneakWeave] Sampler disabled (non-Feral spec)")
            --end
        end
    end
end

-- ============================ OPTIONS ============================
function DruidSneakWeaveModule:GetOptions()
    return {
        type = "group",
        name = L["Sneak Weave (Druid)"] or "Sneak Weave (Druid)",
        order = 26,
        args = {
            main = {
                type = "group",
                name = L["main"] or "Sneak Weave",
                inline = true,
                order = 1,
                args = {
                    enabled = OptionsFactory:CreateToggle(L["enabled"] or "Enable", L["enabledDesc"] or "Enable or disable this module/feature",
                        function() return self:GetSetting("class", "enabled") end,
                        function(_, v) self:SetSetting("class", "enabled", v) end,
                        { order = 1 }
                    ),
                    autoSummon = OptionsFactory:CreateToggle(L["autoSummon"] or "Auto-summon Snake", L["autoSummonDesc"] or "Automatically summon Albino Snake when beneficial",
                        function() return self:GetSetting("class", "autoSummon") end,
                        function(_, v) self:SetSetting("class", "autoSummon", v) end,
                        { order = 2 }
                    ),
                    lockout = OptionsFactory:CreateRange(L["lockout"] or "Lockout (s)", L["lockoutDesc"] or "Minimum time between summons",
                        function() return self:GetSetting("class", "lockout") end,
                        function(_, v) self:SetSetting("class", "lockout", v) end,
                        { min = 0.20, max = 2.00, step = 0.05, order = 3 }
                    ),
                    extraMargin = OptionsFactory:CreateRange(L["extraMargin"] or "Extra margin (s)", L["extraMarginDesc"] or "Additional safety margin",
                        function() return self:GetSetting("class", "extraMargin") end,
                        function(_, v) self:SetSetting("class", "extraMargin", v) end,
                        { min = 0.00, max = 0.50, step = 0.01, order = 4 }
                    ),
                    onlyInRaids = OptionsFactory:CreateToggle(L["onlyInRaids"] or "Only in raids", L["onlyInRaidsDesc"] or "Restrict to raid instances",
                        function() return self:GetSetting("class", "onlyInRaids") end,
                        function(_, v) self:SetSetting("class", "onlyInRaids", v) end,
                        { order = 5 }
                    ),
                    snakeSpellName = OptionsFactory:CreateInput(L["snakeSpellName"] or "Snake Spell Name", L["snakeSpellNameDesc"] or "Set a custom snake summon spell name",
                        function() return self:GetSetting("class", "snakeSpellName") end,
                        function(_, v)
                            local value = v or ""
                            -- simple trim
                            value = value:gsub("^%s+", ""):gsub("%s+$", "")
                            if value == "" then value = "Albino Snake" end
                            self:SetSetting("class", "snakeSpellName", value)
                        end,
                        { width = "full", order = 6 }
                    ),
                    debug = OptionsFactory:CreateToggle(L["debug"] or "Debug logs", L["debugDesc"] or "Show debug traces in chat",
                        function() return self:GetSetting("class", "debug") end,
                        function(_, v) self:SetSetting("class", "debug", v) end,
                        { order = 7 }
                    ),
                }
            }
        }
    }
end
