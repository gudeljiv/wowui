--- @module "NAG.WarriorSlamWeaveBarV2"
--- Visual swing + Slam timing bar for Warrior Slam weaving (V2).
---
--- The swing impact moment is centered on the bar.
--- The Slam icon is anchored to the center with a fixed post-icon gap trail.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...

local GetTime = _G.GetTime
local CreateFrame = _G.CreateFrame

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ DEFAULTS ============================
local defaults = {
    class = {
        enabled = true,
        showBar = true,
        hideOutOfCombat = false,

        -- Positioning
        autoAnchor = true,
        point = "CENTER",
        x = 360,
        y = 18,

        -- Dimensions
        width = 240,
        height = 10,
        barHeight = 4,
        barOffsetY = 0,
        alpha = 1.0,

        -- Visual toggles
        showBackground = true,
        showSwingMarker = true,
        showPreSwingSpark = true,
        showSlamTrail = true,
        showKeybindOnBar = false,

        -- Slam trail settings
        slamGapSeconds = 0.40,
        slamIconSize = 18,
        slamIconOffsetX = 0,
        slamIconOffsetY = 0,
        slamTrailHeight = 4,

        -- Visual tuning
        preSwingSparkWidth = 2,
        preSwingSparkHeight = 12,
        preSwingSparkOffsetY = 0,
        swingMarkerWidth = 2,
        swingMarkerOffsetY = 0,

        -- Colors
        backgroundColor = { r = 0.0, g = 0.0, b = 0.0, a = 0.35 },
        preSwingColor = { r = 0.35, g = 0.75, b = 0.35, a = 0.85 },
        preSwingSparkColor = { r = 0.95, g = 0.95, b = 0.95, a = 0.95 },
        swingMarkerColor = { r = 0.85, g = 0.85, b = 0.85, a = 0.9 },
        slamTrailColor = { r = 0.60, g = 0.35, b = 0.95, a = 0.8 },
    }
}

--- @class WarriorSlamWeaveBarV2:CoreModule
local WarriorSlamWeaveBarV2 = NAG:CreateModule("WarriorSlamWeaveBarV2", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "WARRIOR",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    debugCategories = {
        ns.DEBUG_CATEGORIES.CLASS,
        ns.DEBUG_CATEGORIES.UI,
    },
    eventHandlers = {
        PLAYER_REGEN_DISABLED = true,
        PLAYER_REGEN_ENABLED = true,
    },
    messageHandlers = {
        NAG_FRAME_UPDATED = true,
        NAG_WARRIOR_BAR_SCALE_UPDATED = true,
    },
    slashCommands = {
        ["slamweavev2"] = {
            handler = "HandleSlash",
            help = "Toggle the V2 slam weave bar (show/hide/reset/lock/unlock)"
        }
    },
    defaultState = {
        frame = nil,
        isDragging = false,
    }
})

ns.WarriorSlamWeaveBarV2 = WarriorSlamWeaveBarV2
local module = WarriorSlamWeaveBarV2

-- ============================ LOCALS ============================
local frame
local background
local preSwingBar
local preSwingSpark
local swingMarker
local slamIconFrame
local slamIconTexture
local slamTrail

local UPDATE_INTERVAL = 0.016 -- ~60fps
local lastUpdate = 0

local SLAM_SPELL_ID = 1464 -- Slam (Rank 1)

local function SetSparkKeybind(sparkFrame, showKeybind)
    if not sparkFrame or not sparkFrame.keybindText then return end
    if showKeybind and sparkFrame.spellId then
        local KeybindManager = NAG:GetModule("KeybindManager", true)
        local kb = ""
        if KeybindManager and KeybindManager.GetSpellKeybind then
            kb = KeybindManager:GetSpellKeybind(sparkFrame.spellId) or ""
        end
        sparkFrame.keybindText:SetText(kb)
        if kb ~= "" then
            sparkFrame.keybindText:Show()
        else
            sparkFrame.keybindText:Hide()
        end
    else
        sparkFrame.keybindText:SetText("")
        sparkFrame.keybindText:Hide()
    end
end

-- ============================ HELPERS ============================
local function clamp01(value)
    if value < 0 then
        return 0
    end
    if value > 1 then
        return 1
    end
    return value
end

local function getSlamIcon()
    local icon = "Interface\\Icons\\Ability_Warrior_Slam"
    if NAG.Spell and NAG.Spell[SLAM_SPELL_ID] and NAG.Spell[SLAM_SPELL_ID].icon then
        icon = NAG.Spell[SLAM_SPELL_ID].icon
    end
    return icon
end

