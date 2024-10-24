-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

local RSConfigDB = private.NewLib("RareScannerConfigDB")


-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner database libraries
local RSNpcDB = private.ImportLib("RareScannerNpcDB")
local RSContainerDB = private.ImportLib("RareScannerContainerDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")
local RSLogger = private.ImportLib("RareScannerLogger")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSRoutines = private.ImportLib("RareScannerRoutines")

---============================================================================
-- Timers options
---============================================================================

function RSConfigDB.GetRescanTimer()
	return private.db.general.rescanTimer
end

function RSConfigDB.SetRescanTimer(value)
	private.db.general.rescanTimer = value
end

function RSConfigDB.GetAutoHideButtonTime()
	return private.db.display.autoHideButton
end

function RSConfigDB.SetAutoHideButtonTime(value)
	private.db.display.autoHideButton = value
end

---============================================================================
-- Appearence options
---============================================================================

function RSConfigDB.GetButtonScale()
	return private.db.display.scale
end

function RSConfigDB.SetButtonScale(value)
	private.db.display.scale = value
end

function RSConfigDB.GetMarkerOnTarget()
	return private.db.general.marker
end

function RSConfigDB.SetMarkerOnTarget(value)
	private.db.general.marker = value
end

function RSConfigDB.IsLockingPosition()
	return private.db.display.lockPosition
end

function RSConfigDB.SetLockingPosition(value)
	private.db.display.lockPosition = value
end

function RSConfigDB.GetClickKeybinding()
	return private.db.display.clickkeybinding
end

function RSConfigDB.SetClickKeybinding(value)
	private.db.display.clickkeybinding = value
end

function RSConfigDB.GetHideKeybinding()
	return private.db.display.hidekeybinding
end

function RSConfigDB.SetHideKeybinding(value)
	private.db.display.hidekeybinding = value
end

---============================================================================
-- Sound options database
---============================================================================

function RSConfigDB.GetCustomSoundsFolder()
	return private.db.sound.soundCustomFolder
end

function RSConfigDB.SetCustomSoundsFolder(value)
	private.db.sound.soundCustomFolder = value
end

function RSConfigDB.AddCustomSound(name,file)
	if (not private.db.sound.custom) then
		private.db.sound.custom = {}
	end
	
	if (file) then
		private.db.sound.custom[name] = file
	end
end

function RSConfigDB.GetCustomSound(name)
	if (private.db.sound.custom and name and private.db.sound.custom[name]) then
		return private.db.sound.custom[name]
	end
	
	return nil
end

function RSConfigDB.GetCustomSounds()
	return private.db.sound.custom
end

function RSConfigDB.DeleteCustomSound(name)
	if (private.db.sound.custom and name and private.db.sound.custom[name]) then
		private.db.sound.custom[name] = nil
	
		-- Checks if selected audios match with the deleted, in that case restores default values
		if (RSConfigDB.GetSoundPlayedWithObjects() == name) then
			RSConfigDB.SetSoundPlayedWithObjects("PVP Horde")
		end
		if (RSConfigDB.GetSoundPlayedWithNpcs() == name) then
			RSConfigDB.SetSoundPlayedWithNpcs("Horn")
		end
	end
end

function RSConfigDB.IsPlayingSound()
	return private.db.sound.soundDisabled
end

function RSConfigDB.SetPlayingSound(value)
	private.db.sound.soundDisabled = value
end

function RSConfigDB.IsPlayingObjectsSound()
	return private.db.sound.soundObjectDisabled
end

function RSConfigDB.SetPlayingObjectsSound(value)
	private.db.sound.soundObjectDisabled = value
end

function RSConfigDB.GetSoundPlayedWithObjects()
	return private.db.sound.soundObjectPlayed
end

function RSConfigDB.SetSoundPlayedWithObjects(value)
	private.db.sound.soundObjectPlayed = value
end

function RSConfigDB.GetSoundPlayedWithNpcs()
	return private.db.sound.soundPlayed
end

function RSConfigDB.SetSoundPlayedWithNpcs(value)
	private.db.sound.soundPlayed = value
end

function RSConfigDB.GetSoundVolume()
	return private.db.sound.soundVolume
end

function RSConfigDB.SetSoundVolume(value)
	private.db.sound.soundVolume = value
end

function RSConfigDB.GetSoundChannel()
	return private.db.sound.soundChannel
end

function RSConfigDB.SetSoundChannel(value)
	private.db.sound.soundChannel = value
end

---============================================================================
-- Display options database
---============================================================================

function RSConfigDB.IsButtonDisplaying()
	return private.db.display.displayButton
end

function RSConfigDB.SetButtonDisplaying(value)
	private.db.display.displayButton = value
end

