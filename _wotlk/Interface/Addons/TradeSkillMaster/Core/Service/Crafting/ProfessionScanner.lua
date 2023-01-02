-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local ProfessionScanner = TSM.Crafting:NewPackage("ProfessionScanner")
local ProfessionInfo = TSM.Include("Data.ProfessionInfo")
local CraftString = TSM.Include("Util.CraftString")
local Database = TSM.Include("Util.Database")
local Event = TSM.Include("Util.Event")
local Delay = TSM.Include("Util.Delay")
local TempTable = TSM.Include("Util.TempTable")
local Math = TSM.Include("Util.Math")
local Log = TSM.Include("Util.Log")
local MatString = TSM.Include("Util.MatString")
local ItemString = TSM.Include("Util.ItemString")
local ItemInfo = TSM.Include("Service.ItemInfo")
local Profession = TSM.Include("Service.Profession")
local private = {
	db = nil,
	hasScanned = false,
	callbacks = {},
	disabled = false,
	ignoreUpdatesUntil = 0,
	categorySkillLevelCache = { lastUpdate = 0 },
	recipeInfoCache = {},
	prevScannedHash = nil,
	scanTimer = nil,
}
-- don't want to scan a bunch of times when the profession first loads so add a 10 frame debounce to update events
local SCAN_DEBOUNCE_FRAMES = 10
local MAX_CRAFT_LEVEL = 4



-- ============================================================================
-- Module Functions
-- ============================================================================

function ProfessionScanner.OnInitialize()
	if not TSM.IsWowClassic() then
		private.db = Database.NewSchema("CRAFTING_RECIPES")
			:AddUniqueStringField("craftString")
			:AddNumberField("index")
			:AddStringField("name")
			:AddNumberField("categoryId")
			:AddNumberField("difficulty")
			:AddNumberField("rank")
			:AddNumberField("numSkillUps")
			:AddNumberField("level")
			:AddNumberField("currentExp")
			:AddNumberField("nextExp")
			:AddNumberField("stepExp")
			:Commit()
	else
		private.db = Database.NewSchema("CRAFTING_RECIPES")
			:AddUniqueStringField("craftString")
			:AddNumberField("index")
			:AddStringField("name")
			:AddNumberField("categoryId")
			:AddStringField("difficulty")
			:AddNumberField("rank")
			:AddNumberField("numSkillUps")
			:AddNumberField("level")
			:AddNumberField("currentExp")
			:AddNumberField("nextExp")
			:AddNumberField("stepExp")
			:Commit()
	end
	private.scanTimer = Delay.CreateTimer("PROFESSION_SCAN", private.ScanProfession)
	Profession.RegisterStateCallback(private.ProfessionStateUpdate)
	if TSM.IsWowClassic() then
		Event.Register("CRAFT_UPDATE", private.OnTradeSkillUpdateEvent)
		Event.Register("TRADE_SKILL_UPDATE", private.OnTradeSkillUpdateEvent)
	else
		Event.Register("TRADE_SKILL_LIST_UPDATE", private.OnTradeSkillUpdateEvent)
	end
	Event.Register("CHAT_MSG_SKILL", private.ChatMsgSkillEventHandler)
end

function ProfessionScanner.SetDisabled(disabled)
	if private.disabled == disabled then
		return
	end
	private.disabled = disabled
	if not disabled then
		private.ScanProfession()
	end
end

function ProfessionScanner.HasScanned()
	return private.hasScanned
end

function ProfessionScanner.HasSkills()
	return private.hasScanned and private.db:GetNumRows() > 0
end

function ProfessionScanner.RegisterHasScannedCallback(callback)
	tinsert(private.callbacks, callback)
end

function ProfessionScanner.IgnoreNextProfessionUpdates()
	private.ignoreUpdatesUntil = GetTime() + 1
end

function ProfessionScanner.CreateQuery()
	return private.db:NewQuery()
end

function ProfessionScanner.GetIndexByCraftString(craftString)
	assert(TSM.IsWowClassic() or private.hasScanned)
	return private.db:GetUniqueRowField("craftString", craftString, "index")
end

function ProfessionScanner.GetCategoryIdByCraftString(craftString)
	assert(private.hasScanned)
	return private.db:GetUniqueRowField("craftString", craftString, "categoryId")
end

