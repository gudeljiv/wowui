-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local _, TSM = ...
local ItemClass = TSM.Init("Data.ItemClass")
local STATIC_DATA = {
	classes = {},
	subClasses = {},
	classLookup = {},
	classIdLookup = {},
	inventorySlotIdLookup = {},
}



-- ============================================================================
-- Population of the Static Data
-- ============================================================================

do
	-- Needed because NUM_LE_ITEM_CLASSS contains an erroneous value
	local ITEM_CLASS_IDS = nil
	if not TSM.IsWowClassic() then
		ITEM_CLASS_IDS = {
			LE_ITEM_CLASS_WEAPON,
			LE_ITEM_CLASS_ARMOR,
			LE_ITEM_CLASS_CONTAINER,
			LE_ITEM_CLASS_GEM,
			LE_ITEM_CLASS_ITEM_ENHANCEMENT,
			LE_ITEM_CLASS_CONSUMABLE,
			LE_ITEM_CLASS_GLYPH,
			LE_ITEM_CLASS_TRADEGOODS,
			LE_ITEM_CLASS_RECIPE,
			LE_ITEM_CLASS_BATTLEPET,
			LE_ITEM_CLASS_QUESTITEM,
			LE_ITEM_CLASS_MISCELLANEOUS,
		}
	elseif TSM.IsWowBCClassic() then
		ITEM_CLASS_IDS = {
			LE_ITEM_CLASS_WEAPON,
			LE_ITEM_CLASS_ARMOR,
			LE_ITEM_CLASS_CONTAINER,
			LE_ITEM_CLASS_CONSUMABLE,
			LE_ITEM_CLASS_TRADEGOODS,
			LE_ITEM_CLASS_PROJECTILE,
			LE_ITEM_CLASS_QUIVER,
			LE_ITEM_CLASS_RECIPE,
			LE_ITEM_CLASS_GEM,
			LE_ITEM_CLASS_MISCELLANEOUS,
			LE_ITEM_CLASS_QUESTITEM,
		}
	else
		ITEM_CLASS_IDS = {
			LE_ITEM_CLASS_WEAPON,
			LE_ITEM_CLASS_ARMOR,
			LE_ITEM_CLASS_CONTAINER,
			LE_ITEM_CLASS_CONSUMABLE,
			LE_ITEM_CLASS_TRADEGOODS,
			LE_ITEM_CLASS_PROJECTILE,
			LE_ITEM_CLASS_QUIVER,
			LE_ITEM_CLASS_RECIPE,
			LE_ITEM_CLASS_REAGENT,
			LE_ITEM_CLASS_MISCELLANEOUS,
		}
	end

	for _, classId in ipairs(ITEM_CLASS_IDS) do
		local class = GetItemClassInfo(classId)
		if class then
			STATIC_DATA.classIdLookup[strlower(class)] = classId
			STATIC_DATA.classLookup[class] = {}
			STATIC_DATA.classLookup[class]._index = classId
			local subClasses = nil
			if TSM.IsWowClassic() then
				subClasses = {GetAuctionItemSubClasses(classId)}
			else
				subClasses = C_AuctionHouse.GetAuctionItemSubClasses(classId)
			end
			for _, subClassId in pairs(subClasses) do
				local subClassName = GetItemSubClassInfo(classId, subClassId)
				if not strfind(subClassName, "(OBSOLETE)") then
					STATIC_DATA.classLookup[class][subClassName] = subClassId
				end
			end
		end
	end

	for class, subClasses in pairs(STATIC_DATA.classLookup) do
		tinsert(STATIC_DATA.classes, class)
		STATIC_DATA.subClasses[class] = {}
		for subClass in pairs(subClasses) do
			if subClass ~= "_index" then
				tinsert(STATIC_DATA.subClasses[class], subClass)
			end
		end
		sort(STATIC_DATA.subClasses[class], function(a, b) return STATIC_DATA.classLookup[class][a] < STATIC_DATA.classLookup[class][b] end)
	end
	sort(STATIC_DATA.classes, function(a, b) return STATIC_DATA.classIdLookup[strlower(a)] < STATIC_DATA.classIdLookup[strlower(b)] end)

	for _, id in pairs(Enum.InventoryType) do
		local invType = GetItemInventorySlotInfo(id)
		if invType then
			STATIC_DATA.inventorySlotIdLookup[strlower(invType)] = id
		end
	end
end



-- ============================================================================
-- Module Functions
-- ============================================================================

function ItemClass.GetClasses()
	return STATIC_DATA.classes
end

function ItemClass.GetSubClasses(class)
	return STATIC_DATA.subClasses[class]
end

function ItemClass.GetClassIdFromClassString(classStr)
	return STATIC_DATA.classIdLookup[strlower(classStr)]
end

function ItemClass.GetSubClassIdFromSubClassString(subClass, classId)
	if not classId then return end
	local class = GetItemClassInfo(classId)
	if not STATIC_DATA.classLookup[class] then return end
	for str, index in pairs(STATIC_DATA.classLookup[class]) do
		if strlower(str) == strlower(subClass) then
			return index
		end
	end
end

function ItemClass.GetInventorySlotIdFromInventorySlotString(slot)
	return STATIC_DATA.inventorySlotIdLookup[strlower(slot)]
end
