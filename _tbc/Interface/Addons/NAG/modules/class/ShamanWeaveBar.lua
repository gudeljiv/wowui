--- @module "NAG.ShamanWeaveBar"
--- Module for Shaman weave optimization
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local GetTime = _G.GetTime
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local WoWAPI = ns.WoWAPI
local UnitExists = _G.UnitExists
local UnitAttackSpeed = _G.UnitAttackSpeed
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitLevel = _G.UnitLevel
local UnitCastingInfo = _G.UnitCastingInfo
local CreateFrame = _G.CreateFrame
local GetSpellTexture = C_Spell and C_Spell.GetSpellTexture or _G.GetSpellTexture

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type StateManager
--- @type DataManager
local StateManager, DataManager

--- @type DisplayManager
--- @type OptionsFactory
--- @type TimerManager
local DisplayManager, OptionsFactory, TimerManager

--- @type SpecCompat
local SpecCompat



local L = LibStub("AceLocale-3.0"):GetLocale("NAG")


local AceConfigRegistry = ns.AceConfigRegistry


-- Constants
local LIGHTNING_BOLT_ID = 403
local CHAIN_LIGHTNING_ID = 421 -- Chain Lightning spell ID
local MAX_WEAVE_TIME = 3.0
local MIN_ENEMIES_FOR_CL = 2   -- Minimum number of enemies to switch to Chain Lightning

-- Specialization constants
local ENHANCEMENT_SPEC_INDEX = 2 -- Enhancement spec index (specIndex 2 for Shaman)

-- Spell CD Bar tracked spells
local SPELL_CD_BAR_SPELLS = {
    73680,  -- Unleash Elements
    115356, -- Stormblast
    17364,  -- Stormstrike
    117014, -- Elemental Blast
    60103,  -- Lava Lash
    8050,   -- Flame Shock
    8042    -- Earth Shock
}

-- Default settings
local defaults = {
    class = {
        enabled = true,
        showBar = true,
        hideOutOfCombat = true, -- New option to hide bars out of combat
        showKeybindOnBar = false,
        bar = {
            width = 200,
            height = 20,
            alpha = 1,
            point = "CENTER",
            x = 0,
            y = -100,
            showBorder = true,
            borderColor = { r = 1, g = 1, b = 1, a = 1 },
            borderThickness = 1,
            showCountdownText = true,
            countdownTextSize = 14,
            countdownTextColor = { r = 1, g = 1, b = 1, a = 1 },
            showSparkIcons = true, -- Controls circular spark overlays for custom layout
            -- Individual bar heights
            lbBarHeightPct = 0.15, -- 15% of universal height
            clBarHeightPct = 0.15,
            ebBarHeightPct = 0.15,
            -- Bar colors
            colors = {
                background = { r = 0.2, g = 0.2, b = 0.2, a = 0.8 },
                weave = { r = 0.4, g = 0.7, b = 1, a = 0.8 },
                countdown = { r = 0.8, g = 0.2, b = 0.2, a = 0.8 },
                gcd = { r = 0.3, g = 0.3, b = 0.3, a = 0.85 },
                spark = { r = 1, g = 1, b = 1, a = 1 },
                clweave = { r = 0.2, g = 0.4, b = 0.8, a = 0.8 },
                upcomingweave = { r = 0.4, g = 0.7, b = 1, a = 0.8 },
                clupcomingweave = { r = 0.2, g = 0.4, b = 0.8, a = 0.8 }
            },
            -- Swing timer settings
            swingTimer = {
                enabled = true,
                sparkWidth = 2,                                    -- Fixed width
                sparkColor = { r = 0.8, g = 0.8, b = 0.8, a = 1 }, -- Light gray color
                nextSwingEnabled = true,
                nextSparkColor = { r = 0.8, g = 0.8, b = 0.8, a = 0.7 },
                backgroundBar = {
                    enabled = true,
                    alpha = 0.3
                },
                -- universalBarHeight removed
            },
            background = "none",
            bgColor = { r = 1, g = 1, b = 1, a = 1 },
            borderArtHeightPct = 1.7, -- default 170% of bar height
        },
        -- Preset Layout settings - completely independent system
        presetLayout = {
            enabled = true,
            width = 89,
            height = 20,
            alpha = 1.0,
            point = "CENTER",
            x = 0,
            y = 0,
            showBorder = true,
            borderColor = { r = 1, g = 1, b = 1, a = 1 },
            borderThickness = 1,
            showCountdownText = true,
            countdownTextSize = 14,
            countdownTextColor = { r = 1, g = 1, b = 1, a = 1 },
            lbBarHeightPct = 0.16,
            clBarHeightPct = 0.15,
            ebBarHeightPct = 0.15,
            colors = {
                background = { r = 0.2, g = 0.2, b = 0.2, a = 0.8 },
                weave = { r = 0.4, g = 0.7, b = 1, a = 0.8 },
                countdown = { r = 0.8, g = 0.2, b = 0.2, a = 0.8 },
                gcd = { r = 0.3, g = 0.3, b = 0.3, a = 0.85 },
                spark = { r = 1, g = 1, b = 1, a = 1 },
                clweave = { r = 0.2, g = 0.4, b = 0.8, a = 0.8 },
                upcomingweave = { r = 0.4, g = 0.7, b = 1, a = 0.8 },
                clupcomingweave = { r = 0.2, g = 0.4, b = 0.8, a = 0.8 }
            },
            swingTimer = {
                enabled = true,
                sparkWidth = 2,
                sparkColor = false, -- As requested
                nextSwingEnabled = true,
                nextSparkColor = { r = 0.8, g = 0.8, b = 0.8, a = 0.7 },
            },
            background = {
                enabled = true,
                style = "Simpler",
                scale = 1.9,
                xOffset = -32,
                yOffset = 8,
                width = 84,
                height = 40,
                alpha = 0.8
            },
            -- Spell CD Bar settings
            spellCDBar = {
                enabled = true,
                yOffset = 4
            }
        },
        debugNetworkStatsData = {},
        debugNetworkStats = false,
        debugAdjustedDelay = nil,
        debugInputDelay = nil,
    }
}

-- Local state
local frame = nil
local isDragging = false
local isPositioning = false    -- New variable to track positioning mode
local lastUpdate = 0
local UPDATE_INTERVAL = 0.016  -- Approximately 60 FPS for smooth movement
local autoAnchorEnabled = true -- Enable automatic anchoring by default

local sparkIconsEnabled = true

-- ============================ MAELSTROM CAST-TIME ADJUSTMENT ============================
-- Enhancement Shaman: Maelstrom Weapon reduces cast time of certain spells by 20% per stack (up to 5).
-- We need to reflect this in weave-window math; WoWAPI GetSpellInfo cast time does not include temporary buffs.
local function ClampNumber(value, minValue, maxValue)
    if value == nil then return minValue end
    if value < minValue then return minValue end
    if value > maxValue then return maxValue end
    return value
end

--- @param spellId number
--- @param baseCastTime number
--- @param maelstromStacks number
--- @return number
local function GetMaelstromAdjustedCastTime(spellId, baseCastTime, maelstromStacks)
    if not spellId or not baseCastTime then
        return baseCastTime or 0
    end

    -- Spells we treat as Maelstrom-reducible for the weave bar UI.
    -- LB/CL are core; EB is included because it is commonly used with Maelstrom in later expansions.
    if spellId ~= LIGHTNING_BOLT_ID and spellId ~= CHAIN_LIGHTNING_ID and spellId ~= 117014 then
        return baseCastTime
    end

    local stacks = ClampNumber(tonumber(maelstromStacks) or 0, 0, 5)
    if stacks <= 0 then
        return baseCastTime
    end

    local multiplier = 1 - (0.20 * stacks)
    if multiplier < 0 then multiplier = 0 end
    return baseCastTime * multiplier
end

local function HideSparkFrame(sparkFrame)
    if not sparkFrame then return end
    if sparkFrame.icon then sparkFrame.icon:Hide() end
    if sparkFrame.line then sparkFrame.line:Hide() end
    if sparkFrame.keybindText then
        sparkFrame.keybindText:SetText("")
        sparkFrame.keybindText:Hide()
    end
    if sparkFrame.currentX then sparkFrame.currentX = nil end
    sparkFrame:Hide()
end

local function SetSparkKeybind(spark, showKeybind)
    if not spark or not spark.keybindText then return end
    if showKeybind and spark.spellId then
        local KeybindManager = NAG:GetModule("KeybindManager", true)
        local kb = ""
        if KeybindManager and KeybindManager.GetSpellKeybind then
            kb = KeybindManager:GetSpellKeybind(spark.spellId) or ""
        end
        spark.keybindText:SetText(kb)
        if kb ~= "" then
            spark.keybindText:Show()
        else
            spark.keybindText:Hide()
        end
    else
        spark.keybindText:SetText("")
        spark.keybindText:Hide()
    end
end

local function HideAllSparkFrames()
    if not frame then return end
    HideSparkFrame(frame.weaveSpark)
    HideSparkFrame(frame.clWeaveSpark)
    HideSparkFrame(frame.upcomingWeaveSpark)
    HideSparkFrame(frame.clUpcomingWeaveSpark)
    HideSparkFrame(frame.ebWeaveSpark)
    HideSparkFrame(frame.ebUpcomingWeaveSpark)
    if frame.spellCDSparks then
        for _, sparkFrame in ipairs(frame.spellCDSparks) do
            HideSparkFrame(sparkFrame)
        end
    end
end

-- Track current spell cast for GCD bar logic
local currentCastSpellId = nil
local currentCastEndTime = nil

--- @class ShamanWeaveBar:CoreModule
local ShamanWeaveBar = NAG:CreateModule("ShamanWeaveBar", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "SHAMAN",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.CLASS,
        ns.DEBUG_CATEGORIES.UI
    },
    -- ZERO-BOILERPLATE: Declarative event and message handlers
    eventHandlers = {
        UNIT_SPELLCAST_START = true,
        UNIT_SPELLCAST_STOP = true,
        UNIT_SPELLCAST_INTERRUPTED = true,
        -- PLAYER_LEVEL_UP removed - handled via NAG_SPEC_UPDATED from SpecCompat
        PLAYER_REGEN_DISABLED = true,                   -- Combat start
        PLAYER_REGEN_ENABLED = "PLAYER_REGEN_DISABLED", -- Combat end
    },
    messageHandlers = {
        NAG_SPEC_UPDATED = true,
        NAG_FRAME_UPDATED = true,
        NAG_SHAMAN_BAR_SCALE_UPDATED = true,
    },
    defaultState = {
        frame = nil,
        isDragging = false
    }
})
-- Add module to namespace
ns.ShamanWeaveBar = ShamanWeaveBar
local module = ShamanWeaveBar

-- Runtime (non-DB) state: keep module enabled so it can react to spec swaps via NAG_SPEC_UPDATED.
-- When not Enhancement, we simply hide/idle.
module.isEnhancementSpec = false

function ShamanWeaveBar:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    StateManager = NAG:GetModule("StateManager")
    DataManager = NAG:GetModule("DataManager")
    DisplayManager = NAG:GetModule("DisplayManager")
    OptionsFactory = NAG:GetModule("OptionsFactory")
    TimerManager = NAG:GetModule("TimerManager")
    SpecCompat = NAG:GetModule("SpecCompat")

    -- Check game version - only works in Wrath, Cata, and Mists
    local Version = ns.Version
    if not Version:IsWrath() and not Version:IsCata() and not Version:IsMists() then
        self:Debug("ShamanWeaveBar only works in Wrath, Cata, and Mists - current version not supported")
        self:SetEnabledState(false)
        return
    end

    -- Check if player is a Shaman
    local playerClass = NAG.CLASS_FILENAME
    if playerClass ~= "SHAMAN" then
        self:Debug("Not a Shaman, skipping initialization")
        self:SetEnabledState(false)
        return
    end

    -- Check if player is high enough level to have specs
    local playerLevel = UnitLevel("player")
    if playerLevel < 10 then
        self:Debug("Player level too low for specs, skipping initialization")
        self:SetEnabledState(false)
        return
    end


    -- ZERO-BOILERPLATE: Events and messages are automatically registered via declarative patterns

    -- Register for swing timer events to force instant update on swing
    local swingTimerLib = LibStub("LibClassicSwingTimerAPI")
    if swingTimerLib then
        swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_START", function(_, unitId, speed, expirationTime, hand)
            if unitId == "player" and hand == "mainhand" then
                self.forceInstantUpdate = true
                self:UpdateDisplay()
                self.forceInstantUpdate = false
            end
        end)
        swingTimerLib.RegisterCallback(self, "UNIT_SWING_TIMER_STOP", function(_, unitId, hand)
            if unitId == "player" and hand == "mainhand" then
                self.forceInstantUpdate = true
                self:UpdateDisplay()
                self.forceInstantUpdate = false
            end
        end)
    end

    -- Initial spec check
    self:CheckSpecialization()
end

function ShamanWeaveBar:NAG_SPEC_UPDATED(message)
    -- Only process if spec change was successful
    self:CheckSpecialization()
end

function ShamanWeaveBar:CheckSpecialization()
    -- Check if specialization is available using SpecCompat
    if not SpecCompat then
        -- Keep module enabled so it can recover when SpecCompat becomes available.
        self.isEnhancementSpec = false
        self:UpdateVisibility()
        return
    end
    local specStatus = SpecCompat:GetSpecializationStatus()
    if not specStatus or not specStatus.available then
        -- Keep module enabled so it can react when specs become available (login/spec swap timing).
        self.isEnhancementSpec = false
        self:UpdateVisibility()
        return
    end

    local specIndex = specStatus.specIndex
    if not specIndex then
        -- Spec unknown right now (can happen briefly). Don't hard-toggle state; just keep hidden until known.
        self.isEnhancementSpec = false
        self:UpdateVisibility()
        return
    end

    local isEnh = (specIndex == ENHANCEMENT_SPEC_INDEX)
    local wasEnh = self.isEnhancementSpec
    if wasEnh ~= isEnh then
        self.isEnhancementSpec = isEnh
        self:Debug("Spec state changed: Enhancement=%s", tostring(isEnh))

        if isEnh then
            -- We may have missed frame creation earlier if spec wasn't ready during ModuleEnable.
            if not frame then
                self:CreateFrames()
            end
            if frame then
                self:UpdateFrameSettings()
                frame:SetScript("OnUpdate", function(frameSelf, elapsed)
                    lastUpdate = lastUpdate + elapsed
                    if lastUpdate >= UPDATE_INTERVAL then
                        ShamanWeaveBar:UpdateDisplay()
                        lastUpdate = 0
                    end
                end)
            end
        else
            -- Leaving Enhancement: stop updates and hide.
            if frame then
                frame:SetScript("OnUpdate", nil)
                frame:Hide()
                if frame.spellCDBarFrame then
                    frame.spellCDBarFrame:Hide()
                end
            end
        end
    end

    self:UpdateVisibility()
end

