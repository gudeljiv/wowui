-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local ADDON_NAME, private = ...

-- RareScanner libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSGeneralDB = private.ImportLib("RareScannerGeneralDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")
local RSMapDB =  private.ImportLib("RareScannerMapDB")

-- RareScanner service libraries
local RSMinimap = private.ImportLib("RareScannerMinimap")
local RSProvider = private.ImportLib("RareScannerProvider")

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

RSWorldMapButtonMixin = CreateFromMixins(WowStyle2IconButtonMixin);

function RSWorldMapButtonMixin:OnLoad()

end

function RSWorldMapButtonMixin:OnShow()
	self:SetupMenu();
end

function RSWorldMapButtonMixin:OnMenuResponse(menu, description)
	self:NotifyUpdate(description);
end

function RSWorldMapButtonMixin:NotifyUpdate(description)
	RSMinimap.RefreshAllData(true)
	RSProvider.RefreshAllDataProviders()
end

function RSWorldMapButtonMixin:OnMouseDown(button)
    self.Icon:SetPoint('TOPLEFT', self, "TOPLEFT", 6, -6.5)
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
end

function RSWorldMapButtonMixin:OnMouseUp()
	self.Icon:SetPoint('TOPLEFT', 6.5, -6)
end

function RSWorldMapButtonMixin:OnEnter()
    GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
    GameTooltip_SetTitle(GameTooltip, "RareScanner")
    GameTooltip:Show()
end

function RSWorldMapButtonMixin:Refresh()
    self:SetupMenu()
end

