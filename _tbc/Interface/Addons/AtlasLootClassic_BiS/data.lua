-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW
local function C_Map_GetAreaInfo(id)
	local d = C_Map.GetAreaInfo(id)
	return d or "GetAreaInfo"..id
end

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local GetForVersion = AtlasLoot.ReturnForGameVersion

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local HEROIC_DIFF = data:AddDifficulty(AL["Heroic"], "h", 2, nil, true)
local ALLIANCE_DIFF, HORDE_DIFF, LOAD_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	LOAD_DIFF = HORDE_DIFF
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	LOAD_DIFF = ALLIANCE_DIFF
end

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local VENDOR_CONTENT = data:AddContentType(AL["Vendor"], ATLASLOOT_DUNGEON_COLOR)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)
--local WORLD_BOSS_CONTENT = data:AddContentType(AL["World Bosses"], ATLASLOOT_WORLD_BOSS_COLOR)
local COLLECTIONS_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_COLLECTIONS_COLOR)
local WORLD_EVENT_CONTENT = data:AddContentType(AL["World Events"], ATLASLOOT_SEASONALEVENTS_COLOR)

data["WarriorProt"] = {
	name = AL["Warrior Prot BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34345 }, -- Crown of Anasterian
{ 2, 35068 }, -- Brutal Gladiator's Plate Helm
{ 3, 34354 }, -- Mayhem Projection Goggles
{ 4, 34357 }, -- Hard Khorium Goggles
{ 5, 34401 }, -- Helm of Uther's Resolve
{ 6, 32521 }, -- Faceplate of the Impenetrable
{ 7, 33730 }, -- Vengeful Gladiator's Plate Helm
{ 8, 34400 }, -- Crown of Dath'Remar
{ 9, 30972 }, -- Onslaught Battle-Helm
{ 10, 32373 }, -- Helm of the Illidari Shatterer
{ 11, 34244 }, -- Duplicitous Guise
{ 12, 33810 }, -- Amani Mask of Death
{ 13, 30974 }, -- Onslaught Greathelm
{ 14, 33421 }, -- Battleworn Tuskguard
{ 15, 34333 }, -- Coif of Alleria
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34178 }, -- Collar of the Pit Lord
{ 2, 33296 }, -- Brooch of Deftness
{ 3, 34358 }, -- Hard Khorium Choker
{ 4, 34680 }, -- Shattered Sun Pendant of Resolve
{ 5, 35135 }, -- Guardian's Pendant of Triumph
{ 6, 34177 }, -- Clutch of Demise
{ 7, 32362 }, -- Pendant of Titans
{ 8, 30099 }, -- Frayed Tether of the Drowned
{ 9, 32591 }, -- Choker of Serrated Blades
{ 10, 33923 }, -- Vindicator's Pendant of Triumph
{ 11, 33066 }, -- Veteran's Pendant of Triumph
{ 12, 33297 }, -- The Savage's Choker
{ 13, 28509 }, -- Worgen Claw Necklace
{ 14, 35511 }, -- Hailstone Pendant
{ 15, 29381 }, -- Choker of Vile Intent
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34192 }, -- Pauldrons of Perseverance
{ 2, 35070 }, -- Brutal Gladiator's Plate Shoulders
{ 3, 34388 }, -- Pauldrons of Berserking
{ 4, 34389 }, -- Spaulders of the Thalassian Defender
{ 5, 33732 }, -- Vengeful Gladiator's Plate Shoulders
{ 6, 30979 }, -- Onslaught Shoulderblades
{ 7, 30117 }, -- Destroyer Shoulderguards
{ 8, 30122 }, -- Destroyer Shoulderblades
{ 9, 30490 }, -- Merciless Gladiator's Plate Shoulders
{ 10, 30866 }, -- Blood-stained Pauldrons
{ 11, 34194 }, -- Mantle of the Golden Forest
{ 12, 32570 }, -- Swiftsteel Shoulders
{ 13, 29023 }, -- Warbringer Shoulderplates
{ 14, 30980 }, -- Onslaught Shoulderguards
{ 15, 33514 }, -- Pauldrons of Gruesome Fate
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34190 }, -- Crimson Paragon's Cover
{ 2, 34241 }, -- Cloak of Unforgivable Sin
{ 3, 34010 }, -- Pepe's Shroud of Pacification
{ 4, 32323 }, -- Shadowmoon Destroyer's Drape
{ 5, 33484 }, -- Dory's Embrace
{ 6, 29385 }, -- Farstrider Defender's Cloak
{ 7, 28529 }, -- Royal Cloak of Arathi Kings
{ 8, 33122 }, -- Cloak of Darkness (melee)
{ 9, 28672 }, -- Drape of the Dark Reavers
{ 10, 29994 }, -- Thalassian Wildercloak
{ 11, 33590 }, -- Cloak of Fiends
{ 12, 33593 }, -- Slikk's Cloak of Placation
{ 13, 30098 }, -- Razor-Scale Battlecloak
{ 14, 28777 }, -- Cloak of the Pit Stalker
{ 15, 28764 }, -- Farstrider Wildercloak
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 35066 }, -- Brutal Gladiator's Plate Chestpiece
{ 2, 34215 }, -- Warharness of Reckless Fury
{ 3, 34377 }, -- Hard Khorium Battleplate
{ 4, 30975 }, -- Onslaught Breastplate
{ 5, 33728 }, -- Vengeful Gladiator's Plate Chestpiece
{ 6, 28485 }, -- Bulwark of the Ancient Kings
{ 7, 34394 }, -- Breastplate of Agony's Aversion
{ 8, 30113 }, -- Destroyer Chestguard
{ 9, 28484 }, -- Bulwark of Kings
{ 10, 30486 }, -- Merciless Gladiator's Plate Chestpiece
{ 11, 30976 }, -- Onslaught Chestguard
{ 12, 30118 }, -- Destroyer Breastplate
{ 13, 34216 }, -- Heroic Judicator's Chestguard
{ 14, 32365 }, -- Heartshatter Breastplate
{ 15, 34939 }, -- Chestplate of Stoicism
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 35176 }, -- Guardian's Plate Bracers
{ 2, 34441 }, -- Onslaught Bracers
{ 3, 34442 }, -- Onslaught Wristguards
{ 4, 35178 }, -- Guardian's Scaled Bracers
{ 5, 33516 }, -- Bracers of the Ancient Phalanx
{ 6, 33813 }, -- Vindicator's Plate Bracers
{ 7, 30861 }, -- Furious Shackles
{ 8, 32568 }, -- Swiftsteel Bracers
{ 9, 30057 }, -- Bracers of Eradication
{ 10, 28502 }, -- Vambraces of Courage
{ 11, 33910 }, -- Vindicator's Scaled Bracers
{ 12, 33513 }, -- Eternium Rage-shackles
{ 13, 32232 }, -- Eternium Shell Bracers
{ 14, 28795 }, -- Bladespire Warbands
{ 15, 32818 }, -- Veteran's Plate Bracers
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34378 }, -- Hard Khorium Battlefists
{ 2, 34341 }, -- Borderland Paingrips
{ 3, 32280 }, -- Gauntlets of Enforcement
{ 4, 34343 }, -- Thalassian Ranger Gauntlets
{ 5, 32278 }, -- Grips of Silent Justice
{ 6, 34352 }, -- Borderland Fortress Grips
{ 7, 30969 }, -- Onslaught Gauntlets
{ 8, 35067 }, -- Brutal Gladiator's Plate Gauntlets
{ 9, 32608 }, -- Pillager's Gauntlets
{ 10, 33512 }, -- Furious Deathgrips
{ 11, 33517 }, -- Bonefist Gauntlets
{ 12, 34408 }, -- Gloves of the Forest Drifter
{ 13, 30114 }, -- Destroyer Handguards
{ 14, 29998 }, -- Royal Gauntlets of Silvermoon
{ 15, 33729 }, -- Vengeful Gladiator's Plate Gauntlets
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34547 }, -- Onslaught Waistguard
{ 2, 34941 }, -- Girdle of the Fearless
{ 3, 32333 }, -- Girdle of Stability
{ 4, 32342 }, -- Girdle of Mighty Resolve
{ 5, 33331 }, -- Chain of Unleashed Rage
{ 6, 34944 }, -- Girdle of Seething Rage
{ 7, 34546 }, -- Onslaught Belt
{ 8, 35161 }, -- Guardian's Plate Belt
{ 9, 30034 }, -- Belt of the Guardian
{ 10, 30032 }, -- Red Belt of Battle
{ 11, 35163 }, -- Guardian's Scaled Belt
{ 12, 33811 }, -- Vindicator's Plate Belt
{ 13, 30915 }, -- Belt of Seething Fury
{ 14, 28779 }, -- Girdle of the Endless Pit
{ 15, 30106 }, -- Belt of One-Hundred Deaths
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34213 }, -- Ring of Hardened Resolve
{ 2, 32497 }, -- Stormrage Signet Ring
{ 3, 32266 }, -- Ring of Deceitful Intent
{ 4, 34361 }, -- Hard Khorium Band
{ 5, 29297 }, -- Band of the Eternal Defender
{ 6, 32261 }, -- Band of the Abyssal Lord
{ 7, 29296 }, -- Band of Eternity (revered)
{ 8, 29301 }, -- Band of the Eternal Champion
{ 9, 34189 }, -- Band of Ruinous Delight
{ 10, 32526 }, -- Band of Devastation
{ 11, 33499 }, -- Signet of the Last Defender
{ 12, 29295 }, -- Band of Eternity (honored)
{ 13, 29300 }, -- Band of Eternity (revered)
{ 14, 29997 }, -- Band of the Ranger-General
{ 15, 33496 }, -- Signet of Primal Wrath
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34381 }, -- Felstrength Legplates
{ 2, 35069 }, -- Brutal Gladiator's Plate Legguards
{ 3, 34180 }, -- Felfury Legplates
{ 4, 34382 }, -- Judicator's Legguards
{ 5, 30977 }, -- Onslaught Greaves
{ 6, 30978 }, -- Onslaught Legguards
{ 7, 34943 }, -- Legplates of Unending Fury
{ 8, 33515 }, -- Unwavering Legguards
{ 9, 30903 }, -- Legguards of Endless Rage
{ 10, 33731 }, -- Vengeful Gladiator's Plate Legguards
{ 11, 32263 }, -- Praetorian's Legguards
{ 12, 34940 }, -- Sunguard Legplates
{ 13, 34188 }, -- Leggings of the Immortal Night
{ 14, 33501 }, -- Bloodthirster's Wargreaves
{ 15, 34168 }, -- Starstalker Legguards
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34568 }, -- Onslaught Boots
{ 2, 32345 }, -- Dreadboots of the Legion
{ 3, 32268 }, -- Myrmidon's Treads
{ 4, 35146 }, -- Guardian's Plate Greaves
{ 5, 34569 }, -- Onslaught Treads
{ 6, 35148 }, -- Guardian's Scaled Greaves
{ 7, 33523 }, -- Sabatons of the Righteous Defender
{ 8, 32245 }, -- Tide-stomper's Greaves
{ 9, 33812 }, -- Vindicator's Plate Greaves
{ 10, 33303 }, -- Skullshatter Warboots
{ 11, 33191 }, -- Jungle Stompers
{ 12, 33911 }, -- Vindicator's Scaled Greaves
{ 13, 32267 }, -- Boots of the Resilient
{ 14, 32793 }, -- Veteran's Plate Greaves
{ 15, 30880 }, -- Quickstrider Moccasins
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 30446 }, -- Solarian's Sapphire (Group AP Buff)
{ 2, 28830 }, -- Dragonspine Trophy
{ 3, 34472 }, -- Shard of Contempt
{ 4, 34428 }, -- Steely Naaru Sliver
{ 5, 29387 }, -- Gnomeregan Auto-Blocker 600
{ 6, 38289 }, -- Coren's Lucky Coin
{ 7, 34473 }, -- Commendation of Kael'thas
{ 8, 34427 }, -- Blackened Naaru Sliver
{ 9, 32505 }, -- Madness of the Betrayer
{ 10, 31858 }, -- Darkmoon Card: Vengeance
{ 11, 31859 }, -- Darkmoon Card: Madness
{ 12, 35700 }, -- Figurine - Crimson Serpent
{ 13, 23836 }, -- Goblin Rocket Launcher
{ 14, 23835 }, -- Gnomish Poultryizer
{ 15, 32864 }, -- Commander's Badge
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34331 }, -- Hand of the Deceiver
{ 2, 34329 }, -- Crux of the Apocalypse
{ 3, 34164 }, -- Dragonscale-Encrusted Longblade
{ 4, 32837 }, -- Warglaive of Azzinoth
{ 5, 35076 }, -- Brutal Gladiator's Right Ripper
{ 6, 34996 }, -- Brutal Gladiator's Cleaver
{ 7, 35071 }, -- Brutal Gladiator's Pummeler
{ 8, 35101 }, -- Brutal Gladiator's Slicer
{ 9, 35093 }, -- Brutal Gladiator's Shanker
{ 10, 34214 }, -- Muramasa
{ 11, 33737 }, -- Vengeful Gladiator's Right Ripper
{ 12, 33669 }, -- Vengeful Gladiator's Cleaver
{ 13, 33733 }, -- Vengeful Gladiator's Pummeler
{ 14, 33754 }, -- Vengeful Gladiator's Shanker
{ 15, 33762 }, -- Vengeful Gladiator's Slicer
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34185 }, -- Sword Breaker's Bulwark
{ 2, 35094 }, -- Brutal Gladiator's Shield Wall
{ 3, 32375 }, -- Bulwark of Azzinoth
{ 4, 34986 }, -- Brutal Gladiator's Barrier
{ 5, 35073 }, -- Brutal Gladiator's Redoubt
{ 6, 30889 }, -- Kaz'rogal's Hardened Heart
{ 7, 33755 }, -- Vengeful Gladiator's Shield Wall
{ 8, 34231 }, -- Aegis of Angelic Fortune
{ 9, 30909 }, -- Antonidas's Aegis of Rapt Concentration
{ 10, 33326 }, -- Bulwark of the Amani Empire
{ 11, 34011 }, -- Illidari Runeshield
{ 12, 33661 }, -- Vengeful Gladiator's Barrier
{ 13, 33735 }, -- Vengeful Gladiator's Redoubt
{ 14, 30882 }, -- Bastion of Light
{ 15, 32045 }, -- Merciless Gladiator's Shield Wall
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
 
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
{ 1, 32253 }, -- Legionkiller
{ 2, 30906 }, -- Bristleblitz Striker
{ 3, 32756 }, -- Gyro-Balanced Khorium Destroyer
{ 4, 34334 }, -- Thori'dal, the Stars' Fury
{ 5, 32645 }, -- Crystalline Crossbow
{ 6, 32325 }, -- Rifle of the Stoic Guardian
{ 7, 34196 }, -- Golden Bow of Quel'Thalas
{ 8, 30105 }, -- Serpent Spine Longbow
{ 9, 30724 }, -- Barrel-Blade Longrifle
{ 10, 29949 }, -- Arcanite Steam-Pistol
{ 11, 34892 }, -- Crossbow of Relentless Strikes
{ 12, 27817 }, -- Starbolt Longbow
{ 13, 29115 }, -- Consortium Blaster
{ 14, 30226 }, -- Alley's Recurve
{ 15, 32780 }, -- The Boomstick
},
},




--@end-version-bcc@
},
}

data["WarriorFury"] = {
	name = AL["Warrior Fury BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34333 }, -- Coif of Alleria
{ 2, 34345 }, -- Crown of Anasterian
{ 3, 34244 }, -- Duplicitous Guise
{ 4, 32235 }, -- Cursed Vision of Sargeras
{ 5, 34354 }, -- Mayhem Projection Goggles
{ 6, 35068 }, -- Brutal Gladiator's Plate Helm
{ 7, 32373 }, -- Helm of the Illidari Shatterer
{ 8, 30972 }, -- Onslaught Battle-Helm
{ 9, 33730 }, -- Vengeful Gladiator's Plate Helm
{ 10, 32376 }, -- Forest Prowler's Helm
{ 11, 30120 }, -- Destroyer Battle-Helm
{ 12, 32461 }, -- Furious Gizmatic Goggles
{ 13, 34404 }, -- Mask of the Fury Hunter
{ 14, 29021 }, -- Warbringer Battle-Helm
{ 15, 30488 }, -- Merciless Gladiator's Plate Helm
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34358 }, -- Hard Khorium Choker
{ 2, 34177 }, -- Clutch of Demise
{ 3, 32260 }, -- Choker of Endless Nightmares
{ 4, 32591 }, -- Choker of Serrated Blades
{ 5, 35292 }, -- Sin'dorei Pendant of Triumph
{ 6, 35135 }, -- Guardian's Pendant of Triumph
{ 7, 24114 }, -- Braided Eternium Chain (GROUP BUFF)
{ 8, 33923 }, -- Vindicator's Pendant of Triumph
{ 9, 30022 }, -- Pendant of the Perilous
{ 10, 30059 }, -- Choker of Animalistic Fury
{ 11, 30017 }, -- Telonicus's Pendant of Mayhem
{ 12, 33297 }, -- The Savage's Choker
{ 13, 33066 }, -- Veteran's Pendant of Triumph
{ 14, 33296 }, -- Brooch of Deftness
{ 15, 29349 }, -- Adamantine Chain of the Unbroken
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34388 }, -- Pauldrons of Berserking
{ 2, 34194 }, -- Mantle of the Golden Forest
{ 3, 34195 }, -- Shoulderpads of Vehemence
{ 4, 34392 }, -- Demontooth Shoulderpads
{ 5, 30979 }, -- Onslaught Shoulderblades
{ 6, 32581 }, -- Swiftstrike Shoulders
{ 7, 32570 }, -- Swiftsteel Shoulders
{ 8, 32575 }, -- Shoulders of Lightning Reflexes
{ 9, 30055 }, -- Shoulderpads of the Stranger
{ 10, 35070 }, -- Brutal Gladiator's Plate Shoulders
{ 11, 30866 }, -- Blood-stained Pauldrons
{ 12, 32377 }, -- Mantle of Darkness
{ 13, 30740 }, -- Ripfiend Shoulderplates
{ 14, 32264 }, -- Shoulders of the Hidden Predator
{ 15, 33514 }, -- Pauldrons of Gruesome Fate
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34241 }, -- Cloak of Unforgivable Sin
{ 2, 32323 }, -- Shadowmoon Destroyer's Drape
{ 3, 33484 }, -- Dory's Embrace
{ 4, 33590 }, -- Cloak of Fiends
{ 5, 30729 }, -- Black-Iron Battlecloak
{ 6, 24259 }, -- Vengeance Wrap
{ 7, 33122 }, -- Cloak of Darkness (melee)
{ 8, 29994 }, -- Thalassian Wildercloak
{ 9, 28777 }, -- Cloak of the Pit Stalker
{ 10, 30098 }, -- Razor-Scale Battlecloak
{ 11, 34708 }, -- Cloak of the Coming Night
{ 12, 28672 }, -- Drape of the Dark Reavers
{ 13, 34190 }, -- Crimson Paragon's Cover
{ 14, 27892 }, -- Cloak of the Inciter
{ 15, 32665 }, -- Crystalweave Cape
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34397 }, -- Bladed Chaos Tunic
{ 2, 34377 }, -- Hard Khorium Battleplate
{ 3, 34369 }, -- Carapace of Sun and Shadow
{ 4, 34215 }, -- Warharness of Reckless Fury
{ 5, 34211 }, -- Harness of Carnal Instinct
{ 6, 35066 }, -- Brutal Gladiator's Plate Chestpiece
{ 7, 30975 }, -- Onslaught Breastplate
{ 8, 30905 }, -- Midnight Chestguard
{ 9, 33728 }, -- Vengeful Gladiator's Plate Chestpiece
{ 10, 28485 }, -- Bulwark of the Ancient Kings
{ 11, 30101 }, -- Bloodsea Brigand's Vest
{ 12, 32365 }, -- Heartshatter Breastplate
{ 13, 30118 }, -- Destroyer Breastplate
{ 14, 33329 }, -- Shadowtooth Trollskin Cuirass
{ 15, 34912 }, -- Scaled Drakeskin Chestguard
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34441 }, -- Onslaught Bracers
{ 2, 30863 }, -- Deadly Cuffs
{ 3, 32574 }, -- Bindings of Lightning Reflexes
{ 4, 30057 }, -- Bracers of Eradication
{ 5, 32580 }, -- Swiftstrike Bracers
{ 6, 32568 }, -- Swiftsteel Bracers
{ 7, 32324 }, -- Insidious Bands
{ 8, 28795 }, -- Bladespire Warbands
{ 9, 33540 }, -- Master Assassin Wristwraps
{ 10, 30861 }, -- Furious Shackles
{ 11, 33513 }, -- Eternium Rage-shackles
{ 12, 35176 }, -- Guardian's Plate Bracers
{ 13, 35178 }, -- Guardian's Scaled Bracers
{ 14, 32251 }, -- Wraps of Precise Flight
{ 15, 33529 }, -- Steadying Bracers
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34343 }, -- Thalassian Ranger Gauntlets
{ 2, 34370 }, -- Gloves of Immortal Dusk
{ 3, 34341 }, -- Borderland Paingrips
{ 4, 34234 }, -- Shadowed Gauntlets of Paroxysm
{ 5, 34378 }, -- Hard Khorium Battlefists
{ 6, 34374 }, -- Fletcher's Gloves of the Phoenix
{ 7, 34408 }, -- Gloves of the Forest Drifter
{ 8, 32278 }, -- Grips of Silent Justice
{ 9, 32347 }, -- Grips of Damnation
{ 10, 32234 }, -- Fists of Mukoa
{ 11, 32608 }, -- Pillager's Gauntlets
{ 12, 30969 }, -- Onslaught Gauntlets
{ 13, 34916 }, -- Gauntlets of Rapidity
{ 14, 29947 }, -- Gloves of the Searing Grip
{ 15, 33539 }, -- Trickster's Stickyfingers
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34546 }, -- Onslaught Belt
{ 2, 30106 }, -- Belt of One-Hundred Deaths
{ 3, 32346 }, -- Boneweave Girdle
{ 4, 32265 }, -- Shadow-walker's Cord
{ 5, 30919 }, -- Valestalker Girdle
{ 6, 33331 }, -- Chain of Unleashed Rage
{ 7, 30879 }, -- Don Alejandro's Money Belt
{ 8, 30032 }, -- Red Belt of Battle
{ 9, 33211 }, -- Bladeangel's Money Belt
{ 10, 30915 }, -- Belt of Seething Fury
{ 11, 30040 }, -- Belt of Deep Shadow
{ 12, 34929 }, -- Belt of the Silent Path
{ 13, 32606 }, -- Girdle of the Lightbearer
{ 14, 34944 }, -- Girdle of Seething Rage
{ 15, 28779 }, -- Girdle of the Endless Pit
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34189 }, -- Band of Ruinous Delight
{ 2, 34361 }, -- Hard Khorium Band
{ 3, 32497 }, -- Stormrage Signet Ring
{ 4, 34887 }, -- Angelista's Revenge
{ 5, 33496 }, -- Signet of Primal Wrath
{ 6, 35131 }, -- Guardian's Band of Triumph
{ 7, 32335 }, -- Unstoppable Aggressor's Ring
{ 8, 32526 }, -- Band of Devastation
{ 9, 29997 }, -- Band of the Ranger-General
{ 10, 29301 }, -- Band of the Eternal Champion
{ 11, 33919 }, -- Vindicator's Band of Triumph
{ 12, 30738 }, -- Ring of Reciprocity
{ 13, 28757 }, -- Ring of a Thousand Marks
{ 14, 35284 }, -- Sin'dorei Band of Triumph
{ 15, 32266 }, -- Ring of Deceitful Intent
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34188 }, -- Leggings of the Immortal Night
{ 2, 34180 }, -- Felfury Legplates
{ 3, 32341 }, -- Leggings of Divine Retribution
{ 4, 34385 }, -- Leggings of the Immortal Beast
{ 5, 34168 }, -- Starstalker Legguards
{ 6, 35069 }, -- Brutal Gladiator's Plate Legguards
{ 7, 34943 }, -- Legplates of Unending Fury
{ 8, 30977 }, -- Onslaught Greaves
{ 9, 30900 }, -- Bow-stitched Leggings
{ 10, 30903 }, -- Legguards of Endless Rage
{ 11, 33731 }, -- Vengeful Gladiator's Plate Legguards
{ 12, 30898 }, -- Shady Dealer's Pantaloons
{ 13, 29995 }, -- Leggings of Murderous Intent
{ 14, 34910 }, -- Tameless Breeches
{ 15, 29950 }, -- Greaves of the Bloodwarder
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34569 }, -- Onslaught Treads
{ 2, 32345 }, -- Dreadboots of the Legion
{ 3, 32366 }, -- Shadowmaster's Boots
{ 4, 32510 }, -- Softstep Boots of Tracking
{ 5, 34809 }, -- Sunrage Treads
{ 6, 33222 }, -- Nyn'jah's Tabi Boots
{ 7, 35146 }, -- Guardian's Plate Greaves
{ 8, 33303 }, -- Skullshatter Warboots
{ 9, 34807 }, -- Sunstrider Warboots
{ 10, 30039 }, -- Boots of Utter Darkness
{ 11, 30880 }, -- Quickstrider Moccasins
{ 12, 29951 }, -- Star-Strider Boots
{ 13, 30104 }, -- Cobra-Lash Boots
{ 14, 30081 }, -- Warboots of Obliteration
{ 15, 35148 }, -- Guardian's Scaled Greaves
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 28830 }, -- Dragonspine Trophy
{ 2, 30446 }, -- Solarian's Sapphire (Group AP Buff)
{ 3, 34427 }, -- Blackened Naaru Sliver
{ 4, 34472 }, -- Shard of Contempt
{ 5, 34428 }, -- Steely Naaru Sliver
{ 6, 32505 }, -- Madness of the Betrayer
{ 7, 30627 }, -- Tsunami Talisman
{ 8, 23206 }, -- Mark of the Champion (undead/demon)
{ 9, 33831 }, -- Berserker's Call
{ 10, 35702 }, -- Figurine - Shadowsong Panther
{ 11, 28034 }, -- Hourglass of the Unraveller
{ 12, 31856 }, -- Darkmoon Card: Crusade
{ 13, 28288 }, -- Abacus of Violent Odds
{ 14, 29383 }, -- Bloodlust Brooch
{ 15, 22954 }, -- Kiss of the Spider
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 32837 }, -- Warglaive of Azzinoth
{ 2, 34346 }, -- Mounting Vengeance
{ 3, 35076 }, -- Brutal Gladiator's Right Ripper
{ 4, 34995 }, -- Brutal Gladiator's Chopper
{ 5, 35037 }, -- Brutal Gladiator's Left Render
{ 6, 34996 }, -- Brutal Gladiator's Cleaver
{ 7, 35071 }, -- Brutal Gladiator's Pummeler
{ 8, 34214 }, -- Muramasa
{ 9, 34331 }, -- Hand of the Deceiver
{ 10, 32262 }, -- Syphon of the Nathrezim
{ 11, 33737 }, -- Vengeful Gladiator's Right Ripper
{ 12, 34015 }, -- Vengeful Gladiator's Chopper
{ 13, 34016 }, -- Vengeful Gladiator's Left Render
{ 14, 33669 }, -- Vengeful Gladiator's Cleaver
{ 15, 33733 }, -- Vengeful Gladiator's Pummeler
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34346 }, -- Mounting Vengeance
{ 2, 34995 }, -- Brutal Gladiator's Chopper
{ 3, 35037 }, -- Brutal Gladiator's Left Render
{ 4, 34996 }, -- Brutal Gladiator's Cleaver
{ 5, 35071 }, -- Brutal Gladiator's Pummeler
{ 6, 34214 }, -- Muramasa
{ 7, 32262 }, -- Syphon of the Nathrezim
{ 8, 34015 }, -- Vengeful Gladiator's Chopper
{ 9, 34016 }, -- Vengeful Gladiator's Left Render
{ 10, 33669 }, -- Vengeful Gladiator's Cleaver
{ 11, 33733 }, -- Vengeful Gladiator's Pummeler
{ 12, 29996 }, -- Rod of the Sun King
{ 13, 35101 }, -- Brutal Gladiator's Slicer
{ 14, 30881 }, -- Blade of Infamy
{ 15, 30082 }, -- Talon of Azshara
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
 
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
{ 1, 34334 }, -- Thori'dal, the Stars' Fury
{ 2, 34196 }, -- Golden Bow of Quel'Thalas
{ 3, 33474 }, -- Ancient Amani Longbow
{ 4, 34892 }, -- Crossbow of Relentless Strikes
{ 5, 33491 }, -- Tuskbreaker
{ 6, 30105 }, -- Serpent Spine Longbow
{ 7, 30724 }, -- Barrel-Blade Longrifle
{ 8, 28772 }, -- Sunfury Bow of the Phoenix
{ 9, 30279 }, -- Mama's Insurance
{ 10, 29949 }, -- Arcanite Steam-Pistol
{ 11, 29151 }, -- Veteran's Musket
{ 12, 29152 }, -- Marksman's Bow
{ 13, 30906 }, -- Bristleblitz Striker
{ 14, 28581 }, -- Wolfslayer Sniper Rifle
{ 15, 22812 }, -- Nerubian Slavemaker
},
},




--@end-version-bcc@
},
}


data["WarriorArms"] = {
	name = AL["Warrior Arms BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34333 }, -- Coif of Alleria
{ 2, 34345 }, -- Crown of Anasterian
{ 3, 34354 }, -- Mayhem Projection Goggles
{ 4, 34244 }, -- Duplicitous Guise
{ 5, 32235 }, -- Cursed Vision of Sargeras
{ 6, 32373 }, -- Helm of the Illidari Shatterer
{ 7, 35068 }, -- Brutal Gladiator's Plate Helm
{ 8, 30972 }, -- Onslaught Battle-Helm
{ 9, 33730 }, -- Vengeful Gladiator's Plate Helm
{ 10, 30120 }, -- Destroyer Battle-Helm
{ 11, 32376 }, -- Forest Prowler's Helm
{ 12, 32461 }, -- Furious Gizmatic Goggles
{ 13, 34404 }, -- Mask of the Fury Hunter
{ 14, 29021 }, -- Warbringer Battle-Helm
{ 15, 30488 }, -- Merciless Gladiator's Plate Helm
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34358 }, -- Hard Khorium Choker
{ 2, 32260 }, -- Choker of Endless Nightmares
{ 3, 32591 }, -- Choker of Serrated Blades
{ 4, 34177 }, -- Clutch of Demise
{ 5, 35292 }, -- Sin'dorei Pendant of Triumph
{ 6, 35135 }, -- Guardian's Pendant of Triumph
{ 7, 24114 }, -- Braided Eternium Chain (GROUP BUFF)
{ 8, 30022 }, -- Pendant of the Perilous
{ 9, 33923 }, -- Vindicator's Pendant of Triumph
{ 10, 30059 }, -- Choker of Animalistic Fury
{ 11, 30017 }, -- Telonicus's Pendant of Mayhem
{ 12, 33066 }, -- Veteran's Pendant of Triumph
{ 13, 29381 }, -- Choker of Vile Intent
{ 14, 35507 }, -- Amulet of Bitter Hatred
{ 15, 28509 }, -- Worgen Claw Necklace
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34194 }, -- Mantle of the Golden Forest
{ 2, 34388 }, -- Pauldrons of Berserking
{ 3, 34392 }, -- Demontooth Shoulderpads
{ 4, 30979 }, -- Onslaught Shoulderblades
{ 5, 34195 }, -- Shoulderpads of Vehemence
{ 6, 30866 }, -- Blood-stained Pauldrons
{ 7, 35070 }, -- Brutal Gladiator's Plate Shoulders
{ 8, 30740 }, -- Ripfiend Shoulderplates
{ 9, 32377 }, -- Mantle of Darkness
{ 10, 30055 }, -- Shoulderpads of the Stranger
{ 11, 30122 }, -- Destroyer Shoulderblades
{ 12, 33514 }, -- Pauldrons of Gruesome Fate
{ 13, 30053 }, -- Pauldrons of the Wardancer
{ 14, 32264 }, -- Shoulders of the Hidden Predator
{ 15, 33732 }, -- Vengeful Gladiator's Plate Shoulders
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34241 }, -- Cloak of Unforgivable Sin
{ 2, 32323 }, -- Shadowmoon Destroyer's Drape
{ 3, 33484 }, -- Dory's Embrace
{ 4, 33122 }, -- Cloak of Darkness (melee)
{ 5, 30729 }, -- Black-Iron Battlecloak
{ 6, 24259 }, -- Vengeance Wrap
{ 7, 29994 }, -- Thalassian Wildercloak
{ 8, 30098 }, -- Razor-Scale Battlecloak
{ 9, 33590 }, -- Cloak of Fiends
{ 10, 28777 }, -- Cloak of the Pit Stalker
{ 11, 28672 }, -- Drape of the Dark Reavers
{ 12, 27892 }, -- Cloak of the Inciter
{ 13, 28371 }, -- Netherfury Cape
{ 14, 27878 }, -- Auchenai Death Shroud
{ 15, 29382 }, -- Blood Knight War Cloak
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34397 }, -- Bladed Chaos Tunic
{ 2, 34377 }, -- Hard Khorium Battleplate
{ 3, 34369 }, -- Carapace of Sun and Shadow
{ 4, 34211 }, -- Harness of Carnal Instinct
{ 5, 34215 }, -- Warharness of Reckless Fury
{ 6, 35066 }, -- Brutal Gladiator's Plate Chestpiece
{ 7, 30905 }, -- Midnight Chestguard
{ 8, 30975 }, -- Onslaught Breastplate
{ 9, 33728 }, -- Vengeful Gladiator's Plate Chestpiece
{ 10, 28485 }, -- Bulwark of the Ancient Kings
{ 11, 32365 }, -- Heartshatter Breastplate
{ 12, 30101 }, -- Bloodsea Brigand's Vest
{ 13, 30118 }, -- Destroyer Breastplate
{ 14, 32252 }, -- Nether Shadow Tunic
{ 15, 28484 }, -- Bulwark of Kings
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34441 }, -- Onslaught Bracers
{ 2, 30863 }, -- Deadly Cuffs
{ 3, 30057 }, -- Bracers of Eradication
{ 4, 32324 }, -- Insidious Bands
{ 5, 30861 }, -- Furious Shackles
{ 6, 28795 }, -- Bladespire Warbands
{ 7, 33540 }, -- Master Assassin Wristwraps
{ 8, 35176 }, -- Guardian's Plate Bracers
{ 9, 33513 }, -- Eternium Rage-shackles
{ 10, 35178 }, -- Guardian's Scaled Bracers
{ 11, 32251 }, -- Wraps of Precise Flight
{ 12, 30091 }, -- True-Aim Stalker Bands
{ 13, 33813 }, -- Vindicator's Plate Bracers
{ 14, 32574 }, -- Bindings of Lightning Reflexes
{ 15, 33529 }, -- Steadying Bracers
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34343 }, -- Thalassian Ranger Gauntlets
{ 2, 34370 }, -- Gloves of Immortal Dusk
{ 3, 34341 }, -- Borderland Paingrips
{ 4, 34408 }, -- Gloves of the Forest Drifter
{ 5, 32278 }, -- Grips of Silent Justice
{ 6, 34234 }, -- Shadowed Gauntlets of Paroxysm
{ 7, 34378 }, -- Hard Khorium Battlefists
{ 8, 34374 }, -- Fletcher's Gloves of the Phoenix
{ 9, 30969 }, -- Onslaught Gauntlets
{ 10, 34916 }, -- Gauntlets of Rapidity
{ 11, 28824 }, -- Gauntlets of Martial Perfection
{ 12, 28776 }, -- Liar's Tongue Gloves
{ 13, 35067 }, -- Brutal Gladiator's Plate Gauntlets
{ 14, 29947 }, -- Gloves of the Searing Grip
{ 15, 33528 }, -- Gauntlets of Sniping
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34546 }, -- Onslaught Belt
{ 2, 30106 }, -- Belt of One-Hundred Deaths
{ 3, 32346 }, -- Boneweave Girdle
{ 4, 30032 }, -- Red Belt of Battle
{ 5, 30879 }, -- Don Alejandro's Money Belt
{ 6, 33331 }, -- Chain of Unleashed Rage
{ 7, 33211 }, -- Bladeangel's Money Belt
{ 8, 34929 }, -- Belt of the Silent Path
{ 9, 30040 }, -- Belt of Deep Shadow
{ 10, 33583 }, -- Waistguard of the Great Beast
{ 11, 28779 }, -- Girdle of the Endless Pit
{ 12, 30046 }, -- Belt of the Black Eagle
{ 13, 35161 }, -- Guardian's Plate Belt
{ 14, 28828 }, -- Gronn-Stitched Girdle
{ 15, 32265 }, -- Shadow-walker's Cord
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34189 }, -- Band of Ruinous Delight
{ 2, 32497 }, -- Stormrage Signet Ring
{ 3, 34887 }, -- Angelista's Revenge
{ 4, 33496 }, -- Signet of Primal Wrath
{ 5, 32335 }, -- Unstoppable Aggressor's Ring
{ 6, 29997 }, -- Band of the Ranger-General
{ 7, 34361 }, -- Hard Khorium Band
{ 8, 35131 }, -- Guardian's Band of Triumph
{ 9, 29301 }, -- Band of the Eternal Champion
{ 10, 30738 }, -- Ring of Reciprocity
{ 11, 28757 }, -- Ring of a Thousand Marks
{ 12, 33919 }, -- Vindicator's Band of Triumph
{ 13, 32266 }, -- Ring of Deceitful Intent
{ 14, 35284 }, -- Sin'dorei Band of Triumph
{ 15, 30052 }, -- Ring of Lethality
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34188 }, -- Leggings of the Immortal Night
{ 2, 34180 }, -- Felfury Legplates
{ 3, 32341 }, -- Leggings of Divine Retribution
{ 4, 34385 }, -- Leggings of the Immortal Beast
{ 5, 34168 }, -- Starstalker Legguards
{ 6, 35069 }, -- Brutal Gladiator's Plate Legguards
{ 7, 30977 }, -- Onslaught Greaves
{ 8, 30903 }, -- Legguards of Endless Rage
{ 9, 30900 }, -- Bow-stitched Leggings
{ 10, 33731 }, -- Vengeful Gladiator's Plate Legguards
{ 11, 34943 }, -- Legplates of Unending Fury
{ 12, 30898 }, -- Shady Dealer's Pantaloons
{ 13, 29950 }, -- Greaves of the Bloodwarder
{ 14, 30121 }, -- Destroyer Greaves
{ 15, 29995 }, -- Leggings of Murderous Intent
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34569 }, -- Onslaught Treads
{ 2, 32345 }, -- Dreadboots of the Legion
{ 3, 32366 }, -- Shadowmaster's Boots
{ 4, 32510 }, -- Softstep Boots of Tracking
{ 5, 33222 }, -- Nyn'jah's Tabi Boots
{ 6, 34809 }, -- Sunrage Treads
{ 7, 35146 }, -- Guardian's Plate Greaves
{ 8, 33303 }, -- Skullshatter Warboots
{ 9, 30880 }, -- Quickstrider Moccasins
{ 10, 30039 }, -- Boots of Utter Darkness
{ 11, 34807 }, -- Sunstrider Warboots
{ 12, 30081 }, -- Warboots of Obliteration
{ 13, 35148 }, -- Guardian's Scaled Greaves
{ 14, 29951 }, -- Star-Strider Boots
{ 15, 30104 }, -- Cobra-Lash Boots
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 30446 }, -- Solarian's Sapphire (Group AP Buff)
{ 2, 34472 }, -- Shard of Contempt
{ 3, 34427 }, -- Blackened Naaru Sliver
{ 4, 28830 }, -- Dragonspine Trophy
{ 5, 32505 }, -- Madness of the Betrayer
{ 6, 30627 }, -- Tsunami Talisman
{ 7, 34428 }, -- Steely Naaru Sliver
{ 8, 23206 }, -- Mark of the Champion (undead/demon)
{ 9, 33831 }, -- Berserker's Call
{ 10, 35702 }, -- Figurine - Shadowsong Panther
{ 11, 31856 }, -- Darkmoon Card: Crusade
{ 12, 29383 }, -- Bloodlust Brooch
{ 13, 28034 }, -- Hourglass of the Unraveller
{ 14, 23041 }, -- Slayer's Crest
{ 15, 28288 }, -- Abacus of Violent Odds
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
 
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
 
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34247 }, -- Apolyon, the Soul-Render
{ 2, 34183 }, -- Shivering Felspine
{ 3, 34989 }, -- Brutal Gladiator's Bonegrinder
{ 4, 35015 }, -- Brutal Gladiator's Greatsword
{ 5, 34997 }, -- Brutal Gladiator's Decapitator
{ 6, 30902 }, -- Cataclysm's Edge
{ 7, 35064 }, -- Brutal Gladiator's Painsaw
{ 8, 34891 }, -- The Blade of Harbingers
{ 9, 33663 }, -- Vengeful Gladiator's Bonegrinder
{ 10, 33688 }, -- Vengeful Gladiator's Greatsword
{ 11, 33670 }, -- Vengeful Gladiator's Decapitator
{ 12, 32348 }, -- Soul Cleaver
{ 13, 33727 }, -- Vengeful Gladiator's Painsaw
{ 14, 29993 }, -- Twinblade of the Phoenix
{ 15, 32332 }, -- Torch of the Damned

},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
{ 1, 34334 }, -- Thori'dal, the Stars' Fury
{ 2, 34196 }, -- Golden Bow of Quel'Thalas
{ 3, 34892 }, -- Crossbow of Relentless Strikes
{ 4, 33474 }, -- Ancient Amani Longbow
{ 5, 34349 }, -- Blade of Life's Inevitability
{ 6, 35108 }, -- Brutal Gladiator's War Edge
{ 7, 30105 }, -- Serpent Spine Longbow
{ 8, 30724 }, -- Barrel-Blade Longrifle
{ 9, 32326 }, -- Twisted Blades of Zarak
{ 10, 33765 }, -- Vengeful Gladiator's War Edge
{ 11, 28772 }, -- Sunfury Bow of the Phoenix
{ 12, 32054 }, -- Merciless Gladiator's War Edge
{ 13, 33491 }, -- Tuskbreaker
{ 14, 30279 }, -- Mama's Insurance
{ 15, 34603 }, -- Distracting Blades

},
},




