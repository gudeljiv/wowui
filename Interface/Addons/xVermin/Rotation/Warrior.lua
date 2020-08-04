local _, Rotation = ...

if Rotation.inRange() then
	print("aoe")
else
	print("single target")
end

local f = CreateFrame("Frame", "Frame")

PlayerFrame:HookScript(
	"OnUpdate",
	function()
		-- if Rotation.inRange() then
		-- 	print("aoe")
		-- else
		-- 	print("single target")
		-- end
	end
)
