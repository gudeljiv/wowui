local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["DruidResto"] = {
    name = AL["Druid Resto BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34245}, -- Cover of Ursol the Wise
                {2, 34339}, -- Cowl of Light's Purity
                {3, 35183}, -- Wonderheal XT68 Shades
                {4, 35181}, -- Powerheal 9000 Lens
                {5, 31037}, -- Thunderheart Helmet
                {6, 32329}, -- Cowl of Benevolence
                {7, 33463}, -- Hood of the Third Eye
                {8, 30219}, -- Nordrassil Headguard
                {9, 33356}, -- Helm of Natural Regeneration
                {10, 32479}, -- Wonderheal XT40 Shades
                {11, 35023}, -- Brutal Gladiator's Kodohide Helm
                {12, 32240}, -- Guise of the Tidal Lurker
                {13, 32495}, -- Powerheal 4000 Lens
                {14, 24264}, -- Whitemend Hood
                {15, 33691} -- Vengeful Gladiator's Kodohide Helm
                ,
                {16, 25897},
                {17, 29190}
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 34360}, -- Amulet of Flowing Life
                {2, 35291}, -- Sin'dorei Pendant of Salvation
                {3, 30018}, -- Lord Sanguinar's Claim
                {4, 35134}, -- Guardian's Pendant of Salvation
                {5, 33281}, -- Brooch of Nature's Mercy
                {6, 32370}, -- Nadina's Pendant of Purity
                {7, 37929}, -- Guardian's Pendant of Reprieve
                {8, 30726}, -- Archaic Charm of Presence
                {9, 34184}, -- Brooch of the Highborne
                {10, 33922}, -- Vindicator's Pendant of Salvation
                {11, 35317}, -- Vindicator's Pendant of Reprieve
                {12, 34677}, -- Shattered Sun Pendant of Restoration
                {13, 33068}, -- Veteran's Pendant of Salvation
                {14, 28609}, -- Emberspur Talisman
                {15, 32531} -- Gezzarak's Fang
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34209}, -- Spaulders of Reclamation
                {2, 34202}, -- Shawl of Wonderment
                {3, 31047}, -- Thunderheart Spaulders
                {4, 30221}, -- Nordrassil Life-Mantle
                {5, 33287}, -- Gnarled Ironwood Pauldrons
                {6, 29089}, -- Shoulderguards of Malorne
                {7, 35025}, -- Brutal Gladiator's Kodohide Spaulders
                {8, 30111}, -- Runetotem's Mantle
                {9, 33693}, -- Vengeful Gladiator's Kodohide Spaulders
                {10, 21874}, -- Primal Mooncloth Shoulders
                {11, 32518}, -- Veil of Turning Leaves
                {12, 31990}, -- Merciless Gladiator's Kodohide Spaulders
                {13, 32273}, -- Amice of Brilliant Light
                {14, 31378}, -- Gladiator's Kodohide Spaulders
                {15, 32585} -- Swiftheal Mantle
                ,
                {16, 28887}
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 32337}, -- Shroud of Forgiveness
                {2, 29989}, -- Sunshower Light Cloak
                {3, 34205}, -- Shroud of Redeemed Souls
                {4, 34012}, -- Shroud of the Final Stand
                {5, 32524}, -- Shroud of the Highborne
                {6, 31329}, -- Lifegiving Cloak
                {7, 28765}, -- Stainless Cloak of the Pure Hearted
                {8, 24254}, -- White Remedy Cape
                {9, 32653}, -- Apexis Cloak
                {10, 29354}, -- Light-Touched Stole of Altruism
                {11, 33333}, -- Kharmaa's Shroud of Hope
                {12, 28582}, -- Red Riding Hood's Cloak
                {13, 22960}, -- Cloak of Suturing
                {14, 27448}, -- Cloak of the Everliving
                {15, 33592} -- Cloak of Ancient Rituals
                ,
                {16, 20735}
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34371}, -- Leather Chestguard of the Sun
                {2, 34233}, -- Robes of Faltered Light
                {3, 34212}, -- Sunglow Vest
                {4, 34365}, -- Robe of Eternal Light
                {5, 31041}, -- Thunderheart Tunic
                {6, 30216}, -- Nordrassil Chestguard
                {7, 33203}, -- Robes of Heavenly Purpose
                {8, 35026}, -- Brutal Gladiator's Kodohide Tunic
                {9, 21875}, -- Primal Mooncloth Robe
                {10, 29087}, -- Chestguard of Malorne
                {11, 33694}, -- Vengeful Gladiator's Kodohide Tunic
                {12, 34900}, -- Shroud of Nature's Harmony
                {13, 34924}, -- Gown of Spiritual Wonder
                {14, 31991}, -- Merciless Gladiator's Kodohide Tunic
                {15, 29522} -- Windhawk Hauberk
                ,
                {16, 35431}
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34445}, -- Thunderheart Bracers
                {2, 30868}, -- Rejuvenating Bracers
                {3, 30871}, -- Bracers of Martyrdom
                {4, 30684}, -- Ravager's Cuffs of Healing
                {5, 33557}, -- Gargon's Bracers of Peaceful Slumber
                {6, 33589}, -- Wristguards of Tranquil Thought
                {7, 34602}, -- Eversong Cuffs
                {8, 35169}, -- Guardian's Kodohide Bracers
                {9, 30062}, -- Grove-Bands of Remulos
                {10, 32513}, -- Wristbands of Divine Influence
                {11, 29523}, -- Windhawk Bracers
                {12, 32980}, -- Veteran's Mooncloth Cuffs
                {13, 33887}, -- Vindicator's Kodohide Bracers
                {14, 32584}, -- Swiftheal Wraps
                {15, 34705} -- Bracers of Divine Infusion
                ,
                {16, 22531}
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34367}, -- Hands of Eternal Light
                {2, 34351}, -- Tranquil Majesty Wraps
                {3, 34342}, -- Handguards of the Dawn
                {4, 34372}, -- Leather Gauntlets of the Sun
                {5, 32353}, -- Gloves of Unfailing Faith
                {6, 32328}, -- Botanist's Gloves of Growth
                {7, 33587}, -- Light-Blessed Bonds
                {8, 31032}, -- Thunderheart Gloves
                {9, 34902}, -- Oakleaf-Spun Handguards
                {10, 28521}, -- Mitts of the Treemender
                {11, 35022}, -- Brutal Gladiator's Kodohide Gloves
                {12, 28508}, -- Gloves of Saintly Blessings
                {13, 30217}, -- Nordrassil Gloves
                {14, 33690}, -- Vengeful Gladiator's Kodohide Gloves
                {15, 30029} -- Bark-Gloves of Ancient Wisdom
                ,
                {16, 28273}
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34554}, -- Thunderheart Belt
                {2, 21873}, -- Primal Mooncloth Belt
                {3, 33483}, -- Life-step Belt
                {4, 32519}, -- Belt of Divine Guidance
                {5, 30036}, -- Belt of the Long Road
                {6, 29984}, -- Girdle of Zaetar
                {7, 33480}, -- Cord of Braided Troll Hair
                {8, 30675}, -- Lurker's Cord of Healing
                {9, 29524}, -- Windhawk Belt
                {10, 34793}, -- Cord of Reconstruction
                {11, 35154}, -- Guardian's Kodohide Belt
                {12, 30895}, -- Angelista's Sash
                {13, 32339}, -- Belt of Primal Majesty
                {14, 33885}, -- Vindicator's Kodohide Belt
                {15, 30675} -- Lurker's Cord of the Prophet
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 29309}, -- Band of the Eternal Restorer
                {2, 35733}, -- Ring of Harmonic Beauty
                {3, 30110}, -- Coral Band of the Revived
                {4, 34166}, -- Band of Lucent Beams
                {5, 32528}, -- Blessed Band of Karabor
                {6, 34890}, -- Anveena's Touch
                {7, 29308}, -- Band of Eternity (revered)
                {8, 34363}, -- Ring of Flowing Life
                {9, 30736}, -- Ring of Flowing Light
                {10, 34625}, -- Kharmaa's Ring of Fate
                {11, 28763}, -- Jade Ring of the Everliving
                {12, 35283}, -- Sin'dorei Band of Salvation
                {13, 32238}, -- Ring of Calming Waves
                {14, 33498}, -- Signet of the Quiet Forest
                {15, 29306} -- Band of Eternity (honored)
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34384}, -- Breeches of Natural Splendor
                {2, 34170}, -- Pantaloons of Calming Strife
                {3, 30912}, -- Leggings of Eternity
                {4, 32271}, -- Kilt of Immortal Nature
                {5, 30727}, -- Gilded Trousers of Benediction
                {6, 34901}, -- Grovewalker's Leggings
                {7, 34925}, -- Adorned Supernal Legwraps
                {8, 33552}, -- Pants of Splendid Recovery
                {9, 31045}, -- Thunderheart Legguards
                {10, 28591}, -- Earthsoul Leggings
                {11, 28742}, -- Pantaloons of Repentance
                {12, 30543}, -- Pontifex Kilt
                {13, 30220}, -- Nordrassil Life-Kilt
                {14, 24261}, -- Whitemend Pants
                {15, 35024} -- Brutal Gladiator's Kodohide Legguards
                ,
                {16, 24276},
                {17, 24275},
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 30737}, -- Gold-Leaf Wildboots
                {2, 34571}, -- Thunderheart Boots
                {3, 32609}, -- Boots of the Divine Light
                {4, 30092}, -- Orca-Hide Boots
                {5, 34926}, -- Slippers of Dutiful Mending
                {6, 30100}, -- Soul-Strider Boots
                {7, 33471}, -- Two-toed Sandals
                {8, 30680}, -- Glider's Foot-Wraps of Healing
                {9, 28752}, -- Forestlord Striders
                {10, 34707}, -- Boots of Resuscitation
                {11, 30885}, -- Archbishop's Slippers
                {12, 30886}, -- Enchanted Leather Sandals
                {13, 35139}, -- Guardian's Kodohide Boots
                {14, 30035}, -- Boots of the Long Road
                {15, 27411} -- Slippers of Serenity
                ,
                {16, 28280}
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
                {5, 23047}, -- Eye of the Dead
                {6, 25634}, -- Oshu'gun Relic
                {7, 34050}, -- Battlemaster's Perseverance
                {8, 34580}, -- Battlemaster's Perseverance
                {9, 30841}, -- Lower City Prayerbook
                {10, 33828}, -- Tome of Diabolic Remedy
                {11, 28590}, -- Ribbon of Sacrifice
                {12, 19395}, -- Rejuvenating Gem
                {13, 28190}, -- Scarab of the Infinite Cycle
                {14, 28823}, -- Eye of Gruul
                {15, 24390} -- Auslese's Light Channeler
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
                {5, 34896}, -- Gavel of Naaru Blessings
                {6, 33743}, -- Vengeful Gladiator's Salvation
                {7, 30108}, -- Lightfathom Scepter
                {8, 30918}, -- Hammer of Atonement
                {9, 33468}, -- Dark Blessing
                {10, 32964}, -- Merciless Gladiator's Salvation
                {11, 28771}, -- Light's Justice
                {12, 32451}, -- Gladiator's Salvation
                {13, 28522}, -- Shard of the Virtuous
                {14, 23556}, -- Hand of Eternity
                {15, 29353} -- Shockwave Truncheon
                ,
                {16, 28281},
                {17, 19448}
            }
        },
        {
            -- T2
            name = format(AL["Offhand"], "2"),
            [NORMAL_DIFF] = {
                {1, 30911}, -- Scepter of Purification
                {2, 35074}, -- Brutal Gladiator's Reprieve
                {3, 34206}, -- Book of Highborne Hymns
                {4, 29274}, -- Tears of Heaven
                {5, 32350}, -- Touch of Inspiration
                {6, 29170}, -- Windcaller's Orb
                {7, 33736}, -- Vengeful Gladiator's Reprieve
                {8, 29923}, -- Talisman of the Sun King
                {9, 33325}, -- Voodoo Shaker
                {10, 32961}, -- Merciless Gladiator's Reprieve
                {11, 23048}, -- Sapphiron's Right Eye
                {12, 27477}, -- Faol's Signet of Cleansing
                {13, 28728}, -- Aran's Soothing Sapphire
                {14, 23029}, -- Noth's Frigid Heart
                {15, 28213} -- Lordaeron Medical Guide
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
                {7, 34608}, -- Rod of the Blazing Light
                {8, 28782}, -- Crystalheart Pulse-Staff
                {9, 28604}, -- Nightstaff of the Everliving
                {10, 22632}, -- Atiesh, Greatstaff of the Guardian
                {11, 27791}, -- Serpentcrest Life-Staff
                {12, 29133}, -- Seer's Cane
                {13, 28033}, -- Epoch-Mender
                {14, 31289}, -- Staff of Divine Infusion
                {15, 31417} -- Staff of the Ashtongue Deathsworn
                ,
                {16, 28281},
                {17, 19448}
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