local function getSwingTimings()
    local swingSpeed = NAG:AutoSwingTime(NAG.Types:GetType("SwingType").MainHand)
    local timeToNext, rawTimeToNext = NAG:AutoTimeToNext()
    local timeRemaining = rawTimeToNext or timeToNext or 0
    return timeRemaining, swingSpeed or 0
end

local function applyColor(texture, color)
    if not texture or not color then
        return
    end
    texture:SetColorTexture(color.r, color.g, color.b, color.a)
end

-- ============================ FRAME SETUP ============================

function module:CreateFrames()
    frame = CreateFrame("Frame", "NAGWarriorSlamWeaveBarV2", _G.UIParent)
    frame:SetSize(self.db.class.width, self.db.class.height)
    frame:SetPoint(self.db.class.point, self.db.class.x, self.db.class.y)
    frame:SetAlpha(self.db.class.alpha)
    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:EnableMouse(NAG.IsAnyEditMode and NAG:IsAnyEditMode())

    background = frame:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    applyColor(background, self.db.class.backgroundColor)

    preSwingBar = frame:CreateTexture(nil, "ARTWORK")
    preSwingBar:SetPoint("RIGHT", frame, "CENTER", 0, self.db.class.barOffsetY)
    preSwingBar:SetHeight(self.db.class.barHeight)
    preSwingBar:SetWidth(0)
    applyColor(preSwingBar, self.db.class.preSwingColor)

    preSwingSpark = frame:CreateTexture(nil, "OVERLAY")
    preSwingSpark:SetSize(self.db.class.preSwingSparkWidth, self.db.class.preSwingSparkHeight)
    applyColor(preSwingSpark, self.db.class.preSwingSparkColor)

    swingMarker = frame:CreateTexture(nil, "OVERLAY")
    swingMarker:SetSize(self.db.class.swingMarkerWidth, self.db.class.height)
    swingMarker:SetPoint("CENTER", frame, "CENTER", 0, self.db.class.swingMarkerOffsetY)
    applyColor(swingMarker, self.db.class.swingMarkerColor)

    slamIconFrame = CreateFrame("Frame", nil, frame)
    slamIconFrame:SetSize(self.db.class.slamIconSize, self.db.class.slamIconSize)
    slamIconFrame:SetPoint("CENTER", frame, "CENTER", self.db.class.slamIconOffsetX, self.db.class.slamIconOffsetY)
    slamIconFrame.spellId = SLAM_SPELL_ID
    slamIconTexture = slamIconFrame:CreateTexture(nil, "OVERLAY")
    slamIconTexture:SetAllPoints()
    slamIconTexture:SetTexture(getSlamIcon())
    slamIconTexture:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    local keybindText = slamIconFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    keybindText:SetPoint("BOTTOM", slamIconFrame, "TOP", 0, 2)
    keybindText:SetJustifyH("CENTER")
    keybindText:SetTextColor(1, 1, 0)
    keybindText:SetText("")
    keybindText:Hide()
    slamIconFrame.keybindText = keybindText

    slamTrail = frame:CreateTexture(nil, "ARTWORK")
    slamTrail:SetPoint("LEFT", slamIconFrame, "RIGHT", 0, 0)
    slamTrail:SetHeight(self.db.class.slamTrailHeight)
    slamTrail:SetWidth(0)
    applyColor(slamTrail, self.db.class.slamTrailColor)

    frame:SetScript("OnMouseDown", function(_, button)
        local canDrag = NAG.IsAnyEditMode and NAG:IsAnyEditMode()
        if button == "LeftButton" and canDrag then
            self:StartPositioning()
        end
    end)
    frame:SetScript("OnMouseUp", function(_, button)
        if button == "LeftButton" then
            self:StopPositioning()
        end
    end)
end

--- Effective scale for Warrior bar frame: NAG display scale * universal Warrior bar scale.
local function GetWarriorBarEffectiveScale()
    local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
    local nagScale = (anchor and anchor ~= _G.UIParent and anchor:GetScale()) or 1
    local wm = NAG:GetModule("WarriorSlamWeaveModule", true)
    local barScale = (wm and wm.GetWarriorBarScale and wm:GetWarriorBarScale()) or 1
    return nagScale * barScale
end

function module:UpdateFrameAnchor()
    if not frame then
        return
    end

    local db = self.db.class
    local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
    local anchorValid = anchor and anchor ~= _G.UIParent

    if not db.autoAnchor or not anchorValid then
        frame:SetParent(_G.UIParent)
        frame:ClearAllPoints()
        frame:SetPoint(db.point, db.x, db.y)
        frame:SetScale(GetWarriorBarEffectiveScale())
        return
    end

    frame:SetParent(_G.UIParent)
    frame:ClearAllPoints()
    frame:SetPoint("LEFT", anchor, "RIGHT", db.x, db.y)
    frame:SetScale(GetWarriorBarEffectiveScale())
