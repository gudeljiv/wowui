--- @module "NAG.TBCStatistics"
--- Tracks uptime of core TBC raid buffs on player and debuffs on target.
--- Reports uptime at combat end and provides a debug monitor view.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas

-- ============================ LOCALIZE ============================

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ MODULE ACCESS ============================

--- @type TimerManager
--- @type OptionsFactory
local TimerManager, OptionsFactory

-- ============================ LUA API LOCALIZATION ============================

local GetTime = _G.GetTime
local format = string.format
local pairs = pairs
local ipairs = ipairs
local tinsert = table.insert
local max = math.max
local wipe = wipe

-- ============================ CONSTANTS ============================

local DEFAULT_UPDATE_INTERVAL = 0.2
local REPORT_PERCENT_PRECISION = 1
local REPORT_SECONDS_PRECISION = 1
local TIMER_NAME = "TBCStatisticsUpdate"
local DEFAULT_TIMELINE_NAME = "TBC Raid Uptime"

-- ============================ TRACKED AURAS ============================

local TRACKED_ENTRIES = {
    -- ---------------------------- PLAYER BUFFS ----------------------------
    {
        key = "windfury_totem",
        name = "Windfury Totem",
        unit = "player",
        auraType = "buff",
        spellIds = { 25587 }, -- Windfury Totem (Rank 5)
        providers = { "Shaman (Enhancement)" },
        importantFor = { "Melee", "Hunters", "Physical DPS" },
    },
    {
        key = "windfury_weapon",
        name = "Windfury Weapon",
        unit = "player",
        auraType = "buff",
        spellIds = { 25505 }, -- Windfury Weapon (Rank 5)
        providers = { "Shaman (Enhancement)" },
        importantFor = { "Melee", "Hunters", "Physical DPS" },
    },
    {
        key = "totem_of_wrath",
        name = "Totem of Wrath",
        unit = "player",
        auraType = "buff",
        spellIds = { 30706 }, -- Totem of Wrath
        providers = { "Shaman (Elemental)" },
        importantFor = { "Spell DPS", "Healers" },
    },
    {
        key = "trueshot_aura",
        name = "Trueshot Aura",
        unit = "player",
        auraType = "buff",
        spellIds = { 27066 }, -- Trueshot Aura (Rank 4)
        providers = { "Hunter (Marksmanship)" },
        importantFor = { "Physical DPS", "Hunters", "Melee" },
    },
    {
        key = "leader_of_the_pack",
        name = "Leader of the Pack",
        unit = "player",
        auraType = "buff",
        spellIds = { 17007 }, -- Leader of the Pack
        providers = { "Druid (Feral)" },
        importantFor = { "Physical DPS", "Melee" },
    },
    {
        key = "moonkin_aura",
        name = "Moonkin Aura",
        unit = "player",
        auraType = "buff",
        spellIds = { 24907 }, -- Moonkin Aura
        providers = { "Druid (Balance)" },
        importantFor = { "Spell DPS", "Healers" },
    },
    {
        key = "ferocious_inspiration",
        name = "Ferocious Inspiration",
        unit = "player",
        auraType = "buff",
        spellIds = { 34460 }, -- Ferocious Inspiration (Rank 3)
        providers = { "Hunter (Beast Mastery)" },
        importantFor = { "All DPS" },
    },

    -- ---------------------------- TARGET DEBUFFS ----------------------------
    {
        key = "major_armor_reduction",
        name = "Major Armor Reduction",
        unit = "target",
        auraType = "debuff",
        spellIds = { 25225, 8649 }, -- Sunder Armor (Rank 6), Expose Armor (Rank 2)
        providers = { "Warrior (Sunder Armor)", "Rogue (Expose Armor)" },
        importantFor = { "Physical DPS", "Hunters", "Melee" },
    },
    {
        key = "faerie_fire",
        name = "Faerie Fire",
        unit = "target",
        auraType = "debuff",
        spellIds = { 770 }, -- Faerie Fire
        providers = { "Druid" },
        importantFor = { "Physical DPS", "Tanks" },
    },
    {
        key = "curse_of_elements",
        name = "Curse of the Elements",
        unit = "target",
        auraType = "debuff",
        spellIds = { 27228 }, -- Curse of the Elements (Rank 4)
        providers = { "Warlock" },
        importantFor = { "Spell DPS", "Healers" },
    },
    {
        key = "misery",
        name = "Misery",
        unit = "target",
        auraType = "debuff",
        spellIds = { 33195 }, -- Misery (Rank 5)
        providers = { "Priest (Shadow)" },
        importantFor = { "Spell DPS", "Healers" },
    },
    {
        key = "shadow_vulnerability",
        name = "Shadow Vulnerability",
        unit = "target",
        auraType = "debuff",
        spellIds = { 17800 }, -- Shadow Vulnerability (Rank 5)
        providers = { "Warlock (Improved Shadow Bolt)" },
        importantFor = { "Shadow DPS" },
    },
    {
        key = "fire_vulnerability",
        name = "Fire Vulnerability",
        unit = "target",
        auraType = "debuff",
        spellIds = { 22959 }, -- Fire Vulnerability (Improved Scorch)
        providers = { "Mage (Fire)" },
        importantFor = { "Fire DPS" },
    },
    {
        key = "winters_chill",
        name = "Winter's Chill",
        unit = "target",
        auraType = "debuff",
        spellIds = { 28595 }, -- Winter's Chill (Rank 5)
        providers = { "Mage (Frost)" },
        importantFor = { "Frost DPS" },
    },
    {
        key = "blood_frenzy",
        name = "Blood Frenzy",
        unit = "target",
        auraType = "debuff",
        spellIds = { 29859 }, -- Blood Frenzy (Rank 2)
        providers = { "Warrior (Arms)" },
        importantFor = { "Physical DPS", "Hunters", "Melee" },
    },
    {
        key = "judgement_of_wisdom",
        name = "Judgement of Wisdom",
        unit = "target",
        auraType = "debuff",
        spellIds = { 27164 }, -- Judgement of Wisdom (Rank 4)
        providers = { "Paladin" },
        importantFor = { "Mana users", "Healers", "Spell DPS" },
    },
    {
        key = "judgement_of_the_crusader",
        name = "Judgement of the Crusader",
        unit = "target",
        auraType = "debuff",
        spellIds = { 27159 }, -- Judgement of the Crusader (Rank 7)
        providers = { "Paladin" },
        importantFor = { "Holy damage", "Paladins" },
    },
}

