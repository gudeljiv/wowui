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
                {1, 34340}, -- Dark Conjuror's Collar
                {2, 34847}, -- Annihilator Holo-Gogs
                {3, 32525}, -- Cowl of the Illidari High Lord
                {4, 34405}, -- Helm of Arcane Purity
                {5, 33453}, -- Hood of Hexing
                {6, 30161}, -- Hood of the Avatar
                {7, 32494}, -- Destruction Holo-gogs
                {8, 31064}, -- Hood of Absolution
                {9, 29986}, -- Cowl of the Grand Engineer
                {10, 24266}, -- Spellstrike Hood
                {11, 29058}, -- Soul-Collar of the Incarnate
                {12, 35084}, -- Brutal Gladiator's Satin Hood
                {13, 33745}, -- Vengeful Gladiator's Satin Hood
                {14, 28415}, -- Hood of Oblivion
                {15, 32089} -- Mana-Binders Cowl
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
                {1, 34210}, -- Amice of the Convoker
                {2, 34393}, -- Shoulderpads of Knowledge's Pursuit
                {3, 30884}, -- Hatefury Mantle
                {4, 31070}, -- Shoulderpads of Absolution
                {5, 32587}, -- Mantle of Nimble Thought
                {6, 21869}, -- Frozen Shadoweave Shoulders (Shadow/Frost)
                {7, 32338}, -- Blood-cursed Shoulderpads
                {8, 33489}, -- Mantle of Ill Intent
                {9, 30163}, -- Wings of the Avatar
                {10, 30079}, -- Illidari Shoulderpads
                {11, 34607}, -- Fel-tinged Mantle
                {12, 35086}, -- Brutal Gladiator's Satin Mantle
                {13, 30024}, -- Mantle of the Elven Kings
                {14, 34202}, -- Shawl of Wonderment
                {15, 34788} -- Duskhallow Mantle
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34242}, -- Tattered Cape of Antonidas
                {2, 32590}, -- Nethervoid Cloak (Shadow)
                {3, 32524}, -- Shroud of the Highborne
                {4, 33591}, -- Shadowcaster's Drape
                {5, 32331}, -- Cloak of the Illidari Council
                {6, 31201}, -- Illidari Cloak of Wrath
                {7, 34792}, -- Cloak of the Betrayed
                {8, 29992}, -- Royal Cloak of the Sunstriders
                {9, 28766}, -- Ruby Drape of the Mysticant
                {10, 35321}, -- Cloak of Arcane Alacrity
                {11, 33592}, -- Cloak of Ancient Rituals
                {12, 25041}, -- Ambusher's Cloak of Wrath
                {13, 30735}, -- Ancient Spellcloak of the Highborne
                {14, 28570}, -- Shadow-Cloak of Dalaran
                {15, 22731} -- Cloak of the Devoured
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
                {5, 31065}, -- Shroud of Absolution
                {6, 30159}, -- Shroud of the Avatar
                {7, 30913}, -- Robes of Rhonin
                {8, 34917}, -- Shroud of the Lore`nial
                {9, 29056}, -- Shroud of the Incarnate
                {10, 21871}, -- Frozen Shadoweave Robe (Shadow/Frost)
                {11, 34610}, -- Scarlet Sin'dorei Robes
                {12, 33317}, -- Robe of Departed Spirits
                {13, 30056}, -- Robe of Hateful Echoes
                {14, 35087}, -- Brutal Gladiator's Satin Robe
                {15, 34936} -- Tormented Demonsoul Robes
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34434}, -- Bracers of Absolution
                {2, 32586}, -- Bracers of Nimble Thought
                {3, 30684}, -- Ravager's Cuffs of Wrath
                {4, 32270}, -- Focused Mana Bindings
                {5, 33588}, -- Runed Spell-cuffs
                {6, 30870}, -- Cuffs of Devastation
                {7, 35168}, -- Guardian's Dreadweave Cuffs
                {8, 31225}, -- Illidari Bindings of Wrath
                {9, 33285}, -- Fury of the Ursine
                {10, 35179}, -- Guardian's Silk Cuffs
                {11, 24692}, -- Elementalist Bracelets of Wrath
                {12, 33913}, -- Vindicator's Silk Cuffs
                {13, 24250}, -- Bracers of Havok
                {14, 33883}, -- Vindicator's Dreadweave Cuffs
                {15, 29918} -- Mindstorm Wristbands
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34344}, -- Handguards of Defiled Worlds
                {2, 34406}, -- Gloves of Tyri's Power
                {3, 34366}, -- Sunfire Handwraps
                {4, 31061}, -- Handguards of Absolution
                {5, 30725}, -- Anger-Spark Gloves
                {6, 34808}, -- Gloves of Arcane Acuity
                {7, 28507}, -- Handwraps of Flowing Thought
                {8, 33586}, -- Studious Wraps
                {9, 28780}, -- Soul-Eater's Handwraps
                {10, 34938}, -- Enslaved Doomguard Soulgrips
                {11, 30160}, -- Handguards of the Avatar
                {12, 34342}, -- Handguards of the Dawn
                {13, 24450}, -- Manaspark Gloves
                {14, 29317}, -- Tempest's Touch
                {15, 29987} -- Gauntlets of the Sun King
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
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34362}, -- Loop of Forged Power
                {2, 33497}, -- Mana Attuned Band
                {3, 34230}, -- Ring of Omnipotence
                {4, 32527}, -- Ring of Ancient Knowledge
                {5, 32247}, -- Ring of Captured Storms
                {6, 34889}, -- Fused Nethergon Band
                {7, 32528}, -- Blessed Band of Karabor
                {8, 29305}, -- Band of the Eternal Sage
                {9, 34363}, -- Ring of Flowing Life
                {10, 33498}, -- Signet of the Quiet Forest
                {11, 34166}, -- Band of Lucent Beams
                {12, 35129}, -- Guardian's Band of Dominance
                {13, 21709}, -- Ring of the Fallen God
                {14, 34625}, -- Kharmaa's Ring of Fate
                {15, 23031} -- Band of the Inevitable
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34386}, -- Pantaloons of Growing Strife
                {2, 34181}, -- Leggings of Calamity
                {3, 30916}, -- Leggings of Channeled Elements
                {4, 32367}, -- Leggings of Devastation
                {5, 34918}, -- Legwraps of Sweltering Flame
                {6, 30734}, -- Leggings of the Seventh Circle
                {7, 24262}, -- Spellstrike Pants
                {8, 33584}, -- Pantaloons of Arcane Annihilation
                {9, 34937}, -- Corrupted Soulcloth Pantaloons
                {10, 29972}, -- Trousers of the Astromancer
                {11, 30162}, -- Leggings of the Avatar
                {12, 28594}, -- Trial-Fire Trousers
                {13, 31067}, -- Leggings of Absolution
                {14, 30531}, -- Breeches of the Occultist
                {15, 30532} -- Kirin Tor Master's Trousers
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34563}, -- Treads of Absolution
                {2, 21870}, -- Frozen Shadoweave Boots (Shadow/Frost)
                {3, 30680}, -- Glider's Foot-Wraps of Wrath
                {4, 33357}, -- Footpads of Madness
                {5, 32239}, -- Slippers of the Seacaller
                {6, 34919}, -- Boots of Incantations
                {7, 30050}, -- Boots of the Shifting Nightmare (Shadow)
                {8, 30894}, -- Blue Suede Shoes
                {9, 30037}, -- Boots of Blasting
                {10, 30067}, -- Velvet Boots of the Guardian
                {11, 28517}, -- Boots of Foretelling
                {12, 28179}, -- Shattrath Jumpers
                {13, 35138}, -- Guardian's Dreadweave Stalkers
                {14, 28585}, -- Ruby Slippers
                {15, 28406} -- Sigil-Laced Boots
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
                {1, 34336}, -- Sunflare
                {2, 34176}, -- Reign of Misery
                {3, 35014}, -- Brutal Gladiator's Gavel
                {4, 35102}, -- Brutal Gladiator's Spellblade
                {5, 33687}, -- Vengeful Gladiator's Gavel
                {6, 33763}, -- Vengeful Gladiator's Spellblade
                {7, 34009}, -- Hammer of Judgement
                {8, 34895}, -- Scryer's Blade of Focus
                {9, 32237}, -- The Maelstrom's Fury
                {10, 32053}, -- Merciless Gladiator's Spellblade
                {11, 32963}, -- Merciless Gladiator's Gavel
                {12, 33283}, -- Amani Punisher
                {13, 33354}, -- Wub's Cursed Hexblade
                {14, 34611}, -- Cudgel of Consecration
                {15, 30723} -- Talon of the Tempest
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
                {1, 34182}, -- Grand Magister's Staff of Torrents
                {2, 32374}, -- Zhar'doom, Greatstaff of the Devourer
                {3, 34987}, -- Brutal Gladiator's Battle Staff
                {4, 34540}, -- Vengeful Gladiator's Battle Staff
                {5, 35109}, -- Brutal Gladiator's War Staff
                {6, 33494}, -- Amani Divining Staff
                {7, 33766}, -- Vengeful Gladiator's War Staff
                {8, 32055}, -- Merciless Gladiator's War Staff
                {9, 29988}, -- The Nexus Key
                {10, 24557}, -- Gladiator's War Staff
                {11, 28633}, -- Staff of Infinite Mysteries
                {12, 35514}, -- Frostscythe of Lord Ahune
                {13, 29355}, -- Terokk's Shadowstaff
                {14, 34797}, -- Sun-infused Focus Staff
                {15, 28935} -- High Warlord's War Staff
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
