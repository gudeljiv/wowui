local _, xVermin = ...

local function ProcessAura(tooltip, func, ...)
	local ok, _, _, _, _, _, _, caster = pcall(func, ...) --	Going to let the function validate args (an error should've already been thrown if invalid, just ignore it here)
	if ok and caster then
		local pet = caster
		caster = (UnitIsUnit(caster, 'pet') and 'player' or caster:gsub('[pP][eE][tT]', ''))
		if caster then
			tooltip:AddDoubleLine(
				' ',
				(pet == caster and '|cffffc000Source:|r %s' or '|cffffc000Source:|r %s (%s)'):format(UnitName(caster), UnitName(pet)),
				1,
				0.975,
				0,
				xVermin.ClassColor.r,
				xVermin.ClassColor.g,
				xVermin.ClassColor.b
			)
		end
		tooltip:Show()
	end
end

local GTT_Meta = getmetatable(GameTooltip).__index
hooksecurefunc(
	GTT_Meta,
	'SetUnitAura',
	function(self, ...)
		return ProcessAura(self, UnitAura, ...)
	end
)
hooksecurefunc(
	GTT_Meta,
	'SetUnitBuff',
	function(self, ...)
		return ProcessAura(self, UnitBuff, ...)
	end
)
hooksecurefunc(
	GTT_Meta,
	'SetUnitDebuff',
	function(self, ...)
		return ProcessAura(self, UnitDebuff, ...)
	end
)
