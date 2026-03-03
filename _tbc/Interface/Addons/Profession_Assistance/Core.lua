local L = PA_LOCALIZATION;

local isClassic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
	or WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC
	or WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC
	or WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC
	or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC);
local isMapClassic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
	or WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC
	or WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC
	or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC);

local expansionIcon = {
	'|TInterface\\AddOns\\Profession_Assistance\\Images\\bc.tga:18:36:0:|t',
	'|TInterface\\AddOns\\Profession_Assistance\\Images\\wrath.tga:16:36:0:|t',
	'|TInterface\\AddOns\\Profession_Assistance\\Images\\cata.tga:18:36:0:|t',
	'|TInterface\\AddOns\\Profession_Assistance\\Images\\mop.tga:16:36:0:|t',
	'|TInterface\\AddOns\\Profession_Assistance\\Images\\wod.tga:10:38:0:|t',
	'|TInterface\\AddOns\\Profession_Assistance\\Images\\legion.tga:10:38:0:|t',
	'|TInterface\\AddOns\\Profession_Assistance\\Images\\bfa.tga:10:38:0:|t',
	'|TInterface\\AddOns\\Profession_Assistance\\Images\\sl.tga:16:32:0:|t',
	'|TInterface\\AddOns\\Profession_Assistance\\Images\\df.tga:16:32:0:|t',
	'|TInterface\\AddOns\\Profession_Assistance\\Images\\tww.tga:16:38:0:|t',
	'|TInterface\\AddOns\\Profession_Assistance\\Images\\mn.tga:16:32:0:|t'
}

local typeInfo = {
	['herb'] = {
		['headline'] = L['Milling outcome']..':',
		['color'] = {r = 0, g = 1,b = 0.5},
		['dataLink'] = 'Milling',
		['locationDataLink'] = 'Herbalism'
	},
	['milling'] = {
		['headline'] = L['Milled from']..':',
		['color'] = {r = 0, g = 1,b = 0.5},
		['dataLink'] = 'Herb'
	},
	['prospecting'] = {
		['headline'] = L['Prospecting outcome']..':',
		['color'] = {r = 1, g = 0.5,b = 0},
		['dataLink'] = 'Prospecting',
	},
	['ore'] = {
		['headline'] = L['Prospected from']..':',
		['color'] = {r = 1, g = 0.5,b = 0},
		['dataLink'] = 'Ore',
		['locationDataLink'] = 'Mining'
	},
	['gear'] = {
		['headline'] = L['Disenchant into']..':',
		['color'] = {r = 1, g = 0,b = 0.9},
		['dataLink'] = 'Enchanting',
	},
	['disenchant'] = {
		['headline'] = L['Disenchant from']..':',
		['color'] = {r = 1, g = 0,b = 0.9},
		['dataLink'] = 'Material',
	},
}

local function getItemInfoWrapper(itemID)
	if isClassic then
		return GetItemInfo(itemID)
	else
		return C_Item.GetItemInfo(itemID)
	end
end;

local function getItemIconWrapper(itemID)
	if isClassic then
		return GetItemIcon(itemID)
	else
		return C_Item.GetItemIconByID(itemID)
	end
end;

local function isCosmeticItemWrapper(itemID)
	if isClassic then
		return false
	else
		return C_Item.IsCosmeticItem(itemID)
	end
end;

local function addItemTexture(itemID)
	local itemTexture = getItemIconWrapper(itemID);
	
	return (itemTexture and type(itemID) == 'number') and '|T'..itemTexture..':14|t' or ''
end

