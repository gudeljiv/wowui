local _, xVermin = ...
local ib, numQuests

local count = 0
local width = 235
C_Timer.NewTicker(
	1,
	function(self)
		if (count > 10) then
			self:Cancel()
		end
		if Questie_BaseFrame then
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
						if not self:IsVisible() then
							self:Show()
						end
					else
						if self:IsVisible() then
							self:Hide()
						end
					end

					self:CreateBeautyBorder(8)
					self:SetBackdrop(
						{
							bgFile = 'Interface\\Buttons\\WHITE8x8',
							edgeFile = '',
							tile = false,
							tileSize = 0,
							edgeSize = 0,
							insets = {left = 0, right = 0, top = 0, bottom = 0}
						}
					)
					self:SetBackdropColor(0, 0, 0, 0.6)
					self:ClearAllPoints()
					self:SetPoint('TOPRIGHT', 'CustomContainer_2', 'BOTTOMRIGHT', 0, -10)
					self.ClearAllPoints = function()
					end
					self.SetPoint = function()
					end

					if (self:GetWidth() < width) then
						self:SetWidth(width)
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

			self:Cancel()
		end
	end
)