end

function module:UpdateFrameSettings()
    if not frame then
        return
    end

    local db = self.db.class
    frame:SetSize(db.width, db.height)
    frame:SetAlpha(db.alpha)
    self:UpdateFrameAnchor()

    background:SetShown(db.showBackground)
    applyColor(background, db.backgroundColor)

    preSwingBar:SetHeight(db.barHeight)
    preSwingBar:ClearAllPoints()
    preSwingBar:SetPoint("RIGHT", frame, "CENTER", 0, db.barOffsetY)
    applyColor(preSwingBar, db.preSwingColor)

    preSwingSpark:SetSize(db.preSwingSparkWidth, db.preSwingSparkHeight)
    applyColor(preSwingSpark, db.preSwingSparkColor)

    swingMarker:SetSize(db.swingMarkerWidth, db.height)
    swingMarker:SetPoint("CENTER", frame, "CENTER", 0, db.swingMarkerOffsetY)
    applyColor(swingMarker, db.swingMarkerColor)

    slamIconFrame:SetSize(db.slamIconSize, db.slamIconSize)
    slamIconFrame:SetPoint("CENTER", frame, "CENTER", db.slamIconOffsetX, db.slamIconOffsetY)
    slamIconTexture:SetTexture(getSlamIcon())

    slamTrail:SetHeight(db.slamTrailHeight)
    applyColor(slamTrail, db.slamTrailColor)
end

function module:UpdateVisibility()
    if not frame then
        return
    end
    -- In edit mode: force visible for positioning - check FIRST so bars stay visible when unlocked
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        frame:SetFrameStrata("DIALOG")
        frame:SetFrameLevel(200)
        frame:Show()
        frame:EnableMouse(true)
        return
    end

    if not self.db.class.enabled or not self.db.class.showBar then
        frame:Hide()
        return
    end

    if self.db.class.hideOutOfCombat and not NAG:InCombat("player") then
        frame:Hide()
        return
    end

    local dm = NAG:GetModule("DisplayManager", true)
    local level = dm and dm.GetRecommendedClassBarFrameLevel and dm:GetRecommendedClassBarFrameLevel() or 50
    frame:SetFrameStrata("MEDIUM")
    frame:SetFrameLevel(level)
    frame:Show()
    frame:EnableMouse(false)
end

-- ============================ UPDATE LOOP ============================

function module:UpdateDisplay()
    if not frame or self.state.isDragging or not self.db.class.showBar then
        return
    end
    -- In edit mode, visibility is managed by UpdateVisibility - never hide so user can position
    if NAG.IsAnyEditMode and NAG:IsAnyEditMode() then
        return
    end

    if self.db.class.hideOutOfCombat and not NAG:InCombat("player") then
        frame:Hide()
        if slamIconFrame then SetSparkKeybind(slamIconFrame, false) end
        return
    end

    local timeToNext, swingSpeed = getSwingTimings()
    if not swingSpeed or swingSpeed <= 0 then
        preSwingBar:SetWidth(0)
        preSwingSpark:Hide()
        slamTrail:SetWidth(0)
        if slamIconFrame then SetSparkKeybind(slamIconFrame, false) end
        return
    end

    frame:Show()
    if slamIconFrame then
        SetSparkKeybind(slamIconFrame, self.db.class.showKeybindOnBar)
    end

    local halfWidth = frame:GetWidth() / 2
    local clampedTime = math.min(math.max(timeToNext, 0), swingSpeed)
    local preSwingProgress = clamp01(clampedTime / swingSpeed)
    local preSwingWidth = halfWidth * preSwingProgress

    preSwingBar:SetWidth(preSwingWidth)
    preSwingBar:Show()

    if self.db.class.showPreSwingSpark then
        local sparkX = -halfWidth + ((1 - preSwingProgress) * halfWidth)
        preSwingSpark:ClearAllPoints()
        preSwingSpark:SetPoint("CENTER", frame, "CENTER", sparkX, self.db.class.preSwingSparkOffsetY)
        preSwingSpark:Show()
    else
        preSwingSpark:Hide()
    end

    swingMarker:SetShown(self.db.class.showSwingMarker)

    if self.db.class.showSlamTrail then
        local trailProgress = clamp01(self.db.class.slamGapSeconds / swingSpeed)
        local trailWidth = halfWidth * trailProgress
        slamTrail:SetWidth(trailWidth)
        slamTrail:Show()
    else
        slamTrail:SetWidth(0)
        slamTrail:Hide()
    end
end

-- ============================ EVENT HANDLING ============================

function module:PLAYER_REGEN_DISABLED()
    self:UpdateVisibility()
end

function module:PLAYER_REGEN_ENABLED()
    self:UpdateVisibility()
