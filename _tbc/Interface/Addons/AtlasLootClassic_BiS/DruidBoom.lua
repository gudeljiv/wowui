local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["DruidBoom"] = {
    name = AL["Druid Boomkin BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34340},
                {2, 32525},
                {3, 34405},
                {4, 34403},
                {5, 31040},
                {6, 35182},
                {7, 33453},
                {8, 30233},
                {9, 29986},
                {10, 35112},
                {11, 32480},
                {12, 33768},
                {13, 24266},
                {14, 29093},
                {15, 33972},
                {16, 34220 },
                {17, 29192 },
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34204}, -- Amulet of Unfettered Magics
                {2, 34359}, -- Pendant of Sunfire
                {3, 32349}, -- Translucent Spellthread Necklace
                {4, 24116}, -- Eye of the Night (GROUP BUFF)
                {5, 34360}, -- Amulet of Flowing Life
                {6, 33281}, -- Brooch of Nature's Mercy
                {7, 37928}, -- Guardian's Pendant of Subjugation
                {8, 35290}, -- Sin'dorei Pendant of Conquest
                {9, 30015}, -- The Sun King's Talisman
                {10, 35132}, -- Guardian's Pendant of Conquest
                {11, 33466}, -- Loop of Cursed Bones
                {12, 35319}, -- Vindicator's Pendant of Subjugation
                {13, 37929}, -- Guardian's Pendant of Reprieve
                {14, 35133}, -- Guardian's Pendant of Dominance
                {15, 33920} -- Vindicator's Pendant of Conquest
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34210},
                {2, 34391},
                {3, 31049},
                {4, 34393},
                {5, 33973},
                {6, 30884},
                {7, 32338},
                {8, 30235},
                {9, 30024},
                {10, 35114},
                {11, 32587},
                {12, 30079},
                {13, 34607},
                {14, 29095},
                {15, 33489},
                {16, 28909 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34242},
                {2, 32331},
                {3, 28766},
                {4, 32524},
                {5, 34792},
                {6, 33591},
                {7, 30735},
                {8, 29992},
                {9, 28797},
                {10, 23050},
                {11, 31201},
                {12, 35321},
                {13, 33592},
                {14, 22731},
                {15, 27981},
                {16, 25084, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34364},
                {2, 34399},
                {3, 34232},
                {4, 34398},
                {5, 31043},
                {6, 30107},
                {7, 30231},
                {8, 30913},
                {9, 34917},
                {10, 35115},
                {11, 29091},
                {12, 33566},
                {13, 21848},
                {14, 34936},
                {15, 34610},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34446},
                {2, 32270},
                {3, 32351},
                {4, 30870},
                {5, 32586},
                {6, 33285},
                {7, 30684},
                {8, 33578},
                {9, 29523},
                {10, 33588},
                {11, 29918},
                {12, 35180},
                {13, 32820},
                {14, 32655},
                {15, 31225},
                {16, 27917, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34344},
                {2, 34406},
                {3, 34366},
                {4, 34407},
                {5, 31035},
                {6, 34904},
                {7, 30725},
                {8, 21847},
                {9, 33586},
                {10, 34808},
                {11, 34938},
                {12, 28507},
                {13, 28780},
                {14, 29987},
                {15, 34372},
                {16, 33997, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34555}, -- Thunderheart Cord
                {2, 30038}, -- Belt of Blasting
                {3, 30064}, -- Cord of Screaming Terrors
                {4, 30888}, -- Anetheron's Noose
                {5, 21846}, -- Spellfire Belt (Fire/Arcane)
                {6, 32256}, -- Waistwrap of Infinity
                {7, 30914}, -- Belt of the Crescent Moon
                {8, 33559}, -- Starfire Waistband
                {9, 33291}, -- Voodoo-woven Belt
                {10, 29524}, -- Windhawk Belt
                {11, 24256}, -- Girdle of Ruination
                {12, 30675}, -- Lurker's Cord of the Wrath
                {13, 28799}, -- Belt of Divine Inspiration
                {14, 27843}, -- Glyph-Lined Sash
                {15, 29241} -- Belt of Depravity
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 34362},
                {2, 33497},
                {3, 34230},
                {4, 32247},
                {5, 34889},
                {6, 29305},
                {7, 32527},
                {8, 34363},
                {9, 30667},
                {10, 32528},
                {11, 29304},
                {12, 34166},
                {13, 35282},
                {14, 33498},
                {15, 28793},
                {16, 27924, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34181},
                {2, 34386},
                {3, 30916},
                {4, 34169},
                {5, 32367},
                {6, 34918},
                {7, 31046},
                {8, 30734},
                {9, 34905},
                {10, 24262},
                {11, 34937},
                {12, 33971},
                {13, 29972},
                {14, 30234},
                {15, 35113},
                {16, 24274 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34572},
                {2, 32239},
                {3, 34919},
                {4, 32352},
                {5, 33577},
                {6, 30894},
                {7, 30037},
                {8, 30680},
                {9, 33357},
                {10, 30067},
                {11, 28517},
                {12, 28585},
                {13, 35150},
                {14, 30680},
                {15, 28406},
                {16, 34008, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 32483}, -- The Skull of Gul'dan
                {2, 34429}, -- Shifting Naaru Sliver
                {3, 33829}, -- Hex Shrunken Head
                {4, 23207}, -- Mark of the Champion (undead/demon)
                {5, 30626}, -- Sextant of Unstable Currents
                {6, 31856}, -- Darkmoon Card: Crusade
                {7, 28789}, -- Eye of Magtheridon
                {8, 34470}, -- Timbal's Focusing Crystal
                {9, 27683}, -- Quagmirran's Eye
                {10, 29370}, -- Icon of the Silver Crescent
                {11, 38290}, -- Dark Iron Smoking Pipe
                {12, 29132}, -- Scryer's Bloodgem
                {13, 19379}, -- Neltharion's Tear
                {14, 23046}, -- The Restrained Essence of Sapphiron
                {15, 28223} -- Arcanist's Stone
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34336},
                {2, 34176},
                {3, 35014},
                {4, 35102},
                {5, 33687},
                {6, 33763},
                {7, 34009},
                {8, 34895},
                {9, 32237},
                {10, 33354},
                {11, 32053},
                {12, 32963},
                {13, 33283},
                {14, 34611},
                {15, 30723},
                {16, 27981, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 30872}, -- Chronicle of Dark Secrets
                {2, 32361}, -- Blind-Seers Icon
                {3, 34179}, -- Heart of the Pit
                {4, 33334}, -- Fetish of the Primal Gods
                {5, 28734}, -- Jewel of Infinite Possibilities
                {6, 30049}, -- Fathomstone
                {7, 35008}, -- Brutal Gladiator's Endgame
                {8, 29273}, -- Khadgar's Knapsack
                {9, 28412}, -- Lamp of Peaceful Radiance
                {10, 28603}, -- Talisman of Nightbane
                {11, 25099}, -- Draenei Crystal Rod of Wrath
                {12, 28781}, -- Karaborian Talisman
                {13, 28187}, -- Star-Heart Lamp
                {14, 33681} -- Vengeful Gladiator's Endgame
            }
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34182},
                {2, 34987},
                {3, 32374},
                {4, 34540},
                {5, 35109},
                {6, 32055},
                {7, 33766},
                {8, 33494},
                {9, 29988},
                {10, 24557},
                {11, 28633},
                {12, 35514},
                {13, 29355},
                {14, 34797},
                {15, 32854},
                {16, 27981, "Profession" },
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





































