--- @module "NAG.PaladinSealTwistLeaderboard"
--- TBC Retribution Paladin seal-twist metric provider for LeaderboardService.
---
--- Captures twist attempts from CLEU and submits successful twist records to LeaderboardService.
--- A successful twist requires:
--- - a recent Seal of Command cast,
--- - a twist seal cast in the configured pre-swing window,
--- - correlated Seal of Command and twist-seal damage events near the swing.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
local Version = ns.Version
local WoWAPI = ns.WoWAPI
local GetTime = _G.GetTime
local UnitLevel = _G.UnitLevel
local ProviderBase = ns.LeaderboardProviderBase
local PaladinTwistConstants = ns.PaladinTwistConstants or {}

-- ============================ CONSTANTS ============================

local METRIC_ID = "paladin_seal_twist_tbc"
--- Display label and icon for the Spell column in LeaderboardViewer.
--- Other composite metrics (e.g. other "twist" or multi-source types) can follow the same pattern:
--- set context.eventType, context.spellName, context.spellIcon, context.targetName when submitting.
local SEAL_TWIST_DISPLAY_NAME = "Seal Twist"
local SEAL_TWIST_DISPLAY_ICON = 20424 -- Seal of Command proc icon
--- Max entries in the local top-N list (shown in leaderboard viewer when Local is selected).
local LOCAL_TOP_N_CAP = 20
local SOC_CAST_IDS = PaladinTwistConstants.SOC_CAST_IDS or {}
local TWIST_CAST_IDS = PaladinTwistConstants.TWIST_CAST_IDS or {}
local SOC_PROC_ID = tonumber(PaladinTwistConstants.SOC_PROC_ID) or 20424
local TWIST_PROC_IDS = PaladinTwistConstants.TWIST_PROC_SET or {}

local defaults = {
    class = {
        enabled = true,
        twistWindowSeconds = 0.4,
        correlationWindowSeconds = 0.5,
        includeSwingDamageInScore = true,
        debugTwistTracking = false,
        requireBarSuccessForSubmit = false,
    }
}

-- ============================ MODULE CREATION ============================

--- @class PaladinSealTwistLeaderboard: CoreModule
local PaladinSealTwistLeaderboard = NAG:CreateModule("PaladinSealTwistLeaderboard", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "PALADIN",
    optionsCategory = ns.MODULE_CATEGORIES.LEADERBOARD,
    debugCategories = { ns.DEBUG_CATEGORIES.CLASS, ns.DEBUG_CATEGORIES.FEATURES },
    eventHandlers = {
        PLAYER_REGEN_DISABLED = "OnCombatStateChanged",
        PLAYER_REGEN_ENABLED = "OnCombatStateChanged",
        UNIT_SPELLCAST_SUCCEEDED = true,
    },
    cleuHandlers = {
        SWING_DAMAGE = "HandleSwingEvent",
        SWING_MISSED = "HandleSwingEvent",
        SPELL_CAST_SUCCESS = "HandleSpellCastSuccess",
        SPELL_DAMAGE = "HandleSpellDamage",
        SPELL_AURA_APPLIED = "HandleAuraApplied",
    },
    defaultState = {
        inCombat = false,
        lastSoCCastTime = 0,
        lastTwistCastTime = 0,
        lastSoCCastSpellId = 0,
        lastTwistCastSpellId = 0,
        pendingSwing = nil,
        lastPendingSkippedNoTwistPrint = 0,
    },
})

ns.PaladinSealTwistLeaderboard = PaladinSealTwistLeaderboard

-- ============================ HELPERS ============================

function PaladinSealTwistLeaderboard:IsEnabledForCurrentRuntime()
    if self.db.class.enabled ~= true then
        return false
    end
    if Version and Version.IsTBC and not Version:IsTBC() then
        return false
    end
    return true
end

function PaladinSealTwistLeaderboard:GetLeaderboardService()
    return ProviderBase:GetLeaderboardService(self)
end

function PaladinSealTwistLeaderboard:GetPlayerGUID()
    return ProviderBase:GetPlayerGUID()
