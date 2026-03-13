--- @module "NAG.UptimeTimeline"
--- Visual timeline display for uptime tracking with spark effects
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS ~~~~~~~~~~
--- @type UptimeTrackerManager
--- @type OptionsFactory
local UptimeTrackerManager, OptionsFactory

local WoWAPI = ns.WoWAPI
local GetTime = _G.GetTime
local UnitAffectingCombat = _G.UnitAffectingCombat
local IsMounted = _G.IsMounted
local IsFlying = _G.IsFlying
local CreateFrame = _G.CreateFrame
local L = ns.AceLocale:GetLocale("NAG", true)
local GetSpellTexture = C_Spell and C_Spell.GetSpellTexture or _G.GetSpellTexture
local UnitAura = _G.UnitAura
local UnitBuff = _G.UnitBuff
local UnitDebuff = _G.UnitDebuff

-- Lua helpers
local min = math.min
local max = math.max
local abs = math.abs
local tinsert = table.insert

-- ~~~~~~~~~~ CONSTANTS ~~~~~~~~~~
local UPDATE_INTERVAL = 0.016 -- ~60 FPS for timeline redraws
local UPDATE_INTERVAL_IDLE = 0.10 -- Reduce idle flight overhead
local DEFAULT_ICON_SIZE = 16
local MAX_SPARKS = 32 -- Support more sparks for multiple tracked IDs

-- Background art settings
local BG_ART_TEXTURE = "Interface\\AddOns\\NAG\\media\\bgIcons\\NAGbarCD.png"
local BG_ART_WIDTH = 260
local BG_ART_HEIGHT = 71
local BG_ART_ALPHA = 1
local BG_ART_Y_OFFSET = 0
local BG_ART_X_OFFSET = -15

-- Spark settings
local SPARK_EMBLEM_Y_OFFSET = 7

-- ~~~~~~~~~~ DEFAULTS ~~~~~~~~~~
local defaults = {
    char = {
        enabled = true,
        showAllClusters = true
    }
}

--- @class UptimeTimeline: CoreModule
local UptimeTimeline = NAG:CreateModule("UptimeTimeline", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.UI,
    debug = true,
    messageHandlers = {
        NAG_UPTIME_TRACKING_UPDATED = true,
        NAG_CLUSTER_CONFIG_CHANGED = true,
    },
    defaultState = {
        clusterFrames = {}, -- Frame instances per cluster
        lastUpdate = 0,
        lastDebugTime = 0 -- Throttle debug output
    },
    debugCategories = { ns.DEBUG_CATEGORIES.UI, ns.DEBUG_CATEGORIES.FEATURES }
})
ns.UptimeTimeline = UptimeTimeline

-- ~~~~~~~~~~ LIFECYCLE ~~~~~~~~~~
function UptimeTimeline:ModuleInitialize()
    UptimeTrackerManager = NAG:GetModule("UptimeTrackerManager")
    OptionsFactory = NAG:GetModule("OptionsFactory")
end

function UptimeTimeline:ModuleEnable()
    self:CreateAllClusterFrames()
    self:UpdateAllClusters()

    -- Setup update loop
    self:CreateUpdateFrame()
end

function UptimeTimeline:ModuleDisable()
    -- Hide all cluster frames
    for _, clusterFrame in pairs(self.state.clusterFrames) do
        if clusterFrame and clusterFrame.frame then
            clusterFrame.frame:Hide()
        end
    end
end

-- ~~~~~~~~~~ MESSAGE HANDLERS ~~~~~~~~~~
function UptimeTimeline:NAG_UPTIME_TRACKING_UPDATED()
    self:UpdateAllClusters()
end

function UptimeTimeline:NAG_CLUSTER_CONFIG_CHANGED(message, payload)
    if payload and payload.clusterIndex then
        self:UpdateClusterFrame(payload.clusterIndex)
    else
        self:RecreateAllFrames()
    end
end

-- ~~~~~~~~~~ FRAME MANAGEMENT ~~~~~~~~~~
function UptimeTimeline:CreateUpdateFrame()
    self.updateFrame = CreateFrame("Frame")
    self.updateFrame:SetScript("OnUpdate", function(_, elapsed)
        local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")
        local isTraveling = (IsMounted and IsMounted()) or (IsFlying and IsFlying()) or false
        local interval = UPDATE_INTERVAL
        if not inCombat and isTraveling then
            interval = UPDATE_INTERVAL_IDLE
        end
        self.state.lastUpdate = self.state.lastUpdate + elapsed
        if self.state.lastUpdate >= interval then
            self:UpdateAllClusters()
            self.state.lastUpdate = 0
        end
    end)
