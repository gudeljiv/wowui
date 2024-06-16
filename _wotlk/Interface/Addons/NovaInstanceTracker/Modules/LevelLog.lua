------------------------
---NovaInstanceTracker--
------------------------

local L = LibStub("AceLocale-3.0"):GetLocale("NovaInstanceTracker");
local levelLogFrame;
local lastDing = 0;
local logonTime = 0;
local lastPlayed = 0;
local backupPlayedTimer;
local levelCache = UnitLevel("player");
local playedCache, playedCacheWhen;
local waitingForPlayed, reregisterPlayedEvent;

local function getSecondsOnline()
	return GetServerTime() - logonTime;
end

local function getTimeSinceLastDing()
	if (lastDing > 0) then
		return GetServerTime() - lastDing;
	end
end

local function getPlayedCache()
	if (playedCache and playedCacheWhen) then
		return playedCache + (GetServerTime() - playedCacheWhen);
	end
end

function NIT:addLevelLogDing(level, isFirstTime)
	local char = UnitName("player");
	if (isFirstTime) then
		level = UnitLevel("player");
	end
	if (not level or not tonumber(level)) then
		return;
	end
	levelCache = level;
	if (not NIT.data.myChars[char].levelLog) then
		NIT.data.myChars[char].levelLog = {};
	end
	if (not NIT.data.myChars[char].levelLog[level]) then
		NIT.data.myChars[char].levelLog[level] = {};
	end
	NIT.data.myChars[char].levelLog[level].timestamp = GetServerTime();
	local x, y, zone = NIT.dragonLib:GetPlayerZonePosition();
	NIT.data.myChars[char].levelLog[level].zone = zone;
	NIT.data.myChars[char].levelLog[level].x = x;
	NIT.data.myChars[char].levelLog[level].y = y;
	local zoneText = GetZoneText();
	if (zoneText and zoneText ~= "") then
		NIT.data.myChars[char].levelLog[level].zoneName = GetZoneText(); --Zone names are not available at logon.
	else
		NIT.data.myChars[char].levelLog[level].zoneName = NIT.dragonLib:GetLocalizedMap(zone);
	end
	NIT.data.myChars[char].levelLog[level].subzoneName = GetSubZoneText();
	NIT.data.myChars[char].levelLog[level].gold = GetMoney();
	--NIT:debug("Added ding data:", level, GetZoneText(), GetSubZoneText());
	waitingForPlayed = nil; --Reset last played time used for backup timer, incase of super fast leveling like granting levels.
	local pCache = getPlayedCache();
	if (pCache) then
		NIT.data.myChars[char].levelLog[level].played = pCache;
		--NIT:debug("Added played from cache.");
	else
		NIT:requestLevelLogPlayed();
	end
	if (isFirstTime) then
		--Reget zonetext if first logon, its usually an empty string for a while after logon.
		C_Timer.After(20, function()
			NIT:recalcLevelLogZoneText();
		end)
	end
	lastDing = GetServerTime();
end

function NIT:recalcLevelLogZoneText()
	local char = UnitName("player");
	local level = levelCache;
	if (not level or not tonumber(level)) then
		return;
	end
	local x, y, zone = NIT.dragonLib:GetPlayerZonePosition();
	local zoneText = GetZoneText();
	if (zoneText and zoneText ~= "") then
		NIT.data.myChars[char].levelLog[level].zoneName = GetZoneText();
	else
		NIT.data.myChars[char].levelLog[level].zoneName = NIT.dragonLib:GetLocalizedMap(zone);
	end
	NIT.data.myChars[char].levelLog[level].subzoneName = GetSubZoneText();
	--NIT:debug("Recalced level log zone text:", GetZoneText(), GetSubZoneText());
end

--When leveling up.
function NIT:requestLevelLogPlayed()
	waitingForPlayed = true;
	if (NIT:isTimePlayedMsgRegistered()) then
		reregisterPlayedEvent = true;
		NIT:unregisterTimePlayedMsg();
	end
	--Backup timer incase played data fails to come back.
	backupPlayedTimer = C_Timer.NewTimer(5, function()
		NIT:backupPlayedTimer();
	end);
	RequestTimePlayed();
