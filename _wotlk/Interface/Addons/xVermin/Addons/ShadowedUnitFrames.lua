local _, xVermin = ...
local indicator
local count = 0

C_Timer.NewTicker(
	1,
	function(self)
		if count > 30 then
			self:Cancel()
		end
		count = count + 1

		if IsAddOnLoaded('ShadowedUnitFrames') then
			TargetFrameSpellBar:RegisterEvent('UNIT_SPELLCAST_START')
			TargetFrameSpellBar:RegisterEvent('UNIT_SPELLCAST_STOP')
			TargetFrameSpellBar:RegisterEvent('UNIT_SPELLCAST_FAILED')
			TargetFrameSpellBar:RegisterEvent('UNIT_SPELLCAST_INTERRUPTED')
			TargetFrameSpellBar:RegisterEvent('UNIT_SPELLCAST_DELAYED')
			TargetFrameSpellBar:RegisterEvent('UNIT_SPELLCAST_CHANNEL_START')
			TargetFrameSpellBar:RegisterEvent('UNIT_SPELLCAST_CHANNEL_UPDATE')
			TargetFrameSpellBar:RegisterEvent('UNIT_SPELLCAST_CHANNEL_STOP')
			-- TargetFrameSpellBar:RegisterEvent('UNIT_SPELLCAST_INTERRUPTIBLE')
			-- TargetFrameSpellBar:RegisterEvent('UNIT_SPELLCAST_NOT_INTERRUPTIBLE')
			TargetFrameSpellBar:RegisterEvent('PLAYER_ENTERING_WORLD')
			TargetFrameSpellBar:RegisterEvent('PLAYER_TARGET_CHANGED')

			TargetFrameSpellBar:SetParent(UIParent)
			TargetFrameSpellBar:ClearAllPoints()
			TargetFrameSpellBar:SetPoint('CENTER', UIParent, 'CENTER', 245, -175)

			TargetFrameSpellBar.Icon:SetScale(1.6)
			-- TargetFrameSpellBar.Icon:CreateBeautyBorder(8)

			function RemoveBlizzFunction()
			end

			Target_Spellbar_AdjustPosition = RemoveBlizzFunction
			TargetFrameSpellBar:SetScript(
				'OnShow',
				function()
				end
			)

			self:Cancel()
		end
	end
)

-- xVermin.CheckIfLoadedWithTimer(
-- 	'SUFUnitplayer',
-- 	function()
-- 		SUFUnitplayer:HookScript(
-- 			'OnUpdate',
-- 			function()
-- 				for i = 1, 20 do
-- 					indicator = _G['SUFUnitplayer.auraIndicators.indicator-' .. i]
-- 					-- print(indicator:GetName())
-- 					if indicator then
-- 						print('ima:', indicator)
-- 						indicator:CreateBeautyBorder(6)
-- 					end
-- 				end
-- 			end
-- 		)
-- 	end
-- )

-- SUFUnitplayer.auraIndicators.indicator-9
-- SUFHEaderpartyUnitButton1.auraIndicators.indicator-9
