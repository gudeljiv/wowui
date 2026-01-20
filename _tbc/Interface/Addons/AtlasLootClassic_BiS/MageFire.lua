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
                {1, 34340}, -- Dark Conjuror's Collar
                {2, 32525}, -- Cowl of the Illidari High Lord
                {3, 33453}, -- Hood of Hexing
                {4, 34847}, -- Annihilator Holo-Gogs
                {5, 29986}, -- Cowl of the Grand Engineer
                {6, 31056}, -- Cowl of the Tempest
                {7, 34405}, -- Helm of Arcane Purity
                {8, 24266}, -- Spellstrike Hood
                {9, 32494}, -- Destruction Holo-gogs
                {10, 35097}, -- Brutal Gladiator's Silk Cowl
                {11, 30206}, -- Cowl of Tirisfal
                {12, 28744}, -- Uni-Mind Headdress
                {13, 29076}, -- Collar of the Aldor
                {14, 33758}, -- Vengeful Gladiator's Silk Cowl
                {15, 31104} -- Evoker's Helmet of Second Sight
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
                {1, 34210}, -- Amice of the Convoker
                {2, 34393}, -- Shoulderpads of Knowledge's Pursuit
                {3, 30884}, -- Hatefury Mantle
                {4, 32338}, -- Blood-cursed Shoulderpads
                {5, 31059}, -- Mantle of the Tempest
                {6, 35096}, -- Brutal Gladiator's Silk Amice
                {7, 32587}, -- Mantle of Nimble Thought
                {8, 30024}, -- Mantle of the Elven Kings
                {9, 30210}, -- Mantle of Tirisfal
                {10, 30079}, -- Illidari Shoulderpads
                {11, 34607}, -- Fel-tinged Mantle
                {12, 33757}, -- Vengeful Gladiator's Silk Amice
                {13, 33489}, -- Mantle of Ill Intent
                {14, 32047}, -- Merciless Gladiator's Silk Amice
                {15, 34788} -- Duskhallow Mantle
                ,
                {16, 28886},
                {17, 28909},
                {18, 23545}
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34242}, -- Tattered Cape of Antonidas
                {2, 32331}, -- Cloak of the Illidari Council
                {3, 32524}, -- Shroud of the Highborne
                {4, 28766}, -- Ruby Drape of the Mysticant
                {5, 33591}, -- Shadowcaster's Drape
                {6, 30735}, -- Ancient Spellcloak of the Highborne
                {7, 34792}, -- Cloak of the Betrayed
                {8, 28797}, -- Brute Cloak of the Ogre-Magi
                {9, 29992}, -- Royal Cloak of the Sunstriders
                {10, 23050}, -- Cloak of the Necropolis
                {11, 33592}, -- Cloak of Ancient Rituals
                {12, 35321}, -- Cloak of Arcane Alacrity
                {13, 31201}, -- Illidari Cloak of Wrath
                {14, 33304}, -- Cloak of Subjugated Power
                {15, 29369} -- Shawl of Shifting Probabilities
                ,
                {16, 20735}
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34364}, -- Sunfire Robe
                {2, 34232}, -- Fel Conquerer Raiments
                {3, 34399}, -- Robes of Ghostly Hatred
                {4, 30107}, -- Vestments of the Sea-Witch
                {5, 30913}, -- Robes of Rhonin
                {6, 31057}, -- Robes of the Tempest
                {7, 34936}, -- Tormented Demonsoul Robes
                {8, 21848}, -- Spellfire Robe (Fire/Arcane)
                {9, 34610}, -- Scarlet Sin'dorei Robes
                {10, 34917}, -- Shroud of the Lore`nial
                {11, 35099}, -- Brutal Gladiator's Silk Raiment
                {12, 30056}, -- Robe of Hateful Echoes
                {13, 30196}, -- Robes of Tirisfal
                {14, 32327}, -- Robe of the Shadow Council
                {15, 33760} -- Vengeful Gladiator's Silk Raiment
                ,
                {16, 22547}
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34447}, -- Bracers of the Tempest
                {2, 32270}, -- Focused Mana Bindings
                {3, 32586}, -- Bracers of Nimble Thought
                {4, 35179}, -- Guardian's Silk Cuffs
                {5, 30870}, -- Cuffs of Devastation
                {6, 33285}, -- Fury of the Ursine
                {7, 33913}, -- Vindicator's Silk Cuffs
                {8, 33588}, -- Runed Spell-cuffs
                {9, 29918}, -- Mindstorm Wristbands
                {10, 30684}, -- Ravager's Cuffs of Wrath
                {11, 35168}, -- Guardian's Dreadweave Cuffs
                {12, 34697}, -- Bindings of Raging Fire
                {13, 32820}, -- Veteran's Silk Cuffs
                {14, 30684}, -- Ravager's Cuffs of the Invoker
                {15, 32655} -- Crystalweave Bracers
                ,
                {16, 22534},
                {17, 34001}
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34344}, -- Handguards of Defiled Worlds
                {2, 34366}, -- Sunfire Handwraps
                {3, 34406}, -- Gloves of Tyri's Power
                {4, 31055}, -- Gloves of the Tempest
                {5, 30725}, -- Anger-Spark Gloves
                {6, 21847}, -- Spellfire Gloves (Fire/Arcane)
                {7, 34938}, -- Enslaved Doomguard Soulgrips
                {8, 33586}, -- Studious Wraps
                {9, 34808}, -- Gloves of Arcane Acuity
                {10, 28780}, -- Soul-Eater's Handwraps
                {11, 28507}, -- Handwraps of Flowing Thought
                {12, 29080}, -- Gloves of the Aldor
                {13, 29987}, -- Gauntlets of the Sun King
                {14, 35098}, -- Brutal Gladiator's Silk Handguards
                {15, 30205} -- Gloves of Tirisfal
                ,
                {16, 33997}
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
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34362}, -- Loop of Forged Power
                {2, 34230}, -- Ring of Omnipotence
                {3, 33497}, -- Mana Attuned Band
                {4, 32247}, -- Ring of Captured Storms
                {5, 29305}, -- Band of the Eternal Sage
                {6, 34889}, -- Fused Nethergon Band
                {7, 32527}, -- Ring of Ancient Knowledge
                {8, 29304}, -- Band of Eternity (revered)
                {9, 35282}, -- Sin'dorei Band of Dominance
                {10, 34363}, -- Ring of Flowing Life
                {11, 32528}, -- Blessed Band of Karabor
                {12, 29303}, -- Band of Eternity (honored)
                {13, 28793}, -- Band of Crimson Fury
                {14, 34166}, -- Band of Lucent Beams
                {15, 33498} -- Signet of the Quiet Forest
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34181}, -- Leggings of Calamity
                {2, 34386}, -- Pantaloons of Growing Strife
                {3, 30916}, -- Leggings of Channeled Elements
                {4, 32367}, -- Leggings of Devastation
                {5, 31058}, -- Leggings of the Tempest
                {6, 30734}, -- Leggings of the Seventh Circle
                {7, 24262}, -- Spellstrike Pants
                {8, 34937}, -- Corrupted Soulcloth Pantaloons
                {9, 34918}, -- Legwraps of Sweltering Flame
                {10, 30207}, -- Leggings of Tirisfal
                {11, 33584}, -- Pantaloons of Arcane Annihilation
                {12, 35100}, -- Brutal Gladiator's Silk Trousers
                {13, 29972}, -- Trousers of the Astromancer
                {14, 28594}, -- Trial-Fire Trousers
                {15, 30531} -- Breeches of the Occultist
                ,
                {16, 24274},
                {17, 24273}
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34574}, -- Boots of the Tempest
                {2, 32239}, -- Slippers of the Seacaller
                {3, 30894}, -- Blue Suede Shoes
                {4, 30037}, -- Boots of Blasting
                {5, 34919}, -- Boots of Incantations
                {6, 33357}, -- Footpads of Madness
                {7, 35149}, -- Guardian's Silk Footguards
                {8, 30680}, -- Glider's Foot-Wraps of Wrath
                {9, 30067}, -- Velvet Boots of the Guardian
                {10, 28517}, -- Boots of Foretelling
                {11, 33914}, -- Vindicator's Silk Footguards
                {12, 30680}, -- Glider's Foot-Wraps of the Invoker
                {13, 28585}, -- Ruby Slippers
                {14, 28406}, -- Sigil-Laced Boots
                {15, 32795} -- Veteran's Silk Footguards
                ,
                {16, 28280}
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
                {1, 34336}, -- Sunflare
                {2, 30910}, -- Tempest of Chaos
                {3, 35102}, -- Brutal Gladiator's Spellblade
                {4, 33763}, -- Vengeful Gladiator's Spellblade
                {5, 32237}, -- The Maelstrom's Fury
                {6, 34895}, -- Scryer's Blade of Focus
                {7, 33354}, -- Wub's Cursed Hexblade
                {8, 33467}, -- Blade of Twisted Visions
                {9, 32053}, -- Merciless Gladiator's Spellblade
                {10, 30723}, -- Talon of the Tempest
                {11, 30095}, -- Fang of the Leviathan
                {12, 28802}, -- Bloodmaw Magus-Blade
                {13, 28770}, -- Nathrezim Mindblade
                {14, 34604}, -- Jaded Crystal Dagger
                {15, 28297} -- Gladiator's Spellblade
                ,
                {16, 22560},
                {17, 22555},
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
                {1, 34182}, -- Grand Magister's Staff of Torrents
                {2, 34987}, -- Brutal Gladiator's Battle Staff
                {3, 32374}, -- Zhar'doom, Greatstaff of the Devourer
                {4, 34540}, -- Vengeful Gladiator's Battle Staff
                {5, 35109}, -- Brutal Gladiator's War Staff
                {6, 32055}, -- Merciless Gladiator's War Staff
                {7, 33766}, -- Vengeful Gladiator's War Staff
                {8, 29988}, -- The Nexus Key
                {9, 33494}, -- Amani Divining Staff
                {10, 24557}, -- Gladiator's War Staff
                {11, 28633}, -- Staff of Infinite Mysteries
                {12, 29355}, -- Terokk's Shadowstaff
                {13, 22589}, -- Atiesh, Greatstaff of the Guardian
                {14, 34797}, -- Sun-infused Focus Staff
                {15, 29130} -- Auchenai Staff
                ,
                {16, 22560}
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