function RSConfigDB.IsButtonDisplayingForContainers()
	return private.db.display.displayButtonContainers
end

function RSConfigDB.SetButtonDisplayingForContainers(value)
	private.db.display.displayButtonContainers = value
end

function RSConfigDB.IsDisplayingNavigationArrows()
	return private.db.display.enableNavigation
end

function RSConfigDB.SetDisplayingNavigationArrows(value)
	private.db.display.enableNavigation = value
end

function RSConfigDB.IsDisplayingRaidWarning()
	return private.db.display.displayRaidWarning
end

function RSConfigDB.SetDisplayingRaidWarning(value)
	private.db.display.displayRaidWarning = value
end

function RSConfigDB.IsDisplayingChatMessages()
	return private.db.display.displayChatMessage
end

function RSConfigDB.SetDisplayingChatMessages(value)
	private.db.display.displayChatMessage = value
end

function RSConfigDB.GetChatWindowName()
	return private.db.display.chatWindowName
end

function RSConfigDB.SetChatWindowName(value)
	private.db.display.chatWindowName = value
end

function RSConfigDB.IsDisplayingTimestampChatMessages()
	return private.db.display.displayTimestampChatMessage
end

function RSConfigDB.SetDisplayingTimestampChatMessages(value)
	private.db.display.displayTimestampChatMessage = value
end

function RSConfigDB.IsDisplayingLootBar()
	return private.db.loot.displayLoot
end

function RSConfigDB.SetDisplayingLootBar(value)
	private.db.loot.displayLoot = value
end

function RSConfigDB.IsDisplayingMarkerOnTarget()
	return private.db.general.showMaker
end

function RSConfigDB.SetDisplayingMarkerOnTarget(value)
	private.db.general.showMaker = value
end

function RSConfigDB.IsDisplayingModel()
	return private.db.display.displayMiniature
end

function RSConfigDB.SetDisplayingModel(value)
	private.db.display.displayMiniature = value
end

---============================================================================
-- Scanner filters database
---============================================================================

function RSConfigDB.IsScanningInInstances()
	return private.db.general.scanInstances
end

function RSConfigDB.SetScanningInInstance(value)
	private.db.general.scanInstances = value
end

function RSConfigDB.IsScanningWhileOnTaxi()
	return private.db.general.scanOnTaxi
end

function RSConfigDB.SetScanningWhileOnTaxi(value)
	private.db.general.scanOnTaxi = value
end

function RSConfigDB.IsScanningForNpcs()
	return private.db.general.scanRares
end

function RSConfigDB.SetScanningForNpcs(value)
	private.db.general.scanRares = value
end

function RSConfigDB.IsScanningForContainers()
	return private.db.general.scanContainers
end

function RSConfigDB.SetScanningForContainers(value)
	private.db.general.scanContainers = value
end

function RSConfigDB.IsScanningChatAlerts()
	return private.db.general.scanChatAlerts
end

function RSConfigDB.SetScanningChatAlerts(value)
	private.db.general.scanChatAlerts = value
end

function RSConfigDB.IsScanningTargetUnit()
	return private.db.general.scanTargetUnit
end

function RSConfigDB.SetScanningTargetUnit(value)
	private.db.general.scanTargetUnit = value
end

---============================================================================
-- Not discovered filters database
---============================================================================

function RSConfigDB.IsShowingOldNotDiscoveredMapIcons()
	return private.db.map.displayOldNotDiscoveredMapIcons
end

function RSConfigDB.SetShowingOldNotDiscoveredMapIcons(value)
	private.db.map.displayOldNotDiscoveredMapIcons = value
end

---============================================================================
-- NPC filters database
---============================================================================

function RSConfigDB.IsShowingNpcs()
	return private.db.map.displayNpcIcons
end

function RSConfigDB.SetShowingNpcs(value)
	private.db.map.displayNpcIcons = value
end

function RSConfigDB.IsNpcFiltered(npcID)
	local filterType = RSConfigDB.GetNpcFiltered(npcID)
	if (filterType and filterType == RSConstants.ENTITY_FILTER_ALL) then
		return true
	end
	
	return false
end

function RSConfigDB.IsNpcFilteredOnlyWorldmap(npcID)
	local filterType = RSConfigDB.GetNpcFiltered(npcID)
	if (filterType and filterType == RSConstants.ENTITY_FILTER_WORLDMAP) then
		return true
	end
	
	return false
end

function RSConfigDB.IsNpcFilteredOnlyAlerts(npcID)
	local filterType = RSConfigDB.GetNpcFiltered(npcID)
	if (filterType and filterType == RSConstants.ENTITY_FILTER_ALERTS) then
		return true
	end
	
	return false
end

