local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["Palret"] = {
    name = AL["Paladin Ret BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34244}, -- Duplicitous Guise
                {2, 34333}, -- Coif of Alleria
                {3, 34345}, -- Crown of Anasterian
                {4, 32235}, -- Cursed Vision of Sargeras
                {5, 34354}, -- Mayhem Projection Goggles
                {6, 32373}, -- Helm of the Illidari Shatterer
                {7, 32376}, -- Forest Prowler's Helm
                {8, 34404}, -- Mask of the Fury Hunter
                {9, 35090}, -- Brutal Gladiator's Scaled Helm
                {10, 32461}, -- Furious Gizmatic Goggles
                {11, 30989}, -- Lightbringer War-Helm
                {12, 30131}, -- Crystalforge War-Helm
                {13, 33751}, -- Vengeful Gladiator's Scaled Helm
                {14, 32041}, -- Merciless Gladiator's Scaled Helm
                {15, 29073} -- Justicar Crown
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34358}, -- Hard Khorium Choker
                {2, 34177}, -- Clutch of Demise
                {3, 32260}, -- Choker of Endless Nightmares
                {4, 34178}, -- Collar of the Pit Lord
                {5, 35292}, -- Sin'dorei Pendant of Triumph
                {6, 35135}, -- Guardian's Pendant of Triumph
                {7, 30022}, -- Pendant of the Perilous
                {8, 33296}, -- Brooch of Deftness
                {9, 30017}, -- Telonicus's Pendant of Mayhem
                {10, 33923}, -- Vindicator's Pendant of Triumph
                {11, 24114}, -- Braided Eternium Chain (GROUP BUFF)
                {12, 33297}, -- The Savage's Choker
                {13, 32591}, -- Choker of Serrated Blades
                {14, 29119}, -- Haramad's Bargain
                {15, 28745} -- Mithril Chain of Heroism
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34388}, -- Pauldrons of Berserking
                {2, 34195}, -- Shoulderpads of Vehemence
                {3, 34194}, -- Mantle of the Golden Forest
                {4, 34392}, -- Demontooth Shoulderpads
                {5, 30055}, -- Shoulderpads of the Stranger
                {6, 32581}, -- Swiftstrike Shoulders
                {7, 32570}, -- Swiftsteel Shoulders
                {8, 32575}, -- Shoulders of Lightning Reflexes
                {9, 30997}, -- Lightbringer Shoulderbraces
                {10, 32264}, -- Shoulders of the Hidden Predator
                {11, 30866}, -- Blood-stained Pauldrons
                {12, 30740}, -- Ripfiend Shoulderplates
                {13, 30053}, -- Pauldrons of the Wardancer
                {14, 35092}, -- Brutal Gladiator's Scaled Shoulders
                {15, 30133} -- Crystalforge Shoulderbraces
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34241}, -- Cloak of Unforgivable Sin
                {2, 33590}, -- Cloak of Fiends
                {3, 32323}, -- Shadowmoon Destroyer's Drape
                {4, 34190}, -- Crimson Paragon's Cover
                {5, 33122}, -- Cloak of Darkness (melee)
                {6, 30098}, -- Razor-Scale Battlecloak
                {7, 29994}, -- Thalassian Wildercloak
                {8, 24259}, -- Vengeance Wrap
                {9, 30729}, -- Black-Iron Battlecloak
                {10, 33484}, -- Dory's Embrace
                {11, 28777}, -- Cloak of the Pit Stalker
                {12, 28672}, -- Drape of the Dark Reavers
                {13, 34708}, -- Cloak of the Coming Night
                {14, 32665}, -- Crystalweave Cape
                {15, 29382} -- Blood Knight War Cloak
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34369}, -- Carapace of Sun and Shadow
                {2, 34397}, -- Bladed Chaos Tunic
                {3, 34215}, -- Warharness of Reckless Fury
                {4, 34377}, -- Hard Khorium Battleplate
                {5, 34211}, -- Harness of Carnal Instinct
                {6, 30905}, -- Midnight Chestguard
                {7, 30990}, -- Lightbringer Breastplate
                {8, 35088}, -- Brutal Gladiator's Scaled Chestpiece
                {9, 34942}, -- Breastplate of Ire
                {10, 34912}, -- Scaled Drakeskin Chestguard
                {11, 28485}, -- Bulwark of the Ancient Kings
                {12, 30129}, -- Crystalforge Breastplate
                {13, 34373}, -- Embrace of the Phoenix
                {14, 32365}, -- Heartshatter Breastplate
                {15, 34906} -- Embrace of Everlasting Prowess
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34431}, -- Lightbringer Bands
                {2, 32574}, -- Bindings of Lightning Reflexes
                {3, 32580}, -- Swiftstrike Bracers
                {4, 32568}, -- Swiftsteel Bracers
                {5, 30863}, -- Deadly Cuffs
                {6, 30057}, -- Bracers of Eradication
                {7, 32324}, -- Insidious Bands
                {8, 30861}, -- Furious Shackles
                {9, 28795}, -- Bladespire Warbands
                {10, 33540}, -- Master Assassin Wristwraps
                {11, 35176}, -- Guardian's Plate Bracers
                {12, 35178}, -- Guardian's Scaled Bracers
                {13, 32251}, -- Wraps of Precise Flight
                {14, 33813}, -- Vindicator's Plate Bracers
                {15, 33910} -- Vindicator's Scaled Bracers
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34343}, -- Thalassian Ranger Gauntlets
                {2, 34370}, -- Gloves of Immortal Dusk
                {3, 34234}, -- Shadowed Gauntlets of Paroxysm
                {4, 34341}, -- Borderland Paingrips
                {5, 34378}, -- Hard Khorium Battlefists
                {6, 34374}, -- Fletcher's Gloves of the Phoenix
                {7, 34408}, -- Gloves of the Forest Drifter
                {8, 32347}, -- Grips of Damnation
                {9, 32234}, -- Fists of Mukoa
                {10, 29947}, -- Gloves of the Searing Grip
                {11, 32608}, -- Pillager's Gauntlets
                {12, 32278}, -- Grips of Silent Justice
                {13, 34916}, -- Gauntlets of Rapidity
                {14, 34911}, -- Handwraps of the Aggressor
                {15, 33539} -- Trickster's Stickyfingers
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34485}, -- Lightbringer Girdle
                {2, 30106}, -- Belt of One-Hundred Deaths
                {3, 32265}, -- Shadow-walker's Cord
                {4, 30919}, -- Valestalker Girdle
                {5, 30879}, -- Don Alejandro's Money Belt
                {6, 30915}, -- Belt of Seething Fury
                {7, 32346}, -- Boneweave Girdle
                {8, 30032}, -- Red Belt of Battle
                {9, 32606}, -- Girdle of the Lightbearer
                {10, 34944}, -- Girdle of Seething Rage
                {11, 30040}, -- Belt of Deep Shadow
                {12, 34929}, -- Belt of the Silent Path
                {13, 33583}, -- Waistguard of the Great Beast
                {14, 33211}, -- Bladeangel's Money Belt
                {15, 28779} -- Girdle of the Endless Pit
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34361}, -- Hard Khorium Band
                {2, 34189}, -- Band of Ruinous Delight
                {3, 32335}, -- Unstoppable Aggressor's Ring
                {4, 32526}, -- Band of Devastation
                {5, 34887}, -- Angelista's Revenge
                {6, 30834}, -- Shapeshifter's Signet
                {7, 29301}, -- Band of the Eternal Champion
                {8, 33496}, -- Signet of Primal Wrath
                {9, 29997}, -- Band of the Ranger-General
                {10, 32497}, -- Stormrage Signet Ring
                {11, 35131}, -- Guardian's Band of Triumph
                {12, 30061}, -- Ancestral Ring of Conquest
                {13, 32266}, -- Ring of Deceitful Intent
                {14, 29300}, -- Band of Eternity (revered)
                {15, 30052} -- Ring of Lethality
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34180}, -- Felfury Legplates
                {2, 34188}, -- Leggings of the Immortal Night
                {3, 34168}, -- Starstalker Legguards
                {4, 34385}, -- Leggings of the Immortal Beast
                {5, 34943}, -- Legplates of Unending Fury
                {6, 30900}, -- Bow-stitched Leggings
                {7, 30903}, -- Legguards of Endless Rage
                {8, 32341}, -- Leggings of Divine Retribution
                {9, 34910}, -- Tameless Breeches
                {10, 30993}, -- Lightbringer Greaves
                {11, 34381}, -- Felstrength Legplates
                {12, 33538}, -- Shallow-grave Trousers
                {13, 29950}, -- Greaves of the Bloodwarder
                {14, 29995}, -- Leggings of Murderous Intent
                {15, 35091} -- Brutal Gladiator's Scaled Legguards
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34561}, -- Lightbringer Boots
                {2, 32345}, -- Dreadboots of the Legion
                {3, 32366}, -- Shadowmaster's Boots
                {4, 32510}, -- Softstep Boots of Tracking
                {5, 33222}, -- Nyn'jah's Tabi Boots
                {6, 33303}, -- Skullshatter Warboots
                {7, 29951}, -- Star-Strider Boots
                {8, 30104}, -- Cobra-Lash Boots
                {9, 35146}, -- Guardian's Plate Greaves
                {10, 30880}, -- Quickstrider Moccasins
                {11, 33582}, -- Footwraps of Wild Encroachment
                {12, 30081}, -- Warboots of Obliteration
                {13, 35148}, -- Guardian's Scaled Greaves
                {14, 28608}, -- Ironstriders of Urgency
                {15, 34809} -- Sunrage Treads
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 28830}, -- Dragonspine Trophy
                {2, 34472}, -- Shard of Contempt
                {3, 34427}, -- Blackened Naaru Sliver
                {4, 34428}, -- Steely Naaru Sliver
                {5, 31856}, -- Darkmoon Card: Crusade
                {6, 23206}, -- Mark of the Champion (undead/demon)
                {7, 33831}, -- Berserker's Call
                {8, 30627}, -- Tsunami Talisman
                {9, 32505}, -- Madness of the Betrayer
                {10, 35702}, -- Figurine - Shadowsong Panther
                {11, 28288}, -- Abacus of Violent Odds
                {12, 29383}, -- Bloodlust Brooch
                {13, 28034}, -- Hourglass of the Unraveller
                {14, 23041}, -- Slayer's Crest
                {15, 22954} -- Kiss of the Spider
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {}
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {}
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34247}, -- Apolyon, the Soul-Render
                {2, 34183}, -- Shivering Felspine
                {3, 34891}, -- The Blade of Harbingers
                {4, 34989}, -- Brutal Gladiator's Bonegrinder
                {5, 35015}, -- Brutal Gladiator's Greatsword
                {6, 32332}, -- Torch of the Damned
                {7, 30902}, -- Cataclysm's Edge
                {8, 34997}, -- Brutal Gladiator's Decapitator
                {9, 35064}, -- Brutal Gladiator's Painsaw
                {10, 33663}, -- Vengeful Gladiator's Bonegrinder
                {11, 33688}, -- Vengeful Gladiator's Greatsword
                {12, 28430}, -- Lionheart Executioner
                {13, 29993}, -- Twinblade of the Phoenix
                {14, 33670}, -- Vengeful Gladiator's Decapitator
                {15, 32348} -- Soul Cleaver
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
