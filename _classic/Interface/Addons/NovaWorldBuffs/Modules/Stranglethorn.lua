-------------------
---NovaWorldBuffs--
-------------------

local addonName, addon = ...;
local NWB = addon.a;
local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");
local calcStart, lastSendGuild = 0, 0;

SLASH_NWBASTVCMD1 = '/stv';
function SlashCmdList.NWBASTVCMD(msg, editBox)
	WorldMapFrame:Show();
	WorldMapFrame:SetMapID(1434);
end

--This may need to adjusted for DST we'll see whe it ticks over.
local region = GetCurrentRegion();
if (region == 1 and string.match(NWB.realm, "(AU)")) then
	--OCE.
	calcStart = 1707260400; --Date and time (GMT): Tuesday, February 6, 2024 11:00:00 PM
elseif (region == 1) then
	--US.
	calcStart = 1707260400; --OCE and US are the same? (unlike dmf)
elseif (region == 2) then
	--Korea.
	calcStart = 1707256800; --Date and time (GMT): Tuesday, February 6, 2024 10:00:00 PM --KR starts 1h before OCE/US.
elseif (region == 3) then
	--EU.
	calcStart = 1707220800; --Date and time (GMT): Tuesday, February 6, 2024 12:00:00 PM
elseif (region == 4) then
	--Taiwan.
	calcStart = 1707260400; --TW same as OCE/US.
elseif (region == 5) then
	--China.
	calcStart = 1707260400; --CN same as OCE/US.
end
calcStart = calcStart - 3600; --Stv runs 1 hour before ashenvale.

local function getTimeLeft()
	local timeLeft, type;
	if (calcStart) then
		local utc = time(date("*t"));
		local secondsSinceFirstReset = utc - calcStart;
		local timestamp = calcStart + ((math.floor(secondsSinceFirstReset / 10800) + 1) * 10800);
		local timeLeft = timestamp - utc;
		local realTimeLeft = timeLeft;
		if (timeLeft > 9000) then
			--If more than 2.5h left then it's running, return tim left on current event instead.
			type = "running";
			timeLeft = timeLeft - 9000;
			timestamp = timestamp - 9000;
		end
		return timeLeft, type, timestamp, realTimeLeft;
	end
end

function NWB:getStranglethornTimeString(isShort, veryShort)
	local text;
	local timeLeft, type, timestamp, realTimeLeft = getTimeLeft();
	if (timeLeft) then
		local timeString = NWB:getTimeString(timeLeft, true, "short");
		if (veryShort) then
			if (type == "running") then
				--For the overlay we don't show it running, so add the time until next start.
				timeString = NWB:getTimeString(timeLeft + 9000, true, "short");
			end
			--if (type == "running") then
			--	text = "|cFF00C800" .. L["Stranglethorn"] .. ": |cFF9CD6DE" .. timeString .. "|r" .. "|r |cFF9CD6DE" .. L["remaining"] .. "|r";
			--else
				text = L["Stranglethorn"] .. ": |cFF9CD6DE" .. timeString .. "|r";
			--end
		elseif (isShort) then
			if (type == "running") then
				text = "|cFF00C800" .. string.format(L["stranglethornEventRunning"], "|cFF9CD6DE" .. timeString .. "|r") .. "|r |cFF9CD6DE" .. L["remaining"] .. "|r";
			else
				text = string.format(L["startsIn"], "|cFF9CD6DE" .. timeString .. "|r");
			end
		else
			if (type == "running") then
				text = "|cFF00C800" .. string.format(L["stranglethornEventRunning"], "|cFF9CD6DE" .. timeString .. "|r") .. "|r |cFF9CD6DE" .. L["remaining"] .. "|r";
			else
				text = string.format(L["stranglethornEventStartsIn"], "|cFF9CD6DE" .. timeString .. "|r");
			end
		end
	end
	return text, timeLeft, timestamp, realTimeLeft;
end

