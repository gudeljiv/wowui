--- @module "NAG.LeaderboardViewer"
--- UI module to view NAG leaderboard data (local and synced).
---
--- Provides a movable frame with metric tabs, Local vs Merged view, and a table
--- showing rank, player, value, optional spell/target from context, and timestamp.
--- Follows compact, addon-channel leaderboard viewer patterns.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)

local CreateFrame = _G.CreateFrame
local date = _G.date
local tostring = _G.tostring
local type = _G.type
local pairs = _G.pairs
local ipairs = _G.ipairs
local sort = _G.table.sort
local strlower = _G.strlower
local strtrim = _G.strtrim
local BreakUpLargeNumbers = _G.BreakUpLargeNumbers
local GetSpellTexture = _G.GetSpellTexture
local GetSpellInfo = _G.GetSpellInfo
local UnitFullName = _G.UnitFullName
local UnitName = _G.UnitName
local UnitGUID = _G.UnitGUID
local UnitClass = _G.UnitClass
local GetRealmName = _G.GetRealmName
local UIDropDownMenu_SetWidth = _G.UIDropDownMenu_SetWidth
local UIDropDownMenu_SetText = _G.UIDropDownMenu_SetText
local UIDropDownMenu_Initialize = _G.UIDropDownMenu_Initialize
local UIDropDownMenu_CreateInfo = _G.UIDropDownMenu_CreateInfo
local UIDropDownMenu_AddButton = _G.UIDropDownMenu_AddButton
local UIDropDownMenu_EnableDropDown = _G.UIDropDownMenu_EnableDropDown
local UIDropDownMenu_DisableDropDown = _G.UIDropDownMenu_DisableDropDown

-- ============================ CONSTANTS ============================

local VISIBLE_ROWS = 10
local MAX_ROWS = 50
local ROW_HEIGHT = 22
local SCROLL_FRAME_HEIGHT = VISIBLE_ROWS * ROW_HEIGHT
local HEADER_Y = -118
local TAB_ROW1_Y = -44
local TAB_ROW2_Y = -72
local MIN_FRAME_HEIGHT = 410
local GENERIC_SPELL_ICON = 132349
local SCOPE_LABELS = {
    all = L["All"] or "All",
    ["local"] = L["Local"] or "Local",
    guild = L["Guild"] or "Guild",
    server = L["Server"] or "Server",
}
local SCOPE_SHORT = {
    ["local"] = "L",
    guild = "G",
    server = "S",
}
local CLASS_FILTER_AUTO = "auto"
local CLASS_FILTER_ALL = "all"
-- Class token to locale key (matches NAG locale class name keys).
local CLASS_TO_LOCALE_KEY = {
    [CLASS_FILTER_AUTO] = "Auto (Metric)",
    [CLASS_FILTER_ALL] = "All Classes",
    DEATHKNIGHT = "death Knight",
    DEMONHUNTER = "demon Hunter",
    DRUID = "druid",
    EVOKER = "evoker",
    HUNTER = "hunter",
    MAGE = "mage",
    MONK = "monk",
    PALADIN = "paladin",
    PRIEST = "priest",
    ROGUE = "rogue",
    SHAMAN = "shaman",
    WARLOCK = "warlock",
    WARRIOR = "warrior",
}
local CLASS_FILTER_LABELS = {}
for token, locKey in pairs(CLASS_TO_LOCALE_KEY) do
    CLASS_FILTER_LABELS[token] = L[locKey] or locKey
end
local CLASS_FILTER_ORDER = {
    CLASS_FILTER_AUTO,
    CLASS_FILTER_ALL,
    "DEATHKNIGHT",
    "DEMONHUNTER",
    "DRUID",
    "EVOKER",
    "HUNTER",
    "MAGE",
    "MONK",
    "PALADIN",
    "PRIEST",
    "ROGUE",
    "SHAMAN",
    "WARLOCK",
    "WARRIOR",
}

local RANK_RGB = {
    [1] = { 230/255, 204/255, 128/255 },
    [2] = { 255/255, 128/255,   0/255 },
    [3] = { 163/255,  53/255, 238/255 },
    [4] = {   0/255, 112/255, 221/255 },
    [5] = {  30/255, 255/255,   0/255 },
    [6] = {  30/255, 255/255,   0/255 },
    [7] = { 255/255, 255/255, 255/255 },
    [8] = { 255/255, 255/255, 255/255 },
    [9] = { 157/255, 157/255, 157/255 },
    [10] = { 157/255, 157/255, 157/255 },
}

local COLUMNS = {
    { key = "rank",   text = "#",      width = 26 },
    { key = "class",  text = "Class",  width = 24 },
    { key = "player", text = "Player", width = 120 },
    { key = "value",  text = "Value",  width = 75 },
    { key = "spell",  text = "Spell",  width = 135 },
    { key = "target", text = "Target", width = 145 },
    { key = "realm",  text = "Realm",  width = 90 },
    { key = "guild",  text = "Guild",  width = 90 },
    { key = "date",   text = "Date",   width = 90 },
}

-- Class name (e.g. "WARRIOR", "HUNTER") to icon file ID for SetTexture(fileId).
local CLASS_ICON_IDS = {
    WARRIOR = 626008,
    PALADIN = 626003,
    HUNTER = 626000,
    ROGUE = 626005,
    PRIEST = 626004,
    DEATHKNIGHT = 135771,
    SHAMAN = 626006,
    MAGE = 626001,
    WARLOCK = 626007,
    MONK = 626002,
    DRUID = 625999,
    DEMONHUNTER = 1247264,
    EVOKER = 4574311,
}

-- ============================ DEFAULTS ============================

local defaults = {
    global = {
        frameWidth = 900,
        frameHeight = MIN_FRAME_HEIGHT,
    },
    char = {
        framePosition = { point = "CENTER", x = 0, y = 0 },
        viewMode = "local", -- "local" | "merged"
        scopeFilter = "all", -- "all" | "local" | "guild" | "server"
        classFilter = CLASS_FILTER_AUTO, -- "auto" | "all" | class token
    },
}

-- ============================ MODULE CREATION ============================

