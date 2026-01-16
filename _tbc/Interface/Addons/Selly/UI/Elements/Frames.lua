local _, Addon = ...
local UI = Addon.UI
local Functions = Addon.Functions
local Assets = Addon.Assets

--------------------------------------------
-- CREATE MAIN FRAME
--------------------------------------------

-- Name, Title, Size [, FrameLevel]

function UI:CreateMainFrame(Settings)
    local Width, Height = unpack(Settings.Size)

    local Frame = UI:GetPoolFrame("Frame", UI:FrameName(Settings.Name), UIParent, "BackdropTemplate")
    Frame:SetMovable(true)
    Frame:SetUserPlaced(true)
    Frame:EnableMouse(true)
    Frame:SetSize(Width, Height)
    Frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    Frame:SetBackdrop(UI.Backdrop)
    Frame:SetBackdropColor(UI:HexToRGB("#000", 0.8))
    Frame:SetBackdropBorderColor(UI:HexToRGB("#000"))
    Frame:RegisterForDrag("LeftButton")
    Frame:SetScript("OnDragStart", Frame.StartMoving)
    Frame:SetScript("OnDragStop", Frame.StopMovingOrSizing)
    Frame:Hide()

    Frame.TitleBG = CreateFrame("Frame", UI:FrameName(Settings.Name)..".TitleBG", Frame, "BackdropTemplate")
    Frame.TitleBG:SetPoint("TOPLEFT", Frame, "TOPLEFT", 1, -1)
    Frame.TitleBG:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -1, 1)
    Frame.TitleBG:SetBackdrop(UI.Backdrop)
    Frame.TitleBG:SetBackdropColor(UI:HexToRGB("#000"))
    Frame.TitleBG:SetBackdropBorderColor(UI:HexToRGB("#000"))
    Frame.TitleBG:SetHeight(30)

    Frame.TitleBG.Title = Frame.TitleBG:CreateFontString(UI:FrameName(Settings.Name)..".Title", "OVERLAY")
    Frame.TitleBG.Title:SetPoint("LEFT", Frame.TitleBG, "LEFT", 10, 0)
    Frame.TitleBG.Title:SetFontObject(UI:GetFontObject("Asap.ttf", 16))
    Frame.TitleBG.Title:SetTextColor(UI:HexToRGB("#ffd100"))
    Frame.TitleBG.Title:SetText(Settings.Title)

    Frame.TitleBG.CloseButton = CreateFrame("Button", UI:FrameName(Settings.Name)..".CloseButton", Frame.TitleBG, "BackdropTemplate")
    Frame.TitleBG.CloseButton:SetSize(16, 16)
    Frame.TitleBG.CloseButton:SetPoint("RIGHT", Frame.TitleBG, "RIGHT", -8, 0)
    Frame.TitleBG.CloseButton:SetNormalTexture(Assets.Images["Close.blp"])
    Frame.TitleBG.CloseButton:SetScript("OnEnter", function(Self, Button) Self:SetNormalTexture(Assets.Images["Close-Hover.blp"]) end)
    Frame.TitleBG.CloseButton:SetScript("OnLeave", function(Self, Button) Self:SetNormalTexture(Assets.Images["Close.blp"]) end)
    Frame.TitleBG.CloseButton:SetScript("OnClick", function(Self, Button) Frame:Hide() end)
end

--------------------------------------------
-- CREATE FRAME
--------------------------------------------

-- Name, Size, Point1 [, Point2, ParentFrameName, IsStandalone]

function UI:CreateFrame(Settings)
    local WhichParentFrame = Functions:Condition(Settings.IsStandalone, UIParent, UI:GetFrame(Settings.ParentFrameName))

    local Width, Height = unpack(Functions:Condition(Settings.Size, Settings.Size, { 0, 0 }))
    local WhichPoint = Functions:Condition(Settings.Point1, Settings.Point1, { "CENTER", UIParent, "CENTER", 0, 0 })
    local Point1, Point1Frame, Point1Relative, Point1X, Point1Y = unpack(WhichPoint)
    local Point2, Point2Frame, Point2Relative, Point2X, Point2Y = unpack(Functions:Condition(Settings.Point2, Settings.Point2, {}))

    local Frame = UI:GetPoolFrame("Frame", UI:FrameName(Settings.Name), WhichParentFrame, "BackdropTemplate")
    Frame:SetSize(Width, Height)
    Frame:SetPoint(Point1, UI:GetPointFrame(Point1Frame), Point1Relative, Point1X, Point1Y)
    if (Point2) then Frame:SetPoint(Point2, UI:GetPointFrame(Point2Frame), Point2Relative, Point2X, Point2Y) end
    Frame:SetBackdrop(UI.Backdrop)

    if (Settings.IsStandalone) then
        Frame:SetBackdropColor(UI:HexToRGB("#000", 0.8))
        Frame:SetBackdropBorderColor(UI:HexToRGB("#000"))
    else
        Frame:SetBackdropColor(UI:HexToRGB("#fff", 0.07))
        Frame:SetBackdropBorderColor(UI:HexToRGB("#46413e", 0.3))
    end

    if (Settings.IsStandalone) then
        Frame:SetMovable(true)
        Frame:SetUserPlaced(true)
        Frame:EnableMouse(true)
        Frame:RegisterForDrag("LeftButton")
        Frame:SetScript("OnDragStart", Frame.StartMoving)
        Frame:SetScript("OnDragStop", Frame.StopMovingOrSizing)
        Frame:Hide()
    end
end
