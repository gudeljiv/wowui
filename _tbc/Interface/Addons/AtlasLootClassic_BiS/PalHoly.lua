local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["PalHoly"] = {
    name = AL["Paladin Holy BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34402}, -- Shroud of Chieftain Ner'zhul
                {2, 34339}, -- Cowl of Light's Purity
                {3, 34243}, -- Helm of Burning Righteousness
                {4, 34245}, -- Cover of Ursol the Wise
                {5, 35185}, -- Justicebringer 3000 Specs
                {6, 35183}, -- Wonderheal XT68 Shades
                {7, 30988}, -- Lightbringer Greathelm
                {8, 32354}, -- Crown of Empowered Fate
                {9, 35181}, -- Powerheal 9000 Lens
                {10, 32241}, -- Helm of Soothing Currents
                {11, 30728}, -- Fathom-Helm of the Deeps
                {12, 30136}, -- Crystalforge Greathelm
                {13, 33286}, -- Mojo-mender's Mask
                {14, 33327}, -- Mask of Introspection
                {15, 32240} -- Guise of the Tidal Lurker
                ,
                {16, 25897},
                {17, 25901},
                {18, 29190}
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34360}, -- Amulet of Flowing Life
                {2, 33281}, -- Brooch of Nature's Mercy
                {3, 37929}, -- Guardian's Pendant of Reprieve
                {4, 34184}, -- Brooch of the Highborne
                {5, 35317}, -- Vindicator's Pendant of Reprieve
                {6, 32370}, -- Nadina's Pendant of Purity
                {7, 35291}, -- Sin'dorei Pendant of Salvation
                {8, 30018}, -- Lord Sanguinar's Claim
                {9, 35134}, -- Guardian's Pendant of Salvation
                {10, 30726}, -- Archaic Charm of Presence
                {11, 33922}, -- Vindicator's Pendant of Salvation
                {12, 34359}, -- Pendant of Sunfire
                {13, 33068}, -- Veteran's Pendant of Salvation
                {14, 34677}, -- Shattered Sun Pendant of Restoration
                {15, 28609} -- Emberspur Talisman
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34202}, -- Shawl of Wonderment
                {2, 34208}, -- Equilibrium Epaulets
                {3, 34209}, -- Spaulders of Reclamation
                {4, 34193}, -- Spaulders of the Thalassian Savior
                {5, 30996}, -- Lightbringer Pauldrons
                {6, 32579}, -- Living Earth Shoulders
                {7, 30878}, -- Glimmering Steel Mantle
                {8, 32583}, -- Shoulderpads of Renewed Life
                {9, 32573}, -- Dawnsteel Shoulders
                {10, 30138}, -- Crystalforge Pauldrons
                {11, 30097}, -- Coral-Barbed Shoulderpads
                {12, 35063}, -- Brutal Gladiator's Ornamented Spaulders
                {13, 33464}, -- Hex Lord's Voodoo Pauldrons
                {14, 32585}, -- Swiftheal Mantle
                {15, 33287} -- Gnarled Ironwood Pauldrons
                ,
                {16, 28887}
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 32524}, -- Shroud of the Highborne
                {2, 33592}, -- Cloak of Ancient Rituals
                {3, 34205}, -- Shroud of Redeemed Souls
                {4, 29989}, -- Sunshower Light Cloak
                {5, 32337}, -- Shroud of Forgiveness
                {6, 34242}, -- Tattered Cape of Antonidas
                {7, 35324}, -- Cloak of Swift Reprieve
                {8, 34012}, -- Shroud of the Final Stand
                {9, 34702}, -- Cloak of Swift Mending
                {10, 31329}, -- Lifegiving Cloak
                {11, 28765}, -- Stainless Cloak of the Pure Hearted
                {12, 29354}, -- Light-Touched Stole of Altruism
                {13, 32653}, -- Apexis Cloak
                {14, 24254}, -- White Remedy Cape
                {15, 28582} -- Red Riding Hood's Cloak
                ,
                {16, 22548}
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34365}, -- Robe of Eternal Light
                {2, 34375}, -- Sun-Drenched Scale Chestguard
                {3, 34212}, -- Sunglow Vest
                {4, 34233}, -- Robes of Faltered Light
                {5, 34229}, -- Garments of Serene Shores
                {6, 34371}, -- Leather Chestguard of the Sun
                {7, 30992}, -- Lightbringer Chestpiece
                {8, 30134}, -- Crystalforge Chestpiece
                {9, 33469}, -- Hauberk of the Empire's Champion
                {10, 29062}, -- Justicar Chestpiece
                {11, 21875}, -- Primal Mooncloth Robe
                {12, 34605}, -- Breastplate of Fierce Survival
                {13, 33216}, -- Chestguard of Hidden Purpose
                {14, 33203}, -- Robes of Heavenly Purpose
                {15, 35059} -- Brutal Gladiator's Ornamented Chestguard
                ,
                -- {16, 33991 } -- This is the spellID, but there is no correlating itemID that can go with it...
            },

        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34432}, -- Lightbringer Bracers
                {2, 32571}, -- Dawnsteel Bracers
                {3, 32584}, -- Swiftheal Wraps
                {4, 32577}, -- Living Earth Bindings
                {5, 32582}, -- Bracers of Renewed Life
                {6, 30862}, -- Blessed Adamantite Bracers
                {7, 35175}, -- Guardian's Ornamented Bracers
                {8, 30869}, -- Howling Wind Bracers
                {9, 30868}, -- Rejuvenating Bracers
                {10, 30871}, -- Bracers of Martyrdom
                {11, 30047}, -- Blackfathom Warbands
                {12, 33520}, -- Vambraces of the Naaru
                {13, 33589}, -- Wristguards of Tranquil Thought
                {14, 33904}, -- Vindicator's Ornamented Bracers
                {15, 30684} -- Ravager's Cuffs of Healing
                ,
                {16, 22531}
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34240}, -- Gauntlets of the Soothed Soul
                {2, 34372}, -- Leather Gauntlets of the Sun
                {3, 32328}, -- Botanist's Gloves of Growth
                {4, 34376}, -- Sun-Drenched Scale Gloves
                {5, 34409}, -- Gauntlets of the Ancient Frostwolf
                {6, 34342}, -- Handguards of the Dawn
                {7, 34380}, -- Sunblessed Gauntlets
                {8, 34351}, -- Tranquil Majesty Wraps
                {9, 34367}, -- Hands of Eternal Light
                {10, 32275}, -- Spiritwalker Gauntlets
                {11, 30112}, -- Glorious Gauntlets of Crestfall
                {12, 32353}, -- Gloves of Unfailing Faith
                {13, 29976}, -- Worldstorm Gauntlets
                {14, 34791}, -- Gauntlets of the Tranquil Waves
                {15, 34700} -- Gauntlets of Divine Blessings
                ,
                {16, 28273}
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34487}, -- Lightbringer Belt
                {2, 30895}, -- Angelista's Sash
                {3, 32258}, -- Naturalist's Preserving Cinch
                {4, 32339}, -- Belt of Primal Majesty
                {5, 30897}, -- Girdle of Hope
                {6, 33446}, -- Girdle of Stromgarde's Hope
                {7, 32512}, -- Girdle of Lordaeron's Fallen
                {8, 33480}, -- Cord of Braided Troll Hair
                {9, 21873}, -- Primal Mooncloth Belt
                {10, 33483}, -- Life-step Belt
                {11, 30030}, -- Girdle of Fallen Stars
                {12, 34932}, -- Clutch of the Soothing Breeze
                {13, 33386}, -- Man'kin'do's Belt
                {14, 32519}, -- Belt of Divine Guidance
                {15, 29984} -- Girdle of Zaetar
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 32528}, -- Blessed Band of Karabor
                {2, 34363}, -- Ring of Flowing Life
                {3, 34166}, -- Band of Lucent Beams
                {4, 33498}, -- Signet of the Quiet Forest
                {5, 29309}, -- Band of the Eternal Restorer
                {6, 34625}, -- Kharmaa's Ring of Fate
                {7, 32238}, -- Ring of Calming Waves
                {8, 30736}, -- Ring of Flowing Light
                {9, 29308}, -- Band of Eternity (revered)
                {10, 35733}, -- Ring of Harmonic Beauty
                {11, 34890}, -- Anveena's Touch
                {12, 30110}, -- Coral Band of the Revived
                {13, 35283}, -- Sin'dorei Band of Salvation
                {14, 29306}, -- Band of Eternity (honored)
                {15, 28763} -- Jade Ring of the Everliving
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34383}, -- Kilt of Spiritual Reconstruction
                {2, 34170}, -- Pantaloons of Calming Strife
                {3, 34384}, -- Breeches of Natural Splendor
                {4, 34167}, -- Legplates of the Holy Juggernaut
                {5, 30912}, -- Leggings of Eternity
                {6, 32271}, -- Kilt of Immortal Nature
                {7, 30893}, -- Sun-touched Chain Leggings
                {8, 30727}, -- Gilded Trousers of Benediction
                {9, 29991}, -- Sunhawk Leggings
                {10, 33518}, -- High Justicar's Legplates
                {11, 33585}, -- Achromic Trousers of the Naaru
                {12, 34931}, -- Runed Scales of Antiquity
                {13, 33530}, -- Natural Life Leggings
                {14, 34901}, -- Grovewalker's Leggings
                {15, 34925} -- Adorned Supernal Legwraps
                ,
                {16, 24276},
                {17, 24275},
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34559}, -- Lightbringer Treads
                {2, 33324}, -- Treads of the Life Path
                {3, 30737}, -- Gold-Leaf Wildboots
                {4, 33207}, -- Implacable Guardian Sabatons
                {5, 33471}, -- Two-toed Sandals
                {6, 30092}, -- Orca-Hide Boots
                {7, 32609}, -- Boots of the Divine Light
                {8, 30680}, -- Glider's Foot-Wraps of Healing
                {9, 34926}, -- Slippers of Dutiful Mending
                {10, 32243}, -- Pearl Inlaid Boots
                {11, 34612}, -- Greaves of the Penitent Knight
                {12, 30100}, -- Soul-Strider Boots
                {13, 30027}, -- Boots of Courage Unending
                {14, 28752}, -- Forestlord Striders
                {15, 34707} -- Boots of Resuscitation
                ,
                {16, 28280},
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 29376}, -- Essence of the Martyr
                {2, 38288}, -- Direbrew Hops
                {3, 32496}, -- Memento of Tyrande
                {4, 34430}, -- Glimmering Naaru Sliver
                {5, 28190}, -- Scarab of the Infinite Cycle
                {6, 30447}, -- Tome of Fiery Redemption
                {7, 23047}, -- Eye of the Dead
                {8, 25634}, -- Oshu'gun Relic
                {9, 34050}, -- Battlemaster's Perseverance
                {10, 34580}, -- Battlemaster's Perseverance
                {11, 34429}, -- Shifting Naaru Sliver
                {12, 28823}, -- Eye of Gruul
                {13, 33828}, -- Tome of Diabolic Remedy
                {14, 30841}, -- Lower City Prayerbook
                {15, 28590} -- Ribbon of Sacrifice
            }
        },
        {
            -- T2
            name = format(AL["Onehand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34335}, -- Hammer of Sanctification
                {2, 34199}, -- Archon's Gavel
                {3, 35082}, -- Brutal Gladiator's Salvation
                {4, 32500}, -- Crystal Spire of Karabor
                {5, 33468}, -- Dark Blessing
                {6, 34896}, -- Gavel of Naaru Blessings
                {7, 33743}, -- Vengeful Gladiator's Salvation
                {8, 30918}, -- Hammer of Atonement
                {9, 30108}, -- Lightfathom Scepter
                {10, 32964}, -- Merciless Gladiator's Salvation
                {11, 28771}, -- Light's Justice
                {12, 32451}, -- Gladiator's Salvation
                {13, 28522}, -- Shard of the Virtuous
                {14, 23556}, -- Hand of Eternity
                {15, 29353} -- Shockwave Truncheon
                ,
                {16, 28281},
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34206}, -- Book of Highborne Hymns
                {2, 30882}, -- Bastion of Light
                {3, 34231}, -- Aegis of Angelic Fortune
                {4, 33332}, -- Enamelled Disc of Mojo
                {5, 32255}, -- Felstone Bulwark
                {6, 35073}, -- Brutal Gladiator's Redoubt
                {7, 35074}, -- Brutal Gladiator's Reprieve
                {8, 30911}, -- Scepter of Purification
                {9, 32350}, -- Touch of Inspiration
                {10, 29274}, -- Tears of Heaven
                {11, 33735}, -- Vengeful Gladiator's Redoubt
                {12, 33736}, -- Vengeful Gladiator's Reprieve
                {13, 29923}, -- Talisman of the Sun King
                {14, 29170}, -- Windcaller's Orb
                {15, 29458} -- Aegis of the Vindicator
                ,
                {16, 22539}
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
