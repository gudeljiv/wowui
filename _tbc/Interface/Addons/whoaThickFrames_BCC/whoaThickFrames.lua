cfg = {}

-- palyer frame class color selector.
function whoaUnitColor(unit)
	if (cfg.reactColor) then
		if UnitIsTapDenied(unit) then
			r, g, b = 0.5, 0.5, 0.5;
		elseif UnitIsCivilian(unit) then
			r, g, b = 1.0, 1.0, 1.0;
		else
			r, g, b = UnitSelectionColor(unit);
			if (b >= 0.9) then g, b = 0.9, 0; end
			if not (cfg.blizzColors) then
				if (r >= 0.9) and (g >= 0.5) and (g <= 0.6) and (b == 0) then
					r, g, b = r, g, b; -- orange.
				elseif (r >= 0.9) and (g >= 0.9) and (b == 0) then
					r, g, b = 0.9, 0.75, 0; -- yellow.
				elseif (r >= 0.9) and (g == 0) and (b == 0) then
					r, g, b = 0.8, 0.1, 0; -- red.
				else
					r, g, b = 0, 0.6, 0.1; -- green.
				end
			end
		end
	else
		r, g, b = 0, 0.9, 0;
	end
	if UnitIsPlayer(unit) then
		if not UnitIsConnected(unit) then
			r, g, b = 0.5, 0.5, 0.5;
		elseif UnitClass(unit) and (cfg.classColor) then
			_, class = UnitClass(unit);
			local c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
				r, g, b = c.r, c.g, c.b;
			else
		end
	end
	return r, g, b;
end
-- fix.
hooksecurefunc("HealthBar_OnValueChanged", function(self)
	PlayerFrameHealthBar:SetStatusBarColor(whoaUnitColor("player"));
end)

--	Name / numeric threat display.
-- local whoaThreatFrame = CreateFrame("Frame")
-- PlayerFrame:SetScript('OnUpdate', function(self)
	-- if TargetFrameNumericalThreat:IsVisible() or
		-- FocusFrameNumericalThreat:IsVisible() then
		-- PlayerName:Hide();
	-- else
		-- PlayerName:Show();
	-- end
-- end)

function WhoaGroupIndicator()
	local name, rank, subgroup;
	if ( not IsInRaid() ) then
		return;
	end
	local numGroupMembers = GetNumGroupMembers();
	for i=1, MAX_RAID_MEMBERS do
		if ( i <= numGroupMembers ) then
			name, rank, subgroup = GetRaidRosterInfo(i);
			if ( name == UnitName("player") ) then
				PlayerFrameGroupIndicatorText:SetText("G"..subgroup);
				PlayerFrameGroupIndicator:SetWidth(PlayerFrameGroupIndicatorText:GetWidth());-- +40);
				PlayerFrameGroupIndicator:Show();
			end
		end
	end
end
hooksecurefunc("PlayerFrame_UpdateGroupIndicator", WhoaGroupIndicator)

