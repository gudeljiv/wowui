--- @module "NAG.WarlockShadowBoltCritLeaderboard"
--- Warlock Shadow Bolt crit leaderboard provider (TBC / Wrath / MoP).
---
--- Tracks SPELL_DAMAGE crits from Shadow Bolt only and submits best-only + local top-N.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
local Version = ns.Version

local UnitGUID = _G.UnitGUID
local UnitLevel = _G.UnitLevel
local UnitExists = _G.UnitExists
local GetSpellTexture = _G.GetSpellTexture
local ProviderBase = ns.LeaderboardProviderBase
local WarlockConstants = ns.WarlockShadowBoltConstants or {}

-- ============================ CONSTANTS ============================

local METRIC_ID = "warlock_shadow_bolt_crit"
local LOCAL_TOP_N_CAP = 20
local GENERIC_SPELL_ICON = 136197

local SEARCH_TOKENS = { "target", "focus", "mouseover" }
for i = 1, 40 do
    SEARCH_TOKENS[#SEARCH_TOKENS + 1] = "nameplate" .. i
end

local defaults = {
    char = {
        enabled = true,
        debugShadowBoltLeaderboard = false,
        bestRecordNotificationsEnabled = false,
        localShadowBoltCritTopN = {},
    },
}

-- ============================ MODULE CREATION ============================

--- @class WarlockShadowBoltCritLeaderboard: CoreModule
local WarlockShadowBoltCritLeaderboard = NAG:CreateModule("WarlockShadowBoltCritLeaderboard", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "WARLOCK",
    optionsCategory = ns.MODULE_CATEGORIES.LEADERBOARD,
    cleuHandlers = {
        SPELL_DAMAGE = "HandleSpellDamage",
    },
    defaultState = {
        bestShadowBoltCrit = 0,
    },
    debugCategories = {
        ns.DEBUG_CATEGORIES.CLASS,
        ns.DEBUG_CATEGORIES.FEATURES,
    },
})

ns.WarlockShadowBoltCritLeaderboard = WarlockShadowBoltCritLeaderboard

-- ============================ HELPERS ============================

function WarlockShadowBoltCritLeaderboard:GetLeaderboardService()
    return ProviderBase:GetLeaderboardService(self)
end

function WarlockShadowBoltCritLeaderboard:GetPlayerGUID()
    return ProviderBase:GetPlayerGUID()
end

function WarlockShadowBoltCritLeaderboard:IsPlayerSource(sourceGUID)
    return ProviderBase:IsPlayerSource(sourceGUID)
end

--- True when the char option "Debug Shadow Bolt Crit Leaderboard" is enabled (for NAG:Print diagnostics).
function WarlockShadowBoltCritLeaderboard:IsShadowBoltDebugEnabled()
    return self.db.char.debugShadowBoltLeaderboard == true
end

--- Return the Shadow Bolt spell ID set for the current expansion (TBC, Wrath, or MoP).
function WarlockShadowBoltCritLeaderboard:GetShadowBoltSet()
    if Version and Version.IsMoP and Version:IsMoP() and WarlockConstants.SHADOW_BOLT_SET_WRATH then
        return WarlockConstants.SHADOW_BOLT_SET_WRATH
    end
    if Version and Version.IsWrath and Version:IsWrath() and WarlockConstants.SHADOW_BOLT_SET_WRATH then
        return WarlockConstants.SHADOW_BOLT_SET_WRATH
    end
    if Version and Version.IsTBC and Version:IsTBC() and WarlockConstants.SHADOW_BOLT_SET_TBC then
        return WarlockConstants.SHADOW_BOLT_SET_TBC
    end
    return WarlockConstants.SHADOW_BOLT_SET_TBC or {}
end

function WarlockShadowBoltCritLeaderboard:IsEnabledForCurrentRuntime()
    if not self.db.char.enabled then
        return false
    end
    local class = NAG and NAG.CLASS_FILENAME or nil
    if type(class) ~= "string" or class ~= "WARLOCK" then
        return false
    end
    if Version and Version.IsMoP and Version:IsMoP() then
        return true
    end
    if Version and Version.IsWrath and Version:IsWrath() then
        return true
    end
    if Version and Version.IsTBC and Version:IsTBC() then
        return true
    end
    return false
end

function WarlockShadowBoltCritLeaderboard:GetTargetLevelFromGUID(destGUID)
    if not destGUID then
        return nil
    end
    for i = 1, #SEARCH_TOKENS do
        local token = SEARCH_TOKENS[i]
        if UnitExists(token) and UnitGUID(token) == destGUID then
            local level = UnitLevel(token)
            if level and level ~= 0 then
                return level
            end
        end
    end
    return nil
end

