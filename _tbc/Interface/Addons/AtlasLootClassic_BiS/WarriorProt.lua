local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["WarriorProt"] = {
    name = AL["Warrior Prot BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34345}, -- Crown of Anasterian
                {2, 35068}, -- Brutal Gladiator's Plate Helm
                {3, 34354}, -- Mayhem Projection Goggles
                {4, 34357}, -- Hard Khorium Goggles
                {5, 34401}, -- Helm of Uther's Resolve
                {6, 32521}, -- Faceplate of the Impenetrable
                {7, 33730}, -- Vengeful Gladiator's Plate Helm
                {8, 34400}, -- Crown of Dath'Remar
                {9, 30972}, -- Onslaught Battle-Helm
                {10, 32373}, -- Helm of the Illidari Shatterer
                {11, 34244}, -- Duplicitous Guise
                {12, 33810}, -- Amani Mask of Death
                {13, 30974}, -- Onslaught Greathelm
                {14, 33421}, -- Battleworn Tuskguard
                {15, 34333}, -- Coif of Alleria
                -- Enchants
                {16, 19782}, -- presence-of-might
                {17, 29192}, -- glyph-of-ferocity
                {18, 29186}, -- glyph-of-the-defender
                -- Meta Gems
                {19, 25896}, -- powerful-earthstorm-diamond
                {20, 32409} -- relentless-earthstorm-diamond
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34178}, -- Collar of the Pit Lord
                {2, 33296}, -- Brooch of Deftness
                {3, 34358}, -- Hard Khorium Choker
                {4, 34680}, -- Shattered Sun Pendant of Resolve
                {5, 35135}, -- Guardian's Pendant of Triumph
                {6, 34177}, -- Clutch of Demise
                {7, 32362}, -- Pendant of Titans
                {8, 30099}, -- Frayed Tether of the Drowned
                {9, 32591}, -- Choker of Serrated Blades
                {10, 33923}, -- Vindicator's Pendant of Triumph
                {11, 33066}, -- Veteran's Pendant of Triumph
                {12, 33297}, -- The Savage's Choker
                {13, 28509}, -- Worgen Claw Necklace
                {14, 35511}, -- Hailstone Pendant
                {15, 29381} -- Choker of Vile Intent
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34192}, -- Pauldrons of Perseverance
                {2, 35070}, -- Brutal Gladiator's Plate Shoulders
                {3, 34388}, -- Pauldrons of Berserking
                {4, 34389}, -- Spaulders of the Thalassian Defender
                {5, 33732}, -- Vengeful Gladiator's Plate Shoulders
                {6, 30979}, -- Onslaught Shoulderblades
                {7, 30117}, -- Destroyer Shoulderguards
                {8, 30122}, -- Destroyer Shoulderblades
                {9, 30490}, -- Merciless Gladiator's Plate Shoulders
                {10, 30866}, -- Blood-stained Pauldrons
                {11, 34194}, -- Mantle of the Golden Forest
                {12, 32570}, -- Swiftsteel Shoulders
                {13, 29023}, -- Warbringer Shoulderplates
                {14, 30980}, -- Onslaught Shoulderguards
                {15, 33514}, -- Pauldrons of Gruesome Fate
                -- Enchants
                {16, 28889},
                {17, 28911},
                {18, 23549}
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34190}, -- Crimson Paragon's Cover
                {2, 34241}, -- Cloak of Unforgivable Sin
                {3, 34010}, -- Pepe's Shroud of Pacification
                {4, 32323}, -- Shadowmoon Destroyer's Drape
                {5, 33484}, -- Dory's Embrace
                {6, 29385}, -- Farstrider Defender's Cloak
                {7, 28529}, -- Royal Cloak of Arathi Kings
                {8, 33122}, -- Cloak of Darkness (melee)
                {9, 28672}, -- Drape of the Dark Reavers
                {10, 29994}, -- Thalassian Wildercloak
                {11, 33590}, -- Cloak of Fiends
                {12, 33593}, -- Slikk's Cloak of Placation
                {13, 30098}, -- Razor-Scale Battlecloak
                {14, 28777}, -- Cloak of the Pit Stalker
                {15, 28764}, -- Farstrider Wildercloak
                -- Enchants
                {16, 35432}
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 35066}, -- Brutal Gladiator's Plate Chestpiece
                {2, 34215}, -- Warharness of Reckless Fury
                {3, 34377}, -- Hard Khorium Battleplate
                {4, 30975}, -- Onslaught Breastplate
                {5, 33728}, -- Vengeful Gladiator's Plate Chestpiece
                {6, 28485}, -- Bulwark of the Ancient Kings
                {7, 34394}, -- Breastplate of Agony's Aversion
                {8, 30113}, -- Destroyer Chestguard
                {9, 28484}, -- Bulwark of Kings
                {10, 30486}, -- Merciless Gladiator's Plate Chestpiece
                {11, 30976}, -- Onslaught Chestguard
                {12, 30118}, -- Destroyer Breastplate
                {13, 34216}, -- Heroic Judicator's Chestguard
                {14, 32365}, -- Heartshatter Breastplate
                {15, 34939}, -- Chestplate of Stoicism
                -- Enchants
                {16, 22547},
                {17, 28270}
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 35176}, -- Guardian's Plate Bracers
                {2, 34441}, -- Onslaught Bracers
                {3, 34442}, -- Onslaught Wristguards
                {4, 35178}, -- Guardian's Scaled Bracers
                {5, 33516}, -- Bracers of the Ancient Phalanx
                {6, 33813}, -- Vindicator's Plate Bracers
                {7, 30861}, -- Furious Shackles
                {8, 32568}, -- Swiftsteel Bracers
                {9, 30057}, -- Bracers of Eradication
                {10, 28502}, -- Vambraces of Courage
                {11, 33910}, -- Vindicator's Scaled Bracers
                {12, 33513}, -- Eternium Rage-shackles
                {13, 32232}, -- Eternium Shell Bracers
                {14, 28795}, -- Bladespire Warbands
                {15, 32818}, -- Veteran's Plate Bracers
                -- Enchants
                {16, 22533}
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34378}, -- Hard Khorium Battlefists
                {2, 34341}, -- Borderland Paingrips
                {3, 32280}, -- Gauntlets of Enforcement
                {4, 34343}, -- Thalassian Ranger Gauntlets
                {5, 32278}, -- Grips of Silent Justice
                {6, 34352}, -- Borderland Fortress Grips
                {7, 30969}, -- Onslaught Gauntlets
                {8, 35067}, -- Brutal Gladiator's Plate Gauntlets
                {9, 32608}, -- Pillager's Gauntlets
                {10, 33512}, -- Furious Deathgrips
                {11, 33517}, -- Bonefist Gauntlets
                {12, 34408}, -- Gloves of the Forest Drifter
                {13, 30114}, -- Destroyer Handguards
                {14, 29998}, -- Royal Gauntlets of Silvermoon
                {15, 33729}, -- Vengeful Gladiator's Plate Gauntlets
                -- Enchants
                {16, 33153}
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34547}, -- Onslaught Waistguard
                {2, 34941}, -- Girdle of the Fearless
                {3, 32333}, -- Girdle of Stability
                {4, 32342}, -- Girdle of Mighty Resolve
                {5, 33331}, -- Chain of Unleashed Rage
                {6, 34944}, -- Girdle of Seething Rage
                {7, 34546}, -- Onslaught Belt
                {8, 35161}, -- Guardian's Plate Belt
                {9, 30034}, -- Belt of the Guardian
                {10, 30032}, -- Red Belt of Battle
                {11, 35163}, -- Guardian's Scaled Belt
                {12, 33811}, -- Vindicator's Plate Belt
                {13, 30915}, -- Belt of Seething Fury
                {14, 28779}, -- Girdle of the Endless Pit
                {15, 30106} -- Belt of One-Hundred Deaths
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34213}, -- Ring of Hardened Resolve
                {2, 32497}, -- Stormrage Signet Ring
                {3, 32266}, -- Ring of Deceitful Intent
                {4, 34361}, -- Hard Khorium Band
                {5, 29297}, -- Band of the Eternal Defender
                {6, 32261}, -- Band of the Abyssal Lord
                {7, 29296}, -- Band of Eternity (revered)
                {8, 29301}, -- Band of the Eternal Champion
                {9, 34189}, -- Band of Ruinous Delight
                {10, 32526}, -- Band of Devastation
                {11, 33499}, -- Signet of the Last Defender
                {12, 29295}, -- Band of Eternity (honored)
                {13, 29300}, -- Band of Eternity (revered)
                {14, 29997}, -- Band of the Ranger-General
                {15, 33496}, -- Signet of Primal Wrath
                -- Enchants
                {16, 22538}
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34381}, -- Felstrength Legplates
                {2, 35069}, -- Brutal Gladiator's Plate Legguards
                {3, 34180}, -- Felfury Legplates
                {4, 34382}, -- Judicator's Legguards
                {5, 30977}, -- Onslaught Greaves
                {6, 30978}, -- Onslaught Legguards
                {7, 34943}, -- Legplates of Unending Fury
                {8, 33515}, -- Unwavering Legguards
                {9, 30903}, -- Legguards of Endless Rage
                {10, 33731}, -- Vengeful Gladiator's Plate Legguards
                {11, 32263}, -- Praetorian's Legguards
                {12, 34940}, -- Sunguard Legplates
                {13, 34188}, -- Leggings of the Immortal Night
                {14, 33501}, -- Bloodthirster's Wargreaves
                {15, 34168}, -- Starstalker Legguards
                -- Enchants
                {16, 29536}
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34568}, -- Onslaught Boots
                {2, 32345}, -- Dreadboots of the Legion
                {3, 32268}, -- Myrmidon's Treads
                {4, 35146}, -- Guardian's Plate Greaves
                {5, 34569}, -- Onslaught Treads
                {6, 35148}, -- Guardian's Scaled Greaves
                {7, 33523}, -- Sabatons of the Righteous Defender
                {8, 32245}, -- Tide-stomper's Greaves
                {9, 33812}, -- Vindicator's Plate Greaves
                {10, 33303}, -- Skullshatter Warboots
                {11, 33191}, -- Jungle Stompers
                {12, 33911}, -- Vindicator's Scaled Greaves
                {13, 32267}, -- Boots of the Resilient
                {14, 32793}, -- Veteran's Plate Greaves
                {15, 30880}, -- Quickstrider Moccasins
                -- Enchants
                {16, 28280}
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 30446}, -- Solarian's Sapphire (Group AP Buff)
                {2, 28830}, -- Dragonspine Trophy
                {3, 34472}, -- Shard of Contempt
                {4, 34428}, -- Steely Naaru Sliver
                {5, 29387}, -- Gnomeregan Auto-Blocker 600
                {6, 38289}, -- Coren's Lucky Coin
                {7, 34473}, -- Commendation of Kael'thas
                {8, 34427}, -- Blackened Naaru Sliver
                {9, 32505}, -- Madness of the Betrayer
                {10, 31858}, -- Darkmoon Card: Vengeance
                {11, 31859}, -- Darkmoon Card: Madness
                {12, 35700}, -- Figurine - Crimson Serpent
                {13, 23836}, -- Goblin Rocket Launcher
                {14, 23835}, -- Gnomish Poultryizer
                {15, 32864} -- Commander's Badge
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34331}, -- Hand of the Deceiver
                {2, 34329}, -- Crux of the Apocalypse
                {3, 34164}, -- Dragonscale-Encrusted Longblade
                {4, 32837}, -- Warglaive of Azzinoth
                {5, 35076}, -- Brutal Gladiator's Right Ripper
                {6, 34996}, -- Brutal Gladiator's Cleaver
                {7, 35071}, -- Brutal Gladiator's Pummeler
                {8, 35101}, -- Brutal Gladiator's Slicer
                {9, 35093}, -- Brutal Gladiator's Shanker
                {10, 34214}, -- Muramasa
                {11, 33737}, -- Vengeful Gladiator's Right Ripper
                {12, 33669}, -- Vengeful Gladiator's Cleaver
                {13, 33733}, -- Vengeful Gladiator's Pummeler
                {14, 33754}, -- Vengeful Gladiator's Shanker
                {15, 33762}, -- Vengeful Gladiator's Slicer
                -- Enchants
                {16, 22559}
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34185}, -- Sword Breaker's Bulwark
                {2, 35094}, -- Brutal Gladiator's Shield Wall
                {3, 32375}, -- Bulwark of Azzinoth
                {4, 34986}, -- Brutal Gladiator's Barrier
                {5, 35073}, -- Brutal Gladiator's Redoubt
                {6, 30889}, -- Kaz'rogal's Hardened Heart
                {7, 33755}, -- Vengeful Gladiator's Shield Wall
                {8, 34231}, -- Aegis of Angelic Fortune
                {9, 30909}, -- Antonidas's Aegis of Rapt Concentration
                {10, 33326}, -- Bulwark of the Amani Empire
                {11, 34011}, -- Illidari Runeshield
                {12, 33661}, -- Vengeful Gladiator's Barrier
                {13, 33735}, -- Vengeful Gladiator's Redoubt
                {14, 30882}, -- Bastion of Light
                {15, 32045}, -- Merciless Gladiator's Shield Wall
                -- Enchants
                {16, 28282}
            }
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {}
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {
                {1, 32253}, -- Legionkiller
                {2, 30906}, -- Bristleblitz Striker
                {3, 32756}, -- Gyro-Balanced Khorium Destroyer
                {4, 34334}, -- Thori'dal, the Stars' Fury
                {5, 32645}, -- Crystalline Crossbow
                {6, 32325}, -- Rifle of the Stoic Guardian
                {7, 34196}, -- Golden Bow of Quel'Thalas
                {8, 30105}, -- Serpent Spine Longbow
                {9, 30724}, -- Barrel-Blade Longrifle
                {10, 29949}, -- Arcanite Steam-Pistol
                {11, 34892}, -- Crossbow of Relentless Strikes
                {12, 27817}, -- Starbolt Longbow
                {13, 29115}, -- Consortium Blaster
                {14, 30226}, -- Alley's Recurve
                {15, 32780}, -- The Boomstick
                -- Enchants
                {16, 23765}
            }
        }
    }
}
