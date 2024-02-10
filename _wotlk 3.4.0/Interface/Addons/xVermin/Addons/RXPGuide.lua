local _, xVermin = ...
local ib

xVermin.CheckIfLoadedWithTimer(
	'RXPFrame',
	function()
		if not RXPFrame.SetBackdrop then
			Mixin(RXPFrame, BackdropTemplateMixin)
		end

		RXPFrame:ClearAllPoints()
		RXPFrame:SetPoint('BOTTOMRIGHT', 'ChatFrame3', 'BOTTOMLEFT', 0, -10)

		RXPItemFrame:HookScript(
			'OnUpdate',
			function(self)
				local in_instance, type_of_instance = IsInInstance()

				if in_instance or UnitInRaid('player') then
					if RXPFrame:IsVisible() then
						RXPFrame:Hide()
					end
					if RXPItemFrame:IsVisible() then
						RXPItemFrame:Hide()
					end
				else
					if not RXPFrame:IsVisible() then
						RXPFrame:Show()
					end
					if not RXPItemFrame:IsVisible() then
						RXPItemFrame:Show()
					end
				end

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
	end
)