function NWB:addStranglethornMinimapString(tooltip, noTopSeperator, noBottomSeperator)
	if (not NWB.isSOD) then
		return;
	end
	local text, timeLeft, timestamp = NWB:getStranglethornTimeString();
	if (not text) then
		return;
	end
	--Check if previous line is a seperator so we don't double up.
	if (_G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()] and _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()]:GetText() ~= " "
			and not noTopSeperator) then
		tooltip:AddLine(" ");
		if (not tooltip.NWBSeparator9) then
		    tooltip.NWBSeparator9 = tooltip:CreateTexture(nil, "BORDER");
		    tooltip.NWBSeparator9:SetColorTexture(0.6, 0.6, 0.6, 0.85);
		    tooltip.NWBSeparator9:SetHeight(1);
		    tooltip.NWBSeparator9:SetPoint("LEFT", 10, 0);
		    tooltip.NWBSeparator9:SetPoint("RIGHT", -10, 0);
		end
		tooltip.NWBSeparator9:SetPoint("TOP", _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()], "CENTER");
		tooltip.NWBSeparator9:Show();
	end
	local dateString = "";
	if (IsShiftKeyDown()) then
		if (NWB.db.global.timeStampFormat == 12) then
			dateString = " (" .. date("%A", timestamp) .. " " .. gsub(date("%I:%M", timestamp), "^0", "")
					.. string.lower(date("%p", timestamp)) .. ")";
		else
			dateString = " (" .. date("%A %H:%M", timestamp) .. ")";
		end
	end
	tooltip:AddLine(text .. dateString);
	if (not noBottomSeperator) then
		tooltip:AddLine(" ");
		if (not tooltip.NWBSeparator10) then
		    tooltip.NWBSeparator10 = tooltip:CreateTexture(nil, "BORDER");
		    tooltip.NWBSeparator10:SetColorTexture(0.6, 0.6, 0.6, 0.85);
		    tooltip.NWBSeparator10:SetHeight(1);
		    tooltip.NWBSeparator10:SetPoint("LEFT", 10, 0);
		    tooltip.NWBSeparator10:SetPoint("RIGHT", -10, 0);
		end
		tooltip.NWBSeparator10:SetPoint("TOP", _G[tooltip:GetName() .. "TextLeft" .. tooltip:NumLines()], "CENTER");
		tooltip.NWBSeparator10:Show();
	end
	return true;
end

function NWB:checkStranglethornTimer()
	local _, _, _, realTimeLeft = getTimeLeft();
	if (realTimeLeft <= 900 and realTimeLeft >= 899 and GetTime() - lastSendGuild > 900) then
		lastSendGuild = GetTime();
		local msg = string.format(L["stranglethornStartSoon"], "15 " .. L["minutes"]) .. ".";
		if (NWB.db.global.guild10) then
			if (IsInGuild()) then
				NWB:sendGuildMsg(msg, "guild10", nil, "[NWB]", 2.67);
			else
				NWB:print(msg);
			end
		end
	end
end

local mapMarkerTypes;
if (NWB.isSOD) then
	mapMarkerTypes = {
		["Alliance"] = {x = 78, y = 90, mapID = 1434, icon = "Interface\\worldstateframe\\alliancetower.blp"},
		["Horde"] = {x = 83, y = 90, mapID = 1434, icon = "Interface\\worldstateframe\\hordetower.blp"},
	};
end

--Update timers for worldmap when the map is open.
function NWB:updateStranglethornMarkers(type)
	local text = NWB:getStranglethornTimeString(true);
	_G["AllianceNWBStranglethornMap"].timerFrame.fs:SetText("|cFFFFFF00" .. text);
end

local function createStranglethornMarkers()
	if (not mapMarkerTypes) then
		return;
	end
	for k, v in pairs(mapMarkerTypes) do
		NWB:createStranglethornMarker(k, v);
	end
	NWB:refreshStranglethornMarkers();
end

