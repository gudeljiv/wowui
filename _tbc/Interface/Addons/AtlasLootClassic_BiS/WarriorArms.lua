local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["WarriorArms"] = {
    name = AL["Warrior Arms BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34333},
                {2, 34345},
                {3, 34354},
                {4, 34244},
                {5, 32235},
                {6, 32373},
                {7, 35068},
                {8, 30972},
                {9, 33730},
                {10, 30120},
                {11, 32376},
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
                {2, 32260}, -- Choker of Endless Nightmares
                {3, 32591}, -- Choker of Serrated Blades
                {4, 34177}, -- Clutch of Demise
                {5, 35292}, -- Sin'dorei Pendant of Triumph
                {6, 35135}, -- Guardian's Pendant of Triumph
                {7, 24114}, -- Braided Eternium Chain (GROUP BUFF)
                {8, 30022}, -- Pendant of the Perilous
                {9, 33923}, -- Vindicator's Pendant of Triumph
                {10, 30059}, -- Choker of Animalistic Fury
                {11, 30017}, -- Telonicus's Pendant of Mayhem
                {12, 33066}, -- Veteran's Pendant of Triumph
                {13, 29381}, -- Choker of Vile Intent
                {14, 35507}, -- Amulet of Bitter Hatred
                {15, 28509} -- Worgen Claw Necklace
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34194},
                {2, 34388},
                {3, 34392},
                {4, 30979},
                {5, 34195},
                {6, 30866},
                {7, 35070},
                {8, 30740},
                {9, 32377},
                {10, 30055},
                {11, 30122},
                {12, 33514},
                {13, 30053},
                {14, 32264},
                {15, 33732},
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
                {4, 33122},
                {5, 30729},
                {6, 24259},
                {7, 29994},
                {8, 30098},
                {9, 33590},
                {10, 28777},
                {11, 28672},
                {12, 27892},
                {13, 28371},
                {14, 27878},
                {15, 29382},
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
                {4, 34211},
                {5, 34215},
                {6, 35066},
                {7, 30905},
                {8, 30975},
                {9, 33728},
                {10, 28485},
                {11, 32365},
                {12, 30101},
                {13, 30118},
                {14, 32252},
                {15, 28484},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34441},
                {2, 30863},
                {3, 30057},
                {4, 32324},
                {5, 30861},
                {6, 28795},
                {7, 33540},
                {8, 35176},
                {9, 33513},
                {10, 35178},
                {11, 32251},
                {12, 30091},
                {13, 33813},
                {14, 32574},
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
                {4, 34408},
                {5, 32278},
                {6, 34234},
                {7, 34378},
                {8, 34374},
                {9, 30969},
                {10, 34916},
                {11, 28824},
                {12, 28776},
                {13, 35067},
                {14, 29947},
                {15, 33528},
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
                {4, 30032}, -- Red Belt of Battle
                {5, 30879}, -- Don Alejandro's Money Belt
                {6, 33331}, -- Chain of Unleashed Rage
                {7, 33211}, -- Bladeangel's Money Belt
                {8, 34929}, -- Belt of the Silent Path
                {9, 30040}, -- Belt of Deep Shadow
                {10, 33583}, -- Waistguard of the Great Beast
                {11, 28779}, -- Girdle of the Endless Pit
                {12, 30046}, -- Belt of the Black Eagle
                {13, 35161}, -- Guardian's Plate Belt
                {14, 28828}, -- Gronn-Stitched Girdle
                {15, 32265} -- Shadow-walker's Cord
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 34189},
                {2, 32497},
                {3, 34887},
                {4, 33496},
                {5, 32335},
                {6, 29997},
                {7, 34361},
                {8, 35131},
                {9, 29301},
                {10, 30738},
                {11, 28757},
                {12, 33919},
                {13, 32266},
                {14, 35284},
                {15, 30052},
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
                {7, 30977},
                {8, 30903},
                {9, 30900},
                {10, 33731},
                {11, 34943},
                {12, 30898},
                {13, 29950},
                {14, 30121},
                {15, 29995},
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
                {5, 33222},
                {6, 34809},
                {7, 35146},
                {8, 33303},
                {9, 30880},
                {10, 30039},
                {11, 34807},
                {12, 30081},
                {13, 35148},
                {14, 29951},
                {15, 30104},
                {16, 34007, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 30446}, -- Solarian's Sapphire (Group AP Buff)
                {2, 34472}, -- Shard of Contempt
                {3, 34427}, -- Blackened Naaru Sliver
                {4, 28830}, -- Dragonspine Trophy
                {5, 32505}, -- Madness of the Betrayer
                {6, 30627}, -- Tsunami Talisman
                {7, 34428}, -- Steely Naaru Sliver
                {8, 23206}, -- Mark of the Champion (undead/demon)
                {9, 33831}, -- Berserker's Call
                {10, 35702}, -- Figurine - Shadowsong Panther
                {11, 31856}, -- Darkmoon Card: Crusade
                {12, 29383}, -- Bloodlust Brooch
                {13, 28034}, -- Hourglass of the Unraveller
                {14, 23041}, -- Slayer's Crest
                {15, 28288} -- Abacus of Violent Odds
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
                {3, 34989},
                {4, 35015},
                {5, 34997},
                {6, 30902},
                {7, 35064},
                {8, 34891},
                {9, 33663},
                {10, 33688},
                {11, 33670},
                {12, 32348},
                {13, 33727},
                {14, 29993},
                {15, 32332},
                {16, 27984, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {
                {1, 34334},
                {2, 34196},
                {3, 34892},
                {4, 33474},
                {5, 34349},
                {6, 35108},
                {7, 30105},
                {8, 30724},
                {9, 32326},
                {10, 33765},
                {11, 28772},
                {12, 32054},
                {13, 33491},
                {14, 30279},
                {15, 34603},
                {16, 23765 },
            }
        }
    }
}























