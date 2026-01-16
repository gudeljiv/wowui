local AddonName, Addon = ...
local Core = Addon.Core
local UI = Addon.UI
local Functions = Addon.Functions
local Assets = Addon.Assets

UI.ContextMenus = {}
UI.IsOverContextMenu = false

-- ClickFrameName, Items [, Width, IsDisabled]
-- Items.Text = "-" to add a separator

function UI:CreateContextMenu(Settings)
    local FrameName = UI:FrameName(Settings.ClickFrameName)..".ContextMenu"

    -- Context menu frame

    local ContextMenu = UI:GetPoolFrame("Frame", FrameName, UIParent, "BackdropTemplate")
    ContextMenu:SetBackdrop(UI.Backdrop)
    ContextMenu:SetBackdropColor(UI:HexToRGB("#000"))
    ContextMenu:SetBackdropBorderColor(UI:HexToRGB("#fff", 0.2))
    ContextMenu:SetFrameLevel(UI:GetFrameLevel(Settings.ClickFrameName) + 5)
    ContextMenu:Hide()

    -- Context menu items

    local ContextMenuWidth = 0
    local ContextMenuHeight = 0

    for Key, MenuItemSettings in next, Settings.Items, nil do
        local IsTitle = MenuItemSettings.IsTitle
        local IsSeparator = MenuItemSettings.Text == "-"
        local IsDisabled = MenuItemSettings.IsDisabled or IsTitle or IsSeparator
        local MenuItemName = FrameName..".Item"..Key
        local MenuItemFrame = UI:GetFrame(MenuItemName)
        local MenuItem = Functions:Condition(MenuItemFrame, MenuItemFrame, CreateFrame("Button", MenuItemName, ContextMenu, "BackdropTemplate"))

        -- Menu item

        MenuItem:SetBackdrop(UI.Backdrop)
        MenuItem:SetBackdropColor(UI:HexToRGB("#000", 0))
        MenuItem:SetBackdropBorderColor(UI:HexToRGB("#000", 0))
        MenuItem:SetHeight(Functions:Condition(IsTitle or IsSeparator, 20, 30))

        if (Key == 1) then
            MenuItem:SetPoint("TOPLEFT", ContextMenu, "TOPLEFT", 1, -1)
        else
            MenuItem:SetPoint("TOPLEFT", UI:GetFrame(FrameName..".Item"..(Key - 1)), "BOTTOMLEFT", 0, 0)
        end

        MenuItem:SetScript("OnEnter", function(Self, Button)
            UI.IsOverContextMenu = true

            if (not IsDisabled) then
                Self:SetBackdropColor(UI:HexToRGB("#fff", 0.1))
            end
        end)

        MenuItem:SetScript("OnLeave", function(Self, Button)
            UI.IsOverContextMenu = false
            UI:AutoCloseContextMenu(ContextMenu, 0)

            if (not IsDisabled) then
                Self:SetBackdropColor(UI:HexToRGB("#000", 0))
            end
        end)
        
        if (not IsDisabled) then
            MenuItem:SetScript("OnClick", MenuItemSettings.Func)
            MenuItem:HookScript("OnClick", function() UI:HideContextMenus() end)
        end

        -- Menu item: Title / Text

        if (not IsSeparator) then

            if (not MenuItem.Text) then
                MenuItem.Text = MenuItem:CreateFontString(MenuItemName..".Text", "OVERLAY")
            end

            if (IsTitle or IsSeparator) then
                MenuItem.Text:SetFont(Assets.Fonts["Asap.ttf"], 10)
                MenuItem.Text:SetTextColor(UI:HexToRGB("#ffd100"))
            else
                MenuItem.Text:SetFont(Assets.Fonts["Asap.ttf"], 13)
                MenuItem.Text:SetTextColor(UI:HexToRGB(Functions:Condition(IsDisabled, "#474747", "#ffffff")))
            end

            MenuItem.Text:SetPoint("LEFT", MenuItem, "LEFT", 10, 0)
            MenuItem.Text:SetText(MenuItemSettings.Text)

        end

        -- Measure width and height for adjustments

        local TextMargin, ItemWidth = 0, 0

        if (not IsSeparator) then
            TextMargin = select(4, MenuItem.Text:GetPoint())
            ItemWidth = MenuItem.Text:GetWidth() + TextMargin * 2
        end

        ContextMenuWidth = Functions:Condition(ItemWidth > ContextMenuWidth, ItemWidth, ContextMenuWidth)
        ContextMenuHeight = ContextMenuHeight + MenuItem:GetHeight()
    end

    -- Adjust all MenuItem widths
    -- Add separator lines

    ContextMenuWidth = Functions:Condition(Settings.Width, Settings.Width, ContextMenuWidth + 10)

    for Key, MenuItemSettings in next, Settings.Items, nil do
        local IsTitle = MenuItemSettings.IsTitle
        local IsSeparator = MenuItemSettings.Text == "-"
        local MenuItem = UI:GetFrame(FrameName..".Item"..Key)

        MenuItem:SetWidth(ContextMenuWidth - 2)

        if (IsTitle) then

            local TitleSeparator = MenuItem:CreateLine()
            TitleSeparator:SetColorTexture(UI:HexToRGB("#474747", 0.5))
            TitleSeparator:SetStartPoint("RIGHT", MenuItem.Text, 5, 0)
            TitleSeparator:SetEndPoint("RIGHT", MenuItem, -10, 0)
            TitleSeparator:SetThickness(1.5)

        elseif (IsSeparator) then

            local Separator = MenuItem:CreateLine()
            Separator:SetColorTexture(UI:HexToRGB("#474747", 0.5))
            Separator:SetStartPoint("LEFT", MenuItem, 10, 0)
            Separator:SetEndPoint("RIGHT", MenuItem, -10, 0)
            Separator:SetThickness(1)

        end
    end

    -- Adjust last MenuItem height

    local LastMenuItem = UI:GetFrame(FrameName..".Item"..Functions:CountTable(Settings.Items))
    LastMenuItem:SetHeight(LastMenuItem:GetHeight() - 2)

    -- Set context menu height

    ContextMenu:SetSize(ContextMenuWidth, ContextMenuHeight)

    -- Add context menu to table

    UI:AddContextMenu(ContextMenu)

    -- Add context menu to frame pool
    -- This prevents empty context menus when editing scroll items

    UI:HideContextMenus()
end

function UI:AddContextMenu(Frame)
    for Key, ContextMenu in next, UI.ContextMenus, nil do
        if (ContextMenu == Frame) then return end
    end

    tinsert(UI.ContextMenus, Frame)
end

function UI:HideContextMenus()
    for Key, ContextMenu in next, UI.ContextMenus, nil do
        UI:RemovePoolFrame(ContextMenu)
    end

    UI.IsOverContextMenu = false
end

function UI:AutoCloseContextMenu(ContextMenu, MS)
    if (UI.IsOverContextMenu) then return end

    if (MS == 20) then
        if (ContextMenu) then UI:RemovePoolFrame(ContextMenu) end
        return
    end

    C_Timer.After(0.1, function() UI:AutoCloseContextMenu(ContextMenu, MS + 1) end)
end

function UI:ShowContextMenu(FrameName)
    UI:HideContextMenus(FrameName)
    FrameName = FrameName..".ContextMenu"

    local ContextMenu = UI:GetFrame(FrameName)
    local Scale, X, Y = ContextMenu:GetEffectiveScale(), GetCursorPosition()
    ContextMenu:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", X/Scale, Y/Scale)

    UI:Show(FrameName)
    UI:AutoCloseContextMenu(ContextMenu, 0)
end
