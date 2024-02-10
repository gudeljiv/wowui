local _, xVermin = ...
local counter = 0

C_Timer.NewTicker(
	300,
	function()
		collectgarbage()
		counter = counter + 1
	end
)