function RSConfigDB.GetNpcFiltered(npcID)
	if (npcID and private.db.rareFilters.filteredNpcs and private.db.rareFilters.filteredNpcs[npcID]) then
		return private.db.rareFilters.filteredNpcs[npcID]
	end
	
	return nil
end

function RSConfigDB.SetNpcFiltered(npcID, filterType)
	--RSLogger:PrintDebugMessage(string.format("RSConfigDB.SetNpcFiltered [%s][%s]", npcID, filterType or ""))
	if (not private.db.rareFilters.filteredNpcs) then
		private.db.rareFilters.filteredNpcs = {}
	end
	
	if (npcID) then
		if (filterType) then
			private.db.rareFilters.filteredNpcs[npcID] = filterType
		else
			private.db.rareFilters.filteredNpcs[npcID] = RSConfigDB.GetDefaultNpcFilter()
		end
	end
end

function RSConfigDB.DeleteNpcFiltered(npcID)
	--RSLogger:PrintDebugMessage(string.format("RSConfigDB.DeleteNpcFiltered [%s]", npcID))
	if (npcID and private.db.rareFilters.filteredNpcs and private.db.rareFilters.filteredNpcs[npcID]) then
		private.db.rareFilters.filteredNpcs[npcID] = nil
	end
	
	if (RSUtils.GetTableLength(private.db.rareFilters.filteredNpcs) == 0) then
		private.db.rareFilters.filteredNpcs = nil
	end
end

function RSConfigDB.SetDefaultNpcFilter(filterType)
	if (filterType) then
		private.db.rareFilters.defaultNpcFilterType = filterType
	end
end

function RSConfigDB.GetDefaultNpcFilter()
	return private.db.rareFilters.defaultNpcFilterType
end

function RSConfigDB.FilterAllNpcs(routines, routineTextOutput)
	local filterAllNpcsRoutine = RSRoutines.LoopRoutineNew()
	filterAllNpcsRoutine:Init(RSNpcDB.GetAllInternalNpcInfo, 500, 
		function(context, npcID, _)
			RSConfigDB.SetNpcFiltered(npcID)
		end,
		function(context)
			RSLogger:PrintDebugMessage("FilterAllNpcs. Filtrados todos los NPCs")
			
			if (routineTextOutput) then
				routineTextOutput:SetText(AL["EXPLORER_FILTERING_NPCS"])
			end
		end
	)
	table.insert(routines, filterAllNpcsRoutine)
end

function RSConfigDB.IsShowingFriendlyNpcs()
	return private.db.map.displayFriendlyNpcIcons
end

function RSConfigDB.SetShowingFriendlyNpcs(value)
	private.db.map.displayFriendlyNpcIcons = value
end

function RSConfigDB.IsShowingNotDiscoveredNpcs()
	return private.db.map.displayNotDiscoveredNpcIcons
end

function RSConfigDB.SetShowingNotDiscoveredNpcs(value)
	private.db.map.displayNotDiscoveredNpcIcons = value
end

function RSConfigDB.IsMaxSeenTimeFilterEnabled()
	return private.db.map.maxSeenTime ~= 0
end

function RSConfigDB.EnableMaxSeenTimeFilter()
	-- If while disabled they setted the time through the options panel
	if (RSConfigDB.GetMaxSeenTimeFilter() > 0) then
		RSLogger:PrintDebugMessage(string.format("EnableMaxSeenTimeFilter [maxSeenTime = %s]", RSConfigDB.GetMaxSeenTimeFilter()))
		return;
	end

	if (private.db.map.maxSeenTimeBak and private.db.map.maxSeenTimeBak > 0) then
		RSConfigDB.SetMaxSeenTimeFilter(private.db.map.maxSeenTimeBak)
		-- Its possible that they enabled it though the options panel
	else
		RSConfigDB.SetMaxSeenTimeFilter(5, false)
	end
	RSLogger:PrintDebugMessage(string.format("EnableMaxSeenTimeFilter [maxSeenTime = %s]", RSConfigDB.GetMaxSeenTimeFilter()))
end

function RSConfigDB.DisableMaxSeenTimeFilter()
	private.db.map.maxSeenTimeBak = RSConfigDB.GetMaxSeenTimeFilter()
	RSConfigDB.SetMaxSeenTimeFilter(0, false)
	RSLogger:PrintDebugMessage(string.format("DisableMaxSeenTimeFilter [maxSeenTime = %s]", RSConfigDB.GetMaxSeenTimeFilter()))
end

function RSConfigDB.GetMaxSeenTimeFilter()
	return private.db.map.maxSeenTime
end

function RSConfigDB.SetMaxSeenTimeFilter(value, clearBak)
	private.db.map.maxSeenTime = value
	RSLogger:PrintDebugMessage(string.format("SetMaxSeenTimeFilter [maxSeenTime = %s]", value))
	if (clearBak) then
		private.db.map.maxSeenTimeBak = nil
	end
