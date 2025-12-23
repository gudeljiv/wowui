local _, xVermin = ...

-- xVermin.CheckIfLoadedWithTimer(
-- 	'RingMenuRingFrame1',
-- 	function()

-- 		RingMenuRingFrame1:HookScript(
-- 			'OnShow',
-- 			function()
-- 				if InCombatLockdown() then
-- 					return
-- 				end
-- 				RingMenuRingFrame1:ClearAllPoints()
-- 				RingMenuRingFrame1:SetPoint("CENTER", UIParent, "BOTTOMLEFT", UIParent:GetWidth() / 2 + 400, UIParent:GetHeight() / 2 + 250)
-- 			end
-- 		)

-- 	end
-- )


xVermin.CheckIfLoadedWithTimer(
	'RadialWheel1',
	function()

		RadialWheel1:HookScript(
			'OnShow',
			function()
				if InCombatLockdown() then
					return
				end
				RadialWheel1:ClearAllPoints()
				RadialWheel1:SetPoint("CENTER", UIParent, "BOTTOMLEFT", UIParent:GetWidth() / 2 + 400, UIParent:GetHeight() / 2 + 250)


				for i = 1, 20 do
					local button = _G["RadialWheel1Slot"..i]
					if button then
						button:CreateBeautyBorder(8)
					end
				end
			end
		)

	end
)


