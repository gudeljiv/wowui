local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["ShamanEnh"] = {
    name = AL["Shaman Enh BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34244},
                {2, 34333},
                {3, 32235},
                {4, 34356},
                {5, 35044},
                {6, 32376},
                {7, 31015},
                {8, 34404},
                {9, 30190},
                {10, 32474},
                {11, 33708},
                {12, 32087},
                {13, 33479},
                {14, 32006},
                {15, 28182},
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
                {4, 24114}, -- Braided Eternium Chain (GROUP BUFF)
                {5, 32591}, -- Choker of Serrated Blades
                {6, 35135}, -- Guardian's Pendant of Triumph
                {7, 35292}, -- Sin'dorei Pendant of Triumph
                {8, 30017}, -- Telonicus's Pendant of Mayhem
                {9, 30022}, -- Pendant of the Perilous
                {10, 29381}, -- Choker of Vile Intent
                {11, 35507}, -- Amulet of Bitter Hatred
                {12, 28509}, -- Worgen Claw Necklace
                {13, 30059}, -- Choker of Animalistic Fury
                {14, 33923}, -- Vindicator's Pendant of Triumph
                {15, 33296} -- Brooch of Deftness
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34195},
                {2, 34194},
                {3, 34392},
                {4, 32581},
                {5, 32575},
                {6, 32377},
                {7, 30055},
                {8, 32264},
                {9, 33206},
                {10, 31024},
                {11, 34613},
                {12, 30917},
                {13, 30085},
                {14, 35046},
                {15, 33300},
                {16, 28888 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34241},
                {2, 32323},
                {3, 33590},
                {4, 29994},
                {5, 30098},
                {6, 33484},
                {7, 30729},
                {8, 24259},
                {9, 33122},
                {10, 28672},
                {11, 28777},
                {12, 34708},
                {13, 27878},
                {14, 28529},
                {15, 27892},
                {16, 34004, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34369},
                {2, 34397},
                {3, 34211},
                {4, 30905},
                {5, 34927},
                {6, 32252},
                {7, 34912},
                {8, 30101},
                {9, 35042},
                {10, 30907},
                {11, 30730},
                {12, 34906},
                {13, 30185},
                {14, 33329},
                {15, 31018},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34439},
                {2, 32574},
                {3, 30863},
                {4, 32324},
                {5, 32580},
                {6, 33540},
                {7, 32251},
                {8, 35172},
                {9, 33529},
                {10, 35166},
                {11, 33894},
                {12, 30091},
                {13, 30026},
                {14, 30685},
                {15, 29966},
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
                {4, 34374},
                {5, 34408},
                {6, 32347},
                {7, 32234},
                {8, 34916},
                {9, 29947},
                {10, 33539},
                {11, 34911},
                {12, 31011},
                {13, 30189},
                {14, 33528},
                {15, 30644},
                {16, 33995, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34545}, -- Skyshatter Girdle
                {2, 30106}, -- Belt of One-Hundred Deaths
                {3, 32346}, -- Boneweave Girdle
                {4, 32265}, -- Shadow-walker's Cord
                {5, 30919}, -- Valestalker Girdle
                {6, 34929}, -- Belt of the Silent Path
                {7, 30879}, -- Don Alejandro's Money Belt
                {8, 30040}, -- Belt of Deep Shadow
                {9, 33583}, -- Waistguard of the Great Beast
                {10, 33211}, -- Bladeangel's Money Belt
                {11, 30046}, -- Belt of the Black Eagle
                {12, 35157}, -- Guardian's Linked Girdle
                {13, 28828}, -- Gronn-Stitched Girdle
                {14, 30676}, -- Lurker's Grasp of the Tiger
                {15, 35151} -- Guardian's Chain Girdle
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
                {6, 29301},
                {7, 29997},
                {8, 32335},
                {9, 32526},
                {10, 32266},
                {11, 30052},
                {12, 30738},
                {13, 35131},
                {14, 28757},
                {15, 29300},
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34188},
                {2, 34168},
                {3, 34385},
                {4, 30900},
                {5, 30898},
                {6, 34910},
                {7, 33538},
                {8, 29995},
                {9, 35045},
                {10, 30739},
                {11, 31021},
                {12, 28741},
                {13, 30192},
                {14, 31544},
                {15, 33527},
                {16, 29535 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34567},
                {2, 32510},
                {3, 32366},
                {4, 33222},
                {5, 30880},
                {6, 30891},
                {7, 30039},
                {8, 34809},
                {9, 30104},
                {10, 35142},
                {11, 28545},
                {12, 33582},
                {13, 29951},
                {14, 25686},
                {15, 30041},
                {16, 34007, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 28830}, -- Dragonspine Trophy
                {2, 34427}, -- Blackened Naaru Sliver
                {3, 34472}, -- Shard of Contempt
                {4, 32505}, -- Madness of the Betrayer
                {5, 31856}, -- Darkmoon Card: Crusade
                {6, 34428}, -- Steely Naaru Sliver
                {7, 23206}, -- Mark of the Champion (undead/demon)
                {8, 33831}, -- Berserker's Call
                {9, 32491}, -- Ashtongue Talisman of Vision
                {10, 30627}, -- Tsunami Talisman
                {11, 35702}, -- Figurine - Shadowsong Panther
                {12, 29383}, -- Bloodlust Brooch
                {13, 23041}, -- Slayer's Crest
                {14, 28288}, -- Abacus of Violent Odds
                {15, 28034} -- Hourglass of the Unraveller
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34331},
                {2, 34203},
                {3, 34346},
                {4, 34988},
                {5, 35017},
                {6, 35038},
                {7, 35076},
                {8, 34995},
                {9, 35037},
                {10, 34996},
                {11, 35071},
                {12, 34950},
                {13, 34951},
                {14, 34893},
                {15, 32943},
                {16, 27984, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {}
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {}
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {}
        }
        --@end-version-bcc@
    }
}

