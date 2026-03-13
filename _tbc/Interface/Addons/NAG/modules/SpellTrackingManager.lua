--- @module "NAG.SpellTrackingManager"
--- Manages spell-related state tracking.
---
---  Responsibilities:
---    - Track spell travel times
---    - Track periodic effects (DoTs/HoTs)
---    - Track cast counts
---
---  State Structure:
---    ---------------
---    state = {
---        travelTime = {},      -- {spellId = {STT = number, inFlight = timestamp, projectileSpeed = number}}
---        periodicEffects = {}, -- {spellId = {targets = {[guid] = {lastTickTime = timestamp, tickDamage = number}}, spellId = number, auraId = number}}
---        castTracking = {},    -- {spellId = {recentCasts = {timestamp, ...}, lastCast = timestamp}}
---        icdTracking = {},     -- {spellId = {duration = number, lastProc = number}} -- Track both ICD duration and last proc time
---    }
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns = ...
local UnitSpellHaste = _G.UnitSpellHaste
local GetCritChance = _G.GetCritChance
local GetHaste = _G.GetHaste
local GetMeleeHaste = _G.GetMeleeHaste
local GetSpellCritChance = _G.GetSpellCritChance
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type DataManager
--- @type StateManager
local DataManager, StateManager

--- @type TimerManager
local TimerManager


local AssertUtils = ns.AssertUtils
local TableUtils = ns.TableUtils


-- Lua APIs (using WoW's optimized versions where available)
local GetTime = _G.GetTime
local UnitGUID = _G.UnitGUID
local format = string.format -- WoW's optimized version if available
local floor = math.floor
local min = math.min
local max = math.max

local tinsert = tinsert
local tremove = tremove
local wipe = wipe



local defaults = {
    char = {
        channelTickTimes = {},
        channelDurations = {}
    }
}

local function addRelatedId(list, candidate, original)
    if candidate and candidate ~= original then
        tinsert(list, candidate)
    end
end

local function GetPlayerHasteMultiplier()
    local hastePercent = 0

    if UnitSpellHaste then
        hastePercent = UnitSpellHaste("player") or 0
    elseif GetHaste then
        hastePercent = GetHaste() or 0
    elseif GetMeleeHaste then
        hastePercent = GetMeleeHaste() or 0
    end

    if not hastePercent or hastePercent < 0 then
        hastePercent = 0
    end

    return 1 + (hastePercent / 100)
end

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
local DEBUG_SLASH = "nagspelltrackdebug"

--- @class SpellTrackingManager: CoreModule, AceEvent-3.0
local SpellTrackingManager = NAG:CreateModule("SpellTrackingManager", defaults, {
 
    -- Define default state structure
    defaultState = {
        travelTime = {},      -- {spellId = {STT = number, inFlight = timestamp, projectileSpeed = number}}
        periodicEffects = {}, -- {spellId = {targets = {[guid] = {lastTickTime = timestamp, tickDamage = number}}, spellId = number, auraId = number}}
        castTracking = {},    -- {spellId = {recentCasts = {timestamp, ...}, lastCast = timestamp}}
        icdTracking = {},     -- {spellId = {duration = number, lastProc = number}} -- Track both ICD duration and last proc time
        channelTracking = {
            active = false,
            spellId = nil,
            targetGUID = nil,
            castGUID = nil,
            ticks = 0,
            lastTickTime = 0,
            startTime = 0
        },
        channelTickTimes = {}, -- {spellId = averagedTickInterval}
        channelDurations = {} -- {spellId = averagedChannelDuration}
    },

    -- Register event handlers here so they are available before OnInitialize
    eventHandlers = {
        PLAYER_REGEN_ENABLED = true,
        UNIT_SPELLCAST_CHANNEL_START = "OnChannelStart",
        UNIT_SPELLCAST_CHANNEL_STOP = "OnChannelStop",
        -- Note: UNIT_SPELLCAST_INTERRUPTED does NOT apply to channels
        -- Channels use UNIT_SPELLCAST_CHANNEL_STOP for both completion and interruption
    },
    cleuHandlers = {
        SPELL_CAST_SUCCESS = "HandleSpellCastSuccess",
        SPELL_DAMAGE = "HandleSpellDamage",
        SPELL_PERIODIC_DAMAGE = "HandlePeriodicDamage",
        SPELL_AURA_REMOVED = "HandleSpellAuraRemoved",
        SPELL_AURA_APPLIED = "HandleSpellAuraApplied",
        UNIT_DIED = "HandleUnitDied",
    },
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.TRACKERS
    },

    -- Slash commands using zero-boilerplate pattern
    slashCommands = {
        -- NEW HIERARCHICAL FORMAT:
        ["spell_tracking_stats"] = {
            handler = "StatsSlashHandler",
            help = "Print spell tracking cache stats",
            root = "nagdebug",
            path = {"spell", "tracking", "stats"},
            category = "Data"
        },
        ["spell_tracking_debug"] = {
            handler = "DebugSlashHandler",
            help = "Show the Spell Tracking debug window",
            root = "nagdebug",
            path = {"spell", "tracking", "debug"},
            category = "Debug"
        }
    }
})
local module = SpellTrackingManager
ns.SpellTrackingManager = SpellTrackingManager
ns.SpellTracker = SpellTrackingManager


do -- Core functionality
    --- Initialize the SpellTrackingManager module
    --- @param self SpellTrackingManager
    function SpellTrackingManager:ModuleInitialize()
        DataManager = NAG:GetModule("DataManager")
        StateManager = NAG:GetModule("StateManager")
        TimerManager = NAG:GetModule("TimerManager")

        -- Start cleanup timer
        --self:ScheduleRepeatingTimer("CleanupOldData", 300) -- Clean up every 5 minutes
        -- Slash commands are now handled via zero-boilerplate slashCommands table
    end

    --- Enable the SpellTrackingManager module and register events
    --- @param self SpellTrackingManager
    function SpellTrackingManager:ModuleEnable()
        -- ============================ MODULE INITIALIZATION ============================
        self:LoadPersistedChannelData()
    end

    --- Disable the SpellTrackingManager module
    --- @param self SpellTrackingManager
    function SpellTrackingManager:ModuleDisable()
    end

    function SpellTrackingManager:LoadPersistedChannelData()
        if not self.db or not self.db.char then
            return
        end

        local storedTickTimes = self.db.char.channelTickTimes or {}
        self.db.char.channelTickTimes = storedTickTimes

        wipe(self.state.channelTickTimes)
        for spellId, interval in pairs(storedTickTimes) do
            if interval and interval > 0 then
                self.state.channelTickTimes[spellId] = interval
            end
        end

        self.state.channelDurations = self.state.channelDurations or {}
        wipe(self.state.channelDurations)

        local storedDurations = self.db.char.channelDurations or {}
        self.db.char.channelDurations = storedDurations

        for spellId, duration in pairs(storedDurations) do
            if duration and duration > 0 then
                self.state.channelDurations[spellId] = duration
            end
        end
    end

