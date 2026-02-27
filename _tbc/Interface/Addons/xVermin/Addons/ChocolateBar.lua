local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer("ChocolateBar1 and CustomContainer_1", function()
	ChocolateBar1:ClearAllPoints()
	ChocolateBar1:SetPoint("LEFT", CustomContainer_1, "LEFT", 5, 0)
	ChocolateBar1:SetWidth(145)
end)

xVermin.CheckIfLoadedWithTimer("ChocolateBar2 and CustomContainer_1", function()
	ChocolateBar2:ClearAllPoints()
	ChocolateBar2:SetPoint("LEFT", CustomContainer_2, "LEFT", 5, 0)
	ChocolateBar2:SetWidth(145)
end)