--- @class LeaderboardViewer : CoreModule
local LeaderboardViewer = NAG:CreateModule("LeaderboardViewer", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    databaseRoot = "leaderboard",
    optionsCategory = ns.MODULE_CATEGORIES.LEADERBOARD,
    slashCommands = {
        ["leaderboard"] = {
            handler = "HandleLeaderboardSlash",
            help = L["Leaderboard commands: toggle/show/hide/reset"] or "Leaderboard commands: toggle/show/hide/reset",
            root = "nag",
            path = { "leaderboard" },
            category = "Features",
        },
    },
    messageHandlers = {
        NAG_LEADERBOARD_LOCAL_RECORD_ADDED = "OnLocalRecordAdded",
        NAG_LEADERBOARD_SYNC_MERGED = "OnSyncMerged",
    },
    defaultState = {
        frame = nil,
        isShown = false,
        selectedMetricId = "",
        metricDropdown = nil,
        metricDropdownLabel = nil,
        viewModeDropdown = nil,
        viewModeDropdownLabel = nil,
        scopeDropdown = nil,
        scopeDropdownLabel = nil,
        classDropdown = nil,
        classDropdownLabel = nil,
        headerFontStrings = {},
        rows = {},
        scrollFrame = nil,
        scrollChild = nil,
    },
    debugCategories = { ns.DEBUG_CATEGORIES.FEATURES },
})

ns.LeaderboardViewer = LeaderboardViewer

-- ============================ HELPERS ============================

local function formatValue(value)
    if type(value) ~= "number" then
        return tostring(value or "—")
    end
    if BreakUpLargeNumbers then
        return BreakUpLargeNumbers(value)
    end
    local s = tostring(value):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    return s
end

local function formatTimestamp(ts)
    if ts == nil or type(ts) ~= "number" then
        return "—"
    end
    local displayTimestamp = ts
    if displayTimestamp > 0 and displayTimestamp <= 86400 * 30 then
        local nowEpoch = tonumber(time and time()) or 0
        local uptime = tonumber(GetTime and GetTime()) or 0
        if nowEpoch > 0 and uptime > 0 then
            -- Convert session-relative timestamps (GetTime-based) to epoch for display.
            displayTimestamp = (nowEpoch - uptime) + displayTimestamp
        end
    end
    if displayTimestamp > 0 then
        return date("%m/%d/%y", displayTimestamp)
    end
    return "—"
end

local function playerDisplayName(playerName)
    if type(playerName) ~= "string" or playerName == "" then
        return "—"
    end
    local name = playerName:match("^([^-]+)")
    return name or playerName
end

local function extractRealmFromRecord(record)
    if type(record) ~= "table" then
        return ""
    end
    local function isRealmDisplaySafe(s)
        if type(s) ~= "string" or s == "" then
            return false
        end
        if s:match("^%d+%-%x+$") then
            return false
        end
        if not s:match("%a") then
            return false
        end
        return true
    end
    local explicit = tostring(record.serverName or "")
    if explicit ~= "" and isRealmDisplaySafe(explicit) then
        return explicit
    end
    local key = tostring(record.playerKey or record.playerName or "")
    local _, realm = key:match("^([^-]+)%-(.+)$")
    if type(realm) == "string" and realm ~= "" and isRealmDisplaySafe(realm) then
        return realm
    end
    return ""
end

local function extractGuildFromRecord(record, context)
    if type(record) ~= "table" then
        return "—"
    end
    local guildName = tostring(record.guildName or "")
    if guildName == "" and type(context) == "table" then
        guildName = tostring(context.guildName or "")
    end
    return guildName ~= "" and guildName or "—"
end

local function getClassIconIdFromRecord(record)
    if type(record) ~= "table" then
        return nil
    end
    local className = type(record.className) == "string" and record.className:upper() or ""
    if className == "" or className == "ALL" then
        return nil
    end
    return CLASS_ICON_IDS[className]
end

local function getCurrentPlayerIdentity()
    local fullName, fullRealm = nil, nil
    if type(UnitFullName) == "function" then
        fullName, fullRealm = UnitFullName("player")
    end
    local playerName = fullName or (type(UnitName) == "function" and UnitName("player")) or ""
    local realm = fullRealm
    if type(realm) ~= "string" or realm == "" then
        realm = type(GetRealmName) == "function" and GetRealmName() or ""
    end
    if type(playerName) ~= "string" or playerName == "" then
        return {
            key = "",
            name = "",
            guid = type(UnitGUID) == "function" and tostring(UnitGUID("player") or "") or "",
        }
    end
    local playerKey = playerName
    if type(realm) == "string" and realm ~= "" and not playerName:find("-", 1, true) then
        playerKey = playerName .. "-" .. realm
    end
    return {
        key = playerKey,
        name = playerName,
        guid = type(UnitGUID) == "function" and tostring(UnitGUID("player") or "") or "",
    }
end

local function isCurrentPlayerRecord(record, currentIdentity)
    if type(record) ~= "table" then
        return false
    end
    local currentGuid = tostring(currentIdentity and currentIdentity.guid or "")
    local candidateGuid = tostring(record.playerGUID or "")
    if currentGuid ~= "" and candidateGuid ~= "" and currentGuid == candidateGuid then
        return true
    end

    local recordPlayerKey = record.playerKey
    local currentPlayerKey = currentIdentity and currentIdentity.key or ""
    local candidate = tostring(recordPlayerKey or "")
    local current = tostring(currentPlayerKey or "")
    if candidate == "" or current == "" then
        return false
    end
    if candidate == current then
        return true
    end
    local candidateName = candidate:match("^([^-]+)")
    local currentName = current:match("^([^-]+)")
    return candidateName ~= nil and currentName ~= nil and candidateName == currentName
end

local function scopeDisplay(scope)
    local normalized = type(scope) == "string" and scope:lower() or "local"
    return SCOPE_LABELS[normalized] or SCOPE_LABELS["local"]
end

local function scopeBadge(scope)
    local normalized = type(scope) == "string" and scope:lower() or "local"
    return SCOPE_SHORT[normalized] or SCOPE_SHORT["local"]
end

