------------------------------------
---NovaInstance Tracker zones list--
------------------------------------

local L = LibStub("AceLocale-3.0"):GetLocale("NovaInstanceTracker");

NIT.zones = {
	--Dungeons (Classic).
	[33] = {
		name = L["Shadowfang Keep"],
		type = "dungeon",
		expansion = "classic",
	},
	[48] = {
		name = L["Blackfathom Deeps"],
		type = "dungeon",
		expansion = "classic",
	},
	[230] = {
		name = L["Blackrock Depths"],
		type = "dungeon",
		expansion = "classic",
	},
	[229] = {
		name = L["Blackrock Spire"],
		type = "dungeon",
		expansion = "classic",
	},
	[429] = {
		name = L["Dire Maul"],
		type = "dungeon",
		expansion = "classic",
	},
	[90] = {
		name = L["Gnomeregan"],
		type = "dungeon",
		expansion = "classic",
	},
	[349] = {
		name = L["Maraudon"],
		type = "dungeon",
		expansion = "classic",
	},
	[389] = {
		name = L["Ragefire Chasm"],
		type = "dungeon",
		expansion = "classic",
	},
	[129] = {
		name = L["Razorfen Downs"],
		type = "dungeon",
		expansion = "classic",
	},
	[47] = {
		name = L["Razorfen Kraul"],
		type = "dungeon",
		expansion = "classic",
	},
	[189] = {
		name = L["Scarlet Monastery"],
		type = "dungeon",
		expansion = "classic",
	},
	[1004] = { --New retail ID?
		name = L["Scarlet Monastery"],
		type = "dungeon",
		expansion = "classic",
	},
	[289] = {
		name = L["Scholomance"],
		type = "dungeon",
		expansion = "classic",
	},
	[1007] = { --New retail ID?
		name = L["Scholomance"],
		type = "dungeon",
		expansion = "classic",
	},
	[329] = {
		name = L["Stratholme"],
		type = "dungeon",
		expansion = "classic",
	},
	[36] = {
		name = L["The Deadmines"],
		type = "dungeon",
		expansion = "classic",
	},
	[34] = {
		name = L["The Stockade"],
		type = "dungeon",
		expansion = "classic",
	},
	[109] = {
		name = L["The Temple of Atal'Hakkar"],
		type = "dungeon",
		expansion = "classic",
	},
	[70] = {
		name = L["Uldaman"],
		type = "dungeon",
		expansion = "classic",
	},
	[43] = {
		name = L["Wailing Caverns"],
		type = "dungeon",
		expansion = "classic",
	},
	[209] = {
		name = L["Zul'Farrak"],
		type = "dungeon",
		expansion = "classic",
	},
	[2784] = {
		name = L["Demon Fall Canyon"],
		type = "dungeon",
		expansion = "classic", --SoD.
	},
	--Raids (Classic).
	[249] = {
		name = L["Onyxia's Lair"],
		type = "raid",
		expansion = "classic",
		noLockout = true,
	},
	[309] = {
		name = L["Zul'gurub"],
		type = "raid",
		expansion = "classic",
	},
	[409] = {
		name = L["Molten Core"],
		type = "raid",
		expansion = "classic",
		noLockout = true,
	},
	[469] = {
		name = L["Blackwing Lair"],
		type = "raid",
		expansion = "classic",
		noLockout = true,
		maxPlayers = 40,
	},
	[509] = {
		name = L["Ruins of Ahn'Qiraj"],
		type = "raid",
		expansion = "classic",
	},
	[531] = {
		name = L["Temple of Ahn'Qiraj"],
		type = "raid",
		expansion = "classic",
		noLockout = true,
	},
	[533] = {
		name = L["Naxxramas"],
		type = "raid",
		expansion = "classic",
		noLockout = true,
	},
	[2791] = {
		name = L["Storm Cliffs"],
		type = "raid",
		expansion = "classic", --SoD.
		noLockout = true,
	},
	[2789] = {
		name = L["The Tainted Scar"],
		type = "raid",
		expansion = "classic",
		noLockout = true,
	},
	[2804] = {
		name = L["The Crystal Vale"],
		type = "raid",
		expansion = "classic",
		noLockout = true,
	},
}

