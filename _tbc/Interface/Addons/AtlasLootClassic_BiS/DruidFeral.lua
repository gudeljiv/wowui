local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["DruidFeral"] = {
    name = AL["Druid Feral BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34244},
                {2, 32235},
                {3, 34353},
                {4, 34999},
                {5, 33479},
                {6, 33672},
                {7, 34404},
                {8, 32478},
                {9, 28732},
                {10, 31039},
                {11, 31109},
                {12, 28796},
                {13, 32087},
                {14, 29502},
                {15, 30228},
                {16, 32409 },
                {17, 29192 },
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 32260}, -- Choker of Endless Nightmares
                {2, 34358}, -- Hard Khorium Choker
                {3, 34177}, -- Clutch of Demise
                {4, 24114}, -- Braided Eternium Chain (GROUP BUFF)
                {5, 29381}, -- Choker of Vile Intent
                {6, 35507}, -- Amulet of Bitter Hatred
                {7, 28509}, -- Worgen Claw Necklace
                {8, 30017}, -- Telonicus's Pendant of Mayhem
                {9, 35292}, -- Sin'dorei Pendant of Triumph
                {10, 35135}, -- Guardian's Pendant of Triumph
                {11, 32591}, -- Choker of Serrated Blades
                {12, 31275}, -- Necklace of Trophies
                {13, 29119}, -- Haramad's Bargain
                {14, 27779}, -- Bone Chain Necklace
                {15, 32508} -- Necklace of the Deep
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34392},
                {2, 34195},
                {3, 35001},
                {4, 31048},
                {5, 33674},
                {6, 30055},
                {7, 30230},
                {8, 34613},
                {9, 27797},
                {10, 32377},
                {11, 29100},
                {12, 33300},
                {13, 30917},
                {14, 32581},
                {15, 28755},
                {16, 28888 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34241},
                {2, 32323},
                {3, 28672},
                {4, 29994},
                {5, 30098},
                {6, 33590},
                {7, 31255},
                {8, 33484},
                {9, 33122},
                {10, 27878},
                {11, 24259},
                {12, 30729},
                {13, 29382},
                {14, 35495},
                {15, 27892},
                {16, 34004, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34397},
                {2, 34369},
                {3, 34211},
                {4, 35002},
                {5, 32252},
                {6, 30905},
                {7, 33675},
                {8, 34927},
                {9, 30101},
                {10, 31042},
                {11, 33329},
                {12, 33204},
                {13, 33579},
                {14, 30730},
                {15, 34906},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34444},
                {2, 32324},
                {3, 33881},
                {4, 35171},
                {5, 30863},
                {6, 33540},
                {7, 35167},
                {8, 33893},
                {9, 29966},
                {10, 33580},
                {11, 32580},
                {12, 30685},
                {13, 32814},
                {14, 32647},
                {15, 28171},
                {16, 34002, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34370},
                {2, 34234},
                {3, 34408},
                {4, 34998},
                {5, 34911},
                {6, 29947},
                {7, 31034},
                {8, 28506},
                {9, 32347},
                {10, 25969},
                {11, 25685},
                {12, 33671},
                {13, 30644},
                {14, 33539},
                {15, 28776},
                {16, 25080, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34556}, -- Thunderheart Waistguard
                {2, 30106}, -- Belt of One-Hundred Deaths
                {3, 30040}, -- Belt of Deep Shadow
                {4, 34929}, -- Belt of the Silent Path
                {5, 30879}, -- Don Alejandro's Money Belt
                {6, 33583}, -- Waistguard of the Great Beast
                {7, 33211}, -- Bladeangel's Money Belt
                {8, 35152}, -- Guardian's Dragonhide Belt
                {9, 35156}, -- Guardian's Leather Belt
                {10, 32265}, -- Shadow-walker's Cord
                {11, 33879}, -- Vindicator's Dragonhide Belt
                {12, 29247}, -- Girdle of the Deathdealer
                {13, 30676}, -- Lurker's Grasp of the Tiger
                {14, 30042}, -- Belt of Natural Power
                {15, 28828} -- Gronn-Stitched Girdle
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 32497},
                {2, 34887},
                {3, 34189},
                {4, 33496},
                {5, 34361},
                {6, 30052},
                {7, 32266},
                {8, 29301},
                {9, 29997},
                {10, 28649},
                {11, 29300},
                {12, 28757},
                {13, 30738},
                {14, 32335},
                {15, 30834},
                {16, 27927, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34188},
                {2, 34385},
                {3, 31044},
                {4, 35000},
                {5, 28741},
                {6, 30898},
                {7, 34910},
                {8, 29995},
                {9, 30229},
                {10, 33673},
                {11, 34928},
                {12, 27837},
                {13, 25687},
                {14, 33538},
                {15, 30538},
                {16, 29536 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 33222},
                {2, 34573},
                {3, 32366},
                {4, 28545},
                {5, 35137},
                {6, 34809},
                {7, 33582},
                {8, 35141},
                {9, 25686},
                {10, 33880},
                {11, 30039},
                {12, 30681},
                {13, 30041},
                {14, 30891},
                {15, 30060},
                {16, 34007, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 34472}, -- Shard of Contempt
                {2, 32505}, -- Madness of the Betrayer
                {3, 28830}, -- Dragonspine Trophy
                {4, 34427}, -- Blackened Naaru Sliver
                {5, 30627}, -- Tsunami Talisman
                {6, 34428}, -- Steely Naaru Sliver
                {7, 23206}, -- Mark of the Champion (undead/demon)
                {8, 33831}, -- Berserker's Call
                {9, 28121}, -- Icon of Unyielding Courage
                {10, 35702}, -- Figurine - Shadowsong Panther
                {11, 28034}, -- Hourglass of the Unraveller
                {12, 19406}, -- Drake Fang Talisman
                {13, 31856}, -- Darkmoon Card: Crusade
                {14, 29383}, -- Bloodlust Brooch
                {15, 28579} -- Romulo's Poison Vial
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
                {5, 33465},
                {6, 32014},
                {7, 30883},
                {8, 28658},
                {9, 28476},
                {10, 30021},
                {11, 29359},
                {12, 31334},
                {13, 29171},
                {14, 27877},
                {15, 30010},
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





































