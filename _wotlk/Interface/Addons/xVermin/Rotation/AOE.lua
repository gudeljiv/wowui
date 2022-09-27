local _, xVermin = ...

function AOE(type, skill)
	local type = type or 'bool'
	local skill = skill or 'Heroic Strike'
	local inRange = 0

	for i = 1, 10 do
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
	['WARRIOR'] = 'Cleave',
	['PALADIN'] = 'Divine Storm',
	['DEATHKNIGHT'] = 'Heart Strike',
	['ROGUE'] = 'Sinister Strike',
	['DRUID'] = 'Maul'
}

local count = 0
C_Timer.NewTicker(
	1,
	function(self)
		if (count > 10) then
			self:Cancel()
		end
		count = count + 1

		if RotationFrame1 then
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

					if IsAltKeyDown() or ChatFrame1EditBox:IsVisible() or IsMounted() or haveBuff then
						RotationFrame1:SetBackdropColor(1, 1, 1, 1) -- white
					else
						if InCombatLockdown() then
							if AOE(skills[xVermin.Class]) then
								RotationFrame1:SetBackdropColor(1, 0, 0, 1) -- red --> DO AOE
							else
								RotationFrame1:SetBackdropColor(0, 1, 0, 1) -- green --> DO SINGLE TARGET
							end
						else
							RotationFrame1:SetBackdropColor(1, 1, 1, 1) -- white --> OOC
						end
					end
				end
			)

			self:Cancel()
		end
	end
)
