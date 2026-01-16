local _, Addon = ...
local UI = Addon.UI
local Functions = Addon.Functions
local Assets = Addon.Assets

--------------------------------------------
-- CREATE SCROLL FRAME
--------------------------------------------

-- Name, ParentFrameName, Point1 [, Point2]

function UI:CreateScrollFrame(Settings)
    local Point1, Point1Frame, Point1Relative, Point1X, Point1Y = unpack(Settings.Point1)
    local Point2, Point2Frame, Point2Relative, Point2X, Point2Y = unpack(Functions:Condition(Settings.Point2, Settings.Point2, {}))

    local ScrollFrame = CreateFrame("ScrollFrame", UI:FrameName(Settings.Name), UI:GetFrame(Settings.ParentFrameName), "UIPanelScrollFrameTemplate")
    ScrollFrame:SetPoint(Point1, UI:GetPointFrame(Point1Frame), Point1Relative, Point1X, Point1Y)
    if (Point2) then ScrollFrame:SetPoint(Point2, UI:GetPointFrame(Point2Frame), Point2Relative, Point2X, Point2Y) end

    local ScrollChild = CreateFrame("Frame", UI:FrameName(Settings.Name)..".ScrollChild")
    ScrollChild:SetWidth(ScrollFrame:GetWidth())
    ScrollChild:SetHeight(1)
    ScrollFrame:SetScrollChild(ScrollChild)
end

--------------------------------------------
-- CREATE SCROLL ITEM
--------------------------------------------

-- Name, ScrollFrameName, Title, Info [, Icon, CustomIcons]

