--- @module "NAG.UptimeTracker"
--- Single-file uptime tracker: storage (clusters), inline editor, and timeline renderer
---
--- License: CC BY-NC 4.0
--- Authors: @Rakizi, @Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local WoWAPI = ns.WoWAPI
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitName = _G.UnitName
local UnitAffectingCombat = _G.UnitAffectingCombat
local IsMounted = _G.IsMounted
local IsFlying = _G.IsFlying
local CreateFrame = _G.CreateFrame
local AceConfigRegistry = ns.AceConfigRegistry
local AceGUI = ns.AceGUI
local L = ns.AceLocale:GetLocale("NAG", true)
local GetSpellTexture = C_Spell and C_Spell.GetSpellTexture or _G.GetSpellTexture
local UnitAura = _G.UnitAura
local UnitBuff = _G.UnitBuff
local UnitDebuff = _G.UnitDebuff

--- @type OptionsFactory
local OptionsFactory

-- Lua helpers
local tinsert = table.insert
local min = math.min
local max = math.max

-- ~~~~~~~~~~ DEFAULTS ~~~~~~~~~~
local defaults = {
    char = {
        enabled = true,
        clusters = {}, -- legacy
        groups = {},   -- legacy
        -- Unified model
        general = {
            orientation = "horizontal",
            direction = "rightToLeft",
            length = 220,
            thickness = 2,
            color = { r = 0, g = 0, b = 0, a = 0.7 },
            maxTrackingTime = 20,
            windowStart = 0,
            windowEnd = 20,
            spacing = 34, -- default icon(32) + 2
            position = { point = "CENTER", x = 0, y = 140 },
            scale = 1.0,
            showBackground = true,
            backgroundAlpha = 0.7,
        },
        timelines = {},
        debugScan = false,
    }
}

--- @class UptimeTracker: CoreModule
local UptimeTracker = NAG:CreateModule("UptimeTracker", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.UI,
    debug = true,
    messageHandlers = {
        NAG_CLUSTER_CONFIG_CHANGED = true,
    },
    defaultState = {
        frames = {},
        lastUpdate = 0,
        lastDebug = 0,
        groupFrames = {},
    },
    debugCategories = { ns.DEBUG_CATEGORIES.UI, ns.DEBUG_CATEGORIES.FEATURES }
})
ns.UptimeTracker = UptimeTracker

-- Compute frame width/height from cluster length/thickness and direction
local function computeDimensions(c)
    local dir = c and c.direction or "rightToLeft"
    -- Prefer explicit length/thickness; fallback to legacy size (W,H)
    local legacyW = (c and c.size and c.size.width) or 200
    local legacyH = (c and c.size and c.size.height) or 2
    local length = (c and c.length) or legacyW
    local thickness = (c and c.thickness) or legacyH
    local vertical = (dir == "topToBottom" or dir == "bottomToTop")
    if vertical then
        -- Vertical: width = thickness, height = length
        return thickness, length
    else
        -- Horizontal: width = length, height = thickness
        return length, thickness
    end
end

-- ~~~~~~~~~~ LIFECYCLE ~~~~~~~~~~
function UptimeTracker:ModuleInitialize()
    OptionsFactory = NAG:GetModule("OptionsFactory")
end

function UptimeTracker:ModuleEnable()
    self:MigrateToTimelinesIfNeeded()
    self:EnsureDefaultTimeline()
    self:RebuildAll()
    self:StartTicker()
end

function UptimeTracker:ModuleDisable()
    self:StopTicker()
    for _, f in pairs(self.state.frames) do if f and f.frame then f.frame:Hide() end end
end

-- ~~~~~~~~~~ TICKER ~~~~~~~~~~
local UPDATE_INTERVAL = 0.016 -- ~60 FPS for uptime bars
local UPDATE_INTERVAL_IDLE = 0.10 -- Reduce idle flight overhead
function UptimeTracker:StartTicker()
    if self.updateFrame then return end
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
            self:UpdateAll()
            self.state.lastUpdate = 0
        end
    end)
end

function UptimeTracker:StopTicker()
    if self.updateFrame then
        self.updateFrame:SetScript("OnUpdate", nil)
        self.updateFrame = nil
    end
end

-- ~~~~~~~~~~ STORAGE (Clusters) ~~~~~~~~~~
function UptimeTracker:GetClusters()
    return self.db.char.clusters or {}
end

function UptimeTracker:GetCluster(i)
    return (self.db.char.clusters and self.db.char.clusters[i]) or nil
end

