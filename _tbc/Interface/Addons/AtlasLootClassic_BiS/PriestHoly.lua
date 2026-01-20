local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)
local AL = AtlasLoot.Locales
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local SET_CONTENT = data:AddContentType(AL["Sets"], ATLASLOOT_PVP_COLOR)

data["PriestHoly"] = {
    name = AL["Priest Holy BiS"],
    ContentType = SET_CONTENT,
    items = {
        {
            -- T1
            name = format(AL["Head"], "1"),
            [NORMAL_DIFF] = {
                {1, 34339}, -- Cowl of Light's Purity
                {2, 35181}, -- Powerheal 9000 Lens
                {3, 31063}, -- Cowl of Absolution
                {4, 32329}, -- Cowl of Benevolence
                {5, 30152}, -- Cowl of the Avatar
                {6, 32495}, -- Powerheal 4000 Lens
                {7, 29049}, -- Light-Collar of the Incarnate
                {8, 29990}, -- Crown of the Sun
                {9, 34405}, -- Helm of Arcane Purity
                {10, 33463}, -- Hood of the Third Eye
                {11, 31064}, -- Hood of Absolution
                {12, 32090}, -- Cowl of Naaru Blessings
                {13, 35054}, -- Brutal Gladiator's Mooncloth Hood
                {14, 34340}, -- Dark Conjuror's Collar
                {15, 28413} -- Hallowed Crown
            }
        },
        {
            -- T2
            name = format(AL["Neck"], "2"),
            [NORMAL_DIFF] = {
                {1, 33281}, -- Brooch of Nature's Mercy
                {2, 34360}, -- Amulet of Flowing Life
                {3, 34184}, -- Brooch of the Highborne
                {4, 32370}, -- Nadina's Pendant of Purity
                {5, 37929}, -- Guardian's Pendant of Reprieve
                {6, 28822}, -- Teeth of Gruul
                {7, 35291}, -- Sin'dorei Pendant of Salvation
                {8, 30018}, -- Lord Sanguinar's Claim
                {9, 35134}, -- Guardian's Pendant of Salvation
                {10, 35317}, -- Vindicator's Pendant of Reprieve
                {11, 28731}, -- Shining Chain of the Afterworld
                {12, 33922}, -- Vindicator's Pendant of Salvation
                {13, 30726}, -- Archaic Charm of Presence
                {14, 34359}, -- Pendant of Sunfire
                {15, 27766} -- Swampstone Necklace
            }
        },
        {
            -- T2
            name = format(AL["Shoulders"], "2"),
            [NORMAL_DIFF] = {
                {1, 34202}, -- Shawl of Wonderment
                {2, 31069}, -- Mantle of Absolution
                {3, 32273}, -- Amice of Brilliant Light
                {4, 32585}, -- Swiftheal Mantle
                {5, 30154}, -- Mantle of the Avatar
                {6, 29054}, -- Light-Mantle of the Incarnate
                {7, 28612}, -- Pauldrons of the Solace-Giver
                {8, 21874}, -- Primal Mooncloth Shoulders
                {9, 34393}, -- Shoulderpads of Knowledge's Pursuit
                {10, 35056}, -- Brutal Gladiator's Mooncloth Mantle
                {11, 27775}, -- Hallowed Pauldrons
                {12, 34210}, -- Amice of the Convoker
                {13, 30163}, -- Wings of the Avatar
                {14, 33720}, -- Vengeful Gladiator's Mooncloth Mantle
                {15, 27433} -- Pauldrons of Sufferance
            }
        },
        {
            -- T2
            name = format(AL["Back"], "2"),
            [NORMAL_DIFF] = {
                {1, 29989}, -- Sunshower Light Cloak
                {2, 32337}, -- Shroud of Forgiveness
                {3, 34205}, -- Shroud of Redeemed Souls
                {4, 32524}, -- Shroud of the Highborne
                {5, 34012}, -- Shroud of the Final Stand
                {6, 33592}, -- Cloak of Ancient Rituals
                {7, 28765}, -- Stainless Cloak of the Pure Hearted
                {8, 27946}, -- Avian Cloak of Feathers
                {9, 28582}, -- Red Riding Hood's Cloak
                {10, 28373}, -- Cloak of Scintillating Auras
                {11, 22960}, -- Cloak of Suturing
                {12, 35324}, -- Cloak of Swift Reprieve
                {13, 34242}, -- Tattered Cape of Antonidas
                {14, 31329}, -- Lifegiving Cloak
                {15, 33333} -- Kharmaa's Shroud of Hope
            }
        },
        {
            -- T2
            name = format(AL["Chest"], "2"),
            [NORMAL_DIFF] = {
                {1, 34233}, -- Robes of Faltered Light
                {2, 34365}, -- Robe of Eternal Light
                {3, 31066}, -- Vestments of Absolution
                {4, 34924}, -- Gown of Spiritual Wonder
                {5, 33203}, -- Robes of Heavenly Purpose
                {6, 30150}, -- Vestments of the Avatar
                {7, 21875}, -- Primal Mooncloth Robe
                {8, 32340}, -- Garments of Temperance
                {9, 34399}, -- Robes of Ghostly Hatred
                {10, 29050}, -- Robes of the Incarnate
                {11, 35057}, -- Brutal Gladiator's Mooncloth Robe
                {12, 28230}, -- Hallowed Garments
                {13, 34364}, -- Sunfire Robe
                {14, 33721}, -- Vengeful Gladiator's Mooncloth Robe
                {15, 34232} -- Fel Conquerer Raiments
            }
        },
        {
            -- T2
            name = format(AL["Wrist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34435}, -- Cuffs of Absolution
                {2, 30871}, -- Bracers of Martyrdom
                {3, 32513}, -- Wristbands of Divine Influence
                {4, 33589}, -- Wristguards of Tranquil Thought
                {5, 32584}, -- Swiftheal Wraps
                {6, 35174}, -- Guardian's Mooncloth Cuffs
                {7, 30684}, -- Ravager's Cuffs of the Prophet
                {8, 34434}, -- Bracers of Absolution
                {9, 32516}, -- Wraps of Purification
                {10, 28511}, -- Bands of Indwelling
                {11, 29249}, -- Bands of the Benevolent
                {12, 33901}, -- Vindicator's Mooncloth Cuffs
                {13, 30870}, -- Cuffs of Devastation
                {14, 22519}, -- Bindings of Faith
                {15, 27452} -- Light Scribe Bands
            }
        },
        {
            -- T2
            name = format(AL["Hands"], "2"),
            [NORMAL_DIFF] = {
                {1, 34342}, -- Handguards of the Dawn
                {2, 34367}, -- Hands of Eternal Light
                {3, 31060}, -- Gloves of Absolution
                {4, 30151}, -- Gloves of the Avatar
                {5, 32353}, -- Gloves of Unfailing Faith
                {6, 33587}, -- Light-Blessed Bonds
                {7, 34406}, -- Gloves of Tyri's Power
                {8, 28508}, -- Gloves of Saintly Blessings
                {9, 29055}, -- Handwraps of the Incarnate
                {10, 27536}, -- Hallowed Handwraps
                {11, 35053}, -- Brutal Gladiator's Mooncloth Gloves
                {12, 34344}, -- Handguards of Defiled Worlds
                {13, 22517}, -- Gloves of Faith
                {14, 34366}, -- Sunfire Handwraps
                {15, 24393} -- Bloody Surgeon's Mitts
            }
        },
        {
            -- T2
            name = format(AL["Waist"], "2"),
            [NORMAL_DIFF] = {
                {1, 34527}, -- Belt of Absolution
                {2, 32519}, -- Belt of Divine Guidance
                {3, 30036}, -- Belt of the Long Road
                {4, 30895}, -- Angelista's Sash
                {5, 33480}, -- Cord of Braided Troll Hair
                {6, 21873}, -- Primal Mooncloth Belt
                {7, 30675}, -- Lurker's Cord of the Prophet
                {8, 35159}, -- Guardian's Mooncloth Belt
                {9, 28652}, -- Cincture of Will
                {10, 34793}, -- Cord of Reconstruction
                {11, 34528}, -- Cord of Absolution
                {12, 27542}, -- Cord of Belief
                {13, 33900}, -- Vindicator's Mooncloth Belt
                {14, 24257}, -- Black Belt of Knowledge
                {15, 32979} -- Veteran's Mooncloth Belt
            }
        },
        {
            -- T2
            name = format(AL["Rings"], "2"),
            [NORMAL_DIFF] = {
                {1, 35733}, -- Ring of Harmonic Beauty
                {2, 34363}, -- Ring of Flowing Life
                {3, 29309}, -- Band of the Eternal Restorer
                {4, 34166}, -- Band of Lucent Beams
                {5, 32528}, -- Blessed Band of Karabor
                {6, 30110}, -- Coral Band of the Revived
                {7, 33498}, -- Signet of the Quiet Forest
                {8, 29308}, -- Band of Eternity (revered)
                {9, 32238}, -- Ring of Calming Waves
                {10, 34890}, -- Anveena's Touch
                {11, 29290}, -- Violet Signet of the Grand Restorer
                {12, 29306}, -- Band of Eternity (honored)
                {13, 29291}, -- Violet Signet
                {14, 28790}, -- Naaru Lightwarden's Band
                {15, 35130} -- Guardian's Band of Salvation
            }
        },
        {
            -- T2
            name = format(AL["Legs"], "2"),
            [NORMAL_DIFF] = {
                {1, 34170}, -- Pantaloons of Calming Strife
                {2, 34925}, -- Adorned Supernal Legwraps
                {3, 30912}, -- Leggings of Eternity
                {4, 31068}, -- Breeches of Absolution
                {5, 30153}, -- Breeches of the Avatar
                {6, 29977}, -- Star-Soul Breeches
                {7, 30727}, -- Gilded Trousers of Benediction
                {8, 28742}, -- Pantaloons of Repentance
                {9, 29053}, -- Trousers of the Incarnate
                {10, 33585}, -- Achromic Trousers of the Naaru
                {11, 30543}, -- Pontifex Kilt
                {12, 35055}, -- Brutal Gladiator's Mooncloth Leggings
                {13, 34386}, -- Pantaloons of Growing Strife
                {14, 31343}, -- Kamaei's Cerulean Skirt
                {15, 28218} -- Pontiff's Pantaloons of Prophecy
            }
        },
        {
            -- T2
            name = format(AL["Feet"], "2"),
            [NORMAL_DIFF] = {
                {1, 34562}, -- Boots of Absolution
                {2, 34926}, -- Slippers of Dutiful Mending
                {3, 30885}, -- Archbishop's Slippers
                {4, 32609}, -- Boots of the Divine Light
                {5, 30100}, -- Soul-Strider Boots
                {6, 30035}, -- Boots of the Long Road
                {7, 33471}, -- Two-toed Sandals
                {8, 28663}, -- Boots of the Incorrupt
                {9, 30680}, -- Glider's Foot-Wraps of the Prophet
                {10, 34563}, -- Treads of Absolution
                {11, 35144}, -- Guardian's Mooncloth Slippers
                {12, 29251}, -- Boots of the Pious
                {13, 25792}, -- Curate's Boots
                {14, 33902}, -- Vindicator's Mooncloth Slippers
                {15, 27411} -- Slippers of Serenity
            }
        },
        {
            -- T2
            name = format(AL["Trinkets"], "2"),
            [NORMAL_DIFF] = {
                {1, 28823}, -- Eye of Gruul
                {2, 32496}, -- Memento of Tyrande
                {3, 30665}, -- Earring of Soulful Meditation
                {4, 34430}, -- Glimmering Naaru Sliver
                {5, 28370}, -- Bangle of Endless Blessings
                {6, 29376}, -- Essence of the Martyr
                {7, 38288}, -- Direbrew Hops
                {8, 19288}, -- Darkmoon Card: Blue Dragon
                {9, 28727}, -- Pendant of the Violet Eye
                {10, 33828}, -- Tome of Diabolic Remedy
                {11, 28190}, -- Scarab of the Infinite Cycle
                {12, 30841}, -- Lower City Prayerbook
                {13, 23047}, -- Eye of the Dead
                {14, 19395}, -- Rejuvenating Gem
                {15, 25634} -- Oshu'gun Relic
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
                {6, 30108}, -- Lightfathom Scepter
                {7, 33743}, -- Vengeful Gladiator's Salvation
                {8, 30918}, -- Hammer of Atonement
                {9, 33468}, -- Dark Blessing
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
                {2, 30911}, -- Scepter of Purification
                {3, 33325}, -- Voodoo Shaker
                {4, 32350}, -- Touch of Inspiration
                {5, 35074}, -- Brutal Gladiator's Reprieve
                {6, 29923}, -- Talisman of the Sun King
                {7, 28525}, -- Signet of Unshakable Faith
                {8, 29170}, -- Windcaller's Orb
                {9, 28728}, -- Aran's Soothing Sapphire
                {10, 33736}, -- Vengeful Gladiator's Reprieve
                {11, 31493}, -- Netherwing Spiritualist's Charm
                {12, 32961}, -- Merciless Gladiator's Reprieve
                {13, 23029}, -- Noth's Frigid Heart
                {14, 28213}, -- Lordaeron Medical Guide
                {15, 29274} -- Tears of Heaven
            }
        },
        {
            -- T2
            name = format(AL["Twohand"], "2"),
            [NORMAL_DIFF] = {
                {1, 34337}, -- Golden Staff of the Sin'dorei
                {2, 30908}, -- Apostle of Argus
                {3, 32344}, -- Staff of Immaculate Recovery
                {4, 29981}, -- Ethereum Life-Staff
                {5, 33490}, -- Staff of Dark Mending
                {6, 34608}, -- Rod of the Blazing Light
                {7, 30732}, -- Exodar Life-Staff
                {8, 28782}, -- Crystalheart Pulse-Staff
                {9, 28604}, -- Nightstaff of the Everliving
                {10, 22631}, -- Atiesh, Greatstaff of the Guardian
                {11, 27791}, -- Serpentcrest Life-Staff
                {12, 29133}, -- Seer's Cane
                {13, 30012}, -- Ameer's Judgement
                {14, 31289}, -- Staff of Divine Infusion
                {15, 28033} -- Epoch-Mender
            }
        },
        {
            -- T2
            name = format(AL["Ranged"], "2"),
            [NORMAL_DIFF] = {
                {1, 34348}, -- Wand of Cleansing Light
                {2, 32363}, -- Naaru-Blessed Life Rod
                {3, 30080}, -- Luminescent Rod of the Naaru
                {4, 28588}, -- Blue Diamond Witchwand
                {5, 34985}, -- Brutal Gladiator's Baton of Light
                {6, 34059}, -- Vengeful Gladiator's Baton of Light
                {7, 27885}, -- Soul-Wand of the Aldor
                {8, 23009}, -- Wand of the Whispering Dead
                {9, 34347}, -- Wand of the Demonsoul
                {10, 24380}, -- Calming Spore Reed
                {11, 33192}, -- Carved Witch Doctor's Stick
                {12, 29779}, -- Rejuvenating Scepter
                {13, 30724}, -- Barrel-Blade Longrifle
                {14, 28783}, -- Eredar Wand of Obliteration
                {15, 27540} -- Nexus Torch
            }
        }

        --@end-version-bcc@
    }
}
