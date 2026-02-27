local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["PriestShadow"] = {
    name = AL["Priest Shadow BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34340},
                {2, 34847},
                {3, 32525},
                {4, 34405},
                {5, 33453},
                {6, 30161},
                {7, 32494},
                {8, 31064},
                {9, 29986},
                {10, 24266},
                {11, 29058},
                {12, 35084},
                {13, 33745},
                {14, 28415},
                {15, 32089},
                {16, 25893 },
                {17, 29191 },
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34204}, -- Amulet of Unfettered Magics
                {2, 34359}, -- Pendant of Sunfire
                {3, 37928}, -- Guardian's Pendant of Subjugation
                {4, 32349}, -- Translucent Spellthread Necklace
                {5, 33281}, -- Brooch of Nature's Mercy
                {6, 33466}, -- Loop of Cursed Bones
                {7, 34360}, -- Amulet of Flowing Life
                {8, 35319}, -- Vindicator's Pendant of Subjugation
                {9, 37929}, -- Guardian's Pendant of Reprieve
                {10, 35317}, -- Vindicator's Pendant of Reprieve
                {11, 30666}, -- Ritssyn's Lost Pendant (Shadow)
                {12, 24116}, -- Eye of the Night (GROUP BUFF)
                {13, 35290}, -- Sin'dorei Pendant of Conquest
                {14, 35133}, -- Guardian's Pendant of Dominance
                {15, 30015} -- The Sun King's Talisman
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34210},
                {2, 34393},
                {3, 30884},
                {4, 31070},
                {5, 32587},
                {6, 21869},
                {7, 32338},
                {8, 33489},
                {9, 30163},
                {10, 30079},
                {11, 34607},
                {12, 35086},
                {13, 30024},
                {14, 34202},
                {15, 34788},
                {16, 28886 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34242},
                {2, 32590},
                {3, 32524},
                {4, 33591},
                {5, 32331},
                {6, 31201},
                {7, 34792},
                {8, 29992},
                {9, 28766},
                {10, 35321},
                {11, 33592},
                {12, 25041},
                {13, 30735},
                {14, 28570},
                {15, 22731},
                {16, 25084, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34364},
                {2, 34232},
                {3, 34399},
                {4, 30107},
                {5, 31065},
                {6, 30159},
                {7, 30913},
                {8, 34917},
                {9, 29056},
                {10, 21871},
                {11, 34610},
                {12, 33317},
                {13, 30056},
                {14, 35087},
                {15, 34936},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34434},
                {2, 32586},
                {3, 30684},
                {4, 32270},
                {5, 33588},
                {6, 30870},
                {7, 35168},
                {8, 31225},
                {9, 33285},
                {10, 35179},
                {11, 24692},
                {12, 33913},
                {13, 24250},
                {14, 33883},
                {15, 29918},
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
                {4, 31061},
                {5, 30725},
                {6, 34808},
                {7, 28507},
                {8, 33586},
                {9, 28780},
                {10, 34938},
                {11, 30160},
                {12, 34342},
                {13, 24450},
                {14, 29317},
                {15, 29987},
                {16, 33997, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34528}, -- Cord of Absolution
                {2, 30038}, -- Belt of Blasting
                {3, 30064}, -- Cord of Screaming Terrors
                {4, 32256}, -- Waistwrap of Infinity
                {5, 30888}, -- Anetheron's Noose
                {6, 30675}, -- Lurker's Cord of the Wrath
                {7, 28799}, -- Belt of Divine Inspiration
                {8, 24256}, -- Girdle of Ruination
                {9, 33291}, -- Voodoo-woven Belt
                {10, 27843}, -- Glyph-Lined Sash
                {11, 24255}, -- Unyielding Girdle
                {12, 35153}, -- Guardian's Dreadweave Belt
                {13, 29241}, -- Belt of Depravity
                {14, 24395}, -- Mindfire Waistband
                {15, 35164} -- Guardian's Silk Belt
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 34362},
                {2, 33497},
                {3, 34230},
                {4, 32527},
                {5, 32247},
                {6, 34889},
                {7, 32528},
                {8, 29305},
                {9, 34363},
                {10, 33498},
                {11, 34166},
                {12, 35129},
                {13, 21709},
                {14, 34625},
                {15, 23031},
                {16, 27924, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34386},
                {2, 34181},
                {3, 30916},
                {4, 32367},
                {5, 34918},
                {6, 30734},
                {7, 24262},
                {8, 33584},
                {9, 34937},
                {10, 29972},
                {11, 30162},
                {12, 28594},
                {13, 31067},
                {14, 30531},
                {15, 30532},
                {16, 24274 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34563},
                {2, 21870},
                {3, 30680},
                {4, 33357},
                {5, 32239},
                {6, 34919},
                {7, 30050},
                {8, 30894},
                {9, 30037},
                {10, 30067},
                {11, 28517},
                {12, 28179},
                {13, 35138},
                {14, 28585},
                {15, 28406},
                {16, 34008, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 34429}, -- Shifting Naaru Sliver
                {2, 32483}, -- The Skull of Gul'dan
                {3, 33829}, -- Hex Shrunken Head
                {4, 23207}, -- Mark of the Champion (undead/demon)
                {5, 31856}, -- Darkmoon Card: Crusade
                {6, 27683}, -- Quagmirran's Eye
                {7, 28789}, -- Eye of Magtheridon
                {8, 34470}, -- Timbal's Focusing Crystal
                {9, 29370}, -- Icon of the Silver Crescent
                {10, 38290}, -- Dark Iron Smoking Pipe
                {11, 30626}, -- Sextant of Unstable Currents
                {12, 23046}, -- The Restrained Essence of Sapphiron
                {13, 19379}, -- Neltharion's Tear
                {14, 29132}, -- Scryer's Bloodgem
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
                {10, 32053},
                {11, 32963},
                {12, 33283},
                {13, 33354},
                {14, 34611},
                {15, 30723},
                {16, 27982, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34179}, -- Heart of the Pit
                {2, 32361}, -- Blind-Seers Icon
                {3, 30872}, -- Chronicle of Dark Secrets
                {4, 33334}, -- Fetish of the Primal Gods
                {5, 29272}, -- Orb of the Soul-Eater (Shadow)
                {6, 29273}, -- Khadgar's Knapsack
                {7, 25099}, -- Draenei Crystal Rod of Wrath
                {8, 35008}, -- Brutal Gladiator's Endgame
                {9, 30049}, -- Fathomstone
                {10, 28734}, -- Jewel of Infinite Possibilities
                {11, 32533}, -- Karrog's Shard
                {12, 28781}, -- Karaborian Talisman
                {13, 33681}, -- Vengeful Gladiator's Endgame
                {14, 31978}, -- Merciless Gladiator's Endgame
                {15, 32651} -- Crystal Orb of Enlightenment
            }
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34182},
                {2, 32374},
                {3, 34987},
                {4, 34540},
                {5, 35109},
                {6, 33494},
                {7, 33766},
                {8, 32055},
                {9, 29988},
                {10, 24557},
                {11, 28633},
                {12, 35514},
                {13, 29355},
                {14, 34797},
                {15, 28935},
                {16, 27982, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {
                {1, 34347}, -- Wand of the Demonsoul
                {2, 32343}, -- Wand of Prismatic Focus
                {3, 29982}, -- Wand of the Forgotten Star
                {4, 33192}, -- Carved Witch Doctor's Stick
                {5, 32872}, -- Illidari Rod of Discipline
                {6, 25295}, -- Flawless Wand of Wrath
                {7, 28673}, -- Tirisfal Wand of Ascendancy
                {8, 34348}, -- Wand of Cleansing Light
                {9, 29350}, -- The Black Stalk
                {10, 35107}, -- Brutal Gladiator's Touch of Defeat
                {11, 28386}, -- Nether Core's Control Rod
                {12, 28783}, -- Eredar Wand of Obliteration
                {13, 30859}, -- Wand of the Seer
                {14, 33764}, -- Vengeful Gladiator's Touch of Defeat
                {15, 22820} -- Wand of Fates
            }
        }

        --@end-version-bcc@
    }
}





























