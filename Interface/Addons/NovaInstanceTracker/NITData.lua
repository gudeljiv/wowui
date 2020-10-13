------------------------------
---NovaInstanceTracker data---
------------------------------

local L = LibStub("AceLocale-3.0"):GetLocale("NovaInstanceTracker");
local version = GetAddOnMetadata("NovaInstanceTracker", "Version") or 9999;

--Some of this addon comm stuff is copied from my other addon NovaWorldBuffs and is left here incase of future stuff being added.
function NIT:OnCommReceived(commPrefix, string, distribution, sender)
	--if (NIT.isDebug) then
	--	return;
	--end
	--AceComm doesn't supply realm name if it's on the same realm as player.
	--Not sure if it provives GetRealmName() or GetNormalizedRealmName() for crossrealm.
	--For now we'll check all 3 name types just to be sure until tested.
	local me = UnitName("player") .. "-" .. GetRealmName();
	local meNormalized = UnitName("player") .. "-" .. GetNormalizedRealmName();
	if (sender == UnitName("player") or sender == me or sender == meNormalized) then
		NIT.hasAddon[meNormalized] = tostring(version);
		return;
	end
	local _, realm = strsplit("-", sender, 2);
	--If realm found then it's not my realm, but just incase acecomm changes and starts supplying realm also check if realm exists.
	if (realm ~= nil or (realm and realm ~= GetRealmName() and realm ~= GetNormalizedRealmName())) then
		--Ignore data from other realms (in bgs).
		return;
	end
	--If no realm in name it must be our realm so add it.
	if (not string.match(sender, "-")) then
		--Add normalized realm since roster checks use this.
		sender = sender .. "-" .. GetNormalizedRealmName();
	end
	local decoded;
	if (distribution == "YELL" or distribution == "SAY") then
		decoded = NIT.libDeflate:DecodeForWoWChatChannel(string);
	else
		decoded = NIT.libDeflate:DecodeForWoWAddonChannel(string);
	end
	if (not decoded) then
		NIT:debug("Incomming data decode failure");
		return;
	end
	local decompressed = NIT.libDeflate:DecompressDeflate(decoded);
	local deserializeResult, deserialized = NIT.serializer:Deserialize(decompressed);
	if (not deserializeResult) then
		NIT:debug("Error deserializing:", distribution);
		return;
	end
	local args = NIT:explode(" ", deserialized, 2);
	local cmd = args[1]; --Cmd (first arg) so we know where to send the data.
	local remoteVersion = args[2]; --Version number.
	local data = args[3]; --Data (everything after version arg).
	--if (data == nil and cmd ~= "ping") then
		--Temp fix for people with old version data structure sending incompatable data.
		--Only effects a few of the early testers.
	--	data = args[2]; --Data (everything after version arg).
	--	remoteVersion = "0";
	--end
	NIT.hasAddon[sender] = remoteVersion or "0";
	if (not tonumber(remoteVersion)) then
		--Trying to catch a lua error and find out why.
		NIT:debug("version missing", sender, cmd, data);
		return;
	end
	--Ignore data syncing for some recently out of date versions.
	if (tonumber(remoteVersion) < 1.00) then
		return;
	end
	if (cmd == "instanceReset") then
		--Instance reset.
		NIT:instanceResetComm(data, sender, distribution);
	elseif (cmd == "instanceResetNoMsg") then
		--Instance reset from someone with group msg disabled.
		NIT:instanceResetNoMsgComm(data, sender, distribution);
	elseif (cmd == "instanceResetOther") then
		--Instance reset from NWB user.
		NIT:instanceResetOtherComm(data, sender, distribution);
	end
	NIT:versionCheck(remoteVersion);
end

--Send to specified addon channel.
function NIT:sendComm(distribution, string, target)
	--if (NIT.isDebug) then
	--	return;
	--end
	--NIT:debug("Comms:", distribution, string);
	if (target == UnitName("player")) then
		return;
	end
	if (distribution == "GUILD" and not IsInGuild()) then
		return;
	end
	if (UnitInBattleground("player") and distribution ~= "GUILD") then
		return;
	end
	if (distribution == "CHANNEL") then
		--Get channel ID number.
		local addonChannelId = GetChannelName(target);
		--Not sure why this only accepts a string and not an int.
		--Addon channels are disabled in classic but I'll leave this here anyway.
		target = tostring(addonChannelId);
	elseif (distribution ~= "WHISPER") then
		target = nil;
	end
	local data, serialized;
	serialized = NIT.serializer:Serialize(string);
	local compressed = NIT.libDeflate:CompressDeflate(serialized, {level = 9});
	if (distribution == "YELL" or distribution == "SAY") then
		data = NIT.libDeflate:EncodeForWoWChatChannel(compressed);
	else
		data = NIT.libDeflate:EncodeForWoWAddonChannel(compressed);
	end
	NIT:SendCommMessage(NIT.commPrefix, data, distribution, target);
end

function NIT:versionCheck(remoteVersion)
	if (remoteVersion == 0) then
		--Comm is from NWB.
		return;
	end
	local lastVersionMsg = NIT.db.global.lastVersionMsg;
	if (tonumber(remoteVersion) > tonumber(version) and (GetServerTime() - lastVersionMsg) > 14400) then
		print("|cFF9CD6DE" .. L["versionOutOfDate"]);
		NIT.db.global.lastVersionMsg = GetServerTime();
	end
	if (tonumber(remoteVersion) > tonumber(version)) then
		NIT.latestRemoteVersion = remoteVersion;
	end
end

function NIT:sendVersion(distribution)
	--The "check" part needs to be here so it works with older versions, can be removed at some point later.
	if (distribution) then
		NIT:sendComm(distribution, "version " .. version .. " check");
	else
		if (IsInRaid()) then
			NIT:sendComm("RAID", "version " .. version .. " check");
		elseif (IsInGroup()) then
			NIT:sendComm("PARTY", "version " .. version .. " check");
		end
	end
end

--Instance reset sent by someone with this addon.
function NIT:instanceResetComm(data, sender, distribution)
	--Do nothing if they have group msg enabled to let us know anyway.
	NIT:debug("Incomming data:", data);
end

--Instance reset sent by someone with this addon but with group msg disabled.
function NIT:instanceResetNoMsgComm(data, sender, distribution)
	NIT:debug("Incomming noMsg data:", data);
	local who, realm = strsplit("-", sender, 2);
	NIT:print(data .. " has been reset by the group leader (" .. who .. ").");
end

--Instance reset sent by someone without this addon (from NWB) so they won't print to party chat.
function NIT:instanceResetOtherComm(data, sender, distribution)
	NIT:debug("Incomming data from other:", data);
	local who, realm = strsplit("-", sender, 2);
	NIT:print(data .. " has been reset by the group leader (" .. who .. ").");
end

