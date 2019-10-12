
-- added shortcut to /reload
SLASH_RELOAD1 = "/rl"
SlashCmdList["RELOAD"] = function(msg)
   ReloadUI();
end 

local frame = CreateFrame("Frame", "CVarSet")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, ...)
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


local font = "Interface\\AddOns\\xVerminz\\media\\fontAtari.ttf"
RAID_CLASS_COLORS["SHAMAN"] = {r = 050 / 255, g = 111 / 255, b = 255 / 255, colorStr = "ff326fff"}

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function()

	-------------------------------------------
	-- adjust position of OmenBarAnchor
	-------------------------------------------
	if (IsAddOnLoaded('Omen')) then
		local OriginalSetPointOmen = getmetatable(OmenAnchor).__index.SetPoint
		local function MoveOmen(self)
			self:ClearAllPoints()
			OriginalSetPointOmen(self, "CENTER", 0, -237)
		end
		hooksecurefunc(OmenAnchor, "SetPoint", MoveOmen)
		MoveOmen(OmenAnchor)
	end


	-------------------------------------------
	-- adjust position of Recount
	-------------------------------------------
	if (IsAddOnLoaded('Recount')) then
		-- Move it
		Recount_MainWindow:Show()
		Recount_MainWindow:ClearAllPoints()
		Recount_MainWindow:SetMovable(true)
		Recount_MainWindow:SetUserPlaced(true)
		Recount_MainWindow:SetWidth(300)
		Recount_MainWindow:SetHeight(110)
		Recount_MainWindow:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 5, 7)

		-- Stop the default UI from moving it back
		Recount_MainWindow.ClearAllPoints = function() end
		Recount_MainWindow.SetPoint = function() end
	end

	-------------------------------------------
	-- Reposit toast frame.
	-------------------------------------------
	BNToastFrame:ClearAllPoints()
	BNToastFrame:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 35)
	BNToastFrame.CloseButton:Hide()
	BNToastFrame:SetBackdrop({ 
		bgFile = "Interface\\Buttons\\WHITE8x8", 
		edgeFile = "", tile = false, tileSize = 0, edgeSize = 0, 
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	});
	BNToastFrame:SetBackdropColor(0,0,0,0.75);
	BNToastFrame:SetWidth(250)
	BNToastFrame:CreateBeautyBorder(8)
	BNToastFrame.ClearAllPoints = function() end
	BNToastFrame.SetPoint = function() end

	-------------------------------------------
	-- Reposit loot frame.
	-------------------------------------------
	LootFrame:HookScript("OnShow", function(self)
		LootFrame:ClearAllPoints()
		LootFrame:SetPoint("BOTTOMLEFT", CustomContainer_Combat, "TOPLEFT", 450, 250)
	end)

	-------------------------------------------
	-- Reposit quest timer frame.
	-------------------------------------------
	QuestTimerFrame:HookScript("OnShow", function(self)
		QuestTimerFrame:ClearAllPoints()
		QuestTimerFrame:SetPoint("BOTTOMRIGHT", CustomContainer_1, "BOTTOMLEFT", 0, -9)
	end)

	QuestTimerFrame:HookScript("OnUpdate", function(self)
		QuestTimerFrame:ClearAllPoints()
		QuestTimerFrame:SetPoint("BOTTOMRIGHT", CustomContainer_1, "BOTTOMLEFT", 0, -9)
	end)

	-------------------------------------------
	-- SHOW FPS ALL THE TIME
	-------------------------------------------
	-- local Frame = CreateFrame("Frame")
	-- Frame:RegisterEvent("PLAYER_LOGIN")

	-- Frame:SetScript("OnEvent", function(...)
	-- 	ToggleFramerate()
		
	-- 	FramerateLabel:ClearAllPoints()
	-- 	FramerateLabel:SetPoint("BOTTOMLEFT", CustomContainer_2, "BOTTOMRIGHT", -60, 11)
	-- 	FramerateLabel:SetScale(0.6)
	-- 	-- FramerateLabel:SetFrameStrata("HIGH")

	-- 	FramerateText:ClearAllPoints()
	-- 	FramerateText:SetPoint("LEFT", FramerateLabel, "RIGHT", 0, 0)
	-- 	FramerateText:SetScale(0.6)
	-- 	-- FramerateText:SetFrameStrata("HIGH")
	-- end)

	-------------------------------------------
	-- position of choco bars
	-------------------------------------------
	ChocolateBar1:ClearAllPoints();
	ChocolateBar1:SetPoint("LEFT", CustomContainer_1, "LEFT", 5, 0)
	ChocolateBar1:SetWidth(145)
	ChocolateBar2:ClearAllPoints();
	ChocolateBar2:SetPoint("LEFT", CustomContainer_2, "LEFT", 5, 0)
	ChocolateBar2:SetWidth(145)


	-------------------------------------------
	-- monkey quest
	-------------------------------------------
	MonkeyQuestFrame:ClearAllPoints();
	MonkeyQuestFrame:SetPoint("TOPRIGHT", "CustomContainer_2", "TOPLEFT", -10, 0);
	MonkeyQuestFrame:CreateBeautyBorder(8);
	MonkeyQuestFrame.ClearAllPoints = function() end
	MonkeyQuestFrame.SetPoint = function() end

	-------------------------------------------
	-- tracking icon
	-------------------------------------------
	MiniMapTrackingFrame:ClearAllPoints();
	MiniMapTrackingFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -10, -5)
	MiniMapTrackingFrame:SetScale(0.7)

	-------------------------------------------
	-- adjust position of PetActionButtons
	-------------------------------------------
	PetActionButton1:Show()
	PetActionButton1:ClearAllPoints()
	PetActionButton1:SetMovable(true)
	PetActionButton1:SetUserPlaced(true)
	PetActionButton1:SetPoint("BOTTOM", MultiBarBottomRightButton2, "TOP", 20, 7)
	PetActionButton1.ClearAllPoints = function() end
	PetActionButton1.SetPoint = function() end

	-------------------------------------------
	-- right action bars
	-------------------------------------------
	MultiBarRightButton1:ClearAllPoints()
	MultiBarRightButton1:SetPoint("LEFT", CustomContainer_1, "RIGHT", 5, 2)
	MultiBarRightButton1.ClearAllPoints = function() end
	MultiBarRightButton1.SetPoint = function() end
	
	MultiBarLeftButton1:ClearAllPoints()
	MultiBarLeftButton1:SetPoint("TOP", MultiBarRightButton12, "BOTTOM", 0, -20)
	MultiBarLeftButton1.ClearAllPoints = function() end
	MultiBarLeftButton1.SetPoint = function() end

	MultiBarRight:SetScale(0.7)
	MultiBarLeft:SetScale(0.7)
	MultiBarRight.SetScale = function() end
	MultiBarLeft.SetScale = function() end

	MainMenuBarExpText:SetPoint("RIGHT", MainMenuExpBar, "RIGHT", -10, 2)

	MainMenuExpBar:HookScript('OnUpdate', function()
		local currentXP = UnitXP("player")
		local maxXP = UnitXPMax("player")
		local percent = floor((currentXP/maxXP)*100)
		MainMenuBarExpText:SetText(currentXP.." / "..maxXP.." ("..percent.."%)")
	end)

	PetFrame:HookScript("OnUpdate", function(self)
		PetFrameHealthBarText:SetFont(font, 10, 'THINOUTLINE')
		PetFrameHealthBarText:SetPoint("TOPRIGHT", PetFrameHealthBar, "TOPRIGHT", 0, 2)
		PetFrameHealthBarText.SetPoint = function() end
		PetFrameManaBarText:SetFont(font, 10, 'THINOUTLINE')
		PetFrameManaBarText:SetPoint("TOPRIGHT", PetFrameManaBar, "TOPRIGHT", 0, 0)
		PetFrameManaBarText.SetPoint = function() end
	end)

	local point = TargetFrame.SetPoint
	hooksecurefunc(TargetFrame, "SetPoint", function()
		point(TargetFrame, "CENTER", UIParent, "CENTER", 250, -96)
	end)

	local point = PlayerFrame.SetPoint
	hooksecurefunc(PlayerFrame, "SetPoint", function()
		point(PlayerFrame, "CENTER", UIParent, "CENTER", -250, -96)
	end)