-- ============================ DEFAULTS ============================

local defaults = {
    char = {
        enabled = true,
        updateInterval = DEFAULT_UPDATE_INTERVAL,
        reportOnCombatEnd = false,
        configureUptimeTracker = true,
        uptimeTimelineName = DEFAULT_TIMELINE_NAME,
    }
}

-- ============================ MODULE DEFINITION ============================

--- @class TBCStatistics: CoreModule
local TBCStatistics = NAG:CreateModule("TBCStatistics", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.FEATURE,
    debugCategories = { ns.DEBUG_CATEGORIES.FEATURES },
    eventHandlers = {
        PLAYER_REGEN_DISABLED = true,
        PLAYER_REGEN_ENABLED = true,
    },
    slashCommands = {
        ["tbcstats"] = {
            handler = "HandleSlash",
            help = "Show TBC uptime report. Usage: /tbcstats [report|reset|debug|timeline]",
        },
    },
    defaultState = {
        inCombat = false,
        lastUpdate = 0,
        combatTime = 0,
        entryStats = {},
        auraPresence = {
            playerBuffs = {},
            targetDebuffs = {},
        },
        lastReport = nil,
    }
})

ns.TBCStatistics = TBCStatistics

-- ============================ PRIVATE HELPERS ============================

local function roundToPrecision(value, precision)
    local p = 10 ^ (precision or 0)
    return math.floor((value * p) + 0.5) / p
end

local function buildAuraPresence(unit, auraType, out)
    if not out then return {} end
    wipe(out)
    local cache = ns.SnapshotAuras and ns.SnapshotAuras(unit)
    if not cache then
        return out
    end
    local list = (auraType == "buff") and cache.buffs or cache.debuffs
    for i = 1, #list do
        local data = list[i]
        local spellId = data and data[10]
        if spellId then
            out[spellId] = true
        end
    end
    return out
end

local function anyAuraActive(spellIds, presence)
    if not presence then return false end
    for i = 1, #spellIds do
        if presence[spellIds[i]] then
            return true
        end
    end
    return false
end

local function snapshotReport(state)
    if not state then return nil end
    local snapshot = {
        combatTime = state.combatTime or 0,
        entries = {},
    }
    for key, stats in pairs(state.entryStats or {}) do
        snapshot.entries[key] = {
            activeTime = stats.activeTime or 0,
            totalTime = stats.totalTime or 0,
            active = stats.active == true,
        }
    end
    return snapshot
end

-- ============================ LIFECYCLE ============================

function TBCStatistics:ModuleInitialize()
    OptionsFactory = NAG:GetModule("OptionsFactory")
    TimerManager = NAG:GetModule("TimerManager")
    self:ResetStats()
end

