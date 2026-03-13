--- @module "NAG.HunterDebugBarsTBC"
--- Debug bars for TBC Hunter rotation timing
---
--- Provides three separate debug bars:
--- - Auto Shot Timer Bar: Shows time to next auto shot and weapon speed
--- - Melee Weapon Timer Bar: Shows time to next melee swing and weapon speed
--- - Cast Bar: Shows current cast progress with overlay text comparing to autoshot cast time
---
--- License: CC BY-NC 4.0

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local GetTime = _G.GetTime
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitClassBase = _G.UnitClassBase
local UnitLevel = _G.UnitLevel
local CreateFrame = _G.CreateFrame
local UnitCastingInfo = _G.UnitCastingInfo

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local Version = ns.Version
local AceConfigRegistry = ns.AceConfigRegistry

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
--- @type OptionsFactory
local OptionsFactory
--- @type SpecCompat
local SpecCompat

local L = LibStub("AceLocale-3.0"):GetLocale("NAG")

-- LibClassicSwingTimerAPI for swing timing
local swingTimerLib = LibStub("LibClassicSwingTimerAPI", true)
local WoWAPI = ns.WoWAPI
local math_max = math.max

-- Default settings
local defaults = {
    class = {
        enabled = true,
        showAutoShotBar = true,
        showMeleeBar = true,
        showCastBar = true,
        hideOutOfCombat = false,

        autoShotBar = {
            width = 200,
            height = 30,
            alpha = 1.0,
            point = "CENTER",
            x = -250,
            y = 100,
            showBorder = true,
            borderColor = { r = 1, g = 1, b = 1, a = 1 },
            borderThickness = 1,
            colors = {
                background = { r = 0, g = 0, b = 0, a = 0.5 },
                bar = { r = 0.2, g = 0.8, b = 1.0, a = 0.9 },
            },
        },

        meleeBar = {
            width = 200,
            height = 30,
            alpha = 1.0,
            point = "CENTER",
            x = -250,
            y = 60,
            showBorder = true,
            borderColor = { r = 1, g = 1, b = 1, a = 1 },
            borderThickness = 1,
            colors = {
                background = { r = 0, g = 0, b = 0, a = 0.5 },
                bar = { r = 1.0, g = 0.5, b = 0.2, a = 0.9 },
            },
        },

        castBar = {
            width = 200,
            height = 30,
            alpha = 1.0,
            point = "CENTER",
            x = -250,
            y = 20,
            showBorder = true,
            borderColor = { r = 1, g = 1, b = 1, a = 1 },
            borderThickness = 1,
            colors = {
                background = { r = 0, g = 0, b = 0, a = 0.5 },
                bar = { r = 0.8, g = 0.8, b = 0.2, a = 0.9 },
            },
        },
    }
}

--- @class HunterDebugBarsTBC:CoreModule
local HunterDebugBarsTBC = NAG:CreateModule("HunterDebugBarsTBC", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "HUNTER",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    hidden = function() return UnitClassBase("player") ~= "HUNTER" end,
    messageHandlers = {
        NAG_SPEC_UPDATED = true,
        NAG_FRAME_UPDATED = true,
    },
    eventHandlers = {
        UNIT_SPELLCAST_START = true,
        UNIT_SPELLCAST_STOP = true,
        UNIT_SPELLCAST_INTERRUPTED = true,
        UNIT_SPELLCAST_SUCCEEDED = true,
    },
})

-- Local state
local frames = {}
local isDragging = {}
local isPositioning = false
local lastUpdate = 0
local UPDATE_INTERVAL = 0.016 -- ~60fps

-- Cast time tracking
local currentCastSpellId = nil
local currentCastStartTime = nil
local currentCastEndTime = nil
local currentCastTotalTime = nil
local currentCastName = nil

-- Steady Shot cast timing debug (TBC BM focus)
local STEADY_SHOT_ID = 34120 -- Steady Shot
local lastSteadyCastStartTime = nil
local lastSteadyCastDurationSeconds = nil
local lastSteadyPredictedSeconds = nil
local lastSteadyPredictedSource = nil

