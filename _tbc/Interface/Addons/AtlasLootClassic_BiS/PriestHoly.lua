local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["PriestHoly"] = {
    name = AL["Priest Holy BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34339},
                {2, 35181},
                {3, 31063},
                {4, 32329},
                {5, 30152},
                {6, 32495},
                {7, 29049},
                {8, 29990},
                {9, 34405},
                {10, 33463},
                {11, 31064},
                {12, 32090},
                {13, 35054},
                {14, 34340},
                {15, 28413},
                {16, 25901 },
                {17, 29190 },
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 33281}, -- Brooch of Nature's Mercy
                {2, 34360}, -- Amulet of Flowing Life
                {3, 34184}, -- Brooch of the Highborne
                {4, 32370}, -- Nadina's Pendant of Purity
                {5, 37929}, -- Guardian's Pendant of Reprieve
                {6, 28822}, -- Teeth of Gruul
                {7, 35291}, -- Sin'dorei Pendant of Salvation
                {8, 30018}, -- Lord Sanguinar's Claim
                {9, 35134}, -- Guardian's Pendant of Salvation
                {10, 35317}, -- Vindicator's Pendant of Reprieve
                {11, 28731}, -- Shining Chain of the Afterworld
                {12, 33922}, -- Vindicator's Pendant of Salvation
                {13, 30726}, -- Archaic Charm of Presence
                {14, 34359}, -- Pendant of Sunfire
                {15, 27766} -- Swampstone Necklace
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34202},
                {2, 31069},
                {3, 32273},
                {4, 32585},
                {5, 30154},
                {6, 29054},
                {7, 28612},
                {8, 21874},
                {9, 34393},
                {10, 35056},
                {11, 27775},
                {12, 34210},
                {13, 30163},
                {14, 33720},
                {15, 27433},
                {16, 28887 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 29989},
                {2, 32337},
                {3, 34205},
                {4, 32524},
                {5, 34012},
                {6, 33592},
                {7, 28765},
                {8, 27946},
                {9, 28582},
                {10, 28373},
                {11, 22960},
                {12, 35324},
                {13, 34242},
                {14, 31329},
                {15, 33333},
                {16, 27962, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34233},
                {2, 34365},
                {3, 31066},
                {4, 34924},
                {5, 33203},
                {6, 30150},
                {7, 21875},
                {8, 32340},
                {9, 34399},
                {10, 29050},
                {11, 35057},
                {12, 28230},
                {13, 34364},
                {14, 33721},
                {15, 34232},
                {16, 33990, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34435},
                {2, 30871},
                {3, 32513},
                {4, 33589},
                {5, 32584},
                {6, 35174},
                {7, 30684},
                {8, 34434},
                {9, 32516},
                {10, 28511},
                {11, 29249},
                {12, 33901},
                {13, 30870},
                {14, 22519},
                {15, 27452},
                {16, 27911, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34342},
                {2, 34367},
                {3, 31060},
                {4, 30151},
                {5, 32353},
                {6, 33587},
                {7, 34406},
                {8, 28508},
                {9, 29055},
                {10, 27536},
                {11, 35053},
                {12, 34344},
                {13, 22517},
                {14, 34366},
                {15, 24393},
                {16, 33999, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34527}, -- Belt of Absolution
                {2, 32519}, -- Belt of Divine Guidance
                {3, 30036}, -- Belt of the Long Road
                {4, 30895}, -- Angelista's Sash
                {5, 33480}, -- Cord of Braided Troll Hair
                {6, 21873}, -- Primal Mooncloth Belt
                {7, 30675}, -- Lurker's Cord of the Prophet
                {8, 35159}, -- Guardian's Mooncloth Belt
                {9, 28652}, -- Cincture of Will
                {10, 34793}, -- Cord of Reconstruction
                {11, 34528}, -- Cord of Absolution
                {12, 27542}, -- Cord of Belief
                {13, 33900}, -- Vindicator's Mooncloth Belt
                {14, 24257}, -- Black Belt of Knowledge
                {15, 32979} -- Veteran's Mooncloth Belt
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 35733},
                {2, 34363},
                {3, 29309},
                {4, 34166},
                {5, 32528},
                {6, 30110},
                {7, 33498},
                {8, 29308},
                {9, 32238},
                {10, 34890},
                {11, 29290},
                {12, 29306},
                {13, 29291},
                {14, 28790},
                {15, 35130},
                {16, 27926, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34170},
                {2, 34925},
                {3, 30912},
                {4, 31068},
                {5, 30153},
                {6, 29977},
                {7, 30727},
                {8, 28742},
                {9, 29053},
                {10, 33585},
                {11, 30543},
                {12, 35055},
                {13, 34386},
                {14, 31343},
                {15, 28218},
                {16, 24276 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34562},
                {2, 34926},
                {3, 30885},
                {4, 32609},
                {5, 30100},
                {6, 30035},
                {7, 33471},
                {8, 28663},
                {9, 30680},
                {10, 34563},
                {11, 35144},
                {12, 29251},
                {13, 25792},
                {14, 33902},
                {15, 27411},
                {16, 34008, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 28823}, -- Eye of Gruul
                {2, 32496}, -- Memento of Tyrande
                {3, 30665}, -- Earring of Soulful Meditation
                {4, 34430}, -- Glimmering Naaru Sliver
                {5, 28370}, -- Bangle of Endless Blessings
                {6, 29376}, -- Essence of the Martyr
                {7, 38288}, -- Direbrew Hops
                {8, 19288}, -- Darkmoon Card: Blue Dragon
                {9, 28727}, -- Pendant of the Violet Eye
                {10, 33828}, -- Tome of Diabolic Remedy
                {11, 28190}, -- Scarab of the Infinite Cycle
                {12, 30841}, -- Lower City Prayerbook
                {13, 23047}, -- Eye of the Dead
                {14, 19395}, -- Rejuvenating Gem
                {15, 25634} -- Oshu'gun Relic
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
                {6, 30108},
                {7, 33743},
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
                {1, 34206}, -- Book of Highborne Hymns
                {2, 30911}, -- Scepter of Purification
                {3, 33325}, -- Voodoo Shaker
                {4, 32350}, -- Touch of Inspiration
                {5, 35074}, -- Brutal Gladiator's Reprieve
                {6, 29923}, -- Talisman of the Sun King
                {7, 28525}, -- Signet of Unshakable Faith
                {8, 29170}, -- Windcaller's Orb
                {9, 28728}, -- Aran's Soothing Sapphire
                {10, 33736}, -- Vengeful Gladiator's Reprieve
                {11, 31493}, -- Netherwing Spiritualist's Charm
                {12, 32961}, -- Merciless Gladiator's Reprieve
                {13, 23029}, -- Noth's Frigid Heart
                {14, 28213}, -- Lordaeron Medical Guide
                {15, 29274} -- Tears of Heaven
            }
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34337},
                {2, 30908},
                {3, 32344},
                {4, 29981},
                {5, 33490},
                {6, 34608},
                {7, 30732},
                {8, 28782},
                {9, 28604},
                {10, 22631},
                {11, 27791},
                {12, 29133},
                {13, 30012},
                {14, 31289},
                {15, 28033},
                {16, 34010, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {
                {1, 34348}, -- Wand of Cleansing Light
                {2, 32363}, -- Naaru-Blessed Life Rod
                {3, 30080}, -- Luminescent Rod of the Naaru
                {4, 28588}, -- Blue Diamond Witchwand
                {5, 34985}, -- Brutal Gladiator's Baton of Light
                {6, 34059}, -- Vengeful Gladiator's Baton of Light
                {7, 27885}, -- Soul-Wand of the Aldor
                {8, 23009}, -- Wand of the Whispering Dead
                {9, 34347}, -- Wand of the Demonsoul
                {10, 24380}, -- Calming Spore Reed
                {11, 33192}, -- Carved Witch Doctor's Stick
                {12, 29779}, -- Rejuvenating Scepter
                {13, 30724}, -- Barrel-Blade Longrifle
                {14, 28783}, -- Eredar Wand of Obliteration
                {15, 27540} -- Nexus Torch
            }
        }

        --@end-version-bcc@
    }
}






























