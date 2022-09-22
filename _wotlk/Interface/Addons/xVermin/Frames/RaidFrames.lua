--This is how you make the raid frames even more resizable :) you can also put all this in one line and just use a macro in game.
-- local n, w, h = "CompactUnitFrameProfilesGeneralOptionsFrame"
-- h, w = _G[n .. "HeightSlider"], _G[n .. "WidthSlider"]
-- h:SetMinMaxValues(1, 150)
-- w:SetMinMaxValues(1, 150)
-- local Button = CreateFrame("Button", "AddOnName_ButtonName", nil, "SecureActionButtonTemplate")
-- Button:SetAttribute("type", "macro")
-- Button:SetAttribute("macrotext", "/cast [@mouseover] Lesser Heal")
-- SetOverrideBindingClick(Button, "F12", "AddOnName_ButtonName")

hooksecurefunc(
	'CompactUnitFrame_UpdateName',
	function(frame)
		local name = frame.name
		local playerName = GetUnitName(frame.unit, true)

		name:ClearAllPoints()
		name:SetPoint('TOPLEFT', 5, -5)

		if (playerName) then
			local nameWithoutRealm = gsub(playerName, '%-[^|]+', '')
			name:SetText(nameWithoutRealm)
		end
	end
)

local f = CreateFrame('frame')
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:RegisterEvent('GROUP_ROSTER_UPDATE')
f:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)
		-------------------------------------------
		-- Add Beauty Border to party and raid buffs icons
		-------------------------------------------
		for member = 1, 5, 1 do
			for buff = 1, 5, 1 do
				if _G['CompactPartyFrameMember' .. member .. 'Buff' .. buff] then
					_G['CompactPartyFrameMember' .. member .. 'Buff' .. buff]:CreateBeautyBorder(6)
				end
				if _G['CompactPartyFrameMember' .. member .. 'Debuff' .. buff] then
					_G['CompactPartyFrameMember' .. member .. 'Debuff' .. buff]:CreateBeautyBorder(6)
				end
			end
		end

		for group = 1, 8, 1 do
			for member = 1, 5, 1 do
				for buff = 1, 5, 1 do
					if _G['CompactRaidGroup' .. group .. 'Member' .. member .. 'Buff' .. buff] then
						_G['CompactRaidGroup' .. group .. 'Member' .. member .. 'Buff' .. buff]:CreateBeautyBorder(6)
					end
					if _G['CompactRaidGroup' .. group .. 'Member' .. member .. 'Debuff' .. buff] then
						_G['CompactRaidGroup' .. group .. 'Member' .. member .. 'Debuff' .. buff]:CreateBeautyBorder(6)
					end
				end
			end
		end
	end
)
