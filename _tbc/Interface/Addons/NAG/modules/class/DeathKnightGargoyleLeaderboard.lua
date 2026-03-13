--- @module "NAG.DeathKnightGargoyleLeaderboard"
--- Unholy Death Knight Gargoyle damage leaderboard provider (Wrath / MoP).
---
--- Tracks combined SPELL_DAMAGE from the player's Gargoyle pet over the full Summon Gargoyle
--- duration (one value per summon), so haste/buffs/snapshots are reflected in the total.
--- Submits when the Gargoyle aura (49206) is removed; best total + local top-N.
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
local UnitAura = _G.UnitAura
local C_UnitAuras = _G.C_UnitAuras
local GetSpellInfo = _G.GetSpellInfo
local ProviderBase = ns.LeaderboardProviderBase

-- ============================ CONSTANTS ============================

local METRIC_ID = "death_knight_gargoyle_damage"
local SUMMON_GARGOYLE_AURA_ID = 49206
local GARGOYLE_STRIKE_SPELL_ID = 51963
local LOCAL_TOP_N_CAP = 20
local GARGOYLE_DISPLAY_NAME = "Gargoyle"
local GARGOYLE_DISPLAY_ICON = 49206
local GENERIC_SPELL_ICON = 136223

local SEARCH_TOKENS = { "target", "focus", "mouseover" }
for i = 1, 40 do
    SEARCH_TOKENS[#SEARCH_TOKENS + 1] = "nameplate" .. i
end

local defaults = {
    char = {
        enabled = true,
        debugGargoyleLeaderboard = false,
        bestRecordNotificationsEnabled = false,
        localGargoyleDamageTopN = {},
    },
}

-- ============================ MODULE CREATION ============================

--- @class DeathKnightGargoyleLeaderboard: CoreModule
local DeathKnightGargoyleLeaderboard = NAG:CreateModule("DeathKnightGargoyleLeaderboard", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "DEATHKNIGHT",
    optionsCategory = ns.MODULE_CATEGORIES.LEADERBOARD,
    cleuHandlers = {
        SPELL_DAMAGE = "HandleSpellDamage",
        SPELL_AURA_APPLIED = "HandleAuraEvent",
        SPELL_AURA_REMOVED = "HandleAuraEvent",
    },
    defaultState = {
        bestGargoyleTotal = 0,
        currentWindowTotal = 0,
        currentWindowContext = nil,
        gargoyleWindowActive = false,
        gargoyleSourceGUID = nil,
    },
    debugCategories = {
        ns.DEBUG_CATEGORIES.CLASS,
        ns.DEBUG_CATEGORIES.FEATURES,
    },
})

ns.DeathKnightGargoyleLeaderboard = DeathKnightGargoyleLeaderboard

-- ============================ HELPERS ============================

function DeathKnightGargoyleLeaderboard:GetLeaderboardService()
    return ProviderBase:GetLeaderboardService(self)
end

function DeathKnightGargoyleLeaderboard:GetPlayerGUID()
    return ProviderBase:GetPlayerGUID()
end

--- True if the player has the Summon Gargoyle aura (49206) on themselves.
function DeathKnightGargoyleLeaderboard:PlayerHasGargoyleAura()
    if C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID then
        local aura = C_UnitAuras.GetPlayerAuraBySpellID(SUMMON_GARGOYLE_AURA_ID)
        return aura ~= nil
    end
    local expectedName = GetSpellInfo and GetSpellInfo(SUMMON_GARGOYLE_AURA_ID) or "Summon Gargoyle"
    for i = 1, 40 do
        local name = UnitAura("player", i, "HELPFUL")
        if not name then
            break
        end
        if name == expectedName then
            return true
        end
    end
    return false
end

--- True if destGUID is the local player (for aura events).
function DeathKnightGargoyleLeaderboard:IsPlayerDest(destGUID)
    local playerGUID = self:GetPlayerGUID()
    return playerGUID ~= nil and destGUID == playerGUID
end

--- True if sourceGUID is the player's current pet (UnitGUID("pet")).
--- In Wrath the Gargoyle often is not the "pet" unit; use IsGargoyleSource for window-based lock.
function DeathKnightGargoyleLeaderboard:IsPetSource(sourceGUID)
    if not sourceGUID or type(sourceGUID) ~= "string" then
        return false
    end
    local petGUID = UnitGUID and UnitGUID("pet")
    return petGUID ~= nil and sourceGUID == petGUID
