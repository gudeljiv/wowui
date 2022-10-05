local _, xVermin = ...

xVermin:CheckIfLoadedWithTimer(
	'RXPFrame',
	function()
		if not RXPFrame.SetBackdrop then
			Mixin(RXPFrame, BackdropTemplateMixin)
		end

		RXPFrame:ClearAllPoints()
		RXPFrame:SetPoint('BOTTOMRIGHT', 'ChatFrame3', 'BOTTOMLEFT', 0, -10)
	end
)