local doGUID, isGhost;
local f = CreateFrame("Frame");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:RegisterEvent("CHAT_MSG_ADDON");
f:RegisterEvent("PLAYER_UNGHOST");
f:RegisterEvent("PLAYER_LEAVING_WORLD");
f:RegisterEvent("ADDONS_UNLOADING");
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
f:RegisterEvent("PLAYER_TARGET_CHANGED");
f:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
f:RegisterEvent("NAME_PLATE_UNIT_ADDED");
f:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN");
f:RegisterEvent("PLAYER_REGEN_ENABLED");
f:RegisterEvent("GROUP_ROSTER_UPDATE");
f:RegisterEvent("CHAT_MSG_MONEY");
f:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
f:RegisterEvent("PLAYER_UPDATE_RESTING");
f:RegisterEvent("PLAYER_XP_UPDATE");
f:RegisterEvent("PLAYER_LEVEL_UP");
f:RegisterEvent("PLAYER_DEAD");
f:RegisterEvent("BAG_UPDATE");
f:RegisterEvent("PLAYER_MONEY");
f:RegisterEvent("QUEST_TURNED_IN");
f:RegisterEvent("CHAT_MSG_SKILL");
f:RegisterEvent("UNIT_RANGEDDAMAGE");
f:RegisterEvent("LOCALPLAYER_PET_RENAMED");
f:RegisterEvent("UNIT_PET");
f:RegisterEvent("UNIT_PET_TRAINING_POINTS");
f:RegisterEvent("GROUP_JOINED");
f:RegisterEvent("GROUP_FORMED");
f:SetScript('OnEvent', function(self, event, ...)
	if (event == "PLAYER_LEAVING_WORLD" ) then
		doGUID = nil;
		if (UnitIsGhost("player")) then
			isGhost = true;
			NIT:debug("ghost");
			C_Timer.After(5, function()
				isGhost = false;
			end)
		end
		NIT:playerLeavingWorld(...);
	elseif (event == "PLAYER_ENTERING_WORLD" ) then
		local isLogon, isReload = ...;
		NIT:playerEnteringWorld(...);
		if (isLogon) then
			C_Timer.After(10, function()
				--Let other comms go first, this can be removed later and just party version checking once more people have it.
				NIT:sendVersion("GUILD");
			end)
		end
		if (isLogon or isReload) then
			--Need to add a delay for pet data to load properly at logon.
			C_Timer.After(5, function()
				NIT:recordCharacterData();
			end)
		else
			NIT:recordCharacterData();
		end
	elseif (event == "ADDONS_UNLOADING" ) then
		NIT:playerLogout(...);
		--Had this disable this here, too many player stats are set to 0 or nil right before PLAYER_LOGOUT.
		--Changed to a polling system.
		--NIT:recordCharacterData();
	elseif (event == "CHAT_MSG_ADDON") then
		local commPrefix, string, distribution, sender = ...;
		if (commPrefix == NIT.commPrefix) then
			local normalizedWho = string.gsub(sender, " ", "");
			normalizedWho = string.gsub(normalizedWho, "'", "");
			if (not string.match(normalizedWho, "-")) then
				--Sometimes it comes through without realm in classic?
				normalizedWho = normalizedWho .. "-" .. GetNormalizedRealmName();
			end
			if (not NIT.hasAddon[normalizedWho]) then
				NIT.hasAddon[normalizedWho] = "0";
			end
		end
	elseif (event == "PLAYER_UNGHOST" ) then
		--If player just unghosted then don't record new instance.
		NIT:debug("unghost");
		isGhost = true;
		C_Timer.After(4, function()
			isGhost = false;
		end)
		NIT:throddleEventByFunc(event, 2, "recordDurabilityData", ...);
	elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		NIT:combatLogEventUnfiltered(...);
	elseif (event == "UNIT_TARGET" or event == "PLAYER_TARGET_CHANGED") then
		NIT:parseGUID("target", nil, "target");
	elseif (event == "UPDATE_MOUSEOVER_UNIT") then
		NIT:parseGUID("mouseover", nil, "mouseover");
	elseif (event == "NAME_PLATE_UNIT_ADDED") then
		NIT:parseGUID("nameplate1", nil, "nameplate");
	elseif (event == "CHAT_MSG_COMBAT_XP_GAIN") then
		NIT:chatMsgCombatXpGain(...);
		NIT:recordGroupInfo();
	elseif (event == "CHAT_MSG_COMBAT_FACTION_CHANGE") then
		NIT:chatMsgCombatFactionChange(...);
	elseif (event == "PLAYER_REGEN_ENABLED") then
		NIT:recordCombatEndedData(...);
		--Send GUID from mage possibly later after pull is done.
	elseif (event == "GROUP_ROSTER_UPDATE") then
		NIT:recordGroupInfo();
	elseif (event == "CHAT_MSG_MONEY") then
		NIT:chatMsgMoney(...);
	elseif (event == "PLAYER_UPDATE_RESTING") then
		NIT:recordCharacterData();
	elseif (event == "PLAYER_XP_UPDATE") then
		--NIT:recordPlayerLevelData();
		NIT:throddleEventByFunc(event, 2, "recordPlayerLevelData", ...);
	elseif (event == "PLAYER_LEVEL_UP") then
		--Needs a delay to give time for client to update with right data.
		C_Timer.After(2, function()
			NIT:recordCharacterData();
		end)
	elseif (event == "PLAYER_DEAD") then
		NIT:throddleEventByFunc(event, 2, "recordDurabilityData", ...);
	elseif (event == "BAG_UPDATE" or event == "PLAYER_MONEY") then
		NIT:throddleEventByFunc(event, 2, "recordInventoryData", ...);
	elseif (event == "QUEST_TURNED_IN") then
		NIT:throddleEventByFunc(event, 2, "recordPlayerLevelData", ...);
	elseif (event == "CHAT_MSG_SKILL") then
		NIT:throddleEventByFunc(event, 4, "recordSkillUpData", ...);
	elseif (event == "UNIT_RANGEDDAMAGE" or event == "LOCALPLAYER_PET_RENAMED" or event == "UNIT_PET"
			or event == "UNIT_PET_TRAINING_POINTS") then
		local unit = ...;
		if (unit and (event == "UNIT_RANGEDDAMAGE" and unit ~= "pet") or (event == "UNIT_PET" and unit ~= "player")
				or (event == "UNIT_PET_TRAINING_POINTS" and unit ~= "pet")) then
			--Check if it's my pet. (UNIT_RANGEDDAMAGE uses "pet", UNIT_PET uses "player")
			--This must be checked here and not in recordHunterData() becaus the
			--throddle function captures the first unit only and supresses the rest but
			--UNIT_PET spams for every pet dismissed around the player so it captures the entire team
			--and can capture someone elses pet first before thier own within the throddle suppression timer.
			return;
		end
		if (NIT.loadTime < (GetServerTime() - 8)) then
				--This throddle timer can't be longer than pet res cast time.
				NIT:throddleEventByFunc(event, 2, "recordHunterData", ...);
		end
	elseif (event == "GROUP_JOINED" or event == "GROUP_FORMED") then
		--If not in group when this fires it means you are first to invite and starting the group so we use GROUP_FORMED instead.
		if (IsInGroup()) then
			NIT:throddleEventByFunc(event, 3, "sendVersion");
			--C_Timer.After(3, function()
			--	if (IsInGroup()) then
			--		NIT:sendVersion();
			--	end
			--end)
		end
	end
end)

--Keep 200 records max, can set records shown to max 500 in options, 100 is default.
function NIT:trimDatabase()
	for i, v in pairs(NIT.data.instances) do
		if (i > NIT.db.global.maxRecordsKept) then
			table.remove(NIT.data.instances, i);
		end
	end
end

function NIT:combatLogEventUnfiltered(...)
	local timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, 
			destName, destFlags, destRaidFlags, _, spellName = CombatLogGetCurrentEventInfo();
	if (subEvent == "SWING_DAMAGE" or subEvent == "SPELL_DAMAGE" or subEvent == "RANGE_DAMAGE") then
		if (sourceGUID and string.match(sourceGUID, "Creature")) then
			NIT:parseGUID(nil, sourceGUID, "combatlogSourceGUID");
		elseif (destGUID and string.match(destGUID, "Creature")) then
			NIT:parseGUID(nil, destGUID, "combatlogDestGUID");
		end
	elseif (subEvent == "UNIT_DIED" and UnitLevel("player") == NIT.maxLevel and string.match(destGUID, "Creature")) then
		--If max level player then count mobs via death instead of xp.
		NIT:countMobsFromKill();
	end
end