end

--- True if we're in an active Gargoyle window and sourceGUID is the locked Gargoyle (or pet).
function DeathKnightGargoyleLeaderboard:IsGargoyleSource(sourceGUID)
    if not sourceGUID or type(sourceGUID) ~= "string" then
        return false
    end
    if self:IsPetSource(sourceGUID) then
        return true
    end
    local locked = self.state.gargoyleSourceGUID
    return locked ~= nil and sourceGUID == locked
end

--- True when the char option "Debug Gargoyle Leaderboard" is enabled (for NAG:Print diagnostics).
function DeathKnightGargoyleLeaderboard:IsGargoyleDebugEnabled()
    return self.db.char.debugGargoyleLeaderboard == true
end

function DeathKnightGargoyleLeaderboard:IsEnabledForCurrentRuntime()
    if not self.db.char.enabled then
        return false
    end
    local class = NAG and NAG.CLASS_FILENAME or nil
    if type(class) ~= "string" or class ~= "DEATHKNIGHT" then
        return false
    end
    if Version and Version.IsMoP and Version:IsMoP() then
        return true
    end
    if Version and Version.IsWrath and Version:IsWrath() then
        return true
    end
    return false
end

function DeathKnightGargoyleLeaderboard:GetTargetLevelFromGUID(destGUID)
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

function DeathKnightGargoyleLeaderboard:GetSpellIconSafe(spellId)
    if type(spellId) == "number" and spellId > 0 then
        local icon = GetSpellTexture and GetSpellTexture(spellId) or nil
        if icon then
            return icon
        end
    end
    return GENERIC_SPELL_ICON
end

function DeathKnightGargoyleLeaderboard:BuildContext(eventType, destName, destGUID, spellId, spellName, spellIcon)
    return {
        eventType = eventType,
        targetName = destName or "Unknown",
        targetGUID = destGUID or "",
        targetLevel = self:GetTargetLevelFromGUID(destGUID),
        spellId = spellId or GARGOYLE_STRIKE_SPELL_ID,
        spellName = spellName or GARGOYLE_DISPLAY_NAME,
        spellIcon = spellIcon or GARGOYLE_DISPLAY_ICON,
        playerLevel = (UnitLevel and UnitLevel("player")) or nil,
    }
end

function DeathKnightGargoyleLeaderboard:SubmitBestOnlyRecord(amount, context)
    if type(amount) ~= "number" or amount <= 0 then
        return
    end
    if amount <= (self.state.bestGargoyleTotal or 0) then
        return
    end
    self.state.bestGargoyleTotal = amount

    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.SubmitMetricRecord then
        return
    end

    local ok, err = leaderboardService:SubmitMetricRecord({
        metricId = METRIC_ID,
        value = amount,
        scope = "local",
        className = "DEATHKNIGHT",
        context = context,
        sourceModule = self:GetName(),
        expansionTag = Version and Version:GetExpansion() or "unknown",
    })
    if not ok then
        self:Warn("Failed to submit Gargoyle damage record: %s", tostring(err))
    elseif self.db.char.bestRecordNotificationsEnabled then
        local spellName = type(context) == "table" and context.spellName or GARGOYLE_DISPLAY_NAME
        local targetName = type(context) == "table" and context.targetName or ""
        local targetStr = (targetName and targetName ~= "" and targetName ~= "Unknown") and (" on " .. targetName) or ""
        NAG:Print(string.format("|cffffcc00[NAG] " .. (L["Leaderboard best!"] or "Leaderboard best!") .. "|r %s total damage %s%s", tostring(spellName), tostring(amount), targetStr))
    end
end

function DeathKnightGargoyleLeaderboard:InsertLocalTopN(amount, context)
    if type(amount) ~= "number" or amount <= 0 or type(context) ~= "table" then
        return
    end
    if not self:IsEnabledForCurrentRuntime() then
        return
    end
    self.db.char.localGargoyleDamageTopN = self.db.char.localGargoyleDamageTopN or {}
    ProviderBase:InsertLocalTopN(self.db.char.localGargoyleDamageTopN, LOCAL_TOP_N_CAP, amount, context, {
        className = "DEATHKNIGHT",
    })
end

function DeathKnightGargoyleLeaderboard:GetLocalGargoyleDamageTopN()
    local t = self.db.char.localGargoyleDamageTopN
    return type(t) == "table" and t or {}
