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

xVermin.CheckIfLoadedWithTimer(
	'ItemRackMenu',
	hooksecurefunc(ItemRack, "BuildMenu", function() 
		for i = 1, 30 do
			local child = _G['ItemRackMenu' .. i .. 'Count']
			local parent = _G['ItemRackMenu' .. i]
			if parent and child then
				child:SetScale(0.7)
				child:ClearAllPoints()
				child:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -3, -4)
			end
		end
	end)
)

