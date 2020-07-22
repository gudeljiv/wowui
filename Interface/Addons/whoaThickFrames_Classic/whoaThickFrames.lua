whoa = {}
cfg = {}

local rmhAddon = IsAddOnLoaded("RealMobHealth")
local mi2addonaddon = IsAddOnLoaded("MobInfo2-Classic")
local lortiUIaddon = IsAddOnLoaded("Lorti-UI-Classic")

local ghostText = "Ghost" -- for manual localization of word when you are dead and in ghost shape.
local offlineText = "Offline"
local deadText = DEAD

--	Blue shamans instead of pink.
function blueShamans()
	if (cfg.blueShamans == true) then
		RAID_CLASS_COLORS["SHAMAN"] = CreateColor(0.0, 0.44, 0.87)
		RAID_CLASS_COLORS["SHAMAN"].colorStr = RAID_CLASS_COLORS["SHAMAN"]:GenerateHexColor()
	end
end

--	Player class colors HP.
function unitClassColors(healthbar, unit)
	local classColor = cfg.classColor
	if UnitIsPlayer(unit) and UnitClass(unit) and classColor then
		_, class = UnitClass(unit)
		local class = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
		healthbar:SetStatusBarColor(class.r, class.g, class.b)
		if not UnitIsConnected(unit) then
			healthbar:SetStatusBarColor(0.6, 0.6, 0.6, 0.5)
		end
	end
	-- PlayerFrameHealthBar:SetStatusBarColor(0,0.9,0);
end
hooksecurefunc("UnitFrameHealthBar_Update", unitClassColors)
hooksecurefunc(
	"HealthBar_OnValueChanged",
	function(self)
		unitClassColors(self, self.unit)
	end
)

-- Enemy player color override
-- local function playerHPColorOverride(healthbar)
-- if (cfg.reactionColor == true) then
-- if UnitIsPlayer("target") and UnitIsEnemy("player","target") then	--	Target enemy player color
-- healthbar:SetStatusBarColor(0.9,0.0,0.0);		-- red color.
-- end
-- end
-- end
-- hooksecurefunc("UnitFrameHealthBar_Update", playerHPColorOverride)
-- hooksecurefunc("HealthBar_OnValueChanged", function(self)
-- playerHPColorOverride(self, self.unit)
-- end)

--	Blizzard´s target unit reactions HP color
function npcReactionBrightColors()
	if cfg.BlizzardReactionColor == true then
		FACTION_BAR_COLORS = {
			[1] = {r = 0.9, g = 0.0, b = 0.0},
			[2] = {r = 0.9, g = 0.0, b = 0.0},
			[3] = {r = 0.9, g = 0.0, b = 0.0},
			[4] = {r = 1, g = 0.8, b = 0.0},
			[5] = {r = 0.0, g = 0.9, b = 0.0},
			[6] = {r = 0.0, g = 0.9, b = 0.0},
			[7] = {r = 0.0, g = 0.9, b = 0.0},
			[8] = {r = 0.0, g = 0.9, b = 0.0}
		}
	end
end
-- hooksecurefunc("TargetFrame_CheckFaction", npcReactionBrightColors)

--	Whoa´s customs target unit reactions HP colors.
local function npcReactionColors(healthbar, unit)
	if (cfg.reactionColor == true) then
		if UnitExists(unit) and (not UnitIsPlayer(unit)) then
			local reaction = FACTION_BAR_COLORS[UnitReaction(unit, "player")]
			if reaction then
				healthbar:SetStatusBarColor(reaction.r, reaction.g, reaction.b)
			else
				healthbar:SetStatusBarColor(0, 0.6, 0.1)
			end
			if (UnitIsTapDenied(unit)) then
				healthbar:SetStatusBarColor(0.5, 0.5, 0.5)
			elseif UnitIsCivilian(unit) then
				healthbar:SetStatusBarColor(1.0, 1.0, 1.0)
			end
		end
	elseif not cfg.reactionColor then
		if UnitExists(unit) and (not UnitIsPlayer(unit)) then
			healthbar:SetStatusBarColor(0, 0.9, 0)
		end
	end
end
hooksecurefunc("UnitFrameHealthBar_Update", npcReactionColors)
hooksecurefunc(
	"HealthBar_OnValueChanged",
	function(self)
		npcReactionColors(self, self.unit)
	end
)