local function IsHunterBM()
    if UnitClassBase("player") ~= "HUNTER" then return false end
    if not Version:IsTBC() then return false end
    if (UnitLevel("player") or 0) < 10 then return false end
    if not SpecCompat then return false end
    local specStatus = SpecCompat:GetSpecializationStatus()
    return specStatus and specStatus.available and specStatus.specIndex == 1
end

-- ============================ FRAME CREATION ============================

--- Create a debug bar frame with common structure
--- @param name string Frame name
--- @param settings table Bar settings from database
--- @param barKey string Key for frame storage ('autoShot', 'melee', 'cast')
local function CreateDebugBarFrame(self, name, settings, barKey)
    local frame = CreateFrame("Frame", name, UIParent)
    frame:SetSize(settings.width, settings.height)
    frame:SetPoint(settings.point, settings.x, settings.y)
    frame:SetAlpha(settings.alpha)

    -- Background
    local bg = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    bg:SetAllPoints()
    bg:SetColorTexture(settings.colors.background.r, settings.colors.background.g,
        settings.colors.background.b, settings.colors.background.a)
    frame.bgTexture = bg

    -- Border
    local border = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    border:SetAllPoints()
    frame.border = border

    -- Progress bar
    local bar = frame:CreateTexture(nil, "ARTWORK", nil, 1)
    bar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    bar:SetWidth(0)
    bar:SetHeight(frame:GetHeight())
    bar:SetColorTexture(settings.colors.bar.r, settings.colors.bar.g,
        settings.colors.bar.b, settings.colors.bar.a)
    frame.progressBar = bar

    -- Text overlay
    local text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    text:SetPoint("CENTER", frame, "CENTER", 0, 0)
    text:SetJustifyH("CENTER")
    text:SetJustifyV("MIDDLE")
    frame.text = text

    -- Close button for positioning
    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 12, 12)
    closeButton:SetScript("OnClick", function()
        self:StopPositioning()
    end)
    closeButton:Hide()
    frame.closeButton = closeButton

    -- Dragging
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:EnableMouse(NAG.IsAnyEditMode and NAG:IsAnyEditMode())
    frame:SetScript("OnDragStart", function()
        local canDrag = NAG.IsAnyEditMode and NAG:IsAnyEditMode()
        if canDrag and (not UnitAffectingCombat("player") or isPositioning) then
            frame:StartMoving()
            isDragging[barKey] = true
        end
    end)
    frame:SetScript("OnDragStop", function()
        if isDragging[barKey] then
            frame:StopMovingOrSizing()
            isDragging[barKey] = false
            local left, bottom = frame:GetLeft(), frame:GetBottom()
            if left and bottom then
                frame:SetParent(UIParent)
                frame:ClearAllPoints()
                frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left, bottom)
            end
            local point, _, _, x, y = frame:GetPoint(1)
            settings.point = point
            settings.x = x
            settings.y = y
        end
    end)

    frame:Hide()
    return frame
end

function HunterDebugBarsTBC:CreateAutoShotFrame()
    if frames.autoShot then return end
    frames.autoShot = CreateDebugBarFrame(self, "NAGHunterDebugAutoShotBar",
        self.db.class.autoShotBar, "autoShot")
    self:UpdateFrameSettings(frames.autoShot, self.db.class.autoShotBar)
end

function HunterDebugBarsTBC:CreateMeleeFrame()
    if frames.melee then return end
    frames.melee = CreateDebugBarFrame(self, "NAGHunterDebugMeleeBar",
        self.db.class.meleeBar, "melee")
    self:UpdateFrameSettings(frames.melee, self.db.class.meleeBar)
end

function HunterDebugBarsTBC:CreateCastFrame()
    if frames.cast then return end
    frames.cast = CreateDebugBarFrame(self, "NAGHunterDebugCastBar",
        self.db.class.castBar, "cast")
    self:UpdateFrameSettings(frames.cast, self.db.class.castBar)
end

function HunterDebugBarsTBC:CreateAllFrames()
    self:CreateAutoShotFrame()
    self:CreateMeleeFrame()
    self:CreateCastFrame()
