-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local Profession = TSM.Init("Service.Profession") ---@class Service.Profession
local State = TSM.Include("Service.ProfessionHelpers.State")
local ProfessionInfo = TSM.Include("Data.ProfessionInfo")
local Math = TSM.Include("Util.Math")
local Table = TSM.Include("Util.Table")
local ItemString = TSM.Include("Util.ItemString")
local CraftString = TSM.Include("Util.CraftString")
local MatString = TSM.Include("Util.MatString")
local ItemInfo = TSM.Include("Service.ItemInfo")
local private = {
	resultQualityTemp = {},
	classicSpellIdLookup = {},
	categoryInfoTemp = {},
	matStringItemsTemp = {},
}
local EMPTY_MATS_TABLE = {}



-- ============================================================================
-- Module Functions
-- ============================================================================

---Register a callback for when the profession state changes.
---@param callback fun() The callback function
function Profession.RegisterStateCallback(callback)
	State.RegisterCallback(callback)
end

---Returns whether or not the profession is closed.
---@return boolean
function Profession.IsClosed()
	return State.IsClosed()
end

---Returns whether or not the classic crafting UI is open.
---@return boolean
function Profession.IsClassicCrafting()
	return State.IsClassicCrafting()
end

---Sets whether the classic crafting UI is open.
---@param open boolean
---TODO: Better way to handle this
function Profession.SetClassicCraftingOpen(open)
	State.SetClassicCraftingOpen(open)
end

---Returns whether or not the profession data is stable.
---@return boolean
function Profession.IsDataStable()
	return State.IsDataStable()
end

---Gets the current stable and open profession info.
---@return string @The name of the profession
---@return Enum.Profession? @The profession enum value (retail only)
function Profession.GetCurrentProfession()
	return State.GetCurrentProfession()
end

---Gets the current profession skill line.
---@return string @The name of the profession
---@return Enum.Profession? @The profession enum value (retail only)
---TODO: This should be replaced with GetCurrentProfession() and delayed until the profession data is stable
function Profession.GetSkillLine()
	return State.GetSkillLine()
end

---Opens a profession.
---@param profession string|Enum.Profession The name of the profession (classic) or the profession enum value (retail)
function Profession.Open(profession)
	if TSM.IsWowClassic() then
		assert(type(profession) == "string")
		if profession == ProfessionInfo.GetName("Mining") then
			-- mining needs to be opened as smelting
			profession = ProfessionInfo.GetName("Smelting")
		end
		local mappedName = ProfessionInfo.MapProfessionName(profession)
		if mappedName then
			profession = mappedName
		end
		CastSpellByName(profession)
	else
		assert(type(profession) == "number")
		C_TradeSkillUI.OpenTradeSkill(profession)
	end
end

---Close the open profession.
---@param closeBoth boolean Whether to close both the craft and tradeskill on classic
function Profession.CloseTradeSkill(closeBoth)
	if TSM.IsWowClassic() then
		if closeBoth then
			CloseCraft()
			CloseTradeSkill()
		else
			if Profession.IsClassicCrafting() then
				CloseCraft()
			else
				CloseTradeSkill()
			end
		end
	else
		C_TradeSkillUI.CloseTradeSkill()
		C_Garrison.CloseGarrisonTradeskillNPC()
	end
end

---Returns whether or not the open profession is an NPC profession.
---@return boolean
function Profession.IsNPC()
	return not TSM.IsWowClassic() and C_TradeSkillUI.IsNPCCrafting()
end

---Returns whether or not the open profession is linked.
---@return boolean
---@return string? @The character who it's linked from (if available)
function Profession.IsLinked()
	if TSM.IsWowVanillaClassic() then
		return nil, nil
	elseif TSM.IsWowWrathClassic() then
		return IsTradeSkillLinked()
	else
		return C_TradeSkillUI.IsTradeSkillLinked()
	end
end

---Returns whether or not the open profession is a guild profession.
---@return boolean
function Profession.IsGuild()
	return not TSM.IsWowClassic() and C_TradeSkillUI.IsTradeSkillGuild()
end

---Returns a link for the current profession.
---@return string?
function Profession.GetLink()
	if TSM.IsWowClassic() then
		return nil
	end
	return C_TradeSkillUI.GetTradeSkillListLink()
end

