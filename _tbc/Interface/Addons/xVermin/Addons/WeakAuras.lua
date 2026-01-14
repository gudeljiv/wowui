local _, xVermin = ...

function print_children(frame)
	print('amount children: ' .. frame:GetNumChildren())
	local children = {frame:GetChildren()}

	for key, child in ipairs(children) do
		local name = child:GetName() or child:GetDebugName()

		ChatFrame7:AddMessage(name)

		if child:GetNumChildren() and frame:GetNumChildren() > 0 then
			print_children(child)
		end
	end
end

-- xVermin.CheckIfLoadedWithTimer(
-- 	WeakAurasFrame,
-- 	function()
-- 		print_children(WeakAurasFrame)
-- 	end
-- )