function UI:CreateScrollItem(Settings)
    local ScrollChild = UI:GetFrame(Settings.ScrollFrameName..".ScrollChild")
    local CountItems = UI:CountChildFrames(ScrollChild)
    local PositionY = CountItems * -55
    local TitlePoint1X = 10
    local TitlePoint2X = -10

    local function SetItemBackdropOnEnter()
        UI:SetBackdropColor(Settings.Name, "#fff", 0.07)
        UI:SetBackdropBorderColor(Settings.Name, "#46413e", 0.6)
    end

    local function SetItemBackdropOnLeave()
        UI:SetBackdropColor(Settings.Name, "#fff", 0.05)
        UI:SetBackdropBorderColor(Settings.Name, "#46413e", 0.3)
    end

    -- Scroll Item

    local ScrollItem = UI:GetPoolFrame("Button", UI:FrameName(Settings.Name), ScrollChild, "BackdropTemplate")
    ScrollItem:SetSize(ScrollChild:GetWidth() - 3, 50)
    ScrollItem:SetPoint("TOPLEFT", 0, PositionY)
    ScrollItem:SetBackdrop(UI.Backdrop)
    ScrollItem:SetBackdropColor(UI:HexToRGB("#fff", 0.05))
    ScrollItem:SetBackdropBorderColor(UI:HexToRGB("#46413e", 0.3))
    ScrollItem:SetScript("OnEnter", function(Self, Button) SetItemBackdropOnEnter() end)
    ScrollItem:SetScript("OnLeave", function(Self, Button) SetItemBackdropOnLeave() end)

    -- Icon
    -- Get frame manually. There are only parent frames in the frame pool.

    if (Settings.Icon) then
        local IconName = UI:FrameName(Settings.Name)..".Icon"
        local IconFrame = UI:GetFrame(IconName)
        local Icon = Functions:Condition(IconFrame, IconFrame, CreateFrame("Button", IconName, ScrollItem, "BackdropTemplate"))

        Icon:SetPoint("LEFT", ScrollItem, "LEFT", 10, 0)
        Icon:SetSize(32, 32)
        Icon:SetNormalTexture(Settings.Icon)

        TitlePoint1X = 52
    end

    -- Title and Info

    if (not ScrollItem.Title) then
        ScrollItem.Title = ScrollItem:CreateFontString(UI:FrameName(Settings.Name)..".Title", "OVERLAY", "GameFontNormal")
    end
    ScrollItem.Title:SetHeight(14)
    ScrollItem.Title:SetFontObject(UI:GetFontObject("Asap.ttf", 15))
    ScrollItem.Title:SetTextColor(UI:HexToRGB("#fff"))
    ScrollItem.Title:SetJustifyH("LEFT")
    ScrollItem.Title:SetText(Settings.Title)

    if (not ScrollItem.Info) then
        ScrollItem.Info = ScrollItem:CreateFontString(UI:FrameName(Settings.Name)..".Info", "OVERLAY", "GameFontNormal")
    end
    ScrollItem.Info:SetPoint("BOTTOMLEFT", ScrollItem.Title, "BOTTOMLEFT", 0, -18)
    -- ScrollItem.Info:SetPoint("BOTTOMRIGHT", ScrollItem.Title, "BOTTOMRIGHT", 0, 0)
    ScrollItem.Info:SetHeight(14)
    ScrollItem.Info:SetFontObject(UI:GetFontObject("Asap.ttf", 14))
    ScrollItem.Info:SetTextColor(UI:HexToRGB("#969696"))
    ScrollItem.Info:SetJustifyH("LEFT")
    ScrollItem.Info:SetText(Settings.Info)
    ScrollItem.Info:SetScript("OnEnter", function(Self) SetItemBackdropOnEnter() end)
    ScrollItem.Info:SetScript("OnLeave", function(Self) SetItemBackdropOnLeave() end)

    -- Custom Icons
    -- Get frame manually. There are only parent frames in the frame pool.

    if (Settings.CustomIcons) then
        for Key, IconSettings in next, Settings.CustomIcons, nil do
            
            local IconWidth, IconWidth = unpack(Functions:Condition(IconSettings.Size, IconSettings.Size, { 20, 20 }))
            local IconPoint1, IconPoint1Frame, IconPoint1Relative, IconPoint1X, IconPoint1Y = unpack(IconSettings.Point1)
            local IconPoint2, IconPoint2Frame, IconPoint2Relative, IconPoint2X, IconPoint2Y = unpack(Functions:Condition(IconSettings.Point2, IconSettings.Point2, {}))

            local IconName = UI:FrameName(Settings.Name).."."..IconSettings.Name
            local IconFrame = UI:GetFrame(IconName)
            local Icon = Functions:Condition(IconFrame, IconFrame, CreateFrame("Button", IconName, ScrollItem, "BackdropTemplate"))

            Icon:SetPoint(IconPoint1, UI:GetPointFrame(IconPoint1Frame), IconPoint1Relative, IconPoint1X, IconPoint1Y)
            if (IconSettings.IconPoint2) then Icon:SetPoint(IconPoint1, UI:GetPointFrame(IconPoint1Frame), IconPoint1Relative, IconPoint1X, IconPoint1Y) end
            Icon:SetSize(IconWidth, IconWidth)
            Icon:SetNormalTexture(Assets.Images[IconSettings.AssetName])

            if (IconSettings.AssetHoverName) then

                Icon:SetScript("OnEnter", function(Self, Button)
                    Self:SetNormalTexture(Assets.Images[IconSettings.AssetHoverName])
                    SetItemBackdropOnEnter()
                end)

                Icon:SetScript("OnLeave", function(Self, Button)
                    Self:SetNormalTexture(Assets.Images[IconSettings.AssetName])
                    SetItemBackdropOnLeave()
                end)

            end

            TitlePoint2X = TitlePoint2X - IconWidth
        end

        TitlePoint2X = TitlePoint2X - 25
    end

    -- Title Position

    ScrollItem.Title:SetPoint("TOPLEFT", ScrollItem, "TOPLEFT", TitlePoint1X, -10)
    ScrollItem.Title:SetPoint("TOPRIGHT", ScrollItem, "TOPRIGHT", TitlePoint2X, 0)
end

--------------------------------------------
-- REMOVE ALL SCROLL ITEMS
--------------------------------------------

function UI:RemoveAllScrollItems(ScrollFrameName)
    local ScrollChild = UI:GetFrame(ScrollFrameName..".ScrollChild")
    for _, ItemFrame in next, UI:GetChildFrames(ScrollChild), nil do
        UI:RemovePoolFrame(ItemFrame)
    end
end

--------------------------------------------
-- MARK SCROLL ITEM
--------------------------------------------

function UI:MarkScrollItem(ScrollFrameName, ScrollItemName, MarkOnly)
    if (not MarkOnly) then
        local ScrollChild = UI:GetFrame(ScrollFrameName..".ScrollChild")
        for _, ItemFrame in next, UI:GetChildFrames(ScrollChild), nil do
            local ItemFrameTitle = UI:GetFrame(UI:GetName(ItemFrame)..".Title")
            ItemFrameTitle:SetTextColor(UI:HexToRGB("#fff"))
        end
    end

    local Item = UI:GetFrame(ScrollItemName)
    local ItemTitle = UI:GetFrame(ScrollItemName..".Title")

    ItemTitle:SetTextColor(UI:HexToRGB("#1EFF0C"))
end