end

function PaladinSealTwistLeaderboard:IsPlayerSource(sourceGUID)
    return ProviderBase:IsPlayerSource(sourceGUID)
end

--- Insert a successful twist into the local top-N list (for viewer Local tab). Sorted by value descending.
--- @param value number Combined twist value
--- @param context table Record context (spellName, spellIcon, targetName, etc.)
function PaladinSealTwistLeaderboard:InsertLocalTwistTopN(value, context)
    if type(value) ~= "number" or value <= 0 then
        return
    end
    self.db.char.localSealTwistTopN = self.db.char.localSealTwistTopN or {}
    local list = self.db.char.localSealTwistTopN
    ProviderBase:InsertLocalTopN(list, LOCAL_TOP_N_CAP, value, context, {
        className = "PALADIN",
    })
end

--- Return the local top-N twist list for the leaderboard viewer (Local tab).
--- @return table Array of record-shaped entries (sorted by value desc)
function PaladinSealTwistLeaderboard:GetLocalTwistTopN()
    local t = self.db.char.localSealTwistTopN
    return type(t) == "table" and t or {}
end

function PaladinSealTwistLeaderboard:ResetPendingSwing()
    self.state.pendingSwing = nil
end

function PaladinSealTwistLeaderboard:RecordCast(spellId, timestamp)
    local t = timestamp or 0
    local logEpsilon = 0.05
    if SOC_CAST_IDS[spellId] then
        local prev = self.state.lastSoCCastTime or 0
        self.state.lastSoCCastTime = t
        self.state.lastSoCCastSpellId = spellId
        if not self.db.class.debugTwistTracking then
            -- no debug: never print
        elseif math.abs(t - prev) > logEpsilon then
            NAG:Print(string.format("|cffaad372[SealTwist DBG] SoC cast recorded spellId=%s t=%.2f|r", tostring(spellId), t))
        end
    elseif TWIST_CAST_IDS[spellId] then
        local prev = self.state.lastTwistCastTime or 0
        self.state.lastTwistCastTime = t
        self.state.lastTwistCastSpellId = spellId
        if not self.db.class.debugTwistTracking then
            -- no debug: never print
        elseif math.abs(t - prev) > logEpsilon then
            NAG:Print(string.format("|cffaad372[SealTwist DBG] Twist cast recorded spellId=%s t=%.2f|r", tostring(spellId), t))
        end
    end
end

function PaladinSealTwistLeaderboard:TryStartPendingSwing(timestamp, subEvent, destGUID, destName, swingAmount)
    local twistWindow = tonumber(self.db.class.twistWindowSeconds) or 0.4
    if twistWindow < 0.05 then
        twistWindow = 0.05
    end

    local socTime = self.state.lastSoCCastTime or 0
    local twistTime = self.state.lastTwistCastTime or 0
    if socTime <= 0 or twistTime <= 0 then
        if self.db.class.debugTwistTracking then
            if socTime <= 0 then
                NAG:Print("|cffaad372[SealTwist DBG] Pending skipped: no SoC|r")
            else
                NAG:Print("|cffaad372[SealTwist DBG] Pending skipped: no twist|r")
            end
        elseif socTime > 0 and twistTime <= 0 then
            local now = GetTime()
            local throttle = 2.5
            if self.db.class.debugTwistTracking and (now - (self.state.lastPendingSkippedNoTwistPrint or 0)) >= throttle then
                self.state.lastPendingSkippedNoTwistPrint = now
                NAG:Print("|cffffcc00[SealTwist] Pending skipped: no twist cast recorded (twist seal before swing). Enable Debug twist tracking for details.|r")
            end
        end
        return
    end
    if twistTime < socTime then
        if self.db.class.debugTwistTracking then
            NAG:Print("|cffaad372[SealTwist DBG] Pending skipped: twist before SoC|r")
        end
        return
    end

    local delta = timestamp - twistTime
    if delta < 0 or delta > twistWindow then
        if self.db.class.debugTwistTracking then
            NAG:Print(string.format("|cffaad372[SealTwist DBG] Pending skipped: twist outside window delta=%.2f window=%.2f|r", delta, twistWindow))
        end
        return
    end

    if self.db.class.debugTwistTracking then
        NAG:Print(string.format("|cffaad372[SealTwist DBG] Pending swing started t=%.2f delta=%.2f swing=%s|r", timestamp or 0, delta, tostring(swingAmount)))
    end
    self.state.pendingSwing = {
        swingTimestamp = timestamp,
        subEvent = subEvent,
        targetGUID = destGUID,
        targetName = (type(destName) == "string" and destName ~= "" and destName) or nil,
        swingDamage = tonumber(swingAmount) or 0,
        socDamage = 0,
        twistDamage = 0,
        socSpellId = self.state.lastSoCCastSpellId or 0,
        twistSpellId = self.state.lastTwistCastSpellId or 0,
        socSeen = false,
        twistSeen = false,
        unrecognizedSpellLogged = false,
    }