-- Unit frames Status text reformat.
local function customStatusTex(statusFrame, textString, value, valueMin, valueMax)
	local xpValue = UnitXP("player");
	local xpMaxValue = UnitXPMax("player");

	if (statusFrame.LeftText and statusFrame.RightText) then
		statusFrame.LeftText:SetText("");
		statusFrame.RightText:SetText("");
		statusFrame.LeftText:Hide();
		statusFrame.RightText:Hide();
	end

	local k, m = 1e3
	local m = k * k

	--	whoa custom status text abbreviation.
	valueDisplay =
		((value > 1e3 and value < 1e5 and format("%1.3f", value / k)) or
		(value >= 1e5 and value < 1e6 and format("%1.0f K", value / k)) or
		(value >= 1e6 and value < 1e9 and format("%1.2f M", value / m)) or
		(value >= 1e9 and format("%1.1f M", value / m)) or value)

	valueMaxDisplay = ((valueMax > 1e3 and valueMax < 1e5 and format("%1.3f", valueMax / k)) or
		(valueMax >= 1e5 and valueMax < 1e6 and format("%1.0f K", valueMax / k)) or
		(valueMax >= 1e6 and valueMax < 1e9 and format("%1.2f M", valueMax / m)) or
		(valueMax >= 1e9 and format("%1.1f M", valueMax / m)) or valueMax)

	if ((tonumber(valueMax) ~= valueMax or valueMax > 0) and not (statusFrame.pauseUpdates)) then
		statusFrame:Show();

		if ((statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable) or statusFrame.forceShow) then
			textString:Show();
		elseif (statusFrame.lockShow > 0 and (not statusFrame.forceHideText)) then
			textString:Show();
		else
			textString:SetText("");
			textString:Hide();
			return;
		end
		local textDisplay = GetCVar("statusTextDisplay");
		if (value and valueMax > 0 and (textDisplay ~= "NUMERIC" and textDisplay ~= "NONE") and not statusFrame.showNumeric) then
			if (value == 0 and statusFrame.zeroText) then
				textString:SetText(statusFrame.zeroText);
				statusFrame.isZero = 1;
				textString:Show();
			elseif (textDisplay == "BOTH") then
				if (statusFrame.LeftText and statusFrame.RightText) then
					if (not statusFrame.powerToken or statusFrame.powerToken == "MANA") then
						statusFrame.LeftText:SetText(math.ceil((value / valueMax) * 100) .. "%");
						if value == 0 then
							statusFrame.LeftText:SetText("");
						end
						statusFrame.LeftText:Show();
					end
					statusFrame.RightText:SetText(valueDisplay);
					if value == 0 then
						statusFrame.RightText:SetText("");
					end
					statusFrame.RightText:Show();
					textString:Hide();
				else
					valueDisplay = "(" .. math.ceil((value / valueMax) * 100) .. "%) " .. valueDisplay .. " / " .. valueMaxDisplay;
					if value == 0 then
						textString:SetText("");
					end
				end
				textString:SetText(valueDisplay);
			else
				valueDisplay = math.ceil((value / valueMax) * 100) .. "%";
				if (statusFrame.prefix and (statusFrame.alwaysPrefix or
					not (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable))) then
					textString:SetText(statusFrame.prefix .. " " .. valueDisplay);
				else
					textString:SetText(valueDisplay);
				end
				if value == 0 then textString:SetText(""); end
			end
		elseif (value == 0 and statusFrame.zeroText) then
			textString:SetText(statusFrame.zeroText);
			statusFrame.isZero = 1;
			textString:Show();
			return;
		else
			statusFrame.isZero = nil;
			if (statusFrame.prefix and (statusFrame.alwaysPrefix or
				not (statusFrame.cvar and GetCVar(statusFrame.cvar) == "1" and statusFrame.textLockable))) then
				textString:SetText(statusFrame.prefix .. " " .. valueDisplay .. " / " .. valueMaxDisplay)
			else
				textString:SetText(valueDisplay .. " / " .. valueMaxDisplay);
			end
			if value == 0 then textString:SetText("") end
		end
	else
		textString:Hide();
		textString:SetText("");
		if (not statusFrame.alwaysShow) then
			statusFrame:Hide();
		else
			statusFrame:SetValue(0);
		end
	end
end
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", customStatusTex)

-- aura positioning constants
local AURA_START_X = 5;
local AURA_START_Y = 32;
local AURA_OFFSET_Y = 3;
local LARGE_AURA_SIZE = cfg.largeAuraSize;	-- Default 21.
local SMALL_AURA_SIZE = cfg.smallAuraSize;	-- Default 17.
local AURA_ROW_WIDTH = 130;
local TOT_AURA_ROW_WIDTH = 101;
local NUM_TOT_AURA_ROWS = 2;	-- TODO: replace with TOT_AURA_ROW_HEIGHT functionality if this becomes a problem

