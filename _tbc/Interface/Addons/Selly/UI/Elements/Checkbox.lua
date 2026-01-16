local _, Addon = ...
local UI = Addon.UI
local Functions = Addon.Functions
local Assets = Addon.Assets
local Colors = Addon.Colors

--------------------------------------------
-- CREATE CHECKBOX
--------------------------------------------

-- Name, Text, ParentFrameName, Point1 [, FontColor, DisableHoverEffect]

function UI:CreateCheckbox(Settings)
    local Point1, Point1Frame, Point1Relative, Point1X, Point1Y = unpack(Settings.Point1)

    local Checkbox = CreateFrame("CheckButton", UI:FrameName(Settings.Name), UI:GetFrame(Settings.ParentFrameName), "UICheckButtonTemplate")
    Checkbox:SetPoint(Point1, UI:GetPointFrame(Point1Frame), Point1Relative, Point1X, Point1Y)

    Checkbox.lblText = Checkbox:CreateFontString(UI:FrameName(Settings.Name)..".lblText", "OVERLAY")
    Checkbox.lblText:SetPoint("LEFT", Checkbox, "LEFT", 35, 0)
    Checkbox.lblText:SetFontObject(UI:GetFontObject("Asap.ttf", 14))
    Checkbox.lblText:SetJustifyH("LEFT")

    if (Settings.FontColor) then
        Checkbox.lblText:SetText(Functions:PrintColor(Settings.Text, Settings.FontColor))
    else
        Checkbox.lblText:SetText(Settings.Text)
    end

    if (not Settings.DisableHoverEffect and not Settings.FontColor) then
        UI:EnableCheckbox(Settings.Name)
    end
end

function UI:EnableCheckbox(CheckboxName)
    local Checkbox = UI:GetFrame(CheckboxName)
    local CheckboxLabel = UI:GetFrame(CheckboxName..".lblText")
    local CheckboxText = UI:GetText(CheckboxLabel)

    UI:SetEnabled(Checkbox, true)
    UI:SetText(CheckboxLabel, Functions:PrintColor(UI:GetText(CheckboxLabel), Colors.white))

    UI:SetScript("OnMouseDown", CheckboxLabel, function(Self, Button) if (Button == "LeftButton") then Checkbox:Click() end end)
    UI:SetScript("OnEnter", CheckboxLabel, function(Self) Self:SetText(Functions:PrintColor(CheckboxText, Colors.orange3)) end)
    UI:SetScript("OnLeave", CheckboxLabel, function(Self) Self:SetText(Functions:PrintColor(CheckboxText, Colors.white)) end)
end

function UI:DisableCheckbox(CheckboxName)
    local Checkbox = UI:GetFrame(CheckboxName)
    local CheckboxLabel = UI:GetFrame(CheckboxName..".lblText")

    UI:SetEnabled(Checkbox, false)
    UI:SetText(CheckboxLabel, Functions:PrintColor(UI:GetText(CheckboxLabel), Colors.disabled))

    UI:UnsetScript("OnMouseDown", CheckboxLabel)
    UI:UnsetScript("OnEnter", CheckboxLabel)
    UI:UnsetScript("OnLeave", CheckboxLabel)
end