function ProfessionScanner.GetNameByCraftString(craftString)
	assert(private.hasScanned)
	return private.db:GetUniqueRowField("craftString", craftString, "name")
end

function ProfessionScanner.GetCurrentExpByCraftString(craftString)
	assert(private.hasScanned)
	return private.db:GetUniqueRowField("craftString", craftString, "currentExp")
end

function ProfessionScanner.GetNextExpByCraftString(craftString)
	assert(private.hasScanned)
	return private.db:GetUniqueRowField("craftString", craftString, "nextExp")
end

function ProfessionScanner.GetStepExpByCraftString(craftString)
	assert(private.hasScanned)
	return private.db:GetUniqueRowField("craftString", craftString, "stepExp")
end

function ProfessionScanner.GetDifficultyByCraftString(craftString)
	assert(private.hasScanned)
	return private.db:GetUniqueRowField("craftString", craftString, "difficulty")
end

function ProfessionScanner.GetFirstCraftString()
	if not private.hasScanned then
		return
	end
	return private.db:NewQuery()
		:Select("craftString")
		:OrderBy("index", true)
		:Equal("level", 1)
		:GetFirstResultAndRelease()
end

function ProfessionScanner.HasCraftString(craftString)
	return private.hasScanned and private.db:HasUniqueRow("craftString", craftString)
end



-- ============================================================================
-- Event Handlers
-- ============================================================================

function private.ProfessionStateUpdate()
	private.hasScanned = false
	for _, callback in ipairs(private.callbacks) do
		callback()
	end
	if Profession.GetCurrentProfession() then
		private.db:Truncate()
		private.prevScannedHash = nil
		private.OnTradeSkillUpdateEvent()
	else
		private.scanTimer:Cancel()
	end
end

function private.OnTradeSkillUpdateEvent()
	private.scanTimer:Cancel()
	private.QueueProfessionScan()
end

function private.ChatMsgSkillEventHandler(_, msg)
	local professionName = Profession.GetCurrentProfession()
	if not professionName or not strmatch(msg, professionName) then
		return
	end
	private.ignoreUpdatesUntil = 0
	private.QueueProfessionScan()
end



-- ============================================================================
-- Profession Scanning
-- ============================================================================

function private.QueueProfessionScan()
	private.scanTimer:RunForFrames(SCAN_DEBOUNCE_FRAMES)
end

