--- @module "NAG.CritHealLeaderboardProvider"
--- Crit/heal leaderboard provider (boss/encounter boards intentionally excluded).
---
--- Tracks crit-only combat events and submits best-only local records for:
--- - damage_crit_topX
--- - heal_crit_topX
---
--- Event coverage:
--- SWING_DAMAGE, RANGE_DAMAGE, SPELL_DAMAGE, SPELL_PERIODIC_DAMAGE,
--- SPELL_HEAL, SPELL_PERIODIC_HEAL
---
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

-- ============================ CONSTANTS ============================

local METRIC_DAMAGE = "damage_crit_topX"
local METRIC_HEAL = "heal_crit_topX"
local GENERIC_MELEE_ICON = 132349
local LOCAL_TOP_N_CAP = 20

local SEARCH_TOKENS = { "target", "focus", "mouseover" }
for i = 1, 40 do
    SEARCH_TOKENS[#SEARCH_TOKENS + 1] = "nameplate" .. i
end

local defaults = {
    char = {
        enabled = true,
        damageCritEnabled = true,
        healCritEnabled = true,
        trackPeriodicDamage = true,
        trackPeriodicHeal = true,
        bestRecordNotificationsEnabled = false,
        localCritNotificationsEnabled = false,
        localDamageCritTopN = {},
        localHealCritTopN = {},
    },
}

-- ============================ MODULE CREATION ============================

--- @class CritHealLeaderboardProvider: CoreModule
local CritHealLeaderboardProvider = NAG:CreateModule("CritHealLeaderboardProvider", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.LEADERBOARD,
    cleuHandlers = {
        SWING_DAMAGE = "HandleSwingDamage",
        RANGE_DAMAGE = "HandleRangeDamage",
        SPELL_DAMAGE = "HandleSpellDamage",
        SPELL_PERIODIC_DAMAGE = "HandleSpellPeriodicDamage",
        SPELL_HEAL = "HandleSpellHeal",
        SPELL_PERIODIC_HEAL = "HandleSpellPeriodicHeal",
    },
    defaultState = {
        bestDamageCrit = 0,
        bestHealCrit = 0,
    },
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.EVENTS,
    },
})

ns.CritHealLeaderboardProvider = CritHealLeaderboardProvider

-- ============================ HELPERS ============================

function CritHealLeaderboardProvider:GetLeaderboardService()
    return ProviderBase:GetLeaderboardService(self)
end

function CritHealLeaderboardProvider:GetPlayerGUID()
    return ProviderBase:GetPlayerGUID()
end

function CritHealLeaderboardProvider:GetRuntimeClassName()
    local player = NAG and NAG.state and NAG.state.player or nil
    local className = player and player.classInfo and player.classInfo.fileName or nil
    if type(className) ~= "string" or className == "" then
        className = NAG and NAG.CLASS_FILENAME or nil
    end
    if type(className) ~= "string" or className == "" then
        className = "ALL"
    end
    return tostring(className)
end

function CritHealLeaderboardProvider:IsPlayerSource(sourceGUID)
    return ProviderBase:IsPlayerSource(sourceGUID)
end

function CritHealLeaderboardProvider:GetTargetLevelFromGUID(destGUID)
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

function CritHealLeaderboardProvider:IsEnabledForRuntime()
    return self.db.char.enabled == true
end

function CritHealLeaderboardProvider:SubmitBestOnlyRecord(metricId, amount, context)
    if type(amount) ~= "number" or amount <= 0 then
        return
    end

    if metricId == METRIC_DAMAGE then
        if amount <= (self.state.bestDamageCrit or 0) then
            return
        end
        self.state.bestDamageCrit = amount
    elseif metricId == METRIC_HEAL then
        if amount <= (self.state.bestHealCrit or 0) then
            return
        end
        self.state.bestHealCrit = amount
    else
        return
    end

    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.SubmitMetricRecord then
        return
    end

    local ok, err = leaderboardService:SubmitMetricRecord({
        metricId = metricId,
        value = amount,
        scope = "local",
        className = self:GetRuntimeClassName(),
        context = context,
        sourceModule = self:GetName(),
        expansionTag = Version and Version:GetExpansion() or "unknown",
    })
    if not ok then
        self:Warn("Failed to submit %s record: %s", tostring(metricId), tostring(err))
    elseif self.db.char.bestRecordNotificationsEnabled then
        local spellName = type(context) == "table" and context.spellName or "Crit"
        local targetName = type(context) == "table" and context.targetName or ""
        local targetStr = (targetName and targetName ~= "" and targetName ~= "Unknown") and (" on " .. targetName) or ""
        NAG:Print(string.format("|cffffcc00[NAG] " .. (L["Leaderboard best!"] or "Leaderboard best!") .. "|r %s crit for %s%s", tostring(spellName), tostring(amount), targetStr))
    end