function RSWorldMapButtonMixin:SetupMenu()
	if (self.mapID and self.mapID == WorldMapFrame:GetMapID()) then
		return
	end
	
	DropdownButtonMixin.SetupMenu(self, function(dropdown, rootDescription)
		rootDescription:SetTag("MENU_WORLD_MAP_RARESCANNER");

		local mapID = WorldMapFrame:GetMapID();

		-- Rare NPCs
		local npcsSubmenu =	rootDescription:CreateButton("|T"..RSConstants.NORMAL_NPC_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_RARE_NPCS"]);		
    	npcsSubmenu:CreateTitle(AL["MAP_MENU_SHOW"])
		npcsSubmenu:CreateCheckbox(AL["MAP_MENU_SHOW_RARE_NPCS"], function() return RSConfigDB.IsShowingNpcs() end, 
			function()
				if (RSConfigDB.IsShowingNpcs()) then
					RSConfigDB.SetShowingNpcs(false)
				else
					RSConfigDB.SetShowingNpcs(true)
				end
			end)
			
		-- Show Rare NPCs
    	local npcsLastSeen = npcsSubmenu:CreateCheckbox("|T"..RSConstants.NORMAL_NPC_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_DISABLE_LAST_SEEN_FILTER"], 
    		function() return not RSConfigDB.IsMaxSeenTimeFilterEnabled() end, 
			function()
				if (RSConfigDB.IsMaxSeenTimeFilterEnabled()) then
					RSConfigDB.DisableMaxSeenTimeFilter()
				else
					RSConfigDB.EnableMaxSeenTimeFilter()
				end
			end)
		npcsLastSeen:SetEnabled(function() return RSConfigDB.IsShowingNpcs() end)
		
    	local npcsNotDiscovered = npcsSubmenu:CreateCheckbox("|T"..RSConstants.RED_NPC_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_SHOW_NOT_DISCOVERED_RARE_NPCS"], 
    		function() return RSConfigDB.IsShowingNotDiscoveredNpcs() end, 
			function()
				if (RSConfigDB.IsShowingNotDiscoveredNpcs()) then
					RSConfigDB.SetShowingNotDiscoveredNpcs(false)
				else
					RSConfigDB.SetShowingNotDiscoveredNpcs(true)
				end
			end)
		npcsNotDiscovered:SetEnabled(function() return RSConfigDB.IsShowingNpcs() end)
		
    	local npcsFriendly = npcsSubmenu:CreateCheckbox("|T"..RSConstants.LIGHT_BLUE_NPC_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_SHOW_FRIENDLY_RARE_NPCS"], 
    		function() return RSConfigDB.IsShowingFriendlyNpcs() end, 
			function()
				if (RSConfigDB.IsShowingFriendlyNpcs()) then
					RSConfigDB.SetShowingFriendlyNpcs(false)
				else
					RSConfigDB.SetShowingFriendlyNpcs(true)
				end
			end)
		npcsFriendly:SetEnabled(function() return RSConfigDB.IsShowingNpcs() end)
	    
		local groups = RSNpcDB.GetCustomGroupsByMapID(mapID)
	    if (RSUtils.GetTableLength(groups) > 0) then
			for _, group in ipairs(groups) do
		    	local npcsGroup = npcsSubmenu:CreateCheckbox("|T"..RSConstants.PURPLE_NPC_TEXTURE..":18:18:::::0:32:0:32|t "..string.format(AL["MAP_MENU_SHOW_CUSTOM_NPC_GROUP"], RSNpcDB.GetCustomNpcGroupByKey(group)), 
		    		function() return not RSConfigDB.IsCustomNpcGroupFiltered(group) end, 
					function()
						if (RSConfigDB.IsCustomNpcGroupFiltered(group)) then
							RSConfigDB.SetCustomNpcGroupFiltered(group, false)
						else
							RSConfigDB.SetCustomNpcGroupFiltered(group, true)
						end
					end)
				npcsGroup:SetEnabled(function() return RSConfigDB.IsShowingNpcs() end)
			end
		end
		
		-- Filter NPCs		
		local npcIDsWithNames = RSNpcDB.GetActiveNpcIDsWithNamesByMapID(mapID, false)
		if (RSUtils.GetTableLength(npcIDsWithNames) > 0) then
			npcsSubmenu:CreateDivider()
			npcsSubmenu:CreateTitle(AL["MAP_MENU_FILTER"])
		
	    	local npcsFilterSubmenu = npcsSubmenu:CreateButton(AL["MAP_MENU_FILTER_NPCS"])
			npcsFilterSubmenu:SetScrollMode(500)
			npcsFilterSubmenu:CreateTitle(AL["MAP_MENU_FILTER_DESELECT"])
			
			-- Select/deselect all
			local npcDesSel = npcsFilterSubmenu:CreateButton(AL["MAP_MENU_FILTER_ALL"])
			npcDesSel:SetResponder(function(data, menuInputData, menu)
	    		local anySelected = true
    			for npcID, _ in pairs (npcIDsWithNames) do
    				if (not RSConfigDB.GetNpcFiltered(npcID)) then
    					anySelected = false
    					break
    				end
    			end
    			
    			if (anySelected) then
    				for npcID, _ in pairs (npcIDsWithNames) do
	    				RSConfigDB.DeleteNpcFiltered(npcID)
	    			end
    			else
    				for npcID, _ in pairs (npcIDsWithNames) do
	    				RSConfigDB.SetNpcFiltered(npcID)
	    			end
    			end
    
				return MenuResponse.Refresh;
			end)
			
			-- Select/deselect by group
		    if (RSUtils.GetTableLength(groups) > 0) then
				for _, group in ipairs(groups) do
			    	local npcDesSelGroup = npcsFilterSubmenu:CreateButton(string.format(AL["MAP_MENU_FILTER_ALL_GROUP"], RSNpcDB.GetCustomNpcGroupByKey(group))) 
			    	npcDesSelGroup:SetResponder(function(data, menuInputData, menu)
			    		local anySelected = true
		    			for npcID, _ in pairs (npcIDsWithNames) do
		    				if (RSNpcDB.IsCustomNpcInGroup(npcID, group) and not RSConfigDB.GetNpcFiltered(npcID)) then
		    					anySelected = false
		    					break
		    				end
		    			end
		    			
		    			if (anySelected) then
		    				for npcID, _ in pairs (npcIDsWithNames) do
		    					if (RSNpcDB.IsCustomNpcInGroup(npcID, group)) then
			    					RSConfigDB.DeleteNpcFiltered(npcID)
			    				end
			    			end
		    			else
		    				for npcID, _ in pairs (npcIDsWithNames) do
		    					if (RSNpcDB.IsCustomNpcInGroup(npcID, group)) then
			    					RSConfigDB.SetNpcFiltered(npcID)
			    				end
			    			end
		    			end
		    
						return MenuResponse.Refresh;
					end)
				end
			end
	
			for _, npcID in ipairs (RSUtils.GetSortedKeysByValue(npcIDsWithNames, function(a, b) return a < b end)) do
				local npcName = npcIDsWithNames[npcID]
				local text
				if (RSNpcDB.IsInternalNpcFriendly(npcID)) then
					text = "|T"..RSConstants.LIGHT_BLUE_NPC_TEXTURE..":18:18:::::0:32:0:32|t "
				elseif (RSGeneralDB.GetAlreadyFoundEntity(npcID)) then
					text = "|T"..RSConstants.NORMAL_NPC_TEXTURE..":18:18:::::0:32:0:32|t "
				else
					text = "|T"..RSConstants.RED_NPC_TEXTURE..":18:18:::::0:32:0:32|t "
				end
				
				text = text..npcName
				
				local npcFilter = npcsFilterSubmenu:CreateCheckbox(text, 
		    		function() return RSConfigDB.GetNpcFiltered(npcID) == nil end, 
					function()
						if (RSConfigDB.GetNpcFiltered(npcID)) then
							RSConfigDB.DeleteNpcFiltered(npcID)
						else
							RSConfigDB.SetNpcFiltered(npcID)
						end
					end)
				npcFilter:SetEnabled(function() 
					local npcInfo = RSNpcDB.GetInternalNpcInfo(npcID)
					if (npcInfo and npcInfo.warbandQuestID and RSConfigDB.IsWeeklyRepNpcFilterEnabled()) then
						for _, questID in ipairs(npcInfo.warbandQuestID) do
							if (C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID)) then
								return false
							end
						end
					end
					
					return true				
				end)
			end
		end
		
		-- Containers
	    local containersSubmenu = rootDescription:CreateButton("|TInterface\\AddOns\\RareScanner\\Media\\Icons\\OriginalChest:18:18:::::0:32:0:32|t "..AL["MAP_MENU_CONTAINERS"])
    	containersSubmenu:CreateTitle(AL["MAP_MENU_SHOW"])
    	containersSubmenu:CreateCheckbox(AL["MAP_MENU_SHOW_CONTAINERS"], function() return RSConfigDB.IsShowingContainers() end, 
			function()
				if (RSConfigDB.IsShowingContainers()) then
					RSConfigDB.SetShowingContainers(false)
				else
					RSConfigDB.SetShowingContainers(true)
				end
			end)
			
		-- Show Containers
    	local containersLastSeen = containersSubmenu:CreateCheckbox("|TInterface\\AddOns\\RareScanner\\Media\\Icons\\OriginalChest:18:18:::::0:32:0:32|t "..AL["MAP_MENU_DISABLE_LAST_SEEN_CONTAINER_FILTER"], 
    		function() return not RSConfigDB.IsMaxSeenTimeContainerFilterEnabled() end, 
			function()
				if (RSConfigDB.IsMaxSeenTimeContainerFilterEnabled()) then
					RSConfigDB.DisableMaxSeenContainerTimeFilter()
				else
					RSConfigDB.EnableMaxSeenContainerTimeFilter()
				end
			end)
		containersLastSeen:SetEnabled(function() return RSConfigDB.IsShowingContainers() end)

    	local containersNotDiscovered = containersSubmenu:CreateCheckbox("|T"..RSConstants.RED_CONTAINER_TEXTURE..":18:18:::::0:32:0:32|t "..AL["MAP_MENU_SHOW_NOT_DISCOVERED_CONTAINERS"], 
    		function() return RSConfigDB.IsShowingNotDiscoveredContainers() end, 
			function()
				if (RSConfigDB.IsShowingNotDiscoveredContainers()) then
					RSConfigDB.SetShowingNotDiscoveredContainers(false)
				else
					RSConfigDB.SetShowingNotDiscoveredContainers(true)
				end
			end)
		containersNotDiscovered:SetEnabled(function() return RSConfigDB.IsShowingContainers() end)
		
		containersSubmenu:CreateDivider()

		-- Filter Containers
		local containerIDsWithNames = RSContainerDB.GetActiveContainerIDsWithNamesByMapID(mapID)
		if (RSUtils.GetTableLength(containerIDsWithNames) > 0) then
			containersSubmenu:CreateDivider()
			containersSubmenu:CreateTitle(AL["MAP_MENU_FILTER"])
			
	    	local containersFilterSubmenu = containersSubmenu:CreateButton(AL["MAP_MENU_FILTER_CONTAINERS"])
			containersFilterSubmenu:SetScrollMode(500)
			containersFilterSubmenu:CreateTitle(AL["MAP_MENU_FILTER_DESELECT"])
			
			local containerDesSel = containersFilterSubmenu:CreateButton(AL["MAP_MENU_FILTER_ALL"])
			containerDesSel:SetResponder(function(data, menuInputData, menu)
	    		local anySelected = true
    			for containerID, _ in pairs (containerIDsWithNames) do
    				if (not RSConfigDB.GetContainerFiltered(containerID)) then
    					anySelected = false
    					break
    				end
    			end
    			
    			if (anySelected) then
    				for containerID, _ in pairs (containerIDsWithNames) do
	    				RSConfigDB.DeleteContainerFiltered(containerID)
	    			end
    			else
    				for containerID, _ in pairs (containerIDsWithNames) do
	    				RSConfigDB.SetContainerFiltered(containerID)
	    			end
    			end
    
				return MenuResponse.Refresh;
			end)
	
			for _, containerID in ipairs (RSUtils.GetSortedKeysByValue(containerIDsWithNames, function(a, b) return a < b end)) do
				local containerName = containerIDsWithNames[containerID]
				local text
				if (RSContainerDB.IsContainerOpened(containerID)) then
					text = "|T"..RSConstants.BLUE_CONTAINER_TEXTURE..":18:18:::::0:32:0:32|t "
				elseif (RSGeneralDB.GetAlreadyFoundEntity(containerID)) then
					text = "|T"..RSConstants.NORMAL_CONTAINER_TEXTURE..":18:18:::::0:32:0:32|t "
				else
					text = "|T"..RSConstants.RED_CONTAINER_TEXTURE..":18:18:::::0:32:0:32|t "
				end
				
				text = text..containerName
				
				local containerFilter = containersFilterSubmenu:CreateCheckbox(text, 
		    		function() return RSConfigDB.GetContainerFiltered(containerID) == nil end, 
					function()
						if (RSConfigDB.GetContainerFiltered(containerID)) then
							RSConfigDB.DeleteContainerFiltered(containerID)
						else
							RSConfigDB.SetContainerFiltered(containerID)
						end
					end)
			end
		end
			
		-- Not discovered old expansions
	 	rootDescription:CreateCheckbox(AL["MAP_MENU_SHOW_NOT_DISCOVERED_OLD"], 
	    	function() return RSConfigDB.IsShowingOldNotDiscoveredMapIcons() end,
	    	function() 
	    		if (RSConfigDB.IsShowingOldNotDiscoveredMapIcons()) then
					RSConfigDB.SetShowingOldNotDiscoveredMapIcons(false)
				else
					RSConfigDB.SetShowingOldNotDiscoveredMapIcons(true)
				end
			end)
			
		-- Filter zone
		local mapIDsWithNames = RSMapDB.GetActiveMapIDsWithNamesByMapID(mapID)
		if (RSUtils.GetTableLength(mapIDsWithNames) > 0) then
			rootDescription:CreateDivider()
			rootDescription:CreateTitle(AL["MAP_MENU_FILTER"])
			
	    	local mapsFilterSubmenu = rootDescription:CreateButton(AL["MAP_MENU_FILTER_MAPS"])
			mapsFilterSubmenu:SetScrollMode(500)
			mapsFilterSubmenu:CreateTitle(AL["MAP_MENU_FILTER_DESELECT"])
			
			local mapDesSel = mapsFilterSubmenu:CreateButton(AL["MAP_MENU_FILTER_ALL"])
			mapDesSel:SetResponder(function(data, menuInputData, menu)
	    		local anySelected = true
    			for mapID, _ in pairs (mapIDsWithNames) do
    				if (not RSConfigDB.GetZoneFiltered(mapID)) then
    					anySelected = false
    					break
    				end
    			end
    			
    			if (anySelected) then
    				for mapID, _ in pairs (mapIDsWithNames) do
	    				RSConfigDB.DeleteZoneFiltered(mapID)
	    			end
    			else
    				for mapID, _ in pairs (mapIDsWithNames) do
	    				RSConfigDB.SetZoneFiltered(mapID)
	    			end
    			end
    
				return MenuResponse.Refresh;
			end)
	
			for _, mapID in ipairs (RSUtils.GetSortedKeysByValue(mapIDsWithNames, function(a, b) return a < b end)) do
				local mapName = mapIDsWithNames[mapID]
				local eventFilter = mapsFilterSubmenu:CreateCheckbox(mapName, 
		    		function() return RSConfigDB.GetZoneFiltered(mapID) == nil end, 
					function()
						if (RSConfigDB.GetZoneFiltered(mapID)) then
							RSConfigDB.DeleteZoneFiltered(mapID)
						else
							RSConfigDB.SetZoneFiltered(mapID)
						end
					end)
			end
		end
	end);
	
	-- Avoids reconstructing if no changes
	self.mapID = WorldMapFrame:GetMapID()
end