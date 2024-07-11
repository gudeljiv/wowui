------------------------------
---NovaInstanceTracker data---
------------------------------

local locale = GetLocale();
if (locale == "deDE" and NIT.expansionNum < 5) then
	--Temporary fix for german clients having broken XP global strings that don't show the amount gained.
	--Not sure when this started but it was reported and tested 15/09/2023
	--Credit to user Tomatensalat and an addon https://www.wowinterface.com/downloads/download25450-aPVPName1s2s by Razyel.
	--Only fixing a few strings that are important to this addon while normal grouping for xp in dungs.
	COMBATLOG_XPGAIN_EXHAUSTION1_RAID = "%s stirbt, Ihr bekommt %d Erfahrung. (%s Erf. %s Bonus, -%d Schlachtzugsmalus)"
	COMBATLOG_XPGAIN_FIRSTPERSON = "%s stirbt, Ihr bekommt %d Erfahrung."
	COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED_RAID = "Ihr bekommt %d Erfahrung. (-%d Schlachtzugsmalus)"
	COMBATLOG_XPGAIN_FIRSTPERSON_GROUP = "%s stirbt, Ihr bekommt %d Erfahrung. (+%d Gruppen-Bonus)"
	COMBATLOG_XPGAIN_EXHAUSTION1_GROUP = "%s stirbt, Ihr bekommt %d Erfahrung. (%s Erf. %s Bonus, +%d Gruppen-Bonus)"
	COMBATLOG_XPGAIN_EXHAUSTION5_GROUP = "%s stirbt, Ihr bekommt %d Erfahrung. (%s Erf. %s Abzug, +%d Gruppen-Bonus)"
	COMBATLOG_XPGAIN_EXHAUSTION2_GROUP = "%s stirbt, Ihr bekommt %d Erfahrung. (%s Erf. %s Bonus, +%d Gruppen-Bonus)"
	COMBATLOG_XPGAIN_EXHAUSTION2 = "%s stirbt, Ihr bekommt %d Erfahrung. (%s Erf. %s Bonus)"
	COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED = "Ihr bekommt %d Erfahrung."
	COMBATLOG_XPGAIN_EXHAUSTION5 = "%s stirbt, Ihr bekommt %d Erfahrung. (%s-Erf. %s-Abzug)"
	COMBATLOG_XPGAIN_FIRSTPERSON_RAID = "%s stirbt, Ihr bekommt %d Erfahrung. (-%d Schlachtzugsmalus)"
	COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED_GROUP = "Ihr bekommt %d Erfahrung. (+%d Gruppen-Bonus)"
	COMBATLOG_XPGAIN_EXHAUSTION4_GROUP = "%s stirbt, Ihr bekommt %d Erfahrung. (%s Erf. %s Abzug, +%d Gruppen-Bonus)"
	COMBATLOG_XPGAIN_EXHAUSTION5_RAID = "%s stirbt, Ihr bekommt %d Erfahrung. (%s Erf. %s Abzug, -%d Schlachtzugsmalus)"
	COMBATLOG_XPGAIN_EXHAUSTION4 = "%s stirbt, Ihr bekommt %d Erfahrung. (%s-Erf. %s-Abzug)"
	COMBATLOG_XPGAIN_EXHAUSTION4_RAID = "%s stirbt, Ihr bekommt %d Erfahrung. (%s Erf. %s Abzug, -%d Schlachtzugsmalus)"
	COMBATLOG_XPGAIN_EXHAUSTION1 = "%s stirbt, Ihr bekommt %d Erfahrung. (%s Erf. %s Bonus)"
	COMBATLOG_XPGAIN_QUEST = "Ihr bekommt %d Erfahrung. (%s EP-Bonus durch %s)"
	COMBATLOG_XPGAIN_EXHAUSTION2_RAID = "%s stirbt, Ihr bekommt %d Erfahrung. (%s Erf. %s Bonus, -%d Schlachtzugsmalus)"
end

local L = LibStub("AceLocale-3.0"):GetLocale("NovaInstanceTracker");
local version = GetAddOnMetadata("NovaInstanceTracker", "Version") or 9999;
local GetContainerNumFreeSlots = GetContainerNumFreeSlots or C_Container.GetContainerNumFreeSlots;
local GetContainerNumSlots = GetContainerNumSlots or C_Container.GetContainerNumSlots;
local GetContainerItemCooldown = GetContainerItemCooldown or C_Container.GetContainerItemCooldown;
local GetContainerItemLink = GetContainerItemLink or C_Container.GetContainerItemLink;
local IsQuestFlaggedCompleted = IsQuestFlaggedCompleted or C_QuestLog.IsQuestFlaggedCompleted;
local GetQuestInfo = C_QuestLog.GetQuestInfo or C_QuestLog.GetTitleForQuestID;
NIT.currentInstanceID = 0;
--This is for a system that records before and after honor for bgs honor gained calced.
--Didn't have to end up using it becaus another way was worked out that didn't work at the start of expansion.
--Cata scoreboard isn't accurate honor gained either, but NIT current system is now accurate, hopefully nothing else breaks.
--Can't use CHAT_MSG_CURRENCY becaus bg bonus honor doesn't trigger it.
--local usePreHonor = true;
local usePreHonor;

--Some of this addon comm stuff is copied from my other addon NovaWorldBuffs and is left here incase of future stuff being added.
function NIT:OnCommReceived(commPrefix, string, distribution, sender)
	--if (NIT.isDebug) then
	--	return;
	--end
	--AceComm doesn't supply realm name if it's on the same realm as player.
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
		return;
		--decoded = NIT.libDeflate:DecodeForWoWChatChannel(string);
	else
		decoded = NIT.libDeflate:DecodeForWoWAddonChannel(string);
	end
	if (not decoded) then
		NIT:debug("Incoming data decode failure");
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
	if ((UnitInBattleground("player") or NIT:isInArena()) and distribution ~= "GUILD") then
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
	if (not remoteVersion or remoteVersion == 0) then
		--Comm is from NWB is version is 0.
		--Someone reported version was missing all together, someone else started using the NIT prefix maybe?
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
		NIT:sendGroupComm("version " .. version .. " check")
	end
end

--Instance reset sent by someone with this addon.
function NIT:instanceResetComm(data, sender, distribution)
	--Do nothing if they have group msg enabled to let us know anyway.
	--NIT:debug("Incoming data:", data);
end

--Instance reset sent by someone with this addon but with group msg disabled.
function NIT:instanceResetNoMsgComm(data, sender, distribution)
	NIT:debug("Incoming noMsg data:", data);
	local who, realm = strsplit("-", sender, 2);
	NIT:print(data .. " has been reset by the group leader (" .. who .. ").");
end

--Instance reset sent by someone without this addon (from NWB) so they won't print to party chat.
function NIT:instanceResetOtherComm(data, sender, distribution)
	NIT:debug("Incoming data from other:", data);
	local who, realm = strsplit("-", sender, 2);
	NIT:print(data .. " has been reset by the group leader (" .. who .. ").");
end

local doGUID, isGhost;
local currentXP, maxXP = 0, 0;
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
f:RegisterEvent("PLAYER_LOGOUT");
if (NIT.expansionNum < 4) then
	f:RegisterEvent("UNIT_PET_TRAINING_POINTS");
	f:RegisterEvent("TRADE_SKILL_UPDATE");
	f:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
end
if (NIT.expansionNum > 3) then
	f:RegisterEvent("CHAT_MSG_CURRENCY");
	f:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
end
f:RegisterEvent("GROUP_JOINED");
f:RegisterEvent("GROUP_FORMED");
f:RegisterEvent("PLAYER_CAMPING");
f:RegisterEvent("TRADE_SKILL_SHOW");
f:RegisterEvent("TRADE_SKILL_CLOSE");
f:RegisterEvent("UPDATE_BATTLEFIELD_SCORE");
f:RegisterEvent("ENCOUNTER_END");
f:RegisterEvent("CURRENCY_DISPLAY_UPDATE");
if (NIT.isRetail) then
	f:RegisterEvent("CHALLENGE_MODE_START");
	f:RegisterEvent("CHALLENGE_MODE_COMPLETED");
	f:RegisterEvent("CHALLENGE_MODE_MAPS_UPDATE")
	f:RegisterEvent("CHAT_MSG_LOOT");
	f:RegisterEvent("ITEM_CHANGED");
	f:RegisterEvent("WEEKLY_REWARDS_UPDATE");
end
f:RegisterEvent("UPDATE_INSTANCE_INFO");
f:RegisterEvent("PLAYER_GUILD_UPDATE");
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
				currentXP = (UnitXP("player") or 0);
				maxXP = (UnitXPMax("player") or 0);
			end)
			C_Timer.After(5, function()
				NIT:fixCooldowns();
			end)
			NIT:trimTrades();
		end
		if (isLogon or isReload) then
			--Need to add a delay for pet data to load properly at logon.
			C_Timer.After(5, function()
				NIT:recordCharacterData();
			end)
			C_Timer.After(10, function()
				NIT:recordKeystoneData();
			end)
		else
			NIT:recordCharacterData();
		end
		C_Timer.After(3, function()
			NIT:recordLockoutData();
		end)
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
		--NIT:debug("unghost");
		isGhost = true;
		C_Timer.After(4, function()
			isGhost = false;
		end)
		NIT:throddleEventByFunc(event, 2, "recordDurabilityData", ...);
	elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		NIT:combatLogEventUnfiltered(...);
	elseif (event == "UNIT_TARGET" or event == "PLAYER_TARGET_CHANGED") then
		NIT:parseGUID("target", nil, "target");
		if (NIT.inInstance and (NIT.isWrath or NIT.isCata)) then
			NIT:scanDungeonSubDifficulty();
		end
	elseif (event == "UPDATE_MOUSEOVER_UNIT") then
		NIT:parseGUID("mouseover", nil, "mouseover");
	elseif (event == "NAME_PLATE_UNIT_ADDED") then
		NIT:parseGUID("nameplate1", nil, "nameplate");
	elseif (event == "CHAT_MSG_COMBAT_XP_GAIN") then
		NIT:chatMsgCombatXpGain(...);
		NIT:throddleEventByFunc(event, 2, "recordGroupInfo", ...);
	elseif (event == "ENCOUNTER_END") then
		local _, _, _, _, success = ...;
		NIT:throddleEventByFunc(event, 2, "recordGroupInfo", ...);
		RequestRaidInfo();
		C_Timer.After(3, function()
			NIT:recordLockoutData();
		end)
		if (success) then
			C_Timer.After(2, function()
				NIT:recordKeystoneData();
			end)
		end
	elseif (event == "CHAT_MSG_COMBAT_FACTION_CHANGE") then
		NIT:chatMsgCombatFactionChange(...);
	elseif (event == "CHAT_MSG_COMBAT_HONOR_GAIN") then
		--Pre cata.
		NIT:chatMsgCombatHonorGain(...);
		NIT:recordHonorData();
	elseif (event == "CHAT_MSG_CURRENCY") then
		--Post cata honor recording.
		NIT:chatMsgCurrency(...);
		NIT:recordCurrency();
		NIT:recordHonorData();
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
		currentXP = (UnitXP("player") or 0);
		maxXP = (UnitXPMax("player") or 0);
	elseif (event == "PLAYER_LEVEL_UP") then
		--Needs a delay to give time for client to update with right data.
		C_Timer.After(2, function()
			NIT:recordCharacterData();
		end)
	elseif (event == "PLAYER_DEAD") then
		NIT:throddleEventByFunc(event, 2, "recordDurabilityData", ...);
	elseif (event == "BAG_UPDATE" or event == "PLAYER_MONEY") then
		NIT:throddleEventByFunc(event, 3, "recordInventoryData", ...);
	elseif (event == "QUEST_TURNED_IN") then
		NIT:throddleEventByFunc(event, 2, "recordPlayerLevelData", ...);
		NIT:throddleEventByFunc(event, 1, "recordQuests", ...);
		C_Timer.After(5, function()
			NIT:recordQuests();
		end)
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
	elseif (event == "PLAYER_CAMPING") then
		--Print stats if logging out inside an instance for an offline reset.
		if (NIT.inInstance) then
			NIT.data.instances[1]["leftTime"] = GetServerTime();
			NIT:showInstanceStats();
		end
		NIT:recordLockoutData();
		NIT:recordQuests();
	elseif (event == "PLAYER_LOGOUT") then
		--Print stats if logging out inside an instance for an offline reset.
		NIT:recordLockoutData();
		NIT:recordQuests();
	elseif (event == "TRADE_SKILL_UPDATE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE") then
		NIT:recordCooldowns();
	elseif (event == "UPDATE_BATTLEFIELD_SCORE") then
		NIT:recordBgStats();
	elseif (event == "CURRENCY_DISPLAY_UPDATE") then
		C_Timer.After(1, function()
			NIT:recordCurrency();
		end)
	elseif (event == "CHALLENGE_MODE_START") then
		if (NIT.inInstance and NIT.data.instances[1]) then
			local activeKeystoneLevel, activeAffixIDs, wasActiveKeystoneCharged = C_ChallengeMode.GetActiveKeystoneInfo();
			NIT.data.instances[1].mythicPlus = {
				level = activeKeystoneLevel;
				affixes = activeAffixIDs,
			};
			--record +key times for the dung
		end
	elseif (event == "CHALLENGE_MODE_COMPLETED") then
		NIT:debug("challenge mode completed")
		if (NIT.inInstance and NIT.data.instances[1]) then
			if (not NIT.data.instances[1].mythicPlus) then
				NIT.data.instances[1].mythicPlus = {};
			end
			local mapChallengeModeID, level, time, onTime, keystoneUpgradeLevels, practiceRun, oldOverallDungeonScore, newOverallDungeonScore,
					IsMapRecord, IsAffixRecord, PrimaryAffix, isEligibleForScore, members = C_ChallengeMode.GetCompletionInfo();
			local data = NIT.data.instances[1].mythicPlus;
			data.map = mapChallengeModeID;
			data.time = time;
			data.timed = onTime;
			data.upgrade = keystoneUpgradeLevels;
			data.oldScore = oldOverallDungeonScore;
			data.newScore = newOverallDungeonScore;
			data.completed = true;
			data.newRecord = IsAffixRecord == true or nil;
			local deaths, timeLost = C_ChallengeMode.GetDeathCount();
			data.deaths = deaths;
			data.timeLost = timeLost;
			--data.totalScore = C_ChallengeMode.GetOverallDungeonScore(); --Total score same as new score.
			C_Timer.After(2, function()
				NIT:recordKeystoneData();
			end)
		end
		RequestRaidInfo();
	elseif (event == "CHAT_MSG_LOOT") then
		NIT:chatMsgLoot(...)
	elseif (event == "ITEM_CHANGED") then
		NIT:debug("item changed");
		C_Timer.After(1, function()
			NIT:recordKeystoneData();
		end)
	elseif (event == "CHALLENGE_MODE_MAPS_UPDATE") then
		C_Timer.After(1, function()
			NIT:challengeModeMapsUpdate();
		end)
	elseif (event == "WEEKLY_REWARDS_UPDATE" or event == "UPDATE_INSTANCE_INFO") then
		--Some issues with speed of update after looting vault.
		C_Timer.After(1, function()
			NIT:recordKeystoneData();
		end)
		C_Timer.After(5, function()
			NIT:checkRewards();
		end)
		C_Timer.After(1, function()
			NIT:recordLockoutData();
		end)
	elseif (event == "PLAYER_GUILD_UPDATE") then
		NIT:throddleEventByFunc(event, 1, "recordGuildInfo");
	end
