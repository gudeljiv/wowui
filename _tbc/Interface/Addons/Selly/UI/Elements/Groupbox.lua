local _, Addon = ...
local UI = Addon.UI
local Functions = Addon.Functions
local Assets = Addon.Assets

--------------------------------------------
-- CREATE CHECKBOX
--------------------------------------------

-- Name, Title, ParentFrameName, Point1 [, Point2, Size]

function UI:CreateGroupBox(Settings)
    local Width, Height = unpack(Functions:Condition(Settings.Size, Settings.Size, { 0, 0 }))
    local Point1, Point1Frame, Point1Relative, Point1X, Point1Y = unpack(Settings.Point1)
    local Point2, Point2Frame, Point2Relative, Point2X, Point2Y = unpack(Functions:Condition(Settings.Point2, Settings.Point2, {}))

    local Groupbox = CreateFrame("Frame", UI:FrameName(Settings.Name), UI:GetFrame(Settings.ParentFrameName), "BackdropTemplate")
    Groupbox:SetSize(Width, Height)
    Groupbox:SetPoint(Point1, UI:GetPointFrame(Point1Frame), Point1Relative, Point1X, Point1Y)
    if (Point2) then Groupbox:SetPoint(Point2, UI:GetPointFrame(Point2Frame), Point2Relative, Point2X, Point2Y) end
    Groupbox:SetBackdrop(UI.Backdrop)
    Groupbox:SetBackdropColor(UI:HexToRGB("#fff", 0.07))
    Groupbox:SetBackdropBorderColor(UI:HexToRGB("#000", 0))

    local BorderTopLeft = Groupbox:CreateLine()
    BorderTopLeft:SetColorTexture(UI:HexToRGB("#46413e", 0.3))
    BorderTopLeft:SetStartPoint("TOPLEFT", -1, 0)
    BorderTopLeft:SetEndPoint("TOPLEFT", 15, 0)
    BorderTopLeft:SetThickness(1.5)

    Groupbox.TitleBG = CreateFrame("Frame", UI:FrameName(Settings.Name)..".TitleBG", Groupbox, "BackdropTemplate")
    Groupbox.TitleBG:SetPoint("LEFT", BorderTopLeft, "LEFT", 10, 0)
    Groupbox.TitleBG:SetBackdrop(UI.Backdrop)
    Groupbox.TitleBG:SetBackdropColor(UI:HexToRGB("#000", 0.6))
    Groupbox.TitleBG:SetBackdropBorderColor(UI:HexToRGB("#46413e", 0.3))
    Groupbox.TitleBG:SetHeight(22)

    BorderTopLeft.Title = Groupbox.TitleBG:CreateFontString(UI:FrameName(Settings.Name)..".Title", "OVERLAY")
    BorderTopLeft.Title:SetPoint("LEFT", BorderTopLeft, "LEFT", 20, 0)
    BorderTopLeft.Title:SetFont(Assets.Fonts["Asap.ttf"], 11)
    BorderTopLeft.Title:SetTextColor(UI:HexToRGB("#b5b5b5"))
    BorderTopLeft.Title:SetText(Settings.Title)

    Groupbox.TitleBG:SetPoint("RIGHT", BorderTopLeft.Title, "RIGHT", 10, 0)

    local BorderTopRight = Groupbox:CreateLine()
    BorderTopRight:SetColorTexture(UI:HexToRGB("#46413e", 0.3))
    BorderTopRight:SetStartPoint("RIGHT", Groupbox.TitleBG, "RIGHT", 0, 0)
    BorderTopRight:SetEndPoint("TOPRIGHT", -1, 0)
    BorderTopRight:SetThickness(1.5)

    local BorderRight = Groupbox:CreateLine()
    BorderRight:SetColorTexture(UI:HexToRGB("#46413e", 0.3))
    BorderRight:SetStartPoint("TOPRIGHT", 0, 1)
    BorderRight:SetEndPoint("BOTTOMRIGHT", 0, -1)
    BorderRight:SetThickness(1.5)

    local BorderBottom = Groupbox:CreateLine()
    BorderBottom:SetColorTexture(UI:HexToRGB("#46413e", 0.3))
    BorderBottom:SetStartPoint("BOTTOMLEFT", 1, 0)
    BorderBottom:SetEndPoint("BOTTOMRIGHT", -1, 0)
    BorderBottom:SetThickness(1.5)

    local BorderLeft = Groupbox:CreateLine()
    BorderLeft:SetColorTexture(UI:HexToRGB("#46413e", 0.3))
    BorderLeft:SetStartPoint("TOPLEFT", 0, -1)
    BorderLeft:SetEndPoint("BOTTOMLEFT", 0, -1)
    BorderLeft:SetThickness(1.5)
end
