local _, xVermin = ...

xVermin.Threat = function(unit)
	unit = unit and unit or 'target'

	local isTanking, status, scaledPercentage, rawPercentage, threatValue = UnitDetailedThreatSituation("player", unit)

	if InCombatLockdown() and UnitExists(unit) then 
		return xVermin.Round(scaledPercentage, 0)
	else
		return 0
	end
end
xThreat = xVermin.Threat


UIParent:HookScript(
	'OnUpdate',
	function()
		if InCombatLockdown() and UnitExists("target") then 
			xVermin.Threat()
		end
	end
)