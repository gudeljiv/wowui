RXPGuides.RegisterGuide([[
#classic
#version 1
<< Horde
#group Custom Quests for RXP
#subgroup SoD Level 40 Quest Stacking
#name 40-1-How to Use this Guide
#displayname 1-How to Use this Guide
#next 40-2-Pre-Launch Collection Guide

-- |cRXP_FRIENDLY_, |cRXP_ENEMY_, |cRXP_LOOT_, |cRXP_WARN_, |cRXP_PICK_, |cRXP_BUY_
-- |c99ffff99 OR|r
-- |Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk

step
    >>Welcome to the |cRXP_WARN_SoD Level 40|r Quest Stacking Guide!
    +Use the Collection Guide to complete pre-req quests and gather items for launch day.
    +|cRXP_WARN_ON LAUNCH DAY|r, use the Turn-in Guide.
]])

RXPGuides.RegisterGuide([[
#classic
#version 1
<< Horde
#group Custom Quests for RXP
#subgroup SoD Level 40 Quest Stacking
#name 40-2-Pre-Launch Collection Guide
#displayname 2-Pre-Launch Collection Guide
#next 40-3-Launch Day Turn-in Route

step
    .maxlevel 39
    >>|cRXP_WARN_NOTE|r: This guide is for |cRXP_WARN_HIGHER LEVEL|r characters.
    .xp 40
step
    >>|cRXP_WARN_LEVEL 40 HORDE QUEST STACK|r
    >>There is |cRXP_PICK_NO RXP|r Horde collection guide for Phase 3.
    +Use the Google Sheet and Weak Aura available through:
    .link https://www.patreon.com/joardee >>Joardee's Patreon
]])