end

--When logging on.
function NIT:requestPlayedCache()
	if (NIT:isTimePlayedMsgRegistered()) then
		reregisterPlayedEvent = true;
		NIT:unregisterTimePlayedMsg();
	end
	RequestTimePlayed();
end

function NIT:addLevelLogPlayed(timestamp)
	if (waitingForPlayed) then
		if (backupPlayedTimer) then
			backupPlayedTimer:Cancel();
			backupPlayedTimer = nil;
		end
		local char = UnitName("player");
		local level = levelCache;
		--Add played if it doesn't exist already in this level table.
		if (not NIT.data.myChars[char].levelLog[level].played) then
			NIT.data.myChars[char].levelLog[level].played = timestamp;
			lastPlayed = GetTime();
			--NIT:debug("Added played.");
		else
			NIT:debug("ERROR: Trying to add level log played with it already exists.", levelCache, UnitLevel("player"));
		end
		waitingForPlayed = nil;
	else
		--NIT:debug("Played received without level log waiting.");
	end
	if (reregisterPlayedEvent) then
		reregisterPlayedEvent = nil;
		C_Timer.After(2, function()
			NIT:registerTimePlayedMsg();
		end)
	end
end

--Backup incase we never receive played time, not sure why this can happen but I think it does on rare occasions?
function NIT:backupPlayedTimer()
	if (waitingForPlayed) then
		local level = levelCache;
		local char = UnitName("player");
		if (not NIT.data.myChars[char].levelLog[level].played) then
			local timeSinceLastDing = getTimeSinceLastDing();
			--Only works if last ding was since being online, need a better system to track played cache reliably later.
			if (timeSinceLastDing) then
				NIT.data.myChars[char].levelLog[level].played = timeSinceLastDing;
				NIT.data.myChars[char].levelLog[level].playedSource = "backupTimer";
				lastPlayed = GetTime();
				NIT:debug("Added played from backup.");
				if (reregisterPlayedEvent) then
					reregisterPlayedEvent = nil;
					C_Timer.After(2, function()
						NIT:registerTimePlayedMsg();
					end)
				end
			end
		end
		waitingForPlayed = nil;
	end
	backupPlayedTimer = nil;
end

function NIT:addLevelLogQuestCount()
	local char = UnitName("player");
	local level = levelCache;
	if (not NIT.data.myChars[char].levelLog or not NIT.data.myChars[char].levelLog[level]) then
		NIT:addLevelLogDing(level);
	end
	if (not NIT.data.myChars[char].levelLog[level].questCount) then
		NIT.data.myChars[char].levelLog[level].questCount = 0;
	end
	NIT.data.myChars[char].levelLog[level].questCount = NIT.data.myChars[char].levelLog[level].questCount + 1;
end

