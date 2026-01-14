------------------------------------
---NovaInstance Tracker zones list--
------------------------------------

local L = LibStub('AceLocale-3.0'):GetLocale('NovaInstanceTracker')

NIT.zones = {
	--Dungeons (Classic).
	[33] = {
		name = L['Shadowfang Keep'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[48] = {
		name = L['Blackfathom Deeps'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[230] = {
		name = L['Blackrock Depths'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[229] = {
		name = L['Blackrock Spire'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[429] = {
		name = L['Dire Maul'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[90] = {
		name = L['Gnomeregan'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[349] = {
		name = L['Maraudon'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[389] = {
		name = L['Ragefire Chasm'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[129] = {
		name = L['Razorfen Downs'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[47] = {
		name = L['Razorfen Kraul'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[189] = {
		name = L['Scarlet Monastery'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[533] = {
		name = L['Scholomance'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[329] = {
		name = L['Stratholme'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[36] = {
		name = L['The Deadmines'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[34] = {
		name = L['The Stockade'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[109] = {
		name = L["The Temple of Atal'Hakkar"],
		type = 'dungeon',
		expansion = 'classic'
	},
	[70] = {
		name = L['Uldaman'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[43] = {
		name = L['Wailing Caverns'],
		type = 'dungeon',
		expansion = 'classic'
	},
	[209] = {
		name = L["Zul'Farrak"],
		type = 'dungeon',
		expansion = 'classic'
	},
	--Raids (Classic).
	[249] = {
		name = L["Onyxia's Lair"],
		type = 'raid',
		expansion = 'classic',
		noLockout = true
	},
	[309] = {
		name = L["Zul'gurub"],
		type = 'raid',
		expansion = 'classic'
	},
	[409] = {
		name = L['Molten Core'],
		type = 'raid',
		expansion = 'classic',
		noLockout = true
	},
	[469] = {
		name = L['Blackwing Lair'],
		type = 'raid',
		expansion = 'classic',
		noLockout = true,
		maxPlayers = 40
	},
	[509] = {
		name = L["Ruins of Ahn'Qiraj"],
		type = 'raid',
		expansion = 'classic'
	},
	[531] = {
		name = L["Temple of Ahn'Qiraj"],
		type = 'raid',
		expansion = 'classic',
		noLockout = true
	},
	[533] = {
		name = L['Naxxramas'],
		type = 'raid',
		expansion = 'classic',
		noLockout = true
	},
	--Dungeons (TBC).
	[558] = {
		name = L['Auchenai Crypts'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[543] = {
		name = L['Hellfire Ramparts'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[585] = {
		name = L["Magisters' Terrace"],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[557] = {
		name = L['Mana-Tombs'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[560] = {
		name = L['Old Hillsbrad Foothills'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[556] = {
		name = L['Sethekk Halls'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[555] = {
		name = L['Shadow Labyrinth'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[552] = {
		name = L['The Arcatraz'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[269] = {
		--Is this low ID right?
		name = L['The Black Morass'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[542] = {
		name = L['The Blood Furnace'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[553] = {
		name = L['The Botanica'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[554] = {
		name = L['The Mechanar'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[540] = {
		name = L['The Shattered Halls'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[547] = {
		name = L['The Slave Pens'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[545] = {
		name = L['The Steamvault'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	[546] = {
		name = L['The Underbog'],
		type = 'dungeon',
		expansion = 'tbc'
	},
	--Raids (TBC).
	[564] = {
		name = L['Black Temple'],
		type = 'raid',
		expansion = 'tbc',
		noLockout = true
	},
	[565] = {
		name = L["Gruul's Lair"],
		type = 'raid',
		expansion = 'tbc',
		noLockout = true
	},
	[534] = {
		name = L['Hyjal Summit'],
		type = 'raid',
		expansion = 'tbc',
		noLockout = true
	},
	[532] = {
		name = L['Karazhan'],
		type = 'raid',
		expansion = 'tbc',
		noLockout = true --Maybe has a lockout like 20m classic raids?
	},
	[544] = {
		name = L["Magtheridon's Lair"],
		type = 'raid',
		expansion = 'classic',
		noLockout = true
	},
	[548] = {
		name = L['Serpentshrine Cavern'],
		type = 'raid',
		expansion = 'classic',
		noLockout = true
	},
	[580] = {
		name = L['Sunwell Plateau'],
		type = 'raid',
		expansion = 'tbc',
		noLockout = true
	},
	[550] = {
		name = L['Tempest Keep'],
		type = 'raid',
		expansion = 'tbc',
		noLockout = true
	}
}