end)

--Trim records to maxRecordsKept, can set records shown to max 500 in options, 100 is default.
function NIT:trimDatabase()
	local max = NIT.db.global.maxRecordsKept;
	for i, v in pairs(NIT.data.instances) do
		if (i > max) then
			table.remove(NIT.data.instances, i);
		end
	end
end

function NIT:trimTrades()
	local max = NIT.db.global.maxTradesKept;
	for i, v in pairs(NIT.data.trades) do
		if (i > max) then
			table.remove(NIT.data.trades, i);
		end
	end
end

function NIT:chatMsgLoot(...)
	local msg = ...;
	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType,
				itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice, itemClassID, itemSubClassID;
    --Get itemlink by checking all possible matches for self loot msgs and other players loot msg.
    --Check multiple msgs first so you dont end up with item links with x2 on the end.
    --Self receive multiple loot "You receive loot: [Item]x2"
    local amount;
    local name = UnitName("Player");
    local otherPlayer;
    --Self loot multiple item "You receive loot: [Item]x2"
	local itemLink, amount = strmatch(msg, string.gsub(string.gsub(LOOT_ITEM_SELF_MULTIPLE, "%%s", "(.+)"), "%%d", "(%%d+)"));
	if (not itemLink) then
 		--Self receive single loot "You receive loot: [Item]"
    	itemLink = msg:match(LOOT_ITEM_SELF:gsub("%%s", "(.+)"));
		if (not itemLink) then
 			--Self receive single item "You receive item: [Item]"
			itemLink = msg:match(LOOT_ITEM_PUSHED_SELF:gsub("%%s", "(.+)"));
		end
    end
    if (itemLink) then
    	if (string.match(itemLink, "|Hkeystone:(.+)|h") or string.match(itemLink, "item:180653")) then
    		C_Timer.After(1, function()
    			NIT:debug("looted keystone");
				NIT:recordKeystoneData(true);
			end)
			C_Timer.After(5, function()
				NIT:checkRewards();
			end)
			C_Timer.After(15, function()
				NIT:checkRewards();
			end)
    	end
    end
end

function NIT:combatLogEventUnfiltered(...)
	local timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, 
			destName, destFlags, destRaidFlags, _, spellName = CombatLogGetCurrentEventInfo();
	--[[if (subEvent == "SWING_DAMAGE" or subEvent == "SPELL_DAMAGE" or subEvent == "RANGE_DAMAGE") then
		if (sourceGUID and string.match(sourceGUID, "Creature")) then
			NIT:parseGUID(nil, sourceGUID, "combatlogSourceGUID");
		elseif (destGUID and string.match(destGUID, "Creature")) then
			NIT:parseGUID(nil, destGUID, "combatlogDestGUID");
		end]]
	--elseif (subEvent == "UNIT_DIED" and UnitLevel("player") == NIT.maxLevel and string.match(destGUID, "Creature")) then
	--elseif (subEvent == "UNIT_DIED" and UnitLevel("player") == NIT.maxLevel and string.match(destGUID, "Creature")) then
	if (subEvent == "UNIT_DIED" and string.match(destGUID, "Creature")) then
		--If max level player then count mobs via death instead of xp.
		local _, _, _, _, zoneID, npcID = strsplit("-", destGUID);
		npcID = tonumber(npcID);
		if (NIT.critterCreatures[npcID]) then
			return;
		end
		NIT:countMobsFromKill(npcID);
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
	if (xpGained) then
		if (LOCALE_koKR) then
			xpGained = string.match(text, "(%d+)의 경험치");
		end
		if (NIT.inInstance and NIT.data.instances[1]) then
			NIT.data.instances[1].xpFromChat = NIT.data.instances[1].xpFromChat + xpGained;
			if (NIT.data.instances[1].isPvp) then
				return;
			end
			NIT.data.instances[1].mobCount = NIT.data.instances[1].mobCount + 1;
		end
	else
		NIT:debug("Missing xp match:" ..  text);
	end
	currentXP = (UnitXP("player") or 0);
	maxXP = (UnitXPMax("player") or 0);
end

function NIT:countMobsFromKill(npcID)
	if (NIT.inInstance and NIT.data.instances[1]) then
		if (NIT.data.instances[1].isPvp) then
			return;
		end
		--NIT.data.instances[1].mobCount = NIT.data.instances[1].mobCount + 1;
		--Starting in this version we count mobs from the combat log even seperately as a backup.
		--And check both counts in the display, count from xp first, if no xp then check from death event.
		--This is to detect grey mobs dying from boosters that aren't NIT.maxLevel (70).
		NIT.data.instances[1].mobCountFromKill = NIT.data.instances[1].mobCountFromKill + 1;
	end
end

function NIT:chatMsgMoney(...)
	local text = ...;
	if (NIT.inInstance and NIT.data.instances[1]) then
		if (NIT.data.instances[1].isPvp) then
			return;
		end
		local copperGained = string.match(text, string.gsub(COPPER_AMOUNT, "%%d", "(%%d+)")) or 0;
		local silverGained = string.match(text, string.gsub(SILVER_AMOUNT, "%%d", "(%%d+)")) or 0;
		local goldGained = string.match(text, string.gsub(GOLD_AMOUNT, "%%d", "(%%d+)")) or 0;
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
	--The above line doesn't work on RU clients due to declensions.
	if (LOCALE_ruRU and not repName or not repAmount) then
		--With declension.
		--Отношение |3-7(%s) к вам улучшилось на %d.
		repName, repAmount = string.match(text, "Отношение |3%-7%((.+)%) к вам улучшилось на (%d+).");
		if (LOCALE_ruRU and not repName or not repAmount) then
			--Without declension as a backup just incase.
			repName, repAmount = string.match(text, "Отношение (.+) к вам улучшилось на (%d+).");
		end
	end
	--Faction decrease.
	if (not repName or not repAmount) then
		repName, repAmount = string.match(text, string.gsub(string.gsub(FACTION_STANDING_DECREASED, "%%s", "(.+)"), "%%d", "(%%d+)"));
		decrease = true;
		if (LOCALE_ruRU and not repName or not repAmount) then
			--With Declension.
			--Отношение |3-7(%s) к вам ухудшилось на %d.
			repName, repAmount = string.match(text, "Отношение |3%-7%((.+)%) к вам ухудшилось на (%d+).");
			if (LOCALE_ruRU and not repName or not repAmount) then
				--Without Declension as a backup just incase.
				repName, repAmount = string.match(text, "Отношение (.+) к вам ухудшилось на (%d+).");
			end
		end
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

--Pre cata honor recording.
function NIT:chatMsgCombatHonorGain(...)
	if (not NIT.inInstance or NIT.data.instances[1].type ~= "bg") then
		return;
	end
	if (not NIT.data.instances[1].honor) then
		NIT.data.instances[1].honor = 0;
	end
	local text = ...;
	local honorGained;
	if (string.match(text, "%d+%.%d+")) then
		--Decimal in cata.
		honorGained = string.match(text, "%d+%.%d+");
	else
		honorGained = string.match(text, "%d+");
	end
	if (not honorGained) then
		NIT:debug("Honor error:", text);
		return;
	end
	--NIT:debug("Honor Gained:", honorGained);
	NIT.data.instances[1].honor = NIT.data.instances[1].honor + honorGained;
end

function NIT:calcRecordedHonor(logID, useData)
	local data;
	if (logID) then
		data = NIT.data.instances[logID];
	else
		data = useData;
	end
	if (not data or not data.honor) then
		return 0;
	end
	if (usePreHonor and NIT.inInstance and data.preHonor and logID == 1 and data.type == "bg") then
		local honor = C_CurrencyInfo.GetCurrencyInfo(1901);
		if (honor) then
			return NIT:round(honor.quantity - data.preHonor);
		else
			return NIT:round(data.honor);
		end				
	elseif (data.preHonor and data.postHonor) then
		return NIT:round(data.postHonor - data.preHonor);
	else
		return NIT:round(data.honor);
	end
end

--Cata and onwards honor recording, new event added.
function NIT:chatMsgCurrency(...)
	if (not NIT.inInstance) then
		return;
	end
	local text = ...;
	if (not strmatch(text, "currency:")) then
		return;
	end
	local currencyID = tonumber(strmatch(text, "currency:(%d+):"));
	local instance = NIT.data.instances[1];
	if (currencyID == 1901 and instance.type == "bg") then
		--Doesn't work right in cata becaus the currency msgs don't work for bonus honor at the end of a bg.
		--[[local amount = strmatch(text, "currency:.+\]|h|r%D*(%d+)");
		if (not amount) then
			NIT:debug("Honor error:", text);
			return;
		end
		if (not instance.honor) then
			instance.honor = 0;
		end
		instance.honor = instance.honor + amount;
		NIT:debug("Honor Gained2:", amount);]]
	else
		--Don't judge my string matching.
		local amount = strmatch(text, "currency:.+\]|h|r%D*(%d+)");
		if (not amount) then
			NIT:debug("Currency error:", text);
			return;
		end
		local data = C_CurrencyInfo.GetCurrencyInfo(currencyID);
		if (not instance.currencies) then
			instance.currencies = {};
		end
		if (not instance.currencies[currencyID]) then
			instance.currencies[currencyID] = {
				count = 0;
			};
		end
		instance.currencies[currencyID] = {
			name = data.name,
			count = instance.currencies[currencyID].count + amount,
			icon = data.iconFileID,
		}; --/run NIT.data.instances[1].currencies[395] = {name = "Justice Points", count = 5, icon = 463446}
	end
end

function NIT:playerEnteringWorld(...)
	local isLogon, isReload = ...;
	--On rare occasions you PLAYER_ENTERING_WORLD as a ghost still instead of unghosting beforehand.
	local isInstance, instanceType = IsInInstance();
	if (isInstance) then
		if (isReload) then
			C_Timer.After(0.5, function()
				NIT:enteredInstance(true);
			end)
		elseif (isLogon) then
			C_Timer.After(0.5, function()
				NIT:enteredInstance(nil, true);
			end)
		else
			C_Timer.After(0.5, function()
				if (isInstance) then
					NIT:enteredInstance();
				end
			end)
		end
	elseif (NIT.inInstance and not isReload) then
		NIT:leftInstance();
	end
end

function NIT:playerLeavingWorld(...)
	--Moved to PEW, some people had a chat reconnect delay that stopped the stats working.
	--if (NIT.inInstance) then
		--NIT:leftInstance();
	--end
end

function NIT:playerLogout(...)
	if (NIT.inInstance) then
		NIT:leftInstance();
	end
end

function NIT:recordBgStats()
	if (not NIT.inInstance) then
		return;
	end
	local instance = NIT.data.instances[1];
	local totalPlayers = GetNumBattlefieldScores();
	--local mapID = C_Map.GetBestMapForUnit("player");
	if (NIT.data.instances[1].type == "bg") then
		for i = 1, totalPlayers do
			local name, kb, hk, deaths, honor, faction, rank, race, class, classEnglish, damage, healing = GetBattlefieldScore(i);
			--local rankName, rankNumber = GetPVPRankInfo(rank, faction);
			--Record me only.
			local me = UnitName("player");
			if (name == me) then
				instance.kb = kb;
				instance.hk = hk;
				instance.deaths = deaths;
				--instance.bonusHonor = honor;
				instance.faction = faction;
				--instance.classEnglish = classEnglish;
				instance.damage = damage;
				instance.healing = healing;
				local objectives = {};
				if (GetNumBattlefieldStats) then
					for j = 1, GetNumBattlefieldStats() do
						local score = GetBattlefieldStatData(i, j);
						if (score and score > 0) then
							local text, icon = GetBattlefieldStatInfo(j);
							--Icons textures end in 0 or 1 for each faction.
							--We want to display the right color for our real faction and not same faction vs same faction wrong side.
							--[[if (NIT.faction == "Horde") then
								icon = icon .. "1";
							else
								icon = icon .. "0";
							end]]
							icon = icon .. faction;
							local t = {
								score = score,
								text = text,
								icon = icon,
							};
							table.insert(objectives, t);
							--/run NIT.data.instances[1].objectives = {}
							--/run NIT.data.instances[1].objectives[1] = {score = 3,text = "Flag Captures",icon = "Interface\\WorldStateFrame\\ColumnIcon-FlagCapture0"};
						end
					end
				end
				if (next(objectives)) then
					instance.objectives = objectives;
				end
			end
		end
		if (GetBattlefieldWinner() == 0) then
			--Horde won.
			instance.winningFaction = 0;
		elseif (GetBattlefieldWinner() == 1) then
			--Alliance won.
			instance.winningFaction = 1;
		end
	elseif (NIT.data.instances[1].type == "arena") then
		local purpleTeam, goldTeam = {}, {};
		for i = 1, totalPlayers do
			local name, kb, hk, deaths, honor, faction, rank, race, class, classEnglish, damage, healing = GetBattlefieldScore(i);
			--Record all players.
			local me = UnitName("player");
			if (name) then
				local t = {
					kb = kb,
					faction = faction,
					class = classEnglish,
					damage = damage,
					healing = healing,
					race = race,
				};
				local teamName, teamRating, newTeamRating, teamMMR = GetBattlefieldTeamInfo(faction);
				--if (NIT.isTBC) then
					if (teamName) then
						t.teamName = teamName;
					end
					if (teamRating) then
						t.teamRating = teamRating;
					end
					if (newTeamRating) then
						t.newTeamRating = newTeamRating;
					end
				--end
				if (teamMMR) then
					t.teamMMR = teamMMR;
				end
				if (faction == 0) then
					if (teamName == "" and instance.purpleTeam and instance.purpleTeam[name] and instance.purpleTeam[name].teamName) then
						--If team name is showing an empty string but we already have a team name recorded then use the already recorded name instead and don't overwrite.
						t.teamName = instance.purpleTeam[name].teamName;
					end
					purpleTeam[name] = t;
				else
					if (teamName == "" and instance.goldTeam and instance.goldTeam[name] and instance.goldTeam[name].teamName) then
						t.teamName = instance.goldTeam[name].teamName;
					end
					goldTeam[name] = t;
				end
				if (name == me) then
					instance.faction = faction;
				end
			end
		end --/tinspect NIT.data.instances[1]
		if (GetBattlefieldWinner() == 0) then
			--Purple team won.
			instance.winningFaction = 0;
		elseif (GetBattlefieldWinner() == 1) then
			--Gold team won.
			instance.winningFaction = 1;
		end
		--No winner name means a draw.
		local drawName;
		--I've seen one time GetBattlefieldWinner() be nil when not a draw so had to add a check here.
		if (GetBattlefieldWinner()) then
			local drawName = GetBattlefieldTeamInfo(GetBattlefieldWinner());
			if (not drawName) then
				instance.draw = true;
			end
		end
		if (next(purpleTeam)) then
			instance.purpleTeam = purpleTeam;
		end
		if (next(goldTeam)) then
			instance.goldTeam = goldTeam;
		end
	end
	--instance.pvpStats = stats;
	NIT:recordGroupInfo();