end

function PaladinSealTwistLeaderboard:IsPendingWithinWindow(timestamp)
    local pending = self.state.pendingSwing
    if not pending then
        return false
    end
    local correlation = tonumber(self.db.class.correlationWindowSeconds) or 0.5
    if correlation < 0.1 then
        correlation = 0.1
    end
    local delta = timestamp - (pending.swingTimestamp or timestamp)
    if delta < 0 then
        return false
    end
    return delta <= correlation
end

function PaladinSealTwistLeaderboard:FinalizePendingSuccess(timestamp)
    local pending = self.state.pendingSwing
    if not pending then
        return
    end
    if not pending.socSeen or not pending.twistSeen then
        if self.db.class.debugTwistTracking then
            NAG:Print(string.format("|cffffcc00[SealTwist DBG] Finalize skipped socSeen=%s twistSeen=%s|r", tostring(pending.socSeen), tostring(pending.twistSeen)))
        end
        return
    end

    if self.db.class.requireBarSuccessForSubmit then
        local lastSuccessTime = 0
        if NAG and NAG.RetTwistGetLastSuccess then
            lastSuccessTime = NAG:RetTwistGetLastSuccess()
        end
        local swingTs = pending.swingTimestamp or 0
        local epsilon = 0.15
        if lastSuccessTime <= 0 or (swingTs - lastSuccessTime) > epsilon or (lastSuccessTime - swingTs) > epsilon then
            if self.db.class.debugTwistTracking then
                NAG:Print(string.format("|cffaad372[SealTwist DBG] Submit skipped: bar success not within epsilon swingTs=%.2f lastSuccess=%.2f|r", swingTs, lastSuccessTime or 0))
            end
            return
        end
    end

    local value = pending.socDamage + pending.twistDamage
    if self.db.class.includeSwingDamageInScore == true then
        value = value + (pending.swingDamage or 0)
    end

    if self.db.class.debugTwistTracking then
        NAG:Print(string.format("|cff00ff00[SealTwist DBG] Submitting twist value=%.0f soc=%.0f twist=%.0f swing=%.0f|r", value, pending.socDamage or 0, pending.twistDamage or 0, pending.swingDamage or 0))
    end
    local leaderboardService = self:GetLeaderboardService()
    if leaderboardService and leaderboardService.SubmitMetricRecord then
        local context = {
            eventType = "SEAL_TWIST",
            swingSubEvent = pending.subEvent,
            targetGUID = pending.targetGUID,
            targetName = pending.targetName or "—",
            spellName = SEAL_TWIST_DISPLAY_NAME,
            spellIcon = SEAL_TWIST_DISPLAY_ICON,
            playerLevel = (UnitLevel and UnitLevel("player")) or nil,
            socDamage = pending.socDamage,
            twistDamage = pending.twistDamage,
            swingDamage = pending.swingDamage,
            socSpellId = pending.socSpellId,
            twistSpellId = pending.twistSpellId,
        }
        local ok, err = leaderboardService:SubmitMetricRecord({
            metricId = METRIC_ID,
            value = value,
            timestamp = timestamp,
            scope = "local",
            className = "PALADIN",
            context = context,
            sourceModule = self:GetName(),
            expansionTag = "tbc",
        })
        if not ok then
            self:Warn("Failed to submit seal twist record: %s", tostring(err))
        else
            self:InsertLocalTwistTopN(value, context)
        end
    end

    self:ResetPendingSwing()
