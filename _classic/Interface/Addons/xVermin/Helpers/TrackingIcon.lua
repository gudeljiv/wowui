local _, xVermin = ...

local GetNumTrackingTypes = C_Minimap and C_Minimap.GetNumTrackingTypes or GetNumTrackingTypes
local GetTrackingInfo = C_Minimap and C_Minimap.GetTrackingInfo or GetTrackingInfo

local titm = CreateFrame('Frame', 'TrackingIconTextFrame')
titm:SetPoint('CENTER', UIParent, 'CENTER', 0, -55)
titm.text = titm:CreateFontString(nil, 'ARTWORK')
titm.text:SetFont(xVermin.Config.font.arial, 10, 'NONE')
titm.text:SetShadowOffset(1, -1)
titm.text:SetPoint('TOP', titm, 'TOP', 0, 0)
titm.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
titm:SetWidth(titm.text:GetStringWidth())
titm:SetHeight(titm.text:GetStringHeight())
titm:SetFrameStrata("HIGH")


local TrackingIconFrame = CreateFrame('Frame', 'TrackingIconFrame', Minimap)
TrackingIconFrame:SetPoint('TOPRIGHT', Minimap, 'TOPRIGHT', -5, -5)
TrackingIconFrame:SetWidth(16)
TrackingIconFrame:SetHeight(16)
TrackingIconFrame:EnableMouse(false)
TrackingIconFrame:CreateBeautyBorder(6)
TrackingIconFrame:SetFrameStrata('HIGH')
TrackingIconFrame.Icon = TrackingIconFrame:CreateTexture()
TrackingIconFrame.Icon:SetAllPoints(TrackingIconFrame)
TrackingIconFrame:Hide()

local function TrackingIcon(texture)
	TrackingIconFrame:Hide()
	
		-- Minerals
	if (texture == 2580) then
		titm.text:SetText('MINERALS')
		TrackingIconFrame:Show()
		TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\spell_nature_earthquake')
	end

	-- Herbs
	if (texture == 2383) then
		titm.text:SetText('HERBS')
		TrackingIconFrame:Show()
		TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\inv_misc_flower_02')
	end

	-- Humanoids HUNTER
	if (texture == 19883) then
		titm.text:SetText('HUMANOIDS')
		TrackingIconFrame:Show()
		TrackingIconFrame.Icon:SetTexture('Interface\\Icons\\spell_holy_prayerofhealing')
	end

	-- Beasts
	if (texture == 1494) then
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

	if not texture or xVermin.Class ~= 'HUNTER' then
		titm:Hide()
	else
		titm:SetWidth(titm.text:GetStringWidth())
		titm:SetHeight(titm.text:GetStringHeight())
		titm:Hide()
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

		if (
			spellName == 'Find Minerals' or 
			spellName == 'Find Herbs' or 
			spellName == 'Track Beasts' or 
			spellName == 'Track Humanoids' or 
			spellName == 'Track Undead' or 
			spellName == 'Track Hidden' or 
			spellName == 'Track Demons' or 
			spellName == 'Track Elementals' or 
			spellName == 'Track Dragonkin' or 
			spellName == 'Track Giants' or 
			spellName == 'Sense Undead'
		) then
			TrackingIconFrame:RegisterUnitEvent('UNIT_AURA', 'player')
			TrackingIconFrame:SetScript('OnEvent', TrackingIcon)
			TrackingIcon(spellName)
		end

		i = i + 1
	end
end

-- local f = CreateFrame('Frame')
-- f:RegisterEvent('PLAYER_ENTERING_WORLD')
-- f:SetScript(
-- 	'OnEvent',
-- 	function(self, event, isInitialLogin, isReloadingUi)
-- 		if event == 'PLAYER_ENTERING_WORLD' and (isInitialLogin or isReloadingUi) then
-- 			InitializeTracking()
-- 		end
-- 	end
-- )

local f2 = CreateFrame('Frame')
f2:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED')
f2:SetScript(
	'OnEvent',
	function(self, event, arg1, unit, spell_id)
		if (
			spell_id == 2580 or 
			spell_id == 2383 or
			spell_id == 1494 or
			spell_id == 19883
		) then
			TrackingIcon(spell_id)
		end
	end
)

MiniMapTrackingFrame:Hide()
MiniMapTrackingFrame:HookScript(
	'OnShow',
	function()
		MiniMapTrackingFrame:Hide()
	end
)


