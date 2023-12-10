-------------------
---NovaWorldBuffs--
-------------------

local addonName, addon = ...;
local NWB = addon.a;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");

local lastAshenUpdate, lastSendGuild, lastSendGroup = 0, 0, 0;
local lastAlliancePercent, lastHordePercent, lastWinner = 0, 0, 0;
local lastStartSoon, lastStarted = 0;
local logonStartDelay, lastStartSoonDelay = 0, 900;
local lastIsRunning, isRunning = 0;
local startup = true;
local lastWidget = 0;

SLASH_NWBASHVCMD1 = '/ashenvale';
function SlashCmdList.NWBASHVCMD(msg, editBox)
	WorldMapFrame:Show();
	WorldMapFrame:SetMapID(1440);
end

local f = CreateFrame("Frame");
f:RegisterEvent("UPDATE_UI_WIDGET");
f:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");
--f:RegisterEvent("CHAT_MSG_GUILD");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:SetScript('OnEvent', function(self, event, ...)
	if (event == "UPDATE_UI_WIDGET") then
		local data = ...;
		if (data.widgetID == 5360 or data.widgetID == 5361) then -- Alliance and Horde percentage stage.
			--One widget is sent at a time when percent changes.
			NWB:getAshenvaleResourceData();
			isRunning = nil;
			lastWidget = data.widgetID;
		elseif (data.widgetID == 5366 or data.widgetID == 5367 or data.widgetID == 5368) then --Event is running.
			--5367 Alliance.
			--5368 Horde.
			if (data.widgetID == 5367 or data.widgetID == 5368) then
				--Score update while running.
				NWB:getAshenvaleScoreData();
			end
			if (not isRunning and lastAlliancePercent ~= 0 and lastHordePercent ~= 0 and NWB:isAshenvaleTimerValid()) then
				if (lastWidget == 5366 or lastWidget == 5367 or lastWidget == 5368) then
					--Header widget has popped up, event started.
					NWB:ashenvaleEventStarted();
				end
			end
			isRunning = true;
			lastIsRunning = GetServerTime();
			lastWidget = data.widgetID;
		end
	elseif (event == "CHAT_MSG_BG_SYSTEM_NEUTRAL") then
		local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
		if (zone == 1440) then
			local msg = ...;
			if (strmatch(msg, L["ashenvaleHordeVictoryMsg"])) then
				NWB:ashenvaleWinner("horde");
			elseif (strmatch(msg, L["ashenvaleAllianceVictoryMsg"])) then
				NWB:ashenvaleWinner("alliance");
			end
		end
	--[[elseif (event == "CHAT_MSG_GUILD") then
		local msg = ...;
		local match = string.gsub("[NWB] " .. L["ashenvaleWarning"], "%[NWB%] ", ""); --Prefix.
		match = string.gsub(match, "%(", "%%("); --Brackets.
		match = string.gsub(match, "%)", "%%)"); --Brackets.
		match = string.gsub(match, "%%s", "(.+)"); --Captures.
		match = string.gsub(match, "%.$", "%%."); --Last full stop.
		if (strmatch(msg, match)) then
			NWB.data.lastAshenvaleGuildMsg = GetServerTime();
		end]]
	elseif (event == "PLAYER_ENTERING_WORLD") then
		local isLogon, isReload = ...;
		if (isLogon or isReload) then
			local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
			if (zone == 1440) then
				--If we logon in the zone and it's already about to start don't announce to guild, someone probably already did.
				logonStartDelay = GetServerTime();
			end
		end
	end
end)

function NWB:getAshenvaleResourceData()
	if (not NWB.isClassic) then
		return;
	end
	if (NWB:isAshenvaleRunning()) then
		--Sometimes the resource wdigets update while the game is running, not sure why, probably layer related.
		NWB:debug("Widget update while game is running.")
		return;
	end
	if (GetTime() - lastWinner < 2) then
		--We get weird widget updates right after the battle ends of resource scores like 100-100 and 100-0.
		return;
	end
	--Percentage widgets stop updating when the event is running.
	local alliance = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(5360);
	local horde = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(5361);
	if (not alliance or not horde) then
		NWB:debug("missing widget");
		return;
	end
	if (not UIWidgetTopCenterContainerFrame:IsShown()) then
		NWB:debug("missing widget2");
		return;
	end
	--Make sure the child being shown is a matching widget, incase the state is ever set wrong.
	local children = {UIWidgetTopCenterContainerFrame:GetChildren()};
	local child;
	for k, v in pairs(children) do
		if (v:IsShown()) then
			child = v;
		end
	end
	if (not child) then
		NWB:debug("missing child frame");
		return;
	end
	local alliancePercent = string.match(alliance.text, "(%d+)");
	local hordePercent = string.match(horde.text, "(%d+)");
	if (alliancePercent and hordePercent and tonumber(alliancePercent) and tonumber(hordePercent)) then
		NWB:receivedAshenvaleUpdate(alliancePercent .. "_" .. hordePercent, GetServerTime(), "zone");
	end
