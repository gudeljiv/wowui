local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer(
	'RXPFrame',
	function()
		if not RXPFrame.SetBackdrop then
			Mixin(RXPFrame, BackdropTemplateMixin)
		end

		RXPFrame:ClearAllPoints()
		RXPFrame:SetPoint('BOTTOMRIGHT', 'ChatFrame3', 'BOTTOMLEFT', 0, -10)
	end
)

RXPItemFrame:HookScript(
	'OnUpdate',
	function(self)
		if InCombatLockdown() then
			return
		end

		for i = 1, 10 do
			ib = _G['RXPItemFrameButton' .. i]
			if ib then
				ib:CreateBeautyBorder(6)
			end
		end
	end
)
