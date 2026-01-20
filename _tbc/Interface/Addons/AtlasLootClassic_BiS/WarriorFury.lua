local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["WarriorFury"] = {
    name = AL["Warrior Fury BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34333}, -- Coif of Alleria
                {2, 34345}, -- Crown of Anasterian
                {3, 34244}, -- Duplicitous Guise
                {4, 32235}, -- Cursed Vision of Sargeras
                {5, 34354}, -- Mayhem Projection Goggles
                {6, 35068}, -- Brutal Gladiator's Plate Helm
                {7, 32373}, -- Helm of the Illidari Shatterer
                {8, 30972}, -- Onslaught Battle-Helm
                {9, 33730}, -- Vengeful Gladiator's Plate Helm
                {10, 32376}, -- Forest Prowler's Helm
                {11, 30120}, -- Destroyer Battle-Helm
                {12, 32461}, -- Furious Gizmatic Goggles
                {13, 34404}, -- Mask of the Fury Hunter
                {14, 29021}, -- Warbringer Battle-Helm
                {15, 30488}, -- Merciless Gladiator's Plate Helm
                {16, 32409},
                {17, 29192},
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34358}, -- Hard Khorium Choker
                {2, 34177}, -- Clutch of Demise
                {3, 32260}, -- Choker of Endless Nightmares
                {4, 32591}, -- Choker of Serrated Blades
                {5, 35292}, -- Sin'dorei Pendant of Triumph
                {6, 35135}, -- Guardian's Pendant of Triumph
                {7, 24114}, -- Braided Eternium Chain (GROUP BUFF)
                {8, 33923}, -- Vindicator's Pendant of Triumph
                {9, 30022}, -- Pendant of the Perilous
                {10, 30059}, -- Choker of Animalistic Fury
                {11, 30017}, -- Telonicus's Pendant of Mayhem
                {12, 33297}, -- The Savage's Choker
                {13, 33066}, -- Veteran's Pendant of Triumph
                {14, 33296}, -- Brooch of Deftness
                {15, 29349} -- Adamantine Chain of the Unbroken
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34388}, -- Pauldrons of Berserking
                {2, 34194}, -- Mantle of the Golden Forest
                {3, 34195}, -- Shoulderpads of Vehemence
                {4, 34392}, -- Demontooth Shoulderpads
                {5, 30979}, -- Onslaught Shoulderblades
                {6, 32581}, -- Swiftstrike Shoulders
                {7, 32570}, -- Swiftsteel Shoulders
                {8, 32575}, -- Shoulders of Lightning Reflexes
                {9, 30055}, -- Shoulderpads of the Stranger
                {10, 35070}, -- Brutal Gladiator's Plate Shoulders
                {11, 30866}, -- Blood-stained Pauldrons
                {12, 32377}, -- Mantle of Darkness
                {13, 30740}, -- Ripfiend Shoulderplates
                {14, 32264}, -- Shoulders of the Hidden Predator
                {15, 33514} -- Pauldrons of Gruesome Fate
                ,
                {16, 28888},
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34241}, -- Cloak of Unforgivable Sin
                {2, 32323}, -- Shadowmoon Destroyer's Drape
                {3, 33484}, -- Dory's Embrace
                {4, 33590}, -- Cloak of Fiends
                {5, 30729}, -- Black-Iron Battlecloak
                {6, 24259}, -- Vengeance Wrap
                {7, 33122}, -- Cloak of Darkness (melee)
                {8, 29994}, -- Thalassian Wildercloak
                {9, 28777}, -- Cloak of the Pit Stalker
                {10, 30098}, -- Razor-Scale Battlecloak
                {11, 34708}, -- Cloak of the Coming Night
                {12, 28672}, -- Drape of the Dark Reavers
                {13, 34190}, -- Crimson Paragon's Cover
                {14, 27892}, -- Cloak of the Inciter
                {15, 32665} -- Crystalweave Cape
                ,
                {16, 35432},
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34397}, -- Bladed Chaos Tunic
                {2, 34377}, -- Hard Khorium Battleplate
                {3, 34369}, -- Carapace of Sun and Shadow
                {4, 34215}, -- Warharness of Reckless Fury
                {5, 34211}, -- Harness of Carnal Instinct
                {6, 35066}, -- Brutal Gladiator's Plate Chestpiece
                {7, 30975}, -- Onslaught Breastplate
                {8, 30905}, -- Midnight Chestguard
                {9, 33728}, -- Vengeful Gladiator's Plate Chestpiece
                {10, 28485}, -- Bulwark of the Ancient Kings
                {11, 30101}, -- Bloodsea Brigand's Vest
                {12, 32365}, -- Heartshatter Breastplate
                {13, 30118}, -- Destroyer Breastplate
                {14, 33329}, -- Shadowtooth Trollskin Cuirass
                {15, 34912} -- Scaled Drakeskin Chestguard
                ,
                {16, 35429},
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34441}, -- Onslaught Bracers
                {2, 30863}, -- Deadly Cuffs
                {3, 32574}, -- Bindings of Lightning Reflexes
                {4, 30057}, -- Bracers of Eradication
                {5, 32580}, -- Swiftstrike Bracers
                {6, 32568}, -- Swiftsteel Bracers
                {7, 32324}, -- Insidious Bands
                {8, 28795}, -- Bladespire Warbands
                {9, 33540}, -- Master Assassin Wristwraps
                {10, 30861}, -- Furious Shackles
                {11, 33513}, -- Eternium Rage-shackles
                {12, 35176}, -- Guardian's Plate Bracers
                {13, 35178}, -- Guardian's Scaled Bracers
                {14, 32251}, -- Wraps of Precise Flight
                {15, 33529} -- Steadying Bracers
                ,
                {16, 35420},
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34343}, -- Thalassian Ranger Gauntlets
                {2, 34370}, -- Gloves of Immortal Dusk
                {3, 34341}, -- Borderland Paingrips
                {4, 34234}, -- Shadowed Gauntlets of Paroxysm
                {5, 34378}, -- Hard Khorium Battlefists
                {6, 34374}, -- Fletcher's Gloves of the Phoenix
                {7, 34408}, -- Gloves of the Forest Drifter
                {8, 32278}, -- Grips of Silent Justice
                {9, 32347}, -- Grips of Damnation
                {10, 32234}, -- Fists of Mukoa
                {11, 32608}, -- Pillager's Gauntlets
                {12, 30969}, -- Onslaught Gauntlets
                {13, 34916}, -- Gauntlets of Rapidity
                {14, 29947}, -- Gloves of the Searing Grip
                {15, 33539} -- Trickster's Stickyfingers
                ,
                {16, 35442},
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34546}, -- Onslaught Belt
                {2, 30106}, -- Belt of One-Hundred Deaths
                {3, 32346}, -- Boneweave Girdle
                {4, 32265}, -- Shadow-walker's Cord
                {5, 30919}, -- Valestalker Girdle
                {6, 33331}, -- Chain of Unleashed Rage
                {7, 30879}, -- Don Alejandro's Money Belt
                {8, 30032}, -- Red Belt of Battle
                {9, 33211}, -- Bladeangel's Money Belt
                {10, 30915}, -- Belt of Seething Fury
                {11, 30040}, -- Belt of Deep Shadow
                {12, 34929}, -- Belt of the Silent Path
                {13, 32606}, -- Girdle of the Lightbearer
                {14, 34944}, -- Girdle of Seething Rage
                {15, 28779} -- Girdle of the Endless Pit
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34189}, -- Band of Ruinous Delight
                {2, 34361}, -- Hard Khorium Band
                {3, 32497}, -- Stormrage Signet Ring
                {4, 34887}, -- Angelista's Revenge
                {5, 33496}, -- Signet of Primal Wrath
                {6, 35131}, -- Guardian's Band of Triumph
                {7, 32335}, -- Unstoppable Aggressor's Ring
                {8, 32526}, -- Band of Devastation
                {9, 29997}, -- Band of the Ranger-General
                {10, 29301}, -- Band of the Eternal Champion
                {11, 33919}, -- Vindicator's Band of Triumph
                {12, 30738}, -- Ring of Reciprocity
                {13, 28757}, -- Ring of a Thousand Marks
                {14, 35284}, -- Sin'dorei Band of Triumph
                {15, 32266} -- Ring of Deceitful Intent
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34188}, -- Leggings of the Immortal Night
                {2, 34180}, -- Felfury Legplates
                {3, 32341}, -- Leggings of Divine Retribution
                {4, 34385}, -- Leggings of the Immortal Beast
                {5, 34168}, -- Starstalker Legguards
                {6, 35069}, -- Brutal Gladiator's Plate Legguards
                {7, 34943}, -- Legplates of Unending Fury
                {8, 30977}, -- Onslaught Greaves
                {9, 30900}, -- Bow-stitched Leggings
                {10, 30903}, -- Legguards of Endless Rage
                {11, 33731}, -- Vengeful Gladiator's Plate Legguards
                {12, 30898}, -- Shady Dealer's Pantaloons
                {13, 29995}, -- Leggings of Murderous Intent
                {14, 34910}, -- Tameless Breeches
                {15, 29950} -- Greaves of the Bloodwarder
                ,
                {16, 29535},
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34569}, -- Onslaught Treads
                {2, 32345}, -- Dreadboots of the Legion
                {3, 32366}, -- Shadowmaster's Boots
                {4, 32510}, -- Softstep Boots of Tracking
                {5, 34809}, -- Sunrage Treads
                {6, 33222}, -- Nyn'jah's Tabi Boots
                {7, 35146}, -- Guardian's Plate Greaves
                {8, 33303}, -- Skullshatter Warboots
                {9, 34807}, -- Sunstrider Warboots
                {10, 30039}, -- Boots of Utter Darkness
                {11, 30880}, -- Quickstrider Moccasins
                {12, 29951}, -- Star-Strider Boots
                {13, 30104}, -- Cobra-Lash Boots
                {14, 30081}, -- Warboots of Obliteration
                {15, 35148} -- Guardian's Scaled Greaves
                ,
                {16, 28279},
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 28830}, -- Dragonspine Trophy
                {2, 30446}, -- Solarian's Sapphire (Group AP Buff)
                {3, 34427}, -- Blackened Naaru Sliver
                {4, 34472}, -- Shard of Contempt
                {5, 34428}, -- Steely Naaru Sliver
                {6, 32505}, -- Madness of the Betrayer
                {7, 30627}, -- Tsunami Talisman
                {8, 23206}, -- Mark of the Champion (undead/demon)
                {9, 33831}, -- Berserker's Call
                {10, 35702}, -- Figurine - Shadowsong Panther
                {11, 28034}, -- Hourglass of the Unraveller
                {12, 31856}, -- Darkmoon Card: Crusade
                {13, 28288}, -- Abacus of Violent Odds
                {14, 29383}, -- Bloodlust Brooch
                {15, 22954} -- Kiss of the Spider
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 32837}, -- Warglaive of Azzinoth
                {2, 34346}, -- Mounting Vengeance
                {3, 35076}, -- Brutal Gladiator's Right Ripper
                {4, 34995}, -- Brutal Gladiator's Chopper
                {5, 35037}, -- Brutal Gladiator's Left Render
                {6, 34996}, -- Brutal Gladiator's Cleaver
                {7, 35071}, -- Brutal Gladiator's Pummeler
                {8, 34214}, -- Muramasa
                {9, 34331}, -- Hand of the Deceiver
                {10, 32262}, -- Syphon of the Nathrezim
                {11, 33737}, -- Vengeful Gladiator's Right Ripper
                {12, 34015}, -- Vengeful Gladiator's Chopper
                {13, 34016}, -- Vengeful Gladiator's Left Render
                {14, 33669}, -- Vengeful Gladiator's Cleaver
                {15, 33733} -- Vengeful Gladiator's Pummeler
                ,
                {16, 22559},
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34346}, -- Mounting Vengeance
                {2, 34995}, -- Brutal Gladiator's Chopper
                {3, 35037}, -- Brutal Gladiator's Left Render
                {4, 34996}, -- Brutal Gladiator's Cleaver
                {5, 35071}, -- Brutal Gladiator's Pummeler
                {6, 34214}, -- Muramasa
                {7, 32262}, -- Syphon of the Nathrezim
                {8, 34015}, -- Vengeful Gladiator's Chopper
                {9, 34016}, -- Vengeful Gladiator's Left Render
                {10, 33669}, -- Vengeful Gladiator's Cleaver
                {11, 33733}, -- Vengeful Gladiator's Pummeler
                {12, 29996}, -- Rod of the Sun King
                {13, 35101}, -- Brutal Gladiator's Slicer
                {14, 30881}, -- Blade of Infamy
                {15, 30082} -- Talon of Azshara
                ,
                {16, 22559},
            }
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {}
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {
                {1, 34334}, -- Thori'dal, the Stars' Fury
                {2, 34196}, -- Golden Bow of Quel'Thalas
                {3, 33474}, -- Ancient Amani Longbow
                {4, 34892}, -- Crossbow of Relentless Strikes
                {5, 33491}, -- Tuskbreaker
                {6, 30105}, -- Serpent Spine Longbow
                {7, 30724}, -- Barrel-Blade Longrifle
                {8, 28772}, -- Sunfury Bow of the Phoenix
                {9, 30279}, -- Mama's Insurance
                {10, 29949}, -- Arcanite Steam-Pistol
                {11, 29151}, -- Veteran's Musket
                {12, 29152}, -- Marksman's Bow
                {13, 30906}, -- Bristleblitz Striker
                {14, 28581}, -- Wolfslayer Sniper Rifle
                {15, 22812} -- Nerubian Slavemaker
                ,
                {16, 23765},
            }
        }

        --@end-version-bcc@
    }
}
