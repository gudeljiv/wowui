local _, xVermin = ...

xVermin.Threat = function(unit)
	unit = unit and unit or "target"

	local isTanking, status, scaledPercentage, rawPercentage, threatValue = UnitDetailedThreatSituation("player", unit)

	if InCombatLockdown() and UnitExists(unit) then
		return xVermin.Round(scaledPercentage, 0)
	else
		return 0
	end
end
xThreat = xVermin.Threat

local f = CreateFrame("Frame")
f:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
f:SetScript("OnEvent", function(self, event, unit)
	if unit == "target" then
		xVermin.Threat("target")
	end
end)