--	Aura positioning constants.
local LARGE_AURA_SIZE = 22 --	cfg.largeAuraSize;		--	Default 21.
local SMALL_AURA_SIZE = 18 --	cfg.smallAuraSize;		--	Default 17.
local AURA_OFFSET_Y = 4
local AURA_ROW_WIDTH = 122
local NUM_TOT_AURA_ROWS = 2

--	Set aura size.
local function auraResize(
	self,
	auraName,
	numAuras,
	numOppositeAuras,
	largeAuraList,
	updateFunc,
	maxRowWidth,
	offsetX,
	mirrorAurasVertically)
	if (cfg.bigAuras == true) then
		local size
		local offsetY = AURA_OFFSET_Y
		local rowWidth = 0
		local firstBuffOnRow = 1
		for i = 1, numAuras do
			if (largeAuraList[i]) then
				size = LARGE_AURA_SIZE --(cfg.largeAuraSize)
				offsetY = AURA_OFFSET_Y + AURA_OFFSET_Y
			else
				size = SMALL_AURA_SIZE --(cfg.smallAuraSize) --
			end
			if (i == 1) then
				rowWidth = size
				self.auraRows = self.auraRows + 1
			else
				rowWidth = rowWidth + size + offsetX
			end
			if (rowWidth > maxRowWidth) then
				updateFunc(self, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY, mirrorAurasVertically)
				rowWidth = size
				self.auraRows = self.auraRows + 1
				firstBuffOnRow = i
				offsetY = AURA_OFFSET_Y
				if (self.auraRows > NUM_TOT_AURA_ROWS) then
					maxRowWidth = AURA_ROW_WIDTH
				end
			else
				updateFunc(self, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY, mirrorAurasVertically)
			end
		end
	end
end
hooksecurefunc("TargetFrame_UpdateAuraPositions", auraResize)

local function CreateStatusBarText(name, parentName, parent, point, x, y)
	local fontString = parent:CreateFontString(parentName .. name, nil, "TextStatusBarText")
	fontString:SetPoint(point, parent, point, x, y)
	return fontString
end
local function CreateDeadText(name, parentName, parent, point, x, y)
	local fontString = parent:CreateFontString(parentName .. name, nil, "GameFontNormalSmall")
	fontString:SetPoint(point, parent, point, x, y)
	return fontString
end
local function targetFrameStatusText()
	if not mi2addon then
		TargetFrameHealthBar.TextString =
			CreateStatusBarText("Text", "TargetFrameHealthBar", TargetFrameTextureFrame, "CENTER", 0, 0)
		TargetFrameHealthBar.LeftText =
			CreateStatusBarText("TextLeft", "TargetFrameHealthBar", TargetFrameTextureFrame, "LEFT", 5, 0)
		TargetFrameHealthBar.RightText =
			CreateStatusBarText("TextRight", "TargetFrameHealthBar", TargetFrameTextureFrame, "RIGHT", -3, 0)
		TargetFrameManaBar.TextString =
			CreateStatusBarText("Text", "TargetFrameManaBar", TargetFrameTextureFrame, "CENTER", 0, 0)
		TargetFrameManaBar.LeftText =
			CreateStatusBarText("TextLeft", "TargetFrameManaBar", TargetFrameTextureFrame, "LEFT", 5, 0)
		TargetFrameManaBar.RightText =
			CreateStatusBarText("TextRight", "TargetFrameManaBar", TargetFrameTextureFrame, "RIGHT", -3, 0)
	end
	TargetFrameTextureFrameGhostText =
		CreateDeadText("GhostText", "TargetFrameHealthBar", TargetFrameHealthBar, "CENTER", 0, 0)
	TargetFrameTextureFrameOfflineText =
		CreateDeadText("OfflineText", "TargetFrameHealthBar", TargetFrameHealthBar, "CENTER", 0, 0)
	PlayerFrameDeadText = CreateDeadText("DeadText", "PlayerFrame", PlayerFrameHealthBar, "CENTER", 0, 0)
	PlayerFrameGhostText = CreateDeadText("GhostText", "PlayerFrame", PlayerFrameHealthBar, "CENTER", 0, 0)

	PlayerFrameDeadText:SetText(DEAD)
	PlayerFrameGhostText:SetText(ghostText)
	TargetFrameTextureFrameGhostText:SetText(ghostText)
	TargetFrameTextureFrameOfflineText:SetText(offlineText)
end
targetFrameStatusText()

