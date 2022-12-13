local _, xVermin = ...
local irbf

-- IRF = function()
-- 	for i = 1, 30 do
-- 		irbf = _G['ItemRackButton' .. i]
-- 		if irbf then
-- 			irbf:SetPoint('CENTER')
-- 			return
-- 		end
-- 	end

-- 	print('IRF')
-- end

-- hooksecurefunc('CharacterTrinket0Slot.UpdateTooltip', IRF)
-- hooksecurefunc('CharacterTrinket1Slot.UpdateTooltip', IRF)

-- ItemRackButton13:HookScript(
-- 	'OnShow',
-- 	function()
-- 		ItemRackButton13:ClearAllPoints()
-- 		ItemRackButton13:SetPoint('RIGHT', PlayerFrame, 'LEFT', -5, -40)
-- 		ItemRackButton13.SetPoint = function()
-- 		end
-- 	end
-- )

xVermin.CheckIfLoadedWithTimer(
	'LibDBIcon10_ItemRack',
	function()
		LibDBIcon10_ItemRack:Hide()
	end
)