local function setDropdownEnabledSafe(dropdown, enabled)
    if not dropdown then
        return
    end
    local dropdownName = type(dropdown.GetName) == "function" and dropdown:GetName() or nil
    if type(dropdownName) == "string" and dropdownName ~= "" and UIDropDownMenu_EnableDropDown and UIDropDownMenu_DisableDropDown then
        if enabled then
            UIDropDownMenu_EnableDropDown(dropdown)
        else
            UIDropDownMenu_DisableDropDown(dropdown)
        end
        return
    end
    local button = dropdown.Button
    if button and button.Enable and button.Disable then
        if enabled then
            button:Enable()
        else
            button:Disable()
        end
    end
    if dropdown.SetAlpha then
        dropdown:SetAlpha(enabled and 1 or 0.5)
    end
end

local getSpellIconPath = function(iconId)
    if type(iconId) == "string" and iconId ~= "" then
        return iconId
    end
    if type(iconId) == "number" and iconId > 0 then
        if GetSpellTexture then
            local path = GetSpellTexture(iconId)
            if path then
                return path
            end
        end
        return iconId
    end
    return GENERIC_SPELL_ICON
end

--- Resolve spell display name and icon from context; prefer spellId for localized lookup when available.
--- @param ctx table record.context
--- @return string spellName
--- @return string|number iconPathOrId
local function resolveSpellDisplay(ctx)
    local spellId = ctx and tonumber(ctx.spellId)
    if spellId and spellId > 0 then
        local WoWAPI = ns.WoWAPI
        local name, _, icon
        if WoWAPI and type(WoWAPI.GetSpellInfo) == "function" then
            name, _, icon = WoWAPI.GetSpellInfo(spellId)
        elseif GetSpellInfo then
            name, _, icon = GetSpellInfo(spellId)
        end
        if name and name ~= "" then
            local nameStr = type(name) == "table" and name.name or tostring(name)
            return nameStr, icon or getSpellIconPath(ctx.spellIcon)
        end
    end
    local raw = ctx and ctx.spellName or "—"
    local spellNameStr = type(raw) == "table" and raw.name or (type(raw) == "string" and raw) or "—"
    local spellIcon = ctx and ctx.spellIcon or GENERIC_SPELL_ICON
    return spellNameStr, getSpellIconPath(spellIcon)
end

-- ============================ SERVICE ACCESS ============================

function LeaderboardViewer:GetLeaderboardService()
    if not self._leaderboardService then
        self._leaderboardService = NAG:GetModule("LeaderboardService", true)
    end
    return self._leaderboardService
end

function LeaderboardViewer:GetViewAdapter()
    if not self._viewAdapter then
        self._viewAdapter = NAG:GetModule("LeaderboardViewAdapter", true)
    end
    return self._viewAdapter
end

-- ============================ FRAME LIFECYCLE ============================

--- Create the main viewer frame (called on first show).
function LeaderboardViewer:CreateFrame()
    if self.state.frame then
        return
    end

    local frame = CreateFrame("Frame", "NAG_LeaderboardViewer", UIParent, "BackdropTemplate")
    local pos = self.db.char.framePosition or { point = "CENTER", x = 0, y = 0 }
    local frameWidth = tonumber(self.db.global.frameWidth) or defaults.global.frameWidth
    local frameHeight = tonumber(self.db.global.frameHeight) or defaults.global.frameHeight
    if frameHeight < MIN_FRAME_HEIGHT then
        frameHeight = MIN_FRAME_HEIGHT
        self.db.global.frameHeight = frameHeight
    end

    frame:SetSize(frameWidth, frameHeight)
    frame:SetPoint(pos.point or "CENTER", UIParent, pos.point or "CENTER", pos.x or 0, pos.y or 0)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetClampedToScreen(true)
    frame:SetScript("OnDragStart", function(f)
        f:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(f)
        f:StopMovingOrSizing()
        local point, _, _, x, y = f:GetPoint()
        self.db.char.framePosition = { point = point, x = x, y = y }
    end)
    frame:Hide()

    if frame.SetBackdrop then
        frame:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 },
        })
        frame:SetBackdropColor(0, 0, 0, 0.8)
    end

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -12)
    title:SetText(L["NAG Leaderboards"] or "NAG Leaderboards")

    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", 0, 0)
    closeBtn:SetScript("OnClick", function()
        self:HideFrame()
    end)

    table.insert(UISpecialFrames, "NAG_LeaderboardViewer")

    self:CreateMetricDropdown(frame)
    self:CreateViewModeDropdown(frame)
    self:CreateScopeDropdown(frame)
    self:CreateClassDropdown(frame)
    self:CreateHeaderRow(frame)
    self:CreateScrollFrame(frame)
    self:CreateDataRows(frame)

    self.state.frame = frame
end

function LeaderboardViewer:GetConfiguredClassFilter()
    local configured = tostring(self.db.char.classFilter or CLASS_FILTER_AUTO)
    if configured == CLASS_FILTER_AUTO or configured == CLASS_FILTER_ALL then
        return configured
    end
    if CLASS_FILTER_LABELS[configured] then
        return configured
    end
    return CLASS_FILTER_AUTO
end

function LeaderboardViewer:GetMetricClassToken(metricId, service)
    if type(metricId) ~= "string" or metricId == "" then
        return CLASS_FILTER_ALL
    end
    if not service or type(service.GetMetricClassName) ~= "function" then
        return CLASS_FILTER_ALL
    end
    local metricClass = tostring(service:GetMetricClassName(metricId) or CLASS_FILTER_ALL)
    if CLASS_FILTER_LABELS[metricClass] then
        return metricClass
    end
    return CLASS_FILTER_ALL
end

function LeaderboardViewer:IsMetricClassSpecific(metricId, service)
    return self:GetMetricClassToken(metricId, service) ~= CLASS_FILTER_ALL
end

function LeaderboardViewer:IsMetricLocallyTrackable(metricId, service)
    local metricClass = self:GetMetricClassToken(metricId, service)
    if metricClass == CLASS_FILTER_ALL then
        return true
    end
    if type(UnitClass) ~= "function" then
        return false
    end
    local _, playerClass = UnitClass("player")
    return type(playerClass) == "string" and playerClass == metricClass
end