--@end-version-bcc@
},
}


data["Rogue"] = {
	name = AL["Rogue BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34244 }, -- Duplicitous Guise
{ 2, 32235 }, -- Cursed Vision of Sargeras
{ 3, 34353 }, -- Quad Deathblow X44 Goggles
{ 4, 31027 }, -- Slayer's Helm
{ 5, 35033 }, -- Brutal Gladiator's Leather Helm
{ 6, 33701 }, -- Vengeful Gladiator's Leather Helm
{ 7, 32478 }, -- Deathblow X11 Goggles
{ 8, 30146 }, -- Deathmantle Helm
{ 9, 33479 }, -- Grimgrin Faceguard
{ 10, 29044 }, -- Netherblade Facemask
{ 11, 32087 }, -- Mask of the Deceiver
{ 12, 34404 }, -- Mask of the Fury Hunter
{ 13, 31999 }, -- Merciless Gladiator's Leather Helm
{ 14, 28182 }, -- Helm of the Claw
{ 15, 28224 }, -- Wastewalker Helm
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34358 }, -- Hard Khorium Choker
{ 2, 34177 }, -- Clutch of Demise
{ 3, 32260 }, -- Choker of Endless Nightmares
{ 4, 24114 }, -- Braided Eternium Chain (GROUP BUFF)
{ 5, 35292 }, -- Sin'dorei Pendant of Triumph
{ 6, 29381 }, -- Choker of Vile Intent
{ 7, 35507 }, -- Amulet of Bitter Hatred
{ 8, 30017 }, -- Telonicus's Pendant of Mayhem
{ 9, 32591 }, -- Choker of Serrated Blades
{ 10, 35135 }, -- Guardian's Pendant of Triumph
{ 11, 28509 }, -- Worgen Claw Necklace
{ 12, 33923 }, -- Vindicator's Pendant of Triumph
{ 13, 27779 }, -- Bone Chain Necklace
{ 14, 33296 }, -- Brooch of Deftness
{ 15, 33297 }, -- The Savage's Choker
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34195 }, -- Shoulderpads of Vehemence
{ 2, 31030 }, -- Slayer's Shoulderpads
{ 3, 35035 }, -- Brutal Gladiator's Leather Spaulders
{ 4, 32581 }, -- Swiftstrike Shoulders
{ 5, 30055 }, -- Shoulderpads of the Stranger
{ 6, 34392 }, -- Demontooth Shoulderpads
{ 7, 32377 }, -- Mantle of Darkness
{ 8, 33703 }, -- Vengeful Gladiator's Leather Spaulders
{ 9, 30149 }, -- Deathmantle Shoulderpads
{ 10, 34613 }, -- Shoulderpads of the Silvermoon Retainer
{ 11, 32001 }, -- Merciless Gladiator's Leather Spaulders
{ 12, 33300 }, -- Shoulderpads of Dancing Blades
{ 13, 30917 }, -- Razorfury Mantle
{ 14, 27797 }, -- Wastewalker Shoulderpads
{ 15, 29047 }, -- Netherblade Shoulderpads
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34241 }, -- Cloak of Unforgivable Sin
{ 2, 32323 }, -- Shadowmoon Destroyer's Drape
{ 3, 33590 }, -- Cloak of Fiends
{ 4, 29994 }, -- Thalassian Wildercloak
{ 5, 28672 }, -- Drape of the Dark Reavers
{ 6, 33484 }, -- Dory's Embrace
{ 7, 24259 }, -- Vengeance Wrap
{ 8, 30729 }, -- Black-Iron Battlecloak
{ 9, 27878 }, -- Auchenai Death Shroud
{ 10, 34708 }, -- Cloak of the Coming Night
{ 11, 31255 }, -- Cloak of the Craft
{ 12, 27892 }, -- Cloak of the Inciter
{ 13, 29382 }, -- Blood Knight War Cloak
{ 14, 35495 }, -- The Frost Lord's War Cloak
{ 15, 28777 }, -- Cloak of the Pit Stalker
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34369 }, -- Carapace of Sun and Shadow
{ 2, 34397 }, -- Bladed Chaos Tunic
{ 3, 31028 }, -- Slayer's Chestguard
{ 4, 30905 }, -- Midnight Chestguard
{ 5, 32252 }, -- Nether Shadow Tunic
{ 6, 35036 }, -- Brutal Gladiator's Leather Tunic
{ 7, 34927 }, -- Tunic of the Dark Hour
{ 8, 30101 }, -- Bloodsea Brigand's Vest
{ 9, 34211 }, -- Harness of Carnal Instinct
{ 10, 33704 }, -- Vengeful Gladiator's Leather Tunic
{ 11, 30144 }, -- Deathmantle Chestguard
{ 12, 30730 }, -- Terrorweave Tunic
{ 13, 33329 }, -- Shadowtooth Trollskin Cuirass
{ 14, 29045 }, -- Netherblade Chestpiece
{ 15, 28601 }, -- Chestguard of the Conniver
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34448 }, -- Slayer's Bracers
{ 2, 32324 }, -- Insidious Bands
{ 3, 30863 }, -- Deadly Cuffs
{ 4, 32580 }, -- Swiftstrike Bracers
{ 5, 35171 }, -- Guardian's Leather Bracers
{ 6, 33540 }, -- Master Assassin Wristwraps
{ 7, 33881 }, -- Vindicator's Dragonhide Bracers
{ 8, 29966 }, -- Vambraces of Ending
{ 9, 33893 }, -- Vindicator's Leather Bracers
{ 10, 32647 }, -- Shard-bound Bracers
{ 11, 35167 }, -- Guardian's Dragonhide Bracers
{ 12, 32814 }, -- Veteran's Leather Bracers
{ 13, 28171 }, -- Spymistress's Wristguards
{ 14, 29246 }, -- Nightfall Wristguards
{ 15, 29527 }, -- Primalstrike Bracers
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34370 }, -- Gloves of Immortal Dusk
{ 2, 34234 }, -- Shadowed Gauntlets of Paroxysm
{ 3, 31026 }, -- Slayer's Handguards
{ 4, 32347 }, -- Grips of Damnation
{ 5, 34408 }, -- Gloves of the Forest Drifter
{ 6, 30145 }, -- Deathmantle Handguards
{ 7, 33539 }, -- Trickster's Stickyfingers
{ 8, 29947 }, -- Gloves of the Searing Grip
{ 9, 35032 }, -- Brutal Gladiator's Leather Gloves
{ 10, 25685 }, -- Fel Leather Gloves
{ 11, 28506 }, -- Gloves of Dexterous Manipulation
{ 12, 28776 }, -- Liar's Tongue Gloves
{ 13, 34911 }, -- Handwraps of the Aggressor
{ 14, 30644 }, -- Grips of Deftness
{ 15, 29048 }, -- Netherblade Gloves
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34558 }, -- Slayer's Belt
{ 2, 30106 }, -- Belt of One-Hundred Deaths
{ 3, 34929 }, -- Belt of the Silent Path
{ 4, 30040 }, -- Belt of Deep Shadow
{ 5, 30879 }, -- Don Alejandro's Money Belt
{ 6, 32265 }, -- Shadow-walker's Cord
{ 7, 33211 }, -- Bladeangel's Money Belt
{ 8, 33583 }, -- Waistguard of the Great Beast
{ 9, 35156 }, -- Guardian's Leather Belt
{ 10, 29247 }, -- Girdle of the Deathdealer
{ 11, 28828 }, -- Gronn-Stitched Girdle
{ 12, 35152 }, -- Guardian's Dragonhide Belt
{ 13, 30372 }, -- Socrethar's Girdle
{ 14, 28750 }, -- Girdle of Treachery
{ 15, 33891 }, -- Vindicator's Leather Belt
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34361 }, -- Hard Khorium Band
{ 2, 32497 }, -- Stormrage Signet Ring
{ 3, 34189 }, -- Band of Ruinous Delight
{ 4, 34887 }, -- Angelista's Revenge
{ 5, 33496 }, -- Signet of Primal Wrath
{ 6, 29301 }, -- Band of the Eternal Champion
{ 7, 32266 }, -- Ring of Deceitful Intent
{ 8, 30052 }, -- Ring of Lethality
{ 9, 29997 }, -- Band of the Ranger-General
{ 10, 32526 }, -- Band of Devastation
{ 11, 30738 }, -- Ring of Reciprocity
{ 12, 28757 }, -- Ring of a Thousand Marks
{ 13, 28649 }, -- Garona's Signet Ring
{ 14, 29300 }, -- Band of Eternity (revered)
{ 15, 35131 }, -- Guardian's Band of Triumph
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34188 }, -- Leggings of the Immortal Night
{ 2, 31029 }, -- Slayer's Legguards
{ 3, 34385 }, -- Leggings of the Immortal Beast
{ 4, 28741 }, -- Skulker's Greaves
{ 5, 30898 }, -- Shady Dealer's Pantaloons
{ 6, 35034 }, -- Brutal Gladiator's Leather Legguards
{ 7, 33538 }, -- Shallow-grave Trousers
{ 8, 30148 }, -- Deathmantle Legguards
{ 9, 29995 }, -- Leggings of Murderous Intent
{ 10, 29046 }, -- Netherblade Breeches
{ 11, 34701 }, -- Leggings of the Betrayed
{ 12, 25687 }, -- Fel Leather Leggings
{ 13, 34910 }, -- Tameless Breeches
{ 14, 33702 }, -- Vengeful Gladiator's Leather Legguards
{ 15, 30538 }, -- Midnight Legguards
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34575 }, -- Slayer's Boots
{ 2, 33222 }, -- Nyn'jah's Tabi Boots
{ 3, 32366 }, -- Shadowmaster's Boots
{ 4, 28545 }, -- Edgewalker Longboots
{ 5, 34809 }, -- Sunrage Treads
{ 6, 30891 }, -- Black Featherlight Boots
{ 7, 30039 }, -- Boots of Utter Darkness
{ 8, 25686 }, -- Fel Leather Boots
{ 9, 35141 }, -- Guardian's Leather Boots
{ 10, 35137 }, -- Guardian's Dragonhide Boots
{ 11, 30060 }, -- Boots of Effortless Striking
{ 12, 33892 }, -- Vindicator's Leather Boots
{ 13, 33582 }, -- Footwraps of Wild Encroachment
{ 14, 31288 }, -- The Master's Treads
{ 15, 33880 }, -- Vindicator's Dragonhide Boots
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 28830 }, -- Dragonspine Trophy
{ 2, 34427 }, -- Blackened Naaru Sliver
{ 3, 30450 }, -- Warp-Spring Coil
{ 4, 34472 }, -- Shard of Contempt
{ 5, 32492 }, -- Ashtongue Talisman of Lethality
{ 6, 32505 }, -- Madness of the Betrayer
{ 7, 30627 }, -- Tsunami Talisman
{ 8, 23206 }, -- Mark of the Champion (undead/demon)
{ 9, 33831 }, -- Berserker's Call
{ 10, 34428 }, -- Steely Naaru Sliver
{ 11, 35702 }, -- Figurine - Shadowsong Panther
{ 12, 31856 }, -- Darkmoon Card: Crusade
{ 13, 29383 }, -- Bloodlust Brooch
{ 14, 28288 }, -- Abacus of Violent Odds
{ 15, 28121 }, -- Icon of Unyielding Courage
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34331 }, -- Hand of the Deceiver
{ 2, 34329 }, -- Crux of the Apocalypse
{ 3, 32837 }, -- Warglaive of Azzinoth
{ 4, 34197 }, -- Shiv of Exsanguination
{ 5, 34214 }, -- Muramasa
{ 6, 35076 }, -- Brutal Gladiator's Right Ripper
{ 7, 35071 }, -- Brutal Gladiator's Pummeler
{ 8, 35101 }, -- Brutal Gladiator's Slicer
{ 9, 34893 }, -- Vanir's Right Fist of Brutality
{ 10, 35093 }, -- Brutal Gladiator's Shanker
{ 11, 33737 }, -- Vengeful Gladiator's Right Ripper
{ 12, 33733 }, -- Vengeful Gladiator's Pummeler
{ 13, 33762 }, -- Vengeful Gladiator's Slicer
{ 14, 28439 }, -- Dragonstrike (melee proc)
{ 15, 30881 }, -- Blade of Infamy
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34203 }, -- Grip of Mannoroth
{ 2, 34165 }, -- Fang of Kalecgos
{ 3, 34329 }, -- Crux of the Apocalypse
{ 4, 32838 }, -- Warglaive of Azzinoth
{ 5, 34950 }, -- Vanir's Left Fist of Savagery
{ 6, 35095 }, -- Brutal Gladiator's Shiv
{ 7, 32943 }, -- Swiftsteel Bludgeon
{ 8, 34164 }, -- Dragonscale-Encrusted Longblade
{ 9, 34197 }, -- Shiv of Exsanguination
{ 10, 34988 }, -- Brutal Gladiator's Bonecracker
{ 11, 35038 }, -- Brutal Gladiator's Left Ripper
{ 12, 35072 }, -- Brutal Gladiator's Quickblade
{ 13, 32369 }, -- Blade of Savagery
{ 14, 30865 }, -- Tracker's Blade
{ 15, 33756 }, -- Vengeful Gladiator's Shiv
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
 
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
{ 2, 34334 }, -- Thori'dal, the Stars' Fury
{ 3, 34196 }, -- Golden Bow of Quel'Thalas
{ 4, 34892 }, -- Crossbow of Relentless Strikes
{ 5, 34349 }, -- Blade of Life's Inevitability
{ 6, 29949 }, -- Arcanite Steam-Pistol
{ 7, 30724 }, -- Barrel-Blade Longrifle
{ 8, 33474 }, -- Ancient Amani Longbow
{ 9, 34603 }, -- Distracting Blades
{ 10, 33491 }, -- Tuskbreaker
{ 11, 32326 }, -- Twisted Blades of Zarak
{ 12, 28772 }, -- Sunfury Bow of the Phoenix
{ 13, 29151 }, -- Veteran's Musket
{ 14, 29152 }, -- Marksman's Bow
{ 15, 28504 }, -- Steelhawk Crossbow
{ 16, 34622 }, -- Spinesever
},
},




--@end-version-bcc@
},
}

data["HunterBM"] = {
	name = AL["Hunter BM BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34333 }, -- Coif of Alleria
{ 2, 34244 }, -- Duplicitous Guise
{ 3, 32235 }, -- Cursed Vision of Sargeras
{ 4, 34356 }, -- Surestrike Goggles v3.0
{ 5, 34992 }, -- Brutal Gladiator's Chain Helm
{ 6, 32376 }, -- Forest Prowler's Helm
{ 7, 33666 }, -- Vengeful Gladiator's Chain Helm
{ 8, 31003 }, -- Gronnstalker's Helmet
{ 9, 32474 }, -- Surestrike Goggles v2.0
{ 10, 33479 }, -- Grimgrin Faceguard
{ 11, 30141 }, -- Rift Stalker Helm
{ 12, 31962 }, -- Merciless Gladiator's Chain Helm
{ 13, 33432 }, -- Coif of the Jungle Stalker
{ 14, 32087 }, -- Mask of the Deceiver
{ 15, 28182 }, -- Helm of the Claw
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34358 }, -- Hard Khorium Choker
{ 2, 34177 }, -- Clutch of Demise
{ 3, 32260 }, -- Choker of Endless Nightmares
{ 4, 30017 }, -- Telonicus's Pendant of Mayhem
{ 5, 32591 }, -- Choker of Serrated Blades
{ 6, 35292 }, -- Sin'dorei Pendant of Triumph
{ 7, 24114 }, -- Braided Eternium Chain (GROUP BUFF)
{ 8, 35135 }, -- Guardian's Pendant of Triumph
{ 9, 29381 }, -- Choker of Vile Intent
{ 10, 35507 }, -- Amulet of Bitter Hatred
{ 11, 28509 }, -- Worgen Claw Necklace
{ 12, 34679 }, -- Shattered Sun Pendant of Might
{ 13, 30059 }, -- Choker of Animalistic Fury
{ 14, 33923 }, -- Vindicator's Pendant of Triumph
{ 15, 27779 }, -- Bone Chain Necklace
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34194 }, -- Mantle of the Golden Forest
{ 2, 34195 }, -- Shoulderpads of Vehemence
{ 3, 31006 }, -- Gronnstalker's Spaulders
{ 4, 32581 }, -- Swiftstrike Shoulders
{ 5, 32264 }, -- Shoulders of the Hidden Predator
{ 6, 32575 }, -- Shoulders of Lightning Reflexes
{ 7, 32377 }, -- Mantle of Darkness
{ 8, 34994 }, -- Brutal Gladiator's Chain Spaulders
{ 9, 33206 }, -- Pauldrons of Primal Fury
{ 10, 30917 }, -- Razorfury Mantle
{ 11, 34613 }, -- Shoulderpads of the Silvermoon Retainer
{ 12, 30055 }, -- Shoulderpads of the Stranger
{ 13, 30085 }, -- Mantle of the Tireless Tracker
{ 14, 33300 }, -- Shoulderpads of Dancing Blades
{ 15, 30892 }, -- Beast-tamer's Shoulders
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34241 }, -- Cloak of Unforgivable Sin
{ 2, 32323 }, -- Shadowmoon Destroyer's Drape
{ 3, 33590 }, -- Cloak of Fiends
{ 4, 29994 }, -- Thalassian Wildercloak
{ 5, 33484 }, -- Dory's Embrace
{ 6, 28672 }, -- Drape of the Dark Reavers
{ 7, 30729 }, -- Black-Iron Battlecloak
{ 8, 24259 }, -- Vengeance Wrap
{ 9, 29382 }, -- Blood Knight War Cloak
{ 10, 35495 }, -- The Frost Lord's War Cloak
{ 11, 28777 }, -- Cloak of the Pit Stalker
{ 12, 27878 }, -- Auchenai Death Shroud
{ 13, 31255 }, -- Cloak of the Craft
{ 14, 32540 }, -- Terokk's Might
{ 15, 34708 }, -- Cloak of the Coming Night
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34397 }, -- Bladed Chaos Tunic
{ 2, 34369 }, -- Carapace of Sun and Shadow
{ 3, 30905 }, -- Midnight Chestguard
{ 4, 34927 }, -- Tunic of the Dark Hour
{ 5, 32252 }, -- Nether Shadow Tunic
{ 6, 30907 }, -- Mail of Fevered Pursuit
{ 7, 34912 }, -- Scaled Drakeskin Chestguard
{ 8, 34990 }, -- Brutal Gladiator's Chain Armor
{ 9, 33329 }, -- Shadowtooth Trollskin Cuirass
{ 10, 31004 }, -- Gronnstalker's Chestguard
{ 11, 32334 }, -- Vest of Mounting Assault
{ 12, 30139 }, -- Rift Stalker Hauberk
{ 13, 30101 }, -- Bloodsea Brigand's Vest
{ 14, 30054 }, -- Ranger-General's Chestguard
{ 15, 33664 }, -- Vengeful Gladiator's Chain Armor
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34443 }, -- Gronnstalker's Bracers
{ 2, 32324 }, -- Insidious Bands
{ 3, 32574 }, -- Bindings of Lightning Reflexes
{ 4, 32580 }, -- Swiftstrike Bracers
{ 5, 30863 }, -- Deadly Cuffs
{ 6, 33540 }, -- Master Assassin Wristwraps
{ 7, 32251 }, -- Wraps of Precise Flight
{ 8, 35166 }, -- Guardian's Chain Bracers
{ 9, 33529 }, -- Steadying Bracers
{ 10, 29966 }, -- Vambraces of Ending
{ 11, 30864 }, -- Bracers of the Pathfinder
{ 12, 30026 }, -- Bands of the Celestial Archer
{ 13, 33876 }, -- Vindicator's Chain Bracers
{ 14, 30091 }, -- True-Aim Stalker Bands
{ 15, 34698 }, -- Bracers of the Forest Stalker
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34343 }, -- Thalassian Ranger Gauntlets
{ 2, 34370 }, -- Gloves of Immortal Dusk
{ 3, 34234 }, -- Shadowed Gauntlets of Paroxysm
{ 4, 34374 }, -- Fletcher's Gloves of the Phoenix
{ 5, 31001 }, -- Gronnstalker's Gloves
{ 6, 32347 }, -- Grips of Damnation
{ 7, 32234 }, -- Fists of Mukoa
{ 8, 34916 }, -- Gauntlets of Rapidity
{ 9, 33539 }, -- Trickster's Stickyfingers
{ 10, 30140 }, -- Rift Stalker Gauntlets
{ 11, 34991 }, -- Brutal Gladiator's Chain Gauntlets
{ 12, 33528 }, -- Gauntlets of Sniping
{ 13, 28506 }, -- Gloves of Dexterous Manipulation
{ 14, 28776 }, -- Liar's Tongue Gloves
{ 15, 34408 }, -- Gloves of the Forest Drifter
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34549 }, -- Gronnstalker's Belt
{ 2, 32346 }, -- Boneweave Girdle
{ 3, 34929 }, -- Belt of the Silent Path
{ 4, 30879 }, -- Don Alejandro's Money Belt
{ 5, 32265 }, -- Shadow-walker's Cord
{ 6, 30919 }, -- Valestalker Girdle
{ 7, 30040 }, -- Belt of Deep Shadow
{ 8, 33211 }, -- Bladeangel's Money Belt
{ 9, 30106 }, -- Belt of One-Hundred Deaths
{ 10, 30046 }, -- Belt of the Black Eagle
{ 11, 35151 }, -- Guardian's Chain Girdle
{ 12, 29247 }, -- Girdle of the Deathdealer
{ 13, 28828 }, -- Gronn-Stitched Girdle
{ 14, 25789 }, -- Rune-Engraved Belt
{ 15, 33280 }, -- War-Feathered Loop
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34361 }, -- Hard Khorium Band
{ 2, 34189 }, -- Band of Ruinous Delight
{ 3, 34887 }, -- Angelista's Revenge
{ 4, 33496 }, -- Signet of Primal Wrath
{ 5, 32497 }, -- Stormrage Signet Ring
{ 6, 29301 }, -- Band of the Eternal Champion
{ 7, 32266 }, -- Ring of Deceitful Intent
{ 8, 30052 }, -- Ring of Lethality
{ 9, 29997 }, -- Band of the Ranger-General
{ 10, 29300 }, -- Band of Eternity (revered)
{ 11, 32526 }, -- Band of Devastation
{ 12, 35131 }, -- Guardian's Band of Triumph
{ 13, 30738 }, -- Ring of Reciprocity
{ 14, 29299 }, -- Band of Eternity (honored)
{ 15, 28757 }, -- Ring of a Thousand Marks
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34188 }, -- Leggings of the Immortal Night
{ 2, 34168 }, -- Starstalker Legguards
{ 3, 30900 }, -- Bow-stitched Leggings
{ 4, 30898 }, -- Shady Dealer's Pantaloons
{ 5, 29995 }, -- Leggings of Murderous Intent
{ 6, 34993 }, -- Brutal Gladiator's Chain Leggings
{ 7, 33538 }, -- Shallow-grave Trousers
{ 8, 31005 }, -- Gronnstalker's Leggings
{ 9, 30739 }, -- Scaled Greaves of the Marksman
{ 10, 28741 }, -- Skulker's Greaves
{ 11, 30142 }, -- Rift Stalker Leggings
{ 12, 33527 }, -- Shifting Camouflage Pants
{ 13, 33667 }, -- Vengeful Gladiator's Chain Leggings
{ 14, 29985 }, -- Void Reaver Greaves
{ 15, 34385 }, -- Leggings of the Immortal Beast
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34570 }, -- Gronnstalker's Boots
{ 2, 32510 }, -- Softstep Boots of Tracking
{ 3, 32366 }, -- Shadowmaster's Boots
{ 4, 33222 }, -- Nyn'jah's Tabi Boots
{ 5, 34809 }, -- Sunrage Treads
{ 6, 30880 }, -- Quickstrider Moccasins
{ 7, 29951 }, -- Star-Strider Boots
{ 8, 30104 }, -- Cobra-Lash Boots
{ 9, 35136 }, -- Guardian's Chain Sabatons
{ 10, 28545 }, -- Edgewalker Longboots
{ 11, 33805 }, -- Shadowhunter's Treads
{ 12, 30039 }, -- Boots of Utter Darkness
{ 13, 30891 }, -- Black Featherlight Boots
{ 14, 30045 }, -- Boots of the Crimson Hawk
{ 15, 30060 }, -- Boots of Effortless Striking
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 28830 }, -- Dragonspine Trophy
{ 2, 34427 }, -- Blackened Naaru Sliver
{ 3, 32505 }, -- Madness of the Betrayer
{ 4, 23206 }, -- Mark of the Champion (undead/demon)
{ 5, 33831 }, -- Berserker's Call
{ 6, 30627 }, -- Tsunami Talisman
{ 7, 35702 }, -- Figurine - Shadowsong Panther
{ 8, 31856 }, -- Darkmoon Card: Crusade
{ 9, 29383 }, -- Bloodlust Brooch
{ 10, 23041 }, -- Slayer's Crest
{ 11, 28034 }, -- Hourglass of the Unraveller
{ 12, 28288 }, -- Abacus of Violent Odds
{ 13, 34472 }, -- Shard of Contempt
{ 14, 30448 }, -- Talon of Al'ar
{ 15, 19406 }, -- Drake Fang Talisman
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34197 }, -- Shiv of Exsanguination
{ 2, 34329 }, -- Crux of the Apocalypse
{ 3, 34331 }, -- Hand of the Deceiver
{ 4, 34165 }, -- Fang of Kalecgos
{ 5, 34203 }, -- Grip of Mannoroth
{ 6, 34893 }, -- Vanir's Right Fist of Brutality
{ 7, 33389 }, -- Dagger of Bad Mojo
{ 8, 34346 }, -- Mounting Vengeance
{ 9, 30881 }, -- Blade of Infamy
{ 10, 34950 }, -- Vanir's Left Fist of Savagery
{ 11, 34951 }, -- Vanir's Left Fist of Brutality
{ 12, 30865 }, -- Tracker's Blade
{ 13, 32944 }, -- Talon of the Phoenix
{ 14, 30082 }, -- Talon of Azshara
{ 15, 32369 }, -- Blade of Savagery
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
 
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34183 }, -- Shivering Felspine
{ 2, 34247 }, -- Apolyon, the Soul-Render
{ 3, 34891 }, -- The Blade of Harbingers
{ 4, 32248 }, -- Halberd of Desolation
{ 5, 34997 }, -- Brutal Gladiator's Decapitator
{ 6, 33670 }, -- Vengeful Gladiator's Decapitator
{ 7, 34014 }, -- Vengeful Gladiator's Waraxe
{ 8, 29993 }, -- Twinblade of the Phoenix
{ 9, 30789 }, -- Illidari-Bane Claymore (Demon)
{ 10, 33492 }, -- Trollbane
{ 11, 28436 }, -- Bloodmoon
{ 12, 33478 }, -- Jin'rohk, The Great Apocalypse
{ 13, 28435 }, -- Mooncleaver
{ 14, 35064 }, -- Brutal Gladiator's Painsaw
{ 15, 31966 }, -- Merciless Gladiator's Decapitator

},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
{ 1, 34334 }, -- Thori'dal, the Stars' Fury
{ 2, 34196 }, -- Golden Bow of Quel'Thalas
{ 3, 35018 }, -- Brutal Gladiator's Heavy Crossbow (Ranged AP)
{ 4, 35047 }, -- Brutal Gladiator's Longbow (Ranged AP)
{ 5, 35075 }, -- Brutal Gladiator's Rifle (Ranged AP)
{ 6, 34892 }, -- Crossbow of Relentless Strikes
{ 7, 33006 }, -- Vengeful Gladiator's Heavy Crossbow (Ranged AP)
{ 8, 34529 }, -- Vengeful Gladiator's Longbow (Ranged AP)
{ 9, 34530 }, -- Vengeful Gladiator's Rifle (Ranged AP)
{ 10, 30906 }, -- Bristleblitz Striker
{ 11, 32336 }, -- Black Bow of the Betrayer
{ 12, 30105 }, -- Serpent Spine Longbow
{ 13, 29949 }, -- Arcanite Steam-Pistol
{ 14, 32253 }, -- Legionkiller
{ 15, 33474 }, -- Ancient Amani Longbow
},
},




--@end-version-bcc@
},
}

