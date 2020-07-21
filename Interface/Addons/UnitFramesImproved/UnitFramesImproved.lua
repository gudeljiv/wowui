-- Credits to stassart on curse.com for suggesting to use InCombatLockdown() checks in the code

-- Debug function. Adds message to the chatbox (only visible to the loacl player)
function dout(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg)
end

-- Additional debug info can be found on http://www.wowwiki.com/Blizzard_DebugTools
-- /framestack [showhidden]
--		showhidden - if "true" then will also display information about hidden frames
-- /eventtrace [command]
-- 		start - enables event capturing to the EventTrace frame
--		stop - disables event capturing
--		number - captures the provided number of events and then stops
--		If no command is given the EventTrace frame visibility is toggled. The first time the frame is displayed, event tracing is automatically started.
-- /dump expression
--		expression can be any valid lua expression that results in a value. So variable names, function calls, frames or tables can all be dumped.

function tokenize(str)
	local tbl = {}
	for v in string.gmatch(str, "[^ ]+") do
		tinsert(tbl, v)
	end
	return tbl
end

-- Create the addon main instance
local UnitFramesImproved = CreateFrame("Button", "UnitFramesImproved")

-- Event listener to make sure we enable the addon at the right time
function UnitFramesImproved:PLAYER_ENTERING_WORLD()
	-- Set some default settings
	if (characterSettings == nil) then
		UnitFramesImproved_LoadDefaultSettings()
	end

	EnableUnitFramesImproved()
end

-- Event listener to make sure we've loaded our settings and thta we apply them
function UnitFramesImproved:VARIABLES_LOADED()
	-- dout("UnitFramesImproved settings loaded!");

	-- Set some default settings
	if (characterSettings == nil) then
		UnitFramesImproved_LoadDefaultSettings()
	end

	if (not (characterSettings["PlayerFrameAnchor"] == nil)) then
		StaticPopup_Show("LAYOUT_RESETDEFAULT")
		characterSettings["PlayerFrameX"] = nil
		characterSettings["PlayerFrameY"] = nil
		characterSettings["PlayerFrameMoved"] = nil
		characterSettings["PlayerFrameAnchor"] = nil
	end

	UnitFramesImproved_ApplySettings(characterSettings)
end

function UnitFramesImproved_ApplySettings(settings)
	UnitFramesImproved_SetFrameScale(settings["FrameScale"])
end

function UnitFramesImproved_LoadDefaultSettings()
	characterSettings = {}
	characterSettings["FrameScale"] = "1.0"

	if not TargetFrame:IsUserPlaced() then
		TargetFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPRIGHT", 36, 0)
	end
end

function EnableUnitFramesImproved()
	-- Generic status text hook
	hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UnitFramesImproved_TextStatusBar_UpdateTextStringWithValues)

	-- Hook PlayerFrame functions
	hooksecurefunc("PlayerFrame_ToPlayerArt", UnitFramesImproved_PlayerFrame_ToPlayerArt)
	hooksecurefunc("PlayerFrame_ToVehicleArt", UnitFramesImproved_PlayerFrame_ToVehicleArt)

	-- Hook TargetFrame functions
	hooksecurefunc("TargetFrame_CheckDead", UnitFramesImproved_TargetFrame_Update)
	hooksecurefunc("TargetFrame_Update", UnitFramesImproved_TargetFrame_Update)
	hooksecurefunc("TargetFrame_CheckFaction", UnitFramesImproved_TargetFrame_CheckFaction)
	hooksecurefunc("TargetFrame_CheckClassification", UnitFramesImproved_TargetFrame_CheckClassification)
	hooksecurefunc("TargetofTarget_Update", UnitFramesImproved_TargetFrame_Update)

	-- BossFrame hooks
	hooksecurefunc("BossTargetFrame_OnLoad", UnitFramesImproved_BossTargetFrame_Style)

	-- Set up some stylings
	UnitFramesImproved_Style_PlayerFrame()
	UnitFramesImproved_BossTargetFrame_Style(Boss1TargetFrame)
	UnitFramesImproved_BossTargetFrame_Style(Boss2TargetFrame)
	UnitFramesImproved_BossTargetFrame_Style(Boss3TargetFrame)
	UnitFramesImproved_BossTargetFrame_Style(Boss4TargetFrame)
	UnitFramesImproved_Style_TargetFrame(TargetFrame)
	if (FocusFrame) then -- Support WoW Classic by checking for FocusFrame
		UnitFramesImproved_Style_TargetFrame(FocusFrame)
	end
	UnitFramesImproved_Style_TargetOfTargetFrame()

	-- Update some values
	TextStatusBar_UpdateTextString(PlayerFrame.healthbar)
	TextStatusBar_UpdateTextString(PlayerFrame.manabar)

	-- Add TargetFrame status text for classic
	if (not FocusFrame) then
		-- print("t f h b t")
		TargetFrameHealthBar.TextString =
			CreateStatusBarText("Text", "TargetFrameHealthBar", TargetFrameTextureFrame, "CENTER", -50, 3)
		TargetFrameHealthBar.LeftText =
			CreateStatusBarText("TextLeft", "TargetFrameHealthBar", TargetFrameTextureFrame, "LEFT", 8, 3)
		TargetFrameHealthBar.RightText =
			CreateStatusBarText("TextRight", "TargetFrameHealthBar", TargetFrameTextureFrame, "RIGHT", -110, 3)

		TargetFrameManaBar.TextString =
			CreateStatusBarText("Text", "TargetFrameManaBar", TargetFrameTextureFrame, "CENTER", -50, -8)
		TargetFrameManaBar.LeftText =
			CreateStatusBarText("TextLeft", "TargetFrameManaBar", TargetFrameTextureFrame, "LEFT", 8, -8)
		TargetFrameManaBar.RightText =
			CreateStatusBarText("TextRight", "TargetFrameManaBar", TargetFrameTextureFrame, "RIGHT", -110, -8)
	end