end

function NWB:isAshenvaleRunning()
	if (isRunning) then
		return true;
	end
	local _, _, zone = NWB.dragonLib:GetPlayerZonePosition();
	if (zone == 1440) then
		local children = {UIWidgetTopCenterContainerFrame:GetChildren()};
		for k, v in pairs(children) do
			if (v:IsShown() and (v.widgetID == 5367 or v.widgetID == 5368)) then
				return true;
			end
		end
	end
end

function NWB:getAshenvaleScoreData()
	--Percentage widgets stop updating when the event is running.
	local alliance = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(5367);
	local horde = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(5368);
	if (not alliance or not horde) then
		NWB:debug("missing widget");
		return;
	end
	if (not UIWidgetTopCenterContainerFrame:IsShown()) then
		NWB:debug("missing widget2");
		return;
	end
	--Make sure the child being shown is a matching widget, incase the state is ever set wrong.
	local children = {UIWidgetTopCenterContainerFrame:GetChildren()};
	local child;
	for k, v in pairs(children) do
		if (v:IsShown()) then
			child = v;
		end
	end
	if (not child) then
		NWB:debug("missing child frame");
		return;
	end
	local allianceScore = string.match(alliance.text, "(%d+)");
	local hordeScore = string.match(horde.text, "(%d+)");
	if (allianceScore and hordeScore) then
		--I considered showing the scoreboard but it's different for each layer so no point really.
		--I'll leave the code here incase that changes.
		--NWB:debug("Score update:", allianceScore, hordeScore);
	end
end

function NWB:receivedAshenvaleUpdate(data, timestamp, distribution, sender)
	if (distribution == "zone") then
		NWB:debug("Received ashenvale data:", data, timestamp, distribution, sender);
	end
	if (data and timestamp and distribution) then
		if ((not NWB.data.ashenvaleTime or timestamp > NWB.data.ashenvaleTime)
				and (timestamp < GetServerTime() + 60)) then
			local newAlliance, newHorde = strsplit("_", data, 2);
			local oldAlliance, oldHorde = NWB:getAshenvalePercent();
			if (not NWB.data.ashenvaleTime or GetServerTime() - NWB.data.ashenvaleTime > 1200) then
				oldAlliance, oldHorde = 0, 0;
			end
			NWB.data.ashenvale = data;
			NWB.data.ashenvaleTime = timestamp;
			lastAshenUpdate = GetServerTime();
			if (distribution == "zone") then
				local _, _, onlineCount = GetNumGuildMembers();
				if (IsInGuild() and GetServerTime() - lastSendGuild > 30 and onlineCount > 1) then
					lastSendGuild = GetServerTime()
					NWB:sendData("GUILD", nil, nil, true, true, "ashenvale");
				end
				if (GetServerTime() - lastSendGroup > 30) then
					--Timed delay so receivers can compare data from guild first and ched if it's needed to relay to party.
					lastSendGroup = GetServerTime();
					C_Timer.After(2, function()
						if (IsInRaid()) then
							NWB:sendData("RAID", nil, nil, true, true, "ashenvale");
						elseif (IsInGroup()) then
							NWB:sendData("PARTY", nil, nil, true, true, "ashenvale");
						end
					end)
				end
			end
			if (not startup and not isRunning and not (oldAlliance == 0 and oldHorde == 0)
					and GetServerTime() - lastIsRunning > lastStartSoonDelay + 300) then
				--Not first run and old data isn't too far expired.
				local newTotal = newAlliance + newHorde;
				local oldTotal = oldAlliance + oldHorde;
				--Don't need to check previous total now we're sharing when last guild msg was sent.
				--if (newTotal >= 180 and newTotal < 200 and oldTotal < 180) then
				if (newTotal >= 180 and newTotal < 200 and newTotal > oldTotal) then
					NWB:ashenvaleEventStartsSoon(newAlliance, newHorde, timestamp);
				end
			end
			--NWB:debug("Alliance:", newAlliance, lastAlliancePercent, "Horde:", newHorde, lastHordePercent, distribution, sender);
			lastAlliancePercent = newAlliance;
			lastHordePercent = newHorde;
			startup = nil;
			if (sender and (distribution == "PARTY" or distribution == "RAID" or distribution == "YELL")) then
				local _, _, onlineCount = GetNumGuildMembers();
				if (IsInGuild() and GetServerTime() - lastSendGuild > 90 and not NWB:inMyGuild(sender) and onlineCount > 1) then
					lastSendGuild = GetServerTime()
					C_Timer.After(2, function()
						NWB:sendData("GUILD", nil, nil, true, true, "ashenvale");
					end)
					--NWB:debug("Guild relay sent.");
				end
			end
			isRunning = nil;
		end
	end
