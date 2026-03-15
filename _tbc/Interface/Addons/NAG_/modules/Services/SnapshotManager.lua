--- @module "NAG.SnapshotManager"
--- Captures and stores game state snapshots for debugging purposes.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas, @Smufrik
--- Discord: https://discord.gg/ebonhold
--

-- ============================ LOCALIZE ============================

local _, ns = ...
local WoWAPI = ns.WoWAPI

-- ============================ ADDON ACCESS ============================

--- @type NAG Main addon reference
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ LIBRARY ACCESS ============================

local L = ns.AceLocale:GetLocale("NAG", true)

-- ============================ UTILITY MODULE ACCESS ============================

local TableUtils = ns.TableUtils
local StringUtil = ns.StringUtil
local Version = ns.Version

-- ============================ MODULE DECLARATIONS ============================

--- @type SpecCompat
local SpecCompat

-- ============================ LUA API LOCALIZATION ============================

local format = string.format
local floor = math.floor
local min = math.min
local max = math.max
local date = date
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber

-- Table operations
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local concat = table.concat
local sort = table.sort

-- WoW APIs
local GetTime = _G.GetTime
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitPowerType = _G.UnitPowerType
local UnitExists = _G.UnitExists
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitGUID = _G.UnitGUID
local UnitName = _G.UnitName
local UnitClass = _G.UnitClass
local UnitLevel = _G.UnitLevel
local UnitRace = _G.UnitRace
local UnitClassification = _G.UnitClassification
local UnitBuff = _G.UnitBuff
local UnitDebuff = _G.UnitDebuff
local GetSpellCooldown = _G.GetSpellCooldown

-- ============================ CONSTANTS ============================

local MAX_SNAPSHOTS = 15
local SNAPSHOT_VERSION = 2
local MAX_CAST_HISTORY = 50 -- expanded to show more casts per snapshot

-- Resource type names for formatting
local POWER_TYPE_NAMES = {
    [0] = "Mana",
    [1] = "Rage",
    [2] = "Focus",
    [3] = "Energy",
    [4] = "Combo Points",
    [5] = "Runes",
    [6] = "Runic Power",
    [7] = "Soul Shards",
    [8] = "Astral Power",
    [9] = "Holy Power",
    [11] = "Maelstrom",
    [12] = "Chi",
    [13] = "Insanity",
    [16] = "Arcane Charges",
    [17] = "Fury",
    [18] = "Pain",
}

-- Simple name normalizer for gear output (Hekili-style snake case)
local function sanitizeName(name)
    if not name or name == "" then
        return "unknown"
    end
    return name:lower():gsub("[^a-z0-9]+", "_"):gsub("^_+", ""):gsub("_+$", "")
end

-- ============================ MODULE DEFAULTS ============================

local defaults = {
    global = {
        autoSnapshotOnNoRecommendation = true,
        autoSnapshotOnError = true,
        collectDebugMessages = true, -- Collect warnings/errors for snapshots
        maxSnapshots = MAX_SNAPSHOTS,
    },
    char = {
        enabled = true,
    },
}

-- ============================ MODULE CREATION ============================

--- @class SnapshotManager: CoreModule
local SnapshotManager = NAG:CreateModule("SnapshotManager", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    optionsOrder = 85,

    -- Message handlers
    messageHandlers = {
        NAG_NO_RECOMMENDATION = "OnNoRecommendation",
        NAG_ROTATION_ERROR = "OnRotationError",
        NAG_WARNING = "OnWarning",
        NAG_ERROR = "OnError",
        APLMonitor_TickComplete = "OnTickComplete",
    },

    -- Slash commands
    slashCommands = {
        ["snapshot"] = {
            handler = "HandleSnapshotCommand",
            help = "Take a snapshot of current game state for debugging. Use 'list' or 'clear' as argument.",
            root = "nagdebug",
            category = "Debug"
        },
    },

    -- Debug categories
    debugCategories = {
        ns.DEBUG_CATEGORIES.DEBUG,
        ns.DEBUG_CATEGORIES.FEATURES,
    },

    -- Default state
    defaultState = {
        lastSnapshotTime = 0,
        selectedSnapshotIndex = 0,
    },
})

ns.SnapshotManager = SnapshotManager

-- ============================ MODULE VARIABLES ============================

-- In-memory snapshot storage (not persisted to WTF)
SnapshotManager.snapshots = {}

-- Current evaluation trace (populated during APL evaluation)
SnapshotManager.currentTrace = {}

-- Last APL evaluation tick data (from APLMonitorFeed)
SnapshotManager.lastTickData = nil

-- Cast history tracking
SnapshotManager.castHistory = {}

-- Combat start tracking (fallback if NAG.combatStartTime not set)
SnapshotManager.combatStartTime = nil

-- Warning/error collector (max 30 entries)
SnapshotManager.warnings = {}
local MAX_WARNINGS = 30

-- ============================ LIFECYCLE METHODS ============================

function SnapshotManager:ModuleInitialize()
    -- Initialize empty snapshots array
    self.snapshots = {}
    self.currentTrace = {}
    self.castHistory = {}
    self.combatStartTime = nil
    self.warnings = {}
end

function SnapshotManager:ModuleEnable()
    SpecCompat = NAG:GetModule("SpecCompat")
    self:Debug("SnapshotManager enabled - ready to capture snapshots")

    -- Register for spellcast events to track cast history
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "OnSpellCastSucceeded")

    -- Track combat state to timestamp casts
    self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnEnterCombat")
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnLeaveCombat")
end

function SnapshotManager:ModuleDisable()
    -- Clear trace data on disable
    wipe(self.currentTrace)
    wipe(self.castHistory)

    -- Unregister events
    self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    self:UnregisterEvent("PLAYER_REGEN_DISABLED")
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
end

-- ============================ CAST HISTORY TRACKING ============================

function SnapshotManager:OnEnterCombat()
    self.combatStartTime = GetTime()
    -- Clear cast history at combat start for fresh data
    wipe(self.castHistory)
end

function SnapshotManager:OnLeaveCombat()
    self.combatStartTime = nil
    -- Keep cast history after combat so snapshots can be taken post-fight
end

--- Handler for UNIT_SPELLCAST_SUCCEEDED event
--- @param event string The event name
--- @param unit string The unit that cast the spell
--- @param castGUID string The cast GUID (MoP uses different args)
--- @param spellID number The spell ID that was cast
function SnapshotManager:OnSpellCastSucceeded(event, unit, castGUID, spellID)
    -- Only track player casts
    if unit ~= "player" then return end

    -- Only track casts while in combat
    if not UnitAffectingCombat("player") then return end

    -- MoP event args: unit, castGUID, spellID (or could be unit, spellID depending on version)
    -- Handle both arg formats
    local actualSpellID = spellID
    if type(castGUID) == "number" then
        actualSpellID = castGUID
    end

    if not actualSpellID or actualSpellID == 0 then return end

    -- Get spell name (WoWAPI returns table in unified API)
    local spellInfo = WoWAPI.GetSpellInfo(actualSpellID)
    local spellName = nil
    if type(spellInfo) == "table" then
        spellName = spellInfo.name or spellInfo.spellName or spellInfo[1]
    elseif type(spellInfo) == "string" then
        spellName = spellInfo
    end
    if not spellName then
        spellName = tostring(actualSpellID)
    end

    -- Determine combat-relative time
    local now = GetTime()
    local combatStart = self.combatStartTime or NAG.combatStartTime
    if not combatStart then
        combatStart = now
        self.combatStartTime = combatStart
    end
    local combatTime = max(0, now - combatStart)

    -- Record the cast
    local castEntry = {
        spellID = actualSpellID,
        spellName = spellName,
        timestamp = now,
        combatTime = combatTime,
    }

    tinsert(self.castHistory, 1, castEntry)

    -- Trim history to max size
    while #self.castHistory > MAX_CAST_HISTORY do
        tremove(self.castHistory)
    end