function ShamanWeaveBar:NAG_FRAME_UPDATED(message)
    -- Update anchor when NAG frame is updated; refresh mouse state and visibility when edit mode toggles
    if self.db.class.presetLayout.enabled and autoAnchorEnabled then
        self:UpdateFrameAnchor()
    end
    self:UpdateVisibility()
    self:UpdateFrameSettings()
end

function ShamanWeaveBar:NAG_SHAMAN_BAR_SCALE_UPDATED()
    self:UpdateFrameSettings()
end

function ShamanWeaveBar:ModuleEnable()
    -- Double check all conditions before enabling

    -- Check game version - only works in Wrath, Cata, and Mists
    local Version = ns.Version
    if not Version:IsWrath() and not Version:IsCata() and not Version:IsMists() then
        self:Debug("ShamanWeaveBar only works in Wrath, Cata, and Mists - current version not supported")
        self:SetEnabledState(false)
        return
    end

    -- ============================ MODULE INITIALIZATION ============================
    local playerClass = NAG.CLASS_FILENAME
    if playerClass ~= "SHAMAN" then
        self:Debug("Not a Shaman, skipping enable")
        self:SetEnabledState(false)
        return
    end

    -- Keep module enabled across spec availability changes so it can react to NAG_SPEC_UPDATED.
    if not SpecCompat then
        self.isEnhancementSpec = false
        return
    end
    local specStatus = SpecCompat:GetSpecializationStatus()
    if not specStatus or not specStatus.available then
        self.isEnhancementSpec = false
        return
    end

    -- Keep module enabled across specs so it continues receiving NAG_SPEC_UPDATED.
    -- Actual behavior is gated by self.isEnhancementSpec.
    self:CheckSpecialization()

    -- Create or show the frame
    if self.isEnhancementSpec and not frame then
        self:CreateFrames()
    end

    -- Update visibility based on settings
    self:UpdateVisibility()

    -- Apply automatic anchor if preset layout is enabled
    if self.db.class.presetLayout.enabled and autoAnchorEnabled then
        self:UpdateFrameAnchor()
    end

    -- ZERO-BOILERPLATE: Events are automatically registered via declarative patterns

    -- Start update loop only while Enhancement is active (prevents work on other specs).
    if frame and self.isEnhancementSpec then
        frame:SetScript("OnUpdate", function(frameSelf, elapsed)
            lastUpdate = lastUpdate + elapsed
            if lastUpdate >= UPDATE_INTERVAL then
                ShamanWeaveBar:UpdateDisplay()
                lastUpdate = 0
            end
        end)
    elseif frame then
        frame:SetScript("OnUpdate", nil)
    end

    if frame and self.isEnhancementSpec then
        self:UpdateFrameSettings() -- Ensure all settings (including Spell CD Bar) are applied
    end

    -- Force Spell CD Bar frame visibility to match settings
    if frame and frame.spellCDBarFrame then
        if self.isEnhancementSpec and self.db.class.presetLayout.enabled and self.db.class.presetLayout.spellCDBar.enabled then
            frame.spellCDBarFrame:Show()
        else
            frame.spellCDBarFrame:Hide()
        end
    end

    self:UpdateVisibility() -- Ensure visibility is correct
end

function ShamanWeaveBar:ModuleDisable()
    self:Debug("Disabling ShamanWeaveBar")

    if frame then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end

    -- ZERO-BOILERPLATE: Events are automatically unregistered via declarative patterns
end

function ShamanWeaveBar:CreateFrames()
    -- Create main frame
    frame = CreateFrame("Frame", "NAGShamanWeaveBar", UIParent)
    frame:SetSize(self.db.class.bar.width, self.db.class.bar.height)
    frame:SetPoint(self.db.class.bar.point, self.db.class.bar.x, self.db.class.bar.y)

    -- Create swing timer background bar as a texture on the main frame FIRST so it's always at the back
    local swingBgBar = frame:CreateTexture(nil, "BACKGROUND", nil, -8) -- Render at the lowest allowed sublevel
    swingBgBar:SetAllPoints()
    swingBgBar:SetColorTexture(0, 0, 0, 0.3)
    frame.swingBgBar = swingBgBar

    -- Create background texture (just behind bars, slightly larger)
    local bgTexture = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    bgTexture:SetPoint("CENTER", frame, "CENTER", 0, 0)
    frame.bgTexture = bgTexture

    -- Create preset layout background texture (lowest layer, behind everything)
    local presetBgTexture = frame:CreateTexture(nil, "BACKGROUND", nil, -8)
    presetBgTexture:SetPoint("CENTER", frame, "CENTER", 0, 0)
    -- Texture will be set dynamically based on style selection
    presetBgTexture:Hide() -- Hidden by default
    frame.presetBgTexture = presetBgTexture

    -- Create countdown bar (drawn first, lowest sublayer)
    local countdownBar = frame:CreateTexture(nil, "ARTWORK", nil, -8)
    countdownBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    countdownBar:SetWidth(0)
    countdownBar:SetColorTexture(
        self.db.class.bar.colors.countdown.r,
        self.db.class.bar.colors.countdown.g,
        self.db.class.bar.colors.countdown.b,
        self.db.class.bar.colors.countdown.a
    )
    frame.countdownBar = countdownBar

    -- Create weave bar (drawn above CL bar)
    local weaveBar = frame:CreateTexture(nil, "ARTWORK", nil, -6)
    weaveBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    weaveBar:SetWidth(0)
    weaveBar:SetColorTexture(0.4, 0.7, 1, 0.8) -- Light blue
    frame.weaveBar = weaveBar

    -- Create CL weave bar (drawn below LB bar)
    local clWeaveBar = frame:CreateTexture(nil, "ARTWORK", nil, -7)
    clWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    clWeaveBar:SetWidth(0)
    clWeaveBar:SetColorTexture(0.2, 0.4, 0.8, 0.8) -- Darker blue
    frame.clWeaveBar = clWeaveBar

    -- Create GCD bar (drawn above all other bars)
    local gcdBar = frame:CreateTexture(nil, "ARTWORK", nil, 6)
    gcdBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    gcdBar:SetWidth(0)
    gcdBar:SetColorTexture(0.4, 0.4, 0.4, 0.95) -- Dark gray with 85% alpha
    frame.gcdBar = gcdBar

    -- Create GCD spark texture (highest strata)
    local gcdSpark = frame:CreateTexture(nil, "OVERLAY", nil, 7)
    gcdSpark:SetPoint("CENTER", gcdBar, "RIGHT", 0, 0)
    gcdSpark:SetColorTexture(0, 0, 0, 1) -- Solid black
    -- Remove the spark texture and blend mode to make it a solid line
    gcdSpark:SetTexture(nil)
    gcdSpark:SetBlendMode("BLEND")
    frame.gcdSpark = gcdSpark

    -- Add LB icon spark for weaveBar
    local lbIcon = "Interface\\Icons\\Spell_Nature_Lightning"
    if NAG.Spell and NAG.Spell[403] and NAG.Spell[403].icon then
        lbIcon = NAG.Spell[403].icon
    end
    -- Create frame for weave spark
    local weaveSparkFrame = CreateFrame("Frame", nil, frame)
    weaveSparkFrame:SetSize(16, 16)
    weaveSparkFrame.defaultWidth = 16
    weaveSparkFrame.defaultHeight = 16
    local weaveSpark = weaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    weaveSpark:SetAllPoints()
    weaveSpark:SetTexture(lbIcon)
    weaveSpark:SetTexCoord(0.15, 0.85, 0.15, 0.85) -- 30% zoom (crop 15% each side)
    -- Create mask for circular shape
    local weaveSparkMask = weaveSparkFrame:CreateMaskTexture()
    weaveSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
        "CLAMPTOBLACKADDITIVE")
    weaveSparkMask:SetAllPoints()
    weaveSpark:AddMaskTexture(weaveSparkMask)
    weaveSparkFrame.icon = weaveSpark
    weaveSparkFrame.iconMask = weaveSparkMask
    local weaveFallback = weaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 4)
    weaveFallback:SetColorTexture(1, 1, 1, 1)
    weaveFallback:Hide()
    weaveSparkFrame.line = weaveFallback
    weaveSparkFrame.spellId = LIGHTNING_BOLT_ID
    local weaveKeybindText = weaveSparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    weaveKeybindText:SetPoint("BOTTOM", weaveSparkFrame, "TOP", 0, 2)
    weaveKeybindText:SetJustifyH("CENTER")
    weaveKeybindText:SetTextColor(1, 1, 0)
    weaveKeybindText:SetText("")
    weaveKeybindText:Hide()
    weaveSparkFrame.keybindText = weaveKeybindText
    weaveSparkFrame:Hide()
    frame.weaveSpark = weaveSparkFrame

    -- Add CL icon spark for clWeaveBar
    local clIcon = "Interface\\Icons\\Spell_Nature_ChainLightning"
    if NAG.Spell and NAG.Spell[421] and NAG.Spell[421].icon then
        clIcon = NAG.Spell[421].icon
    end
    -- Create frame for CL weave spark
    local clWeaveSparkFrame = CreateFrame("Frame", nil, frame)
    clWeaveSparkFrame:SetSize(16, 16)
    clWeaveSparkFrame.defaultWidth = 16
    clWeaveSparkFrame.defaultHeight = 16
    local clWeaveSpark = clWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 2)
    clWeaveSpark:SetAllPoints()
    clWeaveSpark:SetTexture(clIcon)
    clWeaveSpark:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    -- Create mask for circular shape
    local clWeaveSparkMask = clWeaveSparkFrame:CreateMaskTexture()
    clWeaveSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
        "CLAMPTOBLACKADDITIVE")
    clWeaveSparkMask:SetAllPoints()
    clWeaveSpark:AddMaskTexture(clWeaveSparkMask)
    clWeaveSparkFrame.icon = clWeaveSpark
    clWeaveSparkFrame.iconMask = clWeaveSparkMask
    local clFallback = clWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    clFallback:SetColorTexture(1, 1, 1, 1)
    clFallback:Hide()
    clWeaveSparkFrame.line = clFallback
    clWeaveSparkFrame.spellId = CHAIN_LIGHTNING_ID
    local clKeybindText = clWeaveSparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    clKeybindText:SetPoint("BOTTOM", clWeaveSparkFrame, "TOP", 0, 2)
    clKeybindText:SetJustifyH("CENTER")
    clKeybindText:SetTextColor(1, 1, 0)
    clKeybindText:SetText("")
    clKeybindText:Hide()
    clWeaveSparkFrame.keybindText = clKeybindText
    clWeaveSparkFrame:Hide()
    frame.clWeaveSpark = clWeaveSparkFrame

    -- Create upcoming weave gap bar (drawn above red bar, same sublayer as weave bar)
    local upcomingWeaveBar = frame:CreateTexture(nil, "ARTWORK", nil, 2)
    upcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    upcomingWeaveBar:SetWidth(0)
    upcomingWeaveBar:SetColorTexture(0.4, 0.7, 1, 0.8) -- Light blue
    frame.upcomingWeaveBar = upcomingWeaveBar

    -- Create CL upcoming weave gap bar (drawn below LB bar)
    local clUpcomingWeaveBar = frame:CreateTexture(nil, "ARTWORK", nil, 1)
    clUpcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    clUpcomingWeaveBar:SetWidth(0)
    clUpcomingWeaveBar:SetColorTexture(0.2, 0.4, 0.8, 0.8) -- Darker blue
    frame.clUpcomingWeaveBar = clUpcomingWeaveBar

    -- Add LB icon spark for upcomingWeaveBar
    local lbIcon2 = "Interface\\Icons\\Spell_Nature_Lightning"
    if NAG.Spell and NAG.Spell[403] and NAG.Spell[403].icon then
        lbIcon2 = NAG.Spell[403].icon
    end
    -- Create frame for upcoming weave spark
    local upcomingWeaveSparkFrame = CreateFrame("Frame", nil, frame)
    upcomingWeaveSparkFrame:SetSize(16, 16)
    upcomingWeaveSparkFrame.defaultWidth = 16
    upcomingWeaveSparkFrame.defaultHeight = 16
    local upcomingWeaveSpark = upcomingWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    upcomingWeaveSpark:SetAllPoints()
    upcomingWeaveSpark:SetTexture(lbIcon2)
    upcomingWeaveSpark:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    -- Create mask for circular shape
    local upcomingWeaveSparkMask = upcomingWeaveSparkFrame:CreateMaskTexture()
    upcomingWeaveSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
        "CLAMPTOBLACKADDITIVE")
    upcomingWeaveSparkMask:SetAllPoints()
    upcomingWeaveSpark:AddMaskTexture(upcomingWeaveSparkMask)
    upcomingWeaveSparkFrame.icon = upcomingWeaveSpark
    upcomingWeaveSparkFrame.iconMask = upcomingWeaveSparkMask
    local upcomingFallback = upcomingWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 4)
    upcomingFallback:SetColorTexture(1, 1, 1, 1)
    upcomingFallback:Hide()
    upcomingWeaveSparkFrame.line = upcomingFallback
    upcomingWeaveSparkFrame.spellId = LIGHTNING_BOLT_ID
    local upcomingKeybindText = upcomingWeaveSparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    upcomingKeybindText:SetPoint("BOTTOM", upcomingWeaveSparkFrame, "TOP", 0, 2)
    upcomingKeybindText:SetJustifyH("CENTER")
    upcomingKeybindText:SetTextColor(1, 1, 0)
    upcomingKeybindText:SetText("")
    upcomingKeybindText:Hide()
    upcomingWeaveSparkFrame.keybindText = upcomingKeybindText
    upcomingWeaveSparkFrame:Hide()
    frame.upcomingWeaveSpark = upcomingWeaveSparkFrame

    -- Add CL icon spark for clUpcomingWeaveBar
    local clIcon2 = "Interface\\Icons\\Spell_Nature_ChainLightning"
    if NAG.Spell and NAG.Spell[421] and NAG.Spell[421].icon then
        clIcon2 = NAG.Spell[421].icon
    end
    -- Create frame for CL upcoming weave spark
    local clUpcomingWeaveSparkFrame = CreateFrame("Frame", nil, frame)
    clUpcomingWeaveSparkFrame:SetSize(16, 16)
    clUpcomingWeaveSparkFrame.defaultWidth = 16
    clUpcomingWeaveSparkFrame.defaultHeight = 16
    local clUpcomingWeaveSpark = clUpcomingWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 2)
    clUpcomingWeaveSpark:SetAllPoints()
    clUpcomingWeaveSpark:SetTexture(clIcon2)
    clUpcomingWeaveSpark:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    -- Create mask for circular shape
    local clUpcomingWeaveSparkMask = clUpcomingWeaveSparkFrame:CreateMaskTexture()
    clUpcomingWeaveSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
        "CLAMPTOBLACKADDITIVE")
    clUpcomingWeaveSparkMask:SetAllPoints()
    clUpcomingWeaveSpark:AddMaskTexture(clUpcomingWeaveSparkMask)
    clUpcomingWeaveSparkFrame.icon = clUpcomingWeaveSpark
    clUpcomingWeaveSparkFrame.iconMask = clUpcomingWeaveSparkMask
    local clUpcomingFallback = clUpcomingWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    clUpcomingFallback:SetColorTexture(1, 1, 1, 1)
    clUpcomingFallback:Hide()
    clUpcomingWeaveSparkFrame.line = clUpcomingFallback
    clUpcomingWeaveSparkFrame.spellId = CHAIN_LIGHTNING_ID
    local clUpcomingKeybindText = clUpcomingWeaveSparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    clUpcomingKeybindText:SetPoint("BOTTOM", clUpcomingWeaveSparkFrame, "TOP", 0, 2)
    clUpcomingKeybindText:SetJustifyH("CENTER")
    clUpcomingKeybindText:SetTextColor(1, 1, 0)
    clUpcomingKeybindText:SetText("")
    clUpcomingKeybindText:Hide()
    clUpcomingWeaveSparkFrame.keybindText = clUpcomingKeybindText
    clUpcomingWeaveSparkFrame:Hide()
    frame.clUpcomingWeaveSpark = clUpcomingWeaveSparkFrame

    -- Create current swing timer bar frame
    local swingFrame = CreateFrame("Frame", nil, frame)
    swingFrame:SetAllPoints()
    frame.swingFrame = swingFrame

    -- Create current swing timer bar (fully transparent)
    local swingBar = swingFrame:CreateTexture(nil, "ARTWORK")
    swingBar:SetPoint("LEFT", swingFrame, "LEFT", 0, 0)
    swingBar:SetWidth(0)
    swingBar:SetColorTexture(0, 0, 0, 0) -- Fully transparent
    frame.swingBar = swingBar

    -- Create current swing spark texture
    local spark = swingFrame:CreateTexture(nil, "OVERLAY")
    spark:SetPoint("CENTER", swingBar, "RIGHT", 0, 1)
    spark:SetColorTexture(
        self.db.class.bar.swingTimer.sparkColor.r,
        self.db.class.bar.swingTimer.sparkColor.g,
        self.db.class.bar.swingTimer.sparkColor.b,
        self.db.class.bar.swingTimer.sparkColor.a
    )
    -- Remove the spark texture and blend mode to make it a solid line
    spark:SetTexture(nil)
    spark:SetBlendMode("BLEND")
    frame.spark = spark

    -- Create EB weave bar (light purple)
    local ebWeaveBar = frame:CreateTexture(nil, "ARTWORK", nil, -6)
    ebWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    ebWeaveBar:SetWidth(0)
    ebWeaveBar:SetColorTexture(0.7, 0.5, 1, 0.8)
    frame.ebWeaveBar = ebWeaveBar

    -- Create EB upcoming weave bar (light purple)
    local ebUpcomingWeaveBar = frame:CreateTexture(nil, "ARTWORK", nil, -5)
    ebUpcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, 0)
    ebUpcomingWeaveBar:SetWidth(0)
    ebUpcomingWeaveBar:SetColorTexture(0.7, 0.5, 1, 0.8)
    frame.ebUpcomingWeaveBar = ebUpcomingWeaveBar

    -- Add EB icon spark for ebWeaveBar
    local ebIcon = "Interface\\Icons\\shaman_talent_elementalblast" -- Blizzard's icon name for Elemental Blast
    if NAG.Spell and NAG.Spell[117014] and NAG.Spell[117014].icon then
        ebIcon = NAG.Spell[117014].icon
    end
    local ebWeaveSparkFrame = CreateFrame("Frame", nil, frame)
    ebWeaveSparkFrame:SetSize(16, 16)
    ebWeaveSparkFrame.defaultWidth = 16
    ebWeaveSparkFrame.defaultHeight = 16
    local ebWeaveSpark = ebWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 2)
    ebWeaveSpark:SetAllPoints()
    ebWeaveSpark:SetTexture(ebIcon)
    ebWeaveSpark:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    local ebWeaveSparkMask = ebWeaveSparkFrame:CreateMaskTexture()
    ebWeaveSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
        "CLAMPTOBLACKADDITIVE")
    ebWeaveSparkMask:SetAllPoints()
    ebWeaveSpark:AddMaskTexture(ebWeaveSparkMask)
    ebWeaveSparkFrame.icon = ebWeaveSpark
    ebWeaveSparkFrame.iconMask = ebWeaveSparkMask
    local ebFallback = ebWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    ebFallback:SetColorTexture(1, 1, 1, 1)
    ebFallback:Hide()
    ebWeaveSparkFrame.line = ebFallback
    ebWeaveSparkFrame.spellId = 117014
    local ebKeybindText = ebWeaveSparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    ebKeybindText:SetPoint("BOTTOM", ebWeaveSparkFrame, "TOP", 0, 2)
    ebKeybindText:SetJustifyH("CENTER")
    ebKeybindText:SetTextColor(1, 1, 0)
    ebKeybindText:SetText("")
    ebKeybindText:Hide()
    ebWeaveSparkFrame.keybindText = ebKeybindText
    ebWeaveSparkFrame:Hide()
    frame.ebWeaveSpark = ebWeaveSparkFrame

    -- Add EB icon spark for ebUpcomingWeaveBar
    local ebUpcomingWeaveSparkFrame = CreateFrame("Frame", nil, frame)
    ebUpcomingWeaveSparkFrame:SetSize(16, 16)
    ebUpcomingWeaveSparkFrame.defaultWidth = 16
    ebUpcomingWeaveSparkFrame.defaultHeight = 16
    local ebUpcomingWeaveSpark = ebUpcomingWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 2)
    ebUpcomingWeaveSpark:SetAllPoints()
    ebUpcomingWeaveSpark:SetTexture(ebIcon)
    ebUpcomingWeaveSpark:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    local ebUpcomingWeaveSparkMask = ebUpcomingWeaveSparkFrame:CreateMaskTexture()
    ebUpcomingWeaveSparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
        "CLAMPTOBLACKADDITIVE")
    ebUpcomingWeaveSparkMask:SetAllPoints()
    ebUpcomingWeaveSpark:AddMaskTexture(ebUpcomingWeaveSparkMask)
    ebUpcomingWeaveSparkFrame.icon = ebUpcomingWeaveSpark
    ebUpcomingWeaveSparkFrame.iconMask = ebUpcomingWeaveSparkMask
    local ebUpcomingFallback = ebUpcomingWeaveSparkFrame:CreateTexture(nil, "OVERLAY", nil, 3)
    ebUpcomingFallback:SetColorTexture(1, 1, 1, 1)
    ebUpcomingFallback:Hide()
    ebUpcomingWeaveSparkFrame.line = ebUpcomingFallback
    ebUpcomingWeaveSparkFrame.spellId = 117014
    local ebUpcomingKeybindText = ebUpcomingWeaveSparkFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    ebUpcomingKeybindText:SetPoint("BOTTOM", ebUpcomingWeaveSparkFrame, "TOP", 0, 2)
    ebUpcomingKeybindText:SetJustifyH("CENTER")
    ebUpcomingKeybindText:SetTextColor(1, 1, 0)
    ebUpcomingKeybindText:SetText("")
    ebUpcomingKeybindText:Hide()
    ebUpcomingWeaveSparkFrame.keybindText = ebUpcomingKeybindText
    ebUpcomingWeaveSparkFrame:Hide()
    frame.ebUpcomingWeaveSpark = ebUpcomingWeaveSparkFrame

    -- Create Spell CD Bar frame (positioned above the main weave bar)
    local spellCDBarFrame = CreateFrame("Frame", nil, frame)
    spellCDBarFrame:SetSize(self.db.class.bar.width, self.db.class.bar.height)
    spellCDBarFrame:SetPoint("BOTTOM", frame, "TOP", 0, 0)
    spellCDBarFrame:Hide() -- Hidden by default, only shown when preset layout is enabled
    frame.spellCDBarFrame = spellCDBarFrame

    -- Create Spell CD Bar sparks for each tracked spell
    frame.spellCDSparks = {}
    for i, spellId in ipairs(SPELL_CD_BAR_SPELLS) do
        -- Get spell icon using GetSpellTexture for better compatibility
        local spellIcon = GetSpellTexture(spellId) or "Interface\\Icons\\INV_Misc_QuestionMark"

        -- Create spark frame for this spell
        local sparkFrame = CreateFrame("Frame", nil, spellCDBarFrame)
        sparkFrame:SetSize(16, 16)
        sparkFrame.defaultWidth = 16
        sparkFrame.defaultHeight = 16
        sparkFrame.spellId = spellId -- Store spell ID for reference

        -- Create spark texture
        local spark = sparkFrame:CreateTexture(nil, "OVERLAY", nil, 1)
        spark:SetAllPoints()
        spark:SetTexture(spellIcon)
        spark:SetTexCoord(0.15, 0.85, 0.15, 0.85) -- 30% zoom (crop 15% each side)

        -- Create mask for circular shape (same as LB/CL/EB sparks)
        local sparkMask = sparkFrame:CreateMaskTexture()
        sparkMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
            "CLAMPTOBLACKADDITIVE")
        sparkMask:SetAllPoints()
        spark:AddMaskTexture(sparkMask)
        sparkFrame.icon = spark
        sparkFrame.iconMask = sparkMask
        local sparkFallback = sparkFrame:CreateTexture(nil, "OVERLAY", nil, 2)
        sparkFallback:SetColorTexture(1, 1, 1, 1)
        sparkFallback:Hide()
        sparkFrame.line = sparkFallback

        sparkFrame:Hide() -- Hidden by default
        frame.spellCDSparks[i] = sparkFrame
    end

    -- Set up dragging for the main frame
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")

    -- Make all child frames pass mouse events to parent
    local function makeFrameDraggable(childFrame)
        if childFrame:GetObjectType() == "Frame" then
            childFrame:EnableMouse(true)
            childFrame:RegisterForDrag("LeftButton")
            childFrame:SetScript("OnDragStart", function()
                local canDrag = NAG.IsAnyEditMode and NAG:IsAnyEditMode()
                if canDrag and not UnitAffectingCombat("player") then
                    frame:StartMoving()
                    isDragging = true
                end
            end)
            childFrame:SetScript("OnDragStop", function()
                if isDragging then
                    frame:StopMovingOrSizing()
                    isDragging = false

                    local left, bottom = frame:GetLeft(), frame:GetBottom()
                    if left and bottom then
                        frame:SetParent(UIParent)
                        frame:ClearAllPoints()
                        frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left, bottom)
                    end
                    local point, _, _, x, y = frame:GetPoint(1)
                    self.db.class.bar.point = point
                    self.db.class.bar.x = x
                    self.db.class.bar.y = y
                end
            end)
        end
    end

    -- Apply dragging to all child frames
    makeFrameDraggable(swingFrame)
    makeFrameDraggable(swingBgBar)
    makeFrameDraggable(spellCDBarFrame)

    -- Set up main frame drag handlers
    frame:SetScript("OnDragStart", function()
        local canDrag = NAG.IsAnyEditMode and NAG:IsAnyEditMode()
        if canDrag and not UnitAffectingCombat("player") then
            frame:StartMoving()
            isDragging = true
        end
    end)

    frame:SetScript("OnDragStop", function()
        if isDragging then
            frame:StopMovingOrSizing()
            isDragging = false

            local left, bottom = frame:GetLeft(), frame:GetBottom()
            if left and bottom then
                frame:SetParent(UIParent)
                frame:ClearAllPoints()
                frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", left, bottom)
            end
            local point, _, _, x, y = frame:GetPoint(1)
            self.db.class.bar.point = point
            self.db.class.bar.x = x
            self.db.class.bar.y = y
        end
    end)

    -- Apply initial settings
    self:UpdateFrameSettings()
