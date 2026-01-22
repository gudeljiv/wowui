local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["DruidBear"] = {
    name = AL["Druid Bear BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34244},
                {2, 34404},
                {3, 34999},
                {4, 34353},
                {5, 31039},
                {6, 32235},
                {7, 33672},
                {8, 30228},
                {9, 33479},
                {10, 29098},
                {11, 32478},
                {12, 31968},
                {13, 32087},
                {14, 28127},
                {15, 32088},
                {16, 32409 },
                {17, 29192 },
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34178}, -- Collar of the Pit Lord
                {2, 33296}, -- Brooch of Deftness
                {3, 34358}, -- Hard Khorium Choker
                {4, 34177}, -- Clutch of Demise
                {5, 34680}, -- Shattered Sun Pendant of Resolve
                {6, 35135}, -- Guardian's Pendant of Triumph
                {7, 30017}, -- Telonicus's Pendant of Mayhem
                {8, 32591}, -- Choker of Serrated Blades
                {9, 28509}, -- Worgen Claw Necklace
                {10, 32362}, -- Pendant of Titans
                {11, 33923}, -- Vindicator's Pendant of Triumph
                {12, 29381}, -- Choker of Vile Intent
                {13, 35507}, -- Amulet of Bitter Hatred
                {14, 28674}, -- Saberclaw Talisman
                {15, 28745} -- Mithril Chain of Heroism
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34392},
                {2, 35001},
                {3, 34195},
                {4, 31048},
                {5, 33674},
                {6, 30230},
                {7, 30917},
                {8, 30055},
                {9, 29100},
                {10, 31971},
                {11, 32581},
                {12, 33300},
                {13, 34613},
                {14, 32377},
                {15, 28129},
                {16, 28888 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34190},
                {2, 34241},
                {3, 33593},
                {4, 29994},
                {5, 34010},
                {6, 28660},
                {7, 28256},
                {8, 32323},
                {9, 28672},
                {10, 34810},
                {11, 30098},
                {12, 33590},
                {13, 33484},
                {14, 24258},
                {15, 33122},
                {16, 34004, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34211},
                {2, 34369},
                {3, 31042},
                {4, 34397},
                {5, 35002},
                {6, 34906},
                {7, 30222},
                {8, 30905},
                {9, 32252},
                {10, 33675},
                {11, 34927},
                {12, 33579},
                {13, 29096},
                {14, 33329},
                {15, 31972},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34444},
                {2, 33580},
                {3, 35171},
                {4, 32324},
                {5, 33881},
                {6, 35167},
                {7, 33893},
                {8, 32580},
                {9, 30863},
                {10, 29966},
                {11, 33540},
                {12, 32810},
                {13, 32814},
                {14, 29263},
                {15, 28445},
                {16, 27914, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34408},
                {2, 34370},
                {3, 31034},
                {4, 34234},
                {5, 34911},
                {6, 34998},
                {7, 30223},
                {8, 29947},
                {9, 33671},
                {10, 32347},
                {11, 29097},
                {12, 30644},
                {13, 31967},
                {14, 33539},
                {15, 28506},
                {16, 25072, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34556}, -- Thunderheart Waistguard
                {2, 30106}, -- Belt of One-Hundred Deaths
                {3, 33583}, -- Waistguard of the Great Beast
                {4, 35152}, -- Guardian's Dragonhide Belt
                {5, 35156}, -- Guardian's Leather Belt
                {6, 34929}, -- Belt of the Silent Path
                {7, 30042}, -- Belt of Natural Power
                {8, 30879}, -- Don Alejandro's Money Belt
                {9, 33879}, -- Vindicator's Dragonhide Belt
                {10, 33891}, -- Vindicator's Leather Belt
                {11, 30040}, -- Belt of Deep Shadow
                {12, 32265}, -- Shadow-walker's Cord
                {13, 33211}, -- Bladeangel's Money Belt
                {14, 29264}, -- Tree-Mender's Belt
                {15, 32802} -- Veteran's Leather Belt
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 34361},
                {2, 34213},
                {3, 29301},
                {4, 32266},
                {5, 29300},
                {6, 32497},
                {7, 33496},
                {8, 34887},
                {9, 29299},
                {10, 30834},
                {11, 34189},
                {12, 29298},
                {13, 30052},
                {14, 32526},
                {15, 28649},
                {16, 27927, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34385},
                {2, 31044},
                {3, 34188},
                {4, 34910},
                {5, 30229},
                {6, 35000},
                {7, 30898},
                {8, 33673},
                {9, 29099},
                {10, 34928},
                {11, 33538},
                {12, 28741},
                {13, 29995},
                {14, 30535},
                {15, 31969},
                {16, 29536 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34573},
                {2, 32593},
                {3, 35137},
                {4, 35141},
                {5, 30041},
                {6, 32366},
                {7, 33582},
                {8, 33880},
                {9, 33222},
                {10, 33892},
                {11, 30060},
                {12, 30674},
                {13, 30891},
                {14, 28545},
                {15, 32790},
                {16, 34008, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 34472}, -- Shard of Contempt
                {2, 34428}, -- Steely Naaru Sliver
                {3, 32658}, -- Badge of Tenacity
                {4, 28830}, -- Dragonspine Trophy
                {5, 34427}, -- Blackened Naaru Sliver
                {6, 33830}, -- Ancient Aqir Artifact
                {7, 32505}, -- Madness of the Betrayer
                {8, 34473}, -- Commendation of Kael'thas
                {9, 30627}, -- Tsunami Talisman
                {10, 23206}, -- Mark of the Champion (undead/demon)
                {11, 33831}, -- Berserker's Call
                {12, 31858}, -- Darkmoon Card: Vengeance
                {13, 31859}, -- Darkmoon Card: Madness
                {14, 35700}, -- Figurine - Crimson Serpent
                {15, 35702} -- Figurine - Shadowsong Panther
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
                {1, 34198},
                {2, 35103},
                {3, 34898},
                {4, 33716},
                {5, 30883},
                {6, 33465},
                {7, 32014},
                {8, 30021},
                {9, 28658},
                {10, 28476},
                {11, 29359},
                {12, 29171},
                {13, 34989},
                {14, 31334},
                {15, 33663},
                {16, 27977, "Profession" },
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





































