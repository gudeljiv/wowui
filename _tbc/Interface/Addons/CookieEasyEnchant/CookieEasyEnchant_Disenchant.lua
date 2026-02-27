-- CookieEasyEnchant: Multi-Disenchant Module
-- Standalone window for bulk disenchanting bag items

local addonName, addon = ...

-- Module state
local deFrame           -- Main disenchant window frame
local scrollFrame       -- Scroll frame for item list
local itemRows = {}     -- Pool of visible row frames
local scannedItems = {} -- Items found in bags after scanning
local sessionDismissed = {} -- {["bag:slot"] = true} dismissed this session
local selectedDE = nil  -- Currently selected item for disenchant {bag, slot, name, link}
local NUM_VISIBLE_ROWS = 8

-- Forward declarations
local ScanBags, RefreshList, CreateDisenchantFrame, UpdateDEButton

-- Single secure disenchant button, created at load time (same pattern as enchant button)
local deSecureButton = CreateFrame("Button", "CookieEasyEnchantDEButton", UIParent, "SecureActionButtonTemplate, UIPanelButtonTemplate")
deSecureButton:SetSize(280, 26)
deSecureButton:Hide()
deSecureButton:SetText("Disenchant")
deSecureButton:SetAttribute("type", "macro")
deSecureButton:SetAttribute("macrotext", "")
deSecureButton:RegisterForClicks("AnyUp", "AnyDown")

--------------------------------------------------------------------------------
-- Quality Filtering
--------------------------------------------------------------------------------

local QUALITY_UNCOMMON = 2  -- Green
local QUALITY_RARE = 3      -- Blue
local QUALITY_EPIC = 4      -- Purple

-- Equip locations that correspond to disenchantable gear (weapons + armor)
local DISENCHANTABLE_SLOTS = {
    INVTYPE_HEAD = true, INVTYPE_NECK = true, INVTYPE_SHOULDER = true,
    INVTYPE_CHEST = true, INVTYPE_ROBE = true, INVTYPE_WAIST = true,
    INVTYPE_LEGS = true, INVTYPE_FEET = true, INVTYPE_WRIST = true,
    INVTYPE_HAND = true, INVTYPE_FINGER = true, INVTYPE_TRINKET = true,
    INVTYPE_CLOAK = true, INVTYPE_WEAPON = true, INVTYPE_SHIELD = true,
    INVTYPE_2HWEAPON = true, INVTYPE_WEAPONMAINHAND = true,
    INVTYPE_WEAPONOFFHAND = true, INVTYPE_HOLDABLE = true,
    INVTYPE_RANGED = true, INVTYPE_RANGEDRIGHT = true,
    INVTYPE_THROWN = true, INVTYPE_RELIC = true,
}

-- Weapon equip locations (for disenchant result probabilities)
local WEAPON_SLOTS = {
    INVTYPE_WEAPON = true, INVTYPE_2HWEAPON = true,
    INVTYPE_WEAPONMAINHAND = true, INVTYPE_WEAPONOFFHAND = true,
    INVTYPE_RANGED = true, INVTYPE_RANGEDRIGHT = true,
    INVTYPE_THROWN = true,
}

--------------------------------------------------------------------------------
-- Disenchant Results Data (TBC, iLvl 1-120)
--------------------------------------------------------------------------------

