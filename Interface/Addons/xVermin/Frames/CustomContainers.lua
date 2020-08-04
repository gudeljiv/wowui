local _, class = UnitClass("player")
local color = RAID_CLASS_COLORS[class]
if class == "SHAMAN" then
	color = {
		b = 0.86666476726532,
		g = 0.4392147064209,
		r = 0
	}
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOM CONTAINER COMBAT
----------------------------------------------------------------------------------------------------------------------------------------------------------
cc = CreateFrame("Frame", "CustomContainer", UIParent)
cc:SetWidth(110)
cc:SetHeight(20)
cc:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 310)

cc_combat = CreateFrame("Frame", "CustomContainer_Combat", cc)
cc_combat:SetWidth(110)
cc_combat:SetHeight(20)
cc_combat:SetPoint("LEFT", cc, "LEFT", 0, 0)
cc_combat:SetBackdrop(
	{
		bgFile = config.background.white,
		edgeFile = "",
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)
cc_combat:SetBackdropColor(0, 0, 0, 0.4)
cc_combat:Show()
cc_combat:SetFrameStrata("BACKGROUND")
cc_combat:CreateBeautyBorder(6)

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:SetScript(
	"OnEvent",
	function(self, event, ...)
		if event == "PLAYER_REGEN_DISABLED" then
			-- cc_combat:SetBackdropColor(color.r, color.g, color.b, 0.8)
			cc_combat:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\Media\\textureWhite")
			cc_combat:SetBeautyBorderColor(color.r, color.g, color.b, 1)
		end
		if event == "PLAYER_REGEN_ENABLED" then
			cc_combat:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\Media\\textureNormal")
			cc_combat:SetBeautyBorderColor(1, 1, 1, 1)
		-- cc_combat:SetBackdropColor(0, 0, 0, 0.4)
		end
	end
)

-- cc_inrange = CreateFrame("Frame", "CustomContainer_InRange", cc)
-- cc_inrange:SetWidth(10)
-- cc_inrange:SetHeight(10)
-- cc_inrange:SetPoint("LEFT", CustomContainer_Combat, "LEFT", 5, 0)
-- cc_inrange:SetBackdrop({
-- 	-- bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
-- 	bgFile = "Interface\\Buttons\\WHITE8x8",
-- 	edgeFile = "", tile = false, tileSize = 0, edgeSize = 0,
-- 	insets = { left = 0, right = 0, top = 0, bottom = 0 }
-- });
-- cc_inrange:SetBackdropColor(0,0,0,0.4);
-- cc_inrange:Hide();
-- cc_inrange:SetFrameStrata("LOW")
-- cc_inrange:CreateBeautyBorder(2)

-- local function TargetInRangeHide()
-- 	cc_inrange:Hide();
-- end
-- local function TargetInRangeShow()
-- 	TargetInRangeHide();
-- 	if(UnitCanAttack("player","target") and not UnitIsDeadOrGhost("target")) then
-- 		local playerClass, englishClass = UnitClass("player")
-- 		local spell = "";

-- 		if(englishClass == "WARLOCK") then spell = "Immolate" end
-- 		if(englishClass == "WARRIOR") then spell = "Charge" end

-- 		if(spell ~= "") then
-- 			cc_inrange:Show();
-- 			inRange = IsSpellInRange(spell, target)
-- 			-- print(inRange)
-- 			if(inRange == 1) then cc_inrange:SetBackdropColor(0,1,0,1) end
-- 			if(inRange == 0) then cc_inrange:SetBackdropColor(1,0,0,1) end
-- 		end
-- 	end
-- end
-- TargetFrame:HookScript("OnUpdate", TargetInRangeShow)
-- TargetFrame:HookScript('OnHide', TargetInRangeHide)

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOM CONTAINER 1
----------------------------------------------------------------------------------------------------------------------------------------------------------
cc = CreateFrame("Frame", "CustomContainer", UIParent)
cc:SetWidth(154)
cc:SetHeight(30)
cc:SetPoint("TOPRIGHT", "Minimap", "BOTTOMRIGHT", 0, -10)

cc1 = CreateFrame("Frame", "CustomContainer_1", cc)
cc1:SetWidth(154)
cc1:SetHeight(30)
cc1:SetPoint("LEFT", cc, "LEFT", 0, 0)
cc1:SetBackdrop(
	{
		bgFile = config.background.white,
		edgeFile = "",
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)
cc1:SetBackdropColor(0, 0, 0, 0.4)
cc1:Show()
cc1:SetFrameStrata("BACKGROUND")
cc1:CreateBeautyBorder(8)

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOM CONTAINER 2
----------------------------------------------------------------------------------------------------------------------------------------------------------
cc = CreateFrame("Frame", "CustomContainer", UIParent)
cc:SetWidth(154)
cc:SetHeight(30)
cc:SetPoint("TOPRIGHT", cc1, "BOTTOMRIGHT", 0, -10)

cc2 = CreateFrame("Frame", "CustomContainer_2", cc)
cc2:SetWidth(154)
cc2:SetHeight(30)
cc2:SetPoint("LEFT", cc, "LEFT", 0, 0)
cc2:SetBackdrop(
	{
		bgFile = config.background.white,
		edgeFile = "",
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)
cc2:SetBackdropColor(0, 0, 0, 0.4)
cc2:Show()
cc2:SetFrameStrata("BACKGROUND")
cc2:CreateBeautyBorder(8)
