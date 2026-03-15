--- @module "NAG.BossAbilityObserver"
--- Learns boss ability timings per-encounter and emits defensive pre-warnings.
---
--- Integrations:
--- - Optional DBM callbacks for timer-based predictions
--- - CLEU-based simple heuristics when DBM is not available
---
--- Emits only internal message: NAG_PREP_DEFENSIVE
--- Payload: { encounterId, bossName, sourceMobId, spellId, spellName, effectType, school, predictedAt, sourceGUID }
---
--- License: CC BY-NC 4.0
--- Authors: @Rakizi, @Fonsas

-- ============================ LOCALIZE ============================

local _, ns = ...
local WoWAPI = ns.WoWAPI
local L = ns.AceLocale:GetLocale("NAG", true)
local OptionsFactory

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Lua APIs
local format = string.format
local min = math.min
local max = math.max
local wipe = wipe
local strmatch = strmatch
local strsplit = strsplit

-- WoW APIs
local GetTime = _G.GetTime
local UnitGUID = _G.UnitGUID

-- ============================ DEFAULTS ============================

local defaults = {
    char = {
        enabled = true,
        prewarnSeconds = 5,
        dbmIntegration = true,
        maxObservations = 20,
    },
    global = {
        learnedEncounters = {},
    }
}

-- ============================ MODULE CREATION ============================

--- @class BossAbilityObserver : CoreModule
local BossAbilityObserver = NAG:CreateModule("BossAbilityObserver", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.FEATURE,

    -- Register direct WoW events
    eventHandlers = {
        ENCOUNTER_START = true,
        ENCOUNTER_END = true,
        PLAYER_REGEN_DISABLED = true,
        PLAYER_REGEN_ENABLED = true,
    },
    cleuHandlers = {
        SPELL_CAST_START = "HandleCLEUSpellCastStart",
        SPELL_CAST_SUCCESS = "HandleCLEUSpellCastSuccess",
        SPELL_DAMAGE = "HandleCLEUSpellDamage",
        SPELL_AURA_APPLIED = "HandleCLEUSpellAuraApplied",
    },

    -- Cross-module options injection
    optionsComposers = {
        ["splash"] = true,
    },

    -- Preservation of learned data
    preservationGroups = {
        ["bossAbilityObserverMemory"] = {
            name = L["Boss Ability Memory"] or "Boss Ability Memory",
            description = L["Persist learned boss ability timings per encounter"] or "Persist learned boss ability timings per encounter",
            settings = {
                global = { "learnedEncounters" },
                char = { "prewarnSeconds", "dbmIntegration" },
            },
            alwaysPreserve = false,
        }
    },

    debugCategories = { ns.DEBUG_CATEGORIES.TRACKERS, ns.DEBUG_CATEGORIES.FEATURES },

    -- Transient state
    defaultState = {
        currentEncounterId = nil,
        bossGuids = {},            -- [guid] = true
        activeTimers = {},         -- [timerName] = true
        lastCastStart = {},        -- [sourceGUID_spellId] = { t = time, school = num, sourceName = str }
    },
})
local module = BossAbilityObserver
ns.BossAbilityObserver = BossAbilityObserver

-- ============================ INTERNAL HELPERS ============================

local function guidToMobId(guid)
    if not guid then return nil end
    local _, _, _, _, _, npcId = strsplit("-", guid)
    if npcId then
        return tonumber(npcId)
    end
    return nil
end

local function buildKey(sourceGUID, spellId)
    return tostring(sourceGUID or "?") .. "_" .. tostring(spellId or 0)
end

function BossAbilityObserver:IsEnabled()
    return self.db and self.db.char and self.db.char.enabled == true
end

function BossAbilityObserver:GetEncounterBucket(encounterId)
    local g = self.db.global
    g.learnedEncounters[encounterId] = g.learnedEncounters[encounterId] or {}
    return g.learnedEncounters[encounterId]
end