--[[COMBATLOG_XPGAIN_EXHAUSTION1 = "%s dies, you gain %d experience. (%s exp %s bonus)";
COMBATLOG_XPGAIN_EXHAUSTION1_GROUP = "%s dies, you gain %d experience. (%s exp %s bonus, +%d group bonus)";
COMBATLOG_XPGAIN_EXHAUSTION1_RAID = "%s dies, you gain %d experience. (%s exp %s bonus, -%d raid penalty)";
COMBATLOG_XPGAIN_EXHAUSTION2 = "%s dies, you gain %d experience. (%s exp %s bonus)";
COMBATLOG_XPGAIN_EXHAUSTION2_GROUP = "%s dies, you gain %d experience. (%s exp %s bonus, +%d group bonus)";
COMBATLOG_XPGAIN_EXHAUSTION2_RAID = "%s dies, you gain %d experience. (%s exp %s bonus, -%d raid penalty)";
COMBATLOG_XPGAIN_EXHAUSTION4 = "%s dies, you gain %d experience. (%s exp %s penalty)";
COMBATLOG_XPGAIN_EXHAUSTION4_GROUP = "%s dies, you gain %d experience. (%s exp %s penalty, +%d group bonus)";
COMBATLOG_XPGAIN_EXHAUSTION4_RAID = "%s dies, you gain %d experience. (%s exp %s penalty, -%d raid penalty)";
COMBATLOG_XPGAIN_EXHAUSTION5 = "%s dies, you gain %d experience. (%s exp %s penalty)";
COMBATLOG_XPGAIN_EXHAUSTION5_GROUP = "%s dies, you gain %d experience. (%s exp %s penalty, +%d group bonus)";
COMBATLOG_XPGAIN_EXHAUSTION5_RAID = "%s dies, you gain %d experience. (%s exp %s penalty, -%d raid penalty)";
COMBATLOG_XPGAIN_FIRSTPERSON = "%s dies, you gain %d experience.";
COMBATLOG_XPGAIN_FIRSTPERSON_GROUP = "%s dies, you gain %d experience. (+%d group bonus)";
COMBATLOG_XPGAIN_FIRSTPERSON_RAID = "%s dies, you gain %d experience. (-%d raid penalty)";
COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED = "You gain %d experience.";
COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED_GROUP = "You gain %d experience. (+%d group bonus)";
COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED_RAID = "You gain %d experience. (-%d raid penalty)";
COMBATLOG_XPGAIN_QUEST = "You gain %d experience. (%s exp %s bonus)";
COMBATLOG_XPLOSS_FIRSTPERSON_UNNAMED = "You lose %d experience.";]]

local xpStrings = {
	--Only strings that are mob died related, no quest xp.
	["COMBATLOG_XPGAIN_EXHAUSTION1"] = true,
	["COMBATLOG_XPGAIN_EXHAUSTION1_GROUP"] = true,
	["COMBATLOG_XPGAIN_EXHAUSTION1_RAID"] = true,
	["COMBATLOG_XPGAIN_EXHAUSTION2"] = true,
	["COMBATLOG_XPGAIN_EXHAUSTION2_GROUP"] = true,
	["COMBATLOG_XPGAIN_EXHAUSTION2_RAID"] = true,
	["COMBATLOG_XPGAIN_EXHAUSTION4"] = true,
	["COMBATLOG_XPGAIN_EXHAUSTION4_GROUP"] = true,
	["COMBATLOG_XPGAIN_EXHAUSTION4_RAID"] = true,
	["COMBATLOG_XPGAIN_EXHAUSTION5"] = true,
	["COMBATLOG_XPGAIN_EXHAUSTION5_GROUP"] = true,
	["COMBATLOG_XPGAIN_EXHAUSTION5_RAID"] = true,
	["COMBATLOG_XPGAIN_FIRSTPERSON"] = true,
	["COMBATLOG_XPGAIN_FIRSTPERSON_GROUP"] = true,
	["COMBATLOG_XPGAIN_FIRSTPERSON_RAID"] = true,
	["COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED"] = true,
	["COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED_GROUP"] = true,
	["COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED_RAID"] = true,
};

--Only mobs that gave xp.
function NIT:addLevelLogMobCount(text)
	if (LOCALE_enUS or LOCALE_enGB or LOCALE_esES or LOCALE_esMX) then
		--invalid capture index
		--Disabled in some non-english clients until I work out how to capture for all.
		local found;
		for k, v in pairs(xpStrings) do
			if (strmatch(text, string.gsub(string.gsub(_G[k], "%%s", "(.+)"), "%%d", "(%%d+)"))) then
				found = true
				break;
			end
		end
		if (found) then
			local char = UnitName("player");
			local level = levelCache;
			if (not NIT.data.myChars[char].levelLog or not NIT.data.myChars[char].levelLog[level]) then
				NIT:addLevelLogDing(level);
			end
			if (not NIT.data.myChars[char].levelLog[level].mobCount) then
				NIT.data.myChars[char].levelLog[level].mobCount = 0;
			end
			NIT.data.myChars[char].levelLog[level].mobCount = NIT.data.myChars[char].levelLog[level].mobCount + 1;
		else
			--NIT:debug("xp gain with no string match found:", text);
		end
	end