end
if (NIT.expansionNum < 4) then
	hooksecurefunc("WorldStateScoreFrame_OnShow", function(...) NIT:recordBgStats() end);
end

--Seems to be some issue with it not recording as an arena if we check before the zone data is upedated properly in blizz's end?
local function doubleCheckArena()
	if (NIT.isTBC and NIT.inInstance) then
		if (NIT:isInArena()) then
			NIT.data.instances[1].type = "arena";
		end
	end
end

--This frame is only used for same instance detection and disabled after first event after entering.
--Changed to it's own frame for disabling to see if it makes a performance difference.
local instanceDetectionFrame = CreateFrame("Frame");
instanceDetectionFrame:SetScript('OnEvent', function(self, event, ...)
	local _, subEvent, _, sourceGUID, _, _, _, destGUID = CombatLogGetCurrentEventInfo();
	if (subEvent == "SWING_DAMAGE" or subEvent == "SPELL_DAMAGE" or subEvent == "RANGE_DAMAGE") then
		if (sourceGUID and string.match(sourceGUID, "Creature")) then
			NIT:parseGUID(nil, sourceGUID, "combatlogSourceGUID");
			instanceDetectionFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		elseif (destGUID and string.match(destGUID, "Creature")) then
			NIT:parseGUID(nil, destGUID, "combatlogDestGUID");
			instanceDetectionFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		end
	end
end)

--No API available to get alpha/beta/gamma difficulty yet.
--[[local function getDungeonSubDifficulty()
	if (IsInInstance()) then
		local diff;
		--wtb dungeon api for these new difficulties.
		NIT:print("Getting dungeon difficulty:", diff);
		return diff;
	end
end

function NIT:updateCurrentDungeonSubDifficulty()
	if (IsInInstance()) then
		local diff = getDungeonSubDifficulty();
		if (diff) then
			NIT.data.instances[1].subDifficulty = diff;
			NIT:debug("Updated dungeon sub difficulty.");
		end
	end
end]]

--Get dungeon sub difficulty by scanning npc buffs instead.
local subDiffculties = {
	--Gamma dungs.
	[424205] = "gamma", --Gamma Empowered: Titan Rune
	[424203] = "gamma", --Gamma Empowered: Blood Rune
	[424210] = "gamma", --Gamma Empowered: Plague Rune
	[424196] = "gamma", --Gamma Empowered: Arcane Rune
	[424211] = "gamma", --Gamma Empowered: Gladiator Rune
	[424194] = "gamma", --Gamma Empowered: Frost Rune
	[424201] = "gamma", --Gamma Empowered: Shadow Rune
	--Beta dungs.
	[413573] = "beta", --Beta Empowered: Gladiator Rune
	[412770] = "beta", --Beta Empowered: Frost Rune
	[412991] = "beta", --Beta Empowered: Arcane Rune
	[412867] = "beta", --Beta Empowered: Plague Rune
	[413169] = "beta", --Beta Empowered: Blood Rune
	[412470] = "beta", --Beta Empowered: Shadow Rune
	--Alpha dungs.
	[394441] = "alpha", --Alpha Empowered: Titan Rune
	[392430] = "alpha", --Alpha Empowered: Frost Rune
	[394444] = "alpha", --Alpha Empowered: Plague Rune
	[394435] = "alpha", --Alpha Empowered: Arcane Rune
	[394437] = "alpha", --Alpha Empowered: Shadow Rune
	[394438] = "alpha", --Alpha Empowered: Blood Rune
};
function NIT:scanDungeonSubDifficulty()
	--Only scan once if we found it.
	if (NIT.inInstance and not NIT.data.instances[1].subDifficulty) then
		local found;
		local guid = UnitGUID("target");
		if (guid and string.match(guid, "Creature")) then
			for i = 1, 10 do
				local name, _, _, _, _, _, _, _, _, spellID = UnitBuff("target", i);
				if (name) then
					if (subDiffculties[spellID]) then
						NIT.data.instances[1].subDifficulty = subDiffculties[spellID];
						NIT:debug("Updated dungeon sub difficulty:", subDiffculties[spellID]);
						found = true;
					elseif (string.match(name, "Gamma Empowered: %w+ Rune")) then
						--English backups so if they add more it will atleast work for english client without updates.
						NIT.data.instances[1].subDifficulty = "gamma";
						found = true;
					elseif (string.match(name, "Beta Empowered: %w+ Rune")) then
						NIT.data.instances[1].subDifficulty = "beta";
						found = true;
					elseif (string.match(name, "Alpha Empowered: %w+ Rune")) then
						NIT.data.instances[1].subDifficulty = "alpha";
						found = true;
					end
				else
					break;
				end
			end
		end
		if (found and NIT.data.instances[1].subDifficulty == "gamma" and NIT.db.global.autoGammaBuffReminder)then
			--If we don't have a buff already then remind us, should only fire once per dung.
			local hasBuff;
			local gammaBuffs = {
				[424400] = true, --Melee.
				[424403] = true, --Ranged.
				[424405] = true, --Healer.
				[424407] = true, --Tank.
			};
			for i = 1, 32 do
				local _, _, _, _, _, _, _, _, _, spellID = UnitBuff("player", i);
				if (spellID) then
					if (gammaBuffs[spellID]) then
						hasBuff = true;
						break;
					end
				else
					break;
				end
			end
			if (not hasBuff) then
				local npcType;
				if (NIT.faction == "Horde") then
					npcType = L["Sunreaver Warden"];
				else
					npcType = L["Silver Covenant Warden"];
				end
				NIT:print("|cFF00FF00" .. string.format(L["autoGammaBuffReminder"], npcType), nil, "[NIT Reminder]");
				local colorTable = {r = 1, g = 0.96, b = 0.41, id = 41, sticky = 0};
				RaidNotice_AddMessage(RaidWarningFrame, NIT.prefixColor .. "[NIT Reminder]:|r |cFF00FF00" .. string.format(L["autoGammaBuffReminder"], npcType), colorTable, 6);
			end
		end
	end
end

--[[function test()
	local npcType;
	if (NIT.faction == "Horde") then
		npcType = L["Sunreaver Warden"];
	else
		npcType = L["Silver Covenant Warden"];
	end
	NIT:print("|cFF00FF00" .. string.format(L["autoGammaBuffReminder"], npcType), nil, "[NIT Reminder]");
	local colorTable = {r = 1, g = 0.96, b = 0.41, id = 41, sticky = 0};
	RaidNotice_AddMessage(RaidWarningFrame, NIT.prefixColor .. "[NIT Reminder]:|r |cFF00FF00" .. string.format(L["autoGammaBuffReminder"], npcType), colorTable, 6);
end]]

local isGhost = false;
NIT.lastInstanceName = "(Unknown Instance)";
local doneFirstGUIDCheck;
function NIT:enteredInstance(isReload, isLogon, checkAgain)
	doGUID = true;
	local instance, instanceType = IsInInstance();
	local type;
	--instanceType was showing "pvp" at the start of tbc, now it shows "arena".
	--Leave some redunant checks here in place anyway incase it ever reverts back.
	if (instanceType == "pvp" or instanceType == "arena") then
		if (NIT:isInArena() or instanceType == "arena") then
			type = "arena";
		elseif (UnitInBattleground("player")) then
			type = "bg";
		end
		if (not type and not checkAgain) then
			--Sometimes UnitInBattleground() is slow to return true after PEW.
			--So recheck after a couple of seconds if we're in a pvp instance and both arena and bg wern't found.
			NIT:debug("PvP type not found, rechecking.");
			C_Timer.After(2, function()
				NIT:enteredInstance(isReload, isLogon, true);
			end)
			return;
		end
	end
	if (checkAgain) then
		NIT:debug("Rechecked Instance:", instance, "Type:", instanceType, NIT:isInArena(), UnitInBattleground("player"));
	end
	if (instance == true and ((instanceType == "party") or (instanceType == "raid")
			or (type == "bg") or (type == "arena"))) then
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
		local instanceNameMsg = instanceName;
		if (difficultyID == 174) then
			instanceNameMsg = instanceNameMsg .. " |cFF9CD6DE(|r|cFFFF2222H|r|cFF9CD6DE)|r";
		end
		if (isGhost) then
			--This never worked and doesn't need to anyway.
			--if (NIT.db.global.enteredMsg) then
			--	local texture = "|TInterface\\AddOns\\NovaInstanceTracker\\Media\\greenTick:12:12:0:0|t";
				--NIT:print("Entered " .. instanceName .. " as ghost, not recording new instance. "
				--		.. "If you would like to force record a new instance click |HNITCustomLink:deletelast|h" .. texture .. "|h");
			--end
		else
			if (not isReload) then
				local class, classEnglish = UnitClass("player");
				local t = {
					playerName = UnitName("player"),
					class = class,
					classEnglish = classEnglish,
					instanceName = instanceName,
					instanceID = instanceID,
					difficultyID = difficultyID,
					type = type,
					enteredTime = GetServerTime(),
					enteredLevel = UnitLevel("player");
					enteredXP = UnitXP("player");
					enteredMoney = GetMoney(),
					leftTime = 0,
					leftMoney = 0,
					mobCount = 0,
					mobCountFromKill = 0,
					rawMoneyCount = 0,
					xpFromChat = 0,
					group = {},
					rep = {},
				};
				--No API available to get alpha/beta/gamma difficulty yet.
				--t.subDifficulty = getDungeonSubDifficulty();
				if (type == "bg") then
					t.honor = 0;
					if (usePreHonor) then
						local honor = C_CurrencyInfo.GetCurrencyInfo(1901);
						if (honor) then
							t.preHonor = honor.quantity;
						end
					end
				end
				if (type == "bg" or type == "arena") then
					t.isPvp = true;
				end
				if (t.isPvp) then
					--No need to store certain things for pvp instances.
					t.difficultyID = nil;
					--t.enteredLevel = nil;
					--t.enteredXP = nil;
					t.enteredMoney = nil;
					t.rawMoneyCount = nil;
					--t.xpFromChat = nil;
					t.mobCount = nil;
					--t.mobCountFromKill = nil;
					C_Timer.After(2, function()
						doubleCheckArena();
					end)
				end
				--NIT:debug("entered", UnitLevel("player"));
				--if (NIT.isDebug) then
				--	t.GUIDList = {};
				--end
				--This should really be called noLockout instead of raid but not changing it or the local string now.
				local raid;
				if (NIT.noRaidLockouts and instanceID and NIT.zones[instanceID] and NIT.zones[instanceID].noLockout) then
					raid = true;
				end
				--Insert as first row, instances are stored newest first in the data table.
				table.insert(NIT.data.instances, 1, t);
				local texture = "|TInterface\\AddOns\\NovaInstanceTracker\\Media\\redX2:12:12:0:0|t";
				local hourCount, hourCount24, hourTimestamp, hourTimestamp24 = NIT:getInstanceLockoutInfo();
				local countMsg = "(" .. NIT.prefixColor .. hourCount .. "|r" .. NIT.chatColor .. " " .. L["thisHour"] .. ")";
				if (t.isPvp) then
					if (NIT.db.global.pvpEnteredMsg) then
						local msg = string.format(L["enteredDungeon"], instanceNameMsg, "");
						msg = string.gsub(msg, " , ", ", ")
						C_Timer.After(0.5, function()
							--local hourCount, hourCount24, hourTimestamp, hourTimestamp24 = NIT:getInstanceLockoutInfo();
							NIT:print("|HNITCustomLink:instancelog|h" .. msg .. "|h "
									.. "|HNITCustomLink:deletelast|h" .. texture
									.. "|h |HNITCustomLink:instancelog|h" .. L["enteredDungeon2"] .. "|h");
						end)
					end
				elseif (raid) then
					if (NIT.db.global.raidEnteredMsg) then
						C_Timer.After(0.5, function()
							NIT:print("|HNITCustomLink:instancelog|h" .. string.format(L["enteredRaid"], instanceNameMsg) .. "|h");
						end)
					end
				elseif (isLogon) then
					C_Timer.After(3, function()
						--local hourCount, hourCount24, hourTimestamp, hourTimestamp24 = NIT:getInstanceLockoutInfo();
						NIT:print("|HNITCustomLink:instancelog|h" .. string.format(L["loggedInDungeon"], instanceNameMsg, countMsg) .. "|h "
								.. " |HNITCustomLink:deletelast|h" .. texture
								.. "|h |HNITCustomLink:instancelog|h " .. L["loggedInDungeon2"] .. "|h");
					end)
				else
					if (NIT.db.global.enteredMsg) then
						C_Timer.After(0.5, function()
							--local hourCount, hourCount24, hourTimestamp, hourTimestamp24 = NIT:getInstanceLockoutInfo();
							NIT:print("|HNITCustomLink:instancelog|h" .. string.format(L["enteredDungeon"], instanceNameMsg, countMsg) .. "|h "
									.. "|HNITCustomLink:deletelast|h" .. texture
									.. "|h |HNITCustomLink:instancelog|h" .. L["enteredDungeon2"] .. "|h");
						end)
					end
				end
				--Changed to when targeting a mob at start of dung.
				--[[if (t.subDifficulty == "gamma" and NIT.db.global.autoGammaBuffReminder) then
					C_Timer.After(3, function()
						NIT:print("|cFF00FF00Gamma Dungeon:|r " .. L["autoGammaBuffReminder"]);
					end)
				end]]
			elseif (isReload) then
				C_Timer.After(3, function()
					local texture = "|TInterface\\AddOns\\NovaInstanceTracker\\Media\\redX2:12:12:0:0|t";
					local hourCount, hourCount24, hourTimestamp, hourTimestamp24 = NIT:getInstanceLockoutInfo();
					local countMsg = "(" .. NIT.prefixColor .. hourCount .. NIT.chatColor .. " " .. L["thisHour"] .. ")";
					NIT:print(string.format(L["reloadDungeon"], countMsg));
				end)
			end
			C_Timer.After(0.5, function()
				NIT.inInstance = GetServerTime();
			end)
			--NIT.lastInstanceID = #NIT.data.instances + 1;
			--NIT.data.instances[NIT.lastInstanceID] = t;
			NIT.currentInstanceID = instanceID;
			isGhost = false;
			NIT:trimDatabase();
			NIT:addInstanceCount(instanceID);
			local type = "unknown";
			if (instanceID and NIT.zones[instanceID] and NIT.zones[instanceID].type) then
					type = NIT.zones[instanceID].type;
			end
			NIT:pushInstanceEntered(instanceName, instanceID, type, isReload, isLogon);
			doneFirstGUIDCheck = nil;
			instanceDetectionFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		end
		C_Timer.After(1, function()
			NIT:recordGroupInfo();
		end)
		C_Timer.After(30, function()
			NIT:recordGroupInfo();
		end)
	end