end

-- ============================ FRAME SETTINGS ============================

function HunterDebugBarsTBC:NAG_FRAME_UPDATED()
    self:UpdateVisibility()
    if frames.autoShot then self:UpdateFrameSettings(frames.autoShot, self.db.class.autoShotBar) end
    if frames.melee then self:UpdateFrameSettings(frames.melee, self.db.class.meleeBar) end
    if frames.cast then self:UpdateFrameSettings(frames.cast, self.db.class.castBar) end
end

function HunterDebugBarsTBC:UpdateFrameSettings(frame, settings)
    if not frame then return end

    frame:SetSize(settings.width, settings.height)
    frame:SetAlpha(settings.alpha)

    -- Background
    if frame.bgTexture and settings.colors.background then
        local c = settings.colors.background
        frame.bgTexture:SetColorTexture(c.r, c.g, c.b, c.a)
    end

    -- Border
    if settings.showBorder then
        frame.border:Show()
        local bc = settings.borderColor or { r = 1, g = 1, b = 1, a = 1 }
        frame.border:SetBackdropBorderColor(bc.r, bc.g, bc.b, bc.a)
        frame.border:SetBackdrop({
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = settings.borderThickness or 1,
        })
    else
        frame.border:Hide()
    end

    -- Progress bar color
    if frame.progressBar and settings.colors.bar then
        local c = settings.colors.bar
        frame.progressBar:SetColorTexture(c.r, c.g, c.b, c.a)
    end
end

-- ============================ VISIBILITY ============================

function HunterDebugBarsTBC:UpdateVisibility()
    -- In edit mode: force visible, raise strata/level above NAG display frames
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        local function showBar(f)
            if f then
                f:SetFrameStrata("DIALOG")
                f:SetFrameLevel(200)
                f:Show()
            end
        end
        if self.db.class.showAutoShotBar then showBar(frames.autoShot) elseif frames.autoShot then frames.autoShot:Hide() end
        if self.db.class.showMeleeBar then showBar(frames.melee) elseif frames.melee then frames.melee:Hide() end
        if self.db.class.showCastBar then showBar(frames.cast) elseif frames.cast then frames.cast:Hide() end
        return
    end

    local show = IsHunterBM() or isPositioning
    local dm = NAG:GetModule("DisplayManager", true)
    local level = dm and dm.GetRecommendedClassBarFrameLevel and dm:GetRecommendedClassBarFrameLevel() or 50

    if frames.autoShot then
        if not self.db.class.showAutoShotBar or (self.db.class.hideOutOfCombat and
            not UnitAffectingCombat("player") and not isPositioning) or not show then
            frames.autoShot:Hide()
        else
            frames.autoShot:SetFrameStrata("MEDIUM")
            frames.autoShot:SetFrameLevel(level)
            frames.autoShot:Show()
        end
    end

    if frames.melee then
        if not self.db.class.showMeleeBar or (self.db.class.hideOutOfCombat and
            not UnitAffectingCombat("player") and not isPositioning) or not show then
            frames.melee:Hide()
        else
            frames.melee:SetFrameStrata("MEDIUM")
            frames.melee:SetFrameLevel(level)
            frames.melee:Show()
        end
    end

    if frames.cast then
        if not self.db.class.showCastBar or (self.db.class.hideOutOfCombat and
            not UnitAffectingCombat("player") and not isPositioning) or not show then
            frames.cast:Hide()
        else
            frames.cast:SetFrameStrata("MEDIUM")
            frames.cast:SetFrameLevel(level)
            frames.cast:Show()
        end
    end
end

-- ============================ POSITIONING ============================

function HunterDebugBarsTBC:StartPositioning()
    isPositioning = true
    if frames.autoShot then
        frames.autoShot:EnableMouse(true)
        frames.autoShot.closeButton:Show()
    end
    if frames.melee then
        frames.melee:EnableMouse(true)
        frames.melee.closeButton:Show()
    end
    if frames.cast then
        frames.cast:EnableMouse(true)
        frames.cast.closeButton:Show()
    end
    self:UpdateVisibility()