end

function ShamanWeaveBar:GetBackgroundTexturePath(style)
    if style == "Simpler" then
        return "Interface\\AddOns\\NAG\\Media\\ShamanWeaver\\weaverbgSimpler.png"
    else
        return "Interface\\AddOns\\NAG\\Media\\ShamanWeaver\\weaverbg.png"
    end
end

--- Effective scale for Shaman bar frame: NAG display scale * universal Shaman bar scale.
local function GetShamanBarEffectiveScale()
    local nagFrame = NAG:GetDisplayAnchor()
    local nagScale = (nagFrame and nagFrame ~= UIParent and nagFrame:GetScale()) or 1
    local sm = NAG:GetModule("ShamanWeaveModule", true)
    local barScale = (sm and sm.GetShamanBarScale and sm:GetShamanBarScale()) or 1
    return nagScale * barScale
end

function ShamanWeaveBar:UpdateFrameAnchor()
    if not frame or not autoAnchorEnabled then return end

    -- Get the correct NAG display frame (handles both legacy and group display modes)
    local nagFrame = NAG:GetDisplayAnchor()
    if not nagFrame or nagFrame == UIParent then
        self:Debug("UpdateFrameAnchor: No valid NAG display frame found")
        return
    end

    -- Get the scale of the main NAG frame
    local nagScale = nagFrame:GetScale() or 1

    -- Add user-configurable offsets from presetLayout
    local preset = self.db.class.presetLayout
    local userX = preset.x or 0
    local userY = preset.y or 0

    -- Fine-tune positioning offsets (adjusted for direct frame anchoring)
    local offsetX = 0 -- Adjust horizontal position
    local offsetY = 8   -- Adjust vertical position

    -- Keep on UIParent so we don't affect the main frame (e.g. floating selector position)
    frame:SetParent(UIParent)
    frame:ClearAllPoints()
    frame:SetPoint("BOTTOMLEFT", nagFrame, "BOTTOMRIGHT", offsetX + userX, offsetY + userY)

    -- Apply NAG scale and universal Shaman bar scale
    frame:SetScale(GetShamanBarEffectiveScale())

    self:Debug("UpdateFrameAnchor: Anchored to %s with offset x=%.1f, y=%.1f, scale=%.2f",
        nagFrame:GetName() or "unknown frame", offsetX + userX, offsetY + userY, GetShamanBarEffectiveScale())
end

