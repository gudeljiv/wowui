RXPGuides.RegisterGuide([[
#classic
#version 3
<< Horde
#group Custom Quests for RXP
#subgroup SoD Level 25 Quest Stacking
#name 25-1-How to Use this Guide
#displayname 1-How to Use this Guide
#next 25-2-Pre-Launch Collection Guide

-- |cRXP_FRIENDLY_, |cRXP_ENEMY_, |cRXP_LOOT_, |cRXP_WARN_, |cRXP_PICK_, |cRXP_BUY_
-- |c99ffff99 OR|r
-- |Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk

step
    >>Welcome to the |cRXP_WARN_SoD Level 25|r Quest Stacking Guide!
    +Use the Collection Guide to complete pre-req quests and gather items for launch day.
    +|cRXP_WARN_ON LAUNCH DAY|r, use the Turn-in Guide.
]])

RXPGuides.RegisterGuide([[
#classic
#version 3
<< Horde
#group Custom Quests for RXP
#subgroup SoD Level 25 Quest Stacking
#name 25-2-Pre-Launch Collection Guide
#displayname 2-Pre-Launch Collection Guide
#next 25-3-Launch Day Turn-in Route

step
    .maxlevel 19
    >>|cRXP_WARN_NOTE|r: This guide is for |cRXP_WARN_HIGHER LEVEL|r characters.
    .xp 20
step
    >>|cRXP_WARN_LEVEL 25 HORDE QUEST STACK|r
    >>There is |cRXP_PICK_NO RXP|r Horde collection guide for Phase 2.
    +Use the Google Sheet and Weak Aura available through:
    .link https://www.patreon.com/joardee >>Joardee's Patreon
step
    >>|cRXP_WARN_WARNING PLEASE READ CAREFULLY!!!!|r
    >>Many quest addons auto-turn-in quests (INCLUDING THIS ONE).
    >>It is your responsibility to safeguard your Launch Day quests.
    +|cRXP_PICK_I understand|r
    >>|cRXP_WARN_PRO TIP|r: Store turn-in items in the bank to prevent accidental turn-in.
step
    >>|cRXP_WARN_BEFORE PHASE 2 LAUNCH|r
    +Set your hearthstone in The Sepulcher, Silverpine Forest
    +Complete your Item Checklist in the Google Sheet
    +Get Boon of Blackfathom for 20% Movement Speed, and as many swiftness potions you can carry
    +Get all needed flight paths
    +Logout at Whitereach Post in Thousand Needles for P2 launch
]])

