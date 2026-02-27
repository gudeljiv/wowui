local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["Warlockdest"] = {
    name = AL["Warlock Destro BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34340},
                {2, 32525},
                {3, 34847},
                {4, 31051},
                {5, 34405},
                {6, 33453},
                {7, 32494},
                {8, 30212},
                {9, 29986},
                {10, 35010},
                {11, 33683},
                {12, 24266},
                {13, 28963},
                {14, 35004},
                {15, 31980},
                {16, 34220 },
                {17, 29191 },
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34204}, -- Amulet of Unfettered Magics
                {2, 34359}, -- Pendant of Sunfire
                {3, 32349}, -- Translucent Spellthread Necklace
                {4, 37928}, -- Guardian's Pendant of Subjugation
                {5, 34360}, -- Amulet of Flowing Life
                {6, 32589}, -- Hellfire-Encased Pendant (Fire)
                {7, 33281}, -- Brooch of Nature's Mercy
                {8, 33466}, -- Loop of Cursed Bones
                {9, 24116}, -- Eye of the Night (GROUP BUFF)
                {10, 37929}, -- Guardian's Pendant of Reprieve
                {11, 35319}, -- Vindicator's Pendant of Subjugation
                {12, 35290}, -- Sin'dorei Pendant of Conquest
                {13, 35132}, -- Guardian's Pendant of Conquest
                {14, 30015}, -- The Sun King's Talisman
                {15, 35317} -- Vindicator's Pendant of Reprieve
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34210},
                {2, 31054},
                {3, 34393},
                {4, 35006},
                {5, 32338},
                {6, 30884},
                {7, 30215},
                {8, 32587},
                {9, 33679},
                {10, 35009},
                {11, 28967},
                {12, 33489},
                {13, 30024},
                {14, 30079},
                {15, 31976},
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
                {4, 32331},
                {5, 33591},
                {6, 28766},
                {7, 34792},
                {8, 33592},
                {9, 29992},
                {10, 30735},
                {11, 35321},
                {12, 28797},
                {13, 23050},
                {14, 31201},
                {15, 27981},
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
                {5, 31052},
                {6, 30913},
                {7, 30214},
                {8, 34917},
                {9, 34936},
                {10, 34610},
                {11, 21848},
                {12, 35012},
                {13, 30056},
                {14, 28964},
                {15, 35007},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34436},
                {2, 32586},
                {3, 32270},
                {4, 33588},
                {5, 35179},
                {6, 30870},
                {7, 34697},
                {8, 33285},
                {9, 33913},
                {10, 30684},
                {11, 35168},
                {12, 29918},
                {13, 32820},
                {14, 33883},
                {15, 32655},
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
                {4, 31050},
                {5, 30725},
                {6, 21847},
                {7, 34808},
                {8, 33586},
                {9, 34938},
                {10, 28507},
                {11, 28780},
                {12, 29987},
                {13, 35011},
                {14, 34342},
                {15, 30211},
                {16, 33994, "Profession" },
                {17, 33997, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34541}, -- Belt of the Malefic
                {2, 30038}, -- Belt of Blasting
                {3, 30064}, -- Cord of Screaming Terrors
                {4, 30888}, -- Anetheron's Noose
                {5, 32256}, -- Waistwrap of Infinity
                {6, 21846}, -- Spellfire Belt (Fire/Arcane)
                {7, 33291}, -- Voodoo-woven Belt
                {8, 30020}, -- Fire-Cord of the Magus (Fire)
                {9, 24256}, -- Girdle of Ruination
                {10, 30673}, -- Inferno Waist Cord (Fire)
                {11, 28799}, -- Belt of Divine Inspiration
                {12, 30675}, -- Lurker's Cord of the Wrath
                {13, 35164}, -- Guardian's Silk Belt
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
                {5, 32527},
                {6, 34889},
                {7, 29305},
                {8, 34363},
                {9, 32528},
                {10, 33498},
                {11, 34166},
                {12, 29304},
                {13, 35282},
                {14, 28793},
                {15, 29303},
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
                {4, 32367},
                {5, 31053},
                {6, 30734},
                {7, 34918},
                {8, 30213},
                {9, 24262},
                {10, 34937},
                {11, 33584},
                {12, 29972},
                {13, 28594},
                {14, 28966},
                {15, 35013},
                {16, 24274 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34564},
                {2, 32239},
                {3, 30894},
                {4, 34919},
                {5, 30050},
                {6, 30037},
                {7, 33357},
                {8, 21870},
                {9, 30680},
                {10, 35149},
                {11, 30067},
                {12, 28517},
                {13, 28585},
                {14, 33914},
                {15, 35138},
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
                {6, 27683}, -- Quagmirran's Eye
                {7, 31856}, -- Darkmoon Card: Crusade
                {8, 28789}, -- Eye of Magtheridon
                {9, 34470}, -- Timbal's Focusing Crystal
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
                {2, 30910},
                {3, 35102},
                {4, 33763},
                {5, 33467},
                {6, 34895},
                {7, 32237},
                {8, 33354},
                {9, 32053},
                {10, 30723},
                {11, 30095},
                {12, 28770},
                {13, 28802},
                {14, 34604},
                {15, 28297},
                {16, 27981, "Profession" },
                {17, 27982, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34179}, -- Heart of the Pit
                {2, 30872}, -- Chronicle of Dark Secrets
                {3, 32361}, -- Blind-Seers Icon
                {4, 33334}, -- Fetish of the Primal Gods
                {5, 29270}, -- Flametongue Seal (Fire)
                {6, 28734}, -- Jewel of Infinite Possibilities
                {7, 30049}, -- Fathomstone
                {8, 35008}, -- Brutal Gladiator's Endgame
                {9, 29272}, -- Orb of the Soul-Eater (Shadow)
                {10, 28412}, -- Lamp of Peaceful Radiance
                {11, 29273}, -- Khadgar's Knapsack
                {12, 28603}, -- Talisman of Nightbane
                {13, 28187}, -- Star-Heart Lamp
                {14, 28781}, -- Karaborian Talisman
                {15, 33681} -- Vengeful Gladiator's Endgame
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
                {6, 32055},
                {7, 33766},
                {8, 33494},
                {9, 29988},
                {10, 24557},
                {11, 28633},
                {12, 22630},
                {13, 35514},
                {14, 29355},
                {15, 34797},
                {16, 27981, "Profession" },
                {17, 27982, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {
                {1, 34347}, -- Wand of the Demonsoul
                {2, 29982}, -- Wand of the Forgotten Star
                {3, 32343}, -- Wand of Prismatic Focus
                {4, 33192}, -- Carved Witch Doctor's Stick
                {5, 28673}, -- Tirisfal Wand of Ascendancy
                {6, 28783}, -- Eredar Wand of Obliteration
                {7, 22128}, -- Master Firestone (Fire)
                {8, 28386}, -- Nether Core's Control Rod
                {9, 29350}, -- The Black Stalk
                {10, 35107}, -- Brutal Gladiator's Touch of Defeat
                {11, 22820}, -- Wand of Fates
                {12, 32872}, -- Illidari Rod of Discipline
                {13, 34348}, -- Wand of Cleansing Light
                {14, 22821}, -- Doomfinger
                {15, 25295} -- Flawless Wand of Wrath
            }
        }

        --@end-version-bcc@
    }
}
























