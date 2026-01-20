local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["ShamanEnh"] = {
    name = AL["Shaman Enh BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34244}, -- Duplicitous Guise
                {2, 34333}, -- Coif of Alleria
                {3, 32235}, -- Cursed Vision of Sargeras
                {4, 34356}, -- Surestrike Goggles v3.0
                {5, 35044}, -- Brutal Gladiator's Linked Helm
                {6, 32376}, -- Forest Prowler's Helm
                {7, 31015}, -- Skyshatter Cover
                {8, 34404}, -- Mask of the Fury Hunter
                {9, 30190}, -- Cataclysm Helm
                {10, 32474}, -- Surestrike Goggles v2.0
                {11, 33708}, -- Vengeful Gladiator's Linked Helm
                {12, 32087}, -- Mask of the Deceiver
                {13, 33479}, -- Grimgrin Faceguard
                {14, 32006}, -- Merciless Gladiator's Linked Helm
                {15, 28182} -- Helm of the Claw
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34358}, -- Hard Khorium Choker
                {2, 34177}, -- Clutch of Demise
                {3, 32260}, -- Choker of Endless Nightmares
                {4, 24114}, -- Braided Eternium Chain (GROUP BUFF)
                {5, 32591}, -- Choker of Serrated Blades
                {6, 35135}, -- Guardian's Pendant of Triumph
                {7, 35292}, -- Sin'dorei Pendant of Triumph
                {8, 30017}, -- Telonicus's Pendant of Mayhem
                {9, 30022}, -- Pendant of the Perilous
                {10, 29381}, -- Choker of Vile Intent
                {11, 35507}, -- Amulet of Bitter Hatred
                {12, 28509}, -- Worgen Claw Necklace
                {13, 30059}, -- Choker of Animalistic Fury
                {14, 33923}, -- Vindicator's Pendant of Triumph
                {15, 33296} -- Brooch of Deftness
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34195}, -- Shoulderpads of Vehemence
                {2, 34194}, -- Mantle of the Golden Forest
                {3, 34392}, -- Demontooth Shoulderpads
                {4, 32581}, -- Swiftstrike Shoulders
                {5, 32575}, -- Shoulders of Lightning Reflexes
                {6, 32377}, -- Mantle of Darkness
                {7, 30055}, -- Shoulderpads of the Stranger
                {8, 32264}, -- Shoulders of the Hidden Predator
                {9, 33206}, -- Pauldrons of Primal Fury
                {10, 31024}, -- Skyshatter Pauldrons
                {11, 34613}, -- Shoulderpads of the Silvermoon Retainer
                {12, 30917}, -- Razorfury Mantle
                {13, 30085}, -- Mantle of the Tireless Tracker
                {14, 35046}, -- Brutal Gladiator's Linked Spaulders
                {15, 33300} -- Shoulderpads of Dancing Blades
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34241}, -- Cloak of Unforgivable Sin
                {2, 32323}, -- Shadowmoon Destroyer's Drape
                {3, 33590}, -- Cloak of Fiends
                {4, 29994}, -- Thalassian Wildercloak
                {5, 30098}, -- Razor-Scale Battlecloak
                {6, 33484}, -- Dory's Embrace
                {7, 30729}, -- Black-Iron Battlecloak
                {8, 24259}, -- Vengeance Wrap
                {9, 33122}, -- Cloak of Darkness (melee)
                {10, 28672}, -- Drape of the Dark Reavers
                {11, 28777}, -- Cloak of the Pit Stalker
                {12, 34708}, -- Cloak of the Coming Night
                {13, 27878}, -- Auchenai Death Shroud
                {14, 28529}, -- Royal Cloak of Arathi Kings
                {15, 27892} -- Cloak of the Inciter
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34369}, -- Carapace of Sun and Shadow
                {2, 34397}, -- Bladed Chaos Tunic
                {3, 34211}, -- Harness of Carnal Instinct
                {4, 30905}, -- Midnight Chestguard
                {5, 34927}, -- Tunic of the Dark Hour
                {6, 32252}, -- Nether Shadow Tunic
                {7, 34912}, -- Scaled Drakeskin Chestguard
                {8, 30101}, -- Bloodsea Brigand's Vest
                {9, 35042}, -- Brutal Gladiator's Linked Armor
                {10, 30907}, -- Mail of Fevered Pursuit
                {11, 30730}, -- Terrorweave Tunic
                {12, 34906}, -- Embrace of Everlasting Prowess
                {13, 30185}, -- Cataclysm Chestplate
                {14, 33329}, -- Shadowtooth Trollskin Cuirass
                {15, 31018} -- Skyshatter Tunic
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34439}, -- Skyshatter Wristguards
                {2, 32574}, -- Bindings of Lightning Reflexes
                {3, 30863}, -- Deadly Cuffs
                {4, 32324}, -- Insidious Bands
                {5, 32580}, -- Swiftstrike Bracers
                {6, 33540}, -- Master Assassin Wristwraps
                {7, 32251}, -- Wraps of Precise Flight
                {8, 35172}, -- Guardian's Linked Bracers
                {9, 33529}, -- Steadying Bracers
                {10, 35166}, -- Guardian's Chain Bracers
                {11, 33894}, -- Vindicator's Linked Bracers
                {12, 30091}, -- True-Aim Stalker Bands
                {13, 30026}, -- Bands of the Celestial Archer
                {14, 30685}, -- Ravager's Wrist-Wraps of the Tiger
                {15, 29966} -- Vambraces of Ending
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34343}, -- Thalassian Ranger Gauntlets
                {2, 34370}, -- Gloves of Immortal Dusk
                {3, 34234}, -- Shadowed Gauntlets of Paroxysm
                {4, 34374}, -- Fletcher's Gloves of the Phoenix
                {5, 34408}, -- Gloves of the Forest Drifter
                {6, 32347}, -- Grips of Damnation
                {7, 32234}, -- Fists of Mukoa
                {8, 34916}, -- Gauntlets of Rapidity
                {9, 29947}, -- Gloves of the Searing Grip
                {10, 33539}, -- Trickster's Stickyfingers
                {11, 34911}, -- Handwraps of the Aggressor
                {12, 31011}, -- Skyshatter Grips
                {13, 30189}, -- Cataclysm Gauntlets
                {14, 33528}, -- Gauntlets of Sniping
                {15, 30644} -- Grips of Deftness
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34545}, -- Skyshatter Girdle
                {2, 30106}, -- Belt of One-Hundred Deaths
                {3, 32346}, -- Boneweave Girdle
                {4, 32265}, -- Shadow-walker's Cord
                {5, 30919}, -- Valestalker Girdle
                {6, 34929}, -- Belt of the Silent Path
                {7, 30879}, -- Don Alejandro's Money Belt
                {8, 30040}, -- Belt of Deep Shadow
                {9, 33583}, -- Waistguard of the Great Beast
                {10, 33211}, -- Bladeangel's Money Belt
                {11, 30046}, -- Belt of the Black Eagle
                {12, 35157}, -- Guardian's Linked Girdle
                {13, 28828}, -- Gronn-Stitched Girdle
                {14, 30676}, -- Lurker's Grasp of the Tiger
                {15, 35151} -- Guardian's Chain Girdle
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
                {6, 29301}, -- Band of the Eternal Champion
                {7, 29997}, -- Band of the Ranger-General
                {8, 32335}, -- Unstoppable Aggressor's Ring
                {9, 32526}, -- Band of Devastation
                {10, 32266}, -- Ring of Deceitful Intent
                {11, 30052}, -- Ring of Lethality
                {12, 30738}, -- Ring of Reciprocity
                {13, 35131}, -- Guardian's Band of Triumph
                {14, 28757}, -- Ring of a Thousand Marks
                {15, 29300} -- Band of Eternity (revered)
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34188}, -- Leggings of the Immortal Night
                {2, 34168}, -- Starstalker Legguards
                {3, 34385}, -- Leggings of the Immortal Beast
                {4, 30900}, -- Bow-stitched Leggings
                {5, 30898}, -- Shady Dealer's Pantaloons
                {6, 34910}, -- Tameless Breeches
                {7, 33538}, -- Shallow-grave Trousers
                {8, 29995}, -- Leggings of Murderous Intent
                {9, 35045}, -- Brutal Gladiator's Linked Leggings
                {10, 30739}, -- Scaled Greaves of the Marksman
                {11, 31021}, -- Skyshatter Pants
                {12, 28741}, -- Skulker's Greaves
                {13, 30192}, -- Cataclysm Legplates
                {14, 31544}, -- Clefthoof Hide Leggings
                {15, 33527} -- Shifting Camouflage Pants
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34567}, -- Skyshatter Greaves
                {2, 32510}, -- Softstep Boots of Tracking
                {3, 32366}, -- Shadowmaster's Boots
                {4, 33222}, -- Nyn'jah's Tabi Boots
                {5, 30880}, -- Quickstrider Moccasins
                {6, 30891}, -- Black Featherlight Boots
                {7, 30039}, -- Boots of Utter Darkness
                {8, 34809}, -- Sunrage Treads
                {9, 30104}, -- Cobra-Lash Boots
                {10, 35142}, -- Guardian's Linked Sabatons
                {11, 28545}, -- Edgewalker Longboots
                {12, 33582}, -- Footwraps of Wild Encroachment
                {13, 29951}, -- Star-Strider Boots
                {14, 25686}, -- Fel Leather Boots
                {15, 30041} -- Boots of Natural Grace
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 28830}, -- Dragonspine Trophy
                {2, 34427}, -- Blackened Naaru Sliver
                {3, 34472}, -- Shard of Contempt
                {4, 32505}, -- Madness of the Betrayer
                {5, 31856}, -- Darkmoon Card: Crusade
                {6, 34428}, -- Steely Naaru Sliver
                {7, 23206}, -- Mark of the Champion (undead/demon)
                {8, 33831}, -- Berserker's Call
                {9, 32491}, -- Ashtongue Talisman of Vision
                {10, 30627}, -- Tsunami Talisman
                {11, 35702}, -- Figurine - Shadowsong Panther
                {12, 29383}, -- Bloodlust Brooch
                {13, 23041}, -- Slayer's Crest
                {14, 28288}, -- Abacus of Violent Odds
                {15, 28034} -- Hourglass of the Unraveller
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34331}, -- Hand of the Deceiver
                {2, 34203}, -- Grip of Mannoroth
                {3, 34346}, -- Mounting Vengeance
                {4, 34988}, -- Brutal Gladiator's Bonecracker
                {5, 35017}, -- Brutal Gladiator's Hacker
                {6, 35038}, -- Brutal Gladiator's Left Ripper
                {7, 35076}, -- Brutal Gladiator's Right Ripper
                {8, 34995}, -- Brutal Gladiator's Chopper
                {9, 35037}, -- Brutal Gladiator's Left Render
                {10, 34996}, -- Brutal Gladiator's Cleaver
                {11, 35071}, -- Brutal Gladiator's Pummeler
                {12, 34950}, -- Vanir's Left Fist of Savagery
                {13, 34951}, -- Vanir's Left Fist of Brutality
                {14, 34893}, -- Vanir's Right Fist of Brutality
                {15, 32943} -- Swiftsteel Bludgeon
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {}
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {}
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {}
        }

        --@end-version-bcc@
    }
}
