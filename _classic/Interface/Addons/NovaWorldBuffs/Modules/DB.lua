-------------------
---NovaWorldBuffs--
-------------------

--Slowly moving all settings and buff data in to this file so things are easier to change around and add new buffs as classic/sod keeps getting changes.

local addonName, addon = ...;
--local addonName, NWB = ...;
addon.a = LibStub("AceAddon-3.0"):NewAddon("NovaWorldBuffs", "AceComm-3.0");
local NWB = addon.a;
--local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");
NWB.expansionNum = 1;
if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
	NWB.isClassic = true;
	if (C_Seasons and C_Seasons.GetActiveSeason() == 2) then
		NWB.isSOD = true;
	end
	if (C_GameRules and C_GameRules.IsHardcoreActive()) then
		NWB.isHardcore = true;
	end
elseif (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC) then
	NWB.isTBC = true;
	NWB.expansionNum = 2;
elseif (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC) then
	NWB.isWrath = true;
	NWB.expansionNum = 3;
elseif (WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC) then
	if (GetRealmName() ~= "Classic Beta PvE" and GetServerTime() < 1716127200) then --Sun May 19 2024 14:00:00 GMT;
		NWB.isPrepatch = true;
		NWB.isCataPrepatch = true;
	end
	NWB.isCata = true;
	NWB.expansionNum = 4;
elseif (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC) then
	NWB.isMOP = true; --Later expansion project id's will likely need updating once Blizzard decides on the names.
	NWB.expansionNum = 5;
elseif (WOW_PROJECT_ID == WOW_PROJECT_WARLORDS_CLASSIC) then
	NWB.isWOD = true;
	NWB.expansionNum = 6;
elseif (WOW_PROJECT_ID == WOW_PROJECT_LEGION_CLASSIC) then
	NWB.isLegion = true;
	NWB.expansionNum = 7;
