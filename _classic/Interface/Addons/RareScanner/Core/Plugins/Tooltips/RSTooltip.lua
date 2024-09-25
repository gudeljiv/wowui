-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- LibQTip
local RareScannerMapTooltip = LibStub('LibQTip-1.0RS')

local RSTooltip = private.NewLib("RareScannerTooltip")

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSGuideDB = private.ImportLib("RareScannerGuideDB")

-- RareScanner general libraries
local RSLogger = private.ImportLib("RareScannerLogger")
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSTimeUtils = private.ImportLib("RareScannerTimeUtils")

-- RareScanner service libraries
local RSLootTooltip = private.ImportLib("RareScannerLootTooltip")
local RSNotes = private.ImportLib("RareScannerNotes")
local RSLoot = private.ImportLib("RareScannerLoot")

--=====================================================
-- LibQtip provider for groups
--=====================================================

local provider, cellPrototype = RareScannerMapTooltip:CreateCellProvider()

local pinFramePool = CreateFramePool("FRAME", UIParent, "RSEntityPinTemplate");

local function GetTipAnchor(frame)
	local x, y = frame:GetCenter()
	if not x or not y then return "TOPLEFT", "BOTTOMLEFT" end
	local hhalf = (x > UIParent:GetWidth() * 2 / 3) and "RIGHT" or (x < UIParent:GetWidth() / 3) and "LEFT" or "LEFT"
	local vhalf = (y > UIParent:GetHeight() / 2) and "TOP" or "BOTTOM"
	return vhalf .. hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP") .. hhalf
end

function cellPrototype:SetupCell(cell, args)
	local parentPin, POI, groupTooltip = unpack(args)
	self.pin = pinFramePool:Acquire()
	self.pin.dataProvider = parentPin.dataProvider
	self.pin:SetParent(self)
	self.pin:SetAllPoints(self)
	function self.pin:GetMap()
		return parentPin:GetMap()
	end
	self.pin:SetScript("OnEnter", function()
		RSTooltip.ShowSimpleTooltip(self.pin, groupTooltip)
		if (self.pin.tooltip) then
			self.pin.tooltip:ClearAllPoints();
			self.pin.tooltip:SetPoint(GetTipAnchor(groupTooltip))
			groupTooltip.tooltip = self.pin.tooltip
		end
	end)
	self.pin:SetScript("OnLeave", function()
		local _, _, relativePoint = GetTipAnchor(groupTooltip)
		if (RSUtils.Contains(relativePoint, "TOP") and not MouseIsOver(self.pin, 10) or RSUtils.Contains(relativePoint, "BOTTOM") and not MouseIsOver(self.pin, nil, -10)) then
			RSTooltip.HideTooltip(self.pin.tooltip)
			groupTooltip.tooltip = nil
		end
	end)
	self.pin.POI = POI
	self.pin.Texture:SetTexture(POI.Texture)
	self.pin.IconTexture:SetAtlas(POI.iconAtlas)
	self.pin.Texture:SetScale(0.7)
	--MapPinHighlight_CheckHighlightPin(self.pin:GetHighlightType(), self.pin, self.pin.Texture, AREAPOI_HIGHLIGHT_PARAMS);
	self.pin:Show()
	return self.pin:GetWidth(), self.pin:GetHeight()
end

function cellPrototype:ReleaseCell()
	pinFramePool:Release(self.pin)
	RSTooltip.ReleaseTooltip(self.pin.tooltip)
end

--=====================================================
-- Auxiliar tooltips functions
--=====================================================

local ItemToolTip = CreateFrame("GameTooltip", "RSMapItemToolTip", nil, "GameTooltipTemplate")
local ItemToolTipComp1 = CreateFrame("GameTooltip", "RSMapItemToolTipComp1", nil, "GameTooltipTemplate")
local ItemToolTipComp2 = CreateFrame("GameTooltip", "RSMapItemToolTipComp2", nil, "GameTooltipTemplate")
local InfoToolTip = CreateFrame("GameTooltip", "RSMapInfoToolTip", nil, "GameTooltipTemplate")
ItemToolTip.shoppingTooltips = { ItemToolTipComp1, ItemToolTipComp2 }