local function GetDisenchantResults(quality, itemLevel, isWeapon)
    local results = {}

    if quality == QUALITY_UNCOMMON then
        -- Determine material tier by item level
        local dust, essence, shard
        if itemLevel <= 20 then
            dust = "Strange Dust"
            essence = (isWeapon and "Lesser Magic Essence") or "Lesser Magic Essence"
            if itemLevel <= 15 then
                essence = "Lesser Magic Essence"
            else
                essence = "Greater Magic Essence"
            end
        elseif itemLevel <= 25 then
            dust = "Strange Dust"
            essence = "Lesser Astral Essence"
        elseif itemLevel <= 30 then
            dust = "Soul Dust"
            essence = "Greater Astral Essence"
        elseif itemLevel <= 35 then
            dust = "Soul Dust"
            essence = "Lesser Mystic Essence"
        elseif itemLevel <= 40 then
            dust = "Vision Dust"
            essence = "Greater Mystic Essence"
        elseif itemLevel <= 45 then
            dust = "Vision Dust"
            essence = "Lesser Nether Essence"
        elseif itemLevel <= 50 then
            dust = "Dream Dust"
            essence = "Greater Nether Essence"
        elseif itemLevel <= 55 then
            dust = "Dream Dust"
            essence = "Lesser Eternal Essence"
        elseif itemLevel <= 60 then
            dust = "Illusion Dust"
            essence = "Greater Eternal Essence"
        elseif itemLevel <= 70 then
            dust = "Illusion Dust"
            essence = "Greater Eternal Essence"
        elseif itemLevel <= 99 then
            dust = "Arcane Dust"
            essence = "Lesser Planar Essence"
        else
            dust = "Arcane Dust"
            essence = "Greater Planar Essence"
        end

        -- Shard tier
        if itemLevel <= 25 then
            shard = "Small Glimmering Shard"
        elseif itemLevel <= 30 then
            shard = "Large Glimmering Shard"
        elseif itemLevel <= 35 then
            shard = "Small Glowing Shard"
        elseif itemLevel <= 40 then
            shard = "Large Glowing Shard"
        elseif itemLevel <= 45 then
            shard = "Small Radiant Shard"
        elseif itemLevel <= 50 then
            shard = "Large Radiant Shard"
        elseif itemLevel <= 55 then
            shard = "Small Brilliant Shard"
        elseif itemLevel <= 60 then
            shard = "Large Brilliant Shard"
        elseif itemLevel <= 70 then
            shard = "Large Brilliant Shard"
        else
            shard = "Small Prismatic Shard"
        end

        -- Dust quantities by tier
        local dustMin, dustMax = 1, 3
        if itemLevel > 50 then dustMin, dustMax = 2, 5
        elseif itemLevel > 30 then dustMin, dustMax = 1, 4 end

        if isWeapon then
            -- Weapons: essence 75%, dust 20%, shard 5%
            table.insert(results, {material = essence, qtyMin = 1, qtyMax = 2, chance = 75})
            table.insert(results, {material = dust, qtyMin = dustMin, qtyMax = dustMax, chance = 20})
            table.insert(results, {material = shard, qtyMin = 1, qtyMax = 1, chance = 5})
        else
            -- Armor: dust 75%, essence 20%, shard 5%
            table.insert(results, {material = dust, qtyMin = dustMin, qtyMax = dustMax, chance = 75})
            table.insert(results, {material = essence, qtyMin = 1, qtyMax = 2, chance = 20})
            table.insert(results, {material = shard, qtyMin = 1, qtyMax = 1, chance = 5})
        end

    elseif quality == QUALITY_RARE then
        local shard
        if itemLevel <= 25 then
            shard = "Small Glimmering Shard"
        elseif itemLevel <= 30 then
            shard = "Large Glimmering Shard"
        elseif itemLevel <= 35 then
            shard = "Small Glowing Shard"
        elseif itemLevel <= 40 then
            shard = "Large Glowing Shard"
        elseif itemLevel <= 45 then
            shard = "Small Radiant Shard"
        elseif itemLevel <= 50 then
            shard = "Large Radiant Shard"
        elseif itemLevel <= 55 then
            shard = "Small Brilliant Shard"
        elseif itemLevel <= 65 then
            shard = "Large Brilliant Shard"
        elseif itemLevel <= 99 then
            shard = "Small Prismatic Shard"
        else
            shard = "Large Prismatic Shard"
        end

        if itemLevel >= 56 and itemLevel <= 65 then
            table.insert(results, {material = shard, qtyMin = 1, qtyMax = 1, chance = 99.5})
            table.insert(results, {material = "Nexus Crystal", qtyMin = 1, qtyMax = 1, chance = 0.5})
        elseif itemLevel > 65 then
            table.insert(results, {material = shard, qtyMin = 1, qtyMax = 1, chance = 99.5})
            table.insert(results, {material = "Void Crystal", qtyMin = 1, qtyMax = 1, chance = 0.5})
        else
            table.insert(results, {material = shard, qtyMin = 1, qtyMax = 1, chance = 100})
        end

    elseif quality == QUALITY_EPIC then
        local crystal
        if itemLevel <= 65 then
            crystal = "Nexus Crystal"
        elseif itemLevel <= 99 then
            crystal = "Void Crystal"
        else
            crystal = "Void Crystal"
        end
        table.insert(results, {material = crystal, qtyMin = 1, qtyMax = 2, chance = 100})
    end

    return results