end

function HunterDebugBarsTBC:StopPositioning()
    isPositioning = false
    if frames.autoShot then
        frames.autoShot.closeButton:Hide()
    end
    if frames.melee then
        frames.melee.closeButton:Hide()
    end
    if frames.cast then
        frames.cast.closeButton:Hide()
    end
    self:UpdateVisibility()
end

-- ============================ UPDATES ============================

function HunterDebugBarsTBC:UpdateAutoShotBar()
    local frame = frames.autoShot
    if not frame or not frame:IsShown() then return end

    if not swingTimerLib then
        frame.progressBar:SetWidth(0)
        frame.text:SetText("No swing timer")
        return
    end

    local speed, expiration, lastSwing = swingTimerLib:UnitSwingTimerInfo("player", "ranged")
    if not speed or not expiration or speed <= 0 then
        frame.progressBar:SetWidth(0)
        frame.text:SetText("No ranged weapon")
        return
    end

    local now = GetTime()
    local timeToNext = math.max(0, expiration - now)
    local settings = self.db.class.autoShotBar

    -- Progress bar (right-to-left countdown)
    local progress = timeToNext / speed
    if progress > 1.0 then progress = 1.0 end
    local barWidth = settings.width * progress
    frame.progressBar:SetWidth(barWidth)

    -- Text overlay
    frame.text:SetText(string.format("Auto: %.2fs | Speed: %.2fs", timeToNext, speed))
end

function HunterDebugBarsTBC:UpdateMeleeBar()
    local frame = frames.melee
    if not frame or not frame:IsShown() then return end

    if not swingTimerLib then
        frame.progressBar:SetWidth(0)
        frame.text:SetText("No swing timer")
        return
    end

    local speed, expiration, lastSwing = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
    if not speed or not expiration or speed <= 0 then
        frame.progressBar:SetWidth(0)
        frame.text:SetText("No melee weapon")
        return
    end

    local now = GetTime()
    local timeToNext = math.max(0, expiration - now)
    local settings = self.db.class.meleeBar

    -- Progress bar (right-to-left countdown)
    local progress = timeToNext / speed
    if progress > 1.0 then progress = 1.0 end
    local barWidth = settings.width * progress
    frame.progressBar:SetWidth(barWidth)

    -- Text overlay
    frame.text:SetText(string.format("Melee: %.2fs | Speed: %.2fs", timeToNext, speed))
end

