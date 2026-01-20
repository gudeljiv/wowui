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
                {1, 34340}, -- Dark Conjuror's Collar
                {2, 32525}, -- Cowl of the Illidari High Lord
                {3, 31051}, -- Hood of the Malefic
                {4, 34847}, -- Annihilator Holo-Gogs
                {5, 34405}, -- Helm of Arcane Purity
                {6, 33453}, -- Hood of Hexing
                {7, 32494}, -- Destruction Holo-gogs
                {8, 30212}, -- Hood of the Corruptor
                {9, 29986}, -- Cowl of the Grand Engineer
                {10, 35010}, -- Brutal Gladiator's Felweave Cowl
                {11, 33683}, -- Vengeful Gladiator's Felweave Cowl
                {12, 28963}, -- Voidheart Crown
                {13, 24266}, -- Spellstrike Hood
                {14, 35004}, -- Brutal Gladiator's Dreadweave Hood
                {15, 31980} -- Merciless Gladiator's Felweave Cowl
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
                {1, 34210}, -- Amice of the Convoker
                {2, 31054}, -- Mantle of the Malefic
                {3, 34393}, -- Shoulderpads of Knowledge's Pursuit
                {4, 35006}, -- Brutal Gladiator's Dreadweave Mantle
                {5, 32338}, -- Blood-cursed Shoulderpads
                {6, 30215}, -- Mantle of the Corruptor
                {7, 30884}, -- Hatefury Mantle
                {8, 32587}, -- Mantle of Nimble Thought
                {9, 33679}, -- Vengeful Gladiator's Dreadweave Mantle
                {10, 28967}, -- Voidheart Mantle
                {11, 35009}, -- Brutal Gladiator's Felweave Amice
                {12, 30024}, -- Mantle of the Elven Kings
                {13, 33489}, -- Mantle of Ill Intent
                {14, 31976}, -- Merciless Gladiator's Dreadweave Mantle
                {15, 30079} -- Illidari Shoulderpads
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34242}, -- Tattered Cape of Antonidas
                {2, 32590}, -- Nethervoid Cloak (Shadow)
                {3, 32524}, -- Shroud of the Highborne
                {4, 28766}, -- Ruby Drape of the Mysticant
                {5, 32331}, -- Cloak of the Illidari Council
                {6, 33591}, -- Shadowcaster's Drape
                {7, 34792}, -- Cloak of the Betrayed
                {8, 33592}, -- Cloak of Ancient Rituals
                {9, 30735}, -- Ancient Spellcloak of the Highborne
                {10, 35321}, -- Cloak of Arcane Alacrity
                {11, 23050}, -- Cloak of the Necropolis
                {12, 29992}, -- Royal Cloak of the Sunstriders
                {13, 28797}, -- Brute Cloak of the Ogre-Magi
                {14, 31201}, -- Illidari Cloak of Wrath
                {15, 27981} -- Sethekk Oracle Cloak
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
                {5, 31052}, -- Robe of the Malefic
                {6, 30913}, -- Robes of Rhonin
                {7, 30214}, -- Robe of the Corruptor
                {8, 34917}, -- Shroud of the Lore`nial
                {9, 34610}, -- Scarlet Sin'dorei Robes
                {10, 34936}, -- Tormented Demonsoul Robes
                {11, 35012}, -- Brutal Gladiator's Felweave Raiment
                {12, 30056}, -- Robe of Hateful Echoes
                {13, 28964}, -- Voidheart Robe
                {14, 29341}, -- Auchenai Anchorite's Robe
                {15, 33685} -- Vengeful Gladiator's Felweave Raiment
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34436}, -- Bracers of the Malefic
                {2, 32270}, -- Focused Mana Bindings
                {3, 32586}, -- Bracers of Nimble Thought
                {4, 33588}, -- Runed Spell-cuffs
                {5, 35179}, -- Guardian's Silk Cuffs
                {6, 30870}, -- Cuffs of Devastation
                {7, 33285}, -- Fury of the Ursine
                {8, 30684}, -- Ravager's Cuffs of Wrath
                {9, 33913}, -- Vindicator's Silk Cuffs
                {10, 35168}, -- Guardian's Dreadweave Cuffs
                {11, 29918}, -- Mindstorm Wristbands
                {12, 32820}, -- Veteran's Silk Cuffs
                {13, 32655}, -- Crystalweave Bracers
                {14, 33883}, -- Vindicator's Dreadweave Cuffs
                {15, 28411} -- General's Silk Cuffs
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34344}, -- Handguards of Defiled Worlds
                {2, 34406}, -- Gloves of Tyri's Power
                {3, 34366}, -- Sunfire Handwraps
                {4, 30725}, -- Anger-Spark Gloves
                {5, 31050}, -- Gloves of the Malefic
                {6, 34808}, -- Gloves of Arcane Acuity
                {7, 28507}, -- Handwraps of Flowing Thought
                {8, 33586}, -- Studious Wraps
                {9, 34938}, -- Enslaved Doomguard Soulgrips
                {10, 28780}, -- Soul-Eater's Handwraps
                {11, 24450}, -- Manaspark Gloves
                {12, 29987}, -- Gauntlets of the Sun King
                {13, 35011}, -- Brutal Gladiator's Felweave Handguards
                {14, 34342}, -- Handguards of the Dawn
                {15, 30211} -- Gloves of the Corruptor
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
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34362}, -- Loop of Forged Power
                {2, 33497}, -- Mana Attuned Band
                {3, 34230}, -- Ring of Omnipotence
                {4, 32247}, -- Ring of Captured Storms
                {5, 34889}, -- Fused Nethergon Band
                {6, 32527}, -- Ring of Ancient Knowledge
                {7, 29305}, -- Band of the Eternal Sage
                {8, 34363}, -- Ring of Flowing Life
                {9, 32528}, -- Blessed Band of Karabor
                {10, 33498}, -- Signet of the Quiet Forest
                {11, 34166}, -- Band of Lucent Beams
                {12, 28793}, -- Band of Crimson Fury
                {13, 29304}, -- Band of Eternity (revered)
                {14, 35282}, -- Sin'dorei Band of Dominance
                {15, 29172} -- Ashyen's Gift
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
                {5, 31053}, -- Leggings of the Malefic
                {6, 30734}, -- Leggings of the Seventh Circle
                {7, 24262}, -- Spellstrike Pants
                {8, 30213}, -- Leggings of the Corruptor
                {9, 34918}, -- Legwraps of Sweltering Flame
                {10, 34937}, -- Corrupted Soulcloth Pantaloons
                {11, 33584}, -- Pantaloons of Arcane Annihilation
                {12, 28966}, -- Voidheart Leggings
                {13, 29972}, -- Trousers of the Astromancer
                {14, 30531}, -- Breeches of the Occultist
                {15, 35013} -- Brutal Gladiator's Felweave Trousers
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34564}, -- Boots of the Malefic
                {2, 34919}, -- Boots of Incantations
                {3, 32239}, -- Slippers of the Seacaller
                {4, 30050}, -- Boots of the Shifting Nightmare (Shadow)
                {5, 30894}, -- Blue Suede Shoes
                {6, 30037}, -- Boots of Blasting
                {7, 33357}, -- Footpads of Madness
                {8, 21870}, -- Frozen Shadoweave Boots (Shadow/Frost)
                {9, 30680}, -- Glider's Foot-Wraps of Wrath
                {10, 28517}, -- Boots of Foretelling
                {11, 35149}, -- Guardian's Silk Footguards
                {12, 30067}, -- Velvet Boots of the Guardian
                {13, 28585}, -- Ruby Slippers
                {14, 28406}, -- Sigil-Laced Boots
                {15, 33914} -- Vindicator's Silk Footguards
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
                {1, 34336}, -- Sunflare
                {2, 30910}, -- Tempest of Chaos
                {3, 35102}, -- Brutal Gladiator's Spellblade
                {4, 33763}, -- Vengeful Gladiator's Spellblade
                {5, 33467}, -- Blade of Twisted Visions
                {6, 33354}, -- Wub's Cursed Hexblade
                {7, 32237}, -- The Maelstrom's Fury
                {8, 34895}, -- Scryer's Blade of Focus
                {9, 32053}, -- Merciless Gladiator's Spellblade
                {10, 30723}, -- Talon of the Tempest
                {11, 30095}, -- Fang of the Leviathan
                {12, 28802}, -- Bloodmaw Magus-Blade
                {13, 28770}, -- Nathrezim Mindblade
                {14, 34604}, -- Jaded Crystal Dagger
                {15, 28297} -- Gladiator's Spellblade
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
                {12, 22630}, -- Atiesh, Greatstaff of the Guardian
                {13, 35514}, -- Frostscythe of Lord Ahune
                {14, 34797}, -- Sun-infused Focus Staff
                {15, 29355} -- Terokk's Shadowstaff
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
