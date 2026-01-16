local _, Addon = ...
local Core = Addon.Core
local UI = Addon.UI
local Functions = Addon.Functions
local Assets = Addon.Assets
local Colors = Addon.Colors

--------------------------------------------
-- DISPLAY DIALOG
--------------------------------------------

-- [Title, ] Text, LeftButtonText, RightButtonText

function UI:DisplayDialog(Settings)
    UI:HideDialogs()

    UI:SetText("DialogFrame.Title", Functions:Condition(Settings.Title, Settings.Title, Core.AddonName..": Info"))
    UI:SetText("DialogFrame.Label", Settings.Text)
    UI:SetText("DialogFrame.LeftButton", Settings.LeftButtonText)
    UI:SetText("DialogFrame.RightButton", Settings.RightButtonText)

    if (Settings.RightButtonText == "Cancel") then
        UI:SetScript("OnClick", "DialogFrame.RightButton", function(Self, Button)
            UI:Hide("DialogFrame")
        end)
    else
        UI:SetScript("OnClick", "DialogFrame.RightButton", nil)
    end

    local FrameHeight = 0
    FrameHeight = FrameHeight + UI:GetHeight("DialogFrame.Label")
    FrameHeight = FrameHeight + UI:GetHeight("DialogFrame.LeftButton")
    FrameHeight = FrameHeight + 90

    UI:SetHeight("DialogFrame", FrameHeight)
    UI:Show("DialogFrame")
end

--------------------------------------------
-- DISPLAY DIALOG TEXTBOX
--------------------------------------------

-- [Title, ] Text, LeftButtonText, RightButtonText [, TextboxText, HighlightTextboxText]

function UI:DisplayDialogTextbox(Settings)
    UI:HideDialogs()

    UI:SetText("DialogTextboxFrame.Title", Functions:Condition(Settings.Title, Settings.Title, Core.AddonName..": Info"))
    UI:SetText("DialogTextboxFrame.Label", Settings.Text)
    UI:SetText("DialogTextboxFrame.LeftButton", Settings.LeftButtonText)
    UI:SetText("DialogTextboxFrame.RightButton", Settings.RightButtonText)
    UI:SetText("DialogTextboxFrame.Textbox.Textbox", Functions:Condition(Settings.TextboxText, Settings.TextboxText, ""))

    if (Settings.RightButtonText == "Cancel") then
        UI:SetScript("OnClick", "DialogTextboxFrame.RightButton", function(Self, Button)
            UI:Hide("DialogTextboxFrame")
        end)
    else
        UI:SetScript("OnClick", "DialogTextboxFrame.RightButton", nil)
    end

    local FrameHeight = 0
    FrameHeight = FrameHeight + UI:GetHeight("DialogTextboxFrame.Label")
    FrameHeight = FrameHeight + UI:GetHeight("DialogTextboxFrame.LeftButton")
    FrameHeight = FrameHeight + UI:GetHeight("DialogTextboxFrame.Textbox")
    FrameHeight = FrameHeight + 105

    UI:SetHeight("DialogTextboxFrame", FrameHeight)
    UI:Show("DialogTextboxFrame")
    UI:SetFocus("DialogTextboxFrame.Textbox.Textbox")

    if (Settings.HighlightTextboxText) then
        UI:HighlightText("DialogTextboxFrame.Textbox.Textbox")
    end
end

--------------------------------------------
-- HIDE DIALOGS
--------------------------------------------

function UI:HideDialogs()
    UI:Hide("DialogFrame")
    UI:Hide("DialogTextboxFrame")
end
