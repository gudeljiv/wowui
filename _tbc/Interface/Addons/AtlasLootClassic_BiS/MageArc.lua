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
                {1, 34340}, -- Dark Conjuror's Collar
                {2, 34405}, -- Helm of Arcane Purity
                {3, 34847}, -- Annihilator Holo-Gogs
                {4, 31056}, -- Cowl of the Tempest
                {5, 32525}, -- Cowl of the Illidari High Lord
                {6, 30206}, -- Cowl of Tirisfal
                {7, 34339}, -- Cowl of Light's Purity
                {8, 32494}, -- Destruction Holo-gogs
                {9, 35097}, -- Brutal Gladiator's Silk Cowl
                {10, 29076}, -- Collar of the Aldor
                {11, 33453}, -- Hood of Hexing
                {12, 33758}, -- Vengeful Gladiator's Silk Cowl
                {13, 32048}, -- Merciless Gladiator's Silk Cowl
                {14, 29986}, -- Cowl of the Grand Engineer
                {15, 28278} -- Incanter's Cowl
                ,
                {16, 34220},
                {17, 29191}
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
                {1, 34210}, -- Amice of the Convoker
                {2, 32587}, -- Mantle of Nimble Thought
                {3, 34393}, -- Shoulderpads of Knowledge's Pursuit
                {4, 33489}, -- Mantle of Ill Intent
                {5, 31059}, -- Mantle of the Tempest
                {6, 34202}, -- Shawl of Wonderment
                {7, 30884}, -- Hatefury Mantle
                {8, 30210}, -- Mantle of Tirisfal
                {9, 35096}, -- Brutal Gladiator's Silk Amice
                {10, 32338}, -- Blood-cursed Shoulderpads
                {11, 30079}, -- Illidari Shoulderpads
                {12, 29079}, -- Pauldrons of the Aldor
                {13, 34607}, -- Fel-tinged Mantle
                {14, 30024}, -- Mantle of the Elven Kings
                {15, 33757} -- Vengeful Gladiator's Silk Amice
                ,
                {16, 28886}
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34242}, -- Tattered Cape of Antonidas
                {2, 32524}, -- Shroud of the Highborne
                {3, 33591}, -- Shadowcaster's Drape
                {4, 33592}, -- Cloak of Ancient Rituals
                {5, 32331}, -- Cloak of the Illidari Council
                {6, 35321}, -- Cloak of Arcane Alacrity
                {7, 29992}, -- Royal Cloak of the Sunstriders
                {8, 28797}, -- Brute Cloak of the Ogre-Magi
                {9, 30735}, -- Ancient Spellcloak of the Highborne
                {10, 35324}, -- Cloak of Swift Reprieve
                {11, 34702}, -- Cloak of Swift Mending
                {12, 28766}, -- Ruby Drape of the Mysticant
                {13, 28570}, -- Shadow-Cloak of Dalaran
                {14, 25777}, -- Ogre Slayer's Cover
                {15, 33304} -- Cloak of Subjugated Power
                ,
                {16, 20735}
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34364}, -- Sunfire Robe
                {2, 34399}, -- Robes of Ghostly Hatred
                {3, 34232}, -- Fel Conquerer Raiments
                {4, 31057}, -- Robes of the Tempest
                {5, 33317}, -- Robe of Departed Spirits
                {6, 30107}, -- Vestments of the Sea-Witch
                {7, 34233}, -- Robes of Faltered Light
                {8, 30196}, -- Robes of Tirisfal
                {9, 30913}, -- Robes of Rhonin
                {10, 34365}, -- Robe of Eternal Light
                {11, 34936}, -- Tormented Demonsoul Robes
                {12, 32327}, -- Robe of the Shadow Council
                {13, 30056}, -- Robe of Hateful Echoes
                {14, 34917}, -- Shroud of the Lore`nial
                {15, 34610} -- Scarlet Sin'dorei Robes
                ,
                {16, 22547}
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34447}, -- Bracers of the Tempest
                {2, 32586}, -- Bracers of Nimble Thought
                {3, 33588}, -- Runed Spell-cuffs
                {4, 30870}, -- Cuffs of Devastation
                {5, 35179}, -- Guardian's Silk Cuffs
                {6, 33285}, -- Fury of the Ursine
                {7, 34697}, -- Bindings of Raging Fire
                {8, 32584}, -- Swiftheal Wraps
                {9, 33913}, -- Vindicator's Silk Cuffs
                {10, 35168}, -- Guardian's Dreadweave Cuffs
                {11, 32270}, -- Focused Mana Bindings
                {12, 29918}, -- Mindstorm Wristbands
                {13, 30684}, -- Ravager's Cuffs of the Invoker
                {14, 32820}, -- Veteran's Silk Cuffs
                {15, 33883} -- Vindicator's Dreadweave Cuffs
                ,
                {16, 35423},
                {17, 22534}
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34406}, -- Gloves of Tyri's Power
                {2, 34344}, -- Handguards of Defiled Worlds
                {3, 34366}, -- Sunfire Handwraps
                {4, 34342}, -- Handguards of the Dawn
                {5, 31055}, -- Gloves of the Tempest
                {6, 34938}, -- Enslaved Doomguard Soulgrips
                {7, 33586}, -- Studious Wraps
                {8, 29987}, -- Gauntlets of the Sun King
                {9, 21847}, -- Spellfire Gloves (Fire/Arcane)
                {10, 28780}, -- Soul-Eater's Handwraps
                {11, 30205}, -- Gloves of Tirisfal
                {12, 28507}, -- Handwraps of Flowing Thought
                {13, 29080}, -- Gloves of the Aldor
                {14, 34808}, -- Gloves of Arcane Acuity
                {15, 35098} -- Brutal Gladiator's Silk Handguards
                ,
                {16, 28272}
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
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34362}, -- Loop of Forged Power
                {2, 34230}, -- Ring of Omnipotence
                {3, 32527}, -- Ring of Ancient Knowledge
                {4, 33497}, -- Mana Attuned Band
                {5, 34363}, -- Ring of Flowing Life
                {6, 32528}, -- Blessed Band of Karabor
                {7, 33498}, -- Signet of the Quiet Forest
                {8, 34166}, -- Band of Lucent Beams
                {9, 29305}, -- Band of the Eternal Sage
                {10, 37927}, -- Guardian's Band of Subjugation
                {11, 35320}, -- Vindicator's Band of Subjugation
                {12, 29304}, -- Band of Eternity (revered)
                {13, 35129}, -- Guardian's Band of Dominance
                {14, 29303}, -- Band of Eternity (honored)
                {15, 32247} -- Ring of Captured Storms
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34386}, -- Pantaloons of Growing Strife
                {2, 34181}, -- Leggings of Calamity
                {3, 33584}, -- Pantaloons of Arcane Annihilation
                {4, 30916}, -- Leggings of Channeled Elements
                {5, 31058}, -- Leggings of the Tempest
                {6, 32367}, -- Leggings of Devastation
                {7, 34937}, -- Corrupted Soulcloth Pantaloons
                {8, 34918}, -- Legwraps of Sweltering Flame
                {9, 30207}, -- Leggings of Tirisfal
                {10, 29972}, -- Trousers of the Astromancer
                {11, 30734}, -- Leggings of the Seventh Circle
                {12, 35100}, -- Brutal Gladiator's Silk Trousers
                {13, 28594}, -- Trial-Fire Trousers
                {14, 33585}, -- Achromic Trousers of the Naaru
                {15, 24262} -- Spellstrike Pants
                ,
                {16, 24274}
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34574}, -- Boots of the Tempest
                {2, 33357}, -- Footpads of Madness
                {3, 32239}, -- Slippers of the Seacaller
                {4, 34919}, -- Boots of Incantations
                {5, 35149}, -- Guardian's Silk Footguards
                {6, 30894}, -- Blue Suede Shoes
                {7, 30067}, -- Velvet Boots of the Guardian
                {8, 30037}, -- Boots of Blasting
                {9, 28517}, -- Boots of Foretelling
                {10, 35138}, -- Guardian's Dreadweave Stalkers
                {11, 33914}, -- Vindicator's Silk Footguards
                {12, 30680}, -- Glider's Foot-Wraps of the Invoker
                {13, 32795}, -- Veteran's Silk Footguards
                {14, 30680}, -- Glider's Foot-Wraps of Wrath
                {15, 33884} -- Vindicator's Dreadweave Stalkers
                ,
                {16, 28280}
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
                {1, 34336}, -- Sunflare
                {2, 30910}, -- Tempest of Chaos
                {3, 35102}, -- Brutal Gladiator's Spellblade
                {4, 33467}, -- Blade of Twisted Visions
                {5, 34895}, -- Scryer's Blade of Focus
                {6, 33763}, -- Vengeful Gladiator's Spellblade
                {7, 32237}, -- The Maelstrom's Fury
                {8, 33354}, -- Wub's Cursed Hexblade
                {9, 30095}, -- Fang of the Leviathan
                {10, 32053}, -- Merciless Gladiator's Spellblade
                {11, 30723}, -- Talon of the Tempest
                {12, 34604}, -- Jaded Crystal Dagger
                {13, 28770}, -- Nathrezim Mindblade
                {14, 28802}, -- Bloodmaw Magus-Blade
                {15, 28297} -- Gladiator's Spellblade
                ,
                {16, 22560}
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
                {1, 32374}, -- Zhar'doom, Greatstaff of the Devourer
                {2, 34182}, -- Grand Magister's Staff of Torrents
                {3, 34987}, -- Brutal Gladiator's Battle Staff
                {4, 35109}, -- Brutal Gladiator's War Staff
                {5, 34540}, -- Vengeful Gladiator's Battle Staff
                {6, 33766}, -- Vengeful Gladiator's War Staff
                {7, 29988}, -- The Nexus Key
                {8, 33494}, -- Amani Divining Staff
                {9, 32055}, -- Merciless Gladiator's War Staff
                {10, 24557}, -- Gladiator's War Staff
                {11, 28633}, -- Staff of Infinite Mysteries
                {12, 29355}, -- Terokk's Shadowstaff
                {13, 22589}, -- Atiesh, Greatstaff of the Guardian
                {14, 29130}, -- Auchenai Staff
                {15, 34797} -- Sun-infused Focus Staff
                ,
                {16, 22560}
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