end

function CreateStatusBarText(name, parentName, parent, point, x, y)
	local fontString = parent:CreateFontString(parentName .. name, nil, "TextStatusBarText")
	fontString:SetPoint(point, parent, point, x, y)
	return fontString
end

function UnitFramesImproved_Style_TargetOfTargetFrame()
	if not InCombatLockdown() then
		TargetFrameToTHealthBar.lockColor = true
	end
end

function UnitFramesImproved_Style_PlayerFrame()
	if not InCombatLockdown() then
		PlayerFrameHealthBar.lockColor = true
		PlayerFrameHealthBar.capNumericDisplay = true
		PlayerFrameHealthBar:SetWidth(119)
		PlayerFrameHealthBar:SetHeight(29)
		PlayerFrameHealthBar:SetPoint("TOPLEFT", 106, -22)
		PlayerFrameHealthBarText:SetPoint("CENTER", 50, 6)
	end

	PlayerFrameTexture:SetTexture("Interface\\Addons\\UnitFramesImproved\\Textures\\UI-TargetingFrame")
	PlayerStatusTexture:SetTexture("Interface\\Addons\\UnitFramesImproved\\Textures\\UI-Player-Status")
	PlayerFrameHealthBar:SetStatusBarColor(UnitColor("player"))
end

function UnitFramesImproved_Style_TargetFrame(self)
	--if not InCombatLockdown() then
	local classification = UnitClassification(self.unit)
	if (classification == "minus") then
		self.healthbar:SetHeight(12)
		self.healthbar:SetPoint("TOPLEFT", 7, -41)
		if (self.healthbar.TextString) then
			self.healthbar.TextString:SetPoint("CENTER", -50, 4)
		end
		self.deadText:SetPoint("CENTER", -50, 4)
		self.Background:SetPoint("TOPLEFT", 7, -41)
	else
		self.healthbar:SetHeight(29)
		self.healthbar:SetPoint("TOPLEFT", 7, -22)
		if (self.healthbar.TextString) then
			self.healthbar.TextString:SetPoint("CENTER", -50, 6)
		end
		self.deadText:SetPoint("CENTER", -50, 6)
		self.nameBackground:Hide()
		self.Background:SetPoint("TOPLEFT", 7, -22)
	end

	self.healthbar:SetWidth(119)
	self.healthbar.lockColor = true
	--end
end

function UnitFramesImproved_BossTargetFrame_Style(self)
	self.borderTexture:SetTexture("Interface\\Addons\\UnitFramesImproved\\Textures\\UI-UnitFrame-Boss")

	UnitFramesImproved_Style_TargetFrame(self)
	if (not (characterSettings["FrameScale"] == nil)) then
		if not InCombatLockdown() then
			self:SetScale(characterSettings["FrameScale"] * 0.9)
		end
	end
end

function UnitFramesImproved_SetFrameScale(scale)
	if not InCombatLockdown() then
		-- Scale the main frames
		PlayerFrame:SetScale(scale)
		TargetFrame:SetScale(scale)
		if (FocusFrame) then -- Support WoW Classic by checking for FocusFrame
			FocusFrame:SetScale(scale)
		end

		-- Scale sub-frames
		ComboFrame:SetScale(scale) -- Still needed

		characterSettings["FrameScale"] = scale
	end
end

