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
                {1, 34340}, -- Dark Conjuror's Collar
                {2, 32525}, -- Cowl of the Illidari High Lord
                {3, 34405}, -- Helm of Arcane Purity
                {4, 34403}, -- Cover of Ursoc the Mighty
                {5, 31040}, -- Thunderheart Headguard
                {6, 35182}, -- Hyper-Magnified Moon Specs
                {7, 33453}, -- Hood of Hexing
                {8, 30233}, -- Nordrassil Headpiece
                {9, 29986}, -- Cowl of the Grand Engineer
                {10, 35112}, -- Brutal Gladiator's Wyrmhide Helm
                {11, 32480}, -- Magnified Moon Specs
                {12, 33768}, -- Vengeful Gladiator's Wyrmhide Helm
                {13, 24266}, -- Spellstrike Hood
                {14, 29093}, -- Antlers of Malorne
                {15, 33972} -- Mask of Primal Power
                ,
                {16, 34220},
                {17, 29191},
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
                {1, 34210}, -- Amice of the Convoker
                {2, 34391}, -- Spaulders of Devastation
                {3, 31049}, -- Thunderheart Shoulderpads
                {4, 34393}, -- Shoulderpads of Knowledge's Pursuit
                {5, 33973}, -- Pauldrons of Tribal Fury
                {6, 30884}, -- Hatefury Mantle
                {7, 32338}, -- Blood-cursed Shoulderpads
                {8, 30235}, -- Nordrassil Wrath-Mantle
                {9, 30024}, -- Mantle of the Elven Kings
                {10, 35114}, -- Brutal Gladiator's Wyrmhide Spaulders
                {11, 32587}, -- Mantle of Nimble Thought
                {12, 30079}, -- Illidari Shoulderpads
                {13, 34607}, -- Fel-tinged Mantle
                {14, 29095}, -- Pauldrons of Malorne
                {15, 33489} -- Mantle of Ill Intent
                ,
                {16, 28909},
                {17, 28886},
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34242}, -- Tattered Cape of Antonidas
                {2, 32331}, -- Cloak of the Illidari Council
                {3, 28766}, -- Ruby Drape of the Mysticant
                {4, 32524}, -- Shroud of the Highborne
                {5, 34792}, -- Cloak of the Betrayed
                {6, 33591}, -- Shadowcaster's Drape
                {7, 30735}, -- Ancient Spellcloak of the Highborne
                {8, 29992}, -- Royal Cloak of the Sunstriders
                {9, 28797}, -- Brute Cloak of the Ogre-Magi
                {10, 23050}, -- Cloak of the Necropolis
                {11, 31201}, -- Illidari Cloak of Wrath
                {12, 35321}, -- Cloak of Arcane Alacrity
                {13, 33592}, -- Cloak of Ancient Rituals
                {14, 22731}, -- Cloak of the Devoured
                {15, 27981} -- Sethekk Oracle Cloak
                ,
                {16, 33150},
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34364}, -- Sunfire Robe
                {2, 34399}, -- Robes of Ghostly Hatred
                {3, 34232}, -- Fel Conquerer Raiments
                {4, 34398}, -- Utopian Tunic of Elune
                {5, 31043}, -- Thunderheart Vest
                {6, 30107}, -- Vestments of the Sea-Witch
                {7, 30231}, -- Nordrassil Chestpiece
                {8, 30913}, -- Robes of Rhonin
                {9, 34917}, -- Shroud of the Lore`nial
                {10, 35115}, -- Brutal Gladiator's Wyrmhide Tunic
                {11, 29091}, -- Chestpiece of Malorne
                {12, 33566}, -- Blessed Elunite Coverings
                {13, 21848}, -- Spellfire Robe (Fire/Arcane)
                {14, 34936}, -- Tormented Demonsoul Robes
                {15, 34610} -- Scarlet Sin'dorei Robes
                ,
                {16, 22547},
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34446}, -- Thunderheart Bands
                {2, 32270}, -- Focused Mana Bindings
                {3, 32351}, -- Elunite Empowered Bracers
                {4, 30870}, -- Cuffs of Devastation
                {5, 32586}, -- Bracers of Nimble Thought
                {6, 33285}, -- Fury of the Ursine
                {7, 30684}, -- Ravager's Cuffs of Wrath
                {8, 33578}, -- Armwraps of the Kaldorei Protector
                {9, 29523}, -- Windhawk Bracers
                {10, 33588}, -- Runed Spell-cuffs
                {11, 29918}, -- Mindstorm Wristbands
                {12, 35180}, -- Guardian's Wyrmhide Bracers
                {13, 32820}, -- Veteran's Silk Cuffs
                {14, 32655}, -- Crystalweave Bracers
                {15, 31225} -- Illidari Bindings of Wrath
                ,
                {16, 35425},
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34344}, -- Handguards of Defiled Worlds
                {2, 34406}, -- Gloves of Tyri's Power
                {3, 34366}, -- Sunfire Handwraps
                {4, 34407}, -- Tranquil Moonlight Wraps
                {5, 31035}, -- Thunderheart Handguards
                {6, 34904}, -- Barbed Gloves of the Sage
                {7, 30725}, -- Anger-Spark Gloves
                {8, 21847}, -- Spellfire Gloves (Fire/Arcane)
                {9, 33586}, -- Studious Wraps
                {10, 34808}, -- Gloves of Arcane Acuity
                {11, 34938}, -- Enslaved Doomguard Soulgrips
                {12, 28507}, -- Handwraps of Flowing Thought
                {13, 28780}, -- Soul-Eater's Handwraps
                {14, 29987}, -- Gauntlets of the Sun King
                {15, 34372} -- Leather Gauntlets of the Sun
                ,
                {16, 35441},
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
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34362}, -- Loop of Forged Power
                {2, 33497}, -- Mana Attuned Band
                {3, 34230}, -- Ring of Omnipotence
                {4, 32247}, -- Ring of Captured Storms
                {5, 34889}, -- Fused Nethergon Band
                {6, 29305}, -- Band of the Eternal Sage
                {7, 32527}, -- Ring of Ancient Knowledge
                {8, 34363}, -- Ring of Flowing Life
                {9, 30667}, -- Ring of Unrelenting Storms (Nature)
                {10, 32528}, -- Blessed Band of Karabor
                {11, 29304}, -- Band of Eternity (revered)
                {12, 34166}, -- Band of Lucent Beams
                {13, 35282}, -- Sin'dorei Band of Dominance
                {14, 33498}, -- Signet of the Quiet Forest
                {15, 28793} -- Band of Crimson Fury
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34181}, -- Leggings of Calamity
                {2, 34386}, -- Pantaloons of Growing Strife
                {3, 30916}, -- Leggings of Channeled Elements
                {4, 34169}, -- Breeches of Natural Aggression
                {5, 32367}, -- Leggings of Devastation
                {6, 34918}, -- Legwraps of Sweltering Flame
                {7, 31046}, -- Thunderheart Pants
                {8, 30734}, -- Leggings of the Seventh Circle
                {9, 34905}, -- Crystalwind Leggings
                {10, 24262}, -- Spellstrike Pants
                {11, 34937}, -- Corrupted Soulcloth Pantaloons
                {12, 33971}, -- Elunite Imbued Leggings
                {13, 29972}, -- Trousers of the Astromancer
                {14, 30234}, -- Nordrassil Wrath-Kilt
                {15, 35113} -- Brutal Gladiator's Wyrmhide Legguards
                ,
                {16, 24274},
                {17, 24273},
                {18, 24275},
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34572}, -- Thunderheart Footwraps
                {2, 32239}, -- Slippers of the Seacaller
                {3, 34919}, -- Boots of Incantations
                {4, 32352}, -- Naturewarden's Treads
                {5, 33577}, -- Moon-walkers
                {6, 30894}, -- Blue Suede Shoes
                {7, 30037}, -- Boots of Blasting
                {8, 30680}, -- Glider's Foot-Wraps of Wrath
                {9, 33357}, -- Footpads of Madness
                {10, 30067}, -- Velvet Boots of the Guardian
                {11, 28517}, -- Boots of Foretelling
                {12, 28585}, -- Ruby Slippers
                {13, 35150}, -- Guardian's Wyrmhide Boots
                {14, 30680}, -- Glider's Foot-Wraps of the Invoker
                {15, 28406} -- Sigil-Laced Boots
                ,
                {16, 28280},
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
                {1, 34336}, -- Sunflare
                {2, 34176}, -- Reign of Misery
                {3, 35014}, -- Brutal Gladiator's Gavel
                {4, 35102}, -- Brutal Gladiator's Spellblade
                {5, 33687}, -- Vengeful Gladiator's Gavel
                {6, 33763}, -- Vengeful Gladiator's Spellblade
                {7, 34009}, -- Hammer of Judgement
                {8, 34895}, -- Scryer's Blade of Focus
                {9, 32237}, -- The Maelstrom's Fury
                {10, 33354}, -- Wub's Cursed Hexblade
                {11, 32053}, -- Merciless Gladiator's Spellblade
                {12, 32963}, -- Merciless Gladiator's Gavel
                {13, 33283}, -- Amani Punisher
                {14, 34611}, -- Cudgel of Consecration
                {15, 30723} -- Talon of the Tempest
                ,
                {16, 22560},
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
                {1, 34182}, -- Grand Magister's Staff of Torrents
                {2, 34987}, -- Brutal Gladiator's Battle Staff
                {3, 32374}, -- Zhar'doom, Greatstaff of the Devourer
                {4, 34540}, -- Vengeful Gladiator's Battle Staff
                {5, 35109}, -- Brutal Gladiator's War Staff
                {6, 32055}, -- Merciless Gladiator's War Staff
                {7, 33766}, -- Vengeful Gladiator's War Staff
                {8, 33494}, -- Amani Divining Staff
                {9, 29988}, -- The Nexus Key
                {10, 24557}, -- Gladiator's War Staff
                {11, 28633}, -- Staff of Infinite Mysteries
                {12, 35514}, -- Frostscythe of Lord Ahune
                {13, 29355}, -- Terokk's Shadowstaff
                {14, 34797}, -- Sun-infused Focus Staff
                {15, 32854} -- Hammer of Righteous Might
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
