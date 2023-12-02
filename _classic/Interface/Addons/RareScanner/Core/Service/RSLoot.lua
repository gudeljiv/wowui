-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local RSLoot = private.NewLib("RareScannerLoot")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")
local RSLootDB = private.ImportLib("RareScannerLootDB")

-- RareScanner general libraries
local RSLogger = private.ImportLib("RareScannerLogger")
local RSConstants = private.ImportLib("RareScannerConstants")
local RSUtils = private.ImportLib("RareScannerUtils")
local RSTooltipScanners = private.ImportLib("RareScannerTooltipScanners")

---============================================================================
-- Filters to apply to the loot displayed under the main button and the worldmap
---============================================================================

local function IsToy(itemLink, itemID)
	if (RSLootDB.IsToy(itemID)) then
		return true
	elseif (RSTooltipScanners.ScanLoot(itemLink, TOY)) then
		RSLootDB.SetItemAsToy(itemID)
		return true
	end
end

local function IsFilteredByCategory(itemLink, itemID, itemClassID, itemSubClassID)
	-- If filtered by category
	if (RSConfigDB.GetLootFilterByCategory(itemClassID, itemSubClassID) == false) then
		-- We ignore toys from this filter because they are scattered all around
		if (IsToy(itemLink, itemID)) then
			return false
		end
		
		return true
	end
	
	return false
end

function RSLoot.IsFiltered(entityID, itemID, itemLink, itemRarity, itemEquipLoc, itemClassID, itemSubClassID)
	-- Category filter
	if (IsFilteredByCategory(itemLink, itemID, itemClassID, itemSubClassID)) then
		RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado por su categoria.", itemID))
		return true
	end
	
	-- Quality filter
	if (itemRarity < tonumber(RSConfigDB.GetLootFilterMinQuality())) then
		RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado por su calidad.", itemID))
		return true
	end
	
	-- Individual filter
	if (RSConfigDB.IsItemFiltered(itemID)) then
		RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado individualmente.", itemID))
		return true
	end

	-- Completed quests
	if (RSConfigDB.IsFilteringLootByCompletedQuest() and (itemClassID == Enum.ItemClass.Questitem or (itemClassID == Enum.ItemClass.Consumable and itemSubClassID == 8))) then --quest item
		local questIDs = RSLootDB.GetAssociatedQuestIDs(itemID)
		if (questIDs) then
			local filtered = false
			for i, questID in ipairs(questIDs) do
				if (C_QuestLog.IsQuestFlaggedCompleted(questID) or not C_TaskQuest.IsActive(questID)) then
					filtered = true
				else
					filtered = false
					break
				end
			end

			if (filtered) then
				RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado por su mision asociada.", itemID))
				return true;
			end
		end
	end

	-- Equipable filter
	if (RSConfigDB.IsFilteringLootByNotEquipableItems() and (itemClassID == Enum.ItemClass.Weapon or itemClassID == Enum.ItemClass.Armor)) then --weapons or armor
		if (not IsEquipable(itemClassID, itemSubClassID, itemEquipLoc)) then
			RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado por no ser equipable.", itemID))
			return true;
		end
	end

	-- Character class filter
	if (RSConfigDB.IsFilteringLootByNotMatchingClass() and RSTooltipScanners.ScanLoot(itemLink, string.gsub(ITEM_CLASSES_ALLOWED, ": %%s", ""))) then
		local localizedClass, _, _ = UnitClass("player")
		if (not RSTooltipScanners.ScanLoot(itemLink, localizedClass)) then
			RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado por clase.", itemID))
			return true;
		end
	end

	-- Character faction filter
	if (RSConfigDB.IsFilteringLootByNotMatchingFaction()) then
		local _, localizedFaction = UnitFactionGroup("player")
		if ((RSTooltipScanners.ScanLoot(itemLink, ITEM_REQ_ALLIANCE) and localizedFaction ~= FACTION_ALLIANCE) or (RSTooltipScanners.ScanLoot(itemLink, ITEM_REQ_HORDE) and localizedFaction ~= FACTION_HORDE)) then
			RSLogger:PrintDebugMessageItemID(itemID, string.format("Item [%s]. Filtrado por facción.", itemID))
			return true;
		end
	end
	
	return false
end
