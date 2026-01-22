local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["HunterSurv"] = {
    name = AL["Hunter Surv BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34333},
                {2, 34244},
                {3, 32235},
                {4, 34992},
                {5, 32376},
                {6, 31003},
                {7, 33666},
                {8, 31962},
                {9, 30141},
                {10, 33479},
                {11, 34404},
                {12, 28331},
                {13, 33432},
                {14, 32087},
                {15, 29081},
                {16, 32409 },
                {17, 29192 },
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34177}, -- Clutch of Demise
                {2, 30017}, -- Telonicus's Pendant of Mayhem
                {3, 34358}, -- Hard Khorium Choker
                {4, 32508}, -- Necklace of the Deep
                {5, 29381}, -- Choker of Vile Intent
                {6, 35507}, -- Amulet of Bitter Hatred
                {7, 28509}, -- Worgen Claw Necklace
                {8, 19377}, -- Prestor's Talisman of Connivery
                {9, 28343}, -- Jagged Bark Pendant
                {10, 25562}, -- Earthen Mark of Razing
                {11, 34679}, -- Shattered Sun Pendant of Might
                {12, 28674}, -- Saberclaw Talisman
                {13, 27779}, -- Bone Chain Necklace
                {14, 32260}, -- Choker of Endless Nightmares
                {15, 31147} -- Pendant of Cunning
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34194},
                {2, 34195},
                {3, 34994},
                {4, 31006},
                {5, 32264},
                {6, 32581},
                {7, 30055},
                {8, 32575},
                {9, 33668},
                {10, 33206},
                {11, 30892},
                {12, 34392},
                {13, 34613},
                {14, 30143},
                {15, 31964},
                {16, 28888 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34241},
                {2, 29994},
                {3, 33590},
                {4, 28672},
                {5, 31255},
                {6, 29382},
                {7, 35495},
                {8, 27519},
                {9, 27878},
                {10, 32540},
                {11, 32323},
                {12, 21710},
                {13, 27423},
                {14, 32665},
                {15, 32539},
                {16, 34004, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34369},
                {2, 34397},
                {3, 34373},
                {4, 32334},
                {5, 34927},
                {6, 34912},
                {7, 30907},
                {8, 33329},
                {9, 34990},
                {10, 31004},
                {11, 32252},
                {12, 34228},
                {13, 30139},
                {14, 30054},
                {15, 34211},
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
                {5, 35166},
                {6, 30864},
                {7, 29966},
                {8, 33540},
                {9, 32251},
                {10, 33529},
                {11, 33876},
                {12, 29246},
                {13, 30026},
                {14, 32814},
                {15, 32647},
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
                {4, 31001},
                {5, 34374},
                {6, 34916},
                {7, 32347},
                {8, 32234},
                {9, 34991},
                {10, 33539},
                {11, 30140},
                {12, 34408},
                {13, 28506},
                {14, 33665},
                {15, 33528},
                {16, 25080, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34549}, -- Gronnstalker's Belt
                {2, 32346}, -- Boneweave Girdle
                {3, 30879}, -- Don Alejandro's Money Belt
                {4, 34929}, -- Belt of the Silent Path
                {5, 32265}, -- Shadow-walker's Cord
                {6, 30919}, -- Valestalker Girdle
                {7, 30040}, -- Belt of Deep Shadow
                {8, 35151}, -- Guardian's Chain Girdle
                {9, 30106}, -- Belt of One-Hundred Deaths
                {10, 33211}, -- Bladeangel's Money Belt
                {11, 33877}, -- Vindicator's Chain Girdle
                {12, 29247}, -- Girdle of the Deathdealer
                {13, 33280}, -- War-Feathered Loop
                {14, 28750}, -- Girdle of Treachery
                {15, 33583} -- Waistguard of the Great Beast
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 34361},
                {2, 34887},
                {3, 33496},
                {4, 29301},
                {5, 29300},
                {6, 30052},
                {7, 29299},
                {8, 32266},
                {9, 29298},
                {10, 28791},
                {11, 34189},
                {12, 28649},
                {13, 31277},
                {14, 22961},
                {15, 32942},
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34188},
                {2, 34168},
                {3, 30898},
                {4, 30900},
                {5, 30739},
                {6, 29995},
                {7, 33538},
                {8, 34385},
                {9, 34993},
                {10, 31005},
                {11, 30142},
                {12, 28741},
                {13, 29985},
                {14, 33527},
                {15, 33667},
                {16, 29535 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34570},
                {2, 32366},
                {3, 33222},
                {4, 32510},
                {5, 30104},
                {6, 34809},
                {7, 30880},
                {8, 30060},
                {9, 35136},
                {10, 28545},
                {11, 29951},
                {12, 28746},
                {13, 33878},
                {14, 33805},
                {15, 30045},
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
                {8, 32658}, -- Badge of Tenacity
                {9, 31856}, -- Darkmoon Card: Crusade
                {10, 29383}, -- Bloodlust Brooch
                {11, 28288}, -- Abacus of Violent Odds
                {12, 23041}, -- Slayer's Crest
                {13, 28034}, -- Hourglass of the Unraveller
                {14, 34472}, -- Shard of Contempt
                {15, 22954} -- Kiss of the Spider
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34197},
                {2, 34329},
                {3, 34165},
                {4, 34893},
                {5, 30881},
                {6, 33389},
                {7, 29924},
                {8, 32269},
                {9, 34331},
                {10, 34616},
                {11, 29948},
                {12, 30082},
                {13, 33495},
                {14, 32946},
                {15, 32945},
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
                {2, 32248},
                {3, 34247},
                {4, 33492},
                {5, 34891},
                {6, 28587},
                {7, 29329},
                {8, 27903},
                {9, 29166},
                {10, 29167},
                {11, 34997},
                {12, 29993},
                {13, 28429},
                {14, 28430},
                {15, 33670},
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
                {6, 32253},
                {7, 29949},
                {8, 34892},
                {9, 30724},
                {10, 30906},
                {11, 33006},
                {12, 34529},
                {13, 34530},
                {14, 28772},
                {15, 30105},
                {16, 23766 },
            }
        }

        --@end-version-bcc@
    }
}





































