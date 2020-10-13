-------------------------
--Nova Instance Tracker--
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

NIT = LibStub("AceAddon-3.0"):NewAddon("NovaInstanceTracker", "AceComm-3.0");
NIT.LSM = LibStub("LibSharedMedia-3.0");
NIT.commPrefix = "NIT";
NIT.hasAddon = {};
NIT.realm = GetRealmName();
NIT.faction = UnitFactionGroup("player");
NIT.serializer = LibStub:GetLibrary("LibSerialize");
NIT.libDeflate = LibStub:GetLibrary("LibDeflate");
NIT.aceGUI = LibStub:GetLibrary("AceGUI-3.0");
NIT.acr = LibStub:GetLibrary("AceConfigRegistry-3.0");
local L = LibStub("AceLocale-3.0"):GetLocale("NovaInstanceTracker");
local LDB = LibStub:GetLibrary("LibDataBroker-1.1");
NIT.LDBIcon = LibStub("LibDBIcon-1.0");
local version = GetAddOnMetadata("NovaInstanceTracker", "Version") or 9999;
NIT.classic = true;
NIT.latestRemoteVersion = version;
NIT.hourlyLimit = 5;
NIT.dailyLimit = 30;
NIT.maxLevel = 60;
NIT.prefixColor = "|cFFFF6900";
NIT.perCharOnly = true;
NIT.loadTime = GetServerTime();

function NIT:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("NITdatabase", NIT.optionDefaults, "Default");
    LibStub("AceConfig-3.0"):RegisterOptionsTable("NovaInstanceTracker", NIT.options);
	self.NITOptions = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("NovaInstanceTracker", "NovaInstanceTracker");
	self:RegisterComm(self.commPrefix);
	self:buildDatabase();
	self.chatColor = "|cff" .. self:RGBToHex(self.db.global.chatColorR, self.db.global.chatColorG, self.db.global.chatColorB);
	self.mergeColor = "|cff" .. self:RGBToHex(self.db.global.mergeColorR, self.db.global.mergeColorG, self.db.global.mergeColorB);
	self.prefixColor = "|cff" .. self:RGBToHex(self.db.global.prefixColorR, self.db.global.prefixColorG, self.db.global.prefixColorB);
	self:createBroker();
	self:resetCharData();
	self:ticker();
	self:tickerCharacterData();
	self:resetOldLockouts();
end

NIT.regionFont = "Fonts\\ARIALN.ttf";
function NIT:setRegionFont()
	if (LOCALE_koKR) then
     	NIT.regionFont = "Fonts\\2002.TTF";
    elseif (LOCALE_zhCN) then
     	NIT.regionFont = "Fonts\\ARKai_T.ttf";
    elseif (LOCALE_zhTW) then
     	NIT.regionFont = "Fonts\\blei00d.TTF";
    elseif (LOCALE_ruRU) then
    	--ARIALN seems to work in RU.
     	--NIT.regionFont = "Fonts\\FRIZQT___CYR.TTF";
    end
end
NIT:setRegionFont();

--Add prefix and colors from db then print.
local printPrefix;
function NIT:print(msg, channel, prefix, nonClickable, tradeLog)
	if (prefix) then
		printPrefix = prefix;
	else
		printPrefix = "[NIT]";
	end
	if (channel == "group" or channel == "team") then
		channel = "party";
	end
	if (channel == "gchat" or channel == "gmsg") then
		channel = "guild";
	end
	if (channel == "say" or channel == "yell" or channel == "party" or channel == "guild" or channel == "officer" or channel == "raid") then
		SendChatMessage(printPrefix .. " " .. msg, channel);
	elseif (tonumber(channel)) then
		--Send to numbered channel by number.
		local id, name = GetChannelName(channel);
		if (id == 0) then
			print(NIT.chatColor .. "No channel with id " .. NIT.prefixColor .. channel .. NIT.chatColor .. " exists.");
			print(NIT.chatColor .. "Type \"/nit\" to show your instance history.");
			print(NIT.chatColor .. "Type \"/nit config\" to open options.");
			print(NIT.chatColor .. "Type \"/nit channelname\" to post your current lockouts to a channel.");
			return;
		end
		SendChatMessage(printPrefix .. " " .. NIT:stripColors(msg), "CHANNEL", nil, id);
	elseif (channel ~= nil) then
		--Send to numbered channel by name.
		local id, name = GetChannelName(channel);
		if (id == 0) then
			print(NIT.chatColor .. "No channel with id " .. NIT.prefixColor .. channel .. NIT.chatColor .. " exists.");
			print(NIT.chatColor .. "Type \"/nit\" to show your instance history.");
			print(NIT.chatColor .. "Type \"/nit config\" to open options.");
			print(NIT.chatColor .. "Type \"/nit channelname\" to post your current lockouts to a channel.");
			return;
		end
		SendChatMessage(printPrefix .. " " .. NIT:stripColors(msg), "CHANNEL", nil, id);
	else
		--if (not prefix) then
		--	printPrefix = "|HNITCustomLink:instancelog|h[NIT]|h|r";
		--end
		if (tradeLog) then
			printPrefix = "|HNITCustomLink:tradelog|h" .. printPrefix .. "|h|r";
			msg = "|HNITCustomLink:tradelog|h" .. msg .. "|h";
		elseif (string.match(msg, "|H.-|h(.-)|h")) then
			--If we put a chat link in the msg then don't re-add it, this is for strings with textures.
			--You can't add a seperate link inside another link, has to be done side by side in the string.
			printPrefix = "|HNITCustomLink:instancelog|h" .. printPrefix .. "|h|r";
		elseif (not nonClickable) then
			printPrefix = "|HNITCustomLink:instancelog|h" .. printPrefix .. "|h|r";
			msg = "|HNITCustomLink:instancelog|h" .. msg .. "|h";
		else
			printPrefix = "|HNITCustomLink:instancelog|h" .. printPrefix .. "|h|r";
		end
		print(NIT.prefixColor .. printPrefix .. " " .. NIT.chatColor .. msg);
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_SYSTEM")
f:SetScript('OnEvent', function(self, event, msg)
	local instance, success;
	local string = "";
	if (string.match(msg, string.gsub(INSTANCE_RESET_SUCCESS, "%%s", ".+"))) then
		instance = string.match(msg, string.gsub(INSTANCE_RESET_SUCCESS, "%%s", "(.+)"));
		string = msg;
		success = true;
	elseif (string.match(msg, string.gsub(INSTANCE_RESET_FAILED, "%%s", ".+"))) then
		instance = string.match(msg, string.gsub(INSTANCE_RESET_FAILED, "%%s", "(.+)"));
		--string = instance .. " has been reset but there are still players inside the old instance, please zone out to re-enter.";
		--string = instance .. " has been reset, if you are still inside the old instance please zone out and re-enter.";
		--string = instance .. " has been reset (Players still inside old instance need to zone out and re-enter).";
		string = instance .. " has been reset (Players still inside old instance need to zone out to enter new).";
		--Not sure why this is called a fail by Blizzard, the reset still works for everyone outside, and anyone that zones out after.
		success = true;
	elseif (string.match(msg, string.gsub(INSTANCE_RESET_FAILED_ZONING, "%%s", ".+"))) then
		instance = string.match(msg, string.gsub(INSTANCE_RESET_FAILED_ZONING, "%%s", "(.+)"));
		string = msg;
	elseif (string.match(msg, string.gsub(INSTANCE_RESET_FAILED_OFFLINE, "%%s", ".+"))) then
		instance = string.match(msg, string.gsub(INSTANCE_RESET_FAILED_OFFLINE, "%%s", "(.+)"));
		string = msg;
	end
	if (string.match(msg, TRANSFER_ABORT_TOO_MANY_INSTANCES)) then
		C_Timer.After(0.2, function()
			local msg, shortMsg, msgColorized = NIT:getInstanceLockoutInfoString();
			NIT:print(msgColorized);
		end)
		return;
	end
	if (success) then
		if (UnitIsGroupLeader("player")) then
			local cmd = "instanceReset";
			if (not NIT.db.global.instanceResetMsg) then
				--Tell the group if we're not announcing this to party so they can get still get a chat window print.
				cmd = "instanceResetNoMsg";
			end
			if (IsInRaid()) then
				NIT:sendComm("RAID", cmd .. " " .. version .. " " .. instance);
	  		elseif (IsInGroup()) then
	  			NIT:sendComm("PARTY", cmd .. " " .. version .. " " .. instance);
	  		end
	  	end
  	end
  	if (NIT.db.global.instanceResetMsg and instance and string) then
		if (IsInRaid()) then
  			SendChatMessage("[NIT] " .. NIT:stripColors(string), "RAID");
  		elseif (IsInGroup()) then
  			SendChatMessage("[NIT] " .. NIT:stripColors(string), "PARTY");
		end
  	end
end)

--Gloabl strings
--INSTANCE_RESET_FAILED = "Cannot reset %s.  There are players still inside the instance.";
--INSTANCE_RESET_FAILED_OFFLINE = "Cannot reset %s.  There are players offline in your party.";
--INSTANCE_RESET_FAILED_ZONING = "Cannot reset %s.  There are players in your party attempting to zone into an instance.";
--INSTANCE_RESET_SUCCESS = "%s has been reset.";

--Convert seconds to a readable format.
function NIT:getTimeString(seconds, countOnly, type)
	local timecalc = 0;
	if (countOnly) then
		timecalc = seconds;
	else
		timecalc = seconds - time();
	end
	local d = math.floor((timecalc % (86400*365)) / 86400);
	local h = math.floor((timecalc % 86400) / 3600);
	local m = math.floor((timecalc % 3600) / 60);
	local s = math.floor((timecalc % 60));
	local space = "";
	if (LOCALE_koKR or LOCALE_zhCN or LOCALE_zhTW) then
		space = " ";
	end
	if (type == "short") then
		if (d == 1 and h == 0) then
			return d .. L["dayShort"];
		elseif (d == 1) then
			return d .. L["dayShort"] .. space .. h .. L["hourShort"];
		end
		if (d > 1 and h == 0) then
			return d .. L["dayShort"];
		elseif (d > 1) then
			return d .. L["dayShort"] .. space .. h .. L["hourShort"];
		end
		if (h == 1 and m == 0) then
			return h .. L["hourShort"];
		elseif (h == 1) then
			return h .. L["hourShort"] .. space .. m .. L["minuteShort"];
		end
		if (h > 1 and m == 0) then
			return h .. L["hourShort"];
		elseif (h > 1) then
			return h .. L["hourShort"] .. space .. m .. L["minuteShort"];
		end
		if (m == 1 and s == 0) then
			return m .. L["minuteShort"];
		elseif (m == 1) then
			return m .. L["minuteShort"] .. space .. s .. L["secondShort"];
		end
		if (m > 1 and s == 0) then
			return m .. L["minuteShort"];
		elseif (m > 1) then
			return m .. L["minuteShort"] .. space .. s .. L["secondShort"];
		end
		--If no matches it must be seconds only.
		return s .. L["secondShort"];
	elseif (type == "medium") then
		if (d == 1 and h == 0) then
			return d .. " " .. L["dayMedium"];
		elseif (d == 1) then
			return d .. " " .. L["dayMedium"] .. " " .. h .. " " .. L["hoursMedium"];
		end
		if (d > 1 and h == 0) then
			return d .. " " .. L["daysMedium"];
		elseif (d > 1) then
			return d .. " " .. L["daysMedium"] .. " " .. h .. " " .. L["hoursMedium"];
		end
		if (h == 1 and m == 0) then
			return h .. " " .. L["hourMedium"];
		elseif (h == 1) then
			return h .. " " .. L["hourMedium"] .. " " .. m .. " " .. L["minutesMedium"];
		end
		if (h > 1 and m == 0) then
			return h .. " " .. L["hoursMedium"];
		elseif (h > 1) then
			return h .. " " .. L["hoursMedium"] .. " " .. m .. " " .. L["minutesMedium"];
		end
		if (m == 1 and s == 0) then
			return m .. " " .. L["minuteMedium"];
		elseif (m == 1) then
			return m .. " " .. L["minuteMedium"] .. " " .. s .. " " .. L["secondsMedium"];
		end
		if (m > 1 and s == 0) then
			return m .. " " .. L["minutesMedium"];
		elseif (m > 1) then
			return m .. " " .. L["minutesMedium"] .. " " .. s .. " " .. L["secondsMedium"];
		end
		--If no matches it must be seconds only.
		return s .. " " .. L["secondsMedium"];
	else
		if (d == 1 and h == 0) then
			return d .. " " .. L["day"];
		elseif (d == 1) then
			return d .. " " .. L["day"] .. " " .. h .. " " .. L["hours"];
		end
		if (d > 1 and h == 0) then
			return d .. " " .. L["days"];
		elseif (d > 1) then
			return d .. " " .. L["days"] .. " " .. h .. " " .. L["hours"];
		end
		if (h == 1 and m == 0) then
			return h .. " " .. L["hour"];
		elseif (h == 1) then
			return h .. " " .. L["hour"] .. " " .. m .. " " .. L["minutes"];
		end
		if (h > 1 and m == 0) then
			return h .. " " .. L["hours"];
		elseif (h > 1) then
			return h .. " " .. L["hours"] .. " " .. m .. " " .. L["minutes"];
		end
		if (m == 1 and s == 0) then
			return m .. " " .. L["minute"];
		elseif (m == 1) then
			return m .. " " .. L["minute"] .. " " .. s .. " " .. L["seconds"];
		end
		if (m > 1 and s == 0) then
			return m .. " " .. L["minutes"];
		elseif (m > 1) then
			return m .. " " .. L["minutes"] .. " " .. s .. " " .. L["seconds"];
		end
		--If no matches it must be seconds only.
		return s .. " " .. L["seconds"];
	end
end

--Returns am/pm and lt/st format.
function NIT:getTimeFormat(timeStamp, fullDate, abbreviate)
	if (NIT.db.global.timeStampZone == "server") then
		--This is ugly and shouldn't work, and probably doesn't work on some time difference.
		--Need a better solution but all I can get from the wow client in server time is hour:mins, not date or full timestamp.
		local data = date("*t", GetServerTime());
		local localHour, localMin = data.hour, data.min;
		local serverHour, serverMin = GetGameTime();
		local localSecs = (localMin*60) + ((localHour*60)*60);
		local serverSecs = (serverMin*60) + ((serverHour*60)*60);
		local diff = localSecs - serverSecs;
		--local diff = difftime(localSecs - serverSecs);
		local serverTime = 0;
		--if (localHour < serverHour) then
		--	timeStamp = timeStamp - (diff + 86400);
		--else
			timeStamp = timeStamp - diff;
		--end
	end
	if (NIT.db.global.timeStampFormat == 12) then
		--Strip leading zero and convert to lowercase am/pm.
		if (fullDate) then
			if (abbreviate) then
				local string = date("%a %b %d", timeStamp);
				--print(date("%c", timeStamp))
				--print(date("%c", GetServerTime()))
				--if (string) then
				--	return;
				--end
				if (date("%x", timeStamp) == date("%x", GetServerTime())) then
					string = "Today";
				elseif (date("%x", timeStamp) == date("%x", GetServerTime() - 86400)) then
					string = "Yesterday";
				end
				return string .. " " .. gsub(string.lower(date("%I:%M%p", timeStamp)), "^0", "");
			else
				return date("%a %b %d", timeStamp) .. " " .. gsub(string.lower(date("%I:%M%p", timeStamp)), "^0", "");
			end
		else
			return gsub(string.lower(date("%I:%M%p", timeStamp)), "^0", "");
		end
	else
		if (fullDate) then
			local dateFormat = NIT:getRegionTimeFormat();
			return date(dateFormat .. " %H:%M:%S", timeStamp);
		else
		 return date("%H:%M:%S", timeStamp);
		end
	end