end

function NIT:leftInstance()
	if (NIT.inInstance and NIT.data.instances[1]) then
		local isPvp = NIT.data.instances[1].isPvp
		NIT.data.instances[1]["leftTime"] = GetServerTime();
		if (isPvp) then
			if (usePreHonor and NIT.data.instances[1].type == "bg") then
				local honor = C_CurrencyInfo.GetCurrencyInfo(1901);
				if (honor) then
					NIT.data.instances[1].postHonor = honor.quantity;
				end
			end
		else
			NIT.data.instances[1]["leftLevel"] = UnitLevel("player");
			NIT.data.instances[1]["leftXP"] = UnitXP("player");
			NIT.data.instances[1]["leftMoney"] = GetMoney();
		end
		--NIT:debug("left", UnitLevel("player"));
		--Don't show party stats if bg or arena, only self.
		if (not isPvp or NIT.db.global.instanceStatsOutputWhere == "self") then
			NIT:showInstanceStats();
		end
		NIT:pushInstanceLeft(NIT.data.instances[1].instanceName, NIT.data.instances[1].instanceID);
	end
	C_Timer.After(5, function()
		NIT:recordKeystoneData();
	end)
	NIT.inInstance = nil;
	NIT.currentInstanceID = 0;
	NIT.lastNpcID = 999999999;
	NIT.lastInstanceName = "(Unknown Instance)";
	if (NITAUTORESET) then
		if (NIT.data.instances[1] and NIT.data.instances[1].mobCount and NIT.data.instances[1].mobCount > 10) then
			C_Timer.After(2, function()
				if (UnitIsGroupLeader("player") and not IsInInstance() and not UnitIsGhost("player")) then
					local msg = "Auto resetting dungeons.";
					if (IsInGroup()) then
			  			NIT:sendGroup("[NIT] " .. msg);
					else
						NIT:print(NIT.prefixColor .. msg);
					end
					ResetInstances();
				end
			end)
		end
	end
end

function NIT:showInstanceStats(id, output, showAll, customPrefix, showDate)
	if (not id) then
		id = 1;
	end
	if (not NIT.data.instances[id]) then
		NIT:print(string.format(L["statsError"], id));
		return;
	end
	local data = NIT.data.instances[id];
	local level = data.enteredLevel or UnitLevel("player");
	local timeSpent = "";
	local timeSpentRaw = 0;
	local nonClickable;
	if (data.enteredTime and data.leftTime and data.enteredTime > 0 and data.leftTime > 0) then
		timeSpentRaw = data.leftTime - data.enteredTime;
	elseif (data.enteredTime and data.leftTime and data.enteredTime > 0 and (GetServerTime() - data.enteredTime) < 21600
			--Make sure we're not checking /nit stats while still inside an instance we have re-entered and recorded a leave time.
			and not NIT.inInstance) then
		timeSpentRaw = GetServerTime() - data.enteredTime;
	end
	if ((not data.leftTime or data.leftTime == 0) or NIT.inInstance) then
		timeSpent = NIT:getTimeString(GetServerTime() - data.enteredTime, true, true);
	else
		timeSpent = NIT:getTimeString(data.leftTime - data.enteredTime, true, true);
	end
	--local timeSpent = NIT:getTimeString(data.leftTime - data.enteredTime, true, true);
	--UnitLevel("player") == NIT.maxLevel
	--local pColor, sColor = "|cFF9CD6DE", "|cFFc3e6eb";
	local pColor, sColor = "|cFFFFFFFF", "|cFF9CD6DE";
	--local text = "(" .. NIT.lastInstanceName .. ")";
	--local text = pColor;
	--local text = sColor .. NIT.lastInstanceName;
	local text = sColor .. data.instanceName .. "|r";
	if (data.subDifficulty) then
		text = sColor .. data.instanceName .. " (|cFFFF2222" .. gsub(data.subDifficulty, "^%l", string.upper) .. "|r)|r"; 
	end
	local mobCount = 0;
	local money = 0;
	if (showDate) then
		local dateString;
		local useTime = data.enteredTime;
		if (data.leftTime and data.leftTime > 0) then
			useTime = data.leftTime;
		end
		if (GetServerTime() - useTime < 86400) then
			--If within last 24h then show as time ago instead of date.
			local timeAgo = GetServerTime() - useTime;
			dateString = "|cFFFFFFFF(" .. NIT:getTimeString(timeAgo, true, "short") .. " " .. L["ago"] .. ")|r";
		else
			dateString = "|cFFFFFFFF(" .. NIT:getTimeFormat(useTime, true, true) .. ")|r";
		end
		text = dateString .. " " .. text;
	end
	if (data.isPvp) then
		if (data.type == "bg") then
			text = text .. pColor .. " " .. L["Honor"] .. ":|r " .. sColor .. NIT:calcRecordedHonor(nil, data) .. "|r";
			if (NIT.db.global.instanceStatsOutputHK) then
				text = text .. pColor .. " " .. L["HKs"] .. ":|r " .. sColor .. (data.hk or 0) .. "|r";
			end
		end
		if (not NIT.isClassic and not NIT.isTBC and data.type ~= "arena") then
			if ((NIT.db.global.instanceStatsOutputXP or showAll) and level ~= NIT.maxLevel) then
				text = text .. pColor .. " " .. L["statsXP"] .. "|r " .. sColor .. NIT:commaValue(data.xpFromChat) .. "|r";
			end
		end
	else
		--Check both count from xp and count from combat log event.
		--So it works for boosters that mobs are grey and people out of range of combat event but still get xp.
		if (data.mobCount and data.mobCount > 0) then
			mobCount = data.mobCount;
		elseif (data.mobCountFromKill and data.mobCountFromKill > 0) then
			mobCount = data.mobCountFromKill;
		end
		if (NIT.db.global.instanceStatsOutputMobCount or showAll) then
			--text = text .. " |cFF9CD6DEMobs: " .. data.mobCount;
			text = text .. pColor .. " " .. L["statsMobs"] .. "|r " .. sColor .. mobCount .. "|r";
		end
		if ((NIT.db.global.instanceStatsOutputXP or showAll) and level ~= NIT.maxLevel) then
			text = text .. pColor .. " " .. L["statsXP"] .. "|r " .. sColor .. NIT:commaValue(data.xpFromChat) .. "|r";
		end
		if ((NIT.db.global.instanceStatsOutputXpPerHour or showAll) and level ~= NIT.maxLevel) then
			if (timeSpentRaw and timeSpentRaw > 0 and tonumber(data.xpFromChat) and data.xpFromChat > 0) then
				local xpPerHour = NIT:commaValue(NIT:round((tonumber(data.xpFromChat) / timeSpentRaw) * 3600));
				text = text .. pColor .. " " .. L["experiencePerHour"] .. ":|r " .. sColor .. xpPerHour .. "|r";
			end
		end
		if ((NIT.db.global.instanceStatsOutputAverageXP or showAll) and level ~= NIT.maxLevel) then
			--if (data.xpFromChat and data.xpFromChat > 0 and data.mobCount and data.mobCount > 0) then
			if (data.xpFromChat and data.xpFromChat > 0) then
				local averageXP = data.xpFromChat / mobCount;
				text = text .. pColor .. " " .. L["statsAverageXP"] .. "|r " .. sColor .. NIT:commaValue(NIT:round(averageXP, 2)) .. "|r";
			else
				text = text .. pColor .. " " .. L["statsAverageXP"] .. "|r " .. sColor .. "0|r";
			end
		end
	end
	if (NIT.db.global.instanceStatsOutputTime or showAll) then
		text = text .. pColor .. " " .. L["statsTime"] .. "|r " .. sColor .. timeSpent .. "|r";
	end
	if (not data.isPvp) then
		if ((NIT.db.global.instanceStatsOutputAverageGroupLevel or showAll) and data.groupAverage) then
			text = text .. pColor .. " " .. L["statsAverageGroupLevel"] .. "|r " .. sColor .. NIT:round(data.groupAverage, 2) .. "|r";
		end
		--Don't send gold to group chat.
		if ((NIT.db.global.instanceStatsOutputGold and NIT.db.global.instanceStatsOutput ~= "group") or showAll) then
			if (data.rawMoneyCount and data.rawMoneyCount > 0) then
				money = data.rawMoneyCount;
			elseif (data.enteredMoney and data.leftMoney and data.enteredMoney > 0 and data.leftMoney > 0) then
				--Backup for people with addons installed using an altered money string.
				money = data.leftMoney - data.enteredMoney;
			end
			text = text .. pColor .. " " .. L["statsGold"] .. "|r " .. sColor .. NIT:convertMoney(money, true, "", true, sColor) .. "|r";
		end
		if (id == 1 and data.xpFromChat and data.xpFromChat > 0) then
			if (currentXP == 0) then
				currentXP = (UnitXP("player") or 0);
			end
			if (maxXP == 0) then
				maxXP = (UnitXPMax("player") or 0);
			end
			--Will add rested xp left calcs in to this later.
			--local restedXP = (GetXPExhaustion() or 0);
			--local percent = NIT:round((data.xpFromChat/maxXP) * 100);
			local runsPerLevel = NIT:round(maxXP / data.xpFromChat, 1);
			local runsToLevel = NIT:round((maxXP - currentXP) / data.xpFromChat, 1);
			if ((NIT.db.global.instanceStatsOutputRunsPerLevel or showAll) and runsPerLevel > 0) then
				text = text .. pColor .. " " .. L["statsRunsPerLevel"] .. "|r " .. sColor .. runsPerLevel .. "|r";
			end
			if ((NIT.db.global.instanceStatsOutputRunsNextLevel or showAll) and runsToLevel > 0) then
				text = text .. pColor .. " " .. L["statsRunsNextLevel"] .. "|r " .. sColor .. runsToLevel .. "|r";
			end
		end
	end
	if (NIT.db.global.instanceStatsOutputRep or showAll) then
		local repText = "";
		if (data.rep and next(data.rep)) then
			local count = 0;
			for k, v in NIT:pairsByKeys(data.rep) do
				count = count + 1;
				if (v > 0) then
					v = "+" .. NIT:commaValue(v);
				else
					v = "-" .. NIT:commaValue(v);
				end
				if (count == 1) then
					repText = repText .. "(" .. k .. " " .. v .. ")";
				else
					repText = repText .. " (" .. k .. " " .. v .. ")";
				end
			end
		end
		if (repText ~= "") then
			text = text .. pColor .. " " .. L["statsRep"] .. "|r " .. sColor .. repText .. "|r";
		end
	end
	if (not data.isPvp and (NIT.db.global.instanceStatsOutputCurrency or showAll)) then
		local curText = "";
		if (data.currencies and next(data.currencies)) then
			local count = 0;
			local notPrint;
			if ((not output and NIT.db.global.instanceStatsOutputWhere == "group" and IsInGroup())
				or (output == "send" and NIT.db.global.instanceStatsOutputWhere == "group" and IsInGroup())
				or (output and output ~= "self" and output ~= "send")) then
				--Check if we're going to print or not to use currency textures.
				notPrint = true;
			end
			for k, v in NIT:pairsByKeys(data.currencies) do
				count = count + 1;
				local texture = "";
				if (v.icon) then
					texture = "|T" .. v.icon .. ":12:12:0:0|t ";
				end
				if (count == 1) then
					if (notPrint) then
						curText = curText .. "(+" .. v.count .. " " .. v.name .. ")";
					else
						curText = curText .. "+" .. v.count .. texture;
					end
				else
					if (notPrint) then
						curText = curText .. " (+" .. v.count .. " " .. v.name .. ")";
					else
						curText = curText .. " +" .. v.count .. texture;
					end
					if (texture ~= "") then
						--Can't have multiple textures inside a link only 1, so if we have multiple we need to make it unclickable.
						nonClickable = true;
					end
				end
			end
		end
		if (curText ~= "") then
			text = text .. pColor .. " " .. L["Currency"] .. "|r " .. sColor .. curText .. "|r";
		end
	end
	if (output) then
		local prefix = "Last Dungeon";
		if (customPrefix) then
			prefix = customPrefix;
		else
			if (NIT.inInstance and id == 1) then
				prefix = "Current Dungeon";
			end
		end
		if (output == "copypaste") then
			NIT:openNITCopyFrame("[NIT] " .. NIT:stripColors(prefix.. " " .. text));
		elseif (output == "group") then
			if (IsInGroup()) then
	  			NIT:sendGroup("[NIT] " .. NIT:stripColors(prefix.. " " .. text));
			else
				NIT:print(NIT.prefixColor .. prefix.. " " .. text, nil, nil, nonClickable);
			end
		elseif (output == "say" or output == "yell" or output == "party" or output == "guild"
			or output == "officer" or output == "raid") then
			if (output == "raid" and not IsInRaid()) then
				NIT:print("You are not in a raid.");
				return;
		  	elseif (output == "party" and not IsInGroup()) then
		  		NIT:print("You are not in a party.");
		  		return;
			end
			SendChatMessage("[NIT] " .. NIT:stripColors(prefix.. " " .. text), string.upper(output));
		elseif (output == "self") then
			NIT:print(NIT.prefixColor .. prefix.. " " .. text, nil, nil, nonClickable);
		elseif (output == "send") then
			--If no channel was specified run the normal output with added prefix.
			if (NIT.db.global.instanceStatsOutputWhere == "group") then
				if (IsInRaid()) then
					if (NIT.db.global.showStatsInRaid) then
		  				SendChatMessage("[NIT] " .. NIT:stripColors(prefix.. " " .. text), "RAID");
		  			elseif (NIT.db.global.printRaidInstead) then
		  				NIT:print(NIT.prefixColor .. prefix.. " " .. text, nil, nil, nonClickable);
		  			end
		  		elseif (IsInGroup()) then
		  			SendChatMessage("[NIT] " .. NIT:stripColors(prefix.. " " .. text), "PARTY");
				end
			else
				NIT:print(NIT.prefixColor .. prefix.. " " .. text, nil, nil, nonClickable);
			end
		end
	elseif (not NIT.db.global.statsOnlyWhenActivity or ((data.xpFromChat and data.xpFromChat > 0)
			or mobCount > 0 or tonumber(money) > 0)) then
		C_Timer.After(0.7, function()
			if (NIT.db.global.instanceStatsOutput and NIT.db.global.instanceStatsOutputWhere == "group") then
				if (IsInRaid()) then
					if (NIT.db.global.showStatsInRaid) then
		  				SendChatMessage("[NIT] " .. NIT:stripColors(text), "RAID");
		  			elseif (NIT.db.global.printRaidInstead) then
		  				NIT:print(text, nil, nil, nonClickable);
		  			end
		  		elseif (IsInGroup()) then
		  			SendChatMessage("[NIT] " .. NIT:stripColors(text), "PARTY");
				end
			elseif (NIT.db.global.instanceStatsOutput) then
				--NIT:print(text, nil, "[" .. NIT.lastInstanceName .. "]");
				NIT:print(text, nil, nil, nonClickable);
			end
		end)
	end
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
	--Don't merge pvp instances, zoneids can come from temporary pets with a creature guid.
	if (NIT.data.instances[1] and NIT.data.instances[1].isPvp) then
		return;
	end
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
		--[[if (NIT.isDebug) then
			if (not NIT.data.instances[1].GUIDList) then
				NIT.data.instances[1].GUIDList = {};
			end
			local data = (GUID or "nil");
			NIT.data.instances[1].GUIDList[data] = true;
		end]]
		NIT.lastNpcID = npcID;
		if (zoneID and zoneID > 0 and NIT.data.instances[1]) then
			---Trying a few different things here to work out some bugs.
			---The next step if these don't work will be creating NPC whitelists.

			--Only merge if current GUID isn't set (first GUID of the instance).
			if (NIT.data.instances[2] and NIT.data.instances[2]["zoneID"] and NIT.data.instances[2]["zoneID"] == zoneID
					and not NIT.data.instances[1].zoneID) then
					--and (not NIT.data.instances[1].zoneID or NIT.data.instances[1].zoneID < 1)) then
					
			--Oirignal version
			--if (NIT.data.instances[2] and NIT.data.instances[2]["zoneID"] and NIT.data.instances[2]["zoneID"] == zoneID) then
				if (NIT.db.global.detectSameInstance) then
					--NIT:debug("OldGUID:", NIT.data.instances[2].GUID, "NewGUID:", GUID, source);
					--NIT:debug("OldZoneID:", NIT.data.instances[2]["zoneID"], "NewZoneID:", zoneID, source);
					--Merge instances data and then delete last.
					NIT:mergeLastInstances(GUID, source);
					local texture = "|TInterface\\AddOns\\NovaInstanceTracker\\Media\\redX2:12:12:0:0|t";
					local hourCount, hourCount24, hourTimestamp, hourTimestamp24 = NIT:getInstanceLockoutInfo();
					local countMsg = "(" .. NIT.prefixColor .. hourCount .. "|r" .. NIT.mergeColor .. " " .. L["thisHour"] .. ")";
					C_Timer.After(0.7, function()
						local isInstance, instanceType = IsInInstance();
						if (instanceType ~= "raid" or not NIT.db.global.noRaidInstanceMergeMsg) then
							NIT:print(NIT.mergeColor .. string.format(L["sameInstance"], countMsg));
						end
					end)
				end
			elseif (NIT.lastNpcID == npcID or (not NIT.data.instances[1].zoneID or NIT.data.instances[1].zoneID < 1)) then
				--Set new zoneID if we get the same zoneid from 2 mobs in a row the same or one isn't set yet.
				NIT.data.instances[1].zoneID = zoneID;
				NIT.data.instances[1].GUID = GUID;
				NIT.data.instances[1].GUIDSource = unit or "combatLog";
				if (not doneFirstGUIDCheck) then
					if (NIT.data.instances[1]) then
						NIT:pushDifferentInstanceConfirmed(NIT.data.instances[1].instanceName, NIT.data.instances[1].instanceID)
					end
				end
			end
			doneFirstGUIDCheck = true;
		end
	end