end



do -- Registration Functions
    --- Register periodic damage tick time for spells
    --- @param self SpellTrackingManager
    --- @param spellIds table Array of spell IDs
    --- @param data table Data for the periodic damage
    function SpellTrackingManager:RegisterPeriodicDamage(spellIds, data)
        AssertUtils.assertType(spellIds, "table", "spellIds")
        AssertUtils.assertType(data, "table", "data")

        for _, spellId in ipairs(spellIds) do
            self.state.periodicEffects[spellId] = {
                targets = {},
                spellId = data.spellId, -- For effects like Ignite that need to track a different spellId
                auraId = data.auraId    -- For effects that need to track a specific aura
            }
            if self.debug then self:Debug("Registered periodic damage for spell %s", spellId) end
        end
    end

    --- Unregister periodic damage tracking for spells
    --- @param self SpellTrackingManager
    --- @param spellIds table Array of spell IDs to unregister
    function SpellTrackingManager:UnregisterPeriodicDamage(spellIds)
        AssertUtils.assertType(spellIds, "table", "spellIds")

        for _, spellId in ipairs(spellIds) do
            self.state.periodicEffects[spellId] = nil
            if self.debug then self:Debug("Unregistered periodic damage for spell %s", spellId) end
        end
    end

    --- Register travel time for spells
    --- @param self SpellTrackingManager
    --- @param spellIds table Array of spell IDs
    --- @param data table Travel time data
    function SpellTrackingManager:RegisterTravelTime(spellIds, data)
        AssertUtils.assertType(spellIds, "table", "spellIds")
        AssertUtils.assertType(data, "table", "data")

        for _, spellId in ipairs(spellIds) do
            local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            local projectileSpeed = spell and spell.projectileSpeed or nil

            self.state.travelTime[spellId] = {
                STT = data.STT,
                inFlight = data.inFlight,
                projectileSpeed = projectileSpeed
            }
            if self.debug then self:Debug("Registered travel time for spell %s", spellId) end
        end
    end

    --- Unregister travel time tracking for spells
    --- @param self SpellTrackingManager
    --- @param spellIds table Array of spell IDs to unregister
    function SpellTrackingManager:UnregisterTravelTime(spellIds)
        AssertUtils.assertType(spellIds, "table", "spellIds")

        for _, spellId in ipairs(spellIds) do
            self.state.travelTime[spellId] = nil
            if self.debug then self:Debug("Unregistered travel time for spell %s", spellId) end
        end
    end

    --- Register cast tracking for spells
    --- @param self SpellTrackingManager
    --- @param spellIds table Array of spell IDs
    --- @param data table Cast tracking data
    function SpellTrackingManager:RegisterCastTracking(spellIds, data)
        AssertUtils.assertType(spellIds, "table", "spellIds")
        AssertUtils.assertType(data, "table", "data")

        local currentTime = GetTime()
        for _, spellId in ipairs(spellIds) do
            self.state.castTracking[spellId] = {
                recentCasts = {},
                lastCast = currentTime
            }
            if self.debug then self:Debug("Registered cast tracking for spell %s", spellId) end
        end
    end

    --- Unregister cast tracking for spells
    --- @param self SpellTrackingManager
    --- @param spellIds table Array of spell IDs to unregister
    function SpellTrackingManager:UnregisterCastTracking(spellIds)
        AssertUtils.assertType(spellIds, "table", "spellIds")

        for _, spellId in ipairs(spellIds) do
            self.state.castTracking[spellId] = nil
            if self.debug then self:Debug("Unregistered cast tracking for spell %s", spellId) end
        end
    end

    --- Resolve or register periodic effect information for a spell ID.
    --- Returns the canonical spell ID that should be used for tracking and the effect table.
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @param visited table|nil
    --- @return number|nil
    --- @return table|nil
    function SpellTrackingManager:ResolvePeriodicEffect(spellId, visited)
        if not spellId then return nil end

        visited = visited or {}
        if visited[spellId] then
            return nil
        end
        visited[spellId] = true

        local effect = self.state.periodicEffects[spellId]
        if effect then
            return spellId, effect
        end

        local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if not entry then
            return nil
        end

        if entry.flags and (entry.flags.dot or entry.flags.hot) then
            self:RegisterPeriodicDamage({ spellId }, {
                spellId = entry.dotId or spellId,
                auraId = entry.auraId
            })
            effect = self.state.periodicEffects[spellId]
            if effect then
                return spellId, effect
            end
        end

        local relatedIds = {}
        addRelatedId(relatedIds, entry.dotId, spellId)
        addRelatedId(relatedIds, entry.auraId, spellId)
        addRelatedId(relatedIds, entry.spellId, spellId)

        if entry.relationships and entry.relationships.spell then
            for relatedSpellId in pairs(entry.relationships.spell) do
                addRelatedId(relatedIds, relatedSpellId, spellId)
            end
        end

        for i = 1, #relatedIds do
            local relatedId = relatedIds[i]
            local resolvedId, resolvedEffect = self:ResolvePeriodicEffect(relatedId, visited)
            if resolvedEffect then
                self.state.periodicEffects[spellId] = resolvedEffect
                return resolvedId, resolvedEffect
            end
        end

        return nil
    end

    --- Register a spell's internal cooldown duration
    --- @param self SpellTrackingManager
    --- @param spellId number The spell ID to register
    --- @param duration number The internal cooldown duration in seconds
    function SpellTrackingManager:RegisterICD(spellId, duration)
        local DataManager = NAG:GetModule("DataManager")
        -- Get spell data from DataManager
        local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if not spell then return end

        -- Register the ICD
        if not self.state.icdTracking[spellId] then
            self.state.icdTracking[spellId] = {
                duration = duration,
                lastProc = StateManager:GetNextTime() - duration -- Initialize as ready to proc
            }
        else
            self.state.icdTracking[spellId].duration = duration
        end
        if self.debug then self:Debug("Registered ICD duration for spell/proc %s: %.3f seconds", spellId, duration) end
    end

    --- Unregister a spell's internal cooldown duration
    --- @param self SpellTrackingManager
    --- @param spellId number The spell ID to unregister
    function SpellTrackingManager:UnregisterICD(spellId)
        self.state.icdTracking[spellId] = nil
        if self.debug then self:Debug("Unregistered ICD for spell/proc %s", spellId) end
    end
