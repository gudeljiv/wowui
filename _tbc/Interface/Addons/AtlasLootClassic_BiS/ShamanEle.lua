local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["ShamanEle"] = {
    name = AL["Shaman Ele BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34332},
                {2, 34340},
                {3, 34355},
                {4, 34403},
                {5, 34405},
                {6, 35182},
                {7, 32525},
                {8, 31014},
                {9, 35050},
                {10, 30171},
                {11, 32476},
                {12, 32480},
                {13, 33713},
                {14, 33453},
                {15, 29986},
                {16, 34220 },
                {17, 29191 },
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34359}, -- Pendant of Sunfire
                {2, 34204}, -- Amulet of Unfettered Magics
                {3, 37928}, -- Guardian's Pendant of Subjugation
                {4, 33281}, -- Brooch of Nature's Mercy
                {5, 34360}, -- Amulet of Flowing Life
                {6, 33466}, -- Loop of Cursed Bones
                {7, 32349}, -- Translucent Spellthread Necklace
                {8, 37929}, -- Guardian's Pendant of Reprieve
                {9, 30015}, -- The Sun King's Talisman
                {10, 35319}, -- Vindicator's Pendant of Subjugation
                {11, 35132}, -- Guardian's Pendant of Conquest
                {12, 24121}, -- Chain of the Twilight Owl (GROUP BUFF)
                {13, 24116}, -- Eye of the Night (GROUP BUFF)
                {14, 35290}, -- Sin'dorei Pendant of Conquest
                {15, 35317} -- Vindicator's Pendant of Reprieve
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34210},
                {2, 34390},
                {3, 34391},
                {4, 34393},
                {5, 32587},
                {6, 31023},
                {7, 30884},
                {8, 33489},
                {9, 33970},
                {10, 32338},
                {11, 35052},
                {12, 30173},
                {13, 30079},
                {14, 33973},
                {15, 33715},
                {16, 28886 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34242},
                {2, 32524},
                {3, 32331},
                {4, 33591},
                {5, 30735},
                {6, 33592},
                {7, 28797},
                {8, 35321},
                {9, 29992},
                {10, 31201},
                {11, 33304},
                {12, 23050},
                {13, 29369},
                {14, 35497},
                {15, 28766},
                {16, 34003, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34364},
                {2, 34396},
                {3, 34232},
                {4, 34399},
                {5, 34398},
                {6, 34933},
                {7, 31017},
                {8, 33965},
                {9, 30107},
                {10, 34936},
                {11, 30913},
                {12, 32592},
                {13, 35048},
                {14, 34610},
                {15, 30056},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34437},
                {2, 32586},
                {3, 33588},
                {4, 35173},
                {5, 30870},
                {6, 30684},
                {7, 32259},
                {8, 33897},
                {9, 29918},
                {10, 33578},
                {11, 33285},
                {12, 32270},
                {13, 29523},
                {14, 32655},
                {15, 32817},
                {16, 27917, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34344},
                {2, 34406},
                {3, 34350},
                {4, 34366},
                {5, 34407},
                {6, 31008},
                {7, 34938},
                {8, 33586},
                {9, 30725},
                {10, 33534},
                {11, 33974},
                {12, 35049},
                {13, 28780},
                {14, 34376},
                {15, 29987},
                {16, 33997, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34542}, -- Skyshatter Cord
                {2, 32276}, -- Flashfire Girdle
                {3, 34935}, -- Aftershock Waistguard
                {4, 32256}, -- Waistwrap of Infinity
                {5, 30038}, -- Belt of Blasting
                {6, 30888}, -- Anetheron's Noose
                {7, 30914}, -- Belt of the Crescent Moon
                {8, 33559}, -- Starfire Waistband
                {9, 30064}, -- Cord of Screaming Terrors
                {10, 24256}, -- Girdle of Ruination
                {11, 30675}, -- Lurker's Cord of the Wrath
                {12, 33291}, -- Voodoo-woven Belt
                {13, 33536}, -- Stormwrap
                {14, 35158}, -- Guardian's Mail Girdle
                {15, 30044} -- Monsoon Belt
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 34230},
                {2, 34362},
                {3, 32527},
                {4, 33497},
                {5, 29305},
                {6, 32247},
                {7, 32528},
                {8, 34363},
                {9, 33498},
                {10, 30667},
                {11, 35282},
                {12, 29304},
                {13, 34166},
                {14, 29303},
                {15, 30109},
                {16, 27924, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34181},
                {2, 34186},
                {3, 34386},
                {4, 34169},
                {5, 34934},
                {6, 30916},
                {7, 34937},
                {8, 33584},
                {9, 31020},
                {10, 30734},
                {11, 34905},
                {12, 33971},
                {13, 33533},
                {14, 32367},
                {15, 24262},
                {16, 24274 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34566},
                {2, 32239},
                {3, 33357},
                {4, 32242},
                {5, 32352},
                {6, 33537},
                {7, 30680},
                {8, 35143},
                {9, 30067},
                {10, 33577},
                {11, 30037},
                {12, 30894},
                {13, 34919},
                {14, 28517},
                {15, 30043},
                {16, 34008, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 34429}, -- Shifting Naaru Sliver
                {2, 32483}, -- The Skull of Gul'dan
                {3, 30626}, -- Sextant of Unstable Currents
                {4, 33829}, -- Hex Shrunken Head
                {5, 23207}, -- Mark of the Champion (undead/demon)
                {6, 27683}, -- Quagmirran's Eye
                {7, 31856}, -- Darkmoon Card: Crusade
                {8, 28789}, -- Eye of Magtheridon
                {9, 34470}, -- Timbal's Focusing Crystal
                {10, 29370}, -- Icon of the Silver Crescent
                {11, 38290}, -- Dark Iron Smoking Pipe
                {12, 28418}, -- Shiffar's Nexus-Horn
                {13, 23046}, -- The Restrained Essence of Sapphiron
                {14, 29179}, -- Xi'ri's Gift
                {15, 19379} -- Neltharion's Tear
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
                {5, 32237},
                {6, 33687},
                {7, 33763},
                {8, 34895},
                {9, 34009},
                {10, 33354},
                {11, 32053},
                {12, 32963},
                {13, 30723},
                {14, 33283},
                {15, 28770},
                {16, 27975, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34179},
                {2, 30872},
                {3, 30909},
                {4, 33334},
                {5, 30049},
                {6, 32361},
                {7, 29273},
                {8, 34986},
                {9, 35008},
                {10, 28603},
                {11, 25099},
                {12, 32533},
                {13, 29268},
                {14, 34011},
                {15, 28781},
                {16, 27945, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {
                {1, 32374},
                {2, 34182},
                {3, 34987},
                {4, 35109},
                {5, 34540},
                {6, 33766},
                {7, 29988},
                {8, 33494},
                {9, 32055},
                {10, 24557},
                {11, 35514},
                {12, 29355},
                {13, 28633},
                {14, 32854},
                {15, 34797},
                {16, 27975, "Profession" },
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













































