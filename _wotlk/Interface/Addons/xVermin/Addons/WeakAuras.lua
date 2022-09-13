local _, xVermin = ...

local function print_children(frame)
	-- print("amount children: " .. frame:GetNumChildren())
	local children = {frame:GetChildren()}

	for key, child in ipairs(children) do
		local name = child:GetName() or child:GetDebugName()

		-- child:CreateBeautyBorder(8)

		if child:GetNumChildren() and frame:GetNumChildren() > 0 then
			print_children(child)
		end
	end
end

-- C_Timer.NewTicker(1, function(self)
-- 	print(1)
-- 	if WeakAurasFrame then
-- 		self:Cancel()
-- 		print_children(WeakAurasFrame)
-- 	end
-- end)