function LeaderboardViewer:GetEffectiveClassFilter(metricId, service)
    local metricClass = self:GetMetricClassToken(metricId, service)
    if metricClass ~= CLASS_FILTER_ALL then
        return metricClass
    end

    local configured = self:GetConfiguredClassFilter()
    if configured ~= CLASS_FILTER_AUTO then
        return configured
    end
    return CLASS_FILTER_ALL
end

function LeaderboardViewer:GetClassDropdownText(metricId, service)
    local configured = self:GetConfiguredClassFilter()
    if configured == CLASS_FILTER_AUTO then
        local effective = self:GetEffectiveClassFilter(metricId, service)
        local effectiveLabel = CLASS_FILTER_LABELS[effective] or tostring(effective)
        return "Auto (" .. effectiveLabel .. ")"
    end
    return CLASS_FILTER_LABELS[configured] or tostring(configured)
end

function LeaderboardViewer:UpdateClassDropdown()
    local dropdown = self.state.classDropdown
    if not dropdown or not UIDropDownMenu_SetText then
        return
    end
    local service = self:GetLeaderboardService()
    local metricId = self.state.selectedMetricId
    UIDropDownMenu_SetText(dropdown, self:GetClassDropdownText(metricId, service))
    local isClassSpecific = self:IsMetricClassSpecific(metricId, service)
    setDropdownEnabledSafe(dropdown, not isClassSpecific)
end

function LeaderboardViewer:CreateClassDropdown(parent)
    if not UIDropDownMenu_Initialize or not UIDropDownMenu_CreateInfo or not UIDropDownMenu_AddButton then
        return
    end

    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("LEFT", self.state.scopeDropdown, "RIGHT", 18, 0)
    label:SetText(L["Class:"] or "Class:")

    local dropdown = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate")
    dropdown:SetPoint("LEFT", label, "RIGHT", -8, 0)
    if UIDropDownMenu_SetWidth then
        UIDropDownMenu_SetWidth(dropdown, 140)
    end

    UIDropDownMenu_Initialize(dropdown, function(_, level)
        if level ~= 1 then
            return
        end
        local metricId = self.state.selectedMetricId
        local service = self:GetLeaderboardService()
        local isClassSpecific = self:IsMetricClassSpecific(metricId, service)
        local configured = self:GetConfiguredClassFilter()
        for i = 1, #CLASS_FILTER_ORDER do
            local classId = CLASS_FILTER_ORDER[i]
            local info = UIDropDownMenu_CreateInfo()
            info.text = CLASS_FILTER_LABELS[classId] or tostring(classId)
            info.checked = (configured == classId)
            info.disabled = isClassSpecific
            info.func = function()
                self.db.char.classFilter = classId
                self:UpdateClassDropdown()
                self:RefreshBoard()
            end
            UIDropDownMenu_AddButton(info, level)
        end
    end)

    self.state.classDropdown = dropdown
    self.state.classDropdownLabel = label
    self:UpdateClassDropdown()
end

--- Create scroll frame and scroll child for the data table.
function LeaderboardViewer:CreateScrollFrame(parent)
    local scrollFrame = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 12, -144)
    scrollFrame:SetPoint("TOPRIGHT", -30, -144)
    scrollFrame:SetHeight(SCROLL_FRAME_HEIGHT)

    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetPoint("TOPLEFT", 0, 0)
    scrollChild:SetWidth(scrollFrame:GetWidth() - 20)
    scrollChild:SetHeight(SCROLL_FRAME_HEIGHT)
    scrollFrame:SetScrollChild(scrollChild)

    self.state.scrollFrame = scrollFrame
    self.state.scrollChild = scrollChild
end