function HunterDebugBarsTBC:UpdateCastBar()
    local frame = frames.cast
    if not frame or not frame:IsShown() then return end

    local spellName, _, _, _, startTimeMS, endTimeMS, _, _, spellIdFromAPI = UnitCastingInfo("player")
    local settings = self.db.class.castBar

    -- Debug-only: show current haste-scaled wind-up and library autoShotCastTime (for comparison).
    local windupSeconds = 0.50
    if NAG and NAG.HunterWeaveSnapshot then
        local snap = NAG:HunterWeaveSnapshot()
        if snap and snap.ok and snap.rangedWindupSeconds then
            windupSeconds = snap.rangedWindupSeconds
        elseif snap and snap.ok and ns and type(ns.HunterComputeWindupSeconds) == "function" then
            local rangedSpeed = tonumber(snap.rangedSpeed or 0) or 0
            local baseSpeed = 0
            if swingTimerLib and swingTimerLib.player and swingTimerLib.player.rangedBaseSpeed then
                baseSpeed = tonumber(swingTimerLib.player.rangedBaseSpeed) or 0
            end
            windupSeconds = ns.HunterComputeWindupSeconds(rangedSpeed, baseSpeed, 0.50)
        end
    end
    local libAutoShotCastTime = nil
    if swingTimerLib and swingTimerLib.player and swingTimerLib.player.autoShotCastTime then
        libAutoShotCastTime = swingTimerLib.player.autoShotCastTime
    end

    if spellName and endTimeMS and startTimeMS then
        -- Update tracked cast info
        if spellIdFromAPI then
            currentCastSpellId = spellIdFromAPI
            currentCastName = spellName
            currentCastEndTime = endTimeMS / 1000
            currentCastTotalTime = (endTimeMS - startTimeMS) / 1000
        end

        local now = GetTime()
        local castRemaining = math.max(0, (endTimeMS / 1000) - now)
        local castTotal = (endTimeMS - startTimeMS) / 1000

        -- Progress bar (left-to-right, shrinks from right)
        local progress = castRemaining / castTotal
        if progress > 1.0 then progress = 1.0 end
        if progress < 0 then progress = 0 end
        local barWidth = settings.width * progress
        frame.progressBar:SetWidth(barWidth)

        -- Text overlay with autoshot comparison
        local libText = libAutoShotCastTime and string.format("%.2fs", libAutoShotCastTime) or "n/a"
        local gcdSnap = (NAG.GCDDebugSnapshot and NAG:GCDDebugSnapshot()) or nil
        local gcdText = "GCD:n/a"
        if gcdSnap then
            gcdText = string.format(
                "GCDleft=%.3f probe=%d dur=%.3f rem=%.3f start=%.3f",
                tonumber(gcdSnap.gcdTimeToReady or 0) or 0,
                tonumber(gcdSnap.probeSpellId or 0) or 0,
                tonumber(gcdSnap.duration or 0) or 0,
                tonumber(gcdSnap.remaining or 0) or 0,
                tonumber(gcdSnap.start or 0) or 0
            )
        end

        frame.text:SetText(string.format("Cast: %s %.2fs | %s | AutoWindup: %.2fs | LibAuto: %s",
            spellName, castRemaining, gcdText, windupSeconds, libText))
    else
        -- Check tracked state if UnitCastingInfo is nil
        if currentCastSpellId and currentCastEndTime then
            local now = GetTime()
            local castRemaining = math.max(0, currentCastEndTime - now)

            if castRemaining > 0 then
                local progress = castRemaining / (currentCastTotalTime or 1.0)
                if progress > 1.0 then progress = 1.0 end
                if progress < 0 then progress = 0 end
                local barWidth = settings.width * progress
                frame.progressBar:SetWidth(barWidth)

                local libText = libAutoShotCastTime and string.format("%.2fs", libAutoShotCastTime) or "n/a"
                local gcdSnap = (NAG.GCDDebugSnapshot and NAG:GCDDebugSnapshot()) or nil
                local gcdText = "GCD:n/a"
                if gcdSnap then
                    gcdText = string.format(
                        "GCDleft=%.3f probe=%d dur=%.3f rem=%.3f start=%.3f",
                        tonumber(gcdSnap.gcdTimeToReady or 0) or 0,
                        tonumber(gcdSnap.probeSpellId or 0) or 0,
                        tonumber(gcdSnap.duration or 0) or 0,
                        tonumber(gcdSnap.remaining or 0) or 0,
                        tonumber(gcdSnap.start or 0) or 0
                    )
                end

                frame.text:SetText(string.format("Cast: %s %.2fs | %s | AutoWindup: %.2fs | LibAuto: %s",
                    currentCastName or "Unknown", castRemaining, gcdText, windupSeconds, libText))
            else
                -- Cast finished
                frame.progressBar:SetWidth(0)
                local gcdSnap = (NAG.GCDDebugSnapshot and NAG:GCDDebugSnapshot()) or nil
                if gcdSnap then
                    frame.text:SetText(string.format(
                        "Not casting | GCDleft=%.3f probe=%d dur=%.3f rem=%.3f start=%.3f",
                        tonumber(gcdSnap.gcdTimeToReady or 0) or 0,
                        tonumber(gcdSnap.probeSpellId or 0) or 0,
                        tonumber(gcdSnap.duration or 0) or 0,
                        tonumber(gcdSnap.remaining or 0) or 0,
                        tonumber(gcdSnap.start or 0) or 0
                    ))
                else
                    frame.text:SetText("Not casting | GCD:n/a")
                end
                currentCastSpellId = nil
                currentCastEndTime = nil
                currentCastTotalTime = nil
                currentCastName = nil
            end
        else
            frame.progressBar:SetWidth(0)
            local gcdSnap = (NAG.GCDDebugSnapshot and NAG:GCDDebugSnapshot()) or nil
            if gcdSnap then
                frame.text:SetText(string.format(
                    "Not casting | GCDleft=%.3f probe=%d dur=%.3f rem=%.3f start=%.3f",
                    tonumber(gcdSnap.gcdTimeToReady or 0) or 0,
                    tonumber(gcdSnap.probeSpellId or 0) or 0,
                    tonumber(gcdSnap.duration or 0) or 0,
                    tonumber(gcdSnap.remaining or 0) or 0,
                    tonumber(gcdSnap.start or 0) or 0
                ))
            else
                frame.text:SetText("Not casting | GCD:n/a")
            end
        end
    end
