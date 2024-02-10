local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer(
	'ECS_StatsFrame',
	function()
		ECS_StatsFrame:SetWidth(200)

		-- xVermin.CheckIfLoadedWithTimer(
		-- 	'EngravingFrame',
		-- 	function()

		-- 		EngravingFrame:HookScript(
		-- 			'OnShow',
		-- 			function(self)
		-- 				ECS_StatsFrame:ClearAllPoints()
		-- 				ECS_StatsFrame:SetPoint("TOPLEFT", EngravingFrameSearchBox, "TOPRIGHT", 18, 5)
		-- 			end
		-- 		)

		-- 		EngravingFrame:HookScript(
		-- 			'OnHide',
		-- 			function(self)
		-- 				ECS_StatsFrame:ClearAllPoints()
		-- 				ECS_StatsFrame:SetPoint("TOPLEFT", PaperDollFrame, "TOPRIGHT", -25, -14)
		-- 			end
		-- 		)

		-- 	end
		-- )

	end
)