end

function CritHealLeaderboardProvider:BuildContext(eventType, destName, destGUID, spellId, spellName, spellIcon)
    return {
        eventType = eventType,
        targetName = destName or "Unknown",
        targetGUID = destGUID or "",
        targetLevel = self:GetTargetLevelFromGUID(destGUID),
        spellId = spellId,
        spellName = spellName or "Unknown",
        spellIcon = spellIcon or GENERIC_MELEE_ICON,
        playerLevel = (UnitLevel and UnitLevel("player")) or nil,
    }
end

function CritHealLeaderboardProvider:GetSpellIconSafe(spellId)
    if type(spellId) == "number" and spellId > 0 then
        local icon = GetSpellTexture and GetSpellTexture(spellId) or nil
        if icon then
            return icon
        end
    end
    return GENERIC_MELEE_ICON
end

-- ============================ LOCAL TOP-N (BCDL-STYLE) ============================

--- Insert a crit into the local top-N list (BCDL-style). Does not touch LeaderboardService.
--- @param metricId string METRIC_DAMAGE or METRIC_HEAL
--- @param amount number Crit value
--- @param context table From BuildContext (spellName, spellIcon, targetName, targetLevel, eventType, etc.)
function CritHealLeaderboardProvider:InsertLocalCritTopN(metricId, amount, context)
    if type(amount) ~= "number" or amount <= 0 then
        return
    end
    if type(context) ~= "table" then
        return
    end
    if metricId == METRIC_DAMAGE then
        if not self:IsEnabledForRuntime() or not self.db.char.damageCritEnabled then
            return
        end
    elseif metricId == METRIC_HEAL then
        if not self:IsEnabledForRuntime() or not self.db.char.healCritEnabled then
            return
        end
    else
        return
    end

    local list
    if metricId == METRIC_DAMAGE then
        self.db.char.localDamageCritTopN = self.db.char.localDamageCritTopN or {}
        list = self.db.char.localDamageCritTopN
    else
        self.db.char.localHealCritTopN = self.db.char.localHealCritTopN or {}
        list = self.db.char.localHealCritTopN
    end
    ProviderBase:InsertLocalTopN(list, LOCAL_TOP_N_CAP, amount, context, {
        className = self:GetRuntimeClassName(),
    })

    if self.db.char.localCritNotificationsEnabled then
        local spellName = type(context) == "table" and context.spellName or "Crit"
        local targetName = type(context) == "table" and context.targetName or ""
        local targetStr = (targetName and targetName ~= "" and targetName ~= "Unknown") and (" on " .. targetName) or ""
        NAG:Print(string.format("|cff00ff00[NAG] " .. (L["Local crit:"] or "Local crit:") .. "|r %s for %s%s", tostring(spellName), tostring(amount), targetStr))
    end
end

--- Return the local top-N list for the given crit metric (for viewer local mode).
--- @param metricId string damage_crit_topX or heal_crit_topX
--- @return table|nil Array of record-shaped entries (sorted by value desc), or nil for other metrics
function CritHealLeaderboardProvider:GetLocalCritTopN(metricId)
    if metricId == METRIC_DAMAGE then
        local t = self.db.char.localDamageCritTopN
        return type(t) == "table" and t or {}
    end
    if metricId == METRIC_HEAL then
        local t = self.db.char.localHealCritTopN
        return type(t) == "table" and t or {}
    end
    return nil
end

-- ============================ METRIC REGISTRATION ============================