end

--- Get recent cast history
--- @return table castHistory Array of recent casts
function SnapshotManager:GetCastHistory()
    return self.castHistory or {}
end

--- Clear cast history
function SnapshotManager:ClearCastHistory()
    wipe(self.castHistory)
end

-- ============================ STATE CAPTURE FUNCTIONS ============================

--- Capture all player auras (buffs and debuffs)
--- @return table playerBuffs, table playerDebuffs
function SnapshotManager:CapturePlayerAuras()
    local buffs = {}
    local debuffs = {}
    local now = GetTime()

    -- Capture buffs using raw WoW API (UnitBuff returns: name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, ...)
    for i = 1, 40 do
        local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId = UnitBuff("player", i)
        if not name then break end

        tinsert(buffs, {
            id = spellId or 0,
            name = name,
            stacks = count or 1,
            remaining = expirationTime and expirationTime > 0 and (expirationTime - now) or 0,
            duration = duration or 0,
            source = source or "unknown",
        })
    end

    -- Capture debuffs using raw WoW API
    for i = 1, 40 do
        local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId = UnitDebuff("player", i)
        if not name then break end

        tinsert(debuffs, {
            id = spellId or 0,
            name = name,
            stacks = count or 1,
            remaining = expirationTime and expirationTime > 0 and (expirationTime - now) or 0,
            duration = duration or 0,
            source = source or "unknown",
        })
    end

    return buffs, debuffs
end

--- Capture target auras (buffs and debuffs)
--- @return table targetBuffs, table targetDebuffs
function SnapshotManager:CaptureTargetAuras()
    local buffs = {}
    local debuffs = {}

    if not UnitExists("target") then
        return buffs, debuffs
    end

    local now = GetTime()
    local playerGUID = NAG.state.player.guid

    -- Capture target buffs using raw WoW API
    for i = 1, 40 do
        local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId = UnitBuff("target", i)
        if not name then break end

        local isPlayerAura = source and UnitGUID(source) == playerGUID
        tinsert(buffs, {
            id = spellId or 0,
            name = name,
            stacks = count or 1,
            remaining = expirationTime and expirationTime > 0 and (expirationTime - now) or 0,
            duration = duration or 0,
            isPlayerAura = isPlayerAura or false,
        })
    end

    -- Capture target debuffs (all debuffs, marked with source)
    for i = 1, 40 do
        local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId = UnitDebuff("target", i)
        if not name then break end

        local isPlayerAura = source and UnitGUID(source) == playerGUID
        tinsert(debuffs, {
            id = spellId or 0,
            name = name,
            stacks = count or 1,
            remaining = expirationTime and expirationTime > 0 and (expirationTime - now) or 0,
            duration = duration or 0,
            isPlayerAura = isPlayerAura or false,
            source = source or "unknown",
        })
    end

    return buffs, debuffs
end

--- Capture player resources
--- @return table resources
function SnapshotManager:CaptureResources()
    local resources = {}

    -- Get primary resource (mana, rage, energy, etc.)
    local powerType = UnitPowerType("player")
    local primaryPower = UnitPower("player")
    local primaryPowerMax = UnitPowerMax("player")

    resources.primary = {
        type = POWER_TYPE_NAMES[powerType] or "Unknown",
        powerType = powerType,
        current = primaryPower,
        max = primaryPowerMax,
        percent = primaryPowerMax > 0 and floor((primaryPower / primaryPowerMax) * 100) or 0,
    }

    -- Capture health
    local health = UnitHealth("player")
    local healthMax = UnitHealthMax("player")
    resources.health = {
        current = health,
        max = healthMax,
        percent = healthMax > 0 and floor((health / healthMax) * 100) or 0,
    }

    -- Capture secondary resources if applicable
    local secondaryPowers = { 4, 5, 6, 9, 12 } -- Combo Points, Runes, Runic Power, Holy Power, Chi
    for _, pt in ipairs(secondaryPowers) do
        local power = UnitPower("player", pt)
        local powerMax = UnitPowerMax("player", pt)
        if powerMax > 0 then
            local name = POWER_TYPE_NAMES[pt] or ("Power" .. pt)
            resources[name:lower():gsub(" ", "_")] = {
                type = name,
                current = power,
                max = powerMax,
            }
        end
    end

    return resources
end

--- Capture player talents using unified APIs across TBC and MoP
--- @return table talents
function SnapshotManager:CaptureTalents()
    local talents = {}

    -- Use SpecCompat for talent info (already declared at module level)

    -- MoP (6 tiers, 3 columns)
    if Version and Version:IsMists() then
        for tier = 1, 6 do
            for column = 1, 3 do
                local talentIndex = (tier - 1) * 3 + column
                local talentInfo = SpecCompat:GetTalentInfo(nil, talentIndex, false, false, nil)
                if type(talentInfo) == "table" then
                    local name = talentInfo.name or talentInfo[1]
                    local selected = talentInfo.selected or talentInfo.isSelected
                    local spellID = talentInfo.spellID or talentInfo.talentID or talentInfo.id
                    tinsert(talents, {
                        name = name or format("Tier%dCol%d", tier, column),
                        selected = selected and true or false,
                        spellID = spellID or 0,
                        tier = talentInfo.tier or tier,
                        column = talentInfo.column or column,
                    })
                end
            end
        end
        return talents
    end

    -- TBC/Classic-style talent trees: iterate tabs/trees
    local numTabs = SpecCompat:GetNumTalentTabs() or 0
    for tabIndex = 1, numTabs do
        local numTalents = SpecCompat:GetNumTalents(tabIndex) or 0
        for talentIndex = 1, numTalents do
            local talentInfo = SpecCompat:GetTalentInfo(tabIndex, talentIndex, false, false, nil)
            if type(talentInfo) == "table" then
                tinsert(talents, {
                    name = talentInfo.name or format("Tab%dTalent%d", tabIndex, talentIndex),
                    rank = talentInfo.rank or 0,
                    maxRank = talentInfo.maxRank or 0,
                    tier = talentInfo.tier or 0,
                    column = talentInfo.column or 0,
                    meetsPrereq = talentInfo.meetsPrereq,
                    talentID = talentInfo.talentID or 0,
                    tabIndex = tabIndex,
                    talentIndex = talentIndex,
                })
            end
        end
    end

    -- Fallback: if no talents captured, try direct legacy API scan (up to 3 tabs, 30 talents each)
    if #talents == 0 and _G.GetTalentInfo then
        for tabIndex = 1, 3 do
            for talentIndex = 1, 30 do
                local ok, name, icon, tier, column, rank, maxRank, meetsPrereq, previewRank, meetsPreviewPrereq, isExceptional, hasGoldBorder, talentID = pcall(_G.GetTalentInfo, tabIndex, talentIndex, false, false, nil)
                if ok and name then
                    tinsert(talents, {
                        name = name,
                        rank = rank or 0,
                        maxRank = maxRank or 0,
                        tier = tier or 0,
                        column = column or 0,
                        meetsPrereq = meetsPrereq,
                        talentID = talentID or 0,
                        tabIndex = tabIndex,
                        talentIndex = talentIndex,
                    })
                else
                    break
                end
            end
        end
    end

    return talents
end