function WarlockShadowBoltCritLeaderboard:GetSpellIconSafe(spellId)
    if type(spellId) == "number" and spellId > 0 then
        local icon = GetSpellTexture and GetSpellTexture(spellId) or nil
        if icon then
            return icon
        end
    end
    return GENERIC_SPELL_ICON
end

function WarlockShadowBoltCritLeaderboard:BuildContext(eventType, destName, destGUID, spellId, spellName, spellIcon)
    return {
        eventType = eventType,
        targetName = destName or "Unknown",
        targetGUID = destGUID or "",
        targetLevel = self:GetTargetLevelFromGUID(destGUID),
        spellId = spellId,
        spellName = spellName or "Shadow Bolt",
        spellIcon = spellIcon or GENERIC_SPELL_ICON,
        playerLevel = (UnitLevel and UnitLevel("player")) or nil,
    }
end

function WarlockShadowBoltCritLeaderboard:SubmitBestOnlyRecord(amount, context)
    if type(amount) ~= "number" or amount <= 0 then
        return
    end
    if amount <= (self.state.bestShadowBoltCrit or 0) then
        return
    end
    self.state.bestShadowBoltCrit = amount

    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.SubmitMetricRecord then
        return
    end

    local ok, err = leaderboardService:SubmitMetricRecord({
        metricId = METRIC_ID,
        value = amount,
        scope = "local",
        className = "WARLOCK",
        context = context,
        sourceModule = self:GetName(),
        expansionTag = Version and Version:GetExpansion() or "unknown",
    })
    if not ok then
        self:Warn("Failed to submit Shadow Bolt crit record: %s", tostring(err))
    elseif self.db.char.bestRecordNotificationsEnabled then
        local spellName = type(context) == "table" and context.spellName or "Shadow Bolt"
        local targetName = type(context) == "table" and context.targetName or ""
        local targetStr = (targetName and targetName ~= "" and targetName ~= "Unknown") and (" on " .. targetName) or ""
        NAG:Print(string.format("|cffffcc00[NAG] " .. (L["Leaderboard best!"] or "Leaderboard best!") .. "|r %s crit for %s%s", tostring(spellName), tostring(amount), targetStr))
    end
end

function WarlockShadowBoltCritLeaderboard:InsertLocalTopN(amount, context)
    if type(amount) ~= "number" or amount <= 0 or type(context) ~= "table" then
        return
    end
    if not self:IsEnabledForCurrentRuntime() then
        return
    end
    self.db.char.localShadowBoltCritTopN = self.db.char.localShadowBoltCritTopN or {}
    ProviderBase:InsertLocalTopN(self.db.char.localShadowBoltCritTopN, LOCAL_TOP_N_CAP, amount, context, {
        className = "WARLOCK",
    })
end

function WarlockShadowBoltCritLeaderboard:GetLocalShadowBoltCritTopN()
    local t = self.db.char.localShadowBoltCritTopN
    return type(t) == "table" and t or {}
end

-- ============================ METRIC REGISTRATION ============================

function WarlockShadowBoltCritLeaderboard:RegisterMetric()
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.RegisterMetricProvider then
        return
    end
    leaderboardService:RegisterMetricProvider({
        id = METRIC_ID,
        name = L["Shadow Bolt Crit"] or "Shadow Bolt Crit",
        description = L["Highest Shadow Bolt crit damage (TBC/Wrath/MoP)."] or "Highest Shadow Bolt crit damage (TBC/Wrath/MoP).",
        sourceModule = self:GetName(),
        className = "WARLOCK",
        expansionTag = Version and Version:GetExpansion() or "unknown",
        enabled = function()
            return WarlockShadowBoltCritLeaderboard:IsEnabledForCurrentRuntime()
        end,
        schema = {
            allowedEventTypes = { SPELL_DAMAGE = true },
            contextPolicy = "allow_sparse",
            valueLabel = "Shadow Bolt Crit",
        },
        capabilities = ProviderBase:BuildLocalTopNCapability(METRIC_ID, function()
            return WarlockShadowBoltCritLeaderboard:GetLocalShadowBoltCritTopN()
        end),
    })
end

function WarlockShadowBoltCritLeaderboard:UnregisterMetric()
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.UnregisterMetricProvider then
        return
    end
    leaderboardService:UnregisterMetricProvider(METRIC_ID)
end

-- ============================ LIFECYCLE ============================

function WarlockShadowBoltCritLeaderboard:ModuleEnable()
    self:RegisterMetric()
end

function WarlockShadowBoltCritLeaderboard:ModuleDisable()
    self:UnregisterMetric()
end

-- ============================ CLEU HANDLERS ============================