---Clears all profession filters
---@return boolean @Whether or not a filter was cleared
function Profession.ClearFilters()
	if TSM.IsWowClassic() then
		-- TODO
		return false
	else
		local hadFilter = false
		if C_TradeSkillUI.GetShowUnlearned() then
			C_TradeSkillUI.SetShowLearned(true)
			C_TradeSkillUI.SetShowUnlearned(false)
			hadFilter = true
		end
		if C_TradeSkillUI.GetOnlyShowMakeableRecipes() then
			C_TradeSkillUI.SetOnlyShowMakeableRecipes(false)
			hadFilter = true
		end
		if C_TradeSkillUI.GetOnlyShowSkillUpRecipes() then
			C_TradeSkillUI.SetOnlyShowSkillUpRecipes(false)
			hadFilter = true
		end
		if C_TradeSkillUI.AnyRecipeCategoriesFiltered() then
			C_TradeSkillUI.ClearRecipeCategoryFilter()
			hadFilter = true
		end
		if C_TradeSkillUI.AreAnyInventorySlotsFiltered() then
			C_TradeSkillUI.ClearInventorySlotFilter()
			hadFilter = true
		end
		for i = 1, C_PetJournal.GetNumPetSources() do
			if C_TradeSkillUI.IsAnyRecipeFromSource(i) and C_TradeSkillUI.IsRecipeSourceTypeFiltered(i) then
				C_TradeSkillUI.ClearRecipeSourceTypeFilter()
				hadFilter = true
				break
			end
		end
		if C_TradeSkillUI.GetRecipeItemNameFilter() ~= "" then
			C_TradeSkillUI.SetRecipeItemNameFilter(nil)
			hadFilter = true
		end
		local minItemLevel, maxItemLevel = C_TradeSkillUI.GetRecipeItemLevelFilter()
		if minItemLevel ~= 0 or maxItemLevel ~= 0 then
			C_TradeSkillUI.SetRecipeItemLevelFilter(0, 0)
			hadFilter = true
		end
		return hadFilter
	end
end

---Populates the spellId lookup for classic.
function Profession.PopulateClassicSpellIdLookup()
	assert(TSM.IsWowClassic())
	assert(Profession.GetCurrentProfession() and Profession.IsDataStable())
	wipe(private.classicSpellIdLookup)
	for i = 1, Profession.IsClassicCrafting() and GetNumCrafts() or GetNumTradeSkills() do
		local hash = private.GetClassicSpellId(i)
		if hash then
			assert(hash >= 0 and not private.classicSpellIdLookup[hash] and not private.classicSpellIdLookup[-i])
			private.classicSpellIdLookup[hash] = i
			private.classicSpellIdLookup[-i] = hash
		end
	end
end

---Look up a classic spellId by index.
---@param index number
---@return number?
function Profession.GetClassicSpellIdByIndex(index)
	return private.classicSpellIdLookup[-index]
end

---Gets whether or not a recipe has a cooldown.
---@param craftString string The craft string for the recipe
---@return boolean
function Profession.HasCooldown(craftString)
	local spellId = CraftString.GetSpellId(craftString)
	if TSM.IsWowClassic() then
		spellId = private.classicSpellIdLookup[spellId] or spellId
		return GetTradeSkillCooldown(spellId) and true or false
	else
		return select(2, C_TradeSkillUI.GetRecipeCooldown(spellId)) and true or false
	end
end

---Gets the remaining cooldown for a recipe.
---@param craftString string The craft string for the recipe
---@return number?
function Profession.GetRemainingCooldown(craftString)
	local spellId = CraftString.GetSpellId(craftString)
	local cooldown = nil
	if TSM.IsWowClassic() then
		spellId = private.classicSpellIdLookup[spellId] or spellId
		cooldown = GetTradeSkillCooldown(spellId)
	else
		cooldown = C_TradeSkillUI.GetRecipeCooldown(spellId)
	end
	return cooldown
end

---Gets how many the recipe crafts.
---@param craftString string The craft string for the recipe
---@return number @The lower bound of the crafted quantity
---@return number @The upper bound of the crafted quantity
function Profession.GetCraftedQuantity(craftString)
	if Profession.IsClassicCrafting() then
		return 1, 1
	end
	local spellId = CraftString.GetSpellId(craftString)
	if TSM.IsWowClassic() then
		spellId = private.classicSpellIdLookup[spellId] or spellId
		return GetTradeSkillNumMade(spellId)
	else
		local info = C_TradeSkillUI.GetRecipeSchematic(spellId, false)
		return info.quantityMin, info.quantityMax
	end