end

local function QualityPassesFilter(quality)
    if quality == QUALITY_UNCOMMON then return CookieEasyEnchantDB.deFilterUncommon end
    if quality == QUALITY_RARE then return CookieEasyEnchantDB.deFilterRare end
    if quality == QUALITY_EPIC then return CookieEasyEnchantDB.deFilterEpic end
    return false
end

--------------------------------------------------------------------------------
-- BoE / BoP Detection via Tooltip Scanning
--------------------------------------------------------------------------------

local scanTooltip

local function IsItemBoE(bag, slot)
    if not scanTooltip then
        scanTooltip = CreateFrame("GameTooltip", "CEEDEScanTooltip", nil, "GameTooltipTemplate")
        scanTooltip:SetOwner(UIParent, "ANCHOR_NONE")
    end
    scanTooltip:ClearLines()
    scanTooltip:SetBagItem(bag, slot)
    for i = 2, scanTooltip:NumLines() do
        local text = _G["CEEDEScanTooltipTextLeft" .. i]
        if text then
            local line = text:GetText() or ""
            if line == ITEM_BIND_ON_EQUIP then
                return true
            elseif line == ITEM_SOULBOUND or line == ITEM_BIND_ON_PICKUP then
                return false
            end
        end
    end
    return false
end

--------------------------------------------------------------------------------
-- Secure Button Macro Update
--------------------------------------------------------------------------------

UpdateDEButton = function()
    if not deSecureButton then return end
    if InCombatLockdown() then return end

    if not selectedDE then
        deSecureButton:SetAttribute("macrotext", "")
        deSecureButton:SetText("Select an item")
        return
    end

    local macroText = string.format("/cast Disenchant\n/use %d %d", selectedDE.bag, selectedDE.slot)
    deSecureButton:SetAttribute("macrotext", macroText)
    deSecureButton:SetText("Disenchant: " .. (selectedDE.name or "Unknown"))
end

--------------------------------------------------------------------------------
-- Bag Scanning
--------------------------------------------------------------------------------

ScanBags = function()
    scannedItems = {}
    for bag = 0, NUM_BAG_SLOTS do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local itemID = C_Container.GetContainerItemID(bag, slot)
            if itemID and not CookieEasyEnchantDB.ignoredItems[itemID]
               and not sessionDismissed[bag .. ":" .. slot] then
                local info = C_Container.GetContainerItemInfo(bag, slot)
                if info then
                    local itemName, itemLink, quality, itemLevel, _, _, _, _, itemEquipLoc = GetItemInfo(info.hyperlink)
                    -- Only equippable gear (weapons/armor) can be disenchanted
                    if quality and QualityPassesFilter(quality) and DISENCHANTABLE_SLOTS[itemEquipLoc] then
                        local isBoE = IsItemBoE(bag, slot)
                        table.insert(scannedItems, {
                            bag = bag,
                            slot = slot,
                            itemID = itemID,
                            name = itemName or "Unknown",
                            link = info.hyperlink,
                            icon = info.iconFileID,
                            quality = quality,
                            itemLevel = itemLevel or 0,
                            isBoE = isBoE,
                            isWeapon = WEAPON_SLOTS[itemEquipLoc] or false,
                        })
                    end
                end
            end
        end
    end

    -- Sort: BoP first, then BoE; within each group sort by item level
    table.sort(scannedItems, function(a, b)
        if a.isBoE ~= b.isBoE then
            return not a.isBoE  -- BoP (false) before BoE (true)
        end
        return a.itemLevel < b.itemLevel
    end)

    -- Clear selection if the selected item is no longer in the list
    if selectedDE then
        local found = false
        for _, item in ipairs(scannedItems) do
            if item.bag == selectedDE.bag and item.slot == selectedDE.slot then
                found = true
                break
            end
        end
        if not found then
            selectedDE = nil
            UpdateDEButton()
        end
    end