function TBCStatistics:ModuleEnable()
    self:StartTimer()
    self:EnsureUptimeTrackerTimeline()
end

function TBCStatistics:ModuleDisable()
    self:StopTimer()
end

-- ============================ EVENT HANDLERS ============================

function TBCStatistics:PLAYER_REGEN_DISABLED()
    if not self.db.char.enabled then return end
    self.state.inCombat = true
    self.state.combatTime = 0
    self.state.lastUpdate = GetTime()
    self:ResetStats()
end

function TBCStatistics:PLAYER_REGEN_ENABLED()
    if not self.db.char.enabled then return end
    self.state.inCombat = false
    self.state.lastReport = snapshotReport(self.state)
    self:ResetStats()
end

-- ============================ TIMER MANAGEMENT ============================

function TBCStatistics:StartTimer()
    if not TimerManager then return end
    local interval = tonumber(self.db.char.updateInterval) or DEFAULT_UPDATE_INTERVAL
    TimerManager:Create(TimerManager.Categories.COMBAT, TIMER_NAME, function()
        self:UpdateTracking()
    end, interval, true)
end

function TBCStatistics:StopTimer()
    if not TimerManager then return end
    TimerManager:Cancel(TimerManager.Categories.COMBAT, TIMER_NAME)
end

function TBCStatistics:RestartTimer()
    self:StopTimer()
    self:StartTimer()
end

-- ============================ TRACKING ============================

function TBCStatistics:ResetStats()
    self.state.entryStats = {}
    for _, entry in ipairs(TRACKED_ENTRIES) do
        self.state.entryStats[entry.key] = {
            activeTime = 0,
            totalTime = 0,
            active = false,
        }
    end
end

function TBCStatistics:UpdateTracking()
    if not self.db.char.enabled then return end
    if not self.state.inCombat then
        self.state.lastUpdate = GetTime()
        return
    end

    local now = GetTime()
    local last = self.state.lastUpdate or now
    local elapsed = max(0, now - last)
    self.state.lastUpdate = now
    if elapsed <= 0 then return end

    self.state.combatTime = (self.state.combatTime or 0) + elapsed

    local playerBuffs = buildAuraPresence("player", "buff", self.state.auraPresence.playerBuffs)
    local targetActive = NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target")
    local targetDebuffs = targetActive and buildAuraPresence("target", "debuff", self.state.auraPresence.targetDebuffs) or nil
    if not targetActive then
        wipe(self.state.auraPresence.targetDebuffs)
    end

    for _, entry in ipairs(TRACKED_ENTRIES) do
        local stats = self.state.entryStats[entry.key]
        if stats then
            local applicable = (entry.unit == "player") or targetActive
            if applicable then
                stats.totalTime = stats.totalTime + elapsed
                local presence = (entry.unit == "player") and playerBuffs or targetDebuffs
                local active = anyAuraActive(entry.spellIds, presence)
                if active then
                    stats.activeTime = stats.activeTime + elapsed
                end
                stats.active = active
            else
                stats.active = false
            end
        end
    end
end

-- ============================ REPORTING ============================

function TBCStatistics:ReportUptime(reportData, prefix)
    local data = reportData or snapshotReport(self.state)
    if not data then return end

    local combatTime = data.combatTime or 0
    local header = prefix and (prefix .. " - ") or ""
    print(format("|cFF00FF00%sTBC Uptime Report|r (combat: %.1fs)", header, combatTime))

    local pctFormat = "%." .. REPORT_PERCENT_PRECISION .. "f"
    local secFormat = "%." .. REPORT_SECONDS_PRECISION .. "f"
    for _, entry in ipairs(TRACKED_ENTRIES) do
        local stats = data.entries and data.entries[entry.key]
        local total = stats and stats.totalTime or 0
        local active = stats and stats.activeTime or 0
        local pct = (total > 0) and (active / total * 100) or 0
        local pctRounded = roundToPrecision(pct, REPORT_PERCENT_PRECISION)
        local activeRounded = roundToPrecision(active, REPORT_SECONDS_PRECISION)
        local totalRounded = roundToPrecision(total, REPORT_SECONDS_PRECISION)
        print(format(" - %s: " .. pctFormat .. "%% (" .. secFormat .. "s / " .. secFormat .. "s) [%s -> %s]",
            entry.name,
            pctRounded,
            activeRounded,
            totalRounded,
            entry.unit,
            entry.auraType
        ))
    end
end

-- ============================ UPTIME TRACKER INTEGRATION ============================

