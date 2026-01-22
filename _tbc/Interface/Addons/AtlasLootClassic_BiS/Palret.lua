local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["Palret"] = {
    name = AL["Paladin Ret BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34244},
                {2, 34333},
                {3, 34345},
                {4, 32235},
                {5, 34354},
                {6, 32373},
                {7, 32376},
                {8, 34404},
                {9, 35090},
                {10, 32461},
                {11, 30989},
                {12, 30131},
                {13, 33751},
                {14, 32041},
                {15, 29073},
                {16, 32409 },
                {17, 29192 },
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34358}, -- Hard Khorium Choker
                {2, 34177}, -- Clutch of Demise
                {3, 32260}, -- Choker of Endless Nightmares
                {4, 34178}, -- Collar of the Pit Lord
                {5, 35292}, -- Sin'dorei Pendant of Triumph
                {6, 35135}, -- Guardian's Pendant of Triumph
                {7, 30022}, -- Pendant of the Perilous
                {8, 33296}, -- Brooch of Deftness
                {9, 30017}, -- Telonicus's Pendant of Mayhem
                {10, 33923}, -- Vindicator's Pendant of Triumph
                {11, 24114}, -- Braided Eternium Chain (GROUP BUFF)
                {12, 33297}, -- The Savage's Choker
                {13, 32591}, -- Choker of Serrated Blades
                {14, 29119}, -- Haramad's Bargain
                {15, 28745} -- Mithril Chain of Heroism
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34388},
                {2, 34195},
                {3, 34194},
                {4, 34392},
                {5, 30055},
                {6, 32581},
                {7, 32570},
                {8, 32575},
                {9, 30997},
                {10, 32264},
                {11, 30866},
                {12, 30740},
                {13, 30053},
                {14, 35092},
                {15, 30133},
                {16, 28888 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34241},
                {2, 33590},
                {3, 32323},
                {4, 34190},
                {5, 33122},
                {6, 30098},
                {7, 29994},
                {8, 24259},
                {9, 30729},
                {10, 33484},
                {11, 28777},
                {12, 28672},
                {13, 34708},
                {14, 32665},
                {15, 29382},
                {16, 34004, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34369},
                {2, 34397},
                {3, 34215},
                {4, 34377},
                {5, 34211},
                {6, 30905},
                {7, 30990},
                {8, 35088},
                {9, 34942},
                {10, 34912},
                {11, 28485},
                {12, 30129},
                {13, 34373},
                {14, 32365},
                {15, 34906},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34431},
                {2, 32574},
                {3, 32580},
                {4, 32568},
                {5, 30863},
                {6, 30057},
                {7, 32324},
                {8, 30861},
                {9, 28795},
                {10, 33540},
                {11, 35176},
                {12, 35178},
                {13, 32251},
                {14, 33813},
                {15, 33910},
                {16, 27899, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34343},
                {2, 34370},
                {3, 34234},
                {4, 34341},
                {5, 34378},
                {6, 34374},
                {7, 34408},
                {8, 32347},
                {9, 32234},
                {10, 29947},
                {11, 32608},
                {12, 32278},
                {13, 34916},
                {14, 34911},
                {15, 33539},
                {16, 33995, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34485}, -- Lightbringer Girdle
                {2, 30106}, -- Belt of One-Hundred Deaths
                {3, 32265}, -- Shadow-walker's Cord
                {4, 30919}, -- Valestalker Girdle
                {5, 30879}, -- Don Alejandro's Money Belt
                {6, 30915}, -- Belt of Seething Fury
                {7, 32346}, -- Boneweave Girdle
                {8, 30032}, -- Red Belt of Battle
                {9, 32606}, -- Girdle of the Lightbearer
                {10, 34944}, -- Girdle of Seething Rage
                {11, 30040}, -- Belt of Deep Shadow
                {12, 34929}, -- Belt of the Silent Path
                {13, 33583}, -- Waistguard of the Great Beast
                {14, 33211}, -- Bladeangel's Money Belt
                {15, 28779} -- Girdle of the Endless Pit
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 34361},
                {2, 34189},
                {3, 32335},
                {4, 32526},
                {5, 34887},
                {6, 30834},
                {7, 29301},
                {8, 33496},
                {9, 29997},
                {10, 32497},
                {11, 35131},
                {12, 30061},
                {13, 32266},
                {14, 29300},
                {15, 30052},
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34180},
                {2, 34188},
                {3, 34168},
                {4, 34385},
                {5, 34943},
                {6, 30900},
                {7, 30903},
                {8, 32341},
                {9, 34910},
                {10, 30993},
                {11, 34381},
                {12, 33538},
                {13, 29950},
                {14, 29995},
                {15, 35091},
                {16, 29535 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34561},
                {2, 32345},
                {3, 32366},
                {4, 32510},
                {5, 33222},
                {6, 33303},
                {7, 29951},
                {8, 30104},
                {9, 35146},
                {10, 30880},
                {11, 33582},
                {12, 30081},
                {13, 35148},
                {14, 28608},
                {15, 34809},
                {16, 27951, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 28830}, -- Dragonspine Trophy
                {2, 34472}, -- Shard of Contempt
                {3, 34427}, -- Blackened Naaru Sliver
                {4, 34428}, -- Steely Naaru Sliver
                {5, 31856}, -- Darkmoon Card: Crusade
                {6, 23206}, -- Mark of the Champion (undead/demon)
                {7, 33831}, -- Berserker's Call
                {8, 30627}, -- Tsunami Talisman
                {9, 32505}, -- Madness of the Betrayer
                {10, 35702}, -- Figurine - Shadowsong Panther
                {11, 28288}, -- Abacus of Violent Odds
                {12, 29383}, -- Bloodlust Brooch
                {13, 28034}, -- Hourglass of the Unraveller
                {14, 23041}, -- Slayer's Crest
                {15, 22954} -- Kiss of the Spider
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {}
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {}
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34247},
                {2, 34183},
                {3, 34891},
                {4, 34989},
                {5, 35015},
                {6, 32332},
                {7, 30902},
                {8, 34997},
                {9, 35064},
                {10, 33663},
                {11, 33688},
                {12, 28430},
                {13, 29993},
                {14, 33670},
                {15, 32348},
                {16, 27984, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {}
        }

        --@end-version-bcc@
    }
}

































