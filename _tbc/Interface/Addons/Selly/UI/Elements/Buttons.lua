local _, Addon = ...
local UI = Addon.UI
local Functions = Addon.Functions
local Assets = Addon.Assets
local Colors = Addon.Colors

--------------------------------------------
-- CREATE BUTTON
--------------------------------------------

-- Name, Text, ParentFrameName, Point1 [, Point2, Size, IsDisabled]

function UI:CreateButton(Settings)
    local Width, Height = unpack(Functions:Condition(Settings.Size, Settings.Size, { 100, 35 }))
    local Point1, Point1Frame, Point1Relative, Point1X, Point1Y = unpack(Settings.Point1)
    local Point2, Point2Frame, Point2Relative, Point2X, Point2Y = unpack(Functions:Condition(Settings.Point2, Settings.Point2, {}))

    local Button = UI:GetPoolFrame("Button", UI:FrameName(Settings.Name), UI:GetFrame(Settings.ParentFrameName), "BackdropTemplate")
    Button:SetSize(Width, Height)
    Button:SetPoint(Point1, UI:GetPointFrame(Point1Frame), Point1Relative, Point1X, Point1Y)
    if (Point2) then Button:SetPoint(Point2, UI:GetPointFrame(Point2Frame), Point2Relative, Point2X, Point2Y) end
    Button:SetBackdrop(UI.Backdrop)
    Button:SetBackdropColor(UI:HexToRGB("#000", 0.8))
    Button:SetBackdropBorderColor(UI:HexToRGB("#1a1a1a"))
    Button:SetNormalFontObject(UI:GetFontObject("Asap.ttf", 16))
    Button:SetText(Functions:PrintColor(Settings.Text, Colors.orange))

    Button:SetScript("OnEnter", function(Self, Button) Self:SetBackdropBorderColor(UI:HexToRGB("#ffd100", 0.5)) end)
    Button:SetScript("OnLeave", function(Self, Button) Self:SetBackdropBorderColor(UI:HexToRGB("#1a1a1a")) end)

    if (Settings.IsDisabled) then
        UI:DisableButton(UI:FrameName(Settings.Name))
    end
end

function UI:EnableButton(ButtonName)
    UI:SetEnabled(ButtonName, true)
    UI:SetText(ButtonName, Functions:PrintColor(UI:GetText(ButtonName), Colors.orange))
end

function UI:DisableButton(ButtonName)
    UI:SetEnabled(ButtonName, false)
    UI:SetText(ButtonName, Functions:PrintColor(UI:GetText(ButtonName), Colors.disabled))
end

--------------------------------------------
-- CREATE IMAGE BUTTON
--------------------------------------------

-- Name, ParentFrameName, Size, Point1, AssetName [, AssetHoverName, Point2]

function UI:CreateImageButton(Settings)
    local Width, Height = unpack(Functions:Condition(Settings.Size, Settings.Size, { 0, 0 }))
    local Point1, Point1Frame, Point1Relative, Point1X, Point1Y = unpack(Settings.Point1)
    local Point2, Point2Frame, Point2Relative, Point2X, Point2Y = unpack(Functions:Condition(Settings.Point2, Settings.Point2, {}))

    local Button = UI:GetPoolFrame("Button", UI:FrameName(Settings.Name), UI:GetFrame(Settings.ParentFrameName), "BackdropTemplate")
    Button:SetPoint(Point1, UI:GetPointFrame(Point1Frame), Point1Relative, Point1X, Point1Y)
    if (Point2) then Button:SetPoint(Point2, UI:GetPointFrame(Point2Frame), Point2Relative, Point2X, Point2Y) end
    Button:SetSize(Width, Height)
    Button:SetNormalTexture(Assets.Images[Settings.AssetName])

    if (Settings.AssetHoverName) then
        Button:SetScript("OnEnter", function(Self, Button) Self:SetNormalTexture(Assets.Images[Settings.AssetHoverName]) end)
        Button:SetScript("OnLeave", function(Self, Button) Self:SetNormalTexture(Assets.Images[Settings.AssetName]) end)
    end
end

--------------------------------------------
-- CREATE ICON BUTTON
--------------------------------------------

-- Name, ParentFrameName, Size, Point1 [, Point2, Icon]

function UI:CreateIconButton(Settings)
    local Width, Height = unpack(Functions:Condition(Settings.Size, Settings.Size, { 32, 32 }))
    local Point1, Point1Frame, Point1Relative, Point1X, Point1Y = unpack(Settings.Point1)
    local Point2, Point2Frame, Point2Relative, Point2X, Point2Y = unpack(Functions:Condition(Settings.Point2, Settings.Point2, {}))

    local Button = UI:GetPoolFrame("Button", UI:FrameName(Settings.Name), UI:GetFrame(Settings.ParentFrameName), "BackdropTemplate")
    Button:SetPoint(Point1, UI:GetPointFrame(Point1Frame), Point1Relative, Point1X, Point1Y)
    if (Point2) then Button:SetPoint(Point2, UI:GetPointFrame(Point2Frame), Point2Relative, Point2X, Point2Y) end
    Button:SetSize(Width, Height)
    Button:SetNormalTexture(Functions:Condition(Settings.Icon, Settings.Icon, 134400))
end