RXPGuides.RegisterGuide([[
#classic
#version 4
<< Horde
#group Custom Quests for RXP
#subgroup SoD Level 25 Quest Stacking
#name 25-3-Launch Day Turn-in Route
#displayname 3-Launch Day Turn-in Route

step
    .xp 25 >>You must be level 25 to utilize this guide!
step
    +|cRXP_WARN_WARNING: ONLY LOAD THIS GUIDE ON LAUNCH DAY, DO NOT ACCIDENTALLY TURN IN YOUR PRE QUESTS|r

-- THOUSAND NEEDLES --
step
    #completewith thousandneedles1
    .zone Thousand Needles >>Head to Whitereach Post in Thousand Needles

-- Whitereach Post --
step
    .isOnQuest 5151
    >>Talk to |cRXP_FRIENDLY_Wizlo Bearingshiner|r in Whitereach Post
    .turnin 5151 >>Turn in Hypercapacitor Gizmo
    .goto Thousand Needles,21.4,32.4
    .target Wizlo Bearingshiner
step
    .itemcount 12564,1
    >>Use the Assassination Note to Accept the quest
    .use 12564
    .accept 4881 >>Accept Assassination Note
    .goto Thousand Needles,21.2,32
step
    .isOnQuest 4881
    >>Talk to |cRXP_FRIENDLY_Kanati Greycloud|r in Whitereach Post
    .turnin 4881 >>Turn in Assassination Note
    .goto Thousand Needles,21.2,32
    .target Kanati Greycloud
step
    .isOnQuest 4770
    >>Talk to |cRXP_FRIENDLY_Motega Firemane|r in Whitereach Post
    .turnin 4770 >>Turn in Homeward Bound
    .goto Thousand Needles,21.4,32.2
    .target Motega Firemane
step
    .isOnQuest 5088
    >>Talk to |cRXP_FRIENDLY_Motega Firemane|r in Whitereach Post
    .turnin 5088 >>Turn in Arikara
    .goto Thousand Needles,21.4,32.2
    .target Motega Firemane

-- Splithoof Crag --
step
    .isOnQuest 1151
    >>Talk to |cRXP_FRIENDLY_Dorn Plainstalker|r in Splithoof Crag
    .turnin 1151 >>Turn in Test of Strength
    .goto Thousand Needles,53.8,41.6
    .target Dorn Plainstalker
step
    .isOnQuest 4904
    >>Talk to |cRXP_FRIENDLY_Thalia Amberhide|r in Freewind Post
    .turnin 4904 >>Turn in Free at Last
    .goto Thousand Needles,46,51.4
    .target Thalia Amberhide
step
    .isOnQuest 5064
    >>Talk to |cRXP_FRIENDLY_Cliffwatcher Longhorn|r in Freewind Post
    .turnin 5064 >>Turn in Grimtotem Spying
    .goto Thousand Needles,45.6,50.6
    .target Cliffwatcher Longhorn
step
    .isOnQuest 5147
    >>Talk to |cRXP_FRIENDLY_Cliffwatcher Longhorn|r in Freewind Post
    .turnin 5147 >>Turn in Wanted - Arnak Grimtotem
    .goto Thousand Needles,45.6,50.6
    .target Cliffwatcher Longhorn
step
    #label thousandneedles1
    .isOnQuest 4767
    >>Talk to |cRXP_FRIENDLY_Elu|r in Freewind Post
    .turnin 4767 >>Turn in Wind Rider
    .goto Thousand Needles,45,49
    .target Elu
step
    #completewith next
    .fly Camp Taurajo
    .goto Thousand Needles,45.0,49.2
    .target Nyse

-- THE BARRENS --
step
    #completewith thebarrens1
    .zone The Barrens >>Head to Camp Taurajo in The Barrens

-- Camp Taurajo --
step
    .itemcount 5099,1
    >>Use the Hoof of Lakota'mani to Accept the quest
    .use 5099
    .accept 883 >>Accept Hoof of Lakota'mani
    .goto The Barrens,44.8,59.0
step
    .isOnQuest 883
    >>Talk to |cRXP_FRIENDLY_Jorn Skyseer|r in Camp Taurajo
    .turnin 883 >>Turn in Hoof of Lakota'mani
    .goto The Barrens,44.8,59.0
    .target Jorn Skyseer
step
    .itemcount 5103,1
    >>Use the Washte Pawne's Feather to Accept the quest
    .use 5103
    .accept 885 >>Accept Washte Pawne's Feather
    .goto The Barrens,44.8,59.0
step
    .isOnQuest 885
    >>Talk to |cRXP_FRIENDLY_Jorn Skyseer|r in Camp Taurajo
    .turnin 885 >>Turn in Washte Pawne's Feather
    .goto The Barrens,44.8,59.0
    .target Jorn Skyseer
step
    .itemcount 5138,1
    >>Use the Harvester's Head to Accept the quest
    .use 5138
    .accept 897 >>Accept Harvester's Head
    .goto The Barrens,44.8,59.0
step
    .isOnQuest 897
    >>Talk to |cRXP_FRIENDLY_Jorn Skyseer|r in Camp Taurajo
    .turnin 897 >>Turn in Harvester's Head
    .goto The Barrens,44.8,59.0
    .target Jorn Skyseer
step
    .itemcount 5102,1
    >>Use Owatanka's Tailspike to Accept the quest
    .use 5102
    .accept 884 >>Accept Owatanka's Tailspike
    .goto The Barrens,44.8,59.0
step
    .isOnQuest 884
    >>Talk to |cRXP_FRIENDLY_Jorn Skyseer|r in Camp Taurajo
    .turnin 884 >>Turn in Owatanka's Tailspike
    .goto The Barrens,44.8,59.0
    .target Jorn Skyseer
step
    >>Talk to |cRXP_FRIENDLY_Jorn Skyseer|r in Camp Taurajo
    .accept 6382 >>The Ashenvale Hunt
    .goto The Barrens,44.8,59.0
    .target Jorn Skyseer
step
    .itemcount 5092,1
    .itemcount 5093,1
    .itemcount 5094,1
    >>Talk to |cRXP_FRIENDLY_Tatternack Steelforge|r in Camp Taurajo
    .accept 893 >>Accept Weapons of Choice
    .turnin 893 >>Turn in Weapons of Choice
    .goto The Barrens,45,57.6
    .target Tatternack Steelforge
step
    .isOnQuest 1153
    >>Talk to |cRXP_FRIENDLY_Tatternack Steelforge|r in Camp Taurajo
    .turnin 1153 >>Turn in A New Ore Sample
    .goto The Barrens,45,57.6
    .target Tatternack Steelforge
step
    .itemcount 5075,10
    >>Talk to |cRXP_FRIENDLY_Mangletooth|r in Camp Taurajo
    .accept 889 >>Spirit of the Wind
    .turnin 889 >>Spirit of the Wind
    .goto The Barrens,44.6,59.2
    .target Mangletooth
step
    .isQuestTurnedIn 879
    >>Talk to |cRXP_FRIENDLY_Mangletooth|r in Camp Taurajo
    .accept 906 >>Betrayal from Within
    .goto The Barrens,44.6,59.2
    .target Mangletooth
step
    #completewith ratchet1
    .fly Ratchet
    .goto The Barrens,44.4,59.0
    .target Omusa Thunderhorn

-- Ratchet --
step
    .isOnQuest 1221
    >>Talk to |cRXP_FRIENDLY_Mebok Mizzyrix|r in Ratchet
    .turnin 1221 >>Turn in Blueleaf Tubers
    .goto The Barrens,62.4,37.6
    .target Mebok Mizzyrix
step
    .isOnQuest 1069
    >>Talk to |cRXP_FRIENDLY_Mebok Mizzyrix|r in Ratchet
    .turnin 1069 >>Turn in Deepmoss Spider Eggs
    .goto The Barrens,62.4,37.6
    .target Mebok Mizzyrix
step
    .itemcount 4926,1
    >>Use Chen's Empty Keg to Accept the quest
    .use 4926
    .accept 819 >>Accept Chen's Empty Keg
    .goto The Barrens,62.2,38.4
step
    .isOnQuest 819
    >>Talk to |cRXP_FRIENDLY_Brewmaster Drohn|r in Ratchet
    .turnin 819 >>Turn in Chen's Empty Keg
    .goto The Barrens,62.2,38.4
    .target Brewmaster Drohn
step
    .isOnQuest 873
    >>Talk to |cRXP_FRIENDLY_Mahren Skyseer|r South of Ratchet
    .turnin 873 >>Turn in Isha Awak
    .goto The Barrens,65.8,43.8
    .target Mahren Skyseer
step
    .itemcount 10441,1
    >>Use the Glowing Shard to Accept the quest
    .use 10441
    .accept 6981 >>Accept Glowing Shard
    .goto The Barrens,63.0,37.2
step
    #label ratchet1
    .isOnQuest 6981
    >>Talk to |cRXP_FRIENDLY_Sputtervalve|r in Ratchet
    .complete 6981,1 >>The Glowing Shard
    .goto The Barrens,63.0,37.2
    .target Sputtervalve
step
    #completewith thebarrens1
    .fly Crossroads
    .goto The Barrens,63.0,37.2
    .target Bragok

-- Crossroads --
step
    .isOnQuest 906
    >>Talk to |cRXP_FRIENDLY_Thork|r in the Crossroads
    .turnin 906 >>Turn in Betrayal from Within
    .goto The Barrens,51.4,30.8
    .target Thork
step
    .isOnQuest 876
    >>Talk to |cRXP_FRIENDLY_Darsok Swiftdagger|r in the Crossroads
    .turnin 876 >>Turn in Serena Bloodfeather
    .goto The Barrens,51.6,30.8
    .target Darsok Swiftdagger
step
    .isOnQuest 899
    >>Talk to |cRXP_FRIENDLY_Mankrik|r in the Crossroads
    .turnin 899 >>Turn in Consumed by Hatred
    .goto The Barrens,52,31.6
    .target Mankrik
step
    .itemcount 5051,8
    >>Talk to |cRXP_FRIENDLY_Grub|r East of the Crossroads
    .accept 862 >>Dig Rat Stew
    .turnin 862 >>Dig Rat Stew
    .goto The Barrens,55.2,31.8
    .target Grub
step
    .isOnQuest 6981
    >>Talk to |cRXP_FRIENDLY_Falla Sagewind|r inside the tent on top of the hill above Wailing Caverns.
    .turnin 6981 >>Glowing Shard
    .goto The Barrens,48.2,32.8
    .target Falla Sagewind
step
    .isQuestTurnedIn 6981
    >>Talk to |cRXP_FRIENDLY_Falla Sagewind|r inside the tent on top of the hill above Wailing Caverns.
    .accept 3369 >>Accept In Nightmares
    .goto The Barrens,48.2,32.8
    .target Falla Sagewind
step
    .isQuestTurnedIn 848
    >>Talk to |cRXP_FRIENDLY_Apothecary Helbrim|r in the Crossroads
    .accept 853 >>Accept Apothecary Zamah
    .goto The Barrens,51.4,30.2
    .target Apothecary Helbrim
step
    #label thebarrens1
    >>Talk to |cRXP_FRIENDLY_Thork|r in the Crossroads
    .accept 6541 >>Accept Report to Kadrak
    .goto The Barrens,51.6,30.8
    .target Thork
step
    #completewith next
    .fly Thunder Bluff
    .goto The Barrens,51.6,30.4
    .target Devrak

-- MULGORE / THUNDER BLUFF --
step
    #completewith thunderbluff1
    .zone Thunder Bluff >>Head to Thunder Bluff in Mulgore
step
    .isOnQuest 853
    >>Talk to |cRXP_FRIENDLY_Apothecary Zamah|r at The Spirit Rise
    .turnin 853 >>Turn in Apothecary Zamah
    .goto Thunder Bluff,23.6,21.4
    .target Apothecary Zamah
step
    .isQuestTurnedIn 1064
    >>Talk to |cRXP_FRIENDLY_Apothecary Zamah|r at The Spirit Rise
    .accept 1065 >>Accept Journey to Tarren Mill
    .goto Thunder Bluff,23.6,21.4
    .target Apothecary Zamah
step
    >>Talk to |cRXP_FRIENDLY_Rumstag Proudstrider|r in Thunder Bluff
    .turnin 7820 >>Turn in A Donation of Wool
    .turnin 7821 >>Turn in A Donation of Silk
    .goto Thunder Bluff,43.8,42.2
    .target Rumstag Proudstrider
step
    .isOnQuest 78922
    >>Talk to |cRXP_FRIENDLY_Bashana Runetotem|r at The Elder Rise
    .turnin 78922 >>Turn in Blackfathom Villainy
    .goto Thunder Bluff,70.8,33.8
    .target Bashana Runetotem
step
    .isOnQuest 914
    >>Talk to |cRXP_FRIENDLY_Nara Wildmane|r at The Elder Rise
    .turnin 914 >>Turn in Leaders of the Fang
    .goto Thunder Bluff,75.6,31.2
    .target Nara Wildmane
step
    .isOnQuest 3369
    >>Talk to |cRXP_FRIENDLY_Arch Druid Hamuul Runetotem|r at The Elder Rise
    .turnin 3369 >>Turn in In Nightmares
    .goto Thunder Bluff,78.6,28.6
    .target Arch Druid Hamuul Runetotem
step
    .isOnQuest 1195
    >>Talk to |cRXP_FRIENDLY_Zangen Stonehoof|r in Thunder Bluff
    .turnin 1195 >>Turn in The Sacred Flame
    .goto Thunder Bluff,54.6,51.2
    .target Zangen Stonehoof
step
    .isOnQuest 1131
    >>Talk to |cRXP_FRIENDLY_Melor Stonehoof|r in Thunder Bluff
    .turnin 1131 >>Turn in Steelsnap
    .goto Thunder Bluff,61.4,80.6
    .target Melor Stonehoof
step
    .itemcount 20558,3
    >>Talk to |cRXP_FRIENDLY_Horde Warbringer|r in Thunder Bluff
    +Turn in any Warsong Gulch Marks
    .goto Thunder Bluff,80.6,30.6
    .target Horde Warbringer
step
    #label thunderbluff1
    .goto Thunder Bluff,47.12,57.88
    .target Chesmu
    >>Talk to |cRXP_FRIENDLY_Chesmu|r in Thunder Bluff
    .bankwithdraw 16408,211813,16303,16304,16305,16642,10621,16790,16782,3712,3520 >>Withdraw any needed items from your bank

step << !Mage
    #completewith next
    .fly Orgrimmar
    .goto Thunder Bluff,46.8,50.0
    .target Tal

-- ORGRIMMAR --
step
    #completewith orgrimmar1
    .zone Orgrimmar >>Head to Orgrimmar << !Mage
    .zone Orgrimmar >>Teleport to Orgrimmar << Mage
step
    >>Talk to |cRXP_FRIENDLY_Rashona Straglash|r The Drag
    .turnin 7826 >>A Donation of Wool
    .turnin 7827 >>A Donation of Silk
    .goto Orgrimmar,63.6,51.0
    .target Rashona Straglash
step
    #label orgrimmar1
    >>Talk to |cRXP_FRIENDLY_Vehena|r The Valley of Spirits
    .turnin 7833 >>A Donation of Wool
    .turnin 7834 >>A Donation of Silk
    .goto Orgrimmar,37.8,87.6
    .target Vehena
step
    #completewith next
    .fly Splintertree Post
    .goto Orgrimmar,45.2,63.8
    .target Doras

-- ASHENVALE --
step
    #completewith ashenvale1
    .zone Ashenvale >>Head to Ashenvale
step
    .isOnQuest 6441
    >>Talk to |cRXP_FRIENDLY_Pixel|r in Splintertree Post
    .turnin 6441 >>Turn in Satyr Horns
    .goto Ashenvale,73,61.4
    .target Pixel
step
    .itemcount 16408,1
    >>Use the The Befouled Element to Accept the quest
    .use 16408
    .accept 1918 >>Accept The Befouled Element
    .goto Ashenvale,73.6,60.0
step
    .isOnQuest 1918
    >>Talk to |cRXP_FRIENDLY_Mastok Wrilehiss|r in Splintertree Post
    .turnin 1918 >>Turn in The Befouled Element
    .goto Ashenvale,73.6,60.0
    .target Mastok Wrilehiss
step
    .isOnQuest 25
    >>Talk to |cRXP_FRIENDLY_Mastok Wrilehiss|r in Splintertree Post
    .turnin 25 >>Stonetalon Standstill
    .goto Ashenvale,73.6,60
    .target Mastok Wrilehiss
step
    .itemcount 211813,1
    >>Use the Silverwing Sentinel Charm to Accept the quest
    .use 211813
    .accept 79098 >>Accept Clear the Forest!
    .goto Ashenvale,74.0,60.6
step
    .isOnQuest 79098
    >>Talk to |cRXP_FRIENDLY_Kazragore|r in Ashenvale
    .turnin 79098 >>Turn in Clear the Forest!
    .goto Ashenvale,74.0,60.6
    .target Kazragore
step
    .isOnQuest 6482
    >>Talk to |cRXP_FRIENDLY_Yama Snowhoof|r in Splintertree Post
    .turnin 6482 >>Turn in Freedom to Ruul
    .goto Ashenvale,74,60.8
    .target Yama Snowhoof
step
    .isOnQuest 6382
    >>Talk to |cRXP_FRIENDLY_Senani Thunderheart|r in Splintertree Post
    .turnin 6382 >>The Ashenvale Hunt
    .goto Ashenvale,73.6,61.6
    .target Senani Thunderheart
step
    .itemcount 16303,1
    >>Use Ursangous's Paw to Accept the quest
    .use 16303
    >>Talk to |cRXP_FRIENDLY_Senani Thunderheart|r in Splintertree Post
    .turnin 23 >>Turn in Ursangous's Paw
    .goto Ashenvale,73.6,61.6
    .target Senani Thunderheart
step
    .itemcount 16303,1
    >>Use the Ursangous's Paw to Accept the quest
    .use 16303
    .accept 23 >>Accept Ursangous's Paw
    .goto Ashenvale,73.6,61.6
step
    .isOnQuest 23
    >>Talk to |cRXP_FRIENDLY_Senani Thunderheart|r in Splintertree Post
    .turnin 23 >>Turn in Ursangous's Paw
    .goto Ashenvale,73.6,61.6
    .target Senani Thunderheart
step
    .itemcount 16304,1
    >>Use Shadumbra's Head to Accept the quest
    .use 16304
    .accept 24 >>Accept Shadumbra's Head
    .goto Ashenvale,73.6,61.6
step
    .isOnQuest 24
    >>Talk to |cRXP_FRIENDLY_Senani Thunderheart|r in Splintertree Post
    .turnin 24 >>Turn in Shadumbra's Head
    .goto Ashenvale,73.6,61.6
    .target Senani Thunderheart
step
    .itemcount 16305,1
    >>Use Sharptalon's Claw to Accept the quest
    .use 16305
    .accept 2 >>Accept Sharptalon's Claw
    .goto Ashenvale,73.6,61.6
step
    .isOnQuest 2
    >>Talk to |cRXP_FRIENDLY_Senani Thunderheart|r in Splintertree Post
    .turnin 2 >>Turn in Sharptalon's Claw
    .goto Ashenvale,73.6,61.6
    .target Senani Thunderheart
step
    .isQuestTurnedIn 2
    >>Talk to |cRXP_FRIENDLY_Senani Thunderheart|r in Splintertree Post
    .accept 247 >>Accept The Hunt Completed
    .goto Ashenvale,73.6,61.6
    .target Senani Thunderheart
step   
    .isOnQuest 247
    >>Talk to |cRXP_FRIENDLY_Senani Thunderheart|r in Splintertree Post
    .turnin 247 >>Turn in The Hunt Completed
    .goto Ashenvale,73.6,61.6
    .target Senani Thunderheart
step
    .isOnQuest 6544
    >>Talk to |cRXP_FRIENDLY_Ertog Ragetusk|r in Splintertree Post
    .turnin 6544 >>Turn in Torek's Assault
    .goto Ashenvale,73,62.4
    .target Ertog Ragetusk
step
    .isOnQuest 6571
    >>Talk to |cRXP_FRIENDLY_Locke Okarr|r near Splintertree Post
    .turnin 6571 >>Turn in Warsong Supplies
    .goto Ashenvale,71.4,67.6
    .target Locke Okarr
step
    .isOnQuest 6503
    >>Talk to |cRXP_FRIENDLY_Kuray'bin|r near Splintertree Post
    .turnin 6503 >>Turn in Ashenvale Outrunners
    .goto Ashenvale,71,68.2
    .target Kuray'bin
step
    .itemcount 16642,1
    .itemcount 16643,1
    .itemcount 16644,1
    >>Talk to |cRXP_FRIENDLY_Kuray'bin|r near Splintertree Post
    .accept 6504 >>Accept The Lost Pages
    .turnin 6504 >>Turn in The Lost Pages
    .goto Ashenvale,70.0,71.0
    .target Kuray'bin
step
    .isQuestTurnedIn 1918
    >>Talk to |cRXP_FRIENDLY_Mastok Wrilehiss|r in Splintertree Post
    .accept 824 >>Accept Je'neu of the Earthen Ring
    .goto Ashenvale,73.6,60.0
    .target Mastok Wrilehiss
step
    .isOnQuest 6541
    >>Talk to |cRXP_FRIENDLY_Kadrak|r at the Barrens / Ashenvale border
    .turnin 6541 >>Turn in Report to Kadrak
    .goto The Barrens,48.0,5.4
    .target Kadrak
step
    .itemcount 10621,1
    >>Use the Runed Scroll to Accept the quest
    .use 10621
    .accept 3513 >>Accept The Runed Scroll
    .goto The Barrens,48.0,5.4
step
    .isOnQuest 3513
    >>Talk to |cRXP_FRIENDLY_Kadrak|r at the Barrens / Ashenvale border
    .turnin 3513 >>Turn in The Runed Scroll
    .goto The Barrens,48.0,5.4
    .target Kadrak
step
    #completewith ashenvale1
    .fly Zoram'Gar Outpost
    .goto Ashenvale,73.2,61.6
    .target Vhulgra
step
    .itemcount 16790,1
    >>Use the Damp Note to Accept the quest
    .use 16790
    .accept 6564 >>Accept Allegiance to the Old Gods
    .goto Ashenvale,11.6,34.2
step
    .isOnQuest 6564
    >>Talk to |cRXP_FRIENDLY_Je'neu Sancrea|r at Zoram'Gar Outpost
    .turnin 6564 >>Turn in Allegiance to the Old Gods
    .goto Ashenvale,11.6,34.2
    .target Je'neu Sancrea
step
    .itemcount 211454,1
    >>Use the Strange Water Globe to Accept the quest
    .use 211454
    .accept 78920 >>Accept Baron Aquanis
    .goto Ashenvale,11.6,34.2
step
    .isOnQuest 78920
    >>Talk to |cRXP_FRIENDLY_Je'neu Sancrea|r at Zoram'Gar Outpost
    .turnin 78920 >>Turn in Baron Aquanis
    .goto Ashenvale,11.6,34.2
    .target Je'neu Sancrea
step
    .isOnQuest 824
    >>Talk to |cRXP_FRIENDLY_Je'neu Sancrea|r at Zoram'Gar Outpost
    .turnin 824 >>Turn in Je'neu of the Earthen Ring
    .goto Ashenvale,11.6,34.2
    .target Je'neu Sancrea
step
    .isOnQuest 6462
    >>Talk to |cRXP_FRIENDLY_Mitsuwa|r at Zoram'Gar Outpost
    .turnin 6462 >>Turn in Troll Charm
    .goto Ashenvale,11.6,34.8
    .target Mitsuwa
step
    .isOnQuest 6621
    >>Talk to |cRXP_FRIENDLY_Karang Amakkar|r at Zoram'Gar Outpost
    .turnin 6621 >>Turn in King of the Foulweald
    .goto Ashenvale,11.8,34.4
    .target Karang Amakkar
step
    #label ashenvale1
    .isOnQuest 6641
    >>Talk to |cRXP_FRIENDLY_Warsong Runner|r at Zoram'Gar Outpost
    .turnin 6641 >>Turn in Vorsha the Lasher
    .goto Ashenvale,12.2,34.2
    .target Warsong Runner
step
    #completewith next
    .hs >>Hearth to The Sepulcher, Silverpine Forest

-- SILVERPINE FOREST --
step
    #completewith silverpine1
    .zone Silverpine Forest >>Head to Silverpine Forest
step
    .isOnQuest 1014
    >>Talk to |cRXP_FRIENDLY_Dalar Dawnweaver|r at The Sepulcher
    .turnin 1014 >>Turn in Arugal Must Die
    .goto Silverpine Forest,44.2,39.8
    .target Dalar Dawnweaver
step
    .isOnQuest 442
    >>Talk to |cRXP_FRIENDLY_High Executor Hadrec|r at The Sepulcher
    .turnin 442 >>Turn in Assault on Fenris Isle
    .goto Silverpine Forest,43.4,40.8
    .target High Executor Hadrec
step
    #label silverpine1
    >>Talk to |cRXP_FRIENDLY_Apothecary Renferrel|r at The Sepulcher
    .accept 493 >>Accpet Journey to Hillsbrad Foothills
    .goto Silverpine Forest,42.8,40.8
    .target Apothecary Renferrel
step
    #completewith next
    .fly Tarren Mill
    .goto Silverpine Forest,45.6,42.6
    .target Karos Razok

-- HILLSBRAD FOOTHILLS --
step
    #completewith hillsbrad1
    .zone Hillsbrad Foothills >>Head to Hillsbrad Foothills
step
    .isOnQuest 1065
    >>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r in Tarren Mill
    .turnin 1065 >>Turn in Journey to Tarren Mill
    .goto Hillsbrad Foothills,61.4,19.2
    .target Apothecary Lydon
step
    .isOnQuest 493
    >>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r in Tarren Mill
    .turnin 493 >>Turn in Journey to Hillsbrad Foothills
    .goto Hillsbrad Foothills,61.4,19.2
    .target Apothecary Lydon
step
    .isOnQuest 546
    >>Talk to |cRXP_FRIENDLY_Deathguard Samsa|r in Tarren Mill
    .turnin 546 >>Turn in Souvenirs of Death
    .goto Hillsbrad Foothills,62.14,19.75
    .target Deathguard Samsa
step
    .isOnQuest 567
    >>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r in Tarren Mill
    .turnin 567 >>Turn in Dangerous!
    .goto Hillsbrad Foothills,62.36,20.39
    .target High Executor Darthalia
step
    .isOnQuest 541
    >>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r in Tarren Mill
    .turnin 541 >>Turn in Battle of Hillsbrad
    .goto Hillsbrad Foothills,62.36,20.39
    .target High Executor Darthalia
step
    .isOnQuest 549
    >>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r in Tarren Mill
    .turnin 549 >>Turn in WANTED: Syndicate Personnel
    .goto Hillsbrad Foothills,62.36,20.39
    .target High Executor Darthalia
step
    .isOnQuest 498
    >>Talk to |cRXP_FRIENDLY_Krusk|r in Tarren Mill
    .turnin 498 >>Turn in The Rescue
    .goto Hillsbrad Foothills,63.2,20.6
    .target Krusk
step
    .isOnQuest 1051
    >>Talk to |cRXP_FRIENDLY_Monika Sengutz|r in Tarren Mill
    .turnin 1051 >>Turn in Vorrel's Revenge
    .goto Hillsbrad Foothills,62.6,19
    .target Monika Sengutz
step
    .isQuestTurnedIn 517
    >>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r in Tarren Mill
    .accept 524 >>Accept Elixir of Agony
    .goto Hillsbrad Foothills,61.4,19.2
    .target Apothecary Lydon
step
    .isQuestTurnedIn 496
    .goto Hillsbrad Foothills,61.4,19.2
    .target Apothecary Lydon
    >>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r in Tarren Mill
    .accept 499 >>Accept Elixir of Suffering
    .turnin 499 >>Turn in Elixir of Suffering
step
    .itemcount 3712,10
    >>|cRXP_WARN_NOTE|r: You must be level 28 to accept this quest
    .goto Hillsbrad Foothills,62.2,19.0
    .target Christoph Jeffcoat
    >>Talk to |cRXP_FRIENDLY_Christoph Jeffcoat|r in Tarren Mill
    .accept 7321 >>Accept Soothing Turtle Bisque
    .turnin 7321 >>Turn in Soothing Turtle Bisque
step
    .isOnQuest 524
    >>Place the Tainted Keg on the |cRXP_FRIENDLY_Dusty Rug|r in Tarren Mill
    .use 3520
    .complete 524,1 >>Elixir of Agony
    .turnin 524 >>Turn in Elixir of Agony
    .goto Hillsbrad Foothills,62.8,18.8
step
    #label hillsbrad1
    .isQuestTurnedIn 541
    >>Talk to |cRXP_FRIENDLY_High Executor Darthalia|r in Tarren Mill
    .accept 550 >>Battle of Hillsbrad
    .goto Hillsbrad Foothills,62.36,20.39
    .target High Executor Darthalia
step << !Mage
    #completewith next
    .fly Undercity
    .goto Hillsbrad Foothills,60.2,18.6
    .target Zarise

-- UNDERCITY --
step
    #completewith undercity1
    .zone Undercity >>Head to Undercity << !Mage
    .zone Undercity >>Teleport to Undercity << Mage
step    
    .goto Undercity,65.8,46.2
    .target William Montague
    >>Talk to |cRXP_FRIENDLY_William Montague|r in Undercity
    .bankwithdraw 6283,4306,2592,211841,17008 >>Withdraw any needed items from your bank
step
    >>Turn in any Full Shipment boxes
    >>Talk to |cRXP_FRIENDLY_Gishah|r Undercity
    .turnin 79103 >>A Full Shipment
    .goto Undercity,65.6,38.4
    .target Gishah
step
    >>Talk to |cRXP_FRIENDLY_Ralston Farnsley|r in Undercity
    .turnin 7813 >>A Donation of Wool
    .turnin 7814 >>A Donation of Silk
    .goto Undercity,71.8,29.0
    .target Ralston Farnsley
step
    .itemcount 17008,1
    >>Use the Small Scroll to Accept the quest
    .use 17008
    .accept 6522 >>Accept An Unholy Alliance
    .goto Undercity,56.2,92.6
step
    .isOnQuest 6522
    >>Talk to |cRXP_FRIENDLY_Varimathras|r in Undercity
    .turnin 6522 >>Turn in An Unholy Alliance
    .goto Undercity,56.2,92.6
    .target Varimathras
step
    .isOnQuest 1013
    .goto Undercity,53.6,54
    .target Keeper Bel'dugur
    >>Talk to |cRXP_FRIENDLY_Keeper Bel'dugur|r in The Apothecarium
    .turnin 1013 >>Turn in The Book of Ur
step
    #label undercity1
    .isOnQuest 550
    >>Talk to |cRXP_FRIENDLY_Varimathras|r in Undercity
    .turnin 550 >>Turn in Battle of Hillsbrad
    .goto Undercity,56.2,92.6
    .target Varimathras
step
    +CONGRATULATIONS!!! You have completed this route.
]])