end

function NWB:isAshenvaleTimerValid()
	if (NWB.data.ashenvale and NWB.data.ashenvaleTime and NWB.data.ashenvaleTime > GetServerTime() - 300) then
		return true;
	end
end

function NWB:ashenvaleEventStartsSoon(alliancePercent, hordePercent, timestamp)
	if (GetServerTime() - lastStartSoon > lastStartSoonDelay and GetServerTime() - logonStartDelay > 30) then
		--Only announce if data is less than 5 mins old, it could be started by then if resources are moving fast.
		if (NWB:isAshenvaleTimerValid() and GetServerTime() - timestamp < 300 and GetServerTime() + 30 > timestamp) then
			lastStartSoon = GetServerTime();
			local msg = string.format(L["ashenvaleWarning"], alliancePercent, hordePercent);
			if (NWB.db.global.chat10) then
				NWB:print(msg, nil, "[NWB]");
			end
			--if (NWB.db.global.middle10) then
			--	NWB:middleScreenMsg("middle30", msg, nil, 5);
			--end
			--Not needed anymore since we check last guild msg.
			--if (lastAlliancePercent == 0 and lastHordePercent == 0) then
				--If first run (we logon in ashenvale) only let ourselves know about spawn and not guild.
			--	return;
			--end
			if (NWB.db.global.guild10) then
				if (not NWB.data.lastAshenvaleGuildMsg or GetServerTime() - NWB.data.lastAshenvaleGuildMsg > lastStartSoonDelay) then
					NWB:sendGuildMsg(msg, "guild10", nil, "[NWB]", 2.60);
					NWB.data.lastAshenvaleGuildMsg = GetServerTime();
				end
			end
		end
	end
end

function NWB:ashenvaleEventStarted()
	--NWB:debug("Ashenvale event started");
end

function NWB:ashenvaleWinner(winner)
	local lastWinner = GetTime();
	--NWB:debug("Ashenvale PvP event ended - Winner:", winner .. ".");
	isRunning = nil;
end

function NWB:getAshenvalePercent()
	if (NWB.data.ashenvale) then
		local alliance, horde = strsplit("_", NWB.data.ashenvale, 2);
		return alliance, horde;
	end
end