end

---Gets the number of different quality items the recipe crafts (retail only).
---@param craftString string The craft string for the recipe
---@return number
function Profession.GetNumResultItems(craftString)
	assert(not TSM.IsWowClassic())
	local spellId = CraftString.GetSpellId(craftString)
	local resultItems = C_TradeSkillUI.GetRecipeQualityItemIDs(spellId) or ProfessionInfo.GetIndirectCraftResult(spellId)
	if type(resultItems) ~= "table" then
		return 1
	end
	return #resultItems
end

---Gets the result of a recipe.
---@param craftString string The craft string for the recipe
---@return string|string[]?
---TODO: Should this handle indirect crafts on classic like GetResultInfo()?
function Profession.GetResultItem(craftString)
	local spellId = CraftString.GetSpellId(craftString)
	if TSM.IsWowClassic() then
		spellId = private.classicSpellIdLookup[spellId] or spellId
		local itemLink = Profession.IsClassicCrafting() and GetCraftItemLink(spellId) or GetTradeSkillItemLink(spellId)
		local emptyLink = strfind(itemLink or "", "item::") and true or false
		itemLink = not emptyLink and itemLink or nil
		return itemLink or (TSM.IsWowWrathClassic() and GetTradeSkillRecipeLink(spellId)) or nil
	else
		local indirectResult = ProfessionInfo.GetIndirectCraftResult(spellId)
		if indirectResult then
			if type(indirectResult) == "table" then
				for i = 1, #indirectResult do
					local link = ItemInfo.GetLink(indirectResult[i])
					assert(link)
					indirectResult[i] = link
				end
			else
				indirectResult = ItemInfo.GetLink(indirectResult)
				assert(indirectResult)
			end
			return indirectResult
		end
		local result = C_TradeSkillUI.GetRecipeQualityItemIDs(spellId)
		if not result then
			return C_TradeSkillUI.GetRecipeItemLink(spellId)
		end
		wipe(private.resultQualityTemp)
		for i = 1, #result do
			local itemId = result[i]
			local itemString = "i:"..itemId
			local quality = C_TradeSkillUI.GetItemCraftedQualityByItemInfo(itemId) or C_TradeSkillUI.GetItemReagentQualityByItemInfo(itemId) or ItemInfo.GetCraftedQuality(itemString)
			assert(quality)
			private.resultQualityTemp[itemId] = quality
		end
		Table.SortWithValueLookup(result, private.resultQualityTemp)
		for i = 1, #result do
			local link = ItemInfo.GetLink("i:"..result[i])
			assert(link)
			result[i] = link
		end
		return result
	end
end

---Gets the result info for a recipe.
---@param craftString string The craft string for the recipe
---@return string? itemString
---@return number? texture
---@return string? name
function Profession.GetResultInfo(craftString)
	-- Get the links
	local resultItem = Profession.GetResultItem(craftString)
	if not resultItem then
		return nil, nil, nil
	end
	if type(resultItem) == "table" then
		-- TODO: Update the caller to handle multiple result items
		local itemLink = resultItem[1]
		return ItemString.Get(itemLink), ItemInfo.GetTexture(itemLink), ItemInfo.GetName(itemLink)
	elseif strfind(resultItem, "enchant:") then
		-- Result of craft is not an item
		local spellId = CraftString.GetSpellId(craftString)
		local indirectSpellId = nil
		if TSM.IsWowWrathClassic() then
			indirectSpellId = strmatch(resultItem, "enchant:(%d+)")
			indirectSpellId = indirectSpellId and tonumber(indirectSpellId)
			if not indirectSpellId then
				return nil, nil, nil
			end
		else
			indirectSpellId = spellId
		end
		local itemString = ProfessionInfo.GetIndirectCraftResult(indirectSpellId)
		if type(itemString) == "table" then
			-- TODO: Update the caller to handle multiple result items
			itemString = itemString[1]
		end
		if itemString and (not TSM.IsWowClassic() or TSM.IsWowWrathClassic()) then
			return itemString, ItemInfo.GetTexture(itemString), ItemInfo.GetName(itemString)
		elseif ProfessionInfo.IsEngineeringTinker(spellId) then
			local name, _, icon = GetSpellInfo(spellId)
			return nil, icon, name
		elseif TSM.IsWowWrathClassic() then
			local name, _, icon = GetSpellInfo(indirectSpellId)
			return nil, icon, name
		else
			local name, _, icon = GetSpellInfo(Profession.IsClassicCrafting() and GetCraftInfo(TSM.IsWowClassic() and private.classicSpellIdLookup[spellId] or spellId) or spellId)
			return nil, icon, name
		end
	elseif strfind(resultItem, "item:") then
		-- result of craft is an item
		return ItemString.Get(resultItem), ItemInfo.GetTexture(resultItem), ItemInfo.GetName(resultItem)
	else
		error("Invalid craft: "..craftString)
	end
