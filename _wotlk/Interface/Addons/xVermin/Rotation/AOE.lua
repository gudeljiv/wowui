local _, xVermin = ...
local RangeCheck = LibStub('LibRangeCheck-2.0')
local minRange, maxRange

function xGetRange(unit)
	if UnitExists(unit) then
		minRange, maxRange = RangeCheck:GetRange(unit)
		return minRange, maxRange
	else
		return -1, -1
	end
end

-- 1 = Inspect, 28 yards
-- 2 = Trade, 11.11 yards
-- 3 = Duel, 9.9 yards
-- 4 = Follow, 28 yards
function AOE(range)
	local type = type or 'bool'
	local range = range or 5
	local inRange = 0

	for i = 1, 40 do
		-- if UnitExists('nameplate' .. i) and IsSpellInRange(skill, 'nameplate' .. i) == 1 and CheckInteractDistance('nameplate' .. i, 3) then
		if UnitExists('nameplate' .. i) then
			if xVermin.Class == 'HUNTER' and UnitExists('pet') then
				if IsSpellInRange('Bite', 'pet', 'nameplate' .. i) == 1 then
					inRange = inRange + 1
				end
			else
				minRange, maxRange = xGetRange('nameplate' .. i)
				if maxRange and maxRange <= range then
					inRange = inRange + 1
				end
			end
		end
	end
	return inRange
end

local buffs = {
	['Feign Dead'] = true
}

local skills_range = {
	['HUNTER'] = 5,
	['MAGE'] = 5,
	['WARLOCK'] = 5,
	['SHAMAN'] = 5,
	['WARRIOR'] = 5,
	['PALADIN'] = 5,
	['DEATHKNIGHT'] = 5,
	['ROGUE'] = 5,
	['DRUID'] = 5
}

-----------------------------------------------------------------------------------------------------------------------------
-- AOE TARGETS
-----------------------------------------------------------------------------------------------------------------------------

aoe = CreateFrame('Frame', 'AOE_TARGETS')
aoe:SetPoint('RIGHT', PlayerFrame, 'LEFT', 15, 3)
aoe:SetWidth(0)
aoe:SetHeight(0)
aoe.text = aoe:CreateFontString(nil, 'ARTWORK')
aoe.text:SetFont(xVermin.Config.font.arial, 22, 'NONE')
aoe.text:SetPoint('CENTER', AOE_TARGETS, 'CENTER', 0, 0)
aoe.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

local aoe_number
xVermin:CheckIfLoadedWithTimer(
	'RotationFrame1',
	function()
		-- white -> skip
		-- green -> single target
		-- red -> aoe
		PlayerFrame:HookScript(
			'OnUpdate',
			function()
				haveBuff = false

				for buff in pairs(buffs) do
					for i = 1, 40 do
						local B = UnitBuff('player', i)
						if B and B == buff then
							haveBuff = true
						end
					end
				end

				aoe_number = 0
				if IsAltKeyDown() or ChatFrame1EditBox:IsVisible() or IsMounted() or haveBuff then
					RotationFrame1:SetBackdropColor(1, 1, 1, 1) -- white
				else
					if InCombatLockdown() then
						aoe_number = AOE(skills_range[xVermin.Class])
						if aoe_number > 1 then
							RotationFrame1:SetBackdropColor(1, 0, 0, 1) -- red --> DO AOE
						else
							RotationFrame1:SetBackdropColor(0, 1, 0, 1) -- green --> DO SINGLE TARGET
						end
					else
						RotationFrame1:SetBackdropColor(1, 1, 1, 1) -- white --> OOC
					end
				end
				aoe.text:SetText(aoe_number)
				aoe:SetWidth(aoe.text:GetStringWidth())
				aoe:SetHeight(aoe.text:GetStringHeight())
			end
		)
	end
)

-- Courtesy of Wopak - [url]http://www.ownedcore.com/forums/members/309249-wopak.html[/url]
-- This function doesn't require any PLUA unlocker or any other kind of hack
-- ARGUMENTS
---- name - Name of a spell (string)
---- unit - A unit to target with the spell (string, [url=http://wowprogramming.com/docs/api_types#unitID]API Meta-Types - World of Warcraft Programming: A Guide and Reference for Creating WoW Addons[/url])
---- unit will default to target if left empty
-- RETURN VALUES
---- 1 if the player is near enough to cast the spell on the unit; 0 if not in range; nil if the unit is not a valid target for the spell (1nil)
-- function fawIsSpellInRange(spell, unit)
-- 	if spell == nil then
-- 		return nil
-- 	end
-- 	if unit == nil then
-- 		unit = 'target'
-- 	end

-- 	-- Using WoW's standard API first, because Tricks of the Trade is bugged when passing it's spell index
-- 	-- So only going further down the function the spell's that returns nil
-- 	-- I this returns nil is if the unit is not a valid target for the spell (or you have no target selected)
-- 	local inRange = IsSpellInRange(spell, unit)

-- 	-- Collecting the Spell GLOBAL SpellID, not to be confused with the SpellID
-- 	-- Matching the Spell Name and the GLOBAL SpellID will give us the Spellbook index of the Spell
-- 	-- With the Spellbook index, we can then proceed to do a proper IsSpellInRange with the index.
-- 	if inRange == nil then
-- 		local myIndex = nil
-- 		local name, texture, offset, numSpells, isGuild = GetSpellTabInfo(2)
-- 		local booktype = 'spell'
-- 		for index = offset + 1, numSpells + offset do
-- 			-- Get the Global Spell ID from the Player's spellbook
-- 			local spellID = select(2, GetSpellBookItemInfo(index, booktype))
-- 			if spellID and spell == GetSpellBookItemName(index, booktype) then
-- 				myIndex = index
-- 				break -- Breaking out of the for/do loop, because we have a match
-- 			end
-- 		end

-- 		-- If the Spell wasn't found, we're checking if we have a Pet Spellbook
-- 		-- If a Pet Spellbook is found, do the same as above and try to get an Index on the Spell
-- 		local numPetSpells = HasPetSpells()
-- 		if myIndex == nil and numPetSpells then
-- 			booktype = 'pet'
-- 			for index = 1, numPetSpells do
-- 				-- Get the Global Spell ID from the Pet's spellbook
-- 				local spellID = select(2, GetSpellBookItemInfo(index, booktype))
-- 				if spellID and spell == GetSpellBookItemName(index, booktype) then
-- 					myIndex = index
-- 					break -- Breaking out of the for/do loop, because we have a match
-- 				end
-- 			end
-- 		end

-- 		if myIndex then
-- 			return IsSpellInRange(myIndex, booktype, unit)
-- 		end
-- 		return inRange
-- 	end
-- 	return inRange
-- end

-- PetBasicAttacks = {
-- 	17253, -- Bite
-- 	16827, -- Claw
-- 	49966 -- Smack
-- }
-- function PetInRange(unit)
-- 	if UnitExists(unit) and UnitExists('pet') then
-- 		for i = 1, #PetBasicAttacks do
-- 			print(GetSpellInfo(PetBasicAttacks[i]), IsSpellInRange(GetSpellInfo(PetBasicAttacks[i]), unit))
-- 		end
-- 	end
-- end

-- TargetFrame:HookScript(
-- 	'OnUpdate',
-- 	function()
-- 		PetInRange('target')
-- 	end
-- )