end

function UptimeTimeline:CreateAllClusterFrames()
    local clusters = UptimeTrackerManager:GetAllClusters()

    for clusterIndex = 1, #clusters do
        self:CreateClusterFrame(clusterIndex)
    end
end

function UptimeTimeline:RecreateAllFrames()
    -- Destroy existing frames
    for _, clusterFrame in pairs(self.state.clusterFrames) do
        if clusterFrame and clusterFrame.frame then
            clusterFrame.frame:Hide()
        end
    end
    wipe(self.state.clusterFrames)

    -- Recreate all
    self:CreateAllClusterFrames()
    self:UpdateAllClusters()
end

function UptimeTimeline:CreateClusterFrame(clusterIndex)
    self:Debug("CreateClusterFrame: Creating frame for cluster %d", clusterIndex)

    local cluster = UptimeTrackerManager:GetCluster(clusterIndex)
    if not cluster then
        self:Debug("  ERROR: No cluster data for index %d", clusterIndex)
        return
    end

    local frame = CreateFrame("Frame", "NAGUptimeCluster" .. clusterIndex, UIParent)
    self:Debug("  Created frame: %s", frame:GetName())
    frame:SetSize(cluster.size.width, cluster.size.height)
    frame:SetPoint(cluster.position.point, cluster.position.x, cluster.position.y)
    frame:SetAlpha(1)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")

    -- Background (optional)
    if cluster.showBackground then
        local bg = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
        bg:SetAllPoints()
        bg:SetColorTexture(0.2, 0.2, 0.2, cluster.backgroundAlpha)
        frame.bg = bg
    end

    -- Timeline bar (lower layer than sparks)
    local timeline = frame:CreateTexture(nil, "ARTWORK", nil, 0)
    timeline:SetPoint("LEFT", frame, "LEFT", 0, 0)
    timeline:SetSize(frame:GetWidth(), frame:GetHeight())
    timeline:SetColorTexture(0.0, 0.0, 0.0, 0.7)
    frame.timeline = timeline

    -- NOW marker
    local now = frame:CreateTexture(nil, "OVERLAY", nil, 2)
    now:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
    now:SetWidth(2)
    now:SetColorTexture(0, 0, 0, 0.7)
    frame.now = now

    local nowInner = frame:CreateTexture(nil, "OVERLAY", nil, 3)
    nowInner:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
    nowInner:SetWidth(1)
    nowInner:SetColorTexture(1, 1, 1, 0.6)
    frame.nowInner = nowInner

    -- Tick markers
    frame.ticks = {}
    frame.tickOverlays = {}
    local tickCount = 5
    for i = 0, tickCount do
        local x = i * (frame:GetWidth() / tickCount)
        local tick = frame:CreateTexture(nil, "OVERLAY", nil, 6)
        tick:SetSize(2, 10)
        tick:SetPoint("CENTER", frame, "LEFT", x, 0)
        tick:SetColorTexture(0, 0, 0, 0.7)
        tinsert(frame.ticks, tick)

        local tickInner = frame:CreateTexture(nil, "OVERLAY", nil, 7)
        tickInner:SetSize(1, 10)
        tickInner:SetPoint("CENTER", frame, "LEFT", x, 0)
        tickInner:SetColorTexture(1, 1, 1, 0.6)
        tinsert(frame.tickOverlays, tickInner)
    end

    -- Sparks
    frame.sparks = {}
    self:Debug("  Creating %d spark frames", MAX_SPARKS)
    for i = 1, MAX_SPARKS do
        local sFrame = CreateFrame("Frame", nil, frame)
        sFrame:SetSize(DEFAULT_ICON_SIZE, DEFAULT_ICON_SIZE)
        -- Ensure sparks render above timeline and markers
        sFrame:SetFrameLevel((frame:GetFrameLevel() or 0) + 10)
        local s = sFrame:CreateTexture(nil, "OVERLAY", nil, 3)
        s:SetDrawLayer("OVERLAY", 7)
        s:SetAllPoints()
        local mask = sFrame:CreateMaskTexture()
        mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
        mask:SetAllPoints()
        s:AddMaskTexture(mask)
        s:Hide()
        sFrame:Hide()
        sFrame.icon = s

        -- Countdown text
        local timerText = sFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        timerText:SetPoint("CENTER", sFrame, "CENTER", 0, 0)
        timerText:SetTextColor(1, 1, 1, 0.9)
        sFrame.text = timerText

        frame.sparks[i] = sFrame
    end
    self:Debug("  Created %d sparks successfully", #frame.sparks)

    -- Drag handling
    frame:SetScript("OnDragStart", function()
        if not UnitAffectingCombat("player") then
            frame:StartMoving()
        end
    end)
    frame:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
        local point, _, _, x, y = frame:GetPoint()
        cluster.position = { point = point, x = x, y = y }
    end)

    -- Store in state
    self.state.clusterFrames[clusterIndex] = {
        frame = frame,
        cluster = cluster
    }
