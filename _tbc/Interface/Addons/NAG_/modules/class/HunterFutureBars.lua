--- @module "NAG.HunterFutureBars"
--- Minimal two-spark overlay UI for HunterFutureTimeline timings (TBC Hunter).
---
--- This intentionally does not reuse legacy Hunter bar logic.
--- It consumes `HunterFutureTimeline:GetNextTiming()` and renders two overlapping transparent bars:
--- - SS spark (or Auto Shot prompt when Auto is off)
--- - Filler spark (MS > AR), gated to not clip Auto Shot
---
--- License: CC BY-NC 4.0

-- ============================ LOCALIZE ============================

local _, ns = ...

-- ============================ ADDON ACCESS ============================

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ MODULE ACCESS ============================

-- ============================ LIBRARY ACCESS ============================

local Version = ns.Version
local WoWAPI = ns.WoWAPI

-- ============================ LUA API LOCALIZATION ============================

local max = math.max
local min = math.min
local format = string.format

-- ============================ WOW API LOCALIZATION ============================

local GetTime = _G.GetTime
local CreateFrame = _G.CreateFrame
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitClassBase = _G.UnitClassBase

-- ============================ DEFAULTS (SETTINGS ONLY) ============================

local defaults = {
    char = {
        enabled = true,
        position = {
            point = "CENTER",
            relativePoint = "CENTER",
            x = 0,
            y = -140,
        },
        locked = false,
    },
    class = {
        hideOutOfCombat = false,
        showKeybindOnBar = false,
        scale = 1.0,
        width = 338,
        height = 26,
        alpha = 1.0,
        timeWindowSeconds = 3.0,
        updateIntervalSeconds = 0.05,
        -- Debug-only per-spark countdown labels.
        showDetailedTimes = false,

        -- Prints (throttled)
        debugPrintIntervalSeconds = 0.50,
    }
}

-- ============================ MODULE CREATION ============================

--- @class HunterFutureBars:CoreModule
local HunterFutureBars = NAG:CreateModule("HunterFutureBars", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "HUNTER",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    hidden = function()
        return not (Version and Version:IsTBC()) or UnitClassBase("player") ~= "HUNTER"
    end,
    messageHandlers = {
        NAG_HUNTER_BAR_SCALE_UPDATED = true,
    },
    eventHandlers = {
        PLAYER_REGEN_DISABLED = true,
        PLAYER_REGEN_ENABLED = true,
        PLAYER_ENTERING_WORLD = true,
    }
})

ns.HunterFutureBars = HunterFutureBars

-- ============================ MODULE VARIABLES ============================

local OptionsFactory
local TimerManager
local Prediction

HunterFutureBars.frame = nil
HunterFutureBars.ssBar = nil
HunterFutureBars.fillerBar = nil
HunterFutureBars._lastDebugPrintAt = 0

-- ============================ PRIVATE UI HELPERS ============================

local function Clamp(v, lo, hi)
    return max(lo, min(hi, v))
end

local function GetHunterBarScale()
    local hm = NAG:GetModule("HunterWeaveModule", true)
    return (hm and hm.GetHunterBarScale and hm:GetHunterBarScale()) or 1
end

local function GetSpellNameAndIcon(spellId)
    if not spellId then
        return nil, nil
    end

    -- Prefer unified registry first.
    if WoWAPI and WoWAPI.GetSpellInfo then
        local infoOrName, _, icon = WoWAPI.GetSpellInfo(spellId)
        if type(infoOrName) == "table" then
            local info = infoOrName
            return info.name, info.originalIconID or info.iconID or icon
        end
        if infoOrName or icon then
            return infoOrName, icon
        end
    end

    -- Fallback to APICompat unified helper if present.
    if ns.GetSpellInfoUnified then
        local info = ns.GetSpellInfoUnified(spellId)
        if info then
            return info.name, info.originalIconID
        end
    end

    return nil, nil
end

local function ApplyFont(fs)
    if not fs then
        return
    end
    -- Keep minimal: use default font object if available.
    fs:SetFontObject("GameFontHighlightSmall")
end