function ShamanWeaveBar:UpdateFrameSettings()
    if not frame then return end

    -- Check if preset layout is enabled
    local usePresetLayout = self.db.class.presetLayout.enabled

    -- Choose which settings to use
    local settings
    if usePresetLayout then
        settings = self.db.class.presetLayout
    else
        settings = self.db.class.bar
    end

    local showSparkIcons = usePresetLayout or (self.db.class.bar.showSparkIcons ~= false)
    sparkIconsEnabled = showSparkIcons

    local showSparkIcons = usePresetLayout or (self.db.class.bar.showSparkIcons ~= false)
    sparkIconsEnabled = showSparkIcons

    -- Update size
    frame:SetSize(settings.width, settings.height)

    -- Update position - use automatic anchoring for preset layout
    if usePresetLayout and autoAnchorEnabled then
        self:UpdateFrameAnchor()
    else
        -- Use manual positioning for regular layout; parent to UIParent so coords are consistent
        frame:SetParent(UIParent)
        frame:ClearAllPoints()
        frame:SetPoint(settings.point, settings.x, settings.y)

        -- Apply NAG scale and universal Shaman bar scale
        frame:SetScale(GetShamanBarEffectiveScale())
    end

    -- Update alpha
    frame:SetAlpha(settings.alpha)
    frame:EnableMouse(NAG.IsAnyEditMode and NAG:IsAnyEditMode())

    -- Update bar heights and vertical positions
    local barHeight = settings.height
    local lbBarHeight = barHeight * (settings.lbBarHeightPct or 0.15)
    local clBarHeight = barHeight * (settings.clBarHeightPct or 0.15)
    local ebBarHeight = barHeight * (settings.ebBarHeightPct or 0.15)

    -- Proportional offsets for stacking, with clamping to fit inside the main bar
    local halfBarHeight = barHeight / 2

    -- Calculate Y offset for the bottom bar (LB)
    -- Start with a -25% offset and clamp it so the bar stays within the bottom half.
    local desiredLbYOffset = -barHeight * 0.25
    local minLbYOffset = -halfBarHeight + (lbBarHeight / 2)
    local lbBarYOffset = math.max(desiredLbYOffset, minLbYOffset)

    -- Calculate Y offset for the top bars (CL & EB)
    -- Start with a +25% offset and clamp it so the bars stay within the top half.
    local desiredClYOffset = barHeight * 0.25
    local maxClYOffset = halfBarHeight - (clBarHeight / 2)
    local clBarYOffset = math.min(desiredClYOffset, maxClYOffset)

    local desiredEbYOffset = barHeight * 0.25
    local maxEbYOffset = halfBarHeight - (ebBarHeight / 2)
    local ebBarYOffset = math.min(desiredEbYOffset, maxEbYOffset)

    frame.weaveBar:SetHeight(lbBarHeight)
    frame.weaveBar:ClearAllPoints()
    frame.weaveBar:SetPoint("LEFT", frame, "LEFT", 0, lbBarYOffset)

    frame.clWeaveBar:SetHeight(clBarHeight)
    frame.clWeaveBar:ClearAllPoints()
    frame.clWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, clBarYOffset)

    frame.ebWeaveBar:SetHeight(ebBarHeight)
    frame.ebWeaveBar:ClearAllPoints()
    frame.ebWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, ebBarYOffset)

    frame.upcomingWeaveBar:SetHeight(lbBarHeight)
    frame.upcomingWeaveBar:ClearAllPoints()
    frame.upcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, lbBarYOffset)

    frame.clUpcomingWeaveBar:SetHeight(clBarHeight)
    frame.clUpcomingWeaveBar:ClearAllPoints()
    frame.clUpcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, clBarYOffset)

    frame.ebUpcomingWeaveBar:SetHeight(ebBarHeight)
    frame.ebUpcomingWeaveBar:ClearAllPoints()
    frame.ebUpcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", 0, ebBarYOffset)

    frame.countdownBar:SetHeight(barHeight)
    frame.countdownBar:ClearAllPoints()
    frame.countdownBar:SetPoint("LEFT", frame, "LEFT", 0, 0)

    frame.gcdBar:SetHeight(barHeight)
    frame.gcdBar:ClearAllPoints()
    frame.gcdBar:SetPoint("LEFT", frame, "LEFT", 0, 0)

    -- Update preset layout background
    if frame.presetBgTexture then
        if usePresetLayout and settings.background.enabled then
            -- Get the texture path based on selected style
            local texturePath = self:GetBackgroundTexturePath(settings.background.style or "Extended")
            frame.presetBgTexture:SetTexture(texturePath)
            frame.presetBgTexture:Show()
            frame.presetBgTexture:SetSize(settings.background.width * settings.background.scale,
                settings.background.height * settings.background.scale)
            frame.presetBgTexture:ClearAllPoints()
            frame.presetBgTexture:SetPoint("CENTER", frame, "CENTER", settings.background.xOffset,
                settings.background.yOffset)
            frame.presetBgTexture:SetAlpha(settings.background.alpha)
        else
            frame.presetBgTexture:Hide()
        end
    end

    -- Update regular background (only if preset layout is disabled)
    local barWidth = settings.width
    local bgFile = self.db.class.bar.background
    local bgPath = nil
    if bgFile == "bg2" then
        bgPath = "Interface\\AddOns\\NAG\\Media\\ShamanWeaver\\bg2.png"
    elseif bgFile == "bg3" then
        bgPath = "Interface\\AddOns\\NAG\\Media\\ShamanWeaver\\bg3.png"
    elseif bgFile == "bg4" then
        bgPath = "Interface\\AddOns\\NAG\\Media\\ShamanWeaver\\bg4.png"
    end
    if frame.bgTexture then
        if bgPath and not usePresetLayout then
            frame.bgTexture:SetTexture(bgPath)
            frame.bgTexture:Show()
        else
            frame.bgTexture:SetTexture(nil)
            frame.bgTexture:Hide()
        end
        frame.bgTexture:SetSize(barWidth * 1.45, barHeight * (self.db.class.bar.borderArtHeightPct or 1.7))
        frame.bgTexture:ClearAllPoints()
        frame.bgTexture:SetPoint("CENTER", frame, "CENTER", 0, 0)
        local bgColor = self.db.class.bar.bgColor or { r = 1, g = 1, b = 1, a = 1 }
        frame.bgTexture:SetVertexColor(bgColor.r, bgColor.g, bgColor.b, bgColor.a)
    end

    -- Update weave bar color
    local colors = settings.colors
    frame.weaveBar:SetColorTexture(colors.weave.r, colors.weave.g, colors.weave.b, colors.weave.a)
    frame.clWeaveBar:SetColorTexture(colors.clweave.r, colors.clweave.g, colors.clweave.b, colors.clweave.a)
    frame.upcomingWeaveBar:SetColorTexture(colors.upcomingweave.r, colors.upcomingweave.g, colors.upcomingweave.b,
        colors.upcomingweave.a)
    frame.clUpcomingWeaveBar:SetColorTexture(colors.clupcomingweave.r, colors.clupcomingweave.g, colors.clupcomingweave
        .b, colors.clupcomingweave.a)

    -- Update countdown bar color
    frame.countdownBar:SetColorTexture(colors.countdown.r, colors.countdown.g, colors.countdown.b, colors.countdown.a)

    -- Update GCD bar color
    frame.gcdBar:SetColorTexture(colors.gcd.r, colors.gcd.g, colors.gcd.b, colors.gcd.a)

    -- Update GCD spark
    if frame.gcdSpark then
        frame.gcdSpark:SetSize(settings.swingTimer.sparkWidth + 2, barHeight)
        frame.gcdSpark:SetColorTexture(0, 0, 0, 1)
    end

    -- Update swing timer settings
    if frame.swingFrame then
        frame.swingBar:SetHeight(barHeight)
        frame.spark:SetSize(settings.swingTimer.sparkWidth, barHeight)

        -- Handle sparkColor which can be false or a color table
        if settings.swingTimer.sparkColor and type(settings.swingTimer.sparkColor) == "table" then
            frame.spark:SetColorTexture(
                settings.swingTimer.sparkColor.r,
                settings.swingTimer.sparkColor.g,
                settings.swingTimer.sparkColor.b,
                settings.swingTimer.sparkColor.a
            )
        else
            -- Use default color when sparkColor is false or invalid
            frame.spark:SetColorTexture(0.8, 0.8, 0.8, 1)
        end

        -- Update swing timer background settings
        if frame.swingBgBar then
            frame.swingBgBar:SetWidth(barWidth)
            frame.swingBgBar:SetHeight(barHeight)
            -- Handle background bar settings for both regular and preset layouts
            if usePresetLayout then
                -- Preset layout doesn't use background bar, so hide it
                frame.swingBgBar:Hide()
            else
                -- Regular layout uses background bar settings
                local backgroundBar = settings.swingTimer.backgroundBar
                if backgroundBar then
                    frame.swingBgBar:SetColorTexture(0, 0, 0, backgroundBar.alpha)
                    if backgroundBar.enabled then
                        frame.swingBgBar:Show()
                    else
                        frame.swingBgBar:Hide()
                    end
                else
                    frame.swingBgBar:Hide()
                end
            end
        end
    end

    -- Update Spell CD Bar frame settings
    if frame.spellCDBarFrame then
        if usePresetLayout and settings.spellCDBar and settings.spellCDBar.enabled then
            -- Show and position the Spell CD Bar frame
            frame.spellCDBarFrame:Show()
            frame.spellCDBarFrame:SetSize(settings.width, settings.height)
            frame.spellCDBarFrame:ClearAllPoints()
            frame.spellCDBarFrame:SetPoint("BOTTOM", frame, "TOP", 0, settings.spellCDBar.yOffset or 0)
        else
            -- Hide the Spell CD Bar frame
            frame.spellCDBarFrame:Hide()
        end
    end

    if not showSparkIcons then
        HideAllSparkFrames()
    end
end

function ShamanWeaveBar:UpdateVisibility()
    if not frame then return end

    -- In edit mode: force visible for positioning - check FIRST so bars stay visible when unlocked
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        frame:SetFrameStrata("DIALOG")
        frame:SetFrameLevel(200)
        frame:Show()
        if frame.spellCDBarFrame then
            frame.spellCDBarFrame:SetFrameStrata("DIALOG")
            frame.spellCDBarFrame:SetFrameLevel(201)
            frame.spellCDBarFrame:Show()
        end
        return
    end

    if not self.isEnhancementSpec then
        frame:Hide()
        if frame.spellCDBarFrame then
            frame.spellCDBarFrame:Hide()
        end
        return
    end

    -- If in positioning mode, always show
    if isPositioning then
        frame:Show()
        if frame.spellCDBarFrame then
            frame.spellCDBarFrame:Show()
        end
        return
    end

    -- First check if the bar should be shown at all
    if not self.db.class.showBar then
        frame:Hide()
        if frame.spellCDBarFrame then
            frame.spellCDBarFrame:Hide()
        end
        return
    end

    -- Then check combat state if hideOutOfCombat is enabled
    if self.db.class.hideOutOfCombat and not UnitAffectingCombat("player") then
        frame:Hide()
        if frame.spellCDBarFrame then
            frame.spellCDBarFrame:Hide()
        end
    else
        local level = DisplayManager and DisplayManager.GetRecommendedClassBarFrameLevel and DisplayManager:GetRecommendedClassBarFrameLevel() or 50
        frame:SetFrameStrata("MEDIUM")
        frame:SetFrameLevel(level)
        frame:Show()
        -- Only show Spell CD Bar if preset layout and spellCDBar are enabled
        if frame.spellCDBarFrame then
            if self.db.class.presetLayout.enabled and self.db.class.presetLayout.spellCDBar.enabled then
                frame.spellCDBarFrame:Show()
            else
                frame.spellCDBarFrame:Hide()
            end
        end
    end
end

function ShamanWeaveBar:ShouldUseChainLightning()
    -- Only check in combat and with a target
    if not UnitAffectingCombat("player") or not UnitExists("target") then
        return false
    end

    -- Count enemies in range (using 10 yards as default range for Chain Lightning)
    local enemies = NAG:CountEnemiesInRange(10)

    -- Get weapon speed and cast times (Maelstrom-adjusted)
    local weaponSpeed = NAG:AutoSwingTime(NAG.Types:GetType("SwingType").MainHand)
    local maelstromStacks = NAG:AuraNumStacks(51530) -- Maelstrom Weapon spell ID
    local lbCastTime = GetMaelstromAdjustedCastTime(LIGHTNING_BOLT_ID, NAG:SpellCastTime(LIGHTNING_BOLT_ID), maelstromStacks)
    local clCastTime = GetMaelstromAdjustedCastTime(CHAIN_LIGHTNING_ID, NAG:SpellCastTime(CHAIN_LIGHTNING_ID), maelstromStacks)

    -- Check if we should use CL based on enemy count
    local shouldUseCLForEnemies = enemies >= MIN_ENEMIES_FOR_CL

    -- Check if we should use CL based on cast times
    local shouldUseCLForCastTime = lbCastTime + 0.1 > weaponSpeed and clCastTime < weaponSpeed

    -- Return true if either condition is met
    return shouldUseCLForEnemies or shouldUseCLForCastTime
end

local function PositionBarSpark(bar, spark, alignTop, alignBottom)
    if not bar or not spark then return end
    if bar:IsShown() and bar:GetWidth() > 0 then
        local left = bar:GetLeft()
        local top = bar:GetTop()
        local bottom = bar:GetBottom()
        if left and top and bottom then
            local barHeight = bar:GetHeight() or 0
            if spark.icon and spark.line then
                if sparkIconsEnabled then
                    spark:SetSize(spark.defaultWidth or 16, spark.defaultHeight or 16)
                    spark.icon:Show()
                    spark.line:Hide()
                else
                    spark:SetWidth(2)
                    spark:SetHeight(barHeight)
                    spark.icon:Hide()
                    spark.line:SetAllPoints()
                    spark.line:Show()
                end
            end
            local sparkWidth = spark:GetWidth() or 16
            local sparkHeight = spark:GetHeight() or 16
            -- Position spark centered at the end of the bar (not extending past it)
            local sparkX = left + bar:GetWidth() - sparkWidth / 2
            local sparkY
            if sparkIconsEnabled then
                if alignTop then
                    sparkY = top
                elseif alignBottom then
                    sparkY = bottom - (sparkHeight / 2)
                else
                    local barCenterY = (top + bottom) / 2
                    sparkY = barCenterY - (sparkHeight / 2)
                end
            else
                local barCenterY = (top + bottom) / 2
                sparkY = barCenterY
            end
            spark:ClearAllPoints()
            spark:SetPoint("LEFT", UIParent, "BOTTOMLEFT", sparkX, sparkY)
            spark:Show()
            return
        end
    end
    spark:Hide()
end

