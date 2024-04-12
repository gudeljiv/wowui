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


_G.ShowTotemBars = false
xVermin.CheckIfLoadedWithTimer(
	'XiTimers_Timer1',
	function()
		TT_ActionButton11:HookScript(
			'OnShow',
			function(self)
				_G.ShowTotemBars = true
			end
		)
		TT_ActionButton11:HookScript(
			'OnHide',
			function(self)
				_G.ShowTotemBars = false
			end
		)
		TT_ActionButton21:HookScript(
			'OnShow',
			function(self)
				_G.ShowTotemBars = true
			end
		)
		TT_ActionButton21:HookScript(
			'OnHide',
			function(self)
				_G.ShowTotemBars = false
			end
		)
		TT_ActionButton31:HookScript(
			'OnShow',
			function(self)
				_G.ShowTotemBars = true
			end
		)
		TT_ActionButton31:HookScript(
			'OnHide',
			function(self)
				_G.ShowTotemBars = false
			end
		)
		TT_ActionButton41:HookScript(
			'OnShow',
			function(self)
				_G.ShowTotemBars = true
			end
		)
		TT_ActionButton41:HookScript(
			'OnHide',
			function(self)
				_G.ShowTotemBars = false
			end
		)
	end
)
-- UIParent:HookScript(
-- 	'OnUpdate',
-- 	function(self)
-- 		print(_G.TotemBarShow)
-- 	end
-- )

-- hooksecurefunc(TTActionBars, "StartCast", function(...) print(...) end)