function NWB:addAshenvaleMinimapString(tooltip)
	if (not NWB.isSOD) then
		return;
	end
	local alliance, horde = NWB:getAshenvalePercent();
	local allianceString, hordeString;
	if (NWB:isAshenvaleTimerValid()) then
		allianceString = "|TInterface\\worldstateframe\\alliancetower.blp:12:12:-2:1:32:32:1:18:1:18|t " .. alliance .. "%  Alliance";
		hordeString = "|TInterface\\worldstateframe\\hordetower.blp:12:12:-2:0:32:32:1:18:1:18|t " .. horde .. "%  Horde";
	else
		allianceString = "|TInterface\\worldstateframe\\alliancetower.blp:12:12:-2:1:32:32:1:18:1:18|t No data yet.";
		hordeString = "|TInterface\\worldstateframe\\hordetower.blp:12:12:-2:0:32:32:1:18:1:18|t No data yet.";
	end
	tooltip:AddLine(" ");
	if (not tooltip.NWBSeparator2) then
	    tooltip.NWBSeparator2 = tooltip:CreateTexture(nil, "BORDER");
	    tooltip.NWBSeparator2:SetColorTexture(0.6, 0.6, 0.6, 0.85);
	    tooltip.NWBSeparator2:SetHeight(1);
	    tooltip.NWBSeparator2:SetPoint("LEFT", 10, 0);
	    tooltip.NWBSeparator2:SetPoint("RIGHT", -10, 0);
	end
	tooltip.NWBSeparator2:SetPoint("TOP", _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()], "CENTER");
	tooltip.NWBSeparator2:Show();
	if (isRunning) then
		tooltip:AddLine(NWB.chatColor .. "Ashenvale (Event Running)");
	else
		tooltip:AddLine(NWB.chatColor .. "Ashenvale Resources");
	end
	tooltip:AddLine(allianceString);
	tooltip:AddLine(hordeString);
	tooltip:AddLine(" ");
	if (not tooltip.NWBSeparator3) then
	    tooltip.NWBSeparator3 = tooltip:CreateTexture(nil, "BORDER");
	    tooltip.NWBSeparator3:SetColorTexture(0.6, 0.6, 0.6, 0.85);
	    tooltip.NWBSeparator3:SetHeight(1);
	    tooltip.NWBSeparator3:SetPoint("LEFT", 10, 0);
	    tooltip.NWBSeparator3:SetPoint("RIGHT", -10, 0);
	end
	tooltip.NWBSeparator3:SetPoint("TOP", _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()], "CENTER");
	tooltip.NWBSeparator3:Show();
end

local ashenvaleMapMarkerTypes;
if (NWB.isSOD) then
	ashenvaleMapMarkerTypes = {
		["Alliance"] = {x = 90, y = 90, mapID = 1440, icon = "Interface\\worldstateframe\\alliancetower.blp"},
		["Horde"] = {x = 95, y = 90, mapID = 1440, icon = "Interface\\worldstateframe\\hordetower.blp"},
	};
end

--Update timers for worldmap when the map is open.
function NWB:updateAshenvaleMarkers(type)
	_G["AllianceNWBAshenvaleMap"].fsTitle:SetText("|cFFFFFF00Ashenvale");
	if (NWB:isAshenvaleTimerValid()) then
		local alliance, horde = NWB:getAshenvalePercent();
		 _G["AllianceNWBAshenvaleMap"].timerFrame.fs:SetText("|cFFFFFF00" .. alliance .. "%");
		 _G["HordeNWBAshenvaleMap"].timerFrame.fs:SetText("|cFFFFFF00" .. horde .. "%");
	else
		 _G["AllianceNWBAshenvaleMap"].timerFrame.fs:SetText("---");
		 _G["HordeNWBAshenvaleMap"].timerFrame.fs:SetText("---");
	end
end

function NWB:createAshenvaleMarkers()
	if (not ashenvaleMapMarkerTypes) then
		return;
	end
	for k, v in pairs(ashenvaleMapMarkerTypes) do
		NWB:createAshenvaleMarker(k, v);
	end
	NWB:refreshAshenvaleMarkers();
end

