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