function CritHealLeaderboardProvider:RegisterMetrics()
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.RegisterMetricProvider then
        return
    end
    leaderboardService:RegisterMetricProvider({
        id = METRIC_DAMAGE,
        name = L["Damage Crit Top X"] or "Damage Crit Top X",
        description = "Highest outgoing crit damage values.",
        sourceModule = self:GetName(),
        className = self:GetRuntimeClassName(),
        expansionTag = Version and Version:GetExpansion() or "unknown",
        enabled = function()
            return CritHealLeaderboardProvider.db.char.enabled == true and CritHealLeaderboardProvider.db.char.damageCritEnabled == true
        end,
        schema = {
            allowedEventTypes = {
                SWING_DAMAGE = true,
                RANGE_DAMAGE = true,
                SPELL_DAMAGE = true,
                SPELL_PERIODIC_DAMAGE = true,
            },
            contextPolicy = "allow_sparse",
            valueLabel = "Damage",
        },
        capabilities = ProviderBase:BuildLocalTopNCapability(METRIC_DAMAGE, function()
            return CritHealLeaderboardProvider:GetLocalCritTopN(METRIC_DAMAGE)
        end),
    })
    leaderboardService:RegisterMetricProvider({
        id = METRIC_HEAL,
        name = L["Healing Crit Top X"] or "Healing Crit Top X",
        description = "Highest outgoing crit heal values.",
        sourceModule = self:GetName(),
        className = self:GetRuntimeClassName(),
        expansionTag = Version and Version:GetExpansion() or "unknown",
        enabled = function()
            return CritHealLeaderboardProvider.db.char.enabled == true and CritHealLeaderboardProvider.db.char.healCritEnabled == true
        end,
        schema = {
            allowedEventTypes = {
                SPELL_HEAL = true,
                SPELL_PERIODIC_HEAL = true,
            },
            contextPolicy = "allow_sparse",
            valueLabel = "Healing",
        },
        capabilities = ProviderBase:BuildLocalTopNCapability(METRIC_HEAL, function()
            return CritHealLeaderboardProvider:GetLocalCritTopN(METRIC_HEAL)
        end),
    })
end

function CritHealLeaderboardProvider:UnregisterMetrics()
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.UnregisterMetricProvider then
        return
    end
    leaderboardService:UnregisterMetricProvider(METRIC_DAMAGE)
    leaderboardService:UnregisterMetricProvider(METRIC_HEAL)
end

-- ============================ LIFECYCLE ============================

function CritHealLeaderboardProvider:ModuleEnable()
    self:RegisterMetrics()
end

function CritHealLeaderboardProvider:ModuleDisable()
    self:UnregisterMetrics()
end

-- ============================ CLEU HANDLERS ============================

function CritHealLeaderboardProvider:HandleSwingDamage(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, amount, overkill, school, resisted, blocked, absorbed,
    critical)
    if not self:IsEnabledForRuntime() or not self.db.char.damageCritEnabled then
        return
    end
    if not self:IsPlayerSource(sourceGUID) then
        return
    end
    if critical ~= true and critical ~= 1 then
        return
    end
    local numericAmount = tonumber(amount) or 0
    local context = self:BuildContext("SWING_DAMAGE", destName, destGUID, 0, "Melee", GENERIC_MELEE_ICON)
    self:SubmitBestOnlyRecord(METRIC_DAMAGE, numericAmount, context)
    self:InsertLocalCritTopN(METRIC_DAMAGE, numericAmount, context)
end

function CritHealLeaderboardProvider:HandleRangeDamage(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, amount, overkill,
    school, resisted, blocked, absorbed, critical)
    if not self:IsEnabledForRuntime() or not self.db.char.damageCritEnabled then
        return
    end
    if not self:IsPlayerSource(sourceGUID) then
        return
    end
    if critical ~= true and critical ~= 1 then
        return
    end
    local numericAmount = tonumber(amount) or 0
    local context = self:BuildContext("RANGE_DAMAGE", destName, destGUID, spellId, spellName, self:GetSpellIconSafe(spellId))
    self:SubmitBestOnlyRecord(METRIC_DAMAGE, numericAmount, context)
    self:InsertLocalCritTopN(METRIC_DAMAGE, numericAmount, context)
end

function CritHealLeaderboardProvider:HandleSpellDamage(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, amount, overkill,
    school, resisted, blocked, absorbed, critical)
    if not self:IsEnabledForRuntime() or not self.db.char.damageCritEnabled then
        return
    end
    if not self:IsPlayerSource(sourceGUID) then
        return
    end
    if critical ~= true and critical ~= 1 then
        return
    end
    local numericAmount = tonumber(amount) or 0
    local context = self:BuildContext("SPELL_DAMAGE", destName, destGUID, spellId, spellName, self:GetSpellIconSafe(spellId))
    self:SubmitBestOnlyRecord(METRIC_DAMAGE, numericAmount, context)
    self:InsertLocalCritTopN(METRIC_DAMAGE, numericAmount, context)