data["HunterSurv"] = {
	name = AL["Hunter Surv BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34333 }, -- Coif of Alleria
{ 2, 34244 }, -- Duplicitous Guise
{ 3, 32235 }, -- Cursed Vision of Sargeras
{ 4, 34992 }, -- Brutal Gladiator's Chain Helm
{ 5, 32376 }, -- Forest Prowler's Helm
{ 6, 31003 }, -- Gronnstalker's Helmet
{ 7, 33666 }, -- Vengeful Gladiator's Chain Helm
{ 8, 31962 }, -- Merciless Gladiator's Chain Helm
{ 9, 30141 }, -- Rift Stalker Helm
{ 10, 33479 }, -- Grimgrin Faceguard
{ 11, 34404 }, -- Mask of the Fury Hunter
{ 12, 28331 }, -- Gladiator's Chain Helm
{ 13, 33432 }, -- Coif of the Jungle Stalker
{ 14, 32087 }, -- Mask of the Deceiver
{ 15, 29081 }, -- Demon Stalker Greathelm
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34177 }, -- Clutch of Demise
{ 2, 30017 }, -- Telonicus's Pendant of Mayhem
{ 3, 34358 }, -- Hard Khorium Choker
{ 4, 32508 }, -- Necklace of the Deep
{ 5, 29381 }, -- Choker of Vile Intent
{ 6, 35507 }, -- Amulet of Bitter Hatred
{ 7, 28509 }, -- Worgen Claw Necklace
{ 8, 19377 }, -- Prestor's Talisman of Connivery
{ 9, 28343 }, -- Jagged Bark Pendant
{ 10, 25562 }, -- Earthen Mark of Razing
{ 11, 34679 }, -- Shattered Sun Pendant of Might
{ 12, 28674 }, -- Saberclaw Talisman
{ 13, 27779 }, -- Bone Chain Necklace
{ 14, 32260 }, -- Choker of Endless Nightmares
{ 15, 31147 }, -- Pendant of Cunning
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34194 }, -- Mantle of the Golden Forest
{ 2, 34195 }, -- Shoulderpads of Vehemence
{ 3, 34994 }, -- Brutal Gladiator's Chain Spaulders
{ 4, 31006 }, -- Gronnstalker's Spaulders
{ 5, 32264 }, -- Shoulders of the Hidden Predator
{ 6, 32581 }, -- Swiftstrike Shoulders
{ 7, 30055 }, -- Shoulderpads of the Stranger
{ 8, 32575 }, -- Shoulders of Lightning Reflexes
{ 9, 33668 }, -- Vengeful Gladiator's Chain Spaulders
{ 10, 33206 }, -- Pauldrons of Primal Fury
{ 11, 30892 }, -- Beast-tamer's Shoulders
{ 12, 34392 }, -- Demontooth Shoulderpads
{ 13, 34613 }, -- Shoulderpads of the Silvermoon Retainer
{ 14, 30143 }, -- Rift Stalker Mantle
{ 15, 31964 }, -- Merciless Gladiator's Chain Spaulders
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34241 }, -- Cloak of Unforgivable Sin
{ 2, 29994 }, -- Thalassian Wildercloak
{ 3, 33590 }, -- Cloak of Fiends
{ 4, 28672 }, -- Drape of the Dark Reavers
{ 5, 31255 }, -- Cloak of the Craft
{ 6, 29382 }, -- Blood Knight War Cloak
{ 7, 35495 }, -- The Frost Lord's War Cloak
{ 8, 27519 }, -- Cloak of Malice
{ 9, 27878 }, -- Auchenai Death Shroud
{ 10, 32540 }, -- Terokk's Might
{ 11, 32323 }, -- Shadowmoon Destroyer's Drape
{ 12, 21710 }, -- Cloak of the Fallen God
{ 13, 27423 }, -- Cloak of Impulsiveness
{ 14, 32665 }, -- Crystalweave Cape
{ 15, 32539 }, -- Skyguard's Drape
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34369 }, -- Carapace of Sun and Shadow
{ 2, 34397 }, -- Bladed Chaos Tunic
{ 3, 34373 }, -- Embrace of the Phoenix
{ 4, 32334 }, -- Vest of Mounting Assault
{ 5, 34927 }, -- Tunic of the Dark Hour
{ 6, 34912 }, -- Scaled Drakeskin Chestguard
{ 7, 30907 }, -- Mail of Fevered Pursuit
{ 8, 33329 }, -- Shadowtooth Trollskin Cuirass
{ 9, 34990 }, -- Brutal Gladiator's Chain Armor
{ 10, 31004 }, -- Gronnstalker's Chestguard
{ 11, 32252 }, -- Nether Shadow Tunic
{ 12, 34228 }, -- Vicious Hawkstrider Hauberk
{ 13, 30139 }, -- Rift Stalker Hauberk
{ 14, 30054 }, -- Ranger-General's Chestguard
{ 15, 34211 }, -- Harness of Carnal Instinct
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34443 }, -- Gronnstalker's Bracers
{ 2, 32324 }, -- Insidious Bands
{ 3, 32574 }, -- Bindings of Lightning Reflexes
{ 4, 32580 }, -- Swiftstrike Bracers
{ 5, 35166 }, -- Guardian's Chain Bracers
{ 6, 30864 }, -- Bracers of the Pathfinder
{ 7, 29966 }, -- Vambraces of Ending
{ 8, 33540 }, -- Master Assassin Wristwraps
{ 9, 32251 }, -- Wraps of Precise Flight
{ 10, 33529 }, -- Steadying Bracers
{ 11, 33876 }, -- Vindicator's Chain Bracers
{ 12, 29246 }, -- Nightfall Wristguards
{ 13, 30026 }, -- Bands of the Celestial Archer
{ 14, 32814 }, -- Veteran's Leather Bracers
{ 15, 32647 }, -- Shard-bound Bracers
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34343 }, -- Thalassian Ranger Gauntlets
{ 2, 34370 }, -- Gloves of Immortal Dusk
{ 3, 34234 }, -- Shadowed Gauntlets of Paroxysm
{ 4, 31001 }, -- Gronnstalker's Gloves
{ 5, 34374 }, -- Fletcher's Gloves of the Phoenix
{ 6, 34916 }, -- Gauntlets of Rapidity
{ 7, 32347 }, -- Grips of Damnation
{ 8, 32234 }, -- Fists of Mukoa
{ 9, 34991 }, -- Brutal Gladiator's Chain Gauntlets
{ 10, 33539 }, -- Trickster's Stickyfingers
{ 11, 30140 }, -- Rift Stalker Gauntlets
{ 12, 34408 }, -- Gloves of the Forest Drifter
{ 13, 28506 }, -- Gloves of Dexterous Manipulation
{ 14, 33665 }, -- Vengeful Gladiator's Chain Gauntlets
{ 15, 33528 }, -- Gauntlets of Sniping
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34549 }, -- Gronnstalker's Belt
{ 2, 32346 }, -- Boneweave Girdle
{ 3, 30879 }, -- Don Alejandro's Money Belt
{ 4, 34929 }, -- Belt of the Silent Path
{ 5, 32265 }, -- Shadow-walker's Cord
{ 6, 30919 }, -- Valestalker Girdle
{ 7, 30040 }, -- Belt of Deep Shadow
{ 8, 35151 }, -- Guardian's Chain Girdle
{ 9, 30106 }, -- Belt of One-Hundred Deaths
{ 10, 33211 }, -- Bladeangel's Money Belt
{ 11, 33877 }, -- Vindicator's Chain Girdle
{ 12, 29247 }, -- Girdle of the Deathdealer
{ 13, 33280 }, -- War-Feathered Loop
{ 14, 28750 }, -- Girdle of Treachery
{ 15, 33583 }, -- Waistguard of the Great Beast
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34361 }, -- Hard Khorium Band
{ 2, 34887 }, -- Angelista's Revenge
{ 3, 33496 }, -- Signet of Primal Wrath
{ 4, 29301 }, -- Band of the Eternal Champion
{ 5, 29300 }, -- Band of Eternity (revered)
{ 6, 30052 }, -- Ring of Lethality
{ 7, 29299 }, -- Band of Eternity (honored)
{ 8, 32266 }, -- Ring of Deceitful Intent
{ 9, 29298 }, -- Band of Eternity (friendly)
{ 10, 28791 }, -- Ring of the Recalcitrant
{ 11, 34189 }, -- Band of Ruinous Delight
{ 12, 28649 }, -- Garona's Signet Ring
{ 13, 31277 }, -- Pathfinder's Band
{ 14, 22961 }, -- Band of Reanimation
{ 15, 32942 }, -- Ring of the Overseer
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34188 }, -- Leggings of the Immortal Night
{ 2, 34168 }, -- Starstalker Legguards
{ 3, 30898 }, -- Shady Dealer's Pantaloons
{ 4, 30900 }, -- Bow-stitched Leggings
{ 5, 30739 }, -- Scaled Greaves of the Marksman
{ 6, 29995 }, -- Leggings of Murderous Intent
{ 7, 33538 }, -- Shallow-grave Trousers
{ 8, 34385 }, -- Leggings of the Immortal Beast
{ 9, 34993 }, -- Brutal Gladiator's Chain Leggings
{ 10, 31005 }, -- Gronnstalker's Leggings
{ 11, 30142 }, -- Rift Stalker Leggings
{ 12, 28741 }, -- Skulker's Greaves
{ 13, 29985 }, -- Void Reaver Greaves
{ 14, 33527 }, -- Shifting Camouflage Pants
{ 15, 33667 }, -- Vengeful Gladiator's Chain Leggings
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34570 }, -- Gronnstalker's Boots
{ 2, 32366 }, -- Shadowmaster's Boots
{ 3, 33222 }, -- Nyn'jah's Tabi Boots
{ 4, 32510 }, -- Softstep Boots of Tracking
{ 5, 30104 }, -- Cobra-Lash Boots
{ 6, 34809 }, -- Sunrage Treads
{ 7, 30880 }, -- Quickstrider Moccasins
{ 8, 30060 }, -- Boots of Effortless Striking
{ 9, 35136 }, -- Guardian's Chain Sabatons
{ 10, 28545 }, -- Edgewalker Longboots
{ 11, 29951 }, -- Star-Strider Boots
{ 12, 28746 }, -- Fiend Slayer Boots
{ 13, 33878 }, -- Vindicator's Chain Sabatons
{ 14, 33805 }, -- Shadowhunter's Treads
{ 15, 30045 }, -- Boots of the Crimson Hawk
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 28830 }, -- Dragonspine Trophy
{ 2, 34427 }, -- Blackened Naaru Sliver
{ 3, 32505 }, -- Madness of the Betrayer
{ 4, 23206 }, -- Mark of the Champion (undead/demon)
{ 5, 33831 }, -- Berserker's Call
{ 6, 30627 }, -- Tsunami Talisman
{ 7, 35702 }, -- Figurine - Shadowsong Panther
{ 8, 32658 }, -- Badge of Tenacity
{ 9, 31856 }, -- Darkmoon Card: Crusade
{ 10, 29383 }, -- Bloodlust Brooch
{ 11, 28288 }, -- Abacus of Violent Odds
{ 12, 23041 }, -- Slayer's Crest
{ 13, 28034 }, -- Hourglass of the Unraveller
{ 14, 34472 }, -- Shard of Contempt
{ 15, 22954 }, -- Kiss of the Spider
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34197 }, -- Shiv of Exsanguination
{ 2, 34329 }, -- Crux of the Apocalypse
{ 3, 34165 }, -- Fang of Kalecgos
{ 4, 34893 }, -- Vanir's Right Fist of Brutality
{ 5, 30881 }, -- Blade of Infamy
{ 6, 33389 }, -- Dagger of Bad Mojo
{ 7, 29924 }, -- Netherbane
{ 8, 32269 }, -- Messenger of Fate
{ 9, 34331 }, -- Hand of the Deceiver
{ 10, 34616 }, -- Breeching Comet
{ 11, 29948 }, -- Claw of the Phoenix
{ 12, 30082 }, -- Talon of Azshara
{ 13, 33495 }, -- Rage
{ 14, 32946 }, -- Claw of Molten Fury
{ 15, 32945 }, -- Fist of Molten Fury
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
 
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34183 }, -- Shivering Felspine
{ 2, 32248 }, -- Halberd of Desolation
{ 3, 34247 }, -- Apolyon, the Soul-Render
{ 4, 33492 }, -- Trollbane
{ 5, 34891 }, -- The Blade of Harbingers
{ 6, 28587 }, -- Legacy
{ 7, 29329 }, -- Terokk's Quill
{ 8, 27903 }, -- Sonic Spear
{ 9, 29166 }, -- Hellforged Halberd
{ 10, 29167 }, -- Blackened Spear
{ 11, 34997 }, -- Brutal Gladiator's Decapitator
{ 12, 29993 }, -- Twinblade of the Phoenix
{ 13, 28429 }, -- Lionheart Champion
{ 14, 28430 }, -- Lionheart Executioner
{ 15, 33670 }, -- Vengeful Gladiator's Decapitator

},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
{ 1, 34334 }, -- Thori'dal, the Stars' Fury
{ 2, 34196 }, -- Golden Bow of Quel'Thalas
{ 3, 35018 }, -- Brutal Gladiator's Heavy Crossbow (Ranged AP)
{ 4, 35047 }, -- Brutal Gladiator's Longbow (Ranged AP)
{ 5, 35075 }, -- Brutal Gladiator's Rifle (Ranged AP)
{ 6, 32253 }, -- Legionkiller
{ 7, 29949 }, -- Arcanite Steam-Pistol
{ 8, 34892 }, -- Crossbow of Relentless Strikes
{ 9, 30724 }, -- Barrel-Blade Longrifle
{ 10, 30906 }, -- Bristleblitz Striker
{ 11, 33006 }, -- Vengeful Gladiator's Heavy Crossbow (Ranged AP)
{ 12, 34529 }, -- Vengeful Gladiator's Longbow (Ranged AP)
{ 13, 34530 }, -- Vengeful Gladiator's Rifle (Ranged AP)
{ 14, 28772 }, -- Sunfury Bow of the Phoenix
{ 15, 30105 }, -- Serpent Spine Longbow
},
},




--@end-version-bcc@
},
}


data["DruidResto"] = {
	name = AL["Druid Resto BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34245 }, -- Cover of Ursol the Wise
{ 2, 34339 }, -- Cowl of Light's Purity
{ 3, 35183 }, -- Wonderheal XT68 Shades
{ 4, 35181 }, -- Powerheal 9000 Lens
{ 5, 31037 }, -- Thunderheart Helmet
{ 6, 32329 }, -- Cowl of Benevolence
{ 7, 33463 }, -- Hood of the Third Eye
{ 8, 30219 }, -- Nordrassil Headguard
{ 9, 33356 }, -- Helm of Natural Regeneration
{ 10, 32479 }, -- Wonderheal XT40 Shades
{ 11, 35023 }, -- Brutal Gladiator's Kodohide Helm
{ 12, 32240 }, -- Guise of the Tidal Lurker
{ 13, 32495 }, -- Powerheal 4000 Lens
{ 14, 24264 }, -- Whitemend Hood
{ 15, 33691 }, -- Vengeful Gladiator's Kodohide Helm
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34360 }, -- Amulet of Flowing Life
{ 2, 35291 }, -- Sin'dorei Pendant of Salvation
{ 3, 30018 }, -- Lord Sanguinar's Claim
{ 4, 35134 }, -- Guardian's Pendant of Salvation
{ 5, 33281 }, -- Brooch of Nature's Mercy
{ 6, 32370 }, -- Nadina's Pendant of Purity
{ 7, 37929 }, -- Guardian's Pendant of Reprieve
{ 8, 30726 }, -- Archaic Charm of Presence
{ 9, 34184 }, -- Brooch of the Highborne
{ 10, 33922 }, -- Vindicator's Pendant of Salvation
{ 11, 35317 }, -- Vindicator's Pendant of Reprieve
{ 12, 34677 }, -- Shattered Sun Pendant of Restoration
{ 13, 33068 }, -- Veteran's Pendant of Salvation
{ 14, 28609 }, -- Emberspur Talisman
{ 15, 32531 }, -- Gezzarak's Fang
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34209 }, -- Spaulders of Reclamation
{ 2, 34202 }, -- Shawl of Wonderment
{ 3, 31047 }, -- Thunderheart Spaulders
{ 4, 30221 }, -- Nordrassil Life-Mantle
{ 5, 33287 }, -- Gnarled Ironwood Pauldrons
{ 6, 29089 }, -- Shoulderguards of Malorne
{ 7, 35025 }, -- Brutal Gladiator's Kodohide Spaulders
{ 8, 30111 }, -- Runetotem's Mantle
{ 9, 33693 }, -- Vengeful Gladiator's Kodohide Spaulders
{ 10, 21874 }, -- Primal Mooncloth Shoulders
{ 11, 32518 }, -- Veil of Turning Leaves
{ 12, 31990 }, -- Merciless Gladiator's Kodohide Spaulders
{ 13, 32273 }, -- Amice of Brilliant Light
{ 14, 31378 }, -- Gladiator's Kodohide Spaulders
{ 15, 32585 }, -- Swiftheal Mantle
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 32337 }, -- Shroud of Forgiveness
{ 2, 29989 }, -- Sunshower Light Cloak
{ 3, 34205 }, -- Shroud of Redeemed Souls
{ 4, 34012 }, -- Shroud of the Final Stand
{ 5, 32524 }, -- Shroud of the Highborne
{ 6, 31329 }, -- Lifegiving Cloak
{ 7, 28765 }, -- Stainless Cloak of the Pure Hearted
{ 8, 24254 }, -- White Remedy Cape
{ 9, 32653 }, -- Apexis Cloak
{ 10, 29354 }, -- Light-Touched Stole of Altruism
{ 11, 33333 }, -- Kharmaa's Shroud of Hope
{ 12, 28582 }, -- Red Riding Hood's Cloak
{ 13, 22960 }, -- Cloak of Suturing
{ 14, 27448 }, -- Cloak of the Everliving
{ 15, 33592 }, -- Cloak of Ancient Rituals
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34371 }, -- Leather Chestguard of the Sun
{ 2, 34233 }, -- Robes of Faltered Light
{ 3, 34212 }, -- Sunglow Vest
{ 4, 34365 }, -- Robe of Eternal Light
{ 5, 31041 }, -- Thunderheart Tunic
{ 6, 30216 }, -- Nordrassil Chestguard
{ 7, 33203 }, -- Robes of Heavenly Purpose
{ 8, 35026 }, -- Brutal Gladiator's Kodohide Tunic
{ 9, 21875 }, -- Primal Mooncloth Robe
{ 10, 29087 }, -- Chestguard of Malorne
{ 11, 33694 }, -- Vengeful Gladiator's Kodohide Tunic
{ 12, 34900 }, -- Shroud of Nature's Harmony
{ 13, 34924 }, -- Gown of Spiritual Wonder
{ 14, 31991 }, -- Merciless Gladiator's Kodohide Tunic
{ 15, 29522 }, -- Windhawk Hauberk
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34445 }, -- Thunderheart Bracers
{ 2, 30868 }, -- Rejuvenating Bracers
{ 3, 30871 }, -- Bracers of Martyrdom
{ 4, 30684 }, -- Ravager's Cuffs of Healing
{ 5, 33557 }, -- Gargon's Bracers of Peaceful Slumber
{ 6, 33589 }, -- Wristguards of Tranquil Thought
{ 7, 34602 }, -- Eversong Cuffs
{ 8, 35169 }, -- Guardian's Kodohide Bracers
{ 9, 30062 }, -- Grove-Bands of Remulos
{ 10, 32513 }, -- Wristbands of Divine Influence
{ 11, 29523 }, -- Windhawk Bracers
{ 12, 32980 }, -- Veteran's Mooncloth Cuffs
{ 13, 33887 }, -- Vindicator's Kodohide Bracers
{ 14, 32584 }, -- Swiftheal Wraps
{ 15, 34705 }, -- Bracers of Divine Infusion
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34367 }, -- Hands of Eternal Light
{ 2, 34351 }, -- Tranquil Majesty Wraps
{ 3, 34342 }, -- Handguards of the Dawn
{ 4, 34372 }, -- Leather Gauntlets of the Sun
{ 5, 32353 }, -- Gloves of Unfailing Faith
{ 6, 32328 }, -- Botanist's Gloves of Growth
{ 7, 33587 }, -- Light-Blessed Bonds
{ 8, 31032 }, -- Thunderheart Gloves
{ 9, 34902 }, -- Oakleaf-Spun Handguards
{ 10, 28521 }, -- Mitts of the Treemender
{ 11, 35022 }, -- Brutal Gladiator's Kodohide Gloves
{ 12, 28508 }, -- Gloves of Saintly Blessings
{ 13, 30217 }, -- Nordrassil Gloves
{ 14, 33690 }, -- Vengeful Gladiator's Kodohide Gloves
{ 15, 30029 }, -- Bark-Gloves of Ancient Wisdom
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34554 }, -- Thunderheart Belt
{ 2, 21873 }, -- Primal Mooncloth Belt
{ 3, 33483 }, -- Life-step Belt
{ 4, 32519 }, -- Belt of Divine Guidance
{ 5, 30036 }, -- Belt of the Long Road
{ 6, 29984 }, -- Girdle of Zaetar
{ 7, 33480 }, -- Cord of Braided Troll Hair
{ 8, 30675 }, -- Lurker's Cord of Healing
{ 9, 29524 }, -- Windhawk Belt
{ 10, 34793 }, -- Cord of Reconstruction
{ 11, 35154 }, -- Guardian's Kodohide Belt
{ 12, 30895 }, -- Angelista's Sash
{ 13, 32339 }, -- Belt of Primal Majesty
{ 14, 33885 }, -- Vindicator's Kodohide Belt
{ 15, 30675 }, -- Lurker's Cord of the Prophet
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 29309 }, -- Band of the Eternal Restorer
{ 2, 35733 }, -- Ring of Harmonic Beauty
{ 3, 30110 }, -- Coral Band of the Revived
{ 4, 34166 }, -- Band of Lucent Beams
{ 5, 32528 }, -- Blessed Band of Karabor
{ 6, 34890 }, -- Anveena's Touch
{ 7, 29308 }, -- Band of Eternity (revered)
{ 8, 34363 }, -- Ring of Flowing Life
{ 9, 30736 }, -- Ring of Flowing Light
{ 10, 34625 }, -- Kharmaa's Ring of Fate
{ 11, 28763 }, -- Jade Ring of the Everliving
{ 12, 35283 }, -- Sin'dorei Band of Salvation
{ 13, 32238 }, -- Ring of Calming Waves
{ 14, 33498 }, -- Signet of the Quiet Forest
{ 15, 29306 }, -- Band of Eternity (honored)
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34384 }, -- Breeches of Natural Splendor
{ 2, 34170 }, -- Pantaloons of Calming Strife
{ 3, 30912 }, -- Leggings of Eternity
{ 4, 32271 }, -- Kilt of Immortal Nature
{ 5, 30727 }, -- Gilded Trousers of Benediction
{ 6, 34901 }, -- Grovewalker's Leggings
{ 7, 34925 }, -- Adorned Supernal Legwraps
{ 8, 33552 }, -- Pants of Splendid Recovery
{ 9, 31045 }, -- Thunderheart Legguards
{ 10, 28591 }, -- Earthsoul Leggings
{ 11, 28742 }, -- Pantaloons of Repentance
{ 12, 30543 }, -- Pontifex Kilt
{ 13, 30220 }, -- Nordrassil Life-Kilt
{ 14, 24261 }, -- Whitemend Pants
{ 15, 35024 }, -- Brutal Gladiator's Kodohide Legguards
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 30737 }, -- Gold-Leaf Wildboots
{ 2, 34571 }, -- Thunderheart Boots
{ 3, 32609 }, -- Boots of the Divine Light
{ 4, 30092 }, -- Orca-Hide Boots
{ 5, 34926 }, -- Slippers of Dutiful Mending
{ 6, 30100 }, -- Soul-Strider Boots
{ 7, 33471 }, -- Two-toed Sandals
{ 8, 30680 }, -- Glider's Foot-Wraps of Healing
{ 9, 28752 }, -- Forestlord Striders
{ 10, 34707 }, -- Boots of Resuscitation
{ 11, 30885 }, -- Archbishop's Slippers
{ 12, 30886 }, -- Enchanted Leather Sandals
{ 13, 35139 }, -- Guardian's Kodohide Boots
{ 14, 30035 }, -- Boots of the Long Road
{ 15, 27411 }, -- Slippers of Serenity
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 29376 }, -- Essence of the Martyr
{ 2, 38288 }, -- Direbrew Hops
{ 3, 32496 }, -- Memento of Tyrande
{ 4, 34430 }, -- Glimmering Naaru Sliver
{ 5, 23047 }, -- Eye of the Dead
{ 6, 25634 }, -- Oshu'gun Relic
{ 7, 34050 }, -- Battlemaster's Perseverance
{ 8, 34580 }, -- Battlemaster's Perseverance
{ 9, 30841 }, -- Lower City Prayerbook
{ 10, 33828 }, -- Tome of Diabolic Remedy
{ 11, 28590 }, -- Ribbon of Sacrifice
{ 12, 19395 }, -- Rejuvenating Gem
{ 13, 28190 }, -- Scarab of the Infinite Cycle
{ 14, 28823 }, -- Eye of Gruul
{ 15, 24390 }, -- Auslese's Light Channeler
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34335 }, -- Hammer of Sanctification
{ 2, 34199 }, -- Archon's Gavel
{ 3, 35082 }, -- Brutal Gladiator's Salvation
{ 4, 32500 }, -- Crystal Spire of Karabor
{ 5, 34896 }, -- Gavel of Naaru Blessings
{ 6, 33743 }, -- Vengeful Gladiator's Salvation
{ 7, 30108 }, -- Lightfathom Scepter
{ 8, 30918 }, -- Hammer of Atonement
{ 9, 33468 }, -- Dark Blessing
{ 10, 32964 }, -- Merciless Gladiator's Salvation
{ 11, 28771 }, -- Light's Justice
{ 12, 32451 }, -- Gladiator's Salvation
{ 13, 28522 }, -- Shard of the Virtuous
{ 14, 23556 }, -- Hand of Eternity
{ 15, 29353 }, -- Shockwave Truncheon

},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 30911 }, -- Scepter of Purification
{ 2, 35074 }, -- Brutal Gladiator's Reprieve
{ 3, 34206 }, -- Book of Highborne Hymns
{ 4, 29274 }, -- Tears of Heaven
{ 5, 32350 }, -- Touch of Inspiration
{ 6, 29170 }, -- Windcaller's Orb
{ 7, 33736 }, -- Vengeful Gladiator's Reprieve
{ 8, 29923 }, -- Talisman of the Sun King
{ 9, 33325 }, -- Voodoo Shaker
{ 10, 32961 }, -- Merciless Gladiator's Reprieve
{ 11, 23048 }, -- Sapphiron's Right Eye
{ 12, 27477 }, -- Faol's Signet of Cleansing
{ 13, 28728 }, -- Aran's Soothing Sapphire
{ 14, 23029 }, -- Noth's Frigid Heart
{ 15, 28213 }, -- Lordaeron Medical Guide
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34337 }, -- Golden Staff of the Sin'dorei
{ 2, 30908 }, -- Apostle of Argus
{ 3, 33490 }, -- Staff of Dark Mending
{ 4, 32344 }, -- Staff of Immaculate Recovery
{ 5, 30732 }, -- Exodar Life-Staff
{ 6, 29981 }, -- Ethereum Life-Staff
{ 7, 34608 }, -- Rod of the Blazing Light
{ 8, 28782 }, -- Crystalheart Pulse-Staff
{ 9, 28604 }, -- Nightstaff of the Everliving
{ 10, 22632 }, -- Atiesh, Greatstaff of the Guardian
{ 11, 27791 }, -- Serpentcrest Life-Staff
{ 12, 29133 }, -- Seer's Cane
{ 13, 28033 }, -- Epoch-Mender
{ 14, 31289 }, -- Staff of Divine Infusion
{ 15, 31417 }, -- Staff of the Ashtongue Deathsworn
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
 
},
},




--@end-version-bcc@
},
}

