local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["WarlockAff"] = {
    name = AL["Warlock Aff BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34340},
                {2, 32525},
                {3, 31051},
                {4, 34847},
                {5, 34405},
                {6, 33453},
                {7, 32494},
                {8, 30212},
                {9, 29986},
                {10, 35010},
                {11, 33683},
                {12, 28963},
                {13, 24266},
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
                {5, 24116}, -- Eye of the Night (GROUP BUFF)
                {6, 34360}, -- Amulet of Flowing Life
                {7, 33281}, -- Brooch of Nature's Mercy
                {8, 33466}, -- Loop of Cursed Bones
                {9, 37929}, -- Guardian's Pendant of Reprieve
                {10, 35319}, -- Vindicator's Pendant of Subjugation
                {11, 35290}, -- Sin'dorei Pendant of Conquest
                {12, 35317}, -- Vindicator's Pendant of Reprieve
                {13, 35132}, -- Guardian's Pendant of Conquest
                {14, 30015}, -- The Sun King's Talisman
                {15, 34184} -- Brooch of the Highborne
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
                {6, 30215},
                {7, 30884},
                {8, 32587},
                {9, 33679},
                {10, 28967},
                {11, 35009},
                {12, 30024},
                {13, 33489},
                {14, 31976},
                {15, 30079},
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
                {4, 28766},
                {5, 32331},
                {6, 33591},
                {7, 34792},
                {8, 33592},
                {9, 30735},
                {10, 35321},
                {11, 23050},
                {12, 29992},
                {13, 28797},
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
                {9, 34610},
                {10, 34936},
                {11, 35012},
                {12, 30056},
                {13, 28964},
                {14, 29341},
                {15, 33685},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34436},
                {2, 32270},
                {3, 32586},
                {4, 33588},
                {5, 35179},
                {6, 30870},
                {7, 33285},
                {8, 30684},
                {9, 33913},
                {10, 35168},
                {11, 29918},
                {12, 32820},
                {13, 32655},
                {14, 33883},
                {15, 28411},
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
                {4, 30725},
                {5, 31050},
                {6, 34808},
                {7, 28507},
                {8, 33586},
                {9, 34938},
                {10, 28780},
                {11, 24450},
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
                {6, 33291}, -- Voodoo-woven Belt
                {7, 24256}, -- Girdle of Ruination
                {8, 30675}, -- Lurker's Cord of the Wrath
                {9, 28799}, -- Belt of Divine Inspiration
                {10, 35164}, -- Guardian's Silk Belt
                {11, 27843}, -- Glyph-Lined Sash
                {12, 29241}, -- Belt of Depravity
                {13, 33912}, -- Vindicator's Silk Belt
                {14, 30675}, -- Lurker's Cord of Invoker
                {15, 28654} -- Malefic Girdle
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
                {6, 32527},
                {7, 29305},
                {8, 34363},
                {9, 32528},
                {10, 33498},
                {11, 34166},
                {12, 28793},
                {13, 29304},
                {14, 35282},
                {15, 29172},
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
                {7, 24262},
                {8, 30213},
                {9, 34918},
                {10, 34937},
                {11, 33584},
                {12, 28966},
                {13, 29972},
                {14, 30531},
                {15, 35013},
                {16, 24274 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34564},
                {2, 34919},
                {3, 32239},
                {4, 30050},
                {5, 30894},
                {6, 30037},
                {7, 33357},
                {8, 21870},
                {9, 30680},
                {10, 28517},
                {11, 35149},
                {12, 30067},
                {13, 28585},
                {14, 28406},
                {15, 33914},
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
                {4, 27683}, -- Quagmirran's Eye
                {5, 30626}, -- Sextant of Unstable Currents
                {6, 23207}, -- Mark of the Champion (undead/demon)
                {7, 31856}, -- Darkmoon Card: Crusade
                {8, 29132}, -- Scryer's Bloodgem
                {9, 28789}, -- Eye of Magtheridon
                {10, 34470}, -- Timbal's Focusing Crystal
                {11, 19379}, -- Neltharion's Tear
                {12, 29370}, -- Icon of the Silver Crescent
                {13, 38290}, -- Dark Iron Smoking Pipe
                {14, 28223}, -- Arcanist's Stone
                {15, 23046} -- The Restrained Essence of Sapphiron
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
                {6, 33354},
                {7, 32237},
                {8, 34895},
                {9, 32053},
                {10, 30723},
                {11, 30095},
                {12, 28802},
                {13, 28770},
                {14, 34604},
                {15, 28297},
                {16, 27981, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 30872}, -- Chronicle of Dark Secrets
                {2, 34179}, -- Heart of the Pit
                {3, 32361}, -- Blind-Seers Icon
                {4, 33334}, -- Fetish of the Primal Gods
                {5, 28734}, -- Jewel of Infinite Possibilities
                {6, 30049}, -- Fathomstone
                {7, 28412}, -- Lamp of Peaceful Radiance
                {8, 29272}, -- Orb of the Soul-Eater (Shadow)
                {9, 29273}, -- Khadgar's Knapsack
                {10, 35008}, -- Brutal Gladiator's Endgame
                {11, 28187}, -- Star-Heart Lamp
                {12, 28603}, -- Talisman of Nightbane
                {13, 25099}, -- Draenei Crystal Rod of Wrath
                {14, 32533}, -- Karrog's Shard
                {15, 28781} -- Karaborian Talisman
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
                {12, 22630},
                {13, 35514},
                {14, 34797},
                {15, 29355},
                {16, 27981, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {
                {1, 34347}, -- Wand of the Demonsoul
                {2, 29982}, -- Wand of the Forgotten Star
                {3, 32343}, -- Wand of Prismatic Focus
                {4, 28673}, -- Tirisfal Wand of Ascendancy
                {5, 33192}, -- Carved Witch Doctor's Stick
                {6, 28783}, -- Eredar Wand of Obliteration
                {7, 28386}, -- Nether Core's Control Rod
                {8, 30724}, -- Barrel-Blade Longrifle
                {9, 29350}, -- The Black Stalk
                {10, 22820}, -- Wand of Fates
                {11, 34348}, -- Wand of Cleansing Light
                {12, 22821}, -- Doomfinger
                {13, 32872}, -- Illidari Rod of Discipline
                {14, 35107}, -- Brutal Gladiator's Touch of Defeat
                {15, 25295} -- Flawless Wand of Wrath
            }
        }

        --@end-version-bcc@
    }
}


