function ShamanWeaveBar:UpdateDisplay()
    if not self.isEnhancementSpec then
        return
    end
    if not frame or isDragging or not self.db.class.showBar then return end

    -- Choose which settings to use
    local usePresetLayout = self.db.class.presetLayout.enabled
    local settings
    if usePresetLayout then
        settings = self.db.class.presetLayout
    else
        settings = self.db.class.bar
    end

    -- Recalculate proportional Y offsets with clamping
    local barHeight = settings.height
    local lbBarHeight = barHeight * (settings.lbBarHeightPct or 0.15)
    local clBarHeight = barHeight * (settings.clBarHeightPct or 0.15)
    local ebBarHeight = barHeight * (settings.ebBarHeightPct or 0.15)
    local halfBarHeight = barHeight / 2

    local desiredLbYOffset = -barHeight * 0.25
    local minLbYOffset = -halfBarHeight + (lbBarHeight / 2)
    local lbBarYOffset = math.max(desiredLbYOffset, minLbYOffset)

    local desiredClYOffset = barHeight * 0.25
    local maxClYOffset = halfBarHeight - (clBarHeight / 2)
    local clBarYOffset = math.min(desiredClYOffset, maxClYOffset)

    local desiredEbYOffset = barHeight * 0.25
    local maxEbYOffset = halfBarHeight - (ebBarHeight / 2)
    local ebBarYOffset = math.min(desiredEbYOffset, maxEbYOffset)

    -- Handle out of combat/no target state
    if not UnitAffectingCombat("player") or not UnitExists("target") or not self.db.class.showBar then
        frame.weaveBar:SetWidth(0)
        frame.clWeaveBar:SetWidth(0)
        frame.upcomingWeaveBar:SetWidth(0)
        frame.clUpcomingWeaveBar:SetWidth(0)
        frame.countdownBar:SetWidth(0)
        frame.gcdBar:SetWidth(0)
        frame.gcdSpark:Hide()
        frame.swingBar:SetWidth(0)
        frame.spark:Hide()
        -- Hide all sparks
        SetSparkKeybind(frame.weaveSpark, false)
        frame.weaveSpark:Hide()
        SetSparkKeybind(frame.clWeaveSpark, false)
        frame.clWeaveSpark:Hide()
        SetSparkKeybind(frame.upcomingWeaveSpark, false)
        frame.upcomingWeaveSpark:Hide()
        SetSparkKeybind(frame.clUpcomingWeaveSpark, false)
        frame.clUpcomingWeaveSpark:Hide()
        SetSparkKeybind(frame.ebWeaveSpark, false)
        frame.ebWeaveSpark:Hide()
        SetSparkKeybind(frame.ebUpcomingWeaveSpark, false)
        frame.ebUpcomingWeaveSpark:Hide()
        -- Hide Spell CD Bar sparks
        if frame.spellCDSparks then
            for i, sparkFrame in ipairs(frame.spellCDSparks) do
                sparkFrame:Hide()
            end
        end
        return
    end

    -- Determine which spell we're using
    local useChainLightning = self:ShouldUseChainLightning()
    local currentSpellId = useChainLightning and CHAIN_LIGHTNING_ID or LIGHTNING_BOLT_ID

    -- Get weave timing information for both spells
    local lbTimeToWeave = NAG:TimeToNextWeaveGap(LIGHTNING_BOLT_ID)
    local clTimeToWeave = NAG:TimeToNextWeaveGap(CHAIN_LIGHTNING_ID)
    local lbCanWeave = NAG:CanWeave(LIGHTNING_BOLT_ID)
    local clCanWeave = NAG:CanWeave(CHAIN_LIGHTNING_ID)

    -- Get timing information (Maelstrom-adjusted)
    local lbCastTime = NAG:SpellCastTime(LIGHTNING_BOLT_ID)
    local clCastTime = NAG:SpellCastTime(CHAIN_LIGHTNING_ID)
    local weaponSpeed = NAG:AutoSwingTime(NAG.Types:GetType("SwingType").MainHand)
    local swingTimeLeft, rawSwingTimeLeft = NAG:AutoTimeToNext()
    local gcd = NAG:GCDTimeToReady() or 0

    -- Calculate bar widths with smooth interpolation only when decreasing
    local maxWidth = frame:GetWidth()

    -- Elemental Blast talent/castability gating
    local ebIsKnown = NAG.IsKnownSpell and NAG:IsKnownSpell(117014) or false
    local ebCanCast = ebIsKnown and (NAG.SpellCanCast and NAG:SpellCanCast(117014) or true) or false

    -- Apply Maelstrom Weapon logic for input delay with latency awareness and fixed buffer
    local userPing = NAG:GetNetStats()               -- Use cached network stats
    local baseInputDelay = NAG:InputDelay() or 0.050 -- fallback to 50ms
    local staticPressBuffer = 0.200                  -- 200ms flat buffer for press-to-cast
    local maelstromStacks = NAG:AuraNumStacks(51530) -- Maelstrom Weapon spell ID

    -- Apply Maelstrom cast-time reduction to weave math (critical for slow weapons).
    lbCastTime = GetMaelstromAdjustedCastTime(LIGHTNING_BOLT_ID, lbCastTime, maelstromStacks)
    clCastTime = GetMaelstromAdjustedCastTime(CHAIN_LIGHTNING_ID, clCastTime, maelstromStacks)

    -- Final delay: input + ping + 200ms fixed buffer
    local adjustedInputDelay = baseInputDelay + userPing + staticPressBuffer
    if maelstromStacks >= 5 then
        adjustedInputDelay = 0                                  -- instant cast, ignore delay
    else
        adjustedInputDelay = math.min(adjustedInputDelay, 0.45) -- cap at 0.45s
    end

    -- Store for debug purposes
    if self.db.class.debugInputDelay ~= nil then
        self.db.class.debugInputDelay = adjustedInputDelay
    end

    -- Store adjusted delay for debug purposes
    if self.db.class.debugAdjustedDelay ~= nil then
        self.db.class.debugAdjustedDelay = adjustedInputDelay
    end

    -- Store network stats for debug purposes
    if self.db.class.debugNetworkStats then
        local netStatsDebug = NAG:GetNetStatsDebug()
        self.db.class.debugNetworkStatsData = {
            currentAverage = netStatsDebug.currentAverage,
            readingsCount = netStatsDebug.readingsCount,
            lastUpdate = netStatsDebug.lastUpdate
        }
    end

    -- Update LB weave bar (light blue) and spark with improved smoothing
    local lbRemainingGapTime = rawSwingTimeLeft - (lbCastTime + adjustedInputDelay)
    local epsilon = 1e-3

    -- Calculate safe gap and visual width with improved smoothing
    local safeGap = rawSwingTimeLeft - lbCastTime
    local visualGap = math.max(0, safeGap - adjustedInputDelay)

    if visualGap > epsilon then
        local swingProgress = visualGap / weaponSpeed
        local targetWidth = maxWidth * swingProgress
        local currentWidth = frame.weaveBar:GetWidth()

        -- Smooth interpolation for width changes
        if targetWidth < currentWidth then
            local newWidth = currentWidth + (targetWidth - currentWidth) * 0.3
            frame.weaveBar:SetWidth(newWidth)
        else
            frame.weaveBar:SetWidth(targetWidth)
        end

        -- Smooth alpha transition as gap approaches zero
        local alpha = math.min(1.0, visualGap / (adjustedInputDelay + 0.1))
        frame.weaveBar:SetAlpha(alpha)

        frame.weaveBar:Show()
        PositionBarSpark(frame.weaveBar, frame.weaveSpark, false)
        SetSparkKeybind(frame.weaveSpark, self.db.class.showKeybindOnBar)
    else
        -- Very small gap - shrink width smoothly instead of disappearing
        local currentWidth = frame.weaveBar:GetWidth()
        local newWidth = currentWidth * 0.7 -- Gradually shrink
        if newWidth < 2 then                -- Minimum visible width
            frame.weaveBar:SetWidth(0)
            frame.weaveBar:Hide()
            SetSparkKeybind(frame.weaveSpark, false)
            frame.weaveSpark:Hide()
        else
            frame.weaveBar:SetWidth(newWidth)
            frame.weaveBar:SetAlpha(0.3) -- Fade out
            SetSparkKeybind(frame.weaveSpark, false)
            frame.weaveSpark:Hide()
        end
    end

    -- Update CL weave bar (darker blue) and spark with improved smoothing
    local clRemainingGapTime = rawSwingTimeLeft - (clCastTime + adjustedInputDelay)

    -- Calculate safe gap and visual width with improved smoothing
    local clSafeGap = rawSwingTimeLeft - clCastTime
    local clVisualGap = math.max(0, clSafeGap - adjustedInputDelay)

    if clVisualGap > epsilon then
        local swingProgress = clVisualGap / weaponSpeed
        local targetWidth = maxWidth * swingProgress
        local currentWidth = frame.clWeaveBar:GetWidth()

        -- Smooth interpolation for width changes
        if targetWidth < currentWidth then
            local newWidth = currentWidth + (targetWidth - currentWidth) * 0.3
            frame.clWeaveBar:SetWidth(newWidth)
        else
            frame.clWeaveBar:SetWidth(targetWidth)
        end

        -- Smooth alpha transition as gap approaches zero
        local alpha = math.min(1.0, clVisualGap / (adjustedInputDelay + 0.1))
        frame.clWeaveBar:SetAlpha(alpha)

        -- Only show CL bar if EB is on cooldown (or EB not talented)
        local cdInfo = WoWAPI.GetSpellCooldown(117014)
        local ebOnCD = false
        if cdInfo then
            local ebStart = cdInfo.startTime
            local ebDuration = cdInfo.duration
            ebOnCD = ebDuration and ebDuration > 1.5 and (ebStart + ebDuration - GetTime()) > 0
        end
        local showCL = (ebIsKnown and ebOnCD) or (not ebIsKnown)
        if showCL then
            frame.clWeaveBar:Show()
            PositionBarSpark(frame.clWeaveBar, frame.clWeaveSpark, true)
            SetSparkKeybind(frame.clWeaveSpark, self.db.class.showKeybindOnBar)
        else
            frame.clWeaveBar:Hide()
            SetSparkKeybind(frame.clWeaveSpark, false)
            frame.clWeaveSpark:Hide()
        end
    else
        -- Very small gap - shrink width smoothly instead of disappearing
        local currentWidth = frame.clWeaveBar:GetWidth()
        local newWidth = currentWidth * 0.7 -- Gradually shrink
        if newWidth < 2 then                -- Minimum visible width
            frame.clWeaveBar:SetWidth(0)
            frame.clWeaveBar:Hide()
            SetSparkKeybind(frame.clWeaveSpark, false)
            frame.clWeaveSpark:Hide()
        else
            frame.clWeaveBar:SetWidth(newWidth)
            frame.clWeaveBar:SetAlpha(0.3) -- Fade out
            SetSparkKeybind(frame.clWeaveSpark, false)
            frame.clWeaveSpark:Hide()
        end
    end

    -- Update LB upcoming weave gap bar (light blue) and spark
    local lbNextGapTime = max(0, (weaponSpeed) - (lbCastTime + adjustedInputDelay))
    if lbNextGapTime > epsilon then
        local swingProgress = rawSwingTimeLeft / weaponSpeed
        local safeOffset = 0.02
        if swingProgress < 1 - safeOffset then
            swingProgress = swingProgress + safeOffset
        end
        local startPoint = maxWidth * swingProgress
        local gapEndTime = min(rawSwingTimeLeft + lbNextGapTime, weaponSpeed)
        local endProgress = gapEndTime / weaponSpeed
        local endPoint = maxWidth * endProgress
        local width = endPoint - startPoint
        if width < 0 then width = 0 end
        frame.upcomingWeaveBar:ClearAllPoints()
        frame.upcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", startPoint, lbBarYOffset)
        if width > epsilon then
            frame.upcomingWeaveBar:SetWidth(width)
            frame.upcomingWeaveBar:Show()
            -- Show the spark when the bar is not at its maximum width
            local maxUpcomingWidth = maxWidth * (1 - swingProgress)
            if math.abs(width - maxUpcomingWidth) >= 1 then
                PositionBarSpark(frame.upcomingWeaveBar, frame.upcomingWeaveSpark, false)
                SetSparkKeybind(frame.upcomingWeaveSpark, self.db.class.showKeybindOnBar)
            else
                SetSparkKeybind(frame.upcomingWeaveSpark, false)
                frame.upcomingWeaveSpark:Hide()
            end
        else
            frame.upcomingWeaveBar:ClearAllPoints()
            frame.upcomingWeaveBar:SetWidth(0)
            frame.upcomingWeaveBar:Hide()
            SetSparkKeybind(frame.upcomingWeaveSpark, false)
            frame.upcomingWeaveSpark:Hide()
        end
    else
        frame.upcomingWeaveBar:ClearAllPoints()
        frame.upcomingWeaveBar:SetWidth(0)
        frame.upcomingWeaveBar:Hide()
        SetSparkKeybind(frame.upcomingWeaveSpark, false)
        frame.upcomingWeaveSpark:Hide()
    end

    -- Update CL upcoming weave gap bar (darker blue) and spark
    local clNextGapTime = max(0, (weaponSpeed) - (clCastTime + adjustedInputDelay))
    if clNextGapTime > epsilon then
        local swingProgress = rawSwingTimeLeft / weaponSpeed
        local safeOffset = 0.02
        if swingProgress < 1 - safeOffset then
            swingProgress = swingProgress + safeOffset
        end
        local startPoint = maxWidth * swingProgress
        local gapEndTime = min(rawSwingTimeLeft + clNextGapTime, weaponSpeed)
        local endProgress = gapEndTime / weaponSpeed
        local endPoint = maxWidth * endProgress
        local width = endPoint - startPoint
        if width < 0 then width = 0 end
        frame.clUpcomingWeaveBar:ClearAllPoints()
        frame.clUpcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", startPoint, clBarYOffset)
        if width > epsilon then
            frame.clUpcomingWeaveBar:SetWidth(width)
            -- Only show CL upcoming bar if EB is on cooldown (or EB not talented)
            local cdInfo = WoWAPI.GetSpellCooldown(117014)
            local ebOnCD = false
            if cdInfo then
                local ebStart = cdInfo.startTime
                local ebDuration = cdInfo.duration
                ebOnCD = ebDuration and ebDuration > 1.5 and (ebStart + ebDuration - GetTime()) > 0
            end
            local showCL = (ebIsKnown and ebOnCD) or (not ebIsKnown)
            if showCL then
                frame.clUpcomingWeaveBar:Show()
                local maxUpcomingWidth = maxWidth * (1 - swingProgress)
                if math.abs(width - maxUpcomingWidth) >= 1 then
                    PositionBarSpark(frame.clUpcomingWeaveBar, frame.clUpcomingWeaveSpark, true)
                    SetSparkKeybind(frame.clUpcomingWeaveSpark, self.db.class.showKeybindOnBar)
                else
                    SetSparkKeybind(frame.clUpcomingWeaveSpark, false)
                    frame.clUpcomingWeaveSpark:Hide()
                end
            else
                frame.clUpcomingWeaveBar:Hide()
                SetSparkKeybind(frame.clUpcomingWeaveSpark, false)
                frame.clUpcomingWeaveSpark:Hide()
            end
        else
            frame.clUpcomingWeaveBar:ClearAllPoints()
            frame.clUpcomingWeaveBar:SetWidth(0)
            frame.clUpcomingWeaveBar:Hide()
            SetSparkKeybind(frame.clUpcomingWeaveSpark, false)
            frame.clUpcomingWeaveSpark:Hide()
        end
    else
        frame.clUpcomingWeaveBar:ClearAllPoints()
        frame.clUpcomingWeaveBar:SetWidth(0)
        frame.clUpcomingWeaveBar:Hide()
        SetSparkKeybind(frame.clUpcomingWeaveSpark, false)
        frame.clUpcomingWeaveSpark:Hide()
    end

    -- Update countdown bar (red)
    frame.countdownBar:SetWidth(0)

    -- Update GCD bar
    if UnitAffectingCombat("player") and UnitExists("target") then
        local gcd = NAG:GCDTimeToReady() or 0
        local weaponSpeed = NAG:AutoSwingTime(NAG.Types:GetType("SwingType").MainHand)
        local maxWidth = frame:GetWidth()
        local castTimeLeft = 0
        local isInstantCast = true
        if currentCastEndTime and currentCastEndTime > GetTime() and currentCastSpellId then
            castTimeLeft = currentCastEndTime - GetTime()
            local castDuration = NAG:SpellCastTime(currentCastSpellId)
            if castDuration and castDuration > 0.05 then -- treat <=0.05 as instant
                isInstantCast = false
            end
        end
        local barTime = math.max(gcd, castTimeLeft)
        local barProgress = barTime / weaponSpeed -- Use weapon speed as maximum length
        local targetWidth = maxWidth * barProgress
        local currentWidth = frame.gcdBar:GetWidth()

        -- Color logic
        local swingTimeLeft = select(2, NAG:AutoTimeToNext()) or 0
        local nextSwingTime = GetTime() + swingTimeLeft
        local castEndTime = currentCastEndTime or 0
        local gcdEndTime = GetTime() + gcd
        local r, g, b, a = 0.3, 0.3, 0.3, 0.85 -- darker default gray

        -- For instant casts, just use GCD time and default color
        if isInstantCast then
            -- Use default darkened gray for instant casts
            r, g, b, a = 0.3, 0.3, 0.3, 0.85
        else
            -- For non-instant casts, check if cast will clip swing
            -- Note: We use the actual castEndTime (without adjustedInputDelay) for clipping detection
            -- Maelstrom Weapon at 5 stacks makes casts instant, so skip clipping check
            if maelstromStacks == 5 then
                -- Light green: no clipping possible with instant casts
                r, g, b, a = 0.4, 1, 0.4, 0.95
            elseif castEndTime >= nextSwingTime then
                -- Red: cast will clip next swing
                r, g, b, a = 1, 0.2, 0.2, 0.95
            else
                -- Light green: cast will finish before next swing
                r, g, b, a = 0.4, 1, 0.4, 0.95
            end
        end

        frame.gcdBar:SetColorTexture(r, g, b, a)

        -- Only interpolate if we're decreasing
        if targetWidth < currentWidth then
            local newWidth = currentWidth + (targetWidth - currentWidth) * 0.3
            frame.gcdBar:SetWidth(newWidth)
        else
            frame.gcdBar:SetWidth(targetWidth)
        end
        -- Update GCD spark visibility and position
        if barTime > 0 then
            frame.gcdSpark:Show()
            -- Calculate alpha for GCD spark
            local alpha = 0.5 -- Start at 50% visibility
            if barProgress < 0.25 then
                -- Fade from 50% to 100% in the last quarter
                alpha = 0.5 + ((0.25 - barProgress) * 2.0)
            end
            frame.gcdSpark:SetAlpha(alpha)
        else
            frame.gcdSpark:Hide()
        end
    else
        frame.gcdBar:SetWidth(0)
        frame.gcdSpark:Hide()
    end

    -- Update current swing timer bar
    if settings.swingTimer.enabled then
        local swingProgress = rawSwingTimeLeft / weaponSpeed
        local targetWidth = maxWidth * swingProgress
        local currentWidth = frame.swingBar:GetWidth()

        -- Only interpolate if we're decreasing
        if targetWidth < currentWidth then
            local newWidth = currentWidth + (targetWidth - currentWidth) * 0.3
            frame.swingBar:SetWidth(newWidth)
        else
            frame.swingBar:SetWidth(targetWidth)
        end

        -- Set fixed spark size and show it
        frame.spark:SetSize(settings.swingTimer.sparkWidth, barHeight)
        frame.spark:Show()
    else
        frame.swingBar:SetWidth(0)
        frame.spark:Hide()
    end

    -- Update EB weave bar (light purple) and spark with improved smoothing
    local EB_ID = 117014
    -- Only show EB bars if EB is talented/known and off cooldown and castable
    local cdInfo = WoWAPI.GetSpellCooldown(EB_ID)
    local ebOnCD = false
    if cdInfo then
        local ebStart = cdInfo.startTime
        local ebDuration = cdInfo.duration
        ebOnCD = ebDuration and ebDuration > 1.5 and (ebStart + ebDuration - GetTime()) > 0
    end
    if ebIsKnown and ebCanCast and not ebOnCD then
        local ebCastTime = GetMaelstromAdjustedCastTime(EB_ID, NAG:SpellCastTime(EB_ID), maelstromStacks)

        -- Calculate safe gap and visual width with improved smoothing
        local ebSafeGap = rawSwingTimeLeft - ebCastTime
        local ebVisualGap = math.max(0, ebSafeGap - adjustedInputDelay)

        if ebVisualGap > epsilon then
            local swingProgress = ebVisualGap / weaponSpeed
            local targetWidth = maxWidth * swingProgress
            local currentWidth = frame.ebWeaveBar:GetWidth()

            -- Smooth interpolation for width changes
            if targetWidth < currentWidth then
                local newWidth = currentWidth + (targetWidth - currentWidth) * 0.3
                frame.ebWeaveBar:SetWidth(newWidth)
            else
                frame.ebWeaveBar:SetWidth(targetWidth)
            end

            -- Smooth alpha transition as gap approaches zero
            local alpha = math.min(1.0, ebVisualGap / (adjustedInputDelay + 0.1))
            frame.ebWeaveBar:SetAlpha(alpha)

            frame.ebWeaveBar:Show()
            PositionBarSpark(frame.ebWeaveBar, frame.ebWeaveSpark, true) -- Changed to alignTop like CL
            SetSparkKeybind(frame.ebWeaveSpark, self.db.class.showKeybindOnBar)
        else
            -- Very small gap - shrink width smoothly instead of disappearing
            local currentWidth = frame.ebWeaveBar:GetWidth()
            local newWidth = currentWidth * 0.7 -- Gradually shrink
            if newWidth < 2 then                -- Minimum visible width
                frame.ebWeaveBar:SetWidth(0)
                frame.ebWeaveBar:Hide()
                SetSparkKeybind(frame.ebWeaveSpark, false)
                frame.ebWeaveSpark:Hide()
            else
                frame.ebWeaveBar:SetWidth(newWidth)
                frame.ebWeaveBar:SetAlpha(0.3) -- Fade out
                SetSparkKeybind(frame.ebWeaveSpark, false)
                frame.ebWeaveSpark:Hide()
            end
        end
    else
        frame.ebWeaveBar:SetWidth(0)
        frame.ebWeaveBar:Hide()
        SetSparkKeybind(frame.ebWeaveSpark, false)
        frame.ebWeaveSpark:Hide()
    end
    -- Update EB upcoming weave gap bar (light purple) and spark
    if ebIsKnown and ebCanCast and not ebOnCD then
        local ebCastTime = GetMaelstromAdjustedCastTime(EB_ID, NAG:SpellCastTime(EB_ID), maelstromStacks)
        local ebNextGapTime = max(0, (weaponSpeed) - (ebCastTime + adjustedInputDelay))
        if ebNextGapTime > epsilon then
            local swingProgress = rawSwingTimeLeft / weaponSpeed
            local safeOffset = 0.02
            if swingProgress < 1 - safeOffset then
                swingProgress = swingProgress + safeOffset
            end
            local startPoint = maxWidth * swingProgress
            local gapEndTime = min(rawSwingTimeLeft + ebNextGapTime, weaponSpeed)
            local endProgress = gapEndTime / weaponSpeed
            local endPoint = maxWidth * endProgress
            local width = endPoint - startPoint
            if width < 0 then width = 0 end
            frame.ebUpcomingWeaveBar:ClearAllPoints()
            frame.ebUpcomingWeaveBar:SetPoint("LEFT", frame, "LEFT", startPoint, ebBarYOffset)
            if width > epsilon then
                frame.ebUpcomingWeaveBar:SetWidth(width)
                frame.ebUpcomingWeaveBar:Show()
                local maxUpcomingWidth = maxWidth * (1 - swingProgress)
                if math.abs(width - maxUpcomingWidth) >= 1 then
                    PositionBarSpark(frame.ebUpcomingWeaveBar, frame.ebUpcomingWeaveSpark, true) -- Changed to alignTop like CL
                    SetSparkKeybind(frame.ebUpcomingWeaveSpark, self.db.class.showKeybindOnBar)
                else
                    SetSparkKeybind(frame.ebUpcomingWeaveSpark, false)
                    frame.ebUpcomingWeaveSpark:Hide()
                end
            else
                frame.ebUpcomingWeaveBar:ClearAllPoints()
                frame.ebUpcomingWeaveBar:SetWidth(0)
                frame.ebUpcomingWeaveBar:Hide()
                SetSparkKeybind(frame.ebUpcomingWeaveSpark, false)
                frame.ebUpcomingWeaveSpark:Hide()
            end
        else
            frame.ebUpcomingWeaveBar:ClearAllPoints()
            frame.ebUpcomingWeaveBar:SetWidth(0)
            frame.ebUpcomingWeaveBar:Hide()
            SetSparkKeybind(frame.ebUpcomingWeaveSpark, false)
            frame.ebUpcomingWeaveSpark:Hide()
        end
    else
        frame.ebUpcomingWeaveBar:ClearAllPoints()
        frame.ebUpcomingWeaveBar:SetWidth(0)
        frame.ebUpcomingWeaveBar:Hide()
        SetSparkKeybind(frame.ebUpcomingWeaveSpark, false)
        frame.ebUpcomingWeaveSpark:Hide()
    end

    -- Update Spell CD Bar sparks
    if usePresetLayout and settings.spellCDBar and settings.spellCDBar.enabled and frame.spellCDBarFrame and frame.spellCDSparks then
        local weaponSpeed = NAG:AutoSwingTime(NAG.Types:GetType("SwingType").MainHand)
        local maxWidth = frame.spellCDBarFrame:GetWidth()
        local smoothingFactor = 0.3
        -- Update each spell spark
        for i, sparkFrame in ipairs(frame.spellCDSparks) do
            local spellId = sparkFrame.spellId
            -- Check if spell is known
            if NAG:SpellIsKnown(spellId) then
                -- Calculate GCD-aware cooldown timing
                local delay = 0
                if not NAG:IsReadySpell(spellId) then
                    local spellCooldown = NAG:TimeToReady(spellId)
                    local gcdTime = NAG:GCDTimeToReady()
                    if spellCooldown and spellCooldown > 0 then
                        delay = spellCooldown + gcdTime
                    else
                        delay = gcdTime
                    end
                end
                if delay and delay > 0 then
                    local clampedDelay = math.min(delay, weaponSpeed)
                    local progress = clampedDelay / weaponSpeed
                    local targetX = maxWidth * progress
                    -- Smoothing: interpolate currentX toward targetX
                    if not sparkFrame.currentX or math.abs(sparkFrame.currentX - targetX) > maxWidth then
                        sparkFrame.currentX = targetX -- Initialize or reset if out of bounds
                    else
                        sparkFrame.currentX = sparkFrame.currentX + (targetX - sparkFrame.currentX) * smoothingFactor
                    end
                    if sparkFrame.icon and sparkFrame.line then
                        if sparkIconsEnabled then
                            sparkFrame:SetSize(sparkFrame.defaultWidth or 16, sparkFrame.defaultHeight or 16)
                            sparkFrame.icon:Show()
                            sparkFrame.line:Hide()
                        else
                            local barHeight = frame.spellCDBarFrame:GetHeight() or settings.height
                            sparkFrame:SetWidth(2)
                            sparkFrame:SetHeight(barHeight)
                            sparkFrame.icon:Hide()
                            sparkFrame.line:SetAllPoints()
                            sparkFrame.line:Show()
                        end
                    end
                    sparkFrame:ClearAllPoints()
                    sparkFrame:SetPoint("CENTER", frame.spellCDBarFrame, "LEFT", sparkFrame.currentX, 0)
                    sparkFrame:Show()
                else
                    if sparkFrame.icon then sparkFrame.icon:Hide() end
                    if sparkFrame.line then sparkFrame.line:Hide() end
                    sparkFrame:Hide()
                    sparkFrame.currentX = nil -- Reset smoothing when hidden
                end
            else
                if sparkFrame.icon then sparkFrame.icon:Hide() end
                if sparkFrame.line then sparkFrame.line:Hide() end
                sparkFrame:Hide()
                sparkFrame.currentX = nil -- Reset smoothing when hidden
            end
        end
    else
        -- Hide all spell CD sparks if not enabled
        if frame.spellCDSparks then
            for i, sparkFrame in ipairs(frame.spellCDSparks) do
                if sparkFrame.icon then sparkFrame.icon:Hide() end
                if sparkFrame.line then sparkFrame.line:Hide() end
                sparkFrame:Hide()
                sparkFrame.currentX = nil -- Reset smoothing when hidden
            end
        end
    end