end

local f = CreateFrame("Frame");
f:RegisterEvent("PLAYER_LEVEL_UP");
f:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
f:RegisterEvent("TIME_PLAYED_MSG");
f:RegisterEvent("QUEST_TURNED_IN");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:SetScript('OnEvent', function(self, event, ...)
	if (event == "PLAYER_LEVEL_UP") then
		local level = ...;
		NIT:addLevelLogDing(level);
	elseif (event == "CHAT_MSG_COMBAT_XP_GAIN") then
		local text = ...;
		NIT:addLevelLogMobCount(text);
	elseif (event == "TIME_PLAYED_MSG") then
		local played = ...;
		playedCache = played;
		playedCacheWhen = GetServerTime();
		NIT:addLevelLogPlayed(played);
	elseif (event == "QUEST_TURNED_IN") then
		NIT:addLevelLogQuestCount();
	elseif (event == "PLAYER_ENTERING_WORLD" ) then
		local isLogon, isReload = ...;
		if (isLogon or isReload) then
			--First logon.
			levelCache = UnitLevel("player");
			logonTime = GetServerTime();
			local char = UnitName("player");
			--NIT.data.myChars[char].levelLog = nil;
			if (not NIT.data.myChars[char].levelLog) then
				C_Timer.After(2, function()
					NIT:addLevelLogDing(nil, true);
				end)
			end
			C_Timer.After(5, function()
				--Get played cache at logon.
				NIT:requestPlayedCache();
			end)
		end
	end
end)