local function showItemToolTip(cell, args)
	local itemID, itemLink, itemClassID, itemSubClassID, isLink = unpack(args)
	if (isLink) then
		ItemToolTip:SetScale(RSConfigDB.GetChatLootAchievTooltipsScale())
	else
		ItemToolTip:SetScale(RSConfigDB.GetWorldMapLootAchievTooltipsScale())
	end
	
	if (RSConfigDB.GetWorldMapLootAchievTooltipPosition() == "ANCHOR_LEFT") then
		ItemToolTip:SetOwner(cell:GetParent():GetParent():GetParent(), "ANCHOR_BOTTOMLEFT", 0, cell:GetParent():GetParent():GetParent():GetHeight())	
	elseif (RSConfigDB.GetWorldMapLootAchievTooltipPosition() == "ANCHOR_RIGHT") then
		ItemToolTip:SetOwner(cell:GetParent():GetParent():GetParent(), "ANCHOR_BOTTOMRIGHT", 0, cell:GetParent():GetParent():GetParent():GetHeight())	
	elseif (RSConfigDB.GetWorldMapLootAchievTooltipPosition() == "ANCHOR_TOPLEFT") then
		ItemToolTip:SetOwner(cell:GetParent():GetParent():GetParent(), "ANCHOR_LEFT")	
	elseif (RSConfigDB.GetWorldMapLootAchievTooltipPosition() == "ANCHOR_TOPRIGHT") then
		ItemToolTip:SetOwner(cell:GetParent():GetParent():GetParent(), "ANCHOR_RIGHT")	
	else
		ItemToolTip:SetOwner(cell:GetParent():GetParent():GetParent(), RSConfigDB.GetWorldMapLootAchievTooltipPosition())	
	end

	ItemToolTip:SetHyperlink(itemLink)
	ItemToolTip:SetFrameLevel(cell:GetParent():GetParent():GetParent():GetFrameLevel() + 100)
	
	-- Adds extra information
	RSLootTooltip.AddRareScannerInformation(ItemToolTip, itemLink, itemID, itemClassID, itemSubClassID)
	ItemToolTip:Show()
end

local function showHideItemComparationTooltip(cell, _, event, key, down)
	if (event ~= "MODIFIER_STATE_CHANGED") then
		return
	end
	
	if (down == 1) then
		if (IsShiftKeyDown() and not IsAltKeyDown() and not IsControlKeyDown() and ItemToolTip:IsShown()) then
			ItemToolTipComp1:SetScale(RSConfigDB.GetWorldMapLootAchievTooltipsScale())
			ItemToolTipComp2:SetScale(RSConfigDB.GetWorldMapLootAchievTooltipsScale())
			ItemToolTipComp1:SetFrameLevel(2100)
			ItemToolTipComp2:SetFrameLevel(2100)
			GameTooltip_ShowCompareItem(ItemToolTip)
		end
	elseif (down == 0) then
		GameTooltip_HideShoppingTooltips(ItemToolTip)
	end
end

local function hideItemToolTip(cell)
	ItemToolTip:Hide()
end

local function filterItem(cell, args, button)
	local itemID, itemClassID, itemSubClassID, itemLink = unpack(args)
	RSLootTooltip.HandleInputEvents(button, itemLink, itemClassID, itemSubClassID, itemID)
end

local function hideInfoTooltip()
	InfoToolTip:Hide()
end

local function showInfoTooltip(cell, args)
	local value, isLink = unpack(args)
	if (isLink) then
		InfoToolTip:SetScale(RSConfigDB.GetChatLootAchievTooltipsScale())
	else
		InfoToolTip:SetScale(RSConfigDB.GetWorldMapLootAchievTooltipsScale())
	end
	InfoToolTip:SetOwner(cell, "ANCHOR_LEFT")
	InfoToolTip:SetFrameLevel(2100)
	InfoToolTip:SetText(value)
	InfoToolTip:Show()
end