local function CreateSparkBar(parent, width, height, yOffset)
    local bar = CreateFrame("StatusBar", nil, parent)
    bar:SetSize(width, height)
    bar:SetMinMaxValues(0, 1)
    bar:SetValue(0)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar:SetStatusBarColor(0.20, 0.80, 1.00, 0.75)

    -- Transparent background: keep frame clickable/positionable but visually minimal.
    bar.bg = bar:CreateTexture(nil, "BACKGROUND")
    bar.bg:SetAllPoints()
    bar.bg:SetColorTexture(0, 0, 0, 0.35)

    -- Moving spark: uses the action's icon.
    bar.spark = bar:CreateTexture(nil, "ARTWORK")
    bar.spark:SetSize(height, height)
    bar.spark:SetTexture(nil)
    bar.spark:Hide()

    bar.sparkYOffset = yOffset or 0
    bar.sparkX = 0
    bar.spark:SetPoint("LEFT", bar, "LEFT", 0, bar.sparkYOffset)

    -- Optional debug text (off by default via option).
    bar.debugText = bar:CreateFontString(nil, "OVERLAY")
    ApplyFont(bar.debugText)
    bar.debugText:SetPoint("CENTER", bar, "CENTER", 0, bar.sparkYOffset)
    bar.debugText:SetJustifyH("CENTER")
    bar.debugText:SetText("")
    bar.debugText:Hide()

    -- Keybind text above bar (when showKeybindOnBar is on).
    bar.keybindText = bar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    bar.keybindText:SetPoint("BOTTOM", bar, "TOP", 0, 2)
    bar.keybindText:SetJustifyH("CENTER")
    bar.keybindText:SetTextColor(1, 1, 0)
    bar.keybindText:SetText("")
    bar.keybindText:Hide()

    return bar
end

local function SetSparkKeybind(bar, showKeybind)
    if not bar or not bar.keybindText then
        return
    end
    if showKeybind and bar.spellId then
        local KeybindManager = NAG:GetModule("KeybindManager", true)
        local kb = ""
        if KeybindManager and KeybindManager.GetSpellKeybind then
            kb = KeybindManager:GetSpellKeybind(bar.spellId) or ""
        end
        bar.keybindText:SetText(kb)
        if kb and kb ~= "" then
            bar.keybindText:Show()
        else
            bar.keybindText:Hide()
        end
    else
        bar.keybindText:SetText("")
        bar.keybindText:Hide()
    end
end

-- ============================ FRAME CREATION ============================

function HunterFutureBars:CreateFrameUI()
    if self.frame then
        return self.frame
    end

    local pos = self.db.char.position or {}
    local width = self.db.class.width or 260
    local height = self.db.class.height or 26
    local scale = GetHunterBarScale()
    local alpha = self.db.class.alpha or 1.0

    local frame = CreateFrame("Frame", "NAGHunterFutureBarsFrame", UIParent)
    frame:SetScale(scale)
    frame:SetAlpha(alpha)
    frame:SetPoint(pos.point or "CENTER", UIParent, pos.relativePoint or "CENTER", pos.x or 0, pos.y or 0)
    frame:SetSize(width, height)

    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")

    local module = self
    frame:SetScript("OnDragStart", function()
        if module.db.char.locked then
            return
        end
        frame:StartMoving()
    end)
    frame:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
        local point, _, relativePoint, x, y = frame:GetPoint()
        module.db.char.position = {
            point = point,
            relativePoint = relativePoint,
            x = x,
            y = y,
        }
    end)

    -- Two overlapping transparent bars (same position/size).
    local ssBar = CreateSparkBar(frame, width, height, 2)
    ssBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    local fillerBar = CreateSparkBar(frame, width, height, -2)
    fillerBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    fillerBar:Hide()

    self.frame = frame
    self.ssBar = ssBar
    self.fillerBar = fillerBar

    return frame
end

function HunterFutureBars:ApplyFrameSettings()
    if not self.frame then
        return
    end

    local width = self.db.class.width or 260
    local height = self.db.class.height or 26
    local scale = GetHunterBarScale()
    local alpha = self.db.class.alpha or 1.0

    self.frame:SetScale(scale)
    self.frame:SetAlpha(alpha)
    self.frame:SetSize(width, height)

    if self.ssBar then
        self.ssBar:SetSize(width, height)
        self.ssBar.spark:SetSize(height, height)
        self.ssBar:ClearAllPoints()
        self.ssBar:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
    end
    if self.fillerBar then
        self.fillerBar:SetSize(width, height)
        self.fillerBar.spark:SetSize(height, height)
        self.fillerBar:ClearAllPoints()
        self.fillerBar:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 0, 0)
    end
end

-- ============================ DISPLAY UPDATE ============================

function HunterFutureBars:UpdateVisibility()
    if not self.frame then
        return
    end

    -- In edit mode: force visible for positioning - check FIRST so bars stay visible when unlocked
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        self.frame:Show()
        return
    end

    if not self.db.char.enabled then
        self.frame:Hide()
        return
    end

    if self.db.class.hideOutOfCombat and (not UnitAffectingCombat("player")) then
        self.frame:Hide()
        return
    end

    self.frame:Show()
end

function HunterFutureBars:NAG_HUNTER_BAR_SCALE_UPDATED()
    self:ApplyFrameSettings()
end