end

function UptimeTimeline:UpdateClusterFrame(clusterIndex)
    local cluster = UptimeTrackerManager:GetCluster(clusterIndex)
    if not cluster then
        -- Cluster was deleted, hide frame
        local clusterFrame = self.state.clusterFrames[clusterIndex]
        if clusterFrame and clusterFrame.frame then
            clusterFrame.frame:Hide()
        end
        return
    end

    local clusterFrame = self.state.clusterFrames[clusterIndex]
    if not clusterFrame then
        -- New cluster, create frame
        self:CreateClusterFrame(clusterIndex)
        clusterFrame = self.state.clusterFrames[clusterIndex]
    end

    if not clusterFrame then
        self:Debug("UpdateClusterFrame: Failed to create frame for cluster " .. clusterIndex)
        return
    end

    local frame = clusterFrame.frame
    clusterFrame.cluster = cluster

    -- Update frame settings first
    frame:SetSize(cluster.size.width, cluster.size.height)
    frame:SetAlpha(1)

    -- Update positioning
    if cluster.position then
        frame:ClearAllPoints()
        frame:SetPoint(cluster.position.point, cluster.position.x, cluster.position.y)
    end

    -- Basic visibility (final hide/show decided in UpdateClusterVisuals after local scan)
    if self:ShouldShowCluster(cluster) then
        frame:Show()
    else
        frame:Hide()
    end
end

function UptimeTimeline:ShouldShowCluster(cluster)
    -- Check if module is enabled
    if not self.db.char.enabled then
        return false
    end

    -- Check if cluster is enabled
    if not cluster or not cluster.enabled then
        return false
    end

    return true
end

-- ~~~~~~~~~~ RENDERING ~~~~~~~~~~
function UptimeTimeline:UpdateAllClusters()
    local clusters = UptimeTrackerManager:GetAllClusters()

    for clusterIndex = 1, #clusters do
        self:UpdateClusterVisuals(clusterIndex)
    end
end

