local _, xVermin = ...

local function HandleItem(self, unit, index, filter)
	local _, id
	if unit then
		_, _, _, _, _, _, _, _, _, id = UnitAura(unit, index, filter)
	else
		_, id = self:GetSpell()
	end
	if id then
		self:AddLine(' ')
		self:AddLine(_G.ORANGE_FONT_COLOR_CODE .. 'Spell ID: ' .. _G.NORMAL_FONT_COLOR_CODE .. id)
	end
	self:Show()
end
hooksecurefunc(GameTooltip, 'SetUnitAura', HandleItem)
hooksecurefunc(GameTooltip, 'SetUnitBuff', HandleItem)
hooksecurefunc(GameTooltip, 'SetUnitDebuff', HandleItem)
GameTooltip:HookScript('OnTooltipSetSpell', HandleItem)