function private.ScanProfession()
	if InCombatLockdown() then
		-- we are in combat, so try again in a bit
		private.QueueProfessionScan()
		return
	elseif private.disabled then
		return
	elseif GetTime() < private.ignoreUpdatesUntil then
		return
	end

	local professionName = Profession.GetCurrentProfession()
	if not professionName or not Profession.IsDataStable() then
		-- profession hasn't fully opened yet
		private.QueueProfessionScan()
		return
	end

	if Profession.ClearFilters() then
		-- An update event will be triggered
		return
	end

	local scannedHash = nil
	if TSM.IsWowClassic() then
		-- TODO: Better way to trigger this?
		Profession.PopulateClassicSpellIdLookup()
		local lastHeaderIndex = 0
		private.db:TruncateAndBulkInsertStart()
		for i = 1, Profession.IsClassicCrafting() and GetNumCrafts() or GetNumTradeSkills() do
			local name, skillType = nil, nil
			if Profession.IsClassicCrafting() then
				local _
				name, _, skillType = GetCraftInfo(i)
			else
				name, skillType = GetTradeSkillInfo(i)
			end
			if skillType == "header" then
				lastHeaderIndex = i
			elseif name then
				local craftString = CraftString.Get(Profession.GetClassicSpellIdByIndex(i))
				private.db:BulkInsertNewRow(craftString, i, name, lastHeaderIndex, skillType, -1, 1, 1, -1, -1, -1)
			end
		end
		private.db:BulkInsertEnd()
	else
		wipe(private.recipeInfoCache)
		local prevRecipeIds = TempTable.Acquire()
		local nextRecipeIds = TempTable.Acquire()
		local recipes = TempTable.Acquire()
		assert(C_TradeSkillUI.GetFilteredRecipeIDs(recipes) == recipes)
		for index, spellId in ipairs(recipes) do
			-- There's a Blizzard bug where First Aid duplicates spellIds, so check that we haven't seen this before
			if not private.recipeInfoCache[spellId] then
				local info = C_TradeSkillUI.GetRecipeInfo(spellId)
				assert(not info.index)
				info.index = index
				if info.previousRecipeID then
					prevRecipeIds[spellId] = info.previousRecipeID
					nextRecipeIds[info.previousRecipeID] = spellId
				end
				if info.nextRecipeID then
					nextRecipeIds[spellId] = info.nextRecipeID
					prevRecipeIds[info.nextRecipeID] = spellId
				end
				private.recipeInfoCache[spellId] = info
			end
		end
		scannedHash = Math.CalculateHash(private.recipeInfoCache)
		if scannedHash == private.prevScannedHash then
			Log.Info("Hash hasn't changed, so not scanning")
			TempTable.Release(recipes)
			TempTable.Release(prevRecipeIds)
			TempTable.Release(nextRecipeIds)
			private.DoneScanning(scannedHash)
			return
		end
		private.db:TruncateAndBulkInsertStart()
		local inactiveCraftStrings = TempTable.Acquire()
		for index, spellId in ipairs(recipes) do
			local info = private.recipeInfoCache[spellId]
			local nextSpellId = nextRecipeIds[spellId]
			local hasHigherRank = nextSpellId and private.recipeInfoCache[nextSpellId] and private.recipeInfoCache[nextSpellId].learned
			local rank = -1
			if prevRecipeIds[spellId] or nextSpellId then
				rank = 1
				local tempSpellId = spellId
				while prevRecipeIds[tempSpellId] do
					rank = rank + 1
					tempSpellId = prevRecipeIds[tempSpellId]
				end
			end
			-- There's a Blizzard bug where First Aid duplicates spellIds, so check that this is the right index
			-- TODO: show unlearned recipes in the TSM UI
			if info and info.index == index and info.learned and not hasHigherRank then
				local unlockedLevel = info.unlockedRecipeLevel
				local numSkillUps = info.relativeDifficulty == Enum.TradeskillRelativeDifficulty.Optimal and info.numSkillUps or 1
				if unlockedLevel then
					for level = 1, MAX_CRAFT_LEVEL do
						local craftString = CraftString.Get(spellId, rank, level)
						-- Remove any old version of the spell without a level
						inactiveCraftStrings[CraftString.Get(spellId)] = true
						if level <= unlockedLevel then
							private.db:BulkInsertNewRow(craftString, index, info.name, info.categoryID, info.relativeDifficulty, rank, numSkillUps, level, info.currentRecipeExperience or -1, info.nextLevelRecipeExperience or -1, info.earnedExperience or -1)
							private.recipeInfoCache[craftString] = private.recipeInfoCache[spellId]
						else
							-- This level isn't unlocked yet
							inactiveCraftStrings[craftString] = true
						end
					end
				else
					local craftString = CraftString.Get(spellId, rank)
					local numResultItems = Profession.GetNumResultItems(craftString)
					if numResultItems == 1 then
						private.db:BulkInsertNewRow(craftString, index, info.name, info.categoryID, info.relativeDifficulty, rank, numSkillUps, 1, info.currentRecipeExperience or -1, info.nextLevelRecipeExperience or -1, info.earnedExperience or -1)
						private.recipeInfoCache[craftString] = private.recipeInfoCache[spellId]
					else
						-- This is a quality craft
						local recipeDifficulty, baseRecipeQuality = Profession.GetRecipeQualityInfo(craftString)
						if baseRecipeQuality then
							for i = 1, numResultItems do
								local qualityCraftString = CraftString.Get(spellId, rank, nil, i)
								if TSM.Crafting.DFCrafting.CanCraftQuality(i, recipeDifficulty, baseRecipeQuality, numResultItems) then
									private.db:BulkInsertNewRow(qualityCraftString, index, info.name, info.categoryID, info.relativeDifficulty, rank, numSkillUps, 1, info.currentRecipeExperience or -1, info.nextLevelRecipeExperience or -1, info.earnedExperience or -1)
									private.recipeInfoCache[qualityCraftString] = private.recipeInfoCache[spellId]
								else
									-- We can no longer craft this quality
									inactiveCraftStrings[qualityCraftString] = true
								end
							end
						else
							-- Just ignore this craft for now
							Log.Warn("Could not look up base quality (%s, %s)", tostring(professionName), tostring(craftString))
						end
					end
				end
			end
		end
		private.db:BulkInsertEnd()
		-- remove crafts which are not active (i.e. older ranks)
		if next(inactiveCraftStrings) then
			TSM.Crafting.RemovePlayerSpells(inactiveCraftStrings)
		end
		TempTable.Release(inactiveCraftStrings)
		TempTable.Release(recipes)
		TempTable.Release(prevRecipeIds)
		TempTable.Release(nextRecipeIds)
	end

	if Profession.IsNPC() or Profession.IsLinked() or Profession.IsGuild() then
		-- we don't want to store this profession in our DB, so we're done
		private.DoneScanning(scannedHash)
		return
	end

	if not TSM.db.sync.internalData.playerProfessions[professionName] then
		-- we are in combat or the player's professions haven't been scanned yet by PlayerProfessions.lua, so try again in a bit
		private.QueueProfessionScan()
		return
	end

	-- update the link for this profession
	TSM.db.sync.internalData.playerProfessions[professionName].link = Profession.GetLink()

	-- scan all the recipes
	TSM.Crafting.SetSpellDBQueryUpdatesPaused(true)
	local inactiveCraftStrings = TempTable.Acquire()
	local query = private.db:NewQuery()
		:Select("craftString")
	local numFailed = 0
	for _, craftString in query:Iterator() do
		if not private.ScanRecipe(professionName, craftString, inactiveCraftStrings) then
			numFailed = numFailed + 1
		end
	end
	query:Release()
	-- remove crafts which are not active (i.e. lower quality)
	if next(inactiveCraftStrings) then
		TSM.Crafting.RemovePlayerSpells(inactiveCraftStrings)
	end
	TempTable.Release(inactiveCraftStrings)
	TSM.Crafting.SetSpellDBQueryUpdatesPaused(false)

	Log.Info("Scanned %s (failed to scan %d)", professionName, numFailed)
	if numFailed > 0 then
		-- didn't completely scan, so we'll try again
		private.QueueProfessionScan()
	end
	private.DoneScanning(scannedHash)

	-- explicitly run GC
	wipe(private.recipeInfoCache)
	collectgarbage()