local mapMarkers = {};
function NWB:createAshenvaleMarker(type, data)
	if (not NWB.isClassic) then
		return;
	end
	if (not _G[type .. "NWBAshenvaleMap"]) then
		--Worldmap marker.
		local obj = CreateFrame("Frame", type .. "NWBAshenvaleMap", WorldMapFrame);
		local bg = obj:CreateTexture(nil, "ARTWORK");
		bg:SetTexture(data.icon);
		bg:SetTexCoord(0.1, 0.6, 0.1, 0.6);
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj:SetSize(20, 20);
		obj.fsTitle = obj:CreateFontString(type .. "NWBAshenvaleBuffCmdFSTitle", "ARTWORK");
		obj.fsTitle:SetPoint("TOP", 28, 22);
		obj.fsTitle:SetFont("Fonts\\FRIZQT__.ttf", 14, "OUTLINE");
		--obj.fsTitle:SetFontObject(NumberFont_Outline_Med);
		--Timer frame that sits above the icon when an active timer is found.
		obj.timerFrame = CreateFrame("Frame", type .. "AshenvaleTimerFrame", obj, "TooltipBorderedFrameTemplate");
		obj.timerFrame:SetPoint("CENTER", obj, "CENTER",  0, -22);
		obj.timerFrame:SetFrameStrata("FULLSCREEN");
		obj.timerFrame:SetFrameLevel(9);
		obj.timerFrame.fs = obj.timerFrame:CreateFontString(type .. "NWBAshenvaleTimerFrameFS", "ARTWORK");
		obj.timerFrame.fs:SetPoint("CENTER", 0, 0);
		obj.timerFrame.fs:SetFont("Fonts\\FRIZQT__.ttf", 13);
		obj.timerFrame:SetWidth(54);
		obj.timerFrame:SetHeight(24);
		obj.lastUpdate = 0;
		obj.resetType = L["Ashenvale Towers"];
		obj:SetScript("OnUpdate", function(self)
			--Update timer when map is open.
			if (GetServerTime() - obj.lastUpdate > 0) then
				obj.lastUpdate = GetServerTime();
				NWB:updateAshenvaleMarkers(type);
				obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 18);
				obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 12);
			end
		end)
		--Make it act like pin is the parent and not WorldMapFrame.
		obj:SetScript("OnHide", function(self)
			obj.timerFrame:Hide();
		end)
		obj:SetScript("OnShow", function(self)
			obj.timerFrame:Show();
		end)
		mapMarkers[type .. "NWBAshenvale"] = true;
		obj.tooltip = CreateFrame("Frame", type .. "NWBAshenvaleDailyMapTextTooltip", obj, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("BOTTOM", obj, "TOP", 0, 35);
		--obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -26);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9999);
		obj.tooltip.fs = obj.tooltip:CreateFontString("NWBAshenvaleDailyMapTextTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NWB.regionFont, 14);
		obj.tooltip.fs:SetJustifyH("LEFT")
		obj.tooltip.fs:SetText("Ashenvale PvP Event Resources");
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
		obj.tooltip:Hide();
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		obj.timerFrame:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj.timerFrame:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		NWB.extraMapMarkers[obj:GetName()] = true;
	end
end

local hookWorldMap = true;
function NWB:refreshAshenvaleMarkers(updateOnly)
	if (not NWB.isClassic) then
		return;
	end
	--If we're looking at the capital city map.
	if (NWB.faction == "Horde" and WorldMapFrame and WorldMapFrame:GetMapID() == 1454) then
		ashenvaleMapMarkerTypes = {
			["Alliance"] = {x = 15, y = 87, mapID = 1454, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 20, y = 87, mapID = 1454, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
	elseif (NWB.faction == "Alliance" and WorldMapFrame and WorldMapFrame:GetMapID() == 1453) then
		ashenvaleMapMarkerTypes = {
			["Alliance"] = {x = 12, y = 87, mapID = 1453, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 17, y = 87, mapID = 1453, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
	else
		ashenvaleMapMarkerTypes = {
			["Alliance"] = {x = 90, y = 90, mapID = 1440, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 95, y = 90, mapID = 1440, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
	end
	if (WorldMapFrame and hookWorldMap) then
		hooksecurefunc(WorldMapFrame, "OnMapChanged", function()
			NWB:refreshAshenvaleMarkers();
		end)
		hookWorldMap = nil;
	end
	--if (not NWB:isAshenvaleTimerValid()) then
		--Hide markers when no timer.
	--	NWB.dragonLibPins:RemoveWorldMapIcon("AllianceNWBAshenvaleMap", _G["AllianceNWBAshenvaleMap"]);
	--	NWB.dragonLibPins:RemoveWorldMapIcon("HordeNWBAshenvaleMap", _G["HordeNWBAshenvaleMap"]);
	--else
		for k, v in pairs(ashenvaleMapMarkerTypes) do
			NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWBAshenvaleMap", _G[k .. "NWBAshenvaleMap"]);
			if (NWB.db.global.showWorldMapMarkers and _G[k .. "NWBAshenvaleMap"]) then
				NWB.dragonLibPins:AddWorldMapIconMap(k .. "NWBAshenvaleMap", _G[k .. "NWBAshenvaleMap"], v.mapID,
						v.x / 100, v.y / 100, HBD_PINS_WORLDMAP_SHOW_PARENT);
			end
		end
	--end
	if (not updateOnly) then
		NWB:updateWorldbuffMarkersScale();
	end
end