local function showAchievementTooltip(cell, args)
	local achievementLink, isLink = unpack(args)
	if (isLink) then
		ItemToolTip:SetScale(RSConfigDB.GetChatLootAchievTooltipsScale())
	else
		ItemToolTip:SetScale(RSConfigDB.GetWorldMapLootAchievTooltipsScale())
	end
	ItemToolTip:SetOwner(cell:GetParent():GetParent():GetParent(), "ANCHOR_LEFT")
	ItemToolTip:SetHyperlink(achievementLink)
	ItemToolTip:Show()
end

--=====================================================
-- Tooltip lines
--=====================================================

function RSTooltip.ShowGroupTooltip(pin)
	-- If a tooltip is already being displayed, dont add another one
	if (pin.groupTooltip and not RSTooltip.HideGroupTooltip(pin.groupTooltip)) then
		return
	end

	local tpColumns = table.getn(pin.POI.POIs)

	local identation = {}
	for i=1, tpColumns do
		tinsert(identation, "CENTER");
	end

	-- Avoid to reuse one tooltip that for whatever reason was already opened
	local groupTooltip = RareScannerMapTooltip:Acquire("RsGroupMapToolTip", tpColumns, unpack(identation))
	RSTooltip.HideGroupTooltip(groupTooltip)
	groupTooltip = RareScannerMapTooltip:Acquire("RsGroupMapToolTip", tpColumns, unpack(identation))

	pin.groupTooltip = groupTooltip
	groupTooltip:SetScale(RSConfigDB.GetWorldMapTooltipsScale())
	groupTooltip:SetFrameLevel(2000)
	groupTooltip:ClearAllPoints()
	groupTooltip:SetClampedToScreen(true)
	groupTooltip:SetScript("OnLeave", function()
		RSTooltip.HideGroupTooltip(pin.groupTooltip)
	end)

	local line = groupTooltip:AddLine()
	for i, POI in ipairs (pin.POI.POIs) do
		groupTooltip:SetCell(line, i, { pin, POI, groupTooltip }, nil, "LEFT", 1, provider)
	end

	groupTooltip:SmartAnchorTo(pin)
	groupTooltip:Show()
end