data["DruidBoom"] = {
	name = AL["Druid Boomkin BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34340 }, -- Dark Conjuror's Collar
{ 2, 32525 }, -- Cowl of the Illidari High Lord
{ 3, 34405 }, -- Helm of Arcane Purity
{ 4, 34403 }, -- Cover of Ursoc the Mighty
{ 5, 31040 }, -- Thunderheart Headguard
{ 6, 35182 }, -- Hyper-Magnified Moon Specs
{ 7, 33453 }, -- Hood of Hexing
{ 8, 30233 }, -- Nordrassil Headpiece
{ 9, 29986 }, -- Cowl of the Grand Engineer
{ 10, 35112 }, -- Brutal Gladiator's Wyrmhide Helm
{ 11, 32480 }, -- Magnified Moon Specs
{ 12, 33768 }, -- Vengeful Gladiator's Wyrmhide Helm
{ 13, 24266 }, -- Spellstrike Hood
{ 14, 29093 }, -- Antlers of Malorne
{ 15, 33972 }, -- Mask of Primal Power
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34204 }, -- Amulet of Unfettered Magics
{ 2, 34359 }, -- Pendant of Sunfire
{ 3, 32349 }, -- Translucent Spellthread Necklace
{ 4, 24116 }, -- Eye of the Night (GROUP BUFF)
{ 5, 34360 }, -- Amulet of Flowing Life
{ 6, 33281 }, -- Brooch of Nature's Mercy
{ 7, 37928 }, -- Guardian's Pendant of Subjugation
{ 8, 35290 }, -- Sin'dorei Pendant of Conquest
{ 9, 30015 }, -- The Sun King's Talisman
{ 10, 35132 }, -- Guardian's Pendant of Conquest
{ 11, 33466 }, -- Loop of Cursed Bones
{ 12, 35319 }, -- Vindicator's Pendant of Subjugation
{ 13, 37929 }, -- Guardian's Pendant of Reprieve
{ 14, 35133 }, -- Guardian's Pendant of Dominance
{ 15, 33920 }, -- Vindicator's Pendant of Conquest
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34210 }, -- Amice of the Convoker
{ 2, 34391 }, -- Spaulders of Devastation
{ 3, 31049 }, -- Thunderheart Shoulderpads
{ 4, 34393 }, -- Shoulderpads of Knowledge's Pursuit
{ 5, 33973 }, -- Pauldrons of Tribal Fury
{ 6, 30884 }, -- Hatefury Mantle
{ 7, 32338 }, -- Blood-cursed Shoulderpads
{ 8, 30235 }, -- Nordrassil Wrath-Mantle
{ 9, 30024 }, -- Mantle of the Elven Kings
{ 10, 35114 }, -- Brutal Gladiator's Wyrmhide Spaulders
{ 11, 32587 }, -- Mantle of Nimble Thought
{ 12, 30079 }, -- Illidari Shoulderpads
{ 13, 34607 }, -- Fel-tinged Mantle
{ 14, 29095 }, -- Pauldrons of Malorne
{ 15, 33489 }, -- Mantle of Ill Intent
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34242 }, -- Tattered Cape of Antonidas
{ 2, 32331 }, -- Cloak of the Illidari Council
{ 3, 28766 }, -- Ruby Drape of the Mysticant
{ 4, 32524 }, -- Shroud of the Highborne
{ 5, 34792 }, -- Cloak of the Betrayed
{ 6, 33591 }, -- Shadowcaster's Drape
{ 7, 30735 }, -- Ancient Spellcloak of the Highborne
{ 8, 29992 }, -- Royal Cloak of the Sunstriders
{ 9, 28797 }, -- Brute Cloak of the Ogre-Magi
{ 10, 23050 }, -- Cloak of the Necropolis
{ 11, 31201 }, -- Illidari Cloak of Wrath
{ 12, 35321 }, -- Cloak of Arcane Alacrity
{ 13, 33592 }, -- Cloak of Ancient Rituals
{ 14, 22731 }, -- Cloak of the Devoured
{ 15, 27981 }, -- Sethekk Oracle Cloak
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34364 }, -- Sunfire Robe
{ 2, 34399 }, -- Robes of Ghostly Hatred
{ 3, 34232 }, -- Fel Conquerer Raiments
{ 4, 34398 }, -- Utopian Tunic of Elune
{ 5, 31043 }, -- Thunderheart Vest
{ 6, 30107 }, -- Vestments of the Sea-Witch
{ 7, 30231 }, -- Nordrassil Chestpiece
{ 8, 30913 }, -- Robes of Rhonin
{ 9, 34917 }, -- Shroud of the Lore`nial
{ 10, 35115 }, -- Brutal Gladiator's Wyrmhide Tunic
{ 11, 29091 }, -- Chestpiece of Malorne
{ 12, 33566 }, -- Blessed Elunite Coverings
{ 13, 21848 }, -- Spellfire Robe (Fire/Arcane)
{ 14, 34936 }, -- Tormented Demonsoul Robes
{ 15, 34610 }, -- Scarlet Sin'dorei Robes
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34446 }, -- Thunderheart Bands
{ 2, 32270 }, -- Focused Mana Bindings
{ 3, 32351 }, -- Elunite Empowered Bracers
{ 4, 30870 }, -- Cuffs of Devastation
{ 5, 32586 }, -- Bracers of Nimble Thought
{ 6, 33285 }, -- Fury of the Ursine
{ 7, 30684 }, -- Ravager's Cuffs of Wrath
{ 8, 33578 }, -- Armwraps of the Kaldorei Protector
{ 9, 29523 }, -- Windhawk Bracers
{ 10, 33588 }, -- Runed Spell-cuffs
{ 11, 29918 }, -- Mindstorm Wristbands
{ 12, 35180 }, -- Guardian's Wyrmhide Bracers
{ 13, 32820 }, -- Veteran's Silk Cuffs
{ 14, 32655 }, -- Crystalweave Bracers
{ 15, 31225 }, -- Illidari Bindings of Wrath
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34344 }, -- Handguards of Defiled Worlds
{ 2, 34406 }, -- Gloves of Tyri's Power
{ 3, 34366 }, -- Sunfire Handwraps
{ 4, 34407 }, -- Tranquil Moonlight Wraps
{ 5, 31035 }, -- Thunderheart Handguards
{ 6, 34904 }, -- Barbed Gloves of the Sage
{ 7, 30725 }, -- Anger-Spark Gloves
{ 8, 21847 }, -- Spellfire Gloves (Fire/Arcane)
{ 9, 33586 }, -- Studious Wraps
{ 10, 34808 }, -- Gloves of Arcane Acuity
{ 11, 34938 }, -- Enslaved Doomguard Soulgrips
{ 12, 28507 }, -- Handwraps of Flowing Thought
{ 13, 28780 }, -- Soul-Eater's Handwraps
{ 14, 29987 }, -- Gauntlets of the Sun King
{ 15, 34372 }, -- Leather Gauntlets of the Sun
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34555 }, -- Thunderheart Cord
{ 2, 30038 }, -- Belt of Blasting
{ 3, 30064 }, -- Cord of Screaming Terrors
{ 4, 30888 }, -- Anetheron's Noose
{ 5, 21846 }, -- Spellfire Belt (Fire/Arcane)
{ 6, 32256 }, -- Waistwrap of Infinity
{ 7, 30914 }, -- Belt of the Crescent Moon
{ 8, 33559 }, -- Starfire Waistband
{ 9, 33291 }, -- Voodoo-woven Belt
{ 10, 29524 }, -- Windhawk Belt
{ 11, 24256 }, -- Girdle of Ruination
{ 12, 30675 }, -- Lurker's Cord of the Wrath
{ 13, 28799 }, -- Belt of Divine Inspiration
{ 14, 27843 }, -- Glyph-Lined Sash
{ 15, 29241 }, -- Belt of Depravity
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34362 }, -- Loop of Forged Power
{ 2, 33497 }, -- Mana Attuned Band
{ 3, 34230 }, -- Ring of Omnipotence
{ 4, 32247 }, -- Ring of Captured Storms
{ 5, 34889 }, -- Fused Nethergon Band
{ 6, 29305 }, -- Band of the Eternal Sage
{ 7, 32527 }, -- Ring of Ancient Knowledge
{ 8, 34363 }, -- Ring of Flowing Life
{ 9, 30667 }, -- Ring of Unrelenting Storms (Nature)
{ 10, 32528 }, -- Blessed Band of Karabor
{ 11, 29304 }, -- Band of Eternity (revered)
{ 12, 34166 }, -- Band of Lucent Beams
{ 13, 35282 }, -- Sin'dorei Band of Dominance
{ 14, 33498 }, -- Signet of the Quiet Forest
{ 15, 28793 }, -- Band of Crimson Fury
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34181 }, -- Leggings of Calamity
{ 2, 34386 }, -- Pantaloons of Growing Strife
{ 3, 30916 }, -- Leggings of Channeled Elements
{ 4, 34169 }, -- Breeches of Natural Aggression
{ 5, 32367 }, -- Leggings of Devastation
{ 6, 34918 }, -- Legwraps of Sweltering Flame
{ 7, 31046 }, -- Thunderheart Pants
{ 8, 30734 }, -- Leggings of the Seventh Circle
{ 9, 34905 }, -- Crystalwind Leggings
{ 10, 24262 }, -- Spellstrike Pants
{ 11, 34937 }, -- Corrupted Soulcloth Pantaloons
{ 12, 33971 }, -- Elunite Imbued Leggings
{ 13, 29972 }, -- Trousers of the Astromancer
{ 14, 30234 }, -- Nordrassil Wrath-Kilt
{ 15, 35113 }, -- Brutal Gladiator's Wyrmhide Legguards
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34572 }, -- Thunderheart Footwraps
{ 2, 32239 }, -- Slippers of the Seacaller
{ 3, 34919 }, -- Boots of Incantations
{ 4, 32352 }, -- Naturewarden's Treads
{ 5, 33577 }, -- Moon-walkers
{ 6, 30894 }, -- Blue Suede Shoes
{ 7, 30037 }, -- Boots of Blasting
{ 8, 30680 }, -- Glider's Foot-Wraps of Wrath
{ 9, 33357 }, -- Footpads of Madness
{ 10, 30067 }, -- Velvet Boots of the Guardian
{ 11, 28517 }, -- Boots of Foretelling
{ 12, 28585 }, -- Ruby Slippers
{ 13, 35150 }, -- Guardian's Wyrmhide Boots
{ 14, 30680 }, -- Glider's Foot-Wraps of the Invoker
{ 15, 28406 }, -- Sigil-Laced Boots
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 32483 }, -- The Skull of Gul'dan
{ 2, 34429 }, -- Shifting Naaru Sliver
{ 3, 33829 }, -- Hex Shrunken Head
{ 4, 23207 }, -- Mark of the Champion (undead/demon)
{ 5, 30626 }, -- Sextant of Unstable Currents
{ 6, 31856 }, -- Darkmoon Card: Crusade
{ 7, 28789 }, -- Eye of Magtheridon
{ 8, 34470 }, -- Timbal's Focusing Crystal
{ 9, 27683 }, -- Quagmirran's Eye
{ 10, 29370 }, -- Icon of the Silver Crescent
{ 11, 38290 }, -- Dark Iron Smoking Pipe
{ 12, 29132 }, -- Scryer's Bloodgem
{ 13, 19379 }, -- Neltharion's Tear
{ 14, 23046 }, -- The Restrained Essence of Sapphiron
{ 15, 28223 }, -- Arcanist's Stone
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34336 }, -- Sunflare
{ 2, 34176 }, -- Reign of Misery
{ 3, 35014 }, -- Brutal Gladiator's Gavel
{ 4, 35102 }, -- Brutal Gladiator's Spellblade
{ 5, 33687 }, -- Vengeful Gladiator's Gavel
{ 6, 33763 }, -- Vengeful Gladiator's Spellblade
{ 7, 34009 }, -- Hammer of Judgement
{ 8, 34895 }, -- Scryer's Blade of Focus
{ 9, 32237 }, -- The Maelstrom's Fury
{ 10, 33354 }, -- Wub's Cursed Hexblade
{ 11, 32053 }, -- Merciless Gladiator's Spellblade
{ 12, 32963 }, -- Merciless Gladiator's Gavel
{ 13, 33283 }, -- Amani Punisher
{ 14, 34611 }, -- Cudgel of Consecration
{ 15, 30723 }, -- Talon of the Tempest
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 30872 }, -- Chronicle of Dark Secrets
{ 2, 32361 }, -- Blind-Seers Icon
{ 3, 34179 }, -- Heart of the Pit
{ 4, 33334 }, -- Fetish of the Primal Gods
{ 5, 28734 }, -- Jewel of Infinite Possibilities
{ 6, 30049 }, -- Fathomstone
{ 7, 35008 }, -- Brutal Gladiator's Endgame
{ 8, 29273 }, -- Khadgar's Knapsack
{ 9, 28412 }, -- Lamp of Peaceful Radiance
{ 10, 28603 }, -- Talisman of Nightbane
{ 11, 25099 }, -- Draenei Crystal Rod of Wrath
{ 12, 28781 }, -- Karaborian Talisman
{ 13, 28187 }, -- Star-Heart Lamp
{ 14, 33681 }, -- Vengeful Gladiator's Endgame
 
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34182 }, -- Grand Magister's Staff of Torrents
{ 2, 34987 }, -- Brutal Gladiator's Battle Staff
{ 3, 32374 }, -- Zhar'doom, Greatstaff of the Devourer
{ 4, 34540 }, -- Vengeful Gladiator's Battle Staff
{ 5, 35109 }, -- Brutal Gladiator's War Staff
{ 6, 32055 }, -- Merciless Gladiator's War Staff
{ 7, 33766 }, -- Vengeful Gladiator's War Staff
{ 8, 33494 }, -- Amani Divining Staff
{ 9, 29988 }, -- The Nexus Key
{ 10, 24557 }, -- Gladiator's War Staff
{ 11, 28633 }, -- Staff of Infinite Mysteries
{ 12, 35514 }, -- Frostscythe of Lord Ahune
{ 13, 29355 }, -- Terokk's Shadowstaff
{ 14, 34797 }, -- Sun-infused Focus Staff
{ 15, 32854 }, -- Hammer of Righteous Might

},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
 
},
},




--@end-version-bcc@
},
}

data["DruidFeral"] = {
	name = AL["Druid Feral BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34244 }, -- Duplicitous Guise
{ 2, 32235 }, -- Cursed Vision of Sargeras
{ 3, 34353 }, -- Quad Deathblow X44 Goggles
{ 4, 34999 }, -- Brutal Gladiator's Dragonhide Helm
{ 5, 33479 }, -- Grimgrin Faceguard
{ 6, 33672 }, -- Vengeful Gladiator's Dragonhide Helm
{ 7, 34404 }, -- Mask of the Fury Hunter
{ 8, 32478 }, -- Deathblow X11 Goggles
{ 9, 28732 }, -- Cowl of Defiance
{ 10, 31039 }, -- Thunderheart Cover
{ 11, 31109 }, -- Stealther's Helmet of Second Sight
{ 12, 28796 }, -- Malefic Mask of the Shadows
{ 13, 32087 }, -- Mask of the Deceiver
{ 14, 29502 }, -- Cobrascale Hood
{ 15, 30228 }, -- Nordrassil Headdress
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 32260 }, -- Choker of Endless Nightmares
{ 2, 34358 }, -- Hard Khorium Choker
{ 3, 34177 }, -- Clutch of Demise
{ 4, 24114 }, -- Braided Eternium Chain (GROUP BUFF)
{ 5, 29381 }, -- Choker of Vile Intent
{ 6, 35507 }, -- Amulet of Bitter Hatred
{ 7, 28509 }, -- Worgen Claw Necklace
{ 8, 30017 }, -- Telonicus's Pendant of Mayhem
{ 9, 35292 }, -- Sin'dorei Pendant of Triumph
{ 10, 35135 }, -- Guardian's Pendant of Triumph
{ 11, 32591 }, -- Choker of Serrated Blades
{ 12, 31275 }, -- Necklace of Trophies
{ 13, 29119 }, -- Haramad's Bargain
{ 14, 27779 }, -- Bone Chain Necklace
{ 15, 32508 }, -- Necklace of the Deep
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34392 }, -- Demontooth Shoulderpads
{ 2, 34195 }, -- Shoulderpads of Vehemence
{ 3, 35001 }, -- Brutal Gladiator's Dragonhide Spaulders
{ 4, 31048 }, -- Thunderheart Pauldrons
{ 5, 33674 }, -- Vengeful Gladiator's Dragonhide Spaulders
{ 6, 30055 }, -- Shoulderpads of the Stranger
{ 7, 30230 }, -- Nordrassil Feral-Mantle
{ 8, 34613 }, -- Shoulderpads of the Silvermoon Retainer
{ 9, 27797 }, -- Wastewalker Shoulderpads
{ 10, 32377 }, -- Mantle of Darkness
{ 11, 29100 }, -- Mantle of Malorne
{ 12, 33300 }, -- Shoulderpads of Dancing Blades
{ 13, 30917 }, -- Razorfury Mantle
{ 14, 32581 }, -- Swiftstrike Shoulders
{ 15, 28755 }, -- Bladed Shoulderpads of the Merciless
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34241 }, -- Cloak of Unforgivable Sin
{ 2, 32323 }, -- Shadowmoon Destroyer's Drape
{ 3, 28672 }, -- Drape of the Dark Reavers
{ 4, 29994 }, -- Thalassian Wildercloak
{ 5, 30098 }, -- Razor-Scale Battlecloak
{ 6, 33590 }, -- Cloak of Fiends
{ 7, 31255 }, -- Cloak of the Craft
{ 8, 33484 }, -- Dory's Embrace
{ 9, 33122 }, -- Cloak of Darkness (melee)
{ 10, 27878 }, -- Auchenai Death Shroud
{ 11, 24259 }, -- Vengeance Wrap
{ 12, 30729 }, -- Black-Iron Battlecloak
{ 13, 29382 }, -- Blood Knight War Cloak
{ 14, 35495 }, -- The Frost Lord's War Cloak
{ 15, 27892 }, -- Cloak of the Inciter
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34397 }, -- Bladed Chaos Tunic
{ 2, 34369 }, -- Carapace of Sun and Shadow
{ 3, 34211 }, -- Harness of Carnal Instinct
{ 4, 35002 }, -- Brutal Gladiator's Dragonhide Tunic
{ 5, 32252 }, -- Nether Shadow Tunic
{ 6, 30905 }, -- Midnight Chestguard
{ 7, 33675 }, -- Vengeful Gladiator's Dragonhide Tunic
{ 8, 34927 }, -- Tunic of the Dark Hour
{ 9, 30101 }, -- Bloodsea Brigand's Vest
{ 10, 31042 }, -- Thunderheart Chestguard
{ 11, 33329 }, -- Shadowtooth Trollskin Cuirass
{ 12, 33204 }, -- Shadowprowler's Chestguard
{ 13, 33579 }, -- Vestments of Hibernation
{ 14, 30730 }, -- Terrorweave Tunic
{ 15, 34906 }, -- Embrace of Everlasting Prowess
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34444 }, -- Thunderheart Wristguards
{ 2, 32324 }, -- Insidious Bands
{ 3, 33881 }, -- Vindicator's Dragonhide Bracers
{ 4, 35171 }, -- Guardian's Leather Bracers
{ 5, 30863 }, -- Deadly Cuffs
{ 6, 33540 }, -- Master Assassin Wristwraps
{ 7, 35167 }, -- Guardian's Dragonhide Bracers
{ 8, 33893 }, -- Vindicator's Leather Bracers
{ 9, 29966 }, -- Vambraces of Ending
{ 10, 33580 }, -- Band of the Swift Paw
{ 11, 32580 }, -- Swiftstrike Bracers
{ 12, 30685 }, -- Ravager's Wrist-Wraps of the Tiger
{ 13, 32814 }, -- Veteran's Leather Bracers
{ 14, 32647 }, -- Shard-bound Bracers
{ 15, 28171 }, -- Spymistress's Wristguards
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34370 }, -- Gloves of Immortal Dusk
{ 2, 34234 }, -- Shadowed Gauntlets of Paroxysm
{ 3, 34408 }, -- Gloves of the Forest Drifter
{ 4, 34998 }, -- Brutal Gladiator's Dragonhide Gloves
{ 5, 34911 }, -- Handwraps of the Aggressor
{ 6, 29947 }, -- Gloves of the Searing Grip
{ 7, 31034 }, -- Thunderheart Gauntlets
{ 8, 28506 }, -- Gloves of Dexterous Manipulation
{ 9, 32347 }, -- Grips of Damnation
{ 10, 25969 }, -- Rapscallion's Touch
{ 11, 25685 }, -- Fel Leather Gloves
{ 12, 33671 }, -- Vengeful Gladiator's Dragonhide Gloves
{ 13, 30644 }, -- Grips of Deftness
{ 14, 33539 }, -- Trickster's Stickyfingers
{ 15, 28776 }, -- Liar's Tongue Gloves
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34556 }, -- Thunderheart Waistguard
{ 2, 30106 }, -- Belt of One-Hundred Deaths
{ 3, 30040 }, -- Belt of Deep Shadow
{ 4, 34929 }, -- Belt of the Silent Path
{ 5, 30879 }, -- Don Alejandro's Money Belt
{ 6, 33583 }, -- Waistguard of the Great Beast
{ 7, 33211 }, -- Bladeangel's Money Belt
{ 8, 35152 }, -- Guardian's Dragonhide Belt
{ 9, 35156 }, -- Guardian's Leather Belt
{ 10, 32265 }, -- Shadow-walker's Cord
{ 11, 33879 }, -- Vindicator's Dragonhide Belt
{ 12, 29247 }, -- Girdle of the Deathdealer
{ 13, 30676 }, -- Lurker's Grasp of the Tiger
{ 14, 30042 }, -- Belt of Natural Power
{ 15, 28828 }, -- Gronn-Stitched Girdle
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 32497 }, -- Stormrage Signet Ring
{ 2, 34887 }, -- Angelista's Revenge
{ 3, 34189 }, -- Band of Ruinous Delight
{ 4, 33496 }, -- Signet of Primal Wrath
{ 5, 34361 }, -- Hard Khorium Band
{ 6, 30052 }, -- Ring of Lethality
{ 7, 32266 }, -- Ring of Deceitful Intent
{ 8, 29301 }, -- Band of the Eternal Champion
{ 9, 29997 }, -- Band of the Ranger-General
{ 10, 28649 }, -- Garona's Signet Ring
{ 11, 29300 }, -- Band of Eternity (revered)
{ 12, 28757 }, -- Ring of a Thousand Marks
{ 13, 30738 }, -- Ring of Reciprocity
{ 14, 32335 }, -- Unstoppable Aggressor's Ring
{ 15, 30834 }, -- Shapeshifter's Signet
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34188 }, -- Leggings of the Immortal Night
{ 2, 34385 }, -- Leggings of the Immortal Beast
{ 3, 31044 }, -- Thunderheart Leggings
{ 4, 35000 }, -- Brutal Gladiator's Dragonhide Legguards
{ 5, 28741 }, -- Skulker's Greaves
{ 6, 30898 }, -- Shady Dealer's Pantaloons
{ 7, 34910 }, -- Tameless Breeches
{ 8, 29995 }, -- Leggings of Murderous Intent
{ 9, 30229 }, -- Nordrassil Feral-Kilt
{ 10, 33673 }, -- Vengeful Gladiator's Dragonhide Legguards
{ 11, 34928 }, -- Trousers of the Scryers' Retainer
{ 12, 27837 }, -- Wastewalker Leggings
{ 13, 25687 }, -- Fel Leather Leggings
{ 14, 33538 }, -- Shallow-grave Trousers
{ 15, 30538 }, -- Midnight Legguards
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 33222 }, -- Nyn'jah's Tabi Boots
{ 2, 34573 }, -- Thunderheart Treads
{ 3, 32366 }, -- Shadowmaster's Boots
{ 4, 28545 }, -- Edgewalker Longboots
{ 5, 35137 }, -- Guardian's Dragonhide Boots
{ 6, 34809 }, -- Sunrage Treads
{ 7, 33582 }, -- Footwraps of Wild Encroachment
{ 8, 35141 }, -- Guardian's Leather Boots
{ 9, 25686 }, -- Fel Leather Boots
{ 10, 33880 }, -- Vindicator's Dragonhide Boots
{ 11, 30039 }, -- Boots of Utter Darkness
{ 12, 30681 }, -- Glider's Boots of the Tiger
{ 13, 30041 }, -- Boots of Natural Grace
{ 14, 30891 }, -- Black Featherlight Boots
{ 15, 30060 }, -- Boots of Effortless Striking
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 34472 }, -- Shard of Contempt
{ 2, 32505 }, -- Madness of the Betrayer
{ 3, 28830 }, -- Dragonspine Trophy
{ 4, 34427 }, -- Blackened Naaru Sliver
{ 5, 30627 }, -- Tsunami Talisman
{ 6, 34428 }, -- Steely Naaru Sliver
{ 7, 23206 }, -- Mark of the Champion (undead/demon)
{ 8, 33831 }, -- Berserker's Call
{ 9, 28121 }, -- Icon of Unyielding Courage
{ 10, 35702 }, -- Figurine - Shadowsong Panther
{ 11, 28034 }, -- Hourglass of the Unraveller
{ 12, 19406 }, -- Drake Fang Talisman
{ 13, 31856 }, -- Darkmoon Card: Crusade
{ 14, 29383 }, -- Bloodlust Brooch
{ 15, 28579 }, -- Romulo's Poison Vial
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
 
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
 
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34198 }, -- Stanchion of Primal Instinct (Feral)
{ 2, 35103 }, -- Brutal Gladiator's Staff (Feral)
{ 3, 34898 }, -- Staff of the Forest Lord (Feral)
{ 4, 33716 }, -- Vengeful Gladiator's Staff (Feral)
{ 5, 33465 }, -- Staff of Primal Fury (Feral)
{ 6, 32014 }, -- Merciless Gladiator's Maul (Feral)
{ 7, 30883 }, -- Pillar of Ferocity (Feral)
{ 8, 28658 }, -- Terestian's Stranglestaff (Feral)
{ 9, 28476 }, -- Gladiator's Maul (Feral)
{ 10, 30021 }, -- Wildfury Greatstaff (Feral)
{ 11, 29359 }, -- Feral Staff of Lashing (Feral)
{ 12, 31334 }, -- Staff of Natural Fury (Feral)
{ 13, 29171 }, -- Earthwarden
{ 14, 27877 }, -- Draenic Wildstaff (Feral)
{ 15, 30010 }, -- Fleshling Simulation Staff (Feral)
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
 
},
},




--@end-version-bcc@
},
}





data["DruidBear"] = {
	name = AL["Druid Bear BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34244 }, -- Duplicitous Guise
{ 2, 34404 }, -- Mask of the Fury Hunter
{ 3, 34999 }, -- Brutal Gladiator's Dragonhide Helm
{ 4, 34353 }, -- Quad Deathblow X44 Goggles
{ 5, 31039 }, -- Thunderheart Cover
{ 6, 32235 }, -- Cursed Vision of Sargeras
{ 7, 33672 }, -- Vengeful Gladiator's Dragonhide Helm
{ 8, 30228 }, -- Nordrassil Headdress
{ 9, 33479 }, -- Grimgrin Faceguard
{ 10, 29098 }, -- Stag-Helm of Malorne
{ 11, 32478 }, -- Deathblow X11 Goggles
{ 12, 31968 }, -- Merciless Gladiator's Dragonhide Helm
{ 13, 32087 }, -- Mask of the Deceiver
{ 14, 28127 }, -- Gladiator's Dragonhide Helm
{ 15, 32088 }, -- Cowl of Beastly Rage
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34178 }, -- Collar of the Pit Lord
{ 2, 33296 }, -- Brooch of Deftness
{ 3, 34358 }, -- Hard Khorium Choker
{ 4, 34177 }, -- Clutch of Demise
{ 5, 34680 }, -- Shattered Sun Pendant of Resolve
{ 6, 35135 }, -- Guardian's Pendant of Triumph
{ 7, 30017 }, -- Telonicus's Pendant of Mayhem
{ 8, 32591 }, -- Choker of Serrated Blades
{ 9, 28509 }, -- Worgen Claw Necklace
{ 10, 32362 }, -- Pendant of Titans
{ 11, 33923 }, -- Vindicator's Pendant of Triumph
{ 12, 29381 }, -- Choker of Vile Intent
{ 13, 35507 }, -- Amulet of Bitter Hatred
{ 14, 28674 }, -- Saberclaw Talisman
{ 15, 28745 }, -- Mithril Chain of Heroism
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34392 }, -- Demontooth Shoulderpads
{ 2, 35001 }, -- Brutal Gladiator's Dragonhide Spaulders
{ 3, 34195 }, -- Shoulderpads of Vehemence
{ 4, 31048 }, -- Thunderheart Pauldrons
{ 5, 33674 }, -- Vengeful Gladiator's Dragonhide Spaulders
{ 6, 30230 }, -- Nordrassil Feral-Mantle
{ 7, 30917 }, -- Razorfury Mantle
{ 8, 30055 }, -- Shoulderpads of the Stranger
{ 9, 29100 }, -- Mantle of Malorne
{ 10, 31971 }, -- Merciless Gladiator's Dragonhide Spaulders
{ 11, 32581 }, -- Swiftstrike Shoulders
{ 12, 33300 }, -- Shoulderpads of Dancing Blades
{ 13, 34613 }, -- Shoulderpads of the Silvermoon Retainer
{ 14, 32377 }, -- Mantle of Darkness
{ 15, 28129 }, -- Gladiator's Dragonhide Spaulders
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34190 }, -- Crimson Paragon's Cover
{ 2, 34241 }, -- Cloak of Unforgivable Sin
{ 3, 33593 }, -- Slikk's Cloak of Placation
{ 4, 29994 }, -- Thalassian Wildercloak
{ 5, 34010 }, -- Pepe's Shroud of Pacification
{ 6, 28660 }, -- Gilded Thorium Cloak
{ 7, 28256 }, -- Thoriumweave Cloak
{ 8, 32323 }, -- Shadowmoon Destroyer's Drape
{ 9, 28672 }, -- Drape of the Dark Reavers
{ 10, 34810 }, -- Cloak of Blade Turning
{ 11, 30098 }, -- Razor-Scale Battlecloak
{ 12, 33590 }, -- Cloak of Fiends
{ 13, 33484 }, -- Dory's Embrace
{ 14, 24258 }, -- Resolute Cape
{ 15, 33122 }, -- Cloak of Darkness (melee)
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34211 }, -- Harness of Carnal Instinct
{ 2, 34369 }, -- Carapace of Sun and Shadow
{ 3, 31042 }, -- Thunderheart Chestguard
{ 4, 34397 }, -- Bladed Chaos Tunic
{ 5, 35002 }, -- Brutal Gladiator's Dragonhide Tunic
{ 6, 34906 }, -- Embrace of Everlasting Prowess
{ 7, 30222 }, -- Nordrassil Chestplate
{ 8, 30905 }, -- Midnight Chestguard
{ 9, 32252 }, -- Nether Shadow Tunic
{ 10, 33675 }, -- Vengeful Gladiator's Dragonhide Tunic
{ 11, 34927 }, -- Tunic of the Dark Hour
{ 12, 33579 }, -- Vestments of Hibernation
{ 13, 29096 }, -- Breastplate of Malorne
{ 14, 33329 }, -- Shadowtooth Trollskin Cuirass
{ 15, 31972 }, -- Merciless Gladiator's Dragonhide Tunic
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34444 }, -- Thunderheart Wristguards
{ 2, 33580 }, -- Band of the Swift Paw
{ 3, 35171 }, -- Guardian's Leather Bracers
{ 4, 32324 }, -- Insidious Bands
{ 5, 33881 }, -- Vindicator's Dragonhide Bracers
{ 6, 35167 }, -- Guardian's Dragonhide Bracers
{ 7, 33893 }, -- Vindicator's Leather Bracers
{ 8, 32580 }, -- Swiftstrike Bracers
{ 9, 30863 }, -- Deadly Cuffs
{ 10, 29966 }, -- Vambraces of Ending
{ 11, 33540 }, -- Master Assassin Wristwraps
{ 12, 32810 }, -- Veteran's Dragonhide Bracers
{ 13, 32814 }, -- Veteran's Leather Bracers
{ 14, 29263 }, -- Forestheart Bracers
{ 15, 28445 }, -- General's Dragonhide Bracers
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34408 }, -- Gloves of the Forest Drifter
{ 2, 34370 }, -- Gloves of Immortal Dusk
{ 3, 31034 }, -- Thunderheart Gauntlets
{ 4, 34234 }, -- Shadowed Gauntlets of Paroxysm
{ 5, 34911 }, -- Handwraps of the Aggressor
{ 6, 34998 }, -- Brutal Gladiator's Dragonhide Gloves
{ 7, 30223 }, -- Nordrassil Handgrips
{ 8, 29947 }, -- Gloves of the Searing Grip
{ 9, 33671 }, -- Vengeful Gladiator's Dragonhide Gloves
{ 10, 32347 }, -- Grips of Damnation
{ 11, 29097 }, -- Gauntlets of Malorne
{ 12, 30644 }, -- Grips of Deftness
{ 13, 31967 }, -- Merciless Gladiator's Dragonhide Gloves
{ 14, 33539 }, -- Trickster's Stickyfingers
{ 15, 28506 }, -- Gloves of Dexterous Manipulation
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34556 }, -- Thunderheart Waistguard
{ 2, 30106 }, -- Belt of One-Hundred Deaths
{ 3, 33583 }, -- Waistguard of the Great Beast
{ 4, 35152 }, -- Guardian's Dragonhide Belt
{ 5, 35156 }, -- Guardian's Leather Belt
{ 6, 34929 }, -- Belt of the Silent Path
{ 7, 30042 }, -- Belt of Natural Power
{ 8, 30879 }, -- Don Alejandro's Money Belt
{ 9, 33879 }, -- Vindicator's Dragonhide Belt
{ 10, 33891 }, -- Vindicator's Leather Belt
{ 11, 30040 }, -- Belt of Deep Shadow
{ 12, 32265 }, -- Shadow-walker's Cord
{ 13, 33211 }, -- Bladeangel's Money Belt
{ 14, 29264 }, -- Tree-Mender's Belt
{ 15, 32802 }, -- Veteran's Leather Belt
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34361 }, -- Hard Khorium Band
{ 2, 34213 }, -- Ring of Hardened Resolve
{ 3, 29301 }, -- Band of the Eternal Champion
{ 4, 32266 }, -- Ring of Deceitful Intent
{ 5, 29300 }, -- Band of Eternity (revered)
{ 6, 32497 }, -- Stormrage Signet Ring
{ 7, 33496 }, -- Signet of Primal Wrath
{ 8, 34887 }, -- Angelista's Revenge
{ 9, 29299 }, -- Band of Eternity (honored)
{ 10, 30834 }, -- Shapeshifter's Signet
{ 11, 34189 }, -- Band of Ruinous Delight
{ 12, 29298 }, -- Band of Eternity (friendly)
{ 13, 30052 }, -- Ring of Lethality
{ 14, 32526 }, -- Band of Devastation
{ 15, 28649 }, -- Garona's Signet Ring
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34385 }, -- Leggings of the Immortal Beast
{ 2, 31044 }, -- Thunderheart Leggings
{ 3, 34188 }, -- Leggings of the Immortal Night
{ 4, 34910 }, -- Tameless Breeches
{ 5, 30229 }, -- Nordrassil Feral-Kilt
{ 6, 35000 }, -- Brutal Gladiator's Dragonhide Legguards
{ 7, 30898 }, -- Shady Dealer's Pantaloons
{ 8, 33673 }, -- Vengeful Gladiator's Dragonhide Legguards
{ 9, 29099 }, -- Greaves of Malorne
{ 10, 34928 }, -- Trousers of the Scryers' Retainer
{ 11, 33538 }, -- Shallow-grave Trousers
{ 12, 28741 }, -- Skulker's Greaves
{ 13, 29995 }, -- Leggings of Murderous Intent
{ 14, 30535 }, -- Forestwalker Kilt
{ 15, 31969 }, -- Merciless Gladiator's Dragonhide Legguards
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34573 }, -- Thunderheart Treads
{ 2, 32593 }, -- Treads of the Den Mother
{ 3, 35137 }, -- Guardian's Dragonhide Boots
{ 4, 35141 }, -- Guardian's Leather Boots
{ 5, 30041 }, -- Boots of Natural Grace
{ 6, 32366 }, -- Shadowmaster's Boots
{ 7, 33582 }, -- Footwraps of Wild Encroachment
{ 8, 33880 }, -- Vindicator's Dragonhide Boots
{ 9, 33222 }, -- Nyn'jah's Tabi Boots
{ 10, 33892 }, -- Vindicator's Leather Boots
{ 11, 30060 }, -- Boots of Effortless Striking
{ 12, 30674 }, -- Zierhut's Lost Treads
{ 13, 30891 }, -- Black Featherlight Boots
{ 14, 28545 }, -- Edgewalker Longboots
{ 15, 32790 }, -- Veteran's Leather Boots
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 34472 }, -- Shard of Contempt
{ 2, 34428 }, -- Steely Naaru Sliver
{ 3, 32658 }, -- Badge of Tenacity
{ 4, 28830 }, -- Dragonspine Trophy
{ 5, 34427 }, -- Blackened Naaru Sliver
{ 6, 33830 }, -- Ancient Aqir Artifact
{ 7, 32505 }, -- Madness of the Betrayer
{ 8, 34473 }, -- Commendation of Kael'thas
{ 9, 30627 }, -- Tsunami Talisman
{ 10, 23206 }, -- Mark of the Champion (undead/demon)
{ 11, 33831 }, -- Berserker's Call
{ 12, 31858 }, -- Darkmoon Card: Vengeance
{ 13, 31859 }, -- Darkmoon Card: Madness
{ 14, 35700 }, -- Figurine - Crimson Serpent
{ 15, 35702 }, -- Figurine - Shadowsong Panther
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
 
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
 
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34198 }, -- Stanchion of Primal Instinct (Feral)
{ 2, 35103 }, -- Brutal Gladiator's Staff (Feral)
{ 3, 34898 }, -- Staff of the Forest Lord (Feral)
{ 4, 33716 }, -- Vengeful Gladiator's Staff (Feral)
{ 5, 30883 }, -- Pillar of Ferocity (Feral)
{ 6, 33465 }, -- Staff of Primal Fury (Feral)
{ 7, 32014 }, -- Merciless Gladiator's Maul (Feral)
{ 8, 30021 }, -- Wildfury Greatstaff (Feral)
{ 9, 28658 }, -- Terestian's Stranglestaff (Feral)
{ 10, 28476 }, -- Gladiator's Maul (Feral)
{ 11, 29359 }, -- Feral Staff of Lashing (Feral)
{ 12, 29171 }, -- Earthwarden
{ 13, 34989 }, -- Brutal Gladiator's Bonegrinder
{ 14, 31334 }, -- Staff of Natural Fury (Feral)
{ 15, 33663 }, -- Vengeful Gladiator's Bonegrinder
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
 
},
},




--@end-version-bcc@
},
}

data["MageArc"] = {
	name = AL["Mage Arcane BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34340 }, -- Dark Conjuror's Collar
{ 2, 34405 }, -- Helm of Arcane Purity
{ 3, 34847 }, -- Annihilator Holo-Gogs
{ 4, 31056 }, -- Cowl of the Tempest
{ 5, 32525 }, -- Cowl of the Illidari High Lord
{ 6, 30206 }, -- Cowl of Tirisfal
{ 7, 34339 }, -- Cowl of Light's Purity
{ 8, 32494 }, -- Destruction Holo-gogs
{ 9, 35097 }, -- Brutal Gladiator's Silk Cowl
{ 10, 29076 }, -- Collar of the Aldor
{ 11, 33453 }, -- Hood of Hexing
{ 12, 33758 }, -- Vengeful Gladiator's Silk Cowl
{ 13, 32048 }, -- Merciless Gladiator's Silk Cowl
{ 14, 29986 }, -- Cowl of the Grand Engineer
{ 15, 28278 }, -- Incanter's Cowl
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34359 }, -- Pendant of Sunfire
{ 2, 34204 }, -- Amulet of Unfettered Magics
{ 3, 33281 }, -- Brooch of Nature's Mercy
{ 4, 37928 }, -- Guardian's Pendant of Subjugation
{ 5, 33466 }, -- Loop of Cursed Bones
{ 6, 34360 }, -- Amulet of Flowing Life
{ 7, 37929 }, -- Guardian's Pendant of Reprieve
{ 8, 35319 }, -- Vindicator's Pendant of Subjugation
{ 9, 35317 }, -- Vindicator's Pendant of Reprieve
{ 10, 34184 }, -- Brooch of the Highborne
{ 11, 35290 }, -- Sin'dorei Pendant of Conquest
{ 12, 35132 }, -- Guardian's Pendant of Conquest
{ 13, 30015 }, -- The Sun King's Talisman
{ 14, 35133 }, -- Guardian's Pendant of Dominance
{ 15, 24121 }, -- Chain of the Twilight Owl (GROUP BUFF)
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34210 }, -- Amice of the Convoker
{ 2, 32587 }, -- Mantle of Nimble Thought
{ 3, 34393 }, -- Shoulderpads of Knowledge's Pursuit
{ 4, 33489 }, -- Mantle of Ill Intent
{ 5, 31059 }, -- Mantle of the Tempest
{ 6, 34202 }, -- Shawl of Wonderment
{ 7, 30884 }, -- Hatefury Mantle
{ 8, 30210 }, -- Mantle of Tirisfal
{ 9, 35096 }, -- Brutal Gladiator's Silk Amice
{ 10, 32338 }, -- Blood-cursed Shoulderpads
{ 11, 30079 }, -- Illidari Shoulderpads
{ 12, 29079 }, -- Pauldrons of the Aldor
{ 13, 34607 }, -- Fel-tinged Mantle
{ 14, 30024 }, -- Mantle of the Elven Kings
{ 15, 33757 }, -- Vengeful Gladiator's Silk Amice
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34242 }, -- Tattered Cape of Antonidas
{ 2, 32524 }, -- Shroud of the Highborne
{ 3, 33591 }, -- Shadowcaster's Drape
{ 4, 33592 }, -- Cloak of Ancient Rituals
{ 5, 32331 }, -- Cloak of the Illidari Council
{ 6, 35321 }, -- Cloak of Arcane Alacrity
{ 7, 29992 }, -- Royal Cloak of the Sunstriders
{ 8, 28797 }, -- Brute Cloak of the Ogre-Magi
{ 9, 30735 }, -- Ancient Spellcloak of the Highborne
{ 10, 35324 }, -- Cloak of Swift Reprieve
{ 11, 34702 }, -- Cloak of Swift Mending
{ 12, 28766 }, -- Ruby Drape of the Mysticant
{ 13, 28570 }, -- Shadow-Cloak of Dalaran
{ 14, 25777 }, -- Ogre Slayer's Cover
{ 15, 33304 }, -- Cloak of Subjugated Power
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34364 }, -- Sunfire Robe
{ 2, 34399 }, -- Robes of Ghostly Hatred
{ 3, 34232 }, -- Fel Conquerer Raiments
{ 4, 31057 }, -- Robes of the Tempest
{ 5, 33317 }, -- Robe of Departed Spirits
{ 6, 30107 }, -- Vestments of the Sea-Witch
{ 7, 34233 }, -- Robes of Faltered Light
{ 8, 30196 }, -- Robes of Tirisfal
{ 9, 30913 }, -- Robes of Rhonin
{ 10, 34365 }, -- Robe of Eternal Light
{ 11, 34936 }, -- Tormented Demonsoul Robes
{ 12, 32327 }, -- Robe of the Shadow Council
{ 13, 30056 }, -- Robe of Hateful Echoes
{ 14, 34917 }, -- Shroud of the Lore`nial
{ 15, 34610 }, -- Scarlet Sin'dorei Robes
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34447 }, -- Bracers of the Tempest
{ 2, 32586 }, -- Bracers of Nimble Thought
{ 3, 33588 }, -- Runed Spell-cuffs
{ 4, 30870 }, -- Cuffs of Devastation
{ 5, 35179 }, -- Guardian's Silk Cuffs
{ 6, 33285 }, -- Fury of the Ursine
{ 7, 34697 }, -- Bindings of Raging Fire
{ 8, 32584 }, -- Swiftheal Wraps
{ 9, 33913 }, -- Vindicator's Silk Cuffs
{ 10, 35168 }, -- Guardian's Dreadweave Cuffs
{ 11, 32270 }, -- Focused Mana Bindings
{ 12, 29918 }, -- Mindstorm Wristbands
{ 13, 30684 }, -- Ravager's Cuffs of the Invoker
{ 14, 32820 }, -- Veteran's Silk Cuffs
{ 15, 33883 }, -- Vindicator's Dreadweave Cuffs
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34406 }, -- Gloves of Tyri's Power
{ 2, 34344 }, -- Handguards of Defiled Worlds
{ 3, 34366 }, -- Sunfire Handwraps
{ 4, 34342 }, -- Handguards of the Dawn
{ 5, 31055 }, -- Gloves of the Tempest
{ 6, 34938 }, -- Enslaved Doomguard Soulgrips
{ 7, 33586 }, -- Studious Wraps
{ 8, 29987 }, -- Gauntlets of the Sun King
{ 9, 21847 }, -- Spellfire Gloves (Fire/Arcane)
{ 10, 28780 }, -- Soul-Eater's Handwraps
{ 11, 30205 }, -- Gloves of Tirisfal
{ 12, 28507 }, -- Handwraps of Flowing Thought
{ 13, 29080 }, -- Gloves of the Aldor
{ 14, 34808 }, -- Gloves of Arcane Acuity
{ 15, 35098 }, -- Brutal Gladiator's Silk Handguards
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34557 }, -- Belt of the Tempest
{ 2, 32256 }, -- Waistwrap of Infinity
{ 3, 30888 }, -- Anetheron's Noose
{ 4, 21846 }, -- Spellfire Belt (Fire/Arcane)
{ 5, 30038 }, -- Belt of Blasting
{ 6, 30064 }, -- Cord of Screaming Terrors
{ 7, 30895 }, -- Angelista's Sash
{ 8, 35164 }, -- Guardian's Silk Belt
{ 9, 28799 }, -- Belt of Divine Inspiration
{ 10, 33291 }, -- Voodoo-woven Belt
{ 11, 24256 }, -- Girdle of Ruination
{ 12, 35153 }, -- Guardian's Dreadweave Belt
{ 13, 33912 }, -- Vindicator's Silk Belt
{ 14, 30675 }, -- Lurker's Cord of Invoker
{ 15, 27843 }, -- Glyph-Lined Sash
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34362 }, -- Loop of Forged Power
{ 2, 34230 }, -- Ring of Omnipotence
{ 3, 32527 }, -- Ring of Ancient Knowledge
{ 4, 33497 }, -- Mana Attuned Band
{ 5, 34363 }, -- Ring of Flowing Life
{ 6, 32528 }, -- Blessed Band of Karabor
{ 7, 33498 }, -- Signet of the Quiet Forest
{ 8, 34166 }, -- Band of Lucent Beams
{ 9, 29305 }, -- Band of the Eternal Sage
{ 10, 37927 }, -- Guardian's Band of Subjugation
{ 11, 35320 }, -- Vindicator's Band of Subjugation
{ 12, 29304 }, -- Band of Eternity (revered)
{ 13, 35129 }, -- Guardian's Band of Dominance
{ 14, 29303 }, -- Band of Eternity (honored)
{ 15, 32247 }, -- Ring of Captured Storms
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34386 }, -- Pantaloons of Growing Strife
{ 2, 34181 }, -- Leggings of Calamity
{ 3, 33584 }, -- Pantaloons of Arcane Annihilation
{ 4, 30916 }, -- Leggings of Channeled Elements
{ 5, 31058 }, -- Leggings of the Tempest
{ 6, 32367 }, -- Leggings of Devastation
{ 7, 34937 }, -- Corrupted Soulcloth Pantaloons
{ 8, 34918 }, -- Legwraps of Sweltering Flame
{ 9, 30207 }, -- Leggings of Tirisfal
{ 10, 29972 }, -- Trousers of the Astromancer
{ 11, 30734 }, -- Leggings of the Seventh Circle
{ 12, 35100 }, -- Brutal Gladiator's Silk Trousers
{ 13, 28594 }, -- Trial-Fire Trousers
{ 14, 33585 }, -- Achromic Trousers of the Naaru
{ 15, 24262 }, -- Spellstrike Pants
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34574 }, -- Boots of the Tempest
{ 2, 33357 }, -- Footpads of Madness
{ 3, 32239 }, -- Slippers of the Seacaller
{ 4, 34919 }, -- Boots of Incantations
{ 5, 35149 }, -- Guardian's Silk Footguards
{ 6, 30894 }, -- Blue Suede Shoes
{ 7, 30067 }, -- Velvet Boots of the Guardian
{ 8, 30037 }, -- Boots of Blasting
{ 9, 28517 }, -- Boots of Foretelling
{ 10, 35138 }, -- Guardian's Dreadweave Stalkers
{ 11, 33914 }, -- Vindicator's Silk Footguards
{ 12, 30680 }, -- Glider's Foot-Wraps of the Invoker
{ 13, 32795 }, -- Veteran's Silk Footguards
{ 14, 30680 }, -- Glider's Foot-Wraps of Wrath
{ 15, 33884 }, -- Vindicator's Dreadweave Stalkers
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 34429 }, -- Shifting Naaru Sliver
{ 2, 32483 }, -- The Skull of Gul'dan
{ 3, 27683 }, -- Quagmirran's Eye
{ 4, 33829 }, -- Hex Shrunken Head
{ 5, 30626 }, -- Sextant of Unstable Currents
{ 6, 23207 }, -- Mark of the Champion (undead/demon)
{ 7, 31856 }, -- Darkmoon Card: Crusade
{ 8, 35326 }, -- Battlemaster's Alacrity
{ 9, 35327 }, -- Battlemaster's Alacrity
{ 10, 28789 }, -- Eye of Magtheridon
{ 11, 34470 }, -- Timbal's Focusing Crystal
{ 12, 29370 }, -- Icon of the Silver Crescent
{ 13, 38290 }, -- Dark Iron Smoking Pipe
{ 14, 23046 }, -- The Restrained Essence of Sapphiron
{ 15, 28418 }, -- Shiffar's Nexus-Horn
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34336 }, -- Sunflare
{ 2, 30910 }, -- Tempest of Chaos
{ 3, 35102 }, -- Brutal Gladiator's Spellblade
{ 4, 33467 }, -- Blade of Twisted Visions
{ 5, 34895 }, -- Scryer's Blade of Focus
{ 6, 33763 }, -- Vengeful Gladiator's Spellblade
{ 7, 32237 }, -- The Maelstrom's Fury
{ 8, 33354 }, -- Wub's Cursed Hexblade
{ 9, 30095 }, -- Fang of the Leviathan
{ 10, 32053 }, -- Merciless Gladiator's Spellblade
{ 11, 30723 }, -- Talon of the Tempest
{ 12, 34604 }, -- Jaded Crystal Dagger
{ 13, 28770 }, -- Nathrezim Mindblade
{ 14, 28802 }, -- Bloodmaw Magus-Blade
{ 15, 28297 }, -- Gladiator's Spellblade
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34179 }, -- Heart of the Pit
{ 2, 33334 }, -- Fetish of the Primal Gods
{ 3, 30872 }, -- Chronicle of Dark Secrets
{ 4, 32361 }, -- Blind-Seers Icon
{ 5, 35008 }, -- Brutal Gladiator's Endgame
{ 6, 29271 }, -- Talisman of Kalecgos (Arcane)
{ 7, 30049 }, -- Fathomstone
{ 8, 34206 }, -- Book of Highborne Hymns
{ 9, 28603 }, -- Talisman of Nightbane
{ 10, 28781 }, -- Karaborian Talisman
{ 11, 33681 }, -- Vengeful Gladiator's Endgame
{ 12, 31978 }, -- Merciless Gladiator's Endgame
{ 13, 29330 }, -- The Saga of Terokk
{ 14, 28734 }, -- Jewel of Infinite Possibilities
{ 15, 32651 }, -- Crystal Orb of Enlightenment
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 32374 }, -- Zhar'doom, Greatstaff of the Devourer
{ 2, 34182 }, -- Grand Magister's Staff of Torrents
{ 3, 34987 }, -- Brutal Gladiator's Battle Staff
{ 4, 35109 }, -- Brutal Gladiator's War Staff
{ 5, 34540 }, -- Vengeful Gladiator's Battle Staff
{ 6, 33766 }, -- Vengeful Gladiator's War Staff
{ 7, 29988 }, -- The Nexus Key
{ 8, 33494 }, -- Amani Divining Staff
{ 9, 32055 }, -- Merciless Gladiator's War Staff
{ 10, 24557 }, -- Gladiator's War Staff
{ 11, 28633 }, -- Staff of Infinite Mysteries
{ 12, 29355 }, -- Terokk's Shadowstaff
{ 13, 22589 }, -- Atiesh, Greatstaff of the Guardian
{ 14, 29130 }, -- Auchenai Staff
{ 15, 34797 }, -- Sun-infused Focus Staff
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
{ 1, 34347 }, -- Wand of the Demonsoul
{ 2, 33192 }, -- Carved Witch Doctor's Stick
{ 3, 34348 }, -- Wand of Cleansing Light
{ 4, 28783 }, -- Eredar Wand of Obliteration
{ 5, 29982 }, -- Wand of the Forgotten Star
{ 6, 35107 }, -- Brutal Gladiator's Touch of Defeat
{ 7, 33764 }, -- Vengeful Gladiator's Touch of Defeat
{ 8, 32343 }, -- Wand of Prismatic Focus
{ 9, 32962 }, -- Merciless Gladiator's Touch of Defeat
{ 10, 28673 }, -- Tirisfal Wand of Ascendancy
{ 11, 30859 }, -- Wand of the Seer
{ 12, 25806 }, -- Nethekurse's Rod of Torment
{ 13, 25808 }, -- Rod of Dire Shadows
{ 14, 29350 }, -- The Black Stalk
{ 15, 28386 }, -- Nether Core's Control Rod
},
},




--@end-version-bcc@
},
}





