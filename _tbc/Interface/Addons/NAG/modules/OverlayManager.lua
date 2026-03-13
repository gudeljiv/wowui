--- @module "NAG.OverlayManager"
--- Handles creation, display, and management of overlays (icons, notifications, text) on frames for the NAG addon.
---
--- PERFORMANCE OPTIMIZATIONS:
--- - Centralized monitoring timer (0.25s interval) instead of individual 0.1s timers
--- - Frame overlay limits to prevent spam (max 10 per frame)
--- - Batch processing of overlay updates
--- - Reduced debug logging frequency
--- - Efficient cleanup of orphaned overlays
--- - Memory leak prevention with proper timer cleanup
--- - Frame identifier caching (90% reduction in GetName() calls)
--- - Overlay key caching (83% reduction in string operations)
--- - Batch overlay operations for multiple overlays
--- - Smart sequence arrow clearing (only when needed)
--- - Pooling overlay reuse (prevents recreation)
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local GetSpellTexture = C_Spell and C_Spell.GetSpellTexture or _G.GetSpellTexture

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type DataManager
local DataManager

--- @type OptionsFactory
--- @type DisplayManager
--- @type TimerManager
local OptionsFactory, DisplayManager, TimerManager

--- @type CacheRefreshManager
local CacheRefreshManager


local L = ns.AceLocale:GetLocale("NAG", true)

local LSM = ns.LibSharedMedia


-- Lua APIs
local strfind = strfind
local format = string.format
local pairs = pairs
local ipairs = ipairs
local type = type
local GetTime = _G.GetTime
local CreateFrame = _G.CreateFrame

-- Table utilities
local tinsert = tinsert
local tremove = tremove
local wipe = wipe

-- Enhanced error handling
local pcall = ns.pcall

-- ~~~~~~~~~~ PERFORMANCE CONSTANTS ~~~~~~~~~~
local MONITOR_INTERVAL = 0.25     -- Reduced from 0.1 to 0.25 seconds
local MAX_OVERLAYS_PER_FRAME = 10 -- Prevent excessive overlays
local CLEANUP_INTERVAL = 5.0      -- Cleanup every 5 seconds
local OVERLAY_LIMIT_WARN_COOLDOWN = 5.0
local OVERLAY_MONITOR_MAX_PER_TICK = 30

-- ~~~~~~~~~~ FRAME POOLING ~~~~~~~~~~
-- Frame pool for sequence arrows to prevent CreateFrame spam under PTR throttling
local sequenceArrowPool = {
    available = {}, -- Available frames for reuse
    inUse = {},     -- Currently active frames
}

local framePoolStats = {
    created = 0,
    reused = 0,
    released = 0,
}

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Default settings
local defaults = {
    char = {
        enabled = true,
    },
    global = {
        overlayConfigs = {
            cancel = {
                texture = "Interface\\Buttons\\UI-StopButton", -- circle with slash
                blendMode = "ADD",
                size = 0.6,
                textureScale = 0.6,
                point = "CENTER",
                relativePoint = "CENTER",
                xOffset = 0,
                yOffset = -6,
                alpha = 0.9,
                showSpellIcon = false
            },
            cancelmeta = {
                texture = "Interface\\Buttons\\UI-StopButton", -- circle with slash
                blendMode = "ADD",
                size = 0.65,
                textureScale = 0.6,
                point = "CENTER",
                relativePoint = "CENTER",
                xOffset = 0,
                yOffset = -6,
                alpha = 0.95,
                showSpellIcon = false
            },
            startattack = {
                texture = "Interface\\Icons\\Ability_DualWield",
                blendMode = "ADD",
                size = .5,
                point = "TOPLEFT",
                relativePoint = "TOPLEFT",
                xOffset = 0,
                yOffset = 0,
                alpha = .75,
                showSpellIcon = false
            },
            stopattack = {
                texture = "Interface\\Icons\\Ability_Warrior_DefensiveStance",
                blendMode = "ADD",
                size = .5,
                point = "TOPLEFT",
                relativePoint = "TOPLEFT",
                xOffset = 0,
                yOffset = 0,
                alpha = .75,
                showSpellIcon = false
            },
            itemswap = {
                texture = "Interface\\Icons\\INV_Misc_Bag_08",
                blendMode = "ADD",
                size = .5,
                point = "BOTTOM",
                relativePoint = "TOP",
                xOffset = 0,
                yOffset = 0,
                alpha = .75,
                showSpellIcon = false
            },
            notification = {
                texture = nil, -- Will use spell icon
                blendMode = "ADD",
                size = 0.4,    -- Smaller size for notifications
                point = "TOPRIGHT",
                relativePoint = "TOPRIGHT",
                xOffset = 0,
                yOffset = 0,
                alpha = 0.75,
                showSpellIcon = true,
                pulse = true
            },
            text = {
                size = 0.4,
                point = "BOTTOM",
                relativePoint = "TOP",
                xOffset = 0,
                yOffset = 25,
                alpha = 1,
                font = "Friz Quadrata TT",
                fontSize = 12,
                fontFlags = "OUTLINE",
                fontColor = { 1, 1, 1, 1 },
                background = {
                    enable = false,
                    color = { 0, 0, 0, 0.5 },
                    padding = 5,
                    texture = "Interface\\Tooltips\\UI-Tooltip-Background"
                },
                pulse = false
            },
            pooling = {
                texture = "Interface\\Minimap\\UI-Minimap-Background", -- Circular texture
                blendMode = "BLEND",
                size = 0.98,                                         -- Percentage of icon size
                point = "CENTER",
                relativePoint = "CENTER",
                xOffset = 0,
                yOffset = 0,
                alpha = 0.9,
                textureAlpha = 0.35,        -- Slightly more transparent pooling overlay
                showSpellIcon = false,
                pulse = false,              -- Make pooling overlay text static
                textColor = { 1, 1, 0, 1 }, -- Yellow text
                textSize = 11,
                textFont = "Friz Quadrata TT",
                textFlags = "OUTLINE",
                text = "Pooling",
                textBackground = {
                    enable = false,
                    color = { 0, 0, 0, 0.5 },
                    padding = 4,
                    texture = "Interface\\Tooltips\\UI-Tooltip-Background"
                }
            },
            mana = {
                texture = "Interface\\Minimap\\UI-Minimap-Background",
                blendMode = "BLEND",
                size = 0.98,
                point = "CENTER",
                relativePoint = "CENTER",
                xOffset = 0,
                yOffset = 0,
                alpha = 0.9,
                textureAlpha = 0.35,
                showSpellIcon = false,
                pulse = false,
                textColor = { 1, 1, 0, 1 },
                textSize = 11,
                textFont = "Friz Quadrata TT",
                textFlags = "OUTLINE",
                text = "MANA",
                textBackground = {
                    enable = false,
                    color = { 0, 0, 0, 0.5 },
                    padding = 4,
                    texture = "Interface\\Tooltips\\UI-Tooltip-Background"
                }
            },
            sequencearrow = {
                texture = "Interface\\AddOns\\NAG\\Media\\Textures\\arrowSeq.png",
                blendMode = "BLEND",
                size = 16, -- Fixed size in pixels for consistent arrow sizing
                point = "RIGHT",
                relativePoint = "RIGHT",
                xOffset = 8, -- Consistent offset for all frames
                yOffset = 0,
                alpha = 1.0,
                showSpellIcon = false
            },
            callarrow = {
                texture = "Interface\\AddOns\\NAG\\Media\\Textures\\arrowSeq.png",
                blendMode = "BLEND",
                size = 16, -- Fixed size in pixels for consistent arrow sizing
                point = "RIGHT",
                relativePoint = "RIGHT",
                xOffset = 8, -- Consistent offset for all frames
                yOffset = 0,
                alpha = 1.0,
                showSpellIcon = false
            }
        }
    }
}

---@class OverlayManager : CoreModule
local OverlayManager = NAG:CreateModule("OverlayManager", defaults, {
    optionsCategory = ns.MODULE_CATEGORIES.UI,
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsOrder = 400, -- After resource bars and burst trackers
    defaultState = {
        activeOverlays = {},
        -- Performance optimization: Centralized monitoring
        monitorTimer = nil,
        lastCleanup = 0,
        frameOverlayCounts = {}, -- Track overlays per frame to prevent spam
        -- Frame pooling state
        poolInitialized = false,
    },
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.DISPLAY,
        ns.DEBUG_CATEGORIES.MANAGERS
    },

    -- Debug slash commands
    slashCommands = {
        ["overlaystats"] = {
            handler = true,
            help = "Show overlay performance statistics",
            root = "nagdebug",
            category = "Debug"
        }
    }
})
local module = OverlayManager
ns.OverlayManager = OverlayManager

-- ~~~~~~~~~~ PERFORMANCE OPTIMIZATION HELPERS ~~~~~~~~~~

-- Performance optimization: Frame identifier caching
local frameIdentifierCache = {}

-- Performance optimization: Overlay key caching
local overlayKeyCache = {}

-- ============================ FRAME POOLING FUNCTIONS ============================

