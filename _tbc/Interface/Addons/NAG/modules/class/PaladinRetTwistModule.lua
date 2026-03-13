--- @module "NAG.PaladinRetTwistModule"
--- Runtime helpers for Classic TBC Retribution Paladin seal twisting rotations.
---
--- Tracks simple, runtime-only state needed by APL logic (no DB writes):
--- - "warmup swings since combat start" (WA used `meleeCount > 2`)
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local GetTime = _G.GetTime
local GetSpellInfo = _G.GetSpellInfo
local UnitAura = _G.UnitAura
local UnitGUID = _G.UnitGUID
local UnitAttackSpeed = _G.UnitAttackSpeed
local PlaySound = _G.PlaySound
local PlaySoundFile = _G.PlaySoundFile
local tableSort = _G.table.sort
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local PaladinTwistConstants = ns.PaladinTwistConstants or {}
--- @type OptionsFactory
local OptionsFactory
local LSM = ns.LibSharedMedia

-- ============================ MODULE DEFINITION ============================

local defaults = {
    class = {
        enabled = true,

        -- Debug: when enabled, this module will print compact state snapshots
        -- on relevant swing/cast events to help validate timing helpers in-game.
        debugLoggingEnabled = false,
        debugThrottleSeconds = 0.25,

        -- Ret twist hold cue settings (disabled by default)
        holdCueSoundEnabled = false,
        holdCueSound = "None",
        holdCueShineEnabled = false,
        holdCueShineType = "Autocast Shine",
        holdCueShineScale = 1.0,
        holdCueLeadTimeSeconds = 0.1,

        -- Self-apply Judgement of the Crusader (default ON)
        -- When enabled, guide applying the ImpSoC debuff yourself during the pull (from range).
        -- Automatically activates if ≤2 paladins in group.
        selfApplyJudgementOfCrusader = true,
        -- Force self-apply even with more paladins (assignment override)
        selfApplyJudgementOfCrusaderForced = false,
        -- Optional: allow self-apply logic while solo (default OFF)
        selfApplyJudgementOfCrusaderSoloForced = false,

        barScale = 1.0,

        -- When true, the bar only shows "Successful Twist" when Seal of Command's damage proc
        -- actually occurs (not just when both seals were active at swing). Default OFF.
        successTwistRequiresProc = false,
    }
}

local HOLD_CUE_SHINE_TYPES = {
    ["Autocast Shine"] = "Autocast Shine",
    ["Pixel Glow"] = "Pixel Glow",
    ["Button Glow"] = "Button Glow",
    ["Proc Glow"] = "Proc Glow",
}

local HOLD_CUE_SOUND_PRIORITY = {
    "Air Horn",
    "Aggro Alarm",
    "Alarm Clock Warning 3",
    "Auction Window Open",
    "Backpack Open",
    "Bell Toll Alliance",
}

local function buildHoldCueSoundValues()
    local values = {}
    if LSM and LSM.HashTable then
        local soundTable = LSM:HashTable("sound")
        if soundTable then
            for name in pairs(soundTable) do
                values[name] = name
            end
        end
    end

    return values
end

local LEGACY_HOLD_CUE_SOUNDKIT_KEYS = {
    ["Tell Message"] = "TELL_MESSAGE",
    ["Tutorial Popup"] = "TUTORIAL_POPUP",
    ["Loot Coin"] = "LOOT_WINDOW_COIN_SOUND",
    ["Checkbox On"] = "IG_MAINMENU_OPTION_CHECKBOX_ON",
    ["Checkbox Off"] = "IG_MAINMENU_OPTION_CHECKBOX_OFF",
    ["Backpack Open"] = "IG_BACKPACK_OPEN",
}

--- Resolve a legacy curated label into a valid SOUNDKIT id.
--- @param soundSetting string
--- @return number|nil
local function resolveLegacyHoldCueSoundKit(soundSetting)
    if type(soundSetting) ~= "string" then
        return nil
    end
    local soundKit = _G.SOUNDKIT
    if not soundKit then
        return nil
    end
    local soundKitKey = LEGACY_HOLD_CUE_SOUNDKIT_KEYS[soundSetting]
    if not soundKitKey then
        return nil
    end
    local soundKitValue = soundKit[soundKitKey]
    if type(soundKitValue) == "number" and soundKitValue > 0 then
        return soundKitValue
    end
    return nil
