local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["ShamanResto"] = {
    name = AL["Shaman Resto BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34402}, -- Shroud of Chieftain Ner'zhul
                {2, 34339}, -- Cowl of Light's Purity
                {3, 34245}, -- Cover of Ursol the Wise
                {4, 35184}, -- Primal-Attuned Goggles
                {5, 35183}, -- Wonderheal XT68 Shades
                {6, 31012}, -- Skyshatter Helmet
                {7, 32241}, -- Helm of Soothing Currents
                {8, 35181}, -- Powerheal 9000 Lens
                {9, 32240}, -- Guise of the Tidal Lurker
                {10, 35079}, -- Brutal Gladiator's Ringmail Helm
                {11, 32475}, -- Living Replicator Specs
                {12, 30166}, -- Cataclysm Headguard
                {13, 33286}, -- Mojo-mender's Mask
                {14, 32329}, -- Cowl of Benevolence
                {15, 33463} -- Hood of the Third Eye
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34360}, -- Amulet of Flowing Life
                {2, 33281}, -- Brooch of Nature's Mercy
                {3, 34184}, -- Brooch of the Highborne
                {4, 37929}, -- Guardian's Pendant of Reprieve
                {5, 35317}, -- Vindicator's Pendant of Reprieve
                {6, 32370}, -- Nadina's Pendant of Purity
                {7, 35291}, -- Sin'dorei Pendant of Salvation
                {8, 30018}, -- Lord Sanguinar's Claim
                {9, 35134}, -- Guardian's Pendant of Salvation
                {10, 34359}, -- Pendant of Sunfire
                {11, 30726}, -- Archaic Charm of Presence
                {12, 28609}, -- Emberspur Talisman
                {13, 33922}, -- Vindicator's Pendant of Salvation
                {14, 34677}, -- Shattered Sun Pendant of Restoration
                {15, 33068} -- Veteran's Pendant of Salvation
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34202}, -- Shawl of Wonderment
                {2, 34208}, -- Equilibrium Epaulets
                {3, 34209}, -- Spaulders of Reclamation
                {4, 32579}, -- Living Earth Shoulders
                {5, 32583}, -- Shoulderpads of Renewed Life
                {6, 33464}, -- Hex Lord's Voodoo Pauldrons
                {7, 31022}, -- Skyshatter Shoulderpads
                {8, 32585}, -- Swiftheal Mantle
                {9, 35081}, -- Brutal Gladiator's Ringmail Spaulders
                {10, 30168}, -- Cataclysm Shoulderguards
                {11, 30097}, -- Coral-Barbed Shoulderpads
                {12, 33742}, -- Vengeful Gladiator's Ringmail Spaulders
                {13, 34210}, -- Amice of the Convoker
                {14, 33287}, -- Gnarled Ironwood Pauldrons
                {15, 32517} -- The Wavemender's Mantle
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 32524}, -- Shroud of the Highborne
                {2, 33592}, -- Cloak of Ancient Rituals
                {3, 34205}, -- Shroud of Redeemed Souls
                {4, 34242}, -- Tattered Cape of Antonidas
                {5, 34012}, -- Shroud of the Final Stand
                {6, 34702}, -- Cloak of Swift Mending
                {7, 35324}, -- Cloak of Swift Reprieve
                {8, 29989}, -- Sunshower Light Cloak
                {9, 32337}, -- Shroud of Forgiveness
                {10, 31329}, -- Lifegiving Cloak
                {11, 28765}, -- Stainless Cloak of the Pure Hearted
                {12, 24254}, -- White Remedy Cape
                {13, 28582}, -- Red Riding Hood's Cloak
                {14, 33333}, -- Kharmaa's Shroud of Hope
                {15, 27448} -- Cloak of the Everliving
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34375}, -- Sun-Drenched Scale Chestguard
                {2, 34365}, -- Robe of Eternal Light
                {3, 34212}, -- Sunglow Vest
                {4, 34229}, -- Garments of Serene Shores
                {5, 34233}, -- Robes of Faltered Light
                {6, 34371}, -- Leather Chestguard of the Sun
                {7, 33469}, -- Hauberk of the Empire's Champion
                {8, 35077}, -- Brutal Gladiator's Ringmail Armor
                {9, 31016}, -- Skyshatter Chestguard
                {10, 34364}, -- Sunfire Robe
                {11, 34930}, -- Wave of Life Chestguard
                {12, 30164}, -- Cataclysm Chestguard
                {13, 33738}, -- Vengeful Gladiator's Ringmail Armor
                {14, 21875}, -- Primal Mooncloth Robe
                {15, 32340} -- Garments of Temperance
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34438}, -- Skyshatter Bracers
                {2, 32584}, -- Swiftheal Wraps
                {3, 32577}, -- Living Earth Bindings
                {4, 32582}, -- Bracers of Renewed Life
                {5, 30869}, -- Howling Wind Bracers
                {6, 35177}, -- Guardian's Ringmail Bracers
                {7, 30684}, -- Ravager's Cuffs of Healing
                {8, 33589}, -- Wristguards of Tranquil Thought
                {9, 30868}, -- Rejuvenating Bracers
                {10, 30871}, -- Bracers of Martyrdom
                {11, 30047}, -- Blackfathom Warbands
                {12, 33906}, -- Vindicator's Ringmail Bracers
                {13, 34602}, -- Eversong Cuffs
                {14, 33557}, -- Gargon's Bracers of Peaceful Slumber
                {15, 33532} -- Gleaming Earthen Bracers
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34376}, -- Sun-Drenched Scale Gloves
                {2, 34372}, -- Leather Gauntlets of the Sun
                {3, 34409}, -- Gauntlets of the Ancient Frostwolf
                {4, 32328}, -- Botanist's Gloves of Growth
                {5, 34342}, -- Handguards of the Dawn
                {6, 32275}, -- Spiritwalker Gauntlets
                {7, 34351}, -- Tranquil Majesty Wraps
                {8, 34791}, -- Gauntlets of the Tranquil Waves
                {9, 34367}, -- Hands of Eternal Light
                {10, 32353}, -- Gloves of Unfailing Faith
                {11, 29976}, -- Worldstorm Gauntlets
                {12, 31007}, -- Skyshatter Gloves
                {13, 34344}, -- Handguards of Defiled Worlds
                {14, 34406}, -- Gloves of Tyri's Power
                {15, 35078} -- Brutal Gladiator's Ringmail Gauntlets
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34543}, -- Skyshatter Belt
                {2, 30895}, -- Angelista's Sash
                {3, 32258}, -- Naturalist's Preserving Cinch
                {4, 32339}, -- Belt of Primal Majesty
                {5, 33386}, -- Man'kin'do's Belt
                {6, 34932}, -- Clutch of the Soothing Breeze
                {7, 33480}, -- Cord of Braided Troll Hair
                {8, 33483}, -- Life-step Belt
                {9, 21873}, -- Primal Mooncloth Belt
                {10, 30030}, -- Girdle of Fallen Stars
                {11, 30675}, -- Lurker's Cord of Healing
                {12, 35162}, -- Guardian's Ringmail Girdle
                {13, 32519}, -- Belt of Divine Guidance
                {14, 29984}, -- Girdle of Zaetar
                {15, 29524} -- Windhawk Belt
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 32528}, -- Blessed Band of Karabor
                {2, 34363}, -- Ring of Flowing Life
                {3, 33498}, -- Signet of the Quiet Forest
                {4, 34166}, -- Band of Lucent Beams
                {5, 29309}, -- Band of the Eternal Restorer
                {6, 34625}, -- Kharmaa's Ring of Fate
                {7, 32238}, -- Ring of Calming Waves
                {8, 34890}, -- Anveena's Touch
                {9, 29308}, -- Band of Eternity (revered)
                {10, 30736}, -- Ring of Flowing Light
                {11, 28763}, -- Jade Ring of the Everliving
                {12, 35283}, -- Sin'dorei Band of Salvation
                {13, 35733}, -- Ring of Harmonic Beauty
                {14, 29306}, -- Band of Eternity (honored)
                {15, 34230} -- Ring of Omnipotence
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34383}, -- Kilt of Spiritual Reconstruction
                {2, 34170}, -- Pantaloons of Calming Strife
                {3, 34384}, -- Breeches of Natural Splendor
                {4, 33585}, -- Achromic Trousers of the Naaru
                {5, 30912}, -- Leggings of Eternity
                {6, 32271}, -- Kilt of Immortal Nature
                {7, 34931}, -- Runed Scales of Antiquity
                {8, 30893}, -- Sun-touched Chain Leggings
                {9, 30727}, -- Gilded Trousers of Benediction
                {10, 29991}, -- Sunhawk Leggings
                {11, 31019}, -- Skyshatter Leggings
                {12, 33530}, -- Natural Life Leggings
                {13, 34901}, -- Grovewalker's Leggings
                {14, 34925}, -- Adorned Supernal Legwraps
                {15, 35080} -- Brutal Gladiator's Ringmail Leggings
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34565}, -- Skyshatter Boots
                {2, 33471}, -- Two-toed Sandals
                {3, 33324}, -- Treads of the Life Path
                {4, 30737}, -- Gold-Leaf Wildboots
                {5, 30680}, -- Glider's Foot-Wraps of Healing
                {6, 34926}, -- Slippers of Dutiful Mending
                {7, 30873}, -- Stillwater Boots
                {8, 30092}, -- Orca-Hide Boots
                {9, 35147}, -- Guardian's Ringmail Sabatons
                {10, 34566}, -- Skyshatter Treads
                {11, 32609}, -- Boots of the Divine Light
                {12, 30100}, -- Soul-Strider Boots
                {13, 34707}, -- Boots of Resuscitation
                {14, 33908}, -- Vindicator's Ringmail Sabatons
                {15, 30035} -- Boots of the Long Road
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 32496}, -- Memento of Tyrande
                {2, 34430}, -- Glimmering Naaru Sliver
                {3, 29376}, -- Essence of the Martyr
                {4, 38288}, -- Direbrew Hops
                {5, 28190}, -- Scarab of the Infinite Cycle
                {6, 28823}, -- Eye of Gruul
                {7, 34429}, -- Shifting Naaru Sliver
                {8, 33828}, -- Tome of Diabolic Remedy
                {9, 23047}, -- Eye of the Dead
                {10, 25634}, -- Oshu'gun Relic
                {11, 34050}, -- Battlemaster's Perseverance
                {12, 34580}, -- Battlemaster's Perseverance
                {13, 30841}, -- Lower City Prayerbook
                {14, 19395}, -- Rejuvenating Gem
                {15, 27683} -- Quagmirran's Eye
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
                {8, 30108}, -- Lightfathom Scepter
                {9, 30918}, -- Hammer of Atonement
                {10, 32964}, -- Merciless Gladiator's Salvation
                {11, 28771}, -- Light's Justice
                {12, 32451}, -- Gladiator's Salvation
                {13, 28522}, -- Shard of the Virtuous
                {14, 23556}, -- Hand of Eternity
                {15, 29353} -- Shockwave Truncheon
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34206}, -- Book of Highborne Hymns
                {2, 34231}, -- Aegis of Angelic Fortune
                {3, 30882}, -- Bastion of Light
                {4, 32350}, -- Touch of Inspiration
                {5, 32255}, -- Felstone Bulwark
                {6, 33332}, -- Enamelled Disc of Mojo
                {7, 35073}, -- Brutal Gladiator's Redoubt
                {8, 35074}, -- Brutal Gladiator's Reprieve
                {9, 30911}, -- Scepter of Purification
                {10, 29274}, -- Tears of Heaven
                {11, 29458}, -- Aegis of the Vindicator
                {12, 29923}, -- Talisman of the Sun King
                {13, 33735}, -- Vengeful Gladiator's Redoubt
                {14, 33736}, -- Vengeful Gladiator's Reprieve
                {15, 28728} -- Aran's Soothing Sapphire
            }
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34337}, -- Golden Staff of the Sin'dorei
                {2, 30908}, -- Apostle of Argus
                {3, 33490}, -- Staff of Dark Mending
                {4, 32344}, -- Staff of Immaculate Recovery
                {5, 30732}, -- Exodar Life-Staff
                {6, 29981}, -- Ethereum Life-Staff
                {7, 28782}, -- Crystalheart Pulse-Staff
                {8, 34608}, -- Rod of the Blazing Light
                {9, 28604}, -- Nightstaff of the Everliving
                {10, 29133}, -- Seer's Cane
                {11, 28033}, -- Epoch-Mender
                {12, 27791}, -- Serpentcrest Life-Staff
                {13, 31038}, -- Staff of the Redeemer
                {14, 30012}, -- Ameer's Judgement
                {15, 31417} -- Staff of the Ashtongue Deathsworn
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