data["Mage Fire"] = {
	name = AL["Mage Fire BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34340 }, -- Dark Conjuror's Collar
{ 2, 32525 }, -- Cowl of the Illidari High Lord
{ 3, 33453 }, -- Hood of Hexing
{ 4, 34847 }, -- Annihilator Holo-Gogs
{ 5, 29986 }, -- Cowl of the Grand Engineer
{ 6, 31056 }, -- Cowl of the Tempest
{ 7, 34405 }, -- Helm of Arcane Purity
{ 8, 24266 }, -- Spellstrike Hood
{ 9, 32494 }, -- Destruction Holo-gogs
{ 10, 35097 }, -- Brutal Gladiator's Silk Cowl
{ 11, 30206 }, -- Cowl of Tirisfal
{ 12, 28744 }, -- Uni-Mind Headdress
{ 13, 29076 }, -- Collar of the Aldor
{ 14, 33758 }, -- Vengeful Gladiator's Silk Cowl
{ 15, 31104 }, -- Evoker's Helmet of Second Sight
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34359 }, -- Pendant of Sunfire
{ 2, 34204 }, -- Amulet of Unfettered Magics
{ 3, 32349 }, -- Translucent Spellthread Necklace
{ 4, 32589 }, -- Hellfire-Encased Pendant (Fire)
{ 5, 24116 }, -- Eye of the Night (GROUP BUFF)
{ 6, 37928 }, -- Guardian's Pendant of Subjugation
{ 7, 35290 }, -- Sin'dorei Pendant of Conquest
{ 8, 30015 }, -- The Sun King's Talisman
{ 9, 35132 }, -- Guardian's Pendant of Conquest
{ 10, 33281 }, -- Brooch of Nature's Mercy
{ 11, 33466 }, -- Loop of Cursed Bones
{ 12, 34360 }, -- Amulet of Flowing Life
{ 13, 24121 }, -- Chain of the Twilight Owl (GROUP BUFF)
{ 14, 37929 }, -- Guardian's Pendant of Reprieve
{ 15, 35319 }, -- Vindicator's Pendant of Subjugation
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34210 }, -- Amice of the Convoker
{ 2, 34393 }, -- Shoulderpads of Knowledge's Pursuit
{ 3, 30884 }, -- Hatefury Mantle
{ 4, 32338 }, -- Blood-cursed Shoulderpads
{ 5, 31059 }, -- Mantle of the Tempest
{ 6, 35096 }, -- Brutal Gladiator's Silk Amice
{ 7, 32587 }, -- Mantle of Nimble Thought
{ 8, 30024 }, -- Mantle of the Elven Kings
{ 9, 30210 }, -- Mantle of Tirisfal
{ 10, 30079 }, -- Illidari Shoulderpads
{ 11, 34607 }, -- Fel-tinged Mantle
{ 12, 33757 }, -- Vengeful Gladiator's Silk Amice
{ 13, 33489 }, -- Mantle of Ill Intent
{ 14, 32047 }, -- Merciless Gladiator's Silk Amice
{ 15, 34788 }, -- Duskhallow Mantle
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34242 }, -- Tattered Cape of Antonidas
{ 2, 32331 }, -- Cloak of the Illidari Council
{ 3, 32524 }, -- Shroud of the Highborne
{ 4, 28766 }, -- Ruby Drape of the Mysticant
{ 5, 33591 }, -- Shadowcaster's Drape
{ 6, 30735 }, -- Ancient Spellcloak of the Highborne
{ 7, 34792 }, -- Cloak of the Betrayed
{ 8, 28797 }, -- Brute Cloak of the Ogre-Magi
{ 9, 29992 }, -- Royal Cloak of the Sunstriders
{ 10, 23050 }, -- Cloak of the Necropolis
{ 11, 33592 }, -- Cloak of Ancient Rituals
{ 12, 35321 }, -- Cloak of Arcane Alacrity
{ 13, 31201 }, -- Illidari Cloak of Wrath
{ 14, 33304 }, -- Cloak of Subjugated Power
{ 15, 29369 }, -- Shawl of Shifting Probabilities
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34364 }, -- Sunfire Robe
{ 2, 34232 }, -- Fel Conquerer Raiments
{ 3, 34399 }, -- Robes of Ghostly Hatred
{ 4, 30107 }, -- Vestments of the Sea-Witch
{ 5, 30913 }, -- Robes of Rhonin
{ 6, 31057 }, -- Robes of the Tempest
{ 7, 34936 }, -- Tormented Demonsoul Robes
{ 8, 21848 }, -- Spellfire Robe (Fire/Arcane)
{ 9, 34610 }, -- Scarlet Sin'dorei Robes
{ 10, 34917 }, -- Shroud of the Lore`nial
{ 11, 35099 }, -- Brutal Gladiator's Silk Raiment
{ 12, 30056 }, -- Robe of Hateful Echoes
{ 13, 30196 }, -- Robes of Tirisfal
{ 14, 32327 }, -- Robe of the Shadow Council
{ 15, 33760 }, -- Vengeful Gladiator's Silk Raiment
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34447 }, -- Bracers of the Tempest
{ 2, 32270 }, -- Focused Mana Bindings
{ 3, 32586 }, -- Bracers of Nimble Thought
{ 4, 35179 }, -- Guardian's Silk Cuffs
{ 5, 30870 }, -- Cuffs of Devastation
{ 6, 33285 }, -- Fury of the Ursine
{ 7, 33913 }, -- Vindicator's Silk Cuffs
{ 8, 33588 }, -- Runed Spell-cuffs
{ 9, 29918 }, -- Mindstorm Wristbands
{ 10, 30684 }, -- Ravager's Cuffs of Wrath
{ 11, 35168 }, -- Guardian's Dreadweave Cuffs
{ 12, 34697 }, -- Bindings of Raging Fire
{ 13, 32820 }, -- Veteran's Silk Cuffs
{ 14, 30684 }, -- Ravager's Cuffs of the Invoker
{ 15, 32655 }, -- Crystalweave Bracers
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34344 }, -- Handguards of Defiled Worlds
{ 2, 34366 }, -- Sunfire Handwraps
{ 3, 34406 }, -- Gloves of Tyri's Power
{ 4, 31055 }, -- Gloves of the Tempest
{ 5, 30725 }, -- Anger-Spark Gloves
{ 6, 21847 }, -- Spellfire Gloves (Fire/Arcane)
{ 7, 34938 }, -- Enslaved Doomguard Soulgrips
{ 8, 33586 }, -- Studious Wraps
{ 9, 34808 }, -- Gloves of Arcane Acuity
{ 10, 28780 }, -- Soul-Eater's Handwraps
{ 11, 28507 }, -- Handwraps of Flowing Thought
{ 12, 29080 }, -- Gloves of the Aldor
{ 13, 29987 }, -- Gauntlets of the Sun King
{ 14, 35098 }, -- Brutal Gladiator's Silk Handguards
{ 15, 30205 }, -- Gloves of Tirisfal
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34557 }, -- Belt of the Tempest
{ 2, 30038 }, -- Belt of Blasting
{ 3, 30064 }, -- Cord of Screaming Terrors
{ 4, 30888 }, -- Anetheron's Noose
{ 5, 33291 }, -- Voodoo-woven Belt
{ 6, 21846 }, -- Spellfire Belt (Fire/Arcane)
{ 7, 32256 }, -- Waistwrap of Infinity
{ 8, 30020 }, -- Fire-Cord of the Magus (Fire)
{ 9, 30673 }, -- Inferno Waist Cord (Fire)
{ 10, 24256 }, -- Girdle of Ruination
{ 11, 35164 }, -- Guardian's Silk Belt
{ 12, 30675 }, -- Lurker's Cord of the Wrath
{ 13, 28799 }, -- Belt of Divine Inspiration
{ 14, 27843 }, -- Glyph-Lined Sash
{ 15, 33912 }, -- Vindicator's Silk Belt
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34362 }, -- Loop of Forged Power
{ 2, 34230 }, -- Ring of Omnipotence
{ 3, 33497 }, -- Mana Attuned Band
{ 4, 32247 }, -- Ring of Captured Storms
{ 5, 29305 }, -- Band of the Eternal Sage
{ 6, 34889 }, -- Fused Nethergon Band
{ 7, 32527 }, -- Ring of Ancient Knowledge
{ 8, 29304 }, -- Band of Eternity (revered)
{ 9, 35282 }, -- Sin'dorei Band of Dominance
{ 10, 34363 }, -- Ring of Flowing Life
{ 11, 32528 }, -- Blessed Band of Karabor
{ 12, 29303 }, -- Band of Eternity (honored)
{ 13, 28793 }, -- Band of Crimson Fury
{ 14, 34166 }, -- Band of Lucent Beams
{ 15, 33498 }, -- Signet of the Quiet Forest
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34181 }, -- Leggings of Calamity
{ 2, 34386 }, -- Pantaloons of Growing Strife
{ 3, 30916 }, -- Leggings of Channeled Elements
{ 4, 32367 }, -- Leggings of Devastation
{ 5, 31058 }, -- Leggings of the Tempest
{ 6, 30734 }, -- Leggings of the Seventh Circle
{ 7, 24262 }, -- Spellstrike Pants
{ 8, 34937 }, -- Corrupted Soulcloth Pantaloons
{ 9, 34918 }, -- Legwraps of Sweltering Flame
{ 10, 30207 }, -- Leggings of Tirisfal
{ 11, 33584 }, -- Pantaloons of Arcane Annihilation
{ 12, 35100 }, -- Brutal Gladiator's Silk Trousers
{ 13, 29972 }, -- Trousers of the Astromancer
{ 14, 28594 }, -- Trial-Fire Trousers
{ 15, 30531 }, -- Breeches of the Occultist
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34574 }, -- Boots of the Tempest
{ 2, 32239 }, -- Slippers of the Seacaller
{ 3, 30894 }, -- Blue Suede Shoes
{ 4, 30037 }, -- Boots of Blasting
{ 5, 34919 }, -- Boots of Incantations
{ 6, 33357 }, -- Footpads of Madness
{ 7, 35149 }, -- Guardian's Silk Footguards
{ 8, 30680 }, -- Glider's Foot-Wraps of Wrath
{ 9, 30067 }, -- Velvet Boots of the Guardian
{ 10, 28517 }, -- Boots of Foretelling
{ 11, 33914 }, -- Vindicator's Silk Footguards
{ 12, 30680 }, -- Glider's Foot-Wraps of the Invoker
{ 13, 28585 }, -- Ruby Slippers
{ 14, 28406 }, -- Sigil-Laced Boots
{ 15, 32795 }, -- Veteran's Silk Footguards
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 32483 }, -- The Skull of Gul'dan
{ 2, 34429 }, -- Shifting Naaru Sliver
{ 3, 30626 }, -- Sextant of Unstable Currents
{ 4, 33829 }, -- Hex Shrunken Head
{ 5, 23207 }, -- Mark of the Champion (undead/demon)
{ 6, 31856 }, -- Darkmoon Card: Crusade
{ 7, 27683 }, -- Quagmirran's Eye
{ 8, 28789 }, -- Eye of Magtheridon
{ 9, 34470 }, -- Timbal's Focusing Crystal
{ 10, 29370 }, -- Icon of the Silver Crescent
{ 11, 38290 }, -- Dark Iron Smoking Pipe
{ 12, 30720 }, -- Serpent-Coil Braid
{ 13, 29132 }, -- Scryer's Bloodgem
{ 14, 28418 }, -- Shiffar's Nexus-Horn
{ 15, 19379 }, -- Neltharion's Tear
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34336 }, -- Sunflare
{ 2, 30910 }, -- Tempest of Chaos
{ 3, 35102 }, -- Brutal Gladiator's Spellblade
{ 4, 33763 }, -- Vengeful Gladiator's Spellblade
{ 5, 32237 }, -- The Maelstrom's Fury
{ 6, 34895 }, -- Scryer's Blade of Focus
{ 7, 33354 }, -- Wub's Cursed Hexblade
{ 8, 33467 }, -- Blade of Twisted Visions
{ 9, 32053 }, -- Merciless Gladiator's Spellblade
{ 10, 30723 }, -- Talon of the Tempest
{ 11, 30095 }, -- Fang of the Leviathan
{ 12, 28802 }, -- Bloodmaw Magus-Blade
{ 13, 28770 }, -- Nathrezim Mindblade
{ 14, 34604 }, -- Jaded Crystal Dagger
{ 15, 28297 }, -- Gladiator's Spellblade
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 30872 }, -- Chronicle of Dark Secrets
{ 2, 32361 }, -- Blind-Seers Icon
{ 3, 34179 }, -- Heart of the Pit
{ 4, 29270 }, -- Flametongue Seal (Fire)
{ 5, 33334 }, -- Fetish of the Primal Gods
{ 6, 30049 }, -- Fathomstone
{ 7, 28734 }, -- Jewel of Infinite Possibilities
{ 8, 28412 }, -- Lamp of Peaceful Radiance
{ 9, 35008 }, -- Brutal Gladiator's Endgame
{ 10, 28603 }, -- Talisman of Nightbane
{ 11, 29273 }, -- Khadgar's Knapsack
{ 12, 28781 }, -- Karaborian Talisman
{ 13, 25099 }, -- Draenei Crystal Rod of Wrath
{ 14, 28187 }, -- Star-Heart Lamp
{ 15, 32533 }, -- Karrog's Shard
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34182 }, -- Grand Magister's Staff of Torrents
{ 2, 34987 }, -- Brutal Gladiator's Battle Staff
{ 3, 32374 }, -- Zhar'doom, Greatstaff of the Devourer
{ 4, 34540 }, -- Vengeful Gladiator's Battle Staff
{ 5, 35109 }, -- Brutal Gladiator's War Staff
{ 6, 32055 }, -- Merciless Gladiator's War Staff
{ 7, 33766 }, -- Vengeful Gladiator's War Staff
{ 8, 29988 }, -- The Nexus Key
{ 9, 33494 }, -- Amani Divining Staff
{ 10, 24557 }, -- Gladiator's War Staff
{ 11, 28633 }, -- Staff of Infinite Mysteries
{ 12, 29355 }, -- Terokk's Shadowstaff
{ 13, 22589 }, -- Atiesh, Greatstaff of the Guardian
{ 14, 34797 }, -- Sun-infused Focus Staff
{ 15, 29130 }, -- Auchenai Staff
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
{ 1, 34347 }, -- Wand of the Demonsoul
{ 2, 29982 }, -- Wand of the Forgotten Star
{ 3, 32343 }, -- Wand of Prismatic Focus
{ 4, 33192 }, -- Carved Witch Doctor's Stick
{ 5, 28673 }, -- Tirisfal Wand of Ascendancy
{ 6, 28783 }, -- Eredar Wand of Obliteration
{ 7, 29350 }, -- The Black Stalk
{ 8, 28386 }, -- Nether Core's Control Rod
{ 9, 22821 }, -- Doomfinger
{ 10, 35107 }, -- Brutal Gladiator's Touch of Defeat
{ 11, 32872 }, -- Illidari Rod of Discipline
{ 12, 25295 }, -- Flawless Wand of Wrath
{ 13, 22820 }, -- Wand of Fates
{ 14, 33764 }, -- Vengeful Gladiator's Touch of Defeat
{ 15, 25939 }, -- Voidfire Wand
},
},




--@end-version-bcc@
},
}



data["WarlockAff"] = {
	name = AL["Warlock Aff BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34340 }, -- Dark Conjuror's Collar
{ 2, 32525 }, -- Cowl of the Illidari High Lord
{ 3, 31051 }, -- Hood of the Malefic
{ 4, 34847 }, -- Annihilator Holo-Gogs
{ 5, 34405 }, -- Helm of Arcane Purity
{ 6, 33453 }, -- Hood of Hexing
{ 7, 32494 }, -- Destruction Holo-gogs
{ 8, 30212 }, -- Hood of the Corruptor
{ 9, 29986 }, -- Cowl of the Grand Engineer
{ 10, 35010 }, -- Brutal Gladiator's Felweave Cowl
{ 11, 33683 }, -- Vengeful Gladiator's Felweave Cowl
{ 12, 28963 }, -- Voidheart Crown
{ 13, 24266 }, -- Spellstrike Hood
{ 14, 35004 }, -- Brutal Gladiator's Dreadweave Hood
{ 15, 31980 }, -- Merciless Gladiator's Felweave Cowl
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34204 }, -- Amulet of Unfettered Magics
{ 2, 34359 }, -- Pendant of Sunfire
{ 3, 32349 }, -- Translucent Spellthread Necklace
{ 4, 37928 }, -- Guardian's Pendant of Subjugation
{ 5, 24116 }, -- Eye of the Night (GROUP BUFF)
{ 6, 34360 }, -- Amulet of Flowing Life
{ 7, 33281 }, -- Brooch of Nature's Mercy
{ 8, 33466 }, -- Loop of Cursed Bones
{ 9, 37929 }, -- Guardian's Pendant of Reprieve
{ 10, 35319 }, -- Vindicator's Pendant of Subjugation
{ 11, 35290 }, -- Sin'dorei Pendant of Conquest
{ 12, 35317 }, -- Vindicator's Pendant of Reprieve
{ 13, 35132 }, -- Guardian's Pendant of Conquest
{ 14, 30015 }, -- The Sun King's Talisman
{ 15, 34184 }, -- Brooch of the Highborne
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34210 }, -- Amice of the Convoker
{ 2, 31054 }, -- Mantle of the Malefic
{ 3, 34393 }, -- Shoulderpads of Knowledge's Pursuit
{ 4, 35006 }, -- Brutal Gladiator's Dreadweave Mantle
{ 5, 32338 }, -- Blood-cursed Shoulderpads
{ 6, 30215 }, -- Mantle of the Corruptor
{ 7, 30884 }, -- Hatefury Mantle
{ 8, 32587 }, -- Mantle of Nimble Thought
{ 9, 33679 }, -- Vengeful Gladiator's Dreadweave Mantle
{ 10, 28967 }, -- Voidheart Mantle
{ 11, 35009 }, -- Brutal Gladiator's Felweave Amice
{ 12, 30024 }, -- Mantle of the Elven Kings
{ 13, 33489 }, -- Mantle of Ill Intent
{ 14, 31976 }, -- Merciless Gladiator's Dreadweave Mantle
{ 15, 30079 }, -- Illidari Shoulderpads
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34242 }, -- Tattered Cape of Antonidas
{ 2, 32590 }, -- Nethervoid Cloak (Shadow)
{ 3, 32524 }, -- Shroud of the Highborne
{ 4, 28766 }, -- Ruby Drape of the Mysticant
{ 5, 32331 }, -- Cloak of the Illidari Council
{ 6, 33591 }, -- Shadowcaster's Drape
{ 7, 34792 }, -- Cloak of the Betrayed
{ 8, 33592 }, -- Cloak of Ancient Rituals
{ 9, 30735 }, -- Ancient Spellcloak of the Highborne
{ 10, 35321 }, -- Cloak of Arcane Alacrity
{ 11, 23050 }, -- Cloak of the Necropolis
{ 12, 29992 }, -- Royal Cloak of the Sunstriders
{ 13, 28797 }, -- Brute Cloak of the Ogre-Magi
{ 14, 31201 }, -- Illidari Cloak of Wrath
{ 15, 27981 }, -- Sethekk Oracle Cloak
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34364 }, -- Sunfire Robe
{ 2, 34232 }, -- Fel Conquerer Raiments
{ 3, 34399 }, -- Robes of Ghostly Hatred
{ 4, 30107 }, -- Vestments of the Sea-Witch
{ 5, 31052 }, -- Robe of the Malefic
{ 6, 30913 }, -- Robes of Rhonin
{ 7, 30214 }, -- Robe of the Corruptor
{ 8, 34917 }, -- Shroud of the Lore`nial
{ 9, 34610 }, -- Scarlet Sin'dorei Robes
{ 10, 34936 }, -- Tormented Demonsoul Robes
{ 11, 35012 }, -- Brutal Gladiator's Felweave Raiment
{ 12, 30056 }, -- Robe of Hateful Echoes
{ 13, 28964 }, -- Voidheart Robe
{ 14, 29341 }, -- Auchenai Anchorite's Robe
{ 15, 33685 }, -- Vengeful Gladiator's Felweave Raiment
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34436 }, -- Bracers of the Malefic
{ 2, 32270 }, -- Focused Mana Bindings
{ 3, 32586 }, -- Bracers of Nimble Thought
{ 4, 33588 }, -- Runed Spell-cuffs
{ 5, 35179 }, -- Guardian's Silk Cuffs
{ 6, 30870 }, -- Cuffs of Devastation
{ 7, 33285 }, -- Fury of the Ursine
{ 8, 30684 }, -- Ravager's Cuffs of Wrath
{ 9, 33913 }, -- Vindicator's Silk Cuffs
{ 10, 35168 }, -- Guardian's Dreadweave Cuffs
{ 11, 29918 }, -- Mindstorm Wristbands
{ 12, 32820 }, -- Veteran's Silk Cuffs
{ 13, 32655 }, -- Crystalweave Bracers
{ 14, 33883 }, -- Vindicator's Dreadweave Cuffs
{ 15, 28411 }, -- General's Silk Cuffs
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34344 }, -- Handguards of Defiled Worlds
{ 2, 34406 }, -- Gloves of Tyri's Power
{ 3, 34366 }, -- Sunfire Handwraps
{ 4, 30725 }, -- Anger-Spark Gloves
{ 5, 31050 }, -- Gloves of the Malefic
{ 6, 34808 }, -- Gloves of Arcane Acuity
{ 7, 28507 }, -- Handwraps of Flowing Thought
{ 8, 33586 }, -- Studious Wraps
{ 9, 34938 }, -- Enslaved Doomguard Soulgrips
{ 10, 28780 }, -- Soul-Eater's Handwraps
{ 11, 24450 }, -- Manaspark Gloves
{ 12, 29987 }, -- Gauntlets of the Sun King
{ 13, 35011 }, -- Brutal Gladiator's Felweave Handguards
{ 14, 34342 }, -- Handguards of the Dawn
{ 15, 30211 }, -- Gloves of the Corruptor
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34541 }, -- Belt of the Malefic
{ 2, 30038 }, -- Belt of Blasting
{ 3, 30064 }, -- Cord of Screaming Terrors
{ 4, 30888 }, -- Anetheron's Noose
{ 5, 32256 }, -- Waistwrap of Infinity
{ 6, 33291 }, -- Voodoo-woven Belt
{ 7, 24256 }, -- Girdle of Ruination
{ 8, 30675 }, -- Lurker's Cord of the Wrath
{ 9, 28799 }, -- Belt of Divine Inspiration
{ 10, 35164 }, -- Guardian's Silk Belt
{ 11, 27843 }, -- Glyph-Lined Sash
{ 12, 29241 }, -- Belt of Depravity
{ 13, 33912 }, -- Vindicator's Silk Belt
{ 14, 30675 }, -- Lurker's Cord of Invoker
{ 15, 28654 }, -- Malefic Girdle
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34362 }, -- Loop of Forged Power
{ 2, 33497 }, -- Mana Attuned Band
{ 3, 34230 }, -- Ring of Omnipotence
{ 4, 32247 }, -- Ring of Captured Storms
{ 5, 34889 }, -- Fused Nethergon Band
{ 6, 32527 }, -- Ring of Ancient Knowledge
{ 7, 29305 }, -- Band of the Eternal Sage
{ 8, 34363 }, -- Ring of Flowing Life
{ 9, 32528 }, -- Blessed Band of Karabor
{ 10, 33498 }, -- Signet of the Quiet Forest
{ 11, 34166 }, -- Band of Lucent Beams
{ 12, 28793 }, -- Band of Crimson Fury
{ 13, 29304 }, -- Band of Eternity (revered)
{ 14, 35282 }, -- Sin'dorei Band of Dominance
{ 15, 29172 }, -- Ashyen's Gift
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34181 }, -- Leggings of Calamity
{ 2, 34386 }, -- Pantaloons of Growing Strife
{ 3, 30916 }, -- Leggings of Channeled Elements
{ 4, 32367 }, -- Leggings of Devastation
{ 5, 31053 }, -- Leggings of the Malefic
{ 6, 30734 }, -- Leggings of the Seventh Circle
{ 7, 24262 }, -- Spellstrike Pants
{ 8, 30213 }, -- Leggings of the Corruptor
{ 9, 34918 }, -- Legwraps of Sweltering Flame
{ 10, 34937 }, -- Corrupted Soulcloth Pantaloons
{ 11, 33584 }, -- Pantaloons of Arcane Annihilation
{ 12, 28966 }, -- Voidheart Leggings
{ 13, 29972 }, -- Trousers of the Astromancer
{ 14, 30531 }, -- Breeches of the Occultist
{ 15, 35013 }, -- Brutal Gladiator's Felweave Trousers
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34564 }, -- Boots of the Malefic
{ 2, 34919 }, -- Boots of Incantations
{ 3, 32239 }, -- Slippers of the Seacaller
{ 4, 30050 }, -- Boots of the Shifting Nightmare (Shadow)
{ 5, 30894 }, -- Blue Suede Shoes
{ 6, 30037 }, -- Boots of Blasting
{ 7, 33357 }, -- Footpads of Madness
{ 8, 21870 }, -- Frozen Shadoweave Boots (Shadow/Frost)
{ 9, 30680 }, -- Glider's Foot-Wraps of Wrath
{ 10, 28517 }, -- Boots of Foretelling
{ 11, 35149 }, -- Guardian's Silk Footguards
{ 12, 30067 }, -- Velvet Boots of the Guardian
{ 13, 28585 }, -- Ruby Slippers
{ 14, 28406 }, -- Sigil-Laced Boots
{ 15, 33914 }, -- Vindicator's Silk Footguards
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 32483 }, -- The Skull of Gul'dan
{ 2, 34429 }, -- Shifting Naaru Sliver
{ 3, 33829 }, -- Hex Shrunken Head
{ 4, 27683 }, -- Quagmirran's Eye
{ 5, 30626 }, -- Sextant of Unstable Currents
{ 6, 23207 }, -- Mark of the Champion (undead/demon)
{ 7, 31856 }, -- Darkmoon Card: Crusade
{ 8, 29132 }, -- Scryer's Bloodgem
{ 9, 28789 }, -- Eye of Magtheridon
{ 10, 34470 }, -- Timbal's Focusing Crystal
{ 11, 19379 }, -- Neltharion's Tear
{ 12, 29370 }, -- Icon of the Silver Crescent
{ 13, 38290 }, -- Dark Iron Smoking Pipe
{ 14, 28223 }, -- Arcanist's Stone
{ 15, 23046 }, -- The Restrained Essence of Sapphiron
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34336 }, -- Sunflare
{ 2, 30910 }, -- Tempest of Chaos
{ 3, 35102 }, -- Brutal Gladiator's Spellblade
{ 4, 33763 }, -- Vengeful Gladiator's Spellblade
{ 5, 33467 }, -- Blade of Twisted Visions
{ 6, 33354 }, -- Wub's Cursed Hexblade
{ 7, 32237 }, -- The Maelstrom's Fury
{ 8, 34895 }, -- Scryer's Blade of Focus
{ 9, 32053 }, -- Merciless Gladiator's Spellblade
{ 10, 30723 }, -- Talon of the Tempest
{ 11, 30095 }, -- Fang of the Leviathan
{ 12, 28802 }, -- Bloodmaw Magus-Blade
{ 13, 28770 }, -- Nathrezim Mindblade
{ 14, 34604 }, -- Jaded Crystal Dagger
{ 15, 28297 }, -- Gladiator's Spellblade
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 30872 }, -- Chronicle of Dark Secrets
{ 2, 34179 }, -- Heart of the Pit
{ 3, 32361 }, -- Blind-Seers Icon
{ 4, 33334 }, -- Fetish of the Primal Gods
{ 5, 28734 }, -- Jewel of Infinite Possibilities
{ 6, 30049 }, -- Fathomstone
{ 7, 28412 }, -- Lamp of Peaceful Radiance
{ 8, 29272 }, -- Orb of the Soul-Eater (Shadow)
{ 9, 29273 }, -- Khadgar's Knapsack
{ 10, 35008 }, -- Brutal Gladiator's Endgame
{ 11, 28187 }, -- Star-Heart Lamp
{ 12, 28603 }, -- Talisman of Nightbane
{ 13, 25099 }, -- Draenei Crystal Rod of Wrath
{ 14, 32533 }, -- Karrog's Shard
{ 15, 28781 }, -- Karaborian Talisman
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34182 }, -- Grand Magister's Staff of Torrents
{ 2, 34987 }, -- Brutal Gladiator's Battle Staff
{ 3, 32374 }, -- Zhar'doom, Greatstaff of the Devourer
{ 4, 34540 }, -- Vengeful Gladiator's Battle Staff
{ 5, 35109 }, -- Brutal Gladiator's War Staff
{ 6, 32055 }, -- Merciless Gladiator's War Staff
{ 7, 33766 }, -- Vengeful Gladiator's War Staff
{ 8, 33494 }, -- Amani Divining Staff
{ 9, 29988 }, -- The Nexus Key
{ 10, 24557 }, -- Gladiator's War Staff
{ 11, 28633 }, -- Staff of Infinite Mysteries
{ 12, 22630 }, -- Atiesh, Greatstaff of the Guardian
{ 13, 35514 }, -- Frostscythe of Lord Ahune
{ 14, 34797 }, -- Sun-infused Focus Staff
{ 15, 29355 }, -- Terokk's Shadowstaff
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
{ 1, 34347 }, -- Wand of the Demonsoul
{ 2, 29982 }, -- Wand of the Forgotten Star
{ 3, 32343 }, -- Wand of Prismatic Focus
{ 4, 28673 }, -- Tirisfal Wand of Ascendancy
{ 5, 33192 }, -- Carved Witch Doctor's Stick
{ 6, 28783 }, -- Eredar Wand of Obliteration
{ 7, 28386 }, -- Nether Core's Control Rod
{ 8, 30724 }, -- Barrel-Blade Longrifle
{ 9, 29350 }, -- The Black Stalk
{ 10, 22820 }, -- Wand of Fates
{ 11, 34348 }, -- Wand of Cleansing Light
{ 12, 22821 }, -- Doomfinger
{ 13, 32872 }, -- Illidari Rod of Discipline
{ 14, 35107 }, -- Brutal Gladiator's Touch of Defeat
{ 15, 25295 }, -- Flawless Wand of Wrath
},
},




--@end-version-bcc@
},
}

