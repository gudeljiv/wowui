local _, xVermin = ...

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOM CONTAINER COMBAT
----------------------------------------------------------------------------------------------------------------------------------------------------------
local cc = CreateFrame("Frame", "CustomContainer_CENTER", UIParent)
cc:SetWidth(110)
cc:SetHeight(20)
cc:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 300)

local cc_combat = CreateFrame("Frame", "CustomContainer_Combat", cc, BackdropTemplateMixin and "BackdropTemplate")
cc_combat:SetWidth(110)
cc_combat:SetHeight(20)
cc_combat:SetPoint("LEFT", cc, "LEFT", 0, 0)
cc_combat:SetBackdrop({
	bgFile = xVermin.Config.background.white,
	edgeFile = "",
	tile = false,
	tileSize = 0,
	edgeSize = 0,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
})
cc_combat:SetBackdropColor(0, 0, 0, 0.6)
cc_combat:Show()
cc_combat:SetFrameStrata("BACKGROUND")
cc_combat:CreateBeautyBorder(6)

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_REGEN_DISABLED" then
		cc_combat:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\Media\\textureWhite")
		cc_combat:SetBeautyBorderColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
		SetCVar("nameplateShowEnemies", 1)
		SetCVar("nameplateShowEnemyMinions", 0)
		SetCVar("nameplateShowEnemyMinus", 0)
		-- SetCVar('nameplateShowFriends', 0)
		-- SetCVar('nameplateShowFriendlyMinions', 0)
	end
	if event == "PLAYER_REGEN_ENABLED" then
		cc_combat:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\Media\\textureNormal")
		cc_combat:SetBeautyBorderColor(1, 1, 1, 1)
		SetCVar("nameplateShowEnemies", 0)
		SetCVar("nameplateShowEnemyMinions", 0)
		SetCVar("nameplateShowEnemyMinus", 0)
		-- SetCVar('nameplateShowFriends', 1)
		-- SetCVar('nameplateShowFriendlyMinions', 1)
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- USER PROFESSIONS
----------------------------------------------------------------------------------------------------------------------------------------------------------

-- local ProfessionNames = {
-- 	main = {
-- 		[164] = "Blacksmithing",
-- 		[165] = "Leatherworking",
-- 		[171] = "Alchemy",
-- 		[182] = "Herbalism",
-- 		[186] = "Mining",
-- 		[197] = "Tailoring",
-- 		[202] = "Engineering",
-- 		[333] = "Enchanting",
-- 		[393] = "Skinning",
-- 		[755] = "Jewelcrafting",
-- 		[773] = "Inscription"
-- 	},
-- 	secondary = {
-- 		[185] = "Cooking",
-- 		[356] = "Fishing",
-- 		[129] = "First Aid",
-- 		[794] = "Archaeology"
-- 	}
-- }

-- local profNames_main = ProfessionNames["main"]
-- local profNames_rev_main = tInvert(profNames_main)
-- local profNames_secondary = ProfessionNames["secondary"]
-- local profNames_rev_secondary = tInvert(profNames_secondary)

-- for i = 1, GetNumSkillLines() do
-- 	local name, _, _, skillRank = GetSkillLineInfo(i)
-- 	if profNames_rev_main[name] then
-- 		print("main", name, skillRank)
-- 	end
-- end

-- for i = 1, GetNumSkillLines() do
-- 	local name, _, _, skillRank = GetSkillLineInfo(i)
-- 	if profNames_rev_secondary[name] then
-- 		print("secondary", name, skillRank)
-- 	end
-- end

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOM CONTAINER 1 (minimap 1)
----------------------------------------------------------------------------------------------------------------------------------------------------------
cc = CreateFrame("Frame", "CustomContainer_MM", UIParent)
cc:SetWidth(154)
cc:SetHeight(30)
-- cc:SetPoint("TOPRIGHT", "MinimapCluster", "BOTTOMRIGHT", 0, -10)
cc:SetPoint("TOP", "MinimapCluster", "BOTTOM", -15, -20)

local cc1 = CreateFrame("Frame", "CustomContainer_1", cc, BackdropTemplateMixin and "BackdropTemplate")
cc1:SetWidth(154)
cc1:SetHeight(30)
cc1:SetPoint("LEFT", cc, "LEFT", 0, 0)
cc1:SetBackdrop({
	bgFile = xVermin.Config.background.white,
	edgeFile = "",
	tile = false,
	tileSize = 0,
	edgeSize = 0,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
})
cc1:SetBackdropColor(0, 0, 0, 0.6)
cc1:Show()
cc1:SetFrameStrata("BACKGROUND")
cc1:CreateBeautyBorder(8)

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOM CONTAINER 2 (minimap 2)
----------------------------------------------------------------------------------------------------------------------------------------------------------
cc = CreateFrame("Frame", "CustomContainer", UIParent)
cc:SetWidth(154)
cc:SetHeight(30)
cc:SetPoint("TOPRIGHT", cc1, "BOTTOMRIGHT", 0, -10)

local cc2 = CreateFrame("Frame", "CustomContainer_2", cc, BackdropTemplateMixin and "BackdropTemplate")
cc2:SetWidth(154)
cc2:SetHeight(30)
cc2:SetPoint("LEFT", cc, "LEFT", 0, 0)
cc2:SetBackdrop({
	bgFile = xVermin.Config.background.white,
	edgeFile = "",
	tile = false,
	tileSize = 0,
	edgeSize = 0,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
})
cc2:SetBackdropColor(0, 0, 0, 0.6)
cc2:Show()
cc2:SetFrameStrata("BACKGROUND")
cc2:CreateBeautyBorder(8)
