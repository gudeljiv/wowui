local _, xVermin = ...
local ib, numQuests

local width = 235

xVermin:CheckIfLoadedWithTimer(
	'Questie_BaseFrame',
	function()
		if not Questie_BaseFrame.SetBackdrop then
			Mixin(Questie_BaseFrame, BackdropTemplateMixin)
		end

		Questie_BaseFrame:HookScript(
			'OnUpdate',
			function(self)
				if InCombatLockdown() then
					return
				end

				_, numQuests = GetNumQuestLogEntries()
				if numQuests > 0 then
					if not Questie_BaseFrame:IsVisible() then
						Questie_BaseFrame:Show()
					end
				else
					if Questie_BaseFrame:IsVisible() then
						Questie_BaseFrame:Hide()
					end
				end

				Questie_BaseFrame:CreateBeautyBorder(8)
				Questie_BaseFrame:SetBackdrop(
					{
						bgFile = 'Interface\\Buttons\\WHITE8x8',
						edgeFile = '',
						tile = false,
						tileSize = 0,
						edgeSize = 0,
						insets = {left = 0, right = 0, top = 0, bottom = 0}
					}
				)
				Questie_BaseFrame:SetBackdropColor(0, 0, 0, 0.6)
				Questie_BaseFrame:ClearAllPoints()
				Questie_BaseFrame:SetPoint('TOPRIGHT', 'CustomContainer_2', 'BOTTOMRIGHT', 0, -10)
				Questie_BaseFrame.ClearAllPoints = function()
				end
				Questie_BaseFrame.SetPoint = function()
				end

				if (Questie_BaseFrame:GetWidth() < width) then
					Questie_BaseFrame:SetWidth(width)
				end

				TomTomCrazyArrow:SetPoint('TOPRIGHT', self, 'TOPLEFT', -20, -10)

				for i = 1, 32 do
					ib = _G['Questie_ItemButton' .. i]
					if ib then
						ib:CreateBeautyBorder(6)
					end
				end
			end
		)
	end
)
