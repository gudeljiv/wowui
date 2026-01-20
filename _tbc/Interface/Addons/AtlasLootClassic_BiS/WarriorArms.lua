local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["WarriorArms"] = {
    name = AL["Warrior Arms BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34333}, -- Coif of Alleria
                {2, 34345}, -- Crown of Anasterian
                {3, 34354}, -- Mayhem Projection Goggles
                {4, 34244}, -- Duplicitous Guise
                {5, 32235}, -- Cursed Vision of Sargeras
                {6, 32373}, -- Helm of the Illidari Shatterer
                {7, 35068}, -- Brutal Gladiator's Plate Helm
                {8, 30972}, -- Onslaught Battle-Helm
                {9, 33730}, -- Vengeful Gladiator's Plate Helm
                {10, 30120}, -- Destroyer Battle-Helm
                {11, 32376}, -- Forest Prowler's Helm
                {12, 32461}, -- Furious Gizmatic Goggles
                {13, 34404}, -- Mask of the Fury Hunter
                {14, 29021}, -- Warbringer Battle-Helm
                {15, 30488} -- Merciless Gladiator's Plate Helm
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34358}, -- Hard Khorium Choker
                {2, 32260}, -- Choker of Endless Nightmares
                {3, 32591}, -- Choker of Serrated Blades
                {4, 34177}, -- Clutch of Demise
                {5, 35292}, -- Sin'dorei Pendant of Triumph
                {6, 35135}, -- Guardian's Pendant of Triumph
                {7, 24114}, -- Braided Eternium Chain (GROUP BUFF)
                {8, 30022}, -- Pendant of the Perilous
                {9, 33923}, -- Vindicator's Pendant of Triumph
                {10, 30059}, -- Choker of Animalistic Fury
                {11, 30017}, -- Telonicus's Pendant of Mayhem
                {12, 33066}, -- Veteran's Pendant of Triumph
                {13, 29381}, -- Choker of Vile Intent
                {14, 35507}, -- Amulet of Bitter Hatred
                {15, 28509} -- Worgen Claw Necklace
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34194}, -- Mantle of the Golden Forest
                {2, 34388}, -- Pauldrons of Berserking
                {3, 34392}, -- Demontooth Shoulderpads
                {4, 30979}, -- Onslaught Shoulderblades
                {5, 34195}, -- Shoulderpads of Vehemence
                {6, 30866}, -- Blood-stained Pauldrons
                {7, 35070}, -- Brutal Gladiator's Plate Shoulders
                {8, 30740}, -- Ripfiend Shoulderplates
                {9, 32377}, -- Mantle of Darkness
                {10, 30055}, -- Shoulderpads of the Stranger
                {11, 30122}, -- Destroyer Shoulderblades
                {12, 33514}, -- Pauldrons of Gruesome Fate
                {13, 30053}, -- Pauldrons of the Wardancer
                {14, 32264}, -- Shoulders of the Hidden Predator
                {15, 33732} -- Vengeful Gladiator's Plate Shoulders
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34241}, -- Cloak of Unforgivable Sin
                {2, 32323}, -- Shadowmoon Destroyer's Drape
                {3, 33484}, -- Dory's Embrace
                {4, 33122}, -- Cloak of Darkness (melee)
                {5, 30729}, -- Black-Iron Battlecloak
                {6, 24259}, -- Vengeance Wrap
                {7, 29994}, -- Thalassian Wildercloak
                {8, 30098}, -- Razor-Scale Battlecloak
                {9, 33590}, -- Cloak of Fiends
                {10, 28777}, -- Cloak of the Pit Stalker
                {11, 28672}, -- Drape of the Dark Reavers
                {12, 27892}, -- Cloak of the Inciter
                {13, 28371}, -- Netherfury Cape
                {14, 27878}, -- Auchenai Death Shroud
                {15, 29382} -- Blood Knight War Cloak
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34397}, -- Bladed Chaos Tunic
                {2, 34377}, -- Hard Khorium Battleplate
                {3, 34369}, -- Carapace of Sun and Shadow
                {4, 34211}, -- Harness of Carnal Instinct
                {5, 34215}, -- Warharness of Reckless Fury
                {6, 35066}, -- Brutal Gladiator's Plate Chestpiece
                {7, 30905}, -- Midnight Chestguard
                {8, 30975}, -- Onslaught Breastplate
                {9, 33728}, -- Vengeful Gladiator's Plate Chestpiece
                {10, 28485}, -- Bulwark of the Ancient Kings
                {11, 32365}, -- Heartshatter Breastplate
                {12, 30101}, -- Bloodsea Brigand's Vest
                {13, 30118}, -- Destroyer Breastplate
                {14, 32252}, -- Nether Shadow Tunic
                {15, 28484} -- Bulwark of Kings
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34441}, -- Onslaught Bracers
                {2, 30863}, -- Deadly Cuffs
                {3, 30057}, -- Bracers of Eradication
                {4, 32324}, -- Insidious Bands
                {5, 30861}, -- Furious Shackles
                {6, 28795}, -- Bladespire Warbands
                {7, 33540}, -- Master Assassin Wristwraps
                {8, 35176}, -- Guardian's Plate Bracers
                {9, 33513}, -- Eternium Rage-shackles
                {10, 35178}, -- Guardian's Scaled Bracers
                {11, 32251}, -- Wraps of Precise Flight
                {12, 30091}, -- True-Aim Stalker Bands
                {13, 33813}, -- Vindicator's Plate Bracers
                {14, 32574}, -- Bindings of Lightning Reflexes
                {15, 33529} -- Steadying Bracers
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34343}, -- Thalassian Ranger Gauntlets
                {2, 34370}, -- Gloves of Immortal Dusk
                {3, 34341}, -- Borderland Paingrips
                {4, 34408}, -- Gloves of the Forest Drifter
                {5, 32278}, -- Grips of Silent Justice
                {6, 34234}, -- Shadowed Gauntlets of Paroxysm
                {7, 34378}, -- Hard Khorium Battlefists
                {8, 34374}, -- Fletcher's Gloves of the Phoenix
                {9, 30969}, -- Onslaught Gauntlets
                {10, 34916}, -- Gauntlets of Rapidity
                {11, 28824}, -- Gauntlets of Martial Perfection
                {12, 28776}, -- Liar's Tongue Gloves
                {13, 35067}, -- Brutal Gladiator's Plate Gauntlets
                {14, 29947}, -- Gloves of the Searing Grip
                {15, 33528} -- Gauntlets of Sniping
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34546}, -- Onslaught Belt
                {2, 30106}, -- Belt of One-Hundred Deaths
                {3, 32346}, -- Boneweave Girdle
                {4, 30032}, -- Red Belt of Battle
                {5, 30879}, -- Don Alejandro's Money Belt
                {6, 33331}, -- Chain of Unleashed Rage
                {7, 33211}, -- Bladeangel's Money Belt
                {8, 34929}, -- Belt of the Silent Path
                {9, 30040}, -- Belt of Deep Shadow
                {10, 33583}, -- Waistguard of the Great Beast
                {11, 28779}, -- Girdle of the Endless Pit
                {12, 30046}, -- Belt of the Black Eagle
                {13, 35161}, -- Guardian's Plate Belt
                {14, 28828}, -- Gronn-Stitched Girdle
                {15, 32265} -- Shadow-walker's Cord
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34189}, -- Band of Ruinous Delight
                {2, 32497}, -- Stormrage Signet Ring
                {3, 34887}, -- Angelista's Revenge
                {4, 33496}, -- Signet of Primal Wrath
                {5, 32335}, -- Unstoppable Aggressor's Ring
                {6, 29997}, -- Band of the Ranger-General
                {7, 34361}, -- Hard Khorium Band
                {8, 35131}, -- Guardian's Band of Triumph
                {9, 29301}, -- Band of the Eternal Champion
                {10, 30738}, -- Ring of Reciprocity
                {11, 28757}, -- Ring of a Thousand Marks
                {12, 33919}, -- Vindicator's Band of Triumph
                {13, 32266}, -- Ring of Deceitful Intent
                {14, 35284}, -- Sin'dorei Band of Triumph
                {15, 30052} -- Ring of Lethality
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
                {7, 30977}, -- Onslaught Greaves
                {8, 30903}, -- Legguards of Endless Rage
                {9, 30900}, -- Bow-stitched Leggings
                {10, 33731}, -- Vengeful Gladiator's Plate Legguards
                {11, 34943}, -- Legplates of Unending Fury
                {12, 30898}, -- Shady Dealer's Pantaloons
                {13, 29950}, -- Greaves of the Bloodwarder
                {14, 30121}, -- Destroyer Greaves
                {15, 29995} -- Leggings of Murderous Intent
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
                {5, 33222}, -- Nyn'jah's Tabi Boots
                {6, 34809}, -- Sunrage Treads
                {7, 35146}, -- Guardian's Plate Greaves
                {8, 33303}, -- Skullshatter Warboots
                {9, 30880}, -- Quickstrider Moccasins
                {10, 30039}, -- Boots of Utter Darkness
                {11, 34807}, -- Sunstrider Warboots
                {12, 30081}, -- Warboots of Obliteration
                {13, 35148}, -- Guardian's Scaled Greaves
                {14, 29951}, -- Star-Strider Boots
                {15, 30104} -- Cobra-Lash Boots
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 30446}, -- Solarian's Sapphire (Group AP Buff)
                {2, 34472}, -- Shard of Contempt
                {3, 34427}, -- Blackened Naaru Sliver
                {4, 28830}, -- Dragonspine Trophy
                {5, 32505}, -- Madness of the Betrayer
                {6, 30627}, -- Tsunami Talisman
                {7, 34428}, -- Steely Naaru Sliver
                {8, 23206}, -- Mark of the Champion (undead/demon)
                {9, 33831}, -- Berserker's Call
                {10, 35702}, -- Figurine - Shadowsong Panther
                {11, 31856}, -- Darkmoon Card: Crusade
                {12, 29383}, -- Bloodlust Brooch
                {13, 28034}, -- Hourglass of the Unraveller
                {14, 23041}, -- Slayer's Crest
                {15, 28288} -- Abacus of Violent Odds
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
                {3, 34989}, -- Brutal Gladiator's Bonegrinder
                {4, 35015}, -- Brutal Gladiator's Greatsword
                {5, 34997}, -- Brutal Gladiator's Decapitator
                {6, 30902}, -- Cataclysm's Edge
                {7, 35064}, -- Brutal Gladiator's Painsaw
                {8, 34891}, -- The Blade of Harbingers
                {9, 33663}, -- Vengeful Gladiator's Bonegrinder
                {10, 33688}, -- Vengeful Gladiator's Greatsword
                {11, 33670}, -- Vengeful Gladiator's Decapitator
                {12, 32348}, -- Soul Cleaver
                {13, 33727}, -- Vengeful Gladiator's Painsaw
                {14, 29993}, -- Twinblade of the Phoenix
                {15, 32332} -- Torch of the Damned
            }
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {
                {1, 34334}, -- Thori'dal, the Stars' Fury
                {2, 34196}, -- Golden Bow of Quel'Thalas
                {3, 34892}, -- Crossbow of Relentless Strikes
                {4, 33474}, -- Ancient Amani Longbow
                {5, 34349}, -- Blade of Life's Inevitability
                {6, 35108}, -- Brutal Gladiator's War Edge
                {7, 30105}, -- Serpent Spine Longbow
                {8, 30724}, -- Barrel-Blade Longrifle
                {9, 32326}, -- Twisted Blades of Zarak
                {10, 33765}, -- Vengeful Gladiator's War Edge
                {11, 28772}, -- Sunfury Bow of the Phoenix
                {12, 32054}, -- Merciless Gladiator's War Edge
                {13, 33491}, -- Tuskbreaker
                {14, 30279}, -- Mama's Insurance
                {15, 34603} -- Distracting Blades
            }
        }
    }
}