function BossAbilityObserver:GetMobBucket(encounterId, mobId)
    local enc = self:GetEncounterBucket(encounterId)
    enc[mobId] = enc[mobId] or {}
    return enc[mobId]
end

function BossAbilityObserver:GetSpellStats(encounterId, mobId, spellId)
    local mob = self:GetMobBucket(encounterId, mobId)
    mob[spellId] = mob[spellId] or { avgCastToImpactMs = 0, avgIntervalMs = 0, observations = 0, tags = {} }
    return mob[spellId]
end

-- Update running averages bounded by maxObservations (store milliseconds)
function BossAbilityObserver:UpdateAverages(stats, newCastToImpactMs, newIntervalMs)
    local maxObs = self.db.char.maxObservations or 20
    local n = min((stats.observations or 0) + 1, maxObs)

    if newCastToImpactMs then
        if stats.observations and stats.observations > 0 then
            stats.avgCastToImpactMs = ((stats.avgCastToImpactMs * (n - 1)) + newCastToImpactMs) / n
        else
            stats.avgCastToImpactMs = newCastToImpactMs
        end
    end

    if newIntervalMs then
        if stats.observations and stats.observations > 0 then
            stats.avgIntervalMs = ((stats.avgIntervalMs * (n - 1)) + newIntervalMs) / n
        else
            stats.avgIntervalMs = newIntervalMs
        end
    end

    stats.observations = n
end

function BossAbilityObserver:IsBossSource(sourceGUID)
    return self.state.bossGuids and self.state.bossGuids[sourceGUID] == true
end

function BossAbilityObserver:RefreshBossGuids()
    wipe(self.state.bossGuids)
    for i = 1, 5 do
        local unit = "boss" .. i
        local guid = UnitGUID and UnitGUID(unit) or UnitGUID and UnitGUID(unit) or nil
        if guid then
            self.state.bossGuids[guid] = true
        end
    end
end

-- Choose effectType from tags; priority: stun > magical > knockback
local function deriveEffectType(tags)
    if not tags then return nil end
    if tags.stun then return "stun" end
    if tags.magical then return "magical" end
    if tags.knockback then return "knockback" end
    return nil
end

-- Schedule pre-warn for a predicted impact time (absolute seconds)
function BossAbilityObserver:SchedulePrewarn(sourceGUID, sourceName, spellId, spellName, predictedImpactAt)
    if not predictedImpactAt or predictedImpactAt <= 0 then return end
    local now = GetTime()
    local delay = predictedImpactAt - (now + (self.db.char.prewarnSeconds or 5))
    if delay <= 0 then delay = 0.01 end

    local encounterId = self.state.currentEncounterId
    if not encounterId then return end

    local mobId = guidToMobId(sourceGUID)
    if not mobId then return end

    -- Select tags/effectType from learned stats if available
    local stats = self:GetSpellStats(encounterId, mobId, spellId)
    local effectType = deriveEffectType(stats.tags)

    -- Timer unique name
    local timerName = format("BAO_%s_%d_%d", tostring(encounterId), mobId, spellId)
    if self.state.activeTimers[timerName] then return end
    self.state.activeTimers[timerName] = true

    local TimerManager = NAG:GetModule("TimerManager")
    TimerManager:Create(TimerManager.Categories.COMBAT, timerName, function()
        self.state.activeTimers[timerName] = nil
        self:SendMessage("NAG_PREP_DEFENSIVE", {
            encounterId = encounterId,
            bossName = sourceName,
            sourceMobId = mobId,
            spellId = spellId,
            spellName = spellName,
            effectType = effectType,
            school = stats.tags and stats.tags.school or nil,
            predictedAt = GetTime(),
            sourceGUID = sourceGUID,
        })
    end, delay, false)
end

-- Attempt to extract spellId from DBM timer id/text
function BossAbilityObserver:ExtractSpellId(id, text)
    if type(id) == "number" then return id end
    if type(id) == "string" then
        local num = tonumber(id)
        if num then return num end
        local m = strmatch(id, "(%d+)")
        if m then return tonumber(m) end
    end
    if type(text) == "string" then
        local m = strmatch(text, "(%d+)")
        if m then return tonumber(m) end
    end
    return nil
