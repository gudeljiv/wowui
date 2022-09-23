local _, xVermin = ...
local counter = 0

C_Timer.NewTicker(
	300,
	function()
		if (not UnitInBattleground('player')) then
			-- collectgarbage()
			counter = counter + 1
		end
	end
)
