local _, xVermin = ...

local function AddSpellID(self, unit, index, filter)
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
hooksecurefunc(GameTooltip, 'SetUnitAura', AddSpellID)
hooksecurefunc(GameTooltip, 'SetUnitBuff', AddSpellID)
hooksecurefunc(GameTooltip, 'SetUnitDebuff', AddSpellID)
GameTooltip:HookScript('OnTooltipSetSpell', AddSpellID)
