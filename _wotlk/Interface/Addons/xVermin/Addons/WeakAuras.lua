local _, xVermin = ...

-- local function print_children(frame)
-- 	-- print("amount children: " .. frame:GetNumChildren())
-- 	local children = {frame:GetChildren()}

-- 	for key, child in ipairs(children) do
-- 		local name = child:GetName() or child:GetDebugName()

-- 		if name:match('.icon') then
-- 			child:CreateBeautyBorder(8)
-- 			print(name)
-- 		end

-- 		if child:GetNumChildren() and frame:GetNumChildren() > 0 then
-- 			print_children(child)
-- 		end
-- 	end
-- end

-- local count = 0
-- C_Timer.NewTicker(
-- 	1,
-- 	function(self)
-- 		if (count > xVermin.WaitTimeUntillAddonLoaded) then
-- 			self:Cancel()
-- 		end
-- 		count = count + 1

-- 		if WeakAurasFrame then
-- 			print_children(WeakAurasFrame)
-- 			self:Cancel()
-- 		end
-- 	end
-- )