function HunterFutureBars:UpdateDisplay()
    if not self.frame or not self.ssBar or not self.fillerBar then
        return
    end

    self:UpdateVisibility()
    if not self.frame:IsShown() then
        return
    end

    if not Prediction or not Prediction.GetNextTiming then
        return
    end

    local now = GetTime()
    local timeWindow = self.db.class.timeWindowSeconds or 3.0

    local timing = Prediction:GetNextTiming()
    if not timing or not timing.ss then
        SetSparkKeybind(self.ssBar, false)
        SetSparkKeybind(self.fillerBar, false)
        self.ssBar.spark:Hide()
        self.fillerBar.spark:Hide()
        self.ssBar.debugText:Hide()
        self.fillerBar.debugText:Hide()
        return
    end

    local ss = timing and timing.ss or nil
    if not ss then
        SetSparkKeybind(self.ssBar, false)
        self.ssBar:SetMinMaxValues(0, 1)
        self.ssBar:SetValue(0)
        self.ssBar.spark:Hide()
        self.ssBar.debugText:Hide()
        return
    end

    -- Use coupled predictor anchor from timeline (includes filler-first delay when applicable).
    local gapAt = timing.ssGapAt or ss.displayPressAt or now

    local remaining = max(0, (gapAt or now) - now)
    local _, icon = GetSpellNameAndIcon(ss.spellId)
    self.ssBar.spellId = ss.spellId
    SetSparkKeybind(self.ssBar, self.db.class.showKeybindOnBar)
    self.ssBar.spark:SetTexture(icon)
    self.ssBar.spark:Show()

    local w = (self.db.class.width or 260)
    local h = (self.db.class.height or 26)
    local usableWidth = max(1, w - h)
    local frac = Clamp(remaining / timeWindow, 0, 1)
    local x = usableWidth * frac
    self.ssBar.spark:ClearAllPoints()
    self.ssBar.spark:SetPoint("LEFT", self.ssBar, "LEFT", x, self.ssBar.sparkYOffset or 0)

    -- Core request: a bar that counts down to the next SS castable gap.
    self.ssBar:SetMinMaxValues(0, timeWindow)
    self.ssBar:SetValue(Clamp(remaining, 0, timeWindow))

    if self.db.class.showDetailedTimes then
        self.ssBar.debugText:SetText(format("SS gap %.2f", remaining))
        self.ssBar.debugText:Show()
    else
        self.ssBar.debugText:Hide()
    end

    local interval = self.db.class.debugPrintIntervalSeconds or 0.50
    if interval > 0 and (now - (self._lastDebugPrintAt or 0)) >= interval then
        self._lastDebugPrintAt = now
        print(format(
            "NAG SS_GAP | remaining=%.2f gapAt=%.2f autoOn=%s",
            tonumber(remaining) or -1,
            tonumber(gapAt) or -1,
            (timing and timing.autoShotOn) and "1" or "0"
        ))
    end
end

-- ============================ OPTIONS ============================

