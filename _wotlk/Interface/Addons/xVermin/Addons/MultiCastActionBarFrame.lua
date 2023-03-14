local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer(
	'MultiCastActionBarFrame and MultiBarBottomRightButton1',
	function()
		local UpdateMultiCastActionBarFrame = function()
			MultiCastActionBarFrame:ClearAllPoints()
			MultiCastActionBarFrame:SetPoint('BOTTOMLEFT', MultiBarBottomRightButton1, 'TOPLEFT', 0, 5)
		end

		UpdateMultiCastActionBarFrame()
		local f = CreateFrame('Frame')
		f:RegisterEvent('PLAYER_ENTERING_WORLD')
		f:RegisterEvent('PLAYER_REGEN_DISABLED')
		f:RegisterEvent('PLAYER_REGEN_ENABLED')
		f:SetScript('OnEvent', UpdateMultiCastActionBarFrame)
		-- UIParent:HookScript('OnUpdate', Update_Questie_BaseFrame)

		-- hooksecurefunc(
		-- 	'ActionButton_UpdateHotkeys',
		-- 	function(self)
		-- 		UpdateMultiCastActionBarFrame()
		-- 	end
		-- )
	end
)
