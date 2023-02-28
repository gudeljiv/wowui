local _, xVermin = ...

local SwingTimerMonitor = CreateFrame('Frame')
local myGUID = UnitGUID('player')
local lastMH, lastOH, nextMH, nextOH = 0, 0, 0, 0

SwingTimerMonitor:SetScript(
	'OnEvent',
	function(self, event, _, subtype, _, sourceGUID, ...)
		if event == 'COMBAT_LOG_EVENT_UNFILTERED' and subtype:sub(1, 5) == 'SWING' and sourceGUID == myGUID then
			local offhand = select(17, ...)

			if offhand then
				lastOH = GetTime()
				nextOH = lastOH + select(2, UnitAttackSpeed('player'))
			else
				lastMH = GetTime()
				nextMH = lastMH + UnitAttackSpeed('player')
			end
		end
	end
)

local SwingTimer = function(offhand)
	local now = GetTime()

	if offhand then
		return max(0, nextOH - now)
	end

	return max(0, nextMH - now), max(0, nextOH - now)
end

xSwingTimer = SwingTimer

-- UIParent:HookScript(
-- 	'OnUpdate',
-- 	function()
-- 		print(SwingTimer())
-- 	end
-- )
