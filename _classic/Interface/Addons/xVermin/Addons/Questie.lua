local _, xVermin = ...
local ib, numQuests, showQuestieFrame

local width = 235

xVermin.CheckIfLoadedWithTimer(
	'Questie_BaseFrame',
	function()
		if not Questie_BaseFrame.SetBackdrop then
			Mixin(Questie_BaseFrame, BackdropTemplateMixin)
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
		-- Questie_BaseFrame:SetBackdropColor(0, 0, 0, 0.6)
		Questie_BaseFrame:ClearAllPoints()
		Questie_BaseFrame:SetPoint('TOPRIGHT', 'CustomContainer_2', 'BOTTOMRIGHT', 1, -10)
		-- if (Questie_BaseFrame:GetWidth() < width) then
		-- 	Questie_BaseFrame:SetWidth(width)
		-- end

		local function Update_Questie_BaseFrame()
			if InCombatLockdown() then
				return
			end

			local in_instance, type_of_instance = IsInInstance()

			_, numQuests = GetNumQuestLogEntries()
			-- showQuestieFrame = (not in_instance and numQuests > 0 and not UnitInRaid('player')) and true or false
			showQuestieFrame = numQuests > 0 and true or false

			if showQuestieFrame then
				if not Questie_BaseFrame:IsVisible() then
					Questie_BaseFrame:Show()
				end
			else
				if Questie_BaseFrame:IsVisible() then
					Questie_BaseFrame:Hide()
				end
			end

			for i = 1, 32 do
				ib = _G['Questie_ItemButton' .. i]
				if ib then
					ib:CreateBeautyBorder(6)
				end
			end
		end

		local f = CreateFrame('Frame')
		f:RegisterEvent('PLAYER_ENTERING_WORLD')
		f:RegisterEvent('PLAYER_REGEN_DISABLED')
		f:RegisterEvent('PLAYER_REGEN_ENABLED')
		f:SetScript('OnEvent', Update_Questie_BaseFrame)
		Questie_BaseFrame:HookScript('OnUpdate', Update_Questie_BaseFrame)
	end
)