end

function HunterDebugBarsTBC:UpdateBars()
    if self.db.class.showAutoShotBar then
        self:UpdateAutoShotBar()
    end
    if self.db.class.showMeleeBar then
        self:UpdateMeleeBar()
    end
    if self.db.class.showCastBar then
        self:UpdateCastBar()
    end
end

-- ============================ CAST TRACKING ============================

function HunterDebugBarsTBC:UNIT_SPELLCAST_START(event, unit, castString, spellId)
    if unit == "player" and type(spellId) == "number" then
        currentCastSpellId = spellId
        currentCastStartTime = GetTime()

        local _, _, _, startTimeMS, endTimeMS, _, _, _, spellIdFromAPI = UnitCastingInfo("player")
        if endTimeMS and startTimeMS and endTimeMS > startTimeMS and (not spellIdFromAPI or spellIdFromAPI == spellId) then
            currentCastStartTime = startTimeMS / 1000
            currentCastEndTime = endTimeMS / 1000
            currentCastTotalTime = (endTimeMS - startTimeMS) / 1000
            local spellName = select(1, UnitCastingInfo("player"))
            currentCastName = spellName

            if spellId == STEADY_SHOT_ID then
                lastSteadyCastStartTime = currentCastStartTime
                lastSteadyCastDurationSeconds = nil
                lastSteadyPredictedSeconds = currentCastTotalTime
                lastSteadyPredictedSource = "UnitCastingInfo"
            end
            return
        end

        -- Fallback: compute from base cast time
        local castTime = nil
        if NAG.SpellCastTime then
            castTime = NAG:SpellCastTime(spellId)
        end
        if castTime and castTime > 0 then
            currentCastEndTime = GetTime() + castTime
            currentCastTotalTime = castTime
            local spellName = select(1, UnitCastingInfo("player")) or "Unknown"
            currentCastName = spellName

            if spellId == STEADY_SHOT_ID then
                lastSteadyCastStartTime = currentCastStartTime
                lastSteadyCastDurationSeconds = nil
                lastSteadyPredictedSeconds = castTime
                lastSteadyPredictedSource = "NAG.SpellCastTime"
            end
        else
            currentCastSpellId = nil
            currentCastStartTime = nil
            currentCastEndTime = nil
            currentCastTotalTime = nil
            currentCastName = nil
        end
    end
end

function HunterDebugBarsTBC:UNIT_SPELLCAST_STOP(event, unit)
    if unit == "player" then
        currentCastSpellId = nil
        currentCastStartTime = nil
        currentCastEndTime = nil
        currentCastTotalTime = nil
        currentCastName = nil
    end
end

function HunterDebugBarsTBC:UNIT_SPELLCAST_INTERRUPTED(event, unit)
    if unit == "player" then
        currentCastSpellId = nil
        currentCastStartTime = nil
        currentCastEndTime = nil
        currentCastTotalTime = nil
        currentCastName = nil
    end
end