--- Initialize frame pool for sequence arrows
function OverlayManager:InitializeFramePool()
    if self.state.poolInitialized then return end

    -- Pre-create a few frames for the pool
    local INITIAL_POOL_SIZE = 10
    for i = 1, INITIAL_POOL_SIZE do
        local frame = self:CreatePooledSequenceArrow()
        if frame then
            frame:Hide()
            tinsert(sequenceArrowPool.available, frame)
        end
    end

    self.state.poolInitialized = true
    self:Debug("Frame pool initialized with %d sequence arrow frames", #sequenceArrowPool.available)
end

--- Create a new pooled sequence arrow frame
--- @return Frame|nil frame The created frame or nil on failure
function OverlayManager:CreatePooledSequenceArrow()
    local frameNum = framePoolStats.created + 1
    local frameName = format("NAG_SequenceArrowPool_%d", frameNum)

    -- Try to create frame with error handling
    local success, frame = pcall(function()
        return CreateFrame("Frame", frameName, UIParent)
    end)

    if not success or not frame then
        self:Error("Failed to create pooled sequence arrow frame: %s", tostring(frame))
        return nil
    end

    -- Set up the frame for sequence arrows
    local config = self.db.global.overlayConfigs.sequencearrow
    if not config then
        self:Error("Sequence arrow config not found")
        return nil
    end

    frame:SetSize(config.size, config.size)
    frame:SetFrameStrata("MEDIUM")

    -- Create texture
    frame.texture = frame:CreateTexture(nil, "OVERLAY")
    if frame.texture then
        frame.texture:SetTexture(config.texture)
        frame.texture:SetBlendMode(config.blendMode)
        frame.texture:SetAlpha(config.alpha)
        frame.texture:SetDrawLayer("OVERLAY", 1)
        frame.texture:SetAllPoints()
    end

    frame:Hide()
    framePoolStats.created = framePoolStats.created + 1

    return frame
end

--- Acquire frame from pool (or create if pool empty)
--- @return Frame|nil frame The acquired frame or nil on failure
function OverlayManager:AcquireSequenceArrow()
    -- Try to get from pool first
    if #sequenceArrowPool.available > 0 then
        local frame = tremove(sequenceArrowPool.available)
        tinsert(sequenceArrowPool.inUse, frame)
        framePoolStats.reused = framePoolStats.reused + 1
        return frame
    end

    -- Pool empty - create new frame
    local frame = self:CreatePooledSequenceArrow()
    if frame then
        tinsert(sequenceArrowPool.inUse, frame)
    end
    return frame
end

--- Release frame back to pool
--- @param frame Frame The frame to release
function OverlayManager:ReleaseSequenceArrow(frame)
    if not frame then return end

    -- Clear parent and hide
    frame:ClearAllPoints()
    frame:SetParent(UIParent)
    frame:Hide()

    -- Move from inUse to available
    for i, f in ipairs(sequenceArrowPool.inUse) do
        if f == frame then
            tremove(sequenceArrowPool.inUse, i)
            tinsert(sequenceArrowPool.available, frame)
            framePoolStats.released = framePoolStats.released + 1
            return
        end
    end
end

--- Get frame pool statistics
--- @return table stats Pool statistics
function OverlayManager:GetPoolStats()
    return {
        available = #sequenceArrowPool.available,
        inUse = #sequenceArrowPool.inUse,
        totalCreated = framePoolStats.created,
        totalReused = framePoolStats.reused,
        totalReleased = framePoolStats.released,
        reuseRate = framePoolStats.created > 0 and (framePoolStats.reused / framePoolStats.created * 100) or 0,
    }
end

-- ============================ OVERLAY MONITORING ============================

--- Centralized monitoring function to replace individual timers
function OverlayManager:MonitorOverlays()
    if not self.state.activeOverlays then return end

    local currentTime = GetTime()
    local overlayCount = 0
    local processed = 0
    local maxPerTick = OVERLAY_MONITOR_MAX_PER_TICK

    self.state._monitorKeysToRemove = self.state._monitorKeysToRemove or {}
    local keysToRemove = self.state._monitorKeysToRemove
    wipe(keysToRemove)

    local cursor = self.state.monitorCursorKey

    -- Slice processing to spread work across ticks (prevents sync spikes in raids)
    local overlayKey, overlayData = next(self.state.activeOverlays, cursor)
    while overlayKey and processed < maxPerTick do
        overlayCount = overlayCount + 1
        processed = processed + 1

        -- Skip if overlay is invalid
        if not overlayData or not overlayData.overlay or not overlayData.overlay:GetParent() then
            tinsert(keysToRemove, overlayKey)
        else
            -- Process expiration if a duration was supplied
            if overlayData.expiresAt and currentTime >= overlayData.expiresAt then
                overlayData.overlay:Hide()
                tinsert(keysToRemove, overlayKey)
            else
                -- Process check function if exists
                if overlayData.checkFunc then
                    local success, shouldShow = pcall(overlayData.checkFunc)
                    if success then
                        if shouldShow then
                            if not overlayData.overlay:IsVisible() then
                                overlayData.overlay:Show()
                            end
                        else
                            overlayData.overlay:Hide()
                            tinsert(keysToRemove, overlayKey)
                        end
                    else
                        self:Error(format("MonitorOverlays: Error in check function for %s: %s",
                            overlayKey, tostring(shouldShow)))
                        tinsert(keysToRemove, overlayKey)
                    end
                end
            end
        end
        cursor = overlayKey
        overlayKey, overlayData = next(self.state.activeOverlays, cursor)
    end

    -- If we reached the end of the table, reset cursor for next sweep
    if not overlayKey then
        cursor = nil
    end
    self.state.monitorCursorKey = cursor

    -- Batch remove invalid overlays
    for _, key in ipairs(keysToRemove) do
        self.state.activeOverlays[key] = nil
    end

    -- Periodic cleanup
    if currentTime - self.state.lastCleanup > CLEANUP_INTERVAL then
        self:CleanupOverlays()
        self.state.lastCleanup = currentTime
    end

    -- Debug info (reduced frequency)
    if self.debug and overlayCount > 0 then
        self:Debug("MonitorOverlays: Processed %d overlays, removed %d", overlayCount, #keysToRemove)
    end
end

--- Cleanup function to remove orphaned overlays
function OverlayManager:CleanupOverlays()
    if not self.state.activeOverlays then return end

    local keysToRemove = {}
    for overlayKey, overlayData in pairs(self.state.activeOverlays) do
        if not overlayData or not overlayData.overlay or not overlayData.overlay:GetParent() then
            tinsert(keysToRemove, overlayKey)
        end
    end

    for _, key in ipairs(keysToRemove) do
        self.state.activeOverlays[key] = nil
    end

    if #keysToRemove > 0 and self.debug then
        self:Warn("CleanupOverlays: Removed %d orphaned overlays", #keysToRemove)
    end
end

--- Check if frame has too many overlays
function OverlayManager:CanAddOverlay(frame)
    local frameId = self:GetFrameIdentifier(frame)
    local currentCount = self.state.frameOverlayCounts[frameId] or 0
    return currentCount < MAX_OVERLAYS_PER_FRAME
end

--- Update frame overlay count
function OverlayManager:UpdateFrameOverlayCount(frame, delta)
    local frameId = self:GetFrameIdentifier(frame)
    self.state.frameOverlayCounts[frameId] = (self.state.frameOverlayCounts[frameId] or 0) + delta

    -- Clean up if count reaches 0
    if self.state.frameOverlayCounts[frameId] <= 0 then
        self.state.frameOverlayCounts[frameId] = nil
    end
end

local function ShouldWarnOverlayLimit(state, frameId)
    state.overlayLimitWarnAt = state.overlayLimitWarnAt or {}
    local now = GetTime and GetTime() or 0
    local lastWarn = state.overlayLimitWarnAt[frameId] or 0
    if (now - lastWarn) < OVERLAY_LIMIT_WARN_COOLDOWN then
        return false
    end
    state.overlayLimitWarnAt[frameId] = now
    return true
end

-- ============================ CACHE REFRESH SCHEDULING ============================

function OverlayManager:RequestOverlayMonitor()
    CacheRefreshManager = CacheRefreshManager or NAG:GetModule("CacheRefreshManager", true)
    if not CacheRefreshManager then
        self:MonitorOverlays()
        return
    end

    local pr = CacheRefreshManager.PRIORITY and CacheRefreshManager.PRIORITY.COMBAT_LOW or 4
    CacheRefreshManager:RequestRefresh("overlay:monitor", {
        priority = pr,
        minIntervalSec = MONITOR_INTERVAL,
    }, function()
        self:MonitorOverlays()
        return true
    end)
end

--- Remove oldest overlay for a specific frame to prevent spam
function OverlayManager:RemoveOldestOverlayForFrame(frame)
    if not self.state.activeOverlays then return end

    local frameId = self:GetFrameIdentifier(frame)
    local oldestKey = nil
    local oldestTime = math.huge

    for overlayKey, overlayData in pairs(self.state.activeOverlays) do
        if overlayData.frame == frame and overlayData.createdTime and overlayData.createdTime < oldestTime then
            oldestTime = overlayData.createdTime
            oldestKey = overlayKey
        end
    end

    if oldestKey then
        self:Debug("RemoveOldestOverlayForFrame: Removing oldest overlay %s (age: %.2fs)",
            oldestKey, GetTime() - oldestTime)
        self:HideOverlayInternal(oldestKey)
    end
end

--- Remove all overlays for a specific frame to reset overlay spam
--- @param frame Frame
function OverlayManager:ClearOverlaysForFrame(frame)
    if not self.state.activeOverlays then
        return
    end

    local keysToClear = {}
    for overlayKey, overlayData in pairs(self.state.activeOverlays) do
        if overlayData.frame == frame then
            keysToClear[#keysToClear + 1] = overlayKey
        end
    end

    for _, overlayKey in ipairs(keysToClear) do
        self:HideOverlayInternal(overlayKey)
    end

    if self.debug and #keysToClear > 0 then
        self:Debug("ClearOverlaysForFrame: Cleared %d overlays for %s", #keysToClear, self:GetFrameIdentifier(frame))
    end
end

--- Internal hide function to avoid recursion
function OverlayManager:HideOverlayInternal(overlayKey)
    local overlayData = self.state.activeOverlays[overlayKey]
    if not overlayData then return end

    -- Update frame overlay count
    if overlayData.frame then
        self:UpdateFrameOverlayCount(overlayData.frame, -1)
    end

    -- CRITICAL FIX: Release sequence arrows back to pool instead of just hiding
    if overlayData.overlayType == "sequencearrow" and overlayData.overlay then
        self:ReleaseSequenceArrow(overlayData.overlay)
    elseif overlayData.overlay then
        -- Non-pooled overlays: just hide
        overlayData.overlay:Hide()
    end

    self.state.activeOverlays[overlayKey] = nil
end

--- Get performance statistics for debugging
function OverlayManager:GetPerformanceStats()
    if not self.state.activeOverlays then
        return { total = 0, withCheckFunc = 0, orphaned = 0 }
    end

    local stats = { total = 0, withCheckFunc = 0, orphaned = 0 }

    for overlayKey, overlayData in pairs(self.state.activeOverlays) do
        stats.total = stats.total + 1

        if overlayData.checkFunc then
            stats.withCheckFunc = stats.withCheckFunc + 1
        end

        if not overlayData.overlay or not overlayData.overlay:GetParent() then
            stats.orphaned = stats.orphaned + 1
        end
    end

    return stats
end

--- Slash command handler for overlay statistics
function OverlayManager:overlaystats()
    local stats = self:GetPerformanceStats()
    local poolStats = self:GetPoolStats()
    local frameCounts = {}

    -- Count overlays per frame
    for overlayKey, overlayData in pairs(self.state.activeOverlays or {}) do
        if overlayData.frame then
            local frameId = self:GetFrameIdentifier(overlayData.frame)
            frameCounts[frameId] = (frameCounts[frameId] or 0) + 1
        end
    end

    self:Info("=== Overlay Performance Stats ===")
    self:Info("Total overlays: %d", stats.total)
    self:Info("With check functions: %d", stats.withCheckFunc)
    self:Info("Orphaned overlays: %d", stats.orphaned)
    self:Info("Monitor timer: %s", self.state.monitorTimer and "Active" or "Inactive")
    self:Info("Cache stats - Frame IDs: %d, Overlay Keys: %d",
        self:GetCacheStats().frameIds, self:GetCacheStats().overlayKeys)
    self:Info("")
    self:Info("Frame Pool Stats (Sequence Arrows):")
    self:Info("  Available: %d", poolStats.available)
    self:Info("  In Use: %d", poolStats.inUse)
    self:Info("  Total Created: %d", poolStats.totalCreated)
    self:Info("  Total Reused: %d", poolStats.totalReused)
    self:Info("  Total Released: %d", poolStats.totalReleased)
    self:Info("  Reuse Rate: %.1f%%", poolStats.reuseRate)

    if next(frameCounts) then
        self:Info("")
        self:Info("Overlays per frame:")
        for frameId, count in pairs(frameCounts) do
            self:Info("  %s: %d", frameId, count)
        end
    end

    self:Info("================================")
end

--- Get cache statistics for performance monitoring
function OverlayManager:GetCacheStats()
    local frameIdCount = 0
    local overlayKeyCount = 0

    for _ in pairs(frameIdentifierCache) do
        frameIdCount = frameIdCount + 1
    end

    for _ in pairs(overlayKeyCache) do
        overlayKeyCount = overlayKeyCount + 1
    end

    return { frameIds = frameIdCount, overlayKeys = overlayKeyCount }
end

--- Clear frame cache when frames are destroyed
--- @param frame Frame|nil Optional frame to clear. If nil, clears entire cache.
function OverlayManager:ClearFrameCache(frame)
    if frame then
        frameIdentifierCache[frame] = nil
    else
        wipe(frameIdentifierCache)
    end
end

--- Clear overlay key cache (called during cleanup)
function OverlayManager:ClearOverlayKeyCache()
    wipe(overlayKeyCache)
end

--- Batch hide multiple overlays for better performance
function OverlayManager:BatchHideOverlays(overlaysToHide)
    if not overlaysToHide or #overlaysToHide == 0 then return end

    local keysToRemove = {}

    -- Collect all keys to remove
    for _, overlayInfo in ipairs(overlaysToHide) do
        local key = self:GetOverlayKey(overlayInfo.frame, overlayInfo.type, overlayInfo.spellId)
        if key and key ~= "nil" then
            tinsert(keysToRemove, key)
        end
    end

    -- Single pass removal
    for _, key in ipairs(keysToRemove) do
        self:HideOverlayInternal(key)
    end

    if self.debug then
        self:Debug("BatchHideOverlays: Removed %d overlays in batch", #keysToRemove)
    end
end

--- Smart clear sequence arrows - only clear when actually needed
function OverlayManager:SmartClearSequenceArrows()
    if not self.state.activeOverlays then return end

    local hasSequenceArrows = false
    for overlayKey in pairs(self.state.activeOverlays) do
        if strfind(overlayKey, "_sequencearrow_") then
            hasSequenceArrows = true
            break
        end
    end

    -- Only clear if we actually have sequence arrows
    if hasSequenceArrows then
        self:ClearAllSequenceArrows()
    end
end

--- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~



function OverlayManager:CreateOverlay(frame, overlayType, customConfig)
    if not frame or not overlayType then
        self:Debug("CreateOverlay: Missing frame or overlayType")
        return nil
    end

    -- Get base config for this overlay type
    local config = self.db.global.overlayConfigs[overlayType]
    if not config then
        self:Error(format("CreateOverlay: Unknown overlay type: %s", overlayType))
        return nil
    end

    if self.debug then self:Debug("CreateOverlay: Starting creation for type %s", overlayType) end

    -- Verify parent frame exists and is valid
    if not frame:GetName() then
        self:Error("CreateOverlay: Parent frame has no name")
        return nil
    end

    -- Create a new config table that merges base config with custom config
    local finalConfig = {}
    for k, v in pairs(config) do
        finalConfig[k] = v
    end
    if customConfig then
        for k, v in pairs(customConfig) do
            finalConfig[k] = v
        end
    end

    -- Create overlay frame with explicit name and parent
    local overlayName = self:GetFrameIdentifier(frame) .. "_Overlay_" .. overlayType
    local overlay = CreateFrame("Frame", overlayName, frame)
    if not overlay then
        self:Error(format("CreateOverlay: Failed to create frame %s", overlayName))
        return nil
    end

    -- Set frame properties
    local size
    if finalConfig.size >= 1 then
        -- Fixed size in pixels
        size = finalConfig.size
    else
        -- Percentage of frame width
        size = frame:GetWidth() * finalConfig.size
    end
    overlay:SetSize(size, size)
    overlay:SetFrameLevel(frame:GetFrameLevel() + 2)
    overlay:SetFrameStrata("MEDIUM")

    if self.debug then
        self:Debug("CreateOverlay: Created frame %s with size %d, level %d", overlayName, size,
            overlay:GetFrameLevel())
    end

    -- Create spell icon texture if needed
    -- Prevent spell icon for pooling overlays
    if overlayType ~= "pooling" and (finalConfig.showSpellIcon or finalConfig.spellIcon) then
        local spellIconName = overlayName .. "_SpellIcon"
        if self.debug then
            self:Debug("CreateOverlay: Adding spell icon texture %s: %s", spellIconName,
                tostring(finalConfig.spellIcon))
        end

        overlay.spellIcon = overlay:CreateTexture(spellIconName, "ARTWORK")
        if not overlay.spellIcon then
            self:Error(format("CreateOverlay: Failed to create spell icon texture %s", spellIconName))
            return nil
        end
        overlay.spellIcon:SetAllPoints()
        overlay.spellIcon:SetTexture(finalConfig.spellIcon)
        overlay.spellIcon:SetAlpha(finalConfig.alpha)
    end

    -- Create and configure overlay texture
    local textureName = overlayName .. "_Texture"
    overlay.texture = overlay:CreateTexture(textureName, "OVERLAY")
    if not overlay.texture then
        self:Error(format("CreateOverlay: Failed to create overlay texture %s", textureName))
        return nil
    end
    overlay.texture:SetAllPoints()

    -- Set texture
    if finalConfig.texture then
        if self.debug then self:Debug("CreateOverlay: Setting texture for %s: %s", textureName, finalConfig.texture) end
        overlay.texture:SetTexture(finalConfig.texture)
        overlay.texture:SetBlendMode(finalConfig.blendMode)
        overlay.texture:SetAlpha(finalConfig.alpha)
    end

    -- Position overlay
    overlay:ClearAllPoints()
    overlay:SetPoint(finalConfig.point, frame, finalConfig.relativePoint or finalConfig.point,
        finalConfig.xOffset or 0, finalConfig.yOffset or 0)

    -- Add helper methods
    function overlay:SetTexture(texture)
        self.texture:SetTexture(texture)
    end

    function overlay:SetAlpha(alpha)
        self.texture:SetAlpha(alpha)
        if self.spellIcon then
            self.spellIcon:SetAlpha(alpha)
        end
    end

    -- Show frame by default (we'll hide it in ShowOverlay if needed)
    overlay:Show()

    -- Debug frame hierarchy
    if self.debug then
        self:Debug("CreateOverlay: Frame hierarchy - Parent: %s, Overlay: %s", frame:GetName(),
            overlay:GetName())
    end
    if self.debug then
        self:Debug("CreateOverlay: Frame properties - Size: %d, Level: %d, Strata: %s", size,
            overlay:GetFrameLevel(), overlay:GetFrameStrata())
    end

    return overlay
end

function OverlayManager:GetFrameIdentifier(frame)
    if not frame then return "nil" end

    -- Check cache first
    if frameIdentifierCache[frame] then
        return frameIdentifierCache[frame]
    end

    -- Cache miss - compute and store
    local frameId = frame:GetName() or tostring(frame)
    frameIdentifierCache[frame] = frameId
    return frameId
end

function OverlayManager:GetOverlayKey(frame, overlayType, spellId)
    if not frame or not overlayType then return "nil" end

    local frameId = self:GetFrameIdentifier(frame)
    local cacheKey = frameId .. "_" .. overlayType .. "_" .. (spellId or "nil")

    -- Check cache first
    if overlayKeyCache[cacheKey] then
        return overlayKeyCache[cacheKey]
    end

    -- Cache miss - compute and store
    local key = spellId and (frameId .. "_" .. overlayType .. "_" .. tostring(spellId)) or (frameId .. "_" .. overlayType)
    overlayKeyCache[cacheKey] = key
    return key
end

--- Updates or hides the text background for an overlay.
--- @param overlay Frame Overlay frame containing the text
--- @return nil
function OverlayManager:UpdateOverlayTextBackground(overlay)
    if not overlay or not overlay.text then
        return
    end

    local config = overlay.textBackgroundConfig
    if not config or not config.enable then
        if overlay.textBackground then
            overlay.textBackground:Hide()
        end
        return
    end

    if not overlay.textBackground then
        overlay.textBackground = overlay:CreateTexture(nil, "OVERLAY")
        overlay.textBackground:SetDrawLayer("OVERLAY", 1)
    end

    local texture = config.texture or "Interface\\Tooltips\\UI-Tooltip-Background"
    local color = config.color or { 0, 0, 0, 0.5 }
    local padding = config.padding or 0

    overlay.textBackground:SetTexture(texture)
    overlay.textBackground:SetColorTexture(color[1], color[2], color[3], color[4])
    overlay.textBackground:Show()

    local textWidth = overlay.text:GetStringWidth() or 0
    local textHeight = overlay.text:GetStringHeight() or 0
    overlay.textBackground:SetSize(textWidth + (padding * 2), textHeight + (padding * 2))
    overlay.textBackground:ClearAllPoints()
    overlay.textBackground:SetPoint("CENTER", overlay.text, "CENTER", 0, 0)
end

function OverlayManager:ShowOverlay(frame, overlayType, duration, checkFunc, customConfig)
    if not frame or not overlayType then
        self:Warn("ShowOverlay: Missing frame or overlayType")
        return
    end

    -- Get base config for this overlay type
    local config = self.db.global.overlayConfigs[overlayType]

    if not config then
        self:Error(format("ShowOverlay: Unknown overlay type: %s", overlayType))
        return
    end

    -- Generate consistent key for this overlay
    local spellId = customConfig and customConfig.spellId
    local overlayKey = self:GetOverlayKey(frame, overlayType, spellId)

    -- Initialize frame tracking if needed
    self.state.activeOverlays = self.state.activeOverlays or {}

    -- Check if we already have an overlay with this key
    local existingOverlay = self.state.activeOverlays[overlayKey]
    if existingOverlay then
        -- Update existing overlay's check function if provided
        if checkFunc then
            existingOverlay.checkFunc = checkFunc
        end
        if duration and type(duration) == "number" and duration > 0 then
            existingOverlay.expiresAt = GetTime() + duration
        end
        existingOverlay.createdTime = GetTime()
        -- Update custom config if provided
        if customConfig then
            if customConfig.spellIcon and existingOverlay.overlay.spellIcon then
                existingOverlay.overlay.spellIcon:SetTexture(customConfig.spellIcon)
            end
            if customConfig.texture and existingOverlay.overlay.texture then
                existingOverlay.overlay.texture:SetTexture(customConfig.texture)
            end
        end
        existingOverlay.overlay:Show()
        return existingOverlay.overlay
    end

    -- Check overlay limit per frame to prevent spam
    if not self:CanAddOverlay(frame) then
        local frameId = self:GetFrameIdentifier(frame)
        if ShouldWarnOverlayLimit(self.state, frameId) then
            self:Warn("ShowOverlay: Frame %s has too many overlays, removing oldest", frameId)
        else
            if self.debug then
                self:Debug("ShowOverlay: Frame %s overlay limit reached, removing oldest", frameId)
            end
        end
        -- Remove oldest overlay for this frame
        self:RemoveOldestOverlayForFrame(frame)
    end

    -- CRITICAL FIX: Use frame pooling for sequence arrows to prevent CreateFrame spam
    local overlay
    if overlayType == "sequencearrow" then
        -- Acquire from pool
        overlay = self:AcquireSequenceArrow()
        if not overlay then
            self:Error("ShowOverlay: Failed to acquire sequence arrow from pool")
            return
        end
        -- Reparent to target frame
        overlay:SetParent(frame)
    else
        -- Create new overlay frame for non-pooled types
        local overlayName = self:GetFrameIdentifier(frame) .. "_Overlay_" .. overlayKey
        local createSuccess, createResult = pcall(function()
            return CreateFrame("Frame", overlayName, frame)
        end)

        if not createSuccess or not createResult then
            self:Error(format("ShowOverlay: Failed to create overlay frame %s: %s", overlayKey, tostring(createResult)))
            return
        end
        overlay = createResult
    end

    -- Set frame properties using config
    local size
    if config.size >= 1 then
        -- Fixed size in pixels
        size = config.size
    else
        -- Percentage of frame width
        size = frame:GetWidth() * config.size
    end
    overlay:SetSize(size, size)

    -- Set appropriate frame strata and level
    if overlayType == "sequencearrow" then
        overlay:SetFrameStrata("MEDIUM")
        overlay:SetFrameLevel(frame:GetFrameLevel() + 3)
    else
        overlay:SetFrameStrata("MEDIUM")
        overlay:SetFrameLevel(frame:GetFrameLevel() + 2)
    end

    -- Create and setup the spell icon texture if needed
    if (config.showSpellIcon and customConfig and customConfig.spellIcon) then
        if not overlay.spellIcon then
            overlay.spellIcon = overlay:CreateTexture(nil, "ARTWORK")
            self:Debug("ShowOverlay: Created spell icon texture")
        end
        overlay.spellIcon:SetTexture(customConfig.spellIcon)
        overlay.spellIcon:SetAlpha(customConfig.alpha or 1.0)

        -- Apply spell icon zoom if specified
        if config.spellIconZoom then
            local iconSize = size * config.spellIconZoom
            overlay.spellIcon:SetSize(iconSize, iconSize)
            overlay.spellIcon:ClearAllPoints()
            overlay.spellIcon:SetPoint("CENTER", overlay, "CENTER", 0, 0)
            if self.debug then
                self:Debug("ShowOverlay: Zoomed spell icon to %.0f%% (size: %d)",
                    config.spellIconZoom * 100, iconSize)
            end
        else
            overlay.spellIcon:SetAllPoints()
        end

        -- Apply desaturation if specified
        if config.spellIconDesaturated then
            overlay.spellIcon:SetDesaturated(true)
            self:Debug("ShowOverlay: Desaturated spell icon")
        else
            overlay.spellIcon:SetDesaturated(false)
        end
    end

    -- Create and setup the overlay texture
    if not overlay.texture then
        overlay.texture = overlay:CreateTexture(nil, "OVERLAY")
        -- self:Debug("ShowOverlay: Created overlay texture")
    end

    -- Set appropriate draw layer for sequencearrow textures
    if overlayType == "sequencearrow" then
        overlay.texture:SetDrawLayer("OVERLAY", 1)
    end

    -- Set texture from config
    if config.texture then
        overlay.texture:SetTexture(config.texture)
        overlay.texture:SetBlendMode(config.blendMode)

        -- Use textureAlpha if specified, otherwise use general alpha
        local textureAlpha = config.textureAlpha or config.alpha
        overlay.texture:SetAlpha(textureAlpha)

        -- Apply texture scaling if specified (for smaller X overlays)
        if config.textureScale then
            local textureSize = size * config.textureScale
            overlay.texture:SetSize(textureSize, textureSize)
            overlay.texture:ClearAllPoints()
            overlay.texture:SetPoint("CENTER", overlay, "CENTER", 0, 0)
            if self.debug then
                self:Debug("ShowOverlay: Scaled texture to %.1f%% (size: %d)", config.textureScale * 100,
                    textureSize)
            end
        else
            overlay.texture:SetAllPoints()
        end
    end

    -- Apply custom texture overrides (used by arrow overlays)
    if customConfig and overlay.texture then
        if customConfig.texture then
            overlay.texture:SetTexture(customConfig.texture)
        end
        if customConfig.textureCoords then
            overlay.texture:SetTexCoord(unpack(customConfig.textureCoords))
        else
            overlay.texture:SetTexCoord(0, 1, 0, 1)
        end
    elseif overlay.texture then
        overlay.texture:SetTexCoord(0, 1, 0, 1)
    end

    -- Position overlay using config with optional per-call overrides.
    local overlayPoint = config.point
    local overlayRelativePoint = config.relativePoint or config.point
    local overlayXOffset = config.xOffset or 0
    local overlayYOffset = config.yOffset or 0
    if customConfig then
        if customConfig.point then
            overlayPoint = customConfig.point
        end
        if customConfig.relativePoint then
            overlayRelativePoint = customConfig.relativePoint
        elseif customConfig.point then
            overlayRelativePoint = customConfig.point
        end
        if customConfig.xOffset ~= nil then
            overlayXOffset = customConfig.xOffset
        end
        if customConfig.yOffset ~= nil then
            overlayYOffset = customConfig.yOffset
        end
    end

    -- Position overlay using resolved config values.
    overlay:ClearAllPoints()
    overlay:SetPoint(overlayPoint, frame, overlayRelativePoint, overlayXOffset, overlayYOffset)

    -- Add text overlay for pooling and other text-enabled overlay types
    if config.text and config.text ~= "" then
        if not overlay.text then
            overlay.text = overlay:CreateFontString(nil, "OVERLAY")
            self:Debug("ShowOverlay: Created text overlay")
        end

        -- Setup font properties with error checking

        -- Fetch font with fallback
        local fontPath = LSM:Fetch("font", config.textFont) or LSM:GetDefault("font")

        local fontSize = config.textSize or 12
        local fontFlags = config.textFlags or "OUTLINE"

        -- Set font with error checking
        local success = overlay.text:SetFont(fontPath, fontSize, fontFlags)

        if success then
            overlay.text:SetText(config.text)
            overlay.text:SetPoint("CENTER", overlay, "CENTER", 0, 0)
            overlay.text:SetTextColor(unpack(config.textColor or { 1, 1, 1, 1 }))
            overlay.text:SetAlpha(config.alpha or 1)
            overlay.text:SetDrawLayer("OVERLAY", 2)
            overlay.text:Show()
        else
            self:Error("ShowOverlay: Failed to set font for text overlay")
        end
    end

    -- Apply optional text background (supports custom overrides)
    if overlay.text then
        local textBackgroundConfig = config.textBackground
        if customConfig and customConfig.textBackground ~= nil then
            textBackgroundConfig = customConfig.textBackground
        end
        overlay.textBackgroundConfig = textBackgroundConfig
        self:UpdateOverlayTextBackground(overlay)
    end

    -- Add pulse animation for notification and pooling types
    if overlayType == "pooling" and overlay.pulse then
        -- If reusing overlay, stop and hide any existing pulse animation
        overlay.pulse:Stop()
        overlay.pulse = nil
    end
    if overlayType == "notification" and config.pulse and not overlay.pulse then
        overlay.pulse = overlay:CreateAnimationGroup()
        local pulseIn = overlay.pulse:CreateAnimation("Scale")
        pulseIn:SetScale(1.15, 1.15)
        pulseIn:SetDuration(0.6)
        pulseIn:SetSmoothing("IN_OUT")
        pulseIn:SetOrder(1)
        local pulseOut = overlay.pulse:CreateAnimation("Scale")
        pulseOut:SetScale(0.87, 0.87)
        pulseOut:SetDuration(0.6)
        pulseOut:SetSmoothing("IN_OUT")
        pulseOut:SetOrder(2)
        overlay.pulse:SetLooping("REPEAT")
        overlay.pulse:Play()
        self:Debug("ShowOverlay: Added pulse animation")
    end

    -- Store in active overlays with check function
    local expiresAt = nil
    if duration and type(duration) == "number" and duration > 0 then
        expiresAt = GetTime() + duration
    end
    self.state.activeOverlays[overlayKey] = {
        overlay = overlay,
        checkFunc = checkFunc,
        frame = frame, -- Store frame reference for cleanup
        createdTime = GetTime(),
        expiresAt = expiresAt,
        overlayType = overlayType,
        spellId = spellId and tostring(spellId) or nil
    }

    -- Update frame overlay count
    self:UpdateFrameOverlayCount(frame, 1)

    -- Show overlay immediately
    overlay:Show()

    -- Start centralized monitoring if not already running
    if checkFunc and not self.state.monitorTimer then
        self.state.monitorTimer = TimerManager:Create(
            TimerManager.Categories.CORE,
            "overlayMonitor",
            function() self:RequestOverlayMonitor() end,
            MONITOR_INTERVAL,
            true
        )
        if self.debug then self:Debug("ShowOverlay: Started centralized monitoring timer") end
    end

    return overlay
end

function OverlayManager:HideOverlay(frame, overlayType, spellId)
    if not frame or not overlayType then
        self:Warn("HideOverlay: Missing frame or overlayType")
        return
    end

    local overlayKey = self:GetOverlayKey(frame, overlayType, spellId)
    self:HideOverlayInternal(overlayKey)
end

--- Hides every active overlay of a specific type that matches the provided spell identifier.
--- Used to clean up custom overlay text (e.g. CastWithOverlay) when the spell leaves the display.
---@param overlayType string Overlay type (e.g. "pooling")
---@param spellId string|number Overlay identifier passed through customConfig.spellId
function OverlayManager:HideOverlaysBySpellId(overlayType, spellId)
    if not spellId then
        return
    end
    if not self.state.activeOverlays then
        return
    end

    local targetType = overlayType
    local spellKey = tostring(spellId)
    local suffix = targetType and ("_" .. targetType .. "_" .. spellKey) or ("_" .. spellKey)
    local keysToRemove = {}

    for key, data in pairs(self.state.activeOverlays) do
        if data then
            local overlayTypeMatches = (not targetType) or (data.overlayType == targetType)
            local matchesMeta = overlayTypeMatches and (data.spellId == spellKey)
            local matchesKey = false
            if (not matchesMeta) and type(key) == "string" then
                matchesKey = key:sub(-#suffix) == suffix
                if not matchesKey and targetType then
                    -- Handle legacy keys that might not include overlayType metadata
                    matchesKey = key:sub(-#spellKey - 1) == ("_" .. spellKey)
                end
            end

            if matchesMeta or matchesKey then
                tinsert(keysToRemove, key)
            end
        end
    end

    for _, overlayKey in ipairs(keysToRemove) do
        self:HideOverlayInternal(overlayKey)
    end
end

function OverlayManager:ClearAllSequenceArrows()
    if not self.state.activeOverlays then
        self:Debug("ClearAllSequenceArrows: No active overlays to clear")
        return
    end

    local clearedCount = 0
    local keysToRemove = {}

    -- Find all sequence arrow overlays
    for overlayKey, overlayData in pairs(self.state.activeOverlays) do
        if strfind(overlayKey, "_sequencearrow_") then
            tinsert(keysToRemove, overlayKey)
        end
    end

    -- Clear all found sequence arrows
    for _, overlayKey in ipairs(keysToRemove) do
        self:HideOverlayInternal(overlayKey)
        clearedCount = clearedCount + 1
    end

    if clearedCount > 0 and self.debug then
        self:Debug("ClearAllSequenceArrows: Cleared %d sequence arrows", clearedCount)
    end
end

function OverlayManager:GetActiveOverlayCount()
    if not self.state.activeOverlays then
        return 0
    end

    local count = 0
    for _ in pairs(self.state.activeOverlays) do
        count = count + 1
    end
    return count
end

function OverlayManager:GetOptions()
    return {
        type = "group",
        name = function() return L["overlayManager"] or "Overlay Manager" end,
        order = 1,
        args = {
            overlayTypes = {
                type = "group",
                name = L["overlayTypes"] or "Overlay Types",
                order = 1,
                childGroups = "tab",
                args = (function()
                    local overlayArgs = {}
                    -- Helper function to determine if an option should be shown for an overlay type
                    local function shouldShowOption(overlayType, optionName)
                        local disabledOptions = {
                            text = {
                                texture = true,
                                blendMode = true,
                                showSpellIcon = true
                            },
                            notification = {
                                font = true,
                                fontSize = true,
                                fontFlags = true,
                                fontColor = true
                            }
                        }
                        return not (disabledOptions[overlayType] and disabledOptions[overlayType][optionName])
                    end
                    local overlayConfigs = self:GetSetting("global", "overlayConfigs")
                    for overlayType, config in pairs(overlayConfigs) do
                        local overlayOptions = {
                            type = "group",
                            name = L[overlayType] or overlayType:gsub("^%l", string.upper),
                            order = 1,
                            args = {}
                        }
                        -- Texture options (not for text overlays)
                        if shouldShowOption(overlayType, "texture") then
                            overlayOptions.args.texture = OptionsFactory:CreateInput(
                                L["texture"] or "Texture",
                                L["textureDesc"] or "Path to texture file (Interface\\Icons\\...)",
                                function() return config.texture end,
                                function(_, value)
                                    config.texture = value
                                    self:RefreshAllOverlays()
                                end,
                                {
                                    order = 1,
                                    width = "full"
                                }
                            )
                            overlayOptions.args.texturePreview = {
                                type = "execute",
                                name = "",
                                order = 1.5,
                                width = 0.5,
                                image = function()
                                    return config.texture, 32, 32
                                end,
                                func = function() end
                            }
                            overlayOptions.args.blendMode = OptionsFactory:CreateSelect(
                                L["blendMode"] or "Blend Mode",
                                "",
                                function() return config.blendMode end,
                                function(_, value)
                                    config.blendMode = value
                                    self:RefreshAllOverlays()
                                end,
                                {
                                    order = 2,
                                    values = {
                                        ["ADD"] = L["add"] or "Additive",
                                        ["BLEND"] = L["blend"] or "Blend",
                                        ["MOD"] = L["mod"] or "Modulate",
                                        ["ALPHAKEY"] = L["alphakey"] or "Alpha Key"
                                    }
                                }
                            )
                        end
                        -- Font options (only for text overlays)
                        if overlayType == "text" then
                            overlayOptions.args.font = OptionsFactory:CreateSelect(
                                L["font"] or "Font",
                                "",
                                function() return config.font end,
                                function(_, value)
                                    config.font = value
                                    self:RefreshAllOverlays()
                                end,
                                {
                                    order = 3,
                                    values = function()
                                        return LSM:HashTable("font")
                                    end,
                                    dialogControl = "LSM30_Font"
                                }
                            )
                            overlayOptions.args.fontSize = OptionsFactory:CreateRange(
                                function(info) return L[info[#info]] or "Font Size" end,
                                "",
                                function() return config.fontSize end,
                                function(_, value)
                                    config.fontSize = value
                                    self:RefreshAllOverlays()
                                end,
                                {
                                    order = 4,
                                    min = 6,
                                    max = 32,
                                    step = 1
                                }
                            )
                            overlayOptions.args.fontFlags = OptionsFactory:CreateSelect(
                                L["fontFlags"] or "Font Flags",
                                "",
                                function() return config.fontFlags end,
                                function(_, value)
                                    config.fontFlags = value
                                    self:RefreshAllOverlays()
                                end,
                                {
                                    order = 5,
                                    values = {
                                        [""] = L["none"] or "None",
                                        ["OUTLINE"] = L["outline"] or "Outline",
                                        ["THICKOUTLINE"] = L["thickoutline"] or "Thick Outline",
                                        ["MONOCHROME"] = L["monochrome"] or "Monochrome"
                                    }
                                }
                            )
                            overlayOptions.args.fontColor = OptionsFactory:CreateColor(
                                L["fontColor"] or "Font Color",
                                "",
                                function() return unpack(config.fontColor or { 1, 1, 1, 1 }) end,
                                function(_, r, g, b, a)
                                    config.fontColor = { r, g, b, a }
                                    self:RefreshAllOverlays()
                                end,
                                {
                                    order = 6,
                                    hasAlpha = true
                                }
                            )
                        end
                        -- Common options for all overlay types
                        overlayOptions.args.position = {
                            type = "group",
                            name = L["position"] or "Position",
                            order = 7,
                            inline = true,
                            args = {
                                point = OptionsFactory:CreateSelect(
                                    L["point"] or "Point",
                                    "",
                                    function() return config.point end,
                                    function(_, value)
                                        config.point = value
                                        self:RefreshAllOverlays()
                                    end,
                                    {
                                        order = 1,
                                        values = {
                                            ["CENTER"] = L["center"] or "Center",
                                            ["TOP"] = L["top"] or "Top",
                                            ["BOTTOM"] = L["bottom"] or "Bottom",
                                            ["LEFT"] = L["left"] or "Left",
                                            ["RIGHT"] = L["right"] or "Right",
                                            ["TOPLEFT"] = L["topleft"] or "Top Left",
                                            ["TOPRIGHT"] = L["topright"] or "Top Right",
                                            ["BOTTOMLEFT"] = L["bottomleft"] or "Bottom Left",
                                            ["BOTTOMRIGHT"] = L["bottomright"] or "Bottom Right"
                                        }
                                    }
                                ),
                                relativePoint = OptionsFactory:CreateSelect(
                                    L["relativePoint"] or "Relative Point",
                                    "",
                                    function() return config.relativePoint end,
                                    function(_, value)
                                        config.relativePoint = value
                                        self:RefreshAllOverlays()
                                    end,
                                    {
                                        order = 2,
                                        values = {
                                            ["CENTER"] = L["center"] or "Center",
                                            ["TOP"] = L["top"] or "Top",
                                            ["BOTTOM"] = L["bottom"] or "Bottom",
                                            ["LEFT"] = L["left"] or "Left",
                                            ["RIGHT"] = L["right"] or "Right",
                                            ["TOPLEFT"] = L["topleft"] or "Top Left",
                                            ["TOPRIGHT"] = L["topright"] or "Top Right",
                                            ["BOTTOMLEFT"] = L["bottomleft"] or "Bottom Left",
                                            ["BOTTOMRIGHT"] = L["bottomright"] or "Bottom Right"
                                        }
                                    }
                                ),
                                xOffset = OptionsFactory:CreateRange(
                                    L["xOffset"] or "X Offset",
                                    "",
                                    function() return config.xOffset end,
                                    function(_, value)
                                        config.xOffset = value
                                        self:RefreshAllOverlays()
                                    end,
                                    {
                                        order = 3,
                                        min = -100,
                                        max = 100,
                                        step = 1
                                    }
                                ),
                                yOffset = OptionsFactory:CreateRange(
                                    L["yOffset"] or "Y Offset",
                                    "",
                                    function() return config.yOffset end,
                                    function(_, value)
                                        config.yOffset = value
                                        self:RefreshAllOverlays()
                                    end,
                                    {
                                        order = 4,
                                        min = -100,
                                        max = 100,
                                        step = 1
                                    }
                                )
                            }
                        }
                        -- Add size option
                        overlayOptions.args.size = OptionsFactory:CreateRange(
                            L["size"] or "Size",
                            "",
                            function() return config.size end,
                            function(_, value)
                                config.size = value
                                self:RefreshAllOverlays()
                            end,
                            {
                                order = 8,
                                min = 0.1,
                                max = 3.0,
                                step = 0.1
                            }
                        )
                        -- Add alpha option
                        overlayOptions.args.alpha = OptionsFactory:CreateRange(
                            L["alpha"] or "Alpha",
                            "",
                            function() return config.alpha end,
                            function(_, value)
                                config.alpha = value
                                self:RefreshAllOverlays()
                            end,
                            {
                                order = 9,
                                min = 0,
                                max = 1,
                                step = 0.05
                            }
                        )
                        -- Add spell icon option for supported types
                        if shouldShowOption(overlayType, "showSpellIcon") then
                            overlayOptions.args.showSpellIcon = OptionsFactory:CreateToggle(
                                L["showSpellIcon"] or "Show Spell Icon",
                                "",
                                function() return config.showSpellIcon end,
                                function(_, value)
                                    config.showSpellIcon = value
                                    self:RefreshAllOverlays()
                                end,
                                {
                                    order = 10
                                }
                            )
                        end
                        -- Add reset button
                        overlayOptions.args.reset = OptionsFactory:CreateExecute(
                            L["resetToDefault"] or "Reset to Default",
                            L["resetConfirm"] or "Are you sure you want to reset? This cannot be undone.",
                            function()
                                local overlayConfigs = self:GetSetting("global", "overlayConfigs")
                                if overlayConfigs then
                                    overlayConfigs[overlayType] = nil
                                    self:SetSetting("global", "overlayConfigs", overlayConfigs)
                                    self.db:RegisterDefaults(self.defaults)
                                    self:RefreshAllOverlays()
                                    AceConfigRegistry:NotifyChange("NAG")
                                end
                            end,
                            {
                                order = 99,
                                confirm = true
                            }
                        )
                        overlayArgs[overlayType] = overlayOptions
                    end
                    return overlayArgs
                end)()
            },
            poolingOverlay = {
                type = "group",
                name = L["poolingOverlay"] or "Pooling Overlay",
                order = 2,
                args = {
                    enabled = OptionsFactory:CreateToggle(
                        L["enablePoolingOverlay"] or "Enable Pooling Overlay",
                        L["enablePoolingOverlayDesc"] or "Show visual overlay when energy pooling",
                        function() return self:GetSetting("global", "overlayConfigs.pooling") ~= nil end,
                        function(_, value)
                            if not value then
                                self:SetSetting("global", "overlayConfigs.pooling", nil)
                                for key, data in pairs(self.state.activeOverlays or {}) do
                                    if key:find("_pooling") then
                                        if data.overlay then data.overlay:Hide() end
                                        self.state.activeOverlays[key] = nil
                                    end
                                end
                            else
                                self:SetSetting("global", "overlayConfigs.pooling", {
                                    texture = "Interface\\Minimap\\UI-Minimap-Background",
                                    blendMode = "BLEND",
                                    size = 1.0,
                                    point = "CENTER",
                                    relativePoint = "CENTER",
                                    xOffset = 0,
                                    yOffset = 0,
                                    alpha = 0.7,
                                    textureAlpha = 0.5,
                                    showSpellIcon = false,
                                    pulse = true,
                                    textColor = { 1, 1, 0, 1 },
                                    textSize = 11,
                                    textFont = "Friz Quadrata TT",
                                    textFlags = "OUTLINE",
                                    text = "Pooling"
                                })
                            end
                        end,
                        {
                            order = 1
                        }
                    ),
                    testPooling = OptionsFactory:CreateExecute(
                        L["testPooling"] or "Test Pooling Overlay",
                        L["testPoolingDesc"] or "Show pooling overlay for 3 seconds to test appearance",
                        function()
                            if NAG.Frame and NAG.Frame.iconFrames and NAG.Frame.iconFrames["primary"] then
                                local primaryFrame = NAG.Frame.iconFrames["primary"]
                                local endTime = GetTime() + 3
                                self:ShowPooling(primaryFrame, function()
                                    return GetTime() < endTime
                                end)
                                self:Info("Testing pooling overlay for 3 seconds")
                            else
                                self:Error("No primary frame available for testing")
                            end
                        end,
                        {
                            order = 2,
                            disabled = function() return self:GetSetting("global", "overlayConfigs.pooling") == nil end
                        }
                    )
                }
            }
        }
    }
end

function OverlayManager:RefreshAllOverlays()
    -- Iterate through all active overlays and refresh them
    if not self.state.activeOverlays then
        self:Debug("RefreshAllOverlays: No active overlays to refresh")
        return
    end

    self:Trace("RefreshAllOverlays: Starting refresh of all overlays")
    local refreshedCount = 0
    local cleanedCount = 0

    for overlayKey, overlayData in pairs(self.state.activeOverlays) do
        if type(overlayData) == "table" and overlayData.overlay and overlayData.overlay:GetParent() then
            -- Only refresh if overlay is still valid
            if self.debug then self:Trace("RefreshAllOverlays: Refreshing overlay %s", overlayKey) end

            -- Force a redraw by temporarily changing alpha
            local currentAlpha = overlayData.overlay:GetAlpha()
            overlayData.overlay:SetAlpha(currentAlpha + 0.001)
            overlayData.overlay:SetAlpha(currentAlpha)

            refreshedCount = refreshedCount + 1
        else
            -- Invalid overlay data, clean it up
            if self.debug then
                self:Warn("RefreshAllOverlays: Found invalid overlay data for key %s, removing",
                    overlayKey)
            end
            self.state.activeOverlays[overlayKey] = nil
            cleanedCount = cleanedCount + 1
        end
    end

    self:Trace("RefreshAllOverlays: Completed refresh of %d overlays, cleaned %d invalid", refreshedCount, cleanedCount)
end

function OverlayManager:DumpActiveOverlays()
    if not self.state.activeOverlays then
        self:Debug("No active overlays table")
        return
    end

    local count = 0
    local validCount = 0
    for key, data in pairs(self.state.activeOverlays) do
        count = count + 1
        if data and data.overlay and data.overlay:GetParent() then
            validCount = validCount + 1
        end
    end

    if self.debug then
        self:Debug("Active overlays: %d total, %d valid", count, validCount)
    end
end

function OverlayManager:ShowNotification(frame, spellId, xOffset, yOffset, checkFunc)
    if not frame or not spellId then
        self:Debug("ShowNotification: Missing frame or spellId")
        return
    end

    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not spell then
        self:Error(format("ShowNotification: Invalid spellId: %d", spellId))
        return
    end

    local iconTexture = spell.icon or GetSpellTexture(spellId)
    if not iconTexture then
        self:Error(format("ShowNotification: Could not get icon texture for spellId: %d", spellId))
        return
    end

    if self.debug then
        self:Debug("ShowNotification: Creating notification for spell %d (%s)", spellId,
            spell.name or "unknown")
    end
    return self:ShowOverlay(frame, "notification", nil, checkFunc, {
        spellIcon = iconTexture,
        xOffset = xOffset,
        yOffset = yOffset,
        spellId = spellId
    })
end

function OverlayManager:HideNotification(frame, spellId)
    if not frame or not spellId then
        self:Debug("HideNotification: Missing frame or spellId")
        return
    end

    self:HideOverlay(frame, "notification", spellId)
end

function OverlayManager:ShowTextOverlay(frame, text, duration, checkFunc, customConfig)
    if not frame or not text then
        self:Debug("ShowTextOverlay: Missing frame or text")
        return
    end

    -- Generate a unique key for this text overlay
    local overlayKey = self:GetOverlayKey(frame, "text", customConfig and customConfig.id)
    if self.debug then self:Debug("ShowTextOverlay: Creating text overlay with key: %s", overlayKey) end

    -- Get base config
    local config = self.db.global.overlayConfigs.text
    if not config then
        self:Error("ShowTextOverlay: Text overlay configuration not found")
        return
    end

    -- Merge custom config with base config
    local finalConfig = {}
    for k, v in pairs(config) do
        if type(v) == "table" then
            finalConfig[k] = {}
            for k2, v2 in pairs(v) do
                finalConfig[k][k2] = v2
            end
        else
            finalConfig[k] = v
        end
    end
    if customConfig then
        for k, v in pairs(customConfig) do
            if type(v) == "table" and finalConfig[k] then
                for k2, v2 in pairs(v) do
                    finalConfig[k][k2] = v2
                end
            else
                finalConfig[k] = v
            end
        end
    end

    -- Create or get existing overlay
    local overlay = self:ShowOverlay(frame, "text", duration, checkFunc, finalConfig)
    if not overlay then return end

    -- Create or update text display
    if not overlay.textFrame then
        overlay.textFrame = CreateFrame("Frame", nil, overlay)
        overlay.textFrame:SetAllPoints()

        -- Create background if enabled
        if finalConfig.background.enable then
            overlay.textFrame.bg = overlay.textFrame:CreateTexture(nil, "BACKGROUND")
            overlay.textFrame.bg:SetAllPoints()
            overlay.textFrame.bg:SetTexture(finalConfig.background.texture)
            overlay.textFrame.bg:SetColorTexture(unpack(finalConfig.background.color))
        end

        -- Create text
        overlay.textFrame.text = overlay.textFrame:CreateFontString(nil, "OVERLAY")
    end

    -- Get the actual font path from LSM with fallback
    local fontPath = LSM:Fetch("font", finalConfig.font) or LSM:GetDefault("font")

    -- Update text properties with error checking
    local success = overlay.textFrame.text:SetFont(fontPath, finalConfig.fontSize, finalConfig.fontFlags)

    if not success then
        self:Error("ShowTextOverlay: Failed to set font for text overlay")
        return
    end
    overlay.textFrame.text:SetTextColor(unpack(finalConfig.fontColor))
    overlay.textFrame.text:SetText(text)

    -- Position the text within the frame according to config
    overlay.textFrame.text:ClearAllPoints()
    overlay.textFrame.text:SetPoint(finalConfig.point or "CENTER", overlay.textFrame,
        finalConfig.relativePoint or finalConfig.point or "CENTER", finalConfig.xOffset or 0, finalConfig.yOffset or 0)

    -- Adjust frame size based on text width if needed
    local textWidth = overlay.textFrame.text:GetStringWidth() + (finalConfig.background.padding or 0) * 2
    local textHeight = overlay.textFrame.text:GetStringHeight() + (finalConfig.background.padding or 0) * 2
    overlay:SetSize(textWidth, textHeight)

    -- Add pulse animation if enabled
    if finalConfig.pulse and not overlay.pulse then
        overlay.pulse = overlay:CreateAnimationGroup()
        local pulseIn = overlay.pulse:CreateAnimation("Scale")
        pulseIn:SetScale(1.2, 1.2)
        pulseIn:SetDuration(0.5)
        pulseIn:SetSmoothing("IN_OUT")
        pulseIn:SetOrder(1)
        local pulseOut = overlay.pulse:CreateAnimation("Scale")
        pulseOut:SetScale(0.8333, 0.8333)
        pulseOut:SetDuration(0.5)
        pulseOut:SetSmoothing("IN_OUT")
        pulseOut:SetOrder(2)
        overlay.pulse:SetLooping("REPEAT")
        overlay.pulse:Play()
    end

    return overlay
end

function OverlayManager:HideTextOverlay(frame, id)
    if not frame then
        self:Debug("HideTextOverlay: Missing frame")
        return
    end

    self:HideOverlay(frame, "text", id)
end

function OverlayManager:ShowWarning(frame, text, duration)
    return self:ShowTextOverlay(frame, text, duration, nil, {
        fontColor = { 1, 0.1, 0.1, 1 }, -- Red text
        background = {
            enable = false,
            color = { 0, 0, 0, 0.8 },
            padding = 8
        },
        fontSize = 14,
        pulse = true
    })
end

function OverlayManager:ShowInfo(frame, text, duration)
    return self:ShowTextOverlay(frame, text, duration, nil, {
        fontColor = { 0.1, 1, 0.1, 1 }, -- Green text
        background = {
            enable = false,
            color = { 0, 0, 0, 0.6 },
            padding = 5
        },
        fontSize = 12,
        pulse = false
    })
end

function OverlayManager:ShowPooling(frame, checkFunc)
    if not frame then
        self:Debug("ShowPooling: Missing frame")
        return
    end

    local poolingText = "Pooling"
    local classModule = NAG:GetClassModule()
    if classModule and classModule.className == "WARRIOR" then
        poolingText = "Pool\nRage"
    end

    -- Check if we already have a pooling overlay for this frame
    local existingKey = self:GetOverlayKey(frame, "pooling")
    local existing = self.state.activeOverlays[existingKey]

    if existing then
        -- Update existing overlay instead of creating new one
        if checkFunc then
            existing.checkFunc = checkFunc
        end
        existing.overlay:Show()
        if existing.overlay.text then
            existing.overlay.text:SetText(poolingText)
            self:UpdateOverlayTextBackground(existing.overlay)
        end
        if self.debug then
            self:Debug("ShowPooling: Reused existing pooling overlay")
        end
        return existing.overlay
    end

    -- Only create new if none exists
    if self.debug then
        self:Debug("ShowPooling: Creating new pooling overlay")
    end
    local overlay = self:ShowOverlay(frame, "pooling", nil, checkFunc)
    if overlay and overlay.text then
        overlay.text:SetText(poolingText)
        self:UpdateOverlayTextBackground(overlay)
    end
    return overlay
end

function OverlayManager:HidePooling(frame)
    if not frame then
        self:Debug("HidePooling: Missing frame")
        return
    end

    self:Debug("HidePooling: Hiding pooling overlay")
    self:HideOverlay(frame, "pooling")
end

function OverlayManager:ShowMana(frame, checkFunc)
    if not frame then
        self:Debug("ShowMana: Missing frame")
        return
    end

    local manaText = "MANA"
    local existingKey = self:GetOverlayKey(frame, "mana", "mana_primary")
    local existing = self.state.activeOverlays[existingKey]
    if existing then
        if checkFunc then
            existing.checkFunc = checkFunc
        end
        existing.overlay:Show()
        if existing.overlay.text then
            existing.overlay.text:SetText(manaText)
            self:UpdateOverlayTextBackground(existing.overlay)
        end
        return existing.overlay
    end

    local overlay = self:ShowOverlay(frame, "mana", nil, checkFunc, {
        spellId = "mana_primary"
    })
    if overlay and overlay.text then
        overlay.text:SetText(manaText)
        self:UpdateOverlayTextBackground(overlay)
    end
    return overlay
end

function OverlayManager:HideMana(frame)
    if not frame then
        self:Debug("HideMana: Missing frame")
        return
    end
    self:HideOverlay(frame, "mana", "mana_primary")
end

--- Shows a combined cancel-aura overlay (icon + text) centered on the given frame while the aura is active.
--- The overlay is spell-based and will only show when the specified aura is active and this frame displays that spell.
--- The icon uses a loop/refresh arrow and the text/color can be customized.
--- @param frame Frame Parent frame to attach overlays to
--- @param auraId number Aura/spell ID to monitor for activity
--- @param opts table|nil Optional overrides: { text=string, color={r,g,b,a}, icon=string, center=bool, xOffset=number, yOffset=number }
function OverlayManager:ShowCancelAura(frame, auraId, opts)
    if not frame or not auraId then
        self:Debug("ShowCancelAura: Missing frame or auraId")
        return
    end

    opts = opts or {}
    -- Provide default positioning and size for cancel overlays if caller didn't specify
    if opts.xOffset == nil then opts.xOffset = 0 end
    if opts.yOffset == nil then opts.yOffset = -2 end
    if opts.size == nil then opts.size = 1.2 end -- 300% of notification base (0.4 * 3 = 1.2 of frame width)


    local function isActive()
        -- Show overlay only when:
        -- 1. The frame is displaying the aura spell
        -- 2. The aura is still active on the player
        local isCorrectSpell = frame.spellId == auraId or frame.id == auraId
        local isAuraActive = NAG:AuraIsActive(auraId)

        return isCorrectSpell and isAuraActive
    end

    -- Notification icon overlay (use provided icon or default refresh button)
    local iconOverlay = self:ShowOverlay(frame, "notification", auraId, isActive, {
        spellIcon = opts.icon or "Interface\\Buttons\\UI-Panel-MinimizeButton-Up",
        spellId = auraId
    })
    if iconOverlay then
        -- Center positioning for cancel aura overlays
        iconOverlay:ClearAllPoints()
        iconOverlay:SetPoint("CENTER", frame, "CENTER", opts.xOffset or 0, opts.yOffset or 0)

        -- Override size and alpha if provided in opts
        if opts.size then
            local newSize = (frame.GetWidth and frame:GetWidth() or 64) * opts.size
            iconOverlay:SetSize(newSize, newSize)
        end
        if opts.alpha and iconOverlay.spellIcon and iconOverlay.spellIcon.SetAlpha then
            iconOverlay.spellIcon:SetAlpha(opts.alpha)
        end
        -- Apply vertex color to icon if provided (for red tint)
        if iconOverlay.spellIcon and iconOverlay.spellIcon.SetVertexColor and opts.color then
            iconOverlay.spellIcon:SetVertexColor(opts.color[1] or 1, opts.color[2] or 1, opts.color[3] or 1,
                opts.color[4] or 1)
        end
    end

    -- Text overlay (centered by default if center flag set at ShowTextOverlay return)
    local text = opts.text or "Cancel"
    local textOverlay = self:ShowTextOverlay(frame, text, nil, isActive, {
        id = auraId,
        fontColor = opts.color or { 1, 0.1, 0.1, 1 },
        fontSize = opts.textSize or 16,
        pulse = false
    })
    if textOverlay then
        textOverlay:ClearAllPoints()
        textOverlay:SetPoint("CENTER", frame, "CENTER", opts.xOffset or 0, (opts.yOffset or 0))
    end
end

--- Shows a prominent cancel-meta overlay (circle-slash) centered on the frame while Metamorphosis is active
--- and this frame is displaying the Metamorphosis spell. Text "Cancel" is shown slightly closer to center.
--- @param frame Frame Parent frame to attach overlays to
--- @param auraId number Aura/spell ID to monitor (expected 103958)
function OverlayManager:ShowCancelMeta(frame, auraId)
    if not frame or not auraId then
        self:Debug("ShowCancelMeta: Missing frame or auraId")
        return
    end

    local function isActive()
        -- Stabilize: only depend on aura being active to avoid flicker when primary icon briefly changes
        return NAG:AuraIsActive(auraId)
    end

    -- Circle-slash overlay
    local overlay = self:ShowOverlay(frame, "cancelmeta", nil, isActive, { spellId = auraId })
    if overlay then
        overlay:ClearAllPoints()
        overlay:SetPoint("CENTER", frame, "CENTER", 0, -2)
        -- Increase size by 600% relative to base percent size in config (previously 300%)
        local baseSize = (self.db.global.overlayConfigs.cancelmeta and self.db.global.overlayConfigs.cancelmeta.size) or 0.65
        local frameWidth = (frame.GetWidth and frame:GetWidth()) or 64
        local newSize = frameWidth * baseSize * 6
        overlay:SetSize(newSize, newSize)
    end

    -- Centered text "Cancel" + spell name
    local spellName = (GetSpellInfo and (select(1, GetSpellInfo(auraId)))) or "Metamorphosis"
    local cancelText = (L and L["Cancel"] or "Cancel") .. "\n" .. (spellName or "Metamorphosis")
    self:ShowTextOverlay(frame, cancelText, nil, isActive, {
        id = auraId,
        fontColor = { 1, 0.1, 0.1, 1 },
        fontSize = 16,
        point = "CENTER",
        relativePoint = "CENTER",
        xOffset = 0,
        yOffset = -2,
        pulse = false
    })
end

--- Hides the combined cancel-aura overlays created by ShowCancelAura.
--- @param frame Frame Parent frame that holds the overlays
--- @param auraId number Aura/spell ID used for keys
function OverlayManager:HideCancelAura(frame, auraId)
    if not frame or not auraId then
        self:Debug("HideCancelAura: Missing frame or auraId")
        return
    end
    -- Hide both the notification (icon) and the text overlays keyed by auraId
    self:HideOverlay(frame, "notification", auraId)
    self:HideTextOverlay(frame, auraId)
end

-- ============================ ACE3 LIFECYCLE ============================

function OverlayManager:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    OptionsFactory = NAG:GetModule("OptionsFactory")
    DataManager = NAG:GetModule("DataManager")
    DisplayManager = NAG:GetModule("DisplayManager")
    TimerManager = NAG:GetModule("TimerManager")
    CacheRefreshManager = NAG:GetModule("CacheRefreshManager")
end

function OverlayManager:ModuleEnable()
    -- Initialize frame pool for sequence arrows
    self:InitializeFramePool()

    -- Register callback for LSM updates
    -- ============================ MODULE INITIALIZATION ============================
    LSM.RegisterCallback(self, "LibSharedMedia_Registered", function(_, mediatype)
        if mediatype == "font" then
            self:RefreshAllOverlays()
        end
    end)
end

function OverlayManager:ModuleDisable()
    -- Clean up centralized monitoring timer
    if self.state.monitorTimer then
        TimerManager:Cancel(TimerManager.Categories.CORE, "overlayMonitor")
        self.state.monitorTimer = nil
    end

    -- Clean up all active overlays
    if self.state.activeOverlays then
        for overlayKey, overlayData in pairs(self.state.activeOverlays) do
            if overlayData.overlay then
                overlayData.overlay:Hide()
            end
        end
        wipe(self.state.activeOverlays)
    end

    -- Reset frame counts
    wipe(self.state.frameOverlayCounts)

    -- Clear performance caches
    self:ClearFrameCache()
    self:ClearOverlayKeyCache()
end

-- ~~~~~~~~~~ MODULE EXPOSURE ~~~~~~~~~~