end

---Returns whether or not a recipe is an enchant.
---@param craftString string The craft string for the recipe
---@return boolean
function Profession.IsEnchant(craftString)
	if State.GetSkillLine() ~= GetSpellInfo(7411) then
		return false
	end
	local spellId = CraftString.GetSpellId(craftString)
	if TSM.IsWowClassic() then
		local itemLink = Profession.GetResultItem(craftString)
		if not itemLink or not strfind(itemLink, "enchant:") then
			return false
		end
		return true
	else
		if not strfind(C_TradeSkillUI.GetRecipeItemLink(spellId), "enchant:") then
			return false
		end
		local recipeInfo = C_TradeSkillUI.GetRecipeInfo(spellId)
		return recipeInfo.isEnchantingRecipe
	end
end

---Gets the tools required for a recipe.
---@param craftString string The craft string for the recipe
---@return string @The string describing the tools required
---@return boolean @Whether or not the tools are present
function Profession.GetToolInfo(craftString)
	local toolsStr, hasTools = nil, nil
	local spellId = CraftString.GetSpellId(craftString)
	if TSM.IsWowClassic() then
		spellId = private.classicSpellIdLookup[spellId] or spellId
		if Profession.IsClassicCrafting() then
			toolsStr, hasTools = GetCraftSpellFocus(spellId)
		else
			toolsStr, hasTools = GetTradeSkillTools(spellId)
		end
	else
		for _, requirement in ipairs(C_TradeSkillUI.GetRecipeRequirements(spellId)) do
			if requirement.type == Enum.RecipeRequirementType.Totem then
				toolsStr = requirement.name
				if not requirement.met then
					return toolsStr, false
				end
			end
		end
		hasTools = true
	end
	return toolsStr, hasTools
end

---Gets the link for a recipe.
---@param craftString string The craft string for the recipe
---@return string
function Profession.GetRecipeLink(craftString)
	local spellId = CraftString.GetSpellId(craftString)
	if TSM.IsWowClassic() then
		spellId = private.classicSpellIdLookup[spellId] or spellId
		if Profession.IsClassicCrafting() then
			return GetCraftRecipeLink(spellId)
		else
			return GetTradeSkillRecipeLink(spellId)
		end
	else
		return C_TradeSkillUI.GetRecipeLink(spellId)
	end
end

---Get information on a profession category.
---@param categoryId number The category ID
---@return string? @The name
---@return number @The number of indents
---@return number? @The parent category ID (on retail)
---@return number? @The current skill level for the category (on retail)
---@return number? @The max skill level for the category (on retail)
function Profession.CategoryInfo(categoryId)
	if TSM.IsWowClassic() then
		local name = Profession.IsClassicCrafting() and GetCraftDisplaySkillLine() or (categoryId and GetTradeSkillInfo(categoryId) or nil)
		return name, 0, nil, nil, nil
	end
	C_TradeSkillUI.GetCategoryInfo(categoryId, private.categoryInfoTemp)
	local name = private.categoryInfoTemp.name
	local parentCategoryId = private.categoryInfoTemp.numIndents ~= 0 and private.categoryInfoTemp.parentCategoryID or nil
	local currentSkillLevel = private.categoryInfoTemp.skillLineCurrentLevel
	local maxSkillLevel = private.categoryInfoTemp.skillLineMaxLevel
	local numIndents = 0
	if parentCategoryId then
		C_TradeSkillUI.GetCategoryInfo(parentCategoryId, private.categoryInfoTemp)
		if private.categoryInfoTemp.type == "subheader" then
			numIndents = parentCategoryId == private.categoryInfoTemp.parentCategoryID and 0 or 1
		end
	else
		numIndents = 0
	end
	wipe(private.categoryInfoTemp)
	return name, numIndents, parentCategoryId, currentSkillLevel, maxSkillLevel
