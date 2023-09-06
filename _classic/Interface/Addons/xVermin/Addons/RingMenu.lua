local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer(
	'RingMenuRingFrame1',
	function()

		RingMenuRingFrame1:HookScript(
			'OnShow',
			function()
				RingMenuRingFrame1:ClearAllPoints()
				RingMenuRingFrame1:SetPoint("CENTER", UIParent, "BOTTOMLEFT", UIParent:GetWidth() / 2 + 400, UIParent:GetHeight() / 2 + 250)
			end
		)

	end
)