RXPGuides.RegisterGuide([[
#classic
#version 2
<< Horde
#group Custom Quests for RXP
#subgroup SoD Level 40 Quest Stacking
#name 40-3-Launch Day Turn-in Route
#displayname 3-Launch Day Turn-in Route

step
    #sticky
    +|cRXP_WARN_WARNING: ONLY LOAD THIS GUIDE ON LAUNCH DAY, DO NOT ACCIDENTALLY TURN IN YOUR PRE QUESTS|r
step
    >>|cRXP_WARN_LEVEL 40 HORDE QUEST STACK|r
    >>This is a community guide that may have ERRORS. I don't have a Horde character to test this route.
    >>I recommend testing on the PTR prior to Phase 3 launch.
    +|cRXP_PICK_I understand|r
step
    .isOnQuest 208
    .goto Stranglethorn Vale,35.6,10.8
    .target Hemet Nesingwary
    >>Talk to |cRXP_FRIENDLY_Hemet Nesingwary|r at Nessingwary's Expedition
    .turnin 208 >>Turn in Big Game Hunter
step
    .goto Stranglethorn Vale,35.6,10.6
    .target Barnil Stonepot
    >>Talk to |cRXP_FRIENDLY_Barnil Stonepot|r at Nessingwary's Expedition
    .accept 338 >>Accept The Green Hills of Stranglethorn
step
    .isOnQuest 338
    .goto Stranglethorn Vale,35.6,10.6
    .target Barnil Stonepot
    >>Talk to |cRXP_FRIENDLY_Barnil Stonepot|r at Nessingwary's Expedition
    .turnin 338 >>Turn in The Green Hills of Stranglethorn
step
    .isOnQuest 591
    .goto Stranglethorn Vale,32.2,27.8
    .target Kin'weelay
    >>Talk to |cRXP_FRIENDLY_Kin'weelay|r in Grom'gol Base Camp
    .turnin 591 >>Turn in The Mind's Eye
step
    .fly Booty Bay
    .goto Stranglethorn Vale,32.6,29.2
    .target Thysta
step
    .isOnQuest 348
    .goto Stranglethorn Vale,27.6,76.8
    .target Fin Fizracket
    >>Talk to |cRXP_FRIENDLY_Fin Fizracket|r in Booty Bay
    .turnin 348 >>Turn in Stranglethorn Fever
step
    .isOnQuest 608
    .goto Stranglethorn Vale,27.2,77.0
    .target Fleet Master Seahorn
    >>Talk to |cRXP_FRIENDLY_Fleet Master Seahorn|r in Booty Bay
    .turnin 608 >>Turn in The Bloodsail Buccaneers
step
    .isOnQuest 2767
    .goto Stranglethorn Vale,28.2,76.2
    .target Oglethorpe Obnoticus
    >>Talk to |cRXP_FRIENDLY_Oglethorpe Obnoticus|r in Booty Bay
    .turnin 2767 >>Turn in Rescue OOX-22/FE!
step
    .isOnQuest 580
    .goto Stranglethorn Vale,27.0,77.4
    .target Whiskey Slim
    >>Talk to |cRXP_FRIENDLY_Whiskey Slim|r in Booty Bay
    .turnin 580 >>Turn in Whiskey Slim's Lost Grog
step
    .isQuestTurnedIn 606
    .goto Stranglethorn Vale,26.8,73.6
    .target "Shaky" Phillipe
    >>Talk to |cRXP_FRIENDLY_"Shaky" Phillipe|r in Booty Bay
    .accept 607 >>Accept Return to MacKinley
step
    .isOnQuest 607
    .goto Stranglethorn Vale,27.8,77.0
    .target "Sea Wolf" MacKinley
    >>Talk to |cRXP_FRIENDLY_"Sea Wolf" MacKinley|r in Booty Bay
    .turnin 607 >>Turn in Return to MacKinley
step
    .isOnQuest 613
    .goto Stranglethorn Vale,27.8,77.0
    .target "Sea Wolf" MacKinley
    >>Talk to |cRXP_FRIENDLY_"Sea Wolf" MacKinley|r in Booty Bay
    .turnin 613 >>Turn in Cracking Maury's Foot
step
    .isOnQuest 2874
    .goto Stranglethorn Vale,27.8,77.0
    .target "Sea Wolf" MacKinley
    >>Talk to |cRXP_FRIENDLY_"Sea Wolf" MacKinley|r in Booty Bay
    .turnin 2874 >>Turn in Deliver to MacKinley
step
    .itemcount 3985,1
    >>Use the Monogrammed Sash to Accept the quest
    .use 3985
    .accept 8552 >>Accept The Monogrammed Sash
    .goto Stranglethorn Vale,26.6,73.6
step
    .isOnQuest 8552
    .goto Stranglethorn Vale,26.6,73.6
    .target Captain Hecklebury Smotts
    >>Talk to |cRXP_FRIENDLY_Captain Hecklebury Smotts|r in Booty Bay
    .turnin 8552 >>Turn in The Monogrammed Sash
step
    .isOnQuest 621
    .goto Stranglethorn Vale,27.0,77.2
    .target Crank Fizzlebub
    >>Talk to |cRXP_FRIENDLY_Crank Fizzlebub|r in Booty Bay
    .turnin 621 >>Turn in Zanzil's Secret
step
    .isOnQuest 617
    .goto Stranglethorn Vale,27.4,76.8
    .target Privateer Bloads
    >>Talk to |cRXP_FRIENDLY_Privateer Bloads|r in Booty Bay
    .turnin 617 >>Turn in Akiris by the Bundle
step
    .isQuestTurnedIn 621
    .isQuestTurnedIn 1118
    .goto Stranglethorn Vale,27.0,77.2
    .target Crank Fizzlebub
    >>Talk to |cRXP_FRIENDLY_Crank Fizzlebub|r in Booty Bay
    .accept 1119 >>Accept Zanzil's Mixture and a Fool's Stout
step
    .goto Stranglethorn Vale,27.0,77.2
    .target Krazek
    >>Talk to |cRXP_FRIENDLY_Krazek|r in Booty Bay
    .accept 2864 >>Accept Tran'rek
step
    .zone 226 >>Use the Booty Bay transporter to Gnomeregan
step
    .itemcount 9308,1
    .target The Sparklematic 5200
    >>Click |cRXP_FRIENDLY_The Sparklematic 5200|r inside Gnomeregan
    .accept 80161 >>Accept The Sparklematic 5200!
    .turnin 80161 >>Turn in The Sparklematic 5200!
step
    .itemcount 216661,1
    >>Use the Grime-Encrusted Ring to Accept the quest
    .use 216661
    .accept 79986 >>Accept Grime-Encrusted Ring
step
    .isOnQuest 79986
    .target The Sparklematic 5200
    >>Click |cRXP_FRIENDLY_The Sparklematic 5200|r inside Gnomeregan
    .turnin 79986 >>Turn in Grime-Encrusted Ring
step
    .itemcount 216662,1
    .target The Sparklematic 5200
    >>Click |cRXP_FRIENDLY_The Sparklematic 5200|r inside Gnomeregan
    .accept 80140 >>Accept Return of the Ring
step
    .target Kernobee
    >>[OPTIONAL] Talk to |cRXP_FRIENDLY_Kernobee|r inside Gnomeregan
    .accept 79985 >>Accept A Fine Mess
step
    .target Kernobee
    >>[OPTIONAL] Escort |cRXP_FRIENDLY_Kernobee|r to the Clockwerk Run exit
    .complete 79985,1 >>A Fine Mess
step
    .zone Undercity >>Teleport to Undercity
step
    .isOnQuest 3341
    .goto Undercity,74.0,32.8
    .target Andrew Brownell
    >>Talk to |cRXP_FRIENDLY_Andrew Brownell|r in The Magic Quarter
    .turnin 3341 >>Turn in Bring the End
step
    .goto Undercity,71.8,29.0
    .target Ralston Farnsley
    >>Talk to |cRXP_FRIENDLY_Ralston Farnsley|r in Undercity
    .turnin 7813 >>Turn in A Donation of Wool
    .turnin 7814 >>Turn in A Donation of Silk
    .turnin 7817 >>Turn in A Donation of Mageweave
step
    .isOnQuest 2342
    .goto Undercity,62.6,48.6
    .target Patrick Garrett
    >>Talk to |cRXP_FRIENDLY_Patrick Garrett|r in Undercity
    .turnin 2342 >>Turn in Reclaimed Treasures
step
    .goto Undercity,65.8,46.2
    .target William Montague
    >>Talk to |cRXP_FRIENDLY_William Montague|r in Undercity
    .bankwithdraw 17008,3829,4389,929,3823,2868,3404,4611,6196,18972,9370,217281 >>Withdraw any needed items from your bank
step
    .isQuestTurnedIn 232
    .goto Undercity,58.6,55.2
    .target Alessandro Luca
    >>Talk to |cRXP_FRIENDLY_Alessandro Luca|r in The Apothecarium
    .accept 238 >>Accept Errand for Apothecary Zinge
step
    .isOnQuest 238
    .goto Undercity,50.0,68.6
    .target Apothecary Zinge
    >>Talk to |cRXP_FRIENDLY_Apothecary Zinge|r in The Apothecarium
    .turnin 238 >>Turn in Errand for Apothecary Zinge
step
    .isQuestTurnedIn 238
    .goto Undercity,50.0,68.6
    .target Apothecary Zinge
    >>Talk to |cRXP_FRIENDLY_Apothecary Zinge|r in The Apothecarium
    .accept 243 >>Accept Into the Field
step
    .isOnQuest 736
    .goto Undercity,54.4,55.6
    .target Keeper Bel'dugur
    >>Talk to |cRXP_FRIENDLY_Keeper Bel'dugur|r in The Apothecarium
    .turnin 736 >>Turn in The Star, the Hand, and the Heart
step
    .goto Undercity,54.4,55.6
    .target Keeper Bel'dugur
    >>Talk to |cRXP_FRIENDLY_Keeper Bel'dugur|r in The Apothecarium
    .accept 737 >>Accept Forbidden Knowledge
step
    .isOnQuest 1048
    .goto Undercity,56.6,92.6
    .target Varimathras
    >>Talk to |cRXP_FRIENDLY_Varimathras|r in The Apothecarium
    .turnin 1048 >>Turn in Into the Scarlet Monastery
step
    .itemcount 17008,1
    >>Use the Small Scroll to Accept the quest
    .use 17008
    .accept 6522 >>Accept An Unholy Alliance
    .goto Undercity,56.6,92.6
step
    .isOnQuest 6522
    .goto Undercity,56.6,92.6
    .target Varimathras
    >>Talk to |cRXP_FRIENDLY_Varimathras|r in Undercity
    .turnin 6522 >>Turn in An Unholy Alliance
step
    .fly Hammerfall
    .goto Undercity,63.6,48.6
    .target Michael Garrett
step
    .isOnQuest 646
    .goto Arathi Highlands,73.8,33.8
    .target Zengu
    >>Talk to |cRXP_FRIENDLY_Zengu|r in Hammerfall
    .turnin 646 >>Turn in Trol'kalar
step
    .isQuestTurnedIn 701
    .goto Arathi Highlands,74.6,36.4
    .target Tor'gan
    >>Talk to |cRXP_FRIENDLY_Tor'gan|r in Hammerfall
    .accept 702 >>Accept Guile of the Raptor
step
    .isOnQuest 702
    .goto Arathi Highlands,72.6,34.0
    .target Gor'mul
    >>Talk to |cRXP_FRIENDLY_Gor'mul|r in Hammerfall
    .turnin 702 >>Turn in Guile of the Raptor
step
    .goto Arathi Highlands,72.6,34.0
    .target Gor'mul
    >>Talk to |cRXP_FRIENDLY_Gor'mul|r in Hammerfall
    .accept 847 >>Accept Guile of the Raptor
step
    .isOnQuest 847
    .goto Arathi Highlands,74.6,36.4
    .target Tor'gan
    >>Talk to |cRXP_FRIENDLY_Tor'gan|r in Hammerfall
    .turnin 847 >>Turn in Guile of the Raptor
step
    .isOnQuest 656
    .goto Arathi Highlands,62.5,33.8
    .target Shards of Myzrael
    >>Click the |cRXP_FRIENDLY_Shards of Myzrael|r in Arathi Highlands
    .turnin 656 >>Turn in Summoning the Princess
step
    .fly Kargath
    .goto Arathi Highlands,73.0,32.6
    .target Urda
step
    .isOnQuest 793
    .goto Badlands,2.8,45.8
    .target Gorn
    >>Talk to |cRXP_FRIENDLY_Gorn|r in Kargath
    .turnin 793 >>Turn in Broken Alliances
step
    .isOnQuest 2203
    .goto Badlands,2.6,46.0
    .target Jarkal Mossmeld
    >>Talk to |cRXP_FRIENDLY_Jarkal Mossmeld|r in Kargath
    .turnin 2203 >>Turn in Badlands Reagent Run II
step
    .isQuestTurnedIn 2339
    .goto Badlands,2.6,46.0
    .target Jarkal Mossmeld
    >>Talk to |cRXP_FRIENDLY_Jarkal Mossmeld|r in Kargath
    .accept 2340 >>Accept Deliver the Gems
step
    .isQuestTurnedIn 1418
    .goto Badlands,6.4,47.0
    .target Neeka Bloodscar
    >>Talk to |cRXP_FRIENDLY_Neeka Bloodscar|r in Kargath
    .accept 1420 >>Accept Report to Helgrum
step
    .itemcount 3829,1
    .goto Badlands,26.0,45.8
    .target Lotwil Veriatus
    >>Talk to |cRXP_FRIENDLY_Lotwil Veriatus|r in the Badlands
    .accept 713 >>Accept Coolant Heads Prevail
    .turnin 713 >>Turn in Coolant Heads Prevail
step
    .itemcount 4389,1
    .goto Badlands,26.0,45.8
    .target Lotwil Veriatus
    >>Talk to |cRXP_FRIENDLY_Lotwil Veriatus|r in the Badlands
    .accept 714 >>Accept Gyro... What?
    .turnin 714 >>Turn in Gyro... What?
step
    .itemcount 929,1
    .itemcount 3823,1
    .isQuestTurnedIn 712
    .goto Badlands,25.8,44.6
    .target Lucien Tosselwrench
    >>Talk to |cRXP_FRIENDLY_Lucien Tosselwrench|r in the Badlands
    .accept 715 >>Accept Liquid Stone
    .turnin 715 >>Turn in Liquid Stone
step
    .itemcount 2868,1
    .isQuestTurnedIn 712
    .goto Badlands,25.8,44.6
    .target Lucien Tosselwrench
    >>Talk to |cRXP_FRIENDLY_Lucien Tosselwrench|r in the Badlands
    .accept 716 >>Accept Stone Is Better than Cloth
    .turnin 716 >>Turn in Stone Is Better than Cloth
step
    .isQuestTurnedIn 714
    .isQuestTurnedIn 712
    .goto Badlands,26.0,45.8
    .target Lotwil Veriatus
    >>Talk to |cRXP_FRIENDLY_Lotwil Veriatus|r in the Badlands
    .accept 734 >>Accept This Is Going to Be Hard
step
    .isOnQuest 734
    .goto Badlands,25.8,44.6
    .target Lucien Tosselwrench
    >>Talk to |cRXP_FRIENDLY_Lucien Tosselwrench|r in the Badlands
    .turnin 734 >>Turn in This Is Going to Be Hard
step
    .isQuestTurnedIn 734
    .goto Badlands,25.8,44.6
    .target Lucien Tosselwrench
    >>Talk to |cRXP_FRIENDLY_Lucien Tosselwrench|r in the Badlands
    .accept 777 >>Accept This Is Going to Be Hard
step
    .isOnQuest 777
    .goto Badlands,26.0,45.8
    .target Lotwil Veriatus
    >>Talk to |cRXP_FRIENDLY_Lotwil Veriatus|r in the Badlands
    .turnin 777 >>Turn in This Is Going to Be Hard
step
    .itemcount 3404,4
    .goto Badlands,42.4,52.8
    .target Rigglefuzz
    >>Talk to |cRXP_FRIENDLY_Rigglefuzz|r in the Badlands
    .accept 703 >>Accept Barbecued Buzzard Wings
    .turnin 703 >>Turn in Barbecued Buzzard Wings
step
    .itemcount 4611,9
    .goto Badlands,42.4,52.8
    .target Rigglefuzz
    >>Talk to |cRXP_FRIENDLY_Rigglefuzz|r in the Badlands
    .accept 705 >>Accept Pearl Diving
    .turnin 705 >>Turn in Pearl Diving
step
    .isOnQuest 2418
    .goto Badlands,42.4,52.8
    .target Rigglefuzz
    >>Talk to |cRXP_FRIENDLY_Rigglefuzz|r in the Badlands
    .turnin 2418 >>Turn in Power Stones
step
    .isOnQuest 737
    .goto Badlands,51.4,76.8
    .target Theldurin the Lost
    >>Talk to |cRXP_FRIENDLY_Theldurin the Lost|r in the Badlands
    .turnin 737 >>Turn in Forbidden Knowledge
step
    .isQuestTurnedIn 1108
    .goto Badlands,42.2,52.6
    .target Martek the Exiled
    >>Talk to |cRXP_FRIENDLY_Martek the Exiled|r in the Badlands
    .accept 1137 >>Accept News for Fizzle
.fly Stonard
    .goto Badlands,4.0,44.8
    .target Gorrik
step
    .isOnQuest 1420
    .goto Swamp of Sorrows,47.8,55.2
    .target Helgrum the Swift
    >>Talk to |cRXP_FRIENDLY_Helgrum the Swift|r in Stonard
    .turnin 1420 >>Turn in Report to Helgrum
step
    .isOnQuest 1430
    .goto Swamp of Sorrows,44.8,57.2
    .target Dar
    >>Talk to |cRXP_FRIENDLY_Dar|r in Stonard
    .turnin 1430 >>Turn in Fresh Meat
step
    .isOnQuest 1424
    .goto Swamp of Sorrows,48.0,55.0
    .target Fel'zerul
    >>Talk to |cRXP_FRIENDLY_Fel'zerul|r in Stonard
    .turnin 1424 >>Turn in Pool of Tears
step
    .isOnQuest 1418
    .goto Swamp of Sorrows,47.8,55.2
    .target Helgrum the Swift
    >>Talk to |cRXP_FRIENDLY_Helgrum the Swift|r in Stonard
    .accept 1418 >>Accept Neeka Bloodscar
step
    .isOnQuest 1426
    .goto Swamp of Sorrows,83.6,80.6
    .target Katar
    >>Talk to |cRXP_FRIENDLY_Katar|r in Swamp of Sorrows
    .turnin 1426 >>Turn in Threat from the Sea
step
    .isQuestTurnedIn 1426
    .goto Swamp of Sorrows,83.6,80.6
    .target Katar
    >>Talk to |cRXP_FRIENDLY_Katar|r in Swamp of Sorrows
    .accept 1427 >>Accept Threat from the Sea
step
    .isOnQuest 1427
    .goto Swamp of Sorrows,81.4,80.8
    .target Tok'Kar
    >>Talk to |cRXP_FRIENDLY_Tok'Kar|r in Swamp of Sorrows
    .turnin 1427 >>Turn in Threat from the Sea
step
    .itemcount 6196,1
    >>Use the Noboru's Cudgel to Accept the quest
    .use 6196
    .accept 1392 >>Accept Noboru the Cudgel
    .goto Swamp of Sorrows,26.0,31.6
step
    .isOnQuest 1392
    .goto Swamp of Sorrows,26.0,31.6
    .target Magtoor
    >>Talk to |cRXP_FRIENDLY_Magtoor|r in Swamp of Sorrows
    .turnin 1392 >>Turn in Noboru the Cudgel
step
    #completewith next
    .zone Deadwind Pass >>Head to Deadwind Pass
step
    .goto Deadwind Pass,52.0,34.6
    .target Dalaran Agent
    >>Talk to the |cRXP_FRIENDLY_Dalaran Agent|r 
    +Turn in any Dalaran Relics you have.
step
    .hs >>Hearth to Camp Mojache, Feralas
step
    .isOnQuest 3128
    .goto Feralas,74.4,43.4
    .target Witch Doctor Uzer'i
    >>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r in Camp Mojache
    .turnin 3128 >>Turn in Natural Materials
step
    .isOnQuest 3127
    .goto Feralas,74.4,43.4
    .target Witch Doctor Uzer'i
    >>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r in Camp Mojache
    .turnin 3127 >>Turn in Mountain Giant Muisek
step
    .isQuestTurnedIn 3127
    .isQuestTurnedIn 3128
    .goto Feralas,74.4,43.4
    .target Witch Doctor Uzer'i
    >>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r in Camp Mojache
    .accept 3129 >>Accept Weapons of Spirit
step
    .isOnQuest 3129
    .goto Feralas,74.4,43.4
    .target Witch Doctor Uzer'i
    >>Talk to |cRXP_FRIENDLY_Witch Doctor Uzer'i|r in Camp Mojache
    .turnin 3129 >>Turn in Weapons of Spirit
step
    .itemcount 18972,1
    >>Use the Perfect Yeti Hide to Accept the quest
    .use 18972
    .accept 7738 >>Accept Perfect Yeti Hide
    .goto Feralas,74.4,42.8
step
    .isOnQuest 7738
    .goto Feralas,74.4,42.8
    .target Jangdor Swiftstrider
    >>Talk to |cRXP_FRIENDLY_Jangdor Swiftstrider|r in Camp Mojache
    .turnin 7738 >>Turn in Perfect Yeti Hide
step
    .itemcount 9370,1
    >>Use the Gordunni Scroll to Accept the quest
    .use 9370
    .accept 2978 >>Accept The Gordunni Scroll
    .goto Feralas,74.4,44.0
step
    .isOnQuest 2978
    .goto Feralas,74.4,44.0
    .target Rok Orhan
    >>Talk to |cRXP_FRIENDLY_Rok Orhan|r in Camp Mojache
    .turnin 2978 >>Turn in The Gordunni Scroll
step
    .isOnQuest 7734
    .goto Feralas,74.4,42.8
    .target Jangdor Swiftstrider
    >>Talk to |cRXP_FRIENDLY_Jangdor Swiftstrider|r in Camp Mojache
    .turnin 7734 >>Turn in The Mark of Quality
step
    .isOnQuest 7731
    .goto Feralas,74.8,42.6
    .target Hadoken Swiftstrider
    >>Talk to |cRXP_FRIENDLY_Hadoken Swiftstrider|r in Camp Mojache
    .turnin 7731 >>Turn in Stinglasher
step
    .isOnQuest 2974
    .goto Feralas,76.0,42.8
    .target Krueg Skullsplitter
    >>Talk to |cRXP_FRIENDLY_Krueg Skullsplitter|r in Camp Mojache
    .turnin 2974 >>Turn in A Grim Discovery
step
    .isOnQuest 7730
    .goto Feralas,74.8,42.6
    .target Hadoken Swiftstrider
    >>Talk to |cRXP_FRIENDLY_Hadoken Swiftstrider|r in Camp Mojache
    .turnin 7730 >>Turn in Zukk'ash Infestation
step
    .isOnQuest 2980
    .goto Feralas,74.4,44.0
    .target Rok Orhan
    >>Talk to |cRXP_FRIENDLY_Rok Orhan|r in Camp Mojache
    .turnin 2980 >>Turn in The Ogres of Feralas
step
    .isOnQuest 2987
    .goto Feralas,75.6,44.2
    .target Orwin Gizzmick
    >>Talk to |cRXP_FRIENDLY_Orwin Gizzmick|r in Camp Mojache
    .turnin 2987 >>Turn in Gorunnni Cobolt
step
    .isQuestTurnedIn 7730
    .isQuestTurnedIn 7731
    .goto Feralas,74.8,42.6
    .target Hadoken Swiftstrider
    >>Talk to |cRXP_FRIENDLY_Hadoken Swiftstrider|r in Camp Mojache
    .accept 7732 >>Accept Zukk'ash Report
step
    .fly Brackenwall Village
    .goto Feralas,75.4,44.2
    .target Shyn
step
    .isOnQuest 1169
    .goto Dustwallow Marsh,37.0,33.0
    .target Draz'Zilb
    >>Talk to |cRXP_FRIENDLY_Draz'Zilb|r in Brackenwall Village
    .turnin 1169 >>Turn in Identifying the Brood
step
    .isQuestTurnedIn 1169
    .goto Dustwallow Marsh,37.0,33.0
    .target Draz'Zilb
    >>Talk to |cRXP_FRIENDLY_Draz'Zilb|r in Brackenwall Village
    .accept 1170 >>Accept The Brood of Onyxia
step
    .isOnQuest 1170
    .goto Dustwallow Marsh,36.2,31.6
    .target Overlord Mok'Morokk
    >>Talk to |cRXP_FRIENDLY_Overlord Mok'Morokk|r in Brackenwall Village
    .turnin 1170 >>Turn in The Brood of Onyxia
step
    .isQuestTurnedIn 1170
    .goto Dustwallow Marsh,36.2,31.6
    .target Overlord Mok'Morokk
    >>Talk to |cRXP_FRIENDLY_Overlord Mok'Morokk|r in Brackenwall Village
    .accept 1171 >>Accept The Brood of Onyxia
step
    .isOnQuest 1171
    .goto Dustwallow Marsh,37.0,33.0
    .target Draz'Zilb
    >>Talk to |cRXP_FRIENDLY_Draz'Zilb|r in Brackenwall Village
    .turnin 1171 >>Turn in The Brood of Onyxia
step
    .isQuestTurnedIn 1322
    .goto Dustwallow Marsh,36.6,30.8
    .target Do'gol
    >>Talk to |cRXP_FRIENDLY_Do'gol|r in Brackenwall Village
    .accept 1323 >>Accept The Black Shield
step
    .isOnQuest 1323
    .goto Dustwallow Marsh,36.4,31.8
    .target Krog
    >>Talk to |cRXP_FRIENDLY_Krog|r in Brackenwall Village
    .turnin 1323 >>Turn in The Black Shield
step
    .isQuestTurnedIn 1323
    .goto Dustwallow Marsh,36.4,31.8
    .target Krog
    >>Talk to |cRXP_FRIENDLY_Krog|r in Brackenwall Village
    .accept 1276 >>Accept The Black Shield
step
    .isOnQuest 1166
    .goto Dustwallow Marsh,36.2,31.6
    .target Overlord Mok'Morokk
    >>Talk to |cRXP_FRIENDLY_Overlord Mok'Morokk|r in Brackenwall Village
    .turnin 1166 >>Turn in Overlord Mok'Morokk's Concern
step
    .isOnQuest 1168
    .goto Dustwallow Marsh,37.2,31.4
    .target Tharg
    >>Talk to |cRXP_FRIENDLY_Tharg|r in Brackenwall Village
    .turnin 1168 >>Turn in Army of the Black Dragon
step
    .goto Dustwallow Marsh,35.2,30.6
    .target Nazeer Bloodpike
    >>Talk to |cRXP_FRIENDLY_Nazeer Bloodpike|r in Brackenwall Village
    .accept 1262 >>Accept Report to Zor
step
    .itemcount 217281,1
    .goto Dustwallow Marsh,55.4,26.2
    .target "Swamp Eye" Jarl
    >>Talk to |cRXP_FRIENDLY_"Swamp Eye" Jarl|r in Dustwallow Marsh
    .accept 81570 >>Accept Jarl Needs a Blade
    .turnin 81570 >>Turn in Jarl Needs a Blade
step
    .goto Dustwallow Marsh,29.7,47.7
    .target Hoofprints
    >>Click the |cRXP_FRIENDLY_Hoofprints|r in Dustwallow Marsh
    .accept 1268 >>Accept Suspicious Hoofprints
step
    .goto Dustwallow Marsh,29.8,48.2
    .target Theramore Guard Badge
    >>Click the |cRXP_FRIENDLY_Theramore Guard Badge|r in Dustwallow Marsh
    .accept 1269 >>Accept Lieutenant Pavel Reethe
step
    .isOnQuest 1268
    .goto Dustwallow Marsh,36.4,31.8
    .target Krog
    >>Talk to |cRXP_FRIENDLY_Krog|r in Brackenwall Village
    .turnin 1268 >>Turn in Suspicious Hoofprints
step
    .isOnQuest 1269
    .goto Dustwallow Marsh,36.4,31.8
    .target Krog
    >>Talk to |cRXP_FRIENDLY_Krog|r in Brackenwall Village
    .turnin 1269 >>Turn in Lieutenant Pavel Reethe
step
    .fly Thunder Bluff
    .goto Dustwallow Marsh,35.6,31.8
    .target Shardi
step
    .isOnQuest 2280
    .goto Thunder Bluff,34.8,47.8
    .target Sage Truthseeker
    >>Talk to |cRXP_FRIENDLY_Sage Truthseeker|r in Thunder Bluff
    .turnin 2280 >>Turn in The Platinum Discs
step
    .isQuestTurnedIn 2280
    .goto Thunder Bluff,34.8,47.8
    .target Sage Truthseeker
    >>Talk to |cRXP_FRIENDLY_Sage Truthseeker|r in Thunder Bluff
    .accept 2440 >>Accept The Platinum Discs
step
    .goto Thunder Bluff,43.8,42.2
    .target Rumstag Proudstrider
    >>Talk to |cRXP_FRIENDLY_Rumstag Proudstrider|r in Thunder Bluff
    .turnin 7820 >>Turn in A Donation of Wool
    .turnin 7821 >>Turn in A Donation of Silk
    .turnin 7822 >>Turn in A Donation of Mageweave
step
    .isOnQuest 2440
    .goto Thunder Bluff,46.8,33.6
    .target Bena Winterhoof
    >>Talk to |cRXP_FRIENDLY_Bena Winterhoof|r in Thunder Bluff
    .turnin 2440 >>Turn in The Platinum Discs
step
    .isOnQuest 1276
    .goto Thunder Bluff,54.6,80.0
    .target Mosarn
    >>Talk to |cRXP_FRIENDLY_Mosarn|r in Thunder Bluff at the Hunter Rise
    .turnin 1276 >>Turn in The Black Shield
step
    .isOnQuest 1136
    .goto Thunder Bluff,61.4,80.4
    .target Melor Stonehoof
    >>Talk to |cRXP_FRIENDLY_Melor Stonehoof|r in The Hunter Rise
    .turnin 1136 >>Turn in Frostmaw
step
    .isOnQuest 1205
    .goto Thunder Bluff,61.4,80.6
    .target Melor Stonehoof
    >>Talk to |cRXP_FRIENDLY_Melor Stonehoof|r in The Hunter Rise
    .turnin 1205 >>Turn in Deadmire
step
    .goto Thunder Bluff,47.12,57.88
    .target Chesmu
    >>Talk to |cRXP_FRIENDLY_Chesmu|r in Thunder Bluff
    .bankwithdraw 9250,8483 >>Withdraw any needed items from your bank
step
    .fly Orgrimmar
    .goto Thunder Bluff,46.8,50.0
    .target Tal
step
    .goto Orgrimmar,37.8,87.6
    .target Vehena
    >>Talk to |cRXP_FRIENDLY_Vehena|r The Valley of Spirits
    .turnin 7833 >>Turn in A Donation of Wool
    .turnin 7834 >>Turn in A Donation of Silk
    .turnin 7835 >>Turn in A Donation of Mageweave
step
    .isOnQuest 1262
    .goto Orgrimmar,39.0,38.0
    .target Zor Lonetree
    >>Talk to |cRXP_FRIENDLY_Zor Lonetree|r in The Valley of Wisdom
    .turnin 1262 >>Turn in Report to Zor
step
    .isQuestTurnedIn 1262
    .goto Orgrimmar,39.0,38.0
    .target Zor Lonetree
    >>Talk to |cRXP_FRIENDLY_Zor Lonetree|r in The Valley of Wisdom
    .accept 7541 >>Accept Service to the Horde
step
    .isOnQuest 7541
    .goto Orgrimmar,39.0,38.0
    .target Zor Lonetree
    >>Talk to |cRXP_FRIENDLY_Zor Lonetree|r in The Valley of Wisdom
    .turnin 7541 >>Turn in Service to the Horde
step
    .isOnQuest 80140
    .goto Orgrimmar,75.8,25.2
    .target Nogg
    >>Talk to |cRXP_FRIENDLY_Nogg|r in Orgrimmar
    .turnin 80140 >>Turn in Return of the Ring
step
    .isQuestTurnedIn 80140
    .goto Orgrimmar,75.8,25.2
    .target Nogg
    >>Talk to |cRXP_FRIENDLY_Nogg|r in Orgrimmar
    .accept 80141 >>Accept Nogg's Ring Redo
step
    .isOnQuest 80141
    .goto Orgrimmar,75.8,25.2
    .target Nogg
    >>Talk to |cRXP_FRIENDLY_Nogg|r in Orgrimmar
    .turnin 80141 >>Turn in Nogg's Ring Redo
step
    .isOnQuest 2340
    .goto Orgrimmar,59.4,36.8
    .target Dran Droffers
    >>Talk to |cRXP_FRIENDLY_Dran Droffers|r in Orgrimmar
    .turnin 2340 >>Turn in Deliver the Gems
step
    .isOnQuest 7732
    .goto Orgrimmar,56.6,46.4
    .target Zilzibin Drumlore
    >>Talk to |cRXP_FRIENDLY_Zilzibin Drumlore|r in Orgrimmar
    .turnin 7732 >>Turn in Zukk'ash Report
step
    .goto Orgrimmar,63.6,51.0
    .target Rashona Straglash
    >>Talk to |cRXP_FRIENDLY_Rashona Straglash|r The Drag
    .turnin 7826 >>Turn in A Donation of Wool
    .turnin 7827 >>Turn in A Donation of Silk
    .turnin 7831 >>Turn in A Donation of Mageweave
step
    .goto Orgrimmar,57.6,53.6
    .target Zamja
    >>Talk to |cRXP_FRIENDLY_Zamja|r 
    .accept 6611 >>Accept To Gadgetzan You Go!
step
    .goto Orgrimmar,49.8,70.0
    .target Karus
    >>Talk to |cRXP_FRIENDLY_Karus|r in Orgrimmar
    .bankwithdraw 9250,8483,12207,7974,8932 >>Withdraw any needed items from your bank
step
    .fly Gadgetzan
    .goto Orgrimmar,45.2,63.8
    .target Doras
step
    .isOnQuest 2781
    .goto Tanaris,52.4,28.4
    .target Chief Engineer Bilgewhizzle
    >>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r in Gadgetzan
    .turnin 2781 >>Turn in WANTED: Caliph Scorpidsting
step
    .isOnQuest 10
    .goto Tanaris,50.2,27.4
    .target Senior Surveyor Fizzledowser
    >>Talk to |cRXP_FRIENDLY_Senior Surveyor Fizzledowser|r in Gadgetzan
    .turnin 10 >>Turn in The Scrimshank Redemption
step
    .isQuestTurnedIn 113
    .goto Tanaris,50.2,27.4
    .target Senior Surveyor Fizzledowser
    >>Talk to |cRXP_FRIENDLY_Senior Surveyor Fizzledowser|r in Gadgetzan
    .accept 32 >>Accept Rise of the Silithid
step
    .isOnQuest 243
    .goto Tanaris,52.4,28.4
    .target Chief Engineer Bilgewhizzle
    >>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r in Gadgetzan
    .turnin 243 >>Turn in Into the Field
step
    .isOnQuest 2864
    .goto Tanaris,51.6,26.8
    .target Tran'rek
    >>Talk to |cRXP_FRIENDLY_Tran'rek|r in Gadgetzan
    .turnin 2864 >>Turn in Tran'rek
step
    .isQuestTurnedIn 2864
    .goto Tanaris,51.6,26.8
    .target Tran'rek
    >>Talk to |cRXP_FRIENDLY_Tran'rek|r in Gadgetzan
    .accept 2865 >>Accept Scarab Shells
step
    .itemcount 12207,12
    .itemcount 7974,10
    .itemcount 8932,20
    .goto Tanaris,52.6,28.0
    .target Dirge Quikcleave
    >>Talk to |cRXP_FRIENDLY_Dirge Quikcleave|r in Gadgetzan
    .accept 6610 >>Accept Clamlette Surprise
    .turnin 6610 >>Turn in Clamlette Surprise
step
    .isOnQuest 1691
    .goto Tanaris,52.4,28.4
    .target Chief Engineer Bilgewhizzle
    >>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r in Gadgetzan
    .turnin 1691 >>Turn in More Wastewander Justice
step
    .itemcount 8483,5
    .goto Tanaris,52.4,28.4
    .target Spigot Operator Luglunket
    >>Talk to |cRXP_FRIENDLY_Spigot Operator Luglunket|r in Gadgetzan
    .accept 1707 >>Accept Water Pouch Bounty
    .turnin 1707 >>Turn in Water Pouch Bounty
step
    .itemcount 9250,1
    >>Use the Ship Schedule to Accept the quest
    .use 9250
    .accept 2876 >>Accept Ship Schedules
    .goto Tanaris,67.0,23.8
step
    .isOnQuest 2876
    .goto Tanaris,67.0,23.8
    .target Security Chief Bilgewhizzle
    >>Talk to |cRXP_FRIENDLY_Security Chief Bilgewhizzle|r in Steamwheedle Port
    .turnin 2876 >>Turn in Ship Schedules
step
    .isOnQuest 8366
    .goto Tanaris,67.0,23.8
    .target Security Chief Bilgewhizzle
    >>Talk to |cRXP_FRIENDLY_Security Chief Bilgewhizzle|r in Steamwheedle Port
    .turnin 8366 >>Turn in Southsea Shakedown
step
    .isOnQuest 2875
    .goto Tanaris,67.0,23.8
    .target Security Chief Bilgewhizzle
    >>Talk to |cRXP_FRIENDLY_Security Chief Bilgewhizzle|r in Steamwheedle Port
    .turnin 2875 >>Turn in WANTED: Andre Firebeard
step
    .isOnQuest 8365
    .goto Tanaris,66.6,22.2
    .target Haughty Modiste
    >>Talk to |cRXP_FRIENDLY_Haughty Modiste|r in Steamwheedle Port
    .turnin 8365 >>Turn in Pirate Hats Ahoy!
step
    .isOnQuest 2873
    .goto Tanaris,67.0,23.8
    .target Stoley
    >>Talk to |cRXP_FRIENDLY_Stoley|r in Steamwheedle Port
    .turnin 2873 >>Turn in Stoley's Shipment
step
    .isQuestTurnedIn 2873
    .goto Tanaris,67.0,23.8
    .target Stoley
    >>Talk to |cRXP_FRIENDLY_Stoley|r in Steamwheedle Port
    .accept 2874 >>Accept Deliver to MacKinley
step
    .isOnQuest 3520
    .goto Tanaris,67.0,22.4
    .target Yeh'kinya
    >>Talk to |cRXP_FRIENDLY_Yeh'kinya|r in Steamwheedle Port
    .turnin 3520 >>Turn in Screecher Spirits
step
    .isQuestTurnedIn 3520
    .goto Tanaris,67.0,22.4
    .target Yeh'kinya
    >>Talk to |cRXP_FRIENDLY_Yeh'kinya|r in Steamwheedle Port
    .accept 3527 >>Accept The Prophecy of Mosh'aru
step
    .isOnQuest 1560
    .goto Tanaris,66.6,25.6
    .target Torta
    >>Talk to |cRXP_FRIENDLY_Torta|r in Steamwheedle Port
    .turnin 1560 >>Turn in Tooga's Quest
step
    .zone Thousand Needles >>Head to The Shimmering Flats
step
    .isOnQuest 1119
    .goto Thousand Needles,77.8,77.2
    .target Kravel Koalbeard
    >>Talk to |cRXP_FRIENDLY_Kravel Koalbeard|r in The Shimmering Flasts
    .turnin 1119 >>Turn in Zanzil's Mixture and a Fool's Stout
step
    .isQuestTurnedIn 1119
    .goto Thousand Needles,77.8,77.2
    .target Kravel Koalbeard
    >>Talk to |cRXP_FRIENDLY_Kravel Koalbeard|r in The Shimmering Flasts
    .accept 1120 >>Accept Get the Gnomes Drunk
step
    .isOnQuest 1120
    .goto Thousand Needles,77.6,77.0
    .target Gnome Pit Boss
    >>Talk to |cRXP_FRIENDLY_Gnome Pit Boss|r in The Shimmering Flasts
    .turnin 1120 >>Turn in Get the Gnomes Drunk
step
    .isQuestTurnedIn 1120
    .goto Thousand Needles,77.8,77.2
    .target Kravel Koalbeard
    >>Talk to |cRXP_FRIENDLY_Kravel Koalbeard|r in The Shimmering Flasts
    .accept 1122 >>Accept Report Back to Fizzlebub
step
    .isOnQuest 1137
    .goto Thousand Needles,78.0,77.0
    .target Fizzle Brassbolts
    >>Talk to |cRXP_FRIENDLY_Fizzle Brassbolts|r in The Shimmering Flasts
    .turnin 1137 >>Turn in News for Fizzle
step
    .isQuestTurnedIn 1137
    .goto Thousand Needles,80.0,75.8
    .target Pozzik
    >>Talk to |cRXP_FRIENDLY_Pozzik|r in The Shimmering Flasts
    .accept 1190 >>Accept Keeping Pace
step
    .isOnQuest 1190
    .goto Thousand Needles,77.3,77.4
    .target Rizzle's Unguarded Plans
    >>Click on |cRXP_FRIENDLY_Rizzle's Unguarded Plans|r in The Shimmering Flasts
    .turnin 1190 >>Turn in Keeping Pace
step
    .isQuestTurnedIn 1190
    .goto Thousand Needles,77.3,77.4
    .target Rizzle's Unguarded Plans
    >>Click on |cRXP_FRIENDLY_Rizzle's Unguarded Plans|r in The Shimmering Flasts
    .accept 1194 >>Accept Rizzle's Schematics
step
    .isOnQuest 1194
    .goto Thousand Needles,80.0,75.8
    .target Pozzik
    >>Talk to |cRXP_FRIENDLY_Pozzik|r in The Shimmering Flasts
    .turnin 1194 >>Turn in Rizzle's Schematics
step
    +CONGRATULATIONS!!! You have completed this route.
]])