elseif (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
	NWB.isRetail = true;
	NWB.expansionNum = 10;
end

--Temporary until actual launch.
--if (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC) then
	--This basically meant prepatch, some things were still enabled.
--	NWB.realmsTBC = true;
--end

NWB.rendCooldownTime = 10800;
NWB.onyCooldownTime = 21600;
NWB.nefCooldownTime = 28800;
NWB.zanCooldownTime = 28800; --Not used but left here so some older stuff doesn't break.
--NWB.noWorldBuffTimers = false; --Hides timers on certain frames and minimap button tooltip, should be used if all rend/ony/nef cooldown times are set to 0 like in SoD.
NWB.yellPercent = 100; --Capital city logon chance to share data via yell, will be adjusted later when timer cooldown changes stabilize.
NWB.buffDropSpamCooldown = 0; --Spam control for buff drops, Might of Stormwind has it's own longer delay in WorldBuffs.lua
NWB.buffDropSpamCooldownSoD = 300; --Longer cooldown for the spammy SoD buff drops (Boon of Blackfathom, Ashenvale Rallying Cry, Fervor of the Temple Explorer).

if (NWB.isSOD) then
	NWB.noWorldBuffTimers = true; --Hides timers on certain frames and minimap button tooltip, should be used if all rend/ony/nef cooldown times are set to 0 like in SoD.
	NWB.noGuildBuffDroppedMsgs = true; --With no timers tracked the drops are alot more often and spammy, this removes the 2nd msg "buff dropped" and just keep the drop in few seconds warning.
	NWB.buffDropSpamCooldown = 900; --Spam control cooldown time between msgs for buff drops, might of stormwind has it's own longer delay in WorldBuffs.lua (as of now might of stormwind never sends a msg becaus no need)
	NWB.rendCooldownTime = 0; --0 means timer is disabled.
	NWB.onyCooldownTime = 0;
	NWB.nefCooldownTime = 0;
	NWB.noDmfCooldown = true;
elseif (NWB.isClassic) then
	NWB.nefCooldownTime = 0;
end

NWB.spellTypes = {
	--Classic.
	[16609] = {
		icon = "|TInterface\\Icons\\spell_arcane_teleportorgrimmar:12:12:0:0|t",
		fullName = "Warchief's Blessing",
		maxDuration = 3600,
		type = "rend",
		isBoonable = true,
	},
	[22888] = {
		icon = "|TInterface\\Icons\\inv_misc_head_dragon_01:12:12:0:0|t",
		fullName = "Rallying Cry of the Dragonslayer",
		maxDuration = 7200,
		type = "ony",
		type2 = "nef",
		isBoonable = true,
	},
	--[[["nef"] = {
		icon = "|TInterface\\Icons\\inv_misc_head_dragon_01:12:12:0:0|t",
		fullName = "Rallying Cry of the Dragonslayer",
		maxDuration = 7200,
		type = "nef",
	},]]
	[24425] = {
		icon = "|TInterface\\Icons\\ability_creature_poison_05:12:12:0:0|t",
		fullName = "Spirit of Zandalar",
		maxDuration = 7200,
		type = "zan",
		isBoonable = true,
	},
	--New spell ID's after hotfix 23/4/21.
	[355366] = {
		icon = "|TInterface\\Icons\\spell_arcane_teleportorgrimmar:12:12:0:0|t",
		fullName = "Warchief's Blessing",
		maxDuration = 3600,
		type = "rend",
		isBoonable = true,
	},
	[355363] = {
		icon = "|TInterface\\Icons\\inv_misc_head_dragon_01:12:12:0:0|t",
		fullName = "Rallying Cry of the Dragonslayer",
		maxDuration = 7200,
		type = "ony",
		type2 = "nef",
		isBoonable = true,
	},
	[355365] = {
		icon = "|TInterface\\Icons\\ability_creature_poison_05:12:12:0:0|t",
		fullName = "Spirit of Zandalar",
		maxDuration = 7200,
		type = "zan",
		isBoonable = true,
	},
	[22818] = {
		icon = "|TInterface\\Icons\\spell_nature_massteleport:12:12:0:0|t",
		fullName = "Mol'dar's Moxie",
		maxDuration = 7200,
		type = "moxie",
		isBoonable = true,
	},
	[22817] = {
		icon = "|TInterface\\Icons\\spell_nature_undyingstrength:12:12:0:0|t",
		fullName = "Fengus' Ferocity",
		maxDuration = 7200,
		type = "ferocity",
		isBoonable = true,
	},
	[22820] = {
		icon = "|TInterface\\Icons\\spell_holy_lesserheal02:12:12:0:0|t",
		fullName = "Slip'kik's Savvy",
		maxDuration = 7200,
		type = "savvy",
		isBoonable = true,
	},
	[17628] = { --Supreme Power.
		icon = "|TInterface\\Icons\\inv_potion_41:12:12:0:0|t",
		fullName = "Supreme Power",
		maxDuration = 7200,
		type = "flaskPower",
	},
	[17626] = { --Flask of the Titans (only flask spell with Flask in the name, dunno why).
		icon = "|TInterface\\Icons\\inv_potion_62:12:12:0:0|t",
		fullName = "Flask of the Titans",
		maxDuration = 7200,
		type = "flaskTitans",
	},
	[17627] = { --Distilled Wisdom.
		icon = "|TInterface\\Icons\\inv_potion_97:12:12:0:0|t",
		fullName = "Distilled Wisdom",
		maxDuration = 7200,
		type = "flaskWisdom",
	},
	[17629] = { --Chromatic Resistance.
		icon = "|TInterface\\Icons\\inv_potion_48:12:12:0:0|t",
		fullName = "Flask of Chromatic Resistance",
		maxDuration = 7200,
		type = "flaskResistance",
	},
	[15366] = {
		icon = "|TInterface\\Icons\\spell_holy_mindvision:12:12:0:0|t",
		fullName = "Songflower Serenade",
		maxDuration = 3600,
		type = "songflower",
		isBoonable = true,
	},
	[15123] = {
		icon = "|TInterface\\Icons\\spell_fire_firearmor:12:12:0:0|t",
		fullName = "Resist Fire",
		maxDuration = 3600,
		type = "resistFire",
	},
	[8733] = {
		icon = "|TInterface\\Icons\\spell_frost_frostward:12:12:0:0|t",
		fullName = "Blessing of Blackfathom",
		maxDuration = 3600,
		type = "blackfathom",
	},
	[29235] = {
		icon = "|TInterface\\Icons\\inv_summerfest_firespirit:12:12:0:0|t",
		fullName = "Fire Festival Fortitude",
		maxDuration = 3600,
		type = "festivalFortitude",
	},
	[29846] = {
		icon = "|TInterface\\Icons\\inv_misc_summerfest_brazierorange:12:12:0:0|t",
		fullName = "Fire Festival Fury",
		maxDuration = 3600,
		type = "festivalFury",
	},
	[29338] = {
		icon = "|TInterface\\Icons\\inv_misc_summerfest_brazierorange:12:12:0:0|t",
		fullName = "Fire Festival Fury",
		maxDuration = 3600,
		type = "festivalFury",
	},
	[29175] = {
		icon = "|TInterface\\Icons\\inv_summerfest_symbol_medium:12:12:0:0|t",
		fullName = "Ribbon Dance",
		maxDuration = 3600,
		type = "ribbonDance",
	},
	[29534] = { --Traces of Silithyst.
		icon = "|TInterface\\Icons\\spell_nature_timestop:12:12:0:0|t",
		fullName = "Traces of Silithyst",
		maxDuration = 3600,
		type = "silithyst",
	},
	[24417] = {
		icon = "|TInterface\\Icons\\inv_potion_29:12:12:0:0|t",
		fullName = "Sheen of Zanza",
		maxDuration = 7200,
		type = "sheenZanza",
	},
	[24382] = {
		icon = "|TInterface\\Icons\\inv_potion_30:12:12:0:0|t",
		fullName = "Spirit of Zanza",
		maxDuration = 7200,
		type = "spiritZanza",
	},
	[24383] = {
		icon = "|TInterface\\Icons\\inv_potion_31:12:12:0:0|t",
		fullName = "Swiftness of Zanza",
		maxDuration = 7200,
		type = "swiftZanza",
	},
	[25101] = {
		icon = "|TInterface\\Icons\\ability_warrior_battleshout:12:12:0:0|t",
		fullName = "Battle Shout",
		maxDuration = 900,
		type = "battleShout",
	},
	--TBC.
	[28518] = {
		icon = "|TInterface\\Icons\\inv_potion_119:12:12:0:0|t",
		fullName = "Flask of Fortification",
		maxDuration = 7200,
		type = "flaskFort",
	},
	[28591] = {
		icon = "|TInterface\\Icons\\inv_potion_115:12:12:0:0|t",
		fullName = "Flask of Pure Death",
		maxDuration = 7200,
		type = "flaskPure",
	},
	[28520] = {
		icon = "|TInterface\\Icons\\inv_potion_117:12:12:0:0|t",
		fullName = "Flask of Relentless Assault",
		maxDuration = 7200,
		type = "flaskRelent",
	},
	[28521] = {
		icon = "|TInterface\\Icons\\inv_potion_116:12:12:0:0|t",
		fullName = "Flask of Blinding Light",
		maxDuration = 7200,
		type = "flaskBlinding",
	},
	[28519] = {
		icon = "|TInterface\\Icons\\inv_potion_118:12:12:0:0|t",
		fullName = "Flask of Mighty Restoration",
		maxDuration = 7200,
		type = "flaskMighty",
	},
	[42735] = {
		icon = "|TInterface\\Icons\\inv_potion_48:12:12:0:0|t",
		fullName = "Flask of Chromatic Wonder",
		maxDuration = 7200,
		type = "flaskChromatic",
	},
	--Shat flasks have 2 or 3 spells the same, have to test after launch which is correct for each.
	[41607] = {
		icon = "|TInterface\\Icons\\inv_potion_119:12:12:0:0|t",
		fullName = "Fortification of Shattrath",
		maxDuration = 7200,
		type = "shattrathFlaskFort",
	},
	[41609] = {
		icon = "|TInterface\\Icons\\inv_potion_119:12:12:0:0|t",
		fullName = "Fortification of Shattrath",
		maxDuration = 7200,
		type = "shattrathFlaskFort",
	},
	[46837] = {
		icon = "|TInterface\\Icons\\inv_potion_115:12:12:0:0|t",
		fullName = "Pure Death of Shattrath",
		maxDuration = 7200,
		type = "shattrathFlaskPure",
	},
	[46838] = {
		icon = "|TInterface\\Icons\\inv_potion_115:12:12:0:0|t",
		fullName = "Pure Death of Shattrath",
		maxDuration = 7200,
		type = "shattrathFlaskPure",
	},
	[41606] = {
		icon = "|TInterface\\Icons\\inv_potion_117:12:12:0:0|t",
		fullName = "Relentless Assault of Shattrath",
		maxDuration = 7200,
		type = "shattrathFlaskRelent",
	},
	[41608] = {
		icon = "|TInterface\\Icons\\inv_potion_117:12:12:0:0|t",
		fullName = "Relentless Assault of Shattrath",
		maxDuration = 7200,
		type = "shattrathFlaskRelent",
	},
	[46839] = {
		icon = "|TInterface\\Icons\\inv_potion_116:12:12:0:0|t",
		fullName = "Blinding Light of Shattrath",
		maxDuration = 7200,
		type = "shattrathFlaskBlinding",
	},
	[46840] = {
		icon = "|TInterface\\Icons\\inv_potion_116:12:12:0:0|t",
		fullName = "Blinding Light of Shattrath",
		maxDuration = 7200,
		type = "shattrathFlaskBlinding",
	},
	[41605] = {
		icon = "|TInterface\\Icons\\inv_potion_118:12:12:0:0|t",
		fullName = "Mighty Restoration of Shattrath",
		maxDuration = 7200,
		type = "shattrathFlaskMighty",
	},
	[41610] = {
		icon = "|TInterface\\Icons\\inv_potion_118:12:12:0:0|t",
		fullName = "Mighty Restoration of Shattrath",
		maxDuration = 7200,
		type = "shattrathFlaskMighty",
	},
	[41604] = {
		icon = "|TInterface\\Icons\\inv_potion_41:12:12:0:0|t",
		fullName = "Supreme Power of Shattrath",
		maxDuration = 7200,
		type = "shattrathFlaskSupreme",
	},
	[41611] = {
		icon = "|TInterface\\Icons\\inv_potion_41:12:12:0:0|t",
		fullName = "Supreme Power of Shattrath",
		maxDuration = 7200,
		type = "shattrathFlaskSupreme",
	},
	[40572] = {
		icon = "|TInterface\\Icons\\inv_potion_35:12:12:0:0|t",
		fullName = "Unstable Flask of the Beast",
		maxDuration = 7200,
		type = "unstableFlaskBeast",
	},
	[40580] = {
		icon = "|TInterface\\Icons\\inv_potion_35:12:12:0:0|t",
		fullName = "Unstable Flask of the Beast",
		maxDuration = 7200,
		type = "unstableFlaskBeast",
	},
	[40576] = {
		icon = "|TInterface\\Icons\\inv_potion_42:12:12:0:0|t",
		fullName = "Unstable Flask of the Sorcerer",
		maxDuration = 7200,
		type = "unstableFlaskSorcerer",
	},
	[40588] = {
		icon = "|TInterface\\Icons\\inv_potion_42:12:12:0:0|t",
		fullName = "Unstable Flask of the Sorcerer",
		maxDuration = 7200,
		type = "unstableFlaskSorcerer",
	},
	[40763] = {
		icon = "|TInterface\\Icons\\inv_potion_42:12:12:0:0|t",
		fullName = "Unstable Flask of the Sorcerer",
		maxDuration = 7200,
		type = "unstableFlaskSorcerer",
	},
	[40567] = {
		icon = "|TInterface\\Icons\\inv_potion_91:12:12:0:0|t",
		fullName = "Unstable Flask of the Bandit",
		maxDuration = 7200,
		type = "unstableFlaskBandit",
	},
	[40577] = {
		icon = "|TInterface\\Icons\\inv_potion_91:12:12:0:0|t",
		fullName = "Unstable Flask of the Bandit",
		maxDuration = 7200,
		type = "unstableFlaskBandit",
	},
	[40579] = {
		icon = "|TInterface\\Icons\\inv_potion_91:12:12:0:0|t",
		fullName = "Unstable Flask of the Bandit",
		maxDuration = 7200,
		type = "unstableFlaskBandit",
	},
	[40568] = {
		icon = "|TInterface\\Icons\\inv_potion_77:12:12:0:0|t",
		fullName = "Unstable Flask of the Elder",
		maxDuration = 7200,
		type = "unstableFlaskElder",
	},
	[40582] = {
		icon = "|TInterface\\Icons\\inv_potion_77:12:12:0:0|t",
		fullName = "Unstable Flask of the Elder",
		maxDuration = 7200,
		type = "unstableFlaskElder",
	},
	[40573] = {
		icon = "|TInterface\\Icons\\inv_potion_70:12:12:0:0|t",
		fullName = "Unstable Flask of the Physician",
		maxDuration = 7200,
		type = "unstableFlaskPhysician",
	},
	[40586] = {
		icon = "|TInterface\\Icons\\inv_potion_70:12:12:0:0|t",
		fullName = "Unstable Flask of the Physician",
		maxDuration = 7200,
		type = "unstableFlaskPhysician",
	},
	[40575] = {
		icon = "|TInterface\\Icons\\inv_potion_84:12:12:0:0|t",
		fullName = "Unstable Flask of the Soldier",
		maxDuration = 7200,
		type = "unstableFlaskSoldier",
	},
	[40587] = {
		icon = "|TInterface\\Icons\\inv_potion_84:12:12:0:0|t",
		fullName = "Unstable Flask of the Soldier",
		maxDuration = 7200,
		type = "unstableFlaskSoldier",
	},
	--SoD.
	[430947] = {
		icon = "|TInterface\\Icons\\achievement_boss_bazil_akumai:12:12:0:0|t",
		fullName = "Boon of Blackfathom",
		maxDuration = 7200,
		type = "boonOfBlackfathom",
		isBoonable = true,
	},
	[430352] = {
		icon = "|TInterface\\Icons\\spell_misc_warsongfocus:12:12:0:0|t",
		fullName = "Ashenvale Rallying Cry",
		maxDuration = 7200,
		type = "ashenvaleRallyingCry",
	},
	[438536] = { --Why is there 2 the same? Horde and Alliance perhaps?
		icon = "|T236424:12:12:0:0|t", --achievement_boss_mekgineer_thermaplugg- seemed bugged, id works though.
		fullName = "Spark of Inspiration",
		maxDuration = 7200,
		type = "sparkOfInspiration",
		isBoonable = true,
	},
	[438537] = {
		icon = "|T236424:12:12:0:0|t", --achievement_boss_mekgineer_thermaplugg- seemed bugged, id works though.
		fullName = "Spark of Inspiration",
		maxDuration = 7200,
		type = "sparkOfInspiration",
		isBoonable = true,
	},
	[446695] = {
		icon = "|TInterface\\Icons\\achievement_bg_killxenemies_generalsroom:12:12:0:0|t",
		fullName = "Fervor of the Temple Explorer",
		maxDuration = 7200,
		type = "fervorTempleExplorer",
		isBoonable = true,
	},
	[446698] = {
		icon = "|TInterface\\Icons\\achievement_bg_killxenemies_generalsroom:12:12:0:0|t",
		fullName = "Fervor of the Temple Explorer",
		maxDuration = 7200,
		type = "fervorTempleExplorer",
		isBoonable = true,
	},
	[460939] = {
		icon = "|TInterface\\Icons\\spell_arcane_teleportstormwind:12:12:0:0|t",
		fullName = "Might of Stormwind",
		maxDuration = 7200,
		type = "mightOfStormwind",
		isBoonable = true,
	},
	[460940] = {
		icon = "|TInterface\\Icons\\spell_arcane_teleportstormwind:12:12:0:0|t",
		fullName = "Might of Stormwind",
		maxDuration = 7200,
		type = "mightOfStormwind",
		isBoonable = true,
	},
	
	
	[23736] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Agility",
		maxDuration = 7200,
		type = "dmf",
		isBoonable = true,
	},
	[23766] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Intelligence",
		maxDuration = 7200,
		type = "dmf",
		isBoonable = true,
	},
	[23738] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Spirit",
		maxDuration = 7200,
		type = "dmf",
		isBoonable = true,
	},
	[23737] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Stamina",
		maxDuration = 7200,
		type = "dmf",
		isBoonable = true,
	},
	[23735] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Strength",
		maxDuration = 7200,
		type = "dmf",
		isBoonable = true,
	},
	[23767] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Armor",
		maxDuration = 7200,
		type = "dmf",
		isBoonable = true,
	},
	[23769] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Resistance",
		maxDuration = 7200,
		type = "dmf",
		isBoonable = true,
	},
	[23768] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Damage",
		maxDuration = 7200,
		type = "dmf",
		isBoonable = true,
	},
};



















