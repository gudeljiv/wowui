local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["HunterBM"] = {
    name = AL["Hunter BM BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34333},
                {2, 34244},
                {3, 32235},
                {4, 34356},
                {5, 34992},
                {6, 32376},
                {7, 33666},
                {8, 31003},
                {9, 32474},
                {10, 33479},
                {11, 30141},
                {12, 31962},
                {13, 33432},
                {14, 32087},
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
                {4, 30017}, -- Telonicus's Pendant of Mayhem
                {5, 32591}, -- Choker of Serrated Blades
                {6, 35292}, -- Sin'dorei Pendant of Triumph
                {7, 24114}, -- Braided Eternium Chain (GROUP BUFF)
                {8, 35135}, -- Guardian's Pendant of Triumph
                {9, 29381}, -- Choker of Vile Intent
                {10, 35507}, -- Amulet of Bitter Hatred
                {11, 28509}, -- Worgen Claw Necklace
                {12, 34679}, -- Shattered Sun Pendant of Might
                {13, 30059}, -- Choker of Animalistic Fury
                {14, 33923}, -- Vindicator's Pendant of Triumph
                {15, 27779} -- Bone Chain Necklace
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34194},
                {2, 34195},
                {3, 31006},
                {4, 32581},
                {5, 32264},
                {6, 32575},
                {7, 32377},
                {8, 34994},
                {9, 33206},
                {10, 30917},
                {11, 34613},
                {12, 30055},
                {13, 30085},
                {14, 33300},
                {15, 30892},
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
                {5, 33484},
                {6, 28672},
                {7, 30729},
                {8, 24259},
                {9, 29382},
                {10, 35495},
                {11, 28777},
                {12, 27878},
                {13, 31255},
                {14, 32540},
                {15, 34708},
                {16, 34004, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34397},
                {2, 34369},
                {3, 30905},
                {4, 34927},
                {5, 32252},
                {6, 30907},
                {7, 34912},
                {8, 34990},
                {9, 33329},
                {10, 31004},
                {11, 32334},
                {12, 30139},
                {13, 30101},
                {14, 30054},
                {15, 33664},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34443},
                {2, 32324},
                {3, 32574},
                {4, 32580},
                {5, 30863},
                {6, 33540},
                {7, 32251},
                {8, 35166},
                {9, 33529},
                {10, 29966},
                {11, 30864},
                {12, 30026},
                {13, 33876},
                {14, 30091},
                {15, 34698},
                {16, 34002, "Profession" },
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
                {5, 31001},
                {6, 32347},
                {7, 32234},
                {8, 34916},
                {9, 33539},
                {10, 30140},
                {11, 34991},
                {12, 33528},
                {13, 28506},
                {14, 28776},
                {15, 34408},
                {16, 25080, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34549}, -- Gronnstalker's Belt
                {2, 32346}, -- Boneweave Girdle
                {3, 34929}, -- Belt of the Silent Path
                {4, 30879}, -- Don Alejandro's Money Belt
                {5, 32265}, -- Shadow-walker's Cord
                {6, 30919}, -- Valestalker Girdle
                {7, 30040}, -- Belt of Deep Shadow
                {8, 33211}, -- Bladeangel's Money Belt
                {9, 30106}, -- Belt of One-Hundred Deaths
                {10, 30046}, -- Belt of the Black Eagle
                {11, 35151}, -- Guardian's Chain Girdle
                {12, 29247}, -- Girdle of the Deathdealer
                {13, 28828}, -- Gronn-Stitched Girdle
                {14, 25789}, -- Rune-Engraved Belt
                {15, 33280} -- War-Feathered Loop
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 34361},
                {2, 34189},
                {3, 34887},
                {4, 33496},
                {5, 32497},
                {6, 29301},
                {7, 32266},
                {8, 30052},
                {9, 29997},
                {10, 29300},
                {11, 32526},
                {12, 35131},
                {13, 30738},
                {14, 29299},
                {15, 28757},
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34188},
                {2, 34168},
                {3, 30900},
                {4, 30898},
                {5, 29995},
                {6, 34993},
                {7, 33538},
                {8, 31005},
                {9, 30739},
                {10, 28741},
                {11, 30142},
                {12, 33527},
                {13, 33667},
                {14, 29985},
                {15, 34385},
                {16, 29535 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34570},
                {2, 32510},
                {3, 32366},
                {4, 33222},
                {5, 34809},
                {6, 30880},
                {7, 29951},
                {8, 30104},
                {9, 35136},
                {10, 28545},
                {11, 33805},
                {12, 30039},
                {13, 30891},
                {14, 30045},
                {15, 30060},
                {16, 34007, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 28830}, -- Dragonspine Trophy
                {2, 34427}, -- Blackened Naaru Sliver
                {3, 32505}, -- Madness of the Betrayer
                {4, 23206}, -- Mark of the Champion (undead/demon)
                {5, 33831}, -- Berserker's Call
                {6, 30627}, -- Tsunami Talisman
                {7, 35702}, -- Figurine - Shadowsong Panther
                {8, 31856}, -- Darkmoon Card: Crusade
                {9, 29383}, -- Bloodlust Brooch
                {10, 23041}, -- Slayer's Crest
                {11, 28034}, -- Hourglass of the Unraveller
                {12, 28288}, -- Abacus of Violent Odds
                {13, 34472}, -- Shard of Contempt
                {14, 30448}, -- Talon of Al'ar
                {15, 19406} -- Drake Fang Talisman
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34197},
                {2, 34329},
                {3, 34331},
                {4, 34165},
                {5, 34203},
                {6, 34893},
                {7, 33389},
                {8, 34346},
                {9, 30881},
                {10, 34950},
                {11, 34951},
                {12, 30865},
                {13, 32944},
                {14, 30082},
                {15, 32369},
                {16, 42620, "Profession" },
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
            [NORMAL_DIFF] = {
                {1, 34183},
                {2, 34247},
                {3, 34891},
                {4, 32248},
                {5, 34997},
                {6, 33670},
                {7, 34014},
                {8, 29993},
                {9, 30789},
                {10, 33492},
                {11, 28436},
                {12, 33478},
                {13, 28435},
                {14, 35064},
                {15, 31966},
                {16, 42620, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {
                {1, 34334},
                {2, 34196},
                {3, 35018},
                {4, 35047},
                {5, 35075},
                {6, 34892},
                {7, 33006},
                {8, 34529},
                {9, 34530},
                {10, 30906},
                {11, 32336},
                {12, 30105},
                {13, 29949},
                {14, 32253},
                {15, 33474},
                {16, 23766 },
            }
        }

        --@end-version-bcc@
    }
}





































