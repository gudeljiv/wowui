local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["PalHoly"] = {
    name = AL["Paladin Holy BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34402},
                {2, 34339},
                {3, 34243},
                {4, 34245},
                {5, 35185},
                {6, 35183},
                {7, 30988},
                {8, 32354},
                {9, 35181},
                {10, 32241},
                {11, 30728},
                {12, 30136},
                {13, 33286},
                {14, 33327},
                {15, 32240},
                {16, 25901 },
                {17, 29190 },
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34360}, -- Amulet of Flowing Life
                {2, 33281}, -- Brooch of Nature's Mercy
                {3, 37929}, -- Guardian's Pendant of Reprieve
                {4, 34184}, -- Brooch of the Highborne
                {5, 35317}, -- Vindicator's Pendant of Reprieve
                {6, 32370}, -- Nadina's Pendant of Purity
                {7, 35291}, -- Sin'dorei Pendant of Salvation
                {8, 30018}, -- Lord Sanguinar's Claim
                {9, 35134}, -- Guardian's Pendant of Salvation
                {10, 30726}, -- Archaic Charm of Presence
                {11, 33922}, -- Vindicator's Pendant of Salvation
                {12, 34359}, -- Pendant of Sunfire
                {13, 33068}, -- Veteran's Pendant of Salvation
                {14, 34677}, -- Shattered Sun Pendant of Restoration
                {15, 28609} -- Emberspur Talisman
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34202},
                {2, 34208},
                {3, 34209},
                {4, 34193},
                {5, 30996},
                {6, 32579},
                {7, 30878},
                {8, 32583},
                {9, 32573},
                {10, 30138},
                {11, 30097},
                {12, 35063},
                {13, 33464},
                {14, 32585},
                {15, 33287},
                {16, 28887 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 32524},
                {2, 33592},
                {3, 34205},
                {4, 29989},
                {5, 32337},
                {6, 34242},
                {7, 35324},
                {8, 34012},
                {9, 34702},
                {10, 31329},
                {11, 28765},
                {12, 29354},
                {13, 32653},
                {14, 24254},
                {15, 28582},
                {16, 27962, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34365},
                {2, 34375},
                {3, 34212},
                {4, 34233},
                {5, 34229},
                {6, 34371},
                {7, 30992},
                {8, 30134},
                {9, 33469},
                {10, 29062},
                {11, 21875},
                {12, 34605},
                {13, 33216},
                {14, 33203},
                {15, 35059},
                {16, 33991, "Profession" },
            },

        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34432},
                {2, 32571},
                {3, 32584},
                {4, 32577},
                {5, 32582},
                {6, 30862},
                {7, 35175},
                {8, 30869},
                {9, 30868},
                {10, 30871},
                {11, 30047},
                {12, 33520},
                {13, 33589},
                {14, 33904},
                {15, 30684},
                {16, 27911, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34240},
                {2, 34372},
                {3, 32328},
                {4, 34376},
                {5, 34409},
                {6, 34342},
                {7, 34380},
                {8, 34351},
                {9, 34367},
                {10, 32275},
                {11, 30112},
                {12, 32353},
                {13, 29976},
                {14, 34791},
                {15, 34700},
                {16, 33999, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34487}, -- Lightbringer Belt
                {2, 30895}, -- Angelista's Sash
                {3, 32258}, -- Naturalist's Preserving Cinch
                {4, 32339}, -- Belt of Primal Majesty
                {5, 30897}, -- Girdle of Hope
                {6, 33446}, -- Girdle of Stromgarde's Hope
                {7, 32512}, -- Girdle of Lordaeron's Fallen
                {8, 33480}, -- Cord of Braided Troll Hair
                {9, 21873}, -- Primal Mooncloth Belt
                {10, 33483}, -- Life-step Belt
                {11, 30030}, -- Girdle of Fallen Stars
                {12, 34932}, -- Clutch of the Soothing Breeze
                {13, 33386}, -- Man'kin'do's Belt
                {14, 32519}, -- Belt of Divine Guidance
                {15, 29984} -- Girdle of Zaetar
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 32528},
                {2, 34363},
                {3, 34166},
                {4, 33498},
                {5, 29309},
                {6, 34625},
                {7, 32238},
                {8, 30736},
                {9, 29308},
                {10, 35733},
                {11, 34890},
                {12, 30110},
                {13, 35283},
                {14, 29306},
                {15, 28763},
                {16, 27926, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34383},
                {2, 34170},
                {3, 34384},
                {4, 34167},
                {5, 30912},
                {6, 32271},
                {7, 30893},
                {8, 30727},
                {9, 29991},
                {10, 33518},
                {11, 33585},
                {12, 34931},
                {13, 33530},
                {14, 34901},
                {15, 34925},
                {16, 24276 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34559},
                {2, 33324},
                {3, 30737},
                {4, 33207},
                {5, 33471},
                {6, 30092},
                {7, 32609},
                {8, 30680},
                {9, 34926},
                {10, 32243},
                {11, 34612},
                {12, 30100},
                {13, 30027},
                {14, 28752},
                {15, 34707},
                {16, 34008, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 29376}, -- Essence of the Martyr
                {2, 38288}, -- Direbrew Hops
                {3, 32496}, -- Memento of Tyrande
                {4, 34430}, -- Glimmering Naaru Sliver
                {5, 28190}, -- Scarab of the Infinite Cycle
                {6, 30447}, -- Tome of Fiery Redemption
                {7, 23047}, -- Eye of the Dead
                {8, 25634}, -- Oshu'gun Relic
                {9, 34050}, -- Battlemaster's Perseverance
                {10, 34580}, -- Battlemaster's Perseverance
                {11, 34429}, -- Shifting Naaru Sliver
                {12, 28823}, -- Eye of Gruul
                {13, 33828}, -- Tome of Diabolic Remedy
                {14, 30841}, -- Lower City Prayerbook
                {15, 28590} -- Ribbon of Sacrifice
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34335},
                {2, 34199},
                {3, 35082},
                {4, 32500},
                {5, 33468},
                {6, 34896},
                {7, 33743},
                {8, 30918},
                {9, 30108},
                {10, 32964},
                {11, 28771},
                {12, 32451},
                {13, 28522},
                {14, 23556},
                {15, 29353},
                {16, 34010, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34206},
                {2, 30882},
                {3, 34231},
                {4, 33332},
                {5, 32255},
                {6, 35073},
                {7, 35074},
                {8, 30911},
                {9, 32350},
                {10, 29274},
                {11, 33735},
                {12, 33736},
                {13, 29923},
                {14, 29170},
                {15, 29458},
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
            [NORMAL_DIFF] = {}
        }

        --@end-version-bcc@
    }
}





































