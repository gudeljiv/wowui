local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["WarriorFury"] = {
    name = AL["Warrior Fury BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34333},
                {2, 34345},
                {3, 34244},
                {4, 32235},
                {5, 34354},
                {6, 35068},
                {7, 32373},
                {8, 30972},
                {9, 33730},
                {10, 32376},
                {11, 30120},
                {12, 32461},
                {13, 34404},
                {14, 29021},
                {15, 30488},
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
                {4, 32591}, -- Choker of Serrated Blades
                {5, 35292}, -- Sin'dorei Pendant of Triumph
                {6, 35135}, -- Guardian's Pendant of Triumph
                {7, 24114}, -- Braided Eternium Chain (GROUP BUFF)
                {8, 33923}, -- Vindicator's Pendant of Triumph
                {9, 30022}, -- Pendant of the Perilous
                {10, 30059}, -- Choker of Animalistic Fury
                {11, 30017}, -- Telonicus's Pendant of Mayhem
                {12, 33297}, -- The Savage's Choker
                {13, 33066}, -- Veteran's Pendant of Triumph
                {14, 33296}, -- Brooch of Deftness
                {15, 29349} -- Adamantine Chain of the Unbroken
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34388},
                {2, 34194},
                {3, 34195},
                {4, 34392},
                {5, 30979},
                {6, 32581},
                {7, 32570},
                {8, 32575},
                {9, 30055},
                {10, 35070},
                {11, 30866},
                {12, 32377},
                {13, 30740},
                {14, 32264},
                {15, 33514},
                {16, 28888 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34241},
                {2, 32323},
                {3, 33484},
                {4, 33590},
                {5, 30729},
                {6, 24259},
                {7, 33122},
                {8, 29994},
                {9, 28777},
                {10, 30098},
                {11, 34708},
                {12, 28672},
                {13, 34190},
                {14, 27892},
                {15, 32665},
                {16, 34004, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34397},
                {2, 34377},
                {3, 34369},
                {4, 34215},
                {5, 34211},
                {6, 35066},
                {7, 30975},
                {8, 30905},
                {9, 33728},
                {10, 28485},
                {11, 30101},
                {12, 32365},
                {13, 30118},
                {14, 33329},
                {15, 34912},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34441},
                {2, 30863},
                {3, 32574},
                {4, 30057},
                {5, 32580},
                {6, 32568},
                {7, 32324},
                {8, 28795},
                {9, 33540},
                {10, 30861},
                {11, 33513},
                {12, 35176},
                {13, 35178},
                {14, 32251},
                {15, 33529},
                {16, 27899, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34343},
                {2, 34370},
                {3, 34341},
                {4, 34234},
                {5, 34378},
                {6, 34374},
                {7, 34408},
                {8, 32278},
                {9, 32347},
                {10, 32234},
                {11, 32608},
                {12, 30969},
                {13, 34916},
                {14, 29947},
                {15, 33539},
                {16, 33995, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34546}, -- Onslaught Belt
                {2, 30106}, -- Belt of One-Hundred Deaths
                {3, 32346}, -- Boneweave Girdle
                {4, 32265}, -- Shadow-walker's Cord
                {5, 30919}, -- Valestalker Girdle
                {6, 33331}, -- Chain of Unleashed Rage
                {7, 30879}, -- Don Alejandro's Money Belt
                {8, 30032}, -- Red Belt of Battle
                {9, 33211}, -- Bladeangel's Money Belt
                {10, 30915}, -- Belt of Seething Fury
                {11, 30040}, -- Belt of Deep Shadow
                {12, 34929}, -- Belt of the Silent Path
                {13, 32606}, -- Girdle of the Lightbearer
                {14, 34944}, -- Girdle of Seething Rage
                {15, 28779} -- Girdle of the Endless Pit
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 34189},
                {2, 34361},
                {3, 32497},
                {4, 34887},
                {5, 33496},
                {6, 35131},
                {7, 32335},
                {8, 32526},
                {9, 29997},
                {10, 29301},
                {11, 33919},
                {12, 30738},
                {13, 28757},
                {14, 35284},
                {15, 32266},
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34188},
                {2, 34180},
                {3, 32341},
                {4, 34385},
                {5, 34168},
                {6, 35069},
                {7, 34943},
                {8, 30977},
                {9, 30900},
                {10, 30903},
                {11, 33731},
                {12, 30898},
                {13, 29995},
                {14, 34910},
                {15, 29950},
                {16, 29535 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34569},
                {2, 32345},
                {3, 32366},
                {4, 32510},
                {5, 34809},
                {6, 33222},
                {7, 35146},
                {8, 33303},
                {9, 34807},
                {10, 30039},
                {11, 30880},
                {12, 29951},
                {13, 30104},
                {14, 30081},
                {15, 35148},
                {16, 34007, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 28830}, -- Dragonspine Trophy
                {2, 30446}, -- Solarian's Sapphire (Group AP Buff)
                {3, 34427}, -- Blackened Naaru Sliver
                {4, 34472}, -- Shard of Contempt
                {5, 34428}, -- Steely Naaru Sliver
                {6, 32505}, -- Madness of the Betrayer
                {7, 30627}, -- Tsunami Talisman
                {8, 23206}, -- Mark of the Champion (undead/demon)
                {9, 33831}, -- Berserker's Call
                {10, 35702}, -- Figurine - Shadowsong Panther
                {11, 28034}, -- Hourglass of the Unraveller
                {12, 31856}, -- Darkmoon Card: Crusade
                {13, 28288}, -- Abacus of Violent Odds
                {14, 29383}, -- Bloodlust Brooch
                {15, 22954} -- Kiss of the Spider
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 32837},
                {2, 34346},
                {3, 35076},
                {4, 34995},
                {5, 35037},
                {6, 34996},
                {7, 35071},
                {8, 34214},
                {9, 34331},
                {10, 32262},
                {11, 33737},
                {12, 34015},
                {13, 34016},
                {14, 33669},
                {15, 33733},
                {16, 27984, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34346},
                {2, 34995},
                {3, 35037},
                {4, 34996},
                {5, 35071},
                {6, 34214},
                {7, 32262},
                {8, 34015},
                {9, 34016},
                {10, 33669},
                {11, 33733},
                {12, 29996},
                {13, 35101},
                {14, 30881},
                {15, 30082},
                {16, 27984, "Profession" },
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
                {1, 34334},
                {2, 34196},
                {3, 33474},
                {4, 34892},
                {5, 33491},
                {6, 30105},
                {7, 30724},
                {8, 28772},
                {9, 30279},
                {10, 29949},
                {11, 29151},
                {12, 29152},
                {13, 30906},
                {14, 28581},
                {15, 22812},
                {16, 23765 },
            }
        }

        --@end-version-bcc@
    }
}






















