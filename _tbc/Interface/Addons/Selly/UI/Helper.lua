local _, Addon = ...
local Core = Addon.Core
local UI = Addon.UI
local Functions = Addon.Functions
local Assets = Addon.Assets

----------------------------------------------------------------------------------------
-- VARS
----------------------------------------------------------------------------------------

UI.Backdrop = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
	tile = false,
	tileSize = 0,
	edgeSize = 1
}

----------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------

--------------------------------------------
-- FRAME POOL
--------------------------------------------

UI.FramePool = {}

function UI:GetPoolFrame(Type, Name, Parent, Template)
    for Key, Frame in next, UI.FramePool, nil do

        local FrameName = Frame:GetName()

        if (FrameName == Name) then
            tremove(UI.FramePool, Key)
            _G[FrameName]:SetParent(Parent)
            _G[FrameName]:Show()

            return _G[FrameName]
        end

    end

    return CreateFrame(Type, Name, Parent, Template)
end

function UI:RemovePoolFrame(Frame)
    Frame:Hide()
    Frame:SetParent(nil)

    tinsert(UI.FramePool, Frame)
end

--------------------------------------------
-- HEX TO RGB
--------------------------------------------

function UI:HexToRGB(Hex, Opacity)
    Hex = Functions:StringReplace(Hex, "#","")
    Opacity = Functions:Condition(Opacity, Opacity, 1)
    local R, G, B = 0

    if (strlen(Hex) == 3) then
        R = (tonumber("0x"..string.sub(Hex, 1, 1)) * 17) / 255
        G = (tonumber("0x"..string.sub(Hex, 2, 2)) * 17) / 255
        B = (tonumber("0x"..string.sub(Hex, 3, 3)) * 17) / 255
    elseif (strlen(Hex) == 6) then
        R = (tonumber("0x"..string.sub(Hex, 1, 2))) / 255
        G = (tonumber("0x"..string.sub(Hex, 3, 4))) / 255
        B = (tonumber("0x"..string.sub(Hex, 5, 6))) / 255
    end

    return R, G, B, Opacity
end

----------------------------------------------------------------------------------------
-- FRAMES AND ELEMENTS
----------------------------------------------------------------------------------------

function UI:CountChildFrames(Frame)
    local Result = 0

    for _, ChildFrame in ipairs({ Frame:GetChildren() }) do
        Result = Result + 1
    end

    return Result
end

function UI:GetChildFrames(Frame)
    local ChildFrames = {}

    for _, ChildFrame in ipairs({ Frame:GetChildren() }) do
        tinsert(ChildFrames, ChildFrame)
    end

    return ChildFrames
end

function UI:GetFontObject(FontName, FontSize)
    local FontObject = CreateFont(Assets.Fonts[FontName])
    local SetFont = FontObject:SetFont(Assets.Fonts[FontName], FontSize, "")

    return FontObject
end

function UI:FrameName(FrameName)
    return Core.FrameNameShort..FrameName
end

function UI:GetFrame(FrameOrName)
    if (not FrameOrName) then return nil end

    if (Functions:IsTable(FrameOrName)) then
        if (not Functions:StartsWith(FrameOrName:GetName(), Core.FrameNameShort)) then
            return Functions:Condition(_G[Core.FrameNameShort..FrameOrName:GetName()], _G[Core.FrameNameShort..FrameOrName:GetName()], nil)
        end

        return FrameOrName
    end

    if (not Functions:StartsWith(FrameOrName, Core.FrameNameShort)) then
        return Functions:Condition(_G[Core.FrameNameShort..FrameOrName], _G[Core.FrameNameShort..FrameOrName], nil)
    end
    
    return Functions:Condition(_G[FrameOrName], _G[FrameOrName], nil)
end

function UI:GetPointFrame(Value)
    if (not Value) then return nil end
    if (tonumber(Value)) then return Value end
    if (Functions:IsTable(Value)) then return Value end

    return UI:GetFrame(Value)
end

function UI:GetText(FrameOrName) -- Button, Textbox...
    local Element = UI:GetFrame(FrameOrName)
    local CurrentText = Element:GetText()
    CurrentText = Functions:Trim(CurrentText)

    if (Functions:StartsWith(CurrentText, "|cFF")) then
        local ColorCode = Functions:Substring(CurrentText, 1, 10)
        CurrentText = Functions:StringReplace(CurrentText, ColorCode, "")
        CurrentText = Functions:StringReplace(CurrentText, "|r", "")
    end

    return CurrentText
end