end

function ShamanWeaveBar:OnCombatStateChanged()
    local canDrag = NAG.IsAnyEditMode and NAG:IsAnyEditMode()
    if UnitAffectingCombat("player") then
        -- Entered combat: disable mouse when not in edit mode
        if not canDrag and frame then
            frame:EnableMouse(false)
        end
    else
        -- Left combat
        if canDrag and frame then
            frame:EnableMouse(true)
        end
    end
    -- Update visibility when combat state changes
    self:UpdateVisibility()
end

function ShamanWeaveBar:PLAYER_REGEN_DISABLED(event)
    -- Combat start
    self:OnCombatStateChanged()
end

function ShamanWeaveBar:PLAYER_REGEN_ENABLED(event)
    -- Combat end
    self:OnCombatStateChanged()
end

function ShamanWeaveBar:GetOptions()
    return {
        type = "group",
        name = L["LB Weaving Bar"] or "LB Weaving Bar",
        order = 25,
        childGroups = "tab",
        width = "full",
        args = {
            showBar = OptionsFactory:CreateToggle(
                L["Show Weaving Bar"] or "Show Weaving Bar",
                L["Toggle the visibility of the weaving bar"] or "Toggle the visibility of the weaving bar",
                function() return self.db.class.showBar end,
                function(info, value)
                    self.db.class.showBar = value
                    self:UpdateVisibility()
                end,
                { width = "full", order = 0 }
            ),
            hideOutOfCombat = OptionsFactory:CreateToggle(
                L["Hide Out of Combat"] or "Hide Out of Combat",
                L["Hide the weaving bar when out of combat"] or "Hide the weaving bar when out of combat",
                function() return self.db.class.hideOutOfCombat end,
                function(info, value)
                    self.db.class.hideOutOfCombat = value
                    self:UpdateVisibility()
                end,
                { width = "full", order = 1 }
            ),
            showKeybindOnBar = OptionsFactory:CreateToggle(
                L["Show Keybind Above Bar Icons"] or "Show Keybind Above Bar Icons",
                L["Display the keybind above the icons on the weave bar."] or "Display the keybind above the icons on the weave bar.",
                function() return self.db.class.showKeybindOnBar end,
                function(info, value)
                    self.db.class.showKeybindOnBar = value
                    self:UpdateDisplay()
                end,
                { width = "full", order = 2 }
            ),
            positionBar = OptionsFactory:CreateExecute(
                L["Position Bar"] or "Position Bar",
                L["Click to enter positioning mode. Drag the bar to position it, then click X when done."] or "Click to enter positioning mode. Drag the bar to position it, then click X when done.",
                function()
                    self:StartPositioning()
                end,
                {
                    width = "full",
                    order = 2,
                    disabled = function()
                        return self.db.class.presetLayout.enabled and autoAnchorEnabled
                    end
                }
            ),
            presetLayout = {
                name = L["Preset Layout"],
                type = "group",
                order = 5,
                inline = false,
                args = {
                    enabled = OptionsFactory:CreateToggle(
                        L["Enable Preset Layout"] or "Enable Preset Layout",
                        L["Toggle the preset layout system on/off"] or "Toggle the preset layout system on/off",
                        function() return self.db.class.presetLayout.enabled end,
                        function(info, value)
                            self.db.class.presetLayout.enabled = value
                            self:UpdateFrameSettings()
                            -- Refresh the options panel to update button states
                            if NAG.optionsFrame then
                                -- NAG.optionsFrame:Refresh()
                                AceConfigRegistry:NotifyChange("NAG")
                            end
                        end,
                        { width = "full", order = 0 }
                    ),
                    autoAnchor = OptionsFactory:CreateToggle(
                        L["Auto Anchor to NAG Frame"] or "Auto Anchor to NAG Frame",
                        L["Automatically position the weaving bar relative to the NAG primary frame"] or
                        "Automatically position the weaving bar relative to the NAG primary frame",
                        function() return autoAnchorEnabled end,
                        function(info, value)
                            autoAnchorEnabled = value
                            if self.db.class.presetLayout.enabled then
                                self:UpdateFrameSettings()
                            end
                            -- Refresh the options panel to update button states
                            if NAG.optionsFrame then
                                -- NAG.optionsFrame:Refresh()
                                AceConfigRegistry:NotifyChange("NAG")
                            end
                        end,
                        { width = "full", order = 1 }
                    ),
                    -- Basic settings
                    width = OptionsFactory:CreateRange(
                        L["Width"],
                        L["Width"],
                        function() return self.db.class.presetLayout.width end,
                        function(info, value)
                            self.db.class.presetLayout.width = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 45, max = 1000, step = 1, order = 20 }
                    ),
                    height = OptionsFactory:CreateRange(
                        L["Height"],
                        L["Height"],
                        function() return self.db.class.presetLayout.height end,
                        function(info, value)
                            self.db.class.presetLayout.height = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 10, max = 500, step = 1, order = 30 }
                    ),
                    alpha = OptionsFactory:CreateRange(
                        L["Alpha"],
                        L["Alpha"],
                        function() return self.db.class.presetLayout.alpha end,
                        function(info, value)
                            self.db.class.presetLayout.alpha = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 0, max = 1, step = 0.05, order = 40 }
                    ),
                    -- Position settings
                    positionHeader = OptionsFactory:CreateHeader(L["Position"], { order = 50 }),
                    xOffset = OptionsFactory:CreateRange(
                        L["X Offset"],
                        L["X Offset"],
                        function() return self.db.class.presetLayout.x end,
                        function(info, value)
                            self.db.class.presetLayout.x = value
                            self:UpdateFrameSettings()
                        end,
                        { min = -2000, max = 2000, step = 1, order = 60 }
                    ),
                    yOffset = OptionsFactory:CreateRange(
                        L["Y Offset"],
                        L["Y Offset"],
                        function() return self.db.class.presetLayout.y end,
                        function(info, value)
                            self.db.class.presetLayout.y = value
                            self:UpdateFrameSettings()
                        end,
                        { min = -2000, max = 2000, step = 1, order = 70 }
                    ),
                    -- Bar heights
                    barHeightsHeader = OptionsFactory:CreateHeader(L["Bar Heights"], { order = 80 }),
                    lbBarHeightPct = OptionsFactory:CreateRange(
                        L["Lightning Bolt Bar Height"],
                        L["Lightning Bolt Bar Height"],
                        function() return self.db.class.presetLayout.lbBarHeightPct end,
                        function(info, value)
                            self.db.class.presetLayout.lbBarHeightPct = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 0.05, max = 1.0, step = 0.01, order = 81, isPercent = true }
                    ),
                    clBarHeightPct = OptionsFactory:CreateRange(
                        L["Chain Lightning Bar Height"],
                        L["Chain Lightning Bar Height"],
                        function() return self.db.class.presetLayout.clBarHeightPct end,
                        function(info, value)
                            self.db.class.presetLayout.clBarHeightPct = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 0.05, max = 1.0, step = 0.01, order = 82, isPercent = true }
                    ),
                    ebBarHeightPct = OptionsFactory:CreateRange(
                        L["Elemental Blast Bar Height"],
                        L["Elemental Blast Bar Height"],
                        function() return self.db.class.presetLayout.ebBarHeightPct end,
                        function(info, value)
                            self.db.class.presetLayout.ebBarHeightPct = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 0.05, max = 1.0, step = 0.01, order = 83, isPercent = true }
                    ),
                    -- Custom background settings
                    backgroundHeader = OptionsFactory:CreateHeader(L["Custom Background"], { order = 90 }),
                    backgroundEnabled = OptionsFactory:CreateToggle(
                        L["Enable Custom Background"],
                        L["Enable Custom Background"],
                        function() return self.db.class.presetLayout.background.enabled end,
                        function(info, value)
                            self.db.class.presetLayout.background.enabled = value
                            self:UpdateFrameSettings()
                        end,
                        { order = 91 }
                    ),
                    backgroundStyle = OptionsFactory:CreateSelect(
                        L["Background Style"] or "Background Style",
                        L["Select the background style for the preset layout"] or
                        "Select the background style for the preset layout",
                        function() return self.db.class.presetLayout.background.style or "Extended" end,
                        function(info, value)
                            self.db.class.presetLayout.background.style = value
                            self:UpdateFrameSettings()
                        end,
                        {
                            order = 92,
                            values = {
                                Extended = "Extended",
                                Simpler = "Simpler"
                            }
                        }
                    ),
                    backgroundScale = OptionsFactory:CreateRange(
                        L["Background Scale"],
                        L["Background Scale"],
                        function() return self.db.class.presetLayout.background.scale end,
                        function(info, value)
                            self.db.class.presetLayout.background.scale = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 0.1, max = 3.0, step = 0.1, order = 93 }
                    ),
                    backgroundXOffset = OptionsFactory:CreateRange(
                        L["Background X Offset"],
                        L["Background X Offset"],
                        function() return self.db.class.presetLayout.background.xOffset end,
                        function(info, value)
                            self.db.class.presetLayout.background.xOffset = value
                            self:UpdateFrameSettings()
                        end,
                        { min = -2000, max = 2000, step = 1, order = 94 }
                    ),
                    backgroundYOffset = OptionsFactory:CreateRange(
                        L["Background Y Offset"],
                        L["Background Y Offset"],
                        function() return self.db.class.presetLayout.background.yOffset end,
                        function(info, value)
                            self.db.class.presetLayout.background.yOffset = value
                            self:UpdateFrameSettings()
                        end,
                        { min = -2000, max = 2000, step = 1, order = 95 }
                    ),
                    backgroundWidth = OptionsFactory:CreateRange(
                        L["Background Width"],
                        L["Background Width"],
                        function() return self.db.class.presetLayout.background.width end,
                        function(info, value)
                            self.db.class.presetLayout.background.width = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 50, max = 1000, step = 1, order = 96 }
                    ),
                    backgroundHeight = OptionsFactory:CreateRange(
                        L["Background Height"],
                        L["Background Height"],
                        function() return self.db.class.presetLayout.background.height end,
                        function(info, value)
                            self.db.class.presetLayout.background.height = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 10, max = 500, step = 1, order = 97 }
                    ),
                    backgroundAlpha = OptionsFactory:CreateRange(
                        L["Background Alpha"],
                        L["Background Alpha"],
                        function() return self.db.class.presetLayout.background.alpha end,
                        function(info, value)
                            self.db.class.presetLayout.background.alpha = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 0, max = 1, step = 0.05, order = 98 }
                    ),
                    -- Swing timer settings
                    swingTimerHeader = OptionsFactory:CreateHeader(L["Swing Timer"], { order = 100 }),
                    swingTimerEnabled = OptionsFactory:CreateToggle(
                        L["Enable Swing Timer"],
                        L["Enable Swing Timer"],
                        function() return self.db.class.presetLayout.swingTimer.enabled end,
                        function(info, value)
                            self.db.class.presetLayout.swingTimer.enabled = value
                            self:UpdateFrameSettings()
                        end,
                        { order = 101 }
                    ),
                    swingTimerSparkWidth = OptionsFactory:CreateRange(
                        L["Spark Width"],
                        L["Spark Width"],
                        function() return self.db.class.presetLayout.swingTimer.sparkWidth end,
                        function(info, value)
                            self.db.class.presetLayout.swingTimer.sparkWidth = value
                            self:UpdateFrameSettings()
                        end,
                        { min = 1, max = 10, step = 1, order = 104 }
                    ),
                    swingTimerSparkColor = OptionsFactory:CreateColor(
                        L["Spark Color"],
                        L["Spark Color"],
                        function()
                            local c = self.db.class.presetLayout.swingTimer.sparkColor
                            if c and type(c) == "table" then
                                return c.r, c.g, c.b, c.a
                            else
                                -- Return default color when sparkColor is false
                                return 0.8, 0.8, 0.8, 1
                            end
                        end,
                        function(info, r, g, b, a)
                            self.db.class.presetLayout.swingTimer.sparkColor = { r = r, g = g, b = b, a = a }
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 105 }
                    ),

                    -- Spell CD Bar settings
                    spellCDBarHeader = OptionsFactory:CreateHeader(L["Spell CD Bar"] or "Spell CD Bar", { order = 106 }),
                    spellCDBarEnabled = OptionsFactory:CreateToggle(
                        L["Enable Spell CD Bar"] or "Enable Spell CD Bar",
                        L["Enables the cooldown tracking bar"] or "Enables the cooldown tracking bar",
                        function() return self.db.class.presetLayout.spellCDBar.enabled end,
                        function(info, value)
                            self.db.class.presetLayout.spellCDBar.enabled = value
                            self:UpdateFrameSettings()
                        end,
                        { order = 107 }
                    ),
                    spellCDBarYOffset = OptionsFactory:CreateRange(
                        L["Spell CD Bar Y Offset"] or "Spell CD Bar Y Offset",
                        L["Adjusts vertical offset above main bar group"] or
                        "Adjusts vertical offset above main bar group",
                        function() return self.db.class.presetLayout.spellCDBar.yOffset end,
                        function(info, value)
                            self.db.class.presetLayout.spellCDBar.yOffset = value
                            self:UpdateFrameSettings()
                        end,
                        { min = -100, max = 100, step = 1, order = 108 }
                    ),

                    -- Reset to defaults
                    resetHeader = OptionsFactory:CreateHeader(L["Reset"], { order = 110 }),
                    resetToDefaults = OptionsFactory:CreateExecute(
                        L["Reset to Defaults"] or "Reset to Defaults",
                        L["Reset all preset layout settings to their default values"] or "Reset all preset layout settings to their default values",
                        function()
                            -- Reset preset layout to new finalized defaults
                            self.db.class.presetLayout = {
                                enabled = true,
                                width = 89,
                                height = 20,
                                alpha = 1.0,
                                point = "CENTER",
                                x = -2,
                                y = 0,
                                showBorder = true,
                                borderColor = { r = 1, g = 1, b = 1, a = 1 },
                                borderThickness = 1,
                                showCountdownText = true,
                                countdownTextSize = 14,
                                countdownTextColor = { r = 1, g = 1, b = 1, a = 1 },
                                lbBarHeightPct = 0.16,
                                clBarHeightPct = 0.15,
                                ebBarHeightPct = 0.15,
                                colors = {
                                    background = { r = 0.2, g = 0.2, b = 0.2, a = 0.8 },
                                    weave = { r = 0.4, g = 0.7, b = 1, a = 0.8 },
                                    countdown = { r = 0.8, g = 0.2, b = 0.2, a = 0.8 },
                                    gcd = { r = 0.3, g = 0.3, b = 0.3, a = 0.85 },
                                    spark = { r = 1, g = 1, b = 1, a = 1 },
                                    clweave = { r = 0.2, g = 0.4, b = 0.8, a = 0.8 },
                                    upcomingweave = { r = 0.4, g = 0.7, b = 1, a = 0.8 },
                                    clupcomingweave = { r = 0.2, g = 0.4, b = 0.8, a = 0.8 }
                                },
                                swingTimer = {
                                    enabled = true,
                                    sparkWidth = 2,
                                    sparkColor = false, -- As requested
                                    nextSwingEnabled = true,
                                    nextSparkColor = { r = 0.8, g = 0.8, b = 0.8, a = 0.7 }
                                },
                                background = {
                                    enabled = true,
                                    style = "Simpler",
                                    scale = 1.9,
                                    xOffset = -32,
                                    yOffset = 8,
                                    width = 84,
                                    height = 40,
                                    alpha = 0.8
                                },
                                -- Spell CD Bar settings
                                spellCDBar = {
                                    enabled = true,
                                    yOffset = 4
                                }
                            }
                            self:UpdateFrameSettings()
                            self:UpdateVisibility() -- Ensure visibility is refreshed after resetting defaults
                        end,
                        { order = 111 }
                    )
                }
            },
            barSettings = {
                name = L["Bar Settings"],
                type = "group",
                order = 10,
                inline = false,
                args = {
                    showSparkIcons = OptionsFactory:CreateToggle(
                        L["Show Spark Icons"] or "Show Spark Icons",
                        L["Display circular spark indicators on weave bars"] or
                        "Display circular spark indicators on weave bars",
                        function() return self.db.class.bar.showSparkIcons ~= false end,
                        function(info, value)
                            self.db.class.bar.showSparkIcons = value
                            self:UpdateFrameSettings()
                            self:UpdateDisplay()
                        end,
                        {
                            order = 0,
                            width = "full",
                            disabled = function()
                                return self.db.class.presetLayout.enabled
                            end
                        }
                    ),
                    width = OptionsFactory:CreateRange(
                        L["Width"],
                        L["Width"],
                        function() return self.db.class.bar.width end,
                        function(info, value)
                            self.db.class.bar.width = value; self:UpdateFrameSettings()
                        end,
                        { min = 45, max = 500, step = 1, order = 10 }
                    ),
                    height = OptionsFactory:CreateRange(
                        L["Height"],
                        L["Height"],
                        function() return self.db.class.bar.height end,
                        function(info, value)
                            self.db.class.bar.height = value; self:UpdateFrameSettings()
                        end,
                        { min = 10, max = 50, step = 1, order = 20 }
                    ),
                    barHeightsHeader = OptionsFactory:CreateHeader(L["Bar Heights"], { order = 25 }),
                    lbBarHeightPct = OptionsFactory:CreateRange(
                        L["Lightning Bolt Bar Height"],
                        L["Lightning Bolt Bar Height"],
                        function() return self.db.class.bar.lbBarHeightPct end,
                        function(info, value)
                            self.db.class.bar.lbBarHeightPct = value; self:UpdateFrameSettings()
                        end,
                        { min = 0.05, max = 1.0, step = 0.01, order = 26, isPercent = true }
                    ),
                    clBarHeightPct = OptionsFactory:CreateRange(
                        L["Chain Lightning Bar Height"],
                        L["Chain Lightning Bar Height"],
                        function() return self.db.class.bar.clBarHeightPct end,
                        function(info, value)
                            self.db.class.bar.clBarHeightPct = value; self:UpdateFrameSettings()
                        end,
                        { min = 0.05, max = 1.0, step = 0.01, order = 27, isPercent = true }
                    ),
                    ebBarHeightPct = OptionsFactory:CreateRange(
                        L["Elemental Blast Bar Height"],
                        L["Elemental Blast Bar Height"],
                        function() return self.db.class.bar.ebBarHeightPct end,
                        function(info, value)
                            self.db.class.bar.ebBarHeightPct = value; self:UpdateFrameSettings()
                        end,
                        { min = 0.05, max = 1.0, step = 0.01, order = 28, isPercent = true }
                    ),
                    alpha = OptionsFactory:CreateRange(
                        L["Alpha"],
                        L["Alpha"],
                        function() return self.db.class.bar.alpha end,
                        function(info, value)
                            self.db.class.bar.alpha = value; self:UpdateFrameSettings()
                        end,
                        { min = 0, max = 1, step = 0.05, order = 30 }
                    ),
                    positionHeader = OptionsFactory:CreateHeader(L["Position"], { order = 40 }),
                    xOffset = OptionsFactory:CreateRange(
                        L["X Offset"],
                        L["X Offset"],
                        function() return self.db.class.bar.x end,
                        function(info, value)
                            self.db.class.bar.x = value; self:UpdateFrameSettings()
                        end,
                        { min = -2000, max = 2000, step = 1, order = 50 }
                    ),
                    yOffset = OptionsFactory:CreateRange(
                        L["Y Offset"],
                        L["Y Offset"],
                        function() return self.db.class.bar.y end,
                        function(info, value)
                            self.db.class.bar.y = value; self:UpdateFrameSettings()
                        end,
                        { min = -2000, max = 2000, step = 1, order = 60 }
                    ),
                    backgroundHeader = OptionsFactory:CreateHeader(L["Border Art"], { order = 80 }),
                    background = OptionsFactory:CreateSelect(
                        L["Border Art"] or "Border Art",
                        L["Select a border art for the bar"] or "Select a border art for the bar",
                        function() return self.db.class.bar.background end,
                        function(info, value)
                            self.db.class.bar.background = value; self:UpdateFrameSettings()
                        end,
                        {
                            order = 90,
                            values = {
                                none = L["None"],
                                bg2 = "ShamanWeaver BG2",
                                bg3 = "ShamanWeaver BG3",
                                bg4 = "ShamanWeaver BG4"
                            }
                        }
                    ),
                    bgColor = OptionsFactory:CreateColor(
                        L["Border Art Color"] or "Border Art Color",
                        L["Set the color and alpha of the border art image"] or "Set the color and alpha of the border art image",
                        function()
                            local c = self.db.class.bar.bgColor or { r = 1, g = 1, b = 1, a = 1 };
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.bgColor = { r = r, g = g, b = b, a = a };
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 91 }
                    ),
                    borderArtHeightPct = OptionsFactory:CreateRange(
                        L["Border Art Height"] or "Border Art Height",
                        L["Set the height of the border art as a percentage of the bar height"] or "Set the height of the border art as a percentage of the bar height",
                        function() return self.db.class.bar.borderArtHeightPct or 1.7 end,
                        function(info, value)
                            self.db.class.bar.borderArtHeightPct = value; self:UpdateFrameSettings()
                        end,
                        { min = 0.5, max = 3.0, step = 0.01, order = 92, isPercent = true }
                    ),
                    -- Swing Timer options moved here
                    swingTimerHeader = OptionsFactory:CreateHeader(L["Swing Timer"], { order = 100 }),
                    swingTimerEnabled = OptionsFactory:CreateToggle(
                        L["Enable Swing Timer"],
                        L["Enable Swing Timer"],
                        function() return self.db.class.bar.swingTimer.enabled end,
                        function(info, value)
                            self.db.class.bar.swingTimer.enabled = value; self:UpdateFrameSettings()
                        end,
                        { order = 101 }
                    ),
                    swingTimerSparkWidth = OptionsFactory:CreateRange(
                        L["Spark Width"],
                        L["Spark Width"],
                        function() return self.db.class.bar.swingTimer.sparkWidth end,
                        function(info, value)
                            self.db.class.bar.swingTimer.sparkWidth = value; self:UpdateFrameSettings()
                        end,
                        { min = 1, max = 10, step = 1, order = 104 }
                    ),
                    swingTimerSparkColor = OptionsFactory:CreateColor(
                        L["Spark Color"],
                        L["Spark Color"],
                        function()
                            local c = self.db.class.bar.swingTimer.sparkColor;
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.swingTimer.sparkColor = { r = r, g = g, b = b, a = a };
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 105 }
                    ),
                    -- Background Bar options
                    backgroundBarHeader = OptionsFactory:CreateHeader(L["Background Bar"], { order = 110 }),
                    backgroundBarEnabled = OptionsFactory:CreateToggle(
                        L["Enable Background Bar"],
                        L["Enable Background Bar"],
                        function() return self.db.class.bar.swingTimer.backgroundBar.enabled end,
                        function(info, value)
                            self.db.class.bar.swingTimer.backgroundBar.enabled = value; self:UpdateFrameSettings()
                        end,
                        { order = 111 }
                    ),
                    backgroundBarAlpha = OptionsFactory:CreateRange(
                        L["Background Bar Alpha"],
                        L["Background Bar Alpha"],
                        function() return self.db.class.bar.swingTimer.backgroundBar.alpha end,
                        function(info, value)
                            self.db.class.bar.swingTimer.backgroundBar.alpha = value; self:UpdateFrameSettings()
                        end,
                        { min = 0, max = 1, step = 0.05, order = 113 }
                    ),
                    -- Debug options
                    debugHeader = OptionsFactory:CreateHeader(L["Debug"], { order = 120 }),
                    debugInputDelay = OptionsFactory:CreateToggle(
                        L["Show Input Delay"] or "Show Input Delay",
                        L["Display the current adjusted input delay value (for debugging)"] or "Display the current adjusted input delay value (for debugging)",
                        function() return self.db.class.debugInputDelay ~= nil end,
                        function(info, value)
                            if value then
                                self.db.class.debugInputDelay = 0   -- Initialize to 0
                            else
                                self.db.class.debugInputDelay = nil -- Remove the debug value
                            end
                        end,
                        { order = 121 }
                    ),
                    debugNetworkStats = OptionsFactory:CreateToggle(
                        L["Show Network Stats"] or "Show Network Stats",
                        L["Display the current network latency and stats (for debugging)"] or "Display the current network latency and stats (for debugging)",
                        function() return self.db.class.debugNetworkStats end,
                        function(info, value)
                            if value then
                                self.db.class.debugNetworkStats = true
                            else
                                self.db.class.debugNetworkStats = false
                            end
                        end,
                        { order = 122 }
                    ),
                    debugAdjustedDelay = OptionsFactory:CreateToggle(
                        L["Show Adjusted Delay"],
                        L["Display the current adjusted input delay value (for debugging)"],
                        function() return self.db.class.debugAdjustedDelay ~= nil end,
                        function(info, value)
                            if value then
                                self.db.class.debugAdjustedDelay = 0   -- Initialize to 0
                            else
                                self.db.class.debugAdjustedDelay = nil -- Remove the debug value
                            end
                        end,
                        { order = 123 }
                    ),
                }
            },
            appearanceSettings = {
                name = L["Appearance"],
                type = "group",
                order = 20,
                inline = false,
                args = {
                    showBorder = OptionsFactory:CreateToggle(
                        L["Show Border"],
                        L["Show Border"],
                        function() return self.db.class.bar.showBorder end,
                        function(info, value)
                            self.db.class.bar.showBorder = value; self:UpdateFrameSettings()
                        end,
                        { order = 10 }
                    ),
                    borderColor = OptionsFactory:CreateColor(
                        L["Border Color"],
                        L["Border Color"],
                        function()
                            local c = self.db.class.bar.borderColor;
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.borderColor = { r = r, g = g, b = b, a = a };
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 20 }
                    ),
                    showCountdownText = OptionsFactory:CreateToggle(
                        L["Show Countdown Text"],
                        L["Show Countdown Text"],
                        function() return self.db.class.bar.showCountdownText end,
                        function(info, value)
                            self.db.class.bar.showCountdownText = value; self:UpdateFrameSettings()
                        end,
                        { order = 30 }
                    ),
                    textSize = OptionsFactory:CreateRange(
                        L["Text Size"],
                        L["Text Size"],
                        function() return self.db.class.bar.countdownTextSize end,
                        function(info, value)
                            self.db.class.bar.countdownTextSize = value; self:UpdateFrameSettings()
                        end,
                        { min = 8, max = 32, step = 1, order = 40 }
                    ),
                    textColor = OptionsFactory:CreateColor(
                        L["Text Color"],
                        L["Text Color"],
                        function()
                            local c = self.db.class.bar.countdownTextColor;
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.countdownTextColor = { r = r, g = g, b = b, a = a };
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 50 }
                    ),
                    colorHeader = OptionsFactory:CreateHeader(L["Bar Colors"], { order = 60 }),
                    weaveColor = OptionsFactory:CreateColor(
                        L["Weave Bar Color"],
                        L["Weave Bar Color"],
                        function()
                            local c = self.db.class.bar.colors.weave;
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.colors.weave = { r = r, g = g, b = b, a = a };
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 70 }
                    ),
                    clweaveColor = OptionsFactory:CreateColor(
                        L["CL Weave Bar Color"] or "CL Weave Bar Color",
                        L["CL Weave Bar Color"] or "CL Weave Bar Color",
                        function()
                            local c = self.db.class.bar.colors.clweave;
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.colors.clweave = { r = r, g = g, b = b, a = a };
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 80 }
                    ),
                    upcomingweaveColor = OptionsFactory:CreateColor(
                        L["Upcoming Weave Bar Color"],
                        L["Upcoming Weave Bar Color"],
                        function()
                            local c = self.db.class.bar.colors.upcomingweave;
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.colors.upcomingweave = { r = r, g = g, b = b, a = a };
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 90 }
                    ),
                    clupcomingweaveColor = OptionsFactory:CreateColor(
                        L["CL Upcoming Weave Bar Color"] or "CL Upcoming Weave Bar Color",
                        L["CL Upcoming Weave Bar Color"] or "CL Upcoming Weave Bar Color",
                        function()
                            local c = self.db.class.bar.colors.clupcomingweave;
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.colors.clupcomingweave = { r = r, g = g, b = b, a = a };
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 100 }
                    ),
                    gcdColor = OptionsFactory:CreateColor(
                        L["GCD Bar Color"] or "GCD Bar Color",
                        L["GCD Bar Color"] or "GCD Bar Color",
                        function()
                            local c = self.db.class.bar.colors.gcd;
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.colors.gcd = { r = r, g = g, b = b, a = a };
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 110 }
                    ),
                    countdownColor = OptionsFactory:CreateColor(
                        L["Countdown Bar Color"],
                        L["Countdown Bar Color"],
                        function()
                            local c = self.db.class.bar.colors.countdown;
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.colors.countdown = { r = r, g = g, b = b, a = a };
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 120 }
                    ),
                    sparkColor = OptionsFactory:CreateColor(
                        L["Spark Color"],
                        L["Spark Color"],
                        function()
                            local c = self.db.class.bar.colors.spark;
                            return c.r, c.g, c.b, c.a
                        end,
                        function(info, r, g, b, a)
                            self.db.class.bar.colors.spark = { r = r, g = g, b = b, a = a };
                            self:UpdateFrameSettings()
                        end,
                        { hasAlpha = true, order = 130 }
                    ),
                }
            }
        }
    }