-- Slashcommand stuff
SLASH_UNITFRAMESIMPROVED1 = "/unitframesimproved"
SLASH_UNITFRAMESIMPROVED2 = "/ufi"
SlashCmdList["UNITFRAMESIMPROVED"] = function(msg, editBox)
	local tokens = tokenize(msg)
	if (table.getn(tokens) > 0 and strlower(tokens[1]) == "reset") then
		StaticPopup_Show("LAYOUT_RESET")
	elseif (table.getn(tokens) > 0 and strlower(tokens[1]) == "settings") then
		InterfaceOptionsFrame_OpenToCategory(UnitFramesImproved.panelSettings)
	elseif (table.getn(tokens) > 0 and strlower(tokens[1]) == "scale") then
		if (table.getn(tokens) > 1) then
			UnitFramesImproved_SetFrameScale(tokens[2])
		else
			dout("Please supply a number, between 0.0 and 10.0 as the second parameter.")
		end
	else
		dout("Valid commands for UnitFramesImproved are:")
		dout("    help    (shows this message)")
		dout("    scale # (scales the player frames)")
		dout("    reset   (resets the scale of the player frames)")
		dout("")
	end
end

-- Setup the static popup dialog for resetting the UI
StaticPopupDialogs["LAYOUT_RESET"] = {
	text = "Are you sure you want to reset your scale?",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		UnitFramesImproved_LoadDefaultSettings()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true
}

StaticPopupDialogs["LAYOUT_RESETDEFAULT"] = {
	text = "In order for UnitFramesImproved to work properly,\nyour old layout settings need to be reset.\nThis will reload your UI.",
	button1 = "Reset",
	button2 = "Ignore",
	OnAccept = function()
		PlayerFrame:SetUserPlaced(false)
		ReloadUI()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true
}

function UnitFramesImproved_TextStatusBar_UpdateTextStringWithValues(statusFrame, textString, value, valueMin, valueMax)
	if (statusFrame.LeftText and statusFrame.RightText) then
		statusFrame.LeftText:SetText("")
		statusFrame.RightText:SetText("")
		statusFrame.LeftText:Hide()
		statusFrame.RightText:Hide()
		textString:Show()
	end

	-- if RealMobHealth addon is loadad let him handle all the values
	if IsAddOnLoaded("RealMobHealth") then
		return
	end

	if ((tonumber(valueMax) ~= valueMax or valueMax > 0) and not (statusFrame.pauseUpdates)) then
		local valueDisplay = value
		local valueMaxDisplay = valueMax
		if (statusFrame.capNumericDisplay) then
			valueDisplay = UnitFramesImproved_AbbreviateLargeNumbers(value)
			valueMaxDisplay = UnitFramesImproved_AbbreviateLargeNumbers(valueMax)
		else
			valueDisplay = BreakUpLargeNumbers(value)
			valueMaxDisplay = BreakUpLargeNumbers(valueMax)
		end

		local textDisplay = GetCVar("statusTextDisplay")
		if (textDisplay == "NONE") then
			return
		end

		if
			(value and valueMax > 0 and (textDisplay ~= "NUMERIC" or statusFrame.showPercentage) and not statusFrame.showNumeric)
		 then
			-- if ( value == 0 and statusFrame.zeroText ) then
			-- textString:SetText(statusFrame.zeroText);
			-- statusFrame.isZero = 1;
			-- textString:Show();
			-- return;
			-- end

			number = math.ceil((value / valueMax) * 100)
			percent = number .. "%"
			if (textDisplay == "BOTH" and not statusFrame.showPercentage) then
				valueDisplay = valueDisplay .. " (" .. percent .. ")"
				textString:SetText(valueDisplay)
			else
				valueDisplay = percent
				if
					(statusFrame.prefix and
						(statusFrame.alwaysPrefix or
							not (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable and number > 0)))
				 then
					textString:SetText(statusFrame.prefix .. " " .. valueDisplay)
				else
					textString:SetText(valueDisplay)
				end
			end
		elseif (value == 0 and statusFrame.zeroText) then
			-- textString:SetText(statusFrame.zeroText);
			-- statusFrame.isZero = 1;
			-- textString:Show();
			return
		else
			statusFrame.isZero = nil
			if
				(statusFrame.prefix and
					(statusFrame.alwaysPrefix or
						not (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable)))
			 then
				textString:SetText(statusFrame.prefix .. " " .. valueDisplay .. "/" .. valueMaxDisplay)
			else
				textString:SetText(valueDisplay .. "/" .. valueMaxDisplay)
			end
		end
	end
end

function UnitFramesImproved_PlayerFrame_ToPlayerArt(self)
	if not InCombatLockdown() then
		UnitFramesImproved_Style_PlayerFrame()
	end
end

function UnitFramesImproved_PlayerFrame_ToVehicleArt(self)
	if not InCombatLockdown() then
		PlayerFrameHealthBar:SetHeight(12)
		PlayerFrameHealthBarText:SetPoint("CENTER", 50, 3)
	end
end