end

function RSConfigDB.IsCustomNpcGroupFiltered(group)
	if (group and private.db.map.displayCustomGroupNpcIcons[group]) then
		return private.db.map.displayCustomGroupNpcIcons[group]
	end

	return false
end

function RSConfigDB.SetCustomNpcGroupFiltered(group, filtered)
	if (group) then
		private.db.map.displayCustomGroupNpcIcons[group] = filtered
	end
end

---============================================================================
-- Container filters database
---============================================================================

function RSConfigDB.IsShowingContainers()
	return private.db.map.displayContainerIcons
end

function RSConfigDB.SetShowingContainers(value)
	private.db.map.displayContainerIcons = value
end

function RSConfigDB.IsContainerFiltered(containerID)
	local filterType = RSConfigDB.GetContainerFiltered(containerID)
	if (filterType and filterType == RSConstants.ENTITY_FILTER_ALL) then
		return true
	end
	
	return false
end

function RSConfigDB.IsContainerFilteredOnlyWorldmap(containerID)
	local filterType = RSConfigDB.GetContainerFiltered(containerID)
	if (filterType and filterType == RSConstants.ENTITY_FILTER_WORLDMAP) then
		return true
	end
	
	return false
end

function RSConfigDB.IsContainerFilteredOnlyAlerts(containerID)
	local filterType = RSConfigDB.GetContainerFiltered(containerID)
	if (filterType and filterType == RSConstants.ENTITY_FILTER_ALERTS) then
		return true
	end
	
	return false
end

function RSConfigDB.GetContainerFiltered(containerID)
	if (containerID and private.db.containerFilters.filteredContainers and private.db.containerFilters.filteredContainers[containerID]) then
		return private.db.containerFilters.filteredContainers[containerID]
	end
	
	return nil
end

function RSConfigDB.SetContainerFiltered(containerID, filterType)
	--RSLogger:PrintDebugMessage(string.format("RSConfigDB.SetContainerFiltered [%s][%s]", containerID, filterType or ""))
	if (not private.db.containerFilters.filteredContainers) then
		private.db.containerFilters.filteredContainers = {}
	end
	
	if (containerID) then
		if (filterType) then
			private.db.containerFilters.filteredContainers[containerID] = filterType
		else
			private.db.containerFilters.filteredContainers[containerID] = RSConfigDB.GetDefaultContainerFilter()
		end
	end
end

function RSConfigDB.DeleteContainerFiltered(containerID)
	--RSLogger:PrintDebugMessage(string.format("RSConfigDB.DeleteContainerFiltered [%s]", containerID))
	if (containerID and private.db.containerFilters.filteredContainers and private.db.containerFilters.filteredContainers[containerID]) then
		private.db.containerFilters.filteredContainers[containerID] = nil
	end
	
	if (RSUtils.GetTableLength(private.db.containerFilters.filteredContainers) == 0) then
		private.db.containerFilters.filteredContainers = nil
	end
end

function RSConfigDB.SetDefaultContainerFilter(filterType)
	if (filterType) then
		private.db.containerFilters.defaultContainerFilterType = filterType
	end
end

function RSConfigDB.GetDefaultContainerFilter()
	return private.db.containerFilters.defaultContainerFilterType
end

function RSConfigDB.FilterAllContainers(routines, routineTextOutput)
	local filterAllContainersRoutine = RSRoutines.LoopRoutineNew()
	filterAllContainersRoutine:Init(RSContainerDB.GetAllInternalContainerInfo, 500, 
		function(context, containerID, _)
			RSConfigDB.SetContainerFiltered(containerID)
		end,
		function(context)
			RSLogger:PrintDebugMessage("FilterAllContainers. Filtrados todos los contenedores")
			
			if (routineTextOutput) then
				routineTextOutput:SetText(AL["EXPLORER_FILTERING_CONTAINERS"])
			end
		end
	)
	table.insert(routines, filterAllContainersRoutine)
end

function RSConfigDB.IsShowingNotDiscoveredContainers()
	return private.db.map.displayNotDiscoveredContainerIcons
end

function RSConfigDB.SetShowingNotDiscoveredContainers(value)
	private.db.map.displayNotDiscoveredContainerIcons = value
end

function RSConfigDB.IsMaxSeenTimeContainerFilterEnabled()
	return private.db.map.maxSeenTimeContainer ~= 0
end

