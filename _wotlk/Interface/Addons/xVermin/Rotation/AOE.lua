local _, xVermin = ...
local minRange, maxRange, unitcasting, unit, inRange, range, targetcasting, rangecasting

local t = {
	'Critter',
	-- 'Not specified',
	'Totem',
	'Non-combat Pet',
	'Gas Cloud'
}

-- 1 = Inspect, 28 yards
-- 2 = Trade, 11.11 yards
-- 3 = Duel, 9.9 yards
-- 4 = Follow, 28 yards
xVermin.AOE = function(range, casting)
	range = range or 5
	inRange = 0
	rangecasting = 0
	casting = casting or false

	for i = 1, 40 do
		unit = 'nameplate' .. i

		if UnitExists(unit) and not xVermin.HasValue(t, UnitCreatureType(unit)) then
			-- print(unit, UnitExists(unit), UnitCreatureType(unit), not xVermin.HasValue(t, UnitCreatureType(unit)), xVermin.GetRange(unit))
			unitcasting = xVermin.IfUnitIsCastingInteruptable(unit)
			targetcasting = xVermin.IfUnitIsCastingInteruptable('target')

			if unitcasting then
				if not targetcasting then
					rangecasting = rangecasting + 1
				else
					if xVermin.Class == 'WARRIOR' then
						local _, battle = GetShapeshiftFormInfo(1) -- ako je battle stance
						local _, defensive = GetShapeshiftFormInfo(2) -- ako je defensive stance
						local _, berserker = GetShapeshiftFormInfo(3) -- ako je berserker stance
						if defensive or (battle and IsEquippedItemType('Shields')) then
							if IsSpellInRange('Shield Bash', 'target') == 0 or select(2, GetSpellCooldown('Shield Bash')) > 0 then
								rangecasting = rangecasting + 1
							end
						end
					end
					if xVermin.Class == 'DEATHKNIGHT' then
						if IsSpellInRange('Mind Freeze', 'target') == 0 or select(2, GetSpellCooldown('Mind Freeze')) > 0 then
							rangecasting = rangecasting + 1
						end
					end
					if xVermin.Class == 'SHAMAN' then
						if IsSpellInRange('Wind Shear', 'target') == 0 or select(2, GetSpellCooldown('Wind Shear')) > 0 then
							rangecasting = rangecasting + 1
						end
					end
				end
			end

			-- if xVermin.Class == 'xHUNTER' and UnitExists('pet') then
			-- 	if IsSpellInRange('Bite', 'pet', unit) == 1 then
			-- 		inRange = inRange + 1
			-- 	end
			-- else
			minRange, maxRange = xVermin.GetRange(unit)
			if maxRange and maxRange <= range then
				inRange = inRange + 1
			end
		-- print(unit, inRange, rangecasting)
		-- end
		end
	end
	if rangecasting > 0 then
		RotationFrame_AOERANGECASTING:SetBackdropColor(0, 1, 0.5, 1)
	else
		RotationFrame_AOERANGECASTING:SetBackdropColor(1, 1, 1, 1)
	end
	return casting and rangecasting or inRange
end
xAOE = xVermin.AOE

local buffs = {
	['Feign Dead'] = true
}

local skills_range = {
	['HUNTER'] = 10,
	['MAGE'] = 10,
	['WARLOCK'] = 10,
	['SHAMAN'] = 10,
	['WARRIOR'] = 5,
	['PALADIN'] = 10,
	['DEATHKNIGHT'] = 10,
	['ROGUE'] = 10,
	['DRUID'] = 10
}

-----------------------------------------------------------------------------------------------------------------------------
-- AOE TARGETS
-----------------------------------------------------------------------------------------------------------------------------

-- aoe:SetPoint('RIGHT', PlayerFrame, 'LEFT', 15, 3)
-- aoe_casting:SetPoint('RIGHT', PlayerFrame, 'LEFT', 21, 4)

local aoe = CreateFrame('Frame', 'AOE_TARGETS')
aoe:SetPoint('CENTER', UIParent, 'CENTER', -55, -30)
aoe:SetWidth(50)
aoe:SetHeight(50)
aoe.text = aoe:CreateFontString(aoe:GetName() .. 'Title', 'BACKGROUND')
aoe.text:SetFont(xVermin.Config.font.arial, 18, 'NONE')
aoe.text:SetPoint('CENTER', aoe, 'CENTER', 0, 0)
aoe.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

aoe.text:SetShadowColor(0, 0, 0, 1.0)
aoe.text:SetShadowOffset(2, -2)

local aoe_casting = CreateFrame('Frame', 'AOE_TARGETS_CASTING')
aoe_casting:SetPoint('CENTER', UIParent, 'CENTER', 55, -30)
aoe_casting:SetWidth(50)
aoe_casting:SetHeight(50)
aoe_casting.text = aoe_casting:CreateFontString(aoe_casting:GetName() .. 'Title', 'BACKGROUND')
aoe_casting.text:SetFont(xVermin.Config.font.arial, 18, 'NONE')
aoe_casting.text:SetPoint('CENTER', aoe_casting, 'CENTER', 0, 0)
aoe_casting.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

aoe_casting.text:SetShadowColor(0, 0, 0, 1.0)
aoe_casting.text:SetShadowOffset(2, -2)

local aoe_number, aoe_casting_number

UIParent:HookScript(
	'OnUpdate',
	function()
		-- local red, green, blue, alpha = RotationFrame_AOERANGECASTING:GetBackdropColor()
		-- ChatFrame7:AddMessage(xVermin.Round(red, 2) .. ' ' .. xVermin.Round(green, 2) .. ' ' .. xVermin.Round(blue, 2))

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
		aoe_casting_number = 0

		if IsAltKeyDown() or ChatFrame1EditBox:IsVisible() or IsMounted() or haveBuff then
			RotationFrame2:SetBackdropColor(1, 1, 1, 1) -- white
		else
			if InCombatLockdown() then
				aoe_number = xVermin.AOE(skills_range[xVermin.Class], false)
				aoe_casting_number = xVermin.AOE(35, true)
				if aoe_number > 1 then
					RotationFrame2:SetBackdropColor(1, 0, 0, 1) -- red --> DO AOE
				else
					RotationFrame2:SetBackdropColor(0, 1, 0, 1) -- green --> DO SINGLE TARGET
				end
			else
				RotationFrame2:SetBackdropColor(1, 1, 1, 1) -- white --> OOC
			end
		end

		aoe.text:SetText(aoe_number)
		aoe_casting.text:SetText(aoe_casting_number)
	end
)