end

--Merged countable instance data when deleting duplicate instance.
NIT.lastMerge = 0;
function NIT:mergeLastInstances(GUID, source)
	--Update static stuff with new character that entered stats.
	--[[if (NIT.isDebug) then
		if (not NIT.data.instancesDebug) then
			NIT.data.instancesDebug = {};
		end
		table.insert(NIT.data.instancesDebug, 1, NIT.data.instances[1]);
	end]]
	local class, classEnglish = UnitClass("player");
	NIT.data.instances[2].playerName = UnitName("player");
	NIT.data.instances[2].class = class;
	NIT.data.instances[2].classEnglish = classEnglish;
	NIT.data.instances[2].enteredLevel = UnitLevel("player");
	NIT.data.instances[2].enteredXP = UnitXP("player");
	NIT.data.instances[2].enteredMoney = GetMoney();
	if (not NIT.data.instances[1].isPvp) then
		NIT.data.instances[2].mobCount =  NIT.data.instances[2].mobCount + NIT.data.instances[1].mobCount;
		NIT.data.instances[2].mobCountFromKill =  NIT.data.instances[2].mobCountFromKill + NIT.data.instances[1].mobCountFromKill;
		NIT.data.instances[2].rawMoneyCount =  NIT.data.instances[2].rawMoneyCount + NIT.data.instances[1].rawMoneyCount;
		NIT.data.instances[2].xpFromChat =  NIT.data.instances[2].xpFromChat + NIT.data.instances[1].xpFromChat;
	end
	NIT.data.instances[2].oldZoneID = NIT.data.instances[1].zoneID;
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
	if (NIT.data.instances[1]) then
		NIT:pushSameInstanceConfirmed(NIT.data.instances[1].instanceName, NIT.data.instances[1].instanceID);
	end
	table.remove(NIT.data.instances, 1);
	NIT.lastMerge = GetServerTime();
end

local recordGroupInfoThroddle = 0;
function NIT:recordGroupInfo()
	if (not NIT.inInstance) then
		return;
	end
	if (NIT.data.instances[1].type == "arena") then
		--We get the group info from scoreboard in arena.
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
	local name, realm = UnitName(unit);
	if (realm and realm ~= "" and realm ~= GetRealmName()) then
	--if (NIT.data.instances[1] and NIT.data.instances[1].isPvp) then
		--if (realm) then
			name = name .. "-" .. realm;
		--end
	end
	if (name == "Unknown") then
		--Sometimes the game can't get info from a group member.
		return 0;
	end
	local class, classEnglish = UnitClass(unit);
	local guildName, guildRankName = GetGuildInfo(unit);
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
			NIT:print(string.format(L["deleteInstance"], displayNum, data.instanceName, NIT:getTimeString(timeAgo, true)));
		else
			NIT:print(string.format(L["deleteInstance"], num, data.instanceName, NIT:getTimeString(timeAgo, true)));
		end
		table.remove(NIT.data.instances, num);
		NIT:recalcInstanceLineFrames();
	else
		NIT:print(string.format(L["deleteInstanceError"], num));
	end
end

--Delete character data.
function NIT:deleteCharacter(realm, char)
	local data = NIT.db.global[realm].myChars[char];
	if (data) then
		if (char == UnitName("player")) then
			NIT.db.global[realm].myChars[char] = nil;
			NIT:print(string.format(L["deletedCharOnRealmNewInfo"], char, realm));
			NIT:recalcAltsLineFrames();
			NIT:recordCharacterData();
		else
			NIT.db.global[realm].myChars[char] = nil;
			NIT:print(string.format(L["deletedCharOnRealm"], char, realm));
			NIT:recalcAltsLineFrames();
		end
	else
		NIT:print("Error deleting " .. char .. ".")
	end
end

function NIT:getInstanceLockoutInfoString(char)
	local hourCount, hourCount24, hourTimestamp, hourTimestamp24 = NIT:getInstanceLockoutInfo(char);
	local countString = string.format(L["countString"], hourCount, hourCount24);
	local countStringColorized = NIT.chatColor
			.. string.format(L["countStringColorized"], NIT.prefixColor, hourCount, NIT.chatColor, NIT.prefixColor, hourCount24, NIT.chatColor);
	local lockoutInfo = L["now"];
	--local timeLeft24 = 86400 - (GetServerTime() - hourTimestamp24);
	--local timeLeft = 3600 - (GetServerTime() - hourTimestamp);
	--local timeLeftMax = math.max(timeLeft24, timeLeft);
	--if (GetServerTime() - hourTimestamp24 < 86400 and hourCount24 >= NIT.dailyLimit and timeLeft24 == timeLeftMax) then
	if (GetServerTime() - hourTimestamp24 < 86400 and hourCount24 >= NIT.dailyLimit and not NIT.noDailyLockout) then
		lockoutInfo = L["in"] .. " " .. NIT:getTimeString(86400 - (GetServerTime() - hourTimestamp24), true) .. " (" .. L["active24"] .. ")";
	elseif (GetServerTime() - hourTimestamp < 3600 and hourCount >= NIT.hourlyLimit) then
		lockoutInfo = L["in"] .. " " .. NIT:getTimeString(3600 - (GetServerTime() - hourTimestamp), true);
	end
	lockoutInfo = L["nextInstanceAvailable"] .. " " .. lockoutInfo;
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
	local maxCount = NIT.dailyLimit + 50;
	if (char) then
		target = char;
	end
	for k, v in ipairs(NIT.data.instances) do
		if (not NIT.perCharOnly or target == v.playerName) then
			if (v.isPvp or (NIT.noRaidLockouts and v.instanceID and NIT.zones[v.instanceID] and NIT.zones[v.instanceID].noLockout)) then
				--NIT:debug("skipping raid", v.instanceID);
			else
				count = count + 1;
				if (count > maxCount) then
				--if (count > 80) then
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
	end
	return hourCount, hourCount24, hourTimestamp, hourTimestamp24;
end

--/dump LFGRewardsFrame_EstimateRemainingCompletions(302) throne normal
--/dump LFGRewardsFrame_EstimateRemainingCompletions(324) throne heroic
--/dump LFGRewardsFrame_EstimateRemainingCompletions(300) random normal
--/dump LFGRewardsFrame_EstimateRemainingCompletions(301) random heroic
--https://warcraft.wiki.gg/wiki/LfgDungeonID
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
	--if (UnitXP("player") > 0) then
		NIT.data.myChars[char].currentXP = UnitXP("player");
	--end
	--if (UnitXPMax("player") > 0) then
		NIT.data.myChars[char].maxXP = UnitXPMax("player");
	--end
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
	elseif (genderNum == 3) then
		gender = "Female";
	end
	NIT.data.myChars[char].gender = gender;
	local guild, guildRankName = GetGuildInfo("player");
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
	NIT:recordProfessions();
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
	if (IsQuestFlaggedCompleted(9838)) then
		NIT.data.myChars[char].karaAttune = true;
	end
	if (IsQuestFlaggedCompleted(10764) or IsQuestFlaggedCompleted(10758)) then
		NIT.data.myChars[char].shatteredHallsAttune = true;
	end
	if (IsQuestFlaggedCompleted(10901)) then
		NIT.data.myChars[char].serpentshrineAttune = true;
	end
	--if (IsQuestFlaggedCompleted(10704)) then
	--	NIT.data.myChars[char].arcatrazAttune = true;
	--end
	--if (IsQuestFlaggedCompleted(10285)) then
	--	NIT.data.myChars[char].cavernsAttune = true;
	--end
	if (IsQuestFlaggedCompleted(10297) and IsQuestFlaggedCompleted(10298)) then
		NIT.data.myChars[char].blackMorassAttune = true;
	end
	if (IsQuestFlaggedCompleted(10445)) then
		NIT.data.myChars[char].hyjalAttune = true;
	end
	--if (IsQuestFlaggedCompleted(10888)) then
	--	NIT.data.myChars[char].tempestKeepAttune = true;
	--end
	if (IsQuestFlaggedCompleted(10959)) then
		NIT.data.myChars[char].blackTempleAttune = true;
	end
	if (classEnglish and classEnglish == "HUNTER") then
		NIT:recordHunterData();
	end
	NIT:recordAttunementKeys();
	NIT:recordInventoryData();
	NIT:recordLockoutData();
	NIT:recordPvpData();
	NIT:recordHonorData();
	NIT:recordArenaPoints();
	NIT:recordMarksData();
	NIT:recordCooldowns();
	NIT:recordQuests();
end

function NIT:recordGuildInfo()
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	local guild, guildRankName = GetGuildInfo("player");
	if (not guild) then
		guild = "No guild";
	end
	if (not guildRankName) then
		guildRankName = "No guild rank";
	end
	NIT.data.myChars[char].guild = guild;
	NIT.data.myChars[char].guildRankName = guildRankName;
end

--Weeklys.
local weeklyQuests = {};
if (NIT.isRetail) then
	weeklyQuests[70893] = {name = L["Feast Weekly"]};
	weeklyQuests[70866] = {name = L["Siege on Dragonbane Keep"]};
	weeklyQuests[70906] = {name = L["Grand Hunt (1st Time)"]};
	weeklyQuests[71136] = {name = L["Grand Hunt (2nd Time)"]};
	weeklyQuests[71137] = {name = L["Grand Hunt (3rd Time)"]};
	weeklyQuests[71995] = {name = L["Trial of Elements"]};
	weeklyQuests[71033] = {name = L["Trial of Flood"]};
	weeklyQuests[69927] = {name = L["World Boss (Bazual)"]};
	weeklyQuests[69928] = {name = L["World Boss (Liskanoth)"]};
	weeklyQuests[69929] = {name = L["World Boss (Strunraan)"]};
	weeklyQuests[69930] = {name = L["World Boss (Basrikron)"]};
end
if (NIT.isWrath) then
	weeklyQuests[24590] = {name = "Lord Marrowgar Must Die!", sharedCooldown = L["Wrath Raid Boss Weekly"]};
	weeklyQuests[24580] = {name = "Anub'Rekhan Must Die!", sharedCooldown = L["Wrath Raid Boss Weekly"]};
	weeklyQuests[24585] = {name = "Flame Leviathan Must Die!", sharedCooldown = L["Wrath Raid Boss Weekly"]};
	weeklyQuests[24587] = {name = "Ignis the Furnace Master Must Die!", sharedCooldown = L["Wrath Raid Boss Weekly"]};
	weeklyQuests[24582] = {name = "Instructor Razuvious Must Die!", sharedCooldown = L["Wrath Raid Boss Weekly"]};
	weeklyQuests[24589] = {name = "Lord Jaraxxus Must Die!", sharedCooldown = L["Wrath Raid Boss Weekly"]};
	weeklyQuests[24584] = {name = "Malygos Must Die!", sharedCooldown = L["Wrath Raid Boss Weekly"]};
	weeklyQuests[24581] = {name = "Noth the Plaguebringer Must Die!", sharedCooldown = L["Wrath Raid Boss Weekly"]};
	weeklyQuests[24583] = {name = "Patchwerk Must Die!", sharedCooldown = L["Wrath Raid Boss Weekly"]};
	weeklyQuests[24586] = {name = "Razorscale Must Die!", sharedCooldown = L["Wrath Raid Boss Weekly"]};
	weeklyQuests[24579] = {name = "Sartharion Must Die!", sharedCooldown = L["Wrath Raid Boss Weekly"]};
	weeklyQuests[24588] = {name = "XT-002 Deconstructor Must Die!", sharedCooldown = L["Wrath Raid Boss Weekly"]};
