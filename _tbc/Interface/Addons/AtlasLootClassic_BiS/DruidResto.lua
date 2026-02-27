local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["DruidResto"] = {
    name = AL["Druid Resto BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34245},
                {2, 34339},
                {3, 35183},
                {4, 35181},
                {5, 31037},
                {6, 32329},
                {7, 33463},
                {8, 30219},
                {9, 33356},
                {10, 32479},
                {11, 35023},
                {12, 32240},
                {13, 32495},
                {14, 24264},
                {15, 33691},
                {16, 25897 },
                {17, 29190 },
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34360}, -- Amulet of Flowing Life
                {2, 35291}, -- Sin'dorei Pendant of Salvation
                {3, 30018}, -- Lord Sanguinar's Claim
                {4, 35134}, -- Guardian's Pendant of Salvation
                {5, 33281}, -- Brooch of Nature's Mercy
                {6, 32370}, -- Nadina's Pendant of Purity
                {7, 37929}, -- Guardian's Pendant of Reprieve
                {8, 30726}, -- Archaic Charm of Presence
                {9, 34184}, -- Brooch of the Highborne
                {10, 33922}, -- Vindicator's Pendant of Salvation
                {11, 35317}, -- Vindicator's Pendant of Reprieve
                {12, 34677}, -- Shattered Sun Pendant of Restoration
                {13, 33068}, -- Veteran's Pendant of Salvation
                {14, 28609}, -- Emberspur Talisman
                {15, 32531} -- Gezzarak's Fang
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34209},
                {2, 34202},
                {3, 31047},
                {4, 30221},
                {5, 33287},
                {6, 29089},
                {7, 35025},
                {8, 30111},
                {9, 33693},
                {10, 21874},
                {11, 32518},
                {12, 31990},
                {13, 32273},
                {14, 31378},
                {15, 32585},
                {16, 28887 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 32337},
                {2, 29989},
                {3, 34205},
                {4, 34012},
                {5, 32524},
                {6, 31329},
                {7, 28765},
                {8, 24254},
                {9, 32653},
                {10, 29354},
                {11, 33333},
                {12, 28582},
                {13, 22960},
                {14, 27448},
                {15, 33592},
                {16, 25084, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34371},
                {2, 34233},
                {3, 34212},
                {4, 34365},
                {5, 31041},
                {6, 30216},
                {7, 33203},
                {8, 35026},
                {9, 21875},
                {10, 29087},
                {11, 33694},
                {12, 34900},
                {13, 34924},
                {14, 31991},
                {15, 29522},
                {16, 33990, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34445},
                {2, 30868},
                {3, 30871},
                {4, 30684},
                {5, 33557},
                {6, 33589},
                {7, 34602},
                {8, 35169},
                {9, 30062},
                {10, 32513},
                {11, 29523},
                {12, 32980},
                {13, 33887},
                {14, 32584},
                {15, 34705},
                {16, 27911, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34367},
                {2, 34351},
                {3, 34342},
                {4, 34372},
                {5, 32353},
                {6, 32328},
                {7, 33587},
                {8, 31032},
                {9, 34902},
                {10, 28521},
                {11, 35022},
                {12, 28508},
                {13, 30217},
                {14, 33690},
                {15, 30029},
                {16, 33999, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34554}, -- Thunderheart Belt
                {2, 21873}, -- Primal Mooncloth Belt
                {3, 33483}, -- Life-step Belt
                {4, 32519}, -- Belt of Divine Guidance
                {5, 30036}, -- Belt of the Long Road
                {6, 29984}, -- Girdle of Zaetar
                {7, 33480}, -- Cord of Braided Troll Hair
                {8, 30675}, -- Lurker's Cord of Healing
                {9, 29524}, -- Windhawk Belt
                {10, 34793}, -- Cord of Reconstruction
                {11, 35154}, -- Guardian's Kodohide Belt
                {12, 30895}, -- Angelista's Sash
                {13, 32339}, -- Belt of Primal Majesty
                {14, 33885}, -- Vindicator's Kodohide Belt
                {15, 30675} -- Lurker's Cord of the Prophet
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 29309},
                {2, 35733},
                {3, 30110},
                {4, 34166},
                {5, 32528},
                {6, 34890},
                {7, 29308},
                {8, 34363},
                {9, 30736},
                {10, 34625},
                {11, 28763},
                {12, 35283},
                {13, 32238},
                {14, 33498},
                {15, 29306},
                {16, 27926, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34384},
                {2, 34170},
                {3, 30912},
                {4, 32271},
                {5, 30727},
                {6, 34901},
                {7, 34925},
                {8, 33552},
                {9, 31045},
                {10, 28591},
                {11, 28742},
                {12, 30543},
                {13, 30220},
                {14, 24261},
                {15, 35024},
                {16, 24276 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 30737},
                {2, 34571},
                {3, 32609},
                {4, 30092},
                {5, 34926},
                {6, 30100},
                {7, 33471},
                {8, 30680},
                {9, 28752},
                {10, 34707},
                {11, 30885},
                {12, 30886},
                {13, 35139},
                {14, 30035},
                {15, 27411},
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
                {5, 23047}, -- Eye of the Dead
                {6, 25634}, -- Oshu'gun Relic
                {7, 34050}, -- Battlemaster's Perseverance
                {8, 34580}, -- Battlemaster's Perseverance
                {9, 30841}, -- Lower City Prayerbook
                {10, 33828}, -- Tome of Diabolic Remedy
                {11, 28590}, -- Ribbon of Sacrifice
                {12, 19395}, -- Rejuvenating Gem
                {13, 28190}, -- Scarab of the Infinite Cycle
                {14, 28823}, -- Eye of Gruul
                {15, 24390} -- Auslese's Light Channeler
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
                {5, 34896},
                {6, 33743},
                {7, 30108},
                {8, 30918},
                {9, 33468},
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
                {1, 30911}, -- Scepter of Purification
                {2, 35074}, -- Brutal Gladiator's Reprieve
                {3, 34206}, -- Book of Highborne Hymns
                {4, 29274}, -- Tears of Heaven
                {5, 32350}, -- Touch of Inspiration
                {6, 29170}, -- Windcaller's Orb
                {7, 33736}, -- Vengeful Gladiator's Reprieve
                {8, 29923}, -- Talisman of the Sun King
                {9, 33325}, -- Voodoo Shaker
                {10, 32961}, -- Merciless Gladiator's Reprieve
                {11, 23048}, -- Sapphiron's Right Eye
                {12, 27477}, -- Faol's Signet of Cleansing
                {13, 28728}, -- Aran's Soothing Sapphire
                {14, 23029}, -- Noth's Frigid Heart
                {15, 28213} -- Lordaeron Medical Guide
            }
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34337},
                {2, 30908},
                {3, 33490},
                {4, 32344},
                {5, 30732},
                {6, 29981},
                {7, 34608},
                {8, 28782},
                {9, 28604},
                {10, 22632},
                {11, 27791},
                {12, 29133},
                {13, 28033},
                {14, 31289},
                {15, 31417},
                {16, 34010, "Profession" },
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





