end

-- ============================ METRIC REGISTRATION ============================

function DeathKnightGargoyleLeaderboard:RegisterMetric()
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.RegisterMetricProvider then
        return
    end
    leaderboardService:RegisterMetricProvider({
        id = METRIC_ID,
        name = L["Gargoyle Damage"] or "Gargoyle Damage",
        description = L["Highest combined Gargoyle damage per summon, full duration (Wrath/MoP Unholy)."] or "Highest combined Gargoyle damage per summon, full duration (Wrath/MoP Unholy).",
        sourceModule = self:GetName(),
        className = "DEATHKNIGHT",
        expansionTag = Version and Version:GetExpansion() or "unknown",
        enabled = function()
            return DeathKnightGargoyleLeaderboard:IsEnabledForCurrentRuntime()
        end,
        schema = {
            allowedEventTypes = { SPELL_DAMAGE = true },
            contextPolicy = "allow_sparse",
            valueLabel = "Gargoyle Total",
        },
        capabilities = ProviderBase:BuildLocalTopNCapability(METRIC_ID, function()
            return DeathKnightGargoyleLeaderboard:GetLocalGargoyleDamageTopN()
        end),
    })
end

function DeathKnightGargoyleLeaderboard:UnregisterMetric()
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.UnregisterMetricProvider then
        return
    end
    leaderboardService:UnregisterMetricProvider(METRIC_ID)
end

-- ============================ LIFECYCLE ============================

function DeathKnightGargoyleLeaderboard:ModuleEnable()
    self:RegisterMetric()
end

function DeathKnightGargoyleLeaderboard:ModuleDisable()
    self:UnregisterMetric()
end

-- ============================ CLEU HANDLERS ============================

--- Start a new Gargoyle window (aura 49206 applied — on player or on Gargoyle creature).
function DeathKnightGargoyleLeaderboard:StartGargoyleWindow()
    self.state.currentWindowTotal = 0
    self.state.currentWindowContext = nil
    self.state.gargoyleWindowActive = true
    self.state.gargoyleSourceGUID = nil
    if self:IsGargoyleDebugEnabled() then
        NAG:Print("|cff69ccf0[Gargoyle DBG]|r Window started (Summon Gargoyle aura applied).")
    end
end

--- Finalize current window and submit combined total if > 0.
function DeathKnightGargoyleLeaderboard:FinalizeGargoyleWindow()
    local total = tonumber(self.state.currentWindowTotal) or 0
    self.state.gargoyleWindowActive = false
    self.state.gargoyleSourceGUID = nil
    if total <= 0 then
        if self:IsGargoyleDebugEnabled() then
            NAG:Print("|cff69ccf0[Gargoyle DBG]|r Finalize skipped (total <= 0).")
        end
        self.state.currentWindowTotal = 0
        self.state.currentWindowContext = nil
        return
    end
    if self:IsGargoyleDebugEnabled() then
        NAG:Print(string.format("|cff69ccf0[Gargoyle DBG]|r Window ended, total=%d — submitting.", total))
    end
    local context = self.state.currentWindowContext
    if type(context) ~= "table" then
        context = self:BuildContext("SPELL_DAMAGE", "Unknown", "", GARGOYLE_STRIKE_SPELL_ID, GARGOYLE_DISPLAY_NAME, self:GetSpellIconSafe(GARGOYLE_STRIKE_SPELL_ID))
    end
    self:SubmitBestOnlyRecord(total, context)
    self:InsertLocalTopN(total, context)
    self.state.currentWindowTotal = 0
    self.state.currentWindowContext = nil
end

function DeathKnightGargoyleLeaderboard:HandleAuraEvent(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, auraType)
    if not self:IsEnabledForCurrentRuntime() then
        return
    end
    if spellId ~= SUMMON_GARGOYLE_AURA_ID then
        return
    end
    -- Aura 49206 can be applied to the Gargoyle creature (dest) or the player; accept either for window start/end.
    if subEvent == "SPELL_AURA_APPLIED" then
        self:StartGargoyleWindow()
    elseif subEvent == "SPELL_AURA_REMOVED" then
        self:FinalizeGargoyleWindow()
    end
end

