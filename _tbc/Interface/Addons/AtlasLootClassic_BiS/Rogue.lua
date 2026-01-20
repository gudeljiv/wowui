local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["Rogue"] = {
    name = AL["Rogue BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34244}, -- Duplicitous Guise
                {2, 32235}, -- Cursed Vision of Sargeras
                {3, 34353}, -- Quad Deathblow X44 Goggles
                {4, 31027}, -- Slayer's Helm
                {5, 35033}, -- Brutal Gladiator's Leather Helm
                {6, 33701}, -- Vengeful Gladiator's Leather Helm
                {7, 32478}, -- Deathblow X11 Goggles
                {8, 30146}, -- Deathmantle Helm
                {9, 33479}, -- Grimgrin Faceguard
                {10, 29044}, -- Netherblade Facemask
                {11, 32087}, -- Mask of the Deceiver
                {12, 34404}, -- Mask of the Fury Hunter
                {13, 31999}, -- Merciless Gladiator's Leather Helm
                {14, 28182}, -- Helm of the Claw
                {15, 28224} -- Wastewalker Helm
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
                {5, 35292}, -- Sin'dorei Pendant of Triumph
                {6, 29381}, -- Choker of Vile Intent
                {7, 35507}, -- Amulet of Bitter Hatred
                {8, 30017}, -- Telonicus's Pendant of Mayhem
                {9, 32591}, -- Choker of Serrated Blades
                {10, 35135}, -- Guardian's Pendant of Triumph
                {11, 28509}, -- Worgen Claw Necklace
                {12, 33923}, -- Vindicator's Pendant of Triumph
                {13, 27779}, -- Bone Chain Necklace
                {14, 33296}, -- Brooch of Deftness
                {15, 33297} -- The Savage's Choker
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34195}, -- Shoulderpads of Vehemence
                {2, 31030}, -- Slayer's Shoulderpads
                {3, 35035}, -- Brutal Gladiator's Leather Spaulders
                {4, 32581}, -- Swiftstrike Shoulders
                {5, 30055}, -- Shoulderpads of the Stranger
                {6, 34392}, -- Demontooth Shoulderpads
                {7, 32377}, -- Mantle of Darkness
                {8, 33703}, -- Vengeful Gladiator's Leather Spaulders
                {9, 30149}, -- Deathmantle Shoulderpads
                {10, 34613}, -- Shoulderpads of the Silvermoon Retainer
                {11, 32001}, -- Merciless Gladiator's Leather Spaulders
                {12, 33300}, -- Shoulderpads of Dancing Blades
                {13, 30917}, -- Razorfury Mantle
                {14, 27797}, -- Wastewalker Shoulderpads
                {15, 29047} -- Netherblade Shoulderpads
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
                {5, 28672}, -- Drape of the Dark Reavers
                {6, 33484}, -- Dory's Embrace
                {7, 24259}, -- Vengeance Wrap
                {8, 30729}, -- Black-Iron Battlecloak
                {9, 27878}, -- Auchenai Death Shroud
                {10, 34708}, -- Cloak of the Coming Night
                {11, 31255}, -- Cloak of the Craft
                {12, 27892}, -- Cloak of the Inciter
                {13, 29382}, -- Blood Knight War Cloak
                {14, 35495}, -- The Frost Lord's War Cloak
                {15, 28777} -- Cloak of the Pit Stalker
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34369}, -- Carapace of Sun and Shadow
                {2, 34397}, -- Bladed Chaos Tunic
                {3, 31028}, -- Slayer's Chestguard
                {4, 30905}, -- Midnight Chestguard
                {5, 32252}, -- Nether Shadow Tunic
                {6, 35036}, -- Brutal Gladiator's Leather Tunic
                {7, 34927}, -- Tunic of the Dark Hour
                {8, 30101}, -- Bloodsea Brigand's Vest
                {9, 34211}, -- Harness of Carnal Instinct
                {10, 33704}, -- Vengeful Gladiator's Leather Tunic
                {11, 30144}, -- Deathmantle Chestguard
                {12, 30730}, -- Terrorweave Tunic
                {13, 33329}, -- Shadowtooth Trollskin Cuirass
                {14, 29045}, -- Netherblade Chestpiece
                {15, 28601} -- Chestguard of the Conniver
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34448}, -- Slayer's Bracers
                {2, 32324}, -- Insidious Bands
                {3, 30863}, -- Deadly Cuffs
                {4, 32580}, -- Swiftstrike Bracers
                {5, 35171}, -- Guardian's Leather Bracers
                {6, 33540}, -- Master Assassin Wristwraps
                {7, 33881}, -- Vindicator's Dragonhide Bracers
                {8, 29966}, -- Vambraces of Ending
                {9, 33893}, -- Vindicator's Leather Bracers
                {10, 32647}, -- Shard-bound Bracers
                {11, 35167}, -- Guardian's Dragonhide Bracers
                {12, 32814}, -- Veteran's Leather Bracers
                {13, 28171}, -- Spymistress's Wristguards
                {14, 29246}, -- Nightfall Wristguards
                {15, 29527} -- Primalstrike Bracers
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34370}, -- Gloves of Immortal Dusk
                {2, 34234}, -- Shadowed Gauntlets of Paroxysm
                {3, 31026}, -- Slayer's Handguards
                {4, 32347}, -- Grips of Damnation
                {5, 34408}, -- Gloves of the Forest Drifter
                {6, 30145}, -- Deathmantle Handguards
                {7, 33539}, -- Trickster's Stickyfingers
                {8, 29947}, -- Gloves of the Searing Grip
                {9, 35032}, -- Brutal Gladiator's Leather Gloves
                {10, 25685}, -- Fel Leather Gloves
                {11, 28506}, -- Gloves of Dexterous Manipulation
                {12, 28776}, -- Liar's Tongue Gloves
                {13, 34911}, -- Handwraps of the Aggressor
                {14, 30644}, -- Grips of Deftness
                {15, 29048} -- Netherblade Gloves
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34558}, -- Slayer's Belt
                {2, 30106}, -- Belt of One-Hundred Deaths
                {3, 34929}, -- Belt of the Silent Path
                {4, 30040}, -- Belt of Deep Shadow
                {5, 30879}, -- Don Alejandro's Money Belt
                {6, 32265}, -- Shadow-walker's Cord
                {7, 33211}, -- Bladeangel's Money Belt
                {8, 33583}, -- Waistguard of the Great Beast
                {9, 35156}, -- Guardian's Leather Belt
                {10, 29247}, -- Girdle of the Deathdealer
                {11, 28828}, -- Gronn-Stitched Girdle
                {12, 35152}, -- Guardian's Dragonhide Belt
                {13, 30372}, -- Socrethar's Girdle
                {14, 28750}, -- Girdle of Treachery
                {15, 33891} -- Vindicator's Leather Belt
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34361}, -- Hard Khorium Band
                {2, 32497}, -- Stormrage Signet Ring
                {3, 34189}, -- Band of Ruinous Delight
                {4, 34887}, -- Angelista's Revenge
                {5, 33496}, -- Signet of Primal Wrath
                {6, 29301}, -- Band of the Eternal Champion
                {7, 32266}, -- Ring of Deceitful Intent
                {8, 30052}, -- Ring of Lethality
                {9, 29997}, -- Band of the Ranger-General
                {10, 32526}, -- Band of Devastation
                {11, 30738}, -- Ring of Reciprocity
                {12, 28757}, -- Ring of a Thousand Marks
                {13, 28649}, -- Garona's Signet Ring
                {14, 29300}, -- Band of Eternity (revered)
                {15, 35131} -- Guardian's Band of Triumph
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34188}, -- Leggings of the Immortal Night
                {2, 31029}, -- Slayer's Legguards
                {3, 34385}, -- Leggings of the Immortal Beast
                {4, 28741}, -- Skulker's Greaves
                {5, 30898}, -- Shady Dealer's Pantaloons
                {6, 35034}, -- Brutal Gladiator's Leather Legguards
                {7, 33538}, -- Shallow-grave Trousers
                {8, 30148}, -- Deathmantle Legguards
                {9, 29995}, -- Leggings of Murderous Intent
                {10, 29046}, -- Netherblade Breeches
                {11, 34701}, -- Leggings of the Betrayed
                {12, 25687}, -- Fel Leather Leggings
                {13, 34910}, -- Tameless Breeches
                {14, 33702}, -- Vengeful Gladiator's Leather Legguards
                {15, 30538} -- Midnight Legguards
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34575}, -- Slayer's Boots
                {2, 33222}, -- Nyn'jah's Tabi Boots
                {3, 32366}, -- Shadowmaster's Boots
                {4, 28545}, -- Edgewalker Longboots
                {5, 34809}, -- Sunrage Treads
                {6, 30891}, -- Black Featherlight Boots
                {7, 30039}, -- Boots of Utter Darkness
                {8, 25686}, -- Fel Leather Boots
                {9, 35141}, -- Guardian's Leather Boots
                {10, 35137}, -- Guardian's Dragonhide Boots
                {11, 30060}, -- Boots of Effortless Striking
                {12, 33892}, -- Vindicator's Leather Boots
                {13, 33582}, -- Footwraps of Wild Encroachment
                {14, 31288}, -- The Master's Treads
                {15, 33880} -- Vindicator's Dragonhide Boots
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 28830}, -- Dragonspine Trophy
                {2, 34427}, -- Blackened Naaru Sliver
                {3, 30450}, -- Warp-Spring Coil
                {4, 34472}, -- Shard of Contempt
                {5, 32492}, -- Ashtongue Talisman of Lethality
                {6, 32505}, -- Madness of the Betrayer
                {7, 30627}, -- Tsunami Talisman
                {8, 23206}, -- Mark of the Champion (undead/demon)
                {9, 33831}, -- Berserker's Call
                {10, 34428}, -- Steely Naaru Sliver
                {11, 35702}, -- Figurine - Shadowsong Panther
                {12, 31856}, -- Darkmoon Card: Crusade
                {13, 29383}, -- Bloodlust Brooch
                {14, 28288}, -- Abacus of Violent Odds
                {15, 28121} -- Icon of Unyielding Courage
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34331}, -- Hand of the Deceiver
                {2, 34329}, -- Crux of the Apocalypse
                {3, 32837}, -- Warglaive of Azzinoth
                {4, 34197}, -- Shiv of Exsanguination
                {5, 34214}, -- Muramasa
                {6, 35076}, -- Brutal Gladiator's Right Ripper
                {7, 35071}, -- Brutal Gladiator's Pummeler
                {8, 35101}, -- Brutal Gladiator's Slicer
                {9, 34893}, -- Vanir's Right Fist of Brutality
                {10, 35093}, -- Brutal Gladiator's Shanker
                {11, 33737}, -- Vengeful Gladiator's Right Ripper
                {12, 33733}, -- Vengeful Gladiator's Pummeler
                {13, 33762}, -- Vengeful Gladiator's Slicer
                {14, 28439}, -- Dragonstrike (melee proc)
                {15, 30881} -- Blade of Infamy
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34203}, -- Grip of Mannoroth
                {2, 34165}, -- Fang of Kalecgos
                {3, 34329}, -- Crux of the Apocalypse
                {4, 32838}, -- Warglaive of Azzinoth
                {5, 34950}, -- Vanir's Left Fist of Savagery
                {6, 35095}, -- Brutal Gladiator's Shiv
                {7, 32943}, -- Swiftsteel Bludgeon
                {8, 34164}, -- Dragonscale-Encrusted Longblade
                {9, 34197}, -- Shiv of Exsanguination
                {10, 34988}, -- Brutal Gladiator's Bonecracker
                {11, 35038}, -- Brutal Gladiator's Left Ripper
                {12, 35072}, -- Brutal Gladiator's Quickblade
                {13, 32369}, -- Blade of Savagery
                {14, 30865}, -- Tracker's Blade
                {15, 33756} -- Vengeful Gladiator's Shiv
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
                {2, 34334}, -- Thori'dal, the Stars' Fury
                {3, 34196}, -- Golden Bow of Quel'Thalas
                {4, 34892}, -- Crossbow of Relentless Strikes
                {5, 34349}, -- Blade of Life's Inevitability
                {6, 29949}, -- Arcanite Steam-Pistol
                {7, 30724}, -- Barrel-Blade Longrifle
                {8, 33474}, -- Ancient Amani Longbow
                {9, 34603}, -- Distracting Blades
                {10, 33491}, -- Tuskbreaker
                {11, 32326}, -- Twisted Blades of Zarak
                {12, 28772}, -- Sunfury Bow of the Phoenix
                {13, 29151}, -- Veteran's Musket
                {14, 29152}, -- Marksman's Bow
                {15, 28504}, -- Steelhawk Crossbow
                {16, 34622} -- Spinesever
            }
        }

        --@end-version-bcc@
    }
}