-- Functions --
local function drawFunction(tooltip, expacIcon, dataResults, dataFlavor, blockItemResults, blockLocationResults, showIcons)
	local showText = dataResults['text'] ~= nil and blockItemResults;
	local showItem = dataResults['items'] ~= nil and blockItemResults;
	
	local headerText = '\n'..((dataResults['skill'] ~= nil and isClassic) and _G['SKILL_LEVEL']..': |cffffffff'..dataResults['skill']..'|r\n' or '')..expacIcon..dataFlavor['headline'];
	if(tooltip:GetName() == 'ItemRefTooltip') then
		for line=1, tooltip:NumLines() do
			if(_G['ItemRefTooltipTextLeft'..line]:GetText() == 'Profession Assistance loading..') then
				_G['ItemRefTooltipTextLeft'..line]:SetText('')
			end;
		end
	end
	
	if(showText or showItem) then tooltip:AddLine(headerText, dataFlavor['color'].r, dataFlavor['color'].g, dataFlavor['color'].b) end
	
	if(showText) then
		-- Put next line behind isClassic statement
		if(isClassic) then tooltip:AddLine( _G['STAT_AVERAGE_ITEM_LEVEL']..': |cffffffff'..dataResults['min']..' - '..dataResults['max']..'|r', dataFlavor['color'].r, dataFlavor['color'].g, dataFlavor['color'].b) end
		for count, textTable in ipairs(dataResults['text']) do
			tooltip:AddLine((count > 1 and '\n' or '')..textTable['chance'], 1, 1, 1);
			local typeList = '';
			
			for typeCount, typeEntry in ipairs(textTable['type']) do
				typeList = typeList..(typeCount > 1 and ' & ' or '')..typeEntry;
			end
			
			tooltip:AddLine(ITEM_QUALITY_COLORS[textTable['quality']].hex.._G['ITEM_QUALITY'..textTable['quality']..'_DESC']..'|r '..typeList, 1, 1, 1);
		end;
	end;
	
	if(showItem) then
		for count, itemTable in ipairs(dataResults['items']) do
			tooltip:AddLine((count > 1 and '\n' or '')..itemTable['chance'], 1, 1, 1);
			
			for _, item in ipairs(itemTable) do
				local itemLink = select(2, getItemInfoWrapper(item));
				
				tooltip:AddLine((showIcons and addItemTexture(item) or '')..(itemLink or item), 1, 1, 1);
			end
		end
	end;
	
	if(dataResults['found'] == nil or not blockLocationResults) then return end;
	local foundInfo = dataResults['found'];
	
	tooltip:AddLine('\n'..L['Found in']..':', dataFlavor['color'].r, dataFlavor['color'].g, dataFlavor['color'].b)
	
	local wrapCount = 0;
	local nodeText = '';
	if(foundInfo['node'] ~= nil) then
		for count, item in ipairs(foundInfo['node']) do
			if(count == 1) then tooltip:AddLine(L['Nodes']..' |cffffffff'..foundInfo['chance']..'|r', dataFlavor['color'].r, dataFlavor['color'].g, dataFlavor['color'].b) end;
			local itemLink = select(2, getItemInfoWrapper(item));
			
			nodeText = nodeText..(wrapCount > 0 and ' - ' or '')..(showIcons and addItemTexture(item) or '')..(itemLink or item);
			
			wrapCount = wrapCount+1;
			if(wrapCount > 2) then wrapCount = 0; nodeText = nodeText..'\n' end;
		end
		tooltip:AddLine(nodeText, 1, 1, 1);
	end;
	
	if(foundInfo['location'] == nil) then return end;
	wrapCount = 0;
	local mapText = '';
	for count, mapLocation in ipairs(foundInfo['location']) do
		local mapID = table_mapID[mapLocation][isMapClassic and 1 or 2];
		
		if not (mapID == nil) then
			local mapInfo = C_Map.GetMapInfo(mapID);
			
			if not (mapInfo == nil) then
				if(count == 1) then tooltip:AddLine((nodeText=='' and '' or '\n').._G['ZONE'], dataFlavor['color'].r, dataFlavor['color'].g, dataFlavor['color'].b) end;
				
				mapText = mapText..(wrapCount > 0 and ' - ' or '')..mapInfo.name;
				wrapCount = wrapCount+1;
				if(wrapCount > 2) then wrapCount = 0; mapText = mapText..'\n' end;
			end
		end
	end
	
	tooltip:AddLine(mapText, 1, 1, 1);
end;

-- Search database --
local function searchItem(itemID)
	for dataType, dataResults in next, {
		['herb'] = table_herb[itemID],
		['milling'] = table_milling[itemID],
		['ore'] = table_ore[itemID],
		['prospecting'] = table_prospecting[itemID],
		['disenchant'] = table_disenchant[itemID],
	}
	do return dataType, dataResults or nil end;
end;

local function searchLevel(quality, itemLevel, itemSort, expacID)
	if(table_gear[quality] == nil or itemSort == nil) then return end;
	
	for _, itemTable in ipairs(table_gear[quality]) do
		
		if(isClassic) then
			if(itemLevel >= itemTable['min'] and itemLevel <= itemTable['max']) then
				return 'gear', itemTable[itemSort], itemTable['expansion'];
			end
		elseif(expacID == itemTable['expansion']) then
			return 'gear', itemTable[itemSort], nil
		end
	end;
	return 'gear', nil;
end;

-- Tooltip func --