data["Warlockdest"] = {
	name = AL["Warlock Destro BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34340 }, -- Dark Conjuror's Collar
{ 2, 32525 }, -- Cowl of the Illidari High Lord
{ 3, 34847 }, -- Annihilator Holo-Gogs
{ 4, 31051 }, -- Hood of the Malefic
{ 5, 34405 }, -- Helm of Arcane Purity
{ 6, 33453 }, -- Hood of Hexing
{ 7, 32494 }, -- Destruction Holo-gogs
{ 8, 30212 }, -- Hood of the Corruptor
{ 9, 29986 }, -- Cowl of the Grand Engineer
{ 10, 35010 }, -- Brutal Gladiator's Felweave Cowl
{ 11, 33683 }, -- Vengeful Gladiator's Felweave Cowl
{ 12, 24266 }, -- Spellstrike Hood
{ 13, 28963 }, -- Voidheart Crown
{ 14, 35004 }, -- Brutal Gladiator's Dreadweave Hood
{ 15, 31980 }, -- Merciless Gladiator's Felweave Cowl
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34204 }, -- Amulet of Unfettered Magics
{ 2, 34359 }, -- Pendant of Sunfire
{ 3, 32349 }, -- Translucent Spellthread Necklace
{ 4, 37928 }, -- Guardian's Pendant of Subjugation
{ 5, 34360 }, -- Amulet of Flowing Life
{ 6, 32589 }, -- Hellfire-Encased Pendant (Fire)
{ 7, 33281 }, -- Brooch of Nature's Mercy
{ 8, 33466 }, -- Loop of Cursed Bones
{ 9, 24116 }, -- Eye of the Night (GROUP BUFF)
{ 10, 37929 }, -- Guardian's Pendant of Reprieve
{ 11, 35319 }, -- Vindicator's Pendant of Subjugation
{ 12, 35290 }, -- Sin'dorei Pendant of Conquest
{ 13, 35132 }, -- Guardian's Pendant of Conquest
{ 14, 30015 }, -- The Sun King's Talisman
{ 15, 35317 }, -- Vindicator's Pendant of Reprieve
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34210 }, -- Amice of the Convoker
{ 2, 31054 }, -- Mantle of the Malefic
{ 3, 34393 }, -- Shoulderpads of Knowledge's Pursuit
{ 4, 35006 }, -- Brutal Gladiator's Dreadweave Mantle
{ 5, 32338 }, -- Blood-cursed Shoulderpads
{ 6, 30884 }, -- Hatefury Mantle
{ 7, 30215 }, -- Mantle of the Corruptor
{ 8, 32587 }, -- Mantle of Nimble Thought
{ 9, 33679 }, -- Vengeful Gladiator's Dreadweave Mantle
{ 10, 35009 }, -- Brutal Gladiator's Felweave Amice
{ 11, 28967 }, -- Voidheart Mantle
{ 12, 33489 }, -- Mantle of Ill Intent
{ 13, 30024 }, -- Mantle of the Elven Kings
{ 14, 30079 }, -- Illidari Shoulderpads
{ 15, 31976 }, -- Merciless Gladiator's Dreadweave Mantle
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34242 }, -- Tattered Cape of Antonidas
{ 2, 32590 }, -- Nethervoid Cloak (Shadow)
{ 3, 32524 }, -- Shroud of the Highborne
{ 4, 32331 }, -- Cloak of the Illidari Council
{ 5, 33591 }, -- Shadowcaster's Drape
{ 6, 28766 }, -- Ruby Drape of the Mysticant
{ 7, 34792 }, -- Cloak of the Betrayed
{ 8, 33592 }, -- Cloak of Ancient Rituals
{ 9, 29992 }, -- Royal Cloak of the Sunstriders
{ 10, 30735 }, -- Ancient Spellcloak of the Highborne
{ 11, 35321 }, -- Cloak of Arcane Alacrity
{ 12, 28797 }, -- Brute Cloak of the Ogre-Magi
{ 13, 23050 }, -- Cloak of the Necropolis
{ 14, 31201 }, -- Illidari Cloak of Wrath
{ 15, 27981 }, -- Sethekk Oracle Cloak
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34364 }, -- Sunfire Robe
{ 2, 34232 }, -- Fel Conquerer Raiments
{ 3, 34399 }, -- Robes of Ghostly Hatred
{ 4, 30107 }, -- Vestments of the Sea-Witch
{ 5, 31052 }, -- Robe of the Malefic
{ 6, 30913 }, -- Robes of Rhonin
{ 7, 30214 }, -- Robe of the Corruptor
{ 8, 34917 }, -- Shroud of the Lore`nial
{ 9, 34936 }, -- Tormented Demonsoul Robes
{ 10, 34610 }, -- Scarlet Sin'dorei Robes
{ 11, 21848 }, -- Spellfire Robe (Fire/Arcane)
{ 12, 35012 }, -- Brutal Gladiator's Felweave Raiment
{ 13, 30056 }, -- Robe of Hateful Echoes
{ 14, 28964 }, -- Voidheart Robe
{ 15, 35007 }, -- Brutal Gladiator's Dreadweave Robe
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34436 }, -- Bracers of the Malefic
{ 2, 32586 }, -- Bracers of Nimble Thought
{ 3, 32270 }, -- Focused Mana Bindings
{ 4, 33588 }, -- Runed Spell-cuffs
{ 5, 35179 }, -- Guardian's Silk Cuffs
{ 6, 30870 }, -- Cuffs of Devastation
{ 7, 34697 }, -- Bindings of Raging Fire
{ 8, 33285 }, -- Fury of the Ursine
{ 9, 33913 }, -- Vindicator's Silk Cuffs
{ 10, 30684 }, -- Ravager's Cuffs of Wrath
{ 11, 35168 }, -- Guardian's Dreadweave Cuffs
{ 12, 29918 }, -- Mindstorm Wristbands
{ 13, 32820 }, -- Veteran's Silk Cuffs
{ 14, 33883 }, -- Vindicator's Dreadweave Cuffs
{ 15, 32655 }, -- Crystalweave Bracers
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34344 }, -- Handguards of Defiled Worlds
{ 2, 34406 }, -- Gloves of Tyri's Power
{ 3, 34366 }, -- Sunfire Handwraps
{ 4, 31050 }, -- Gloves of the Malefic
{ 5, 30725 }, -- Anger-Spark Gloves
{ 6, 21847 }, -- Spellfire Gloves (Fire/Arcane)
{ 7, 34808 }, -- Gloves of Arcane Acuity
{ 8, 33586 }, -- Studious Wraps
{ 9, 34938 }, -- Enslaved Doomguard Soulgrips
{ 10, 28507 }, -- Handwraps of Flowing Thought
{ 11, 28780 }, -- Soul-Eater's Handwraps
{ 12, 29987 }, -- Gauntlets of the Sun King
{ 13, 35011 }, -- Brutal Gladiator's Felweave Handguards
{ 14, 34342 }, -- Handguards of the Dawn
{ 15, 30211 }, -- Gloves of the Corruptor
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34541 }, -- Belt of the Malefic
{ 2, 30038 }, -- Belt of Blasting
{ 3, 30064 }, -- Cord of Screaming Terrors
{ 4, 30888 }, -- Anetheron's Noose
{ 5, 32256 }, -- Waistwrap of Infinity
{ 6, 21846 }, -- Spellfire Belt (Fire/Arcane)
{ 7, 33291 }, -- Voodoo-woven Belt
{ 8, 30020 }, -- Fire-Cord of the Magus (Fire)
{ 9, 24256 }, -- Girdle of Ruination
{ 10, 30673 }, -- Inferno Waist Cord (Fire)
{ 11, 28799 }, -- Belt of Divine Inspiration
{ 12, 30675 }, -- Lurker's Cord of the Wrath
{ 13, 35164 }, -- Guardian's Silk Belt
{ 14, 27843 }, -- Glyph-Lined Sash
{ 15, 29241 }, -- Belt of Depravity
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34362 }, -- Loop of Forged Power
{ 2, 33497 }, -- Mana Attuned Band
{ 3, 34230 }, -- Ring of Omnipotence
{ 4, 32247 }, -- Ring of Captured Storms
{ 5, 32527 }, -- Ring of Ancient Knowledge
{ 6, 34889 }, -- Fused Nethergon Band
{ 7, 29305 }, -- Band of the Eternal Sage
{ 8, 34363 }, -- Ring of Flowing Life
{ 9, 32528 }, -- Blessed Band of Karabor
{ 10, 33498 }, -- Signet of the Quiet Forest
{ 11, 34166 }, -- Band of Lucent Beams
{ 12, 29304 }, -- Band of Eternity (revered)
{ 13, 35282 }, -- Sin'dorei Band of Dominance
{ 14, 28793 }, -- Band of Crimson Fury
{ 15, 29303 }, -- Band of Eternity (honored)
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34181 }, -- Leggings of Calamity
{ 2, 34386 }, -- Pantaloons of Growing Strife
{ 3, 30916 }, -- Leggings of Channeled Elements
{ 4, 32367 }, -- Leggings of Devastation
{ 5, 31053 }, -- Leggings of the Malefic
{ 6, 30734 }, -- Leggings of the Seventh Circle
{ 7, 34918 }, -- Legwraps of Sweltering Flame
{ 8, 30213 }, -- Leggings of the Corruptor
{ 9, 24262 }, -- Spellstrike Pants
{ 10, 34937 }, -- Corrupted Soulcloth Pantaloons
{ 11, 33584 }, -- Pantaloons of Arcane Annihilation
{ 12, 29972 }, -- Trousers of the Astromancer
{ 13, 28594 }, -- Trial-Fire Trousers
{ 14, 28966 }, -- Voidheart Leggings
{ 15, 35013 }, -- Brutal Gladiator's Felweave Trousers
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34564 }, -- Boots of the Malefic
{ 2, 32239 }, -- Slippers of the Seacaller
{ 3, 30894 }, -- Blue Suede Shoes
{ 4, 34919 }, -- Boots of Incantations
{ 5, 30050 }, -- Boots of the Shifting Nightmare (Shadow)
{ 6, 30037 }, -- Boots of Blasting
{ 7, 33357 }, -- Footpads of Madness
{ 8, 21870 }, -- Frozen Shadoweave Boots (Shadow/Frost)
{ 9, 30680 }, -- Glider's Foot-Wraps of Wrath
{ 10, 35149 }, -- Guardian's Silk Footguards
{ 11, 30067 }, -- Velvet Boots of the Guardian
{ 12, 28517 }, -- Boots of Foretelling
{ 13, 28585 }, -- Ruby Slippers
{ 14, 33914 }, -- Vindicator's Silk Footguards
{ 15, 35138 }, -- Guardian's Dreadweave Stalkers
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 32483 }, -- The Skull of Gul'dan
{ 2, 34429 }, -- Shifting Naaru Sliver
{ 3, 33829 }, -- Hex Shrunken Head
{ 4, 23207 }, -- Mark of the Champion (undead/demon)
{ 5, 30626 }, -- Sextant of Unstable Currents
{ 6, 27683 }, -- Quagmirran's Eye
{ 7, 31856 }, -- Darkmoon Card: Crusade
{ 8, 28789 }, -- Eye of Magtheridon
{ 9, 34470 }, -- Timbal's Focusing Crystal
{ 10, 29370 }, -- Icon of the Silver Crescent
{ 11, 38290 }, -- Dark Iron Smoking Pipe
{ 12, 29132 }, -- Scryer's Bloodgem
{ 13, 19379 }, -- Neltharion's Tear
{ 14, 23046 }, -- The Restrained Essence of Sapphiron
{ 15, 28223 }, -- Arcanist's Stone
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34336 }, -- Sunflare
{ 2, 30910 }, -- Tempest of Chaos
{ 3, 35102 }, -- Brutal Gladiator's Spellblade
{ 4, 33763 }, -- Vengeful Gladiator's Spellblade
{ 5, 33467 }, -- Blade of Twisted Visions
{ 6, 34895 }, -- Scryer's Blade of Focus
{ 7, 32237 }, -- The Maelstrom's Fury
{ 8, 33354 }, -- Wub's Cursed Hexblade
{ 9, 32053 }, -- Merciless Gladiator's Spellblade
{ 10, 30723 }, -- Talon of the Tempest
{ 11, 30095 }, -- Fang of the Leviathan
{ 12, 28770 }, -- Nathrezim Mindblade
{ 13, 28802 }, -- Bloodmaw Magus-Blade
{ 14, 34604 }, -- Jaded Crystal Dagger
{ 15, 28297 }, -- Gladiator's Spellblade
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34179 }, -- Heart of the Pit
{ 2, 30872 }, -- Chronicle of Dark Secrets
{ 3, 32361 }, -- Blind-Seers Icon
{ 4, 33334 }, -- Fetish of the Primal Gods
{ 5, 29270 }, -- Flametongue Seal (Fire)
{ 6, 28734 }, -- Jewel of Infinite Possibilities
{ 7, 30049 }, -- Fathomstone
{ 8, 35008 }, -- Brutal Gladiator's Endgame
{ 9, 29272 }, -- Orb of the Soul-Eater (Shadow)
{ 10, 28412 }, -- Lamp of Peaceful Radiance
{ 11, 29273 }, -- Khadgar's Knapsack
{ 12, 28603 }, -- Talisman of Nightbane
{ 13, 28187 }, -- Star-Heart Lamp
{ 14, 28781 }, -- Karaborian Talisman
{ 15, 33681 }, -- Vengeful Gladiator's Endgame
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34182 }, -- Grand Magister's Staff of Torrents
{ 2, 32374 }, -- Zhar'doom, Greatstaff of the Devourer
{ 3, 34987 }, -- Brutal Gladiator's Battle Staff
{ 4, 34540 }, -- Vengeful Gladiator's Battle Staff
{ 5, 35109 }, -- Brutal Gladiator's War Staff
{ 6, 32055 }, -- Merciless Gladiator's War Staff
{ 7, 33766 }, -- Vengeful Gladiator's War Staff
{ 8, 33494 }, -- Amani Divining Staff
{ 9, 29988 }, -- The Nexus Key
{ 10, 24557 }, -- Gladiator's War Staff
{ 11, 28633 }, -- Staff of Infinite Mysteries
{ 12, 22630 }, -- Atiesh, Greatstaff of the Guardian
{ 13, 35514 }, -- Frostscythe of Lord Ahune
{ 14, 29355 }, -- Terokk's Shadowstaff
{ 15, 34797 }, -- Sun-infused Focus Staff
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
{ 1, 34347 }, -- Wand of the Demonsoul
{ 2, 29982 }, -- Wand of the Forgotten Star
{ 3, 32343 }, -- Wand of Prismatic Focus
{ 4, 33192 }, -- Carved Witch Doctor's Stick
{ 5, 28673 }, -- Tirisfal Wand of Ascendancy
{ 6, 28783 }, -- Eredar Wand of Obliteration
{ 7, 22128 }, -- Master Firestone (Fire)
{ 8, 28386 }, -- Nether Core's Control Rod
{ 9, 29350 }, -- The Black Stalk
{ 10, 35107 }, -- Brutal Gladiator's Touch of Defeat
{ 11, 22820 }, -- Wand of Fates
{ 12, 32872 }, -- Illidari Rod of Discipline
{ 13, 34348 }, -- Wand of Cleansing Light
{ 14, 22821 }, -- Doomfinger
{ 15, 25295 }, -- Flawless Wand of Wrath
},
},




--@end-version-bcc@
},
}





data["PriestShadow"] = {
	name = AL["Priest Shadow BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34340 }, -- Dark Conjuror's Collar
{ 2, 34847 }, -- Annihilator Holo-Gogs
{ 3, 32525 }, -- Cowl of the Illidari High Lord
{ 4, 34405 }, -- Helm of Arcane Purity
{ 5, 33453 }, -- Hood of Hexing
{ 6, 30161 }, -- Hood of the Avatar
{ 7, 32494 }, -- Destruction Holo-gogs
{ 8, 31064 }, -- Hood of Absolution
{ 9, 29986 }, -- Cowl of the Grand Engineer
{ 10, 24266 }, -- Spellstrike Hood
{ 11, 29058 }, -- Soul-Collar of the Incarnate
{ 12, 35084 }, -- Brutal Gladiator's Satin Hood
{ 13, 33745 }, -- Vengeful Gladiator's Satin Hood
{ 14, 28415 }, -- Hood of Oblivion
{ 15, 32089 }, -- Mana-Binders Cowl
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34204 }, -- Amulet of Unfettered Magics
{ 2, 34359 }, -- Pendant of Sunfire
{ 3, 37928 }, -- Guardian's Pendant of Subjugation
{ 4, 32349 }, -- Translucent Spellthread Necklace
{ 5, 33281 }, -- Brooch of Nature's Mercy
{ 6, 33466 }, -- Loop of Cursed Bones
{ 7, 34360 }, -- Amulet of Flowing Life
{ 8, 35319 }, -- Vindicator's Pendant of Subjugation
{ 9, 37929 }, -- Guardian's Pendant of Reprieve
{ 10, 35317 }, -- Vindicator's Pendant of Reprieve
{ 11, 30666 }, -- Ritssyn's Lost Pendant (Shadow)
{ 12, 24116 }, -- Eye of the Night (GROUP BUFF)
{ 13, 35290 }, -- Sin'dorei Pendant of Conquest
{ 14, 35133 }, -- Guardian's Pendant of Dominance
{ 15, 30015 }, -- The Sun King's Talisman
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34210 }, -- Amice of the Convoker
{ 2, 34393 }, -- Shoulderpads of Knowledge's Pursuit
{ 3, 30884 }, -- Hatefury Mantle
{ 4, 31070 }, -- Shoulderpads of Absolution
{ 5, 32587 }, -- Mantle of Nimble Thought
{ 6, 21869 }, -- Frozen Shadoweave Shoulders (Shadow/Frost)
{ 7, 32338 }, -- Blood-cursed Shoulderpads
{ 8, 33489 }, -- Mantle of Ill Intent
{ 9, 30163 }, -- Wings of the Avatar
{ 10, 30079 }, -- Illidari Shoulderpads
{ 11, 34607 }, -- Fel-tinged Mantle
{ 12, 35086 }, -- Brutal Gladiator's Satin Mantle
{ 13, 30024 }, -- Mantle of the Elven Kings
{ 14, 34202 }, -- Shawl of Wonderment
{ 15, 34788 }, -- Duskhallow Mantle
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34242 }, -- Tattered Cape of Antonidas
{ 2, 32590 }, -- Nethervoid Cloak (Shadow)
{ 3, 32524 }, -- Shroud of the Highborne
{ 4, 33591 }, -- Shadowcaster's Drape
{ 5, 32331 }, -- Cloak of the Illidari Council
{ 6, 31201 }, -- Illidari Cloak of Wrath
{ 7, 34792 }, -- Cloak of the Betrayed
{ 8, 29992 }, -- Royal Cloak of the Sunstriders
{ 9, 28766 }, -- Ruby Drape of the Mysticant
{ 10, 35321 }, -- Cloak of Arcane Alacrity
{ 11, 33592 }, -- Cloak of Ancient Rituals
{ 12, 25041 }, -- Ambusher's Cloak of Wrath
{ 13, 30735 }, -- Ancient Spellcloak of the Highborne
{ 14, 28570 }, -- Shadow-Cloak of Dalaran
{ 15, 22731 }, -- Cloak of the Devoured
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34364 }, -- Sunfire Robe
{ 2, 34232 }, -- Fel Conquerer Raiments
{ 3, 34399 }, -- Robes of Ghostly Hatred
{ 4, 30107 }, -- Vestments of the Sea-Witch
{ 5, 31065 }, -- Shroud of Absolution
{ 6, 30159 }, -- Shroud of the Avatar
{ 7, 30913 }, -- Robes of Rhonin
{ 8, 34917 }, -- Shroud of the Lore`nial
{ 9, 29056 }, -- Shroud of the Incarnate
{ 10, 21871 }, -- Frozen Shadoweave Robe (Shadow/Frost)
{ 11, 34610 }, -- Scarlet Sin'dorei Robes
{ 12, 33317 }, -- Robe of Departed Spirits
{ 13, 30056 }, -- Robe of Hateful Echoes
{ 14, 35087 }, -- Brutal Gladiator's Satin Robe
{ 15, 34936 }, -- Tormented Demonsoul Robes
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34434 }, -- Bracers of Absolution
{ 2, 32586 }, -- Bracers of Nimble Thought
{ 3, 30684 }, -- Ravager's Cuffs of Wrath
{ 4, 32270 }, -- Focused Mana Bindings
{ 5, 33588 }, -- Runed Spell-cuffs
{ 6, 30870 }, -- Cuffs of Devastation
{ 7, 35168 }, -- Guardian's Dreadweave Cuffs
{ 8, 31225 }, -- Illidari Bindings of Wrath
{ 9, 33285 }, -- Fury of the Ursine
{ 10, 35179 }, -- Guardian's Silk Cuffs
{ 11, 24692 }, -- Elementalist Bracelets of Wrath
{ 12, 33913 }, -- Vindicator's Silk Cuffs
{ 13, 24250 }, -- Bracers of Havok
{ 14, 33883 }, -- Vindicator's Dreadweave Cuffs
{ 15, 29918 }, -- Mindstorm Wristbands
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34344 }, -- Handguards of Defiled Worlds
{ 2, 34406 }, -- Gloves of Tyri's Power
{ 3, 34366 }, -- Sunfire Handwraps
{ 4, 31061 }, -- Handguards of Absolution
{ 5, 30725 }, -- Anger-Spark Gloves
{ 6, 34808 }, -- Gloves of Arcane Acuity
{ 7, 28507 }, -- Handwraps of Flowing Thought
{ 8, 33586 }, -- Studious Wraps
{ 9, 28780 }, -- Soul-Eater's Handwraps
{ 10, 34938 }, -- Enslaved Doomguard Soulgrips
{ 11, 30160 }, -- Handguards of the Avatar
{ 12, 34342 }, -- Handguards of the Dawn
{ 13, 24450 }, -- Manaspark Gloves
{ 14, 29317 }, -- Tempest's Touch
{ 15, 29987 }, -- Gauntlets of the Sun King
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34528 }, -- Cord of Absolution
{ 2, 30038 }, -- Belt of Blasting
{ 3, 30064 }, -- Cord of Screaming Terrors
{ 4, 32256 }, -- Waistwrap of Infinity
{ 5, 30888 }, -- Anetheron's Noose
{ 6, 30675 }, -- Lurker's Cord of the Wrath
{ 7, 28799 }, -- Belt of Divine Inspiration
{ 8, 24256 }, -- Girdle of Ruination
{ 9, 33291 }, -- Voodoo-woven Belt
{ 10, 27843 }, -- Glyph-Lined Sash
{ 11, 24255 }, -- Unyielding Girdle
{ 12, 35153 }, -- Guardian's Dreadweave Belt
{ 13, 29241 }, -- Belt of Depravity
{ 14, 24395 }, -- Mindfire Waistband
{ 15, 35164 }, -- Guardian's Silk Belt
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34362 }, -- Loop of Forged Power
{ 2, 33497 }, -- Mana Attuned Band
{ 3, 34230 }, -- Ring of Omnipotence
{ 4, 32527 }, -- Ring of Ancient Knowledge
{ 5, 32247 }, -- Ring of Captured Storms
{ 6, 34889 }, -- Fused Nethergon Band
{ 7, 32528 }, -- Blessed Band of Karabor
{ 8, 29305 }, -- Band of the Eternal Sage
{ 9, 34363 }, -- Ring of Flowing Life
{ 10, 33498 }, -- Signet of the Quiet Forest
{ 11, 34166 }, -- Band of Lucent Beams
{ 12, 35129 }, -- Guardian's Band of Dominance
{ 13, 21709 }, -- Ring of the Fallen God
{ 14, 34625 }, -- Kharmaa's Ring of Fate
{ 15, 23031 }, -- Band of the Inevitable
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34386 }, -- Pantaloons of Growing Strife
{ 2, 34181 }, -- Leggings of Calamity
{ 3, 30916 }, -- Leggings of Channeled Elements
{ 4, 32367 }, -- Leggings of Devastation
{ 5, 34918 }, -- Legwraps of Sweltering Flame
{ 6, 30734 }, -- Leggings of the Seventh Circle
{ 7, 24262 }, -- Spellstrike Pants
{ 8, 33584 }, -- Pantaloons of Arcane Annihilation
{ 9, 34937 }, -- Corrupted Soulcloth Pantaloons
{ 10, 29972 }, -- Trousers of the Astromancer
{ 11, 30162 }, -- Leggings of the Avatar
{ 12, 28594 }, -- Trial-Fire Trousers
{ 13, 31067 }, -- Leggings of Absolution
{ 14, 30531 }, -- Breeches of the Occultist
{ 15, 30532 }, -- Kirin Tor Master's Trousers
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34563 }, -- Treads of Absolution
{ 2, 21870 }, -- Frozen Shadoweave Boots (Shadow/Frost)
{ 3, 30680 }, -- Glider's Foot-Wraps of Wrath
{ 4, 33357 }, -- Footpads of Madness
{ 5, 32239 }, -- Slippers of the Seacaller
{ 6, 34919 }, -- Boots of Incantations
{ 7, 30050 }, -- Boots of the Shifting Nightmare (Shadow)
{ 8, 30894 }, -- Blue Suede Shoes
{ 9, 30037 }, -- Boots of Blasting
{ 10, 30067 }, -- Velvet Boots of the Guardian
{ 11, 28517 }, -- Boots of Foretelling
{ 12, 28179 }, -- Shattrath Jumpers
{ 13, 35138 }, -- Guardian's Dreadweave Stalkers
{ 14, 28585 }, -- Ruby Slippers
{ 15, 28406 }, -- Sigil-Laced Boots
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 34429 }, -- Shifting Naaru Sliver
{ 2, 32483 }, -- The Skull of Gul'dan
{ 3, 33829 }, -- Hex Shrunken Head
{ 4, 23207 }, -- Mark of the Champion (undead/demon)
{ 5, 31856 }, -- Darkmoon Card: Crusade
{ 6, 27683 }, -- Quagmirran's Eye
{ 7, 28789 }, -- Eye of Magtheridon
{ 8, 34470 }, -- Timbal's Focusing Crystal
{ 9, 29370 }, -- Icon of the Silver Crescent
{ 10, 38290 }, -- Dark Iron Smoking Pipe
{ 11, 30626 }, -- Sextant of Unstable Currents
{ 12, 23046 }, -- The Restrained Essence of Sapphiron
{ 13, 19379 }, -- Neltharion's Tear
{ 14, 29132 }, -- Scryer's Bloodgem
{ 15, 28223 }, -- Arcanist's Stone
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34336 }, -- Sunflare
{ 2, 34176 }, -- Reign of Misery
{ 3, 35014 }, -- Brutal Gladiator's Gavel
{ 4, 35102 }, -- Brutal Gladiator's Spellblade
{ 5, 33687 }, -- Vengeful Gladiator's Gavel
{ 6, 33763 }, -- Vengeful Gladiator's Spellblade
{ 7, 34009 }, -- Hammer of Judgement
{ 8, 34895 }, -- Scryer's Blade of Focus
{ 9, 32237 }, -- The Maelstrom's Fury
{ 10, 32053 }, -- Merciless Gladiator's Spellblade
{ 11, 32963 }, -- Merciless Gladiator's Gavel
{ 12, 33283 }, -- Amani Punisher
{ 13, 33354 }, -- Wub's Cursed Hexblade
{ 14, 34611 }, -- Cudgel of Consecration
{ 15, 30723 }, -- Talon of the Tempest
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34179 }, -- Heart of the Pit
{ 2, 32361 }, -- Blind-Seers Icon
{ 3, 30872 }, -- Chronicle of Dark Secrets
{ 4, 33334 }, -- Fetish of the Primal Gods
{ 5, 29272 }, -- Orb of the Soul-Eater (Shadow)
{ 6, 29273 }, -- Khadgar's Knapsack
{ 7, 25099 }, -- Draenei Crystal Rod of Wrath
{ 8, 35008 }, -- Brutal Gladiator's Endgame
{ 9, 30049 }, -- Fathomstone
{ 10, 28734 }, -- Jewel of Infinite Possibilities
{ 11, 32533 }, -- Karrog's Shard
{ 12, 28781 }, -- Karaborian Talisman
{ 13, 33681 }, -- Vengeful Gladiator's Endgame
{ 14, 31978 }, -- Merciless Gladiator's Endgame
{ 15, 32651 }, -- Crystal Orb of Enlightenment
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34182 }, -- Grand Magister's Staff of Torrents
{ 2, 32374 }, -- Zhar'doom, Greatstaff of the Devourer
{ 3, 34987 }, -- Brutal Gladiator's Battle Staff
{ 4, 34540 }, -- Vengeful Gladiator's Battle Staff
{ 5, 35109 }, -- Brutal Gladiator's War Staff
{ 6, 33494 }, -- Amani Divining Staff
{ 7, 33766 }, -- Vengeful Gladiator's War Staff
{ 8, 32055 }, -- Merciless Gladiator's War Staff
{ 9, 29988 }, -- The Nexus Key
{ 10, 24557 }, -- Gladiator's War Staff
{ 11, 28633 }, -- Staff of Infinite Mysteries
{ 12, 35514 }, -- Frostscythe of Lord Ahune
{ 13, 29355 }, -- Terokk's Shadowstaff
{ 14, 34797 }, -- Sun-infused Focus Staff
{ 15, 28935 }, -- High Warlord's War Staff
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
{ 1, 34347 }, -- Wand of the Demonsoul
{ 2, 32343 }, -- Wand of Prismatic Focus
{ 3, 29982 }, -- Wand of the Forgotten Star
{ 4, 33192 }, -- Carved Witch Doctor's Stick
{ 5, 32872 }, -- Illidari Rod of Discipline
{ 6, 25295 }, -- Flawless Wand of Wrath
{ 7, 28673 }, -- Tirisfal Wand of Ascendancy
{ 8, 34348 }, -- Wand of Cleansing Light
{ 9, 29350 }, -- The Black Stalk
{ 10, 35107 }, -- Brutal Gladiator's Touch of Defeat
{ 11, 28386 }, -- Nether Core's Control Rod
{ 12, 28783 }, -- Eredar Wand of Obliteration
{ 13, 30859 }, -- Wand of the Seer
{ 14, 33764 }, -- Vengeful Gladiator's Touch of Defeat
{ 15, 22820 }, -- Wand of Fates
},
},




--@end-version-bcc@
},
}

data["PriestHoly"] = {
	name = AL["Priest Holy BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34339 }, -- Cowl of Light's Purity
{ 2, 35181 }, -- Powerheal 9000 Lens
{ 3, 31063 }, -- Cowl of Absolution
{ 4, 32329 }, -- Cowl of Benevolence
{ 5, 30152 }, -- Cowl of the Avatar
{ 6, 32495 }, -- Powerheal 4000 Lens
{ 7, 29049 }, -- Light-Collar of the Incarnate
{ 8, 29990 }, -- Crown of the Sun
{ 9, 34405 }, -- Helm of Arcane Purity
{ 10, 33463 }, -- Hood of the Third Eye
{ 11, 31064 }, -- Hood of Absolution
{ 12, 32090 }, -- Cowl of Naaru Blessings
{ 13, 35054 }, -- Brutal Gladiator's Mooncloth Hood
{ 14, 34340 }, -- Dark Conjuror's Collar
{ 15, 28413 }, -- Hallowed Crown
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 33281 }, -- Brooch of Nature's Mercy
{ 2, 34360 }, -- Amulet of Flowing Life
{ 3, 34184 }, -- Brooch of the Highborne
{ 4, 32370 }, -- Nadina's Pendant of Purity
{ 5, 37929 }, -- Guardian's Pendant of Reprieve
{ 6, 28822 }, -- Teeth of Gruul
{ 7, 35291 }, -- Sin'dorei Pendant of Salvation
{ 8, 30018 }, -- Lord Sanguinar's Claim
{ 9, 35134 }, -- Guardian's Pendant of Salvation
{ 10, 35317 }, -- Vindicator's Pendant of Reprieve
{ 11, 28731 }, -- Shining Chain of the Afterworld
{ 12, 33922 }, -- Vindicator's Pendant of Salvation
{ 13, 30726 }, -- Archaic Charm of Presence
{ 14, 34359 }, -- Pendant of Sunfire
{ 15, 27766 }, -- Swampstone Necklace
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34202 }, -- Shawl of Wonderment
{ 2, 31069 }, -- Mantle of Absolution
{ 3, 32273 }, -- Amice of Brilliant Light
{ 4, 32585 }, -- Swiftheal Mantle
{ 5, 30154 }, -- Mantle of the Avatar
{ 6, 29054 }, -- Light-Mantle of the Incarnate
{ 7, 28612 }, -- Pauldrons of the Solace-Giver
{ 8, 21874 }, -- Primal Mooncloth Shoulders
{ 9, 34393 }, -- Shoulderpads of Knowledge's Pursuit
{ 10, 35056 }, -- Brutal Gladiator's Mooncloth Mantle
{ 11, 27775 }, -- Hallowed Pauldrons
{ 12, 34210 }, -- Amice of the Convoker
{ 13, 30163 }, -- Wings of the Avatar
{ 14, 33720 }, -- Vengeful Gladiator's Mooncloth Mantle
{ 15, 27433 }, -- Pauldrons of Sufferance
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 29989 }, -- Sunshower Light Cloak
{ 2, 32337 }, -- Shroud of Forgiveness
{ 3, 34205 }, -- Shroud of Redeemed Souls
{ 4, 32524 }, -- Shroud of the Highborne
{ 5, 34012 }, -- Shroud of the Final Stand
{ 6, 33592 }, -- Cloak of Ancient Rituals
{ 7, 28765 }, -- Stainless Cloak of the Pure Hearted
{ 8, 27946 }, -- Avian Cloak of Feathers
{ 9, 28582 }, -- Red Riding Hood's Cloak
{ 10, 28373 }, -- Cloak of Scintillating Auras
{ 11, 22960 }, -- Cloak of Suturing
{ 12, 35324 }, -- Cloak of Swift Reprieve
{ 13, 34242 }, -- Tattered Cape of Antonidas
{ 14, 31329 }, -- Lifegiving Cloak
{ 15, 33333 }, -- Kharmaa's Shroud of Hope
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34233 }, -- Robes of Faltered Light
{ 2, 34365 }, -- Robe of Eternal Light
{ 3, 31066 }, -- Vestments of Absolution
{ 4, 34924 }, -- Gown of Spiritual Wonder
{ 5, 33203 }, -- Robes of Heavenly Purpose
{ 6, 30150 }, -- Vestments of the Avatar
{ 7, 21875 }, -- Primal Mooncloth Robe
{ 8, 32340 }, -- Garments of Temperance
{ 9, 34399 }, -- Robes of Ghostly Hatred
{ 10, 29050 }, -- Robes of the Incarnate
{ 11, 35057 }, -- Brutal Gladiator's Mooncloth Robe
{ 12, 28230 }, -- Hallowed Garments
{ 13, 34364 }, -- Sunfire Robe
{ 14, 33721 }, -- Vengeful Gladiator's Mooncloth Robe
{ 15, 34232 }, -- Fel Conquerer Raiments
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34435 }, -- Cuffs of Absolution
{ 2, 30871 }, -- Bracers of Martyrdom
{ 3, 32513 }, -- Wristbands of Divine Influence
{ 4, 33589 }, -- Wristguards of Tranquil Thought
{ 5, 32584 }, -- Swiftheal Wraps
{ 6, 35174 }, -- Guardian's Mooncloth Cuffs
{ 7, 30684 }, -- Ravager's Cuffs of the Prophet
{ 8, 34434 }, -- Bracers of Absolution
{ 9, 32516 }, -- Wraps of Purification
{ 10, 28511 }, -- Bands of Indwelling
{ 11, 29249 }, -- Bands of the Benevolent
{ 12, 33901 }, -- Vindicator's Mooncloth Cuffs
{ 13, 30870 }, -- Cuffs of Devastation
{ 14, 22519 }, -- Bindings of Faith
{ 15, 27452 }, -- Light Scribe Bands
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34342 }, -- Handguards of the Dawn
{ 2, 34367 }, -- Hands of Eternal Light
{ 3, 31060 }, -- Gloves of Absolution
{ 4, 30151 }, -- Gloves of the Avatar
{ 5, 32353 }, -- Gloves of Unfailing Faith
{ 6, 33587 }, -- Light-Blessed Bonds
{ 7, 34406 }, -- Gloves of Tyri's Power
{ 8, 28508 }, -- Gloves of Saintly Blessings
{ 9, 29055 }, -- Handwraps of the Incarnate
{ 10, 27536 }, -- Hallowed Handwraps
{ 11, 35053 }, -- Brutal Gladiator's Mooncloth Gloves
{ 12, 34344 }, -- Handguards of Defiled Worlds
{ 13, 22517 }, -- Gloves of Faith
{ 14, 34366 }, -- Sunfire Handwraps
{ 15, 24393 }, -- Bloody Surgeon's Mitts
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34527 }, -- Belt of Absolution
{ 2, 32519 }, -- Belt of Divine Guidance
{ 3, 30036 }, -- Belt of the Long Road
{ 4, 30895 }, -- Angelista's Sash
{ 5, 33480 }, -- Cord of Braided Troll Hair
{ 6, 21873 }, -- Primal Mooncloth Belt
{ 7, 30675 }, -- Lurker's Cord of the Prophet
{ 8, 35159 }, -- Guardian's Mooncloth Belt
{ 9, 28652 }, -- Cincture of Will
{ 10, 34793 }, -- Cord of Reconstruction
{ 11, 34528 }, -- Cord of Absolution
{ 12, 27542 }, -- Cord of Belief
{ 13, 33900 }, -- Vindicator's Mooncloth Belt
{ 14, 24257 }, -- Black Belt of Knowledge
{ 15, 32979 }, -- Veteran's Mooncloth Belt
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 35733 }, -- Ring of Harmonic Beauty
{ 2, 34363 }, -- Ring of Flowing Life
{ 3, 29309 }, -- Band of the Eternal Restorer
{ 4, 34166 }, -- Band of Lucent Beams
{ 5, 32528 }, -- Blessed Band of Karabor
{ 6, 30110 }, -- Coral Band of the Revived
{ 7, 33498 }, -- Signet of the Quiet Forest
{ 8, 29308 }, -- Band of Eternity (revered)
{ 9, 32238 }, -- Ring of Calming Waves
{ 10, 34890 }, -- Anveena's Touch
{ 11, 29290 }, -- Violet Signet of the Grand Restorer
{ 12, 29306 }, -- Band of Eternity (honored)
{ 13, 29291 }, -- Violet Signet
{ 14, 28790 }, -- Naaru Lightwarden's Band
{ 15, 35130 }, -- Guardian's Band of Salvation
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34170 }, -- Pantaloons of Calming Strife
{ 2, 34925 }, -- Adorned Supernal Legwraps
{ 3, 30912 }, -- Leggings of Eternity
{ 4, 31068 }, -- Breeches of Absolution
{ 5, 30153 }, -- Breeches of the Avatar
{ 6, 29977 }, -- Star-Soul Breeches
{ 7, 30727 }, -- Gilded Trousers of Benediction
{ 8, 28742 }, -- Pantaloons of Repentance
{ 9, 29053 }, -- Trousers of the Incarnate
{ 10, 33585 }, -- Achromic Trousers of the Naaru
{ 11, 30543 }, -- Pontifex Kilt
{ 12, 35055 }, -- Brutal Gladiator's Mooncloth Leggings
{ 13, 34386 }, -- Pantaloons of Growing Strife
{ 14, 31343 }, -- Kamaei's Cerulean Skirt
{ 15, 28218 }, -- Pontiff's Pantaloons of Prophecy
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34562 }, -- Boots of Absolution
{ 2, 34926 }, -- Slippers of Dutiful Mending
{ 3, 30885 }, -- Archbishop's Slippers
{ 4, 32609 }, -- Boots of the Divine Light
{ 5, 30100 }, -- Soul-Strider Boots
{ 6, 30035 }, -- Boots of the Long Road
{ 7, 33471 }, -- Two-toed Sandals
{ 8, 28663 }, -- Boots of the Incorrupt
{ 9, 30680 }, -- Glider's Foot-Wraps of the Prophet
{ 10, 34563 }, -- Treads of Absolution
{ 11, 35144 }, -- Guardian's Mooncloth Slippers
{ 12, 29251 }, -- Boots of the Pious
{ 13, 25792 }, -- Curate's Boots
{ 14, 33902 }, -- Vindicator's Mooncloth Slippers
{ 15, 27411 }, -- Slippers of Serenity
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 28823 }, -- Eye of Gruul
{ 2, 32496 }, -- Memento of Tyrande
{ 3, 30665 }, -- Earring of Soulful Meditation
{ 4, 34430 }, -- Glimmering Naaru Sliver
{ 5, 28370 }, -- Bangle of Endless Blessings
{ 6, 29376 }, -- Essence of the Martyr
{ 7, 38288 }, -- Direbrew Hops
{ 8, 19288 }, -- Darkmoon Card: Blue Dragon
{ 9, 28727 }, -- Pendant of the Violet Eye
{ 10, 33828 }, -- Tome of Diabolic Remedy
{ 11, 28190 }, -- Scarab of the Infinite Cycle
{ 12, 30841 }, -- Lower City Prayerbook
{ 13, 23047 }, -- Eye of the Dead
{ 14, 19395 }, -- Rejuvenating Gem
{ 15, 25634 }, -- Oshu'gun Relic
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34335 }, -- Hammer of Sanctification
{ 2, 34199 }, -- Archon's Gavel
{ 3, 35082 }, -- Brutal Gladiator's Salvation
{ 4, 32500 }, -- Crystal Spire of Karabor
{ 5, 34896 }, -- Gavel of Naaru Blessings
{ 6, 30108 }, -- Lightfathom Scepter
{ 7, 33743 }, -- Vengeful Gladiator's Salvation
{ 8, 30918 }, -- Hammer of Atonement
{ 9, 33468 }, -- Dark Blessing
{ 10, 32964 }, -- Merciless Gladiator's Salvation
{ 11, 28771 }, -- Light's Justice
{ 12, 32451 }, -- Gladiator's Salvation
{ 13, 28522 }, -- Shard of the Virtuous
{ 14, 23556 }, -- Hand of Eternity
{ 15, 29353 }, -- Shockwave Truncheon
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34206 }, -- Book of Highborne Hymns
{ 2, 30911 }, -- Scepter of Purification
{ 3, 33325 }, -- Voodoo Shaker
{ 4, 32350 }, -- Touch of Inspiration
{ 5, 35074 }, -- Brutal Gladiator's Reprieve
{ 6, 29923 }, -- Talisman of the Sun King
{ 7, 28525 }, -- Signet of Unshakable Faith
{ 8, 29170 }, -- Windcaller's Orb
{ 9, 28728 }, -- Aran's Soothing Sapphire
{ 10, 33736 }, -- Vengeful Gladiator's Reprieve
{ 11, 31493 }, -- Netherwing Spiritualist's Charm
{ 12, 32961 }, -- Merciless Gladiator's Reprieve
{ 13, 23029 }, -- Noth's Frigid Heart
{ 14, 28213 }, -- Lordaeron Medical Guide
{ 15, 29274 }, -- Tears of Heaven
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34337 }, -- Golden Staff of the Sin'dorei
{ 2, 30908 }, -- Apostle of Argus
{ 3, 32344 }, -- Staff of Immaculate Recovery
{ 4, 29981 }, -- Ethereum Life-Staff
{ 5, 33490 }, -- Staff of Dark Mending
{ 6, 34608 }, -- Rod of the Blazing Light
{ 7, 30732 }, -- Exodar Life-Staff
{ 8, 28782 }, -- Crystalheart Pulse-Staff
{ 9, 28604 }, -- Nightstaff of the Everliving
{ 10, 22631 }, -- Atiesh, Greatstaff of the Guardian
{ 11, 27791 }, -- Serpentcrest Life-Staff
{ 12, 29133 }, -- Seer's Cane
{ 13, 30012 }, -- Ameer's Judgement
{ 14, 31289 }, -- Staff of Divine Infusion
{ 15, 28033 }, -- Epoch-Mender
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
{ 1, 34348 }, -- Wand of Cleansing Light
{ 2, 32363 }, -- Naaru-Blessed Life Rod
{ 3, 30080 }, -- Luminescent Rod of the Naaru
{ 4, 28588 }, -- Blue Diamond Witchwand
{ 5, 34985 }, -- Brutal Gladiator's Baton of Light
{ 6, 34059 }, -- Vengeful Gladiator's Baton of Light
{ 7, 27885 }, -- Soul-Wand of the Aldor
{ 8, 23009 }, -- Wand of the Whispering Dead
{ 9, 34347 }, -- Wand of the Demonsoul
{ 10, 24380 }, -- Calming Spore Reed
{ 11, 33192 }, -- Carved Witch Doctor's Stick
{ 12, 29779 }, -- Rejuvenating Scepter
{ 13, 30724 }, -- Barrel-Blade Longrifle
{ 14, 28783 }, -- Eredar Wand of Obliteration
{ 15, 27540 }, -- Nexus Torch
},
},




--@end-version-bcc@
},
}





