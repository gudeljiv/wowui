local _, xVermin = ...

GameTimeFrame:Hide()

WorldMapFrame:HookScript(
	'OnShow',
	function(self)
		WorldMapFrame:SetFrameStrata("HIGH")
	end
)

xVermin.CheckIfLoadedWithTimer(
	'TimeManagerClockButton',
	function()
		TimeManagerClockButton:SetFrameStrata("HIGH")
		TimeManagerClockButton:SetScale(1)
		TimeManagerClockTicker:SetScale(0.85)
		TimeManagerClockTicker:ClearAllPoints()
		TimeManagerClockTicker:SetPoint("CENTER", TimeManagerClockButton, "CENTER", 0, 0)
	end
)

xVermin.CheckIfLoadedWithTimer(
	'CustomContainer_Combat',
	function()
		FramerateLabel:SetScale(0.8)
		FramerateText:SetScale(0.8)
		FramerateLabel:ClearAllPoints()
		FramerateLabel:SetPoint("TOP", CustomContainer_Combat, "TOP", -15, -22)
	end
)

CharacterRangedSlotCount:SetScale(0.75)