local function playerFontStyle(self)
	if (cfg.styleFont) then
		self.healthbar.LeftText:SetFontObject(SystemFont_Outline_Small)
		self.healthbar.RightText:SetFontObject(SystemFont_Outline_Small)
		self.manabar.LeftText:SetFontObject(SystemFont_Outline_Small)
		self.manabar.RightText:SetFontObject(SystemFont_Outline_Small)
		self.healthbar.TextString:SetFontObject(SystemFont_Outline_Small)
		self.manabar.TextString:SetFontObject(SystemFont_Outline_Small)
	end
end
hooksecurefunc("PlayerFrame_ToPlayerArt", playerFontStyle)

local function targetFontStyle(self)
	if not mi2addon and (cfg.styleFont) then
		self.healthbar.LeftText:SetFontObject(SystemFont_Outline_Small)
		self.healthbar.RightText:SetFontObject(SystemFont_Outline_Small)
		self.manabar.LeftText:SetFontObject(SystemFont_Outline_Small)
		self.manabar.RightText:SetFontObject(SystemFont_Outline_Small)
		self.healthbar.TextString:SetFontObject(SystemFont_Outline_Small)
		self.manabar.TextString:SetFontObject(SystemFont_Outline_Small)
	end
end
hooksecurefunc("TargetFrame_CheckClassification", targetFontStyle)

local function whoaXpBarFontStyle(self)
	if not mi2addon and (cfg.styleFont) then
		MainMenuBarExpText:SetFontObject(SystemFont_Outline_Small)
	end
end
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", whoaXpBarFontStyle)

-- NOTE: Blizzards API will return targets current and max healh as a percentage instead of exact value (ex. 100/100).
local function customStatusTex(statusFrame, textString, value, valueMin, valueMax)
	local xpValue = UnitXP("player")
	local xpMaxValue = UnitXPMax("player")

	if (statusFrame.LeftText and statusFrame.RightText) then
		statusFrame.LeftText:SetText("")
		statusFrame.RightText:SetText("")
		statusFrame.LeftText:Hide()
		statusFrame.RightText:Hide()
	end

	if ((tonumber(valueMax) ~= valueMax or valueMax > 0) and not (statusFrame.pauseUpdates)) then
		statusFrame:Show()

		if ((statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable) or statusFrame.forceShow) then
			textString:Show()
		elseif (statusFrame.lockShow > 0 and (not statusFrame.forceHideText)) then
			textString:Show()
		else
			textString:SetText("")
			textString:Hide()
			return
		end

		local k, m = 1e3
		local m = k * k

		valueDisplay =
			((value >= 1e3 and value < 1e5 and format("%1.3f", value / k)) or --	1.000
			(value >= 1e5 and value < 1e6 and format("%1.0f K", value / k)) or --	100k
			(value >= 1e6 and value < 1e7 and format("%1.1f M", value / m)) or --	1.0M
			(value >= 1e7 and format("%1.2f M", value / m)) or
			value) --	10.00M +

		valueMaxDisplay =
			((valueMax >= 1e3 and valueMax < 1e5 and format("%1.3f", valueMax / k)) or
			(valueMax >= 1e5 and valueMax < 1e6 and format("%1.0f K", valueMax / k)) or
			(valueMax >= 1e6 and valueMax < 1e7 and format("%1.1f M", valueMax / m)) or
			(valueMax >= 1e7 and format("%1.2f M", valueMax / m)) or
			valueMax)

		xpValueDisplay = (xpValue >= 1e3 and format("%1.3f", xpValue / k) or xpValue)

		xpMaxValueDisplay = (xpMaxValue >= 1e3 and format("%1.3f", xpMaxValue / k) or xpMaxValue)

		-- valueDisplay = AbbreviateLargeNumbers(value);
		-- valueMaxDisplay = AbbreviateLargeNumbers(valueMax);
		-- xpValueDisplay = BreakUpLargeNumbers(xpValue);
		-- xpMaxValueDisplay = BreakUpLargeNumbers(xpMaxValue);

		local textDisplay = GetCVar("statusTextDisplay")
		if
			(value and valueMax > 0 and ((textDisplay ~= "NUMERIC" and textDisplay ~= "NONE") or statusFrame.showPercentage) and
				not statusFrame.showNumeric)
		 then
			if (value == 0 and statusFrame.zeroText) then
				textString:SetText(statusFrame.zeroText)
				statusFrame.isZero = 1
				textString:Show()
			elseif (textDisplay == "BOTH" and not statusFrame.showPercentage) then
				if (statusFrame.LeftText and statusFrame.RightText) then
					if (not statusFrame.powerToken or statusFrame.powerToken == "MANA") then
						statusFrame.LeftText:SetText(math.ceil((value / valueMax) * 100) .. "%") -- % both.
						if value == 0 then
							statusFrame.LeftText:SetText("")
						end
						statusFrame.LeftText:Show()
					end
					statusFrame.RightText:SetText(valueDisplay) -- both rtext.
					if value == 0 then
						statusFrame.RightText:SetText("")
					end
					statusFrame.RightText:Show()
					textString:Hide()
				else
					valueDisplay = "(" .. math.ceil((value / valueMax) * 100) .. "%) " .. xpValueDisplay .. " / " .. xpMaxValueDisplay -- xp both.
					if value == 0 then
						textString:SetText("")
					end
				end
				textString:SetText(valueDisplay)
			else
				valueDisplay = math.ceil((value / valueMax) * 100) .. "%"
				if
					(statusFrame.prefix and
						(statusFrame.alwaysPrefix or
							not (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable)))
				 then
					textString:SetText(statusFrame.prefix .. " " .. valueDisplay) --	xp %.
				else
					textString:SetText(valueDisplay) -- %.
				end
				if value == 0 then
					textString:SetText("")
				end
			end
		elseif (value == 0 and statusFrame.zeroText) then
			textString:SetText(statusFrame.zeroText)
			statusFrame.isZero = 1
			textString:Show()
			return
		else
			statusFrame.isZero = nil
			if
				(statusFrame.prefix and
					(statusFrame.alwaysPrefix or
						not (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable)))
			 then
				textString:SetText(statusFrame.prefix .. " " .. valueDisplay .. " / " .. valueMaxDisplay) --	xp # / none, + none.
				MainMenuBarExpText:SetText(statusFrame.prefix .. " " .. xpValueDisplay .. "  / " .. xpMaxValueDisplay) -- xp override.
			else
				textString:SetText(valueDisplay .. " / " .. valueMaxDisplay) -- #.
			end
			if value == 0 then
				textString:SetText("")
			end
		end
	else
		textString:Hide()
		textString:SetText("")
		if (not statusFrame.alwaysShow) then
			statusFrame:Hide()
		else
			statusFrame:SetValue(0)
		end
	end
