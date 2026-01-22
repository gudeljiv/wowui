local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["PalProt"] = {
    name = AL["Paladin Prot BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34401},
                {2, 34400},
                {3, 32521},
                {4, 34357},
                {5, 30987},
                {6, 35029},
                {7, 30125},
                {8, 33421},
                {9, 33697},
                {10, 31997},
                {11, 32473},
                {12, 34345},
                {13, 35061},
                {14, 29068},
                {15, 35090},
                {16, 25896 },
                {17, 29186 },
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 35133}, -- Guardian's Pendant of Dominance
                {2, 34178}, -- Collar of the Pit Lord
                {3, 30007}, -- The Darkener's Grasp
                {4, 33921}, -- Vindicator's Pendant of Dominance
                {5, 32362}, -- Pendant of Titans
                {6, 35132}, -- Guardian's Pendant of Conquest
                {7, 37928}, -- Guardian's Pendant of Subjugation
                {8, 34359}, -- Pendant of Sunfire
                {9, 33065}, -- Veteran's Pendant of Dominance
                {10, 28245}, -- Pendant of Dominance
                {11, 34358}, -- Hard Khorium Choker
                {12, 33920}, -- Vindicator's Pendant of Conquest
                {13, 35319}, -- Vindicator's Pendant of Subjugation
                {14, 28516}, -- Barbed Choker of Discipline
                {15, 35135} -- Guardian's Pendant of Triumph
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34389},
                {2, 34192},
                {3, 30998},
                {4, 35031},
                {5, 32250},
                {6, 30127},
                {7, 29070},
                {8, 33481},
                {9, 33699},
                {10, 34388},
                {11, 35092},
                {12, 31996},
                {13, 35063},
                {14, 33753},
                {15, 30997},
                {16, 28911 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34190},
                {2, 34242},
                {3, 33593},
                {4, 34010},
                {5, 29925},
                {6, 29992},
                {7, 34241},
                {8, 32331},
                {9, 33304},
                {10, 35321},
                {11, 28660},
                {12, 28378},
                {13, 28379},
                {14, 29385},
                {15, 27804},
                {16, 25086, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34216},
                {2, 30991},
                {3, 34394},
                {4, 35027},
                {5, 33522},
                {6, 34939},
                {7, 34945},
                {8, 30123},
                {9, 33473},
                {10, 34215},
                {11, 33695},
                {12, 30896},
                {13, 35088},
                {14, 29066},
                {15, 35059},
                {16, 27957, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34433},
                {2, 32279},
                {3, 32232},
                {4, 35170},
                {5, 32515},
                {6, 33889},
                {7, 35176},
                {8, 33516},
                {9, 28502},
                {10, 35178},
                {11, 33813},
                {12, 32813},
                {13, 35175},
                {14, 29252},
                {15, 33910},
                {16, 27917, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34352},
                {2, 30985},
                {3, 29998},
                {4, 32280},
                {5, 30124},
                {6, 35028},
                {7, 34341},
                {8, 33517},
                {9, 34378},
                {10, 28518},
                {11, 30741},
                {12, 33696},
                {13, 35060},
                {14, 29067},
                {15, 34380},
                {16, 25072, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34488}, -- Lightbringer Waistguard
                {2, 32342}, -- Girdle of Mighty Resolve
                {3, 32333}, -- Girdle of Stability
                {4, 30034}, -- Belt of the Guardian
                {5, 33524}, -- Girdle of the Protector
                {6, 33279}, -- Iron-tusk Girdle
                {7, 30096}, -- Girdle of the Invulnerable
                {8, 34941}, -- Girdle of the Fearless
                {9, 35155}, -- Guardian's Lamellar Belt
                {10, 33888}, -- Vindicator's Lamellar Belt
                {11, 28566}, -- Crimson Girdle of the Indomitable
                {12, 34944}, -- Girdle of Seething Rage
                {13, 35161}, -- Guardian's Plate Belt
                {14, 29253}, -- Girdle of Valorous Deeds
                {15, 30897} -- Girdle of Hope
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 34213},
                {2, 34888},
                {3, 33499},
                {4, 29297},
                {5, 29296},
                {6, 30083},
                {7, 30028},
                {8, 29305},
                {9, 33054},
                {10, 32261},
                {11, 29279},
                {12, 29295},
                {13, 29278},
                {14, 28792},
                {15, 32527},
                {16, 27924, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34382},
                {2, 34381},
                {3, 34946},
                {4, 30995},
                {5, 32263},
                {6, 33515},
                {7, 34940},
                {8, 30126},
                {9, 35030},
                {10, 34180},
                {11, 33698},
                {12, 28621},
                {13, 34167},
                {14, 35091},
                {15, 29069},
                {16, 24274 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34560},
                {2, 32245},
                {3, 34947},
                {4, 32268},
                {5, 33523},
                {6, 32267},
                {7, 35140},
                {8, 33191},
                {9, 30033},
                {10, 30031},
                {11, 33890},
                {12, 35146},
                {13, 32345},
                {14, 32789},
                {15, 35148},
                {16, 27950, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 30447}, -- Tome of Fiery Redemption
                {2, 31856}, -- Darkmoon Card: Crusade
                {3, 33829}, -- Hex Shrunken Head
                {4, 23207}, -- Mark of the Champion (undead/demon)
                {5, 34473}, -- Commendation of Kael'thas
                {6, 28789}, -- Eye of Magtheridon
                {7, 34470}, -- Timbal's Focusing Crystal
                {8, 29370}, -- Icon of the Silver Crescent
                {9, 38290}, -- Dark Iron Smoking Pipe
                {10, 35700}, -- Figurine - Crimson Serpent
                {11, 31858}, -- Darkmoon Card: Vengeance
                {12, 31859}, -- Darkmoon Card: Madness
                {13, 23046}, -- The Restrained Essence of Sapphiron
                {14, 33830}, -- Ancient Aqir Artifact
                {15, 30626} -- Sextant of Unstable Currents
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 35014},
                {2, 34176},
                {3, 30910},
                {4, 33687},
                {5, 34009},
                {6, 33467},
                {7, 32963},
                {8, 33283},
                {9, 30095},
                {10, 28802},
                {11, 34164},
                {12, 34611},
                {13, 32450},
                {14, 30874},
                {15, 34996},
                {16, 27975, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34185},
                {2, 34986},
                {3, 35094},
                {4, 32375},
                {5, 30909},
                {6, 35073},
                {7, 34011},
                {8, 33661},
                {9, 34231},
                {10, 30889},
                {11, 33755},
                {12, 33735},
                {13, 33326},
                {14, 30882},
                {15, 33313},
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



































