local _, Addon = ...
local UI = Addon.UI
local Functions = Addon.Functions
local Assets = Addon.Assets
local Colors = Addon.Colors

--------------------------------------------
-- CREATE TEXTBOX
--------------------------------------------

-- Name, ParentFrameName, Width, Point1
-- [, Point2, Size, Text, AutoFocus, MaxLetters, HighlightText]

function UI:CreateTextbox(Settings)
    local Width, Height = unpack(Functions:Condition(Settings.Size, Settings.Size, { 125, 35 }))
    local Point1, Point1Frame, Point1Relative, Point1X, Point1Y = unpack(Settings.Point1)
    local Point2, Point2Frame, Point2Relative, Point2X, Point2Y = unpack(Functions:Condition(Settings.Point2, Settings.Point2, {}))

    local Frame = CreateFrame("Frame", UI:FrameName(Settings.Name), UI:GetFrame(Settings.ParentFrameName), "BackdropTemplate")
    Frame:EnableMouse(true)
    Frame:SetSize(Width, Height)
    Frame:SetPoint(Point1, UI:GetPointFrame(Point1Frame), Point1Relative, Point1X, Point1Y)
    if (Point2) then Frame:SetPoint(Point2, UI:GetPointFrame(Point2Frame), Point2Relative, Point2X, Point2Y) end
    Frame:SetBackdrop(UI.Backdrop)
    Frame:SetBackdropColor(UI:HexToRGB("#fff", 0.15))
    Frame:SetBackdropBorderColor(UI:HexToRGB("#46413e", 0.3))

    local Textbox = CreateFrame("EditBox", UI:FrameName(Settings.Name)..".Textbox", Frame)
	Textbox:EnableMouse(true)
	Textbox:SetFontObject(UI:GetFontObject("Asap.ttf", 15))
    Textbox:SetPoint("TOPLEFT", Frame)
    Textbox:SetPoint("BOTTOMRIGHT", Frame)
    Textbox:SetWidth(Frame:GetWidth() - 3)
    Textbox:SetTextInsets(10, 10, 10, 10)

	Textbox:SetMaxLetters(Functions:Condition(Settings.MaxLetters, Settings.MaxLetters, 0))
	Textbox:SetText(Functions:Condition(Settings.Text, Settings.Text, ""))
	Textbox:SetAutoFocus(Functions:Condition(Settings.AutoFocus ~= nil, Settings.AutoFocus, false))
	Textbox:HighlightText(Functions:Condition(Settings.HighlightText ~= nil, Settings.HighlightText, 0))

	Textbox:SetScript("OnEscapePressed", function(Self) Self:SetAutoFocus(false); Self:ClearFocus() end)

    local function SetBorderColorOnFocusGained()
        UI:SetBackdropBorderColor(Settings.Name, "#fff", 0.6)
    end

    local function SetBorderColorOnFocusLost()
        UI:SetBackdropBorderColor(Settings.Name, "#46413e", 0.3)
    end

    Textbox:SetScript("OnEditFocusGained", function(Self) SetBorderColorOnFocusGained() end)
    Textbox:SetScript("OnEditFocusLost", function(Self) SetBorderColorOnFocusLost() end)

    if (Settings.Placeholder) then
        local function SetPlaceholder()
            local CurrentText = UI:GetText(Textbox)

            if (strlen(CurrentText) == 0) then
                if (not Textbox:HasFocus()) then
                    Textbox:SetText(Functions:PrintColor(Settings.Placeholder, "Grey"))
                end
            elseif (Textbox:HasFocus()) then
                if (CurrentText == Settings.Placeholder) then
                    Textbox:SetText("")
                end
            end
        end

        if (not Settings.Text) then SetPlaceholder() end

        Textbox:HookScript("OnEditFocusGained", function() SetPlaceholder() end)
        Textbox:HookScript("OnEditFocusLost", function() SetPlaceholder() end)
    end
end

--------------------------------------------
-- CREATE MULTILINE TEXTBOX
--------------------------------------------

-- Name, ParentFrameName, Point1
-- [, Point2, Size, Text, AutoFocus, MaxLetters, HighlightText, IsLongString]

