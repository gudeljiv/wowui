do
    AutoRoll.RollHistory = CreateFrame("Frame")

    local lootRolls = {
--[[
        {itemId = 19707, buttons = {}, html = nil }, -- Red Hakkari Bijou
        {itemId = 19708, buttons = {}, html = nil }, -- Blue Hakkari Bijou
        {itemId = 19709, buttons = {}, html = nil }, -- Yellow Hakkari Bijou
        {itemId = 19710, buttons = {}, html = nil }, -- Orange Hakkari Bijou
        {itemId = 19711, buttons = {}, html = nil }, -- Green Hakkari Bijou
        {itemId = 19712, buttons = {}, html = nil }, -- Purple Hakkari Bijou
        {itemId = 19703, buttons = {}, html = nil }, -- Bronze Hakkari Bijou
        {itemId = 19714, buttons = {}, html = nil }, -- Silver Hakkari Bijou
        {itemId = 19715, buttons = {}, html = nil }, -- Gold Hakkari Bijou
        {itemId = 19716, buttons = {}, html = nil }, -- Gold Hakkari Bijou
        {itemId = 19717, buttons = {}, html = nil }, -- Gold Hakkari Bijou
        {itemId = 19718, buttons = {}, html = nil }, -- Gold Hakkari Bijou
        {itemId = 19719, buttons = {}, html = nil }, -- Gold Hakkari Bijou
        {itemId = 19720, buttons = {}, html = nil }, -- Gold Hakkari Bijou
        {itemId = 19721, buttons = {}, html = nil }, -- Gold Hakkari Bijou
        {itemId = 19722, buttons = {}, html = nil }, -- Gold Hakkari Bijou
        {itemId = 19723, buttons = {}, html = nil }, -- Gold Hakkari Bijou
]]
    }

    local BUTTON_CHECKED_ALPHA = 1.0
    local BUTTON_UNCHECKED_ALPHA = 0.2
    local ROOT_FRAME_HEIGHT = 150
    local ROOT_FRAME_WIDTH = 250
    local PADDING = 0
    local BUTTON_SIZE = 20
    local ROOT_PADDING = 10
    local SCROLL_STEP = BUTTON_SIZE + PADDING
    local SCROLLBAR_WIDTH = 30
    local SCROLLBAR_INSET = 10

    local scrollFrame = nil
    local framePool = {}
    local tempFontString = AutoRoll.RollHistory:CreateFontString("AutoRollTempFontString", "BACKGROUND", nil)
    tempFontString:SetFontObject(GameFontWhite)

    function Create()
        if not AutoRoll_PCDB.enableHistory then
          return
        end

        if not scrollFrame then
            scrollFrame  = CreateFrame("ScrollFrame", "AutoRollScrollFrame", UIParent)
        end
        scrollFrame.width  = ROOT_FRAME_WIDTH
        scrollFrame.height = ROOT_FRAME_HEIGHT
        scrollFrame:SetFrameStrata("FULLSCREEN_DIALOG")
        scrollFrame:SetSize(scrollFrame.width, scrollFrame.height)
        scrollFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
        scrollFrame:SetBackdrop({
            bgFile   = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile     = true,
            tileSize = 32,
            edgeSize = 32,
            insets   = { left = ROOT_PADDING, right = ROOT_PADDING, top = ROOT_PADDING, bottom = ROOT_PADDING }
        })
        scrollFrame:SetBackdropColor(0, 0, 0, 1)
        scrollFrame:EnableMouse(true)
        scrollFrame:EnableMouseWheel(true)
        scrollFrame:SetHitRectInsets(-8, 8, -8, 8) -- create a slightly larger hitbox for resizing/dragging

        -- Make movable/resizable
        scrollFrame:SetMovable(true)
        scrollFrame:SetResizable(true)
        scrollFrame:SetUserPlaced(true)
        scrollFrame:SetMinResize(100, 100)
        scrollFrame:RegisterForDrag("LeftButton")
        scrollFrame:SetScript("OnDragStart", scrollFrame.StartMoving)
        scrollFrame:SetScript("OnDragStop", scrollFrame.StopMovingOrSizing)

        scrollFrame:SetScript("OnUpdate", function(self)
            if self.isResizing then
                UpdateDimensions()
            end
        end)

        scrollFrame:SetScript("OnShow", function(self)
            UpdateDimensions()
        end)

        -- Title
        scrollFrame.text = scrollFrame:CreateFontString(nil, "ARTWORK")
        scrollFrame.text:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE")
        scrollFrame.text:SetPoint("TOPLEFT",12,10)
        scrollFrame.text:SetText("AutoRoll History")

        -- Empty Text
        scrollFrame.emptyText = scrollFrame:CreateFontString(nil, "BACKGROUND")
        scrollFrame.emptyText:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE")
        scrollFrame.emptyText:SetPoint("CENTER")
        scrollFrame.emptyText:SetText("No rolls yet.")
        scrollFrame.emptyText:Hide()

        -- Resize button
        local resizeButton = CreateFrame("Button", nil, scrollFrame)
        resizeButton:SetSize(16, 16)
        resizeButton:SetPoint("BOTTOMRIGHT")
        resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
        resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
        resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

        resizeButton:SetScript("OnMouseDown", function(self, button)
            scrollFrame:StartSizing("BOTTOMRIGHT")
            scrollFrame:SetUserPlaced(true)
            scrollFrame.isResizing = true
        end)

        resizeButton:SetScript("OnMouseUp", function(self, button)
            scrollFrame:StopMovingOrSizing()
            scrollFrame.isResizing = false
        end)

        -- Close button
        if not scrollFrame.closeButton then
            scrollFrame.closeButton = CreateFrame("Button", nil, scrollFrame, "UIPanelCloseButton")
        end
        scrollFrame.closeButton:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", 0, 25)
        scrollFrame.closeButton:SetHeight(31)
        scrollFrame.closeButton:SetWidth(31)

        scrollFrame.closeButton:SetScript("OnClick", function(self)
            HideParentPanel(self)
        end)

        -- Scroll Bar
        if not scrollFrame.scrollBar then
            scrollFrame.scrollBar = CreateFrame("Slider", nil, scrollFrame, "UIPanelScrollBarTemplate")
        end
        local scrollBar = scrollFrame.scrollBar

        scrollBar:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", -SCROLLBAR_INSET, -30)
        scrollBar:SetPoint("BOTTOM", scrollFrame, "BOTTOM", -SCROLLBAR_INSET, 30)
        scrollBar:SetWidth(SCROLLBAR_WIDTH)
        scrollBar:SetValueStep(1)
        scrollBar.scrollStep = 1

        scrollBar:SetScript("OnValueChanged", function(self, value)
            scrollFrame:SetVerticalScroll(value)
            UpdateDimensions()
        end)

        scrollFrame:SetScript("OnMouseWheel", function(self, delta)
            local cur_val = scrollBar:GetValue()
            local min_val, max_val = scrollBar:GetMinMaxValues()

            if delta < 0 and cur_val < max_val then
                cur_val = math.min(max_val, cur_val + SCROLL_STEP)
                scrollBar:SetValue(cur_val)
            elseif delta > 0 and cur_val > min_val then
                cur_val = math.max(min_val, cur_val - SCROLL_STEP)
                scrollBar:SetValue(cur_val)
            end
        end)

        if not scrollFrame.scrollChild then
            scrollFrame.scrollChild = CreateFrame('Frame')
        end

        local scrollChild = scrollFrame.scrollChild
        scrollChild:SetWidth(scrollFrame:GetWidth())
        scrollChild:SetPoint("CENTER")
        scrollChild:SetFrameStrata("FULLSCREEN")
        scrollFrame:SetScrollChild(scrollChild)

        ConfigDebugButton()
        Update()

        scrollBar:SetValue(select(2, scrollBar:GetMinMaxValues()))
    end

    function Update()
        if not AutoRoll_PCDB.enableHistory then
          return
        end

        if #AutoRoll_PCDB.history == 0 then
            scrollFrame.emptyText:Show()
        else
            scrollFrame.emptyText:Hide()

            for index,event in ipairs(AutoRoll_PCDB.history) do
                CreateRow(index, event)
            end
        end

        UpdateDimensions()
    end

    function UpdateDimensions()
        if scrollFrame then

            local scrollBar = scrollFrame.scrollBar
            local scrollChild = scrollFrame.scrollChild

            local scrollMax = GetMaxScroll()

            scrollBar:SetMinMaxValues(0, scrollMax)
            scrollBar:SetValue(GetCurrentScroll())

            if scrollMax > 0 then
                scrollBar:Show()
            else
                scrollBar:Hide()
            end

            scrollChild:SetHeight(GetContentHeight())

            scrollBar:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", -SCROLLBAR_INSET, -30)
            scrollBar:SetPoint("BOTTOM", scrollFrame, "BOTTOM", -SCROLLBAR_INSET, 30)

            HideClippedRows()

            local minWidth = GetContentWidth()
            scrollFrame:SetMinResize(minWidth, 100)

            if scrollFrame:GetWidth() < minWidth then
                scrollFrame:SetWidth(minWidth)
            end
        end
    end

    function CreateRow(index, event)
        local yoffset = index * (BUTTON_SIZE + PADDING) - PADDING
        local scrollChild = scrollFrame.scrollChild

        local function clickHandler(index, rule)
            local frame = framePool[index]
            local buttons = frame.buttons

            UncheckButtons(buttons)

            local str = AutoRollUtils:getRuleString(rule)
            buttons[str]:SetAlpha(BUTTON_CHECKED_ALPHA)
            buttons[str].normalAlpha = BUTTON_CHECKED_ALPHA

            AutoRoll.SaveRule(event.itemId, str)

            if event.rollId then
                RollOnLoot(event.rollId, rule)
            end

        end

        PopulateFrame(index, event.itemId, clickHandler)

        SetFrameAlpha(index, event.itemId)
    end

    function PopulateFrame(index, itemId, clickHandler)
        local scrollChild = scrollFrame.scrollChild
        local frame = nil

        if index > #framePool then
            frame = CreateFrame("Frame", "AutoRollScrollItemFrame"..index, scrollChild)
            frame.html = CreateFrame("SimpleHTML", "AutoRollScrollItemHtmlFrame"..index, frame)
            frame.buttons = CreateRollButtons(frame, index, clickHandler)

            framePool[index] = frame
        else
            frame = framePool[index]
        end

        local html = frame.html
        local buttons = frame.buttons

        local yoffset = index * (BUTTON_SIZE + PADDING) - PADDING

        frame:SetPoint("TOPLEFT", 0, -yoffset)
        frame:SetWidth(scrollChild:GetWidth() - 3*BUTTON_SIZE - ROOT_PADDING)
        frame:SetHeight(BUTTON_SIZE)

        html:SetPoint("TOPLEFT", buttons["pass"], "TOPRIGHT", 4, -3)
        html:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")

        html:SetFontObject(GameFontWhite)
        html:SetFrameStrata("FULLSCREEN")
        html:EnableMouse(true)
        html:SetScript("OnHyperlinkClick", function(self, link, text, button)
        end)
        html:SetScript("OnHyperlinkEnter", function(self, link, text)
            GameTooltip:SetOwner(html,"ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(link)
            GameTooltip:Show()
        end)
        html:SetScript("OnHyperlinkLeave", function(self, link, text)
            GameTooltip:Hide()
        end)

        local itemName, itemLink = GetItemInfo(itemId)

        html:SetText([[
            <html>
            <body>
                <p>]]..(itemLink or itemName or itemId)..[[</p>
            </body>
            </html>
        ]]);

        html:Show()

        return frame
    end

    function UncheckButtons(buttons)
        for rule,button in pairs(buttons) do
            button:SetAlpha(BUTTON_UNCHECKED_ALPHA)
            button.normalAlpha = BUTTON_UNCHECKED_ALPHA
        end
    end

    function CreateRollButtons(parent, index, handler)
        local need = CreateButton("AUTOROLL_NEED_ROLL"..index, AutoRollUtils.ROLL.NEED, 0, 0, parent, function()
            handler(index, AutoRollUtils.ROLL.NEED)
        end)
        local greed = CreateButton("AUTOROLL_GREED_ROLL"..index, AutoRollUtils.ROLL.GREED, BUTTON_SIZE, 0, parent, function()
            handler(index, AutoRollUtils.ROLL.GREED)
        end)
        local pass = CreateButton("AUTOROLL_PASS_ROLL"..index, AutoRollUtils.ROLL.PASS, 2*BUTTON_SIZE, 0, parent, function()
            handler(index, AutoRollUtils.ROLL.PASS)
        end)

        return {
            need = need,
            greed = greed,
            pass = pass
        }
    end

    function CreateButton(name, rule, x, y, parent, handler)
        local button = CreateFrame("Button", "AutoRoll_"..name, parent)
            button:SetSize(BUTTON_SIZE,BUTTON_SIZE)
            button:SetPoint("TOPLEFT", BUTTON_SIZE + x, -y)
            button:RegisterForClicks("LeftButtonUp")
            button:SetScript("OnClick", function() handler() end)
            button:SetScript("OnEnter", function(self) self:SetAlpha(BUTTON_CHECKED_ALPHA) end)
            button:SetScript("OnLeave", function(self) self:SetAlpha(self.normalAlpha) end)

            SetButtonTextures(button, rule)

            return button
    end

    function SetButtonTextures(button, rule)
        local pushed, highlight, normal = nil

        if (rule == AutoRollUtils.ROLL.NEED) then
            pushed = "Interface\\Buttons\\ui-grouploot-dice-down"
            highlight = "Interface\\Buttons\\ui-grouploot-dice-highlight"
            normal = "Interface\\Buttons\\ui-grouploot-dice-up"
        elseif (rule == AutoRollUtils.ROLL.GREED) then
            pushed = "Interface\\Buttons\\ui-grouploot-coin-down"
            highlight = "Interface\\Buttons\\ui-grouploot-coin-highlight"
            normal = "Interface\\Buttons\\ui-grouploot-coin-up"
        elseif (rule == AutoRollUtils.ROLL.PASS) then
            pushed = "Interface\\Buttons\\ui-grouploot-pass-down"
            highlight = "Interface\\Buttons\\ui-grouploot-pass-highlight"
            normal = "Interface\\Buttons\\ui-grouploot-pass-up"
        end

        button:SetPushedTexture(pushed)
        button:SetHighlightTexture(highlight)
        button:SetNormalTexture(normal)
    end

    function Add(event)
        if not AutoRoll_PCDB.enableHistory then
          return
        end

        for i,e in ipairs(AutoRoll_PCDB.history) do
            if (e.itemId == event.itemId) then
                return
            end
        end

        table.insert(AutoRoll_PCDB.history, event)

        if (#AutoRoll_PCDB.history > AutoRoll_PCDB.historySize) then
            table.remove(AutoRoll_PCDB.history, 1)
        end

        Update()

        scrollFrame.scrollBar:SetValue(GetMaxScroll())
    end

    function Show()
        if not AutoRoll_PCDB.enableHistory then
          return
        end

        scrollFrame:Show()
    end

    function SetFrameAlpha(index, itemId)
        local frame = framePool[index]
        local buttons = frame.buttons
        local rule = AutoRoll_PCDB.rules[itemId]
        local ruleString = AutoRollUtils:getRuleString(rule)

        for key,button in pairs(buttons) do
            if key == ruleString then
                button.normalAlpha = BUTTON_CHECKED_ALPHA
            else
                button.normalAlpha = BUTTON_UNCHECKED_ALPHA
            end

            button:SetAlpha(button.normalAlpha)
        end
    end

    function GetContentWidth()
        return GetLongestItemWidth() + 3*BUTTON_SIZE + 2*ROOT_PADDING + 2*SCROLLBAR_WIDTH + SCROLLBAR_INSET
    end

    function GetContentHeight()
        return (#AutoRoll_PCDB.history+2) * SCROLL_STEP - PADDING
    end

    function GetMaxScroll()
        return max(GetContentHeight() - scrollFrame:GetHeight(), 0)
    end

    function GetCurrentScroll()
        return min(GetMaxScroll(), scrollFrame.scrollBar:GetValue())
    end

    function HideClippedRows()
        local currentScroll = GetCurrentScroll()

        for index,frame in ipairs(framePool) do
            local top = (index-1) * BUTTON_SIZE
            local bottom = top + BUTTON_SIZE

            if (top <= currentScroll - ROOT_PADDING) or (bottom >= currentScroll + scrollFrame:GetHeight() - BUTTON_SIZE - ROOT_PADDING) then
                frame:Hide()
            else
                frame:Show()
            end
        end
    end

    function GetLongestItemWidth()
        local length = 0

        for index,event in ipairs(AutoRoll_PCDB.history) do
            local itemId = event.itemId
            local itemName = select(1, GetItemInfo(event.itemId))
            tempFontString:SetText(itemName)
            length = max(length, tempFontString:GetStringWidth())
        end

        return length
    end

    function ConfigDebugButton()
        if not AutoRoll_PCDB.enableHistory then
          return
        end

        if AutoRoll_PCDB.debug then
            if not scrollFrame.debugButton then
                scrollFrame.debugButton = CreateFrame("Button", "AutoRollHistoryDebugButton", scrollFrame, "UIPanelButtonTemplate")
            end
            scrollFrame.debugButton:SetPoint("TOPLEFT", scrollFrame, "TOPLEFT", 0, 25)
            scrollFrame.debugButton:SetWidth(70)
            scrollFrame.debugButton:SetText("Random")
            scrollFrame.debugButton:SetScript("OnClick", function(self)
                local e = {
                    itemId = random(19750),
                    rollId = nil,
                    buttons = {}
                }
                Add(e)
            end)
            scrollFrame.debugButton:Show()
        else
            if scrollFrame.debugButton then
                scrollFrame.debugButton:Hide()
            end
        end
    end

    -- Expose Functions
    AutoRoll.RollHistory.Create = Create
    AutoRoll.RollHistory.Update = Update
    AutoRoll.RollHistory.Add = Add
    AutoRoll.RollHistory.Show = Show
    AutoRoll.RollHistory.ConfigDebugButton = ConfigDebugButton

end