function UptimeTimeline:UpdateClusterVisuals(clusterIndex)
    -- Throttle debug output to once per second
    local currentTime = GetTime()
    local shouldDebug = (currentTime - self.state.lastDebugTime) >= 1.0

    if shouldDebug then
        self:Debug("=== UpdateClusterVisuals called for cluster %d ===", clusterIndex)
        self.state.lastDebugTime = currentTime
    end

    local clusterFrame = self.state.clusterFrames[clusterIndex]
    if not clusterFrame then
        if shouldDebug then
            self:Debug("  No existing frame, creating one...")
        end
        self:UpdateClusterFrame(clusterIndex)
        clusterFrame = self.state.clusterFrames[clusterIndex]
    end

    if not clusterFrame then
        self:Debug("  ERROR: Failed to create/get frame for cluster " .. clusterIndex)
        return
    end

    local frame = clusterFrame.frame
    local cluster = clusterFrame.cluster

    if not frame then
        self:Debug("  ERROR: Frame is nil for cluster " .. clusterIndex)
        return
    end

    if shouldDebug then
        self:Debug("  Frame exists: %s", tostring(frame:GetName() or "unnamed"))
    end

    -- Ensure basic visibility first (final decision uses hideWhenEmpty after scan)
    if not self:ShouldShowCluster(cluster) then
        frame:Hide()
        for _, spark in ipairs(frame.sparks or {}) do
            spark:Hide(); if spark.icon then spark.icon:Hide() end
        end
        return
    end
    frame:Show()

    if shouldDebug then
        self:Debug("  Frame shown: %s (IsShown=%s)", tostring(frame:GetName()), tostring(frame:IsShown()))
    end

    -- Build local active data by scanning auras directly (fast, frame-driven)
    local activeData = nil
    if cluster and cluster.trackingConfigs and #cluster.trackingConfigs > 0 then
        local function getMapsFor(unit, trackType)
            local idToAura, nameToAura = {}, {}
            -- Prefer cached snapshot if available
            if ns and ns.SnapshotAuras then
                local cache = ns.SnapshotAuras(unit)
                if cache then
                    local list = (trackType == "buff") and cache.buffs or cache.debuffs
                    for i = 1, #list do
                        local a = list[i]
                        if a then
                            local name = a[1]
                            local icon = a[3]
                            local count = a[4]
                            local duration = a[6]
                            local expirationTime = a[7]
                            local sourceUnit = a[8]
                            local spellId = a[10]
                            local aura = {
                                name = name,
                                icon = icon,
                                count = count,
                                duration = duration,
                                expirationTime = expirationTime,
                                sourceUnit = sourceUnit,
                                spellId = spellId,
                            }
                            if spellId then idToAura[spellId] = aura end
                            if name then nameToAura[name] = aura end
                        end
                    end
                    return idToAura, nameToAura
                end
            end
            -- Fallback: direct UnitAura scan
            local filter = (trackType == "buff") and "HELPFUL" or "HARMFUL"
            for i = 1, 40 do
                local name, _, icon, count, auraType, duration, expirationTime, sourceUnit, _, _, spellId = UnitAura(unit, i, filter)
                if not name then break end
                local aura = {
                    name = name,
                    icon = icon,
                    count = count,
                    duration = duration,
                    expirationTime = expirationTime,
                    sourceUnit = sourceUnit,
                    spellId = spellId,
                }
                if spellId then idToAura[spellId] = aura end
                if name then nameToAura[name] = aura end
            end
            return idToAura, nameToAura
        end

        local localActive = {}
        for _, trackConfig in ipairs(cluster.trackingConfigs) do
            local trackType = trackConfig.type or "buff"
            local unit = trackConfig.unit or "player"
            local matchByName = trackConfig.matchByName ~= false
            local resolvedName = trackConfig.resolvedName
            local idMap, nameMap = getMapsFor(unit, trackType)

            if trackType == "buff" or trackType == "debuff" then
                local aura = idMap[trackConfig.id]
                if not aura and matchByName then
                    if resolvedName then
                        aura = nameMap[resolvedName]
                    end
                    if not aura then
                        local si = WoWAPI.GetSpellInfo(trackConfig.id)
                        if si and si.name then
                            aura = nameMap[si.name]
                            if aura then trackConfig.resolvedName = si.name end
                        end
                    end
                end
                if aura and type(aura.expirationTime) == "number" and (aura.expirationTime - GetTime()) > 0 then
                    table.insert(localActive, {
                        spellId = aura.spellId or trackConfig.id,
                        expirationTime = aura.expirationTime,
                        icon = aura.icon or (GetSpellTexture and GetSpellTexture(aura.spellId)) or "Interface\\Icons\\INV_Misc_QuestionMark",
                        name = aura.name,
                        trackType = trackType,
                        unit = unit,
                        stacks = aura.count or 0
                    })
                end
            elseif trackType == "spell" or trackType == "item" then
                -- Cooldown-based tracking
                local cdInfo = WoWAPI.GetSpellCooldown(trackConfig.id)
                if cdInfo and cdInfo.duration and cdInfo.duration > 0 then
                    local endTime = (cdInfo.startTime + cdInfo.duration)
                    local remaining = endTime - GetTime()
                    if remaining > 0 and remaining <= cluster.maxTrackingTime then
                        local si = WoWAPI.GetSpellInfo(trackConfig.id)
                        table.insert(localActive, {
                            spellId = trackConfig.id,
                            expirationTime = endTime,
                            icon = (si and si.iconID) or (GetSpellTexture and GetSpellTexture(trackConfig.id)) or "Interface\\Icons\\INV_Misc_QuestionMark",
                            name = (si and si.name) or tostring(trackConfig.id),
                            trackType = trackType,
                            unit = nil
                        })
                    end
                end
            end
        end

        activeData = localActive
        if shouldDebug then
            self:Debug("  Local scan matched %d items", #localActive)
        end
    end

    if not activeData or #activeData == 0 then
        if shouldDebug then
            self:Debug("  No active data, clearing sparks")
        end
        -- Clear sparks if no active data
        for _, spark in ipairs(frame.sparks or {}) do
            spark:Hide()
            if spark.icon then spark.icon:Hide() end
        end
        -- Respect hideWhenEmpty here
        if cluster.hideWhenEmpty == true then
            frame:Hide()
        end
        return
    end

    local width = cluster.size.width
    local maxTime = cluster.maxTrackingTime
    local pixelsPerSecond = width / maxTime

    if shouldDebug then
        self:Debug("  Rendering %d items (width=%.0f, maxTime=%.1f, pxPerSec=%.2f)",
            #activeData, width, maxTime, pixelsPerSecond)
        self:Debug("  Window: %.1fs to %.1fs", cluster.windowStart, cluster.windowEnd)
    end

    -- Clear all sparks first
    for _, spark in ipairs(frame.sparks or {}) do
        spark:Hide()
        if spark.icon then spark.icon:Hide() end
    end

    -- Position sparks for active data
    local sparkIndex = 0
    for i, data in ipairs(activeData) do
        -- Compute remaining dynamically to keep sparks moving
        local exp = data.expirationTime
        local timeRemaining
        if exp and type(exp) == "number" then
            timeRemaining = max(0, exp - GetTime())
        else
            timeRemaining = data.timeRemaining or 0
        end
        local sparkX = width - (timeRemaining * pixelsPerSecond)

        if shouldDebug then
            self:Debug("  Item %d: %s - %.1fs remaining (icon=%s)",
                i, data.name or "?", timeRemaining, tostring(data.icon))
        end

        -- Visible window defaults
        local windowStart = (cluster.windowStart ~= nil) and cluster.windowStart or 0
        local windowEnd = (cluster.windowEnd ~= nil) and cluster.windowEnd or maxTime
        -- Only show if within visible window
        if timeRemaining >= windowStart and timeRemaining <= windowEnd then
            sparkIndex = sparkIndex + 1
            local spark = frame.sparks[sparkIndex]
            if spark then
                if shouldDebug then
                    self:Debug("    Setting spark %d at x=%.0f", sparkIndex, sparkX)
                end

                -- Resolve icon texture reliably
                local iconTexture = data.icon
                if not iconTexture or iconTexture == 0 then
                    if data.spellId and GetSpellTexture then
                        iconTexture = GetSpellTexture(data.spellId)
                    end
                    if not iconTexture then
                        local si = WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(data.spellId)
                        iconTexture = (si and si.iconID) or "Interface\\Icons\\INV_Misc_QuestionMark"
                    end
                end
                spark.icon:SetTexture(iconTexture)
                spark.icon:Show()

                spark:ClearAllPoints()
                spark:SetPoint("CENTER", frame, "LEFT", sparkX, 0)

                -- Update countdown text
                local seconds = math.floor(timeRemaining)
                spark.text:SetText(tostring(seconds))

                spark:Show()

                if shouldDebug then
                    self:Debug("    Spark %d visible: icon=%s, shown=%s, parent=%s",
                        sparkIndex, tostring(spark.icon:IsShown()), tostring(spark:IsShown()),
                        tostring(spark:GetParent():IsShown()))
                end
            else
                self:Debug("    ERROR: No spark frame at index %d", sparkIndex)
            end
        else
            if shouldDebug then
                self:Debug("    Outside window (%.1f not in %.1f-%.1f)",
                    timeRemaining, cluster.windowStart, cluster.windowEnd)
            end
        end
    end

    if shouldDebug then
        if sparkIndex > 0 then
            self:Debug("  SUCCESS: Displayed %d sparks for cluster %d", sparkIndex, clusterIndex)
        else
            self:Debug("  WARNING: No sparks displayed (had %d items)", #activeData)
        end
    end
end

-- ~~~~~~~~~~ OPTIONS ~~~~~~~~~~
function UptimeTimeline:GetOptions()
    return {
        type = "group",
        name = L["Uptime Tracker"] or "Uptime Tracker",
        order = 36,
        args = {
            enabled = OptionsFactory:CreateToggle(
                L["enabled"] or "Enabled",
                "Toggle the uptime timeline display",
                function() return self.db.char.enabled end,
                function(_, value) self.db.char.enabled = value; self:UpdateAllClusters() end,
                { order = 0 }
            ),
            showAllClusters = OptionsFactory:CreateToggle(L["showAllClusters"] or "Show All Clusters", L["showAllClustersDesc"] or "Toggle visibility of all clusters",
                function() return self.db.char.showAllClusters end,
                function(_, value) self.db.char.showAllClusters = value; self:UpdateAllClusters() end,
                { order = 1 }
            ),
            openEditor = {
                type = "execute",
                name = L["uptimeEditor"] or "Uptime Editor",
                desc = L["uptimeTimelineDesc"] or "Configure timeline clusters for tracking buffs/debuffs",
                order = 2,
                func = function()
                    local UptimeEditor = NAG:GetModule("UptimeEditor")
                    if UptimeEditor then
                        UptimeEditor:ShowEditor()
                    end
                end
            }
        }
    }
end

