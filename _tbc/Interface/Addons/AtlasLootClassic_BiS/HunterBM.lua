local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["HunterBM"] = {
    name = AL["Hunter BM BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34333}, -- Coif of Alleria
                {2, 34244}, -- Duplicitous Guise
                {3, 32235}, -- Cursed Vision of Sargeras
                {4, 34356}, -- Surestrike Goggles v3.0
                {5, 34992}, -- Brutal Gladiator's Chain Helm
                {6, 32376}, -- Forest Prowler's Helm
                {7, 33666}, -- Vengeful Gladiator's Chain Helm
                {8, 31003}, -- Gronnstalker's Helmet
                {9, 32474}, -- Surestrike Goggles v2.0
                {10, 33479}, -- Grimgrin Faceguard
                {11, 30141}, -- Rift Stalker Helm
                {12, 31962}, -- Merciless Gladiator's Chain Helm
                {13, 33432}, -- Coif of the Jungle Stalker
                {14, 32087}, -- Mask of the Deceiver
                {15, 28182} -- Helm of the Claw
                ,
                {16, 32409},
                {17, 29192}
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34358}, -- Hard Khorium Choker
                {2, 34177}, -- Clutch of Demise
                {3, 32260}, -- Choker of Endless Nightmares
                {4, 30017}, -- Telonicus's Pendant of Mayhem
                {5, 32591}, -- Choker of Serrated Blades
                {6, 35292}, -- Sin'dorei Pendant of Triumph
                {7, 24114}, -- Braided Eternium Chain (GROUP BUFF)
                {8, 35135}, -- Guardian's Pendant of Triumph
                {9, 29381}, -- Choker of Vile Intent
                {10, 35507}, -- Amulet of Bitter Hatred
                {11, 28509}, -- Worgen Claw Necklace
                {12, 34679}, -- Shattered Sun Pendant of Might
                {13, 30059}, -- Choker of Animalistic Fury
                {14, 33923}, -- Vindicator's Pendant of Triumph
                {15, 27779} -- Bone Chain Necklace
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34194}, -- Mantle of the Golden Forest
                {2, 34195}, -- Shoulderpads of Vehemence
                {3, 31006}, -- Gronnstalker's Spaulders
                {4, 32581}, -- Swiftstrike Shoulders
                {5, 32264}, -- Shoulders of the Hidden Predator
                {6, 32575}, -- Shoulders of Lightning Reflexes
                {7, 32377}, -- Mantle of Darkness
                {8, 34994}, -- Brutal Gladiator's Chain Spaulders
                {9, 33206}, -- Pauldrons of Primal Fury
                {10, 30917}, -- Razorfury Mantle
                {11, 34613}, -- Shoulderpads of the Silvermoon Retainer
                {12, 30055}, -- Shoulderpads of the Stranger
                {13, 30085}, -- Mantle of the Tireless Tracker
                {14, 33300}, -- Shoulderpads of Dancing Blades
                {15, 30892} -- Beast-tamer's Shoulders
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
                {3, 33590}, -- Cloak of Fiends
                {4, 29994}, -- Thalassian Wildercloak
                {5, 33484}, -- Dory's Embrace
                {6, 28672}, -- Drape of the Dark Reavers
                {7, 30729}, -- Black-Iron Battlecloak
                {8, 24259}, -- Vengeance Wrap
                {9, 29382}, -- Blood Knight War Cloak
                {10, 35495}, -- The Frost Lord's War Cloak
                {11, 28777}, -- Cloak of the Pit Stalker
                {12, 27878}, -- Auchenai Death Shroud
                {13, 31255}, -- Cloak of the Craft
                {14, 32540}, -- Terokk's Might
                {15, 34708} -- Cloak of the Coming Night
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
                {3, 30905}, -- Midnight Chestguard
                {4, 34927}, -- Tunic of the Dark Hour
                {5, 32252}, -- Nether Shadow Tunic
                {6, 30907}, -- Mail of Fevered Pursuit
                {7, 34912}, -- Scaled Drakeskin Chestguard
                {8, 34990}, -- Brutal Gladiator's Chain Armor
                {9, 33329}, -- Shadowtooth Trollskin Cuirass
                {10, 31004}, -- Gronnstalker's Chestguard
                {11, 32334}, -- Vest of Mounting Assault
                {12, 30139}, -- Rift Stalker Hauberk
                {13, 30101}, -- Bloodsea Brigand's Vest
                {14, 30054}, -- Ranger-General's Chestguard
                {15, 33664} -- Vengeful Gladiator's Chain Armor
                ,
                {16, 35429}
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34443}, -- Gronnstalker's Bracers
                {2, 32324}, -- Insidious Bands
                {3, 32574}, -- Bindings of Lightning Reflexes
                {4, 32580}, -- Swiftstrike Bracers
                {5, 30863}, -- Deadly Cuffs
                {6, 33540}, -- Master Assassin Wristwraps
                {7, 32251}, -- Wraps of Precise Flight
                {8, 35166}, -- Guardian's Chain Bracers
                {9, 33529}, -- Steadying Bracers
                {10, 29966}, -- Vambraces of Ending
                {11, 30864}, -- Bracers of the Pathfinder
                {12, 30026}, -- Bands of the Celestial Archer
                {13, 33876}, -- Vindicator's Chain Bracers
                {14, 30091}, -- True-Aim Stalker Bands
                {15, 34698} -- Bracers of the Forest Stalker
                ,
                {16, 187737}
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
                {5, 31001}, -- Gronnstalker's Gloves
                {6, 32347}, -- Grips of Damnation
                {7, 32234}, -- Fists of Mukoa
                {8, 34916}, -- Gauntlets of Rapidity
                {9, 33539}, -- Trickster's Stickyfingers
                {10, 30140}, -- Rift Stalker Gauntlets
                {11, 34991}, -- Brutal Gladiator's Chain Gauntlets
                {12, 33528}, -- Gauntlets of Sniping
                {13, 28506}, -- Gloves of Dexterous Manipulation
                {14, 28776}, -- Liar's Tongue Gloves
                {15, 34408} -- Gloves of the Forest Drifter
                ,
                {16, 20731}
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34549}, -- Gronnstalker's Belt
                {2, 32346}, -- Boneweave Girdle
                {3, 34929}, -- Belt of the Silent Path
                {4, 30879}, -- Don Alejandro's Money Belt
                {5, 32265}, -- Shadow-walker's Cord
                {6, 30919}, -- Valestalker Girdle
                {7, 30040}, -- Belt of Deep Shadow
                {8, 33211}, -- Bladeangel's Money Belt
                {9, 30106}, -- Belt of One-Hundred Deaths
                {10, 30046}, -- Belt of the Black Eagle
                {11, 35151}, -- Guardian's Chain Girdle
                {12, 29247}, -- Girdle of the Deathdealer
                {13, 28828}, -- Gronn-Stitched Girdle
                {14, 25789}, -- Rune-Engraved Belt
                {15, 33280} -- War-Feathered Loop
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34361}, -- Hard Khorium Band
                {2, 34189}, -- Band of Ruinous Delight
                {3, 34887}, -- Angelista's Revenge
                {4, 33496}, -- Signet of Primal Wrath
                {5, 32497}, -- Stormrage Signet Ring
                {6, 29301}, -- Band of the Eternal Champion
                {7, 32266}, -- Ring of Deceitful Intent
                {8, 30052}, -- Ring of Lethality
                {9, 29997}, -- Band of the Ranger-General
                {10, 29300}, -- Band of Eternity (revered)
                {11, 32526}, -- Band of Devastation
                {12, 35131}, -- Guardian's Band of Triumph
                {13, 30738}, -- Ring of Reciprocity
                {14, 29299}, -- Band of Eternity (honored)
                {15, 28757} -- Ring of a Thousand Marks
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34188}, -- Leggings of the Immortal Night
                {2, 34168}, -- Starstalker Legguards
                {3, 30900}, -- Bow-stitched Leggings
                {4, 30898}, -- Shady Dealer's Pantaloons
                {5, 29995}, -- Leggings of Murderous Intent
                {6, 34993}, -- Brutal Gladiator's Chain Leggings
                {7, 33538}, -- Shallow-grave Trousers
                {8, 31005}, -- Gronnstalker's Leggings
                {9, 30739}, -- Scaled Greaves of the Marksman
                {10, 28741}, -- Skulker's Greaves
                {11, 30142}, -- Rift Stalker Leggings
                {12, 33527}, -- Shifting Camouflage Pants
                {13, 33667}, -- Vengeful Gladiator's Chain Leggings
                {14, 29985}, -- Void Reaver Greaves
                {15, 34385} -- Leggings of the Immortal Beast
                ,
                {16, 29535}
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34570}, -- Gronnstalker's Boots
                {2, 32510}, -- Softstep Boots of Tracking
                {3, 32366}, -- Shadowmaster's Boots
                {4, 33222}, -- Nyn'jah's Tabi Boots
                {5, 34809}, -- Sunrage Treads
                {6, 30880}, -- Quickstrider Moccasins
                {7, 29951}, -- Star-Strider Boots
                {8, 30104}, -- Cobra-Lash Boots
                {9, 35136}, -- Guardian's Chain Sabatons
                {10, 28545}, -- Edgewalker Longboots
                {11, 33805}, -- Shadowhunter's Treads
                {12, 30039}, -- Boots of Utter Darkness
                {13, 30891}, -- Black Featherlight Boots
                {14, 30045}, -- Boots of the Crimson Hawk
                {15, 30060} -- Boots of Effortless Striking
                ,
                {16, 28279}
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 28830}, -- Dragonspine Trophy
                {2, 34427}, -- Blackened Naaru Sliver
                {3, 32505}, -- Madness of the Betrayer
                {4, 23206}, -- Mark of the Champion (undead/demon)
                {5, 33831}, -- Berserker's Call
                {6, 30627}, -- Tsunami Talisman
                {7, 35702}, -- Figurine - Shadowsong Panther
                {8, 31856}, -- Darkmoon Card: Crusade
                {9, 29383}, -- Bloodlust Brooch
                {10, 23041}, -- Slayer's Crest
                {11, 28034}, -- Hourglass of the Unraveller
                {12, 28288}, -- Abacus of Violent Odds
                {13, 34472}, -- Shard of Contempt
                {14, 30448}, -- Talon of Al'ar
                {15, 19406} -- Drake Fang Talisman
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34197}, -- Shiv of Exsanguination
                {2, 34329}, -- Crux of the Apocalypse
                {3, 34331}, -- Hand of the Deceiver
                {4, 34165}, -- Fang of Kalecgos
                {5, 34203}, -- Grip of Mannoroth
                {6, 34893}, -- Vanir's Right Fist of Brutality
                {7, 33389}, -- Dagger of Bad Mojo
                {8, 34346}, -- Mounting Vengeance
                {9, 30881}, -- Blade of Infamy
                {10, 34950}, -- Vanir's Left Fist of Savagery
                {11, 34951}, -- Vanir's Left Fist of Brutality
                {12, 30865}, -- Tracker's Blade
                {13, 32944}, -- Talon of the Phoenix
                {14, 30082}, -- Talon of Azshara
                {15, 32369} -- Blade of Savagery
                ,
                {16, 35453}
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
            [NORMAL_DIFF] = {
                {1, 34183}, -- Shivering Felspine
                {2, 34247}, -- Apolyon, the Soul-Render
                {3, 34891}, -- The Blade of Harbingers
                {4, 32248}, -- Halberd of Desolation
                {5, 34997}, -- Brutal Gladiator's Decapitator
                {6, 33670}, -- Vengeful Gladiator's Decapitator
                {7, 34014}, -- Vengeful Gladiator's Waraxe
                {8, 29993}, -- Twinblade of the Phoenix
                {9, 30789}, -- Illidari-Bane Claymore (Demon)
                {10, 33492}, -- Trollbane
                {11, 28436}, -- Bloodmoon
                {12, 33478}, -- Jin'rohk, The Great Apocalypse
                {13, 28435}, -- Mooncleaver
                {14, 35064}, -- Brutal Gladiator's Painsaw
                {15, 31966} -- Merciless Gladiator's Decapitator
                ,
                {16, 22556}
            }
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {
                {1, 34334}, -- Thori'dal, the Stars' Fury
                {2, 34196}, -- Golden Bow of Quel'Thalas
                {3, 35018}, -- Brutal Gladiator's Heavy Crossbow (Ranged AP)
                {4, 35047}, -- Brutal Gladiator's Longbow (Ranged AP)
                {5, 35075}, -- Brutal Gladiator's Rifle (Ranged AP)
                {6, 34892}, -- Crossbow of Relentless Strikes
                {7, 33006}, -- Vengeful Gladiator's Heavy Crossbow (Ranged AP)
                {8, 34529}, -- Vengeful Gladiator's Longbow (Ranged AP)
                {9, 34530}, -- Vengeful Gladiator's Rifle (Ranged AP)
                {10, 30906}, -- Bristleblitz Striker
                {11, 32336}, -- Black Bow of the Betrayer
                {12, 30105}, -- Serpent Spine Longbow
                {13, 29949}, -- Arcanite Steam-Pistol
                {14, 32253}, -- Legionkiller
                {15, 33474} -- Ancient Amani Longbow
                ,
                {16, 23766}
            }
        }

        --@end-version-bcc@
    }
}
