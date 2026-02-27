local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["ShamanResto"] = {
    name = AL["Shaman Resto BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34402},
                {2, 34339},
                {3, 34245},
                {4, 35184},
                {5, 35183},
                {6, 31012},
                {7, 32241},
                {8, 35181},
                {9, 32240},
                {10, 35079},
                {11, 32475},
                {12, 30166},
                {13, 33286},
                {14, 32329},
                {15, 33463},
                {16, 25897 },
                {17, 29190 },
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34360}, -- Amulet of Flowing Life
                {2, 33281}, -- Brooch of Nature's Mercy
                {3, 34184}, -- Brooch of the Highborne
                {4, 37929}, -- Guardian's Pendant of Reprieve
                {5, 35317}, -- Vindicator's Pendant of Reprieve
                {6, 32370}, -- Nadina's Pendant of Purity
                {7, 35291}, -- Sin'dorei Pendant of Salvation
                {8, 30018}, -- Lord Sanguinar's Claim
                {9, 35134}, -- Guardian's Pendant of Salvation
                {10, 34359}, -- Pendant of Sunfire
                {11, 30726}, -- Archaic Charm of Presence
                {12, 28609}, -- Emberspur Talisman
                {13, 33922}, -- Vindicator's Pendant of Salvation
                {14, 34677}, -- Shattered Sun Pendant of Restoration
                {15, 33068} -- Veteran's Pendant of Salvation
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34202},
                {2, 34208},
                {3, 34209},
                {4, 32579},
                {5, 32583},
                {6, 33464},
                {7, 31022},
                {8, 32585},
                {9, 35081},
                {10, 30168},
                {11, 30097},
                {12, 33742},
                {13, 34210},
                {14, 33287},
                {15, 32517},
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
                {4, 34242},
                {5, 34012},
                {6, 34702},
                {7, 35324},
                {8, 29989},
                {9, 32337},
                {10, 31329},
                {11, 28765},
                {12, 24254},
                {13, 28582},
                {14, 33333},
                {15, 27448},
                {16, 25084, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34375},
                {2, 34365},
                {3, 34212},
                {4, 34229},
                {5, 34233},
                {6, 34371},
                {7, 33469},
                {8, 35077},
                {9, 31016},
                {10, 34364},
                {11, 34930},
                {12, 30164},
                {13, 33738},
                {14, 21875},
                {15, 32340},
                {16, 33991, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34438},
                {2, 32584},
                {3, 32577},
                {4, 32582},
                {5, 30869},
                {6, 35177},
                {7, 30684},
                {8, 33589},
                {9, 30868},
                {10, 30871},
                {11, 30047},
                {12, 33906},
                {13, 34602},
                {14, 33557},
                {15, 33532},
                {16, 27911, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34376},
                {2, 34372},
                {3, 34409},
                {4, 32328},
                {5, 34342},
                {6, 32275},
                {7, 34351},
                {8, 34791},
                {9, 34367},
                {10, 32353},
                {11, 29976},
                {12, 31007},
                {13, 34344},
                {14, 34406},
                {15, 35078},
                {16, 33999, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34543}, -- Skyshatter Belt
                {2, 30895}, -- Angelista's Sash
                {3, 32258}, -- Naturalist's Preserving Cinch
                {4, 32339}, -- Belt of Primal Majesty
                {5, 33386}, -- Man'kin'do's Belt
                {6, 34932}, -- Clutch of the Soothing Breeze
                {7, 33480}, -- Cord of Braided Troll Hair
                {8, 33483}, -- Life-step Belt
                {9, 21873}, -- Primal Mooncloth Belt
                {10, 30030}, -- Girdle of Fallen Stars
                {11, 30675}, -- Lurker's Cord of Healing
                {12, 35162}, -- Guardian's Ringmail Girdle
                {13, 32519}, -- Belt of Divine Guidance
                {14, 29984}, -- Girdle of Zaetar
                {15, 29524} -- Windhawk Belt
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 32528},
                {2, 34363},
                {3, 33498},
                {4, 34166},
                {5, 29309},
                {6, 34625},
                {7, 32238},
                {8, 34890},
                {9, 29308},
                {10, 30736},
                {11, 28763},
                {12, 35283},
                {13, 35733},
                {14, 29306},
                {15, 34230},
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34383},
                {2, 34170},
                {3, 34384},
                {4, 33585},
                {5, 30912},
                {6, 32271},
                {7, 34931},
                {8, 30893},
                {9, 30727},
                {10, 29991},
                {11, 31019},
                {12, 33530},
                {13, 34901},
                {14, 34925},
                {15, 35080},
                {16, 24276 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34565},
                {2, 33471},
                {3, 33324},
                {4, 30737},
                {5, 30680},
                {6, 34926},
                {7, 30873},
                {8, 30092},
                {9, 35147},
                {10, 34566},
                {11, 32609},
                {12, 30100},
                {13, 34707},
                {14, 33908},
                {15, 30035},
                {16, 34008, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 32496}, -- Memento of Tyrande
                {2, 34430}, -- Glimmering Naaru Sliver
                {3, 29376}, -- Essence of the Martyr
                {4, 38288}, -- Direbrew Hops
                {5, 28190}, -- Scarab of the Infinite Cycle
                {6, 28823}, -- Eye of Gruul
                {7, 34429}, -- Shifting Naaru Sliver
                {8, 33828}, -- Tome of Diabolic Remedy
                {9, 23047}, -- Eye of the Dead
                {10, 25634}, -- Oshu'gun Relic
                {11, 34050}, -- Battlemaster's Perseverance
                {12, 34580}, -- Battlemaster's Perseverance
                {13, 30841}, -- Lower City Prayerbook
                {14, 19395}, -- Rejuvenating Gem
                {15, 27683} -- Quagmirran's Eye
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34335}, -- Hammer of Sanctification
                {2, 34199}, -- Archon's Gavel
                {3, 35082}, -- Brutal Gladiator's Salvation
                {4, 32500}, -- Crystal Spire of Karabor
                {5, 33468}, -- Dark Blessing
                {6, 34896}, -- Gavel of Naaru Blessings
                {7, 33743}, -- Vengeful Gladiator's Salvation
                {8, 30108}, -- Lightfathom Scepter
                {9, 30918}, -- Hammer of Atonement
                {10, 32964}, -- Merciless Gladiator's Salvation
                {11, 28771}, -- Light's Justice
                {12, 32451}, -- Gladiator's Salvation
                {13, 28522}, -- Shard of the Virtuous
                {14, 23556}, -- Hand of Eternity
                {15, 29353} -- Shockwave Truncheon
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34206},
                {2, 34231},
                {3, 30882},
                {4, 32350},
                {5, 32255},
                {6, 33332},
                {7, 35073},
                {8, 35074},
                {9, 30911},
                {10, 29274},
                {11, 29458},
                {12, 29923},
                {13, 33735},
                {14, 33736},
                {15, 28728},
            }
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34337}, -- Golden Staff of the Sin'dorei
                {2, 30908}, -- Apostle of Argus
                {3, 33490}, -- Staff of Dark Mending
                {4, 32344}, -- Staff of Immaculate Recovery
                {5, 30732}, -- Exodar Life-Staff
                {6, 29981}, -- Ethereum Life-Staff
                {7, 28782}, -- Crystalheart Pulse-Staff
                {8, 34608}, -- Rod of the Blazing Light
                {9, 28604}, -- Nightstaff of the Everliving
                {10, 29133}, -- Seer's Cane
                {11, 28033}, -- Epoch-Mender
                {12, 27791}, -- Serpentcrest Life-Staff
                {13, 31038}, -- Staff of the Redeemer
                {14, 30012}, -- Ameer's Judgement
                {15, 31417} -- Staff of the Ashtongue Deathsworn
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



























