local _, xVermin = ...
local count

count = 0
C_Timer.NewTicker(
	1,
	function(self)
		if (count > 10) then
			self:Cancel()
		end

		if (ChocolateBar1 and CustomContainer_1) then
			ChocolateBar1:ClearAllPoints()
			ChocolateBar1:SetPoint('LEFT', CustomContainer_1, 'LEFT', 5, 0)
			ChocolateBar1:SetWidth(145)
			self:Cancel()
		end
	end
)

count = 0
C_Timer.NewTicker(
	1,
	function(self)
		if (count > 10) then
			self:Cancel()
		end

		if (ChocolateBar2 and CustomContainer_1) then
			ChocolateBar2:ClearAllPoints()
			ChocolateBar2:SetPoint('LEFT', CustomContainer_2, 'LEFT', 5, 0)
			ChocolateBar2:SetWidth(145)
			self:Cancel()
		end
	end
)