end

function module:NAG_FRAME_UPDATED()
    if self.db.class.autoAnchor then
        self:UpdateFrameAnchor()
    end
    if frame then
        self:UpdateVisibility()
    end
end

function module:NAG_WARRIOR_BAR_SCALE_UPDATED()
    self:UpdateFrameAnchor()
end

-- ============================ LIFECYCLE ============================

function module:ModuleInitialize()
    local playerClass = NAG.CLASS_FILENAME
    if playerClass ~= "WARRIOR" then
        self:SetEnabledState(false)
        return
    end
end

function module:ModuleEnable()
    local playerClass = NAG.CLASS_FILENAME
    if playerClass ~= "WARRIOR" then
        self:SetEnabledState(false)
        return
    end
    if not self.db.class.enabled then
        return
    end

    if not frame then
        self:CreateFrames()
    end
    self:UpdateFrameSettings()
    self:UpdateVisibility()

    if frame then
        frame:SetScript("OnUpdate", function(_, elapsed)
            lastUpdate = lastUpdate + elapsed
            if lastUpdate >= UPDATE_INTERVAL then
                module:UpdateDisplay()
                lastUpdate = 0
            end
        end)
    end
end

function module:ModuleDisable()
    if frame then
        frame:SetScript("OnUpdate", nil)
        frame:Hide()
    end
end

-- ============================ POSITIONING ============================

function module:StartPositioning()
    if not frame then
        return
    end
    self.state.isDragging = true
    frame:StartMoving()
end

function module:StopPositioning()
    if not frame then
        return
    end
    frame:StopMovingOrSizing()
    self.state.isDragging = false

    local db = self.db.class
    local anchor = NAG.GetDisplayAnchor and NAG:GetDisplayAnchor() or nil
    if anchor and anchor ~= _G.UIParent and db.autoAnchor then
        local barLeft = frame:GetLeft()
        local barCenterY = select(2, frame:GetCenter())
        local anchorRight = anchor:GetRight()
        local anchorCenterY = select(2, anchor:GetCenter())
        if barLeft and barCenterY and anchorRight and anchorCenterY then
            local offsetX = barLeft - anchorRight
            local offsetY = barCenterY - anchorCenterY
            frame:SetParent(_G.UIParent)
            frame:ClearAllPoints()
            frame:SetPoint("LEFT", anchor, "RIGHT", offsetX, offsetY)
            db.point = "LEFT"
            db.x = offsetX
            db.y = offsetY
        end
    else
        local left, bottom = frame:GetLeft(), frame:GetBottom()
        if left and bottom then
            frame:SetParent(_G.UIParent)
            frame:ClearAllPoints()
            frame:SetPoint("BOTTOMLEFT", _G.UIParent, "BOTTOMLEFT", left, bottom)
        end
        local point, _, _, x, y = frame:GetPoint(1)
        db.point = point
        db.x = x
        db.y = y
    end
end

-- ============================ OPTIONS ============================

function module:GetOptions()
    local OptionsFactory = NAG:GetModule("OptionsFactory")
    if not OptionsFactory then
        return { type = "group", args = {} }
    end
    return {
        type = "group",
        name = "Slam Weave Bar V2",
        order = 28,
        args = {
            showKeybindOnBar = OptionsFactory:CreateToggle(
                "Show Keybind Above Bar Icons",
                "Display the keybind above the Slam icon on the bar.",
                function() return self.db.class.showKeybindOnBar end,
                function(_, value)
                    self.db.class.showKeybindOnBar = value
                    self:UpdateDisplay()
                end,
                { order = 1 }
            ),
        },
    }
end

-- ============================ SLASH COMMAND ============================

function module:HandleSlash(input)
    local command = (input or ""):lower()
    if command == "" or command == "toggle" then
        self.db.class.showBar = not self.db.class.showBar
    elseif command == "show" then
        self.db.class.enabled = true
        self.db.class.showBar = true
        self.db.class.hideOutOfCombat = false
    elseif command == "hide" then
        self.db.class.showBar = false
    elseif command == "lock" then
        local dm = NAG:GetModule("DisplayManager")
        if dm then dm.classHelperEditMode = false; NAG:SendMessage("NAG_FRAME_UPDATED") end
    elseif command == "unlock" then
        local dm = NAG:GetModule("DisplayManager")
        if dm then dm.classHelperEditMode = true; NAG:SendMessage("NAG_FRAME_UPDATED") end
    elseif command == "reset" then
        self.db.class.point = "CENTER"
        self.db.class.x = 360
        self.db.class.y = 18
        self.db.class.autoAnchor = true
    end

    if not frame then
        self:CreateFrames()
    end
    self:UpdateFrameSettings()
    self:UpdateVisibility()
end