--- Capture equipped gear and a flat itemID list
--- @return table gear
--- @return table itemIDs
function SnapshotManager:CaptureGear()
    local gear = {}
    local itemIDs = {}

    for slot = 1, 19 do
        local itemId = GetInventoryItemID and GetInventoryItemID("player", slot)
        if itemId and itemId > 0 then
            local itemInfo = WoWAPI.GetItemInfo and WoWAPI.GetItemInfo(itemId)
            local itemName = nil

            if type(itemInfo) == "table" then
                itemName = itemInfo.name or itemInfo[1]
            elseif type(itemInfo) == "string" then
                itemName = itemInfo
            end

            tinsert(gear, {
                slot = slot,
                id = itemId,
                name = sanitizeName(itemName or ("item_" .. itemId)),
                rawName = itemName or tostring(itemId),
            })
            tinsert(itemIDs, itemId)
        end
    end

    sort(gear, function(a, b) return (a.slot or 99) < (b.slot or 99) end)
    return gear, itemIDs
end

--- Capture spell cooldowns from current rotation spells
--- @return table cooldowns
function SnapshotManager:CaptureCooldowns()
    local cooldowns = {}
    local now = GetTime()

    -- Get spells from current rotation data
    local ClassModule = NAG:GetClassModule()
    if not ClassModule then return cooldowns end

    local rotation = ClassModule:GetCurrentRotation()
    if not rotation or not rotation.spells then return cooldowns end

    -- Check cooldowns for rotation spells
    for _, spellId in ipairs(rotation.spells) do
        if type(spellId) == "number" and spellId > 0 then
            local cdInfo = WoWAPI.GetSpellCooldown(spellId)
            if cdInfo then
                local startTime = cdInfo.startTime or 0
                local duration = cdInfo.duration or 0
                local remaining = 0

                if startTime > 0 and duration > 0 then
                    remaining = max(0, (startTime + duration) - now)
                end

                -- Include spells with real cooldowns (not just GCD)
                if duration > 1.5 then
                    local spellInfo = WoWAPI.GetSpellInfo(spellId)
                    local spellName = spellInfo and spellInfo.name or tostring(spellId)

                    -- Check for charges
                    local chargeInfo = WoWAPI.GetSpellCharges(spellId)
                    local charges = chargeInfo and chargeInfo.currentCharges
                    local maxCharges = chargeInfo and chargeInfo.maxCharges

                    cooldowns[spellId] = {
                        id = spellId,
                        name = spellName,
                        remaining = remaining,
                        duration = duration,
                        charges = charges,
                        maxCharges = maxCharges,
                    }
                end
            end
        end
    end

    return cooldowns
end