end

--Date 24h string format based on region, won't be 100% accurate but better than %x returning US format for every region like it does now.
function NIT:getRegionTimeFormat()
	local dateFormat = "%x";
	local region = GetCurrentRegion();
	if (NIT.realm == "Arugal" or NIT.realm == "Felstriker" or NIT.realm == "Remulos" or NIT.realm == "Yojamba") then
		--OCE
		dateFormat = "%d/%m/%y";
	elseif (NIT.realm == "Sulthraze" or NIT.realm == "Loatheb") then
		--Brazil/Latin America.
		dateFormat = "%d/%m/%y";
	elseif (region == 1) then
		--US.
		dateFormat = "%m/%d/%y";
	elseif (region == 2 or region == 4 or region == 5) then
		--Korea, Taiwan, Chinda all same format.
		dateFormat = "%y/%m/%d";
	elseif (region == 3) then
		--EU.
		dateFormat = "%d/%m/%y";
	end
	return dateFormat;
end

--Iterate table keys in alphabetical order.
function NIT:pairsByKeys(t, f)
	local a = {};
	for n in pairs(t) do
		table.insert(a, n);
	end
	table.sort(a, f);
	local i = 0;
	local iter = function()
		i = i + 1;
		if (a[i] == nil) then
			return nil;
		else
			return a[i], t[a[i]];
		end
	end
	return iter;
end

function NIT:commaValue(amount)
	if (not amount or not tonumber(amount)) then
		return;
	end
	local formatted = amount;
	while true do
		local k;
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2');
		if (k == 0) then
			break;
		end;
	end;
	return formatted;
end

--The built in coin strings didn't do exactly what I needed.
function NIT:convertMoney(money, short, separator, colorized, amountColor)
	if (not separator) then
		separator = "";
	end
	if (not amountColor) then
		amountColor = "|cFFFFFFFF";
	end
	local gold = math.floor(money / 100 / 100);
	local silver = math.floor((money / 100) % 100);
	local copper = math.floor(money % 100);
	local goldText = amountColor .. "%d|cffFFDF00gold|r"; 
	local silverText = amountColor .. "%d|cFFF0F0F0silver|r"; 
	local copperText = amountColor .. "%d|cFFD69151copper|r";
	if (short) then
		goldText = amountColor .. "%d|cffFFDF00g|r"; 
		silverText = amountColor .. "%d|cFFF0F0F0s|r"; 
		copperText = amountColor .. "%d|cFFD69151c|r";
	end
	if (not colorized) then
		goldText = NIT:stripColors(goldText);
		silverText = NIT:stripColors(silverText);
		copperText = NIT:stripColors(copperText);
	end
	local text = goldText .. separator .. silverText .. separator .. copperText;
	if (gold > 0 and silver > 0 and copper > 0) then
		text = goldText .. separator .. silverText .. separator .. copperText;
		return string.format(text, gold, silver, copper);
	elseif (silver > 0 and copper > 0) then
		text = silverText .. separator .. copperText;
		return string.format(text, silver, copper);
	elseif (copper > 0) then
		text = copperText;
		return string.format(text, copper);
	else
		text = copperText;
		return string.format(text, 0);
	end
end

--Add options to choose how money is displayed later.
function NIT:getCoinString(money, color)
	if (NIT.db.global.moneyString == "text") then
		return NIT:convertMoney(money, true, "", true, color);
	else
		return GetCoinTextureString(money);
	end
end

--Strip escape strings from chat msgs.
function NIT:stripColors(str)
	local escapes = {
    	["|c%x%x%x%x%x%x%x%x"] = "", --Color start.
    	["|r"] = "", --Color end.
    	--["|H.-|h(.-)|h"] = "%1", --Links.
    	["|T.-|t"] = "", --Textures.
    	["{.-}"] = "", --Raid target icons.
	};
	if (str) then
    	for k, v in pairs(escapes) do
        	str = gsub(str, k, v);
    	end
    end
    return str;
end

function NIT:RGBToHex(r, g, b)
	r = tonumber(r);
	g = tonumber(g);
	b = tonumber(b);
	--Check if whole numbers.
	if (r == math.floor(r) and g == math.floor(g) and b == math.floor(b)
			and (r> 1 or g > 1 or b > 1)) then
		r = r <= 255 and r >= 0 and r or 0;
		g = g <= 255 and g >= 0 and g or 0;
		b = b <= 255 and b >= 0 and b or 0;
		return string.format("%02x%02x%02x", r, g, b);
	else
		return string.format("%02x%02x%02x", r*255, g*255, b*255);
	end
end

function NIT:round(num, numDecimalPlaces)
	if (not num or not tonumber(num)) then
		return;
	end
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

--PHP explode type function.
function NIT:explode(div, str, count)
	if (div == '') then
		return false;
	end
	local pos,arr = 0,{};
	local index = 0;
	for st, sp in function() return string.find(str, div, pos, true) end do
		index = index + 1;
 		table.insert(arr, string.sub(str, pos, st-1));
		pos = sp + 1;
		if (count and index == count) then
			table.insert(arr, string.sub(str, pos));
			return arr;
		end
	end
	table.insert(arr, string.sub(str, pos));
	return arr;
end

function NIT:openConfig()
	--Opening the frame needs to be run twice to avoid a bug.
	InterfaceOptionsFrame_OpenToCategory("NovaInstanceTracker");
	--Hack to fix the issue of interface options not opening to menus below the current scroll range.
	--This addon name starts with N and will always be closer to the middle so just scroll to the middle when opening.
	local min, max = InterfaceOptionsFrameAddOnsListScrollBar:GetMinMaxValues();
	if (min < max) then
		InterfaceOptionsFrameAddOnsListScrollBar:SetValue(math.floor(max/2));
	end
	InterfaceOptionsFrame_OpenToCategory("NovaInstanceTracker");
end

function NIT:debug(...)
	if (NIT.isDebug) then
		if (type(...) == "table") then
			UIParentLoadAddOn('Blizzard_DebugTools');
			--DevTools_Dump(...);
    		DisplayTableInspectorWindow(...);
    	else
			print("NITDebug:", ...);
		end
	end
end

SLASH_NITCMD1, SLASH_NITCMD2 = '/nit', '/novainstancetracker';
function SlashCmdList.NITCMD(msg, editBox)
	if (msg == "add" or msg == "new") then
		local isInstance, instanceType = IsInInstance();
		if (isInstance) then
			--Simulate entering instance.
			NIT:enteredInstance();
		else
			NIT:print("You are not inside an instance to add.");
		end
	elseif (msg == "options" or msg == "option" or msg == "config" or msg == "menu") then
		NIT:openConfig();
	elseif (msg == "money" or msg == "gold" or msg == "trade" or msg == "trades" or msg == "tradelog") then
		NIT:openTradeLogFrame();
	elseif (msg ~= nil and msg ~= "") then
		local text, text24 = NIT:getInstanceLockoutInfoString();
		NIT:print(text .. " " .. text24, msg);
	else
		NIT:openInstanceLogFrame();
	end
end

local lockoutNum, lockoutNum24 = 0, 0;
function NIT:ticker()
	local hourCount, hourCount24, hourTimestamp, hourTimestamp24 = NIT:getInstanceLockoutInfo();
	if (hourCount24 < lockoutNum24 and lockoutNum24 == 30 and GetServerTime() - NIT.lastMerge > 3) then
		NIT:print("A new instance can be entered now (24h lockout).");
	elseif (hourCount < lockoutNum and lockoutNum == 5 and GetServerTime() - NIT.lastMerge > 3) then
		NIT:print("A new instance can be entered now.");
	end
	lockoutNum24 = hourCount24;
	lockoutNum = hourCount;
	C_Timer.After(1, function()
		NIT:ticker();
	end)
end

--Prefixes are clickable in chat to open buffs frame.
function NIT.addClickLinks(self, event, msg, author, ...)
	local types = {};
	if (event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER") then
		--Don't color the prefix for group msgs;
		types = {
			["%[NIT%]"] = "|HNITCustomLink:instancelog|h[NIT]|h|r",
		};
	else
		types = {
			["%[NIT%]"] = NIT.prefixColor .. "|HNITCustomLink:instancelog|h[NIT]|h|r",
		};
	end
	for k, v in pairs(types) do
		local match = string.match(msg, k);
		if (match) then
			msg = string.gsub(msg, k .. " (.+)", v .. " |HNITCustomLink:instancelog|h%1|h");
			return false, msg, author, ...;
		end
	end
	return false, msg, author, ...;
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", NIT.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", NIT.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", NIT.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", NIT.addClickLinks);
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", NIT.addClickLinks);

--Hook the chat link click func.
hooksecurefunc("ChatFrame_OnHyperlinkShow", function(...)
	local chatFrame, link, text, button = ...;
    if (link == "NITCustomLink:instancelog") then
		NIT:openInstanceLogFrame();
	end
	if (link == "NITCustomLink:tradelog") then
		NIT:openTradeLogFrame();
	end
	if (link == "NITCustomLink:deletelast") then
		NIT:openDeleteConfirmFrame(1);
	end
	if (link == "NITCustomLink:addinstance") then
		NIT:enteredInstance();
	end
end)

--Insert our custom link type into blizzards SetHyperlink() func.
local OriginalSetHyperlink = ItemRefTooltip.SetHyperlink
function ItemRefTooltip:SetHyperlink(link, ...)
	if (link and link:sub(0, 13) == "NITCustomLink") then
		return;
	end
	return OriginalSetHyperlink(self, link, ...);
end

local NITLDB, doUpdateMinimapButton;
function NIT:createBroker()
	local data = {
		type = "launcher",
		label = "NIT",
		text = "NovaInstanceTracker",
		icon = "Interface\\AddOns\\NovaInstanceTracker\\Media\\portal",
		OnClick = function(self, button)
			if (button == "LeftButton" and IsShiftKeyDown()) then
				NIT:openTradeLogFrame();
			elseif (button == "LeftButton") then
				NIT:openInstanceLogFrame();
			elseif (button == "RightButton" and IsShiftKeyDown()) then
				if (InterfaceOptionsFrame and InterfaceOptionsFrame:IsShown()) then
					InterfaceOptionsFrame:Hide();
				else
					NIT:openConfig();
				end
			elseif (button == "RightButton") then
				NIT:openAltsFrame();
			end
		end,
		OnLeave = function(self, button)
			doUpdateMinimapButton = nil;
		end,
		OnTooltipShow = function(tooltip)
			doUpdateMinimapButton = true;
			NIT:updateMinimapButton(tooltip);
		end,
		OnEnter = function(self, button)
			GameTooltip:SetOwner(self, "ANCHOR_NONE")
			GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
			doUpdateMinimapButton = true;
			NIT:updateMinimapButton(GameTooltip, true);
			GameTooltip:Show()
		end,
	};
	NITLDB = LDB:NewDataObject("NIT", data);
	NIT.LDBIcon:Register("NovaInstanceTracker", NITLDB, NIT.db.global.minimapIcon);
end

function NIT:updateMinimapButton(tooltip, usingPanel)
	local _, relativeTo = tooltip:GetPoint();
	if (doUpdateMinimapButton and (usingPanel or relativeTo and relativeTo:GetName() == "LibDBIcon10_NovaInstanceTracker")) then
		tooltip:ClearLines()
		tooltip:AddLine("NovaInstanceTracker");
		if (NIT.perCharOnly) then
			tooltip:AddLine("|cFF9CD6DE(This character)|r");
		end
		tooltip:AddLine(NIT:getMinimapButtonLockoutString() .. "\n");
		local expires = NIT:getMinimapButtonNextExpires();
		if (expires) then
			tooltip:AddLine(expires .. "\n");
		end
		tooltip:AddLine("|cFF9CD6DELeft-Click|r Open Instance Frame");
		tooltip:AddLine("|cFF9CD6DERight-Click|r Open Your Characters");
		tooltip:AddLine("|cFF9CD6DEShift Left-Click|r Open Trade Log");
		tooltip:AddLine("|cFF9CD6DEShift Right-Click|r Config");
		C_Timer.After(0.1, function()
			NIT:updateMinimapButton(tooltip, usingPanel);
		end)
	end
end

function NIT:getMinimapButtonLockoutString()
	local hourCount, hourCount24, hourTimestamp, hourTimestamp24 = NIT:getInstanceLockoutInfo();
	local countStringColorized = NIT.prefixColor .. hourCount .. NIT.chatColor.. " instances in the past hour.\n"
			.. NIT.prefixColor .. hourCount24 .. NIT.chatColor .. " instances in the past 24h.\n";
	local lockoutInfo = "now";
	if (GetServerTime() - hourTimestamp24 < 86400 and hourCount24 >= NIT.dailyLimit) then
		lockoutInfo = "in " .. NIT:getTimeString(86400 - (GetServerTime() - hourTimestamp24), true) .. " (24h lockout active)";
	elseif (GetServerTime() - hourTimestamp < 3600 and hourCount >= NIT.hourlyLimit) then
		lockoutInfo = "in " .. NIT:getTimeString(3600 - (GetServerTime() - hourTimestamp), true);
	end
	local msg = NIT.prefixColor .. hourCount .. NIT.chatColor.. " instances in the past hour.\n"
			.. NIT.prefixColor .. hourCount24 .. NIT.chatColor .. " instances in the past 24h.\n"
			.. "Next instance available " .. lockoutInfo .. ".";
	return msg;
end

function NIT:getMinimapButtonNextExpires(char)
	if (not char) then
		char = UnitName("player");
	end
	--local msg = "Current Hour Lockouts:";
	local msg = "";
	local count = 0;
	local found;
	for k, v in ipairs(self.data.instances) do
		if (not NIT.perCharOnly or char == v.playerName) then
			if (v.leftTime and v.leftTime > (GetServerTime() - 3600)) then
				local time = 3600 - (GetServerTime() - v.leftTime);
				--msg = msg .. "\n|cFF9CD6DE" .. v.instanceName .. " expires in " .. NIT:getTimeString(time, true);
				msg = "\n|cFF9CD6DE" .. v.instanceName .. " expires in " .. NIT:getTimeString(time, true, NIT.db.global.timeStringType) .. msg;
				found = true;
			elseif (v.enteredTime and v.enteredTime > (GetServerTime() - 3600)) then
				local time = 3600 - (GetServerTime() - v.enteredTime);
				--msg = msg .. "\n|cFF9CD6DE" .. v.instanceName .. " expires in " .. NIT:getTimeString(time, true);
				msg = "\n|cFF9CD6DE" .. v.instanceName .. " expires in " .. NIT:getTimeString(time, true, NIT.db.global.timeStringType) .. msg;
				found = true;
			else
				break;
			end
		end
	end
	if (found) then
		return "Current Hour Lockouts:" .. msg;
	else
		return;
	end
