local _, xVermin = ...

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
cc:SetPoint("BOTTOM", UIParent, "BOTTOM", 60, 300)

cc_combat = CreateFrame("Frame", "CustomContainer_Combat", cc)
cc_combat:SetWidth(110)
cc_combat:SetHeight(20)
cc_combat:SetPoint("LEFT", cc, "LEFT", 0, 0)
cc_combat:SetBackdrop(
	{
		bgFile = xVermin.Config.background.white,
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
			cc_combat:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\Media\\textureWhite")
			cc_combat:SetBeautyBorderColor(color.r, color.g, color.b, 1)
		end
		if event == "PLAYER_REGEN_ENABLED" then
			cc_combat:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\Media\\textureNormal")
			cc_combat:SetBeautyBorderColor(1, 1, 1, 1)
		end
	end
)

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
		bgFile = xVermin.Config.background.white,
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
		bgFile = xVermin.Config.background.white,
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