local function AddLastTimeSeenTooltip(tooltip, pin, isLink)
	if (isLink) then
		if (not RSConfigDB.IsShowingChatTooltipsSeen()) then
			return
		end
	elseif (not RSConfigDB.IsShowingTooltipsSeen() or pin.POI.isDragonGlyph) then
		return
	end
	
	local line = tooltip:AddLine()
	if (pin.POI.isDiscovered) then
		tooltip:SetCell(line, 1, string.format(AL["MAP_TOOLTIP_SEEN"], RSUtils.TextColor(RSTimeUtils.TimeStampToClock(pin.POI.foundTime, true), "FF8000")), nil, "LEFT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
	else
		tooltip:SetCell(line, 1, RSUtils.TextColor(AL["MAP_TOOLTIP_NOT_FOUND"], "FF0000"), nil, "LEFT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
	end
end

local function AddNotesTooltip(tooltip, pin)
	if (not RSConfigDB.IsShowingTooltipsNotes()) then
		return
	end
	
	local note = RSNotes.GetNote(pin.POI.entityID, pin.POI.mapID)
	if (note) then
		local line = tooltip:AddLine()
		tooltip:SetCell(line, 1, RSUtils.TextColor(note, "FFFFCC"), nil, "LEFT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
	end
end

local function AddLootTooltip(tooltip, pin, isLink)
	local lootAdded = false
	
	if (isLink) then
		if (not RSConfigDB.IsShowingChatTooltipsLoot()) then
			return lootAdded
		end
	elseif (not RSConfigDB.IsShowingLootOnWorldMap()) then
		return lootAdded
	end
	
	local itemsIDs
	if (pin.POI.isNpc) then
		itemsIDs = RSNpcDB.GetNpcLoot(pin.POI.entityID)
	elseif (pin.POI.isContainer) then
		itemsIDs = RSContainerDB.GetContainerLoot(pin.POI.entityID)
	end

	-- Apply loot filters
	local itemsIDsFiltered = {}
	if (RSUtils.GetTableLength(itemsIDs) > 0) then
		for i, itemID in ipairs(itemsIDs) do
			local itemLink, itemRarity, itemEquipLoc, iconFileDataID, itemClassID, itemSubClassID = RSGeneralDB.GetItemInfo(itemID)
			if (iconFileDataID and not RSLoot.IsFiltered(pin.POI.entityID, itemID, itemLink, itemRarity, itemEquipLoc, itemClassID, itemSubClassID)) then
				local itemInfo = { itemID, itemLink, itemRarity, itemEquipLoc, iconFileDataID, itemClassID, itemSubClassID }
				tinsert(itemsIDsFiltered, itemInfo)
			end
		end
	end
		
	-- Sort loot by Class and SubClass
	table.sort(itemsIDsFiltered, function(a, b) 
		if a[6] == b[6] then
			return a[7] < b[7]
		else
			return a[6] < b[6] 
		end
	end)

	-- Add loot to the tooltip
	if (RSUtils.GetTableLength(itemsIDsFiltered) > 0) then
		tooltip:AddSeparator(1)
				
		local line = tooltip:AddLine()		

		local maxItems = 60
		local j
		for i, itemInfo in ipairs(itemsIDsFiltered) do
			if (maxItems == 0) then
				break
			end
			
			local itemLink, itemRarity, itemEquipLoc, iconFileDataID, itemClassID, itemSubClassID = RSGeneralDB.GetItemInfo(itemInfo[1])
		
			j = (i - floor(i/10) * 10)
			if (j == 0) then
				j = 10
			end

			tooltip:SetCell(line, j, "|T"..iconFileDataID..":24|t", nil, "LEFT", 1, nil, nil, nil, nil, 20, 20)
			tooltip:SetCellScript(line, j, "OnEnter", showItemToolTip, { itemInfo[1], itemLink, itemClassID, itemSubClassID, isLink });
			tooltip:SetCellScript(line, j, "OnEvent", showHideItemComparationTooltip)
			tooltip:SetCellScript(line, j, "OnLeave", hideItemToolTip)
			tooltip:SetCellScript(line, j, "OnMouseDown", filterItem, { itemInfo[1], itemClassID, itemSubClassID, itemLink })

			if (floor(j%10) == 0) then
				line = tooltip:AddLine()
			end
			
			maxItems = maxItems - 1
		end

		-- fill with white spaces
		if (j <= 9) then
			if (RSUtils.GetTableLength(itemsIDsFiltered) > 10) then
				tooltip:SetCell(line, j+1, " ", nil, "LEFT", 10-j, nil, nil, nil, nil, 20 * (10 - j), 20 * (10 - j))
			else
				tooltip:SetCell(line, j+1, " ", nil, "LEFT", 10-j, nil, nil, nil, nil, 30 * (10 - j), 30 * (10 - j))
			end
		end

		tooltip:AddSeparator(1)
		lootAdded = true
	end
	
	return lootAdded
end

local function AddGuideTooltip(tooltip, pin, addSeparator)
	if (not RSConfigDB.IsShowingTooltipsCommands()) then
		return false
	end
	
	-- Guide
	local guide = false
	if (pin.POI.isNpc) then
		guide = RSGuideDB.GetNpcGuide(pin.POI.entityID, pin.POI.mapID)
	elseif (pin.POI.isContainer) then
		guide = RSGuideDB.GetContainerGuide(pin.POI.entityID, pin.POI.mapID)
	end

	if (guide) then
		if (addSeparator) then
			tooltip:AddSeparator(1)
		end
		
		local line = tooltip:AddLine()	
		tooltip:SetCell(line, 1, "|TInterface\\AddOns\\RareScanner\\Media\\Textures\\tooltip_shortcuts:18:60:::256:256:0:96:64:96|t "..RSUtils.TextColor(AL["MAP_TOOLTIP_SHOW_GUIDE"], "05DFDC"), nil, "LEFT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
		return true
	end
	
	return false
end

local function AddShareTooltip(tooltip, pin, addSeparator)
	if (not RSConfigDB.IsShowingChatTooltipsCommands()) then
		return false
	end
	
	if (addSeparator) then
		tooltip:AddSeparator(1)
	end
	
	local line = tooltip:AddLine()	
	tooltip:SetCell(line, 1, "|TInterface\\AddOns\\RareScanner\\Media\\Textures\\tooltip_shortcuts:18:60:::256:256:0:96:32:64|t "..RSUtils.TextColor(AL["MAP_TOOLTIP_SHARE"], "05DFDC"), nil, "LEFT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
	return true
end

local function AddOverlayTooltip(tooltip, pin, addSeparator)
	if (not RSConfigDB.IsShowingTooltipsCommands()) then
		return false
	end
	
	local overlay = nil
	if (pin.POI.isNpc) then
		overlay = RSNpcDB.GetInternalNpcOverlay(pin.POI.entityID, pin.POI.mapID)
	elseif (pin.POI.isContainer) then
		overlay = RSContainerDB.GetInternalContainerOverlay(pin.POI.entityID, pin.POI.mapID)
	end

	if (overlay) then
		if (addSeparator) then
			tooltip:AddSeparator(1)
		end
		
		local line = tooltip:AddLine()	
		tooltip:SetCell(line, 1, "|TInterface\\AddOns\\RareScanner\\Media\\Textures\\tooltip_shortcuts:18:60:::256:256:0:96:96:128|t "..RSUtils.TextColor(AL["MAP_TOOLTIP_SHOW_OVERLAY"], "FFF5EE"), nil, "LEFT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
		return true
	end
	
	return false
end

local function AddFilterStateTooltip(tooltip, pin, addSeparator)
	if (not RSConfigDB.IsShowingTooltipsFilterState()) then
		return false
	end
	
	local filterType = nil
	if (pin.POI.isNpc) then
		filterType = RSConfigDB.GetNpcFiltered(pin.POI.entityID)
	elseif (pin.POI.isContainer) then
		filterType = RSConfigDB.GetContainerFiltered(pin.POI.entityID)
	end

	if (filterType) then
		if (addSeparator) then
			tooltip:AddSeparator(1)
		end
		
		local filterText
		if (filterType == RSConstants.ENTITY_FILTER_WORLDMAP) then
			filterText = AL["MAP_TOOLTIPS_FILTER_STATE_WORLDMAP"]
		elseif (filterType == RSConstants.ENTITY_FILTER_ALERTS) then
			filterText = AL["MAP_TOOLTIPS_FILTER_STATE_ALERTS"]
		else
			filterText = AL["MAP_TOOLTIPS_FILTER_STATE_ALL"]
		end
		
		local line = tooltip:AddLine()
		tooltip:SetCell(line, 1, "|A:perks-warning-small:16:16::::|a "..RSUtils.TextColor(filterText, "FFA500"), nil, "RIGHT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
		return true
	end
	
	return false
end

local function AddFilterTooltip(tooltip, pin, addSeparator)
	if (not RSConfigDB.IsShowingTooltipsCommands()) then
		return false
	end
	
	-- Skip if dragon glyph
	if (pin.POI.isDragonGlyph) then
		return false
	end
	
	if (addSeparator) then
		tooltip:AddSeparator(1)
	end
	
	local line = tooltip:AddLine()
	tooltip:SetCell(line, 1, "|TInterface\\AddOns\\RareScanner\\Media\\Textures\\tooltip_shortcuts:18:60:::256:256:0:96:0:32|t "..RSUtils.TextColor(AL["MAP_TOOLTIP_FILTER_ENTITY"], "00FF00"), nil, "LEFT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
	return true
end

local function AddWaypointsTooltip(tooltip, pin, onShift, addSeparator, isLink)
	if (isLink) then
		if (not RSConfigDB.IsShowingChatTooltipsCommands()) then
			return false
		elseif (not RSConfigDB.IsAddingchatTomtomWaypoints()) then
			return false
		end
	elseif (not RSConfigDB.IsShowingTooltipsCommands()) then
		return false
	elseif (not RSConfigDB.IsAddingWorldMapTomtomWaypoints()) then
		return false
	end
	
	if (addSeparator) then
		tooltip:AddSeparator(1)
	end
	
	local line = tooltip:AddLine()
	if (onShift) then
		tooltip:SetCell(line, 1, "|TInterface\\AddOns\\RareScanner\\Media\\Textures\\tooltip_shortcuts:18:60:::256:256:0:96:32:64|t "..RSUtils.TextColor(AL["MAP_TOOLTIP_ADD_WAYPOINT"], "FFFF00"), nil, "LEFT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
	else
		tooltip:SetCell(line, 1, "|TInterface\\AddOns\\RareScanner\\Media\\Textures\\tooltip_shortcuts:18:60:::256:256:0:96:64:96|t "..RSUtils.TextColor(AL["MAP_TOOLTIP_ADD_WAYPOINT"], "FFFF00"), nil, "LEFT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
	end
	return true
end

--=====================================================
-- Functions to show/hide the tooltip
--=====================================================

function RSTooltip.ShowGroupTooltip(pin)
	-- If a tooltip is already being displayed, dont add another one
	if (pin.groupTooltip and not RSTooltip.HideGroupTooltip(pin.groupTooltip)) then
		return
	end

	local tpColumns = table.getn(pin.POI.POIs)

	local identation = {}
	for i=1, tpColumns do
		tinsert(identation, "CENTER");
	end

	-- Avoid to reuse one tooltip that for whatever reason was already opened
	local groupTooltip = RareScannerMapTooltip:Acquire("RsGroupMapToolTip", tpColumns, unpack(identation))
	RSTooltip.HideGroupTooltip(groupTooltip)
	groupTooltip = RareScannerMapTooltip:Acquire("RsGroupMapToolTip", tpColumns, unpack(identation))

	if (groupTooltip.closeButton) then
		groupTooltip.closeButton:Hide()
	end
	
	pin.groupTooltip = groupTooltip
	groupTooltip:SetFrameLevel(2000)
	groupTooltip:ClearAllPoints()
	groupTooltip:SetClampedToScreen(true)
	groupTooltip:SetScript("OnLeave", function()
		RSTooltip.HideGroupTooltip(pin.groupTooltip)
	end)

	local line = groupTooltip:AddLine()
	for i, POI in ipairs (pin.POI.POIs) do
		groupTooltip:SetCell(line, i, { pin, POI, groupTooltip }, nil, "LEFT", 1, provider)
	end

	groupTooltip:SmartAnchorTo(pin)
	groupTooltip:Show()
end

function RSTooltip.ShowSimpleTooltip(pin, parentTooltip)
	-- If a tooltip is already being displayed, dont add another one
	if (pin.tooltip and not RSTooltip.HideTooltip(pin.tooltip)) then
		return
	end

	local tooltip = RareScannerMapTooltip:Acquire("RsSimpleMapToolTip", 10, "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER")
	pin.tooltip = tooltip
	tooltip:SetScale(RSConfigDB.GetWorldMapTooltipsScale())
	tooltip:SetFrameLevel(2000)
	tooltip:ClearAllPoints()
	--tooltip:SetCellMarginH(10)
	tooltip:SetClampedToScreen(true)
	tooltip:SetScript("OnLeave", function()
		RSTooltip.HideTooltip(pin.tooltip)
		if (parentTooltip and not MouseIsOver(parentTooltip)) then
			RSTooltip.HideGroupTooltip(parentTooltip)
		end
	end)
	
	if (tooltip.closeButton) then
		tooltip.closeButton:Hide()
	end
	
	-- NPC name
	local line = tooltip:AddLine()
	if (pin.POI.name) then
		tooltip:SetCell(line, 1, RSUtils.TextColor(pin.POI.name, "3399FF"), nil, "LEFT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
	else
		tooltip:SetCell(line, 1, RSUtils.TextColor(UKNOWNBEING, "3399FF"), nil, "LEFT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
	end
	
	-- Last time seen
	AddLastTimeSeenTooltip(tooltip, pin)

	-- Notes
	AddNotesTooltip(tooltip, pin)

	-- Loot
	local lootAdded = AddLootTooltip(tooltip, pin)

	-- Text to display command to auto tag as dead/completed/opened or the time remaining to be available again
	local filterAdded = AddFilterTooltip(tooltip, pin, not lootAdded)

	-- Waypoints
	local waypointAdded = AddWaypointsTooltip(tooltip, pin, true, not filterAdded)

	-- Guide
	local guideAdded = AddGuideTooltip(tooltip, pin, not filterAdded and not waypointAdded)

	-- Overlay
	local overlayAdded = AddOverlayTooltip(tooltip, pin, not filterAdded and not waypointAdded and not guideAdded)

	-- Filtered state
	AddFilterStateTooltip(tooltip, pin, true)
	
	tooltip:SmartAnchorTo(pin)
	tooltip:Show()
end

function RSTooltip.ShowLinkTooltip(pin, chatFrame)
	local tooltip = RareScannerMapTooltip:Acquire("RsLinkToolTip", 10, "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER")
	pin.tooltip = tooltip
	tooltip:SetScale(RSConfigDB.GetChatTooltipsScale())
	tooltip:SetFrameLevel(10)
	tooltip:ClearAllPoints()
	tooltip:SetClampedToScreen(true)
	
	if (not tooltip.closeButton) then
		tooltip.closeButton = CreateFrame("Button", "LinkCloseButton", tooltip, "UIPanelCloseButton")
		tooltip.closeButton:SetPoint("TOPRIGHT", tooltip)
		tooltip.closeButton:SetFrameLevel(11)
		tooltip.closeButton:SetScript("OnHide", function()
			RSTooltip.HideTooltip(pin.tooltip, true)
			pin.tooltip = nil
		end)
	else
		tooltip.closeButton:Show()
	end

	-- Entity name
	local line = tooltip:AddLine()
	if (pin.POI.name) then
		tooltip:SetCell(line, 1, RSUtils.TextColor(pin.POI.name, "3399FF"), nil, "LEFT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
	else
		tooltip:SetCell(line, 1, RSUtils.TextColor(UKNOWNBEING, "3399FF"), nil, "LEFT", 10, nil, nil, nil, RSConstants.TOOLTIP_MAX_WIDTH, RSConstants.TOOLTIP_MAX_WIDTH)
	end
	
	-- Last time seen
	AddLastTimeSeenTooltip(tooltip, pin, true)

	-- Loot
	local lootAdded = AddLootTooltip(tooltip, pin, true)

	-- Text to display command to auto tag as dead/completed/opened or the time remaining to be available again
	--local filterAdded = AddFilterTooltip(tooltip, pin, not lootAdded)
	
	-- Share note
	local shareAdded = false
	if (pin.POI.isNpc) then
		shareAdded = AddShareTooltip(tooltip, pin, not lootAdded)
	end
	
	-- Waypoints
	local waypointAdded = AddWaypointsTooltip(tooltip, pin, false, not lootAdded and not shareAdded, true)
	
	-- Filtered state
	AddFilterStateTooltip(tooltip, pin, true)
	
	tooltip:SmartAnchorTo(chatFrame, true)
    --tooltip:SetPoint("BOTTOMLEFT", chatFrame, "TOPLEFT")
	tooltip:Show()
end

function RSTooltip.HideTooltip(tooltip, isLinkTooltip)
	if (tooltip) then
		if (not isLinkTooltip and MouseIsOver(tooltip)) then
			return false
		end
		RareScannerMapTooltip:Release(tooltip)
		tooltip = nil
		return true
	end
end

function RSTooltip.HideGroupTooltip(groupTooltip)
	if (groupTooltip and groupTooltip.tooltip and groupTooltip.tooltip:IsShown()) then
		return false;
	end

	return RSTooltip.HideTooltip(groupTooltip)
end

function RSTooltip.ReleaseTooltip(tooltip)
	if (tooltip) then
		tooltip:Hide()
		RareScannerMapTooltip:Release(tooltip)
		tooltip = nil
	end
	ItemToolTip:Hide()
end