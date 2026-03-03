local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer("PlayerCastingBarFrame.timer", function()
	PlayerCastingBarFrame.timer:ClearAllPoints()
	PlayerCastingBarFrame.timer:SetScale(1.2)
	PlayerCastingBarFrame.timer:SetPoint("LEFT", PlayerCastingBarFrame, "RIGHT", 10, 2)
end)
