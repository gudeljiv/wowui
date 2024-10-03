------------------------
---NovaInstanceTracker--
------------------------

local L = LibStub("AceLocale-3.0"):GetLocale("NovaInstanceTracker");
local lastLootNpcID, lastBossNpcID, lastBossTime;
local lastTargetBoss, lastTargetBossTime;
local tinsert = tinsert;

if (not NIT.isClassic) then
	return;
end

--Name needs to match the bosses table below, we lookup data via name since there are different npcIDs across different game versions.
local douses = {
	[1] = {name = "Magmadar", order = 1, rune = "Rune of Kress"},
	[2] = {name = "Gehennas", order = 2, rune = "Rune of Mohn"},
	[3] = {name = "Garr", order = 3, rune = "Rune of Blaz"},
	[4] = {name = "Baron Geddon", order = 4, rune = "Rune of Zeth"},
	[5] = {name = "Shazzrah", order = 5, rune = "Rune of Mazj"},
	[6] = {name = "Sulfuron Harbinger", order = 6, rune = "Rune of Koro"},
	[7] = {name = "Golemagg the Incinerator", order = 7, rune = "Rune of Theri"},
};

--Seperate table with both classic and SoD NPC IDs for faster lookups.
local bosses = {
	[11982] = "Magmadar",
	[228430] = "Magmadar",
	[12259] = "Gehennas",
	[228431] = "Gehennas",
	[12057] = "Garr",
	[228432] = "Garr",
	[12056] = "Baron Geddon",
	[228433] = "Baron Geddon",
	[12264] = "Shazzrah",
	[228434] = "Shazzrah",
	[12098] = "Sulfuron Harbinger",
	[228436] = "Sulfuron Harbinger",
	[11988] = "Golemagg the Incinerator",
	[228435] = "Golemagg the Incinerator",
};

local function getDousedStatus(name)
	local data = NIT.data.instances[1].douses;
	if (data) then
		for k, v in pairs(bosses) do
			--Compare both npcIDs for the supplied name.
			if (v == name) then
				if (data[k]) then
					return data[k];
				end
			end
		end
	end
end

local function getDataForBoss(name)
	for k, v in pairs(bosses) do
		if (v == name) then
			return v;
		end
	end
end

local function hasAnyID(ids)
	if (NIT.data.instances[1].douses) then
		for k, v in pairs(ids) do
			if (NIT.data.instances[1].douses[k]) then
				return true;
			end
		end
	end
end

local function getIDsForBoss(name)
	local ids = {};
	for k, v in pairs(bosses) do
		--Compare both npcIDs for the supplied name.
		if (v == name) then
			ids[k] = true;
		end
	end
	return ids;
end

function NIT:getDousesMinimapString()
	if (NIT.currentInstanceID == 409) then
		local text = "";
		local sorted = {};
		local count = 0;
		local dousedCount = 0;
		for k, v in pairs(douses) do
			local t = {
				npcID = k,
				name = v.name,
				order = v.order,
			};
			tinsert(sorted, t);
		end
		table.sort(sorted, function(a, b) return a.order < b.order end);
		for k, v in pairs(sorted) do
			count = count + 1;
			local data = getDousedStatus(v.name);
			local lootedString;
			if (data) then
				lootedString = "|cFF00FF00(" .. L["Doused"] .. ")|r";
				if (data.name) then
					if (data.name and data.name ~= "") then
						local _, _, _, classColorHex = GetClassColor(data.class);
						--Safeguard for weakauras/addons that like to overwrite and break the GetClassColor() function.
						if (not classColorHex and v.tradeWhoClass == "SHAMAN") then
							classColorHex = "ff0070dd";
						elseif (not classColorHex) then
							classColorHex = "ffffffff";
						end
						lootedString = lootedString .. " |cFF9CD6DE(|c" .. classColorHex .. data.name .. "|r)|r";
					end
				end
				dousedCount = dousedCount + 1;
			else
				lootedString = "|cFFFF0000(" .. L["Not Doused"] .. ")|r";
			end
			if (count == 1) then
				text = text .. "|cFFFFAE42".. v.name .. "|r  " .. lootedString;
			else
				text = text .. "\n|cFFFFAE42" .. v.name .. "|r  " .. lootedString;
			end
		end
		local lootedString
		if (dousedCount >= 7) then
			lootedString = "|cFF00FF00" .. dousedCount .. "/7|r";
		else
			lootedString = "|cFF9CD6DE " .. dousedCount .. "/7|r";
		end
		local header = "|cFFFFFF00" .. L["Aqual Quintessence"] .. "|r - " .. lootedString .. "\n";
		local disclaimer = "\n|cFF9CD6DENote: This douses module uses best guess based on\nlast boss killed and other factors, could be inaccurate.";
		if (text ~= "") then
			return header .. text .. disclaimer;
		end
	end
end