end

-- ============================ LIFECYCLE ============================

function BossAbilityObserver:ModuleInitialize()
    OptionsFactory = NAG:GetModule("OptionsFactory")
    self:RefreshBossGuids()
end

function BossAbilityObserver:ModuleEnable()
    -- Optional DBM integration
    if self.db.char.dbmIntegration and DBM and DBM.RegisterCallback then
        -- Guard re-registration
        if not self._dbmCallbacksRegistered then
            DBM:RegisterCallback("DBM_TimerStart", function(_, id, text, timer, icon, barType, spellId)
                if not self:IsEnabled() then return end
                -- Only consider ability timers
                local sid = spellId or self:ExtractSpellId(id, text)
                if not sid then return end

                -- Predict impact time as timer end (fallback, may differ by encounter)
                local predictedImpactAt = GetTime() + (tonumber(timer) or 0)
                local sourceName = nil -- Unknown from DBM; filled on CLEU elsewhere
                local sourceGUID = nil -- Unknown; we will still schedule generic warning
                local spellInfo = WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(sid)
                local spellName = spellInfo and spellInfo.name or text or ("Spell " .. tostring(sid))

                -- Use current target boss GUID if available as best-effort
                for guid in pairs(self.state.bossGuids) do
                    sourceGUID = guid
                    break
                end
                sourceName = sourceName or "Boss"

                if sourceGUID and self.state.currentEncounterId then
                    self:SchedulePrewarn(sourceGUID, sourceName, sid, spellName, predictedImpactAt)
                end
            end, self)
            self._dbmCallbacksRegistered = true
        end
    end
end

function BossAbilityObserver:ModuleDisable()
    -- Cancel our timers
    local TimerManager = NAG:GetModule("TimerManager")
    for name in pairs(self.state.activeTimers) do
        TimerManager:Cancel(TimerManager.Categories.COMBAT, name)
        self.state.activeTimers[name] = nil
    end
    -- DBM does not expose unregister per-callback id uniformly; leave as-is on disable
end

-- ============================ OPTIONS COMPOSER ============================

function BossAbilityObserver:splash(options, context)
    if not options or not options.args or not options.args.controlGroup or not options.args.controlGroup.args then
        return options
    end

    options.args.controlGroup.args.bossAbilityObserverToggle = OptionsFactory:CreateToggle(
        L["bossAbilityObserver"] or "Boss Ability Observer",
        L["bossAbilityObserverDesc"] or "Learn boss abilities and pre-warn for defensives",
        function() return self:GetSetting("char", "enabled", true) end,
        function(_, value)
            self:SetSetting("char", "enabled", value)
            if value then self:Enable() else self:Disable() end
        end,
        { order = 60 }
    )

    options.args.controlGroup.args.bossAbilityObserverPrewarn = OptionsFactory:CreateRange(
        L["prewarnSeconds"] or "Pre-warn Seconds",
        L["prewarnSecondsDesc"] or "How many seconds before impact to warn",
        function() return self:GetSetting("char", "prewarnSeconds", 5) end,
        function(_, v) self:SetSetting("char", "prewarnSeconds", max(1, min(8, v))) end,
        { order = 61, min = 1, max = 8, step = 1 }
    )

    options.args.controlGroup.args.bossAbilityObserverDBM = OptionsFactory:CreateToggle(
        L["useDBMIntegration"] or "Use DBM Integration",
        L["useDBMIntegrationDesc"] or "Leverage DBM timers when available",
        function() return self:GetSetting("char", "dbmIntegration", true) end,
        function(_, value) self:SetSetting("char", "dbmIntegration", value) end,
        { order = 62 }
    )

    return options
end

-- ============================ EVENT HANDLERS ============================

