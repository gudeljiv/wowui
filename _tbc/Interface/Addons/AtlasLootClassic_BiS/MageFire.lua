local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["Mage Fire"] = {
    name = AL["Mage Fire BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34340},
                {2, 32525},
                {3, 33453},
                {4, 34847},
                {5, 29986},
                {6, 31056},
                {7, 34405},
                {8, 24266},
                {9, 32494},
                {10, 35097},
                {11, 30206},
                {12, 28744},
                {13, 29076},
                {14, 33758},
                {15, 31104},
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
                {3, 32349}, -- Translucent Spellthread Necklace
                {4, 32589}, -- Hellfire-Encased Pendant (Fire)
                {5, 24116}, -- Eye of the Night (GROUP BUFF)
                {6, 37928}, -- Guardian's Pendant of Subjugation
                {7, 35290}, -- Sin'dorei Pendant of Conquest
                {8, 30015}, -- The Sun King's Talisman
                {9, 35132}, -- Guardian's Pendant of Conquest
                {10, 33281}, -- Brooch of Nature's Mercy
                {11, 33466}, -- Loop of Cursed Bones
                {12, 34360}, -- Amulet of Flowing Life
                {13, 24121}, -- Chain of the Twilight Owl (GROUP BUFF)
                {14, 37929}, -- Guardian's Pendant of Reprieve
                {15, 35319} -- Vindicator's Pendant of Subjugation
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34210},
                {2, 34393},
                {3, 30884},
                {4, 32338},
                {5, 31059},
                {6, 35096},
                {7, 32587},
                {8, 30024},
                {9, 30210},
                {10, 30079},
                {11, 34607},
                {12, 33757},
                {13, 33489},
                {14, 32047},
                {15, 34788},
                {16, 28886 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34242},
                {2, 32331},
                {3, 32524},
                {4, 28766},
                {5, 33591},
                {6, 30735},
                {7, 34792},
                {8, 28797},
                {9, 29992},
                {10, 23050},
                {11, 33592},
                {12, 35321},
                {13, 31201},
                {14, 33304},
                {15, 29369},
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
                {5, 30913},
                {6, 31057},
                {7, 34936},
                {8, 21848},
                {9, 34610},
                {10, 34917},
                {11, 35099},
                {12, 30056},
                {13, 30196},
                {14, 32327},
                {15, 33760},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34447},
                {2, 32270},
                {3, 32586},
                {4, 35179},
                {5, 30870},
                {6, 33285},
                {7, 33913},
                {8, 33588},
                {9, 29918},
                {10, 30684},
                {11, 35168},
                {12, 34697},
                {13, 32820},
                {14, 30684},
                {15, 32655},
                {16, 27917, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34344},
                {2, 34366},
                {3, 34406},
                {4, 31055},
                {5, 30725},
                {6, 21847},
                {7, 34938},
                {8, 33586},
                {9, 34808},
                {10, 28780},
                {11, 28507},
                {12, 29080},
                {13, 29987},
                {14, 35098},
                {15, 30205},
                {16, 33997, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34557}, -- Belt of the Tempest
                {2, 30038}, -- Belt of Blasting
                {3, 30064}, -- Cord of Screaming Terrors
                {4, 30888}, -- Anetheron's Noose
                {5, 33291}, -- Voodoo-woven Belt
                {6, 21846}, -- Spellfire Belt (Fire/Arcane)
                {7, 32256}, -- Waistwrap of Infinity
                {8, 30020}, -- Fire-Cord of the Magus (Fire)
                {9, 30673}, -- Inferno Waist Cord (Fire)
                {10, 24256}, -- Girdle of Ruination
                {11, 35164}, -- Guardian's Silk Belt
                {12, 30675}, -- Lurker's Cord of the Wrath
                {13, 28799}, -- Belt of Divine Inspiration
                {14, 27843}, -- Glyph-Lined Sash
                {15, 33912} -- Vindicator's Silk Belt
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 34362},
                {2, 34230},
                {3, 33497},
                {4, 32247},
                {5, 29305},
                {6, 34889},
                {7, 32527},
                {8, 29304},
                {9, 35282},
                {10, 34363},
                {11, 32528},
                {12, 29303},
                {13, 28793},
                {14, 34166},
                {15, 33498},
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
                {5, 31058},
                {6, 30734},
                {7, 24262},
                {8, 34937},
                {9, 34918},
                {10, 30207},
                {11, 33584},
                {12, 35100},
                {13, 29972},
                {14, 28594},
                {15, 30531},
                {16, 24274 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34574},
                {2, 32239},
                {3, 30894},
                {4, 30037},
                {5, 34919},
                {6, 33357},
                {7, 35149},
                {8, 30680},
                {9, 30067},
                {10, 28517},
                {11, 33914},
                {12, 30680},
                {13, 28585},
                {14, 28406},
                {15, 32795},
                {16, 34008, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 32483}, -- The Skull of Gul'dan
                {2, 34429}, -- Shifting Naaru Sliver
                {3, 30626}, -- Sextant of Unstable Currents
                {4, 33829}, -- Hex Shrunken Head
                {5, 23207}, -- Mark of the Champion (undead/demon)
                {6, 31856}, -- Darkmoon Card: Crusade
                {7, 27683}, -- Quagmirran's Eye
                {8, 28789}, -- Eye of Magtheridon
                {9, 34470}, -- Timbal's Focusing Crystal
                {10, 29370}, -- Icon of the Silver Crescent
                {11, 38290}, -- Dark Iron Smoking Pipe
                {12, 30720}, -- Serpent-Coil Braid
                {13, 29132}, -- Scryer's Bloodgem
                {14, 28418}, -- Shiffar's Nexus-Horn
                {15, 19379} -- Neltharion's Tear
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
                {5, 32237},
                {6, 34895},
                {7, 33354},
                {8, 33467},
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
                {2, 32361}, -- Blind-Seers Icon
                {3, 34179}, -- Heart of the Pit
                {4, 29270}, -- Flametongue Seal (Fire)
                {5, 33334}, -- Fetish of the Primal Gods
                {6, 30049}, -- Fathomstone
                {7, 28734}, -- Jewel of Infinite Possibilities
                {8, 28412}, -- Lamp of Peaceful Radiance
                {9, 35008}, -- Brutal Gladiator's Endgame
                {10, 28603}, -- Talisman of Nightbane
                {11, 29273}, -- Khadgar's Knapsack
                {12, 28781}, -- Karaborian Talisman
                {13, 25099}, -- Draenei Crystal Rod of Wrath
                {14, 28187}, -- Star-Heart Lamp
                {15, 32533} -- Karrog's Shard
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
                {8, 29988},
                {9, 33494},
                {10, 24557},
                {11, 28633},
                {12, 29355},
                {13, 22589},
                {14, 34797},
                {15, 29130},
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
                {4, 33192}, -- Carved Witch Doctor's Stick
                {5, 28673}, -- Tirisfal Wand of Ascendancy
                {6, 28783}, -- Eredar Wand of Obliteration
                {7, 29350}, -- The Black Stalk
                {8, 28386}, -- Nether Core's Control Rod
                {9, 22821}, -- Doomfinger
                {10, 35107}, -- Brutal Gladiator's Touch of Defeat
                {11, 32872}, -- Illidari Rod of Discipline
                {12, 25295}, -- Flawless Wand of Wrath
                {13, 22820}, -- Wand of Fates
                {14, 33764}, -- Vengeful Gladiator's Touch of Defeat
                {15, 25939} -- Voidfire Wand
            }
        }

        --@end-version-bcc@
    }
}





