data["ShamanEle"] = {
	name = AL["Shaman Ele BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34332 }, -- Cowl of Gul'dan
{ 2, 34340 }, -- Dark Conjuror's Collar
{ 3, 34355 }, -- Lightning Etched Specs
{ 4, 34403 }, -- Cover of Ursoc the Mighty
{ 5, 34405 }, -- Helm of Arcane Purity
{ 6, 35182 }, -- Hyper-Magnified Moon Specs
{ 7, 32525 }, -- Cowl of the Illidari High Lord
{ 8, 31014 }, -- Skyshatter Headguard
{ 9, 35050 }, -- Brutal Gladiator's Mail Helm
{ 10, 30171 }, -- Cataclysm Headpiece
{ 11, 32476 }, -- Gadgetstorm Goggles
{ 12, 32480 }, -- Magnified Moon Specs
{ 13, 33713 }, -- Vengeful Gladiator's Mail Helm
{ 14, 33453 }, -- Hood of Hexing
{ 15, 29986 }, -- Cowl of the Grand Engineer
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34359 }, -- Pendant of Sunfire
{ 2, 34204 }, -- Amulet of Unfettered Magics
{ 3, 37928 }, -- Guardian's Pendant of Subjugation
{ 4, 33281 }, -- Brooch of Nature's Mercy
{ 5, 34360 }, -- Amulet of Flowing Life
{ 6, 33466 }, -- Loop of Cursed Bones
{ 7, 32349 }, -- Translucent Spellthread Necklace
{ 8, 37929 }, -- Guardian's Pendant of Reprieve
{ 9, 30015 }, -- The Sun King's Talisman
{ 10, 35319 }, -- Vindicator's Pendant of Subjugation
{ 11, 35132 }, -- Guardian's Pendant of Conquest
{ 12, 24121 }, -- Chain of the Twilight Owl (GROUP BUFF)
{ 13, 24116 }, -- Eye of the Night (GROUP BUFF)
{ 14, 35290 }, -- Sin'dorei Pendant of Conquest
{ 15, 35317 }, -- Vindicator's Pendant of Reprieve
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34210 }, -- Amice of the Convoker
{ 2, 34390 }, -- Erupting Epaulets
{ 3, 34391 }, -- Spaulders of Devastation
{ 4, 34393 }, -- Shoulderpads of Knowledge's Pursuit
{ 5, 32587 }, -- Mantle of Nimble Thought
{ 6, 31023 }, -- Skyshatter Mantle
{ 7, 30884 }, -- Hatefury Mantle
{ 8, 33489 }, -- Mantle of Ill Intent
{ 9, 33970 }, -- Pauldrons of the Furious Elements
{ 10, 32338 }, -- Blood-cursed Shoulderpads
{ 11, 35052 }, -- Brutal Gladiator's Mail Spaulders
{ 12, 30173 }, -- Cataclysm Shoulderpads
{ 13, 30079 }, -- Illidari Shoulderpads
{ 14, 33973 }, -- Pauldrons of Tribal Fury
{ 15, 33715 }, -- Vengeful Gladiator's Mail Spaulders
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34242 }, -- Tattered Cape of Antonidas
{ 2, 32524 }, -- Shroud of the Highborne
{ 3, 32331 }, -- Cloak of the Illidari Council
{ 4, 33591 }, -- Shadowcaster's Drape
{ 5, 30735 }, -- Ancient Spellcloak of the Highborne
{ 6, 33592 }, -- Cloak of Ancient Rituals
{ 7, 28797 }, -- Brute Cloak of the Ogre-Magi
{ 8, 35321 }, -- Cloak of Arcane Alacrity
{ 9, 29992 }, -- Royal Cloak of the Sunstriders
{ 10, 31201 }, -- Illidari Cloak of Wrath
{ 11, 33304 }, -- Cloak of Subjugated Power
{ 12, 23050 }, -- Cloak of the Necropolis
{ 13, 29369 }, -- Shawl of Shifting Probabilities
{ 14, 35497 }, -- Cloak of the Frigid Winds
{ 15, 28766 }, -- Ruby Drape of the Mysticant
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34364 }, -- Sunfire Robe
{ 2, 34396 }, -- Garments of Crashing Shores
{ 3, 34232 }, -- Fel Conquerer Raiments
{ 4, 34399 }, -- Robes of Ghostly Hatred
{ 5, 34398 }, -- Utopian Tunic of Elune
{ 6, 34933 }, -- Hauberk of Whirling Fury
{ 7, 31017 }, -- Skyshatter Breastplate
{ 8, 33965 }, -- Hauberk of the Furious Elements
{ 9, 30107 }, -- Vestments of the Sea-Witch
{ 10, 34936 }, -- Tormented Demonsoul Robes
{ 11, 30913 }, -- Robes of Rhonin
{ 12, 32592 }, -- Chestguard of Relentless Storms
{ 13, 35048 }, -- Brutal Gladiator's Mail Armor
{ 14, 34610 }, -- Scarlet Sin'dorei Robes
{ 15, 30056 }, -- Robe of Hateful Echoes
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34437 }, -- Skyshatter Bands
{ 2, 32586 }, -- Bracers of Nimble Thought
{ 3, 33588 }, -- Runed Spell-cuffs
{ 4, 35173 }, -- Guardian's Mail Bracers
{ 5, 30870 }, -- Cuffs of Devastation
{ 6, 30684 }, -- Ravager's Cuffs of Wrath
{ 7, 32259 }, -- Bands of the Coming Storm
{ 8, 33897 }, -- Vindicator's Mail Bracers
{ 9, 29918 }, -- Mindstorm Wristbands
{ 10, 33578 }, -- Armwraps of the Kaldorei Protector
{ 11, 33285 }, -- Fury of the Ursine
{ 12, 32270 }, -- Focused Mana Bindings
{ 13, 29523 }, -- Windhawk Bracers
{ 14, 32655 }, -- Crystalweave Bracers
{ 15, 32817 }, -- Veteran's Mail Bracers
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34344 }, -- Handguards of Defiled Worlds
{ 2, 34406 }, -- Gloves of Tyri's Power
{ 3, 34350 }, -- Gauntlets of the Ancient Shadowmoon
{ 4, 34366 }, -- Sunfire Handwraps
{ 5, 34407 }, -- Tranquil Moonlight Wraps
{ 6, 31008 }, -- Skyshatter Gauntlets
{ 7, 34938 }, -- Enslaved Doomguard Soulgrips
{ 8, 33586 }, -- Studious Wraps
{ 9, 30725 }, -- Anger-Spark Gloves
{ 10, 33534 }, -- Grips of Nature's Wrath
{ 11, 33974 }, -- Grasp of the Moonkin
{ 12, 35049 }, -- Brutal Gladiator's Mail Gauntlets
{ 13, 28780 }, -- Soul-Eater's Handwraps
{ 14, 34376 }, -- Sun-Drenched Scale Gloves
{ 15, 29987 }, -- Gauntlets of the Sun King
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34542 }, -- Skyshatter Cord
{ 2, 32276 }, -- Flashfire Girdle
{ 3, 34935 }, -- Aftershock Waistguard
{ 4, 32256 }, -- Waistwrap of Infinity
{ 5, 30038 }, -- Belt of Blasting
{ 6, 30888 }, -- Anetheron's Noose
{ 7, 30914 }, -- Belt of the Crescent Moon
{ 8, 33559 }, -- Starfire Waistband
{ 9, 30064 }, -- Cord of Screaming Terrors
{ 10, 24256 }, -- Girdle of Ruination
{ 11, 30675 }, -- Lurker's Cord of the Wrath
{ 12, 33291 }, -- Voodoo-woven Belt
{ 13, 33536 }, -- Stormwrap
{ 14, 35158 }, -- Guardian's Mail Girdle
{ 15, 30044 }, -- Monsoon Belt
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34230 }, -- Ring of Omnipotence
{ 2, 34362 }, -- Loop of Forged Power
{ 3, 32527 }, -- Ring of Ancient Knowledge
{ 4, 33497 }, -- Mana Attuned Band
{ 5, 29305 }, -- Band of the Eternal Sage
{ 6, 32247 }, -- Ring of Captured Storms
{ 7, 32528 }, -- Blessed Band of Karabor
{ 8, 34363 }, -- Ring of Flowing Life
{ 9, 33498 }, -- Signet of the Quiet Forest
{ 10, 30667 }, -- Ring of Unrelenting Storms (Nature)
{ 11, 35282 }, -- Sin'dorei Band of Dominance
{ 12, 29304 }, -- Band of Eternity (revered)
{ 13, 34166 }, -- Band of Lucent Beams
{ 14, 29303 }, -- Band of Eternity (honored)
{ 15, 30109 }, -- Ring of Endless Coils
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34181 }, -- Leggings of Calamity
{ 2, 34186 }, -- Chain Links of the Tumultuous Storm
{ 3, 34386 }, -- Pantaloons of Growing Strife
{ 4, 34169 }, -- Breeches of Natural Aggression
{ 5, 34934 }, -- Rushing Storm Kilt
{ 6, 30916 }, -- Leggings of Channeled Elements
{ 7, 34937 }, -- Corrupted Soulcloth Pantaloons
{ 8, 33584 }, -- Pantaloons of Arcane Annihilation
{ 9, 31020 }, -- Skyshatter Legguards
{ 10, 30734 }, -- Leggings of the Seventh Circle
{ 11, 34905 }, -- Crystalwind Leggings
{ 12, 33971 }, -- Elunite Imbued Leggings
{ 13, 33533 }, -- Avalanche Leggings
{ 14, 32367 }, -- Leggings of Devastation
{ 15, 24262 }, -- Spellstrike Pants
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34566 }, -- Skyshatter Treads
{ 2, 32239 }, -- Slippers of the Seacaller
{ 3, 33357 }, -- Footpads of Madness
{ 4, 32242 }, -- Boots of Oceanic Fury
{ 5, 32352 }, -- Naturewarden's Treads
{ 6, 33537 }, -- Treads of Booming Thunder
{ 7, 30680 }, -- Glider's Foot-Wraps of Wrath
{ 8, 35143 }, -- Guardian's Mail Sabatons
{ 9, 30067 }, -- Velvet Boots of the Guardian
{ 10, 33577 }, -- Moon-walkers
{ 11, 30037 }, -- Boots of Blasting
{ 12, 30894 }, -- Blue Suede Shoes
{ 13, 34919 }, -- Boots of Incantations
{ 14, 28517 }, -- Boots of Foretelling
{ 15, 30043 }, -- Hurricane Boots
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 34429 }, -- Shifting Naaru Sliver
{ 2, 32483 }, -- The Skull of Gul'dan
{ 3, 30626 }, -- Sextant of Unstable Currents
{ 4, 33829 }, -- Hex Shrunken Head
{ 5, 23207 }, -- Mark of the Champion (undead/demon)
{ 6, 27683 }, -- Quagmirran's Eye
{ 7, 31856 }, -- Darkmoon Card: Crusade
{ 8, 28789 }, -- Eye of Magtheridon
{ 9, 34470 }, -- Timbal's Focusing Crystal
{ 10, 29370 }, -- Icon of the Silver Crescent
{ 11, 38290 }, -- Dark Iron Smoking Pipe
{ 12, 28418 }, -- Shiffar's Nexus-Horn
{ 13, 23046 }, -- The Restrained Essence of Sapphiron
{ 14, 29179 }, -- Xi'ri's Gift
{ 15, 19379 }, -- Neltharion's Tear
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34336 }, -- Sunflare
{ 2, 34176 }, -- Reign of Misery
{ 3, 35014 }, -- Brutal Gladiator's Gavel
{ 4, 35102 }, -- Brutal Gladiator's Spellblade
{ 5, 32237 }, -- The Maelstrom's Fury
{ 6, 33687 }, -- Vengeful Gladiator's Gavel
{ 7, 33763 }, -- Vengeful Gladiator's Spellblade
{ 8, 34895 }, -- Scryer's Blade of Focus
{ 9, 34009 }, -- Hammer of Judgement
{ 10, 33354 }, -- Wub's Cursed Hexblade
{ 11, 32053 }, -- Merciless Gladiator's Spellblade
{ 12, 32963 }, -- Merciless Gladiator's Gavel
{ 13, 30723 }, -- Talon of the Tempest
{ 14, 33283 }, -- Amani Punisher
{ 15, 28770 }, -- Nathrezim Mindblade

},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34179 }, -- Heart of the Pit
{ 2, 30872 }, -- Chronicle of Dark Secrets
{ 3, 30909 }, -- Antonidas's Aegis of Rapt Concentration
{ 4, 33334 }, -- Fetish of the Primal Gods
{ 5, 30049 }, -- Fathomstone
{ 6, 32361 }, -- Blind-Seers Icon
{ 7, 29273 }, -- Khadgar's Knapsack
{ 8, 34986 }, -- Brutal Gladiator's Barrier
{ 9, 35008 }, -- Brutal Gladiator's Endgame
{ 10, 28603 }, -- Talisman of Nightbane
{ 11, 25099 }, -- Draenei Crystal Rod of Wrath
{ 12, 32533 }, -- Karrog's Shard
{ 13, 29268 }, -- Mazthoril Honor Shield
{ 14, 34011 }, -- Illidari Runeshield
{ 15, 28781 }, -- Karaborian Talisman
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 32374 }, -- Zhar'doom, Greatstaff of the Devourer
{ 2, 34182 }, -- Grand Magister's Staff of Torrents
{ 3, 34987 }, -- Brutal Gladiator's Battle Staff
{ 4, 35109 }, -- Brutal Gladiator's War Staff
{ 5, 34540 }, -- Vengeful Gladiator's Battle Staff
{ 6, 33766 }, -- Vengeful Gladiator's War Staff
{ 7, 29988 }, -- The Nexus Key
{ 8, 33494 }, -- Amani Divining Staff
{ 9, 32055 }, -- Merciless Gladiator's War Staff
{ 10, 24557 }, -- Gladiator's War Staff
{ 11, 35514 }, -- Frostscythe of Lord Ahune
{ 12, 29355 }, -- Terokk's Shadowstaff
{ 13, 28633 }, -- Staff of Infinite Mysteries
{ 14, 32854 }, -- Hammer of Righteous Might
{ 15, 34797 }, -- Sun-infused Focus Staff
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
 
},
},




--@end-version-bcc@
},
}



data["ShamanEnh"] = {
	name = AL["Shaman Enh BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34244 }, -- Duplicitous Guise
{ 2, 34333 }, -- Coif of Alleria
{ 3, 32235 }, -- Cursed Vision of Sargeras
{ 4, 34356 }, -- Surestrike Goggles v3.0
{ 5, 35044 }, -- Brutal Gladiator's Linked Helm
{ 6, 32376 }, -- Forest Prowler's Helm
{ 7, 31015 }, -- Skyshatter Cover
{ 8, 34404 }, -- Mask of the Fury Hunter
{ 9, 30190 }, -- Cataclysm Helm
{ 10, 32474 }, -- Surestrike Goggles v2.0
{ 11, 33708 }, -- Vengeful Gladiator's Linked Helm
{ 12, 32087 }, -- Mask of the Deceiver
{ 13, 33479 }, -- Grimgrin Faceguard
{ 14, 32006 }, -- Merciless Gladiator's Linked Helm
{ 15, 28182 }, -- Helm of the Claw
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34358 }, -- Hard Khorium Choker
{ 2, 34177 }, -- Clutch of Demise
{ 3, 32260 }, -- Choker of Endless Nightmares
{ 4, 24114 }, -- Braided Eternium Chain (GROUP BUFF)
{ 5, 32591 }, -- Choker of Serrated Blades
{ 6, 35135 }, -- Guardian's Pendant of Triumph
{ 7, 35292 }, -- Sin'dorei Pendant of Triumph
{ 8, 30017 }, -- Telonicus's Pendant of Mayhem
{ 9, 30022 }, -- Pendant of the Perilous
{ 10, 29381 }, -- Choker of Vile Intent
{ 11, 35507 }, -- Amulet of Bitter Hatred
{ 12, 28509 }, -- Worgen Claw Necklace
{ 13, 30059 }, -- Choker of Animalistic Fury
{ 14, 33923 }, -- Vindicator's Pendant of Triumph
{ 15, 33296 }, -- Brooch of Deftness
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34195 }, -- Shoulderpads of Vehemence
{ 2, 34194 }, -- Mantle of the Golden Forest
{ 3, 34392 }, -- Demontooth Shoulderpads
{ 4, 32581 }, -- Swiftstrike Shoulders
{ 5, 32575 }, -- Shoulders of Lightning Reflexes
{ 6, 32377 }, -- Mantle of Darkness
{ 7, 30055 }, -- Shoulderpads of the Stranger
{ 8, 32264 }, -- Shoulders of the Hidden Predator
{ 9, 33206 }, -- Pauldrons of Primal Fury
{ 10, 31024 }, -- Skyshatter Pauldrons
{ 11, 34613 }, -- Shoulderpads of the Silvermoon Retainer
{ 12, 30917 }, -- Razorfury Mantle
{ 13, 30085 }, -- Mantle of the Tireless Tracker
{ 14, 35046 }, -- Brutal Gladiator's Linked Spaulders
{ 15, 33300 }, -- Shoulderpads of Dancing Blades
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34241 }, -- Cloak of Unforgivable Sin
{ 2, 32323 }, -- Shadowmoon Destroyer's Drape
{ 3, 33590 }, -- Cloak of Fiends
{ 4, 29994 }, -- Thalassian Wildercloak
{ 5, 30098 }, -- Razor-Scale Battlecloak
{ 6, 33484 }, -- Dory's Embrace
{ 7, 30729 }, -- Black-Iron Battlecloak
{ 8, 24259 }, -- Vengeance Wrap
{ 9, 33122 }, -- Cloak of Darkness (melee)
{ 10, 28672 }, -- Drape of the Dark Reavers
{ 11, 28777 }, -- Cloak of the Pit Stalker
{ 12, 34708 }, -- Cloak of the Coming Night
{ 13, 27878 }, -- Auchenai Death Shroud
{ 14, 28529 }, -- Royal Cloak of Arathi Kings
{ 15, 27892 }, -- Cloak of the Inciter
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34369 }, -- Carapace of Sun and Shadow
{ 2, 34397 }, -- Bladed Chaos Tunic
{ 3, 34211 }, -- Harness of Carnal Instinct
{ 4, 30905 }, -- Midnight Chestguard
{ 5, 34927 }, -- Tunic of the Dark Hour
{ 6, 32252 }, -- Nether Shadow Tunic
{ 7, 34912 }, -- Scaled Drakeskin Chestguard
{ 8, 30101 }, -- Bloodsea Brigand's Vest
{ 9, 35042 }, -- Brutal Gladiator's Linked Armor
{ 10, 30907 }, -- Mail of Fevered Pursuit
{ 11, 30730 }, -- Terrorweave Tunic
{ 12, 34906 }, -- Embrace of Everlasting Prowess
{ 13, 30185 }, -- Cataclysm Chestplate
{ 14, 33329 }, -- Shadowtooth Trollskin Cuirass
{ 15, 31018 }, -- Skyshatter Tunic
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34439 }, -- Skyshatter Wristguards
{ 2, 32574 }, -- Bindings of Lightning Reflexes
{ 3, 30863 }, -- Deadly Cuffs
{ 4, 32324 }, -- Insidious Bands
{ 5, 32580 }, -- Swiftstrike Bracers
{ 6, 33540 }, -- Master Assassin Wristwraps
{ 7, 32251 }, -- Wraps of Precise Flight
{ 8, 35172 }, -- Guardian's Linked Bracers
{ 9, 33529 }, -- Steadying Bracers
{ 10, 35166 }, -- Guardian's Chain Bracers
{ 11, 33894 }, -- Vindicator's Linked Bracers
{ 12, 30091 }, -- True-Aim Stalker Bands
{ 13, 30026 }, -- Bands of the Celestial Archer
{ 14, 30685 }, -- Ravager's Wrist-Wraps of the Tiger
{ 15, 29966 }, -- Vambraces of Ending
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34343 }, -- Thalassian Ranger Gauntlets
{ 2, 34370 }, -- Gloves of Immortal Dusk
{ 3, 34234 }, -- Shadowed Gauntlets of Paroxysm
{ 4, 34374 }, -- Fletcher's Gloves of the Phoenix
{ 5, 34408 }, -- Gloves of the Forest Drifter
{ 6, 32347 }, -- Grips of Damnation
{ 7, 32234 }, -- Fists of Mukoa
{ 8, 34916 }, -- Gauntlets of Rapidity
{ 9, 29947 }, -- Gloves of the Searing Grip
{ 10, 33539 }, -- Trickster's Stickyfingers
{ 11, 34911 }, -- Handwraps of the Aggressor
{ 12, 31011 }, -- Skyshatter Grips
{ 13, 30189 }, -- Cataclysm Gauntlets
{ 14, 33528 }, -- Gauntlets of Sniping
{ 15, 30644 }, -- Grips of Deftness
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34545 }, -- Skyshatter Girdle
{ 2, 30106 }, -- Belt of One-Hundred Deaths
{ 3, 32346 }, -- Boneweave Girdle
{ 4, 32265 }, -- Shadow-walker's Cord
{ 5, 30919 }, -- Valestalker Girdle
{ 6, 34929 }, -- Belt of the Silent Path
{ 7, 30879 }, -- Don Alejandro's Money Belt
{ 8, 30040 }, -- Belt of Deep Shadow
{ 9, 33583 }, -- Waistguard of the Great Beast
{ 10, 33211 }, -- Bladeangel's Money Belt
{ 11, 30046 }, -- Belt of the Black Eagle
{ 12, 35157 }, -- Guardian's Linked Girdle
{ 13, 28828 }, -- Gronn-Stitched Girdle
{ 14, 30676 }, -- Lurker's Grasp of the Tiger
{ 15, 35151 }, -- Guardian's Chain Girdle
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34189 }, -- Band of Ruinous Delight
{ 2, 34361 }, -- Hard Khorium Band
{ 3, 32497 }, -- Stormrage Signet Ring
{ 4, 34887 }, -- Angelista's Revenge
{ 5, 33496 }, -- Signet of Primal Wrath
{ 6, 29301 }, -- Band of the Eternal Champion
{ 7, 29997 }, -- Band of the Ranger-General
{ 8, 32335 }, -- Unstoppable Aggressor's Ring
{ 9, 32526 }, -- Band of Devastation
{ 10, 32266 }, -- Ring of Deceitful Intent
{ 11, 30052 }, -- Ring of Lethality
{ 12, 30738 }, -- Ring of Reciprocity
{ 13, 35131 }, -- Guardian's Band of Triumph
{ 14, 28757 }, -- Ring of a Thousand Marks
{ 15, 29300 }, -- Band of Eternity (revered)
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34188 }, -- Leggings of the Immortal Night
{ 2, 34168 }, -- Starstalker Legguards
{ 3, 34385 }, -- Leggings of the Immortal Beast
{ 4, 30900 }, -- Bow-stitched Leggings
{ 5, 30898 }, -- Shady Dealer's Pantaloons
{ 6, 34910 }, -- Tameless Breeches
{ 7, 33538 }, -- Shallow-grave Trousers
{ 8, 29995 }, -- Leggings of Murderous Intent
{ 9, 35045 }, -- Brutal Gladiator's Linked Leggings
{ 10, 30739 }, -- Scaled Greaves of the Marksman
{ 11, 31021 }, -- Skyshatter Pants
{ 12, 28741 }, -- Skulker's Greaves
{ 13, 30192 }, -- Cataclysm Legplates
{ 14, 31544 }, -- Clefthoof Hide Leggings
{ 15, 33527 }, -- Shifting Camouflage Pants
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34567 }, -- Skyshatter Greaves
{ 2, 32510 }, -- Softstep Boots of Tracking
{ 3, 32366 }, -- Shadowmaster's Boots
{ 4, 33222 }, -- Nyn'jah's Tabi Boots
{ 5, 30880 }, -- Quickstrider Moccasins
{ 6, 30891 }, -- Black Featherlight Boots
{ 7, 30039 }, -- Boots of Utter Darkness
{ 8, 34809 }, -- Sunrage Treads
{ 9, 30104 }, -- Cobra-Lash Boots
{ 10, 35142 }, -- Guardian's Linked Sabatons
{ 11, 28545 }, -- Edgewalker Longboots
{ 12, 33582 }, -- Footwraps of Wild Encroachment
{ 13, 29951 }, -- Star-Strider Boots
{ 14, 25686 }, -- Fel Leather Boots
{ 15, 30041 }, -- Boots of Natural Grace
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 28830 }, -- Dragonspine Trophy
{ 2, 34427 }, -- Blackened Naaru Sliver
{ 3, 34472 }, -- Shard of Contempt
{ 4, 32505 }, -- Madness of the Betrayer
{ 5, 31856 }, -- Darkmoon Card: Crusade
{ 6, 34428 }, -- Steely Naaru Sliver
{ 7, 23206 }, -- Mark of the Champion (undead/demon)
{ 8, 33831 }, -- Berserker's Call
{ 9, 32491 }, -- Ashtongue Talisman of Vision
{ 10, 30627 }, -- Tsunami Talisman
{ 11, 35702 }, -- Figurine - Shadowsong Panther
{ 12, 29383 }, -- Bloodlust Brooch
{ 13, 23041 }, -- Slayer's Crest
{ 14, 28288 }, -- Abacus of Violent Odds
{ 15, 28034 }, -- Hourglass of the Unraveller
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34331 }, -- Hand of the Deceiver
{ 2, 34203 }, -- Grip of Mannoroth
{ 3, 34346 }, -- Mounting Vengeance
{ 4, 34988 }, -- Brutal Gladiator's Bonecracker
{ 5, 35017 }, -- Brutal Gladiator's Hacker
{ 6, 35038 }, -- Brutal Gladiator's Left Ripper
{ 7, 35076 }, -- Brutal Gladiator's Right Ripper
{ 8, 34995 }, -- Brutal Gladiator's Chopper
{ 9, 35037 }, -- Brutal Gladiator's Left Render
{ 10, 34996 }, -- Brutal Gladiator's Cleaver
{ 11, 35071 }, -- Brutal Gladiator's Pummeler
{ 12, 34950 }, -- Vanir's Left Fist of Savagery
{ 13, 34951 }, -- Vanir's Left Fist of Brutality
{ 14, 34893 }, -- Vanir's Right Fist of Brutality
{ 15, 32943 }, -- Swiftsteel Bludgeon
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
 
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
 
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
 
},
},




--@end-version-bcc@
},
}

data["ShamanResto"] = {
	name = AL["Shaman Resto BiS"],
	ContentType = SET_CONTENT,

items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34402 }, -- Shroud of Chieftain Ner'zhul
{ 2, 34339 }, -- Cowl of Light's Purity
{ 3, 34245 }, -- Cover of Ursol the Wise
{ 4, 35184 }, -- Primal-Attuned Goggles
{ 5, 35183 }, -- Wonderheal XT68 Shades
{ 6, 31012 }, -- Skyshatter Helmet
{ 7, 32241 }, -- Helm of Soothing Currents
{ 8, 35181 }, -- Powerheal 9000 Lens
{ 9, 32240 }, -- Guise of the Tidal Lurker
{ 10, 35079 }, -- Brutal Gladiator's Ringmail Helm
{ 11, 32475 }, -- Living Replicator Specs
{ 12, 30166 }, -- Cataclysm Headguard
{ 13, 33286 }, -- Mojo-mender's Mask
{ 14, 32329 }, -- Cowl of Benevolence
{ 15, 33463 }, -- Hood of the Third Eye
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34360 }, -- Amulet of Flowing Life
{ 2, 33281 }, -- Brooch of Nature's Mercy
{ 3, 34184 }, -- Brooch of the Highborne
{ 4, 37929 }, -- Guardian's Pendant of Reprieve
{ 5, 35317 }, -- Vindicator's Pendant of Reprieve
{ 6, 32370 }, -- Nadina's Pendant of Purity
{ 7, 35291 }, -- Sin'dorei Pendant of Salvation
{ 8, 30018 }, -- Lord Sanguinar's Claim
{ 9, 35134 }, -- Guardian's Pendant of Salvation
{ 10, 34359 }, -- Pendant of Sunfire
{ 11, 30726 }, -- Archaic Charm of Presence
{ 12, 28609 }, -- Emberspur Talisman
{ 13, 33922 }, -- Vindicator's Pendant of Salvation
{ 14, 34677 }, -- Shattered Sun Pendant of Restoration
{ 15, 33068 }, -- Veteran's Pendant of Salvation
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34202 }, -- Shawl of Wonderment
{ 2, 34208 }, -- Equilibrium Epaulets
{ 3, 34209 }, -- Spaulders of Reclamation
{ 4, 32579 }, -- Living Earth Shoulders
{ 5, 32583 }, -- Shoulderpads of Renewed Life
{ 6, 33464 }, -- Hex Lord's Voodoo Pauldrons
{ 7, 31022 }, -- Skyshatter Shoulderpads
{ 8, 32585 }, -- Swiftheal Mantle
{ 9, 35081 }, -- Brutal Gladiator's Ringmail Spaulders
{ 10, 30168 }, -- Cataclysm Shoulderguards
{ 11, 30097 }, -- Coral-Barbed Shoulderpads
{ 12, 33742 }, -- Vengeful Gladiator's Ringmail Spaulders
{ 13, 34210 }, -- Amice of the Convoker
{ 14, 33287 }, -- Gnarled Ironwood Pauldrons
{ 15, 32517 }, -- The Wavemender's Mantle
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 32524 }, -- Shroud of the Highborne
{ 2, 33592 }, -- Cloak of Ancient Rituals
{ 3, 34205 }, -- Shroud of Redeemed Souls
{ 4, 34242 }, -- Tattered Cape of Antonidas
{ 5, 34012 }, -- Shroud of the Final Stand
{ 6, 34702 }, -- Cloak of Swift Mending
{ 7, 35324 }, -- Cloak of Swift Reprieve
{ 8, 29989 }, -- Sunshower Light Cloak
{ 9, 32337 }, -- Shroud of Forgiveness
{ 10, 31329 }, -- Lifegiving Cloak
{ 11, 28765 }, -- Stainless Cloak of the Pure Hearted
{ 12, 24254 }, -- White Remedy Cape
{ 13, 28582 }, -- Red Riding Hood's Cloak
{ 14, 33333 }, -- Kharmaa's Shroud of Hope
{ 15, 27448 }, -- Cloak of the Everliving
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34375 }, -- Sun-Drenched Scale Chestguard
{ 2, 34365 }, -- Robe of Eternal Light
{ 3, 34212 }, -- Sunglow Vest
{ 4, 34229 }, -- Garments of Serene Shores
{ 5, 34233 }, -- Robes of Faltered Light
{ 6, 34371 }, -- Leather Chestguard of the Sun
{ 7, 33469 }, -- Hauberk of the Empire's Champion
{ 8, 35077 }, -- Brutal Gladiator's Ringmail Armor
{ 9, 31016 }, -- Skyshatter Chestguard
{ 10, 34364 }, -- Sunfire Robe
{ 11, 34930 }, -- Wave of Life Chestguard
{ 12, 30164 }, -- Cataclysm Chestguard
{ 13, 33738 }, -- Vengeful Gladiator's Ringmail Armor
{ 14, 21875 }, -- Primal Mooncloth Robe
{ 15, 32340 }, -- Garments of Temperance
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34438 }, -- Skyshatter Bracers
{ 2, 32584 }, -- Swiftheal Wraps
{ 3, 32577 }, -- Living Earth Bindings
{ 4, 32582 }, -- Bracers of Renewed Life
{ 5, 30869 }, -- Howling Wind Bracers
{ 6, 35177 }, -- Guardian's Ringmail Bracers
{ 7, 30684 }, -- Ravager's Cuffs of Healing
{ 8, 33589 }, -- Wristguards of Tranquil Thought
{ 9, 30868 }, -- Rejuvenating Bracers
{ 10, 30871 }, -- Bracers of Martyrdom
{ 11, 30047 }, -- Blackfathom Warbands
{ 12, 33906 }, -- Vindicator's Ringmail Bracers
{ 13, 34602 }, -- Eversong Cuffs
{ 14, 33557 }, -- Gargon's Bracers of Peaceful Slumber
{ 15, 33532 }, -- Gleaming Earthen Bracers
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34376 }, -- Sun-Drenched Scale Gloves
{ 2, 34372 }, -- Leather Gauntlets of the Sun
{ 3, 34409 }, -- Gauntlets of the Ancient Frostwolf
{ 4, 32328 }, -- Botanist's Gloves of Growth
{ 5, 34342 }, -- Handguards of the Dawn
{ 6, 32275 }, -- Spiritwalker Gauntlets
{ 7, 34351 }, -- Tranquil Majesty Wraps
{ 8, 34791 }, -- Gauntlets of the Tranquil Waves
{ 9, 34367 }, -- Hands of Eternal Light
{ 10, 32353 }, -- Gloves of Unfailing Faith
{ 11, 29976 }, -- Worldstorm Gauntlets
{ 12, 31007 }, -- Skyshatter Gloves
{ 13, 34344 }, -- Handguards of Defiled Worlds
{ 14, 34406 }, -- Gloves of Tyri's Power
{ 15, 35078 }, -- Brutal Gladiator's Ringmail Gauntlets
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34543 }, -- Skyshatter Belt
{ 2, 30895 }, -- Angelista's Sash
{ 3, 32258 }, -- Naturalist's Preserving Cinch
{ 4, 32339 }, -- Belt of Primal Majesty
{ 5, 33386 }, -- Man'kin'do's Belt
{ 6, 34932 }, -- Clutch of the Soothing Breeze
{ 7, 33480 }, -- Cord of Braided Troll Hair
{ 8, 33483 }, -- Life-step Belt
{ 9, 21873 }, -- Primal Mooncloth Belt
{ 10, 30030 }, -- Girdle of Fallen Stars
{ 11, 30675 }, -- Lurker's Cord of Healing
{ 12, 35162 }, -- Guardian's Ringmail Girdle
{ 13, 32519 }, -- Belt of Divine Guidance
{ 14, 29984 }, -- Girdle of Zaetar
{ 15, 29524 }, -- Windhawk Belt
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 32528 }, -- Blessed Band of Karabor
{ 2, 34363 }, -- Ring of Flowing Life
{ 3, 33498 }, -- Signet of the Quiet Forest
{ 4, 34166 }, -- Band of Lucent Beams
{ 5, 29309 }, -- Band of the Eternal Restorer
{ 6, 34625 }, -- Kharmaa's Ring of Fate
{ 7, 32238 }, -- Ring of Calming Waves
{ 8, 34890 }, -- Anveena's Touch
{ 9, 29308 }, -- Band of Eternity (revered)
{ 10, 30736 }, -- Ring of Flowing Light
{ 11, 28763 }, -- Jade Ring of the Everliving
{ 12, 35283 }, -- Sin'dorei Band of Salvation
{ 13, 35733 }, -- Ring of Harmonic Beauty
{ 14, 29306 }, -- Band of Eternity (honored)
{ 15, 34230 }, -- Ring of Omnipotence
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34383 }, -- Kilt of Spiritual Reconstruction
{ 2, 34170 }, -- Pantaloons of Calming Strife
{ 3, 34384 }, -- Breeches of Natural Splendor
{ 4, 33585 }, -- Achromic Trousers of the Naaru
{ 5, 30912 }, -- Leggings of Eternity
{ 6, 32271 }, -- Kilt of Immortal Nature
{ 7, 34931 }, -- Runed Scales of Antiquity
{ 8, 30893 }, -- Sun-touched Chain Leggings
{ 9, 30727 }, -- Gilded Trousers of Benediction
{ 10, 29991 }, -- Sunhawk Leggings
{ 11, 31019 }, -- Skyshatter Leggings
{ 12, 33530 }, -- Natural Life Leggings
{ 13, 34901 }, -- Grovewalker's Leggings
{ 14, 34925 }, -- Adorned Supernal Legwraps
{ 15, 35080 }, -- Brutal Gladiator's Ringmail Leggings
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34565 }, -- Skyshatter Boots
{ 2, 33471 }, -- Two-toed Sandals
{ 3, 33324 }, -- Treads of the Life Path
{ 4, 30737 }, -- Gold-Leaf Wildboots
{ 5, 30680 }, -- Glider's Foot-Wraps of Healing
{ 6, 34926 }, -- Slippers of Dutiful Mending
{ 7, 30873 }, -- Stillwater Boots
{ 8, 30092 }, -- Orca-Hide Boots
{ 9, 35147 }, -- Guardian's Ringmail Sabatons
{ 10, 34566 }, -- Skyshatter Treads
{ 11, 32609 }, -- Boots of the Divine Light
{ 12, 30100 }, -- Soul-Strider Boots
{ 13, 34707 }, -- Boots of Resuscitation
{ 14, 33908 }, -- Vindicator's Ringmail Sabatons
{ 15, 30035 }, -- Boots of the Long Road
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 32496 }, -- Memento of Tyrande
{ 2, 34430 }, -- Glimmering Naaru Sliver
{ 3, 29376 }, -- Essence of the Martyr
{ 4, 38288 }, -- Direbrew Hops
{ 5, 28190 }, -- Scarab of the Infinite Cycle
{ 6, 28823 }, -- Eye of Gruul
{ 7, 34429 }, -- Shifting Naaru Sliver
{ 8, 33828 }, -- Tome of Diabolic Remedy
{ 9, 23047 }, -- Eye of the Dead
{ 10, 25634 }, -- Oshu'gun Relic
{ 11, 34050 }, -- Battlemaster's Perseverance
{ 12, 34580 }, -- Battlemaster's Perseverance
{ 13, 30841 }, -- Lower City Prayerbook
{ 14, 19395 }, -- Rejuvenating Gem
{ 15, 27683 }, -- Quagmirran's Eye
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34335 }, -- Hammer of Sanctification
{ 2, 34199 }, -- Archon's Gavel
{ 3, 35082 }, -- Brutal Gladiator's Salvation
{ 4, 32500 }, -- Crystal Spire of Karabor
{ 5, 33468 }, -- Dark Blessing
{ 6, 34896 }, -- Gavel of Naaru Blessings
{ 7, 33743 }, -- Vengeful Gladiator's Salvation
{ 8, 30108 }, -- Lightfathom Scepter
{ 9, 30918 }, -- Hammer of Atonement
{ 10, 32964 }, -- Merciless Gladiator's Salvation
{ 11, 28771 }, -- Light's Justice
{ 12, 32451 }, -- Gladiator's Salvation
{ 13, 28522 }, -- Shard of the Virtuous
{ 14, 23556 }, -- Hand of Eternity
{ 15, 29353 }, -- Shockwave Truncheon

},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34206 }, -- Book of Highborne Hymns
{ 2, 34231 }, -- Aegis of Angelic Fortune
{ 3, 30882 }, -- Bastion of Light
{ 4, 32350 }, -- Touch of Inspiration
{ 5, 32255 }, -- Felstone Bulwark
{ 6, 33332 }, -- Enamelled Disc of Mojo
{ 7, 35073 }, -- Brutal Gladiator's Redoubt
{ 8, 35074 }, -- Brutal Gladiator's Reprieve
{ 9, 30911 }, -- Scepter of Purification
{ 10, 29274 }, -- Tears of Heaven
{ 11, 29458 }, -- Aegis of the Vindicator
{ 12, 29923 }, -- Talisman of the Sun King
{ 13, 33735 }, -- Vengeful Gladiator's Redoubt
{ 14, 33736 }, -- Vengeful Gladiator's Reprieve
{ 15, 28728 }, -- Aran's Soothing Sapphire
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34337 }, -- Golden Staff of the Sin'dorei
{ 2, 30908 }, -- Apostle of Argus
{ 3, 33490 }, -- Staff of Dark Mending
{ 4, 32344 }, -- Staff of Immaculate Recovery
{ 5, 30732 }, -- Exodar Life-Staff
{ 6, 29981 }, -- Ethereum Life-Staff
{ 7, 28782 }, -- Crystalheart Pulse-Staff
{ 8, 34608 }, -- Rod of the Blazing Light
{ 9, 28604 }, -- Nightstaff of the Everliving
{ 10, 29133 }, -- Seer's Cane
{ 11, 28033 }, -- Epoch-Mender
{ 12, 27791 }, -- Serpentcrest Life-Staff
{ 13, 31038 }, -- Staff of the Redeemer
{ 14, 30012 }, -- Ameer's Judgement
{ 15, 31417 }, -- Staff of the Ashtongue Deathsworn
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
 
},
},




--@end-version-bcc@
},
}



