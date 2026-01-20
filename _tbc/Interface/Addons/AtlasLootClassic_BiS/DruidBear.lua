local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["DruidBear"] = {
    name = AL["Druid Bear BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34244}, -- Duplicitous Guise
                {2, 34404}, -- Mask of the Fury Hunter
                {3, 34999}, -- Brutal Gladiator's Dragonhide Helm
                {4, 34353}, -- Quad Deathblow X44 Goggles
                {5, 31039}, -- Thunderheart Cover
                {6, 32235}, -- Cursed Vision of Sargeras
                {7, 33672}, -- Vengeful Gladiator's Dragonhide Helm
                {8, 30228}, -- Nordrassil Headdress
                {9, 33479}, -- Grimgrin Faceguard
                {10, 29098}, -- Stag-Helm of Malorne
                {11, 32478}, -- Deathblow X11 Goggles
                {12, 31968}, -- Merciless Gladiator's Dragonhide Helm
                {13, 32087}, -- Mask of the Deceiver
                {14, 28127}, -- Gladiator's Dragonhide Helm
                {15, 32088} -- Cowl of Beastly Rage
                ,
                {16, 32409},
                {17, 29192},
                {18, 29193},
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34178}, -- Collar of the Pit Lord
                {2, 33296}, -- Brooch of Deftness
                {3, 34358}, -- Hard Khorium Choker
                {4, 34177}, -- Clutch of Demise
                {5, 34680}, -- Shattered Sun Pendant of Resolve
                {6, 35135}, -- Guardian's Pendant of Triumph
                {7, 30017}, -- Telonicus's Pendant of Mayhem
                {8, 32591}, -- Choker of Serrated Blades
                {9, 28509}, -- Worgen Claw Necklace
                {10, 32362}, -- Pendant of Titans
                {11, 33923}, -- Vindicator's Pendant of Triumph
                {12, 29381}, -- Choker of Vile Intent
                {13, 35507}, -- Amulet of Bitter Hatred
                {14, 28674}, -- Saberclaw Talisman
                {15, 28745} -- Mithril Chain of Heroism
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34392}, -- Demontooth Shoulderpads
                {2, 35001}, -- Brutal Gladiator's Dragonhide Spaulders
                {3, 34195}, -- Shoulderpads of Vehemence
                {4, 31048}, -- Thunderheart Pauldrons
                {5, 33674}, -- Vengeful Gladiator's Dragonhide Spaulders
                {6, 30230}, -- Nordrassil Feral-Mantle
                {7, 30917}, -- Razorfury Mantle
                {8, 30055}, -- Shoulderpads of the Stranger
                {9, 29100}, -- Mantle of Malorne
                {10, 31971}, -- Merciless Gladiator's Dragonhide Spaulders
                {11, 32581}, -- Swiftstrike Shoulders
                {12, 33300}, -- Shoulderpads of Dancing Blades
                {13, 34613}, -- Shoulderpads of the Silvermoon Retainer
                {14, 32377}, -- Mantle of Darkness
                {15, 28129} -- Gladiator's Dragonhide Spaulders
                ,
                {16, 23548},
                {17, 23549},
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34190}, -- Crimson Paragon's Cover
                {2, 34241}, -- Cloak of Unforgivable Sin
                {3, 33593}, -- Slikk's Cloak of Placation
                {4, 29994}, -- Thalassian Wildercloak
                {5, 34010}, -- Pepe's Shroud of Pacification
                {6, 28660}, -- Gilded Thorium Cloak
                {7, 28256}, -- Thoriumweave Cloak
                {8, 32323}, -- Shadowmoon Destroyer's Drape
                {9, 28672}, -- Drape of the Dark Reavers
                {10, 34810}, -- Cloak of Blade Turning
                {11, 30098}, -- Razor-Scale Battlecloak
                {12, 33590}, -- Cloak of Fiends
                {13, 33484}, -- Dory's Embrace
                {14, 24258}, -- Resolute Cape
                {15, 33122} -- Cloak of Darkness (melee)
                ,
                {16, 35432},
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34211}, -- Harness of Carnal Instinct
                {2, 34369}, -- Carapace of Sun and Shadow
                {3, 31042}, -- Thunderheart Chestguard
                {4, 34397}, -- Bladed Chaos Tunic
                {5, 35002}, -- Brutal Gladiator's Dragonhide Tunic
                {6, 34906}, -- Embrace of Everlasting Prowess
                {7, 30222}, -- Nordrassil Chestplate
                {8, 30905}, -- Midnight Chestguard
                {9, 32252}, -- Nether Shadow Tunic
                {10, 33675}, -- Vengeful Gladiator's Dragonhide Tunic
                {11, 34927}, -- Tunic of the Dark Hour
                {12, 33579}, -- Vestments of Hibernation
                {13, 29096}, -- Breastplate of Malorne
                {14, 33329}, -- Shadowtooth Trollskin Cuirass
                {15, 31972} -- Merciless Gladiator's Dragonhide Tunic
                ,
                {16, 22547},
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34444}, -- Thunderheart Wristguards
                {2, 33580}, -- Band of the Swift Paw
                {3, 35171}, -- Guardian's Leather Bracers
                {4, 32324}, -- Insidious Bands
                {5, 33881}, -- Vindicator's Dragonhide Bracers
                {6, 35167}, -- Guardian's Dragonhide Bracers
                {7, 33893}, -- Vindicator's Leather Bracers
                {8, 32580}, -- Swiftstrike Bracers
                {9, 30863}, -- Deadly Cuffs
                {10, 29966}, -- Vambraces of Ending
                {11, 33540}, -- Master Assassin Wristwraps
                {12, 32810}, -- Veteran's Dragonhide Bracers
                {13, 32814}, -- Veteran's Leather Bracers
                {14, 29263}, -- Forestheart Bracers
                {15, 28445} -- General's Dragonhide Bracers
                ,
                {16, 22533},
                {17, 35426},
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34408}, -- Gloves of the Forest Drifter
                {2, 34370}, -- Gloves of Immortal Dusk
                {3, 31034}, -- Thunderheart Gauntlets
                {4, 34234}, -- Shadowed Gauntlets of Paroxysm
                {5, 34911}, -- Handwraps of the Aggressor
                {6, 34998}, -- Brutal Gladiator's Dragonhide Gloves
                {7, 30223}, -- Nordrassil Handgrips
                {8, 29947}, -- Gloves of the Searing Grip
                {9, 33671}, -- Vengeful Gladiator's Dragonhide Gloves
                {10, 32347}, -- Grips of Damnation
                {11, 29097}, -- Gauntlets of Malorne
                {12, 30644}, -- Grips of Deftness
                {13, 31967}, -- Merciless Gladiator's Dragonhide Gloves
                {14, 33539}, -- Trickster's Stickyfingers
                {15, 28506} -- Gloves of Dexterous Manipulation
                ,
                {16, 20726},
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34556}, -- Thunderheart Waistguard
                {2, 30106}, -- Belt of One-Hundred Deaths
                {3, 33583}, -- Waistguard of the Great Beast
                {4, 35152}, -- Guardian's Dragonhide Belt
                {5, 35156}, -- Guardian's Leather Belt
                {6, 34929}, -- Belt of the Silent Path
                {7, 30042}, -- Belt of Natural Power
                {8, 30879}, -- Don Alejandro's Money Belt
                {9, 33879}, -- Vindicator's Dragonhide Belt
                {10, 33891}, -- Vindicator's Leather Belt
                {11, 30040}, -- Belt of Deep Shadow
                {12, 32265}, -- Shadow-walker's Cord
                {13, 33211}, -- Bladeangel's Money Belt
                {14, 29264}, -- Tree-Mender's Belt
                {15, 32802} -- Veteran's Leather Belt
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34361}, -- Hard Khorium Band
                {2, 34213}, -- Ring of Hardened Resolve
                {3, 29301}, -- Band of the Eternal Champion
                {4, 32266}, -- Ring of Deceitful Intent
                {5, 29300}, -- Band of Eternity (revered)
                {6, 32497}, -- Stormrage Signet Ring
                {7, 33496}, -- Signet of Primal Wrath
                {8, 34887}, -- Angelista's Revenge
                {9, 29299}, -- Band of Eternity (honored)
                {10, 30834}, -- Shapeshifter's Signet
                {11, 34189}, -- Band of Ruinous Delight
                {12, 29298}, -- Band of Eternity (friendly)
                {13, 30052}, -- Ring of Lethality
                {14, 32526}, -- Band of Devastation
                {15, 28649} -- Garona's Signet Ring
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34385}, -- Leggings of the Immortal Beast
                {2, 31044}, -- Thunderheart Leggings
                {3, 34188}, -- Leggings of the Immortal Night
                {4, 34910}, -- Tameless Breeches
                {5, 30229}, -- Nordrassil Feral-Kilt
                {6, 35000}, -- Brutal Gladiator's Dragonhide Legguards
                {7, 30898}, -- Shady Dealer's Pantaloons
                {8, 33673}, -- Vengeful Gladiator's Dragonhide Legguards
                {9, 29099}, -- Greaves of Malorne
                {10, 34928}, -- Trousers of the Scryers' Retainer
                {11, 33538}, -- Shallow-grave Trousers
                {12, 28741}, -- Skulker's Greaves
                {13, 29995}, -- Leggings of Murderous Intent
                {14, 30535}, -- Forestwalker Kilt
                {15, 31969} -- Merciless Gladiator's Dragonhide Legguards
                ,
                {16, 29536},
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34573}, -- Thunderheart Treads
                {2, 32593}, -- Treads of the Den Mother
                {3, 35137}, -- Guardian's Dragonhide Boots
                {4, 35141}, -- Guardian's Leather Boots
                {5, 30041}, -- Boots of Natural Grace
                {6, 32366}, -- Shadowmaster's Boots
                {7, 33582}, -- Footwraps of Wild Encroachment
                {8, 33880}, -- Vindicator's Dragonhide Boots
                {9, 33222}, -- Nyn'jah's Tabi Boots
                {10, 33892}, -- Vindicator's Leather Boots
                {11, 30060}, -- Boots of Effortless Striking
                {12, 30674}, -- Zierhut's Lost Treads
                {13, 30891}, -- Black Featherlight Boots
                {14, 28545}, -- Edgewalker Longboots
                {15, 32790} -- Veteran's Leather Boots
                ,
                {16, 28280},
                {17, 28279},
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 34472}, -- Shard of Contempt
                {2, 34428}, -- Steely Naaru Sliver
                {3, 32658}, -- Badge of Tenacity
                {4, 28830}, -- Dragonspine Trophy
                {5, 34427}, -- Blackened Naaru Sliver
                {6, 33830}, -- Ancient Aqir Artifact
                {7, 32505}, -- Madness of the Betrayer
                {8, 34473}, -- Commendation of Kael'thas
                {9, 30627}, -- Tsunami Talisman
                {10, 23206}, -- Mark of the Champion (undead/demon)
                {11, 33831}, -- Berserker's Call
                {12, 31858}, -- Darkmoon Card: Vengeance
                {13, 31859}, -- Darkmoon Card: Madness
                {14, 35700}, -- Figurine - Crimson Serpent
                {15, 35702} -- Figurine - Shadowsong Panther
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
                {5, 30883}, -- Pillar of Ferocity (Feral)
                {6, 33465}, -- Staff of Primal Fury (Feral)
                {7, 32014}, -- Merciless Gladiator's Maul (Feral)
                {8, 30021}, -- Wildfury Greatstaff (Feral)
                {9, 28658}, -- Terestian's Stranglestaff (Feral)
                {10, 28476}, -- Gladiator's Maul (Feral)
                {11, 29359}, -- Feral Staff of Lashing (Feral)
                {12, 29171}, -- Earthwarden
                {13, 34989}, -- Brutal Gladiator's Bonegrinder
                {14, 31334}, -- Staff of Natural Fury (Feral)
                {15, 33663} -- Vengeful Gladiator's Bonegrinder
                ,
                {16, 22556},
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