function BossAbilityObserver:ENCOUNTER_START(event, encounterId)
    self.state.currentEncounterId = encounterId
    self:RefreshBossGuids()
end

function BossAbilityObserver:ENCOUNTER_END()
    self.state.currentEncounterId = nil
    wipe(self.state.bossGuids)
    wipe(self.state.lastCastStart)
    -- Cancel any pending timers
    local TimerManager = NAG:GetModule("TimerManager")
    for name in pairs(self.state.activeTimers) do
        TimerManager:Cancel(TimerManager.Categories.COMBAT, name)
        self.state.activeTimers[name] = nil
    end
end

function BossAbilityObserver:PLAYER_REGEN_DISABLED()
    self:RefreshBossGuids()
end

function BossAbilityObserver:PLAYER_REGEN_ENABLED()
    -- Clear transient caches on leave combat
    wipe(self.state.lastCastStart)
end

-- Core CLEU handlers (split per subevent for clarity)
function BossAbilityObserver:HandleCLEUSpellCastStart(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, arg16, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    if not self:IsEnabled() or not self.state.currentEncounterId then return end
    if not self:IsBossSource(sourceGUID) then return end

    local key = buildKey(sourceGUID, spellId)
    self.state.lastCastStart[key] = { t = GetTime(), school = spellSchool, sourceName = sourceName }

    local encId = self.state.currentEncounterId
    local mobId = guidToMobId(sourceGUID)
    if encId and mobId then
        local stats = self:GetSpellStats(encId, mobId, spellId)
        local predictedImpactAt

        if stats and stats.avgCastToImpactMs and stats.avgCastToImpactMs > 0 then
            predictedImpactAt = GetTime() + (stats.avgCastToImpactMs / 1000)
        else
            local si = WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(spellId)
            local castMs = (si and si.castTime) or 2000
            predictedImpactAt = GetTime() + (castMs / 1000)
        end
        self:SchedulePrewarn(sourceGUID, sourceName or "Boss", spellId, spellName, predictedImpactAt)
    end
end

function BossAbilityObserver:HandleCLEUSpellCastSuccess(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, arg16, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    -- Currently no separate logic needed; keep for symmetry and future hooks
    if not self:IsEnabled() or not self.state.currentEncounterId then return end
    if not self:IsBossSource(sourceGUID) then return end
    -- Intentional no-op for now
end

function BossAbilityObserver:HandleCLEUSpellDamage(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, arg16, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    if not self:IsEnabled() or not self.state.currentEncounterId then return end
    if not self:IsBossSource(sourceGUID) then return end

    local key = buildKey(sourceGUID, spellId)
    local entry = self.state.lastCastStart[key]
    if entry then
        local deltaSec = max(0, GetTime() - entry.t)
        local encId = self.state.currentEncounterId
        local mobId = guidToMobId(sourceGUID)
        if encId and mobId then
            local stats = self:GetSpellStats(encId, mobId, spellId)
            self:UpdateAverages(stats, deltaSec * 1000, nil)
            if spellSchool and spellSchool ~= 1 then
                stats.tags.magical = true
                stats.tags.school = spellSchool
            end
        end
        self.state.lastCastStart[key] = nil
    end
end

function BossAbilityObserver:HandleCLEUSpellAuraApplied(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, auraType, arg17,
    arg18, arg19, arg20, arg21, arg22, arg23, arg24)
    if not self:IsEnabled() or not self.state.currentEncounterId then return end
    if not self:IsBossSource(sourceGUID) then return end

    if destGUID and (destGUID == (UnitGUID and NAG.state.player.guid or NAG.state.player.guid)) then
        local encId = self.state.currentEncounterId
        local mobId = guidToMobId(sourceGUID)
        if encId and mobId then
            local stats = self:GetSpellStats(encId, mobId, spellId)
            -- TODO: add curated detection to set stats.tags.stun/knockback
            if stats then
                -- placeholder for future tagging
            end
        end
    end
end

-- ============================ EXPORT ============================

return BossAbilityObserver