function WarlockShadowBoltCritLeaderboard:HandleSpellDamage(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, amount, overkill,
    school, resisted, blocked, absorbed, critical)
    if not self:IsEnabledForCurrentRuntime() then
        if self:IsShadowBoltDebugEnabled() then
            local expansion = (Version and Version.GetExpansion and Version:GetExpansion()) or "unknown"
            local isTBC = Version and Version.IsTBC and Version:IsTBC()
            local isWrath = Version and Version.IsWrath and Version:IsWrath()
            local isMoP = Version and Version.IsMoP and Version:IsMoP()
            NAG:Print(string.format("|cff9482c9[ShadowBolt DBG]|r SPELL_DAMAGE skipped: enabled=%s class=%s expansion=%s (TBC=%s Wrath=%s MoP=%s).", tostring(self.db.char.enabled), tostring(NAG and NAG.CLASS_FILENAME), tostring(expansion), tostring(isTBC), tostring(isWrath), tostring(isMoP)))
        end
        return
    end
    if not self:IsPlayerSource(sourceGUID) then
        if self:IsShadowBoltDebugEnabled() then
            local playerGUID = self:GetPlayerGUID()
            NAG:Print(string.format("|cff9482c9[ShadowBolt DBG]|r SPELL_DAMAGE skipped: source not player (sourceGUID=%s playerGUID=%s spellId=%s).", tostring(sourceGUID), tostring(playerGUID), tostring(spellId)))
        end
        return
    end
    if critical ~= true and critical ~= 1 then
        if self:IsShadowBoltDebugEnabled() and spellId then
            local set = self:GetShadowBoltSet()
            if set[spellId] then
                NAG:Print(string.format("|cff9482c9[ShadowBolt DBG]|r Shadow Bolt spellId=%s amount=%s skipped (not crit, critical=%s).", tostring(spellId), tostring(amount), tostring(critical)))
            end
        end
        return
    end
    local set = self:GetShadowBoltSet()
    if not set[spellId] then
        if self:IsShadowBoltDebugEnabled() then
            NAG:Print(string.format("|cff9482c9[ShadowBolt DBG]|r SPELL_DAMAGE spellId=%s amount=%s skipped (not in Shadow Bolt set for expansion).", tostring(spellId), tostring(amount)))
        end
        return
    end
    local numericAmount = tonumber(amount) or 0
    if self:IsShadowBoltDebugEnabled() then
        NAG:Print(string.format("|cff9482c9[ShadowBolt DBG]|r Shadow Bolt crit accepted: spellId=%s amount=%d target=%s.", tostring(spellId), numericAmount, tostring(destName)))
    end
    local context = self:BuildContext("SPELL_DAMAGE", destName, destGUID, spellId, spellName, self:GetSpellIconSafe(spellId))
    self:SubmitBestOnlyRecord(numericAmount, context)
    self:InsertLocalTopN(numericAmount, context)
end

-- ============================ OPTIONS ============================

function WarlockShadowBoltCritLeaderboard:GetOptions()
    local function hideDeveloperOptions()
        return not (NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled())
    end
    return {
        type = "group",
        name = L["Shadow Bolt Crit Leaderboard"] or "Shadow Bolt Crit Leaderboard",
        order = 72,
        args = {
            enabled = {
                type = "toggle",
                name = L["Enable Shadow Bolt Crit Leaderboard"] or "Enable Shadow Bolt Crit Leaderboard",
                desc = L["Track highest Shadow Bolt crits for the leaderboard (TBC/Wrath/MoP). Shadow Bolt crits also appear in the generic Damage Crit tab."] or "Track highest Shadow Bolt crits for the leaderboard (TBC/Wrath/MoP). Shadow Bolt crits also appear in the generic Damage Crit tab.",
                order = 1,
                get = function() return self.db.char.enabled == true end,
                set = function(_, value) self.db.char.enabled = value == true end,
            },
            debugShadowBoltLeaderboard = {
                type = "toggle",
                name = L["Debug Shadow Bolt Crit Leaderboard"] or "Debug Shadow Bolt Crit Leaderboard",
                desc = L["Print diagnostic messages to chat so you can see why Shadow Bolt crits may or may not be recorded for the Shadow Bolt tab."] or "Print diagnostic messages to chat so you can see why Shadow Bolt crits may or may not be recorded for the Shadow Bolt tab.",
                order = 2,
                hidden = hideDeveloperOptions,
                get = function() return self.db.char.debugShadowBoltLeaderboard == true end,
                set = function(_, value) self.db.char.debugShadowBoltLeaderboard = value == true end,
            },
            bestRecordNotificationsEnabled = {
                type = "toggle",
                name = L["Show Best Record Notifications"] or "Show Best Record Notifications",
                desc = L["Print a chat message when a new personal best Shadow Bolt leaderboard record is submitted."] or "Print a chat message when a new personal best Shadow Bolt leaderboard record is submitted.",
                order = 3,
                get = function() return self.db.char.bestRecordNotificationsEnabled == true end,
                set = function(_, value) self.db.char.bestRecordNotificationsEnabled = value == true end,
            },
        }
    }
end

return WarlockShadowBoltCritLeaderboard