end)
f:RegisterEvent("PLAYER_ENTERING_WORLD")





-- local tooltipOnEnter = function(self, event)
--     GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
--     GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, false);
--     GameTooltip:Show();
-- end
-- local tooltipOnLeave = function(self, event)
--     GameTooltip:Hide();
-- end
-- local function AddTooltip(widget, tooltipText)
--     widget.tooltipText = tooltipText
--     widget:SetScript("OnEnter", tooltipOnEnter)
--     widget:SetScript("OnLeave", tooltipOnLeave)
-- end

-- local function MakeCheckbox(name, parent)
--     local cb = CreateFrame("CheckButton", name, parent, "UICheckButtonTemplate")
--     cb:SetWidth(25)
--     cb:SetHeight(25)
--     cb:Show()

--     local cblabel = cb:CreateFontString(nil, "OVERLAY")
--     cblabel:SetFontObject("GameFontHighlight")
--     cblabel:SetPoint("LEFT", cb,"RIGHT", 5,0)
--     cb.label = cblabel
--     return cb
-- end


-- function f:CreateGUI(name, parent)
--     local frame = CreateFrame("Frame", nil, InterfaceOptionsFrame)
--     frame:Hide()

--     frame.parent = parent
--     frame.name = name

--     frame:SetScript("OnShow", function(self)
--         self.content.enemyBuffs:SetChecked(db.enemyBuffs)
--         self.content.portraitIcon:SetChecked(db.portraitIcon)
--         self.content.hookTargetFrame:SetChecked(db.hookTargetFrame)
--         self.content.verbosePortraitIcon:SetChecked(db.verbosePortraitIcon)
--     end)
--     -- frame:SetScript("OnHide", function(self) print("onHide") end)

