local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["DruidFeral"] = {
    name = AL["Druid Feral BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34244}, -- Duplicitous Guise
                {2, 32235}, -- Cursed Vision of Sargeras
                {3, 34353}, -- Quad Deathblow X44 Goggles
                {4, 34999}, -- Brutal Gladiator's Dragonhide Helm
                {5, 33479}, -- Grimgrin Faceguard
                {6, 33672}, -- Vengeful Gladiator's Dragonhide Helm
                {7, 34404}, -- Mask of the Fury Hunter
                {8, 32478}, -- Deathblow X11 Goggles
                {9, 28732}, -- Cowl of Defiance
                {10, 31039}, -- Thunderheart Cover
                {11, 31109}, -- Stealther's Helmet of Second Sight
                {12, 28796}, -- Malefic Mask of the Shadows
                {13, 32087}, -- Mask of the Deceiver
                {14, 29502}, -- Cobrascale Hood
                {15, 30228} -- Nordrassil Headdress
                ,
                {16, 29192}
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 32260}, -- Choker of Endless Nightmares
                {2, 34358}, -- Hard Khorium Choker
                {3, 34177}, -- Clutch of Demise
                {4, 24114}, -- Braided Eternium Chain (GROUP BUFF)
                {5, 29381}, -- Choker of Vile Intent
                {6, 35507}, -- Amulet of Bitter Hatred
                {7, 28509}, -- Worgen Claw Necklace
                {8, 30017}, -- Telonicus's Pendant of Mayhem
                {9, 35292}, -- Sin'dorei Pendant of Triumph
                {10, 35135}, -- Guardian's Pendant of Triumph
                {11, 32591}, -- Choker of Serrated Blades
                {12, 31275}, -- Necklace of Trophies
                {13, 29119}, -- Haramad's Bargain
                {14, 27779}, -- Bone Chain Necklace
                {15, 32508} -- Necklace of the Deep
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34392}, -- Demontooth Shoulderpads
                {2, 34195}, -- Shoulderpads of Vehemence
                {3, 35001}, -- Brutal Gladiator's Dragonhide Spaulders
                {4, 31048}, -- Thunderheart Pauldrons
                {5, 33674}, -- Vengeful Gladiator's Dragonhide Spaulders
                {6, 30055}, -- Shoulderpads of the Stranger
                {7, 30230}, -- Nordrassil Feral-Mantle
                {8, 34613}, -- Shoulderpads of the Silvermoon Retainer
                {9, 27797}, -- Wastewalker Shoulderpads
                {10, 32377}, -- Mantle of Darkness
                {11, 29100}, -- Mantle of Malorne
                {12, 33300}, -- Shoulderpads of Dancing Blades
                {13, 30917}, -- Razorfury Mantle
                {14, 32581}, -- Swiftstrike Shoulders
                {15, 28755} -- Bladed Shoulderpads of the Merciless
                ,
                {16, 28888}
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34241}, -- Cloak of Unforgivable Sin
                {2, 32323}, -- Shadowmoon Destroyer's Drape
                {3, 28672}, -- Drape of the Dark Reavers
                {4, 29994}, -- Thalassian Wildercloak
                {5, 30098}, -- Razor-Scale Battlecloak
                {6, 33590}, -- Cloak of Fiends
                {7, 31255}, -- Cloak of the Craft
                {8, 33484}, -- Dory's Embrace
                {9, 33122}, -- Cloak of Darkness (melee)
                {10, 27878}, -- Auchenai Death Shroud
                {11, 24259}, -- Vengeance Wrap
                {12, 30729}, -- Black-Iron Battlecloak
                {13, 29382}, -- Blood Knight War Cloak
                {14, 35495}, -- The Frost Lord's War Cloak
                {15, 27892} -- Cloak of the Inciter
                ,
                {16, 35432}
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34397}, -- Bladed Chaos Tunic
                {2, 34369}, -- Carapace of Sun and Shadow
                {3, 34211}, -- Harness of Carnal Instinct
                {4, 35002}, -- Brutal Gladiator's Dragonhide Tunic
                {5, 32252}, -- Nether Shadow Tunic
                {6, 30905}, -- Midnight Chestguard
                {7, 33675}, -- Vengeful Gladiator's Dragonhide Tunic
                {8, 34927}, -- Tunic of the Dark Hour
                {9, 30101}, -- Bloodsea Brigand's Vest
                {10, 31042}, -- Thunderheart Chestguard
                {11, 33329}, -- Shadowtooth Trollskin Cuirass
                {12, 33204}, -- Shadowprowler's Chestguard
                {13, 33579}, -- Vestments of Hibernation
                {14, 30730}, -- Terrorweave Tunic
                {15, 34906} -- Embrace of Everlasting Prowess
                ,
                {16, 35429}
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34444}, -- Thunderheart Wristguards
                {2, 32324}, -- Insidious Bands
                {3, 33881}, -- Vindicator's Dragonhide Bracers
                {4, 35171}, -- Guardian's Leather Bracers
                {5, 30863}, -- Deadly Cuffs
                {6, 33540}, -- Master Assassin Wristwraps
                {7, 35167}, -- Guardian's Dragonhide Bracers
                {8, 33893}, -- Vindicator's Leather Bracers
                {9, 29966}, -- Vambraces of Ending
                {10, 33580}, -- Band of the Swift Paw
                {11, 32580}, -- Swiftstrike Bracers
                {12, 30685}, -- Ravager's Wrist-Wraps of the Tiger
                {13, 32814}, -- Veteran's Leather Bracers
                {14, 32647}, -- Shard-bound Bracers
                {15, 28171} -- Spymistress's Wristguards
                ,
                {16, 187737}
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34370}, -- Gloves of Immortal Dusk
                {2, 34234}, -- Shadowed Gauntlets of Paroxysm
                {3, 34408}, -- Gloves of the Forest Drifter
                {4, 34998}, -- Brutal Gladiator's Dragonhide Gloves
                {5, 34911}, -- Handwraps of the Aggressor
                {6, 29947}, -- Gloves of the Searing Grip
                {7, 31034}, -- Thunderheart Gauntlets
                {8, 28506}, -- Gloves of Dexterous Manipulation
                {9, 32347}, -- Grips of Damnation
                {10, 25969}, -- Rapscallion's Touch
                {11, 25685}, -- Fel Leather Gloves
                {12, 33671}, -- Vengeful Gladiator's Dragonhide Gloves
                {13, 30644}, -- Grips of Deftness
                {14, 33539}, -- Trickster's Stickyfingers
                {15, 28776} -- Liar's Tongue Gloves
                ,
                {16, 33152}
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34556}, -- Thunderheart Waistguard
                {2, 30106}, -- Belt of One-Hundred Deaths
                {3, 30040}, -- Belt of Deep Shadow
                {4, 34929}, -- Belt of the Silent Path
                {5, 30879}, -- Don Alejandro's Money Belt
                {6, 33583}, -- Waistguard of the Great Beast
                {7, 33211}, -- Bladeangel's Money Belt
                {8, 35152}, -- Guardian's Dragonhide Belt
                {9, 35156}, -- Guardian's Leather Belt
                {10, 32265}, -- Shadow-walker's Cord
                {11, 33879}, -- Vindicator's Dragonhide Belt
                {12, 29247}, -- Girdle of the Deathdealer
                {13, 30676}, -- Lurker's Grasp of the Tiger
                {14, 30042}, -- Belt of Natural Power
                {15, 28828} -- Gronn-Stitched Girdle
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 32497}, -- Stormrage Signet Ring
                {2, 34887}, -- Angelista's Revenge
                {3, 34189}, -- Band of Ruinous Delight
                {4, 33496}, -- Signet of Primal Wrath
                {5, 34361}, -- Hard Khorium Band
                {6, 30052}, -- Ring of Lethality
                {7, 32266}, -- Ring of Deceitful Intent
                {8, 29301}, -- Band of the Eternal Champion
                {9, 29997}, -- Band of the Ranger-General
                {10, 28649}, -- Garona's Signet Ring
                {11, 29300}, -- Band of Eternity (revered)
                {12, 28757}, -- Ring of a Thousand Marks
                {13, 30738}, -- Ring of Reciprocity
                {14, 32335}, -- Unstoppable Aggressor's Ring
                {15, 30834} -- Shapeshifter's Signet
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34188}, -- Leggings of the Immortal Night
                {2, 34385}, -- Leggings of the Immortal Beast
                {3, 31044}, -- Thunderheart Leggings
                {4, 35000}, -- Brutal Gladiator's Dragonhide Legguards
                {5, 28741}, -- Skulker's Greaves
                {6, 30898}, -- Shady Dealer's Pantaloons
                {7, 34910}, -- Tameless Breeches
                {8, 29995}, -- Leggings of Murderous Intent
                {9, 30229}, -- Nordrassil Feral-Kilt
                {10, 33673}, -- Vengeful Gladiator's Dragonhide Legguards
                {11, 34928}, -- Trousers of the Scryers' Retainer
                {12, 27837}, -- Wastewalker Leggings
                {13, 25687}, -- Fel Leather Leggings
                {14, 33538}, -- Shallow-grave Trousers
                {15, 30538} -- Midnight Legguards
                ,
                {16, 29535}
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 33222}, -- Nyn'jah's Tabi Boots
                {2, 34573}, -- Thunderheart Treads
                {3, 32366}, -- Shadowmaster's Boots
                {4, 28545}, -- Edgewalker Longboots
                {5, 35137}, -- Guardian's Dragonhide Boots
                {6, 34809}, -- Sunrage Treads
                {7, 33582}, -- Footwraps of Wild Encroachment
                {8, 35141}, -- Guardian's Leather Boots
                {9, 25686}, -- Fel Leather Boots
                {10, 33880}, -- Vindicator's Dragonhide Boots
                {11, 30039}, -- Boots of Utter Darkness
                {12, 30681}, -- Glider's Boots of the Tiger
                {13, 30041}, -- Boots of Natural Grace
                {14, 30891}, -- Black Featherlight Boots
                {15, 30060} -- Boots of Effortless Striking
                ,
                {16, 28279}
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 34472}, -- Shard of Contempt
                {2, 32505}, -- Madness of the Betrayer
                {3, 28830}, -- Dragonspine Trophy
                {4, 34427}, -- Blackened Naaru Sliver
                {5, 30627}, -- Tsunami Talisman
                {6, 34428}, -- Steely Naaru Sliver
                {7, 23206}, -- Mark of the Champion (undead/demon)
                {8, 33831}, -- Berserker's Call
                {9, 28121}, -- Icon of Unyielding Courage
                {10, 35702}, -- Figurine - Shadowsong Panther
                {11, 28034}, -- Hourglass of the Unraveller
                {12, 19406}, -- Drake Fang Talisman
                {13, 31856}, -- Darkmoon Card: Crusade
                {14, 29383}, -- Bloodlust Brooch
                {15, 28579} -- Romulo's Poison Vial
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
                {1, 34198}, -- Stanchion of Primal Instinct (Feral)
                {2, 35103}, -- Brutal Gladiator's Staff (Feral)
                {3, 34898}, -- Staff of the Forest Lord (Feral)
                {4, 33716}, -- Vengeful Gladiator's Staff (Feral)
                {5, 33465}, -- Staff of Primal Fury (Feral)
                {6, 32014}, -- Merciless Gladiator's Maul (Feral)
                {7, 30883}, -- Pillar of Ferocity (Feral)
                {8, 28658}, -- Terestian's Stranglestaff (Feral)
                {9, 28476}, -- Gladiator's Maul (Feral)
                {10, 30021}, -- Wildfury Greatstaff (Feral)
                {11, 29359}, -- Feral Staff of Lashing (Feral)
                {12, 31334}, -- Staff of Natural Fury (Feral)
                {13, 29171}, -- Earthwarden
                {14, 27877}, -- Draenic Wildstaff (Feral)
                {15, 30010} -- Fleshling Simulation Staff (Feral)
                ,
                {16, 22556}
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