--- Capture combat context
--- @return table context
function SnapshotManager:CaptureContext()
    local context = {
        timestamp = GetTime(),
        dateTime = date("%Y-%m-%d %H:%M:%S"),
        inCombat = UnitAffectingCombat("player") or false,
        targetExists = UnitExists("target") or false,
    }

    -- NAG Version info (use ns.Version namespace table, not Ace3 module)
    local Version = ns.Version
    if Version then
        local versionInfo = Version:GetVersionInfo()
        if versionInfo then
            context.expansion = versionInfo.expansion or "Unknown"
            context.gameType = versionInfo.gameType or "Unknown"
            context.interfaceVersion = versionInfo.interfaceVersion or 0
        end
    end

    -- Addon version from metadata
    context.nagVersion = WoWAPI.GetAddOnMetadata("NAG", "Version") or "Unknown"

    -- Player info
    local _, className = UnitClass("player")
    local _, race = UnitRace("player")
    context.className = className
    context.race = race
    context.playerName = UnitName("player")
    context.playerLevel = UnitLevel("player")
    context.playerGUID = UnitGUID("player")
    context.playerHealth = UnitHealth("player")
    context.playerHealthMax = UnitHealthMax("player")
    context.playerHealthPercent = context.playerHealthMax > 0 and
        floor((context.playerHealth / context.playerHealthMax) * 100) or 0

    -- Specialization info using SpecCompat (handles version differences)
    local specIndex = nil
    local specName = nil
    local specID = nil

    if SpecCompat then
        specIndex = SpecCompat:GetCurrentSpecIndex()
        if specIndex and specIndex > 0 then
            local specInfo = SpecCompat:GetSpecInfo(specIndex)
            if specInfo then
                specName = specInfo.name
                specID = specInfo.specID
            end
        end
    end

    context.specIndex = specIndex or 0
    context.specID = specID or 0
    context.specName = specName or "None"

    -- Fallback: if specName is missing (e.g., API unavailable), use current rotation metadata
    if not context.specName or context.specName == "None" or context.specIndex == 0 then
        local ClassModule = NAG:GetClassModule()
        if ClassModule then
            local rotation = ClassModule:GetCurrentRotation()
            if rotation then
                context.specIndex = rotation.specIndex or context.specIndex or 0
                context.specName = rotation.name or context.specName or "Unknown"
            end
        end
        if not context.specName or context.specName == "None" then
            context.specName = "Unknown"
        end
    end

    -- Combat time
    if context.inCombat and NAG.combatStartTime then
        context.combatTime = GetTime() - NAG.combatStartTime
    else
        context.combatTime = 0
    end

    -- GCD info (use version-aware probe spell via centralized helper)
    context.gcdRemaining = (NAG and NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0

    -- Target info
    if context.targetExists then
        context.targetName = UnitName("target")
        context.targetGUID = UnitGUID("target")
        context.targetHealth = UnitHealth("target")
        context.targetHealthMax = UnitHealthMax("target")
        context.targetHealthPercent = context.targetHealthMax > 0 and
            floor((context.targetHealth / context.targetHealthMax) * 100) or 0
        context.targetLevel = UnitLevel("target")

        -- Target classification
        local classification = UnitClassification("target")
        context.targetClassification = classification
    end

    -- Number of targets (from TTDManager if available)
    local TTDManager = NAG:GetModule("TTDManager", true)
    if TTDManager and TTDManager.GetTargetCount then
        context.activeEnemies = TTDManager:GetTargetCount() or 1
    else
        context.activeEnemies = 1
    end

    -- Get current rotation info
    local ClassModule = NAG:GetClassModule()
    if ClassModule then
        local rotation = ClassModule:GetCurrentRotation()
        if rotation then
            context.rotationName = rotation.name or "Unknown"
            context.rotationAuthor = rotation.author
            context.rotationLastModified = rotation.lastModified
        end
    end

    -- Settings snapshot
    context.settings = {}
    if NAG.db and NAG.db.char then
        context.settings.devMode = NAG:IsDevModeEnabled() or false
    end

    return context
end

--- Capture event queue - future scheduled events
--- @return table eventQueue Array of upcoming events sorted by time
function SnapshotManager:CaptureEventQueue()
    local events = {}
    local now = GetTime()

    -- 1. Aura expirations from player buffs
    local playerBuffs, playerDebuffs = self:CapturePlayerAuras()
    for _, buff in ipairs(playerBuffs) do
        if buff.remaining and buff.remaining > 0 and buff.remaining < 30 then
            tinsert(events, {
                action = sanitizeName(buff.name or "buff"),
                type = "BUFF_EXPIRATION",
                time = buff.remaining,
                triggers = "player buff expires",
                spellId = buff.id,
            })
        end
    end

    -- 2. Aura expirations from target debuffs (player-applied)
    local targetBuffs, targetDebuffs = self:CaptureTargetAuras()
    for _, debuff in ipairs(targetDebuffs) do
        if debuff.isPlayerAura and debuff.remaining and debuff.remaining > 0 and debuff.remaining < 30 then
            tinsert(events, {
                action = sanitizeName(debuff.name or "debuff"),
                type = "AURA_EXPIRATION",
                time = debuff.remaining,
                triggers = "debuff expires on target",
                spellId = debuff.id,
            })
        end
    end

    -- 3. Cooldowns becoming ready
    local cooldowns = self:CaptureCooldowns()
    for spellId, cd in pairs(cooldowns) do
        if cd.remaining and cd.remaining > 0 and cd.remaining < 120 then
            tinsert(events, {
                action = sanitizeName(cd.name or "cooldown"),
                type = "COOLDOWN_READY",
                time = cd.remaining,
                triggers = "ability becomes usable",
                spellId = spellId,
            })
        end
    end

    -- 4. Trinket ICDs (via TrinketTrackingManager if available)
    local TrinketTrackingManager = NAG:GetModule("TrinketTrackingManager", true)
    if TrinketTrackingManager and TrinketTrackingManager.GetTrinketState then
        for slot = 13, 14 do
            local trinketState = TrinketTrackingManager:GetTrinketState(slot)
            if trinketState and trinketState.icdRemaining and trinketState.icdRemaining > 0 then
                tinsert(events, {
                    action = sanitizeName(trinketState.name or format("trinket_%d", slot)),
                    type = "TRINKET_ICD_READY",
                    time = trinketState.icdRemaining,
                    triggers = "trinket ICD expires",
                    spellId = trinketState.itemId or 0,
                })
            end
        end
    end

    -- 5. GCD completion
    local gcdRemaining = (NAG and NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
    if gcdRemaining > 0 then
        tinsert(events, {
            action = "gcd",
            type = "GCD_COMPLETE",
            time = gcdRemaining,
            triggers = "GCD ends",
            spellId = 0,
        })
    end

    -- 6. Current cast/channel completion
    local castInfo = nil
    if _G.UnitCastingInfo then
        local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = _G.UnitCastingInfo("player")
        if name and endTimeMS then
            local remaining = (endTimeMS / 1000) - now
            if remaining > 0 then
                tinsert(events, {
                    action = sanitizeName(name),
                    type = "CAST_COMPLETE",
                    time = remaining,
                    triggers = "cast finishes",
                    spellId = spellId or 0,
                })
            end
        end
    end
    if _G.UnitChannelInfo then
        local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, notInterruptible, spellId = _G.UnitChannelInfo("player")
        if name and endTimeMS then
            local remaining = (endTimeMS / 1000) - now
            if remaining > 0 then
                tinsert(events, {
                    action = sanitizeName(name),
                    type = "CHANNEL_COMPLETE",
                    time = remaining,
                    triggers = "channel finishes",
                    spellId = spellId or 0,
                })
            end
        end
    end

    -- Sort by time
    sort(events, function(a, b) return (a.time or 0) < (b.time or 0) end)

    return events
end

--- Capture toggle states from various managers
--- @return table toggles
function SnapshotManager:CaptureToggleStates()
    local toggles = {}

    -- Core toggles
    toggles.enabled = NAG.db and NAG.db.char and NAG.db.char.enabled
    toggles.devMode = NAG:IsDevModeEnabled() or false

    -- Display toggles
    local DisplayManager = NAG:GetModule("DisplayManager", true)
    if DisplayManager then
        toggles.displayEnabled = DisplayManager:IsEnabled()
        if DisplayManager.db and DisplayManager.db.char then
            toggles.cooldownsEnabled = DisplayManager.db.char.showCooldowns
            toggles.interruptsEnabled = DisplayManager.db.char.showInterrupts
            toggles.defensivesEnabled = DisplayManager.db.char.showDefensives
        end
    end

    -- Rotation toggles (class-specific)
    local ClassModule = NAG:GetClassModule()
    if ClassModule and ClassModule.GetToggles then
        toggles.classToggles = ClassModule:GetToggles()
    elseif ClassModule and ClassModule.toggles then
        -- Fallback: direct access to toggles table if method doesn't exist
        toggles.classToggles = ClassModule.toggles
    end

    -- AOE mode toggle (common across classes)
    if NAG.state and NAG.state.toggles then
        toggles.aoe = NAG.state.toggles.aoe
        toggles.cooldowns = NAG.state.toggles.cooldowns
        toggles.defensives = NAG.state.toggles.defensives
        toggles.interrupts = NAG.state.toggles.interrupts
    end

    return toggles
end

--- Capture current recommendation
--- @return table|nil recommendation
function SnapshotManager:CaptureRecommendation()
    local recommendation = { spells = {} }

    -- Helper to collect frames from a table
    local function collectFromFrames(frameTable)
        if not frameTable then return end
        for slotName, frame in pairs(frameTable) do
            if frame and frame.spellId and frame.spellId > 0 then
                tinsert(recommendation.spells, {
                    slot = slotName or "unknown",
                    spellId = frame.spellId,
                    name = self:GetSpellName(frame.spellId),
                })
            end
        end
    end

    if NAG.Frame then
        collectFromFrames(NAG.Frame.iconFrames)       -- main/above/below/etc
        collectFromFrames(NAG.Frame.cooldownFrames)   -- cooldown rows
        collectFromFrames(NAG.Frame.interruptFrames)  -- interrupts
        collectFromFrames(NAG.Frame.defensiveFrames)  -- defensives
        collectFromFrames(NAG.Frame.extraFrames)      -- any extras
    end

    -- Sort by slot name for consistent output
    sort(recommendation.spells, function(a, b)
        return (a.slot or "") < (b.slot or "")
    end)

    return recommendation
end

--- Get spell name from ID
--- @param spellId number
--- @return string
function SnapshotManager:GetSpellName(spellId)
    if not spellId then return "Unknown" end
    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    return spellInfo and spellInfo.name or tostring(spellId)
end

-- ============================ TRACE CAPTURE ============================

--- Start capturing evaluation trace
function SnapshotManager:StartTrace()
    wipe(self.currentTrace)
    self.traceActive = true
end

--- Add a trace entry during APL evaluation
--- @param lineNum number Line number in rotation
--- @param condition string The condition being evaluated
--- @param result boolean Result of the condition
--- @param reason string|nil Optional reason for result
function SnapshotManager:AddTraceEntry(lineNum, condition, result, reason)
    if not self.traceActive then return end

    tinsert(self.currentTrace, {
        line = lineNum,
        condition = condition,
        result = result,
        reason = reason or "",
    })
end

--- Stop trace capture and return captured data
--- @return table trace
function SnapshotManager:StopTrace()
    self.traceActive = false
    local trace = {}
    for i, entry in ipairs(self.currentTrace) do
        trace[i] = entry
    end
    return trace
end

--- Get current trace (copy)
--- @return table trace
function SnapshotManager:GetCurrentTrace()
    local trace = {}
    for i, entry in ipairs(self.currentTrace) do
        trace[i] = entry
    end
    return trace
end

-- ============================ SNAPSHOT CREATION ============================

--- Take a full snapshot of current game state
--- @param trigger string|nil What triggered the snapshot (manual, auto, error)
--- @return table|nil snapshot The created snapshot or nil on failure
function SnapshotManager:TakeSnapshot(trigger)
    trigger = trigger or "manual"

    -- Capture all state
    local playerBuffs, playerDebuffs = self:CapturePlayerAuras()
    local targetBuffs, targetDebuffs = self:CaptureTargetAuras()
    local resources = self:CaptureResources()
    local cooldowns = self:CaptureCooldowns()
    local talents = self:CaptureTalents()
    local gear, itemIDs = self:CaptureGear()
    local context = self:CaptureContext()
    local toggles = self:CaptureToggleStates()
    local warnings = self:GetWarnings()
    local eventQueue = self:CaptureEventQueue()
    local recommendation = self:CaptureRecommendation()
    local trace = self:GetCurrentTrace()
    local castHistory = self:GetCastHistory()

    -- Include APLMonitorFeed tick data if available
    local tickData = self.lastTickData
    if tickData then
        context.tickId = tickData.tickId
        context.evaluationMode = tickData.evaluationMode
        context.evaluationDuration = tickData.totalDuration
        context.nodeCount = tickData.nodeCount
    end

    -- Build header
    local recText = "No recommendation"
    if recommendation and recommendation.spells and #recommendation.spells > 0 then
        local spellNames = {}
        for _, spell in ipairs(recommendation.spells) do
            if spell.slot == "main" then
                tinsert(spellNames, 1, spell.name)
            else
                tinsert(spellNames, spell.name)
            end
        end
        recText = concat(spellNames, ", ")
    end

    local header = format("[%s] %s - %s (%s)",
        context.dateTime,
        context.rotationName or "Unknown Rotation",
        recText,
        trigger
    )

    -- Create snapshot
    local snapshot = {
        version = SNAPSHOT_VERSION,
        header = header,
        trigger = trigger,
        timestamp = context.timestamp,
        dateTime = context.dateTime,

        state = {
            resources = resources,
            playerBuffs = playerBuffs,
            playerDebuffs = playerDebuffs,
            targetBuffs = targetBuffs,
            targetDebuffs = targetDebuffs,
            cooldowns = cooldowns,
            talents = talents,
            gear = gear,
            toggles = toggles,
        },

        evaluation = {
            rotationName = context.rotationName,
            trace = trace,
            recommendation = recommendation,
        },

        -- Recent cast history
        castHistory = castHistory,

        -- Recent warnings/errors
        warnings = warnings,

        -- Upcoming events
        eventQueue = eventQueue,

        context = context,
        itemIDs = itemIDs,

        -- Pre-generate export string
        exportString = nil, -- Will be generated lazily
    }

    -- Store snapshot (FIFO)
    tinsert(self.snapshots, snapshot)
    local maxSnaps = self.db.global.maxSnapshots or MAX_SNAPSHOTS
    while #self.snapshots > maxSnaps do
        tremove(self.snapshots, 1)
    end

    self.state.lastSnapshotTime = GetTime()
    self.state.selectedSnapshotIndex = #self.snapshots

    self:Info("Snapshot #%d captured: %s", #self.snapshots, header)
    if self.Print then
        self:Print(format("Snapshot #%d captured (%s)", #self.snapshots, trigger))
    end

    return snapshot
end

-- ============================ MESSAGE HANDLERS ============================

--- Handle APL evaluation tick completion (from APLMonitorFeed)
--- @param message string Message name
--- @param tickData table Tick data from APLMonitorFeed
function SnapshotManager:OnTickComplete(message, tickData)
    if not tickData then return end

    -- Store the last tick data for snapshot capture
    self.lastTickData = tickData

    -- Convert tick nodes to trace format
    wipe(self.currentTrace)
    if tickData.nodes then
        local lineNum = 0
        for i, nodeInfo in ipairs(tickData.nodes) do
            lineNum = lineNum + 1

            -- Extract condition/action text from node data
            local conditionText = "unknown"
            local spellInfo = nil

            if nodeInfo.data then
                -- Try to get spell info from data
                if nodeInfo.data.funcName then
                    conditionText = nodeInfo.data.funcName
                    if nodeInfo.data.args then
                        local argStr = ""
                        for j, arg in ipairs(nodeInfo.data.args) do
                            if j > 1 then argStr = argStr .. ", " end
                            argStr = argStr .. tostring(arg)
                        end
                        if argStr ~= "" then
                            conditionText = conditionText .. "(" .. argStr .. ")"
                        end
                    end
                end

                -- Check for spell ID
                if nodeInfo.data.args and nodeInfo.data.args[1] then
                    local spellId = tonumber(nodeInfo.data.args[1])
                    if spellId then
                        local spellName = WoWAPI.GetSpellInfo(spellId)
                        if spellName then
                            spellInfo = {
                                id = spellId,
                                name = spellName,
                            }
                        end
                    end
                end
            end

            -- Fallback to nodeType if no condition text
            if conditionText == "unknown" then
                conditionText = nodeInfo.nodeType or "node"
            end

            tinsert(self.currentTrace, {
                line = lineNum,
                nodeId = nodeInfo.nodeId or ("node_" .. i),
                nodeType = nodeInfo.nodeType or "unknown",
                condition = conditionText,
                result = nodeInfo.result,
                resultStr = nodeInfo.result == true and "PASS" or (nodeInfo.result == false and "FAIL" or tostring(nodeInfo.result)),
                duration = nodeInfo.duration or 0,
                spell = spellInfo,
                depth = nodeInfo.depth or 0,
                actionList = nodeInfo.actionList or "default",
            })
        end
    end
end

--- Handle no recommendation event
function SnapshotManager:OnNoRecommendation()
    if self.db.global.autoSnapshotOnNoRecommendation then
        self:TakeSnapshot("auto_no_rec")
    end
end

--- Handle rotation error event
function SnapshotManager:OnRotationError()
    if self.db.global.autoSnapshotOnError then
        self:TakeSnapshot("auto_error")
    end
end

--- Handle warning message
--- @param message string Message name
--- @param source string|nil Source module name
--- @param text string|nil Warning text
function SnapshotManager:OnWarning(message, source, text)
    -- Only collect if toggle is enabled
    if not self.db.global.collectDebugMessages then return end

    local warningEntry = {
        timestamp = GetTime(),
        dateTime = date("%H:%M:%S"),
        level = "WARN",
        source = source or "Unknown",
        message = text or message or "",
    }

    tinsert(self.warnings, warningEntry)

    -- Trim to max size (keep most recent)
    while #self.warnings > MAX_WARNINGS do
        tremove(self.warnings, 1)
    end
end

--- Handle error message
--- @param message string Message name
--- @param source string|nil Source module name
--- @param text string|nil Error text
function SnapshotManager:OnError(message, source, text)
    -- Only collect if toggle is enabled
    if not self.db.global.collectDebugMessages then return end

    local errorEntry = {
        timestamp = GetTime(),
        dateTime = date("%H:%M:%S"),
        level = "ERROR",
        source = source or "Unknown",
        message = text or message or "",
    }

    tinsert(self.warnings, errorEntry)

    -- Trim to max size (keep most recent)
    while #self.warnings > MAX_WARNINGS do
        tremove(self.warnings, 1)
    end
end

--- Get recent warnings
--- @return table warnings Array of recent warnings/errors
function SnapshotManager:GetWarnings()
    return self.warnings or {}
end

--- Clear warnings
function SnapshotManager:ClearWarnings()
    wipe(self.warnings)
end

-- ============================ SLASH COMMAND HANDLERS ============================

--- Handle /nag snapshot command with optional subcommands
--- @param input string|nil Optional subcommand: "list", "clear", or empty for take
function SnapshotManager:HandleSnapshotCommand(input)
    input = input and input:lower():trim() or ""

    if input == "list" then
        self:ListSnapshots()
    elseif input == "clear" then
        self:ClearSnapshots()
    else
        -- Default: take a snapshot
        self:TakeSnapshot("manual")
    end
end

--- List all stored snapshots
function SnapshotManager:ListSnapshots()
    if #self.snapshots == 0 then
        self:Info("No snapshots stored. Use '/nag snapshot' to capture one.")
        return
    end

    self:Info("=== Stored Snapshots (%d) ===", #self.snapshots)
    for i, snap in ipairs(self.snapshots) do
        self:Info("#%d: %s", i, snap.header)
    end
end

--- Clear all stored snapshots
function SnapshotManager:ClearSnapshots()
    local count = #self.snapshots
    wipe(self.snapshots)
    self.state.selectedSnapshotIndex = 0
    self:Info("Cleared %d snapshots.", count)
end

-- ============================ FORMATTING ============================

--- Format recommendation summary for header line
--- @param snapshot table The snapshot data
--- @return string summary
function SnapshotManager:FormatRecommendationSummary(snapshot)
    local eval = snapshot and snapshot.evaluation
    local rec = eval and eval.recommendation
    local spells = rec and rec.spells or {}

    if #spells == 0 then
        return "No Recommendation"
    end

    local parts = {}
    for _, spell in ipairs(spells) do
        if spell.name then
            tinsert(parts, spell.name)
        end
    end

    return table.concat(parts, ", ")
end

--- Format a snapshot for export
--- @param snapshot table The snapshot to format
--- @return string exportString
function SnapshotManager:FormatSnapshot(snapshot)
    if not snapshot then return "No snapshot data" end

    -- Use cached export string if available
    if snapshot.exportString then
        return snapshot.exportString
    end

    local lines = {}
    local ctx = snapshot.context or {}
    local state = snapshot.state or {}
    local eval = snapshot.evaluation or {}
    local rec = eval.recommendation or {}
    local spells = rec.spells or {}

    -- Header similar to Hekili snapshot
    local className = (ctx.className or "UNKNOWN"):upper()
    local specName = ctx.specName or "None"
    local rotationName = ctx.rotationName or "Unknown"
    local spellSummary = self:FormatRecommendationSummary(snapshot)

    tinsert(lines, format("%s (%s[%d]); Primary - %s",
        rotationName,
        specName,
        ctx.specIndex or 0,
        spellSummary))
    tinsert(lines, "")

    tinsert(lines, format("build: %s", ctx.nagVersion or "Unknown"))
    tinsert(lines, format("level: %d (%d)", ctx.playerLevel or 0, ctx.playerLevel or 0))
    tinsert(lines, format("class: %s", className))
    tinsert(lines, format("spec: %s", specName:lower()))
    tinsert(lines, "")

    -- Talents
    tinsert(lines, "### Talents ###")
    local talents = state.talents or {}
    if #talents == 0 then
        tinsert(lines, "    (no talents captured)")
    else
        for _, talent in ipairs(talents) do
            local flag = talent.selected and "1/0" or "0/1"
            tinsert(lines, format("    %s = %s", sanitizeName(talent.name or "talent"), flag))
        end
    end
    tinsert(lines, "")

    -- Legacy content placeholder
    tinsert(lines, "### Legacy Content ###")
    tinsert(lines, "legendaries: none")
    tinsert(lines, "")

    -- Gear & Items
    tinsert(lines, "### Gear & Items ###")
    tinsert(lines, "sets:")
    tinsert(lines, "    none")
    tinsert(lines, "")

    tinsert(lines, "gear:")
    local gear = state.gear or {}
    if #gear == 0 then
        tinsert(lines, "    none")
    else
        for _, entry in ipairs(gear) do
            tinsert(lines, format("    %s = 1", entry.name or sanitizeName(entry.rawName)))
        end
    end

    local itemIDs = snapshot.itemIDs or {}
    if #itemIDs > 0 then
        tinsert(lines, "")
        tinsert(lines, "itemIDs: " .. table.concat(itemIDs, ", "))
    end
    tinsert(lines, "")

    -- Settings and toggles (best-effort from context)
    tinsert(lines, "### Settings ###")
    tinsert(lines, "Settings:")
    local settings = ctx.settings or {}
    if next(settings) then
        for k, v in pairs(settings) do
            tinsert(lines, format("    %s = %s", k, tostring(v)))
        end
    else
        tinsert(lines, "    (not captured)")
    end
    tinsert(lines, "")

    tinsert(lines, "### Toggles ###")
    local toggles = state.toggles or {}
    local hasToggles = false
    -- Core toggles
    if toggles.enabled ~= nil then
        tinsert(lines, format("    enabled = %s", tostring(toggles.enabled)))
        hasToggles = true
    end
    if toggles.devMode ~= nil then
        tinsert(lines, format("    devMode = %s", tostring(toggles.devMode)))
        hasToggles = true
    end
    -- Display toggles
    if toggles.displayEnabled ~= nil then
        tinsert(lines, format("    displayEnabled = %s", tostring(toggles.displayEnabled)))
        hasToggles = true
    end
    if toggles.cooldownsEnabled ~= nil then
        tinsert(lines, format("    cooldownsEnabled = %s", tostring(toggles.cooldownsEnabled)))
        hasToggles = true
    end
    if toggles.interruptsEnabled ~= nil then
        tinsert(lines, format("    interruptsEnabled = %s", tostring(toggles.interruptsEnabled)))
        hasToggles = true
    end
    if toggles.defensivesEnabled ~= nil then
        tinsert(lines, format("    defensivesEnabled = %s", tostring(toggles.defensivesEnabled)))
        hasToggles = true
    end
    -- Runtime toggles
    if toggles.aoe ~= nil then
        tinsert(lines, format("    aoe = %s", tostring(toggles.aoe)))
        hasToggles = true
    end
    if toggles.cooldowns ~= nil then
        tinsert(lines, format("    cooldowns = %s", tostring(toggles.cooldowns)))
        hasToggles = true
    end
    if toggles.defensives ~= nil then
        tinsert(lines, format("    defensives = %s", tostring(toggles.defensives)))
        hasToggles = true
    end
    if toggles.interrupts ~= nil then
        tinsert(lines, format("    interrupts = %s", tostring(toggles.interrupts)))
        hasToggles = true
    end
    -- Class-specific toggles
    if toggles.classToggles and type(toggles.classToggles) == "table" then
        for k, v in pairs(toggles.classToggles) do
            tinsert(lines, format("    %s = %s", tostring(k), tostring(v)))
            hasToggles = true
        end
    end
    if not hasToggles then
        tinsert(lines, "    (none captured)")
    end
    tinsert(lines, "")

    -- Keybinds for recommended spells (if KeybindManager is available)
    tinsert(lines, "Keybinds:")
    local KeybindManager = NAG:GetModule("KeybindManager", true)
    local printedKeybind = false
    if KeybindManager and KeybindManager.GetKeybindForSpell then
        for _, spell in ipairs(spells) do
            local bind = KeybindManager:GetKeybindForSpell(spell.spellId)
            if bind and bind ~= "" then
                tinsert(lines, format("    %s = %s", sanitizeName(spell.name or "spell"), bind))
                printedKeybind = true
            end
        end
    end
    if not printedKeybind then
        tinsert(lines, "    (not captured)")
    end
    tinsert(lines, "")

    -- Warnings section
    tinsert(lines, "### Warnings ###")
    local warnings = snapshot.warnings or {}
    if #warnings == 0 then
        tinsert(lines, "(none)")
    else
        for _, warning in ipairs(warnings) do
            tinsert(lines, format("[%s] %s: %s: %s",
                warning.dateTime or "??:??:??",
                warning.level or "WARN",
                warning.source or "Unknown",
                warning.message or ""))
        end
    end
    tinsert(lines, "")

    -- Event Queue section
    local eventQueue = snapshot.eventQueue or {}
    tinsert(lines, format("### Event Queue - %d events ###", #eventQueue))
    if #eventQueue == 0 then
        tinsert(lines, "(no scheduled events)")
    else
        tinsert(lines, format("%-6s | %-20s | %-18s | %-7s | %s", "Order", "Action", "Type", "Time", "Triggers"))
        tinsert(lines, "-------|----------------------|--------------------|---------|" .. string.rep("-", 30))
        for i, event in ipairs(eventQueue) do
            tinsert(lines, format(" #%-4d | %-20s | %-18s | +%-6.2f | %s",
                i,
                (event.action or "unknown"):sub(1, 20),
                (event.type or "UNKNOWN"):sub(1, 18),
                event.time or 0,
                event.triggers or ""))
            if i >= 20 then
                tinsert(lines, format("       | ... and %d more events", #eventQueue - 20))
                break
            end
        end
    end
    tinsert(lines, "")

    -- Snapshotter data (Added for Feral/Affliction debugging)
    tinsert(lines, "### Stat Snapshots ###")
    local Snapshotter = NAG:GetModule("Snapshotter", true)
    if Snapshotter and Snapshotter.state and Snapshotter.state.snapshots and next(Snapshotter.state.snapshots) then
        for spellId, map in pairs(Snapshotter.state.snapshots) do
            local spellName = self:GetSpellName(spellId)
            for guid, data in pairs(map) do
                local unitStr = (guid == "*") and "Global" or guid
                tinsert(lines, format("    %s (%d) [%s]:", spellName, spellId, unitStr))
                
                local details = {}
                if data.ap then tinsert(details, format("AP=%d", data.ap)) end
                if data.critChance then tinsert(details, format("Crit=%.1f%%", data.critChance)) end
                if data.bleedMasteryMul then tinsert(details, format("Mastery=%.1f%%", (data.bleedMasteryMul - 1) * 100)) end
                if data.percentMod then tinsert(details, format("Mod=%.3f", data.percentMod)) end
                if data.tigerFuryMul and data.tigerFuryMul > 1 then tinsert(details, format("TF=%.2f", data.tigerFuryMul)) end
                if data.docMul and data.docMul > 1 then tinsert(details, format("DoC=%.2f", data.docMul)) end
                if data.perSpell and data.perSpell.comboPoints then tinsert(details, format("CP=%d", data.perSpell.comboPoints)) end
                
                if #details > 0 then
                    tinsert(lines, "        " .. table.concat(details, ", "))
                else
                    tinsert(lines, "        (no stats recorded)")
                end
            end
        end
    else
        tinsert(lines, "    (no snapshotter data)")
    end
    tinsert(lines, "")

    -- Player buffs/debuffs
    tinsert(lines, "player_buffs:")
    local playerBuffs = state.playerBuffs or {}
    if #playerBuffs == 0 then
        tinsert(lines, "    none")
    else
        for _, buff in ipairs(playerBuffs) do
            tinsert(lines, format("    %d - %s - %3d - %0.2f",
                buff.id or 0,
                buff.name or "?",
                buff.stacks or 1,
                buff.remaining or 0))
        end
    end
    tinsert(lines, "")

    tinsert(lines, "player_debuffs:")
    local playerDebuffs = state.playerDebuffs or {}
    if #playerDebuffs == 0 then
        tinsert(lines, "    none")
    else
        for _, debuff in ipairs(playerDebuffs) do
            tinsert(lines, format("    %d - %s - %3d - %0.2f",
                debuff.id or 0,
                debuff.name or "?",
                debuff.stacks or 1,
                debuff.remaining or 0))
        end
    end
    tinsert(lines, "")

    local targetLabel = "target_auras:"
    if not ctx.targetExists then
        tinsert(lines, targetLabel .. "  target does not exist")
    else
        tinsert(lines, targetLabel)
        local targetDebuffs = state.targetDebuffs or {}
        if #targetDebuffs == 0 then
            tinsert(lines, "    none")
        else
            -- Separate player and other debuffs
            local playerDebuffsOnTarget = {}
            local otherDebuffsOnTarget = {}
            for _, debuff in ipairs(targetDebuffs) do
                if debuff.isPlayerAura then
                    tinsert(playerDebuffsOnTarget, debuff)
                else
                    tinsert(otherDebuffsOnTarget, debuff)
                end
            end

            -- Player debuffs
            tinsert(lines, "  target_debuffs (yours):")
            if #playerDebuffsOnTarget == 0 then
                tinsert(lines, "    none")
            else
                for _, debuff in ipairs(playerDebuffsOnTarget) do
                    tinsert(lines, format("    %d - %s - %3d - %0.2f",
                        debuff.id or 0,
                        debuff.name or "?",
                        debuff.stacks or 1,
                        debuff.remaining or 0))
                end
            end

            -- Other debuffs
            tinsert(lines, "  target_debuffs (others):")
            if #otherDebuffsOnTarget == 0 then
                tinsert(lines, "    none")
            else
                for _, debuff in ipairs(otherDebuffsOnTarget) do
                    tinsert(lines, format("    %d - %s - %3d - %0.2f",
                        debuff.id or 0,
                        debuff.name or "?",
                        debuff.stacks or 1,
                        debuff.remaining or 0))
                end
            end
        end
    end
    tinsert(lines, "")
    tinsert(lines, "")

    -- Recent Cast History (most recent first)
    local castHistory = snapshot.castHistory or {}
    if #castHistory > 0 then
        tinsert(lines, "### Recent Casts (most recent first) ###")
        tinsert(lines, format("%-7s | %-6s | %-30s | %s", "SpellID", "Time", "Spell Name", "Combat"))
        tinsert(lines, "--------|--------|--------------------------------|--------")
        for i, cast in ipairs(castHistory) do
            local timeAgo = snapshot.timestamp and (snapshot.timestamp - cast.timestamp) or 0
            local combatTimeStr = cast.combatTime and cast.combatTime > 0 and format("%.1fs", cast.combatTime) or "pre"
            local spellName = tostring(cast.spellName or "?")
            tinsert(lines, format("%7d | %5.1fs | %-30s | %s",
                cast.spellID or 0,
                timeAgo,
                spellName:sub(1, 30),
                combatTimeStr))
            if i >= 50 then break end -- limit output to 50 entries
        end
        tinsert(lines, "")
    end

    -- APL Evaluation Trace (with hierarchy indentation)
    local trace = eval.trace or {}
    if #trace > 0 then
        tinsert(lines, "### APL Evaluation Trace ###")
        tinsert(lines, "Shows which rotation conditions were evaluated and their results.")
        tinsert(lines, "Indentation indicates action list nesting depth.")
        tinsert(lines, "")
        tinsert(lines, format("%-4s | %-6s | %-6s | %-15s | %s", "L#", "Result", "ms", "Action List", "Condition"))
        tinsert(lines, "-----|--------|--------|-----------------|" .. string.rep("-", 55))

        -- Helper to normalize spell name
        local function normalizeSpellName(spell)
            if not spell then return "" end
            if type(spell) == "string" then return spell end
            if type(spell) == "number" then
                local info = WoWAPI.GetSpellInfo(spell)
                if type(info) == "table" then
                    info = info.name or info.spellName or info[1]
                end
                return tostring(info or spell)
            end
            if type(spell) == "table" then
                local rawName = spell.name or spell[1]
                if not rawName and spell.id then
                    rawName = WoWAPI.GetSpellInfo(spell.id)
                end
                if not rawName and spell.spellID then
                    rawName = WoWAPI.GetSpellInfo(spell.spellID)
                end
                if type(rawName) == "table" then
                    rawName = rawName.name or rawName[1]
                end
                return tostring(rawName or "")
            end
            return ""
        end

        for _, entry in ipairs(trace) do
            local resultStr = entry.resultStr or (entry.result and "PASS" or "FAIL")
            local depth = entry.depth or 0
            local actionList = entry.actionList or "default"
            local condStr = tostring(entry.condition or "")
            local spellName = normalizeSpellName(entry.spell)

            -- Build condition string with spell name
            if spellName ~= "" then
                if condStr ~= "" then
                    condStr = condStr .. " -> " .. spellName
                else
                    condStr = spellName
                end
            end

            -- Add indentation based on depth (2 spaces per level)
            local indent = string.rep("  ", depth)
            local indentedCond = indent .. condStr

            -- Truncate if too long (accounting for indent)
            local maxCondLen = 55 - (depth * 2)
            if #condStr > maxCondLen then
                indentedCond = indent .. condStr:sub(1, maxCondLen - 3) .. "..."
            end

            tinsert(lines, format("%4d | %-6s | %6.2f | %-15s | %s",
                entry.line or 0,
                resultStr,
                entry.duration or 0,
                actionList:sub(1, 15),
                indentedCond))
        end
        tinsert(lines, "")
    end

    -- Recommendation summary header
    tinsert(lines, format("New Recommendations for [ Primary ] requested at %s ( %.2f ); using ( %s ) priority.",
        ctx.dateTime or "unknown time",
        ctx.timestamp or 0,
        rotationName))

    tinsert(lines, "*** START OF NEW DISPLAY: Primary ***")
    tinsert(lines, "")

    -- Simple recommendation list (spells in order)
    if #spells == 0 then
        tinsert(lines, "No recommendation available.")
    else
        for idx, spell in ipairs(spells) do
            tinsert(lines, format("RECOMMENDATION #%d : %s (ID: %d)", idx, spell.name or "?", spell.spellId or 0))
        end
    end

    -- Cache export string
    local exportString = concat(lines, "\n")
    snapshot.exportString = exportString
    return exportString
end

--- Get snapshot by index
--- @param index number
--- @return table|nil snapshot
function SnapshotManager:GetSnapshot(index)
    return self.snapshots[index]
end

--- Get snapshot count
--- @return number count
function SnapshotManager:GetSnapshotCount()
    return #self.snapshots
end

--- Get selected snapshot
--- @return table|nil snapshot
function SnapshotManager:GetSelectedSnapshot()
    local index = self.state.selectedSnapshotIndex
    if index and index > 0 and index <= #self.snapshots then
        return self.snapshots[index]
    end
    return nil
end

-- ============================ OPTIONS UI ============================

function SnapshotManager:GetOptions()
    local OptionsFactory = NAG:GetModule("OptionsFactory")

    return {
        type = "group",
        name = "Snapshots",
        desc = "Capture game state for debugging",
        order = 1,
        args = {
            description = OptionsFactory:CreateDescription(
                "Snapshots capture your complete game state (buffs, resources, cooldowns, recommendations) for debugging purposes. " ..
                "Use |cFFFFD100/nagdebug snapshot|r to capture a snapshot, or set up auto-capture below.",
                nil,
                { order = 1, fontSize = "medium" }
            ),

            snapshotHeader = OptionsFactory:CreateHeader("Snapshot Controls", { order = 5 }),

            takeSnapshot = OptionsFactory:CreateExecute(
                "Take Snapshot Now",
                "Capture the current game state immediately.",
                function() self:TakeSnapshot("manual") end,
                { order = 10, width = "normal" }
            ),

            clearSnapshots = OptionsFactory:CreateExecute(
                "Clear All Snapshots",
                "Remove all stored snapshots.",
                function() self:ClearSnapshots() end,
                { order = 11, width = "normal", confirm = true, confirmText = "Clear all snapshots?" }
            ),

            snapshotCount = {
                type = "description",
                name = function()
                    return format("\n|cFFFFD100Snapshots stored:|r %d / %d",
                        #self.snapshots,
                        self.db.global.maxSnapshots or MAX_SNAPSHOTS)
                end,
                order = 12,
                fontSize = "medium",
            },

            autoHeader = OptionsFactory:CreateHeader("Auto-Capture Settings", { order = 20 }),

            autoSnapshotOnNoRecommendation = OptionsFactory:CreateToggle(
                "Auto-Snapshot on No Recommendation",
                "Automatically capture a snapshot when the addon fails to generate a recommendation.",
                function() return self:GetSetting("global", "autoSnapshotOnNoRecommendation") end,
                function(_, v) self:SetSetting("global", "autoSnapshotOnNoRecommendation", v) end,
                { order = 21 }
            ),

            autoSnapshotOnError = OptionsFactory:CreateToggle(
                "Auto-Snapshot on Error",
                "Automatically capture a snapshot when a rotation error occurs.",
                function() return self:GetSetting("global", "autoSnapshotOnError") end,
                function(_, v) self:SetSetting("global", "autoSnapshotOnError", v) end,
                { order = 22 }
            ),

            collectDebugMessages = OptionsFactory:CreateToggle(
                "Collect Debug Messages",
                "Collect warnings and errors for inclusion in snapshots. Stores up to 30 messages.",
                function() return self:GetSetting("global", "collectDebugMessages") end,
                function(_, v)
                    self:SetSetting("global", "collectDebugMessages", v)
                    -- Clear existing warnings when disabled
                    if not v then
                        wipe(self.warnings)
                    end
                end,
                { order = 23 }
            ),

            maxSnapshots = OptionsFactory:CreateRange(
                "Maximum Snapshots",
                "Maximum number of snapshots to keep in memory. Oldest snapshots are removed when limit is reached.",
                function() return self:GetSetting("global", "maxSnapshots") or MAX_SNAPSHOTS end,
                function(_, v) self:SetSetting("global", "maxSnapshots", v) end,
                { order = 24, min = 5, max = 50, step = 1 }
            ),

            viewHeader = OptionsFactory:CreateHeader("View Snapshots", { order = 35 }),

            snapshotSelect = {
                type = "select",
                name = "Select Snapshot",
                desc = "Choose a snapshot to view.",
                order = 36,
                width = "full",
                values = function()
                    local values = {}
                    if #self.snapshots == 0 then
                        values[0] = "No snapshots captured"
                    else
                        for i, snap in ipairs(self.snapshots) do
                            values[i] = format("#%d: %s", i, snap.header or "Unknown")
                        end
                    end
                    return values
                end,
                get = function()
                    -- AceConfig select keys are strings; ensure numeric index
                    local idx = self.state.selectedSnapshotIndex or 0
                    return tonumber(idx) or idx
                end,
                set = function(_, val)
                    self.state.selectedSnapshotIndex = tonumber(val) or val
                end,
                disabled = function() return #self.snapshots == 0 end,
            },

            snapshotContent = {
                type = "input",
                name = "Snapshot Content",
                desc = "Copy this text to share the snapshot (e.g., paste to Pastebin).",
                order = 37,
                width = "full",
                multiline = 30, -- taller multiline box
                dialogControl = "MultiLineEditBox",
                get = function()
                    local snap = self:GetSelectedSnapshot()
                    if snap then
                        return self:FormatSnapshot(snap)
                    end
                    return "Select a snapshot above to view its content."
                end,
                set = function() end, -- Read-only
                hidden = function() return #self.snapshots == 0 end,
            },

            instructionsHeader = OptionsFactory:CreateHeader("How to Use", { order = 40 }),

            instructions = OptionsFactory:CreateDescription(
                "|cFFFFD100Creating Snapshots:|r\n" ..
                "1. Use |cFF00CCFF/nagdebug snapshot|r when you see an issue\n" ..
                "2. Or enable auto-capture above\n" ..
                "3. Or bind a key in Key Bindings > Addons > NAG\n\n" ..
                "|cFFFFD100Sharing Snapshots:|r\n" ..
                "1. Select a snapshot from the dropdown\n" ..
                "2. Copy the content from the text box\n" ..
                "3. Paste to Pastebin.com and share the link\n\n" ..
                "|cFFFFD100Commands:|r\n" ..
                "  /nagdebug snapshot - Take a snapshot\n" ..
                "  /nagdebug snapshot list - List stored snapshots\n" ..
                "  /nagdebug snapshot clear - Clear all snapshots",
                nil,
                { order = 41, fontSize = "medium" }
            ),
        }
    }
end

-- ============================ EXPORT ============================

return SnapshotManager