function RSConfigDB.EnableMaxSeenContainerTimeFilter()
	-- If while disabled they setted the time through the options panel
	if (RSConfigDB.GetMaxSeenContainerTimeFilter() > 0) then
		RSLogger:PrintDebugMessage(string.format("EnableMaxSeenContainerTimeFilter [maxSeenTimeContainer = %s]", RSConfigDB.GetMaxSeenContainerTimeFilter()))
		return;
	end

	if (private.db.map.maxSeenContainerTimeBak and private.db.map.maxSeenContainerTimeBak > 0) then
		RSConfigDB.SetMaxSeenContainerTimeFilter(private.db.map.maxSeenContainerTimeBak)
		-- Its possible that they enabled it though the options panel
	else
		RSConfigDB.SetMaxSeenContainerTimeFilter(5, false)
	end
	RSLogger:PrintDebugMessage(string.format("EnableMaxSeenContainerTimeFilter [maxSeenTimeContainer = %s]", RSConfigDB.GetMaxSeenContainerTimeFilter()))
end

function RSConfigDB.DisableMaxSeenContainerTimeFilter()
	private.db.map.maxSeenContainerTimeBak = RSConfigDB.GetMaxSeenContainerTimeFilter()
	RSConfigDB.SetMaxSeenContainerTimeFilter(0, false)
	RSLogger:PrintDebugMessage(string.format("DisableMaxSeenContainerTimeFilter [maxSeenTimeContainer = %s]", RSConfigDB.GetMaxSeenContainerTimeFilter()))
end

function RSConfigDB.GetMaxSeenContainerTimeFilter()
	return private.db.map.maxSeenTimeContainer
end

function RSConfigDB.SetMaxSeenContainerTimeFilter(value, clearBak)
	private.db.map.maxSeenTimeContainer = value
	RSLogger:PrintDebugMessage(string.format("SetMaxSeenContainerTimeFilter [maxSeenTimeContainer = %s]", value))
	if (clearBak) then
		private.db.map.maxSeenContainerTimeBak = nil
	end
end

---============================================================================
-- Zone filters database
---============================================================================

function RSConfigDB.IsZoneFiltered(zoneID)
	local filterType = RSConfigDB.GetZoneFiltered(zoneID)
	if (filterType and filterType == RSConstants.ENTITY_FILTER_ALL) then
		return true
	end
	
	return false
end

function RSConfigDB.IsZoneFilteredOnlyWorldmap(zoneID)
	local filterType = RSConfigDB.GetZoneFiltered(zoneID)
	if (filterType and filterType == RSConstants.ENTITY_FILTER_WORLDMAP) then
		return true
	end
	
	return false
end

function RSConfigDB.IsZoneFilteredOnlyAlerts(zoneID)
	local filterType = RSConfigDB.GetZoneFiltered(zoneID)
	if (filterType and filterType == RSConstants.ENTITY_FILTER_ALERTS) then
		return true
	end
	
	return false
end

function RSConfigDB.IsEntityZoneFilteredOnlyAlerts(entityID, atlasName, mapID)
	if (entityID and atlasName) then
		-- If npc
		if (RSConstants.IsNpcAtlas(atlasName)) then
			local npcInfo = RSNpcDB.GetInternalNpcInfo(entityID)
			if (npcInfo) then
				if (RSNpcDB.IsInternalNpcMultiZone(entityID)) then
					for zoneMapID, _ in pairs (npcInfo.zoneID) do
						if (mapID == zoneMapID and RSConfigDB.GetZoneFiltered(mapID)) then
							return RSConfigDB.IsZoneFilteredOnlyAlerts(mapID)
						end
					end
				elseif (RSNpcDB.IsInternalNpcMonoZone(entityID)) then
					return RSConfigDB.IsZoneFilteredOnlyAlerts(mapID)
				end
			end
		-- If container
		elseif (RSConstants.IsContainerAtlas(atlasName)) then
			local containerInfo = RSContainerDB.GetInternalContainerInfo(entityID)
			if (containerInfo) then
				if (RSContainerDB.IsInternalContainerMultiZone(entityID)) then
					for zoneMapID, _ in pairs (containerInfo.zoneID) do
						if (mapID == zoneMapID and RSConfigDB.GetZoneFiltered(mapID)) then
							return RSConfigDB.IsZoneFilteredOnlyAlerts(mapID)
						end
					end
				elseif (RSContainerDB.IsInternalContainerMonoZone(entityID)) then
					return RSConfigDB.IsZoneFilteredOnlyAlerts(mapID)
				end
			end
		end
	end

	return false
end

function RSConfigDB.GetZoneFiltered(zoneID)
	if (zoneID and private.db.zoneFilters.filteredZones and private.db.zoneFilters.filteredZones[zoneID]) then
		return private.db.zoneFilters.filteredZones[zoneID]
	end
	
	return nil
end