end

-- ============================ LIFECYCLE ============================

function PaladinSealTwistLeaderboard:ModuleEnable()
    local leaderboardService = self:GetLeaderboardService()
    if leaderboardService and leaderboardService.RegisterMetricProvider then
        leaderboardService:RegisterMetricProvider({
            id = METRIC_ID,
            name = L["TBC Paladin Seal Twist Damage"] or "TBC Paladin Seal Twist Damage",
            description = "Highest successful seal-twist damage bundle (SoC + twist seal, optional swing).",
            className = "PALADIN",
            expansionTag = "tbc",
            sourceModule = self:GetName(),
            enabled = function()
                return PaladinSealTwistLeaderboard:IsEnabledForCurrentRuntime()
            end,
            schema = {
                allowedEventTypes = {
                    SEAL_TWIST = true,
                },
                contextPolicy = "allow_sparse",
                valueLabel = "Twist Damage",
            },
            capabilities = ProviderBase:BuildLocalTopNCapability(METRIC_ID, function()
                return PaladinSealTwistLeaderboard:GetLocalTwistTopN()
            end),
        })
    end
end

function PaladinSealTwistLeaderboard:ModuleDisable()
    local leaderboardService = self:GetLeaderboardService()
    if leaderboardService and leaderboardService.UnregisterMetricProvider then
        leaderboardService:UnregisterMetricProvider(METRIC_ID)
    end
    self:ResetPendingSwing()
end

-- ============================ EVENTS ============================

function PaladinSealTwistLeaderboard:OnCombatStateChanged(event)
    if event == "PLAYER_REGEN_DISABLED" then
        self.state.inCombat = true
    else
        self.state.inCombat = false
        self:ResetPendingSwing()
    end
end

--- Track direct player cast success events for seal cast timing.
--- @param event string
--- @param unitTarget string
--- @param castGUID string
--- @param spellID number
function PaladinSealTwistLeaderboard:UNIT_SPELLCAST_SUCCEEDED(event, unitTarget, castGUID, spellID)
    if not self:IsEnabledForCurrentRuntime() then
        return
    end
    if unitTarget ~= "player" then
        return
    end
    if not spellID then
        return
    end
    self:RecordCast(spellID, GetTime())
end

--- Track relevant spell casts from CLEU for player-only casts.
--- Uses GetTime() so timing is comparable with UNIT_SPELLCAST_SUCCEEDED and swing/proc events.
function PaladinSealTwistLeaderboard:HandleSpellCastSuccess(timestamp, subEvent, hideCaster, sourceGUID, sourceName,
    sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId)
    if not self:IsEnabledForCurrentRuntime() or not self.state.inCombat then
        return
    end
    if not self:IsPlayerSource(sourceGUID) then
        return
    end
    if not spellId then
        return
    end
    self:RecordCast(spellId, GetTime())
end

--- Track swing impact events and create pending twist-correlation candidates.
--- Only SWING_DAMAGE starts a pending swing; SWING_MISSED is ignored (no seal procs on miss).
--- Uses GetTime() so delta vs lastSoCCastTime/lastTwistCastTime is correct (same time base).
function PaladinSealTwistLeaderboard:HandleSwingEvent(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, amount)
    if not self:IsEnabledForCurrentRuntime() or not self.state.inCombat then
        return
    end
    if not self:IsPlayerSource(sourceGUID) then
        return
    end
    if subEvent == "SWING_MISSED" then
        return
    end

    local eventTime = GetTime()
    self:TryStartPendingSwing(eventTime, subEvent, destGUID, destName, amount)
end