function NIT:createLevelLogFrame()
	local frame = CreateFrame("Frame", "NITLevelLogFrame", UIParent, "BackdropTemplate");
	frame.scrollFrame = CreateFrame("ScrollFrame", "$parentScrollFrame", frame, "UIPanelScrollFrameTemplate");
	frame.scrollFrame:SetFrameLevel(5);
	frame.scrollChild = CreateFrame("Frame", "$parentScrollChild", frame.scrollFrame);
	frame.scrollFrame:SetScrollChild(frame.scrollChild);
	frame.scrollChild:SetAllPoints();
	frame.scrollChild:SetPoint("RIGHT", -40, 0);
	frame.scrollChild:SetPoint("TOP", 0, -20);
	frame.scrollChild:SetHeight(20);
	frame.scrollChild:SetScript("OnSizeChanged", function(self,event)
		frame.scrollChild:SetWidth(self:GetWidth())
	end)
	frame.scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -8);
	frame.scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 8);
	
	frame:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8",
		insets = {top = 4, left = 4, bottom = 4, right = 4},
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tileEdge = true,
		edgeSize = 16,
	});
	frame:SetBackdropColor(0, 0, 0, 0.9);
	frame:SetBackdropBorderColor(1, 1, 1, 0.7);
	frame.scrollFrame.ScrollBar:ClearAllPoints();
	frame.scrollFrame.ScrollBar:SetPoint("TOPRIGHT", -5, -(frame.scrollFrame.ScrollBar.ScrollDownButton:GetHeight()) + 1);
	frame.scrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", -5, frame.scrollFrame.ScrollBar.ScrollUpButton:GetHeight());
	frame:SetToplevel(true);
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetPoint("CENTER", UIParent, 0, 100);
	frame:SetSize(720, 450);
	frame:SetFrameStrata("HIGH");
	frame:SetClampedToScreen(true);
	
	frame.topFrame = CreateFrame("Frame", "$parentTopFrame", frame, "BackdropTemplate");
	frame.topFrame:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8",
		insets = {top = 3, left = 3, bottom = 18, right = 3},
		edgeFile = "Interface\\Addons\\EventCounter\\UI-Tooltip-Border-NoBottom",
		tileEdge = true,
		edgeSize = 16,
	});
	frame.topFrame:SetBackdropColor(0, 0, 0, 0.9);
	frame.topFrame:SetBackdropBorderColor(1, 1, 1, 0.7);
	frame.topFrame:SetToplevel(true);
	frame.topFrame:EnableMouse(true);
	frame.topFrame:SetWidth(frame:GetWidth());
	frame.topFrame:SetHeight(42);
	frame.topFrame:SetPoint("BOTTOM", frame, "TOP", 0, -21);
	frame.topFrame:SetFrameLevel(4);
	frame.topFrame.fs = frame.topFrame:CreateFontString("$parentFS", "ARTWORK");
	frame.topFrame.fs:SetPoint("TOP", -20, -5);
	frame.topFrame.fs:SetFontObject(GameFontNormalLarge);
	frame.topFrame.fs:SetText("|cffff6900NIT " ..  L["Level Log"]);
	frame.topFrame.fs2 = frame.topFrame:CreateFontString("$parentFS2", "ARTWORK");
	frame.topFrame.fs2:SetPoint("TOP", 160, -8);
	frame.topFrame.fs2:SetFontObject(GameFontNormalSmall);
	frame.topFrame.fs2:SetText("|cFF9CD6DE(" ..  L["Mouseover log entry for more info"] .. ")");
	frame.topFrame:SetScript("OnMouseDown", function(self, button)
		if (button == "LeftButton" and not frame.isMoving) then
			frame:StartMoving();
			frame.isMoving = true;
		end
	end)
	frame.topFrame:SetScript("OnMouseUp", function(self, button)
		if (button == "LeftButton" and frame.isMoving) then
			frame:StopMovingOrSizing();
			frame.isMoving = false;
		end
	end)
	frame.topFrame:SetScript("OnHide", function(self)
		if (frame.isMoving) then
			frame:StopMovingOrSizing();
			frame.isMoving = false;
		end
	end)
	--[[frame.button = CreateFrame("Button", "$parentButton", frame.topFrame, "UIPanelButtonTemplate");
	frame.button:SetPoint("TOP", -80, -5);
	frame.button:SetWidth(90);
	frame.button:SetHeight(22);
	frame.button:SetText("Refresh");
	frame.button2 = CreateFrame("Button", "$parentButton2", frame.topFrame, "UIPanelButtonTemplate");
	frame.button2:SetPoint("TOPRIGHT", -65, -5);
	frame.button2:SetWidth(50);
	frame.button2:SetHeight(22);
	frame.button2:SetText("Clear");	]]
	frame.close = CreateFrame("Button", "$parentClose", frame.topFrame, "UIPanelCloseButton");
	frame.close:SetPoint("TOPRIGHT", -3, -3);
	frame.close:SetWidth(20);
	frame.close:SetHeight(20);
	frame.close:SetScript("OnClick", function(self, arg)
		frame:Hide();
	end)
	frame.close:GetNormalTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
	frame.close:GetHighlightTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
	frame.close:GetPushedTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
	frame.close:GetDisabledTexture():SetTexCoord(0.1875, 0.8125, 0.1875, 0.8125);
	--Seperate line frames for each string to show tooltips, border, buttons etc.
	frame.simpleLineFrames = {};
	frame.getSimpleLineFrame = function(count, data)
		if (not frame.simpleLineFrames[count]) then
			frame.createSimpleLineFrame(count, data);
		end
		return frame.simpleLineFrames[count];
	end
	frame.createSimpleLineFrame = function(count, data)
		if (not frame.simpleLineFrames[count]) then
			local obj = CreateFrame("Button", "$parentSimpleLine" .. count, frame.scrollChild);
			obj.borderFrame = CreateFrame("Frame", "$parentBorderFrame", obj, "BackdropTemplate");
			obj.borderFrame:SetPoint("TOP", 0, 2);
			obj.borderFrame:SetPoint("BOTTOM", 0, -2);
			obj.borderFrame:SetPoint("LEFT", -2, 0);
			obj.borderFrame:SetPoint("RIGHT", 2, 0);
			obj.borderFrame:SetBackdrop({
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tileEdge = true,
				edgeSize = 16,
			});
			obj.borderFrame:SetBackdropBorderColor(1, 1, 1, 0.2);
			obj:RegisterForClicks("LeftButtonDown", "RightButtonDown");
			
			obj.highlightTex = obj:CreateTexture("$parentHighlightTexture", "HIGHLIGHT");
			obj.highlightTex:SetAlpha(0.5);
			obj.highlightTex:SetTexture("Interface\\ClassTrainerFrame\\TrainerTextures");
			obj.highlightTex:SetTexCoord(0.00195313, 0.57421875, 0.75390625, 0.84570313);
			obj:SetHighlightTexture(obj.highlightTex);
			obj.count = count;
			
			obj.fs = obj:CreateFontString("$parentLineFS" .. count, "ARTWORK");
			--obj.fs:SetFontObject(GameFontNormal);
			obj.fs:SetFont(NIT.regionFont, 14);
			--They don't quite line up properly without justify on top of set point left.
			obj.fs:SetJustifyH("LEFT");
			obj.fs:SetPoint("LEFT", 10, 0);
			obj.fs:SetPoint("RIGHT", 0, 0);
			obj.fs:SetWordWrap(false);
			obj:EnableMouse(true);
			
			obj.tooltip = CreateFrame("Frame", "$parentLineTooltip" .. count, frame, "TooltipBorderedFrameTemplate");
			obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -46);
			obj.tooltip:SetFrameStrata("HIGH");
			obj.tooltip:SetFrameLevel(6);
			--Change the alpha.
			obj.tooltip.NineSlice:SetCenterColor(0, 0, 0, 1);
			obj.tooltip.fs = obj.tooltip:CreateFontString("$parentLineTooltipFS" .. count, "ARTWORK");
			obj.tooltip.fs:SetPoint("CENTER", 0, 0);
			--obj.tooltip.fs:SetFontObject(GameFontNormal);
			obj.tooltip.fs:SetFont(NIT.regionFont, 14);
			obj.tooltip.fs:SetJustifyH("LEFT");
			obj.updateTooltip = function(text)
				if (text) then
					obj.tooltip.fs:SetText(text);
					obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
					obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
				else
					obj.tooltip.fs:SetText("");
					obj.tooltip:SetWidth(0);
					obj.tooltip:SetHeight(0);
				end
			end
			obj.tooltip:SetScript("OnUpdate", function(self)
				--Keep our custom tooltip at the mouse when it moves.
				if (obj.tooltip.fs:GetText() ~= "" and obj.tooltip.fs:GetText() ~= nil) then
					local scale, x, y = obj.tooltip:GetEffectiveScale(), GetCursorPosition();
					obj.tooltip:SetPoint("RIGHT", nil, "BOTTOMLEFT", (x / scale) - 20, (y / scale) + 20);
				end
			end)
			obj:SetScript("OnEnter", function(self)
				if (obj.tooltip.fs:GetText() ~= "" and obj.tooltip.fs:GetText() ~= nil) then
					obj.tooltip:Show();
					local scale, x, y = obj.tooltip:GetEffectiveScale(), GetCursorPosition();
					obj.tooltip:SetPoint("CENTER", nil, "BOTTOMLEFT", x / scale, y / scale);
				end
			end)
			obj:SetScript("OnLeave", function(self)
				obj.tooltip:Hide();
			end)
			obj.tooltip:Hide();
			frame.simpleLineFrames[count] = obj;
		end
	end
	frame.hideAllSimpleLineFrames = function()
		for k, v in pairs(frame.simpleLineFrames) do
			v:Hide();
		end
	end
	frame:Hide();
	levelLogFrame = frame;