end

local NITInstanceFrame = CreateFrame("ScrollFrame", "NITInstanceFrame", UIParent, "InputScrollFrameTemplate");
local instanceFrameWidth = 620;
NITInstanceFrame:Hide();
NITInstanceFrame:SetToplevel(true);
NITInstanceFrame:SetMovable(true);
NITInstanceFrame:EnableMouse(true);
tinsert(UISpecialFrames, "NITInstanceFrame");
NITInstanceFrame:SetPoint("CENTER", UIParent, 0, 100);
NITInstanceFrame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",insets = {top = 0, left = 0, bottom = 0, right = 0}});
NITInstanceFrame:SetBackdropColor(0,0,0,.5);
NITInstanceFrame.CharCount:Hide();
NITInstanceFrame:SetFrameStrata("HIGH");
NITInstanceFrame.EditBox:SetAutoFocus(false);
NITInstanceFrame.EditBox:SetScript("OnKeyDown", function(self, arg)
	NITInstanceFrame.EditBox:ClearFocus();
end)
NITInstanceFrame.EditBox:SetScript("OnShow", function(self, arg)
	NITInstanceFrame:SetVerticalScroll(0);
	NITInstanceFrame:SetVerticalScroll(0);
end)
local instanceFrameUpdateTime = 0;
NITInstanceFrame:HookScript("OnUpdate", function(self, arg)
	NITInstanceFrame.EditBox:ClearFocus();
	--Only update once per second.
	if (GetServerTime() - instanceFrameUpdateTime > 0) then
		instanceFrameUpdateTime = GetServerTime();
		NIT:recalcInstanceLineFrames();
	end
end)
--NITInstanceFrame.fsCalc = NITInstanceFrame:CreateFontString("NITInstanceFrameFSCalc", "LOW");
--NITInstanceFrame.fsCalc:SetFont(NIT.regionFont, 14);
NITInstanceFrame.fs = NITInstanceFrame.EditBox:CreateFontString("NITInstanceFrameFS", "HIGH");
NITInstanceFrame.fs:SetPoint("TOP", 0, -0);
NITInstanceFrame.fs:SetFont(NIT.regionFont, 14);
NITInstanceFrame.fs2 = NITInstanceFrame:CreateFontString("NITInstanceFrameFS", "HIGH");
NITInstanceFrame.fs2:SetPoint("TOPLEFT", 0, -14);
NITInstanceFrame.fs2:SetFont(NIT.regionFont, 14);
NITInstanceFrame.fs3 = NITInstanceFrame:CreateFontString("NITbuffListFrameFS", "HIGH");
NITInstanceFrame.fs3:SetPoint("BOTTOM", 0, -20);
NITInstanceFrame.fs3:SetFont(NIT.regionFont, 14);

local NITInstanceDragFrame = CreateFrame("Frame", "NITlayerDragFrame", NITInstanceFrame);
NITInstanceDragFrame:SetToplevel(true);
NITInstanceDragFrame:EnableMouse(true);
NITInstanceDragFrame:SetWidth(205);
NITInstanceDragFrame:SetHeight(38);
NITInstanceDragFrame:SetPoint("TOP", 0, 4);
NITInstanceDragFrame:SetFrameLevel(131);
NITInstanceDragFrame.tooltip = CreateFrame("Frame", "NITInstanceDragTooltip", NITInstanceDragFrame, "TooltipBorderedFrameTemplate");
NITInstanceDragFrame.tooltip:SetPoint("CENTER", NITInstanceDragFrame, "TOP", 0, 12);
NITInstanceDragFrame.tooltip:SetFrameStrata("TOOLTIP");
NITInstanceDragFrame.tooltip:SetFrameLevel(9);
NITInstanceDragFrame.tooltip:SetAlpha(.8);
NITInstanceDragFrame.tooltip.fs = NITInstanceDragFrame.tooltip:CreateFontString("NITInstanceDragTooltipFS", "HIGH");
NITInstanceDragFrame.tooltip.fs:SetPoint("CENTER", 0, 0.5);
NITInstanceDragFrame.tooltip.fs:SetFont(NIT.regionFont, 12);
NITInstanceDragFrame.tooltip.fs:SetText("Hold to drag");
NITInstanceDragFrame.tooltip:SetWidth(NITInstanceDragFrame.tooltip.fs:GetStringWidth() + 16);
NITInstanceDragFrame.tooltip:SetHeight(NITInstanceDragFrame.tooltip.fs:GetStringHeight() + 10);
NITInstanceDragFrame:SetScript("OnEnter", function(self)
	NITInstanceDragFrame.tooltip:Show();
end)
NITInstanceDragFrame:SetScript("OnLeave", function(self)
	NITInstanceDragFrame.tooltip:Hide();
end)
NITInstanceDragFrame.tooltip:Hide();
NITInstanceDragFrame:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent().isMoving) then
		self:GetParent().EditBox:ClearFocus();
		self:GetParent():StartMoving();
		self:GetParent().isMoving = true;
		--self:GetParent():SetUserPlaced(false);
	end
end)
NITInstanceDragFrame:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)
NITInstanceDragFrame:SetScript("OnHide", function(self)
	if (self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)

--Top right X close button.
local NITInstanceFrameClose = CreateFrame("Button", "NITInstanceFrameClose", NITInstanceFrame, "UIPanelCloseButton");
NITInstanceFrameClose:SetPoint("TOPRIGHT", -5, 8.6);
NITInstanceFrameClose:SetWidth(31);
NITInstanceFrameClose:SetHeight(31);
NITInstanceFrameClose:SetScript("OnClick", function(self, arg)
	NITInstanceFrame:Hide();
end)

--Config button.
local NITInstanceFrameConfButton = CreateFrame("Button", "NITInstanceFrameConfButton", NITInstanceFrameClose, "UIPanelButtonTemplate");
--NITInstanceFrameConfButton:SetPoint("CENTER", -60, 1);
NITInstanceFrameConfButton:SetPoint("CENTER", -61, -22);
NITInstanceFrameConfButton:SetWidth(95);
NITInstanceFrameConfButton:SetHeight(17);
NITInstanceFrameConfButton:SetText(L["Options"]);
NITInstanceFrameConfButton:SetNormalFontObject("GameFontNormalSmall");
NITInstanceFrameConfButton:SetScript("OnClick", function(self, arg)
	NIT:openConfig();
end)
NITInstanceFrameConfButton:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent().EditBox:ClearFocus();
		self:GetParent():GetParent():StartMoving();
		self:GetParent():GetParent().isMoving = true;
	end
end)
NITInstanceFrameConfButton:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)
NITInstanceFrameConfButton:SetScript("OnHide", function(self)
	if (self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)

--Trade log button.
local NITInstanceFrameTradesButton = CreateFrame("Button", "NITInstanceFrameTradesButton", NITInstanceFrameClose, "UIPanelButtonTemplate");
--NITInstanceFrameTradesButton:SetPoint("CENTER", -60, -14);
NITInstanceFrameTradesButton:SetPoint("CENTER", -61, -38);
NITInstanceFrameTradesButton:SetWidth(95);
NITInstanceFrameTradesButton:SetHeight(17);
NITInstanceFrameTradesButton:SetText("Trade Log");
NITInstanceFrameTradesButton:SetNormalFontObject("GameFontNormalSmall");
NITInstanceFrameTradesButton:SetScript("OnClick", function(self, arg)
	NIT:openTradeLogFrame();
end)
NITInstanceFrameTradesButton:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent().EditBox:ClearFocus();
		self:GetParent():GetParent():StartMoving();
		self:GetParent():GetParent().isMoving = true;
	end
end)
NITInstanceFrameTradesButton:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)
NITInstanceFrameTradesButton:SetScript("OnHide", function(self)
	if (self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)

--Rested button.
local NITInstanceFrameRestedButton = CreateFrame("Button", "NITInstanceFrameRestedButton", NITInstanceFrameClose, "UIPanelButtonTemplate");
--NITInstanceFrameRestedButton:SetPoint("CENTER", -80, -30);
--NITInstanceFrameRestedButton:SetPoint("CENTER", -60, -28);
NITInstanceFrameRestedButton:SetPoint("CENTER", -70, -3);
--NITInstanceFrameRestedButton:SetWidth(134);
--NITInstanceFrameRestedButton:SetHeight(18);
NITInstanceFrameRestedButton:SetWidth(115);
--NITInstanceFrameRestedButton:SetHeight(17);
NITInstanceFrameRestedButton:SetHeight(25);
NITInstanceFrameRestedButton:SetText("Your Characters");
NITInstanceFrameRestedButton:SetNormalFontObject("GameFontNormalSmall");
NITInstanceFrameRestedButton:SetScript("OnClick", function(self, arg)
	NIT:openAltsFrame();
end)
NITInstanceFrameRestedButton:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent().EditBox:ClearFocus();
		self:GetParent():GetParent():StartMoving();
		self:GetParent():GetParent().isMoving = true;
	end
end)
NITInstanceFrameRestedButton:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)
NITInstanceFrameRestedButton:SetScript("OnHide", function(self)
	if (self:GetParent():GetParent().isMoving) then
		self:GetParent():GetParent():StopMovingOrSizing();
		self:GetParent():GetParent().isMoving = false;
	end
end)

function NIT:createInstanceFrameShowsAltsButton()
	if (NIT.instanceFrameShowsAltsButton) then
		return;
	end
	NIT.instanceFrameShowsAltsButton = CreateFrame("CheckButton", "NITInstanceFrameShowsAltsButton", NITInstanceFrame.EditBox, "ChatConfigCheckButtonTemplate");
	NIT.instanceFrameShowsAltsButton:SetPoint("TOPLEFT", 5, -5);
	--So strange the way to set text is to append Text to the global frame name.
	NITInstanceFrameShowsAltsButtonText:SetText("Show Alts");
	NIT.instanceFrameShowsAltsButton.tooltip = "Show all alts in the instance log? (Lockouts are per character)";
	NIT.instanceFrameShowsAltsButton:SetFrameStrata("HIGH");
	NIT.instanceFrameShowsAltsButton:SetFrameLevel(3);
	NIT.instanceFrameShowsAltsButton:SetWidth(24);
	NIT.instanceFrameShowsAltsButton:SetHeight(24);
	NIT.instanceFrameShowsAltsButton:SetChecked(NIT.db.global.showAltsLog);
	NIT.instanceFrameShowsAltsButton:SetScript("OnClick", function()
		local value = NIT.instanceFrameShowsAltsButton:GetChecked();
		NIT.db.global.showAltsLog = value;
		NIT:hideAllLineFrames();
		NIT:recalcInstanceLineFrames();
		--Refresh the config page.
		NIT.acr:NotifyChange("NovaInstanceTracker");
	end)
end

function NIT:openInstanceLogFrame()
	if (not NIT.instanceFrameShowsAltsButton) then
		NIT:createInstanceFrameShowsAltsButton();
	end
	local header = NIT.prefixColor .. "NovaInstanceTracker v" .. version .. "|r\n"
			.. "|TInterface\\AddOns\\NovaInstanceTracker\\Media\\00C800Square:10:10:0:0|t Past hour"
			.. "    |TInterface\\AddOns\\NovaInstanceTracker\\Media\\FFFF00Square:10:10:0:0|t Past 24 hours"
			.. "    |TInterface\\AddOns\\NovaInstanceTracker\\Media\\FF0000Square:10:10:0:0|t Older";
	NITInstanceFrame.fs:SetText(header);
	NIT:createInstanceLineFrames(true);
	--Quick fix to re-set the region font since the frames are created before we set region font.
	NITInstanceFrame.fs:SetFont(NIT.regionFont, 14);
	NITInstanceFrame.fs2:SetFont(NIT.regionFont, 14);
	NITInstanceFrame.fs3:SetFont(NIT.regionFont, 14);
	if (NITInstanceFrame:IsShown()) then
		NITInstanceFrame:Hide();
	else
		if (not _G["titleNITInstanceLine"]) then
			NIT:createTitleInstanceLineFrame();
			_G["titleNITInstanceLine"]:Show();
			_G["titleNITInstanceLine"]:ClearAllPoints();
			_G["titleNITInstanceLine"]:SetPoint("LEFT", NITInstanceFrame.EditBox, "TOPLEFT", 3, -45);
		end
		--Fit exactly the last 30 instances in the frames opening scroll area.
		NITInstanceFrame:SetHeight(473);
		NITInstanceFrame:SetHeight(487);
		NITInstanceFrame:SetWidth(instanceFrameWidth);
		local fontSize = false;
		NITInstanceFrame.EditBox:SetFont(NIT.regionFont, 14);
		NITInstanceFrame.EditBox:SetWidth(NITInstanceFrame:GetWidth() - 30);
		NITInstanceFrame:Show();
		--Changing scroll position requires a slight delay.
		--Second delay is a backup.
		C_Timer.After(0.05, function()
			NITInstanceFrame:SetVerticalScroll(0);
		end)
		C_Timer.After(0.3, function()
			NITInstanceFrame:SetVerticalScroll(0);
		end)
		--So interface options and this frame will open on top of each other.
		if (InterfaceOptionsFrame:IsShown()) then
			NITInstanceFrame:SetFrameStrata("DIALOG");
		else
			NITInstanceFrame:SetFrameStrata("HIGH");
		end
		NIT:recalcInstanceLineFrames();
	end
end

function NIT:createInstanceLineFrames(skipRecalc)
	local count = 0;
	local new;
	for k, v in NIT:pairsByKeys(NIT.data.instances) do
		count = count + 1;
		if (not _G[k .. "NITInstanceLine"]) then
			NIT:createInstanceLineFrame(k, v, count);
			new = true;
		end
	end
	if (new and not skipRecalc) then
		NIT:recalcInstanceLineFrames();
	end
end