function UptimeTracker:AddCluster(cfg)
    self.db.char.clusters = self.db.char.clusters or {}
    local c = {
        name = (cfg and cfg.name) or ("Cluster " .. (#self.db.char.clusters + 1)),
        enabled = true,
        trackingConfigs = (cfg and cfg.trackingConfigs) or {},
        position = (cfg and cfg.position) or { point = "CENTER", x = 0, y = 0 },
        size = (cfg and cfg.size) or { width = 200, height = 2 },
        maxTrackingTime = (cfg and cfg.maxTrackingTime) or 15,
        windowStart = (cfg and cfg.windowStart ~= nil) and cfg.windowStart or 0,
        windowEnd = (cfg and cfg.windowEnd ~= nil) and cfg.windowEnd or 15,
        orientation = (cfg and cfg.orientation) or "horizontal",
        direction = (cfg and cfg.direction) or "rightToLeft",
        showBackground = (cfg and cfg.showBackground ~= nil) and cfg.showBackground or true,
        backgroundAlpha = (cfg and cfg.backgroundAlpha) or 0.7,
        hideOutOfCombat = (cfg and cfg.hideOutOfCombat) or false,
        hideWhenEmpty = (cfg and cfg.hideWhenEmpty ~= nil) and cfg.hideWhenEmpty or false,
    }
    tinsert(self.db.char.clusters, c)
    self:RebuildAll()
    if AceConfigRegistry then AceConfigRegistry:NotifyChange("NAG") end
    print("|cFF00FF00UptimeTracker: Added cluster|r")
end

function UptimeTracker:UpdateCluster(i, fields)
    if not self.db.char.clusters or not self.db.char.clusters[i] then return end
    if not fields then return end
    -- If Max is being changed, lock Start=0 and End=Max for simplicity
    if fields.maxTrackingTime then
        fields.windowStart = 0
        fields.windowEnd = fields.maxTrackingTime
    end
    for k, v in pairs(fields) do self.db.char.clusters[i][k] = v end
    self:RebuildOne(i)
end

function UptimeTracker:DeleteCluster(i)
    if not self.db.char.clusters or not self.db.char.clusters[i] then return end
    table.remove(self.db.char.clusters, i)
    self:RebuildAll()
end

-- ~~~~~~~~~~ STORAGE (Groups) ~~~~~~~~~~
function UptimeTracker:GetGroups()
    return self.db.char.groups or {}
end

function UptimeTracker:AddGroup(cfg)
    self.db.char.groups = self.db.char.groups or {}
    local g = {
        name = (cfg and cfg.name) or ("Group " .. (#self.db.char.groups + 1)),
        position = (cfg and cfg.position) or { point = "CENTER", x = 0, y = 0 },
        scale = (cfg and cfg.scale) or 1.0,
    }
    table.insert(self.db.char.groups, g)
    self:RebuildAll()
    if AceConfigRegistry then AceConfigRegistry:NotifyChange("NAG") end
    print("|cFF00FF00UptimeTracker: Added group|r")
    return #self.db.char.groups
end

function UptimeTracker:UpdateGroup(i, fields)
    if not self.db.char.groups or not self.db.char.groups[i] then return end
    if not fields then return end
    for k, v in pairs(fields) do self.db.char.groups[i][k] = v end
    self:RebuildAll()
end

-- ~~~~~~~~~~ UNIFIED MODEL (General + Timelines) ~~~~~~~~~~
function UptimeTracker:GetGeneral()
    self.db.char.general = self.db.char.general or defaults.char.general
    return self.db.char.general
end

function UptimeTracker:GetTimelines()
    self.db.char.timelines = self.db.char.timelines or {}
    return self.db.char.timelines
end

function UptimeTracker:AddTimeline(cfg)
    local arr = self:GetTimelines()
    local t = {
        name = (cfg and cfg.name) or ("Timeline " .. (#arr + 1)),
        enabled = (cfg and cfg.enabled) ~= false,
        trackingConfigs = (cfg and cfg.trackingConfigs) or {},
    }
    table.insert(arr, t)
    self:RebuildAll()
    if AceConfigRegistry then AceConfigRegistry:NotifyChange("NAG") end
    print("|cFF00FF00UptimeTracker: Added timeline|r")
    return #arr
end

function UptimeTracker:UpdateTimeline(i, fields)
    local arr = self:GetTimelines()
    if not arr[i] or not fields then return end
    for k, v in pairs(fields) do arr[i][k] = v end
    self:RebuildAll()
end

function UptimeTracker:DeleteTimeline(i)
    local arr = self:GetTimelines()
    if not arr[i] then return end
    table.remove(arr, i)
    self:RebuildAll()
end

function UptimeTracker:MigrateToTimelinesIfNeeded()
    local haveNew = self.db.char.timelines and (#self.db.char.timelines > 0)
    if haveNew then return end
    local clusters = self.db.char.clusters or {}
    local groups = self.db.char.groups or {}
    -- Build general from first cluster/group if available
    local general = self:GetGeneral()
    if #clusters > 0 then
        local c1 = clusters[1]
        general.length = c1.length or (c1.size and c1.size.width) or general.length
        general.thickness = c1.thickness or (c1.size and c1.size.height) or general.thickness
        general.maxTrackingTime = c1.maxTrackingTime or general.maxTrackingTime
        general.windowStart = 0
        general.windowEnd = general.maxTrackingTime
        general.orientation = (c1.direction == "topToBottom" or c1.direction == "bottomToTop") and "vertical" or "horizontal"
        general.direction = c1.direction or general.direction
        general.showBackground = (c1.showBackground ~= false)
        general.backgroundAlpha = c1.backgroundAlpha or general.backgroundAlpha
        if c1.position then general.position = { point = c1.position.point or "CENTER", x = c1.position.x or 0, y = c1.position.y or 0 } end
    end
    if #groups > 0 then
        local g1 = groups[1]
        if g1 and g1.position then general.position = { point = g1.position.point or "CENTER", x = g1.position.x or 0, y = g1.position.y or 0 } end
        if g1 and g1.scale then general.scale = g1.scale end
    end
    -- Build timelines from clusters
    self.db.char.timelines = {}
    for _, c in ipairs(clusters) do
        table.insert(self.db.char.timelines, {
            name = c.name or "Timeline",
            enabled = c.enabled ~= false,
            trackingConfigs = c.trackingConfigs or {},
        })
    end
end

function UptimeTracker:EnsureDefaultTimeline()
    local timelines = self:GetTimelines()
    if #timelines == 0 then
        self:AddTimeline({
            name = "Timeline 1",
            enabled = true,
            trackingConfigs = {
                { resolvedName = "Frost Fever", matchByName = true, type = "debuff", unit = "target", requireMine = true },
                { resolvedName = "Killing Machine", matchByName = true, type = "buff", unit = "player" },
            }
        })
    end
end

function UptimeTracker:DeleteGroup(i)
    local groups = self.db.char.groups
    if not groups or not groups[i] then return end
    -- Reassign clusters: detach those in this group; adjust indices for higher groupIds
    local clusters = self:GetClusters()
    local removedIdx = i
    for _, c in ipairs(clusters) do
        if c.groupId then
            if c.groupId == removedIdx then
                -- Convert to standalone using absolute position = group.position + offset
                local gp = groups[removedIdx]
                local offx = (c.groupOffset and c.groupOffset.x) or 0
                local offy = (c.groupOffset and c.groupOffset.y) or 0
                local absx = ((gp and gp.position and gp.position.x) or 0) + offx
                local absy = ((gp and gp.position and gp.position.y) or 0) + offy
                c.position = { point = "CENTER", x = absx, y = absy }
                c.groupId = nil
                c.groupOffset = nil
            elseif c.groupId > removedIdx then
                c.groupId = c.groupId - 1
            end
        end
    end
    table.remove(groups, i)
    self:RebuildAll()
end

-- General parent frame (single group for all timelines)
function UptimeTracker:CreateGeneralFrame()
    local gen = self:GetGeneral()
    if self.state.generalFrame then self.state.generalFrame:Hide() end
    local frame = CreateFrame("Frame", "NAGUptimeGeneral", UIParent)
    frame:SetSize(2, 2)
    frame:SetPoint(gen.position.point or "CENTER", gen.position.x or 0, gen.position.y or 0)
    frame:SetScale(gen.scale or 1.0)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetMovable(true)
    frame:SetScript("OnDragStart", function() if not UnitAffectingCombat("player") then frame:StartMoving() end end)
    frame:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
        local p, _, _, x, y = frame:GetPoint()
        gen.position = { point = p, x = x, y = y }
        -- If editor open, reflect coords
        if self.editor and self.editor:IsShown() and self.editorGeneralPos then
            if self.editorGeneralPos.x then self.editorGeneralPos.x:SetText(tostring(x)) end
            if self.editorGeneralPos.y then self.editorGeneralPos.y:SetText(tostring(y)) end
        end
    end)
    self.state.generalFrame = frame
end

local function createSpark(parent)
    local f = CreateFrame("Frame", nil, parent)
    f:SetSize(32, 32)
    f:SetFrameLevel((parent:GetFrameLevel() or 0) + 10)
    local t = f:CreateTexture(nil, "OVERLAY", nil, 3)
    t:SetDrawLayer("OVERLAY", 7)
    t:SetAllPoints()
    local mask = f:CreateMaskTexture()
    mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    mask:SetAllPoints()
    t:AddMaskTexture(mask)
    f.icon = t
    local txt = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    txt:SetPoint("CENTER", f, "CENTER", 0, 0)
    f.text = txt
    f:Hide(); t:Hide()
    return f
end

function UptimeTracker:CreateTimelineFrame(i)
    local gen = self:GetGeneral()
    local timelines = self:GetTimelines()
    local t = timelines[i]
    if not t then return end
    local parent = self.state.generalFrame or UIParent
    local cfgForDim = { direction = gen.direction, length = gen.length, thickness = gen.thickness }
    local frame = CreateFrame("Frame", "NAGUptimeTL" .. i, parent)
    local cw, ch = computeDimensions(cfgForDim)
    frame:SetSize(cw, ch)
    -- Stack timelines perpendicular to orientation
    local vertical = (gen.direction == "topToBottom" or gen.direction == "bottomToTop")
    local spacing = gen.spacing or 34
    local offx, offy = 0, 0
    if vertical then
        offx = (i - 1) * spacing
    else
        offy = - (i - 1) * spacing
    end
    frame:SetPoint("CENTER", parent, "CENTER", offx, offy)
    frame:EnableMouse(false) -- drag only via general frame

    if gen.showBackground then
        local bg = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
        bg:SetAllPoints()
        bg:SetColorTexture(gen.color.r or 0, gen.color.g or 0, gen.color.b or 0, gen.backgroundAlpha or 0.7)
        frame.bg = bg
    end

    local timeline = frame:CreateTexture(nil, "ARTWORK", nil, 0)
    timeline:SetPoint("LEFT", frame, "LEFT", 0, 0)
    timeline:SetSize(frame:GetWidth(), frame:GetHeight())
    timeline:SetColorTexture(gen.color.r or 0, gen.color.g or 0, gen.color.b or 0, (gen.color.a ~= nil) and gen.color.a or 0.7)
    frame.timeline = timeline

    local now = frame:CreateTexture(nil, "OVERLAY", nil, 2)
    now:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
    now:SetWidth(2)
    now:SetColorTexture(0, 0, 0, 0.7)
    frame.now = now

    frame.sparks = {}
    for s = 1, 32 do frame.sparks[s] = createSpark(frame) end

    self.state.frames[i] = { frame = frame }
end

function UptimeTracker:RebuildOne(i)
    local f = self.state.frames[i]
    if f and f.frame then f.frame:Hide() end
    self:CreateClusterFrame(i)
end

function UptimeTracker:RebuildAll()
    -- General parent
    self:CreateGeneralFrame()
    -- Timelines
    for _, f in pairs(self.state.frames) do if f and f.frame then f.frame:Hide() end end
    self.state.frames = {}
    local timelines = self:GetTimelines()
    for i = 1, #timelines do self:CreateTimelineFrame(i) end
end

-- ~~~~~~~~~~ DETECTION + RENDERING ~~~~~~~~~~
local function getAuraMaps(unit, trackType)
    local idMap, nameMap = {}, {}
    if ns and ns.SnapshotAuras then
        local cache = ns.SnapshotAuras(unit)
        if cache then
            local list = (trackType == "buff") and cache.buffs or cache.debuffs
            for _, a in ipairs(list) do
                -- Snapshot tuples align with positional UnitAura returns
                local name = a[1]
                local icon = a[2]
                local count = a[3]
                local duration = a[5]
                local expirationTime = a[6]
                local sourceUnit = a[7]
                local spellId = a[10]
                if name and spellId and type(expirationTime) == "number" then
                    local aura = { name=name, icon=icon, count=count, duration=duration, expirationTime=expirationTime, sourceUnit=sourceUnit, spellId=spellId }
                    idMap[spellId] = aura; nameMap[name] = aura
                end
            end
            return idMap, nameMap
        end
    end
    local filter = (trackType == "buff") and "HELPFUL" or "HARMFUL"
    for i = 1, 40 do
        local ret = UnitAura(unit, i, filter)
        if not ret then break end
        local name, icon, count, duration, expirationTime, sourceUnit, spellId
        if type(ret) == "table" then
            name = ret.name; icon = ret.icon; count = ret.count; duration = ret.duration; expirationTime = ret.expirationTime; sourceUnit = ret.sourceUnit; spellId = ret.spellId
        else
            local r = { UnitAura(unit, i, filter) }
            if not r[1] then break end
            -- 1=name, 2=icon, 3=count, 5=duration, 6=expirationTime, 7=sourceUnit, 10=spellId
            name = r[1]; icon = r[2]; count = r[3]; duration = r[5]; expirationTime = r[6]; sourceUnit = r[7]; spellId = r[10]
        end
        if not name then break end
        if spellId and type(expirationTime) == "number" then
            local aura = { name=name, icon=icon, count=count, duration=duration, expirationTime=expirationTime, sourceUnit=sourceUnit, spellId=spellId }
            idMap[spellId] = aura; nameMap[name] = aura
        end
    end
    return idMap, nameMap
end

local function resolveIconForSpell(id)
    local icon = (GetSpellTexture and GetSpellTexture(id)) or nil
    if not icon then
        local si = WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(id)
        icon = (si and si.iconID) or "Interface\\Icons\\INV_Misc_QuestionMark"
    end
    return icon
end

function UptimeTracker:UpdateAll()
    if not self.db.char.enabled then
        for _, f in pairs(self.state.frames) do if f.frame then f.frame:Hide() end end
        return
    end

    -- Optional 1/sec aura debug scan
    local now = GetTime()
    if self.db.char.debugScan and (now - (self.state.lastDebug or 0)) >= 1.0 then
        self.state.lastDebug = now
        -- Print simple cluster geometry for diagnostics
        local gen = self:GetGeneral()
        local w, h = computeDimensions({ direction = gen.direction, length = gen.length, thickness = gen.thickness })
        print(string.format("|cFF66CCFF[UptimeGeom] General dir=%s len=%s thk=%s size=%dx%d spacing=%s|r",
            tostring(gen.direction or "rightToLeft"), tostring(gen.length or "-"), tostring(gen.thickness or "-"), w, h, tostring(gen.spacing or "-")))
        local function printAuras(unit, filter, label)
            if not UnitExists or not UnitExists(unit) then
                print(string.format("|cFF99CCFF[UptimeScan] %s: no unit|r", label))
                return
            end
            print(string.format("|cFF99CCFF[UptimeScan] %s|r", label))
            local found = 0
            for i = 1, 40 do
                local a = UnitAura(unit, i, filter)
                if not a then break end
                local name, icon, count, expirationTime, sourceUnit, spellId
                if type(a) == "table" then
                    name = a.name
                    icon = a.icon
                    count = a.count
                    expirationTime = a.expirationTime
                    sourceUnit = a.sourceUnit
                    spellId = a.spellId
                    if not name then break end
                else
                    -- Fallback to positional returns (Retail/Cata):
                    -- 1=name, 2=icon, 3=count, 4=dispelType, 5=duration, 6=expirationTime, 7=sourceUnit, 10=spellId
                    local r = { UnitAura(unit, i, filter) }
                    if not r[1] then break end
                    name = r[1]; icon = r[2]; count = r[3]; expirationTime = r[6]; sourceUnit = r[7]; spellId = r[10]
                end
                local tl = 0
                if type(expirationTime) == "number" then
                    tl = expirationTime - GetTime()
                end
                print(string.format("  [%02d] %s (ID:%s) %.1fs stacks:%s src:%s", i, tostring(name), tostring(spellId or "?"), tl, tostring(count or 0), tostring(sourceUnit)))
                found = found + 1
            end
            if found == 0 then print("  (none)") end
        end
        if UnitExists and UnitExists("target") then
            local tn = UnitName and UnitName("target") or "target"
            printAuras("target", "HARMFUL", string.format("TARGET %s - Debuffs", tostring(tn)))
        else
            print("|cFF99CCFF[UptimeScan] TARGET: none|r")
        end
        printAuras("player", "HELPFUL", "PLAYER - Buffs")
    end
    local timelines = self:GetTimelines()
    for i = 1, #timelines do self:UpdateVisual(i) end
end

function UptimeTracker:ShouldShowTimeline(timeline)
    if not timeline or not timeline.enabled then return false end
    return true
end

function UptimeTracker:UpdateVisual(i)
    local gen = self:GetGeneral()
    local timelines = self:GetTimelines()
    local t = timelines[i]
    local f = self.state.frames[i] and self.state.frames[i].frame
    if not t or not f then return end

    if not self:ShouldShowTimeline(t) then
        f:Hide(); for _, s in ipairs(f.sparks) do s:Hide(); if s.icon then s.icon:Hide() end end; return
    end

    f:Show()

    local localActive = {}
    for _, tc in ipairs(t.trackingConfigs or {}) do
        local tType = tc.type or "buff"
        local unit = tc.unit or "player"
        local matchByName = tc.matchByName ~= false
        local idMap, nameMap = getAuraMaps(unit, tType)
        if tType == "buff" or tType == "debuff" then
            local aura = (tc.id and idMap[tc.id]) or nil
            if not aura and matchByName then
                if tc.resolvedName then aura = nameMap[tc.resolvedName] end
                if not aura then
                    if tc.id then
                        local si = WoWAPI.GetSpellInfo(tc.id)
                        if si and si.name then aura = nameMap[si.name]; if aura then tc.resolvedName = si.name end end
                    end
                end
            end
            -- If requireMine is set, ensure sourceUnit is 'player'
            if aura and tc.requireMine and aura.sourceUnit ~= "player" then aura = nil end
            if aura and type(aura.expirationTime) == "number" and (aura.expirationTime - GetTime()) > 0 then
                tinsert(localActive, {
                    spellId = aura.spellId or tc.id,
                    expirationTime = aura.expirationTime,
                    icon = aura.icon or resolveIconForSpell(aura.spellId or tc.id),
                    name = aura.name,
                    iconScale = tc.iconScale,
                })
            end
        else
            -- Spell cooldowns: prefer SpellTimeToReadyWithGCD only if beyond GCD window; otherwise use SpellTimeToReady
            local timeToReady
            if NAG and NAG.SpellTimeToReadyWithGCD and NAG.SpellTimeToReady and NAG.GCDTimeValue then
                local withGCD = NAG:SpellTimeToReadyWithGCD(tc.id) or 0
                local pure = NAG:SpellTimeToReady(tc.id) or 0
                local gcdVal = (NAG:GCDTimeValue() or 0) + 0.05
                timeToReady = (withGCD > gcdVal) and withGCD or pure
            else
                -- Fallback: subtract current GCD from raw cooldown
                local cd = WoWAPI.GetSpellCooldown(tc.id)
                if cd and cd.duration then
                    local raw = (cd.startTime + cd.duration) - GetTime()
                    local gcd = (NAG and NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
                    timeToReady = max(0, (raw or 0) - gcd)
                end
            end
            local genMax = (gen and gen.maxTrackingTime) or 15
            if timeToReady and timeToReady > 0 and timeToReady <= genMax then
                local si = WoWAPI.GetSpellInfo(tc.id)
                tinsert(localActive, {
                    spellId = tc.id,
                    expirationTime = GetTime() + timeToReady,
                    icon = (si and si.iconID) or resolveIconForSpell(tc.id),
                    name = (si and si.name) or tostring(tc.id),
                    iconScale = tc.iconScale,
                })
            end
        end
    end

    -- Hide when empty if configured
    if (#localActive == 0) and (gen.hideWhenEmpty == true) then
        f:Hide(); for _, s in ipairs(f.sparks) do s:Hide(); if s.icon then s.icon:Hide() end end; return
    end

    -- Draw sparks
    for _, s in ipairs(f.sparks) do s:Hide(); if s.icon then s.icon:Hide() end end
    local width, height = computeDimensions({ direction = gen.direction, length = gen.length, thickness = gen.thickness })
    -- If direction/geometry changed, update frame and timeline sizing to match
    if math.floor(f:GetWidth() + 0.5) ~= width or math.floor(f:GetHeight() + 0.5) ~= height then
        f:SetSize(width, height)
        if f.timeline then
            f.timeline:ClearAllPoints()
            f.timeline:SetPoint("LEFT", f, "LEFT", 0, 0)
            f.timeline:SetSize(width, height)
        end
        if f.bg then f.bg:ClearAllPoints(); f.bg:SetAllPoints() end
        if f.now then
            local dir = gen.direction or "rightToLeft"
            if dir == "topToBottom" or dir == "bottomToTop" then
                f.now:ClearAllPoints(); f.now:SetPoint("BOTTOM", f, "BOTTOM", 0, 0); f.now:SetSize(width, 2)
            else
                f.now:ClearAllPoints(); f.now:SetPoint("RIGHT", f, "RIGHT", 0, 0); f.now:SetSize(2, height)
            end
        end
    end
    local maxTime = gen.maxTrackingTime
    local pxPerSecX = width / maxTime
    local pxPerSecY = height / maxTime
    local windowStart = (gen.windowStart ~= nil) and gen.windowStart or 0
    local windowEnd = (gen.windowEnd ~= nil) and gen.windowEnd or maxTime
    local direction = gen.direction or "rightToLeft"

    local idx = 0
    for _, data in ipairs(localActive) do
        local remaining = max(0, (data.expirationTime or 0) - GetTime())
        if remaining >= windowStart and remaining <= windowEnd then
            idx = idx + 1
            local s = f.sparks[idx]
            if not s then break end
            local progress = remaining / maxTime
            if progress < 0 then progress = 0 elseif progress > 1 then progress = 1 end
            local x, y = 0, 0
            if direction == "rightToLeft" then
                -- right = full duration; left = 0
                x = progress * width
                s:ClearAllPoints(); s:SetPoint("CENTER", f, "LEFT", x, 0)
            elseif direction == "leftToRight" then
                -- left = full duration; right = 0
                x = width - (progress * width)
                s:ClearAllPoints(); s:SetPoint("CENTER", f, "LEFT", x, 0)
            elseif direction == "topToBottom" then
                -- up = full duration; down = 0
                y = progress * height
                s:ClearAllPoints(); s:SetPoint("CENTER", f, "BOTTOM", 0, y)
            elseif direction == "bottomToTop" then
                -- down = full duration; up = 0
                y = height - (progress * height)
                s:ClearAllPoints(); s:SetPoint("CENTER", f, "BOTTOM", 0, y)
            else
                -- fallback
                x = progress * width
                s:ClearAllPoints(); s:SetPoint("CENTER", f, "LEFT", x, 0)
            end
            s.icon:SetTexture(data.icon or resolveIconForSpell(data.spellId))
            s.icon:Show()
            -- Apply per-track icon scale (default 1.0) over a base of 32px
            local scale = (data.iconScale and tonumber(data.iconScale)) or 1.0
            if scale < 0.25 then scale = 0.25 elseif scale > 3.0 then scale = 3.0 end
            s:SetSize(32 * scale, 32 * scale)
            s.text:SetText(tostring(math.floor(remaining)))
            s:Show()
        end
    end
end

-- ~~~~~~~~~~ OPTIONS (Minimal)
function UptimeTracker:GetOptions()
    return {
        type = "group",
        name = L["Uptime Tracker"] or "Uptime Tracker",
        order = 36,
        args = {
            enabled = OptionsFactory:CreateToggle(
                L["enabled"] or "Enabled",
                "Toggle the uptime tracker",
                function() return self.db.char.enabled end,
                function(_, v) self.db.char.enabled = v; self:RebuildAll() end,
                { order = 0 }
            ),
            debugScan = OptionsFactory:CreateToggle(L["debugScan"] or "Debug Aura Scan (1/s)", L["debugScanDesc"] or "Print player buffs and target debuffs once per second",
                function() return self.db.char.debugScan end,
                function(_, v) self.db.char.debugScan = v end,
                { order = 1 }
            ),
            openEditor = {
                type = "execute",
                name = L["uptimeEditor"] or "Uptime Editor",
                desc = L["uptimeTrackerDesc"] or "Configure timelines for tracking buffs/debuffs",
                order = 2,
                func = function() self:ShowEditor() end
            }
        }
    }
end

-- ~~~~~~~~~~ INLINE EDITOR WINDOW ~~~~~~~~~~
function UptimeTracker:ShowEditor()
    if self.editor and self.editor:IsShown() then
        self.editor:Show()
        return
    end

    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Uptime Tracker Editor")
    frame:SetLayout("Flow")
    frame:SetWidth(1170)
    frame:SetHeight(600)
    self.editor = frame
    self.editorPosFields = self.editorPosFields or {}

    local function buildTree()
        local nodes = {}
        table.insert(nodes, { value = "gen", text = "General Settings" })
        local timelines = self:GetTimelines()
        for i, t in ipairs(timelines) do
            local name = t.name or ("Timeline " .. i)
            local count = #(t.trackingConfigs or {})
            local status = (t.enabled ~= false) and "✓" or "○"
            table.insert(nodes, { value = "t:" .. i, text = string.format("%s [%d IDs] %s", status, count, name) })
        end
        return nodes
    end

    local function indexFromValue(value)
        if type(value) ~= "string" then return nil, nil end
        local last = value
        local sep = string.char(1)
        local parts = {}
        for token in string.gmatch(value, "[^" .. sep .. "]+") do table.insert(parts, token) end
        if #parts > 0 then last = parts[#parts] end
        if last == "gen" then return "gen", 0 end
        local tidx = last:match("^t:(%d+)$")
        if tidx then return "t", tonumber(tidx) end
        return nil, nil
    end

    local function addNumberInput(container, label, value, onEnter)
        local lbl = AceGUI:Create("Label"); lbl:SetText(label); lbl:SetWidth(60); container:AddChild(lbl)
        local eb = AceGUI:Create("EditBox"); eb:SetText(tostring(value)); eb:SetWidth(100); eb:SetCallback("OnEnterPressed", onEnter); container:AddChild(eb)
        return eb
    end

    local tree = ns.CreateTreeGroup()
    tree:SetLayout("Fill")
    tree:SetFullWidth(true)
    tree:SetFullHeight(true)
    -- Persist and size the tree column like the old editor
    self.editorTreeStatus = self.editorTreeStatus or { groups = {}, treewidth = 260, treesizable = true, scrollvalue = 0 }
    tree:SetStatusTable(self.editorTreeStatus)
    if tree.SetTreeWidth then tree:SetTreeWidth(self.editorTreeStatus.treewidth or 260, true) end
    tree:SetTree(buildTree())
    self.editorTree = tree

    local function renderDetail(group, value)
        group:ReleaseChildren()
        local panel = AceGUI:Create("ScrollFrame"); panel:SetLayout("Flow"); panel:SetFullWidth(true); panel:SetFullHeight(true)
        group:AddChild(panel)

        local kind, idx = indexFromValue(value)
        if kind == "gen" then
            local gen = self:GetGeneral()
            local head = AceGUI:Create("Heading"); head:SetText("General Settings"); head:SetFullWidth(true); panel:AddChild(head)
            local orientGroup = AceGUI:Create("SimpleGroup"); orientGroup:SetLayout("Flow"); orientGroup:SetFullWidth(true)
            local orientDrop = AceGUI:Create("Dropdown"); orientDrop:SetLabel("Orientation"); orientDrop:SetRelativeWidth(0.47)
            orientDrop:SetList({ horizontal = "Horizontal", vertical = "Vertical" })
            orientDrop:SetValue(gen.orientation or "horizontal")
            local dirDrop = AceGUI:Create("Dropdown"); dirDrop:SetLabel("Direction"); dirDrop:SetRelativeWidth(0.47)
            local function applyDirListForOrientation(orientVal)
                if orientVal == "vertical" then
                    dirDrop:SetList({ topToBottom = "Top to Bottom", bottomToTop = "Bottom to Top" })
                    local cur = gen.direction or "topToBottom"; if cur ~= "topToBottom" and cur ~= "bottomToTop" then cur = "topToBottom" end; dirDrop:SetValue(cur); gen.direction = cur
                else
                    dirDrop:SetList({ rightToLeft = "Right to Left", leftToRight = "Left to Right" })
                    local cur = gen.direction or "rightToLeft"; if cur ~= "rightToLeft" and cur ~= "leftToRight" then cur = "rightToLeft" end; dirDrop:SetValue(cur); gen.direction = cur
                end
            end
            orientDrop:SetCallback("OnValueChanged", function(_, _, val) gen.orientation = val; self:RebuildAll(); applyDirListForOrientation(val) end)
            applyDirListForOrientation(gen.orientation or "horizontal")
            dirDrop:SetCallback("OnValueChanged", function(_, _, val) gen.direction = val; self:RebuildAll() end)
            orientGroup:AddChild(orientDrop); orientGroup:AddChild(dirDrop); panel:AddChild(orientGroup)

            local lineHead = AceGUI:Create("Heading"); lineHead:SetText("Line"); lineHead:SetFullWidth(true); panel:AddChild(lineHead)
            local lineGroup = AceGUI:Create("SimpleGroup"); lineGroup:SetLayout("Flow"); lineGroup:SetFullWidth(true)
            addNumberInput(lineGroup, "Length:", gen.length or 220, function(_, _, text) gen.length = tonumber(text) or 220; self:RebuildAll() end)
            addNumberInput(lineGroup, "Thickness:", gen.thickness or 2, function(_, _, text) gen.thickness = tonumber(text) or 2; self:RebuildAll() end)
            panel:AddChild(lineGroup)

            local twHead = AceGUI:Create("Heading"); twHead:SetText("Tracking Window"); twHead:SetFullWidth(true); panel:AddChild(twHead)
            local twGroup = AceGUI:Create("SimpleGroup"); twGroup:SetLayout("Flow"); twGroup:SetFullWidth(true)
            addNumberInput(twGroup, "Max(s):", gen.maxTrackingTime or 20, function(_, _, text) local v=tonumber(text) or 20; gen.maxTrackingTime=v; gen.windowStart=0; gen.windowEnd=v; self:RebuildAll() end)
            panel:AddChild(twGroup)

            local spHead = AceGUI:Create("Heading"); spHead:SetText("Layout"); spHead:SetFullWidth(true); panel:AddChild(spHead)
            local spGroup = AceGUI:Create("SimpleGroup"); spGroup:SetLayout("Flow"); spGroup:SetFullWidth(true)
            addNumberInput(spGroup, "Spacing:", gen.spacing or 34, function(_, _, text) gen.spacing = tonumber(text) or 34; self:RebuildAll() end)
            panel:AddChild(spGroup)

            local bgToggle = AceGUI:Create("CheckBox"); bgToggle:SetLabel("Show Background"); bgToggle:SetValue(gen.showBackground ~= false); bgToggle:SetFullWidth(true)
            bgToggle:SetCallback("OnValueChanged", function(_, _, v) gen.showBackground = v; self:RebuildAll() end)
            panel:AddChild(bgToggle)
            local colorGroup = AceGUI:Create("SimpleGroup"); colorGroup:SetLayout("Flow"); colorGroup:SetFullWidth(true)
            addNumberInput(colorGroup, "Color R:", gen.color.r or 0, function(_, _, text) gen.color.r = tonumber(text) or 0; self:RebuildAll() end)
            addNumberInput(colorGroup, "G:", gen.color.g or 0, function(_, _, text) gen.color.g = tonumber(text) or 0; self:RebuildAll() end)
            addNumberInput(colorGroup, "B:", gen.color.b or 0, function(_, _, text) gen.color.b = tonumber(text) or 0; self:RebuildAll() end)
            addNumberInput(colorGroup, "A:", gen.color.a or 0.7, function(_, _, text) gen.color.a = tonumber(text) or 0.7; self:RebuildAll() end)
            panel:AddChild(colorGroup)

            local posHead = AceGUI:Create("Heading"); posHead:SetText("Position"); posHead:SetFullWidth(true); panel:AddChild(posHead)
            local posGroup = AceGUI:Create("SimpleGroup"); posGroup:SetLayout("Flow"); posGroup:SetFullWidth(true)
            local xIn = addNumberInput(posGroup, "X:", gen.position.x or 0, function(_, _, text) gen.position.x = tonumber(text) or 0; self:RebuildAll() end)
            local yIn = addNumberInput(posGroup, "Y:", gen.position.y or 0, function(_, _, text) gen.position.y = tonumber(text) or 0; self:RebuildAll() end)
            self.editorGeneralPos = { x = xIn, y = yIn }
            panel:AddChild(posGroup)
            local sc = AceGUI:Create("Slider"); sc:SetLabel("Scale"); sc:SetSliderValues(0.5, 2.5, 0.05); sc:SetValue(gen.scale or 1.0); sc:SetWidth(200)
            sc:SetCallback("OnValueChanged", function(_, _, v) gen.scale = v; self:RebuildAll() end)
            panel:AddChild(sc)
            return
        end

        if kind ~= "t" then local msg = AceGUI:Create("Label"); msg:SetText("Select General or a Timeline."); panel:AddChild(msg); return end

        local tls = self:GetTimelines(); local t = tls[idx]
        if not t then local msg = AceGUI:Create("Label"); msg:SetText("Timeline not found"); panel:AddChild(msg); return end
        local head = AceGUI:Create("Heading"); head:SetText(string.format("Timeline #%d: %s", idx, t.name or ("Timeline " .. idx))); head:SetFullWidth(true); panel:AddChild(head)
        local nameEdit = AceGUI:Create("EditBox"); nameEdit:SetLabel("Name"); nameEdit:SetRelativeWidth(0.95); nameEdit:SetText(t.name or ("Timeline " .. idx))
        nameEdit:SetCallback("OnEnterPressed", function(_, _, text) t.name = text; self:UpdateTimeline(idx, { name = text }); tree:SetTree(buildTree()); tree:SelectByValue("t:" .. idx) end)
        panel:AddChild(nameEdit)
        local enabled = AceGUI:Create("CheckBox"); enabled:SetLabel("Enabled"); enabled:SetValue(t.enabled ~= false); enabled:SetFullWidth(true)
        enabled:SetCallback("OnValueChanged", function(_, _, v) t.enabled = v; self:UpdateTimeline(idx, { enabled = v }) end)
        panel:AddChild(enabled)

        local idsHead = AceGUI:Create("Heading"); idsHead:SetText(string.format("Tracked IDs (%d)", #(t.trackingConfigs or {}))); idsHead:SetFullWidth(true); panel:AddChild(idsHead)
        t.trackingConfigs = t.trackingConfigs or {}
        for j, tc in ipairs(t.trackingConfigs) do
            local row = AceGUI:Create("InlineGroup"); row:SetLayout("Flow"); row:SetFullWidth(true); row:SetTitle(string.format("Track #%d", j))
            local nameLabel = AceGUI:Create("Label"); nameLabel:SetRelativeWidth(0.95)
            local si = WoWAPI.GetSpellInfo(tc.id)
            local displayName = (tc.resolvedName and (tc.resolvedName .. " (name)")) or (si and si.name) or (tc.id and ("ID " .. tostring(tc.id))) or "Unknown"
            nameLabel:SetText(string.format("%s", displayName))
            row:AddChild(nameLabel)
            local typeDrop = AceGUI:Create("Dropdown"); typeDrop:SetLabel("Type"); typeDrop:SetRelativeWidth(0.47)
            typeDrop:SetList({ buff = "Buff", debuff = "Debuff", item = "Item CD", spell = "Spell CD" })
            typeDrop:SetValue(tc.type or "buff")
            typeDrop:SetCallback("OnValueChanged", function(_, _, val) tc.type = val; self:UpdateTimeline(idx, { trackingConfigs = t.trackingConfigs }) end)
            row:AddChild(typeDrop)
            if (tc.type == "buff" or tc.type == "debuff") then
                local unitDrop = AceGUI:Create("Dropdown"); unitDrop:SetLabel("Unit"); unitDrop:SetRelativeWidth(0.47)
                unitDrop:SetList({ player = "Player", target = "Target", focus = "Focus", pet = "Pet" })
                unitDrop:SetValue(tc.unit or "player")
                unitDrop:SetCallback("OnValueChanged", function(_, _, val) tc.unit = val; self:UpdateTimeline(idx, { trackingConfigs = t.trackingConfigs }) end)
                row:AddChild(unitDrop)
                local mbn = AceGUI:Create("CheckBox"); mbn:SetLabel("Match by Name"); mbn:SetValue(tc.matchByName ~= false); mbn:SetWidth(140)
                mbn:SetCallback("OnValueChanged", function(_, _, val) tc.matchByName = (val == true); self:UpdateTimeline(idx, { trackingConfigs = t.trackingConfigs }) end)
                row:AddChild(mbn)
                local mine = AceGUI:Create("CheckBox"); mine:SetLabel("Only Mine"); mine:SetValue(tc.requireMine == true); mine:SetWidth(120)
                mine:SetCallback("OnValueChanged", function(_, _, val) tc.requireMine = (val == true); self:UpdateTimeline(idx, { trackingConfigs = t.trackingConfigs }) end)
                row:AddChild(mine)
            end
            local scaleSlider = AceGUI:Create("Slider"); scaleSlider:SetLabel("Icon Scale"); scaleSlider:SetSliderValues(0.25, 3.0, 0.05)
            scaleSlider:SetValue(tc.iconScale or 1.0); scaleSlider:SetWidth(180)
            scaleSlider:SetCallback("OnValueChanged", function(_, _, v) tc.iconScale = v; self:UpdateTimeline(idx, { trackingConfigs = t.trackingConfigs }) end)
            row:AddChild(scaleSlider)
            local removeBtn = AceGUI:Create("Button"); removeBtn:SetText("Remove"); removeBtn:SetWidth(80)
            removeBtn:SetCallback("OnClick", function() table.remove(t.trackingConfigs, j); self:UpdateTimeline(idx, { trackingConfigs = t.trackingConfigs }); tree:SetTree(buildTree()); tree:SelectByValue("t:" .. idx) end)
            row:AddChild(removeBtn)
            panel:AddChild(row)
        end
        local addGroup = AceGUI:Create("InlineGroup"); addGroup:SetLayout("Flow"); addGroup:SetFullWidth(true); addGroup:SetTitle("Add New Tracked ID or Name")
        local idInput = AceGUI:Create("EditBox"); idInput:SetLabel("Spell/Item ID or Name"); idInput:SetRelativeWidth(0.6); addGroup:AddChild(idInput)
        local addType = AceGUI:Create("Dropdown"); addType:SetLabel("Type"); addType:SetRelativeWidth(0.35); addType:SetList({ buff="Buff", debuff="Debuff", item="Item CD", spell="Spell CD" }); addType:SetValue("buff"); addGroup:AddChild(addType)
        local addUnit = AceGUI:Create("Dropdown"); addUnit:SetLabel("Unit"); addUnit:SetRelativeWidth(0.35); addUnit:SetList({ player="Player", target="Target", focus="Focus", pet="Pet" }); addUnit:SetValue("player"); addGroup:AddChild(addUnit)
        local addBtn2 = AceGUI:Create("Button"); addBtn2:SetText("+ Add"); addBtn2:SetWidth(120)
        addBtn2:SetCallback("OnClick", function()
            local txt = idInput:GetText() or ""; local id = tonumber(txt); local resolvedName = nil
            if not id and txt ~= "" then local siAdd = WoWAPI.GetSpellInfo(txt); if siAdd and siAdd.spellID then id = siAdd.spellID; resolvedName = siAdd.name else resolvedName = txt end end
            if id or resolvedName then table.insert(t.trackingConfigs, { id=id, resolvedName=resolvedName, matchByName=true, type=addType:GetValue() or "buff", unit=addUnit:GetValue() or "player" }); self:UpdateTimeline(idx, { trackingConfigs = t.trackingConfigs }); idInput:SetText(""); tree:SelectByValue("t:" .. idx) else self:Error("Invalid ID or name: " .. tostring(txt)) end
        end)
        addGroup:AddChild(addBtn2); panel:AddChild(addGroup)
        local delBtn = AceGUI:Create("Button"); delBtn:SetText("Delete Timeline"); delBtn:SetWidth(150)
        delBtn:SetCallback("OnClick", function() self:DeleteTimeline(idx); tree:SetTree(buildTree()); renderDetail(tree, "gen") end)
        panel:AddChild(delBtn)
    end

    tree:SetCallback("OnGroupSelected", function(widget, _, value)
        renderDetail(widget, value)
    end)

    local controls = AceGUI:Create("SimpleGroup"); controls:SetLayout("Flow"); controls:SetFullWidth(true)
    local addTL = AceGUI:Create("Button"); addTL:SetText("+ Add Timeline"); addTL:SetWidth(160)
    addTL:SetCallback("OnClick", function() local tid = self:AddTimeline({}); tree:SetTree(buildTree()); tree:SelectByValue("t:" .. tid) end)
    controls:AddChild(addTL)


    -- Backfill: Filters section (Classes/Specs) to match past editor features
    local function arrayToCSV(arr)
        if type(arr) ~= "table" then return "" end
        local out = {}
        for _, v in ipairs(arr) do out[#out+1] = tostring(v) end
        return table.concat(out, ", ")
    end
    local function csvToArray(txt, asNumbers)
        local res = {}
        if type(txt) ~= "string" or txt == "" then return res end
        for token in string.gmatch(txt, "[^,]+") do
            local t = token:gsub("^%s+", ""):gsub("%s+$", "")
            if t ~= "" then
                if asNumbers then local n = tonumber(t); if n then table.insert(res, n) end else table.insert(res, t:upper()) end
            end
        end
        return res
    end

    frame:AddChild(controls)
    frame:AddChild(tree)
    tree:SelectByValue("gen")
end