function DeathKnightGargoyleLeaderboard:HandleSpellDamage(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, amount, overkill,
    school, resisted, blocked, absorbed, critical)
    if not self:IsEnabledForCurrentRuntime() then
        return
    end
    -- Only count damage during an active Gargoyle window.
    if not self.state.gargoyleWindowActive then
        return
    end
    -- Lock onto the Gargoyle source: first Gargoyle Strike (51963) in this window sets gargoyleSourceGUID.
    if spellId == GARGOYLE_STRIKE_SPELL_ID and self.state.gargoyleSourceGUID == nil then
        self.state.gargoyleSourceGUID = sourceGUID
        if self:IsGargoyleDebugEnabled() then
            NAG:Print(string.format("|cff69ccf0[Gargoyle DBG]|r Locked Gargoyle source: %s", tostring(sourceGUID)))
        end
    end
    if not self:IsGargoyleSource(sourceGUID) then
        if self:IsGargoyleDebugEnabled() then
            local petGUID = UnitGUID and UnitGUID("pet")
            NAG:Print(string.format("|cff69ccf0[Gargoyle DBG]|r SPELL_DAMAGE source not our Gargoyle (sourceGUID=%s locked=%s petGUID=%s spellId=%s).", tostring(sourceGUID), tostring(self.state.gargoyleSourceGUID), tostring(petGUID), tostring(spellId)))
        end
        return
    end
    local numericAmount = tonumber(amount) or 0
    if numericAmount <= 0 then
        if self:IsGargoyleDebugEnabled() then
            NAG:Print(string.format("|cff69ccf0[Gargoyle DBG]|r Gargoyle damage spellId=%s skipped (amount=%s <= 0).", tostring(spellId), tostring(amount)))
        end
        return
    end
    self.state.currentWindowTotal = (self.state.currentWindowTotal or 0) + numericAmount
    if self:IsGargoyleDebugEnabled() then
        NAG:Print(string.format("|cff69ccf0[Gargoyle DBG]|r Gargoyle damage +%d (spellId=%s), running total=%d.", numericAmount, tostring(spellId), self.state.currentWindowTotal))
    end
    local displayName = (spellId == GARGOYLE_STRIKE_SPELL_ID and spellName) or GARGOYLE_DISPLAY_NAME
    self.state.currentWindowContext = self:BuildContext("SPELL_DAMAGE", destName, destGUID, spellId, displayName, self:GetSpellIconSafe(spellId))
end

-- ============================ OPTIONS ============================

function DeathKnightGargoyleLeaderboard:GetOptions()
    local function hideDeveloperOptions()
        return not (NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled())
    end
    return {
        type = "group",
        name = L["Gargoyle Damage Leaderboard"] or "Gargoyle Damage Leaderboard",
        order = 73,
        args = {
            enabled = {
                type = "toggle",
                name = L["Enable Gargoyle Damage Leaderboard"] or "Enable Gargoyle Damage Leaderboard",
                desc = L["Track combined Gargoyle damage per full summon for the leaderboard (Wrath/MoP Unholy)."] or "Track combined Gargoyle damage per full summon for the leaderboard (Wrath/MoP Unholy).",
                order = 1,
                get = function() return self.db.char.enabled == true end,
                set = function(_, value) self.db.char.enabled = value == true end,
            },
            debugGargoyleLeaderboard = {
                type = "toggle",
                name = L["Debug Gargoyle Leaderboard"] or "Debug Gargoyle Leaderboard",
                desc = L["Print diagnostic messages to chat for aura/damage/submit so you can see why Gargoyle may not be tracking."] or "Print diagnostic messages to chat for aura/damage/submit so you can see why Gargoyle may not be tracking.",
                order = 2,
                hidden = hideDeveloperOptions,
                get = function() return self.db.char.debugGargoyleLeaderboard == true end,
                set = function(_, value) self.db.char.debugGargoyleLeaderboard = value == true end,
            },
            bestRecordNotificationsEnabled = {
                type = "toggle",
                name = L["Show Best Record Notifications"] or "Show Best Record Notifications",
                desc = L["Print a chat message when a new personal best Gargoyle leaderboard record is submitted."] or "Print a chat message when a new personal best Gargoyle leaderboard record is submitted.",
                order = 3,
                get = function() return self.db.char.bestRecordNotificationsEnabled == true end,
                set = function(_, value) self.db.char.bestRecordNotificationsEnabled = value == true end,
            },
        }
    }
end

return DeathKnightGargoyleLeaderboard