end

do -- Event Handlers
    --- Handle PLAYER_REGEN_ENABLED event (migrated from StateManager)
    --- @param self SpellTrackingManager
    function SpellTrackingManager:PLAYER_REGEN_ENABLED(event)
        self:HandleCombatReset()
    end

    --- Handle UNIT_SPELLCAST_CHANNEL_START
    --- @param self SpellTrackingManager
    --- @param event string
    --- @param unit string
    --- @param castGUID string
    --- @param spellId number
    function SpellTrackingManager:OnChannelStart(event, unit, castGUID, spellId)
        if unit ~= "player" or not spellId then
            return
        end

        local tracker = self.state.channelTracking
        tracker.active = true
        tracker.spellId = spellId
        tracker.targetGUID = UnitGUID("target")
        tracker.castGUID = castGUID
        tracker.ticks = 0
        tracker.lastTickTime = 0
        tracker.startTime = GetTime()

        if self.debug then
            self:Trace("Channel start detected for spell %s (castGUID=%s, target=%s)", tostring(spellId),
                tostring(castGUID), tostring(tracker.targetGUID))
        end
    end

    --- Handle UNIT_SPELLCAST_CHANNEL_STOP
    --- Note: UNIT_SPELLCAST_CHANNEL_STOP fires for both completed and interrupted channels
    --- UNIT_SPELLCAST_INTERRUPTED does NOT apply to channeled spells
    --- @param self SpellTrackingManager
    --- @param event string
    --- @param unit string
    --- @param castGUID string
    --- @param spellId number
    function SpellTrackingManager:OnChannelStop(event, unit, castGUID, spellId)
        if unit ~= "player" then
            return
        end

        local tracker = self.state.channelTracking
        if tracker.active and (not spellId or tracker.spellId == spellId) then
            local trackedSpellId = tracker.spellId
            if trackedSpellId and tracker.startTime and tracker.startTime > 0 then
                local duration = GetTime() - tracker.startTime
                if duration and duration > 0 then
                    self.state.channelDurations = self.state.channelDurations or {}
                    self.state.channelDurations[trackedSpellId] = duration

                    if self.db and self.db.char then
                        self.db.char.channelDurations = self.db.char.channelDurations or {}
                        self.db.char.channelDurations[trackedSpellId] = duration
                    end
                end
            end

            if self.debug then
                self:Trace("Channel stop detected for spell %s (event=%s)", tostring(spellId), tostring(event))
            end
            self:ResetChannelTracking()
        end
    end

    --- Reset the active channel tracking data
    --- @param self SpellTrackingManager
    function SpellTrackingManager:ResetChannelTracking()
        local tracker = self.state.channelTracking
        tracker.active = false
        tracker.spellId = nil
        tracker.targetGUID = nil
        tracker.castGUID = nil
        tracker.ticks = 0
        tracker.lastTickTime = 0
        tracker.startTime = 0
    end

    --- Check if the currently tracked channel matches the provided spellId
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return boolean
    function SpellTrackingManager:IsChannelTrackedSpell(spellId)
        local tracker = self.state.channelTracking
        return tracker.active and tracker.spellId == spellId
    end

    -- CLEU sub-event handlers (dispatched centrally via EventManager)

    --- Handle spell cast success
    --- @param self SpellTrackingManager
    --- @param timestamp number
    --- @param spellId number
    --- @param destGUID string
    function SpellTrackingManager:HandleSpellCastSuccess(timestamp, subEvent, hideCaster, sourceGUID, sourceName,
                                                         sourceFlags, sourceRaidFlags, destGUID, destName, destFlags,
                                                         destRaidFlags, spellId)
        if sourceGUID ~= NAG.state.player.guid then
            return
        end
        if self.debug then
            -- PERFORMANCE: Use format instead of string concatenations
            self:Trace("HandleSpellCastSuccess: spellId=%d, destGUID=%s, timestamp=%d",
                spellId, destGUID or "nil", timestamp)
        end


        -- Update cast tracking if registered
        if self.state.castTracking[spellId] then
            --self:Debug("Updating castTracking for spellId=" .. tostring(spellId))
            self:UpdateCastTracking(spellId, timestamp)
        end

        -- Set in-flight timestamp ONLY if already registered
        if self.state.travelTime[spellId] then
            -- Use GetTime() instead of CLEU timestamp to ensure consistent time format
            local currentTime = GetTime()
            self.state.travelTime[spellId].inFlight = currentTime
            if self.debug then self:Debug("Updated in-flight timestamp for spell %d", spellId) end

        else
        end

        -- CRITICAL: Track sequence progress for StrictSequence completion
        -- This ensures sequences are properly completed when spells are cast
        if NAG and NAG.TrackSequenceCast then
            NAG:TrackSequenceCast(spellId)
        end
    end

    --- Handle spell damage
    --- @param self SpellTrackingManager
    --- @param timestamp number
    --- @param spellId number
    --- @param destGUID string
    --- @param amount number
    function SpellTrackingManager:HandleSpellDamage(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
                                                    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId,
                                                    spellName, spellSchool, amount, overkill, school, resisted, blocked,
                                                    absorbed, critical)
        if sourceGUID ~= NAG.state.player.guid then
            return
        end

        local originalSpellId = spellId
        spellId = originalSpellId == 413841 and 413843 or spellId
        if self.debug then
            self:Trace("HandleSpellDamage: spellId=" ..
                tostring(spellId) ..
                ", destGUID=" ..
                tostring(destGUID) .. ", amount=" .. tostring(amount) .. ", timestamp=" .. tostring(timestamp))
        end


        local hasTravelTracking = self.state.travelTime[spellId] ~= nil
        local effect = self.state.periodicEffects[spellId]
        local isChannelTracked = self:IsChannelTrackedSpell(spellId)

        -- Only process if we're tracking this spell or it's the active channel
        if not hasTravelTracking and not effect and not isChannelTracked then
            return
        end

        -- Special case: Ignite sometimes comes as SPELL_DAMAGE instead of SPELL_PERIODIC_DAMAGE
        if spellId == 413843 and effect then
            effect.targets[destGUID] = effect.targets[destGUID] or {}
            effect.targets[destGUID].tickDamage = amount
            effect.targets[destGUID].lastTickTime = GetTime()
            effect.targets[destGUID].wasCrit = false -- or set appropriately if crit info is available
            if self.debug then self:Debug("Updated Ignite tickDamage via SPELL_DAMAGE: " .. tostring(amount)) end
        end

        -- Handle travel time tracking
        if hasTravelTracking then
            local travelTime = self.state.travelTime[spellId]
            if travelTime.inFlight then
                travelTime.STT = timestamp - travelTime.inFlight
                travelTime.inFlight = nil
                if self.debug then
                    self:Debug("Updated travel time for registered spell " ..
                        tostring(spellId) .. ": " .. tostring(travelTime.STT) .. " seconds")
                end

            else
            end
        else
        end

        -- Handle periodic damage tick information
        if effect and effect.auraId then
            effect.tickDamage = amount
            if self.debug then
                self:Debug("Updated tick damage for registered spell " ..
                    tostring(spellId) ..
                    ": " ..
                    tostring(amount) .. " (auraId: " .. tostring(effect.auraId) .. ")")
            end
        end

        if isChannelTracked then
            self:RecordChannelTick(spellId, destGUID)
        end
    end

    --- Handle spell aura removed
    --- @param self SpellTrackingManager
    --- @param timestamp number
    --- @param subEvent string
    --- @param hideCaster boolean
    --- @param sourceGUID string
    --- @param sourceName string
    --- @param sourceFlags number
    --- @param sourceRaidFlags number
    --- @param destGUID string
    --- @param destName string
    --- @param destFlags number
    --- @param destRaidFlags number
    --- @param spellId number
    --- @param spellName string
    --- @param spellSchool number
    --- @param auraType string
    function SpellTrackingManager:HandleSpellAuraRemoved(timestamp, subEvent, hideCaster, sourceGUID, sourceName,
                                                         sourceFlags, sourceRaidFlags, destGUID, destName, destFlags,
                                                         destRaidFlags, spellId, spellName, spellSchool, auraType)
        spellId = spellId == 413841 and 413843 or spellId

        -- Allow cleanup if we have active tracking for this target even when the source is not us
        if sourceGUID ~= NAG.state.player.guid then
            local effect = self.state.periodicEffects[spellId]
            if not (effect and effect.targets and effect.targets[destGUID]) then
                return
            end
        end
        -- Special case for Ignite
        if originalSpellId == 413841 and not self.state.periodicEffects[413843] then return end
        if not self.state.periodicEffects[spellId] then return end

        -- Handle periodic effect cleanup
        local effect = self.state.periodicEffects[spellId]
        if effect then
            -- Log pre-cleanup state
            if self.debug then
                self:Trace(
                    "Pre-cleanup [%s]: Global(dmg=%s, time=%s) Target(%s: dmg=%s, time=%s, crit=%s)", spellId,
                    tostring(effect.tickDamage), tostring(effect.tickTime), destGUID,
                    tostring(effect.targets[destGUID] and effect.targets[destGUID].tickDamage),
                    tostring(effect.targets[destGUID] and effect.targets[destGUID].lastTickTime),
                    tostring(effect.targets[destGUID] and effect.targets[destGUID].wasCrit))
            end

            -- Schedule cleanup after last tick
            C_Timer.After(0.1, function()
                if not effect then return end

                -- Store current values for debug
                local oldDamage = effect.tickDamage or 0
                local oldTime = effect.tickTime
                local oldTargetData = effect.targets[destGUID] and {
                    damage = effect.targets[destGUID].tickDamage,
                    time = effect.targets[destGUID].lastTickTime,
                    wasCrit = effect.targets[destGUID].wasCrit
                }

                -- Clear target-specific data
                local targetData = effect.targets[destGUID]
                if targetData then
                    wipe(targetData)
                    effect.targets[destGUID] = nil
                    if self.debug then self:Debug("Removed target entry for %s from spell %s", destGUID, spellId) end
                end

                -- If no targets remain, clear global effect data
                if not next(effect.targets) then
                    effect.tickDamage = 0
                    effect.tickTime = nil
                    if self.debug then
                        self:Trace("Cleared global data for spell %s (old: dmg=%s, time=%s)", spellId,
                            oldDamage, oldTime and string.format("%.3f", oldTime) or "nil")
                    end
                end

                -- Log final state
                if self.debug then
                    self:Debug(
                        "Post-cleanup [%s]: Global(dmg=%s, time=%s) Target(%s: dmg=%s, time=%s, crit=%s)", spellId,
                        tostring(effect.tickDamage), tostring(effect.tickTime), destGUID,
                        tostring(effect.targets[destGUID] and effect.targets[destGUID].tickDamage),
                        tostring(effect.targets[destGUID] and effect.targets[destGUID].lastTickTime),
                        tostring(effect.targets[destGUID] and effect.targets[destGUID].wasCrit))
                end
            end)
        end
    end

    --- Handle periodic damage
    --- @param self SpellTrackingManager
    --- @param timestamp number
    --- @param spellId number
    --- @param destGUID string
    --- @param amount number
    --- @param critical boolean
    --- @param absorbed number
    function SpellTrackingManager:HandlePeriodicDamage(timestamp, subEvent, hideCaster, sourceGUID, sourceName,
                                                       sourceFlags, sourceRaidFlags, destGUID, destName, destFlags,
                                                       destRaidFlags, spellId, spellName, spellSchool, amount, overkill,
                                                       school, resisted, blocked, absorbed, critical)
        if sourceGUID ~= NAG.state.player.guid then
            return
        end

        spellId = spellId == 413841 and 413843 or spellId
        self:ResolvePeriodicEffect(spellId)

        local effect = self.state.periodicEffects[spellId]
        -- Initialize target data if needed
        if effect then
            effect.targets[destGUID] = effect.targets[destGUID] or {}

            local currentTime = GetTime()
            local oldDamage = effect.targets[destGUID].tickDamage or 0
            local oldTime = effect.targets[destGUID].lastTickTime or 0

            -- Calculate tick time if we have a previous tick
            if oldTime > 0 then
                effect.targets[destGUID].tickTime = currentTime - oldTime
                if self.debug then
                    self:Trace("  - Calculated tick time: " ..
                        tostring(effect.targets[destGUID].tickTime) .. " seconds")
                end
            end

            -- Calculate total damage (including absorbed)
            local totalDamage = amount + (absorbed or 0)

            -- Update target-specific data
            effect.targets[destGUID].lastTickTime = currentTime
            effect.targets[destGUID].tickDamage = totalDamage
            effect.targets[destGUID].wasCrit = critical

            -- Move to Trace level to reduce spam
            if self.debug then
                self:Trace("  - Updated target data: lastTickTime=" ..
                    tostring(currentTime) .. ", tickDamage=" .. tostring(totalDamage) .. ", wasCrit=" .. tostring(critical))
            end
            if effect.auraId then
                if self.debug then self:Trace("  - Associated auraId: " .. tostring(effect.auraId)) end
            end
        end

        if self:IsChannelTrackedSpell(spellId) then
            self:RecordChannelTick(spellId, destGUID)
        end
    end

    --- Handle unit death cleanup
    --- @param self SpellTrackingManager
    --- @param timestamp number
    --- @param subEvent string
    --- @param hideCaster boolean
    --- @param sourceGUID string
    --- @param sourceName string
    --- @param sourceFlags number
    --- @param sourceRaidFlags number
    --- @param destGUID string
    --- @param destName string
    --- @param destFlags number
    --- @param destRaidFlags number
    function SpellTrackingManager:HandleUnitDied(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
                                                 sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags)
        if not destGUID then
            return
        end

        for _, effect in pairs(self.state.periodicEffects) do
            if effect.targets and effect.targets[destGUID] then
                effect.targets[destGUID] = nil
            end
        end
    end

    --- Handle spell aura applied
    --- @param self SpellTrackingManager
    --- @param timestamp number
    --- @param subEvent string
    --- @param hideCaster boolean
    --- @param sourceGUID string
    --- @param sourceName string
    --- @param sourceFlags number
    --- @param sourceRaidFlags number
    --- @param destGUID string
    --- @param destName string
    --- @param destFlags number
    --- @param destRaidFlags number
    --- @param spellId number
    --- @param spellName string
    --- @param spellSchool number
    --- @param auraType string
    function SpellTrackingManager:HandleSpellAuraApplied(timestamp, subEvent, hideCaster, sourceGUID, sourceName,
                                                         sourceFlags, sourceRaidFlags, destGUID, destName, destFlags,
                                                         destRaidFlags, spellId, spellName, spellSchool, auraType)
        if sourceGUID ~= NAG.state.player.guid then
            return
        end
        -- Handle ICD tracking
        if self.state.icdTracking[spellId] then
            self:UpdateICD(spellId, StateManager:GetNextTime())
            if self.debug then self:Debug("Updated ICD tracking for proc %s", spellId) end
        end

        -- Handle periodic effect tracking
        local effect = self.state.periodicEffects[spellId]
        if effect then
            -- Initialize or update target data
            effect.targets[destGUID] = effect.targets[destGUID] or {}
            effect.targets[destGUID].active = true
            if self.debug then self:Debug("Marked DoT active for spell %s on target %s", spellId, destGUID) end
        end
    end

    --- Handle combat reset
    --- @param self SpellTrackingManager
    function SpellTrackingManager:HandleCombatReset()
        if self.debug then self:Debug("Handling combat reset") end

        -- Reset travel time tracking
        for spellId in pairs(self.state.travelTime) do
            self.state.travelTime[spellId].inFlight = nil
            self.state.travelTime[spellId].STT = nil
            if self.debug then self:Trace("Reset travel time for spell %s", spellId) end
        end

        -- Reset periodic effects
        for spellId, effect in pairs(self.state.periodicEffects) do
            effect.tickDamage = 0
            effect.tickTime = nil
            wipe(effect.targets)
            if self.debug then self:Trace("Reset periodic effect for spell %s", spellId) end
        end

        -- Reset cast tracking
        for spellId, tracking in pairs(self.state.castTracking) do
            wipe(tracking.recentCasts)
            tracking.lastCast = nil
            if self.debug then self:Trace("Reset cast tracking for spell %s", spellId) end
        end

        -- Also perform a quick old-data cleanup on leave combat
        self:CleanupOldData(60) -- aggressively prune entries older than 60s
    end

    --- Clean up old data
    --- @param self SpellTrackingManager
    --- @param maxAge number
    function SpellTrackingManager:CleanupOldData(maxAge)
        local currentTime = GetTime()
        maxAge = maxAge or 300 -- Default to 5 minutes

        -- Clean up travel time data
        for spellId, data in pairs(self.state.travelTime) do
            if data.inFlight and (currentTime - data.inFlight) > maxAge then
                self.state.travelTime[spellId] = nil
            end
        end

        -- Clean up periodic effects
        for spellId, effect in pairs(self.state.periodicEffects) do
            -- Clean up old target data
            local hasActiveTargets = false
            for guid, targetData in pairs(effect.targets) do
                if targetData.lastTickTime and (currentTime - targetData.lastTickTime) > maxAge then
                    effect.targets[guid] = nil
                else
                    hasActiveTargets = true
                end
            end

            -- If no active targets remain, reset effect data
            if not hasActiveTargets then
                effect.tickDamage = 0
                effect.tickTime = nil
            end
        end

        -- Clean up cast tracking
        for spellId, data in pairs(self.state.castTracking) do
            if data.lastCast and (currentTime - data.lastCast) > maxAge then
                self.state.castTracking[spellId] = nil
            end
        end
    end
