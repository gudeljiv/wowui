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
		local tta = {
			"TT_ActionButton11", "TT_ActionButton21", "TT_ActionButton31", "TT_ActionButton41",
			"TT_ActionButton12", "TT_ActionButton22", "TT_ActionButton32", "TT_ActionButton42",
			"TT_ActionButton13", "TT_ActionButton23", "TT_ActionButton33", "TT_ActionButton43",
			"TT_ActionButton14", "TT_ActionButton24", "TT_ActionButton34", "TT_ActionButton44",
			"TT_ActionButton15", "TT_ActionButton25", "TT_ActionButton35", "TT_ActionButton45",
			"TT_ActionButton16", "TT_ActionButton26", "TT_ActionButton36", "TT_ActionButton46",
			"TT_ActionButton17", "TT_ActionButton27", "TT_ActionButton37", "TT_ActionButton47",
			"TT_ActionButton18", "TT_ActionButton28", "TT_ActionButton38", "TT_ActionButton48",
			"TT_ActionButton19", "TT_ActionButton29", "TT_ActionButton39", "TT_ActionButton49",
		}
		for _, timerName in ipairs(tta) do
			if not _G[timerName] then 
				return false 
			end
			
			_G[timerName]:HookScript('OnShow', function(self)
				_G.ShowTotemBars = true
			end)
		
			_G[timerName]:HookScript('OnHide', function(self)
				_G.ShowTotemBars = false
			end)
		end

		local xt = {
			"XiTimers_Timer1",
			"XiTimers_Timer2",
			"XiTimers_Timer3",
			"XiTimers_Timer4"
		}
		for _, timerName in ipairs(xt) do
			if not _G[timerName] then 
				return false 
			end

			_G[timerName]:HookScript('OnEnter', function(self)
				_G.ShowTotemBars = true
			end)
		
			_G[timerName]:HookScript('OnLeave', function(self)
				_G.ShowTotemBars = false
			end)
		end
	end
)

-- UIParent:HookScript(
-- 	'OnUpdate',
-- 	function(self)
-- 		print(_G.TotemBarShow)
-- 	end
-- )

-- hooksecurefunc(TTActionBars, "StartCast", function(...) print(...) end)