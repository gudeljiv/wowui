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
                {1, 34345},
                {2, 35068},
                {3, 34354},
                {4, 34357},
                {5, 34401},
                {6, 32521},
                {7, 33730},
                {8, 34400},
                {9, 30972},
                {10, 32373},
                {11, 34244},
                {12, 33810},
                {13, 30974},
                {14, 33421},
                {15, 34333},
                {16, 25896 },
                {17, 32409 },
                {18, 19782 },
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
                {1, 34192},
                {2, 35070},
                {3, 34388},
                {4, 34389},
                {5, 33732},
                {6, 30979},
                {7, 30117},
                {8, 30122},
                {9, 30490},
                {10, 30866},
                {11, 34194},
                {12, 32570},
                {13, 29023},
                {14, 30980},
                {15, 33514},
                {16, 28889 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34190},
                {2, 34241},
                {3, 34010},
                {4, 32323},
                {5, 33484},
                {6, 29385},
                {7, 28529},
                {8, 33122},
                {9, 28672},
                {10, 29994},
                {11, 33590},
                {12, 33593},
                {13, 30098},
                {14, 28777},
                {15, 28764},
                {16, 34004, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 35066},
                {2, 34215},
                {3, 34377},
                {4, 30975},
                {5, 33728},
                {6, 28485},
                {7, 34394},
                {8, 30113},
                {9, 28484},
                {10, 30486},
                {11, 30976},
                {12, 30118},
                {13, 34216},
                {14, 32365},
                {15, 34939},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 35176},
                {2, 34441},
                {3, 34442},
                {4, 35178},
                {5, 33516},
                {6, 33813},
                {7, 30861},
                {8, 32568},
                {9, 30057},
                {10, 28502},
                {11, 33910},
                {12, 33513},
                {13, 32232},
                {14, 28795},
                {15, 32818},
                {16, 27914, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34378},
                {2, 34341},
                {3, 32280},
                {4, 34343},
                {5, 32278},
                {6, 34352},
                {7, 30969},
                {8, 35067},
                {9, 32608},
                {10, 33512},
                {11, 33517},
                {12, 34408},
                {13, 30114},
                {14, 29998},
                {15, 33729},
                {16, 25072, "Profession" },
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
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 34213},
                {2, 32497},
                {3, 32266},
                {4, 34361},
                {5, 29297},
                {6, 32261},
                {7, 29296},
                {8, 29301},
                {9, 34189},
                {10, 32526},
                {11, 33499},
                {12, 29295},
                {13, 29300},
                {14, 29997},
                {15, 33496},
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34381},
                {2, 35069},
                {3, 34180},
                {4, 34382},
                {5, 30977},
                {6, 30978},
                {7, 34943},
                {8, 33515},
                {9, 30903},
                {10, 33731},
                {11, 32263},
                {12, 34940},
                {13, 34188},
                {14, 33501},
                {15, 34168},
                {16, 29535 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34568},
                {2, 32345},
                {3, 32268},
                {4, 35146},
                {5, 34569},
                {6, 35148},
                {7, 33523},
                {8, 32245},
                {9, 33812},
                {10, 33303},
                {11, 33191},
                {12, 33911},
                {13, 32267},
                {14, 32793},
                {15, 30880},
                {16, 34008, "Profession" },
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
                {1, 34331},
                {2, 34329},
                {3, 34164},
                {4, 32837},
                {5, 35076},
                {6, 34996},
                {7, 35071},
                {8, 35101},
                {9, 35093},
                {10, 34214},
                {11, 33737},
                {12, 33669},
                {13, 33733},
                {14, 33754},
                {15, 33762},
                {16, 27984, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34185},
                {2, 35094},
                {3, 32375},
                {4, 34986},
                {5, 35073},
                {6, 30889},
                {7, 33755},
                {8, 34231},
                {9, 30909},
                {10, 33326},
                {11, 34011},
                {12, 33661},
                {13, 33735},
                {14, 30882},
                {15, 32045},
                {16, 34009, "Profession" },
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
                {1, 32253},
                {2, 30906},
                {3, 32756},
                {4, 34334},
                {5, 32645},
                {6, 32325},
                {7, 34196},
                {8, 30105},
                {9, 30724},
                {10, 29949},
                {11, 34892},
                {12, 27817},
                {13, 29115},
                {14, 30226},
                {15, 32780},
                {16, 23765 },
            }
        }
    }
}






