end

--- Return the first valid hold cue sound name from preferred order.
--- @param values table
--- @return string|nil
local function getFirstAvailableHoldCueSoundName(values)
    local orderedNames = {}
    for i = 1, #HOLD_CUE_SOUND_PRIORITY do
        local name = HOLD_CUE_SOUND_PRIORITY[i]
        if values[name] ~= nil then
            return name
        end
    end
    for name in pairs(values) do
        orderedNames[#orderedNames + 1] = name
    end
    if #orderedNames > 0 then
        tableSort(orderedNames, function(a, b)
            return tostring(a):lower() < tostring(b):lower()
        end)
        return orderedNames[1]
    end
    return nil
end

--- Return true when the provided sound setting is a valid LSM key.
--- @param soundSetting any
--- @return boolean
local function isValidLSMHoldCueSoundName(soundSetting)
    if type(soundSetting) ~= "string" or soundSetting == "" or soundSetting == "None" then
        return false
    end
    if not LSM or not LSM.Fetch then
        return false
    end
    local soundPath = LSM:Fetch("sound", soundSetting, true)
    return type(soundPath) == "string" and soundPath ~= ""
end

--- Normalize sound setting to a valid LSM hold cue sound name.
--- @param soundSetting any
--- @return string|nil
local function normalizeHoldCueSoundName(soundSetting)
    if isValidLSMHoldCueSoundName(soundSetting) then
        return soundSetting
    end
    return getFirstAvailableHoldCueSoundName(buildHoldCueSoundValues())
end

--- Resolve hold cue setting into a playable sound target.
--- @param soundSetting any
--- @return number|string|nil
local function resolveHoldCueSoundSetting(soundSetting)
    if not soundSetting then
        return nil
    end
    if type(soundSetting) == "number" then
        if soundSetting > 0 then
            return soundSetting
        end
        return nil
    end
    if type(soundSetting) ~= "string" then
        return soundSetting
    end
    if soundSetting == "" or soundSetting == "None" then
        return nil
    end

    if isValidLSMHoldCueSoundName(soundSetting) and LSM and LSM.Fetch then
        local soundPath = LSM:Fetch("sound", soundSetting, true)
        if soundPath and soundPath ~= "" then
            return soundPath
        end
    end

    local numericSound = tonumber(soundSetting)
    if numericSound and numericSound > 0 then
        return numericSound
    end

    local legacySoundKit = resolveLegacyHoldCueSoundKit(soundSetting)
    if legacySoundKit then
        return legacySoundKit
    end

    return soundSetting
end

--- @class PaladinRetTwistModule:CoreModule
local PaladinRetTwistModule = NAG:CreateModule("PaladinRetTwistModule", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "PALADIN",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    debugCategories = { ns.DEBUG_CATEGORIES.CLASS },

    slashCommands = {
        ["rettwistdebug"] = {
            handler = true,
            help = "Toggle or set Ret twist debug logging. Usage: /rettwistdebug [on|off]"
        }
    },

    eventHandlers = {
        PLAYER_REGEN_DISABLED = "OnCombatStateChanged",
        PLAYER_REGEN_ENABLED = "OnCombatStateChanged"
    },
    cleuHandlers = {
        SWING_DAMAGE = "HandleCLEU",
        SWING_MISSED = "HandleCLEU",
        SPELL_CAST_SUCCESS = "HandleCLEUSpellCastSuccess",
        SPELL_DAMAGE = "HandleCLEUSpellDamageSoCProc",
    },
    defaultState = {
        inCombat = false,
        swingCount = 0,
        lastResetTime = 0,

        -- Success-only twist detection (runtime-only):
        -- Updated on SWING_DAMAGE/SWING_MISSED when SoC + SoB/SoM are both active at impact.
        lastTwistSuccessTime = 0,
        lastTwistSuccessSoCId = 0,
        lastTwistSuccessTwistId = 0,

        -- When successTwistRequiresProc is true: pending swing with both seals; confirmed when SoC proc (20424) is seen.
        lastSwingWithBothSealsTime = 0,
        lastSwingWithBothSealsSoCId = 0,
        lastSwingWithBothSealsTwistId = 0,
    }
})