end

--Dailys.
local dailyQuests = {};
if (NIT.isWrath) then
	dailyQuests[78752] = {name = L["Proof of Demise: Titan Rune Protocol Gamma"]};
	dailyQuests[78753] = {name = L["Proof of Demise: Threats to Azeroth"]};
	dailyQuests[13102] = {name = "Sewer Stew", sharedCooldown = L["Wrath Cooking Daily"]};
	dailyQuests[13103] = {name = "Cheese for Glowergold", sharedCooldown = L["Wrath Cooking Daily"]};
	dailyQuests[13101] = {name = "Convention at the Legerdemain", sharedCooldown = L["Wrath Cooking Daily"]};
	dailyQuests[13100] = {name = "Infused Mushroom Meatloaf", sharedCooldown = L["Wrath Cooking Daily"]};
	dailyQuests[13107] = {name = "Mustard Dogs!", sharedCooldown = L["Wrath Cooking Daily"]};
	dailyQuests[13830] = {name = "The Ghostfish", sharedCooldown = L["Wrath Fishing Daily"]};
	dailyQuests[13832] = {name = "Jewel Of The Sewers", sharedCooldown = L["Wrath Fishing Daily"]};
	dailyQuests[13834] = {name = "Dangerously Delicious", sharedCooldown = L["Wrath Fishing Daily"]};
	dailyQuests[13836] = {name = "Disarmed!", sharedCooldown = L["Wrath Fishing Daily"]};
	dailyQuests[13833] = {name = "Blood Is Thicker", sharedCooldown = L["Wrath Fishing Daily"]};
	dailyQuests[12958] = {name = "Shipment: Blood Jade Amulet", sharedCooldown = L["Wrath Jewelcrafting Daily"]};
	dailyQuests[12962] = {name = "Shipment: Bright Armor Relic", sharedCooldown = L["Wrath Jewelcrafting Daily"]};
	dailyQuests[12959] = {name = "Shipment: Glowing Ivory Figurine", sharedCooldown = L["Wrath Jewelcrafting Daily"]};
	dailyQuests[12961] = {name = "Shipment: Intricate Bone Figurine", sharedCooldown = L["Wrath Jewelcrafting Daily"]};
	dailyQuests[12963] = {name = "Shipment: Shifting Sun Curio", sharedCooldown = L["Wrath Jewelcrafting Daily"]};
	dailyQuests[12960] = {name = "Shipment: Wicked Sun Brooch", sharedCooldown = L["Wrath Jewelcrafting Daily"]};
end

if (NIT.isSOD) then
	dailyQuests[79098] = {name = "Clear the Forest!"};
	dailyQuests[79090] = {name = "Repelling Invaders"};
end