data["PalProt"] = {
	name = AL["Paladin Prot BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34401 }, -- Helm of Uther's Resolve
{ 2, 34400 }, -- Crown of Dath'Remar
{ 3, 32521 }, -- Faceplate of the Impenetrable
{ 4, 34357 }, -- Hard Khorium Goggles
{ 5, 30987 }, -- Lightbringer Faceguard
{ 6, 35029 }, -- Brutal Gladiator's Lamellar Helm
{ 7, 30125 }, -- Crystalforge Faceguard
{ 8, 33421 }, -- Battleworn Tuskguard
{ 9, 33697 }, -- Vengeful Gladiator's Lamellar Helm
{ 10, 31997 }, -- Merciless Gladiator's Lamellar Helm
{ 11, 32473 }, -- Tankatronic Goggles
{ 12, 34345 }, -- Crown of Anasterian
{ 13, 35061 }, -- Brutal Gladiator's Ornamented Headcover
{ 14, 29068 }, -- Justicar Faceguard
{ 15, 35090 }, -- Brutal Gladiator's Scaled Helm
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 35133 }, -- Guardian's Pendant of Dominance
{ 2, 34178 }, -- Collar of the Pit Lord
{ 3, 30007 }, -- The Darkener's Grasp
{ 4, 33921 }, -- Vindicator's Pendant of Dominance
{ 5, 32362 }, -- Pendant of Titans
{ 6, 35132 }, -- Guardian's Pendant of Conquest
{ 7, 37928 }, -- Guardian's Pendant of Subjugation
{ 8, 34359 }, -- Pendant of Sunfire
{ 9, 33065 }, -- Veteran's Pendant of Dominance
{ 10, 28245 }, -- Pendant of Dominance
{ 11, 34358 }, -- Hard Khorium Choker
{ 12, 33920 }, -- Vindicator's Pendant of Conquest
{ 13, 35319 }, -- Vindicator's Pendant of Subjugation
{ 14, 28516 }, -- Barbed Choker of Discipline
{ 15, 35135 }, -- Guardian's Pendant of Triumph
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34389 }, -- Spaulders of the Thalassian Defender
{ 2, 34192 }, -- Pauldrons of Perseverance
{ 3, 30998 }, -- Lightbringer Shoulderguards
{ 4, 35031 }, -- Brutal Gladiator's Lamellar Shoulders
{ 5, 32250 }, -- Pauldrons of Abyssal Fury
{ 6, 30127 }, -- Crystalforge Shoulderguards
{ 7, 29070 }, -- Justicar Shoulderguards
{ 8, 33481 }, -- Pauldrons of Stone Resolve
{ 9, 33699 }, -- Vengeful Gladiator's Lamellar Shoulders
{ 10, 34388 }, -- Pauldrons of Berserking
{ 11, 35092 }, -- Brutal Gladiator's Scaled Shoulders
{ 12, 31996 }, -- Merciless Gladiator's Lamellar Shoulders
{ 13, 35063 }, -- Brutal Gladiator's Ornamented Spaulders
{ 14, 33753 }, -- Vengeful Gladiator's Scaled Shoulders
{ 15, 30997 }, -- Lightbringer Shoulderbraces
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34190 }, -- Crimson Paragon's Cover
{ 2, 34242 }, -- Tattered Cape of Antonidas
{ 3, 33593 }, -- Slikk's Cloak of Placation
{ 4, 34010 }, -- Pepe's Shroud of Pacification
{ 5, 29925 }, -- Phoenix-Wing Cloak
{ 6, 29992 }, -- Royal Cloak of the Sunstriders
{ 7, 34241 }, -- Cloak of Unforgivable Sin
{ 8, 32331 }, -- Cloak of the Illidari Council
{ 9, 33304 }, -- Cloak of Subjugated Power
{ 10, 35321 }, -- Cloak of Arcane Alacrity
{ 11, 28660 }, -- Gilded Thorium Cloak
{ 12, 28378 }, -- Sergeant's Heavy Cape
{ 13, 28379 }, -- Sergeant's Heavy Cape
{ 14, 29385 }, -- Farstrider Defender's Cloak
{ 15, 27804 }, -- Devilshark Cape
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34216 }, -- Heroic Judicator's Chestguard
{ 2, 30991 }, -- Lightbringer Chestguard
{ 3, 34394 }, -- Breastplate of Agony's Aversion
{ 4, 35027 }, -- Brutal Gladiator's Lamellar Chestpiece
{ 5, 33522 }, -- Chestguard of the Stoic Guardian
{ 6, 34939 }, -- Chestplate of Stoicism
{ 7, 34945 }, -- Shattrath Protectorate's Breastplate
{ 8, 30123 }, -- Crystalforge Chestguard
{ 9, 33473 }, -- Chestguard of the Warlord
{ 10, 34215 }, -- Warharness of Reckless Fury
{ 11, 33695 }, -- Vengeful Gladiator's Lamellar Chestpiece
{ 12, 30896 }, -- Glory of the Defender
{ 13, 35088 }, -- Brutal Gladiator's Scaled Chestpiece
{ 14, 29066 }, -- Justicar Chestguard
{ 15, 35059 }, -- Brutal Gladiator's Ornamented Chestguard
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34433 }, -- Lightbringer Wristguards
{ 2, 32279 }, -- The Seeker's Wristguards
{ 3, 32232 }, -- Eternium Shell Bracers
{ 4, 35170 }, -- Guardian's Lamellar Bracers
{ 5, 32515 }, -- Wristguards of Determination
{ 6, 33889 }, -- Vindicator's Lamellar Bracers
{ 7, 35176 }, -- Guardian's Plate Bracers
{ 8, 33516 }, -- Bracers of the Ancient Phalanx
{ 9, 28502 }, -- Vambraces of Courage
{ 10, 35178 }, -- Guardian's Scaled Bracers
{ 11, 33813 }, -- Vindicator's Plate Bracers
{ 12, 32813 }, -- Veteran's Lamellar Bracers
{ 13, 35175 }, -- Guardian's Ornamented Bracers
{ 14, 29252 }, -- Bracers of Dignity
{ 15, 33910 }, -- Vindicator's Scaled Bracers
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34352 }, -- Borderland Fortress Grips
{ 2, 30985 }, -- Lightbringer Handguards
{ 3, 29998 }, -- Royal Gauntlets of Silvermoon
{ 4, 32280 }, -- Gauntlets of Enforcement
{ 5, 30124 }, -- Crystalforge Handguards
{ 6, 35028 }, -- Brutal Gladiator's Lamellar Gauntlets
{ 7, 34341 }, -- Borderland Paingrips
{ 8, 33517 }, -- Bonefist Gauntlets
{ 9, 34378 }, -- Hard Khorium Battlefists
{ 10, 28518 }, -- Iron Gauntlets of the Maiden
{ 11, 30741 }, -- Topaz-Studded Battlegrips
{ 12, 33696 }, -- Vengeful Gladiator's Lamellar Gauntlets
{ 13, 35060 }, -- Brutal Gladiator's Ornamented Gloves
{ 14, 29067 }, -- Justicar Handguards
{ 15, 34380 }, -- Sunblessed Gauntlets
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34488 }, -- Lightbringer Waistguard
{ 2, 32342 }, -- Girdle of Mighty Resolve
{ 3, 32333 }, -- Girdle of Stability
{ 4, 30034 }, -- Belt of the Guardian
{ 5, 33524 }, -- Girdle of the Protector
{ 6, 33279 }, -- Iron-tusk Girdle
{ 7, 30096 }, -- Girdle of the Invulnerable
{ 8, 34941 }, -- Girdle of the Fearless
{ 9, 35155 }, -- Guardian's Lamellar Belt
{ 10, 33888 }, -- Vindicator's Lamellar Belt
{ 11, 28566 }, -- Crimson Girdle of the Indomitable
{ 12, 34944 }, -- Girdle of Seething Rage
{ 13, 35161 }, -- Guardian's Plate Belt
{ 14, 29253 }, -- Girdle of Valorous Deeds
{ 15, 30897 }, -- Girdle of Hope
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34213 }, -- Ring of Hardened Resolve
{ 2, 34888 }, -- Ring of the Stalwart Protector
{ 3, 33499 }, -- Signet of the Last Defender
{ 4, 29297 }, -- Band of the Eternal Defender
{ 5, 29296 }, -- Band of Eternity (revered)
{ 6, 30083 }, -- Ring of Sundered Souls
{ 7, 30028 }, -- Seventh Ring of the Tirisfalen
{ 8, 29305 }, -- Band of the Eternal Sage
{ 9, 33054 }, -- The Seal of Danzalar
{ 10, 32261 }, -- Band of the Abyssal Lord
{ 11, 29279 }, -- Violet Signet of the Great Protector
{ 12, 29295 }, -- Band of Eternity (honored)
{ 13, 29278 }, -- Violet Signet
{ 14, 28792 }, -- A'dal's Signet of Defense
{ 15, 32527 }, -- Ring of Ancient Knowledge
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34382 }, -- Judicator's Legguards
{ 2, 34381 }, -- Felstrength Legplates
{ 3, 34946 }, -- Inscribed Legplates of the Aldor
{ 4, 30995 }, -- Lightbringer Legguards
{ 5, 32263 }, -- Praetorian's Legguards
{ 6, 33515 }, -- Unwavering Legguards
{ 7, 34940 }, -- Sunguard Legplates
{ 8, 30126 }, -- Crystalforge Legguards
{ 9, 35030 }, -- Brutal Gladiator's Lamellar Legguards
{ 10, 34180 }, -- Felfury Legplates
{ 11, 33698 }, -- Vengeful Gladiator's Lamellar Legguards
{ 12, 28621 }, -- Wrynn Dynasty Greaves
{ 13, 34167 }, -- Legplates of the Holy Juggernaut
{ 14, 35091 }, -- Brutal Gladiator's Scaled Legguards
{ 15, 29069 }, -- Justicar Legguards
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34560 }, -- Lightbringer Stompers
{ 2, 32245 }, -- Tide-stomper's Greaves
{ 3, 34947 }, -- Blue's Greaves of the Righteous Guardian
{ 4, 32268 }, -- Myrmidon's Treads
{ 5, 33523 }, -- Sabatons of the Righteous Defender
{ 6, 32267 }, -- Boots of the Resilient
{ 7, 35140 }, -- Guardian's Lamellar Greaves
{ 8, 33191 }, -- Jungle Stompers
{ 9, 30033 }, -- Boots of the Protector
{ 10, 30031 }, -- Red Havoc Boots
{ 11, 33890 }, -- Vindicator's Lamellar Greaves
{ 12, 35146 }, -- Guardian's Plate Greaves
{ 13, 32345 }, -- Dreadboots of the Legion
{ 14, 32789 }, -- Veteran's Lamellar Greaves
{ 15, 35148 }, -- Guardian's Scaled Greaves
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 30447 }, -- Tome of Fiery Redemption
{ 2, 31856 }, -- Darkmoon Card: Crusade
{ 3, 33829 }, -- Hex Shrunken Head
{ 4, 23207 }, -- Mark of the Champion (undead/demon)
{ 5, 34473 }, -- Commendation of Kael'thas
{ 6, 28789 }, -- Eye of Magtheridon
{ 7, 34470 }, -- Timbal's Focusing Crystal
{ 8, 29370 }, -- Icon of the Silver Crescent
{ 9, 38290 }, -- Dark Iron Smoking Pipe
{ 10, 35700 }, -- Figurine - Crimson Serpent
{ 11, 31858 }, -- Darkmoon Card: Vengeance
{ 12, 31859 }, -- Darkmoon Card: Madness
{ 13, 23046 }, -- The Restrained Essence of Sapphiron
{ 14, 33830 }, -- Ancient Aqir Artifact
{ 15, 30626 }, -- Sextant of Unstable Currents
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 35014 }, -- Brutal Gladiator's Gavel
{ 2, 34176 }, -- Reign of Misery
{ 3, 30910 }, -- Tempest of Chaos
{ 4, 33687 }, -- Vengeful Gladiator's Gavel
{ 5, 34009 }, -- Hammer of Judgement
{ 6, 33467 }, -- Blade of Twisted Visions
{ 7, 32963 }, -- Merciless Gladiator's Gavel
{ 8, 33283 }, -- Amani Punisher
{ 9, 30095 }, -- Fang of the Leviathan
{ 10, 28802 }, -- Bloodmaw Magus-Blade
{ 11, 34164 }, -- Dragonscale-Encrusted Longblade
{ 12, 34611 }, -- Cudgel of Consecration
{ 13, 32450 }, -- Gladiator's Gavel
{ 14, 30874 }, -- The Unbreakable Will
{ 15, 34996 }, -- Brutal Gladiator's Cleaver
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34185 }, -- Sword Breaker's Bulwark
{ 2, 34986 }, -- Brutal Gladiator's Barrier
{ 3, 35094 }, -- Brutal Gladiator's Shield Wall
{ 4, 32375 }, -- Bulwark of Azzinoth
{ 5, 30909 }, -- Antonidas's Aegis of Rapt Concentration
{ 6, 35073 }, -- Brutal Gladiator's Redoubt
{ 7, 34011 }, -- Illidari Runeshield
{ 8, 33661 }, -- Vengeful Gladiator's Barrier
{ 9, 34231 }, -- Aegis of Angelic Fortune
{ 10, 30889 }, -- Kaz'rogal's Hardened Heart
{ 11, 33755 }, -- Vengeful Gladiator's Shield Wall
{ 12, 33735 }, -- Vengeful Gladiator's Redoubt
{ 13, 33326 }, -- Bulwark of the Amani Empire
{ 14, 30882 }, -- Bastion of Light
{ 15, 33313 }, -- Merciless Gladiator's Barrier
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
 
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
 
},
},




--@end-version-bcc@
},
}



data["PalHoly"] = {
	name = AL["Paladin Holy BiS"],
	ContentType = SET_CONTENT,
items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34402 }, -- Shroud of Chieftain Ner'zhul
{ 2, 34339 }, -- Cowl of Light's Purity
{ 3, 34243 }, -- Helm of Burning Righteousness
{ 4, 34245 }, -- Cover of Ursol the Wise
{ 5, 35185 }, -- Justicebringer 3000 Specs
{ 6, 35183 }, -- Wonderheal XT68 Shades
{ 7, 30988 }, -- Lightbringer Greathelm
{ 8, 32354 }, -- Crown of Empowered Fate
{ 9, 35181 }, -- Powerheal 9000 Lens
{ 10, 32241 }, -- Helm of Soothing Currents
{ 11, 30728 }, -- Fathom-Helm of the Deeps
{ 12, 30136 }, -- Crystalforge Greathelm
{ 13, 33286 }, -- Mojo-mender's Mask
{ 14, 33327 }, -- Mask of Introspection
{ 15, 32240 }, -- Guise of the Tidal Lurker
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34360 }, -- Amulet of Flowing Life
{ 2, 33281 }, -- Brooch of Nature's Mercy
{ 3, 37929 }, -- Guardian's Pendant of Reprieve
{ 4, 34184 }, -- Brooch of the Highborne
{ 5, 35317 }, -- Vindicator's Pendant of Reprieve
{ 6, 32370 }, -- Nadina's Pendant of Purity
{ 7, 35291 }, -- Sin'dorei Pendant of Salvation
{ 8, 30018 }, -- Lord Sanguinar's Claim
{ 9, 35134 }, -- Guardian's Pendant of Salvation
{ 10, 30726 }, -- Archaic Charm of Presence
{ 11, 33922 }, -- Vindicator's Pendant of Salvation
{ 12, 34359 }, -- Pendant of Sunfire
{ 13, 33068 }, -- Veteran's Pendant of Salvation
{ 14, 34677 }, -- Shattered Sun Pendant of Restoration
{ 15, 28609 }, -- Emberspur Talisman
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34202 }, -- Shawl of Wonderment
{ 2, 34208 }, -- Equilibrium Epaulets
{ 3, 34209 }, -- Spaulders of Reclamation
{ 4, 34193 }, -- Spaulders of the Thalassian Savior
{ 5, 30996 }, -- Lightbringer Pauldrons
{ 6, 32579 }, -- Living Earth Shoulders
{ 7, 30878 }, -- Glimmering Steel Mantle
{ 8, 32583 }, -- Shoulderpads of Renewed Life
{ 9, 32573 }, -- Dawnsteel Shoulders
{ 10, 30138 }, -- Crystalforge Pauldrons
{ 11, 30097 }, -- Coral-Barbed Shoulderpads
{ 12, 35063 }, -- Brutal Gladiator's Ornamented Spaulders
{ 13, 33464 }, -- Hex Lord's Voodoo Pauldrons
{ 14, 32585 }, -- Swiftheal Mantle
{ 15, 33287 }, -- Gnarled Ironwood Pauldrons
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 32524 }, -- Shroud of the Highborne
{ 2, 33592 }, -- Cloak of Ancient Rituals
{ 3, 34205 }, -- Shroud of Redeemed Souls
{ 4, 29989 }, -- Sunshower Light Cloak
{ 5, 32337 }, -- Shroud of Forgiveness
{ 6, 34242 }, -- Tattered Cape of Antonidas
{ 7, 35324 }, -- Cloak of Swift Reprieve
{ 8, 34012 }, -- Shroud of the Final Stand
{ 9, 34702 }, -- Cloak of Swift Mending
{ 10, 31329 }, -- Lifegiving Cloak
{ 11, 28765 }, -- Stainless Cloak of the Pure Hearted
{ 12, 29354 }, -- Light-Touched Stole of Altruism
{ 13, 32653 }, -- Apexis Cloak
{ 14, 24254 }, -- White Remedy Cape
{ 15, 28582 }, -- Red Riding Hood's Cloak
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34365 }, -- Robe of Eternal Light
{ 2, 34375 }, -- Sun-Drenched Scale Chestguard
{ 3, 34212 }, -- Sunglow Vest
{ 4, 34233 }, -- Robes of Faltered Light
{ 5, 34229 }, -- Garments of Serene Shores
{ 6, 34371 }, -- Leather Chestguard of the Sun
{ 7, 30992 }, -- Lightbringer Chestpiece
{ 8, 30134 }, -- Crystalforge Chestpiece
{ 9, 33469 }, -- Hauberk of the Empire's Champion
{ 10, 29062 }, -- Justicar Chestpiece
{ 11, 21875 }, -- Primal Mooncloth Robe
{ 12, 34605 }, -- Breastplate of Fierce Survival
{ 13, 33216 }, -- Chestguard of Hidden Purpose
{ 14, 33203 }, -- Robes of Heavenly Purpose
{ 15, 35059 }, -- Brutal Gladiator's Ornamented Chestguard
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34432 }, -- Lightbringer Bracers
{ 2, 32571 }, -- Dawnsteel Bracers
{ 3, 32584 }, -- Swiftheal Wraps
{ 4, 32577 }, -- Living Earth Bindings
{ 5, 32582 }, -- Bracers of Renewed Life
{ 6, 30862 }, -- Blessed Adamantite Bracers
{ 7, 35175 }, -- Guardian's Ornamented Bracers
{ 8, 30869 }, -- Howling Wind Bracers
{ 9, 30868 }, -- Rejuvenating Bracers
{ 10, 30871 }, -- Bracers of Martyrdom
{ 11, 30047 }, -- Blackfathom Warbands
{ 12, 33520 }, -- Vambraces of the Naaru
{ 13, 33589 }, -- Wristguards of Tranquil Thought
{ 14, 33904 }, -- Vindicator's Ornamented Bracers
{ 15, 30684 }, -- Ravager's Cuffs of Healing
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34240 }, -- Gauntlets of the Soothed Soul
{ 2, 34372 }, -- Leather Gauntlets of the Sun
{ 3, 32328 }, -- Botanist's Gloves of Growth
{ 4, 34376 }, -- Sun-Drenched Scale Gloves
{ 5, 34409 }, -- Gauntlets of the Ancient Frostwolf
{ 6, 34342 }, -- Handguards of the Dawn
{ 7, 34380 }, -- Sunblessed Gauntlets
{ 8, 34351 }, -- Tranquil Majesty Wraps
{ 9, 34367 }, -- Hands of Eternal Light
{ 10, 32275 }, -- Spiritwalker Gauntlets
{ 11, 30112 }, -- Glorious Gauntlets of Crestfall
{ 12, 32353 }, -- Gloves of Unfailing Faith
{ 13, 29976 }, -- Worldstorm Gauntlets
{ 14, 34791 }, -- Gauntlets of the Tranquil Waves
{ 15, 34700 }, -- Gauntlets of Divine Blessings
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34487 }, -- Lightbringer Belt
{ 2, 30895 }, -- Angelista's Sash
{ 3, 32258 }, -- Naturalist's Preserving Cinch
{ 4, 32339 }, -- Belt of Primal Majesty
{ 5, 30897 }, -- Girdle of Hope
{ 6, 33446 }, -- Girdle of Stromgarde's Hope
{ 7, 32512 }, -- Girdle of Lordaeron's Fallen
{ 8, 33480 }, -- Cord of Braided Troll Hair
{ 9, 21873 }, -- Primal Mooncloth Belt
{ 10, 33483 }, -- Life-step Belt
{ 11, 30030 }, -- Girdle of Fallen Stars
{ 12, 34932 }, -- Clutch of the Soothing Breeze
{ 13, 33386 }, -- Man'kin'do's Belt
{ 14, 32519 }, -- Belt of Divine Guidance
{ 15, 29984 }, -- Girdle of Zaetar
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 32528 }, -- Blessed Band of Karabor
{ 2, 34363 }, -- Ring of Flowing Life
{ 3, 34166 }, -- Band of Lucent Beams
{ 4, 33498 }, -- Signet of the Quiet Forest
{ 5, 29309 }, -- Band of the Eternal Restorer
{ 6, 34625 }, -- Kharmaa's Ring of Fate
{ 7, 32238 }, -- Ring of Calming Waves
{ 8, 30736 }, -- Ring of Flowing Light
{ 9, 29308 }, -- Band of Eternity (revered)
{ 10, 35733 }, -- Ring of Harmonic Beauty
{ 11, 34890 }, -- Anveena's Touch
{ 12, 30110 }, -- Coral Band of the Revived
{ 13, 35283 }, -- Sin'dorei Band of Salvation
{ 14, 29306 }, -- Band of Eternity (honored)
{ 15, 28763 }, -- Jade Ring of the Everliving
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34383 }, -- Kilt of Spiritual Reconstruction
{ 2, 34170 }, -- Pantaloons of Calming Strife
{ 3, 34384 }, -- Breeches of Natural Splendor
{ 4, 34167 }, -- Legplates of the Holy Juggernaut
{ 5, 30912 }, -- Leggings of Eternity
{ 6, 32271 }, -- Kilt of Immortal Nature
{ 7, 30893 }, -- Sun-touched Chain Leggings
{ 8, 30727 }, -- Gilded Trousers of Benediction
{ 9, 29991 }, -- Sunhawk Leggings
{ 10, 33518 }, -- High Justicar's Legplates
{ 11, 33585 }, -- Achromic Trousers of the Naaru
{ 12, 34931 }, -- Runed Scales of Antiquity
{ 13, 33530 }, -- Natural Life Leggings
{ 14, 34901 }, -- Grovewalker's Leggings
{ 15, 34925 }, -- Adorned Supernal Legwraps
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34559 }, -- Lightbringer Treads
{ 2, 33324 }, -- Treads of the Life Path
{ 3, 30737 }, -- Gold-Leaf Wildboots
{ 4, 33207 }, -- Implacable Guardian Sabatons
{ 5, 33471 }, -- Two-toed Sandals
{ 6, 30092 }, -- Orca-Hide Boots
{ 7, 32609 }, -- Boots of the Divine Light
{ 8, 30680 }, -- Glider's Foot-Wraps of Healing
{ 9, 34926 }, -- Slippers of Dutiful Mending
{ 10, 32243 }, -- Pearl Inlaid Boots
{ 11, 34612 }, -- Greaves of the Penitent Knight
{ 12, 30100 }, -- Soul-Strider Boots
{ 13, 30027 }, -- Boots of Courage Unending
{ 14, 28752 }, -- Forestlord Striders
{ 15, 34707 }, -- Boots of Resuscitation
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 29376 }, -- Essence of the Martyr
{ 2, 38288 }, -- Direbrew Hops
{ 3, 32496 }, -- Memento of Tyrande
{ 4, 34430 }, -- Glimmering Naaru Sliver
{ 5, 28190 }, -- Scarab of the Infinite Cycle
{ 6, 30447 }, -- Tome of Fiery Redemption
{ 7, 23047 }, -- Eye of the Dead
{ 8, 25634 }, -- Oshu'gun Relic
{ 9, 34050 }, -- Battlemaster's Perseverance
{ 10, 34580 }, -- Battlemaster's Perseverance
{ 11, 34429 }, -- Shifting Naaru Sliver
{ 12, 28823 }, -- Eye of Gruul
{ 13, 33828 }, -- Tome of Diabolic Remedy
{ 14, 30841 }, -- Lower City Prayerbook
{ 15, 28590 }, -- Ribbon of Sacrifice
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34335 }, -- Hammer of Sanctification
{ 2, 34199 }, -- Archon's Gavel
{ 3, 35082 }, -- Brutal Gladiator's Salvation
{ 4, 32500 }, -- Crystal Spire of Karabor
{ 5, 33468 }, -- Dark Blessing
{ 6, 34896 }, -- Gavel of Naaru Blessings
{ 7, 33743 }, -- Vengeful Gladiator's Salvation
{ 8, 30918 }, -- Hammer of Atonement
{ 9, 30108 }, -- Lightfathom Scepter
{ 10, 32964 }, -- Merciless Gladiator's Salvation
{ 11, 28771 }, -- Light's Justice
{ 12, 32451 }, -- Gladiator's Salvation
{ 13, 28522 }, -- Shard of the Virtuous
{ 14, 23556 }, -- Hand of Eternity
{ 15, 29353 }, -- Shockwave Truncheon
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34206 }, -- Book of Highborne Hymns
{ 2, 30882 }, -- Bastion of Light
{ 3, 34231 }, -- Aegis of Angelic Fortune
{ 4, 33332 }, -- Enamelled Disc of Mojo
{ 5, 32255 }, -- Felstone Bulwark
{ 6, 35073 }, -- Brutal Gladiator's Redoubt
{ 7, 35074 }, -- Brutal Gladiator's Reprieve
{ 8, 30911 }, -- Scepter of Purification
{ 9, 32350 }, -- Touch of Inspiration
{ 10, 29274 }, -- Tears of Heaven
{ 11, 33735 }, -- Vengeful Gladiator's Redoubt
{ 12, 33736 }, -- Vengeful Gladiator's Reprieve
{ 13, 29923 }, -- Talisman of the Sun King
{ 14, 29170 }, -- Windcaller's Orb
{ 15, 29458 }, -- Aegis of the Vindicator
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
 
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
 
},
},




--@end-version-bcc@
},
}




data["Palret"] = {
	name = AL["Paladin Ret BiS"],
	ContentType = SET_CONTENT,

items = {
{ -- T1
name = format(AL["Head"], "1"),
[NORMAL_DIFF] = {
{ 1, 34244 }, -- Duplicitous Guise
{ 2, 34333 }, -- Coif of Alleria
{ 3, 34345 }, -- Crown of Anasterian
{ 4, 32235 }, -- Cursed Vision of Sargeras
{ 5, 34354 }, -- Mayhem Projection Goggles
{ 6, 32373 }, -- Helm of the Illidari Shatterer
{ 7, 32376 }, -- Forest Prowler's Helm
{ 8, 34404 }, -- Mask of the Fury Hunter
{ 9, 35090 }, -- Brutal Gladiator's Scaled Helm
{ 10, 32461 }, -- Furious Gizmatic Goggles
{ 11, 30989 }, -- Lightbringer War-Helm
{ 12, 30131 }, -- Crystalforge War-Helm
{ 13, 33751 }, -- Vengeful Gladiator's Scaled Helm
{ 14, 32041 }, -- Merciless Gladiator's Scaled Helm
{ 15, 29073 }, -- Justicar Crown
},
},

{ -- T2
name = format(AL["Neck"], "2"),
[NORMAL_DIFF] = {
{ 1, 34358 }, -- Hard Khorium Choker
{ 2, 34177 }, -- Clutch of Demise
{ 3, 32260 }, -- Choker of Endless Nightmares
{ 4, 34178 }, -- Collar of the Pit Lord
{ 5, 35292 }, -- Sin'dorei Pendant of Triumph
{ 6, 35135 }, -- Guardian's Pendant of Triumph
{ 7, 30022 }, -- Pendant of the Perilous
{ 8, 33296 }, -- Brooch of Deftness
{ 9, 30017 }, -- Telonicus's Pendant of Mayhem
{ 10, 33923 }, -- Vindicator's Pendant of Triumph
{ 11, 24114 }, -- Braided Eternium Chain (GROUP BUFF)
{ 12, 33297 }, -- The Savage's Choker
{ 13, 32591 }, -- Choker of Serrated Blades
{ 14, 29119 }, -- Haramad's Bargain
{ 15, 28745 }, -- Mithril Chain of Heroism
},
},


{ -- T2
name = format(AL["Shoulders"], "2"),
[NORMAL_DIFF] = {
{ 1, 34388 }, -- Pauldrons of Berserking
{ 2, 34195 }, -- Shoulderpads of Vehemence
{ 3, 34194 }, -- Mantle of the Golden Forest
{ 4, 34392 }, -- Demontooth Shoulderpads
{ 5, 30055 }, -- Shoulderpads of the Stranger
{ 6, 32581 }, -- Swiftstrike Shoulders
{ 7, 32570 }, -- Swiftsteel Shoulders
{ 8, 32575 }, -- Shoulders of Lightning Reflexes
{ 9, 30997 }, -- Lightbringer Shoulderbraces
{ 10, 32264 }, -- Shoulders of the Hidden Predator
{ 11, 30866 }, -- Blood-stained Pauldrons
{ 12, 30740 }, -- Ripfiend Shoulderplates
{ 13, 30053 }, -- Pauldrons of the Wardancer
{ 14, 35092 }, -- Brutal Gladiator's Scaled Shoulders
{ 15, 30133 }, -- Crystalforge Shoulderbraces
},
},

{ -- T2
name = format(AL["Back"], "2"),
[NORMAL_DIFF] = {
{ 1, 34241 }, -- Cloak of Unforgivable Sin
{ 2, 33590 }, -- Cloak of Fiends
{ 3, 32323 }, -- Shadowmoon Destroyer's Drape
{ 4, 34190 }, -- Crimson Paragon's Cover
{ 5, 33122 }, -- Cloak of Darkness (melee)
{ 6, 30098 }, -- Razor-Scale Battlecloak
{ 7, 29994 }, -- Thalassian Wildercloak
{ 8, 24259 }, -- Vengeance Wrap
{ 9, 30729 }, -- Black-Iron Battlecloak
{ 10, 33484 }, -- Dory's Embrace
{ 11, 28777 }, -- Cloak of the Pit Stalker
{ 12, 28672 }, -- Drape of the Dark Reavers
{ 13, 34708 }, -- Cloak of the Coming Night
{ 14, 32665 }, -- Crystalweave Cape
{ 15, 29382 }, -- Blood Knight War Cloak
},
},

{ -- T2
name = format(AL["Chest"], "2"),
[NORMAL_DIFF] = {
{ 1, 34369 }, -- Carapace of Sun and Shadow
{ 2, 34397 }, -- Bladed Chaos Tunic
{ 3, 34215 }, -- Warharness of Reckless Fury
{ 4, 34377 }, -- Hard Khorium Battleplate
{ 5, 34211 }, -- Harness of Carnal Instinct
{ 6, 30905 }, -- Midnight Chestguard
{ 7, 30990 }, -- Lightbringer Breastplate
{ 8, 35088 }, -- Brutal Gladiator's Scaled Chestpiece
{ 9, 34942 }, -- Breastplate of Ire
{ 10, 34912 }, -- Scaled Drakeskin Chestguard
{ 11, 28485 }, -- Bulwark of the Ancient Kings
{ 12, 30129 }, -- Crystalforge Breastplate
{ 13, 34373 }, -- Embrace of the Phoenix
{ 14, 32365 }, -- Heartshatter Breastplate
{ 15, 34906 }, -- Embrace of Everlasting Prowess
},
},

{ -- T2
name = format(AL["Wrist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34431 }, -- Lightbringer Bands
{ 2, 32574 }, -- Bindings of Lightning Reflexes
{ 3, 32580 }, -- Swiftstrike Bracers
{ 4, 32568 }, -- Swiftsteel Bracers
{ 5, 30863 }, -- Deadly Cuffs
{ 6, 30057 }, -- Bracers of Eradication
{ 7, 32324 }, -- Insidious Bands
{ 8, 30861 }, -- Furious Shackles
{ 9, 28795 }, -- Bladespire Warbands
{ 10, 33540 }, -- Master Assassin Wristwraps
{ 11, 35176 }, -- Guardian's Plate Bracers
{ 12, 35178 }, -- Guardian's Scaled Bracers
{ 13, 32251 }, -- Wraps of Precise Flight
{ 14, 33813 }, -- Vindicator's Plate Bracers
{ 15, 33910 }, -- Vindicator's Scaled Bracers
},
},

{ -- T2
name = format(AL["Hands"], "2"),
[NORMAL_DIFF] = {
{ 1, 34343 }, -- Thalassian Ranger Gauntlets
{ 2, 34370 }, -- Gloves of Immortal Dusk
{ 3, 34234 }, -- Shadowed Gauntlets of Paroxysm
{ 4, 34341 }, -- Borderland Paingrips
{ 5, 34378 }, -- Hard Khorium Battlefists
{ 6, 34374 }, -- Fletcher's Gloves of the Phoenix
{ 7, 34408 }, -- Gloves of the Forest Drifter
{ 8, 32347 }, -- Grips of Damnation
{ 9, 32234 }, -- Fists of Mukoa
{ 10, 29947 }, -- Gloves of the Searing Grip
{ 11, 32608 }, -- Pillager's Gauntlets
{ 12, 32278 }, -- Grips of Silent Justice
{ 13, 34916 }, -- Gauntlets of Rapidity
{ 14, 34911 }, -- Handwraps of the Aggressor
{ 15, 33539 }, -- Trickster's Stickyfingers
},
},

{ -- T2
name = format(AL["Waist"], "2"),
[NORMAL_DIFF] = {
{ 1, 34485 }, -- Lightbringer Girdle
{ 2, 30106 }, -- Belt of One-Hundred Deaths
{ 3, 32265 }, -- Shadow-walker's Cord
{ 4, 30919 }, -- Valestalker Girdle
{ 5, 30879 }, -- Don Alejandro's Money Belt
{ 6, 30915 }, -- Belt of Seething Fury
{ 7, 32346 }, -- Boneweave Girdle
{ 8, 30032 }, -- Red Belt of Battle
{ 9, 32606 }, -- Girdle of the Lightbearer
{ 10, 34944 }, -- Girdle of Seething Rage
{ 11, 30040 }, -- Belt of Deep Shadow
{ 12, 34929 }, -- Belt of the Silent Path
{ 13, 33583 }, -- Waistguard of the Great Beast
{ 14, 33211 }, -- Bladeangel's Money Belt
{ 15, 28779 }, -- Girdle of the Endless Pit
},
},

{ -- T2
name = format(AL["Rings"], "2"),
[NORMAL_DIFF] = {
{ 1, 34361 }, -- Hard Khorium Band
{ 2, 34189 }, -- Band of Ruinous Delight
{ 3, 32335 }, -- Unstoppable Aggressor's Ring
{ 4, 32526 }, -- Band of Devastation
{ 5, 34887 }, -- Angelista's Revenge
{ 6, 30834 }, -- Shapeshifter's Signet
{ 7, 29301 }, -- Band of the Eternal Champion
{ 8, 33496 }, -- Signet of Primal Wrath
{ 9, 29997 }, -- Band of the Ranger-General
{ 10, 32497 }, -- Stormrage Signet Ring
{ 11, 35131 }, -- Guardian's Band of Triumph
{ 12, 30061 }, -- Ancestral Ring of Conquest
{ 13, 32266 }, -- Ring of Deceitful Intent
{ 14, 29300 }, -- Band of Eternity (revered)
{ 15, 30052 }, -- Ring of Lethality
},
},

{ -- T2
name = format(AL["Legs"], "2"),
[NORMAL_DIFF] = {
{ 1, 34180 }, -- Felfury Legplates
{ 2, 34188 }, -- Leggings of the Immortal Night
{ 3, 34168 }, -- Starstalker Legguards
{ 4, 34385 }, -- Leggings of the Immortal Beast
{ 5, 34943 }, -- Legplates of Unending Fury
{ 6, 30900 }, -- Bow-stitched Leggings
{ 7, 30903 }, -- Legguards of Endless Rage
{ 8, 32341 }, -- Leggings of Divine Retribution
{ 9, 34910 }, -- Tameless Breeches
{ 10, 30993 }, -- Lightbringer Greaves
{ 11, 34381 }, -- Felstrength Legplates
{ 12, 33538 }, -- Shallow-grave Trousers
{ 13, 29950 }, -- Greaves of the Bloodwarder
{ 14, 29995 }, -- Leggings of Murderous Intent
{ 15, 35091 }, -- Brutal Gladiator's Scaled Legguards
},
},

{ -- T2
name = format(AL["Feet"], "2"),
[NORMAL_DIFF] = {
{ 1, 34561 }, -- Lightbringer Boots
{ 2, 32345 }, -- Dreadboots of the Legion
{ 3, 32366 }, -- Shadowmaster's Boots
{ 4, 32510 }, -- Softstep Boots of Tracking
{ 5, 33222 }, -- Nyn'jah's Tabi Boots
{ 6, 33303 }, -- Skullshatter Warboots
{ 7, 29951 }, -- Star-Strider Boots
{ 8, 30104 }, -- Cobra-Lash Boots
{ 9, 35146 }, -- Guardian's Plate Greaves
{ 10, 30880 }, -- Quickstrider Moccasins
{ 11, 33582 }, -- Footwraps of Wild Encroachment
{ 12, 30081 }, -- Warboots of Obliteration
{ 13, 35148 }, -- Guardian's Scaled Greaves
{ 14, 28608 }, -- Ironstriders of Urgency
{ 15, 34809 }, -- Sunrage Treads
},
},

{ -- T2
name = format(AL["Trinkets"], "2"),
[NORMAL_DIFF] = {
{ 1, 28830 }, -- Dragonspine Trophy
{ 2, 34472 }, -- Shard of Contempt
{ 3, 34427 }, -- Blackened Naaru Sliver
{ 4, 34428 }, -- Steely Naaru Sliver
{ 5, 31856 }, -- Darkmoon Card: Crusade
{ 6, 23206 }, -- Mark of the Champion (undead/demon)
{ 7, 33831 }, -- Berserker's Call
{ 8, 30627 }, -- Tsunami Talisman
{ 9, 32505 }, -- Madness of the Betrayer
{ 10, 35702 }, -- Figurine - Shadowsong Panther
{ 11, 28288 }, -- Abacus of Violent Odds
{ 12, 29383 }, -- Bloodlust Brooch
{ 13, 28034 }, -- Hourglass of the Unraveller
{ 14, 23041 }, -- Slayer's Crest
{ 15, 22954 }, -- Kiss of the Spider
},
},
{ -- T2
name = format(AL["Onehand"], "2"),
[NORMAL_DIFF] = {
 
},
},

{ -- T2
name = format(AL["Offhand"], "2"),
[NORMAL_DIFF] = {
 
},
},

{ -- T2
name = format(AL["Twohand"], "2"),
[NORMAL_DIFF] = {
{ 1, 34247 }, -- Apolyon, the Soul-Render
{ 2, 34183 }, -- Shivering Felspine
{ 3, 34891 }, -- The Blade of Harbingers
{ 4, 34989 }, -- Brutal Gladiator's Bonegrinder
{ 5, 35015 }, -- Brutal Gladiator's Greatsword
{ 6, 32332 }, -- Torch of the Damned
{ 7, 30902 }, -- Cataclysm's Edge
{ 8, 34997 }, -- Brutal Gladiator's Decapitator
{ 9, 35064 }, -- Brutal Gladiator's Painsaw
{ 10, 33663 }, -- Vengeful Gladiator's Bonegrinder
{ 11, 33688 }, -- Vengeful Gladiator's Greatsword
{ 12, 28430 }, -- Lionheart Executioner
{ 13, 29993 }, -- Twinblade of the Phoenix
{ 14, 33670 }, -- Vengeful Gladiator's Decapitator
{ 15, 32348 }, -- Soul Cleaver
},
},


{ -- T2
name = format(AL["Ranged"], "2"),
[NORMAL_DIFF] = {
 
},
},




--@end-version-bcc@
},
}