end

do -- Update methods
    --- Update ICD tracking when a spell procs
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @param timestamp number
    function SpellTrackingManager:UpdateICD(spellId, timestamp)
        if not self.state.icdTracking[spellId] then
            if self.debug then self:Debug("Warning: Attempting to update ICD for unregistered spell %s", spellId) end
            return
        end
        self.state.icdTracking[spellId].lastProc = timestamp
        if self.debug then self:Trace("Updated last proc time for spell %s at %.3f", spellId, timestamp) end
    end

    --- Update cast tracking for a spell
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @param timestamp number
    function SpellTrackingManager:UpdateCastTracking(spellId, timestamp)
        self.state.castTracking[spellId] = self.state.castTracking[spellId] or {
            recentCasts = {},
            lastCast = timestamp
        }

        local tracking = self.state.castTracking[spellId]

        -- Add new cast
        tinsert(tracking.recentCasts, timestamp)
        tracking.lastCast = timestamp

        -- Remove casts older than 60 seconds
        local cutoffTime = timestamp - 60
        while tracking.recentCasts[1] and tracking.recentCasts[1] < cutoffTime do
            tremove(tracking.recentCasts, 1)
        end
    end
end

do -- Getters
    --- Get cast count within the last minute
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return number
    function SpellTrackingManager:GetRecentCastCount(spellId)
        local tracking = self.state.castTracking[spellId]
        if not tracking then
            -- Auto-register for cast tracking
            local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL) or
                DataManager:Get(spellId, DataManager.EntityTypes.ITEM)
            if entry then
                self:RegisterCastTracking({ spellId }, {})
                tracking = self.state.castTracking[spellId]
            else
                return 0
            end
        end

        -- Clean up old casts first
        local currentTime = StateManager:GetNextTime()
        local cutoffTime = currentTime - 60
        while tracking.recentCasts[1] and tracking.recentCasts[1] < cutoffTime do
            tremove(tracking.recentCasts, 1)
        end

        return #tracking.recentCasts
    end

    --- Check if a spell is currently in flight
    --- @param self SpellTrackingManager
    --- @param spellId number The spell ID to check
    --- @return boolean True if the spell is in flight, false otherwise
    function SpellTrackingManager:IsSpellInFlight(spellId)

        local travelTime = self.state.travelTime[spellId]
        if not travelTime then
            -- Auto-register for travel time tracking
            local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            if entry then
                self:RegisterTravelTime({ spellId }, {
                    STT = entry.travelTime,
                    inFlight = nil,
                    projectileSpeed = entry.projectileSpeed
                })
                travelTime = self.state.travelTime[spellId]
            else
                return false
            end
        end


        -- Check if spell is in flight
        if not travelTime.inFlight then
            return false
        end

        -- Add timeout mechanism to prevent spells from being stuck in flight
        local timeSinceCast = GetTime() - travelTime.inFlight
        local maxTravelTime = 10.0 -- Maximum 10 seconds for any spell to travel

        if timeSinceCast > maxTravelTime then
            if self.debug then
                self:Debug("Spell %d stuck in flight for %.2f seconds, clearing inFlight flag", spellId, timeSinceCast)
            end
            travelTime.inFlight = nil
            return false
        end


        -- Heuristic: If projectile speed is very low (< 5), treat as fixed travel time
        -- This handles spells like Hand of Gul'dan that use fixed delays instead of projectile speeds
        if travelTime.projectileSpeed and travelTime.projectileSpeed < 5.0 then
            local fixedTravelTime = travelTime.projectileSpeed
            local result = timeSinceCast < fixedTravelTime

            if self.debug then
                self:Debug("🔥 FIXED DELAY SPELL: spellId=" .. tostring(spellId) ..
                    ", fixedTravelTime=" .. tostring(fixedTravelTime) ..
                    ", timeSinceCast=" .. tostring(timeSinceCast) ..
                    ", result=" .. tostring(result))
            end

            return result
        end

        -- If we have projectile speed, calculate if it should have landed by now
        if travelTime.projectileSpeed then
            local distance = NAG:UnitDistance("target")
            -- Add tolerance buffer for hitbox center travel (distance is edge-to-edge)
            -- Use 15% of distance as tolerance to account for hitbox radius scaling with distance
            local hitboxTolerance = distance * 0.15 -- 15% of distance
            local adjustedDistance = distance + hitboxTolerance
            local calculatedTravelTime = adjustedDistance / travelTime.projectileSpeed
            local result = timeSinceCast < (calculatedTravelTime + 1)


            return result
        end

        -- Otherwise use static travel time
        if travelTime.STT then
            local result = timeSinceCast < travelTime.STT


            return result
        end

        return false
    end

    --- Get casts per minute for a spell using a rolling 60-second window
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return number
    function SpellTrackingManager:GetCPM(spellId)
        -- No need to check if spell is registered, GetRecentCastCount will do that
        return self:GetRecentCastCount(spellId)
    end

    --- Get spell travel time
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return number|nil
    function SpellTrackingManager:GetSpellTravelTime(spellId)

        local travelTime = self.state.travelTime[spellId]
        if not travelTime then
            -- Auto-register for travel time tracking
            local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL) or
                DataManager:Get(spellId, DataManager.EntityTypes.ITEM)
            if entry then
                self:RegisterTravelTime({ spellId }, {
                    STT = entry.travelTime, -- Use predefined travel time if available
                    inFlight = nil,
                    projectileSpeed = entry.projectileSpeed
                })
                travelTime = self.state.travelTime[spellId]
            else
                return nil
            end
        end

        -- Heuristic: If projectile speed is very low (< 5), treat as fixed travel time
        if travelTime.projectileSpeed and travelTime.projectileSpeed < 5.0 then
            return travelTime.projectileSpeed -- Return the fixed travel time directly
        end

        -- Calculate travel time based on projectile speed if available
        if travelTime.projectileSpeed then
            local distance = NAG:UnitDistance("target")
            return distance / travelTime.projectileSpeed
        end

        return travelTime.STT
    end

    --- Record a tick for the currently tracked channel spell
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @param destGUID string|nil
    function SpellTrackingManager:RecordChannelTick(spellId, destGUID)
        local tracker = self.state.channelTracking
        if not tracker.active or tracker.spellId ~= spellId then
            return
        end

        if tracker.targetGUID and destGUID and tracker.targetGUID ~= destGUID then
            return
        end

        if not tracker.targetGUID then
            tracker.targetGUID = destGUID
        end

        local currentTime = GetTime()

        if tracker.lastTickTime and tracker.lastTickTime > 0 then
            local interval = currentTime - tracker.lastTickTime
            if interval > 0 then
                local hasteMultiplier = GetPlayerHasteMultiplier()
                local baseInterval = interval * hasteMultiplier
                local cachedBase = self.state.channelTickTimes[spellId]
                if cachedBase then
                    baseInterval = (cachedBase * 0.7) + (baseInterval * 0.3)
                end
                self.state.channelTickTimes[spellId] = baseInterval
                if self.db and self.db.char then
                    self.db.char.channelTickTimes[spellId] = baseInterval
                end
            end
        end

        tracker.ticks = (tracker.ticks or 0) + 1
        tracker.lastTickTime = currentTime
    end

    --- Get the number of ticks that have occurred for the active channel spell
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return number
    function SpellTrackingManager:GetChannelTickCount(spellId)
        local tracker = self.state.channelTracking
        if not tracker.active or tracker.spellId ~= spellId then
            return 0
        end

        return tracker.ticks or 0
    end

    --- Get the most recently observed tick interval for a channel spell
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return number
    function SpellTrackingManager:GetChannelTickInterval(spellId)
        local baseInterval = self.state.channelTickTimes[spellId]
        if not baseInterval or baseInterval <= 0 then
            return 0
        end

        local hasteMultiplier = GetPlayerHasteMultiplier()
        if hasteMultiplier <= 0 then
            hasteMultiplier = 1
        end

        return baseInterval / hasteMultiplier
    end

    --- Get the most recently observed channel duration for a spell
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return number
    function SpellTrackingManager:GetChannelDuration(spellId)
        if not spellId then
            return 0
        end

        local durations = self.state.channelDurations
        if durations and durations[spellId] and durations[spellId] > 0 then
            return durations[spellId]
        end

        if self.db and self.db.char and self.db.char.channelDurations then
            local persisted = self.db.char.channelDurations[spellId]
            if persisted and persisted > 0 then
                return persisted
            end
        end

        return 0
    end

    --- Get periodic effect info for a spell
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @param targetGUID? string Optional target GUID to get specific target data
    --- @return table|nil
    function SpellTrackingManager:GetPeriodicEffectInfo(spellId, targetGUID)
        local _, effect = self:ResolvePeriodicEffect(spellId)
        if not effect then return nil end

        if targetGUID then
            return effect.targets[targetGUID]
        end
        return effect
    end

    --- Get number of active dots for a spell
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return number
    function SpellTrackingManager:GetActiveDotCount(spellId)
        local _, effect = self:ResolvePeriodicEffect(spellId)
        if not effect then return 0 end

        -- Use actual aura state from targets
        local count = 0
        for guid, targetData in pairs(effect.targets) do
            -- Only count targets that have an active aura
            if targetData.active then
                count = count + 1
            end
        end

        return count
    end

    --- Get ICD tracking info for a spell
    --- @param self SpellTrackingManager
    --- @param spellId number
    --- @return number|nil remainingCooldown The remaining cooldown time, or nil if not tracked
    function SpellTrackingManager:GetICDInfo(spellId)
        local icdInfo = self.state.icdTracking[spellId]
        if not icdInfo then
            -- Auto-register for ICD tracking
            local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL) or
                DataManager:Get(spellId, DataManager.EntityTypes.ITEM)
            if entry and entry.icd then
                self:RegisterICD(spellId, entry.icd)
                icdInfo = self.state.icdTracking[spellId]
            else
                return nil
            end
        end

        if not icdInfo.lastProc then return nil end

        local timeSinceProc = StateManager:GetNextTime() - icdInfo.lastProc
        local remainingCooldown = icdInfo.duration - timeSinceProc

        return max(0, remainingCooldown)
    end