--- Correlate SoC/twist damage events to pending swings and submit successful records.
--- Uses GetTime() for correlation window so we stay on the same time base as swing and casts.
function PaladinSealTwistLeaderboard:HandleSpellDamage(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, amount)
    if not self:IsEnabledForCurrentRuntime() or not self.state.inCombat then
        return
    end
    if not self:IsPlayerSource(sourceGUID) then
        return
    end
    if not self.state.pendingSwing then
        return
    end

    local eventTime = GetTime()
    if not self:IsPendingWithinWindow(eventTime) then
        if self.state.pendingSwing and self.db.class.debugTwistTracking then
            NAG:Print(string.format("|cffff0000[SealTwist DBG] Spell damage outside correlation window, resetting pending spellId=%s|r", tostring(spellId)))
        end
        self:ResetPendingSwing()
        return
    end

    local numericAmount = tonumber(amount) or 0
    if spellId == SOC_PROC_ID then
        self.state.pendingSwing.socSeen = true
        self.state.pendingSwing.socDamage = (self.state.pendingSwing.socDamage or 0) + numericAmount
        if self.db.class.debugTwistTracking then
            NAG:Print(string.format("|cffaad372[SealTwist DBG] SoC proc spellId=%s amount=%s|r", tostring(spellId), tostring(numericAmount)))
        end
    elseif TWIST_PROC_IDS[spellId] then
        self.state.pendingSwing.twistSeen = true
        self.state.pendingSwing.twistDamage = (self.state.pendingSwing.twistDamage or 0) + numericAmount
        if self.db.class.debugTwistTracking then
            NAG:Print(string.format("|cffaad372[SealTwist DBG] Twist proc spellId=%s amount=%s|r", tostring(spellId), tostring(numericAmount)))
        end
    else
        if self.db.class.debugTwistTracking and not self.state.pendingSwing.unrecognizedSpellLogged then
            self.state.pendingSwing.unrecognizedSpellLogged = true
            NAG:Print(string.format("|cffaad372[SealTwist DBG] Unrecognized SPELL_DAMAGE for pending twist spellId=%s amount=%s|r", tostring(spellId), tostring(numericAmount)))
        end
        if self.db.class.debugTwistTracking then
            NAG:Print(string.format("|cffffcc00[SealTwist DBG] SPELL_DAMAGE ignored (not SoC/twist proc) spellId=%s amount=%s|r", tostring(spellId), tostring(numericAmount)))
        end
    end

    self:FinalizePendingSuccess(eventTime)
end

--- When twist seal aura is applied to the player, treat it as a twist "cast" for timing.
--- Fallback for clients where SPELL_CAST_SUCCESS does not fire for the twist seal.
--- Also accepts by spell name so clients that report a different spellId still record.
function PaladinSealTwistLeaderboard:HandleAuraApplied(timestamp, subEvent, hideCaster, sourceGUID, sourceName,
    sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, auraType)
    if not self:IsEnabledForCurrentRuntime() or not self.state.inCombat then
        return
    end
    if not self:IsPlayerSource(sourceGUID) then
        return
    end
    if destGUID ~= self:GetPlayerGUID() then
        return
    end
    if not spellId then
        return
    end
    if SOC_CAST_IDS[spellId] then
        self:RecordCast(spellId, GetTime())
        return
    end
    if TWIST_CAST_IDS[spellId] then
        self:RecordCast(spellId, GetTime())
        return
    end
    local name = (type(spellName) == "string" and spellName ~= "" and spellName) or nil
    if name then
        if name == "Seal of Blood" or name == "Seal of the Martyr" or name == "Seal of Righteousness"
            or (string.find(name, "Seal of Blood") == 1)
            or (string.find(name, "Seal of the Martyr") == 1)
            or (string.find(name, "Seal of Righteousness") == 1) then
            local t = GetTime()
            local prev = self.state.lastTwistCastTime or 0
            self.state.lastTwistCastTime = t
            self.state.lastTwistCastSpellId = spellId
            if self.db.class.debugTwistTracking and math.abs(t - prev) > 0.05 then
                NAG:Print(string.format("|cffaad372[SealTwist DBG] Twist cast recorded (by name) spellId=%s name=%s t=%.2f|r", tostring(spellId), tostring(name), t))
            end
            return
        end
    end
    if self.db.class.debugTwistTracking then
        NAG:Print(string.format("|cffaad372[SealTwist DBG] AURA_APPLIED player->player spellId=%s spellName=%s (not SoC/twist)|r", tostring(spellId), tostring(spellName)))
    end
