local ADDON_NAME, Addon = ...

local MasqueLib = LibStub and LibStub("Masque", true)

local DATABASE_DEFAULTS = {
    wheelCount = 1,
    multipleWheelsOpen = false,
}

local WHEEL_DEFAULTS = {
    label = nil,
    binding = nil,
    dismissOnUse = true,
    quickCast = false,
    size = 100,
    rotation = 0,
    slotStart = 13,
    slotCount = 12,
    bgSize = 1.5,
    bgTint = { red = 0, green = 0, blue = 0, alpha = 0.5 },
}

local TWO_PI = math.pi * 2
local DEAD_ZONE_RADIUS = 20

Addon.frames = {}

RadialWheelDB = RadialWheelDB or {}
RadialWheelProfiles = RadialWheelProfiles or {}

local function CloneTable(source)
    if type(source) ~= "table" then return source end
    local result = {}
    for key, value in pairs(source) do
        result[CloneTable(key)] = CloneTable(value)
    end
    return result
end

local function ApplyDefaults(target, defaults)
    for key, defaultValue in pairs(defaults) do
        if target[key] == nil then
            target[key] = CloneTable(defaultValue)
        end
    end
end

Addon.CloneTable = CloneTable
Addon.ApplyDefaults = ApplyDefaults

-- Determines which slot the cursor is pointing at based on angle from wheel center
-- Each slice is centered on its button, so boundaries fall between buttons
local function GetHoveredSlot(container, profile)
    local centerX, centerY = container:GetCenter()
    local cursorX, cursorY = GetCursorPosition()
    local uiScale = container:GetEffectiveScale()
    cursorX, cursorY = cursorX / uiScale, cursorY / uiScale

    local deltaX, deltaY = cursorX - centerX, cursorY - centerY
    local distanceSquared = deltaX * deltaX + deltaY * deltaY
    if distanceSquared < DEAD_ZONE_RADIUS * DEAD_ZONE_RADIUS then
        return nil
    end

    local cursorAngle = math.atan2(deltaY, deltaX)
    if cursorAngle < 0 then
        cursorAngle = cursorAngle + TWO_PI
    end

    local sliceWidth = TWO_PI / profile.slotCount
    local halfSlice = sliceWidth / 2
    local rotationRadians = profile.rotation * math.pi / 180

    -- First button is at top (90 deg / pi/2). Offset by half slice so boundaries fall between buttons
    local angleDifference = (math.pi / 2 - rotationRadians + halfSlice) - cursorAngle
    while angleDifference < 0 do angleDifference = angleDifference + TWO_PI end
    while angleDifference >= TWO_PI do angleDifference = angleDifference - TWO_PI end

    local slotIndex = math.floor(angleDifference / sliceWidth) + 1
    return math.max(1, math.min(slotIndex, profile.slotCount))
end

-- Adds a glow texture behind a button for hover highlight
local function CreateButtonGlow(button)
    if button.glowTexture then return end

    local glow = button:CreateTexture(nil, "BACKGROUND", nil, -1)
    glow:SetPoint("CENTER", button, "CENTER", 0, 0)
    glow:SetSize(button:GetWidth() * 2, button:GetHeight() * 2)
    glow:SetTexture("Interface\\SpellActivationOverlay\\IconAlert")
    glow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)
    glow:SetVertexColor(1, 0.9, 0.5, 0.9)
    glow:Hide()

    button.glowTexture = glow
end

local function UpdateQuickCastHighlight(container, hoveredSlot, profile)
    if not container.actions then return end

    for index, button in ipairs(container.actions) do
        -- Create glow on first use
        if not button.glowTexture then
            CreateButtonGlow(button)
        end

        if index == hoveredSlot then
            button:LockHighlight()
            button.glowTexture:Show()
        else
            button:UnlockHighlight()
            button.glowTexture:Hide()
        end
    end
end

local function ClearQuickCastHighlight(container)
    if not container.actions then return end

    for _, button in ipairs(container.actions) do
        button:UnlockHighlight()
        if button.glowTexture then
            button.glowTexture:Hide()
        end
    end