end

---Gets the number of mats for a recipe.
---@param craftString string The craft string for the recipe
---@return number
function Profession.GetNumMats(craftString)
	local spellId = CraftString.GetSpellId(craftString)
	local numMats = nil
	if TSM.IsWowClassic() then
		spellId = private.classicSpellIdLookup[spellId] or spellId
		numMats = Profession.IsClassicCrafting() and GetCraftNumReagents(spellId) or GetTradeSkillNumReagents(spellId)
	else
		local level = CraftString.GetLevel(craftString)
		local info = C_TradeSkillUI.GetRecipeSchematic(spellId, false, level)
		local num = 0
		for _, data in pairs(info.reagentSlotSchematics) do
			if data.reagentType == Enum.CraftingReagentType.Basic then
				if data.dataSlotType == Enum.TradeskillSlotDataType.Reagent then
					num = num + 1
				elseif data.dataSlotType == Enum.TradeskillSlotDataType.ModifiedReagent then
					num = num + 1
				end
			end
		end
		numMats = num
	end
	return numMats
end

---Gets information on a material.
---@param craftString string The craft string for the recipe
---@param index number The index of the material
---@return string? itemString
---@return number? quantity
---@return string? name
---@return boolean? isQualityMat
function Profession.GetMatInfo(craftString, index)
	local spellId = CraftString.GetSpellId(craftString)
	if TSM.IsWowClassic() then
		spellId = private.classicSpellIdLookup[spellId] or spellId
		local itemLink = Profession.IsClassicCrafting() and GetCraftReagentItemLink(spellId, index) or GetTradeSkillReagentItemLink(spellId, index)
		local itemString = ItemString.Get(itemLink)
		if Profession.IsClassicCrafting() then
			local name, _, quantity = GetCraftReagentInfo(spellId, index)
			return itemString, quantity, name, false
		else
			local name, _, quantity = GetTradeSkillReagentInfo(spellId, index)
			return itemString, quantity, name, false
		end
	else
		local info = C_TradeSkillUI.GetRecipeSchematic(spellId, false, CraftString.GetLevel(craftString))
		local reagentSlotInfo = info.reagentSlotSchematics[index]
		if reagentSlotInfo.reagentType == Enum.CraftingReagentType.Basic and reagentSlotInfo.dataSlotType == Enum.TradeskillSlotDataType.Reagent then
			local itemLink = C_TradeSkillUI.GetRecipeFixedReagentItemLink(spellId, reagentSlotInfo.dataSlotIndex)
			local itemString = ItemString.Get(itemLink)
			local name, quantity = ItemInfo.GetName(itemLink), reagentSlotInfo.quantityRequired
			return itemString, quantity, name, false
		elseif reagentSlotInfo.reagentType == Enum.CraftingReagentType.Basic and reagentSlotInfo.dataSlotType == Enum.TradeskillSlotDataType.ModifiedReagent then
			local qualityIndex = 1
			local reagentDataInfo = reagentSlotInfo.reagents[qualityIndex]
			local itemLink = C_TradeSkillUI.GetRecipeQualityReagentItemLink(spellId, reagentSlotInfo.dataSlotIndex, qualityIndex)
			-- NOTE: For some reason, the above API doesn't always work (i.e. with 'Handful of Serevite Bolts')
			local itemString = itemLink and ItemString.Get(itemLink) or "i:"..reagentDataInfo.itemID
			itemLink = itemLink or ItemInfo.GetLink(reagentDataInfo.itemID)
			local name, quantity = ItemInfo.GetName(itemLink), reagentSlotInfo.quantityRequired
			return itemString, quantity, name, true
		else
			return nil, nil, nil, false
		end
	end
end

---Iterator for the optional/quality/finishing mats for a recipe.
---@param craftString string The craft string for the recipe
---@param categorySkillLevel number The category skill level
---@return fun(): number, string, string, number @An iterator with fields: `index`, `slotText`, `matString`, `quantity`
function Profession.SpecialMatIterator(craftString, categorySkillLevel)
	assert(not TSM.IsWowClassic())
	local spellId = CraftString.GetSpellId(craftString)
	local level = CraftString.GetLevel(craftString)
	local mats = C_TradeSkillUI.GetRecipeSchematic(spellId, false, level).reagentSlotSchematics
	mats.categorySkillLevel = categorySkillLevel
	return private.SpecialMatInfoIterator, mats, 0