end
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", customStatusTex)

-- Dead, Ghost and Offline text.
function whoaCheckDead(self)
	local textDisplay = GetCVar("statusTextDisplay")

	if UnitIsDeadOrGhost("player") then
		if textDisplay == "BOTH" then
			PlayerFrameHealthBarTextLeft:Hide()
			PlayerFrameHealthBarTextRight:Hide()
			PlayerFrameManaBarTextLeft:Hide()
			PlayerFrameManaBarTextRight:Hide()
		else
			PlayerFrameHealthBarText:Hide()
			PlayerFrameManaBarText:Hide()
		end
	else
	end
	if UnitIsDead("player") then
		PlayerFrameDeadText:Show()
		PlayerFrameGhostText:Hide()
	elseif UnitIsGhost("player") then
		PlayerFrameDeadText:Hide()
		PlayerFrameGhostText:Show()
	else
		PlayerFrameDeadText:Hide()
		PlayerFrameGhostText:Hide()
	end

	if UnitIsDeadOrGhost("target") or not UnitIsConnected("target") then
		if textDisplay == "BOTH" then
			TargetFrameHealthBarTextLeft:Hide()
			TargetFrameHealthBarTextRight:Hide()
			TargetFrameManaBarTextLeft:Hide()
			TargetFrameManaBarTextRight:Hide()
		else
			TargetFrameHealthBarText:Hide()
			TargetFrameManaBarText:Hide()
		end
	else
	end
	if UnitIsDead("target") then
		TargetFrameTextureFrameDeadText:Show()
		TargetFrameTextureFrameGhostText:Hide()
	elseif UnitIsGhost("target") then
		TargetFrameTextureFrameDeadText:Hide()
		TargetFrameTextureFrameGhostText:Show()
	else
		TargetFrameTextureFrameDeadText:Hide()
		TargetFrameTextureFrameGhostText:Hide()
	end
	if not UnitIsConnected("target") then
		TargetFrameTextureFrameOfflineText:Show()
		TargetFrameManaBar:Hide()
	else
		TargetFrameTextureFrameOfflineText:Hide()
	end
end
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", whoaCheckDead)