end

--- Estimate the value of a Combustion DoT if cast right now, mimicking the sim logic.
--- @param self SpellTrackingManager
--- @param unit string The unit to check Ignite on
--- @return number The estimated total Combustion DoT value
function SpellTrackingManager:GetCombustionDotEstimate(unit)
    -- Accepts a unit string (default 'target')
    unit = unit or "target"
    local targetGUID = UnitGUID(unit)
    local IGNITE_SPELL_ID = 413843           -- 12654 Replace with correct Ignite DoT spell ID for MoP
    local GLYPH_OF_COMBUSTION_ID = 56368     -- Replace with correct glyph ID if needed

    -- 1. Get current Ignite DoT tick value on the target
    local igniteEffect = self:GetPeriodicEffectInfo(IGNITE_SPELL_ID, targetGUID)
    local igniteTick = igniteEffect and igniteEffect.tickDamage or 0

    -- 1a. Apply igniteMultiplier from Mage class module (default 1)
    local igniteMultiplier = 1
    local mageModule = NAG:GetModule("MAGE", true)
    if mageModule then
        igniteMultiplier = mageModule.GetSetting and mageModule:GetSetting("char", "igniteMultiplier") or 1
    end
    local adjustedIgniteTick = igniteTick * igniteMultiplier

    -- 2. Check for Glyph of Combustion (double duration/damage)
    local hasGlyph = NAG.HasGlyph and NAG:HasGlyph(GLYPH_OF_COMBUSTION_ID)     -- Implement this utility if needed
    local combustionTickCount = hasGlyph and 20 or 10
    local combustionMultiplier = hasGlyph and 2.0 or 1.0

    -- 3. Pyromaniac (10% if active on target)
    local pyromaniacMultiplier = 1.0
    if NAG:UnitDebuff(unit, 132209) then     -- Pyromaniac aura ID (corrected)
        pyromaniacMultiplier = 1.1
    end

    -- Consolidated debug print for all input factors
    --print(format("[GetCombustionDotEstimate] unit=%s targetGUID=%s igniteTick=%.2f igniteMultiplier=%.2f adjustedIgniteTick=%.2f hasGlyph=%s combustionTickCount=%d combustionMultiplier=%.2f pyromaniacMultiplier=%.2f", tostring(unit), tostring(targetGUID), igniteTick, igniteMultiplier, adjustedIgniteTick, tostring(hasGlyph), combustionTickCount, combustionMultiplier, pyromaniacMultiplier))

    -- 4. Calculate Combustion DoT estimate
    local combustionDotEstimate = adjustedIgniteTick * 0.5 * combustionTickCount * combustionMultiplier *
        pyromaniacMultiplier
    --print(format("[GetCombustionDotEstimate] combustionDotEstimate=%.2f", combustionDotEstimate))

    return combustionDotEstimate
