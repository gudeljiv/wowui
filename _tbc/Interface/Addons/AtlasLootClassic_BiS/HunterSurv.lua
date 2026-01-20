local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["HunterSurv"] = {
    name = AL["Hunter Surv BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34333}, -- Coif of Alleria
                {2, 34244}, -- Duplicitous Guise
                {3, 32235}, -- Cursed Vision of Sargeras
                {4, 34992}, -- Brutal Gladiator's Chain Helm
                {5, 32376}, -- Forest Prowler's Helm
                {6, 31003}, -- Gronnstalker's Helmet
                {7, 33666}, -- Vengeful Gladiator's Chain Helm
                {8, 31962}, -- Merciless Gladiator's Chain Helm
                {9, 30141}, -- Rift Stalker Helm
                {10, 33479}, -- Grimgrin Faceguard
                {11, 34404}, -- Mask of the Fury Hunter
                {12, 28331}, -- Gladiator's Chain Helm
                {13, 33432}, -- Coif of the Jungle Stalker
                {14, 32087}, -- Mask of the Deceiver
                {15, 29081} -- Demon Stalker Greathelm
                ,
                {16, 32409},
                {17, 29192}
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34177}, -- Clutch of Demise
                {2, 30017}, -- Telonicus's Pendant of Mayhem
                {3, 34358}, -- Hard Khorium Choker
                {4, 32508}, -- Necklace of the Deep
                {5, 29381}, -- Choker of Vile Intent
                {6, 35507}, -- Amulet of Bitter Hatred
                {7, 28509}, -- Worgen Claw Necklace
                {8, 19377}, -- Prestor's Talisman of Connivery
                {9, 28343}, -- Jagged Bark Pendant
                {10, 25562}, -- Earthen Mark of Razing
                {11, 34679}, -- Shattered Sun Pendant of Might
                {12, 28674}, -- Saberclaw Talisman
                {13, 27779}, -- Bone Chain Necklace
                {14, 32260}, -- Choker of Endless Nightmares
                {15, 31147} -- Pendant of Cunning
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34194}, -- Mantle of the Golden Forest
                {2, 34195}, -- Shoulderpads of Vehemence
                {3, 34994}, -- Brutal Gladiator's Chain Spaulders
                {4, 31006}, -- Gronnstalker's Spaulders
                {5, 32264}, -- Shoulders of the Hidden Predator
                {6, 32581}, -- Swiftstrike Shoulders
                {7, 30055}, -- Shoulderpads of the Stranger
                {8, 32575}, -- Shoulders of Lightning Reflexes
                {9, 33668}, -- Vengeful Gladiator's Chain Spaulders
                {10, 33206}, -- Pauldrons of Primal Fury
                {11, 30892}, -- Beast-tamer's Shoulders
                {12, 34392}, -- Demontooth Shoulderpads
                {13, 34613}, -- Shoulderpads of the Silvermoon Retainer
                {14, 30143}, -- Rift Stalker Mantle
                {15, 31964} -- Merciless Gladiator's Chain Spaulders
                ,
                {16, 28888}
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34241}, -- Cloak of Unforgivable Sin
                {2, 29994}, -- Thalassian Wildercloak
                {3, 33590}, -- Cloak of Fiends
                {4, 28672}, -- Drape of the Dark Reavers
                {5, 31255}, -- Cloak of the Craft
                {6, 29382}, -- Blood Knight War Cloak
                {7, 35495}, -- The Frost Lord's War Cloak
                {8, 27519}, -- Cloak of Malice
                {9, 27878}, -- Auchenai Death Shroud
                {10, 32540}, -- Terokk's Might
                {11, 32323}, -- Shadowmoon Destroyer's Drape
                {12, 21710}, -- Cloak of the Fallen God
                {13, 27423}, -- Cloak of Impulsiveness
                {14, 32665}, -- Crystalweave Cape
                {15, 32539} -- Skyguard's Drape
                ,
                {16, 35432}
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34369}, -- Carapace of Sun and Shadow
                {2, 34397}, -- Bladed Chaos Tunic
                {3, 34373}, -- Embrace of the Phoenix
                {4, 32334}, -- Vest of Mounting Assault
                {5, 34927}, -- Tunic of the Dark Hour
                {6, 34912}, -- Scaled Drakeskin Chestguard
                {7, 30907}, -- Mail of Fevered Pursuit
                {8, 33329}, -- Shadowtooth Trollskin Cuirass
                {9, 34990}, -- Brutal Gladiator's Chain Armor
                {10, 31004}, -- Gronnstalker's Chestguard
                {11, 32252}, -- Nether Shadow Tunic
                {12, 34228}, -- Vicious Hawkstrider Hauberk
                {13, 30139}, -- Rift Stalker Hauberk
                {14, 30054}, -- Ranger-General's Chestguard
                {15, 34211} -- Harness of Carnal Instinct
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
                {5, 35166}, -- Guardian's Chain Bracers
                {6, 30864}, -- Bracers of the Pathfinder
                {7, 29966}, -- Vambraces of Ending
                {8, 33540}, -- Master Assassin Wristwraps
                {9, 32251}, -- Wraps of Precise Flight
                {10, 33529}, -- Steadying Bracers
                {11, 33876}, -- Vindicator's Chain Bracers
                {12, 29246}, -- Nightfall Wristguards
                {13, 30026}, -- Bands of the Celestial Archer
                {14, 32814}, -- Veteran's Leather Bracers
                {15, 32647} -- Shard-bound Bracers
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
                {4, 31001}, -- Gronnstalker's Gloves
                {5, 34374}, -- Fletcher's Gloves of the Phoenix
                {6, 34916}, -- Gauntlets of Rapidity
                {7, 32347}, -- Grips of Damnation
                {8, 32234}, -- Fists of Mukoa
                {9, 34991}, -- Brutal Gladiator's Chain Gauntlets
                {10, 33539}, -- Trickster's Stickyfingers
                {11, 30140}, -- Rift Stalker Gauntlets
                {12, 34408}, -- Gloves of the Forest Drifter
                {13, 28506}, -- Gloves of Dexterous Manipulation
                {14, 33665}, -- Vengeful Gladiator's Chain Gauntlets
                {15, 33528} -- Gauntlets of Sniping
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
                {3, 30879}, -- Don Alejandro's Money Belt
                {4, 34929}, -- Belt of the Silent Path
                {5, 32265}, -- Shadow-walker's Cord
                {6, 30919}, -- Valestalker Girdle
                {7, 30040}, -- Belt of Deep Shadow
                {8, 35151}, -- Guardian's Chain Girdle
                {9, 30106}, -- Belt of One-Hundred Deaths
                {10, 33211}, -- Bladeangel's Money Belt
                {11, 33877}, -- Vindicator's Chain Girdle
                {12, 29247}, -- Girdle of the Deathdealer
                {13, 33280}, -- War-Feathered Loop
                {14, 28750}, -- Girdle of Treachery
                {15, 33583} -- Waistguard of the Great Beast
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34361}, -- Hard Khorium Band
                {2, 34887}, -- Angelista's Revenge
                {3, 33496}, -- Signet of Primal Wrath
                {4, 29301}, -- Band of the Eternal Champion
                {5, 29300}, -- Band of Eternity (revered)
                {6, 30052}, -- Ring of Lethality
                {7, 29299}, -- Band of Eternity (honored)
                {8, 32266}, -- Ring of Deceitful Intent
                {9, 29298}, -- Band of Eternity (friendly)
                {10, 28791}, -- Ring of the Recalcitrant
                {11, 34189}, -- Band of Ruinous Delight
                {12, 28649}, -- Garona's Signet Ring
                {13, 31277}, -- Pathfinder's Band
                {14, 22961}, -- Band of Reanimation
                {15, 32942} -- Ring of the Overseer
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34188}, -- Leggings of the Immortal Night
                {2, 34168}, -- Starstalker Legguards
                {3, 30898}, -- Shady Dealer's Pantaloons
                {4, 30900}, -- Bow-stitched Leggings
                {5, 30739}, -- Scaled Greaves of the Marksman
                {6, 29995}, -- Leggings of Murderous Intent
                {7, 33538}, -- Shallow-grave Trousers
                {8, 34385}, -- Leggings of the Immortal Beast
                {9, 34993}, -- Brutal Gladiator's Chain Leggings
                {10, 31005}, -- Gronnstalker's Leggings
                {11, 30142}, -- Rift Stalker Leggings
                {12, 28741}, -- Skulker's Greaves
                {13, 29985}, -- Void Reaver Greaves
                {14, 33527}, -- Shifting Camouflage Pants
                {15, 33667} -- Vengeful Gladiator's Chain Leggings
                ,
                {16, 29535}
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34570}, -- Gronnstalker's Boots
                {2, 32366}, -- Shadowmaster's Boots
                {3, 33222}, -- Nyn'jah's Tabi Boots
                {4, 32510}, -- Softstep Boots of Tracking
                {5, 30104}, -- Cobra-Lash Boots
                {6, 34809}, -- Sunrage Treads
                {7, 30880}, -- Quickstrider Moccasins
                {8, 30060}, -- Boots of Effortless Striking
                {9, 35136}, -- Guardian's Chain Sabatons
                {10, 28545}, -- Edgewalker Longboots
                {11, 29951}, -- Star-Strider Boots
                {12, 28746}, -- Fiend Slayer Boots
                {13, 33878}, -- Vindicator's Chain Sabatons
                {14, 33805}, -- Shadowhunter's Treads
                {15, 30045} -- Boots of the Crimson Hawk
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
                {8, 32658}, -- Badge of Tenacity
                {9, 31856}, -- Darkmoon Card: Crusade
                {10, 29383}, -- Bloodlust Brooch
                {11, 28288}, -- Abacus of Violent Odds
                {12, 23041}, -- Slayer's Crest
                {13, 28034}, -- Hourglass of the Unraveller
                {14, 34472}, -- Shard of Contempt
                {15, 22954} -- Kiss of the Spider
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34197}, -- Shiv of Exsanguination
                {2, 34329}, -- Crux of the Apocalypse
                {3, 34165}, -- Fang of Kalecgos
                {4, 34893}, -- Vanir's Right Fist of Brutality
                {5, 30881}, -- Blade of Infamy
                {6, 33389}, -- Dagger of Bad Mojo
                {7, 29924}, -- Netherbane
                {8, 32269}, -- Messenger of Fate
                {9, 34331}, -- Hand of the Deceiver
                {10, 34616}, -- Breeching Comet
                {11, 29948}, -- Claw of the Phoenix
                {12, 30082}, -- Talon of Azshara
                {13, 33495}, -- Rage
                {14, 32946}, -- Claw of Molten Fury
                {15, 32945} -- Fist of Molten Fury
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
                {2, 32248}, -- Halberd of Desolation
                {3, 34247}, -- Apolyon, the Soul-Render
                {4, 33492}, -- Trollbane
                {5, 34891}, -- The Blade of Harbingers
                {6, 28587}, -- Legacy
                {7, 29329}, -- Terokk's Quill
                {8, 27903}, -- Sonic Spear
                {9, 29166}, -- Hellforged Halberd
                {10, 29167}, -- Blackened Spear
                {11, 34997}, -- Brutal Gladiator's Decapitator
                {12, 29993}, -- Twinblade of the Phoenix
                {13, 28429}, -- Lionheart Champion
                {14, 28430}, -- Lionheart Executioner
                {15, 33670} -- Vengeful Gladiator's Decapitator
                ,
                {16, 35396}
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
                {6, 32253}, -- Legionkiller
                {7, 29949}, -- Arcanite Steam-Pistol
                {8, 34892}, -- Crossbow of Relentless Strikes
                {9, 30724}, -- Barrel-Blade Longrifle
                {10, 30906}, -- Bristleblitz Striker
                {11, 33006}, -- Vengeful Gladiator's Heavy Crossbow (Ranged AP)
                {12, 34529}, -- Vengeful Gladiator's Longbow (Ranged AP)
                {13, 34530}, -- Vengeful Gladiator's Rifle (Ranged AP)
                {14, 28772}, -- Sunfury Bow of the Phoenix
                {15, 30105} -- Serpent Spine Longbow
                ,
                {16, 23766}
            }
        }

        --@end-version-bcc@
    }
}
