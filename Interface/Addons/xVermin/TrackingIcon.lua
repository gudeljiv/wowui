local _, xVermin = ...

local TrackingIconFrame = CreateFrame("Frame", "TrackingIconFrame", Minimap)
TrackingIconFrame:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 5, -5)
TrackingIconFrame:SetWidth(16)
TrackingIconFrame:SetHeight(16)
TrackingIconFrame:CreateBeautyBorder(6)
TrackingIconFrame:SetFrameStrata("LOW")
TrackingIconFrame.Icon = TrackingIconFrame:CreateTexture()
TrackingIconFrame.Icon:SetAllPoints(TrackingIconFrame)
TrackingIconFrame:Hide()

local function TrackingIcon()
	TrackingIconFrame:Hide()
	local texture = GetTrackingTexture()

	if (texture) then
		-- Minerals
		if (texture == 136025) then
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture("Interface\\Icons\\spell_nature_earthquake")
		end

		-- Herbs
		if (texture == 133939) then
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture("Interface\\Icons\\inv_misc_flower_02")
		end

		-- Humanoids
		if (texture == 135942) then
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture("Interface\\Icons\\spell_holy_prayerofhealing")
		end

		--Undead
		if (texture == 136142) then
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture("Interface\\Icons\\spell_shadow_darksummoning")
		end

		-- Beasts
		if (texture == 132328) then
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture("Interface\\Icons\\ability_tracking")
		end

		-- Hidden
		if (texture == 132320) then
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture("Interface\\Icons\\ability_stealth")
		end

		-- Demons
		if (texture == 136217) then
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture("Interface\\Icons\\spell_shadow_summonfelhunter")
		end

		-- Elementals
		if (texture == 135861) then
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture("Interface\\Icons\\spell_frost_summonwaterelemental")
		end

		-- Dragonkin
		if (texture == 134153) then
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture("Interface\\Icons\\inv_misc_head_dragon_01")
		end

		-- Giants
		if (texture == 132275) then
			TrackingIconFrame:Show()
			TrackingIconFrame.Icon:SetTexture("Interface\\Icons\\ability_racial_avatar")
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
			(spellName == "Find Minerals" or spellName == "Find Herbs" or spellName == "Track Beasts" or spellName == "Track Humanoids" or spellName == "Track Undead" or spellName == "Track Hidden" or spellName == "Track Demons" or
				spellName == "Track Elementals" or
				spellName == "Track Dragonkin" or
				spellName == "Track Giants")
		 then
			TrackingIconFrame:RegisterUnitEvent("UNIT_AURA", "player")
			TrackingIconFrame:SetScript("OnEvent", TrackingIcon)
			TrackingIcon()
		end

		i = i + 1
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("CHAT_MSG_SKILL")
f:SetScript("OnEvent", InitializeTracking)

MiniMapTrackingFrame:HookScript(
	"OnShow",
	function()
		MiniMapTrackingFrame:Hide()
	end
)