end

---Gets quality info for a DF recipe.
---@param craftString string The craft string for the recipe
---@return number? baseDifficulty
---@return number? quality
function Profession.GetRecipeQualityInfo(craftString)
	if TSM.IsWowClassic() then
		return nil, nil
	end
	local spellId = CraftString.GetSpellId(craftString)
	-- TODO: Do we need this info?
	local info = C_TradeSkillUI.GetRecipeSchematic(spellId, false, 1)
	local isItem = info.recipeType == Enum.TradeskillRecipeType.Item
	local isEnchant = info.recipeType == Enum.TradeskillRecipeType.Enchant
	if not info.hasCraftingOperationInfo or info.hasGatheringOperationInfo then
		return nil, nil
	elseif not isItem and not isEnchant then
		return nil, nil
	elseif isItem and not info.outputItemID then
		return nil, nil
	end
	local operationInfo = C_TradeSkillUI.GetCraftingOperationInfo(spellId, EMPTY_MATS_TABLE)
	if not operationInfo then
		return nil, nil
	end
	if isItem and not ItemInfo.IsCommodity("i:"..info.outputItemID) and operationInfo.isQualityCraft then
		-- TODO: Support crafts where the quality results in higher item level gear
		return nil, nil
	end
	return operationInfo.baseDifficulty, operationInfo.quality
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.GetClassicSpellId(index)
	local name, skillType = nil, nil
	if Profession.IsClassicCrafting() then
		local _
		name, _, skillType = GetCraftInfo(index)
	else
		name, skillType = GetTradeSkillInfo(index)
	end
	if skillType == "header" or not name then
		return
	end
	local hash = Math.CalculateHash(name)
	if Profession.IsClassicCrafting() then
		hash = Math.CalculateHash(GetCraftIcon(index), hash)
		for i = 1, GetCraftNumReagents(index) do
			local _, _, quantity = GetCraftReagentInfo(index, i)
			hash = Math.CalculateHash(ItemString.Get(GetCraftReagentItemLink(index, i)), hash)
			hash = Math.CalculateHash(quantity, hash)
		end
	else
		hash = Math.CalculateHash(GetTradeSkillIcon(index), hash)
		for i = 1, GetTradeSkillNumReagents(index) do
			local _, _, quantity = GetTradeSkillReagentInfo(index, i)
			hash = Math.CalculateHash(ItemString.Get(GetTradeSkillReagentItemLink(index, i)), hash)
			hash = Math.CalculateHash(quantity, hash)
		end
	end
	return hash
end

function private.SpecialMatInfoIterator(tbl, index)
	while true do
		index = index + 1
		local data = tbl[index]
		if not data then
			return
		end
		if private.IsSpecialMatValid(data, tbl.categorySkillLevel) then
			assert(not next(private.matStringItemsTemp))
			for _, craftingReagent in ipairs(data.reagents) do
				tinsert(private.matStringItemsTemp, craftingReagent.itemID)
			end
			local matStringType = nil
			if data.reagentType == Enum.CraftingReagentType.Basic and data.dataSlotType == Enum.TradeskillSlotDataType.ModifiedReagent then
				matStringType = MatString.TYPE.QUALITY
			elseif data.reagentType == Enum.CraftingReagentType.Optional then
				matStringType = MatString.TYPE.OPTIONAL
			elseif data.reagentType == Enum.CraftingReagentType.Finishing then
				matStringType = MatString.TYPE.FINISHING
			else
				error("Unexpected optional mat type: "..tostring(data.reagentType)..", "..tostring(data.dataSlotType))
			end
			local matString = MatString.Create(matStringType, data.dataSlotIndex, private.matStringItemsTemp)
			wipe(private.matStringItemsTemp)
			local slotText = data.slotInfo.slotText or OPTIONAL_REAGENT_POSTFIX
			return index, slotText, matString, data.quantityRequired
		end
	end
end

function private.IsSpecialMatValid(data, categorySkillLevel)
	if data.reagentType == Enum.CraftingReagentType.Basic and data.dataSlotType == Enum.TradeskillSlotDataType.ModifiedReagent then
		-- pass
	elseif data.reagentType == Enum.CraftingReagentType.Optional or data.reagentType == Enum.CraftingReagentType.Finishing then
		-- pass
	else
		return false
	end
	return data.slotInfo.requiredSkillRank <= categorySkillLevel
end