end

--------------------------------------------------------------------------------
-- Display List (with section headers)
--------------------------------------------------------------------------------

local function BuildDisplayList()
    local display = {}
    local bopCount, boeCount = 0, 0

    for _, item in ipairs(scannedItems) do
        if item.isBoE then boeCount = boeCount + 1 else bopCount = bopCount + 1 end
    end

    if bopCount > 0 then
        table.insert(display, { isHeader = true, headerText = "Bind on Pickup (" .. bopCount .. ")" })
        for _, item in ipairs(scannedItems) do
            if not item.isBoE then
                table.insert(display, item)
            end
        end
    end

    if boeCount > 0 then
        table.insert(display, { isHeader = true, headerText = "Bind on Equip (" .. boeCount .. ")" })
        for _, item in ipairs(scannedItems) do
            if item.isBoE then
                table.insert(display, item)
            end
        end
    end

    return display
end

--------------------------------------------------------------------------------
-- Refresh List
--------------------------------------------------------------------------------

RefreshList = function()
    local displayList = BuildDisplayList()
    local offset = FauxScrollFrame_GetOffset(scrollFrame)
    FauxScrollFrame_Update(scrollFrame, #displayList, NUM_VISIBLE_ROWS, 36)

    for i = 1, NUM_VISIBLE_ROWS do
        local row = itemRows[i]
        local idx = offset + i
        local entry = displayList[idx]

        if entry and entry.isHeader then
            row.icon:Hide()
            row.iconBorder:Hide()
            row.text:Hide()
            row.ilvl:Hide()
            row.dismissBtn:Hide()
            row.highlight:Hide()
            row.stripe:Hide()
            row.headerText:SetText(entry.headerText)
            row.headerText:Show()
            row.headerLine:Show()
            row.itemLink = nil
            row.entry = nil
            row:Show()

        elseif entry then
            row.headerText:Hide()
            row.headerLine:Hide()
            row.icon:SetTexture(entry.icon)
            row.icon:Show()

            local qualityColor = ITEM_QUALITY_COLORS[entry.quality] or ITEM_QUALITY_COLORS[1]
            for _, edge in ipairs(row.iconBorder.edges) do
                edge:SetColorTexture(qualityColor.r, qualityColor.g, qualityColor.b, 1)
            end
            row.iconBorder:Show()

            row.text:SetText(entry.name)
            row.text:SetTextColor(qualityColor.r, qualityColor.g, qualityColor.b)
            row.text:Show()

            row.ilvl:SetText("i" .. entry.itemLevel)
            row.ilvl:Show()

            row.itemLink = entry.link
            row.entry = entry

            -- Alternating row shading
            if idx % 2 == 0 then
                row.stripe:SetColorTexture(1, 1, 1, 0.04)
                row.stripe:Show()
            else
                row.stripe:Hide()
            end

            -- Show selection highlight
            if selectedDE and selectedDE.bag == entry.bag and selectedDE.slot == entry.slot then
                row.highlight:SetColorTexture(0.9, 0.8, 0.2, 0.2)
                row.highlight:Show()
            else
                row.highlight:SetColorTexture(1, 1, 1, 0.15)
                row.highlight:Hide()
            end

            -- Dismiss button handlers
            row.dismissBtn:SetScript("OnClick", function(self, button)
                if IsShiftKeyDown() then
                    CookieEasyEnchantDB.ignoredItems[entry.itemID] = true
                    DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00CookieEasyEnchant:|r Permanently ignored " .. (entry.link or entry.name))
                else
                    sessionDismissed[entry.bag .. ":" .. entry.slot] = true
                end
                ScanBags()
                RefreshList()
            end)
            row.dismissBtn:Show()

            row:Show()
        else
            row:Hide()
        end
    end
end

--------------------------------------------------------------------------------
-- Create the Disenchant Window UI
--------------------------------------------------------------------------------

CreateDisenchantFrame = function()
    if deFrame then return deFrame end

    deFrame = CreateFrame("Frame", "CookieEasyEnchantDEFrame", UIParent, "BackdropTemplate")
    deFrame:SetSize(320, 430)
    deFrame:SetPoint("CENTER")
    deFrame:SetMovable(true)
    deFrame:EnableMouse(true)
    deFrame:RegisterForDrag("LeftButton")
    deFrame:SetScript("OnDragStart", deFrame.StartMoving)
    deFrame:SetScript("OnDragStop", deFrame.StopMovingOrSizing)
    deFrame:SetFrameStrata("DIALOG")
    deFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })

    -- Title
    local title = deFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -12)
    title:SetText("Disenchant")

    -- Close button
    local closeBtn = CreateFrame("Button", nil, deFrame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -2, -2)

    -- Refresh button
    local refreshBtn = CreateFrame("Button", nil, deFrame, "UIPanelButtonTemplate")
    refreshBtn:SetSize(70, 22)
    refreshBtn:SetPoint("TOPLEFT", 12, -10)
    refreshBtn:SetText("Refresh")
    refreshBtn:SetScript("OnClick", function()
        ScanBags()
        RefreshList()
    end)

    tinsert(UISpecialFrames, "CookieEasyEnchantDEFrame")

    -- Quality filter checkboxes
    local filterY = -36
    local filters = {
        { key = "deFilterUncommon", label = "Uncommon", color = {0, 0.8, 0} },
        { key = "deFilterRare",     label = "Rare",     color = {0, 0.44, 0.87} },
        { key = "deFilterEpic",     label = "Epic",     color = {0.64, 0.21, 0.93} },
    }

    for i, f in ipairs(filters) do
        local btn = CreateFrame("CheckButton", nil, deFrame, "UICheckButtonTemplate")
        btn:SetSize(24, 24)
        btn:SetPoint("TOPLEFT", 12 + (i - 1) * 100, filterY)
        btn:SetChecked(CookieEasyEnchantDB[f.key])
        btn:SetScript("OnClick", function(self)
            CookieEasyEnchantDB[f.key] = self:GetChecked()
            ScanBags()
            RefreshList()
        end)
        local label = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        label:SetPoint("LEFT", btn, "RIGHT", 0, 0)
        label:SetText(f.label)
        label:SetTextColor(unpack(f.color))
    end

    -- Scroll frame and row pool
    local listTop = -62

    scrollFrame = CreateFrame("ScrollFrame", "CookieEasyEnchantDEScroll", deFrame, "FauxScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 8, listTop)
    scrollFrame:SetPoint("BOTTOMRIGHT", -28, 40)
    scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
        FauxScrollFrame_OnVerticalScroll(self, offset, 36, function() RefreshList() end)
    end)

    -- Create row pool
    local rowLevel = scrollFrame:GetFrameLevel() + 2
    for i = 1, NUM_VISIBLE_ROWS do
        local row = CreateFrame("Button", nil, deFrame)
        row:SetSize(270, 34)
        row:SetPoint("TOPLEFT", 12, listTop - 2 + (i - 1) * -36)
        row:SetFrameLevel(rowLevel)

        -- Alternating row stripe
        row.stripe = row:CreateTexture(nil, "BACKGROUND", nil, -1)
        row.stripe:SetAllPoints()
        row.stripe:Hide()

        -- Selection highlight
        row.highlight = row:CreateTexture(nil, "BACKGROUND")
        row.highlight:SetAllPoints()
        row.highlight:SetColorTexture(1, 1, 1, 0.15)
        row.highlight:Hide()

        -- Item icon
        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(28, 28)
        row.icon:SetPoint("LEFT", 2, 0)
        row.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)  -- Trim default icon border

        -- Quality-colored icon border (4 edge textures for TBC compatibility)
        row.iconBorder = CreateFrame("Frame", nil, row)
        row.iconBorder:SetPoint("TOPLEFT", row.icon, "TOPLEFT", -1, 1)
        row.iconBorder:SetPoint("BOTTOMRIGHT", row.icon, "BOTTOMRIGHT", 1, -1)
        row.iconBorder.edges = {}
        for _, info in ipairs({
            {"TOPLEFT", "TOPRIGHT", 0, 0, 0, -1},      -- top
            {"BOTTOMLEFT", "BOTTOMRIGHT", 0, 1, 0, 0},  -- bottom
            {"TOPLEFT", "BOTTOMLEFT", 0, 0, -1, 0},     -- left
            {"TOPRIGHT", "BOTTOMRIGHT", 1, 0, 0, 0},     -- right
        }) do
            local edge = row.iconBorder:CreateTexture(nil, "OVERLAY")
            edge:SetPoint(info[1], row.iconBorder, info[1], info[3], info[4])
            edge:SetPoint(info[2], row.iconBorder, info[2], info[5], info[6])
            if info[1] == "TOPLEFT" and info[2] == "TOPRIGHT" then edge:SetHeight(1)
            elseif info[1] == "BOTTOMLEFT" and info[2] == "BOTTOMRIGHT" then edge:SetHeight(1)
            else edge:SetWidth(1) end
            edge:SetColorTexture(1, 1, 1, 1)
            table.insert(row.iconBorder.edges, edge)
        end
        row.iconBorder:Hide()

        -- Item name
        row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        row.text:SetPoint("LEFT", row.icon, "RIGHT", 8, 0)
        row.text:SetPoint("RIGHT", row, "RIGHT", -40, 0)
        row.text:SetJustifyH("LEFT")
        row.text:SetWordWrap(false)

        -- Item level
        row.ilvl = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.ilvl:SetPoint("RIGHT", row, "RIGHT", -26, 0)
        row.ilvl:SetTextColor(0.7, 0.7, 0.7)

        -- Section header text
        row.headerText = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.headerText:SetPoint("LEFT", 0, -4)
        row.headerText:Hide()

        -- Section header divider line
        row.headerLine = row:CreateTexture(nil, "ARTWORK")
        row.headerLine:SetHeight(1)
        row.headerLine:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 2)
        row.headerLine:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 2)
        row.headerLine:SetColorTexture(0.6, 0.6, 0.6, 0.4)
        row.headerLine:Hide()

        -- Dismiss button (minimal styled X)
        row.dismissBtn = CreateFrame("Button", nil, row)
        row.dismissBtn:SetSize(18, 18)
        row.dismissBtn:SetPoint("RIGHT", row, "RIGHT", -2, 0)
        local dismissText = row.dismissBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        dismissText:SetPoint("CENTER", 0, 0)
        dismissText:SetText("x")
        dismissText:SetTextColor(0.5, 0.5, 0.5)
        row.dismissBtn:SetScript("OnEnter", function(self)
            dismissText:SetTextColor(1, 0.3, 0.3)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("Dismiss")
            GameTooltip:AddLine("Click: hide for this session", 1, 1, 1)
            GameTooltip:AddLine("Shift+Click: permanently ignore", 1, 0.5, 0.5)
            GameTooltip:Show()
        end)
        row.dismissBtn:SetScript("OnLeave", function()
            dismissText:SetTextColor(0.5, 0.5, 0.5)
            GameTooltip:Hide()
        end)

        -- Click row to select item for disenchant
        row:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
        row:RegisterForClicks("LeftButtonUp")
        row:SetScript("OnClick", function(self)
            if self.entry then
                selectedDE = self.entry
                UpdateDEButton()
                RefreshList()
            end
        end)

        -- Tooltip on hover (with disenchant results)
        row:SetScript("OnEnter", function(self)
            if self.itemLink then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink(self.itemLink)
                if self.entry then
                    local results = GetDisenchantResults(self.entry.quality, self.entry.itemLevel, self.entry.isWeapon)
                    if #results > 0 then
                        GameTooltip:AddLine(" ")
                        GameTooltip:AddLine("Disenchants into:")
                        for _, r in ipairs(results) do
                            local qty
                            if r.qtyMin == r.qtyMax then
                                qty = "x" .. r.qtyMin
                            else
                                qty = "x" .. r.qtyMin .. "-" .. r.qtyMax
                            end
                            GameTooltip:AddLine("  " .. r.material .. " " .. qty .. " (" .. r.chance .. "%)", 0.8, 0.8, 0.8)
                        end
                    end
                end
                GameTooltip:Show()
            end
        end)
        row:SetScript("OnLeave", function() GameTooltip:Hide() end)

        itemRows[i] = row
    end

    -- Reparent the pre-created secure button into the frame
    deSecureButton:SetParent(deFrame)
    deSecureButton:ClearAllPoints()
    deSecureButton:SetPoint("BOTTOM", deFrame, "BOTTOM", 0, 12)
    deSecureButton:Show()

    -- PreClick to update macro right before click (same pattern as enchant button)
    deSecureButton:SetScript("PreClick", function()
        UpdateDEButton()
    end)

    return deFrame