--[[Global XP strings.
COMBATLOG_XPGAIN_EXHAUSTION1 = "%s dies, you gain %d experience. (%s exp %s bonus)";
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

function NIT:chatMsgCombatXpGain(...)
	local text = ...;
	local xpGained = string.match(text, "%d+");
	if (NIT.inInstance and NIT.data.instances[1]) then
		NIT.data.instances[1].mobCount = NIT.data.instances[1].mobCount + 1;
		NIT.data.instances[1].xpFromChat = NIT.data.instances[1].xpFromChat + xpGained;
	end
end

function NIT:countMobsFromKill()
	if (NIT.inInstance and NIT.data.instances[1]) then
		NIT.data.instances[1].mobCount = NIT.data.instances[1].mobCount + 1;
	end
end

function NIT:chatMsgMoney(...)
	local text = ...;
	if (NIT.inInstance and NIT.data.instances[1]) then
		local copperGained = string.match(text, "(%d+) Copper") or 0;
		local silverGained = string.match(text, "(%d+) Silver") or 0;
		local goldGained = string.match(text, "(%d+) Gold") or 0;
		local total = copperGained + (silverGained * 100) + (goldGained * 10000); --12482
		if (not NIT.data.instances[1].rawMoneyCount) then
			NIT.data.instances[1].rawMoneyCount = 0;
		end
		NIT.data.instances[1].rawMoneyCount = NIT.data.instances[1].rawMoneyCount + total;
	end
end

function NIT:chatMsgCombatFactionChange(...)
	if (not NIT.inInstance) then
		return;
	end
	if (not NIT.data.instances[1].rep) then
		NIT.data.instances[1].rep = {};
	end
	local text = ...;
	local repName, repAmount, decrease;
	--Your %s reputation has increased by %d.
	local repName, repAmount = string.match(text, string.gsub(string.gsub(FACTION_STANDING_INCREASED, "%%s", "(.+)"), "%%d", "(%%d+)"));
	if (not repName or not repAmount) then
		repName, repAmount = string.match(text, string.gsub(string.gsub(FACTION_STANDING_DECREASED, "%%s", "(.+)"), "%%d", "(%%d+)"));
		decrease = true;
	end
	if (not repName or not repAmount) then
		NIT:debug("Faction error:", text);
		return;
	end
	if (not NIT.data.instances[1].rep[repName]) then
		NIT.data.instances[1].rep[repName] = 0
	end
	if (decrease) then
		NIT.data.instances[1].rep[repName] = NIT.data.instances[1].rep[repName] - repAmount;
	else
		NIT.data.instances[1].rep[repName] = NIT.data.instances[1].rep[repName] + repAmount;
	end
end

function NIT:playerEnteringWorld(...)
	local isLogon, isReload = ...;
	--On rare occasions you PLAYER_ENTERING_WORLD as a ghost still instead of unghosting beforehand.
	local isInstance, instanceType = IsInInstance();
	if (isInstance) then
		if (isReload) then
			C_Timer.After(0.2, function()
				NIT:enteredInstance(true);
			end)
		elseif (isLogon) then
			C_Timer.After(0.2, function()
				NIT:enteredInstance(nil, true);
			end)
		else
			C_Timer.After(0.2, function()
				if (isInstance) then
					NIT:enteredInstance();
				end
			end)
		end
	--elseif (NIT.inInstance and not isReload) then
	--	NIT:leftInstance();
	end
end

function NIT:playerLeavingWorld(...)
	if (NIT.inInstance) then
		NIT:leftInstance();
	end
end

function NIT:playerLogout(...)
	if (NIT.inInstance) then
		NIT:leftInstance();
	end
end

local isGhost = false;
NIT.lastInstanceName = "(Unknown Instance)";
function NIT:enteredInstance(isReload, isLogon)
	doGUID = true;
	local instance, instanceType = IsInInstance();
	if (instance == true and ((instanceType == "party") or (instanceType == "raid"))) then
		local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty,
				isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo();
		if (NIT.inInstance and NIT.lastInstanceName ~= instanceName) then
			--If we zone from one instance into another instance and the instance name if different (UBRS to BWL etc).
			--Close out the old instance data before starting a new.
			NIT:leftInstance();
		end
		NIT.lastInstanceName = instanceName;
		if (not instanceName) then
			instanceName = "(Instance Name Not Found)";
		end
		if (isGhost) then
			if (NIT.db.global.enteredMsg) then
				local texture = "|TInterface\\AddOns\\NovaInstanceTracker\\Media\\greenTick:12:12:0:0|t";
				NIT:print("Entered " .. instanceName .. " as ghost, not recording new instance. "
						.. "If you would like to force record a new instance click |HNITCustomLink:deletelast|h" .. texture .. "|h");
			end
		else
			if (not isReload) then
				local class, classEnglish = UnitClass("player");
				local t = {
					playerName = UnitName("player"),
					class = class,
					classEnglish = classEnglish,
					instanceName = instanceName,
					instanceID = instanceID,
					enteredTime = GetServerTime(),
					enteredLevel = UnitLevel("player");
					enteredXP = UnitXP("player");
					enteredMoney = GetMoney(),
					leftTime = 0,
					leftMoney = 0,
					mobCount = 0,
					rawMoneyCount = 0,
					xpFromChat = 0,
					group = {},
					rep = {},
				};
				if (NIT.isDebug) then
					t.GUIDList = {};
				end
				--Insert as first row, instances are stored newest first in the data table.
				table.insert(NIT.data.instances, 1, t);
				local texture = "|TInterface\\AddOns\\NovaInstanceTracker\\Media\\redX2:12:12:0:0|t";
				--local texture = "X";
				if (isLogon) then
					C_Timer.After(3, function()
						NIT:print("|HNITCustomLink:instancelog|hYou have logged in inside " .. instanceName .. ", "
								.. "if this is not a new instance click|h |HNITCustomLink:deletelast|h" .. texture
								.. "|h |HNITCustomLink:instancelog|h to delete this instance from the database.|h");
					end)
				else
					C_Timer.After(0.5, function()
						NIT:print("|HNITCustomLink:instancelog|hNew instance " .. instanceName .. ", click|h |HNITCustomLink:deletelast|h" .. texture
								.. "|h |HNITCustomLink:instancelog|h if this is not a new instance.|h");
					end)
				end
			elseif (isReload) then
				C_Timer.After(3, function()
					NIT:print("UI Reload detected, loading last instance data instead of creating new.");
				end)
			elseif (isLogon) then
				--Unsure how to deal with logons yet, could be logging back in from hours ago and it could ne a new instance.
				--Could be a logout reset with alt too.
				--Maybe a popup window to choose?
				--NIT:print("Logon detected, loading last instance.");
			end
			C_Timer.After(0.5, function()
				NIT.inInstance = GetServerTime();
			end)
			--NIT.lastInstanceID = #NIT.data.instances + 1;
			--NIT.data.instances[NIT.lastInstanceID] = t;
			isGhost = false;
			NIT:trimDatabase();
			NIT:addInstanceCount(instanceID);
		end
		NIT:recordGroupInfo();
	end
end

function NIT:leftInstance()
	if (NIT.inInstance and NIT.data.instances[1]) then
		NIT.data.instances[1]["leftTime"] = GetServerTime();
		NIT.data.instances[1]["leftLevel"] = UnitLevel("player");
		NIT.data.instances[1]["leftXP"] = UnitXP("player");
		NIT.data.instances[1]["leftMoney"] = GetMoney();
		local timeSpent = NIT:getTimeString(NIT.data.instances[1]["leftTime"] - NIT.data.instances[1]["enteredTime"], true, true);
		--UnitLevel("player") == NIT.maxLevel
		local data = NIT.data.instances[1];
		--local pColor, sColor = "|cFF9CD6DE", "|cFFc3e6eb";
		local pColor, sColor = "|cFFFFFFFF", "|cFF9CD6DE";
		--local text = "(" .. NIT.lastInstanceName .. ")";
		--local text = pColor;
		local text = sColor .. NIT.lastInstanceName;
		if (NIT.db.global.instanceStatsOutputMobCount) then
			--text = text .. " |cFF9CD6DEMobs: " .. data.mobCount;
			text = text .. pColor .. " Mobs: " .. sColor .. data.mobCount;
		end
		if (NIT.db.global.instanceStatsOutputXP and UnitLevel("player") ~= NIT.maxLevel) then
			text = text .. pColor .. " XP: " .. sColor .. NIT:commaValue(data.xpFromChat);
		end
		if (NIT.db.global.instanceStatsOutputAverageXP and UnitLevel("player") ~= NIT.maxLevel) then
			if (data.xpFromChat and data.xpFromChat > 0 and data.mobCount and data.mobCount > 0) then
				local averageXP = data.xpFromChat / data.mobCount
				text = text .. pColor .. " Average XP/Mob: " .. sColor .. NIT:round(averageXP, 2);
			else
				text = text .. pColor .. " Average XP/Mob: " .. sColor .. "0";
			end
		end
		if (NIT.db.global.instanceStatsOutputTime) then
			text = text .. pColor .. " Time: " .. sColor .. timeSpent;
		end
		if (NIT.db.global.instanceStatsOutputAverageGroupLevel and data.groupAverage) then
			text = text .. pColor .. " Average Group Level: " .. sColor .. NIT:round(data.groupAverage, 2);
		end
		--Don't send gold to group chat.
		local money = "0";
		if (NIT.db.global.instanceStatsOutputGold and NIT.db.global.instanceStatsOutput ~= "group") then
			if (data.rawMoneyCount and data.rawMoneyCount > 0) then
				money = data.rawMoneyCount;
			elseif (data.enteredMoney and data.leftMoney and data.enteredMoney > 0 and data.leftMoney > 0) then
				--Backup for people with addons installed using an altered money string.
				money = data.leftMoney - data.enteredMoney;
			end
			text = text .. pColor .. " Gold: " .. sColor .. NIT:convertMoney(money, true, "", true, sColor);
		end
		if (not NIT.db.global.statsOnlyWhenActivity or ((data.xpFromChat and data.xpFromChat > 0)
				or (data.mobCount and data.mobCount > 0) or tonumber(money) > 0)) then
			C_Timer.After(0.7, function()
				if (NIT.db.global.instanceStatsOutput and NIT.db.global.instanceStatsOutputWhere == "group") then
					if (IsInRaid()) then
						if (NIT.db.global.showStatsInRaid) then
			  				SendChatMessage("[NIT] " .. NIT:stripColors(text), "RAID");
			  			elseif (NIT.db.global.printRaidInstead) then
			  				NIT:print(text);
			  			end
			  		elseif (IsInGroup()) then
			  			SendChatMessage("[NIT] " .. NIT:stripColors(text), "PARTY");
					end
				elseif (NIT.db.global.instanceStatsOutput) then
					--NIT:print(text, nil, "[" .. NIT.lastInstanceName .. "]");
					NIT:print(text);
				end
			end)
		end
	end
	NIT.inInstance = nil;
	NIT.lastNpcID = 999999999;
	NIT.lastInstanceName = "(Unknown Instance)";
end

function NIT:addInstanceCount(instanceID)
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	if (not NIT.data.myChars[char].instances) then
		NIT.data.myChars[char].instances = {};
	end
	if (not NIT.data.myChars[char].instances[instanceID]) then
		NIT.data.myChars[char].instances[instanceID] = 0;
	end
	NIT.data.myChars[char].instances[instanceID] = NIT.data.myChars[char].instances[instanceID] + 1;
end

function NIT:removeInstanceCount(instanceID)
	local char = UnitName("player");
	if (NIT.data.myChars[char] and NIT.data.myChars[char].instances and NIT.data.myChars[char].instances[instanceID]
			and NIT.data.myChars[char].instances[instanceID] > 0) then
		NIT.data.myChars[char].instances[instanceID] = NIT.data.myChars[char].instances[instanceID] - 1;
	end
end

NIT.lastNpcID = 999999999;
function NIT:parseGUID(unit, GUID, source)
	if (not GUID) then
		GUID = UnitGUID(unit);
	end
	if (GUID and doGUID and NIT.inInstance and (not string.match(source, "combatlog") or GetServerTime() - NIT.inInstance > 2)) then
		local unitType, _, _, _, zoneID, npcID = strsplit("-", GUID);
		local zoneID = tonumber(zoneID);
		if (unitType ~= "Creature" or NIT.companionCreatures[tonumber(npcID)]) then
			--NIT:debug("not a creature");
			return;
		end
		if (NIT.isDebug) then
			if (not NIT.data.instances[1].GUIDList) then
				NIT.data.instances[1].GUIDList = {};
			end
			local data = (GUID or "nil");
			NIT.data.instances[1].GUIDList[data] = true;
		end
		NIT.lastNpcID = npcID;
		if (zoneID and zoneID > 0) then
			---Trying a few different things here to work out some bugs.
			---The next step if these don't work will be creating NPC whitelists.

			--Only merge if current GUID isn't set (first GUID of the instance).
			if (NIT.data.instances[2] and NIT.data.instances[2]["zoneID"] and NIT.data.instances[2]["zoneID"] == zoneID
					and not NIT.data.instances[1].zoneID) then
					--and (not NIT.data.instances[1].zoneID or NIT.data.instances[1].zoneID < 1)) then
					
			--Oirignal version
			--if (NIT.data.instances[2] and NIT.data.instances[2]["zoneID"] and NIT.data.instances[2]["zoneID"] == zoneID) then
				if (NIT.db.global.detectSameInstance) then
					C_Timer.After(0.7, function()
						NIT:print(NIT.mergeColor .. "Same instance ID as last detected, merging database entries.");
					end)
					NIT:debug("OldGUID:", NIT.data.instances[2].GUID, "NewGUID:", GUID, source);
					NIT:debug("OldZoneID:", NIT.data.instances[2]["zoneID"], "NewZoneID:", zoneID, source);
					--Merge instances data and then delete last.
					NIT:mergeLastInstances(GUID, source);
				end
			elseif (NIT.lastNpcID == npcID or (not NIT.data.instances[1].zoneID or NIT.data.instances[1].zoneID < 1)) then
				--Set new zoneID if we get the same zoneid from 2 mobs in a row the same or one isn't set yet.
				NIT.data.instances[1].zoneID = zoneID;
				NIT.data.instances[1].GUID = GUID;
				NIT.data.instances[1].GUIDSource = unit or "combatLog";
			end
		end
	end
end

--Merged countable instance data when deleting duplicate instance.
NIT.lastMerge = 0;
function NIT:mergeLastInstances(GUID, source)
	--Update static stuff with new character that entered stats.
	if (NIT.isDebug) then
		if (not NIT.data.instancesDebug) then
			NIT.data.instancesDebug = {};
		end
		table.insert(NIT.data.instancesDebug, 1, NIT.data.instances[1]);
	end
	local class, classEnglish = UnitClass("player");
	NIT.data.instances[2].playerName = UnitName("player");
	NIT.data.instances[2].class = class;
	NIT.data.instances[2].classEnglish = classEnglish;
	NIT.data.instances[2].enteredLevel = UnitLevel("player");
	NIT.data.instances[2].enteredXP = UnitXP("player");
	NIT.data.instances[2].enteredMoney = GetMoney();
	NIT.data.instances[2].mobCount =  NIT.data.instances[2].mobCount + NIT.data.instances[1].mobCount;
	NIT.data.instances[2].rawMoneyCount =  NIT.data.instances[2].rawMoneyCount + NIT.data.instances[1].rawMoneyCount;
	NIT.data.instances[2].xpFromChat =  NIT.data.instances[2].xpFromChat + NIT.data.instances[1].xpFromChat;
	NIT.data.instances[2].oldZoneID = NIT.data.instances[1].zoneID
	if (GUID) then
		NIT.data.instances[2].mergeGUID = GUID;
	end
	if (source) then
		NIT.data.instances[2].mergeSource = source;
	end
	local data = NIT.data.instances[1];
	if (data and data.instanceID) then
		NIT:removeInstanceCount(data.instanceID);
	end
	table.remove(NIT.data.instances, 1);
	NIT.lastMerge = GetServerTime();
end

local recordGroupInfoThroddle = 0;
function NIT:recordGroupInfo()
	if (not NIT.inInstance) then
		return;
	end
	if ((GetServerTime() - recordGroupInfoThroddle) < 2) then
		--Throddle to only run this once every 2 seconds because it can be called from a few different things.
		return;
	end
	if (not NIT.data.instances[1].group) then
		NIT.data.instances[1].group = {};
	end
	recordGroupInfoThroddle = GetServerTime();
	local average, count = 0, 0;
	local nums = {};
	nums[0] = UnitLevel("player");
	if (IsInRaid()) then
		for i = 1, 40 do
			local level = NIT:addToGroupData("raid" .. i);
			if (level) then
				if (level > 0) then
					count = count + 1;
					average = ((average * (count - 1)) + level) / count;
				end
			end
		end
	elseif (IsInGroup()) then
		for i = 1, 5 do
			local level = NIT:addToGroupData("party" .. i);
			if (level) then
				if (level > 0) then
					count = count + 1;
					average = ((average * (count - 1)) + level) / count;
				end
			end
		end
	else
		return;
	end
	local level = NIT:addToGroupData("player");
	if (level) then
		if (level > 0) then
			count = count + 1;
			average = ((average * (count - 1)) + level) / count;
		end
	end
	NIT.data.instances[1].groupAverage = average;
	return average;
end

function NIT:addToGroupData(unit)
	local level = UnitLevel(unit);
	local name = UnitName(unit);
	if (name == "Unknown") then
		--Sometimes the game can't get info from a group member.
		return 0;
	end
	local class, classEnglish = UnitClass(unit);
	local guildName, guildRankName, guildRankIndex = GetGuildInfo(unit);
	if (level and name) then
		--[[NIT.data.instances[1].group[name] = {
			level = level,
			class = class,
			classEnglish = classEnglish,
		}]]
		if (not NIT.data.instances[1].group[name]) then
			NIT.data.instances[1].group[name] = {};
		end
		--Only overwrite things if they are valid and not player out of range.
		if (level and (not NIT.data.instances[1].group[name].level or level > 0)) then
			NIT.data.instances[1].group[name].level = level;
		end
		if (class and (not NIT.data.instances[1].group[name].class or class ~= "")) then
			NIT.data.instances[1].group[name].class = class;
		end
		if (classEnglish and (not NIT.data.instances[1].group[name].classEnglish or classEnglish ~= "")) then
			NIT.data.instances[1].group[name].classEnglish = classEnglish;
		end
		if (guildName and (not NIT.data.instances[1].group[name].guildName or guildName ~= "")) then
			NIT.data.instances[1].group[name].guildName = guildName;
		end
	end
	--Return level for average calc.
	if (not level) then
		level = 0;
	end
	return level;
end

--Delete instance by number, called by confirmation popup.
function NIT:deleteInstance(num, displayNum)
	local data = NIT.data.instances[num];
	if (data) then
		local timeAgo = GetServerTime() - data.enteredTime;
		if (data.instanceID) then
			NIT:removeInstanceCount(data.instanceID);
		end
		if (displayNum) then
			NIT:print("Deleted instance [" .. displayNum .. "] " .. data.instanceName .. " ("
					.. NIT:getTimeString(timeAgo, true) .. " ago) from the database.")
		else
			NIT:print("Deleted instance [" .. num .. "] " .. data.instanceName .. " ("
					.. NIT:getTimeString(timeAgo, true) .. " ago) from the database.")
		end
		table.remove(NIT.data.instances, num);
		NIT:recalcInstanceLineFrames();
	else
		NIT:print("Error deleting " .. num .. ".")
	end
end

--Delete character data.
function NIT:deleteCharacter(realm, char)
	local data = NIT.db.global[realm].myChars[char];
	if (data) then
		if (char == UnitName("player")) then
			NIT.db.global[realm].myChars[char] = nil;
			NIT:print("Deleted character " .. char .. " on realm [" .. realm .. "], recording new info.")
			NIT:recalcAltsLineFrames();
			NIT:recordCharacterData();
		else
			NIT.db.global[realm].myChars[char] = nil;
			NIT:print("Deleted character " .. char .. " on realm [" .. realm .. "].")
			NIT:recalcAltsLineFrames();
		end
	else
		NIT:print("Error deleting " .. char .. ".")
	end
end

function NIT:getInstanceLockoutInfoString(char)
	local hourCount, hourCount24, hourTimestamp, hourTimestamp24 = NIT:getInstanceLockoutInfo(char);
	local countString = "You have entered " .. hourCount .. " instances in the past hour and " .. hourCount24 .. " in the past 24h";
	local countStringColorized = NIT.chatColor .. "You have entered " .. NIT.prefixColor .. hourCount .. NIT.chatColor
			.. " instances in the past hour and " .. NIT.prefixColor .. hourCount24 .. NIT.chatColor .. " in the past 24h";
	local lockoutInfo = "now";
	if (GetServerTime() - hourTimestamp24 < 86400 and hourCount24 >= NIT.dailyLimit) then
		lockoutInfo = "in " .. NIT:getTimeString(86400 - (GetServerTime() - hourTimestamp24), true) .. " (24h lockout active)";
	elseif (GetServerTime() - hourTimestamp < 3600 and hourCount >= NIT.hourlyLimit) then
		lockoutInfo = "in " .. NIT:getTimeString(3600 - (GetServerTime() - hourTimestamp), true);
	end
	lockoutInfo = "Next instance available " .. lockoutInfo;
	local lockoutStringShort = lockoutInfo .. ".";
	local lockoutString = countString .. ". " .. lockoutInfo .. ".";
	local lockoutStringColorized = countStringColorized .. ". " .. lockoutInfo .. ".";
	return lockoutString, lockoutStringShort, lockoutStringColorized;
end

function NIT:getInstanceLockoutInfo(char)
	local hourCount, hourCount24, hourTimestamp, hourTimestamp24 = 0, 0, 0, 0;
	local count = 0;
	local instances, lastInstance, lastInstance24 = 0, 0, 0;
	local target = UnitName("player");
	if (char) then
		target = char;
	end
	for k, v in ipairs(NIT.data.instances) do
		if (not NIT.perCharOnly or target == v.playerName) then
			count = count + 1;
			if (count > (NIT.dailyLimit + 10)) then
				break;
			end
			--Check leftTime first, then fallback to enteredTime if there's no time recorded for leaving instance.
			if (v.leftTime and v.leftTime > (GetServerTime() - 3600)) then
				hourCount = hourCount + 1;
				hourTimestamp = v.leftTime;
			elseif (v.enteredTime and v.enteredTime > (GetServerTime() - 3600)) then
				hourCount = hourCount + 1;
				hourTimestamp = v.enteredTime;
			end
			if (v.leftTime and v.leftTime > (GetServerTime() - 86400)) then
				hourCount24 = hourCount24 + 1;
				hourTimestamp24 = v.leftTime;
			elseif (v.enteredTime and v.enteredTime > (GetServerTime() - 86400)) then
				hourCount24 = hourCount24 + 1;
				hourTimestamp24 = v.enteredTime;
			end
		end
	end
	return hourCount, hourCount24, hourTimestamp, hourTimestamp24;
end

function NIT:recordCharacterData()
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	--Some of these can be nil or 0 at logout for some reason so we have to check.
	local classLocalized, classEnglish = UnitClass("player");
	NIT.data.myChars[char].realm = GetRealmName();
	NIT.data.myChars[char].level = UnitLevel("player");
	NIT.data.myChars[char].classLocalized = classLocalized;
	NIT.data.myChars[char].classEnglish = classEnglish;
	NIT.data.myChars[char].race = UnitRace("player");
	if (UnitXP("player") > 0) then
		NIT.data.myChars[char].currentXP = UnitXP("player");
	end
	if (UnitXPMax("player") > 0) then
		NIT.data.myChars[char].maxXP = UnitXPMax("player");
	end
	if (GetXPExhaustion()) then
		NIT.data.myChars[char].restedXP = GetXPExhaustion();
	else
		NIT.data.myChars[char].restedXP = 0
	end
	NIT.data.myChars[char].resting = IsResting();
	NIT.data.myChars[char].time = GetServerTime();
	--Race.
	local raceLocalized, raceEnglish = UnitRace("player");
	if (not raceEnglish) then
		raceEnglish = "unknownrace";
		raceLocalized = "unknownrace";
	end
	NIT.data.myChars[char].raceLocalized = raceLocalized;
	NIT.data.myChars[char].raceEnglish = raceEnglish;
	--Gender.
	local gender, genderNum = "Neutral", UnitSex("player");
	if (genderNum == 2) then
		gender = "Male";
	elseif (genderNum == 2) then
		gender = "Female";
	end
	NIT.data.myChars[char].gender = gender;
	local guild, guildRankName, guildRankIndex = GetGuildInfo("player");
	if (not guild) then
		guild = "No guild";
	end
	if (not guildRankName) then
		guildRankName = "No guild rank";
	end
	NIT.data.myChars[char].guild = guild;
	NIT.data.myChars[char].guildRankName = guildRankName;
	--Durability.
	local durabilityAverage = NIT.getAverageDurability();
	NIT.data.myChars[char].durabilityAverage = durabilityAverage;
	--Professions
	local prof1, prof2, fishing, cooking, firstaid = "none", "none", "none", "none", "none";
	local profSkill1, profSkill2, fishingSkill, cookingSkill, firstaidSkill = 0, 0, 0, 0, 0;
	local profSkillMax1, profSkillMax2, fishingSkillMax, cookingSkillMax, firstaidSkillMax = 0, 0, 0, 0, 0;
	if (NIT.classic) then
		--Skill list is always in same order, so we can get primary/secondary/weapon by checking the section headers.
		local section, primaryCount, secondaryCount, weaponCount = 0, 0, 0, 0;
		for i = 1, GetNumSkillLines() do
			local skillName, isHeader, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(i)
			if (isHeader and skillName == "Professions") then
				section = 2;
			elseif (isHeader and skillName == "Secondary Skills") then
				section = 3;
			elseif (isHeader and skillName == "Weapon Skills") then
				section = 4;
			elseif (isHeader and skillName == "Armor Proficiencies") then
				section = 5;
			elseif (isHeader and skillName == "Languages") then
				section = 6;
			end
			if (not isHeader and section == 2) then
				--Primary professions.
				primaryCount = primaryCount + 1;
				if (primaryCount == 1) then
					prof1 = skillName;
					profSkill1 = skillRank;
					profSkillMax1 = skillMaxRank;
				elseif (primaryCount == 2) then
					prof2 = skillName;
					profSkill2 = skillRank;
					profSkillMax2 = skillMaxRank;
				end
			elseif (not isHeader and section == 3) then
				--Secondary professions.
				secondaryCount = secondaryCount + 1;
				if (skillName == "Fishing") then
					fishing = skillName;
					fishingSkill = skillRank;
					fishingSkillMax = skillMaxRank;
				elseif (skillName == "Cooking") then
					cooking = skillName;
					cookingSkill = skillRank;
					cookingSkillMax = skillMaxRank;
				elseif (skillName == "First Aid") then
					firstaid = skillName;
					firstaidSkill = skillRank;
					firstaidSkillMax = skillMaxRank;
				end
			elseif (not isHeader and section == 4) then
				--Weapon skills.
				weaponCount = weaponCount + 1;
			end
		end
		NIT.data.myChars[char].prof1 = prof1;
		NIT.data.myChars[char].profSkill1 = profSkill1;
		NIT.data.myChars[char].profSkillMax1 = profSkillMax1;
		NIT.data.myChars[char].prof2 = prof2;
		NIT.data.myChars[char].profSkill2 = profSkill2;
		NIT.data.myChars[char].profSkillMax2 = profSkillMax2;
		--NIT.data.myChars[char].fishing = fishing;
		NIT.data.myChars[char].fishingSkill = fishingSkill;
		NIT.data.myChars[char].fishingSkillMax = fishingSkillMax;
		--NIT.data.myChars[char].cooking = cooking;
		NIT.data.myChars[char].cookingSkill = cookingSkill;
		NIT.data.myChars[char].cookingSkillMax = cookingSkillMax;
		--NIT.data.myChars[char].firstaid = firstaid;
		NIT.data.myChars[char].firstaidSkill = firstaidSkill;
		NIT.data.myChars[char].firstaidSkillMax = firstaidSkillMax;
	end
	if (IsQuestFlaggedCompleted(7848) or IsQuestFlaggedCompleted(7487)) then
		NIT.data.myChars[char].mcAttune = true;
	end
	if (IsQuestFlaggedCompleted(6502) or IsQuestFlaggedCompleted(6602)) then
		NIT.data.myChars[char].onyAttune = true;
	end
	if (IsQuestFlaggedCompleted(7761)) then
		NIT.data.myChars[char].bwlAttune = true;
	end
	if (IsQuestFlaggedCompleted(9121) or IsQuestFlaggedCompleted(9122) or IsQuestFlaggedCompleted(9123)) then
		NIT.data.myChars[char].naxxAttune = true;
	end
	if (classEnglish and classEnglish == "HUNTER") then
		NIT:recordHunterData();
	end
	NIT:recordInventoryData();
	NIT:recordLockoutdata();
end

function NIT:recordLockoutdata()
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	if (not NIT.data.myChars[char].savedInstances) then
		NIT.data.myChars[char].savedInstances = {};
	end
	local data = {};
	for i = 1, GetNumSavedInstances() do
		local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers,
				difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(i);
		local resetTime = GetServerTime() + reset;
		NIT.data.myChars[char].savedInstances[id] = {
			name = name,
			resetTime = resetTime,
			difficultyName = difficultyName,
			locked = locked,
		};
	end
end

function NIT:recordLockoutdataTest()
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	if (not NIT.data.myChars[char].savedInstances) then
		NIT.data.myChars[char].savedInstances = {};
	end
	local data = {};
	local name, id, reset, difficultyName, locked = "Test", 11, 15, "40 Player", true;
	local resetTime = GetServerTime() + reset;
	NIT.data.myChars[char].savedInstances[id] = {
		name = name,
		resetTime = resetTime,
		difficultyName = difficultyName,
		locked = locked,
	};
end

function NIT:resetOldLockouts()
	for realm, realmData in pairs(NIT.db.global) do
		if (type(realmData) == "table" and realmData ~= "minimapIcon" and realmData ~= "data") then
			if (realmData.myChars) then
				for char, charData in pairs(realmData.myChars) do
					if (charData.savedInstances) then
						for k, v in pairs(charData.savedInstances) do
							if (v.resetTime and v.resetTime < GetServerTime()) then
								NIT.db.global[realm].myChars[char].savedInstances[k] = nil;
							end
						end
					end
				end
			end
		end
	end
end

--These are structured like this so there's a sort order.
--minLvl is min lvl that you need to cast the spells that require them.
NIT.trackItemsPRIEST = {
	[1] = {
		id = 17029,
		name = "Sacred Candle",
		texture = "Interface\\Icons\\inv_misc_candle_02",
		minLvl = 56,
	},
	[2] = {
		id = 17056,
		name = "Light Feather",
		texture = "Interface\\Icons\\inv_feather_04",
		minLvl = 24,
	},
};

NIT.trackItemsMAGE = {
	[1] = {
		id = 17031,
		name = "Rune of Teleportation",
		texture = "Interface\\Icons\\inv_misc_rune_06",
		minLvl = 20;
	},
	[2] = {
		id = 17032,
		name = "Rune of Portals",
		texture = "Interface\\Icons\\inv_misc_rune_08",
		minLvl = 40;
	},
	[3] = {
		id = 17020,
		name = "Arcane Powder",
		texture = "Interface\\Icons\\inv_misc_dust_01",
		minLvl = 56;
	},
	[4] = {
		id = 17056,
		name = "Light Feather",
		texture = "Interface\\Icons\\inv_feather_04",
		minLvl = 12;
	},
};

NIT.trackItemsDRUID = {
	[1] = {
		id = 17026,
		name = "Wild Thornroot",
		texture = "Interface\\Icons\\inv_misc_root_01",
		minLvl = 60;
	},
	[2] = {
		id = 17038,
		name = "Ironwood Seed",
		texture = "Interface\\Icons\\inv_misc_food_02",
		minLvl = 60;
	},
};

NIT.trackItemsWARLOCK = {
	[1] = {
		id = 6265,
		name = "Soul Shard",
		texture = "Interface\\Icons\\inv_misc_gem_amethyst_02",
		minLvl = 10;
	},
};

NIT.trackItemsSHAMAN = {
	[1] = {
		id = 17030,
		name = "Ankh",
		texture = "Interface\\Icons\\inv_jewelry_talisman_06",
		minLvl = 30;
	},
	[2] = {
		id = 17058,
		name = "Fish Oil",
		texture = "Interface\\Icons\\inv_potion_64",
		minLvl = 28;
	},
	[3] = {
		id = 17057,
		name = "Shiny Fish Scales",
		texture = "Interface\\Icons\\inv_misc_monsterscales_08",
		minLvl = 22;
	},
};

NIT.trackItemsPALADIN = {
	[1] = {
		id = 21177,
		name = "Symbol of Kings",
		texture = "Interface\\Icons\\inv_misc_symbolofkings_01",
		minLvl = 52;
	},
	[2] = {
		id = 17033,
		name = "Symbol of Divinity",
		texture = "Interface\\Icons\\inv_stone_weightstone_05",
		minLvl = 30;
	},
};

--Sometimes we only need to update inventory data.
function NIT:recordInventoryData()
	local classLocalized, classEnglish = UnitClass("player");
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	--Gold.
	local gold = GetMoney();
	if (not gold) then
		gold = 0;
	end
	NIT.data.myChars[char].gold = gold;
	--Bags.
	local freeBagSlots, totalBagSlots = NIT.getBagSlots();
	if (not freeBagSlots) then
		freeBagSlots = 0;
	end
	if (not totalBagSlots) then
		totalBagSlots = 0;
	end
	NIT.data.myChars[char].freeBagSlots = freeBagSlots;
	NIT.data.myChars[char].totalBagSlots = totalBagSlots;
	local _, classEnglish = UnitClass("player");
	if (classEnglish and classEnglish == "HUNTER") then
		local ammo, ammoType = NIT.getAmmoCount();
		NIT.data.myChars[char].ammo = ammo;
		NIT.data.myChars[char].ammoType = ammoType;
	else
		if (_G["NIT"]["trackItems" .. classEnglish]) then
			for k, v in pairs(_G["NIT"]["trackItems" .. classEnglish]) do
				NIT.data.myChars[char][v.id] = (GetItemCount(v.id) or 0);
			end
		end
	end
end

function NIT:recordPlayerLevelData()
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	NIT.data.myChars[char].level = UnitLevel("player");
	if (UnitXP("player") > 0) then
		NIT.data.myChars[char].currentXP = UnitXP("player");
	end
	if (UnitXPMax("player") > 0) then
		NIT.data.myChars[char].maxXP = UnitXPMax("player");
	end
	if (GetXPExhaustion()) then
		NIT.data.myChars[char].restedXP = GetXPExhaustion();
	else
		NIT.data.myChars[char].restedXP = 0
	end
	NIT.data.myChars[char].resting = IsResting();
	NIT.data.myChars[char].time = GetServerTime();
end

function NIT:recordSkillUpData(...)
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	local prof1, prof2, fishing, cooking, firstaid = "none", "none", "none", "none", "none";
	local profSkill1, profSkill2, fishingSkill, cookingSkill, firstaidSkill = 0, 0, 0, 0, 0;
	local profSkillMax1, profSkillMax2, fishingSkillMax, cookingSkillMax, firstaidSkillMax = 0, 0, 0, 0, 0;
	if (NIT.classic) then
		--Skill list is always in same order, so we can get primary/secondary/weapon by checking the section headers.
		local section, primaryCount, secondaryCount, weaponCount = 0, 0, 0, 0;
		for i = 1, GetNumSkillLines() do
			local skillName, isHeader, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(i)
			if (isHeader and skillName == "Professions") then
				section = 2;
			elseif (isHeader and skillName == "Secondary Skills") then
				section = 3;
			elseif (isHeader and skillName == "Weapon Skills") then
				section = 4;
			elseif (isHeader and skillName == "Armor Proficiencies") then
				section = 5;
			elseif (isHeader and skillName == "Languages") then
				section = 6;
			end
			if (not isHeader and section == 2) then
				--Primary professions.
				primaryCount = primaryCount + 1;
				if (primaryCount == 1) then
					prof1 = skillName;
					profSkill1 = skillRank;
					profSkillMax1 = skillMaxRank;
				elseif (primaryCount == 2) then
					prof2 = skillName;
					profSkill2 = skillRank;
					profSkillMax2 = skillMaxRank;
				end
			elseif (not isHeader and section == 3) then
				--Secondary professions.
				secondaryCount = secondaryCount + 1;
				if (skillName == "Fishing") then
					fishing = skillName;
					fishingSkill = skillRank;
					fishingSkillMax = skillMaxRank;
				elseif (skillName == "Cooking") then
					cooking = skillName;
					cookingSkill = skillRank;
					cookingSkillMax = skillMaxRank;
				elseif (skillName == "First Aid") then
					firstaid = skillName;
					firstaidSkill = skillRank;
					firstaidSkillMax = skillMaxRank;
				end
			elseif (not isHeader and section == 4) then
				--Weapon skills.
				weaponCount = weaponCount + 1;
			end
		end
		NIT.data.myChars[char].prof1 = prof1;
		NIT.data.myChars[char].profSkill1 = profSkill1;
		NIT.data.myChars[char].profSkillMax1 = profSkillMax1;
		NIT.data.myChars[char].prof2 = prof2;
		NIT.data.myChars[char].profSkill2 = profSkill2;
		NIT.data.myChars[char].profSkillMax2 = profSkillMax2;
		--NIT.data.myChars[char].fishing = fishing;
		NIT.data.myChars[char].fishingSkill = fishingSkill;
		NIT.data.myChars[char].fishingSkillMax = fishingSkillMax;
		--NIT.data.myChars[char].cooking = cooking;
		NIT.data.myChars[char].cookingSkill = cookingSkill;
		NIT.data.myChars[char].cookingSkillMax = cookingSkillMax;
		--NIT.data.myChars[char].firstaid = firstaid;
		NIT.data.myChars[char].firstaidSkill = firstaidSkill;
		NIT.data.myChars[char].firstaidSkillMax = firstaidSkillMax;
	end
end

--Update certain data like XP etc when combat ends instead of every mob.
function NIT:recordCombatEndedData()
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	
	if (UnitXP("player") > 0) then
		NIT.data.myChars[char].currentXP = UnitXP("player");
	end
	if (UnitXPMax("player") > 0) then
		NIT.data.myChars[char].maxXP = UnitXPMax("player");
	end
	if (GetXPExhaustion()) then
		NIT.data.myChars[char].restedXP = GetXPExhaustion();
	else
		NIT.data.myChars[char].restedXP = 0
	end
	NIT.data.myChars[char].resting = IsResting();
	NIT.data.myChars[char].time = GetServerTime();
	local durabilityAverage = NIT.getAverageDurability();
	NIT.data.myChars[char].durabilityAverage = durabilityAverage;
	local localizedClass, englishClass = UnitClass("player");
	if (englishClass == "HUNTER") then
		NIT:recordHunterData();
	end
end

local durabilityFirstRun = true;
function NIT:recordDurabilityData()
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	--Don't run this at logon, this data gets recorded already in recordCharacterData();
	if (durabilityFirstRun) then
		durabilityFirstRun = false;
		return
	end
	local durabilityAverage = NIT.getAverageDurability();
	NIT.data.myChars[char].durabilityAverage = durabilityAverage;
end

function NIT:recordHunterData()
	local _, class = UnitClass("player");
	if (class ~= "HUNTER") then
		return;
	end
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	local hasUI = HasPetUI();
	local hasPet, petHappiness, petLoyaltyRate, petCurrentXP, petMaxXP, petLevel, petName, petFamily, loyaltyString;
	local totalPetPoints, spentPetPoints = 0, 0;
	if (hasUI) then
		hasPet = true;
		petHappiness, _, petLoyaltyRate = GetPetHappiness();
		petCurrentXP, petMaxXP = GetPetExperience();
		petLevel = UnitLevel("pet");
		petName = UnitName("pet");
		petFamily = UnitCreatureFamily("pet");
		loyaltyString = GetPetLoyalty();
		totalPetPoints, spentPetPoints = GetPetTrainingPoints();
        --local percent = NIT:round((currXP/nextXP) * 100);
	else
		hasPet = false;
		--Fallback to stable for some data incase pet isn't out.
		_, petName, petLevel, petFamily, loyaltyString = GetStablePetInfo(0);
	end
	local isPetDead = false;
	if (UnitIsDead("pet")) then
		isPetDead = true;
	end
	local ammo, ammoType = NIT.getAmmoCount();
	NIT.data.myChars[char].hasPet = hasPet;
	NIT.data.myChars[char].isPetDead = isPetDead;
	NIT.data.myChars[char].ammo = ammo;
	NIT.data.myChars[char].ammoType = ammoType;
	--I check these before setting them so last data is displayed anyway and not overwritten with 0/nil.
	if (petHappiness) then
		NIT.data.myChars[char].petHappiness = petHappiness;
	end
	if (petLoyaltyRate) then
		NIT.data.myChars[char].petLoyaltyRate = petLoyaltyRate;
	end
	if (petCurrentXP) then
		NIT.data.myChars[char].petCurrentXP = petCurrentXP;
	end
	if (petMaxXP) then
		NIT.data.myChars[char].petMaxXP = petMaxXP;
	end
	if (petLevel) then
		NIT.data.myChars[char].petLevel = petLevel;
	end
	if (petLevel) then
		NIT.data.myChars[char].petName = petName;
	end
	if (petFamily) then
		NIT.data.myChars[char].petFamily = petFamily;
	end
	if (loyaltyString) then
		NIT.data.myChars[char].loyaltyString = loyaltyString;
	end
	if (totalPetPoints) then
		NIT.data.myChars[char].totalPetPoints = totalPetPoints;
	end
	if (spentPetPoints) then
		NIT.data.myChars[char].spentPetPoints = spentPetPoints;
	end
end

function NIT.getAverageDurability()
	local totalCurrent, totalMax = 0, 0;
	for i = 0, 19 do
		local current, max = GetInventoryItemDurability(i)
		if (current and max) then
			totalCurrent = totalCurrent + current;
			totalMax = totalMax + max;
		end
	end
	if (totalMax == 0) then
		--If no durability found then armor is off or they have unbreakable armor on.
		return 100;
	end
	local totalAverage = ((totalCurrent/totalMax)*100);
	return totalAverage;
end

function NIT.getAmmoCount()
	local slotID = GetInventorySlotInfo("AmmoSlot");
	if (slotID) then
		local itemID = GetInventoryItemID("player", slotID);
		if (itemID) then
			local ammoCount = GetItemCount(itemID);
			if (ammoCount) then
				return ammoCount, itemID;
			end
		end
	end
	return 0;
end

function NIT:getBagSlots()
	local freeSlots = 0;
	local totalSlots = 0;
	for bag = 0, NUM_BAG_SLOTS do
		local free, bagType = GetContainerNumFreeSlots(bag);
		local total = GetContainerNumSlots(bag);
		--Bag type 0 is a normal storage bag (non professon bag).
		if (bagType == 0) then
			freeSlots = freeSlots + free;
			totalSlots = totalSlots + total;
		end
	end
	return freeSlots, totalSlots;
end

--Throddle by function name, delays event for non-vital info and catches any extras to avoid spam when mass looting etc.
local throddle = true;
NIT.currentThroddles = {};
function NIT:throddleEventByFunc(event, time, func, ...)
	if (throddle and NIT.currentThroddles[func] == nil) then
		--Must be false and not nil.
		NIT.currentThroddles[func] = ... or false;
		C_Timer.After(time, function()
			self[func](self, NIT.currentThroddles[func]);
			NIT.currentThroddles[func] = nil;
		end)
	elseif (not throddle) then
		self[func](...);
	end
end

--Record character data every 60 seconds as a backup, there's good reason for this.
function NIT:tickerCharacterData()
	C_Timer.After(60, function()
		NIT:recordCharacterData()
		NIT:tickerCharacterData();
	end)
end

--Correct a bug, remove this later.
--[[function NIT:correctCharacterData()
	NIT.data.chars = nil;
	for k, v in pairs(NIT.db.global) do
		if (type(v) == "table" and k ~= "minimapIcon" and k ~= "data") then
			if (v.myChars) then
				for kk, vv in pairs(v.myChars) do
					NIT.db.global[k].myChars[kk].englishClass = nil;
					NIT.db.global[k].myChars[kk].localizedClass = nil;
				end
			end
		end
	end
end]]

function NIT:resetCharData()
	if (NIT.db.global.resetCharData) then
		for k, v in pairs(NIT.db.global) do
			if (type(v) == "table" and k ~= "minimapIcon" and k ~= "data") then
				if (v.myChars) then
					NIT.db.global[k].myChars = {};
				end
			end
		end
		NIT:recalcAltsLineFrames();
		NIT:recordCharacterData();
	end
	NIT.db.global.resetCharData = false;
end
---Trades---

local f = CreateFrame("Frame");
f:RegisterEvent("TRADE_SHOW");
--f:RegisterEvent("TRADE_CLOSED");
--f:RegisterEvent("PLAYER_TRADE_MONEY");
f:RegisterEvent("TRADE_MONEY_CHANGED");
f:RegisterEvent("TRADE_ACCEPT_UPDATE");
f:RegisterEvent("TRADE_REQUEST_CANCEL");
f:RegisterEvent("UI_INFO_MESSAGE");
f:RegisterEvent("UI_ERROR_MESSAGE");
f:RegisterEvent("TRADE_REQUEST_CANCEL");
local playerMoney, targetMoney, tradeWho, tradeWhoClass = 0, 0, "", "";
local doTrade;
f:SetScript("OnEvent", function(self, event, ...)
	if (event == "TRADE_SHOW") then
		tradeWho = UnitName("npc");
		_, tradeWhoClass = UnitClass("npc");
	elseif (event == "TRADE_MONEY_CHANGED") then
		playerMoney = GetPlayerTradeMoney();
		targetMoney = GetTargetTradeMoney();
	elseif (event == "TRADE_ACCEPT_UPDATE") then
		playerMoney = GetPlayerTradeMoney();
		targetMoney = GetTargetTradeMoney();
	elseif (event == "TRADE_REQUEST_CANCEL") then
		NIT:resetCurrentTradeData();
	elseif (event == "UI_INFO_MESSAGE" or event == "UI_ERROR_MESSAGE") then
		local type, msg = ...;
		if (msg == ERR_TRADE_BAG_FULL or msg == ERR_TRADE_TARGET_BAG_FULL or msg == ERR_TRADE_CANCELLED
				or msg == ERR_TRADE_TARGET_MAX_LIMIT_CATEGORY_COUNT_EXCEEDED_IS) then
			NIT:resetCurrentTradeData();
		elseif (msg == ERR_TRADE_COMPLETE) then
			NIT:doTrade();
		end
	end
end)

function NIT:doTrade(playerMoneyCount, targetMoneyCount)
	local traded;
	local _, _, _, classColorHex = GetClassColor(string.upper(tradeWhoClass));
	if (playerMoney > 0) then
		if (NIT.db.global.showMoneyTradedChat) then
			NIT:print("|HNITCustomLink:tradelog|h|cFF9CD6DEGave|r|h |r" .. NIT:getCoinString(playerMoney)
					.. NIT.chatColor .. " |HNITCustomLink:tradelog|h|cFF9CD6DEto|r |c"
					.. classColorHex .. tradeWho .. NIT.chatColor .. ".|h", nil, nil, true, true);
		end
		traded = true;
	end
	if (targetMoney > 0) then
		if (NIT.db.global.showMoneyTradedChat) then
			NIT:print("|HNITCustomLink:tradelog|h|cFF9CD6DEReceived|r|h |r" .. NIT:getCoinString(targetMoney)
					.. NIT.chatColor .. " |HNITCustomLink:tradelog|h|cFF9CD6DEfrom|r |c"
					.. classColorHex .. tradeWho .. NIT.chatColor .. ".|h", nil, nil, true, true);
		end
		traded = true;
	end
	if (not NIT.data.trades) then
		NIT.data.trades = {};
	end
	if (traded) then
		local t = {
			playerMoney = playerMoney,
			targetMoney = targetMoney,
			tradeWho = tradeWho,
			tradeWhoClass = tradeWhoClass,
			where = GetZoneText() or "",
			time = GetServerTime(),
		};
		table.insert(NIT.data.trades, 1, t);
	end
	NIT:resetCurrentTradeData();
end

function NIT:resetCurrentTradeData()
	--NIT:debug("reset trade data");
	playerMoney, targetMoney, tradeWho, tradeWhoClass = 0, 0, "", "";
end

--[[local f = CreateFrame("Frame");
f:RegisterAllEvents();
f:SetScript('OnEvent', function(self, event, ...)
	NIT.db.global.events[event] = GetServerTime();
end)]]