--     local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
-- 	label:SetPoint("TOPLEFT", 10, -15)
-- 	label:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 10, -45)
-- 	label:SetJustifyH("LEFT")
--     label:SetJustifyV("TOP")

--     label:SetText(name)

-- 	local content = CreateFrame("Frame", "CADOptionsContent", frame)
-- 	content:SetPoint("TOPLEFT", 10, -10)
--     content:SetPoint("BOTTOMRIGHT", -10, 10)

--     frame.content = content

--     -- local warning = content:CreateFontString(nil, "OVERLAY")
--     -- warning:SetFontObject("GameFontHighlightSmall")
--     -- warning:SetPoint("TOPLEFT", 10, -40)
--     -- warning:SetText("If you're getting 'Script ran too long' errors consider turning enemy buffs off or switching to non-standard unitframes")

--     local htt = MakeCheckbox(nil, content)
--     htt.label:SetText("Hook Target Frame")
--     htt:SetPoint("TOPLEFT", 10, -60)
--     content.hookTargetFrame = htt
--     htt:SetScript("OnClick",function(self,button)
--         f.Commands.hooktarget()
--     end)
--     AddTooltip(htt, "Enable aura durations on target frame")

--     local ebt = MakeCheckbox(nil, content)
--     ebt.label:SetText("Full Aura Replacement")
--     ebt:SetPoint("TOPLEFT", 10, -90)
--     content.enemyBuffs = ebt
--     ebt:SetScript("OnClick",function(self,button)
--         f.Commands.enemybuffs()
--     end)
--     AddTooltip(ebt, [=[As opposed to only adding cooldown swipes, completely duplicates default aura handling.
-- This allows to display large personal debuffs and some enemy buffs.
-- May cause 'Script ran too long errors'
-- ]=])

--     local pit = MakeCheckbox(nil, content)
--     pit.label:SetText("Show Portrait Icon")
--     pit:SetPoint("TOPLEFT", 10, -120)
--     content.portraitIcon = pit
--     pit:SetScript("OnClick",function(self,button)
--         f.Commands.portraiticon()
--     end)
--     AddTooltip(pit, "Show CCs and other effects in the portrait")

--     local vpi = MakeCheckbox(nil, content)
--     vpi.label:SetText("Verbose Portrait Icon")
--     vpi:SetPoint("TOPLEFT", 10, -150)
--     content.verbosePortraitIcon = vpi
--     vpi:SetScript("OnClick",function(self,button)
--         f.Commands.verboseicon()
--     end)
--     AddTooltip(vpi, "Lowers the threshold of effects for portrait display. Will include slows and anything remotely important")

--     return frame
-- end



-- local loader = CreateFrame('Frame', nil, InterfaceOptionsFrame)
-- loader:SetScript('OnShow', function(self)
-- 	self:SetScript('OnShow', nil)

-- 	if not f.optionsPanel then
-- 		f.optionsPanel = f:CreateGUI("xVerminz")
-- 		InterfaceOptions_AddCategory(f.optionsPanel);
-- 	end
-- end)





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

-------------------------------------------
-- Set font in Character font for ammo count
-------------------------------------------
CharacterAmmoSlotCount:SetFont(font, 12, 'THINOUTLINE')