end

---
-- Detailed Combustion DoT estimate (ported from APL_Class.lua for comparison)
--- Unworking, for reference as removed from APL_Class.lua no GetTotalDamage() etc api atm
--- @param self SpellTrackingManager
--- @param unit string The unit to check Ignite on (default 'target')
--- @return number The estimated total Combustion DoT value (detailed version)
function SpellTrackingManager:GetCombustionDotEstimate_Detailed(unit)
    unit = unit or "target"
    local currentTime = GetTime()
    -- Use DataManager to get Ignite spell entity
    local igniteSpell = DataManager:Get(413843, DataManager.EntityTypes.SPELL)     -- Ignite spell ID
    if not igniteSpell then
        self:Print("[CombustionDetailed] Ignite spell entity not found.")
        return 0
    end
    -- Check if Ignite is active on target
    if not igniteSpell:IsActive('target') then
        self:Print("[CombustionDetailed] Ignite is not active on target.")
        return 0
    end
    -- Get Ignite's total remaining damage and ticks
    local igniteTotalDamage = igniteSpell:GetTotalDamage()
    local igniteRemainingTicks = igniteSpell:GetRemainingTicks()
    if igniteRemainingTicks <= 0 or igniteTotalDamage <= 0 then
        self:Print("[CombustionDetailed] Ignite has no remaining ticks or damage.")
        return 0
    end
    -- Calculate Ignite tick damage: total_amount / ticks_remaining
    local igniteTickDamage = igniteTotalDamage / igniteRemainingTicks
    -- Combustion tick damage is 50% of Ignite tick damage
    local combustionTickDamage = igniteTickDamage * 0.5
    -- Get Combustion duration based on glyph
    local hasGlyph = NAG.HasGlyph and NAG:HasGlyph(47170)     -- GLYPH_OF_COMBUSTION_ID
    local combustionDuration = hasGlyph and 20 or 10          -- COMBUSTION_GLYPH_DURATION or COMBUSTION_BASE_DURATION
    -- Get current haste percentage using compatibility functions
    local hastePercent = 0
    if GetHaste then
        hastePercent = GetHaste()
    elseif GetMeleeHaste then
        hastePercent = GetMeleeHaste()
    elseif UnitSpellHaste then
        hastePercent = UnitSpellHaste("player")
    end
    if not hastePercent or hastePercent < 0 then
        hastePercent = 0
    end
    -- Calculate tick interval with haste: 1 / (1 + Haste%)
    local baseTickInterval = 1.0     -- Combustion ticks every 1 second
    local hasteMultiplier = 1 + (hastePercent / 100)
    local tickInterval = baseTickInterval / hasteMultiplier
    tickInterval = math.max(0.1, math.min(tickInterval, 2.0))
    -- Calculate total number of ticks
    local totalTicks = math.floor(combustionDuration / tickInterval)
    totalTicks = math.max(1, totalTicks)
    -- Get current fire spell crit chance using compatibility functions
    local critChance = 0
    if GetSpellCritChance then
        critChance = GetSpellCritChance(2) -- 2 = Fire school
    elseif GetCritChance then
        critChance = GetCritChance()
    end
    if not critChance or critChance < 0 then
        critChance = 0
    end
    -- Apply crit multiplier: (1 + CritChance%)
    local critMultiplier = 1 + (critChance / 100)
    -- Calculate total Combustion damage
    local totalCombustionDamage = combustionTickDamage * totalTicks * critMultiplier
    if not totalCombustionDamage or totalCombustionDamage < 0 then
        totalCombustionDamage = 0
    end
    -- Print summarized debug info (2-3 lines)
    self:Print(format("[CombustionDetailed] IgniteTick: %.1f, CombustionTick: %.1f, Ticks: %d, Duration: %.1fs",
        igniteTickDamage, combustionTickDamage, totalTicks, combustionDuration))
    self:Print(format("[CombustionDetailed] Haste: %.1f%%, Crit: %.1f%%, TickInterval: %.2fs, Glyph: %s", hastePercent,
        critChance, tickInterval, hasGlyph and "Yes" or "No"))
    self:Print(format("[CombustionDetailed] Total Combustion Estimate: %.1f", totalCombustionDamage))
    return totalCombustionDamage