ns.PaladinRetTwistModule = PaladinRetTwistModule
local module = PaladinRetTwistModule

-- ============================ MODULE LIFECYCLE ============================

-- ============================ TWIST SUCCESS DETECTION (RAW AURA SCAN) ============================

-- Keep these lists consistent with `NAG/handlers/APLAction_Casting.lua` through shared constants.
local RET_TWIST_SOC_IDS = PaladinTwistConstants.RET_TWIST_SOC_IDS or {}

-- Seal of Command proc (Holy damage) - same ID across SoC ranks.
local RET_TWIST_SOC_PROC_SPELL_ID = tonumber(PaladinTwistConstants.SOC_PROC_ID) or 20424

local RET_TWIST_SOB_IDS = PaladinTwistConstants.RET_TWIST_SOB_IDS or {}

-- Leveling fallback (when SoB/SoM are not learned yet)
local RET_TWIST_SOR_IDS = PaladinTwistConstants.RET_TWIST_SOR_IDS or {}

local function buildSpellIdSet(ids)
    local set = {}
    for i = 1, #ids do
        set[ids[i]] = true
    end
    return set
end

local function buildSpellNameSet(ids)
    local set = {}
    if not GetSpellInfo then
        return set
    end
    for i = 1, #ids do
        local name = GetSpellInfo(ids[i])
        if name then
            set[name] = true
        end
    end
    return set
end

local SOC_ID_SET = buildSpellIdSet(RET_TWIST_SOC_IDS)
local SOB_ID_SET = buildSpellIdSet(RET_TWIST_SOB_IDS)
local SOC_NAME_SET = buildSpellNameSet(RET_TWIST_SOC_IDS)
local SOB_NAME_SET = buildSpellNameSet(RET_TWIST_SOB_IDS)
local SOR_NAME_SET = buildSpellNameSet(RET_TWIST_SOR_IDS)
for i = 1, #RET_TWIST_SOR_IDS do
    local id = RET_TWIST_SOR_IDS[i]
    if id then
        SOB_ID_SET[id] = true
    end
end
for name in pairs(SOR_NAME_SET) do
    SOB_NAME_SET[name] = true
end

--- Raw aura scan that avoids NAG aura helpers/caches.
--- Returns both SoC and twist aura matches from a single pass.
--- @param unit string
--- @return number soCId
--- @return number twistId
local function rawFindTwistAuraIds(unit)
    if not UnitAura then
        return 0, 0
    end
    local soCId = 0
    local twistId = 0
    for i = 1, 40 do
        local name, _, _, _, _, _, _, _, _, _, spellId = UnitAura(unit, i, "HELPFUL")
        if not name then
            break
        end

        if soCId == 0 then
            if spellId and SOC_ID_SET[spellId] then
                soCId = spellId
            elseif name and SOC_NAME_SET[name] then
                soCId = 1 -- Fallback: spellId not available on this client; name match is enough.
            end
        end

        if twistId == 0 then
            if spellId and SOB_ID_SET[spellId] then
                twistId = spellId
            elseif name and SOB_NAME_SET[name] then
                twistId = 1 -- Fallback: spellId not available on this client; name match is enough.
            end
        end

        if soCId ~= 0 and twistId ~= 0 then
            break
        end
    end
    return soCId, twistId
end

function PaladinRetTwistModule:ModuleInitialize()
    -- No heavy work here; events are wired via declarative tables.
    if self:GetSetting("class", "holdCueSoundEnabled") then
        self:EnsureHoldCueSoundSelection()
    end
end

--- Play configured HOLD cue sound.
--- @param soundSetting any
--- @param context string|nil
--- @return boolean
function PaladinRetTwistModule:PlayHoldCueSound(soundSetting, context)
    local resolvedSound = resolveHoldCueSoundSetting(soundSetting)
    if not resolvedSound or resolvedSound == "None" then
        if context then
            self:Debug("RetTwist hold cue: no playable sound for context " .. tostring(context))
        end
        return false
    end

    if type(resolvedSound) == "number" and PlaySound then
        PlaySound(resolvedSound)
        return true
    end

    if type(resolvedSound) == "string" and PlaySoundFile then
        PlaySoundFile(resolvedSound, "Master")
        return true
    end

    return false
end

