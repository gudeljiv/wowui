local _, xVermin = ...

-- WeaponEnhancementMacro.lua
local macroName = "sharp"

-- Priority order (best to worst)
local sharpeningStones = {
	23528, -- Adamantite Sharpening Stone
	23122, -- Consecrated Sharpening Stone
	18262, -- Elemental Sharpening Stone
	12404, -- Dense Sharpening Stone
	7964, -- Solid Sharpening Stone
	2871, -- Heavy Sharpening Stone
	2863, -- Coarse Sharpening Stone
	2862, -- Rough Sharpening Stone
}

local weightstones = {
	23529, -- Adamantite Weightstone
	12643, -- Dense Weightstone
	7965, -- Solid Weightstone
	3241, -- Heavy Weightstone
	3240, -- Coarse Weightstone
	3239, -- Rough Weightstone
}

-- Check if item is in bags
local function HasItem(itemID)
	for bag = 0, 4 do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			local item = C_Container.GetContainerItemInfo(bag, slot)
			if item and item.itemID == itemID then
				return true
			end
		end
	end
	return false
end

-- Check weapon type (returns true if bladed/edged, false if blunt)
local function IsEdgedWeapon(slot)
	local itemLink = GetInventoryItemLink("player", slot)
	if not itemLink then
		return nil
	end

	local _, _, _, _, _, _, subClass = GetItemInfo(itemLink)
	-- Edged weapons: Swords, Axes, Daggers, Polearms
	-- Blunt weapons: Maces
	if subClass then
		if subClass:find("Axe") or subClass:find("Sword") or subClass:find("Dagger") or subClass:find("Polearm") then
			return true
		elseif subClass:find("Mace") or subClass:find("Staff") or subClass:find("Fist") then
			return false
		end
	end
	return true -- Default to sharpening stone
end

-- Find best available enhancement
local function FindBestEnhancement()
	local mainHandEdged = IsEdgedWeapon(16)
	local offHandEdged = IsEdgedWeapon(17)

	-- Determine which type we need
	local needSharpening = false
	local needWeightstone = false

	if mainHandEdged == true or offHandEdged == true then
		needSharpening = true
	end
	if mainHandEdged == false or offHandEdged == false then
		needWeightstone = true
	end

	-- Prefer sharpening stones if both weapons can use them
	-- or if we have mixed weapons
	local searchList = sharpeningStones
	if needWeightstone and not needSharpening then
		searchList = weightstones
	end

	-- Find best available
	for _, itemID in ipairs(searchList) do
		if HasItem(itemID) then
			return itemID
		end
	end

	-- If primary type not found, try the other
	if needSharpening and needWeightstone then
		for _, itemID in ipairs(weightstones) do
			if HasItem(itemID) then
				return itemID
			end
		end
	end

	return nil
end

-- Create or update macro
local function UpdateWeaponMacro()
	local itemID = FindBestEnhancement()

	if not itemID then
		itemID = 0
	end

	local macroText = string.format(
		"#showtooltip item:%d\n/use item:%d\n/use [button:2] 17; 16\n/click StaticPopup1Button1",
		itemID,
		itemID
	)

	local macroIndex = GetMacroIndexByName(macroName)
	if macroIndex == 0 then
		local numAccountMacros, numCharacterMacros = GetNumMacros()
		if numCharacterMacros < 18 then
			CreateMacro(macroName, "INV_Misc_QuestionMark", macroText, nil)
		else
			print("Cannot create macro - character macro limit reached!")
		end
	else
		EditMacro(macroIndex, macroName, "INV_Misc_QuestionMark", macroText)
	end
end

-- Slash command
SLASH_WEAPONBUFF1 = "/weaponbuff"
SLASH_WEAPONBUFF2 = "/wb"
SlashCmdList["WEAPONBUFF"] = function()
	UpdateWeaponMacro()
end

-- Auto-update on login and bag update
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("BAG_UPDATE")
frame:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		C_Timer.After(2, function()
			if not InCombatLockdown() then
				UpdateWeaponMacro()
			else
				self.queuedUpdate = true
				self:RegisterEvent("PLAYER_REGEN_ENABLED")
			end
		end)
	elseif event == "BAG_UPDATE" then
		-- Debounce bag updates
		if not self.debounceActive then
			self.debounceActive = true
			C_Timer.After(1, function()
				if not InCombatLockdown() then
					UpdateWeaponMacro()
				else
					self.queuedUpdate = true
					self:RegisterEvent("PLAYER_REGEN_ENABLED")
				end
				self.debounceActive = false
			end)
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		-- Exited combat
		if self.queuedUpdate then
			UpdateWeaponMacro()
			self.queuedUpdate = false
		end
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	end
end)

-- print("Weapon Enhancement Macro loaded. Use /weaponbuff or /wb to update.")