end

function private.ScanRecipe(professionName, craftString, inactiveCraftStrings)
	-- get the links
	local spellId = CraftString.GetSpellId(craftString)
	local quality = CraftString.GetQuality(craftString)
	local resultItem = Profession.GetResultItem(craftString)
	local lNum, hNum = Profession.GetCraftedQuantity(craftString)

	-- get the itemString and craft name
	local itemString, craftName, indirectSpellId = nil, nil, nil
	if quality then
		assert(type(resultItem) == "table")
		assert(resultItem[quality])
		itemString = ItemString.GetBase(resultItem[quality])
		craftName = ItemInfo.GetName(itemString)
	elseif strfind(resultItem, "enchant:") then
		if TSM.IsWowClassic() and not TSM.IsWowWrathClassic() then
			return true
		else
			-- result of craft is not an item
			if TSM.IsWowWrathClassic() then
				indirectSpellId = strmatch(resultItem, "enchant:(%d+)")
				indirectSpellId = indirectSpellId and tonumber(indirectSpellId)
				if not indirectSpellId then
					return true
				end
			else
				indirectSpellId = spellId
			end
			itemString = ProfessionInfo.GetIndirectCraftResult(indirectSpellId)
			if not itemString then
				-- we don't care about this craft
				return true
			end
			craftName = GetSpellInfo(indirectSpellId)
		end
	elseif strfind(resultItem, "item:") then
		-- result of craft is item
		itemString = ItemString.GetBase(resultItem)
		craftName = ItemInfo.GetName(resultItem)
		-- Blizzard broke Brilliant Scarlet Ruby in 8.3, so just hard-code a workaround
		if spellId == 53946 and not itemString and not craftName then
			itemString = "i:39998"
			craftName = GetSpellInfo(spellId)
		end
	else
		error("Invalid craft: "..tostring(craftString))
	end
	if not itemString or not craftName then
		Log.Warn("No itemString (%s) or craftName (%s) found (%s, %s)", tostring(itemString), tostring(craftName), tostring(professionName), tostring(craftString))
		return false
	end

	-- get the result number
	local numResult = nil
	local isEnchant = Profession.IsEnchant(craftString)
	local vellumable = isEnchant and not TSM.IsWowVanillaClassic()
	if isEnchant then
		numResult = 1
	else
		-- workaround for incorrect values returned for Temporal Crystal
		if spellId == 169092 and itemString == "i:113588" then
			lNum, hNum = 1, 1
		end
		-- workaround for incorrect values returned for new mass milling recipes
		if ProfessionInfo.IsMassMill(spellId) then
			if spellId == 210116 then -- Yseralline
				lNum, hNum = 4, 4 -- always four
			elseif spellId == 209664 then -- Felwort
				lNum, hNum = 42, 42 -- amount is variable but the values are conservative
			elseif spellId == 247861 then -- Astral Glory
				lNum, hNum = 4, 4 -- amount is variable but the values are conservative
			else
				lNum, hNum = 8, 8.8
			end
		end
		numResult = floor(((lNum or 1) + (hNum or 1)) / 2)
	end

	-- store general info about this recipe
	local hasCD = Profession.HasCooldown(craftString)
	local recipeDifficulty, baseRecipeQuality = Profession.GetRecipeQualityInfo(craftString)
	TSM.Crafting.CreateOrUpdate(craftString, itemString, professionName, craftName, numResult, UnitName("player"), hasCD, recipeDifficulty, baseRecipeQuality, quality and #resultItem or 1)

	-- get the mat quantities and add mats to our DB
	local matQuantities = TempTable.Acquire()
	local haveInvalidMats = false
	local numReagents = Profession.GetNumMats(craftString)
	for i = 1, numReagents do
		local matItemString, quantity, name, isQualityMat = Profession.GetMatInfo(craftString, i)
		if not matItemString then
			Log.Warn("Failed to get itemString for mat %d (%s, %s)", i, tostring(professionName), tostring(craftString))
			haveInvalidMats = true
			break
		end
		if not name or not quantity then
			Log.Warn("Failed to get name (%s) or quantity (%s) for mat (%s, %s, %d)", tostring(name), tostring(quantity), tostring(professionName), tostring(craftString), i)
			haveInvalidMats = true
			break
		end
		if not isQualityMat then
			ItemInfo.StoreItemName(matItemString, name)
			TSM.db.factionrealm.internalData.mats[matItemString] = TSM.db.factionrealm.internalData.mats[matItemString] or {}
			matQuantities[matItemString] = quantity
		end
	end
	-- if this is an enchant, add a vellum to the list of mats
	if isEnchant and vellumable then
		local matItemString = ProfessionInfo.GetVellumItemString(indirectSpellId)
		TSM.db.factionrealm.internalData.mats[matItemString] = TSM.db.factionrealm.internalData.mats[matItemString] or {}
		matQuantities[matItemString] = 1
	end

	if not haveInvalidMats then
		if not TSM.IsWowClassic() then
			local categorySkillLevel = private.GetCurrentCategorySkillLevel(private.recipeInfoCache[spellId].categoryID)
			for _, slotText, matString, quantity in Profession.SpecialMatIterator(craftString, categorySkillLevel) do
				TSM.Crafting.ProfessionUtil.StoreOptionalMatText(matString, slotText)
				for matItemString in MatString.ItemIterator(matString) do
					TSM.db.factionrealm.internalData.mats[matItemString] = TSM.db.factionrealm.internalData.mats[matItemString] or {}
				end
				matQuantities[matString] = quantity
			end
		end
		TSM.Crafting.SetMats(craftString, matQuantities)
	end
	TempTable.Release(matQuantities)
	return not haveInvalidMats
end

function private.GetCurrentCategorySkillLevel(categoryId)
	if private.categorySkillLevelCache.lastUpdate ~= GetTime() then
		wipe(private.categorySkillLevelCache)
		private.categorySkillLevelCache.lastUpdate = GetTime()
	end
	if not private.categorySkillLevelCache[categoryId] then
		local categoryInfo = C_TradeSkillUI.GetCategoryInfo(categoryId)
		while not categoryInfo.skillLineCurrentLevel and categoryInfo.parentCategoryID do
			categoryInfo = C_TradeSkillUI.GetCategoryInfo(categoryInfo.parentCategoryID)
		end
		private.categorySkillLevelCache[categoryId] = categoryInfo.skillLineCurrentLevel or 0
	end
	return private.categorySkillLevelCache[categoryId]
end

function private.DoneScanning(scannedHash)
	private.prevScannedHash = scannedHash
	if not private.hasScanned then
		private.hasScanned = true
		for _, callback in ipairs(private.callbacks) do
			callback()
		end
	end
end