local function combatLogEventUnfiltered(...)
	local timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, 
			destName, destFlags, destRaidFlags, spellID, spellName = CombatLogGetCurrentEventInfo();
	if (NIT.currentInstanceID == 409) then
		--[[if (subEvent == "SPELL_CAST_SUCCESS" and spellID == 21358) then
			--print(CombatLogGetCurrentEventInfo())
			if (not NIT.data.instances[1].douses) then
				NIT.data.instances[1].douses = {};
			end
			NIT.data.instances[1].douses[lastBossNpcID] = {
				name = sourceName,
				class = class,
				time = GetServerTime();
			};
		elseif (subEvent == "UNIT_DIED" and NIT.inInstance and destGUID and string.match(destGUID, "Creature")) then]]
		if (subEvent == "UNIT_DIED" and NIT.inInstance and destGUID and string.match(destGUID, "Creature")) then
			local _, _, _, _, _, npcID = strsplit("-", destGUID);
			npcID = tonumber(npcID);
			if (bosses[npcID]) then
				lastBossNpcID = npcID;
				lastBossTime = GetServerTime();
			end
		end
	end
end

--As a backup or if we entered an old lockout, update the douses from the teleport npc in sod.
local function gossipShow()
	local npcGUID = UnitGUID("npc");
	local npcID;
	if (npcGUID) then
		_, _, _, _, _, npcID = strsplit("-", npcGUID);
	end
	if (not npcID) then
		return;
	end
	if (npcID == "229840") then
		local data = C_GossipInfo.GetOptions();
		if (data) then
			if (not NIT.data.instances[1].douses) then
				NIT.data.instances[1].douses = {};
			end
			for k, v in pairs(data) do
				for kk, vv in pairs(douses) do
					if (v.name and strmatch(v.name, vv.rune)) then
						local ids = getIDsForBoss(vv.name);
						if (ids) then
							if (not hasAnyID(ids)) then
								for id, _ in pairs(ids) do
									--Just insert both ids if none are found for that boss it doesn't matter, still displays correctly.
									if (not NIT.data.instances[1].douses[id]) then
										--if (not hasAnyID[id]) then
											NIT.data.instances[1].douses[id] = {
												name = "",
												time = GetServerTime();
											};
										--end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

local function mouseoverUnit()
	if (UnitIsDead("mouseover")) then
		local GUID = UnitGUID("mouseover");
		local unitType, npcID;
		if (GUID) then
			unitType, _, _, _, _, npcID = strsplit("-", GUID);
			if (npcID and bosses[npcID]) then
				lastTargetBoss = npcID;
				lastTargetBossTime = GetTime();
			end
		end
	end
end

local function unitSpellcastSucceeded(...)
	local unit, castGUID, spellID = ...;
	if (NIT.currentInstanceID == 409) then
		if (spellID == 21358) then
			NIT:debug("doused", unit, castGUID, UnitName(unit));
			if (not lastBossNpcID) then
				return;
			end
			if (not NIT.data.instances[1].douses) then
				NIT.data.instances[1].douses = {};
			end
			local name = UnitName(unit);
			local _, class = UnitClass(unit);
			--If last npc was shaz but shaz is done then use baron id
			if (unit == "player") then
				if (lastTargetBoss and lastTargetBossTime and GetTime() - lastTargetBossTime < 20) then
					--If we mouseover a boss and then douse we must be close to it so lock that in as the right boss.
					local _, myClass = UnitClass("player");
					NIT:sendGroupComm("douse " .. NIT.version .. " " .. lastTargetBoss .. " " .. myClass);
					NIT.data.instances[1].douses[lastTargetBoss] = {
						name = name,
						class = myClass,
						time = GetServerTime();
					};
				else
					NIT.data.instances[1].douses[lastBossNpcID] = {
						name = name,
						class = class,
						time = GetServerTime();
					};
				end
			else
				NIT.data.instances[1].douses[lastBossNpcID] = {
					name = name,
					class = class,
					time = GetServerTime();
				};
			end
		end
	end
end

function NIT:receivedDouse(data, sender, distribution)
	if (NIT.currentInstanceID == 409) then
		if (data) then
			local npcID, class = strsplit(" ", data, 2);
			if (npcID and tonumber(npcID)) then
				if (not NIT.data.instances[1].douses) then
					NIT.data.instances[1].douses = {};
				end
				local name, realm = strsplit("-", sender, 2);
				NIT.data.instances[1].douses[tonumber(npcID)] = {
					name = name,
					class = class,
					time = GetServerTime();
				};
			end
		end
	end
end

local f = CreateFrame("Frame");
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
f:RegisterEvent("GOSSIP_SHOW");
f:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
f:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
f:SetScript('OnEvent', function(self, event, ...)
	if (event == "UNIT_SPELLCAST_SUCCEEDED") then
		unitSpellcastSucceeded(...);
	elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		combatLogEventUnfiltered(...);
	elseif (event == "UPDATE_MOUSEOVER_UNIT") then
		if (NIT.currentInstanceID == 409) then
			mouseoverUnit();
		end
	elseif (event == "GOSSIP_SHOW") then
		gossipShow();
	end
end)