end

function ShamanWeaveBar:UNIT_SPELLCAST_START(event, unit, castString, spellId)
    if unit == "player" and type(spellId) == "number" then
        currentCastSpellId = spellId

        -- Use the live cast end time from the game client when available.
        -- This reflects haste and Maelstrom Weapon cast-time reduction, unlike WoWAPI.GetSpellInfo().
        local _, _, _, startTimeMS, endTimeMS, _, _, _, spellIdFromAPI = UnitCastingInfo("player")
        if endTimeMS and startTimeMS and endTimeMS > startTimeMS and (not spellIdFromAPI or spellIdFromAPI == spellId) then
            currentCastEndTime = endTimeMS / 1000
            return
        end

        -- Fallback: compute from base cast time (may be wrong for temporary cast-time modifiers).
        local castTime = NAG:SpellCastTime(spellId)
        if castTime and castTime > 0 then
            currentCastEndTime = GetTime() + castTime
        else
            currentCastSpellId = nil
            currentCastEndTime = nil
        end
    end
end

function ShamanWeaveBar:UNIT_SPELLCAST_STOP(event, unit)
    if unit == "player" then
        currentCastSpellId = nil
        currentCastEndTime = nil
    end
end

function ShamanWeaveBar:UNIT_SPELLCAST_INTERRUPTED(event, unit)
    if unit == "player" then
        currentCastSpellId = nil
        currentCastEndTime = nil
    end