function RSConfigDB.SetZoneFiltered(zoneID, filterType)
	--RSLogger:PrintDebugMessage(string.format("RSConfigDB.SetZoneFiltered [%s][%s]", eventID, filterType or ""))
	if (not private.db.zoneFilters.filteredZones) then
		private.db.zoneFilters.filteredZones = {}
	end
	
	if (zoneID) then
		if (filterType) then
			private.db.zoneFilters.filteredZones[zoneID] = filterType
		else
			private.db.zoneFilters.filteredZones[zoneID] = RSConfigDB.GetDefaultZoneFilter()
		end
	end
end

function RSConfigDB.DeleteZoneFiltered(zoneID)
	--RSLogger:PrintDebugMessage(string.format("RSConfigDB.DeleteZoneFiltered [%s]", zoneID))
	if (zoneID and private.db.zoneFilters.filteredZones and private.db.zoneFilters.filteredZones[zoneID]) then
		private.db.zoneFilters.filteredZones[zoneID] = nil
	end
	
	if (RSUtils.GetTableLength(private.db.zoneFilters.filteredZones) == 0) then
		private.db.zoneFilters.filteredZones = nil
	end
end

function RSConfigDB.SetDefaultZoneFilter(filterType)
	if (filterType) then
		private.db.zoneFilters.defaultZoneFilterType = filterType
	end
end

function RSConfigDB.GetDefaultZoneFilter()
	return private.db.zoneFilters.defaultZoneFilterType
end

---============================================================================
-- Minimap
---============================================================================

function RSConfigDB.IsShowingMinimapIcons()
	return private.db.map.displayMinimapIcons
end

function RSConfigDB.SetShowingMinimapIcons(value)
	private.db.map.displayMinimapIcons = value
end

function RSConfigDB.GetIconsMinimapScale()
	return private.db.map.minimapscale
end

function RSConfigDB.IsShowingMinimapButton()
	return not private.db.display.minimapButton.hide
end

function RSConfigDB.SetShowingMinimapButton(value)
	private.db.display.minimapButton.hide = not value
end

function RSConfigDB.GetMMinimapButtonDB()
	return private.db.display.minimapButton
end

function RSConfigDB.IsShowingWorldmapButton()
	return private.db.display.worldmapButton
end

function RSConfigDB.SetShowingWorldmapButton(value)
	private.db.display.worldmapButton = value
end

---============================================================================
-- Loot in general
---============================================================================

function RSConfigDB.GetMaxNumItemsToShow()
	return private.db.loot.numItems
end

function RSConfigDB.SetMaxNumItemsToShow(value)
	private.db.loot.numItems = value
end

function RSConfigDB.GetNumItemsPerRow()
	return private.db.loot.numItemsPerRow
end

function RSConfigDB.SetNumItemsPerRow(value)
	private.db.loot.numItemsPerRow = value
end

function RSConfigDB:GetLootTooltipPosition()
	return private.db.loot.lootTooltipPosition
end

function RSConfigDB:SetLootTooltipPosition(value)
	private.db.loot.lootTooltipPosition = value
end

---============================================================================
-- Loot filters
---============================================================================

function RSConfigDB.GetItemFiltered(itemID)
	if (itemID) then
		return private.db.loot.filteredItems[itemID]
	end
end

function RSConfigDB.GetAllFilteredItems()
	return private.db.loot.filteredItems
end

function RSConfigDB.SetItemFiltered(itemID, value)
	if (itemID) then
		if (value) then
			private.db.loot.filteredItems[itemID] = true
		else
			private.db.loot.filteredItems[itemID] = nil
		end
	end
end

function RSConfigDB.GetLootFilterMinQuality()
	return private.db.loot.lootMinQuality
end

function RSConfigDB.SetLootFilterMinQuality(value)
	private.db.loot.lootMinQuality = value
end

function RSConfigDB.SetLootFilterByCategory(itemClassID, itemSubClassID, value)
	if (itemClassID and itemSubClassID and private.db.loot.filteredLootCategories[itemClassID]) then
		private.db.loot.filteredLootCategories[itemClassID][itemSubClassID] = value
	end
end

function RSConfigDB.GetLootFilterByCategory(itemClassID, itemSubClassID)
	if (itemClassID and itemSubClassID and private.db.loot.filteredLootCategories[itemClassID]) then
		return private.db.loot.filteredLootCategories[itemClassID][itemSubClassID]
	end

	return nil
end

function RSConfigDB.IsFilteringLootByCompletedQuest()
	return private.db.loot.filterItemsCompletedQuest
end

function RSConfigDB.SetFilteringLootByCompletedQuest(value)
	private.db.loot.filterItemsCompletedQuest = value
end

function RSConfigDB.IsFilteringLootByNotEquipableItems()
	return private.db.loot.filterNotEquipableItems