function whoaUpdateAuraPositions(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
	local size;
	local offsetY = AURA_OFFSET_Y;
	local rowWidth = 0;
	local firstBuffOnRow = 1;
	if cfg.bigAuras then
		for i=1, numAuras do
			if ( largeAuraList[i] ) then
				size = cfg.largeAuraSize;
				offsetY = AURA_OFFSET_Y + AURA_OFFSET_Y;
			else
				size = cfg.smallAuraSize;
			end
			if ( i == 1 ) then
				rowWidth = size;
				self.auraRows = self.auraRows + 1;
			else
				rowWidth = rowWidth + size + offsetX;
			end
			if ( rowWidth > maxRowWidth ) then
				updateFunc(self, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY, mirrorAurasVertically);

				rowWidth = size;
				self.auraRows = self.auraRows + 1;
				firstBuffOnRow = i;
				offsetY = AURA_OFFSET_Y;
				if ( self.auraRows > NUM_TOT_AURA_ROWS ) then
					maxRowWidth = AURA_ROW_WIDTH;
				end
			else
				updateFunc(self, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY, mirrorAurasVertically);
			end
		end
	end
end
hooksecurefunc("TargetFrame_UpdateAuraPositions", whoaUpdateAuraPositions)

function UpdateBuffAnchor(self, buffName, index, numDebuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
	local point, relativePoint;
	local startY, auraOffsetY;
	if cfg.bigAuras then
		if ( mirrorVertically ) then
			point = "BOTTOM";
			relativePoint = "TOP";
			startY = -5;
			-- if ( self.threatNumericIndicator:IsShown() ) then
				-- startY = startY + self.threatNumericIndicator:GetHeight();
			-- end
			offsetY = - offsetY;
			auraOffsetY = -AURA_OFFSET_Y;
		else
			point = "TOP";
			relativePoint="BOTTOM";
			startY = AURA_START_Y - 3;
			auraOffsetY = AURA_OFFSET_Y;
		end
		local buff = _G[buffName..index];
		if ( index == 1 ) then
			if ( UnitIsFriend("player", self.unit) or numDebuffs == 0 ) then
				buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY);
			else
				buff:SetPoint(point.."LEFT", self.debuffs, relativePoint.."LEFT", 0, -offsetY);
			end
			self.buffs:SetPoint(point.."LEFT", buff, point.."LEFT", 0, 0);
			self.buffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
			self.spellbarAnchor = buff;
		elseif ( anchorIndex ~= (index-1) ) then
			buff:SetPoint(point.."LEFT", _G[buffName..anchorIndex], relativePoint.."LEFT", 0, -offsetY);
			self.buffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
			self.spellbarAnchor = buff;
		else
			buff:SetPoint(point.."LEFT", _G[buffName..anchorIndex], point.."RIGHT", offsetX, 0);
		end
		buff:SetWidth(size);
		buff:SetHeight(size);
	end
end
hooksecurefunc("TargetFrame_UpdateBuffAnchor", UpdateBuffAnchor)

function UpdateDebuffAnchor(self, debuffName, index, numBuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
	local buff = _G[debuffName..index];
	local isFriend = UnitIsFriend("player", self.unit);
	local point, relativePoint;
	local startY, auraOffsetY;
	if cfg.bigAuras then
		if ( mirrorVertically ) then
			point = "BOTTOM";
			relativePoint = "TOP";
			startY = -5;
			-- if ( self.threatNumericIndicator:IsShown() ) then
				-- startY = startY + self.threatNumericIndicator:GetHeight();
			-- end
			offsetY = - offsetY;
			auraOffsetY = -AURA_OFFSET_Y;
		else
			point = "TOP";
			relativePoint="BOTTOM";
			startY = AURA_START_Y - 3;
			auraOffsetY = AURA_OFFSET_Y;
		end
		if ( index == 1 ) then
			if ( isFriend and numBuffs > 0 ) then
				buff:SetPoint(point.."LEFT", self.buffs, relativePoint.."LEFT", 0, -offsetY);
			else
				buff:SetPoint(point.."LEFT", self, relativePoint.."LEFT", AURA_START_X, startY);
			end
			self.debuffs:SetPoint(point.."LEFT", buff, point.."LEFT", 0, 0);
			self.debuffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
			if ( ( isFriend ) or ( not isFriend and numBuffs == 0) ) then
				self.spellbarAnchor = buff;
			end
		elseif ( anchorIndex ~= (index-1) ) then
			buff:SetPoint(point.."LEFT", _G[debuffName..anchorIndex], relativePoint.."LEFT", 0, -offsetY);
			self.debuffs:SetPoint(relativePoint.."LEFT", buff, relativePoint.."LEFT", 0, -auraOffsetY);
			if ( ( isFriend ) or ( not isFriend and numBuffs == 0) ) then
				self.spellbarAnchor = buff;
			end
		else
			buff:SetPoint(point.."LEFT", _G[debuffName..(index-1)], point.."RIGHT", offsetX, 0);
		end
		buff:SetWidth(size);
		buff:SetHeight(size);
		local debuffFrame =_G[debuffName..index.."Border"];
		debuffFrame:SetWidth(size+2);
		debuffFrame:SetHeight(size+2);
	end
end
hooksecurefunc("TargetFrame_UpdateDebuffAnchor", UpdateDebuffAnchor)

function whoaSpellbarAdjustPosition(self)
	if cfg.bigAuras then
		local parentFrame = self:GetParent();
		if ( self.boss ) then
			self:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", 25, 10 );
		elseif ( parentFrame.haveToT ) then	-- if have tot.
			if ( parentFrame.buffsOnTop or parentFrame.auraRows <= 1 ) then
				self:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", 25, -21 );
			else
				self:SetPoint("TOPLEFT", parentFrame.spellbarAnchor, "BOTTOMLEFT", 20, -28);
			end
		elseif ( parentFrame.haveElite ) then
			if ( parentFrame.buffsOnTop or parentFrame.auraRows <= 1 ) then
				self:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", 25, -21 );
			else
				self:SetPoint("TOPLEFT", parentFrame.spellbarAnchor, "BOTTOMLEFT", 20, -28);
			end
		else
			if ( (not parentFrame.buffsOnTop) and parentFrame.auraRows > 0 ) then
				self:SetPoint("TOPLEFT", parentFrame.spellbarAnchor, "BOTTOMLEFT", 20, -20);
			else
				self:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", 25, 3 );	-- target no tot
			end
		end
	end
end
hooksecurefunc("Target_Spellbar_AdjustPosition", whoaSpellbarAdjustPosition)

-- local function playerFontStyle(self)
	-- if (cfg.styleFont) then
		-- self.healthbar.LeftText:SetFontObject(SystemFont_Outline_Small);
		-- self.healthbar.RightText:SetFontObject(SystemFont_Outline_Small);
		-- self.manabar.LeftText:SetFontObject(SystemFont_Outline_Small);
		-- self.manabar.RightText:SetFontObject(SystemFont_Outline_Small);
		-- self.healthbar.TextString:SetFontObject(SystemFont_Outline_Small);
		-- self.manabar.TextString:SetFontObject(SystemFont_Outline_Small);
	-- end
-- end
-- hooksecurefunc("PlayerFrame_ToPlayerArt", playerFontStyle)

-- local function targetFontStyle (self)
	-- if (cfg.styleFont) then
		-- self.healthbar.LeftText:SetFontObject(SystemFont_Outline_Small);
		-- self.healthbar.RightText:SetFontObject(SystemFont_Outline_Small);
		-- self.manabar.LeftText:SetFontObject(SystemFont_Outline_Small);
		-- self.manabar.RightText:SetFontObject(SystemFont_Outline_Small);
		-- self.healthbar.TextString:SetFontObject(SystemFont_Outline_Small);
		-- self.manabar.TextString:SetFontObject(SystemFont_Outline_Small);
	-- end
-- end
-- hooksecurefunc("TargetFrame_CheckClassification", targetFontStyle)

local function whoaXpBarFontStyle (self)
	MainMenuBarExpText:SetFontObject(SystemFont_Outline_Small);
end
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", whoaXpBarFontStyle)

-- Text builder factory.
local function CreateText(name, parentName, parent, point, x, y)
	local fontString = parent:CreateFontString(parentName .. name, nil, "GameFontNormalSmall")
	fontString:SetPoint(point, parent, point, x, y)
	return fontString
end

-- Create dead/ghost/offline text.
function createDeadTextFrames(self)
	deadText = CreateText("DeadText", "PlayerFrame", PlayerFrameHealthBar, "CENTER", 0, 0);
	deadText:SetText(DEAD);
	deadText = CreateText("GhostText", "PlayerFrame", PlayerFrameHealthBar, "CENTER", 0, 0);
	deadText:SetText("Ghost");

	deadText = CreateText("GhostText", "TargetFrame", TargetFrameHealthBar, "CENTER", 0, 0);
	deadText:SetText("Ghost");
	deadText = CreateText("OfflineText", "TargetFrame", TargetFrameHealthBar, "CENTER", 0, 0);
	deadText:SetText("Offline");

	deadText = CreateText("GhostText", "FocusFrame", FocusFrameHealthBar, "CENTER", 0, 0);
	deadText:SetText("Ghost");
	deadText = CreateText("OfflineText", "FocusFrame", FocusFrameHealthBar, "CENTER", 0, 0);
	deadText:SetText("Offline");
end

-- Player dead check  switch.
function playerDeadCheck(self)
	if UnitIsDead("player") then
		PlayerFrameDeadText:Show();
		PlayerFrameGhostText:Hide();
		-- PlayerFrameAlternateManaBar:Hide();
	elseif UnitIsGhost("player") then
		PlayerFrameDeadText:Hide();
		PlayerFrameGhostText:Show();
		-- PlayerFrameAlternateManaBar:Hide();
	elseif not (UnitIsDead("player") or UnitIsGhost("player")) then
		PlayerFrameDeadText:Hide();
		PlayerFrameGhostText:Hide();
		-- PlayerFrameAlternateManaBar:Show();
	end
	if UnitExists("player") and UnitIsDead("player") or UnitIsGhost("player") then
		for i, v in pairs({ PlayerFrameHealthBarText, PlayerFrameHealthBar.LeftText, PlayerFrameHealthBar.RightText, 
			PlayerFrameManaBar.LeftText, PlayerFrameManaBar.RightText, PlayerFrameTextureFrameManaBarText, PlayerFrameManaBar
		}) do if v then v:SetAlpha(0); end end
	else
		for i, v in pairs({ PlayerFrameHealthBarText, PlayerFrameHealthBar.LeftText, PlayerFrameHealthBar.RightText, PlayerFrameManaBar.LeftText,
			PlayerFrameManaBar.RightText, PlayerFrameTextureFrameManaBarText, PlayerFrameManaBar	
		}) do if v then v:SetAlpha(1); end end
	end
end

-- Target frame dead check switch.
function targetDeadCheck()
	if UnitIsDead("target") then
		TargetFrameGhostText:Hide();
		TargetFrameOfflineText:Hide();
	elseif UnitIsGhost("target") then
		TargetFrameGhostText:Show();
		TargetFrameOfflineText:Hide();
	elseif UnitIsPlayer("target") and not UnitIsConnected("target") then
		TargetFrameGhostText:Hide();
		TargetFrameOfflineText:Show();
	else
		TargetFrameGhostText:Hide();
		TargetFrameOfflineText:Hide();
	end
	if UnitExists("target") and UnitIsDead("target") or UnitIsGhost("target") or
		not UnitIsConnected("target") then
		for i, v in pairs({	TargetFrameTextureFrame.HealthBarText, TargetFrameHealthBar.LeftText, TargetFrameHealthBar.RightText, 
			TargetFrameTextureFrame.ManaBarText, TargetFrameManaBar.LeftText, TargetFrameManaBar.RightText, TargetFrameManaBar,
		}) do if v then v:SetAlpha(0); end end
	else
		for i, v in pairs({ TargetFrameTextureFrame.HealthBarText, TargetFrameHealthBar.LeftText, TargetFrameHealthBar.RightText, 
			TargetFrameTextureFrame.ManaBarText, TargetFrameManaBar.LeftText, TargetFrameManaBar.RightText, TargetFrameManaBar,
		}) do if v then v:SetAlpha(1); end end
	end
end

-- Focus frame dead check switch.
function focusDeadCheck()
	if UnitIsDead("focus") then
		FocusFrameGhostText:Hide();
		FocusFrameOfflineText:Hide();
	elseif UnitIsGhost("focus") then
		FocusFrameGhostText:Show();
		FocusFrameOfflineText:Hide();
	elseif UnitIsPlayer("focus") and not UnitIsConnected("focus") then
		FocusFrameGhostText:Hide();
		FocusFrameOfflineText:Show();
	else
		FocusFrameGhostText:Hide();
		FocusFrameOfflineText:Hide();
	end
	if UnitExists("focus") and UnitIsDead("focus") or UnitIsGhost("focus") or
		not UnitIsConnected("focus") then
		for i, v in pairs({ FocusFrameTextureFrame.HealthBarText, FocusFrameHealthBar.LeftText, FocusFrameHealthBar.RightText,	
			FocusFrameManaBar.LeftText, FocusFrameManaBar.RightText, FocusFrameTextureFrameManaBarText, FocusFrameManaBar
		}) do if v then v:SetAlpha(0); end end
	else
		for i, v in pairs({ FocusFrameTextureFrame.HealthBarText, FocusFrameHealthBar.LeftText, FocusFrameHealthBar.RightText,
			FocusFrameManaBar.LeftText, FocusFrameManaBar.RightText, FocusFrameTextureFrameManaBarText, FocusFrameManaBar
		}) do if v then v:SetAlpha(1); end end
	end
end

--	Check dead events.
local whoaFrameUpdate = CreateFrame("Frame", "whoaFrameUpdate")
whoaFrameUpdate:RegisterEvent("PLAYER_ENTERING_WORLD");
whoaFrameUpdate:RegisterEvent("PLAYER_TARGET_CHANGED");
whoaFrameUpdate:RegisterEvent("PLAYER_FOCUS_CHANGED");
whoaFrameUpdate:RegisterEvent("PLAYER_DEAD")
whoaFrameUpdate:RegisterEvent("PLAYER_UNGHOST")
whoaFrameUpdate:RegisterEvent("PLAYER_ALIVE")
whoaFrameUpdate:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
whoaFrameUpdate:RegisterEvent("PLAYER_ENTER_COMBAT")
whoaFrameUpdate:RegisterEvent("ADDON_LOADED")
whoaFrameUpdate:RegisterEvent("PLAYER_LOGIN")
whoaFrameUpdate:SetScript('OnEvent', function(self, event, ...)
	if (event == "PLAYER_LOGIN") then
		createDeadTextFrames()
	elseif (event == "PLAYER_ENTERING_WORLD") then
		playerDeadCheck()
	elseif (event == "PLAYER_TARGET_CHANGED") then
		whoaUnitTarget()
		targetDeadCheck()
	elseif (event == "PLAYER_FOCUS_CHANGED") then
		whoaUnitTarget()
		focusDeadCheck()
	-- elseif (event == "UNIT_AURA") then
	-- elseif (event == "UNIT_SPELLCAST_START") then
	elseif (event == "PLAYER_DEAD") then
		playerDeadCheck()
		focusDeadCheck()
	elseif (event == "PLAYER_UNGHOST") then
		playerDeadCheck()
		targetDeadCheck()
		focusDeadCheck()
	elseif (event == "PLAYER_ALIVE") then
		playerDeadCheck()
		targetDeadCheck()
		focusDeadCheck()
	-- elseif (event == "INSTANCE_ENCOUNTER_ENGAGE_UNIT") then
		-- whoaBossFrames();
	elseif (event == "PLAYER_LEVEL_UP") then
		playerDeadCheck()
	end
end)