--Add expansions dungeons seperately so we can overwrite duplicate zoneids (like naxx) for later expansions.
if (NIT.expansionNum > 1) then
	--Dungeons (TBC).
	NIT.zones[558] = {
		name = L["Auchenai Crypts"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[543] = {
		name = L["Hellfire Ramparts"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[585] = {
		name = L["Magisters' Terrace"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[557] = {
		name = L["Mana-Tombs"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[560] = {
		name = L["Old Hillsbrad Foothills"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[556] = {
		name = L["Sethekk Halls"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[555] = {
		name = L["Shadow Labyrinth"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[552] = {
		name = L["The Arcatraz"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[269] = { --Is this low ID right?
		name = L["The Black Morass"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[542] = {
		name = L["The Blood Furnace"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[553] = {
		name = L["The Botanica"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[554] = {
		name = L["The Mechanar"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[540] = {
		name = L["The Shattered Halls"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[547] = {
		name = L["The Slave Pens"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[545] = {
		name = L["The Steamvault"],
		type = "dungeon",
		expansion = "tbc",
	};
	NIT.zones[546] = {
		name = L["The Underbog"],
		type = "dungeon",
		expansion = "tbc",
	};
	--Raids (TBC).
	NIT.zones[564] = {
		name = L["Black Temple"],
		type = "raid",
		expansion = "tbc",
		noLockout = true,
	};
	NIT.zones[565] = {
		name = L["Gruul's Lair"],
		type = "raid",
		expansion = "tbc",
		noLockout = true,
	};
	NIT.zones[534] = {
		name = L["Hyjal Summit"],
		type = "raid",
		expansion = "tbc",
		noLockout = true,
	};
	NIT.zones[532] = {
		name = L["Karazhan"],
		type = "raid",
		expansion = "tbc",
		noLockout = true, --Maybe has a lockout like 20m classic raids?
	};
	NIT.zones[544] = {
		name = L["Magtheridon's Lair"],
		type = "raid",
		expansion = "tbc",
		noLockout = true,
	};
	NIT.zones[548] = {
		name = L["Serpentshrine Cavern"],
		type = "raid",
		expansion = "tbc",
		noLockout = true,
	};
	NIT.zones[580] = {
		name = L["Sunwell Plateau"],
		type = "raid",
		expansion = "tbc",
		noLockout = true,
	};
	NIT.zones[550] = {
		name = L["Tempest Keep"],
		type = "raid",
		expansion = "tbc",
		noLockout = true,
	};
	NIT.zones[568] = {
		name = L["Zul'Aman"],
		type = "raid",
		expansion = "tbc",
		noLockout = true,
	};
end

if (NIT.expansionNum > 2) then
	--Wrath dungeons.
	NIT.zones[619] = {
		name = L["Ahn'kahet: The Old Kingdom"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[601] = {
		name = L["Azjol-Nerub"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[600] = {
		name = L["Drak'Tharon Keep"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[604] = {
		name = L["Gundrak"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[602] = {
		name = L["Halls of Lightning"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[668] = {
		name = L["Halls of Reflection"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[599] = {
		name = L["Halls of Stone"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[658] = {
		name = L["Pit of Saron"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[595] = {
		name = L["The Culling of Stratholme"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[632] = {
		name = L["The Forge of Souls"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[576] = {
		name = L["The Nexus"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[578] = {
		name = L["The Oculus"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[608] = {
		name = L["The Violet Hold"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[650] = {
		name = L["Trial of the Champion"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[574] = {
		name = L["Utgarde Keep"],
		type = "dungeon",
		expansion = "wrath",
	};
	NIT.zones[575] = {
		name = L["Utgarde Pinnacle "],
		type = "dungeon",
		expansion = "wrath",
	};
	--Wrath raids.
	NIT.zones[533] = {
		name = L["Naxxramas"],
		type = "raid",
		expansion = "wrath",
		noLockout = true,
	};
	NIT.zones[615] = {
		name = L["The Obsidian Sanctum"],
		type = "raid",
		expansion = "wrath",
		noLockout = true,
	};
	NIT.zones[616] = {
		name = L["The Eye of Eternity"],
		type = "raid",
		expansion = "wrath",
		noLockout = true,
	};
	NIT.zones[624] = {
		name = L["Vault of Archavon"],
		type = "raid",
		expansion = "wrath",
		noLockout = true,
	};
	NIT.zones[603] = {
		name = L["Ulduar"],
		type = "raid",
		expansion = "wrath",
		noLockout = true,
	};
	NIT.zones[649] = {
		name = L["Trial of the Crusader"],
		type = "raid",
		expansion = "wrath",
		noLockout = true,
	};
	NIT.zones[631] = {
		name = L["Icecrown Citadel"],
		type = "raid",
		expansion = "wrath",
		noLockout = true,
	};
	NIT.zones[724] = {
		name = L["The Ruby Sanctum"],
		type = "raid",
		expansion = "wrath",
		noLockout = true,
	};
	NIT.zones[249] = {
		name = L["Onyxia's Lair"],
		type = "raid",
		expansion = "wrath",
		noLockout = true,
	};
end

if (NIT.expansionNum > 3) then
	--Cata.
	NIT.zones[568] = {
		name = L["Zul'Aman"],
		type = "dungeon",
		expansion = "cata",
	};
	NIT.zones[643] = {
		name = L["Throne of the Tides"],
		type = "dungeon",
		expansion = "cata",
	};
	NIT.zones[644] = {
		name = L["Halls of Origination"],
		type = "dungeon",
		expansion = "cata",
	};
	NIT.zones[645] = {
		name = L[" Blackrock Caverns"],
		type = "dungeon",
		expansion = "cata",
	};
	NIT.zones[657] = {
		name = L["The Vortex Pinnacle"],
		type = "dungeon",
		expansion = "cata",
	};
	NIT.zones[670] = {
		name = L["Grim Batol"],
		type = "dungeon",
		expansion = "cata",
	};
	NIT.zones[725] = {
		name = L["The Stonecore"],
		type = "dungeon",
		expansion = "cata",
	};
	NIT.zones[755] = {
		name = L["Lost City of the Tol'vir"],
		type = "dungeon",
		expansion = "cata",
	};
	NIT.zones[859] = {
		name = L["Zul'Gurub"],
		type = "dungeon",
		expansion = "cata",
	};
	NIT.zones[938] = {
		name = L["End Time"],
		type = "dungeon",
		expansion = "cata",
	};
	NIT.zones[939] = {
		name = L["Well of Eternity"],
		type = "dungeon",
		expansion = "cata",
	};
	NIT.zones[940] = {
		name = L["Hour of Twilight"],
		type = "dungeon",
		expansion = "cata",
	};
	
	NIT.zones[249] = {
		name = L["Onyxia's Lair"],
		type = "raid",
		expansion = "cata",
		noLockout = true,
	};
	NIT.zones[669] = {
		name = L["Blackwing Descent"],
		type = "raid",
		expansion = "cata",
		noLockout = true,
	};
	NIT.zones[671] = {
		name = L["The Bastion of Twilight"],
		type = "raid",
		expansion = "cata",
		noLockout = true,
	};
	NIT.zones[720] = {
		name = L["Firelands"],
		type = "raid",
		expansion = "cata",
		noLockout = true,
	};
	NIT.zones[754] = {
		name = L["Throne of the Four Winds"],
		type = "raid",
		expansion = "cata",
		noLockout = true,
	};
	NIT.zones[757] = {
		name = L["Baradin Hold"],
		type = "raid",
		expansion = "cata",
		noLockout = true,
	};
	NIT.zones[967] = {
		name = L["Dragon Soul"],
		type = "raid",
		expansion = "cata",
		noLockout = true,
	};
end

if (NIT.expansionNum > 4) then
	--MoP.
	NIT.zones[959] = {
		name = L["Shado-pan Monastery"],
		type = "dungeon",
		expansion = "mop",
	};
	NIT.zones[960] = {
		name = L["Temple of the Jade Serpent"],
		type = "dungeon",
		expansion = "mop",
	};
	NIT.zones[961] = {
		name = L["Stormstout Brewery"],
		type = "dungeon",
		expansion = "mop",
	};
	NIT.zones[962] = {
		name = L["Gate of the Setting Sun"],
		type = "dungeon",
		expansion = "mop",
	};
	NIT.zones[944] = {
		name = L["Mogu'Shan Palace"],
		type = "dungeon",
		expansion = "mop",
	};
	NIT.zones[1011] = {
		name = L["Siege of Niuzao Temple"],
		type = "dungeon",
		expansion = "mop",
	};
	NIT.zones[996] = {
		name = L["Terrace of Endless Spring"],
		type = "raid",
		expansion = "mop",
		noLockout = true,
	};
	NIT.zones[1008] = {
		name = L["Mogu'shan Vaults"],
		type = "raid",
		expansion = "mop",
		noLockout = true,
	};
	NIT.zones[1009] = {
		name = L["Heart of Fear"],
		type = "raid",
		expansion = "mop",
		noLockout = true,
	};
	NIT.zones[1098] = {
		name = L["Throne of Thunder"],
		type = "raid",
		expansion = "mop",
		noLockout = true,
	};
	NIT.zones[1136] = {
		name = L["Siege of Orgrimmar"],
		type = "raid",
		expansion = "mop",
		noLockout = true,
	};
end

if (NIT.expansionNum > 5) then
	--WoD.
	NIT.zones[1182] = {
		name = L["Auchindoun"],
		type = "dungeon",
		expansion = "wod",
	};
	NIT.zones[1175] = {
		name = L["Bloodmaul Slag Mines"],
		type = "dungeon",
		expansion = "wod",
	};
	NIT.zones[1176] = {
		name = L["Shadowmoon Burial Grounds"],
		type = "dungeon",
		expansion = "wod",
	};
	NIT.zones[1195] = {
		name = L["Iron Docks"],
		type = "dungeon",
		expansion = "wod",
	};
	NIT.zones[1208] = {
		name = L["Grimrail Depot"],
		type = "dungeon",
		expansion = "wod",
	};
	NIT.zones[1209] = {
		name = L["Skyreach"],
		type = "dungeon",
		expansion = "wod",
	};
	NIT.zones[1279] = {
		name = L["The Everbloom"],
		type = "dungeon",
		expansion = "wod",
	};
	NIT.zones[1358] = {
		name = L["Upper Blackrock Spire"],
		type = "dungeon",
		expansion = "wod",
	};
	NIT.zones[1205] = {
		name = L["Blackrock Foundry"],
		type = "raid",
		expansion = "wod",
		noLockout = true,
	};
	NIT.zones[1228] = {
		name = L["Highmaul"],
		type = "raid",
		expansion = "wod",
		noLockout = true,
	};
	NIT.zones[1448] = {
		name = L["Hellfire Citadel"],
		type = "raid",
		expansion = "wod",
		noLockout = true,
	};
end

if (NIT.expansionNum > 6) then	
	--Legion.
	NIT.zones[1456] = {
		name = L["Eye of Azshara"],
		type = "dungeon",
		expansion = "legion",
	};
	NIT.zones[1458] = {
		name = L["Neltharion's Lair"],
		type = "dungeon",
		expansion = "legion",
	};
	NIT.zones[1466] = {
		name = L["Darkheart Thicket"],
		type = "dungeon",
		expansion = "legion",
	};
	NIT.zones[1477] = {
		name = L["Halls of Valor"],
		type = "dungeon",
		expansion = "legion",
	};
	NIT.zones[1492] = {
		name = L["Maw of Souls"],
		type = "dungeon",
		expansion = "legion",
	};
	NIT.zones[1493] = {
		name = L["Vault of the Wardens"],
		type = "dungeon",
		expansion = "legion",
	};
	NIT.zones[1501] = {
		name = L["Black Rook Hold"],
		type = "dungeon",
		expansion = "legion",
	};
	NIT.zones[1516] = {
		name = L["The Arcway"],
		type = "dungeon",
		expansion = "legion",
	};
	NIT.zones[1544] = {
		name = L["Violet Hold"],
		type = "dungeon",
		expansion = "legion",
	};
	NIT.zones[1571] = {
		name = L["Court of Stars"],
		type = "dungeon",
		expansion = "legion",
	};
	NIT.zones[1651] = {
		name = L["Return to Karazhan"],
		type = "dungeon",
		expansion = "legion",
	};
	NIT.zones[1677] = {
		name = L["Cathedral of Eternal Night"],
		type = "dungeon",
		expansion = "legion",
	};
	NIT.zones[1753] = {
		name = L["Seat of the Triumvirate"],
		type = "dungeon",
		expansion = "legion",
	};
	NIT.zones[1520] = {
		name = L["The Emerald Nightmare"],
		type = "raid",
		expansion = "legion",
		noLockout = true,
	};
	NIT.zones[1530] = {
		name = L["The Nighthold"],
		type = "raid",
		expansion = "legion",
		noLockout = true,
	};
	NIT.zones[1648] = {
		name = L["Trial of Valor"],
		type = "raid",
		expansion = "legion",
		noLockout = true,
	};
	NIT.zones[1676] = {
		name = L["Tomb of Sargeras"],
		type = "raid",
		expansion = "legion",
		noLockout = true,
	};
	NIT.zones[1712] = {
		name = L["Antorus, the Burning Throne"],
		type = "raid",
		expansion = "legion",
		noLockout = true,
	};
end