end

function RSConfigDB.SetFilteringLootByNotEquipableItems(value)
	private.db.loot.filterNotEquipableItems = value
end

function RSConfigDB.IsFilteringLootByNotMatchingClass()
	return private.db.loot.filterNotMatchingClass
end

function RSConfigDB.SetFilteringLootByNotMatchingClass(value)
	private.db.loot.filterNotMatchingClass = value
end

function RSConfigDB.IsFilteringLootByNotMatchingFaction()
	return private.db.loot.filterNotMatchingFaction
end

function RSConfigDB.SetFilteringLootByNotMatchingFaction(value)
	private.db.loot.filterNotMatchingFaction = value
end

function RSConfigDB.ResetLootFilters()
	-- Quality Uncommon and supperior
	RSConfigDB.SetLootFilterMinQuality(Enum.ItemQuality.Poor)
	
	-- Type/Subtype
	for mainTypeID, subtypesIDs in pairs(private.ITEM_CLASSES) do
		for _, typeID in pairs (subtypesIDs) do
			RSConfigDB.SetLootFilterByCategory(mainTypeID, typeID, true)
		end
	end
	
	-- Custom filters
	RSConfigDB.SetFilteringLootByNotMatchingClass(false)
	RSConfigDB.SetFilteringLootByNotMatchingFaction(true)
end

---============================================================================
-- Loot tooltips
---============================================================================

function RSConfigDB.IsShowingLootTooltipsCommands()
	return private.db.loot.tooltipsCommands
end

function RSConfigDB.SetShowingLootTooltipsCommands(value)
	private.db.loot.tooltipsCommands = value
end

---============================================================================
-- Navigator options
---============================================================================

function RSConfigDB.IsNavigationLockEnabled()
	return private.db.display.navigationLockEntity
end

function RSConfigDB.SetNavigationLockEnabled(value)
	private.db.display.navigationLockEntity = value
end

---============================================================================
-- Waypoints
---============================================================================

function RSConfigDB.IsTomtomSupportEnabled()
	return TomTom and private.db.general.enableTomtomSupport
end

function RSConfigDB.SetTomtomSupportEnabled(value)
	private.db.general.enableTomtomSupport = TomTom and value
end

function RSConfigDB.IsAddingTomtomWaypointsAutomatically()
	return TomTom and private.db.general.autoTomtomWaypoints
end

function RSConfigDB.SetAddingTomtomWaypointsAutomatically(value)
	private.db.general.autoTomtomWaypoints = TomTom and value
end

---============================================================================
-- Worldmap waypoints
---============================================================================

function RSConfigDB.IsAddingWorldMapTomtomWaypoints()
	return TomTom and private.db.map.waypointTomtom
end

function RSConfigDB.SetAddingWorldMapTomtomWaypoints(value)
	private.db.map.waypointTomtom = TomTom and value
end

---============================================================================
-- WorldMap icons scale
---============================================================================

function RSConfigDB.GetIconsWorldMapScale()
	return private.db.map.scale
end

function RSConfigDB.SetIconsWorldMapScale(value)
	private.db.map.scale = value
end

---============================================================================
-- Worldmap tooltips
---============================================================================

function RSConfigDB.GetWorldMapTooltipsScale()
	return private.db.map.tooltipsScale
end

function RSConfigDB.SetWorldMapTooltipsScale(value)
	private.db.map.tooltipsScale = value
end

function RSConfigDB.IsShowingTooltipsNotes()
	return private.db.map.tooltipsNotes
end

function RSConfigDB.SetShowingTooltipsNotes(value)
	private.db.map.tooltipsNotes = value
end

function RSConfigDB.IsShowingTooltipsLoot()
	return private.db.map.tooltipsLoot
end

function RSConfigDB.SetShowingTooltipsLoot(value)
	private.db.map.tooltipsLoot = value
end

function RSConfigDB.IsShowingLootOnWorldMap()
	return private.db.loot.displayLootOnMap
end

function RSConfigDB.SetShowingLootOnWorldMap(value)
	private.db.loot.displayLootOnMap = value
end

function RSConfigDB.IsShowingTooltipsSeen()
	return private.db.map.tooltipsSeen
end

function RSConfigDB.SetShowingTooltipsSeen(value)
	private.db.map.tooltipsSeen = value
end

function RSConfigDB.IsShowingTooltipsCommands()
	return private.db.map.tooltipsCommands
end

function RSConfigDB.SetShowingTooltipsCommands(value)
	private.db.map.tooltipsCommands = value
end

function RSConfigDB.IsShowingTooltipsFilterState()
	return private.db.map.tooltipsFilterState
end

function RSConfigDB.SetShowingTooltipsFilterState(value)
	private.db.map.tooltipsFilterState = value