--- Create metric selector dropdown (first row). Lists all metrics including class-specific (e.g. Warlock Shadow Bolt Crit, Paladin Seal Twist, DK Gargoyle).
function LeaderboardViewer:CreateMetricDropdown(parent)
    if not UIDropDownMenu_Initialize or not UIDropDownMenu_CreateInfo or not UIDropDownMenu_AddButton then
        return
    end

    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOPLEFT", 12, TAB_ROW1_Y + 2)
    label:SetText(L["Metric:"] or "Metric:")

    local dropdown = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate")
    dropdown:SetPoint("LEFT", label, "RIGHT", -8, 0)
    if UIDropDownMenu_SetWidth then
        UIDropDownMenu_SetWidth(dropdown, 220)
    end

    UIDropDownMenu_Initialize(dropdown, function(_, level)
        if level ~= 1 then
            return
        end
        local service = self:GetLeaderboardService()
        if not service or not service.GetMetricValuesMap then
            return
        end
        local valuesMap = service:GetMetricValuesMap()
        local ids = {}
        for id in pairs(valuesMap) do
            ids[#ids + 1] = id
        end
        sort(ids)
        local selected = self.state.selectedMetricId
        for _, metricId in ipairs(ids) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = valuesMap[metricId] or metricId
            info.checked = (metricId == selected)
            info.func = function()
                self.state.selectedMetricId = metricId
                self:UpdateMetricDropdown()
                self:UpdateClassDropdown()
                self:RefreshBoard()
            end
            UIDropDownMenu_AddButton(info, level)
        end
    end)

    self.state.metricDropdown = dropdown
    self.state.metricDropdownLabel = label
end

--- Create Local / Merged view mode dropdown (second row).
function LeaderboardViewer:CreateViewModeDropdown(parent)
    if not UIDropDownMenu_Initialize or not UIDropDownMenu_CreateInfo or not UIDropDownMenu_AddButton then
        return
    end

    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOPLEFT", 12, TAB_ROW2_Y + 2)
    label:SetText(L["View:"] or "View:")

    local dropdown = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate")
    dropdown:SetPoint("LEFT", label, "RIGHT", -8, 0)
    if UIDropDownMenu_SetWidth then
        UIDropDownMenu_SetWidth(dropdown, 100)
    end

    UIDropDownMenu_Initialize(dropdown, function(_, level)
        if level ~= 1 then
            return
        end
        local mode = tostring(self.db.char.viewMode or "local")
        local metricId = self.state.selectedMetricId
        local service = self:GetLeaderboardService()
        local canUseLocal = self:IsMetricLocallyTrackable(metricId, service)
        for _, entry in ipairs({ { value = "local", label = L["Local"] or "Local" }, { value = "merged", label = L["Merged"] or "Merged" } }) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = entry.label
            info.checked = (mode == entry.value)
            if entry.value == "local" and not canUseLocal then
                info.text = (L["Local"] or "Local") .. " (N/A)"
                info.disabled = true
            end
            info.func = function()
                self.db.char.viewMode = entry.value
                self:UpdateViewModeDropdown()
                self:RefreshBoard()
            end
            UIDropDownMenu_AddButton(info, level)
        end
    end)

    self.state.viewModeDropdown = dropdown
    self.state.viewModeDropdownLabel = label
end

--- Create scope filter dropdown (second row: All, Local, Guild, Server).
function LeaderboardViewer:CreateScopeDropdown(parent)
    if not UIDropDownMenu_Initialize or not UIDropDownMenu_CreateInfo or not UIDropDownMenu_AddButton then
        return
    end

    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("LEFT", self.state.viewModeDropdown, "RIGHT", 18, 0)
    label:SetText(L["Scope:"] or "Scope:")

    local dropdown = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate")
    dropdown:SetPoint("LEFT", label, "RIGHT", -8, 0)
    if UIDropDownMenu_SetWidth then
        UIDropDownMenu_SetWidth(dropdown, 100)
    end

    UIDropDownMenu_Initialize(dropdown, function(_, level)
        if level ~= 1 then
            return
        end
        local scopeFilter = tostring(self.db.char.scopeFilter or "all"):lower()
        if scopeFilter == "global" then
            scopeFilter = "all"
        end
        for _, scopeId in ipairs({ "all", "local", "guild", "server" }) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = scopeDisplay(scopeId)
            info.checked = (scopeId == scopeFilter)
            info.func = function()
                self.db.char.scopeFilter = scopeId
                self:UpdateScopeDropdown()
                self:RefreshBoard()
            end
            UIDropDownMenu_AddButton(info, level)
        end
    end)

    self.state.scopeDropdown = dropdown
    self.state.scopeDropdownLabel = label
end

--- Create header row for table columns.
function LeaderboardViewer:CreateHeaderRow(parent)
    local xoff = 12
    local headers = {}
    for _, col in ipairs(COLUMNS) do
        local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        fs:SetPoint("TOPLEFT", xoff, HEADER_Y)
        fs:SetText(L[col.text] or col.text)
        col._x = xoff
        headers[#headers + 1] = fs
        xoff = xoff + col.width + 12
    end
    self.state.headerFontStrings = headers
end

--- Create one data row with cells for rank, player, value, spell (icon+text), target, date.
--- @param parent Frame Parent (scroll child)
--- @param rowIndex number 1-based row index (y = -(rowIndex-1)*ROW_HEIGHT from top).
function LeaderboardViewer:MakeRow(parent, rowIndex)
    local y = -(rowIndex - 1) * ROW_HEIGHT
    local scrollX = 0
    if parent == self.state.scrollChild then
        scrollX = 12
    end
    local cells = {}
    for _, col in ipairs(COLUMNS) do
        local x = col._x - scrollX
        if col.key == "spell" then
            local tex = parent:CreateTexture(nil, "ARTWORK")
            tex:SetPoint("TOPLEFT", x, y)
            tex:SetSize(16, 16)
            local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            fs:SetPoint("LEFT", tex, "RIGHT", 4, 1)
            fs:SetJustifyH("LEFT")
            fs:SetWidth(col.width - 24)
            fs:SetText("")
            tex:Hide()
            fs:Hide()
            cells[#cells + 1] = { icon = tex, text = fs }
        elseif col.key == "class" then
            local tex = parent:CreateTexture(nil, "ARTWORK")
            tex:SetPoint("TOPLEFT", x, y)
            tex:SetSize(20, 20)
            tex:Hide()
            cells[#cells + 1] = { icon = tex }
        else
            local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            fs:SetPoint("TOPLEFT", x, y)
            fs:SetJustifyH("LEFT")
            fs:SetWidth(col.width)
            fs:SetText("")
            fs:Hide()
            cells[#cells + 1] = fs
        end
    end
    return cells
end

function LeaderboardViewer:CreateDataRows(parent)
    local scrollChild = self.state.scrollChild or parent
    local rows = {}
    for i = 1, MAX_ROWS do
        rows[i] = self:MakeRow(scrollChild, i)
    end
    self.state.rows = rows
end

-- ============================ REFRESH AND TAB UPDATE ============================

--- Keeps records that match the metric's event type so damage tab never shows heal events and vice versa.
--- @param metricId string
--- @param records table Array of record tables
--- @return table Filtered array (same order, may be shorter)
function LeaderboardViewer:FilterRecordsByMetricType(metricId, records)
    local service = self:GetLeaderboardService()
    if service and type(service.FilterRecordsByMetricType) == "function" then
        return service:FilterRecordsByMetricType(metricId, records)
    end
    local adapter = self:GetViewAdapter()
    if adapter and type(adapter.FilterRecordsByMetricType) == "function" then
        return adapter:FilterRecordsByMetricType(metricId, records, service)
    end
    return records or {}
end

--- Refresh metric dropdown list and selected text from LeaderboardService:GetMetricValuesMap().
function LeaderboardViewer:RefreshMetricDropdown()
    local frame = self.state.frame
    local dropdown = self.state.metricDropdown
    if not frame or not dropdown or not UIDropDownMenu_SetText then
        return
    end

    local service = self:GetLeaderboardService()
    if not service or not service.GetMetricValuesMap then
        if self.state.selectedMetricId == "" then
            self.state.selectedMetricId = nil
        end
        return
    end

    local valuesMap = service:GetMetricValuesMap()
    local ids = {}
    for id in pairs(valuesMap) do
        ids[#ids + 1] = id
    end
    sort(ids)

    if #ids == 0 then
        if self.state.selectedMetricId == "" then
            self.state.selectedMetricId = nil
        end
        return
    end

    if self.state.selectedMetricId == "" or not valuesMap[self.state.selectedMetricId] then
        self.state.selectedMetricId = ids[1]
    end

    self:UpdateMetricDropdown()
end

function LeaderboardViewer:UpdateMetricDropdown()
    local dropdown = self.state.metricDropdown
    if not dropdown or not UIDropDownMenu_SetText then
        return
    end
    local service = self:GetLeaderboardService()
    local metricId = self.state.selectedMetricId
    if not metricId or metricId == "" then
        UIDropDownMenu_SetText(dropdown, L["No metrics registered"] or "No metrics registered")
        return
    end
    local valuesMap = service and service.GetMetricValuesMap and service:GetMetricValuesMap() or {}
    UIDropDownMenu_SetText(dropdown, valuesMap[metricId] or metricId)
end

function LeaderboardViewer:UpdateViewModeDropdown()
    local dropdown = self.state.viewModeDropdown
    if not dropdown or not UIDropDownMenu_SetText then
        return
    end
    local service = self:GetLeaderboardService()
    local metricId = self.state.selectedMetricId
    if not self:IsMetricLocallyTrackable(metricId, service) and tostring(self.db.char.viewMode or "local") == "local" then
        self.db.char.viewMode = "merged"
    end
    local mode = tostring(self.db.char.viewMode or "local")
    local label = (mode == "local") and (L["Local"] or "Local") or (L["Merged"] or "Merged")
    UIDropDownMenu_SetText(dropdown, label)
end

function LeaderboardViewer:UpdateScopeDropdown()
    local dropdown = self.state.scopeDropdown
    if not dropdown or not UIDropDownMenu_SetText then
        return
    end
    local scopeFilter = tostring(self.db.char.scopeFilter or "all"):lower()
    if scopeFilter == "global" then
        scopeFilter = "all"
    end
    UIDropDownMenu_SetText(dropdown, scopeDisplay(scopeFilter))
end

--- Fill one row with record data.
--- Spell and Target columns use record.context: spellName, spellIcon, targetName, targetLevel.
--- Player column appends (level) when record.playerLevel or context.playerLevel is set.
--- Metric providers (e.g. seal twist, crit heal) should set these when submitting so the row shows a label and target instead of "—".
function LeaderboardViewer:FillRow(rowCells, rank, record)
    local rgb = RANK_RGB[rank] or { 1, 1, 1 }
    local r, g, b = rgb[1], rgb[2], rgb[3]
    local ctx = record.context or {}

    -- rank
    rowCells[1]:SetText(rank .. ".")
    rowCells[1]:SetTextColor(r, g, b)
    rowCells[1]:Show()

    -- class icon
    local classIconId = getClassIconIdFromRecord(record)
    if type(rowCells[2]) == "table" and rowCells[2].icon then
        if classIconId then
            rowCells[2].icon:SetTexture(classIconId)
            rowCells[2].icon:Show()
        else
            rowCells[2].icon:SetTexture(nil)
            rowCells[2].icon:Hide()
        end
    end

    -- player
    local playerText = playerDisplayName(record.playerName)
    local recordScope = type(record.scope) == "string" and record.scope:lower() or "local"
    playerText = playerText .. " [" .. scopeBadge(recordScope) .. "]"
    local playerLevel = record.playerLevel or (ctx and ctx.playerLevel)
    if type(playerLevel) == "number" and playerLevel > 0 then
        playerText = playerText .. " (" .. playerLevel .. ")"
    end
    rowCells[3]:SetText(playerText)
    rowCells[3]:SetTextColor(r, g, b)
    rowCells[3]:Show()

    -- value
    rowCells[4]:SetText(formatValue(record.value))
    rowCells[4]:SetTextColor(r, g, b)
    rowCells[4]:Show()

    -- spell (icon + text): resolve from spellId for localized name/icon when available
    local spellName, spellIconResolved = resolveSpellDisplay(ctx)
    local spellDisplayText = (type(spellName) == "table" and spellName.name) or (type(spellName) == "string" and spellName) or "—"
    local iconPath = type(spellIconResolved) == "string" and spellIconResolved or getSpellIconPath(spellIconResolved)
    if type(rowCells[5]) == "table" then
        rowCells[5].icon:SetTexture(iconPath)
        rowCells[5].icon:Show()
        rowCells[5].text:SetText(spellDisplayText)
        rowCells[5].text:SetTextColor(1, 1, 1)
        rowCells[5].text:Show()
    end

    -- target
    local targetStr = ctx.targetName or "—"
    if type(ctx.targetLevel) == "number" and ctx.targetLevel ~= 0 then
        if ctx.targetLevel == -1 then
            targetStr = targetStr .. " (Boss)"
        else
            targetStr = targetStr .. " (lvl " .. ctx.targetLevel .. ")"
        end
    end
    rowCells[6]:SetText(targetStr)
    rowCells[6]:SetTextColor(r, g, b)
    rowCells[6]:Show()

    -- realm
    local realmStr = extractRealmFromRecord(record)
    rowCells[7]:SetText(type(realmStr) == "string" and realmStr ~= "" and realmStr or "—")
    rowCells[7]:SetTextColor(r, g, b)
    rowCells[7]:Show()

    -- guild
    rowCells[8]:SetText(extractGuildFromRecord(record, ctx))
    rowCells[8]:SetTextColor(r, g, b)
    rowCells[8]:Show()

    -- date
    rowCells[9]:SetText(formatTimestamp(record.timestamp))
    rowCells[9]:SetTextColor(r, g, b)
    rowCells[9]:Show()
end

--- Clear one row (show rank index only or blank).
function LeaderboardViewer:ClearRow(rowCells, rank)
    if not rowCells then
        return
    end
    rowCells[1]:SetText(rank .. ".")
    rowCells[1]:SetTextColor(1, 1, 1)
    rowCells[1]:Show()
    for i = 2, #COLUMNS do
        local c = rowCells[i]
        if c and c.icon and c.text then
            c.icon:SetTexture(nil)
            c.icon:Hide()
            c.text:SetText("")
            c.text:Hide()
        elseif c and c.icon then
            c.icon:SetTexture(nil)
            c.icon:Hide()
        elseif c and c.SetText then
            c:SetText("")
            c:SetTextColor(1, 1, 1)
            c:Hide()
        end
    end
end

--- Refresh the table from LeaderboardService.
function LeaderboardViewer:RefreshBoard()
    local frame = self.state.frame
    if not frame then
        return
    end

    local service = self:GetLeaderboardService()
    if not service then
        for i = 1, MAX_ROWS do
            self:ClearRow(self.state.rows[i], i)
        end
        if self.state.scrollChild then
            self.state.scrollChild:SetHeight(SCROLL_FRAME_HEIGHT)
        end
        return
    end

    self:RefreshMetricDropdown()
    self:UpdateViewModeDropdown()
    self:UpdateScopeDropdown()
    self:UpdateClassDropdown()

    local metricId = self.state.selectedMetricId
    if not metricId or metricId == "" then
        for i = 1, MAX_ROWS do
            self:ClearRow(self.state.rows[i], i)
        end
        if self.state.scrollChild then
            self.state.scrollChild:SetHeight(SCROLL_FRAME_HEIGHT)
        end
        return
    end

    local viewMode = self.db.char.viewMode or "local"
    local scopeFilter = tostring(self.db.char.scopeFilter or "all"):lower()
    if scopeFilter == "global" then
        scopeFilter = "all"
    end
    local classFilter = self:GetEffectiveClassFilter(metricId, service)
    local limit = MAX_ROWS
    local records = {}
    local adapter = self:GetViewAdapter()
    if service and type(service.GetDisplayRows) == "function" then
        records = service:GetDisplayRows(metricId, viewMode, scopeFilter, classFilter, limit, getCurrentPlayerIdentity()) or {}
    elseif adapter and type(adapter.GetRows) == "function" then
        records = adapter:GetRows(metricId, viewMode, scopeFilter, classFilter, limit, getCurrentPlayerIdentity()) or {}
    elseif viewMode == "merged" and service.GetCombinedTopX then
        records = service:GetCombinedTopX(metricId, limit, scopeFilter, classFilter) or {}
        records = self:FilterRecordsByMetricType(metricId, records)
    else
        records = service:GetTop(metricId, limit, false, scopeFilter, classFilter) or {}
        records = self:FilterRecordsByMetricType(metricId, records)
    end

    local numRecords = #records
    for i = 1, MAX_ROWS do
        if i <= numRecords then
            self:FillRow(self.state.rows[i], i, records[i])
        else
            self:ClearRow(self.state.rows[i], i)
        end
    end

    local scrollChild = self.state.scrollChild
    local scrollFrame = self.state.scrollFrame
    if scrollChild and scrollFrame then
        local contentHeight = (numRecords > VISIBLE_ROWS) and (numRecords * ROW_HEIGHT) or SCROLL_FRAME_HEIGHT
        scrollChild:SetHeight(contentHeight)
        scrollFrame:SetVerticalScroll(0)
    end
end

-- ============================ SHOW / HIDE / TOGGLE ============================

function LeaderboardViewer:ShowFrame()
    self:CreateFrame()
    if self.state.frame then
        self.state.frame:Show()
        self.state.isShown = true
        self:RefreshBoard()
    end
end

function LeaderboardViewer:HideFrame()
    if self.state.frame then
        self.state.frame:Hide()
        self.state.isShown = false
    end
end

function LeaderboardViewer:ToggleFrame()
    if self.state.isShown then
        self:HideFrame()
    else
        self:ShowFrame()
    end
end

-- ============================ SLASH COMMAND ============================

--- Handle /nag leaderboard [toggle|show|hide|reset|help].
--- @param input string Raw slash command input.
function LeaderboardViewer:HandleLeaderboardSlash(input)
    local command = strlower(strtrim(tostring(input or "")))
    if command == "help" then
        NAG:Print(L["Leaderboard Commands:"] or "Leaderboard Commands:")
        NAG:Print(L["  /nag leaderboard                    -- Toggle leaderboard window"] or "  /nag leaderboard                    -- Toggle leaderboard window")
        NAG:Print(L["  /nag leaderboard show               -- Show leaderboard window"] or "  /nag leaderboard show               -- Show leaderboard window")
        NAG:Print(L["  /nag leaderboard hide               -- Hide leaderboard window"] or "  /nag leaderboard hide               -- Hide leaderboard window")
        NAG:Print(L["  /nag leaderboard reset              -- Reset leaderboard data only"] or "  /nag leaderboard reset              -- Reset leaderboard data only")
        return
    end

    if command == "show" then
        self:ShowFrame()
        return
    end
    if command == "hide" then
        self:HideFrame()
        return
    end
    if command == "reset" then
        local service = self:GetLeaderboardService()
        if not service or not service.ResetLeaderboardData then
            NAG:Print("|cffff0000[NAG] " .. (L["Leaderboard reset unavailable"] or "Leaderboard reset unavailable") .. "|r")
            return
        end
        local ok, err = service:ResetLeaderboardData()
        if not ok then
            NAG:Print("|cffff0000[NAG] " .. (string.format(L["Leaderboard reset failed: %s"] or "Leaderboard reset failed: %s", tostring(err))) .. "|r")
            return
        end
        if self.state.isShown then
            self:RefreshBoard()
        end
        NAG:Print("|cff00ff00[NAG] " .. (L["Leaderboard data reset complete"] or "Leaderboard data reset complete") .. "|r")
        return
    end

    self:ToggleFrame()
end

-- ============================ MESSAGE HANDLERS ============================

--- Refresh table when a local record is added, if viewer is open and metric matches.
--- @param message string
--- @param addedMetricId string
function LeaderboardViewer:OnLocalRecordAdded(message, addedMetricId)
    if not self.state.isShown or not self.state.frame or not self.state.frame:IsShown() then
        return
    end
    if addedMetricId == self.state.selectedMetricId then
        self:RefreshBoard()
    end
end

--- Refresh table when sync merges peer data, so the viewer updates without reopening (e.g. Rogue sees DK Gargoyle data after TOPX_CHUNK).
--- @param message string
--- @param mergedMetricId string|nil Metric that was merged, or nil for any.
function LeaderboardViewer:OnSyncMerged(message, mergedMetricId)
    if not self.state.isShown or not self.state.frame or not self.state.frame:IsShown() then
        return
    end
    if not mergedMetricId or mergedMetricId == "" or mergedMetricId == self.state.selectedMetricId then
        self:RefreshBoard()
    end
end

-- ============================ OPTIONS ============================

function LeaderboardViewer:GetOptions()
    local scopeValues = {
        all = L["All"] or "All",
        ["local"] = L["Local"] or "Local",
        guild = L["Guild"] or "Guild",
        server = L["Server"] or "Server",
    }

    local classValues = {}
    for i = 1, #CLASS_FILTER_ORDER do
        local classId = CLASS_FILTER_ORDER[i]
        classValues[classId] = CLASS_FILTER_LABELS[classId] or tostring(classId)
    end

    return {
        type = "group",
        name = L["Leaderboard Viewer"] or "Leaderboard Viewer",
        order = 62,
        args = {
            openViewer = {
                type = "execute",
                name = L["Open Leaderboard Viewer"] or "Open Leaderboard Viewer",
                order = 1,
                func = function()
                    self:ShowFrame()
                end,
            },
            closeViewer = {
                type = "execute",
                name = L["Hide Leaderboard Viewer"] or "Hide Leaderboard Viewer",
                order = 2,
                func = function()
                    self:HideFrame()
                end,
            },
            viewMode = {
                type = "select",
                name = L["Default View"] or "Default View",
                order = 10,
                values = function()
                    local service = self:GetLeaderboardService()
                    local canUseLocal = self:IsMetricLocallyTrackable(self.state.selectedMetricId, service)
                    return {
                        local_mode = canUseLocal and (L["Local"] or "Local") or ((L["Local"] or "Local") .. " (N/A)"),
                        merged = L["Merged"] or "Merged",
                    }
                end,
                get = function()
                    local mode = tostring(self:GetSetting("char", "viewMode", "local"))
                    if mode == "local" then
                        return "local_mode"
                    end
                    return "merged"
                end,
                set = function(_, value)
                    local requestedMode = (value == "local_mode") and "local" or "merged"
                    local mode = requestedMode
                    if requestedMode == "local" then
                        local service = self:GetLeaderboardService()
                        if not self:IsMetricLocallyTrackable(self.state.selectedMetricId, service) then
                            mode = "merged"
                        end
                    end
                    self:SetSetting("char", "viewMode", mode)
                    if self.state.isShown then
                        self:RefreshBoard()
                    end
                end,
            },
            scopeFilter = {
                type = "select",
                name = L["Default Scope Filter"] or "Default Scope Filter",
                order = 11,
                values = scopeValues,
                get = function()
                    local currentScope = tostring(self:GetSetting("char", "scopeFilter", "all")):lower()
                    return scopeValues[currentScope] and currentScope or "all"
                end,
                set = function(_, value)
                    local normalizedScope = tostring(value or "all"):lower()
                    if not scopeValues[normalizedScope] then
                        normalizedScope = "all"
                    end
                    self:SetSetting("char", "scopeFilter", normalizedScope)
                    if self.state.isShown then
                        self:RefreshBoard()
                    end
                end,
            },
            classFilter = {
                type = "select",
                name = L["Default Class Filter"] or "Default Class Filter",
                order = 12,
                disabled = function()
                    local service = self:GetLeaderboardService()
                    return self:IsMetricClassSpecific(self.state.selectedMetricId, service)
                end,
                values = classValues,
                get = function()
                    return self:GetConfiguredClassFilter()
                end,
                set = function(_, value)
                    local classId = tostring(value or CLASS_FILTER_AUTO)
                    if not classValues[classId] then
                        classId = CLASS_FILTER_AUTO
                    end
                    self:SetSetting("char", "classFilter", classId)
                    if self.state.isShown then
                        self:UpdateClassDropdown()
                        self:RefreshBoard()
                    end
                end,
            },
            frameWidth = {
                type = "range",
                name = L["Frame Width"] or "Frame Width",
                order = 20,
                min = 700,
                max = 1400,
                step = 10,
                get = function()
                    return tonumber(self:GetSetting("global", "frameWidth", defaults.global.frameWidth)) or
                        defaults.global.frameWidth
                end,
                set = function(_, value)
                    local width = tonumber(value) or defaults.global.frameWidth
                    self:SetSetting("global", "frameWidth", width)
                    if self.state.frame then
                        local currentHeight = self.state.frame:GetHeight()
                        self.state.frame:SetSize(width, currentHeight)
                    end
                end,
            },
            frameHeight = {
                type = "range",
                name = L["Frame Height"] or "Frame Height",
                order = 21,
                min = MIN_FRAME_HEIGHT,
                max = 900,
                step = 10,
                get = function()
                    return tonumber(self:GetSetting("global", "frameHeight", defaults.global.frameHeight)) or
                        defaults.global.frameHeight
                end,
                set = function(_, value)
                    local height = tonumber(value) or defaults.global.frameHeight
                    if height < MIN_FRAME_HEIGHT then
                        height = MIN_FRAME_HEIGHT
                    end
                    self:SetSetting("global", "frameHeight", height)
                    if self.state.frame then
                        local currentWidth = self.state.frame:GetWidth()
                        self.state.frame:SetSize(currentWidth, height)
                    end
                end,
            },
            resetLeaderboard = {
                type = "execute",
                name = L["Reset Leaderboard Data"] or "Reset Leaderboard Data",
                order = 30,
                confirm = true,
                confirmText = L["Reset leaderboard data for this character?"] or "Reset leaderboard data for this character?",
                func = function()
                    local service = self:GetLeaderboardService()
                    if not service or not service.ResetLeaderboardData then
                        self:Warn(L["Leaderboard reset unavailable"] or "Leaderboard reset unavailable")
                        return
                    end
                    local ok, err = service:ResetLeaderboardData()
                    if not ok then
                        self:Warn(L["Leaderboard reset failed: %s"] or "Leaderboard reset failed: %s", tostring(err))
                        return
                    end
                    if self.state.isShown then
                        self:RefreshBoard()
                    end
                    self:Info(L["Leaderboard data reset complete"] or "Leaderboard data reset complete")
                end,
            },
        },
    }
end

-- ============================ LIFECYCLE ============================

function LeaderboardViewer:ModuleEnable()
    -- Frame is created on first show
end

function LeaderboardViewer:ModuleDisable()
    self:HideFrame()
end

return LeaderboardViewer