if (NIT.isCata) then
	--Alliance cooking dailies.
	dailyQuests[29316] = {name = "Back to Basics", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29314] = {name = "Remembering the Ancestors", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29318] = {name = "Ribs for the Sentinels", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29357] = {name = "Spice Bread Aplenty", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29313] = {name = "The Secret to Perfect Kimchi", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29352] = {name = "A Fowl Shortage", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29351] = {name = "A Round for the Guards", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29355] = {name = "Can't Get Enough Spice Bread", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29356] = {name = "I Need to Cask a Favor", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29353] = {name = "Keepin' the Haggis Flowin'", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[26190] = {name = "A Fisherman's Feast", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[26177] = {name = "Feeling Crabby?", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[26192] = {name = "Orphans Like Cookies Too!", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[26153] = {name = "Penny's Pumpkin Pancakes", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[26183] = {name = "The King's Cider", sharedCooldown = L["Cata Cooking Daily"]};
	--Horde cooking dailies.
	dailyQuests[26227] = {name = "Careful, This Fruit Bites Back", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[26226] = {name = "Crawfish Creole", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[26235] = {name = "Even Thieves Get Hungry", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[26220] = {name = "Everything Is Better with Bacon", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[26233] = {name = "Stealing From Our Own", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29362] = {name = "Magic Mushrooms", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29364] = {name = "Corn Mash", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29363] = {name = "Mulgore Spice Bread", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29365] = {name = "Perfectly Picked Portions", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29358] = {name = "Pining for Nuts", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29333] = {name = "Escargot A Go-Go", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29315] = {name = "Fungus Among Us", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29332] = {name = "Lily, Oh Lily", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29334] = {name = "Roach Coach", sharedCooldown = L["Cata Cooking Daily"]};
	dailyQuests[29360] = {name = "Would You Like Some Flies With That?", sharedCooldown = L["Cata Cooking Daily"]};
	--Alliance fishing dailies.
	dailyQuests[29342] = {name = "Cold Water Fishing", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29344] = {name = "Fish fer Squrky", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29347] = {name = "Live Bait", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29343] = {name = "One fer the Ages", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29350] = {name = "The Gnomish Bait-o-Matic", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29325] = {name = "A Slippery Snack", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29359] = {name = "An Old Favorite", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29321] = {name = "Happy as a Clam Digger", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29323] = {name = "Stocking Up", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29324] = {name = "The Sister's Pendant", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[26488] = {name = "Big Gulp", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[26420] = {name = "Diggin' For Worms", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[26414] = {name = "Hitting a Walleye", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[26442] = {name = "Rock Lobster", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[26536] = {name = "Thunder Falls", sharedCooldown = L["Cata Fishing Daily"]};
	--Horde fishing dailies.
	dailyQuests[26588] = {name = "A Furious Catch", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[26572] = {name = "A Golden Opportunity", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[26557] = {name = "A Staggering Effort", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[26543] = {name = "Clammy Hands", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[26556] = {name = "No Dumping Allowed", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29349] = {name = "Craving Crayfish", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29345] = {name = "Pond Predators", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29354] = {name = "Shiny Baubles", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29348] = {name = "The Race to Restock", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29346] = {name = "The Ring's the Thing", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29317] = {name = "Fish Head", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29320] = {name = "Like Pike?", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29361] = {name = "Moat Monster!", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29319] = {name = "Tadpole Terror", sharedCooldown = L["Cata Fishing Daily"]};
	dailyQuests[29322] = {name = "Time for Slime", sharedCooldown = L["Cata Fishing Daily"]};
	--Jewelcrafting dailies.
	dailyQuests[25154] = {name = "A Present for Lila", sharedCooldown = L["Cata Jewelcrafting Daily"]};
	dailyQuests[25156] = {name = "Elemental Goo", sharedCooldown = L["Cata Jewelcrafting Daily"]};
	dailyQuests[25105] = {name = "Nibbler! No!", sharedCooldown = L["Cata Jewelcrafting Daily"]};
	dailyQuests[25155] = {name = "Ogrezonians in the Mood", sharedCooldown = L["Cata Jewelcrafting Daily"]};
	dailyQuests[25157] = {name = "The Latest Fashion!", sharedCooldown = L["Cata Jewelcrafting Daily"]};
end

--Cache all quest names.
for k, v in pairs(weeklyQuests) do
	GetQuestInfo(k);
end
for k, v in pairs(dailyQuests) do
	GetQuestInfo(k);
end

function NIT:recordQuests()
	if (not C_DateAndTime or not C_DateAndTime.GetSecondsUntilWeeklyReset) then
		return;
	end
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	if (not NIT.data.myChars[char].quests) then
		NIT.data.myChars[char].quests = {};
	end
	local resetTime = GetServerTime() + C_DateAndTime.GetSecondsUntilWeeklyReset();
	local sharedQuests = {};
	for k, v in pairs(weeklyQuests) do
		if (IsQuestFlaggedCompleted(k)) then
			local questName = v.name;
			local localizedName = GetQuestInfo(k);
			local skip;
			if (v.sharedCooldown) then
				--If shared cooldown type like cata cooking dailies diff quests are up but you can only do one.
				--It flags all as complete but we only want to record one.
				if (sharedQuests[v.sharedCooldown]) then
					skip = true;
				else
					sharedQuests[v.sharedCooldown] = true;
					questName = v.sharedCooldown;
				end
			elseif (localizedName and localizedName ~= "") then
				questName = localizedName;
			end
			if (not skip) then
				NIT.data.myChars[char].quests[questName] = resetTime;
			end
		end
	end
	--Record cata 7 per week dungeon quests.
	if (NIT.isCata) then
		--Always reset the data so new remaining can overwrite old.
		NIT.data.myChars[char].dungWeeklies = {};
		--Normal.
		local _, currencyQuantity, _, _, _, overallLimit = GetLFGDungeonRewardCapInfo(300); --https://warcraft.wiki.gg/wiki/LfgDungeonID
		--currencyQuantity is 0 if we don't qualify for this type of queue due totoo low level or whatever (I think).
		if (overallLimit and currencyQuantity and currencyQuantity ~= 0) then
			local remaining = LFGRewardsFrame_EstimateRemainingCompletions(300);
			--Only record if we've used some slots this week.
			--Changed to just show it even if 7 left.
			--if (remaining < overallLimit) then
				local remainingText = "|cFF00FF00" .. remaining .. "|r|cFF00FF00/" .. overallLimit .. "|r";
				if (remaining == 0) then
					remainingText = "|cFFFF0000" .. remaining .. "|r|cFF00FF00/" .. overallLimit .. "|r";
				elseif (remaining < overallLimit) then
					remainingText = "|cFFFFFF00" .. remaining .. "|r|cFF00FF00/" .. overallLimit .. "|r";
				end
				local desc = "|cFF9CD6DE(|r|cff00ff00N|r|cFF9CD6DE)|r Dungeon weeklies remaining: " .. remainingText;
				NIT.data.myChars[char].dungWeeklies[desc] = resetTime;
			--end
		end
		--Heroic.
		--[[local _, currencyQuantity, _, _, _, overallLimit = GetLFGDungeonRewardCapInfo(301);
		--if (currencyQuantity ~= 0) then
		if (UnitLevel("player") == 85) then
			local remaining = LFGRewardsFrame_EstimateRemainingCompletions(301);
			--if (remaining < overallLimit) then
				local remainingText = "|cFF00FF00" .. remaining .. "|r|cFF00FF00/" .. overallLimit .. "|r";
				if (remaining == 0) then
					remainingText = "|cFFFF0000" .. remaining .. "|r|cFF00FF00/" .. overallLimit .. "|r";
				elseif (remaining < overallLimit) then
					remainingText = "|cFFFFFF00" .. remaining .. "|r|cFF00FF00/" .. overallLimit .. "|r";
				end
				local desc = "|cFF9CD6DE(|r|cFFFF2222H|r|cFF9CD6DE)|r Dungeon weeklies remaining: " .. remainingText;
				NIT.data.myChars[char].dungWeeklies[desc] = resetTime;
			--end
		end]]
		--Heroic was changed from a 7 per week cap to a rolling season cap so we'll display that cap instead.
		if (UnitLevel("player") == 85) then
			local valor = C_CurrencyInfo.GetCurrencyInfo(396);
			if (valor) then
				local name, totalEarned, max = valor.name, valor.totalEarned, valor.maxQuantity;
				if (name and totalEarned and max) then
					local remainingText = "|cFF00FF00" .. totalEarned .. "|r|cFF00FF00/" .. max .. "|r";
					if (totalEarned == 0) then
						remainingText = "|cFFFF0000" .. totalEarned .. "|r|cFF00FF00/" .. max .. "|r";
					elseif (totalEarned < max) then
						remainingText = "|cFFFFFF00" .. totalEarned .. "|r|cFF00FF00/" .. max .. "|r";
					end
					local desc = "|cFF9CD6DE(|r|cFFFF2222H|r|cFF9CD6DE)|r " .. name .. " cap: " .. remainingText;
					NIT.data.myChars[char].dungWeeklies[desc] = resetTime;
				end
			end
		end
	end
	local resetTime = GetServerTime() + C_DateAndTime.GetSecondsUntilDailyReset();
	local sharedQuests = {};
	if (not NIT.data.myChars[char].questsDaily) then
		NIT.data.myChars[char].questsDaily = {};
	end
	for k, v in pairs(dailyQuests) do
		if (IsQuestFlaggedCompleted(k)) then
			local questName = v.name;
			local localizedName = GetQuestInfo(k);
			local skip;
			if (v.sharedCooldown) then
				--If shared cooldown type like cata cooking dailies diff quests are up but you can only do one.
				--It flags all as complete but we only want to record one.
				if (sharedQuests[v.sharedCooldown]) then
					skip = true;
				else
					sharedQuests[v.sharedCooldown] = true;
					questName = v.sharedCooldown;
				end
			elseif (localizedName and localizedName ~= "") then
				questName = localizedName;
			end
			if (not skip) then
				NIT.data.myChars[char].questsDaily[questName] = resetTime;
			end
		end
	end
end

function NIT:recordAttunementKeys()
	if (NIT.expansionNum > 3) then
		return;
	end
	if (not KeyRingButtonIDToInvSlotID) then
		return; --This was patched out a month after cata release instead of during beta?
	end
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	--Check the keyring for attunement keys.
	for slot = 1, 32 do
		local slotID = KeyRingButtonIDToInvSlotID(slot);
		if (slotID) then
			local item = Item:CreateFromEquipmentSlot(slotID);
			if (item) then
				local itemID = item:GetItemID(item);
				local itemName = item:GetItemName(item);
				if (itemID == 185686 or itemID == 185687 or itemID == 30637 or itemID == 30622) then
					NIT.data.myChars[char].hellfireCitadelAttune = true;
				end
				if (itemID == 30623 or itemID == 185690) then
					NIT.data.myChars[char].coilfangAttune = true;
				end
				if (itemID == 30633 or itemID == 185691) then
					NIT.data.myChars[char].auchindounAttune = true;
				end
				if (itemID == 27991) then
					NIT.data.myChars[char].shadowLabAttune = true;
				end
				if (itemID == 30634 or itemID == 185692) then
					NIT.data.myChars[char].tempestKeepAttune = true;
				end
				if (itemID == 30635 or itemID == 185693) then
					NIT.data.myChars[char].cavernsAttune = true;
				end
				if (itemID == 31084) then
					NIT.data.myChars[char].arcatrazAttune = true;
				end
				--if (itemID == 7146) then
				--	NIT.data.myChars[char].testAttune = true;
				--end
				--if (itemName and string.find(itemName, "Key")) then
				--	print(itemName, itemID)
				--end
			end
		end
	end
end

function NIT:recordPvpData()
	if (NIT.isRetail) then
		return;
	end
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	local rankID = UnitPVPRank("player");
	if (rankID) then
		local rankName, rankNumber = GetPVPRankInfo(rankID);
		local rankPercent = GetPVPRankProgress();
		if (rankName and rankNumber and rankPercent) then
			if (NIT.data.myChars[char].pvpRankPercent and rankPercent and tostring(rankPercent) ~= tostring(NIT.data.myChars[char].pvpRankPercent)) then
				NIT.data.myChars[char].pvpRankNameLastWeek = NIT.data.myChars[char].pvpRankName;
				NIT.data.myChars[char].pvpRankNumberLastWeek = NIT.data.myChars[char].pvpRankNumber;
				NIT.data.myChars[char].pvpRankPercentLastWeek = NIT.data.myChars[char].pvpRankPercent;
			end
			NIT.data.myChars[char].pvpRankName = rankName;
			NIT.data.myChars[char].pvpRankNumber = rankNumber;
			NIT.data.myChars[char].pvpRankPercent = rankPercent;
		end
	end
end

function NIT:recordHonorData()
	if (NIT.isClassic) then
		return;
	end
	local honor = C_CurrencyInfo.GetCurrencyInfo(1901);
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	
	if (honor and honor.quantity and honor.quantity > 0) then
		NIT.data.myChars[char].honor = honor.quantity;
	else
		NIT.data.myChars[char].honor = 0;
	end
end

function NIT:recordArenaPoints()
	if (NIT.isClassic) then
		return;
	end
	local data = C_CurrencyInfo.GetCurrencyInfo(1900);
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	if (data and data.quantity and data.quantity > 0) then
		NIT.data.myChars[char].arenaPoints = data.quantity;
	else
		NIT.data.myChars[char].arenaPoints = 0;
	end
end

NIT.bgMarks = {
	[20558] = {
		name = "Warsong Gulch Mark of Honor",
		icon = 134420,
	};
	[20559] = {
		name = "Arathi Basin Mark of Honor",
		icon = 133282,
	};
	[20560] = {
		name = "Alterac Valley Mark of Honor",
		icon = 133308,
	};
};
if (NIT.isTBC) then
	NIT.bgMarks[29024] = {
		name = "Eye of the Storm Mark of Honor",
		icon = 136032,
	};
end
if (NIT.isWrath) then
	NIT.bgMarks[29024] = {
		name = "Eye of the Storm Mark of Honor",
		icon = 136032,
	};
	NIT.bgMarks[42425] = {
		name = "Strand of the Ancients Mark of Honor",
		icon = 133276,
	};
	NIT.bgMarks[47395] = {
		name = "Isle of Conquest Mark of Honor",
		icon = 133314,
	};
end

function NIT:recordMarksData()
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	if (not NIT.data.myChars[char].marks) then
		NIT.data.myChars[char].marks = {};
	end
	if (NIT.expansionNum < 4) then
		for k, v in pairs(NIT.bgMarks) do
			NIT.data.myChars[char].marks[k] = (GetItemCount(k, true) or 0);
		end
	end
end

function NIT:recordLockoutData()
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
		if (tonumber(id)) then
			NIT.data.myChars[char].savedInstances[tonumber(id)] = {
				name = name,
				resetTime = resetTime,
				difficultyName = difficultyName,
				locked = locked,
			};
			if (NIT.isRetail) then
				if (GetSavedInstanceEncounterInfo and numEncounters and numEncounters > 0) then
					NIT.data.myChars[char].savedInstances[tonumber(id)].bosses = {};
					for b = 1, numEncounters do
						local bossName, texture, isKilled = GetSavedInstanceEncounterInfo(i, b);
						NIT.data.myChars[char].savedInstances[tonumber(id)].bosses[b] = {
							bossName = bossName,
							texture = texture,
							isKilled = isKilled,
						};
					end
				end
			end
		end
	end
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

function NIT:recordKeystoneData(lootedKeystone)
	if (not NIT.isRetail) then
		return;
	end
	C_MythicPlus.RequestMapInfo(); --Instead of a timer this should be changed to wait for CHALLENGE_MODE_MAPS_UPDATE later.
	if (lootedKeystone) then
		--Force record data if we just looted a keystone from the vault.
		--For some reason running C_MythicPlus.RequestMapInfo() right after loot doesn't trigger any event.
		--Maybe a throddle?
		NIT:challengeModeMapsUpdate();
	end
end

function NIT:challengeModeMapsUpdate()
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	if (not NIT.data.myChars[char].keystoneData) then
		NIT.data.myChars[char].keystoneData = {};
	end
	NIT.data.myChars[char].keystoneScore = C_ChallengeMode.GetOverallDungeonScore();
	local _, class = UnitClass("player");
	local keystone, bestMap, bestLevel;
	for bag = 0, NUM_BAG_SLOTS do
		for slot = 1, GetContainerNumSlots(bag) do
      		local item = GetContainerItemLink(bag,slot);
      		if (item and strfind(item, "|Hkeystone")) then
      			keystone = item;
      			break;
			end
		end
	end
	--if (keystone) then
	--	level = C_MythicPlus.GetOwnedKeystoneLevel();
	--	local mapID = C_MythicPlus.GetOwnedKeystoneMapID();
	--	local mapName = C_ChallengeMode.GetMapUIInfo(mapID);
	--	mapData = C_Map.GetMapInfo(mapID);
	--end
	if (keystone) then
		NIT.data.myChars[char].keystoneData.itemLink = keystone;
	end
	local bestLevel, bestScore = 0, 0;
	local bestMapName, bestMapID;
	local weeklyRuns = C_MythicPlus.GetRunHistory(false, true);
	for i = 1, #weeklyRuns do
		local run = weeklyRuns[i];
		if (run.thisWeek and run.level > bestLevel) then
			bestLevel = run.level;
		end
	end
	--Check all keys equal to our max level done to find the best score so we can display which map it was.
	for i = 1, #weeklyRuns do
		local run = weeklyRuns[i];
		if (run.thisWeek and run.level == bestLevel) then
			if (run.runScore > bestScore or bestScore == 0) then
				bestScore = run.runScore;
				bestMapID = run.mapChallengeModeID;
			end
		end
	end
	if (bestMapID and bestLevel > 0) then
		bestMapName = C_ChallengeMode.GetMapUIInfo(bestMapID);
		NIT.data.myChars[char].keystoneData.bestMapName = bestMapName;
		NIT.data.myChars[char].keystoneData.bestLevel = bestLevel;
	end
	if (C_WeeklyRewards.HasAvailableRewards()) then
		NIT.data.myChars[char].weeklyCache = true;
	else
		NIT.data.myChars[char].weeklyCache = nil;
	end
end

function NIT:checkRewards()
	if (not C_WeeklyRewards) then
		return;
	end
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	if (C_WeeklyRewards.HasAvailableRewards()) then
		NIT.data.myChars[char].weeklyCache = true;
	else
		NIT.data.myChars[char].weeklyCache = nil;
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_SYSTEM")
f:SetScript('OnEvent', function(self, event, msg)
	if (string.match(msg, DAILY_QUESTS_RESET)) then
		C_Timer.After(10, function()
			NIT:resetWeeklyAndDailyData();
			NIT:updateWeeklyResetTime();
		end)
	end
end)

--Weekly and daily data.
function NIT:resetWeeklyAndDailyData()
	for realm, realmData in pairs(NIT.db.global) do
		if (type(realmData) == "table" and realmData ~= "minimapIcon" and realmData ~= "data") then
			if (realmData.myChars) then
				local resetTime = (realmData.weeklyResetTime or 0);
				for char, charData in pairs(realmData.myChars) do
					if (charData.quests) then
						for k, v in pairs(charData.quests) do
							if (v < GetServerTime()) then
								NIT.db.global[realm].myChars[char].quests[k] = nil;
							end
						end
					end
					if (charData.dungWeeklies) then
						for k, v in pairs(charData.dungWeeklies) do
							if (v < GetServerTime()) then
								NIT.db.global[realm].myChars[char].dungWeeklies[k] = nil;
							end
						end
					end
					if (charData.questsDaily) then
						for k, v in pairs(charData.questsDaily) do
							if (v < GetServerTime()) then
								NIT.db.global[realm].myChars[char].questsDaily[k] = nil;
							end
						end
					end
					if (charData.keystoneData) then
						if (resetTime < GetServerTime()) then
							NIT.db.global[realm].myChars[char].keystoneData = nil;
						end
					end
				end
			end
		end
	end
end

function NIT:updateWeeklyResetTime()
	NIT.db.global[NIT.realm].weeklyResetTime = GetServerTime() + C_DateAndTime.GetSecondsUntilWeeklyReset();
end

function NIT:doOnceAfterWeeklyReset()
	for realm, realmData in pairs(NIT.db.global) do
		if (type(realmData) == "table" and realmData ~= "minimapIcon" and realmData ~= "data") then
			if (realmData.myChars) then
				local resetTime = (realmData.weeklyResetTime or 0);
				if (GetServerTime() > resetTime) then
					--resetTime is set after this func is run at logon so it's easy to check if it's first logon after weekly reset.
					--If it's first logon after weekly reset we do things like setting flags that chars need to loot weekly cache etc.
					for char, charData in pairs(realmData.myChars) do
						if (charData.keystoneData and charData.keystoneData.bestLevel and charData.keystoneData.bestLevel > 0) then
							NIT.db.global[realm].myChars[char].weeklyCache = true;
						end
					end
				end
			end
		end
	end
end

--These are structured like this so there's a sort order.
--minLvl is min lvl that you need to cast the spells that require them.

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

if (NIT.isTBC or NIT.isPrepatch) then
	NIT.trackItemsDRUID = {
		[1] = {
			id = 22148,
			name = "Wild Quillvine",
			texture = "Interface\\Icons\\inv_misc_root_01",
			minLvl = 70;
		},
		[2] = {
			id = 22147,
			name = "Flintweed Seed",
			texture = "Interface\\Icons\\inv_misc_food_02",
			minLvl = 70;
		},
	};
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
elseif (NIT.isWrath) then
	NIT.trackItemsDRUID = {
		[1] = {
			id = 44605,
			name = "Wild Spineleaf",
			texture = "Interface\\Icons\\inv_misc_spineleaf-_01",
			minLvl = 80;
		},
		[2] = {
			id = 44614,
			name = "Starleaf Seed",
			texture = "Interface\\Icons\\inv_misc_food_02",
			minLvl = 80;
		},
	};
	NIT.trackItemsPRIEST = {
		[1] = {
			id = 44615,
			name = "Devout Candle",
			texture = "Interface\\Icons\\inv_misc_candle_01",
			minLvl = 56,
		},
		[2] = {
			id = 17056,
			name = "Light Feather",
			texture = "Interface\\Icons\\inv_feather_04",
			minLvl = 24,
		},
	};
else
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
end
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
	NIT:recordMarksData();
	NIT:recordCurrency();
end

--[icon] = "name",
local currencyItems = {
	--TBC.
	[135884] = "Badge of Justice",
	--Wrath
	[237547] = "Emblem of Valor",
	[135979] = "Emblem of Triumph",
	[135947] = "Emblem of Heroism",
	[135885] = "Emblem of Conquest",
	[334365] = "Emblem of Frost",
	[134375] = "Stone Keeper's Shards",
	[133408] = "Wintergrasp Mark of Honor",
	[237235] = "Sidereal Essence",
	[236246] = "Champion's Seal",
	[237273] = "Defiler's Scourgestone",
	--Cata
    [463446] = "Justice Points",
    [463447] = "Valor Points",
    [236571] = "Chef's Award",
    [136192] = "Mote of Darkness",
    [132851] = "Essence of Corrupted Deathwing",
	--Profession tokens.
    [134411] = "Epicurean's Award",
    [236571] = "Chef's Award",
    [134138] = "Dalaran Jewelcrafter's Token",
    [134501] = "Illustrious Jewelcrafter's Token",
    --Misc
    [134481] = "Darkmoon Prize Ticket",
    [409548] = "Tol Barad Commendation",
};

function NIT:recordCurrency()
	if (NIT.isClassic or NIT.isTBC or NIT.isRetail) then
		return;
	end
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	--Wipe old data for things like currencies disappearing for new expansions etc.
	--if (not NIT.data.myChars[char].currency) then
		NIT.data.myChars[char].currency = {};
	--end
	for i = 1, GetCurrencyListSize() do
		local name, isHeader, _, _, _, count, icon, max = GetCurrencyListInfo(i);
		if (icon and currencyItems[icon]) then
			NIT.data.myChars[char].currency[icon] = {
				name = name,
				count = count,
				max = max,
			};
		end
	end
	
	local conq = C_CurrencyInfo.GetCurrencyInfo(390);
	if (conq and conq.quantity and conq.quantity > 0) then
		NIT.data.myChars[char].conq = conq.quantity;
	else
		NIT.data.myChars[char].conq = 0;
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

--Thanks for Stpain and GuildBook addon for spec detection help.
--spellID -> professionID.
--https://warcraft.wiki.gg/wiki/TradeSkillLineID.
--Alchemy:
--[[[28672] = 171,
[28677] = 171,
[28675] = 171,
--Engineering:
[20222] = 202,
[20219] = 202,
--Tailoring:
[26798] = 197,
[26797] = 197,
[26801] = 197,
--Blacksmithing:
[9788] = 164,
[17039] = 164,
[17040] = 164,
[17041] = 164,
[9787] = 164,
--Leatherworking:
[10656] = 165,
[10658] = 165,
[10660] = 165,]]
local tradeskillSpecs = {
    --Alchemy:
    [28672] = L["Alchemy"], --Transmutation Master.
    [28677] = L["Alchemy"], --Elixir Master.
    [28675] = L["Alchemy"], --Potion Master.
    --Engineering:
    [20222] = L["Engineering"], --Goblin Engineer.
    [20219] = L["Engineering"], --Gnomish Engineer.
    --Tailoring:
    [26798] = L["Tailoring"], --Mooncloth Tailoring.
    [26797] = L["Tailoring"], --Spellfire Tailoring.
    [26801] = L["Tailoring"], --Shadoweave Tailoring.
    --Blacksmithing:
    [9788] = L["Blacksmithing"], --Armorsmith.
    [17039] = L["Blacksmithing"], --Master Swordsmith.
    [17040] = L["Blacksmithing"], --Master Hammersmith.
    [17041] = L["Blacksmithing"], --Master Axesmith.
    [9787] = L["Blacksmithing"], --Weaponsmith.
    --Leatherworking:
    [10656] = L["Leatherworking"], --Dragonscale Leatherworking.
    [10658] = L["Leatherworking"], --Elemental Leatherworking.
    [10660] = L["Leatherworking"], --Tribal Leatherworking.
}
--Cache all prof spec spell names.
for k, v in pairs(tradeskillSpecs) do
	GetSpellInfo(k);
end

--By tab index.
local function getProfessionSpec(spellTabIndex)
	if (not spellTabIndex) then
		return;
	end
	local specName;
    local name, _, offset, numSlots = GetSpellTabInfo(spellTabIndex);
    for j = offset + 1, offset + numSlots do
        local _, spellID = GetSpellBookItemInfo(j, BOOKTYPE_SPELL);
        if (spellID and tradeskillSpecs[spellID]) then
            specName = GetSpellInfo(spellID);
            return specName;
        end
    end
end

--By profession name.
local function getProfessionSpecClassic(profName)
	if (not profName) then
		return;
	end
    local specName;
    for i = 1, GetNumSpellTabs() do
    	local found;
        local _, _, offset, numSlots = GetSpellTabInfo(i);
        for j = offset + 1, offset + numSlots do
           local _, spellID = GetSpellBookItemInfo(j, BOOKTYPE_SPELL);
           if (spellID and tradeskillSpecs[spellID] and tradeskillSpecs[spellID] == profName) then
	            specName = GetSpellInfo(spellID);
	            return specName
	        end
        end
    end
end

function NIT:recordProfessions()
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	local data = NIT.data.myChars[char];
	local prof1Name, prof2Name, fishing, cooking, firstaid = "none", "none", "none", "none", "none";
	local profSkill1, profSkill2, fishingSkill, cookingSkill, firstaidSkill = 0, 0, 0, 0, 0;
	local profSkillMax1, profSkillMax2, fishingSkillMax, cookingSkillMax, firstaidSkillMax = 0, 0, 0, 0, 0;
	if (NIT.isRetail) then
		--This way would work for cata too now I guess, but skillLines also still works so leaving it for now.
		local prof1, prof2, archaeology, fishing, cooking = GetProfessions();
		if (prof1) then
			local prof1Name = GetProfessionInfo(prof1);
			data.prof1 = prof1Name;
			--data.prof1SpecName = getProfessionSpec(prof1);
		end
		if (prof2) then
			local prof2Name = GetProfessionInfo(prof2);
			data.prof2 = prof2Name;
			--data.prof2SpecName = getProfessionSpec(prof2);
		end
	elseif (NIT.classic) then
		--Skill list is always in same order, so we can get primary/secondary/weapon by checking the section headers.
		local section, primaryCount, secondaryCount, weaponCount = 0, 0, 0, 0;
		for i = 1, GetNumSkillLines() do
			local skillName, isHeader, _, skillRank, _, _, skillMaxRank = GetSkillLineInfo(i)
			--[[if (isHeader and skillName == "Professions") then
				section = 2;
			elseif (isHeader and skillName == "Secondary Skills") then
				section = 3;
			elseif (isHeader and skillName == "Weapon Skills") then
				section = 4;
			elseif (isHeader and skillName == "Armor Proficiencies") then
				section = 5;
			elseif (isHeader and skillName == "Languages") then
				section = 6;
			end]]
			if (isHeader and skillName == TRADE_SKILLS) then
				section = 2;
			elseif (isHeader and skillName == string.gsub(SECONDARY_SKILLS, ":", "")) then
				section = 3;
			elseif (isHeader and string.find(skillName, COMBAT_RATING_NAME1)) then
				section = 4;
			elseif (isHeader and string.find(skillName, string.gsub(PROFICIENCIES, ":", ""))) then
				--Global string PROFICIENCIES has a colon so strip it and use that as a close enough.
				--Couldn't find a "Armor Proficiencies" global string.
				section = 5;
			elseif (isHeader and skillName == LANGUAGES_LABEL) then
				section = 6;
			end
			if (not isHeader and section == 2) then
				--Primary professions.
				primaryCount = primaryCount + 1;
				if (primaryCount == 1) then
					prof1Name = skillName;
					profSkill1 = skillRank;
					profSkillMax1 = skillMaxRank;
				elseif (primaryCount == 2) then
					prof2Name = skillName;
					profSkill2 = skillRank;
					profSkillMax2 = skillMaxRank;
				end
			elseif (not isHeader and (section == 3 or section == 2)) then
				--Secondary professions.
				secondaryCount = secondaryCount + 1;
				if (skillName == PROFESSIONS_FISHING) then
					fishing = skillName;
					fishingSkill = skillRank;
					fishingSkillMax = skillMaxRank;
				elseif (skillName == PROFESSIONS_COOKING) then
					cooking = skillName;
					cookingSkill = skillRank;
					cookingSkillMax = skillMaxRank;
				elseif (skillName == PROFESSIONS_FIRST_AID) then
					firstaid = skillName;
					firstaidSkill = skillRank;
					firstaidSkillMax = skillMaxRank;
				end
			elseif (not isHeader and section == 4) then
				--Weapon skills.
				weaponCount = weaponCount + 1;
			end
		end
		data.prof1 = prof1Name;
		data.profSkill1 = profSkill1;
		data.profSkillMax1 = profSkillMax1;
		data.prof2 = prof2Name;
		data.profSkill2 = profSkill2;
		data.profSkillMax2 = profSkillMax2;
		--data.fishing = fishing;
		data.fishingSkill = fishingSkill;
		data.fishingSkillMax = fishingSkillMax;
		--data.cooking = cooking;
		data.cookingSkill = cookingSkill;
		data.cookingSkillMax = cookingSkillMax;
		--data.firstaid = firstaid;
		data.firstaidSkill = firstaidSkill;
		data.firstaidSkillMax = firstaidSkillMax;
		--print(prof1, profSkill1, profSkillMax1);
		--print(prof2, profSkill2, profSkillMax2);
		--print(fishingSkill, cookingSkill, firstaidSkill);
		if (GetProfessions) then
			--Cata.
			local prof1SpellTabIndex, prof2SpellTabIndex = GetProfessions();
			data.prof1SpecName = getProfessionSpec(prof1SpellTabIndex);
			data.prof2SpecName = getProfessionSpec(prof2SpellTabIndex);
		elseif (GetNumPrimaryProfessions) then
			--Era.
			data.prof1SpecName = getProfessionSpecClassic(prof1Name);
			data.prof2SpecName = getProfessionSpecClassic(prof2Name);
		end
	end
end

function NIT:recordSkillUpData(...)
	NIT:recordProfessions();
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

--Big thanks to this comment https://github.com/Stanzilla/WoWUIBugs/issues/47#issuecomment-710698976
local function GetCooldownLeft(start, duration)
	if (start < GetTime()) then
		local cdEndTime = start + duration;
		local cdLeftDuration = cdEndTime - GetTime();
		return cdLeftDuration;
	end
	local time = time();
	local startupTime = time - GetTime();
	local cdTime = (2 ^ 32) / 1000 - start;
	local cdStartTime = startupTime - cdTime;
	local cdEndTime = cdStartTime + duration;
	local cdLeftDuration = cdEndTime - time;
    return cdLeftDuration;
end

--[[local cooldownList = {
	--[14342] = CHARACTER_PROFESSION_TAILORING, --(These global strings don't seem to exist in classic)).
	[14342] = L["Tailoring"], --Mooncloth.
};]]

local itemCooldowns = {};
if (NIT.isClassic) then
	itemCooldowns = {
		[15846] = L["Salt Shaker"],
	}
end

function NIT:recordCooldowns()
	if (NIT.isRetail) then
		return;
	end
	local char = UnitName("player");
	if (not NIT.data.myChars[char]) then
		NIT.data.myChars[char] = {};
	end
	if (not NIT.data.myChars[char].cooldowns) then
		NIT.data.myChars[char].cooldowns = {};
	end
	--GetNumTradeSkills() is 0 unless a prof window has been opened since logon.
	--But it doesn't matter because it only goes on cooldown when opening it to use it anyway.
	local count = {};
	local data = {};
	local error;
	local duplicateCheck = true;
	local numTradeSkills = GetNumTradeSkills() or 0;
	if (numTradeSkills < 1) then
		--Try crafts for enchanting.
		numTradeSkills = GetNumCrafts();
	end
	if (duplicateCheck) then
		for i = 1, numTradeSkills do
			local secondsLeft = GetTradeSkillCooldown(i) or GetCraftCooldown(i);
			if (secondsLeft and secondsLeft > 60) then
				local skillName = GetTradeSkillInfo(i) or GetCraftInfo(i);
				--NIT:debug("Check Skill:", skillName, "Cooldown:", secondsLeft);
				data[skillName] = secondsLeft;
				--Alchemy has 12 skills that share a cooldown, if there's more than 12 duplicate timestamps we have a rare bug.
				count[secondsLeft] = (count[secondsLeft] or 0) + 1;
				if (count[secondsLeft] > 15) then
					error = true;
				end
			end
		end
		if (not error) then
			for skillName, secondsLeft in pairs(data) do
				if (not NIT.data.myChars[char].cooldowns[skillName]) then
					NIT.data.myChars[char].cooldowns[skillName] = {};
				end
				NIT.data.myChars[char].cooldowns[skillName].time = GetServerTime() + secondsLeft;
			end
		end
	else
		for i = 1, numTradeSkills do
			local secondsLeft = GetTradeSkillCooldown(i);
			if (secondsLeft and secondsLeft > 60) then
				local skillName = GetTradeSkillInfo(i);
				--NIT:debug("Skill:", skillName, "Cooldown:", secondsLeft);
				if (not NIT.data.myChars[char].cooldowns[skillName]) then
					NIT.data.myChars[char].cooldowns[skillName] = {};
				end
				NIT.data.myChars[char].cooldowns[skillName].time = GetServerTime() + secondsLeft;
			end
		end
	end
	for bag = 0, NUM_BAG_SLOTS do
		for slot = 1, GetContainerNumSlots(bag) do
			local item = Item:CreateFromBagAndSlot(bag, slot);
			if (item) then
				local itemID = item:GetItemID(item);
				local itemName = item:GetItemName(item);
				if (itemID and itemName and itemCooldowns[itemID]) then
					local startTime, duration, isEnabled = GetContainerItemCooldown(bag, slot);
					--local endTime = (startTime + duration) - (GetTime() - GetServerTime());
					local endTime = GetCooldownLeft(startTime, duration) + GetServerTime();
					if (isEnabled == 1 and startTime > 0 and duration > 0) then
						if (not NIT.data.myChars[char].cooldowns[itemName]) then
							NIT.data.myChars[char].cooldowns[itemName] = {};
						end
						NIT.data.myChars[char].cooldowns[itemName].time = endTime;
						--NIT:debug("Check Item:", itemName, "Cooldown:", endTime);
					end
				end
			end
		end
	end
end

--Fix and issue where the entire tradeskill list was recording a cooldown.
function NIT:fixCooldowns()
	local count = {};
	local found;
	for realm, v in pairs(NIT.db.global) do --Iterate realms.
		if (type(v) == "table" and v.myChars) then
			for char, v in pairs(v.myChars) do
				if (v.cooldowns) then
					for skill, vv in pairs(v.cooldowns) do
						count[vv.time] = (count[vv.time] or 0) + 1;
						if (count[vv.time] > 30) then
							local time = vv.time;
							for skill, data in pairs(v.cooldowns) do
								--Remove all duplicate timestamp entries.
								if (data.time and time == data.time) then
									NIT.db.global[realm].myChars[char].cooldowns[skill] = nil;
								end
							end
							NIT:print("Data error found in tradeskill cooldowns for " .. char .. "-" .. realm .. ", resetting cooldown data.");
							break;
						end
					end
				end
			end
		end
	end
end

function NIT:recordHunterData()
	if (NIT.expansionNum > 3) then
		return;
	end
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
	if (NIT.expansionNum > 3) then
		return 0
	end
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

function NIT:doTrade()
	local traded;
	local _, _, _, classColorHex = GetClassColor(string.upper(tradeWhoClass));
	--Safeguard for weakauras/addons that like to overwrite and break the GetClassColor() function.
	if (not classColorHex and string.upper(tradeWhoClass) == "SHAMAN") then
		classColorHex = "ff0070dd";
	elseif (not classColorHex) then
		classColorHex = "ffffffff";
	end
	if (playerMoney > 0) then
		if (NIT.db.global.showMoneyTradedChat) then
			NIT:print("|HNITCustomLink:tradelog|h|cFF9CD6DE" .. L["gave"] .. "|r|h |r" .. NIT:getCoinString(playerMoney)
					.. NIT.chatColor .. " |HNITCustomLink:tradelog|h|cFF9CD6DE" .. L["to"] .. "|r |c"
					.. classColorHex .. tradeWho .. NIT.chatColor .. ".|h", nil, nil, true, true);
		end
		traded = true;
	end
	if (targetMoney > 0) then
		if (NIT.db.global.showMoneyTradedChat) then
			NIT:print("|HNITCustomLink:tradelog|h|cFF9CD6DE" .. L["received"] .. "|r|h |r" .. NIT:getCoinString(targetMoney)
					.. NIT.chatColor .. " |HNITCustomLink:tradelog|h|cFF9CD6DE" .. L["from"] .. "|r |c"
					.. classColorHex .. tradeWho .. NIT.chatColor .. ".|h", nil, nil, true, true);
		end
		traded = true;
	end
	if (not NIT.data.trades) then
		NIT.data.trades = {};
	end
	local where = GetZoneText() or "";
	if (NIT.inInstance) then
		local instanceName = GetInstanceInfo();
		where = instanceName;
	end
	if (traded) then
		local t = {
			playerMoney = playerMoney,
			targetMoney = targetMoney,
			tradeWho = tradeWho,
			tradeWhoClass = tradeWhoClass,
			where = where,
			time = GetServerTime(),
		};
		table.insert(NIT.data.trades, 1, t);
	end
	NIT:resetCurrentTradeData();
end

function NIT:resetCurrentTradeData()
	playerMoney, targetMoney, tradeWho, tradeWhoClass = 0, 0, "", "";
end

---Some intergration for softres.it
--instanceType can be raid/dungeon/unknown.
--isReload is if we did a reload inside a dungeon.
--isLogon is if we relogged inside a dungeon.
function NIT:pushInstanceEntered(instanceName, instanceID, instanceType, isReload, isLogon)
	if (Softresit and Softresit.NIT_ENTERED) then
		Softresit:NIT_ENTERED(instanceName, instanceID, instanceType, isReload, isLogon);
	end
end

function NIT:pushInstanceLeft(instanceName, instanceID)
	if (Softresit and Softresit.NIT_LEFT) then
		Softresit:NIT_LEFT(instanceName, instanceID);
	end
end

--Same instance as last we entered confirmed via NPC data (done only once mobs are seen).
function NIT:pushSameInstanceConfirmed(instanceName, instanceID)
	if (Softresit and Softresit.NIT_SAME_INSTANCE) then
		Softresit:NIT_SAME_INSTANCE(instanceName, instanceID);
	end
end

--Different instance than last we entered confirmed via NPC data (done only once mobs are seen).
function NIT:pushDifferentInstanceConfirmed(instanceName, instanceID)
	if (Softresit and Softresit.NIT_SAME_INSTANCE) then
		Softresit:NIT_DIFFERENT_INSTANCE(instanceName, instanceID);
	end
end