local mapMarkers = {};
function NWB:createStranglethornMarker(type, data)
	if (not NWB.isClassic) then
		return;
	end
	if (not _G[type .. "NWBStranglethornMap"]) then
		--Worldmap marker.
		local obj = CreateFrame("Frame", type .. "NWBStranglethornMap", WorldMapFrame);
		local bg = obj:CreateTexture(nil, "ARTWORK");
		bg:SetTexture(data.icon);
		bg:SetTexCoord(0.1, 0.6, 0.1, 0.6);
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj:SetSize(20, 20);
		obj.fsTitle = obj:CreateFontString(type .. "NWBStranglethornBuffCmdFSTitle", "ARTWORK");
		obj.fsTitle:SetPoint("TOP", 27, 22);
		obj.fsTitle:SetFont("Fonts\\FRIZQT__.ttf", 14, "OUTLINE");
		--obj.fsTitle:SetFontObject(NumberFont_Outline_Med);
		obj.fsBottom = obj:CreateFontString(type .. "NWBStranglethornBuffCmdFSBottom", "ARTWORK");
		obj.fsBottom:SetPoint("BOTTOM", 28, -45);
		obj.fsBottom:SetFont("Fonts\\FRIZQT__.ttf", 14, "OUTLINE");
		mapMarkers[type .. "NWBStranglethorn"] = true;
		obj.tooltip = CreateFrame("Frame", type .. "NWBStranglethornDailyMapTextTooltip", obj, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("BOTTOM", obj, "TOP", 0, 35);
		--obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -26);
		obj.tooltip:SetFrameStrata("TOOLTIP");
		obj.tooltip:SetFrameLevel(9999);
		obj.tooltip.fs = obj.tooltip:CreateFontString("NWBStranglethornDailyMapTextTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NWB.regionFont, 14);
		obj.tooltip.fs:SetJustifyH("LEFT")
		obj.tooltip.fs:SetText(L["Stranglethorn PvP Event"]);
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
		obj.tooltip:Hide();
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		--New version we don't need resource frames for both factions, just attach timer string to alliance and move it to sit in the middle of both.
		if (type == "Alliance") then
			_G["AllianceNWBStranglethornMap"].fsTitle:SetText("|cFFFFFF00" .. L["Stranglethorn"]);
			--Timer frame that sits above the icon when an active timer is found.
			obj.timerFrame = CreateFrame("Frame", type .. "StranglethornTimerFrame", obj, "TooltipBorderedFrameTemplate");
			obj.timerFrame:SetPoint("CENTER", obj, "CENTER",  26, -23);
			obj.timerFrame:SetFrameStrata("FULLSCREEN");
			obj.timerFrame:SetFrameLevel(9);
			obj.timerFrame.fs = obj.timerFrame:CreateFontString(type .. "NWBStranglethornTimerFrameFS", "ARTWORK");
			obj.timerFrame.fs:SetPoint("CENTER", 0, 0);
			obj.timerFrame.fs:SetFont("Fonts\\FRIZQT__.ttf", 13);
			obj.timerFrame:SetWidth(54);
			obj.timerFrame:SetHeight(24);
			obj.lastUpdate = 0;
			obj.resetType = L["Stranglethorn Towers"];
			obj:SetScript("OnUpdate", function(self)
				--Update timer when map is open.
				if (GetServerTime() - obj.lastUpdate > 0) then
					obj.lastUpdate = GetServerTime();
					NWB:updateStranglethornMarkers(type);
					obj.timerFrame:SetWidth(obj.timerFrame.fs:GetStringWidth() + 18);
					obj.timerFrame:SetHeight(obj.timerFrame.fs:GetStringHeight() + 12);
				end
			end)
				obj.timerFrame:SetScript("OnEnter", function(self)
				obj.tooltip:Show();
			end)
			obj.timerFrame:SetScript("OnLeave", function(self)
				obj.tooltip:Hide();
			end)
			--Make it act like pin is the parent and not WorldMapFrame.
			obj:SetScript("OnHide", function(self)
				obj.timerFrame:Hide();
			end)
			obj:SetScript("OnShow", function(self)
				obj.timerFrame:Show();
			end)
		end
		NWB.extraMapMarkers[obj:GetName()] = true;
	end
end

local hookWorldMap = true;
function NWB:refreshStranglethornMarkers(updateOnly)
	if (not NWB.isClassic) then
		return;
	end
	--If we're looking at the capital city map.
	if (NWB.faction == "Horde" and WorldMapFrame and WorldMapFrame:GetMapID() == 1454) then
		mapMarkerTypes = {
			["Alliance"] = {x = 15, y = 92, mapID = 1454, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 20, y = 92, mapID = 1454, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
		_G["AllianceNWBStranglethornMap"].fsBottom:ClearAllPoints();
		_G["AllianceNWBStranglethornMap"].fsBottom:SetPoint("BOTTOM", 28, -45);
	elseif (NWB.faction == "Alliance" and WorldMapFrame and WorldMapFrame:GetMapID() == 1453) then
		mapMarkerTypes = {
			["Alliance"] = {x = 14, y = 92, mapID = 1453, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 19, y = 92, mapID = 1453, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
		_G["AllianceNWBStranglethornMap"].fsBottom:ClearAllPoints();
		_G["AllianceNWBStranglethornMap"].fsBottom:SetPoint("BOTTOM", 28, -45);
	else
		mapMarkerTypes = {
			["Alliance"] = {x = 78, y = 90, mapID = 1434, icon = "Interface\\worldstateframe\\alliancetower.blp"},
			["Horde"] = {x = 83, y = 90, mapID = 1434, icon = "Interface\\worldstateframe\\hordetower.blp"},
		};
		_G["AllianceNWBStranglethornMap"].fsBottom:ClearAllPoints();
		_G["AllianceNWBStranglethornMap"].fsBottom:SetPoint("TOPRIGHT", _G["AllianceNWBStranglethornMap"], "TOPRIGHT", 70, -50);
	end
	if (WorldMapFrame and hookWorldMap) then
		hooksecurefunc(WorldMapFrame, "OnMapChanged", function()
			NWB:refreshStranglethornMarkers();
		end)
		hookWorldMap = nil;
	end
	for k, v in pairs(mapMarkerTypes) do
		NWB.dragonLibPins:RemoveWorldMapIcon(k .. "NWBStranglethornMap", _G[k .. "NWBStranglethornMap"]);
		if (NWB.db.global.showWorldMapMarkers and _G[k .. "NWBStranglethornMap"]) then
			NWB.dragonLibPins:AddWorldMapIconMap(k .. "NWBStranglethornMap", _G[k .. "NWBStranglethornMap"], v.mapID,
					v.x / 100, v.y / 100, HBD_PINS_WORLDMAP_SHOW_PARENT);
		end
	end
	if (not updateOnly) then
		NWB:updateWorldbuffMarkersScale();
	end
end

function NWB:loadStranglethorn()
	if (not NWB.isSOD) then
		return;
	end
	createStranglethornMarkers();
end