end

function ShamanWeaveBar:StartPositioning()
    if not frame then return end

    isPositioning = true
    frame:Show()            -- Force show the frame
    frame:EnableMouse(NAG.IsAnyEditMode and NAG:IsAnyEditMode())

    -- Create or update the close button
    if not frame.closeButton then
        local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 2, 2)
        closeButton:SetScript("OnClick", function()
            self:StopPositioning()
        end)
        frame.closeButton = closeButton
    else
        frame.closeButton:Show()
    end

    -- Show a tooltip on the frame to indicate it's in positioning mode
    frame:SetScript("OnEnter", function()
        GameTooltip:SetOwner(frame, "ANCHOR_TOP")
        GameTooltip:AddLine(L["Positioning Mode"])
        GameTooltip:AddLine(L["Drag to position the bar. Click X when done."], 1, 1, 1, true)
        GameTooltip:Show()
    end)
    frame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end

function ShamanWeaveBar:StopPositioning()
    if not frame then return end

    isPositioning = false
    frame:EnableMouse(NAG.IsAnyEditMode and NAG:IsAnyEditMode())
    if frame.closeButton then
        frame.closeButton:Hide()
    end

    -- Remove tooltip scripts
    frame:SetScript("OnEnter", nil)
    frame:SetScript("OnLeave", nil)

    -- Update visibility based on normal rules
    self:UpdateVisibility()
end
