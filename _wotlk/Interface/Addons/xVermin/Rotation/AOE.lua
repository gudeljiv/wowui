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
			unitcasting = xVermin.IfUnitIsCastingInteruptable(unit)
			targetcasting = xVermin.IfUnitIsCastingInteruptable('target')

			if unitcasting then
				if not targetcasting then
					rangecasting = rangecasting + 1
				else
					if (xVermin.Class == 'WARRIOR') then
						local _, battle = GetShapeshiftFormInfo(1) -- ako je battle stance
						local _, defensive = GetShapeshiftFormInfo(2) -- ako je defensive stance
						local _, berserker = GetShapeshiftFormInfo(3) -- ako je berserker stance
						if defensive or (battle and IsEquippedItemType('Shields')) then
							if IsSpellInRange('Shield Bash', 'target') == 0 or select(2, GetSpellCooldown('Shield Bash')) > 0 then
								rangecasting = rangecasting + 1
							end
						end
					end
					if (xVermin.Class == 'DEATHKNIGHT') then
						if IsSpellInRange('Mind Freeze', 'target') == 0 or select(2, GetSpellCooldown('Mind Freeze')) > 0 then
							rangecasting = rangecasting + 1
						end
					end
				end
			end

			if xVermin.Class == 'xHUNTER' and UnitExists('pet') then
				if IsSpellInRange('Bite', 'pet', unit) == 1 then
					inRange = inRange + 1
				end
			else
				minRange, maxRange = xVermin.GetRange(unit)
				if maxRange and maxRange <= range then
					inRange = inRange + 1
				end
			end
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

aoe = CreateFrame('Frame', 'AOE_TARGETS')
aoe:SetPoint('RIGHT', PlayerFrame, 'LEFT', 15, 3)
aoe:SetWidth(0)
aoe:SetHeight(0)
aoe.text = aoe:CreateFontString(nil, 'ARTWORK')
aoe.text:SetFont(xVermin.Config.font.arial, 22, 'NONE')
aoe.text:SetPoint('CENTER', AOE_TARGETS, 'CENTER', 0, 0)
aoe.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

aoe_casting = CreateFrame('Frame', 'AOE_TARGETS_CASTING')
aoe_casting:SetPoint('RIGHT', PlayerFrame, 'LEFT', 21, 4)
aoe_casting:SetWidth(0)
aoe_casting:SetHeight(0)
aoe_casting.text = aoe_casting:CreateFontString(nil, 'ARTWORK')
aoe_casting.text:SetFont(xVermin.Config.font.arial, 8, 'NONE')
aoe_casting.text:SetPoint('CENTER', AOE_TARGETS_CASTING, 'CENTER', 0, 0)
aoe_casting.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

local aoe_number, aoe_casting_number
xVermin.CheckIfLoadedWithTimer(
	'RotationFrame2',
	function()
		-- white -> skip
		-- green -> single target
		-- red -> aoe
		PlayerFrame:HookScript(
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
						aoe_number = xVermin.AOE(skills_range[xVermin.Class])
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
				aoe:SetWidth(aoe.text:GetStringWidth())
				aoe:SetHeight(aoe.text:GetStringHeight())

				aoe_casting.text:SetText(aoe_casting_number)
				aoe_casting:SetWidth(aoe_casting.text:GetStringWidth())
				aoe_casting:SetHeight(aoe_casting.text:GetStringHeight())
			end
		)
	end
)