function UI:SetText(FrameOrName, Text)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetText(Text)
end

function UI:SetTextColor(FrameOrName, Color, Opacity)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetTextColor(UI:HexToRGB(Color, Opacity))
end

function UI:SetChecked(FrameOrName, Status)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetChecked(Status)
end

function UI:GetChecked(FrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    return Element:GetChecked()
end

function UI:SetPoint(FrameOrName, Points)
    local Element = UI:GetFrame(FrameOrName)
    local Point, PointFrame, PointRelative, PointX, PointY = unpack(Points)
    PointFrame = Functions:Condition(PointFrame and not tonumber(PointFrame), UI:GetFrame(PointFrame), PointFrame)
    Element:SetPoint(Point, PointFrame, PointRelative, PointX, PointY)
end

function UI:SetNormalTexture(FrameOrName, Texture)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetNormalTexture(Texture)
end

function UI:SetBackdropBorderColor(FrameOrName, Color, Opacity)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetBackdropBorderColor(UI:HexToRGB(Color, Opacity))
end

function UI:HighlightText(FrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    Element:HighlightText()
end

function UI:SetFocus(FrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetFocus()
end

function UI:ClearFocus(FrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    Element:ClearFocus()
end

function UI:GetFrameLevel(FrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    return Element:GetFrameLevel()
end

function UI:SetFrameLevel(FrameOrName, FrameLevel)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetFrameLevel(FrameLevel)
end

function UI:SetAboveFrame(FrameOrName, UnderlyingFrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    local UnderlyingElement = UI:GetFrame(UnderlyingFrameOrName)
    Element:SetFrameLevel(UnderlyingElement:GetFrameLevel() + 5)
end

function UI:SetSize(FrameOrName, Size)
    local Element = UI:GetFrame(FrameOrName)
    local Width, Height = unpack(Size)
    Element:SetSize(Width, Height)
end

function UI:SetWidth(FrameOrName, Width)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetWidth(Width)
end

function UI:SetHeight(FrameOrName, Height)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetHeight(Height)
end

function UI:GetWidth(FrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    return Element:GetWidth()
end

function UI:GetHeight(FrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    return Element:GetHeight()
end

function UI:IsVisible(FrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    return Element:IsVisible()
end

function UI:IsShown(FrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    return Element:IsShown()
end

function UI:Click(FrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    Element:Click()
end

function UI:SetEnabled(FrameOrName, Status)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetEnabled(Status)
end

function UI:IsEnabled(FrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    return Element:IsEnabled()
end

function UI:SetBackdropColor(FrameOrName, Color, Opacity)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetBackdropColor(UI:HexToRGB(Color, Opacity))
end

function UI:SetBackdropBorderColor(FrameOrName, Color, Opacity)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetBackdropBorderColor(UI:HexToRGB(Color, Opacity))
end

function UI:GetName(Frame)
    return Frame:GetName()
end

--------------------------------------------
-- FRAMES: SHOW/HIDE (AUTO FRAME LEVEL)
--------------------------------------------

UI.OpenFrames = {}

function UI:Show(FrameOrName, IgnoreFrameLevel)
    local Element = UI:GetFrame(FrameOrName)
    if (IgnoreFrameLevel or not Element.SetFrameLevel) then
        Element:Show()
        return
    end

    local FrameLevel = 1
    for Key, Frame in next, UI.OpenFrames, nil do
        Frame:SetFrameLevel(FrameLevel)
        FrameLevel = FrameLevel + Functions:Condition(FrameLevel == 1, 9, 10)
    end

    Element:Show()
    Element:SetFrameLevel(FrameLevel)

    tinsert(UI.OpenFrames, Element)
end

function UI:Hide(FrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    Element:Hide()

    for Key, Frame in next, UI.OpenFrames, nil do
        if (Frame == Element) then
            tremove(UI.OpenFrames, Key)
            return
        end
    end
end

--------------------------------------------
-- FRAMES: SET SCRIPT
--------------------------------------------

function UI:SetScript(ScriptType, FrameOrName, Function)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetScript(ScriptType, Function)
end

function UI:HookScript(ScriptType, FrameOrName, Function)
    local Element = UI:GetFrame(FrameOrName)
    if (Element:GetScript(ScriptType)) then
        Element:HookScript(ScriptType, Function)
    else
        Element:SetScript(ScriptType, Function)
    end
end

function UI:UnsetScript(ScriptType, FrameOrName)
    local Element = UI:GetFrame(FrameOrName)
    Element:SetScript(ScriptType, nil)
end
