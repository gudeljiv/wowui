local _, xVermin = ...

local function spellid(self, unit, index, filter)
	local _, id
	if unit then
		_, _, _, _, _, _, _, _, _, id = UnitAura(unit, index, filter)
	else
		_, id = self:GetSpell()
	end
	if id then
		self:AddLine('|cff789ABCSpellID: ' .. id .. '|r')
	end
	self:Show()
end
hooksecurefunc(GameTooltip, 'SetUnitAura', spellid)
hooksecurefunc(GameTooltip, 'SetUnitBuff', spellid)
hooksecurefunc(GameTooltip, 'SetUnitDebuff', spellid)
GameTooltip:HookScript('OnTooltipSetSpell', spellid)