function NIT:createInstanceLineFrame(type, data, count)
	if (not _G[type .. "NITInstanceLine"]) then
		local obj = CreateFrame("Frame", type .. "NITInstanceLine", NITInstanceFrame.EditBox);
		obj.name = data.name;
		obj.count = count;
		local bg = obj:CreateTexture(nil, "HIGH");
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj.fs = obj:CreateFontString(type .. "NITInstanceLineFS", "ARTWORK");
		obj.fs:SetPoint("LEFT", 0, 0);
		obj.fs:SetFont(NIT.regionFont, 14);
		--They don't quite line up properly without justify on top of set point left.
		obj.fs:SetJustifyH("LEFT");
		obj.tooltip = CreateFrame("Frame", type .. "NITInstanceLineTooltip", NITInstanceFrame, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -46);
		obj.tooltip:SetFrameStrata("HIGH");
		obj.tooltip:SetFrameLevel(4);
		obj.tooltip.fs = obj.tooltip:CreateFontString(type .. "NITInstanceLineTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NIT.regionFont, 13);
		obj.tooltip.fs:SetJustifyH("LEFT");
		obj.tooltip.fs:SetText("|CffDEDE42Frame " .. count);
		obj.tooltip.fsCalc = obj.tooltip:CreateFontString(type .. "NITInstanceLineTooltipFS", "ARTWORK");
		obj.tooltip.fsCalc:SetFont(NIT.regionFont, 13);
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
		obj.tooltip:SetScript("OnUpdate", function(self)
		obj.tooltip.updateTime = 0;
			--Keep our custom tooltip at the mouse when it moves.
			local scale, x, y = obj.tooltip:GetEffectiveScale(), GetCursorPosition();
			obj.tooltip:SetPoint("RIGHT", nil, "BOTTOMLEFT", (x / scale) - 2, y / scale);
			local instanceFrameUpdateTime = 0;
			--Only update once per second.
			if (GetServerTime() - obj.tooltip.updateTime > 0) then
				obj.tooltip.updateTime = GetServerTime();
				NIT:recalcInstanceLineFramesTooltip(obj);
			end
		end)
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
			NIT:recalcInstanceLineFramesTooltip(obj);
			local scale, x, y = obj.tooltip:GetEffectiveScale(), GetCursorPosition();
			obj.tooltip:SetPoint("CENTER", nil, "BOTTOMLEFT", x / scale, y / scale);
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		obj.tooltip:Hide();
		--obj:SetScript("OnMouseDown", function(self)
			--Maybe add a mouse event here later.
		--end)
		
		obj.removeButton = CreateFrame("Button", type .. "NITInstanceLineRB", obj, "UIPanelButtonTemplate");
		obj.removeButton:SetPoint("LEFT", obj, "RIGHT", 34, 0);
		obj.removeButton:SetWidth(13);
		obj.removeButton:SetHeight(13);
		--obj.removeButton:SetText("X");
		obj.removeButton:SetNormalFontObject("GameFontNormalSmall");
		--obj.removeButton:SetScript("OnClick", function(self, arg)

		--end)
		obj.removeButton:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_7");
		obj.removeButton.tooltip = CreateFrame("Frame", type .. "NITInstanceLineTooltipRB", NITInstanceFrame, "TooltipBorderedFrameTemplate");
		obj.removeButton.tooltip:SetPoint("RIGHT", obj.removeButton, "LEFT", -5, 0);
		obj.removeButton.tooltip:SetFrameStrata("HIGH");
		obj.removeButton.tooltip:SetFrameLevel(3);
		obj.removeButton.tooltip.fs = obj.removeButton.tooltip:CreateFontString(type .. "NITInstanceLineTooltipRBFS", "ARTWORK");
		obj.removeButton.tooltip.fs:SetPoint("CENTER", -0, 0);
		obj.removeButton.tooltip.fs:SetFont(NIT.regionFont, 13);
		obj.removeButton.tooltip.fs:SetJustifyH("LEFT");
		obj.removeButton.tooltip.fs:SetText("|CffDEDE42Delete entry " .. count);
		obj.removeButton.tooltip:SetWidth(obj.removeButton.tooltip.fs:GetStringWidth() + 18);
		obj.removeButton.tooltip:SetHeight(obj.removeButton.tooltip.fs:GetStringHeight() + 12);
		obj.removeButton:SetScript("OnEnter", function(self)
			obj.removeButton.tooltip:Show();
		end)
		obj.removeButton:SetScript("OnLeave", function(self)
			obj.removeButton.tooltip:Hide();
		end)
		obj.removeButton.tooltip:Hide();
	end
end

function NIT:createTitleInstanceLineFrame()
	if (not _G["titleNITInstanceLine"]) then
		local obj = CreateFrame("Frame", "titleNITInstanceLine", NITInstanceFrame.EditBox);
		local bg = obj:CreateTexture(nil, "HIGH");
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj.fs = obj:CreateFontString("titleNITInstanceLineFS", "ARTWORK");
		obj.fs:SetPoint("LEFT", 0, 0);
		obj.fs:SetFont(NIT.regionFont, 14);
		obj.fs:SetJustifyH("LEFT");
	end
end

function NIT:recalcInstanceLineFrames()
	if (not _G["titleNITInstanceLine"]) then
		--Frame hasn't been opened since logon, no need to recalc.
		return;
	end
	local offset, count = 75, 0; --60
	local hour, hour24, hourTimestamp, hourTimestamp24 = NIT:getInstanceLockoutInfo();
	local lockoutString, lockoutStringShort = NIT:getInstanceLockoutInfoString();
	local text = "|cFFFFFF00 Last hour: |cFFFF6900" .. hour .. " |cFFFFFF00Last 24h: |cFFFF6900" .. hour24;
		if (NIT.perCharOnly) then
			text = text	.. " |cFFFFFF00(This character)";
		end
		text = text	.. "\n |cFF9CD6DE" .. lockoutStringShort;
	_G["titleNITInstanceLine"].fs:SetText(text);
	_G["titleNITInstanceLine"]:SetWidth(_G["titleNITInstanceLine"].fs:GetWidth());
	_G["titleNITInstanceLine"]:SetHeight(_G["titleNITInstanceLine"].fs:GetHeight());
	local framesUsed = {};
	for k, v in NIT:pairsByKeys(NIT.data.instances) do
		if (NIT.perCharOnly and (UnitName("player") == v.playerName or NIT.db.global.showAltsLog)) then
			if (_G[k .. "NITInstanceLine"]) then
				local timeAgo = GetServerTime() - v.enteredTime;
				if (v.leftTime and v.leftTime > 0) then
					timeAgo = GetServerTime() - v.leftTime;
				end
				if (NIT.db.global.show24HourOnly and timeAgo > 86400) then
					break;
				end
				count = count + 1;
				if (count > self.db.global.logSize) then
					if (_G[count .. "NITInstanceLine"]) then
						_G[count .. "NITInstanceLine"]:Hide();
					end
				else
					framesUsed[count] = true;
					_G[count .. "NITInstanceLine"]:Show();
					_G[count .. "NITInstanceLine"]:ClearAllPoints();
					_G[count .. "NITInstanceLine"]:SetPoint("LEFT", NITInstanceFrame.EditBox, "TOPLEFT", 3, -offset);
					offset = offset + 14;
					local line = NIT:buildInstanceLineFrameString(v, count);
					if (count < 10) then
						--Offset the text for single digit numbers so the date comlumn lines up.
						_G[count .. "NITInstanceLine"].fs:SetPoint("LEFT", 7, 0);
					else
						_G[count .. "NITInstanceLine"].fs:SetPoint("LEFT", 0, 0);
					end
					_G[count .. "NITInstanceLine"].fs:SetText(line);
					--Leave enough room on the right of frame to not overlap the scroll bar (-20) and remove button (-20).
					_G[count .. "NITInstanceLine"]:SetWidth(NITInstanceFrame:GetWidth() - 120);
					_G[count .. "NITInstanceLine"]:SetHeight(_G[count .. "NITInstanceLine"].fs:GetHeight());
					_G[count .. "NITInstanceLine"].removeButton.count = count;
					_G[count .. "NITInstanceLine"].removeButton:SetScript("OnClick", function(self, arg)
						--Open delete confirmation box to delete table id (k), but display it as matching log number (count).
						NIT:openDeleteConfirmFrame(k, self.count);
					end)
				end
			end
		end
	end
	--Hide any no longer is use lines frames from the bottom when instances are deleted.
	for i = 1, NIT.maxRecordsShown do
		if (_G[i .. "NITInstanceLine"] and not framesUsed[i]) then
			_G[i .. "NITInstanceLine"]:Hide();
		end
	end
end

function NIT:buildInstanceLineFrameString(v, count)
	local player = v.playerName;
	local _, _, _, classColorHex = GetClassColor(v.classEnglish);
	local instance = v.instanceName;
	local time = NIT:getTimeFormat(v.enteredTime, true, true);
	local timeAgo = GetServerTime() - v.enteredTime;
	local enteredType = "entered";
	if (v.leftTime and v.leftTime > 0) then
		--If valid left time use that instead.
		enteredType = "left";
		timeAgo = GetServerTime() - v.leftTime;
		time = NIT:getTimeFormat(v.leftTime, true, true);
	end
	local lockoutTime;
	local timeColor = "|cFFFF2222";
	local lockoutTimeString, altString = "", "";
	if (NIT.perCharOnly and UnitName("player") ~= v.playerName) then
		lockoutTimeString = instance .. " (Entered " .. NIT:getTimeString(timeAgo, true, NIT.db.global.timeStringType) .. " ago)";
		--altString = " |cFFFFFFFF(|cFFEBA286Alt|r|cFFFFFFFF)";
	else
		lockoutTimeString = instance .. " (Entered " .. NIT:getTimeString(timeAgo, true, NIT.db.global.timeStringType) .. " ago)";
	end
	if (count == 1 and NIT.inInstance) then
		if (timeAgo < 3600) then
			timeColor = "|cFF00C800";
		elseif (timeAgo < 86400) then
			timeColor = "|cFFDEDE42";
		end
		lockoutTimeString = instance .. " (Still inside dungeon)";
	elseif (timeAgo < 3600) then
		lockoutTime = NIT:getTimeString(3600 - timeAgo, true, NIT.db.global.timeStringType)
		if (not NIT.perCharOnly or UnitName("player") == v.playerName) then
			timeColor = "|cFF00C800";
			lockoutTimeString = instance .. " (" .. lockoutTime .. " left on lockout)";
		end
	elseif (timeAgo < 86400) then
		lockoutTime = NIT:getTimeString(86400 - timeAgo, true, NIT.db.global.timeStringType)
		if (not NIT.perCharOnly or UnitName("player") == v.playerName) then
			timeColor = "|cFFDEDE42";
			lockoutTimeString = instance .. " (" .. lockoutTime .. " left on daily lockout)";
		end
	end
	local line = "";
	if (NIT.db.global.showLockoutTime) then
		line = "|cFF9CD6DE" .. count .. ")|r [" .. timeColor .. time .. "|cFF9CD6DE]|r |c" .. classColorHex .. player 
			.. "|r |cFF9CD6DE" .. lockoutTimeString .. altString;
	else
		line = "|cFF9CD6DE" .. count .. ")|r [" .. timeColor .. time .. "|cFF9CD6DE]|r |c" .. classColorHex .. player 
			.. "|r |cFF9CD6DE" .. instance .. " (Entered " .. NIT:getTimeString(timeAgo, true, NIT.db.global.timeStringType) .. " ago)";
	end
	return line;
end

function NIT:hideAllLineFrames()
	for i = 1, NIT.db.global.maxRecordsKept do
		if (_G[i .. "NITInstanceLine"]) then
			_G[i .. "NITInstanceLine"]:Hide();
		end
	end
end

function NIT:recalcInstanceLineFramesTooltip(obj)
	local data = NIT.data.instances[obj.count];
	if (data) then
		local timeSpent = "Unknown";
		if (data.enteredTime and data.leftTime and data.enteredTime > 0 and data.leftTime > 0) then
			timeSpent = NIT:getTimeString(data.leftTime - data.enteredTime, true);
		end
		local averageXP = "Unknown";
		if (data.xpFromChat and data.mobCount and data.enteredTime > 0 and data.mobCount > 0) then
			averageXP = data.xpFromChat / data.mobCount;
		end
		local timeLastInside = GetServerTime() - data.enteredTime;
		if (data.leftTime and data.leftTime > 0) then
			timeLastInside = GetServerTime() - data.leftTime;
		end
		local timeLeft = "Unknown";
		if (data.leftTime and data.leftTime > 0) then
			 timeLeft = NIT:getTimeFormat(data.leftTime, true, true);
		end
		local timeColor = "|cFFFF2222";
		if (timeLastInside < 3600) then
			 timeColor = "|cFF00C800";
		elseif (timeLastInside < 86400) then
			timeColor = "|cFFDEDE42";
		end
		local player = data.playerName;
		local _, _, _, classColorHex = GetClassColor(data.classEnglish);
		--local text = "|c" .. classColorHex .. player .. " " .. timeColor .. "Instance " .. obj.count .. " (" .. data.instanceName .. ")"
		local text = timeColor .. "Instance " .. obj.count .. " (" .. data.instanceName .. ")"
		text = text .. "\n|cFF9CD6DETime Entered:|r " .. NIT:getTimeFormat(data.enteredTime, true, true);
		text = text .. "\n|cFF9CD6DETime Left:|r " .. timeLeft;
		text = text .. "\n|cFF9CD6DETime Inside:|r " .. timeSpent;
		text = text .. "\n|cFF9CD6DEMob Count:|r " .. (data.mobCount or "Unknown");
		text = text .. "\n|cFF9CD6DEExperience:|r " .. (NIT:commaValue(data.xpFromChat) or "Unknown");
		text = text .. "\n|cFF9CD6DEAverage XP/Mob:|r " .. (NIT:round(averageXP, 2) or "0");
		if (data.rawMoneyCount and data.rawMoneyCount > 0) then
			text = text .. "\n|cFF9CD6DERaw Gold From Mobs:|r " .. GetCoinTextureString(data.rawMoneyCount);
		elseif (data.enteredMoney and data.leftMoney and data.enteredMoney > 0 and data.leftMoney > 0
				and data.leftMoney > data.enteredMoney) then
			--Backup for people with addons installed using an altered money string.
			local moneyCount = data.leftMoney - data.enteredMoney;
			text = text .. "\n|cFF9CD6DERaw Gold From Mobs:|r " .. GetCoinTextureString(moneyCount);
		else
			text = text .. "\n|cFF9CD6DERaw Gold From Mobs:|r " .. GetCoinTextureString(0);
		end
		text = text .. "\n|cFF9CD6DEEntered Level:|r " .. (data.enteredLevel or "Unknown");
		text = text .. "\n|cFF9CD6DELeft Level:|r " .. (data.leftLevel or "Unknown");
		text = text .. "\n|cFF9CD6DEAverage Group Level:|r " .. (NIT:round(data.groupAverage, 2) or "Unknown");
		if (data.playerName ~= UnitName("player")) then
			--Show lockout timers for alts if you hover them.
			--Use the minimap lockout string for this, it's small and neat.
			--text = text .. "\n\n|cFF9CD6DEThis alts current lockouts:|r\n";
			text = text .. "\n\n|c" .. classColorHex .. player .. "|cFF9CD6DE current lockouts:|r\n";
			text = text .. NIT:getAltLockoutString(data.playerName);
			local expires = NIT:getMinimapButtonNextExpires(data.playerName);
			if (expires) then
				text = text .. "\n\n" .. expires;
			end
		end
		if (data.rep and next(data.rep)) then
			text = text .. "\n\n|cFFFFFF00Reputation Gains:|r"
			for k, v in NIT:pairsByKeys(data.rep) do
				if (v > 0) then
					v = "+" .. NIT:commaValue(v);
				else
					v = NIT:commaValue(v);
				end
				text = text .. "\n |cFF9CD6DE" .. k .. "|r " .. v;
			end
		end
		if (data.group and next(data.group)) then
			local memberCount = 0;
			for k, v in pairs(data.group) do
				memberCount = memberCount + 1;
			end
			--Make extra columns if many group members.
			local perLine = 1;
			if (memberCount > 50) then
				perLine = 4
			elseif (memberCount > 24) then
				perLine = 3
			elseif (memberCount > 14) then
				perLine = 2
			end
			text = text .. "\n\n|cFFFFFF00Group Members (" .. memberCount .. "):|r\n";
			local count = 0;
			local spacing = 30;
			--This is ugly but works, table is small.
			--Sorts by level and then name.
			local temp = {};
			for i = NIT.maxLevel, 0, -1 do
				for k, v in NIT:pairsByKeys(data.group) do
					if (i == v.level) then
						v.name = k;
						table.insert(temp, v);
					end
				end
			end
			for k, v in ipairs(temp) do
				count = count + 1;
				local nl = "";
				local _, _, _, classColorHex = GetClassColor(string.upper(v.classEnglish));
				if ((count ~= 1 and math.fmod(count, perLine) == 0)
						or (count == 1 and perLine == 1)) then
					nl = "\n";
				end
				local groupLine = "";
				if (v.guildName) then
					groupLine = " |cFFFFFFFF" .. v.level .. "|r |c" .. classColorHex .. v.name .. " |cFF989898(" .. v.guildName .. ")|r";
				else
					groupLine = " |cFFFFFFFF" .. v.level .. "|r |c" .. classColorHex .. v.name .. "|r";
				end
				obj.tooltip.fsCalc:SetText(groupLine);
				--Space strings so they roughly look like columns.
				if (math.fmod(count, perLine) > 0) then
					obj.tooltip.fsCalc:SetText(groupLine);
					--Trim string if multiple columns.
					while obj.tooltip.fsCalc:GetWidth() > 150 do
						groupLine = string.sub(groupLine, 1, -2);
						obj.tooltip.fsCalc:SetText(groupLine);
					end
					obj.tooltip.fsCalc:SetText(groupLine);
					while obj.tooltip.fsCalc:GetWidth() < 160 do
						groupLine = groupLine .. " ";
						obj.tooltip.fsCalc:SetText(groupLine);
					end
				end
				text = text .. groupLine .. nl;
			end
		end
		obj.tooltip.fs:SetText(text);
	else
		obj.tooltip.fs:SetText("|CffDEDE42Frame " .. obj.count .. "\nNo data available for this instance.");
	end
	obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
	obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
end

function NIT:getAltLockoutString(char)
	local hourCount, hourCount24, hourTimestamp, hourTimestamp24 = NIT:getInstanceLockoutInfo(char);
	local countStringColorized = NIT.prefixColor .. hourCount .. NIT.chatColor.. " instances in the past hour.\n"
			.. NIT.prefixColor .. hourCount24 .. NIT.chatColor .. " instances in the past 24h.\n";
	local lockoutInfo = "now";
	if (GetServerTime() - hourTimestamp24 < 86400 and hourCount24 >= NIT.dailyLimit) then
		lockoutInfo = "in " .. NIT:getTimeString(86400 - (GetServerTime() - hourTimestamp24), true) .. " (24h lockout active)";
	elseif (GetServerTime() - hourTimestamp < 3600 and hourCount >= NIT.hourlyLimit) then
		lockoutInfo = "in " .. NIT:getTimeString(3600 - (GetServerTime() - hourTimestamp), true);
	end
	local msg = NIT.prefixColor .. hourCount .. NIT.chatColor.. " instances in the past hour.\n"
			.. NIT.prefixColor .. hourCount24 .. NIT.chatColor .. " instances in the past 24h.\n"
			.. "Next instance available " .. lockoutInfo .. ".";
	return msg;
end

function NIT:test()
	--.NIT:print("Texture test: |TInterface\\AddOns\\NovaInstanceTracker\\Media\\redX:12:12:0:0|t");
	print("|cFF9CD6DE" .. L["versionOutOfDate"]);
	NIT:print(NIT.mergeColor .. "Same instance ID as last detected, merging database entries.");
end

local NITInstanceFrameDeleteConfirm = CreateFrame("ScrollFrame", "NITInstanceFrameDC", UIParent, "InputScrollFrameTemplate");
NITInstanceFrameDeleteConfirm:Hide();
NITInstanceFrameDeleteConfirm:SetToplevel(true);
NITInstanceFrameDeleteConfirm:SetHeight(130);
NITInstanceFrameDeleteConfirm:SetWidth(250);
tinsert(UISpecialFrames, "NITInstanceFrameDeleteConfirm");
NITInstanceFrameDeleteConfirm:SetPoint("CENTER", UIParent, 0, 200);
NITInstanceFrameDeleteConfirm:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",insets = {top = 0, left = 0, bottom = 0, right = 0}});
NITInstanceFrameDeleteConfirm:SetBackdropColor(0,0,0,1);
NITInstanceFrameDeleteConfirm.CharCount:Hide();
NITInstanceFrameDeleteConfirm:SetFrameStrata("HIGH");
NITInstanceFrameDeleteConfirm.EditBox:SetAutoFocus(false);
NITInstanceFrameDeleteConfirm.EditBox:EnableMouse(false);
NITInstanceFrameDeleteConfirm.EditBox:SetScript("OnKeyDown", function(self, arg)
	NITInstanceFrameDeleteConfirm.EditBox:ClearFocus();
end)
NITInstanceFrameDeleteConfirm.EditBox:SetScript("OnUpdate", function(self, arg)
	--This is a hack so the editbox never gets focus and I can use the same frame template minus the editbox.
	NITInstanceFrameDeleteConfirm.EditBox:ClearFocus();
end)
NITInstanceFrameDeleteConfirm.EditBox:SetScript("OnHide", function(self, arg)
	--Clear the instance deletion that was set.
	NITInstanceFrameDCDelete:SetScript("OnClick", function(self, arg) end);
end)

NITInstanceFrameDeleteConfirm.fs = NITInstanceFrameDeleteConfirm:CreateFontString("NITInstanceFrameFS", "HIGH");
NITInstanceFrameDeleteConfirm.fs:SetPoint("TOP", 0, -4);
NITInstanceFrameDeleteConfirm.fs:SetFont(NIT.regionFont, 14);
NITInstanceFrameDeleteConfirm.fs:SetText("Instance data missing");

--Delete button.
local NITInstanceFrameDCDelete = CreateFrame("Button", "NITInstanceFrameDCDelete", NITInstanceFrameDeleteConfirm, "UIPanelButtonTemplate");
NITInstanceFrameDCDelete:SetPoint("CENTER", 0, -40);
NITInstanceFrameDCDelete:SetWidth(120);
NITInstanceFrameDCDelete:SetHeight(30);
--NITInstanceFrameDCDelete:SetText(L["confirmDelete"]);
NITInstanceFrameDCDelete:SetText(L["delete"]);
NITInstanceFrameDCDelete:SetNormalFontObject("GameFontNormal");

--Top right X close button.
local NITInstanceDCFrameClose = CreateFrame("Button", "NITInstanceDCFrameClose", NITInstanceFrameDeleteConfirm, "UIPanelCloseButton");
NITInstanceDCFrameClose:SetPoint("TOPRIGHT", 10, 10);
NITInstanceDCFrameClose:SetWidth(36);
NITInstanceDCFrameClose:SetHeight(36);
NITInstanceDCFrameClose:SetScript("OnClick", function(self, arg)
	NITInstanceFrameDeleteConfirm:Hide();
end)

--Open delete confirmation box.
--If displayNum is provided then we display it as the matching number in the instance log.
--But we still delete the right table id number.
local deleteItemLast;
function NIT:openDeleteConfirmFrame(num, displayNum)
	--Close window if we click delete button for same item again, but open new one if different item is clicked.
	if (NITInstanceFrameDeleteConfirm:IsShown() and num == deleteItemLast) then
		NITInstanceFrameDeleteConfirm:Hide();
	else
		NITInstanceFrameDeleteConfirm:Hide();
		local data = NIT.data.instances[num];
		if (data) then
			local player = data.playerName;
			local _, _, _, classColorHex = GetClassColor(data.classEnglish);
			local instance = data.instanceName;
			local time = NIT:getTimeFormat(data.enteredTime, true, true);
			local timeAgo = GetServerTime() - data.enteredTime;
			local timeLastInside = GetServerTime() - data.enteredTime;
			if (data.leftTime and data.leftTime > 0) then
				timeLastInside = GetServerTime() - data.leftTime;
			end
			local timeColor = "|cFFFF2222";
			if (timeLastInside < 3600) then
				 timeColor = "|cFF00C800";
			elseif (timeLastInside < 86400) then
				timeColor = "|cFFDEDE42";
			end
			local text = NIT.prefixColor .. L["confirmInstanceDeletion"] .. "|r\n";
			if (displayNum) then
				text = text .. "\n|cFF9CD6DE" .. instance .. " (" .. displayNum .. ")|r";
			else
				text = text .. "\n|cFF9CD6DE" .. instance .. " (" .. num .. ")|r";
			end
			text = text .. "\n" .. timeColor .. time .. "|r";
			text = text .. "\n|c" .. classColorHex .. player .. " |cFF9CD6DE(" .. NIT:getTimeString(timeAgo, true) .. " ago)";
			NITInstanceFrameDeleteConfirm.fs:SetText(text);
			NITInstanceFrameDCDelete:Show();
			NITInstanceFrameDCDelete:SetScript("OnClick", function(self, arg)
				NIT:deleteInstance(num, displayNum);
				NITInstanceFrameDeleteConfirm:Hide();
			end)
		else
			NITInstanceFrameDeleteConfirm.fs:SetText("Error: Instance data missing");
			--NITInstanceFrameDCDelete:SetText(L["Error"]);
			NITInstanceFrameDCDelete:Hide();
		end
		NITInstanceFrameDeleteConfirm:Show();
	end
	deleteItemLast = num;
end

---Trade Log---
local NITTradeLogFrame = CreateFrame("ScrollFrame", "NITTradeLogFrame", UIParent, "InputScrollFrameTemplate");
NITTradeLogFrame:Hide();
NITTradeLogFrame:SetToplevel(true);
NITTradeLogFrame:SetMovable(true);
NITTradeLogFrame:EnableMouse(true);
tinsert(UISpecialFrames, "NITTradeLogFrame");
NITTradeLogFrame:SetPoint("CENTER", UIParent, 20, 120);
NITTradeLogFrame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",insets = {top = 0, left = 0, bottom = 0, right = 0}});
NITTradeLogFrame:SetBackdropColor(0,0,0,.8);
NITTradeLogFrame.CharCount:Hide();
--NITTradeLogFrame:SetFrameLevel(128);
NITTradeLogFrame:SetFrameStrata("MEDIUM");
NITTradeLogFrame.EditBox:SetAutoFocus(false);
NITTradeLogFrame.EditBox:SetFont(NIT.regionFont, 10);
NITTradeLogFrame.EditBox:SetScript("OnKeyDown", function(self, arg)
	NITTradeLogFrame.EditBox:ClearFocus();
end)
NITTradeLogFrame.EditBox:SetScript("OnShow", function(self, arg)
	NITTradeLogFrame:SetVerticalScroll(0);
end)
local buffUpdateTime = 0;
NITTradeLogFrame:HookScript("OnUpdate", function(self, arg)
	if (GetServerTime() - buffUpdateTime > 0 and self:GetVerticalScrollRange() == 0) then
		NIT:recalcTradeLogFrame();
		buffUpdateTime = GetServerTime();
	end
end)
NITTradeLogFrame.fs = NITTradeLogFrame.EditBox:CreateFontString("NITTradeLogFrameFS", "HIGH");
NITTradeLogFrame.fs:SetPoint("TOP", 0, 0);
NITTradeLogFrame.fs:SetFont(NIT.regionFont, 14);

local NITTradeLogDragFrame = CreateFrame("Frame", "NITTradeLogDragFrame", NITTradeLogFrame);
NITTradeLogDragFrame:EnableMouse(true);
NITTradeLogDragFrame:SetWidth(205);
NITTradeLogDragFrame:SetHeight(38);
NITTradeLogDragFrame:SetPoint("TOP", 0, 4);
NITTradeLogDragFrame:SetFrameLevel(131);
NITTradeLogDragFrame.tooltip = CreateFrame("Frame", "NITTradeLogDragTooltip", NITTradeLogDragFrame, "TooltipBorderedFrameTemplate");
NITTradeLogDragFrame.tooltip:SetPoint("CENTER", NITTradeLogDragFrame, "TOP", 0, 12);
NITTradeLogDragFrame.tooltip:SetFrameStrata("TOOLTIP");
NITTradeLogDragFrame.tooltip:SetFrameLevel(9);
NITTradeLogDragFrame.tooltip:SetAlpha(.8);
NITTradeLogDragFrame.tooltip.fs = NITTradeLogDragFrame.tooltip:CreateFontString("NITTradeLogDragTooltipFS", "HIGH");
NITTradeLogDragFrame.tooltip.fs:SetPoint("CENTER", 0, 0.5);
NITTradeLogDragFrame.tooltip.fs:SetFont(NIT.regionFont, 13);
NITTradeLogDragFrame.tooltip.fs:SetText("Hold to drag");
NITTradeLogDragFrame.tooltip:SetWidth(NITTradeLogDragFrame.tooltip.fs:GetStringWidth() + 16);
NITTradeLogDragFrame.tooltip:SetHeight(NITTradeLogDragFrame.tooltip.fs:GetStringHeight() + 10);
NITTradeLogDragFrame:SetScript("OnEnter", function(self)
	NITTradeLogDragFrame.tooltip:Show();
end)
NITTradeLogDragFrame:SetScript("OnLeave", function(self)
	NITTradeLogDragFrame.tooltip:Hide();
end)
NITTradeLogDragFrame.tooltip:Hide();
NITTradeLogDragFrame:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent().isMoving) then
		self:GetParent().EditBox:ClearFocus();
		self:GetParent():StartMoving();
		self:GetParent().isMoving = true;
		--self:GetParent():SetUserPlaced(false);
	end
