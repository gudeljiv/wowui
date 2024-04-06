local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer(
	'ECS_StatsFrame',
	function()
		ECS_StatsFrame:SetWidth(200)

		CharacterFrame:HookScript(
			"OnShow",
			function()
				ECS_StatsFrame:ClearAllPoints()
				ECS_StatsFrame:HookScript(
					"OnUpdate",
					function()
						if EngravingFrame:IsVisible() then
							ECS_StatsFrame:SetPoint("TOPLEFT", EngravingFrame, "TOPRIGHT", 15, 45)
						else
							ECS_StatsFrame:SetPoint("TOPLEFT", CharacterFrame, "TOPRIGHT", -25, -15)
						end
					end
				)
			end
		)

	end
)