function PaladinRetTwistModule:PlayHoldCueSoundPreview(soundSetting, context)
    local selectedSound = soundSetting
    if selectedSound == nil then
        selectedSound = self:GetSetting("class", "holdCueSound")
    end
    self:PlayHoldCueSound(selectedSound, context or "preview")
end

function PaladinRetTwistModule:ResolveHoldCueSoundSetting(soundSetting)
    return resolveHoldCueSoundSetting(soundSetting)
end

--- Ensure hold cue sound setting always points to a valid selectable sound.
--- @return string|nil
function PaladinRetTwistModule:EnsureHoldCueSoundSelection()
    local selectedSound = self:GetSetting("class", "holdCueSound")
    local normalizedSound = normalizeHoldCueSoundName(selectedSound)
    if normalizedSound and normalizedSound ~= selectedSound then
        self:SetSetting("class", "holdCueSound", normalizedSound)
    end
    return normalizedSound
end

function PaladinRetTwistModule:StartDebugSampler()
    if self._debugSamplerActive then
        return
    end

    local TimerManager = ns.TimerManager
    if not TimerManager or not TimerManager.Create then
        return
    end

    self._debugSamplerActive = true
    TimerManager:Cancel(TimerManager.Categories.COMBAT, "retTwistDebugSampler")
    TimerManager:Create(
        TimerManager.Categories.COMBAT,
        "retTwistDebugSampler",
        function()
            self:DebugSamplerTick()
        end,
        0.05,
        true
    )
end

function PaladinRetTwistModule:StopDebugSampler()
    local TimerManager = ns.TimerManager
    if TimerManager and TimerManager.Cancel then
        TimerManager:Cancel(TimerManager.Categories.COMBAT, "retTwistDebugSampler")
    end
    self._debugSamplerActive = false
end

function PaladinRetTwistModule:DebugSamplerTick()
    if not self.db.class.debugLoggingEnabled then
        self:StopDebugSampler()
        return
    end

    self:InitializeState()
    if not self.state.inCombat then
        return
    end

    -- Only emit samples near the twist-relevant region to avoid spam.
    local _, rawTimeToSwing = NAG:AutoTimeToNext()
    if not rawTimeToSwing then
        return
    end

    if rawTimeToSwing <= 0.65 then
        self:MaybePrintSnapshot("SAMPLE")
    end
end

function PaladinRetTwistModule:OnCombatStateChanged(event)
    self:InitializeState()
    if event == "PLAYER_REGEN_DISABLED" then
        self.state.inCombat = true
        self.state.swingCount = 0
        self.state.lastResetTime = GetTime()
        self:MaybePrintSnapshot("COMBAT_START")
        if self.db.class.debugLoggingEnabled then
            self:StartDebugSampler()
        end
    else
        self:MaybePrintSnapshot("COMBAT_END")
        self.state.inCombat = false
        self.state.swingCount = 0
        self.state.lastResetTime = GetTime()
        -- Clear twist success state so next combat does not show stale "Successful Twist" toast.
        self.state.lastTwistSuccessTime = 0
        self.state.lastTwistSuccessSoCId = 0
        self.state.lastTwistSuccessTwistId = 0
        self.state.lastSwingWithBothSealsTime = 0
        self.state.lastSwingWithBothSealsSoCId = 0
        self.state.lastSwingWithBothSealsTwistId = 0
        self:StopDebugSampler()
    end
end

--- Handle swing events via CLEU dispatch.
--- EventManager passes at least (timestamp, subEvent, hideCaster, sourceGUID, ...)
function PaladinRetTwistModule:HandleCLEU(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, arg12, arg13, arg14, arg15, arg16, arg17, arg18,
    arg19, arg20, arg21, arg22, arg23, arg24)
    self:InitializeState()
    if not self.state.inCombat then
        return
    end
    if sourceGUID ~= NAG.state.player.guid then
        return
    end
    -- cleuHandlers already restrict to SWING_DAMAGE / SWING_MISSED
    self.state.swingCount = (self.state.swingCount or 0) + 1

    -- Success-only twist detection:
    -- A twist is considered successful if, at swing impact, we have both SoC and SoB/SoM active.
    -- When successTwistRequiresProc is true, we only set lastTwistSuccess when the SoC proc (20424) is seen.
    local now = GetTime()
    local soCId, twistId = rawFindTwistAuraIds("player")
    if soCId ~= 0 and twistId ~= 0 then
        if self.db.class.successTwistRequiresProc then
            self.state.lastSwingWithBothSealsTime = now
            self.state.lastSwingWithBothSealsSoCId = soCId
            self.state.lastSwingWithBothSealsTwistId = twistId
        else
            self.state.lastTwistSuccessTime = now
            self.state.lastTwistSuccessSoCId = soCId
            self.state.lastTwistSuccessTwistId = twistId
        end
    end

    self:MaybePrintSnapshot(subEvent)
