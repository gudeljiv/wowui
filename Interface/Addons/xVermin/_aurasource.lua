local _, config = ...

if not config.auraSource then
	return
end

local function addAuraSource(self, func, unit, index, filter)
	local srcUnit = select(8, func(unit, index, filter))
	if srcUnit then
		self:AddLine(" ")

		local src = GetUnitName(srcUnit, true)
		if srcUnit == "pet" or srcUnit == "vehicle" then
			local color = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
			src =
				format("%s (|cff%02x%02x%02x%s|r)", src, color.r * 255, color.g * 255, color.b * 255, GetUnitName("player", true))
		else
			local partypet = srcUnit:match("^partypet(%d+)$")
			local raidpet = srcUnit:match("^raidpet(%d+)$")
			if partypet then
				src = format("%s (%s)", src, GetUnitName("party" .. partypet, true))
			elseif raidpet then
				src = format("%s (%s)", src, GetUnitName("raid" .. raidpet, true))
			end
		end

		if (UnitIsPlayer(srcUnit)) then
			local color = RAID_CLASS_COLORS[select(2, UnitClass(srcUnit))]
			if (color) then
				src = format("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, src)
			end
		end

		self:AddLine(src)
		self:Show()
	end
end

local funcs = {
	SetUnitAura = UnitAura,
	SetUnitBuff = UnitBuff,
	SetUnitDebuff = UnitDebuff
}

for k, v in pairs(funcs) do
	hooksecurefunc(
		GameTooltip,
		k,
		function(self, unit, index, filter)
			addAuraSource(self, v, unit, index, filter)
		end
	)
end
