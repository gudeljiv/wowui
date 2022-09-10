local _, xVermin = ...

local titm = CreateFrame('Frame', 'TrackingIconTextFrame')
titm:SetPoint('CENTER', UIParent, 'CENTER', 0, -55)
titm.text = titm:CreateFontString(nil, 'ARTWORK')
titm.text:SetFont(xVermin.Config.font.arial, 10, 'NONE')
titm.text:SetShadowOffset(1, -1)
titm.text:SetPoint('TOP', titm, 'TOP', 0, 0)
titm.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
titm:SetWidth(titm.text:GetStringWidth())
titm:SetHeight(titm.text:GetStringHeight())

local TrackingIconFrame = CreateFrame('Frame', 'TrackingIconFrame', Minimap)
TrackingIconFrame:SetPoint('TOPRIGHT', Minimap, 'TOPRIGHT', -5, -5)
TrackingIconFrame:SetWidth(16)
TrackingIconFrame:SetHeight(16)
TrackingIconFrame:EnableMouse(false)
TrackingIconFrame:CreateBeautyBorder(6)
TrackingIconFrame:SetFrameStrata('LOW')
TrackingIconFrame.Icon = TrackingIconFrame:CreateTexture()
TrackingIconFrame.Icon:SetAllPoints(TrackingIconFrame)
TrackingIconFrame:Hide()

local function TrackingIcon()
	TrackingIconFrame:Hide()
	-- local texture = GetTrackingTexture()
	local texture

	for i = 1, GetNumTrackingTypes() do
		local n, t, a = GetTrackingInfo(i)
		if a and (t == 136025 or t == 133939 or t == 135942 or t == 136142 or t == 132328 or t == 132320 or t == 136217 or t == 135861 or t == 134153 or t == 132275 or t == 135974) then
			texture = t
		end
	end

	if (texture) then
		trackingID = texture
		-- Minerals
		if (texture == 136025) then
			titm.text:SetText('MINERALS')
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\spell_nature_earthquake')
		end

		-- Herbs
		if (texture == 133939) then
			titm.text:SetText('HERBS')
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\inv_misc_flower_02')
		end

		-- Humanoids HUNTER
		if (texture == 135942) then
			titm.text:SetText('HUMANOIDS')
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\spell_holy_prayerofhealing')
		end

		-- Beasts
		if (texture == 132328) then
			titm.text:SetText('BEASTS')
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\ability_tracking')
		end

		-- Humanoids DRUID
		if (texture == 132328 and xVermin.Class == 'DRUID') then
			titm.text:SetText('HUMANOIDS')
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\ability_tracking')
		end

		--Undead
		if (texture == 136142) then
			titm.text:SetText('UNDEAD')
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\spell_shadow_darksummoning')
		end

		--Sense Undead
		if (texture == 135974) then
			titm.text:SetText('SENSE UNDEAD')
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\spell_holy_senseundead')
		end

		-- Hidden
		if (texture == 132320) then
			titm.text:SetText('HIDDEN')
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\ability_stealth')
		end

		-- Demons
		if (texture == 136217) then
			titm.text:SetText('DEMONS')
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\spell_shadow_summonfelhunter')
		end

		-- Elementals
		if (texture == 135861) then
			titm.text:SetText('ELEMENTALS')
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\spell_frost_summonwaterelemental')
		end

		-- Dragonkin
		if (texture == 134153) then
			titm.text:SetText('DRAGONKIN')
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\inv_misc_head_dragon_01')
		end

		-- Giants
		if (texture == 132275) then
			titm.text:SetText('GIANTS')
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\ability_racial_avatar')
		end

		if not texture then
			titm:Hide()
		else
			titm:SetWidth(titm.text:GetStringWidth())
			titm:SetHeight(titm.text:GetStringHeight())
			titm:Show()
		end
	end
end

local function InitializeTracking()
	local i = 1
	while true do
		local spellName, spellSubName = GetSpellBookItemName(i, BOOKTYPE_SPELL)
		if not spellName then
			do
				break
			end
		end

		if
			(spellName == 'Find Minerals' or spellName == 'Find Herbs' or spellName == 'Track Beasts' or spellName == 'Track Humanoids' or spellName == 'Track Undead' or spellName == 'Track Hidden' or spellName == 'Track Demons' or spellName == 'Track Elementals' or spellName == 'Track Dragonkin' or spellName == 'Track Giants' or spellName == 'Sense Undead')
		 then
			TrackingIconFrame:RegisterUnitEvent('UNIT_AURA', 'player')
			TrackingIconFrame:SetScript('OnEvent', TrackingIcon)
			TrackingIcon()
		end

		i = i + 1
	end
end

local f = CreateFrame('Frame')
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:RegisterEvent('CHAT_MSG_SKILL')
-- f:RegisterEvent('MINIMAP_UPDATE_TRACKING')
f:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)
		if event == 'PLAYER_ENTERING_WORLD' and (isInitialLogin or isReloadingUi) then
			InitializeTracking()
		end
		if event == 'CHAT_MSG_SKILL' then
			InitializeTracking()
		end
	end
)

MiniMapTracking:Hide()
MiniMapTracking:HookScript(
	'OnShow',
	function()
		MiniMapTracking:Hide()
	end
)