end

function CritHealLeaderboardProvider:HandleSpellPeriodicDamage(timestamp, subEvent, hideCaster, sourceGUID, sourceName,
    sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, amount,
    overkill, school, resisted, blocked, absorbed, critical)
    if not self.db.char.trackPeriodicDamage then
        return
    end
    self:HandleSpellDamage(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID,
        destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked,
        absorbed, critical)
end

function CritHealLeaderboardProvider:HandleSpellHeal(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, amount, overheal,
    absorbed, critical)
    if not self:IsEnabledForRuntime() or not self.db.char.healCritEnabled then
        return
    end
    if not self:IsPlayerSource(sourceGUID) then
        return
    end
    if critical ~= true and critical ~= 1 then
        return
    end
    local numericAmount = tonumber(amount) or 0
    local context = self:BuildContext("SPELL_HEAL", destName, destGUID, spellId, spellName, self:GetSpellIconSafe(spellId))
    self:SubmitBestOnlyRecord(METRIC_HEAL, numericAmount, context)
    self:InsertLocalCritTopN(METRIC_HEAL, numericAmount, context)
end

function CritHealLeaderboardProvider:HandleSpellPeriodicHeal(timestamp, subEvent, hideCaster, sourceGUID, sourceName,
    sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, amount,
    overheal, absorbed, critical)
    if not self.db.char.trackPeriodicHeal then
        return
    end
    self:HandleSpellHeal(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID,
        destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, amount, overheal, absorbed, critical)
end

-- ============================ OPTIONS ============================

function CritHealLeaderboardProvider:GetOptions()
    return {
        type = "group",
        name = L["Crit/Heal Leaderboard"] or "Crit/Heal Leaderboard",
        order = 71,
        args = {
            enabled = {
                type = "toggle",
                name = L["Enable Crit/Heal Leaderboard Tracking"] or "Enable Crit/Heal Leaderboard Tracking",
                order = 1,
                get = function() return self.db.char.enabled == true end,
                set = function(_, value) self.db.char.enabled = value == true end,
            },
            damageCritEnabled = {
                type = "toggle",
                name = L["Track Damage Crits"] or "Track Damage Crits",
                order = 2,
                get = function() return self.db.char.damageCritEnabled == true end,
                set = function(_, value) self.db.char.damageCritEnabled = value == true end,
            },
            healCritEnabled = {
                type = "toggle",
                name = L["Track Heal Crits"] or "Track Heal Crits",
                order = 3,
                get = function() return self.db.char.healCritEnabled == true end,
                set = function(_, value) self.db.char.healCritEnabled = value == true end,
            },
            trackPeriodicDamage = {
                type = "toggle",
                name = L["Include Periodic Damage Crits"] or "Include Periodic Damage Crits",
                order = 4,
                get = function() return self.db.char.trackPeriodicDamage == true end,
                set = function(_, value) self.db.char.trackPeriodicDamage = value == true end,
            },
            trackPeriodicHeal = {
                type = "toggle",
                name = L["Include Periodic Heal Crits"] or "Include Periodic Heal Crits",
                order = 5,
                get = function() return self.db.char.trackPeriodicHeal == true end,
                set = function(_, value) self.db.char.trackPeriodicHeal = value == true end,
            },
            bestRecordNotificationsEnabled = {
                type = "toggle",
                name = L["Show Best Record Notifications"] or "Show Best Record Notifications",
                desc = L["Print a chat message when a new personal best leaderboard record is submitted."] or "Print a chat message when a new personal best leaderboard record is submitted.",
                order = 6,
                get = function() return self.db.char.bestRecordNotificationsEnabled == true end,
                set = function(_, value) self.db.char.bestRecordNotificationsEnabled = value == true end,
            },
            localCritNotificationsEnabled = {
                type = "toggle",
                name = L["Show Local Crit Notifications"] or "Show Local Crit Notifications",
                desc = L["Print a chat message for each recorded local crit entry."] or "Print a chat message for each recorded local crit entry.",
                order = 7,
                get = function() return self.db.char.localCritNotificationsEnabled == true end,
                set = function(_, value) self.db.char.localCritNotificationsEnabled = value == true end,
            },
        }
    }
end

return CritHealLeaderboardProvider