end

function Addon:CreateWheel()
    RadialWheelDB.wheelCount = RadialWheelDB.wheelCount + 1
    local wheelIndex = RadialWheelDB.wheelCount
    RadialWheelProfiles[wheelIndex] = CloneTable(WHEEL_DEFAULTS)
    self:BuildAllWheels()
    return wheelIndex
end

function Addon:DestroyWheel(wheelIndex)
    table.remove(RadialWheelProfiles, wheelIndex)
    RadialWheelDB.wheelCount = RadialWheelDB.wheelCount - 1
    self:BuildAllWheels()
end

function Addon:BuildWheel(wheelIndex)
    local profile = RadialWheelProfiles[wheelIndex]
    if not profile then return end

    if not self.frames[wheelIndex] then
        local container = CreateFrame("Frame", "RadialWheel" .. wheelIndex, UIParent)
        container.wheelIndex = wheelIndex
        self.frames[wheelIndex] = container

        local background = container:CreateTexture(nil, "BACKGROUND")
        background:SetAllPoints()
        background:SetTexture("Interface\\AddOns\\RingMenuReborn\\RingMenuBackdrop.tga")
        container.background = background

        local toggleButton = CreateFrame("Button", "RadialWheelToggle" .. wheelIndex, container, "SecureActionButtonTemplate,SecureHandlerBaseTemplate")
        toggleButton:SetFrameRef("GameParent", UIParent)
        toggleButton:RegisterForClicks("AnyDown", "AnyUp")

        -- PreClick: On key down show wheel, on key up (quick cast) execute hovered action
        SecureHandlerWrapScript(toggleButton, "PreClick", toggleButton, [[
            local wheel = self:GetParent()
            local gameParent = self:GetFrameRef("GameParent")

            if down then
                local totalWheels = self:GetAttribute("totalWheels") or 0
                if wheel:IsShown() then
                    if not self:GetAttribute("quickCast") then
                        wheel:Hide()
                    end
                else
                    if not self:GetAttribute("allowStacking") then
                        for i = 1, totalWheels do
                            local otherWheel = self:GetFrameRef("wheel" .. i)
                            if otherWheel then otherWheel:Hide() end
                        end
                    end
                    local mouseX, mouseY = gameParent:GetMousePosition()
                    wheel:ClearAllPoints()
                    wheel:SetPoint("CENTER", gameParent, "BOTTOMLEFT", mouseX * gameParent:GetWidth(), mouseY * gameParent:GetHeight())
                    wheel:Show()
                end
                self:SetAttribute("type", nil)
                self:SetAttribute("action", nil)
            else
                if self:GetAttribute("quickCast") and wheel:IsShown() then
                    local hoveredSlot = self:GetAttribute("quickcastslot")
                    if hoveredSlot then
                        local slotButton = self:GetFrameRef("slot" .. hoveredSlot)
                        if slotButton then
                            self:SetAttribute("type", "action")
                            self:SetAttribute("action", slotButton:GetAttribute("action"))
                        end
                    end
                    wheel:Hide()
                else
                    self:SetAttribute("type", nil)
                    self:SetAttribute("action", nil)
                end
            end
        ]])

        SecureHandlerWrapScript(toggleButton, "PostClick", toggleButton, [[
            self:SetAttribute("type", nil)
            self:SetAttribute("action", nil)
        ]])

        container.toggle = toggleButton

        container:SetScript("OnUpdate", function(self)
            if not self:IsShown() then return end
            local wheelProfile = RadialWheelProfiles[self.wheelIndex]
            if not wheelProfile or not wheelProfile.quickCast then
                ClearQuickCastHighlight(self)
                return
            end
            local hoveredSlot = GetHoveredSlot(self, wheelProfile)
            self.toggle:SetAttribute("quickcastslot", hoveredSlot)
            UpdateQuickCastHighlight(self, hoveredSlot, wheelProfile)
        end)

        container:SetScript("OnHide", function(self)
            ClearQuickCastHighlight(self)
            self.toggle:SetAttribute("quickcastslot", nil)
        end)

        container:Hide()
    end

    local container = self.frames[wheelIndex]
    local frameDimension = 2 * profile.size * profile.bgSize
    container:SetSize(frameDimension, frameDimension)
    container.background:SetVertexColor(profile.bgTint.red, profile.bgTint.green, profile.bgTint.blue, profile.bgTint.alpha)

    container.toggle:SetAttribute("allowStacking", RadialWheelDB.multipleWheelsOpen)
    container.toggle:SetAttribute("quickCast", profile.quickCast)
    container:SetAttribute("dismissOnUse", profile.dismissOnUse)

    container.actions = container.actions or {}
    for slotIndex = 1, profile.slotCount do
        if not container.actions[slotIndex] then
            local actionButton = CreateFrame("CheckButton", container:GetName() .. "Slot" .. slotIndex, container, "ActionBarButtonTemplate")
            actionButton.wheelIndex = wheelIndex
            actionButton.slotIndex = slotIndex
            container.actions[slotIndex] = actionButton

            if MasqueLib then
                MasqueLib:Group("RingMenuReborn"):AddButton(actionButton)
            end

            container.toggle:WrapScript(actionButton, "OnClick", [[
                local wheel = self:GetParent()
                if wheel:GetAttribute("dismissOnUse") then
                    wheel:Hide()
                end
            ]])
        end

        local actionButton = container.actions[slotIndex]
        local buttonAngle = TWO_PI * (0.25 - (slotIndex - 1) / profile.slotCount - profile.rotation / 360)
        actionButton:ClearAllPoints()
        actionButton:SetPoint("CENTER", container, "CENTER", profile.size * math.cos(buttonAngle), profile.size * math.sin(buttonAngle))
        actionButton:SetAttribute("type", "action")
        actionButton:SetAttribute("action", profile.slotStart + slotIndex - 1)
        actionButton:Show()
        container.toggle:SetFrameRef("slot" .. slotIndex, actionButton)
    end

    for index = profile.slotCount + 1, #container.actions do
        container.actions[index]:Hide()
    end
