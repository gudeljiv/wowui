local _, xVermin = ...

function AOE(type, skill)
	local type = type or 'bool'
	local skill = skill or 'Pummel'
	local inRange = 0

	for i = 1, 40 do
		if UnitExists('nameplate' .. i) and IsSpellInRange(skill, 'nameplate' .. i) == 1 and CheckInteractDistance('nameplate' .. i, 3) then
			-- 1 = Inspect, 28 yards
			-- 2 = Trade, 11.11 yards
			-- 3 = Duel, 9.9 yards
			-- 4 = Follow, 28 yards
			-- print("nameplate"..i,CheckInteractDistance("nameplate"..i, 3))
			inRange = inRange + 1
		end
	end
	if type == 'bool' then
		if inRange > 1 then
			return true
		else
			return false
		end
	end
	if type == 'number' then
		return inRange
	end
end

local buffs = {
	['Feign Dead'] = true
}

local skills = {
	['HUNTER'] = 'Multi-Shot',
	['MAGE'] = 'Frostbolt',
	['WARLOCK'] = 'Shadowbolt',
	['SHAMAN'] = 'Lightning Bolt',
	['WARRIOR'] = 'Pummel',
	['PALADIN'] = 'Crusader Strike',
	['DEATHKNIGHT'] = 'Heart Strike',
	['ROGUE'] = 'Sinister Strike',
	['DRUID'] = 'Maul'
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
						aoe_number = AOE('number', skills[xVermin.Class])
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