function HunterFutureBars:GetOptions()
    return {
        type = "group",
        name = "Hunter Future Bars",
        desc = "Two overlapping transparent spark bars for SS and filler timing.",
        order = 80,
        args = {
            enabled = OptionsFactory:CreateToggle(
                "Enabled",
                "Enable/disable the Hunter future bars UI.",
                function() return self:GetSetting("char", "enabled", true) end,
                function(_, value)
                    self:SetSetting("char", "enabled", value)
                    if value then
                        self:Enable()
                    else
                        self:Disable()
                    end
                end,
                { order = 1 }
            ),
            locked = OptionsFactory:CreateToggle(
                "Lock",
                "Lock/unlock the frame for dragging.",
                function() return self:GetSetting("char", "locked", false) end,
                function(_, value) self:SetSetting("char", "locked", value) end,
                { order = 2 }
            ),
            hideOutOfCombat = OptionsFactory:CreateToggle(
                "Hide out of combat",
                "Hide the bars when out of combat.",
                function() return self:GetSetting("class", "hideOutOfCombat", false) end,
                function(_, value)
                    self:SetSetting("class", "hideOutOfCombat", value)
                    self:UpdateVisibility()
                end,
                { order = 3 }
            ),
            showKeybindOnBar = OptionsFactory:CreateToggle(
                "Show Keybind Above Bar Icons",
                "Display the keybind above the icons on the bar.",
                function() return self:GetSetting("class", "showKeybindOnBar", false) end,
                function(_, value)
                    self:SetSetting("class", "showKeybindOnBar", value)
                    if self.frame then self:UpdateDisplay() end
                end,
                { order = 4 }
            ),
            showDetailedTimes = OptionsFactory:CreateToggle(
                "Show debug countdown labels",
                "Show remaining seconds on each spark (debug only).",
                function() return self:GetSetting("class", "showDetailedTimes", false) end,
                function(_, value) self:SetSetting("class", "showDetailedTimes", value) end,
                { order = 5 }
            ),
            debugPrintIntervalSeconds = OptionsFactory:CreateRange(
                "Print interval",
                "Seconds between timing prints to chat. Set higher to reduce spam.",
                function() return self:GetSetting("class", "debugPrintIntervalSeconds", 0.50) end,
                function(_, value) self:SetSetting("class", "debugPrintIntervalSeconds", value) end,
                { min = 0.10, max = 2.0, step = 0.05, order = 6 }
            ),
            debugPrediction = OptionsFactory:CreateToggle(
                "Prediction debug",
                "Print compact timing debug lines from HunterFutureTimeline.",
                function()
                    local Timeline = NAG:GetModule("HunterFutureTimeline", true)
                    return Timeline and Timeline.db and Timeline.db.class.debugPrediction or false
                end,
                function(_, value)
                    local Timeline = NAG:GetModule("HunterFutureTimeline", true)
                    if Timeline and Timeline.db then
                        Timeline.db.class.debugPrediction = value
                    end
                end,
                { order = 7 }
            ),
            width = OptionsFactory:CreateRange(
                "Width",
                "Width of each bar.",
                function() return self:GetSetting("class", "width", 338) end,
                function(_, value)
                    self:SetSetting("class", "width", value)
                    self:ApplyFrameSettings()
                end,
                { min = 140, max = 500, step = 1, order = 11 }
            ),
            height = OptionsFactory:CreateRange(
                "Height",
                "Height of each bar (also icon size).",
                function() return self:GetSetting("class", "height", 26) end,
                function(_, value)
                    self:SetSetting("class", "height", value)
                    self:ApplyFrameSettings()
                end,
                { min = 16, max = 64, step = 1, order = 12 }
            ),
            timeWindowSeconds = OptionsFactory:CreateRange(
                "Time window",
                "Seconds shown on each bar (bar fills as action time approaches).",
                function() return self:GetSetting("class", "timeWindowSeconds", 3.0) end,
                function(_, value) self:SetSetting("class", "timeWindowSeconds", value) end,
                { min = 0.5, max = 8.0, step = 0.1, order = 13 }
            ),
            resetPosition = OptionsFactory:CreateExecute(
                "Reset position",
                "Reset the frame position to default.",
                function()
                    self.db.char.position = {
                        point = "CENTER",
                        relativePoint = "CENTER",
                        x = 0,
                        y = -140,
                    }
                    if self.frame then
                        self.frame:ClearAllPoints()
                        self.frame:SetPoint("CENTER", UIParent, "CENTER", 0, -140)
                    end
                end,
                { order = 30 }
            ),
        }
    }
end

-- ============================ EVENTS ============================

function HunterFutureBars:PLAYER_REGEN_DISABLED()
    self:UpdateVisibility()
end

function HunterFutureBars:PLAYER_REGEN_ENABLED()
    self:UpdateVisibility()
end

function HunterFutureBars:PLAYER_ENTERING_WORLD()
    self:UpdateVisibility()
end

-- ============================ UPDATE MANAGEMENT ============================

function HunterFutureBars:StartUpdates()
    if not TimerManager then
        return
    end
    TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "HunterFutureBarsUpdate")
    TimerManager:Create(
        TimerManager.Categories.UI_NOTIFICATION,
        "HunterFutureBarsUpdate",
        function() self:UpdateDisplay() end,
        self.db.class.updateIntervalSeconds or 0.05,
        true
    )
end

function HunterFutureBars:StopUpdates()
    if not TimerManager then
        return
    end
    TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "HunterFutureBarsUpdate")
end

-- ============================ LIFECYCLE ============================

function HunterFutureBars:ModuleInitialize()
    OptionsFactory = NAG:GetModule("OptionsFactory")
    TimerManager = ns.TimerManager or NAG:GetModule("TimerManager", true)
    Prediction = NAG:GetModule("HunterFutureTimeline", true) or ns.HunterFutureTimeline

    if not self._revPrinted then
        self._revPrinted = true
        print("NAG HunterFutureBars.lua REV=2026-02-11-TWO_SPARK_TIMING_UI path=NAG/modules/class/HunterFutureBars.lua")
    end

    if not (Version and Version:IsTBC()) or UnitClassBase("player") ~= "HUNTER" then
        self:SetEnabledState(false)
        return
    end
end

function HunterFutureBars:ModuleEnable()
    if not self.db.char.enabled then
        return
    end

    self:CreateFrameUI()
    self:ApplyFrameSettings()
    self:UpdateVisibility()
    self:StartUpdates()
    self:UpdateDisplay()
end

function HunterFutureBars:ModuleDisable()
    self:StopUpdates()
    if self.frame then
        self.frame:Hide()
    end
end