end

function Addon:LinkWheels()
    local wheelCount = RadialWheelDB.wheelCount
    for wheelIndex = 1, wheelCount do
        local container = self.frames[wheelIndex]
        if container then
            for otherIndex = 1, wheelCount do
                if self.frames[otherIndex] then
                    container.toggle:SetFrameRef("wheel" .. otherIndex, self.frames[otherIndex])
                end
            end
            container.toggle:SetAttribute("totalWheels", wheelCount)
        end
    end
end

function Addon:BuildAllWheels()
    for wheelIndex = 1, RadialWheelDB.wheelCount do
        self:BuildWheel(wheelIndex)
    end
    self:LinkWheels()
end

local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:SetScript("OnEvent", function(_, event, loadedAddon)
    if loadedAddon ~= ADDON_NAME then return end

    ApplyDefaults(RadialWheelDB, DATABASE_DEFAULTS)
    for wheelIndex = 1, RadialWheelDB.wheelCount do
        RadialWheelProfiles[wheelIndex] = RadialWheelProfiles[wheelIndex] or {}
        ApplyDefaults(RadialWheelProfiles[wheelIndex], WHEEL_DEFAULTS)
    end

    Addon:BuildAllWheels()
    Addon:SetupSettingsPanel()
end)

SLASH_RADIALWHEEL1 = "/rmr"
SLASH_RADIALWHEEL2 = "/radialwheel"
SlashCmdList["RADIALWHEEL"] = function()
    if Settings and Settings.OpenToCategory and Addon.settingsCategoryID then
        Settings.OpenToCategory(Addon.settingsCategoryID)
    else
        InterfaceOptionsFrame_OpenToCategory("RingMenu Reborn")
        InterfaceOptionsFrame_OpenToCategory("RingMenu Reborn")
    end
end