function HunterDebugBarsTBC:UNIT_SPELLCAST_SUCCEEDED(event, unit, castString, spellId)
    if unit ~= "player" or type(spellId) ~= "number" then
        return
    end
    if spellId ~= STEADY_SHOT_ID then
        return
    end
    if not lastSteadyCastStartTime then
        return
    end

    local now = GetTime()
    local actual = now - lastSteadyCastStartTime
    if actual < 0 then
        actual = 0
    end
    lastSteadyCastDurationSeconds = actual

    local predicted = lastSteadyPredictedSeconds
    local predictedText = predicted and string.format("%.3fs", predicted) or "n/a"

    -- Also print what the core NAG cast-time function currently believes (base cast time, not haste-adjusted).
    local nagBase = nil
    if NAG.SpellCastTime then
        nagBase = NAG:SpellCastTime(STEADY_SHOT_ID)
    end
    local nagBaseText = (nagBase and nagBase > 0) and string.format("%.3fs", nagBase) or "n/a"

    local src = lastSteadyPredictedSource or "unknown"
    self:Print(string.format(
        "Steady Shot cast completed: actual=%.3fs, predicted=%s (%s), nagBase=%s",
        actual, predictedText, src, nagBaseText
    ))
end

-- ============================ SPEC UPDATED ============================

function HunterDebugBarsTBC:NAG_SPEC_UPDATED()
    self:UpdateVisibility()
end

-- ============================ LIFECYCLE ============================

function HunterDebugBarsTBC:ModuleInitialize()
    OptionsFactory = NAG:GetModule("OptionsFactory")
    SpecCompat = NAG:GetModule("SpecCompat")
end

function HunterDebugBarsTBC:ModuleEnable()
    if UnitClassBase("player") ~= "HUNTER" then
        self:SetEnabledState(false)
        return
    end
    if not Version:IsTBC() then
        self:SetEnabledState(false)
        return
    end

    if not frames.autoShot then
        self:CreateAllFrames()
    end

    -- Set up update loop
    local updateFrame = CreateFrame("Frame")
    updateFrame:SetScript("OnUpdate", function(_, elapsed)
        lastUpdate = lastUpdate + elapsed
        if lastUpdate >= UPDATE_INTERVAL then
            self:UpdateBars()
            lastUpdate = 0
        end
    end)
    self.updateFrame = updateFrame

    self:UpdateVisibility()
end

function HunterDebugBarsTBC:ModuleDisable()
    if self.updateFrame then
        self.updateFrame:SetScript("OnUpdate", nil)
    end
    if frames.autoShot then frames.autoShot:Hide() end
    if frames.melee then frames.melee:Hide() end
    if frames.cast then frames.cast:Hide() end
end

-- ============================ OPTIONS ============================