end

-- ============================ OPTIONS ============================

function PaladinSealTwistLeaderboard:GetOptions()
    local function hideDeveloperOptions()
        return not (NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled())
    end
    return {
        type = "group",
        name = L["Seal Twist Leaderboard"] or "Seal Twist Leaderboard",
        order = 70,
        args = {
            enabled = {
                type = "toggle",
                name = L["Enable Seal Twist Metric Provider"] or "Enable Seal Twist Metric Provider",
                order = 1,
                get = function() return self.db.class.enabled == true end,
                set = function(_, value) self.db.class.enabled = value == true end,
            },
            twistWindowSeconds = {
                type = "range",
                name = L["Twist cast window (seconds)"] or "Twist cast window (seconds)",
                desc = L["Maximum time between twist-seal cast and swing impact."] or "Maximum time between twist-seal cast and swing impact.",
                order = 2,
                min = 0.1,
                max = 0.8,
                step = 0.01,
                get = function() return tonumber(self.db.class.twistWindowSeconds) or 0.4 end,
                set = function(_, value) self.db.class.twistWindowSeconds = value end,
            },
            correlationWindowSeconds = {
                type = "range",
                name = L["Proc correlation window (seconds)"] or "Proc correlation window (seconds)",
                desc = L["Maximum delay after swing to accept SoC/twist damage as same attempt."] or "Maximum delay after swing to accept SoC/twist damage as same attempt.",
                order = 3,
                min = 0.1,
                max = 1.0,
                step = 0.01,
                get = function() return tonumber(self.db.class.correlationWindowSeconds) or 0.5 end,
                set = function(_, value) self.db.class.correlationWindowSeconds = value end,
            },
            includeSwingDamageInScore = {
                type = "toggle",
                name = L["Include swing damage in score value"] or "Include swing damage in score value",
                desc = L["When enabled, leaderboard value includes white swing + seal proc damage."] or "When enabled, leaderboard value includes white swing + seal proc damage.",
                order = 4,
                get = function() return self.db.class.includeSwingDamageInScore == true end,
                set = function(_, value) self.db.class.includeSwingDamageInScore = value == true end,
            },
            debugTwistTracking = {
                type = "toggle",
                name = L["Debug twist tracking"] or "Debug twist tracking",
                desc = L["Print SealTwist DBG messages (pending skipped reasons, unrecognized proc spellIds) to chat."] or "Print SealTwist DBG messages (pending skipped reasons, unrecognized proc spellIds) to chat.",
                order = 4.5,
                hidden = hideDeveloperOptions,
                get = function() return self.db.class.debugTwistTracking == true end,
                set = function(_, value) self.db.class.debugTwistTracking = value == true end,
            },
            requireBarSuccessForSubmit = {
                type = "toggle",
                name = L["Require bar successful twist to submit"] or "Require bar successful twist to submit",
                desc = L["When enabled, only submit when RetTwist bar considers the same swing a successful twist (within 0.15s)."] or "When enabled, only submit when RetTwist bar considers the same swing a successful twist (within 0.15s).",
                order = 4.6,
                get = function() return self.db.class.requireBarSuccessForSubmit == true end,
                set = function(_, value) self.db.class.requireBarSuccessForSubmit = value == true end,
            },
            runtimeInfo = {
                type = "description",
                order = 5,
                name = function()
                    local status = self:IsEnabledForCurrentRuntime() and "active" or "inactive"
                    local expansion = Version and Version:GetExpansion() or "unknown"
                    local fmt = L["Provider runtime status: %s (expansion: %s)"] or "Provider runtime status: %s (expansion: %s)"
                    return string.format(fmt, status, tostring(expansion))
                end,
            },
        }
    }
end

return PaladinSealTwistLeaderboard