end

---============================================================================
-- Worldmap loot tooltips
---============================================================================

function RSConfigDB.GetWorldMapLootAchievTooltipsScale()
	if (private.db.map.lootAchievTooltipsScale) then
		return private.db.map.lootAchievTooltipsScale
	end
	return RSConfigDB.GetWorldMapTooltipsScale()
end

function RSConfigDB.SetWorldMapLootAchievTooltipsScale(value)
	private.db.map.lootAchievTooltipsScale = value
end

function RSConfigDB.GetWorldMapLootAchievTooltipPosition()
	return private.db.map.lootAchievementsPosition
end 

function RSConfigDB.SetWorldMapLootAchievTooltipPosition(value)
	private.db.map.lootAchievementsPosition = value
end 

---============================================================================
-- Worldmap overlay
---============================================================================

function RSConfigDB.SetWorldMapOverlayColour(id, r, g, b)
	if (not private.db.map["overlayColour"..id]) then
		private.db.map["overlayColour"..id] = {}
	end
	
	private.db.map["overlayColour"..id] = { r, g, b }
end

function RSConfigDB.GetWorldMapOverlayColour(id)
	if (id and private.db.map["overlayColour"..id]) then
		return unpack(private.db.map["overlayColour"..id])
	end
	
	return nil
end

---============================================================================
-- Worldmap animations
---============================================================================

function RSConfigDB.IsShowingAnimationForNpcs()
	return private.db.map.animationNpcs
end

function RSConfigDB.SetShowingAnimationForNpcs(value)
	private.db.map.animationNpcs = value
end

function RSConfigDB.GetAnimationForNpcs()
	return private.db.map.animationNpcsType
end

function RSConfigDB.SetAnimationForNpcs(value)
	private.db.map.animationNpcsType = value
end

function RSConfigDB.IsShowingAnimationForContainers()
	return private.db.map.animationContainers
end

function RSConfigDB.SetShowingAnimationForContainers(value)
	private.db.map.animationContainers = value
end

function RSConfigDB.GetAnimationForContainers()
	return private.db.map.animationContainersType
end

function RSConfigDB.SetAnimationForContainers(value)
	private.db.map.animationContainersType = value
end

---============================================================================
-- Worldmap guidance icons
---============================================================================

function RSConfigDB.IsShowingAutoGuidanceIcons()
	return private.db.map.autoGuidanceIcons
end

function RSConfigDB.SetShowingAutoGuidanceIcons(value)
	private.db.map.autoGuidanceIcons = value
end

---============================================================================
-- Chat waypoints
---============================================================================

function RSConfigDB.IsAddingchatTomtomWaypoints()
	return TomTom and private.db.chat.waypointTomtom
end

function RSConfigDB.SetAddingchatTomtomWaypoints(value)
	private.db.chat.waypointTomtom = TomTom and value
end

function RSConfigDB.GetChatTooltipsScale()
	return private.db.chat.tooltipsScale
end

function RSConfigDB.SetChatTooltipsScale(value)
	private.db.chat.tooltipsScale = value
end

function RSConfigDB.IsShowingChatTooltipsNotes()
	return private.db.chat.tooltipsNotes
end

function RSConfigDB.SetShowingChatTooltipsNotes(value)
	private.db.chat.tooltipsNotes = value
end

function RSConfigDB.IsShowingChatTooltipsSeen()
	return private.db.chat.tooltipsSeen
end

function RSConfigDB.SetShowingChatTooltipsSeen(value)
	private.db.chat.tooltipsSeen = value
end

function RSConfigDB.IsShowingChatTooltipsLoot()
	return private.db.chat.tooltipsLoot
end

function RSConfigDB.SetShowingChatTooltipsLoot(value)
	private.db.chat.tooltipsLoot = value
end

function RSConfigDB.IsShowingChatTooltipsCommands()
	return private.db.chat.tooltipsCommands
end

function RSConfigDB.SetShowingChatTooltipsCommands(value)
	private.db.chat.tooltipsCommands = value
end

function RSConfigDB.GetChatLootAchievTooltipsScale()
	return private.db.chat.tooltipsFilterScale
end

function RSConfigDB.SetChatLootAchievTooltipsScale(value)
	private.db.chat.tooltipsFilterScale = value
end

function RSConfigDB.GetChatLinkColorNpc()
	return private.db.chat.colorNpc
end

function RSConfigDB.SetChatLinkColorNpc(value)
	private.db.chat.colorNpc = value
end

function RSConfigDB.GetChatLinkColorContainer()
	return private.db.chat.colorContainer
end

function RSConfigDB.SetChatLinkColorContainer(value)
	private.db.chat.colorContainer = value
end