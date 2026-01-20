local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["PalProt"] = {
    name = AL["Paladin Prot BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34401}, -- Helm of Uther's Resolve
                {2, 34400}, -- Crown of Dath'Remar
                {3, 32521}, -- Faceplate of the Impenetrable
                {4, 34357}, -- Hard Khorium Goggles
                {5, 30987}, -- Lightbringer Faceguard
                {6, 35029}, -- Brutal Gladiator's Lamellar Helm
                {7, 30125}, -- Crystalforge Faceguard
                {8, 33421}, -- Battleworn Tuskguard
                {9, 33697}, -- Vengeful Gladiator's Lamellar Helm
                {10, 31997}, -- Merciless Gladiator's Lamellar Helm
                {11, 32473}, -- Tankatronic Goggles
                {12, 34345}, -- Crown of Anasterian
                {13, 35061}, -- Brutal Gladiator's Ornamented Headcover
                {14, 29068}, -- Justicar Faceguard
                {15, 35090} -- Brutal Gladiator's Scaled Helm
                ,
                {16, 25896},
                {17, 34220},
                {18, 29186},
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 35133}, -- Guardian's Pendant of Dominance
                {2, 34178}, -- Collar of the Pit Lord
                {3, 30007}, -- The Darkener's Grasp
                {4, 33921}, -- Vindicator's Pendant of Dominance
                {5, 32362}, -- Pendant of Titans
                {6, 35132}, -- Guardian's Pendant of Conquest
                {7, 37928}, -- Guardian's Pendant of Subjugation
                {8, 34359}, -- Pendant of Sunfire
                {9, 33065}, -- Veteran's Pendant of Dominance
                {10, 28245}, -- Pendant of Dominance
                {11, 34358}, -- Hard Khorium Choker
                {12, 33920}, -- Vindicator's Pendant of Conquest
                {13, 35319}, -- Vindicator's Pendant of Subjugation
                {14, 28516}, -- Barbed Choker of Discipline
                {15, 35135} -- Guardian's Pendant of Triumph
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34389}, -- Spaulders of the Thalassian Defender
                {2, 34192}, -- Pauldrons of Perseverance
                {3, 30998}, -- Lightbringer Shoulderguards
                {4, 35031}, -- Brutal Gladiator's Lamellar Shoulders
                {5, 32250}, -- Pauldrons of Abyssal Fury
                {6, 30127}, -- Crystalforge Shoulderguards
                {7, 29070}, -- Justicar Shoulderguards
                {8, 33481}, -- Pauldrons of Stone Resolve
                {9, 33699}, -- Vengeful Gladiator's Lamellar Shoulders
                {10, 34388}, -- Pauldrons of Berserking
                {11, 35092}, -- Brutal Gladiator's Scaled Shoulders
                {12, 31996}, -- Merciless Gladiator's Lamellar Shoulders
                {13, 35063}, -- Brutal Gladiator's Ornamented Spaulders
                {14, 33753}, -- Vengeful Gladiator's Scaled Shoulders
                {15, 30997} -- Lightbringer Shoulderbraces
                ,
                {16, 28911}
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 34190}, -- Crimson Paragon's Cover
                {2, 34242}, -- Tattered Cape of Antonidas
                {3, 33593}, -- Slikk's Cloak of Placation
                {4, 34010}, -- Pepe's Shroud of Pacification
                {5, 29925}, -- Phoenix-Wing Cloak
                {6, 29992}, -- Royal Cloak of the Sunstriders
                {7, 34241}, -- Cloak of Unforgivable Sin
                {8, 32331}, -- Cloak of the Illidari Council
                {9, 33304}, -- Cloak of Subjugated Power
                {10, 35321}, -- Cloak of Arcane Alacrity
                {11, 28660}, -- Gilded Thorium Cloak
                {12, 28378}, -- Sergeant's Heavy Cape
                {13, 28379}, -- Sergeant's Heavy Cape
                {14, 29385}, -- Farstrider Defender's Cloak
                {15, 27804} -- Devilshark Cape
                ,
                {16, 20736}
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34216}, -- Heroic Judicator's Chestguard
                {2, 30991}, -- Lightbringer Chestguard
                {3, 34394}, -- Breastplate of Agony's Aversion
                {4, 35027}, -- Brutal Gladiator's Lamellar Chestpiece
                {5, 33522}, -- Chestguard of the Stoic Guardian
                {6, 34939}, -- Chestplate of Stoicism
                {7, 34945}, -- Shattrath Protectorate's Breastplate
                {8, 30123}, -- Crystalforge Chestguard
                {9, 33473}, -- Chestguard of the Warlord
                {10, 34215}, -- Warharness of Reckless Fury
                {11, 33695}, -- Vengeful Gladiator's Lamellar Chestpiece
                {12, 30896}, -- Glory of the Defender
                {13, 35088}, -- Brutal Gladiator's Scaled Chestpiece
                {14, 29066}, -- Justicar Chestguard
                {15, 35059} -- Brutal Gladiator's Ornamented Chestguard
                ,
                {16, 35428}
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34433}, -- Lightbringer Wristguards
                {2, 32279}, -- The Seeker's Wristguards
                {3, 32232}, -- Eternium Shell Bracers
                {4, 35170}, -- Guardian's Lamellar Bracers
                {5, 32515}, -- Wristguards of Determination
                {6, 33889}, -- Vindicator's Lamellar Bracers
                {7, 35176}, -- Guardian's Plate Bracers
                {8, 33516}, -- Bracers of the Ancient Phalanx
                {9, 28502}, -- Vambraces of Courage
                {10, 35178}, -- Guardian's Scaled Bracers
                {11, 33813}, -- Vindicator's Plate Bracers
                {12, 32813}, -- Veteran's Lamellar Bracers
                {13, 35175}, -- Guardian's Ornamented Bracers
                {14, 29252}, -- Bracers of Dignity
                {15, 33910} -- Vindicator's Scaled Bracers
                ,
                {16, 35425}
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34352}, -- Borderland Fortress Grips
                {2, 30985}, -- Lightbringer Handguards
                {3, 29998}, -- Royal Gauntlets of Silvermoon
                {4, 32280}, -- Gauntlets of Enforcement
                {5, 30124}, -- Crystalforge Handguards
                {6, 35028}, -- Brutal Gladiator's Lamellar Gauntlets
                {7, 34341}, -- Borderland Paingrips
                {8, 33517}, -- Bonefist Gauntlets
                {9, 34378}, -- Hard Khorium Battlefists
                {10, 28518}, -- Iron Gauntlets of the Maiden
                {11, 30741}, -- Topaz-Studded Battlegrips
                {12, 33696}, -- Vengeful Gladiator's Lamellar Gauntlets
                {13, 35060}, -- Brutal Gladiator's Ornamented Gloves
                {14, 29067}, -- Justicar Handguards
                {15, 34380} -- Sunblessed Gauntlets
                ,
                {16, 20726},
                {17, 28272}
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34488}, -- Lightbringer Waistguard
                {2, 32342}, -- Girdle of Mighty Resolve
                {3, 32333}, -- Girdle of Stability
                {4, 30034}, -- Belt of the Guardian
                {5, 33524}, -- Girdle of the Protector
                {6, 33279}, -- Iron-tusk Girdle
                {7, 30096}, -- Girdle of the Invulnerable
                {8, 34941}, -- Girdle of the Fearless
                {9, 35155}, -- Guardian's Lamellar Belt
                {10, 33888}, -- Vindicator's Lamellar Belt
                {11, 28566}, -- Crimson Girdle of the Indomitable
                {12, 34944}, -- Girdle of Seething Rage
                {13, 35161}, -- Guardian's Plate Belt
                {14, 29253}, -- Girdle of Valorous Deeds
                {15, 30897} -- Girdle of Hope
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 34213}, -- Ring of Hardened Resolve
                {2, 34888}, -- Ring of the Stalwart Protector
                {3, 33499}, -- Signet of the Last Defender
                {4, 29297}, -- Band of the Eternal Defender
                {5, 29296}, -- Band of Eternity (revered)
                {6, 30083}, -- Ring of Sundered Souls
                {7, 30028}, -- Seventh Ring of the Tirisfalen
                {8, 29305}, -- Band of the Eternal Sage
                {9, 33054}, -- The Seal of Danzalar
                {10, 32261}, -- Band of the Abyssal Lord
                {11, 29279}, -- Violet Signet of the Great Protector
                {12, 29295}, -- Band of Eternity (honored)
                {13, 29278}, -- Violet Signet
                {14, 28792}, -- A'dal's Signet of Defense
                {15, 32527} -- Ring of Ancient Knowledge
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34382}, -- Judicator's Legguards
                {2, 34381}, -- Felstrength Legplates
                {3, 34946}, -- Inscribed Legplates of the Aldor
                {4, 30995}, -- Lightbringer Legguards
                {5, 32263}, -- Praetorian's Legguards
                {6, 33515}, -- Unwavering Legguards
                {7, 34940}, -- Sunguard Legplates
                {8, 30126}, -- Crystalforge Legguards
                {9, 35030}, -- Brutal Gladiator's Lamellar Legguards
                {10, 34180}, -- Felfury Legplates
                {11, 33698}, -- Vengeful Gladiator's Lamellar Legguards
                {12, 28621}, -- Wrynn Dynasty Greaves
                {13, 34167}, -- Legplates of the Holy Juggernaut
                {14, 35091}, -- Brutal Gladiator's Scaled Legguards
                {15, 29069} -- Justicar Legguards
                ,
                {16, 24274},
                {17, 29536}
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34560}, -- Lightbringer Stompers
                {2, 32245}, -- Tide-stomper's Greaves
                {3, 34947}, -- Blue's Greaves of the Righteous Guardian
                {4, 32268}, -- Myrmidon's Treads
                {5, 33523}, -- Sabatons of the Righteous Defender
                {6, 32267}, -- Boots of the Resilient
                {7, 35140}, -- Guardian's Lamellar Greaves
                {8, 33191}, -- Jungle Stompers
                {9, 30033}, -- Boots of the Protector
                {10, 30031}, -- Red Havoc Boots
                {11, 33890}, -- Vindicator's Lamellar Greaves
                {12, 35146}, -- Guardian's Plate Greaves
                {13, 32345}, -- Dreadboots of the Legion
                {14, 32789}, -- Veteran's Lamellar Greaves
                {15, 35148} -- Guardian's Scaled Greaves
                ,
                {16, 22555},
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 30447}, -- Tome of Fiery Redemption
                {2, 31856}, -- Darkmoon Card: Crusade
                {3, 33829}, -- Hex Shrunken Head
                {4, 23207}, -- Mark of the Champion (undead/demon)
                {5, 34473}, -- Commendation of Kael'thas
                {6, 28789}, -- Eye of Magtheridon
                {7, 34470}, -- Timbal's Focusing Crystal
                {8, 29370}, -- Icon of the Silver Crescent
                {9, 38290}, -- Dark Iron Smoking Pipe
                {10, 35700}, -- Figurine - Crimson Serpent
                {11, 31858}, -- Darkmoon Card: Vengeance
                {12, 31859}, -- Darkmoon Card: Madness
                {13, 23046}, -- The Restrained Essence of Sapphiron
                {14, 33830}, -- Ancient Aqir Artifact
                {15, 30626} -- Sextant of Unstable Currents
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 35014}, -- Brutal Gladiator's Gavel
                {2, 34176}, -- Reign of Misery
                {3, 30910}, -- Tempest of Chaos
                {4, 33687}, -- Vengeful Gladiator's Gavel
                {5, 34009}, -- Hammer of Judgement
                {6, 33467}, -- Blade of Twisted Visions
                {7, 32963}, -- Merciless Gladiator's Gavel
                {8, 33283}, -- Amani Punisher
                {9, 30095}, -- Fang of the Leviathan
                {10, 28802}, -- Bloodmaw Magus-Blade
                {11, 34164}, -- Dragonscale-Encrusted Longblade
                {12, 34611}, -- Cudgel of Consecration
                {13, 32450}, -- Gladiator's Gavel
                {14, 30874}, -- The Unbreakable Will
                {15, 34996} -- Brutal Gladiator's Cleaver
                ,
                {16, 22555}
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34185}, -- Sword Breaker's Bulwark
                {2, 34986}, -- Brutal Gladiator's Barrier
                {3, 35094}, -- Brutal Gladiator's Shield Wall
                {4, 32375}, -- Bulwark of Azzinoth
                {5, 30909}, -- Antonidas's Aegis of Rapt Concentration
                {6, 35073}, -- Brutal Gladiator's Redoubt
                {7, 34011}, -- Illidari Runeshield
                {8, 33661}, -- Vengeful Gladiator's Barrier
                {9, 34231}, -- Aegis of Angelic Fortune
                {10, 30889}, -- Kaz'rogal's Hardened Heart
                {11, 33755}, -- Vengeful Gladiator's Shield Wall
                {12, 33735}, -- Vengeful Gladiator's Redoubt
                {13, 33326}, -- Bulwark of the Amani Empire
                {14, 30882}, -- Bastion of Light
                {15, 33313} -- Merciless Gladiator's Barrier
                ,
                {16, 35449}
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
            [NORMAL_DIFF] = {}
        }

        --@end-version-bcc@
    }
}