--[[
NWB.spellTypes = {
	--Classic.
	[16609] = "rend",
	[22888] = "ony",
	[24425] = "zan",
	--New spell ID's after hotfix 23/4/21.
	[355366] = "rend",
	[355363] = "ony",
	[355365] = "zan",
	[23768] = "dmf", --Sayge's Dark Fortune of Damage
	[23769] = "dmf", --Sayge's Dark Fortune of Resistance
	[23767] = "dmf", --Sayge's Dark Fortune of Armor
	[23766] = "dmf", --Sayge's Dark Fortune of Intelligence
	[23738] = "dmf", --Sayge's Dark Fortune of Spirit
	[23737] = "dmf", --Sayge's Dark Fortune of Stamina
	[23735] = "dmf", --Sayge's Dark Fortune of Strength
	[23736] = "dmf", --Sayge's Dark Fortune of Agility
	[22818] = "moxie",
	[22817] = "ferocity",
	[22820] = "savvy",
	[17628] = "flaskPower", --Supreme Power.
	[17626] = "flaskTitans", --Flask of the Titans (only flask spell with Flask in the name, dunno why).
	[17627] = "flaskWisdom", --Distilled Wisdom.
	[17629] = "flaskResistance", --Chromatic Resistance.
	[15366] = "songflower",
	[15123] = "resistFire", --LBRS fire resist buff.
	[8733] = "blackfathom", --Blessing of Blackfathom
	[29235] = "festivalFortitude", --Fire Festival Fortitude
	[29846] = "festivalFury", --Fire Festival Fury
	[29338] = "festivalFury", --Fire Festival Fury 2 diff types? aoe and single version possibly?
	[29175] = "ribbonDance", --Fire Festival Fortitude
	[29534] = "silithyst", --Traces of Silithyst
	[24417] = "sheenZanza",
	[24382] = "spiritZanza",
	[24383] = "swiftZanza",
	[25101] = "battleShout",
	--TBC.
	[28518] = "flaskFort",
	[28591] = "flaskPure",
	[28520] = "flaskRelent",
	[28521] = "flaskBlinding",
	[28519] = "flaskMighty",
	[42735] = "flaskChromatic",
	--Shat flasks have 2 or 3 spells the same, have to test after launch which is correct for each.
	[41607] = "shattrathFlaskFort",
	[41609] = "shattrathFlaskFort",
	[46837] = "shattrathFlaskPure",
	[46838] = "shattrathFlaskPure",
	[41606] = "shattrathFlaskRelent",
	[41608] = "shattrathFlaskRelent",
	[46839] = "shattrathFlaskBlinding",
	[46840] = "shattrathFlaskBlinding",
	[41605] = "shattrathFlaskMighty",
	[41610] = "shattrathFlaskMighty",
	[41604] = "shattrathFlaskSupreme",
	[41611] = "shattrathFlaskSupreme",
	[40572] = "unstableFlaskBeast",
	[40580] = "unstableFlaskBeast",
	[40576] = "unstableFlaskSorcerer",
	[40588] = "unstableFlaskSorcerer",
	[40763] = "unstableFlaskSorcerer",
	[40567] = "unstableFlaskBandit",
	[40577] = "unstableFlaskBandit",
	[40579] = "unstableFlaskBandit",
	[40568] = "unstableFlaskElder",
	[40582] = "unstableFlaskElder",
	[40573] = "unstableFlaskPhysician",
	[40586] = "unstableFlaskPhysician",
	[40575] = "unstableFlaskSoldier",
	[40587] = "unstableFlaskSoldier",
	--SoD.
	[430947] = "boonOfBlackfathom",
	[430352] = "ashenvaleRallyingCry",
	[438536] = "sparkOfInspiration", --Why is there 2 the same? Horde and Alliance perhaps?
	[438537] = "sparkOfInspiration",
	[446695] = "fervorTempleExplorer",
	[446698] = "fervorTempleExplorer",
	[460939] = "mightOfStormwind",
	[460940] = "mightOfStormwind",
}; 
		
NWB.buffTable = {
	--Classic.
	["rend"] = {
		icon = "|TInterface\\Icons\\spell_arcane_teleportorgrimmar:12:12:0:0|t",
		fullName = "Warchief's Blessing",
		maxDuration = 3600,
	},
	["ony"] = {
		icon = "|TInterface\\Icons\\inv_misc_head_dragon_01:12:12:0:0|t",
		fullName = "Rallying Cry of the Dragonslayer",
		maxDuration = 7200,
	},
	["nef"] = {
		icon = "|TInterface\\Icons\\inv_misc_head_dragon_01:12:12:0:0|t",
		fullName = "Rallying Cry of the Dragonslayer",
		maxDuration = 7200,
	},
	["dmf"] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Darkmoon Faire",
		maxDuration = 7200,
	},
	--These are just here for matching type to fullName, spell detection was messed up after some spellID changes by Blizzard.
	["zan"] = {
		icon = "|TInterface\\Icons\\ability_creature_poison_05:12:12:0:0|t",
		fullName = "Spirit of Zandalar",
		maxDuration = 7200,
	},
	["moxie"] = {
		icon = "|TInterface\\Icons\\spell_nature_massteleport:12:12:0:0|t",
		fullName = "Mol'dar's Moxie",
		maxDuration = 7200,
	},
	["ferocity"] = {
		icon = "|TInterface\\Icons\\spell_nature_undyingstrength:12:12:0:0|t",
		fullName = "Fengus' Ferocity",
		maxDuration = 7200,
	},
	["savvy"] = {
		icon = "|TInterface\\Icons\\spell_holy_lesserheal02:12:12:0:0|t",
		fullName = "Slip'kik's Savvy",
		maxDuration = 7200,
	},
	["flaskPower"] = {
		icon = "|TInterface\\Icons\\inv_potion_41:12:12:0:0|t",
		fullName = "Supreme Power",
		maxDuration = 7200,
	},
	["flaskTitans"] = {
		icon = "|TInterface\\Icons\\inv_potion_62:12:12:0:0|t",
		fullName = "Flask of the Titans",
		maxDuration = 7200,
	},
	["flaskWisdom"] = {
		icon = "|TInterface\\Icons\\inv_potion_97:12:12:0:0|t",
		fullName = "Distilled Wisdom",
		maxDuration = 7200,
	},
	["flaskResistance"] = {
		icon = "|TInterface\\Icons\\inv_potion_48:12:12:0:0|t",
		fullName = "Flask of Chromatic Resistance",
		maxDuration = 7200,
	},
	["songflower"] = {
		icon = "|TInterface\\Icons\\spell_holy_mindvision:12:12:0:0|t",
		fullName = "Songflower Serenade",
		maxDuration = 3600,
	},
	["resistFire"] = {
		icon = "|TInterface\\Icons\\spell_fire_firearmor:12:12:0:0|t",
		fullName = "Resist Fire",
		maxDuration = 3600,
	},
	["blackfathom"] = {
		icon = "|TInterface\\Icons\\spell_frost_frostward:12:12:0:0|t",
		fullName = "Blessing of Blackfathom",
		maxDuration = 3600,
	},
	["festivalFortitude"] = {
		icon = "|TInterface\\Icons\\inv_summerfest_firespirit:12:12:0:0|t",
		fullName = "Fire Festival Fortitude",
		maxDuration = 3600,
	},
	["festivalFury"] = {
		icon = "|TInterface\\Icons\\inv_misc_summerfest_brazierorange:12:12:0:0|t",
		fullName = "Fire Festival Fury",
		maxDuration = 3600,
	},
	["ribbonDance"] = {
		icon = "|TInterface\\Icons\\inv_summerfest_symbol_medium:12:12:0:0|t",
		fullName = "Ribbon Dance",
		maxDuration = 3600,
	},
	["silithyst"] = {
		icon = "|TInterface\\Icons\\spell_nature_timestop:12:12:0:0|t",
		fullName = "Traces of Silithyst",
		maxDuration = 3600,
	},
	["sheenZanza"] = {
		icon = "|TInterface\\Icons\\inv_potion_29:12:12:0:0|t",
		fullName = "Sheen of Zanza",
		maxDuration = 7200,
	},
	["spiritZanza"] = {
		icon = "|TInterface\\Icons\\inv_potion_30:12:12:0:0|t",
		fullName = "Spirit of Zanza",
		maxDuration = 7200,
	},
	["swiftZanza"] = {
		icon = "|TInterface\\Icons\\inv_potion_31:12:12:0:0|t",
		fullName = "Swiftness of Zanza",
		maxDuration = 7200,
	},
	["battleShout"] = {
		icon = "|TInterface\\Icons\\ability_warrior_battleshout:12:12:0:0|t",
		fullName = "Battle Shout",
		maxDuration = 900,
	},
	--TBC.
	["flaskFort"] = {
		icon = "|TInterface\\Icons\\inv_potion_119:12:12:0:0|t",
		fullName = "Flask of Fortification",
		maxDuration = 7200,
	},
	["flaskPure"] = {
		icon = "|TInterface\\Icons\\inv_potion_115:12:12:0:0|t",
		fullName = "Flask of Pure Death",
		maxDuration = 7200,
	},
	["flaskRelent"] = {
		icon = "|TInterface\\Icons\\inv_potion_117:12:12:0:0|t",
		fullName = "Flask of Relentless Assault",
		maxDuration = 7200,
	},
	["flaskBlinding"] = {
		icon = "|TInterface\\Icons\\inv_potion_116:12:12:0:0|t",
		fullName = "Flask of Blinding Light",
		maxDuration = 7200,
	},
	["flaskMighty"] = {
		icon = "|TInterface\\Icons\\inv_potion_118:12:12:0:0|t",
		fullName = "Flask of Mighty Restoration",
		maxDuration = 7200,
	},
	["flaskChromatic"] = {
		icon = "|TInterface\\Icons\\inv_potion_48:12:12:0:0|t",
		fullName = "Flask of Chromatic Wonder",
		maxDuration = 7200,
	},
	["shattrathFlaskFort"] = {
		icon = "|TInterface\\Icons\\inv_potion_119:12:12:0:0|t",
		fullName = "Fortification of Shattrath",
		maxDuration = 7200,
	},
	["shattrathFlaskPure"] = {
		icon = "|TInterface\\Icons\\inv_potion_115:12:12:0:0|t",
		fullName = "Pure Death of Shattrath",
		maxDuration = 7200,
	},
	["shattrathFlaskRelent"] = {
		icon = "|TInterface\\Icons\\inv_potion_117:12:12:0:0|t",
		fullName = "Relentless Assault of Shattrath",
		maxDuration = 7200,
	},
	["shattrathFlaskBlinding"] = {
		icon = "|TInterface\\Icons\\inv_potion_116:12:12:0:0|t",
		fullName = "Blinding Light of Shattrath",
		maxDuration = 7200,
	},
	["shattrathFlaskMighty"] = {
		icon = "|TInterface\\Icons\\inv_potion_118:12:12:0:0|t",
		fullName = "Mighty Restoration of Shattrath",
		maxDuration = 7200,
	},
	["shattrathFlaskSupreme"] = {
		icon = "|TInterface\\Icons\\inv_potion_41:12:12:0:0|t",
		fullName = "Supreme Power of Shattrath",
		maxDuration = 7200,
	},
	["unstableFlaskBeast"] = {
		icon = "|TInterface\\Icons\\inv_potion_35:12:12:0:0|t",
		--icon = "|TInterface\\Icons\\inv_potion_91:12:12:0:0|t",
		fullName = "Unstable Flask of the Beast",
		maxDuration = 7200,
	},
	["unstableFlaskSorcerer"] = {
		icon = "|TInterface\\Icons\\inv_potion_42:12:12:0:0|t",
		--icon = "|TInterface\\Icons\\inv_potion_91:12:12:0:0|t",
		fullName = "Unstable Flask of the Sorcerer",
		maxDuration = 7200,
	},
	["unstableFlaskBandit"] = {
		icon = "|TInterface\\Icons\\inv_potion_91:12:12:0:0|t",
		fullName = "Unstable Flask of the Bandit",
		maxDuration = 7200,
	},
	["unstableFlaskElder"] = {
		icon = "|TInterface\\Icons\\inv_potion_77:12:12:0:0|t",
		--icon = "|TInterface\\Icons\\inv_potion_91:12:12:0:0|t",
		fullName = "Unstable Flask of the Elder",
		maxDuration = 7200,
	},
	["unstableFlaskPhysician"] = {
		icon = "|TInterface\\Icons\\inv_potion_70:12:12:0:0|t",
		--icon = "|TInterface\\Icons\\inv_potion_91:12:12:0:0|t",
		fullName = "Unstable Flask of the Physician",
		maxDuration = 7200,
	},
	["unstableFlaskSoldier"] = {
		icon = "|TInterface\\Icons\\inv_potion_84:12:12:0:0|t",
		--icon = "|TInterface\\Icons\\inv_potion_91:12:12:0:0|t",
		fullName = "Unstable Flask of the Soldier",
		maxDuration = 7200,
	},
	--SoD.
	["boonOfBlackfathom"] = {
		icon = "|TInterface\\Icons\\achievement_boss_bazil_akumai:12:12:0:0|t",
		fullName = "Boon of Blackfathom",
		maxDuration = 7200,
	},
	["ashenvaleRallyingCry"] = {
		icon = "|TInterface\\Icons\\spell_misc_warsongfocus:12:12:0:0|t",
		fullName = "Ashenvale Rallying Cry",
		maxDuration = 7200,
	},
	["sparkOfInspiration"] = {
		icon = "|T236424:12:12:0:0|t", --achievement_boss_mekgineer_thermaplugg- seemed bugged, id works though.
		fullName = "Spark of Inspiration",
		maxDuration = 7200,
	},
	["fervorTempleExplorer"] = {
		icon = "|TInterface\\Icons\\achievement_bg_killxenemies_generalsroom:12:12:0:0|t",
		fullName = "Fervor of the Temple Explorer",
		maxDuration = 7200,
	},
	["mightOfStormwind"] = {
		icon = "|TInterface\\Icons\\spell_arcane_teleportstormwind:12:12:0:0|t",
		fullName = "Might of Stormwind",
		maxDuration = 7200,
	},
};

NWB.dmfBuffTable = {
	["dmfagility"] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Agility",
		maxDuration = 7200,
		type = "dmf",
	},
	["dmfintelligence"] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Intelligence",
		maxDuration = 7200,
		type = "dmf",
	},
	["dmfspirit"] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Spirit",
		maxDuration = 7200,
		type = "dmf",
	},
	["dmfstamina"] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Stamina",
		maxDuration = 7200,
		type = "dmf",
	},
	["dmfstrength"] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Strength",
		maxDuration = 7200,
		type = "dmf",
	},
	["dmfarmor"] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Armor",
		maxDuration = 7200,
		type = "dmf",
	},
	["dmfresistance"] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Resistance",
		maxDuration = 7200,
		type = "dmf",
	},
	["dmfdamage"] = {
		icon = "|TInterface\\Icons\\inv_misc_orb_02:12:12:0:0|t",
		fullName = "Sayge's Dark Fortune of Damage",
		maxDuration = 7200,
		type = "dmf",
	},
};]]

--debug func to make sure no types were missing when changing system over to spellIDs.
--[[function test()
    for k, v in pairs(NWB.buffTable) do
        local found;
        for kk, vv in pairs(NWB.spellTypes) do
            if (k == vv.type or k == vv.type2) then
                found = true;
            end
        end
        if (not found) then
            print("missing", k);
        end
    end
end]]