function UI:CreateMultiLineTextbox(Settings)
    local Width, Height = unpack(Functions:Condition(Settings.Size, Settings.Size, { 0, 0 }))
    local Point1, Point1Frame, Point1Relative, Point1X, Point1Y = unpack(Settings.Point1)
    local Point2, Point2Frame, Point2Relative, Point2X, Point2Y = unpack(Functions:Condition(Settings.Point2, Settings.Point2, {}))

    local Frame = CreateFrame("Frame", UI:FrameName(Settings.Name), UI:GetFrame(Settings.ParentFrameName), "BackdropTemplate")
    Frame:EnableMouse(true)
    Frame:SetSize(Width, Height)
    Frame:SetPoint(Point1, UI:GetPointFrame(Point1Frame), Point1Relative, Point1X, Point1Y)
    if (Point2) then Frame:SetPoint(Point2, UI:GetPointFrame(Point2Frame), Point2Relative, Point2X, Point2Y) end
    Frame:SetBackdrop(UI.Backdrop)
    Frame:SetBackdropColor(UI:HexToRGB("#fff", 0.15))
    Frame:SetBackdropBorderColor(UI:HexToRGB("#46413e", 0.3))

    local ScrollFrame = CreateFrame("ScrollFrame", UI:FrameName(Settings.Name)..".ScrollFrame", Frame, "UIPanelScrollFrameTemplate")
    ScrollFrame:SetPoint("TOPLEFT", Frame)
    ScrollFrame:SetPoint("BOTTOMRIGHT", Frame)

    local Textbox = CreateFrame("EditBox", UI:FrameName(Settings.Name)..".Textbox", ScrollFrame)
	Textbox:SetMultiLine(true)
	Textbox:EnableMouse(true)
	Textbox:SetFontObject(UI:GetFontObject("Asap.ttf", 15))
	Textbox:SetWidth(ScrollFrame:GetWidth() - 3)
    Textbox:SetTextInsets(10, 10, 10, 10)

	Textbox:SetMaxLetters(Functions:Condition(Settings.MaxLetters, Settings.MaxLetters, 0))
	Textbox:SetText(Functions:Condition(Settings.Text, Settings.Text, ""))
	Textbox:SetAutoFocus(Functions:Condition(Settings.AutoFocus ~= nil, Settings.AutoFocus, false))
	Textbox:HighlightText(Functions:Condition(Settings.HighlightText ~= nil, Settings.HighlightText, 0))

	Textbox:SetScript("OnEscapePressed", function(Self) Self:SetAutoFocus(false); Self:ClearFocus() end)
	ScrollFrame:SetScript("OnMouseDown", function(Self, Button) if Button == "LeftButton" then Textbox:SetFocus() end end)

    local function SetBorderColorOnFocusGained()
        UI:SetBackdropBorderColor(Settings.Name, "#fff", 0.6)
    end

    local function SetBorderColorOnFocusLost()
        UI:SetBackdropBorderColor(Settings.Name, "#46413e", 0.3)
    end

    Textbox:SetScript("OnEditFocusGained", function(Self) SetBorderColorOnFocusGained() end)
    Textbox:SetScript("OnEditFocusLost", function(Self) SetBorderColorOnFocusLost() end)

    if (Settings.IsLongString) then
        UI:ReceiveLongString(Textbox)
    end

    ScrollFrame:SetScrollChild(Textbox)
end

function UI:ReceiveLongString(Textbox)
    Textbox:SetMaxBytes(1)

    local Paste = ""
    local TextBuffer, i, LastPaste = {}, 0, 0
        
    local function ClearBuffer(Self)
        Self:SetScript('OnUpdate', nil)

        if i <= 5 then return end
            
        -- print(i, 'characters pasted')
        local CurrentPaste = strtrim(table.concat(TextBuffer))
            
        Self:SetMaxBytes(0)
        if strlen(CurrentPaste) > 500 then
            Self:SetText(strsub(CurrentPaste, 1, 1600).." ... |cFF34c0eb("..strlen(CurrentPaste).." characters)")
        end
        
        Paste = CurrentPaste
        Self:ClearFocus()
        Self:SetMaxBytes(1)
    end
        
    Textbox:SetScript('OnChar', function(Self, Character)
        if LastPaste ~= GetTime() then
            TextBuffer, i, LastPaste = {}, 0, GetTime()
            Self:SetScript('OnUpdate', ClearBuffer)
        end
        
        i = i + 1
        TextBuffer[i] = Character
    end)
    
    Textbox:SetScript('OnEditFocusLost', function(Self)
        Self:SetScript('OnUpdate', nil)
    end)
end
