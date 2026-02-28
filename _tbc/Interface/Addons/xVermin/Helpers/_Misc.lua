local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer("PlayerCastingBarFrame.timer", function()
	PlayerCastingBarFrame.timer:ClearAllPoints()
	PlayerCastingBarFrame.timer:SetScale(1.2)
	PlayerCastingBarFrame.timer:SetPoint("RIGHT", 34, 2)
end)