function UnitFramesImproved_TargetFrame_Update(self)
	-- Set back color of health bar
	if (not UnitPlayerControlled(self.unit) and UnitIsTapDenied(self.unit)) then
		-- Gray if npc is tapped by other player
		self.healthbar:SetStatusBarColor(0.5, 0.5, 0.5)
	else
		-- Standard by class etc if not
		self.healthbar:SetStatusBarColor(UnitColor(self.healthbar.unit))
	end

	if ((UnitHealth(self.unit) <= 0) and UnitIsConnected(self.unit)) then
		if (not UnitIsUnconscious(self.unit)) then
			if (self.healthbar.TextString) then
				self.healthbar.TextString:Hide()
				self.healthbar.forceHideText = true
			end
		end
	end
end

function UnitFramesImproved_TargetFrame_CheckClassification(self, forceNormalTexture)
	local texture
	local classification = UnitClassification(self.unit)
	if (classification == "worldboss" or classification == "elite") then
		texture = "Interface\\Addons\\UnitFramesImproved\\Textures\\UI-TargetingFrame-Elite"
	elseif (classification == "rareelite") then
		texture = "Interface\\Addons\\UnitFramesImproved\\Textures\\UI-TargetingFrame-Rare-Elite"
	elseif (classification == "rare") then
		texture = "Interface\\Addons\\UnitFramesImproved\\Textures\\UI-TargetingFrame-Rare"
	end
	if (texture and not forceNormalTexture) then
		self.borderTexture:SetTexture(texture)
	else
		if (not (classification == "minus")) then
			self.borderTexture:SetTexture("Interface\\Addons\\UnitFramesImproved\\Textures\\UI-TargetingFrame")
		end
	end

	self.nameBackground:Hide()
end

function UnitFramesImproved_TargetFrame_CheckFaction(self)
	local factionGroup = UnitFactionGroup(self.unit)
	if (UnitIsPVPFreeForAll(self.unit)) then
		self.pvpIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA")
		self.pvpIcon:Show()
	elseif (factionGroup and UnitIsPVP(self.unit) and UnitIsEnemy("player", self.unit)) then
		self.pvpIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA")
		self.pvpIcon:Show()
	elseif (factionGroup == "Alliance" or factionGroup == "Horde") then
		self.pvpIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-" .. factionGroup)
		self.pvpIcon:Show()
	else
		self.pvpIcon:Hide()
	end

	UnitFramesImproved_Style_TargetFrame(self)
end

-- Utility functions
function UnitColor(unit)
	local r, g, b
	if ((not UnitIsPlayer(unit)) and ((not UnitIsConnected(unit)) or (UnitIsDeadOrGhost(unit)))) then
		--Color it gray
		r, g, b = 0.5, 0.5, 0.5
	elseif (UnitIsPlayer(unit)) then
		--Try to color it by class.
		local localizedClass, englishClass = UnitClass(unit)
		local classColor = RAID_CLASS_COLORS[englishClass]
		if (classColor) then
			r, g, b = classColor.r, classColor.g, classColor.b
		else
			if (UnitIsFriend("player", unit)) then
				r, g, b = 0.0, 1.0, 0.0
			else
				r, g, b = 1.0, 0.0, 0.0
			end
		end
	else
		r, g, b = UnitSelectionColor(unit)
	end

	return r, g, b
end

function UnitFramesImproved_AbbreviateLargeNumbers(value)
	local strLen = strlen(value)
	local retString = value

	if (strLen >= 10) then
		retString = string.sub(value, 1, -10) .. "." .. string.sub(value, -9, -8) .. "G"
	elseif (strLen >= 7) then
		retString = string.sub(value, 1, -7) .. "." .. string.sub(value, -6, -5) .. "M"
	elseif (strLen >= 4) then
		retString = string.sub(value, 1, -4) .. "." .. string.sub(value, -3, -3) .. "k"
	end

	return retString
end

-- Bootstrap
function UnitFramesImproved_StartUp(self)
	self:SetScript(
		"OnEvent",
		function(self, event)
			self[event](self)
		end
	)
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("VARIABLES_LOADED")
end

UnitFramesImproved_StartUp(UnitFramesImproved)

-- Table Dump Functions -- http://lua-users.org/wiki/TableSerialization
function print_r(t, indent, done)
	done = done or {}
	indent = indent or ""
	local nextIndent  -- Storage for next indentation value
	for key, value in pairs(t) do
		if type(value) == "table" and not done[value] then
			nextIndent = nextIndent or (indent .. string.rep(" ", string.len(tostring(key)) + 2))
			-- Shortcut conditional allocation
			done[value] = true
			print(indent .. "[" .. tostring(key) .. "] => Table {")
			print(nextIndent .. "{")
			print_r(value, nextIndent .. string.rep(" ", 2), done)
			print(nextIndent .. "}")
		else
			print(indent .. "[" .. tostring(key) .. "] => " .. tostring(value) .. "")
		end
	end
end
