local _, Rotation = ...

local f = CreateFrame("Frame", "Frame")

PlayerFrame:HookScript(
	"OnUpdate",
	function()
		-- if Rotation.AOE() then
		-- 	print("aoe")
		-- else
		-- 	print("single target")
		-- end
	end
)
