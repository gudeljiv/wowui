RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Horde 10-60
#name 1 BfA Intro
#displayname Chapter 1 - BfA Intro
#next 1 Horde Silverpine Forest Fresh;1 Horde Draenor Scenario
<< Horde
step << DK !Orc !Undead !Tauren !Troll !BloodElf !Goblin
.goto 1602,49.55,90.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25The Lich King|r
.accept 58877 >>Accept Death's Power Grows
.target The Lich King
step << DK !Orc !Undead !Tauren !Troll !BloodElf !Goblin
.goto 1602,49.55,90.80
>>Use the Extra Action Button
.complete 58877,1 
step << DK !Orc !Undead !Tauren !Troll !BloodElf !Goblin
.goto 1602,49.55,90.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25The Lich King|r
.turnin 58877 >>Turn in Death's Power Grows
.accept 58903 >>Accept Defender of Azeroth
.target The Lich King
step << DK !Orc !Undead !Tauren !Troll !BloodElf !Goblin
.goto 1602,50.74,71.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Darion|r
.complete 58903,1 
.target Highlord Darion Mograine
.skipgossip
step << DK !Orc !Undead !Tauren !Troll !BloodElf !Goblin
.goto 1602,49.96,38.98
>>Take the Death Gate to Orgrimmar
.complete 58903,2 
step
.goto 85,49.40,76.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cFF00FF25Warchief's Herald|r
.accept 51443 >>Accept Battle for Azeroth: Mission Statement
.target Warchief's Herald
.isQuestAvailable 60360
step
.goto 85,49.34,74.02
>>Enter Grommash Hold
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic|r
.complete 51443,1 
.isQuestAvailable 60360
step
#completewith next
.goto 85,49.96,75.74,15,0
.goto 85,44.51,75.00,15,0
.goto 85,43.67,73.54,15,0
.goto 85,38.55,78.23,40 >> Travel toward |cFF00FF25Revi|r
step
#label ReviR
.goto 85,38.55,78.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Revi|r
.skill riding,75 >>Train Apprentice Riding
.target Revi Ramrod
.isQuestAvailable 60360
step
#veteran
.goto 85,40.83,80.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Chromie|r
>>|cFFFCDC00Select "The Iron Horde" Campaign|r
.turnin 62568 >>Turn in Adventurers Wanted: Chromie's Call
.accept 34398 >>Accept Warlords of Draenor: The Dark Portal
.target Chromie
.skipgossip
.isOnQuest 62568
.isQuestAvailable 60360
.zoneskip 85,1
step
#veteran
.goto 85,40.83,80.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Chromie|r
>>|cFFFCDC00Select "The Iron Horde" Campaign|r
.accept 34398 >>Accept Warlords of Draenor: The Dark Portal
.target Chromie
.skipgossip
.isQuestAvailable 60360
.zoneskip 85,1
step
#completewith MeetTeam
.goto 85,54.43,78.47,23 >> Enter the Inn
.timer 16,Meet your team RP
.nodmf
step
.goto 85,53.56,78.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Gryshka|r
.home >>Set your Hearthstone to The Broken Tusk
>>|cFF0E8312Buy food/water if needed|r
.target Innkeeper Gryshka
.zoneskip 85,1
step
#veteran
#label DMFBuyAHItems
>>|cFF0E8312Buy the following items from the auction house or send them to yourself via mail|r
>>|cFFFCDC00This step is optional and you don't need to buy the items if you don't want to/can't afford it|r
+|cFFFCDC00Manually skip this step when you're done|r
.goto 85,53.98,73.26
.collect 71951,1,29456,1,1
.collect 71635,1,29443,1,1
.collect 71715,1,29451,1,1
.collect 71716,1,29464,1,1
.collect 71952,1,29457,1,1
.collect 71636,1,29444,1,1
.collect 71637,1,29445,1,1
.collect 71638,1,29446,1,1
.target Auctioneer Drezmit
.dmf
step << Goblin
>>Buy Netherweave bags from the auction house then go to your Mailbox to loot them. Equip them. Skip this step if you already have better bags
.goto 85,53.98,73.26
.collect 21841,4 
.target Auctioneer Drezmit
.isQuestAvailable 60360
step << !Goblin !DK
#completewith DMFDarkmoonPortalTaken
.goto 85,53.83,82.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Trak'gen|r
.vendor >>|cFF0E8312Buy|r |T133634:0|t[Brown Leather Satchels] |cFF0E8312from him|r
>>|cFFFCDC00Skip this step if you already have better bags|r
.target Trak'gen

step
#completewith DMFDarkmoonPortalTaken
.goto 85,53.38,90.48,10,0
.goto 85,56.26,91.70
.zone 125 >>Take the Portal to Dalaran
.dmf
step
.goto 125,50.29,50.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cFF00FF25Darkmoon Faire Mystic Mage|r
.accept 7926 >>Accept The Darkmoon Faire
.zone 7 >> Teleport to the Darkmoon Faire
.target Darkmoon Faire Mystic Mage
.skipgossip
.dmf
step
#completewith next
.goto 7,36.85,35.86
.zone 407 >>Take the Darkmoon Faire Portal to the Darkmoon Island
.dmf
step
>>Click the Strider if you don't have an Heirloom Mount
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kae Ti|r. |cFF0E8312Buy a|r |T133734:0|t[Ride Ticket Book] |cFF0E8312from her|r
.goto 407,50.44,59.33
.collect 92788,1,7926,1 
.target Kae Ti
.dmf
step
#veteran
>>|cFFFCDC00Open the|r |T133734:0|t[Ride Ticket Book]
>>|cFFFCDC00Stand on the Carousel and wait for the Experience Buff to reach 60minutes|r
>>|cFFFCDC00Click the Quest Items in your bag (skip the ones you don't have)|r
.goto 407,49.45,57.5
.collect 81055,5,7926,1 
.accept 29464 >>Accept Tools of Divination
.accept 29451 >>Accept The Master Strategist
.accept 29456 >>Accept A Captured Banner
.accept 29457 >>Accept The Enemy's Insignia
.accept 29458 >>Accept The Captured Journal
.accept 29443 >>Accept A Curious Crystal
.accept 29444 >>Accept An Exotic Egg
.accept 29445 >>Accept An Intriguing Grimoire
.accept 29446 >>Accept A Wondrous Weapon
.use 92788
.zoneskip 407,1
.dmf


step
#fresh
.goto 407,49.45,57.5
>>|cFFFCDC00Open the|r |T133734:0|t[Ride Ticket Book]
.collect 81055,5,7926,1 
+|cFFFCDC00Stand on the Carousel and wait for the Experience Buff to reach 60 minutes. Skip this step when finished|r
.use 92788
.zoneskip 407,1
.dmf


step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Professor Paleo|r
.turnin 29464 >>Turn in Tools of Divination
.target Professor Thaddeus Paleo
.itemcount 71716,1
.zoneskip 407,1
.dmf
step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Professor Paleo|r
.turnin 29451 >>Turn in The Master Strategist
.target Professor Thaddeus Paleo
.itemcount 71715,1
.zoneskip 407,1
.dmf
step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Professor Paleo|r
.turnin 29456 >>Turn in A Captured Banner
.target Professor Thaddeus Paleo
.itemcount 71951,1
.zoneskip 407,1
.dmf
step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Professor Paleo|r
.turnin 29457 >>Turn in The Enemy's Insignia
.target Professor Thaddeus Paleo
.itemcount 71952,1
.zoneskip 407,1
.dmf
step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Professor Paleo|r
.turnin 29458 >>Turn in The Captured Journal
.target Professor Thaddeus Paleo
.itemcount 71953,1
.zoneskip 407,1
.dmf
step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Professor Paleo|r
.turnin 29443 >>Turn in A Curious Crystal
.target Professor Thaddeus Paleo
.itemcount 71635,1
.zoneskip 407,1
.dmf
step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Professor Paleo|r
.turnin 29446 >>Turn in A Wondrous Weapon
.target Professor Thaddeus Paleo
.itemcount 71638,1
.zoneskip 407,1
.dmf
step
.goto 407,47.76,64.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Gelvas|r. |cFF0E8312Buy as many|r |T669449:0|t[Darkmoon Top Hats] |cFF0E8312from him as you can|r
.turnin 7926 >>Turn in The Darkmoon Faire
.collect 171364,1,29506,1 
.target Gelvas Grimegate
.zoneskip 407,1
.dmf
step
.goto 407,53.23,75.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sayge|r for Buffs
.collect 19422,1
.target Sayge
.skipgossip 1
.zoneskip 407,1
.dmf

step
#veteran
.goto 407,51.11,82.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Yebb|r
.turnin 29444 >>Turn in An Exotic Egg
.target Yebb Neblegear
.zoneskip 407,1
.dmf
.isOnQuest 29444
step
#label DMFHeartBackToOrgrimmar
#completewith BFAStatement
.hs >>Hearth to The Broken Tusk
.dmf
.zoneskip 85
step
#label MeetTeam
.goto 85,54.43,78.47
>>Wait out the RP
.complete 51443,2 
.isOnQuest 51443
step
.goto 85,48.26,71.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Breka|r
.accept 60361 >>Accept Battle for Azeroth: Mission Statement
.target Warlord Breka Grimaxe
.isQuestTurnedIn 60359

step
.goto 85,48.26,71.39
>>|cFFFCDC00Wait out the RP|r
.complete 60361,1 
.isQuestTurnedIn 60359

step
.goto 85,48.51,71.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Nathanos|r
.complete 60361,2 
.target Nathanos Blightcaller
.skipgossip
.isQuestTurnedIn 60359

step
.goto 85,51.26,77.09
>>Get onto the |cFFDB2EEFSturdy Wyvern|r
.complete 60361,4 
.target Sturdy Wyvern
.isOnQuest 60361

step
#veteran
.goto 85,54.43,78.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Nathanos|r to get teleported to Zandalar
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic|r
.turnin 51443 >>Turn in Battle for Azeroth: Mission Statement
.accept 50769 >>Accept The Stormwind Extraction
.zone 862 >> Teleport to Zandalar
.target Nathanos Blightcaller
.skipgossip
.isQuestAvailable 60360
.isQuestTurnedIn 52969
step
#label BFAStatement
.goto 85,54.43,78.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Nathanos|r
.turnin 51443 >>Turn in Battle for Azeroth: Mission Statement
.accept 50769 >>Accept The Stormwind Extraction
.target Nathanos Blightcaller
.isQuestAvailable 60360
step
.goto 85,54.58,78.36
>>Loot the |cFFDB2EEFPotion|r on the table
.complete 50769,1 
.zoneskip 862
.isOnQuest 50769
step
.goto 85,51.19,83.57
.vehicle >>Get onto a |cFFDB2EEFSkyhorn Eagle|r
.timer 95,The Stormwind Extraction RP
.target Skyhorn Eagle
.zoneskip 862
.isOnQuest 50769
step << skip
>>|cFFFCDC00Wait out the RP|r
.complete 50769,2 
.target Skyhorn Eagle
.zoneskip 862
.isOnQuest 50769
step
>>|cFFFCDC00Wait out the RP|r
.scenario 3718,1
.zoneskip 862
.isOnQuest 50769
step
.goto 1012,46.31,58.20,-1
.goto 1012,46.16,58.04,-1
>>Click the |cFFDB2EEFPadlocks|r on the ground
.scenario 3719,2
.zoneskip 862
.isOnQuest 50769
step
.goto 1012,46.31,57.96
>>|cFFFCDC00Go down the Stockades Portal in the water|r
.scenario 3719,1
.zoneskip 862
.isOnQuest 50769
step << skip

step
.goto 1013,31.52,62.04,8,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tOpen the |cFFDB2EEFCell Door|r to |cFF00FF25Saurfang|r's prison
>>|cFFFCDC00Ignore all the|r |cFFFF57227th Legion Enforcers|r |cFFFCDC00and|r |cFFFF57227th Legion Sharpshooters|r. |cFFFCDC00They disappear when you open the|r |cFFDB2EEFCell Door|r
.scenario 3721,2
.goto 1013,50.67,38.88
.gossipoption 48752 >>Talk to |cFF00FF25Saurfang|r
.timer 48,The Stormwind Extraction RP
.goto 1013,48.05,33.52
.target High Overlord Saurfang
.skipgossip
.zoneskip 862
.isOnQuest 50769
step << skip

step
#completewith next
.goto 1013,59.60,59.72,8,0
.goto 1013,55.65,64.12,5 >>Run to the next Prison Cell
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tOpen the |cFFDB2EEFCell Door|r to |cFF00FF25Talanji|r's and |cFF00FF25Zul|r's prison
>>You may have to wait out |cFF00FF25Saurfang|r's RP
.goto 1013,55.65,64.48
.scenario 3722,1
.timer 61,The Stormwind Extraction RP
.target 7th Legion Sharpshooter
.target 7th Legion Enforcer
.zoneskip 862
.isOnQuest 50769
step
#completewith next
.goto 1013,59.44,37.24,8 >>|cFFFCDC00Wait out the RP. Follow the group|r
step
.goto 1013,75.57,26.40,8,0
.goto 1013,87.15,23.20
>>Kill |cFFFF57227th Legion Enforcers|r, |cFFFF57227th Legion Sharpshooters|r, and |cFFFF57227th Legion Battlemages|r in the big circular room
>>Kill |cFFFF5722Lyra|r and her |cFFFF57227th Legion Battlemages|r when they spawn
>>After killing |cFFFF5722Lyra|r, click the |cFFDB2EEFSewer Access Door on the ground|r
.scenario 3722,2
.target 7th Legion Enforcer
.target 7th Legion Sharpshooter
.target 7th Legion Battlemage
.target Mage-Commander Lyra
.zoneskip 862
.isOnQuest 50769
step
#completewith next
.goto 1012,71.09,46.72
>>|cFFFCDC00Dismiss your pet|r << Hunter/Warlock
.gossipoption 48518 >> Talk to |cFF00FF25Rokhan|r
.target Rokhan
step
.goto 1012,70.22,47.53,15,0
.goto 1012,68.51,49.84,15,0
.goto 1012,66.05,51.25,15,0
.goto 1012,64.00,49.59,15,0
.goto 1012,64.30,48.72,8,0
.goto 1012,62.34,47.46,15,0
.goto 1012,61.50,44.77,15,0
.goto 1012,60.00,44.85,8,0
.goto 1012,59.59,43.55
>>|cFFFCDC00Follow|r |cFF00FF25Rokhan|r
>>|cFFFCDC00Stay inside|r |cFF00FF25Rokhan|r|cFFFCDC00's circle to stay stealthed|r
>>|cFFFCDC00Avoid red circles to avoid detection|r
.gossipoption 48339 >> Talk to |cFF00FF25Rokhan|r when he stops after jumping off the Bridge
.target Rokhan
.zoneskip 862
.isOnQuest 50769
step
.goto 1012,61.21,44.93,12,0
.goto 1012,60.48,45.70,15,0
.goto 1012,59.66,46.81,15,0
.goto 1012,60.29,49.05,15,0
.goto 1012,58.13,52.45,15,0
.goto 1012,57.57,54.49,15,0
.goto 1012,55.96,57.10
>>|cFFFCDC00Follow|r |cFF00FF25Rokhan|r
>>|cFFFCDC00Stay inside|r |cFF00FF25Rokhan|r|cFFFCDC00's circle to stay stealthed|r
>>|cFFFCDC00Avoid red circles to avoid detection|r
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic|r
.scenario 3727,1
.target Rokhan
.zoneskip 862
.isOnQuest 50769
step
.goto 1012,55.97,57.09
>>Kill the |cFFFF5722Gilnean Maulers|r attacking the shield
>>|cFFFCDC00Wait out the RP|r
.scenario 3729,1
.target Gilnean Mauler
.zoneskip 862
.isOnQuest 50769
step
.goto 1012,53.79,55.25,20,0
.goto 1012,51.69,54.93,20,0
.goto 1012,49.60,52.21,20,0
.goto 1012,47.33,51.66,20,0
.goto 1012,47.43,47.28,20,0
.goto 1012,49.32,42.49,20,0
.goto 1012,45.43,43.18
>>Follow the group whilst killing |cFFFF5722Gilnean Maulers|r |cFFFF5722Stormwind Guards|r, and |cFFFF5722Stormwind Battlemages|r
.gossipoption 48198 >>Talk to |cFF00FF25Nathanos|r
.scenario 3729,2
.target Gilnean Mauler
.target Stormwind Guard
.target Stormwind Battlemage
.target Nathanos Blightcaller
.zoneskip 862
.isOnQuest 50769
step
.goto 1012,43.53,42.81,20,0
.goto 1012,42.41,42.79,20,0
.goto 1012,39.79,40.59
>>|cFFFCDC00Dodge the White Swirls on the ground|r
>>|cFFFCDC00Stay in|r |cFF00FF25Talanji|r|cFFFCDC00's Bubble when she casts it|r
>>Kill the |cFFFF5722Ice Barrier|r
.scenario 3730,1
.target Ice Barrier
.zoneskip 862
.isOnQuest 50769
step
>>|cFFFCDC00Follow the group|r
>>Kill the |cFFFF5722Alliance|r to reach |cFF00FF25Talanji|r's Ship |cFFFCDC00with the group|r
.scenario 3788,1
.goto 1012,33.54,34.75,30,0
.goto 1012,31.47,31.73,30,0
.goto 1012,29.14,31.42,30,0
.goto 1012,29.69,26.64,30,0
.goto 1012,19.64,25.70
.target Gilnean Mauler
.target Stormwind Guard
.target Stormwind Knight
.target Stormwind Battlemage
.target Teldrassil Sentinel
.target Dwarven Rifleman
.target Gnomish Gyro-Engineer
.target Exodar Peacekeeper
.zoneskip 862
.isOnQuest 50769
step
.goto 1012,20.07,28.76,10,0
.goto 1012,20.54,28.94
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematics|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Talanji|r when she gets onto the ship
.complete 50769,3 
.target Princess Talanji
.skipgossip
.zoneskip 862
.isOnQuest 50769
steps
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Nathanos|r
.goto 862,57.95,62.76
.turnin 60361 >>Turn in Battle for Azeroth: Mission Statement
.target Nathanos Blightcaller
.isOnQuest 60361
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Nathanos|r
.turnin 50769 >>Turn in The Stormwind Extraction
.goto 1164,40.11,71.56,-1
.goto 862,57.96,62.76,-1
.target Nathanos Blightcaller
.isQuestComplete 50769
step
#label ZuldazarWelcometoZuldazar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Talanji|r
.accept 46957 >>Accept Welcome to Zuldazar
.goto 862,57.95,62.46
.target Princess Talanji
.zoneskip 1164
step
.goto 1165,50.78,92.73,40,0
.goto 1165,50.35,90.93,40,0
.goto 1165,49.94,85.84,40,0
.goto 1165,48.89,83.91,40,0
.goto 1165,49.98,82.33
>>Stay close to Talanji else she will stop moving
.complete 46957,1 
.target Princess Talanji
.zoneskip 1164
step
.goto 1165,49.98,82.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to General Jakra'zet
.turnin 46957 >>Turn in Welcome to Zuldazar
.accept 46930 >>Accept Rastakhan
.target General Jakra'zet
.zoneskip 1164
step
.goto 1165,49.98,82.58
>>|cfff78300DO NOT ride the Pterrordax|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tInstead, talk to Talanji
>>Press "Escape" on your keyboard to skip the cinematic
.complete 46930,1 
.target Princess Talanji
.skipgossip
.zoneskip 1164
step
.goto 1165,49.91,42.72
>>Talk to King Rastakhan
.turnin 46930 >>Turn in Rastakhan
.accept 46931 >>Accept Speaker of the Horde
.target King Rastakhan
.zoneskip 1164
step
#completewith next
>>|cfff78300Follow the arrow.|r You don't need to follow Zolani
.goto 1165,49.43,44.67,10,0
.goto 1165,48.66,44.61,20,0
.goto 1165,49.93,39.86
.complete 46931,1 
.isOnQuest 46931
step
>>Click the shade of the Horde Banner
.goto 1165,49.93,39.86
.complete 46931,2 
.isOnQuest 46931
step
#completewith next
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
.isOnQuest 46931
step
>>Go into the three rooms
.complete 46931,3 
.goto 1163,49.78,73.50
.complete 46931,4 
.goto 1163,67.67,70.75
.complete 46931,5 
.goto 862,57.57,44.37
.isOnQuest 46931
step
>>Go up and talk to Talanji
*If you're very fast then you can skip Talanji's roleplay by relogging
.goto 1164,44.67,70.33,20,0
.goto 1164,41.22,66.75
.turnin 46931 >>Turn in Speaker of the Horde
.target Princess Talanji
.isOnQuest 46931
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Horde 10-60
#name 1 Horde Silverpine Forest Fresh
#displayname Chapter 2 - Silverpine Forest
#next 1 Horde Zuldazar First Half
#maxlevel 30
#fresh
<< Horde
step
#completewith SilverpinePortaltoUndercity
+Welcome to the new player friendly guide for Battle for Azeroth.
+This guide assumes that you don't have anything and are a new player that just started playing World of Warcraft.
step
#completewith next
.goto 1163,74.00,69.92
.zone 85 >> Take the portal to Orgrimmar
step
.isQuestAvailable 26965
.goto 85,56.02,88.25
.zone 110 >> Take the portal to Silvermoon
step
.isQuestAvailable 26965
#label SilverpinePortaltoUndercity
#completewith SilverpineTheWarchiefCometh
.zoneskip 18
.goto 110,51.84,17.95,8,0
.goto 110,49.52,17.19,8,0
.goto 110,48.87,14.04,8,0
.goto 110,49.52,14.81
.zone 18 >>Interact with the Orb of Translocation
step
#completewith SilverpineTheWarchiefCometh
.goto 18,69.45,62.81
.gossipoption 49018 >>If you see fire in front of you, talk to Zidormi. Otherwise skip this step
step
.isQuestAvailable 26965
.itemcount 132516,1
#completwith next
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
#label SilverpineTheWarchiefCometh
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Grand Executor Mortuus
.goto 18,55.06,70.76,75,0
.goto 21,66.98,6.68,30,0
.goto 21,57.43,10.14
.accept 26965 >>Accept The Warchief Cometh
.timer 300,Garrosh Roleplay
step
#completewith next
+|cfff78300Drag the RestedXP Target Macro to your bars. You can use it to check for rares|r
step
.goto 21,57.42,10.13
.complete 26965,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Grand Executor Mortuus
.goto 21,57.42,10.13
.turnin 26965 >>Turn in The Warchief Cometh
.accept 26989 >>Accept The Gilneas Liberation Front
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to High Apothecary Shana T'veen
.goto 21,56.26,8.40
.accept 26995 >>Accept Guts and Gore
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Apothecary Witherbloom
.goto 21,56.77,9.19
.accept 26992 >>Accept Agony Abounds
step
#completewith SilverpineWorgenRenegade
>>Kill |cff00ecffbeasts|r in the area. Loot them for their guts
>>Keep an eye out for the rares |cff00ecffKree and Gorefang|r
.unitscan Kree
.unitscan Gorefang
.goto 21,60.83,6.82,30,0
.goto 21,62.24,12.54,25,0
.goto 21,61.76,13.12,20,0
.goto 21,59.36,12.96,20,0
.goto 21,55.66,20.18,20,0
.goto 21,56.01,22.62,20,0
.complete 26995,1 
step
#completewith SilverpineWorgenRenegade
*>>Pick up Ferocious Doomweed from the ground
.complete 26992,1 
step
#label SilverpineWorgenRenegade
.goto 21,56.01,22.62,30,0
.goto 21,53.93,17.13,15,0
.goto 21,56.07,12.92
.complete 26989,1 
step
#sticky
#label SilverpineCleanBeastGuts
>>Kill |cff00ecffbeasts|r in the area. Loot them for their guts
>>Keep an eye out for the rares |cff00ecffKree and Gorefang|r
.unitscan Kree
.unitscan Gorefang
.goto 21,59.26,16.38,20,0
.goto 21,60.52,9.07,20,0
.complete 26995,1 
step
*>>Pick up Ferocious Doomweed from the ground
.goto 21,55.54,13.17,20,0
.goto 21,58.30,15.89,20,0
.goto 21,61.04,13.36,30,0
.goto 21,60.46,8.74
.complete 26992,1 
step
#requires SilverpineCleanBeastGuts
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Grand Executor Mortuus
.target Grand Executor Mortuus
.goto 21,57.41,10.12
.turnin 26989 >>Turn in The Gilneas Liberation Front
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Apothecary Witherbloom and High Apothecary Shana T'veen
.turnin 26992 >>Turn in Agony Abounds
.goto 21,56.76,9.19
.turnin 26995 >>Turn in Guts and Gore
.accept 26998 >>Accept Iterating Upon Success
.goto 21,56.26,8.40
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bat Handler Maggotbreath
.goto 21,57.91,8.71
.skipgossip 1
.complete 26998,1 
step
>>Spam |T236885:0|tBlight Concotion (1) on the Murlocs
*|cfff78300DON'T USE (2)|r
.complete 26998,2 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to High Apothecary Shana T'veen
.target High Apothecary Shana T'veen
.goto 21,56.26,8.40
.turnin 26998 >>Turn in Iterating Upon Success
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deathstalker Commander Belmont
.target Deathstalker Commander Belmont
.goto 21,58.09,8.98
.accept 27039 >>Accept Dangerous Intentions
step
>>Interact with the Abandoned Outhouse
.goto 21,53.90,13.01
.turnin 27039 >>Turn in Dangerous Intentions
.accept 27045 >>Accept Waiting to Exsanguinate
step
>>Interact with the Armoire. |cfff78300DON'T SKIP THE CINEMATIC|r
.goto 21,53.41,13.19,8,0
.goto 21,53.04,13.11,8,0
.goto 21,53.44,13.08,8,0
.goto 21,53.30,12.56
.complete 27045,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deathstalker Commander Belmont
.target Deathstalker Commander Belmont
.goto 21,58.09,8.98
.turnin 27045 >>Turn in Waiting to Exsanguinate
.accept 27056 >>Accept Belmont's Report
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
.target Lady Sylvanas Windrunner
.goto 21,57.37,10.20
.turnin 27056 >>Turn in Belmont's Report
.accept 27065 >>Accept The Warchief's Fleet
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Admiral Hatchet and Warlord Torok
>>Check the locations for the rares Nightlash, Gnath, and Bolgaff
.target Admiral Hatchet
.unitscan Nightlash
.unitscan Gnath
.unitscan Bolgaff
.goto 21,52.57,25.71,15,0
.goto 21,48.38,24.48,15,0
.goto 21,44.06,21.36
.turnin 27065 >>Turn in The Warchief's Fleet
.accept 27069 >>Accept Steel Thunder
.accept 27073 >>Accept Give 'em Hell!
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Apothecary Wormcrud
.target Apothecary Wormcrud
.goto 21,44.80,20.91
.accept 27082 >>Accept Playing Dirty
step
#completwith next
>>Kill |cff00ecffWorgs|r and |cff00ecffBears|r. Loot them for their organs
.goto 21,42.44,20.06,20,0
.goto 21,38.58,23.93,10,0
.goto 21,37.45,23.73
.complete 27082,1 
step
#completewith next
>>Kill |cff00ecffBloodfang Scavengers|r
.goto 21,39.41,25.88,20,0
.goto 21,37.89,27.44,20,0
.goto 21,38.79,30.30,20,0
.goto 21,40.19,29.25
.goto 21,39.20,28.09,0,0
.complete 27073,1 
step
>>Pick up the crates on the ground
.goto 21,39.20,28.09
.complete 27069,1 
step
#sticky
#label SilverpineBloodfangScavenger
>>Kill |cff00ecffBloodfang Scavengers|r
.goto 21,39.20,28.09
.complete 27073,1 
step
>>Kill |cff00ecffWorgen|r and |cff00ecffBears|r. Loot them for their organs
.goto 21,45.69,27.85
.complete 27082,1 
step
#requires SilverpineBloodfangScavenger
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Admiral Hatchet and Warlord Torok
.goto 21,44.00,21.34
.turnin 27069 >>Turn in Steel Thunder
.turnin 27073 >>Turn in Give 'em Hell!
.accept 27095 >>Accept Skitterweb Menace
.accept 27093 >>Accept Lost in the Darkness
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Apothecary Wormcrud
.goto 21,44.79,20.91
.turnin 27082 >>Turn in Playing Dirty
.accept 27088 >>Accept It's Only Poisonous if You Ingest It
step
#completewith SilverpineSkitterwebMatriarch
>>Destroy the |cff00ecffWebbed Victims|r
>>Keep an eye out for the rare |cff00ecffKrethis the Shadowspinner|r
.unitscan Krethis
.goto 21,35.90,14.58,0,0
.complete 27093,1 
step
#completewith SilverpineSkitterwebMatriarch
.goto 21,35.90,14.58,0,0
.complete 27095,1 
step
>>Follow the arrow into the mine. Jump up the rocks
>>|cfff78300There may be a chest next to the jumping location|r
.goto 21,35.14,11.29,10,0
.goto 21,35.47,10.51,10,0
.goto 21,34.95,10.29,10,0
.goto 21,35.56,9.29
.accept 27094 >>Accept Deeper into Darkness
step
#label SilverpineSkitterwebMatriarch
>>Kill |cff00ecffSkitterweb Matriarchs|r
.goto 21,35.94,8.65
.complete 27094,1 
step
#completewith next
.goto 21,35.85,7.98,10 >>Check for a possible chest
.goto 21,34.67,7.82,15,0
.goto 21,35.60,13.38,10 >>Leave the cave
step
#sticky
#label SilverpineOrcSeaDog
>>Destroy the |cff00ecffWebbed Victims|r
>>Keep an eye out for the rare |cff00ecffKrethis|r
.unitscan Krethis
.goto 21,34.80,15.02,30,0
.goto 21,35.60,17.69,30,0
.goto 21,35.90,14.58,0,0
.complete 27093,1 
step
>>Kill |cff00ecffSkitterweb Matriarchs|r
.goto 21,37.11,16.23,30,0
.goto 21,34.80,15.02,30,0
.goto 21,35.60,17.69,30,0
.goto 21,35.90,14.58
.complete 27095,1 
step
>>Click on the quest in your quest log under your minimap
.turnin 27095 >>Turn in Skitterweb Menace
step
#requires SilverpineOrcSeaDog
>>Use the Mutant Bush Chicken Cage on the Ettin.
*The Ettin runs around the village. Click on the quest on the map/quest tracker to track the Ettin. You should see a small yellow waypoint at his position.
.goto 21,46.68,18.04,30,0
.goto 21,46.20,28.45,30,0
.goto 21,39.64,29.99,30,0
.goto 21,39.90,16.58
.use 60808
.complete 27088,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Apothecary Wormcrud, Admiral Hatchet, and Warlord Torok
.turnin 27088 >>Turn in It's Only Poisonous if You Ingest It
.goto 21,44.79,20.91
.turnin 27093 >>Turn in Lost in the Darkness
.turnin 27094 >>Turn in Deeper into Darkness
.accept 27096 >>Accept Orcs are in Order
.goto 21,44.01,21.32
step
#completewith next
.goto 21,45.94,21.88
.fly Forsaken High Command >>Fly to Forsaken High Command
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
*Dismount before talking to Sylvanas
.goto 21,57.37,10.20
.turnin 27096 >>Turn in Orcs are in Order
.accept 27097 >>Accept Rise, Forsaken
step
>>Kill |cff00ecffHillsbrad Refugees|r while Agatha is next to you
*Wait until Agatha spawns before mounting up. If she despawns just dismount and wait for her to reappear
.goto 21,64.87,19.37,30,0
.goto 21,65.70,26.35
.complete 27097,1 
step
>>Click on the quest in your quest log under your minimap
.goto 21,65.70,26.35
.turnin 27097 >>Turn in Rise, Forsaken
.accept 27099 >>Accept No Escape
step
.goto 21,65.73,24.39,10,0
.goto 21,66.27,24.34,10,0
.goto 21,66.07,23.92,10,0
.goto 21,65.54,23.44,10,0
.goto 21,65.92,23.35,8,0
.goto 21,65.94,23.91,8,0
.goto 21,65.29,23.94,10,0
.goto 21,65.27,24.97
>>Find the leaders upstaris. You don't need to kill any mobs if you can survive it.
*|cfff78300DON'T SKIP THE CINEMATIC|r
.complete 27099,1 
step
#completewith next
+You can skip the next cutscene (Esc -> Yes)
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
.goto 21,57.35,10.21
.turnin 27099 >>Turn in No Escape
.accept 27098 >>Accept Lordaeron
step
.complete 27098,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
.goto 21,44.89,41.65
.turnin 27098 >>Turn in Lordaeron
.accept 27180 >>Accept Honor the Dead
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Admiral Hatchet and Warlord Torok
.goto 21,45.78,41.94
.accept 27226 >>Accept Hair of the Dog
.accept 27231 >>Accept Reinforcements from Fenris
step
#completewith SilverpineAcceptExcisingtheTaint
.goto 21,45.41,42.48
.fp >>Get the The Sepulcher Flight Path
step
#label SilverpineAcceptExcisingtheTaint
>>Kill a |cff00ecffBloodfang Stalker|r to trigger the quest
.goto 21,47.28,46.68
.accept 27181 >>Accept Excising the Taint
step
#completewith next
>>Loot the corpses of Veteran Forsaken Troopers on the ground
.complete 27180,1 
step
>>Kill |cff00ecffBloodfang Stalkers|r
>>Keep an eye out for the rare Berard the Moon-Crazed
.unitscan Berard the Moon-Crazed
.goto 21,43.34,50.79,15,0
.goto 21,46.27,51.27,25,0
.goto 21,47.48,49.47,30,0
.goto 21,47.03,53.10
.complete 27181,1 
step
>>Click on the quest in your quest log under your minimap
.turnin 27181 >>Turn in Excising the Taint
.accept 27193 >>Accept Seek and Destroy
step
>>Kill |cff00ecffCaretaker Smithers|r. Loot him for his logbook
.goto 21,45.90,54.23
.complete 27193,1 
step
>>Click on the quest in your quest log under your minimap
.turnin 27193 >>Turn in Seek and Destroy
.accept 27194 >>Accept Cornered and Crushed!
step
>>Loot the corpses of Veteran Forsaken Troopers on the ground
.goto 21,47.03,53.10,30,0
.goto 21,46.27,51.27,25,0
.goto 21,47.48,49.47,30,0
.goto 21,47.03,53.10
.complete 27180,1 
step
#requires SilverpineForsakenInsignia
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Master Forteski and follow him
.goto 21,55.88,46.35
.turnin 27194 >>Turn in Cornered and Crushed!
.accept 27195 >>Accept Nowhere to Run
step
*Don't run too far away from Master Forteski
.goto 21,58.05,44.89
.complete 27195,1 
step
#completewith next
.goto 21,56.46,46.06,10 >>Leave the cave
step
#completewith SilverpineHairoftheDog
>>Kill |cff00ecffHillsbrad Worgen|r
.goto 21,56.64,34.11,0,0
.complete 27231,1 
step
#title Orc roused 1
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,54.25,38.83
.use 60870
.complete 27226,1,1 
step
#completewith next
.goto 21,53.51,38.64,10 >>Check for a possible chest
step
#title Orc roused 2
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,53.86,37.49
.use 60870
.complete 27226,1,2 
step
#title Orc roused 3
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,54.37,36.25
.use 60870
.complete 27226,1,3 
step
#title Orc roused 4
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,53.91,35.74
.use 60870
.complete 27226,1,4 
step
#completewith next
.goto 21,54.43,34.34,10 >>Check for a possible chest
step
#title Orc roused 5
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,54.47,33.00
.use 60870
.complete 27226,1,5 
step
#title Orc roused 6
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,56.08,32.18
.use 60870
.complete 27226,1,6 
step
#title Orc roused 7
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,57.05,32.67
.use 60870
.complete 27226,1,7 
step
#label SilverpineHairoftheDog
#title Orc roused 8
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,57.76,34.06
.use 60870
.complete 27226,1 
step
>>Kill |cff00ecffHillsbrad Worgen|r
.goto 21,57.01,34.96,30,0
.goto 21,54.34,34.19,30,0
.goto 21,52.93,31.90,30,0
.goto 21,56.64,34.11,0,0
.complete 27231,1 
step
>>Interact with the Horde Communication Panel
.goto 21,59.24,34.22
.turnin 27231 >>Turn in Reinforcements from Fenris
.accept 27232 >>Accept The Waters Run Red...
step
#completewith next
.goto 21,59.62,33.53
.vehicle 45263 >>Enter the Horde Cannon
step
>>Use |T133032:0|tRocket Blast (1) to kill the arriving Worgen
>>Keep an eye out for the rare Fenwick Thatros
.unitscan Fenwick Thatros
.goto 21,59.38,33.46,8,0
.goto 21,59.62,33.53
.complete 27232,1 
step
#completewith SilverpineTheWatersRunRed
.deathskip >>Pull some mobs, die and ress at the spirit healer
step
#completewith next
.goto 21,46.43,42.70
.vendor
step
#label SilverpineTheWatersRunRed
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Admiral Hatchet and Warlord Torok
.goto 21,45.79,41.90
.turnin 27232 >>Turn in The Waters Run Red...
.turnin 27226 >>Turn in Hair of the Dog
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
.goto 21,44.94,41.66
.turnin 27180 >>Turn in Honor the Dead
.turnin 27195 >>Turn in Nowhere to Run
step
.maxlevel 19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
.goto 21,44.94,41.66
.accept 27290 >>Accept To Forsaken Forward Command
step
.maxlevel 19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly with Arthura and talk to Deathstalker Commander Belmont
.goto 217,57.46,18.77
.turnin 27290 >>Turn in To Forsaken Forward Command
.accept 27342 >>Accept In Time, All Will Be Revealed
step
.maxlevel 19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Forward Commander Onslaught
.goto 217,57.54,18.24
.accept 27333 >>Accept Losing Ground
.accept 27345 >>Accept The F.C.D.
step
.isOnQuest 27333
#completewith next
>>Kill |cff00ecffWorgen Rebels|r
.goto 217,55.39,13.66,20,0
.complete 27333,1 
step
.isOnQuest 27333
#title Kill Korok for his head
#sticky
#label SilverpineKorokSecondHead
>>Kill |cff00ecffKorok|r (patrolling). Loot him for his head. Click it in your bags
.goto 217,50.26,19.52,15,0
.goto 217,50.26,19.52,0,0
.collect 60956,1,27322,1
.accept 27322 >>Accept Korok the Colossus
step
.isOnQuest 27345
>>Pick up the device on the ground
.goto 217,45.76,21.96
.complete 27345,1 
step
.isOnQuest 27333
#requires SilverpineKorokSecondHead
#sticky
#label SilverpineWorgenRebel
.goto 217,54.21,22.11,20,0
.goto 217,55.10,26.28,15,0
.goto 217,54.84,19.34,0,0
.complete 27333,1 
step
.isOnQuest 27342
#requires SilverpineKorokSecondHead
>>Loot Wolfsbane around the waypoint
*Spawn is too random to place exact waypoints
.goto 217,58.82,32.55,20,0
.goto 217,62.30,33.88,30,0
.goto 217,63.78,31.96,30,0
.goto 217,59.83,28.20
.complete 27342,1 
step
#requires SilverpineWorgenRebel
.goto 217,57.49,18.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Onslaught and Belmont
.turnin -27333 >>Turn in Losing Ground
.turnin -27345 >>Turn in The F.C.D.
.turnin -27322 >>Turn in Korok the Colossus
.turnin -27342 >>Turn in In Time, All Will Be Revealed
step
.isQuestTurnedIn 27342
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Onslaught and Belmont
.goto 217,57.49,18.48
.accept 27349 >>Accept Break in Communications: Dreadwatch Outpost
step
.isOnQuest 27349
*It may not complete if you fly too high.
>>Follow the arrow
.goto 217,52.70,32.23
.complete 27349,1 
step
>>Click on the quest in your quest log under your minimap
.goto 217,52.76,32.36
.turnin -27349 >>Turn in Break in Communications: Dreadwatch Outpost
step
.isQuestTurnedIn 27349
>>Click on the quest in your quest log under your minimap
.goto 217,52.76,32.36
.accept 27350 >>Accept Break in Communications: Rutsak's Guard
step
.isOnQuest 27350
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Captain Rutsak
.goto 217,65.64,34.21
.turnin 27350 >>Turn in Break in Communications: Rutsak's Guard
step
.maxlevel 19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Captain Rutsak
.goto 217,65.64,34.21
.accept 27360 >>Accept Vengeance for Our Soldiers
.accept 27364 >>Accept On Whose Orders?
step
.isOnQuest 27360
#completewith next
.complete 27360,1 
step
.isOnQuest 27364
>>Kill |cff00ecffMaster Seargent Pietro Zaren|r. Loot him for the orders
.goto 217,58.76,47.38
.complete 27364,1 
step
>>Click on the quest in your quest log under your minimap
.goto 217,58.17,47.43
.turnin -27364 >>Turn in On Whose Orders?
step
.isQuestTurnedIn 27364
>>Click on the quest in your quest log under your minimap
.goto 217,58.17,47.43
.accept 27401 >>Accept What Tomorrow Brings
step
.isOnQuest 27360
*Be careful not to pull too many because they can do a lot of damage.
.goto 217,60.12,45.39,20,0
.goto 217,59.17,42.96,20,0
.goto 217,57.91,45.44,20,0
.goto 217,56.73,48.52
.complete 27360,1 
step
.isOnQuest 27401
>>Interact with the spyglass
*|cfff78300DON'T SKIP THE CINEMATIC|r
.goto 217,54.72,44.45
.complete 27401,1 
step
>>Click on the quest in your quest log under your minimap
.goto 217,54.72,44.45
.turnin -27401 >>Turn in What Tomorrow Brings
step
.isQuestTurnedIn 27401
>>Click on the quest in your quest log under your minimap
.goto 217,54.72,44.45
.accept 27405 >>Accept Fall Back!
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Captain Rutsak
.goto 217,65.70,34.29
.turnin -27360 >>Turn in Vengeance for Our Soldiers
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deathstalker Commander Belmont
.goto 217,72.88,30.21
.turnin -27405 >>Turn in Fall Back!
step
.maxlevel 19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deathstalker Commander Belmont
.goto 217,72.88,30.21
.accept 27406 >>Accept A Man Named Godfrey
step
.isOnQuest 27406
>>You automatically accept it when you reach the waypoint
.goto 217,73.76,32.85
.accept 27423 >>Accept Resistance is Futile
step
.isOnQuest 27406
#completewith next
+|cfff78300Dismount if no NPC is following you to make them spawn|r
step
.isOnQuest 27423
*Focus on the Bloodfang Scout + 5 Gilnean Warhound packs
.goto 217,71.84,42.71,20,0
.goto 217,71.78,51.53,20,0
.goto 217,76.38,56.02,20,0
.goto 217,77.65,61.04
.complete 27423,1 
step
.isOnQuest 27406
>>Interact with the corpse of Lord Godfrey
.goto 217,79.70,75.78
.complete 27406,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deathstalker Commander Belmont
*Dismount if no NPC is following you to make them spawn.
.goto 217,79.70,75.78
.turnin -27406 >>Turn in A Man Named Godfrey
.turnin -27423 >>Turn in Resistance is Futile
step
.isQuestTurnedIn 27423
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deathstalker Commander Belmont
*Dismount if no NPC is following you to make them spawn.
.goto 217,79.70,75.78
.accept 27438 >>Accept The Great Escape
step
.goto 21,51.77,66.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
.turnin -27438 >>Turn in The Great Escape
step
.maxlevel 19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
.goto 21,51.77,66.06
.accept 27472 >>Accept Rise, Godfrey
step
.isOnQuest 27472
#completewith SilverpineLordGodfreyReborn
+|cfff78300You only have roughly 40 seconds to search for the next two Rares|r. Run back early if you're too slow. If you miss the timer, abandon the quest and start it again.
step
.isOnQuest 27472
#completewith next
*You have to pull him with a ranged ability as you can't see him near the Forsaken Front
.goto 21,48.53,69.00,15 >>Search for Corpsefeeder behind you
step
.isOnQuest 27472
#completewith next
.goto 21,47.43,69.93,15 >>Search for Effritus
step
.isOnQuest 27472
#label SilverpineLordGodfreyReborn
.unitscan Effritus
.unitscan Corpsefeeder
.goto 21,51.73,65.50
.complete 27472,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner and Daschla
.goto 21,51.88,65.08
.turnin -27472 >>Turn in Rise, Godfrey
step
.maxlevel 19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner and Daschla
.accept 27474 >>Accept Breaking the Barrier
.goto 21,51.88,65.08
.accept 27475 >>Accept Unyielding Servitors
.goto 21,51.91,64.69
step
.isOnQuest 27475
#completewith next
#title Check for Chest
.goto 21,58.48,61.62,8 >>Check possible Chest location
step
.isOnQuest 27475
#completewith SilverpineBreakingtheBarrier
>>Kill the |cff00ecffelementals|r in the area. Loot them for their cores
.goto 21,59.51,64.29,0,0
.complete 27475,1 
step
.isOnQuest 27474
#completewith next
.goto 21,62.84,64.02,8 >>Enter the building
step
.isOnQuest 27474
#label SilverpineBreakingtheBarrier
>>Pick up the book.
.goto 21,63.48,64.25
.complete 27474,1 
step
.isOnQuest 27475
#completewith next
.goto 21,62.84,64.02,8 >>Leave the building
step
.isOnQuest 27475
>>Kill the |cff00ecffelementals|r in the area. Loot them for their cores
.goto 21,59.51,64.29,0,0
.complete 27475,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Daschla and Lady Sylvanas Windrunner
.turnin -27475 >>Turn in Unyielding Servitors
.goto 21,51.89,64.67
.turnin -27474 >>Turn in Breaking the Barrier
.goto 21,51.94,64.99
step
.zoneskip 85
.hs >>Hearth to The Broken Tusk (Orgrimmar)
step
#completewith next
+Activate War Mode by clicking it on the bottom right of your Talent Window (N on your keyboard). This will increase all experience gains by 10%, but turn your pvp mode on. You can skip this step/disable it easily in the future if you wish
step
.goto 85,43.90,73.06,15,0
.goto 85,38.56,78.22
.skill riding,150 >>Train Journeyman Riding
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Horde 10-60
#name 1 Horde Zuldazar First Half
#displayname Chapter 3 - Zuldazar Beginning
#next 2 Horde Nazmir
#maxlevel 60
#fresh
<< Horde
step
#completewith next
.goto 85,53.49,90.43,10,0
.goto 85,58.53,91.28
.zone 1163 >>Take the portal to Zuldazar
step
.goto 1164,41.67,69.17
>>Click the Scouting Map, then click on Zuldazar. Accept the quest
.accept 47514 >>Accept Zuldazar
step
>>Talk to Talanji
.goto 1164,41.22,66.75
.turnin 47514 >>Turn in Zuldazar
.accept 49615 >>Accept Trust of a King
step
#completewith next
.goto 1164,22.67,72.08,5,0
.goto 1165,48.72,44.92,10,0
.goto 1165,49.56,44.60,18 >>Take the elevator up to King Rastakhan
step
>>Talk to King Rastakhan, Zolani, and Yazma
.goto 1164,22.67,72.08,5,0
.goto 1165,48.72,44.92,10,0
.goto 1165,49.56,44.60,18,0
.turnin 49615 >>Turn in Trust of a King
.accept 49488 >>Accept Tal'gurub
.goto 1165,49.93,46.62
.accept 50835 >>Accept The Port of Zandalar
.goto 1165,49.82,46.55
.accept 47445 >>Accept The Zanchuli Council
.goto 1165,49.73,46.51
step
#completewith next
.goto 1165,48.58,42.83,20,0
.goto 1165,48.51,37.82,15,0
.goto 1165,47.79,37.53,15,0
.goto 1165,46.97,37.19,15,0
.goto 1165,45.20,37.20,15,0
.goto 1165,45.22,31.83,20,0
.goto 1165,42.19,26.22,20 >>|cfff78300Follow the arrow.|r Jump down Dazar'alor carefully. Be careful of fall damage
step
>>Talk to Wardruid Loti
.goto 1165,45.26,24.02
.turnin 47445 >>Turn in The Zanchuli Council
.accept 47423 >>Accept Forbidden Practices
step
.goto 1165,47.30,21.67,30,0
.goto 1165,48.09,20.82,30,0
.goto 1165,48.92,18.10,30,0
.goto 1165,49.84,17.92,30,0
.goto 1165,50.31,15.00,30,0
.goto 1165,50.40,13.00,30,0
.goto 1165,50.65,10.74,30,0
.goto 1165,51.65,10.35,30,0
.goto 1165,47.30,21.67
.complete 47423,1 
>>Use |T136008:0|t[Loti's Totem] near Zanchuli Acolytes to reveal them
.use 152627
step
>>Talk to Hexlord Raal
.goto 1165,51.90,11.89
.turnin 47423 >>Turn in Forbidden Practices
.accept 47433 >>Accept Offensively Defensive
step
>>Mount Ata the Windlord
.goto 1165,53.20,11.63
.complete 47433,2 
step
>>Use the "Farseer Totems" (1) on the glowing circles. Make sure to zoom out and look around
*The first one is directly below the starting position
.complete 47433,3 
step
>>Talk to Wardruid Loti
.goto 1165,46.21,19.25
.turnin 47433 >>Turn in Offensively Defensive
.accept 47435 >>Accept Pterrortorial Dispute
.accept 47434 >>Accept Restraining Order
step
.goto 1165,42.88,19.90,30,0
.goto 1165,41.91,16.04,30,0
.goto 1165,40.91,15.02,30,0
.goto 1165,38.59,15.73,30,0
.goto 1165,38.35,10.85,30,0
.goto 1165,39.42,14.08,30,0
.goto 1165,42.88,19.90
>>Run through Hatchlings to shoo them. Kill Bloodraged Pterrordax
.complete 47434,1 
.complete 47435,1 
step
>>Talk to Hexlord Raal
.goto 1165,40.92,11.33
.turnin 47435 >>Turn in Pterrortorial Dispute
.turnin 47434 >>Turn in Restraining Order
.accept 47437 >>Accept Competitive Devotion
step
>>Kill the Guardians inside the building
.complete 47437,1 
.goto 1167,65.69,69.07
.complete 47437,2 
.goto 1167,36.71,25.13,15,0
.goto 1167,43.96,14.80,15,0
.goto 1167,43.47,33.73,15,0
.goto 1166,65.91,30.73
step
.complete 47437,3 
.goto 1166,66.62,69.40,15,0
.goto 1166,78.58,86.53,15,0
.goto 1165,44.29,16.71
step
>>Climb the pyramid and talk to Wardruid Loti
.goto 1165,46.06,15.65,14,0
.goto 1165,46.11,13.07
.turnin 47437 >>Turn in Competitive Devotion
.accept 47422 >>Accept Dire Situation
step
.goto 1165,43.64,7.39
.complete 47422,1 
step
.isQuestAvailable 47438
#completewith next
+|cfff78300Please follow the waypoint and the instructions perfectly and choose the Pterrodax not the Raptor on the next quest. Disable other AddOns that automatically turn in quests.|r
step
.isQuestAvailable 47438
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
.turnin 47422 >>Turn in Dire Situation
.accept 47438 >>Accept Picking a Side
.goto 1165,42.30,9.10
step
.isQuestAvailable 47438
#completewith next
+|cfff78300Please follow the waypoint and the instructions perfectly and choose the Pterrodax not the Raptor on the next quest. Disable other AddOns that automatically turn in quests.|r
step
.isQuestAvailable 47438
>>Click Pa'ku to choose her
.complete 47438,1 
.goto 1165,42.61,9.21
step
.isQuestTurnedIn 47443
>>You've chosen the wrong loa, reaccept the quest and pick the pterrodax. If you've already accidently turned in the quest the skip this step.
.abandon 47438
step
.isQuestAvailable 47438
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
.accept 47438 >>Accept Picking a Side
.goto 1165,42.30,9.10
step
.isQuestAvailable 47438
>>Click Pa'ku to choose her
.complete 47438,1 
.goto 1165,42.61,9.21
step
.isQuestTurnedIn 47436
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
.turnin 47438 >>Turn in Picking a Side
.goto 1165,42.30,9.10
step
.isQuestTurnedIn 47436
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hexlord Raa
.accept 47440 >>Accept Pa'ku, Master of Winds
.goto 1165,42.54,9.49
step
.isQuestTurnedIn 47443
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
.goto 1165,42.30,9.10
.accept 47439 >>Accept Gonk, Lord of the Pack
step
.isQuestTurnedIn 47443
#completewith next
.goto 1165,42.27,9.47,1 >>Run through the Totem of Gonk to gain his buff. The buff reduces your falling damage and increases your movement speed
.goto 1165,40.51,9.40,15,0
.goto 1165,37.95,11.25,20,0
.goto 1165,36.28,7.99,25 >>Jump down
step
.isQuestTurnedIn 47443
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gonk
.goto 862,48.18,32.27
.skipgossip
.complete 47439,1 
step
.isQuestTurnedIn 47443
#completewith next
.goto 862,48.05,28.70,20,0
.goto 862,48.56,26.87,20,0
.goto 862,49.72,26.27
.fly The Great Seal >>Fly to The Great Seal
step
.isQuestTurnedIn 47443
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Huntmaster Kil'ja
.accept 49768 >>Accept Nesingwary's Trek
.goto 1165,52.00,41.39
step
.isQuestTurnedIn 47443
#completewith next
.goto 1165,50.49,40.70,10 >>Run through the Gonk Totem to get his buff
step
.isQuestTurnedIn 47443
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tJump down and talk to Wardruid Loti
.goto 1165,49.92,33.42
.turnin 47439 >>Turn in Gonk, Lord of the Pack
.accept 48897 >>Accept The Bargain is Struck
step
.isQuestTurnedIn 47443
#completewith Hatchling
.cast 6478 >>Click the Altar of Gonk to gain a passive damage buff
.goto 1165,49.92,33.10
step
.isQuestTurnedIn 47443
#completewith Hatchling
.itemcount 109076,<1
.goto 1165,52.27,32.40,18,0
.goto 1165,54.56,32.10,20,0
.goto 1165,58.14,26.43,25,0
.goto 1165,58.40,18.28,25,0
.goto 1165,61.83,35.70,25 >>Follow the arrow down
step
.isQuestTurnedIn 47443
#completewith next
.itemcount 109076,1
.use 109076
.cast 126389 >>Use the Goblin Glider Kit to glide down to the quest
step
.isQuestTurnedIn 47443
#label Hatchling
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Direhorn Hatchling
.goto 862,65.66,41.35
.accept 47226 >>Accept The Orphaned Hatchling
step
.isOnQuest 47440
>>Mount Ata the Winglord
.goto 1165,42.51,10.05
.complete 47440,1 
step
.isQuestTurnedIn 47436
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Pa'ku
.goto 862,71.31,48.67,15,0
.goto 862,71.52,49.40
.complete 47440,2 
step
.isQuestTurnedIn 47436
#completewith next
+If you wish to save time, open up the Battle Net client on your computer
step
.isQuestTurnedIn 47436
.goto 862,71.78,49.24,12,0
.goto 862,72.1,49.5
.complete 47440,3 
.timer 52,Flight Duration
step
.isQuestTurnedIn 47436
#completewith next
+Press "Play" on the Battle Net client to open a second WoW client. Do NOT close your first client. Log in on your second client, wait until you can move, then close your first client
step
.isQuestTurnedIn 47436
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hexlord Raal
.goto 1165,49.92,33.41
.turnin 47440 >>Turn in Pa'ku, Master of Winds
.accept 47432 >>Accept The Bargain is Struck
step
.isQuestTurnedIn 47436
#completewith next
.cast 6478 >>Click the Altar of Pa'ku to gain a movement speed buff
.goto 1165,49.92,33.10
step
.isQuestTurnedIn 47436
#completewith next
.vehicle 131154 >>Click the Totem of Pa'ku
.goto 1165,49.54,32.83
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Huntmaster Kil'ja
.accept 49768 >>Accept Nesingwary's Trek
.goto 1165,52.00,41.39
step << !DemonHunter
.isQuestTurnedIn 47436
#completewith TotemPaku1
.goto 1165,51.12,40.45,15,0
.goto 1165,51.35,37.81,15,0
.goto 1165,52.96,37.08,15,0
.goto 1165,54.54,35.71,20,0
.goto 1165,58.28,35.06,25,0
.goto 1165,58.30,32.63,40 >> Travel down Dazar'alor
.itemcount 109076,<1
step
.isQuestTurnedIn 47436
#completewith next
.cast 126389 >>Use a |T133632:0|t[Goblin Glider Kit] from atop the Golden Throne to glide down
.use 109076
.itemcount 109076,1
step
.isQuestTurnedIn 47436
#label TotemPaku1
#completewith Hatchling2
.goto 1165,58.30,32.63
.vehicle 131154 >>Click the Totem of Pa'ku
.timer 11,Pa'ku Flight
.itemcount 109076,<1
step
#label Hatchling2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Direhorn Hatchling
.goto 862,65.66,41.35
.accept 47226 >>Accept The Orphaned Hatchling
step
.goto 862,66.57,40.25,20,0
.goto 862,66.69,40.94,10,0
.goto 862,66.81,42.51
>>Talk to Beastlord L'kala
.turnin 47226 >>Turn in The Orphaned Hatchling
.accept 47259 >>Accept Direhorn Daycare
.accept 48527 >>Accept Ravenous Landsharks
step
#completewith DirehornD
.goto 862,66.56,42.35
.home >>Set your Hearthstone to Beastcaller Inn
step
#completewith next
.goto 862,68.35,45.75,0,0
.complete 48527,1 
step
>>Click the Soothing Lilybuds
*When the plant keeps glowing you have to click it again
.goto 862,68.09,43.42,6,0
.goto 862,68.70,43.99,6,0
.goto 862,68.96,44.07,6,0
.goto 862,69.90,44.22,6,0
.goto 862,69.53,44.95,6,0
.goto 862,69.20,45.51,6,0
.goto 862,68.88,45.34,6,0
.goto 862,68.65,44.48,6,0
.goto 862,68.11,44.31,6,0
.complete 47259,1 
step
.goto 862,69.04,47.68,30,0
.goto 862,69.61,44.45,30,0
.goto 862,68.96,43.89
>>Kill Irritable Diemetradons
.complete 48527,1 
step
#label DirehornD
#requires ZuldazarIrritableDiemetraden
>>Talk to Beastlord L'kala and Trader Alexxi
.turnin 47259 >>Turn in Direhorn Daycare
.turnin 48527 >>Turn in Ravenous Landsharks
.accept 47311 >>Accept Headbutting 101
.goto 862,66.81,42.51
.accept 47272 >>Accept Direhorn Growth Hormone
.goto 862,66.81,42.58
step
#completewith next
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
step
>>Talk to the Wanted poster and Wingrider Nivek
.accept 51980 >>Accept WANTED: Jabra'kan
.goto 862,69.07,40.85
.accept 47312 >>Accept Queenfeather
.goto 862,69.02,40.69
step
#completewith next
>>Use your Extra Action Button ON COOLDOWN on Savagemane Ravasaurs and Invasive Eggsnatchers
>>Loot the Steaming Fresh Carrions on the ground
.complete 47311,1 
.complete 47272,1 
step
>>Kill Queenfeather. Loot her for her Plume
.goto 862,71.14,40.26
.complete 47312,1 
step
.loop 30,862,71.36,41.35,71.40,40.68,70.72,39.81,70.76,39.47,70.48,38.95,70.00,39.24,70.00,40.50,70.13,40.39,70.53,40.62,70.82,40.94,71.36,41.35
>>Use your Extra Action Button ON COOLDOWN on Savagemane Ravasaurs and Invasive Eggsnatchers
>>Loot the Steaming Fresh Carrions on the ground
.complete 47311,1 
.complete 47272,1 
step
.goto 862,67.07,37.11
>>Kill Jabra'kan. Move away from Traps he throws at you and the cone damage from his Volley
.complete 51980,1 
step
>>Talk to Wingrider Nivek
.goto 862,69.02,40.69
.turnin 51980 >>Turn in WANTED: Jabra'kan
.turnin 47312 >>Turn in Queenfeather
step
>>Talk to Beastlord L'kala, Trader Alexxi, then L'kala again
.turnin 47311 >>Turn in Headbutting 101
.goto 862,66.81,42.51
.turnin 47272 >>Turn in Direhorn Growth Hormone
.accept 51998 >>Accept DGH: Now With Real Direhorn
.goto 862,66.81,42.58
.accept 51990 >>Accept Wings for the Kraal
.goto 862,66.81,42.51
step
#completewith next
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
step
#completewith ZuldazarNearlyHatchungEgg
>>Kill Pterrodax Skyrenders and Wild Pterrorchicks. Loot them for their Flesh
.complete 51998,1 
step
#completewith next
.goto 862,67.05,36.42,30,0
.goto 862,66.80,36.17,20 >> Run up the path to the Skyrender Eyrie
step
#title Egg 1
.goto 862,66.77,35.52
>>Loot the Egg on the ground
.complete 51990,1,1 
step
#title Egg 2
.goto 862,66.95,34.98
>>Loot the Egg on the ground
.complete 51990,1,2 
step
#title Egg 3
.goto 862,67.05,34.47
>>Loot the Egg on the ground
.complete 51990,1,3 
step
#title Egg 4
.goto 862,67.01,33.87
>>Loot the Egg on the ground
.complete 51990,1,4 
step
#title Egg 5+6
.goto 862,66.81,33.98,-1
.goto 862,66.85,34.10,-1
>>Loot the Eggs on the ground
.complete 51990,1,6 
step
#label ZuldazarNearlyHatchungEgg
#title Egg 7+8
.goto 862,66.71,34.50
>>Loot the Eggs on the ground
.complete 51990,1 
step
.goto 862,66.02,32.86,40,0
.goto 862,67.71,31.93,40,0
.goto 862,66.77,35.52
>>Kill Pterrodax Skyrenders and Wild Pterrorchicks. Loot them for their Flesh
.complete 51998,1 
step
#completewith next
.goto 862,65.81,34.78,25,0
.goto 862,64.83,34.99,25,0
.goto 862,63.79,35.11,50 >>Jump down the cliffs
step
.goto 862,62.82,32.56
>>Talk to Zul
.turnin 49488 >>Turn in Tal'gurub
.accept 49489 >>Accept Needs a Little Body
.accept 49490 >>Accept The Urn of Voices
step
#completewith ZuldazarVoodooTotemEight
>>Kill the Jambani and Masks for their souls
.complete 49490,1 
step
.goto 862,63.62,31.76
>>Talk to Izita's Spirit
.accept 49491 >>Accept Fuel for the Voodoo
step
#title Totem 1
.goto 862,64.19,32.82
>>Loot the Totem on the ground
.complete 49491,1,1 
step
#title Totem 2
.goto 862,64.72,32.98
>>Loot the Totem on the ground
.complete 49491,1,2 
step
#sticky
#label Totem3
#title Totem 3
.goto 862,64.98,32.91,-1
>>Loot the Totem on the ground
.complete 49491,1,3 
step
#title Concotion 1
>>Go inside the building. Click Atal'jamba Ungo
.goto 862,65.03,32.98,-1
.complete 49489,1,1 
step
#requires Totem3
#completewith next
.goto 862,64.36,33.14,15,0
.goto 862,63.94,32.49,20 >>Go back across the bridge, then turn right as you get onto the stairs
step
#requires Totem3
#title Totem 4
.goto 862,63.91,31.92
>>Loot the Totem on the ground
.complete 49491,1,4 
step
#title Totem 5
.goto 862,63.74,30.83
>>Loot the Totem on the ground
.complete 49491,1,5 
step
#title Totem 6
.goto 862,63.11,30.22
>>Loot the Totem on the ground
.complete 49491,1,6 
step
#title Concotion 2
>>Go inside the building. Click Atal'jamba Iri
.goto 862,63.07,29.06,12,0
.goto 862,63.20,29.06
.complete 49489,1 
step
#title Totem 7
.goto 862,62.70,29.09
>>Loot the Totem on the ground
.complete 49491,1,7 
step
#label ZuldazarVoodooTotemEight
#title Totem 8
.goto 862,62.88,28.61
>>Loot the Totem on the ground
.complete 49491,1,8 
step
.goto 862,62.70,29.09,40,0
.goto 862,63.11,30.22,40,0
.goto 862,63.74,30.83,40,0
.goto 862,63.91,31.92,40,0
.goto 862,64.19,32.82,40,0
.goto 862,64.72,32.98
>>Kill the Jambani and Masks for their souls
.complete 49490,1 
step
>>Talk to the Brazier and Zul
.turnin 49491 >>Turn in Fuel for the Voodoo
.goto 862,62.74,28.43
.turnin 49489 >>Turn in Needs a Little Body
.turnin 49490 >>Turn in The Urn of Voices
.accept 49492 >>Accept Arrogance of Vol'jamba
.goto 862,62.86,28.24
step
>>Click the Masks on the wall. Don't worry about their traps
.complete 49492,1 
.goto 862,62.90,28.00
.complete 49492,2 
.goto 862,63.55,28.08
.complete 49492,3 
.goto 862,64.12,28.37
.timer 20,Zul RP
step
>>Wait for Zul to walk up the stairs. Talk to him
.goto 862,64.38,28.55
.turnin 49492 >>Turn in Arrogance of Vol'jamba
.accept 49493 >>Accept Zul's Ethical Dilemma
.accept 49494 >>Accept Zuvembi Brew
step
#completewith ZuldazarJambaniStockpiles
>>Use the |T237388:0|t[Mindbreaker Chant] while standing in melee range of Mindslaved Berserkers and Mindslaved Gurubashi. Try to free multiple in one cast
.use 155458
.complete 49493,1 
step
.goto 862,64.88,27.00
>>Kill Zuvembi Brewer Zekal
.complete 49494,1 
step
.goto 862,65.29,28.19
>>Talk to the Jambani Stockpile, then click it again to burn it
.accept 51663 >>Accept Preparing for the Fall
.complete 51663,1,1 
step
#title Stockpile 2
>>Click the Jambani stockpile to burn it
.goto 862,65.39,27.86
.complete 51663,1,2 
step
#title Stockpile 3
>>Click the Jambani stockpile to burn it
.goto 862,65.00,28.34
.complete 51663,1,3 
step
#title Stockpile 4
>>Click the Jambani stockpile to burn it
.goto 862,64.92,28.36
.complete 51663,1,4 
step
#title Stockpile 5
>>Click the Jambani stockpile to burn it
.goto 862,64.66,28.64
.complete 51663,1,5 
step
#title Stockpile 6
>>Click the Jambani stockpile to burn it
.goto 862,64.61,29.82
.complete 51663,1,6 
step
#title Stockpile 7
>>Click the Jambani stockpile to burn it
.goto 862,65.02,29.62
.complete 51663,1,7 
step
#label ZuldazarJambaniStockpiles
#title Stockpile 8
>>Click the Jambani stockpile to burn it
.goto 862,65.59,29.14
.complete 51663,1 
step
>>Use the Mindbreaker Chant while standing in/near Mindslaved Berserkers/Gurubashi
.use 155458
.goto 862,66.35,29.55,30,0
.goto 862,66.47,28.56,30,0
.goto 862,66.07,28.57,30,0
.goto 862,64.66,28.64,30,0
.goto 862,64.61,29.82
.complete 49493,1 
step
#completewith next
.goto 862,65.71,30.21,40 >>Climb the stairs
step
>>Talk to Zul
.goto 862,65.71,30.21
.turnin 49493 >>Turn in Zul's Ethical Dilemma
.turnin 49494 >>Turn in Zuvembi Brew
.turnin 51663 >>Turn in Preparing for the Fall
.accept 49495 >>Accept Enforcing Fate
step
>>Click the Gong of Command
.goto 862,65.89,31.09
.complete 49495,1 
step
>>Click the shade of the Urn
.goto 862,65.89,30.67
.complete 49495,2 
.timer 6,Urn of Voices RP
step
>>Click the shade of the Urn again when it appears
.goto 862,65.86,30.65
.complete 49495,3 
step
>>Click the potion on the table
.goto 862,65.56,31.30
.complete 49495,4 
step
>>Talk to Zul
.goto 862,65.71,30.21
.turnin 49495 >>Turn in Enforcing Fate
.accept 49905 >>Accept Plot Twist
.timer 30,Plot Twist RP
step
>>Wait for the roleplay to finish and attack Vol'jamba
.goto 862,65.68,31.03
.complete 49905,1 
step
.goto 862,65.68,31.03
>>Kill Vol'Jamba
.complete 49905,2 
step
>>Talk to Zul
.goto 862,65.58,30.51
.turnin 49905 >>Turn in Plot Twist
.accept 49663 >>Accept False Prophecies
step
#completewith HuntKing
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
step
#completewith next
.goto 862,66.99,29.79,30 >> Run down this part of the cliff
step
#label HuntKing
>>Talk to the Hunter's Board, Hemet Nesingwary, Erak, and Tracker Burke
.accept 47706 >>Accept Hunt for King K'tal
.goto 862,67.44,17.90
.turnin 49768 >>Turn in Nesingwary's Trek
.accept 50466 >>Accept He's Gone Mad!
.goto 862,67.50,17.70
.accept 47584 >>Accept A Thorn in the Side
.goto 862,67.45,17.72
.accept 47583 >>Accept Die, Die, Diemetradon
.goto 862,67.56,17.73
step
#completewith next
>>Kill Ankylodons
.complete 47584,1 
step
>>Talk to the dead Trapper on the ground
.goto 862,68.85,19.44
.accept 47585 >>Accept Predatory
step
#completewith ZuldazarWildtusk
>>Kill Vemomous Diemetradons and Ankylodons
.complete 47583,1 
.complete 47584,1 
step
.line 862,71.69,20.36,71.40,20.93,71.33,21.89,71.50,22.41,70.84,22.62,70.14,22.88,68.99,22.64,68.26,21.95,67.98,22.04,67.93,22.32,68.10,22.90,68.25,22.74,68.42,23.03,69.76,22.59,70.84,22.62
.goto 862,71.69,20.36,40,0
.goto 862,71.40,20.93,40,0
.goto 862,71.33,21.89,40,0
.goto 862,71.50,22.41,40,0
.goto 862,70.84,22.62,40,0
.goto 862,70.14,22.88,40,0
.goto 862,68.99,22.64,40,0
.goto 862,68.26,21.95,40,0
.goto 862,67.98,22.04,40,0
.goto 862,67.93,22.32,40,0
.goto 862,68.10,22.90,40,0
.goto 862,68.25,22.74,40,0
.goto 862,68.42,23.03,40,0
.goto 862,69.76,22.59,40,0
.goto 862,70.84,22.62
>>Kill King K'tal. Loot him for his Skull. Find a group for him if needed. Skip this step if you're unable to find a group or solo him.
.complete 47706,1 
.unitscan King K'tal
.isOnQuest 47706
step
>>Talk to Ranger Paalu on the ground
.goto 862,70.63,22.09
.complete 47585,1 
step
#label ZuldazarWildtusk
.goto 862,70.94,26.26
>>Kill the Wildtusk
.complete 50466,1 
step
#completewith next
>>Kill Venomous Diemetradons
.complete 47583,1 
step
>>Talk to Marksman Julyen on the ground
.goto 862,67.81,25.03
.complete 47585,2 
step
.loop 40,862,68.00,26.14,68.86,25.70,68.80,25.22,68.41,25.03,68.56,24.19,67.78,24.33,67.41,24.86,68.00,26.14
.complete 47583,1 
step
.goto 862,67.81,22.89,45,0
.goto 862,68.74,21.43,45,0
.goto 862,68.63,20.44,45,0
.goto 862,67.66,20.12,45,0
.goto 862,68.26,18.54,45,0
.goto 862,69.11,18.71
.complete 47584,1 
step
>>Return to Nesingwary's Trek. Talk to Tracker Burke's Hat, Erak, and Huntmaster Vol'ka
.turnin 47583 >>Turn in Die, Die, Diemetradon
.goto 862,67.50,18.89
.turnin 47584 >>Turn in A Thorn in the Side
.goto 862,68.01,18.03
.turnin 47585 >>Turn in Predatory
.turnin 47706 >>Turn in Hunt for King K'tal
.turnin 50466 >>Turn in He's Gone Mad!
.accept 47586 >>Accept Hunting the Hunter
.goto 862,67.50,17.62
.isQuestComplete 47706
step
>>Return to Nesingwary's Trek. Talk to Tracker Burke's Hat, Erak, and Huntmaster Vol'ka
.turnin 47583 >>Turn in Die, Die, Diemetradon
.goto 862,67.50,18.89
.turnin 47584 >>Turn in A Thorn in the Side
.goto 862,68.01,18.03
.turnin 50466 >>Turn in He's Gone Mad!
.turnin 47585 >>Turn in Predatory
.accept 47586 >>Accept Hunting the Hunter
.goto 862,67.50,17.62
step
.abandon 47706 >> Abandon Hunt for King K'tal
step
#completewith next
.goto 862,66.19,17.60
.fp Nesingwary's Gameland >>Get the Nesingwary's Gameland Flight Path
step
#completewith ZuldazarFollowNesingwary
>>Kill Feathered Vipers, their Eggs, and Wild Sabertusks
.complete 50178,1 
step
>>Click Nesingwary's Campfire on the ground
.goto 862,62.45,19.26
.complete 47586,1 
step
>>Click the Dwarf Trap on the ground
.goto 862,61.48,17.95
.complete 47586,2 
step
#label ZuldazarFollowNesingwary
>>Click the Nesingwary's Rifle on the ground
.goto 862,62.32,16.87
.complete 47586,3 
step
.goto 862,62.76,17.45,40,0
.goto 862,62.88,17.04,40,0
.goto 862,64.01,19.36,40,0
.goto 862,64.14,17.29,40,0
.goto 862,65.83,17.90,40,0
.goto 862,65.17,20.05,40,0
.goto 862,62.76,17.45
>>Kill Feathered Vipers, their Eggs, and Wild Sabertusks
.turnin 50178,1 
step
>>Talk to Hemet Nesingwary inside the building
.goto 862,63.49,16.15
.turnin 47586 >>Turn in Hunting the Hunter
.accept 47587 >>Accept Headhunter Jo
step
.goto 862,62.96,15.81
>>Kill Headhunter Jo outside
.complete 47587,1 
step
>>Talk to Hemet Nesingwary
.goto 862,63.49,16.15
.turnin 47587 >>Turn in Headhunter Jo
step
#completewith next
.hs >>Hearth to Warbeast Kraal
step
>>Return to the Warbeast Kraal. Talk to Beastlord L'kala and Trader Alexxi
.turnin 51990 >>Turn in Wings for the Kraal
.goto 862,66.81,42.51
.turnin 51998 >>Turn in DGH: Now With Real Direhorn
.goto 862,66.81,42.58
step
#completewith next
.goto 862,67.26,43.03
.fly Port of Zandalar >>Fly to Port of Zandalar
step
>>Talk to Zolani and Yazma
.turnin 50835 >>Turn in The Port of Zandalar
.accept 46926 >>Accept Shakedown
.goto 1165,50.06,85.07
.accept 46846 >>Accept The Word of Zul
.goto 1165,50.05,84.76
step
#completewith ZuldazarDocksideThugs
.goto 1165,47.83,87.31,0
>>Kill Gurubashi, Amani, and Sandfury Thugs
.complete 46926,1 
step
.goto 1165,51.52,91.03
>>Talk to Nokali. |cfff78300Do NOT go downstairs.|r
.skipgossip
.complete 46846,1 
step
#completewith next
.goto 1165,53.48,90.62,20 >> Jump down through the gap in the wall
step
>>Talk to Volkini
.goto 1165,53.89,91.20
.skipgossip
.complete 46846,2 
step
#completewith next
.goto 1165,56.03,89.72,20 >> Go under the overhang
step
>>Talk to Scrollsage Rooka
.goto 1165,55.95,88.83
.accept 48404 >>Accept The Scamps
step
#completewith next
>>Interact with the Street Scamps. |cfff78300Be careful as they vanish after a few seconds|r
*You can find some at the waypoint marks on your minimap but they run around everywhere
.goto 1165,51.65,93.32,0
.goto 1165,49.19,89.77,0
.goto 1165,52.30,82.86,0
.goto 1165,48.74,89.43,0
.goto 1165,49.19,89.77,10,0
.complete 48404,1 
step
>>Talk to Dockmaster Cobo
.goto 1165,45.31,79.78
.skipgossip
.complete 46846,3 
step
#label ZuldazarDocksideThugs
>>Talk to Witch Doctor Jala
.goto 1165,44.25,82.15
.accept 48452 >>Accept The Red Market
step
#completewith next
>>Kill Crimson Cultists. Loot them for their Dark Fetishes
.complete 48452,1 
step
>>|cfff78300Make sure to jump down while mounted otherwise your pet will pull everything|r << Hunter/Warlock
>>Jump down below, then go inside the building. Click the Chalice of Calling
.goto 1165,42.76,83.64,12,0
.goto 1165,43.13,83.07
.complete 48452,2 
step
.goto 1165,41.82,82.83,30,0
.goto 1165,41.67,77.10,30,0
.goto 1165,43.13,83.07
>>Kill Crimson Cultists. Loot them for their Dark Fetishes
.complete 48452,1 
step
>>Talk to Witch Doctor Jala
.goto 1165,44.25,82.15
.turnin 48452 >>Turn in The Red Market
.accept 48454 >>Accept Evidence of Evil
step
#completewith next
>>Interact with the Street Scamps. |cfff78300Be careful as they vanish after a few seconds|r
*You can find some at the waypoint marks on your minimap but they run around everywhere
.goto 1165,51.65,93.32,0
.goto 1165,49.19,89.77,0
.goto 1165,52.30,82.86,0
.goto 1165,48.74,89.43,0
.complete 48404,1 
step
.goto 1165,45.31,80.04,30,0
.goto 1165,47.52,87.26,30,0
.goto 1165,46.97,89.89,30,0
.goto 1165,48.45,83.77,30,0
.goto 1165,45.31,80.04
>>Kill Gurubashi, Amani, and Sandfury Thugs
.complete 46926,1 
step
>>Talk to Zolani and Yazma
.turnin 46926 >>Turn in Shakedown
.turnin 48454 >>Turn in Evidence of Evil
.accept 46929 >>Accept Deterrent
.goto 1165,50.06,85.07
.turnin 46846 >>Turn in The Word of Zul
.accept 46927 >>Accept Punishment of Tal'aman
.accept 46928 >>Accept Punishment of Tal'farrak
.goto 1165,50.05,84.76
step
#completewith Gong
>>Interact with the Street Scamps. |cfff78300Be careful as they vanish after a few seconds|r
*You can find some at the waypoint marks on your minimap but they run around everywhere
.goto 1165,51.65,93.32,0
.goto 1165,49.19,89.77,0
.goto 1165,52.30,82.86,0
.goto 1165,48.74,89.43,0
.goto 1165,52.08,83.02,15,0
.goto 1165,50.02,89.97,0,0
.complete 48404,1 
step
#completewith GahzRagon
.goto 1165,48.39,77.83,40,0
>>Kill Sandfury Trolls. Loot them for their Heads
.complete 46929,2 
step
#label Gong
#completewith next
.goto 1165,46.61,73.87
.cast 3365 >>Click the Ancient Gong to summon Gahz'ragon
step
#label GahzRagon
.goto 1165,46.63,72.61
>>Kill Gahz'ragon. Loot him for his Tongues
.complete 46928,1 
step
.goto 1165,46.61,70.64,40,0
.goto 1165,47.71,72.37,40,0
.goto 1165,45.82,77.73,40,0
.goto 1165,48.39,77.83
>>Kill Sandfury Trolls. Loot them for their Heads
.complete 46929,2 
step
#completewith next
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
step
.goto 1165,51.74,77.65,40,0
.goto 1165,54.22,79.81,40,0
.goto 1165,57.31,80.80
>>Kill Amani Trolls. Loot them for their Heads
.complete 46929,1 
step
#completewith next
.goto 1165,56.19,87.53
.cast 3365 >>Click the Ancient Gong to summon an Amani Disciple
step
>>Kill the Amani Disciples
*Sometimes it can bug and you have to wait for around 2 minutes until you can interact with the gong again
.goto 1165,56.04,86.88
.complete 46927,1,1 
step
#completewith next
.goto 1165,56.19,87.53
.cast 3365 >>Click the Ancient Gong to summon an Amani Disciple
step
>>Kill the Amani Disciples
*Sometimes it can bug and you have to wait for around 2 minutes until you can interact with the gong again
.goto 1165,56.04,86.88
.complete 46927,1,2 
step
#completewith next
.goto 1165,56.19,87.53
.cast 3365 >>Click the Ancient Gong to summon an Amani Disciple
step
>>Kill the Amani Disciples
*Sometimes it can bug and you have to wait for around 2 minutes until you can interact with the gong again
.goto 1165,56.04,86.88
.complete 46927,1,3 
step
#completewith next
.goto 1165,56.19,87.53
.cast 3365 >>Click the Ancient Gong to summon an Amani Disciple
step
>>Kill the Amani Disciples
*Sometimes it can bug and you have to wait for around 2 minutes until you can interact with the gong again
.goto 1165,56.04,86.88
.complete 46927,1 
step
#completewith Rooka
.goto 1165,54.41,87.92,25 >> Jump down by taking the shortcut here
step
>>Interact with the Street Scamps.|cfff78300Be careful as they vanish after a few seconds|r
.goto 1165,51.65,93.32,30,0
.goto 1165,49.19,89.77,30,0
.goto 1165,52.30,82.86,30,0
.goto 1165,48.74,89.43,30,0
.goto 1165,51.65,93.32,30,0
.goto 1165,49.19,89.77,30,0
.goto 1165,52.30,82.86,30,0
.goto 1165,48.74,89.43
.complete 48404,1 
step
#label Rooka
>>Talk to Scrollsage Rooka
.goto 1165,56.25,89.70,15,0
.goto 1165,55.95,88.83
.turnin 48404 >>Turn in The Scamps
.accept 48405 >>Accept Mista Nice
step
>>|cfff78300Mount up and follow the arrow|r
.goto 1165,59.06,90.73,12,0
.goto 1165,59.11,88.71,12,0
.goto 1165,57.21,87.77
.complete 48405,1 
step
.goto 1165,57.20,87.39
>>Kill Mista Nice. Move out of the Voodoo Totem he places
.complete 48405,2 
step
>>Jump down again. Talk to Scrollsage Rooka
.goto 1165,55.95,88.83
.turnin 48405 >>Turn in Mista Nice
step
#completewith Treasures
>>Talk to Wavesinger De'zan to take a boat to Seeker's Outpost
.goto 1165,52.83,95.78
.vehicle 133540 >>Seeker's Outpost Boat Ride
.skipgossip 2
.timer 59,Seeker's Outpost RP
step
#label Treasures
>>Talk to Koba and Batu
.accept 49285 >>Accept Tiny Treasures
.goto 862,70.27,65.02
.accept 49284 >>Accept Perfect Tidings
.goto 862,70.28,64.95,12,0
.goto 862,70.49,65.18,12,0
.goto 862,70.56,64.98,12,0
.goto 862,70.69,65.30,12,0
step
#completewith ClueThree
>>Kill Murlocs and run on top of Tadpoles to scare them
.complete 49315,1 
step
>>Search the Bag under the tree
.goto 862,71.19,64.58
.complete 49284,1 
step
>>Loot the cage
.goto 862,71.66,64.15
.complete 49285,1 
step
>>Search the Scroll against the tree
.goto 862,72.65,63.05
.complete 49284,2 
step
>>Loot Spitzy on the ground
.goto 862,73.10,64.81
.complete 49285,3 
step
>>Loot the Alchemist Stone floating above the water
.goto 862,73.19,67.22
.complete 49285,2 
step
#completewith next
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
step
#label ClueThree
>>Search the Scroll Case
.goto 862,74.02,62.08
.complete 49284,3 
step
>>Talk to Choa and Deyon
.goto 862,73.68,60.99
.turnin 49285 >>Turn in Tiny Treasures
.turnin 49284 >>Turn in Perfect Tidings
.accept 49286 >>Accept Caged Wisdom
step
>>Go inside the cave. Kill Sil'thrus. Loot him for his Key
.goto 862,73.66,60.49,20,0
.goto 862,74.60,59.34
.complete 49286,1 
step
.goto 862,73.68,60.99
>>Click the cage, then talk to Deyon
.complete 49286,2 
.turnin 49286 >>Turn in Caged Wisdom
.accept 49287 >>Accept Lost Chelonians
.accept 49288 >>Accept Scrollhunters
step
#completewith TortollanScrolls
>>Kill Murlocs and Nagas. Run on top of Tadpoles to scare them
.complete 49315,1 
step
#completewith next
>>Kill Nazeshi Tempest-Wielders. Loot them for their Scrolls
.complete 49288,1 
step
>>Click the cages to free Kono, Rauloo, Akru, and Crosh
*DO NOT PULL Tidecaller Nezara, she is level 60
.complete 49287,1 
.goto 862,73.92,65.87
.complete 49287,2 
.goto 862,75.16,66.56
.complete 49287,3 
.goto 862,77.07,66.47
.complete 49287,4 
.goto 862,77.32,64.34
.unitscan Tidecaller Nezara
step
#label TortollanScrolls
.loop 45,862,77.44,63.72,76.80,64.28,76.10,65.58,76.61,65.68,76.48,65.95,76.13,66.67,74.99,66.58,74.73,66.00,74.41,66.54,74.19,65.91,73.75,66.40,73.80,65.68,74.13,65.03,74.63,65.16,77.44,63.72
>>Kill Nazeshi Tempest-Wielders. Loot them for their Scrolls
.complete 49288,1 
step
.loop 45,862,77.44,63.72,76.80,64.28,76.10,65.58,76.61,65.68,76.48,65.95,76.13,66.67,74.99,66.58,74.73,66.00,74.41,66.54,74.19,65.91,73.75,66.40,73.80,65.68,74.13,65.03,74.63,65.16,77.44,63.72
>>Kill Murlocs and Nagas. Run on top of Tadpoles to scare them
.complete 49315,1 
step
.goto 862,75.22,61.49
>>Talk to Deyon
.turnin 49287 >>Turn in Lost Chelonians
.turnin 49288 >>Turn in Scrollhunters
.accept 49289 >>Accept A Special Stone
step
#completewith next
.cast 262324 >>Use your |T1392955:0|t[Scroll of Storm Control] to gain the "Stormstruck" ability to deal more damage and stun her when she casts "Gift from Below"
.use 157539
step
>>Loot the Stone Fragment in the middle of the lake
>>Kill Tidemistress Nazesh. Loot her for her Orders
.complete 49289,2 
.goto 862,76.67,61.41
.complete 49289,1 
.goto 862,76.62,61.20,20,0
.goto 862,76.89,61.08,20,0
.goto 862,76.77,61.65
step
>>Talk to Deyon. Wait out the RP event
.goto 862,75.22,61.49
.turnin 49289 >>Turn in A Special Stone
.timer 12,A Special Stone RP
.accept 51407 >>Accept Find Their Words
step
>>Take the portal Deyon summons. Talk to Akru
.goto 862,75.19,61.46,-1
.goto 862,70.56,64.89
.turnin 51407 >>Turn in Find Their Words
step
#completewith next
.goto 862,70.45,65.30
.fly Port of Zandalar >>Fly to Port of Zandalar
step
>>Talk to Yazma and Zolani
.turnin 46928 >>Turn in Punishment of Tal'farrak
.turnin 46927 >>Turn in Punishment of Tal'aman
.goto 1165,50.05,84.76
.turnin 46929 >>Turn in Deterrent
.accept 50881 >>Accept Royal Report
.goto 1165,50.05,85.07
step
#completewith ZuldazarFalseProphecies
.goto 1165,52.09,90.10
.fly The Great Seal >>Fly to The Great Seal
step
#completewith ZuldazarFalseProphecies
.isQuestTurnedIn 47436
.vehicle 131154 >>Click the Totem of Pa'ku
.goto 1165,51.37,40.95
step
#completewith ZuldazarFalseProphecies
.isQuestTurnedIn 47443
.goto 1165,49.93,42.24,10,0
.goto 1164,37.75,71.70,10,0
.goto 1164,20.56,72.09,5 >>Take the elevator to King Rastakhan
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Habutu. You may have to wait when you turned in the other quests first
.goto 1165,49.43,44.77,20,0
.goto 1165,50.03,46.54
.turnin 50881 >>Turn in Royal Report
step
#label ZuldazarFalseProphecies
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to King Rastakhan
.goto 1165,49.92,46.63
.turnin 47432 >>Turn in The Bargain is Struck
.turnin 49663 >>Turn in False Prophecies
.accept 49122 >>Accept A Port in Peril
step
.goto 1165,44.35,39.55,15,0
.goto 1165,44.03,39.61
>>Talk to Myxle
.accept 51465 >>Accept A Load of Scrap
.maxlevel 19
step
>>Click the Shred-Master Mk1
*Put the Tattered Pants from your inventory into the Shred-Master Mk1 and press the 'Scrap' Button
.goto 1165,45.04,40.05
.complete 51465,1 
.isOnQuest 51465
step
>>Talk to Myxle
.goto 1165,45.03,39.61
.turnin 51465 >>Turn in A Load of Scrap
.isQuestComplete 51465
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Horde 10-60
#name 1 Horde Draenor Scenario
#displayname Chapter 2 - Draenor Scenario
#next 2 Horde Draenor Garrison
#veteran
<< Horde
step
#completewith AcceptDraenorChromieTime
+Welcome to the RestedXP Veteran Guide! It will guide you to level 60 as fast as possible. |cfff78300ALWAYS read the instructions, especially the orange ones|r.
step
.goto 1163,74.00,69.92
.zone 85 >> Take the portal to Orgrimmar
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Revi Ramrod
.goto 85,38.55,78.24
.skill riding,75 >>Train Apprentice Riding
step
.isOnQuest 62568
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Chromie
.goto 85,40.83,80.16
.turnin 62568 >>Turn in Adventurers Wanted: Chromie's Call
step
#label AcceptDraenorChromieTime
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tGo to Chromie, talk to her and select The Iron Horde Campaign
.goto 85,43.60,73.14,100,0
.goto 85,40.80,80.12
.skipgossip 1
.accept 34398 >>Accept Warlords of Draenor: The Dark Portal
step
#label TalkToVanguardBattlemageDraenor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFollow the arrow. Talk to the Vanguard Battlemage
.goto 85,54.81,89.85,8,0
.goto 85,54.64,87.10,8,0
.goto 85,56.03,86.99,8,0
.goto 85,55.83,91.44
.skipgossip
.complete 34398,1 
step
.itemcount 132516,1
#completwith BlastedLandsTheDarkPortal
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
#completewith next
.goto 17,68.41,50.82,20,0
.goto 17,63.25,49.60,30,0
.goto 17,61.13,52.26,30,0
.goto 17,58.86,52.55,30,0
+If you can't fly then follow the path over the mountains.
*Wait for the patroll to leave if you have to
step
#completewith next
+You can skip the next cutscene (Esc -> Yes)
step
#label BlastedLandsTheDarkPortal
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dadgar
.goto 17,54.92,50.43
.skipgossip
.complete 34398,2 
step
.goto 577,54.79,48.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Archmage Khadgar
.turnin 34398 >>Turn in Warlords of Draenor: The Dark Portal
.accept 35933 >>Accept Azeroth's Last Stand
step
>>Kill an |cff00ecffIron Grunt|r. Loot him for the |T133469:0|t[Iron Horde Missive]
.goto 577,52.76,43.25
.complete 35933,1 
step
>>You may have to click on the quest in your quest log under the minimap.
.turnin 35933 >>Turn in Azeroth's Last Stand
.accept 34392 >>Accept Onslaught's End
step
>>Interact with the Fel Spire
.goto 577,51.03,42.00
.complete 34392,1 
step
>>Interact with the Fel Spire
.goto 577,51.26,54.58
.complete 34392,2 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Archmage Khadgar
.goto 577,52.98,48.30,30,0
.goto 577,54.70,48.25
.turnin 34392 >>Turn in Onslaught's End
.accept 34393 >>Accept The Portal's Power
step
#completewith next
+You can skip the next cutscene (Esc -> Yes)
step
>>Follow the arrow
.goto 577,54.92,45.03,8,0
.goto 577,54.93,46.13
.complete 34393,1 
step
>>Interact with the Mark
.goto 577,56.02,46.32
.complete 34393,2 
step
>>Interact with the Mark
.goto 577,57.26,48.18
.complete 34393,3 
step
>>Interact with the Mark
.goto 577,56.07,50.20
.complete 34393,4 
step
#completewith next
+You can skip the next cutscene (Esc -> Yes)
step
>>Interact with the Stasis Rune on the ground
.goto 577,55.99,48.23
.complete 34393,5 
step
#completewith next
.goto 577,54.94,45.20,8 >>Leave the Prison
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Archmage Khadgar
.goto 577,56.82,45.84,8,0
.goto 577,54.76,48.28
.turnin 34393 >>Turn in The Portal's Power
.accept 34420 >>Accept The Cost of War
step
.itemcount 132516,1
#completwith BlastedLandsTheDarkPortal
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Archmage Khadgar
.goto 577,60.26,56.32
.turnin 34420 >>Turn in The Cost of War
.accept 34422 >>Accept Blaze of Glory
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ashka and Korag
.goto 577,62.26,52.92
.accept 35241 >>Accept Vengeance for the Fallen
.accept 34421 >>Accept Bled Dry
step
#sticky
#label TanaanJungleIntroBleedingHollow
>>Kill |cff00ecffBleeding Hollow Orcs|r on the side
.goto 577,63.57,64.18,0,0
.complete 35241,1 
step
>>Use the |T132839:0|t[Lucifrium Bead] to burn 3 huts
.use 113191
.goto 577,63.61,50.07
.complete 34422,1,3 
step
>>Open the cage
.goto 577,65.74,54.21
.complete 34421,1 
step
>>Use the |T132839:0|t[Lucifrium Bead] to burn 2 huts
.use 113191
.goto 577,66.49,56.09
.complete 34422,1,5 
step
#completewith next
>>Open the cage
.goto 577,61.02,62.77
.complete 34421,2 
step
>>Use the |T132839:0|t[Lucifrium Bead] to burn the missing huts
.use 113191
.goto 577,61.43,61.97,0,0
.complete 34422,1 
step
.goto 577,61.02,62.77
.complete 34421,2 
step
#requires TanaanJungleIntroBleedingHollow
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thrall and Archmage Khadgar after a short roleplay
.turnin 35241 >>Turn in Vengeance for the Fallen
.goto 577,71.94,62.08
.turnin 34422 >>Turn in Blaze of Glory
.turnin 34421 >>Turn in Bled Dry
.accept 34423 >>Accept Altar Altercation
.goto 577,71.54,62.38
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ariok
.goto 577,71.99,62.19
.skipgossip
.complete 34423,1 
step
>>Follow the arrow
.goto 577,76.98,58.04
.complete 34423,2 
step
#completewith next
.goto 577,79.22,57.04,8 >>Go up the stairs
step
>>Interact with the Blood Ritual Orb
.goto 577,79.22,57.04,8,0
.goto 577,78.64,53.38
.complete 34423,3,1 
step
>>Jump down and interact with the Blood Ritual Orb
.goto 577,78.19,53.52
.complete 34423,3,2 
step
>>Interact with the Blood Ritual Orb
*You can skip the next cutscene (Esc -> Yes)
.goto 577,76.68,53.87
.complete 34423,3 
step
>>Cross the bridge.
.goto 577,72.02,41.90
.complete 34423,4 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Archmage Khadgar
.goto 577,71.95,40.47
.turnin 34423 >>Turn in Altar Altercation
.accept 34425 >>Accept The Kargathar Proving Grounds
.timer 30,Roleplay Duration
step
>>Wait at the waypoint for ~30 seconds
.goto 577,73.03,38.11
.complete 34425,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Archmage Khadgar
.goto 577,73.03,38.11
.turnin 34425 >>Turn in The Kargathar Proving Grounds
.accept 34427 >>Accept A Potential Ally
step
>>Use the 'Frostfire Focus' near the fire
*Spam use the item if you have a bleed on you.
.use 110799
.goto 577,68.91,33.73
.complete 34427,1 
.timer 22,Wait for Farseer Drek'Thar
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Farseer Drek'Thar and Archmage Khadgar
.turnin 34427 >>Turn in A Potential Ally
.goto 577,73.18,38.95
.accept 34429 >>Accept Kill Your Hundred
.goto 577,73.03,38.10
step
>>Wait for the others for roughly 20 seconds
.goto 577,73.38,27.13
.complete 34429,1 
step
>>Kill everything and anything!
.goto 577,73.37,27.40
.complete 34429,2,99 
step
#completewith next
+You can skip the next cutscene (Esc -> Yes)
step
>>Follow the arrow
.goto 578,81.88,49.92
.complete 34429,3 
step
#completewith next
+You can skip the next cutscene (Esc -> Yes)
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Archmage Khadgar, Thrall and Luuka
.turnin 34429 >>Turn in Kill Your Hundred
.goto 578,81.31,50.26
.accept 34739 >>Accept The Shadowmoon Clan
.accept 34737 >>Accept Masters of Shadow
.goto 578,82.32,44.55
step
#sticky
#label TanaanJungleIntroEnemyUmbralHalls
>>Kill |cff00ecffVoid Wolfs|r, |cff00ecffShadowmoon Ritualists|r or |cff00ecffShadowmoon Voidaxes|r
.goto 578,56.93,51.91,0,0
.complete 34739,1 
step
>>Kill |cff00ecffTaskmaster Gurran|r
.goto 578,46.37,38.95,10,0
.goto 578,52.69,24.16
.complete 34737,2 
step
>>Jump down and follow the arrow
.goto 578,53.52,19.81,4,0
.goto 578,45.59,15.27
.complete 34737,3 
step
.goto 578,45.20,15.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Yrel
.accept 34740 >>Accept Yrel
step
>>Follow the arrow to the escort location
*After that you can ingore her
.goto 578,57.43,37.36,8,0
.goto 578,46.79,41.78,8,0
.complete 34740,1 
step
>>Kill |cff00ecffUngra|r
.goto 578,46.41,41.62,20,0
.goto 578,43.78,77.37
.complete 34737,1 
step
#requires TanaanJungleIntroEnemyUmbralHalls
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Liadrin, Yrel and Olin Umberhide
.goto 578,50.95,47.85
.turnin 34737 >>Turn in Masters of Shadow
.turnin 34740 >>Turn in Yrel
.turnin 34739 >>Turn in The Shadowmoon Clan
.accept 34741 >>Accept Keli'dan the Breaker
step
*|cfff78300Talent info some self healing or a pet before pulling him (without Heirlooms)|r. Hold your interrupt/stun for his ability 'Void Vacuum'. Drag him away from the totems otherwise he will deal a lot more damage
.goto 578,36.30,48.95
.complete 34741,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Archmage Khadgar
.goto 577,49.53,14.46
.turnin 34741 >>Turn in Keli'dan the Breaker
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thrall
.goto 577,50.08,13.34
.accept 35005 >>Accept Prepare for Battle
step
#completewith next
+Best sources for Blackrock Weapons:
>>1) Iron Horde Weapon Racks
>>2) Blackrock Forgeworker with the 'Carrying Weapons' buff
step
.goto 577,43.21,15.75,20,0
.goto 577,41.46,17.75,25,0
.goto 577,44.81,19.62,8,0
.goto 577,46.94,21.23,15,0
.goto 577,45.91,19.15
.complete 35005,1 
step
#completewith next
+You can skip the next cutscene (Esc -> Yes)
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thrall and Cordana Felsong
.turnin 35005 >>Turn in Prepare for Battle
.goto 577,50.06,13.31
.accept 34439 >>Accept The Battle of the Forge
.goto 577,49.50,14.22
step
>>Focus on low HP mobs
.goto 577,44.13,15.06,30,0
.goto 577,43.21,19.33
.complete 34439,1 
.complete 34439,2 
step
#completewith next
+You can skip the next cutscene (Esc -> Yes)
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Farseer Drek'Thar
.goto 577,43.04,26.37
.turnin 34439 >>Turn in The Battle of the Forge
.accept 34442 >>Accept Ga'nar of the Frostwolf
step
.goto 577,44.02,29.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hansel Heavyhands and Thaelin Darkanvil
.accept 34987 >>Accept The Gunpowder Plot
.accept 34958 >>Accept The Shadow of the Worldbreaker
step
#sticky
#label TanaanJungleIntroWorldbreakerSchematics
>>Kill orcs in the area. Loot them for the schematics
.goto 577,42.56,39.85,0,0
.complete 34958,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ga'nar
.goto 577,41.92,42.05
.turnin 34442 >>Turn in Ga'nar of the Frostwolf
.accept 34925 >>Accept Polishing the Iron Throne
step
#completewith next
.goto 577,44.29,38.07,8 >>Enter the building
step
>>Kill |cff00ecffOverseer Gotrigg|r downstairs. Loot him for the key
*|cfff78300If necessary run away from him when his blade is burning.|r
.goto 577,45.64,39.71
.complete 34925,1 
step
#completewith next
.goto 577,44.29,38.07,8 >>Leave the building
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ga'nar
.goto 577,41.86,42.10
.turnin 34925 >>Turn in Polishing the Iron Throne
.accept 34437 >>Accept The Prodigal Frostwolf
step
#completewith next
.goto 577,45.54,31.69,8 >>Enter the building
step
>>Interact with the keg
.goto 577,46.98,32.15
.complete 34987,1 
step
#requires TanaanJungleIntroWorldbreakerSchematics
#sticky
#label TanaanJungleIntroMakeshiftPlunger
>>Interact with the Makeshift Plunger
.goto 577,44.08,29.62
.complete 34987,2 
step
#requires TanaanJungleIntroWorldbreakerSchematics
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thaelin Darkanvil and Hansel Heavyhands
.goto 577,44.05,29.54
.turnin 34958 >>Turn in The Shadow of the Worldbreaker
.turnin 34987 >>Turn in The Gunpowder Plot
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Farseer Drek'Thar and Archmage Khadgar
.turnin 34437 >>Turn in The Prodigal Frostwolf
.goto 577,43.03,26.38
.accept 35747 >>Accept Taking a Trip to the Top of the Tank
.goto 577,43.13,28.74
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thaelin
.goto 577,44.08,29.69
.skipgossip 78568,1
.complete 35747,1 
step
.itemcount 132516,1
#completwith next
.use 132516
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
>>Kill |cff00ecffGogluk|r
.goto 577,37.55,47.38
.complete 35747,2 
step
>>Follow the arrow upwards. Be careful to not fall of the chains
.goto 577,40.14,48.32
.complete 35747,3 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thaelin Darkanvil
.goto 577,40.11,48.43
.turnin 35747 >>Turn in Taking a Trip to the Top of the Tank
.accept 34445 >>Accept A Taste of Iron
step
>>Mount the Worldbreaker Side Turret
.goto 577,40.17,48.99
.complete 34445,1 
step
>>Spam |T252185:0|tTurret Blast (1) on the spot shown in the picture. You can ignore the cannons
.link https://i.imgur.com/C5x3cTM.jpeg >>Spot to shoot at
.goto 577,40.18,48.74
.complete 34445,2 
step
#completewith next
+You can skip the next cutscene (Esc -> Yes)
step
>>Interact with the Main Cannon Trigger
.goto 577,40.30,48.30
.complete 34445,3 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thaelin Darkanvil
.goto 577,40.12,48.43
.turnin 34445 >>Turn in A Taste of Iron
.accept 34446 >>Accept The Home Stretch
step
.itemcount 132516,1
#completwith next
.use 132516
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
>>Follow the arrow
.goto 577,44.30,79.91
.complete 34446,1 
step
#completewith next
+You can skip the next cutscene (Esc -> Yes)
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Archmage Khadgar
.goto 577,44.38,80.73
.turnin 34446 >>Turn in The Home Stretch
.accept 33868 >>Accept The Home of the Frostwolves
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Horde 10-60
#name 2 Horde Nazmir
#displayname Chapter 4 - Nazmir
#next 3 Horde Vol'dun << !Monk
#next 99 Monk Quest Horde << Monk
#maxlevel 60
#fresh
<< Horde
step
#label NazmirMap
.goto 1164,41.67,69.17
>>Click the Scouting Map, then click on Nazmir
.accept 47512 >>Accept Nazmir
.zoneskip 863
step
.goto 1164,41.22,66.75
>>Talk to Talanji
.turnin 47512 >>Turn in Nazmir
.accept 47103 >>Accept Journey to Nazmir
.zoneskip 863
step
.goto 1165,51.65,41.29
>>Go outside. Talk to Rokhan
.turnin 47103 >>Turn in Journey to Nazmir
.accept 48535 >>Accept Nazmir, the Forbidden Swamp
.zoneskip 863
step
#completewith TalanjiMeet
#label Pakuai
.goto 1165,51.92,41.20
.fly >> Talk to Paku'ai Rokota to fly to Nazmir
.skipgossip 2
.zoneskip 863
step
#requires Pakuai
#completewith next
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
step
#label TalanjiMeet
.goto 862,52.74,20.62,15,0
.goto 862,53.74,18.75,15,0
.goto 863,43.39,86.96,15,0
.goto 863,43.00,86.03
>>Travel to Princess Talanji in Nazmir
.complete 48535,2 
.isOnQuest 48535
step
>>Talk to Talanji
.goto 863,43.00,86.03
.turnin 48535 >>Turn in Nazmir, the Forbidden Swamp
.accept 47105 >>Accept Into The Darkness
.isOnQuest 48535
step
.goto 862,52.74,20.62,15,0
.goto 862,53.74,18.75,15,0
.goto 863,43.39,86.96,15,0
.goto 863,43.00,86.03,30 >> Travel to Nazmir
.zoneskip 863
step
>>Talk to Talanji
.goto 863,43.00,86.03
.accept 47105 >>Accept Into The Darkness
step
.goto 863,47.25,79.73
>>Travel to The Fallen Outpost. Talk to Talanji
.complete 47105,1 
.turnin 47105 >>Turn in Into The Darkness
.accept 47264 >>Accept Leave None Standing
.accept 47130 >>Accept Improper Burial
step
#completewith ZandBurn
.goto 863,47.49,79.53
.cast 3365 >> Click the Woven Idol

step << skip
#completewith ZandBurn
.goto 863,47.41,79.35
.cast 3365 >> Click the Krag'wa's Ire


step << skip
#completewith ZandBurn
.goto 863,47.36,80.30
.cast 281885 >> Eat the Roasted Raptor


step
#sticky
#label NazmirBloodTrollsSlain
.goto 863,48.6,76.7,0,0
.complete 47264,1 
step
#label ZandBurn
>>Kill Blood Troll Hexxers and Brutalizers
>>Use the |T135433:0|t[Ceremonial Torch] to burn the Dead Zandalari Corpses
.goto 863,48.71,79.77,25,0
.goto 863,48.97,79.18,25,0
.goto 863,48.38,78.75,25,0
.goto 863,48.24,78.11,25,0
.goto 863,48.56,76.90,25,0
.goto 863,48.18,76.34,25,0
.goto 863,48.71,79.77,25,0
.goto 863,48.97,79.18,25,0
.goto 863,48.38,78.75,25,0
.goto 863,48.24,78.11,25,0
.goto 863,48.56,76.90,25,0
.goto 863,48.18,76.34
.complete 47264,1 
.complete 47130,1 
.use 154724
step
.goto 863,45.65,74.79
>>Talk to Talanji
.turnin 47264 >>Turn in Leave None Standing
.turnin 47130 >>Turn in Improper Burial
.accept 47262 >>Accept Ending the Blood Trolls
step
#completewith next
.goto 863,44.78,71.27
.cast 3365 >> Click the Woven Idol
step
.goto 863,44.91,71.65
>>Kill Grand Ma'Da Ateena
.complete 47262,1 
step
.goto 863,45.21,71.04
>>Talk to Talanji
.turnin 47262 >>Turn in Ending the Blood Trolls
.accept 47263 >>Accept A Time of Revelation
.timer 20,A Time of Revelation RP
step
.goto 863,45.57,68.65
>>Talk to Talanji when she arrives at the Overlook. Press "Escape" on your keyboard to skip the cinematic
.complete 47263,1 
.timer 40,Zul'jan Ruins Ride RP
.skipgossip
step
>>Talk to the Scouting Report and Talanji
.accept 51089 >>Accept WANTED: Tojek
.goto 863,39.56,79.95
.turnin 47263 >>Turn in A Time of Revelation
.accept 47188 >>Accept The Aid of the Loa
.skipgossip 121288,1
.goto 863,39.14,79.07
step
#completewith AidoftheLoa
.goto 863,39.14,79.07,10,0
>>Talk to Talanji. Don't wait around for her RP
.complete 47188,1 
.skipgossip 121288,1
.timer 107,The Aid of the Loa RP

step
#completewith AidoftheLoa
.goto 863,38.62,78.66
.home >>Set your Hearthstone to Zul'jan Ruins
step
#label ZuljanFP
#completewith AidoftheLoa
.goto 863,38.85,78.14
.fp Zul'jan >>Get the Zul'jan Ruins Flight Path
step
#requires ZuljanFP
#completewith next
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
step
.goto 863,26.44,65.21,30,0
.goto 863,26.64,66.17,30,0
.goto 863,27.07,67.10,30,0
.goto 863,27.08,67.64,30,0
.goto 863,26.67,68.48,30,0
.goto 863,26.44,65.21,30,0
.goto 863,26.64,66.17,30,0
.goto 863,27.07,67.10,30,0
.goto 863,27.08,67.64,30,0
.goto 863,26.67,68.48
>>Kill Tojek. Find a group for him if needed. Skip this step if you're unable to find a group or solo him
.complete 51089,1 
step
#completewith next
.hs >>Hearth to Zul'jan Ruins
.cooldown item,6948,>0
step
#label AidoftheLoa
>>Return to Zul'jan Ruins. Talk to Talanji and Rovash
.turnin 47188 >>Turn in The Aid of the Loa
.accept 47241 >>Accept The Shadow of Death
.goto 863,39.14,79.07
.turnin 51089 >>Turn in WANTED: Tojek
.goto 863,39.13,79.86
step << skip
#completewith next
.vendor >>Talk to Provisioner Lija
.goto 863,39.10,79.46
step
>>Talk to Sur'jan
.goto 863,38.83,77.71
.accept 48669 >>Accept Urok, Terror of the Wetlands
.skipgossip 126713,1
.timer 38, Urok, Terror of the Wetlands RP
step << skip
>>Talk to Sur'jan again and select the 1st gossip option
*Skip this step after you've spoken to her
.goto 863,38.83,77.71
.skipgossip 126713,1

step
.goto 863,39.63,64.95
>>Click the Weathered Shrine
.complete 47241,1 
step
.goto 863,37.50,63.06
>>Click the Broken Spear on the ground. If you run away fast enough you don't have to fight the mobs that spawn
.complete 47241,2 
step
.goto 863,39.06,60.67
>>Talk to Shinga
.accept 48468 >>Accept Bwonsamdi's Deliverance
.accept 48473 >>Accept Respecting the Rites
step
#completewith LastTorch
>>Kill Defiled Embalmers and Worshippers. Use the |T135433:0|t[Cremation Torch] on their corpses. You can burn multiple corpses at once
.use 153178
.complete 48468,1 
step
.goto 863,40.30,62.37
>>Click the Torch
.complete 48473,1,1 
step
.goto 863,40.94,63.43
>>Click the Torch
.complete 48473,1,2 
step
.goto 863,41.31,62.56
>>Loot the Ritual Powder on the ground outside
.complete 48473,2 
step
.goto 863,41.69,63.00
>>Click the Torch
.complete 48473,1,3 
step
.goto 863,42.21,64.58
>>Click the Torch
.complete 48473,1,4 
step
#label LastTorch
>>Click the Torch
.goto 863,41.61,65.16
.complete 48473,1 
step
.goto 863,40.93,64.14,30,0
.goto 863,42.72,63.15,30,0
.goto 863,42.38,62.37,30,0
.goto 863,40.93,64.14,30,0
.goto 863,42.72,63.15,30,0
.goto 863,42.38,62.37
>>Kill Defiled Embalmers and Worshippers. Use the |T135433:0|t[Cremation Torch] on their corpses. You can burn multiple corpses at once
.use 153178
.complete 48468,1 
step
>>Talk to Shinga and Kol'Jun
.turnin 48468 >>Turn in Bwonsamdi's Deliverance
.turnin 48473 >>Turn in Respecting the Rites
.accept 48478 >>Accept Kel'vax's Home
.goto 863,38.93,59.91
.accept 48479 >>Accept Bones for Protection
.goto 863,39.00,59.93
step
>>Click the Blood Scavenger corpse
.goto 863,35.62,58.58
.complete 47241,3 
step
.goto 863,36.61,53.92
>>Talk to Hanzabu
.turnin 47241 >>Turn in The Shadow of Death
.accept 47244 >>Accept A Culling of Souls
step
.goto 863,38.55,49.98
>>Kill Blood Witch Najima
.complete 47244,1 
step
.goto 863,39.52,43.83
>>Talk to Hanzabu
.turnin 47244 >>Turn in A Culling of Souls
.accept 49278 >>Accept Spiritual Restoration
step
.goto 863,39.04,43.91
>>Click the spirit on the ground
.complete 49278,1,1 
step
.goto 863,38.86,43.50
>>Click the spirit on the ground
.complete 49278,1,2 
step
.goto 863,40.88,43.54
>>Click the spirit on the ground
.complete 49278,1 
step
>>Talk to Hanzabu and Kejabu when he arrives
.turnin 49278 >>Turn in Spiritual Restoration
.accept 47868 >>Accept The Necropolis
.goto 863,39.52,43.83
.timer 4,Blood Troll on the Outside RP
.accept 49440 >>Accept Blood Troll on the Outside
.goto 863,39.63,43.86
step
.goto 863,39.58,43.75
>>Click the Blood Troll Skull
.complete 49440,1,1 
step
.goto 863,39.75,43.50
>>Click the Blood Troll Skull
.complete 49440,1,2 
step
.goto 863,39.42,43.50
>>Click the Blood Troll Skull
.complete 49440,1 
step
.goto 863,39.63,43.86
>>Talk to Kejabu
.complete 49440,2 
.skipgossip 122795,1
.timer 23,Blood Troll on the Outside RP
step
.goto 863,39.58,32.57
>>Talk to Hanzabu
.turnin 47868 >>Turn in The Necropolis
.accept 47880 >>Accept A Tribute for Death
step
.goto 863,39.58,32.31
>>Walk along the markings on the ground to draw the Ritual Circle
.complete 47880,1 
step
.goto 863,39.59,31.77
>>Click the Drum of Spirits
.complete 47880,2 
step
.goto 863,39.57,26.43,30,0
.goto 863,39.57,24.52
>>Talk to Bwonsamdi inside the temple
.turnin 47880 >>Turn in A Tribute for Death
.accept 47247 >>Accept That Which Haunts the Dead
.accept 47491 >>Accept Remnants of the Damned
.accept 49348 >>Accept A Desecrated Temple
step
#completewith Salazae
>>Kill Corrupted Spirits and Acolytes of Tizeja
.complete 48934,1 
step
#completewith VileDes
.goto 863,39.55,26.72,30,0
.goto 863,40.97,27.21,30,0
>>Kill Reanimated Horrors. Loot them for their Bloodstones
.complete 47491,1 
step
.goto 863,42.13,27.87
>>Click the Vile Desecration to destroy it
.complete 49348,1,1 
step
.goto 863,43.31,27.88
>>Click the Vile Desecration to destroy it
.complete 49348,1,2 
step
.goto 863,43.63,28.49
>>Click the Vile Desecration to destroy it
.complete 49348,1,3 
step
#label NazmirWarlordMalaja
.goto 863,43.43,30.02
>>Kill Warlord Malaja
.complete 47247,1 
step
.goto 863,42.93,31.98
>>Click the Vile Desecration to destroy it
.complete 49348,1,4 
step
.goto 863,42.58,31.46
>>Talk to Keula
.accept 49432 >>Accept The Forlorn Soul
step
#label VileDes
.goto 863,42.25,31.91
>>Click the Vile Desecration to destroy it
.complete 49348,1 
step
#completewith Shaazula
.goto 863,41.65,33.42,30,0
.goto 863,40.58,33.25,30,0
>>Kill Reanimated Horrors. Loot them for their Bloodstones
.complete 47491,1 
step
.goto 863,39.59,31.60,15,0
.goto 863,39.58,34.99
>>Enter the catacombs. Open the Sarcophagus Lid
.complete 49432,1 
.timer 10,The Forlon Soul RP
step
#label Shaazula
.goto 863,39.65,35.00
>>Kill Matron Shaazula
.complete 49432,2 
step
#completewith next
.goto 863,39.59,31.63,30,0
.goto 863,38.72,29.46,30,0
>>Kill Reanimated Horrors. Loot them for their Bloodstones
.complete 47491,1 
step
.goto 863,37.58,30.98,30,0
.goto 863,36.09,29.89
>>Kill the Disciples of Tizeja, then kill Tizeja
.complete 47247,2 
step
.goto 863,36.66,27.40
>>Talk to Theurgist Salazae
.accept 47248 >>Accept 'Til Death Do Us Part
step
.goto 863,39.59,31.63,30,0
.goto 863,38.72,29.46,30,0
.goto 863,39.55,26.72,30,0
.goto 863,40.97,27.21,30,0
.goto 863,41.65,33.42,30,0
.goto 863,40.58,33.25,30,0
.goto 863,39.59,31.63,30,0
.goto 863,38.72,29.46,30,0
.goto 863,39.55,26.72,30,0
.goto 863,40.97,27.21,30,0
.goto 863,41.65,33.42,30,0
.goto 863,40.58,33.25
>>Kill Reanimated Horrors. Loot them for their Bloodstones
.complete 47491,1 
step
.goto 863,39.57,26.43,30,0
.goto 863,39.57,24.52
>>Talk to Bwonsamdi inside the temple
.turnin 47491 >>Turn in Remnants of the Damned
.turnin 47247 >>Turn in That Which Haunts the Dead
.turnin 49348 >>Turn in A Desecrated Temple
.turnin 49432 >>Turn in The Forlorn Soul
.accept 47249 >>Accept Soulbound
step
.goto 863,39.58,30.22
>>Talk to Bwonsamdi
.complete 47249,1 
.skipgossip
.timer 47,Soulbound RP
step
.goto 863,40.36,28.95,20,0
.goto 863,40.37,26.48
>>Enter the catacombs. Loot the Ancient Urn. You can IGNORE Gee'dae completely
.complete 47248,1 
step
.goto 863,39.57,30.95
>>Kill Grand Ma'Da Ateena once the RP finishes. Ignore the small skeletons
.complete 47249,2 
step
.goto 863,39.58,30.22
>>Talk to Bwonsamdi
.turnin 47249 >>Turn in Soulbound
.accept 47250 >>Accept We'll Meet Again
step
#label Salazae
.goto 863,36.66,27.40
>>Talk to Theurgist Salazae
.turnin 47248 >>Turn in 'Til Death Do Us Part
step
.loop 40,863,37.27,27.84,36.94,31.05,35.97,28.78,37.27,27.84
>>Kill Corrupted Spirits and Acolytes of Tizeja
.complete 48934,1 
step
>>Talk to Hanzabu and Kejabu
.turnin 47250 >>Turn in We'll Meet Again
.goto 863,39.52,43.83
.turnin 49440 >>Turn in Blood Troll on the Outside
.accept 48699 >>Accept Sneaking into Zalamar
.goto 863,39.63,43.86
step
#completewith X
+For these quests, you will automatically be disguised. do NOT attack anything else you will lose your disguise. Leave combat to get your disguise back
step
.goto 863,32.37,46.17
>>Talk to Bloodseeker Jo'chunga
.skipgossip
.complete 48699,1 
.timer 16,Sneaking into Zalamar RP
step
.goto 863,33.23,46.10,20,0
.goto 863,33.35,45.76
>>Talk to Jo'chunga when he arrives inside the building
.turnin 48699 >>Turn in Sneaking into Zalamar
.accept 48801 >>Accept Isolating Zalamar
.accept 48890 >>Accept How to Be a Blood Troll
step
.goto 863,35.30,46.81
>>Climb the tower. Talk to Wardrummer Sheej
.complete 48801,2 
.skipgossip
step
.goto 863,32.20,47.68
>>Click the Unproven Drudges to test them
.complete 48890,1,1 
step
#completewith next
.goto 863,32.34,48.54,8,0
+Right-Click Flask of Blood Rage for a damage buff

step
.goto 863,32.21,48.69
>>Click the Unproven Drudges to test them
.complete 48890,1,2 
step
.goto 863,31.21,49.42
>>Click the Unproven Drudges to test them
.complete 48890,1,3 
step
.goto 863,31.16,49.75
>>Climb the tower. Talk to Wardrummer Gix
.complete 48801,3 
step
.goto 863,30.97,52.18
>>Talk to Zardrax
.accept 48854 >>Accept Offer of Power
.skipgossip
.complete 48854,1 
step
.goto 863,30.97,52.17
>>Click Zadrax to break free
.complete 48854,2 
step
>>Talk to Shadow Hunter Da'jul and Kal'dran
.turnin 48854 >>Turn in Offer of Power
.accept 48823 >>Accept Projection Destruction
.complete 48823,1 
.goto 863,31.05,52.08
.accept 48825 >>Accept Power Denied
.goto 863,30.91,52.03
.skipgossip 127215,1
step
#completewith Zardrax
>>Focus on destroying Empowered Totems
>>kill Empowered Worshippers and Returned Predators
.complete 48852,1 
step
.goto 863,30.87,55.16
>>Use |T132847:0|t[Da'jul's Fire Mojo] to destroy the Skeletal Mound
.complete 48823,2,1 
.use 152727
step
.goto 863,32.16,55.43
>>Use |T132847:0|t[Da'jul's Fire Mojo] to destroy the Skeletal Mound
.complete 48823,2,2 
.use 152727
step
.goto 863,32.84,56.90
>>Use |T132847:0|t[Da'jul's Fire Mojo] to destroy the Skeletal Mound
.complete 48823,2 
.use 152727
step
.goto 863,33.08,58.81
>>Kill Hexxer Nana'kwug. Loot her for her Blood Fetish
.complete 48825,1 
step
>>Talk to Da'jul and Kal'dran
.turnin 48823 >>Turn in Projection Destruction
.turnin 48825 >>Turn in Power Denied
.accept 48856 >>Accept Conduit Interruption
.accept 48855 >>Accept Humbling the Terrors
.goto 863,31.05,52.08
.accept 48857 >>Accept All Hope is Lost
.complete 48857,1 
.goto 863,30.91,52.03
.skipgossip
step
#completewith next
>>kILL Zardrax Conduits and Reconstructed Terrors
>>Use the |T458256:0|t[Modified Blood Fetish] on Reconstructed Terrors to Weaken them
.complete 48856,1 
.complete 48855,1 
.use 153483
step
.goto 863,29.36,56.99,20,0
.goto 863,29.08,56.74
>>Kill Empowered Kal'dran inside the tree
.complete 48857,2 
step
.loop 50,863,32.66,61.25,30.23,61.71,28.79,60.87,29.13,58.20,32.66,61.25
>>kILL Zardrax Conduits and Reconstructed Terrors
>>Use the |T458256:0|t[Modified Blood Fetish] on Reconstructed Terrors to Weaken them
.complete 48856,1 
.complete 48855,1 
.use 153483
step
.goto 863,30.96,52.13
>>Talk to Da'jul
.turnin 48856 >>Turn in All Hope is Lost
.turnin 48855 >>Turn in Humbling the Terrors
.turnin 48857 >>Turn in All Hope is Lost
.accept 48869 >>Accept Payback's a Lich
step
#label Zardrax
.goto 863,31.56,57.87
>>Kill Zardrax
.complete 48869,1 
step
.goto 863,33.74,58.18,20,0
.goto 863,33.99,57.46,20,0
.goto 863,33.00,56.57,20,0
.goto 863,30.38,54.79
>>Focus on destroying Empowered Totems
>>kill Empowered Worshippers and Returned Predators
.complete 48852,1 
step
.goto 863,30.96,52.13
>>Talk to Da'jul
.turnin 48869 >>Turn in Payback's a Lich
step
.goto 863,29.20,52.06
>>Talk to the Imperial Guard corpse
.accept 50933 >>Accept An Unfortunate Event
step
>>Talk to Zaluto and Jin'Tiki
.turnin 50933 >>Turn in An Unfortunate Event
.accept 49777 >>Accept On The Run
.goto 863,24.13,53.20
.accept 49776 >>Accept No Problem Tar Can't Solve
.accept 49774 >>Accept Won't Leaf Him to Die
.goto 863,24.11,53.14
step
#completewith Mojoba
>>Kill Tar Oozes. Loot them for their Tar
.complete 49776,1 
step
.goto 863,23.53,54.64
>>Loot the Sweeatleaf on the ground
.complete 49774,1,1 
step
.goto 863,23.72,56.24
>>Loot the Sweeatleaf on the ground
.complete 49774,1,2 
step
.goto 863,23.36,58.19
>>Loot the Sweeatleaf on the ground
.complete 49774,1,3 
step
.goto 863,22.76,57.71
>>Loot the Sweeatleaf on the ground
.complete 49774,1,4 
step
.goto 863,22.03,54.70
>>Loot the Sweeatleaf on the ground
.complete 49774,1,5 
step
.goto 863,21.85,55.06
>>Loot the Sweeatleaf on the ground
.complete 49774,1,6 
step
.goto 863,21.56,55.03
>>Talk to Razjuto
.complete 49777,1 
.skipgossip
step
.goto 863,20.86,54.16
>>Loot the Sweeatleaf on the ground
.complete 49774,1,7 
step
>>Collect Sweetleafs by Right-Clicking them
.goto 863,21.29,51.07
.complete 49774,1 
step
.goto 863,21.32,50.39
>>Talk to Teshyambi
.complete 49777,3 
.skipgossip
step
#label Mojoba
.goto 863,23.59,47.67
>>Talk to Mojoba WHILE MOUNTED, then run away. You don't have to kill him
.complete 49777,2 
.skipgossip
step
.loop 40,863,21.46,50.76,22.61,52.02,23.28,53.65,23.99,55.95,23.47,59.73,22.67,58.45,22.64,54.95,21.59,54.21,21.29,52.95,21.46,50.76
>>Kill Tar Oozes. Loot them for their Tar
.complete 49776,1 
step
>>Talk to Zaluto and Jin'Tiki
.turnin 49777 >>Turn in On The Run
.goto 863,24.13,53.20
.turnin 49776 >>Turn in No Problem Tar Can't Solve
.turnin 49774 >>Turn in Won't Leaf Him to Die
.accept 49778 >>Accept Don't Go into the Light
.goto 863,24.11,53.14
step
>>Talk to Zaluto to hold him down while Jin'Tiki cures him
.complete 49778,1 
.goto 863,24.13,53.20
.skipgossip
step
>>Talk to Jin'Tiki and Zaluto
.turnin 49778 >>Turn in Don't Go into the Light
.accept 49780 >>Accept Recovering Ancient Fire
.goto 863,24.11,53.14
.accept 49779 >>Accept Bad To The Bone
.goto 863,24.14,53.20
step
#completewith FireMojoAbs
>>Kill Bone Raptors
.complete 49779,1 
step
.goto 863,25.64,51.55
>>Use the |T458256:0|t[Jin'Tiki Fetish] to absorb the Fire Mojo from the Statues. This has a 40-yard range
.complete 49780,1,1 
.use 156480
step
.goto 863,24.64,50.00
>>Use the |T458256:0|t[Jin'Tiki Fetish] to absorb the Fire Mojo from the Statues. This has a 40-yard range
.complete 49780,1,2 
.use 156480
step
.goto 863,26.08,47.72
>>Use the |T458256:0|t[Jin'Tiki Fetish] to absorb the Fire Mojo from the Statues. This has a 40-yard range
.complete 49780,1,3 
.use 156480
step
#label FireMojoAbs
.goto 863,24.73,45.02
>>Use the |T458256:0|t[Jin'Tiki Fetish] to absorb the Fire Mojo from the Statues. This has a 40-yard range
.complete 49780,1 
.use 156480
step
.loop 50,863,25.60,44.47,23.78,44.29,23.70,46.79,24.59,47.70,23.97,50.31,25.48,51.89,25.87,47.65,25.60,44.47
>>Kill Bone Raptors
.complete 49779,1 
step
>>Talk to Jin'Tiki and Zaluto
.turnin 49780 >>Turn in Recovering Ancient Fire
.goto 863,24.11,53.14
.turnin 49779 >>Turn in Bad to The Bone
.accept 49781 >>Accept Catch Me If You Can
.goto 863,24.13,53.20
step
#completewith next
.vehicle >>Mount the Riding Raptor
.goto 863,24.18,53.36
step
.goto 863,28.28,52.05
>>Target Zulajin and cast "Shout" (1), then cast "Fire Empowered Fetish" (1), then cast "Wild Fire Blast" (1).
.complete 49781,1 
step
>>Talk to Jin'Tiki
.goto 863,28.36,52.03
.turnin 49781 >>Turn in Catch Me If You Can
step
>>Talk to Chadwick Paxton on the ground, then click his legs
.accept 48492 >>Accept Getting a Leg Up
.goto 863,28.63,43.75
.complete 48492,1 
.goto 863,28.65,43.72
step
>>Talk to Chadwick then jump. Talk to Chadwick again
.complete 48492,2 
.goto 863,28.63,43.75
.turnin 48492 >>Turn in Getting a Leg Up
.accept 48497 >>Accept Show of Force
.accept 48496 >>Accept Reuniting the Company
.goto 863,28.62,43.78
.skipgossip
step
#completewith Sithis
>>Kill Sethrak Warbringers, Wardens, Ravagers, and Skycallers
.complete 48497,1 
step
>>Click the cages to free Clayton, Anna, Timothy, and Ingrid. Talk to Ingrid
.complete 48496,3 
.goto 863,27.37,41.20
.complete 48496,1 
.goto 863,26.13,40.42
.complete 48496,2 
.goto 863,27.45,38.51
.complete 48496,4 
.accept 48498 >>Accept No Mercy for Sithis
.goto 863,26.60,37.87
step
#label Sithis
.goto 863,25.93,38.15,20,0
.goto 863,25.40,37.65
>>Kill Fangcaller Sithis. Loot him for his Gem
.complete 48498,1 
step
.loop 50,863,26.20,38.11,26.16,40.41,26.92,42.07,28.13,41.40,28.31,39.88,28.17,37.96,26.20,38.11
>>Kill Sethrak Warbringers, Wardens, Ravagers, and Skycallers
.complete 48497,1 
step
>>Talk to Paxton and Ingrid
.turnin 48497 >>Turn in Show of Force
.turnin 48498 >>Turn in No Mercy for Sithis
.turnin 48496 >>Turn in Reuniting the Company
.accept 49479 >>Accept Didn't Stop to Think if They Should
.goto 863,25.83,36.02
.complete 49479,1 
.goto 863,25.80,35.91
.skipgossip
.timer 14,Skycaller Gem RP
step
.goto 863,25.83,36.02
>>Talk to Paxton. Press "Escape" on your keyboard to skip the cinematic
.turnin 49479 >>Turn in Didn't Stop to Think if They Should
.accept 48499 >>Accept Return to Dust
step
.goto 863,27.12,39.56
>>Use the Extra Action Button to kill the Enraged Sethrak
.complete 48499,1 
step
.goto 863,27.12,39.56
>>Use the Extra Action Button when next to the Spire
.complete 48499,2 
step
.goto 863,25.83,36.02
>>Talk to Paxton
.turnin 48499 >>Turn in Return to Dust
step
.goto 863,31.48,43.25
>>Climb the tower. Talk to Wardrummer Saljo
.complete 48801,1 
.skipgossip
step
.goto 863,32.72,43.97
>>Click the Unproven Drudges to test them
.complete 48890,1,4 
step
.goto 863,33.05,44.20
>>Click the Unproven Drudges to test them
.complete 48890,1 
step
.goto 863,33.23,46.10,20,0
.goto 863,33.35,45.76
>>Talk to Jo'chunga
.turnin 48801 >>Turn in Isolating Zalamar
.turnin 48890 >>Turn in How to Be a Blood Troll
.accept 48800 >>Accept Mark of the Bat
.accept 49078 >>Accept Poisoning the Brood
step << skip
#completewith X
+Look out for the buffs at the waypoint locations
.goto 863,33.48,49.34,0
.goto 863,33.13,48.65,0
.goto 863,32.67,49.62,0
.goto 863,32.36,48.57,0
.goto 863,31.02,48.46,0
.goto 863,30.25,48.95,0
.goto 863,30.50,47.55,0
.goto 863,31.62,45.13,0
step
#completewith TamedWarspawn
>>Kill Warspawn Riders, Obedient Drudges, Zalamar Warriors, and Blood Crawgs
>>Drain the Brewing Cauldrons and unlock the Blood Troll Cages
*Make sure to drink the Flasks of Blood Rage, Vials of Vampiric Mojo, and eat Roasted Raptor, Krag'wa's Ire for buffs
.complete 49406,1 
step
#completewith next
>>Use your |T650637:0|t[Poisoned Mojo Flask] on Tamed Warspawns
.complete 49078,1 
.use 153012
step
>>Kill Yialu, Zu'Anji and Vashera. Loot them for their Talismans
.complete 48800,1 
.goto 863,33.65,49.33
.complete 48800,3 
.goto 863,32.60,48.18,5,0
.goto 863,32.68,49.48
.complete 48800,2 
.goto 863,31.03,45.46,5,0
.goto 863,30.73,45.27
step
#label TamedWarspawn
.goto 863,31.25,45.19,30,0
.goto 863,31.80,44.65,30,0
.goto 863,31.69,43.54,30,0
.goto 863,33.20,45.48,30,0
.goto 863,33.28,49.20,30,0
.goto 863,33.21,48.70,30,0
.goto 863,33.11,48.85,30,0
.goto 863,32.02,47.57,30,0
.goto 863,31.64,47.72,30,0
.goto 863,31.01,47.52,30,0
.goto 863,30.94,46.97,30,0
.goto 863,30.20,47.20,30,0
.goto 863,30.65,45.62
>>Use your |T650637:0|t[Poisoned Mojo Flask] on Tamed Warspawns
.complete 49078,1 
.use 153012
step
.goto 863,31.25,45.19,30,0
.goto 863,31.80,44.65,30,0
.goto 863,31.69,43.54,30,0
.goto 863,33.20,45.48,30,0
.goto 863,33.28,49.20,30,0
.goto 863,33.21,48.70,30,0
.goto 863,33.11,48.85,30,0
.goto 863,32.02,47.57,30,0
.goto 863,31.64,47.72,30,0
.goto 863,31.01,47.52,30,0
.goto 863,30.94,46.97,30,0
.goto 863,30.20,47.20,30,0
.goto 863,30.65,45.62
>>Kill Warspawn Riders, Obedient Drudges, Zalamar Warriors, and Blood Crawgs
>>Drain the Brewing Cauldrons and unlock the Blood Troll Cages
*Make sure to drink the Flasks of Blood Rage, Vials of Vampiric Mojo, and eat Roasted Raptor, Krag'wa's Ire for buffs
.complete 49406,1 
step
.goto 863,33.23,46.10,20,0
.goto 863,33.35,45.76
>>Talk to Jo'chunga. Wait out the RP
.turnin 48800 >>Turn in Mark of the Bat
.turnin 49078 >>Turn in Poisoning the Brood
.timer 12,Hir'eek the Bat Loa RP
.accept 49079 >>Accept Hir'eek, the Bat Loa
step
.goto 863,32.18,46.29
>>Stand in the blood circle, then talk to Jo'chunga
.complete 49079,1 
.skipgossip
.timer 29,Hir'eek the Bat Loa RP
step
.goto 863,31.41,46.99
>>Use "Poison Stab" (1) on Hir'eek on cooldown
.complete 49079,2 
step
.goto 863,31.23,46.80
>>Exit the vehicle as fast as possible and fall down (you shouldn't die to fall damage). Quickly talk to Jo'chunga
.turnin 49079 >>Turn in Hir'eek, the Bat Loa
.accept 49081 >>Accept To Kill a Loa
step
.goto 863,29.14,46.57
>>Kill Hir'eek inside the cave. Hide behind a pillar when he begins to cast Blood Horror
.complete 49081,1 
step
.goto 863,31.25,46.81
>>Talk to Jo'chunga
.turnin 49081 >>Turn in To Kill a Loa
.accept 49082 >>Accept Upward and Onward
step
#completewith next
.goto 863,31.27,46.72
>>Mount the Hir'eek Spawnling
.complete 49082,1 
.timer 15,Hir'eek Lair Flight RP
step
.goto 863,39.63,43.86
>>Talk to Kejabu
.complete 49082,2 
.turnin 49082 >>Turn in Upward and Onward
.skipgossip 122795,1
step
>>Talk to Talanji and Lashk
.accept 49185 >>Accept Catching Up
.complete 49185,1 
.turnin 49185 >>Turn in Catching Up
.goto 863,39.40,44.00
.accept 49064 >>Accept Torga, the Turtle Loa
.goto 863,39.46,44.02
.skipgossip 127961,1
step << skip
#completewith next
+Look out for the buffs at the waypoint locations
.goto 863,38.93,55.60,0
.goto 863,40.77,50.40,0
step
#completewith next
>>Kill Phylactery Guardians, Kel'vax, Resurrected Warriors, and Bound Scavengers. Loot them for their Bones
.complete 48479,1 
step
>>Use the |T134380:0|t[Spirit Powder] to gain the Spirit Journey buff to be able to loot the Phylacteries
.complete 48478,1 
.goto 863,40.99,51.98
.complete 48478,3 
.goto 863,38.32,54.39
.complete 48478,2 
.goto 863,39.39,57.48
.use 154130
step
.loop 50,863,40.68,58.82,40.70,55.76,39.51,53.03,38.75,55.17,38.79,56.85,40.68,58.82
>>Kill Phylactery Guardians, Kel'vax, Resurrected Warriors, and Bound Scavengers. Loot them for their Bones
.complete 48479,1 
step
>>Talk to Kol'jun and Shinga
.turnin 48479 >>Turn in Bones for Protection
.goto 863,39.00,59.93
.turnin 48478 >>Turn in Kel'vax Home
.accept 48480 >>Accept The Fall of Kel'vax
.goto 863,38.93,59.91
step
.goto 863,42.22,57.47
>>Kill the Kel'vax Deathwalker
.complete 48480,1 
step
.goto 863,38.93,59.91
>>Talk to Shinga
.turnin 48480 >>Turn in The Fall of Kel'vax
step
.goto 863,55.65,39.40
>>Talk to Kisha
.complete 49064,1 
.skipgossip 2
step
.goto 863,55.15,36.71
>>Talk to Kajosh
.accept 47924 >>Accept Profanity Filter
step
.goto 863,54.14,36.00
>>Use the |T1500879:0|t[Scroll of Inferno] near the Profane Totems to destroy them
.complete 47924,1,1 
.use 151849
step
#completewith ProfaneTotems
>>Focus on burning the Crocodiles. Spam click them to potentially burn them twice
>>Kill Stalking Mawfiends and Young Mawfiends
.complete 47996,1 
step
.goto 863,54.31,33.34
>>Use the |T1500879:0|t[Scroll of Inferno] near the Profane Totems to destroy them
.complete 47924,1,2 
.use 151849
step
.goto 863,54.14,32.26
>>Use the |T1500879:0|t[Scroll of Inferno] near the Profane Totems to destroy them
.complete 47924,1,3 
.use 151849
step
.goto 863,53.19,31.68
>>Use the |T1500879:0|t[Scroll of Inferno] near the Profane Totems to destroy them
.complete 47924,1,4 
.use 151849
step
#label ProfaneTotems
.goto 863,52.67,33.68
>>Use the |T1500879:0|t[Scroll of Inferno] near the Profane Totems to destroy them
.complete 47924,1 
.use 151849
step
.goto 863,52.50,31.34,30,0
.goto 863,52.10,30.60,30,0
.goto 863,54.04,32.25,30,0
.goto 863,54.34,33.53,30,0
.goto 863,53.02,34.10,30,0
.goto 863,52.50,31.34,30,0
.goto 863,52.10,30.60,30,0
.goto 863,54.04,32.25,30,0
.goto 863,54.34,33.53,30,0
.goto 863,53.02,34.10
>>Focus on burning the Crocodiles. Spam click them to potentially burn them twice
>>Kill Stalking Mawfiends and Young Mawfiends
.complete 47996,1 
step
>>Talk to Kajosh. Wait out his RP
.goto 863,51.75,33.25
.complete 47924,2 
.turnin 47924 >>Turn in Profanity Filter
.accept 47919 >>Accept Just Say No to Cannibalism
.accept 47925 >>Accept Shoak's on the Menu
.accept 47998 >>Accept Killing Cannibals
.skipgossip 124933,1
.timer 21,Profanity Filter RP
step << skip
#completewith next
+Some possible buff locations like Woven Idol or Krag'wa's Ire
.goto 863,48.56,35.65,0
.goto 863,49.21,35.53,0
.goto 863,48.86,35.04,0
.goto 863,50.81,37.17,0
.goto 863,50.42,39.69,0
step
#completewith Jalaka
>>Kill Nath'vor Cannibals
.complete 47998,1 
step
>>Kill Nog'shra and Yon'gi inside the huts
.complete 47919,1 
.goto 863,49.21,33.09
.complete 47919,2 
.goto 863,50.70,35.66
step
#completewith next
.goto 863,49.50,38.40,45,0
>>Drag Jal'aka to Shoak. Kill her whilst rescuing Shoak
.complete 47919,3 
step
.goto 863,49.43,39.23
>>Talk to Shoak and kill all the attacking mobs
.complete 47925,1 
.skipgossip
.timer 5,Shoak RP
step
#label Jalaka
.goto 863,49.50,38.40
>>Kill Jal'aka
.complete 47919,3 
step
.loop 40,863,50.52,39.69,49.48,40.46,47.56,37.24,48.31,36.88,48.77,35.44,48.51,33.99,50.61,33.49,49.41,34.56,49.47,36.37,50.52,39.69
>>Kill Nath'vor Cannibals
.complete 47998,1 
step
>>Talk to Kajosh and Shoak
.turnin 47919 >>Turn in Just Say No to Cannibalism
.turnin 47998 >>Turn in Killing Cannibals
.goto 863,55.84,32.35
.turnin 47925 >>Turn in Shaok's on the Menu
.goto 863,55.81,32.25
step
.goto 863,55.56,28.79
.complete 49064,2 
.timer 29,Torga, The Turtle Loa RP
step
.goto 863,56.57,26.67
>>Wait for the RP to finish. Talk to Talanji. Do not move when talking to her otherwise you'll have to talk to her again
.turnin 49064 >>Turn in Torga, the Turtle Loa
.accept 49067 >>Accept Beseeching Bwonsamdi
.complete 49067,1 
.turnin 49067 >>Turn in Beseeching Bwonsamdi
.accept 49080 >>Accept Cease all Summoning
.skipgossip 127961,1
step
>>Talk to Lashk and Bwonsamdi
.accept 49071 >>Accept Dreadtick Combustion
.goto 863,56.51,26.65
.accept 49070 >>Accept Souls for the Death Loa
.goto 863,56.66,26.53
step
#completewith DreadtickL
>>Kill Loa-Gutter Drudges and Hexxers
.complete 49070,1 
step
#completewith next
>>Kill Dreadtick Leechers. Alternatively, use the |T1500879:0|t[Scroll of Combustion] on Dreadtick Leechers
.complete 49071,1 
.use 153024
step
.goto 863,61.04,18.08
>>Kill Summoner Yarz inside Torga's Innards
.complete 49080,1 
step
#label DreadtickL
.loop 40,863,60.08,18.94,59.90,19.82,59.58,20.04,59.47,20.03,58.72,20.52,58.73,22.11,60.86,23.31,60.71,21.99,60.95,21.96,61.51,21.60,61.55,21.19,61.08,20.41,61.80,19.68,60.08,18.94
>>Kill Dreadtick Leechers. Alternatively, use the |T1500879:0|t[Scroll of Combustion] on Dreadtick Leechers
.complete 49071,1 
.use 153024
step
.loop 40,863,60.08,18.94,59.90,19.82,59.58,20.04,59.47,20.03,58.72,20.52,58.73,22.11,60.86,23.31,60.71,21.99,60.95,21.96,61.51,21.60,61.55,21.19,61.08,20.41,61.80,19.68,60.08,18.94
>>Kill Loa-Gutter Drudges and Hexxers
.complete 49070,1 
step
>>Talk to Talanji, Lashk, and Bwonsamdi. Don't move when talking to Bwonsamdi to start the RP event
.turnin 49080 >>Turn in Cease all Summoning
.goto 863,56.57,26.67
.turnin 49071 >>Turn in Dreadtick Combustion
.goto 863,56.51,26.65
.turnin 49070 >>Turn in Souls for the Death Loa
.accept 49120 >>Accept Speaking with the Dead
.complete 49120,1 
.goto 863,56.66,26.53
.skipgossip
.timer 28,Speaking with the Dead RP
step
>>Cancel the channel. Talk to Talanji and Kisha
.turnin 49120 >>Turn in Speaking with the Dead
.goto 863,56.57,26.67
.accept 49125 >>Accept Negative Blood
.goto 863,56.59,26.75
step
#completewith NazmirCorruptedLoaBloodSix
>>Focus on freeing the Tortollan Captives
>>Kill Blood Crawgs and Crawg Riders
.complete 51689,1 
step
.goto 863,59.99,25.95
>>Use the |T1500879:0|t[Scroll of Purification] on the Corrupted Loa Blood
.complete 49125,1,1 
step
.goto 863,60.46,25.52
>>Use the |T1500879:0|t[Scroll of Purification] on the Corrupted Loa Blood
.complete 49125,1,2 
step
.goto 863,62.07,24.51
>>Use the |T1500879:0|t[Scroll of Purification] on the Corrupted Loa Blood
.complete 49125,1,3 
step
.goto 863,62.28,24.58
>>Loot the scroll on the ground
.complete 49125,2 
step
.goto 863,63.23,23.81
>>Use the |T1500879:0|t[Scroll of Purification] on the Corrupted Loa Blood
.complete 49125,1,4 
step
.goto 863,62.83,23.12
>>Use the |T1500879:0|t[Scroll of Purification] on the Corrupted Loa Blood
.complete 49125,1,5 
step
#label NazmirCorruptedLoaBloodSix
.goto 863,63.07,22.27
>>Use the |T1500879:0|t[Scroll of Purification] on the Corrupted Loa Blood
.complete 49125,1,6 
step
>>Make sure to free (Right-Click) Tortollan Captives
*Finish it now!
.complete 51689,1 
step
.goto 863,63.81,21.18
>>Use the |T1500879:0|t[Scroll of Purification] on the Corrupted Loa Blood
.complete 49125,1,7 
step
.goto 863,64.66,20.86
>>Use the |T1500879:0|t[Scroll of Purification] on the Corrupted Loa Blood
.complete 49125,1 
step
.loop 40,863,59.99,25.95,60.46,25.52,62.07,24.51,63.23,23.81,62.83,23.12,63.07,22.27,63.81,21.18,64.66,20.86,59.99,25.95
>>Focus on freeing the Tortollan Captives
>>Kill Blood Crawgs and Crawg Riders
.complete 51689,1 
step
.goto 863,65.45,17.95,30,0
.goto 863,65.72,17.96
>>Talk to Kisha under the tree
.turnin 49125 >>Turn in Negative Blood
.accept 49126 >>Accept Forcing Fate's Hand
step
>>Use the Extra Action Button
.goto 863,65.37,17.98
.complete 49126,1 
step
>>Try to focus on the large groups of mobs. Use "Uppercut of Fate" (1) to deal damage. Use "Beckon the Hand of Fate" (2) to deal AOE damage. Use "Refreshment of Fate" (3) to heal the Hand of Fate.
.goto 863,64.28,17.83,20,0
.goto 863,63.33,16.62,20,0
.goto 863,63.30,15.44,20,0
.goto 863,63.13,14.11,20,0
.goto 863,61.87,13.95,20,0
.goto 863,61.55,15.29,20,0
.complete 49126,2 
step
>>Talk to Kisha, Talanji, and Lashk
.turnin 49126 >>Turn in Forcing Fate's Hand
.accept 49130 >>Accept Loa-Free Diet
.goto 863,58.48,13.78
.accept 49131 >>Accept Sanctifying Ground
.goto 863,58.47,13.86
.accept 49132 >>Accept Crushing the Skullcrushers
.goto 863,58.51,13.89
step
#completewith SanctifyingT
>>Kill Skullcrushers, Loa-Gutter Butchers, and Loa-Gutter Darters. Loot the Butchers and Darters for Torga's parts
.complete 49132,1 
.complete 49130,1 
step
.goto 863,57.41,18.62
>>Place the totem on the ground
.complete 49131,1,1 
step
.goto 863,56.73,20.94
>>Place the totem on the ground
.complete 49131,1,2 
step
.goto 863,56.63,22.11
>>Place the totem on the ground
.complete 49131,1,3 
step
#label SanctifyingT
.goto 863,55.64,21.58
>>Place the totem on the ground
.complete 49131,1 
step
.loop 50,863,54.48,23.27,55.96,23.38,57.17,22.88,58.09,21.44,58.11,20.19,58.81,17.23,57.52,15.52,55.99,17.07,56.10,18.58,54.39,18.72,54.11,20.19,55.06,20.43,54.48,23.27
>>Kill Skullcrushers, Loa-Gutter Butchers, and Loa-Gutter Darters. Loot the Butchers and Darters for Torga's parts
.complete 49132,1 
.complete 49130,1 
step
>>Talk to Lashk,, Kisha, and Talanji
.turnin 49132 >>Turn in Crushing the Skullcrushers
.goto 863,56.51,26.65
.turnin 49130 >>Turn in Loa-Free Diet
.goto 863,56.59,26.75
.turnin 49131 >>Turn in Sanctifying Ground
.accept 49136 >>Accept Jungo, Herald of G'huun
.goto 863,56.57,26.67
step
.goto 863,61.12,17.71
>>Kill Jungo. Wait out the RP
.complete 49136,1 
step
>>Talk to Talanji and Lashk
.turnin 49136 >>Turn in Jungo, Herald of G'huun
.goto 863,56.57,26.67
.accept 49160 >>Accept Torga's Eternal Return
.goto 863,56.51,26.65
step
>>Use the |T1103069:0|t[Scroll of Eternal Return], then talk to Kisha
.complete 49160,1 
.goto 863,56.57,26.67
.turnin 49160 >>Turn in Torga's Eternal Return
.accept 49902 >>Accept To Gloom Hollow
.goto 863,56.59,26.75
.use 153131
step
.goto 863,55.73,39.71
>>Talk to Crez
.complete 49902,1,1 
.skipgossip
step
.goto 863,60.23,46.18
>>Talk to Korkush
.complete 49902,1,2 
.skipgossip
step
.goto 863,63.87,47.73
>>Talk to Yash
.complete 49902,1 
.skipgossip
step
>>Talk to Rokhan and Mutamba
.turnin 49902 >>Turn in To Gloom Hollow
.accept 47245 >>Accept Getting the Message
.goto 863,67.43,42.31
.accept 47525 >>Accept Staying Hidden
.goto 863,67.41,42.06
step
.goto 863,68.55,43.80
>>Click the Message Rocket
.complete 47245,1 
step << skip
.goto 863,68.57,46.17
.complete 47525,1 
step
.goto 863,68.59,46.74
>>Talk to Witch Doctor Zentimo
.turnin 47525 >>Turn in Staying Hidden
.accept 47659 >>Accept Hunt the Hunter
.accept 47660 >>Accept Fallen Idols
step
.goto 863,69.46,48.57
>>Loot the Idol on the ground
.complete 47660,1,1 
step
.goto 863,69.58,48.96
>>Loot the Idol on the ground
.complete 47660,1,2 
step
.goto 863,69.22,49.74
>>Loot the Idol on the ground
.complete 47660,1,3 
step
.goto 863,69.15,50.46
>>Talk to Mag'ash on the ground
.accept 48402 >>Accept A Poisonous Touch
step
#completewith NazmirStolenIdolofKragwa
>>Use the Extra Action Button on Bloodhunter Drudges, Stalkers, or Boatema. You cannot poison the same troll more than once
.complete 48402,1 
step
.goto 863,68.50,50.36
>>Loot the Idol on the ground
.complete 47660,1,4 
step
#sticky
#label Boatema
.goto 863,68.24,51.61,0,0
>>Kill Warmother Boatema
.complete 47659,1 
step
.goto 863,68.65,50.89
>>Loot the Idol on the ground
.complete 47660,1,5 
step
.goto 863,68.17,51.40
>>Loot the Idol on the ground
.complete 47660,1,6 
step
.goto 863,68.20,51.97
>>Loot the Idol on the ground
.complete 47660,1,7 
step
#requires Boatema
#label NazmirStolenIdolofKragwa
.goto 863,68.96,51.75
>>Loot the Idol on the ground
.complete 47660,1 
step
.goto 863,69.03,52.39,40,0
.goto 863,68.71,52.98,40,0
.goto 863,67.88,53.77,40,0
.goto 863,67.08,52.39,40,0
.goto 863,67.15,50.06,40,0
.goto 863,69.03,52.39,40,0
.goto 863,68.71,52.98,40,0
.goto 863,67.88,53.77,40,0
.goto 863,67.08,52.39,40,0
.goto 863,67.15,50.06
>>Use the Extra Action Button on Bloodhunter Drudges, Stalkers, or Boatema. You cannot poison the same troll more than once
.complete 48402,1 
step
.goto 863,73.37,53.68,40,0
.goto 863,75.49,56.81
>>Talk to Krag'wa
.turnin 47659 >>Turn in Hunt the Hunter
.turnin 47660 >>Turn in Fallen Idols
.turnin 48402 >>Turn in A Poisonous Touch
.accept 47623 >>Accept The Last Witch Doctor of Krag'wa
step
.goto 863,75.13,56.69
>>Loot the floating Scepter, then click Zentimo's corpse on the ground
.complete 47623,1 
.complete 47623,2 
step
.goto 863,75.49,56.81
>>Talk to Krag'wa
.turnin 47623 >>Turn in The Last Witch Doctor of Krag'wa
.accept 47621 >>Accept A True Loa Feast
.accept 47622 >>Accept A Magical Glow
step
#completewith next
>>Kill Frogmarsh Razormaws, Frogmarsh Riverbeasts, and Angry Dreadcrocs. Loot them for their Meat
.complete 47621,1 
step
>>Use the |T135446:0|t[Glowfly Bottle] near Beautiful Glowflies
.goto 863,73.25,48.21,20,0
.goto 863,73.36,48.29,20,0
.goto 863,73.22,47.65,20,0
.goto 863,74.69,45.60,20,0
.goto 863,75.07,45.59,20,0
.goto 863,75.46,45.16,20,0
.goto 863,75.99,46.02,20,0
.goto 863,76.36,45.63,20,0
.goto 863,76.60,44.67,20,0
.goto 863,77.47,45.89,20,0
.goto 863,77.18,47.32,20,0
.goto 863,76.12,47.44,20,0
.goto 863,73.25,48.21,20,0
.goto 863,73.36,48.29
.complete 47622,1 
.use 151237
step
.goto 863,73.25,48.21,20,0
.goto 863,73.36,48.29,20,0
.goto 863,73.22,47.65,20,0
.goto 863,74.69,45.60,20,0
.goto 863,75.07,45.59,20,0
.goto 863,75.46,45.16,20,0
.goto 863,75.99,46.02,20,0
.goto 863,76.36,45.63,20,0
.goto 863,76.60,44.67,20,0
.goto 863,77.47,45.89,20,0
.goto 863,77.18,47.32,20,0
.goto 863,76.12,47.44,20,0
.goto 863,73.25,48.21,20,0
.goto 863,73.36,48.29
>>Kill Frogmarsh Razormaws, Frogmarsh Riverbeasts, and Angry Dreadcrocs. Loot them for their Meat
.complete 47621,1 
step
.goto 863,77.73,53.17
>>Talk to Shadow Hunter Narez
.accept 48092 >>Accept Vengeance of the Frogs
.accept 48090 >>Accept Krag'wa's Chosen
step
#completewith Kroldra
>>Focus on destroying Frog Containers
>>Kill Vilescale Mana Tasters and Vilescale Guardians
.complete 48093,1 
step
.goto 863,79.37,53.85
>>Use the |T236885:0|t[Empowerment Potion] on Wok'grug
.complete 48090,3 
.use 158071
step
.goto 863,82.36,55.80
>>Use the |T236885:0|t[Empowerment Potion] on Wag'shash
.complete 48090,1 
.use 158071
step
.goto 863,85.34,54.91
>>Kill Priestess Zaldraxia
.complete 48092,1 
step
#label Kroldra
.goto 863,80.35,50.32
>>Use the |T236885:0|t[Empowerment Potion] on Krol'dra
.complete 48090,2 
.use 158071
step
.loop 40,863,80.66,53.80,81.12,55.26,82.87,54.44,83.14,53.54,83.07,53.19,83.79,53.20,81.75,47.61,81.49,48.41,82.55,51.58,80.66,53.80
>>Focus on destroying Frog Containers
>>Kill Vilescale Mana Tasters and Vilescale Guardians
.complete 48093,1 
step
.goto 863,77.73,53.17
>>Talk to Narez
.turnin 48090 >>Turn in Krag'wa's Chosen
.turnin 48092 >>Turn in Vengeance of the Frogs
step
#completewith next
.goto 863,77.43,54.83,20,0
.goto 863,76.02,54.80,10,0
.goto 863,75.52,54.85,12 >>Take the shortcut back to Krag'wa
step
.goto 863,75.49,56.81
>>Talk to Krag'wa
.turnin 47621 >>Turn in A True Loa Feast
.turnin 47622 >>Turn in A Magical Glow
.accept 47540 >>Accept Totemic Restoration
step
.goto 863,75.34,56.35
>>Click the Totem Pile
.complete 47540,1,1 
step
.goto 863,75.19,56.70
>>Click the Totem Pile
.complete 47540,1,2 
step
.goto 863,75.68,56.37
>>Click the Totem Pile
.complete 47540,1 
step
.goto 863,75.49,56.81
>>Talk to Krag'wa
.turnin 47540 >>Turn in Totemic Restoration
.accept 47696 >>Accept Krag'wa the Terrible
step << skip
.goto 863,67.43,55.82
.complete 47696,1 
step
#completewith next
.vehicle >>Travel to Razorjaw River. Talk to Krag'wa
.goto 863,67.12,56.24
.skipgossip
step
>>Use "Belly Smash" (1) to leap onto trolls to kill them. Use "Tongue Lash" (2) to kill trolls in melee range
>>Kill Ren'Zuli and Bloodhunter Warriors, War Slaves, and War-Witches
.complete 47696,3 
.goto 863,60.01,53.35
.complete 47696,2 
.goto 863,60.81,52.56,60,0
.goto 863,61.85,52.67,60,0
.goto 863,62.22,54.44,60,0
.goto 863,62.79,55.60
step
>>Talk to Krag'wa and Mutumba
.turnin 47696 >>Turn in Krag'wa the Terrible
.goto 863,75.49,56.81
.accept 47697 >>Accept Krag'wa's Aid
.goto 863,75.18,56.67
step << skip
.goto 863,67.53,43.23
.complete 47697,1 
step
>>Talk to Rokhan and Talanji
.turnin 47245 >>Turn in Getting the Message
.accept 47631 >>Accept Rendezvous with the Libation
.goto 863,67.43,42.31
.turnin 47697 >>Turn in Krag'wa's Aid
.goto 863,67.43,42.24
step << skip
.goto 863,74.45,39.48
.complete 47631,1 
step
>>Talk to Patch and Ticker
.turnin 47631 >>Turn in Rendezvous with the Libation
.accept 47597 >>Accept No Goblin Left Behind
.goto 863,74.59,38.86
.accept 47599 >>Accept Revenge: Served Hot
.goto 863,74.76,39.01
step
#completewith TickersRL
>>Focus on rescuing Injured and Captive Sailors
>>Kill Vilescale Slavers, Sorceresses, and Fathom-Hunters
.complete 47756,1 
step
.goto 863,77.69,36.14
.turnin 49867 >> Loot the chest on the ground
step
#completewith next
>>Use |T369278:0|t[Ticker's Rocket Launcher] on Vilescale Behemoths
.complete 47599,1 
.use 151363
step
>>Rescue Newt, Grit, and Volt
.complete 47597,2 
.goto 863,79.30,36.73
.complete 47597,1 
.goto 863,76.99,32.64
.complete 47597,3 
.goto 863,79.95,32.36
step
#label TickersRL
.goto 863,80.50,30.12,40,0
.goto 863,80.34,32.57,40,0
.goto 863,81.05,33.56,40,0
.goto 863,81.26,33.32,40,0
.goto 863,79.57,35.34,40,0
.goto 863,78.56,34.92,40,0
.goto 863,78.34,37.10,40,0
.goto 863,78.71,32.47,40,0
.goto 863,77.55,29.65,40,0
>>Use |T369278:0|t[Ticker's Rocket Launcher] on Vilescale Behemoths
.complete 47599,1 
.use 151363
step
.loop 50,863,78.54,30.05,80.01,31.77,79.85,33.79,78.93,33.32,78.67,34.31,78.20,34.73,76.56,33.56,77.67,33.17,76.90,31.62,78.54,30.05
>>Focus on rescuing Injured and Captive Sailors
>>Kill Vilescale Slavers, Sorceresses, and Fathom-Hunters
.complete 47756,1 
step << skip
.goto 863,82.15,26.70
.fp Forlon Ruins >> Get the Forlon Ruins flight path
step
>>Talk to Patch, Ticker, and Newt inside the building
.goto 863,82.10,26.94,20,0
.turnin 47597 >>Turn in No Goblin Left Behind
.accept 47711 >>Accept Head of the Viper
.goto 863,82.37,27.30
.turnin 47599 >>Turn in Revenge: Served Hot
.accept 47596 >>Accept There Is No Plan "B"
.goto 863,82.10,26.94
.accept 47598 >>Accept Pilfering and Fencing
.goto 863,82.28,27.41
step
#completewith FiringMechanism
>>Kill Vilescale Warriors, Hydromancers, and Tidebinders. Loot them for their Relics
.complete 47598,1 
step
.goto 863,79.16,27.43
>>Loot the Gears on the ground
.complete 47596,2 
step
.goto 863,78.63,25.15
>>Kill Lord Slithin
.complete 47711,1 
step
.goto 863,77.67,25.28
>>Loot the Barrel on the ground
.complete 47596,1 
step
#label FiringMechanism
.goto 863,79.57,22.25
>>Loot the Mechanism on the ground
.complete 47596,3 
step
.loop 50,863,79.16,27.43,77.67,25.28,79.57,22.25
>>Kill Vilescale Warriors, Hydromancers, and Tidebinders. Loot them for their Relics
.complete 47598,1 
step
>>Talk to Newt, Patch, and Ticker
.goto 863,82.10,26.94,20,0
.turnin 47598 >>Turn in Pilfering and Fencing
.goto 863,82.28,27.41
.turnin 47711 >>Turn in Head of the Viper
.accept 47601 >>Accept Field Evaluation
.goto 863,82.37,27.30
.turnin 47596 >>Turn in There Is No Plan "B"
.goto 863,82.37,27.30
step
>>Mount A.M.O.D.
.goto 863,81.45,26.02
.complete 47601,1 
step
.goto 863,75.22,20.81
>>Use "High Explosives" (1) to kill the Nagas
.complete 47601,2,10 
step
.goto 863,75.48,18.12
>>Use "Cluster Shot" (2) to kill the Nagas. Ignore the turrets
.complete 47601,2 
step
.goto 863,77.56,16.55
>>Use "Azerite Power Shell" (3) to kill Grobathan
.complete 47601,3 
step
.goto 863,81.34,26.09
>>Talk to Patch
.turnin 47601 >>Turn in Field Evaluation
.accept 47602 >>Accept Ready For Action
.timer 6,Ready for Action RP
step
.goto 863,81.31,26.23
>>Get into Newt's Emergency Rocket after the RP
.complete 47602,1 
.skipgossip
.timer 21, Ready for Action Flight
step << skip
.goto 863,67.26,42.86
.complete 47602,2 
step
>>Talk to Talanji and Lashk
.turnin 47602 >>Turn in Ready For Action
.goto 863,67.43,42.24
.accept 49932 >>Accept Slumber No More
.goto 863,67.49,41.95
step
#completewith next
.goto 863,67.01,41.52
>>Talk to Crez
.vendor
step
>>Click the Titan Keeper, Damaged Core, and then the Titan Keeper again. Talk to him
.complete 49932,1 
.goto 863,66.92,38.88
.complete 49932,2 
.goto 863,66.96,38.79
.complete 49932,3 
.goto 863,66.92,38.88
step
>>Talk to Titan Keeper Hezrel
.turnin 49932 >>Turn in Slumber No More
.accept 49935 >>Accept How to Repair a Titan Keeper
.accept 49938 >>Accept Corrupted Earth
.accept 49937 >>Accept Recovering Remnants
.goto 863,66.92,38.88
step
#completewith next
>>Kill Blood-Infused Lashers and Nawathan Spectres. Loot Spectres for their Titan Plating
.complete 49937,1 
.complete 49938,1 
step
.goto 863,66.18,33.65
>>Click Titan Keeper Bolcan. Kill him. Loot him for his Core
.complete 49935,2 
step
#completewith next
.goto 863,67.87,36.23,30,0
>>Kill Blood-Infused Lashers and Nawathan Spectres. Loot Spectres for their Titan Plating
.complete 49937,1 
.complete 49938,1 
step
.goto 863,69.24,39.77
>>Loot Shavras's core on the ground
.complete 49935,1 
step
.loop 40,863,67.60,37.69,65.81,38.31,66.41,36.02,65.63,32.81,66.71,32.93,67.74,34.00,67.45,36.10,67.92,36.77,69.12,36.64,69.96,39.46,67.60,37.69
>>Kill Blood-Infused Lashers and Nawathan Spectres. Loot Spectres for their Titan Plating
.complete 49937,1 
.complete 49938,1 
step
.goto 863,68.68,35.11
>>Talk to Hezrel
.turnin 49935 >>Turn in How to Repair a Titan Keeper
.turnin 49937 >>Turn in Recovering Remnants
.turnin 49938 >>Turn in Corrupted Earth
.accept 49941 >>Accept Bone Procession
.accept 49949 >>Accept Unwelcome Undead
step
#completewith Monstrosity
>>Kill Nazwathan Guardians and Blood Benders
.complete 49949,1 
step
>>Talk to the Minor Corruption
.goto 863,69.25,33.81
.accept 49950 >>Accept Blood Purification
step
#completewith next
>>Use the |T897143:0|t[Titan Manipulator] on Reanimated Monstrosities to weaken them. Kill them. Loot them for their Bones
.complete 49941,1 
.use 156528
step
.goto 863,69.50,33.30
>>Click the Corrupted Energy to destroy it
.complete 49950,1,1 
step
#completewith next
.goto 863,72.32,33.32,40,0
.goto 863,73.03,37.19,40,0
>>Use the |T897143:0|t[Titan Manipulator] on Reanimated Monstrosities to weaken them. Kill them. Loot them for their Bones
.complete 49941,1 
.use 156528
step
.goto 863,68.80,31.61
>>Click the Corrupted Energy to destroy it
.complete 49950,1,2 
step
.goto 863,69.44,30.56,15,0
.goto 863,69.25,30.28
>>Go into the building. Click the Corrupted Energy to destroy it
.complete 49950,1,3 
step
#label CEnergy
.goto 863,70.10,29.86
>>Click the Corrupted Energy to destroy it
.complete 49950,1 
step
#label Monstrosity
.goto 863,67.09,28.98,40,0
.goto 863,66.44,31.53,40,0
.goto 863,73.03,37.19,40,0
.goto 863,72.32,33.32,40,0
.goto 863,68.80,31.61,40,0
.goto 863,70.10,29.86,40,0
.goto 863,67.09,28.98,40,0
.goto 863,66.44,31.53,40,0
.goto 863,73.03,37.19,40,0
.goto 863,72.32,33.32,40,0
.goto 863,68.80,31.61,40,0
.goto 863,70.10,29.86,40,0
>>Use the |T897143:0|t[Titan Manipulator] on Reanimated Monstrosities to weaken them. Kill them. Loot them for their Bones
.complete 49941,1 
.use 156528
step
.loop 50,863,69.31,34.13,69.89,33.36,69.30,32.36,70.54,29.97,69.87,27.55,68.68,27.81,69.31,34.13,71.77,36.71,73.56,34.64,72.74,32.87,70.94,35.02,69.89,33.36
>>Kill Nazwathan Guardians and Blood Benders
.complete 49949,1 
step
.goto 863,68.68,35.11
>>Talk to Hezrel
.turnin 49941 >>Turn in Bone Procession
.turnin 49949 >>Turn in Unwelcome Undead
.turnin 49950 >>Turn in Blood Purification
.accept 49957 >>Accept Protocol Recovery
.accept 49956 >>Accept Void is Prohibited
.accept 49955 >>Accept Not Fit for This Plane
step
#completewith VoidPortals
>>Kill Faceless Corruptors, Destroyers, and Subjugators
.complete 49955,1 
step
.goto 863,70.52,32.34
>>Use your |T2347445:0|t[Void Disruptor] next to the Void Portal
.complete 49956,1,1 
.use 156542
step
.goto 863,70.70,31.72,15,0
.goto 863,70.32,31.17
>>Use your |T2347445:0|t[Void Disruptor] next to the Void Portal
.complete 49956,1,2 
.use 156542
step
.goto 863,71.38,30.08
>>Use your |T2347445:0|t[Void Disruptor] next to the Void Portal
.complete 49956,1,3 
.use 156542
step
#label VoidPortals
.goto 863,71.22,31.32
>>Use your |T2347445:0|t[Void Disruptor] next to the Void Portal
.complete 49956,1 
.use 156542
step
.goto 863,71.22,32.55,20,0
.goto 863,72.30,31.15,20,0
.goto 863,74.51,31.56,30,0
.goto 863,72.30,31.15,40,0
.goto 863,70.93,29.20,20,0
.goto 863,70.99,27.56,20,0
>>Kill Faceless Corruptors, Destroyers, and Subjugators
.complete 49955,1 
step
.goto 863,71.96,30.20,20,0
.goto 863,72.83,28.92
>>Kill Overlord Kraxis. Loot him for his Protocol
.complete 49957,1 
step
.goto 863,72.47,29.36
>>Talk to Hezrel. Press "Escape" on your keyboard to skip the cinematic
.turnin 49955 >>Turn in Not Fit for This Plane
.turnin 49956 >>Turn in Void is Prohibited
.turnin 49957 >>Turn in Protocol Recovery
.accept 49980 >>Accept Containment Procedure
.complete 49980,1 
.skipgossip 131253,1
step
.goto 863,72.82,28.92
>>Kill Grand Ma'da Ateena
*Run to Hezrel's bubble when Ateena casts Bloody Apocalypse
.complete 49980,2 
step
.goto 863,72.47,29.36
>>Talk to Hezrel
.turnin 49980 >>Turn in Containment Procedure
.accept 49985 >>Accept Return to Gloom Hollow
step
.goto 863,71.85,30.39
.vehicle >>Mount Hezrel outside
.timer 18,Hezrel Ride RP
.isOnQuest 49985

step
>>Talk to Talanji and Yash
.turnin 49985 >>Turn in Return to Gloom Hollow
.goto 863,67.43,42.24
.accept 50934 >>Accept A Chance Sighting
.goto 863,66.84,41.93
step << skip
.goto 863,66.98,43.78
.fp Gloom Hollow >> Get the Gloom Hollow flight path
step
.goto 863,64.01,50.39
>>Talk to the Antidote on the ground
.turnin 50934 >>Turn in A Chance Sighting
.accept 49366 >>Accept Aid the Wounded
step
.goto 863,63.99,50.39
>>Use the |T650641:0|t[Vial of Liquid] on Guard Satao to start the RP
.complete 49366,1 
.timer 46,Aid the Wounded RP
.use 153676
step
.goto 863,63.16,52.69
>>Wait out the RP. Talk to Guard Satao
.turnin 49366 >>Turn in Aid the Wounded
.accept 49370 >>Accept Rescue the Chronicler
.accept 49380 >>Accept Bad Juju
.accept 49377 >>Accept Off With Her Head
step
.goto 863,62.53,53.56
>>Click the Cage Anchor
.complete 49370,1 
step
.goto 863,62.72,53.58
>>Talk to Chronicler Jabari
.turnin 49370 >>Turn in Rescue the Chronicler
.accept 49378 >>Accept Earn Their Trust
.accept 49379 >>Accept Crawg Free Zone
step
.goto 863,61.84,52.48
>>Click a Crawgling to bond with them
.complete 49378,1 
step
#completewith Nagla
>>Kill Battle Crawgs, Amaki War Slaves, Amaki Guards, and Amaki Bloodsingers
.complete 49378,2 
.complete 49379,1 
step
.goto 863,60.17,53.42
>>Use the |T134865:0|t[Sample Bottle] on the Blood Orb
.complete 49380,1 
.use 153678
step
.goto 863,60.47,55.82
>>Use the |T134865:0|t[Sample Bottle] on the Blood Orb
.complete 49380,3 
.use 153678
step
#label Nagla
.goto 863,62.12,57.32
>>Kill Warmother Nagla. Loot him for his Head
.complete 49377,1 
step
#completewith BloodOrbD
>>Kill Amaki War Slaves, Amaki Guards, and Amaki Bloodsingers
.complete 49378,2 
step
.loop 30,863,62.79,57.23,62.93,57.79,62.20,58.34,60.74,58.57,61.56,56.58,62.60,55.29,62.79,57.23
>>Kill Battle Crawgs
.complete 49379,1 
step
#label BloodOrbD
.goto 863,62.18,54.47
>>Use the |T134865:0|t[Sample Bottle] on the Blood Orb
.complete 49380,2 
.use 153678
step
.loop 40,863,62.18,54.47,60.17,53.42,60.47,55.82,62.18,54.47
>>Kill Amaki War Slaves, Amaki Guards, and Amaki Bloodsingers
.complete 49378,2 
step
#requires NazmirBloodOrbDrained
>>Talk to Jabari and Satao
.turnin 49379 >>Turn in Crawg Free Zone
.turnin 49378 >>Turn in Earn Their Trust
.goto 863,63.17,52.75
.turnin 49380 >>Turn in Bad Juju
.turnin 49377 >>Turn in Off With Her Head
.goto 863,63.16,52.69
step
#completewith SnapjawM
.hs >>Hearth to Zul'jan Ruins
step
#completewith SnapjawM
.goto 863,39.15,77.66
.cast 6478 >>Interact (Right-Click) with the Altar of Bwonsamdi
step
.goto 863,38.83,77.71
>>Talk to Sur'jan
.turnin 48669 >>Turn in Urok, Terror of the Wetlands
.accept 48573 >>Accept Crocolisk Life
.accept 48574 >>Accept Pulling Fangs
step
#completewith next
>>Kill Saurids. Loot them for their Teeth
.complete 48574,1 
step
#label SnapjawM
.goto 863,38.17,75.32,40,0
.goto 863,35.68,76.50,40,0
.goto 863,37.00,79.93,40,0
.goto 863,36.23,79.53,40,0
.goto 863,34.08,74.17,40,0
.goto 863,38.17,75.32,40,0
.goto 863,35.68,76.50,40,0
.goto 863,37.00,79.93,40,0
.goto 863,36.23,79.53,40,0
.goto 863,34.08,74.17
>>Kill Primal Snapjaws. Use the |T250628:0|t[Sur'jan Ritual Dagger] near their corpses
.complete 48573,1 
.use 152596
step
.loop 40,863,34.14,75.89,36.48,71.33,36.38,73.79,38.16,74.64,38.68,75.65,36.09,77.53,36.47,80.15,34.14,75.89
>>Kill Saurids. Loot them for their Teeth
.complete 48574,1 
step
.goto 863,34.08,78.57
>>Talk to Sur'jan. Wait out his RP
.turnin 48573 >>Turn in Crocolisk Life
.turnin 48574 >>Turn in Pulling Fangs
.timer 9,Sur'jan RP
.accept 48576 >>Accept Safe Flying
.accept 48577 >>Accept Terrorizing their Eggs
.accept 48578 >>Accept There's No Eye in Skyterror
step
#completewith Jarkadiax
>>Kill Primal Skyterrors. Use the |T1373906:0|t[Sur'jan Grappling Hook] to hook down those that are flying
.complete 48576,1 
.use 152610
step
.goto 863,33.40,85.29
>>Click the eggs to destroy them
.complete 48577,1,2 
step
.goto 863,33.64,85.19
>>Click the egg to destroy it
.complete 48577,1,3 
step
.goto 863,33.87,84.81
>>Click the eggs to destroy them
.complete 48577,1 
step
#label Jarkadiax
>>Travel up the mountain. Kill Jarkadiax. Loot him for his Eye
.goto 863,34.89,84.83,15,0
.goto 863,34.51,86.07,20,0
.goto 863,33.81,86.04
.complete 48578,1 
step
.goto 863,35.38,86.60,40,0
.goto 863,35.28,85.27,40,0
.goto 863,34.10,83.15,40,0
.goto 863,35.76,81.28,40,0
.goto 863,32.36,81.50,40,0
.goto 863,35.38,86.60,40,0
.goto 863,35.28,85.27,40,0
.goto 863,34.10,83.15,40,0
.goto 863,35.76,81.28,40,0
.goto 863,32.36,81.50
>>Kill Primal Skyterrors. Use the |T1373906:0|t[Sur'jan Grappling Hook] to hook down those that are flying
.complete 48576,1 
.use 152610
step
.goto 863,34.08,78.57
>>Talk to Sur'jan. Wait out his RP
.turnin 48576 >>Turn in Safe Flying
.turnin 48578 >>Turn in There's No Eye in Skyterror
.turnin 48577 >>Turn in Terrorizing their Eggs
.timer 8,Sur'jan RP
.accept 48584 >>Accept The Blood of My Enemies
.accept 48590 >>Accept My Head and Shoulders
step
#completewith DreadtickB
>>Kill Infected Saurolisks. Run on top of their eggs
.goto 863,27.71,77.90,40,0
.complete 48588,1 
step
.goto 863,28.73,76.74
>>Loot the Shoulderpad on the ground under the tree
.complete 48590,3 
step
#completewith Shoulderpad
>>Use |T136173:0|t[Sur'jan Dreadtick Gasser] to kill Dreadtick Latchers. Loot them for their Blood
.complete 48584,1 
step
.goto 863,30.27,75.27,25,0
.goto 863,31.62,73.48
>>Loot the Helm on the ground
.complete 48590,1 
step
#label Shoulderpad
.goto 863,31.05,71.37
>>Loot the Shoulderpad next to the bones
.complete 48590,2 
step
#label DreadtickB
.goto 863,30.70,71.28,40,0
.goto 863,29.37,70.44,40,0
.goto 863,28.13,70.68,40,0
.goto 863,29.54,74.78,40,0
.goto 863,30.13,75.30,40,0
.goto 863,30.89,75.16
>>Use |T136173:0|t[Sur'jan Dreadtick Gasser] to kill Dreadtick Latchers. Loot them for their Blood
.complete 48584,1 
step
.loop 40,863,29.99,69.78,28.40,69.86,29.39,75.15,27.03,77.66,27.21,78.55,28.34,78.80,30.32,76.84,30.97,74.43,33.42,71.77,29.99,69.78
>>Kill Infected Saurolisks. Run on top of their eggs
.complete 48588,1 
step
.goto 863,28.76,72.63
>>Talk to Sur'jan. Wait out his RP
.turnin 48584 >>Turn in The Blood of My Enemies
.turnin 48590 >>Turn in My Head and Shoulders
.timer 14,Sur'jan RP
.accept 48591 >>Accept Urok's True Death
step
.goto 863,25.65,73.58
>>Kill Urok inside the cave
.complete 48591,1 
step
.goto 863,28.76,72.63
>>Talk to Sur'jan. Wait out his RP
.turnin 48591 >>Turn in Urok's True Death
step
#completewith next
.hs >>Hearth to Zul'jan Ruins
.cooldown item,6948,>0
step
.goto 863,38.85,78.14
.fly The Great Seal >>Fly to The Great Seal
.zoneskip 863,1
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Horde 10-60
#name 2 Horde Draenor Garrison
#displayname Chapter 3 - Draenor Garrison Intro
#next 3 Horde Zuldazar
#veteran
<< Horde
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Farseer Drek'Thar
.goto 525,40.79,67.09
.turnin -33868 >>Turn in The Home of the Frostwolves
.accept 33815 >>Accept A Song of Frost and Fire
.timer 30,Introduction Roleplay
step
>>Wait next to Durotan for ~20s
.goto 525,41.54,67.61,20,0
.goto 525,41.81,69.65
.complete 33815,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Durotan
.goto 525,41.81,69.65
.turnin 33815 >>Turn in A Song of Frost and Fire
.accept 34402 >>Accept Of Wolves and Warriors
step
>>Follow the arrow up the mountain
.goto 590,43.54,68.35,20,0
.goto 590,16.70,73.02,20,0
step
>>Follow the way up the mountain and talk to Thrall after he has arrived.
.goto 590,51.17,43.27
.turnin 34402 >>Turn in Of Wolves and Warriors
.accept 34364 >>Accept For the Horde!
step
>>Interact with the shade of the Horde Banner
.goto 590,50.67,39.48
.complete 34364,1 
step
>>Wait for Gazlow and talk to him
.goto 590,51.25,39.61
.turnin 34364 >>Turn in For the Horde!
.accept 34375 >>Accept Back to Work
.accept 34592 >>Accept A Gronnling Problem
step
#sticky
#label FrostfireRidgeFrostfireGronnling
>>Kill |cff00ecffFrostfire Gronnlings|r
.goto 590,40.18,28.26,0,0
.complete 34592,1 
step
#title Tree marked 1
>>Interact with the Tree Marking
.goto 590,47.29,57.32
.complete 34375,1,1 
step
#title Tree marked 2
>>Interact with the Tree Marking
.goto 590,48.59,62.82
.complete 34375,1,2 
step
#title Tree marked 3
>>Interact with the Tree Marking
.goto 590,56.86,69.14
.complete 34375,1,3 
step
#title Tree marked 4
>>Interact with the Tree Marking
.goto 590,59.53,72.74
.complete 34375,1,4 
step
#title Tree marked 5
>>Interact with the Tree Marking
.goto 590,62.64,55.31
.complete 34375,1,5 
step
#title Tree marked 6
>>Interact with the Tree Marking
.goto 590,63.30,51.90
.complete 34375,1 
step
#requires FrostfireRidgeFrostfireGronnling
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gazlowe
.goto 590,51.26,39.63
.turnin 34375 >>Turn in Back to Work
.turnin 34592 >>Turn in A Gronnling Problem
.accept 34765 >>Accept The Den of Skog
step
>>Watch out for Skog's Ground Slap ability while fighting him.
.goto 590,48.88,84.72
.complete 34765,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gazlowe
.goto 590,51.26,39.63
.turnin 34765 >>Turn in The Den of Skog
.accept 34378 >>Accept Establish Your Garrison
step
>>Interact with the Master Surveyor
.goto 590,35.60,52.46
.complete 34378,1 
step
#completewith GarridonEndStartQuests
+Addons can't track the position of characters inside the garrison. Therefore it's not possible to create waypoints.
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gazlow in front of the Architect Table
.turnin 34378 >>Turn in Establish Your Garrison
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gazlow
.accept 34824 >>Accept What We Got
.accept 34822 >>Accept What We Need
step
.isOnQuest 34824
>>Interact with the Garrison Cache to the left
.complete 34824,2 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk with Rokhan near Gazlowe
.accept 34823 >>Accept The Ogron Live?
step
.isOnQuest 34824
#completewith next
.fp >>Get the Garrison Flightpoint
step
.isOnQuest 34824
>>Leave the garrison next to the Flight Master and talk to Skaggit to the left
.skipgossip
.complete 34824,1 
step
.isOnQuest 34824
>>Go north and talk to Senior Peon II
*He's marked on your minimap with a yellow dot
.skipgossip
.complete 34824,3 
step
.isOnQuest 34822
.itemcount 132516,1
#completwith next
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
.isOnQuest 34822
#completewith next
.goto 525,40.24,60.14,30 >>Run west and enter the cave. Right click your map and it will show you the location.
step
.isOnQuest 34822
#completewith next
>>Kill and LOOT Pack Boars or pick up Drudgeboat Salvages
.complete 34822,1 
step
.isOnQuest 34823
>>Be sure to avoid his Rampaging Strike and Earthrending Slam.
.goto 525,40.29,58.95,10,0
.goto 525,41.92,59.19
.complete 34823,1 
step
.isOnQuest 34822
>>Kill and loot Pack Boars or pick up Drudgeboat Salvages
.goto 525,42.04,59.51,5,0
.goto 525,42.17,50.09,5,0
.goto 525,41.79,58.30,10,0
.goto 525,40.18,59.91,10,0
.complete 34822,1 
step
.isOnQuest 34823
.zoneskip 590
#completewith next
.cast 171253 >>Use your Garrison Hearthstone
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk with Gazlowe and Rokhan just outside the building
.turnin -34824 >>Turn in What We Got
.turnin -34822 >>Turn in What We Need
.turnin -34823 >>Turn in The Ogron Live?
step
.isQuestTurnedIn 34823
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gazlowe
.accept 34461 >>Accept Build Your Barracks
step
.isOnQuest 34461
>>Look at your minimap and go to the yellow mark to pick up the blueprint
.collect 111956,1,34461,1
.complete 34461,1 
step
.isOnQuest 34461
>>Use the blueprint 'Barracks, Level 1' in your bags
.use 111956
.complete 34461,2 
step
.isOnQuest 34461
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gazlow and interact with the Architect Table
*Drag and drop 'Barrack' from the list on the left onto the glowing circle on the right
.complete 34461,3 
step
.isOnQuest 34461
>>Now you have to wait for ~10s and follow Gazlowe. If he doesn't move then talk to him, open the Architect Table again or just wait for 1-2 minutes longer.
.complete 34461,4 
step
.isOnQuest 34461
>>Interact with the flying scroll
.complete 34461,5 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gazlowe
.turnin -34461 >>Turn in Build Your Barracks
step
.isQuestTurnedIn 34461
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gazlowe
.accept 34861 >>Accept We Need An Army
step
.isQuestTurnedIn 34461
#label GarridonEndStartQuests
>>Enter the building next to the Architect Table and talk to Warmaster Zog
.turnin -34861 >>Turn in We Need An Army
.accept 34462 >>Accept Winds of Change
step
.zoneskip 85
.hs >>Hearth to The Broken Tusk
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Horde 10-60
#name 3 Horde Vol'dun
#displayname Chapter 5 - Vol'dun
#next 4 Horde Zuldazar Second Half
#maxlevel 60
#fresh
<< Horde
step
.goto 1164,41.67,69.17
>>Click the Scouting Map, then click on Vol'dun
.accept 47513 >>Accept Vol'dun
step
.goto 1164,41.22,66.75
>>Talk to Talanji
.turnin 47513 >>Turn in Vol'dun
.accept 47313 >>Accept Discreet Discussions
step
#completewith next
>>Talk to Araka and buy 3 Explorer's Packs from her. Equip them. Skip this step if your bags are better
.goto 1163,61.06,30.25
.collect 138293,3 

step
.goto 1165,50.10,37.45
>>Talk to Sekal
.complete 47313,1,1 
.skipgossip
step
.goto 1165,51.71,37.79,15,0
.goto 1165,52.19,37.53
>>Talk to Gortok
.complete 47313,1,2 
.skipgossip
step
.goto 1165,54.28,35.85
>>Talk to Dakanji
.complete 47313,1 
.skipgossip
step << skip
>>Ignore the mobs and just follow the arrow
.goto 1165,52.81,32.61
.complete 47313,2 
step
.goto 1165,51.58,31.82
>>Talk to Kaja
.turnin 47313 >>Turn in Discreet Discussions
.accept 47314 >>Accept Rumors of Exile
.timer 41,Rumors of Exile RP
step
.goto 1165,49.92,31.63
>>Wait out the RP. Talk to Kaja
.turnin 47314 >>Turn in Rumors of Exile
.accept 47315 >>Accept Into the Dunes
step
.goto 1165,50.04,31.67
>>Mount the Pterrordax
.complete 47315,1 
.timer 93,Into the Dunes RP
step
.goto 864,66.08,36.43
>>Wait out the RP. Press "Escape" on your keyboard to skip the cinematic
.complete 47315,2 
.timer 24,Into the Dunes Nisha RP
step
>>Talk to Nisha
.goto 864,65.98,36.65
.turnin 47315 >>Turn in Into the Dunes
.accept 51357 >>Accept Armed and Ready
step
>>Loot the Sethrak Scimitar on the left. Talk to Nisha
.complete 51357,1 
.goto 864,65.93,36.68
.turnin 51357 >>Turn in Armed and Ready
.accept 47327 >>Accept Answering Their Attacks
.accept 49676 >>Accept Dressed for Battle
.goto 864,65.98,36.65
step
#completewith VoldunNishasAttackPlans
>>Kill Sethrak
.complete 47327,1 
step
>>Loot the Banner on the tire, Helmet on the wood, and Explosives on the ground
.complete 49676,1 
.goto 864,64.67,33.91
.complete 49676,2 
.goto 864,63.63,32.70
.complete 49676,3 
.goto 864,61.88,33.78
step
.goto 864,61.88,33.78
>>Talk to Nisha when out of combat
.turnin 47327 >>Turn in Answering Their Attacks
.turnin 49676 >>Turn in Dressed for Battle
.accept 49677 >>Accept Plans for Attack
.isQuestComplete 47327
step
.goto 864,61.88,33.78
>>Talk to Nisha when out of combat
.turnin 49676 >>Turn in Dressed for Battle
.accept 49677 >>Accept Plans for Attack
step
#label VoldunNishasAttackPlans
>>Kill Fangcaller Sraka. Loot her for her Attack Plans
.goto 864,60.87,32.67
.complete 49677,1 
step
.goto 864,61.41,32.00,40,0
.goto 864,61.39,32.59,40,0
.goto 864,62.30,32.72,40,0
.goto 864,63.04,34.43,40,0
.goto 864,63.88,34.77,40,0
.goto 864,64.09,36.26,40,0
.goto 864,61.41,32.00,40,0
.goto 864,61.39,32.59,40,0
.goto 864,62.30,32.72,40,0
.goto 864,63.04,34.43
>>Kill Sethrak
.complete 47327,1 
step
>>Talk to Nisha when out of combat
.turnin 47327 >>Turn in Answering Their Attacks
.turnin 49677 >>Turn in Plans for Attack
.accept 51364 >>Accept An Explosive Exit
step << skip
>>Wait for the roleplay to finish
.goto 864,60.06,34.58
.complete 51364,1 
step
.goto 864,60.05,34.59
>>Get onto the Wagon
.complete 51364,2 
.timer 63,Wagon Ride RP
step
.goto 864,56.79,50.54
>>Wait out the RP

.complete 51364,4 
step
>>Talk to Kiro and Meerah
.turnin 51364 >>Turn in An Explosive Exit
.accept 47319 >>Accept Restorative Venom
.goto 864,56.79,50.54
.accept 51574 >>Accept Freshly Squeezed
.goto 864,56.76,50.52
step << skip
.goto 864,56.96,49.25
.fp Vulpera Hideaway >> Get the Vulpera Hideaway flight path
step
.goto 864,55.20,48.39
>>Talk to Vivi
.accept 50739 >>Accept Missing Business
step
#completewith Polecats
>>Kill Venomous Sandstingers and Sandstinger Drones. Loot them for their Glands
>>Loot the Picklevine on the ground for its Juice. Spam click this to get 4-5 Juice per Picklevine
.complete 47319,1 
.complete 51574,1 
step
.goto 864,54.13,49.26
>>Click the Polecat to revive it
.complete 50739,1,1 
.use 159729
step
.goto 864,53.84,49.72
>>Click the Polecat to revive it
.complete 50739,1,2 
.use 159729
step
.goto 864,53.32,50.32
>>Use the |T650640:0|t[Sandstinger Remedy] near the Polecats to revive them both at once
.complete 50739,1,4 
.use 159729
step
.goto 864,53.49,50.85
>>Click the Polecat to revive it
.complete 50739,1,5 
.use 159729
step
.goto 864,53.94,50.49
>>Click the Polecat to revive it
.complete 50739,1,6 
.use 159729
step
#label Polecats
.goto 864,54.35,51.22
>>Click the Polecat to revive it
.complete 50739,1 
.use 159729
step
.loop 30,864,54.29,51.10,54.49,48.68,53.31,49.11,52.89,49.86,53.06,50.54,53.32,51.45,52.73,52.30,53.32,51.45,54.29,51.10
>>Kill Venomous Sandstingers and Sandstinger Drones. Loot them for their Glands
>>Loot the Picklevine on the ground for its Juice. Spam click this to get 4-5 Juice per Picklevine
.complete 47319,1 
.complete 51574,1 
step
>>Return to the Vulpera Hideaway. Talk to Meerah and Kiro
.goto 864,54.62,50.94,30,0
.turnin 51574 >>Turn in Freshly Squeezed
.goto 864,56.76,50.53
.turnin 47319 >>Turn in Restorative Venom
.accept 47320 >>Accept A Balm to Calm
.goto 864,56.79,50.54
step
.goto 864,56.83,50.52
>>Use the |T134737:0|t[Restorative Balm] on Kaja on the ground
.complete 47320,1 
.cast 244636
.timer 5,A Balm to Calm RP
.use 150759
step
>>Wait out the RP. Talk to Kaja, Kiro, and Meerah
.turnin 47320 >>Turn in A Balm to Calm
.accept 47317 >>Accept Searching for Survivors
.goto 864,56.83,50.52
.accept 47321 >>Accept Knickknack Takeback
.goto 864,56.79,50.54
.accept 47316 >>Accept Secrets in the Sand
.goto 864,56.76,50.53
step
.goto 864,55.78,48.68
>>Loot the page on the ground
.complete 47316,1,1 
step
.goto 864,55.20,48.39
>>Talk to Vivi
.turnin 50739 >>Turn in Missing Business
step
.goto 864,52.80,46.41
>>Loot the page on the ground
.complete 47316,1,2 
step
.goto 864,52.78,41.79
>>Loot the page on the ground
.complete 47316,1,3 
step
>>Talk to Neri and Mekaru
.accept 47322 >>Accept Aided Escape
.goto 864,54.69,42.49
.accept 50755 >>Accept A Meal for Birds
.goto 864,54.75,42.40
step
#completewith Hakasi
>>Kill Faithless. Loot them for their Knickknacks
.complete 47321,1 
step
.goto 864,54.75,40.27
>>Click the cage to free Kipp
.complete 47322,2 
step
.goto 864,54.82,39.64,15,0
.goto 864,54.61,39.38
>>Go inside the cave. Talk to the sword
.complete 47317,1 
step
#label Hakasi
.goto 864,56.41,39.30
>>Click the cage to free Hakasi
.complete 47322,1 
step
.goto 864,56.24,38.99,40,0
.goto 864,55.36,39.19,40,0
.goto 864,54.84,40.39,40,0
.goto 864,54.74,41.16,40,0
.goto 864,55.85,41.01,40,0
.goto 864,56.24,38.99,40,0
.goto 864,55.36,39.19,40,0
.goto 864,54.84,40.39,40,0
.goto 864,54.74,41.16,40,0
.goto 864,55.85,41.01,40,0
.goto 864,56.24,38.99
>>Kill Faithless. Loot them for their Knickknacks
.complete 47321,1 
step
#completewith next
>>Kill Bonebeak Vultures, Brine Beetles, Saltspine Krolusks, and Krolusk Dunemites
.complete 50755,1 
step
.goto 864,57.41,40.62
>>Talk to Jorana's corpse
.complete 47317,2 
step
.goto 864,58.24,40.61,40,0
.goto 864,59.15,42.98,40,0
.goto 864,55.19,43.43,40,0
.goto 864,58.24,40.61,40,0
.goto 864,59.15,42.98,40,0
.goto 864,55.19,43.43
>>Kill Bonebeak Vultures, Brine Beetles, Saltspine Krolusks, and Krolusk Dunemites
.complete 50755,1 
step
>>Talk to Mekaru and Neri
.turnin 50755 >>Turn in A Meal for Birds
.goto 864,54.75,42.40
.turnin 47322 >>Turn in Aided Escape
.goto 864,54.69,42.49
step
.goto 864,56.33,43.90
>>Loot the page on the ground
.complete 47316,1 
step
>>Talk to Kiro, Kaja, and Merrah
.turnin 47321 >>Turn in Knickknack Takeback
.goto 864,56.79,50.54
.turnin 47316 >>Turn in Secrets in the Sand
.turnin 47317 >>Turn in Searching for Survivors
.accept 47959 >>Accept The Warguard's Trail
.goto 864,56.83,50.52
.complete 47959,1 
.goto 864,56.76,50.53
.skipgossip
.timer 59,The Warguard's Trail RP
step
.goto 864,53.42,65.89
>>Wait out the RP
.complete 47959,2 
step
.goto 864,52.97,66.53
>>Talk to Jorak
.turnin 47959 >>Turn in The Warguard's Trail
.accept 48549 >>Accept Grozztok the Blackheart
.accept 48550 >>Accept Stolen Satchels
step
.goto 864,53.87,69.40
>>Talk to Ranah
.accept 48551 >>Accept Wither Without Water
.accept 48553 >>Accept Let it Flow
.accept 48555 >>Accept We Can Salvage the Seeds
step
#completewith next
>>Kill Carnivorous Thistlevines. Loot them for their Seeds
.collect 152644,8,48555,1 
step
.goto 864,52.90,71.96
>>Click the Fountain to fix it
.complete 48553,2 
step
.goto 864,53.18,68.42,40,0
.goto 864,52.48,68.74,40,0
.goto 864,52.95,71.13,40,0
.goto 864,53.18,68.42,40,0
.goto 864,52.48,68.74,40,0
.goto 864,52.95,71.13
>>Use |T607527:0|t[Ranah's Watering Can] on the Withered Thistlevines
>>Kill Carnivorous Thistlevines. Loot them for their Seeds
>>Click the Fertile Soil on the ground to plant the Seeds
.complete 48551,1 
.collect 152644,8,48555,0x1,-1 
.complete 48555,1 
.use 152630
step
.goto 864,53.46,67.65
>>Click the Fountain to fix it
.complete 48553,1 
step
>>Use |T607527:0|t[Ranah's Watering Can] on the Withered Thistlevines
.complete 48551,1 
.use 152630
step
.goto 864,53.87,69.40
>>Talk to Ranah
.turnin 48555 >>Turn in We Can Salvage the Seeds
.turnin 48551 >>Turn in Wither Without Water
.turnin 48553 >>Turn in Let it Flow
.accept 48554 >>Accept The Source of the Problem
step
#completewith next
.goto 864,53.89,68.29,20,0
.goto 864,54.36,66.88,20,0
.goto 864,54.96,67.26,20 >> Travel up the mountain path
step
#completewith next
.goto 864,55.38,69.37
>>Click the Loose Boulder in the water to summon the Water Cobra
.complete 48554,1 
step
.goto 864,55.38,69.37
>>Kill the Water Cobra
.complete 48554,2 
step
#completewith next
.goto 864,53.87,69.40,40 >> Drop down the mountain toward Ranah
step
.goto 864,53.87,69.40
>>Talk to Ranah
.turnin 48554 >>Turn in The Source of the Problem
step
#completewith next
>>Kill Sandfury Assassins. Loot them for their Satchels
.complete 48550,1 
step
.goto 864,49.18,64.73
>>Wait out the RP that happens when you get close
>>Kill Grozztok the Blackheart
.complete 48549,1 
step
.goto 864,49.18,66.16,40,0
.goto 864,48.82,66.44,40,0
.goto 864,48.26,67.22,40,0
.goto 864,49.87,66.41,40,0
.goto 864,50.64,65.02
>>Kill Sandfury Assassins. Loot them for their Satchels
.complete 48550,1 
step
>>Talk to Jorek, Kaja, and Meerah
.turnin 48550 >>Turn in Stolen Satchels
.goto 864,53.34,66.00
.turnin 48549 >>Turn in Grozztok the Blackheart
.accept 48684 >>Accept On the Move
.goto 864,53.19,66.06
.complete 48684,1 
.goto 864,53.22,66.04
.skipgossip
.timer 122,On the Move RP
step
.goto 864,52.80,89.17
>>Wait out the RP
.complete 48684,2 
step
.goto 864,52.83,89.23
>>Talk to Jorak
.turnin 48684 >>Turn in On the Move
.accept 48895 >>Accept The Perfect Offering
step
.goto 864,53.18,90.30
>>Talk to Akunda the Exalted
.turnin 48895 >>Turn in The Perfect Offering
.accept 48991 >>Accept Vile Infestation
.accept 48992 >>Accept Sacred Remains
.accept 48993 >>Accept Powerful Conductors
step
#completewith next
.goto 864,53.72,89.17
.fp Temple of Akunda >>Get the Temple of Akunda Flight Path
step
#completewith SacredR
>>Kill Ranishu Gorgers
.complete 48991,1 
step
.goto 864,54.08,88.73
>>Loot the bone on the ground
.complete 48992,1,1 
step
.goto 864,54.16,88.15
>>Loot the bone on the ground
.complete 48992,1,2 
step
.goto 864,54.71,87.83
>>Loot the bone on the ground
.complete 48992,1,3 
step
.goto 864,54.99,87.82
>>Loot the bone on the ground
.complete 48992,1,4 
step
.goto 864,55.09,86.20,20 >> Go inside Redrock Cavern
.isOnQuest 48992
step
.goto 864,55.92,84.89
>>Loot the bone on the ground
.complete 48992,1,5 
step
.goto 864,56.12,83.46
>>Kill Rorgog. Loot him for his Antennae
.complete 48993,1 
step
#label SacredR
.goto 864,55.46,84.49
>>Loot the bone on the ground
.complete 48992,1 
step
.goto 864,54.52,84.69,40,0
.goto 864,53.21,86.68,40,0
.goto 864,54.08,88.73,40,0
.goto 864,54.99,87.82,40,0
.goto 864,54.52,84.69,40,0
.goto 864,53.21,86.68,40,0
.goto 864,54.08,88.73,40,0
.goto 864,54.99,87.82
>>Kill Ranishu Gorgers
.complete 48991,1 
step
.goto 864,53.18,90.30
>>Talk to Akunda the Exalted
.turnin 48991 >>Turn in Vile Infestation
.turnin 48992 >>Turn in Sacred Remains
.turnin 48993 >>Turn in Powerful Conductors
.accept 48887 >>Accept Cleanse the Mind
.accept 48888 >>Accept It Springs Eternal
step
.goto 864,52.83,89.23
>>Talk to Jorak
.accept 49040 >>Accept Fond Farewells
step
#completewith InnerD
>>Kill Redrock Scavengers or Howlers
.complete 48888,1 
step
#completewith next
.goto 864,52.17,83.75,20 >> Go into the cave
step
#label InnerD
>>Click the Shrine of Thunder. Kill the Inner Demon that spawns
.complete 48887,1 
.goto 864,52.17,83.34
.complete 48887,2 
.goto 864,52.14,83.39
step
.goto 864,51.01,83.83,40,0
.goto 864,51.65,84.34,40,0
.goto 864,50.82,85.65,40,0
.goto 864,52.29,85.60,40,0
.goto 864,51.01,83.83,40,0
.goto 864,51.65,84.34,40,0
.goto 864,50.82,85.65,40,0
.goto 864,52.29,85.60
>>Kill Redrock Scavengers or Howlers
.complete 48888,1 
step
#completewith next
.goto 864,52.22,89.73,20,0
.goto 864,51.98,89.81
.home >>Set your Hearthstone to Temple of Akunda
step
>>Talk to Akunda the Exalted and Kaja
.turnin 48887 >>Turn in Cleanse the Mind
.turnin 48888 >>Turn in It Springs Eternal
.accept 48894 >>Accept Trial of Truth
.complete 48894,1 
.turnin 48894 >>Turn in Trial of Truth
.goto 864,53.18,90.30
.accept 48715 >>Accept Akunda Awaits
.goto 864,53.16,90.21
.skipgossip 127992,1
step
#completewith next
.goto 864,53.58,91.66
>>Go inside the Temple
.complete 48715,1 
.timer 12,Akunda Awaits RP
step
>>Wait for the RP. Talk to Kaja and Akunda the Sensible
.turnin 48715 >>Turn in Akunda Awaits
.goto 864,53.58,91.66
.accept 48987 >>Accept Valley of Sorrows
.goto 864,53.58,91.34
step
.goto 864,53.01,78.77
>>Travel to the Valley of Sorrows. Talk to Meijani
.turnin 48987 >>Turn in Valley of Sorrows
.accept 48988 >>Accept Memory Breach
.accept 49005 >>Accept Shattered and Broken
step
#completewith UnwantedM
>>Kill Distorted and Fractured Memories
.complete 49005,1 
.complete 49005,2 
step
.goto 864,53.44,78.22
>>Loot the Unwanted Memory on the ground. Press "Escape" on your keyboard to skip the cinematic
.complete 48988,1,1 
step
.goto 864,54.91,76.01
>>Loot the Unwanted Memory on the ground. Press "Escape" on your keyboard to skip the cinematic
.complete 48988,1,2 
step
.goto 864,54.80,75.40
>>Loot the Unwanted Memory on the ground. Press "Escape" on your keyboard to skip the cinematic
.complete 48988,1,3 
step
.goto 864,54.57,75.45
>>Loot the Unwanted Memory on the ground. Press "Escape" on your keyboard to skip the cinematic
.complete 48988,1,4 
step
.goto 864,53.15,77.46
>>Loot the Unwanted Memory on the ground. Press "Escape" on your keyboard to skip the cinematic
.complete 48988,1,5 
step
.goto 864,52.65,76.40
>>Loot the Unwanted Memory on the ground. Press "Escape" on your keyboard to skip the cinematic
.complete 48988,1,6 
step
.goto 864,52.78,77.66
>>Loot the Unwanted Memory on the ground. Press "Escape" on your keyboard to skip the cinematic
.complete 48988,1,7 
step
#label UnwantedM
.goto 864,52.85,78.05
>>Loot the Unwanted Memory on the ground. Press "Escape" on your keyboard to skip the cinematic
.complete 48988,1 
step
.loop 40,864,53.44,78.22,54.91,76.01,54.80,75.40,54.57,75.45,53.15,77.46,52.65,76.40,52.78,77.66,52.85,78.05,53.44,78.22
>>Kill Distorted and Fractured Memories
.complete 49005,1 
.complete 49005,2 
step
.goto 864,53.01,78.77
>>Talk to Meijani
.turnin 48988 >>Turn in Memory Breach
.turnin 49005 >>Turn in Shattered and Broken
.accept 48889 >>Accept Repairing the Past
.timer 31,Repairing the Past RP
step
.goto 864,52.34,79.68
>>Follow Meijani into the cave. Kill Memories that spawn
.complete 48889,1 
step
.goto 864,52.19,79.94
>>Talk to Akunda
.turnin 48889 >>Turn in Repairing the Past
.accept 48996 >>Accept Ending the Madness
step
#completewith next
.hs >>Hearth to the Temple of Akunda
step
.goto 864,53.17,89.96,30,0
.goto 864,53.19,91.25
>>Kill Akunda the Exalted. Use the Extra Action Button to deal damage and increase your damage dealt. Press "Escape" on your keyboard to skip the cinematic
.complete 48996,1 
step
.goto 864,53.18,91.65
>>Talk to Akunda
.turnin 48996 >>Turn in Ending the Madness
.accept 50913 >>Accept Akunda's Blessing
step
.goto 864,53.18,92.14
>>Click the Altar of Akunda
.complete 50913,1 
step
>>Talk to Akunda and Rakera
.turnin 50913 >>Turn in Akunda's Blessing
.goto 864,53.18,91.65
.accept 47874 >>Accept Clearing the Fog
.goto 864,53.61,91.66
.timer 45,Clearing the Fog RP
step
>>Wait out the RP. Talk to Rakera and Meerah
.turnin 47874 >>Turn in Clearing the Fog
.accept 48896 >>Accept Knowledge of the Past
.goto 864,52.81,89.24
.complete 48896,1 
.goto 864,52.70,89.29
.skipgossip
.timer 52,Knowledge of the Past RP
step
.goto 864,47.86,82.29
>>Wait out the RP
.complete 48896,2 
step
.goto 864,47.60,81.81
>>Kill Sandfury Assassins
.complete 48896,3 
step
.goto 864,47.60,81.81
>>Talk to Rakera
.turnin 48896 >>Turn in Knowledge of the Past
.accept 47716 >>Accept Searching the Ruins
step
.goto 864,46.63,76.11,30,0
.goto 864,47.07,75.66
>>Go into the cave
.complete 47716,1 
.timer 18,Searching the Ruins RP
step
>>Wait out the RP. Talk to Julwaba and Kiro
.turnin 47716 >>Turn in Searching the Ruins
.goto 864,47.07,75.66
.accept 48313 >>Accept Nature's Remedy
.accept 48314 >>Accept Creeping Death
.goto 864,47.05,75.60
step
#completewith PlumC
>>Kill Scorpashi Venomtails and Scorpashi Direclaws. Loot them for their Singers
.complete 48314,1 
step
.goto 864,46.25,76.25
>>Loot the Prickly Plum Cactus on the ground
.complete 48313,1,1 
step
.goto 864,45.62,76.94
>>Loot the Prickly Plum Cactus on the ground
.complete 48313,1,2 
step << skip
.goto 864,43.90,75.92
.fp Scorched Sands Outpost >> Get the Scorched Sands Outpost flight path
step
.goto 864,43.39,75.37
>>Talk to Razgaji
.accept 51573 >>Accept I've Got Your Back
.complete 51573,1 
.skipgossip 126576,1
.timer 74,I've Got Your Back RP
step
#sticky
#label RazgajiE
.goto 864,43.39,75.37,0
>>DON'T escort Razgaji. This quest will automatically complete
.complete 51573,2 

step
.goto 864,45.62,74.71
>>Loot the Prickly Plum Cactus on the ground
.complete 48313,1,3 
step
#label PlumC
.goto 864,45.61,73.52
>>Loot the Prickly Plum Cactus on the ground
.complete 48313,1,4 
step
.goto 864,45.63,70.19,50,0
.goto 864,46.67,69.19,50,0
.goto 864,48.01,70.06,50,0
.goto 864,47.06,71.36,50,0
.goto 864,46.11,72.21,50,0
.goto 864,45.96,76.98,50,0
.goto 864,45.63,70.19,50,0
.goto 864,46.67,69.19,50,0
.goto 864,48.01,70.06,50,0
.goto 864,47.06,71.36,50,0
.goto 864,46.11,72.21,50,0
.goto 864,45.96,76.98
>>Kill Scorpashi Venomtails and Scorpashi Direclaws. Loot them for their Singers
.complete 48314,1 
step
.goto 864,46.37,73.16
>>Loot the Prickly Plum Cactus on the ground
.complete 48313,1,5 
step
.goto 864,46.44,73.53
>>Loot the Prickly Plum Cactus on the ground
.complete 48313,1 
step
>>Talk to Kiro
.goto 864,47.06,75.60
.turnin 48313 >>Turn in Nature's Remedy
.turnin 48314 >>Turn in Creeping Death
.accept 50770 >>Accept Effective Antivenom
step
.goto 864,47.06,75.71
>>Use the |T967559:0|t[Antivenom] on Serrik
.complete 50770,1 
.timer 6,Effective Antivenom RP
.use 158678
step
.goto 864,47.06,75.71
>>Wait out the RP. Talk to Serrik
.turnin 50770 >>Turn in Effective Antivenom
.accept 50539 >>Accept The Secrets of Zul'Ahjin
step
.goto 864,46.56,75.08,20,0
.goto 864,46.87,74.07,20,0
.goto 864,47.14,75.12,20,0
.goto 864,47.32,72.73
>>Exit the cave. Take the stairs up and then go inside the northern building
>>Talk to Maaz
.accept 50536 >>Accept Magic Decoder Device
step
.goto 864,47.36,72.66
>>Click the Scepter
.complete 50536,1 
step
#completewith CrumblingS
.goto 864,47.36,72.66,0
+If you lose your Serpent Form, return to the scepter and click it again. You may NOT mount in this form << !Druid !Shaman
+If you lose your Serpent Form, return to the scepter and click it again. You may NOT mount or shapeshift in this form << Druid
+If you lose your Serpent Form, return to the scepter and click it again. You may NOT mount or Ghost Wolf in this form << Shaman
step
.goto 864,48.30,74.49,30,0
.goto 864,48.05,74.96
>>Talk to the Statue under the overhang
.complete 50536,2 
step
.goto 864,48.89,76.32
>>Talk to the Statue under the overhang
.complete 50536,3 
step
.goto 864,48.90,74.51
>>Talk to the Crumbling Statue
.turnin 50539 >>Turn in The Secrets of Zul'Ahjin
.accept 48315 >>Accept Hollow, Empty Eyes
step
.goto 864,49.85,73.19
>>Loot the Sapphire on the ground
.complete 48315,1,1 
step
#completewith next
.goto 864,50.67,73.73,12 >>Go up along the side of the wall
step
.goto 864,51.05,72.35
>>Loot the Sapphire on the ground
.complete 48315,1 
step
.goto 864,50.85,73.94,30,0
.goto 864,49.75,75.67
.goto 864,49.76,76.74
>>Talk to Jethek. He patrols along the path
.accept 50596 >>Accept Exterminate the Vermin
step
.goto 864,50.21,75.36
>>Click the Shackles to free the Excavator
.complete 50596,1,1 
step
.goto 864,49.49,74.97,15,0
.goto 864,49.73,74.98
>>Drop down. Talk to the Statue under the overhang
.complete 50536,4 
step
.goto 864,49.54,77.56
>>Click the Shackles to free the Excavator
.complete 50596,1,2 
step
.goto 864,48.67,77.59
>>Click the Shackles to free the Excavator
.complete 50596,1 
step
#label CrumblingS
.goto 864,48.90,74.51
>>Talk to the Crumbling Statue
.turnin 48315 >>Turn in Hollow, Empty Eyes
step
>>You no longer have to stay in Serpent form
>>Talk to Maaz and Amre
.turnin 50536 >>Turn in Magic Decoder Device
.accept 48871 >>Accept Rescue the Relics
.goto 864,47.32,72.73
.turnin 50596 >>Turn in Exterminate the Vermin
.accept 48872 >>Accept Expedite the Excavation
.goto 864,47.40,72.74,3,0
.goto 864,47.44,72.61,3,0
.goto 864,47.24,72.67,3,0
.goto 864,47.40,72.74,3,0
.goto 864,47.44,72.61,3,0
.goto 864,47.24,72.67
step
#completewith RelicSix
>>Kill Sethrak Site Guardians and Relic Hunters
.complete 48872,1 
step
.goto 864,47.96,73.15
>>Loot the Relic on the ground
.complete 48871,1,1 
step
.goto 864,48.61,74.16
>>Loot the Relic on the ground
.complete 48871,1,2 
step
.goto 864,48.90,74.24
>>Talk to the Ancient Reliquary
.accept 50561 >>Accept Sulthis' Stone
step
.goto 864,49.01,74.59
>>Loot the Relic on the ground
.complete 48871,1,3 
step
.goto 864,49.10,73.51
>>Loot the Relic on the ground
.complete 48871,1,4 
step
.goto 864,49.59,73.48
>>Loot the Relic on the ground
.complete 48871,1,5 
step
#label RelicSix
.goto 864,50.39,74.11,10,0
.goto 864,50.13,75.47
>>Loot the Relic on the ground
.complete 48871,1,6 
step
.goto 864,50.17,75.90,30,0
.goto 864,50.13,76.80
>>Kill Sethrak Site Guardians and Relic Hunters
.complete 48872,1,8 
step
#completewith RelicKeep
>>Kill Sethrak Site Guardians and Relic Hunters
.complete 48872,1 
step
.goto 864,49.20,76.05
>>Loot the Relic on the ground
.complete 48871,1,7 
step
#label RelicKeep
.goto 864,48.24,75.15
>>Loot the Relic on the ground
.complete 48871,1 
step
.goto 864,48.32,77.02,20,0
.goto 864,47.57,75.69
>>Kill Sethrak Site Guardians and Relic Hunters
.complete 48872,1 
step
>>Talk to Amre and Maaz
.turnin 48872 >>Turn in Expedite the Excavation
.goto 864,47.40,72.74,3,0
.goto 864,47.44,72.61,3,0
.goto 864,47.24,72.67,3,0
.goto 864,47.40,72.74,3,0
.goto 864,47.44,72.61,3,0
.goto 864,47.24,72.67
.turnin 48871 >>Turn in Rescue the Relics
.accept 50535 >>Accept Power of the Overseer
.goto 864,47.32,72.73
step
.goto 864,48.34,76.89,10,0
.goto 864,48.83,76.75
>>Kill Overseer Nerzet ABOVE the overhang. Loot her for her Shard
.complete 50535,1 
step
.goto 864,47.32,72.73
>>Talk to Maaz
.turnin 50535 >>Turn in Power of the Overseer
step
>>Jump down and go under the overhang. Talk to Serrik
.goto 864,46.61,75.72,20,0
.goto 864,47.06,75.71
.turnin 50561 >>Turn in Sulthis' Stone
.accept 47324 >>Accept Unlikely Allies
step
.goto 864,43.39,75.37
>>Talk to Razgaji
.accept 51573 >>Accept I've Got Your Back
.complete 51573,1 
.skipgossip 126576,1
.timer 74,I've Got Your Back RP
step
.goto 864,43.39,75.37,15,0
.goto 864,43.40,73.84
>>Talk to Razgaji again. Escort him
.complete 51573,2 

step
>>Talk to Razgaji, Sezahjin, and Mugjabu
.turnin 51573 >>Turn in I've Got Your Back
.accept 48529 >>Accept Hungry Mouths To Feed
.accept 48530 >>Accept I Heard You Lost the Herd
.goto 864,43.39,75.37
.turnin 48529 >>Turn in Hungry Mouths To Feed
.accept 48531 >>Accept Mystery Meat
.accept 48533 >>Accept Vol'duni Fried Chicken
.goto 864,43.70,76.78
.turnin 48530 >>Turn in I Heard You Lost the Herd
.accept 48532 >>Accept Alpacas Gone Wild
.goto 864,42.13,76.20
step
.goto 864,42.50,75.55,40,0
.goto 864,42.50,72.24,40,0
.goto 864,44.27,72.25,40,0
.goto 864,44.28,75.55,40,0
.goto 864,42.50,75.55,40,0
.goto 864,42.50,72.24,40,0
.goto 864,44.27,72.25,40,0
.goto 864,44.28,75.55
>>Use |T135491:0|t[Sezahjin's Trusty Vulture Bow] on Fattened Buzzards. Kill them. Loot them for Roasted Buzzard
.complete 48533,1 
.use 152572
step
#completewith ScaSupplies
>>Kill Vol'duni Dunecrawlers. Loot them for their Innards
>>Use the |T132161:0|t[Alpaca Whistle] near Alpacas. Attack them if they turn hostile
.complete 48531,1 
.complete 48532,1 
.use 152570
step
.goto 864,40.43,73.63
>>Talk to the Backpack on the ground
.accept 48585 >>Accept Wasteland Survivor
step
.goto 864,40.17,74.07
>>Loot the small pouch on the ground
.complete 48585,1,1 
step
.goto 864,40.33,74.90
>>Loot the small pouch on the ground
.complete 48585,1,2 
step
.goto 864,39.27,74.83
>>Loot the backpack on the ground
.complete 48585,1,3 
step
.goto 864,39.00,75.20
>>Loot the small pouch on the ground
.complete 48585,1,4 
step
.goto 864,38.43,74.65
>>Loot the backpack on the ground
.complete 48585,1,5 
step
.goto 864,37.97,74.62
>>Loot the backpack on the ground
.complete 48585,1,6 
step
.goto 864,37.75,72.27
>>Loot the small pouch on the ground
.complete 48585,1,7 
step
.goto 864,38.52,71.68
>>Loot the small pouch on the ground
.complete 48585,1,8 
step
.goto 864,39.27,72.39
>>Loot the small pouch on the ground
.complete 48585,1,9 
step
#label ScaSupplies
.goto 864,40.46,72.92
>>Loot the backpack on the ground
.complete 48585,1 
step
.goto 864,40.67,72.53,45,0
.goto 864,39.14,72.39,45,0
.goto 864,38.78,73.20,45,0
.goto 864,37.16,72.34,45,0
.goto 864,38.63,70.05,45,0
.goto 864,38.68,72.40,45,0
.goto 864,40.67,72.53,45,0
.goto 864,39.14,72.39,45,0
.goto 864,38.78,73.20,45,0
.goto 864,37.16,72.34,45,0
.goto 864,38.63,70.05,45,0
.goto 864,38.68,72.40
>>Kill Vol'duni Dunecrawlers. Loot them for their Innards
>>Use the |T132161:0|t[Alpaca Whistle] near Alpacas. You can use this whilst mounted. Ignore them if they turn hostile
.complete 48531,1 
.complete 48532,1 
.use 152570
step
.goto 864,43.39,75.37
>>Talk to Razgaji
.turnin 48585 >>Turn in Wasteland Survivor
step
#completewith Junji
.goto 864,43.05,76.46
.home >>Set your Hearthstone to the Scorched Sands Outpost
step
>>Talk to Sezahjin and Mugjabu
.turnin 48531 >>Turn in Mystery Meat
.turnin 48533 >>Turn in Vol'duni Fried Chicken
.accept 48655 >>Accept The Chef's Apprentice
.goto 864,43.70,76.78
.turnin 48532 >>Turn in Alpacas Gone Wild
.accept 48534 >>Accept Snarltooth's Last Laugh
.goto 864,42.13,76.20
step
#completewith next
.goto 864,43.40,79.29,15 >> Jump down toward Junji
step
#label Junji
>>Talk to Junji. DON'T kill the two Saurolisks in front of him
.goto 864,43.39,78.63
.turnin 48655 >>Turn in The Chef's Apprentice
.accept 48656 >>Accept Savage Saurolisks
.accept 48657 >>Accept They Might Be Delicious
step
#completewith SauroliskEgg
>>Kill Scaleclaw Saurolisks
.complete 48656,1 
step << skip
.goto 864,44.54,79.98
.complete 48657,1,2 
step
.goto 864,44.76,80.86
>>Loot the Eggs on the ground. Do NOT aggro the Broodmother
.complete 48657,1,2 
step
.goto 864,44.49,81.79
>>Loot the Eggs on the ground
.complete 48657,1,5 
step
#completewith next
.goto 864,43.49,82.86,15 >>Enter the cave
step
.goto 864,42.82,84.33
>>Kill Snarltooth. Loot him for his Head
.complete 48534,1 
step
.goto 864,42.70,81.99
>>Loot the Eggs on the ground
.complete 48657,1,8 
step
#label SauroliskEgg
.goto 864,42.33,82.06
>>Loot the Eggs on the ground
.complete 48657,1 
step
.goto 864,41.46,81.49,40,0
.goto 864,42.24,79.96,40,0
.goto 864,44.76,80.86,40,0
.goto 864,42.33,82.06,40,0
.goto 864,41.46,81.49,40,0
.goto 864,42.24,79.96,40,0
.goto 864,44.76,80.86,40,0
.goto 864,42.33,82.06
>>Kill Scaleclaw Saurolisks
.complete 48656,1 
step
.goto 864,43.39,78.63
>>Talk to Junji
.turnin 48656 >>Turn in Savage Saurolisks
.turnin 48657 >>Turn in They Might Be Delicious
step
#completewith next
.goto 864,45.09,83.15,20,0
.goto 864,45.54,83.11,15 >>Take the path up to Randall
step
.goto 864,45.65,82.32
>>Talk to Randall
.accept 47870 >>Accept Dead Men Tell No Tales
.accept 47871 >>Accept Seafaring Necessities
step
#completewith next
.goto 864,45.92,84.62,40,0
.goto 864,47.22,86.20,40,0
.goto 864,47.62,86.12,40 >>Ride past all of the Enforcers and Laborers/don't stop to attack them if possible
step
.goto 864,47.62,86.12
>>Talk to Keerin
.accept 47939 >>Accept If the Key Fits...
step
#completewith Perry
>>Kill Ashvane Enforcers, Prospectors, and Redrock Laborers. Loot them for their Keys and Garb
.complete 47939,1 
.collect 160735,5,49261,1 
step
#sticky
#label NautMap
.goto 864,47.97,87.05,0,0
>>Loot the Map on the table
.complete 47871,2 
step
.goto 864,48.08,86.90
>>Kill Boatswain Hendricks. Drag him out of his Smokebomb when he casts it
.complete 47870,2 
step
#sticky
#requires NautMap
#label WeaSpyglass
.goto 864,46.72,87.29,0,0
>>Loot the Spyglass on the table
.complete 47871,3 
step
#label Perry
#requires NautMap
>>Kill First Mate Perry and Gunner Erikson. Drag them out of their Smokebombs when they cast it
.complete 47870,3 
.goto 864,46.89,87.93
.complete 47870,1 
.goto 864,46.73,87.35
step
#requires WeaSpyglass
.goto 864,47.62,86.12
>>Talk to Keerin
.turnin 47939 >>Turn in If the Key Fits...
.isQuestComplete 47939
step
#requires WeaSpyglass
#completewith next
>>Kill Expedition Leader Augustus. Loot him for his Seafaring Hat
.goto 864,46.18,86.46
.complete 47871,1 
step
#requires WeaSpyglass
.loop 40,864,47.96,87.70,48.34,87.30,47.96,86.55,47.32,86.06,46.16,85.20,46.66,86.50,47.08,86.99,47.96,87.70
>>Kill Ashvane Enforcers, Prospectors, and Redrock Laborers. Loot them for their Keys and Garb
.complete 47939,1 
.collect 160735,5,49261,1 
step
.goto 864,47.62,86.12
>>Talk to Keerin
.turnin 47939 >>Turn in If the Key Fits...
step
>>Kill Expedition Leader Augustus. Loot him for his Seafaring Hat
.goto 864,46.18,86.46
.complete 47871,1 
step
.goto 864,44.65,86.99
>>Talk to Randall
.turnin 47870 >>Turn in Dead Men Tell No Tales
.turnin 47871 >>Turn in Seafaring Necessities
.accept 51810 >>Accept Captain Hartford
step
#completewith next
.collect 160735,5,49261,1 
step
#completewith next
.goto 864,44.65,86.99
.cast 247648 >>Use the Ashvane Garb to become disguised for 5 minutes
.timer 300,Ashvane Disguise Timer
.use 160735
step
.goto 864,44.60,88.23
>>Talk to Dockmaster Herrington whilst disguised
.accept 49261 >>Accept Crabby Crew Stew
step
#completewith Herrington
+Avoid Ashvane Overseers as they can remove your disguise
+If your disguise falls off, kill Ashvanes and Shady Deckhands. Loot them for their Garb. Reapply it when you have 5
.use 160735

step
#completewith CapCache
>>Kill Sand Scuttlers. Loot them for their Meat
.complete 49261,1 
step
.goto 864,44.29,90.45,20,0
.goto 864,43.21,90.13,15,0
.goto 864,43.13,90.83
>>Kill Captain Hartford on the top of the ship
.complete 51810,1 
step
#label CapCache
.goto 864,43.30,90.74,8,0
>>Go down one floor, then go inside the ship. Talk to Captain Redmond and the lockbox
.turnin 51810 >>Turn in Captain Hartford
.accept 47873 >>Accept The Captain's Cache
.goto 864,43.20,90.90
.turnin 47873 >>Turn in The Captain's Cache
.goto 864,43.20,90.76
step
.goto 864,44.10,90.54,40,0
.goto 864,44.54,88.84,40,0
.goto 864,42.22,86.42,40,0
.goto 864,44.10,90.54,40,0
.goto 864,44.54,88.84,40,0
.goto 864,42.22,86.42
>>Kill Sand Scuttlers. Loot them for their Meat
.complete 49261,1 
step
#label Herrington
.goto 864,44.60,88.23
>>Talk to Dockmaster Herrington whilst disguised
.turnin 49261 >>Turn in Crabby Crew Stew
step
#completewith next
.hs >>Hearth to Scorched Sands Outpost
step
>>Talk to Mugjabu and Zauljin
.turnin 48534 >>Turn in Snarltooth's Last Laugh
.goto 864,42.13,76.20
.accept 48846 >>Accept Liquid Motivation
.goto 864,43.23,76.96
step
.goto 864,42.86,76.31
>>Talk to Taz'jin. Buy a Zanchuli Reserve from him
.complete 48846,1 

step
.goto 864,43.23,76.96
>>Talk to Zauljin
.complete 48846,2 
.skipgossip
step
.goto 864,43.39,75.37
>>Talk to Razgaji
.turnin 48846 >>Turn in Liquid Motivation
.accept 48790 >>Accept Stolen Goods
.accept 48850 >>Accept Tongo
.accept 51602 >>Accept Bandit Blades
step
#completewith Tongo
>>Kill Zandalari Exiles. Loot them for their Blades. You can also loot the Blades on the ground
.complete 51602,1 
step
.goto 864,40.73,74.66,10,0
.goto 864,40.63,74.50
>>Go inside the building. Loot the Hides on your left on the ground
.complete 48790,1,1 
step
.goto 864,40.88,74.37
>>Loot the Box and Pot on the table
.complete 48790,1,3 
step
.goto 864,40.34,75.28,10,0
.goto 864,40.11,75.37,8,0
.goto 864,40.04,75.19,8,0
.goto 864,40.11,75.37,-1
.goto 864,40.04,75.19,-1
>>Go inside the cave building. Loot the Pouch and Basket on the ground
.complete 48790,1,5 
step
.goto 864,40.45,75.27,5,0
.goto 864,40.04,75.62
>>Loot the Waterskin on the barrel outside
.complete 48790,1 
step
#label Tongo
.goto 864,40.84,76.03
>>Kill Tongo. Loot him for his Head. This quest is difficult. Kill Snarl and Gnarl before if you feel weak and want to be safe
.complete 48850,1 
step
.goto 864,40.99,74.61,40,0
.goto 864,41.04,73.43,40,0
.goto 864,39.72,75.41,40,0
.goto 864,39.99,76.36,40,0
.goto 864,40.99,74.61,40,0
.goto 864,41.04,73.43,40,0
.goto 864,39.72,75.41,40,0
.goto 864,39.99,76.36
>>Kill Zandalari Exiles. Loot them for their Blades. You can also loot the Blades on the ground
.complete 51602,1 
step
.goto 864,43.39,75.37
>>Talk to Razgaji
.turnin 48790 >>Turn in Stolen Goods
.turnin 48850 >>Turn in Tongo
.turnin 51602 >>Turn in Bandit Blades
.accept 48847 >>Accept Arming the Tribe
step
.goto 864,42.87,76.08
>>Talk to the Scorched Sands Outcast
.complete 48847,1,1 
.skipgossip
step
.goto 864,42.86,76.58
>>Talk to the Scorched Sands Outcast
.complete 48847,1,2 
.skipgossip
step
.goto 864,43.61,76.98
>>Talk to the Scorched Sands Outcast
.complete 48847,1,3 
.skipgossip
step
.goto 864,43.82,77.84
>>Talk to the Scorched Sands Outcast
.complete 48847,1,4 
.skipgossip
step
.goto 864,42.97,77.84
>>Talk to the Scorched Sands Outcast
.complete 48847,1,5 
.skipgossip
step
.goto 864,42.56,76.67
>>Talk to the Scorched Sands Outcast
.complete 48847,1,6 
.skipgossip
step
.goto 864,42.52,76.35
>>Talk to the Scorched Sands Outcast
.complete 48847,1,7 
.skipgossip
step
.goto 864,42.14,76.00
>>Talk to the Scorched Sands Outcast
.complete 48847,1 
.skipgossip
step
.goto 864,43.39,75.37
>>Talk to Razgaji
.turnin 48847 >>Turn in Arming the Tribe
.accept 51668 >>Accept Mojambo
step
.goto 864,43.40,73.86
>>Use |T1405809:0|t[Tongo's Head] on Mojambo
.complete 51668,1 
.use 160525
step
>>Talk to Razgaji, Sezahjin, the Wanted Poster, and Mugjabu
.turnin 51668 >>Turn in Mojambo
.goto 864,43.39,75.37
.accept 51772 >>Accept The Tortaka Tribe
.goto 864,43.70,76.78
.accept 51161 >>Accept WANTED: Za'roco
.goto 864,43.12,76.57
.accept 51775 >>Accept Camp Lastwind
.goto 864,42.13,76.20
step
>>Talk to Norah and the Wanted Poster
.turnin 51775 >>Turn in Camp Lastwind
.accept 48324 >>Accept Lost in Zem'lan
.goto 864,38.88,77.32
.accept 51162 >>Accept WANTED: Taz'raka the Traitor
.goto 864,38.86,76.96
step
>>Talk to Meeki's corpse and Jamboya
.turnin 48324 >>Turn in Lost in Zem'lan
.goto 864,35.46,83.47
.accept 51053 >>Accept The Day the Port Fell
.goto 864,35.44,83.82
step
.goto 864,34.32,85.18
>>Use |T1121020:0|t[First Mate Jamboya's Medallion] near the dead trolls
.complete 51053,1 
.use 159747
step
>>Talk to Jamboya, then click him to free him
.goto 864,35.44,83.82
.turnin 51053 >>Turn in The Day the Port Fell
.accept 51054 >>Accept Overdue Mutiny
.complete 51054,1 
.timer 10,Overdue Mutiny RP
step
.goto 864,35.31,83.19
>>Wait out the RP. Talk to Jamboya
.turnin 51054 >>Turn in Overdue Mutiny
.accept 51055 >>Accept The Yard Arm of the Law
.accept 51056 >>Accept My Last Day Alive
step
#completewith PirateBoat
>>This area is difficult. Try not to pull too many mobs, and look out for the "Zem'lan Blackeye Brew" for a health regeneration buff
>>Kill Undead Trolls and their pets, Free Vulpera, and use the Pirate Maps/Hats/Grog
.complete 47647,1 
.xp >50,1

step
.goto 864,36.92,78.06
>>Go in the cave under the overhang. Click Tulmac to free him
.complete 51055,1 
step
.goto 864,35.90,78.26
>>Use |T1121020:0|t[First Mate Jamboya's Medallion] on the stairs
.complete 51056,1 
.use 159757
step
.goto 864,35.14,77.98
>>Click Bosanya to free him
.complete 51055,2 
step
>>Use |T1121020:0|t[First Mate Jamboya's Medallion] near the corpses
.goto 864,35.68,75.56
.complete 51056,2 
.use 159757
step
.goto 864,35.77,70.75,10,0
.goto 864,35.51,70.87
>>Kill Taz'raka inside the building. You can kite him around the building. Find a group for him if needed. Skip this step if you're unable to find a group or solo him.
.complete 51162,1 
step
.goto 864,34.92,76.76,20,0
.goto 864,34.64,77.14
>>Go inside the building. Click Jukanga to free him
.complete 51055,3 
step
.goto 864,36.43,81.99,20,0
.goto 864,35.31,83.19
>>Talk to Jamboya
.turnin 51055 >>Turn in The Yard Arm of the Law
.turnin 51056 >>Turn in My Last Day Alive
.accept 47499 >>Accept The Grinning Idols
.accept 51057 >>Accept Maroon 'em with Fire
step
.goto 864,35.57,82.18
>>Use the |T135432:0|t[Undying Torch] on the Canoe. You can use the torch whilst moving
.complete 51057,1,1 
.use 159774
step
.goto 864,35.51,81.50
>>Use the |T135432:0|t[Undying Torch] on the Canoe. You can use the torch whilst moving
.complete 51057,1,2 
.use 159774
step
.goto 864,35.05,80.40
>>Talk to the Treasure Map on the crate
.accept 49138 >>Accept Captain Gulnaku's Treasure
step
#completewith PirateBoat
+Use the Pirate Hat if you find one
step
>>Kill Boonzali, Da Cabin Boy, and Torwec. Loot them for their Idols
.complete 47499,1 
.goto 864,33.87,81.25
.complete 47499,2 
.goto 864,34.36,77.59
.complete 47499,3 
.goto 864,33.24,77.63,30,0
.goto 864,32.86,78.20
step << skip
.goto 864,31.82,79.36
.complete 49138,1 
step
>>Kill Captain Gulnaku. Loot him for his Key, then talk to the Chest
.complete 49138,2 
.goto 864,31.74,79.26
.turnin 49138 >>Turn in Captain Gulnaku's Treasure
.goto 864,31.78,79.31
step
.goto 864,31.55,78.97
>>Use the |T135432:0|t[Undying Torch] on the Canoe. You can use the torch whilst moving
.complete 51057,1,3 
.use 159774
step
.goto 864,32.22,80.38
>>Use the |T135432:0|t[Undying Torch] on the Canoe. You can use the torch whilst moving
.complete 51057,1,4 
.use 159774
step
.goto 864,32.61,80.40
>>Use the |T135432:0|t[Undying Torch] on the Canoe. You can use the torch whilst moving
.complete 51057,1,5 
.use 159774
step
.goto 864,32.88,79.37
>>Use the |T135432:0|t[Undying Torch] on the Canoe. You can use the torch whilst moving
.complete 51057,1,6 
.use 159774
step
.goto 864,33.27,80.17
>>Use the |T135432:0|t[Undying Torch] on the Canoe. You can use the torch whilst moving
.complete 51057,1,7 
.use 159774
step
.goto 864,32.99,81.03
>>Use the |T135432:0|t[Undying Torch] on the Canoe. You can use the torch whilst moving
.complete 51057,1 
.use 159774
step
.goto 864,33.28,81.77
>>Talk to Jamboya
.turnin 47499 >>Turn in The Grinning Idols
.turnin 51057 >>Turn in Maroon 'em with Fire
.accept 51059 >>Accept The Golden Isle
step
#label PirateBoat
.goto 864,33.25,81.85
.vehicle >>Get into the Boat
.timer 35,The Golden Isle RP
step
#completewith next
>>Wait out the RP
.complete 51059,1 
step
.goto 864,30.24,86.51
>>Talk to Jamboya
.turnin 51059 >>Turn in The Golden Isle
.accept 51060 >>Accept Our Share of the Plunder
.accept 51061 >>Accept The First Time I Died
step
>>Click the Altar, and then the Idol that appears on it
.complete 51061,1 
.goto 864,29.71,87.99
.complete 51061,2 
.goto 864,29.71,87.99
step
.goto 864,30.47,88.11,15,0
.goto 864,30.74,88.88,15,0
.goto 864,30.40,88.84,15,0
.goto 864,29.86,88.57,15,0
.goto 864,29.41,88.58,15,0
.goto 864,29.25,88.33,15,0
.goto 864,28.89,89.25,15,0
.goto 864,28.73,88.67,15,0
.goto 864,28.85,87.88,15,0
.goto 864,29.63,85.58,30,0
.goto 864,29.71,87.99,30,0
.goto 864,30.40,88.84
>>Kill the Goldslaves and Animated Treasures. Loot them for their Cursed Treasure. Additionally, loot the Cursed Treasure on the ground
.complete 51060,1 
step
.goto 864,28.57,88.69
>>Talk to Jamboya
.turnin 51060 >>Turn in Our Share of the Plunder
.turnin 51061 >>Turn in The First Time I Died
.accept 48326 >>Accept This Be Mutiny
step
.goto 864,28.57,88.69
>>Ring the Gong
.complete 48326,1 
.timer 9,This Be Mutiny RP
step
.goto 864,28.58,88.37
>>Kill Zem'lan. Let Jamboya tank him if you're squishy
.complete 48326,2 
step
.goto 864,29.38,87.42
>>Click the sand on the ground
.turnin 51137 >>Talk to the Treasure
step
.goto 864,30.24,86.51
>>Talk to Jamboya
.turnin 48326 >>Turn in This Be Mutiny
.accept 51062 >>Accept Escaping Zem'lan
step
.goto 864,30.27,86.31
.vehicle >>Get into the Boat
.timer 36,Escaping Zem'lan RP
step
#completewith EscapingZ
.goto 864,37.68,82.62
>>Wait out the RP
.complete 51062,1 
step
.goto 864,36.80,82.92,40,0
.goto 864,37.67,79.07,40,0
.goto 864,35.03,77.28,40,0
.goto 864,36.80,82.92,40,0
.goto 864,37.67,79.07,40,0
.goto 864,35.03,77.28
>>This area is difficult. Try not to pull too many mobs, and look out for the "Zem'lan Blackeye Brew" for a health regeneration buff
>>Kill Undead Trolls and their pets, Free Vulpera, and use the Pirate Maps/Hats/Grog
.complete 47647,1 
.xp >50,1
step
>>Talk to Norah
.goto 864,38.88,77.31
.turnin 51062 >>Turn in Escaping Zem'lan
.turnin 51162 >>Turn in WANTED: Taz'raka the Traitor
.accept 48327 >>Accept A Strange Delivery
.isQuestComplete 51162
step
#label EscapingZ
>>Talk to Norah
.goto 864,38.88,77.31
.turnin 51062 >>Turn in Escaping Zem'lan
.accept 48327 >>Accept A Strange Delivery
step
>>Abandon the quest to get teleported back to Seerik
.abandon 47324 >>Abandon Unlikely Allies
step
.goto 864,47.06,75.71
>>Talk to Seerik. Do NOT mount the Pterrordax after
.accept 47324 >>Accept Unlikely Allies
step
.goto 864,46.98,73.66,30,0
.goto 864,47.30,73.69
>>Do NOT mount the Pterrordax
>>Kill Za'roco the Grifter under the overhang. Try to interrupt "Mask of Fear"
.complete 51161,1 
step
#completewith next
.goto 864,43.05,60.87,20 >>Go into the cave
step
.goto 864,43.51,60.21
>>Talk to Rhan'ka
.turnin 48327 >>Turn in A Strange Delivery
.accept 47497 >>Accept Meet the Goldtusk Gang
step
>>Talk to Man'zul (the skull) and the Wanted Poster
.complete 47497,3 
.goto 864,43.64,59.93
.accept 51164 >>Accept WANTED: Cobra Excursion Participants
.goto 864,43.65,59.94
.skipgossip 4
step
>>Talk to Grenja and Volni
.complete 47497,1 
.goto 864,43.66,60.35
.complete 47497,2 
.goto 864,43.38,60.15
.skipgossip 4
step
.goto 864,43.51,60.21
>>Talk to Rhan'ka
.turnin 47497 >>Turn in Meet the Goldtusk Gang
.accept 47498 >>Accept Rhan'ka's Lost Friend
.accept 47501 >>Accept Dirty Work for Dirty Drinks
step
>>Abandon the quest to get teleported back to Seerik
.abandon 47324 >>Abandon Unlikely Allies
step
.goto 864,47.06,75.71
>>Talk to Seerik. Do NOT mount the Pterrordax after
.accept 47324 >>Accept Unlikely Allies
step
.goto 864,43.39,75.37
>>Talk to Razgaji
.turnin 51161 >>Turn in WANTED: Za'roco
.isQuestComplete 51161
step
.isQuestTurnedIn 51161
>>Abandon the quest to get teleported back to Seerik
.abandon 47324 >>Abandon Unlikely Allies
step
.goto 864,47.06,75.71
>>Talk to Seerik
.accept 47324 >>Accept Unlikely Allies
step
.goto 864,46.78,75.45
>>Mount the Pterrordax
.complete 47324,1 
.timer 43,Unlikely Allies RP
step
#completewith next
.goto 864,27.22,53.93
>>Wait out the RP
.complete 47324,2 
step
>>Talk to Serrik and Zissiah
.turnin 47324 >>Turn in Unlikely Allies
.accept 49334 >>Accept A Powerful Prisoner
.goto 864,27.22,53.93
.accept 49327 >>Accept Push Them Back!
.accept 50641 >>Accept Break Their Ranks
.goto 864,27.20,53.86
step
#completewith SpiresShat
.goto 864,28.94,53.91,40,0
>>Kill Faithless Aggressors, Ravagers, Skycallers, and Sentries
.complete 50641,1 
step
.goto 864,28.97,54.65
>>Talk to the Flute on the ground
.accept 50818 >>Accept A Lost Flute
step
.goto 864,29.05,54.95
>>Click the Spire to destroy it
.complete 49327,3,1 
step
.goto 864,30.09,54.44
>>Click the Banner to burn it
.complete 49327,1,1 
step
#label SpiresShat
.goto 864,30.35,54.98
>>Click the Spire to destroy it
.complete 49327,3 
step
.goto 864,29.52,59.35
>>Talk to Jenoh
.turnin 50818 >>Turn in A Lost Flute
.accept 50817 >>Accept A Charming Tail
.accept 50979 >>Accept Just a Nip
step
#completewith next
.goto 864,30.45,58.98,30,0
.goto 864,30.95,58.57,30,0
.goto 864,31.12,59.77,30,0
.goto 864,30.59,60.13,30,0
.goto 864,29.17,61.78,30,0
>>Kill Atrivax Lashers and Lashets. Loot them for their Gel Samples
.complete 50979,1 
step
.goto 864,28.64,62.20,30,0
.goto 864,28.59,63.58,30,0
.goto 864,27.36,63.72,30,0
.goto 864,27.56,63.07,30,0
.goto 864,28.16,62.17,30,0
.goto 864,28.64,62.20,30,0
.goto 864,28.59,63.58,30,0
.goto 864,27.36,63.72,30,0
.goto 864,27.56,63.07,30,0
.goto 864,28.16,62.17
>>Use the |T136008:0|t[Charming Flute] near Strand Cobras. it is usable whilst mounted
.complete 50817,1 
.use 158883
step
.goto 864,28.82,64.07,30,0
.goto 864,29.84,62.47,30,0
.goto 864,30.45,58.98,30,0
.goto 864,30.95,58.57,30,0
.goto 864,31.12,59.77,30,0
.goto 864,30.59,60.13
>>Kill Atrivax Lashers and Lashets. Loot them for their Gel Samples
.complete 50979,1 
step
.goto 864,29.52,59.35
>>Talk to Jenoh
.turnin 50817 >>Turn in A Charming Tail
.turnin 50979 >>Turn in Just a Nip
.accept 50980 >>Accept My Hungry Neighbor
step
.goto 864,29.17,61.78,30,0
.goto 864,27.91,61.21
>>Kill the Territorial Hydra
.complete 50980,1 
step
.goto 864,29.52,59.35
>>Talk to Jenoh
.turnin 50980 >>Turn in My Hungry Neighbor
step
#completewith Vorrik
>>Kill Faithless Aggressors, Ravagers, Skycallers, and Sentries
.complete 50641,1 
step
#completewith next
.goto 864,31.01,54.40,15,0
.goto 864,30.95,53.65,15,0
.goto 864,30.78,53.87,15 >>Travel back up to the Terrace of the Devoted
step << skip
.goto 864,30.65,54.54
>>Click the Cannon to crush it
.complete 49327,2,1 
step
.goto 864,29.42,54.47,20,0
.goto 864,29.40,54.01
>>Click the Banner to burn it
.complete 49327,1,2 
step
.goto 864,29.51,53.85
>>Click the Cannon to crush it
.complete 49327,1,1 
step
.goto 864,29.64,53.66
>>Click the Cannon to crush it
.complete 49327,1 
step
.goto 864,29.75,53.04
>>Click the Banner to burn it
.complete 49327,1,3 
step
.goto 864,29.75,52.10
>>Click the Banner to burn it
.complete 49327,1 
step
#label Vorrik
.goto 864,30.04,52.02
>>Click the cage to rescue Vorrik
.complete 49334,1 
step
.goto 864,29.51,53.85
>>Kill Faithless Aggressors, Ravagers, Skycallers, and Sentries
.complete 50641,1 
step
.goto 864,27.97,54.04,50,0
.goto 864,27.21,53.86
>>Talk to Zissiah
.turnin 49327 >>Turn in Push Them Back!
.turnin 50641 >>Turn in Break Their Ranks
step
#completewith X
.goto 864,26.88,52.23
.home >>Set your Hearthstone to Sanctuary of the Devoted
step
.goto 864,27.61,52.57
>>Talk to Vorrik. Press "Escape" on your keyboard to skip the cinematic
.turnin 49334 >>Turn in A Powerful Prisoner
.accept 49340 >>Accept The Keepers' Keys
.complete 49340,1 
.skipgossip
step
.goto 864,27.11,52.57
>>Talk to Vorrik
.turnin 49340 >>Turn in The Keepers' Keys
.accept 49662 >>Accept The Missing Key
step
#completewith Zulsan
>>Kill Deathsnap Caretakers, Carvers, Elders, and Hatchlings. Loot them for their Blood
.complete 47501,1 
step
#completewith next
.goto 864,33.24,50.93,25,0
.goto 864,33.28,50.86,25,0
.goto 864,36.63,50.92,15 >>Take the path up to the cave
step
#label Zulsan
.goto 864,36.91,50.44
>>Loot the smaller skull inside the cave
.complete 47498,1 
step
.goto 864,37.12,51.85,30,0
.goto 864,36.35,52.14,30,0
.goto 864,35.91,51.55,30,0
.goto 864,35.24,50.43,30,0
.goto 864,36.42,50.36,30,0
.goto 864,37.12,51.85,30,0
.goto 864,36.35,52.14,30,0
.goto 864,35.91,51.55,30,0
.goto 864,35.24,50.43,30,0
.goto 864,36.42,50.36
>>Kill Deathsnap Caretakers, Carvers, Elders, and Hatchlings. Loot them for their Blood
.complete 47501,1 
step
.goto 864,37.41,51.10
>>Talk to Rhan'ka
.turnin 47498 >>Turn in Rhan'ka's Lost Friend
.turnin 47501 >>Turn in Dirty Work for Dirty Drinks
.accept 47502 >>Accept The Great Cranium Caper
.accept 47503 >>Accept Gozda'kun the Slaver
.accept 51717 >>Accept The Best Honey In Vol'dun
step
.goto 864,40.45,55.36
>>Talk to Rikati
.turnin 51717 >>Turn in The Best Honey In Vol'dun
.accept 51718 >>Accept Harvesting "Honey"
step
.goto 864,40.45,54.49,35,0
.goto 864,42.01,55.13,35,0
.goto 864,42.87,55.40,35,0
.goto 864,42.07,57.40,45,0
.goto 864,39.11,56.23,45,0
.goto 864,40.45,54.49,35,0
.goto 864,42.01,55.13,35,0
.goto 864,42.87,55.40,35,0
.goto 864,42.07,57.40,45,0
.goto 864,39.11,56.23
>>Kill Bilewing Hives to spawn Creepers
>>Kill Bilewing Cripplers, Creepers, Infesters. Loot them for their Stingers
.goto 864,42.65,55.24
.complete 51718,1 
step
#completewith Sevriss
.goto 864,40.45,55.36
.vendor >> Vendor your trash to Rikati
step
.goto 864,40.45,55.36
>>Talk to Rikati
.turnin 51718 >>Turn in Harvesting "Honey"
.accept 50328 >>Accept Unconventional Aromatics
step
#label Sevriss
.line 864,39.70,59.47,40.28,59.45,41.28,58.39,41.66,58.11,42.95,57.95
.goto 864,39.70,59.47,50,0
.goto 864,40.28,59.45,50,0
.goto 864,41.28,58.39,50,0
.goto 864,41.66,58.11,50,0
.goto 864,42.95,57.95,50,0
.goto 864,39.70,59.47,50,0
.goto 864,40.28,59.45,50,0
.goto 864,41.28,58.39,50,0
.goto 864,41.66,58.11,50,0
.goto 864,42.95,57.95
>>Kill Sevriss. Find a group for him if needed. Skip this step if you're unable to find a group or solo him
.complete 51164,1 
step
#sticky
#label Gozda
.goto 864,47.33,58.82,0,0
>>Kill Gozda'kun
.complete 47503,1 
step
>>Loot Volni and Grenja's Skulls on the ruins
.complete 47502,2 
.goto 864,46.46,57.87
.complete 47502,3 
.goto 864,47.39,58.08
step
#requires Gozda
.goto 864,47.09,59.74
>>Loot Man'zul's Skull on the ruin
.complete 47502,1 
step
#completewith next
.goto 864,43.05,60.87,20 >>Go into the cave
step
.goto 864,43.70,60.24
>>Talk to Rhan'ka
.turnin 47502 >>Turn in The Great Cranium Caper
.turnin 47503 >>Turn in Gozda'kun the Slaver
.turnin 50328 >>Turn in Unconventional Aromatics
.timer 14,Unconventional Aromatics RP
step
>>Wait out the RP. Talk to Rhan'ka
.goto 864,43.53,60.39
.accept 47638 >>Accept Powerful Spirits
.turnin 51164 >>Turn in WANTED: Cobra Excursion Participants
step
.goto 864,43.51,60.43
>>Click the cup of Blood on the rock to drink it
.complete 47638,1 
.timer 23,Powerful Spirits RP
step
>>Wait out the RP. Talk to Rhan'ka, Man'zul, and Zulsan
.turnin 47638 >>Turn in Powerful Spirits
.goto 864,43.51,60.21
.accept 48321 >>Accept Creative Marketing
.goto 864,43.58,59.88
.accept 47564 >>Accept Restocking the Buffet
.goto 864,43.71,60.22
step
.goto 864,42.75,61.07
>>Talk to Volni outside
.accept 48320 >>Accept The Best Kill is Overkill
step
#completewith WhistleFruit
>>Kill Whistlebloom Hives to spawn Drones
>>Kill Whistlebloom Harvesters, Drones, Sentries, and Impalers. Loot them for their Stingers
.complete 48320,1 
step
.goto 864,42.22,61.64
>>Loot the Whistlebloom on the ground for its Fruit
.complete 47564,1,1 
step
.goto 864,41.90,62.02,10,0
.goto 864,41.80,61.78,10,0
.goto 864,41.90,62.02,10,0
.goto 864,41.80,61.78,10,0
.goto 864,41.90,62.02
>>Loot the Whistlebloom on the ground for its Fruit
.complete 47564,1,3 
step
.goto 864,40.87,62.17
>>Loot the Whistlebloom on the ground for its Fruit
.complete 47564,1,4 
step
.goto 864,40.75,62.33
>>Loot the Whistlebloom on the ground for its Fruit
.complete 47564,1,5 
step
.goto 864,41.07,62.79
>>Loot the Whistlebloom on the ground for its Fruit
.complete 47564,1,6 
step
.goto 864,41.47,62.66
>>Loot the Whistlebloom on the ground for its Fruit
.complete 47564,1,7 
step
.goto 864,41.99,62.65
>>Loot the Whistlebloom on the ground for its Fruit
.complete 47564,1,8 
step
.goto 864,42.51,63.63
>>Kill Bloodcrest. Loot it for it's Rib
.complete 48321,1 
step
.goto 864,42.76,62.65
>>Loot the Whistlebloom on the ground for its Fruit
.complete 47564,1,9 
step
#label WhistleFruit
.goto 864,43.03,61.97
>>Loot the Whistlebloom on the ground for its Fruit
.complete 47564,1 
step
.goto 864,43.29,61.63,40,0
.goto 864,39.88,62.12,40,0
.goto 864,40.81,62.69,40,0
.goto 864,42.86,62.80,40,0
.goto 864,43.29,61.63,40,0
.goto 864,39.88,62.12,40,0
.goto 864,40.81,62.69,40,0
.goto 864,42.86,62.80
>>Kill Whistlebloom Hives to spawn Drones
>>Kill Whistlebloom Harvesters, Drones, Sentries, and Impalers. Loot them for their Stingers
.complete 48320,1 
step
.goto 864,42.75,61.07
>>Talk to Volni
.turnin 48320 >>Turn in The Best Kill is Overkill
step
#completewith Omi
.goto 864,42.75,61.07
.fp Whistlebloom Oasis >>Get the Whistlebloom Oasis Flight Path
step
#completewith next
.goto 864,43.05,60.87,15 >>Go into the cave
step
>>Talk to Zulsan and Man'zul
.turnin 47564 >>Turn in Restocking the Buffet
.goto 864,43.71,60.22
.turnin 48321 >>Turn in Creative Marketing
.goto 864,43.58,59.88
step
#completewith next
.goto 864,43.05,60.87,15 >>Exit the cave
step
#label Omi
>>Talk to Omi, Tacha and Kenzou
.accept 48332 >>Accept Ranishu Are Resources
.goto 864,45.37,46.15
.accept 48334 >>Accept They've Got Golems
.goto 864,45.39,46.15
.accept 49001 >>Accept Inconvenient Spirits
.goto 864,45.40,46.18
step
#completewith next
>>Kill Tortured Spirits and Ranishu Nibblers. Loot the Ranishu for their Stomachs
.complete 49001,1 
.complete 48332,1 
step
.goto 864,47.05,50.42
>>Kill the Malfunctioning Golem
.complete 48334,1 
step
>>Kill Tortured Spirits and Ranishu Nibblers. Loot the Ranishu for their Stomachs
.complete 49001,1 
.goto 864,46.77,51.82,40,0
.goto 864,47.52,50.57,40,0
.goto 864,48.20,47.92,40,0
.goto 864,46.43,47.23,40,0
.goto 864,46.77,51.82,40,0
.goto 864,47.52,50.57,40,0
.goto 864,48.20,47.92,40,0
.goto 864,46.43,47.23
.complete 48332,1 
.goto 864,48.93,49.17,40,0
.goto 864,47.57,49.50,40,0
.goto 864,46.95,47.49,40,0
.goto 864,47.32,51.82,40,0
.goto 864,48.93,49.17,40,0
.goto 864,47.57,49.50,40,0
.goto 864,46.95,47.49,40,0
.goto 864,47.32,51.82
step
>>Talk to Kenzou, Tacha and Omi
.turnin 49001 >>Turn in Inconvenient Spirits
.goto 864,45.40,46.18
.turnin 48334 >>Turn in They've Got Golems
.goto 864,45.39,46.15
.turnin 48332 >>Turn in Ranishu Are Resources
.accept 49139 >>Accept An Army's Arsenal
.goto 864,45.37,46.15
.accept 48331 >>Accept Siphoning Souls
.goto 864,45.39,46.15
.accept 48335 >>Accept The Strongest Rope in Vol'dun
.goto 864,45.40,46.18
step
#completewith Scepters
>>Kill Sandspinner Eggs to spawn Hatchlings
>>Kill Sandspinner Weavers, Hatchlings, Hunters, and Lurkers. Loot them for their Silk
.complete 48335,1 
step
#completewith next
>>Kill Soul-Trapped Guardians. Use the |T136019:0|t[Salvaged Soulcatcher Totem] next to their corpses
.complete 48331,1 
.use 154051
step
#label Scepters
>>Kill the Scepter of Mugabu and Jam'jen
.complete 49139,2 
.goto 864,46.06,43.11,20,0
.goto 864,46.11,42.69
.complete 49139,1 
.goto 864,48.12,44.38,20,0
.goto 864,48.34,44.43
step
#completewith next
.goto 864,47.33,42.80,30,0
>>Kill Sandspinner Eggs to spawn Hatchlings
>>Kill Sandspinner Weavers, Hatchlings, Hunters, and Lurkers. Loot them for their Silk
.complete 48335,1 
step
.goto 864,47.33,43.09,40,0
.goto 864,47.09,44.07,40,0
.goto 864,46.60,45.14,40,0
.goto 864,45.86,45.29,40,0
.goto 864,45.78,43.43,40,0
.goto 864,47.33,43.09,40,0
.goto 864,47.09,44.07,40,0
.goto 864,46.60,45.14,40,0
.goto 864,45.86,45.29,40,0
.goto 864,45.78,43.43
>>Kill Soul-Trapped Guardians. Use the |T136019:0|t[Salvaged Soulcatcher Totem] next to their corpses
.complete 48331,1 
.use 154051
step
.goto 864,45.57,45.90,40,0
.goto 864,44.25,43.65,40,0
.goto 864,45.41,43.26,40,0
.goto 864,45.82,44.17,40,0
.goto 864,47.02,43.66,40,0
.goto 864,47.33,42.80,40,0
.goto 864,45.57,45.90,40,0
.goto 864,44.25,43.65,40,0
.goto 864,45.41,43.26,40,0
.goto 864,45.82,44.17,40,0
.goto 864,47.02,43.66,40,0
.goto 864,47.33,42.80
>>Kill Sandspinner Eggs to spawn Hatchlings
>>Kill Sandspinner Weavers, Hatchlings, Hunters, and Lurkers. Loot them for their Silk
.complete 48335,1 
step
>>Talk to Kenzou, Tacha and Omi
.goto 864,45.39,46.17
.turnin 48335 >>Turn in The Strongest Rope in Vol'dun
.goto 864,45.40,46.18
.turnin 48331 >>Turn in Siphoning Souls
.goto 864,45.39,46.15
.turnin 49139 >>Turn in An Army's Arsenal
.accept 48330 >>Accept Zandalari Treasure Trove
.goto 864,45.37,46.15
step
#completewith next
.goto 864,47.26,41.65,20 >> Travel to Zak'rajan
.timer 11,Zak'rajan RP
step
.goto 864,47.26,41.65
>>Wait out the RP. Kill Zak'rajan. Avoid his Soul Barrage when he becomes invulnerable
.complete 48330,1 
step
.goto 864,45.37,46.15
>>Talk to Omi
.turnin 48330 >>Turn in Zandalari Treasure Trove
step
.goto 864,42.91,35.74
>>Talk to Vorrik
.turnin 49662 >>Turn in The Missing Key
.accept 50745 >>Accept Infiltrating the Empire
.timer 73,Infiltrating the Empire RP
step
>>Travel to Vorrik's Sanctum. Wait out the RP. Talk to Vorrik and Meerah
.goto 864,42.89,33.89,20,0
.goto 864,44.12,34.54,20,0
.goto 864,47.94,35.48,20,0
.goto 864,47.96,36.38
.turnin 50745 >>Turn in Infiltrating the Empire
.accept 49664 >>Accept Allies in Anarchy
.goto 864,47.96,36.38
.accept 49667 >>Accept The Little Ones
.goto 864,47.99,36.51

step
>>Talk to Nisha
.goto 864,46.15,33.21
.turnin 49664 >>Turn in Allies in Anarchy
.accept 49666 >>Accept Make Them Fear Us
.accept 49665 >>Accept Ready to Riot
step
#completewith next
>>Kill Faithless. Use the|T236352:0|t[Vulpera Banners] near their corpses
>>Loot Faithless Scimitars from the Weapon Racks, then talk to Vulpera Slaves
.goto 864,46.79,32.88,10,0
.goto 864,47.71,32.87,10,0
.goto 864,47.24,31.24,10,0
.goto 864,47.75,30.82,10,0
.complete 49666,1 
.collect 159470,8,49665,0x1,-1
.complete 49665,1 
.use 158884
.skipgossip
step
.goto 864,48.46,32.18
>>Kill Appraiser Versik
.complete 49667,1 
step
.goto 864,46.50,32.17,30,0
.goto 864,49.07,33.16,30,0
.goto 864,48.18,33.23,30,0
.goto 864,48.74,32.52,30,0
.goto 864,48.02,32.63,30,0
.goto 864,47.87,32.12,30,0
.goto 864,46.33,32.42,30,0
.goto 864,47.83,30.79,30,0
.goto 864,46.50,32.17,30,0
.goto 864,49.07,33.16,30,0
.goto 864,48.18,33.23,30,0
.goto 864,48.74,32.52,30,0
.goto 864,48.02,32.63,30,0
.goto 864,47.87,32.12,30,0
.goto 864,46.33,32.42,30,0
.goto 864,47.83,30.79
>>Kill Faithless. Use the |T236352:0|t[Vulpera Banners] near their corpses
>>Loot Faithless Scimitars from the Weapon Racks, then talk to Vulpera Slaves
.complete 49666,1 
.collect 159470,8,49665,0x1,-1
.complete 49665,1 
.use 158884
.skipgossip
step
>>Talk to Nisha and Kiro
.turnin 49666 >>Turn in Make Them Fear Us
.turnin 49665 >>Turn in Ready to Riot
.accept 50746 >>Accept Crater Conquered
.goto 864,46.15,33.22
.accept 49668 >>Accept Light Up the Gulch
.goto 864,46.10,33.26
step
>>Use |T135432:0|t[Kiro's Torch] FROM RANGE on the Jars of Oil to burn the Slave Markets
.complete 49668,1 
.goto 864,50.84,32.84
.complete 49668,2 
.goto 864,52.37,33.00
.complete 49668,3 
.goto 864,53.56,33.16
.use 158896
step
.goto 864,54.36,34.27
>>Loot the Note on the ground
.accept 49437 >>Accept Tattered Note
step
.goto 864,55.43,35.02
>>Talk to Kiro
.turnin 49668 >>Turn in Light Up the Gulch
.accept 50757 >>Accept Untame Slaughter
.accept 49669 >>Accept Unleash the Beasts
step
#completewith Traskniss
>>Kill Faithless
.complete 50757,1 
step
#completewith next
.goto 864,55.81,34.16,20 >> Take the path up to Shath'kar
step
.goto 864,54.43,33.16
>>Kill Shath'kar near the ledge
.complete 49437,1 
step
#completewith next
.goto 864,55.81,32.16,15 >>Go inside the cave
step
#label Traskniss
.goto 864,55.30,30.77
>>Kill Traskniss inside the cave
.complete 49669,1 
step
.goto 864,55.81,32.16,20,0
.goto 864,56.28,31.13,40,0
.goto 864,56.38,32.58,40,0
.goto 864,56.51,33.71,40,0
.goto 864,56.20,34.64,40,0
.goto 864,55.92,35.24,40,0
.goto 864,55.41,33.68,40,0
.goto 864,56.28,31.13,40,0
.goto 864,56.38,32.58,40,0
.goto 864,56.51,33.71,40,0
.goto 864,56.20,34.64,40,0
.goto 864,55.92,35.24,40,0
.goto 864,55.41,33.68
>>Kill Faithless
.complete 50757,1 
step
.goto 864,55.43,35.02
>>Talk to Kiro
.turnin 50757 >>Turn in Untame Slaughter
.turnin 49669 >>Turn in Unleash the Beasts
.accept 50749 >>Accept Free Ride
step
#completewith next
.goto 864,55.25,35.22
>>Mount the Battle Krolusk
.complete 50749,1 
step
.goto 864,49.90,33.70,15,0
.goto 864,47.94,35.57,70 >>Ride the Battle Krolusk back to Vorrik's Sanctum. Use "Rampaging Charge" (1) on cooldown to move faster
.isOnQuest 50746
step
>>Talk to Vorrik, Kiro, and Meerah
.goto 864,47.94,35.57,20,0
.turnin 50746 >>Turn in Crater Conquered
.accept 49141 >>Accept Diplomacy and Dominance
.accept 50748 >>Accept Don't Drop It... Yet
.goto 864,47.96,36.38
.turnin 50749 >>Turn in Free Ride
.goto 864,48.02,36.44
.turnin 49437 >>Turn in Tattered Note
.turnin 49667 >>Turn in The Little Ones
.goto 864,47.99,36.51
step
#completewith Suppression1
.goto 864,49.54,35.34,20,0
.goto 864,49.07,35.96,30,0
.goto 864,48.48,37.18,20 >>Travel up to the Crackling Ridge
step
#completewith SuppressionSpire
>>Kill Sethrak. Loot them for their Lightning Bombs
.complete 50748,1 
step
#label Suppression1
.goto 864,49.08,36.97
>>Click the Suppression Spire to drain it
.complete 49141,1,1 
step
.goto 864,49.93,38.90
>>Click the Suppression Spire to drain it
.complete 49141,1,2 
step
.goto 864,48.16,37.79
>>Click the Suppression Spire to drain it
.complete 49141,1,3 
step
.goto 864,47.32,36.52
>>Click the Suppression Spire to drain it
.complete 49141,1,4 
step
.goto 864,46.32,36.37
>>Click the Suppression Spire to drain it
.complete 49141,1,5 
step
#label SuppressionSpire
.goto 864,46.12,37.67
>>Click the Suppression Spire to drain it
.complete 49141,1 
step
.goto 864,46.12,37.67,40,0
.goto 864,46.32,36.37,40,0
.goto 864,47.32,36.52,40,0
.goto 864,48.16,37.79,40,0
.goto 864,49.93,38.90,40,0
.goto 864,49.08,36.97,40,0
.goto 864,46.12,37.67,40,0
.goto 864,46.32,36.37,40,0
.goto 864,47.32,36.52,40,0
.goto 864,48.16,37.79,40,0
.goto 864,49.93,38.90,40,0
.goto 864,49.08,36.97
>>Kill Sethrak. Loot them for their Lightning Bombs
.complete 50748,1 
step
#completewith next
.goto 864,47.79,38.24,20,0
.goto 864,47.99,39.20,15 >>Climb the path up the mountain
step
.goto 864,47.10,38.70
>>Talk to the Faithless Trapper's Spear
.accept 49002 >>Accept Forced Grounding
step
#completewith next
.goto 864,47.06,38.60
.cast 257490 >>Use the |T644382:0|t[Faithless Trapper's Spear] on Hrillik's Pterrordax in the sky
.use 154893
step
.goto 864,47.06,38.60
>>Kill Hrillik's Pterrordax, then kill Hrillik
.complete 49002,1 
step
>>Talk to Vorrik and Rakjan
.turnin 49141 >>Turn in Diplomacy of Dominance
.turnin 50748 >>Turn in Don't Drop It... Yet
.accept 49003 >>Accept Vengeance From Above
.goto 864,47.20,39.14
.turnin 49002 >>Turn in Forced Grounding
.complete 49003,1 
.goto 864,47.16,39.34
step
>>Use "Lightning Bomb" (1) to kill Faithless
.goto 864,47.50,32.30,-1
.goto 864,50.36,33.20,-1
.goto 864,52.56,35.52,-1
.complete 49003,2 
step
>>Use "Vorrik's Barrage" to destroy the Spire Barrier (2)
.goto 864,51.96,29.02
.complete 49003,3 
step
.goto 864,51.95,28.69
>>Talk to Vorrik
.turnin 49003 >>Turn in Vengeance From Above
.accept 50750 >>Accept Infuriating the Emperor
.accept 50752 >>Accept Relics of Sethraliss
step
#completewith SkullSky
>>Lightning Orbs spawn from killing Acolytes and Scrollkeepers. Pick them up to recharge your Bulwark Power to keep instantly killing Faithless
.complete 50750,1 
step
.goto 864,49.89,28.50
>>Loot the Scrolls on the table
.complete 50752,1 
step
.goto 864,48.25,26.15
>>Loot the Crystal Ball on the ground
.complete 50752,3 
step
.goto 864,49.56,24.36
>>Loot the Vase on the altar
.complete 50752,4 
step
#completewith next
.goto 864,50.25,26.69,10 >>Jump over the wall
step
#label SkullSky
>>Jump over the wall
.goto 864,50.25,26.69
>>Loot the Skull on the altar
.complete 50752,2 
step
.goto 864,49.89,28.50,40,0
.goto 864,48.25,26.15,40,0
.goto 864,49.56,24.36,40,0
.goto 864,49.56,24.36,40,0
.goto 864,49.89,28.50,40,0
.goto 864,48.25,26.15,40,0
.goto 864,49.56,24.36,40,0
.goto 864,49.56,24.36
>>Lightning Orbs spawn from killing Acolytes and Scrollkeepers. Pick them up to recharge your Bulwark Power to keep instantly killing Faithless
.complete 50750,1 
step
.goto 864,51.95,28.69
>>Talk to Vorrik. Wait out the RP, then talk to him again. Press "Escape" on your keyboard to skip the cinematic
.turnin 50750 >>Turn in Infuriating the Emperor
.turnin 50752 >>Turn in Relics of Sethraliss
.timer 9,Relics of Sethraliss RP
.accept 50550 >>Accept The Fall of Emperor Korthek
.complete 50550,1 
.skipgossip
step
.goto 864,51.96,27.22
>>Kill Korthek. Avoid his Windwall
.complete 50550,2 
.timer 24,The Fall of Emperor Korthek RP
step
.goto 864,51.98,27.72
>>Wait out the RP. Talk to Vorrik
.turnin 50550 >>Turn in The Fall of Emperor Korthek
.accept 50751 >>Accept Sanctuary Under Siege
step << skip
.goto 864,54.95,25.36,8,0
.goto 864,55.01,27.82,8,0
.goto 864,55.00,28.06,5,0
.goto 864,55.40,27.06
.complete 50805,1 

step
#completewith next
.hs >>Hearth to Sanctuary of the Devoted
step
#completewith next
.goto 864,27.04,51.98,12,0
.goto 864,26.51,52.06,12,0
.goto 864,26.75,52.56,12 >>Go upstairs
step
.goto 864,27.09,52.56
>>Talk to Vorrik
.turnin 50751 >>Turn in Sanctuary Under Siege
.accept 50617 >>Accept Atul'Aman
step
#completewith next
.goto 864,26.75,52.56,12,0
.goto 864,26.61,51.31,30,0
.goto 864,27.65,50.33
.fly Goldtusk Inn >>Fly to Goldtusk Inn
step
>>Talk to Vorrik
.goto 864,43.05,68.21
.turnin 50617 >>Turn in Atul'Aman
.accept 50904 >>Accept The Abandoned Passage
.complete 50904,1 
.skipgossip
step
#completewith next
.goto 1009,31.52,80.51,12,0
.goto 1009,37.89,78.14,15 >> Go into the cave
step
>>Click the Tentacles around Kaja and Rakera to destroy them. If you're fast enough you won't get interrupted by the Tendrils
.complete 50904,2 
.goto 1009,42.84,91.93
.complete 50904,3 
.goto 1009,44.62,69.98,20,0
.goto 1009,51.66,67.30
step
.goto 1009,55.64,36.28
>>Ignore all the mobs (they despawn in the next room). Talk to Rakera
.turnin 50904 >>Turn in The Abandoned Passage
.accept 50702 >>Accept Defeat Jakra'zet
step
#completewith next
.goto 1009,67.89,35.86,70 >> Run into Jakra'zet's Room
.timer 14,Defeat Jakra'zet RP
step
.goto 1009,67.89,35.86
>>Kill Jakra'zet. Focus on his Sanguine Wards when they spawn. Press "Escape" on your keyboard to skip the cinematic
.complete 50702,1 
step
.goto 864,27.09,52.64
>>Talk to Warguard Rakera
.turnin 50702 >>Turn in Defeat Jakra'zet
.accept 50703 >>Accept Informing the Horde
step
#completewith BaineNa
.goto 864,26.75,52.56,12,0
.goto 864,26.61,51.31,30,0
.goto 864,27.65,50.33
.fly The Great Seal >>Fly to The Great Seal
step
#completewith PortofZandaFly
.goto 1163,48.78,19.92,30,0
.goto 1163,48.72,72.00
.home >> Set your Hearthstone to The Great Seal
step
#label BaineNa
>>Talk to Baine and Nathanos
.turnin 50703 >>Turn in Keep Them On Task
.goto 1164,41.44,72.50
.accept 52749 >>Accept The War Campaign
.goto 1164,40.17,71.75
step
#label PortofZandaFly
#completewith next
.goto 1163,48.78,19.92,30,0
.goto 1165,51.91,41.21
.fly Port of Zandalar >>Fly to Port of Zandalar
step
>>Talk to Nathanos on the boat
.goto 1165,50.25,96.47,40,0
.goto 1165,50.79,99.97,15,0
.goto 862,58.44,62.67
.turnin 52749 >>Turn in Send the Fleet
.accept 51803 >>Accept The Kul Tiras Campaign
.complete 51803,1 
.accept 52746 >>Accept The War Cache
.turnin 52746 >>Turn in The War Cache
.accept 53333 >>Accept Time for War
.turnin 53333 >>Turn in Time for War
.accept 51770 >>Accept Mission from the Warchief
step
>>Click the War Table, then click on Stormsong Valley
.goto 862,58.44,62.67

.accept 51802 >>Accept Foothold: Stormsong Valley
.turnin 51802 >>Turn in Foothold: Stormsong Valley
step
>>Talk to Nathanos, Cromush, and Garona
.turnin 51803 >>Turn in The Kul Tiras Campaign
.accept 51526 >>Accept The Warlord's Call
.goto 862,58.44,62.67
.turnin 51526 >>Turn in The Warlord's Call
.accept 51532 >>Accept Storming In
.goto 862,58.54,62.49
.turnin 51770 >>Turn in Mission from the Warchief

.goto 1165,51.69,99.69
step
.goto 862,58.46,62.99
>>Go upstairs. Talk to Tattersail to sail to Stormsong
.complete 51532,1 
.skipgossip
step
.goto 942,51.11,21.16
>>Talk to Cromush
.turnin 51532 >>Turn in Storming In
.accept 51643 >>Accept A Wall of Iron
step
#completewith next
.goto 942,51.50,20.76,12,0
.goto 942,51.18,21.12
>>Go downstairs in the ship. Man the Cannon
.complete 51643,1 
step
>>Use "Cannon Blast" (1) on Kul Tiran Forces
.complete 51643,2 
step
.goto 942,51.53,20.75,10,0
.goto 942,51.10,20.81,10,0
.goto 942,51.11,21.16
>>Talk to Cromush
.turnin 51643 >>Turn in A Wall of Iron
.accept 51536 >>Accept On the Hunt
step << !DK !Shaman
#completewith next
.goto 942,51.00,21.26
>>Click the Rope Coil on the ground to take a Landing craft to the Dock
.complete 51536,1 
.timer 12,Landing Craft RP
step
.goto 942,50.88,26.59,30,0
.goto 942,50.38,26.19
>>Pull the Harpoon free from Huelo
.complete 51536,2 
.timer 28,On the Hunt RP
.skipgossip
step
>>Talk to Rexxar
.goto 942,50.40,26.17
.turnin 51536 >>Turn in On the Hunt
.accept 51587 >>Accept Onward!
step << skip
.goto 942,52.04,29.97
.complete 51587,1 
step
#completewith next
.goto 942,52.32,29.57,30,0
.goto 942,52.10,29.96,30 >> Travel up the Mountain
step
>>Talk to Kaga and Rexxar
.turnin 51587 >>Turn in Onward!
.accept 51674 >>Accept Douse the Flames
.accept 51675 >>Accept Hunt Them Down
.goto 942,51.65,29.83
.accept 51691 >>Accept Almost Worth Saving
.goto 942,51.68,29.89
step
#completewith Barricade
>>Kill Storm's Wake Footmen and Tidesages
>>Loot the Tidesages for |T433449:0|t[Umbral Wands] Fading Umbral Wands. Use the Wands on the Flames. You can get 2 with one use
.complete 51675,2 
.collect 160565,4,51674,0x1,-1 
.complete 51674,1 
.use 160565
step
#sticky
#label Ara
.goto 942,51.73,33.53
>>Kill Captain Ara
.complete 51675,1 
step
#label Barricade
.goto 942,51.83,33.58
.cast 272499 >>Destroy the Barricade behind Captain Ara
.isOnQuest 51691

step
#requires Ara
.loop 30,942,51.90,32.68,51.80,32.36,51.30,31.63,50.63,30.88,50.23,30.99,50.05,31.76,50.06,32.19,49.72,32.95,49.87,33.13,50.64,33.54,51.06,33.04,51.90,32.68
>>Kill Storm's Wake Footmen and Tidesages
>>Loot the Tidesages for |T433449:0|t[Umbral Wands] Fading Umbral Wands. Use the Wands on the Flames. You can get 2 with one use
>>Click the Frightened Peons to rescue them
.complete 51675,2 
.collect 160565,4,51674,0x1,-1 
.complete 51674,1 
.complete 51691,1 
.use 160565
step
>>Talk to Kaga and Rexxar
.turnin 51675 >>Turn in Hunt Them Down
.turnin 51691 >>Turn in Almost Worth Saving
.goto 942,49.19,34.21
.turnin 51674 >>Turn in Douse the Flames
.accept 51696 >>Accept Reclaiming What's Ours
.goto 942,49.24,34.26
step
.goto 942,49.61,34.79
>>Climb the tower. Click the Warhorn to sound it. Press "Escape" on your keyboard to skip the cinematic
.complete 51696,1 
step
.goto 942,52.13,33.66
>>Talk to Rexxar
.turnin 51696 >>Turn in Reclaiming What's Ours
.turnin 51753 >>Turn in Champion: Rexxar
.accept 51986 >>Accept Return to Zuldazar
step
.goto 942,51.43,33.74
>>Go outside. Talk to Muka
.complete 51986,1 
.skipgossip 2
step
.goto 862,58.44,62.67
>>Talk to Nathanos
.turnin 51986 >>Turn in Return to Zuldazar
.accept 51979 >>Accept The Ongoing Campaign
step
>>Click the War Table, then click on Tiragarde Sound
.goto 862,58.44,62.67
.accept 51800 >>Accept Foothold: Tiragarde Sound
.turnin 51800 >>Turn in Foothold: Tiragarde Sound

step
>>Talk to Nathanos and Eitrigg. Research Seafarer's Hearth from Eitrigg
.turnin 51979 >>Turn in The Ongoing Campaign
.accept 51421 >>Accept Shiver Me Timbers
.goto 862,58.44,62.67
.accept 53602 >>Accept Adapting Our Tactics
.complete 53602,1 
.goto 862,58.55,62.72
.skipgossip 143913,1
step
>>Talk to Eitrigg
.turnin 53602 >>Turn in Adapting Our Tactics
.goto 862,58.55,62.72
step
>>Talk to Eitrigg again, select the 1st gossip option and research Seafarer's Hearth
.goto 862,58.55,62.72
.complete 53602,1 
step
>>Return to Eitrigg
.goto 862,58.56,62.72
.turnin 53602 >>Turn in Adapting Our Tactics
step
.goto 862,58.46,62.99
>>Go upstairs. Talk to Tattersail to sail to Tiragarde Sound
.complete 51421,1 
.skipgossip

step
.goto 895,89.33,53.38
>>Talk to Shadow Hunter Ty'jin
.turnin 51421 >>Turn in Shiver Me Timbers
.accept 51435 >>Accept Swashbuckling in Style
step
.goto 895,89.46,53.67
>>Loot the Pirate Garb on the ground
.complete 51435,1 
step
.goto 895,89.33,53.38
>>Talk to Shadow Hunter Ty'jin
.turnin 51435 >>Turn in Swashbuckling in Style
.accept 51436 >>Accept Parleyin' Wit Pirates
step
#completewith next
.goto 895,89.33,53.36
.vehicle >>Click the Rope on the ground
.timer 14,Parleyin' Wit Pirates RP
step
.goto 895,88.22,51.17
>>Wait out the RP
.complete 51436,1 
step
.goto 895,88.21,51.11,-1
.goto 895,87.31,49.99,-1
>>Talk to Ty'jin. Follow him
.complete 51436,2 
.skipgossip
.timer 65, Ty'jin Walk RP

step
>>Talk to Owings and Ty'jin
.turnin 51436 >>Turn in Parleyin' Wit Pirates
.accept 51437 >>Accept Spike the Punch
.goto 895,87.31,49.99
.accept 51439 >>Accept Cannonball Collection
.goto 895,87.28,50.01
step
#completewith KegGrog
>>Kill Fogsail Cannoneers. Loot them for their Cannonballs
.complete 51439,1 
step
.goto 895,87.20,50.36
>>Click the Keg of Grog to spike it
.complete 51437,1,1 
step
.goto 895,87.53,50.96
>>Click the Keg of Grog to spike it
.complete 51437,1,2 
step
.goto 895,87.73,51.59
>>Click the Keg of Grog to spike it
.complete 51437,1,3 
step
.goto 895,87.82,50.92
>>Click the Keg of Grog to spike it
.complete 51437,1,4 
step
.goto 895,88.27,50.74
>>Click the Keg of Grog to spike it
.complete 51437,1,5 
step
#label KegGrog
.goto 895,88.01,50.76
>>Click the Keg of Grog to spike it
.complete 51437,1 
step
.goto 895,88.51,49.46,30,0
.goto 895,87.16,49.58,30,0
.goto 895,87.47,50.84,30,0
.goto 895,87.76,50.49,30,0
.goto 895,88.51,49.46,30,0
.goto 895,87.16,49.58,30,0
.goto 895,87.47,50.84,30,0
.goto 895,87.76,50.49
>>Kill Fogsail Cannoneers. Loot them for their Cannonballs
.complete 51439,1 
step
>>Talk to Ty'jin and Owings
.turnin 51439 >>Turn in Cannonball Collection
.goto 895,87.28,50.01
.turnin 51437 >>Turn in Spike the Punch
.accept 51440 >>Accept A Change in Direction
.goto 895,87.31,49.99
.accept 51441 >>Accept Thar She Blows!
.goto 895,87.28,50.01
step
#sticky
#label FogRowboat
>>Use the Goblin-Engineered Hand Cannon on the boats in the water
.complete 51441,1,2 
.use 160405
step
.goto 895,87.47,49.98,10,0
.goto 895,87.43,49.73,20,0
.goto 895,87.29,49.57
>>Talk to Navigator Swink. Wait out his RP, then kill him
.complete 51440,3 
.skipgossip
.timer 13,Swink RP
step
#requires FogRowboat
#completewith KillianMbappe
>>Use the |T252185:0|t[Goblin-Engineered Hand Cannon] on the boats in the water
.complete 51441,1 
.use 160405
step
#requires FogRowboat
.goto 895,87.83,50.41,8,0
.goto 895,87.85,50.08
>>Talk to Boatswain Taryn. Wait out her RP, then kill her
.complete 51440,1 
.skipgossip
step
#label KillianMbappe
.goto 895,87.00,52.01
>>Talk to Quartermaster Killian
.complete 51440,2 
.skipgossip
step
.goto 895,87.21,49.25
>>Use the |T252185:0|t[Goblin-Engineered Hand Cannon] on the boats in the water
.complete 51441,1 
.use 160405
step
>>Talk to Ty'jin and Owings
.turnin 51441 >>Turn in Thar She Blows!
.goto 895,87.28,50.01
.turnin 51440 >>Turn in A Change in Direction
.accept 51442 >>Accept I'm the Captain Now
.goto 895,87.31,49.99
step
.goto 895,86.92,53.16
>>Kill Rhenik inside the cave
.complete 51442,1 
step
>>Talk to Owings and Ty'jin
.turnin 51442 >>Turn in I'm the Captain Now
.goto 895,87.31,49.99
.accept 51438 >>Accept Marking Our Territory
.goto 895,87.28,50.01
step
.goto 895,87.47,50.41
>>Click the banner to plant it. Press "Escape" on your keyboard to skip the cinematic
.complete 51438,1 
step
.goto 895,87.28,50.01
>>Talk to Ty'jin
.turnin 51438 >>Turn in Marking Our Territory
.turnin 51975 >>Turn in Champion: Shadow Hunter Ty'jin
.accept 51984 >>Accept Return to Zuldazar
step
.goto 895,87.84,51.19
>>Go outside. Talk to Erul
.complete 51984,1 
.skipgossip
step
.goto 862,58.44,62.67
>>Talk to Nathanos
.turnin 51984 >>Turn in Return to Zuldazar
.turnin 52451 >>Turn in Uniting Zandalar


step << skip
>>Right-Click the war table and choose Drustvar
.goto 862,58.44,62.67
.accept 51801 >>Accept Foothold: Drustvar
.turnin 51801 >>Turn in Foothold: Drustvar
.complete 52444,1 

step << skip
>>Return to Nathanos Blightcaller
.goto 862,58.44,62.67
.turnin 52444 >>Turn in The Final Foothold
.accept 51332 >>Accept A Trip Across the Ocean

step << skip
>>Go down into the ship and talk to Trade Prince Gallywix
.goto 862,58.50,62.36,8,0
.goto 862,58.45,62.64
.turnin 51332 >>Turn in A Trip Across the Ocean
.accept 51340 >>Accept Drustvar Ho!

step << skip
>>GO upstairs and talk to Eitrigg
.goto 862,58.55,62.72
.skipgossip 2
.complete 51340,1 

step << skip
.goto 862,58.45,62.99
.skipgossip 1
.complete 51340,2 

step << skip
>>Talk to Eitrigg
.goto 896,20.78,43.85
.turnin 51340 >>Turn in Drustvar Ho!

step << skip
#completewith next
+Talk to Swellthrasher
.goto 896,20.60,43.34
.skipgossip
.zoneskip 862

step
#completewith Freedom
.hs >> Hearth to The Great Seal
.cooldown item,6948,>0
step
#completewith Freedom
.goto 1165,50.48,85.70,50,0
.goto 1165,52.09,90.12
.fly The Great Seal >> Fly to The Great Seal
.cooldown item,6948,<0
step
#completewith Freedom
.goto 1163,48.72,18.58,20 >> Go inside The Great Seal
.cooldown item,6948,<0
step
#label Freedom
.goto 1163,57.61,70.33,15,0 >> Take the portal to Orgrimmar
.zone 85 >> Take the portal to Orgrimmar
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#veteran
#group RestedXP Horde 10-60
#name 3 Horde Zuldazar
#displayname Chapter 4 - Zuldazar
#next 4 Horde Silverpine Forest
<< Horde
step
.isQuestAvailable 51443
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Warchief's Herald
.goto 85,49.40,76.59
.accept 51443 >>Accept Battle for Azeroth: Mission Statement
step
.isOnQuest 51443
>>Enter the building
.goto 85,49.43,75.11
*You can skip most cinematics/cutscene by presseing ESC and then clicking yes
.complete 51443,1 
step
.isOnQuest 51443
.goto 85,54.43,78.47
>>Go into the Inn
.complete 51443,2 
step
.isQuestAvailable 50769
.goto 85,54.43,78.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nathanos BLightcaller
.turnin -51443 >>Turn in Battle for Azeroth: Mission Statement
.accept 50769 >>Accept The Stormwind Extraction
step
.isOnQuest 50769
.isQuestTurnedIn 52969
.zoneskip 862
+|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nathanos Blightcaller again
*|cfff78300Don't take the potion. If you did then abandon the quest and accept it again.|r
.goto 85,54.43,78.47
.skipgossip 1
step
.isOnQuest 50769
.zoneskip 862
>>Loot the potion on the table
.goto 85,54.58,78.36
.complete 50769,1 
step
.isOnQuest 50769
.zoneskip 85,1
.isQuestTurnedIn 52969
>>You took the potion. Abandon the quest, reaccept it and use the skip. If you really want to do the scenario again then skip this step
.abandon 50769
step
.isOnQuest 50769
#completewith next
.isQuestTurnedIn 52969
.zoneskip 85,1
+|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nathanos Blightcaller again
*|cfff78300Don't take the potion. If you did then abandon the quest and accept it again.|r
.goto 85,54.43,78.47
.skipgossip 1
step
.isOnQuest 50769
.zoneskip 85,1
>>Loot the potion on the table
.goto 85,54.58,78.36
.complete 50769,1 
step
.isQuestComplete 50769
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nathanos Blightcaller
.turnin 50769 >>Turn in The Stormwind Extraction
.goto 1164,40.11,71.56,-1
.goto 862,57.96,62.76,-1
step
.isOnQuest 50769
.zoneskip 862
>>Leave the building. Get onto a Skyhorn Eagle outside. |cfff78300It's worth doing the scenario at least once so you can skip it on subsequent characters|r
.goto 85,51.19,83.57
.complete 50769,2 
step
.isOnQuest 50769
.zoneskip 862
.scenario 3718,1
step
.isOnQuest 50769
.zoneskip 862
>>Destroy the two Padlocks next to the waypoint by clicking on them. Afterwards follow the arrow into the trapdoor
.scenario 3719,2
.goto 1012,46.31,58.22
.scenario 3719,1
.goto 1012,46.31,57.96
step
.isOnQuest 50769
.zoneskip 862
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tIf possible ignore all mobs, open the door at the end as fast as possible and talk to Saurfang
.scenario 3720,1
.goto 1013,31.52,62.04,3,0
.goto 1013,50.99,39.32
step
.isOnQuest 50769
.zoneskip 862
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tIf possible ignore all mobs, open the door at the end as fast as possible and talk to Saurfang
.scenario 3721,2
.scenario 3721,1
.goto 1013,48.03,33.56,10,0
.goto 1013,55.92,64.00 >> You can already wait at the next prison cell
.skipgossip
step
.isOnQuest 50769
.zoneskip 862
>>Wait at the waypoint until you can see the barrier and then wait until the barrier disappears
.scenario 3722,1
.goto 1013,55.92,64.00
step
.isOnQuest 50769
.zoneskip 862
>>You only need to kill the mobs in front and inside the big circular room. If you're experienced you can ignore the other ones
*Click on the Stormwind Sewer Access at the end
.scenario 3722,2
.goto 1013,53.68,44.44,5,0
.goto 1013,87.17,23.20
step
.isOnQuest 50769
.zoneskip 862
>>|cfff78300Dismiss your pet as a Hunter or Warlock|r << Hunter/Warlock
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rokhan and follow him. Stay inside the shroud
.scenario 3727,1
.goto 1012,71.07,46.71,3,0
.skipgossip
step
.isOnQuest 50769
.zoneskip 862
>>Follow the arrow and kill mobs when you see them.
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tAt the end talk to Nathanos
.scenario 3729,1
.goto 1012,55.81,56.85
.scenario 3729,2
.goto 1012,53.20,55.42,15,0
.goto 1012,47.38,51.81,10,0
.goto 1012,49.42,42.23,15,0
.goto 1012,45.43,43.18
.skipgossip
step
.isOnQuest 50769
.zoneskip 862
>>Follow the arrow, dodge the swirlies on the ground and destroy the Ice Barrier
.scenario 3730,1
.goto 1012,39.79,40.59
step
.isOnQuest 50769
.zoneskip 862
>>Follow the arrow, kill all mobs on the way. Wait for the NPCs to attack them if you're not confident that you can kill them alone
.scenario 3788,1
.goto 1012,36.61,34.81,20,0
.goto 1012,34.40,34.65,10,0
.goto 1012,31.79,31.66,10,0
.goto 1012,28.72,31.54,20,0
.goto 1012,29.81,26.57,25,0
.goto 1012,19.64,25.70
step
.isOnQuest 50769
.zoneskip 862
#completewith next
+You can skip the cutscene at the end by pressing ESC and clicking on Yes
step
.isOnQuest 50769
.zoneskip 862
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFollow Princess Talanji and talk to her
.goto 1012,19.34,28.66,10,0
.goto 1012,20.54,28.93
.skipgossip
.complete 50769,3 
steps
.isOnQuest 60361
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nathanos Blightcaller
.goto 862,57.95,62.76
.turnin 60361 >>Turn in Battle for Azeroth: Mission Statement
step
.isQuestComplete 50769
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nathanos Blightcaller
.turnin 50769 >>Turn in The Stormwind Extraction
.goto 1164,40.11,71.56,-1
.goto 862,57.96,62.76,-1
step
.zoneskip 1164
#label ZuldazarWelcometoZuldazar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Princess Talanji
.accept 46957 >>Accept Welcome to Zuldazar
.goto 862,57.95,62.46
step
.isOnQuest 46957
.zoneskip 1164
>>Stay close to Talanji else she will stop moving
.goto 1165,50.02,60.63,40,0
.goto 1165,50.78,92.73,40,0
.goto 1165,50.35,90.93,40,0
.goto 1165,49.94,85.84,40,0
.goto 1165,48.89,83.91,40,0
.goto 1165,49.98,82.33
.complete 46957,1 
step
.isQuestAvailable 46930
.zoneskip 1164
.goto 1165,49.98,82.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to General Jakra'zet
.turnin -46957 >>Turn in Welcome to Zuldazar
.accept 46930 >>Accept Rastakhan
step
.isOnQuest 46930
.zoneskip 1164
.goto 1165,49.98,82.58
>>|cfff78300DO NOT ride the Pterrordax|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tInstead, talk to Princess Talanji
*Skip the next cinematic with ESC
.complete 46930,1 
.skipgossip
step
.isQuestAvailable 46931
.zoneskip 1164
>>Talk to King Rastakhan
.goto 1165,49.91,42.72
.turnin -46930 >>Turn in Rastakhan
.accept 46931 >>Accept Speaker of the Horde
step
.isOnQuest 46931
#completewith next
>>|cfff78300Follow the arrow.|r You don't need to follow Zolani
.goto 1165,49.43,44.67,10,0
.goto 1165,48.66,44.61,20,0
.goto 1165,49.93,39.86
.complete 46931,1 
step
.isOnQuest 46931
>>Click the shade of the Horde Banner
.goto 1165,49.93,39.86
.complete 46931,2 
step
.isOnQuest 46931
#completewith next
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
step
.isOnQuest 46931
>>Go into the three rooms
.complete 46931,3 
.goto 1163,49.78,73.50
.complete 46931,4 
.goto 1163,67.67,70.75
.complete 46931,5 
.goto 862,57.57,44.37
step
.isOnQuest 46931
>>Go up and talk to Talanji
*If you're very fast then you can skip Talanji's roleplay by relogging
.goto 1164,44.67,70.33,20,0
.goto 1164,41.22,66.75
.turnin 46931 >>Turn in Speaker of the Horde
step << !DemonHunter
.xp <20,1
#completewith next
.goto 1163,74.06,69.92
.zone 85 >>Take the portal to Orgrimmar
step << !DemonHunter
.xp <20,1
#completewith next
#title Active War Mode. Skip if you don't want to.
+Skip if you don't want to activate War Mode (Bottom Right on your Talent Window (N)) even though it increases your experience gain by at least 10%
step << !DemonHunter
.xp <20,1
#label LearnJourneymanRiding1
.goto 85,43.93,72.96,15,0
.goto 85,38.56,78.19
.skill riding,150 >>Train Journeyman Riding
step << !DemonHunter
.zoneskip 85,1
#completewith next
.goto 85,53.17,90.47,10,0
.goto 85,58.54,91.30
.zone 1163 >>Take the portal to Zuldazar
step
#label ZuldazarAcceptZuldazar
.goto 1164,41.72,69.33
>>Click the Scouting Map, click on Zuldazar. Accept the quest
.accept 47514 >>Accept Zuldazar
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Talanji
.goto 1164,41.22,66.75
.turnin 47514 >>Turn in Zuldazar
.accept 49615 >>Accept Trust of a King
step
#completewith next
.goto 1164,22.67,72.08,5,0
.goto 1165,48.72,44.92,10,0
.goto 1165,49.56,44.60,18 >>Take the elevator up to King Rastakhan
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to King Rastakhan, Zolani, and Yazma
.goto 1164,22.67,72.08,5,0
.goto 1165,48.72,44.92,10,0
.goto 1165,49.56,44.60,18,0
.turnin 49615 >>Turn in Trust of a King
.accept 49488 >>Accept Tal'gurub
.goto 1165,49.93,46.62
.accept 50835 >>Accept The Port of Zandalar
.goto 1165,49.82,46.55
.accept 47445 >>Accept The Zanchuli Council
.goto 1165,49.73,46.51
step
.itemcount 109076,<1
#completewith ZuldazarTheZanchuliCouncil
.goto 1165,48.58,42.83,20,0
.goto 1165,48.51,37.82,15,0
.goto 1165,47.79,37.53,15,0
.goto 1165,46.97,37.19,15,0
.goto 1165,45.20,37.20,15,0
.goto 1165,45.22,31.83,20,0
.goto 1165,42.19,26.22,20 >>|cfff78300Follow the arrow.|r Jump down Dazar'alor carefully. Be careful of fall damage
step
.itemcount 109076,>0
#completewith ZuldazarTheZanchuliCouncil
.goto 1165,45.26,24.02
.use 109076
.cast 109076>>Use a Goblin Glider Kit to fly to Wardruid Loti
step
#label ZuldazarTheZanchuliCouncil
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
.goto 1165,45.26,24.02
.turnin 47445 >>Turn in The Zanchuli Council
.accept 47423 >>Accept Forbidden Practices
step
.use 152627
.goto 1165,47.30,21.67,30,0
.goto 1165,48.09,20.82,30,0
.goto 1165,48.92,18.10,30,0
.goto 1165,49.84,17.92,30,0
.goto 1165,50.31,15.00,30,0
.goto 1165,50.40,13.00,30,0
.goto 1165,50.65,10.74,30,0
.goto 1165,51.65,10.35,30,0
.goto 1165,47.30,21.67
>>Use |T136008:0|t[Loti's Totem] near Zanchuli Acolytes to reveal them
.complete 47423,1 
.use 152627
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hexlord Raal
.goto 1165,51.90,11.89
.turnin 47423 >>Turn in Forbidden Practices
.accept 47433 >>Accept Offensively Defensive
step
>>Mount Ata the Winglord
.goto 1165,53.20,11.63
.complete 47433,2 
step
>>Use the "Farseer Totems" (1) on the glowing circles. Make sure to zoom out and look around
*The first one is directly below the starting position
.complete 47433,3 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
.goto 1165,46.21,19.25
.turnin 47433 >>Turn in Offensively Defensive
.accept 47435 >>Accept Pterrortorial Dispute
.accept 47434 >>Accept Restraining Order
step
.goto 1165,42.88,19.90,30,0
.goto 1165,41.91,16.04,30,0
.goto 1165,40.91,15.02,30,0
.goto 1165,38.59,15.73,30,0
.goto 1165,38.35,10.85,30,0
.goto 1165,39.42,14.08,30,0
.goto 1165,42.88,19.90
>>Run through Hatchlings to shoo them. Kill Bloodraged Pterrordax
.complete 47434,1 
.complete 47435,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hexlord Raal
.goto 1165,40.92,11.33
.turnin 47435 >>Turn in Pterrortorial Dispute
.turnin 47434 >>Turn in Restraining Order
.accept 47437 >>Accept Competitive Devotion
step
>>Kill the |cff00ecffGuardian of the Tombs|r
.goto 1167,65.69,69.07
.complete 47437,1 
step
>>Kill the |cff00ecffGuardian of the Rites|r
.goto 1167,36.67,25.67,15,0
.goto 1167,44.14,15.47,15,0
.goto 1166,65.91,30.73
.complete 47437,2 
step
>>Kill the |cff00ecffGuardian of the Dead|r
.goto 1166,66.62,69.40,15,0
.goto 1166,78.58,86.53,15,0
.goto 1165,44.29,16.71
.complete 47437,3 
step
>>Climb the pyramid and talk to Wardruid Loti
.goto 1165,46.06,15.65,14,0
.goto 1165,46.11,13.07
.turnin 47437 >>Turn in Competitive Devotion
.accept 47422 >>Accept Dire Situation
step
>>Kill |cff00ecffDregada|r. Dodge the leap. Run through the totems at the edges to pick up buffs.
.goto 1165,43.64,7.39
.complete 47422,1 
step
.isQuestAvailable 47438
#completewith next
+|cfff78300Please follow the waypoint and the instructions perfectly and choose the Pterrodax not the Raptor on the next quest. Disable other Addons that automatically turn in quests.|r
step
.isQuestAvailable 47438
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
.turnin 47422 >>Turn in Dire Situation
.accept 47438 >>Accept Picking a Side
.goto 1165,42.30,9.10
step
.isQuestAvailable 47438
#completewith next
+|cfff78300Please follow the waypoint and the instructions perfectly and choose the Pterrodax not the Raptor on the next quest. Disable other Addons that automatically turn in quests.|r
step
.isQuestAvailable 47438
>>Click Pa'ku to choose her
.complete 47438,1 
.goto 1165,42.61,9.21
step
.isQuestTurnedIn 47443
>>You've chosen the wrong loa, reaccept the quest and pick the pterrodax. If you've already accidently turned in the quest the skip this step.
.abandon 47438
step
.isQuestAvailable 47438
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
.accept 47438 >>Accept Picking a Side
.goto 1165,42.30,9.10
step
.isQuestAvailable 47438
>>Click Pa'ku to choose her
.complete 47438,1 
.goto 1165,42.61,9.21
step
.isQuestTurnedIn 47436
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
.turnin 47438 >>Turn in Picking a Side
.goto 1165,42.30,9.10
step
.isQuestTurnedIn 47436
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hexlord Raa
.accept 47440 >>Accept Pa'ku, Master of Winds
.goto 1165,42.54,9.49
step
.isQuestTurnedIn 47443
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
.goto 1165,42.30,9.10
.accept 47439 >>Accept Gonk, Lord of the Pack
step
.isQuestTurnedIn 47443
#completewith next
.goto 1165,42.27,9.47,1 >>Run through the Totem of Gonk to gain his buff. The buff reduces your falling damage and increases your movement speed
.goto 1165,40.51,9.40,15,0
.goto 1165,37.95,11.25,20,0
.goto 1165,36.28,7.99,25 >>Jump down
step
.isQuestTurnedIn 47443
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gonk
.goto 862,48.18,32.27
.skipgossip
.complete 47439,1 
step
.isQuestTurnedIn 47443
#completewith next
.goto 862,48.05,28.70,20,0
.goto 862,48.56,26.87,20,0
.goto 862,49.72,26.27
.fly The Great Seal >>Fly to The Great Seal
step
.isQuestTurnedIn 47443
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Huntmaster Kil'ja
.accept 49768 >>Accept Nesingwary's Trek
.goto 1165,52.00,41.39
step
.isQuestTurnedIn 47443
#completewith next
.goto 1165,50.49,40.70,10 >>Run through the Gonk Totem to get his buff
step
.isQuestTurnedIn 47443
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tJump down and talk to Wardruid Loti
.goto 1165,49.92,33.42
.turnin 47439 >>Turn in Gonk, Lord of the Pack
.accept 48897 >>Accept The Bargain is Struck
step
.isQuestTurnedIn 47443
#completewith Hatchling
.cast 6478 >>Click the Altar of Gonk to gain a passive damage buff
.goto 1165,49.92,33.10
step
.isQuestTurnedIn 47443
#completewith Hatchling
.itemcount 109076,<1
.goto 1165,52.27,32.40,18,0
.goto 1165,54.56,32.10,20,0
.goto 1165,58.14,26.43,25,0
.goto 1165,58.40,18.28,25,0
.goto 1165,61.83,35.70,25 >>Follow the arrow down
step
.isQuestTurnedIn 47443
#completewith next
.itemcount 109076,1
.use 109076
.cast 126389 >>Use the Goblin Glider Kit to glide down to the quest
step
.isQuestTurnedIn 47443
#label Hatchling
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Direhorn Hatchling
.goto 862,65.66,41.35
.accept 47226 >>Accept The Orphaned Hatchling
step
.isOnQuest 47440
>>Mount Ata the Winglord
.goto 1165,42.51,10.05
.complete 47440,1 
step
.isQuestTurnedIn 47436
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Pa'ku
.goto 862,71.31,48.67,15,0
.goto 862,71.52,49.40
.complete 47440,2 
step
.isQuestTurnedIn 47436
#completewith next
+If you wish to save time, open up the Battle Net client on your computer
step
.isQuestTurnedIn 47436
.goto 862,71.78,49.24,12,0
.goto 862,72.1,49.5
.complete 47440,3 
.timer 52,Flight Duration
step
.isQuestTurnedIn 47436
#completewith next
+Press "Play" on the Battle Net client to open a second WoW client. Do NOT close your first client. Log in on your second client, wait until you can move, then close your first client
step
.isQuestTurnedIn 47436
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hexlord Raal
.goto 1165,49.92,33.41
.turnin 47440 >>Turn in Pa'ku, Master of Winds
.accept 47432 >>Accept The Bargain is Struck
step
.isQuestTurnedIn 47436
#completewith next
.cast 6478 >>Click the Altar of Pa'ku to gain a movement speed buff
.goto 1165,49.92,33.10
step
.isQuestTurnedIn 47436
#completewith next
.vehicle 131154 >>Click the Totem of Pa'ku
.goto 1165,49.54,32.83
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Huntmaster Kil'ja
.accept 49768 >>Accept Nesingwary's Trek
.goto 1165,52.00,41.39
step << !DemonHunter
.isQuestTurnedIn 47436
#completewith TotemPaku1
.goto 1165,51.12,40.45,15,0
.goto 1165,51.35,37.81,15,0
.goto 1165,52.96,37.08,15,0
.goto 1165,54.54,35.71,20,0
.goto 1165,58.28,35.06,25,0
.goto 1165,58.30,32.63,40 >> Travel down Dazar'alor
.itemcount 109076,<1
step
.isQuestTurnedIn 47436
#completewith next
.cast 126389 >>Use a |T133632:0|t[Goblin Glider Kit] from atop the Golden Throne to glide down
.use 109076
.itemcount 109076,1
step
.isQuestTurnedIn 47436
#label TotemPaku1
#completewith Hatchling2
.goto 1165,58.30,32.63
.vehicle 131154 >>Click the Totem of Pa'ku
.timer 11,Pa'ku Flight
.itemcount 109076,<1
step
#label Hatchling2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Direhorn Hatchling
.goto 862,65.66,41.35
.accept 47226 >>Accept The Orphaned Hatchling
step
.goto 862,66.57,40.25,20,0
.goto 862,66.69,40.94,10,0
.goto 862,66.81,42.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Beastlord L'kala
.turnin 47226 >>Turn in The Orphaned Hatchling
.accept 47259 >>Accept Direhorn Daycare
.accept 48527 >>Accept Ravenous Landsharks
step
#completewith DirehornD
.goto 862,66.56,42.35
.home >>Set your Hearthstone to Beastcaller Inn
step << Monk
.xp <20,1
.zoneskip 379
#completewith LearnJourneymanRiding2
.cast 126892 >>Use Zen Pilgrimage
step << Monk
.xp <20,1
#completewith LearnJourneymanRiding2
.goto 379,48.53,43.57
.zone 85 >>Take the Portal to Orgrimmar
step << !DemonHunter !Monk
.xp <20,1
#completewith LearnJourneymanRiding2
.goto 862,67.26,43.02
.fly The Great Seal >>Fly to The Great Seal
step << !DemonHunter !Monk
.zoneskip 85
.xp <20,1
#completewith LearnJourneymanRiding2
.goto 1163,48.74,29.28,20 >>Enter The Great Seal
step << !DemonHunter !Monk
.xp <20,1
#completewith LearnJourneymanRiding2
.goto 1163,74.06,69.92
.zone 85 >>Take the portal to Orgrimmar
step << !DemonHunter !Monk
.xp <20,1
#completewith next
#title Active War Mode. Skip if you don't want to.
+Skip if you don't want to activate War Mode (Bottom Right on your Talent Window (N)) even though it increases your experience gain by at least 10%
step << !DemonHunter
.xp <20,1
#label LearnJourneymanRiding2
.goto 85,53.17,90.47,10,0
.goto 85,43.93,72.96,15,0
.goto 85,38.56,78.19
.skill riding,150 >>Train Journeyman Riding
step << !DemonHunter
.zoneskip 85,1
.xp <20,1
.cooldown item,6948,<1,1
#completewith ZuldazarNearlyHatchungEgg
.goto 85,43.93,72.96,15,0
.goto 85,53.17,90.47,10,0
.zone 1163 >>Take the portal to Zuldazar
.goto 85,58.54,91.30
.fly Warbeast Kraal >>Fly to Warbeast Kraal
.goto 1165,51.81,41.25
step << !DemonHunter
.xp <20,1
.zoneskip 85,1
#completewith ZuldazarNearlyHatchungEgg
.hs >>Hearth to Warbeast Kraal
.cooldown item,6948,>0,1
step
#completewith next
>>Kill Irritable Diemetradons. Pull them aggressively
.goto 862,68.35,45.75,0,0
.complete 48527,1 
step
>>Click the Soothing Lilybuds
*When the plant keeps glowing you have to click it again
.goto 862,68.09,43.42,6,0
.goto 862,68.70,43.99,6,0
.goto 862,68.96,44.07,6,0
.goto 862,69.90,44.22,6,0
.goto 862,69.53,44.95,6,0
.goto 862,69.20,45.51,6,0
.goto 862,68.88,45.34,6,0
.goto 862,68.65,44.48,6,0
.goto 862,68.11,44.31,6,0
.goto 862,68.38,45.78
.complete 47259,1 
step
.goto 862,69.04,47.68,30,0
.goto 862,69.61,44.45,30,0
.goto 862,68.96,43.89
>>Kill Irritable Diemetradons
.complete 48527,1 
step
#label DirehornD
#requires ZuldazarIrritableDiemetraden
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Beastlord L'kala and Trader Alexxi
.turnin 47259 >>Turn in Direhorn Daycare
.turnin 48527 >>Turn in Ravenous Landsharks
.accept 47311 >>Accept Headbutting 101
.goto 862,66.81,42.51
.accept 47272 >>Accept Direhorn Growth Hormone
.goto 862,66.81,42.58
step
#completewith next
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Wanted poster and Wingrider Nivek
.accept 51980 >>Accept WANTED: Jabra'kan
.goto 862,69.07,40.85
.accept 47312 >>Accept Queenfeather
.goto 862,69.02,40.69
step
#completewith ZuldazarDirehornGrowthHormone
>>Use your Extra Action Button ON COOLDOWN on Savagemane Ravasaurs and Invasive Eggsnatchers
.complete 47311,1 
step
#completewith ZuldazarDirehornGrowthHormone6
>>Kill Queenfeather. Loot her for her Plume
.goto 862,71.14,40.26,0,0
.complete 47312,1 
step
#title Fresh Carrion 1
>>Loot the Steaming Fresh Carrions on the ground
.goto 862,70.01,40.40
.complete 47272,1,1 
step
#title Fresh Carrion 2
>>Loot the Steaming Fresh Carrions on the ground
.goto 862,70.18,40.26
.complete 47272,1,2 
step
#title Fresh Carrion 3
>>Loot the Steaming Fresh Carrions on the ground
.goto 862,70.54,40.60
.complete 47272,1,3 
step
#title Fresh Carrion 4
>>Loot the Steaming Fresh Carrions on the ground
.goto 862,70.82,40.95
.complete 47272,1,4 
step
#title Fresh Carrion 5
>>Loot the Steaming Fresh Carrions on the ground
.goto 862,71.37,41.36
.complete 47272,1,5 
step
#label ZuldazarDirehornGrowthHormone6
#title Fresh Carrion 6
>>Loot the Steaming Fresh Carrions on the ground
.goto 862,71.38,40.68
.complete 47272,1,6 
step
#label ZuldazarQueenfeather
>>Kill Queenfeather. Loot her for her Plume
.goto 862,71.14,40.26,0,0
.complete 47312,1 
step
#title Fresh Carrion 7
>>Loot the Steaming Fresh Carrions on the ground
.goto 862,70.73,39.81
.complete 47272,1,7 
step
#title Fresh Carrion 8
>>Loot the Steaming Fresh Carrions on the ground
.goto 862,70.76,39.51
.complete 47272,1,8 
step
#title Fresh Carrion 9
>>Loot the Steaming Fresh Carrions on the ground
.goto 862,70.35,39.59
.complete 47272,1,9 
step
#label ZuldazarDirehornGrowthHormone
#title Fresh Carrion 10
>>Loot the Steaming Fresh Carrions on the ground
.goto 862,70.00,39.25
.complete 47272,1 
step
>>Use your Extra Action Button ON COOLDOWN on Savagemane Ravasaurs and Invasive Eggsnatchers
.goto 862,70.37,39.76
.complete 47311,1 
step
.goto 862,67.07,37.11
>>Kill Jabra'kan. Move away from Traps he throws at you and the cone damage from his Volley
*|cfff78300Skip this step if he's not up during an assault|r
.complete 51980,1 
step
.isQuestComplete 51980
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wingrider Nivek
.goto 862,69.02,40.69
.turnin 51980 >>Turn in WANTED: Jabra'kan
.turnin 47312 >>Turn in Queenfeather
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wingrider Nivek
.goto 862,69.02,40.69
.abandon 51980 >>Abandon WANTED: Jabra'kan
.turnin 47312 >>Turn in Queenfeather
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Beastlord L'kala, Trader Alexxi, then L'kala again
.turnin 47311 >>Turn in Headbutting 101
.goto 862,66.81,42.51
.turnin 47272 >>Turn in Direhorn Growth Hormone
.accept 51998 >>Accept DGH: Now With Real Direhorn
.goto 862,66.81,42.58
.accept 51990 >>Accept Wings for the Kraal
.goto 862,66.81,42.51
step << Monk
.xp <20,1
.zoneskip 379
#completewith LearnJourneymanRiding3
.cast 126892 >>Use Zen Pilgrimage
step << Monk
.xp <20,1
#completewith LearnJourneymanRiding3
.goto 379,48.53,43.57
.zone 85 >>Take the Portal to Orgrimmar
step << !DemonHunter !Monk
.xp <20,1
#completewith LearnJourneymanRiding3
.goto 862,67.26,43.02
.fly The Great Seal >>Fly to The Great Seal
step << !DemonHunter !Monk
.zoneskip 85
.xp <20,1
#completewith LearnJourneymanRiding3
.goto 1163,48.74,29.28
.zone 1163 >> Enter the Great Seal
step << !DemonHunter !Monk
.xp <20,1
#completewith LearnJourneymanRiding3
.goto 1163,74.06,69.92
.zone 85 >>Take the portal to Orgrimmar
step << !DemonHunter
.xp <20,1
#completewith LearnJourneymanRiding3
#title Active War Mode. Skip if you don't want to.
+Skip if you don't want to activate War Mode (Bottom Right on your Talent Window (N)) even though it increases your experience gain by at least 10%
step << !DemonHunter
.xp <20,1
#label LearnJourneymanRiding3
.goto 85,53.17,90.47,10,0
.goto 85,43.93,72.96,15,0
.goto 85,38.56,78.19
.skill riding,150 >>Train Journeyman Riding
step << !DemonHunter
.zoneskip 85,1
.xp <20,1
.cooldown item,6948,<1,1
#completewith ZuldazarNearlyHatchungEgg
#label JourneymanPortalBack3
.goto 85,43.93,72.96,15,0
.goto 85,53.17,90.47,10,0
.zone 1163 >>Take the portal to Zuldazar
.goto 85,58.54,91.30
.fly Warbeast Kraal >>Fly to Warbeast Kraal
.goto 1165,51.81,41.25
step << !DemonHunter
.xp <20,1
.zoneskip 85,1
#completewith ZuldazarNearlyHatchungEgg
.hs >>Hearth to Warbeast Kraal
.cooldown item,6948,>0,1
step
#requires JourneymanPortalBack3
#completewith next
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
step
#requires JourneymanPortalBack3
#completewith next
.goto 862,67.78,40.52,30,0
.goto 862,67.05,36.42,30,0
.goto 862,66.80,36.17,20 >> Run up the path to the Skyrender Eyrie
step
#requires JourneymanPortalBack3
#completewith ZuldazarNearlyHatchungEgg
>>Kill Pterrodax Skyrenders and Wild Pterrorchicks. Loot them for their Flesh
.complete 51998,1 
step
#requires JourneymanPortalBack3
#title Egg 1
.goto 862,66.95,34.99
>>Loot the Egg on the ground
.complete 51990,1,1 
step
#title Egg 2
.goto 862,67.05,34.48
>>Loot the Egg on the ground
.complete 51990,1,2 
step
#title Egg 3
.goto 862,67.01,33.89
>>Loot the Egg on the ground
.complete 51990,1,3 
step
#title Egg 4+5
.goto 862,66.83,34.04
>>Loot the Egg on the ground
.complete 51990,1,5 
step
#title Egg 6+7
.goto 862,66.71,34.50
>>Loot the Eggs on the ground
.complete 51990,1,7 
step
#label ZuldazarNearlyHatchungEgg
#title Egg 8
.goto 862,66.50,34.89
>>Loot the Eggs on the ground
.complete 51990,1 
step
.goto 862,66.02,32.86,40,0
.goto 862,67.71,31.93,40,0
.goto 862,66.77,35.52
>>Kill Pterrodax Skyrenders and Wild Pterrorchicks. Loot them for their Flesh
.complete 51998,1 
step
#completewith next
.goto 862,65.81,34.78,25,0
.goto 862,64.83,34.99,25,0
.goto 862,63.79,35.11,50 >>Jump down the cliffs
step
.goto 862,62.82,32.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zul
.turnin 49488 >>Turn in Tal'gurub
.accept 49489 >>Accept Needs a Little Body
.accept 49490 >>Accept The Urn of Voices
step
#completewith ZuldazarVoodooTotemEight
>>Kill the Jambani and Masks for their souls
.complete 49490,1 
step
.goto 862,63.62,31.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Izita's Spirit
.accept 49491 >>Accept Fuel for the Voodoo
step
#title Totem 1
.goto 862,64.19,32.82
>>Loot the Totem on the ground
.complete 49491,1,1 
step
#title Totem 2
.goto 862,64.72,32.98
>>Loot the Totem on the ground
.complete 49491,1,2 
step
#sticky
#label Totem3
#title Totem 3
.goto 862,64.98,32.91,-1
>>Loot the Totem on the ground
.complete 49491,1,3 
step
#title Concotion 1
>>Go inside the building. Click Atal'jamba Ungo
.goto 862,65.03,32.98,-1
.complete 49489,1,1 
step
#requires Totem3
#completewith next
.goto 862,64.36,33.14,15,0
.goto 862,63.94,32.49,20 >>Go back across the bridge, then turn right as you get onto the stairs
step
#requires Totem3
#title Totem 4
.goto 862,63.91,31.92
>>Loot the Totem on the ground
.complete 49491,1,4 
step
#title Totem 5
.goto 862,63.74,30.83
>>Loot the Totem on the ground
.complete 49491,1,5 
step
#title Totem 6
.goto 862,63.11,30.22
>>Loot the Totem on the ground
.complete 49491,1,6 
step
#title Concotion 2
>>Go inside the building. Click Atal'jamba Iri
.goto 862,63.07,29.06,12,0
.goto 862,63.20,29.06
.complete 49489,1 
step
#title Totem 7
.goto 862,62.70,29.09
>>Loot the Totem on the ground
.complete 49491,1,7 
step
#label ZuldazarVoodooTotemEight
#title Totem 8
.goto 862,62.88,28.61
>>Loot the Totem on the ground
.complete 49491,1,8 
step
.goto 862,62.70,29.09,40,0
.goto 862,63.11,30.22,40,0
.goto 862,63.74,30.83,40,0
.goto 862,63.91,31.92,40,0
.goto 862,64.19,32.82,40,0
.goto 862,64.72,32.98
>>Kill the Jambani and Masks for their souls
.complete 49490,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Brazier and Zul
.turnin 49491 >>Turn in Fuel for the Voodoo
.goto 862,62.74,28.43
.turnin 49489 >>Turn in Needs a Little Body
.turnin 49490 >>Turn in The Urn of Voices
.accept 49492 >>Accept Arrogance of Vol'jamba
.goto 862,62.86,28.24
step
>>Click the Masks on the wall. Don't worry about their traps
.complete 49492,1 
.goto 862,62.90,28.00
.complete 49492,2 
.goto 862,63.55,28.08
.complete 49492,3 
.goto 862,64.12,28.37
.timer 20,Zul RP
step
>>Wait for Zul to walk up the stairs. Talk to him
.goto 862,64.38,28.55
.turnin 49492 >>Turn in Arrogance of Vol'jamba
.accept 49493 >>Accept Zul's Ethical Dilemma
.accept 49494 >>Accept Zuvembi Brew
step
#completewith ZuldazarJambaniStockpiles
>>Use the |T237388:0|t[Mindbreaker Chant] while standing in melee range of Mindslaved Berserkers and Mindslaved Gurubashi. Try to free multiple in one cast
.use 155458
.complete 49493,1 
step
.goto 862,64.88,27.00
>>Kill Zuvembi Brewer Zekal
.complete 49494,1 
step
.goto 862,65.29,28.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Jambani Stockpile, then click it again to burn it
.accept 51663 >>Accept Preparing for the Fall
.complete 51663,1,1 
step
#title Stockpile 2
>>Click the Jambani stockpile to burn it
.goto 862,65.39,27.86
.complete 51663,1,2 
step
#title Stockpile 3
>>Click the Jambani stockpile to burn it
.goto 862,65.00,28.34
.complete 51663,1,3 
step
#title Stockpile 4
>>Click the Jambani stockpile to burn it
.goto 862,64.92,28.36
.complete 51663,1,4 
step
#title Stockpile 5
>>Click the Jambani stockpile to burn it
.goto 862,64.66,28.64
.complete 51663,1,5 
step
#title Stockpile 6
>>Click the Jambani stockpile to burn it
.goto 862,64.61,29.82
.complete 51663,1,6 
step
#title Stockpile 7
>>Click the Jambani stockpile to burn it
.goto 862,65.02,29.62
.complete 51663,1,7 
step
#label ZuldazarJambaniStockpiles
#title Stockpile 8
>>Click the Jambani stockpile to burn it
.goto 862,65.59,29.14
.complete 51663,1 
step
>>Use the Mindbreaker Chant while standing in/near Mindslaved Berserkers/Gurubashi
.use 155458
.goto 862,66.35,29.55,30,0
.goto 862,66.47,28.56,30,0
.goto 862,66.07,28.57,30,0
.goto 862,64.66,28.64,30,0
.goto 862,64.61,29.82
.complete 49493,1 
step
#completewith next
.goto 862,65.71,30.21,40 >>Climb the stairs
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zul
.goto 862,65.71,30.21
.turnin 49493 >>Turn in Zul's Ethical Dilemma
.turnin 49494 >>Turn in Zuvembi Brew
.turnin 51663 >>Turn in Preparing for the Fall
.accept 49495 >>Accept Enforcing Fate
step
.isOnQuest 49495
>>Make sure to accept the quest with two free bag slots. If you see this message then free up some bag space, abandon the quest and reaccept it
.collect 160523,1,49495,1
.collect 160524,1,49495,1
step
>>Click the Gong of Command
.goto 862,65.89,31.09
.complete 49495,1 
step
>>Click the shade of the Urn
.goto 862,65.89,30.67
.complete 49495,2 
.timer 6,Urn of Voices RP
step
>>Click the shade of the Urn again when it appears
.goto 862,65.86,30.65
.complete 49495,3 
step
>>Click the potion on the table
.goto 862,65.56,31.30
.complete 49495,4 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zul
.goto 862,65.71,30.21
.turnin 49495 >>Turn in Enforcing Fate
.accept 49905 >>Accept Plot Twist
.timer 30,Plot Twist RP
step
>>Wait for the roleplay to finish and attack Vol'jamba
.goto 862,65.68,31.03
.complete 49905,1 
step
.goto 862,65.68,31.03
>>Kill Vol'Jamba
.complete 49905,2 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zul
.goto 862,65.58,30.51
.turnin 49905 >>Turn in Plot Twist
.accept 49663 >>Accept False Prophecies
step
#completewith HuntKing
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
step
#completewith next
.goto 862,66.99,29.79,30 >> Run down this part of the cliff
step
#label HuntKing
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Hunter's Board, Hemet Nesingwary, Erak, and Tracker Burke
.accept 47706 >>Accept Hunt for King K'tal
.goto 862,67.44,17.90
.turnin 49768 >>Turn in Nesingwary's Trek
.accept 50466 >>Accept He's Gone Mad!
.goto 862,67.50,17.70
.accept 47584 >>Accept A Thorn in the Side
.goto 862,67.45,17.72
.accept 47583 >>Accept Die, Die, Diemetradon
.goto 862,67.56,17.73
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the dead Trapper on the ground
.goto 862,68.85,19.44,0,0
.accept 47585 >>Accept Predatory
step
#completewith ZuldazarWildtusk
>>Kill |cff00ecffVemomous Diemetradons|r and |cff00ecffAnkylodons|r
.goto 862,70.84,20.31,40,0
.complete 47583,1 
.complete 47584,1 
step
#completewith next
.line 862,71.69,20.36,71.40,20.93,71.33,21.89,71.50,22.41,70.84,22.62,70.14,22.88,68.99,22.64,68.26,21.95,67.98,22.04,67.93,22.32,68.10,22.90,68.25,22.74,68.42,23.03,69.76,22.59,70.84,22.62
>>Kill |cff00ecffKing K'tal|r. Loot him for his Skull. Find a group for him if needed. Skip this step |cfff78300and abandon the quest|r if you're unable to find a group or solo him.
.complete 47706,1 
.unitscan King K'tal
.isOnQuest 47706
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ranger Paalu on the ground
.goto 862,70.63,22.09
.complete 47585,1 
step << Hunter
#completewith next
+Recommendation: Tame a Ankylodon (Dismiss Pet -> Tame Beast)
*Ferocity pets are far more durable.
*Ignore this step if you aready have a Ferocity pet or want to keep using your current one.
.goto 862,70.21,21.95,25,0
step
#label ZuldazarWildtusk
.goto 862,70.94,26.26
>>Kill |cff00ecffWildtusk|r
.complete 50466,1 
step
#completewith next
>>Kill |cff00ecffVenomous Diemetradons|r
.complete 47583,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marksman Julyen on the ground
.goto 862,67.81,25.03
.complete 47585,2 
step
.loop 40,862,68.00,26.14,68.86,25.70,68.80,25.22,68.41,25.03,68.56,24.19,67.78,24.33,67.41,24.86,68.00,26.14
.complete 47583,1 
step
#completewith next
.line 862,71.69,20.36,71.40,20.93,71.33,21.89,71.50,22.41,70.84,22.62,70.14,22.88,68.99,22.64,68.26,21.95,67.98,22.04,67.93,22.32,68.10,22.90,68.25,22.74,68.42,23.03,69.76,22.59,70.84,22.62
>>Kill |cff00ecffKing K'tal|r. Loot him for his Skull. Find a group for him if needed. Skip this step |cfff78300and abandon the quest|r if you're unable to find a group or solo him.
.complete 47706,1 
.unitscan King K'tal
.isOnQuest 47706
step
>>Kill |cff00ecffAnkylodons|r
.goto 862,67.81,22.89,45,0
.goto 862,68.74,21.43,45,0
.goto 862,68.63,20.44,45,0
.goto 862,67.66,20.12,45,0
.goto 862,68.26,18.54,45,0
.goto 862,69.11,18.71
.complete 47584,1 
step
#completewith ZuldazarNesingwarysTrekTurnins
.line 862,71.69,20.36,71.40,20.93,71.33,21.89,71.50,22.41,70.84,22.62,70.14,22.88,68.99,22.64,68.26,21.95,67.98,22.04,67.93,22.32,68.10,22.90,68.25,22.74,68.42,23.03,69.76,22.59,70.84,22.62
.goto 862,67.81,23.37,40,0
.goto 862,71.39,21.48,40,0
.goto 862,67.81,23.37
>>Kill |cff00ecffKing K'tal|r. Loot him for his Skull. Find a group for him if needed. Skip this step |cfff78300and abandon the quest|r if you're unable to find a group or solo him.
.complete 47706,1 
.unitscan King K'tal
.isOnQuest 47706
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nesingwary's Trek. Talk to Tracker Burke's Hat, Erak, and Huntmaster Vol'ka
.turnin 47583 >>Turn in Die, Die, Diemetradon
.goto 862,67.50,18.89
.turnin 47584 >>Turn in A Thorn in the Side
.goto 862,68.01,18.03
.turnin 47585 >>Turn in Predatory
.turnin 47706 >>Turn in Hunt for King K'tal
.turnin 50466 >>Turn in He's Gone Mad!
.accept 47586 >>Accept Hunting the Hunter
.goto 862,67.50,17.62
.isQuestComplete 47706
step
#label ZuldazarNesingwarysTrekTurnins
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nesingwary's Trek. Talk to Tracker Burke's Hat, Erak, and Huntmaster Vol'ka
.turnin 47583 >>Turn in Die, Die, Diemetradon
.goto 862,67.50,18.89
.turnin 47584 >>Turn in A Thorn in the Side
.goto 862,68.01,18.03
.turnin 50466 >>Turn in He's Gone Mad!
.turnin 47585 >>Turn in Predatory
.accept 47586 >>Accept Hunting the Hunter
.goto 862,67.50,17.62
step
.abandon 47706 >> Abandon Hunt for King K'tal
step
#completewith next
.goto 862,66.19,17.60
.fp Nesingwary's Gameland >>Get the Nesingwary's Gameland Flight Path
step
#completewith ZuldazarFollowNesingwary
>>Kill Feathered Vipers, their Eggs, and Wild Sabertusks
.complete 50178,1 
step
>>Click Nesingwary's Campfire on the ground
.goto 862,62.45,19.26
.complete 47586,1 
step
>>Click the Dwarf Trap on the ground
.goto 862,61.48,17.95
.complete 47586,2 
step
#label ZuldazarFollowNesingwary
>>Click the Nesingwary's Rifle on the ground
.goto 862,62.32,16.87
.complete 47586,3 
step
>>Finish killing Feathered Vipers, their Eggs, and Wild Sabertusks
.goto 862,62.76,17.45,40,0
.goto 862,62.88,17.04,40,0
.goto 862,64.01,19.36,40,0
.goto 862,64.14,17.29,40,0
.goto 862,65.83,17.90,40,0
.goto 862,65.17,20.05,40,0
.goto 862,62.76,17.45
.complete 50178,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hemet Nesingwary inside the building
.goto 862,63.49,16.15
.turnin 47586 >>Turn in Hunting the Hunter
.accept 47587 >>Accept Headhunter Jo
step
.goto 862,62.96,15.81
>>Kill Headhunter Jo outside
.complete 47587,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hemet Nesingwary
.goto 862,63.49,16.15
.turnin 47587 >>Turn in Headhunter Jo
step
#completewith ZuldazarPortofZuldazar
.goto 862,63.88,18.27,20,0
.goto 862,66.19,17.60
.fly Warbeast Kraal >>Fly to Warbeast Kraal
.cooldown item,6948,<1
step
#completewith ZuldazarPortofZuldazar
.hs >>Hearth to Warbeast Kraal
.cooldown item,6948,>0
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Warbeast Kraal. Talk to Beastlord L'kala and Trader Alexxi
.turnin 51990 >>Turn in Wings for the Kraal
.goto 862,66.81,42.51
.turnin 51998 >>Turn in DGH: Now With Real Direhorn
.goto 862,66.81,42.58
step
#completewith next
.goto 862,67.26,43.03
.fly Port of Zandalar >>Fly to Port of Zandalar
step
#label ZuldazarPortofZuldazar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zolani and Yazma
.turnin 50835 >>Turn in The Port of Zandalar
.accept 46926 >>Accept Shakedown
.goto 1165,50.06,85.07
.accept 46846 >>Accept The Word of Zul
.goto 1165,50.05,84.76
step
#completewith ZuldazarDocksideThugs
.goto 1165,47.83,87.31,0
>>Kill Gurubashi, Amani, and Sandfury Thugs
.complete 46926,1 
step
.goto 1165,51.52,91.03
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nokali. |cfff78300Do NOT go downstairs.|r
.skipgossip
.complete 46846,1 
step
#completewith next
.goto 1165,53.48,90.62,20 >> Jump down through the gap in the wall
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Volkini
.goto 1165,53.89,91.20
.skipgossip
.complete 46846,2 
step
#completewith next
.goto 1165,56.03,89.72,20 >> Go under the overhang
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Scrollsage Rooka
.goto 1165,55.95,88.83
.accept 48404 >>Accept The Scamps
step
#completewith next
>>Interact with the Street Scamps. |cfff78300Be careful as they vanish after a few seconds|r
*You can find some at the waypoint marks on your minimap but they run around everywhere. If you don't finish this now, we will finish it later.
.goto 1165,51.65,93.32,0
.goto 1165,49.19,89.77,0
.goto 1165,52.30,82.86,0
.goto 1165,48.74,89.43,0
.goto 1165,49.19,89.77,10,0
.complete 48404,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dockmaster Cobo
.goto 1165,45.31,79.78
.skipgossip
.complete 46846,3 
step
#label ZuldazarDocksideThugs
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Witch Doctor Jala
.goto 1165,44.25,82.15
.accept 48452 >>Accept The Red Market
step
#completewith next
>>Kill |cff00ecffCrimson Cultists|r. Loot them for their Dark Fetishes
.complete 48452,1 
step
>>|cfff78300Make sure to jump down while mounted otherwise your pet will pull everything|r << Hunter/Warlock
>>Jump down below, then go inside the building. Click the Chalice of Calling
.goto 1165,42.76,83.64,12,0
.goto 1165,43.13,83.07
.complete 48452,2 
step
.goto 1165,41.82,82.83,30,0
.goto 1165,41.67,77.10,30,0
.goto 1165,43.13,83.07
>>Kill |cff00ecffCrimson Cultists|r. Loot them for their Dark Fetishes
.complete 48452,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Witch Doctor Jala
.goto 1165,42.87,79.27,15,0
.goto 1165,44.25,82.15
.turnin 48452 >>Turn in The Red Market
.accept 48454 >>Accept Evidence of Evil
step
#completewith next
>>Interact with the Street Scamps. |cfff78300Be careful as they vanish after a few seconds|r
*You can find some at the waypoint marks on your minimap but they run around everywhere
.goto 1165,51.65,93.32,0
.goto 1165,49.19,89.77,0
.goto 1165,52.30,82.86,0
.goto 1165,48.74,89.43,0
.complete 48404,1 
step
.goto 1165,45.31,80.04,30,0
.goto 1165,47.52,87.26,30,0
.goto 1165,46.97,89.89,30,0
.goto 1165,48.45,83.77,30,0
.goto 1165,45.31,80.04
>>Kill |cff00ecffGurubashi, Amani, and Sandfury Thugs|r
.complete 46926,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zolani and Yazma
.turnin 46926 >>Turn in Shakedown
.turnin 48454 >>Turn in Evidence of Evil
.accept 46929 >>Accept Deterrent
.goto 1165,50.06,85.07
.turnin 46846 >>Turn in The Word of Zul
.accept 46927 >>Accept Punishment of Tal'aman
.accept 46928 >>Accept Punishment of Tal'farrak
.goto 1165,50.05,84.76
step
#completewith Gong
>>Interact with the Street Scamps. |cfff78300Be careful as they vanish after a few seconds|r
*You can find some at the waypoint marks on your minimap but they run around everywhere
.goto 1165,51.65,93.32,0
.goto 1165,49.19,89.77,0
.goto 1165,52.30,82.86,0
.goto 1165,48.74,89.43,0
.goto 1165,52.08,83.02,15,0
.goto 1165,50.02,89.97,0,0
.complete 48404,1 
step
#completewith GahzRagon
.goto 1165,48.39,77.83,40,0
>>Kill |cff00ecffSandfury Trolls|r. Loot them for their Heads
.complete 46929,2 
step
#label Gong
#completewith next
.goto 1165,46.61,73.87
.cast 3365 >>Click the Ancient Gong to summon Gahz'ragon
step
#label GahzRagon
.goto 1165,46.63,72.61
>>Kill |cff00ecffGahz'ragon|r. Loot him for his Tongues
.complete 46928,1 
step
.goto 1165,46.61,70.64,40,0
.goto 1165,47.71,72.37,40,0
.goto 1165,45.82,77.73,40,0
.goto 1165,48.39,77.83
>>Kill |cff00ecffSandfury Trolls|r. Loot them for their Heads
.complete 46929,2 
step
#completewith next
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
step
.goto 1165,51.74,77.65,40,0
.goto 1165,54.22,79.81,40,0
.goto 1165,57.31,80.80
>>Kill |cff00ecffAmani Trolls|r. Loot them for their Heads
.complete 46929,1 
step
#completewith next
.goto 1165,56.19,87.53
.cast 3365 >>Click the Ancient Gong to summon an Amani Disciple
step
>>Kill the |cff00ecffAmani Disciples|r
*Sometimes it can bug and you have to wait for around 2 minutes until you can interact with the gong again
.goto 1165,56.04,86.88
.complete 46927,1,1 
step
#completewith next
.goto 1165,56.19,87.53
.cast 3365 >>Click the Ancient Gong to summon an Amani Disciple
step
>>Kill the |cff00ecffAmani Disciples|r
*Sometimes it can bug and you have to wait for around 2 minutes until you can interact with the gong again
.goto 1165,56.04,86.88
.complete 46927,1,2 
step
#completewith next
.goto 1165,56.19,87.53
.cast 3365 >>Click the Ancient Gong to summon an Amani Disciple
step
>>Kill the |cff00ecffAmani Disciples|r
*Sometimes it can bug and you have to wait for around 2 minutes until you can interact with the gong again
.goto 1165,56.04,86.88
.complete 46927,1,3 
step
#completewith next
.goto 1165,56.19,87.53
.cast 3365 >>Click the Ancient Gong to summon an Amani Disciple
step
>>Kill the |cff00ecffAmani Disciples|r
*Sometimes it can bug and you have to wait for around 2 minutes until you can interact with the gong again
.goto 1165,56.04,86.88
.complete 46927,1 
step
#completewith Rooka
.goto 1165,54.41,87.92,25 >> Jump down by taking the shortcut here
step
>>Interact with the Street Scamps.|cfff78300Be careful as they vanish after a few seconds|r
.goto 1165,51.65,93.32,30,0
.goto 1165,49.19,89.77,30,0
.goto 1165,52.30,82.86,30,0
.goto 1165,48.74,89.43,30,0
.goto 1165,51.65,93.32,30,0
.goto 1165,49.19,89.77,30,0
.goto 1165,52.30,82.86,30,0
.goto 1165,48.74,89.43
.complete 48404,1 
step
#label Rooka
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Scrollsage Rooka
.goto 1165,56.25,89.70,15,0
.goto 1165,55.95,88.83
.turnin 48404 >>Turn in The Scamps
.accept 48405 >>Accept Mista Nice
step
>>|cfff78300Mount up and follow the arrow|r
.goto 1165,59.06,90.73,12,0
.goto 1165,59.11,88.71,12,0
.goto 1165,57.21,87.77
.complete 48405,1 
step
.goto 1165,57.20,87.39
>>Kill |cff00ecffMista Nice|r. Move out of the Voodoo Totem he places
.complete 48405,2 
step
>>Jump down again. Talk to Scrollsage Rooka
.goto 1165,55.95,88.83
.turnin 48405 >>Turn in Mista Nice
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wavesinger De'zan to take a boat to Seeker's Outpost
.goto 1165,52.83,95.78
.vehicle 133540 >>Seeker's Outpost Boat Ride
.timer 59,Seeker's Outpost RP
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Koba and Batu. Batu wanders around the camp.
.accept 49285 >>Accept Tiny Treasures
.goto 862,70.27,65.02,0,0
.accept 49284 >>Accept Perfect Tidings
.goto 862,70.28,64.95,0,0
step
#completewith ClueThree
>>Kill |cff00ecffMurlocs|r and run on top of Tadpoles to scare them. We will finish this later if its not complete by the time you're with the next steps.
.complete 49315,1 
step
>>Search the Bag under the tree
.goto 862,71.19,64.58
.complete 49284,1 
step
>>Loot the cage
.goto 862,71.66,64.15
.complete 49285,1 
step
>>Search the Scroll against the tree
.goto 862,72.65,63.05
.complete 49284,2 
step
>>Loot Spitzy on the ground
.goto 862,73.10,64.81
.complete 49285,3 
step
>>Loot the Alchemist Stone floating above the water
.goto 862,73.19,67.22
.complete 49285,2 
step
#completewith next
.cooldown item,132516,>0,1
.cast 202844 >>Use your |T1405809:0|t[Gunshoes] to move faster
.use 132516
.itemcount 132516,1
step
#label ClueThree
>>Search the Scroll Case
.goto 862,74.02,62.08
.complete 49284,3 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Choa and Deyon
.goto 862,73.68,60.99
.turnin 49285 >>Turn in Tiny Treasures
.turnin 49284 >>Turn in Perfect Tidings
.accept 49286 >>Accept Caged Wisdom
step
>>Go inside the cave. Kill |cff00ecffSil'thrus|r. Loot him for his Key
.goto 862,73.66,60.49,20,0
.goto 862,74.60,59.34
.complete 49286,1 
step
.goto 862,73.68,60.99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tClick the cage, then talk to Deyon
.complete 49286,2 
.turnin 49286 >>Turn in Caged Wisdom
.accept 49287 >>Accept Lost Chelonians
.accept 49288 >>Accept Scrollhunters
step
#completewith ZuldazarLostChelonians
>>Kill Murlocs and run on top of Tadpoles to scare them
.complete 49315,1 
step
#sticky
#completewith ZuldazarLostChelonians
>>Kill |cff00ecffNazeshi Tempest-Wielders|r. Loot them for the scrolls
.complete 49288,1 
step
>>Open the cage
.goto 862,73.90,65.85
.complete 49287,1 
step
>>Open the cage
.goto 862,75.13,66.55
.complete 49287,2 
step
>>Open the cage
.goto 862,75.49,66.25,5,0
.goto 862,75.75,66.55,5,0
.goto 862,77.05,66.48
.complete 49287,3 
step
#label ZuldazarLostChelonians
>>Open the cage
*|cfff78300DO NOT PULL Tidecaller Nezara, she is level 60|r
.goto 862,76.66,65.67,25,0
.goto 862,76.66,64.88,25,0
.goto 862,77.29,64.36
.complete 49287,4 
step
#label ShallowsTI
>>Kill Murlocs and run on top of Tadpoles to scare them
.goto 862,74.67,65.85
.complete 49315,1 
step
>>Kill |cff00ecffNazeshi Tempest-Wielders|r. Loot them for the scrolls
.goto 862,76.66,65.67,25,0
.goto 862,76.66,64.88,25,0
.goto 862,77.29,64.36
.complete 49288,1 
step
#requires ShallowsTI
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deyon
.goto 862,75.22,61.49
.turnin 49287 >>Turn in Lost Chelonians
.turnin 49288 >>Turn in Scrollhunters
.accept 49289 >>Accept A Special Stone
step
>>Kill |cff00ecffTidemistress Nazesh|r. Loot her for the orders
>>Also loot the Stone Fragment from the Fractured Azerite
*You can use the Scroll of Storm Control for an extra ability
.goto 862,76.67,61.42
.use 157539
.complete 49289,2 
.complete 49289,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deyon
.goto 862,75.22,61.49
.turnin 49289 >>Turn in A Special Stone
step
>>Wait for the roleplay to finish and talk to Deyon again
.goto 862,75.22,61.49
.accept 51407 >>Accept Find Their Words
step
>>Take the portal to the right of Deyon and return to Akru
.goto 862,70.56,64.89
.turnin 51407 >>Turn in Find Their Words
step
#completewith next
.goto 862,70.45,65.30
.fly Port of Zandalar >>Fly to Port of Zandalar
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Yazma and Zolani
.turnin 46927 >>Turn in Punishment of Tal'aman
.turnin 46928 >>Turn in Punishment of Tal'farrak
.goto 1165,50.05,84.76
.turnin 46929 >>Turn in Deterrent
.accept 50881 >>Accept Royal Report
.goto 1165,50.05,85.08
step
#completewith ZuldazarFalseProphecies
.goto 1165,52.09,90.10
.fly The Great Seal >>Fly to The Great Seal
step
#completewith ZuldazarFalseProphecies
.isQuestTurnedIn 47436
.vehicle 131154 >>Click the Totem of Pa'ku
.goto 1165,51.37,40.95
step
#completewith ZuldazarFalseProphecies
.isQuestTurnedIn 47443
.goto 1165,49.93,42.24,10,0
.goto 1164,37.75,71.70,10,0
.goto 1164,20.56,72.09,5 >>Take the elevator to King Rastakhan
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Habutu. You may have to wait when you turned in the other quests first
.goto 1165,49.43,44.77,20,0
.goto 1165,50.03,46.54
.turnin 50881 >>Turn in Royal Report
step
#label ZuldazarFalseProphecies
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to King Rastakhan
.goto 1165,49.92,46.63
.turnin 47432 >>Turn in The Bargain is Struck
.turnin 49663 >>Turn in False Prophecies
.accept 49122 >>Accept A Port in Peril
step
.maxlevel 29
.goto 1165,49.92,42.10,10,0
.goto 1165,47.79,37.53,8,0
.goto 1165,46.97,37.19,8,0
.goto 1165,45.20,37.20,8,0
.goto 1165,43.55,36.88,20,0
.goto 1165,45.03,39.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Myxle
.accept 51465 >>Accept A Load of Scrap
step
.isOnQuest 51465
>>Interact with the Shred-Master Mk1
*Place the Tattered Pants from your inventory in the Shred-Master Mk1 and press the 'Scrap' Button
.goto 1165,45.02,39.92
.complete 51465,1 
step
.isQuestComplete 51465
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Myxle
.goto 1165,45.03,39.61
.turnin 51465 >>Turn in A Load of Scrap
step
.maxlevel 29
#completewith ZuldazarWantedSabertuskPrime

.goto 1165,41.93,40.74,10,0
.goto 1165,41.27,40.58,5,0
.goto 862,54.94,42.00,5,0
.goto 862,54.58,41.60,15 >>Mount up and jump into the water
.goto 862,53.46,42.25,8 >>Climb the mountain by Right-Clicking the Ropes
.itemcount 109076,<1
step
#completewith ZuldazarWantedSabertuskPrime
.use 109076
.goto 862,51.62,45.45
.cast 126389 >>Use a Goblin Glider Kit
.itemcount 109076,1
step
.maxlevel 29
#label ZuldazarWantedSabertuskPrime
>>Click the WANTED board
.goto 862,51.62,45.45
.accept 51071 >>Accept WANTED: Sabertusk Empress
.accept 51072 >>Accept WANTED: Prime Thumpknuckle
step
.isOnQuest 51071
>>SEMI HARD elite, shouldn't be too hard to kill
.goto 862,52.69,45.05
.complete 51072,1 
step
.isOnQuest 51071
>>VERY HARD elite, only try it if you know what to do and/or are using heirlooms
*Even with heirlooms this elite can be very difficult depending on your class
.goto 862,52.36,47.76
.complete 51071,1 
step
.isQuestComplete 51071
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Shaz'ki
.goto 862,51.65,50.53
.turnin 51071 >>Turn in WANTED: Sabertusk Empress
step
.isQuestComplete 51072
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Saz'ki
.goto 862,51.65,50.53
.turnin 51072 >>Turn in WANTED: Prime Thumpknuckle
step
.maxlevel 29
.itemcount 132516,1
#completwith next
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
.maxlevel 29
#label ZuldazarGorillaGorge
#completewith ZuldazarPeaceLovingGorillas
.accept 49918 >>Accept Gorilla Gorge (Bonus Objective)
.complete 49918,1 
step
.maxlevel 29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tsunga
.goto 862,51.51,53.77,15,0
.goto 862,50.17,54.57
.accept 49920 >>Accept Gorilla Warfare
step
.isOnQuest 49920
#completewith ZuldazarDakaniGorillas
+Pick up a Kaja'mite Chunk for a damage buff
step
.isOnQuest 49920
>>Open the cage
.goto 862,49.95,54.94
.complete 49920,1,1 
step
.isOnQuest 49920
>>Open the cage
.goto 862,49.56,55.26
.complete 49920,1,2 
step
.isOnQuest 49920
>>Open the cage
.goto 862,49.03,54.79
.complete 49920,1,3 
step
.isOnQuest 49920
>>Open the cage
.goto 862,48.63,53.91
.complete 49920,1,4 
step
.isOnQuest 49920
#completewith next
.goto 862,48.00,54.24,20,0
+You can kill the rare |cff00ecffZayoos|r if you want. He drops a pretty good trinket and counts for the bonus objective
step
.isOnQuest 49920
>>Open the cage
.goto 862,48.14,53.16
.complete 49920,1,5 
step
.isOnQuest 49920
#label ZuldazarPeaceLovingGorillas
>>Open the cage
.goto 862,48.09,51.24
.complete 49920,1 
step
.isQuestComplete 49920
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tsunga
.goto 862,47.42,52.43
.turnin 49920 >>Turn in Gorilla Warfare
step
.isOnQuest 49918
#label ZuldazarDakaniGorillas
>>Kill |cff00ecffGorillas|r
.waypoint 862,48.93,54.52,-25,0
.complete 49918,1 
step
.maxlevel 29
.itemcount 132516,1
#completwith next
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
.maxlevel 29
.isQuestTurnedIn 49920
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zolani
.goto 862,47.92,60.45
.turnin 49122 >>Turn in A Port in Peril
.accept 49144 >>Accept Wrath of the Zandalari
step
.maxlevel 29
.isQuestTurnedIn 49122
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Habutu
.goto 862,47.86,60.45
.accept 49145 >>Accept No Troll Left Behind
step
.maxlevel 29
.isQuestTurnedIn 49122
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kaza'Jin
.goto 862,47.13,60.47
.accept 49146 >>Accept Spirit's Belongings
step
.isOnQuest 49144
#completewith ZuldazarGrimoireoftheOtherSide
>>Kill |cff00ecffMogu Invaders|r
.complete 49144,1 
step
.isOnQuest 49145
#title Rally Rastair Defenders
>>Use the Rastari Skull Whistle near Rastari Defenders to rally them
.goto 862,46.80,60.66
.use 153524
.complete 49145,1,2 
step
.isOnQuest 49145
#title Rally Rastair Defenders
>>Use the Rastari Skull Whistle near Rastari Defenders to rally them
.goto 862,46.34,60.17
.use 153524
.complete 49145,1,5 
step
.isOnQuest 49146
#title Reclaimed Bijous
>>Pick up the Reclaimed Bijous
.goto 862,45.61,60.38
.complete 49146,1 
step
.isOnQuest 49145
#title Rally Rastair Defenders
>>Use the Rastari Skull Whistle near Rastari Defenders to rally them
.goto 862,45.61,60.38
.use 153524
.complete 49145,1,7 
step
.isOnQuest 49145
#title Rally Rastair Defenders
>>Use the Rastari Skull Whistle near Rastari Defenders to rally them
.goto 862,45.30,60.91
.use 153524
.complete 49145,1,12 
step
.isOnQuest 49146
#title Venerated Remains
>>Pick up the Venerated Remains
.goto 862,45.30,60.91,10,0
.goto 862,45.81,62.45
.complete 49146,3 
step
.isOnQuest 49146
#label ZuldazarGrimoireoftheOtherSide
#title Grimoire of the Other Side
>>Jump down and pick up the Grimoire of the Other Side
.goto 862,46.80,61.90
.complete 49146,2 
step
.isOnQuest 49144
>>Kill |cff00ecffMogu Invaders|r
.goto 862,46.45,60.75
.goto 862,46.45,60.80
.complete 49144,1 
step
.isQuestComplete 49145
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Habutu
.goto 862,47.87,60.44
.turnin 49145 >>Turn in No Troll Left Behind
step
.isQuestComplete 49144
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zalani
.goto 862,47.92,60.45
.turnin 49144 >>Turn in Wrath of the Zandalari
step
.isOnQuest 49146
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kaza'jin
.goto 862,48.08,60.37
.turnin 49146 >>Turn in Spirits' Belongings
step
.maxlevel 29
.isQuestTurnedIn 49146
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kaza'jin
.goto 862,48.08,60.37
.accept 49149 >>Accept Embrace the Voodoo
step
.maxlevel 29
.isQuestTurnedIn 49146
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zalani
.goto 862,47.92,60.45
.accept 49148 >>Accept Crumbling Apart
step
.maxlevel 29
.isQuestTurnedIn 49146
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Habutu
.goto 862,47.87,60.44
.accept 49147 >>Accept Show of Strength
step
.isOnQuest 49148
#completewith ZuldazarBlueRunesTurnin
+Standing in the blue runes on the ground gives you 100% crit chance
step
.isOnQuest 49148
#completewith ZuldazarSpiritObelisksactivated
>>Kill |cff00ecffStormbound Conquerer|r
.complete 49148,1 
step
.isOnQuest 49149
>>Click on the Spirit Obelisk
.goto 862,47.22,61.86
.complete 49149,1,1 
step
.isOnQuest 49149
>>Click on the Spirit Obelisk
.goto 862,47.97,63.06
.complete 49149,1,2 
step
.isOnQuest 49147
.goto 862,48.15,64.48
.complete 49147,1 
step
.isOnQuest 49149
>>Click on the Spirit Obelisk
.goto 862,47.45,65.14
.complete 49149,1,3 
step
.isOnQuest 49149
>>Click on the Spirit Obelisk
.goto 862,47.86,67.24,10,0
.goto 862,47.38,66.92,5,0
.goto 862,47.48,66.76
.complete 49149,1,4 
step
.isOnQuest 49147
.goto 862,45.83,66.51
.complete 49147,2 
step
.isOnQuest 49149
#label ZuldazarSpiritObelisksactivated
>>Click on the Spirit Obelisk
.goto 862,47.26,66.11,15,0
.goto 862,48.18,65.42,15,0
.goto 862,48.55,64.51
.complete 49149,1 
step
.isOnQuest 49148
>>Kill |cff00ecffStormbound Conquerer|r. Finish this quests
.goto 862,48.61,65.60
.complete 49148,1 
step
.isQuestComplete 49149
#label ZuldazarBlueRunesTurnin
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kaza'jin
.goto 862,49.59,64.48
.turnin 49149 >>Turn in Embrace the Voodoo
.turnin 49147 >>Turn in Show of Strength
.turnin 49148 >>Turn in Crumbling Apart
step
.maxlevel 29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kaza'jin
.goto 862,49.59,64.48
.accept 49309 >>Accept Thunder's Fall
step
.isOnQuest 49309
>>Kill |cff00ecffWarlord Kao|r on the ship
.goto 862,50.19,65.38
.complete 49309,1 
step
.isQuestTurnedIn 49148
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kaza'jin
.goto 862,49.59,64.48
.turnin 49309 >>Turn in Thunder's Fall
.accept 49310 >>Accept The Prophet's Ploy
step
.isOnQuest 49310
#completewith next
+You can skip the next cutscene (Esc -> Yes)
step
.isOnQuest 49310
>>Mount Scarbeak
.goto 862,49.51,64.34
.complete 49310,1 
step
.isQuestComplete 49310
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Baine
.goto 1164,41.33,72.25
.turnin 49310 >>Turn in The Prophet's Play
step
.maxlevel 29
.isQuestTurnedIn 49310
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Baine
.accept 47509 >>Accept Terrace of the Chosen
.accept 51101 >>Accept in The Wounded King
step
.isQuestTurnedIn 47436
#completewith ZuldazarTerraceoftheChosen
.goto 1165,49.92,33.18
.cast 6478 >>Click the Altar of Pa'ku to gain a movement speed buff
step
.isQuestTurnedIn 47443
#completewith ZuldazarTerraceoftheChosen
.goto 1165,49.92,33.18
.cast 6478 >>Click the Altar of Gonk to gain a passive damage buff
step
.isQuestComplete 47509
#label ZuldazarTerraceoftheChosen
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kaza'jin
.goto 1165,42.30,26.63,20,0
.goto 1165,42.6,21.4
.turnin 47509 >>Turn in Terrace of the Chosen
step
.isQuestTurnedIn 47509
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kaza'jin
.goto 1165,42.6,21.4
.accept 47897 >>Accept Zanchuli Traitors
.accept 47915 >>Accept Rescuing the Taken
step
.isOnQuest 47897
#completewith next
>>Kill |cff00ecffZanchuli traitors|r
.complete 47897,1 
step
.isOnQuest 47915
>>Kill |cff00ecffHexmother Kala|r.Loot her for the fetish
.goto 1165,41.42,18.84,8,0
.goto 1165,43.51,17.71
.complete 47915,1 
step
.isOnQuest 47897
>>Kill |cff00ecffZanchuli traitors|r
.goto 1165,39.62,13.19
.complete 47897,1 
step
.isQuestTurnedIn 47509
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
.goto 1165,39.3,13.7
.turnin 47897 >>Turn in Zanchuli Traitors
.turnin 47915 >>Turn in Rescuing the Taken
step
.isQuestTurnedIn 47915
.maxlevel 29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
.goto 1165,39.3,13.7
.accept 47518 >>Accept Raal
.accept 47520 >>Accept Walls Have Ears
step
.isOnQuest 47520
#sticky
#label ZuldazarEyesEarsYazma
>>Try to kill 5-6 |cff00ecffspiders|r before you reach the top
.goto 1165,43.63,7.41,0,0
.complete 47520,1 
step
.isOnQuest 47518
#completewith next
.goto 1167,46.31,39.87,10,0
.goto 1167,36.76,25.53,10,0
.goto 1167,44.09,15.00,10,0
.goto 1166,78.67,86.33,10,0
.goto 1165,46.08,15.98,10 >> Climb the pyramid
step
.isOnQuest 47518
>>Kill |cff00ecffCrazzak the Heretic|r
.goto 1165,43.63,7.39
.complete 47518,1 
step
.isQuestComplete 47518
#requires ZuldazarEyesEarsYazma
.goto 1165,43.63,7.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hexlord Raal and Wardruid Loti
.turnin -47518 >>Turn in Raal
.turnin -47520 >>Turn in Walls Have Ears
step
.isQuestTurnedIn 47518
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hexlord Raal
.goto 1165,42.55,9.48
.accept 47521 >>Accept Midnight in the Garden of the Loa
step
.isOnQuest 47521
>>Mount Ata the Winglord
.goto 1165,42.51,10.04
.complete 47521,1 
step
.isQuestTurnedIn 47518
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
.goto 862,50.69,29.66
.turnin 47521 >>Turn in Midnight in the Garden of the Loa
.accept 47522 >>Accept The Hunter
step
.isQuestTurnedIn 47521
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hexlord Raal
.goto 862,50.69,29.57
.accept 47963 >>Accept The Ancient One
step
.isOnQuest 47522
#completewith ZuldazarMistressofLies
>>Click on small Voodoo Piles on the ground and kill every mob you see
.accept 47527 >>Accept Rituals of Heresy (Bonus Objective)
.complete 47527,1 
step
.isOnQuest 47963
>>Kill |cff00ecffShadra Betrayers|r around Pa'ku to rescue him
.goto 862,50.24,30.58,15,0
.goto 862,50.99,32.17,20,0
.goto 862,51.28,31.99,10,0
.goto 862,52.07,33.14
.complete 47963,1 
step
.isOnQuest 47963
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Pa'ku
.goto 862,52.1,33.1
.turnin 47963 >>Turn in The Ancient One
step
.isOnQuest 47522
.goto 862,50.13,33.46,15,0
.goto 862,49.18,32.45,15,0
.goto 862,48.79,31.79
.complete 47522,1 
step
.isQuestTurnedIn 47436
#completewith ZuldazarTheHunter
.goto 862,48.79,32.08
.cast 6478 >>Click the Altar of Pa'ku to gain a movement speed buff
step
.isQuestTurnedIn 47443
#completewith ZuldazarTheHunter
.goto 862,48.59,31.59
.cast 6478 >>Click the Altar of Gonk to gain a passive damage buff
step
#label ZuldazarTheHunter
.isQuestComplete 47522
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gonk
.goto 862,48.4,32.1
.turnin 47522 >>Turn in The Hunter
step
.isQuestTurnedIn 47522
#label ZuldazarMistressofLies
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Acolyte Mali
.goto 862,48.54,31.95
.accept 47528 >>Accept Mistress of Lies
step
.isOnQuest 47527
>>Click on the small Voodoo Piles on the ground and kill every mob you see
.goto 862,48.69,31.21,10,0
.goto 862,48.91,29.76,8,0
.goto 862,49.35,29.46,8,0
.goto 862,49.34,29.08,8,0
.goto 862,47.70,28.85,5,0
.goto 862,49.15,28.39,20,0
.goto 862,48.00,30.44,30,0
.goto 862,49.95,29.84,30,0
.goto 862,49.41,28.39
.complete 47527,1 
step
.isOnQuest 47528
#label ZuldazarVolkaalYazma
.goto 862,47.72,28.85,10,0
.goto 862,47.10,27.79
.complete 47528,1 
.complete 47528,2 
step
.isQuestComplete 47528
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wardruid Loti
*You have to relog if you don't see her
.goto 862,47.92,29.07,15,0
.goto 862,48.57,26.79
.turnin 47528 >>Turn in Mistress of Lies
step
.maxlevel 29
.isQuestTurnedIn 47528
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Beastmother Jabati
.goto 862,47.32,25.13
.accept 49679 >>Accept The Sethrak Incursion
step
.maxlevel 29
.isQuestTurnedIn 47528
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bladeguard Sonji
.goto 862,47.25,24.95
.accept 49678 >>Accept I Spy a Spire
.accept 49680 >>Accept Skycaller Soltok
step
.isOnQuest 49679
#sticky
#label ZuldazarSethrakInvader
>>Kill |cff00ecffSethrak Invaders|r
.goto 862,45.80,23.70,0,0
.complete 49679,1 
step
.isOnQuest 49679
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lil'Tika
.goto 862,46.20,23.35
.accept 49681 >>Accept Lil' Tika
step
.isOnQuest 49681
>>Open the cage
.goto 862,46.20,23.35
.complete 49681,1 
step
.isOnQuest 49678
>>Destroy the Sethrak Spire
.goto 862,46.00,22.78
.complete 49678,1,1 
step
.isOnQuest 49678
>>Destroy the Sethrak Spire
.goto 862,45.62,23.03
.complete 49678,1,2 
step
.isOnQuest 49678
>>Destroy the Sethrak Spire
.goto 862,45.11,24.06
.complete 49678,1,3 
step
.isOnQuest 49678
>>Destroy the Sethrak Spire
.goto 862,44.34,24.49
.complete 49678,1 
step
.isOnQuest 49681
>>Click on Chief Chan'tika on the ground
.goto 862,45.37,26.40
.complete 49681,2 
step
.isOnQuest 49680
>>Kill |cff00ecffSkycaller Soltok|r on the second floor
.goto 862,45.19,25.95,10,0
.goto 862,45.05,26.14,5,0
.goto 862,45.31,26.25
.complete 49680,1 
step
#requires ZuldazarSethrakInvader
.isQuestComplete 49680
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bladeguard Sonji
.goto 862,47.25,24.95
.turnin 49678 >>Turn in I Spy a Spire
.turnin 49680 >>Turn in Skycaller Soltok
step
.isQuestComplete 49679
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Beastmother Jabati
.goto 862,47.33,25.14
.turnin 49679 >>Turn in The Sethrak Incursion
.turnin 49681 >>Turn in Lil' Tika
step
.maxlevel 29
.isQuestTurnedIn 47436
#completewith ZuldazarTheWoundedKing
.goto 862,49.97,26.76
.cast 6478 >>Click on the Altar of Pa'ku to gain a movement speed buff
step
.maxlevel 29
#completewith ZuldazarTheWoundedKing
.goto 862,49.72,26.29
.fly Nesingwary's Gameland, Zuldazar >>Fly to Nesingwary's Gameland, Zuldazar
step
.maxlevel 29
#completewith next
.itemcount 132516,1
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
.maxlevel 29
#label ZuldazarTheWoundedKing
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zolani
.goto 862,70.71,20.31,40,0
.goto 862,76.69,18.98,40,0
.goto 862,76.70,16.28
.turnin 51101 >>Turn in The Wounded King
.accept 51680 >>Accept In Bwonsamdi's Shadow
step
.isOnQuest 51680
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jamil and Jol
.complete 51680,1 
.goto 862,76.47,16.00
.complete 51680,2 
.goto 862,76.45,16.16
.skipgossip 1
.skipgossip 124063,1
step
.isQuestComplete 51680
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jol the Ancient
.goto 862,76.45,16.16
.turnin 51680 >>Turn in In Bwonsamdi's Shadow
.accept 47735 >>Accept Ancient Tortollan Remedies
step
.maxlevel 29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jamil
.goto 862,76.47,16.00
.accept 47739 >>Accept The Scent of Vengeance
step
.maxlevel 29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zolani
.goto 862,76.69,16.25
.accept 50235 >>Accept No Safe Haven
step
.isOnQuest 47735
>>Interact with Laelani
.goto 862,78.59,13.12
.complete 47735,2 
step
.isOnQuest 47739
#sticky
#label ZuldazarTraitorBlood
>>Kill |cff00ecfftrolls|r in the area. Loot them for their blood
.goto 862,78.23,19.48,0,0
.complete 47739,1 
step
.isOnQuest 50235
>>Make sure to free every villager you see
*You can free them while mounted
.goto 862,79.78,13.62,20,0
.goto 862,80.13,13.37,20,0
.goto 862,80.90,14.59,15,0
.goto 862,80.07,16.36
.complete 50235,1 
step
.isOnQuest 47735
>>Pick up the Envenomed Puffer Spine
.goto 862,79.80,16.52
.complete 47735,1 
step
.isOnQuest 47735
.goto 862,79.34,16.77
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zeb'ahari Villager
.accept 47733 >>Accept The Loa-Speaker's Betrayal
step
.isOnQuest 47733
>>Kill |cff00ecffLoa-Speaker Kihara|r
.goto 862,78.51,20.24
.complete 47733,1 
step
.isOnQuest 47735
>>Kill |cff00ecffOl'Bubbly|r. Loot him for his foam
.goto 862,79.50,21.60
.complete 47735,3 
step
.isQuestComplete 50235
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zolani
.goto 862,76.70,16.27
.turnin 50235 >>Turn in No Safe Haven
.turnin 47733 >>Turn in The Loa-Speaker's Betrayal
step
.isQuestComplete 47739
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jamil Abul'housin
.goto 862,76.47,16.01
.turnin 47739 >>Turn in The Scent of Vengeance
step
.isQuestComplete 47735
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jol
.goto 862,76.44,16.16
.turnin 47735 >>Turn in Ancient Tortollan Remedies
step
.maxlevel 29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jol
.goto 862,76.44,16.16
.accept 51677 >>Accept Mending Body and Soul
step
.isOnQuest 51677
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jol
.goto 862,76.47,16.01
.skipgossip 124063,1
.complete 51677,1 
step
.isOnQuest 51677
#label ZuldazarMendingBodyandSoul
>>Every now and then somehting in this room glows, pick it up and talk to Jol to bring it to him
.skipgossip
.goto 862,76.47,16.01
.complete 51677,2 
step
.isQuestComplete 51677
>>Wait for the roleplay to finish and return to Jol the Ancient
.goto 862,76.45,16.16
.turnin 51677 >>Turn in Mending Body and Soul
step
.maxlevel 29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jamil
.goto 862,76.47,16.00
.accept 47738 >>Accept The Will of the Loa
step
.isOnQuest 47738
>>Place the Idol
.goto 862,76.87,13.23
.complete 47738,1 
step
.isOnQuest 47738
>>Wait for the roleplay to finish and talk to Rezan
.goto 862,77.01,13.24
.skipgossip
.complete 47738,2 
step
.isOnQuest 47738
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tWait for the roleplay to finish and pick up Rastakhan's soul
.goto 862,76.87,13.23
.complete 47738,3 
step
.isOnQuest 47738
>>You have to wait a moment and then interact with Rastakhan's body
.goto 862,76.46,16.06
.complete 47738,4 
step
.isQuestComplete 47738
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tWait for the roleplay to finish and talk to King Rastakhan and Zolani
.goto 862,76.65,16.14
.turnin 47738 >>Turn in The Will of the Loa
step
.maxlevel 29
>>Wait for the roleplay to finish and talk to King Rastakhan and Zolani
.goto 862,76.65,16.14
.accept 47742 >>Accept Zul's Mutiny
.accept 51678 >>Accept Rastakhan's Might
.accept 51679 >>Accept A Strange Port of Call
step
.isOnQuest 47742
#completewith next
.goto 862,78.99,19.13
.vehicle 139838 >>Mount the Fishing Canoe
step
.isOnQuest 47742
#completewith ZuldazarSkullUlajan
*When the boat is on front of the ship you have to dismount manually otherwise it will bring you back to the coast
+Interact with the Ropes to enter the ship
step
.isOnQuest 47742
#completewith ZuldazarChroniclerTokini
>>Kill |cff00ecffMutinous Zandalari|r
.complete 47742,1 
step
.isOnQuest 51678
#label ZuldazarSkullUlajan
>>|cfff78300Go up the stairs|r. Kill |cff00ecffUla'jan|r. Loot him for his skull
.goto 862,81.27,19.59
.complete 51678,1 
step
.isOnQuest 51679
#completewith next
.goto 862,81.16,20.48,10 >> Follow the arrow down
step
.isOnQuest 51679
>>Interact with the Temple of Rezan Map
.goto 862,81.27,19.74
.complete 51679,1 
step
.isOnQuest 51679
>>|cfff78300Go down the stairs into the ship|r
.goto 1173,51.36,75.07
.complete 51679,2 
step
.isOnQuest 51679
#label ZuldazarChroniclerTokini
>>|cfff78300Go down the stairs one more time|r and interact with Chronicler To'kini
.goto 1174,43.58,81.73,5,0
.goto 1174,48.20,41.48
.complete 51679,3 
step
.isOnQuest 47742
>>Kill |cff00ecffMutinous Zandalari|r
.waypoint 862,81.14,20.55,-30,0
.complete 47742,1 
step << Warlock/Hunter
.isQuestComplete 47742
#completewith next
+|cfff78300Set your pet to passive by clicking on 'Passive' in your pet bar or in your spell book in the Pet tab|r
step
.isQuestComplete 47742
#completewith next
.waypoint 862,81.14,20.55,-30,0
.deathskip >> Die on the ship and resurrect at the spirit healer
step << Warlock/Hunter
.isQuestComplete 47742
#completewith next
+|cfff78300Reminder:Set your pet to back to 'Assist'|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to King Rastakhan
.goto 862,76.67,16.13
.turnin -47742 >>Turn in Zul's Mutiny
.turnin -51678 >>Turn in Rastakhan's Might
.turnin -51679 >>Turn in A Strange Port of Call
step
.isQuestTurnedIn 51679
.maxlevel 29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to King Rastakhan
.goto 862,76.67,16.13
.accept 47737 >>Accept The Temple of Rezan
step
.isOnQuest 47737
#completewith ZuldazarTheTempleofRezan
>>Repair your gear
.goto 862,77.12,16.63
.vendor
step
.isOnQuest 47737
#requires ZuldazarVendor1
.itemcount 132516,1
#completwith ZuldazarTheTempleofRezan
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
.isOnQuest 47737
#label ZuldazarTheTempleofRezan
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to King Rastakhan
.goto 862,72.03,21.04
.turnin 47737 >>Turn in The Temple of Rezan
step
.maxlevel 29
#requires ZuldazarTheTempleofRezan
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to King Rastakhan
.goto 862,72.03,21.04
.accept 47740 >>Accept House of the King
step
.isOnQuest 47740
#completewith ZuldazarHouseoftheKing
*|cfff78300Free Priests of Rezan and open the Training Gates|r
.goto 862,72.95,23.78,0
.goto 862,73.42,23.00,0
.goto 862,73.56,22.79,0
.goto 862,73.77,22.37,0
.goto 862,74.07,22.58,0
.goto 862,73.87,23.39,0
.goto 862,73.60,23.77,0
.goto 862,73.37,24.03,0
.goto 862,71.74,24.19,0
.goto 862,71.56,24.66,0
.goto 862,71.83,24.78,0
.goto 862,73.35,25.28,0
.goto 862,73.15,25.64,0
.goto 862,72.62,25.76,0
.goto 862,74.37,23.93,0
.goto 862,72.16,23.92,0,0
.accept 47797 >>Accept Occupation Hazard (Bonus Objective)
.complete 47797,1 
step
.isOnQuest 47736
#completewith ZuldazarHouseoftheKing
>>Kill |cff00ecffZanadalaris|r. Loot them for their head
.complete 47736,1 
step
.isOnQuest 47740
>>Destroy the Corrupting Totems around the waypoint
.goto 862,72.16,23.92
.complete 47740,1 
step
.isOnQuest 47740
>>Destroy the Corrupting Totems around the waypoint
.goto 862,73.91,22.83
.complete 47740,3 
step
.isOnQuest 47740
#label ZuldazarHouseoftheKing
>>Destroy the Corrupting Totems around the waypoint
.goto 862,73.36,24.05,15,0
.goto 862,73.11,24.44,15,0
.goto 862,73.79,25.89
.complete 47740,2 
step
#sticky
#label ZuldazarOccupationHazard
.isOnQuest 47736
>>Kill |cff00ecffZanadalaris|r. Loot them for their head
.goto 862,72.16,23.92,0,0
.complete 47736,1 
step
.isOnQuest 47740
#completewith ZuldazarHouseoftheKing
*|cfff78300Free Priests of Rezan and open the Training Gates|r
.goto 862,73.62,26.34,20,0
.goto 862,72.62,25.65,20,0
.goto 862,71.62,24.64,20,0
.goto 862,72.56,24.48,20,0
.goto 862,72.94,23.78,20,0
.goto 862,73.76,22.34,20,0
.goto 862,73.91,23.34,20,0
.goto 862,72.95,24.22,20,0
.goto 862,73.69,25.29
.accept 47797 >>Accept Occupation Hazard (Bonus Objective)
.complete 47797,1 
step
#requires ZuldazarOccupationHazard
.goto 862,74.84,24.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zolani
.turnin -47736 >>Turn in Heads Will Roll
.turnin -47740 >>Turn in House of the King
step
.maxlevel 29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Zolani
.goto 862,74.84,24.91
.accept 47734 >>Accept Partners in Heresy
step
.isOnQuest 47734
>>Kill |cff00ecffDarkweaver Ji'tan|r
.goto 862,75.16,23.24
.complete 47734,1 
step
.isOnQuest 47734
>>Kill |cff00ecffSoulrender Gao'tan|r
.goto 862,75.12,26.41
.complete 47734,2 
step
.isQuestTurnedIn 47736
.goto 862,74.87,24.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to King Rastakhan
.turnin 47734 >>Turn in Partners in Heresy
.accept 47741 >>Accept To Sacrifice a Loa
step
.isOnQuest 47741
>>Wait until Vilnak'dor has no more stacks of his buff Stolen Power and then kill him.
*Run away during Blood Nova
.goto 862,76.01,24.91
.complete 47741,1 
step
.isOnQuest 47741
>>Wait for the roleplay
.goto 862,75.96,24.91
.complete 47741,2 
step
.isOnQuest 47741
>>Follow the arrow
.goto 862,73.60,28.19
.complete 47741,3 
step
.isQuestTurnedIn 47734
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rezan and King Rastakhan
.turnin 47741 >>Turn in To Sacrifice a Loa
.goto 862,70.91,29.89
.accept 51111 >>Accept King or Prey
.goto 862,70.98,29.91
step
.isOnQuest 51111
#completewith next
.goto 862,70.79,29.60
.fp >>Get the Scaletrader Post Flight Path
step
#completewith next
.goto 862,70.79,29.60,-1
.goto 862,54.26,56.52,-1
.goto 862,49.65,26.50,-1
.goto 862,66.10,18.12,-1
.fly The Great Seal >>Fly to The Great Seal
step
.isOnQuest 51111
.goto 1164,41.26,71.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Baine Bloodhoof
.turnin 51111 >>Turn in King or Prey
step
.goto 1163,53.39,70.58,10,0
.goto 1163,73.83,69.92
.zone 85 >>Take the portal to Orgrimmar
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Horde 10-60
#name 4 Horde Zuldazar Second Half
#displayname Chapter 6 - Zuldazar End
#maxlevel 60
#fresh
<< Horde
step
.goto 1165,44.35,39.55,15,0
.goto 1165,44.03,39.61
>>Talk to Myxle
.accept 51465 >>Accept A Load of Scrap
step
>>Click the Shred-Master Mk1
*Put the Tattered Pants from your inventory into the Shred-Master Mk1 and press the 'Scrap' Button
.goto 1165,45.04,40.05
.complete 51465,1 
step
>>Talk to Myxle
.goto 1165,45.03,39.61
.turnin 51465 >>Turn in A Load of Scrap
step
#label WantedQuests

.goto 1165,41.93,40.74,10,0
.goto 1165,41.27,40.58,5,0
.goto 862,54.94,42.00,5,0
.goto 862,54.58,41.60,15 >>Mount up and jump into the water
.goto 862,53.46,42.25,8 >>Climb the mountain by Right-Clicking the Ropes
.goto 862,51.62,45.45
>>Right-Click the WANTED board
>>You can skip WANTED: Sabertusk Empress
.accept 51071 >>Accept WANTED: Sabertusk Empress -> SEMI HARD elite, shouldn't be too hard to kill
.accept 51072 >>Accept WANTED: Prime Thumpknuckle -> VERY HARD elite, only try it if you know what to do and/or use heirlooms
step
.isOnQuest 51071
.goto 862,52.69,45.05
.complete 51072,1 
step
.isOnQuest 51071
>>VERY HARD elite, only try it if you know what to do and/or are using heirlooms
*Even with heirlooms this elite can be very difficult depending on your class
.goto 862,52.36,47.76
.complete 51071,1 
step
.isQuestComplete 51071
>>Talk to Shaz'ki
.goto 862,51.65,50.53
.turnin 51071 >>Turn in WANTED: Sabertusk Empress
step
.isQuestComplete 51072
>>Talk to Saz'ki
.goto 862,51.65,50.53
.turnin 51072 >>Turn in WANTED: Prime Thumpknuckle
step
#completewith ZuldazarPeaceLovingGorillas
.complete 49918,1 
step
>>Talk to Tsunga
.goto 862,51.51,53.77,15,0
.goto 862,50.17,54.57
.accept 49920 >>Accept Gorilla Warfare
step
#completewith ZuldazarDakaniGorillas
+Pick up (Right-Click) a Kaja'mite Chunk for a damage buff
step
>>Right-Click the Cages to release the Gorillas
.goto 862,49.95,54.94
.complete 49920,1,1 
step
>>Right-Click the Cages to release the Gorillas
.goto 862,49.56,55.26
.complete 49920,1,2 
step
>>Right-Click the Cages to release the Gorillas
.goto 862,49.03,54.79
.complete 49920,1,3 
step
>>Right-Click the Cages to release the Gorillas
.goto 862,48.63,53.91
.complete 49920,1,4 
step
#completewith next
+You can kill the rare Zayoos if you want. He drops a pretty good trinket and counts for the bonus objective
step
>>Right-Click the Cages to release the Gorillas
.goto 862,48.14,53.16
.complete 49920,1,5 
step
#label ZuldazarPeaceLovingGorillas
>>Right-Click the Cages to release the Gorillas
.goto 862,48.09,51.24
.complete 49920,1 
step
#label ZuldazarDakaniGorillas
.waypoint 862,48.93,54.52,-25,0
.complete 49918,1 
step
>>Talk to Tsunga
.goto 862,47.42,52.43
.turnin 49920 >>Turn in Gorilla Warfare
step
>>Talk to Zolani
.goto 862,47.92,60.45
.turnin 49122 >>Turn in A Port in Peril
.accept 49144 >>Accept Wrath of the Zandalari
step
>>Talk to Habutu
.goto 862,47.86,60.45
.accept 49145 >>Accept No Troll Left Behind
step
>>Talk to Kaza'Jin
.goto 862,47.13,60.47
.accept 49146 >>Accept Spirit's Belongings
step
#completewith ZuldazarGrimoireoftheOtherSide
.complete 49144,1 
step
#title Rally Rastair Defenders
>>Use the Rastari Skull Whistle near Rastari Defenders to rally them
.goto 862,46.80,60.66
.use 153524
.complete 49145,1,2 
step
#title Rally Rastair Defenders
>>Use the Rastari Skull Whistle near Rastari Defenders to rally them
.goto 862,46.34,60.17
.use 153524
.complete 49145,1,5 
step
#title Reclaimed Bijous
.goto 862,45.61,60.38
.complete 49146,1 
step
#title Rally Rastair Defenders
>>Use the Rastari Skull Whistle near Rastari Defenders to rally them
.goto 862,45.61,60.38
.use 153524
.complete 49145,1,7 
step
#title Rally Rastair Defenders
>>Use the Rastari Skull Whistle near Rastari Defenders to rally them
.goto 862,45.30,60.91
.use 153524
.complete 49145,1,12 
step
#title Venerated Remains
>>Right-Click the Venerated Remains
.goto 862,45.30,60.91,10,0
.goto 862,45.81,62.45
.complete 49146,3 
step
#label ZuldazarGrimoireoftheOtherSide
#title Grimoire of the Other Side
>>Jump down and Right-Click the Grimoire of the Other Side
.goto 862,46.80,61.90
.complete 49146,2 
step
.goto 862,46.45,60.75
.waypoint 862,46.45,60.80,-30,0
.complete 49144,1 
step
>>Return to Habutu
.goto 862,47.87,60.44
.turnin 49145 >>Turn in No Troll Left Behind
step
>>Return to Zalani
.goto 862,47.92,60.45
.turnin 49144 >>Turn in Wrath of the Zandalari
step
>>Return to Kaza'jin
.goto 862,48.08,60.37
.turnin 49146 >>Turn in Spirits' Belongings
.accept 49149 >>Accept Embrace the Voodoo
step
>>Talk to Zalani
.goto 862,47.92,60.45
.accept 49148 >>Accept Crumbling Apart
step
>>Talk to Habutu
.goto 862,47.87,60.44
.accept 49147 >>Accept Show of Strength
step
#completewith ZuldazarBlueRunesTurnin
+Standing in the blue runes on the ground gives you 100% crit chance
step
#completewith ZuldazarSpiritObelisksactivated
.complete 49148,1 
step
>>Right-Click the Spirit Obelisk
.goto 862,47.22,61.86
.complete 49149,1,1 
step
>>Right-Click the Spirit Obelisk
.goto 862,47.97,63.06
.complete 49149,1,2 
step
.goto 862,48.15,64.48
.complete 49147,1 
step
>>Right-Click the Spirit Obelisk
.goto 862,47.45,65.14
.complete 49149,1,3 
step
>>Right-Click the Spirit Obelisk
.goto 862,47.86,67.24,10,0
.goto 862,47.38,66.92,5,0
.goto 862,47.48,66.76
.complete 49149,1,4 
step
.goto 862,45.83,66.51
.complete 49147,2 
step
#label ZuldazarSpiritObelisksactivated
>>Right-Click the Spirit Obelisk
.goto 862,47.26,66.11,10,0
.goto 862,48.18,65.42,10,0
.goto 862,48.55,64.51
.complete 49149,1 
step
>>Finish this quests
.waypoint 862,48.69,64.62,-50,0
.complete 49148,1 
step
#label ZuldazarBlueRunesTurnin
>>Talk to Kaza'jin
.goto 862,49.59,64.48
.turnin 49149 >>Turn in Embrace the Voodoo
.turnin 49147 >>Turn in Show of Strength
.turnin 49148 >>Turn in Crumbling Apart
.accept 49309 >>Accept Thunder's Fall
step
>>Kill Warlord Kao on the ship
.goto 862,50.19,65.38
.complete 49309,1 
step
>>Return to Kaza'jin
.goto 862,49.59,64.48
.turnin 49309 >>Turn in Thunder's Fall
.accept 49310 >>Accept The Prophet's Ploy
step
>>Right-Click Scarbeak
.goto 862,49.51,64.34
.complete 49310,1 
step
>>Talk to Baine
.goto 1164,41.33,72.25
.turnin 49310 >>Turn in The Prophet's Play
.accept 47509 >>Accept Terrace of the Chosen
step
.isQuestTurnedIn 47436
#completewith ZuldazarTerraceoftheChosen
.goto 1165,49.92,33.18
.cast 6478 >>Click the Altar of Pa'ku to gain a movement speed buff
step
.isQuestTurnedIn 47443
#completewith ZuldazarTerraceoftheChosen
.goto 1165,49.92,33.18
.cast 6478 >>Click the Altar of Gonk to gain a passive damage buff
step
>>Talk to B'wizati
.goto 1165,40.28,19.27
.turnin 49040 >>Turn in Fond Farewells
step
#label ZuldazarTerraceoftheChosen
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kaza'jin
.goto 1165,42.30,26.63,20,0
.goto 1165,42.6,21.4
.turnin 47509 >>Turn in Terrace of the Chosen
.accept 47897 >>Accept Zanchuli Traitors
.accept 47915 >>Accept Rescuing the Taken
step
#completewith next
.complete 47897,1 
step
>>Kill and LOOT Hexmother Kala
.goto 1165,41.42,18.84,8,0
.goto 1165,43.51,17.71
.complete 47915,1 
step
>>Finish this quest
.waypoint 1165,41.66,17.10,-70,0
.complete 47897,1 
step
>>Talk to Wardruid Loti
.goto 1165,39.3,13.7
.turnin 47897 >>Turn in Zanchuli Traitors
.turnin 47915 >>Turn in Rescuing the Taken
.accept 47518 >>Accept Raal
.accept 47520 >>Accept Walls Have Ears
step
#sticky
#label ZuldazarEyesEarsYazma
>>Try to kill 5-6 spider before you reach the top
.complete 47520,1 
step
>>Climb the pyramide
.goto 1167,46.31,39.87,10,0
.goto 1167,36.76,25.53,10,0
.goto 1167,44.09,15.00,10,0
.goto 1166,78.67,86.33,10,0
.goto 1165,46.08,15.98,10,0
.goto 1165,43.63,7.39
.complete 47518,1 
step
#requires ZuldazarEyesEarsYazma
.goto 1165,43.63,7.39
>>Talk to Hexlord Raal and Wardruid Loti
.turnin 47518 >>Turn in Raal
.turnin 47520 >>Turn in Walls Have Ears
step
>>Talk to Hexlord Raal
.goto 1165,42.55,9.48
.accept 47521 >>Accept Midnight in the Garden of the Loa
step
>>Right-Click Ata the Winglord
.goto 1165,42.51,10.04
.complete 47521,1 
step
>>Talk to Wardruid Loti
.goto 862,50.69,29.66
.turnin 47521 >>Turn in Midnight in the Garden of the Loa
.accept 47527 >>Accept Rituals of Heresy
.accept 47522 >>Accept The Hunter
step
>>Talk to Hexlord Raal
.goto 862,50.69,29.57
.accept 47963 >>Accept The Ancient One
step
#completewith ZuldazarMistressofLies
>>Right-Click small Voodoo Piles on the ground and kill every mob you see
.complete 47527,1 
step
>>Kill Shadra Betrayers around Pa'ku to rescue him
.goto 862,50.24,30.58,15,0
.goto 862,50.99,32.17,20,0
.goto 862,51.28,31.99,10,0
.goto 862,52.07,33.14
.complete 47963,1 
step
>>Talk to Pa'ku
.goto 862,52.1,33.1
.turnin 47963 >>Turn in The Ancient One
step
.goto 862,49.18,32.45,15,0
.goto 862,48.79,31.79
.complete 47522,1 
step
.isQuestTurnedIn 47436
#completewith ZuldazarTheHunter
.goto 862,48.79,32.08
.cast 6478 >>Click the Altar of Pa'ku to gain a movement speed buff
step
.isQuestTurnedIn 47443
#completewith ZuldazarTheHunter
.goto 862,48.59,31.59
.cast 6478 >>Click the Altar of Gonk to gain a passive damage buff
step
#label ZuldazarTheHunter
.isQuestComplete 47522
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gonk
.goto 862,48.4,32.1
.turnin 47522 >>Turn in The Hunter
step
#label ZuldazarMistressofLies
>>Talk to Acolyte Mali
.goto 862,48.54,31.95
.accept 47528 >>Accept Mistress of Lies
step
>>Right-Click small Voodoo Piles on the ground and kill every mob you see
.goto 862,48.69,31.21,10,0
.goto 862,48.91,29.76,8,0
.goto 862,49.35,29.46,8,0
.goto 862,49.34,29.08,8,0
.goto 862,47.70,28.85,5,0
.goto 862,49.15,28.39
.complete 47527,1 
step
#label ZuldazarVolkaalYazma
.goto 862,47.10,27.79
.complete 47528,1 
.complete 47528,2 
step
>>Talk to Wardruid Loti
*You have to relog if you don't see her
.goto 862,47.92,29.07,15,0
.goto 862,48.57,26.79
.turnin 47528 >>Turn in Mistress of Lies
step
>>Talk to Beastmother Jabati
.goto 862,47.32,25.13
.accept 49679 >>Accept The Sethrak Incursion
step
>>Talk to Bladeguard Sonji
.goto 862,47.25,24.95
.accept 49678 >>Accept I Spy a Spire
.accept 49680 >>Accept Skycaller Soltok
step
#sticky
#label ZuldazarSethrakInvader
.complete 49679,1 
step
>>Talk to Lil'Tika
.goto 862,46.20,23.35
.accept 49681 >>Accept Lil' Tika
step
>>Right-Click the cage
.goto 862,46.20,23.35
.complete 49681,1 
step
>>Right-Click the Sethrak Spire
.goto 862,46.00,22.78
.complete 49678,1,1 
step
>>Right-Click the Sethrak Spire
.goto 862,45.62,23.03
.complete 49678,1,2 
step
>>Right-Click the Sethrak Spire
.goto 862,45.11,24.06
.complete 49678,1,3 
step
>>Right-Click the Sethrak Spire
.goto 862,44.34,24.49
.complete 49678,1 
step
>>Right-Click Chief Chan'tika on the ground
.goto 862,45.37,26.40
.complete 49681,2 
step
.goto 862,45.19,25.95,10,0
.goto 862,45.05,26.14,5,0
.goto 862,45.31,26.25
.complete 49680,1 
step
>>Return to Bladeguard Sonji
.goto 862,47.25,24.95
.turnin 49678 >>Turn in I Spy a Spire
.turnin 49680 >>Turn in Skycaller Soltok
step
>>Return to Beastmother Jabati
.goto 862,47.33,25.14
.turnin 49679 >>Turn in The Sethrak Incursion
.turnin 49681 >>Turn in Lil' Tika
step
#completewith next
.isQuestTurnedIn 47436
.goto 862,49.97,26.76
.cast 6478 >>Right-Click the Altar of Pa'ku to gain a movement speed buff
step
#completewith next
.goto 862,49.73,26.33
.fp >>Get the Garden of the Loa Flight Path
step
#completewith next
.goto 862,49.72,26.29
.fly Nesingwary's Gameland >>Fly to Nesingwary's Gameland
step
>>Talk to Zolani
.goto 862,76.70,16.28
.turnin 51101 >>Turn in The Wounded King
.accept 51680 >>Accept In Bwonsamdi's Shadow
step
>>When you talk to Jol you have to manually select the 1st gossip option
.complete 51680,1 
.goto 862,76.47,16.00
.complete 51680,2 
.goto 862,76.45,16.16
step
>>Talk to Jol the Ancient
.goto 862,76.45,16.16
.turnin 51680 >>Turn in In Bwonsamdi's Shadow
.accept 47735 >>Accept Ancient Tortollan Remedies
step
>>Talk to Jamil
.goto 862,76.47,16.00
.accept 47739 >>Accept The Scent of Vengeance
step
>>Talk to Zolani
.goto 862,76.69,16.25
.accept 50235 >>Accept No Safe Haven
step
>>Interact (Right-Click) with Laelani
.goto 862,78.59,13.12
.complete 47735,2 
step
#sticky
#label ZuldazarTraitorBlood
>>Kill and LOOT the trolls
.goto 862,78.23,19.48,0,0
.complete 47739,1 
step
>>Make sure to free every villager you see
*You can free them while mounted
.goto 862,80.48,13.98,10,0
.goto 862,80.07,16.36
.complete 50235,1 
step
.goto 862,79.80,16.52
.complete 47735,1 
step
.goto 862,79.34,16.77
>>Talk to Zeb'ahari Villager
.accept 47733 >>Accept The Loa-Speaker's Betrayal
step
.goto 862,78.51,20.24
.complete 47733,1 
step
>>Kill and LOOT Ol'Bubbly
.goto 862,79.50,21.60
.complete 47735,3 
step
>>Return to Zolani
.goto 862,76.70,16.27
.turnin 50235 >>Turn in No Safe Haven
.turnin 47733 >>Turn in The Loa-Speaker's Betrayal
step
>>Return to Jamil Abul'housin
.goto 862,76.47,16.01
.turnin 47739 >>Turn in The Scent of Vengeance
step
>>Return to Jol
.goto 862,76.44,16.16
.turnin 47735 >>Turn in Ancient Tortollan Remedies
.accept 51677 >>Accept Mending Body and Soul
step
>>Talk to Jol and select the 1st gossip option
.goto 862,76.47,16.01
.skipgossip
.complete 51677,1 
step
>>Every now and then somehting in this room glows, pick it up (Right-Click) and talk to Jol to bring it to him
.goto 862,76.47,16.01
.skipgossip
.complete 51677,2 
step
>>Wait for the roleplay to finish and return to Jol the Ancient
.goto 862,76.45,16.16
.turnin 51677 >>Turn in Mending Body and Soul
step
>>Talk to Jamil
.goto 862,76.47,16.00
.accept 47738 >>Accept The Will of the Loa
step
.goto 862,76.87,13.23
.complete 47738,1 
step
>>Wait for the roleplay to finish and talk to Rezan
.goto 862,77.01,13.24
.skipgossip
.complete 47738,2 
step
>>Wait for the roleplay to finish and pick up (Right-Click) Rastakhan's soul
.goto 862,76.87,13.23
.complete 47738,3 
step
>>You have to wait a moment and then interact (Right-Click) with Rastakhan's body
.goto 862,76.46,16.06
.complete 47738,4 
step
>>Wait for the roleplay to finish and talk to King Rastakhan and Zolani
.goto 862,76.65,16.14
.turnin 47738 >>Turn in The Will of the Loa
.accept 47742 >>Accept Zul's Mutiny
.accept 51678 >>Accept Rastakhan's Might
.accept 51679 >>Accept A Strange Port of Call
step
#completewith next
>>Mount (Right-Click) the Fishing Canoe
*When the boat is on front of the ship you have to dismount manually otherwise it will bring you back to the coast
.goto 862,78.99,19.13
.vehicle 139838
step
#sticky
+Interact (Right-Click) with the Ropes to enter the ship
step
#completewith ZuldazarChroniclerTokini
.complete 47742,1 
step
>>Kill and LOOT Ula'jan at the top of stairs
.goto 862,81.27,19.59
.complete 51678,1 
step
>>Interact (Right-Click) with the Temple of Rezan Map
.goto 862,81.16,20.48,10,0
.goto 862,81.27,19.74
.complete 51679,1 
step
>>Go down the stairs
.goto 1173,51.36,75.07
.complete 51679,2 
step
#label ZuldazarChroniclerTokini
>>Go down the stairs one more time and interact (Right-Click) with Chronicler To'kini
.goto 1174,43.58,81.73,5,0
.goto 1174,48.20,41.48
.complete 51679,3 
step
.waypoint 862,81.14,20.55,-30,0
.complete 47742,1 
step
>>Return to King Rastakhan
.goto 862,76.67,16.13
.turnin 47742 >>Turn in Zul's Mutiny
.turnin 51678 >>Turn in Rastakhan's Might
.turnin 51679 >>Turn in A Strange Port of Call
.accept 47737 >>Accept The Temple of Rezan
step
.goto 862,72.03,21.04
.turnin 47737 >>Turn in The Temple of Rezan
.accept 47740 >>Accept House of the King
step
#sticky
*Make sure to interact (Right-Click) with anything that you can find around the waypoint positions of this step
.goto 862,72.95,23.78,0
.goto 862,73.42,23.00,0
.goto 862,73.56,22.79,0
.goto 862,73.77,22.37,0
.goto 862,74.07,22.58,0
.goto 862,73.87,23.39,0
.goto 862,73.60,23.77,0
.goto 862,73.37,24.03,0
.goto 862,71.74,24.19,0
.goto 862,71.56,24.66,0
.goto 862,71.83,24.78,0
.goto 862,73.35,25.28,0
.goto 862,73.15,25.64,0
.goto 862,72.62,25.76,0
.goto 862,74.37,23.93,0
.complete 47797,1 
step
#sticky
#label ZuldazarTraitorousZandalariHead
>>Kill and LOOT Zanchuli mobs
.complete 47736,1 
step
>>Destroy (Right-Click) the Corrupting Totems around the waypoint
.goto 862,72.16,23.92
.complete 47740,1 
step
>>Destroy (Right-Click) the Corrupting Totems around the waypoint
.goto 862,73.91,22.83
.complete 47740,3 
step
>>Destroy (Right-Click) the Corrupting Totems around the waypoint
.goto 862,73.79,25.89
.complete 47740,2 
step
#requires ZuldazarTraitorousZandalariHead
.goto 862,74.84,24.91
>>Return to Zolani
.turnin 47736 >>Turn in Heads Will Roll
.turnin 47740 >>Turn in House of the King
.accept 47734 >>Accept Partners in Heresy
step
.goto 862,75.16,23.24
.complete 47734,1 
step
.goto 862,75.12,26.41
.complete 47734,2 
step
.goto 862,74.87,24.95
>>Return to King Rastakhan
.turnin 47734 >>Turn in Partners in Heresy
.accept 47741 >>Accept To Sacrifice a Loa
step
.goto 862,76.01,24.91
.complete 47741,1 
.complete 47741,2 
step
.goto 862,73.60,28.19
.complete 47741,3 
step
>>Return to Rezan
.goto 862,70.91,29.89
.turnin 47741 >>Turn in To Sacrifice a Loa
.accept 51111 >>Accept King or Prey
step
.goto 862,70.79,29.60
.fp >>Get the Scaletrader Post Flight Path
step
.goto 862,70.79,29.60
.fly The Great Seal >>Fly to The Great Seal
step
.goto 1164,41.26,71.88
>>Return to Baine Bloodhoof
.turnin 51111 >>Turn in King or Prey
.accept 52210 >>Accept Sending Out An SOS
.accept 49421 >>Accept Hunting Zul
step
.goto 1165,38.92,27.14
>>Return to King Rastakhan
.turnin 49421 >>Turn in Hunting Zul
.accept 49965 >>Accept The Warpack
step
.goto 862,49.19,44.79
.complete 49965,1 
step
.goto 862,49.27,44.36
>>Return to Gonk
.turnin 49965 >>Turn in The Warpack
.accept 49422 >>Accept Heretics
.accept 49424 >>Accept The Full Prophecy
step
#completewith ZuldazarWordofZulI
.complete 49422,1 
step
>>Interact (Right-Click) with The Word of Zul
.goto 862,48.81,42.75
.complete 49424,3 
step
>>Interact (Right-Click) with The Word of Zul
.goto 862,49.01,40.65
.complete 49424,2 
step
#label ZuldazarWordofZulI
>>Interact (Right-Click) with The Word of Zul
.goto 862,48.93,39.43
.complete 49424,1 
step
.waypoint 862,48.93,39.43,-20,0
.complete 49422,1 
step
.goto 862,48.82,39.42
>>Return to Wardruid Loti
.turnin 49424 >>Turn in The Full Prophecy
step
>>Return to Hexlord Raal
.turnin 49422 >>Turn in Heretics
.accept 49425 >>Accept City of Gold
step
>>Mount (Right-Click) Ata the Winglord
.goto 862,49.65,37.98
.complete 49425,1 
step
>>Use your abilities to kill the Forces below you
.goto 862,45.99,36.82
.complete 49425,2 
step
.goto 862,43.73,39.43
>>Return to Rezan
.turnin 49425 >>Turn in City of Gold
.accept 49426 >>Accept The King's Gambit
step
>>You can skip the cinematic by pressing ESC
.goto 862,42.18,39.47
.complete 49426,1 
.complete 49426,2 
step
.goto 862,42.71,37.61
.complete 49426,3 
step
.goto 862,42.72,37.65
>>Return to King Rastakhan
.turnin 49426 >>Turn in The King's Gambit
.accept 49901 >>Accept Atal'Dazar: Yazma the Fallen Priestess
.accept 50963 >>Accept Of Dark Deeds and Dark Days
step
.goto 862,46.14,35.85
.fp >>Get the The Golden Road Flight Path
step
.goto 1165,51.87,41.28
.fly Port of Zandalar >>Fly to Port of Zandalar
step
.goto 1165,46.12,94.55
>>Return to Captain Grez'ko
.turnin 52210 >>Turn in Sending Out An SOS
.accept 49758 >>Accept Send the Signal!
step
>>Mount (Right-Click) the Fleet Scout
.goto 1165,46.39,94.63
.complete 49758,1 
step
>>Talk to Bo'tzun Maset
.goto 862,54.42,87.00
.turnin 49758 >>Turn in Send the Signal!
.accept 49775 >>Accept Key to the Brig
step
>>Kill and LOOT Quartermaster Garza
.goto 862,52.34,86.71,8,0
.goto 862,52.26,86.94,5,0
.goto 862,51.58,86.88
.complete 49775,1 
step
>>Go downstairs and talk to Wavemaster Lanfa
.goto 1176,28.31,33.97,5,0
.goto 1176,44.02,50.83
.turnin 49775 >>Turn in Key to the Brig
.accept 49754 >>Accept Not "Only Zul
step
#sticky
#label ZuldazarSpoilsofPandaria
*Go down one more time and loot the Spoils of Pandaria for some extra experience
.turnin 49936 >>Loot the Spoils of Pandaria
step
.waypoint 1176,44.09,50.84,-25,0
.complete 49754,1 
step
#requires ZuldazarSpoilsofPandaria
.goto 862,54.38,87.02
>>Return to Wavemaster Lanfa
.turnin 49754 >>Turn in Not "Only Zul"
.accept 49871 >>Accept Against the Tide
step
*Walk as far to the edge as possible and ignore every mob you pull
.goto 862,53.89,87.58,8,0
.goto 862,54.70,89.41,8,0
.goto 862,54.58,90.20
.complete 49871,1 
step
>>Use the Empowered Fire Mojo
.goto 862,54.58,90.20
.use 156473
.complete 49871,2 
step
>>Talk to Captain Grez'ko
.goto 862,54.70,89.71
.turnin 49871 >>Turn in Against the Tide
.accept 49785 >>Accept Destroy the Weapon
step
#completewith next
.goto 862,54.70,89.71
.vehicle 130759 >>Mount the Pterrodax
step
.goto 862,58.28,76.96,15,0
.goto 862,58.01,76.69
.complete 49785,1 
step
.goto 862,57.45,75.58
.complete 49785,2 
step
>>Return to Captain Grez'ko
.goto 862,57.81,76.65
.turnin 49785 >>Turn in Destroy the Weapon
.accept 49884 >>Accept Hope's Blue Light
step
#completewith next
.goto 862,57.81,76.65
.vehicle 131271 >>Mount the Pterrodax
step
>>Use Ignite (1) near the tower
.complete 49884,1 
step
.goto 1165,44.49,95.44
>>Return to Captain Rez'okun
.turnin 49884 >>Turn in Hope's Blue Light
step
.goto 862,46.17,35.82
.fly The Great Seal >>Fly to The Great Seal
step
.goto 1164,40.94,66.80
>>Return to Princess Talanji
.turnin 50963 >>Turn in Of Dark Deeds and Dark Days
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Horde 10-60
#name 4 Horde Silverpine Forest
#displayname Chapter 5 - Silverpine Forest
#next 5 Horde Hillsbrad Foothills
#veteran
<< Horde
step
.xp <30,1
#completewith next
#title Active War Mode. Skip if you don't want to.
+Skip if you don't want to activate War Mode (Bottom Right on your Talent Window (N)) even though it increases your experience gain by at least 10%
step
.xp <30,1
#completewith LearnExpertRiding1
.goto 85,53.17,90.47,10,0
.goto 85,50.81,63.46,10,0
.goto 85,51.20,63.06,6,0
.goto 85,50.23,60.96,10 >>Take the elevator
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Maztha
.goto 85,48.91,59.26
.turnin 32674 >>Turn in I Believe You Can Fly
step
.xp <30,1
#label LearnExpertRiding1
.goto 85,48.91,59.26
.skill riding,225 >>Train Expert Riding
step
#completewith next
+|cfff78300Drag a flying mount to your bars|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Chromie and select the campaign "The Iron Horde"
.goto 85,40.81,80.08
.accept 60968 >>Accept Warlords of Draenor: Onward to Adventure in Draenor
step
>>Open the Adventure Guide (Shift + J), click on the right arrow until you see 'Spires of Arak', click 'Start Quest'
.goto 85,40.81,80.08
.accept 36951 >>Accept Arakkoa Exodus
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Chromie and select the campaign "The Legion Invasion"
.goto 85,40.81,80.08
.accept 43926 >>Accept Legion: The Legion Returns
step
.isOnQuest 43926
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Holgar Stormaxe outside of Orgrimmar
.goto 1,46.00,13.80
.turnin 43926 >>Turn in Legion: The Legion Returns
step
.isQuestTurnedIn 43926
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Holgar Stormaxe outside of Orgrimmar
.goto 1,46.00,13.80
.accept 44281 >>Accept To Be Prepared
step
.isOnQuest 44281
>>Interact with any of the meals
.goto 1,47.85,13.59
.complete 44281,3 
step
.isOnQuest 44281
>>Interact with a Keg of Armor Polish
.goto 1,49.67,14.13
.complete 44281,1 
step
.isOnQuest 44281
#completewith next
>>Interact with the Cauldron of Mojo
.goto 1,50.12,13.81,10,0
.collect 141295,1
step
.isQuestTurnedIn 43926
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Holgar Stormaxe to skip the Scenario
*If you can't skip it then skip this step
.goto 1,46.01,13.81
.skipgossip
.accept 44184 >>Accept In the Blink of an Eye
step
.isOnQuest 44184
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Emissary Auldbridge
.goto 627,57.60,45.78
.turnin 44184 >>Turn in In the Blink of an Eye
step
#completewith SilverpineTheWarchiefCometh
.goto 627,55.24,24.01
.zone 85 >>Take the portal to Orgrimmar
step
#completewith SilverpineTheWarchiefCometh
.goto 85,56.02,88.25
.zone 110 >> Take the portal to Silvermoon
step
.zoneskip 18
#completewith SilverpineTheWarchiefCometh
.goto 110,51.84,17.95,8,0
.goto 110,49.52,17.19,8,0
.goto 110,48.87,14.04,8,0
.goto 110,49.52,14.81
.zone 18 >>Interact with the Orb of Translocation
step
.isQuestAvailable 26965
.itemcount 132516,1
#completwith next
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
#label SilverpineTheWarchiefCometh
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Grand Executor Mortuus
.goto 21,57.43,10.14
.accept 26965 >>Accept The Warchief Cometh
.timer 300,Garrosh Roleplay
step
#completewith SilverpineStandbyWarchiefGarroshArrival
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Grand Executor Mortuus when he arrives
.goto 21,57.23,10.39
.accept 28089 >>Accept Warchief's Command: Hillsbrad Foothills!
step
#completewith next
+|cfff78300Drag the RestedXP Target Macro to your bars. You can use it to check for rares|r
step
#label SilverpineStandbyWarchiefGarroshArrival
.goto 21,57.42,10.13
.complete 26965,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Grand Executor Mortuus
.goto 21,57.42,10.13
.turnin 26965 >>Turn in The Warchief Cometh
.accept 26989 >>Accept The Gilneas Liberation Front
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Apothecary Witherbloom and High Apothecary Shana T'veen
.accept 26992 >>Accept Agony Abounds
.goto 21,56.77,9.19
.accept 26995 >>Accept Guts and Gore
.goto 21,56.26,8.40
step
#completewith SilverpineWorgenRenegade
>>Kill |cff00ecffbeasts|r in the area. Loot them for their guts
>>Keep an eye out for the rares |cff00ecffKree and Gorefang|r
.unitscan Kree
.unitscan Gorefang
.goto 21,60.83,6.82,30,0
.goto 21,62.24,12.54,25,0
.goto 21,61.76,13.12,20,0
.goto 21,59.36,12.96,20,0
.goto 21,55.66,20.18,20,0
.goto 21,56.01,22.62,20,0
.complete 26995,1 
step
#completewith SilverpineWorgenRenegade
*>>Pick up Ferocious Doomweed from the ground
.complete 26992,1 
step
#label SilverpineWorgenRenegade
.goto 21,56.01,22.62,30,0
.goto 21,53.93,17.13,15,0
.goto 21,56.07,12.92
.complete 26989,1 
step
#sticky
#label SilverpineCleanBeastGuts
>>Kill |cff00ecffbeasts|r in the area. Loot them for their guts
>>Keep an eye out for the rares |cff00ecffKree and Gorefang|r
.unitscan Kree
.unitscan Gorefang
.goto 21,59.26,16.38,20,0
.goto 21,60.52,9.07,20,0
.complete 26995,1 
step
*>>Pick up Ferocious Doomweed from the ground
.goto 21,55.54,13.17,20,0
.goto 21,58.30,15.89,20,0
.goto 21,61.04,13.36,30,0
.goto 21,60.46,8.74
.complete 26992,1 
step
#requires SilverpineCleanBeastGuts
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Grand Executor Mortuus
.target Grand Executor Mortuus
.goto 21,57.41,10.12
.turnin 26989 >>Turn in The Gilneas Liberation Front
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Apothecary Witherbloom and High Apothecary Shana T'veen
.turnin 26992 >>Turn in Agony Abounds
.goto 21,56.76,9.19
.turnin 26995 >>Turn in Guts and Gore
.accept 26998 >>Accept Iterating Upon Success
.goto 21,56.26,8.40
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bat Handler Maggotbreath
.goto 21,57.91,8.71
.skipgossip 1
.complete 26998,1 
step
>>Spam |T236885:0|tBlight Concotion (1) on the Murlocs
*|cfff78300DON'T USE (2)|r
.complete 26998,2 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to High Apothecary Shana T'veen
.target High Apothecary Shana T'veen
.goto 21,56.26,8.40
.turnin 26998 >>Turn in Iterating Upon Success
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deathstalker Commander Belmont
.target Deathstalker Commander Belmont
.goto 21,58.09,8.98
.accept 27039 >>Accept Dangerous Intentions
step
>>Interact with the Abandoned Outhouse
.goto 21,53.90,13.01
.turnin 27039 >>Turn in Dangerous Intentions
.accept 27045 >>Accept Waiting to Exsanguinate
step
>>Interact with the Armoire. |cfff78300DON'T SKIP THE CINEMATIC|r
.goto 21,53.41,13.19,8,0
.goto 21,53.04,13.11,8,0
.goto 21,53.44,13.08,8,0
.goto 21,53.30,12.56
.complete 27045,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deathstalker Commander Belmont
.target Deathstalker Commander Belmont
.goto 21,58.09,8.98
.turnin 27045 >>Turn in Waiting to Exsanguinate
.accept 27056 >>Accept Belmont's Report
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
.target Lady Sylvanas Windrunner
.goto 21,57.37,10.20
.turnin 27056 >>Turn in Belmont's Report
.accept 27065 >>Accept The Warchief's Fleet
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Admiral Hatchet and Warlord Torok
>>Check the locations for the rares Nightlash, Gnath, and Bolgaff
.target Admiral Hatchet
.unitscan Nightlash
.unitscan Gnath
.unitscan Bolgaff
.goto 21,52.57,25.71,25,0
.goto 21,50.06,29.25,25,0
.goto 21,48.38,24.48,25,0
.goto 21,44.06,21.36
.turnin 27065 >>Turn in The Warchief's Fleet
.accept 27069 >>Accept Steel Thunder
.accept 27073 >>Accept Give 'em Hell!
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Apothecary Wormcrud
.target Apothecary Wormcrud
.goto 21,44.80,20.91
.accept 27082 >>Accept Playing Dirty
step
#completwith next
>>Kill |cff00ecffWorgs|r and |cff00ecffBears|r. Loot them for their organs
.goto 21,42.44,20.06,20,0
.goto 21,38.58,23.93,10,0
.goto 21,37.45,23.73
.complete 27082,1 
step
#completewith next
>>Kill |cff00ecffBloodfang Scavengers|r
.goto 21,39.41,25.88,20,0
.goto 21,37.89,27.44,20,0
.goto 21,38.79,30.30,20,0
.goto 21,40.19,29.25
.goto 21,39.20,28.09,0,0
.complete 27073,1 
step
>>Pick up the crates on the ground
.goto 21,39.20,28.09
.complete 27069,1 
step
#sticky
#label SilverpineBloodfangScavenger
>>Kill |cff00ecffBloodfang Scavengers|r
.goto 21,39.20,28.09
.complete 27073,1 
step
>>Kill |cff00ecffWorgen|r and |cff00ecffBears|r. Loot them for their organs
.goto 21,45.69,27.85
.complete 27082,1 
step
#requires SilverpineBloodfangScavenger
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Admiral Hatchet and Warlord Torok
.goto 21,44.00,21.34
.turnin 27069 >>Turn in Steel Thunder
.turnin 27073 >>Turn in Give 'em Hell!
.accept 27095 >>Accept Skitterweb Menace
.accept 27093 >>Accept Lost in the Darkness
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Apothecary Wormcrud
.goto 21,44.79,20.91
.turnin 27082 >>Turn in Playing Dirty
.accept 27088 >>Accept It's Only Poisonous if You Ingest It
step
#completewith SilverpineSkitterwebMatriarch
>>Destroy the |cff00ecffWebbed Victims|r
>>Keep an eye out for the rare |cff00ecffKrethis the Shadowspinner|r
.unitscan Krethis the Shadowspinner
.goto 21,35.90,14.58,0,0
.complete 27093,1 
step
#completewith SilverpineSkitterwebMatriarch
.goto 21,35.90,14.58,0,0
.complete 27095,1 
step
>>Follow the arrow into the mine. Jump up the rocks
>>|cfff78300There may be a chest next to the jumping location|r
.goto 21,35.14,11.29,10,0
.goto 21,35.47,10.51,10,0
.goto 21,34.95,10.29,10,0
.goto 21,35.56,9.29
.accept 27094 >>Accept Deeper into Darkness
step
#label SilverpineSkitterwebMatriarch
>>Kill |cff00ecffSkitterweb Matriarchs|r
.goto 21,35.94,8.65
.complete 27094,1 
step
#completewith next
.goto 21,35.85,7.98,10 >>Check for a possible chest
.goto 21,34.67,7.82,10,0
.goto 21,35.60,13.38,10 >>Leave the cave
step
#sticky
#label SilverpineOrcSeaDog
>>Destroy the |cff00ecffWebbed Victims|r
>>Keep an eye out for the rare |cff00ecffKrethis the Shadowspinner|r
.unitscan Krethis the Shadowspinner
.goto 21,34.80,15.02,30,0
.goto 21,35.60,17.69,30,0
.goto 21,35.90,14.58,0,0
.complete 27093,1 
step
>>Kill |cff00ecffSkitterweb Matriarchs|r
.goto 21,37.11,16.23,30,0
.goto 21,34.80,15.02,30,0
.goto 21,35.60,17.69,30,0
.goto 21,35.90,14.58
.complete 27095,1 
step
>>Click on the quest in your quest log under your minimap
.turnin 27095 >>Turn in Skitterweb Menace
step
#requires SilverpineOrcSeaDog
>>Use the Mutant Bush Chicken Cage on the Ettin.
*The Ettin runs around the village. Click on the quest on the map/quest tracker to track the Ettin. You should see a small yellow waypoint at his position.
.goto 21,46.68,18.04,30,0
.goto 21,46.20,28.45,30,0
.goto 21,39.64,29.99,30,0
.goto 21,39.90,16.58
.use 60808
.complete 27088,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Apothecary Wormcrud, Admiral Hatchet, and Warlord Torok
.turnin 27088 >>Turn in It's Only Poisonous if You Ingest It
.goto 21,44.79,20.91
.turnin 27093 >>Turn in Lost in the Darkness
.turnin 27094 >>Turn in Deeper into Darkness
.accept 27096 >>Accept Orcs are in Order
.goto 21,44.01,21.32
step
#completewith next
.goto 21,45.94,21.88
.fly Forsaken High Command >>Fly to Forsaken High Command
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
*Dismount before talking to Sylvanas
.goto 21,57.37,10.20
.turnin 27096 >>Turn in Orcs are in Order
.accept 27097 >>Accept Rise, Forsaken
step
>>Kill |cff00ecffHillsbrad Refugees|r while Agatha is next to you
*Wait until Agatha spawns before mounting up. If she despawns just dismount and wait for her to reappear
.goto 21,64.87,19.37,30,0
.goto 21,65.70,26.35
.complete 27097,1 
step
>>Click on the quest in your quest log under your minimap
.goto 21,65.70,26.35
.turnin 27097 >>Turn in Rise, Forsaken
.accept 27099 >>Accept No Escape
step
.goto 21,65.73,24.39,10,0
.goto 21,66.27,24.34,10,0
.goto 21,66.07,23.92,10,0
.goto 21,65.54,23.44,10,0
.goto 21,65.92,23.35,8,0
.goto 21,65.94,23.91,8,0
.goto 21,65.29,23.94,10,0
.goto 21,65.27,24.97
>>Find the leaders upstaris. You don't need to kill any mobs if you can survive it.
*|cfff78300DON'T SKIP THE CINEMATIC|r
.complete 27099,1 
step
#completewith next
+You can skip the next cutscene (Esc -> Yes)
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
.goto 21,57.35,10.21
.turnin 27099 >>Turn in No Escape
.accept 27098 >>Accept Lordaeron
step
.complete 27098,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
.goto 21,44.89,41.65
.turnin 27098 >>Turn in Lordaeron
.accept 27180 >>Accept Honor the Dead
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Admiral Hatchet and Warlord Torok
.goto 21,45.78,41.94
.accept 27226 >>Accept Hair of the Dog
.accept 27231 >>Accept Reinforcements from Fenris
step
#completewith SilverpineAcceptExcisingtheTaint
.goto 21,46.42,42.70
.skipgossip 6739,1
.home >>Set your Hearthstone to The Sepulcher
step
#completewith SilverpineAcceptExcisingtheTaint
.goto 21,45.41,42.48
.fp >>Get the The Sepulcher Flight Path
step
#label SilverpineAcceptExcisingtheTaint
>>Kill a |cff00ecffBloodfang Stalker|r to trigger the quest
.goto 21,47.28,46.68
.accept 27181 >>Accept Excising the Taint
step
#completewith next
>>Loot the corpses of Veteran Forsaken Troopers on the ground
.complete 27180,1 
step
>>Kill |cff00ecffBloodfang Stalkers|r
>>Keep an eye out for the rare Berard the Moon-Crazed
.unitscan Berard the Moon-Crazed
.goto 21,43.34,50.79,15,0
.goto 21,46.27,51.27,25,0
.goto 21,47.48,49.47,30,0
.goto 21,47.03,53.10
.complete 27181,1 
step
>>Click on the quest in your quest log under your minimap
.turnin 27181 >>Turn in Excising the Taint
.accept 27193 >>Accept Seek and Destroy
step
>>Kill |cff00ecffCaretaker Smithers|r. Loot him for his logbook
.goto 21,45.90,54.23
.complete 27193,1 
step
>>Click on the quest in your quest log under your minimap
.turnin 27193 >>Turn in Seek and Destroy
.accept 27194 >>Accept Cornered and Crushed!
step
>>Loot the corpses of Veteran Forsaken Troopers on the ground
.goto 21,47.03,53.10,30,0
.goto 21,46.27,51.27,25,0
.goto 21,47.48,49.47,30,0
.goto 21,45.55,49.45,30,0
.goto 21,47.03,53.10
.complete 27180,1 
step
#requires SilverpineForsakenInsignia
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Master Forteski and follow him
.goto 21,55.88,46.35
.turnin 27194 >>Turn in Cornered and Crushed!
.accept 27195 >>Accept Nowhere to Run
step
*Don't run too far away from Master Forteski
.goto 21,58.05,44.89
.complete 27195,1 
step
#completewith next
.goto 21,56.46,46.06,10 >>Leave the cave
step
#completewith SilverpineHairoftheDog
>>Kill |cff00ecffHillsbrad Worgen|r
.goto 21,56.64,34.11,0,0
.complete 27231,1 
step
#title Orc roused 1
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,54.25,38.83
.use 60870
.complete 27226,1,1 
step
#completewith next
.goto 21,53.51,38.64,10 >>Check for a possible chest
step
#title Orc roused 2
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,53.86,37.49
.use 60870
.complete 27226,1,2 
step
#title Orc roused 3
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,54.37,36.25
.use 60870
.complete 27226,1,3 
step
#title Orc roused 4
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,53.91,35.74
.use 60870
.complete 27226,1,4 
step
#completewith next
.goto 21,54.43,34.34,10 >>Check for a possible chest
step
#title Orc roused 5
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,54.47,33.00
.use 60870
.complete 27226,1,5 
step
#title Orc roused 6
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,56.08,32.18
.use 60870
.complete 27226,1,6 
step
#title Orc roused 7
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,57.05,32.67
.use 60870
.complete 27226,1,7 
step
#label SilverpineHairoftheDog
#title Orc roused 8
>>Use the |T252176:0|t[Barrel of Explosive Ale] on Orc Sea Dogs
*Keep an eye out for chests
.goto 21,57.76,34.06
.use 60870
.complete 27226,1 
step
>>Kill |cff00ecffHillsbrad Worgen|r
.goto 21,57.01,34.96,30,0
.goto 21,54.34,34.19,30,0
.goto 21,52.93,31.90,30,0
.goto 21,56.64,34.11,0,0
.complete 27231,1 
step
>>Interact with the Horde Communication Panel
.goto 21,59.24,34.22
.turnin 27231 >>Turn in Reinforcements from Fenris
.accept 27232 >>Accept The Waters Run Red...
step
#completewith next
.goto 21,59.62,33.53
.vehicle 45263 >>Enter the Horde Cannon
step
>>Use |T133032:0|tRocket Blast (1) to kill the arriving Worgen
>>Keep an eye out for the rare Fenwick Thatros
.unitscan Fenwick Thatros
.goto 21,59.38,33.46,8,0
.goto 21,59.62,33.53
.complete 27232,1 
step
#completewith SilverpineTheWatersRunRed
.goto 21,56.64,34.11
.deathskip >>Pull some mobs, die and ress at the spirit healer
step
#completewith next
.goto 21,46.43,42.70
.vendor
step
#label SilverpineTheWatersRunRed
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Admiral Hatchet and Warlord Torok
.goto 21,45.79,41.90
.turnin 27232 >>Turn in The Waters Run Red...
.turnin 27226 >>Turn in Hair of the Dog
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
.goto 21,44.94,41.66
.turnin 27180 >>Turn in Honor the Dead
.turnin 27195 >>Turn in Nowhere to Run
.accept 27290 >>Accept To Forsaken Forward Command
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly with Arthura and talk to Deathstalker Commander Belmont
.goto 217,57.46,18.77
.turnin 27290 >>Turn in To Forsaken Forward Command
.accept 27342 >>Accept In Time, All Will Be Revealed
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Forward Commander Onslaught
.goto 217,57.54,18.24
.accept 27333 >>Accept Losing Ground
.accept 27345 >>Accept The F.C.D.
step
#completewith next
>>Kill |cff00ecffWorgen Rebels|r
.goto 217,55.39,13.66,20,0
.complete 27333,1 
step
#title Kill Korok for his head
#sticky
#label SilverpineKorokSecondHead
>>Kill |cff00ecffKorok|r (patrolling). Loot him for his head. Click it in your bags
.goto 217,50.26,19.52,15,0
.goto 217,50.26,19.52,0,0
.collect 60956,1,27322,1
.accept 27322 >>Accept Korok the Colossus
step
>>Pick up the device on the ground
.goto 217,45.76,21.96
.complete 27345,1 
step
#requires SilverpineKorokSecondHead
#sticky
#label SilverpineWorgenRebel
.goto 217,54.21,22.11,20,0
.goto 217,55.10,26.28,15,0
.goto 217,54.84,19.34,0,0
.complete 27333,1 
step
#requires SilverpineKorokSecondHead
>>Loot Wolfsbane around the waypoint
*Spawn is too random to place exact waypoints
.goto 217,58.82,32.55,20,0
.goto 217,62.30,33.88,30,0
.goto 217,63.78,31.96,30,0
.goto 217,59.83,28.20
.complete 27342,1 
step
#requires SilverpineWorgenRebel
.goto 217,57.49,18.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Onslaught and Belmont
.turnin 27333 >>Turn in Losing Ground
.turnin 27345 >>Turn in The F.C.D.
.turnin 27322 >>Turn in Korok the Colossus
.turnin 27342 >>Turn in In Time, All Will Be Revealed
.accept 27349 >>Accept Break in Communications: Dreadwatch Outpost
step
*It may not complete if you fly too high.
>>Follow the arrow
.goto 217,52.70,32.23
.complete 27349,1 
step
>>Click on the quest in your quest log under your minimap
.goto 217,52.76,32.36
.turnin 27349 >>Turn in Break in Communications: Dreadwatch Outpost
.accept 27350 >>Accept Break in Communications: Rutsak's Guard
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Captain Rutsak
.goto 217,65.64,34.21
.turnin 27350 >>Turn in Break in Communications: Rutsak's Guard
.accept 27360 >>Accept Vengeance for Our Soldiers
.accept 27364 >>Accept On Whose Orders?
step
#completewith next
.complete 27360,1 
step
>>Kill |cff00ecffMaster Seargent Pietro Zaren|r. Loot him for the orders
.goto 217,58.76,47.38
.complete 27364,1 
step
>>Click on the quest in your quest log under your minimap
.goto 217,58.17,47.43
.turnin 27364 >>Turn in On Whose Orders?
.accept 27401 >>Accept What Tomorrow Brings
step
*Be careful not to pull too many because they can do a lot of damage.
.goto 217,60.12,45.39,20,0
.goto 217,59.17,42.96,20,0
.goto 217,57.91,45.44,20,0
.goto 217,56.73,48.52
.complete 27360,1 
step
>>Interact with the spyglass
*|cfff78300DON'T SKIP THE CINEMATIC|r
.goto 217,54.72,44.45
.complete 27401,1 
step
>>Click on the quest in your quest log under your minimap
.goto 217,54.72,44.45
.turnin 27401 >>Turn in What Tomorrow Brings
.accept 27405 >>Accept Fall Back!
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Captain Rutsak
.goto 217,65.70,34.29
.turnin 27360 >>Turn in Vengeance for Our Soldiers
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deathstalker Commander Belmont
.goto 217,72.88,30.21
.turnin 27405 >>Turn in Fall Back!
.accept 27406 >>Accept A Man Named Godfrey
step
>>You automatically accept it when you reach the waypoint
.goto 217,73.76,32.85
.accept 27423 >>Accept Resistance is Futile
step
#completewith next
+|cfff78300Dismount if no NPC is following you to make them spawn|r
step
*Focus on the Bloodfang Scout + 5 Gilnean Warhound packs
.goto 217,71.84,42.71,35,0
.goto 217,71.78,51.53,35,0
.goto 217,76.38,56.02,35,0
.goto 217,77.65,61.04
.complete 27423,1 
step
>>Interact with the corpse of Lord Godfrey
.goto 217,79.70,75.78
.complete 27406,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deathstalker Commander Belmont
*Dismount if no NPC is following you to make them spawn.
.goto 217,79.70,75.78
.turnin 27406 >>Turn in A Man Named Godfrey
.turnin 27423 >>Turn in Resistance is Futile
.accept 27438 >>Accept The Great Escape
step
.goto 21,51.77,66.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
.turnin 27438 >>Turn in The Great Escape
.accept 27472 >>Accept Rise, Godfrey
step
#completewith SilverpineLordGodfreyReborn
+|cfff78300You only have roughly 40 seconds to search for the next two Rares|r. Run back early if you're too slow. If you miss the timer, abandon the quest and start it again.
step
#completewith next
*You have to pull him with a ranged ability as you can't see him near the Forsaken Front
.goto 21,48.53,69.00,15 >>Search for Corpsefeeder behind you
step
#completewith next
.goto 21,47.43,69.93,15 >>Search for Effritus
step
#label SilverpineLordGodfreyReborn
.unitscan Effritus
.unitscan Corpsefeeder
.goto 21,51.73,65.50
.complete 27472,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner and Daschla
.turnin 27472 >>Turn in Rise, Godfrey
.accept 27474 >>Accept Breaking the Barrier
.goto 21,51.88,65.08
.accept 27475 >>Accept Unyielding Servitors
.goto 21,51.91,64.69
step
#completewith next
#title Check for Chest
.goto 21,58.48,61.62,8 >>Check possible Chest location
step
#completewith SilverpineBreakingtheBarrier
>>Kill the |cff00ecffelementals|r in the area. Loot them for their cores
.goto 21,59.51,64.29,0,0
.complete 27475,1 
step
#completewith next
.goto 21,62.84,64.02,8 >>Enter the building
step
#label SilverpineBreakingtheBarrier
>>Pick up the book.
.goto 21,63.48,64.25
.complete 27474,1 
step
#completewith next
.goto 21,62.84,64.02,8 >>Leave the building
step
>>Kill the |cff00ecffelementals|r in the area. Loot them for their cores
.goto 21,59.51,64.29,0,0
.complete 27475,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Daschla and Lady Sylvanas Windrunner
.turnin 27475 >>Turn in Unyielding Servitors
.goto 21,51.89,64.67
.turnin 27474 >>Turn in Breaking the Barrier
.accept 27476 >>Accept Dalar Dawnweaver
.goto 21,51.94,64.99
step
#completewith next
.goto 21,50.85,63.72
.fly The Sepulcher >>Fly to The Sepulcher
step
.goto 21,47.06,43.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dalar Dawnweaver
.turnin 27476 >>Turn in Dalar Dawnweaver
.accept 27478 >>Accept Relios the Relic Keeper
.accept 27483 >>Accept Practical Vengeance
step
#completewith next
.goto 25,30.10,37.07,50 >> Click the Portal to Dalaran Crater
step
>>Kill an |cff00ecffArcane Remnant|r. Loot if for the 'Arcane Remnant'. Click it in your bags
.goto 25,30.10,37.07
.collect 61310,1,27480
.accept 27480 >>Accept Ley Energies
step
#completewith next
>>Kill |cff00ecffArcane Remnants|r. Loot them for their remnants
.goto 25,31.86,37.55,15,0
.complete 27480,1 
step
#completewith next
*Focus on killing |cff00ecffDalaran Workers|r. The summoners are not worth it
.goto 25,29.72,44.21,0,0
.unitscan Indigos
.complete 27483,1 
step
>>Kill Relios the Relic. Loot him for the ring
>>Keep an eye out for Indigos
.unitscan Indigos
.goto 25,31.73,39.82,15,0
.goto 25,32.76,43.09
.complete 27478,1 
step
#sticky
#label SilverpineDalaranHuman
*Focus on killing |cff00ecffDalaran Workers|r. The summoners are not worth it
.goto 25,30.78,43.81,15,0
.goto 25,29.01,43.88
.complete 27483,1 
step
>>Kill |cff00ecffArcane Remnants|r. Loot them for their remnants
.goto 25,30.31,40.28,15,0
.goto 25,30.40,38.09
.complete 27480,1 
step
#requires SilverpineDalaranHuman
#completewith next
.goto 25,30.29,36.62
.zone 21 >>Take the Portal to the Sepulcher
step
#requires SilverpineDalaranHuman
.goto 21,47.07,43.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dalar Dawnweaver
.turnin 27478 >>Turn in Relios the Relic Keeper
.accept 27484 >>Accept Only One May Enter
.turnin 27483 >>Turn in *undefined*
.turnin 27480 >>Turn in Ley Energies
step << Monk
.xp <40,1
.money <5000
.zoneskip 379
#completewith SkillMasterRiding4
.cast 126892 >>Use Zen Pilgrimage
step << Monk
.xp <40,1
.money <5000
#completewith SkillMasterRiding4
.goto 379,48.53,43.57
.zone 85 >>Take the Portal to Orgrimmar
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
#completewith SkillMasterRiding4
.goto 21,45.41,42.48
.fly Forsaken High Command, Silverpine Forest >>Fly to Forsaken High Command, Silverpine Forest
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
.goto 18,69.46,62.80
#completewith SkillMasterRiding4
.gossipoption 49018 >>Talk to Zidormi if you can see the fire
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
#completewith SkillMasterRiding4
.goto 18,60.73,58.68
.zone 85 >>Take the portal to Orgrimmar
step << !Monk
.xp <40,1
.money <5000
.isQuestTurnedIn 44184
#completewith SkillMasterRiding4
.use 140192
.cast 222695 >>Use Dalaran Hearthstone
step << !Monk
.xp <40,1
.money <5000
.isQuestTurnedIn 44184
#completewith SkillMasterRiding4
.goto 627,55.28,23.95
.zone 85 >>Take the portal to Orgrimmar
step
.money <5000
#label SkillMasterRiding4
.xp <40,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Mazha
.goto 85,48.93,59.28
.skill riding,375 >>Train Master Riding
step
.zoneskip 85,1
.xp <40,1
#completewith SilverpineOnlyOneMayEnter
.hs >>Hearth to The Sepulcher
step
.xp <40,1
.money >5000
#completewith next
.skill riding,375 >>|cfff78300The guide skipped the "Train Master Riding" step because you have less than 5000 gold. Send your character gold and go back some steps if you have enough gold on another character|r
step
#completewith next
.goto 21,45.50,42.47
.fly The Forsaken Front >>Fly to The Forsaken Front
step
#label SilverpineOnlyOneMayEnter
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Sylvanas Windrunner
.goto 21,51.85,64.94
.turnin 27484 >>Turn in Only One May Enter
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Horde 10-60
#name 5 Horde Hillsbrad Foothills
#displayname Chapter 6 - Hillsbrad Foothills
#next 6 Horde Spires of Arak <<!Monk
#next 99 Monk Quest Horde <<Monk
#veteran
<< Horde
step
.zoneskip 85,1
#completewith HillsbradHillsbradFoothills
.goto 85,56.02,88.25
.zone 110 >> Take the portal to Silvermoon
step
.zoneskip 18,1
#completewith HillsbradHillsbradFoothills
.goto 110,51.84,17.95,8,0
.goto 110,49.52,17.19,8,0
.goto 110,48.87,14.04,8,0
.goto 110,49.52,14.81
.zone 18 >>Interact with the Orb of Translocation
step
.itemcount 132516,<1
#completewith HillsbradHillsbradFoothills
+Fly to Hillsbrad
step
step
.itemcount 132516,1
#completwith next
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
#label HillsbradHillsbradFoothills
.isOnQuest 28089
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to to High Executor Darthalia
.goto 25,29.24,63.34
.turnin 28089 >>Turn in Warchief's Command: Hillsbrad Foothills!
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to to High Executor Darthalia
.goto 25,29.24,63.34
.accept 28096 >>Accept Welcome to the Machine
step
#completewith next
.goto 25,29.34,63.44
.vehicle 47488 >>Interact with the Skeletal Steed
step
>>Stay on the Steed and talk to the approaching NPCs
.skipgossip 1
.complete 28096,1 
.complete 28096,2 
.complete 28096,3 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to High Executor Darthalia
.goto 25,29.24,63.34
.turnin 28096 >>Turn in Welcome to the Machine
.accept 28111 >>Accept Trouble at Azurelode
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Apothecary Underhill
.goto 25,29.21,64.04
.accept 28115 >>Accept Past Their Prime
.accept 28114 >>Accept Glorious Harvest
step
#completewith next
.goto 25,29.46,64.12
.vendor
step
>>Kill Infested Bears and LOOT the Eggs from their back
*Don't use AOE abilities otherwise you'll kill the Eggs. Each Bear has 8 Eggs.
.goto 25,36.04,70.81
.complete 28115,1 
.complete 28114,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Captain Keyton and Spider-Handler Sarus
.goto 25,33.29,73.58
.turnin 28111 >>Turn in Trouble at Azurelode
.turnin 28115 >>Turn in Past Their Prime
.turnin 28114 >>Turn in Glorious Harvest
.accept 28144 >>Accept Thieving Little Monsters!
.accept 28138 >>Accept Human Infestation
step
#completewith next
.goto 25,33.50,71.99,5 >>Enter the Mine
step
#sticky
#label SilverpineHillbradHuman
>>Don't kill the Humans. Use the Titanium Shackles at or below 35% HP.
.use 63079
.complete 28138,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dumass
.goto 25,35.71,71.51,10,0
.goto 25,36.63,70.19
.accept 28156 >>Accept Deep Mine Rescue
step
#completewith next
+Leave the cave after scanning for the rare
step
*Dumass follows you but he will randomly attack Miners so be careful not to loose him!
>>Keep an eye out for Miasmiss
.unitscan Miasmiss
.goto 25,36.77,68.39,15,0
.complete 28156,1 
.goto 25,33.29,73.58
step
#requires SilverpineHillbradHuman
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Spider-Handler Sarus
.goto 25,33.27,73.62
.accept 28146 >>Accept Coastal Delicacies!
step
>>Talk to Captain Keytron
.isQuestComplete 28138
.goto 25,33.27,73.67
.turnin 28138 >>Turn in Human Infestation
step
>>Talk to Captain Keytron
.goto 25,33.27,73.67
.turnin 28156 >>Turn in Deep Mine Rescue
step
#completewith next
>>Kill |cff00ecffMuckgill|r. Loot him for Muckgill's Flipper. Click it in your bags
.use 63090
.collect 63090,1,28154
.accept 28154 >>Accept Muckgill's Flipper or Something...
step
#sticky
#label HillsbradMurlocsFedSpider
>>Kill |cff00ecffmurlocs|r in the area
>>Keep an eye out for the rare |cff00ecffScargil|r
.unitscan Scargil
.goto 25,33.14,79.60,0,0
.complete 28146,1 
step
>>Pick up the supplies on the ground
.goto 25,31.37,75.71,10,0
.goto 25,32.52,79.91,10,0
.goto 25,34.47,81.14,10,0
.goto 25,35.81,81.72,10,0
.goto 25,37.60,80.94,10,0
.goto 25,32.60,79.96
.complete 28144,1 
step
>>Kill |cff00ecffMuckgill|r. Loot him for Muckgill's Flipper. Click it in your bags
.use 63090
.collect 63090,1,28154
.accept 28154 >>Accept Muckgill's Flipper or Something...
step
#requires HillsbradMurlocsFedSpider
#completewith next
.unitscan Little Bjorn
.goto 25,35.08,78.48,25 >>Search for Little Bjorn before running back to the camp.
step
#requires HillsbradMurlocsFedSpider
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Spider-Handler Sarus and Captain Keyton
.goto 25,33.27,73.67
.turnin 28146 >>Turn in Coastal Delicacies!
.turnin 28138 >>Turn in Human Infestation
.turnin 28144 >>Turn in Muckgill's Flipper or Something...
.turnin 28156 >>Turn in Muckgill's Flipper or Something...

.turnin 28154 >>Turn in Muckgill's Flipper or Something...
.accept 28168 >>Accept Trouble at the Sludge Fields
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Warden Stillwater
*Skip the next cinematic with ESC
.goto 25,36.22,61.16
.turnin 28168 >>Turn in Trouble at the Sludge Fields
.accept 28192 >>Accept No One Here Gets Out Alive
.turnin 28192 >>Turn in No One Here Gets Out Alive
.accept 28197 >>Accept Discretion is Key
step
#completewith SilverpineForScience
.goto 25,35.85,61.26
.home >>Set your Hearthstone to The Sludge Fields
step
#completewith next
.goto 25,36.12,60.68
.vendor >> Vendor any trash you have.
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flesh-Shaper Arnauld
.goto 25,36.34,60.24
.accept 28199 >>Accept For Science!
step
#sticky
#label HillsbradFleshSample
>>Kill and loot zombies
.goto 25,38.89,63.91,0,0
.complete 28199,1 
step
>>Kill and loot Clerk Horrace and use 'The Battle for Hillsbrad'
.unitscan Clerk Horrace Whitesteed
.goto 25,37.82,63.37,10,0
.goto 25,38.26,63.19
.use 63249
.complete 28197,2 
.collect 63249,1,28196
.accept 28196 >>Accept The Battle for Hillsbrad
step
>>Interact with the Shovel
.goto 25,39.73,63.04
.accept 28189 >>Accept Do the Right Thing
step
>>Interact with the Human Seedlings
.complete 28197,1 
.goto 25,38.98,64.14
.complete 28189,1 
.goto 25,39.14,63.57
step
.goto 25,38.45,63.16
.turnin 28189 >>Turn in Do the Right Thing
step
#label SilverpineForScience
#requires HillsbradFleshSample
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flesh-Shaper Arnauld
.goto 25,36.34,60.23
.turnin 28199 >>Turn in For Science!
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Warden Stillwater
.goto 25,36.18,61.14
.turnin 28196 >>Turn in The Battle for Hillsbrad
.turnin 28197 >>Turn in Discretion is Key
.accept 28206 >>Accept A Lost Lad
step << Monk
.xp <40,1
.money <5000
.zoneskip 379
#completewith SkillMasterRiding1
.cast 126892 >>Use Zen Pilgrimage
step << Monk
.xp <40,1
.money <5000
#completewith SkillMasterRiding1
.goto 379,48.53,43.57
.zone 85 >>Take the Portal to Orgrimmar
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
#completewith SkillMasterRiding1
.goto 25,29.13,64.42
.fly Forsaken High Command, Silverpine Forest >>Fly to Forsaken High Command, Silverpine Forest
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
.goto 18,69.46,62.80
#completewith SkillMasterRiding1
.gossipoption 49018 >>Talk to Zidormi
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
#completewith SkillMasterRiding1
.goto 18,60.73,58.68
.zone 85 >>Take the portal to Orgrimmar
step << !Monk
.xp <40,1
.money <5000
.isQuestTurnedIn 44184
#completewith SkillMasterRiding1
.use 140192
.cast 222695 >>Use Dalaran Hearthstone
step << !Monk
.xp <40,1
.money <5000
.isQuestTurnedIn 44184
#completewith SkillMasterRiding1
.goto 627,55.28,23.95
.zone 85 >>Take the portal to Orgrimmar
step
.money <5000
#label SkillMasterRiding1
.xp <40,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Mazha
.goto 85,48.93,59.28
.skill riding,375 >>Train Master Riding
step
.zoneskip 85,1
.xp <40,1
#completewith next
.hs >>Hearth to The Sludge Fields
step
.xp <40,1
.money >5000
#completewith next
.skill riding,375 >>|cfff78300The guide skipped the "Train Master Riding" step because you have less than 5000 gold. Send your character gold and go back some steps if you have enough gold on another character|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Johnny Awesome and Master Apothecary Lydon
*|cfff78300DON'T KILL ANYTHING ON YOUR WAY|r
.goto 25,40.33,59.40
.turnin 28206 >>Turn in A Lost Lad
.accept 28209 >>Accept Freedom for Lydon
step
#completewith next
.goto 25,39.55,60.36,15 >>Check Chest location
step
>>Kill and LOOT Infected Sludge Guards
.goto 25,38.97,59.66
.complete 28209,1 
step
#completewith HillsbradHeadOfWardenStillwater
+If you can't see Lydon or Johnny dismount and wait until they respawn
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Master Apothecary Lydon
.goto 25,40.25,59.32
.turnin 28209 >>Turn in Freedom for Lydon
.accept 28230 >>Accept Protocol
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Johnny Awesome
.goto 25,40.25,59.32
.accept 28231 >>Accept Do it for Twinkles
step
.goto 25,38.37,56.61
.complete 28230,1 
.complete 28231,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Johnny Awesome and Master Apothecary Lydon
.goto 25,38.22,56.71
.turnin 28230 >>Turn in Protocol
.turnin 28231 >>Turn in Do it for Twinkles
.accept 28235 >>Accept Burnside Must Fall
step
>>Walk up to Magistrate Burnside to kill him.
.goto 25,36.64,58.00
.complete 28235,1 
step
.goto 25,36.65,58.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Master Apothecary Lydon
.turnin 28235 >>Turn in Burnside Must Fall
.accept 28237 >>Accept A Blight Upon the Land
step
>>Kill and loot Warden Stillwater
*Make sure to face Warden Stillwater to the house because he will knock you back
.goto 25,36.37,61.16
.complete 28237,1 
step
#label HillsbradHeadOfWardenStillwater
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Master Apothecary Lydon
.goto 25,36.65,61.20
.turnin 28237 >>Turn in A Blight Upon the Land
.accept 28251 >>Accept Trouble at Southshore
step << Monk
.xp <40,1
.money <5000
.zoneskip 379
#completewith SkillMasterRiding2
.cast 126892 >>Use Zen Pilgrimage
step << Monk
.xp <40,1
.money <5000
#completewith SkillMasterRiding2
.goto 379,48.53,43.57
.zone 85 >>Take the Portal to Orgrimmar
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
#completewith SkillMasterRiding2
.goto 25,29.13,64.42
.fly Forsaken High Command, Silverpine Forest >>Fly to Forsaken High Command, Silverpine Forest
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
.goto 18,69.46,62.80
#completewith SkillMasterRiding2
.gossipoption 49018 >>Talk to Zidormi
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
#completewith SkillMasterRiding2
.goto 18,60.73,58.68
.zone 85 >>Take the portal to Orgrimmar
step << !Monk
.xp <40,1
.money <5000
.isQuestTurnedIn 44184
#completewith SkillMasterRiding2
.use 140192
.cast 222695 >>Use Dalaran Hearthstone
step << !Monk
.xp <40,1
.money <5000
.isQuestTurnedIn 44184
#completewith SkillMasterRiding2
.goto 627,55.28,23.95
.zone 85 >>Take the portal to Orgrimmar
step
.money <5000
#label SkillMasterRiding2
.xp <40,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Mazha
.goto 85,48.93,59.28
.skill riding,375 >>Train Master Riding
step
.zoneskip 85,1
.xp <40,1
#completewith next
.hs >>Hearth to The Sludge Fields
step
.xp <40,1
.money >5000
#completewith next
.skill riding,375 >>|cfff78300The guide skipped the "Train Master Riding" step because you have less than 5000 gold. Send your character gold and go back some steps if you have enough gold on another character|r
step
#completewith next
.goto 25,49.03,66.22
.fp >>Get the Ruins of Southshore Flight Path
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Serge Hinott
>>Keep an eye out for the rare |cff00ecffAlitus|r
.unitscan Alitus
.goto 25,49.10,66.36
.turnin 28251 >>Turn in Green Living
.accept 28325 >>Accept Green Living
.accept 28324 >>Accept Studies in Lethality
step
#sticky
#label HillsbradBlightSample
>>Use the 'Lethality Analyzer' on the slimes in the area
.use 63426
.goto 25,48.90,72.12,0,0
.complete 28324,1 
step
#completewith HillsbradAngryBlightSlime
>>Pick up 'Used Blight Canisters' from the ground
.goto 25,48.56,72.02,0,0
.complete 28325,1 
step
>>Kill an Angry Blight Slime
.goto 25,48.73,72.07
.accept 28329 >>Accept Angry Scrubbing Bubbles
step
*Make sure to drain them before killing them
.goto 25,49.20,72.21,15,0
.goto 25,46.27,73.67,20,0
.goto 25,47.20,70.96,20,0
.goto 25,48.71,72.55
.complete 28329,1 
step
#label HillsbradAngryBlightSlime
.turnin 28329 >>Turn in Angry Scrubbing Bubbles
.accept 28330 >>Accept Trail of Filth
step
>>Find & kill Chet inside the house. You can drain him to make the fight easier.
.goto 25,47.87,72.44
.complete 28330,1 
step
>>Pick up 'Used Blight Canisters' from the ground
.goto 25,49.33,71.34,20,0
.goto 25,50.12,70.69,20,0
.goto 25,49.63,69.59,20,0
.goto 25,48.56,72.02,0,0
.complete 28325,1 
step
#requires HillsbradBlightSample
#completewith next
.goto 25,46.89,75.48,10 >>Search for Carcinak
.unitscan Carcinak
step
#requires HillsbradBlightSample
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kingslayer Orkus
.goto 25,49.57,74.40
.skipgossip 1
.accept 28345 >>Accept *Gurgle* HELP! *Gurgle*
.complete 28345,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kingslayer Orkus
*Skip the next cinematic with ESC
.goto 25,50.02,74.34
.turnin 28345 >>Turn in *Gurgle* HELP! *Gurgle*
.accept 28348 >>Accept Stormpike Rendezvous
.turnin 28348 >>Turn in Stormpike Rendezvous
.accept 28354 >>Accept Kasha Will Fly Again
step
>>Kill and loot a Daggerspine and use the 'Daggerspine Attack Plans'
.goto 25,51.62,74.95
.use 63686
.collect 63686,1,28356
.accept 28356 >>Accept Preemptive Strike
step
#completewith next
.unitscan Lady Zephris
.goto 25,54.92,76.36,15 >>Search for Lady Zephris
step
>>Kill |cff00ecffDaggerspine Nagas|r
.goto 25,54.34,77.17,25,0
.goto 25,55.11,81.10
.complete 28356,1 
step
#sticky
#label HillsbradMudsnoutBlossom
>>Pick up the Mushrooms
.goto 25,57.72,74.66,0,0
.complete 28354,1 
step
>>Kill a Mudnsout Gnoll or Shaman |cfff78300on the field|r
*If this doesn't trigger after the first kill, turn on "Trivial Quests" in your tracking menu next to the minimap.
.accept 28355 >>Accept Terrible Little Creatures
step
#completewith next
.goto 25,57.49,74.48,8 >>Check possible Chest location
step
>>Kill |cff00ecffMudsount Gnolls or Shamans|r
>>Keep an eye out for the rare |cff00ecffRo'Bark|r and a chest
.unitscan Ro'Bark
.goto 25,57.16,75.18,0,0
.complete 28355,1 
step
>>You may have to click on the quest in your quest log under the minimap
.turnin 28355 >>Turn in Terrible Little Creatures
step
#requires HillsbradMudsnoutBlossom
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Captain Jekyll and Nils Beerot
.accept 28635 >>Accept A Haunting in Hillsbrad
.accept 28643 >>Accept The Durnholde Challenge: Zephyrus
.goto 25,60.01,63.34
.accept 28634 >>Accept Extinction
.goto 25,60.14,63.76
step << Monk
.xp <40,1
.money <5000
.zoneskip 379
#completewith SkillMasterRiding5
.cast 126892 >>Use Zen Pilgrimage
step << Monk
.xp <40,1
.money <5000
#completewith SkillMasterRiding5
.goto 379,48.53,43.57
.zone 85 >>Take the Portal to Orgrimmar
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
#completewith SkillMasterRiding5
.goto 25,59.67,63.24
.fly Forsaken High Command, Silverpine Forest >>Fly to Forsaken High Command, Silverpine Forest
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
.goto 18,69.46,62.80
#completewith SkillMasterRiding5
.gossipoption 49018 >>Talk to Zidormi
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
#completewith SkillMasterRiding5
.goto 18,60.73,58.68
.zone 85 >>Take the portal to Orgrimmar
step << !Monk
.xp <40,1
.money <5000
.isQuestTurnedIn 44184
#completewith SkillMasterRiding5
.use 140192
.cast 222695 >>Use Dalaran Hearthstone
step << !Monk
.xp <40,1
.money <5000
.isQuestTurnedIn 44184
#completewith SkillMasterRiding5
.goto 627,55.28,23.95
.zone 85 >>Take the portal to Orgrimmar
step
.money <5000
#label SkillMasterRiding5
.xp <40,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Mazha
.goto 85,48.93,59.28
.skill riding,375 >>Train Master Riding
step
.zoneskip 85,1
.xp <40,1
#completewith next
.hs >>Hearth to The Sludge Fields
step
.xp <40,1
.money >5000
#completewith next
.skill riding,375 >>|cfff78300The guide skipped the "Train Master Riding" step because you have less than 5000 gold. Send your character gold and go back some steps if you have enough gold on another character|r
step
>>Kill |cff00ecffRampaging Owlbeasts|r
>>Keep an eye out for the rares |cff00ecffBig Samras|r and |cff00ecffLopex|r
.goto 25,63.61,52.69,0
.unitscan Big Samras
.goto 25,68.8,56.0,0
.unitscan Lopex
.goto 25,63.52,60.82,25,0
.goto 25,63.05,57.45,25,0
.goto 25,64.42,57.03,25,0
.goto 25,65.50,54.18,25,0
.goto 25,63.61,52.69,25,0
.goto 25,67.46,54.00,25,0
.goto 25,68.89,55.88,25,0
.goto 25,71.22,57.08,25,0
.goto 25,73.03,59.96,25,0
.complete 28634,1 
step
#completewith next
+The following elementals are VERY DIFFICULT. You can skip them.
step
>>Kill |cff00ecffZephyrus|r
*Run away when it summons a Tornado
.goto 25,68.64,59.43
.use 141295
.complete 28643,1 
step
.isQuestComplete 28643
>>You may have to click on the quest in your quest log under the minimap
.turnin 28643 >>Turn in The Durnholde Challenge: Zephyrus
.accept 28644 >>Accept The Durnholde Challenge: Teracula
step
.isOnQuest 28644
>>Kill |cff00ecffTeracula|r
*Dodge or interrupt the Rupture Line
.goto 25,67.28,59.86
.use 141295
.complete 28644,1 
step
.isQuestComplete 28644
>>You may have to click on the quest in your quest log under the minimap
.turnin -28644 >>Turn in The Durnholde Challenge: Teracula
.accept 28645 >>Accept The Durnholde Challenge: Bloodvenom
step
.isOnQuest 28645
>>Kill |cff00ecffBloodvenom|r
*Move out of the blue void zones
.goto 25,66.26,60.10
.use 141295
.complete 28645,1 
step
.isQuestComplete 28645
.goto 25,66.26,60.22
>>You may have to click on the quest in your quest log under the minimap
.turnin 28645 >>Turn in The Durnholde Challenge: Bloodvenom
.accept 28646 >>Accept The Durnholde Challenge: Infernus
step
.isOnQuest 28646
>>Kill |cff00ecffInfernus|r
*This one is very hard without a pet because he will disorient you periodically
.goto 25,68.01,63.17
.complete 28646,1 
step
.isQuestComplete 28646
>>You may have to click on the quest in your quest log under the minimap
.turnin 28646 >>Turn in The Durnholde Challenge: Infernus
.accept 28647 >>Accept The Durnholde Challenge: D-1000
step
.isOnQuest 28647
>>Kill |cff00ecffD-1000|r
*This one is also very hard because of his hard hitting melee hits
.goto 25,70.27,61.05
.complete 28647,1 
step
#completewith next
.goto 25,77.05,59.90,30 >>Search for Zorn
.unitscan Zorn
.goto 14,26.26,28.21,30 >>Search for Snuffles and Singer
.unitscan Singer
.unitscan Snuffles
.goto 14,18.87,31.20,30 >>Search for Ruul Onestone
.unitscan Ruul Onestone
step
>>Follow the arrow
.goto 25,61.75,83.93
.complete 28635,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Captain Ironhill's Ghost
.goto 25,61.78,84.39
.turnin 28635 >>Turn in A Haunting in Hillsbrad
.accept 28636 >>Accept Silence of the Dwarves
step
>>Kill |cff00ecffDun Garok Spirits|r
>>Keep an eye out for the rare |cff00ecffTamra Stormpike|r
.unitscan Tamra Stormpike
.goto 25,63.16,87.01,10,0
.goto 25,63.31,86.61,10,0
.goto 25,63.20,85.71,20,0
.goto 25,62.43,83.75
.complete 28636,1 
step
.isQuestComplete 28647
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Captain Jekyll and Nils Beerot
.turnin 28636 >>Turn in Silence of the Dwarves
.goto 25,59.98,63.36
.turnin 28634 >>Turn in Extinction
.turnin 28647 >>Turn in The Durnholde Challenge: D-1000
.goto 25,60.06,63.66
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Captain Jekyll and Nils Beerot
.turnin 28636 >>Turn in Silence of the Dwarves
.goto 25,59.98,63.36
.turnin 28634 >>Turn in Extinction
.goto 25,60.06,63.66
step
.abandon 28643 >>Abandon The Durnholde Challenge: Zephyrus
.abandon 28644 >>Abandon The Durnholde Challenge: Teracula
.abandon 28645 >>Abandon The Durnholde Challenge: Bloodvenom
.abandon 28646 >>Abandon The Durnholde Challenge: Infernus
.abandon 28647 >>Abandon The Durnholde Challenge: D-1000
step
#completewith next
.goto 25,59.67,63.24
.fly Ruins of Southshore >>Fly to Ruins of Southshore, Hillsbrad
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Serge Hinott and Helcular
.goto 25,49.13,66.30
.turnin 28324 >>Turn in Studies in Lethality
.turnin 28330 >>Turn in Trail of Filth
.turnin 28325 >>Turn in Green Living
.turnin 28356 >>Turn in Preemptive Strike
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kingslayer Orkus
*Skip the cinmatic with ESC
.goto 25,50.00,74.28
.turnin 28354 >>Turn in Kasha Will Fly Again
.accept 28375 >>Accept The Road to Purgation
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kingslayer Orkus
.goto 25,29.25,83.99
.turnin 28375 >>Turn in The Road to Purgation
.accept 28397 >>Accept They Will Never Expect This...
step
*Be careful these NPCs deal a lot of damage.
>>Keep an eye out for the rare |cff00ecffDustwing|r
.unitscan Dustwing
.goto 25,27.55,84.22
.complete 28397,2 
.complete 28397,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kingslayer Orkus next to you
*Type '/reload' into the chat if you can't turn in the quest
.goto 25,27.28,88.20
.turnin 28397 >>Turn in They Will Never Expect This...
.accept 28400 >>Accept Heroes of the Horde!
step
>>Follow the path up the mountain
*Wait next to Orkus until you can talk to him and LOOT the Stormpike Battle Master after he has killed him
.goto 25,27.35,87.35
.skipgossip 1
.complete 28400,1 
step
>>Flying to Tarren Mill takes about 2 minutes.
.goto 25,57.48,46.87
.complete 28400,2 
step
.money >4999
#completewith HillsbradAcceptAFightingChance
+|cfff78300The Guide skipped the step to learn Master Riding because you have less than 5000 gold|r
step
.money <5000
#completewith SkillMasterRiding2
.goto 25,57.95,47.29
.home >>Set your Hearthstone to Tarren Mill
.vendor
step
#label HillsbradAcceptAFightingChance
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Advisor Duskingdawn
.goto 25,56.75,47.36
.accept 28495 >>Accept A Fighting Chance
step << Monk
.xp <40,1
.money <5000
.zoneskip 379
#completewith SkillMasterRiding3
.cast 126892 >>Use Zen Pilgrimage
step << Monk
.xp <40,1
.money <5000
#completewith SkillMasterRiding3
.goto 379,48.53,43.57
.zone 85 >>Take the Portal to Orgrimmar
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
#completewith SkillMasterRiding3
.goto 25,29.13,64.42
.fly Forsaken High Command, Silverpine Forest >>Fly to Forsaken High Command, Silverpine Forest
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
.goto 18,69.46,62.80
#completewith SkillMasterRiding3
.gossipoption 49018 >>Talk to Zidormi
step << !Monk
.xp <40,1
.money <5000
.isQuestAvailable 44184
#completewith SkillMasterRiding3
.goto 18,60.73,58.68
.zone 85 >>Take the portal to Orgrimmar
step << !Monk
.xp <40,1
.money <5000
.isQuestTurnedIn 44184
#completewith SkillMasterRiding3
.use 140192
.cast 222695 >>Use Dalaran Hearthstone
step << !Monk
.xp <40,1
.money <5000
.isQuestTurnedIn 44184
#completewith SkillMasterRiding3
.goto 627,55.28,23.95
.zone 85 >>Take the portal to Orgrimmar
step
.xp <40,1
.money <5000
#label SkillMasterRiding3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Mazha
.goto 85,48.93,59.28
.train 90265 >>Train Master Riding
step
.xp <40,1
.zoneskip 85,1
#completewith HillsbradHeroesoftheHorde
.hs >>Hearth to Tarren Mill
step
.xp <40,1
.money >5000
#completewith next
.skill riding,375 >>|cfff78300The guide skipped the "Train Master Riding" step because you have less than 5000 gold. Send your character gold and go back some steps if you have enough gold on another character|r
step
#label HillsbradHeroesoftheHorde
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to High Warlord Cromush
.goto 25,57.08,46.24
.turnin 28400 >>Turn in Heroes of the Horde!
.accept 28587 >>Accept Aid of the Frostwolf
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Keeper Bel'varil
.goto 25,56.99,45.72
.accept 28484 >>Accept The Heart of the Matter
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deathguard Humbert and Samsa
*If you jump backwards while standing on the stairs you can accept the quest from downstairs. Otherwise go up the stairs in the building.
.goto 25,57.16,45.55
.accept 28487 >>Accept Humbert's Personal Problems
.accept 28485 >>Accept Yetimus the Yeti Lord
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Voggah Deathgrip
*Skip the cinematic with ESC
.goto 25,58.70,34.24
.turnin 28587 >>Turn in Aid of the Frostwolf
.accept 28600 >>Accept Matters of Loyalty
step
#completewith next
.goto 25,60.37,28.92,20 >>Check for the rare Maggarrak above the AV tunnel
.unitscan Maggarrak
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to High Warlord Cromush
*Skip the cinematic with ESC
.goto 25,57.08,46.24
.turnin 28600 >>Turn in Matters of Loyalty
.accept 28506 >>Accept March of the Stormpike
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to High Warlord Cromush
.goto 25,57.08,46.24
.turnin 28506 >>Turn in March of the Stormpike
.accept 28556 >>Accept Breaking the Hand
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Melisara
.goto 25,57.27,46.35
.accept 28538 >>Accept Cry of the Banshee
step
#sticky
#label HillsbradNukeSoferasNaze
>>Use the 'Goblin Pocket-Nuke' at the waypoint location
.use 64471
.goto 25,55.48,38.34,0,0
.complete 28556,1 
step
>>Damage the Assasins until 35% HP and use the 'Banshee Mirror'
>>Keep an eye out for a chest
.use 64445
.goto 25,55.50,38.46,20,0
.goto 25,55.64,40.70
.complete 28538,1 
step
>>Click on the quest in your quest log under your minimap
.turnin 28538 >>Turn in Cry of the Banshee
.accept 28566 >>Accept Decimation
step
#requires HillsbradNukeSoferasNaze
#sticky
#label HillsbradNukeCorrahnsDagger
>>Use the |T237030:0|t[Goblin Pocket-Nuke] at the waypoint location
.use 64471
.goto 25,49.40,46.69,0,0
.complete 28556,2 
step
#requires HillsbradNukeSoferasNaze
#completewith next
>>Kill |cff00ecffStormpike Soldiers|r
.goto 25,50.20,46.59,15,0
.goto 25,49.46,46.82,15,0
.complete 28566,2 
step
#requires HillsbradNukeSoferasNaze
>>Kill |cff00ecffCaptain Iceheart|r (patrolling)
.goto 25,49.46,46.76
.complete 28566,1 
step
>>Kill |cff00ecffStormpike Soldiers|r
.goto 25,49.43,48.22,20,0
.goto 25,50.20,46.59,15,0
.goto 25,48.88,47.05
.complete 28566,2 
step
>>Click on the quest in your quest log under your minimap
.turnin 28566 >>Turn in Decimation
.accept 28603 >>Accept Infiltration
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lilith next to you
.accept 28604 >>Accept Deception and Trickery
step
#completewith next
.unitscan Jimmy the Bleeder
.goto 25,49.88,50.38,25 >>Search for Jimmy the Bleeder and check for Chest
step
#completewith next
>>Use the 'Water Barrel' next to Stormpike Trainees
*Don't use the item again until you get credit for the last trainees
.use 64583
.complete 28604,1 
step
#requires HillsbradNukeCorrahnsDagger
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Instructor Rufus and kill him
.complete 28603,1 
.goto 25,44.51,49.07
.complete 28603,3 
.goto 25,44.31,50.39
.skipgossip
step
#completewith next
.goto 25,44.20,52.32,10 >>Check possible Chest location
.goto 25,44.32,53.83,25 >>Check for Araga
.unitscan Araga
step
#sticky
#label HillsbradNukeHeadland
>>Use the |T237030:0|t[Goblin Pocket-Nuke] at the waypoint location
.use 64471
.goto 25,43.97,48.99,0,0
.complete 28556,3 
step
#completewith HillsbradTurninInfiltration
>>Use the 'Water Barrel' next to Stormpike Trainees
*Don't use the item again until you get credit for the last trainees
.use 64583
.complete 28604,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Drill Seargent Magnus
*You have to stay in meele range otherwise he may evade
.goto 25,43.41,49.97
.skipgossip
.complete 28603,2 
step
#label HillsbradTurninInfiltration
>>Click on the quest in your quest log under your minimap
.turnin 28603 >>Turn in Infiltration
step
#requires HillsbradNukeHeadland
>>Use the 'Water Barrel' next to Stormpike Trainees
*Don't use the item again until you get credit for the last trainees
.use 64583
.goto 25,44.65,48.99,20,0
.goto 25,44.14,50.89,20,0
.goto 25,44.16,52.43,20,0
.goto 25,44.14,50.89
.complete 28604,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lilith next to you
.turnin 28604 >>Turn in Deception and Trickery
.accept 28605 >>Accept Domination
step
#sticky
#label HillsbradStormpikeEngineer
>>Kill |cff00ecffStormpike Engineers|r
.goto 25,39.93,48.52,0,0
.complete 28605,1 
step
>>Use the |T237030:0|t[Goblin Pocket-Nuke] at the waypoint location
.use 64471
.goto 25,39.48,49.06
.complete 28556,4 
step
#requires HillsbradStormpikeEngineer
#completewith next
>>Use |T135468:0|t[Duskingdawn's Wand]. |cfff78300Make sure to stay far away from the fawns otherwise they may attack you which will result in your death|r
.use 64416
.complete 28495,1 
step
#requires HillsbradStormpikeEngineer
#completewith next
.goto 25,46.62,54.41,10 >>Enter the cave
step
#requires HillsbradStormpikeEngineer
#sticky
#label HillsbrandBeatingYetiHeart
>>Kill |cff00ecffCave Yetis|r. Loot them for their hearts
.complete 28484,1 
step
#requires HillsbradStormpikeEngineer
>>Pick up the glowing sword
.goto 25,45.09,51.34
.complete 28487,1 
step
>>Pick up the small helm
.goto 25,45.53,52.26,8,0
.goto 25,45.86,51.54,10,0
.goto 25,44.58,50.93
.complete 28487,2 
step
#completewith next
.goto 25,45.86,51.54,20,0
.goto 25,45.77,53.39,20 >>Search for Weevil
.unitscan Weevil
step
>>Pick up the pants
.goto 25,43.79,55.16,15,0
.goto 25,44.09,53.21
.complete 28487,3 
step
#completewith next
.goto 25,45.51,52.11,10,0
.goto 25,44.78,53.30,15,0
.goto 25,46.51,54.28,10 >>Leave the cave
step
#sticky
#label HillsbradHillFawnSaved
>>Use |T135468:0|t[Duskingdawn's Wand]. |cfff78300Make sure to stay far away from the fawns otherwise they may attack you which will result in your death|r
.goto 25,44.61,57.82,30,0
.goto 25,45.22,60.38,30,0
.goto 25,48.77,55.69,20,0
.goto 25,50.03,55.52,30,0
.goto 25,48.56,53.08,30,0
.goto 25,48.77,55.69
.use 64416
.complete 28495,1 
step
.isOnQuest 28485
>>VERY HARD Elite. Might not even kill him with Heirlooms.
*Within a party you should be able to kill him. You can skip this.
.goto 25,48.37,56.74
.complete 28485,1 
step
#requires HillsbradHillFawnSaved
#completewith next
.goto 25,55.86,54.57,35 >>Search for Chordix
.unitscan Chordix
step
#requires HillsbradHillFawnSaved
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Advisor Duskingdawn
.goto 25,56.74,47.47
.turnin 28495 >>Turn in A Fighting Chance
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Melisara
.goto 25,57.25,46.35
.turnin 28605 >>Turn in Domination
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to High Warlord Cromush
*Skip the cinematic with ESC
.goto 25,57.08,46.23
.turnin 28556 >>Turn in Breaking the Hand
.accept 28616 >>Accept Stormpike Apocalypse
.turnin 28616 >>Turn in Stormpike Apocalypse
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Keeper Bel'varil
.goto 25,57.00,45.73
.turnin 28484 >>Turn in The Heart of the Matter
step
.isQuestComplete 28485
.goto 25,57.19,45.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deathguard Samsa
.turnin 28485 >>Turn in Yetimus the Yeti Lord
step
.abandon 28485
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Deathguard Humbert
.goto 25,57.16,45.53
.turnin 28487 >>Turn in Humbert's Personal Problems
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Horde 10-60
#name 6 Horde Spires of Arak
#displayname Chapter 7 - Spires of Arak
#next 7 Horde Gorgrond
#veteran
<< Horde
step
.zoneskip 590
#completewith next
.cast 171253 >>Use your Garrison Hearthstone
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Murla Longeye
.accept 36862 >>Accept Pinchwhistle Gearworks
step
>>Open the Adventure Guide (Shift + J), click on the right arrow until you see 'Spires of Arak', click 'Start Quest'
.accept 36951 >>Accept Arakkoa Exodus
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bron Skyhorn the Flight Master to be flown out to Spires of Arak.
.skipgossip 3
.turnin 36951 >> Turn in Arakkoa Exodus
.accept 34655 >> Accept Password spoken to Reshad
.goto 542,37.89,18.02
step
.goto 542,36.81,17.14
.turnin 36243 >>Loot the Outcast's Belongings within the mountains
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Reshad
.goto 542,43.65,12.93
.skipgossip 79519
.complete 36243,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Reshad
.goto 542,43.65,12.93
.turnin 34655 >>Turn in The Shadows of Skettis
.accept 34656 >>Accept Hidden in Plain Sight
.accept 34657 >>Accept Adherents of the Sun God
step
#completewith SpiresofArakHiddenInPlainSight
>>Kill |cff00ecffAdherent Bladewings|r
.complete 34657,1 
step
>>Pick up the Wingblades
.goto 542,41.23,16.27
.complete 34656,1 
step
>>|cfff78300Keep the item for later|r
.goto 542,43.91,15.03
.turnin 36395 >>Pick up the Elixir of Shadow Sight
step
#label SpiresofArakHiddenInPlainSight
>>Pick up the Ragged Mask
.goto 542,44.93,15.14
.complete 34656,2 
step
>>Kill |cff00ecffAdherent Bladewings|r
.goto 542,45.62,13.06,25,0
.goto 542,43.63,14.16,30,0
.goto 542,41.56,16.22,30,0
.goto 542,45.62,13.06
.complete 34657,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Reshad
.goto 542,43.65,12.93
.turnin 34656 >>Turn in Hidden in Plain Sight
.turnin 34657 >>Turn in Adherents of the Sun God
.accept 34658 >>Accept Orders From On High
step
>>Kill |cff00ecffSun-Sage Rathyx. Loot him for the proclamation
*When he or his bird cast Blinding Flash/Flash Bang |cfff78300look away|r
*|cfff78300Interrupt Solar Radiance (50% heal)|r
.goto 542,45.97,15.43
.complete 34658,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Reshad
.goto 542,45.39,18.26
.turnin 34658 >>Turn in Orders From On High
.accept 34659 >>Accept The Crone
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Reshad again
.goto 542,45.39,18.26
.skipgossip 1
.train 78670 >>Train Apprentice Archaeology
step
.goto 542,42.96,16.37
.turnin 36245 >>Pick up the Relics of the Outcasts
step
.goto 542,42.70,18.32
.turnin 36244 >>Pick up the Misplaced Scrolls
step
.goto 542,50.51,22.10
.turnin 36246>>Pick up the Fractured Sunstone in the water
step
>>Try to not loot it just close the loot window. This skips the knockup
.goto 542,50.32,25.80
.turnin 36444 >>Pick up the Iron Horde Explosives
step
.goto 542,50.75,28.74
.turnin 36247 >>Pick up the Lost Herb Satchel
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ornekka
.goto 542,51.62,31.37
.skipgossip 79890,1
.complete 34659,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ornekka and Reshad
.goto 542,51.62,31.37
.turnin 34659 >>Turn in The Crone
.accept 34756 >>Accept A Charming Deception
.accept 35636 >>Accept All Due Respect
.accept 34805 >>Accept Echo Hunters
step
#completewith SpiresofArakAllDueRespect
>>Kill |cff00ecffEcho Hunters|r
.complete 34805,1 
step
#title Illusion Charm 1
>>Pick up the Illusion Charm
.goto 542,50.97,31.31
.complete 34756,1,1 
step
#title Illusion Charm 2
>>Pick up the Illusion Charm
.goto 542,51.31,33.58
.complete 34756,1,2 
step
#title Illusion Charm 3
>>Pick up the Illusion Charm
.goto 542,51.83,36.40
.complete 34756,1,3 
step
#title Illusion Charm 4
>>Pick up the Illusion Charm
.goto 542,51.13,36.50
.complete 34756,1,4 
step
>>Interact with the corpse of Syth
.goto 542,50.26,36.38
.complete 35636,1 
step
>>Interact with Syth's Bookcase. Defeat the three incoming waves afterwards
*If you see Echo Hunter nearby, kill them
.goto 542,50.02,36.73
.complete 35636,2 
step
#label SpiresofArakAllDueRespect
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Reshad
.goto 542,50.28,36.70
.turnin 35636 >>Turn in All Due Respect
.accept 35668 >>Accept Syth's Secret
step
#completewith SpiresofArakSythsSecret
>>Kill |cff00ecffEcho Hunters|r
.goto 542,50.46,34.97,20,0
.goto 542,51.27,38.71,30,0
.complete 34805,1 
step
#title Illusion Charm 5
>>Pick up the Illusion Charm
.goto 542,50.40,40.05
.complete 34756,1,5 
step
.goto 542,49.20,37.30
.turnin 36445 >>Pick up Assassin's Spear
step
#completewith next
.goto 542,49.06,41.26,10 >>Enter the cave
step
#label SpiresofArakSythsSecret
>>Kill |cff00ecffSun-Talon Oberyx|r. Loot him for his eye
*Dodge the chakrams (void zones)
.goto 542,48.34,42.87
.complete 35668,1 
step
>>Kill |cff00ecffEcho Hunters|r
.goto 542,47.79,42.68,25,0
.goto 542,48.90,43.08,25,0
.goto 542,50.04,39.01
.complete 34805,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Reshad
.goto 542,48.56,44.48
.turnin 34756 >>Turn in A Charming Deception
.turnin 34805 >>Turn in Echo Hunters
.turnin 35668 >>Turn in Syth's Secret
.accept 35671 >>Accept A Gathering of Shadows
step
#completewith next
.use 115463
.cast 170183 >>Use the Elixier of Shadow Sight
step
.goto 542,48.58,44.49
.turnin 36386 >>Pick up the Gift of Anzu
step
>>Wait at the waypoint
.goto 542,46.51,45.61
.complete 35671,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Shadow-Sage Iskar
.goto 542,46.51,45.61
.turnin 35671 >>Turn in A Gathering of Shadows
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Shadow Hunter Ukambe
.goto 542,45.89,46.37
.accept 35272 >>Accept One of Our Own
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Shadow-Sage Iskar
.goto 542,46.51,45.61
.skipgossip
.complete 35272,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Shadow Hunter Ukambe
.goto 542,45.89,46.36
.turnin 35272 >>Turn in One of Our Own
.accept 35275 >>Accept Inspecting the Troops
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Shadow Hunter Ukambe
.goto 542,40.07,44.05
.turnin 35275 >>Turn in Inspecting the Troops
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taskmaster Gornek
.goto 542,40.19,43.50
.accept 35277 >>Accept Orders, Commander?
step
>>Interact with the Drafting Table and select 'Home Away From Home' (Hearthfire Tavern on the left)
.goto 542,40.19,43.50
.complete 35277,1 
.complete 35277,2 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taskmaster Gornek
.goto 542,40.18,43.50
.turnin 35277 >>Turn in Orders, Commander?
.accept 37326 >>Accept Befriending the Locals
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Percy
.goto 542,40.10,43.97
.accept 35611 >>Accept Return to Veil Terokk
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dusk-Seer Irizzar
.goto 542,43.90,48.91
.turnin 37326 >>Turn in Befriending the Locals
.accept 37296 >>Accept A Lack of Wasps
step
>>Kill |cff00ecffWidow Wasps|r
.goto 542,44.63,49.50,20,0
.goto 542,43.23,50.56,20,0
.goto 542,43.53,47.20
.complete 37296,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dusk-Seer Irizzar
.goto 542,43.90,48.92
.turnin 37296 >>Turn in A Lack of Wasps
.accept 37328 >>Accept Not Here, Not Now
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Reshad and Shadow-Sage Iskar
.turnin 35611 >>Turn in Return to Veil Terokk
.accept 34998 >>Accept Talon Watch
.accept 34884 >>Accept The Kaliri Whisperer
.goto 542,45.87,45.73
.accept 34827 >>Accept Last of the Talonpriests
.goto 542,45.94,45.78
step
.goto 542,45.94,44.17
.turnin 36354 >>Pick up Relics of the Outcasts on the rope
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tInteract with Skizziks corpse
.goto 542,45.43,36.32
.skipgossip
.complete 34884,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Skizzik and the Kaliri Egg
.accept 34885 >>Accept Mother of Thorns
.goto 542,45.43,36.32
.accept 34838 >>Accept Ikky's Egg
.goto 542,45.39,36.74
step
>>Click on the egg
.goto 542,45.39,36.74
.complete 34838,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalkTalk to Ikky
.goto 542,45.39,36.74
.turnin 34838 >>Turn in Ikky's Egg
.accept 34886 >>Accept Baby Bird
step
#completewith next
>>Kill |cff00ecffShadeback Ravagers|r and pick up Ravager Grubs
.complete 34886,1 
.complete 34885,1 
step
>>Kill the |cff00ecffShadeback Thornmother|r
.goto 542,44.19,37.96
.complete 34885,2 
step
>>Kill |cffShadeback Ravager|r and pick up Ravager Grubs (small maggots)
.goto 542,45.10,37.92
.complete 34886,1 
.complete 34885,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ikky
.goto 542,45.40,36.75
.turnin 34886 >>Turn in Baby Bird
step
.goto 542,47.77,36.11
.turnin 36411 >>Pick up the Lost Ring in the water
step
>>Use the |T134711:0|t[Elixier of Shadows]
.use 112100
.goto 542,47.98,34.69
.complete 34827,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Talonpriest Ishaal
.goto 542,48.01,34.76
.turnin 34827 >>Turn in Last of the Talonpriests
.accept 34828 >>Accept Ishaal's Orb
.accept 34829 >>Accept New Neighbors
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ravager Egg
.goto 542,47.13,31.66
.accept 36425 >>Accept Egg Punt
step
#completewith SpiresofArakIshaalsOrb
>>Kill |cff00ecffShattered Hand Orcs|r
.complete 34829,1 
step
#completewith SpiresofArakIshaalsOrb
>>Click on the Ravager Eggs on the ground
.complete 36425,1 
step
.goto 542,47.93,30.66
.turnin 36361 >>Pick up the Shattered Hand Lockbox
step
#label SpiresofArakIshaalsOrb
>>Pick up Ishaal's Orb
.goto 542,48.09,28.47
.complete 34828,1 
step
#completewith next
>>Kill |cff00ecffShattered Hand Orcs|r
*|cfff78300Dodge the Blade Flurries to the side|r
.complete 34829,1 
step
>>Click on the Ravager Eggs on the ground
.goto 542,46.62,29.37,25,0
.goto 542,47.14,31.56,25,0
.goto 542,47.33,30.56
.complete 36425,1 
step
>>Finish killing |cff00ecffShattered Hand Orcs|r
.goto 542,47.33,30.56
.complete 34829,1 
step
#sticky
#label SpiresofArakEggPunt
>>Click on the quest in the quest log under your minimap
.turnin 36425 >>Turn in Egg Punt
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Talonpriest Ishaal
.goto 542,48.01,34.75
.turnin 34828 >>Turn in Ishaal's Orb
.turnin 34829 >>Turn in New Neighbors
.accept 34830 >>Accept Behind the Veil
step
.goto 542,46.92,34.04
.turnin 36446 >>Pick up the Outcast's Poach from the dead Arrakoa Outcast on the tree
step
>>Use the |T134711:0|t[Major Elixir of Shadows]
.use 112099
.goto 542,44.48,24.01
.complete 34830,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Talonpriest Zellek
.goto 542,44.48,24.01
.turnin 34830 >>Turn in Behind the Veil
step
.goto 542,43.82,24.63
.turnin 36397 >>Pick up the Elixir of Shadow Sight
step
.goto 542,43.21,27.26
.turnin 36355 >>Pick up the Relics of the Outcasts located in the trees.
step
#completewith next
.cast 168499 >>Use Home Away From Home (|cfff78300Zone Ability not your Hearthstone|r)
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taskmaster Gornek
.goto 542,40.19,43.50
.turnin 37328 >>Turn in Not Here, Not Now
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ikky
.goto 542,46.20,45.69
.turnin 34898 >>Turn in Ikky
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Reshad
.goto 542,45.87,45.74
.turnin 34884 >>Turn in The Kaliri Whisperer
.turnin 34885 >>Turn in Mother of Thorns
step
.goto 542,48.35,52.61
.turnin 36405 >>Pick up the Offering of the Raven Mother
step
#completewith next
.use 118267
.cast 174031 >>Use the Ravenmother Offering
step
.goto 542,48.91,54.71
.turnin 36406 >>Pick up the Offering of the Raven Mother
step
#completewith next
.use 118267
.cast 174031 >>Use the Ravenmother Offering
step
.goto 542,53.32,55.51
.turnin 36403 >>Pick up the Offering of the Raven Mother
step
#completewith next
.use 118267
.cast 174031 >>Use the Ravenmother Offering
step
.goto 542,60.97,63.88
.turnin 36410 >>Pick up the Offering of the Raven Mother
step
#completewith next
.use 118267
.cast 174031 >>Use the Ravenmother Offering
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kimzee Pinchwhistle and Engineer Gazwitz
.goto 542,61.47,72.94
.turnin 36862 >>Turn in Pinchwhistle Gearworks
.accept 35077 >>Accept Defungination
.accept 35079 >>Accept Spore-be-Gone
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Exterminator Lemmy
.goto 542,62.57,73.91
.accept 36179 >>Accept Unwanted Pests
step
#completewith SpiresofArakSporebeGone
>>Kill |cff00ecffSport Drifter|r. Avoid Fungal Hulks
.complete 36179,1 
step
#completewith SpiresofArakSporebeGone
>>Use the |T134538:0|t [QR58 Flame Blaster] to burn the yellow/green spores on the ground
.use 112683
.complete 35077,1 
step
#title Turret 1
>>Activate the turret
.goto 542,63.16,73.92,20,0
.goto 542,63.59,74.08
.complete 35079,1,1 
step
#title Turret 2
>>Activate the turret
.goto 542,64.49,74.26
.complete 35079,1,2 
step
#title Turret 3
>>Activate the turret
.goto 542,64.76,74.23
.complete 35079,1,3 
step
#title Turret 4
>>Activate the turret
.goto 542,64.36,75.01,15,0
.goto 542,63.72,74.94
.complete 35079,1,4 
step
#title Turret 5
>>Activate the turret
.goto 542,63.36,75.78
.complete 35079,1,5 
step
#label SpiresofArakSporebeGone
#title Turret 6
>>Activate the turret
.goto 542,63.63,76.41
.complete 35079,1 
step
#completewith next
>>Kill |cff00ecffSport Drifter|r. Avoid Fungal Hulks. The QR58 Flame Baster also damages these mobs
.complete 36179,1 
step
#completewith SpiresofArakSporebeGone
>>Use the |T134538:0|t[QR58 Flame Blaster] to burn the yellow/green spores on the ground
.use 112683
.goto 542,62.68,76.40,20,0
.goto 542,63.60,75.34,20,0
.goto 542,64.57,75.18,20,0
.goto 542,63.31,74.30
.complete 35077,1 
step
#completewith next
>>Kill |cff00ecffSport Drifter|r. Avoid Fungal Hulks
.goto 542,62.68,76.40,20,0
.goto 542,63.60,75.34,20,0
.goto 542,64.57,75.18,20,0
.goto 542,63.31,74.30
.complete 36179,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kimzee Pinchwhistle and Engineer Gazwitz
.goto 542,61.46,72.95
.turnin 35077 >>Turn in Defungination
.turnin 35079 >>Turn in Spore-be-Gone
.turnin 36179 >>Turn in Unwanted Pests
.accept 35080 >>Accept The Mother Lode
step
.itemcount 132516,1
#completwith next
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
>>Follow the arrow
.goto 542,59.12,79.18
.complete 35080,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kimzee Pinchwhistle and Engineer Gazwitz
.turnin 35080 >>Turn in The Mother Lode
.accept 35082 >>Accept Getting the Crew Back Together
.goto 542,59.12,79.18
.accept 35081 >>Accept Clearing Out Before Cleaning Up
.goto 542,59.10,79.23
step
#completewith SpiresofArakGettingtheCrewBackTogether
>>Kill |cff00ecffCrimsonwing Wasps|r
.complete 35081,1 
step
#title Crew Revived 1
>>Click on the Injured Crewmans
.goto 542,60.25,79.77
.complete 35082,1,1 
step
#title Crew Revived 2
>>Click on the Injured Crewmans
.goto 542,60.43,80.66
.complete 35082,1,2 
step
#title Crew Revived 3
>>Click on the Injured Crewmans
.goto 542,60.19,81.49
.complete 35082,1,3 
step
#title Crew Revived 4
>>Click on the Injured Crewmans
.goto 542,60.54,81.65
.complete 35082,1,4 
step
#title Crew Revived 5
>>Click on the Injured Crewmans
.goto 542,60.43,82.33
.complete 35082,1,5 
step
#label SpiresofArakGettingtheCrewBackTogether
#title Crew Revived 6
>>Click on the Injured Crewmans
.goto 542,60.00,82.09
.complete 35082,1 
step
>>Kill |cff00ecffCrimsonwing Wasps|r
.goto 542,59.20,81.89,25,0
.goto 542,60.91,82.22,20,0
.goto 542,59.91,80.80
.complete 35081,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kimzee Pinchwhistle and Engineer Gazwitz
.goto 542,59.11,79.20
.turnin 35082 >>Turn in Getting the Crew Back Together
.turnin 35081 >>Turn in Clearing Out Before Cleaning Up
.accept 35285 >>Accept Follow that Hotrod!
step
>>Talk to Kimzee Pinchwhistle and Kimzee Pinchwhistle and Krixel Pinchwhistle
.turnin 35285 >>Turn in Follow that Hotrod!
.accept 35090 >>Accept The Right Parts for the Job
.accept 35089 >>Accept Skimming Off the Top
.goto 542,58.48,92.33
.accept 36384 >>Accept Field Trial
.goto 542,58.49,92.20
step
#completewith next
.goto 542,58.81,91.99
.vendor
step
.goto 542,59.15,90.63
.turnin 36366 >>Pick up the bottle in the small building
step
#completewith next
>>Kill |cff00ecffVolatile Sludge|r. Loot them for the oil
.complete 35089,1 
step
>>Use the |T133032:0|t[G-14 Buster Rocket] to destroy Broken Shredder and pick up the spawning gears
.goto 542,59.32,89.90,20,0
.goto 542,59.81,87.54,20,0
.goto 542,58.95,88.51,20,0
.goto 542,58.29,89.51,20,0
.goto 542,57.94,90.36
.use 112698
.complete 35090,1 
step
>>Kill |cff00ecffVolatile Sludge|r. Loot them for the oil
.goto 542,59.31,88.91
.complete 35089,1 
step
>>Use |T609895:0|t[Vial of Untested Serum] on an Infected Lumberjack
.goto 542,58.64,87.10
.use 115457
.complete 36384,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Krixel Pinchwhistle
.goto 542,58.49,92.21
.turnin 36384 >>Turn in Field Trial
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kimzee Pinchwhistle
.goto 542,58.83,92.84
.turnin 35089 >>Turn in Skimming Off the Top
.turnin 35090 >>Turn in The Right Parts for the Job
.accept 35091 >>Accept Sporicide
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Krixel Pinchwhistle
.goto 542,58.48,92.20
.accept 35211 >>Accept Preventing the Worst
.accept 36428 >>Accept Curing With Force
step
#completewith next
>>Kill |cff00ecffSpore Shamblers|r
.complete 35091,1 
step
#completewith next
>>Use |T609892:0|t[Vial of Refined Serum] on |cff00ecffInfected Bruisers|r or |cff00ecffInfected Bar Patrons|r below 30% HP
.use 115533
.complete 36428,1 
step
#title Bomb Placed 1
>>Place the bomb inside the small building
.goto 542,56.62,89.99
.complete 35211,1,1 
step
#title Bomb Placed 2
>>Place the bomb
.goto 542,56.46,89.45
.complete 35211,1,2 
step
>>Kill |cff00ecffSpore Shamblers|r
.goto 542,54.91,87.97
.complete 35091,1 
step
#completewith SpiresofArakPreventingtheWorst
>>Use |T609892:0|t[Vial of Refined Serum] on |cff00ecffInfected Bruisers|r or |cff00ecffInfected Bar Patrons|r below 30 HP
.use 115533
.complete 36428,1 
step
#title Bomb Placed 3
>>Place the bomb
.goto 542,55.69,90.99
.complete 35211,1,3 
step
#title Bomb Placed 4
>>Place the bomb
.goto 542,56.29,91.61
.complete 35211,1,4 
step
#label SpiresofArakPreventingtheWorst
#title Bomb Placed 5
>>Place the bomb
.goto 542,56.74,91.56
.complete 35211,1 
step
>>Use |T609892:0|t[Vial of Refined Serum] on |cff00ecffInfected Bruisers|r or |cff00ecffInfected Bar Patrons|r below 30 HP
.use 115533
.goto 542,56.20,90.70,20,0
.goto 542,58.28,87.30,40,0
.goto 542,56.20,90.70
.complete 36428,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kimzee Pinchwhistle and Krixel Pinchwhistle
.turnin 35091 >>Turn in Sporicide
.goto 542,58.82,92.83
.turnin 35211 >>Turn in Preventing the Worst
.turnin 36428 >>Turn in Curing With Force
.accept 35298 >>Accept Flame On
.goto 542,58.49,92.20
step
>>Interact with the Plunger
.goto 542,58.51,92.22
.complete 35298,1 
step
>>Mount the Repaird Flying Machine
.goto 542,58.87,92.86
.complete 35298,2 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kimzee Pinchwhistle
.goto 542,61.60,72.85
.turnin 35298 >>Turn in Flame On
.turnin 36062 >>Turn in Kimzee Pinchwhistle
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Horde 10-60
#name 7 Horde Gorgrond
#displayname Chapter 8 - Gorgrond
#veteran
<< Horde
step
.zoneskip 590
#completewith FrostfireRidgeAcceptGutGuttra
.cast 171253 >>Use your Garrison Hearthstone
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Warmaster Zog next to the Innkeeper.
.accept 34462 >>Accept Winds of Change
step
>>Mount up and fly east. Waypoints aren't able to be shown inside of a Garrison. Click on Olin Umberhide inside the cave.
.goto 525,57.29,62.90
.complete 34462,1 
step
#label FrostfireRidgeAcceptGutGuttra
.goto 525,66.02,49.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly east and Talk to Outrider Urukag
.accept 33132 >>Accept Gut Guttra
step
>>Kill |cff00ecffGrimfrost Ogres|r and free Captured Frostwolves
.goto 525,66.33,47.49,20,0
.goto 525,67.19,49.06,20,0
.goto 525,67.96,48.51,30,0
.goto 525,67.14,46.70
.complete 33145,1 
.complete 33145,2 
step
>>Kill |cff00ecffGuttra Wolfchew|r
.goto 525,68.27,45.53
.complete 33132,1 
step
.goto 525,66.06,49.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Outrider Urukag
.turnin 33132 >>Turn in Gut Guttra
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly to Gorgrond and talk to Durotan
.goto 543,37.28,77.01
.accept 33543 >>Accept The Laughing Skull
step
>>Follow the arrow
.goto 543,38.42,74.29
.complete 33543,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ripfist
.goto 543,38.77,73.62
.turnin 33543 >>Turn in The Laughing Skull
.accept 33544 >>Accept Goren, Goren, Gone!
step
#sticky
#label GorgrondAcidtoothDevourers
>>Kill |cff00ecffAcidtooth Devourers|r and turn in the quest under your minimap
.goto 543,40.81,73.87,0,0
.complete 33544,1 
.turnin 33544 >>Turn in Goren, Goren, Gone!
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kaz the Shrieker
.goto 543,39.33,71.98
.accept 33548 >>Accept We Die Laughing!
step
#title Mask 1
>>Interact with the Dead Laughing Skull
.goto 543,39.66,72.46
.complete 33548,1,1 
step
.goto 543,40.01,72.26
.turnin 36170 >>Pick up the bone
step
#title Mask 2
>>Interact with the Dead Laughing Skull
.goto 543,40.21,72.52
.complete 33548,1,2 
step
.goto 543,40.48,71.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Limbflayer
.accept 33563 >>Accept Eye Candy
step
#title Mask 3
>>Interact with the Dead Laughing Skull
.goto 543,41.12,72.26
.complete 33548,1,3 
step
>>Kill |cff00ecffSkothwa|r. Loot him for his eye
.goto 543,41.46,72.68
.complete 33563,1 
step
#title Mask 4
>>Interact with the Dead Laughing Skull
.goto 543,41.14,72.87
.complete 33548,1,4 
step
#title Mask 5
>>Interact with the Dead Laughing Skull
.goto 543,41.06,73.74
.complete 33548,1 
step
#requires GorgrondAcidtoothDevourers
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Limbflayer, Kaz and Durotan
.goto 543,41.48,74.13
.turnin 33563 >>Turn in Eye Candy
.turnin 33548 >>Turn in We Die Laughing!
.accept 33593 >>Accept A Flare for the Dramatic
step
>>Use 'Penny's Flare Gun'
.use 115534
.goto 543,41.38,74.10
.complete 33593,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Durotan
*Skip the next cinematic with ESC
.goto 543,41.49,74.08
.turnin 33593 >>Turn in A Flare for the Dramatic
.accept 36434 >>Accept Penny From Heaven
step
.turnin 36621 >>Pick up the Explorer Canister in the water
.goto 543,40.37,76.60
step
.turnin 36658 >>Pick up the Evermorn Supply Cache
.goto 543,41.82,78.04
step
.turnin 35709 >>Pick up the Laughing Skull Cache on the tree.
.goto 543,44.19,74.23
step
.turnin 36118 >>Pick up the Pile of Rubble
.goto 543,43.94,70.49
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Penny Clobberbottom
.goto 543,45.69,70.59
.turnin 36434 >>Turn in Penny From Heaven
.accept 36460 >>Accept Just Another Stick in the Wall
step
>>Interact with 'Penny's Plunger'
.goto 543,45.69,70.59
.complete 36460,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Durotan
.goto 543,45.86,70.30
.turnin 36460 >>Turn in Just Another Stick in the Wall
.accept 35151 >>Accept Your Base, Your Choice
step
*|cfff78300Select the right building 'Savage Fight Club'|r
.goto 543,45.85,70.26
.complete 35151,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Durotan
.goto 543,46.10,70.19
.turnin 35151 >>Turn in Your Base, Your Choice
.accept 35880 >>Accept Rage and Wisdom
step
#completewith next
.goto 543,45.98,69.71
.home >>Set your Hearthstone to Beastwatch
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Limbflayer
.goto 543,46.33,69.71
.accept 34697 >>Accept A Rediscovered Legend
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marrow
.goto 543,46.29,69.98
.accept 35667 >>Accept Skulltakers in Crimson Fen
.accept 33694 >>Accept Reagents from Rakthoth
step
.itemcount 132516,1
#completwith next
.cooldown item,132516,>0,1
.cast 202844 >>Use |T1405809:0|t[Gunshoes]
step
#completewith next
>>You have 60 seconds to get the following 3 items after using the ability. |cfff78300Before using the ability pull some mobs and damage them until they have only ~20% HP left.
*Skip the ones you didn't get
.goto 543,45.26,79.82,30,0
.cast 164012 >>Use Champion's Honor (Zone Ability)
step
*1) Loot 'Ravager Claw' from |cff00ecffThicket Ravagers|r
*2) Loot 'Wasp Sting' from the |cff00ecffGolden Pollinator|r
*3) Loot 'Orc Thorn' from the |cff00ecffVined Guardians|r
*Skip if you don't loot it after 60 seconds.
.goto 543,45.16,78.14,20,0
.goto 543,43.52,82.00,15,0
.goto 543,42.52,82.67,15,0
.goto 543,40.59,83.83,15,0
.goto 543,40.13,83.24,15,0
.collect 114032,1,36097,1
.collect 114034,1,36101,1
.collect 114027,1,36091,1
.accept 36097 >>Accept Proof of Strength: Ravager Claw
.accept 36101 >>Accept Proof of Strength: Wasp Stinger
.accept 36091 >>Accept Proof of Strength: Orc Thorn
step
.goto 543,43.57,90.18
.accept 36520 >>Accept Tailthrasher Basin (Bonus Objective)
step
#completewith next
#title Destroy Rope Spikes
.goto 543,43.57,90.78,10,0
.complete 36520,2 
step
#completewith next
.goto 543,44.73,90.17,8 >>Enter the cave
step
>>Kill |cff00ecffSkull Trash|r
.goto 543,44.43,88.89
.complete 36520,3 
step
#sticky
#label GorgrondJungleAxebeakFreed
#title Destroy Rope Spikes
.goto 543,45.13,90.61,10,0
.goto 543,44.57,91.58,10,0
.goto 543,45.93,89.72,10,0
.complete 36520,2 
step
>>Kill |cff00ecffTailthrasher Saberons|r
.goto 543,44.18,91.01,0,0
.complete 36520,1 
step
#requires GorgrondJungleAxebeakFreed
.goto 543,49.29,81.57
.accept 35881 >>Accept Ruins of the First Bastion (Bonus Objective)
step
#sticky
#label GorgrondFrenziedPodlingsSlain
>>Kill |cff00ecffFrenzied Podlings|r
.goto 543,50.69,79.66,0,0
.complete 35881,1 
step
#title Ancient Jar 1
.goto 543,49.72,80.42
.complete 35881,2,1 
step
#title Ancient Jar 2
.goto 543,49.85,80.34
.complete 35881,2,2 
step
#title Ancient Jar 3
.goto 543,50.57,80.09
.complete 35881,2,3 
step
#title Ancient Jar 4
.goto 543,50.47,80.55
.complete 35881,2,4 
step
#title Ancient Jar 5
.goto 543,51.09,80.96
.complete 35881,2,5 
step
#title Ancient Jar 6
.goto 543,51.26,80.71
.complete 35881,2,6 
step
.goto 543,52.08,81.25
.complete 35881,3 
step
#title Ancient Jar 7
.goto 543,51.74,80.49
.complete 35881,2,7 
step
#title Ancient Jar 8
.goto 543,51.65,79.85
.complete 35881,2 
step
#requires GorgrondFrenziedPodlingsSlain
.goto 543,48.49,75.19
.accept 36500 >>Accept The Razorbloom (Bonus Objective)
step
#completewith next
>>Walk over the slimes
.complete 36500,3 
step
.goto 543,48.38,73.97,20,0
.goto 543,47.12,74.81,20,0
.goto 543,47.04,73.27,20,0
.goto 543,47.85,72.54
.complete 36500,1 
step
#sticky
#label GorgrondToxicSlimemold
>>Walk over the slimes on your flying mount.
.goto 543,48.25,73.02,0,0
.complete 36500,3 
step
.goto 543,49.43,71.65
.complete 36500,2 
step
#requires GorgrondToxicSlimemold
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bony Xuk
.goto 543,43.56,65.01
.turnin 35880 >>Turn in Rage and Wisdom
.accept 35248 >>Accept A Harsh Reminder
.accept 35035 >>Accept Seedbearers of Bad News
step
#completewith next
>>You have 60 seconds to get the following 3 items after using the ability. |cfff78300Before using the ability pull some mobs and damage them until they have only ~20% HP left.
*Skip the ones you didn't get
.cast 164012 >>Use Champion's Honor (Zone Ability)
step
*1) Loot 'Gronnling Scale' from 'Gronnling Bonebreaker'
*2) Loot 'Acid-Stained Goren Tooth' from the 'Goren Gouger'
*3) Loot 'Botani Bloom' from 'Botani Greensworn'
*Skip the items you haven't looted after 60 seconds.
.goto 543,44.02,64.88,15,0
.goto 543,44.52,64.66,15,0
.goto 543,45.41,63.76,15,0
.collect 114021,1,36080,1
.collect 113590,1,35948,1
.collect 114025,1,36086,1
.accept 36080 >>Accept Proof of Strength: Gronnling Scale
.accept 35948 >>Accept Proof of Strength: Acid-Stained Goren Tooth
.accept 36086 >>Accept Proof of Strength: Botani Bloom
step
#sticky
#label GorgrondDenizensOfWasteland
.goto 543,44.76,64.22,0,0
.complete 35248,1 
step
>>Burn the Ancients on your flying mount.
.goto 543,44.76,64.22
.complete 35035,1 
step
#requires GorgrondDenizensOfWasteland
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bony Xuk
.goto 543,43.56,65.01
.turnin 35248 >>Turnin A Harsh Reminder
.turnin 35035 >>Turnin Seedbearers of Bad News
.accept 35025 >>Accept We Have Company
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kash'drakor, Beatface and Akaani
.goto 543,42.77,63.12
.accept 36603 >>Accept Brimstone Springs
.turnin 34697 >>Turn in A Rediscovered Legend
.accept 34698 >>Accept Slave Hunters
.accept 34700 >>Accept Nazgrel
.accept 34702 >>Accept Krav'ogra
.accept 34699 >>Accept Getting Gladiators
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Prowler Sasha
.goto 543,41.42,66.11
.accept 34012 >>Accept Need More Teeth
step
#sticky
#label GorgrondOgreTeeth
>>Kill and loot any Ogres
.goto 543,38.94,68.04,0,0
.complete 34012,1 
step
>>Kill and loot Slave Hunter Krag at the top of the building.
.goto 543,41.12,66.23
.complete 34698,2 
step
>>Break the Shackles to free Bruto
.goto 543,40.30,64.83
.complete 34699,3 
step
>>Kill and loot Slave Hunter Brol
.goto 543,40.47,66.70
.complete 34698,1 
step
>>Interact with the Gong until Slavemaster Ok'mok jumps down
*You have to use the Gong three times and after each use you've to kill an NPC
.goto 543,40.40,67.56
.complete 34702,1 
step
>>Break the Shackles to free Y'kish
.goto 543,39.75,67.83
.complete 34699,2 
step
>>Break the Shackles to free Vaandaam inside the hut
.goto 543,39.17,67.23
.complete 34699,1 
step
>>Kill and loot Slave Hunter Mol inside the tower
.goto 543,38.99,68.73
.complete 34698,3 
step
#completewith next
.goto 543,38.58,67.38,10 >>Enter the cave
step
.goto 543,36.85,67.90
.turnin 34699 >>Turn in Getting Gladiators
.accept 34703 >>Accept The Axe of Kor'gall
step
>>Break down the Barricade and cross the bridge to the throne.
*If you're not confident then wait for your cooldown before you attack Kor'gall
.goto 543,36.25,68.78,10,0
.goto 543,36.41,69.66
.complete 34703,1 
step
*Jump down and hug the right wall
>>Open the cage
.goto 543,37.38,69.17,10,0
.goto 543,36.85,70.56
.complete 34700,1 
step
#requires GorgrondOgreTeeth
#completewith next
.goto 543,38.58,67.38,10 >>Leave the cave
step
#requires GorgrondOgreTeeth
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Prowler Sasha
.goto 543,41.43,66.09
.turnin 34012 >>Turn in Need More Teeth
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Beatface, Y'kish, Bruto, Akaani and Kash'drakor
.goto 543,42.73,63.03
.turnin 34702 >>Turn in Krav'ogra
.turnin 34703 >>Turn in The Axe of Kor'gall
.turnin 34700 >>Turn in Slave Hunters
.turnin 34698 >>Turn in Slave Hunters
.accept 35152 >>Accept The Sparring Arena
.turnin 35882 >>Turn in The Interest of Bruto
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Dying Beast
.goto 543,44.24,61.61
.skipgossip
.complete 35025,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rexxar
.goto 543,44.27,61.64
.turnin 35025 >>Turn in We Have Company
.accept 35730 >>Accept Cauterizing Wounds
step
>>Interact with the Bonfire
.goto 543,44.37,61.33
.complete 35730,1 
step
>>Interact with Nisha
.goto 543,44.26,61.60
.complete 35730,2 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rexxar
.goto 543,44.28,61.64
.turnin 35730 >>Turn in Cauterizing Wounds
.accept 35026 >>Accept On the Mend
.accept 35870 >>Accept Basilisk Butcher
step
#completewith next
>>You have 60 seconds to get the following four items after using the ability. |cfff78300Before using the ability pull some mobs and damage them until they have only ~20% HP left.
*Skip the ones you didn't get
.cast 164012 >>Use Champion's Honor (Zone Ability)
step
#sticky
#label GorgrondGonnEyeRockthrower
*1) Loot 'Gronn Eye' from 'Gronn Rockthrowers'
*Skip the items you haven't looted after 60 seconds.
.goto 543,43.86,62.71,15,0
.goto 543,43.85,63.35,15,0
.goto 543,44.74,62.84,15,0
.goto 543,45.76,64.53,15,0
.collect 114023,1,36083,1
.accept 36083 >>Accept Proof of Strength: Gronn Eye
step
*2) Loot 'Elemental Crystal' from the 'Steamfuries'
*Skip the items you haven't looted after 60 seconds.
.goto 543,45.28,62.63,15,0
.goto 543,45.38,61.77,15,0
.collect 114038,1,36106,1
.accept 36106 >>Accept Proof of Strength: Elemental Crystal
step
#requires GorgrondGonnEyeRockthrower
#completewith next
>>Kill and loot Steamfury mobs around the pools.
.goto 543,45.53,59.40,15,0
.complete 35026,1 
step
#requires GorgrondGonnEyeRockthrower
>>Kill and loot Basilisks or pick it up from Decaying Basilisks
.goto 543,44.50,60.03
.complete 35870,1 
step
>>Finish killing Steamfury mobs around the pools.
.goto 543,44.15,57.57
.complete 35026,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nisha
.goto 543,45.87,54.95
.turnin 35870 >>Turn in Basilisk Butcher
.turnin 35026 >>Turn in On the Mend
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rexxar twice
.goto 543,46.02,54.75
.skipgossip
.accept 35036 >>Accept Is This One of Yours?
.complete 35036,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bony Xuk
.goto 543,46.18,55.09
.turnin 35036 >>Turn in Is This One of Yours?
.accept 35038 >>Accept What the Bony Xuk?
.accept 35202 >>Accept Xuk Me, Right?
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rexxar
.goto 543,46.05,54.75
.accept 35037 >>Accept Bad at Breaking
.accept 35934 >>Accept Nisha's Vengeance
step
>>Kill and loot Gorger and pick up the Crystals from the corpses of Longtooth Gorgers
.loop 20,543,45.57,52.41,44.59,53.72,43.77,53.54,44.58,51.32
.complete 35038,1 
.complete 35202,1 
step
#sticky
#label GorgrondGromkarGrunt
.goto 543,47.91,52.91,0,0
.complete 35934,1 
step
>>Interact with the Orders
.goto 543,47.75,52.07
.accept 35925 >>Accept The Gronn Strategy
step
.goto 543,47.78,51.81
.complete 35037,2 
step
.goto 543,47.94,54.31
.complete 35037,1 
step
#requires GorgrondGromkarGrunt
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rexxar
.goto 543,46.04,54.75
.turnin 35037 >>Turn in Bad at Breaking
.turnin 35934 >>Turn in Nisha's Vengeance
.turnin 35925 >>Turn in The Gronn Strategy
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bony Xuk
.goto 543,46.20,55.09
.turnin 35202 >>Turn in Xuk Me, Right?
.turnin 35038 >>Turn in What the Bony Xuk?
.accept 35041 >>Accept Xuk It!
step
>>Interact with the Tunnel
.goto 543,46.92,55.38
.complete 35041,1 
step
>>Interact with the Rylak corpse
.goto 543,45.75,50.39
.complete 35041,2 
step
>>Interact with the Tunnel
.goto 543,45.75,50.39
.complete 35041,3 
step
>>Interact with the Tunnel
.goto 543,44.30,41.77
.complete 35041,4 
step
>>Interact with the corpse
.goto 543,43.16,42.30
.complete 35041,5 
step
>>Interact with the Tunnel
.goto 543,43.01,42.49
.complete 35041,6 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rexxar
.goto 543,46.04,54.74
.turnin 35041 >>Turn in Xuk It!
.accept 35129 >>Accept Leave Every Soldier Behind
.accept 35128 >>Accept Fair Warning
step
#completewith next
>>You have 60 seconds to get the following four items after using the ability. |cfff78300Before using the ability pull some mobs and damage them until they have only ~20% HP left.
*Skip the ones you didn't get
.cast 164012 >>Use Champion's Honor (Zone Ability)
step
*Loot 'Worn Ogron Horn' from the 'Ogron Spinecrushers'
*Skip the items you haven't looted after 60 seconds.
.goto 543,43.49,48.05,15,0
.goto 546,58.71,79.16,15,0
.goto 543,35.77,65.86,15,0
.collect 114019,1,36076,1
.accept 36076 >>Accept Proof of Strength: Worn Ogron Horn
step
#sticky
#label GorgrondOgronSpinecrusher
.goto 546,51.76,64.72,0,0
.complete 35128,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Corporal Thukmar anf pick up the intel afterwards.
.goto 546,46.50,57.62,20,0
.goto 546,41.17,58.75,12,0
.goto 546,44.84,85.81
.skipgossip
.complete 35129,1 
.complete 35129,2 
step
.goto 547,31.07,75.36
.complete 35128,2 
step
#requires GorgrondOgronSpinecrusher
>>Interact with the Tunnel
.goto 547,34.77,66.63
.accept 35210 >>Accept A Great Escape
.complete 35210,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bony Xuk
.goto 543,43.89,48.85
.accept 35247 >>Accept Zero Xuks Given
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bony Xuk again
.goto 543,43.89,48.85
.skipgossip
.complete 35247,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rexxar
.goto 543,43.94,48.86
.turnin 35128 >>Turn in Fair Warning
.turnin 35129 >>Turn in Leave Every Soldier Behind
.turnin 35210 >>Turn in A Great Escape
.accept 35139 >>Accept Eye in the Sky
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nisha
*Skip the next cinematic with ESC
.goto 543,43.87,48.91
.skipgossip
.complete 35139,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rexxar
.goto 543,43.94,48.86
.turnin 35139 >>Turn in Eye in the Sky
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Spirit
.goto 543,44.12,48.81
.turnin 35247 >>Turn in Zero Xuks Given
.turnin 36832 >>Turn in Get The Xuk Outta Here!
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rexxar
.goto 543,43.94,48.86
.accept 35136 >>Accept Chains of Iron
step
>>Bonus Objective
.goto 543,44.71,48.69
.accept 36480 >>Accept Valley of Destruction
step
#sticky
#label GorgrondCanyonBoulderbreak
>>Kill five Boulderbreakers around the waypoint
.goto 543,45.73,46.44
.complete 36480,1 
step
>>Break Goren Eggs and kill Nibblers around the waypoint
.goto 543,47.62,48.11
.complete 36480,2 
.complete 36480,3 
step
#requires GorgrondCanyonBoulderbreak
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rakthoth
.goto 543,49.37,49.70
.turnin 33694 >>Turn in Reagents from Rakthoth
.accept 33689 >>Accept Plant Pruning
.accept 33685 >>Accept Ambassador to the Ancient
step
#sticky
#label defendersdionor
.loop 15,543,49.80,47.63,49.46,47.19,49.82,46.36,50.28,46.09,50.89,46.31
.complete 33689,1 
step
.goto 543,50.29,47.52
.skipgossip 1
.complete 33685,1 
step
#requires defendersdionor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rakthoth
.goto 543,51.28,47.98
.turnin 33689 >>Turn in Plant Pruning
.turnin 33685 >>Turn in Ambassador to the Ancient
.accept 33662 >>Accept Beatface vs. Boulder
step
>>Interact with the Boulder
.goto 543,50.63,51.45
.complete 33662,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rakthoth
.goto 543,50.91,51.43
.turnin 33662 >>Turn in Beatface vs. Boulder
.accept 33661 >>Accept Steamscar "Reagents"
step
>>Interact with the Saberon Stash
.goto 543,51.05,51.62
.accept 33660 >>Accept The Sacking of the Saberon
step
#sticky
#label GorgrondSaberonHeart
>>Kill and loot Streamscars
.goto 543,51.86,51.27,0,0
.complete 33661,1 
step
#title Herb Bundle 1
>>Pick up the bundle
.goto 543,51.41,51.87
.complete 33660,1,1 
step
#title Herb Bundle 2
>>Pick up the bundle
.goto 543,51.66,52.47
.complete 33660,1,2 
step
#title Herb Bundle 3
>>Pick up the bundle
.goto 543,51.95,51.04
.complete 33660,1,3 
step
#title Herb Bundle 4
>>Pick up the bundle
.goto 543,53.23,50.98
.complete 33660,1,4 
step
#title Herb Bundle 5
>>Pick up the bundle
.goto 543,53.64,50.82
.complete 33660,1,5 
step
#title Herb Bundle 6
>>Pick up the bundle
.goto 543,53.70,51.20
.complete 33660,1,6 
step
#title Herb Bundle 7
>>Pick up the bundle
.goto 543,53.59,51.75
.complete 33660,1,7 
step
#title Herb Bundle 8
>>Pick up the bundle
.goto 543,53.47,51.82
.complete 33660,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rakthoth
.goto 543,52.86,51.76
.turnin 33660 >>Turn in The Sacking of the Saberon
.turnin 33661 >>Turn in Steamscar "Reagents"
.accept 33695 >>Accept Taking the Death Bloom
step
>>Kill and loot Smokemaster Snarl
.goto 543,54.27,52.61
.complete 33695,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Birchus
.goto 543,50.30,47.53
.turnin 33695 >>Turn in Taking the Death Bloom
.accept 33706 >>Accept Laying Dionor to Rest
step
>>Wait for ~5 seconds.
.goto 543,50.30,47.53
.turnin 33706 >>Turn in Laying Dionor to Rest
step
.goto 543,48.93,47.31
.turnin 36203 >>Pick up the egg inside the cave
step
>>Defeat the incoming waves
*If you're squishy only attack NPCs Rexxar is attacking and wait for him to generate some threat.
.goto 543,49.21,44.90
.complete 35136,1 
step
>>Pick up the Heart.
.goto 543,49.73,43.85
.complete 35136,2 
step
#completewith next
.hs >>Hearth to Beastwatch
step
>>Bonus Objective
.goto 543,48.88,69.68
.accept 36563 >>Accept Mistcreep Mire
step
#completewith next
>>You have 60 seconds to get the following item after using the ability. |cfff78300Before using the ability pull some mobs and damage them until they have only ~20% HP left.
*Skip the ones you didn't get
.cast 164012 >>Use Champion's Honor (Zone Ability)
step
*Loot 'Basilik Scale' from the 'Mire Basilisks'
*Skip the items you haven't looted after 60 seconds.
.goto 543,50.09,69.19,15,0
.goto 543,51.58,68.46
.collect 114036,1,36104,1
.accept 36104 >>Accept Proof of Strength: Basilisk Scale
step
#sticky
#label hydravilescale
>>Break Eggs and kill Vilescales around the waypoint
.goto 543,51.84,66.54,0,0
.complete 36563,1 
.complete 36563,2 
step
.goto 543,52.50,66.95
.turnin 36509 >>Pick up the Skull
step
#requires hydravilescale
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Grulkor
.goto 543,54.45,66.65
.turnin 35667 >>Turn in Skulltakers in Crimson Fen
.accept 35016 >>Accept Basic Skulltaking
step
#sticky
#label GorgrondFungalLurcher
.goto 543,56.79,63.49,0,0
.complete 35017,1 
step
#sticky
#label laughingskull1
#title Laughing Skull 1
>>Take the Laughing Skull from the Dead Skulltaker
.goto 543,54.56,65.58
.complete 35016,1,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dying Skulltaker
.goto 543,54.84,65.31
.accept 35017 >>Accept Skulltaker's Revenge
step
>>Kill and loot a Fungal Lurcher to collect the 'Glowing Red Pod'
.goto 543,54.84,65.31
.collect 112378,1,35021
.accept 35021 >>Accept Mysterious Pod
step
#requires laughingskull1
#title Laughing Skull 2
>>Take the Laughing Skull from the Dead Skulltaker
.goto 543,55.25,65.19
.complete 35016,1,2 
step
#title Laughing Skull 3
>>Take the Laughing Skull from the Dead Skulltaker
.goto 543,55.54,64.68
.complete 35016,1,3 
step
#title Laughing Skull 4
>>Take the Laughing Skull from the Dead Skulltaker
.goto 543,55.83,64.66
.complete 35016,1,4 
step
#title Laughing Skull 5
>>Take the Laughing Skull from the Dead Skulltaker
.goto 543,56.11,64.59
.complete 35016,1 
step
#requires GorgrondFungalLurcher
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Grulkor
.goto 543,57.20,61.95
.turnin 35016 >>Turn in Basic Skulltaking
.turnin 35017 >>Turn in Skulltaker's Revenge
.turnin 35021 >>Turn in Mysterious Pod
.accept 35027 >>Accept Clearing the Way
.accept 35029 >>Accept The Secret of the Fungus
step
#sticky
#label GorgrondFungusCoveredShamblers
.goto 543,57.31,60.74,0,0
.complete 35027,1 
step
>>Pickup the five mushrooms that are closest to the waypoint.
.goto 543,57.31,60.74
.complete 35029,1 
step
#requires GorgrondFungusCoveredShamblers
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Grulkor
.goto 543,57.20,61.95
.turnin 35027 >>Turn in Clearing the Way
.turnin 35029 >>Turn in The Secret of the Fungus
.accept 35030 >>Accept A Grim Harvest
.accept 35031 >>Accept A Heartfelt Search
step
.goto 543,58.93,62.53
.complete 35031,1 
step
>>Kill and loot Fungal Stompers
.goto 543,58.48,62.79,20,0
.goto 543,58.92,61.34,20,0
.goto 543,59.91,62.75
.complete 35030,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Grulkor
.goto 543,58.91,62.52
.turnin 35030 >>Turn in A Grim Harvest
.turnin 35031 >>Turn in A Heartfelt Search
.accept 35040 >>Accept Heart of the Fen
step
>>Slay Grulkor
*If you damage is low wait for your cooldowns.
.goto 543,61.22,61.83
.complete 35040,1 
step
>>Bonus Objective
.goto 543,61.20,57.58
.accept 36571 >>Accept Iyun Weald
step
#sticky
#label GorgrondWealdStinger
>>They fly above you. Use a ranged ability to pull them.
.complete 36571,3 
step
>>You can Right-Click the Leaflings to insta-kill them
.goto 543,61.35,56.61,15,0
.goto 543,60.88,55.54,15,0
.goto 543,61.01,54.37,15,0
.goto 543,60.61,53.62,15,0
.goto 543,61.12,53.22
.complete 36571,1 
.complete 36571,2 
step
#requires GorgrondWealdStinger
>>Bonus Objective
.goto 543,61.52,63.20
.accept 36564 >>Accept Tangleheart
step
#sticky
#label GorgrondTangleheartCultivator
.goto 543,58.60,71.52,0,0
.complete 36564,1 
step
#title Pod 1
>>Destroy the Pod.
.goto 543,61.89,63.64
.complete 36564,2,1 
step
#title Pod 2
>>Destroy the Pod.
.goto 543,62.03,65.41
.complete 36564,2,2 
step
#title Pod 3
>>Destroy the Pod.
.goto 543,61.56,66.39
.complete 36564,2,3 
step
#title Pod 4
>>Destroy the Pod.
.goto 543,60.74,65.95
.complete 36564,2,4 
step
#title Pod 5
>>Destroy the Pod.
.goto 543,59.43,65.68
.complete 36564,2,5 
step
#title Pod 6
>>Destroy the Pod.
.goto 543,59.31,66.99
.complete 36564,2,6 
step
#title Pod 7
>>Destroy the Pod.
.goto 543,59.38,67.88
.complete 36564,2,7 
step
#title Pod 8
>>Destroy the Pod.
.goto 543,59.86,68.72
.complete 36564,2,8 
step
#title Pod 9
>>Destroy the Pod.
.goto 543,60.16,69.79
.complete 36564,2,9 
step
.goto 543,59.87,71.06
.complete 36564,3 
step
#title Pod 10
>>Destroy the Pod.
.goto 543,59.39,71.03
.complete 36564,2 
step
#completewith next
>>You have 60 seconds to get the following 2 items after using the ability. |cfff78300Before using the ability pull some mobs and damage them until they have only ~20% HP left.
*Skip the ones you didn't get
.cast 164012 >>Use Champion's Honor (Zone Ability)
step
*1) Loot 'Orc Thorn' from 'Infested Behemoths'
*2) Loot 'Ancient Branch' from the 'Bloom Defender'
*Skip if you don't loot it after 60 seconds.
.goto 543,48.44,74.05,20,0
.goto 543,47.06,73.15,20,0
.goto 543,46.11,73.29,20,0
.collect 114027,1,36091,1
.collect 114030,1,36094,1
.accept 36091 >>Accept Proof of Strength: Orc Thorn
.accept 36094 >>Accept Proof of Strength: Ancient Branch
step
#requires GorgrondTangleheartCultivator
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Limbflayer
.goto 543,46.33,69.71
.turnin -35152 >>Turn in The Sparring Arena
.turnin -35948 >>Turn in Proof of Strength: Goren Tooth
.turnin -36076 >>Turn in Proof of Strength: Ogron Horn
.turnin -36080 >>Turn in Proof of Strength: Gronnling Scale
.turnin -36083 >>Turn in Proof of Strength: Gronn Eye
.turnin -36086 >>Turn in Proof of Strength: Botani Bloom
.turnin -36091 >>Turn in Proof of Strength: Orc Thorn
.turnin -36097 >>Turn in Proof of Strength: Ravager Claw
.turnin -36101 >>Turn in Proof of Strength: Wasp Stinger
.turnin -36104 >>Turn in Proof of Strength: Basilisk Scale
.turnin -36106 >>Turn in Proof of Strength: Elemental Crystal
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marrow
.goto 543,46.28,69.98
.turnin 35040 >>Turn in Heart of the Fen
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Durotan
.goto 543,46.10,70.19
.turnin 35136 >>Turn in Chains of Iron
step
.zoneskip 590
#completewith next
.cast 171253 >>Use your Garrison Hearthstone
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Warmaster Zog in front of you
.turnin 34462 >>Turn in Winds of Change
.accept 34775 >>Accept Mission Probable
step
>>Interact with the Mission Table and skip through the tutorial
*If you can't press on the mission then type '/reload' into the chat.
*Click on the first Mission then drag Olin Umberhide into the follower slot and start it.
.complete 34775,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Warmaster Zog
.turnin 34775 >>Turn in Mission Probable
step
.isQuestTurnedIn 44184
#completewith next
.use 140192
.cast 222695 >>Use Dalaran Hearthstone
step
.isQuestTurnedIn 44184
.goto 627,55.28,23.95
.zone 85 >>Take the portal to Orgrimmar
step
.isQuestAvailable 44184
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gazlowe
.accept 36706 >>Accept Ashran Appearance
step
.isQuestAvailable 44184
>>Go to the Flight Master and talk to him
.skipgossip 2
.complete 36706,1 
step
.isQuestAvailable 44184
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Stomphoof
.goto 624,45.55,34.64
.turnin 36706 >>Turn in Ashran Appearance
step
.isQuestAvailable 44184
.zoneskip 85
.goto 624,60.76,51.59,1 >>Use the Portal to Orgrimmar
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Horde 10-60
#name 99 Monk Quest Horde
#displayname Monk Quests
#next 3 Horde Vol'dun;6 Horde Spires of Arak
<< Horde Monk
step
.abandon 12103 >>Abandon Before the Storm
step
.isQuestAvailable 31834
.zoneskip 379
.cast 126892 >>Use Zen Pilgrimage
step
.isQuestAvailable 31834
.goto 379,48.53,43.57
.zone 85 >>Take the Portal to Orgrimmar
step
.isQuestAvailable 31834
.goto 85,53.17,90.53,10,0
.goto 85,40.80,80.10
.gossipoption 51903 >>Talk to Chromie
.cast 335595 >>Return to the present. If you're already in the present timeline then skip this step
step
.isQuestAvailable 31834
.zoneskip 379
.cast 126892 >>Use Zen Pilgrimage
step
.goto 379,48.60,42.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Master Hight
.accept 31834 >>Accept Begin Your Training: Master Cheng
step
.isOnQuest 31834
.goto 379,47.06,40.15
.gossipoption 41015 >>Talk to Master Cheng
step
.isOnQuest 31834
>>Wait for Master Cheng at the waypoint location and type /bow into the chat when he tells you to. Then defeat him
.emote BOW,66138
.goto 379,48.07,40.40
.complete 31834,1 
step
.goto 379,48.60,42.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly back up and talk to Master Hight
.turnin 31834 >>Turn in Begin Your Training: Master Cheng
.accept 31835 >>Accept Continue Your Training: Master Kistane
.accept 31840 >>Accept Practice Makes Perfect: Master Cheng
step
.isOnQuest 31834
.goto 379,47.06,40.15
.gossipoption 41015 >>Talk to Master Cheng
step
.isOnQuest 31840
.goto 379,48.05,39.02
.gossipoption 40841 >>Talk to Master Kistane
step
>>Wait for Master Cheng at the waypoint location, target him and type /bow into the chat when he tells you to, then defeat him
.emote BOW,66138
.goto 379,48.11,40.31
.complete 31840,1 
step
>>Wait for Master Kistane at the waypoint location, target her and type /bow into the chat when he tells you to, then defeat her
.emote BOW,65899
.goto 379,48.11,40.31
.complete 31835,1 
step
.goto 379,48.60,42.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly back up and talk to Master Hight
.turnin 31835 >>Turn in Continue Your Training: Master Kistane
.turnin -31840 >>Turn in Practice Makes Perfect: Master Cheng
.accept 31836 >>Accept Continue Your Training: Master Yoon
step
#completewith next
.isOnQuest 31836
.goto 379,48.71,40.49
.gossipoption 40843 >>Talk to Master Yoon
step
>>Wait for Master Yoon at the waypoint location, target him and type /bow into the chat when he tells you to, then defeat him
.emote BOW,66073
.goto 379,48.11,40.36
.complete 31836,1 
step
.goto 379,48.60,42.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly back up and talk to Master Hight
.turnin 31836 >>Turn in Continue Your Training: Master Yoon
.accept 31837 >>Accept Continue Your Training: Master Cheng
step
#completewith next
.isOnQuest 31837
.goto 379,48.53,41.49
.gossipoption 40975 >>Talk to Master Cheng
step
>>Wait for Master Cheng at the waypoint location, target her and type /bow into the chat when he tells you to, then defeat her
.emote BOW,66180
.goto 379,48.10,40.31
.complete 31837,1 
step
.goto 379,48.60,42.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly back up and talk to Master Hight
.turnin 31837 >>Turn in Continue Your Training: Master Cheng
.accept 31838 >>Accept Continue Your Training: Master Tsang
step
#completewith next
.isOnQuest 31838
.goto 379,48.07,41.37
.gossipoption 41014 >>Talk to Master Tsang
step
>>Wait for Master Tsang at the waypoint location, target him and type /bow into the chat when he tells you to
*Use |T606542:0|tCrackling Jade Lightning on the Monk Trainees around you on the Balance Poles, then deafeat Master Tsang
.emote BOW,66149
.goto 379,48.12,40.37
.complete 31838,1 
step
.goto 379,48.60,42.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly back up and talk to Master Hight
.turnin 31838 >>Turn in Continue Your Training: Master Tsang
.accept 31839 >>Accept Continue Your Training: Master Hsu
step
#completewith next
.isOnQuest 31839
.goto 379,47.49,40.93
.gossipoption 40709 >>Talk to Master Hsu
step
>>Wait for Master Hsu at the waypoint location, target him and type /bow into the chat when he tells you to, then defeat him
.emote BOW,65977
.goto 379,48.11,40.36
.complete 31839,1 
step
.goto 379,48.60,42.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly back up and talk to Master Hight
.turnin 31839 >>Turn in Continue Your Training: Master Hsu
.accept 31944 >>Accept Complete Your Training: The Final Test
step
#completewith next
.isOnQuest 31944
.goto 379,48.32,41.52
.gossipoption 41235 >>Talk to Master Hight
step
>>Wait for Master Hsu at the waypoint location, target him and type /bow into the chat when he tells you to, then defeat him
.emote BOW,66732
.goto 379,48.15,40.46
.complete 31944,1 
step
.goto 379,48.60,42.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly back up and talk to Master Hight
.turnin 31944 >>Turn in Complete Your Training: The Final Test
]])