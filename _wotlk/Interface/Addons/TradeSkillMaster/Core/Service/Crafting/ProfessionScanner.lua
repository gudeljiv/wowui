-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local ProfessionScanner = TSM.Crafting:NewPackage("ProfessionScanner")
local ProfessionInfo = TSM.Include("Data.ProfessionInfo")
local CraftString = TSM.Include("Util.CraftString")
local TempTable = TSM.Include("Util.TempTable")
local Log = TSM.Include("Util.Log")
local MatString = TSM.Include("Util.MatString")
local ItemString = TSM.Include("Util.ItemString")
local ItemInfo = TSM.Include("Service.ItemInfo")
local Profession = TSM.Include("Service.Profession")
local private = {}



-- ============================================================================
-- Module Functions
-- ============================================================================

function ProfessionScanner.OnInitialize()
	Profession.SetScanHookFuncs(private.ScanHook, TSM.Crafting.RemovePlayerSpells)
end



-- ============================================================================
-- Profession Scanning
-- ============================================================================

function private.ScanHook(professionName, craftStrings, categorySkillLevelLookup)
	if not TSM.db.sync.internalData.playerProfessions[professionName] then
		-- we are in combat or the player's professions haven't been scanned yet by PlayerProfessions.lua, so will try again in a bit
		return false, true
	end

	-- update the link for this profession
	TSM.db.sync.internalData.playerProfessions[professionName].link = Profession.GetLink()

	-- scan all the recipes
	TSM.Crafting.SetSpellDBQueryUpdatesPaused(true)
	local numFailed = 0
	for _, craftString in ipairs(craftStrings) do
		if not private.ScanRecipe(professionName, craftString, categorySkillLevelLookup) then
			numFailed = numFailed + 1
		end
	end
	TSM.Crafting.SetSpellDBQueryUpdatesPaused(false)

	Log.Info("Scanned %s (failed to scan %d)", professionName, numFailed)
	return numFailed == 0, false
end

function private.ScanRecipe(professionName, craftString, categorySkillLevelLookup)
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
	if Profession.IsEnchant(craftString) then
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

	local matQuantities = TempTable.Acquire()
	for _, matString, quantity, slotText in Profession.MatIterator(craftString) do
		local matType = MatString.GetType(matString)
		if matType == MatString.TYPE.NORMAL then
			TSM.db.factionrealm.internalData.mats[matString] = TSM.db.factionrealm.internalData.mats[matString] or {}
			matQuantities[matString] = quantity
		else
			TSM.Crafting.ProfessionUtil.StoreOptionalMatText(matString, slotText)
			for matItemString in MatString.ItemIterator(matString) do
				TSM.db.factionrealm.internalData.mats[matItemString] = TSM.db.factionrealm.internalData.mats[matItemString] or {}
			end
			matQuantities[matString] = quantity
		end
	end
	if next(matQuantities) then
		TSM.Crafting.SetMats(craftString, matQuantities)
	end
	TempTable.Release(matQuantities)
	return true
end