end

-- Debug UI using DebugFrameUtil
function SpellTrackingManager:GetDebugSections()
    local function travelTimeSection()
        local lines = {}
        for spellId, data in pairs(self.state.travelTime) do
            table.insert(lines, format(
                "SpellID: %d | STT: %s | inFlight: %s | projectileSpeed: %s",
                spellId,
                tostring(data.STT),
                data.inFlight and format("%.3f", data.inFlight) or "nil",
                tostring(data.projectileSpeed)
            ))
        end
        return lines
    end
    local function periodicEffectsSection()
        local lines = {}
        for spellId, effect in pairs(self.state.periodicEffects) do
            table.insert(lines, format("SpellID: %d | auraId: %s", spellId, tostring(effect.auraId)))
            for guid, tdata in pairs(effect.targets) do
                table.insert(lines,
                    format("  Target: %s | lastTickTime: %s | tickDamage: %s | wasCrit: %s | active: %s", guid,
                        tostring(tdata.lastTickTime), tostring(tdata.tickDamage), tostring(tdata.wasCrit),
                        tostring(tdata.active)))
            end
        end
        return lines
    end
    local function castTrackingSection()
        local lines = {}
        for spellId, tracking in pairs(self.state.castTracking) do
            table.insert(lines,
                format("SpellID: %d | lastCast: %s | recentCasts: [%s]", spellId, tostring(tracking.lastCast),
                    table.concat(tracking.recentCasts, ", ")))
        end
        return lines
    end
    local function icdTrackingSection()
        local lines = {}
        for spellId, icd in pairs(self.state.icdTracking) do
            table.insert(lines,
                format("SpellID: %d | duration: %s | lastProc: %s", spellId, tostring(icd.duration),
                    tostring(icd.lastProc)))
        end
        return lines
    end
    local sections = {
        { header = "Travel Time",      dataFn = travelTimeSection },
        { header = "Periodic Effects", dataFn = periodicEffectsSection },
        { header = "Cast Tracking",    dataFn = castTrackingSection },
        { header = "ICD Tracking",     dataFn = icdTrackingSection },
    }
    -- Add Combustion DoT Estimate if player is a mage
    local class = NAG.CLASS_FILENAME
    if class == "MAGE" then
        local function combustionEstimateSection()
            local lines = {}
            local estimate = self:GetCombustionDotEstimate("target")
            table.insert(lines, "Combustion DoT Estimate (original): " .. tostring(estimate))
            return lines
        end
        table.insert(sections, { header = "Combustion DoT Estimate", dataFn = combustionEstimateSection })
    end
    return sections