local wrongItemID = nil;
local TooltipItem = function(self, ...)
	if not (self:NumLines() > 0) then return end;
	if not (PA_SavedSettings['MasterChecked']) then return end;
	
	local frameType = self:GetName(); -- ItemRefTooltip <== Gotta check on that for chat button specific
	local _, itemLink;
	if(isClassic) then
		_, itemLink = self:GetItem();
	else
		_, itemLink = TooltipUtil.GetDisplayedItem(self);
	end
	
	if(itemLink) then
		local itemID = GetItemInfoFromHyperlink(itemLink);
		if(itemID) then
			if (wrongItemID == itemID or isCosmeticItemWrapper(itemID)) then return end;
			local _, _, itemQuality, itemLevel, _, _, _, _, itemEquipLoc, _, _, classID, _, _, expacID = getItemInfoWrapper(itemID);
			
			-- print(C_Item.GetDetailedItemLevelInfo(itemID)); -- Safe keeping

			local dataType, dataResults, classicExpacID = nil, nil, nil;
			local itemSort = (classID == 4 and 'armor' or classID == 2 and 'weapon' or nil);
			
			if(classID == 7) then dataType, dataResults = searchItem(itemID); end
			if(itemSort == 'armor' or itemSort == 'weapon') then
				for _, filterType in next, {'', 'INVTYPE_BODY', 'INVTYPE_RELIC', 'INVTYPE_TABARD', 'INVTYPE_BAG', 'INVTYPE_QUIVER'} do if(itemEquipLoc == filterType) then return end end;
				dataType, dataResults, classicExpacID = searchLevel(itemQuality, itemLevel, itemSort, expacID);
			end
			
			-- Gotta check if we be playing on classic, as expacID will not be the right number otherwise!
			if(classicExpacID) then expacID = classicExpacID end
			
			if not (dataType and dataResults) and self:IsShown() then wrongItemID = itemID; return end;
			
			if(dataResults == nil or typeInfo[dataType] == nil) then return end;
			
			local dataLink = typeInfo[dataType].dataLink or '';
			local locationDataLink = typeInfo[dataType].locationDataLink or '';
			
			if(frameType == 'ItemRefTooltip') then
				if(not PA_SavedSettings[dataLink..'ChatChecked'] and not PA_SavedSettings[locationDataLink..'ChatChecked']) then return end;
				self:AddLine('Profession Assistance loading..', 1, 1, 1)
				self:Show();
				
				if(PA_SavedSettings[dataLink..'ChatChecked']) then
					if(dataResults['items'] ~= nil) then
						for _, itemTable in ipairs(dataResults['items']) do
							for index, item in ipairs(itemTable) do
								local itemTest = (type(item) == 'number' and Item:CreateFromItemID(item) or (item:match("|Hitem:(%d+):") and Item:CreateFromItemLink(item) or nil))
								if(itemTest) then itemTest:ContinueOnItemLoad(function() itemTable[index] = itemTest:GetItemLink() end);
								end
							end
						end
					end
				end
								
				local foundInfo = dataResults['found'] or {};
				
				if(PA_SavedSettings[locationDataLink..'ChatChecked']) then
					if(foundInfo['node'] ~= nil) then
						for count, item in ipairs(foundInfo['node']) do
							local itemTest = (type(item) == 'number' and Item:CreateFromItemID(item) or (item:match("|Hitem:(%d+):") and Item:CreateFromItemLink(item) or nil))
							if(itemTest) then itemTest:ContinueOnItemLoad(function() foundInfo['node'][count] = itemTest:GetItemLink(); end); end;
						end
					end;
				end;
				
				C_Timer.After(0, function()
					drawFunction(
						self,
						(expansionIcon[expacID] == nil and '' or expansionIcon[expacID]..' '),
						dataResults,
						typeInfo[dataType],
						PA_SavedSettings[dataLink..'Checked'] and PA_SavedSettings[dataLink..'ChatChecked'],
						PA_SavedSettings[locationDataLink..'ChatChecked'],
						PA_SavedSettings[dataLink .. 'IconChecked']
					);
					self:Show()
				end)
			else
				drawFunction(
					self,
					(expansionIcon[expacID] == nil and '' or expansionIcon[expacID]..' '),
					dataResults,
					typeInfo[dataType],
					PA_SavedSettings[dataLink..'Checked'] and ((not PA_SavedSettings[dataLink..'Key']) and true or IsShiftKeyDown()),
					PA_SavedSettings[locationDataLink..'Checked'] and ((not PA_SavedSettings[locationDataLink..'Key']) and true or IsShiftKeyDown()),
					PA_SavedSettings[dataLink..'IconChecked'] and ((not PA_SavedSettings[locationDataLink..'Key']) and true or IsShiftKeyDown())
				); end;
		end;
	end;
end;

if isClassic then
	for _, obj in next, {
		GameTooltip,
		ShoppingTooltip1,
		ShoppingTooltip2,
		ShoppingTooltip3,
		ItemRefTooltip
	} do
		obj:HookScript('OnTooltipSetItem', TooltipItem)
	end
else
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, TooltipItem)
end
