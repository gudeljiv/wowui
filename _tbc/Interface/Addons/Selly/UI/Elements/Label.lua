local _, Addon = ...
local UI = Addon.UI
local Functions = Addon.Functions
local Assets = Addon.Assets

--------------------------------------------
-- CREATE CHECKBOX
--------------------------------------------

-- Name, ParentFrameName, Point1 [, Point2, Text, FontSize, FontColor, Align]

function UI:CreateLabel(Settings)
    local Point1, Point1Frame, Point1Relative, Point1X, Point1Y = unpack(Settings.Point1)
    local Point2, Point2Frame, Point2Relative, Point2X, Point2Y = unpack(Functions:Condition(Settings.Point2, Settings.Point2, {}))

    local Label = UI:GetFrame(Settings.ParentFrameName):CreateFontString(UI:FrameName(Settings.Name), "OVERLAY")
    Label:SetPoint(Point1, UI:GetPointFrame(Point1Frame), Point1Relative, Point1X, Point1Y)
    if (Point2) then Label:SetPoint(Point2, UI:GetPointFrame(Point2Frame), Point2Relative, Point2X, Point2Y) end
    -- Label:SetFontObject(UI:GetFontObject("Asap.ttf", Functions:Condition(Settings.FontSize, Settings.FontSize, 14)))
    Label:SetFont(Assets.Fonts["Asap.ttf"], Functions:Condition(Settings.FontSize, Settings.FontSize, 14))
    Label:SetTextColor(UI:HexToRGB(Functions:Condition(Settings.FontColor, Settings.FontColor, "#fff")))
    if (Settings.Align) then Label:SetJustifyH(Settings.Align) end
    Label:SetText(Functions:Condition(Settings.Text, Settings.Text, ""))
end
