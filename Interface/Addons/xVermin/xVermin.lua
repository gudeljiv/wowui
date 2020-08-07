-- added shortcut to /reload
SLASH_RELOAD1 = "/rl"
SlashCmdList["RELOAD"] = function(msg)
	ReloadUI()
end

local frame = CreateFrame("Frame", "CVarSet")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript(
	"OnEvent",
	function(self, event, ...)
		SetCVar("autoQuestWatch", 0)
		SetCVar("autoQuestProgress", 0)
		SetCVar("instantQuestText", 1)
		SetCVar("nameplateMaxDistance", 80)
		SetCVar("ffxGlow", "1")
		SetCVar("ffxDeath", "0")
		SetCVar("ffxNether", "0")
		SetCVar("violenceLevel", "5")
		SetCVar("cameraDistanceMaxZoomFactor", 4.0)
		SetCVar("chatClassColorOverride", 0)
		SetCVar("ShowClassColorInFriendlyNameplate", 1)
		SetCVar("scriptErrors", "1")
	end
)

RAID_CLASS_COLORS["SHAMAN"] = {r = 050 / 255, g = 111 / 255, b = 255 / 255, colorStr = "ff326fff"}

local f = CreateFrame("Frame")
f:SetScript(
	"OnEvent",
	function()
		-------------------------------------------
		-- adjust position of OmenBarAnchor
		-------------------------------------------
		if (IsAddOnLoaded("Omen")) then
			local OriginalSetPointOmen = getmetatable(OmenAnchor).__index.SetPoint
			local function MoveOmen(self)
				self:ClearAllPoints()
				OriginalSetPointOmen(self, "CENTER", 0, -237)
			end
			hooksecurefunc(OmenAnchor, "SetPoint", MoveOmen)
			MoveOmen(OmenAnchor)
		end

		-------------------------------------------
		-- adjust position of Details TinyThreat
		-------------------------------------------
		if (IsAddOnLoaded("Details")) then
			Details_TinyThreat:ClearAllPoints()
			Details_TinyThreat:SetPoint("TOPRIGHT", "ChatFrame3", "TOPLEFT", -2, 2)
		end

		-------------------------------------------
		-- adjust position of Recount
		-------------------------------------------
		if (IsAddOnLoaded("Recount")) then
			-- Move it
			Recount_MainWindow:Show()
			Recount_MainWindow:ClearAllPoints()
			Recount_MainWindow:SetMovable(true)
			Recount_MainWindow:SetUserPlaced(true)
			Recount_MainWindow:SetWidth(300)
			Recount_MainWindow:SetHeight(110)
			Recount_MainWindow:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 5, 7)

			-- Stop the default UI from moving it back
			Recount_MainWindow.ClearAllPoints = function()
			end
			Recount_MainWindow.SetPoint = function()
			end
		end

		-------------------------------------------
		-- Reposition toast frame.
		-------------------------------------------
		BNToastFrame:ClearAllPoints()
		BNToastFrame:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 35)
		BNToastFrame.CloseButton:Hide()
		BNToastFrame:SetBackdrop(
			{
				bgFile = "Interface\\Buttons\\WHITE8x8",
				edgeFile = "",
				tile = false,
				tileSize = 0,
				edgeSize = 0,
				insets = {left = 0, right = 0, top = 0, bottom = 0}
			}
		)
		BNToastFrame:SetBackdropColor(0, 0, 0, 0.75)
		BNToastFrame:SetWidth(250)
		BNToastFrame:CreateBeautyBorder(8)
		BNToastFrame.ClearAllPoints = function()
		end
		BNToastFrame.SetPoint = function()
		end

		-------------------------------------------
		-- Reposition loot frame.
		-------------------------------------------
		LootFrame:HookScript(
			"OnShow",
			function(self)
				LootFrame:ClearAllPoints()
				LootFrame:SetPoint("BOTTOMLEFT", CustomContainer_Combat, "TOPLEFT", 450, 250)
			end
		)

		-------------------------------------------
		-- Reposition quest timer frame.
		-------------------------------------------
		QuestTimerFrame:HookScript(
			"OnShow",
			function(self)
				QuestTimerFrame:ClearAllPoints()
				QuestTimerFrame:SetPoint("BOTTOMRIGHT", CustomContainer_1, "BOTTOMLEFT", 0, -9)
			end
		)

		QuestTimerFrame:HookScript(
			"OnUpdate",
			function(self)
				QuestTimerFrame:ClearAllPoints()
				QuestTimerFrame:SetPoint("BOTTOMRIGHT", CustomContainer_1, "BOTTOMLEFT", 0, -9)
			end
		)

		-------------------------------------------
		-- Position of choco bars
		-------------------------------------------
		ChocolateBar1:ClearAllPoints()
		ChocolateBar1:SetPoint("LEFT", CustomContainer_1, "LEFT", 5, 0)
		ChocolateBar1:SetWidth(145)
		ChocolateBar2:ClearAllPoints()
		ChocolateBar2:SetPoint("LEFT", CustomContainer_2, "LEFT", 5, 0)
		ChocolateBar2:SetWidth(145)

		-------------------------------------------
		-- monkey quest
		-------------------------------------------
		MonkeyQuestFrame:ClearAllPoints()
		MonkeyQuestFrame:SetPoint("TOPRIGHT", "CustomContainer_2", "TOPLEFT", -10, 0)
		MonkeyQuestFrame:CreateBeautyBorder(8)
		MonkeyQuestFrame.ClearAllPoints = function()
		end
		MonkeyQuestFrame.SetPoint = function()
		end

		-------------------------------------------
		-- druability frame
		-------------------------------------------
		DurabilityFrame:ClearAllPoints()
		DurabilityFrame:SetPoint("TOPRIGHT", "EavesDropFrame", "BOTTOMRIGHT", -40, 0)
		DurabilityFrame.ClearAllPoints = function()
		end
		DurabilityFrame.SetPoint = function()
		end

		-------------------------------------------
		-- adjust position of PetActionButtons
		-------------------------------------------
		PetActionButton1:Show()
		PetActionButton1:ClearAllPoints()
		PetActionButton1:SetMovable(true)
		PetActionButton1:SetUserPlaced(true)
		PetActionButton1:SetPoint("BOTTOM", MultiBarBottomRightButton2, "TOP", 20, 7)
		PetActionButton1.ClearAllPoints = function()
		end
		PetActionButton1.SetPoint = function()
		end

		-------------------------------------------
		-- right action bars
		-------------------------------------------
		MultiBarRightButton1:ClearAllPoints()
		MultiBarRightButton1:SetPoint("LEFT", CustomContainer_1, "RIGHT", 5, 2)
		MultiBarRightButton1.ClearAllPoints = function()
		end
		MultiBarRightButton1.SetPoint = function()
		end

		MultiBarLeftButton1:ClearAllPoints()
		MultiBarLeftButton1:SetPoint("TOP", MultiBarRightButton12, "BOTTOM", 0, -20)
		MultiBarLeftButton1.ClearAllPoints = function()
		end
		MultiBarLeftButton1.SetPoint = function()
		end

		MultiBarRight:SetScale(0.7)
		MultiBarLeft:SetScale(0.7)
		MultiBarRight.SetScale = function()
		end
		MultiBarLeft.SetScale = function()
		end

		MainMenuBarExpText:SetPoint("RIGHT", MainMenuExpBar, "RIGHT", -10, 2)

		-------------------------------------------
		--- pet, player and target frame positioning
		-------------------------------------------

		PetFrame:HookScript(
			"OnUpdate",
			function(self)
				PetFrameHealthBarText:SetFont(xVermin.config.font.atari, 10, "THINOUTLINE")
				PetFrameHealthBarText:SetPoint("TOPRIGHT", PetFrameHealthBar, "TOPRIGHT", 0, 2)
				PetFrameHealthBarText.SetPoint = function()
				end
				PetFrameManaBarText:SetFont(xVermin.config.font.atari, 10, "THINOUTLINE")
				PetFrameManaBarText:SetPoint("TOPRIGHT", PetFrameManaBar, "TOPRIGHT", 0, 0)
				PetFrameManaBarText.SetPoint = function()
				end

				PetFrameHealthBarText:Hide()
				PetFrameManaBarText:Hide()
				PetName:Hide()
			end
		)

		local point = TargetFrame.SetPoint
		hooksecurefunc(
			TargetFrame,
			"SetPoint",
			function()
				point(TargetFrame, "CENTER", UIParent, "CENTER", 250, -96)
			end
		)

		local point = PlayerFrame.SetPoint
		hooksecurefunc(
			PlayerFrame,
			"SetPoint",
			function()
				point(PlayerFrame, "CENTER", UIParent, "CENTER", -250, -96)
			end
		)
		PlayerFrameManaBarText:SetScale(0.8)

		PlayerFrame:ClearAllPoints()
		PlayerFrame:SetPoint("CENTER", UIParent, "CENTER", -250, -96)
		TargetFrame:ClearAllPoints()
		TargetFrame:SetPoint("CENTER", UIParent, "CENTER", 250, -96)
	end
)
f:RegisterEvent("PLAYER_ENTERING_WORLD")

local function TargetFrameTextAdjustment()
	TargetFrameHealthBarText:ClearAllPoints()
	TargetFrameHealthBarText:SetPoint("CENTER", TargetFrame, "CENTER", -50, 7)
	TargetFrameManaBarText:SetScale(0.8)
end

hooksecurefunc("TargetFrame_CheckClassification", TargetFrameTextAdjustment)

-------------------------------------------
-- Fast loot function
-------------------------------------------
local tDelay = 0
local function FastLoot()
	if GetTime() - tDelay >= 0.3 then
		tDelay = GetTime()
		if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
			for i = GetNumLootItems(), 1, -1 do
				LootSlot(i)
			end
			tDelay = GetTime()
		end
	end
end

local faster = CreateFrame("Frame")
faster:RegisterEvent("LOOT_READY")
faster:SetScript("OnEvent", FastLoot)

LootFrame:HookScript(
	"OnShow",
	function()
		local numLootItems = GetNumLootItems()
		for i = GetNumLootItems(), 1, -1 do
			local frame = _G["LootButton" .. i]
			if (frame ~= nil) then
				frame:CreateBeautyBorder(6)
			end
		end
	end
)