function HunterDebugBarsTBC:GetOptions()
    local function notify()
        if AceConfigRegistry then
            AceConfigRegistry:NotifyChange("NAG")
        end
    end

    local function colorGetter(colorTable)
        return function()
            return colorTable.r, colorTable.g, colorTable.b, colorTable.a
        end
    end

    local function colorSetter(colorTable)
        return function(_, r, g, b, a)
            colorTable.r, colorTable.g, colorTable.b, colorTable.a = r, g, b, a
            if frames.autoShot then self:UpdateFrameSettings(frames.autoShot, self.db.class.autoShotBar) end
            if frames.melee then self:UpdateFrameSettings(frames.melee, self.db.class.meleeBar) end
            if frames.cast then self:UpdateFrameSettings(frames.cast, self.db.class.castBar) end
        end
    end

    local function createBarOptions(barKey, barName, settings, frameRef)
        return {
            enabled = OptionsFactory:CreateToggle(
                L["Show"] or "Show",
                L["Show this debug bar"] or "Show this debug bar",
                function() return self.db.class["show" .. barKey .. "Bar"] end,
                function(_, v) self.db.class["show" .. barKey .. "Bar"] = v; self:UpdateVisibility() end,
                { width = "full", order = 0 }
            ),
            width = OptionsFactory:CreateRange(
                L["Width"] or "Width",
                L["Bar width"] or "Bar width",
                function() return settings.width end,
                function(_, v) settings.width = v; if frameRef then self:UpdateFrameSettings(frameRef, settings) end end,
                { min = 80, max = 1000, step = 1, order = 10 }
            ),
            height = OptionsFactory:CreateRange(
                L["Height"] or "Height",
                L["Bar height"] or "Bar height",
                function() return settings.height end,
                function(_, v) settings.height = v; if frameRef then self:UpdateFrameSettings(frameRef, settings) end end,
                { min = 10, max = 200, step = 1, order = 20 }
            ),
            alpha = OptionsFactory:CreateRange(
                L["Alpha"] or "Alpha",
                L["Bar transparency"] or "Bar transparency",
                function() return settings.alpha end,
                function(_, v) settings.alpha = v; if frameRef then self:UpdateFrameSettings(frameRef, settings) end end,
                { min = 0, max = 1, step = 0.05, order = 30 }
            ),
            showBorder = OptionsFactory:CreateToggle(
                L["Show Border"] or "Show Border",
                L["Show border around the bar"] or "Show border around the bar",
                function() return settings.showBorder end,
                function(_, v) settings.showBorder = v; if frameRef then self:UpdateFrameSettings(frameRef, settings) end end,
                { width = "full", order = 50 }
            ),
            borderThickness = OptionsFactory:CreateRange(
                L["Border Thickness"] or "Border Thickness",
                L["Border thickness"] or "Border thickness",
                function() return settings.borderThickness end,
                function(_, v) settings.borderThickness = v; if frameRef then self:UpdateFrameSettings(frameRef, settings) end end,
                { min = 1, max = 8, step = 1, order = 51 }
            ),
            borderColor = OptionsFactory:CreateColor(
                L["Border Color"] or "Border Color",
                L["Border color"] or "Border color",
                colorGetter(settings.borderColor),
                colorSetter(settings.borderColor),
                { order = 52 }
            ),
            colorBackground = OptionsFactory:CreateColor(
                L["Background"] or "Background",
                L["Background color"] or "Background color",
                colorGetter(settings.colors.background),
                colorSetter(settings.colors.background),
                { order = 60 }
            ),
            colorBar = OptionsFactory:CreateColor(
                L["Bar Color"] or "Bar Color",
                L["Progress bar color"] or "Progress bar color",
                colorGetter(settings.colors.bar),
                colorSetter(settings.colors.bar),
                { order = 61 }
            ),
        }
    end

    return {
        type = "group",
        name = L["Hunter Debug Bars"] or "Hunter Debug Bars",
        order = 35,
        childGroups = "tab",
        args = {
            enabled = OptionsFactory:CreateToggle(
                L["Enable"] or "Enable",
                L["Enable Hunter Debug Bars"] or "Enable Hunter Debug Bars",
                function() return self.db.class.enabled end,
                function(_, v) self.db.class.enabled = v; self:UpdateVisibility() end,
                { width = "full", order = 0 }
            ),
            hideOutOfCombat = OptionsFactory:CreateToggle(
                L["Hide Out of Combat"] or "Hide Out of Combat",
                L["Hide the debug bars when out of combat"] or "Hide the debug bars when out of combat",
                function() return self.db.class.hideOutOfCombat end,
                function(_, v) self.db.class.hideOutOfCombat = v; self:UpdateVisibility() end,
                { width = "full", order = 1 }
            ),
            positionBars = OptionsFactory:CreateExecute(
                L["Position Bars"] or "Position Bars",
                L["Drag the bars to position them, then click X when done."] or
                    "Drag the bars to position them, then click X when done.",
                function() self:StartPositioning() end,
                { width = "full", order = 2 }
            ),
            autoShotBar = {
                name = L["Auto Shot Bar"] or "Auto Shot Bar",
                type = "group",
                order = 10,
                inline = false,
                args = createBarOptions("AutoShot", "Auto Shot", self.db.class.autoShotBar, frames.autoShot),
            },
            meleeBar = {
                name = L["Melee Bar"] or "Melee Bar",
                type = "group",
                order = 20,
                inline = false,
                args = createBarOptions("Melee", "Melee", self.db.class.meleeBar, frames.melee),
            },
            castBar = {
                name = L["Cast Bar"] or "Cast Bar",
                type = "group",
                order = 30,
                inline = false,
                args = createBarOptions("Cast", "Cast", self.db.class.castBar, frames.cast),
            },
        }
    }
end

return HunterDebugBarsTBC