function TBCStatistics:EnsureUptimeTrackerTimeline()
    if not self.db.char.configureUptimeTracker then return end
    local UptimeTracker = NAG:GetModule("UptimeTracker", true)
    if not UptimeTracker or not UptimeTracker.GetTimelines then return end

    local timelineName = self.db.char.uptimeTimelineName or DEFAULT_TIMELINE_NAME
    local timelines = UptimeTracker:GetTimelines()
    for _, t in ipairs(timelines) do
        if t and t.name == timelineName then
            return
        end
    end

    local trackingConfigs = {}
    for _, entry in ipairs(TRACKED_ENTRIES) do
        for i = 1, #entry.spellIds do
            tinsert(trackingConfigs, {
                id = entry.spellIds[i],
                type = entry.auraType,
                unit = entry.unit,
                matchByName = true,
            })
        end
    end

    UptimeTracker:AddTimeline({
        name = timelineName,
        enabled = true,
        trackingConfigs = trackingConfigs,
    })
end

-- ============================ OPTIONS ============================

function TBCStatistics:GetOptions()
    return {
        type = "group",
        name = "TBC Statistics",
        desc = "Track uptime of core TBC raid buffs and debuffs.",
        order = 40,
        args = {
            enabled = OptionsFactory:CreateToggle(
                "Enabled",
                "Enable TBC statistics tracking",
                function() return self.db.char.enabled end,
                function(_, value)
                    self.db.char.enabled = value
                    if value then
                        self:Enable()
                    else
                        self:Disable()
                    end
                end,
                { order = 1 }
            ),
            reportOnCombatEnd = OptionsFactory:CreateToggle(
                "Report on combat end",
                "Print uptime summary when combat ends",
                function() return self.db.char.reportOnCombatEnd end,
                function(_, value) self.db.char.reportOnCombatEnd = value end,
                { order = 2 }
            ),
            updateInterval = OptionsFactory:CreateRange(
                "Update interval (sec)",
                "How often to sample auras for uptime (seconds).",
                function() return self.db.char.updateInterval end,
                function(_, value)
                    self.db.char.updateInterval = value
                    self:RestartTimer()
                end,
                { min = 0.05, max = 1.0, step = 0.05, order = 3 }
            ),
            configureUptimeTracker = OptionsFactory:CreateToggle(
                "Configure Uptime Tracker timeline",
                "Create a timeline in the Uptime Tracker UI for these auras (if enabled).",
                function() return self.db.char.configureUptimeTracker end,
                function(_, value)
                    self.db.char.configureUptimeTracker = value
                    if value then
                        self:EnsureUptimeTrackerTimeline()
                    end
                end,
                { order = 4 }
            ),
            uptimeTimelineName = OptionsFactory:CreateInput(
                "Timeline name",
                "Name for the Uptime Tracker timeline (if created).",
                function() return self.db.char.uptimeTimelineName end,
                function(_, value) self.db.char.uptimeTimelineName = value end,
                { order = 5 }
            ),
            reportNow = OptionsFactory:CreateExecute(
                "Report now",
                "Print the current or last combat uptime report.",
                function()
                    if self.state.inCombat then
                        self:ReportUptime(snapshotReport(self.state), "Combat active")
                    elseif self.state.lastReport then
                        self:ReportUptime(self.state.lastReport, "Last combat")
                    else
                        self:ReportUptime(snapshotReport(self.state), "No combat data")
                    end
                end,
                { order = 6 }
            ),
            resetStats = OptionsFactory:CreateExecute(
                "Reset stats",
                "Reset tracked uptime statistics for the current combat window.",
                function()
                    self:ResetStats()
                    self.state.combatTime = 0
                    self.state.lastReport = nil
                    print("|cFFFFAA00TBCStatistics: stats reset.|r")
                end,
                { order = 7 }
            ),
        }
    }
end

-- ============================ SLASH COMMANDS ============================

function TBCStatistics:HandleSlash(input)
    local cmd = (input and input:lower()) or ""
    if cmd == "" or cmd == "report" then
        if self.state.inCombat then
            self:ReportUptime(snapshotReport(self.state), "Combat active")
        elseif self.state.lastReport then
            self:ReportUptime(self.state.lastReport, "Last combat")
        else
            self:ReportUptime(snapshotReport(self.state), "No combat data")
        end
        return
    end
    if cmd == "reset" then
        self:ResetStats()
        self.state.combatTime = 0
        self.state.lastReport = nil
        print("|cFFFFAA00TBCStatistics: stats reset.|r")
        return
    end
    if cmd == "timeline" then
        self:EnsureUptimeTrackerTimeline()
        print("|cFF00FF00TBCStatistics: timeline ensured (if UptimeTracker is enabled).|r")
        return
    end
    print("|cFFFFAA00Usage: /tbcstats [report|reset|timeline]|r")
end

