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
                {1, 34332}, -- Cowl of Gul'dan
                {2, 34340}, -- Dark Conjuror's Collar
                {3, 34355}, -- Lightning Etched Specs
                {4, 34403}, -- Cover of Ursoc the Mighty
                {5, 34405}, -- Helm of Arcane Purity
                {6, 35182}, -- Hyper-Magnified Moon Specs
                {7, 32525}, -- Cowl of the Illidari High Lord
                {8, 31014}, -- Skyshatter Headguard
                {9, 35050}, -- Brutal Gladiator's Mail Helm
                {10, 30171}, -- Cataclysm Headpiece
                {11, 32476}, -- Gadgetstorm Goggles
                {12, 32480}, -- Magnified Moon Specs
                {13, 33713}, -- Vengeful Gladiator's Mail Helm
                {14, 33453}, -- Hood of Hexing
                {15, 29986} -- Cowl of the Grand Engineer
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
                {1, 34210}, -- Amice of the Convoker
                {2, 34390}, -- Erupting Epaulets
                {3, 34391}, -- Spaulders of Devastation
                {4, 34393}, -- Shoulderpads of Knowledge's Pursuit
                {5, 32587}, -- Mantle of Nimble Thought
                {6, 31023}, -- Skyshatter Mantle
                {7, 30884}, -- Hatefury Mantle
                {8, 33489}, -- Mantle of Ill Intent
                {9, 33970}, -- Pauldrons of the Furious Elements
                {10, 32338}, -- Blood-cursed Shoulderpads
                {11, 35052}, -- Brutal Gladiator's Mail Spaulders
                {12, 30173}, -- Cataclysm Shoulderpads
                {13, 30079}, -- Illidari Shoulderpads
                {14, 33973}, -- Pauldrons of Tribal Fury
                {15, 33715} -- Vengeful Gladiator's Mail Spaulders
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34242}, -- Tattered Cape of Antonidas
                {2, 32524}, -- Shroud of the Highborne
                {3, 32331}, -- Cloak of the Illidari Council
                {4, 33591}, -- Shadowcaster's Drape
                {5, 30735}, -- Ancient Spellcloak of the Highborne
                {6, 33592}, -- Cloak of Ancient Rituals
                {7, 28797}, -- Brute Cloak of the Ogre-Magi
                {8, 35321}, -- Cloak of Arcane Alacrity
                {9, 29992}, -- Royal Cloak of the Sunstriders
                {10, 31201}, -- Illidari Cloak of Wrath
                {11, 33304}, -- Cloak of Subjugated Power
                {12, 23050}, -- Cloak of the Necropolis
                {13, 29369}, -- Shawl of Shifting Probabilities
                {14, 35497}, -- Cloak of the Frigid Winds
                {15, 28766} -- Ruby Drape of the Mysticant
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34364}, -- Sunfire Robe
                {2, 34396}, -- Garments of Crashing Shores
                {3, 34232}, -- Fel Conquerer Raiments
                {4, 34399}, -- Robes of Ghostly Hatred
                {5, 34398}, -- Utopian Tunic of Elune
                {6, 34933}, -- Hauberk of Whirling Fury
                {7, 31017}, -- Skyshatter Breastplate
                {8, 33965}, -- Hauberk of the Furious Elements
                {9, 30107}, -- Vestments of the Sea-Witch
                {10, 34936}, -- Tormented Demonsoul Robes
                {11, 30913}, -- Robes of Rhonin
                {12, 32592}, -- Chestguard of Relentless Storms
                {13, 35048}, -- Brutal Gladiator's Mail Armor
                {14, 34610}, -- Scarlet Sin'dorei Robes
                {15, 30056} -- Robe of Hateful Echoes
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34437}, -- Skyshatter Bands
                {2, 32586}, -- Bracers of Nimble Thought
                {3, 33588}, -- Runed Spell-cuffs
                {4, 35173}, -- Guardian's Mail Bracers
                {5, 30870}, -- Cuffs of Devastation
                {6, 30684}, -- Ravager's Cuffs of Wrath
                {7, 32259}, -- Bands of the Coming Storm
                {8, 33897}, -- Vindicator's Mail Bracers
                {9, 29918}, -- Mindstorm Wristbands
                {10, 33578}, -- Armwraps of the Kaldorei Protector
                {11, 33285}, -- Fury of the Ursine
                {12, 32270}, -- Focused Mana Bindings
                {13, 29523}, -- Windhawk Bracers
                {14, 32655}, -- Crystalweave Bracers
                {15, 32817} -- Veteran's Mail Bracers
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34344}, -- Handguards of Defiled Worlds
                {2, 34406}, -- Gloves of Tyri's Power
                {3, 34350}, -- Gauntlets of the Ancient Shadowmoon
                {4, 34366}, -- Sunfire Handwraps
                {5, 34407}, -- Tranquil Moonlight Wraps
                {6, 31008}, -- Skyshatter Gauntlets
                {7, 34938}, -- Enslaved Doomguard Soulgrips
                {8, 33586}, -- Studious Wraps
                {9, 30725}, -- Anger-Spark Gloves
                {10, 33534}, -- Grips of Nature's Wrath
                {11, 33974}, -- Grasp of the Moonkin
                {12, 35049}, -- Brutal Gladiator's Mail Gauntlets
                {13, 28780}, -- Soul-Eater's Handwraps
                {14, 34376}, -- Sun-Drenched Scale Gloves
                {15, 29987} -- Gauntlets of the Sun King
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
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34230}, -- Ring of Omnipotence
                {2, 34362}, -- Loop of Forged Power
                {3, 32527}, -- Ring of Ancient Knowledge
                {4, 33497}, -- Mana Attuned Band
                {5, 29305}, -- Band of the Eternal Sage
                {6, 32247}, -- Ring of Captured Storms
                {7, 32528}, -- Blessed Band of Karabor
                {8, 34363}, -- Ring of Flowing Life
                {9, 33498}, -- Signet of the Quiet Forest
                {10, 30667}, -- Ring of Unrelenting Storms (Nature)
                {11, 35282}, -- Sin'dorei Band of Dominance
                {12, 29304}, -- Band of Eternity (revered)
                {13, 34166}, -- Band of Lucent Beams
                {14, 29303}, -- Band of Eternity (honored)
                {15, 30109} -- Ring of Endless Coils
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34181}, -- Leggings of Calamity
                {2, 34186}, -- Chain Links of the Tumultuous Storm
                {3, 34386}, -- Pantaloons of Growing Strife
                {4, 34169}, -- Breeches of Natural Aggression
                {5, 34934}, -- Rushing Storm Kilt
                {6, 30916}, -- Leggings of Channeled Elements
                {7, 34937}, -- Corrupted Soulcloth Pantaloons
                {8, 33584}, -- Pantaloons of Arcane Annihilation
                {9, 31020}, -- Skyshatter Legguards
                {10, 30734}, -- Leggings of the Seventh Circle
                {11, 34905}, -- Crystalwind Leggings
                {12, 33971}, -- Elunite Imbued Leggings
                {13, 33533}, -- Avalanche Leggings
                {14, 32367}, -- Leggings of Devastation
                {15, 24262} -- Spellstrike Pants
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34566}, -- Skyshatter Treads
                {2, 32239}, -- Slippers of the Seacaller
                {3, 33357}, -- Footpads of Madness
                {4, 32242}, -- Boots of Oceanic Fury
                {5, 32352}, -- Naturewarden's Treads
                {6, 33537}, -- Treads of Booming Thunder
                {7, 30680}, -- Glider's Foot-Wraps of Wrath
                {8, 35143}, -- Guardian's Mail Sabatons
                {9, 30067}, -- Velvet Boots of the Guardian
                {10, 33577}, -- Moon-walkers
                {11, 30037}, -- Boots of Blasting
                {12, 30894}, -- Blue Suede Shoes
                {13, 34919}, -- Boots of Incantations
                {14, 28517}, -- Boots of Foretelling
                {15, 30043} -- Hurricane Boots
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
                {1, 34336}, -- Sunflare
                {2, 34176}, -- Reign of Misery
                {3, 35014}, -- Brutal Gladiator's Gavel
                {4, 35102}, -- Brutal Gladiator's Spellblade
                {5, 32237}, -- The Maelstrom's Fury
                {6, 33687}, -- Vengeful Gladiator's Gavel
                {7, 33763}, -- Vengeful Gladiator's Spellblade
                {8, 34895}, -- Scryer's Blade of Focus
                {9, 34009}, -- Hammer of Judgement
                {10, 33354}, -- Wub's Cursed Hexblade
                {11, 32053}, -- Merciless Gladiator's Spellblade
                {12, 32963}, -- Merciless Gladiator's Gavel
                {13, 30723}, -- Talon of the Tempest
                {14, 33283}, -- Amani Punisher
                {15, 28770} -- Nathrezim Mindblade
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34179}, -- Heart of the Pit
                {2, 30872}, -- Chronicle of Dark Secrets
                {3, 30909}, -- Antonidas's Aegis of Rapt Concentration
                {4, 33334}, -- Fetish of the Primal Gods
                {5, 30049}, -- Fathomstone
                {6, 32361}, -- Blind-Seers Icon
                {7, 29273}, -- Khadgar's Knapsack
                {8, 34986}, -- Brutal Gladiator's Barrier
                {9, 35008}, -- Brutal Gladiator's Endgame
                {10, 28603}, -- Talisman of Nightbane
                {11, 25099}, -- Draenei Crystal Rod of Wrath
                {12, 32533}, -- Karrog's Shard
                {13, 29268}, -- Mazthoril Honor Shield
                {14, 34011}, -- Illidari Runeshield
                {15, 28781} -- Karaborian Talisman
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
                {11, 35514}, -- Frostscythe of Lord Ahune
                {12, 29355}, -- Terokk's Shadowstaff
                {13, 28633}, -- Staff of Infinite Mysteries
                {14, 32854}, -- Hammer of Righteous Might
                {15, 34797} -- Sun-infused Focus Staff
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
