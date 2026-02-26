local _, nMainbar = ...
local cfg = nMainbar.Config

if not cfg.MainMenuBar.shortBar then
	return
end

-- disable the automatic frame position

-- do
-- 	for _, frame in pairs(
-- 		{
-- 			"MultiBarLeft",
-- 			"MultiBarRight",
-- 			"MultiBarBottomRight",
-- 			-- 'StanceBarFrame',
-- 			"PossessBarFrame",
-- 			"MULTICASTACTIONBAR_YPOS",
-- 			"MultiCastActionBarFrame",
-- 			"PETACTIONBAR_YPOS"
-- 		}
-- 	) do
-- 		UIPARENT_MANAGED_FRAME_POSITIONS[frame] = nil
-- 	end
-- end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
	local frames = {
		MultiBarLeft,
		MultiBarRight,
		MultiBarBottomRight,
		MultiCastActionBarFrame,
		PetActionBarFrame,
	}

	for _, frame in ipairs(frames) do
		if frame then
			frame.ignoreFramePositionManager = true
			frame:SetAttribute("ignoreFramePositionManager", true)
		end
	end
end)

-- hide unwanted objects

for i = 2, 3 do
	for _, object in pairs({
		_G["ActionBarUpButton"],
		_G["ActionBarDownButton"],
		_G["KeyRingButton"],
		_G["MainMenuBarTexture" .. i],
		_G["MainMenuMaxLevelBar" .. i],
		_G["MainMenuXPBarTexture" .. i],
		_G["ReputationWatchBarTexture" .. i],
		_G["ReputationXPBarTexture" .. i],
		_G["MainMenuBarPageNumber"],
		_G["SlidingActionBarTexture0"],
		_G["SlidingActionBarTexture1"],
		_G["StanceBarLeft"],
		_G["StanceBarMiddle"],
		_G["StanceBarRight"],
		_G["PossessBackground1"],
		_G["PossessBackground2"],
	}) do
		if object:IsObjectType("Frame") or object:IsObjectType("Button") then
			object:UnregisterAllEvents()
			object:SetScript("OnEnter", nil)
			object:SetScript("OnLeave", nil)
			object:SetScript("OnClick", nil)
		end

		hooksecurefunc(object, "Show", function(self)
			self:Hide()
		end)

		object:Hide()
	end
end

-- reduce the size of some main menu bar objects

for _, object in pairs({
	_G["MainMenuBar"],
	_G["MainMenuExpBar"],
	_G["MainMenuBarMaxLevelBar"],
}) do
	object:SetWidth(512)
end

-- ReputationWatchBar:SetWidth(512)
-- ReputationWatchBar.StatusBar:SetWidth(512)

-- ReputationWatchBar.StatusBar.WatchBarTexture0:SetWidth(256)
-- ReputationWatchBar.StatusBar.WatchBarTexture1:SetWidth(256)
-- ReputationWatchBar.StatusBar.WatchBarTexture2:SetTexture(nil)
-- ReputationWatchBar.StatusBar.WatchBarTexture3:SetTexture(nil)

-- -- Only shown when tracker is in place of MainMenuExpBar.
-- ReputationWatchBar.StatusBar.XPBarTexture0:SetWidth(256)
-- ReputationWatchBar.StatusBar.XPBarTexture1:SetWidth(256)
-- ReputationWatchBar.StatusBar.XPBarTexture2:SetTexture(nil)
-- ReputationWatchBar.StatusBar.XPBarTexture3:SetTexture(nil)

-- remove divider

-- for i = 0, 3, 1 do
-- 	_G["MainMenuXPBarTexture" .. i]:Hide()
-- end

-- local divWidth = MainMenuExpBar:GetWidth() / 10
-- local xpos = 0

-- for i = 0, 1, 1 do
-- 	local texture = _G["MainMenuXPBarTexture" .. i]
-- 	local xalign = floor(xpos)
-- 	texture:Show()
-- 	texture:SetPoint("LEFT", xalign, 1)
-- 	xpos = xpos + 256
-- end

MultiBarBottomRight:EnableMouse(false)

MultiBarBottomRightButton1:ClearAllPoints()
MultiBarBottomRightButton1:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton1, "TOPLEFT", 0, 6)

-- reposit some objects

MainMenuBarTexture0:SetPoint("BOTTOM", MainMenuBarArtFrame, -128, 0)
MainMenuBarTexture1:SetPoint("BOTTOM", MainMenuBarArtFrame, 128, 0)

MainMenuMaxLevelBar0:SetPoint("BOTTOM", MainMenuBarMaxLevelBar, "TOP", -128, 0)

MainMenuBarLeftEndCap:SetPoint("BOTTOM", MainMenuBarArtFrame, -289, 0)
MainMenuBarLeftEndCap.SetPoint = function() end

MainMenuBarRightEndCap:SetPoint("BOTTOM", MainMenuBarArtFrame, 289, 0)
MainMenuBarRightEndCap.SetPoint = function() end

-- reposit the micromenu

CharacterMicroButton:ClearAllPoints()
CharacterMicroButton:SetPoint("BOTTOMLEFT", UIParent, 9000, 9000)

-- hooksecurefunc("MoveMicroButtons", function(anchor, achorTo, relAnchor, x, y, isStacked)
-- 	if not isStacked then
-- 		CharacterMicroButton:ClearAllPoints()
-- 		CharacterMicroButton:SetPoint("BOTTOMLEFT", UIParent, 9000, 9000)
-- 	end
-- end)

-- a new place for the exit vehicle button

-- hooksecurefunc("MainMenuBarVehicleLeaveButton_Update", function()
-- 	MainMenuBarVehicleLeaveButton:ClearAllPoints()
-- 	MainMenuBarVehicleLeaveButton:SetPoint("LEFT", MainMenuBar, "RIGHT", 10, 75)
-- end)

local function ParkMicroButtons()
	local bar = _G.MicroButtonAndBagsBar or _G.MicroButtonBar
	if bar then
		bar:ClearAllPoints()
		bar:SetPoint("TOPLEFT", UIParent, "BOTTOMRIGHT", 9000, -9000)
		bar.ignoreFramePositionManager = true
		bar:SetAttribute("ignoreFramePositionManager", true)
		return
	end

	-- fallback: just move the first micro button
	if CharacterMicroButton then
		CharacterMicroButton:ClearAllPoints()
		CharacterMicroButton:SetPoint("TOPLEFT", UIParent, "BOTTOMRIGHT", 9000, -9000)
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", ParkMicroButtons)

local function MoveVehicleLeaveButton()
	local b = _G.MainMenuBarVehicleLeaveButton
	if not b then
		return
	end

	-- pick a stable anchor (MainMenuBar can be nil / not used in modern UI layouts)
	local anchor = _G.MainMenuBar or _G.ActionBarController_GetCurrentActionBar and UIParent or UIParent

	b:ClearAllPoints()
	b:SetPoint("LEFT", anchor, "RIGHT", 10, 75)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("UNIT_ENTERED_VEHICLE")
f:RegisterEvent("UNIT_EXITED_VEHICLE")
f:SetScript("OnEvent", function(_, _, unit)
	if unit == nil or unit == "player" then
		MoveVehicleLeaveButton()
	end
end)

if _G.MainMenuBarVehicleLeaveButton then
	_G.MainMenuBarVehicleLeaveButton:HookScript("OnShow", MoveVehicleLeaveButton)
end