end

function SpellTrackingManager:ShowDebugFrame()
    ns.DebugFrameUtil:ShowDebugFrame(self, {
        title = "Spell Tracking Debug",
        sections = self:GetDebugSections(),
        refreshInterval = self.debugRefreshInterval or 1.0,
    })
end

function SpellTrackingManager:DebugSlashHandler()
    self:ShowDebugFrame()
end

--- Print lightweight cache stats for SpellTrackingManager
function SpellTrackingManager:StatsSlashHandler()
    local travelCount = TableUtils.Size(self.state.travelTime)
    local periodicCount = 0
    local targetEntries = 0
    for _, effect in pairs(self.state.periodicEffects) do
        periodicCount = periodicCount + 1
        if effect.targets then
            for _ in pairs(effect.targets) do targetEntries = targetEntries + 1 end
        end
    end
    local castCount = 0
    local recentCastsTotal = 0
    for _, tracking in pairs(self.state.castTracking) do
        castCount = castCount + 1
        if tracking.recentCasts then recentCastsTotal = recentCastsTotal + #tracking.recentCasts end
    end
    self:Info("[SpellTrack] travel=%d, periodic=%d, targets=%d, castEntries=%d, recentCasts=%d", travelCount,
        periodicCount, targetEntries, castCount, recentCastsTotal)
end
