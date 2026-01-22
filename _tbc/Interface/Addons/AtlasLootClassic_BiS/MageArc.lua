local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["MageArc"] = {
    name = AL["Mage Arcane BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34340},
                {2, 34405},
                {3, 34847},
                {4, 31056},
                {5, 32525},
                {6, 30206},
                {7, 34339},
                {8, 32494},
                {9, 35097},
                {10, 29076},
                {11, 33453},
                {12, 33758},
                {13, 32048},
                {14, 29986},
                {15, 28278},
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
                {3, 33281}, -- Brooch of Nature's Mercy
                {4, 37928}, -- Guardian's Pendant of Subjugation
                {5, 33466}, -- Loop of Cursed Bones
                {6, 34360}, -- Amulet of Flowing Life
                {7, 37929}, -- Guardian's Pendant of Reprieve
                {8, 35319}, -- Vindicator's Pendant of Subjugation
                {9, 35317}, -- Vindicator's Pendant of Reprieve
                {10, 34184}, -- Brooch of the Highborne
                {11, 35290}, -- Sin'dorei Pendant of Conquest
                {12, 35132}, -- Guardian's Pendant of Conquest
                {13, 30015}, -- The Sun King's Talisman
                {14, 35133}, -- Guardian's Pendant of Dominance
                {15, 24121} -- Chain of the Twilight Owl (GROUP BUFF)
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34210},
                {2, 32587},
                {3, 34393},
                {4, 33489},
                {5, 31059},
                {6, 34202},
                {7, 30884},
                {8, 30210},
                {9, 35096},
                {10, 32338},
                {11, 30079},
                {12, 29079},
                {13, 34607},
                {14, 30024},
                {15, 33757},
                {16, 28886 },
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34242},
                {2, 32524},
                {3, 33591},
                {4, 33592},
                {5, 32331},
                {6, 35321},
                {7, 29992},
                {8, 28797},
                {9, 30735},
                {10, 35324},
                {11, 34702},
                {12, 28766},
                {13, 28570},
                {14, 25777},
                {15, 33304},
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
                {4, 31057},
                {5, 33317},
                {6, 30107},
                {7, 34233},
                {8, 30196},
                {9, 30913},
                {10, 34365},
                {11, 34936},
                {12, 32327},
                {13, 30056},
                {14, 34917},
                {15, 34610},
                {16, 27960, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Bracer"], "2"),
            [NORMAL_DIFF] = {
                {1, 34447},
                {2, 32586},
                {3, 33588},
                {4, 30870},
                {5, 35179},
                {6, 33285},
                {7, 34697},
                {8, 32584},
                {9, 33913},
                {10, 35168},
                {11, 32270},
                {12, 29918},
                {13, 30684},
                {14, 32820},
                {15, 33883},
                {16, 27917, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Gloves"], "2"),
            [NORMAL_DIFF] = {
                {1, 34406},
                {2, 34344},
                {3, 34366},
                {4, 34342},
                {5, 31055},
                {6, 34938},
                {7, 33586},
                {8, 29987},
                {9, 21847},
                {10, 28780},
                {11, 30205},
                {12, 28507},
                {13, 29080},
                {14, 34808},
                {15, 35098},
                {16, 33997, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34557}, -- Belt of the Tempest
                {2, 32256}, -- Waistwrap of Infinity
                {3, 30888}, -- Anetheron's Noose
                {4, 21846}, -- Spellfire Belt (Fire/Arcane)
                {5, 30038}, -- Belt of Blasting
                {6, 30064}, -- Cord of Screaming Terrors
                {7, 30895}, -- Angelista's Sash
                {8, 35164}, -- Guardian's Silk Belt
                {9, 28799}, -- Belt of Divine Inspiration
                {10, 33291}, -- Voodoo-woven Belt
                {11, 24256}, -- Girdle of Ruination
                {12, 35153}, -- Guardian's Dreadweave Belt
                {13, 33912}, -- Vindicator's Silk Belt
                {14, 30675}, -- Lurker's Cord of Invoker
                {15, 27843} -- Glyph-Lined Sash
            }
        },
        {
            -- T2
            name = format(AL["Ring"], "2"),
            [NORMAL_DIFF] = {
                {1, 34362},
                {2, 34230},
                {3, 32527},
                {4, 33497},
                {5, 34363},
                {6, 32528},
                {7, 33498},
                {8, 34166},
                {9, 29305},
                {10, 37927},
                {11, 35320},
                {12, 29304},
                {13, 35129},
                {14, 29303},
                {15, 32247},
                {16, 27924, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34386},
                {2, 34181},
                {3, 33584},
                {4, 30916},
                {5, 31058},
                {6, 32367},
                {7, 34937},
                {8, 34918},
                {9, 30207},
                {10, 29972},
                {11, 30734},
                {12, 35100},
                {13, 28594},
                {14, 33585},
                {15, 24262},
                {16, 24274 },
            }
        },
        {
            -- T2
            name = format(AL["Boots"], "2"),
            [NORMAL_DIFF] = {
                {1, 34574},
                {2, 33357},
                {3, 32239},
                {4, 34919},
                {5, 35149},
                {6, 30894},
                {7, 30067},
                {8, 30037},
                {9, 28517},
                {10, 35138},
                {11, 33914},
                {12, 30680},
                {13, 32795},
                {14, 30680},
                {15, 33884},
                {16, 34008, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 34429}, -- Shifting Naaru Sliver
                {2, 32483}, -- The Skull of Gul'dan
                {3, 27683}, -- Quagmirran's Eye
                {4, 33829}, -- Hex Shrunken Head
                {5, 30626}, -- Sextant of Unstable Currents
                {6, 23207}, -- Mark of the Champion (undead/demon)
                {7, 31856}, -- Darkmoon Card: Crusade
                {8, 35326}, -- Battlemaster's Alacrity
                {9, 35327}, -- Battlemaster's Alacrity
                {10, 28789}, -- Eye of Magtheridon
                {11, 34470}, -- Timbal's Focusing Crystal
                {12, 29370}, -- Icon of the Silver Crescent
                {13, 38290}, -- Dark Iron Smoking Pipe
                {14, 23046}, -- The Restrained Essence of Sapphiron
                {15, 28418} -- Shiffar's Nexus-Horn
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34336},
                {2, 30910},
                {3, 35102},
                {4, 33467},
                {5, 34895},
                {6, 33763},
                {7, 32237},
                {8, 33354},
                {9, 30095},
                {10, 32053},
                {11, 30723},
                {12, 34604},
                {13, 28770},
                {14, 28802},
                {15, 28297},
                {16, 27981, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34179}, -- Heart of the Pit
                {2, 33334}, -- Fetish of the Primal Gods
                {3, 30872}, -- Chronicle of Dark Secrets
                {4, 32361}, -- Blind-Seers Icon
                {5, 35008}, -- Brutal Gladiator's Endgame
                {6, 29271}, -- Talisman of Kalecgos (Arcane)
                {7, 30049}, -- Fathomstone
                {8, 34206}, -- Book of Highborne Hymns
                {9, 28603}, -- Talisman of Nightbane
                {10, 28781}, -- Karaborian Talisman
                {11, 33681}, -- Vengeful Gladiator's Endgame
                {12, 31978}, -- Merciless Gladiator's Endgame
                {13, 29330}, -- The Saga of Terokk
                {14, 28734}, -- Jewel of Infinite Possibilities
                {15, 32651} -- Crystal Orb of Enlightenment
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
                {11, 28633},
                {12, 29355},
                {13, 22589},
                {14, 29130},
                {15, 34797},
                {16, 27981, "Profession" },
            }
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {
                {1, 34347}, -- Wand of the Demonsoul
                {2, 33192}, -- Carved Witch Doctor's Stick
                {3, 34348}, -- Wand of Cleansing Light
                {4, 28783}, -- Eredar Wand of Obliteration
                {5, 29982}, -- Wand of the Forgotten Star
                {6, 35107}, -- Brutal Gladiator's Touch of Defeat
                {7, 33764}, -- Vengeful Gladiator's Touch of Defeat
                {8, 32343}, -- Wand of Prismatic Focus
                {9, 32962}, -- Merciless Gladiator's Touch of Defeat
                {10, 28673}, -- Tirisfal Wand of Ascendancy
                {11, 30859}, -- Wand of the Seer
                {12, 25806}, -- Nethekurse's Rod of Torment
                {13, 25808}, -- Rod of Dire Shadows
                {14, 29350}, -- The Black Stalk
                {15, 28386} -- Nether Core's Control Rod
            }
        }

        --@end-version-bcc@
    }
}





