end

--- Handle spell cast success events for relevant Ret twisting spells.
--- Only used for debug snapshots (does not alter swing tracking).
function PaladinRetTwistModule:HandleCLEUSpellCastSuccess(timestamp, subEvent, hideCaster, sourceGUID, sourceName,
    sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, arg13, arg14, arg15, arg16,
    arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    self:InitializeState()
    if sourceGUID ~= NAG.state.player.guid then
        return
    end

    -- Only snapshot on spells relevant to the twisting logic (avoid spam).
    if spellId == 20375  -- Seal of Command (Rank 1, cast ID)
        or spellId == 27170 -- Seal of Command (Rank 6, cast ID)
        or spellId == 31892 -- Seal of Blood
        or spellId == 348700 -- Seal of the Martyr
        or spellId == 35395 -- Crusader Strike
        or spellId == 27138 -- Exorcism
        or spellId == 27173 -- Consecration
    then
        self:MaybePrintSnapshot("SPELL_CAST_SUCCESS:" .. tostring(spellId))
    end
end

--- Handle SPELL_DAMAGE for Seal of Command proc (20424). When successTwistRequiresProc is on,
--- confirm last pending swing-with-both-seals as a successful twist.
function PaladinRetTwistModule:HandleCLEUSpellDamageSoCProc(timestamp, subEvent, hideCaster, sourceGUID, sourceName,
    sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, arg13, arg14, arg15, arg16,
    arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    if not self.db.class.successTwistRequiresProc then
        return
    end
    if sourceGUID ~= NAG.state.player.guid then
        return
    end
    if spellId ~= RET_TWIST_SOC_PROC_SPELL_ID then
        return
    end

    self:InitializeState()
    local pendingTime = self.state.lastSwingWithBothSealsTime or 0
    local pendingSoCId = self.state.lastSwingWithBothSealsSoCId or 0
    local pendingTwistId = self.state.lastSwingWithBothSealsTwistId or 0
    if pendingTime <= 0 or pendingSoCId == 0 or pendingTwistId == 0 then
        return
    end

    local now = GetTime()
    if (now - pendingTime) > 0.5 then
        return
    end

    self.state.lastTwistSuccessTime = pendingTime
    self.state.lastTwistSuccessSoCId = pendingSoCId
    self.state.lastTwistSuccessTwistId = pendingTwistId
    self.state.lastSwingWithBothSealsTime = 0
    self.state.lastSwingWithBothSealsSoCId = 0
    self.state.lastSwingWithBothSealsTwistId = 0
end

function PaladinRetTwistModule:rettwistdebug(input)
    local arg = input and tostring(input):lower() or ""
    local enabled
    if arg == "on" or arg == "1" or arg == "true" then
        enabled = true
    elseif arg == "off" or arg == "0" or arg == "false" then
        enabled = false
    else
        enabled = not self.db.class.debugLoggingEnabled
    end

    self.db.class.debugLoggingEnabled = enabled
    self:Print(string.format("RetTwist debug logging: %s", enabled and "ON" or "OFF"))

    if enabled then
        self:StartDebugSampler()
    else
        self:StopDebugSampler()
    end
end

function PaladinRetTwistModule:MaybePrintSnapshot(reason)
    if not self.db.class.debugLoggingEnabled then
        return
    end

    local throttleSeconds = self.db.class.debugThrottleSeconds or 0.25
    if throttleSeconds < 0 then
        throttleSeconds = 0
    end

    self._lastDebugSnapshot = self._lastDebugSnapshot or 0
    local now = GetTime()
    if (now - self._lastDebugSnapshot) < throttleSeconds then
        return
    end
    self._lastDebugSnapshot = now

    local swingTimerLib = ns.LibClassicSwingTimerAPI
    local mhSpeed, mhExpiration
    if swingTimerLib and swingTimerLib.UnitSwingTimerInfo then
        mhSpeed, mhExpiration = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
    end

    local _, rawTimeToSwing = NAG:AutoTimeToNext()
    local timeAfterGCD = NAG:AutoTimeToNextAfterGCD()
    local gcd = NAG:GCDTimeToReady() or 0

    local canTwistNoDelay = NAG:CanTwist(0.4, 0.0)
    local canTwistDelay = NAG:CanTwist(0.4, 0.1)
    -- Ret twist policy: ignore ping; use fixed input delay of 0.1s
    local inputDelay = 0.1

    local csTTR = NAG:SpellTimeToReady(35395) or 0
    local forceCS = NAG:RetTwistShouldForceCrusaderStrike(1.7, 0.1, 0.4)

    local soCActive = NAG:RetTwistIsSoCActive()
    local soBActive = NAG:IsActive(31892)
    local soMActive = NAG:IsActive(348700)

    local swingCount = NAG:RetTwistSwingCount()
    local warmup = NAG:RetTwistWarmupComplete(2)

    local weaponSpeed = UnitAttackSpeed("player") or 0
    local mhTTR = (mhExpiration and (mhExpiration - now)) or 0

    self:Print(string.format(
        "RetTwist[%s] t=%.2f mhSpeed=%.3f mhTTR=%.3f apiSpeed=%.3f gcd=%.3f rawSwing=%.3f afterGCD=%.3f inputDelay=%.3f CanTwist(0.4,d0)=%.0f CanTwist(d0.1)=%.0f CS_TTR=%.3f ForceCS=%.0f SoC=%.0f SoB=%.0f SoM=%.0f swings=%d warmup=%.0f",
        tostring(reason),
        now,
        tonumber(mhSpeed) or 0,
        mhTTR,
        weaponSpeed,
        gcd,
        rawTimeToSwing or 0,
        timeAfterGCD or 0,
        inputDelay,
        canTwistNoDelay and 1 or 0,
        canTwistDelay and 1 or 0,
        csTTR,
        forceCS and 1 or 0,
        soCActive and 1 or 0,
        soBActive and 1 or 0,
        soMActive and 1 or 0,
        swingCount or 0,
        warmup and 1 or 0
    ))
end

--- Returns the universal scale for all Paladin bar UIs.
--- @return number Scale factor (default 1)
function PaladinRetTwistModule:GetPaladinBarScale()
    return self.db.class.barScale or 1
end

-- ============================ APL ACCESSORS (NAG API) ============================

function PaladinRetTwistModule:GetOptions()
    if not OptionsFactory then
        OptionsFactory = NAG:GetModule("OptionsFactory")
    end

    local soundValues = buildHoldCueSoundValues()

    return {
        type = "group",
        name = "Ret Twist Cues",
        order = 27,
        args = {
            barScale = {
                type = "range",
                name = "Paladin bars scale",
                desc = "Scale all Paladin UI bars (Ret twist bar, Ret weave bar).",
                min = 0.5,
                max = 2.0,
                step = 0.05,
                get = function() return self.db.class.barScale or 1 end,
                set = function(_, v)
                    self.db.class.barScale = v
                    NAG:SendMessage("NAG_PALADIN_BAR_SCALE_UPDATED")
                end,
                order = 0,
            },
            successTwistRequiresProc = OptionsFactory:CreateToggle(
                "Success only when SoC procs",
                "When enabled, the Paladin bar shows \"Successful Twist\" only when Seal of Command's damage proc actually occurs (not just when both seals were active at swing). Default: OFF.",
                function() return self:GetSetting("class", "successTwistRequiresProc") end,
                function(_, value) self:SetSetting("class", "successTwistRequiresProc", value) end,
                { order = 0.5 }
            ),
            holdCueSoundEnabled = OptionsFactory:CreateToggle(
                "Enable HOLD Sound Cue",
                "Play a sound 0.1s before the HOLD window ends.",
                function() return self:GetSetting("class", "holdCueSoundEnabled") end,
                function(_, value)
                    self:SetSetting("class", "holdCueSoundEnabled", value)
                    if value == true then
                        self:EnsureHoldCueSoundSelection()
                    end
                end,
                { order = 1 }
            ),
            holdCueSound = OptionsFactory:CreateSelect(
                "HOLD Sound",
                "Sound to play 0.1s before HOLD ends.",
                function()
                    return self:GetSetting("class", "holdCueSound")
                end,
                function(_, value)
                    if value and value ~= "" then
                        self:SetSetting("class", "holdCueSound", value)
                    end
                    self:PlayHoldCueSoundPreview(value)
                end,
                {
                    values = soundValues,
                    order = 2,
                    dialogControl = "LSM30_Sound",
                    disabled = function() return not self:GetSetting("class", "holdCueSoundEnabled") end,
                }
            ),
            holdCueSoundPreview = OptionsFactory:CreateExecute(
                "Play HOLD Sound",
                "Play the currently selected HOLD sound.",
                function()
                    local selectedSound = self:EnsureHoldCueSoundSelection() or self:GetSetting("class", "holdCueSound")
                    self:PlayHoldCueSoundPreview(selectedSound, "button")
                end,
                { order = 2.5 }
            ),
            holdCueLeadTimeSeconds = OptionsFactory:CreateRange(
                "HOLD Lead Time (seconds)",
                "How long before the twist window opens the cue should play.",
                function() return self:GetSetting("class", "holdCueLeadTimeSeconds") end,
                function(_, value) self:SetSetting("class", "holdCueLeadTimeSeconds", value) end,
                { order = 2.6, min = 0.0, max = 0.4, step = 0.01 }
            ),
            holdCueShineType = OptionsFactory:CreateSelect(
                "HOLD Shine Type",
                "Choose the shine style used for the HOLD cue.",
                function() return self:GetSetting("class", "holdCueShineType") end,
                function(_, value) self:SetSetting("class", "holdCueShineType", value) end,
                {
                    order = 2.7,
                    values = HOLD_CUE_SHINE_TYPES,
                    disabled = function() return not self:GetSetting("class", "holdCueShineEnabled") end,
                }
            ),
            holdCueShineScale = OptionsFactory:CreateRange(
                "HOLD Shine Size",
                "Scale of the HOLD shine effect.",
                function() return self:GetSetting("class", "holdCueShineScale") end,
                function(_, value) self:SetSetting("class", "holdCueShineScale", value) end,
                { order = 2.8, min = 0.5, max = 2.5, step = 0.05 }
            ),
            holdCueShineEnabled = OptionsFactory:CreateToggle(
                "Enable HOLD Shine Cue",
                "Show a shine effect 0.1s before the HOLD window ends.",
                function() return self:GetSetting("class", "holdCueShineEnabled") end,
                function(_, value) self:SetSetting("class", "holdCueShineEnabled", value) end,
                { order = 3 }
            ),
            selfApplyHeader = {
                type = "header",
                name = "Self-Apply Judgement of the Crusader",
                order = 10,
            },
            selfApplyJudgementOfCrusader = OptionsFactory:CreateToggle(
                "Enable Self-Apply ImpSoC",
                "Guide applying the Judgement of the Crusader debuff yourself during the pull (from range). Automatically activates when 2 or fewer paladins are in group. (Default: ON)",
                function() return self:GetSetting("class", "selfApplyJudgementOfCrusader") end,
                function(_, value) self:SetSetting("class", "selfApplyJudgementOfCrusader", value) end,
                { order = 11 }
            ),
            selfApplyJudgementOfCrusaderForced = OptionsFactory:CreateToggle(
                "Force (Assignment Override)",
                "Force self-apply even with 3+ paladins in group. Use if you are assigned to apply ImpSoC regardless of group composition.",
                function() return self:GetSetting("class", "selfApplyJudgementOfCrusaderForced") end,
                function(_, value) self:SetSetting("class", "selfApplyJudgementOfCrusaderForced", value) end,
                {
                    order = 12,
                    disabled = function() return not self:GetSetting("class", "selfApplyJudgementOfCrusader") end,
                }
            ),
            selfApplyJudgementOfCrusaderSoloForced = OptionsFactory:CreateToggle(
                "Force While Solo",
                "Allow self-apply guidance while not grouped. Disabled by default.",
                function() return self:GetSetting("class", "selfApplyJudgementOfCrusaderSoloForced") end,
                function(_, value) self:SetSetting("class", "selfApplyJudgementOfCrusaderSoloForced", value) end,
                {
                    order = 12.5,
                    disabled = function() return not self:GetSetting("class", "selfApplyJudgementOfCrusader") end,
                }
            ),
            selfApplyDescription = {
                type = "description",
                name = "|cffaaaaaa(Normally Prot applies ImpSoC. Enable this only if you need to apply it yourself during the pull.)|r",
                order = 13,
            },
        }
    }
end

local RET_TWIST_BAR_GATE_TTL_SECONDS = 5

local function getTBCRetBarsGate()
    if ns.tbcRetBarsGateEnabled == nil then
        ns.tbcRetBarsGateEnabled = false
    end
    return ns.tbcRetBarsGateEnabled
end

local function getTBCRetBarsGateLastEnable()
    if ns.tbcRetBarsGateLastEnable == nil then
        ns.tbcRetBarsGateLastEnable = 0
    end
    return ns.tbcRetBarsGateLastEnable
end

local function updateTBCRetBarsGateLastEnable(timeSeconds)
    ns.tbcRetBarsGateLastEnable = timeSeconds or 0
end

local function isTBCRetBarsGateExpired(now)
    local lastEnable = getTBCRetBarsGateLastEnable()
    if lastEnable <= 0 then
        return true
    end
    return (now - lastEnable) > RET_TWIST_BAR_GATE_TTL_SECONDS
end

--- Returns true when the TBC Ret twist bars are gated on by a rotation call.
--- @return boolean
function NAG:IsTBCRetBarsEnabled()
    if not getTBCRetBarsGate() then
        return false
    end
    local now = GetTime()
    if isTBCRetBarsGateExpired(now) then
        ns.tbcRetBarsGateEnabled = false
        return false
    end
    return true
end

--- Enable the TBC Ret twist bars gate (does not override user visibility settings).
--- @return boolean Always false so it never short-circuits rotation strings
function NAG:EnableTBCRetBars()
    local now = GetTime()
    local wasEnabled = getTBCRetBarsGate()
    ns.tbcRetBarsGateEnabled = true
    updateTBCRetBarsGateLastEnable(now)

    local bar = ns.PaladinRetTwistBar
    if bar and bar.UpdateVisibility and not wasEnabled then
        bar:UpdateVisibility()
    end

    local TimerManager = ns.TimerManager
    if TimerManager and TimerManager.Create then
        TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "tbcRetBarsGateExpire")
        TimerManager:Create(
            TimerManager.Categories.UI_NOTIFICATION,
            "tbcRetBarsGateExpire",
            function()
                local expiredNow = GetTime()
                if isTBCRetBarsGateExpired(expiredNow) then
                    ns.tbcRetBarsGateEnabled = false
                    if bar and bar.UpdateVisibility then
                        bar:UpdateVisibility()
                    end
                end
            end,
            RET_TWIST_BAR_GATE_TTL_SECONDS,
            false
        )
    end
    return false
end

--- Returns the number of player melee swings observed since entering combat.
--- @return number
function NAG:RetTwistSwingCount()
    local m = ns.PaladinRetTwistModule
    if not m then
        return 0
    end
    m:InitializeState()
    if not m.state then
        return 0
    end
    return m.state.swingCount or 0
end

--- Returns true when we have observed more than `minSwings` swings since entering combat.
--- WA used `meleeCount > 2` as a warmup gate for filler suggestions.
--- @param minSwings number|nil Default: 2
--- @return boolean
function NAG:RetTwistWarmupComplete(minSwings)
    local threshold = minSwings
    if threshold == nil then
        threshold = 2
    end
    if threshold < 0 then
        threshold = 0
    end
    return self:RetTwistSwingCount() > threshold
end

--- Returns recent twist attempts (runtime-only) for visualization modules (e.g., RetTwistBar).
--- @return number timeSeconds
--- @return number soCSpellId
--- @return number twistSpellId
function NAG:RetTwistGetLastSuccess()
    local m = ns.PaladinRetTwistModule
    if not m then
        return 0, 0, 0
    end
    m:InitializeState()
    if not m.state then
        return 0, 0, 0
    end
    return m.state.lastTwistSuccessTime or 0, m.state.lastTwistSuccessSoCId or 0, m.state.lastTwistSuccessTwistId or 0
end