end

function NIT:loadLevelLogFrame(char, realm)
	if (not levelLogFrame) then
		NIT:createLevelLogFrame();
	end
	--if (not levelLogFrame:IsShown()) then
		levelLogFrame:Show();
		NIT:recalcLevelLogFrame(char, realm);
	--else
	--	levelLogFrame:Hide();
	--end
end

function NIT:recalcLevelLogFrame(char, realm)
	levelLogFrame.hideAllSimpleLineFrames();
	local lines = {};
	local data;
	local currentLevel = 0;
	local class;
	for realmName, realmData in pairs(NIT.db.global) do
		if (type(realmData) == "table" and realmName ~= "minimapIcon" and realmName ~= "versions") then
			if (realmData.myChars) then
				for charName, charData in pairs(realmData.myChars) do
					if (charName == char and realm == realmName) then
						data = charData.levelLog;
						class = charData.classEnglish;
						currentLevel = charData.level;
						break;
					end
				end
			end
		end
		if (data) then
			break;
		end
	end
	local me = UnitName("player");
	local firstColor, secondColor, thirdColor = "|cFF9CD6DE", "|cFF00FF00", "|cFFFFFF00";
	--local _, _, _, classColorHex = GetClassColor(data.class);
	--local charString = "|c" .. classColorHex .. char .. "-" .. realm .. "|r";
	--levelLogFrame.topFrame.fs:SetText("|cffff6900" ..  L["Level Log"] .. " (" .. charString .. ")");
	if (data) then
		local _, _, _, classColorHex = GetClassColor(class);
		local charString = "|c" .. classColorHex .. char .. "-" .. realm .. "|r";
		local t = {
			text = "|cffff6900" .. L["Leveling history for"] .. " " .. charString .. " " .. L["Current Level"] .. " " .. secondColor .. currentLevel .. "|r",
			tooltip = "";
			border = false,
		};
		tinsert(lines, t);
		local count = 0;
		local tableCount = 0;
		for level, levelData in NIT:pairsByKeys(data) do
			tableCount = tableCount + 1;
		end
		for level, levelData in NIT:pairsByKeys(data) do
			count = count + 1;
			local timeString = L["Unknown Time"];
			if (levelData.timestamp) then
				timeString = NIT:getTimeFormat(levelData.timestamp, true, true);
			end
			local zoneString, zoneStringTooltip = thirdColor .. L["Unknown Zone"] .. "|r", thirdColor .. L["Unknown Zone"] .. "|r";
			if (levelData.zoneName and levelData.zoneName ~= "") then
				zoneString = levelData.zoneName;
				zoneStringTooltip = L["Zone"] .. ": " .. thirdColor .. levelData.zoneName .. "|r";
				if (levelData.subzoneName and levelData.subzoneName ~= "") then
					zoneString = zoneString .. " ("  .. levelData.subzoneName .. ")";
					zoneStringTooltip = zoneStringTooltip .. thirdColor .. " ("  .. levelData.subzoneName .. ")|r";
				end
			elseif (levelData.subzoneName and levelData.subzoneName ~= "") then
				zoneString = levelData.subzoneName;
				zoneStringTooltip = L["SubZone"] .. ": " .. thirdColor .. levelData.subzoneName .. "|r";
			end
			local text = firstColor .. L["Ding"] .. "|r " .. secondColor .. level .. "|r " .. firstColor .. timeString .. "|r " .. firstColor .. L["in"] .. "|r "
				.. firstColor .. zoneString;
			local tooltip = charString .. " " .. firstColor .. "\n" .. L["Ding"] .. " " .. L["level"] .. " " .. secondColor .. level .. "|r";
			tooltip = tooltip .. "\n" .. timeString;
			tooltip = tooltip .. "\n" .. zoneStringTooltip;
			if (levelData.x and levelData.y) then
				tooltip = tooltip .. "\n" .. L["Map coords"] .. ": X:" .. thirdColor .. NIT:round(levelData.x * 100, 1) .. "|r, Y:" .. thirdColor .. NIT:round(levelData.y * 100, 1) .. "|r";
			end
			if (levelData.gold) then
				tooltip = tooltip .. "\n" .. L["Gold owned at start of level"] .. ": |cFFFFFFFF" .. NIT:getCoinString(levelData.gold) .. "|r";
				local nextLevelGold;
				if (count == tableCount and char == me) then
					--If we're max level recorded.
					nextLevelGold = GetMoney();
				elseif (data[level + 1]) then
					nextLevelGold = data[level + 1].gold
				end
				if (nextLevelGold) then
					local diff = math.abs(levelData.gold - nextLevelGold);
					if (nextLevelGold < levelData.gold) then
						tooltip = tooltip .. "\n" .. L["Gold change during this level"] .. ": |cFFFF0000-|r|cFFFFFFFF" .. NIT:getCoinString(diff) .. "|r";
					else
						tooltip = tooltip .. "\n" .. L["Gold change during this level"] .. ": |cFF00FF00+|r|cFFFFFFFF" .. NIT:getCoinString(diff) .. "|r";
					end
				end
			end
			if (levelData.questCount) then
				tooltip = tooltip .. "\n" .. L["Quests completed during this level"] .. ": " .. thirdColor .. levelData.questCount .. "|r";
			end
			if (levelData.mobCount) then
				tooltip = tooltip .. "\n" .. L["Mobs that gave exp during this level"] .. ": " .. thirdColor .. levelData.mobCount .. "|r";
			end
			local playedString, totalPlayedString, nextLevelPlayed;
			if (levelData.played) then
				tooltip = tooltip .. "\n";
				if (count < tableCount) then
					if (data[level + 1]) then
						nextLevelPlayed = data[level + 1].played
					end
					if (nextLevelPlayed) then
						text = text .. thirdColor .. " " .. NIT:getTimeString(nextLevelPlayed - levelData.played, true) .. "|r";
						tooltip = tooltip .. "\n" .. L["Played time this level"] .. ": " .. thirdColor .. NIT:getTimeString(nextLevelPlayed - levelData.played, true) .. "|r";
					end
				end
				if (count == tableCount and char == me and getPlayedCache()) then
					tooltip = tooltip .. "\n" .. L["Total Played"] .. ": " .. thirdColor .. NIT:getTimeString(getPlayedCache(), true) .. "|r";
				elseif (count > 1) then
					tooltip = tooltip .. "\n" .. L["Total Played"] .. ": " .. thirdColor .. NIT:getTimeString(levelData.played, true) .. "|r";
				end
			end
			if (count == 1 and level ~= 1) then
				tooltip = tooltip .. "\n\n" .. L["firstTimeSeeingCharPlayed"];
			end
			local t = {
				text = text,
				tooltip = tooltip;
				border = true,
			};
			tinsert(lines, t);
		end
	end
	if (not next(lines)) then
		local t = {
			text = L["noLevelLogData"],
			tooltip = "";
		};
		tinsert(lines, t);
	end
	local startOffset, padding, offset = 9, 17, 0;
	if (next(lines)) then
		for k, v in ipairs(lines) do
			local lineFrame = levelLogFrame.getSimpleLineFrame(k);
			if (lineFrame) then
				lineFrame:ClearAllPoints();
				if (k == 1) then
					offset = startOffset;
				else
					offset = offset + padding;
				end
				lineFrame:SetHeight(16);
				lineFrame:SetPoint("LEFT", levelLogFrame.scrollChild, "TOPLEFT", 7, -offset);
				lineFrame:SetPoint("RIGHT", levelLogFrame.scrollChild, "RIGHT");
				lineFrame.fs:SetText(v.text);
				lineFrame.updateTooltip(v.tooltip);
				if (v.border) then
					lineFrame.borderFrame:Show();
					lineFrame.highlightTex:SetTexture("Interface\\ClassTrainerFrame\\TrainerTextures");
				else
					lineFrame.borderFrame:Hide();
					lineFrame.highlightTex:SetTexture();
				end
				lineFrame:Show();
			end
		end
	end
end

--[[function wipeLevelLog()
	for realmName, realmData in pairs(NIT.db.global) do
		if (type(realmData) == "table" and realmName ~= "minimapIcon" and realmName ~= "versions") then
			if (realmData.myChars) then
				for charName, charData in pairs(realmData.myChars) do
					charData.levelLog = nil;
				end
			end
		end
	end
end]]