end

--------------------------------------------------------------------------------
-- Public API (called from slash commands)
--------------------------------------------------------------------------------

function CookieEasyEnchant_ToggleDisenchant()
    local frame = CreateDisenchantFrame()
    if frame:IsShown() then
        frame:Hide()
    else
        selectedDE = nil
        -- Pre-cache item data: GetItemInfo returns nil for uncached items on first call.
        -- Request all items now, then scan after a short delay to let the cache populate.
        local needsDelay = false
        for bag = 0, NUM_BAG_SLOTS do
            for slot = 1, C_Container.GetContainerNumSlots(bag) do
                local info = C_Container.GetContainerItemInfo(bag, slot)
                if info and info.hyperlink then
                    local itemName = GetItemInfo(info.hyperlink)
                    if not itemName then
                        needsDelay = true
                    end
                end
            end
        end
        if needsDelay then
            -- Show frame immediately, scan after cache populates
            frame:Show()
            C_Timer.After(0.5, function()
                ScanBags()
                UpdateDEButton()
                RefreshList()
            end)
        else
            ScanBags()
            UpdateDEButton()
            RefreshList()
            frame:Show()
        end
    end
end

function CookieEasyEnchant_ClearIgnoreList()
    local count = 0
    for _ in pairs(CookieEasyEnchantDB.ignoredItems or {}) do
        count = count + 1
    end
    CookieEasyEnchantDB.ignoredItems = {}
    DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00CookieEasyEnchant:|r Cleared " .. count .. " ignored item(s).")
    if deFrame and deFrame:IsShown() then
        ScanBags()
        RefreshList()
    end
end

--------------------------------------------------------------------------------
-- Event Handling
--------------------------------------------------------------------------------

local deEventFrame = CreateFrame("Frame")
deEventFrame:RegisterEvent("BAG_UPDATE")
deEventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
deEventFrame:SetScript("OnEvent", function(self, event)
    if event == "BAG_UPDATE" and deFrame and deFrame:IsShown() then
        C_Timer.After(0.1, function()
            ScanBags()
            RefreshList()
        end)
    elseif event == "PLAYER_REGEN_ENABLED" and deFrame and deFrame:IsShown() then
        UpdateDEButton()
        RefreshList()
    end
end)