end)
NITTradeLogDragFrame:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)
NITTradeLogDragFrame:SetScript("OnHide", function(self)
	if (self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)

--Top right X close button.
local NITTradeLogFrameClose = CreateFrame("Button", "NITTradeLogFrameClose", NITTradeLogFrame, "UIPanelCloseButton");
NITTradeLogFrameClose:SetPoint("TOPRIGHT", -5, 8.6);
NITTradeLogFrameClose:SetWidth(31);
NITTradeLogFrameClose:SetHeight(31);
NITTradeLogFrameClose:SetScript("OnClick", function(self, arg)
	NITTradeLogFrame:Hide();
end)

--Reset button.
local NITTradeLogFrameResetButton = CreateFrame("Button", "NITTradeLogFrameResetButton", NITTradeLogFrameClose, "UIPanelButtonTemplate");
NITTradeLogFrameResetButton:SetPoint("CENTER", -100,0);
NITTradeLogFrameResetButton:SetWidth(90);
NITTradeLogFrameResetButton:SetHeight(17);
NITTradeLogFrameResetButton:SetText(L["Reset Data"]);
NITTradeLogFrameResetButton:SetNormalFontObject("GameFontNormalSmall");
NITTradeLogFrameResetButton:SetScript("OnClick", function(self, arg)
	NIT:resetTradeData();
end)

function NIT:openTradeLogFrame()
	NITTradeLogFrame.fs:SetFont(NIT.regionFont, 14);
	local header = NIT.prefixColor .. "NovaInstanceTracker v" .. version .. "|r\n"
			.. "|cffffff00Trade Log";
	NITTradeLogFrame.fs:SetText(header);
	if (NITTradeLogFrame:IsShown()) then
		NITTradeLogFrame:Hide();
	else
		NITTradeLogFrame:SetHeight(320);
		NITTradeLogFrame:SetWidth(580);
		local fontSize = false
		NITTradeLogFrame.EditBox:SetFont(NIT.regionFont, 13);
		NIT:recalcTradeLogFrame();
		NITTradeLogFrame.EditBox:SetWidth(NITTradeLogFrame:GetWidth() - 30);
		NITTradeLogFrame:Show();
		--Changing scroll position requires a slight delay.
		--Second delay is a backup.
		C_Timer.After(0.05, function()
			NITTradeLogFrame:SetVerticalScroll(0);
		end)
		C_Timer.After(0.3, function()
			NITTradeLogFrame:SetVerticalScroll(0);
		end)
		--So interface options and this frame will open on top of each other.
		if (InterfaceOptionsFrame:IsShown()) then
			NITTradeLogFrame:SetFrameStrata("DIALOG")
		else
			NITTradeLogFrame:SetFrameStrata("HIGH")
		end
	end
end

function NIT:recalcTradeLogFrame()
	NITTradeLogFrame.EditBox:SetText("\n\n\n");
	local count = 0;
	local found;
	for k, v in ipairs(NIT.data.trades) do
		count = count + 1;
		if (count > 100) then
			break;
		end
		local msg = "";
		local traded;
		local _, _, _, classColorHex = GetClassColor(v.tradeWhoClass);
		local time = NIT:getTimeFormat(v.time, true, true);
		local timeAgo = GetServerTime() - v.time;
		if (v.playerMoney > 0) then
			msg = msg .. "[|cFFDEDE42" .. time .. "|r] |cFF9CD6DEGave |r" .. NIT:getCoinString(v.playerMoney) .. "|r |cFF9CD6DEto |c"
					.. classColorHex .. v.tradeWho .. NIT.chatColor .. " |cFF9CD6DEin " .. v.where 
					.. " (" .. NIT:getTimeString(timeAgo, true) .. " ago\n"
			traded = true;
			found = true;
		end
		if (v.targetMoney > 0) then
			msg = msg .. "[|cFFDEDE42" .. time .. "|r] |cFF9CD6DEReceived |r" .. NIT:getCoinString(v.targetMoney) .. "|r |cFF9CD6DEfrom |c"
					.. classColorHex .. v.tradeWho .. NIT.chatColor .. " |cFF9CD6DEin " .. v.where 
					.. " (" .. NIT:getTimeString(timeAgo, true) .. " ago)\n"
			found = true;
		end
		--[[
		playerMoney = playerMoney,
		targetMoney = targetMoney,
		tradeWho = tradeWho,
		tradeWhoClass = tradeWhoClass,
		where = GetZoneText() or "",
		time = GetServerTime(),
		]]
		NITTradeLogFrame.EditBox:Insert(msg);
	end
	if (not found) then
		NITTradeLogFrame.EditBox:Insert("\n|cffffff00No trade logs found.");
	end
end

function NIT:resetTradeData()
	NIT.data.trades = {};
	NIT:print("Trade log data has been reset.");
	NIT:recalcTradeLogFrame();
end

---Rested Info---

function NIT:calcRested(currentXP, maxXP, time, resting, restedXP, online)
	local percent, bubbles, totalRestedXP = 0, 0, 0;
	if (online) then
		--Ignore timestamp and get rested stats from the API if character is online.
		if (UnitXP("player") > 0) then
			currentXP = UnitXP("player");
		end
		if (UnitXPMax("player") > 0) then
			maxXP = UnitXPMax("player");
		end
		if (GetXPExhaustion()) then
			restedXP = GetXPExhaustion();
		end
		local storedRested = (restedXP / maxXP) * 100;
		percent = NIT:round(storedRested, 2);
	else
		local percentPerSecond = 0;
		if (resting) then
			percentPerSecond = 0.00017361111;
		else
			percentPerSecond = 0.0000434027775;
		end
		local storedRested = (restedXP / maxXP) * 100;
		percent = (time * percentPerSecond) + storedRested;
		percent = NIT:round(percent, 2);
		if (percent > 150) then
			percent = 150;
		end
	end
	--Get xp amount in one bubble of current level.
	local bubbleXP = maxXP / 20;
	--Get how many bubbles fit into our current rested XP.
	bubbles = NIT:round(restedXP / bubbleXP, 1);
	--Get 1% of current levels xp required, times it by current % of rested.
	totalRestedXP = NIT:round((maxXP / 100) * percent);
	return percent, bubbles, totalRestedXP;
end

local NITAltsFrame = CreateFrame("ScrollFrame", "NITAltsFrame", UIParent, "InputScrollFrameTemplate");
local altsFrameWidth = 550;
NITAltsFrame:Hide();
NITAltsFrame:SetToplevel(true);
NITAltsFrame:SetMovable(true);
NITAltsFrame:EnableMouse(true);
tinsert(UISpecialFrames, "NITAltsFrame");
NITAltsFrame:SetPoint("CENTER", UIParent, 0, 100);
NITAltsFrame:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",insets = {top = 0, left = 0, bottom = 0, right = 0}});
NITAltsFrame:SetBackdropColor(0,0,0,.8);
NITAltsFrame.CharCount:Hide();
NITAltsFrame:SetFrameStrata("HIGH");
NITAltsFrame.EditBox:SetAutoFocus(false);
NITAltsFrame.EditBox:SetScript("OnKeyDown", function(self, arg)
	NITAltsFrame.EditBox:ClearFocus();
end)
NITAltsFrame.EditBox:SetScript("OnShow", function(self, arg)
	NITAltsFrame:SetVerticalScroll(0);
	NITAltsFrame:SetVerticalScroll(0);
end)
local altsFrameUpdateTime = 0;
NITAltsFrame:HookScript("OnUpdate", function(self, arg)
	NITAltsFrame.EditBox:ClearFocus();
	--Only update once per second.
	if (GetServerTime() - altsFrameUpdateTime > 0) then
		altsFrameUpdateTime = GetServerTime();
		NIT:recalcAltsLineFrames();
	end
end)
NITAltsFrame.fs = NITAltsFrame.EditBox:CreateFontString("NITAltsFrameFS", "HIGH");
NITAltsFrame.fs:SetPoint("TOP", 0, -0);
NITAltsFrame.fs:SetFont(NIT.regionFont, 14);

local NITAltsDragFrame = CreateFrame("Frame", "NITCharDragFrame", NITAltsFrame);
NITAltsDragFrame:SetToplevel(true);
NITAltsDragFrame:EnableMouse(true);
NITAltsDragFrame:SetWidth(205);
NITAltsDragFrame:SetHeight(38);
NITAltsDragFrame:SetPoint("TOP", 0, 4);
NITAltsDragFrame:SetFrameLevel(131);
NITAltsDragFrame.tooltip = CreateFrame("Frame", "NITAltsDragTooltip", NITAltsDragFrame, "TooltipBorderedFrameTemplate");
NITAltsDragFrame.tooltip:SetPoint("CENTER", NITAltsDragFrame, "TOP", 0, 12);
NITAltsDragFrame.tooltip:SetFrameStrata("TOOLTIP");
NITAltsDragFrame.tooltip:SetFrameLevel(9);
NITAltsDragFrame.tooltip:SetAlpha(.8);
NITAltsDragFrame.tooltip.fs = NITAltsDragFrame.tooltip:CreateFontString("NITAltsDragTooltipFS", "HIGH");
NITAltsDragFrame.tooltip.fs:SetPoint("CENTER", 0, 0.5);
NITAltsDragFrame.tooltip.fs:SetFont(NIT.regionFont, 12);
NITAltsDragFrame.tooltip.fs:SetText("Hold to drag");
NITAltsDragFrame.tooltip:SetWidth(NITAltsDragFrame.tooltip.fs:GetStringWidth() + 16);
NITAltsDragFrame.tooltip:SetHeight(NITAltsDragFrame.tooltip.fs:GetStringHeight() + 10);
NITAltsDragFrame:SetScript("OnEnter", function(self)
	NITAltsDragFrame.tooltip:Show();
end)
NITAltsDragFrame:SetScript("OnLeave", function(self)
	NITAltsDragFrame.tooltip:Hide();
end)
NITAltsDragFrame.tooltip:Hide();
NITAltsDragFrame:SetScript("OnMouseDown", function(self, button)
	if (button == "LeftButton" and not self:GetParent().isMoving) then
		self:GetParent().EditBox:ClearFocus();
		self:GetParent():StartMoving();
		self:GetParent().isMoving = true;
		--self:GetParent():SetUserPlaced(false);
	end
end)
NITAltsDragFrame:SetScript("OnMouseUp", function(self, button)
	if (button == "LeftButton" and self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)
NITAltsDragFrame:SetScript("OnHide", function(self)
	if (self:GetParent().isMoving) then
		self:GetParent():StopMovingOrSizing();
		self:GetParent().isMoving = false;
	end
end)

--Top right X close button.
local NITAltsFrameClose = CreateFrame("Button", "NITAltsFrameClose", NITAltsFrame, "UIPanelCloseButton");
NITAltsFrameClose:SetPoint("TOPRIGHT", -5, 8.6);
NITAltsFrameClose:SetWidth(31);
NITAltsFrameClose:SetHeight(31);
NITAltsFrameClose:SetScript("OnClick", function(self, arg)
	NITAltsFrame:Hide();
end)

function NIT:createAltsFrameCheckbox()
	if (NIT.altsFrameCheckbox) then
		return;
	end
	NIT.altsFrameCheckbox = CreateFrame("CheckButton", "NITAltsFrameCheckbox", NITAltsFrame.EditBox, "ChatConfigCheckButtonTemplate");
	NIT.altsFrameCheckbox:SetPoint("TOPLEFT", 5, -5);
	--So strange the way to set text is to append Text to the global frame name.
	NITAltsFrameCheckboxText:SetText("Show Rested Only");
	NIT.altsFrameCheckbox.tooltip = "Only show chars that have rested XP? Untick this to show all alts, even max level and alts with no rested.";
	NIT.altsFrameCheckbox:SetFrameStrata("HIGH");
	NIT.altsFrameCheckbox:SetFrameLevel(9);
	NIT.altsFrameCheckbox:SetWidth(24);
	NIT.altsFrameCheckbox:SetHeight(24);
	NIT.altsFrameCheckbox:SetChecked(NIT.db.global.restedCharsOnly);
	NIT.altsFrameCheckbox:SetScript("OnClick", function()
		local value = NIT.altsFrameCheckbox:GetChecked();
		NIT.db.global.restedCharsOnly = value;
		NIT:recalcAltsLineFrames();
		--Refresh the config page.
		NIT.acr:NotifyChange("NovaInstanceTracker");
	end)
end

function NIT:openAltsFrame()
	if (not NIT.altsFrameShowsAltsButton) then
		NIT:createAltsFrameCheckbox();
	end
	NITAltsFrame.fs:SetFont(NIT.regionFont, 14);
	local header = NIT.prefixColor .. "NovaInstanceTracker v" .. version .. "|r\n"
			.. "|cffffff00Alts (Mouseover names for info)";
	NITAltsFrame.fs:SetText(header);
	NIT:createAltsLineFrames(true);
	--Quick fix to re-set the region font since the frames are created before we set region font.
	NITAltsFrame.fs:SetFont(NIT.regionFont, 14);
	if (NITAltsFrame:IsShown()) then
		NITAltsFrame:Hide();
	else
		NITAltsFrame:SetHeight(320);
		NITAltsFrame:SetWidth(altsFrameWidth);
		local fontSize = false;
		NITAltsFrame.EditBox:SetFont(NIT.regionFont, 14);
		NITAltsFrame.EditBox:SetWidth(NITAltsFrame:GetWidth() - 30);
		NITAltsFrame:Show();
		--Changing scroll position requires a slight delay.
		--Second delay is a backup.
		C_Timer.After(0.05, function()
			NITAltsFrame:SetVerticalScroll(0);
		end)
		C_Timer.After(0.3, function()
			NITAltsFrame:SetVerticalScroll(0);
		end)
		--So interface options and this frame will open on top of each other.
		if (InterfaceOptionsFrame:IsShown()) then
			NITAltsFrame:SetFrameStrata("DIALOG");
		else
			NITAltsFrame:SetFrameStrata("HIGH");
		end
		NIT:recalcAltsLineFrames();
	end
end

local totalAltLines = 0;
function NIT:createAltsLineFrames(skipRecalc)
	local count = 0;
	local new;
	--Create enough line frames for each realm + character.
	for k, v in NIT:pairsByKeys(NIT.db.global) do --Iterate realms.
		if (type(v) == "table" and k ~= "minimapIcon" and k ~= "data") then
			count = count + 1;
			if (not _G[k .. "NITAltsLine"]) then
				NIT:createAltsLineFrame(count, v, count);
				new = true;
			end
			if (v.myChars) then
				for k, v in NIT:pairsByKeys(v.myChars) do --Iterate characters.
					count = count + 1;
					if (not _G[k .. "NITAltsLine"]) then
						NIT:createAltsLineFrame(count, v, count);
						new = true;
					end
				end
			end
		end
	end
	if (count > totalAltLines) then
		totalAltLines = count;
	end
	if (new and not skipRecalc) then
		NIT:recalcAltsLineFrames();
	end
end

function NIT:createAltsLineFrame(type, data, count)
	if (not _G[type .. "NITAltsLine"]) then
		local obj = CreateFrame("Frame", type .. "NITAltsLine", NITAltsFrame.EditBox);
		obj.name = data.name;
		obj.count = count;
		local bg = obj:CreateTexture(nil, "HIGH");
		bg:SetAllPoints(obj);
		obj.texture = bg;
		obj.fs = obj:CreateFontString(type .. "NITAltsLineFS", "ARTWORK");
		obj.fs:SetPoint("LEFT", 0, 0);
		obj.fs:SetFont(NIT.regionFont, 14);
		--They don't quite line up properly without justify on top of set point left.
		obj.fs:SetJustifyH("LEFT");
		obj.tooltip = CreateFrame("Frame", type .. "NITAltsLineTooltip", NITAltsFrame, "TooltipBorderedFrameTemplate");
		obj.tooltip:SetPoint("CENTER", obj, "CENTER", 0, -46);
		obj.tooltip:SetFrameStrata("HIGH");
		obj.tooltip:SetFrameLevel(4);
		obj.tooltip.fs = obj.tooltip:CreateFontString(type .. "NITAltsLineTooltipFS", "ARTWORK");
		obj.tooltip.fs:SetPoint("CENTER", 0, 0);
		obj.tooltip.fs:SetFont(NIT.regionFont, 13);
		obj.tooltip.fs:SetJustifyH("LEFT");
		obj.tooltip.fs:SetText("|CffDEDE42Error " .. count);
		obj.tooltip.fsCalc = obj.tooltip:CreateFontString(type .. "NITAltsLineTooltipFS", "ARTWORK");
		obj.tooltip.fsCalc:SetFont(NIT.regionFont, 13);
		obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
		obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
		obj.tooltip:SetScript("OnUpdate", function(self)
			--Keep our custom tooltip at the mouse when it moves.
			local scale, x, y = obj.tooltip:GetEffectiveScale(), GetCursorPosition();
			obj.tooltip:SetPoint("RIGHT", nil, "BOTTOMLEFT", (x / scale) - 2, y / scale);
		end)
		obj:SetScript("OnEnter", function(self)
			obj.tooltip:Show();
			NIT:recalcAltsLineFramesTooltip(obj);
			local scale, x, y = obj.tooltip:GetEffectiveScale(), GetCursorPosition();
			obj.tooltip:SetPoint("CENTER", nil, "BOTTOMLEFT", x / scale, y / scale);
		end)
		obj:SetScript("OnLeave", function(self)
			obj.tooltip:Hide();
		end)
		obj.tooltip:Hide();
		--obj:SetScript("OnMouseDown", function(self)
			--Maybe add a mouse event here later.
		--end)
		
		obj.removeButton = CreateFrame("Button", type .. "NITAltsLineRB", obj, "UIPanelButtonTemplate");
		obj.removeButton:SetPoint("LEFT", obj, "RIGHT", 34, 0);
		obj.removeButton:SetWidth(13);
		obj.removeButton:SetHeight(13);
		--obj.removeButton:SetText("X");
		obj.removeButton:SetNormalFontObject("GameFontNormalSmall");
		--obj.removeButton:SetScript("OnClick", function(self, arg)

		--end)
		obj.removeButton:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_7");
		obj.removeButton.tooltip = CreateFrame("Frame", type .. "NITAltsLineTooltipRB", NITAltsFrame, "TooltipBorderedFrameTemplate");
		obj.removeButton.tooltip:SetPoint("RIGHT", obj.removeButton, "LEFT", -5, 0);
		obj.removeButton.tooltip:SetFrameStrata("HIGH");
		obj.removeButton.tooltip:SetFrameLevel(3);
		obj.removeButton.tooltip.fs = obj.removeButton.tooltip:CreateFontString(type .. "NITAltsLineTooltipRBFS", "ARTWORK");
		obj.removeButton.tooltip.fs:SetPoint("CENTER", -0, 0);
		obj.removeButton.tooltip.fs:SetFont(NIT.regionFont, 13);
		obj.removeButton.tooltip.fs:SetJustifyH("LEFT");
		obj.removeButton.tooltip.fs:SetText("|CffDEDE42Delete entry " .. count);
		obj.removeButton.tooltip:SetWidth(obj.removeButton.tooltip.fs:GetStringWidth() + 18);
		obj.removeButton.tooltip:SetHeight(obj.removeButton.tooltip.fs:GetStringHeight() + 12);
		obj.removeButton:SetScript("OnEnter", function(self)
			obj.removeButton.tooltip:Show();
		end)
		obj.removeButton:SetScript("OnLeave", function(self)
			obj.removeButton.tooltip:Hide();
		end)
		obj.removeButton.tooltip:Hide();
	end
end

function NIT:recalcAltsLineFrames()
	if (not NITAltsFrame:IsShown()) then
		return;
	end
	local offset, count = 45, 0;
	local framesUsed = {};
	local foundAnyChars;
	local color1, color2 = "|cFFFFAE42", "|cFF9CD6DE";
	for k, v in NIT:pairsByKeys(NIT.db.global) do --Iterate realms.
		local msg = "";
		if (type(v) == "table" and k ~= "minimapIcon" and k ~= "data") then
			local coloredFaction = "";
			local realmString = "|cff00ff00[" .. k .. "]|r";
			local realmName = k;
			local printedRealm;
			local realmObj;
			if (v.myChars) then
				local realmGold = 0;
				local realmGoldData = {};
				realmGoldData.realm = realmName;
				for k, v in pairs(v.myChars) do
					if (v.gold) then
						realmGold = realmGold + v.gold;
					end
				end
				local foundRested;
				for k, v in NIT:pairsByKeys(v.myChars) do --Iterate characters.
					--Add the key (playername) to the data passed to the tooltip and delete button.
					v.playerName = k;
					realmGoldData[k] = {
						gold = (v.gold or 0),
						classEnglish = v.classEnglish,
					}
					foundRested = nil;
					local _, _, _, classColor = GetClassColor(v.classEnglish);
					local msg = "  -|c" .. classColor .. k .. "|r";
					local online;
					local stateString = "";
					local onlineString = "";
					if (k == UnitName("player")) then
						online = true;
						onlineString = " |cFF00C800(Online)|r";
					end
					if (v.level == NIT.maxLevel) then
						stateString = "(Max level)";
						msg = msg .. " " .. color1 .. "Level:|r " .. color2 .. v.level .. onlineString .. "\n";
					elseif (v.time and v.time > 0 and v.currentXP and v.maxXP) then
						local timeOffline = GetServerTime() - v.time;
						local percent, bubbles, xp = NIT:calcRested(v.currentXP, v.maxXP, timeOffline, v.resting, v.restedXP, online);
						--if (percent > 0) then
							local percentString = percent .. "%";
							local stateString = "(Rested)"
							if (percent == 150) then
								percentString = percentString .. " (Max)";
							end
							local xpString = color2 .. NIT:commaValue(v.currentXP) .. color1 .. "/" .. color2 .. NIT:commaValue(v.maxXP);
							msg = msg .. " " .. color1 .. "Level:|r " .. color2 .. v.level .. "|r " .. color1 .. "XP:|r " .. color2
									.. xpString .. " " .. color1 .. "Rested:|r " .. color2 .. percentString .. onlineString .. "\n";
						--end
						foundRested = true;
					end
					if (not NIT.db.global.restedCharsOnly or foundRested) then
						--Add realm line if we found chars for this realm and have not printed realm line yet.
						if (not printedRealm) then
							count = count + 1;
							printedRealm = true;
							framesUsed[count] = true;
							_G[count .. "NITAltsLine"]:Show();
							_G[count .. "NITAltsLine"]:ClearAllPoints();
							_G[count .. "NITAltsLine"]:SetPoint("LEFT", NITAltsFrame.EditBox, "TOPLEFT", 3, -offset);
							offset = offset + 14;
							_G[count .. "NITAltsLine"].fs:SetPoint("LEFT", 0, 0);
							--_G[count .. "NITAltsLine"].fs:SetText(realmString .. " |cFF9CD6DE"
							--		..  GetCoinTextureString(realmGold, 11) .. "|r");
							_G[count .. "NITAltsLine"].fs:SetText(realmString);
							--Leave enough room on the right of frame to not overlap the scroll bar (-20) and remove button (-20).
							_G[count .. "NITAltsLine"]:SetWidth(NITAltsFrame:GetWidth() - 120);
							_G[count .. "NITAltsLine"]:SetHeight(_G[count .. "NITAltsLine"].fs:GetHeight());
							--_G[count .. "NITAltsLine"].removeButton.count = count;
							_G[count .. "NITAltsLine"].removeButton:Hide();
							_G[count .. "NITAltsLine"].removeButton.tooltip.fs:SetText("Disabled");
							_G[count .. "NITAltsLine"].removeButton.tooltip:SetWidth(_G[count .. "NITAltsLine"].removeButton.tooltip.fs:GetStringWidth() + 18);
							_G[count .. "NITAltsLine"].removeButton.tooltip:SetHeight(_G[count .. "NITAltsLine"].removeButton.tooltip.fs:GetStringHeight() + 12);
							_G[count .. "NITAltsLine"].data = nil;
							_G[count .. "NITAltsLine"].type = "realm";
							realmObj = _G[count .. "NITAltsLine"];
						end
						--Add the char line.
						count = count + 1;
						framesUsed[count] = true;
						_G[count .. "NITAltsLine"]:Show();
						_G[count .. "NITAltsLine"]:ClearAllPoints();
						_G[count .. "NITAltsLine"]:SetPoint("LEFT", NITAltsFrame.EditBox, "TOPLEFT", 3, -offset);
						offset = offset + 14;
						_G[count .. "NITAltsLine"].fs:SetPoint("LEFT", 0, 0);
						_G[count .. "NITAltsLine"].fs:SetText(msg);
						--Leave enough room on the right of frame to not overlap the scroll bar (-20) and remove button (-20).
						_G[count .. "NITAltsLine"]:SetWidth(NITAltsFrame:GetWidth() - 120);
						_G[count .. "NITAltsLine"]:SetHeight(_G[count .. "NITAltsLine"].fs:GetHeight());
						--_G[count .. "NITAltsLine"].removeButton.count = count;
						_G[count .. "NITAltsLine"].removeButton.tooltip.fs:SetText("|CffDEDE42Delete " .. k);
						_G[count .. "NITAltsLine"].removeButton:Show();
						_G[count .. "NITAltsLine"].removeButton.tooltip:SetWidth(_G[count .. "NITAltsLine"].removeButton.tooltip.fs:GetStringWidth() + 18);
						_G[count .. "NITAltsLine"].removeButton.tooltip:SetHeight(_G[count .. "NITAltsLine"].removeButton.tooltip.fs:GetStringHeight() + 12);
						_G[count .. "NITAltsLine"].data = v;
						_G[count .. "NITAltsLine"].type = "char";
						_G[count .. "NITAltsLine"].removeButton:SetScript("OnClick", function(self, arg)
							--Open delete confirmation box to delete table id (k), but display it as matching log number (count).
							NIT:openDeleteCharConfirmFrame(realmName, k);
						end)
						foundAnyChars = true;
					end
				end
				if (realmObj) then
					realmObj.data = realmGoldData;
				end
			end
		end
	end
	if (not foundAnyChars) then
		NIT:hideAllAltLineFrames()
		NITAltsFrame.EditBox:Insert("\n\n\n\n|cffffff00No alts found.");
	else
		NITAltsFrame.EditBox:SetText("");
	end
	--Hide any no longer is use lines frames no longer in use.
	for i = 1, totalAltLines do
		if (_G[i .. "NITAltsLine"] and not framesUsed[i]) then
			_G[i .. "NITAltsLine"]:Hide();
			_G[i .. "NITAltsLine"].data = nil;
		end
	end
end

function NIT:hideAllAltLineFrames()
	for i = 1, totalAltLines do
		if (_G[i .. "NITAltsLine"]) then
			_G[i .. "NITAltsLine"]:Hide();
		end
	end
end

function NIT:recalcAltsLineFramesTooltip(obj)
	local data = obj.data;
	--NIT:debug(data)
	if (data) then
		if (obj.type == "realm") then
			local text = "|cFFFFAE42Realm gold for |cff00ff00[" .. data.realm .. "]|r";
			local total = 0;
			for k, v in NIT:pairsByKeys(data) do
				if (v.gold) then
					local _, _, _, classColor = GetClassColor(v.classEnglish);
					total = total + v.gold;
					local line = "\n|c" .. classColor .. k .. "|r";
					obj.tooltip.fsCalc:SetText(line);
					--Trim string if multiple columns.
					while obj.tooltip.fsCalc:GetWidth() > 80 do
						line = string.sub(line, 1, -2);
						obj.tooltip.fsCalc:SetText(line);
					end
					obj.tooltip.fsCalc:SetText(line);
					while obj.tooltip.fsCalc:GetWidth() < 90 do
						line = line .. " ";
						obj.tooltip.fsCalc:SetText(line);
					end
					text = text .. line .. " " .. GetCoinTextureString(v.gold, 10);
					--text = text .. "\n|c" .. classColor .. k .. "|r " .. GetCoinTextureString(v.gold, 10);
				end
			end
			local line = "\n\n|cFFFFAE42Total: |r";
			obj.tooltip.fsCalc:SetText(line);
			while obj.tooltip.fsCalc:GetWidth() < 90 do
				line = line .. " ";
				obj.tooltip.fsCalc:SetText(line);
			end
			line = line .. " " .. GetCoinTextureString(total, 10);
			obj.tooltip.fs:SetText(text .. line);
		else
			local color1, color2 = "|cFFFFAE42", "|cFF9CD6DE";
			local player = data.playerName;
			local _, _, _, classColorHex = GetClassColor(data.classEnglish);
			local online;
			if (player == UnitName("player")) then
				online = true;
			end
			local timeOffline;
			if (data.time) then
				timeOffline = GetServerTime() - data.time;
			end
			local text = "";
			--Some of the data exists checks are here to be compatible with older versions that didn't record some data.
			if (data.realm) then
				text = "|c" .. classColorHex .. player .. "|r |cff00ff00[" .. data.realm .. "]|r";
			else
				text = "|c" .. classColorHex .. player .. "|r";
			end
			text = text .. "\n" .. color1 .. "Guild: " .. color2 .. (data.guild or "none");
			text = text .. "\n" .. color1 .. "Level:|r " .. color2 .. data.level;
			if (timeOffline and data.level < NIT.maxLevel) then
				local percent, bubbles, xp = NIT:calcRested(data.currentXP, data.maxXP, timeOffline, data.resting, data.restedXP, online);
				if (data.currentXP) then
					local percentXP;
					if (data.currentXP == 0 and data.maxXP == 0) then
						percentXP = 0;
					else
						percentXP = (data.currentXP / data.maxXP) * 100;
					end
					text = text .. "\n" .. color1 .. "XP:|r " .. color2 .. NIT:commaValue(data.currentXP) .. color1 .. "/"
							.. color2 .. NIT:commaValue(data.maxXP) .. " (" .. NIT:round(percentXP) .. "%)";
				end
				if (data.restedXP) then
					local percentString = percent .. "\%";
					--local stateString = "(|cFFFF2222Not Resting" .. color2 .. ")|r";
					local stateString = "(Not Resting)|r";
					if (data.resting) then
						stateString = "(|cFF00C800Resting" .. color2 .. ")|r";
					end
					local percentMax = "";
					if (percent == 150) then
						percentMax = " (Max)";
					end
					text = text .. "\n" .. color1 .. "Rested:|r " .. color2 .. percentString .. " (" .. NIT:commaValue(data.restedXP) .. "xp)" .. percentMax;
					text = text .. "\n" .. color1 .. "Rested Bubbles:|r " .. color2 .. bubbles;
					text = text .. "\n" .. color1 .. "Rested State:|r " .. color2 .. stateString;
				end
			end
			if (data.freeBagSlots and data.totalBagSlots) then
				local displayFreeSlots = color2 .. data.freeBagSlots .. "|r";
				if (data.freeBagSlots < (data.totalBagSlots * 0.10)) then
					--Display in red when less than 10% of bag space left.
					displayFreeSlots = "|cffff0000" .. data.freeBagSlots .. "|r";
				end
				text = text .. "\n" .. color1 .. "Bag slots:|r " .. displayFreeSlots .. color1 .. "/" .. color2 .. data.totalBagSlots;
			end
			if (data.gold) then
				text = text .. "\n" .. color1 .. "Gold:|r " .. color2 .. GetCoinTextureString(data.gold, 10);
			end
			local durabilityAverage = data.durabilityAverage or 100;
			local displayDurability;
			if (durabilityAverage < 10) then
				displayDurability = "|cffff0000" .. NIT:round(durabilityAverage) .. "%|r";
			elseif (durabilityAverage < 30) then
				displayDurability = "|cffffa500" .. NIT:round(durabilityAverage) .. "%|r";
			else
				displayDurability = color2 .. NIT:round(durabilityAverage) .. "%|r";
			end
			text = text .. "\n" .. color1 .. "Durability: " .. displayDurability;
			
			if (data.classEnglish == "PRIEST" or data.classEnglish == "MAGE" or data.classEnglish == "DRUID"
					or data.classEnglish == "WARLOCK" or data.classEnglish == "SHAMAN" or data.classEnglish == "PALADIN"
							or data.classEnglish == "HUNTER") then
				local foundItems;
				local itemString = "\n\n|cFFFFFF00Items|r";
				if (data.classEnglish == "HUNTER" and data.ammo) then
					local ammoTypeString = "";
					if (data.ammoType) then
						local itemName, _, itemRarity, _, _, _, _, _, _, itemTexture = GetItemInfo(data.ammoType);
		    			if (itemName) then
		    				local ammoTexture = "|T" .. itemTexture .. ":12:12:0:0|t";
							ammoTypeString = " (" .. itemName .. " " .. ammoTexture .. ")";
						end
					end
					itemString = itemString .. "\n  |c" .. classColorHex .. "Ammo:|r " .. color2 .. (data.ammo or 0) .. ammoTypeString;
					foundItems = true;
				end
				if (_G["NIT"]["trackItems" .. data.classEnglish]) then
					for k, v in ipairs(_G["NIT"]["trackItems" .. data.classEnglish]) do
						if (not v.minLvl or v.minLvl < data.level) then
							local texture = "";
							if (v.texture) then
								texture = "|T" .. v.texture .. ":12:12:0:0|t ";
							end
							itemString = itemString .. "\n  " .. texture .. "|c" .. classColorHex .. v.name .. ":|r " .. color2 .. (data[v.id] or 0);
							foundItems = true;
						end
					end
				end
				if (foundItems) then
					text = text .. itemString;
				end
			end
			if (data.classEnglish == "HUNTER") then
				local happinessTexture = "";
				if (data.petHappiness and data.petHappiness == 1) then
					happinessTexture = "|TInterface\\PetPaperDollFrame\\UI-PetHappiness:13:13:0:0:128:64:48:72:0:23|t";
					--SetTexCoord(0.375, 0.5625, 0, 0.359375);
				elseif (data.petHappiness and data.petHappiness == 2) then
					--happinessTexture = "|TInterface\\PetPaperDollFrame\\UI-PetHappiness:13:13:0:0:128:64:0.1875:0.375:0:0.359375|t";
					happinessTexture = "|TInterface\\PetPaperDollFrame\\UI-PetHappiness:13:13:0:0:128:64:24:46.5:0:23|t";
					--SetTexCoord(0.1875, 0.375, 0, 0.359375);
				elseif (data.petHappiness and data.petHappiness == 3) then
					--happinessTexture = "|TInterface\\PetPaperDollFrame\\UI-PetHappiness:13:13:0:0:0:128:64:0.1875:0:0.359375|t";
					happinessTexture = "|TInterface\\PetPaperDollFrame\\UI-PetHappiness:13:13:0:0:0:128:64:0:24:0:23|t";
					--SetTexCoord(0, 0.1875, 0, 0.359375);
				end
				text = text .. "\n\n|cFFFFFF00Current Pet|r";
				if (data.isPetDead and data.hasPet) then
					text = text .. "\n" .. color1 .. "  Pet Status:|r (|cFFFF2222Dead" .. color2 .. ")";
				elseif (data.hasPet) then
					text = text .. "\n" .. color1 .. "  Pet Status:|r (|cFF00C800Alive" .. color2 .. ")";
				else
					text = text .. "\n" .. color1 .. "  Pet Status:|r " .. color2 .. "(No Pet Summoned)";
					text = text ..	"\n  |cFF989898Last seen pet details:|r";
				end
				if (data.petName) then
					text = text .. "\n" .. color1 .. "  Name:|r " .. color2 .. data.petName;
				end
				if (data.petLevel) then
					text = text .. "\n" .. color1 .. "  Level:|r " .. color2 .. data.petLevel;
				end
				if (data.petFamily) then
					text = text .. "\n" .. color1 .. "  Family:|r " .. color2 .. data.petFamily;
				end
				if (data.petHappiness) then
					text = text .. "\n" .. color1 .. "  Happiness:|r " .. happinessTexture;
				end
				if (data.petLoyaltyRate) then
					text = text .. "\n" .. color1 .. "  Loyalty rate:|r " .. color2 .. data.petLoyaltyRate;
				end
				if (data.loyaltyString) then
					text = text .. "\n  " .. color1 .. data.loyaltyString;
				end
				if (data.petCurrentXP and data.petMaxXP) then
					local percentXP;
					if (data.petCurrentXP == 0 and data.petMaxXP == 0) then
						percentXP = 0;
					else
						percentXP = (data.petCurrentXP / data.petMaxXP) * 100;
					end
					text = text .. "\n" .. color1 .. "  Pet XP:|r " .. color2 .. data.petCurrentXP .. color1 .. "/" .. color2 
							.. data.petMaxXP .. " (" .. NIT:round(percentXP) .. "%)";
				end
				if (data.totalPetPoints and data.spentPetPoints) then
					local unspentPetPoints = data.totalPetPoints - data.spentPetPoints;
					if (unspentPetPoints < 0) then
						unspentPetPoints = 0;
					end
					text = text .. "\n" .. color1 .. "  Unspent Training points:|r " .. color2 .. unspentPetPoints;
				end
			end
			text = text .. "\n\n|cFFFFFF00Professions|r";
			local foundprofs;
			if (data.prof1 and data.prof1 ~= "none") then
				text = text .. "\n  " .. color1 .. data.prof1 .. ": " .. color2 .. data.profSkill1 .. color1 .. "/" .. color2 .. data.profSkillMax1;
				foundprofs = true;
			end
			if (data.prof2 and data.prof2 ~= "none") then
				text = text .. "\n  " .. color1 .. data.prof2 .. ": " .. color2 .. data.profSkill2 .. color1 .. "/" .. color2 .. data.profSkillMax2;
				foundprofs = true;
			end
			if (data.firstaidSkill and data.firstaidSkill > 0) then
				text = text .. "\n  " .. color1 .. "First Aid: " .. color2 .. data.firstaidSkill .. color1 .. "/" .. color2 .. data.firstaidSkillMax;
				foundprofs = true;
			end
			if (data.fishingSkill and data.fishingSkill > 0) then
				text = text .. "\n  " .. color1 .. "Fishing: " .. color2 .. data.fishingSkill .. color1 .. "/" .. color2 .. data.fishingSkillMax;
				foundprofs = true;
			end
			if (data.cookingSkill and data.cookingSkill > 0) then
				text = text .. "\n  " .. color1 .. "Cooking: " .. color2 .. data.cookingSkill .. color1 .. "/" .. color2 .. data.cookingSkillMax;
				foundprofs = true;
			end
			if (not foundprofs) then
				text = text .. "\n  " .. color2 .. "No professions found.";
			end
			local attunements = "\n\n|cFFFFFF00Attunements|r";
			local foundAttune;
			if (data.mcAttune) then
				attunements = attunements .. "\n  " .. color1 .. "Molten Core";
				foundAttune = true;
			end
			if (data.onyAttune) then
				attunements = attunements .. "\n  " .. color1 .. "Onyxia's Lair";
				foundAttune = true;
			end
			if (data.bwlAttune) then
				attunements = attunements .. "\n  " .. color1 .. "Blackwing Lair";
				foundAttune = true;
			end
			if (data.naxxAttune) then
				attunements = attunements .. "\n  " .. color1 .. "Naxxramas";
				foundAttune = true;
			end
			if (foundAttune) then
				text = text .. attunements;
			end
			
			text = text .. "\n\n|cFFFFFF00Current Raid Lockouts|r";
			local foundLockout;
			local lockoutString = "";
			if (data.savedInstances and next(data.savedInstances)) then
				for k, v in NIT:pairsByKeys(data.savedInstances) do
					if (v.locked and v.resetTime and v.resetTime > GetServerTime()) then
						local timeString = "(" .. NIT:getTimeString(v.resetTime - GetServerTime(), true, NIT.db.global.timeStringType) .. " left)";
						lockoutString = lockoutString .. "\n  " .. color1 .. v.name .. " " .. color2 .. timeString;
						foundLockout = true;
					end
				end
			end
			if (not foundLockout) then
				text = text .. "\n  " .. color2 .. "None.";
			else
				text = text .. lockoutString;
			end
			obj.tooltip.fs:SetText(text);
		end
	else
		obj.tooltip.fs:SetText("|CffDEDE42No data found for this character.");
	end
	obj.tooltip:SetWidth(obj.tooltip.fs:GetStringWidth() + 18);
	obj.tooltip:SetHeight(obj.tooltip.fs:GetStringHeight() + 12);
end

local NITCharsFrameDeleteConfirm = CreateFrame("ScrollFrame", "NITCharsFrameDC", UIParent, "InputScrollFrameTemplate");
NITCharsFrameDeleteConfirm:Hide();
NITCharsFrameDeleteConfirm:SetToplevel(true);
NITCharsFrameDeleteConfirm:SetHeight(130);
NITCharsFrameDeleteConfirm:SetWidth(250);
tinsert(UISpecialFrames, "NITCharsFrameDeleteConfirm");
NITCharsFrameDeleteConfirm:SetPoint("CENTER", UIParent, 0, 200);
NITCharsFrameDeleteConfirm:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8",insets = {top = 0, left = 0, bottom = 0, right = 0}});
NITCharsFrameDeleteConfirm:SetBackdropColor(0,0,0,1);
NITCharsFrameDeleteConfirm.CharCount:Hide();
NITCharsFrameDeleteConfirm:SetFrameStrata("HIGH");
NITCharsFrameDeleteConfirm.EditBox:SetAutoFocus(false);
NITCharsFrameDeleteConfirm.EditBox:EnableMouse(false);
NITCharsFrameDeleteConfirm.EditBox:SetScript("OnKeyDown", function(self, arg)
	NITCharsFrameDeleteConfirm.EditBox:ClearFocus();
end)
NITCharsFrameDeleteConfirm.EditBox:SetScript("OnUpdate", function(self, arg)
	--This is a hack so the editbox never gets focus and I can use the same frame template minus the editbox.
	NITCharsFrameDeleteConfirm.EditBox:ClearFocus();
end)
NITCharsFrameDeleteConfirm.EditBox:SetScript("OnHide", function(self, arg)
	--Clear the instance deletion that was set.
	NITCharsFrameDCDelete:SetScript("OnClick", function(self, arg) end);
end)

NITCharsFrameDeleteConfirm.fs = NITCharsFrameDeleteConfirm:CreateFontString("NITCharsFrameFS", "HIGH");
NITCharsFrameDeleteConfirm.fs:SetPoint("TOP", 0, -4);
NITCharsFrameDeleteConfirm.fs:SetFont(NIT.regionFont, 14);
NITCharsFrameDeleteConfirm.fs:SetText("Character data missing");

--Delete button.
local NITCharsFrameDCDelete = CreateFrame("Button", "NITCharsFrameDCDelete", NITCharsFrameDeleteConfirm, "UIPanelButtonTemplate");
NITCharsFrameDCDelete:SetPoint("CENTER", 0, -40);
NITCharsFrameDCDelete:SetWidth(120);
NITCharsFrameDCDelete:SetHeight(30);
--NITCharsFrameDCDelete:SetText(L["confirmDelete"]);
NITCharsFrameDCDelete:SetText(L["delete"]);
NITCharsFrameDCDelete:SetNormalFontObject("GameFontNormal");

--Top right X close button.
local NITCharsDCFrameClose = CreateFrame("Button", "NITCharsDCFrameClose", NITCharsFrameDeleteConfirm, "UIPanelCloseButton");
NITCharsDCFrameClose:SetPoint("TOPRIGHT", 10, 10);
NITCharsDCFrameClose:SetWidth(36);
NITCharsDCFrameClose:SetHeight(36);
NITCharsDCFrameClose:SetScript("OnClick", function(self, arg)
	NITCharsFrameDeleteConfirm:Hide();
end)

--Open delete confirmation box.
--If displayNum is provided then we display it as the matching number in the instance log.
--But we still delete the right table id number.
local deleteCharLast;
function NIT:openDeleteCharConfirmFrame(realm, char)
	--Close window if we click delete button for same item again, but open new one if different item is clicked.
	if (NITCharsFrameDeleteConfirm:IsShown() and realm .. " " .. char == deleteCharLast) then
		NITCharsFrameDeleteConfirm:Hide();
	else
		NITCharsFrameDeleteConfirm:Hide();
		local data = NIT.db.global[realm].myChars[char];
		if (data) then
			local _, _, _, classColorHex = GetClassColor(data.classEnglish);
			local text = NIT.prefixColor .. L["confirmCharacterDeletion"] .. "|r\n";
			text = text .. "\n\n|cff00ff00[" .. realm .. "]";
			text = text .. "\n\|c" .. classColorHex ..char;
			NITCharsFrameDeleteConfirm.fs:SetText(text);
			NITCharsFrameDCDelete:Show();
			NITCharsFrameDCDelete:SetScript("OnClick", function(self, arg)
				NIT:deleteCharacter(realm, char);
				NITCharsFrameDeleteConfirm:Hide();
			end)
		else
			NITCharsFrameDeleteConfirm.fs:SetText("Error: Character data missing");
			--NITCharsFrameDCDelete:SetText(L["Error"]);
			NITCharsFrameDCDelete:Hide();
		end
		NITCharsFrameDeleteConfirm:Show();
	end
	deleteCharLast = realm .. " " .. char;
end