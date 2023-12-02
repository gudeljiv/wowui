RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 23-25 Hillsbrad
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 20-30
#next 25-27 Southern Barrens/Stonetalon
step
.zone Tirisfal Glades >>Arrive in Tirisfal Glades
.zoneskip Tirisfal Glades
step
#completewith next
.goto Tirisfal Glades,61.52,53.20,80 >> Travel to Brill
step
.goto Tirisfal Glades,61.26,50.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sevren|r
.turnin 440 >> Turn in The Engraved Ring
.accept 441 >> Accept Raleigh and the Undercity
.target Magistrate Sevren
step
#completewith HusbandsRevenge
.goto Tirisfal Glades,61.80,65.06,20,0
.zone Undercity >> Enter Undercity
.zoneskip Undercity
step
#completewith next
.goto Undercity,66.09,20.06,35,0
.goto Undercity,64.37,23.94,35,0
.goto Undercity,65.93,26.71,10,0
.goto Undercity,65.89,34.03,10,0
.goto Undercity,64.22,39.77,10,0
.goto Undercity,65.53,43.62,15 >> Take the lift down to the Undercity
step
#label HusbandsRevenge
.goto Undercity,62.02,42.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Raleigh|r
.turnin 441 >>Turn in Raleigh and the Undercity
.accept 530 >>Accept A Husband's Revenge
.target Raleigh Andrean
step << Mage
.goto Undercity,84.18,15.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lexington|r
.train 3563 >> Train |T135766:0|t[Teleport: Undercity]
.target Lexington Mortaim
step << Mage
.goto Undercity,82.78,15.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Hannah|r|cRXP_BUY_. Buy one or more|r |T134419:0|t[Rune of Teleportation] |cRXP_BUY_from her|r
.collect 17031,1 
.target Hannah Akeley
step << Priest
.goto Undercity,48.98,18.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Aelthalyste|r
.turnin 5644 >> Turn In Devouring Plague
.target Aelthalyste
step
.goto Undercity,53.74,54.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bel'dugur|r
.accept 1013 >>Accept The Book of Ur
.target Keeper Bel'dugur
.dungeon SFK
step
.goto Undercity,63.27,48.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Michael|r
.fly The Supulcher >> Fly to The Sepulcher
.target Michael Garrett
.zoneskip Silverpine Forest
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Allister|r, |cRXP_FRIENDLY_Renferrel|r and |cRXP_FRIENDLY_Mura|r
.accept 480 >>Accept The Weaver
.accept 516 >>Accept Beren's Peril
.goto Silverpine Forest,43.98,40.93
.accept 493 >> Accept Journey to Hillsbrad Foothills
.goto Silverpine Forest,42.90,40.80
.turnin 3301 >> Turn in Mura Runetotem
.goto Silverpine Forest,43.06,41.92
.target Shadow Priest Allister
.target Apothecary Renferrel
.target Mura Runetotem
.isQuestTurnedIn 479
.group
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Allister|r, |cRXP_FRIENDLY_Renferrel|r and |cRXP_FRIENDLY_Mura|r
.accept 516 >>Accept Beren's Peril
.goto Silverpine Forest,43.98,40.93
.accept 493 >> Accept Journey to Hillsbrad Foothills
.goto Silverpine Forest,42.90,40.80
.turnin 3301 >> Turn in Mura Runetotem
.goto Silverpine Forest,43.06,41.92
.target Shadow Priest Allister
.target Apothecary Renferrel
.target Mura Runetotem
step << Druid
#completewith next
.goto Silverpine Forest,36.12,28.30,120 >> Travel North East toward the Great Sea
step << Druid
.goto Silverpine Forest,29.58,29.30
>>Loot the |cRXP_PICK_Strange Lockbox|r in the water for the |T133442:0|t[Half Pendant of Aquatic Endurance]
>>|cRXP_WARN_Combine the two Pendants for the |r|cRXP_LOOT_Pendant of the Sea Lion|r
.collect 15882,1,516,1 
.complete 15885,1 
step
#completewith next
.goto Silverpine Forest,46.07,85.75,100 >> Travel south toward the Greymane Wall
step
.goto Silverpine Forest,46.07,85.75
>>Kill |cRXP_ENEMY_Valdred Moray|r. Loot him for his |cRXP_LOOT_Hands|r
>>|cRXP_WARN_He patrols around. Solo pull him and be careful of the mobs that are grouped|r
.complete 530,1 
.unitscan Valdred Moray
step
#completewith next
.goto Silverpine Forest,60.35,74.54,40 >> Travel toward the cave in Beren's Peril
step
.goto Silverpine Forest,60.38,72.43,20,0
.goto Silverpine Forest,59.73,71.73,15,0
.goto Silverpine Forest,59.52,70.66,15,0
.goto Silverpine Forest,58.71,71.34,15,0
.goto Silverpine Forest,58.26,71.99,15,0
.goto Silverpine Forest,57.65,71.61,15,0
.goto Silverpine Forest,57.30,69.96,30,0
.goto Silverpine Forest,59.73,71.73
>>Kill |cRXP_ENEMY_Ravenclaw Drudgers|r and |cRXP_ENEMY_Ravenclaw Guardians|r
.complete 516,1 
.complete 516,2 
.mob Ravenclaw Drudger
.mob Ravenclaw Guardian
step
#completewith next
.goto Silverpine Forest,62.10,64.42,80 >> Travel toward Ambermill
.isOnQuest 480
.group
step
.goto Silverpine Forest,62.10,64.42,20,0
.goto Silverpine Forest,62.91,63.95,10,0
.goto Silverpine Forest,63.22,63.45,10,0
.goto Silverpine Forest,63.40,64.26
>>Enter the townhall and Kill |cRXP_ENEMY_Archmage Ataeric|r. Loot him for his |cRXP_LOOT_Staff|r
>>|cRXP_WARN_There are many mobs inside. Pull them out of the room carefully|r
.complete 480,1 
.mob Archmage Ataeric
.isOnQuest 480
.group 2
step
#completewith next
.zone Hillsbrad Foothills >> Travel to Hillsbrad Foothills
.zoneskip Hillsbrad Foothills
step
.goto Hillsbrad Foothills,20.79,47.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Deathstalker Lesh|r
.accept 494 >> Accept Time To Strike
.target Deathstalker Lesh
step
#completewith next
.goto Hillsbrad Foothills,62.06,20.19,120 >> Travel to Tarren Mill
step
.goto Hillsbrad Foothills,60.14,18.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zarise|r
.fp Tarren Mill>> Get the Tarren Mill Flight Path
.target Zarise
step << Rogue
.goto Hillsbrad Foothills,61.55,19.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hinott|r
.turnin 2479 >>Turn in Hinott's Assistance
.accept 2480 >>Accept Hinott's Assistance
.target Serge Hinott
step << Rogue
.goto Hillsbrad Foothills,61.55,19.19
>>Wait for |cRXP_FRIENDLY_Hinott|r to complete the cure
.complete 2480,1 
step << Rogue
.goto Hillsbrad Foothills,61.50,19.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hinott|r
.turnin 2480 >>Turn in Hinott's Assistance
.target Serge Hinott
step << Rogue
#completewith TarrenMillPickups
.cast 10723 >>Use |T134807:0|t[Hinott's Oil] to cure yourself of the |T136230:0|t[Touch of Zanzil]
step << Rogue
#completewith TarrenMillPickups
>>Craft |T132273:0|t[Instant Poisons]
.collect 6947,20,1067,1 
step
.goto Hillsbrad Foothills,61.50,19.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Apothecary Lydon|r
.turnin 493 >> Turn in Journey to Hillsbrad Foothills
.turnin 1065 >> Turn in Journey to Tarren Mill
.accept 1066 >> Accept Blood of Innocents
.accept 496 >> Accept Elixir of Suffering
.accept 501 >> Accept Elixir of Pain
.target Apothecary Lydon
step << Shaman
.goto Hillsbrad Foothills,62.18,20.78
.use 7768 >>Use the |T132829:0|t[Empty Red Waterskin] at the well in the middle of Tarren Mill
.complete 1536,1 
step
#label TarrenMillPickups
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Wanted Posters|r, |cRXP_FRIENDLY_High Executor Darthalia|r and |cRXP_FRIENDLY_Krusk|r
.accept 567 >> Accept Dangerous!
.goto Hillsbrad Foothills,62.50,19.70
.turnin 494 >> Turn in Time To Strike
.accept 527 >> Accept Battle of Hillsbrad
.goto Hillsbrad Foothills,62.20,20.50
.accept 549 >> Accept WANTED: Syndicate Personnel
.goto Hillsbrad Foothills,62.60,20.70
.accept 498 >> Accept The Rescue
.goto Hillsbrad Foothills,63.20,20.70
.target High Executor Darthalia
.target Krusk
step << Hunter
.goto Hillsbrad Foothills,62.56,19.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kayren|r
.collect 2515,1800,549,1 << Hunter 
.target Kayren Soothallow
.xp <25,1
step << Hunter
.goto Hillsbrad Foothills,62.56,19.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kayren|r
.collect 3030,1800,549,1 << Hunter 
.target Kayren Soothallow
.xp >25,1
step
.goto Hillsbrad Foothills,62.76,19.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Shay|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Shay
step << Shaman/Warrior
.goto Hillsbrad Foothills,60.43,26.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Ott|r|cRXP_BUY_. Buy a|r |T132408:0|t[Merciless Axe] |cRXP_BUY_from him if it's up and you don't have it yet|r
.collect 12249,1,549,1 
.money <3.0195
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<21.0
.target Ott
step << Rogue
.goto Hillsbrad Foothills,60.43,26.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Ott|r|cRXP_BUY_. Buy a|r |T135640:0|t[Broad Bladed Knife] |cRXP_BUY_from him if it's up and you don't have it yet|r
.collect 12247,1,549,1 
.money <2.8372
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<16.7
.target Ott
step << Hunter
#completewith next
.goto Hillsbrad Foothills,62.31,19.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Theodore|r
.stable >> Stable your pet. You will tame a |cRXP_ENEMY_Gray Bear|r shortly
.target Theodore Mont Claire
step << Hunter
.goto Hillsbrad Foothills,57.93,27.85,60,0
.goto Hillsbrad Foothills,58.88,32.28,60,0
.goto Hillsbrad Foothills,61.77,36.16,60,0
.goto Hillsbrad Foothills,57.93,27.85
.cast 1515 >>|cRXP_WARN_Cast|r |T132164:0|t[Tame Beast] |cRXP_WARN_on a |cRXP_ENEMY_Gray Bear|r to tame it|r
.train 16829 >>|cRXP_WARN_Attack mobs with it to learn|r |T132140:0|t[Claw (Rank 3)]
.link https://www.wow-petopia.com/classic/training.php >> |cRXP_WARN_Click here for more info about pet training|r
.mob Gray Bear
step << Hunter
.goto Hillsbrad Foothills,62.31,19.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Theodore|r
.stable >> Abandon the |cRXP_ENEMY_Gray Bear|r and retrieve your regular pet
.target Theodore Mont Claire
step << Rogue
#completewith Durnholde1
.cast 8679 >> Use the |T132273:0|t[Instant Poison] on your weapons
.itemcount 6947,2
step
#completewith next
>>Kill |cRXP_ENEMY_Bears|r and |cRXP_ENEMY_Spiders|r en route. Loot them for their |cRXP_LOOT_Tongues|r and |cRXP_LOOT_Ichor|r
>>|cFFFCDC00Avoid|r |cFFFF5722Elder Gray Bears|r |cFFFCDC00and|r |cFFFF5722Giant Moss Creepers|r |cFFFCDC00as they're high level and not worth killing|r
.complete 496,1 
.complete 496,2 
.mob Forest Moss Creeper
.mob Gray Bear
.mob Vicious Gray Bear
step
#label Durnholde1
.goto Hillsbrad Foothills,76.57,46.48,120 >> Run to Durnholde Keep
step
#completewith Drull
>>Kill |cFFFF5722Syndicate Rogues|r, |cFFFF5722Watchmen|r, and |cFFFF5722Shadow Mages|r.
>>Loot the |cFFFF5722Shadow Mages|r for their |cFF00BCD4Vials of Innocent Blood|r
.complete 549,1 
.complete 549,2 
.complete 1066,1 
.mob Syndicate Rogue
.mob Syndicate Watchman
.mob Syndicate Shadow Mage
step
#completewith Togthar
.goto Hillsbrad Foothills,79.55,41.85,15,0
>>Kill |cFFFF5722Jailor Eston|r. Loot him for his |cFF00BCD4Iron Key|r
>>|cFFFCDC00He can be found in front of |cRXP_FRIENDLY_Tog'thar's|r Barracks|r
.collect 3467,1,498,1 
.mob Jailor Eston
step
.goto Hillsbrad Foothills,79.45,40.57,15,0
.goto Hillsbrad Foothills,77.99,40.19,15,0
.goto Hillsbrad Foothills,79.45,40.57,15,0
.goto Hillsbrad Foothills,77.99,40.19,15,0
.goto Hillsbrad Foothills,79.45,40.57,15,0
.goto Hillsbrad Foothills,77.99,40.19,15,0
.goto Hillsbrad Foothills,79.45,40.57,15,0
.goto Hillsbrad Foothills,77.99,40.19
>>Kill |cFFFF5722Jailor Marlgen|r. Loot him for his |cFF00BCD4Gold Key|r
>>|cFFFCDC00He can be found in front of |cRXP_FRIENDLY_Tog'thar|r or at the bottom of the tower|r
.collect 3499,1,498,2 
.mob Jailor Marlgen
step
#label Togthar
.goto Hillsbrad Foothills,79.79,39.65
>>Click the |cFFDB2EEFBall and Chain|r on the ground
.complete 498,2 
step << Rogue/Hunter/Shaman
.goto Hillsbrad Foothills,80.14,38.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kris|r
>>|cFF0E8312Buy the|r |T134590:0|t[Stalking Pants] |cFF0E8312and|r |T132603:0|t[Wolf Bracers] |cFF0E8312from her if they're up|r
.vendor >> Vendor and Repair
.target Kris Legace
.money <1.1374
.itemcount 4831,<1
.itemcount 4794,<1
.itemStat 7,ITEM_MOD_ARMOR_SHORT,<76
.itemStat 9,ITEM_MOD_ARMOR_SHORT,<37
step << Rogue/Hunter/Shaman/Druid
.goto Hillsbrad Foothills,80.14,38.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kris|r
>>|cFF0E8312Buy the|r |T134590:0|t[Stalking Pants] |cFF0E8312from her if they're up|r
.vendor >> Vendor and Repair
.target Kris Legace
.money <0.7859
.itemcount 4831,<1
.itemStat 7,ITEM_MOD_ARMOR_SHORT,<76
step << Rogue/Hunter/Shaman/Druid
.goto Hillsbrad Foothills,80.14,38.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kris|r
>>|cFF0E8312Buy the|r |T132603:0|t[Wolf Bracers] |cFF0E8312from her if they're up|r
.vendor >> Vendor and Repair
.target Kris Legace
.money <0.3515
.itemcount 4794,<1
.itemStat 9,ITEM_MOD_ARMOR_SHORT,<37
step << Rogue/Hunter/Shaman/Druid
#completewith Drull
+Equip the |T134590:0|t[Stalking Pants] |cFF0E8312and|r |T132603:0|t[Wolf Bracers]
.use 4831
.use 4794
.itemcount 4831,1
.itemcount 4794,1
.itemStat 7,ITEM_MOD_ARMOR_SHORT,<76
.itemStat 9,ITEM_MOD_ARMOR_SHORT,<37
step << Rogue/Hunter/Shaman/Druid
#completewith Drull
+Equip the |T134590:0|t[Stalking Pants]
.use 4831
.itemcount 4831,1
.itemStat 7,ITEM_MOD_ARMOR_SHORT,<76
step << Rogue/Hunter/Shaman/Druid
#completewith Drull
+Equip the |T132603:0|t[Wolf Bracers]
.use 4794
.itemcount 4794,1
.itemStat 9,ITEM_MOD_ARMOR_SHORT,<37
step << !Rogue !Hunter !Shaman !Druid
.goto Hillsbrad Foothills,80.14,38.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kris|r
.vendor >> Vendor and Repair
.target Kris Legace
step
.goto Hillsbrad Foothills,79.55,41.85,15,0
.goto Hillsbrad Foothills,75.31,41.63,15,0
.goto Hillsbrad Foothills,79.55,41.85,15,0
.goto Hillsbrad Foothills,75.31,41.63,15,0
.goto Hillsbrad Foothills,79.55,41.85,15,0
.goto Hillsbrad Foothills,75.31,41.63,15,0
.goto Hillsbrad Foothills,79.55,41.85,15,0
.goto Hillsbrad Foothills,75.31,41.63,15,0
.goto Hillsbrad Foothills,79.55,41.85,15,0
.goto Hillsbrad Foothills,75.31,41.63,15,0
.goto Hillsbrad Foothills,79.55,41.85,15,0
.goto Hillsbrad Foothills,75.31,41.63
>>Kill |cFFFF5722Jailor Eston|r. Loot him for his |cFF00BCD4Iron Key|r
>>|cFFFCDC00He can be found in front of |cRXP_FRIENDLY_Tog'thar|r's Barracks, or in front of|r |cRXP_FRIENDLY_Drull|r
.collect 3467,1,498,1 
.mob Jailor Eston
step
#label Drull
.goto Hillsbrad Foothills,75.33,41.50
>>Click the |cFFDB2EEFBall and Chain|r on the ground
.complete 498,1 
step
#completewith next
>>Kill |cRXP_ENEMY_Syndicate Rogues|r and |cRXP_ENEMY_Syndicate Watchmen|r
.complete 549,1 
.complete 549,2 
.mob Syndicate Rogue
.mob Syndicate Watchman
step
.loop 25,Hillsbrad Foothills,67.88,47.93,67.06,50.84,66.24,48.79,65.36,48.65,64.86,47.05,65.37,46.46,66.13,45.63,67.22,45.85
>>Kill |cRXP_ENEMY_Syndicate Shadow Mages|r. Loot them for their |cRXP_LOOT_Vials|r
>>|cRXP_WARN_More of them can be found at the tower just southwest of the keep|r
.complete 1066,1 
.mob Syndicate Shadow Mage
step
.loop 25,Hillsbrad Foothills,67.88,47.93,67.06,50.84,66.24,48.79,65.36,48.65,64.86,47.05,65.37,46.46,66.13,45.63,67.22,45.85
>>Kill |cRXP_ENEMY_Syndicate Rogues|r and |cRXP_ENEMY_Syndicate Watchmen|r
>>|cRXP_WARN_More of them can be found at the tower just southwest of the keep|r
.complete 549,1 
.complete 549,2 
.mob Syndicate Rogue
.mob Syndicate Watchman
step
#completewith TarrenMillTurnins1
>>Kill |cRXP_ENEMY_Bears|r and |cRXP_ENEMY_Spiders |r en route back to Tarren Mill. Loot them for their |cRXP_LOOT_Tongues|r and |cRXP_LOOT_Ichor|r
>>|cFFFCDC00Avoid|r |cFFFF5722Elder Gray Bears|r |cFFFCDC00and|r |cFFFF5722Giant Moss Creepers|r |cFFFCDC00as they're high level and not worth killing|r
.complete 496,1 
.complete 496,2 
.mob Forest Moss Creeper
.mob Gray Bear
.mob Vicious Gray Bear
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r, |cRXP_FRIENDLY_Darthalia|r and |cRXP_FRIENDLY_Krusk|r
.turnin 1066 >> Turn in Blood of Innocents
.turnin 496 >> Turn in Elixir of Suffering
.accept 499 >> Accept Elixir of Suffering
.goto Hillsbrad Foothills,61.50,19.20
.turnin 549 >> Turn in WANTED: Syndicate Personnel
.goto Hillsbrad Foothills,62.20,20.50
.turnin 498 >> Turn in The Rescue
.goto Hillsbrad Foothills,63.20,20.70
.target Apothecary Lydon
.target High Executor Darthalia
.target Krusk
.isQuestComplete 496
step
.goto Hillsbrad Foothills,61.50,19.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r, |cRXP_FRIENDLY_Darthalia|r
.accept 499 >> Accept Elixir of Suffering
.isQuestTurnedIn 496
step
.goto Hillsbrad Foothills,61.55,19.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umpi|r
.turnin 499 >> Turn in Elixir of Suffering
.target Umpi
.isQuestTurnedIn 496
step
#label TarrenMillTurnins1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r, |cRXP_FRIENDLY_Darthalia|r and |cRXP_FRIENDLY_Krusk|r
.turnin 1066 >> Turn in Blood of Innocents
.goto Hillsbrad Foothills,61.50,19.20
.turnin 549 >> Turn in WANTED: Syndicate Personnel
.goto Hillsbrad Foothills,62.20,20.50
.turnin 498 >> Turn in The Rescue
.goto Hillsbrad Foothills,63.20,20.70
.target Apothecary Lydon
.target High Executor Darthalia
.target Krusk
step
.goto Hillsbrad Foothills,62.76,19.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Shay|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Shay
step << Hunter
.goto Hillsbrad Foothills,62.56,19.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kayren|r
.collect 2515,1800,527,1 << Hunter 
.target Kayren Soothallow
.xp <25,1
.itemcount 2515,<1000
step << Hunter
.goto Hillsbrad Foothills,62.56,19.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kayren|r
.collect 3030,1800,527,1 << Hunter 
.target Kayren Soothallow
.xp >25,1
.itemcount 3030,<1000
step
#completewith next
>>Kill |cRXP_ENEMY_Bears|r and |cRXP_ENEMY_Mountain Lions|r en route to the Hillsbrad Fields. Loot them for their |cRXP_LOOT_Tongues|r and |cRXP_LOOT_Blood|r
.complete 496,1 
.complete 501,1 
.mob Gray Bear
.mob Vicious Gray Bear
.mob Starving Mountain Lion
step
.goto Hillsbrad Foothills,36.02,39.19,150 >> Run to the Hillsbrad Fields
.isOnQuest 527
step
#completewith FarmerRay
>>Kill |cRXP_ENEMY_Hillsbrad Farmers|r and |cRXP_ENEMY_Hillsbrad Farmhands|r in and around the fields
.complete 527,1 
.complete 527,2 
.mob Hillsbrad Farmer
.mob Hillsbrad Farmhand
step
.goto Hillsbrad Foothills,36.7,39.4,60,0
.goto Hillsbrad Foothills,35.2,37.6,45,0
.goto Hillsbrad Foothills,35.1,41.0,60,0
.goto Hillsbrad Foothills,36.7,39.4,60,0
.goto Hillsbrad Foothills,35.2,37.6,45,0
.goto Hillsbrad Foothills,35.1,41.0,60,0
.goto Hillsbrad Foothills,36.7,39.4
>>Kill |cRXP_ENEMY_Farmer Getz|r. He can be in the house, barn, or field
.complete 527,4 
.unitscan Farmer Getz
step
#label FarmerRay
.goto Hillsbrad Foothills,33.65,35.44,30,0
.goto Hillsbrad Foothills,32.90,35.23,10,0
.goto Hillsbrad Foothills,33.23,34.65,10,0
.goto Hillsbrad Foothills,32.69,34.77,8,0
.goto Hillsbrad Foothills,32.88,34.99,8,0
.goto Hillsbrad Foothills,33.28,34.65
>>Kill |cRXP_ENEMY_Farmer Ray|r
>>|cRXP_WARN_He can spawn outside under the grapevine or in the 1st or 2nd floor of the house|r
.complete 527,3 
.unitscan Farmer Ray
step
.goto Hillsbrad Foothills,31.30,37.08,40,0
.goto Hillsbrad Foothills,33.81,40.91,40,0
.goto Hillsbrad Foothills,35.49,40.36,40,0
.goto Hillsbrad Foothills,31.30,37.08
>>Kill |cRXP_ENEMY_Hillsbrad Farmers|r and |cRXP_ENEMY_Hillsbrad Farmhands|r in and around the fields
.complete 527,1 
.complete 527,2 
.mob Hillsbrad Farmer
.mob Hillsbrad Farmhand
step
#completewith next
>>Kill |cRXP_ENEMY_Bears|r. Loot them for their |cRXP_LOOT_Tongues|r
.complete 496,1 
.mob Gray Bear
.mob Vicious Gray Bear
step
.loop 25,Hillsbrad Foothills,39.79,34.43,38.70,36.71,38.45,38.77,39.88,40.56,37.97,44.59,39.92,45.83,40.91,44.23,42.56,40.19,43.36,39.38,51.28,35.37,54.29,31.75,52.93,29.45,54.77,28.72
>>Finish killing |cRXP_ENEMY_Mountain Lions|r. Loot them for their |cRXP_LOOT_Blood|r
.complete 501,1 
.mob Starving Mountain Lion
step
#completewith TarrenMillTurnins2
>>Kill |cRXP_ENEMY_Bears|r en route back to Tarren Mill. Loot them for their |cRXP_LOOT_Tongues|r
.complete 496,1 
.mob Gray Bear
.mob Vicious Gray Bear
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r, |cRXP_FRIENDLY_Darthalia|r and |cRXP_FRIENDLY_Samsa|r
.turnin 496 >> Turn in Elixir of Suffering
.accept 499 >> Accept Elixir of Suffering
.turnin 501 >> Turn in Elixir of Pain
.accept 502 >> Accept Elixir of Pain
.goto Hillsbrad Foothills,61.50,19.20
.turnin 527 >> Turn in Battle of Hillsbrad
.accept 528 >> Accept Battle of Hillsbrad
.goto Hillsbrad Foothills,62.20,20.50
.accept 546 >> Accept Souvenirs of Death
.goto Hillsbrad Foothills,62.11,19.68
.target Apothecary Lydon
.target High Executor Darthalia
.target Deathguard Samsa
.isQuestComplete 496
step
.goto Hillsbrad Foothills,61.50,19.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r, |cRXP_FRIENDLY_Darthalia|r
.accept 499 >> Accept Elixir of Suffering
.isQuestTurnedIn 496
step
.goto Hillsbrad Foothills,61.55,19.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umpi|r
.turnin 499 >> Turn in Elixir of Suffering
.target Umpi
.isQuestTurnedIn 496
step
#label TarrenMillTurnins2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r, |cRXP_FRIENDLY_Darthalia|r and |cRXP_FRIENDLY_Samsa|r
.turnin 501 >> Turn in Elixir of Pain
.accept 502 >> Accept Elixir of Pain
.goto Hillsbrad Foothills,61.50,19.20
.turnin 527 >> Turn in Battle of Hillsbrad
.accept 528 >> Accept Battle of Hillsbrad
.goto Hillsbrad Foothills,62.20,20.50
.accept 546 >> Accept Souvenirs of Death
.goto Hillsbrad Foothills,62.11,19.68
.target Apothecary Lydon
.target High Executor Darthalia
.target Deathguard Samsa
step
.goto Hillsbrad Foothills,62.76,19.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Shay|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Shay
step
#completewith next
>>Kill |cRXP_ENEMY_Bears|r en route back to the Hillsbrad Fields. Loot them for their |cRXP_LOOT_Tongues|r
.complete 496,1 
.mob Gray Bear
.mob Vicious Gray Bear
step
.goto Hillsbrad Foothills,36.02,39.19,150 >> Run to the Hillsbrad Fields
.isOnQuest 528
step
#completewith Kalaba
>>Kill |cFFFF5722Hillsbrad Humans|r. Loot them for their |cFF00BCD4Skulls|r.
>>|cFFFCDC00This quest does not need to be completed now|r
.complete 546,1,17 
step
#completewith next
.goto Hillsbrad Foothills,32.67,35.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stanley|r
>>|cFFFCDC00Wait out the RP, then kill|r |cFFFF5722Enraged Stanley|r
>>|cFFFF5722Enraged Stanley|r |cFFFCDC00gives a full quest's worth of experience|r
.turnin 502 >> Turn in Elixir of Pain
.timer 9,Stanley RP (BE ALERT)
.mob Stanley
step
.line Hillsbrad Foothills,36.54,39.44,35.36,38.73,33.98,38.78,32.56,40.03,32.58,38.17,32.66,36.08,32.92,35.25,32.66,36.08,32.58,38.17,32.56,40.03,32.65,41.12,32.45,42.58,31.27,42.06,30.53,40.56,31.27,42.06,32.45,42.58,32.41,43.85,32.46,44.59,32.29,45.13
.goto Hillsbrad Foothills,36.54,39.44,40,0
.goto Hillsbrad Foothills,35.36,38.73,40,0
.goto Hillsbrad Foothills,33.98,38.78,40,0
.goto Hillsbrad Foothills,32.56,40.03,40,0
.goto Hillsbrad Foothills,32.58,38.17,40,0
.goto Hillsbrad Foothills,32.66,36.08,40,0
.goto Hillsbrad Foothills,32.92,35.25,40,0
.goto Hillsbrad Foothills,32.56,40.03,40,0
.goto Hillsbrad Foothills,32.65,41.12,40,0
.goto Hillsbrad Foothills,32.45,42.58,40,0
.goto Hillsbrad Foothills,31.27,42.06,40,0
.goto Hillsbrad Foothills,30.53,40.56,40,0
.goto Hillsbrad Foothills,31.27,42.06,40,0
.goto Hillsbrad Foothills,32.45,42.58,40,0
.goto Hillsbrad Foothills,32.41,43.85,40,0
.goto Hillsbrad Foothills,32.46,44.59,40,0
.goto Hillsbrad Foothills,32.29,45.13,40,0
.goto Hillsbrad Foothills,32.45,42.58,40,0
.goto Hillsbrad Foothills,32.56,40.03,40,0
.goto Hillsbrad Foothills,36.54,39.44
>>Kill |cFFFF5722Citizen Wilkes|r
>>|cFFFCDC00He patrols around the roads of the town|r
.complete 567,2 
.unitscan Citizen Wilkes
.unitscan Enraged Stanley
step
.goto Hillsbrad Foothills,32.67,35.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stanley|r
>>|cFFFCDC00Wait out the RP, then kill|r |cFFFF5722Enraged Stanley|r
>>|cFFFF5722Enraged Stanley|r |cFFFCDC00gives a full quest's worth of experience|r
.turnin 502 >> Turn in Elixir of Pain
.timer 9,Stanley RP (BE ALERT)
.mob Stanley
step
#completewith next
>>Kill |cFFFF5722Hillsbrad Peasants|r
.complete 528,1 
.mob Hillsbrad Peasant
step
#label Kalaba
.goto Hillsbrad Foothills,36.00,46.50
>>Kill |cFFFF5722Farmer Kalaba|r
.complete 567,4 
.mob Farmer Kalaba
step
.loop 25,Hillsbrad Foothills,36.64,45.21,36.03,44.40,34.36,44.62,33.82,45.75,33.25,48.54,34.59,48.13,35.29,47.28,36.49,47.49,36.64,45.21
>>Kill |cFFFF5722Hillsbrad Peasants|r
.complete 528,1 
.mob Hillsbrad Peasant
step
.loop 25,Hillsbrad Foothills,40.88,33.87,40.86,37.40,40.85,39.42,38.50,38.04,37.68,41.23,38.71,42.66,40.40,44.65,44.39,41.34,45.23,39.62,43.87,37.01,49.75,34.33,52.06,36.86,51.91,32.97,52.39,29.27,57.38,22.85,57.09,25.67,58.08,28.07,56.88,28.85,59.68,30.90,57.71,34.06,59.89,36.74,62.63,37.64,64.73,38.03,66.52,34.52
>>Finish killing |cRXP_ENEMY_Bears|r. Loot them for their |cRXP_LOOT_Tongues|r
.complete 496,1 
.mob Gray Bear
.mob Vicious Gray Bear
step
.loop 25,Hillsbrad Foothills,62.85,38.74,62.24,39.96,60.92,37.92,59.62,33.33,56.88,29.73,59.80,27.72,57.63,24.16,56.47,16.42,59.36,14.55,60.54,13.67,62.65,12.90,64.43,10.22,65.18,6.93,65.31,5.76,66.90,9.02,70.39,8.89,68.86,10.18,67.35,12.95,71.38,19.81,71.78,21.89,64.85,24.92,66.68,28.15,69.76,31.89,67.62,37.65,62.85,38.74
>>Finish killing |cFFFF5722Forest Moss Creepers|r and |cFFFF5722Giant Moss Creepers|r. Loot them for their |cFF00BCD4Ichor|r
.complete 496,2 
.mob Forest Moss Creeper
.mob Giant Moss Creeper
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r and |cRXP_FRIENDLY_Darthalia|r
.turnin 496 >> Turn in Elixir of Suffering
.accept 499 >> Accept Elixir of Suffering
.accept 1067 >> Accept Return to Thunder Bluff
.goto Hillsbrad Foothills,61.50,19.20
.turnin 528 >> Turn in Battle of Hillsbrad
.goto Hillsbrad Foothills,62.20,20.50
.target Apothecary Lydon
.target High Executor Darthalia
.isQuestComplete 496
step
.goto Hillsbrad Foothills,61.50,19.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r, |cRXP_FRIENDLY_Darthalia|r
.accept 499 >> Accept Elixir of Suffering
.isQuestTurnedIn 496
step
.goto Hillsbrad Foothills,61.55,19.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umpi|r
.turnin 499 >> Turn in Elixir of Suffering
.target Umpi
.isQuestTurnedIn 496
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r and |cRXP_FRIENDLY_Darthalia|r
.accept 1067 >> Accept Return to Thunder Bluff
.goto Hillsbrad Foothills,61.50,19.20
.turnin 528 >> Turn in Battle of Hillsbrad
.goto Hillsbrad Foothills,62.20,20.50
.target Apothecary Lydon
.target High Executor Darthalia
step
.goto Hillsbrad Foothills,62.76,19.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Shay|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Shay
step << Hunter
.goto Hillsbrad Foothills,62.56,19.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kayren|r
.collect 2515,1800,516,1 << Hunter 
.target Kayren Soothallow
.xp <25,1
step << Hunter
.goto Hillsbrad Foothills,62.56,19.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kayren|r
.collect 3030,1800,516,1 << Hunter 
.target Kayren Soothallow
.xp >25,1
step << Shaman/Warrior
.goto Hillsbrad Foothills,60.43,26.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Ott|r|cRXP_BUY_. Buy a|r |T132408:0|t[Merciless Axe] |cRXP_BUY_from him if it's up and you don't have it yet|r
.collect 12249,1,516,1 
.money <3.0195
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<21.0
.target Ott
step << Rogue
.goto Hillsbrad Foothills,60.43,26.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Ott|r|cRXP_BUY_. Buy a|r |T135640:0|t[Broad Bladed Knife] |cRXP_BUY_from him if it's up and you don't have it yet|r
.collect 12247,1,516,1 
.money <2.8372
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<16.7
.target Ott
step
#completewith BerensPerilTurnin
.goto Hillsbrad Foothills,60.14,18.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zarise|r
.fly The Supulcher >> Fly to The Sepulcher
.target Zarise
.zoneskip Silverpine Forest
step
#sticky
#completewith EnterSFK
.subzone 310 >> Now you should be looking for a group to Shadowfang Keep
.dungeon SFK
step
.goto Silverpine Forest,43.98,40.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Allister|r
.turnin 480 >>Turn in The Weaver
.turnin 516 >>Turn in Beren's Peril
.target Shadow Priest Allister
.isQuestComplete 480
.group
step
#label BerensPerilTurnin
.goto Silverpine Forest,43.98,40.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Allister|r
.turnin 516 >>Turn in Beren's Peril
.target Shadow Priest Allister
step
.goto Silverpine Forest,43.43,40.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hadrec|r
.accept 1098 >>Accept Deathstalkers in Shadowfang
.target High Executor Hadrec
.dungeon SFK
step
.goto Silverpine Forest,44.22,39.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dalar|r
.accept 1014 >>Accept Arugal Must Die
.target Dalar Dawnweaver
.dungeon SFK
step
#label EnterSFK
.goto Silverpine Forest,44.87,67.86
.zone 310 >> Enter the SFK Instance portal. Zone in
.dungeon SFK
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vincent|r
.turnin 1098 >> Turn in Deathstalkers in Shadowfang
.target Deathstalker Vincent
.dungeon SFK
.isOnQuest 1098
step
>>Loot the |cFFDB2EEFBook of Ur|r from the bookshelf in |cFFFF5722Fenrus the Devourer's|r room
.complete 1013,1 
.dungeon SFK
.isOnQuest 1013
step
>>Kill |cFFFF5722Archmage Arugal|r. Loot him for his |cFF00BCD4Head|r
.complete 1014,1 
.mob Archmage Arugal
.dungeon SFK
.isOnQuest 1014
step
#completewith FlytoUC
.goto Silverpine Forest,45.51,41.26,100 >> Travel to The Sepulcher
.dungeon SFK
step
.goto Silverpine Forest,43.43,40.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hadrec|r
.turnin 1098 >>Turn in Deathstalkers in Shadowfang
.target High Executor Hadrec
.dungeon SFK
.isQuestComplete 1098
step
.goto Silverpine Forest,44.22,39.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dalar|r
.turnin 1014 >>Turn in Arugal Must Die
.target Dalar Dawnweaver
.dungeon SFK
.isQuestComplete 1014
step << Mage
#completewith HusbandsRevenge
.cast 3563 >>Cast |T135766:0|t[Teleport: Undercity]
.zoneskip Undercity
.itemcount 17031,1
step
#label FlytoUC
#completewith next
.goto Silverpine Forest,45.62,42.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karos|r
.fly Undercity >> Fly to the Undercity
.target Karos Razok
.zoneskip Undercity
step
#label HusbandsRevenge
.goto Undercity,62.02,42.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Raleigh|r
.turnin 530 >>Turn in A Husband's Revenge
.target Raleigh Andrean
step
.goto Undercity,65.99,44.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_William|r
.bankdeposit 3692 >> Deposit your |T133730:0|t[|cFF00BCD4Hillsbrad Human Skulls|r]
.bankwithdraw 5075 >> Withdraw your |T134128:0|t[Blood Shards]
.bankwithdraw 868 >> Withdraw your |T132938:0|t[Digging Claw]
.target William Montague
step
.goto Undercity,53.74,54.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bel'dugur|r
.turnin 1013 >>Turn in The Book of Ur
.target Keeper Bel'dugur
.dungeon SFK
.isQuestComplete 1013
step
.goto Undercity,48.80,69.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Faranell|r
.accept 1109 >> Accept Going, Going, Guano!
.target Master Apothecary Faranell
.dungeon RFK
step << Warrior
.goto Undercity,48.32,15.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Angela|r
.train 5308 >> Train your class spells
.target Angela Curthas
.xp <24,1
.xp >26,1
step << Warrior
.goto Undercity,48.32,15.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Angela|r
.train 6178 >> Train your class spells
.target Angela Curthas
.xp <26,1
step << Rogue
.goto Undercity,75.19,51.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Ezekiel|r|cRXP_BUY_. Buy |r |T133849:0|t[Dust of Decay] |cRXP_BUY_and|r |T132793:0|t[Empty Vials] |cRXP_BUY_from him|r
.collect 2928,40,1067,1 
.collect 3371,40,1067,1 
.target Ezekiel Graves
step << Rogue
#completewith ThunderBluffHS
>>Craft |T132273:0|t[Instant Poisons]
.collect 6947,40,1067,1 
step << Rogue
.goto Undercity,83.86,72.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carolyn|r
.train 6762 >> Train your class spells
.target Carolyn Ward
.xp <24,1
.xp >26,1
step << Rogue
.goto Undercity,83.86,72.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carolyn|r
.train 1833 >> Train your class spells
.target Carolyn Ward
.xp <26,1
step << Warlock
.goto Undercity,88.93,15.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Richard|r
.train 6223 >> Train your class spells
.target Richard Kerwin
.xp <24,1
.xp >26,1
step << Warlock
.goto Undercity,88.93,15.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Richard|r
.train 1456 >> Train your class spells
.target Richard Kerwin
.xp <26,1
step << Druid
#completewith next
.cast 18960 >>Cast |T135758:0|t[Teleport: Moonglade]
.zoneskip Moonglade
step << Druid
.goto Moonglade,56.21,30.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dendrite|r
.turnin 30 >> Turn in Trial of the Sea lion
.accept 31 >> Accept Aquatic Form
.target Dendrite Starblaze
step
#label ThunderBluffHS
.hs >> Hearth to Thunder Bluff
.use 6948
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde-
#name 25-27 Southern Barrens/Stonetalon
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 20-30
#next 27-29 Ashenvale
step
.abandon 480 >> Abandon The Weaver
.inOnQuest 480
step
.abandon 1013 >> Abandon The Book of Ur
.inOnQuest 1013
.dungeon SFK
step
.abandon 1014 >> Abandon Arugal Must Die
.inOnQuest 1014
.dungeon SFK
step
.abandon 1098 >> Abandon Deathstalkers in Shadowfang
.inOnQuest 1098
.dungeon SFK
step << Shaman/Warrior
.goto Thunder Bluff,54.06,57.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Delgo|r|cRXP_BUY_. Buy a|r |T132408:0|t[Merciless Axe] |cRXP_BUY_from him if it's available and you didn't get it in Hillsbrad|r
.collect 12249,1,868,1 
.money <3.0195
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<21.0
.target Delgo Ragetotem
step << Hunter
#completewith HunterTraining26
.goto Thunder Bluff,61.31,78.25,80 >> Travel to the Hunter Rise
step << Hunter
.goto Thunder Bluff,59.13,86.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 14262 >> Train your class spells
.target Urek Thunderhorn
.xp <24,1
.xp >26,1
step << Hunter
.goto Thunder Bluff,59.13,86.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 3045 >> Train your class spells
.target Urek Thunderhorn
.xp <26,1
step << Hunter
#label HunterTraining26
.goto Thunder Bluff,54.07,84.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hesuwa|r
.train 24558 >> Train your pet spells
.target Hesuwa Thunderhorn
step << Druid
#completewith next
.goto Thunder Bluff,69.88,30.90,80 >> Travel to the Elder Rise
step << Druid
.goto Thunder Bluff,76.48,27.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Turak|r
.trainer >> Train your class spells
.turnin 31 >> Turn in Aquatic Form
.target Turak Runetotem
step << Hunter
.goto Thunder Bluff,46.98,45.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kuna|r|cRXP_BUY_. Buy a|r |T135495:0|t[Sturdy Recurve Bow] |cRXP_BUY_from her if it's available|r
.collect 11306,1,868,1 
.money <1.9467
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<12.9
.target Kuna Thunderhorn
step
#completewith next
.goto Thunder Bluff,28.14,32.97,40,0
.goto Thunder Bluff,28.51,28.95,10 >> Travel to the Spirit Rise and enter the pools of vision
step
.goto Thunder Bluff,22.90,21.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zamah|r
.turnin 1067 >> Turn in Return to Thunder Bluff
.accept 1086 >> Accept The Flying Machine Airport
.target Apothecary Zamah
step << Priest
.goto Thunder Bluff,25.31,15.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Miles|r
.train 3747 >> Train your class spells
.target Miles Welsh
.xp <24,1
.xp >26,1
step << Priest
.goto Thunder Bluff,25.31,15.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Miles|r
.train 992 >> Train your class spells
.target Miles Welsh
.xp <26,1
step << Mage
.goto Thunder Bluff,22.74,14.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shymm|r
.train 8400 >> Train your class spells
.target Archmage Shymm
.xp <24,1
.xp >26,1
step << Mage
.goto Thunder Bluff,22.74,14.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shymm|r
.train 120 >> Train your class spells
.target Archmage Shymm
.xp <26,1
step << Shaman
.goto Thunder Bluff,23.64,18.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 905 >> Train your class spells
.target Tigor Skychaser
.xp <24,1
.xp >26,1
step << Shaman
.goto Thunder Bluff,23.64,18.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 8190 >> Train your class spells
.target Tigor Skychaser
.xp <26,1
step
#completewith next
+Create |T133688:0|t[Wool Bandages] until your skill is 115 or higher
.skill firstaid,<1,1
step
.goto Thunder Bluff,29.68,21.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pand|r
.train 3278 >> Train |T133687:0|t[Heavy Wool Bandage]
.target Pand Stonebinder
.skill firstaid,<1,1
step
#completewith FlytoCampT2
>>Abandon A Recipe for Death
.abandon 264 >> Abandon A Recipe for Death
.isOnQuest 264
step
#completewith FlytoCampT2
>>Abandon Mura Runetotem
.abandon 3301 >> Abandon Mura Runetotem
.isOnQuest 264
step
.goto Thunder Bluff,54.96,51.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zangen|r
.accept 1195 >> Accept The Sacred Flame
.target Zangen Stonehoof
step
#label FlytoCampT2
#completewith next
.goto Thunder Bluff,47.00,49.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tal|r
.fly Camp Taurajo >>Fly to Camp Taurajo
.target Tal
.zoneskip The Barrens
step
.goto The Barrens,44.55,59.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mangletooth|r
.accept 879 >> Accept Betrayal from Within
.target Mangletooth
step
#completewith CampTHS2
>>|cRXP_WARN_Use your remaining|r |T134128:0[tBlood Shards] |cRXP_WARN_to get|r |T136104:0|t[Razorhide] |cRXP_WARN_and other buffs if you still have some|r << !Mage !Druid
>>|cRXP_WARN_Use your remaining|r |T134128:0[tBlood Shards] |cRXP_WARN_to get buffs if you still have some|r << Mage/Druid
step
.goto The Barrens,44.85,59.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorn Skyseer|r
.accept 6382 >>Accept The Ashenvale Hunt
.target Jorn Skyseer
step << Warrior
.goto The Barrens,44.67,59.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ruga Ragetotem|r inside the building
.turnin 1823 >>Turn in Speak with Ruga
.accept 1824 >>Accept Trial at the Field of Giants
.target Ruga Ragetotem
step
#label CampTHS2
.goto The Barrens,45.58,59.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Byula|r
.home >>Set your Hearthstone to Camp Taurajo
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Byula
step
.goto The Barrens,44.63,62.71,80,0
.goto The Barrens,45.78,63.09,80,0
.goto The Barrens,49.57,59.36,80,0
>>Find & kill |cRXP_ENEMY_Owatanka|r (Blue Thunder Lizard) around this area. Loot him for |T133723:0|t[|cFF00BCD4Owatanka's Tailspike|r]. Use it to start the quest
>>|cFFFCDC00Skip this quest if you can't find him|r
.collect 5102,1,884 
.accept 884 >>Accept Owatanka
.use 5102
.unitscan Owatanka
step << Warrior
.loop 25,The Barrens,45.17,69.08,43.87,68.84,42.17,69.65,42.35,71.85,42.77,72.28,43.86,72.06,45.38,72.25,45.17,69.08
>>Kill |cFFFF5722Silithid Protectors|r, |cFFFF5722Silithid Swarmers|r, |cFFFF5722Silithid Creepers|r and |cFFFF5722Silithid Grubs|r. Loot them for their |T133027:0|t[Twitching Antenna]
>>|cFFFCDC00NOTE: The |T133027:0|t[Twitching Antenna] only have a 15 minute duration, do not AFK or logout during this quest|r
.complete 1824,1 
.mob Silithid Protector
.mob Silithid Swarmer
.mob Silithid Creeper
.mob Silithid Grub
step << Warrior
.goto The Barrens,44.67,59.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ruga Ragetotem|r inside the building
>>|cRXP_WARN_Skip the follow-up|r
.turnin 1824 >>Turn in Trial at the Field of Giants
.target Ruga Ragetotem
step
#completewith next
>>Kill the |cFFFF5722Silithid Harvester|r. Loot it for the |T134321:0|t[|cFF00BCD4Harvester's Head|r]. Use it to start the quest
>>|cFFFCDC00Skip this quest if you can't find him|r
.collect 5138,1,897,1 
.accept 897 >>Accept The Harvester
.use 5138
.unitscan Silithid Harvester
step
#label SilithidEggs
.goto The Barrens,45.04,69.85,60,0
.goto The Barrens,42.91,69.86,60,0
.goto The Barrens,42.97,71.11,60,0
.goto The Barrens,45.36,72.36,60,0
.goto The Barrens,47.40,70.11,60,0
.goto The Barrens,48.40,70.08,60,0
.goto The Barrens,42.91,69.86
>>Loot the |cRXP_PICK_Silithid Mounds|r for |cRXP_LOOT_Silithid Eggs|r
.complete 868,1 
step
#completewith Gann1
>>Kill |cRXP_ENEMY_Stormhides|r. Loot them for their |cFF00BCD4Lightning Glands|r
>>Kill |cRXP_ENEMY_Greater Thunderhawks|r. Loot them for a |cFF00BCD4Saliva Gland|r
>>Kill |cRXP_ENEMY_Kodos|r. Loot them for a |cFF00BCD4Kodo Liver|r
.complete 822,1 
.complete 822,2 
.complete 822,3 
.mob Stormhide
.mob Greater Thunderhawk
.mob Barrens Kodo
.mob Greater Barrens Kodo
.mob Wooly Kodo
step << Shaman
#completewith next
.goto The Barrens,44.76,74.79,45,0
>>Kill |cFFFF5722Washte Pawne|r. Loot him for |T135992:0|t[|cFF00BCD4Washte Pawne's Feather|r]. Use it to start the quest
.collect 5103,1,885 
.accept 885 >>Accept Washte Pawne
.use 5103
.unitscan Washte Pawne
step << Shaman
#completewith next
.goto The Barrens,43.84,77.28,25,0
.goto The Barrens,43.62,77.29,25,0
.goto The Barrens,43.42,77.41,15 >>Travel toward |cRXP_FRIENDLY_Brine|r
step << Shaman
.goto The Barrens,43.42,77.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brine|r
.turnin 1536 >>Turn in Call of Water
.accept 1534 >>Accept Call of Water
.target Brine
step
#completewith next
>>Kill |cFFFF5722Washte Pawne|r. Loot him for |T135992:0|t[|cFF00BCD4Washte Pawne's Feather|r]. Use it to start the quest
.collect 5103,1,885 
.accept 885 >>Accept Washte Pawne
.use 5103
.unitscan Washte Pawne
step
#label Gann1
.line The Barrens,46.12,81.25,46.09,80.54,46.16,79.66,46.14,79.37,46.07,79.19,45.86,78.77,45.79,78.47,45.83,77.21,45.91,76.97,46.02,76.71,46.08,76.33,46.14,75.40
.goto The Barrens,46.14,75.40,40,0
.goto The Barrens,46.08,76.33,40,0
.goto The Barrens,46.02,76.71,40,0
.goto The Barrens,45.91,76.97,40,0
.goto The Barrens,45.83,77.21,40,0
.goto The Barrens,45.79,78.47,40,0
.goto The Barrens,45.86,78.77,40,0
.goto The Barrens,46.07,79,19,40,0
.goto The Barrens,46.14,79.37,40,0
.goto The Barrens,46.16,79.66,40,0
.goto The Barrens,46.09,80.54,40,0
.goto The Barrens,46.12,81.25,40,0
.goto The Barrens,46.14,75.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gann|r
.accept 843 >> Accept Gann's Reclamation
.target Gann Stonespire
step
#completewith Lok
>>Kill |cFFFF5722Razormane Stalkers|r and |cFFFF5722Razormane Pathfinders|r. Loot them for the |T135640:0|t[|cFF00BCD4Razormane Backstabber|r]
>>Kill |cFFFF5722Razormane Seers|r. Loot them for the |T135139:0|t[|cFF00BCD4Charred Razormane Wand|r]
>>Kill |cFFFF5722Razormane Warfrenzies|r. Loot them for the |T134955:0|t[|cFF00BCD4Razormane War Shield|r]
>>|cFFFCDC00The |cFFFF5722Razormane Stalkers|r are stealthed|r
.complete 893,1 
.complete 893,2 
.complete 893,3 
.mob Razormane Stalker
.mob Razormane Pathfinder
.mob Razormane Seer
.mob Razormane Warfrenzy
step
#completewith next
.goto The Barrens,44.85,78.81,45,0
.goto The Barrens,44.44,78.97,45,0
>>Kill |cFFFF5722Washte Pawne|r. Loot him for |T135992:0|t[|cFF00BCD4Washte Pawne's Feather|r]. Use it to start the quest
.collect 5103,1,885 
.accept 885 >>Accept Washte Pawne
.use 5103
.unitscan Washte Pawne
step
.goto The Barrens,44.06,80.02,45,0
.goto The Barrens,43.91,80.46,45,0
.goto The Barrens,44.03,80.38,45,0
.goto The Barrens,44.16,80.46,45,0
.goto The Barrens,44.31,80.79,45,0
.goto The Barrens,44.66,80.49,45,0
.goto The Barrens,45.10,80.30,45,0
.goto The Barrens,45.52,80.47,45,0
.goto The Barrens,45.46,80.91,45,0
.goto The Barrens,44.83,80.95,45,0
.goto The Barrens,44.15,81.44,45,0
.goto The Barrens,43.79,81.40,45,0
.goto The Barrens,43.63,80.97,45,0
.goto The Barrens,43.49,80.48,45,0
.goto The Barrens,43.24,80.49,45,0
.goto The Barrens,42.82,80.23,45,0
.goto The Barrens,42.65,79.87,45,0
.goto The Barrens,43.07,78.98,45,0
.goto The Barrens,43.48,78.95,45,0
.goto The Barrens,43.66,79.12,45,0
.goto The Barrens,43.80,79.46,45,0
.goto The Barrens,44.43,78.71,45,0
.goto The Barrens,44.89,78.87,45,0
.goto The Barrens,45.12,79.20,45,0
.goto The Barrens,45.05,79.75,45,0
.goto The Barrens,44.83,79.87,45,0
.goto The Barrens,44.37,79.85
.loop 25,The Barrens,44.37,79.85,44.83,79.87,45.05,79.75,45.12,79.20,44.89,78.87,44.43,78.71,43.80,79.46,43.66,79.12,43.48,78.95,43.07,78.98,42.65,79.87,42.82,80.23,43.24,80.49,43.49,80.48,43.63,80.97,43.79,81.40,44.15,81.44,44.83,80.95,45.46,80.91,45.52,80.47,45.10,80.30,44.66,80.49,44.31,80.79,44.16,80.46,44.03,80.38,43.91,80.46,44.06,80.02,44.37,79.85
>>Kill |cFFFF5722Kuz|r. Loot him for |cFF00BCD4Kuz's Skull|r
>>|cFFFF5722Kuz|r patrols around slightly
.complete 879,1 
.unitscan Kuz
step
#completewith next
.goto The Barrens,43.14,80.75,45,0
.goto The Barrens,43.35,81.16,45,0
>>Kill |cFFFF5722Washte Pawne|r. Loot him for |T135992:0|t[|cFF00BCD4Washte Pawne's Feather|r]. Use it to start the quest
.collect 5103,1,885 
.accept 885 >>Accept Washte Pawne
.use 5103
.unitscan Washte Pawne
step
#label Lok
.goto The Barrens,40.31,80.70,20,0
.goto The Barrens,40.14,80.56
>>Kill |cFFFF5722Lok Orcbane|r. Loot him for |cFF00BCD4Lok's Skull|r
.complete 879,3 
.mob Lok Orcbane
step
#completewith WandShield
.goto The Barrens,44.85,78.81,45,0
.goto The Barrens,44.44,78.97,45,0
.goto The Barrens,43.14,80.75,45,0
.goto The Barrens,43.35,81.16,45,0
>>Kill |cFFFF5722Washte Pawne|r. Loot him for |T135992:0|t[|cFF00BCD4Washte Pawne's Feather|r]. Use it to start the quest
.collect 5103,1,885 
.accept 885 >>Accept Washte Pawne
.use 5103
.unitscan Washte Pawne
step
#completewith next
>>Kill |cFFFF5722Razormane Stalkers|r and |cFFFF5722Razormane Pathfinders|r. Loot them for a |T135640:0|t[|cFF00BCD4Razormane Backstabber|r]
>>|cFFFCDC00The |cFFFF5722Razormane Stalkers|r are stealthed|r
.complete 893,1 
.mob Razormane Stalker
.mob Razormane Pathfinder
step
#label WandShield
.loop 25,The Barrens,42.57,78.81,42.12,78.48,41.49,78.69,41.22,79.72,40.91,80.60,40.55,80.84,41.62,80.92,41.54,82.28,42.48,82.28,42.57,78.81
>>Kill |cFFFF5722Razormane Seers|r. Loot them for a |T135139:0|t[|cFF00BCD4Charred Razormane Wand|r]
>>Kill |cFFFF5722Razormane Warfrenzies|r. Loot them for a |T134955:0|t[|cFF00BCD4Razormane War Shield|r]
.complete 893,2 
.complete 893,3 
.mob Razormane Seer
.mob Razormane Warfrenzy
step
.loop 25,The Barrens,44.07,83.34,43.54,83.14,43.60,83.69,44.07,83.34
>>Kill |cFFFF5722Nak|r. Loot him for |cFF00BCD4Nak's Skull|r
.complete 879,2 
.mob Nak
step
.goto The Barrens,44.09,83.70,15,0
.goto The Barrens,44.15,83.34,15,0
.goto The Barrens,44.38,83.05,15,0
.goto The Barrens,44.22,82.67,15,0
.goto The Barrens,44.10,82.38,15,0
.goto The Barrens,43.85,82.25,15,0
.goto The Barrens,43.76,80.84,40,0
.goto The Barrens,44.14,80.03,40,0
.goto The Barrens,44.17,81.02,40,0
.goto The Barrens,44.66,81.18,40,0
.goto The Barrens,45.08,80.34,40,0
.goto The Barrens,45.48,79.89,40,0
.goto The Barrens,44.09,83.70,15,0
.goto The Barrens,44.15,83.34,15,0
.goto The Barrens,44.38,83.05,15,0
.goto The Barrens,44.22,82.67,15,0
.goto The Barrens,44.10,82.38,15,0
.goto The Barrens,43.85,82.25,15,0
.goto The Barrens,43.76,80.84,40,0
.goto The Barrens,44.14,80.03,40,0
.goto The Barrens,44.17,81.02,40,0
.goto The Barrens,44.66,81.18,40,0
.goto The Barrens,45.08,80.34,40,0
.goto The Barrens,45.48,79.89
>>Kill |cFFFF5722Razormane Stalkers|r and |cFFFF5722Razormane Pathfinders|r. Loot them for a |T135640:0|t[|cFF00BCD4Razormane Backstabber|r]
>>|cFFFCDC00The |cFFFF5722Razormane Stalkers|r are stealthed|r
.complete 893,1 
.mob Razormane Stalker
.mob Razormane Pathfinder
step
#completewith next
>>Kill |cFFFF5722Bael'dun Excavators|r and |cFFFF5722Bael'dun Foremen|r
.complete 843,1 
.complete 843,2 
.mob Bael'dun Excavator
.mob Bael'dun Foreman
step
.goto The Barrens,47.51,85.04,15,0
.goto The Barrens,47.44,85.71,15,0
.goto The Barrens,47.94,85.68,15,0
.goto The Barrens,48.34,86.19,15,0
.goto The Barrens,47.51,85.04,15,0
.goto The Barrens,47.44,85.71,15,0
.goto The Barrens,47.94,85.68,15,0
.goto The Barrens,48.34,86.19,15,0
.goto The Barrens,47.51,85.04,15,0
.goto The Barrens,47.44,85.71,15,0
.goto The Barrens,47.94,85.68,15,0
.goto The Barrens,48.34,86.19,15,0
.goto The Barrens,47.51,85.04,15,0
.goto The Barrens,47.44,85.71,15,0
.goto The Barrens,47.94,85.68,15,0
.goto The Barrens,48.34,86.19
>>Kill |cFFFF5722Prospector Khazgorm|r. Loot him for |cFF00BCD4Khazgorm's Journal|r
.complete 843,3 
.mob Prospector Khazgorm
step
.loop 25,The Barrens,47.22,84.98,47.28,85.74,47.60,85.66,48.43,86.34,48.03,85.46,47.94,84.86,47.37,84.01,46.92,84.22,46.99,85.82,47.22,84.98
>>Kill |cFFFF5722Bael'dun Excavators|r and |cFFFF5722Bael'dun Foremen|r
.complete 843,1 
.complete 843,2 
.mob Bael'dun Excavator
.mob Bael'dun Foreman
step
#completewith BaelModan
>>Kill |cRXP_ENEMY_Stormhides|r. Loot them for their |cFF00BCD4Lightning Glands|r
>>Kill |cRXP_ENEMY_Greater Thunderhawks|r. Loot them for a |cFF00BCD4Saliva Gland|r
>>Kill |cRXP_ENEMY_Kodos|r. Loot them for a |cFF00BCD4Kodo Liver|r
.complete 822,1 
.complete 822,2 
.complete 822,3 
.mob Stormhide
.mob Greater Thunderhawk
.mob Barrens Kodo
.mob Greater Barrens Kodo
.mob Wooly Kodo
step
.line The Barrens,46.12,81.25,46.09,80.54,46.16,79.66,46.14,79.37,46.07,79.19,45.86,78.77,45.79,78.47,45.83,77.21,45.91,76.97,46.02,76.71,46.08,76.33,46.14,75.40
.goto The Barrens,46.12,81.25,40,0
.goto The Barrens,46.09,80.54,40,0
.goto The Barrens,46.16,79.66,40,0
.goto The Barrens,46.14,79.37,40,0
.goto The Barrens,46.07,79,19,40,0
.goto The Barrens,45.86,78.77,40,0
.goto The Barrens,45.79,78.47,40,0
.goto The Barrens,45.83,77.21,40,0
.goto The Barrens,45.91,76.97,40,0
.goto The Barrens,46.02,76.71,40,0
.goto The Barrens,46.08,76.33,40,0
.goto The Barrens,46.14,75.40,40,0
.goto The Barrens,46.12,81.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gann|r
.turnin 843 >> Turn in Gann's Reclamation
.accept 846 >> Accept Revenge of Gann
.target Gann Stonespire
step
#completewith next
.goto The Barrens,47.21,79.35,45,0
.goto The Barrens,47.22,79.72,45,0
>>Kill |cFFFF5722Washte Pawne|r. Loot him for |T135992:0|t[|cFF00BCD4Washte Pawne's Feather|r]. Use it to start the quest
.collect 5103,1,885 
.accept 885 >>Accept Washte Pawne
.use 5103
.unitscan Washte Pawne
step
#label BaelModan
.goto The Barrens,48.63,84.49,110 >>Travel to Bael Modan
.isOnQuest 846
step
.loop 20,The Barrens,48.96,84.36,48.88,84.02,49.28,83.76,49.22,84.21,49.47,84.41,49.09,84.67,48.96,84.36
>>Kill |cFFFF5722Bael'dun Dwarves|r. Loot them for their |cFF00BCD4Nitroglycerin|r, |cFF00BCD4Wood Pulp|r, and |cFF00BCD4Sodium Nitrate|r
>>|cRXP_WARN_Be Careful!|r |cRXP_ENEMY_Bael'dun Officers|r |cRXP_WARN_have a 50% increased parry chance for 8 seconds after they do their defense stance animation|r << Rogue/Warrior/Druid/Shaman
.complete 846,1 
.complete 846,2 
.complete 846,3 
.mob Bael'dun Rifleman
.mob Bael'dun Soldier
.mob Bael'dun Officer
step
#completewith WashtethePawne
>>Kill |cRXP_ENEMY_Stormhides|r. Loot them for their |cFF00BCD4Lightning Glands|r
>>Kill |cRXP_ENEMY_Greater Thunderhawks|r. Loot them for a |cFF00BCD4Saliva Gland|r
>>Kill |cRXP_ENEMY_Kodos|r. Loot them for a |cFF00BCD4Kodo Liver|r
.complete 822,1 
.complete 822,2 
.complete 822,3 
.mob Stormhide
.mob Greater Thunderhawk
.mob Barrens Kodo
.mob Greater Barrens Kodo
.mob Wooly Kodo
step
.line The Barrens,46.12,81.25,46.09,80.54,46.16,79.66,46.14,79.37,46.07,79.19,45.86,78.77,45.79,78.47,45.83,77.21,45.91,76.97,46.02,76.71,46.08,76.33,46.14,75.40
.goto The Barrens,46.12,81.25,40,0
.goto The Barrens,46.09,80.54,40,0
.goto The Barrens,46.16,79.66,40,0
.goto The Barrens,46.14,79.37,40,0
.goto The Barrens,46.07,79,19,40,0
.goto The Barrens,45.86,78.77,40,0
.goto The Barrens,45.79,78.47,40,0
.goto The Barrens,45.83,77.21,40,0
.goto The Barrens,45.91,76.97,40,0
.goto The Barrens,46.02,76.71,40,0
.goto The Barrens,46.08,76.33,40,0
.goto The Barrens,46.14,75.40,40,0
.goto The Barrens,46.12,81.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gann|r
.turnin 846 >> Turn in Revenge of Gann
.accept 849 >> Accept Revenge of Gann
.target Gann Stonespire
step
.goto The Barrens,46.97,85.63
>>Click the |cFFDB2EEFBael Modan Flying Machine|r atop the platform
>>|cFFFCDC00This has a 50 yard range|r
.complete 849,1 
step
.line The Barrens,46.12,81.25,46.09,80.54,46.16,79.66,46.14,79.37,46.07,79.19,45.86,78.77,45.79,78.47,45.83,77.21,45.91,76.97,46.02,76.71,46.08,76.33,46.14,75.40
.goto The Barrens,46.12,81.25,40,0
.goto The Barrens,46.09,80.54,40,0
.goto The Barrens,46.16,79.66,40,0
.goto The Barrens,46.14,79.37,40,0
.goto The Barrens,46.07,79,19,40,0
.goto The Barrens,45.86,78.77,40,0
.goto The Barrens,45.79,78.47,40,0
.goto The Barrens,45.83,77.21,40,0
.goto The Barrens,45.91,76.97,40,0
.goto The Barrens,46.02,76.71,40,0
.goto The Barrens,46.08,76.33,40,0
.goto The Barrens,46.14,75.40,40,0
.goto The Barrens,46.12,81.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gann|r
.turnin 849 >> Turn in Revenge of Gann
.target Gann Stonespire
step
#label WashtethePawne
.loop 25,The Barrens,44.85,78.81,44.44,78.97,43.14,80.75,43.35,81.16,47.22,79.72,47.21,79.35,44.76,74.79,44.85,78.81
>>Kill |cFFFF5722Washte Pawne|r. Loot him for |T135992:0|t[|cFF00BCD4Washte Pawne's Feather|r]. Use it to start the quest
.collect 5103,1,885 
.accept 885 >>Accept Washte Pawne
.use 5103
.unitscan Washte Pawne
step
.goto The Barrens,45.35,77.51,60,0
.goto The Barrens,45.42,76.23,60,0
.goto The Barrens,45.05,75.25,60,0
.goto The Barrens,44.70,74.31,60,0
.goto The Barrens,47.28,74.73,60,0
.goto The Barrens,47.89,75.80,60,0
.goto The Barrens,47.70,80.48
>>Kill |cRXP_ENEMY_Stormhides|r. Loot them for their |cFF00BCD4Lightning Glands|r
>>Kill |cRXP_ENEMY_Greater Thunderhawks|r. Loot them for a |cFF00BCD4Saliva Gland|r
>>Kill |cRXP_ENEMY_Kodos|r. Loot them for a |cFF00BCD4Kodo Liver|r
.complete 822,1 
.complete 822,2 
.complete 822,3 
.mob Stormhide
.mob Greater Thunderhawk
.mob Barrens Kodo
.mob Greater Barrens Kodo
.mob Wooly Kodo
step
#completewith WeaponsofChoiceTurnin
.hs >> Hearth to Camp Taurajo
.use 6948
.cooldown item,6948,>0
step
#completewith next
.goto The Barrens,45.13,58.47,120 >> Travel back to Camp Taurajo. You can also grind until your |T134414:0|t[Hearthstone] is back up
.cooldown item,6948,<0
step
#label WeaponsofChoiceTurnin
.goto The Barrens,45.10,57.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tatternack|r
.accept 893 >> Accept Weapons of Choice
.turnin 893 >> Turn in Weapons of Choice
.target Tatternack Steelforge
step
.goto The Barrens,44.86,59.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorn|r
.turnin 884 >>Turn in Owatanka
.turnin 885 >>Turn in Washte Pawne
.turnin 897 >>Turn in The Harvester
.isOnQuest 884
.isOnQuest 885
.isOnQuest 897
.target Jorn Skyseer
step
.goto The Barrens,44.86,59.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorn|r
.turnin 884 >>Turn in Owatanka
.turnin 885 >>Turn in Washte Pawne
.isOnQuest 884
.isOnQuest 885
.target Jorn Skyseer
step
.goto The Barrens,44.86,59.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorn|r
.turnin 884 >>Turn in Owatanka
.turnin 897 >>Turn in The Harvester
.isOnQuest 884
.isOnQuest 897
.target Jorn Skyseer
step
.goto The Barrens,44.86,59.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorn|r
.turnin 885 >>Turn in Washte Pawne
.turnin 897 >>Turn in The Harvester
.isOnQuest 885
.isOnQuest 897
.target Jorn Skyseer
step
.goto The Barrens,44.86,59.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorn|r
.turnin 884 >>Turn in Owatanka
.isOnQuest 884
.target Jorn Skyseer
step
.goto The Barrens,44.86,59.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorn|r
.turnin 885 >>Turn in Washte Pawne
.isOnQuest 885
.target Jorn Skyseer
step
.goto The Barrens,44.86,59.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorn|r
.turnin 897 >>Turn in The Harvester
.isOnQuest 897
.target Jorn Skyseer
step
.goto The Barrens,44.54,59.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mangletooth|r
.turnin 879 >> Turn in Betrayal from Within
.accept 906 >> Accept Betrayal from Within
.target Mangletooth
step
#completewith next
.goto The Barrens,44.45,59.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa|r
.fly Crossroads >>Fly to The Crossroads
.target Omusa Thunderhorn
step
.goto The Barrens,51.50,30.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thork|r
.turnin 906 >> Turn in Betrayal from Within
.target Thork
step
#completewith next
+|cRXP_WARN_If you have over 15 |cRXP_LOOT_Silithid Eggs|r|cRXP_WARN_, split the stack of any extras (shift click), then delete them|r
step
.goto The Barrens,51.07,29.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Korran|r
.turnin 868 >> Turn in Egg Hunt
.target Korran
step
.goto The Barrens,51.99,29.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Boorand|r
.home >>Set your Hearthstone to Crossroads
.target Innkeeper Boorand Plainswind
step << Hunter
#completewith next
.goto The Barrens,51.50,30.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Devrak|r
.fly Orgrimmar >> Fly to Orgrimmar
.zoneskip Orgrimmar
.target Devrak
step << Hunter
.goto Orgrimmar,48.12,80.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Trak'gen|r
.collect 3030,1800,874,1 << Hunter 
.target Trak'gend

step << Hunter
.goto Orgrimmar,45.13,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Ratchet >> Fly to Ratchet
.target Doras
step << !Hunter
.goto The Barrens,51.50,30.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Devrak|r
.fly Ratchet >> Fly to Ratchet
.zoneskip Orgrimmar
.target Devrak
step
.goto The Barrens,62.370,37.615
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mebok|r
.accept 1221 >> Accept Blueleaf Tubers
.target Mebok Mizzyrix
.dungeon RFK
step
>>Loot the |cRXP_LOOT_Snufflenose Command Stick|r, |cRXP_LOOT_Snufflenose Owner's Manual|r and |cRXP_LOOT_Crate With Holes|r next to |cRXP_FRIENDLY_Mebok|r
.collect 6684,1,1221,1 
.goto The Barrens,62.340,37.607
.collect 5897,1,1221,1 
.goto The Barrens,62.332,37.623
.collect 5880,1,1221,1 
.goto The Barrens,62.323,37.620
.dungeon RFK
step
.goto The Barrens,62.27,38.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drohn|r
.turnin 822 >>Turn in Chen's Empty Keg
.target Brewmaster Drohn
.isQuestComplete 822
step
.goto The Barrens,65.84,43.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mahren|r
.turnin 874 >>Turn in Mahren Skyseer
.accept 873 >>Accept Isha Awak
.target Mahren Skyseer
step
.goto The Barrens,65.51,47.32,70,0
.goto The Barrens,64.21,50.70,70,0
.goto The Barrens,63.63,53.85,70,0
.loop 50,The Barrens,65.51,47.32,64.21,50.70,63.63,53.85
>>Kill |cFFFF5722Isha Awak|r. Loot him for the |cFF00BCD4Heart of Isha Awak|r
.complete 873,1 
.unitscan Isha Awak
step
.goto The Barrens,65.84,43.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mahren|r
.turnin 873 >> Turn in Isha Awak
.target Mahren Skyseer
step
#completewith CenariusPickup
.goto The Barrens,63.09,37.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bragok|r
.fly Sun Rock Retreat >> Fly to Sun Rock Retreat
.zoneskip Stonetalon Mountains
.target Bragok
.cooldown item,6948,<0,1
step
#completewith CenariusPickup
.hs >> Hearth to The Crossroads
.goto The Barrens,51.99,29.89,30 >> Arrive in Crossroads
.use 6948
.cooldown item,6948,>0,1
step
#completewith CenariusPickup
.goto The Barrens,51.50,30.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Devrak|r
.fly Sun Rock Retreat >> Fly to Sun Rock Retreat
.zoneskip Stonetalon Mountains
.target Devrak
.cooldown item,6948,>55m,1
step
#label CenariusPickup
.goto Stonetalon Mountains,45.90,60.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Braelyn|r
.accept 1087 >> Accept Cenarius' Legacy
.target Braelyn Firehand
step
.goto Stonetalon Mountains,47.30,61.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maggran|r
.accept 5881 >> Accept Calling in the Reserves
.accept 6282 >> Accept Harpies Threaten
.target Maggran Earthbinder
step
.goto Stonetalon Mountains,47.40,58.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tammra Windfield|r
.accept 6301 >> Accept Cycle of Rebirth
.target Tammra Windfield
step
.goto Stonetalon Mountains,47.47,62.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Jayka|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Jayka
step
.goto Stonetalon Mountains,47.61,61.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Jeeda|r |cRXP_BUY_on the second floor of the inn|r
.vendor >> |cRXP_BUY_Buy|r |T134831:0|t[Healing Potions] |cRXP_BUY_from her if they're up|r
.target Jeeda
step
#completewith next
.goto Stonetalon Mountains,49.38,61.68,30,0
.goto Stonetalon Mountains,48.92,62.71,30,0
.goto Stonetalon Mountains,48.11,63.88,30,0
.goto Stonetalon Mountains,47.21,64.05,30 >> Run up the path to the right
step
.goto Stonetalon Mountains,47.36,64.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tsunaman|r
.accept 6393 >>Accept Elemental War
.target Tsunaman
step
.goto Stonetalon Mountains,59.08,75.70
>>Click the |cRXP_FRIENDLY_Wanted Poster|r
.accept 6284 >>Accept Arachnophobia
step
.goto Stonetalon Mountains,51.89,73.81,50,0
.goto Stonetalon Mountains,52.46,71.67
>>Kill |cRXP_ENEMY_Besseleth|r. Loot her for for her |cRXP_LOOT_Fang|r
>>|cRXP_WARN_Clear out the area befor you pull her. Be careful, she can web you for 10 seconds!|r
.complete 6284,1 
.unitscan Besseleth
step
#completewith next
.goto Stonetalon Mountains,58.99,62.60,100 >> Travel to Windshear Crag
step
.goto Stonetalon Mountains,58.99,62.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ziz|r
.accept 1096 >> Accept Gerenzo Wrenchwhistle
.target Ziz Fizziks
step
.line Stonetalon Mountains,70.82,55.25,70.52,56.22,69.76,56.70,68.52,56.04,67.77,55.97,66.94,56.25,66.41,56.31,65.74,57.20,65.14,57.02,64.37,56.47,63.72,56.80,62.99,56.25,62.32,56.11,61.58,55.10,61.10,54.68,60.98,54.06,59.81,53.51,59.66,52.14,60.33,51.68
.goto Stonetalon Mountains,61.03,52.32,30,0
.goto Stonetalon Mountains,60.33,51.68,30,0
.goto Stonetalon Mountains,59.66,52.14,30,0
.goto Stonetalon Mountains,59.81,53.51,30,0
.goto Stonetalon Mountains,60.98,54.06,30,0
.goto Stonetalon Mountains,61.10,54.68,30,0
.goto Stonetalon Mountains,61.58,55.10,30,0
.goto Stonetalon Mountains,62.32,56.11,30,0
.goto Stonetalon Mountains,62.99,56.25,30,0
.goto Stonetalon Mountains,63.72,56.80,30,0
.goto Stonetalon Mountains,64.37,56.47,30,0
.goto Stonetalon Mountains,65.14,57.02,30,0
.goto Stonetalon Mountains,65.74,57.20,30,0
.goto Stonetalon Mountains,66.41,56.31,30,0
.goto Stonetalon Mountains,66.94,56.25,30,0
.goto Stonetalon Mountains,67.77,55.97,30,0
.goto Stonetalon Mountains,68.52,56.04,30,0
.goto Stonetalon Mountains,69.76,56.70,30,0
.goto Stonetalon Mountains,70.52,56.22,30,0
.goto Stonetalon Mountains,70.82,55.25,30,0
.goto Stonetalon Mountains,59.66,52.14
>>Kill |cRXP_ENEMY_XT:9|r. It patrols the southern side of the river
.complete 1068,2 
.unitscan XT:9
step
.line Stonetalon Mountains,67.18,46.87,66.53,46.95,65.72,45.09,63.73,45.02,63.72,45.92,63.43,46.57,64.43,46.13,64.72,46.63,64.82,47.72,65.11,48.31,65.98,48.67,66.24,49.65,66.65,49.58,66.88,48.95,68.41,49.58,69.45,46.56,70.22,48.62,70.95,48.49,71.41,45.54,71.25,43.45
.goto Stonetalon Mountains,67.18,46.87,30,0
.goto Stonetalon Mountains,66.53,46.95,30,0
.goto Stonetalon Mountains,65.72,45.09,30,0
.goto Stonetalon Mountains,63.73,45.02,30,0
.goto Stonetalon Mountains,63.72,45.92,30,0
.goto Stonetalon Mountains,63.43,46.57,30,0
.goto Stonetalon Mountains,64.43,46.13,30,0
.goto Stonetalon Mountains,64.72,46.63,30,0
.goto Stonetalon Mountains,64.82,47.72,30,0
.goto Stonetalon Mountains,65.11,48.31,30,0
.goto Stonetalon Mountains,65.98,48.67,30,0
.goto Stonetalon Mountains,66.24,49.65,30,0
.goto Stonetalon Mountains,66.65,49.58,30,0
.goto Stonetalon Mountains,66.88,48.95,30,0
.goto Stonetalon Mountains,68.41,49.58,30,0
.goto Stonetalon Mountains,69.45,46.56,30,0
.goto Stonetalon Mountains,70.22,48.62,30,0
.goto Stonetalon Mountains,70.95,48.49,30,0
.goto Stonetalon Mountains,71.41,45.54,30,0
.goto Stonetalon Mountains,71.25,43.45,30,0
.goto Stonetalon Mountains,64.82,47.23
>>Kill |cRXP_ENEMY_XT:4|r. It patrols the northern side of the river
.complete 1068,1 
.unitscan XT:4
step
.goto Stonetalon Mountains,66.47,45.45
.cast 6620 >>Move to the top of the platform and place the the |T132620:0|t[Toxic Fogger]
.use 5638
.complete 1086,1 >> Place the Toxic Fogger
.isOnQuest 1086
step
#completewith next
.goto Stonetalon Mountains,68.81,39.61,50,0
.goto Stonetalon Mountains,67.83,37.77,50,0
.goto Stonetalon Mountains,66.58,37.71,50,0
.goto Stonetalon Mountains,64.56,38.03,50 >>Travel up the mountain and enter the platform
step
.goto Stonetalon Mountains,64.48,40.24,20,0
.goto Stonetalon Mountains,63.45,39.78,20,0
.goto Stonetalon Mountains,62.75,40.31
>>Kill |cFFFF5722Gerenzo|r. Loot him for his |cFF00BCD4Mechanical Arm|r
>>|cFFFCDC00Be careful!|r |cFFFF5722Venture Co. Machine Smiths|r |cFFFCDC00can summon|r |cFFFF5722Venture Co. Harvest Reapers|r|cFFFCDC00. Kill them one at a time|r
.complete 1096,1 
.unitscan Gerenzo Wrenchwhistle
step
.goto Stonetalon Mountains,62.70,40.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Nizzik|r|cRXP_BUY_. Buy gear upgrades if any are available|r
.vendor
.target Nizzik
step
.goto Stonetalon Mountains,58.99,62.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ziz|r
.turnin 1096 >> Turn in Gerenzo Wrenchwhistle
.target Ziz Fizziks
step
.goto Stonetalon Mountains,47.20,61.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maggran|r
.turnin 6284 >> Turn in Arachnophobia
.target Maggran Earthbinder
.isQuestComplete 6284
step
#completewith ReachthePeak
.goto Stonetalon Mountains,49.73,45.10,50,0
.goto Stonetalon Mountains,48.88,43.83,50,0
.goto Stonetalon Mountains,46.35,39.37,50,0
.goto Stonetalon Mountains,46.85,31.87,50,0
>>Loot all the |cFF00BCD4Gaea Seeds|r you see from the ground as you travel past the lake
.complete 6301,1 
step
#completewith next
.goto Stonetalon Mountains,46.64,27.48,80,0
.goto Stonetalon Mountains,45.59,23.87,80,0
.goto Stonetalon Mountains,43.79,16.95,80,0
>>Kill all the |cFFFF5722Antlered Coursers|r you see en route to Stonetalon Peak. Loot them for their |cFF00BCD4Eyes|r
.complete 1058,3 
.mob Antlered Courser
step
#label ReachthePeak
.goto Stonetalon Mountains,41.61,16.02,40 >>Arrive in Stonetalon Peak
step
#completewith Whiskers
>>Kill |cFFFF5722Sons of Cenarius|r, |cFFFF5722Daughters of Cenarius|r and |cFFFF5722Cenarion Botanists|r
.complete 1087,1 
.complete 1087,2 
.complete 1087,3 
.mob Son of Cenarius
.mob Daughter of Cenarius
.mob Cenarion Botanist
step
#completewith Whiskers
>>Kill |cFFFF5722Sap Beasts|r. Loot them for their |cFF00BCD4Sap|r
>>|cFFFCDC00Only regular|r |cFFFF5722Sap Beasts|r |cFFFCDC00drop the sap.|r |cFFFF5722Corrosive Sap Beasts|r |cFFFCDC00do not drop it|r
.complete 1058,1 
.mob Sap Beast
step
#completewith next
>>Kill a |cFFFF5722Fey Dragon|r. Loot it for its |cFF00BCD4Scale|r
.complete 1058,4 
.mob Fey Dragon
.mob Wily Fey Dragon
step
#label Whiskers
.goto Stonetalon Mountains,31.75,12.58,50,0
.goto Stonetalon Mountains,30.87,9.47,50,0
.goto Stonetalon Mountains,32.40,9.97,50,0
.goto Stonetalon Mountains,33.33,8.16,50,0
.goto Stonetalon Mountains,34.68,7.89,50,0
.goto Stonetalon Mountains,32.24,10.76
>>Kill |cFFFF5722Twilight Runners|r. Loot them for their |cFF00BCD4Whiskers|r
.complete 1058,2 
.mob Twilight Runner
step
#completewith CenariusLegacy
>>Kill |cFFFF5722Sap Beasts|r. Loot them for their |cFF00BCD4Sap|r
>>|cFFFCDC00Only regular|r |cFFFF5722Sap Beasts|r |cFFFCDC00drop the sap.|r |cFFFF5722Corrosive Sap Beasts|r |cFFFCDC00do not drop it|r
.complete 1058,1 
.mob Sap Beast
step
#completewith next
>>Kill a |cFFFF5722Fey Dragon|r. Loot it for a |cFF00BCD4Scale|r
.complete 1058,4 
.mob Fey Dragon
.mob Wily Fey Dragon
step
#label CenariusLegacy
.loop 25,Stonetalon Mountains,34.43,12.65,35.49,15.33,36.99,15.29,37.71,14.81,38.17,12.77,37.95,11.21,36.25,10.27,35.41,11.13
>>Kill |cFFFF5722Sons of Cenarius|r, |cFFFF5722Daughters of Cenarius|r and |cFFFF5722Cenarion Botanists|r
.complete 1087,1 
.complete 1087,2 
.complete 1087,3 
.mob Son of Cenarius
.mob Daughter of Cenarius
.mob Cenarion Botanist
step
#completewith next
>>Kill |cFFFF5722Sap Beasts|r. Loot them for their |cFF00BCD4Sap|r
>>|cFFFCDC00Only regular|r |cFFFF5722Sap Beasts|r |cFFFCDC00drop the sap.|r |cFFFF5722Corrosive Sap Beasts|r |cFFFCDC00do not drop it|r
.complete 1058,1 
.mob Sap Beast
step
.goto Stonetalon Mountains,33.96,11.82,60,0
.goto Stonetalon Mountains,36.64,18.76,60,0
.goto Stonetalon Mountains,33.96,11.82
>>Kill a |cFFFF5722Fey Dragon|r. Loot it for a |cFF00BCD4Scale|r
.complete 1058,4 
.mob Fey Dragon
.mob Wily Fey Dragon
step
.goto Stonetalon Mountains,33.00,16.21,50,0
.goto Stonetalon Mountains,33.61,20.27,50,0
.goto Stonetalon Mountains,35.78,19.13,50,0
.goto Stonetalon Mountains,37.57,20.33,50,0
.goto Stonetalon Mountains,38.62,18.04,50,0
.goto Stonetalon Mountains,39.80,17.10,50,0
.goto Stonetalon Mountains,33.61,20.27
>>Kill |cFFFF5722Sap Beasts|r. Loot them for their |cFF00BCD4Sap|r
>>|cFFFCDC00Only regular|r |cFFFF5722Sap Beasts|r |cFFFCDC00drop the sap.|r |cFFFF5722Corrosive Sap Beasts|r |cFFFCDC00do not drop it|r
.complete 1058,1 
.mob Sap Beast
step
.goto Stonetalon Mountains,44.51,20.92,50,0
.goto Stonetalon Mountains,44.45,23.59,50,0
.goto Stonetalon Mountains,46.26,26.72,50,0
.goto Stonetalon Mountains,44.51,20.92
>>Finish killing |cFFFF5722Antlered Coursers|r as you run south back to the lake. Loot them for their |cFF00BCD4Eyes|r
.complete 1058,3 
.mob Antlered Courser
step
.loop 25,Stonetalon Mountains,47.93,36.17,50.44,37.28,50.56,39.79,51.75,42.62,49.72,43.27,49.73,45.09,48.92,43.86,46.98,42.83,45.78,43.13,45.95,40.72,47.04,37.53
>>Loot |cFF00BCD4Gaea Seeds|r from the ground around the lake
.complete 6301,1 
step
#completewith BloodfuryHarpies
.goto Stonetalon Mountains,42.64,42.43,50,0
.goto Stonetalon Mountains,38.18,43.28,60,0
.goto Stonetalon Mountains,34.85,58.38,80 >> Follow the Western path toward The Charred Vale
step
#completewith next
>>Kill |cFFFF5722Fire Elementals|r. Loot them for their |cFF00BCD4Increndrite|r
.complete 6393,1 
.mob Burning Ravager
.mob Rogue Flame Spirit
.mob Burning Destroyer
step
#label BloodfuryHarpies
.goto Stonetalon Mountains,34.07,61.47,60,0
.goto Stonetalon Mountains,31.59,60.58,60,0
.goto Stonetalon Mountains,29.90,62.51,60,0
.goto Stonetalon Mountains,28.38,64.26,60,0
.goto Stonetalon Mountains,27.65,67.88,60,0
.goto Stonetalon Mountains,27.36,69.75,60,0
.goto Stonetalon Mountains,29.98,71.52,60,0
.goto Stonetalon Mountains,34.96,71.29,60,0
.goto Stonetalon Mountains,36.57,68.19,60,0
.goto Stonetalon Mountains,35.24,63.44,60,0
.goto Stonetalon Mountains,33.94,61.17,60,0
.goto Stonetalon Mountains,29.61,63.57
>>Kill |cFFFF5722Bloodfury Harpies|r. |cFFFCDC00Be careful, they have special abilities|r
>>|cFFFF5722Bloodfury Slayers execute you when you are below 20% health|r
>>|cFFFF5722Bloodfury Ambushers shock for a amount of high damage on low cooldown|r
>>|cFFFF5722Bloodfury Roguefeathers can|r |T132152:0|t[Thrash]
.complete 6282,1 
.complete 6282,2 
.complete 6282,3 
.complete 6282,4 
.mob Bloodfury Harpy
.mob Bloodfury Ambusher
.mob Bloodfury Slayer
.mob Bloodfury Roguefeather
step
#completewith TammraTurnin1
.goto Stonetalon Mountains,37.89,67.77,30,0
.goto Stonetalon Mountains,39.58,69.84,30,0
.goto Stonetalon Mountains,41.20,70.09,30,0
.goto Stonetalon Mountains,42.07,66.41,30,0
.goto Stonetalon Mountains,43.54,65.35,30,0
.goto Stonetalon Mountains,44.68,63.50,30 >> Follow the Western path to Sun Rock Retreat
step
.goto Stonetalon Mountains,47.36,64.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tsunaman|r
.turnin 6393 >> Turn in Elemental War
.target Tsunaman
.isQuestComplete 6393
step
#label TammraTurnin1
.goto Stonetalon Mountains,47.40,58.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tammra Windfield|r
.turnin 6301 >> Turn in Cycle of Rebirth
.accept 6381 >> Accept New Life
.target Tammra Windfield
step
.goto Stonetalon Mountains,47.20,61.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maggran|r
.turnin 6282 >> Turn in Harpies Threaten
.accept 6283 >> Accept Bloodfury Bloodline
.target Maggran Earthbinder
.group
step
.goto Stonetalon Mountains,47.20,61.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maggran|r
.turnin 6282 >> Turn in Harpies Threaten
.target Maggran Earthbinder
step
.goto Stonetalon Mountains,47.47,62.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Jayka|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Jayka
step
.goto Stonetalon Mountains,47.61,61.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Jeeda|r |cRXP_BUY_on the second floor of the inn|r
.vendor >> |cRXP_BUY_Buy|r |T134831:0|t[Healing Potions] |cRXP_BUY_from her if they're up|r
.target Jeeda
step
.goto Stonetalon Mountains,45.90,60.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Braelyn|r
.turnin 1087 >> Turn in Cenarius' Legacy
.accept 1088 >> Accept Ordanus
.target Braelyn Firehand
.group
step
.goto Stonetalon Mountains,45.90,60.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Braelyn|r
.turnin 1087 >> Turn in Cenarius' Legacy
.target Braelyn Firehand
step
#completewith next
.goto Stonetalon Mountains,44.31,63.64,30,0
.goto Stonetalon Mountains,43.31,65.47,30,0
.goto Stonetalon Mountains,42.07,66.51,30,0
.goto Stonetalon Mountains,41.26,70.06,30,0
.goto Stonetalon Mountains,37.80,67.68,80 >> Travel back to the Charred Vale
step
#completewith Ripper
.goto Stonetalon Mountains,36.07,67.95,40,0
.goto Stonetalon Mountains,34.22,61.25,40,0
.goto Stonetalon Mountains,31.33,61.38,40,0
>>Plant the seeds in the |cFFDB2EEFGaea Dirt Mounds|r on the ground
.complete 6381,1 
step
#completewith next
>>Kill |cFFFF5722Fire Elementals|r. Loot them for their |cFF00BCD4Increndrite|r
.complete 6393,1 
.mob Burning Ravager
.mob Rogue Flame Spirit
.mob Burning Destroyer
step
#label Ripper
.goto Stonetalon Mountains,30.75,61.91
>>Kill |cFFFF5722Bloodfury Ripper|r. Loot her for her |cFF00BCD4Remains|r
>>|cFFFCDC00Clear the|r |cFFFF5722Harpies|r |cFFFCDC00around her first! She has a large social pull radius|r
.complete 6283,1 
.unitscan Bloodfury Ripper
.group 2
step
#completewith next
>>Plant the seeds in the |cFFDB2EEFGaea Dirt Mounds|r on the ground
.complete 6381,1 
step
.goto Stonetalon Mountains,31.84,70.92,60,0
.goto Stonetalon Mountains,33.84,70.45,60,0
.goto Stonetalon Mountains,35.75,73.03,60,0
.goto Stonetalon Mountains,33.94,63.81,60,0
.goto Stonetalon Mountains,34.47,60.19,60,0
.goto Stonetalon Mountains,30.56,67.08,60,0
.goto Stonetalon Mountains,31.84,70.92
>>Kill |cFFFF5722Fire Elementals|r. Loot them for their |cFF00BCD4Increndrite|r
.complete 6393,1 
.mob Burning Ravager
.mob Rogue Flame Spirit
.mob Burning Destroyer
step
.goto Stonetalon Mountains,30.20,67.61,40,0
.goto Stonetalon Mountains,29.06,68.87,40,0
.goto Stonetalon Mountains,29.64,71.34,40,0
.goto Stonetalon Mountains,30.50,70.80,40,0
.goto Stonetalon Mountains,32.25,70.07,40,0
.goto Stonetalon Mountains,33.70,72.92,40,0
.goto Stonetalon Mountains,34.70,72.25,40,0
.goto Stonetalon Mountains,34.49,69.09,40,0
.goto Stonetalon Mountains,36.06,67.96,40,0
.goto Stonetalon Mountains,36.01,65.24,40,0
.goto Stonetalon Mountains,34.21,61.28,40,0
.goto Stonetalon Mountains,31.90,64.25
>>Plant the seeds in the |cFFDB2EEFGaea Dirt Mounds|r on the ground
.complete 6381,1 
step
.loop 25,Stonetalon Mountains,36.69,67.66,35.89,64.85,35.28,63.36,34.58,61.42,33.14,60.26,31.89,58.88,30.85,60.72,29.70,61.90,28.13,63.70,28.37,66.87,26.94,69.66,29.63,70.80,30.58,72.39,31.92,72.67,33.32,73.17,35.60,73.46,36.55,71.13,36.84,68.70
.xp 27+28850 >> Grind to 28850/38900xp
.isQuestComplete 6393
.isQuestComplete 6283
step
.loop 25,Stonetalon Mountains,36.69,67.66,35.89,64.85,35.28,63.36,34.58,61.42,33.14,60.26,31.89,58.88,30.85,60.72,29.70,61.90,28.13,63.70,28.37,66.87,26.94,69.66,29.63,70.80,30.58,72.39,31.92,72.67,33.32,73.17,35.60,73.46,36.55,71.13,36.84,68.70
.xp 27+30850 >> Grind to 30850/38900xp
.isQuestComplete 6283
step
.loop 25,Stonetalon Mountains,36.69,67.66,35.89,64.85,35.28,63.36,34.58,61.42,33.14,60.26,31.89,58.88,30.85,60.72,29.70,61.90,28.13,63.70,28.37,66.87,26.94,69.66,29.63,70.80,30.58,72.39,31.92,72.67,33.32,73.17,35.60,73.46,36.55,71.13,36.84,68.70
.xp 27+30950 >> Grind to 30950/38900xp
.isQuestComplete 6393
step
.loop 25,Stonetalon Mountains,36.69,67.66,35.89,64.85,35.28,63.36,34.58,61.42,33.14,60.26,31.89,58.88,30.85,60.72,29.70,61.90,28.13,63.70,28.37,66.87,26.94,69.66,29.63,70.80,30.58,72.39,31.92,72.67,33.32,73.17,35.60,73.46,36.55,71.13,36.84,68.70
.xp 27+32950 >> Grind to 32950/38900xp
step
#completewith TammraTurnin2
.goto Stonetalon Mountains,37.89,67.77,30,0
.goto Stonetalon Mountains,39.58,69.84,30,0
.goto Stonetalon Mountains,41.20,70.09,30,0
.goto Stonetalon Mountains,42.07,66.41,30,0
.goto Stonetalon Mountains,43.54,65.35,30,0
.goto Stonetalon Mountains,44.68,63.50,30 >> Follow the Western path back to Sun Rock Retreat
step
.goto Stonetalon Mountains,47.36,64.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tsunaman|r
.turnin 6393 >> Turn in Elemental War
.target Tsunaman
step
#label TammraTurnin2
.goto Stonetalon Mountains,47.40,58.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tammra Windfield|r
.turnin 6381 >> Turn in New Life
.target Tammra Windfield
step
.goto Stonetalon Mountains,47.20,61.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maggran|r
.turnin 6283 >> Turn in Bloodfury Bloodline
.target Maggran Earthbinder
.isQuestComplete 6283
.group
step
.goto Stonetalon Mountains,74.54,97.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jin'Zil|r
.turnin 1058 >> Turn in Jin'Zil's Forest Magic
.target Witch Doctor Jin'Zil
step
.goto The Barrens,35.19,27.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Seereth|r
.turnin 1068 >> Turn in Shredding Machines
.target Seereth Stonebreak
step << Druid
#completewith DruidTraining3
.cast 18960 >>Cast |T135758:0|t[Teleport: Moonglade]
.zoneskip Moonglade
step << Druid
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 1850 >> Train your class spells
.target Loganaar
.xp <26,1
.xp >28,1
step << Druid
#label DruidTraining3
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 3029 >> Train your class spells
.target Loganaar
.xp <28,1
step
#completewith next
.hs >> Hearth to The Crossroads
.use 6948
step
.goto The Barrens,51.50,30.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Devrak|r
.fly Orgrimmar >> Fly to Orgrimmar
.zoneskip Orgrimmar
.target Devrak
step
.abandon 6283 >> Abandon Bloodfury Bloodline
.isOnQuest 6283
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 8687 >> Train your class spells
>>|T132273:0|t[Instant Poison Rank 2] |cFFFCDC00requires 120 skill in Poisons!|r
.target Ormok
.xp <26,1
.xp >28,1
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 1833 >> Train your class spells
>>|T132273:0|t[Instant Poison Rank 2] |cFFFCDC00requires 120 skill in Poisons!|r
.target Ormok
.xp <28,1
step << Rogue
.goto Orgrimmar,48.12,80.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Trak'gen|r|cRXP_BUY_. Buy |r |T135423:0|t[Deadly Throwing Axe] |cRXP_BUY_from him|r
.collect 3137,200,6544,1 
.target K'waii
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 8190 >> Train your class spells
.target Kardris Dreamseeker
.xp <26,1
.xp >28,1
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 8053 >> Train your class spells
.target Kardris Dreamseeker
.xp <28,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 6178 >> Train your class spells
.target Grezz Ragefist
.xp <26,1
.xp >28,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 7887 >> Train your class spells
.target Grezz Ragefist
.xp <28,1
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 1456 >> Train your class spells
.target Mirket
.xp <26,1
.xp >28,1
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 6217 >> Train your class spells
.target Mirket
.xp <28,1
step << Warlock
.goto Orgrimmar,47.52,46.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kurgul|r
.vendor >>Buy any pet upgrades you can afford
.target Kurgul

step << Priest/Warlock
.goto Orgrimmar,44.16,48.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Katis|r|cRXP_BUY_. Buy a|r |T135466:0|t[Pestilent Wand] |cRXP_BUY_from her|r
.collect 5347,1,6544,1 
.money <1.5713
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<26.9
.target Katis
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 3045 >> Train your class spells
.target Ormak Grimshot
.xp <26,1
.xp >28,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14319 >> Train your class spells
.target Ormak Grimshot
.xp <28,1
step << Hunter
.goto Orgrimmar,78.11,38.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uthok|r
>>|cFF0E8312Buy|r |T132382:0|t[Razor Arrows] |cFF0E8312from him|r
.collect 3030,1800,549,1 << Hunter 
.target Jin'sora
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 120 >> Train your class spells
.target Pephredo
.xp <26,1
.xp >28,1
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 759 >> Train your class spells
.target Pephredo
.xp <28,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 992 >> Train your class spells
.target Ur'kyo
.xp <26,1
.xp >28,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 8104 >> Train your class spells
.target Ur'kyo
.xp <28,1
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 27-29 Ashenvale
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 20-30
#next 29-32 Thousand Needles
step
#completewith next
.goto Orgrimmar,26.22,61.58,80,0
.goto Orgrimmar,15.66,63.33,30,0
.zone The Barrens >> Leave Orgrimmar through the Western exit
.zoneskip The Barrens
step
#completewith next
.goto Kalimdor,56.80,45.45,15,0
.goto Ashenvale,94.54,76.15,40,0
.goto Ashenvale,93.49,73.76,40,0
.goto Ashenvale,92.47,71.18,40,0
.goto Ashenvale,91.85,68.71,40,0
.goto Ashenvale,91.39,65.86,25 >> Travel north alongside the river into Ashenvale
step
.goto Ashenvale,89.87,68.07,40,0
.goto Ashenvale,86.89,68.65,40,0
.goto Ashenvale,79.89,68.38,40,0
.goto Ashenvale,73.52,63.50,30 >>Travel to Splintertree Post
>>|cFFFCDC00You may encounter a few level 29-30 mobs, avoid them if possible|r
step
.goto Ashenvale,73.78,61.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Senani|r
.turnin 6382 >> Turn in The Ashenvale Hunt
.turnin 6383 >> Turn in The Ashenvale Hunt
.target Senani Thunderheart
step
.goto Ashenvale,74.00,60.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Kaylisk|r
.home >>Set your Hearthstone to Splintertree Post
.target Innkeeper Kaylisk
step
.goto Ashenvale,73.67,60.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Mastok|r
.accept 25 >> Accept Stonetalon Standstill
.target Mastok Wrilehiss
step
.goto Ashenvale,73.06,61.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Pixel|r
.accept 6441 >> Accept Satyr Horns
.target Pixel
step
.goto Ashenvale,73.18,61.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Vhulgra|r
.fp Splintertree Post >> Get the Splintertree Post flight path
.target Vhulgra
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kuray'bin|r
.accept 6503 >> Accept Ashenvale Outrunners
.goto Ashenvale,71.10,68.12
.target Kuray'bin
step << Hunter
#completewith next
.goto Ashenvale,73.38,61.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Qeeju|r
.stable >> Stable your pet. You will tame an |cRXP_ENEMY_Elder Ashenvale Bear|r shortly
.target Qeeju
step << Hunter
.goto Ashenvale,68.59,60.53,50,0
.goto Ashenvale,66.62,62.81,50,0
.goto Ashenvale,65.31,64.65
.cast 1515 >>|cRXP_WARN_Cast|r |T132164:0|t[Tame Beast] |cRXP_WARN_on an |cRXP_ENEMY_Elder Ashenvale Bear|r to tame it|r
.train 16830 >>|cRXP_WARN_Attack mobs with it to learn|r |T132140:0|t[Claw (Rank 4)]
.link https://www.wow-petopia.com/classic/training.php >> |cRXP_WARN_Click here for more info about pet training|r
.mob Elder Ashenvale Bear
step << Hunter
.goto Ashenvale,73.38,61.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Qeeju|r
.stable >> Abandon the |cRXP_ENEMY_Elder Ashenvale Bear|r and retrieve your regular pet
.target Qeeju
step
#completewith next
.goto Ashenvale,75.25,71.86,0
.line Ashenvale,71.46,70.10,72.08,70.47,72.50,70.60,72.94,70.67,73.33,70.61,74.36,70.10,74.86,70.06,75.26,69.96,75.94,69.80,76.11,68.95,76.93,68.04,77.35,66.96,77.60,66.33,77.93,65.93,78.24,65.72
>>Kill |cFFFF5722Sharptalon|r. Loot him for |T136063:0|t[|cFF00BCD4Sharptalon's Claw|r] and use it to start the quest
>>|cFFFCDC00Be careful!|r |cFFFF5722Sharptalon|r |cFFFCDC00is level 31 and patrols around. You can kite him back to Splintertree Post or the Forsaken Camp if you're struggling to kill him. If you do this, make sure you do 50%+ damage to get credit. You can also do this quest later|r
.collect 16305,1,2 
.unitscan Sharptalon
.use 16305
step
.goto Ashenvale,76.15,67.60,15,0
.goto Ashenvale,76.03,69.02,15,0
.goto Ashenvale,76.25,70.62,15,0
.goto Ashenvale,75.76,71.61,15,0
.goto Ashenvale,75.57,70.33,15,0
.goto Ashenvale,75.20,70.62,15,0
.goto Ashenvale,74.37,69.31,15,0
.goto Ashenvale,73.61,70.91,15,0
.goto Ashenvale,72.96,70.34,15,0
.goto Ashenvale,72.66,69.46,15,0
.goto Ashenvale,72.09,70.17,15,0
.goto Ashenvale,71.07,72.60,15,0
.goto Ashenvale,71.92,73.64,15,0
.goto Ashenvale,72.53,72.58,15,0
.goto Ashenvale,72.32,74.64,15,0
.goto Ashenvale,73.36,74.43,15,0
.goto Ashenvale,73.85,75.03,15,0
.goto Ashenvale,76.15,67.60
>>Kill |cFFFF5722Ashenvale Outrunners|r
>>|cFFFCDC00They are stealthed|r
.complete 6503,1 
.mob Ashenvale Outrunner
step
.goto Ashenvale,78.24,65.72,45,0
.goto Ashenvale,77.93,65.93,45,0
.goto Ashenvale,77.60,66.33,45,0
.goto Ashenvale,77.35,66.96,45,0
.goto Ashenvale,76.93,68.04,45,0
.goto Ashenvale,76.11,68.95,45,0
.goto Ashenvale,75.94,69.80,45,0
.goto Ashenvale,75.26,69.96,45,0
.goto Ashenvale,74.86,70.06,45,0
.goto Ashenvale,74.36,70.10,45,0
.goto Ashenvale,73.33,70.61,45,0
.goto Ashenvale,72.94,70.67,45,0
.goto Ashenvale,72.50,70.60,45,0
.goto Ashenvale,72.08,70.47,45,0
.goto Ashenvale,71.46,70.10,45,0
.goto Ashenvale,78.24,65.72
.line Ashenvale,71.46,70.10,72.08,70.47,72.50,70.60,72.94,70.67,73.33,70.61,74.36,70.10,74.86,70.06,75.26,69.96,75.94,69.80,76.11,68.95,76.93,68.04,77.35,66.96,77.60,66.33,77.93,65.93,78.24,65.72
>>Kill |cFFFF5722Sharptalon|r. Loot him for |T136063:0|t[|cFF00BCD4Sharptalon's Claw|r] and use it to start the quest
>>|cFFFCDC00Be careful!|r |cFFFF5722Sharptalon|r |cFFFCDC00is level 31 and patrols around. You can kite him back to Splintertree Post or the Forsaken Camp if you're struggling to kill him. If you do this, make sure you do 50%+ damage to get credit. You can also do this quest later|r
.collect 16305,1,2 
.accept 2 >> Accept Sharptalon's Claw
.unitscan Sharptalon
.use 16305
step
.goto Ashenvale,68.34,75.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Torek|r to start the escort
>>|cFF00FF25Torek|r |cFFFCDC00has a 5 minute respawn time|r
.accept 6544 >> Accept Torek's Assault
.target Torek
step
.goto Ashenvale,66.08,74.50,60,0
.goto Ashenvale,65.07,75.36,20,0
.goto Ashenvale,64.28,75.33,10,0
.goto Ashenvale,64.81,75.34
>>Follow |cFF00FF25Torek|r
>>Let |cFF00FF25Torek|r and his |cFF00FF25Splintertree Raiders|r tank the |cFFFF5722Silverwing Warriors|r and |cFFFF5722Silverwing Sentinels|r
>>When you clear the building, run toward the Balcony. When |cFFFF5722Duriel Moonfire|r comes, let |cFF00FF25Torek|r and his |cFF00FF25Splintertree Raiders|r take aggro before you deal damage
.complete 6544,1 
.mob Silverwing Warrior
.mob Silverwing Sentinel
.unitscan Duriel Moonfire
step
#completewith Tideress
.goto Ashenvale,51.51,71.02,100 >> Travel to Mystral Lake
.isOnQuest 25
step
#completewith Tideress
>>Kill |cFFFF5722Befouled Water Elementals|r
.complete 25,1 
.mob Befouled Water Elemental
step
#completewith next
.line Ashenvale,45.84,70.67,46.07,70.83,46.53,70.80,46.72,70.63,47.22,70.44,47.57,70.42,47.79,69.90,48.04,69.67,48.71,69.54,48.36,69.74,48.43,70.14,48.93,70.82,49.49,70.76,50.21,70.36,50.47,70.43,50.54,71.08,50.74,71.31,51.42,70.86,51.75,70.86,52.13,71.14,52.18,71.60,52.08,72.10
.goto Ashenvale,52.08,72.10,40,0
.goto Ashenvale,52.18,71.60,40,0
.goto Ashenvale,52.13,71.14,40,0
.goto Ashenvale,51.42,70.86,40,0
.goto Ashenvale,50.74,71.31,40,0
.goto Ashenvale,50.54,71.08,40,0
.goto Ashenvale,50.47,70.43,40,0
.goto Ashenvale,50.21,70.36,40,0
.goto Ashenvale,49.49,70.76,40,0
.goto Ashenvale,48.93,70.82,40,0
.goto Ashenvale,48.43,70.14,40,0
.goto Ashenvale,48.36,69.74,40,0
>>Kill |cFFFF5722Tideress|r. Loot her for the |T136222:0|t[|cFF00BCD4Befouled Water Globe|r]. Use it to start the quest
>>|cFFFF5722Tideress|r patrols around the island and underwater
.collect 16408,1,1918,1 
.accept 1918 >>Accept The Befouled Element
.use 16408
.unitscan Tideress
step
.goto Ashenvale,48.93,69.56
>>Go under the Gazebo
.complete 25,2 
step
#label Tideress
.line Ashenvale,45.84,70.67,46.07,70.83,46.53,70.80,46.72,70.63,47.22,70.44,47.57,70.42,47.79,69.90,48.04,69.67,48.71,69.54,48.36,69.74,48.43,70.14,48.93,70.82,49.49,70.76,50.21,70.36,50.47,70.43,50.54,71.08,50.74,71.31,51.42,70.86,51.75,70.86,52.13,71.14,52.18,71.60,52.08,72.10
.goto Ashenvale,48.71,69.54,40,0
.goto Ashenvale,48.04,69.67,40,0
.goto Ashenvale,47.79,69.90,40,0
.goto Ashenvale,47.57,70.42,40,0
.goto Ashenvale,47.22,70.44,40,0
.goto Ashenvale,46.72,70.63,40,0
.goto Ashenvale,46.53,70.80,40,0
.goto Ashenvale,46.07,70.83,40,0
.goto Ashenvale,45.84,70.67,40,0
.goto Ashenvale,45.84,70.67
>>Kill |cFFFF5722Tideress|r. Loot her for the |T136222:0|t[|cFF00BCD4Befouled Water Globe|r]. Use it to start the quest
>>|cFFFF5722Tideress|r patrols around the island and underwater
.collect 16408,1,1918,1 
.accept 1918 >>Accept The Befouled Element
.use 16408
.unitscan Tideress
step
.loop 25,Ashenvale,48.36,69.74,48.43,70.14,48.93,70.82,49.49,70.76,50.21,70.36,50.47,70.43,50.54,71.08,50.74,71.31,51.42,70.86,52.13,71.14,52.18,71.60,52.08,72.10,45.84,70.67,48.36,69.74
>>Kill |cFFFF5722Befouled Water Elementals|r
.complete 25,1 
.mob Befouled Water Elemental
step
.line Ashenvale,39.81,62.94,39.65,63.74,39.77,65.40,40.22,66.23,41.41,66.56,41.46,67.44,41.55,67.71,41.79,68.28,42.08,68.71,42.46,68.39,42.96,68.43,43.33,68.09,43.78,68.86
.goto Ashenvale,43.78,68.86,40,0
.goto Ashenvale,43.33,68.09,40,0
.goto Ashenvale,42.46,68.39,40,0
.goto Ashenvale,42.08,68.71,40,0
.goto Ashenvale,41.79,68.28,40,0
.goto Ashenvale,41.55,67.71,40,0
.goto Ashenvale,41.46,67.44,40,0
.goto Ashenvale,41.41,66.56,40,0
.goto Ashenvale,40.22,66.23,40,0
.goto Ashenvale,39.77,65.40,40,0
.goto Ashenvale,39.65,63.74,40,0
.goto Ashenvale,39.81,62.94,40,0
>>Kill |cFFFF5722Ursangous|r. Loot him for |T132941:0|t[|cFF00BCD4Ursangous's Paw|r] and use it to start the quest
>>He patrols around slightly
.collect 16303,1,23 
.accept 23 >> Accept Ursangous's Paw
.unitscan Ursangous
.use 16303
step << Shaman
.goto Ashenvale,33.55,67.47
>>Use the |T132821:0|t[Empty Blue Waterskin] under the Gazebo
.complete 1534,1 
.use 7767
step
.goto Ashenvale,36.81,33.48,200 >> Travel to Thistlefur Village
>>|cRXP_WARN_Make sure to avoid Astranaar guards en route|r
.isOnQuest 216
step
#completewith next
>>Kill |cFFFF5722Thistlefur Shamans|r and |cFFFF5722Thistlefur Avengers|r en route to the cave
.complete 216,2 
.complete 216,1 
.mob Thistlefur Shaman
.mob Thistlefur Avenger
step
#label EntertheHold
.goto Ashenvale,38.67,30.62,40 >>Enter Thistlefur Hold
.isOnQuest 6462
step
.goto Ashenvale,40.39,33.22,20,0
.goto Ashenvale,40.77,32.81,20,0
.goto Ashenvale,41.36,32.19,20,0
.goto Ashenvale,41.75,32.94,20,0
.goto Ashenvale,41.77,33.68,20,0
.goto Ashenvale,42.37,33.61,20,0
.goto Ashenvale,42.82,34.11,20,0
.goto Ashenvale,41.73,34.47,20,0
.goto Ashenvale,41.66,35.70,20,0
.goto Ashenvale,40.39,33.22
>>Loot the |cFFDB2EEFTroll Chests|r on the ground for |cFF00BCD4Troll Charms|r
.complete 6462,1 
step
.goto Ashenvale,41.49,34.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ruul|r in the back of the cave. This will start an escort
.accept 6482 >> Accept Freedom to Ruul
.target Ruul Snowhoof
step
.goto Ashenvale,40.68,33.21,20,0
.goto Ashenvale,40.29,32.25,20,0
.goto Ashenvale,39.41,31.00,20,0
.goto Ashenvale,38.28,30.68,20,0
.goto Ashenvale,37.39,32.74,30,0
.goto Ashenvale,37.30,34.49,30,0
.goto Ashenvale,38.73,36.86
.complete 6482,1 
>>|cFFFCDC00Be careful! 3|r |cFFFF5722Thistlefurs|r |cFFFCDC00will spawn once you are halfway through the cave and another 3 outside the gate of Thistlefur Village|r
.target Ruul Snowhoof
step
.goto Ashenvale,37.91,34.49,40,0
.goto Ashenvale,35.89,36.65,40,0
.goto Ashenvale,35.75,32.01,40,0
.goto Ashenvale,34.09,38.48,40,0
.goto Ashenvale,31.86,39.25,40,0
.goto Ashenvale,32.57,42.78,40,0
.goto Ashenvale,30.98,44.40,40,0
.goto Ashenvale,35.75,32.01
>>Finish killing |cFFFF5722Thistlefur Shamans|r and |cFFFF5722Thistlefur Avengers|r
.complete 216,2 
.complete 216,1 
.mob Thistlefur Shaman
.mob Thistlefur Avenger
step
#completewith next
.goto Ashenvale,58.03,55.87,100 >> Travel east toward Raynewood Retreat
.isOnQuest 5867
step
#completewith next
.line Ashenvale,62.39,49.80,61.99,49.81,61.30,50.03,61.03,50.43,61.01,51.09,60.94,51.53,60.49,52.41,59.83,53.40,59.55,53.71,59.26,54.25,59.10,54.76,58.80,55.24,58.17,55.57,57.91,55.90,57.54,56.03,56.93,56.06,56.37,55.90,56.16,55.46,55.62,55.41,54.80,55.09,54.06,54.91,53.01,54.54,52.68,54.42,52.24,54.38
.goto Ashenvale,52.24,54.38,40,0
.goto Ashenvale,52.68,54.42,40,0
.goto Ashenvale,54.06,54.91,40,0
.goto Ashenvale,53.01,54.54,40,0
.goto Ashenvale,54.80,55.09,40,0
.goto Ashenvale,55.62,55.41,40,0
.goto Ashenvale,56.16,55.46,40,0
.goto Ashenvale,56.37,55.90,40,0
.goto Ashenvale,57.54,56.03,40,0
.goto Ashenvale,56.93,56.06,40,0
.goto Ashenvale,57.91,55.90,40,0
.goto Ashenvale,58.17,55.57,40,0
.goto Ashenvale,58.80,55.24,40,0
.goto Ashenvale,59.10,54.76,40,0
.goto Ashenvale,59.26,54.25,40,0
.goto Ashenvale,59.55,53.71,40,0
.goto Ashenvale,59.83,53.40,40,0
.goto Ashenvale,60.49,52.41,40,0
.goto Ashenvale,60.94,51.53,40,0
>>Kill |cFFFF5722Shadumbra|r. Loot her for |T132225:0|t[|cFF00BCD4Shadumbra's Head|r] and use it to start the quest
>>|cFFFF5722Shadumbra|r patrols around slightly
.collect 16304,1,24 
.accept 24 >> Accept Shadumbra's Head
.unitscan Shadumbra
.use 16304
step
.goto Ashenvale,58.08,56.06,40,0
.goto Ashenvale,58.69,55.18,40,0
.goto Ashenvale,59.27,54.47,40,0
.goto Ashenvale,59.83,53.26,40,0
.goto Ashenvale,60.40,52.83,40,0
.goto Ashenvale,61.03,51.96,40,0
.goto Ashenvale,60.99,49.19,40,0
.goto Ashenvale,62.51,50.16,40,0
.goto Ashenvale,58.08,56.06
>>Kill |cFFFF5722Laughing Sisters|r. Loot them for an |T134776:0|t[|cFF00BCD4Etched Phial|r]
.collect 5867,1,1195,1 
.mob Laughing Sister
step
#label Shadumbra
.line Ashenvale,62.39,49.80,61.99,49.81,61.30,50.03,61.03,50.43,61.01,51.09,60.94,51.53,60.49,52.41,59.83,53.40,59.55,53.71,59.26,54.25,59.10,54.76,58.80,55.24,58.17,55.57,57.91,55.90,57.54,56.03,56.93,56.06,56.37,55.90,56.16,55.46,55.62,55.41,54.80,55.09,54.06,54.91,53.01,54.54,52.68,54.42,52.24,54.38
.goto Ashenvale,60.94,51.53,40,0
.goto Ashenvale,60.49,52.41,40,0
.goto Ashenvale,59.83,53.40,40,0
.goto Ashenvale,59.55,53.71,40,0
.goto Ashenvale,59.26,54.25,40,0
.goto Ashenvale,59.10,54.76,40,0
.goto Ashenvale,58.80,55.24,40,0
.goto Ashenvale,58.17,55.57,40,0
.goto Ashenvale,57.91,55.90,40,0
.goto Ashenvale,57.54,56.03,40,0
.goto Ashenvale,56.93,56.06,40,0
.goto Ashenvale,56.37,55.90,40,0
.goto Ashenvale,56.16,55.46,40,0
.goto Ashenvale,55.62,55.41,40,0
.goto Ashenvale,54.80,55.09,40,0
.goto Ashenvale,54.06,54.91,40,0
.goto Ashenvale,53.01,54.54,40,0
.goto Ashenvale,52.68,54.42,40,0
.goto Ashenvale,52.24,54.38,40,0
.goto Ashenvale,62.39,49.80
>>Kill |cFFFF5722Shadumbra|r. Loot her for |T132225:0|t[|cFF00BCD4Shadumbra's Head|r] and use it to start the quest
>>|cFFFF5722Shadumbra|r patrols around slightly
.collect 16304,1,24 
.accept 24 >> Accept Shadumbra's Head
.unitscan Shadumbra
.use 16304
step
.goto Ashenvale,62.07,51.32
>>Kill |cFFFF5722Keeper Ordanus|r. Loot him for his |cFF00BCD4Head|r
>>|cFFFCDC00Be careful! He has two|r |cFFFF5722Cenarion Vindicators|r |cFFFCDC00defending him|r
>>|cFFFCDC00He will summon two|r |cFFFF5722Treants|r |cFFFCDC00when he is below 30% health|r
.complete 1088,1 
.target Keeper Ordanus
.group 2
step
#completewith next
.goto Ashenvale,63.34,44.14,40,0
.goto Ashenvale,65.32,44.22,40,0
.goto Ashenvale,66.56,51.77,80 >> Travel toward Night Run
step
.loop 25,Ashenvale,66.78,51.71,66.19,53.44,66.17,54.40,66.22,55.27,66.20,56.37,66.77,57.14,67.11,56.39,67.35,55.53,67.92,54.42,68.92,53.44,68.63,52.69,67.85,51.34
>>Kill |cFFFF5722Felmusk Shadowstalkers|r, |cFFFF5722Felmusk Satyrs|r, and |cFFFF5722Felmusk Felsworns|r. Loot them for their |cFF00BCD4Satyr Horns|r
>>|cFFFCDC00Be careful! All the Felmusk cast|r |T136119:0|t[Overwhelming Stench]|cFFFCDC00, an instant-cast 6 second silence|r << Mage/Warlock/Priest/Druid/Shaman
.complete 6441,1 
.mob Felmusk Shadowstalker
.mob Felmusk Felsworn
.mob Felmusk Satyr
step
.goto Ashenvale,60.20,72.90
>>Use the |T134776:0|t[|cFF00BCD4Etched Phial|r] in the Moonwell
.complete 1195,1 
.use 5867
step
.goto Ashenvale,71.10,68.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kuray'bin|r
.turnin 6503 >> Turn in Ashenvale Outrunners
.target Kuray'bin
step
.goto Ashenvale,78.24,65.72,45,0
.goto Ashenvale,77.93,65.93,45,0
.goto Ashenvale,77.60,66.33,45,0
.goto Ashenvale,77.35,66.96,45,0
.goto Ashenvale,76.93,68.04,45,0
.goto Ashenvale,76.11,68.95,45,0
.goto Ashenvale,75.94,69.80,45,0
.goto Ashenvale,75.26,69.96,45,0
.goto Ashenvale,74.86,70.06,45,0
.goto Ashenvale,74.36,70.10,45,0
.goto Ashenvale,73.33,70.61,45,0
.goto Ashenvale,72.94,70.67,45,0
.goto Ashenvale,72.50,70.60,45,0
.goto Ashenvale,72.08,70.47,45,0
.goto Ashenvale,71.46,70.10,45,0
.goto Ashenvale,78.24,65.72
.line Ashenvale,71.46,70.10,72.08,70.47,72.50,70.60,72.94,70.67,73.33,70.61,74.36,70.10,74.86,70.06,75.26,69.96,75.94,69.80,76.11,68.95,76.93,68.04,77.35,66.96,77.60,66.33,77.93,65.93,78.24,65.72
>>Kill |cFFFF5722Sharptalon|r. Loot him for |T136063:0|t[|cFF00BCD4Sharptalon's Claw|r] and use it to start the quest
>>|cFFFCDC00Be careful!|r |cFFFF5722Sharptalon|r |cFFFCDC00is level 31 and patrols around. You can kite him back to Splintertree Post or the Forsaken Camp if you're struggling to kill him. If you do this, make sure you do 50%+ damage to get credit. You can also do this quest later|r
.collect 16305,1,2 
.accept 2 >> Accept Sharptalon's Claw
.unitscan Sharptalon
.use 16305
step
#sticky
#completewith EnterBFD
.subzone 719 >> Now you should be looking for a group to BlackFathom Deeps
.dungeon BFD
step
.goto Ashenvale,73.04,62.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ertog|r
.turnin 6544 >> Turn in Torek's Assault
.target Ertog Ragetusk
.isQuestComplete 6544
step
.goto Ashenvale,73.78,61.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Senani|r
.turnin 2 >> Turn in Sharptalon's Claw
.turnin 24 >> Turn in Shadumbra's Head
.turnin 23 >> Turn in Ursangous's Paw
.turnin 247 >> Turn in The Hunt Completed
.target Senani Thunderheart
.isOnQuest 2
step
.goto Ashenvale,73.78,61.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Senani|r
.turnin 24 >> Turn in Shadumbra's Head
.turnin 23 >> Turn in Ursangous's Paw
.target Senani Thunderheart
step
.goto Ashenvale,73.06,61.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Pixel|r
.turnin 6441 >> Turn in Satyr Horns
.target Pixel
step
.goto Ashenvale,73.67,60.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Mastok|r
.turnin 25 >> Turn in Stonetalon Standstill
.turnin 1918 >> Turn in The Befouled Element
.accept 824 >> Accept Je'neu of the Earthen Ring
.target Mastok Wrilehiss
step
.goto Ashenvale,74.11,60.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yama|r
.turnin 6482 >> Turn in Freedom to Ruul
.target Yama Snowhoof
step
.goto Ashenvale,73.18,61.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Vhulgra|r
.fly Zoram'gar >> Fly to Zoram'gar Outpost
.target Vhulgra
step
.goto Ashenvale,11.90,34.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karang|r
.turnin 216 >> Turn in Between a Rock and a Thistlefur
.target Karang Amakkar
step
.goto Ashenvale,11.65,34.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mitsuwa|r
.turnin 6462 >> Turn in Troll Charm
.target Mitsuwa
step
.goto Ashenvale,11.56,34.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Je'neu Sancrea|r
.turnin 824 >> Turn in Je'neu of the Earthen Ring
.accept 6563 >> Accept The Essence of Aku'Mai
.accept 6921 >> Accept Amongst The Ruins
.accept 6565 >> Accept Allegiance to the Old Gods
.target Je'neu Sancrea
.dungeon BFD
.isQuestTurnedIn 6564
step
.goto Ashenvale,11.56,34.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Je'neu Sancrea|r
.turnin 824 >> Turn in Je'neu of the Earthen Ring
.accept 6563 >> Accept The Essence of Aku'Mai
.accept 6921 >> Accept Amongst The Ruins
.target Je'neu Sancrea
.dungeon BFD
step
.goto Ashenvale,11.56,34.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Je'neu Sancrea|r
.turnin 824 >> Turn in Je'neu of the Earthen Ring
.target Je'neu Sancrea
step
.goto Ashenvale,12.06,34.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Muglash|r
>>|cRXP_WARN_This will start an escort quest|r
.accept 6641 >> Accept Vorsha the Lasher
.target Muglash
step
.goto Ashenvale,9.63,27.63
>>Click the |cRXP_PICK_Brazier|r when you get there
.complete 6641,1 
.mob Vorsha the Lasher
step
.goto Kalimdor,43.89,35.23,100 >> Travel to the entrance of Blackfathom Deeps
.dungeon BFD
step
#completewith next
>>Loot |cFF00BCD4Sapphire of Aku'Mai|r from the wall
.complete 6563,1 
.dungeon BFD
.isOnQuest 6563
step
.goto Kalimdor,43.81,35.16,20,0
.goto Kalimdor,43.94,34.86,20,0
.goto Kalimdor,43.90,34.59,20,0
.goto Kalimdor,44.00,34.57,20,0
.goto Kalimdor,44.16,34.85,20,0
.goto Kalimdor,44.35,34.97,20,0
.goto Kalimdor,44.53,34.86,20,0
.goto Kalimdor,43.94,34.86
>>Kill |cFFFF5722Blackfathom Tide Priestesses|r. Loot them for a |T134332:0|t[|cFF00BCD4Damp Note|r] and use it to start the quest
.collect 16790,1,6564 
.accept 6564 >> Accept Allegiance to the Old Gods
.mob Blackfathom Tide Priestess
.use 16790
.dungeon BFD
step
.goto Kalimdor,44.53,34.86,20,0
.goto Kalimdor,44.35,34.97,20,0
.goto Kalimdor,44.16,34.85,20,0
.goto Kalimdor,44.00,34.57,20,0
.goto Kalimdor,43.90,34.59,20,0
.goto Kalimdor,43.94,34.86,20,0
.goto Kalimdor,43.81,35.16,20,0
.goto Kalimdor,44.34,35.11
>>Loot |cFF00BCD4Sapphire of Aku'Mai|r from the wall
.complete 6563,1 
.dungeon BFD
.isOnQuest 6563
step
#label EnterBFD
.goto Kalimdor,44.36,34.86
.zone 221 >> Enter the BFD Instance portal. Zone in
.dungeon BFD
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Argent Guard Thaelrid|r
.accept 6561 >>Accept Blackfathom Villainy
.target Argent Guard Thaelrid
.dungeon BFD
step
>>Kill |cRXP_ENEMY_Lorguss Jett |r
.complete 6565,1 
.mob Lorguss Jett
.isOnQuest 6565
.dungeon BFD
step
#completewith next
>>Loot the |cFFDB2EEFFathom Stone|r in the water on the ground for the |cFF00BCD4Fathom Core|r
>>|cFFFCDC00Looting this will spawn|r |cFFFF5722Baron Aquanis|r
.complete 6921,1 
.isOnQuest 6921
.dungeon BFD
step
>>Kill |cFFFF5722Baron Aquanis|r. Loot him for a |T136222:0|t[|cFF00BCD4Strange Water Globe|r]. Use it to accept the quest
.collect 16782,1 
.accept 6922 >>Accept Baron Aquanis
.mob Baron Aquanis
.use 16782
.dungeon BFD
step
>>Loot the |cFFDB2EEFFathom Stone|r in the water on the ground for the |cFF00BCD4Fathom Core|r
.complete 6921,1 
.isOnQuest 6921
.dungeon BFD
step
>>Kill |cRXP_ENEMY_Twilight Lord Kelris|r. Loot him for his |cRXP_LOOT_Head|r
.complete 6561,1 
.mob Twilight Lord Kelris
.isOnQuest 6561
.dungeon BFD
step
#completewith next
.hs >> Hearth to Splintertree Post
.use 6948
>>|cFFFCDC00Kill|r |cFFFF5722Aku'mai|r |cFFFCDC00first if you wish. This is the last boss of the dungeon|r
.dungeon BFD
step
.goto Ashenvale,73.18,61.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Vhulgra|r
.fly Zoram'gar >> Fly to Zoram'gar Outpost
.target Vhulgra
.dungeon BFD
step
.goto Ashenvale,12.22,34.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Warsong Runner|r
.turnin 6641 >> Turn in Vorsha the Lasher
.target Warsong Runner
step
.goto Ashenvale,11.56,34.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Je'neu Sancrea|r
.turnin 6564 >>Turn in Allegiance to the Old Gods
.target Je'neu Sancrea
.dungeon BFD
.isOnQuest 6564
step
.goto Ashenvale,11.56,34.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Je'neu Sancrea|r
.turnin 6565 >>Turn in Allegiance to the Old Gods
.target Je'neu Sancrea
.dungeon BFD
.isQuestComplete 6565
step
.goto Ashenvale,11.56,34.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Je'neu Sancrea|r
.turnin 6563 >>Turn in The Essence of Aku'Mai
.target Je'neu Sancrea
.dungeon BFD
.isQuestComplete 6563
step
.goto Ashenvale,11.56,34.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Je'neu Sancrea|r
.turnin 6921 >>Turn in Amongst The Ruins
.target Je'neu Sancrea
.dungeon BFD
.isQuestComplete 6521
step
.goto Ashenvale,11.56,34.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Je'neu Sancrea|r
.turnin 6922 >>Turn in Baron Aquanis
.target Je'neu Sancrea
.dungeon BFD
.isQuestComplete 6922
step
.goto Ashenvale,12.24,33.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Andruk|r
.fly Thunder Bluff >> Fly to Thunder Bluff
.target Andruk
.cooldown item,6948,<0
step
.hs >>Hearth to Splintertree Post
.goto Ashenvale,74.00,60.64,30 >> Arrive in Splintertree Post
.use 6948
.cooldown item,6948,>0

step
.goto Ashenvale,73.18,61.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Vhulgra|r
.fly Thunder Bluff >> Fly to Thunder Bluff
.target Vhulgra
.zoneskip 431,1
step
.goto Thunder Bluff,71.04,34.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bashana|r
.turnin 6561 >>Turn in Blackfathom Villainy
.target Bashana Runetotem
.isQuestComplete 6561
.dungeon BFD
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 29-32 Thousand Needles
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 20-30
#next 32-35 Hillsbrad/Arathi
step << Shaman/Warrior
.goto Thunder Bluff,54.06,57.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Delgo|r|cRXP_BUY_. Buy a|r |T132408:0|t[Merciless Axe] |cRXP_BUY_from him if it's available and you didn't get it in Hillsbrad|r
.collect 12249,1,5881,1 
.money <3.0195
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<21.0
.target Delgo Ragetotem
step << Rogue
.goto Thunder Bluff,53.00,56.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kard|r|cRXP_BUY_. Buy a|r |T135651:0|t[Main Gauche] |cRXP_BUY_from him for your off-hand|r
.collect 2526,1,5881,1 
.money <2.0353
.target Kard Ragetotem
.itemStat 17,QUALITY,<7
.itemStat 17,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<16.5
step << Rogue
#completewith TearMoons
+Equip the |T135651:0|t[Main Gauche]
.use 2526
.itemcount 2526,1
.itemStat 17,QUALITY,<7
.itemStat 17,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<16.5
step
.goto Thunder Bluff,54.90,51.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zangen|r
.turnin 1195 >> Turn in The Sacred Flame
.accept 1196 >> Accept The Sacred Flame
.target Zangen Stonehoof
step << Druid
.goto Thunder Bluff,76.79,31.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kym|r
.train 3029 >> Train your class spells
.target Kym Wildmane
.xp <28,1
.xp >30,1
step << Druid
.goto Thunder Bluff,76.79,31.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kym|r
.train 783 >> Train your class spells
.target Kym Wildmane
.xp <30,1
step
.goto Thunder Bluff,61.53,80.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Melor|r
.accept 1131 >>Accept Steelsnap
.target Melor Stonehoof
step << Hunter
.goto Thunder Bluff,59.13,86.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 14319 >> Train your class spells
.target Urek Thunderhorn
.xp <28,1
.xp >30,1
step << Hunter
.goto Thunder Bluff,59.13,86.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 5384 >> Train your class spells
.target Urek Thunderhorn
.xp <30,1
step << Hunter
.goto Thunder Bluff,54.07,84.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hesuwa|r
.train 24559 >> Train your pet spells
.target Hesuwa Thunderhorn
.xp <30,1
step << Warrior
.goto Thunder Bluff,57.59,85.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ker|r
.train 7887 >> Train your class spells
.target Ker Ragetotem
.xp <28,1
.xp >30,1
step << Warrior
.goto Thunder Bluff,57.27,87.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torm|r
.train 7369 >> Train your class spells
.accept 1718 >>Accept The Islander
.target Torm Ragetotem
.xp <30,1
step
.goto Thunder Bluff,45.83,64.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Pala|r
.home >>Set your Hearthstone to Thunder Bluff
.target Innkeeper Pala
step
.goto Thunder Bluff,22.81,20.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Apothecary Zamah|r
.turnin 1086 >> Turn in The Flying Machine Airport
.target Apothecary Zamah
.isOnQuest 1086
step << Priest
.goto Thunder Bluff,25.31,15.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Miles|r
.train 8104 >> Train your class spells
.target Miles Welsh
.xp <28,1
.xp >30,1
step << Priest
.goto Thunder Bluff,25.31,15.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Miles|r
.train 602 >> Train your class spells
.target Miles Welsh
.xp <30,1
step << Mage
.goto Thunder Bluff,22.74,14.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shymm|r
.train 759 >> Train your class spells
.target Archmage Shymm
.xp <28,1
.xp >30,1
step << Mage
.goto Thunder Bluff,22.74,14.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shymm|r
.train 8412 >> Train your class spells
.target Archmage Shymm
.xp <30,1
step << Mage
.goto Thunder Bluff,22.48,16.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Birgitte|r
.train 3566 >> Train |T135765:0|t[Teleport: Thunder Bluff]
.target Birgitte Cranston
.xp <30,1
step << Shaman
.goto Thunder Bluff,23.64,18.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 8053 >> Train your class spells
.target Tigor Skychaser
.xp <28,1
.xp >30,1
step << Shaman
.goto Thunder Bluff,23.64,18.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 556 >> Train your class spells
.target Tigor Skychaser
.xp <30,1
step
#completewith next
.skill firstaid,150 >> Create |T133687:0|t[Heavy Wool Bandages] until your skill is 150
.skill firstaid,<1,1
step
.goto Thunder Bluff,29.68,21.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pand|r
.train 7928 >> Train |T133671:0|t[Silk Bandage]
>>|cFFFCDC00Skip this step if you did not have enough Wool Cloth to reach 150 skill|r
.target Pand Stonebinder
.skill firstaid,<1,1
step << Hunter
.goto Thunder Bluff,46.98,45.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kuna|r|cRXP_BUY_. Buy a|r |T135495:0|t[Sturdy Recurve Bow] |cRXP_BUY_from her if it's available|r
.collect 11306,1,5881,1 
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<12.9
.target Kuna Thunderhorn
step
.goto Thunder Bluff,46.98,45.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kuna|r
.collect 3030,1800,5881,1 << Hunter 
.target Kuna Thunderhorn
step
.abandon 6561 >> Abandon Blackfathom Villainy
.isOnQuest 6561
.dungeon BFD
step
.abandon 6565 >> Abandon Allegiance to the Old Gods
.isOnQuest 6565
.dungeon BFD
step
.abandon 6563 >> Abandon The Essence of Aku'Mai
.isOnQuest 6563
.dungeon BFD
step
.abandon 6921 >> Abandon Amongst the Ruins
.isOnQuest 6921
.dungeon BFD
step
#completewith next
.goto Thunder Bluff,47.00,49.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tal|r
.fly Camp Taurajo >>Fly to Camp Taurajo
.target Tal
.zoneskip The Barrens
step
.goto The Barrens,45.10,57.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tatternack|r
.accept 1153 >> Accept A New Ore Sample
.target Tatternack Steelforge
step << Shaman
#completewith next
.goto The Barrens,43.84,77.28,25,0
.goto The Barrens,43.62,77.29,25,0
.goto The Barrens,43.42,77.41,15 >>Travel toward |cRXP_FRIENDLY_Brine|r
step << Shaman
.goto The Barrens,43.42,77.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brine|r
.turnin 1534 >>Turn in Call of Water
.accept 220 >>Accept Call of Water
.target Brine
step
#completewith next
.goto The Barrens,48.85,84.88,50 >> Travel to Bael Modan
.group
step
.goto The Barrens,48.94,86.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Feegly|r
.accept 857 >> Accept The Tear of the Moons
.target Feegly the Exiled
.group
step
#completewith next
.goto The Barrens,49.01,84.48,8,0
.goto The Barrens,49.06,84.59,8,0
.goto The Barrens,49.38,84.48,8,0
.goto The Barrens,49.53,84.42,8,0
.goto The Barrens,49.43,84.28,6 >>Go down to the bottom floor of Bael'dun
.group
step
.goto The Barrens,49.13,84.25
>>Open |cFFDB2EEFGeneral Twinbraid's Strongbox|r. Loot it for the |cFF00BCD4Tear of the Moons|r
>>|cFFFCDC00Be careful! It is very easy overpull in |cFFFF5722General Twinbraid|r's room|r
>>|cFFFCDC00Directly pull any mob other than |cFFFF5722General Twinbraid|r|r
.complete 857,1 
.group 3
step
#completewith next
.goto The Barrens,49.43,84.28,8,0
.goto The Barrens,49.53,84.42,8,0
.goto The Barrens,49.38,84.48,8,0
.goto The Barrens,49.06,84.59,8,0
.goto The Barrens,49.01,84.48,8,0
.goto The Barrens,48.75,84.63,20 >>Exit Bael'dun's Keep
.group
step
#label TearMoons
.goto The Barrens,48.94,86.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Feegly|r
.turnin 857 >> Turn in The Tear of the Moons
.target Feegly the Exiled
.group
step
#completewith next
.goto The Barrens,44.13,91.44,80 >> Travel south toward The Great Lift
step
.goto Thousand Needles,31.87,21.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grish|r
.turnin 5881 >> Turn in Calling in the Reserves
.target Grish Longrunner
.isOnQuest 5881
step
.goto Thousand Needles,32.24,22.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Moonhorn|r
.accept 4542 >> Accept Message to Freewind Post
.target Brave Moonhorn
step
.goto Thousand Needles,31.97,23.76,30 >> Take the lift down to Thousand Needles
>>|cFFFCDC00Don't fall off! You'll DIE!|r
.isOnQuest 4542
step
#completewith next
.goto Thousand Needles,38.46,32.60,0
.goto Thousand Needles,38.61,31.49,50,0
.line Thousand Needles,39.51,33.43,39.34,32.31,38.81,31.73,37.34,29.29,36.57,29.47,35.84,28.59,35.19,28.11,34.25,29.49,33.89,29.77,33.81,30.12,33.27,30.86,32.73,30.68,32.29,30.52,31.55,30.61,30.69,32.43,29.51,33.89,29.24,33.96,28.64,33.43,28.24,33.37,27.34,34.02,25.29,34.23,24.56,32.76,22.05,30.61,20.83,28.26,20.45,27.87,19.96,27.67,19.46,27.04,18.98,26.71,18.63,26.19,18.70,24.42,18.47,23.06,18.72,22.53,18.32,22.10,19.14,22.81,19.06,23.80,18.60,25.14
>>Kill the |cFFFF5722Galak Messenger|r. Loot him for the |T133473:0|t[|cFF00BCD4Assassination Note|r]. Use it to start the quest
>>|cFFFCDC00He spawns at Splithoof Crag (the eastern Centaur camp)|r
.collect 12564,1,4881 
.accept 4881 >>Accept Assassination Plot
.use 12564
.unitscan Galak Messenger
step
#completewith next
.goto Thousand Needles,46.73,48.27,30 >> Travel to Freewind Post's Elevators
step
.goto Thousand Needles,45.91,49.91,25 >> Take the Elevator up to Freewind
step
.goto Thousand Needles,45.70,50.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Longhorn|r
.turnin 4542 >> Turn in Message to Freewind Post
.accept 4841 >> Accept Pacify the Centaur
.target Cliffwatcher Longhorn
step
.goto Thousand Needles,46.00,50.80
>>Click on the |cRXP_FRIENDLY_Wanted Poster|r
.accept 5147 >> Accept Wanted - Arnak Grimtotem
step
.goto Thousand Needles,46.10,51.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rau|r
.turnin 1196 >> Turn in The Sacred Flame
.accept 1197 >> Accept The Sacred Flame
.target Rau Cliffrunner
.group
step
.goto Thousand Needles,46.10,51.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rau|r
.turnin 1196 >> Turn in The Sacred Flame
.target Rau Cliffrunner
step
.goto Thousand Needles,45.15,50.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Montarr|r
.vendor >> |cRXP_BUY_Buy|r |T134831:0|t[Healing Potions] |cRXP_BUY_and|r |T134937:0|t[Scrolls] |cRXP_BUY_from him if they're up|r
.target Montarr
step << Hunter
.goto Thousand Needles,44.89,50.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Starn|r
.vendor >>|cFF0E8312Buy a|r |T135495:0|t[Dense Shortbow] |cFF0E8312from him if it's up|r
.target Starn
.money <2.7172
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<14.2
step
.goto Thousand Needles,44.70,50.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hagar|r
.accept 4821 >> Accept Alien Egg
.target Hagar Lightninghoof
step
.goto Thousand Needles,44.90,48.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elu|r
.accept 4767 >> Accept Wind Rider
.target Elu
step
.goto Thousand Needles,45.14,49.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Nyse|r
.fp Freewind Post >> Get the Freewind Post flight path
.target Nyse
step
#completewith Clovenhoof
>>Kill |cFFFF5722Galak Scouts|r, |cFFFF5722Galak Wranglers|r, and |cFFFF5722Galak Windchasers|r
>>Kill every |cFFFF5722Galak Scout|r that you see
.complete 4841,1 
.complete 4841,2 
.complete 4841,3 
.mob Galak Scout
.mob Galak Wrangler
.mob Galak Windchaser
step
#label Splithoofcave
#completewith Clovenhoof
.goto Thousand Needles,44.12,37.22,20 >>Enter the cave
.group
step
#requires Splithoofcave
#completewith Clovenhoof
.goto Thousand Needles,44.44,36.32,12,0
.goto Thousand Needles,43.14,35.19,12,0
.goto Thousand Needles,42.11,34.54,12,0
.goto Thousand Needles,42.01,31.47,20 >>Travel toward the |cFFDB2EEFAncient Brazier|r
.group
step
#requires Splithoofcave
#label Clovenhoof
.goto Thousand Needles,42.01,31.47
>>Open the |cFFDB2EEFAncient Brazier|r. Loot it for the |cFF00BCD4Cloven Hoof|r
>>|cFFFCDC00Be careful! The brazier is defended by two level 30|r |cFFFF5722Galak Flame Guards|r
.complete 1197,1 
.mob Galak Flame Guard
.group 2
step
#completewith next
.goto Thousand Needles,38.46,32.60,0
.goto Thousand Needles,38.46,32.60,50,0
.line Thousand Needles,39.51,33.43,39.34,32.31,38.81,31.73,37.34,29.29,36.57,29.47,35.84,28.59,35.19,28.11,34.25,29.49,33.89,29.77,33.81,30.12,33.27,30.86,32.73,30.68,32.29,30.52,31.55,30.61,30.69,32.43,29.51,33.89,29.24,33.96,28.64,33.43,28.24,33.37,27.34,34.02,25.29,34.23,24.56,32.76,22.05,30.61,20.83,28.26,20.45,27.87,19.96,27.67,19.46,27.04,18.98,26.71,18.63,26.19,18.70,24.42,18.47,23.06,18.72,22.53,18.32,22.10,19.14,22.81,19.06,23.80,18.60,25.14
>>Kill the |cFFFF5722Galak Messenger|r. Loot him for the |T133473:0|t[|cFF00BCD4Assassination Note|r]. Use it to start the quest
>>|cFFFCDC00He spawns at Splithoof Crag (the eastern Centaur camp)|r
.collect 12564,1,4881 
.accept 4881 >>Accept Assassination Plot
.use 12564
.unitscan Galak Messenger
step
.loop 25,Thousand Needles,43.12,36.86,41.18,34.83,40.42,34.45,39.00,32.56,39.68,34.93,39.76,35.82,39.32,36.93,40.43,37.96,41.04,39.03,41.12,41.34,42.33,40.54,42.84,39.09,44.15,40.72,44.98,41.03,45.66,43.81,47.23,41.98,48.57,43.53,49.39,41.24,48.14,40.43,47.11,40.29,45.89,40.32,44.43,38.36,,43.12,36.86
>>Kill |cFFFF5722Galak Scouts|r, |cFFFF5722Galak Wranglers|r, and |cFFFF5722Galak Windchasers|r
.complete 4841,1 
.complete 4841,2 
.complete 4841,3 
.mob Galak Scout
.mob Galak Wrangler
.mob Galak Windchaser
step
#completewith next
>>Kill |cFFFF5722Gravelsnout Surveyors|r, |cFFFF5722Gravelsnout Diggers|r, and |cFFFF5722Gibblesnik|r (if he's up). Loot them for an |cFF00BCD4Ore Sample|r
.complete 1153,1 
.unitscan Gravelsnout Digger;Gravelsnout Surveyor;Gibblesnik
step
#completewith next
.goto Thousand Needles,54.57,44.36,12,0
.goto Thousand Needles,53.71,42.59,10,0
.goto Thousand Needles,53.95,41.49,10 >>Travel toward |cFF00FF25Dorn|r
step
.goto Thousand Needles,53.95,41.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Dorn|r
.accept 1149 >> Accept Test of Faith
.timer 7,Test of Faith RP
.target Dorn Plainstalker
step
.goto Thousand Needles,26.63,34.23
>>|cFFFCDC00Wait out the RP|r
>>|cFFFCDC00Jump off the end of the wooden platform. You'll get teleported instead of dying from fall damage|r
.complete 1149,1 
step
.goto Thousand Needles,53.95,41.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Dorn|r
.turnin 1149 >> Turn in Test of Faith
.accept 1150 >> Accept Test of Endurance
.target Dorn Plainstalker
.group
step
.goto Thousand Needles,53.95,41.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Dorn|r
.turnin 1149 >> Turn in Test of Faith
.target Dorn Plainstalker
step
#completewith next
.goto Thousand Needles,56.36,50.39,20,0
>>Loot the |cFF00BCD4Alien Egg|r on the ground
.complete 4821,1 
step
.line Thousand Needles,51.89,43.02,53.41,46.19,54.05,44.96
.line Thousand Needles,53.47,46.65,52.61,48.28,53.64,48.50,52.61,48.28,51.48,48.06
.line Thousand Needles,62.21,47.76,63.05,48.92,62.63,48.38,62.96,47.64,64.01,47.52,63.92,46.63,63.10,45.53
.line Thousand Needles,65.83,51.44,65.87,51.01,65.44,50.11,64.91,50.30,65.44,50.11,66.11,49.91,66.32,49.13
.line Thousand Needles,59.79,58.16,59.53,58.57,58.87,58.69,57.66,57.70,58.87,58.69,58.93,57.68,58.94,56.55,58.97,54.98,59.32,53.69,59.79,58.16
.goto Thousand Needles,51.89,43.02,40,0
.goto Thousand Needles,53.41,46.19,40,0
.goto Thousand Needles,54.05,44.96,40,0
.goto Thousand Needles,53.47,46.65,40,0
.goto Thousand Needles,52.61,48.28,40,0
.goto Thousand Needles,53.64,48.50,40,0
.goto Thousand Needles,51.48,48.06,40,0
.goto Thousand Needles,59.69,47.76,40,0
.goto Thousand Needles,62.21,47.76,40,0
.goto Thousand Needles,62.63,48.38,40,0
.goto Thousand Needles,64.01,47.52,40,0
.goto Thousand Needles,63.92,46.63,40,0
.goto Thousand Needles,63.10,45.53,40,0
.goto Thousand Needles,65.83,51.44,40,0
.goto Thousand Needles,65.44,50.11,40,0
.goto Thousand Needles,64.91,50.30,40,0
.goto Thousand Needles,66.11,49.91,40,0
.goto Thousand Needles,66.32,49.13,40,0
.goto Thousand Needles,59.79,58.16,40,0
.goto Thousand Needles,58.87,58.69,40,0
.goto Thousand Needles,57.66,57.70,40,0
.goto Thousand Needles,58.93,57.68,40,0
.goto Thousand Needles,58.94,56.55,40,0
.goto Thousand Needles,58.97,54.98,40,0
.goto Thousand Needles,59.32,53.69,40,0
.goto Thousand Needles,59.79,58.16
>>Kill |cFFFF5722Gravelsnout Surveyors|r, |cFFFF5722Gravelsnout Diggers|r, and |cFFFF5722Gibblesnik|r (if he's up). Loot them for an |cFF00BCD4Ore Sample|r
.complete 1153,1 
.unitscan Gravelsnout Digger;Gravelsnout Surveyor;Gibblesnik
step
.goto Thousand Needles,52.34,55.24,20,0
.goto Thousand Needles,37.63,56.11,20,0
.goto Thousand Needles,56.36,50.39,20,0
.goto Thousand Needles,52.34,55.24,20,0
.goto Thousand Needles,37.63,56.11,20,0
.goto Thousand Needles,56.36,50.39,20,0
.goto Thousand Needles,52.34,55.24,20,0
.goto Thousand Needles,37.63,56.11,20,0
.goto Thousand Needles,56.36,50.39,20,0
.goto Thousand Needles,52.34,55.24,20,0
.goto Thousand Needles,37.63,56.11,20,0
.goto Thousand Needles,56.36,50.39,20,0
.goto Thousand Needles,52.34,55.24,20,0
.goto Thousand Needles,37.63,56.11,20,0
.goto Thousand Needles,56.36,50.39
>>Loot the |cFF00BCD4Alien Egg|r on the ground
.complete 4821,1 
step
#completewith next
.goto Thousand Needles,46.73,48.27,30 >> Travel to Freewind Post's Elevators
step
.goto Thousand Needles,45.70,50.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Longhorn|r
.turnin 4841 >> Turn in Pacify the Centaur
.accept 5064 >> Accept Grimtotem Spying
.target Cliffwatcher Longhorn
step
.goto Thousand Needles,46.10,51.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rau|r
.turnin 1197 >> Turn in The Sacred Flame
.target Rau Cliffrunner
.group
.isQuestComplete 1197
step
.goto Thousand Needles,44.70,50.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hagar|r
.turnin 4821 >> Turn in Alien Egg
.accept 4865 >> Accept Serpent Wild
.target Hagar Lightninghoof
step << Hunter
.goto Thousand Needles,44.89,50.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Starn|r
.vendor >>|cFF0E8312Buy a|r |T135495:0|t[Dense Shortbow] |cFF0E8312from him if it's up|r
.target Starn
.money <2.7172
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<14.2
step << Hunter
.goto Thousand Needles,44.89,50.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Starn|r
>>|cFF0E8312Buy|r |T132382:0|t[Razor Arrows] |cFF0E8312from him|r
.collect 3030,1800,4767,1 
.target Starn
step
.goto Thousand Needles,45.15,50.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Montarr|r
.vendor >> |cRXP_BUY_Buy|r |T134831:0|t[Healing Potions] |cRXP_BUY_and|r |T134937:0|t[Scrolls] |cRXP_BUY_from him if they're up|r
.target Montarr
step
#label GrenkaCave
.goto Thousand Needles,27.59,49.86,12,0
.goto Thousand Needles,28.65,51.30,12,0
.goto Thousand Needles,27.29,51.30,12 >>Enter Roguefeather Den
.group
.isOnQuest 1150
step
#completewith Grenka
+|cFFFCDC00Be careful as |cFFFF5722Screeching Windcallers|r cast|r |T136022:0|t[Gust of Wind]|cFFFCDC00, a 4-second AoE stun within 10 yards of the |cFFFF5722Screeching Windcaller|r
+|cFFFF5722Screeching Harpies|r cast|r |T136122:0|t[Deafening Screech]|cFFFCDC00, an 8 second silence|r << Mage/Warlock/Priest/Druid/Shaman
.group
.isOnQuest 1150
step
#completewith next
.goto Thousand Needles,25.84,54.78
.cast 6478 >>Open the |cFFDB2EEFHarpy Foodstuffs|r on the ground in the back of the cave to summon |cFFFF5722Grenka|r
>>|cFFFCDC00Be careful, multiple packs of |cFFFF5722Harpies|r |cFFFCDC00will spawn one after another|r
.group
.isOnQuest 1150
step
.goto Thousand Needles,26.16,55.89,15,0
.goto Thousand Needles,26.69,55.62,15,0
.goto Thousand Needles,25.90,55.23
>>Kill |cFFFF5722Grenka Bloodscreech|r. Loot her for |cFF00BCD4Grenka's Claw|r
.complete 1150,1 
.mob Grenka Bloodscreech
.group 4
.isOnQuest 1150
step
#completewith next
.line Thousand Needles,14.34,30.13,15.08,31.63,15.67,31.56,16.59,30.34,17.19,29.60,17.82,27.50,18.48,26.74,18.64,25.90,18.68,24.68,18.57,24.07,18.11,23.65,17.66,22.98,17.24,22.32,17.54,21.49,17.87,20.78,17.96,20.18,17.66,19.46,17.28,18.93,16.70,18.61,16.20,18.53,15.69,18.65,14.49,20.04,12.89,19.97,11.88,20.90,11.50,21.61,11.20,22.29,11.16,23.21,11.49,24.07,11.55,24.44,11.91,25.02,13.01,26.31,13.36,26.97,13.75,28.54,14.34,30.13
>>Kill |cFFFF5722Steelsnap|r. Loot him for |cFF00BCD4Steelsnap's Rib|r
>>|cFFFCDC00Be careful, has two |cFFFF5722Hyenas|r |cFFFCDC00defending him!|r
.complete 1131,1 
.unitscan Steelsnap
step
#completewith next
.goto Thousand Needles,14.41,32.44,20,0
.goto Thousand Needles,14.04,32.37,12,0
.goto Thousand Needles,14.04,32.37,20 >>Travel toward Highperch
step
.goto Thousand Needles,11.31,33.07,50,0
.goto Thousand Needles,9.57,34.90,50,0
.goto Thousand Needles,10.68,40.95,50,0
.goto Thousand Needles,11.98,36.72,50,0
.goto Thousand Needles,13.91,39.11,50,0
.goto Thousand Needles,11.31,33.07,50,0
.goto Thousand Needles,9.57,34.90,50,0
.goto Thousand Needles,10.68,40.95,50,0
.goto Thousand Needles,11.98,36.72,50,0
.goto Thousand Needles,13.91,39.11,50,0
>>Loot |cFF00BCD4Highperch Wyvern Eggs|r on the ground
.complete 4767,1,6 
step
#completewith Paoka1
>>Loot |cFF00BCD4Highperch Wyvern Eggs|r on the ground
.complete 4767,1 
step
#completewith next
.goto Thousand Needles,13.18,39.55,15,0
.goto Thousand Needles,13.52,40.27,15,0
.goto Thousand Needles,14.01,40.27,15,0
.goto Thousand Needles,14.92,39.63,15,0
.goto Thousand Needles,16.46,41.09,25,0
.goto Thousand Needles,17.89,40.57,20 >>Run up the path. Travel toward |cFF00FF25Pao'ka|r
step
#label Paoka1
.goto Thousand Needles,17.89,40.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Pao'ka|r to begin the escort
>>|cFFFCDC00Be careful if |cFFFF5722Heartrazor|r |cFFFCDC00is up! This is a level 32 rare elite|r
.accept 4770 >> Accept Homeward Bound
.target Pao'ka Swiftmountain
.unitscan Heartrazor
step
#completewith next
>>Loot |cFF00BCD4Highperch Wyvern Eggs|r on the ground
.complete 4767,1 
step
.goto Thousand Needles,11.06,34.95,40,0
.goto Thousand Needles,15.17,32.66
>>|cFFFCDC00Escort|r |cFF00FF25Pao'ka|r
>>|cFFFCDC00Three Highperch Wyverns will spawn once |cFF00FF25Pao'ka|r reaches the middle of Highperch. You only need to aggro the eastern one and the others will disappear|r
.complete 4770,1 
step
#completewith next
.goto Thousand Needles,14.41,32.44,20,0
.goto Thousand Needles,14.04,32.37,12,0
.goto Thousand Needles,14.04,32.37,20 >>Travel toward Highperch
step
.goto Thousand Needles,11.31,33.07,50,0
.goto Thousand Needles,9.57,34.90,50,0
.goto Thousand Needles,10.68,40.95,50,0
.goto Thousand Needles,11.98,36.72,50,0
.goto Thousand Needles,13.91,39.11,50,0
.goto Thousand Needles,11.31,33.07,50,0
.goto Thousand Needles,9.57,34.90,50,0
.goto Thousand Needles,10.68,40.95,50,0
.goto Thousand Needles,11.98,36.72,50,0
.goto Thousand Needles,13.91,39.11,50,0
>>Loot |cFF00BCD4Highperch Wyvern Eggs|r on the ground
.complete 4767,1 
step
#completewith Messenger
.line Thousand Needles,14.34,30.13,15.08,31.63,15.67,31.56,16.59,30.34,17.19,29.60,17.82,27.50,18.48,26.74,18.64,25.90,18.68,24.68,18.57,24.07,18.11,23.65,17.66,22.98,17.24,22.32,17.54,21.49,17.87,20.78,17.96,20.18,17.66,19.46,17.28,18.93,16.70,18.61,16.20,18.53,15.69,18.65,14.49,20.04,12.89,19.97,11.88,20.90,11.50,21.61,11.20,22.29,11.16,23.21,11.49,24.07,11.55,24.44,11.91,25.02,13.01,26.31,13.36,26.97,13.75,28.54,14.34,30.13
>>Kill |cFFFF5722Steelsnap|r. Loot him for |cFF00BCD4Steelsnap's Rib|r
>>|cFFFCDC00Be careful, has two |cFFFF5722Hyenas|r |cFFFCDC00defending him!|r
.complete 1131,1 
step
.goto Thousand Needles,21.06,31.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Laer|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Laer Stepperunner
step
.goto Thousand Needles,21.25,32.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kanati|r
>>|cFFFCDC00Be careful! Turning this in will summon three |cFFFF5722Galak Assassins|r |cFFFCDC00that you have to protect |cFF00FF25Kanati|r from|r
.turnin 4881 >> Turn in Assassination Plot
.accept 4966 >> Accept Protect Kanati Greycloud
.target Kanati Greycloud
.isOnQuest 4881
step
.goto Thousand Needles,21.25,32.05
>>Kill the |cFFFF5722Galak Assassins|r to protect |cFF00FF25Kanati|r
.complete 4966,1 
.mob Galak Assassin
.isOnQuest 4966
step
.goto Thousand Needles,21.25,32.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kanati|r
.turnin 4966 >> Turn in Protect Kanati Greycloud
.isQuestComplete 4966
step
.goto Thousand Needles,21.54,32.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Motega|r
.turnin 4865 >> Turn in Serpent Wild
.accept 5062 >> Accept Sacred Fire
.turnin 4770 >> Turn in Homeward Bound
.target Motega Firemane
step
.goto Thousand Needles,21.43,32.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Wizlo|r
.accept 5151 >> Accept Hypercapacitor Gizmo
.target Wizlo Bearingshiner
.group
step
.goto Thousand Needles,22.78,24.53
>>Open the cage and kill the |cFFFF5722Enraged Panther|r. Loot him for the |cFF00BCD4Hypercapacitor Gizmo|r
.complete 5151,1 
.mob Enraged Panther
.group 2
step
#label Messenger
.line Thousand Needles,39.51,33.43,39.34,32.31,38.81,31.73,37.34,29.29,36.57,29.47,35.84,28.59,35.19,28.11,34.25,29.49,33.89,29.77,33.81,30.12,33.27,30.86,32.73,30.68,32.29,30.52,31.55,30.61,30.69,32.43,29.51,33.89,29.24,33.96,28.64,33.43,28.24,33.37,27.34,34.02,25.29,34.23,24.56,32.76,22.05,30.61,20.83,28.26,20.45,27.87,19.96,27.67,19.46,27.04,18.98,26.71,18.63,26.19,18.70,24.42,18.47,23.06,18.72,22.53,18.32,22.10,19.14,22.81,19.06,23.80,18.60,25.14
.goto Thousand Needles,38.46,32.60,0
.goto Thousand Needles,18.32,22.10,0
.goto Thousand Needles,18.32,22.10,40,0
.goto Thousand Needles,18.72,22.53,40,0
.goto Thousand Needles,18.47,23.06,40,0
.goto Thousand Needles,18.70,24.42,40,0
.goto Thousand Needles,18.63,26.19,40,0
.goto Thousand Needles,18.98,26.71,40,0
.goto Thousand Needles,19.46,27.04,40,0
.goto Thousand Needles,19.96,27.67,40,0
.goto Thousand Needles,20.45,27.87,40,0
.goto Thousand Needles,20.83,28.26,40,0
.goto Thousand Needles,22.05,30.61,40,0
.goto Thousand Needles,24.56,32.76,40,0
.goto Thousand Needles,25.29,34.23,40,0
.goto Thousand Needles,27.34,34.02,40,0
.goto Thousand Needles,28.24,33.37,40,0
.goto Thousand Needles,28.64,33.43,40,0
.goto Thousand Needles,29.24,33.96,40,0
.goto Thousand Needles,29.51,33.89,40,0
.goto Thousand Needles,30.69,32.43,40,0
.goto Thousand Needles,31.55,30.61,40,0
.goto Thousand Needles,32.29,30.52,40,0
.goto Thousand Needles,33.27,30.86,40,0
.goto Thousand Needles,33.81,30.12,40,0
.goto Thousand Needles,34.25,29.49,40,0
.goto Thousand Needles,35.19,28.11,40,0
.goto Thousand Needles,35.84,28.59,40,0
.goto Thousand Needles,36.57,29.47,40,0
.goto Thousand Needles,37.34,29.29,40,0
.goto Thousand Needles,38.81,31.73,40,0
.goto Thousand Needles,39.51,33.43
>>Kill the |cFFFF5722Galak Messenger|r. Loot him for the |T133473:0|t[|cFF00BCD4Assassination Note|r]. Use it to start the quest
>>|cFFFCDC00He spawns at Splithoof Crag (the eastern Centaur camp)|r
>>|cFFFCDC00Scout for him with|r |T132172:0|t[Eagle Eye] |cFFFCDC00if you have trained it|r << Hunter
>>|cFFFCDC00Scout for him with|r |T136034:0|t[Far Sight] |cFFFCDC00if you have trained it|r << Shaman
.collect 12564,1,4881 
.accept 4881 >>Accept Assassination Plot
.use 12564
.unitscan Galak Messenger
step
.line Thousand Needles,14.34,30.13,15.08,31.63,15.67,31.56,16.59,30.34,17.19,29.60,17.82,27.50,18.48,26.74,18.64,25.90,18.68,24.68,18.57,24.07,18.11,23.65,17.66,22.98,17.24,22.32,17.54,21.49,17.87,20.78,17.96,20.18,17.66,19.46,17.28,18.93,16.70,18.61,16.20,18.53,15.69,18.65,14.49,20.04,12.89,19.97,11.88,20.90,11.50,21.61,11.20,22.29,11.16,23.21,11.49,24.07,11.55,24.44,11.91,25.02,13.01,26.31,13.36,26.97,13.75,28.54,14.34,30.13
.goto Thousand Needles,11.50,21.61,40,0
.goto Thousand Needles,11.88,20.90,40,0
.goto Thousand Needles,12.89,19.97,40,0
.goto Thousand Needles,14.49,20.04,40,0
.goto Thousand Needles,15.69,18.65,40,0
.goto Thousand Needles,16.20,18.53,40,0
.goto Thousand Needles,16.70,18.61,40,0
.goto Thousand Needles,17.28,18.93,40,0
.goto Thousand Needles,17.66,19.46,40,0
.goto Thousand Needles,17.96,20.18,40,0
.goto Thousand Needles,17.87,20.78,40,0
.goto Thousand Needles,17.54,21.49,40,0
.goto Thousand Needles,17.24,22.32,40,0
.goto Thousand Needles,17.66,22.98,40,0
.goto Thousand Needles,18.11,23.65,40,0
.goto Thousand Needles,18.57,24.07,40,0
.goto Thousand Needles,18.68,24.68,40,0
.goto Thousand Needles,18.64,25.90,40,0
.goto Thousand Needles,18.48,26.74,40,0
.goto Thousand Needles,17.82,27.50,40,0
.goto Thousand Needles,17.19,29.60,40,0
.goto Thousand Needles,15.67,31.56,40,0
.goto Thousand Needles,15.08,31.63,40,0
.goto Thousand Needles,14.34,30.13,40,0
.goto Thousand Needles,13.75,28.54,40,0
.goto Thousand Needles,13.36,26.97,40,0
.goto Thousand Needles,13.01,26.31,40,0
.goto Thousand Needles,11.91,25.02,40,0
.goto Thousand Needles,11.55,24.44,40,0
.goto Thousand Needles,11.49,24.07,40,0
.goto Thousand Needles,11.16,23.21,40,0
.goto Thousand Needles,11.20,22.29,40,0
.goto Thousand Needles,11.50,21.61
>>Kill |cFFFF5722Steelsnap|r. Loot him for |cFF00BCD4Steelsnap's Rib|r
>>|cFFFCDC00He patrols counter-clockwise|r
>>|cFFFCDC00Scout for him with|r |T132172:0|t[Eagle Eye] |cFFFCDC00if you have trained it|r << Hunter
>>|cFFFCDC00Scout for him with|r |T136034:0|t[Far Sight] |cFFFCDC00if you have trained it|r << Shaman
.complete 1131,1 
.unitscan Steelsnap
step
.goto Thousand Needles,21.25,32.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kanati|r
>>|cFFFCDC00Be careful! Turning this in will summon three |cFFFF5722Galak Assassins|r |cFFFCDC00that you have to protect |cFF00FF25Kanati|r from|r
.turnin 4881 >> Turn in Assassination Plot
.accept 4966 >> Accept Protect Kanati Greycloud
.target Kanati Greycloud
.isOnQuest 4881
step
.goto Thousand Needles,21.25,32.05
>>Kill the |cFFFF5722Galak Assassins|r to protect |cFF00FF25Kanati|r
.complete 4966,1 
.mob Galak Assassin
.isOnQuest 4966
step
.goto Thousand Needles,21.25,32.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kanati|r
.turnin 4966 >> Turn in Protect Kanati Greycloud
.isQuestComplete 4966
step
.goto Thousand Needles,21.43,32.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Wizlo|r
.turnin 5151 >> Turn in Hypercapacitor Gizmo
.target Wizlo Bearingshiner
.group
.isQuestComplete 5151
step
.loop 25,Thousand Needles,36.58,38.77,37.77,38.17,36.63,36.23,34.96,33.22,33.37,32.85,33.67,34.09,34.88,34.82,35.62,36.20,36.05,37.41,36.58,38.77
>>Loot the |cFFDB2EEFIncendia Agave Plants|r on the ground and underwater
>>|cFFFF5722Scalding Elementals|r and |cFFFF5722Boiling Elementals|r are immune to frost damage, and highly resistant to fire. Try to avoid them or use Arcane spells << Mage
>>|cFFFCDC00Be careful as|r |cFFFF5722Boiling Elementals|r |cFFFCDC00cast|r |T132156:0|t[Steam Jet]|cFFFCDC00, reducing your chance to hit by 30% for 10 seconds|r << Warrior/Rogue/Shaman/Druid
>>|cFFFCDC00Be careful as|r |cFFFF5722Scalding Elementals|r |cFFFCDC00cast|r |T135807:0|t[Scald]|cFFFCDC00, instantly dealing 150 fire damage and stunning you for 4 seconds|r
.complete 5062,1 
step
#completewith next
.hs >> Hearth to Thunder Bluff
.use 6948
step
.goto Thunder Bluff,45.83,64.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Pala|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Pala
step
.goto Thunder Bluff,61.53,80.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Melor|r
.turnin 1131 >> Turn in Steelsnap
.target Melor Stonehoof
step << Hunter
.goto Thunder Bluff,59.13,86.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 14319 >> Train your class spells
.target Urek Thunderhorn
.xp <28,1
.xp >30,1
step << Hunter
.goto Thunder Bluff,59.13,86.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 5384 >> Train your class spells
.target Urek Thunderhorn
.xp <30,1
step << Hunter
.goto Thunder Bluff,54.07,84.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hesuwa|r
.train 24559 >> Train your pet spells
.target Hesuwa Thunderhorn
.xp <30,1
step << Warrior
.goto Thunder Bluff,57.59,85.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ker|r
.train 7887 >> Train your class spells
.target Ker Ragetotem
.xp <28,1
.xp >30,1
step << Warrior
.goto Thunder Bluff,57.27,87.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torm|r
.train 7369 >> Train your class spells
.accept 1718 >>Accept The Islander
.target Torm Ragetotem
.xp <30,1
step
.goto Thunder Bluff,69.88,30.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Magatha|r
.turnin 5062 >> Turn in Sacred Fire
.accept 5088 >> Accept Arikara
.target Magatha Grimtotem
.group
step
.goto Thunder Bluff,69.88,30.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Magatha|r
.turnin 5062 >> Turn in Sacred Fire
.target Magatha Grimtotem
step << Druid
.goto Thunder Bluff,76.79,31.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kym|r
.train 3029 >> Train your class spells
.target Kym Wildmane
.xp <28,1
.xp >30,1
step << Druid
.goto Thunder Bluff,76.79,31.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kym|r
.train 783 >> Train your class spells
.target Kym Wildmane
.xp <30,1
step
.goto Thunder Bluff,36.01,59.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Auld|r
.accept 1102 >> Accept A Vengeful Fate
.target Auld Stonespire
.dungeon RFK
step << Priest
.goto Thunder Bluff,25.31,15.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Miles|r
.train 8104 >> Train your class spells
.target Miles Welsh
.xp <28,1
.xp >30,1
step << Priest
.goto Thunder Bluff,25.31,15.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Miles|r
.train 602 >> Train your class spells
.target Miles Welsh
.xp <30,1
step << Mage
.goto Thunder Bluff,22.74,14.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shymm|r
.train 759 >> Train your class spells
.target Archmage Shymm
.xp <28,1
.xp >30,1
step << Mage
.goto Thunder Bluff,22.74,14.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shymm|r
.train 8412 >> Train your class spells
.target Archmage Shymm
.xp <30,1
step << Mage
.goto Thunder Bluff,22.48,16.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Birgitte|r
.train 3566 >> Train |T135765:0|t[Teleport: Thunder Bluff]
.target Birgitte Cranston
.xp <30,1
step << Shaman
.goto Thunder Bluff,23.64,18.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 8053 >> Train your class spells
.target Tigor Skychaser
.xp <28,1
.xp >30,1
step << Shaman
.goto Thunder Bluff,23.64,18.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 556 >> Train your class spells
.target Tigor Skychaser
.xp <30,1
step
#completewith next
.skill firstaid,150 >> Create |T133687:0|t[Heavy Wool Bandages] until your skill is 150
.skill firstaid,<1,1
step
.goto Thunder Bluff,29.68,21.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pand|r
.train 7928 >> Train |T133671:0|t[Silk Bandage]
>>|cFFFCDC00Skip this step if you did not have enough Wool Cloth to reach 150 skill|r
.target Pand Stonebinder
.skill firstaid,<1,1
step << Hunter
.goto Thunder Bluff,46.98,45.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kuna|r|cRXP_BUY_. Buy a|r |T135495:0|t[Sturdy Recurve Bow] |cRXP_BUY_from her if it's available|r
.collect 11306,1,1153,1 
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<12.9
.target Kuna Thunderhorn
step
.goto Thunder Bluff,46.98,45.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kuna|r
.collect 3030,1800,1153,1 << Hunter 
.target Kuna Thunderhorn
step << Shaman/Warrior
.goto Thunder Bluff,54.06,57.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Delgo|r|cRXP_BUY_. Buy a|r |T132408:0|t[Merciless Axe] |cRXP_BUY_from him if it's available|r
>>|cRXP_BUY_Alternatively you can also buy a|r |T135576:0|t[Bullova]
.collect 12249,1,1153,1 
.money <3.0195
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<21.0
.target Delgo Ragetotem
step << Rogue
.goto Thunder Bluff,53.00,56.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kard|r|cRXP_BUY_. Buy a|r |T135275:0|t[Broadsword] |cRXP_BUY_from him|r
.collect 2520,1,1153,1 
.money <2.5924
.target Kard Ragetotem
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<17.6
step << Rogue
#completewith TearMoons
+Equip the |T135275:0|t[Broadsword]
.use 2520
.itemcount 2520,1
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<17.6
step << Rogue
.goto Thunder Bluff,53.00,56.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Kard|r|cRXP_BUY_. Buy a|r |T135651:0|t[Main Gauche] |cRXP_BUY_from him for your off-hand|r
.collect 2526,1,1153,1 
.money <2.0353
.target Kard Ragetotem
.itemStat 17,QUALITY,<7
.itemStat 17,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<16.5
step << Rogue
#completewith TearMoons
+Equip the |T135651:0|t[Main Gauche]
.use 2526
.itemcount 2526,1
.itemStat 17,QUALITY,<7
.itemStat 17,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<16.5
step
#completewith next
.goto Thunder Bluff,47.00,49.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tal|r
.fly Camp Taurajo >>Fly to Camp Taurajo
.target Tal
.zoneskip The Barrens
step
.goto The Barrens,45.10,57.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tatternack|r
.turnin 1153 >> Turn in A New Ore Sample
.target Tatternack Steelforge
step
.goto The Barrens,50.48,78.72,100 >> Travel into Dustwallow Marsh
step
#label Hoofprints
.goto Dustwallow Marsh,29.71,47.65
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Hoofprints|r on the ground
.accept 1268 >> Accept Suspicious Hoofprints
.xp <30,1
step
#label Badge
.goto Dustwallow Marsh,29.83,48.24
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Theramore Guard Badge|r on the plank of wood
.accept 1269 >> Accept Lieutenant Paval Reethe
.xp <30,1
step
.goto Dustwallow Marsh,29.63,48.60
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Black Shield|r above the fireplace
.accept 1251 >> Accept The Black Shield
.xp <30,1
step
#completewith next
.goto Dustwallow Marsh,30.65,45.34,40,0
.goto Dustwallow Marsh,32.28,42.80,40,0
.goto Dustwallow Marsh,33.12,40.85,40,0
.goto Dustwallow Marsh,33.55,38.71,40,0
.goto Dustwallow Marsh,34.73,37.66,40,0
.goto Dustwallow Marsh,34.31,34.40,40,0
.goto Dustwallow Marsh,33.30,31.23,40,0
.goto Dustwallow Marsh,34.58,30.62,40,0
.goto Dustwallow Marsh,36.64,31.72,120 >> Travel to Brackenwall Village
>>|cFFFCDC00Be careful! There level 36-38 mobs in the area. Follow the waypoint for safety|r
step
.goto Dustwallow Marsh,36.41,31.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krog|r
.turnin 1268 >> Turn in Suspicious Hoofprints
.turnin 1269 >> Turn in Lieutenant Paval Reethe
.target Krog
.isOnQuest 1268
.isOnQuest 1269
step
.goto Dustwallow Marsh,36.41,31.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krog|r
.turnin 1251 >> Turn in The Black Shield
.accept 1321 >> Accept The Black Shield
.target Krog
.isOnQuest 1251
step
.goto Dustwallow Marsh,36.50,30.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Do'gol|r
.turnin 1321 >> Turn in The Black Shield
.target Do'gol
.isQuestTurnedIn 1251
step << Warrior/Shaman
.goto Dustwallow Marsh,36.17,31.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Zulrg|r|cRXP_BUY_. Buy a|r |T135158:0|t[Big Stick] |cRXP_BUY_from him if it's up|r
.collect 12251,1,4904,1 
.money <4.3117
.target Zulrg
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<25.6
step
.goto Dustwallow Marsh,36.49,30.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Balai|r
.vendor >> |cRXP_BUY_Buy|r |T134831:0|t[Healing Potions] |cRXP_BUY_and|r |T134937:0|t[Scrolls] |cRXP_BUY_from her if they're up|r
.target Balai Lok'Wein
step
.goto Dustwallow Marsh,36.49,30.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Balai|r
.vendor >>|cRXP_BUY_Buy the|r |T134831:0|t[First Aid Manuals] |cRXP_BUY_from her|r
.collect 16112,1,4904,1 >> Manual: Heavy Silk Bandage (1)
.collect 16113,1,4904,1 >> Manual: Mageweave Bandage (1)
.collect 16084,1,4904,1 >> Manual: Expert First Aid - Under Wraps (1)
.target Balai Lok'Wein
.skill firstaid,<1,1
step
#completewith next
.goto Dustwallow Marsh,35.57,31.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shardi|r
.fp Brackenwall >> Get the Brackenwall Village Flight Path
.fly Freewind >> Fly to Freewind Post
.target Shardi
.zoneskip Thousand Needles
step
.goto Thousand Needles,44.90,48.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elu|r
.turnin 4767 >> Turn in Wind Rider
.target Elu
step << Hunter
.goto Thousand Needles,44.89,50.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Starn|r
.vendor >>|cFF0E8312Buy a|r |T135495:0|t[Dense Shortbow] |cFF0E8312from him if it's up|r
.target Starn
.money <2.7172
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<14.2
step
.goto Thousand Needles,45.15,50.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Montarr|r
.vendor >> |cRXP_BUY_Buy|r |T134831:0|t[Healing Potions] |cRXP_BUY_and|r |T134937:0|t[Scrolls] |cRXP_BUY_from him if they're up|r
.target Montarr
step
.goto Thousand Needles,46.07,51.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Abeqwa|r
.home >> Set your Hearthstone to Freewind Post
.target Innkeeper Abeqwa
step
.goto Thousand Needles,53.95,41.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Dorn|r
.turnin 1150 >> Turn in Test of Endurance
.accept 1151 >> Accept Test of Strength
.target Dorn Plainstalker
.isQuestComplete 1150
.group
step
.goto Thousand Needles,53.95,41.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Dorn|r
.accept 1151 >> Accept Test of Strength
.target Dorn Plainstalker
.isQuestTurnedIn 1150
.group
step
.goto Thousand Needles,36.10,55.02,100,0
.goto Thousand Needles,30.35,51.58,40,0
.goto Thousand Needles,24.34,44.72,60,0
.goto Thousand Needles,20.88,39.84,60,0
.goto Thousand Needles,17.33,36.72,60,0
.goto Thousand Needles,13.27,26.74,60,0
.goto Thousand Needles,9.98,21.71,60,0
.goto Thousand Needles,24.34,44.72
>>Find and kill |cFFFF5722Rok'Alim the Pounder|r. Loot him for his |cFF00BCD4Fragments|r
>>|cFFFCDC00He patrols a large portion of the north-western part of the zone|r
.complete 1151,1 
.unitscan Rok'Alim the Pounder
.isOnQuest 1151
.group 2

step
.goto Thousand Needles,31.47,36.71,30 >> Head to Darkcloud Pinnacle
step
#completewith next
.goto Thousand Needles,33.08,35.33,20,0
.goto Thousand Needles,32.78,32.24,20,0
.goto Thousand Needles,32.03,31.36,20,0
.goto Thousand Needles,32.37,28.64,20,0
.goto Thousand Needles,32.60,27.51,20,0
.goto Thousand Needles,34.87,31.76,20,0
.goto Thousand Needles,34.15,35.77,20,0
.goto Thousand Needles,33.32,36.24,20 >> Travel up Darkcloud Pinnacle
step
.goto Thousand Needles,31.79,32.58
>>Open the |cFFDB2EEFDocument Chest|r on top of the plataeu. Loot it for |cFF00BCD4Secret Note #1|r
.complete 5064,1 
step
.goto Thousand Needles,33.80,39.90
>>Open the |cFFDB2EEFDocument Chest|r inside the big tent. Loot it for |cFF00BCD4Secret Note #1|r
.complete 5064,2 
step
.goto Thousand Needles,39.20,41.60
>>Open the |cFFDB2EEFDocument Chest|r inside the tent on the eastern plateau. Loot it for |cFF00BCD4Secret Note #1|r
.complete 5064,3 
step
#completewith next
.goto Thousand Needles,35.68,39.25,20,0
.goto Thousand Needles,34.32,35.74,20,0
.goto Thousand Needles,35.56,30.94,20,0
.goto Thousand Needles,36.97,31.97,20 >> Travel toward the bonfire on the northeastern plateau
.group
step
>>Clear the |cFFFF5722Grimtotems|r and then light the bonfire
>>Kill |cFFFF5722Arikara|r. Loot her for her |cFF00BCD4Skin|r
.goto Thousand Needles,38.00,35.30
.complete 5088,2 
.complete 5088,1 
.mob Arikara
.group 2
step
.goto Thousand Needles,38.00,26.80
>>Kill |cFFFF5722Arnak Grimtotem|r. Loot him for his |cFF00BCD4Hoof|r
.complete 5147,1 
.mob Arnak Grimtotem
step
.goto Thousand Needles,38.00,26.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lakota|r
>>|cFFFCDC00This will start an escort|r
.accept 4904 >> Accept Free at Last
.target Lakota Windsong
step
.goto Thousand Needles,38.96,29.46,20,0
.goto Thousand Needles,37.56,31.43,20,0
.goto Thousand Needles,36.89,31.73,20,0
.goto Thousand Needles,35.64,31.01,20,0
.goto Thousand Needles,34.53,30.78,20,0
.goto Thousand Needles,33.19,28.54,20,0
.goto Thousand Needles,32.53,27.44,20,0
.goto Thousand Needles,32.28,28.67,20,0
.goto Thousand Needles,32.04,31.37,20,0
.goto Thousand Needles,32.86,32.62,20,0
.goto Thousand Needles,33.05,35.42,20,0
.goto Thousand Needles,31.06,36.89
>>Escort |cFF00FF25Lakota|r to safety
>>|cFFFCDC00Two|r |cFFFF5722Grimtotems|r |cFFFCDC00will spawn every time she reaches a new platform. Try and stay ahead of her to clear the platforms if you have respawns behind|r
>>|cFFFCDC00Be careful as this quest is HARD. Don't be afraid to escape by running behind you and failing the escort|r
.complete 4904,1 
.target Lakota Windsong
step
.goto Thousand Needles,21.54,32.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Motega|r
.turnin 5088 >> Turn in Arikara
.target Motega Firemane
step
.goto Thousand Needles,53.95,41.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Dorn|r
.turnin 1151 >> Turn in Test of Strength

.target Dorn Plainstalker
.isQuestComplete 1151
.group








step
#completewith next
.goto Thousand Needles,70.58,62.69,200 >> Travel to the Shimmering Flats
step
.goto Thousand Needles,77.79,77.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kravel|r
.accept 1110 >> Accept Rocket Car Parts
.accept 1111 >> Accept Wharfmaster Dizzywig
.target Kravel Koalbeard
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzle|r and |cRXP_FRIENDLY_Wizzle|r
.accept 1104 >> Accept Salt Flat Venom
.goto Thousand Needles,78.07,77.13
.accept 1105 >> Accept Hardened Shells
.goto Thousand Needles,78.14,77.12
.target Fizzle Brassbolts
.target Wizzle Brassbolts
step
.goto Thousand Needles,80.17,75.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pozzik|r
.accept 1176 >> Accept Load Lightening
.target Pozzik
step
.goto Thousand Needles,81.63,77.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zherin|r
.accept 1175 >> Accept A Bump in the Road
.target Trackmaster Zherin
step
#completewith next
.goto Thousand Needles,75.44,97.37,40,0
.goto Tanaris,51.60,25.44,100 >> Travel to Gadgetzan
step
.goto Tanaris,51.60,25.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bulkrek|r
.fp Gadgetzan >> Get the Gadgetzan Flight Path
.fly Freewind >> Fly to Freewind Post
.target Bulkrek Ragefist
step
.goto Thousand Needles,45.70,50.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Longhorn|r
.turnin 5064 >> Turn in Grimtotem Spying
.turnin 5147 >> Turn in Wanted - Arnak Grimtotem
.target Cliffwatcher Longhorn
step
.goto Thousand Needles,46.00,51.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thalia|r
.turnin 4904 >> Turn in Free at Last
.target Thalia Amberhide
.isQuestComplete 4904
step
.goto Thousand Needles,45.15,50.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Montarr|r
.vendor >> |cRXP_BUY_Buy|r |T134831:0|t[Healing Potions] |cRXP_BUY_and|r |T134937:0|t[Scrolls] |cRXP_BUY_from him if they're up|r
.target Montarr
step << Hunter
.goto Thousand Needles,44.89,50.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Starn|r
.vendor >>|cFF0E8312Buy a|r |T135495:0|t[Dense Shortbow] |cFF0E8312from him if it's up and fill your quiver with arrows|r
.collect 3030,1800,4767,1 
.target Starn
.money <2.7172
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<14.2
step << Hunter
.goto Thousand Needles,44.89,50.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Starn|r
>>|cFF0E8312Buy|r |T132382:0|t[Razor Arrows] |cFF0E8312from him|r
.collect 3030,1800,4767,1 
.target Starn
step
.goto Thousand Needles,45.14,49.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Nyse|r
.fly Crossroads >> Fly to Crossroads
.target Nyse
.zoneskip The Barrens
step
.goto The Barrens,51.10,29.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Korran|r
.accept 1145 >> Accept The Swarm Grows
.target Korran
step << !Warrior
#completewith WharfDizzy
.goto The Barrens,51.50,30.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Devrak|r
.fly Ratchet >> Fly to Ratchet
.target Devrak
step << Warrior
#completewith WharfDizzy
.goto The Barrens,51.50,30.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Devrak|r
.fly Ratchet >> Fly to Ratchet
.target Devrak
.isOnQuest 1718
step << Warrior
#completewith IslanderPickUp
.goto The Barrens,51.50,30.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Devrak|r
.fly Orgrimmar >> Fly to Orgrimmar
.target Devrak
.zoneskip Orgrimmar
step << Warrior
#completewith next
.goto Orgrimmar,75.00,34.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Belgrom|r
.turnin 1145 >> Turn in The Swarm Grows
.accept 1146 >> Accept The Swarm Grows
.target Belgrom Rockmaul
step << Warrior
#label IslanderPickUp
.goto Orgrimmar,80.37,32.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sorek|r
.accept 1718 >> Accept The Islander
.target Sorek
step << Warrior
#completewith WharfDizzy
.goto Orgrimmar,45.12,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Ratchet >> Fly to Ratchet
.target Doras
.zoneskip The Barrens
step
#label WharfDizzy
.goto The Barrens,63.35,38.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dizzywig|r
.turnin 1111 >> Turn in Wharfmaster Dizzywig
.accept 1112 >> Accept Parts for Kravel
.target Wharfmaster Dizzywig
step << Shaman
.goto The Barrens,65.83,43.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Islen|r
.turnin 220 >>Turn in Call of Water
.accept 63 >>Accept Call of Water
.target Islen Waterseer
step << Shaman
.goto The Barrens,65.83,43.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Islen|r
>>|cFFFCDC00Make sure you get the|r |T134754:0|t[|cFF00BCD4Water Sapta|r
.turnin 972 >>Turn in Water Sapta
.collect 6637,1 
step << Warrior
#completewith next
.goto The Barrens,65.09,47.81,90,0
.goto The Barrens,68.61,49.16,100 >> Travel to Fray Island
step << Warrior
.goto The Barrens,68.62,49.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Klannoc|r
.turnin 1718 >>Turn in The Islander
.accept 1719 >>Accept The Affray
.target Klannoc Macleod
step << Warrior
>>Step onto the grate behind you. Quickly kill the |cFFFF5722Affray Challengers|r that come one by one
>>Kill |cFFFF5722Big Will|r once he appears
.goto The Barrens,68.59,48.76
.complete 1719,1 
.complete 1719,2 
.mob Big Will
step << Warrior
.goto The Barrens,68.62,49.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Klannoc|r
>>|cFFFCDC00This will teach you Berserker Stance|r
.turnin 1719 >>Turn in The Affray
.accept 1791 >>Accept The Windwatcher
.target Klannoc Macleod
step << Warrior
.goto The Barrens,62.81,37.91,200 >>Travel back to Ratchet

step << !Mage
.goto The Barrens,63.09,37.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bragok|r
.fly Orgrimmar >> Fly to Orgrimmar
.target Bragok
.zoneskip Orgrimmar
step << Mage
.cast 3567 >>Cast |T135759:0|t[Teleport: Orgrimmar]
.zoneskip Orgrimmar
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 8412 >> Train your class spells
.target Pephredo
.xp <30,1
.xp >32,1
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 8422 >> Train your class spells
.target Pephredo
.xp <32,1
step << Mage
.goto Orgrimmar,45.43,56.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Horthus|r|cRXP_BUY_. Buy two or more|r |T134419:0|t[Rune of Teleportation] |cRXP_BUY_from him|r
.collect 17031,2 
.target Horthus
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 1760 >> Train your class spells
.target Ormok
.xp <30,1
.xp >32,1
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 8623 >> Train your class spells
.target Ormok
.xp <32,1
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.trainer >> Train your class spells
.accept 1531 >> Accept Call of Air
.target Kardris Dreamseeker
step
.goto Orgrimmar,44.70,52.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Craven|r
>>|cFFFCDC00He patrols in the Cleft of Shadows|r
.accept 1431 >> Accept Alliance Relations
.target Craven Drok
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 2941 >> Train your class spells
.target Mirket
.xp <30,1
.xp >32,1
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 6213 >> Train your class spells
.target Mirket
.xp <32,1
step << Warlock
.goto Orgrimmar,47.52,46.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kurgul|r
.vendor >>Buy any pet upgrades you can afford
.target Kurgul

step << Priest/Warlock
.goto Orgrimmar,44.16,48.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Katis|r|cRXP_BUY_. Buy a|r |T135466:0|t[Pestilent Wand] |cRXP_BUY_from her|r
.collect 5347,1,6544,1 
.money <1.5713
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<26.9
.target Katis
step
.goto Orgrimmar,75.00,34.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Belgrom|r
.turnin 1145 >> Turn in The Swarm Grows
.accept 1146 >> Accept The Swarm Grows
.target Belgrom Rockmaul
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 7369 >> Train your class spells
.target Grezz Ragefist
.xp <30,1
.xp >32,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 20658 >> Train your class spells
.target Grezz Ragefist
.xp <32,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
>>|cFFFCDC00Save at least 1 Gold 88 Silver for later|r
.train 5384 >> Train your class spells
.target Ormak Grimshot
.xp <30,1
.xp >32,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
>>|cFFFCDC00Save at least 1 Gold 88 Silver for later|r
.train 14263 >> Train your class spells
.target Ormak Grimshot
.xp <32,1
step << Hunter
.goto Orgrimmar,66.34,14.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xao'tsu|r
.train 24559 >> Train your pet spells
.target Xao'tsu
.xp <30,1
step << Hunter
.goto Orgrimmar,78.11,38.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Jin'sora|r
.collect 3030,1800,549,1 << Hunter 
.target Jin'sora
step << Hunter
.goto Orgrimmar,81.52,19.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hanashi|r
.train 197 >>Train Two-Handed Axes
.target Hanashi
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 602 >> Train your class spells
.target Ur'kyo
.xp <30,1
.xp >32,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 6077 >> Train your class spells
.target Ur'kyo
.xp <32,1
step
.goto Orgrimmar,22.50,52.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keldran|r near the Western exit of Orgrimmar
.turnin 1431 >> Turn in Alliance Relations
.accept 1432 >> Accept Alliance Relations
.target Keldran
step
#sticky EnterRFK
#completewith
.subzone 491 >> Now you should be looking for a group to Razorfen Kraul
.dungeon RFK
step
.abandon 5151 >> Abandon Hypercapacitor Gizmo
.isOnQuest 5151
step
.abandon 5088 >> Abandon Arikara
.isOnQuest 5088
step
.abandon 1150 >> Abandon Test of Endurance
.isOnQuest 1150
step
.abandon 1151 >> Abandon Test of Strength
.isOnQuest 1151
step
.goto Orgrimmar,45.12,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Camp Taurajo >> Fly Camp Taurajo
.target Doras
.zoneskip The Barrens
.dungeon RFK
step
#label EnterRFK
.goto The Barrens,43.46,90.18,0
.goto The Barrens,43.46,90.18,40,0
.goto 1414,50.89,70.35
.zone 301 >> Enter Razorfen Kraul
.dungeon RFK
step
>>Kill |cRXP_ENEMY_Kraul Bats|r. Loot them for a |cRXP_LOOT_Kraul Guano|r
.complete 1109,1 
.mob Kraul Bat
.mob Greater Kraul Bat
.dungeon RFK
step
>>Kill |cRXP_ENEMY_Charlga Razorflank|r. Loot her for her |cRXP_LOOT_Heart|r and for the |T134939:0|t[|cFF00BCD4Small Scroll|r]. Use the scroll to start the quest
.complete 1102,1 
.collect 17008,1 
.accept 6522 >>Accept An Unholy Alliance
.mob Charlga Razorflank
.use 17008
.dungeon RFK
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Willix the Importer|r
>>|cRXP_WARN_This will start an escort|r
.accept 1144 >> Accept Willix the Importer
.target Willix the Importer
.dungeon RFK
step
>>Escort |cRXP_FRIENDLY_Willix the Importer|r through Razorfen Kraul
>>|cRXP_WARN_Ensure you stay close to |cRXP_FRIENDLY_Willix|r otherwise the quest may not complete!|r
.complete 1144,1 
.isOnQuest 1144
.target Willix the Importer
.dungeon RFK
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Willix the Importer|r
.turnin 1144 >> Turn in Willix the Importer
.target Willix the Importer
.isQuestComplete 1144
.dungeon RFK
step
>>|cRXP_WARN_When at the start of the instance, take the first left. Once you reach the Vine at the end, drop down below to where you see |cRXP_ENEMY_Agam'ars|r below|r
>>|cRXP_WARN_Kill the |cRXP_ENEMY_Agam'ars|r below with your party to create a clear space|r
>>|cRXP_WARN_Use the|r |T132765:0|t[Crate With Holes] |cRXP_WARN_to summon a |cRXP_FRIENDLY_Snufflenose Gopher|r at this location. Finding the correct spot to summon it can be finicky|r
>>|cRXP_WARN_Use the|r |T135474:0|t[Snufflenose Command Stick] |cRXP_WARN_to action the |cRXP_FRIENDLY_Gopher|r to dig up|r |cRXP_LOOT_Blueleaf Tubers|r
>>|cRXP_WARN_Loot the |cRXP_LOOT_Blueleaf Tuber|r once it has dug it up|r
>>|cRXP_WARN_Continue to use the|r |T135474:0|t[Snufflenose Command Stick] |cRXP_WARN_on it again so it digs up another one. Repeat this process until you have 6|r |cRXP_LOOT_Blueleaf Tubers|r
>>|cRXP_WARN_If your |cRXP_FRIENDLY_Gopher|r despawns, use the|r |T132765:0|t[Crate With Holes] |cRXP_WARN_to summon another. Note it only has 5 charges|r
.complete 1221,1 
.use 5880 
.use 6684 
.target Snufflenose Gopher
.isOnQuest 1221
.dungeon RFK
step << !Mage
#completewith next
.hs >> Hearth to Freewind Post
.use 6948
.dungeon RFK
step << !Mage
.goto Thousand Needles,45.14,49.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Nyse|r
.fly Thunder Bluff >> Fly to Thunder Bluff
.target Nyse
.zoneskip Thunder Bluff
.dungeon RFK
step << Mage
.cast 3566 >>Cast |T135765:0|t[Teleport: Thunder Bluff]
.zoneskip Thunder Bluff
.dungeon RFK
step
.goto Thunder Bluff,36.01,59.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Auld|r
.turnin 1102 >> Turn in A Vengeful Fate
.target Auld Stonespire
.isQuestComplete 1102
.dungeon RFK
step
.goto Thunder Bluff,47.00,49.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tal|r
.fly Orgrimmar >>Fly to Orgrimmar
.target Tal
.zoneskip Thunder Bluff,1
.dungeon GNOMER
step
.goto Orgrimmar,76.00,25.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nogg|r
.accept 2841 >>Accept Rig Wars
.target Nogg
.dungeon GNOMER
step
.goto Orgrimmar,75.50,25.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sovik|r
.accept 2842 >>Accept Chief Engineer Scooty
.target Sovik
.dungeon GNOMER
step
.goto Orgrimmar,45.13,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Ratchet >>Fly to Ratchet
.target Doras
.zoneskip Orgrimmar,1
.dungeon GNOMER
step
.goto Thunder Bluff,47.00,49.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tal|r
.fly Ratchet >>Fly to Ratchet
.target Tal
.zoneskip Thunder Bluff,1
.dungeon RFK
step
#sticky
#completewith EnterGNOMER
.subzone 133 >> Now you should be looking for a group to Gnomeregan
.dungeon GNOMER
step
.goto The Barrens,62.370,37.615
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mebok|r
.turnin 1221 >> Turn in Blueleaf Tubers
.target Mebok Mizzyrix
.isQuestComplete 1221
.dungeon RFK
step
#completewith next
.goto The Barrens,63.74,38.66
.zone Stranglethorn Vale >> Take the boat to Stranglethorn Vale
.zoneskip Stranglethorn Vale
.dungeon GNOMER
step
.goto Stranglethorn Vale,27.60,77.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scooty|r
.turnin 2842 >>Turn in Chief Engineer Scooty
.accept 2843 >>Accept Gnomer-gooooone!
.target Scooty
.timer 9 >> Goblin Transponder
.dungeon GNOMER
step
.goto Stranglethorn Vale,27.60,77.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scooty|r
.turnin 2843 >>Turn in Gnomer-gooooone!
.target Scooty
.dungeon GNOMER
step
.goto Stranglethorn Vale,27.63,77.55
.goto Eastern Kingdoms,42.75,59.93,30 >> Step onto the Gnomeregan Transponder
.dungeon GNOMER
step
#label EnterGNOMER
.goto Eastern Kingdoms,42.64,59.80,20,0
.goto Eastern Kingdoms,42.58,59.82,20,0
.goto Eastern Kingdoms,42.56,59.87,20,0
.goto Eastern Kingdoms,42.51,60.15,20,0
.goto Eastern Kingdoms,42.34,60.18
.zone 226 >> Enter Gnomeregan
.dungeon GNOMER
step
>>Kill |cRXP_ENEMY_Mekgineer Thermaplugg|r. Loot him for his |cRXP_LOOT_Safe Combination|r
>>Loot |cFFDB2EEFThermaplugg's Safe|r in the northern side of the room for the |cRXP_LOOT_Rig Blueprints|r
.complete 2841,2 
.complete 2841,1 
.mob Mekgineer Thermaplugg
.dungeon GNOMER
step << !Mage
#completewith next
.hs >> Hearth to Freewind Post
.use 6948
.dungeon GNOMER
step << !Mage
.goto Thousand Needles,45.14,49.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Nyse|r
.fly Orgrimmar >> Fly to Orgrimmar
.target Nyse
.zoneskip Orgrimmar
.dungeon GNOMER
step << !Mage
.goto The Barrens,63.09,37.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bragok|r
.fly Orgrimmar >> Fly to Orgrimmar
.target Bragok
.zoneskip 392,1
step << Mage
.cast 3567 >>Cast |T135759:0|t[Teleport: Orgrimmar]
.zoneskip Orgrimmar
step
.goto Orgrimmar,76.00,25.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nogg|r
.turnin 2841 >>Turn in Rig Wars
.target Nogg
.dungeon GNOMER
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 32-35 Hillsbrad/Arathi
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 30-40
#next 35-35 Shimmering Flats
step << Mage
#completewith next
.cast 3563 >>Cast |T135766:0|t[Teleport: Undercity]
step << Mage
.goto Undercity,82.79,15.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hannah Akeley|r
.vendor >> |cRXP_BUY_Buy at least two|r |T134419:0|t[Rune of Teleportation]
.collect 17031,2 
.target Hannah Akeley
step << !Mage
#completewith next
.zone Durotar >> Leave Orgrimmar
.zoneskip Durotar
step << !Mage
.goto Durotar,50.8,13.8,40 >>Go up the Zeppelin Tower
.zone Tirisfal Glades >>Take the Zeppelin to Tirisfal Glades
.zoneskip Tirisfal Glades
step
#completewith StealfromThievesPickup
.goto Tirisfal Glades,61.80,65.06,20,0
.zone Undercity >> Enter Undercity
.zoneskip Undercity
step
#completewith StealfromThievesPickup
.goto Undercity,66.09,20.06,20,0
.goto Undercity,64.37,23.94,20,0
.goto Undercity,65.93,26.71,10,0
.goto Undercity,65.89,34.03,10,0
.goto Undercity,64.22,39.77,10,0
.goto Undercity,65.53,43.62,15 >> Take the lift down to the Undercity
step << Hunter
.goto Undercity,57.31,32.77
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Archibald|r
.train 5011 >> Train Crossbows
.train 202 >> Train Two-Handed Swords
.target Archibald
step << Hunter
.goto Undercity,58.82,32.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Benijah|r|cRXP_BUY_. Buy a|r |T134402:0|t[Heavy Quiver] |cRXP_BUY_and a|r |T135532:0|t[Heavy Crossbow] |cRXP_BUY_from him and fill your quiver with arrows|r
.collect 15809,1,552,1 
.collect 7371,1,552,1 
.collect 3030,2600,552,1 << Hunter 
.money <1.6691
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<13.0
.target Benijah Fenner
step << Hunter
.goto Undercity,58.82,32.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Benijah|r|cRXP_BUY_. Buy a|r |T134402:0|t[Heavy Quiver] |cRXP_BUY_from him and fill your quiver with arrows|r
.collect 7371,1,552,1 
.target Benijah Fenner
step << Rogue
.goto Undercity,58.65,33.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Geoffrey|r|cRXP_BUY_. Buy a|r |T135275:0|t[Broadsword] |cRXP_BUY_from him|r
.collect 2520,1,552,1 
.money <2.2165
.target Geoffrey Hartwell
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<17.6
step << Rogue
#completewith StealfromThievesPickup
+Equip the |T135275:0|t[Broadsword]
.use 2520
.itemcount 2520,1
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<17.6
step << Rogue
.goto Undercity,58.65,33.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Geoffrey|r|cRXP_BUY_. Buy a|r |T135651:0|t[Main Gauche] |cRXP_BUY_from him for your off-hand|r
.collect 2526,1,552,1 
.money <1.7402
.target Geoffrey Hartwell
.itemStat 17,QUALITY,<7
.itemStat 17,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<16.5
step << Rogue
#completewith StealfromThievesPickup
+Equip the |T135651:0|t[Main Gauche]
.use 2526
.itemcount 2526,1
.itemStat 17,QUALITY,<7
.itemStat 17,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<16.5
step
.goto Undercity,48.80,69.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Faranell|r
.turnin 1109 >> Turn in Going, Going, Guano!
.target Master Apothecary Faranell
.isQuestComplete 1109
.dungeon RFK
step
.goto Undercity,48.80,69.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Faranell|r
.turnin 1109 >> Turn in Going, Going, Guano!
.target Master Apothecary Faranell
.isQuestComplete 1109
.dungeon RFK
step
.goto Undercity,56.24,92.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Varimathras|r
.turnin 6522 >>Turn in An Unholy Alliance
.target Varimathras
.isOnQuest 6522
.dungeon RFK
step
#label StealfromThievesPickup
.goto Undercity,64.20,49.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Genavie |r
.accept 1164 >> Accept To Steal From Thieves
.target Genavie Callow
step
.goto Undercity,62.14,44.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Eunice|r
.train 2550 >> Train Cooking for a quest later
.target Eunice Burch
step
.goto Undercity,62.30,43.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Ronald|r. |cRXP_BUY_Buy|r |T134059:0|t[Soothing Spices] |cRXP_BUY_from him|r
.collect 3713,1 
.target Ronald Burch
step
.goto Undercity,65.99,44.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_William|r
.bankwithdraw 3692 >> Withdraw the |T133730:0|t[|cFF00BCD4Hillsbrad Human Skulls|r] from your bank
.target William Montague
step << !Shaman
#completewith AcceptAgony
.goto Undercity,63.27,48.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Michael|r
.fly Tarren Mill >> Fly to Tarren Mill
.target Michael Garrett
.zoneskip Hillsbrad Foothills
step << Shaman
#completewith next
.goto Undercity,63.27,48.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Michael|r
.fly Sepulcher >> Fly to The Sepulcher
.target Michael Garrett
.zoneskip Silverpine Forest
step << Shaman
#completewith CallofWaterSVP
.goto Silverpine Forest,42.03,40.66,10 >> Jump up the side of the tree here
step << Shaman
#completewith CallofWaterSVP
.line Silverpine Forest,41.6,41.8,40.3,42.1,38.9,43.3
.goto Silverpine Forest,41.6,41.8,15,0
.goto Silverpine Forest,40.3,42.1,15,0
.goto Silverpine Forest,38.9,43.3,20 >>Run down the mountain
step << Shaman
.goto Silverpine Forest,38.78,44.25
.use 6637 >>Drink the |T134754:0|t[Water Sapta], then kill the |cRXP_ENEMY_Corrupt Minor Manifestion of Water|r and loot the |T132608:0|t[Corrupt Manifestation's Bracers]
.complete 63,1 
.unitscan Corrupt Minor Manifestation of Water
step << Shaman
#label CallofWaterSVP
.goto Silverpine Forest,38.26,44.56
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Brazier of Everfount|r
.turnin 63 >>Turn in Call of Water
.accept 100 >>Accept Call of Water
step << Shaman
.goto Silverpine Forest,38.78,44.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Minor Manifestation of Water|r
>>|cRXP_WARN_It will appear after a few seconds of roleplay|r
.turnin 100 >>Turn in Call of Water
.accept 96 >>Accept Call of Water
.target Minor Manifestation of Water
step << Shaman
#completewith next
.goto Silverpine Forest,45.62,42.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karos|r
.fly Tarren Mill >> Fly to Tarren Mill
.target Karos Razok
.zoneskip Hillsbrad Foothills
step
.abandon 1144 >> Abandon Willix the Importer
.isOnQuest 1144
.dungeon RFK
step.
.abandon 1102 >> Abandon A Vengeful Fate
.isOnQuest 1102
.dungeon RFK
step
.abandon 1221 >> Abandon Blueleaf Tubers
.isOnQuest 1221
.dungeon RFK
step
.abandon 1109 >> Abandon Going, Going, Guano!
.isOnQuest 1109
.dungeon RFK
step
#label next
.goto Hillsbrad Foothills,61.44,19.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r
.accept 509 >> Accept Elixir of Agony
.target Apothecary Lydon
step
.goto Hillsbrad Foothills,61.86,19.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tallow|r
.accept 676 >> Accept The Hammer May Fall
.target Tallow
step
.goto Hillsbrad Foothills,62.31,20.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Darthalia|r
.accept 529 >> Accept Battle of Hillsbrad
.target High Executor Darthalia
.isQuestTurnedIn 528
step
.goto Hillsbrad Foothills,63.24,20.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krusk|r
.accept 533 >> Accept Infiltration
.target Krusk
step
.goto Hillsbrad Foothills,63.88,19.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thaivand|r
.accept 552 >> Accept Helcular's Revenge
.target Novice Thaivand
step << !Warrior
.goto Hillsbrad Foothills,68.42,17.01,50,0
.goto Hillsbrad Foothills,70.31,11.72,50,0
.goto Alterac Mountains,74.67,65.36,50,0
.goto Alterac Mountains,77.32,63.20,50,0
.goto Alterac Mountains,80.07,58.61,50,0
.goto Alterac Mountains,84.76,51.26,50,0
.goto Alterac Mountains,89.36,47.26,50,0
.goto Hillsbrad Foothills,68.21,19.09,50,0
.goto Hillsbrad Foothills,68.32,25.16,50,0
.goto Hillsbrad Foothills,67.66,31.88,50,0
.goto Hillsbrad Foothills,67.38,35.69,50,0
.goto Hillsbrad Foothills,63.76,40.24,50,0
.goto Hillsbrad Foothills,61.97,42.50,50,0
.goto Alterac Mountains,89.36,47.26,50,0
.goto Alterac Mountains,77.32,63.20
>>Travel up and down the river. Kill |cRXP_ENEMY_Snapjaws|r. Loot them for their |T134026:0|t[|cFF00BCD4Turtle Meat|r]
.collect 3712,10 
.mob Snapjaw
.isQuestAvailable 7321
step << Warrior
#completewith next
>>Travel up and down the river. Kill |cRXP_ENEMY_Snapjaws|r. Loot them for their |T134026:0|t[|cFF00BCD4Turtle Meat|r]
.collect 3712,10 
.mob Snapjaw
.isQuestAvailable 7321
step << Warrior
.goto Alterac Mountains,80.49,66.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bath'rah|r
.turnin 1791 >>Turn in The Windwatcher
.accept 1712 >>Accept Cyclonian
.target Bath'rah the Windwatcher
step << Warrior
.goto Alterac Mountains,77.32,63.20,50,0
.goto Alterac Mountains,80.07,58.61,50,0
.goto Alterac Mountains,84.76,51.26,50,0
.goto Alterac Mountains,89.36,47.26,50,0
.goto Hillsbrad Foothills,68.21,19.09,50,0
.goto Hillsbrad Foothills,68.32,25.16,50,0
.goto Hillsbrad Foothills,67.66,31.88,50,0
.goto Hillsbrad Foothills,67.38,35.69,50,0
.goto Hillsbrad Foothills,63.76,40.24,50,0
.goto Hillsbrad Foothills,61.97,42.50,50,0
.goto Alterac Mountains,89.36,47.26,50,0
.goto Alterac Mountains,77.32,63.20,50,0
>>Travel up and down the river. Kill |cRXP_ENEMY_Snapjaws|r. Loot them for their |T134026:0|t[|cFF00BCD4Turtle Meat|r]
.collect 3712,10 
.mob Snapjaw
.isQuestAvailable 7321
step
.goto Hillsbrad Foothills,62.28,19.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Christoph|r inside the inn
.accept 7321 >> Accept Soothing Turtle Bisque
.turnin 7321 >> Turn in Soothing Turtle Bisque
.target Christoph Jeffcoat
step
#completewith next
.goto Hillsbrad Foothills,62.76,19.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Shay|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Shay
step
.goto Hillsbrad Foothills,36.02,39.19,150 >> Run to the Hillsbrad Fields
.isOnQuest 529
step
#completewith next
>>Kill |cRXP_ENEMY_Blacksmith Verringtan|r and |cRXP_ENEMY_Hillsbrad Apprentice Blacksmiths|r
.complete 529,1 
.complete 529,2 
.unitscan Blacksmith Verringtan
.mob Hillsbrad Apprentice Blacksmith
step
.goto Hillsbrad Foothills,32.02,45.45
>>Loot the |cRXP_PICK_Shipment of Iron|r for the |T132761:0|t[|cFF00BCD4Shipment of Iron|r]
.complete 529,3 
step
.goto Hillsbrad Foothills,32.65,45.48,20,0
.goto Hillsbrad Foothills,31.87,46.66,20,0
.goto Hillsbrad Foothills,32.23,45.32
>>Kill |cRXP_ENEMY_Blacksmith Verringtan|r and |cRXP_ENEMY_Hillsbrad Apprentice Blacksmiths|r
.complete 529,1 
.complete 529,2 
.unitscan Blacksmith Verringtan
.mob Hillsbrad Apprentice Blacksmith
step
#completewith next
.goto Hillsbrad Foothills,62.31,20.29,125 >> Travel back to Tarren Mill
step
.goto Hillsbrad Foothills,62.31,20.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Darthalia|r
.turnin 529 >> Turn in Battle of Hillsbrad
.accept 532 >> Accept Battle of Hillsbrad
.target High Executor Darthalia
.isQuestTurnedIn 528
step
.loop 25,Hillsbrad Foothills,47.9,31.5,46.1,33.2,43.5,27.3,43.9,30.2,41.8,30.6,43.6,24.9,47.9,31.5
>>Kill |cRXP_ENEMY_Yetis|r in and around the cave at Darrow Hill. Loot them for |cFF00BCD4Helcular's Rod|r
>>|T135471:0|t[Helcular's Rod] |cRXP_WARN_has a fairly low drop rate|r
.complete 552,1 
.mob Cave Yeti
.mob Ferocious Yeti
step
#completewith next
#label Council
.goto Hillsbrad Foothills,29.63,42.33
>>Kill |cRXP_ENEMY_Hillsbrad Councilmen|r
>>|cRXP_WARN_Be careful of their Frost Nova and Frostbolt|r
.complete 532,2 
.mob Hillsbrad Councilman
.isQuestTurnedIn 529
step
>>Kill |cRXP_ENEMY_Magistrate Burnside|r inside Hillsbrad Town Hall, then loot the |cFF00BCD4Hillsbrad Town Registry|r and burn the |cRXP_PICK_Hillsbrad Proclamation|r
.complete 532,1 
.goto Hillsbrad Foothills,29.67,41.64
.complete 532,4 
.goto Hillsbrad Foothills,29.52,41.53
.complete 532,3 
.goto Hillsbrad Foothills,29.73,41.75
.isQuestTurnedIn 529
.mob Magistrate Burnside
step
.goto Hillsbrad Foothills,29.63,42.33
>>Finish killing |cRXP_ENEMY_Hillsbrad Councilmen|r
>>|cRXP_WARN_Be careful of their Frost Nova and Frostbolt|r
.complete 532,2 
.mob Hillsbrad Councilman
.isQuestTurnedIn 529
step
#completewith next
.goto Hillsbrad Foothills,62.31,20.29,125 >> Travel back to Tarren Mill
step
#requires Council
.goto Hillsbrad Foothills,62.31,20.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Darthalia|r
.turnin 532 >> Turn in Battle of Hillsbrad
.accept 539 >> Accept Battle of Hillsbrad
.target High Executor Darthalia
.isQuestTurnedIn 529
step
.goto Hillsbrad Foothills,63.88,19.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thaivand|r
.turnin 552 >> Turn in Helcular's Revenge
.target Novice Thaivand
step << Hunter
#completewith next
.goto Hillsbrad Foothills,62.55,19.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kayren|r
.vendor >> |cRXP_BUY_Fill your quiver with arrows|r
.target Kayren Soothallow
step
.goto Hillsbrad Foothills,62.76,19.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Shay|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Shay
step
.goto Hillsbrad Foothills,26.95,59.55,100 >> Run to Azurelode Mine
.isOnQuest 546
step
#completewith Hacket
>>Kill |cRXP_ENEMY_Hillsbrad|r mobs. Loot them for their |cFF00BCD4Skulls|r
.complete 546,1 
.isOnQuest 546
step
#completewith next
.goto Hillsbrad Foothills,31.8,52.5,60,0
.goto Hillsbrad Foothills,29.7,55.7,60,0
.goto Hillsbrad Foothills,31.1,58.6,60,0
.goto Hillsbrad Foothills,31.8,52.5,60,0
.goto Hillsbrad Foothills,29.7,55.7,60,0
.goto Hillsbrad Foothills,31.1,58.6,60,0
.goto Hillsbrad Foothills,31.8,52.5,60,0
.goto Hillsbrad Foothills,29.7,55.7,60,0
.goto Hillsbrad Foothills,31.1,58.6,60,0
.goto Hillsbrad Foothills,31.8,52.5
>>Kill |cRXP_ENEMY_Miner Hackett|r
.complete 567,3 
.unitscan Miner Hackett
.isQuestTurnedIn 528
step
.goto Hillsbrad Foothills,31.21,56.01
>>Kill |cRXP_ENEMY_Foreman Bonds|r and |cRXP_ENEMY_Hillsbrad Miners|r
>>|cRXP_ENEMY_Foreman Bonds|r |cFFFCDC00is located in the center of the mine's lowest floor|r
.complete 539,1 
.complete 539,2 
.isQuestTurnedIn 528
step
#label Hacket
.goto Hillsbrad Foothills,31.8,52.5,60,0
.goto Hillsbrad Foothills,29.7,55.7,60,0
.goto Hillsbrad Foothills,31.1,58.6,60,0
.goto Hillsbrad Foothills,31.8,52.5,60,0
.goto Hillsbrad Foothills,29.7,55.7,60,0
.goto Hillsbrad Foothills,31.1,58.6,60,0
.goto Hillsbrad Foothills,31.8,52.5,60,0
.goto Hillsbrad Foothills,29.7,55.7,60,0
.goto Hillsbrad Foothills,31.1,58.6,60,0
.goto Hillsbrad Foothills,31.8,52.5
>>Kill |cRXP_ENEMY_Miner Hackett|r
.complete 567,3 
.unitscan Miner Hackett
.isQuestTurnedIn 528
step
.goto Hillsbrad Foothills,29.69,58.03,15,0
.goto Hillsbrad Foothills,28.17,57.27,15,0
.goto Hillsbrad Foothills,26.48,58.74,15,0
.goto Hillsbrad Foothills,27.39,59.38,15,0
.goto Hillsbrad Foothills,27.48,57.60,15,0
.goto Hillsbrad Foothills,28.06,55.12,15,0
.goto Hillsbrad Foothills,28.33,53.10,15,0
.goto Hillsbrad Foothills,31.15,54.73
>>Finish killing |cRXP_ENEMY_Hillsbrad|r mobs. Loot them for their |cFF00BCD4Skulls|r
.complete 546,1 
.isQuestTurnedIn 528
step
.goto Alterac Mountains,46.51,81.74,50,0
.goto Alterac Mountains,48.86,82.87,50,0
.goto Alterac Mountains,48.78,80.96,50,0
.goto Alterac Mountains,56.38,66.23,50,0
.goto Alterac Mountains,57.85,69.74,50,0
.goto Alterac Mountains,59.14,69.36,50,0
.goto Alterac Mountains,59.53,66.50,50,0
.goto Alterac Mountains,58.30,66.67,50,0
.goto Alterac Mountains,48.86,82.87
>>Kill |cRXP_ENEMY_Syndicate Thieves|r and |cRXP_ENEMY_Syndicate Footpads|r. Loot them for a |cFF00BCD4Syndicate Missive|r
.complete 533,1 
.mob Syndicate Footpad
.mob Syndicate Thief
step
.goto Hillsbrad Foothills,62.11,19.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Samsa|r
.turnin 546 >> Turn in Souvenirs of Death
.target Deathguard Samsa
step
.goto Hillsbrad Foothills,62.31,20.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Darthalia|r
.turnin 567 >> Turn in Dangerous!
.turnin 539 >> Turn in Battle of Hillsbrad
.accept 541 >> Accept Battle of Hillsbrad
.target High Executor Darthalia
.group
step
.goto Hillsbrad Foothills,62.31,20.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Darthalia|r
.turnin 567 >> Turn in Dangerous!
.turnin 539 >> Turn in Battle of Hillsbrad
.target High Executor Darthalia
step
.goto Hillsbrad Foothills,63.24,20.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krusk|r
.turnin 533 >> Turn in Infiltration
.target Krusk
step << Hunter
.goto Hillsbrad Foothills,62.55,19.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kayren|r
.vendor >> |cRXP_BUY_Fill your quiver with arrows|r
.target Kayren Soothallow
step
.goto Hillsbrad Foothills,62.79,19.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Shay|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Shay
step
#completewith RaisingSpirits
.skill herbalism,70 >>If you have 125 Alchemy, gather two |T134181:0|t[Bruiseweed] and two |T134412:0|t[Briarthorn]
>>|cRXP_WARN_Gather enough materials to grind Alchemy to 125 if it's close. Otherwise, skip this step. Save two Briarthorn and two Bruiseweed for the Elixir of Agony questline|r
.collect 2453,2 
.collect 2450,2 
.skill alchemy,<125,1
step
.goto Hillsbrad Foothills,64.67,60.01,20,0
.goto Hillsbrad Foothills,63.02,61.19,20,0
.goto Hillsbrad Foothills,63.45,62.50,20,0
.goto Hillsbrad Foothills,64.68,62.01
>>Loo the |cRXP_PICK_White Mushrooms|r around Nethander Stead for |cFF00BCD4Mudsnout Blossoms|r
.complete 509,1 
step
.goto Arathi Highlands,20.19,29.54
.zone Arathi Highlands >> Travel to Arathi Highlands
.zoneskip Arathi Highlands
step
.goto Arathi Highlands,31.91,41.15,50,0
.goto Arathi Highlands,35.53,40.93,50,0
.goto Arathi Highlands,35.51,44.26,50,0
.goto Arathi Highlands,34.40,44.25,12,0
.goto Arathi Highlands,31.08,43.68,12,0
.goto Arathi Highlands,34.40,44.25,12,0
.goto Arathi Highlands,35.51,44.26
>>Kill |cRXP_ENEMY_Boulderfist Ogres|r and |cRXP_ENEMY_Boulderfist Enforcers|r in and around Boulder'gor
.complete 676,1 
.complete 676,2 
.mob Boulderfist Ogre
.mob Boulderfist Enforcer
step
.goto Arathi Highlands,54.20,38.20
>>Kill |cRXP_ENEMY_Marcel|r. Loot him for his |cFF00BCD4Head|r
>>|cRXP_WARN_He uses Shield Wall after a few seconds|r
.complete 1164,2 
.unitscan Marcel Dabyrie
step
.goto Arathi Highlands,56.40,36.10
>>Kill |cRXP_ENEMY_Kenata|r. Loot her for her |cFF00BCD4Head|r
>>|cRXP_WARN_This can be quite hard. Be very careful|r << Rogue/Warrior/Shaman
.complete 1164,1 
.unitscan Kenata Dabyrie
step
.goto Arathi Highlands,56.50,38.70
>>Kill |cRXP_ENEMY_Fardel|r. Loot him for his |cFF00BCD4Head|r
>>|cRXP_WARN_Be careful of his high-damage poison and|r |T132152:0|t[Thrash]
.complete 1164,3 
.unitscan Fardel Dabyrie
step
#completewith next
.goto Arathi Highlands,73.52,33.20,150 >> Travel to Hammerfall
step
.goto Arathi Highlands,73.10,32.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urda|r
.fp Hammerfall >> Get the Hammerfall flight path
.target Urda
step
.goto Arathi Highlands,74.20,33.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drum Fel|r
.turnin 676 >> Turn in The Hammer May Fall
.accept 677 >> Accept Call to Arms
.target Drum Fel
step
.goto Arathi Highlands,72.90,34.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gor'mul|r
.accept 655 >> Accept Hammerfall
.target Gor'mul
step
.goto Arathi Highlands,73.84,32.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Adegwa|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Adegwa
step
.goto Arathi Highlands,74.60,36.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 655 >> Turn in Hammerfall
.accept 672 >> Accept Raising Spirits
.accept 671 >> Accept Foul Magics
.target Tor'gan
step
#completewith WitherbarkTrolls
+Keep an eye out for |cFFFF5722Nimar the Slayer|r (rare). He can drop powerful BoEs
.unitscan Nimar the Slayer
step
#completewith next
.goto Arathi Highlands,66.68,62.96,150 >> Travel to Witherbark Village
step
#label WitherbarkTrolls
.loop 25,Arathi Highlands,71.7,60.3,73.4,65.2,70.6,69.3,68.3,74.5,66.2,69.2,64.8,73.1,61.3,72.4,63.3,67.7,66.5,63.7,71.7,60.3
>>Travel southeast to Witherbark Village, then kill |cRXP_ENEMY_Witherbark Witch Doctors|r, |cRXP_ENEMY_Headhunters|r, and |cRXP_ENEMY_Axe Throwers|r
>>|cRXP_WARN_This next quest can be quite hard, be extra careful|r
.complete 677,3 
.complete 677,2 
.complete 677,1 
.mob Witherbark Axe Thrower
.mob Witherbark Headhunter
.mob Witherbark Witch Doctor
step
#completewith xpgate
>>Kill any |cRXP_ENEMY_Highland Raptor|r that you encounter. Loot them for their |cFF00BCD4Eyes|r
>>|cRXP_WARN_Be careful of the|r |cRXP_ENEMY_Highland Trashers|r, |cRXP_WARN_as they actually|r |T132152:0|t[Thrash]
.complete 672,1 
.mob Highland Strider
.mob Highland Thrasher
step
.loop 25,Arathi Highlands,34.07,28.35,33.36,26.41,31.79,26.47,30.83,27.49,31.01,29.58,32.32,30.87,33.36,30.72,34.07,28.35
>>Kill |cRXP_ENEMY_Syndicate members|r. Loot them for their |cFF00BCD4Amulets|r
>>|cRXP_WARN_Be careful of Syndicate Highwaymen; they stealth around the farm's perimeter, and will backstab you if you kite/run away|r
.complete 671,1 
.mob Syndicate Pathstalker
.mob Syndicate Mercenary
.mob Syndicate Highwayman
step
#label xpgate
.goto Arathi Highlands,33.8,31.8
.xp 34+31400>> Grind to level 34.5
step
.goto Arathi Highlands,59.40,42.61
>>Finish killing |cRXP_ENEMY_Highland Raptors|r. Loot them for their |cFF00BCD4Eyes|r
>>|cRXP_WARN_Be careful of the|r |cRXP_ENEMY_Highland Trashers|r, |cRXP_WARN_as they actually|r |T132152:0|t[Thrash]
.complete 672,1 
.mob Highland Strider
.mob Highland Thrasher
step
.goto Arathi Highlands,74.24,33.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Drum|r
.turnin 677 >> Turn in Call to Arms
.target Drum Fel
step
.goto Arathi Highlands,74.72,36.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Tor'gan|r
.turnin 671 >> Turn in Foul Magics
.turnin 672 >> Turn in Raising Spirits
.accept 674 >> Accept Raising Spirits
.target Tor'gan
step
#label RaisingSpirits
.goto Arathi Highlands,72.63,33.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Gor'mul|r
.turnin 674 >> Turn in Raising Spirits
.accept 675 >> Accept Raising Spirits
.target Gor'mul
step
.goto Arathi Highlands,74.72,36.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 675 >> Turn in Raising Spirits
.target Tor'gan
step
#completewith next
.goto Arathi Highlands,73.10,32.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urda|r
.fly Tarren Mill >> Fly to Tarren Mill
.target Urda
.zoneskip Hillsbrad Foothills
step
.goto Hillsbrad Foothills,61.50,19.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Lydon|r
.turnin 509 >> Turn in Elixir of Agony
.accept 513 >> Accept Elixir of Agony
.target Apothecary Lydon
step << Mage
#completewith Thieves
.cast 3563 >>Cast |T135766:0|t[Teleport: Undercity]
.zoneskip Undercity
.itemcount 17031,1
step
#completewith next
.goto Hillsbrad Foothills,60.14,18.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zarise|r
.fly Undercity >> Fly to the Undercity
.target Zarise
.zoneskip Undercity
step
#label Thieves
.goto Undercity,63.83,49.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Genavie Callow|r
.turnin 1164 >> Turn In To Steal From Thieves
.target Genavie Callow
step
#completewith next
.skill alchemy,100 >>Grind to 125 Alchemy if you're ready. Otherwise, skip this step
.skill alchemy,125,1
step
.goto Undercity,64.12,50.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Felicia|r
.vendor >> Buy |T132793:0|t[Leaded Vial] for the Elixir of Agony questline
>>|cRXP_WARN_If you're close to 125 Alchemy and gathered extra herbs, buy enough|r |T132793:0|t[Leaded Vial] |cRXP_WARN_to grind out 125 Alchemy. Otherwise, skip this step|r
.collect 3372,1 
.target Felicia Doan
.skill alchemy,100
.isOnQuest 513
step
#completewith next
.skill alchemy,125 >>Craft one |T134858:0|t[Strong Troll's Blood Potion] for the Elixir of Agony questline
>>|cRXP_WARN_This is a 125 alchemy recipe. If you do not know it, skip this step. You'll learn it later|r
.collect 3388,1 
.isOnQuest 513
step
#ah
.goto Undercity,64.20,49.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Auctioneer Rhyker|r
.collect 3388,1 >>|cRXP_BUY_Buy one|r |T134858:0|t[Strong Troll's Blood Potion] |cRXP_BUY_from the Auction House, for the Elixir of Agony questline|r
.collect 5996,4 >>|cRXP_BUY_Buy three|r |T134797:0|t[Elixir of Water Breathing]
.target Auctioneer Rhyker
step
.goto Undercity,47.77,73.34
.skill alchemy,125 >>Craft one |T134858:0|t[Strong Troll's Blood Potion] for the Elixir of Agony questline
*|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_WARN_Talk to|r |cRXP_FRIENDLY_Doctor Herbert Halsey|r |cRXP_WARN_by the stairs to learn this recipe|r
.collect 3388,1 
.target Doctor Herbert Halsey
.isOnQuest 513
step
#ah
.goto Undercity,48.60,69.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Faranell|r
.turnin 513 >> Turn in Elixir of Agony
.accept 515 >> Accept Elixir of Agony
.target Master Apothecary Faranell
step
.goto Undercity,48.60,69.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Faranell|r
.turnin 513 >> Turn in Elixir of Agony
.accept 515 >> Accept Elixir of Agony
.target Master Apothecary Faranell
.skill alchemy,125
step
.goto Undercity,48.80,69.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Faranell|r
.turnin 513 >> Turn in Elixir of Agony
.target Master Apothecary Faranell
step << Warrior
.goto Undercity,48.32,15.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Angela|r
.train 11554 >> Train your class spells
.target Angela Curthas
.xp <34,1
.xp >36,1
step << Warrior
.goto Undercity,48.32,15.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Angela|r
.train 1680 >> Train your class spells
.target Angela Curthas
.xp <36,1
step << Rogue
.goto Undercity,83.86,72.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carolyn|r
.train 8696 >> Train your class spells
.target Carolyn Ward
.xp <34,1
.xp >36,1
step << Rogue
.goto Undercity,83.86,72.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carolyn|r
.train 8691 >> Train your class spells
.target Carolyn Ward
.xp <36,1
step << Warlock
.goto Undercity,88.93,15.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Richard|r
.train 7648 >> Train your class spells
.target Richard Kerwin
.xp <34,1
.xp >36,1
step << Warlock
.goto Undercity,88.93,15.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Richard|r
.train 2362 >> Train your class spells
.target Richard Kerwin
.xp <36,1
step << Mage
.goto Undercity,85.15,10.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anastasia|r
.train 8492 >> Train your class spells
.target Anastasia Hartwell
.xp <34,1
.xp >36,1
step << Mage
.goto Undercity,85.15,10.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anastasia|r
.train 8495 >> Train your class spells
.target Anastasia Hartwell
.xp <36,1
step << Priest
.goto Undercity,47.55,18.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lazarus|r
.train 2767 >> Train your class spells
.target Father Lazarus
.xp <34,1
.xp >36,1
step << Priest
.goto Undercity,47.55,18.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lazarus|r
.train 15264 >> Train your class spells
.target Father Lazarus
.xp <36,1
step
#completewith next
.goto Undercity,63.27,48.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Michael|r
.fly Tarren Mill >> Fly to Tarren Mill
.target Michael Garrett
.zoneskip Hillsbrad Foothills
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bel'varil|r and |cRXP_FRIENDLY_Wordeen|r
.accept 556 >> Accept Stone Tokens
.goto Hillsbrad Foothills,61.60,20.86
.accept 544 >> Accept Prison Break In
.goto Hillsbrad Foothills,61.49,20.93
.target Keeper Bel'varil
.target Magus Wordeen Voidglare
step
#completewith next
+|cRXP_WARN_This next quest can be quite hard, be extra careful!|r
step
#completewith Belamoore
>>Kill all |cRXP_ENEMY_Dalaran Humanoids|r. Loot them for their |cFF00BCD4Worn Stone Tokens|r
>>|cRXP_WARN_Be careful of |cRXP_ENEMY_Dalaran Shield Guards'|r |cRXP_WARN_glowing|r |T136173:0|t[Violet Shield Effect] |cRXP_WARN_ buff. It lasts eight seconds and returns 85 damage upon being struck in melee|r << !Mage/!Priest/!Warlock
.complete 556,1 
step
.goto Alterac Mountains,20.14,84.28,20,0
.goto Alterac Mountains,20.33,86.31,12,0
.goto Alterac Mountains,19.93,85.94
>>Kill |cRXP_ENEMY_Ricter|r, |cRXP_ENEMY_Alina|r and |cRXP_ENEMY_Dermot|r. Loot them for their |cFF00BCD4Bloodstones|r
.complete 544,2 
.complete 544,3 
.complete 544,1 
.mob Ricter
.mob Alina
.mob Dermot
step
#completewith next
.goto Alterac Mountains,18.70,84.38,10 >> Enter the western building
step
#label Belamoore
.goto Alterac Mountains,18.29,82.83,8,0
.goto Alterac Mountains,17.65,84.11,8,0
.goto Alterac Mountains,17.76,83.18
>>Kill |cRXP_ENEMY_Kegan Darkmar|r on the second floor of the building. Loot him for his |cFF00BCD4Bloodstone|r
>>|cRXP_WARN_Be careful of|r |cRXP_ENEMY_Warden Belamoore|r|cRXP_WARN_. Kill her prior to attacking|r |cRXP_ENEMY_Kegan Darkmar|r
.complete 544,4 
.mob Kegan Darkmar
.mob Warden Belamoore
step
.loop 25,Alterac Mountains,20.1,86.2,17.9,83.0,10.7,76.6,19.4,75.6,20.1,86.2,17.9,83.0,10.7,76.6,19.4,75.6,20.1,86.2
>>Finish killing the |cRXP_ENEMY_Dalaran Humanoids|r. Loot them for their |cFF00BCD4Worn Stone Tokens|r
>>|cRXP_WARN_Be careful of |cRXP_ENEMY_Dalaran Shield Guards'|r |cRXP_WARN_glowing|r |T136173:0|t[Violet Shield Effect] |cRXP_WARN_ buff. It lasts eight seconds and returns 85 damage upon being struck in melee|r << !Mage/!Priest/!Warlock
.complete 556,1 
.mob Dalaran Shield Guard
.mob Dalaran Theurgist
.mob Dalaran Worker
.mob Dalaran Summoner
step
#completewith next
.goto Hillsbrad Foothills,62.31,20.29,125 >> Travel back to Tarren Mill
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bel'varil|r and |cRXP_FRIENDLY_Wordeen|r
.turnin 556 >> Turn in Stone Tokens
.goto Hillsbrad Foothills,61.60,20.86
.turnin 544 >> Turn in Prison Break In
.goto Hillsbrad Foothills,61.49,20.93
.target Keeper Bel'varil
.target Magus Wordeen Voidglare
step
.goto Hillsbrad Foothills,62.76,20.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Humbert|r
.accept 547 >> Accept Humbert's Sword
.target Deathguard Humbert
.group
step
.loop 25,Hillsbrad Foothills,55.76,61.82,56.50,64.70,58.36,65.49,59.20,70.58,61.01,73.35,62.30,75.68,65.17,77.36,66.66,79.86,66.81,84.29,67.15,86.84,66.11,85.69,64.26,78.48,61.83,77.51,57.84,71.98,57.74,69.23,55.05,64.45,53.69,64.22,54.08,62.05,55.76,61.82
>>Travel to Southshore's eastern coast, then kill all |cRXP_ENEMY_Daggerspine Nagas|r. Loot them for their |cFF00BCD4Scales|r
>>|cRXP_WARN_Stay on the east side of the river while traveling, and be extremely cautious of|r |cFFEB144CSouthshore Guards|r |cRXP_WARN_while completing this step|r
.complete 515,3 
.unitscan Southshore Guard << Horde
.mob Daggerspine Siren
.mob Daggerspine Shorehunter
.mob Daggerspine Shorestalker
.skill alchemy,125
step
#ah
.loop 25,Hillsbrad Foothills,55.76,61.82,56.50,64.70,58.36,65.49,59.20,70.58,61.01,73.35,62.30,75.68,65.17,77.36,66.66,79.86,66.81,84.29,67.15,86.84,66.11,85.69,64.26,78.48,61.83,77.51,57.84,71.98,57.74,69.23,55.05,64.45,53.69,64.22,54.08,62.05,55.76,61.82
>>Travel to Southshore's eastern coast, then kill |cRXP_ENEMY_Daggerspine Nagas|r. Loot them for their |cFF00BCD4Scales|r
>>|cRXP_WARN_Stay on the east side of the river while traveling, and be extremely cautious of|r |cFFEB144CSouthshore Guards|r |cRXP_WARN_while completing this step|r << Horde
.complete 515,3 
.unitscan Southshore Guard << Horde
.mob Daggerspine Siren
.mob Daggerspine Shorehunter
.mob Daggerspine Shorestalker
step
.goto Hillsbrad Foothills,50.63,66.44,0
.loop 25,Hillsbrad Foothills,47.97,63.97,45.98,63.38,43.98,66.10,40.63,67.95,35.71,66.97,32.85,69.86,30.82,72.47,25.74,69.92,24.96,64.40,22.56,64.04,24.32,66.28,24.70,71.38,27.79,73.18,30.12,74.19,33.31,72.96,34.83,69.75,39.63,70.37,42.98,69.70,43.75,68.47,45.28,67.92,46.73,65.07,47.97,63.97
>>Swim to Southshore's western coast, |cRXP_WARN_keeping an extreme distance from Southshore at all times,|r then kill |cRXP_ENEMY_Torn Fin Murlocs|r. Loot them for their |cFF00BCD4Eyes|r << Horde
>>|cRXP_WARN_Keep the hills between yourself and Southshore while completing this step. A |cFFEB144CSouthshore Guard|r lingers on the southwest corner of the docks, very close to the easternmost murloc spawn, and it has a huge aggro radius|r << Horde
>>|cRXP_WARN_Be careful of|r |cRXP_ENEMY_Torn Fin Tidehunters'|r |cRXP_WARN_Frost Nova, especially near camps.|r
.complete 515,4 
.unitscan Southshore Guard << Horde
.mob Torn Fin Tidehunter
.mob Torn Fin Oracle
.mob Torn Fin Coastrunner
.mob Torn Fin Muckdweller
.skill alchemy,125
step
#ah
.goto Hillsbrad Foothills,50.63,66.44,0
.loop 25,Hillsbrad Foothills,47.97,63.97,45.98,63.38,43.98,66.10,40.63,67.95,35.71,66.97,32.85,69.86,30.82,72.47,25.74,69.92,24.96,64.40,22.56,64.04,24.32,66.28,24.70,71.38,27.79,73.18,30.12,74.19,33.31,72.96,34.83,69.75,39.63,70.37,42.98,69.70,43.75,68.47,45.28,67.92,46.73,65.07,47.97,63.97
>>Swim to Southshore's western coast, |cRXP_WARN_keeping an extreme distance from Southshore at all times,|r then kill |cRXP_ENEMY_Torn Fin Murlocs|r. Loot them for their |cFF00BCD4Eyes|r << Horde
>>|cRXP_WARN_Keep the hills between yourself and Southshore while completing this step. A |cFFEB144CSouthshore Guard|r lingers on the southwest corner of the docks, very close to the easternmost murloc spawn, and it has a huge aggro radius|r << Horde
>>|cRXP_WARN_Be careful of|r |cRXP_ENEMY_Torn Fin Tidehunters'|r |cRXP_WARN_Frost Nova, especially near camps.|r
.complete 515,4 
.unitscan Southshore Guard << Horde
.mob Torn Fin Tidehunter
.mob Torn Fin Oracle
.mob Torn Fin Coastrunner
.mob Torn Fin Muckdweller
step
.goto Hillsbrad Foothills,61.50,19.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Lydon|r
.turnin 515 >> Turn in Elixir of Agony
.target Apothecary Lydon
.isQuestComplete 515
step
.goto Hillsbrad Foothills,61.50,19.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r again
.accept 517 >> Turn in Elixir of Agony
.target Apothecary Lydon
.isQuestTurnedIn 515
.group
step
#completewith DunGarok
.goto Hillsbrad Foothills,70.76,78.14,150 >> Travel to Dun Garok
.group
step
#completewith next
>>Loot the |cFFDB2EEFKeg of Shindigger Stout|r. It has multiple spawn locations within the keep
.complete 517,1 
.isOnQuest 517
.group 5
step
#label DunGarok
.goto Hillsbrad Foothills,71.60,80.0,0
.loop 25,Hillsbrad Foothills,71.26,75.17,69.11,75.18,68.59,78.47,69.66,78.68,71.01,79.09,70.57,79.70,71.48,81.57,71.72,80.64,71.98,81.24,72.57,80.52,72.20,80.00,72.87,79.79,72.40,79.28,71.84,78.26,71.32,78.69,71.26,75.17
>>Kill |cRXP_ENEMY_Dun Garok Soldiers|r and |cRXP_ENEMY_Captain Ironhill|r. Loot them for |cFF00BCD4Humbert's Sword|r
>>|cRXP_WARN_Be careful on your way in and out of Dun Garok; there are multiple patrols on the road and in the stronghold|r
.complete 541,1 
.complete 541,2 
.complete 541,3 
.complete 541,4 
.complete 547,1 
.unitscan Captain Ironhill
.mob Dun Garok Mountaineer
.mob Dun Garok Rifleman
.mob Dun Garok Priest
.group 5
step
.loop 25,Hillsbrad Foothills,71.26,75.17,69.11,75.18,68.59,78.47,69.66,78.68,71.01,79.09,70.57,79.70,71.48,81.57,71.72,80.64,71.98,81.24,72.57,80.52,72.20,80.00,72.87,79.79,72.40,79.28,71.84,78.26,71.32,78.69,71.26,75.17
>>Loot the |cFFDB2EEFKeg of Shindigger Stout|r. It has multiple spawn locations within the keep
>>|cRXP_WARN_Be careful on your way in and out of Dun Garok; there are multiple patrols on the road and in the stronghold|r
.complete 517,1 
.isOnQuest 517
.group 5
step
.goto Hillsbrad Foothills,62.76,20.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Humbert|r
.turnin 547 >> Turn in Humbert's Sword
.target Deathguard Humbert
.group
step
.goto Hillsbrad Foothills,61.50,19.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r
.turnin 517 >> Turn in Elixir of Agony
.accept 524 >> Accept Elixir of Agony
.target Apothecary Lydon
.isOnQuest 517
.group
step
.goto Hillsbrad Foothills,62.31,20.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Darthalia|r
.turnin 541 >> Turn in Battle of Hillsbrad
.accept 550 >> Accept Battle of Hillsbrad
.target High Executor Darthalia
.group
step
.goto Hillsbrad Foothills,62.80,18.80
>>Climb to the second floor of the inn, then click on the |cRXP_PICK_Dusty Rug|r
.turnin 524 >> Turn in Elixir of Agony
.isQuestTurnedIn 517
.group
step
#completewith next
.goto Hillsbrad Foothills,60.14,18.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zarise|r
.fly Undercity >> Fly to Undercity
.target Zarise
.zoneskip Undercity
.isOnQuest 550
.group
step
.goto Undercity,56.24,92.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Varimathras|r
.turnin 550 >> Turn in Battle of Hillsbrad
.target Varimathras
.isOnQuest 550
.group
step << Druid
#completewith DruidTraining4
.cast 18960 >>Cast |T135758:0|t[Teleport: Moonglade]
.zoneskip Moonglade
step << Druid
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 1823 >> Train your class spells
.target Loganaar
.xp <34,1
.xp >36,1
step << Druid
#label DruidTraining4
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 9005 >> Train your class spells
.target Loganaar
.xp <36,1
step
#completewith next
.hs >> Hearth to Freewind Post
.use 6948
step
.goto Thousand Needles,46.07,51.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Abeqwa|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Abeqwa
step
.abandon 541 >> Battle of Hillsbrad
.isOnQuest 541
step
.abandon 547 >> Humbert's Sword
.isOnQuest 547
step
.abandon 517 >> Elixir of Agony
.isOnQuest 517
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 35-35 Shimmering Flats
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 30-40
#next 35-37 Desolace Horde
step
.goto Thousand Needles,45.70,50.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cliffwatcher Longhorn|r
.accept 5361 >> Accept Family Tree
.target Cliffwatcher Longhorn
step
.goto Thousand Needles,46.10,51.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rau|r
.accept 1197 >> Accept The Sacred Flame
.target Rau Cliffrunner
step << Hunter
.goto Thousand Needles,44.89,50.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Starn|r
.vendor >>|cFF0E8312Buy a|r |T135495:0|t[Dense Shortbow] |cFF0E8312from him if it's up|r
.target Starn
.money <2.7172
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<14.2
step << Hunter
.goto Thousand Needles,44.89,50.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Starn|r
>>|cFF0E8312Buy|r |T132382:0|t[Razor Arrows] |cFF0E8312from him|r
.collect 3030,2600,1146,1 
.target Starn
step
.goto Thousand Needles,45.15,50.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Montarr|r
.vendor >> |cRXP_BUY_Buy|r |T134831:0|t[Healing Potions] |cRXP_BUY_and|r |T134937:0|t[Scrolls] |cRXP_BUY_from him if they're up|r
.target Montarr
step
#completewith Clovenhoof2
.goto Thousand Needles,44.12,37.22,20 >>Enter the cave
step
#completewith Clovenhoof2
.goto Thousand Needles,44.44,36.32,12,0
.goto Thousand Needles,43.14,35.19,12,0
.goto Thousand Needles,42.11,34.54,12,0
.goto Thousand Needles,42.01,31.47,20 >>Travel toward the |cFFDB2EEFAncient Brazier|r
step
#label Clovenhoof2
.goto Thousand Needles,42.01,31.47
>>Open the |cFFDB2EEFAncient Brazier|r. Loot it for the |cFF00BCD4Cloven Hoof|r
>>|cFFFCDC00Be careful! The brazier is defended by two level 30|r |cFFFF5722Galak Flame Guards|r
.complete 1197,1 
.mob Galak Flame Guard
step << Shaman
#completewith next
.goto Thousand Needles,54.7,44.4,30 >> Run up the ramp here
step << Shaman
.goto Thousand Needles,53.5,42.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Prate|r
>>|cRXP_WARN_This turn-in grants a 1-hour buff with +40% move speed, +30% attack speed|r
.turnin 1531 >>Turn in Call of Air
.target Prate Cloudseer
step
.goto Thousand Needles,67.58,63.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Moktar|r
.turnin 1146 >> Turn in The Swarm Grows
.accept 1147 >> Accept The Swarm Grows
.target Moktar Krin
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kravel|r
.turnin 1112 >> Turn in Parts for Kravel
.accept 1114 >> Accept Delivery to the Gnomes
.accept 1110 >> Accept Rocket Car Parts
.target Kravel Koalbeard
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzle|r and |cRXP_FRIENDLY_Wizzle|r
.turnin 1114 >> Turn in Delivery to the Gnomes
.accept 1104 >> Accept Salt Flat Venom
.accept 1115 >> Accept The Rumormonger
.goto Thousand Needles,78.07,77.13
.accept 1105 >> Accept Hardened Shells
.goto Thousand Needles,78.14,77.12
.target Fizzle Brassbolts
.target Wizzle Brassbolts
step
.goto Thousand Needles,80.18,75.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pozzik|r
.accept 1176 >> Accept Load Lightening
.target Pozzik
step
.goto Thousand Needles,81.64,77.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zherin|r
.accept 1175 >> Accept A Bump in the Road
.target Trackmaster Zherin
step
.goto Thousand Needles,69.66,85.97,150 >> Travel to The Rustmaul Dig Site, grind mobs on the way
.isOnQuest 1147
step
#completewith next
>>Kill |cRXP_ENEMY_Silithid Invaders|r, |cRXP_ENEMY_Silithid Invaders|r and |cRXP_ENEMY_Silithid Invaders|r
>>|cFFFCDC00Be careful! They cry for help when attacked, you could accidently agro multiple nearby mobs|r
.complete 1147,3 
.complete 1147,1 
.complete 1147,2 
.mob Silithid Searcher
.mob Silithid Hive Drone
.mob Silithid Invader
step
.loop 25,Thousand Needles,67.27,85.30,68.14,85.96,68.03,86.93,68.08,88.54,69.48,89.64,70.31,87.64,71.09,86.23,71.34,84.11,70.51,82.80,68.52,80.87,67.45,82.28,67.27,85.30
>>Loot the |cRXP_ENEMY_Silithid|r mobs for a |T135034:0|t[|cFF00BCD4Cracked Silithid Carapace|r]. Use it to start the quest
.collect 5877,1,1148,1 
.accept 1148 >> Accept Parts of the Swarm
step
.loop 25,Thousand Needles,67.27,85.30,68.14,85.96,68.03,86.93,68.08,88.54,69.48,89.64,70.31,87.64,71.09,86.23,71.34,84.11,70.51,82.80,68.52,80.87,67.45,82.28,67.27,85.30
>>Kill |cRXP_ENEMY_Silithid Invaders|r, |cRXP_ENEMY_Silithid Searchers|r and |cRXP_ENEMY_Silithid Hive Drones|r. Loot them for their |cFF00BCD4Hearts|r, |cFF00BCD4Talons|r and |cFF00BCD4Carapaces|r
>>|cFFFCDC00Be careful! They cry for help when attacked, you could accidently agro multiple nearby mobs|r
.complete 1147,3 
.complete 1147,1 
.complete 1147,2 
.complete 1148,1 
.complete 1148,2 
.complete 1148,3 
.mob Silithid Searcher
.mob Silithid Hive Drone
.mob Silithid Invader
step
#completewith ShimmeringFlatsLoop
+|cRXP_WARN_Be careful!|r |cRXP_ENEMY_Salt Flats Vultures|r |cRXP_WARN_can execute. Stay above 20% health!|r
step
#completewith next
.goto Thousand Needles,67.58,63.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Moktar|r
.turnin 1147 >> Turn in The Swarm Grows
.target Moktar Krin
step
#label ShimmeringFlatsLoop
>>|cRXP_WARN_Run circles around The Shimmering Flats until all objectives are complete|r
>>Kill |cRXP_ENEMY_Salt Flats Scavengers|r and |cRXP_ENEMY_Salt Flats Vultures|r. Loot them for their |cRXP_LOOT_Bones|r
>>Kill |cRXP_ENEMY_Sparkleshell Tortoises|r, |cRXP_ENEMY_Sparkleshell Borers|r and |cRXP_ENEMY_Sparkleshell Snappers|r. Loot them for their |cRXP_LOOT_Shells|r
>>Kill |cRXP_ENEMY_Scorpid Reavers|r and |cRXP_ENEMY_Scorpid Terrors|r. Loot them for their |cRXP_LOOT_Venom|r
>>Kill |cRXP_ENEMY_Saltstone Basilisks|r, |cRXP_ENEMY_Saltstone Crystalhides|r and |cRXP_ENEMY_Saltstone Gazers|r
>>Open the |cRXP_PICK_Rocket Car Rubble|r. Loot it for the |cRXP_LOOT_Rocket Car Parts|r
.complete 1176,1 
.goto Thousand Needles,87.5,65.6,0
.complete 1105,1 
.goto Thousand Needles,82.6,54.8,0
.complete 1104,1 
.goto Thousand Needles,71.8,73.4,0
.complete 1175,1 
.goto Thousand Needles,73.5,59.9,0
.complete 1175,2 
.goto Thousand Needles,77.65,87.34,0
.complete 1175,3 
.goto Thousand Needles,77.65,87.34,0
.complete 1110,1 
.mob Salt Flats Scavenger
.mob Salt Flats Vulture
.mob Sparkleshell Snapper
.mob Sparkleshell Borer
.mob Sparkleshell Tortoise
.mob Saltstone Basilisk
.mob Saltstone Crystalhide
.mob Saltstone Gazer
.mob Scorpid Reaver
.mob Scorpid Terror
step
.goto Thousand Needles,67.58,63.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Moktar|r
.turnin 1147 >> Turn in The Swarm Grows
.target Moktar Krin
step
.goto Thousand Needles,77.79,77.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Kravel|r
.turnin 1110 >> Turn in Rocket Car Parts
.accept 5762 >> Accept Hemet Nesingwary
.target Kravel Koalbeard
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzle|r and |cRXP_FRIENDLY_Wizzle|r
.turnin 1104 >> Turn in Salt Flat Venom
.goto Thousand Needles,78.07,77.13
.turnin 1105 >> Turn in Hardened Shells
.accept 1106 >> Accept Martek the Exiled
.goto Thousand Needles,78.14,77.12
.target Fizzle Brassbolts
.target Wizzle Brassbolts
step
#ah
.goto Thousand Needles,78.14,77.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wizzle Brassbolts|r
.accept 1107 >> Accept in Encrusted Tail Fins
.target Wizzle Brassbolts
.group
step
.goto Thousand Needles,80.18,75.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pozzik|r
.turnin 1176 >> Turn in Load Lightening
.accept 1178 >> Accept Goblin Sponsorship
.target Pozzik
step
.goto Thousand Needles,81.63,77.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zherin|r
.turnin 1175 >> Turn in A Bump in the Road
.target Trackmaster Zherin
step
#completewith SetHSCampT
.goto Thousand Needles,75.44,97.37,40,0
.goto Tanaris,51.60,25.44,100 >> Travel to Gadgetzan
step
#completewith next
.goto Tanaris,51.61,25.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bulkrek|r
.fly Freewind Post >> Fly to Freewind Post
.target Bulkrek Ragefist
.zoneskip The Barrens
.isQuestComplete 1197
step
.goto Thousand Needles,46.10,51.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rau|r
.turnin 1197 >> Turn in The Sacred Flame
.target Rau Cliffrunner
.isQuestComplete 1197
step
#completewith SetHSCampT
.goto Thousand Needles,45.14,49.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Nyse|r
.fly Camp Taurajo >> Fly to Camp Taurajo
.target Nyse
.subzoneskip 484,1
step
#completewith next
.goto Tanaris,51.61,25.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bulkrek|r
.fly Camp Taurajo >> Fly to Camp Taurajo
.target Bulkrek Ragefist
.zoneskip The Barrens
step
#label SetHSCampT
.goto The Barrens,45.60,59.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Byula|r
.home >>Set your Hearthstone to Camp Taurajo
.target Innkeeper Byula
step
#completewith next
.goto The Barrens,44.45,59.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa|r
.fly Crossroads >> Fly to The Crossroads
.target Omusa Thunderhorn
step
.goto The Barrens,51.10,29.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Korran|r
.turnin 1148 >> Turn in Parts of the Swarm
.accept 1184 >> Accept Parts of the Swarm
.target Korran
step
#completewith next
.goto The Barrens,51.50,30.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Devrak|r
.fly Ratchet >> Fly to Ratchet
.target Devrak
step
.goto The Barrens,62.68,37.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zikkel|r
.bankdeposit 4306,15 >> Deposit 15 |T132905:0|t[Silk Cloth] into your bank
.target Zikkel
step
.goto The Barrens,62.68,36.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gazlowe|r
.turnin 1178 >> Turn in Goblin Sponsorship
.accept 1180 >> Accept Goblin Sponsorship
.target Gazlowe
step << Shaman
.goto The Barrens,65.83,43.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Islen|r
.turnin 96 >>Turn in Call of Water
.target Islen Waterseer
step
.goto The Barrens,63.30,38.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dizzywig|r
.turnin 1111 >> Turn in Wharfmaster Dizzywig

.target Wharfmaster Dizzywig
step
#completewith next
.goto The Barrens,63.74,38.66
.zone Stranglethorn Vale >> Take the boat to Stranglethorn Vale
.zoneskip Stranglethorn Vale
step
.goto Stranglethorn Vale,26.30,73.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lozgil|r
.turnin 1180 >> Turn in Goblin Sponsorship
.accept 1181 >> Accept Goblin Sponsorship
.target Wharfmaster Lozgil
step << Warrior/Shaman
.goto Stranglethorn Vale,28.34,75.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Zarena|r|cRXP_BUY_. Buy a|r |T135158:0|t[Big Stick] |cRXP_BUY_or a|r |T135144:0|t[Staff of Protection] |cRXP_BUY_from her if one of them is available|r
.collect 12251,1,1115,1 
.collect 12252,1,1115,1 
.money <5.3896
.target Zarena Cromwind
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<25.6
step
.goto Stranglethorn Vale,27.10,77.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crank|r inside the inn
.accept 605 >> Accept Singing Blue Shards
.target Crank Fizzlebub
step << Rogue
.goto Stranglethorn Vale,26.82,77.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ian|r on the second floor of the inn
.train 8696 >> Train your class spells
.target Ian Strom
.xp <34,1
.xp >36,1
step << Rogue
.goto Stranglethorn Vale,26.82,77.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ian|r on the second floor of the inn
.train 8691 >> Train your class spells
.target Ian Strom
.xp <36,1
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krazek|r and |cRXP_FRIENDLY_Kebok|r on the third floor of the inn
.turnin 1115 >> Turn in The Rumormonger
.accept 201 >> Accept Investigate the Camp
.goto Stranglethorn Vale,26.94,77.21
.accept 189 >> Accept Bloodscalp Ears
.accept 213 >> Accept Hostile Takeover
.goto Stranglethorn Vale,27.00,77.13
.target Krazek
.target Kebok
step
.goto Stranglethorn Vale,27.20,76.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Baron|r on the third floor balcony
.turnin 1181 >> Turn in Goblin Sponsorship
.accept 1182 >> Accept Goblin Sponsorship
.target Baron Revilgaz
step
.goto Stranglethorn Vale,26.90,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gringer|r around the corner of the balcony
.fp Booty Bay >> Get the Booty Bay flight path
.target Gringer
step
.goto Stranglethorn Vale,28.14,78.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Glyx|r
.vendor >> |cRXP_BUY_Buy|r |T134832:0|t[Greater Healing Potions] |cRXP_BUY_from him if they're up|r
.target Glyx Brewright
step
.goto Stranglethorn Vale,28.30,77.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drizzlik|r
.accept 575 >> Accept Supply and Demand
.target Drizzlik
step
#completewith next
.hs >> Hearth back to Camp Taurajo
.use 6948
step
.goto The Barrens,44.45,59.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa|r
.fly Thunder Bluff >> Fly to Thunder Bluff
.target Omusa Thunderhorn
.zoneskip Thunder Bluff
step
.goto Thunder Bluff,45.81,64.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Pala|r
.home >>Set your Hearthstone to Thunder Bluff
.target Innkeeper Pala
step << Druid
.goto Thunder Bluff,76.46,27.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Turak|r
.train 1823 >>Train your class spells
.target Turak Runetotem
.xp <34,1
.xp >36,1
step << Druid
.goto Thunder Bluff,76.46,27.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Turak|r
.train 1823 >>Train your class spells
.target Turak Runetotem
.xp <36,1
step << Hunter
.goto Thunder Bluff,59.11,86.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 13552 >>Train your class spells
.target Urek Thunderhorn
.xp <34,1
.xp >36,1
step << Hunter
.goto Thunder Bluff,59.11,86.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 14284 >>Train your class spells
.target Urek Thunderhorn
.xp <36,1
step << Hunter
.goto Thunder Bluff,54.08,84.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hesuwa|r
.train 24560 >>Train your pet spells
.target Hesuwa Thunderhorn
.xp <36,1
step << Warrior
.goto Thunder Bluff,57.56,85.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ker|r
.train 11554 >>Train your class spells
.target Ker Ragetotem
.xp <34,1
.xp >36,1
step << Warrior
.goto Thunder Bluff,57.56,85.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ker|r
.train 1680 >> Train your class spells
.target Ker Ragetotem
.xp <36,1
step << Shaman
.goto Thunder Bluff,22.84,21.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 16314 >>Train your class spells
.target Tigor Skychaser
.xp <34,1
.xp >36,1
step << Shaman
.goto Thunder Bluff,22.84,21.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 10412 >>Train your class spells
.target Tigor Skychaser
.xp <36,1
step << Priest
.goto Thunder Bluff,24.56,22.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malakai|r
.train 2767 >> Train your class spells
.target Malakai Cross
.xp <34,1
.xp >36,1
step << Priest
.goto Thunder Bluff,24.56,22.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malakai|r
.train 15264 >> Train your class spells
.target Malakai Cross
.xp <36,1
step << Mage
.goto Thunder Bluff,25.18,20.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thurston|r
.train 8492 >> Train your class spells
.target Thurston Xane
.xp <34,1
.xp >36,1
step << Mage
.goto Thunder Bluff,25.18,20.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thurston|r
.train 8495 >> Train your class spells
.target Thurston Xane
.xp <36,1
step
.goto Thunder Bluff,47.00,49.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tal|r
.fly Sun Rock >> Fly to Stonetalon Mountains
.target Tal
.zoneskip Stonetalon Mountains
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 37-39 Northern Stranglethorn
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 30-40
#next 39-39 Dustwallow Marsh
step
.goto Stranglethorn Vale,32.20,28.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Aggro'gosh|r
.accept 568 >> Accept The Defense of Grom'gol
.target Commander Aggro'gosh
step
.goto Stranglethorn Vale,32.20,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kin'weelay|r
.accept 596 >> Accept Bloody Bone Necklaces
.target Kin'weelay
step
.goto Stranglethorn Vale,32.20,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nimboya|r
.accept 581 >> Accept Hunt for Yenniku
.target Nimboya
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Barnil|r, |cRXP_FRIENDLY_Hemet|r, |cRXP_FRIENDLY_Ajeck|r and |cRXP_FRIENDLY_S. J. Erlgadin|r
.accept 583 >> Accept Welcome to the Jungle
.goto Stranglethorn Vale,35.66,10.53
.turnin 583 >> Turn in Welcome to the Jungle
.turnin 5762 >> Turn in Hemet Nesingwary
.turnin 5763 >> Turn in Hunting in Stranglethorn
.accept 194 >> Accept Raptor Mastery
.goto Stranglethorn Vale,35.66,10.81
.accept 185 >> Accept Tiger Mastery
.goto Stranglethorn Vale,35.62,10.62
.accept 190 >> Accept Panther Mastery
.goto Stranglethorn Vale,35.56,10.55
.target Barnil Stonepot
.target Hemet Nesingwary
.target Ajeck Rouack
.target Sir S. J. Erlgadin
step
#completewith YoungPanthers
>>Kill |cRXP_ENEMY_River Crocolisks|r along the river. Loot them for their |cFF00BCD4Skin|r
.complete 575,1 
.mob River Crocolisk
step
#completewith YoungPanthers
>>Kill |cRXP_ENEMY_Young Stranglethorn Tigers|r
.complete 185,1 
.mob Young Stranglethorn Tiger
step
#label YoungPanthers
.goto Stranglethorn Vale,36.82,10.25,60,0
.goto Stranglethorn Vale,36.66,11.88,60,0
.goto Stranglethorn Vale,37.70,14.44,60,0
.goto Stranglethorn Vale,39.26,14.53,60,0
.goto Stranglethorn Vale,41.01,13.63,60,0
.loop 25,Stranglethorn Vale,41.48,13.18,42.29,13.14,43.06,12.26,42.86,10.49,41.99,10.21,41.04,9.37,40.26,10.04,39.96,11.55,40.42,12.35,40.96,13.65,41.48,13.18
>>Kill |cRXP_ENEMY_Young Panthers|r
.complete 190,1 
.mob Young Panther
step << Warrior
.loop 25,Stranglethorn Vale,43.99,11.95,44.73,11.46,45.21,11.05,45.19,9.53,44.83,8.60,43.91,8.74,43.50,9.72,43.95,10.50,43.99,11.95
>>Travel to the Kurzen Compound. Kill |cRXP_LOOT_Kurzen Medicine Men|r. Loot them for their |T134413:0|t[Liferoot]
>>|cRXP_WARN_Jungle Fighters and Medicine Men share spawns, so you'll have to kill both|r
.collect 3357,8 
.mob Kurzen Jungle Fighter
.mob Kurzen Medicine Man
step
#completewith next
>>Kill |cRXP_ENEMY_River Crocolisks|r along the river. Loot them for their |cFF00BCD4Skin|r
.complete 575,1 
.mob River Crocolisk
step
.goto Stranglethorn Vale,38.82,14.20,60,0
.goto Stranglethorn Vale,37.04,13.94,60,0
.goto Stranglethorn Vale,35.58,12.38,60,0
.goto Stranglethorn Vale,33.59,12.20,60,0
.goto Stranglethorn Vale,32.67,10.15,60,0
.goto Stranglethorn Vale,31.42,8.48,60,0
.goto Stranglethorn Vale,33.47,10.25,60,0
.goto Stranglethorn Vale,34.07,11.34
>>Kill |cRXP_ENEMY_Young Stranglethorn Tigers|r
.complete 185,1 
.mob Young Stranglethorn Tiger
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ajeck|r and |cRXP_FRIENDLY_S. J. Erlgadin|r
.turnin 185 >> Turn in Tiger Mastery
.accept 186 >> Accept Tiger Mastery
.goto Stranglethorn Vale,35.62,10.62
.turnin 190 >> Turn in Panther Mastery
.accept 191 >> Accept Panther Mastery
.goto Stranglethorn Vale,35.56,10.55
.target Ajeck Rouack
.target Sir S. J. Erlgadin
step
#completewith RaptorsPart1
>>Kill |cRXP_ENEMY_River Crocolisks|r along the river. Loot them for their |cFF00BCD4Skin|r
.complete 575,1 
.mob River Crocolisk
step
.loop 25,Stranglethorn Vale,31.0,11.2,29.7,8.9,28.4,12.3,28.8,13.6,28.5,16.9,30.6,13.9,31.0,11.2
>>Kill |cRXP_ENEMY_Panthers|r and |cRXP_ENEMY_Stranglethorn Tigers|r
.complete 191,1 
.complete 186,1 
.mob Panther
.mob Stranglethorn Tiger
step
#label RaptorsPart1
.loop 25,Stranglethorn Vale,28.08,15.41,27.82,16.35,27.18,16.81,26.28,16.70,25.39,16.33,23.71,15.44,25.69,15.71,26.61,15.85,27.24,15.14,27.80,14.33,28.08,15.41
>>Kill |cRXP_ENEMY_Stranglethorn Raptors|r
.complete 194,1 
.mob Stranglethorn Raptor
step
#completewith next
.goto Stranglethorn Vale,35.55,10.55,80 >> Return to Nesingwary's Expedition
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_S. J. Erlgadin|r, |cRXP_FRIENDLY_Ajeck|r and |cRXP_FRIENDLY_Hemet|r
.turnin 191 >> Turn in Panther Mastery
.accept 192 >> Accept Panther Mastery
.goto Stranglethorn Vale,35.55,10.55
.turnin 186 >> Turn in Tiger Mastery
.accept 187 >> Accept Tiger Mastery
.goto Stranglethorn Vale,35.61,10.62
.turnin 194 >> Turn in Raptor Mastery
.accept 195 >> Accept Raptor Mastery
.goto Stranglethorn Vale,35.66,10.81
.target Sir S. J. Erlgadin
.target Ajeck Rouack
.target Hemet Nesingwary
step
.goto Stranglethorn Vale,32.4,8.8,90,0
.goto Stranglethorn Vale,34.4,8.2,90,0
.goto Stranglethorn Vale,36.8,10.4,90,0
.goto Stranglethorn Vale,39.8,11.4,90,0
.goto Stranglethorn Vale,39.8,14.4
.line Stranglethorn Vale,32.4,8.8,34.4,8.2,36.8,10.4,39.8,11.4,39.8,14.4
>>Kill |cRXP_ENEMY_River Crocolisks|r along the river. Loot them for their |cFF00BCD4Skin|r
.complete 575,1 
.mob River Crocolisk
step
#completewith next
>>Kill every |cRXP_ENEMY_Stranglethorn Tigers|r that you encounter
.complete 187,1 
.mob Stranglethorn Tiger
step
.loop 25,Stranglethorn Vale,33.9,15.6,33.2,13.7,28.8,19.6,29.8,19.4,30.6,18.9,33.9,15.6
>>Kill |cRXP_ENEMY_Bloodscalp Trolls|r. Loot them for their |cFF00BCD4Tusks|r
.complete 581,1 
.mob Bloodscalp Warrior
.mob Bloodscalp Axe Thrower
.mob Bloodscalp Shaman
step
.loop 25,Stranglethorn Vale,32.1,15.8,31.4,18.4,31.8,20.0,34.2,17.6,32.1,15.8
>>Finish killing |cRXP_ENEMY_Stranglethorn Tigers|r
.complete 187,1 
.mob Stranglethorn Tiger
step
.loop 25,Stranglethorn Vale,31.9,20.9,30.4,24.7,32.5,23.4,34.1,25.5,36.0,26.8,38.9,25.1,38.1,28.1,31.9,20.9
>>Kill |cRXP_ENEMY_Lashtail Raptors|r
>>|cRXP_WARN_Be careful of their stun and disarm|r
.complete 568,1 
.complete 195,1 
.mob Lashtail Raptor
step
#completewith next
.goto Stranglethorn Vale,32.2,27.8,80 >> Return to Grom'gol Base Camp
step
.goto Stranglethorn Vale,32.2,27.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nimboya|r
.turnin 581 >> Turn in Hunt for Yenniku
.accept 582 >> Accept Headhunting
.target Nimboya
step
.goto Stranglethorn Vale,32.20,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kin'weelay|r
.accept 629 >> Accept The Vile Reef
.target Kin'weelay
step
.goto Stranglethorn Vale,32.17,28.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Aggro'gosh|r
.turnin 568 >> Turn in The Defense of Grom'gol
.accept 569 >> Accept The Defense of Grom'gol
.target Commander Aggro'gosh
step << Hunter
.goto Stranglethorn Vale,31.55,27.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uthok|r
>>|cFF0E8312Buy|r |T132382:0|t[Razor Arrows] |cFF0E8312from him|r
.collect 3030,2600,629,1 
.target Uthok
step << Hunter
.goto Stranglethorn Vale,31.23,28.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kragg|r
.train 14303 >>Train your class spells
.target Kragg
.xp <36,1
.xp >38,1
step << Hunter
.goto Stranglethorn Vale,31.23,28.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kragg|r
.train 14320 >>Train your class spells
.target Kragg
.xp <38,1
step
#completewith next
.goto Stranglethorn Vale,24.77,22.85
>>|TInterface/GossipFrame/HealerGossipIcon:0|tLoot the |cRXP_PICK_Gri'lek the Wanderer|r for the |cFF00BCD4Tablet Shard|r
.complete 629,1 
.group 3
step
#ah
.loop 25,Stranglethorn Vale,24.92,23.59,23.40,24.49,23.71,25.90,25.46,25.61,25.31,24.59,26.8,26.0
.use 5996 >>Drink an |T134797:0|t[Elixir of Water Breathing]
>>Kill |cRXP_ENEMY_Saltscale Murlocs|r. Loot them for their |cFF00BCD4Tail Fins|r
.complete 1107,1 
.mob Saltscale Forager
.mob Saltscale Warrior
.mob Saltscale Hunter
.mob Saltscale Oracle
.mob Saltscale Tide Lord
.itemcount 5996,1
.group 3
step
.goto Stranglethorn Vale,24.77,22.85
>>|TInterface/GossipFrame/HealerGossipIcon:0|tLoot the |cRXP_PICK_Gri'lek the Wanderer|r for the |cFF00BCD4Tablet Shard|r
>>|cFFFCDC00There are two Tablets located on either side of the wall. Loot the one on the outside of the wall. This way you won't agro any of the elite|r |cRXP_ENEMY_Saltscale Murlocs|r
.complete 629,1 
step
.loop 25,Stranglethorn Vale,27.37,18.62,25.94,18.20,24.84,17.26,23.22,16.89,23.21,18.35,24.80,18.98,26.97,19.78,27.37,18.62
>>Kill |cRXP_ENEMY_Crystal Spine Basilisks|r. Loot them for their |cFF00BCD4Crystal Shards|r
>>|cRXP_WARN_You have to go back and forth here forcing dynamic respawns|r
.complete 605,1 
.mob Crystal Spine Basilisk
step << Warrior
.loop 25,Stranglethorn Vale,20.38,13.94,20.81,12.74,21.00,10.81,20.06,11.88,19.36,11.81,19.67,13.31,20.38,13.94
>>Kill |cRXP_ENEMY_Bloodscalp Trolls|r. Loot them for their |cFF00BCD4Ears|r, |cFF00BCD4Heads|r, |cFF00BCD4Necklaces|r and |cFF00BCD4Tusks|r
>>|T133730:0|t[Shrunken Heads] |cRXP_WARN_only drop from|r |cRXP_ENEMY_Bloodscalp Headhunters|r
.complete 189,1 
.complete 582,1 
.complete 596,1 
.complete 1712,2 
.mob Bloodscalp Witch Doctor
.mob Bloodscalp Berserker
.mob Bloodscalp Headhunter
step << !Warrior
.loop 25,Stranglethorn Vale,20.38,13.94,20.81,12.74,21.00,10.81,20.06,11.88,19.36,11.81,19.67,13.31,20.38,13.94
>>Kill |cRXP_ENEMY_Bloodscalp Trolls|r. Loot them for their |cFF00BCD4Ears|r, |cFF00BCD4Heads|r and |cFF00BCD4Necklaces|r
>>|T133730:0|t[Shrunken Head] |cRXP_WARN_only drop from|r |cRXP_ENEMY_Bloodscalp Headhunters|r
.complete 189,1 
.complete 582,1 
.complete 596,1 
.mob Bloodscalp Witch Doctor
.mob Bloodscalp Berserker
.mob Bloodscalp Headhunter
step
#completewith next
.goto Stranglethorn Vale,32.2,27.8,80 >> Return to Grom'gol Base Camp
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nimboya|r and |cRXP_FRIENDLY_Kin'weelay|r
.turnin 582 >> Turn in Headhunting
.goto Stranglethorn Vale,32.16,27.72
.turnin 596 >> Turn in Bloody Bone Necklaces
.turnin 629 >> Turn in The Vile Reef
.goto Stranglethorn Vale,32.27,27.70
.target Nimboya
.target Kin'weelay
step
.goto Stranglethorn Vale,32.5,29.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thysta|r
.fly Booty Bay >> Fly to Booty Bay
.target Thysta
step
.goto Stranglethorn Vale,28.29,77.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drizzlik|r
.turnin 575 >> Turn in Supply and Demand
.accept 577 >> Accept Some Assembly Required
.target Drizzlik
step
.goto Stranglethorn Vale,28.14,78.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Glyx|r
.vendor >> |cRXP_BUY_Buy|r |T134832:0|t[Greater Healing Potions] |cRXP_BUY_from him if they're up|r
.target Glyx Brewright
step
.goto Stranglethorn Vale,26.87,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gringer|r
.fly Grom'gol >> Fly to Grom'gol Base Camp
.target Gringer
step
.goto Stranglethorn Vale,32.12,29.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Far Seer Mok'thardin|r
.accept 570 >> Accept Mok'thardin's Enchantment
.target Far Seer Mok'thardin
step
.loop 25,Stranglethorn Vale,36.49,31.61,37.28,30.96,38.04,29.61,36.88,29.69,35.60,30.62,36.49,31.61
>>Kill |cRXP_ENEMY_Mosh'Ogg Brutes|r and |cRXP_ENEMY_Mosh'Ogg Witch Doctors|r
>>|cRXP_WARN_Kill|r |cRXP_ENEMY_Snapjaw Crocolisks|r |cRXP_WARN_while waiting for respawns|r
.complete 569,1 
.complete 569,2 
.mob Mosh'Ogg Brute
.mob Mosh'Ogg Witch Doctor
step
.goto Stranglethorn Vale,38.0,32.4,50,0
.goto Stranglethorn Vale,38.8,28.4,50,0
.goto Stranglethorn Vale,40.4,24.4,50,0
.goto Stranglethorn Vale,40.4,22.8,50,0
.goto Stranglethorn Vale,39.4,21.6,50,0
.goto Stranglethorn Vale,39.8,16.6,50,0
.goto Stranglethorn Vale,42.6,17.2,50,0
.line Stranglethorn Vale,38.0,32.4,38.8,28.4,40.4,24.4,40.4,22.8,39.4,21.6,39.8,16.6,42.6,17.2
>>Kill |cRXP_ENEMY_Snapjaw Crocolisk|r along the river. Loot them for their |cFF00BCD4Skin|r
.complete 577,1 
.mob Snapjaw Crocolisk
step
#completewith CozzleBl
>>Kill |cRXP_ENEMY_Venture Co. Geologists|r. Loot them for their |cFF00BCD4Crystals|r
.complete 213,1 
.mob Venture Co. Geologist
step
.goto Stranglethorn Vale,42.74,18.04,40,0
.goto Stranglethorn Vale,42.10,18.33,12,0
.goto Stranglethorn Vale,42.29,18.98,12,0
.goto Stranglethorn Vale,42.51,18.82,12,0
.goto Stranglethorn Vale,42.66,18.36
>>Climb to the oil rig's top level, then kill |cRXP_ENEMY_Foreman Cozzle|r. Loot him for his |cFF00BCD4Key|r
.collect 5851,1 
.unitscan Foreman Cozzle
step
#label CozzleBl
.goto Stranglethorn Vale,43.33,20.33
>>|TInterface/GossipFrame/HealerGossipIcon:0|tEnter the house next to the lumber mill, then loot |cRXP_PICK_Cozzle's Footlocker|r for the |cFF00BCD4Blueprints|r
.complete 1182,1 
step
.loop 25,Stranglethorn Vale,36.49,31.61,37.28,30.96,38.04,29.61,36.88,29.69,35.60,30.62,36.49,31.61
>>Return to the Mizjah Ruins and finish killing |cRXP_ENEMY_Mosh'Ogg Brutes|r and |cRXP_ENEMY_Mosh'Ogg Witch Doctors|r
.complete 569,1 
.complete 569,2 
.mob Mosh'Ogg Brute
.mob Mosh'Ogg Witch Doctor
step
.loop 25,Stranglethorn Vale,43.26,21.05,42.58,22.00,43.78,22.80,44.42,23.55,45.38,23.28,46.29,23.45,46.26,21.94,47.02,20.02,46.67,19.13,46.34,18.00,45.27,17.76,44.89,16.79,44.44,16.19,43.60,15.80,43.39,17.63,43.65,19.32,43.26,21.05
>>Finish killing |cRXP_ENEMY_Venture Co. Geologists|r. Loot them for their |cFF00BCD4Crystals|r
.complete 213,1 
.mob Venture Co. Geologist
step
.loop 25,Stranglethorn Vale,43.26,21.05,42.58,22.00,43.78,22.80,44.42,23.55,45.38,23.28,46.29,23.45,46.26,21.94,47.02,20.02,46.67,19.13,46.34,18.00,45.27,17.76,44.89,16.79,44.44,16.19,43.60,15.80,43.39,17.63,43.65,19.32,43.26,21.05
.xp 38+40400 >> Grind to 38.5
step
#completewith ShadowPanthers
>>Kill |cRXP_ENEMY_Stranglethorn Tigresses|r. Loot them for a |cFF00BCD4Pristine Tigress Fang|r
.complete 570,2 
.mob Stranglethorn Tigress
step
#ah
#completewith next
.use 10592 >>Consume your |T134816:0|t[Catseye Elixir] to find the |cRXP_ENEMY_Shadowmaw Panthers|r more easily
step
#label ShadowPanthers
.loop 25,Stranglethorn Vale,47.64,22.47,48.08,23.54,48.82,23.91,49.58,25.41,50.29,24.76,50.25,23.37,50.26,21.44,49.29,19.84,48.33,19.99,47.75,21.21,47.64,22.47
>>Kill |cRXP_ENEMY_Shadowmaw Panthers|r. Loot them for their |cFF00BCD4Claws|r
>>|cRXP_WARN_These are stealthed mobs. Search any vacant areas|r
.complete 570,1 
.complete 192,1 
.unitscan Shadowmaw Panther
step
.loop 25,Stranglethorn Vale,47.64,22.47,48.08,23.54,48.82,23.91,49.58,25.41,50.29,24.76,50.25,23.37,50.26,21.44,49.29,19.84,48.33,19.99,47.75,21.21,47.64,22.47
>>Kill |cRXP_ENEMY_Stranglethorn Tigresses|r. Loot them for a |cFF00BCD4Pristine Tigress Fang|r
.complete 570,2 
.mob Stranglethorn Tigress
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_S. J. Erlgadin|r, |cRXP_FRIENDLY_Ajeck|r and |cRXP_FRIENDLY_Hemet|r
.turnin 192 >> Turn in Panther Mastery
.goto Stranglethorn Vale,35.55,10.55
.turnin 187 >> Turn in Tiger Mastery
.accept 188 >> Accept Tiger Mastery
.goto Stranglethorn Vale,35.61,10.62
.turnin 195 >> Turn in Raptor Mastery
.accept 196 >> Accept Raptor Mastery
.goto Stranglethorn Vale,35.66,10.81
step
.goto Stranglethorn Vale,32.2,17.4
>>Kill |cRXP_ENEMY_Sin'Dall|r. Loot him for his |cFF00BCD4Paw|r
>>|cRXP_WARN_Sin'Dall is either atop the plateau, or patrolling its base|r
.complete 188,1 
.unitscan Sin'Dall
step
.goto Stranglethorn Vale,35.61,10.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ajeck|r
.turnin 188 >> Turn in Tiger Mastery
.target Ajeck Rouack
step
#completewith next
.goto Stranglethorn Vale,32.2,27.8,80 >> Return to Grom'gol Base Camp
step
.goto Stranglethorn Vale,32.16,27.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nimboya|r
.accept 638 >> Accept Trollbane
.target Nimboya
step
.goto Stranglethorn Vale,32.17,28.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Aggro'gosh|r
.turnin 569 >> Turn in The Defense of Grom'gol
.target Commander Aggro'gosh
step
.goto Stranglethorn Vale,32.12,29.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Far Seer Mok'thardin|r
.turnin 570 >> Turn in Mok'thardin's Enchantment
.target Far Seer Mok'thardin
step
.goto Stranglethorn Vale,32.5,29.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thysta|r
.fly Booty Bay >> Fly to Booty Bay
.target Thysta
step
.goto Stranglethorn Vale,27.23,76.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Baron Revilgaz|r
.turnin 1182 >> Turn in Goblin Sponsorship
.accept 1183 >> Accept Goblin Sponsorship
.target Baron Revilgaz
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kebok|r and |cRXP_FRIENDLY_Krazek|r
.turnin 189 >> Turn in Bloodscalp Ears
.turnin 213 >> Turn in Hostile Takeover
.goto Stranglethorn Vale,27.0,77.13
.turnin 201 >> Turn in Investigate the Camp
.accept 209 >> Accept Skullsplitter Tusks
.goto Stranglethorn Vale,26.95,77.21
.target Kebok
.target Krazek
step
.goto Stranglethorn Vale,27.12,77.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crank Fizzlebub|r on the inn's lowest level
.turnin 605 >> Turn in Singing Blue Shards
.accept 600 >> Accept Venture Company Mining
.target Crank Fizzlebub
step
.goto Stranglethorn Vale,28.29,77.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drizzlik|r
.turnin 577 >> Turn in Some Assembly Required
.accept 628 >> Accept Excelsior
.target Drizzlik
step << Druid
#completewith DruidTraining5
.cast 18960 >>Cast |T135758:0|t[Teleport: Moonglade]
.zoneskip Moonglade
step << Druid
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 5201 >> Train your class spells
.target Loganaar
.xp <38,1
.xp >40,1
step << Druid
#label DruidTraining5
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 9634 >> Train your class spells
.target Loganaar
.xp <40,1
step
#completewith next
.hs >> Hearth to Orgrimmar
.use 6948
.zoneskip Orgrimmar
step
.goto Orgrimmar,54.10,68.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Gryshka|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Gryshka
step
.goto Orgrimmar,57.57,52.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xen'to|r
.vendor >>Buy three [Soothing Spices]
.collect 3713,3 
.target Xen'to
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 8413 >> Train your class spells
.target Pephredo
.xp <38,1
.xp >40,1
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 8423 >> Train your class spells
.target Pephredo
.xp <40,1
step << Mage
.goto Orgrimmar,38.70,85.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r at the top of the hut
.train 11417 >> Train |T135744:0|t[Portal: Orgrimmar]
.target Thuul
.xp <40,1
step << Mage
.goto Orgrimmar,45.43,56.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Horthus|r|cRXP_BUY_. Buy two or more|r |T134419:0|t[Rune of Teleportation] |cRXP_BUY_and optionally one or more|r |T134421:0|t[Rune of Portals] |cRXP_BUY_from him|r
.collect 17031,2 
.collect 17032,1 
.target Horthus
.xp <40,1
step << Mage
.goto Orgrimmar,45.43,56.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Horthus|r|cRXP_BUY_. Buy two or more|r |T134419:0|t[Rune of Teleportation] |cRXP_BUY_from him|r
.collect 17031,2 
.target Horthus
.xp >40,1
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 10391 >> Train your class spells
.target Kardris Dreamseeker
.xp <38,1
.xp >40,1
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 8134 >> Train your class spells
.target Kardris Dreamseeker
.xp <40,1
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 8621 >> Train your class spells
.target Ormok
.xp <38,1
.xp >40,1
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 8624 >> Train your class spells
.target Ormok
.xp <40,1
step << Rogue
.goto Orgrimmar,42.10,49.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Rekkul|r|cRXP_BUY_. Buy |r |T134387:0|t[Flash Powder] |cRXP_BUY_from him|r
.collect 5140,20,2479,1 
.target Rekkul
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 11711 >> Train your class spells
.target Mirket
.xp <38,1
.xp >40,1
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 11733 >> Train your class spells
.target Mirket
.xp <40,1
step << Warlock
.goto Orgrimmar,47.52,46.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kurgul|r
.vendor >>Buy any pet upgrades you can afford
.target Kurgul
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 8820 >> Train your class spells
.target Grezz Ragefist
.xp <38,1
.xp >40,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 20660 >> Train your class spells
.target Grezz Ragefist
.xp <40,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14320 >> Train your class spells
.target Ormak Grimshot
.xp <38,1
.xp >40,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14324 >> Train your class spells
.target Ormak Grimshot
.xp <40,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 6078 >> Train your class spells
.target Ur'kyo
.xp <38,1
.xp >40,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 8106 >> Train your class spells
.target Ur'kyo
.xp <40,1
step
#ah
.goto Orgrimmar,55.59,62.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Auctioneer Thathung|r
.collect 3853,1 >>|cRXP_BUY_Buy one|r |T135326:0|t[Moonsteel Broadsword] |cRXP_BUY_from the Auction House|r
.target Auctioneer Thathung
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 39-39 Dustwallow Marsh
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 30-40
#next 39-41 Alterac/Arathi
step
.goto Orgrimmar,45.120,63.889
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Doras|r
.fly Brackenwall Village >>Fly to Brackenwall Village
.target Doras
.zoneskip Dustwallow Marsh
step
.abandon 629 >> Abandon The Vile Reef
.isOnQuest 629
step
#label Hoofprints
.goto Dustwallow Marsh,29.71,47.65
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Hoofprints|r on the ground
.accept 1268 >> Accept Suspicious Hoofprints
step
#label Badge
.goto Dustwallow Marsh,29.83,48.24
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Theramore Guard Badge|r on the plank of wood
.accept 1269 >> Accept Lieutenant Paval Reethe
step
.goto Dustwallow Marsh,29.63,48.60
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Black Shield|r above the fireplace
.accept 1251 >> Accept The Black Shield
step << skip
.goto Dustwallow Marsh,35.5,32.0
.fp Brackenwall >>Get the Brackenwall Village flight path

step
.goto Dustwallow Marsh,35.21,30.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nazeer|r
.accept 1201 >> Accept Theramore Spies
.target Nazeer Bloodpike
step
.goto Dustwallow Marsh,36.41,31.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krog|r
.turnin 1268 >> Turn in Suspicious Hoofprints
.turnin 1269 >> Turn in Lieutenant Paval Reethe
.target Krog
step
.goto Dustwallow Marsh,36.41,31.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krog|r
.turnin 1251 >> Turn in The Black Shield
.accept 1321 >> Accept The Black Shield
.target Krog
step
.goto Dustwallow Marsh,36.50,30.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Do'gol|r
.turnin 1321 >> Turn in The Black Shield
.accept 1322 >> Accept The Black Shield
.target Do'gol
step
#requires Badge
.goto Dustwallow Marsh,35.15,38.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mudcrush|r
.accept 1177 >> Accept Hungry!
.target Mudcrush Durtfeet
step
#completewith Infiltrator
>>Kill |cRXP_ENEMY_Darkfang Spiders|r. Loot them for their |cFF00BCD4Venom Sacs|r
>>|cRXP_WARN_Bloodfen Raptors share spawn with Darkfang spiders, so kill them too|r
.complete 1322,1 
.mob Darkfang Lurker
.mob Darkfang Spider
.mob Darkfang Venomspitter
step
.goto Dustwallow Marsh,40.96,36.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ogron|r, then start his escort quest
.accept 1273 >> Accept Questioning Reethe
>>|cFFFCDC00Be careful! This quest is hard|r
.target Ogron
step
.goto Dustwallow Marsh,42.50,38.00
>>Four mobs will spawn when you reach the camp. They will attack after their roleplay
>>|cFFFCDC00Let|r |cRXP_FRIENDLY_Ogron|r |cFFFCDC00aggro one and use your cooldowns to kill the other three|r
.complete 1273,1 
.target Ogron
step
#completewith next
>>Kill any |cRXP_ENEMY_Theramore Infiltrator|r you encounter
>>|cRXP_WARN_They are stealthed|r
.complete 1201,1 
.unitscan Theramore Infiltrator
step
.goto Dustwallow Marsh,46.90,17.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_"Stinky" Ignatz|r, then start his escort
.accept 1270 >> Accept Stinky's Escape
.target "Stinky" Ignatz
step
>>|cRXP_WARN_While escorting|r |cRXP_FRIENDLY_Stinky|r|cRXP_WARN_, be mindful that Bloodfen Screechers call for help around 33% HP|r
.complete 1270,1 
.target "Stinky" Ignatz
.mob Bloodfen Screecher
step
.goto Dustwallow Marsh,55.43,26.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_"Swamp Eye" Jarl|r
.accept 1218 >> Accept Soothing Spices
.turnin 1218 >> Turn in Soothing Spices
.accept 1206 >> Accept Jarl Needs Eyes
.target "Swamp Eye" Jarl
step
.goto Dustwallow Marsh,55.44,25.93
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Loose Dirt|r west of |cRXP_FRIENDLY_"Swamp Eye" Jarl's|r house
.accept 1238 >> Accept The Lost Report
step
.goto Dustwallow Marsh,56.82,22.42,50,0
.goto Dustwallow Marsh,57.80,21.30,50,0
.goto Dustwallow Marsh,57.49,16.80,50,0
.goto Dustwallow Marsh,58.29,15.47,50,0
.goto Dustwallow Marsh,57.80,21.30
>>Kill |cRXP_ENEMY_all Mirefin Murlocs|r. Loot them for their |cFF00BCD4Heads|r
.complete 1177,1 
.mob Mirefin Puddlejumper
.mob Mirefin Murloc
.mob Mirefin Coastrunner
.mob Mirefin Muckdweller
step
#completewith next
>>Kill any |cRXP_ENEMY_Theramore Infiltrator|r you encounter
>>|cRXP_WARN_They are stealthed|r
.complete 1201,1 
.unitscan Theramore Infiltrator
step
.goto Dustwallow Marsh,35.9,20.7,90,0
.goto Dustwallow Marsh,32.8,21.4,90,0
.loop 25,Dustwallow Marsh,34.4,25.2,35.9,20.7,32.8,21.4,34.4,25.2
>>Kill |cRXP_ENEMY_all Darkmist Spiders|r. Loot them for their |cFF00BCD4Eyes|r
.complete 1206,1 
.mob Darkmist Recluse
.mob Darkmist Spider
.mob Darkmist Spider
.mob Darkmist Lurker
.unitscan Darkmist Widow
step
#completewith next
>>Kill |cRXP_ENEMY_Darkfang Spiders|r. Loot them for their |cFF00BCD4Venom Sacs|r
>>|cRXP_WARN_Bloodfen Raptors share spawn with Darkfang spiders, so kill them too|r
.complete 1322,1 
.mob Darkfang Lurker
.mob Darkfang Spider
.mob Darkfang Venomspitter
step
#label Infiltrator
.goto Dustwallow Marsh,39.0,21.6,70,0
.loop 25,Dustwallow Marsh,39.7,23.9,37.6,26.9,41.0,25.5,44.2,27.4,37.9,37.4,39.0,21.6,39.7,23.9
>>Finish killing any |cRXP_ENEMY_Theramore Infiltrator|r you encounter
>>|cRXP_WARN_They are stealthed|r
.complete 1201,1 
.unitscan Theramore Infiltrator
step
.goto Dustwallow Marsh,39.96,14.10,50,0
.loop 25,Dustwallow Marsh,39.0,21.6,39.7,23.9,37.6,26.9,41.0,25.5,44.2,27.4,37.9,37.4,39.0,21.6
>>Kill |cRXP_ENEMY_Darkfang Spiders|r. Loot them for their |cFF00BCD4Venom Sacs|r
>>|cRXP_WARN_Bloodfen Raptors share spawn with Darkfang spiders, so kill them too|r
.complete 1322,1 
.mob Darkfang Lurker
.mob Darkfang Spider
.mob Darkfang Venomspitter
step
#completewith next
.goto Dustwallow Marsh,35.21,30.66,120 >> Travel back to Brackenwall Village
step
.goto Dustwallow Marsh,35.21,30.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nazeer|r
.turnin 1201 >> Turn in Theramore Spies
.turnin 1238 >> Turn in The Lost Report
.target Nazeer Bloodpike






step
.goto Dustwallow Marsh,36.50,30.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Do'gol|r
.turnin 1322 >> Turn in The Black Shield
.accept 1323 >> Accept The Black Shield
.target Do'gol
step
.goto Dustwallow Marsh,36.50,31.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krog|r
.turnin 1323 >> Turn in The Black Shield
.turnin 1273 >> Turn in Questioning Reethe
.accept 1276 >> Accept The Black Shield
.target Krog
step
.goto Dustwallow Marsh,35.20,38.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mudcrush|r
.turnin 1177 >> Turn in Hungry!
.target Mudcrush Durtfeet
step
.goto Dustwallow Marsh,55.44,25.93
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Loose Dirt|r west of |cRXP_FRIENDLY_"Swamp Eye" Jarl's|r house
.accept 1239 >> Accept The Severed Head
step
.goto Dustwallow Marsh,55.43,26.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_"Swamp Eye" Jarl|r
.turnin 1206 >> Turn in Jarl Needs Eyes
.target "Swamp Eye" Jarl
step
#ah
.goto Dustwallow Marsh,55.43,26.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_"Swamp Eye" Jarl|r
.accept 1203 >> Accept Jarl Needs a Blade
.turnin 1203 >> Turn in Jarl Needs a Blade
.target "Swamp Eye" Jarl
.itemcount 3853,1
step
#completewith next
.goto Dustwallow Marsh,35.21,30.66,120 >> Travel back to Brackenwall Village
step
.goto Dustwallow Marsh,35.30,30.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nazeer|r
.turnin 1239 >> Turn in The Severed Head
.accept 1240 >> Accept The Troll Witchdoctor
.target Nazeer Bloodpike
.isQuestTurnedIn 1238






step
#completewith next
.goto Dustwallow Marsh,35.57,31.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shardi|r
.fly Gadgetzan >> Fly to Gadgetzan
.target Shardi
.zoneskip Tanaris
step
.goto Thousand Needles,80.18,75.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pozzik|r
.turnin 1183 >> Turn in Goblin Sponsorship
.accept 1186 >> Accept The Eighteenth Pilot
.target Pozzik
step
.goto Thousand Needles,80.328,76.094
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Razzeric|r
.turnin 1186 >> Turn in The Eighteenth Pilot
.accept 1187 >> Accept Razzeric's Tweaking
.target Razzeric
step
#ah
.goto Thousand Needles,78.14,77.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wizzle|r
.turnin 1107 >> Turn in Encrusted Tail Fins
.target Wizzle Brassbolts
.group
.isQuestComplete 1107
step << Druid
#completewith DruidTraining6
.cast 18960 >>Cast |T135758:0|t[Teleport: Moonglade]
.zoneskip Moonglade
step << Druid
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 5201 >> Train your class spells
.target Loganaar
.xp <38,1
.xp >40,1
step << Druid
#label DruidTraining6
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 9634 >> Train your class spells
.target Loganaar
.xp <40,1
step << Druid
#completewith FoodAndWater
.hs >>Hearth to Orgrimmar
.use 6948
.zoneskip Orgrimmar
step << !Mage !Druid
#completewith FoodAndWater
.hs >>Hearth to Orgrimmar
.use 6948
.cooldown item,6948,>0
.zoneskip Orgrimmar
step << !Mage
#completewith FoodAndWater
.goto Tanaris,51.60,25.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bulkrek|r
.fly Orgrimmar >> Fly to Orgrimmar
.target Bulkrek Ragefist
.cooldown item,6948,<0
.zoneskip Orgrimmar
step << !Mage
#label FoodAndWater
.goto Orgrimmar,54.10,68.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Gryshka|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Gryshka
step
.abandon 1186 >> Abandon Goblin Sponsorship
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 10391 >> Train your class spells
.target Kardris Dreamseeker
.xp <38,1
.xp >40,1
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 8134 >> Train your class spells
.target Kardris Dreamseeker
.xp <40,1
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 8621 >> Train your class spells
.target Ormok
.xp <38,1
.xp >40,1
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 8624 >> Train your class spells
.target Ormok
.xp <40,1
step << Rogue
.goto Orgrimmar,42.10,49.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Rekkul|r|cRXP_BUY_. Buy |r |T134387:0|t[Flash Powder] |cRXP_BUY_from him|r
.collect 5140,20,2479,1 
.target Rekkul
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 8820 >> Train your class spells
.target Grezz Ragefist
.xp <38,1
.xp >40,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 20660 >> Train your class spells
.target Grezz Ragefist
.xp <40,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14320 >> Train your class spells
.target Ormak Grimshot
.xp <38,1
.xp >40,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14324 >> Train your class spells
.target Ormak Grimshot
.xp <40,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 6078 >> Train your class spells
.target Ur'kyo
.xp <38,1
.xp >40,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 8106 >> Train your class spells
.target Ur'kyo
.xp <40,1
step << Hunter
.goto Orgrimmar,48.13,80.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Trak'gen|r
>>|cFF0E8312Buy|r |T132382:0|t[Razor Arrows] |cFF0E8312from him|r
.collect 3030,2600,232 
.target Trak'gen
.xp >40,1
step << Hunter
.goto Orgrimmar,48.13,80.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Trak'gen|r
>>|cFF0E8312Buy|r |T135661:0|t[Jagged Arrows] |cFF0E8312from him|r
.collect 11285,2600,232 
.target Trak'gen
.xp <40,1
step << Orc !Warlock
.goto Orgrimmar,69.40,13.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kildar|r and |cRXP_FRIENDLY_Ogunaro|r
.train 825 >>Train |T136103:0|t[Wolf Riding]
.vendor >>|cRXP_BUY_Buy a|r |T132224:0|t[|cFF0070FFWolf|r]
.xp <40,1
.money <90
.skill riding,75,1
.target Kildar
.target Ogunaro
step << Troll
#completewith next
.subzone 367 >> Travel to Sen'Jin Village
step << Troll
.goto Durotar,55.28,75.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xar'Ti|r and |cRXP_FRIENDLY_Zjolnir|r
.train 10861 >>Train |T136103:0|t[Raptor Riding]
.vendor >>|cRXP_BUY_Buy a|r |T132253:0|t[|cFF0070FFRaptor|r]
.xp <40,1
.money <90
.skill riding,75,1
.target Xar'Ti
.target Zjolnir
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 11711 >> Train your class spells
.target Mirket
.xp <38,1
.xp >40,1
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.trainer >> Train your class spells
.accept 3631 >> Accept Summon Felsteed
.target Mirket
.xp <40,1
step << Warlock
.goto Orgrimmar,47.52,46.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kurgul|r
.vendor >>Buy any pet upgrades you can afford
.target Kurgul
step << Warlock
#completewith next
.goto Orgrimmar,45.13,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Ratchet >> Fly to Ratchet
.zoneskip The Barrens
.target Doras
.isOnQuest 3631
step << Warlock
.goto The Barrens,62.63,35.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Strahad Farsan|r
.turnin 3631 >> Turn in Summon Felsteed
.target Strahad Farsan
.isOnQuest 3631
step << Warlock
.goto The Barrens,63.09,37.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bragok|r
.fly Orgrimmar >> Fly to Orgrimmar
.target Bragok
.isQuestComplete 3631
.zoneskip Orgrimmar
step << Tauren
#completewith KodoRiding
.goto Orgrimmar,45.13,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Thunder Bluff >> Fly to Thunder Bluff
.zoneskip Thunder Bluff
.target Doras
step << Tauren
#completewith next
.subzone 222 >> Travel to Bloodhoof Village
step << Tauren
#label KodoRiding
.goto Mulgore,47.64,58.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xar'Ti|r and |cRXP_FRIENDLY_Zjolnir|r
.train 132245 >>Train |T136103:0|t[Kodo Riding]
.vendor >>|cRXP_BUY_Buy a|r |T132253:0|t[|cFF0070FFKodo|r]
.xp <40,1
.money <90
.skill riding,75,1
.target Kar Stormsinger
.target Harb Clawhoof
step << Tauren
.hs >>Hearth to Orgrimmar
.use 6948
.cooldown item,6948,>0
.zoneskip Orgrimmar
step << Tauren
.goto Thunder Bluff,47.00,49.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tal|r
.fly Orgrimmar >> Fly to Orgrimmar
.target Tal
.cooldown item,6948,<0
.zoneskip Orgrimmar
step
#sticky
#completewith EnterSM
.subzone 796 >> Now you should be looking for a group to Scarlet Monastery
.dungeon SM
step << !Mage
#completewith next
.zone Durotar >> Leave Orgrimmar
.zoneskip Durotar
step << !Mage
.goto Durotar,50.8,13.8,40 >>Go up the Zeppelin Tower
.zone Tirisfal Glades >>Take the Zeppelin to Undercity
.zoneskip Tirisfal Glades
step << Mage
.cast 3563 >>Cast |T135766:0|t[Teleport: Undercity]
.zoneskip Undercity
step << Mage
.goto Undercity,85.13,10.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anastasia|r
.train 8413 >> Train your class spells
.target Anastasia Hartwell
.xp <38,1
.xp >40,1
step << Mage
.goto Undercity,85.13,10.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anastasia|r
.train 8423 >> Train your class spells
.target Anastasia Hartwell
.xp <40,1
step << Mage
.goto Undercity,84.20,15.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Lexington|r
.train 11418 >> Train |T11418:0|t[Portal: Undercity]
.target Lexington Mortaim
.xp <40,1
step << Mage
.goto Undercity,82.79,15.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Hannah|r|cRXP_BUY_. Buy two or more|r |T134419:0|t[Rune of Teleportation] |cRXP_BUY_from him|r
.collect 17031,2 
.target Hannah Akeley
step
.abandon 1107 >> Abandon Encrusted Tail Fins
.isOnQuest 1107
step
.goto Undercity,56.24,92.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Varimathras|r
.accept 1048 >>Accept Into The Scarlet Monastery
.target Varimathras
.dungeon SM
step
.goto Undercity,48.80,69.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Faranell|r
.accept 1113 >> Accept Hearts of Zeal
.target Master Apothecary Faranell
.isQuestTurnedIn 1109 
.dungeon SM
step << Undead !Warlock
#completewith next
.subzone 159 >> Travel to Brill
step << Undead !Warlock
.goto Tirisfal Glades,60.09,52.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Velma|r and |cRXP_FRIENDLY_Zachariah|r
.train 10906 >>Train |T136103:0|t[Undead Horsemanship]
.vendor >>|cRXP_BUY_Buy a|r |T132264:0|t[|cFF0070FFSkeletal Horse|r]
.xp <40,1
.money <90
.skill riding,75,1
.target Velma Warnam
.target Zachariah Post
step
#label EnterSM
.goto Eastern Kingdoms,46.32,30.71,15,0
.goto Eastern Kingdoms,46.61,30.59
.zone 303 >> Enter Scarlet Monastery. Start with Library so you can loot the [|cRXP_FRIENDLY_The Scarlet Key|r] at the end
.zoneskip 304
.zoneskip 305
.dungeon SM




step << !Undead
#completewith Bosses
>>Loot the |cRXP_LOOT_Compendium of the Fallen|r
>>|cRXP_WARN_It's located in a bookshelf on the left in the last corner of the dungeon|r
.complete 1049,1 
.dungeon SM
step
#completewith Bosses
>>Loot the |cRXP_LOOT_Compendium of the Fallen|r
>>|cRXP_WARN_It's located in a bookshelf on the left in the last corner of the dungeon|r
.complete 1049,1 
.isOnQuest 1049
.dungeon SM
step
#completewith Compendium
>>Kill |cRXP_LOOT_Scarlet|r mobs. Loot them for their|cRXP_LOOT_Hearts of Zeal|r
.complete 1113 
.isOnQuest 1113
.dungeon SM
step
#label Bosses
>>Kill |cRXP_ENEMY_Houndmaster Loksey|r, |cRXP_ENEMY_Herod|r, |cRXP_ENEMY_High Inquisitor Whitemane|r and |cRXP_ENEMY_Scarlet Commander Mograine|r
>>|cRXP_ENEMY_Houndmaster Loksey|r |cRXP_WARN_is located in the Library|r
>>|cRXP_ENEMY_Herod|r |cRXP_WARN_is located in the Armory|r
>>|cRXP_ENEMY_High Inquisitor Whitemane|r |cRXP_WARN_and |cRXP_ENEMY_Scarlet Commander Mograine|r are located in the Cathedral|r
.complete 1048,4 
.complete 1048,3 
.complete 1048,1 
.complete 1048,2 
.isOnQuest 1048
.mob Houndmaster Loksey
.mob Herod
.mob High Inquisitor Whitemane
.mob Scarlet Commander Mograine
.dungeon SM
step << !Undead
#label Compendium
>>Loot the |cRXP_LOOT_Compendium of the Fallen|r
>>|cRXP_WARN_It's located in a bookshelf on the left in the last corner of the dungeon|r
.complete 1049,1 
.isOnQuest 1049
.dungeon SM
step << Mage
#completewith SMturnin
.cast 3563 >>Cast |T135766:0|t[Teleport: Undercity]
.zoneskip Undercity
.dungeon SM
step << !Mage
#completewith next
.goto Undercity,66.07,9.18,150 >> Travel to Undercity
.zoneskip Undercity
.dungeon SM
step
#label SMturnin
.goto Undercity,56.24,92.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Varimathras|r
.turnin 1048 >>Turn in Into The Scarlet Monastery
.isQuestComplete 1048
.target Varimathras
.dungeon SM
step
.goto Undercity,56.24,92.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Varimathras|r
.accept 6521 >>Accept An Unholy Alliance
.target Varimathras
.isQuestTurnedIn 6522 
.dungeon RFD
step
.goto Undercity,48.80,69.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Faranell|r
.turnin 1113 >> Turn in Hearts of Zeal
.target Master Apothecary Faranell
.isQuestComplete 1113
.dungeon SM
step
.goto Undercity,74.05,33.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Andrew|r
.accept 3341 >> Accept Bring the End
.target Andrew Brownell
.dungeon RFD
step << Mage
.cast 3566 >>Cast |T135765:0|t[Teleport: Thunder Bluff]
.zoneskip Thunder Bluff
.isQuestComplete 1049
.dungeon SM
step
.hs >> Hearth to Orgrimmar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Gryshka|r
.vendor >>|cRXP_BUY_Sell your junk, then restock food and water if necessary|r
.target Innkeeper Gryshka
.use 6948
.cooldown item,6948,>0
.zoneskip Undercity,1
.dungeon RFD
step << Mage
.cast 3567 >>Cast |T135759:0|t[Teleport: Orgrimmar]
.zoneskip Undercity,1
.cooldown item,6948,<0
.dungeon RFD
step << !Mage
.hs >> Hearth to Orgrimmar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Gryshka|r
.vendor >>|cRXP_BUY_Sell your junk, then restock food and water if necessary|r
.target Innkeeper Gryshka
.use 6948
.zoneskip Orgrimmar
.dungeon SM
.isQuestComplete 1049
step << !Mage
.goto Tirisfal Glades,61.06,58.86,12,0
.goto Tirisfal Glades,61.51,59.01,10,0
.goto Tirisfal Glades,61.27,59.22,8,0
.goto Tirisfal Glades,61.13,58.84,8,0
.goto Tirisfal Glades,61.38,58.71,8,0
.goto Tirisfal Glades,61.34,59.17,8,0
.goto Tirisfal Glades,60.51,58.69,-1
.goto Tirisfal Glades,60.94,46.35,-1
>>Go up the Zeppelin Tower
.zone Durotar >>Take the Zeppelin to Durotar
.zoneskip Orgrimmar
.cooldown item,6948,<0
.dungeon RFD
step << !Mage
#completewith next
.goto Orgrimmar,45.13,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Thunder Bluff >> Fly to Thunder Bluff
.zoneskip Thunder Bluff
.target Doras
.dungeon SM
.isQuestComplete 1049
step << !Undead
.goto Thunder Bluff,34.42,46.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sage|r
.turnin 1049 >> Turn in Compendium of the Fallen
.target Sage
.dungeon SM
.isQuestComplete 1049
step
#sticky
#completewith EnterRFD
.subzone 722 >> Now you should be looking for a group to Razorfen Downs
.dungeon RFD
step
.goto Thunder Bluff,47.00,49.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tal|r
.fly Camp Taurajo >> Fly to Camp Taurajo
.target Tal
.zoneskip Thunder Bluff,1
step
.goto Orgrimmar,45.13,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Camp Taurajo >> Fly to Camp Taurajo
.zoneskip Orgrimmar,1
.target Doras
.dungeon RFD
step
#completewith next
.goto The Barrens,46.30,90.27,200 >> Travel to Razorfen Downs
step
#completewith next
.goto The Barrens,46.30,90.27,50,0
.goto The Barrens,46.92,91.84,50,0
.goto The Barrens,48.20,92.66,50,0
>>Kill |cRXP_ENEMY_Ambassador Malcin|r. Loot him for his |cRXP_LOOT_Head|r
>>|cRXP_WARN_He can spawn at 4 different tents outside the instance|r
.complete 6521,1 
.unitscan Ambassador Malcin
.isOnQuest 6521
.dungeon RFD
step
.goto The Barrens,49.012,94.938
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Myriam Moonsinger|r
.accept 6626 >> Accept A Host of Evil
.target Myriam Moonsinger
.dungeon RFD
step
#completewith next
>>Kill |cRXP_ENEMY_Razorfen Battleguards|r, |cRXP_ENEMY_Razorfen Thornweavers|r and |cRXP_ENEMY_Death's Head Cultists|r
>>|cRXP_WARN_This quest is completed outside of the Instance|r
.complete 6626,1 
.complete 6626,2 
.complete 6626,3 
.mob Razorfen Battleguard
.mob Razorfen Thornweaver
.mob Death's Head Cultist
.isOnQuest 6626
.dungeon RFD
step
.goto The Barrens,48.57,95.69,50,0
.goto The Barrens,48.20,92.66,50,0
.goto The Barrens,46.92,91.84,50,0
.goto The Barrens,46.30,90.27,50,0
.goto The Barrens,46.92,91.84
>>Kill |cRXP_ENEMY_Ambassador Malcin|r. Loot him for his |cRXP_LOOT_Head|r
>>|cRXP_WARN_He can spawn at 4 different tents outside the instance|r
.complete 6521,1 
.unitscan Ambassador Malcin
.isOnQuest 6521
.dungeon RFD
step
>>Kill |cRXP_ENEMY_Razorfen Battleguards|r, |cRXP_ENEMY_Razorfen Thornweavers|r and |cRXP_ENEMY_Death's Head Cultists|r
>>|cRXP_WARN_This quest is completed outside of the Instance|r
.goto The Barrens,48.23,92.31,70,0
.goto The Barrens,48.15,90.57,70,0
.goto The Barrens,47.86,88.75,70,0
.goto The Barrens,46.46,90.19,70,0
.goto The Barrens,46.94,92.19,70,0
.goto The Barrens,48.23,92.31,70,0
.goto The Barrens,48.15,90.57,70,0
.goto The Barrens,47.86,88.75,70,0
.goto The Barrens,46.46,90.19,70,0
.goto The Barrens,46.94,92.19,70,0
.goto The Barrens,48.23,92.31
.complete 6626,1 
.complete 6626,2 
.complete 6626,3 
.mob Razorfen Battleguard
.mob Razorfen Thornweaver
.mob Death's Head Cultist
.isOnQuest 6626
.dungeon RFD
step
.goto The Barrens,49.012,94.938
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Myriam Moonsinger|r
.turnin 6626 >> Turn in A Host of Evil
.target Myriam Moonsinger
.isQuestComplete 6626
.dungeon RFD
step
#label EnterRFD
.goto The Barrens,49.255,93.077,0
.goto The Barrens,49.255,93.077,30,0
.goto 1414,53.26,71.18
.zone 300 >> Enter Razorfen Downs
.dungeon RFD
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Belnistrasz|r
>>|cRXP_WARN_Take the left path and stick left the entire way until you reach The Murder Pens to get to|r |cRXP_FRIENDLY_Belnistrasz|r
>>|cRXP_WARN_Do not accept Extinguishing the Idol until the rest of your party is ready as this begins the escort. Auto accept has been turned off for this step|r
.accept 3523 >> Accept Scourge of the Downs
.turnin 3523 >> Turn in Scourge of the Downs
.accept 3525,1 >> Accept Extinguishing the Idol
.target Belnistrasz
.dungeon RFD
step
>>Follow and protect |cRXP_FRIENDLY_Belnistrasz|r during his ritual
.complete 3525,1 
.target Belnistrasz
.isOnQuest 3525
.dungeon RFD
step
>>Click |cRXP_PICK_Belnistrasz's Brazier|r
.turnin 3525 >> Turn in Extinguishing the Idol
.isQuestComplete 3525
.dungeon RFD
step
>>Kill |cRXP_ENEMY_Amnennar the Coldbringer|r. Loot him for his |cRXP_LOOT_Skull|r
.complete 3341,1 
.mob Amnennar the Coldbringer
.isOnQuest 3341
.dungeon RFD
step << !Mage
.hs >> Hearth to Orgrimmar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Gryshka|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Gryshka
.use 6948
.dungeon RFD
step << Hunter
.goto Orgrimmar,48.13,80.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Trak'gen|r
>>|cFF0E8312Buy|r |T132382:0|t[Razor Arrows] |cFF0E8312from him|r
.collect 3030,2600,232 
.target Trak'gen
.xp >40,1
.dungeon RFD
step << Hunter
.goto Orgrimmar,48.13,80.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Trak'gen|r
>>|cFF0E8312Buy|r |T135661:0|t[Jagged Arrows] |cFF0E8312from him|r
.collect 11285,2600,232 
.target Trak'gen
.xp <40,1
.dungeon RFD
step << !Mage
.goto Durotar,50.53,12.52
.zone Tirisfal Glades >>Run up the Zeppelin Tower. Take the Zeppelin to Undercity
.dungeon RFD
step << Mage
.cast 3563 >>Cast |T135766:0|t[Teleport: Undercity]
.zoneskip Undercity
.dungeon RFD
step
.goto Undercity,56.24,92.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Varimathras|r
.turnin 6521 >>Turn in An Unholy Alliance
.target Varimathras
.isQuestComplete 6521
.dungeon RFD
step
.goto Undercity,74.05,33.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Andrew|r
.turnin 3341 >>Turn in Bring the End
.target Andrew Brownell
.isQuestComplete 3341
.dungeon RFD
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 39-41 Alterac/Arathi
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 30-40
#next 41-42 Badlands
step
.goto Undercity,50.15,67.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zinge|r
.accept 232 >> Accept Errand for Apothecary Zinge
.target Apothecary Zinge
step
.goto Undercity,58.61,54.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alessandro|r
.turnin 232 >> Turn in Errand for Apothecary Zinge
.accept 238 >> Accept Errand for Apothecary Zinge
.target Alessandro Luca
step
.goto Undercity,50.15,67.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zinge|r
.turnin 238 >> Turn in Errand for Apothecary Zinge
.accept 243 >> Accept Into the Field
.target Apothecary Zinge
.solo
step
.goto Undercity,50.15,67.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zinge|r
.turnin 238 >> Turn in Errand for Apothecary Zinge
.target Apothecary Zinge
.group
step << Hunter
.goto Undercity,54.71,38.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Abigail|r|cRXP_BUY_. Buy a|r |T135489:0|t[Massive Longbow] |cRXP_BUY_from her if it's available|r
.collect 11307,1,503,1 
.target Abigail Sawyer
.money <6.7952
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<21.9
step << Hunter
#completewith BracersofBinding
+Equip the |T135489:0|t[Massive Longbow] when you are level 42
.use 11307
.itemcount 11307,1
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<21.9
step << Hunter
.goto Undercity,58.66,33.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Geoffrey|r|cRXP_BUY_. Buy a|r |cRXP_BUY_Buy a|r |T135424:0|t[Great Axe] |cRXP_BUY_from him if you're melee weaving. Otherwise, skip this step|r
.collect 2531,1,503,1 
.target Geoffrey Hartwell
.money <5.0552
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<31.2
step << Hunter
#completewith BracersofBinding
+Equip the |T135424:0|t[Great Axe] when you are level 39
.use 2531
.itemcount 2531,1
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<31.2
step << Rogue
.goto Undercity,58.66,33.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Geoffrey|r|cRXP_BUY_. Buy a|r |T135344:0|t[Falchion] |cRXP_BUY_from him|r
.collect 2528,1,503,1 
.money <4.6652
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<25.6
.target Geoffrey Hartwell
step << Rogue
.goto Undercity,58.66,33.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Geoffrey|r|cRXP_BUY_. Buy a|r |T135341:0|t[Rondel] |cRXP_BUY_from him|r
.collect 2534,1,503,1 
.money <4.0888
.itemStat 17,QUALITY,<7
.itemStat 17,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<24.0
.target Geoffrey Hartwell
step << Rogue
#completewith BracersofBinding
+Equip the |T135344:0|t[Falchion] when you are level 41
.use 2528
.itemcount 2528,1
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<25.6
step << Rogue
#completewith BracersofBinding
+Equip the |T135341:0|t[Rondel] in your off-hand when you are level 39
.use 2534
.itemcount 2534,1
.itemStat 17,QUALITY,<7
.itemStat 17,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<24.0
step << Priest
.goto Undercity,69.54,26.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Zane|r|cRXP_BUY_. Buy a|r |T133718:0|t[Blackbone Wand] |cRXP_BUY_from him|r
.collect 5239,1,503,1 
.money <4.0769
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<35.3
.target Zane Bradford
step << Priest
#completewith BracersofBinding
+Equip the |T135344:0|t[Falchion] when you are level 41
.use 5239
.itemcount 5239,1
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<35.3
step << Warrior
.goto Undercity,77.48,49.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Nathaniel|r|cRXP_BUY_Buy two stacks of|r |T135424:0|t[Gleaming Throwing Axe] |cRXP_BUY_from him|r
.collect 15326,2 
.target Nathaniel Steenwick
step << Warrior
#ah
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Auctioneer Stockton|r in the Trade Quarter
>>|cRXP_BUY_If you have money leftover after buying|r |T134717:0|t[Nature Protection Potions]|cRXP_BUY_, purchase the following items:|r
.collect 4480,8 
.collect 4479,8 
.collect 4481,8 
.collect 3357,8 
.target Auctioneer Stockton
step << Warrior
#ah
.goto Undercity,71.42,46.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Auctioneer Stockton|r in the Trade Quarter
.collect 6052,2 
.target Auctioneer Stockton
step
#ah
.goto Undercity,71.42,46.69
>>|cRXP_BUY_If you have money leftover, purchase the following items:|r
.collect 3829,1 
.collect 4389,1 
.collect 929,1 
.collect 3823,1 
.collect 2868,1 
.collect 4611,9 
.collect 3404,4 
step
.goto Undercity,62.32,48.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Patrick|r
.accept 2342 >>Accept Reclaimed Treasures
.target Patrick Garrett
.group
step << Warrior
#completewith next
.goto Undercity,63.27,48.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Michael|r
.fly Hammerfall >> Fly to Hammerfall
.target Michael Garrett
.zoneskip Arathi Highlands
step << Warrior
#label Cresting
.goto Arathi Highlands,66.72,29.72
>>Kill |cRXP_ENEMY_Cresting Exiles|r. Loot them for their |T133438:0|t[Cresting Charms]
.collect 4481,8 
.mob Cresting Exile
step << Warrior
.goto Arathi Highlands,52.06,50.60
>>Kill |cRXP_ENEMY_Thundering Exiles|r. Loot them for their |T133435:0|t[Thundering Charms]
>>|cRXP_WARN_Be careful!|r |cRXP_ENEMY_Thundering Exiles|r |cRXP_WARN_have high burst damage|r
.collect 4480,8 
.mob Thundering Exile
step << Warrior
.goto Arathi Highlands,25.47,30.09
>>Kill |cRXP_ENEMY_Burning Exiles|r. Loot them for their |T133434:0|t[Burning Charms]
.collect 4479,8 
.mob Burning Exile
step << Warrior
#completewith BracersofBinding
.goto Hillsbrad Foothills,62.06,20.19,120 >> Travel to Tarren Mill
step << !Warrior
#completewith BracersofBinding
.goto Undercity,63.27,48.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Michael|r
.fly Tarren Mill >> Fly to Tarren Mill
.target Michael Garrett
.zoneskip Hillsbrad Foothills
step << !Undead
.abandon 1049 >> Compendium of the Fallen
.isOnQuest 1049
.dungeon SM
step
.abandon 1048 >> Abandon Into The Scarlet Monastery
.isOnQuest 1048
.dungeon SM
step
.abandon 1113 >> Hearts of Zeal
.isOnQuest 1113
.dungeon SM
step
.abandon 6521 >> Abandon An Unholy Alliance
.isOnQuest 6521
.dungeon RFD
step
.abandon 6626 >> Abandon A Host of Evil
.isOnQuest 6626
.dungeon RFD
step
.abandon 3341 >> Abandon Bring the End
.isOnQuest 3341
.dungeon RFD
step
#label BracersofBinding
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bel'varil|r and |cRXP_FRIENDLY_Wordeen|r
.accept 557 >> Accept Bracers of Binding
.goto Hillsbrad Foothills,61.60,20.86
.accept 545 >> Accept Dalaran Patrols
.goto Hillsbrad Foothills,61.49,20.93
.target Keeper Bel'varil
.target Magus Wordeen Voidglare
step
.goto Hillsbrad Foothills,62.62,20.74
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_WANTED: Baron Vardus|r poster next to |cRXP_FRIENDLY_Melisara|r
.accept 566 >> Accept WANTED: Baron Vardus
.target Melisara
.group
step
.goto Hillsbrad Foothills,63.20,20.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krusk|r
.accept 503 >> Accept Gol'dir
.target Krusk
step << Warrior
#completewith Whirlwind
+|cRXP_WARN_It is VERY important to watch this video on how to cheese Cyclonian for the|r |T132403:0|t[Whirlwind Axe]
.link https://www.youtube.com/watch?v=BiuWeMSHEhA >> CLICK HERE
step << Warrior
#ah
.goto Alterac Mountains,80.49,66.92
.use 6052 >>While traveling, use a [Nature Protection Potion]
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bath'rah the Windwatcher|r
.turnin 1714 >> Turn in Essence of the Exile
.target Bath'rah the Windwatcher
step << Warrior
.goto Alterac Mountains,80.49,66.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bath'rah the Windwatcher|r
.turnin 1714 >> Turn in Essence of the Exile
.target Bath'rah the Windwatcher
step << Warrior
.goto Alterac Mountains,80.49,66.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bath'rah the Windwatcher|r
.turnin 1712 >>Turn in Cyclonian
.accept 1713 >>Accept The Summoning
.target Bath'rah the Windwatcher
step << Warrior
#label Whirlwind
.goto Alterac Mountains,80.6,62.2
>>Wait for |cRXP_FRIENDLY_Bath'rah's|r roleplay, then kill |cRXP_LOOT_Cyclonian|r and loot him for his |cFF00BCD4Heart|r
>>|cRXP_WARN_Equip your|r |T135424:0|t[Gleaming Throwing Axe] |cRXP_WARN_if you haven't|r
.complete 1713,1 
.unitscan Cyclonian
step << Warrior
.goto Alterac Mountains,80.49,66.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bath'rah the Windwatcher|r and choose the |T132403:0|t[Whirlwind Axe]
.turnin 1713 >>Turn in The Summoning
.turnin 1792 >>Turn in Whirlwind Weapon
.target Bath'rah the Windwatcher
step
.goto Hillsbrad Foothills,62.63,20.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Melisara|r
.accept 518 >> Accept The Crown of Will
.target Melisara
.group
step
.goto Alterac Mountains,63.20,43.90
>>Kill |cRXP_ENEMY_Jailor Borhuin|r. Loot him for his |cRXP_LOOT_Key|r
.complete 503,1 
.unitscan Jailor Borhuin
step
.goto Alterac Mountains,60.00,43.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gol'dir|r on the second floor of the inn
.turnin 503 >> Turn in Gol'dir
.accept 506 >> Accept Blackmoore's Legacy
.target Gol'dir
step
.goto Alterac Mountains,42.7,46.6
>>Kill |cRXP_ENEMY_Crushridge Maulers|r
.complete 518,1 
.mob Crushridge Mauler
.group 3
step
#completewith next
.goto Hillsbrad Foothills,62.06,20.19,120 >> Return to Tarren Mill
.group
step
.goto Hillsbrad Foothills,62.6,20.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Melisara|r
.turnin 518 >> Turn in The Crown of Will
.accept 519 >> Accept The Crown of Will
.target Melisara
.group
step
.goto Alterac Mountains,39.49,41.82
>>Kill |cRXP_ENEMY_Glommus|r. Loot him for his |cRXP_LOOT_Head|r
.complete 519,3 
.unitscan Glommus
.group 3
step
.goto Alterac Mountains,38.61,46.78
>>Kill |cRXP_ENEMY_Muckrake|r. Loot him for his |cRXP_LOOT_Head|r
.complete 519,2 
.unitscan Muckrake
.group 3
step
.goto Alterac Mountains,39.59,52.86
>>Kill |cRXP_ENEMY_Targ|r. Loot him for his |cRXP_LOOT_Head|r
.complete 519,1 
.unitscan Targ
.group 3
step
#completewith next
.goto Hillsbrad Foothills,62.06,20.19,120 >> Return to Tarren Mill
.group
step
.goto Hillsbrad Foothills,62.63,20.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Melisara|r
.turnin 519 >> Turn in The Crown of Will
.accept 520 >> Accept The Crown of Will
.target Melisara
.group
step
.goto Alterac Mountains,35.68,54.25
>>Kill |cRXP_ENEMY_Mug'thol|r. Loot him for his |cRXP_LOOT_Head|r and for the |cRXP_LOOT_Crown of Will|r
>>|cRXP_WARN_Be very careful of|r |cRXP_ENEMY_Crushridge Warmongers|r|cRXP_WARN_, who call for help at low HP|r
.complete 520,1 
.complete 520,2 
.mob Crushridge Warmonger
.unitscan Mug'thol
.group 3
step
#completewith next
.goto Hillsbrad Foothills,62.06,20.19,120 >> Return to Tarren Mill
step
#completewith next
.goto Hillsbrad Foothills,62.76,19.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Shay|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Shay
step
.goto Hillsbrad Foothills,62.10,82.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krusk|r
.turnin 506 >> Turn in Blackmoore's Legacy
.target Krusk
step
.goto Hillsbrad Foothills,62.10,82.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krusk|r
.accept 507 >> Accept Lord Aliden Perenolde
.target Krusk
.group
step
#completewith next
.goto Alterac Mountains,42.2,77.8,90,0
.goto Alterac Mountains,46.2,78.2,90,0
>>Kill |cRXP_ENEMY_Mountain Lions|r. Loot them for a |T134368:0|t[Fresh Carcass]
>>|T134368:0|t[Fresh Carcass] |cRXP_WARN_disappears after 30 minutes|r
.collect 5810,1 
.mob Feral Mountain Lion
.mob Mountain Lion
.mob Starving Mountain Lion
.mob Hulking Mountain Lion
step
.goto Alterac Mountains,37.56,68.22
.use 5810 >> Use the |T134368:0|t[Fresh Carcass] inside Growless Cave to summon |cRXP_ENEMY_Frostmaw|r. Kill him and loot him for his |cRXP_LOOT_Mane|r

.complete 1136,1 
.unitscan Frostmaw

step
.loop 25,Alterac Mountains,10.3,78.5,20.5,75.2,21.3,53.5,17.8,56.2,21.3,53.5,20.5,75.2,10.3,78.5
>>Kill |cRXP_ENEMY_Dalaran Summoners|r and |cRXP_ENEMY_Elemental Slaves|r. Loot them for their |cRXP_LOOT_Bracers|r
.complete 545,1 
.complete 545,2 
.complete 557,1 
.mob Dalaran Summoner
.mob Elemental Slave
step
#ah
#completewith next
.use 10592 >> Use a |T134816:0|t[Catseye Elixir] as you approach Lord Aliden Perenolde's homestead
step
.goto Alterac Mountains,39.28,14.52
>>Kill |cRXP_ENEMY_Lord Aliden Perenolde|r
>>|cRXP_WARN_Be mindful of |cRXP_ENEMY_Syndicate Assassins|r|cRXP_WARN_.|r |cRXP_ENEMY_Aliden|r |cRXP_WARN_uses Power Word: Shield, casts Renew, and will sleep pets and other players|r
.complete 507,1 
.unitscan Lord Aliden Perenolde
.mob Syndicate Assassin
.group 2
step
.goto Alterac Mountains,39.30,14.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elysa|r
.turnin 507 >> Turn in Lord Aliden Perenolde
.accept 508 >> Accept Taretha's Gift
.target Elysa
.group
step
.goto Alterac Mountains,47.8,17.1,70,0
.goto Alterac Mountains,53.6,20.6,70,0
.goto Alterac Mountains,56.2,26.8,70,0
.goto Alterac Mountains,58.1,29.9,70,0
.goto Alterac Mountains,59.7,43.9
>>Search for |cRXP_ENEMY_Baron Vardus|r in each camp and the Strahnbrad's inn. Kill him and loot him for his |cRXP_LOOT_Head|r
.complete 566,1 
.unitscan Baron Vardus
.group 2
step
#completewith next
.goto Hillsbrad Foothills,62.06,20.19,120 >> Return to Tarren Mill
step
.goto Alterac Mountains,61.10,82.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_High Executor Darthalia|r
.turnin 566 >> Turn in WANTED: Baron Vardus
.target High Executor Darthalia
.group
step
.goto Alterac Mountains,62.10,82.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krusk|r
.turnin 508 >> Turn in Taretha's Gift
.target Krusk
.group
step
.goto Hillsbrad Foothills,62.63,20.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Melisara|r
.turnin 520 >> Turn in The Crown of Will
.target Melisara
.group
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wordeen|r and |cRXP_FRIENDLY_Bel'varil|r
.turnin 545 >> Turn in Dalaran Patrols
.goto Hillsbrad Foothills,61.56,20.89
.turnin 557 >> Turn in Bracers of Binding
.goto Hillsbrad Foothills,61.49,20.93
.target Magus Wordeen Voidglare
.target Keeper Bel'varil
step
.goto Hillsbrad Foothills,60.14,18.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zarise|r
.fly Hammerfall >> Fly to Hammerfall
.target Zarise
.zoneskip Arathi Highlands
step
.goto Arathi Highlands,73.80,33.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zengu|r
.turnin 638 >> Turn in Trollbane
.accept 639 >> Accept Sigil of Strom
.target Zengu
.group
step
.goto Arathi Highlands,73.80,33.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zengu|r
.turnin 638 >> Turn in Trollbane
.target Zengu
step
.goto Arathi Highlands,74.30,33.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drum Fel|r
.accept 678 >> Accept Call to Arms
.target Drum Fel
step
.goto Arathi Highlands,72.70,34.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gor'mul|r
.accept 675 >> Accept Raising Spirits
.target Gor'mul
step
.goto Arathi Highlands,74.70,36.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 675 >>Turn in Raising Spirits
.accept 701 >> Accept Guile of the Raptor
.target Tor'gan
step
.goto Arathi Highlands,62.50,33.80
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Shards of Myzrael|r
.accept 642 >> Accept The Princess Trapped
step
.goto Arathi Highlands,80.80,39.91,20,0
.goto Arathi Highlands,82.25,38.94,20,0
.goto Arathi Highlands,82.39,36.78,20,0
.goto Arathi Highlands,83.56,35.02,20,0
.goto Arathi Highlands,84.87,31.67,20,0
.goto Arathi Highlands,87.10,31.31,20,0
.goto Arathi Highlands,84.73,28.99,20,0
.goto Arathi Highlands,84.32,30.93
>>Kill |cRXP_ENEMY_Drywhisker Kobolds|r, |cRXP_ENEMY_Diggers|r and |cRXP_ENEMY_Surveyors|r. Loot them for their |cRXP_LOOT_Motes of Myzrael|r
.complete 642,1 
.mob Drywhisker Kobold
.mob Drywhisker Digger
.mob Drywhisker Surveyor
step
.goto Arathi Highlands,84.30,30.95
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Iridescent Shards|r towards the back of the cave
.turnin 642 >> Turn in The Princess Trapped
.accept 651 >> Accept Stones of Binding
step
.goto Arathi Highlands,66.70,29.80
>>|TInterface/GossipFrame/HealerGossipIcon:0|tLoot the |cRXP_PICK_Stone of East Binding|r for the |cRXP_LOOT_Cresting Key|r
>>Kill |cRXP_ENEMY_Cresting Exiles|r. Loot them for an |T134714:0|t[Elemental Water] << Shaman
>>|cRXP_ENEMY_Cresting Exiles|r |cRXP_WARN_have Frost Armor and Frost Nova|r
.complete 651,2 
.collect 7070,1 
.mob Cresting Exile
step
.goto Arathi Highlands,52.00,50.80
>>|TInterface/GossipFrame/HealerGossipIcon:0|tLoot the |cRXP_PICK_Stone of Outer Binding|r for the |cRXP_LOOT_Thundering Key|r
>>Kill |cRXP_ENEMY_Thundering Exiles|r. Loot them for an |T136107:0|t[Elemental Air] << Shaman
>>|cRXP_WARN_Be careful!|r |cRXP_ENEMY_Thundering Exiles|r |cRXP_WARN_have powerful burst damage|r
.complete 651,3 
.collect 7069,1 
.mob Thundering Exile
step
.goto Arathi Highlands,25.50,30.10
>>|TInterface/GossipFrame/HealerGossipIcon:0|tLoot the |cRXP_PICK_Stone of West Binding|r for the |cRXP_LOOT_Burning Key|r
>>Kill |cRXP_ENEMY_Burning Exiles|r. Loot them for an |T135805:0|t[Elemental Fire] << Shaman
>>|cRXP_WARN_If you find yourself in danger, use a|r |T133438:0|t[Cresting Charm] |cRXP_WARN_on|r |cRXP_ENEMY_Burning Exiles|r
.complete 651,1 
.collect 7068,1 
.mob Burning Exile
step
.goto Arathi Highlands,36.20,57.30
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Stone of Inner Binding|r
.turnin 651 >> Turn in Stones of Binding
step << Shaman
.goto Arathi Highlands,36.20,57.30
>>Kill |cRXP_ENEMY_Rumbling Exiles|r. Loot them for an |T134572:0|t[Elemental Earth]
>>You will need these for a level 50 Shaman quest later on. Bank them when you get to Orgrimmar later
.collect 7067,1 
.mob Rumbling Exile
step
.goto Arathi Highlands,36.20,57.30
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Stone of Inner Binding|r again
.accept 652 >> Accept Breaking the Keystone
.group
step
#completewith next
>>Kill |cRXP_ENEMY_Highland Fleshstalkers|r. Loot them for their |cRXP_LOOT_Hearts|r
.complete 701,1 
.mob Highland Fleshstalker
step
.goto Arathi Highlands,52.06,74.38,50,0
.goto Arathi Highlands,53.81,74.59,50,0
.goto Arathi Highlands,53.58,76.20,50,0
.goto Arathi Highlands,54.52,78.00,15,0
.goto Arathi Highlands,53.68,79.95,20,0
.goto Arathi Highlands,53.81,74.59
>>Kill |cRXP_ENEMY_Boulderfist Brutes|r and |cRXP_ENEMY_Boulderfist Magi|r
>>|cRXP_WARN_Be careful of the Magi's Frost Armor and Frost Nova|r
>>|cFFEB144CBe **EXTREMELY CAUTIOUS** of the rare spawn "Molok the Crusher" which is a non-elite that hits for 250-450|r
.complete 678,1 
.complete 678,2 
.mob Boulderfist Brute
.mob Boulderfist Magus
.unitscan Molok the Crusher
step
.goto Arathi Highlands,52.77,63.56,70,0
.goto Arathi Highlands,50.22,65.00,70,0
.goto Arathi Highlands,49.71,68.69,70,0
.goto Arathi Highlands,48.07,74.25,70,0
.goto Arathi Highlands,46.21,76.74,70,0
.goto Arathi Highlands,46.04,79.55,70,0
.goto Arathi Highlands,48.59,80.56,70,0
.goto Arathi Highlands,49.71,68.69
>>Kill |cRXP_ENEMY_Highland Fleshstalkers|r. Loot them for their |cRXP_LOOT_Hearts|r
.complete 701,1 
.mob Highland Fleshstalker
step
.goto Arathi Highlands,27.3,62.8
>>Kill |cRXP_ENEMY_Syndicate Prowlers|r, |cRXP_ENEMY_Conjurors|r, and |cRXP_ENEMY_Magi|r. Loot them for the |cRXP_LOOT_Sigil of Strom|r
>>|cRXP_WARN_It has a very low drop rate. Be careful of respawns. Be careful of|r |cRXP_ENEMY_Syndicate Prowlers|r|cRXP_WARN_, who can net and disarm|r
.complete 639,1 
.mob Syndicate Prowler
.mob Syndicate Conjuror
.mob Syndicate Magus
.group 3
step
.loop 25,Arathi Highlands,67.3,31.1,61.8,43.0,47.4,56.8,30.5,54.6,21.1,36.5,26.4,30.3,26.0,45.4,30.5,54.6,47.4,56.8,61.8,43.0,67.3,31.1
>>Kill |cRXP_ENEMY_Fozruk|r. Loot him for his |cRXP_LOOT_Rod|r
.link https://www.twitch.tv/videos/669107037?t=05h51m54s >>|TInterface/GossipFrame/HealerGossipIcon:0|tClick here for video reference. You'll want to focus |cRXP_ENEMY_Sleeby|r first
>>Consider skipping this step if you're not able to group up << !Warlock
.complete 652,1 
.unitscan Fozruk
.unitscan Znort
.unitscan Feeboz
.unitscan Sleeby
.group 3
step
#completewith next
.goto Arathi Highlands,73.52,33.20,150 >> Return to Hammerfall
step
.goto Arathi Highlands,74.70,36.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 701 >> Turn in Guile of the Raptor
.accept 702 >> Accept Guile of the Raptor
.accept 673 >> Accept Foul Magics
.target Tor'gan
.group
step
.goto Arathi Highlands,74.70,36.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 701 >> Turn in Guile of the Raptor
.accept 702 >> Accept Guile of the Raptor
.target Tor'gan
step
.goto Arathi Highlands,72.70,34.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gor'mul|r
.turnin 702 >> Turn in Guile of the Raptor
.target Gor'mul
step
.goto Arathi Highlands,74.00,33.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Korin Fel|r
.accept 680 >> Accept The Real Threat
.target Korin Fel
.group
step
.goto Arathi Highlands,73.80,33.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zengu|r
.turnin 639 >> Turn in Sigil of Strom
.accept 640 >> Accept The Broken Sigil
.target Zengu
.group
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drum Fel|r
.turnin 678 >> Turn in Call to Arms
.accept 679 >> Accept Call to Arms
.target Drum Fel
.group
step
.goto Arathi Highlands,74.20,33.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drum Fel|r
.turnin 678 >> Turn in Call to Arms
.target Drum Fel
step
.goto Arathi Highlands,72.80,34.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gor'mul|r
.accept 847 >> Accept Guile of the Raptor
.target Gor'mul
step
.goto Arathi Highlands,74.70,36.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 847 >> Turn in Guile of the Raptor
.target Tor'gan
step
.goto Arathi Highlands,36.20,57.30
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Keystone|r
>>|cRXP_WARN_Be careful of|r |cRXP_ENEMY_Rumbling Exiles'|r|cRXP_WARN_. Their stun has no diminishing return|r
.turnin 652 >> Turn in Breaking the Keystone
.accept 688 >> Accept Myzrael's Allies
.group
step
#completewith next
>>Kill |cRXP_ENEMY_Stromgarde Soldiers|r. Loot them for their |cRXP_LOOT_Sigil Fragments|r
>>|cRXP_ENEMY_Stormgarde Defenders|r |cRXP_WARN_have Shield Bash|r
.complete 640,1 
.mob Stromgarde Troll Hunter
.mob Stromgarde Defender
.mob Stromgarde Vindicator
.group 3
step
.goto Arathi Highlands,29.45,64.39,30,0
.goto Arathi Highlands,29.63,62.95
>>Kill |cRXP_ENEMY_Marez Cowl|r. Loot her for her |cRXP_LOOT_Orb|r
>>|cRXP_WARN_She has two spawn locations in the eastern side of the keep|r
.complete 673,1 
.unitscan Marez Cowl
.group 3
step
.loop 25,Arathi Highlands,23.73,60.75,23.25,63.09,22.03,63.07,21.21,63.22,21.19,60.65,22.49,59.37,22.83,58.02,23.82,57.13,24.92,57.18,27.50,57.62,27.37,58.92,24.36,58.87,23.49,59.57,23.73,60.75
>>Kill |cRXP_ENEMY_Stromgarde Soldiers|r. Loot them for their |cRXP_LOOT_Sigil Fragments|r
>>|cRXP_ENEMY_Stormgarde Defenders|r |cRXP_WARN_have Shield Bash|r
.complete 640,1 
.mob Stromgarde Troll Hunter
.mob Stromgarde Defender
.mob Stromgarde Vindicator
.group 3
step
#completewith next
>>Kill |cRXP_ENEMY_Boulderfist Shaman|r and |cRXP_ENEMY_Boulderfist Lords|r
.complete 679,1 
.complete 679,2 
.mob Boulderfist Shaman
.mob Boulderfist Lord
.group 3
step
.goto Arathi Highlands,18.74,66.30,30,0
.goto Arathi Highlands,19.6,66.9
>>Kill |cRXP_ENEMY_Or'Kalar|r. Loot him for his |cRXP_LOOT_Head|r
>>|cRXP_ENEMY_Or'Kalar|r |cRXP_WARN_can spawn in two areas around the Tower of Arathor's base|r
.complete 680,1 
.unitscan Or'Kalar
.group 3
step
.loop 25,Arathi Highlands,18.91,65.80,20.05,65.43,20.50,66.72,21.49,67.03,21.84,65.41,23.64,65.69,22.25,67.74,20.89,69.19,19.51,69.14,18.26,67.42,18.91,65.80
>>Kill |cRXP_ENEMY_Boulderfist Shaman|r and |cRXP_ENEMY_Boulderfist Lords|r
.complete 679,1 
.complete 679,2 
.mob Boulderfist Shaman
.mob Boulderfist Lord
.group 3
step
#completewith next
.goto Arathi Highlands,73.52,33.20,150 >> Return to Hammerfall
.group
step
.goto Arathi Highlands,74.70,36.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 673 >> Turn in Foul Magics
.turnin 640 >> Turn in The Broken Sigil
.accept 641 >> Accept Sigil of Thoradin
.target Tor'gan
.group
step
.goto Arathi Highlands,74.00,33.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Korin Fel|r
.turnin 680 >> Turn in The Real Threat
.target Korin Fel
.group
step
.goto Arathi Highlands,73.80,33.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zengu|r
.turnin 641 >> Turn in Sigil of Thoradin
.accept 643 >> Accept Sigil of Arathor
.target Zengu
.group
step
.goto Arathi Highlands,74.25,33.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drum Fel|r
.turnin 679 >> Turn in Call to Arms
.target Drum Fel
.group
step
.goto Arathi Highlands,73.84,32.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Adegwa|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Adegwa
step
.goto Arathi Highlands,73.41,36.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doctor Gregory Victor|r
.accept 6622 >> Accept Triage
.target Doctor Gregory Victor
.skill firstaid,<225,1
step
.goto Arathi Highlands,73.03,36.84
.use 16991 >> |cRXP_WARN_Channel the|r |T133682:0|t[Triage Bandage] |cRXP_WARN_on the |cRXP_FRIENDLY_Horde Soldiers|r. Prioritize |cRXP_FRIENDLY_Critically Injured Soldiers|r first|r
.complete 6622,1 
.target Critically Injured Horde Soldier
.target Badly Injured Horde Soldier
.target Injured Horde Soldier
.isOnQuest 6622
step
.goto Arathi Highlands,73.41,36.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doctor Gregory Victor|r
.turnin 6622 >> turnin Triage
.target Doctor Gregory Victor
.isQuestComplete 6622
step
.destroy 16991 >> Delete the |T133682:0|t[Triage Bandage]. You no longer need it
.isQuestTurnedIn 6624
step
.goto Arathi Highlands,74.40,35.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zaruk|r
.turnin 688 >> Turn in Myzrael's Allies
.accept 687 >> Accept Theldurin the Lost
.target Zaruk
.isQuestTurnedIn 652
.group
step
.goto Arathi Highlands,53.8,40.8,60,0
.goto Arathi Highlands,49.5,44.0,60,0
.goto Arathi Highlands,43.2,55.1,60,0
.goto Arathi Highlands,34.7,52.2,60,0
.goto Arathi Highlands,27.2,49.8,60,0
.goto Arathi Highlands,66.0,55.6,60,0
.goto Arathi Highlands,24.2,60.3,60,0
.goto Arathi Highlands,27.4,58.2
>>Kill |cRXP_ENEMYT_Lieutenant Valorcall|r and his two |cRXP_ENEMY_Stromgarde Cavalryman|r. Loot the Lieutenant for his |cRXP_LOOT_Sigil|r
>>|cRXP_WARN_Lieutenant Valorcall heals and uses Divine Shield. His Cavalrymen have a high-damage charge|r
.complete 643,1 
.unitscan Lieutenant Valorcall
.mob Stromgarde Cavalryman
.group 3
step
.goto Arathi Highlands,73.80,33.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zengu|r
.turnin 643 >> Turn in Sigil of Arathor
.accept 644 >> Accept Sigil of Trollbane
.target Zengu
.group
step
.goto Arathi Highlands,28.5,58.1
>>Kill |cRXP_ENEMY_Prince Galen Trollbane|r. Loot him for his |cRXP_LOOT_Sigil|r
.complete 644,1 
.unitscan Prince Galen Trollbane
.group 3
step
.goto Arathi Highlands,73.80,33.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zengu|r
.turnin 644 >> Turn in Sigil of Trollbane
.accept 645 >> Accept Trol'kalar
.target Zengu
.group
step
.goto Arathi Highlands,28.9,59.6
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick |cRXP_PICK_Trollbane's Tomb|r
.turnin 645 >> Turn in Trol'kalar
.accept 646 >> Accept Trol'kalar
.group 3
step
#completewith next
.goto Arathi Highlands,21.6,75.6,30,0
.goto Arathi Highlands,22.1,79.9,25 >> Run through the cave to Faldir's Cove
step
.goto Arathi Highlands,31.83,82.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lolo|r
.accept 663 >> Accept Land Ho!
.target Lolo the Lookout
step
.goto Arathi Highlands,32.28,81.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shakes O'Breen|r
.turnin 663 >> Turn in Land Ho!
.target Shakes O'Breen
step
.goto Arathi Highlands,32.78,81.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nilzlix|r
.accept 662 >> Accept Deep Sea Salvage
.target First Mate Nilzlix
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Steelgut|r and |cRXP_FRIENDLY_Phizzlethorpe|r
.accept 664 >> Accept Drowned Sorrows
.goto Arathi Highlands,34.00,80.79
.accept 665 >> Accept Sunken Treasure
.goto Arathi Highlands,33.87,80.55
.target Captain Steelgut
.target Professor Phizzlethorpe
step
.goto Arathi Highlands,35.7,79.7
>>Wait for |cRXP_FRIENDLY_Phizzlethorpe's|r roleplay, then kill the two |cRXP_ENEMY_Vengeful Surges|r that spawn.
>>|cRXP_WARN_These mobs are level 40. Get them off of| |cRXP_FRIENDLY_Phizzlethorpe|r |cRXP_WARN_as soon as you can|r
.complete 665,1 
.unitscan Vengeful Surge
step
.goto Arathi Highlands,33.8,80.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doctor Draxlegauge|r
.turnin 665 >> Turn in Sunken Treasure
.accept 666 >> Accept Sunken Treasure
.target Doctor Draxlegauge
step << !Druid !Warlock !Shaman
#ah
#completewith SLog
+Use your |T134797:0|t[Elixir of Water Breathing]
.use 5996 
.itemcount 5996,1
step
#sticky
#completewith Daggerspines
+|cRXP_ENEMY_Daggerspine Raiders|r |cRXP_WARN_have a Net ability, so be very careful of your breath if you haven't used an|r |T134797:0|t[Elixir of Water Breathing] << !Druid !Warlock !Shaman
+|cRXP_ENEMY_Daggerspine Raiders|r |cRXP_WARN_have a Net ability, so be sure to keep Water Breathing applied.|r << Warlock/Shaman
+|cRXP_WARN_Use Aquatic Form when your breath gets low|r << Druid
step
#completewith ElvenGems
>>Kill |cRXP_ENEMY_Daggerspine Raiders|r and |cRXP_ENEMY_Sorceresses|r
.complete 664,1 
.complete 664,2 
.mob Daggerspine Raider
.mob Daggerspine Sorceress
step
#completewith SLog
.use 4491 >>|TInterface/GossipFrame/HealerGossipIcon:0|tEquip your |T133149:0|t[Goggles of Gem Hunting]. Find |cRXP_PICK_Calcified Elven Gems|r. Loot them for |cRXP_LOOT_Elven Gems|r
.complete 666,1 
step
.goto Arathi Highlands,23.40,85.09
>>|TInterface/GossipFrame/HealerGossipIcon:0|tLoot the |cRXP_PICK_Book|r for |cRXP_LOOT_Maiden's Folly Log|r
>>|cRXP_WARN_The log is on the ship's mid-level, towards its front|r
.complete 662,2 
step
.goto Arathi Highlands,23.04,84.51
>>|TInterface/GossipFrame/HealerGossipIcon:0|tLoot the |cRXP_PICK_Unfurled Parchment|r for |cRXP_LOOT_Maiden's Folly Charts|r
>>|cRXP_WARN_The charts are on the ship's mid-level, towards its center|r
.complete 662,1 
step
.goto Arathi Highlands,20.46,85.61
>>|TInterface/GossipFrame/HealerGossipIcon:0|tLoot the |cRXP_PICK_Unfurled Parchment|r for |cRXP_LOOT_Spirit of Silverpine Charts|r
>>|cRXP_WARN_The charts are on the ship's mid-level, towards its front, on a crate next to a cannon|r
.complete 662,3 
step
#label SLog
.goto Arathi Highlands,20.65,85.10
>>|TInterface/GossipFrame/HealerGossipIcon:0|tLoot the |cRXP_PICK_Book|r for |cRXP_LOOT_Spirit of Silverpine Log|r
>>|cRXP_WARN_The log is on the ship's lowest-level, towards its front, laying in dirt|r
.complete 662,4 
step
#label ElvenGems
.loop 25,Arathi Highlands,19.3,84.1,17.7,89.5,25.5,90.8,24.1,85.7,23.2,89.7,19.3,84.1,17.7,89.5,25.5,90.8,24.1,85.7,23.2,89.7,19.3,84.1
.use 4491 >>|TInterface/GossipFrame/HealerGossipIcon:0|tEquip your |T133149:0|t[Goggles of Gem Hunting]. Find |cRXP_PICK_Calcified Elven Gems|r. Loot them for |cRXP_LOOT_Elven Gems|r
.complete 666,1 
step
#label Daggerspines
.loop 25,Arathi Highlands,21.05,84.62,23.44,84.76,25.38,86.03,23.14,89.88,21.55,86.67,18.75,85.31,19.76,84.00,21.05,84.62
>>Finish killing |cRXP_ENEMY_Daggerspine Raiders|r and |cRXP_ENEMY_Sorceresses|r
.complete 664,1 
.complete 664,2 
.mob Daggerspine Raider
.mob Daggerspine Sorceress
step
#completewith next
+|cRXP_WARN_Re-equip your usual helm, then manually skip this step.|r
step
#requires ElvenGems
.goto Arathi Highlands,32.77,81.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nilzlix|r
.turnin 662 >> Turn in Deep Sea Salvage
.target First Mate Nilzlix
step
.goto Arathi Highlands,33.86,80.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Draxlegauge|r
.turnin 666 >> Turn in Sunken Treasure
.accept 668 >> Accept Sunken Treasure
.target Doctor Draxlegauge
step
.goto Arathi Highlands,34.00,80.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Steelgut|r
.turnin 664 >> Turn in Drowned Sorrows
.target Captain Steelgut
step
.goto Arathi Highlands,32.28,81.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shakes O'Breen|r
.turnin 668 >> Turn in Sunken Treasure
.accept 669 >> Accept Sunken Treasure
.target Shakes O'Breen
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 41-42 Badlands
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 40-50
#next 42-43 Stranglethorn Vale
step
#completewith WetlandsLogoutSkip
.goto Wetlands,32.78,13.12
.zone Wetlands >> Swim to Wetlands
step
.abandon 566 >> Abandon WANTED: Baron Vardus
.isOnQuest 566
step
.abandon 518 >> Abandon The Crown of Will
.isOnQuest 518
step
.abandon 519 >> Abandon The Crown of Will
.isOnQuest 519
step
.abandon 520 >> Abandon The Crown of Will
.isOnQuest 520
step
.abandon 507 >> Abandon Lord Aliden Perenolde
.isOnQuest 507
step
.abandon 639 >> Abandon Sigil of Strom
.isOnQuest 639
step
.abandon 652 >> Abandon Breaking the Keystone
.isOnQuest 652
step
.abandon 673 >> Abandon Foul Magics
.isOnQuest 673
step
.abandon 680 >> Abandon The Real Threat
.isOnQuest 680
step
.abandon 640 >> Abandon The Broken Sigil
.isOnQuest 640
step
.abandon 679 >> Abandon Call to Arms
.isOnQuest 679
step
.abandon 643 >> Abandon Sigil of Arathor
.isOnQuest 643
step
#label WetlandsLogoutSkip
.goto Wetlands,53.86,46.42,150,0
.goto Wetlands,63.9,78.6
.zone Loch Modan >> Logout on top of the mushrooms at the back of the cave. When you log back in, this will teleport you should be just outside of Thelsamar
.link https://www.youtube.com/watch?v=21CuGto26Mk >> CLICK HERE for a video tutorial
>>|cRXP_WARN_After logging in at Thelsamar, run southwest to the other side of the road to avoid the guards. Be VERY careful not to move forward when you log in as it's likely to aggro the level 30-40 guards.|r
.unitscan Mountaineer Stenn
.unitscan Mountaineer Kamdar
step
#completewith next
.goto Loch Modan,25.34,67.27,0
.goto Loch Modan,24.76,70.59,30,0
.goto Loch Modan,25.10,72.98,30,0
.goto Loch Modan,26.11,75.42,30,0
.goto Loch Modan,23.27,81.30,30,0
.goto Loch Modan,22.82,84.81,30,0
.goto Loch Modan,19.59,87.23,30,0
.goto Loch Modan,20.37,91.08,30,0
.goto Loch Modan,22.33,91.55,30,0
.goto Loch Modan,22.87,94.92,30,0
.goto Badlands,5.73,29.78,0
>>Use the shortcut to get to Badlands faster
.zone Badlands >> Run to the Badlands
.link https://www.youtube.com/watch?v=oNFXup-DCM0 >> CLICK HERE for a video tutorial
step
.goto Badlands,3.99,44.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gorrik|r
.fp Kargath >> Get the Kargath Flight Path
.target Gorrik
step
.goto Badlands,2.90,47.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sranda|r
.vendor >>|cRXP_BUY_Sell your junk and repair, if necessary|r
.target Sranda
step
.goto Badlands,2.91,45.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gorn|r
.accept 782 >> Accept Broken Alliances
.target Gorn
.group
step
.goto Badlands,2.42,46.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jarkal Mossmeld|r
.accept 2258 >> Accept Badlands Reagent Run
.target Jarkal Mossmeld
step
.goto Badlands,6.4,47.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Neeka Bloodscar|r
.accept 1419 >> Accept Coyote Thieves
.target Neeka Bloodscar
step
#ah
.goto Badlands,25.95,44.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lotwil|r
.accept 713 >> Accept Coolant Heads Prevail
.turnin 713 >> Turn in Coolant Heads Prevail
.target Lotwil Veriatus
.itemcount 3829,1 
step
#ah
.goto Badlands,25.95,44.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lotwil|r
.accept 714 >> Accept Gyro... What?
.turnin 714 >> Turn in Gyro... What?
.target Lotwil Veriatus
.itemcount 4389,1 
.isQuestTurnedIn 713
step
#ah
.goto Badlands,25.82,44.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lucien|r
.accept 715 >> Accept Liquid Stone
.turnin 715 >> Turn in Liquid Stone
.itemcount 929,1 
.itemcount 3823,1 
.isQuestTurnedIn 714
step
#ah
.goto Badlands,25.82,44.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lucien|r
.accept 716 >> Accept Stone Is Better than Cloth
.turnin 716 >> Turn in Stone Is Better than Cloth
.target Lucien Tosselwrench
.itemcount 2868,1 
.isQuestTurnedIn 714
step
.goto Badlands,25.95,44.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lotwil|r
.accept 710 >> Accept Study of the Elements: Rock
.target Lotwil Veriatus
step
#completewith badlandsall
>>While questing, kill any |cRXP_ENEMY_Buzzards|r and |cRXP_ENEMY_Coyotes|r you encounter. Loot them for their |cRXP_LOOT_Wings|r, |cRXP_LOOT_Gizzards|r, |cRXP_LOOT_Jawbones|r and |cRXP_LOOT_Fangs|r
>>|cRXP_WARN_Don't focus on this. You can complete it later|r
.complete 703,1 
.complete 2258,1 
.complete 1419,1 
.complete 2258,2 
.mob Buzzard
.mob Giant Buzzard
.mob Starving Buzzard
.mob Crag Coyote
.mob Feral Crag Coyote
.mob Rabid Crag Coyote
.mob Elder Crag Coyote
step
.loop 25,Badlands,23.41,45.26,21.90,43.22,19.99,43.10,17.76,41.06,16.62,38.29,14.78,37.34,13.48,37.80,13.01,40.09,15.11,41.89,16.94,42.80,19.17,45.74,20.47,48.40,23.12,48.20,23.41,45.26
>>Kill |cRXP_ENEMY_Earth Elementals|r. Loot them for their |cRXP_LOOT_Stone Shard|r and |cRXP_LOOT_Elemental Shard|r
.complete 710,1 
.complete 2258,3 
.mob Lesser Rock Elemental
.mob Rock Elemental
.mob Enraged Rock Elemental
.mob Greater Rock Elemental
step
#label badlandsall
.goto Badlands,25.95,44.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lotwil Veriatus|r
.turnin 710 >> Turn in Study of the Elements: Rock
.accept 711 >> Accept Study of the Elements: Rock
.target Lotwil Veriatus
step
#completewith next
>>Kill |cRXP_ENEMY_Coyotes|r. Loot them for their |cRXP_LOOT_Jawbones|r and |cRXP_LOOT_Fangs|r
.complete 1419,1 
.complete 2258,2 
.mob Buzzard
.mob Giant Buzzard
.mob Starving Buzzard
.mob Crag Coyote
.mob Feral Crag Coyote
.mob Rabid Crag Coyote
.mob Elder Crag Coyote
step
.loop 25,Badlands,17.24,58.53,15.35,58.51,14.85,60.16,15.00,61.98,16.15,61.84,17.01,61.24,17.24,58.53
>>Kill |cRXP_ENEMY_Buzzards|r. Loot them for their |cRXP_LOOT_Wings|r
.complete 703,1 
.mob Buzzard
.mob Giant Buzzard
.mob Starving Buzzard
step
#completewith badlands3
>>Kill |cRXP_ENEMY_Coyotes|r and |cRXP_ENEMY_Buzzards|r. Loot them for their |cRXP_LOOT_Jawbones|r, |cRXP_LOOT_Fangs|r and |cRXP_LOOT_Gizzards|r
>>|cRXP_WARN_Prioritize|r |cRXP_ENEMY_Coyotes|r |cRXP_WARN_over|r |cRXP_ENEMY_Buzzards|r
.complete 1419,1 
.complete 2258,2 
.complete 2258,1 
.mob Buzzard
.mob Giant Buzzard
.mob Starving Buzzard
.mob Crag Coyote
.mob Feral Crag Coyote
.mob Rabid Crag Coyote
.mob Elder Crag Coyote
step
.goto Badlands,42.47,52.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jazzrik|r
.vendor >>|cRXP_BUY_Sell your junk and repair, if necessary|r
.target Jazzrik
step
#ah
.goto Badlands,42.39,52.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rigglefuzz|r
.accept 705 >> Accept Pearl Diving
.turnin 705 >> Turn in Pearl Diving
.target Rigglefuzz
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rigglefuzz|r and |cRXP_FRIENDLY_Martek|r
.accept 703 >> Accept Barbecued Buzzard Wings
.turnin 703 >> Turn in Barbecued Buzzard Wing
.goto Badlands,42.39,52.92
.turnin 1106 >> Turn in Martek the Exiled
.accept 1108 >> Accept Indurium
.goto Badlands,42.21,52.70
.target Rigglefuzz
.target Martek the Exiled
step
#sticky
#label signofearthBL
>>Find & kill |cRXP_ENEMY_Boss Tho'grun|r. Loot him for the |cRXP_LOOT_Sign of Earth|r
>>|cRXP_LOOT_Boss Tho'grun|r |cRXP_WARN_patrols the zone, accompanied by five guards.|r
.complete 782,1 
.unitscan Boss Tho'grun
.mob Dustbelcher Mystic
.mob Dustbelcher Wyrmhunter
.mob Dustbelcher Shaman
.mob Dustbelcher Mauler
.isOnQuest 782
.group 3
step
.loop 25,Badlands,36.2,75.1,46.0,78.4,42.8,87.2,36.2,75.1
>>Kill |cRXP_ENEMY_Rock Elementals|r. Loot them for their |cRXP_LOOT_Stone Slabs|r
>>|cRXP_ENEMY_Rock Elementals|r |cRXP_WARN_are abundant in this southern location, but the northern location from the prior elemental quest has a few as well|r
.complete 711,1 
.mob Rock Elemental
step
.goto Badlands,51.38,76.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Theldurin|r
.turnin 687 >> Turn in Theldurin the Lost
.accept 709 >> Accept Solution to Doom
.target Theldurin the Lost
.isOnQuest 687
.group
step
.goto Badlands,51.38,76.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Theldurin the Lost|r
.accept 709 >> Accept Solution to Doom
.target Theldurin the Lost
.isQuestTurnedIn 687
.group
step
.loop 25,Badlands,47.16,69.82,48.38,72.06,49.86,72.12,51.20,71.93,52.41,69.96,52.55,67.79,52.46,65.90,51.00,63.86,49.66,63.97,49.69,66.39,49.78,68.28,48.14,68.30,47.16,69.82
>>Kill |cRXP_ENEMY_Stonevault Troggs|r. Loot them for their |cRXP_LOOT_Indurium Flakes|r
.complete 1108,1 
.mob Stonevault Bonesnapper
.mob Stonevault Shaman
step
#label badlands3
.goto Badlands,42.21,52.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Martek|r
.turnin 1108 >> Turn in Indurium
.accept 1137 >> Accept News for Fizzle
.target Martek the Exiled
step
#completewith next
>>Kill |cRXP_ENEMY_Buzzards|r. Loot them for their |cRXP_LOOT_Gizzards|r
.complete 2258,1 
.mob Buzzard
.mob Giant Buzzard
.mob Starving Buzzard
step
.goto Badlands,44.11,71.87,90,0
.goto Badlands,37.09,69.28,90,0
.goto Badlands,30.28,62.70,90,0
.goto Badlands,25.09,55.10,90,0
.goto Badlands,44.11,71.87,90,0
.goto Badlands,37.09,69.28,90,0
.goto Badlands,30.28,62.70
>>Kill |cRXP_ENEMY_Coyotes|r. Loot them for their |cRXP_LOOT_Jawbones|r and |cRXP_LOOT_Fangs|r
.complete 1419,1 
.complete 2258,2 
.mob Crag Coyote
.mob Feral Crag Coyote
.mob Rabid Crag Coyote
.mob Elder Crag Coyote
step
.loop 25,Badlands,17.24,58.53,15.35,58.51,14.85,60.16,15.00,61.98,16.15,61.84,17.01,61.24,17.24,58.53
>>Kill |cRXP_ENEMY_Buzzards|r. Loot them for their |cRXP_LOOT_Gizzards|r
.complete 2258,1 
.mob Buzzard
.mob Giant Buzzard
.mob Starving Buzzard
step
.goto Badlands,6.49,47.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Neeka|r
.turnin 1419 >> Turn in Coyote Thieves
.target Neeka Bloodscar
step
.goto Badlands,2.42,46.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jarkal|r
.turnin 2258 >> Turn in Badlands Reagent Run
.accept 2202 >> Accept Uldaman Reagent Run
.target Jarkal Mossmeld
.group
step
.goto Badlands,2.42,46.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jarkal|r
.turnin 2258 >> Turn in Badlands Reagent Run
.target Jarkal Mossmeld
step
#requires signofearthBL
.goto Badlands,2.91,45.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gorn|r
.turnin 782 >> Turn in Broken Alliances
.target Gorn
.isQuestComplete 782
.group
step
.goto Badlands,25.95,44.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lotwil|r
.turnin 711 >> Turn in Study of the Elements: Rock
.target Lotwil Veriatus
step
.goto Badlands,42.39,52.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rigglefuzz|r
.accept 2418 >> Accept Power Stones
.target Rigglefuzz
.group
step
#completewith Tablet
>>Loot the |cRXP_ENEMY_Shadowforge Dwarves|r and |cRXP_ENEMY_Stonevault Troggs|r for a chance of getting |T133289:0|t[Shattered Necklace]
>>|cRXP_WARN_Don't accept the quest yet due to possible quest log issues|r
.collect 7666,1 
.group 3
step
#completewith next
.goto Badlands,49.7,13.3,125,0
+Travel to The Maker's Terrace in northern Badlands, then enter the cave
.group 3
step
#completewith Tablet
>>Loot the |cRXP_PICK_Magenta Cap Clusters|r for |cRXP_LOOT_Fungus Caps|r
>>Kill |cRXP_ENEMY_Shadowforge Dwarves|r. Loot them for their |cRXP_LOOT_Power Stones|r
>>|cRXP_WARN_Be careful! |cRXP_ENEMY_Shadowforge Surveyors|r |cRXP_WARN_use Frost Nova and |cRXP_ENEMY_Obsidian Golems|r can reflect spells and are immume to taunt!|r
.complete 2202,1 
.complete 2418,1 
.complete 2418,2 
.mob Shadowforge Surveyor
.mob Shadowforge Ruffian
.mob Shadowforge Digger
.group 3
step
.goto Eastern Kingdoms,53.81,57.94,0
.goto Eastern Kingdoms,53.78,58.23
>>Loot the |cRXP_PICK_Garret Family Chest|r in the southern corner of the South Common Hall for the |cRXP_LOOT_Garrett Family Treasure|r
>>|cRXP_WARN_The South Common Hall is southwest of the Uldaman instance portal|r
.complete 2342,1 
.isOnQuest 2342
.group 3
step
#label Tablet
.goto Eastern Kingdoms,54.14,58.24
>>|TInterface/GossipFrame/HealerGossipIcon:0|tLoot the |cRXP_PICK_Ancient Chest|r in the middle of the room for the |cRXP_LOOT_Tablet of Ryun'eh|r
.complete 709,1 
.group 3
step
.loop 25,Eastern Kingdoms,54.15,58.05,54.25,58.03,54.15,58.05,54.03,57.96,54.01,58.18,54.03,57.96,53.97,57.91,53.95,58.03,53.87,57.93,53.71,57.92,53.87,57.93,53.90,57.81,53.87,57.93,53.95,58.03,53.97,57.91,53.94,57.78,54.03,57.69,54.18,57.79,54.11,57.84,54.20,57.87,54.29,57.77,54.20,57.67,54.11,57.84,54.18,57.79,54.03,57.69,53.94,57.78,54.03,57.96,54.15,58.05,54.15,58.05
>>Finish looting the |cRXP_PICK_Magenta Cap Clusters|r for |cRXP_LOOT_Fungus Caps|r
>>Finish killing |cRXP_ENEMY_Shadowforge Dwarves|r. Loot them for their |cRXP_LOOT_Power Stones|r
>>|cRXP_WARN_Be careful! |cRXP_ENEMY_Shadowforge Surveyors|r |cRXP_WARN_use Frost Nova and |cRXP_ENEMY_Obsidian Golems|r can reflect spells and are immume to taunt!|r
.complete 2202,1 
.complete 2418,1 
.complete 2418,2 
.mob Shadowforge Surveyor
.mob Shadowforge Ruffian
.mob Shadowforge Digger
.group 3
step
.goto Eastern Kingdoms,54.51,57.77,10,0
.goto Badlands,51.3,77.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tExit Uldaman, then talk to |cRXP_FRIENDLY_Theldurin|r
.turnin 709 >> Turn in Solution to Doom
.target Theldurin the Lost
.group
step
.goto Badlands,42.39,52.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rigglefuzz|r
.turnin 2418 >> Turn in Power Stones
.target Rigglefuzz
.group
step
.goto Badlands,42.47,52.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jazzrik|r
.vendor >>|cRXP_BUY_Sell your junk and repair, if necessary|r
.target Jazzrik
step
.goto Badlands,6.49,47.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Neeka|r
.accept 1420 >> Accept Report to Helgrum
.target Neeka Bloodscar
step
.goto Badlands,2.42,46.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jarkal|r
.turnin 2202 >> Turn in Uldaman Reagent Run
.target Jarkal Mossmeld
.group
step << Druid
#completewith DruidTraining7
.cast 18960 >>Cast |T135758:0|t[Teleport: Moonglade]
.zoneskip Moonglade
step << Druid
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 9634 >> Train your class spells
.target Loganaar
.xp <40,1
.xp >42,1
step << Druid
#label DruidTraining7
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 9750 >> Train your class spells
.target Loganaar
.xp <42,1
step
#completewith next
.hs >> Hearth to Orgrimmar
.use 6948
step
.goto Orgrimmar,54.10,68.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Gryshka|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Gryshka
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 42-43 Stranglethorn Vale
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 40-50
#next 43-43 Desolace II
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 8423 >> Train your class spells
.target Pephredo
.xp <40,1
.xp >42,1
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 10159 >> Train your class spells
.target Pephredo
.xp <42,1
step << Mage
.goto Orgrimmar,38.70,85.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r at the top of the hut
.train 11417 >> Train |T135744:0|t[Portal: Orgrimmar]
.target Thuul
.xp <40,1
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 8134 >> Train your class spells
.target Kardris Dreamseeker
.xp <40,1
.xp >42,1
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 11314 >> Train your class spells
.target Kardris Dreamseeker
.xp <42,1
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 8624 >> Train your class spells
.target Ormok
.xp <40,1
.xp >42,1
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 6774 >> Train your class spells
.target Ormok
.xp <42,1
step << Rogue
.goto Orgrimmar,42.10,49.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Rekkul|r|cRXP_BUY_. Buy |r |T134387:0|t[Flash Powder] |cRXP_BUY_from him|r
.collect 5140,20,2479,1 
.target Rekkul
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 11665 >> Train your class spells
.target Mirket
.xp <40,1
.xp >42,1
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 6789 >> Train your class spells
.target Mirket
.xp <42,1
step << Warlock
.goto Orgrimmar,47.52,46.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kurgul|r
.vendor >>Buy any pet upgrades you can afford
.target Kurgul
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14324 >> Train your class spells
.target Ormak Grimshot
.xp <40,1
.xp >42,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14289 >> Train your class spells
.target Ormak Grimshot
.xp <42,1
step << Hunter
.goto Orgrimmar,66.34,14.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xao'tsu|r
.train 24561 >> Train your pet spells
.target Xao'tsu
.xp <42,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 8106 >> Train your class spells
.target Ur'kyo
.xp <40,1
.xp >42,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 10898 >> Train your class spells
.target Ur'kyo
.xp <42,1
step
.goto Orgrimmar,59.4,36.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dran|r
.accept 2283 >> Accept Necklace Recovery
.turnin 2283 >> Turn in Necklace Recovery
.target Dran Droffers
.itemcount 7666,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 11608 >> Train your class spells
.target Grezz Ragefist
.xp <40,1
.xp >42,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 11550 >> Train your class spells
.target Grezz Ragefist
.xp <42,1
step
.goto Orgrimmar,75.18,34.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Belgrom Rockmaul|r
.accept 2981 >> Accept A Threat in Feralas
.target Belgrom Rockmaul
step << Orc !Warlock
.goto Orgrimmar,69.40,13.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kildar|r and |cRXP_FRIENDLY_Ogunaro|r
.train 825 >>Train |T136103:0|t[Wolf Riding]
.vendor >>|cRXP_BUY_Buy a|r |T132224:0|t[|cFF0070FFWolf|r]
.xp <40,1
.money <90
.skill riding,75,1
.target Kildar
.target Ogunaro
step << Shaman
.goto Orgrimmar,49.6,69.10
.bankdeposit 7069,7068,7067,7070 >> Deposit the following items into your bank:
>>|T135805:0|t[Elemental Fire]
>>|T134714:0|t[Elemental Water]
>>|T134572:0|t[Elemental Earth]
>>|T136107:0|t[Elemental Air]
step << Troll
#completewith next
.subzone 367 >> Travel to Sen'Jin Village
step << Troll
.goto Durotar,55.28,75.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xar'Ti|r and |cRXP_FRIENDLY_Zjolnir|r
.train 10861 >>Train |T136103:0|t[Raptor Riding]
.vendor >>|cRXP_BUY_Buy a|r |T132253:0|t[|cFF0070FFRaptor|r]
.xp <40,1
.money <90
.skill riding,75,1
.target Xar'Ti
.target Zjolnir
step
#completewith ZeptoUC3
.zone Durotar >> Leave Orgrimmar
.zoneskip Durotar
step
.abandon 782 >> Abandon Broken Alliances
.isOnQuest 782
step
.abandon 709 >> Abandon Solution to Doom
.isOnQuest 709
step
.abandon 2202 >> Abandon Uldaman Reagent Run
.isOnQuest 2202
step
.abandon 2418 >> Abandon Power Stones
.isOnQuest 2418
step
#label ZeptoUC3
.goto Durotar,50.8,13.8,40 >>Go up the Zeppelin Tower
.zone Stranglethorn Vale >>Take the Zeppelin to Stranglethorn Vale
.zoneskip Stranglethorn Vale
step
.goto Stranglethorn Vale,31.49,29.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Thulbek|r
.home >>Set your Hearthstone to Grom'Gol Base Camp
.target Innkeeper Thulbek
step
.goto Stranglethorn Vale,32.12,29.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Far Seer Mok'thardin|r
.accept 572 >> Accept Mok'thardin's Enchantment
.target Far Seer Mok'thardin
step
.goto Stranglethorn Vale,32.20,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kin'weelay|r
.turnin 1240 >> Turn in The Troll Witchdoctor
.target Kin'weelay
.isQuestTurnedIn 1238
step
.goto Stranglethorn Vale,32.10,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nimboya|r
.accept 584 >> Accept Bloodscalp Clan Heads
.target Nimboya
step
.goto Stranglethorn Vale,32.20,27.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kin'weelay|r
.accept 598 >> Accept Split Bone Necklace
.target Kin'weelay
step
#completewith next
.goto Stranglethorn Vale,23.82,10.78,200 >> Travel to the Ruins of Zul'Kunda
step
.goto Stranglethorn Vale,23.52,9.53
>>Kill |cRXP_ENEMY_Nezzliok the Dire|r. Loot him for his |cRXP_LOOT_Head|r
.complete 584,2 
.unitscan Nezzliok the Dire
step
.goto Stranglethorn Vale,23.44,8.14
>>Kill |cRXP_ENEMY_Gan'zulah|r. Loot him for his |cRXP_LOOT_Head|r
.complete 584,1 
.unitscan Gan'zulah
step
#completewith next
.goto Stranglethorn Vale,32.2,27.8,80 >> Return to Grom'gol Base Camp
step
.goto Stranglethorn Vale,32.22,27.60
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cRXP_PICK_Bubbling Cauldron|r
.turnin 584 >> Turn in Bloodscalp Clan Heads
.accept 585 >> Accept Speaking with Nezzliok
step
.goto Stranglethorn Vale,31.00,42.50,60,0
.loop 25,Stranglethorn Vale,32.99,38.06,31.42,40.17,30.14,43.06,28.36,43.47,28.53,45.96,30.61,44.54,31.80,43.08,33.24,40.38,33.85,38.45,32.99,38.06
>>Kill |cRXP_ENEMY_Jungle Stalkers|r. Loot them for their |cRXP_LOOT_Feathers|r
.complete 196,1 
.complete 572,1 
.mob Jungle Stalker
step
.loop 25,Stranglethorn Vale,40.36,43.2941.04,43.73,41.93,44.73,41.47,43.26,42.05,42.55,42.29,41.48,41.55,41.43,41.18,41.93,40.36,43.29
>>Kill |cRXP_ENEMY_Venture Co. Goblins|r. Loot them for their |cRXP_LOOT_Crystals|r
.complete 600,1 
.mob Venture Co. Surveyor
.mob Venture Co. Foreman
.mob Venture Co. Strip Miner
.mob Venture Co. Tinkerer
.mob Foreman Cozzle
step
#completewith SkullP
>>Kill |cRXP_ENEMY_Skullsplitter Trolls|r. Loot them for their |cRXP_LOOT_Tusks|r and |cRXP_LOOT_Necklaces|r
.complete 209,1 
.complete 598,1 
.mob Skullsplitter Mystic
.mob Skullsplitter Warrior
.mob Skullsplitter Axe Thrower
step
.goto Stranglethorn Vale,42.20,36.10
>>|TInterface/GossipFrame/HealerGossipIcon:0|tLoot the |cRXP_PICK_Ziata'jai Trophy Skulls|r for its |cRXP_LOOT_Trophy|r
.complete 585,2 
step
.goto Stranglethorn Vale,47.60,39.60
>>|TInterface/GossipFrame/HealerGossipIcon:0|tLoot the |cRXP_PICK_Zul'Mamwe Trophy Skulls|r for its |cRXP_LOOT_Trophy|r
.complete 585,3 
step
#label SkullP
.goto Stranglethorn Vale,46.10,32.30
>>|TInterface/GossipFrame/HealerGossipIcon:0|tLoot the |cRXP_PICK_Balia'mah Trophy Skulls|r for its |cRXP_LOOT_Trophy|r
.complete 585,1 
step
.loop 25,Stranglethorn Vale,42.13,36.29,41.89,35.93,42.45,35.03,42.47,33.35,43.47,33.25,45.06,32.39,45.51,31.66,46.42,31.98,47.19,30.85,47.11,32.54,47.13,34.31,45.23,34.47,44.00,35.53,43.44,37.92,42.13,36.29
>>Finish killing |cRXP_ENEMY_Skullsplitter Trolls|r. Loot them for their |cRXP_LOOT_Tusks|r and |cRXP_LOOT_Necklaces|r
.complete 209,1 
.complete 598,1 
.mob Skullsplitter Mystic
.mob Skullsplitter Warrior
.mob Skullsplitter Axe Thrower
step
.loop 25,Stranglethorn Vale,42.13,36.29,41.89,35.93,42.45,35.03,42.47,33.35,43.47,33.25,45.06,32.39,45.51,31.66,46.42,31.98,47.19,30.85,47.11,32.54,47.13,34.31,45.23,34.47,44.00,35.53,43.44,37.92,42.13,36.29
.xp 42 >> Grind to level 42
step
#completewith next
.hs >> Hearth to Grom'gol Base Camp
.use 6948
step
.goto Stranglethorn Vale,31.48,29.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Thulbek|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Thulbek
step << Hunter
.goto Stranglethorn Vale,31.55,27.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uthok|r
>>|cFF0E8312Buy|r |T132382:0|t[Razor Arrows] |cFF0E8312from him|r
.collect 3030,2600,669,1 
.target Uthok
.xp >40,1
step << Hunter
.goto Stranglethorn Vale,31.55,27.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uthok|r
>>|cFF0E8312Buy|r |T135661:0|t[Jagged Arrows] |cFF0E8312from him|r
.collect 11285,2600,669,1 
.target Uthok
.xp <40,1
step
.goto Stranglethorn Vale,32.20,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kin'weelay|r
.turnin 598 >> Turn in Split Bone Necklace
.turnin 585 >> Turn in Speaking with Nezzliok
.accept 1261 >> Accept Marg Speaks
.target Kin'weelay
step
.goto Stranglethorn Vale,32.10,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nimboya|r
.accept 2932 >> Accept Grim Message
.target Nimboya
step
.goto Stranglethorn Vale,32.10,29.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Far Seer Mok'thardin|r
.turnin 572 >> Turn in Mok'thardin's Enchantment
.target Far Seer Mok'thardin
step
.goto Stranglethorn Vale,32.54,29.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thysta|r
.fly Booty Bay >> Fly to Booty Bay
.target Thysta
step
.goto Stranglethorn Vale,27.10,77.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fleet Master Seahorn|r
.turnin 669 >> Turn in Sunken Treasure
.accept 670 >> Accept Sunken Treasure
.target Fleet Master Seahorn
step
.goto Stranglethorn Vale,27.10,77.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crank|r on the inn's ground floor
.turnin 600 >> Turn in Venture Company Mining
.target Crank Fizzlebub
step
.goto Stranglethorn Vale,26.95,77.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kebok|r on the inn's top floor
.turnin 209 >> Turn in Skullsplitter Tusks
.accept 1116 >> Accept Dream Dust in the Swamp
.target Kebok
step
.goto Stranglethorn Vale,28.29,77.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drizzlik|r
.turnin 628 >> Turn in Excelsior
.target Drizzlik
step
.goto Stranglethorn Vale,26.87,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gringer|r
.fly Grom'gol >> Fly to Grom'gol Base Camp
.target Gringer
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hemet|r and |cRXP_FRIENDLY_S. J. Erlgadin|r
.turnin 196 >> Turn in Raptor Mastery
.accept 197 >> Accept Raptor Mastery
.goto Stranglethorn Vale,35.66,10.81
.accept 193 >> Accept Panther Mastery
.goto Stranglethorn Vale,35.55,10.55
.group
step
.goto Stranglethorn Vale,35.66,10.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hemet|r
.turnin 196 >> Turn in Raptor Mastery
step
#completewith next
.goto Stranglethorn Vale,39.30,6.49,60,0
.goto Stranglethorn Vale,40.63,3.12,50 >> Travel to Duskwood
.zoneskip Duskwood
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zraedus|r and |cRXP_FRIENDLY_Faustin|r
.accept 1372 >> Accept Nothing But The Truth
.goto Duskwood,87.81,35.62
.turnin 1372 >> Turn in Nothing But The Truth
.goto Duskwood,87.45,35.25
.target Deathstalker Zraedus
.target Apothecary Faustin
step
#completewith next
.goto Duskwood,88.47,41.00,50 >> Travel to Deadwind Pass
.zoneskip Deadwind Pass
step
.goto Deadwind Pass,48.02,34.60,60,0
.goto Deadwind Pass,58.43,41.51,50,0
.zone Swamp of Sorrows >> Travel to Swamp of Sorrows
.zoneskip Swamp of Sorrows
step
#completewith next
.goto Swamp of Sorrows,13.27,67.96,0
.loop 25,Swamp of Sorrows,12.02,60.27,12.00,67.29,15.12,65.50,16.54,61.12,15.37,55.45,12.19,57.13,12.02,60.27
>>Kill |cRXP_ENEMY_Adolescent Whelps|r and |cRXP_ENEMY_Dreaming Whelps|r. Loot them for their |cRXP_LOOT_Dream Dust|r
>>|cRXP_WARN_Don't focus on this. Kill all of the whelps once. You'll finish it later|r
.complete 1116,1 
.mob Dreaming Whelp
.mob Adolescent Whelp
step
.goto Swamp of Sorrows,44.70,57.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dar|r
.accept 698 >> Accept Lack of Surplus
.target Dar
step
.goto Swamp of Sorrows,46.10,54.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Breyk|r
.fp Stonard >> Get the Stonard Flight Path
.target Breyk
step
.goto Swamp of Sorrows,45.78,52.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thultazor|r
.vendor >> |cRXP_BUY_Buy|r |T134833:0|t[Superior Healing Potions] |cRXP_BUY_from him if they're up|r
.target Thultazor
step
.goto Swamp of Sorrows,45.38,56.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rartar|r inside the inn
.vendor >> |cRXP_BUY_Buy|r |T134833:0|t[Superior Healing Potions] |cRXP_BUY_from him if they're up|r
.target Rartar
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Helgrum|r and |cRXP_FRIENDLY_Fel'zerul|r on the top floor of the large building
.turnin 1420 >> Turn in Report to Helgrum
.goto Swamp of Sorrows,47.80,55.20
.accept 1424 >> Accept Pool of Tears
.goto Swamp of Sorrows,47.80,55.20
.target Helgrum the Swift
.target Fel'zerul
step << Hunter
.goto Swamp of Sorrows,47.27,53.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ogrom|r
.train 13553 >>Train your class spells
.target Ogrom
.xp <42,1
.xp >44,1
step << Hunter
.goto Swamp of Sorrows,47.27,53.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ogrom|r
.train 14285 >>Train your class spells
.target Ogrom
.xp <44,1
step << Hunter
.goto Swamp of Sorrows,47.35,52.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grokor|r
.train 24561 >>Train your pet spells
.target Grokor
.xp <42,1
step << Warlock
.goto Swamp of Sorrows,48.64,55.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kartosh|r
.train 6789 >> Train your class spells
.target Kartosh
.xp <42,1
.xp >44,1
step << Warlock
.goto Swamp of Sorrows,48.64,55.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kartosh|r
.train 11671 >> Train your class spells
.target Kartosh
.xp <44,1
step << Warlock
.goto Swamp of Sorrows,48.59,55.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greshka|r
.vendor >>Buy any pet upgrades you can afford
.target Greshka
step << Shaman
.goto Swamp of Sorrows,48.19,57.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greshka|r
.train 11314 >>Train your class spells
.target Haromm
.xp <42,1
.xp >44,1
step << Shaman
.goto Swamp of Sorrows,48.19,57.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greshka|r
.train 16315 >>Train your class spells
.target Haromm
.xp <44,1
step << Warrior
.goto Swamp of Sorrows,44.89,57.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malosh|r
.train 11550 >> Train your class spells
.target Malosh
.xp <42,1
.xp >44,1
step << Warrior
.goto Swamp of Sorrows,44.89,57.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malosh|r
.train 11584 >> Train your class spells
.target Malosh
.xp <44,1
step
#completewith GalenStrongbox
>>Kill |cRXP_ENEMY_Sawtooth Crocolisks|r and |cRXP_ENEMY_Sawtooth Snappers|r. Loot them for their |cRXP_LOOT_Sawtooth Flanks|r
.complete 698,1 
.mob Sawtooth Crocolisk
.mob Sawtooth Snapper
step
.line Swamp of Sorrows,32.24,36.70,33.22,39.96,33.92,44.25,36.71,46.36,37.92,43.17,38.29,39.13,38.86,35.61,40.34,34.40,40.86,32.29,42.43,32.11,45.77,36.75,46.68,38.55,48.95,38.71,53.41,38.98,55.48,37.42,56.06,36.05
.goto Swamp of Sorrows,56.06,36.05,40,0
.goto Swamp of Sorrows,55.48,37.42,40,0
.goto Swamp of Sorrows,53.41,38.98,40,0
.goto Swamp of Sorrows,48.95,38.71,40,0
.goto Swamp of Sorrows,46.68,38.55,40,0
.goto Swamp of Sorrows,45.77,36.75,40,0
.goto Swamp of Sorrows,42.43,32.11,40,0
.goto Swamp of Sorrows,40.86,32.29,40,0
.goto Swamp of Sorrows,40.34,34.40,40,0
.goto Swamp of Sorrows,38.86,35.61,40,0
.goto Swamp of Sorrows,38.29,39.13,40,0
.goto Swamp of Sorrows,37.92,43.17,40,0
.goto Swamp of Sorrows,36.71,46.36,40,0
.goto Swamp of Sorrows,33.92,44.25,40,0
.goto Swamp of Sorrows,33.22,39.96,40,0
.goto Swamp of Sorrows,32.24,36.70,40,0
>>Kill |cRXP_ENEMY_Noboru the Cudgel|r. Loot him for |T133485:0|t[|cFF00BCD4Noboru's Cudgel|r]. Use it to start the quest
>>|cRXP_ENEMY_Noboru the Cudgel|r |cRXP_WARN_patrols the zone's top-center|r
.collect 6196,1,1392 
.accept 1392 >> Accept Noboru the Cudgel
.unitscan Noboru the Cudgel
step
.goto Swamp of Sorrows,25.98,31.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Magtoor|r
.accept 1389 >> Accept Draenethyst Crystals
.turnin 1392 >> Turn in Noboru the Cudgel
.target Magtoor
step
#completewith GalenE
>>Kill |cRXP_ENEMY_Ongeku|r. Loot him for his |cRXP_LOOT_Shard|r
>>|cRXP_WARN_Ongeku can be found all over the Fallow Sanctuary|r
.complete 1373,1 
.unitscan Ongeku
.isOnQuest 1373
step
#completewith GalenE
>>Loot the blue |cRXP_LOOT_Draenethyst Crystals|r on the ground
.complete 1389,1 
.target Galen Goodward
step
#completewith next
+|cRXP_WARN_This next quest can be quite hard, be extra careful|r
step
#label Galen
.goto Swamp of Sorrows,65.46,18.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Galen|r to start his escort
>>|cRXP_WARN_Before starting, pre-clear mobs to the immediate southwest of Galen as best you can|r
.accept 1393 >> Accept Galen's Escape
.target Galen Goodward
step
#label GalenE
>>Escort |cRXP_FRIENDLY_Galen Goodward|r safely out of the Fallow Sanctuary
.complete 1393,1 
.target Galen Goodward
step
#completewith next
>>Loot the blue |cRXP_LOOT_Draenethyst Crystals|r on the ground
.complete 1389,1 
.target Galen Goodward
step
.goto Swamp of Sorrows,62.60,22.86,-1
.goto Swamp of Sorrows,64.74,22.46,-1
>>Kill |cRXP_ENEMY_Ongeku|r. Loot him for his |cRXP_LOOT_Shard|r
>>|cRXP_WARN_Ongeku can be found all over the Fallow Sanctuary|r
.complete 1373,1 
.unitscan Ongeku
.isOnQuest 1373
step
.loop 25,Swamp of Sorrows,58.31,25.47,61.69,22.38,64.52,19.68,63.88,24.38,58.31,25.47
>>Finish looting the blue |cRXP_LOOT_Draenethyst Crystals|r on the ground
.complete 1389,1 
step
#label GalenStrongbox
.goto Swamp of Sorrows,47.80,39.75
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on |cRXP_PICK_Galen's Strongbox|r
.turnin 1393 >> Turn in Galen's Escape
step
.goto Swamp of Sorrows,52.44,37.14,60,0
.goto Swamp of Sorrows,56.71,35.60,60,0
.goto Swamp of Sorrows,60.47,31.60,60,0
.goto Swamp of Sorrows,63.96,32.23,60,0
.goto Swamp of Sorrows,52.44,37.14
>>Kill |cRXP_ENEMY_Sawtooth Crocolisks|r and |cRXP_ENEMY_Sawtooth Snappers|r. Loot them for their |cRXP_LOOT_Sawtooth Flanks|r
.complete 698,1 
.mob Sawtooth Crocolisk
.mob Sawtooth Snapper
step
.goto Swamp of Sorrows,81.40,81.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tok'Kar|r
.turnin 698 >> Turn in Lack of Surplus
.accept 699 >> Accept Lack of Surplus
.target Tok'Kar
step
.goto Swamp of Sorrows,75.44,60.41,50,0
.goto Swamp of Sorrows,71.14,61.44,50,0
.goto Swamp of Sorrows,65.36,57.19,50,0
.goto Swamp of Sorrows,65.99,47.10,50,0
.goto Eastern Kingdoms,53.87,79.26,50,0
.goto Swamp of Sorrows,70.57,46.04,50,0
.goto Swamp of Sorrows,75.03,50.83,50,0
.goto Swamp of Sorrows,75.44,60.41
>>Loot the |cRXP_LOOT_Atal'ai Artifacts|r scattered all around the Pool of Tears' shore, or at the bottom of the Pool of Tears itself
>>|cRXP_WARN_The artifacts have different models. Open your menu, click System, then Graphics, then adjust the Environmental Clutter slider (at the very bottom) to 0|r
.complete 1424,1 
step
.goto Swamp of Sorrows,48.00,54.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Fel'zerul|r in Stonard
.turnin 1424 >> Turn in Pool of Tears
.target Fel'zerul
step
.goto Swamp of Sorrows,25.90,31.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Magtoor|r
.turnin 1392 >> Turn in Noboru the Cudgel
.turnin 1389 >> Turn in Draenethyst Crystals
.target Magtoor
step
.loop 25,Swamp of Sorrows,12.02,60.27,12.00,67.29,15.12,65.50,16.54,61.12,15.37,55.45,12.19,57.13,12.02,60.27
>>Finish killing |cRXP_ENEMY_Adolescent Whelps|r and |cRXP_ENEMY_Dreaming Whelps|r. Loot them for their |cRXP_LOOT_Dream Dust|r
.complete 1116,1 
.mob Dreaming Whelp
.mob Adolescent Whelp
step
.goto Swamp of Sorrows,46.08,54.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Breyk|r
.fly Badlands >> Fly to Badlands
.target Breyk
.zoneskip Badlands
step
.goto Badlands,25.95,44.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lotwil|r
.accept 712 >> Accept Study of the Elements: Rock
.target Lotwil Veriatus
step
.loop 25,Badlands,6.58,75.55,1.23,79.29,2.06,82.38,6.66,81.68,6.58,75.55
>>Kill |cRXP_ENEMY_Greater Rock Elementals|r. Loot them for their |cRXP_LOOT_Bracers|r
.complete 712,1 
.mob Greater Rock Elemental
step
.goto Badlands,51.38,76.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Theldurin|r
.accept 692 >> Accept The Lost Fragments
.target Theldurin the Lost
.isQuestTurnedIn 688
.group
step
.goto Badlands,51.38,76.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Theldurin|r
.accept 728 >> Accept To the Undercity for Yagyin's Digest
.target Theldurin the Lost
.isQuestTurnedIn 709
.group
step
.loop 25,Badlands,53.65,81.49,54.29,85.26,55.43,86.87,56.13,82.85,53.65,81.49
>>Kill |cRXP_ENEMY_Enraged Rock Elementals|r. Loot them for their |cRXP_LOOT_Scrolls|r
.complete 692,1 
.complete 692,2 
.complete 692,3 
.mob Enraged Rock Elemental
.isQuestTurnedIn 688
.group
step
.goto Badlands,51.38,76.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Theldurin|r
.turnin 692 >> Turn in The Lost Fragments
.accept 656 >> Accept Summoning the Princess
.target Theldurin the Lost
.isQuestTurnedIn 688
.group
step
.goto Badlands,25.95,44.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lotwil|r
.turnin 712 >> Turn in Study of the Elements: Rock
.target Lotwil Veriatus
step
#ah
.goto Badlands,25.95,44.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lotwil|r
.accept 734 >> Accept This is Going to Be Hard
.target Lotwil Veriatus
.isQuestTurnedIn 714
.isQuestTurnedIn 712
step
#ah
.goto Badlands,25.82,44.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lucien|r
.turnin 734 >> Turn in This is Going to Be Hard
.accept 777 >> Accept This is Going to Be Hard
.target Lucien Tosselwrench
.isQuestTurnedIn 714
.isQuestTurnedIn 712
step
#ah
.goto Badlands,25.95,44.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lotwil|r
.turnin 777 >> Turn in This is Going to Be Hard
.accept 778 >> Accept This is Going to Be Hard
.target Lotwil Veriatus
.isQuestTurnedIn 714
.isQuestTurnedIn 712
step
#ah
.goto Badlands,26.09,46.83
>>Kill the |cRXP_ENEMY_Fam'retor Guardian|r. Loot him for his |cRXP_LOOT_Bindings|r
.complete 778,1 
.unitscan Fam'retor Guardian
.isQuestTurnedIn 714
.isQuestTurnedIn 712
step
.goto Badlands,25.95,44.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Lotwil Veriatus|r
.turnin 778 >> Turn in This is Going to Be Hard
.target Lotwil Veriatus
.isQuestComplete 778
step
.goto Badlands,3.99,44.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gorrik|r
.fly Hammerfall >> Fly to Hammerfall
.target Gorrik
step
.goto Arathi Highlands,73.80,33.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zengu|r
.turnin 646 >> Turn in Trol'kalar
.target Zengu
.group
step
.goto Arathi Highlands,62.45,33.72
.use 4472 >>Use your |T134937:0|t[Scroll of Myzrael], then wait for roleplay
>>Kill |cRXP_ENEMY_Myzrael|r. Loot her for her |cRXP_LOOT_Shackles|r
>>|cRXP_WARN_Bringing a tank and a healer is advised. She spawns many elemental adds|r
.complete 656,1 
.unitscan Myzrael
.group 5
step
.goto Arathi Highlands,62.45,33.72
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the Shards of Myzrael
.turnin 656 >> Turn in Summoning the Princess
.group
step
#completewith next
.goto Arathi Highlands,21.6,75.6,30,0
.goto Arathi Highlands,22.1,79.9,25 >> Run through the cave to Faldir's Cove
step
.goto Arathi Highlands,32.28,81.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shakes O'Breen|r
.turnin 670 >> Turn in Sunken Treasure
.accept 667 >> Accept Death From Below
.target Shakes O'Breen
step
.goto Arathi Highlands,31.56,82.14,15,0
.goto Arathi Highlands,31.47,81.06,15,0
.goto Arathi Highlands,32.02,80.71
>>Board the boat, then wait for the naga to appear
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Cannon|r to kill the |cRXP_ENEMY_Daggerspine Marauders|r instantly
.complete 667,1 
.mob Daggerspine Marauder
step
.goto Arathi Highlands,32.28,81.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Shakes O'Breen|r
.turnin 667 >> Turn in Death From Below
.target Shakes O'Breen
step
#completewith next
.goto Arathi Highlands,35.78,79.52
.goto Arathi Highlands,48.71,55.80,30 >> Logout on top of the rock in the middle of the cave. Perform a Logout Skip by logging out and back in|r
.link https://www.youtube.com/watch?v=SWBtPqm5M0Q&t=114s >> |cRXP_WARN_Click here for video reference|r
step
.goto Arathi Highlands,73.10,32.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urda|r
.fly Tarren Mill >> Fly to Tarren Mill
.target Urda
.zoneskip Hillsbrad Foothills

step
#completewith VenomBottle
.zone The Hinterlands >> Travel to The Hinterlands
step
#completewith grimmes
>>Kill |cRXP_ENEMY_Witherbark Trolls|r. Loot them for their |cRXP_LOOT_Skulls|r
.collect 9320,20 
.isOnQuest 2932
step
#label VenomBottle
.goto The Hinterlands,23.00,57.73
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick one of the green |cRXP_PICK_Venom Bottles|r around the camp
.accept 2933 >> Accept Venom Bottles
step
#completewith next
.use 15002 >>Click |T135128:0|t[Nimboya's Pike] to create |T135125:0|t[Nimboya's Laden Pike]
.itemcount 15002,1
step
#label grimmes
.goto The Hinterlands,23.9,58.3
.use 9319 >>Use |T135125:0|t[Nimboya's Laden Pike] in the middle of the camp
.complete 2932,1 
.isOnQuest 2932
step
#completewith next
.goto Hillsbrad Foothills,62.31,20.29,125 >> Travel back to Tarren Mill
step
.goto Hillsbrad Foothills,61.50,19.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r
.turnin 2933 >> Turn in Venom Bottles
.target Apothecary Lydon
step
.goto Hillsbrad Foothills,62.10,82.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krusk|r
.accept 507 >> Accept Lord Aliden Perenolde
.target Krusk
.solo
step
.goto Hillsbrad Foothills,62.62,20.74
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_WANTED: Baron Vardus|r poster next to |cRXP_FRIENDLY_Melisara|r
.accept 566 >> Accept WANTED: Baron Vardus
.target Melisara
.solo
step
#completewith next
>>Search for |cRXP_ENEMY_Baron Vardus|r in each camp and the Strahnbrad inn. Kill him and loot him for his |cRXP_LOOT_Head|r
.complete 566,1 
.unitscan Baron Vardus
.solo
step
.goto Alterac Mountains,39.28,14.52
>>Kill |cRXP_ENEMY_Lord Aliden Perenolde|r
>>|cRXP_WARN_Be mindful of |cRXP_ENEMY_Syndicate Assassins|r. |cRXP_ENEMY_Aliden|r uses Power Word: Shield, casts Renew, and will sleep pets and other players|r
.complete 507,1 
.unitscan Lord Aliden Perenolde
.mob Syndicate Assassin
.solo
step
.goto Alterac Mountains,39.30,14.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elysa|r
.turnin 507 >> Turn in Lord Aliden Perenolde
.accept 508 >> Accept Taretha's Gift
.target Elysa
.solo
step
.goto Alterac Mountains,47.8,17.1,70,0
.goto Alterac Mountains,53.6,20.6,70,0
.goto Alterac Mountains,56.2,26.8,70,0
.goto Alterac Mountains,58.1,29.9,70,0
.goto Alterac Mountains,59.7,43.9
>>Search for |cRXP_ENEMY_Baron Vardus|r in each camp and the Strahnbrad inn. Kill him and loot him for his |cRXP_LOOT_Head|r
.complete 566,1 
.unitscan Baron Vardus
.solo
step
.goto Alterac Mountains,61.10,82.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Darthalia|r
.turnin 566 >> Turn in WANTED: Baron Vardus
.target High Executor Darthalia
.solo
step
.goto Alterac Mountains,62.10,82.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krusk|r
.turnin 508 >> Turn in Taretha's Gift
.target Krusk
.solo
step
.goto Hillsbrad Foothills,62.63,20.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Melisara|r
.accept 521 >> Accept The Crown of Will
.target Melisara
.isQuestTurnedIn 520
.group
step
.goto Hillsbrad Foothills,60.14,18.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zarise|r
.fly Undercity >> Fly to Undercity
.target Zarise
.zoneskip Undercity
.group
step
.goto Undercity,62.32,48.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Patrick|r
.turnin 2342 >>Turn in Reclaimed Treasures
.target Patrick Garrett
.isQuestComplete 2342
.group
step
.goto Undercity,62.31,48.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Patrick|r
.accept 2342 >> Accept Reclaimed Treasures
.target Patrick
.dungeon ULDA
step
.goto Undercity,53.77,54.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bel'dugur|r
.turnin 728 >> Turn in To the Undercity for Yagyin's Digest
.target Keeper Bel'dugur
.group
step
.goto Undercity,50.15,67.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zinge|r
.accept 243 >> Accept Into the Field
.target Apothecary Zinge
.group
step
.goto Undercity,57.65,93.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sharlindra|r
.turnin 521 >> Turn in The Crown of Will
.target Sharlindra
.group
step << Warrior
.goto Undercity,48.32,15.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Angela|r
.train 11550 >> Train your class spells
.target Angela Curthas
.xp <42,1
.xp >44,1
.group
step << Warrior
.goto Undercity,48.32,15.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Angela|r
.train 11584 >> Train your class spells
.target Angela Curthas
.xp <44,1
.group
step << Rogue
.goto Undercity,83.86,72.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carolyn|r
.train 6774 >> Train your class spells
.target Carolyn Ward
.xp <42,1
.xp >44,1
.group
step << Rogue
.goto Undercity,83.86,72.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carolyn|r
.train 11341 >> Train your class spells
.target Carolyn Ward
.xp <44,1
.group
step << Warlock
.goto Undercity,88.93,15.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Richard|r
.train 6789 >> Train your class spells
.target Richard Kerwin
.xp <42,1
.xp >44,1
.group
step << Warlock
.goto Undercity,88.93,15.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Richard|r
.train 11671 >> Train your class spells
.target Richard Kerwin
.xp <44,1
.group
step << Mage
.goto Undercity,85.15,10.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anastasia|r
.train 10159 >> Train your class spells
.target Anastasia Hartwell
.xp <42,1
.xp >44,1
.group
step << Mage
.goto Undercity,85.15,10.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anastasia|r
.train 10185 >> Train your class spells
.target Anastasia Hartwell
.xp <44,1
.group
step << Priest
.goto Undercity,47.55,18.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lazarus|r
.train 10892 >> Train your class spells
.target Father Lazarus
.xp <42,1
.xp >44,1
.group
step << Priest
.goto Undercity,47.55,18.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lazarus|r
.train 10927 >> Train your class spells
.target Father Lazarus
.xp <44,1
.group
step << Undead !Warlock
#completewith next
.subzone 159 >> Travel to Brill
step << Undead !Warlock
.goto Tirisfal Glades,60.09,52.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Velma|r and |cRXP_FRIENDLY_Zachariah|r
.train 10906 >>Train |T136103:0|t[Undead Horsemanship]
.vendor >>|cRXP_BUY_Buy a|r |T132264:0|t[|cFF0070FFSkeletal Horse|r]
.xp <40,1
.money <90
.skill riding,75,1
.target Velma Warnam
.target Zachariah Post
step
#completewith next
.hs >> Hearth to Grom'gol Base Camp
.use 6948
step
.goto Stranglethorn Vale,31.48,29.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Thulbek|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Thulbek
step
.goto Stranglethorn Vale,32.5,29.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thysta|r
.fly Booty Bay >> Fly to Booty Bay
.target Thysta
step
.abandon 692 >> Abandon The Lost Fragments
.isOnQuest 692
step
.abandon 656 >> Abandon Summoning the Princess
.isOnQuest 656
step
.goto Stranglethorn Vale,32.10,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nimboya|r
.turnin 2932 >> Turn in Grim Message
.target Nimboya
step
.goto Stranglethorn Vale,26.99,77.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tClimb to the third floor of the inn, then talk to |cRXP_FRIENDLY_Krazek|r
.turnin 1116 >> Turn in Dream Dust in the Swamp
.target Krazek
step << Rogue
.goto Stranglethorn Vale,26.82,77.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ian|r on the second floor of the inn
.train 6774 >> Train your class spells
.target Ian Strom
.xp <42,1
.xp >44,1
step << Rogue
.goto Stranglethorn Vale,26.82,77.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ian|r on the second floor of the inn
.train 11341 >> Train your class spells
.target Ian Strom
.xp <44,1
step
.goto Stranglethorn Vale,27.10,77.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tExit to the third floor balcony, then talk to |cRXP_FRIENDLY_Baron Revilgaz|r
.accept 1183 >> Accept Goblin Sponsorship
.target Baron Revilgaz
step
.goto Stranglethorn Vale,26.99,77.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Krazek|r
.accept 1117 >> Accept Rumors for Kravel
.accept 2864 >> Accept Tran'rek
.target Krazek
step
.goto Stranglethorn Vale,27.70,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_"Sea Wolf" MacKinley|r
.accept 2872 >> Accept Stoley's Debt
.target "Sea Wolf" MacKinley
step
.goto Stranglethorn Vale,28.14,78.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Glyx|r
.vendor >> |cRXP_BUY_Buy|r |T134832:0|t[Greater Healing Potions] |cRXP_BUY_from him if they're up|r
.target Glyx Brewright
step
#completewith next
.goto Stranglethorn Vale,25.90,73.14,40 >> Run to the Booty Bay Dock
step
.goto Stranglethorn Vale,25.76,73.04
.zone The Barrens >> Take the boat to Ratchet
step
.goto The Barrens,62.40,37.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mebok|r
.turnin 1270 >> Turn in Stinky's Escape
.target Mebok Mizzyrix
.isQuestComplete 1270
step
.goto The Barrens,63.09,37.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bragok|r
.fly Camp Taurajo >> Fly to Camp Taurajo
.target Bragok
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 43-43 Desolace II
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 40-50
#next 43-45 Tanaris/Dustwallow

step
.goto The Barrens,45.58,59.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Byula|r
.home >> Set your Hearthstone to Camp Taurajo
.target Innkeeper Byula
step << !Mage
.goto The Barrens,44.45,59.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa|r
.fly Thunder Bluff >> Fly to Thunder Bluff
.target Omusa Thunderhorn
.zoneskip Thunder Bluff
step << Mage
.cast 3566 >>Cast |T135765:0|t[Teleport: Thunder Bluff]
.zoneskip Thunder Bluff
step << Priest
.goto Thunder Bluff,24.56,22.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malakai|r
.train 10892 >> Train your class spells
.target Malakai Cross
.xp <42,1
.xp >44,1
step << Priest
.goto Thunder Bluff,24.56,22.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malakai|r
.train 10927 >> Train your class spells
.target Malakai Cross
.xp <44,1
step << Mage
.goto Thunder Bluff,25.18,20.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thurston|r
.train 10159 >> Train your class spells
.target Thurston Xane
.xp <42,1
.xp >44,1
step << Mage
.goto Thunder Bluff,25.18,20.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thurston|r
.train 10185 >> Train your class spells
.target Thurston Xane
.xp <44,1
step
.goto Thunder Bluff,54.00,80.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mosarn|r
.turnin 1276 >> Turn in The Black Shield
.target Mosarn
.isQuestComplete 1276
step
.goto Thunder Bluff,61.40,80.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Melor|r
.turnin 1136 >> Turn in Frostmaw
.accept 1205 >> Accept Deadmire
.target Melor Stonehoof
.isQuestComplete 1136
step
.goto Thunder Bluff,61.40,80.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Melor|r
.accept 1205 >> Accept Deadmire
.target Melor Stonehoof
step << Druid
.goto Thunder Bluff,76.46,27.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Turak|r
.train 9750 >>Train your class spells
.target Turak Runetotem
.xp <42,1
.xp >44,1
step << Druid
.goto Thunder Bluff,76.46,27.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Turak|r
.train 9752 >>Train your class spells
.target Turak Runetotem
.xp <44,1
step << Hunter
.goto Thunder Bluff,59.11,86.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 13553 >>Train your class spells
.target Urek Thunderhorn
.xp <42,1
.xp >44,1
step << Hunter
.goto Thunder Bluff,59.11,86.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 14285 >>Train your class spells
.target Urek Thunderhorn
.xp <44,1
step << Hunter
.goto Thunder Bluff,54.08,84.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hesuwa|r
.train 24561 >>Train your pet spells
.target Hesuwa Thunderhorn
.xp <42,1
step << Warrior
.goto Thunder Bluff,57.56,85.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ker|r
.train 11550 >>Train your class spells
.target Ker Ragetotem
.xp <42,1
.xp >44,1
step << Warrior
.goto Thunder Bluff,57.56,85.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ker|r
.train 11584 >> Train your class spells
.target Ker Ragetotem
.xp <44,1
step << Shaman
.goto Thunder Bluff,22.84,21.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 11314 >>Train your class spells
.target Tigor Skychaser
.xp <42,1
.xp >44,1
step << Shaman
.goto Thunder Bluff,22.84,21.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 16315 >>Train your class spells
.target Tigor Skychaser
.xp <44,1
step << Tauren
#completewith next
.subzone 222 >> Travel to Bloodhoof Village
step << Tauren
.goto Mulgore,47.64,58.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xar'Ti|r and |cRXP_FRIENDLY_Zjolnir|r
.train 132245 >>Train |T136103:0|t[Kodo Riding]
.vendor >>|cRXP_BUY_Buy a|r |T132253:0|t[|cFF0070FFKodo|r]
.xp <40,1
.money <90
.skill riding,75,1
.target Kar Stormsinger
.target Harb Clawhoof
step
#completewith next
.goto Thunder Bluff,47.00,49.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tal|r
.fly Shadowprey Village >>Fly to Shadowprey Village
.target Tal
.zoneskip Desolace
step
.goto Desolace,25.80,68.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Taiga|r
.accept 5581 >> Accept Portals of the Legion
.target Taiga Wisemane
step
.goto Desolace,36.30,79.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uthek the Wise|r
.turnin 1373 >> Turn in Ongeku
.accept 1374 >> Accept Khan Jehn
.target Uthek the Wise
step
.goto Desolace,47.80,61.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hornizz Brimbuzzle|r
.accept 6134 >> Accept Ghost-o-plasm Round Up
.target Hornizz Brimbuzzle
step
.goto Desolace,52.20,53.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maurin Bonesplitter|r
.accept 1484 >> Accept The Corrupter
.target Maurin Bonesplitter
step
.goto Desolace,52.60,54.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Takata Steelblade|r
.turnin 1484 >> Turn in The Corrupter
.accept 1488 >> Accept The Corrupter
.target Takata Steelblade
step
#completewith KhanJ
.goto Desolace,53.36,79.47,0
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick |cRXP_PICK_Demon Portals|r, then kill the |cRXP_ENEMY_Demon Portal Guardians|r
>>|cRXP_WARN_Don't focus on this step; you can finish it later|r
.complete 5581,1 
.mob Demon Portal Guardian
step
#label Jugkar
.goto Desolace,55.90,77.80
>>Kill |cRXP_ENEMY_Jugkar Grim'rod|r
.complete 1488,2 
.unitscan Jugkar Grim'rod
step
.goto Desolace,55.90,77.80
>> Kill |cRXP_ENEMY_Lord Azrethoc, kite him with Frost Shock if needed.|r << Shaman
>> Kill |cRXP_ENEMY_Lord Azrethoc|r, you might need to use Retaliation to kill him << Warrior
>> Kill |cRXP_ENEMY_Lord Azrethoc|r, use youre fear to heal up in between his Mortal Strikes << Priest
>> Kill |cRXP_ENEMY_Lord Azrethoc|r, he is soloable eaisly << Hunter
>> Kill |cRXP_ENEMY_Lord Azrethoc|r, use your cooldowns. If it's needed use gouges to kite and bandage << Rogue
>> Kill |cRXP_ENEMY_Lord Azrethoc|r, he is fearable and should be eaisly solable. << Warlock
>> Kill |cRXP_ENEMY_Lord Azrethoc|r, you can kite him around with frost novas and frost bolts << Mage
>> Kill |cRXP_ENEMY_Lord Azrethoc|r, you can eaisly kill him in bear form or by kiting him with entangling roots. << Druid
*He patrols all around the edges of Mannoroc Cavern
.complete 1488,1 
.unitscan Lord Azrethoc
step
#label KhanJ
.goto Desolace,66.30,80.10
>>Kill |cRXP_ENEMY_Khan Jehn|r. Loot him for his |cRXP_LOOT_Head|r
.complete 1374,1 
.mob Khan Jehn
step
.goto Desolace,64.00,91.70
.use 15848 >> Travel to the Valley of Bones, then use the |T132763:0|t[Crate of Ghost Magnets]
>>Kill |cRXP_ENEMY_Magrami Spectres|r. Loot them for their |cRXP_LOOT_Ghost-o-plasm|r
.complete 6134,2 
.mob Magrami Spectre
step
.goto Desolace,53.36,79.47
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick |cRXP_PICK_Demon Portals|r, then kill the |cRXP_ENEMY_Demon Portal Guardians|r
.complete 5581,1 
.mob Demon Portal Guardian
step
.goto Desolace,36.30,79.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uthek the Wise|r
.turnin 1374 >> Turn in Khan Jehn
.target Uthek the Wise
step
.goto Desolace,36.30,79.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uthek the Wise|r
.accept 1380 >> Accept Khan Hratha
.target Uthek the Wise
.group
step
.goto Desolace,25.81,68.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Taiga Wisemane|r
.turnin 5581 >> Turn in Portals of the Legion
.target Taiga Wisemane
step
.goto Desolace,29.97,68.88,30,0
.goto Desolace,30.00,66.32,30,0
.goto Desolace,31.57,65.07,30,0
.goto Desolace,32.98,65.93,30,0
.goto Desolace,32.91,62.80,30,0
.goto Desolace,32.01,60.85,50,0
.goto Desolace,29.53,60.66,50,0
.goto Desolace,29.95,58.26,50,0
.goto Desolace,30.73,55.60,50,0
.goto Desolace,32.56,54.95,50,0
.goto Desolace,34.65,56.81,50,0
.goto Desolace,35.28,61.30,50,0
.goto Desolace,36.76,60.62,50,0
.goto Desolace,35.09,57.90,50,0
.goto Desolace,30.57,52.07,50,0
.goto Desolace,29.99,54.66,50,0
.goto Desolace,30.24,57.82
>>Kill |cRXP_ENEMY_Maraudine Centaurs|r. Loot them for the |T134374:0|t[War Horn Mouthpiece]
>>|cRXP_WARN_This has a low droprate, it can take a while|r
.collect 6074 
.group 2
step
.goto Desolace,30.31,50.57,25,0
.goto Desolace,29.37,50.94,25,0
.goto Desolace,29.74,53.50
>>Click the |cRXP_PICK_Mouthpiece Mount|r on the summit overlooking Maraudon, then kill waves of Maraudine centaur until |cRXP_ENEMY_Khan Hratha|r spawns. Kill him, then loot his |cRXP_LOOT_Key Fragment|r
.complete 1380,1 
.group 2
.mob Maraudine Khan Guard
.mob Maraudine Stormer
.mob Maraudine Khan Advisor
.mob Khan Hratha
step
.goto Desolace,33.90,53.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Melizza|r to start the escort
.accept 6132 >> Accept Get Me Out of Here!
.target Melizza Brimbuzzle
.group 2
step
>>Escort |cRXP_FRIENDLY_Melizza|r to safety
>>|cRXP_WARN_Two waves of mobs will spawn during the scort. The mobs of the first wave won't attack|r |cRXP_FRIENDLY_Melizza|r|cRXP_WARN_. The 2nd wave has 5 mobs, so use all cooldowns for it|r
.complete 6132,1
.group 2
step
.goto Desolace,36.30,79.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uthek|r
.turnin 1380 >> Turn in Khan Hratha
.target Uthek the Wise
.group
step
.goto Desolace,47.80,61.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hornizz|r
.turnin 6132 >> Turn in Get Me Out of Here!
.turnin 6134 >> Turn in Ghost-o-plasm Round Up
.target Hornizz Brimbuzzle
.isQuestComplete 6132
.group
step
.goto Desolace,47.83,61.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hornizz|r
.turnin 6134 >> Turn in Ghost-o-plasm Round Up
.target Hornizz Brimbuzzle
step
.goto Desolace,52.60,54.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Takata|r
.turnin 1488 >> Turn in The Corrupter
.target Takata Steelblade
step
#completewith next
.hs >> Hearth back to Camp Taurajo
.use 6948
step
.goto The Barrens,45.58,59.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Byula|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Byula
step
.goto The Barrens,44.45,59.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa|r
.fly Tanaris >> Fly to Tanaris
.target Omusa Thunderhorn
.zoneskip Tanaris
step
.abandon 1380 >> Abandon Khan Hratha
.isOnQuest 1380
step
.abandon 6132 >> Abandon Get Me Out of Here!
.isOnQuest 6132
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 43-45 Tanaris/Dustwallow
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 40-50
#next 45-46 Feralas
step
.goto Tanaris,51.60,26.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tran'rek|r
.turnin 2864 >> Turn in Tran'rek
.target Tran'rek
step
.goto Tanaris,51.80,26.90
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cRXP_PICK_Wanted Poster|r
.accept 2781 >> Accept WANTED: Caliph Scorpidsting
step
.goto Tanaris,52.50,27.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Fizzgrimble|r
.home >> Set your Hearthstone to Gadgetzan
.target Innkeeper Fizzgrimble
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bilgewhizzle|r and |cRXP_FRIENDLY_Luglunket|r
.turnin 243 >> Turn in Into the Field
.accept 379 >> Accept Slake That Thirst
.accept 1690 >> Accept Wastewander Justice
.goto Tanaris,52.46,28.52
.accept 1707 >> Accept Water Pouch Bounty
.goto Tanaris,52.49,28.44
.target Chief Engineer Bilgewhizzle
.target Spigot Operator Luglunket
step
.goto Tanaris,50.20,27.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzledowser|r
.accept 992 >> Accept Gadgetzan Water Survey
.target Senior Surveyor Fizzledowser
step




step
#completewith next
.goto Tanaris,59.36,24.75,60,0
.goto Tanaris,60.46,23.42,60,0
>>Kill |cRXP_ENEMY_Wastewander Bandits|r and |cRXP_ENEMY_Wastewander Thieves|r in the Noonshade Ruins en route to Steamwheedle Port. Loot them for their |cRXP_LOOT_Water Pouches|r
.complete 1690,1 
.complete 1690,2 
.collect 8483,10 
.mob Wastewander Bandit
.mob Wastewander Thief
step
.goto Tanaris,67.00,22.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yeh'kinya|r
.accept 3520 >> Accept Screecher Spirits
.target Yeh'kinya
step << Hunter
.goto Tanaris,67.01,21.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jabbey|r
>>|cFF0E8312Buy|r |T135661:0|t[Jagged Arrows] |cFF0E8312from him|r
.collect 11285,2600,1690,1 
.target Jabbey
step
.goto Tanaris,67.10,24.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stoley|r
.turnin 2872 >> Turn in Stoley's Debt
.target Stoley
step
.goto Tanaris,64.22,29.16,60,0
.goto Tanaris,63.62,31.32,60,0
.goto Tanaris,63.24,32.84,60,0
.goto Tanaris,59.36,24.75,60,0
.goto Tanaris,60.46,23.42,60,0
.goto Tanaris,63.62,31.32
>>Kill |cRXP_ENEMY_Wastewander Bandits|r and |cRXP_ENEMY_Wastewander Thieves|r. Loot them for their |cRXP_LOOT_Water Pouches|r
.complete 1690,1 
.complete 1690,2 
.collect 8483,10 
.mob Wastewander Bandit
.mob Wastewander Thief
step << Shaman
#completewith next
.hs >> Hearth or Astral Recall to Gadgetzan
.use 6948
step << Shaman
.goto Tanaris,52.50,27.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Fizzgrimble|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Fizzgrimble
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bilgewhizzle|r and |cRXP_FRIENDLY_Luglunket|r
.turnin 379 >> Turn in Slake That Thirst
.turnin 1690 >> Turn in Wastewander Justice
.accept 1691 >> Accept More Wastewander Justice
.goto Tanaris,52.46,28.52
.turnin 1707 >> Turn in Water Pouch Bounty
.goto Tanaris,52.49,28.44
.target Chief Engineer Bilgewhizzle
.target Spigot Operator Luglunket






step << !Shaman
.goto Tanaris,52.50,27.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Fizzgrimble|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Fizzgrimble
step
#completewith next
.goto Tanaris,50.87,23.09,30,0
.goto Thousand Needles,75.49,97.58,30,0
.zone Thousand Needles >>Travel north to the Shimmering Flats
step
.goto Thousand Needles,77.79,77.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kravel|r
.turnin 1117 >> Turn in Rumors for Kravel
.target Kravel Koalbeard
step
.goto Thousand Needles,78.07,77.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzle|r
.turnin 1137 >> Turn in News for Fizzle
.target Fizzle Brassbolts
.isQuestTurnedIn 1108
step
.goto Thousand Needles,80.18,75.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pozzik|r
.turnin 1183 >> Turn in Goblin Sponsorship
.accept 1186 >> Accept The Eighteenth Pilot
.accept 1190 >> Accept Keeping Pace
.target Pozzik
.isQuestTurnedIn 1108
step
.goto Thousand Needles,80.18,75.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pozzik|r
.turnin 1183 >> Turn in Goblin Sponsorship
.accept 1186 >> Accept The Eighteenth Pilot
.target Pozzik
step
.goto Thousand Needles,80.32,76.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Razzeric|r
.turnin 1186 >> Turn in The Eighteenth Pilot
.accept 1187 >> Accept Razzeric's Tweaking
.target Razzeric
step
#completewith next
.goto Thousand Needles,79.81,77.02
>>Talk with |cRXP_FRIENDLY_Zamek|r to create a diversion
.turnin 1191 >> Turn in Zamek's Distraction
.target Zamek
.timer 30,Keeping Pace RP
step
.goto Thousand Needles,77.21,77.41
>>Click on |cRXP_PICK_Rizzle's Unguarded Plans|r inside the metal hut
.turnin 1190 >> Turn in Keeping Pace
.accept 1194 >> Accept Rizzle's Schematics
.isQuestTurnedIn 1108
step
.goto Thousand Needles,77.79,77.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kravel|r
.accept 1118 >> Accept Back to Booty Bay
.target Kravel Koalbeard
step
.goto Thousand Needles,80.18,75.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pozzik|r
.turnin 1194 >> Turn in Rizzle's Schematics
.target Pozzik
.isQuestTurnedIn 1108
step
.hs >> Hearth to Gadgetzan
.use 6948
.cooldown item,6948,>0
step
#completewith next
.goto Thousand Needles,75.44,97.37,40,0
.goto Tanaris,51.60,25.44,100 >> Travel to Gadgetzan
.cooldown item,6948,<0
step
.goto Tanaris,51.60,25.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bulkrek|r
.fly Brackenwall >> Fly to Dustwallow Marsh
.target Bulkrek Ragefist
step
.goto Dustwallow Marsh,36.30,31.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Overlord Mok'Morokk|r
.accept 1166 >> Accept Overlord Mok'Morokk's Concern
.target Overlord Mok'Morokk
step
.goto Dustwallow Marsh,37.10,33.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Draz'Zilb|r
.target Draz'Zilb
.accept 1169 >> Accept Identifying the Brood
step
.goto Dustwallow Marsh,37.30,31.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tharg|r
.accept 1168 >> Accept Army of the Black Dragon
.target Tharg
step
#completewith MokSnuff
.line Dustwallow Marsh,50.57,52.82,50.51,55.20,49.15,57.14,48.01,55.61,47.24,57.70,45.94,61.21,44.69,62.28,45.94,61.21,47.24,57.70,48.01,55.61,47.24,54.53,46.08,54.38,45.72,53.06,46.08,54.38,47.24,54.53,47.15,51.45
>>Find & kill |cRXP_ENEMY_Deadmire|r. He's a White Crocolisk who patrols in the water mires around the area. Loot him for his |cRXP_LOOT_Tooth|r
.complete 1205,1 
.unitscan Deadmire
step
.goto Dustwallow Marsh,54.10,56.50
>>Loot the |cRXP_PICK_Crate|r on the ground near the crashed Zeppelin for the |cRXP_LOOT_Seaforium Booster|r
.complete 1187,1 
step
.loop 25,Dustwallow Marsh,56.51,61.15,55.46,61.60,54.80,62.41,54.31,63.24,54.68,64.41,56.10,65.14,56.52,63.62,56.81,62.56,57.30,60.20
>>Kill |cRXP_ENEMY_Muckshell Makruras|r on the beach. Loot them for the |cRXP_LOOT_Pendant|r
.complete 1261,1 
.isOnQuest 1261
.mob Muckshell Razorclaw
.mob Muckshell Clacker
.mob Muckshell Scrabbler
.mob Muckshell Pincer
.mob Muckshell Snapclaw
.unitscan Lord Angler
step
#completewith Dragondeez
>>Kill the |cRXP_ENEMY_Firemane Dragonkins|r in the area
.complete 1168,1 
.complete 1168,2 
.complete 1168,3 
.mob Firemane Scout
.mob Firemane Ash Tail
.mob Firemane Scalebane
step
#completewith Firemanemobs
>>Kill |cRXP_ENEMY_Whelps|r you see on the borders of the area. Loot them for their |cRXP_LOOT_Tongues|r and |cRXP_LOOT_Hearts|r
.complete 1169,1 
.complete 1169,2 
.mob Searing Whelp
.mob Searing Hatchling
step
#label MokSnuff
.goto Dustwallow Marsh,44.50,66.00
>>Loot the |cRXP_PICK_Barrel|r on the ground for |cRXP_LOOT_Mok'Morokk's Snuff|r
.complete 1166,1 
step
.goto Dustwallow Marsh,38.70,65.60
>>Loot the |cRXP_PICK_Vase|r on the ground for |cRXP_LOOT_Mok'Morokk's Grog|r. Go inside the cave afterward
.complete 1166,2 
step
#label Dragondeez
.goto Dustwallow Marsh,36.60,69.50
>>Loot the |cRXP_PICK_Chest|r in the back of the cave for |cRXP_LOOT_Mok'Morokk's Strongbox|r.
>>Kill the |cRXP_ENEMY_Firemane Scalebane|r whilst you're inside
.complete 1166,3 
.complete 1168,3 
.mob Firemane Scalebane
step
#label Firemanemobs
.goto Dustwallow Marsh,39.08,65.92,80,0
.goto Dustwallow Marsh,42.81,66.35,80,0
.goto Dustwallow Marsh,44.63,66.16,80,0
.goto Dustwallow Marsh,39.08,65.92
>>Finish killing the the |cRXP_ENEMY_Firemane Dragonkins|r in the area
.complete 1168,1 
.complete 1168,2 
.complete 1168,3 
.mob Firemane Scout
.mob Firemane Ash Tail
.mob Firemane Scalebane
step
.goto Dustwallow Marsh,48.10,80.85,60,0
.goto Dustwallow Marsh,47.09,82.39,60,0
.goto Dustwallow Marsh,45.60,82.28,60,0
.goto Dustwallow Marsh,43.99,81.35,60,0
.goto Dustwallow Marsh,42.31,80.73,60,0
.goto Dustwallow Marsh,42.08,78.40,60,0
.goto Dustwallow Marsh,42.45,75.89,60,0
.goto Dustwallow Marsh,45.60,82.28
>>Finish killing |cRXP_ENEMY_Whelps|r. Loot them for their |cRXP_LOOT_Tongues|r and |cRXP_LOOT_Hearts|r
.complete 1169,1 
.complete 1169,2 
.mob Searing Whelp
.mob Searing Hatchling
step
#completewith next
.line Dustwallow Marsh,50.57,52.82,50.51,55.20,49.15,57.14,48.01,55.61,47.24,57.70,45.94,61.21,44.69,62.28,45.94,61.21,47.24,57.70,48.01,55.61,47.24,54.53,46.08,54.38,45.72,53.06,46.08,54.38,47.24,54.53,47.15,51.45
>>Find & kill |cRXP_ENEMY_Deadmire|r. He's a White Crocolisk who patrols in the water mires around the area. Loot him for his |cRXP_LOOT_Tooth|r
.complete 1205,1 
.unitscan Deadmire
step
.goto Dustwallow Marsh,46.021,57.096
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tabetha|r
.accept 2846 >> Accept Tiara of the Deep
.target Tabetha
.dungeon ZF
step
.line Dustwallow Marsh,50.57,52.82,50.51,55.20,49.15,57.14,48.01,55.61,47.24,57.70,45.94,61.21,44.69,62.28,45.94,61.21,47.24,57.70,48.01,55.61,47.24,54.53,46.08,54.38,45.72,53.06,46.08,54.38,47.24,54.53,47.15,51.45
.goto Dustwallow Marsh,50.57,52.82,50,0
.goto Dustwallow Marsh,50.51,55.20,50,0
.goto Dustwallow Marsh,49.15,57.14,50,0
.goto Dustwallow Marsh,48.01,55.61,50,0
.goto Dustwallow Marsh,47.24,57.70,50,0
.goto Dustwallow Marsh,45.94,61.21,50,0
.goto Dustwallow Marsh,44.69,62.28,50,0
.goto Dustwallow Marsh,45.94,61.21,50,0
.goto Dustwallow Marsh,47.24,57.70,50,0
.goto Dustwallow Marsh,47.24,54.53,50,0
.goto Dustwallow Marsh,46.08,54.38,50,0
.goto Dustwallow Marsh,45.72,53.06,50,0
.goto Dustwallow Marsh,46.08,54.38,50,0
.goto Dustwallow Marsh,47.73,53.18,50,0
.goto Dustwallow Marsh,47.15,51.45,50,0
.goto Dustwallow Marsh,50.57,52.82
>>Find & kill |cRXP_ENEMY_Deadmire|r. He's a White Crocolisk who patrols in the water mires around the area. Loot him for his |cRXP_LOOT_Tooth|r
.complete 1205,1 
.unitscan Deadmire
step
#completewith next
.goto Dustwallow Marsh,36.64,31.72,120 >> Travel to Brackenwall Village
step
.goto Dustwallow Marsh,37.10,33.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Draz'Zilb|r
.turnin 1169 >> Turn in Identifying the Brood
.target Draz'Zilb
step
.goto Dustwallow Marsh,36.30,31.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Overlord Mok'Morokk|r
.turnin 1166 >> Turn in Overlord Mok'Morokk's Concern
.target Overlord Mok'Morokk
step
.goto Dustwallow Marsh,37.30,31.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tharg|r
.turnin 1168 >> Turn in Army of the Black Dragon
.target Tharg
step
.goto Dustwallow Marsh,35.30,30.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nazeer|r
.turnin 1261 >> Turn in Marg Speaks
.accept 1262 >> Accept Report to Zor
.target Nazeer Bloodpike
.isQuestComplete 1261
step
.goto Dustwallow Marsh,35.30,30.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nazeer|r
.accept 1262 >> Accept Report to Zor
.target Nazeer Bloodpike
.isQuestTurnedIn 1261
step
#completewith next
.hs >> Hearth to Gadgetzan
.use 6948
step
.goto Tanaris,52.50,27.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Fizzgrimble|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Fizzgrimble
step
.goto Tanaris,51.80,26.90
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cRXP_PICK_Wanted Poster|r
.accept 2781 >> Accept WANTED: Caliph Scorpidsting
step
.use 8524 >>Use the |T134459:0|t[|cFF00BCD4Model 4711-FTZ Power Source|r] to start the quest
.accept 654 >> Accept Tanaris Field Sampling
step
#completewith next
>>Kill |cRXP_ENEMY_Basilisks|r, |cRXP_ENEMY_Hyenas|r and |cRXP_ENEMY_Scorpids|r. Loot them for their their |cRXP_LOOT_Samples|r
>>Use the |cRXP_LOOT_Samples|r to test them
*|cFFFCDC00Do not delete any untested samples|r
.complete 654,1 
.complete 654,2 
.complete 654,3 
.use 9440
.use 9441
.use 9438
.mob Glasshide Basilisk
.mob Glasshide Gazer
.mob Glasshide Petrifier
.mob Starving Blisterpaw
.mob Blisterpaw Hyena
.mob Murderous Blisterpaw
.mob Rabid Blisterpaw
.mob Scorpid Tail Lasher
.mob Scorpid Hunter
.mob Scorpid Dunestalker
.mob Scorpid Duneburrower
step
.goto Tanaris,39.10,29.30
.use 8584 >> the |T134867:0|t[Untapped Dowsing Widget] at the pool. Run away from the two mobs that spawn without attacking them.
.complete 992,1 
step
.goto Tanaris,55.94,32.72,90,0
.goto Tanaris,53.75,35.37,90,0
.goto Tanaris,51.13,35.41,90,0
.goto Tanaris,50.18,32.78,90,0
.goto Tanaris,47.99,33.20,90,0
.goto Tanaris,45.47,32.72,90,0
.goto Tanaris,42.52,32.90,90,0
.goto Tanaris,41.23,33.18,90,0
.goto Tanaris,38.30,32.55,90,0
.goto Tanaris,47.99,33.20
>>Kill |cRXP_ENEMY_Basilisks|r, |cRXP_ENEMY_Hyenas|r and |cRXP_ENEMY_Scorpids|r. Loot them for their their |cRXP_LOOT_Samples|r
>>Use the |cRXP_LOOT_Samples|r to test them
*|cFFFCDC00Do not delete any untested samples|r
.complete 654,1 
.complete 654,2 
.complete 654,3 
.use 9440
.use 9441
.use 9438
.mob Glasshide Basilisk
.mob Glasshide Gazer
.mob Glasshide Petrifier
.mob Starving Blisterpaw
.mob Blisterpaw Hyena
.mob Murderous Blisterpaw
.mob Rabid Blisterpaw
.mob Scorpid Tail Lasher
.mob Scorpid Hunter
.mob Scorpid Dunestalker
.mob Scorpid Duneburrower
step
.goto Tanaris,50.20,27.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzledowser|r
.turnin 992 >> Turn in Gadgetzan Water Survey
.target Senior Surveyor Fizzledowser
step
.goto Tanaris,52.40,28.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bilgewhizzle|r
.turnin 654 >> Turn in Tanaris Field Sampling
.target Chief Engineer Bilgewhizzle
.isOnQuest 654
step
#completewith next
.line Tanaris,61.91,35.57,61.91,34.80,62.93,33.28,63.92,31.73,63.93,33.36,63.43,34.33,62.47,35.20,61.91,35.57,60.95,36.69,60.33,37.27,59.56,38.41,58.86,39.41,59.56,38.41,60.33,37.27,60.95,36.69,61.91,35.57,62.47,35.20,63.35,37.42,62.21,37.99,60.84,38.59,62.21,37.99,63.35,37.42,64.21,36.43,64.64,35.28,64.30,33.66,64.18,32.42,63.94,31.73
>>Kill |cRXP_ENEMY_Caliph Scorpidsting|r. Loot him for his |cRXP_LOOT_Head|r
>>|cRXP_WARN_Be careful; he has two stealthed adds with him|r
.complete 2781,1 
.unitscan Caliph Scorpidsting
step
.goto Tanaris,58.75,36.42,80,0
.goto Tanaris,60.10,37.07,80,0
.goto Tanaris,60.84,38.91,80,0
.goto Tanaris,61.04,32.76,80,0
.goto Tanaris,61.84,34.95,80,0
.goto Tanaris,63.48,37.90,80,0
.goto Tanaris,63.80,39.94,80,0
.goto Tanaris,65.10,39.50,80,0
.goto Tanaris,65.36,36.67,80,0
.goto Tanaris,61.04,32.76
>>Kill |cRXP_ENEMY_Wastewander Rogues|r, |cRXP_ENEMY_Assassins|r and |cRXP_ENEMY_Shadow Mages|r
.complete 1691,1 
.complete 1691,2 
.complete 1691,3 
.mob Wastewander Rogue
.mob Wastewander Assassin
.mob Wastewander Shadow Mage
step
.line Tanaris,61.91,35.57,61.91,34.80,62.93,33.28,63.92,31.73,63.93,33.36,63.43,34.33,62.47,35.20,61.91,35.57,60.95,36.69,60.33,37.27,59.56,38.41,58.86,39.41,59.56,38.41,60.33,37.27,60.95,36.69,61.91,35.57,62.47,35.20,63.35,37.42,62.21,37.99,60.84,38.59,62.21,37.99,63.35,37.42,64.21,36.43,64.64,35.28,64.30,33.66,64.18,32.42,63.94,31.73
.goto Tanaris,61.09,35.99,60,0
.goto Tanaris,61.91,34.80,60,0
.goto Tanaris,62.93,33.28,60,0
.goto Tanaris,63.92,31.73,60,0
.goto Tanaris,63.93,33.36,60,0
.goto Tanaris,63.43,34.33,60,0
.goto Tanaris,62.47,35.20,60,0
.goto Tanaris,61.91,35.57,60,0
.goto Tanaris,60.95,36.69,60,0
.goto Tanaris,60.33,37.27,60,0
.goto Tanaris,59.56,38.41,60,0
.goto Tanaris,58.86,39.41,60,0
.goto Tanaris,59.56,38.41,60,0
.goto Tanaris,60.33,37.27,60,0
.goto Tanaris,60.95,36.69,60,0
.goto Tanaris,61.91,35.57,60,0
.goto Tanaris,62.47,35.20,60,0
.goto Tanaris,63.35,37.42,60,0
.goto Tanaris,62.21,37.99,60,0
.goto Tanaris,60.84,38.59,60,0
.goto Tanaris,62.21,37.99,60,0
.goto Tanaris,63.35,37.42,60,0
.goto Tanaris,64.21,36.43,60,0
.goto Tanaris,64.64,35.28,60,0
.goto Tanaris,64.30,33.66,60,0
.goto Tanaris,64.18,32.42,60,0
.goto Tanaris,63.94,31.73
>>Kill |cRXP_ENEMY_Caliph Scorpidsting|r. Loot him for his |cRXP_LOOT_Head|r
>>|cRXP_WARN_Be careful; he has two stealthed adds with him|r
.complete 2781,1 
.unitscan Caliph Scorpidsting
step
.goto Tanaris,52.40,28.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bilgewhizzle|r
.turnin 1691 >> Turn in More Wastewander Justice
.turnin 2781 >> Turn in WANTED: Caliph Scorpidsting
.target Chief Engineer Bilgewhizzle
step
#sticky
#completewith EnterUldaman
.subzone 1337 >> Now you should be looking for a group to Uldaman
.dungeon ULDA
step << !Mage
.goto Tanaris,51.60,25.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bulkrek|r
.fly Orgrimmar >> Fly to Orgrimmar
.target Bulkrek Ragefist
.zoneskip Tanaris
.dungeon ULDA
step << Mage
.cast 3567 >>Cast |T135759:0|t[Teleport: Orgrimmar]
.zoneskip Orgrimmar
.dungeon ULDA
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 10185 >> Train your class spells
.target Pephredo
.xp <44,1
.xp >46,1
.dungeon ULDA
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 10197 >> Train your class spells
.target Pephredo
.xp <46,1
.dungeon ULDA
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 10927 >> Train your class spells
.target Ur'kyo
.xp <44,1
.xp >46,1
.dungeon ULDA
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 10945 >> Train your class spells
.target Ur'kyo
.xp <46,1
.dungeon ULDA
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 16315 >> Train your class spells
.target Kardris Dreamseeker
.xp <44,1
.xp >46,1
.dungeon ULDA
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 10472 >> Train your class spells
.target Kardris Dreamseeker
.xp <46,1
.dungeon ULDA
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14285 >> Train your class spells
.target Ormak Grimshot
.xp <44,1
.xp >46,1
.dungeon ULDA
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14304 >> Train your class spells
.target Ormak Grimshot
.xp <46,1
.dungeon ULDA
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 11584 >> Train your class spells
.target Grezz Ragefist
.xp <44,1
.xp >46,1
.dungeon ULDA
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 11578 >> Train your class spells
.target Grezz Ragefist
.xp <46,1
.dungeon ULDA
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 11341 >> Train your class spells
.target Ormok
.xp <44,1
.xp >46,1
.dungeon ULDA
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 11293 >> Train your class spells
.target Ormok
.xp <46,1
.dungeon ULDA
step << Rogue
.goto Orgrimmar,42.10,49.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Rekkul|r|cRXP_BUY_. Buy |r |T134387:0|t[Flash Powder] |cRXP_BUY_from him|r
.collect 5140,20,2479,1 
.target Rekkul
.dungeon ULDA
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 11671 >> Train your class spells
.target Mirket
.xp <44,1
.xp >46,1
.dungeon ULDA
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 11699 >> Train your class spells
.target Mirket
.xp <46,1
.dungeon ULDA
step
#completewith next
.zone Durotar >> Leave Orgrimmar
.zoneskip Durotar
.dungeon ULDA
step
.goto Durotar,50.8,13.8,40 >>Go up the Zeppelin Tower
.zone Stranglethorn Vale >>Take the Zeppelin to Grom'Gol Base Camp
.zoneskip Stranglethorn Vale
.dungeon ULDA
step
.goto Stranglethorn Vale,32.5,29.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thysta|r
.fly Badlands >> Fly to Badlands
.target Thysta
.dungeon ULDA
step
.goto Badlands,2.42,46.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jarkal Mossmeld|r
.accept 2202 >> Accept Uldaman Reagent Run
.target Jarkal Mossmeld
.isQuestTurnedIn 2258
.dungeon ULDA
step
.goto Badlands,51.38,76.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Theldurin the Lost|r
.accept 709 >> Accept Solution to Doom
.target Theldurin the Lost
.dungeon ULDA
step
.goto 1415,52.36,63.59
.zone 1415 >> Travel to Uldaman
.dungeon ULDA
step
#completewith EnterUldaman
>>If you loot the |T133289:0|t[Shattered Necklace], save it in your inventory
.collect 7666,1 
.dungeon ULDA
step
#completewith Treasure
>>Loot the |cRXP_LOOT_Magenta Fungus Caps|r on the ground
>>|cRXP_WARN_This can be completed INSIDE and OUTSIDE of Uldaman|r
.complete 2202,1 
.isOnQuest 2202
.dungeon ULDA
step
.goto 1415,52.107,64.008
>>Open the |cRXP_PICK_Ancient Chest|r. Loot it for the |cRXP_LOOT_Tablet of Ryun'eh|r
>>|cRXP_WARN_This is completed OUTSIDE of Uldaman|r
.complete 709,1 
.isOnQuest 709
.dungeon ULDA
step
#label Treasure
.goto Eastern Kingdoms,53.81,57.94,0
.goto Eastern Kingdoms,53.78,58.23
>>Loot the |cRXP_PICK_Garret Family Chest|r in the southern corner of the South Common Hall for the |cRXP_LOOT_Garrett Family Treasure|r
>>|cRXP_WARN_The South Common Hall is southwest of the Uldaman instance portal|r
.complete 2342,1 
.isOnQuest 2342
.dungeon ULDA
step
#completewith next
>>Loot the |cRXP_LOOT_Magenta Fungus Caps|r on the ground
>>|cRXP_WARN_This can be completed INSIDE and OUTSIDE of Uldaman|r
.complete 2202,1 
.isOnQuest 2202
.dungeon ULDA
step
#label EnterUldaman
.goto 1415,51.851,63.40
.zone 230 >> Zone into Uldaman
.dungeon ULDA
step
#completewith next
>>Loot the |cRXP_LOOT_Magenta Fungus Caps|r on the ground
>>|cRXP_WARN_This can be completed INSIDE and OUTSIDE of Uldaman|r
.complete 2202,1 
.isOnQuest 2202
.dungeon ULDA
step
>>Kill |cRXP_ENEMY_Archaedas|r
>>Click |cRXP_PICK_The Discs of Norgannon|r
.accept 2278 >> Accept The Platinum Discs
.mob Archaedas
.dungeon ULDA
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lore Keeper of Norgannon|r
.complete 2278,1 
.skipgossip
.target Lore Keeper of Norgannon
.dungeon ULDA
step
>>Click |cRXP_PICK_The Discs of Norgannon|r
.turnin 2278 >> Turn in The Platinum Discs
.accept 2280 >> Accept The Platinum Discs
.dungeon ULDA
step
.zone Badlands >>Leave Uldaman
.dungeon ULDA
step
.goto Badlands,51.38,76.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Theldurin the Lost|r
.turnin 709 >> Turn in Solution to Doom
.accept 728 >> Accept To the Undercity for Yagyin's Digest
.target Theldurin the Lost
.isQuestComplete 709
.dungeon ULDA
step
.goto Badlands,2.42,46.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jarkal Mossmeld|r
.turnin 2202 >> Turn in Uldaman Reagent Run
.target Jarkal Mossmeld
.dungeon ULDA
step
.hs >> Hearth to Gadgetzan
.use 6948
.cooldown item,6948,>0
.dungeon ULDA
step
.goto Tanaris,51.60,25.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bulkrek|r
.fly Freewind >> Fly to Freewind Post
.target Bulkrek Ragefist
step
.abandon 2202 >> Abandon Accept Uldaman Reagent Run
.isOnQuest 2202
.dungeon ULDA
step
.abandon 709 >> Abandon Solution to Doom
.isOnQuest 709
.dungeon ULDA
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 45-46 Feralas
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 40-50
#next 46-47 Southern Stranglethorn
step
#completewith next
.zone Feralas >> Travel to Feralas
step
.goto Feralas,76.06,43.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bronk|r
.vendor >> |cRXP_BUY_Buy|r |T134833:0|t[Superior Healing Potions] |cRXP_BUY_from him if they're up|r
.target Bronk
step
.goto Feralas,75.70,44.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Orwin|r
.accept 2987 >> Accept Gordunni Cobalt
.target Orwin Gizzmick
step
.goto Feralas,75.70,43.62,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rok|r
.turnin 2981 >> Turn in A Threat in Feralas
.accept 2975 >> Accept The Ogres of Feralas
.target Rok Orhan
step
.goto Feralas,76.00,42.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Krueg|r
.accept 2973 >> Accept A New Cloak's Sheen
.target Krueg Skullsplitter
step
.goto Feralas,74.90,42.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Hadoken|r
.accept 2862 >> Accept War on the Woodpaw
.target Hadoken Swiftstrider
step
.goto Feralas,74.50,42.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tEnter the longhouse, then talk to |cFF00FF25Jangdor|r
.accept 2822 >> Accept The Mark of Quality
.target Jangdor Swiftstrider
step
.goto Feralas,74.81,45.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Innkeeper Greul|r
.home >> Set your Hearthstone to Camp Mojache
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Greul
step
.goto Feralas,72.79,39.32,60,0
.goto Feralas,72.11,37.21,60,0
.goto Feralas,73.18,36.29,60,0
.goto Feralas,72.79,39.32
>>Kill |cFFFF5722Woodpaw Gnolls|r northwest of Camp Mojache. Loot them for their |cFF00BCD4Manes|r
.complete 2862,1 
.mob Woodpaw Mongrel
.mob Woodpaw Trapper
.mob Woodpaw Brute
.mob Woodpaw Reaver
.mob Woodpaw Mystic
.mob Woodpaw Alpha
step
#completewith Scroll
.goto Feralas,75.30,28.26,0
.use 9466 >>Stand near the blue circles, then use |T134435:0|t[Orwin's Shovel]
>>Loot the |cFFDB2EEFGordunni Dirt Mounds|r for |cFF00BCD4Gordunni Cobalt|r
.complete 2987,1 
step
#completewith Shovel
.goto Feralas,76.10,33.20,0
>>Kill |cFFFF5722Gordunni Ogres|r, |cFFFF5722Ogre Mages|r, and |cFFFF5722Brutes|r at the Gordunni Outpost
.complete 2975,1 
.complete 2975,2 
.complete 2975,3 
.mob Gordunni Ogre
.mob Gordunni Ogre Mage
.mob Gordunni Brute
step
#label Scroll
.goto Feralas,75.25,34.44,0
.loop 25,Feralas,79.4,34.8,80.5,34.3,80.8,35.0,75.1,29.8,75.2,28.7,74.6,27.9,79.4,34.8,80.5,34.3,80.8,35.0,75.1,29.8,75.2,28.7,74.6,27.9,79.4,34.8
>>Loot the |cFFDB2EEFScroll|r on the ground for the |T134943:0|t[|cFF00BCD4Gordunni Scroll|r]. Use it to start the quest
>>|cFFFCDC00Follow the arrow to its different spawn locations|r
.collect 9370,1,2978,1 
.accept 2978 >> Accept The Gordunni Scroll
.use 9370
step
#label Shovel
.goto Feralas,74.29,28.98,30,0
.goto Feralas,75.35,28.23,30,0
.goto Feralas,76.01,29.00,30,0
.goto Feralas,76.89,29.60,30,0
.goto Feralas,76.47,33.05,30,0
.goto Feralas,76.70,33.86,30,0
.goto Feralas,74.29,28.98
.use 9466 >>Stand near the blue circles, then use |T134435:0|t[Orwin's Shovel]
>>Loot the |cFFDB2EEFGordunni Dirt Mounds|r for |cFF00BCD4Gordunni Cobalt|r
.complete 2987,1 
step
.goto Feralas,74.82,27.53,50,0
.goto Feralas,75.25,29.55,50,0
.goto Feralas,76.51,30.48,50,0
.goto Feralas,75.45,34.59,50,0
.goto Feralas,74.82,27.53
>>Kill |cFFFF5722Gordunni Ogres|r, |cFFFF5722Ogre Mages|r, and |cFFFF5722Brutes|r at the Gordunni Outpost
.complete 2975,1 
.complete 2975,2 
.complete 2975,3 
.mob Gordunni Ogre
.mob Gordunni Ogre Mage
.mob Gordunni Brute
step
.goto Feralas,76.10,33.20
.xp 45 >> Grind to 45
step << Shaman
#completewith WoodpawWarTurnin
.hs >> Hearth to Camp Mojache
.use 6948
step << !Shaman
#completewith next
.goto Feralas,74.73,43.59,150 >> Return to Camp Mojache
step
#label WoodpawWarTurnin
.goto Feralas,74.90,42.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Hadoken|r
.turnin 2862 >> Turn in War on the Woodpaw
.accept 2863 >> Accept Alpha Strike
.target Hadoken Swiftstrider
step
.goto Feralas,75.80,43.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rok|r
.turnin 2975 >> Turn in The Ogres of Feralas
.accept 2980 >> Accept The Ogres of Feralas
.turnin 2978 >> Turn in The Gordunni Scroll
.accept 2979 >> Accept Dark Ceremony
.target Rok Orhan
step
.goto Feralas,75.70,44.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Orwin|r
.turnin 2987 >> Turn in Gordunni Cobalt
.target Orwin Gizzmick
step
.goto Feralas,68.80,48.00
>>Kill |cFFFF5722Sprite Darters|r. Loot them for their |cFF00BCD4Wings|r
.complete 2973,1 
.mob Sprite Darter
step
.loop 25,Feralas,67.50,55.60,69.05,55.78,68.60,54.25,71.51,55.98,72.42,56.63,73.21,56.25,72.42,56.63,71.51,55.98,68.60,54.25,69.05,55.7867.50,55.60
>>Kill |cFFFF5722Woodpaw Alphas|r within the allotted time
*|cFFFCDC00There's usually one in each camp|r
.complete 2863,1 
.unitscan Woodpaw Alpha
step
#completewith KruegTurnin1
.hs >> Hearth to Camp Mojache
.use 6948
.cooldown item,6948,>0
step
#completewith next
.goto Feralas,74.73,43.59,150 >> Return to Camp Mojache
.cooldown item,6948,<0
step
#label KruegTurnin1
.goto Feralas,76.00,42.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Krueg|r
.turnin 2973 >> Turn in A New Cloak's Sheen
.accept 2974 >> Accept A Grim Discovery
.target Krueg Skullsplitter
step
.goto Feralas,74.90,42.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Hadoken|r
.turnin 2863 >> Turn in Alpha Strike
.accept 2902 >> Accept Woodpaw Investigation
.target Hadoken Swiftstrider
step
.goto Feralas,76.06,43.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bronk|r
.vendor >> |cRXP_BUY_Buy|r |T134833:0|t[Superior Healing Potions] |cRXP_BUY_from him if they're up|r
.target Bronk
step
.goto Feralas,69.92,38.97,60,0
.goto Feralas,68.71,39.90,60,0
.goto Feralas,68.08,46.12,60,0
.goto Feralas,66.63,46.62,60,0
.goto Feralas,69.92,38.97,60,0
.goto Feralas,66.63,46.62
>>Kill |cFFFF5722Grimtotem Taurens|r. Loot them for their |cFF00BCD4Horns|r
.complete 2974,1 
.mob Grimtotem Shaman
.mob Grimtotem Raider
.mob Grimtotem Naturalist
step
.goto Feralas,71.60,55.90
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cFFDB2EEFWoodpaw Battle Map|r, on top of a crate
.turnin 2902 >> Turn in Woodpaw Investigation
.accept 2903 >> Accept The Battle Plans
step
.goto Feralas,76.00,42.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Krueg|r
.turnin 2974 >> Turn in A Grim Discovery
.accept 2976 >> Accept A Grim Discovery
.target Krueg Skullsplitter
step
.goto Feralas,74.90,42.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Hadoken|r
.turnin 2903 >> Turn in The Battle Plans
.accept 7730 >> Accept Zukk'ash Infestation
.accept 7731 >> Accept Stinglasher
.target Hadoken Swiftstrider
step
#completewith next
.goto Feralas,73.38,62.94,0
>>Kill |cFFFF5722Zukk'ash Silithid|r. Loot them for their |cFF00BCD4Carapace|r
.complete 7730,1 
.mob Zukk'ash Worker
.mob Zukk'ash Wasp
.mob Zukk'ash Tunneler
.mob Zukk'ash Stinger
step
.goto Feralas,73.38,63.24,-1
.goto Feralas,76.36,61.19,-1
>>Kill |cFFFF5722Stinglasher|r. Loot it for its |cFF00BCD4Glands|r
>>|cFFFCDC00This mob can be quite hard make sure to have cooldowns available|r
>>It patrols all around the outside of the Silithid Hives
.complete 7731,1 
.unitscan Stinglasher
step
.goto Feralas,75.21,61.82,60,0
.goto Feralas,74.10,62.42,60,0
.goto Feralas,72.86,62.78,60,0
.goto Feralas,75.21,61.82,60,0
.goto Feralas,72.86,62.78
>>Kill |cFFFF5722Zukk'ash Silithid|r. Loot them for their |cFF00BCD4Carapace|r
.complete 7730,1 
.mob Zukk'ash Worker
.mob Zukk'ash Wasp
.mob Zukk'ash Tunneler
.mob Zukk'ash Stinger
step
.goto Feralas,74.90,42.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Hadoken|r
.turnin 7730 >> Turn in Zukk'ash Infestation
.turnin 7731 >> Turn in Stinglasher
.accept 7732 >> Accept Zukk'ash Report
.target Hadoken Swiftstrider
step
#completewith egghypo
.goto Feralas,56.15,46.88,0
.use 10699 >>Kill |cFFFF5722Vale Screechers|r, then use |T135474:0|t[Yeh'kinya's Bramble] on their corpses
.complete 3520,1 
.unitscan Rogue Vale Screecher
.unitscan Vale Screecher
step
#completewith next
.goto Feralas,58.59,69.85,0
>>Kill |cFFFF5722Gordunni Mage-Lords|r. Loot them for their |cFF00BCD4Orb|r
.complete 2979,1 
.mob Gordunni Mage-Lord
step
.goto Feralas,61.86,54.46,60,0
.goto Feralas,61.03,56.55,60,0
.goto Feralas,60.69,58.52,60,0
.loop 25,Feralas,59.72,62.77,58.93,64.13,58.31,65.20,58.25,66.56,58.55,67.75,59.54,68.37,60.85,69.68,60.95,67.65,60.35,66.63,60.11,64.93,59.58,64.51,59.72,62.77
>>Kill |cFFFF5722Gordunni Maulers|r, |cFFFF5722Warlocks|r, and |cFFFF5722Shaman|r around the Ruins of Isildien
.complete 2980,1 
.complete 2980,2 
.complete 2980,3 
.mob Gordunni Shaman
.mob Gordunni Warlock
.mob Gordunni Mauler
step
.loop 25,Feralas,59.72,62.77,58.93,64.13,58.31,65.20,58.25,66.56,58.55,67.75,59.54,68.37,60.85,69.68,60.95,67.65,60.35,66.63,60.11,64.93,59.58,64.51,59.72,62.77
>>Kill |cFFFF5722Gordunni Mage-Lords|r. Loot them for their |cFF00BCD4Orb|r
.complete 2979,1 
.mob Gordunni Mage-Lord
step
#completewith next
.use 10699 >>Kill |cFFFF5722Vale Screechers|r, then use |T135474:0|t[Yeh'kinya's Bramble] on their corpses
.complete 3520,1 
.unitscan Rogue Vale Screecher
.unitscan Vale Screecher
step
#label egghypo
.goto Feralas,56.66,75.89
>>Travel south along the mountains, then loot a |T132833:0|t[Hippogryph Egg] from a hippogryph nest
.collect 8564,1 
step
#completewith next
.use 10699 >>Kill |cFFFF5722Rogue Vale Screechers|r, then use |T135474:0|t[Yeh'kinya's Bramble] on their corpses
.complete 3520,1 
.unitscan Rogue Vale Screecher
.unitscan Vale Screecher
step
.loop 25,Feralas,56.71,64.09,56.61,62.01,55.87,60.34,54.79,60.44,55.30,62.17,54.49,64.33,55.23,66.21,55.88,65.91,56.71,64.09
>>Kill |cRXP_ENEMY_Frayfeather Hippogryphs|r. Loot them for their |cFF00BCD4Feathers|r
.collect 4589,10 
.mob Frayfeather Hippogryph
step
.goto Feralas,58.45,55.83,-1
.goto Feralas,56.70,56.13,-1
>>Kill |cFFFF5722Vale Screechers|r, then use |T135474:0|t[Yeh'kinya's Bramble] on their corpses
.complete 3520,1 
.unitscan Rogue Vale Screecher
.unitscan Vale Screecher
step
.goto Feralas,55.14,56.35,70,0
.goto Feralas,53.12,56.27,70,0
.goto Feralas,52.05,58.40
>>Kill |cFFFF5722Yetis|r. Loot them for their |cFF00BCD4Hides|r
.complete 2822,1 
.mob Feral Scar Yeti
.mob Enraged Feral Scar
.mob Hulking Feral Scar
.mob Lurking Feral Scar
.mob Bloodroar the Stalker
step
.accept 2766 >> Accept Find OOX-22/FE!
.itemcount 8705,1 
.use 8705
step
.goto Feralas,53.35,55.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Homing Robot OOX-22/FE|r
.turnin 2766 >> Turn in Find OOX-22/FE!
.target Homing Robot OOX-22/FE
.isOnQuest 2766
step
.goto Feralas,53.35,55.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Homing Robot OOX-22/FE|r
.accept 2767 >> Accept Rescue OOX-22/FE!
>>|cFFFCDC00This starts the chicken escort; be ready to use cooldowns/consumables, as this quest is HARD|r

.target Homing Robot OOX-22/FE
.isQuestTurnedIn 2766
step
.goto Feralas,55.47,56.37,30,0
.goto Feralas,54.38,51.32,60,0
.goto Feralas,50.31,49.91,40,0
.goto Feralas,48.38,44.83,40,0
.goto Feralas,45.04,43.27
>>|cFFFCDC003 Waves will spawn. Save all your very long cooldowns for the|r |cFFFF5722Gnolls|r|cFFFCDC00, and use some on the|r |cFFFF5722Yetis|r
+3 Yetis (each level 46)
+3 Gorillas
+4 Gnolls
.complete 2767,1 
.isOnQuest 2767
.target Homing Robot OOX-22/FE
step
#completewith next
.hs >> Hearth back to Camp Mojache
.use 6948
step
.goto Feralas,74.81,45.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Innkeeper Greul|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
>>|cFFFCDC00Make sure you DO NOT sell any|r |T135992:0|t[Long Elegant Feather]
.target Innkeeper Greul
step
.goto Feralas,75.80,43.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rok|r
.turnin 2980 >> Turn in The Ogres of Feralas
.turnin 2979 >> Turn in Dark Ceremony
.accept 3002 >> Accept The Gordunni Orb
.target Rok Orhan
step
.goto Feralas,74.40,43.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Uzer'i|r
.accept 3121 >> Accept A Strange Request
.target Witch Doctor Uzer'i
step
.goto Feralas,74.40,42.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jangdor|r
.turnin 2822 >> Turn in The Mark of Quality
.target Jangdor Swiftstrider
step
.goto Feralas,76.06,43.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bronk|r
.vendor >> |cRXP_BUY_Buy|r |T134833:0|t[Superior Healing Potions] |cRXP_BUY_from him if they're up|r
.target Bronk
step << Druid
.goto Feralas,76.0,42.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jannos|r
.train 1824 >>Train your class spells
.target Jannos Lighthoof
.xp <44,1
.xp >46,1
step << Druid
.goto Feralas,76.0,42.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jannos|r
.train 9821 >>Train your class spells
.target Jannos Lighthoof
.xp <46,1
step << !Mage
.goto Feralas,75.45,44.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Shyn|r
.fly Orgrimmar >> Fly to Orgrimmar
.target Shyn
step << Mage
.cast 3567 >>Cast |T135759:0|t[Teleport: Orgrimmar]
.zoneskip Orgrimmar
step
.goto Orgrimmar,39.20,86.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Uthel'nay|r
.turnin 3002 >> Turn in The Gordunni Orb
.target Uthel'nay
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 10185 >> Train your class spells
.target Pephredo
.xp <44,1
.xp >46,1
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 10197 >> Train your class spells
.target Pephredo
.xp <46,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 10927 >> Train your class spells
.target Ur'kyo
.xp <44,1
.xp >46,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 10945 >> Train your class spells
.target Ur'kyo
.xp <46,1
step
.goto Orgrimmar,39.00,38.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Zor|r
.turnin 1262 >> Turn in Report to Zor
.target Zor Lonetree
.isOnQuest 1262
step
.goto Orgrimmar,39.00,38.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Zor|r
.accept 7541 >> Accept Service to the Horde
.turnin 7541 >> Turn in Service to the Horde
.target Zor Lonetree
.isQuestTurnedIn 1262
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 16315 >> Train your class spells
.target Kardris Dreamseeker
.xp <44,1
.xp >46,1
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 10472 >> Train your class spells
.target Kardris Dreamseeker
.xp <46,1
step
.goto Orgrimmar,59.4,36.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dran Droffers|r
.accept 2283 >> Accept Necklace Recovery
.turnin 2283 >> Turn in Necklace Recovery
.target Dran Droffers
.itemcount 7666,1
step
.goto Orgrimmar,56.50,46.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Zilzibin|r
.turnin 7732 >> Turn in Zukk'ash Report
.target Zilzibin Drumlore
step
.goto Orgrimmar,75.20,34.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Belgrom|r
.turnin 2976 >> Turn in A Grim Discovery
.target Belgrom Rockmaul
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14285 >> Train your class spells
.target Ormak Grimshot
.xp <44,1
.xp >46,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14304 >> Train your class spells
.target Ormak Grimshot
.xp <46,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 11584 >> Train your class spells
.target Grezz Ragefist
.xp <44,1
.xp >46,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 11578 >> Train your class spells
.target Grezz Ragefist
.xp <46,1
step << Orc !Warlock
.goto Orgrimmar,69.40,13.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kildar|r and |cRXP_FRIENDLY_Ogunaro|r
.train 825 >>Train |T136103:0|t[Wolf Riding]
.vendor >>|cRXP_BUY_Buy a|r |T132224:0|t[|cFF0070FFWolf|r]
.xp <40,1
.money <90
.skill riding,75,1
.target Kildar
.target Ogunaro
step
.goto Orgrimmar,49.60,50.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Neeru|r
.turnin 3121 >> Turn in A Strange Request
.accept 3122 >> Accept Return to Witch Doctor Uzer'i
.target Neeru Fireblade
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 11341 >> Train your class spells
.target Ormok
.xp <44,1
.xp >46,1
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 11293 >> Train your class spells
.target Ormok
.xp <46,1
step << Rogue
.goto Orgrimmar,42.10,49.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Rekkul|r|cRXP_BUY_. Buy |r |T134387:0|t[Flash Powder] |cRXP_BUY_from him|r
.collect 5140,20,2479,1 
.target Rekkul
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 11671 >> Train your class spells
.target Mirket
.xp <44,1
.xp >46,1
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 11699 >> Train your class spells
.target Mirket
.xp <46,1
step << Warlock
.goto Orgrimmar,47.52,46.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kurgul|r
.vendor >>Buy any pet upgrades you can afford
.target Kurgul
step << Troll
#completewith next
.subzone 367 >> Travel to Sen'Jin Village
step << Troll
.goto Durotar,55.28,75.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xar'Ti|r and |cRXP_FRIENDLY_Zjolnir|r
.train 10861 >>Train |T136103:0|t[Raptor Riding]
.vendor >>|cRXP_BUY_Buy a|r |T132253:0|t[|cFF0070FFRaptor|r]
.xp <40,1
.money <90
.skill riding,75,1
.target Xar'Ti
.target Zjolnir
step
#completewith next
.zone Durotar >> Leave Orgrimmar
.zoneskip Durotar
step
.goto Durotar,50.8,13.8,40 >>Go up the Zeppelin Tower
.zone Stranglethorn Vale >>Take the Zeppelin to Grom'Gol Base Camp
.zoneskip Stranglethorn Vale
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 46-47 Southern Stranglethorn
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 40-50
#next 47-48 Swamp of Sorrows
step
.goto Stranglethorn Vale,32.20,27.60
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cFFDB2EEFBubbling Cauldron|r
.accept 586 >> Accept Speaking with Gan'zulah
step
.goto Stranglethorn Vale,32.10,29.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Far Seer Mok'thardin|r
.accept 571 >> Accept Mok'thardin's Enchantment
.target Far Seer Mok'thardin
step
.goto Stranglethorn Vale,28.80,44.80
>>Kill |cRXP_ENEMY_Tethis|r. Loot him for his |cRXP_LOOT_Talon|r
>>He patrols all around the raptor area
.complete 197,1 
.unitscan Tethis
.group 2
step
#completewith Anathek
>>Kill |cRXP_ENEMY_Skullsplitter Hunters|r, |cRXP_ENEMY_Berserkers|r and |cRXP_ENEMY_Headhunters|r
.complete 586,1 
.complete 586,3 
.complete 586,2 
.mob Skullsplitter Hunter
.mob Skullsplitter Berserker
.mob Skullsplitter Headhunter
step
#completewith next
+This next quest can be quite hard, be extra careful
step
#label Anathek
.goto Stranglethorn Vale,44.3,44.9,30,0
.loop 25,Stranglethorn Vale,47.1,40.7,44.3,44.9,45.8,41.2,47.1,40.7
>>Kill |cRXP_ENEMY_Ana'thek the Cruel|r. Loot him for his |cRXP_LOOT_Armor|r
*|cFFFCDC00Be careful of Ana'thek's adds and his|r |cFFEB144Cexecute ability.|r
.complete 586,4 
.unitscan Ana'thek the Cruel
step
.loop 25,Stranglethorn Vale,47.9,42.9,47.6,44.1,46.0,42.8,44.4,41.9,47.4,39.8,47.9,42.9
>>Kill |cRXP_ENEMY_Skullsplitter Hunters|r, |cRXP_ENEMY_Berserkers|r and |cRXP_ENEMY_Headhunters|r
.complete 586,1 
.complete 586,3 
.complete 586,2 
.mob Skullsplitter Hunter
.mob Skullsplitter Berserker
.mob Skullsplitter Headhunter
step
.loop 25,Stranglethorn Vale,47.26,28.58,49.61,23.98,48.95,19.87,47.26,23.98
.goto Stranglethorn Vale,48.95,19.87,70,0
>>Kill |cRXP_ENEMY_Bhag'thera|r. Loot him for his |cRXP_LOOT_Fang|r
>>|cRXP_WARN_Before engaging |cRXP_ENEMY_Bhag'thera|r. Clear the area of |cRXP_ENEMY_Shadowmaw Panthers|r to avoid adds|r
.complete 193,1 
.mob Shadowmaw Panther
.unitscan Bhag'thera
.group 2
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_S. J. Erlgadin|r and |cRXP_FRIENDLY_Hemet|r
.turnin 193 >> Turn in Panther Mastery
.goto Stranglethorn Vale,35.55,10.55
.turnin 197 >> Turn in Raptor Mastery
.accept 208 >> Accept Big Game Hunter
.goto Stranglethorn Vale,35.66,10.81
.target Sir S. J. Erlgadin
.target Hemet Nesingwary
.group
step
.goto Stranglethorn Vale,32.20,27.70
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cFFDB2EEFBubbling Cauldron|r
.turnin 586 >> Turn in Speaking with Gan'zulah
.accept 588 >> Accept The Fate of Yenniku
step
.goto Stranglethorn Vale,32.20,27.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kin'weelay|r
.turnin 588 >> Turn in The Fate of Yenniku
.accept 589 >> Accept The Singing Crystals
.target Kin'weelay
step
.goto Stranglethorn Vale,32.5,29.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thysta|r
.fly Booty Bay >> Fly to Booty Bay
.target Thysta
step
.goto Stranglethorn Vale,28.35,76.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Oglethorpe|r
.turnin 2767 >> Turn in Rescue OOX-22/FE!
.target Oglethorpe Obnoticus
.isQuestComplete 2767
step
.goto Stranglethorn Vale,26.70,76.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Privateer Bloads|r
.accept 617 >> Accept Akiris by the Bundle
.target Privateer Bloads
step
.goto Stranglethorn Vale,27.10,77.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Crank|r
.turnin 1118 >> Turn in Back to Booty Bay
.accept 621 >> Accept Zanzil's Secret
.target Crank Fizzlebub
step
.goto Stranglethorn Vale,27.70,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25"Sea Wolf" MacKinley|r
.accept 606 >> Accept Scaring Shaky
.target "Sea Wolf" MacKinley
step
.goto Stranglethorn Vale,28.10,76.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25First Mate Crazz|r
.accept 595 >> Accept The Bloodsail Buccaneers
.target First Mate Crazz
step
.goto Stranglethorn Vale,27.27,69.51
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cFFDB2EEFBloodsail Correspondence|r on top of a barrel in the center of the camp
.turnin 595 >> Turn in The Bloodsail Buccaneers
.accept 597 >> Accept The Bloodsail Buccaneers
step
.goto Stranglethorn Vale,28.09,76.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25First Mate Crazz|r
.turnin 597 >> Turn in The Bloodsail Buccaneers
.accept 599 >> Accept The Bloodsail Buccaneers
.target First Mate Crazz
step
.goto Stranglethorn Vale,26.92,77.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Deeg|r
.accept 587 >> Accept Up to Snuff
.target Deeg
step
.goto Stranglethorn Vale,27.17,77.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Fleet Master Seahorn|r
.turnin 599 >> Turn in The Bloodsail Buccaneers
.accept 604 >> Accept The Bloodsail Buccaneers
.target Fleet Master Seahorn
step
.goto Stranglethorn Vale,28.59,75.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Dizzy One-Eye|r
.accept 576 >> Accept Keep An Eye Out
.target Dizzy One-Eye
step
#completewith Swashbucklers
>>Kill |cRXP_ENEMY_Bloodsail Pirates|r. Loot them for |cRXP_LOOT_Dizzy's Eye|r
>>|cRXP_WARN_Don't focus on this, you can finish it later|r
.complete 576,1 
step
#completewith next
>>Kill |cFFFF5722Bloodsail Swashbucklers|r
.complete 604,1 
.mob Bloodsail Swashbuckler
step
.goto Stranglethorn Vale,29.61,80.89,20,0
.goto Stranglethorn Vale,27.75,83.13,20,0
.goto Stranglethorn Vale,27.18,82.66,20,0
.goto Stranglethorn Vale,26.94,82.49
>>Click the |cRXP_LOOT_Bloodsail Orders|r and |cRXP_LOOT_Bloodsail Charts|r
>>|cFFFCDC00They're typically in the large camp on the peninsula, or in the boat near that camp|r
.complete 604,2 
.complete 604,3 
step
#label Swashbucklers
.goto Stranglethorn Vale,32.02,79.47,60,0
.goto Stranglethorn Vale,29.83,81.11,60,0
.goto Stranglethorn Vale,27.18,82.79,60,0
.goto Stranglethorn Vale,32.02,79.47,60,0
.goto Stranglethorn Vale,29.83,81.11,60,0
.goto Stranglethorn Vale,27.18,82.79
>>Kill |cFFFF5722Bloodsail Swashbucklers|r
.complete 604,1 
.mob Bloodsail Swashbuckler
step
.goto Stranglethorn Vale,31.19,68.29,60,0
.goto Stranglethorn Vale,32.92,65.99,60,0
.goto Stranglethorn Vale,33.74,63.40,60,0
.goto Stranglethorn Vale,32.73,61.44,60,0
.goto Stranglethorn Vale,31.12,59.80,60,0
.goto Stranglethorn Vale,31.27,65.53,60,0
.goto Stranglethorn Vale,32.92,65.99,60,0
.goto Stranglethorn Vale,33.74,63.40,60,0
.goto Stranglethorn Vale,32.73,61.44
>>Kill |cRXP_ENEMY_Elder Mistvale Gorillas|r. Loot them for their |cRXP_LOOT_Giblets|r and |cRXP_LOOT_Sinew|r
>>|cRXP_WARN_Save any|r |T134298:0|t[Gorilla Fangs] |cRXP_WARN_you loot. You will need them for another quest later|r
.complete 606,1 
.complete 571,1 
.mob Elder Mistvale Gorilla
.group
step
.goto Stranglethorn Vale,31.19,68.29,60,0
.goto Stranglethorn Vale,32.92,65.99,60,0
.goto Stranglethorn Vale,33.74,63.40,60,0
.goto Stranglethorn Vale,32.73,61.44,60,0
.goto Stranglethorn Vale,31.12,59.80,60,0
.goto Stranglethorn Vale,31.27,65.53,60,0
.goto Stranglethorn Vale,32.92,65.99,60,0
.goto Stranglethorn Vale,33.74,63.40,60,0
.goto Stranglethorn Vale,32.73,61.44
>>Kill |cRXP_ENEMY_Elder Mistvale Gorillas|r. Loot them for their |cRXP_LOOT_Giblets|r and |cRXP_LOOT_Sinew|r
.complete 606,1 
.complete 571,1 
.mob Elder Mistvale Gorilla
.solo
step
.goto Stranglethorn Vale,28.60,75.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Dizzy One-Eye|r
.turnin 576 >> Keep An Eye Out
.target Dizzy One-Eye
.isQuestComplete 576
step
.goto Stranglethorn Vale,26.90,73.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25"Shaky" Phillipe|r
.turnin 606 >> Turn in Scaring Shaky
.accept 607 >> Accept Return to MacKinley
.target "Shaky" Phillipe
step
.goto Stranglethorn Vale,27.70,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25"Sea Wolf" MacKinley|r
.turnin 607 >> Turn in Return to MacKinley
.accept 609 >> Accept Voodoo Dues
.target "Sea Wolf" MacKinley
step
.goto Stranglethorn Vale,27.20,77.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Fleet Master Seahorn|r
.turnin 604 >> Turn in The Bloodsail Buccaneers
.accept 608 >> Accept The Bloodsail Buccaneers
.target Fleet Master Seahorn
.group
step
.goto Stranglethorn Vale,27.20,77.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Fleet Master Seahorn|r
.turnin 604 >> Turn in The Bloodsail Buccaneers
.target Fleet Master Seahorn
step
.goto Stranglethorn Vale,26.87,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gringer|r
.fly Grom'gol >> Fly to Grom'gol Base Camp
.target Gringer
step
.goto Stranglethorn Vale,32.10,29.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Far Seer Mok'thardin|r
.turnin 571 >> Turn in Mok'thardin's Enchantment
.accept 573 >> Accept Mok'thardin's Enchantment
.target Far Seer Mok'thardin
step
.goto Stranglethorn Vale,38.18,35.60
>>Kill |cRXP_ENEMY_King Bangalash|r. Loot him for his |cRXP_LOOT_Head|r
>>|cFFFCDC00This quest is HARD. He comes with 2 mobs when he spawns, and spawns 2 more at about 50% health|r
.complete 208,1 
.unitscan King Bangalash
.group 3
step
.goto Stranglethorn Vale,39.48,47.42,60,0
.goto Stranglethorn Vale,41.67,50.19,60,0
.goto Stranglethorn Vale,43.84,47.77
>>Enter the cave, then kill |cRXP_ENEMY_Ironjaw Basilisks|r. Loot them for their |cRXP_LOOT_Shards|r
.complete 589,1 
.mob Ironjaw Basilisk
step
#completewith Chucky
>>Kill |cRXP_ENEMY_Zanzil Undeads|r. Loot them for their |cRXP_LOOT_Mixture|r
>>|cFFFCDC00Do NOT pull or attack Zanzil the Outcast|r
.complete 621,1 
step
.goto Stranglethorn Vale,35.25,51.25
>>Kill |cRXP_ENEMY_Maury|r. Loot her for her |cRXP_LOOT_Clubbed Foot|r
.complete 609,1 
.unitscan Maury "Club Foot" Wilkins
step
.goto Stranglethorn Vale,34.92,51.84
>>Kill |cRXP_ENEMY_Jon-Jon|r. Loot him for his |cRXP_LOOT_Spyglass|r
.complete 609,2 
.unitscan Jon-Jon the Crow
step
#label Chucky
.goto Stranglethorn Vale,40.00,58.24
>>Kill |cRXP_ENEMY_Chucky|r. Loot him for his |cRXP_LOOT_Ring|r
.complete 609,3 
.unitscan Chucky "Ten Thumbs"
step
.loop 25,Stranglethorn Vale,40.63,60.03,39.66,59.28,38.71,59.72,38.58,58.54,38.90,57.60,39.95,57.25,41.27,57.15,40.77,59.00,40.63,60.03
>>Kill |cRXP_ENEMY_Zanzil Undeads|r. Loot them for their |cRXP_LOOT_Mixture|r
>>|cFFFCDC00Do NOT pull or attack Zanzil the Outcast|r
.complete 621,1 
.mob Zanzil Zombie
.mob Zanzil Hunter
.mob Zanzil Witch Doctor
.mob Zanzil Naga
step
#completewith next
>>Kill |cRXP_ENEMY_Bloodsail Pirates|r. Loot them for |cRXP_LOOT_Dizzy's Eye|r
.complete 576,1 
.mob Bloodsail Swashbuckler
.mob Bloodsail Warlock
.isOnQuest 576
.solo
step
.loop 25,Stranglethorn Vale,24.37,52.88,23.10,52.77,22.77,53.90,23.63,55.24,24.10,54.50,24.53,54.06,24.37,52.88
>>Kill |cRXP_ENEMY_Bloodsail Pirates|r. Loot them for their |cRXP_LOOT_Snuff|r
.complete 587,1 
.mob Bloodsail Swashbuckler
.mob Bloodsail Warlock
.isOnQuest 587
.solo
step
.loop 25,Stranglethorn Vale,24.37,52.88,23.10,52.77,22.77,53.90,23.63,55.24,24.10,54.50,24.53,54.06,24.37,52.88
>>Kill |cRXP_ENEMY_Bloodsail Pirates|r. Loot them for |cRXP_LOOT_Dizzy's Eye|r
.complete 576,1 
.mob Bloodsail Swashbuckler
.mob Bloodsail Warlock
.isOnQuest 576
.solo
step
#completewith next
>>Kill |cRXP_ENEMY_Naga Explorers|r. Loot them for their |cRXP_LOOT_Akiris Reed|r
.complete 573,1 
.complete 617,1 
.mob Naga Explorer
step
.goto Stranglethorn Vale,28.96,61.94
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick |cRXP_PICK_The Holy Spring|r to loot the |cRXP_LOOT_Holy Spring Water|r
.complete 573,1 
step
.loop 25,Stranglethorn Vale,28.00,63.12,28.15,64.42,25.55,63.11,25.07,63.73,24.61,64.59,24.02,63.74,24.15,62.14,24.49,61.33,24.73,59.87,25.21,59.03,25.92,59.52,26.95,59.14,27.00,61.39,28.00,63.12
>>Finish killing |cRXP_ENEMY_Naga Explorers|r. Loot them for their |cRXP_LOOT_Akiris Reed|r
.complete 573,1 
.complete 617,1 
.mob Naga Explorer
step
.goto Stranglethorn Vale,28.60,75.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Dizzy One-Eye|r
.turnin 576 >> Turn in Keep An Eye Out
.target Dizzy One-Eye
.isQuestComplete 576
step
.goto Stranglethorn Vale,27.80,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25"Sea Wolf" MacKinley|r
.turnin 609 >> Turn in Voodoo Dues
.target "Sea Wolf" MacKinley
step
.goto Stranglethorn Vale,27.80,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25"Sea Wolf" MacKinley|r
.accept 613 >> Accept Cracking Maury's Foot
.target "Sea Wolf" MacKinley
.group
step
.goto Stranglethorn Vale,26.70,76.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Privateer Bloads|r
.turnin 617 >> Turn in Akiris by the Bundle
.target Privateer Bloads
step
.goto Stranglethorn Vale,27.11,77.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Crank|r
.turnin 621 >> Turn in Zanzil's Secret
.target Crank Fizzlebub
step
.goto Stranglethorn Vale,27.13,77.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Whiskey Slim|r
.accept 580 >> Accept Whiskey Slim's Lost Grog
.target Whiskey Slim
step
.goto Stranglethorn Vale,27.11,77.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Crank|r
.accept 1119 >> Accept Zanzil's Mixture and a Fool's Stout
.target Crank Fizzlebub
step
.goto Stranglethorn Vale,27.00,77.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Deeg|r
.turnin 587 >> Turn in Up to Snuff
.target Deeg
.isQuestComplete 587
step
.goto Stranglethorn Vale,27.10,77.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Fleet Master Seahorn|r
.turnin 608 >> Turn in The Bloodsail Buccaneers
.target Fleet Master Seahorn
.group
step
.goto Stranglethorn Vale,27.70,76.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Fin|r
.accept 348 >> Accept Stranglethorn Fever
.target Fin Fizracket
.group
step
.goto Stranglethorn Vale,26.70,73.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Captain Hecklebury Smotts|r
.accept 8551 >> Accept The Captain's Chest
.target Captain Hecklebury Smotts
.group
step
.goto Stranglethorn Vale,26.87,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gringer|r
.fly Grom'gol >> Fly to Grom'gol Base Camp
.target Gringer
step
.goto Stranglethorn Vale,32.10,29.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Far Seer Mok'thardin|r
.turnin 573 >> Turn in Mok'thardin's Enchantment
.target Far Seer Mok'thardin
step
.goto Stranglethorn Vale,32.20,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kin'weelay|r
.turnin 589 >> Turn in The Singing Crystals
.accept 591 >> Accept The Mind's Eye
.target Kin'weelay
.group
step
.goto Stranglethorn Vale,32.20,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kin'weelay|r
.turnin 589 >> Turn in The Singing Crystals
.target Kin'weelay
step
.goto Stranglethorn Vale,38.18,35.60
>>Kill |cRXP_ENEMY_King Bangalash|r. Loot him for his |cRXP_LOOT_Head|r
>>|cFFFCDC00This quest is HARD. He comes with 2 mobs when he spawns, and spawns 2 more at about 50%.|r
.complete 208,1 
.unitscan King Bangalash
.group 3
step
#completewith next
>>Kill |cRXP_ENEMY_Mosh'Ogg Ogres|r. Loot them for |cRXP_LOOT_Maury's Key|r
.complete 613,1 
.group 4
step
.goto Stranglethorn Vale,52.93,27.60
>>Kill |cRXP_ENEMY_Mai'Zoth|r. Loot him for the |cRXP_LOOT_Mind's Eye|r
>>|cRXP_WARN_He is located in the back of the cave and is defended by 2 adds|r
.complete 591,1 
.mob Mai'Zoth
.group 4
step
.goto Stranglethorn Vale,50.78,27.74,-1
.goto Stranglethorn Vale,49.25,27.10,-1
>>Kill |cRXP_ENEMY_Mosh'Ogg Ogres|r. Loot them for |cRXP_LOOT_Maury's Key|r
.complete 613,1 
.group 4
step
.goto Stranglethorn Vale,35.70,10.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Hemet|r
.turnin 208 >> Turn in Big Game Hunter
.target Hemet Nesingwary
.isQuestComplete 208
.group
step
.goto Stranglethorn Vale,32.20,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kin'weelay|r
.turnin 591 >> Turn in The Mind's Eye
.accept 592 >> Accept Saving Yenniku
.target Kin'weelay
.group
step
#completewith next
.goto Stranglethorn Vale,32.80,65.80,0
>>Kill any |cRXP_ENEMY_Gorilla|r that you find. Loot them for their |cRXP_LOOT_Fangs|r
.collect 2799,10 
.isOnQuest 348
step
.goto Stranglethorn Vale,35.27,60.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Witch Doctor Unbagwa|r
.turnin 349 >> Turn in Stranglethorn Fever
.target Witch Doctor Unbagwa
.isOnQuest 348
.group 3
step
.goto Stranglethorn Vale,35.27,60.40
>>Face waves of |cRXP_ENEMY_Gorillas|r until |cRXP_ENEMY_Mokk the Savage|r appears. Kill him and loot him for his |cRXP_LOOT_Heart|r
.complete 348,1 
.unitscan Mokk the Savage
.isOnQuest 348
.group 3
step
.goto Stranglethorn Vale,39.0,58.20
.use 3912 >>Use the |T134336:0|t[Soul Gem] on |cRXP_ENEMY_Yenniku|r, then talk to him to retrieve his |cRXP_LOOT_Gem|r
.complete 592,1 
.unitscan Yenniku
.group
.isOnQuest 592
step
.goto Stranglethorn Vale,36.6,39.6
>>Kill |cRXP_ENEMY_Gorlash|r. Loot him for his |cRXP_LOOT_Chest|r
.complete 8551,1 
.isOnQuest 8551
.unitscan Gorlash
.group 3
step
#completewith Keelhaul
.goto Stranglethorn Vale,32.90,88.20,0
.goto Stranglethorn Vale,30.60,90.60,0
.goto Stranglethorn Vale,29.30,88.30,0
>>Search the ships' lower levels until you find a small scroll on the ground. Loot it for |T134939:0|t[|cFF00BCD4Cortello's Riddle|r]. Use it to start the quest
.accept 624 >> Accept Cortello's Riddle
.collect 4056,1,624,1 >> Cortello's Riddle (1)
.use 4056
.group 3
step
#completewith Keelhaul
>>Kill |cRXP_ENEMY_Bloodsail Pirates|r. Loot them for their |cRXP_LOOT_Snuff|r and |cRXP_LOOT_Dizzy's Eye|r
.complete 587,1 
.complete 576,1 
.group
step
.goto Stranglethorn Vale,32.90,88.20
>>Kill |cRXP_ENEMY_Captain Stillwater|r in the 2nd floor at the back of the ship
.complete 608,1 
.unitscan Captain Stillwater
.group 3
step
.goto Stranglethorn Vale,30.60,90.60
>>Kill |cRXP_ENEMY_Fleet Master Firallon|r in the 2nd floor at the back of the ship
.complete 608,3 
.unitscan Fleet Master Firallon
.group 3
step
#label Keelhaul
.goto Stranglethorn Vale,29.30,88.30
>>Kill |cRXP_ENEMY_Captain Keelhaul|r in the 2nd floor at the back of the ship.
>>|cRXP_ENEMY_Garr|r |cRXP_WARN_can charge for heavy damage, stun for 2 seconds, and|r |T132152:0|t[Thrash]
.complete 608,2 
.unitscan Captain Keelhaul
.unitscan Garr Salthoof
.group 3
step
#completewith next
>>Kill |cRXP_ENEMY_Bloodsail Pirates|r. Loot them for their |cRXP_LOOT_Snuff|r
.complete 587,1 
.isOnQuest 587
.group
step
.goto Stranglethorn Vale,32.02,79.47,60,0
.goto Stranglethorn Vale,29.83,81.11,60,0
.goto Stranglethorn Vale,27.18,82.79,60,0
.goto Stranglethorn Vale,32.02,79.47,60,0
.goto Stranglethorn Vale,29.83,81.11,60,0
.goto Stranglethorn Vale,27.18,82.79
>>Kill |cRXP_ENEMY_Bloodsail Pirates|r. Loot them for their |cRXP_LOOT_Dizzy's Eye|r
.complete 576,1 
.isOnQuest 576
.group
step
.goto Stranglethorn Vale,32.02,79.47,60,0
.goto Stranglethorn Vale,29.83,81.11,60,0
.goto Stranglethorn Vale,27.18,82.79,60,0
.goto Stranglethorn Vale,32.02,79.47,60,0
.goto Stranglethorn Vale,29.83,81.11,60,0
.goto Stranglethorn Vale,27.18,82.79
>>Kill |cRXP_ENEMY_Bloodsail Pirates|r. Loot them for their |cRXP_LOOT_Snuff|r
.complete 587,1 
.isOnQuest 587
.group
step
.goto Stranglethorn Vale,26.70,73.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to Booty Bay, then talk to |cFF00FF25Captain Hecklebury Smotts|r
.turnin 8551 >> Turn in The Captain's Chest
.target Captain Hecklebury Smotts
.isQuestComplete 8551
.group
step
.goto Stranglethorn Vale,28.60,75.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Dizzy One-Eye|r
.turnin 576 >> Turn in Keep An Eye Out
.target Dizzy One-Eye
.group
step
.goto Stranglethorn Vale,27.60,76.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Fin Fizracket|r
.turnin 348 >> Turn in Stranglethorn Fever
.target Fin Fizracket
.group
step
.goto Stranglethorn Vale,27.80,77.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25"Sea Wolf" MacKinley|r
.turnin 613 >> Turn in Cracking Maury's Foot
.target "Sea Wolf" MacKinley
.isQuestComplete 613
.group
step
.goto Stranglethorn Vale,27.00,77.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Deeg|r
.turnin 587 >> Turn in Up to Snuff
.target Deeg
.group
step
.goto Stranglethorn Vale,26.87,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gringer|r
.fly Grom'gol >> Fly to Grom'gol Base Camp
.target Gringer
.group
step
.goto Stranglethorn Vale,32.20,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kin'weelay|r
.turnin 592 >> Turn in Saving Yenniku
.target Kin'weelay
.isQuestComplete 592
.group
step
.goto Stranglethorn Vale,32.5,29.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thysta|r
.fly Stonard>> Fly to Stonard
.target Thysta
.zoneskip Swamp of Sorrows
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 47-48 Swamp of Sorrows
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 40-50
#next 47-49 Tanaris
step
.goto Swamp of Sorrows,34.30,66.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r at the Blasted Lands border
.accept 2784 >>Accept Fall From Grace
.target Fallen Hero of the Horde
step
.goto Swamp of Sorrows,34.30,66.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r and go through the whole dialogue
.complete 2784,1 
.target Fallen Hero of the Horde
.skipgossip
step
.goto Blasted Lands,52.76,2.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r
.turnin 2784 >>Turn in Fall From Grace
.accept 2621 >>Accept The Disgraced One
.target Fallen Hero of the Horde
step
#completewith next
.goto Swamp of Sorrows,46.0,54.2,50,0
.subzone 75 >>Travel to Stonard
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fel'zerul|r and |cRXP_FRIENDLY_Ruag|r
.accept 1429 >>Accept The Atal'ai Exile
.goto Swamp of Sorrows,47.93,54.79
.turnin 2621 >>Turn in The Disgraced One
.accept 2622 >>Accept The Missing Orders
.goto Swamp of Sorrows,47.78,54.94
.target Fel'zerul
.target Dispatch Commander Ruags
step
.goto Swamp of Sorrows,44.96,57.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bengor|r
.turnin 2622 >>Turn in The Missing Orders
.accept 2623 >>Accept The Swamp Talker
.target Bengor
step
.goto Swamp of Sorrows,81.31,80.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tok'Kar|r
.accept 699 >>Accept Lack of Surplus
.target Tok'Kar
step
.goto Swamp of Sorrows,45.78,52.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thultazor|r
.vendor >> |cRXP_BUY_Buy|r |T134833:0|t[Superior Healing Potions] |cRXP_BUY_from him if they're up|r
.target Thultazor
step
.goto Swamp of Sorrows,45.38,56.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rartar|r inside the inn
.vendor >> |cRXP_BUY_Buy|r |T134833:0|t[Superior Healing Potions] |cRXP_BUY_from him if they're up|r
.target Rartar
step
.goto Swamp of Sorrows,82.0,68.6,40,0
.goto Swamp of Sorrows,86.6,58.6,40,0
.loop 25,Swamp of Sorrows,87.6,39.6,86.8,35.8,83.2,31.6,82.8,26.2,80.6,20.8,78.6,13.6,74.0,15.6,75.8,20.6,78.6,23.0,79.6,29.2,81.6,33.0,84.8,36.2,87.6,39.6
>>Kill |cRXP_ENEMY_Sawtooth Snappers|r. Loot them for their |cRXP_LOOT_Claws|r
.complete 699,1 
.mob Sawtooth Snapper
step
.goto Swamp of Sorrows,81.40,80.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tok'Kar|r
.turnin 699 >>Turn in Lack of Surplus
.accept 1422 >>Accept Threat From the Sea
.target Tok'Kar
step
.goto Swamp of Sorrows,83.70,80.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Katar|r
.turnin 1422 >>Turn in Threat From the Sea
.accept 1426 >>Accept Threat From the Sea
.target Katar
step
.loop 25,Swamp of Sorrows,85.4,82.8,86.6,79.4,88.6,76.6,91.6,69.6,93.4,64.0,94.6,58.2,95.2,51.0,94.6,58.2,93.4,64.0,91.6,69.6,88.6,76.6,87.2,80.4,86.4,84.6,85.6,88.8,83.6,93.8,81.2,93.0,83.2,88.4,85.4,82.8
>>Kill |cRXP_ENEMY_Marsh Murlocs|r, |cRXP_ENEMY_Marsh Inkspewers|r and |cRXP_ENEMY_Marsh Flesheaters|r
.complete 1426,1 
.complete 1426,2 
.complete 1426,3 
.mob Marsh Murloc
.mob Marsh Inkspewer
.mob Marsh Flesheater
step
.goto Swamp of Sorrows,83.70,80.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Katar|r
.turnin 1426 >>Turn in Threat From the Sea
.accept 1427 >>Accept Threat From the Sea
.target Katar
step
.goto Swamp of Sorrows,81.40,80.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tok'Kar|r
.turnin 1427 >>Turn in Threat From the Sea
.target Tok'Kar
step
.goto Swamp of Sorrows,83.75,80.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Katar|r
.accept 1428 >>Accept Continued Threat
.target Katar
step
#completewith SwampTalker
.goto Swamp of Sorrows,66.03,79.60,40,0
.subzone 1817 >>Travel west and enter Stagalbog Cave
step
#completewith next
>>Kill |cRXP_ENEMY_Marsh Murlocs|r, |cRXP_ENEMY_Marsh Inkspewers|r and |cRXP_ENEMY_Marsh Flesheaters|r
>>|cRXP_WARN_These spawn at a higher rate in Stagalbog Cave west of the camp|r
.complete 1428,1 
.complete 1428,2 
.complete 1428,3 
.mob Marsh Murloc
.mob Marsh Inkspewer
.mob Marsh Flesheater
step
#label SwampTalker
.goto Swamp of Sorrows,66.08,77.67,60,0
.goto Swamp of Sorrows,62.90,87.40
>>Kill |cRXP_ENEMY_Swamp Talker|r. Loot him for the |cRXP_LOOT_Warchief's Orders|r
>>|cRXP_WARN_Save your cooldowns for|r |cRXP_ENEMY_Swamp Talker|r|cRXP_WARN_. His adds die in 1 hit but deal significant damage if left alive.|r
.complete 2623,1 
.unitscan Swamp Talker
step
.loop 25,Swamp of Sorrows,62.48,87.74,60.95,84.20,62.20,83.16,64.60,81.25,66.42,84.59,63.34,86.47,63.84,91.64,62.48,87.74
>>Kill |cRXP_ENEMY_Marsh Murlocs|r, |cRXP_ENEMY_Marsh Inkspewers|r and |cRXP_ENEMY_Marsh Flesheaters|r
>>|cRXP_WARN_These spawn at a higher rate in Stagalbog Cave west of the camp|r
.complete 1428,1 
.complete 1428,2 
.complete 1428,3 
.mob Marsh Murloc
.mob Marsh Inkspewer
.mob Marsh Flesheater
step
.goto Swamp of Sorrows,83.70,80.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Katar|r
.turnin 1428 >>Turn in Continued Threat
.target Katar
step << Hunter/Warlock/Shaman/Warrior
#completewith next
.goto Swamp of Sorrows,46.0,54.2,50,0
.subzone 75 >>Travel west to Stonard
step << Hunter
.goto Swamp of Sorrows,47.27,53.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ogrom|r
.train 14304 >> Train your class spells
.target Ogrom
.xp <46,1
.xp >48,1
step << Hunter
.goto Swamp of Sorrows,47.27,53.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ogrom|r
.train 14321 >> Train your class spells
.target Ogrom
.xp <48,1
step << Hunter
.goto Swamp of Sorrows,47.35,52.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grokor|r
.train 24562 >> Train your pet spells
.target Grokor
.xp <48,1
step << Warlock
.goto Swamp of Sorrows,48.64,55.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kartosh|r
.train 11699 >> Train your class spells
.target Kartosh
.xp <46,1
.xp >48,1
step << Warlock
.goto Swamp of Sorrows,48.64,55.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kartosh|r
.train 11712 >> Train your class spells
.target Kartosh
.xp <48,1
step << Warlock
.goto Swamp of Sorrows,48.59,55.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greshka|r
.vendor >>Buy any pet upgrades you can afford
.target Greshka
step << Shaman
.goto Swamp of Sorrows,48.19,57.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greshka|r
.train 10586 >> Train your class spells
.target Haromm
.xp <46,1
.xp >48,1
step << Shaman
.goto Swamp of Sorrows,48.19,57.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greshka|r
.train 10431 >> Train your class spells
.target Haromm
.xp <48,1
step << Warrior
.goto Swamp of Sorrows,44.89,57.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malosh|r
.train 11578 >> Train your class spells
.target Malosh
.xp <46,1
.xp >48,1
step << Warrior
.goto Swamp of Sorrows,44.89,57.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malosh|r
.train 20661 >> Train your class spells
.target Malosh
.xp <48,1
step
.goto Swamp of Sorrows,34.30,66.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r
.turnin 2623 >>Turn in The Swamp Talker
.accept 2801 >>Accept A Tale of Sorrow
.target Fallen Hero of the Horde
step
.goto Swamp of Sorrows,34.30,66.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r and go through the whole dialogue
.complete 2801,1 
.skipgossip
step
.goto Blasted Lands,52.76,2.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r
.turnin 2801 >>Turn in A Tale of Sorrow
.target Fallen Hero of the Horde
step
.goto Swamp of Sorrows,22.90,48.30
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Soggy Scroll|r in the water beneath the bridge
.turnin 624 >>Turn in Cortello's Riddle
.accept 625 >>Accept Cortello's Riddle
.isOnQuest 624
.group
step
#completewith next
.hs >>Hearth to Camp Mojache
.use 6948
step
.goto Feralas,74.81,45.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Innkeeper Greul|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Greul
step << Druid
.goto Feralas,76.0,42.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jannos|r
.train 9823 >>Train your class spells
.target Jannos Lighthoof
.xp <46,1
.xp >48,1
step << Druid
.goto Feralas,76.0,42.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jannos|r
.train 22828 >>Train your class spells
.target Jannos Lighthoof
.xp <48,1
step
.goto Feralas,74.50,43.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uzer'i|r
.turnin 3122 >>Turn in Return to Witch Doctor Uzer'i
.accept 3123 >>Accept Testing the Vessel
.accept 3380 >>Accept The Sunken Temple
.target Witch Doctor Uzer'i
step
.goto Feralas,75.45,44.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Shyn|r
.fly Tanaris>>Fly to Tanaris
.target Shyn
.zoneskip Tanaris
step
.abandon 197 >> Abandon Raptor Mastery
.isOnQuest 197
step
.abandon 193 >> Abandon Panther Mastery
.isOnQuest 193
step
.abandon 208 >> Abandon Big Game Hunter
.isOnQuest 208
step
.abandon 608 >> Abandon The Bloodsail Buccaneers
.isOnQuest 608
step
.abandon 613 >> Abandon Cracking Maury's Foot
.isOnQuest 613
step
.abandon 348 >> Abandon Stranglethorn Fever
.isOnQuest 348
step
.abandon 8551 >> Abandon The Captain's Chest
.isOnQuest 8551
step
.abandon 591 >> Abandon The Mind's Eye
.isOnQuest 591
step
.abandon 348 >> Abandon Stranglethorn Fever
.isOnQuest 348
step
.abandon 348 >> Abandon Stranglethorn Fever
.isOnQuest 348
step
.abandon 592 >> Abandon in Saving Yenniku
.isOnQuest 592
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 47-49 Tanaris
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 40-50
#next 49-50 The Hinterlands
step
#completewith next
.goto Thousand Needles,70.58,62.69,200 >> Travel to the Shimmering Flats
step
.goto Thousand Needles,77.79,77.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kravel|r
.turnin 1119 >>Turn in Zanzil's Mixture and a Fool's Stout
.timer 13,Kravel Koalbeard RP
.target Kravel Koalbeard
step
.goto Thousand Needles,80.33,76.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Razzeric|r
.turnin 1187 >>Turn in Razzeric's Tweaking
.target Razzeric
.isQuestComplete 1187
step
.goto Thousand Needles,80.33,76.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Razzeric|r
.accept 1188 >>Accept Safety First
.target Razzeric
.isQuestTurnedIn 1187
step
.goto Thousand Needles,77.79,77.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kravel|r
.accept 1120 >>Accept Get the Gnomes Drunk
.target Kravel Koalbeard
step
.goto Thousand Needles,77.56,76.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gnome Pit Boss|r
.turnin 1120 >>Turn in Get the Gnomes Drunk
.target Gnome Pit Boss
step
.goto Thousand Needles,77.79,77.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kravel|r
.accept 1122 >>Accept Report Back to Fizzlebub
.target Kravel Koalbeard
step
.goto Thousand Needles,77.79,77.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzledowser|r
.accept 82 >>Accept Noxious Lair Investigation
.target Kravel Koalbeard
step
#completewith next
.goto Thousand Needles,75.44,97.37,40,0
.subzone 976 >>Travel to Gadgetzan
step
.goto Tanaris,51.90,27.00
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Wanted Poster|r by the giant cage
.accept 2875 >>Accept WANTED: Andre Firebeard
step
.goto Tanaris,51.56,26.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tran'rek|r
.accept 3362 >>Accept Thistleshrub Valley
.target Tran'rek
step
.goto Tanaris,51.00,27.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shreev|r
.turnin 1188 >>Turn in Safety First
.target Shreev
.isQuestComplete 1188
step
.goto Tanaris,51.80,28.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Marin|r
.accept 2605 >>Accept The Thirsty Goblin
.target Marin Noggenfogger
step
.goto Tanaris,52.50,27.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzgrimble|r
.home >>Set your Hearthstone to Gadgetzan
.target Innkeeper Fizzgrimble
step
.goto Tanaris,52.80,27.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Andi|r
.accept 5863 >>Accept The Dunemaul Compound
.target Andi Lynn
step
.goto Tanaris,52.30,27.00
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cRXP_PICK_Egg-O-Matic|r next to the teleporter, then turn in your Hippogryph Egg
.accept 2741 >>Accept The Super Egg-O-Matic
.turnin 2741 >>Turn in The Super Egg-O-Matic
step
#completewith next
.goto Tanaris,52.64,25.73,50,0
.goto Tanaris,67.1,22.4,50,0
.subzone 977 >>Travel east to Steamwheedle Port
step
.goto Tanaris,66.60,22.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Modiste|r
.accept 8365 >>Accept Pirate Hats Ahoy!
.target Haughty Modiste
step
.goto Tanaris,67.00,22.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yeh'kinya|r
.turnin 3520 >>Turn in Screecher Spirits
.target Yeh'kinya
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bilgewhizzle|r and |cRXP_FRIENDLY_Stoley|r
.accept 8366 >>Accept Southsea Shakedown
.goto Tanaris,67.06,23.89
.accept 2873 >>Accept Stoley's Shipment
.goto Tanaris,67.11,23.98
.target Security Chief Bilgewhizzle
.target Stoley
step
#completewith FireBeard
.goto Tanaris,68.76,41.51,30,0
.subzone 1336 >>Travel south to Lost Rigger Cove
step
#completewith StolenCargo
>>Kill |cRXP_ENEMY_Southsea Pirates|r. Loot them for their |cRXP_LOOT_Pirate Hats|r
.complete 8366,1 
.complete 8366,2 
.complete 8366,3 
.complete 8366,4 
.complete 8365,1 
.mob Southsea Pirate
.mob Southsea Freebooter
.mob Southsea Dock Worker
.mob Southsea Swashbuckler
step
#completewith next
>>Loot the |cRXP_PICK_Stolen Cargo|r for |cRXP_LOOT_Stoley's Shipment|r on the second floor of the western house
.complete 2873,1 
step
#label FireBeard
.goto Tanaris,73.37,47.14
>>Kill |cRXP_ENEMY_Andre Firebeard|r. Loot him for his |cRXP_LOOT_Head|r
>>|cRXP_WARN_Be careful, as he pulls with nearby mobs. Split-pull him if you can, then kite to reset the other mobs|r
.complete 2875,1 
.unitscan Andre Firebeard
step
#label StolenCargo
.goto Tanaris,72.23,46.81
>>Loot the |cRXP_PICK_Stolen Cargo|r for |cRXP_LOOT_Stoley's Shipment|r on the second floor of the western house
.complete 2873,1 
step
.loop 25,Tanaris,70.94,42.85,72.22,44.35,72.58,45.30,71.07,46.03,71.25,47.98,72.39,48.23,72.59,47.10,73.27,47.99,74.25,47.27,73.68,45.89,72.58,45.30,72.22,44.35,70.94,42.85
>>Kill |cRXP_ENEMY_Southsea Pirates|r. Loot them for their |cRXP_LOOT_Pirate Hats|r
.complete 8366,1 
.complete 8366,2 
.complete 8366,3 
.complete 8366,4 
.complete 8365,1 
.mob Southsea Pirate
.mob Southsea Freebooter
.mob Southsea Dock Worker
.mob Southsea Swashbuckler
step
.goto Tanaris,52.70,45.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Marvon|r
.turnin 3380 >>Turn in The Sunken Temple
.target Marvon Rivetseeker
.isOnQuest 3380
step
#completewith next
.goto Tanaris,68.27,41.21,30,0
.goto Tanaris,65.71,41.53,30,0
.goto Tanaris,52.71,45.92,50,0
.subzone 1938 >>Exit Lost Rigger Cove, then travel west to Broken Pillar
step
.goto Tanaris,52.70,45.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Marvon|r
.accept 3161 >>Accept Gahz'ridian
.target Marvon Rivetseeker
step
#completewith next
.subzone 982 >>Continue west to The Noxious Lair
step
.loop 25,Tanaris,35.6,39.4,37.2,39.6,36.5,43.9,36.0,47.2,34.9,50.3,33.0,51.6,34.4,48.6,35.3,45.1,35.6,39.4
>>Kill |cRXP_ENEMY_Centipaar Silithids|r. Loot them for their |cRXP_LOOT_Insect Parts|r
>>|cRXP_WARN_Be careful of|r |cRXP_ENEMY_Centipaar Swarmers|r|cRXP_WARN_. They can spawn many minions and/or social aggro from great distances|r
.complete 82,1 
.mob Centipaar Wasp
.mob Centipaar Stinger
.mob Centipaar Swarmer
.mob Centipaar Worker
.mob Centipaar Sandreaver
.mob Centipaar Tunneler
step
#completewith Garmarok
.goto Tanaris,40.98,57.16,50,0
.subzone 983 >>Travel southeast to the Dunemaul Compound
step
#completewith next
>>Kill |cRXP_ENEMY_Dunemaul Brutes|r and |cRXP_ENEMY_Dunemaul Enforcers|r
>>|cRXP_WARN_Avoid|r |cRXP_ENEMY_Dunemaul Warlocks|r|cRXP_WARN_, as they have Curse of Thorns|r << Rogue/Warrior/Shaman/Paladin/Hunter
.complete 5863,1 
.complete 5863,2 
.mob Dunemaul Brute
.mob Dunemaul Enforcer
step
#label Garmarok
.goto Tanaris,41.50,57.80
>>Kill |cRXP_ENEMY_Gor'marok|r in the cave
>>|cRXP_WARN_Be careful of his heavy damage output and Mortal Strike|r
.complete 5863,3 
.unitscan Gor'marok the Ravager
step
#completewith next
.use 9978 >>Equip your |T133151:0|t[Gahz'ridian Detector]
>>Loot the |cRXP_PICK_Piles of Sand|r for |cRXP_LOOT_Gahz'ridian Ornaments|r
>>|cRXP_WARN_Gahz'ridian will appear on your minimap. You can find loads in and around the Eastmoon and Southmoon ruins|r
.complete 3161,1 
.use 9978
step
.goto Tanaris,44.97,63.83,80,0
.goto Tanaris,47.66,65.53,80,0
.goto Tanaris,41.98,71.25,80,0
.goto Tanaris,39.86,73.23,60,0
.goto Tanaris,44.97,63.83,80,0
.goto Tanaris,47.66,65.53,80,0
.goto Tanaris,41.98,71.25,80,0
.goto Tanaris,39.86,73.23
>>Kill |cRXP_ENEMY_Dunemaul Brutes|r and |cRXP_ENEMY_Dunemaul Enforcers|r
>>|cRXP_WARN_Avoid|r |cRXP_ENEMY_Dunemaul Warlocks|r|cRXP_WARN_, as they have Curse of Thorns|r << Rogue/Warrior/Shaman/Paladin/Hunter
.complete 5863,1 
.complete 5863,2 
.mob Dunemaul Brute
.mob Dunemaul Enforcer
step
.goto Tanaris,44.97,63.83,80,0
.goto Tanaris,47.66,65.53,80,0
.goto Tanaris,41.98,71.25,80,0
.goto Tanaris,39.86,73.23,60,0
.goto Tanaris,44.97,63.83,80,0
.goto Tanaris,47.66,65.53,80,0
.goto Tanaris,41.98,71.25,80,0
.goto Tanaris,39.86,73.23
.use 9978 >>Equip your |T133151:0|t[Gahz'ridian Detector]
>>Loot the |cRXP_PICK_Piles of Sand|r for |cRXP_LOOT_Gahz'ridian Ornaments|r
>>|cRXP_WARN_Gahz'ridian will appear on your minimap. You can find loads in and around the Eastmoon and Southmoon ruins|r
.complete 3161,1 
.use 9978
step
#completewith Thistleshrubs
.goto Tanaris,31.06,64.91,20,0
.subzone 980 >>Travel southwest to Thistleshrub Valley
step
#completewith next
>>Kill |cRXP_ENEMY_Thistleshrub Dew Collectors|r. Loot them for a |cRXP_LOOT_Laden Dew Gland|r
>>|cRXP_WARN_This has a low drop rate and its spawn is shared with other mob types, so kill everything to make them spawn faster|r
.complete 2605,1 
.mob Thistleshrub Dew Collector
step
#label Thistleshrubs
.loop 25,Tanaris,29.50,62.98,27.76,65.80,28.30,68.39,30.63,66.57,30.62,63.76,29.50,62.98
>>Kill |cRXP_ENEMY_all Thistleshrub elementals|r
.complete 3362,1 
.complete 3362,2 
.mob Gnarled Thistleshrub
.mob Thistleshrub Rootshaper
step
.loop 25,Tanaris,29.50,62.98,27.76,65.80,28.30,68.39,30.63,66.57,30.62,63.76,29.50,62.98
>>Kill |cRXP_ENEMY_Thistleshrub Dew Collectors|r. Loot them for a |cRXP_LOOT_Laden Dew Gland|r
>>|cRXP_WARN_This has a low drop rate and its spawn is shared with other mob types, so kill everything to make them spawn faster|r
.complete 2605,1 
.mob Thistleshrub Dew Collector
step
.loop 25,Tanaris,29.37,59.97,28.70,67.32,31.66,74.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tSearch for |cRXP_FRIENDLY_Tooga|r, then talk to him to start his escort quest
>>|cRXP_WARN_He has 4 different spawn locations in the area|r
.accept 1560 >>Accept Tooga's Quest
.target Tooga
step
.goto Tanaris,66.58,25.64
>>Guide |cRXP_FRIENDLY_Tooga|r toward Steamwheedle Port. You will fail the quest if you get too far away from him
.complete 1560,1 
.target Tooga
step
.goto Tanaris,66.58,25.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torta|r
.turnin 1560 >>Turn in Tooga's Quest
.target Torta
step
#completewith next
.goto Tanaris,67.1,22.4,50,0
.subzone 977 >>Travel north to Steamwheedle Port
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bilgewhizzle|r and |cRXP_FRIENDLY_Stoley|r
.turnin 2875 >>Turn in WANTED: Andre Firebeard
.turnin 8366 >>Turn in Southsea Shakedown
.goto Tanaris,67.06,23.89
.turnin 2873 >>Turn in Stoley's Shipment
.accept 2874 >>Accept Deliver to MacKinley
.goto Tanaris,67.11,23.98
.target Security Chief Bilgewhizzle
.target Stoley
step
.goto Tanaris,66.60,22.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Haughty|r
.turnin 8365 >>Turn in Pirate Hats Ahoy!
.target Haughty Modiste
step
.goto Tanaris,66.989,22.354
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yeh'kinya|r again
.accept 3527 >> Accept The Prophecy of Mosh'aru
.target Yeh'kinya
.isQuestTurnedIn 3520
.dungeon ZF
step
#completewith next
.hs >>Hearth back to Gadgetzan
.use 6948
.cooldown item,6948,>0
step
.goto Tanaris,52.63,28.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dirge Quikcleave|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Dirge Quikcleave
step << skip
.goto Tanaris,52.30,28.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gimblethorn|r
.bankdeposit 9245 >>Deposit Stoley's Bottle in your bank
.target Gimblethorn
step
.goto Tanaris,51.80,28.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Marin|r
.turnin 2605 >>Turn in The Thirsty Goblin
.accept 2606 >>Accept In Good Taste
.target Marin Noggenfogger
step
.goto Tanaris,50.90,27.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pestlezugg|r
.turnin 82 >>Turn in Noxious Lair Investigation
.target Alchemist Pestlezugg
step
.goto Tanaris,51.10,26.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sprinkle|r
.turnin 2606 >>Turn in In Good Taste
.accept 2641 >>Accept Sprinkle's Secret Ingredient
.target Sprinkle
step
.goto Tanaris,50.20,27.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzledowser|r
.accept 10 >>Accept The Scrimshank Redemption
.target Senior Surveyor Fizzledowser
step
.goto Tanaris,51.50,26.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tran'rek|r
.turnin 3362 >>Turn in Thistleshrub Valley
.target Tran'rek
step
.goto Tanaris,52.80,27.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Andi|r
.turnin 5863 >>Turn in The Dunemaul Compound
.target Andi Lynn
step
.goto Tanaris,52.70,45.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Marvon|r
.turnin 3161 >>Turn in Gahz'ridian
.accept 3444 >>Accept The Stone Circle
.target Marvon Rivetseeker
step
#completewith next
.goto Tanaris,56.19,66.62,30,0
.subzone 981 >>Travel south to The Gaping Chasm
step
#label BugHole
.goto Tanaris,55.69,69.44,50,0
.goto Tanaris,56.36,68.44,30,0
.goto Tanaris,57.45,70.45,30,0
.goto Tanaris,55.96,71.16
>>|TInterface/GossipFrame/HealerGossipIcon:0|tEnter the silithid hive, then click the |cRXP_PICK_Scrimshank's Surveying Gear console|r and loot |cRXP_LOOT_Scrimshank's Surveying Gear|r
>>|cRXP_WARN_Be extremely cautious of |cRXP_ENEMY_Hazzali Swarmers|r |cRXP_WARN_as they can rapidly summon adds which deal high damage. They can also social aggro other mobs from extreme distances|r
.complete 10,1 
.unitscan Hazzali Swarmer
step
.use 8623 >>If you've found an |T132836:0|t[OOX-17/TN Distress Beacon], click it and accept its quest. Otherwise, skip this step
.accept 351 >>Accept Find OOX-17/TN!
.itemcount 8623,1
step
.goto Tanaris,60.20,64.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Homing Robot OOX-17/TN|r
.turnin 351 >>Turn in Find OOX-17/TN!
.target Homing Robot OOX-17/TN
.isOnQuest 351
step
.goto Tanaris,60.23,64.71
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Homing Robot OOX-17/TN|r again to start the escort quest
>>|cRXP_WARN_This quest can be difficult. Eat/drink to full and apply any self-buffs (scrolls, food, elixirs, etc.)|r
.accept 648 >>Accept Rescue OOX-17/TN!
.target Homing Robot OOX-17/TN
.isQuestTurnedIn 351
step
.goto Tanaris,67.09,23.18
>>Escort |cRXP_FRIENDLY_Homing Robot OOX-17/TN|r to Steamwheedle Port
>>|cRXP_WARN_A pack of 3 level 46-47|r |cRXP_ENEMY_Scorpions|r |cRXP_WARN_will spawn at the next mountain chain|r
>>|cRXP_WARN_A pack of 3 level 43-45|r |cRXP_ENEMY_Wastewander mobs|r |cRXP_WARN_will spawn around Waterspring Field. Focus the|r |cRXP_ENEMY_Scofflaw|r|cRXP_WARN_. It EXECUTES when you're below 20% health|r
.complete 648,1 
.target Homing Robot OOX-17/TN
.unitscan Wastewander Scofflaw
.isQuestTurnedIn 351
step
#sticky
#complete with EnterZF
.subzone 978 >> Now you should be looking for a group to Zul'Farrak
.dungeon ZF
step << Shaman
#completewith next
.hs >> Hearth or Astral Recall to Gadgetzan
.subzoneskip 976
step << Shaman
.goto Tanaris,52.63,28.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dirge|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Dirge Quikcleave
step << !Shaman
#completewith next
.goto Tanaris,50.6,28.1
.subzone 976 >>Travel to Gadgetzan
step
.goto Tanaris,50.21,27.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzledowser|r
.turnin 10 >>Turn in The Scrimshank Redemption
.accept 110 >>Accept Insect Part Analysis
.target Senior Surveyor Fizzledowser
step
.goto Tanaris,50.90,27.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pestlezugg|r
.turnin 110 >>Turn in Insect Part Analysis
.accept 113 >>Accept Insect Part Analysis
.target Alchemist Pestlezugg
step
.goto Tanaris,50.20,27.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzledowser|r
.turnin 113 >>Turn in Insect Part Analysis
.accept 32 >>Accept Rise of the Silithid
.target Senior Surveyor Fizzledowser
step
.goto Tanaris,51.413,28.752
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Trenton Lighthammer|r
.accept 3042 >> Accept Troll Temper
.target Trenton Lighthammer
.dungeon ZF
step
.goto Tanaris,52.462,28.514
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r
.accept 2768 >> Accept Divino-matic Rod
.target Chief Engineer Bilgewhizzle
.dungeon ZF
step
.goto Tanaris,51.566,26.759
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tran'rek|r
.accept 2865 >> Accept Scarab Shells
.target Tran'rek
.dungeon ZF
step
#completewith next
.goto Thousand Needles,70.58,62.69,200 >> Travel to the Shimmering Flats
step
.goto Thousand Needles,78.143,77.120
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wizzle Brassbolts|r
.accept 2770 >> Accept Gahz'rilla
.target Wizzle Brassbolts
.dungeon ZF
step
#label EnterZF
.goto Tanaris,38.91,20.78,40,0
.goto Tanaris,38.731,19.839
.zone 219 >> Enter Zul'Farrak
.dungeon ZF
step
#completewith Gahzrilla
>>Kill |cRXP_ENEMY_Trolls|r. Loot them for their |cRXP_LOOT_Troll Temper|r
.complete 3042,1 
.isOnQuest 3042
.dungeon ZF
step
#completewith next
>>Kill |cRXP_ENEMY_Scarabs|r. Loot them for their |cRXP_LOOT_Uncracked Scarab Shell|r
.complete 2865,1 
.isOnQuest 2865
.dungeon ZF
step
>>Kill |cRXP_ENEMY_Theka the Martyr|r. Loot him for the |cRXP_LOOT_First Mosh'aru Tablet|r
.complete 3527,1 
.mob Theka the Martyr
.isOnQuest 3527
.dungeon ZF
step
>>Kill |cRXP_ENEMY_Scarabs|r. Loot them for their |cRXP_LOOT_Uncracked Scarab Shell|r
.complete 2865,1 
.isOnQuest 2865
.dungeon ZF
step
#completewith next
+Ascend the Pyramid
>>Kill the |cRXP_ENEMY_Sandfury Executioner|r. Loot him for the |cRXP_LOOT_Executioner's Key|r
>>|cRXP_WARN_Anyone in the party may loot the|r |cRXP_LOOT_Key|r
>>|cRXP_WARN_Use the|r |cRXP_LOOT_Executioner's Key|r |cRXP_WARN_on one of the |cRXP_PICK_Troll Cages|r to free |cRXP_FRIENDLY_Sergeant Bly|r and his band|r
.collect 8444,1 
.disablecheckbox
.isOnQuest 2768
.mob Sandfury Executioner
.dungeon ZF
step
>>Defend |cRXP_FRIENDLY_Sergeant Bly|r and his band, then move down with them after a short period of time
>>Kill |cRXP_ENEMY_Nekrum Gutchewer|r. Eat and drink then talk to |cRXP_FRIENDLY_Sergeant Bly|r to fight him
>>Kill |cRXP_ENEMY_Sergeant Bly|r. Loot him for the |cRXP_LOOT_Divino-matic Rod|r
.complete 2768,1 
.isOnQuest 2768
.skipgossip
.dungeon ZF
step
>>Kill |cRXP_ENEMY_Hydromancer Velratha|r. Loot her for the |cRXP_LOOT_Tiara of the Deep|r and the |cRXP_LOOT_Second Mosh'aru Tablet|r
.complete 2846,1 
.complete 3527,2 
.mob Hydromancer Velratha
.isOnQuest 2846
.isOnQuest 3527
.dungeon ZF
step
>>Kill |cRXP_ENEMY_Hydromancer Velratha|r. Loot her for the |cRXP_LOOT_Tiara of the Deep|r
.complete 2846,1 
.mob Hydromancer Velratha
.isOnQuest 2846
.dungeon ZF
step
>>Kill |cRXP_ENEMY_Hydromancer Velratha|r. Loot her for the |cRXP_LOOT_Second Mosh'aru Tablet|r
.complete 3527,2 
.mob Hydromancer Velratha
.isOnQuest 3527
.dungeon ZF
step
#label Gahzrilla
>>|cRXP_WARN_Use the|r |T133056:0|t[Mallet of Zul'Farrak] |cRXP_WARN_on the |cRXP_PICK_Gong of Zul'Farrak|r to summon|r |cRXP_ENEMY_Gahz'rilla|r
>>Kill |cRXP_ENEMY_Gahz'rilla|r. Loot him for |cRXP_LOOT_Gahz'rilla's Electrified Scale|r
>>|cRXP_WARN_If no one in your party has the|r |T133056:0|t[Mallet of Zul'Farrak] |cRXP_WARN_you will not be able to summon|r |cRXP_ENEMY_Gahz'rilla|r
.complete 2770,1 
.mob Gahz'rilla
.isOnQuest 2770
.dungeon ZF
step
>>Kill |cRXP_ENEMY_Trolls|r. Loot them for their |cRXP_LOOT_Troll Temper|r
.complete 3042,1 
.isOnQuest 3042
.dungeon ZF
step
.hs >>Hearth back to Gadgetzan
.use 6948
.cooldown item,6948,>0
.dungeon ZF
.zoneskip Tanaris
step
.goto Tanaris,51.413,28.752
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Trenton Lighthammer|r
.turnin 3042 >> Turn in Troll Temper
.target Trenton Lighthammer
.isQuestComplete 3042
.dungeon ZF
step
.goto Tanaris,52.462,28.514
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r
.turnin 2768 >> Turn in Divino-matic Rod
.target Chief Engineer Bilgewhizzle
.isQuestComplete 2768
.dungeon ZF
step
.goto Tanaris,51.566,26.759
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tran'rek|r
.turnin 2865 >> Turn in Scarab Shells
.target Tran'rek
.isQuestComplete 2865
.dungeon ZF
step
.goto Tanaris,52.40,28.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bilgewhizzle|r
.accept 864 >> Accept Return to Apothecary Zinge
.target Chief Engineer Bilgewhizzle
.isQuestTurnedIn 654
step
#completewith next
.goto Tanaris,66.989,22.354,100 >> Travel to Steamwheedle Port
.dungeon ZF
step
.goto Tanaris,66.989,22.354
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yeh'kinya|r
.turnin 3527 >> Turn in The Prophecy of Mosh'aru
.target Yeh'kinya
.isQuestComplete 3527
.dungeon ZF
step
.goto Tanaris,66.989,22.354
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yeh'kinya|r
.accept 4787 >> Accept The Ancient Egg
.target Yeh'kinya
.isQuestTurnedIn 3527
.dungeon ZF
step
#completewith next
.zone Thousand Needles >> Travel to the Shimmering Flats
step
.goto Thousand Needles,78.143,77.120
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wizzle Brassbolts|r
.turnin 2770 >> Turn in Gahz'rilla
.target Wizzle Brassbolts
.isQuestComplete 2770
.dungeon ZF
step
.abandon 2770 >> Abandon Gahz'rilla
.dungeon ZF
step
.goto Tanaris,51.60,25.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bulkrek|r
.fly Brackenwall >> Fly to Dustwallow Marsh
.target Bulkrek Ragefist
step
.goto Dustwallow Marsh,37.10,33.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Draz'Zilb|r
.accept 1170 >>Accept The Brood of Onyxia
.target Draz'Zilb
step
.goto Dustwallow Marsh,36.30,31.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mok'Morokk|r
.turnin 1170 >>Turn in The Brood of Onyxia
.accept 1171 >>Accept The Brood of Onyxia
.target Overlord Mok'Morokk
step
.goto Dustwallow Marsh,37.10,33.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Draz'Zilb|r
.turnin 1171 >>Turn in The Brood of Onyxia
.accept 1172 >>Accept The Brood of Onyxia
.target Draz'Zilb
step
#completewith next
.goto Dustwallow Marsh,32.28,65.54,30,0
.subzone 498 >>Travel south to Bloodfen Burrow
step
.goto Dustwallow Marsh,31.10,66.10
>>Enter the cave, then click the |cRXP_PICK_Musty Scroll|r on the rock
>>|cRXP_WARN_Be careful, as this area hyperspawns|r
.turnin 625 >>Turn in Cortello's Riddle
.accept 626 >>Accept Cortello's Riddle
.isOnQuest 625
.group
step
.goto Dustwallow Marsh,48.50,75.30,0
.goto Dustwallow Marsh,55.9,81.9,0
.goto Dustwallow Marsh,53.6,72.5
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick |cRXP_PICK_Eggs of Onyxia|r to destroy them
.complete 1172,1 
step
.goto Dustwallow Marsh,46.021,57.096
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tabetha|r
.turnin 2846 >> Turn in Tiara of the Deep
.target Tabetha
.isQuestComplete 2991
.dungeon ZF
step
#completewith next
.goto Dustwallow Marsh,36.1,30.7,30,0
.subzone 496 >>Travel north to Brackenwall Village
step
.goto Dustwallow Marsh,37.15,33.08
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Draz'Zilb|r
.turnin 1172 >>Turn in The Brood of Onyxia
.target Draz'Zilb
step
#completewith next
.goto Dustwallow Marsh,36.30,31.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mok'Morokk|r
>>|cRXP_WARN_Accepting this quest turns|r |cRXP_ENEMY_Overlord Mok'Morokk|r |cRXP_WARN_hostile. He hits extremely hard and should be kited. Be prepared|r
.turnin 1172 >>Turn in The Brood of Onyxia
.accept 1173 >>Accept Challenge Overlord Mok'Morokk
.unitscan Overlord Mok'Morokk
.group
step
.goto Dustwallow Marsh,36.30,31.50
>>Defeat |cRXP_ENEMY_Overlord Mok'Morokk|r by reducing his health to about 30%
>>|cRXP_WARN_He hits extremely hard and should be kited|r
.complete 1173,1 
.unitscan Overlord Mok'Morokk
.group 3
step
.goto Dustwallow Marsh,36.30,31.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mok'Morokk|r
>>|cRXP_WARN_Do NOT accept the follow-up of this quest.|r |cRXP_FRIENDLY_Mok'Morokk|r |cRXP_WARN_will turn hostile and can kill you|r
.turnin 1172 >>Turn in The Brood of Onyxia
.unitscan Overlord Mok'Morokk
.solo
step
.goto Dustwallow Marsh,37.10,33.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Draz'Zilb|r
.turnin 1173 >>Turn in Challenge Overlord Mok'Morokk
.target Draz'Zilb
.isQuestComplete 1173
.group
step << !Mage
.goto Dustwallow Marsh,35.57,31.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shardi|r
.fly Thunder Bluff>>Fly to Thunder Bluff
.target Shardi
.isQuestComplete 1205
.zoneskip Thunder Bluff
step << Mage
.cast 3566 >>Cast |T135765:0|t[Teleport: Thunder Bluff]
.zoneskip Thunder Bluff
.isQuestComplete 1205
step << !Mage
.goto Dustwallow Marsh,35.57,31.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shardi|r
.fly Thunder Bluff>>Fly to Thunder Bluff
.target Shardi
.zoneskip Thunder Bluff
.isOnQuest 2280
.dungeon ULDA
step << Mage
.cast 3566 >>Cast |T135765:0|t[Teleport: Thunder Bluff]
.zoneskip Thunder Bluff
.isOnQuest 2280
.dungeon ULDA
step
.goto Thunder Bluff,34.42,46.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sage|r
.turnin 2280 >> Turn in The Platinum Discs
.accept 2440 >> Accept The Platinum Discs
.target Sage Truthseeker
.isQuestTurnedIn 2278
.dungeon ULDA
step
.goto Thunder Bluff,46.61,33.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bena|r
.turnin 2440 >> Turn in The Platinum Discs
.accept 2965 >> Accept Portents of Uldum
.target Bena Winterhoof
.isQuestTurnedIn 2278
.dungeon ULDA
step
.goto Thunder Bluff,75.67,31.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nara|r
.turnin 2965 >> Turn in Portents of Uldum

.target Nara Wildmane
.isQuestTurnedIn 2278
.dungeon ULDA

step
.goto Thunder Bluff,61.50,80.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Melor|r
.turnin 1205 >>Turn in Deadmire
.target Melor Stonehoof
.isQuestComplete 1205
step << Hunter
.goto Thunder Bluff,59.11,86.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 14304 >>Train your class spells
.target Urek Thunderhorn
.xp <46,1
.xp >48,1
.zoneskip Thunder Bluff,1
step << Hunter
.goto Thunder Bluff,59.11,86.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 14321 >>Train your class spells
.target Urek Thunderhorn
.xp <48,1
.zoneskip Thunder Bluff,1
step << Hunter
.goto Thunder Bluff,54.08,84.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hesuwa|r
.train 24562 >>Train your pet spells
.target Hesuwa Thunderhorn
.xp <48,1
.zoneskip Thunder Bluff,1
step << Warrior
.goto Thunder Bluff,57.56,85.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ker|r
.train 11578 >>Train your class spells
.target Ker Ragetotem
.xp <46,1
.xp >48,1
.zoneskip Thunder Bluff,1
step << Warrior
.goto Thunder Bluff,57.56,85.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ker|r
.train 20661 >> Train your class spells
.target Ker Ragetotem
.xp <48,1
.zoneskip Thunder Bluff,1
step << Druid
.goto Thunder Bluff,76.46,27.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Turak|r
.train 9823 >>Train your class spells
.target Turak Runetotem
.xp <46,1
.xp >48,1
.zoneskip Thunder Bluff,1
step << Druid
.goto Thunder Bluff,76.46,27.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Turak|r
.train 22828 >>Train your class spells
.target Turak Runetotem
.xp <48,1
.zoneskip Thunder Bluff,1
step << !Mage
.goto Thunder Bluff,47.00,49.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tal|r
.fly Orgrimmar >>Fly to Orgrimmar
.target Tal
.zoneskip Thunder Bluff,1\
step << !Mage
.goto Dustwallow Marsh,35.57,31.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shardi|r
.fly Thunder Bluff >> Fly to Thunder Bluff
.target Shardi
.zoneskip Dustwallow Marsh,1
step << Mage
.cast 3567 >>Cast |T135759:0|t[Teleport: Orgrimmar]
.zoneskip Thunder Bluff,1
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 10197 >> Train your class spells
.target Pephredo
.xp <46,1
.xp >48,1
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 10215 >> Train your class spells
.target Pephredo
.xp <48,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 10945 >> Train your class spells
.target Ur'kyo
.xp <46,1
.xp >48,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 10899 >> Train your class spells
.target Ur'kyo
.xp <48,1
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 10586 >> Train your class spells
.target Kardris Dreamseeker
.xp <46,1
.xp >48,1
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 10431 >> Train your class spells
.target Kardris Dreamseeker
.xp <48,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14304 >>Train your class spells
.target Ormak Grimshot
.xp <46,1
.xp >48,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14321 >>Train your class spells
.target Ormak Grimshot
.xp <48,1
step << Hunter
.goto Orgrimmar,66.33,14.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xao'tsu|r
.train 24562 >>Train your pet spells
.target Xao'tsu
.xp <48,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 11578 >>Train your class spells
.target Grezz Ragefist
.xp <46,1
.xp >48,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 20661 >> Train your class spells
.target Grezz Ragefist
.xp <48,1
step << Orc !Warlock
.goto Orgrimmar,69.40,13.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kildar|r and |cRXP_FRIENDLY_Ogunaro|r
.train 825 >>Train |T136103:0|t[Wolf Riding]
.vendor >>|cRXP_BUY_Buy a|r |T132224:0|t[|cFF0070FFWolf|r]
.xp <40,1
.money <90
.skill riding,75,1
.target Kildar
.target Ogunaro
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 11293 >> Train your class spells
.target Ormok
.xp <46,1
.xp >48,1
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 11299 >> Train your class spells
.target Ormok
.xp <48,1
step << Rogue
.goto Orgrimmar,42.10,49.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Rekkul|r|cRXP_BUY_. Buy |r |T134387:0|t[Flash Powder] |cRXP_BUY_from him|r
.collect 5140,20,2479,1 
.target Rekkul
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 11699 >> Train your class spells
.target Mirket
.xp <46,1
.xp >48,1
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 11712 >> Train your class spells
.target Mirket
.xp <48,1
step << Warlock
.goto Orgrimmar,47.52,46.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kurgul|r
.vendor >>Upgrade your pet's abilities
.target Kurgul
step
.goto Orgrimmar,56.40,46.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zilzibin|r
.turnin 32 >>Turn in Rise of the Silithid
.target Zilzibin Drumlore
step
.goto Orgrimmar,59.40,36.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dran|r
.accept 649 >>Accept Ripple Recovery
.target Dran Droffers
step
.goto Orgrimmar,59.50,36.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malton|r
.turnin 649 >>Turn in Ripple Recovery
.accept 650 >>Accept Ripple Recovery
.target Malton Droffers
step
.goto Orgrimmar,55.52,34.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jes'rimon|r
.accept 4300 >>Accept Bone-Bladed Weapons
.target Jes'rimon
step << Troll
#completewith next
.subzone 367 >> Travel to Sen'Jin Village
step << Troll
.goto Durotar,55.28,75.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xar'Ti|r and |cRXP_FRIENDLY_Zjolnir|r
.train 10861 >>Train |T136103:0|t[Raptor Riding]
.vendor >>|cRXP_BUY_Buy a|r |T132253:0|t[|cFF0070FFRaptor|r]
.xp <40,1
.money <90
.skill riding,75,1
.target Xar'Ti
.target Zjolnir
step << !Mage
#completewith next
.zone Durotar >> Leave Orgrimmar
.zoneskip Durotar
step << !Mage
.goto Durotar,50.8,13.8,40 >>Go up the Zeppelin Tower
.zone Tirisfal Glades >>Take the Zeppelin to Tirisfal Glades
.zoneskip Tirisfal Glades
step << Mage
.cast 3563 >>Cast |T135766:0|t[Teleport: Undercity]
.zoneskip Undercity
step
.abandon 2846 >> Abandon Tiara of the Deep
.isOnQuest 2846
.dungeon ZF
step
.abandon 3527 >> Abandon The Prophecy of Mosh'aru
.isOnQuest 3527
.dungeon ZF
step
.abandon 2768 >> Abandon Divino-matic Rod
.isOnQuest 2768
.dungeon ZF
step
.abandon 3042 >> Abandon Troll Temper
.isOnQuest 3042
.dungeon ZF
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 49-50 The Hinterlands
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 40-50
#next 50-51 Feralas
step << Mage
.goto Undercity,82.79,15.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hannah|r
.vendor >>Buy at least four |cRXP_BUY_Rune of Teleportation|r
.collect 17031,4 
.target Hannah Akeley
step
.goto Undercity,73.20,32.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oran|r
.accept 2995 >>Accept Lines of Communication
.target Oran Snakewrithe
step
.goto Undercity,50.00,68.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zinge|r
.turnin 864 >>Turn in Return to Apothecary Zinge
.target Apothecary Zinge
.isOnQuest 864
step
.goto Undercity,53.77,54.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bel'dugur|r
.turnin 728 >> Turn in To the Undercity for Yagyin's Digest
.target Keeper Bel'dugur
.isOnQuest 728
.dungeon ULDA
step
.goto Undercity,62.31,48.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Patrick|r
.turnin 2342 >> Turn in Reclaimed Treasures
.target Patrick
.dungeon ULDA
.isQuestComplete 2342
step << Undead !Warlock
#completewith next
.subzone 159 >> Travel to Brill
step << Undead !Warlock
.goto Tirisfal Glades,60.09,52.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Velma|r and |cRXP_FRIENDLY_Zachariah|r
.train 10906 >>Train |T136103:0|t[Undead Horsemanship]
.vendor >>|cRXP_BUY_Buy a|r |T132264:0|t[|cFF0070FFSkeletal Horse|r]
.xp <40,1
.money <90
.skill riding,75,1
.target Velma Warnam
.target Zachariah Post
step
.goto Undercity,63.27,48.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Michael|r
.fly Tarren Mill >>Fly to Tarren Mill
.target Michael Garrett
.zoneskip Hillsbrad Foothills
step
.abandon 2342 >> Abandon Reclaimed Treasures
.isOnQuest 2342
step
.goto Hillsbrad Foothills,61.53,19.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r
.accept 2934 >>Accept Undamaged Venom Sac
.target Apothecary Lydon
step
.goto Hillsbrad Foothills,86.60,29.49,30,0
.goto The Hinterlands,9.7,55.8
.zone The Hinterlands >>Take the mountain path northeast of Durnholde Keep into The Hinterlands
step
#completewith AtalalExile
.goto The Hinterlands,35.9,63.9,40,0
.subzone 353 >>Travel southeast to Shadra'Alor
step
#completewith next
>>Kill |cRXP_ENEMY_Witherbark Broodguards|r. Loot them for an |cRXP_LOOT_Undamaged Venom Sac|r
>>|cRXP_WARN_The|r |cRXP_LOOT_Undamaged Venom Sac|r |cRXP_WARN_has a 30 minute duration, so turn it in ASAP|r
.complete 2934,1 
.mob Witherbark Broodguard
step
.goto The Hinterlands,33.751,75.210
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Atal'ai Exile|r
.turnin 1429 >>Turn in The Atal'ai Exile
.accept 1444 >>Accept Return to Fel'Zerul
.accept 1446 >> Accept Jammal'an the Prophet
.target Atal'ai Exile
.dungeon ST
step
#label AtalalExile
.goto The Hinterlands,33.70,75.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Atal'ai Exile|r
.turnin 1429 >>Turn in The Atal'ai Exile
.accept 1444 >>Accept Return to Fel'Zerul
.target Atal'ai Exile





step
.goto The Hinterlands,36.28,68.43,60,0
.goto The Hinterlands,34.16,67.00,60,0
.goto The Hinterlands,33.19,69.66,60,0
.goto The Hinterlands,30.66,69.71,60,0
.goto The Hinterlands,32.08,73.36,60,0
.goto The Hinterlands,35.48,74.42,60,0
.goto The Hinterlands,35.32,70.90,60,0
.goto The Hinterlands,35.79,64.35,60,0
.goto The Hinterlands,33.19,69.66
>>Kill |cRXP_ENEMY_Witherbark Broodguards|r. Loot them for an |cRXP_LOOT_Undamaged Venom Sac|r
>>|cRXP_WARN_The|r |cRXP_LOOT_Undamaged Venom Sac|r |cRXP_WARN_has a 30 minute duration, so turn it in ASAP|r
.complete 2934,1 
.mob Witherbark Broodguard
step
#completewith next
.goto Hillsbrad Foothills,60.8,21.2,60,0
.subzone 272 >>Travel out of the Hinterlands, back to Tarren Mill
step
.goto Hillsbrad Foothills,61.53,19.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lydon|r
>>|cRXP_WARN_The|r |cRXP_LOOT_Undamaged Venom Sac|r |cRXP_WARN_has a 30 minute duration, so turn it in ASAP|r
.turnin 2934 >>Turn in Undamaged Venom Sac
.target Apothecary Lydon










step
.goto The Hinterlands,26.70,48.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gilveradin|r
.turnin 650 >>Turn in Ripple Recovery
.accept 77 >>Accept A Sticky Situation
.target Gilveradin Sunchaser
step
#completewith next
.goto The Hinterlands,77.28,78.64,30,0
.subzone 3317 >>Travel to Revantusk Village
step
#label ViHo
.goto The Hinterlands,72.50,66.20,50,0
.goto The Hinterlands,77.10,80.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Slagtree|r
.accept 7839 >>Accept Vilebranch Hooligans
.target Smith Slagtree
step
.goto The Hinterlands,78.20,81.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lard|r
.accept 7840 >>Accept Lard Lost His Lunch
.target Lard
step
.goto The Hinterlands,80.40,81.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Katoom|r
.accept 7815 >>Accept Snapjaws, Mon!
.accept 7816 >>Accept Gammerita, Mon!
.target Katoom the Angler
step
#completewith Gammerita
>>Loot the |cRXP_PICK_Pupellyverbos Port Bottles|r along the shore
.complete 580,1 
step
#completewith next
>>Kill |cRXP_ENEMY_Saltwater Snapjaws|r
.complete 7815,1 
.mob Saltwater Snapjaw
step
#label Gammerita
.goto The Hinterlands,81.87,49.36,70,0
.goto The Hinterlands,79.86,60.32,70,0
.goto The Hinterlands,78.54,67.85,70,0
.goto The Hinterlands,79.14,71.45,70,0
.goto The Hinterlands,77.47,75.83,70,0
.goto The Hinterlands,78.83,76.26
>>Kill |cRXP_ENEMY_Gammerita|r. Loot her for |cRXP_LOOT_Katoom's Best Lure|r
>>|cRXP_WARN_She patrols the length of the coast. Kite her to the guards. If you can't re-leash her consistently, wait until she is close to the village|r
.complete 7816,1 
.unitscan Gammerita
step
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick |cRXP_PICK_Cortello's Riddle|r beneath the waterfall
.goto The Hinterlands,80.80,46.80
.turnin 626 >>Turn in Cortello's Riddle
.isOnQuest 626
.group
step
.goto The Hinterlands,84.40,41.30
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick |cRXP_PICK_Lard's Picnic Basket|r. Kill the 3 |cRXP_ENEMY_Vilebranch Kidnappers|r that spawn. Loot one of them for |cRXP_LOOT_Lard's Lunch|r
>>|cRXP_WARN_All of the mobs have Execute. Be extremely careful on this quest, try not to let your health dip near 20%|r
.complete 7840,1 
.unitscan Vilebranch Kidnapper
step
#completewith next
>>Loot the |cRXP_PICK_Pupellyverbos Port Bottles|r along the shore
.complete 580,1 
step
.loop 25,The Hinterlands,80.0,58.8,77.2,61.8,77.2,64.2,74.8,68.6,75.6,72.0,78.2,69.2,78.0,64.2,80.0,58.8
>>Kill |cRXP_ENEMY_Saltwater Snapjaws|r
.complete 7815,1 
.mob Saltwater Snapjaw
step
.goto The Hinterlands,79.86,60.32,80,0
.goto The Hinterlands,78.54,67.85,80,0
.goto The Hinterlands,79.14,71.45,80,0
.goto The Hinterlands,77.47,75.83,80,0
.goto The Hinterlands,78.83,76.26
>>Loot the |cRXP_PICK_Pupellyverbos Port Bottles|r along the shore
.complete 580,1 
step
#completewith next
.goto The Hinterlands,77.28,78.64,30,0
.subzone 3317 >>Travel to Revantusk Village
step
#requires Bottles
.goto The Hinterlands,80.30,81.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Katoom|r
.turnin 7815 >>Turn in Snapjaws, Mon!
.turnin 7816 >>Turn in Gammerita, Mon!
.target Katoom the Angler
step
.goto The Hinterlands,78.20,81.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lard|r
.turnin 7840 >>Turn in Lard Lost His Lunch
.target Lard
step
.goto The Hinterlands,78.80,78.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yayo'jin|r
.accept 7844 >>Accept Cannibalistic Cousins
.target Mystic Yayo'jin
step
.goto The Hinterlands,79.40,79.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Otho|r
.accept 7841 >>Accept Message to the Wildhammer
.target Otho Moji'ko
step
.goto The Hinterlands,79.10,79.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Markhor|r
.accept 7828 >>Accept Stalking the Stalkers
.accept 7829 >>Accept Hunt the Savages
.accept 7830 >>Accept Avenging the Fallen
.target Huntsman Markhor
step
#completewith Bucket
>>Kill |cRXP_ENEMY_Silvermane Stalkers|r
.complete 7828,1 
.mob Silvermane Stalker
step
#completewith Bucket
.use 9618 >>Kill |cRXP_ENEMY_Savage Owlbeasts|r and use the |T133841:0|t[Wildkin Muisek Vessel] near their corpses
>>|cRXP_WARN_This item has a cooldown and only works on one corpse at a time, even if they're stacked|r
.complete 7829,1 
.complete 3123,1 
.mob Savage Owlbeast
step
#completewith Bucket
>>Kill |cRXP_ENEMY_Vilebranch Scalpers|r and |cRXP_ENEMY_Vilebranch Soothsayers|r
>>|cRXP_ENEMY_Vilebranch Scalpers|r |cRXP_WARN_have Execute. Be extremely careful on this quest, try not to let your health dip near 20%|r
.complete 7844,1 
.complete 7844,2 
.mob Vilebranch Scalper
.mob Vilebranch Soothsayer
step
#label Bucket
.goto The Hinterlands,72.53,52.92,25,0
.goto The Hinterlands,71.14,48.64,25,0
.goto The Hinterlands,66.09,44.71,25,0
.goto The Hinterlands,57.57,42.50,25,0
.goto The Hinterlands,53.18,39.20,25,0
.goto The Hinterlands,72.53,52.92,25,0
.goto The Hinterlands,71.14,48.64,25,0
.goto The Hinterlands,66.09,44.71,25,0
>>Loot |cRXP_PICK_Slagtree's Lost Tools|r (a small bucket)
>>|cRXP_WARN_The bucket can spawn in 5 locations|r
.complete 7839,1 
step
#completewith next
.goto The Hinterlands,58.7,41.9,50,0
.subzone 351 >>Travel northwest, then enter the cave, Skulk Rock
step
.goto The Hinterlands,57.50,39.50,20,0
.goto The Hinterlands,56.5,43.9
>>Loot the |cRXP_PICK_Horde Supply Crates|r for their |cRXP_LOOT_Hinterlands Honey Ripple|r
.complete 77,1 
step
#completewith QuelDanilLodge
.use 9618 >>Kill |cRXP_ENEMY_Savage Owlbeasts|r and use the |T133841:0|t[Wildkin Muisek Vessel] near their corpses
>>|cRXP_WARN_This item has a cooldown and only works on one corpse at a time, even if they're stacked|r
.complete 7829,1 
.complete 3123,1 
.mob Savage Owlbeast
step
#completewith next
>>Kill |cRXP_ENEMY_Silvermane Howlers|r
.complete 7828,2 
.mob Silvermane Howler
step
#label QuelDanilLodge
#completewith next
.goto The Hinterlands,31.06,47.84,50,0
.subzone 350 >>Travel west to Quel'Danil Lodge
step
#completewith Escort
>>Kill |cRXP_ENEMY_Highvale High Elves|r
>>|cRXP_WARN_Be careful with your health!|r |cRXP_ENEMY_Highvale Rangers|r |cRXP_WARN_can Faerie Fire, making escape more difficult|r << Rogue
.complete 7841,1 
.complete 7841,2 
.complete 7841,3 
.complete 7841,4 
.mob Highvale Scout
.mob Highvale Outrunner
.mob Highvale Ranger
.mob Highvale Marksman
step
#label Notes
.goto The Hinterlands,29.60,48.70
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Highvale Notes|r on the ground
.complete 2995,2 
step
.goto The Hinterlands,28.60,46.10
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Highvale Report|r on the table
.complete 2995,3 
step
#requires Notes
.goto The Hinterlands,32.00,46.90
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Highvale Records|r on the ground
.complete 2995,1 
step
.goto The Hinterlands,30.73,46.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rin'ji|r
>>|cRXP_WARN_This will start an escort!|r
.accept 2742 >>Accept Rin'ji is Trapped!
.target Rin'ji
step
#label Escort
.goto The Hinterlands,34.98,56.92
>>Escort |cRXP_FRIENDLY_Rin'ji|r
.complete 2742,1 
step
.loop 25,The Hinterlands,33.0,51.6,30.4,51.0,29.6,48.6,28.6,46.6,29.6,48.6,32.2,47.6,32.6,43.6,33.8,44.8,33.8,48.6,33.0,51.6
>>Finish killing |cRXP_ENEMY_Highvale High Elves|r
>>|cRXP_WARN_Be careful with your health;|r |cRXP_ENEMY_Highvale Rangers|r |cRXP_WARN_can Faerie Fire, making escape more difficult|r << Rogue
.complete 7841,1 
.complete 7841,2 
.complete 7841,3 
.complete 7841,4 
.mob Highvale Scout
.mob Highvale Outrunner
.mob Highvale Ranger
.mob Highvale Marksman
step
#completewith Tragan
>>Kill |cRXP_ENEMY_Silvermane Howlers|r
.complete 7828,2 
.mob Silvermane Howler
step
.goto The Hinterlands,26.61,48.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gilveradin|r
.turnin 77 >>Turn in A Sticky Situation
.target Gilveradin Sunchaser
step
.goto The Hinterlands,26.61,48.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gilveradin|r
.accept 81 >>Accept Ripple Delivery
.target Gilveradin Sunchaser
step
#label Tragan
.goto The Hinterlands,40.00,59.90
>>Swim to the bottom of the pond, then loot the |cRXP_PICK_Mushroom|r for a |cRXP_LOOT_Violet Tragan|r
.complete 2641,1 
step
.loop 25,The Hinterlands,51.0,41.6,51.4,47.8,51.2,57.2,50.6,63.6,49.6,59.8,45.6,58.8,43.2,61.8,39.2,63.2,36.8,58.6,39.4,55.8,38.8,50.8,39.4,46.2,43.4,46.4,38.8,50.8
>>Finish killing |cRXP_ENEMY_Silvermane Howlers|r
.complete 7828,2 
.mob Silvermane Howler
step
.loop 25,The Hinterlands,45.6,63.4,44.4,67.0,46.4,68.8,49.6,65.2,50.6,65.8,50.6,62.4,45.6,63.4
>>Finish killing |cRXP_ENEMY_Vilebranch Scalpers|r and |cRXP_ENEMY_Vilebranch Soothsayers|r around the base of the temple
>>|cRXP_ENEMY_Vilebranch Scalpers|r |cRXP_WARN_have Execute. Be extremely careful on this quest, try not to let your health dip near 20%|r
>>|cRXP_WARN_Do not go to the top! There are high level elites|r
.complete 7844,1 
.complete 7844,2 
.mob Vilebranch Scalper
.mob Vilebranch Soothsayer
step
#completewith SkylordPlume
>>Kill |cRXP_ENEMY_Silvermane Stalkers|r
.complete 7828,1 
.mob Silvermane Stalker
step
#completewith next
.use 9618 >>Kill |cRXP_ENEMY_Savage Owlbeasts|r and use the |T133841:0|t[Wildkin Muisek Vessel] near their corpses
>>|cRXP_WARN_This item has a cooldown and only works on one corpse at a time, even if they're stacked|r
.complete 7829,1 
.mob Savage Owlbeast
step
#label SkylordPlume
.loop 25,The Hinterlands,53.0,56.6,54.0,54.2,56.0,51.6,58.6,53.0,61.0,54.8,64.2,56.6,63.8,53.6,64.6,48.6,66.6,42.6,61.4,42.4,60.6,48.2,59.8,52.2,57.0,50.2,54.6,47.0,51.0,44.0,50.6,53.0,56.6
>>Find and kill a |cRXP_ENEMY_Razorbeak Skylord|r. Loot it for its |cRXP_LOOT_Plume|r
.complete 7830,1 
.unitscan Razorbeak Skylord
step
#completewith Stalkers
.use 9618 >>Kill |cRXP_ENEMY_Savage Owlbeasts|r and use the |T133841:0|t[Wildkin Muisek Vessel] near their corpses
>>|cRXP_WARN_This item has a cooldown and only works on one corpse at a time, even if they're stacked|r
.complete 7829,1 
.mob Savage Owlbeast
step
#label Stalkers
.loop 25,The Hinterlands,70.6,63.4,70.6,57.4,73.2,52.6,69.0,50.6,69.0,45.6,66.6,48.0,63.2,47.8,61.6,41.8,58.6,46.8,56.2,46.8,54.4,44.0,53.6,49.2,53.2,55.6,55.6,51.4,58.6,53.2,60.8,55.6,64.0,54.6,66.6,57.2,68.4,62.6,70.6,63.4
>>Finish killing |cRXP_ENEMY_Silvermane Stalkers|r
.complete 7828,1 
.mob Silvermane Stalker
step
.loop 25,The Hinterlands,70.6,63.4,70.6,57.4,73.2,52.6,69.0,50.6,69.0,45.6,66.6,48.0,63.2,47.8,61.6,41.8,58.6,46.8,56.2,46.8,54.4,44.0,53.6,49.2,53.2,55.6,55.6,51.4,58.6,53.2,60.8,55.6,64.0,54.6,66.6,57.2,68.4,62.6,70.6,63.4
.use 9618 >>Kill |cRXP_ENEMY_Savage Owlbeasts|r and use the |T133841:0|t[Wildkin Muisek Vessel] near their corpses
>>|cRXP_WARN_This item has a cooldown and only works on one corpse at a time, even if they're stacked|r
.complete 7829,1 
.mob Savage Owlbeast
step

.goto The Hinterlands,49.30,37.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Homing Robot OOX-09/HL|r
.accept 485 >>Accept Find OOX-09/HL!
.turnin 485 >>Turn in Find OOX-09/HL!
.target Homing Robot OOX-09/HL
.itemcount 8704,1 
.solo
step
.goto The Hinterlands,49.35,37.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Homing Robot OOX-09/HL|r to start the escort
>>|cRXP_WARN_This escort can be fatal. Don't hesitate to abandon the attempt if it puts your run at risk|r
.accept 836 >>Accept Rescue OOX-09/HL!
.target Homing Robot OOX-09/HL
.isQuestTurnedIn 485
.solo

step
.goto The Hinterlands,79.47,61.21
>>Escort |cRXP_FRIENDLY_Homing Robot OOX-09/HL|r to the coast
>>|cRXP_WARN_This escort can be fatal. Don't hesitate to abandon the attempt if it puts your run at risk|r
>>|cRXP_WARN_A pack of 3 level 46|r |cRXP_ENEMY_Marauding Owlbeasts|r |cRXP_WARN_will spawn south of Skulk Rock, on the road. They enrage at low HP, so try to kill one at a time|r
>>|cRXP_WARN_A pack of 3 level 47|r |cRXP_ENEMY_Vilebranch Ambushers|r |cRXP_WARN_will spawn in the woods north of Jintha'Alor. They execute when you're below 20% health. Use long CC if you can, and have the chicken tank one or two of them until it's around half HP|r
.complete 836,1 
.target Homing Robot OOX-09/HL
.mob Marauding Owlbeast
.unitscan Vilebranch Ambusher
.isQuestTurnedIn 485
.solo
step
.goto The Hinterlands,86.30,59.00
>>|TInterface/GossipFrame/HealerGossipIcon:0|tSwim to the island to the far east, then click |cRXP_PICK_Rinji's Secret|r
.turnin 2742 >>Turn in Rin'ji is Trapped!
.accept 2782 >>Accept Rin'ji's Secret
step
#completewith next
.goto The Hinterlands,77.28,78.64,30,0
.subzone 3317 >>Travel to Revantusk Village
step
.goto The Hinterlands,77.20,80.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Slagtree|r
.turnin 7839 >>Turn in Vilebranch Hooligans
.target Smith Slagtree
step
.goto The Hinterlands,78.80,78.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yayo'jin|r
.turnin 7844 >>Turn in Cannibalistic Cousins
.target Mystic Yayo'jin
step
.goto The Hinterlands,78.80,78.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yayo'jin|r again
.accept 7862 >>Accept Job Opening: Guard Captain of Revantusk Village
.target Mystic Yayo'jin
.group
step
.goto The Hinterlands,79.08,78.99
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Call to Arms!|r wanted poster by the hut
.accept 7861 >>Accept Wanted: Vile Priestess Hexx and Her Minions
.group
step
.goto The Hinterlands,79.30,79.10
>>|cRXP_WARN_THIS QUEST'S FOLLOW-UP ("Another Message to the Wildhammer") FLAGS YOU FOR PVP! Complete it at your own risk. You have been warned!|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Otho|r
.turnin 7841 >>Turn in Message to the Wildhammer
.target Otho'Mojiko

step
.goto The Hinterlands,79.30,79.10
>>|cRXP_WARN_THIS QUEST ("Another Message to the Wildhammer") FLAGS YOU FOR PVP! Complete it at your own risk, or manually skip this step. You have been warned!|r
.accept 7842 >>Accept Another Message to the Wildhammer
.turnin 7842 >>Turn in Another Message to the Wildhammer
.target Otho Moji'ko

step
.goto The Hinterlands,79.10,79.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Markhor|r
.turnin 7828 >>Turn in Stalking the Stalkers
.turnin 7829 >>Turn in Hunt the Savages
.turnin 7830 >>Turn in Avenging the Fallen
.target Huntsman Markhor
step
#completewith next
.goto The Hinterlands,78,14,81.38,25,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lard|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Lard
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Markhor|r and |cRXP_FRIENDLY_Torntusk|r
.accept 7849 >>Accept Separation Anxiety
.goto The Hinterlands,79.16,79.53
.accept 7845 >>Accept Kidnapped Elder Torntusk!
.accept 7850 >>Accept Dark Vessels
.goto The Hinterlands,78.20,81.17
.target Huntsman Markhor
.target Primal Torntusk
.group
step
#completewith Vilebranchs
>>Loot the |cRXP_LOOT_Vessels of Tainted Blood|r on the ground
>>|cRXP_WARN_Don't worry about focusing on this; you can finish it in later steps|r
.complete 7850,1 
.group 5
step
#completewith ReKey
>>Kill |cRXP_ENEMY_Vilebranch Trolls|r
>>|cRXP_WARN_Don't worry about focusing on this; you can finish it in later steps|r
.complete 7862,4 
.complete 7862,1 
.complete 7862,3 
.complete 7862,2 
.mob Vilebranch Soul Eater
.mob Vilebranch Berserker
.mob Vilebranch Blood Drinker
.mob Vilebranch Shadow Hunter
.group 5
step
.goto The Hinterlands,62.1,75.3
>>Loot the |cRXP_PICK_Pile of Bones|r at the center of the pit for |cRXP_LOOT_Huntsman Malkhor's Bones|r
.complete 7849,2 
.group 5
step
.goto The Hinterlands,58.6,64.9
>>Loot the |cRXP_PICK_Pile of Skulls|r for |cRXP_LOOT_Huntsman Malkhor's Skull|r
.complete 7849,1 
.group 5
step
.goto The Hinterlands,59.6,77.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elder Torntusk|r
.turnin 7845 >>Turn in Kidnapped Elder Torntusk!
.accept 7846 >>Accept Recover the Key!
.target Elder Torntusk
.group
step
.goto The Hinterlands,59.3,78.2
>>Kill |cRXP_ENEMY_Vile Priestess Hex|r
>>|cRXP_WARN_Be extremely cautious of her Hex ability, which she can potentially spam|r
.complete 7861,1 
.unitscan Vile Priestess Hexx
.group 5
step
#completewith Hitahya
>>|cRXP_WARNYou can get to the upper level (without fighting through many guards) by doing a jump skip|r
.link https://www.youtube.com/watch?v=UPiNtMem9tM >> Click here for a video guide
.group
step
#completewith next
>>Loot the |cRXP_LOOT_Ancient Egg|r
.complete 4787,1 
step
#label Hitahya
.goto The Hinterlands,57.8,86.8
>>Kill |cRXP_ENEMY_Hitah'ya the Keeper|r. Loot her for her |cRXP_LOOT_Key|r
.complete 7846,1 
.unitscan Hitah'ya the Keeper
.group 5
step
.goto The Hinterlands,57.60,86.79
>>Loot the |cRXP_LOOT_Ancient Egg|r
.complete 4787,1 
step
.goto The Hinterlands,59.6,77.9
>>Kill |cRXP_ENEMY_Vilebranch Aman'zasi Guards|r
.complete 7861,2 
.mob Vilebranch Aman'zasi Guard
.group 5
step
#label ReKey
.goto The Hinterlands,59.6,77.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elder Torntusk|r
.turnin 7846 >>Turn in Recover the Key!
.accept 7847 >>Accept Return to Primal Torntusk
.target Elder Torntusk
.group
step
#label Vilebranchs
.goto The Hinterlands,60.6,65.4
>>Finish killing |cRXP_ENEMY_Vilebranch Trolls|r
>>|cRXP_ENEMY_Soul Eaters|r |cRXP_WARN_are on the 2nd level.|r |cRXP_ENEMY_Berserkers|r |cRXP_WARN_are on the 3rd level.|r |cRXP_ENEMY_Blood Drinkers|r |cRXP_WARN_and|r |cRXP_ENEMY_Shadow Hunters|r |cRXP_WARN_are on the 4th and 5th levels|r
.complete 7862,4 
.complete 7862,1 
.complete 7862,3 
.complete 7862,2 
.mob Vilebranch Soul Eater
.mob Vilebranch Berserker
.mob Vilebranch Blood Drinker
.mob Vilebranch Shadow Hunter
.group 5
step
.goto The Hinterlands,67.9,73.4
>>Finish looting the |cRXP_LOOT_Vessels of Tainted Blood|r on the ground
>>|cRXP_WARN_Don't worry about focusing on this; you can finish it in later steps|r
.complete 7850,1 
.group 5
step

.goto The Hinterlands,49.30,37.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Homing Robot OOX-09/HL|r
.accept 485 >>Accept Find OOX-09/HL!
.turnin 485 >>Turn in Find OOX-09/HL!
.target Homing Robot OOX-09/HL
.itemcount 8704,1 
.group
step
.goto The Hinterlands,49.35,37.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Homing Robot OOX-09/HL|r to start the escort
>>|cRXP_WARN_This escort can be fatal. Don't hesitate to abandon the attempt if it puts your run at risk|r
.accept 836 >>Accept Rescue OOX-09/HL!
.target Homing Robot OOX-09/HL
.isQuestTurnedIn 485
.group
step
.goto The Hinterlands,79.47,61.21
>>Escort |cRXP_FRIENDLY_Homing Robot OOX-09/HL|r to the coast
>>|cRXP_WARN_This escort can be fatal. Don't hesitate to abandon the attempt if it puts your run at risk|r
>>|cRXP_WARN_A pack of 3 level 46|r |cRXP_ENEMY_Marauding Owlbeasts|r |cRXP_WARN_will spawn south of Skulk Rock, on the road. They enrage at low HP, so try to kill one at a time|r
>>|cRXP_WARN_A pack of 3 level 47|r |cRXP_ENEMY_Vilebranch Ambushers|r |cRXP_WARN_will spawn in the woods north of Jintha'Alor. They execute when you're below 20% health. Use long CC if you can, and have the chicken tank one or two of them until it's around half HP|r
.complete 836,1 
.target Homing Robot OOX-09/HL
.mob Marauding Owlbeast
.unitscan Vilebranch Ambusher
.isQuestTurnedIn 485
.group
step
#completewith next
.goto The Hinterlands,77.28,78.64,30,0
.subzone 3317 >>Travel to Revantusk Village
step
.goto The Hinterlands,78.80,78.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yayo'jin|r
.turnin 7862 >>Turn in Job Opening: Guard Captain of Revantusk Village
.turnin 7861 >>Turn in Wanted: Vile Priestess Hexx and Her Minions
.target Mystic Yayo'jin
.isQuestComplete 7862
.isQuestComplete 7861
.group
step
.goto The Hinterlands,78.80,78.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yayo'jin|r
.turnin 7861 >>Turn in Wanted: Vile Priestess Hexx and Her Minions
.target Mystic Yayo'jin
.isQuestComplete 7861
.group
step
.goto The Hinterlands,78.80,78.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yayo'jin|r
.turnin 7862 >>Turn in Job Opening: Guard Captain of Revantusk Village
.target Mystic Yayo'jin
.isQuestComplete 7862
.group
step
.goto The Hinterlands,79.16,79.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Markhor|r
.turnin 7849 >>Turn in Separation Anxiety
.target Huntsman Markhor
.isQuestComplete 7849
.group
step
#completewith next
.goto The Hinterlands,78,14,81.38,25,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lard|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Lard
.group
step
.goto The Hinterlands,78.20,81.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Primal Torntusk|r
.turnin 7845 >>Turn in Kidnapped Elder Torntusk!
.turnin 7850 >>Turn in Dark Vessels
.turnin 7847 >>Turn in Return to Primal Torntusk
.target Primal Torntusk
.isOnQuest 7845
.isQuestComplete 7850
.isOnQuest 7847
.group
step
.goto The Hinterlands,78.20,81.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Primal Torntusk|r
.turnin 7845 >>Turn in Kidnapped Elder Torntusk!
.target Primal Torntusk
.isOnQuest 7845
.group
step
.goto The Hinterlands,78.20,81.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Primal Torntusk|r
.turnin 7850 >>Turn in Dark Vessels
.target Primal Torntusk
.isQuestComplete 7850
.group
step
.goto The Hinterlands,78.20,81.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Primal Torntusk|r
.turnin 7847 >>Turn in Return to Primal Torntusk
.target Primal Torntusk
.isOnQuest 7847
.group
step
#completewith next
.goto The Hinterlands,81.70,81.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gorkas|r
.fly Hammerfall >> Fly to Hammerfall
.target Gorkas
.skill firstaid,<260,1
step
.goto Arathi Highlands,73.41,36.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doctor Gregory Victor|r
.train 18629 >> Train Runecloth Bandage
.target Doctor Gregory Victor
.skill firstaid,<260,1
step << !Mage
.goto Arathi Highlands,73.10,32.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urda|r
.fly Undercity >>Fly to Undercity
.target Urda
.zoneskip Arathi Highlands,1
step << !Mage
.goto The Hinterlands,81.70,81.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gorkas|r
.fly Undercity >>Fly to Undercity
.target Gorkas
.zoneskip Hinterlands,1
step << Mage
#completewith next
.cast 3563 >>Cast |T135766:0|t[Teleport: Undercity]
.zoneskip Undercity
step << Mage
.goto Undercity,82.79,15.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hannah|r
.vendor >>Buy at least four |cRXP_BUY_Rune of Teleportation|r
.collect 17031,4 
.target Hannah Akeley
step
.goto Undercity,73.50,32.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oran|r
.turnin 2995 >>Turn in Lines of Communication
.turnin 2782 >>Turn in Rin'ji's Secret
.accept 8273 >>Accept Oran's Gratitude
.turnin 8273 >>Turn in Oran's Gratitude
.target Oran Snakewrithe
step
.goto Undercity,48.50,71.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cuely|r
.accept 3568 >>Accept Seeping Corruption
.target Chemist Cuely
step
.abandon 7862 >> Abandon Job Opening: Guard Captain of Revantusk Village
.isOnQuest 7862
step
.abandon 7861 >> Abandon Wanted: Vile Priestess Hexx and Her Minions
.isOnQuest 7861
step
.abandon 7849 >> Abandon Separation Anxiety
.isOnQuest 7849
step
.abandon 7845 >> Abandon Kidnapped Elder Torntusk!
.isOnQuest 7845
step
.abandon 7850 >> Abandon Dark Vessels
.isOnQuest 7850
step
.abandon 7846 >> Abandon Recover the Key!
.isOnQuest 7846
step
.hs >>Hearth to Tanaris
.use 6948
step
#completewith next
.goto Tanaris,52.63,28.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dirge|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Dirge Quikcleave
step
.goto Tanaris,51.10,26.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sprinkle|r
.turnin 2641 >>Turn in Sprinkle's Secret Ingredient
.accept 2661 >>Accept Delivery for Marin
.target Sprinkle
step
.goto Tanaris,51.80,28.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Marin|r
.turnin 2661 >>Turn in Delivery for Marin
.accept 2662 >>Accept Noggenfogger Elixir
.turnin 2662 >>Turn in Noggenfogger Elixir
.collect 8529,60 >>|cRXP_WARN_Carrying a stack of|r |T134863:0|t[Noggenfogger Elixir] |cRXP_WARN_on you at all times is a good practice. Buy 2 extra stacks, then bank them|r
.target Marin Noggenfogger
step
.goto Tanaris,66.989,22.354
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yeh'kinya|r
.turnin 4787 >> Turn in The Ancient Egg
.target Yeh'kinya
.isQuestComplete 4787
.dungeon ZF
step
#sticky
#completewith EnterMaraudon
.subzone 2100 >> Now you should be looking for a group to Maraudon
.dungeon MARA
step
.goto Tanaris,51.60,25.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bulkrek|r
.fly Shadowprey Village >>Fly to Shadowprey Village
.target Bullkrek Ragefist
.zoneskip Feralas
.dungeon MARA
step
.goto Desolace,23.22,70.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vark|r at the top of the hut
.accept 7029 >> Accept Vyletongue Corruption
.target Vark Battlescar
.dungeon MARA
step
.goto Desolace,26.87,77.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Selendra|r
.accept 7064 >> Accept Corruption of Earth and Seed
.target Selendra
.dungeon MARA
step
.line Desolace,50.48,86.66,50.39,86.61,50.18,87.01,49.89,87.11,48.95,87.04,48.73,87.11,48.25,87.14,47.82,87.34,47.01,86.96,45.68,86.22,45.16,86.32,44.74,86.12,44.40,85.69,44.11,85.25,43.77,84.93,43.59,84.93
.goto Desolace,43.59,84.93,50,0
.goto Desolace,47.01,86.96,70,0
.goto Desolace,50.48,86.66,50,0
.goto Desolace,47.01,86.96,70,0
.goto Desolace,43.59,84.93,50,0
.goto Desolace,50.48,86.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Centaur Pariah|r
>>|cRXP_WARN_The |cRXP_FRIENDLY_Centaur Pariah|r patrols slightly around southern Desolace|r
.accept 7067 >> Accept The Pariah's Instructions
.target Centaur Pariah
.dungeon MARA
step
.goto Desolace,62.194,39.624
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Willow|r
.accept 7028 >> Accept Twisted Evils
.target Willow
.dungeon MARA
step
.goto Desolace,29.89,62.44,0
.goto 1414,38.43,57.97
.zone 1414 >> Travel to Maraudon
.dungeon MARA
step
#completewith EnterMaraudon
>>Kill all |cRXP_ENEMY_Monsters|r in Maraudon. Loot them for their |cRXP_LOOT_Theradric Crystal Carvings|r
>>|cRXP_WARN_This can be completed OUTSIDE and INSIDE of the Instance. Don't attempt to complete this now|r
.complete 7028,1 
.isOnQuest 7028
.dungeon MARA
step
>>Kill |cRXP_ENEMY_The Nameless Prophet|r. Loot it for the |T133277:0|t[|cRXP_LOOT_Amulet of Spirits|r]
>>|cRXP_WARN_This is completed OUTSIDE of the Instance. |cRXP_ENEMY_The Nameless Prophets|r may be patrolling|r
.collect 17757,1,7067,1 
.mob The Nameless Prophet
.isOnQuest 7067
.dungeon MARA
step
#completewith next
>>Kill |cRXP_ENEMY_Shadowshard Smashers|r and |cRXP_ENEMY_Shadowshard Rumblers|r. Loot them for their |cRXP_LOOT_Shadowshard Fragments|r
>>|cRXP_WARN_These are only found in the Purple section outside of the Instance|r
.complete 7068,1 
.mob Shadowshard Smasher
.mob Shadowshard Rumbler
.isOnQuest 7068
.dungeon MARA
step
.goto 1414,38.469,57.287,20,0
.goto 1414,38.380,57.376,30,0
.goto 1414,38.469,57.287
>>|cRXP_WARN_Use the|r |T133277:0|t[|cRXP_LOOT_Amulet of Spirits|r] |cRXP_WARN_on the|r |cRXP_FRIENDLY_Spirit of Gelk|r
>>Kill |cRXP_ENEMY_Gelk|r. Loot him for the |T134104:0|t[|cRXP_LOOT_Gem of the Second Khan|r]
>>|cRXP_WARN_This is completed OUTSIDE of the Instance|r
.collect 17762,1,7067,1 
.use 17757 
.mob Spirit of Gelk
.mob Gelk
.isOnQuest 7067
.dungeon MARA
step
.goto 1414,38.13,56.90,60,0
.goto 1414,28.76,56.96,60,0
.goto 1414,38.13,56.90
>>Kill |cRXP_ENEMY_Shadowshard Smashers|r and |cRXP_ENEMY_Shadowshard Rumblers|r. Loot them for their |cRXP_LOOT_Shadowshard Fragments|r
>>|cRXP_WARN_These are only found in the Purple section outside of the Instance|r
.complete 7068,1 
.mob Shadowshard Smasher
.mob Shadowshard Rumbler
.isOnQuest 7068
.dungeon MARA
step
.goto 1414,38.497,57.721
>>|cRXP_WARN_Use the|r |T133277:0|t[|cRXP_LOOT_Amulet of Spirits|r] |cRXP_WARN_on the|r |cRXP_FRIENDLY_Spirit of Kolk|r
>>Kill |cRXP_ENEMY_Kolk|r. Loot him for the |T134129:0|t[|cRXP_LOOT_Gem of the First Khan|r]
>>|cRXP_WARN_This is completed OUTSIDE of the Instance|r
.collect 17761,1,7067,1 
.use 17757 
.mob Spirit of Kolk
.mob Kolk
.isOnQuest 7067
.dungeon MARA
step
.goto 1414,38.77,58.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Centaur Pariah|r
.accept 7044 >> Accept Legends of Maraudon
.target Cavindra
.dungeon MARA
step
.goto 1414,38.928,58.354
>>|cRXP_WARN_Use the|r |T134865:0|t[Coated Cerulean Vial] |cRXP_WARN_in the Orange pool|r
.complete 7029,2 
.use 17693 
.isOnQuest 7029
.dungeon MARA
step
.goto 1414,39.00,58.32,70,0
.goto 1414,39.13,57.68,60,0
.goto 1414,39.25,57.71,20,0
.goto 1414,39.13,57.68
>>|cRXP_WARN_Use the|r |T133277:0|t[|cRXP_LOOT_Amulet of Spirits|r] |cRXP_WARN_on the|r |cRXP_FRIENDLY_Spirit of Magra|r
>>Kill |cRXP_ENEMY_Magra|r. Loot him for the |T134135:0|t[|cRXP_LOOT_Gem of the Third Khan|r]
>>|cRXP_WARN_This is completed OUTSIDE of the Instance|r
.collect 17763,1,7067,1 
.use 17757 
.mob Spirit of Magra
.mob Magra
.isOnQuest 7067
.dungeon MARA
step
#label EnterMaraudon
.goto 1414,39.266,58.205
.zone 280 >> Enter the Maraudon Instance through the Orange side
.dungeon MARA
step
#completewith CrystalCarving
>>Kill any |cRXP_ENEMY_Monster|r in Maraudon. Loot them for their |cRXP_LOOT_Theradric Crystal Carvings|r
.complete 7028,1 
.isOnQuest 7028
.dungeon MARA
step
#completewith next
>>|cRXP_WARN_Use the|r |T134804:0|t[Filled Cerulean Vial] |cRXP_WARN_on small flowers/plants inside Orange|r
>>Kill the |cRXP_ENEMY_Noxxious Scions|r that are summoned
.complete 7029,1 
.use 17696 
.isOnQuest 7029
.dungeon MARA
step
>>|cRXP_WARN_Use the|r |T133277:0|t[|cRXP_LOOT_Amulet of Spirits|r] |cRXP_WARN_on the|r |cRXP_FRIENDLY_Spirit of Veng|r
>>Kill |cRXP_ENEMY_Veng|r. Loot him for the |T134116:0|t[|cRXP_LOOT_Gem of the xxxxxxxx Khan|r]
>>|cRXP_ENEMY_Veng|r |cRXP_WARN_patrols around INSIDE the Maraudon Orange Instance|r
.collect 17765,1,7067,1 
.use 17757 
.mob Spirit of Veng
.mob Veng
.isOnQuest 7067
.dungeon MARA
step
>>|cRXP_WARN_Use the|r |T134804:0|t[Filled Cerulean Vial] |cRXP_WARN_on small flowers/plants inside Orange|r
>>Kill the |cRXP_ENEMY_Noxxious Scions|r that are summoned
.complete 7029,1 
.use 17696 
.isOnQuest 7029
.dungeon MARA
step
>>Kill |cRXP_ENEMY_Noxxion|r. Loot him for the |cRXP_LOOT_Celebrian Rod|r
>>Kill |cRXP_ENEMY_Lord Vyletongue|r. Loot him for the |cRXP_LOOT_Celebrian Diamond|r
>>|cRXP_ENEMY_Noxxion|r |cRXP_WARN_is in the Orange section and |cRXP_ENEMY_Lord Vyletongue|r in the Purple|r
.complete 7044,2 
.complete 7044,1 
.isOnQuest 7044
.dungeon MARA
step
>>|cRXP_WARN_Use the|r |T133277:0|t[|cRXP_LOOT_Amulet of Spirits|r] |cRXP_WARN_on the|r |cRXP_FRIENDLY_Spirit of Maraudos|r
>>Kill |cRXP_ENEMY_Maraudos|r. Loot him for the |T134132:0|t[|cRXP_LOOT_Gem of the Fourth Khan|r]
>>|cRXP_ENEMY_Maraudos|r |cRXP_WARN_patrols around INSIDE the Maraudon Purple Instance|r
.collect 17764,1,7067,1 
.use 17757 
.mob Spirit of Maraudos
.mob Maraudos
.isOnQuest 7067
.dungeon MARA
step
>>|cRXP_WARN_Channel any of the|r |T134129:0|t|T134104:0|t|T134135:0|t|T134132:0|t|T134116:0|t[|cRXP_LOOT_Gems of the Khans|r] |cRXP_WARN_to create the|r |T133277:0|t[|cRXP_LOOT_Amulet of Union|r]
.complete 7067,1 
.use 17761,1
.use 17762,1
.use 17763,1
.use 17764,1
.use 17765,1
.itemcount 17761,1
.itemcount 17762,1
.itemcount 17763,1
.itemcount 17764,1
.itemcount 17765,1
.isOnQuest 7067
.dungeon MARA
step
>>Kill |cRXP_ENEMY_Celebras the Cursed|r then talk to |cRXP_FRIENDLY_Celebras the Redeemed|r
.turnin 7044 >> Turn in Legends of Maraudon
.isQuestComplete 7044
.mob Celebras the Cursed
.target Celebras the Redeemed
.dungeon MARA
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Celebras the Redeemed|r
.accept 7046 >> Accept The Scepter of Celebras
.timer 14,Incantation of Celebras Spawning RP
.target Celebras the Redeemed
.isQuestTurnedIn 7044
.dungeon MARA
step
.cast 6477 >> Click the |cRXP_PICK_Incantation of Celebras|r on the ground
.timer 34,The Scepter of Celebras RP
.isQuestTurnedIn 7044
.dungeon MARA
step
>>|cRXP_WARN_Wait out the RP|r
.complete 7046,1 
.isQuestTurnedIn 7044
.dungeon MARA
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Celebras the Redeemed|r
.turnin 7046 >> Turn in The Scepter of Celebras
.isQuestTurnedIn 7044
.target Celebras the Redeemed
.dungeon MARA
step
>>Kill |cRXP_ENEMY_Princess Theradras|r
.complete 7064,1 
.mob Princess Theradras
.isOnQuest 7064
.dungeon MARA
step
#label CrystalCarving
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zaetar's Spirit|r
.accept 7066 >> Accept Seed of Life
.target Zaetar's Spirit
.dungeon MARA
step
>>Kill any |cRXP_ENEMY_Monster|r in Maraudon. Loot them for their |cRXP_LOOT_Theradric Crystal Carvings|r
>>|cRXP_WARN_This can be completed OUTSIDE and INSIDE of the Instance|r
.complete 7028,1 
.isOnQuest 7028
.dungeon MARA
step
.zone Desolace >> Leave the Maraudon instance
step
.goto Desolace,26.87,77.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Selendra|r
.turnin 7064 >> Turn in Corruption of Earth and Seed
.target Selendra
.isQuestComplete 7064
.dungeon MARA
step
.goto Desolace,23.22,70.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vark|r at the top of the hut
.turnin 7029 >> Turn in Vyletongue Corruption
.target Vark Battlescar
.isQuestComplete 7029
.dungeon MARA
step
.line Desolace,50.48,86.66,50.39,86.61,50.18,87.01,49.89,87.11,48.95,87.04,48.73,87.11,48.25,87.14,47.82,87.34,47.01,86.96,45.68,86.22,45.16,86.32,44.74,86.12,44.40,85.69,44.11,85.25,43.77,84.93,43.59,84.93
.goto Desolace,43.59,84.93,50,0
.goto Desolace,47.01,86.96,70,0
.goto Desolace,50.48,86.66,50,0
.goto Desolace,47.01,86.96,70,0
.goto Desolace,43.59,84.93,50,0
.goto Desolace,50.48,86.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Centaur Pariah|r
>>|cRXP_WARN_The |cRXP_FRIENDLY_Centaur Pariah|r patrols slightly around southern Desolace|r
.turnin 7067 >> Turn in The Pariah's Instructions
.target Centaur Pariah
.isQuestComplete 7067
.dungeon MARA
step
.goto Desolace,62.194,39.624
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Willow|r
.turnin 7028 >> Turn in Twisted Evils
.target Willow
.isQuestComplete 7028
.dungeon MARA
step
.hs >>Hearth to Tanaris
.use 6948
.dungeon MARA
step
#completewith next
.goto Tanaris,52.63,28.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dirge|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Dirge Quikcleave
.dungeon MARA
step
.goto Tanaris,51.60,25.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bulkrek|r
.fly Feralas>>Fly to Feralas
.target Bullkrek Ragefist
.zoneskip Feralas
step
.abandon 7029 >> Abandon Vyletongue Corruption
.isOnQuest 7029
.dungeon MARA
step
.abandon 7064 >> Abandon Corruption of Earth and Seed
.isOnQuest 7064
.dungeon MARA
step
.abandon 7067 >> Abandon The Pariah's Instructions
.isOnQuest 7067
.dungeon MARA
step
.abandon 7028 >> Abandon Twisted Evils
.isOnQuest 7028
.dungeon MARA
step
.abandon 7068 >> Abandon Shadowshard Fragments
.isOnQuest 7068
.dungeon MARA
step
.abandon 7044 >> Abandon Legends of Maraudon
.isOnQuest 7044
.dungeon MARA
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 50-60
#name 50-51 Feralas
#next 51-52 Stranglethorn/Blasted Lands
step
.goto Feralas,76.06,43.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bronk|r
.vendor >> |cRXP_BUY_Buy|r |T134833:0|t[Superior Healing Potions] |cRXP_BUY_from him if they're up|r
.target Bronk
step
.goto Feralas,76.20,43.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Talo|r
.accept 3063 >>Accept Vengeance on the Northspring
.accept 3062 >>Accept Dark Heart
.target Talo Thornhoof
.group
step
.goto Feralas,76.20,43.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Talo|r
.accept 3063 >>Accept Vengeance on the Northspring
.target Talo Thornhoof
step
.goto Feralas,74.50,42.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jangdor|r
.accept 7734 >>Accept Improved Quality
.target Jangdor Swiftstrider
step
.goto Feralas,74.50,43.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uzer'i|r
.turnin 3123 >>Turn in Testing the Vessel
.accept 3124 >>Accept Hippogryph Muisek
.accept 3128 >>Accept Natural Materials
.target Witch Doctor Uzer'i
step
#completewith next
.goto Feralas,58.0,53.1,50,0
.goto Feralas,54.2,68.6,0
.subzone 1106 >>Travel southwest to the Frayfeather Highlands
step
.loop 25,Feralas,55.6,60.6,55.4,64.2,53.8,66.8,54.6,68.6,54.0,71.6,54.2,72.6,55.6,75.2,57.0,74.8,56.0,72.4,55.0,70.6,56.2,66.0,56.8,65.6,57.4,62.6,55.6,60.6
.use 9619 >>Kill |cRXP_ENEMY_Frayfeather Hippogryphs|r. Loot them for their |cRXP_LOOT_Fragments|r
>>Use the |T133841:0|t[Hippogryph Muisek Vessel] on their corpses
>>|cRXP_WARN_This item has a cooldown and only works on one corpse at a time, even if they're stacked|r
.complete 3124,1 
.complete 3128,4 
.mob Frayfeather Stagwing
.mob Frayfeather Skystormer
.mob Frayfeather Hippogryph
.mob Frayfeather Patriarch
step
#completewith next
.goto Feralas,75.9,43.7,0
.subzone 1099 >>Travel to Camp Mojache
step
.goto Feralas,74.42,43.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uzer'i|r
.turnin 3124 >>Turn in Hippogryph Muisek
.accept 3125 >>Accept Faerie Dragon Muisek
.target Witch Doctor Uzer'i
step
.goto Feralas,69.55,46.96,50,0
.goto Feralas,68.82,48.54,50,0
.goto Feralas,67.69,47.95,50,0
.goto Feralas,66.57,47.74,50,0
.goto Feralas,69.55,46.96,50,0
.goto Feralas,68.82,48.54,50,0
.goto Feralas,67.69,47.95
.use 9620 >>Kill |cRXP_ENEMY_Sprite Darters|r. Loot them for their |cRXP_LOOT_Minerals|r.
>>Use the |T133841:0|t[Faerie Dragon Muisek Vessel] on their corpses
>>|cRXP_WARN_This item has a cooldown and only works on one corpse at a time, even if they're stacked|r
.complete 3125,1 
.complete 3128,2 
.mob Sprite Darter
step
.goto Feralas,74.42,43.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uzer'i|r
.turnin 3125 >>Turn in Faerie Dragon Muisek
.accept 3126 >>Accept Treant Muisek
.target Witch Doctor Uzer'i
step
.goto Feralas,69.4,44.6,70,0
.goto Feralas,70.6,41.8,70,0
.goto Feralas,75.0,38.6,70,0
.goto Feralas,77.4,40.8,70,0
.goto Feralas,78.6,42.4,70,0
.goto Feralas,79.6,45.4,70,0
.goto Feralas,69.4,44.6
.line Feralas,55.8,60.8,55.0,65.0,55.4,66.2,54.4,69.0,55.0,71.6,58.2,74.6
.line Feralas,67.97,59.99,68.99,60.19,69.57,59.39,70.42,57.76,71.48,58.00,72.27,59.39,72.71,58.54,74.24,58.18,74.72,56.33,74.24,58.18,72.89,57.66,72.67,56.02,73.44,54.87,73.60,53.79,73.97,53.33,74.26,53.12,73.94,51.66,72.80,50.88
.line Feralas,78.4,41.8,74.6,38.4,72.4,41.2,70.6,41.8,69.4,44.6
.line Feralas,52.0,47.8,52.8,46.2,55.0,47.6,55.6,47.0
.use 9606 >>Kill |cRXP_ENEMY_Wandering Forest Walkers|r. Loot them for their |cRXP_LOOT_Splintered Logs|r
>>Use the |T133841:0|t[Treant Muisek Vessel] on their corpses
>>|cRXP_WARN_The arrow will guide you along their patrol routes, which are outlined on your world map too. The quest item has a cooldown and only works on one corpse at a time, even if they're stacked|r
.collect 9590,1 
.collect 9593,1 
.unitscan Wandering Forest Walker
step
.goto Feralas,67.97,59.99,70,0
.goto Feralas,68.99,60.19,70,0
.goto Feralas,69.57,59.39,70,0
.goto Feralas,70.42,57.76,70,0
.goto Feralas,71.48,58.00,70,0
.goto Feralas,72.27,59.39,70,0
.goto Feralas,72.71,58.54,70,0
.goto Feralas,74.24,58.18,70,0
.goto Feralas,74.72,56.33,70,0
.goto Feralas,74.24,58.18,70,0
.goto Feralas,72.89,57.66,70,0
.goto Feralas,72.67,56.02,70,0
.goto Feralas,73.44,54.87,70,0
.goto Feralas,73.60,53.79,70,0
.goto Feralas,73.97,53.33,70,0
.goto Feralas,74.26,53.12,70,0
.goto Feralas,73.94,51.66,70,0
.goto Feralas,72.80,50.88,70,0
.line Feralas,55.8.,60.8,55.0,65.0,55.4,66.2,54.4,69.0,55.0,71.6,58.2,74.6
.line Feralas,67.97,59.99,68.99,60.19,69.57,59.39,70.42,57.76,71.48,58.00,72.27,59.39,72.71,58.54,74.24,58.18,74.72,56.33,74.24,58.18,72.89,57.66,72.67,56.02,73.44,54.87,73.60,53.79,73.97,53.33,74.26,53.12,73.94,51.66,72.80,50.88
.line Feralas,78.4,41.8,74.6,38.4,72.4,41.2,70.6,41.8,69.4,44.6
.line Feralas,52.0,47.8,52.8,46.2,55.0,47.6,55.6,47.0
.use 9606 >>Kill |cRXP_ENEMY_Wandering Forest Walkers|r. Loot them for their |cRXP_LOOT_Splintered Logs|r
>>Use the |T133841:0|t[Treant Muisek Vessel] on their corpses
>>|cRXP_WARN_The arrow will guide you along their patrol routes, which are outlined on your world map too. The quest item has a cooldown and only works on one corpse at a time, even if they're stacked|r
.collect 9590,2 
.collect 9593,2 
.unitscan Wandering Forest Walker
step
.goto Feralas,58.6,52.0,70,0
.goto Feralas,60.0,48.8,70,0
.goto Feralas,57.8,48.0,70,0
.goto Feralas,55.6,47.0,70,0
.goto Feralas,53.2,46.6,70,0
.goto Feralas,51.6,49.0,70,0
.goto Feralas,58.6,52.0
.line Feralas,55.8.,60.8,55.0,65.0,55.4,66.2,54.4,69.0,55.0,71.6,58.2,74.6
.line Feralas,67.97,59.99,68.99,60.19,69.57,59.39,70.42,57.76,71.48,58.00,72.27,59.39,72.71,58.54,74.24,58.18,74.72,56.33,74.24,58.18,72.89,57.66,72.67,56.02,73.44,54.87,73.60,53.79,73.97,53.33,74.26,53.12,73.94,51.66,72.80,50.88
.line Feralas,78.4,41.8,74.6,38.4,72.4,41.2,70.6,41.8,69.4,44.6
.line Feralas,52.0,47.8,52.8,46.2,55.0,47.6,55.6,47.0
.use 9606 >>Kill |cRXP_ENEMY_Wandering Forest Walkers|r. Loot them for their |cRXP_LOOT_Splintered Logs|r
>>Use the |T133841:0|t[Treant Muisek Vessel] on their corpses
>>|cRXP_WARN_The arrow will guide you along their patrol routes, which are outlined on your world map too. The quest item has a cooldown and only works on one corpse at a time, even if they're stacked|r
.collect 9593,3 
.unitscan Wandering Forest Walker
step
#completewith next
.goto Feralas,75.9,43.7,0
.subzone 1099 >>Travel to Camp Mojache
step
.goto Feralas,74.42,43.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uzer'i|r
.turnin 3126 >>Turn in Treant Muisek
.accept 3127 >>Accept Mountain Giant Muisek
.target Witch Doctor Uzer'i
step
#completewith next
.goto Feralas,51.89,49.82,30,0
.goto Feralas,48.82,45.15,30,0
.goto Feralas,45.67,46.94,30,0
.subzone 1108 >>Travel west to The Forgotten Coast
step
.goto Feralas,44.81,43.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zorbin|r
.accept 7003 >>Accept Zapped Giants
.target Zorbin Fandazzle
step
#completewith next
>>Keep an eye out for a |T134362:0|t[|cFF00BCD4Perfect Yeti Hide|r]
>>|cRXP_WARN_DON'T ACCEPT THE QUEST YET! Skip this step if you don't find one before collecting all of your|r |cRXP_LOOT_Rage Scar Yeti Hides|r
.collect 18972,1 
step
.goto Feralas,52.05,31.82,40,0
.loop 25,Feralas,52.06,30.72,52.50,29.74,53.09,30.80,52.05,31.82,53.11,31.79,54.33,32.54,55.07,32.27,55.43,33.53,55.81,33.0,54.34,33.21,54.81,33.86,54.34,33.21,55.81,33.0,55.43,33.53,55.07,32.27,54.33,32.54,53.11,31.79,52.05,31.82,52.06,30.72
>>Kill |cRXP_ENEMY_Rage Scar Yetis|r. Loot them for their |cRXP_LOOT_Hides|r
.complete 7734,1 
.mob Ferocious Rage Scar
.mob Rage Scar Yeti
.mob Elder Rage Scar
step
.loop 25,Feralas,41.08,24.52,39.36,24.29,38.38,22.21,38.52,20.83,39.47,22.04,41.08,24.52
.use 18904 >>Use |T133003:0|t[Zorbin's Ultra-Shrinker] on |cRXP_ENEMY_Land Walkers|r and |cRXP_ENEMY_Cliff Giants|r. Kill them and loot their |cRXP_LOOT_Residue|r
.use 9621 >>Use the |T133841:0|t[Mountain Giant Muisek Vessel] on their corpses
>>|cRXP_WARN_This item has a cooldown and only works on one corpse at a time, even if they're stacked|r
.complete 3127,1 
.collect 18956,8 
.mob Land Walker
.mob Cliff Giant
step
#completewith next
.goto Feralas,40.9,12.0,0
.subzone 1114 >>Travel north to the Ruins of Ravenwind
step
#completewith next
>>Kill |cRXP_ENEMY_Northspring Harpies|r. Loot them for the |T134228:0|t[Horn of Hatetalon]
>>|cRXP_WARN_The horn has a low droprate, it can take a while before you get it|r
.complete 3063,1 
.complete 3063,2 
.complete 3063,3 
.complete 3063,4 
.collect 9530,1 
.mob Northspring Harpy
.mob Northspring Roguefeather
.mob Northspring Slayer
.mob Northspring Windcaller
.group 2
step
.goto Feralas,40.56,8.58
.use 9530 >>Use the |T134228:0|t[Horn of Hatetalon] to summon |cRXP_ENEMY_Edana Hatetalon|r. Kill her and loot her for her |cRXP_LOOT_Heart|r
.complete 3062,1 
.unitscan Edana of Hatetalon
.group 2
step
.loop 25,Feralas,38.62,13.35,38.61,14.64,39.78,14.09,39.95,12.41,40.98,11.09,39.70,11.09,38.83,10.87,38.07,12.04,38.62,13.35
>>Kill |cRXP_ENEMY_Northspring Harpies|r
.complete 3063,1 
.complete 3063,2 
.complete 3063,3 
.complete 3063,4 
.mob Northspring Harpy
.mob Northspring Roguefeather
.mob Northspring Slayer
.mob Northspring Windcaller
step
.goto Feralas,38.1,14.4
.xp 51 >>Grind to level 51

step
.loop 25,Feralas,41.08,24.52,39.36,24.29,38.38,22.21,38.52,20.83,39.47,22.04,41.08,24.52
.use 18904 >>Use |T133003:0|t[Zorbin's Ultra-Shrinker] on |cRXP_ENEMY_Land Walkers|r and |cRXP_ENEMY_Cliff Giants|r. Kill them and loot their |cRXP_LOOT_Residue|r
.use 9621 >>Use the |T133841:0|t[Mountain Giant Muisek Vessel] on their corpses
>>|cRXP_WARN_This item has a cooldown and only works on one corpse at a time, even if they're stacked|r
.complete 3127,1 
.complete 7003,1 
.mob Land Walker
.mob Cliff Giant
step
#completewith next
.goto Feralas,44.8,44.0,0
.subzone 1108 >>Travel south to the Forgotten Coast
step
.goto Feralas,44.81,43.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zorbin|r
.turnin 7003 >>Turn in Zapped Giants
.target Zorbin Fandazzle
step
#completewith next
.hs >>Hearth to Gadgetzan
.use 6948
step
.goto Tanaris,52.63,28.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dirge|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Dirge Quikcleave
step
.goto Tanaris,52.70,45.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Marvon|r
.turnin 3380 >>Turn in The Sunken Temple
.target Marvon Rivetseeker
step
#completewith next
.goto Tanaris,27.00,55.66,150,0
.goto Tanaris,27.00,50.21
.zone Un'Goro Crater >>Travel to Un'Goro Crater
step
.goto Un'Goro Crater,71.64,75.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torwa|r
.accept 4289 >>Accept The Apes of Un'Goro
.accept 4290 >>Accept The Fare of Lar'korwi
.target Torwa Pathfinder
step
#completewith Scent
.loop 25,Un'Goro Crater,68.2,75.0,67.0,71.2,67.8,67.0,68.0,61.6,64.8,62.6,63.0,66.4,61.6,70.8,59.8,75.2,59.4,79.0,62.0,82.4,61.8,76.0,63.6,77.2,66.2,77.8,68.2,75.0
>>Kill |cRXP_ENEMY_Ravasaur raptors|r. Loot them for their |cRXP_LOOT_Claws|r
>>|cRXP_WARN_Don't focus on this quest yet, just kill them if they cross your path|r
.complete 4300,1 
.mob Ravasaur
.mob Ravasaur Hunter
.mob Venomhide Ravasaur
.mob Ravasaur Runner
.mob Ravasaur Matriarch
.isOnQuest 4300
step
#completewith BoneBlade
.goto Un'Goro Crater,70.60,53.26,0
>>Save 25 |cRXP_LOOT_Un'Goro Soil|r that you'll loot from mobs as you quest
.collect 11018,25 
step
#completewith BoneBlade
.goto Un'Goro Crater,73.06,51.57,0
>>Loot 7 |cRXP_LOOT_Power Crystals|r of each color as you quest
.collect 11186,7 
.collect 11188,7 
.collect 11185,7 
.collect 11184,7 
step
.goto Un'Goro Crater,63.10,68.60
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Wrecked Raft|r
.accept 3844 >>Accept It's a Secret to Everybody
step
.goto Un'Goro Crater,63.10,69.00
>>|TInterface/GossipFrame/HealerGossipIcon:0|tGo underwater, then click the |cRXP_PICK_Small Pack|r
.turnin 3844 >>Turn in It's a Secret to Everybody
.accept 3845 >>Accept It's a Secret to Everybody
step
.goto Un'Goro Crater,68.80,56.80
>>Loot the |cRXP_PICK_Fresh Threshadon Carcass|r for a |cRXP_LOOT_Piece of Threshadon Carcass|r
.complete 4290,1 
step
.goto Un'Goro Crater,71.64,75.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torwa|r
.turnin 4290 >>Turn in The Fare of Lar'korwi
.accept 4291 >>Accept The Scent of Lar'korwi
.target Torwa Pathfinder
step
.goto Un'Goro Crater,67.30,73.10,20,0
.goto Un'Goro Crater,66.60,66.70
>>Step on the small egg nests to summon |cRXP_ENEMY_Lar'Korwi Mates|r. Kill them and loot them for their |cRXP_LOOT_Glands|r
.complete 4291,1 
.unitscan Lar'Korwi Mate
step
#label Scent
.goto Un'Goro Crater,71.64,75.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torwa|r
.turnin 4291 >>Turn in The Scent of Lar'korwi
.target Torwa Pathfinder
step
#label BoneBlade
.loop 25,Un'Goro Crater,68.2,75.0,67.0,71.2,67.8,67.0,68.0,61.6,64.8,62.6,63.0,66.4,61.6,70.8,59.8,75.2,59.4,79.0,62.0,82.4,61.8,76.0,63.6,77.2,66.2,77.8,68.2,75.0
>>Kill |cRXP_ENEMY_Ravasaur raptors|r. Loot them for their |cRXP_LOOT_Claws|r
.complete 4300,1 
.mob Ravasaur
.mob Ravasaur Hunter
.mob Venomhide Ravasaur
.mob Ravasaur Runner
.mob Ravasaur Matriarchaw
.isOnQuest 4300
step 
>>Loot 7 |cRXP_LOOT_Power Crystals|r of each color
.collect 11186,7 
.collect 11188,7 
.collect 11185,7 
.collect 11184,7 
step
#completewith next
.goto Un'Goro Crater,44.70,8.10
.use 11107 >>Open |T133653:0|t[A Small Pack] for the following:
.complete 3845,1 
.complete 3845,2 
.complete 3845,3 
step
#completewith next
.goto Un'Goro Crater,44.6,8.2
.subzone 541 >>Travel north toward Marshal's Refuge
step
.goto Un'Goro Crater,44.70,8.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Linken|r
.turnin 3845 >>Turn in It's a Secret to Everybody
.accept 3908 >>Accept It's a Secret to Everybody
.target Linken
step
#completewith next
.destroy 11107 >>Destroy |T133653:0|t[A Small Pack]
.destroy 3108 >>Destroy the |T135427:0|t[Heavy Throwing Daggers]
.destroy 11108 >>Destroy the |T11108:0|t[Faded Photograph]
step
.goto Un'Goro Crater,43.16,6.24,30,0
.goto Un'Goro Crater,41.90,2.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_J.D. Collie|r
.accept 4284 >>Accept Crystals of Power
.turnin 4284 >>Turn in Crystals of Power
.target J.D. Collie
step
.goto Un'Goro Crater,43.16,6.24,30,0
.goto Un'Goro Crater,45.23,5.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tExit the cave, then talk to |cRXP_FRIENDLY_Gryfe|r
.fp Marshal >>Get the Un'Goro Crater Flight Path
.fly Camp Mojache >>Fly to Camp Mojache
.target Gryfe
step
.goto Feralas,74.42,43.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uzer'i|r
.turnin 3128 >>Turn in Natural Materials
.turnin 3127 >>Turn in Mountain Giant Muisek
.accept 3129 >>Accept Weapons of Spirit
.target Witch Doctor Uzer'i
step
.goto Feralas,74.43,42.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jangdor|r
.turnin 7734 >>Turn in Improved Quality
.target Jangdor Swiftstrider
step
.goto Feralas,74.43,42.91
.use 18972 >>Use the |T134362:0|t[|cFF00BCD4Perfect Yeti Hide|r] to accept the quest
.accept 7738 >>Accept Perfect Yeti Hide
.itemcount 18972,1
step
.goto Feralas,74.43,42.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jangdor|r
.turnin 7738 >>Turn in Perfect Yeti Hide
.target Jangdor Swiftstrider
.isOnQuest 7738
step
.goto Feralas,76.18,43.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Talo|r
.turnin 3063 >>Turn in Vengeance on the Northspring
.accept 4120 >>Accept The Strength of Corruption
.turnin 3062 >>Turn in Dark Heart
.target Talo Thornhoof
.isQuestComplete 3062
.group
step
.goto Feralas,76.18,43.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Talo|r
.turnin 3063 >>Turn in Vengeance on the Northspring
.accept 4120 >>Accept The Strength of Corruption
.target Talo Thornhoof
step
.goto Feralas,74.42,43.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uzer'i|r
.turnin 3129 >>Turn in Weapons of Spirit
.target Witch Doctor Uzer'i
step
.goto Feralas,76.06,43.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bronk|r
.vendor >> |cRXP_BUY_Buy|r |T134833:0|t[Superior Healing Potions] |cRXP_BUY_from him if they're up|r
.target Bronk
step << Druid
.goto Feralas,76.0,42.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jannos|r
.train 9884 >>Train your class spells
.target Jannos Lighthoof
.xp <50,1
.xp >52,1
step << Druid
.goto Feralas,76.0,42.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jannos|r
.train 9894 >>Train your class spells
.target Jannos Lighthoof
.xp <52,1
step << Shaman
.goto Feralas,75.45,44.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Shyn|r
.fly Orgrimmar >>Fly to Orgrimmar
.target Shyn
step << Shaman
.goto Orgrimmar,38.66,35.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sagorne|r
.accept 8410 >>Accept Elemental Mastery
.target Sagorne Creststrider
step << Shaman
.goto Orgrimmar,45.13,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Ratchet >>Fly to Ratchet
.target Doras
step << !Shaman
.goto Feralas,75.45,44.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Shyn|r
.fly Ratchet >>Fly to Ratchet
.target Shyn
step
.abandon 3062 >> Abandon Dark Heart
.isOnQuest 3062
step
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 51-52 Stranglethorn/Blasted Lands
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 50-60
#next 52-53 Searing Gorge/Burning Steppes
step
.goto The Barrens,62.50,38.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Liv|r
.accept 4502 >>Accept Volcanic Activity
.target Liv Rizzlefix
step
.goto The Barrens,62.50,38.60
>>Loot |cRXP_PICK_Marvon's Chest|r outside of the building for the |cRXP_LOOT_Stone Circle|r
.complete 3444,1 
step
.goto The Barrens,62.05,39.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wiley|r
.home >>Set your Hearthstone to Ratchet
.target Innkeeper Wiley
step
.goto The Barrens,63.74,38.66
.zone Stranglethorn Vale >>Take the boat to Stranglethorn Vale
.zoneskip Stranglethorn Vale
step
.goto Stranglethorn Vale,23.60,72.00
>>Kill |cRXP_ENEMY_Mok'rash|r. Loot him for |T133694:0|t[|cFF00BCD4Monogrammed Sash|r]. Use it to start the quest
.collect 3985,1,8552 
.accept 8552 >>Accept The Monogrammed Sash
.use 3985
.group 4
step
.goto Stranglethorn Vale,28.40,76.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oglethorpe|r
.turnin 648 >>Turn in Rescue OOX-17/TN!
.target Oglethorpe Obnoticus
.isQuestComplete 648
step
.goto Stranglethorn Vale,28.40,76.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oglethorpe|r
.turnin 836 >>Turn in Rescue OOX-09/HL!
.target Oglethorpe Obnoticus
.isQuestComplete 836
step
.goto Stranglethorn Vale,28.40,76.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oglethorpe|r
.turnin 2767 >>Turn in Rescue OOX-22/FE!
.target Oglethorpe Obnoticus
.isQuestComplete 2767
step
.goto Stranglethorn Vale,28.40,76.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oglethorpe|r
.accept 3721 >>Accept An OOX of Your Own
.turnin 3721 >>Turn in An OOX of Your Own
.target Oglethorpe Obnoticus
.isQuestTurnedIn 648
.isQuestTurnedIn 836
.isQuestTurnedIn 2767
step
.goto Stranglethorn Vale,26.70,73.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Smotts|r
.turnin 8552 >>Turn in The Monogrammed Sash
.target Captain Hecklebury Smotts
.isOnQuest 8552
.group
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Smotts|r and |cRXP_FRIENDLY_Sprogger|r
.accept 615 >>Accept The Captain's Cutlass
.goto Stranglethorn Vale,26.69,73.62
.turnin 615 >>Turn in The Captain's Cutlass
.goto Stranglethorn Vale,26.66,73.64
.target Captain Hecklebury Smotts
.target Sprogger
.group
step
#ah
.goto Stranglethorn Vale,26.70,73.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sprogger|r
.accept 8554 >>Accept Facing Negolash
.target Sprogger
.group
step
#completewith next
.goto Stranglethorn Vale,26.55,76.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Viznik|r
.bankwithdraw 4306,15 >> Withdraw 15 |T132905:0|t[Silk Cloth] from your bank
.target Viznik
step
.goto Stranglethorn Vale,27.70,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_"Sea Wolf"|r
.turnin 2874 >>Turn in Deliver to MacKinley
.target "Sea Wolf" MacKinley
step
.goto Stranglethorn Vale,27.10,77.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Whiskey Slim|r
.turnin 580 >>Turn in Whiskey Slim's Lost Grog
.target Whiskey Slim
step
.goto Stranglethorn Vale,27.10,77.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crank|r
.turnin 1122 >>Turn in Report Back to Fizzlebub
.target Crank Fizzlebub
step
#ah
.goto Stranglethorn Vale,27.04,77.17,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nixxrax|r
>>|cRXP_WARN_If you don't have|r |T133974:0|t[Barbecued Buzzard Wings] |cRXP_WARN_from earlier (and none of your group members do either), then skip this step|r
.vendor >>Buy |cRXP_BUY_Junglevine Wine|r from |cRXP_FRIENDLY_Nixxrax|r
.collect 4457,10 
.collect 4595,5 
.target Nixxrax Fillamug
.group
step
#completewith next
.goto Stranglethorn Vale,29.83,72.25,50,0
.goto Stranglethorn Vale,33.66,75.05,50,0
.subzone 43 >>Travel north out of Booty Bay, then east to the beach
.group
step
#ah
.goto Stranglethorn Vale,32.5,81.90
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Ruined Lifeboat|r
.accept 619 >>Accept Facing Negolash
.turnin 619 >>Turn in Facing Negolash
.group
step
#ah
.goto Stranglethorn Vale,32.50,81.94
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Ruined Lifeboat|r to summon |cRXP_ENEMY_Negolash|r. Kill him and loot him for |cRXP_LOOT_Smotts' Cutlass|r
>>|cRXP_WARN_If you don't have|r |T133974:0|t[Barbecued Buzzard Wings] |cRXP_WARN_from earlier (and none of your group members do either), then skip this step.|r
.collect 4457,10 
.collect 4595,5 
.complete 8554,1 
.unitscan Negolash
.group 4
step
.goto Stranglethorn Vale,34.22,73.25,60,0
.goto Stranglethorn Vale,34.01,77.21,60,0
.goto Stranglethorn Vale,32.34,79.44,60,0
.goto Stranglethorn Vale,32.38,82.23,60,0
>>Loot the |cRXP_PICK_Half-Burried Bottles|r along the southeastern coast
.collect 4098,1,594
.accept 594 >> Accept Message in a Bottle
step
.goto Stranglethorn Vale,38.53,80.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Princess Poobah|r
.turnin 594 >>Turn in Message in a Bottle
.accept 630 >>Accept Message in a Bottle
.target Princess Poobah
.group
step
.goto Stranglethorn Vale,40.94,83.89
>>Kill |cRXP_ENEMY_King Mukla|r. Loot him for his |cRXP_LOOT_Key|r
>>|cRXP_WARN_Clear a bit of space around|r |cRXP_ENEMY_King Mukla|r|cRXP_WARN_, as he has a fear|r
.complete 630,1 
.unitscan King Mukla
.group 4
step
.goto Stranglethorn Vale,38.53,80.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Princess Poobah|r
.turnin 630 >>Turn in Message in a Bottle
.target Princess Poobah
.group
step
#ah
.goto Stranglethorn Vale,26.70,73.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sprogger|r
.turnin 8554 >>Turn in Facing Negolas
.target Sprogger
.group
step << Shaman
.goto Stranglethorn Vale,26.55,76.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Viznik|r
.bankwithdraw 7069,7068,7067,7070 >>Withdraw the following items from your bank:
+|T135805:0|t[Elemental Fire]
+|T134714:0|t[Elemental Water]
+|T134572:0|t[Elemental Earth]
+|T136107:0|t[Elemental Air]
.target Viznik
step << Rogue
.goto Stranglethorn Vale,26.82,77.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ian|r on the second floor of the inn
.train 8643 >> Train your class spells
.target Ian Strom
.xp <50,1
.xp >52,1
step << Rogue
.goto Stranglethorn Vale,26.82,77.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ian|r on the second floor of the inn
.train 11342 >> Train your class spells
.target Ian Strom
.xp <52,1
step
.goto Stranglethorn Vale,26.87,77.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gringer|r
.fly Stonard>>Fly to Stonard
.target Gringer
step
.goto Swamp of Sorrows,47.90,55.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fel'zerul|r
.turnin 1444 >>Turn in Return to Fel'Zerul
.target Fel'zerul
step << Hunter
.goto Swamp of Sorrows,47.27,53.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ogrom|r
.train 13554 >> Train your class spells
.target Ogrom
.xp <50,1
.xp >52,1
step << Hunter
.goto Swamp of Sorrows,47.27,53.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ogrom|r
.train 13543 >> Train your class spells
.target Ogrom
.xp <52,1
step << Warlock
.goto Swamp of Sorrows,48.64,55.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kartosh|r
.train 17925 >> Train your class spells
.target Kartosh
.xp <50,1
.xp >52,1
step << Warlock
.goto Swamp of Sorrows,48.64,55.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kartosh|r
.train 11675 >> Train your class spells
.target Kartosh
.xp <52,1
step << Warlock
.goto Swamp of Sorrows,48.59,55.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greshka|r
.vendor >>Buy any pet upgrades you can afford
.target Greshka
step << Shaman
.goto Swamp of Sorrows,48.19,57.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greshka|r
.train 10437 >> Train your class spells
.target Haromm
.xp <50,1
.xp >52,1
step << Shaman
.goto Swamp of Sorrows,48.19,57.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greshka|r
.train 10467 >> Train your class spells
.target Haromm
.xp <52,1
step << Warrior
.goto Swamp of Sorrows,44.89,57.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malosh|r
.train 1719 >> Train your class spells
.target Malosh
.xp <50,1
.xp >52,1
step << Warrior
.goto Swamp of Sorrows,44.89,57.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malosh|r
.train 11551 >> Train your class spells
.target Malosh
.xp <52,1
step
.goto Swamp of Sorrows,45.78,52.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thultazor|r
.vendor >> |cRXP_BUY_Buy|r |T134833:0|t[Superior Healing Potions] |cRXP_BUY_from him if they're up|r
.target Thultazor
step
.goto Swamp of Sorrows,45.38,56.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rartar|r inside the inn
.vendor >> |cRXP_BUY_Buy|r |T134833:0|t[Superior Healing Potions] |cRXP_BUY_from him if they're up|r
.target Rartar
step << Warrior
.goto Swamp of Sorrows,34.20,66.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r
.accept 8423 >>Accept Warrior Kinship
.target Fallen Hero of the Horde
step << Warrior
.loop 25,Blasted Lands,53.6,37.2,54.6,41.4,55.6,43.2,52.8,41.8,50.2,38.6,48.0,37.6,46.6,40.2,44.6,37.0,44.6,33.8,48.0,34.4,50.8,36.0,53.6,37.2
>>Kill |cRXP_ENEMY_Helboars|r in the Blasted Lands
.complete 8423,1 
.mob Helboar
step << Warrior
.goto Swamp of Sorrows,34.20,66.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r
.turnin 8423 >>Turn in Warrior Kinship
.accept 8424 >>Accept War on the Shadowsworn
.target Fallen Hero of the Horde
step
#completewith LuckyFragment
>>As you're questing, keep an eye out for |T134089:0|t[|cFF00BCD4Imperfect Draenethyst Fragments|r] and a |T134564:0|t[|cFF00BCD4Flawless Draenethyst Sphere|r]
.collect 10593,1,3501,1 
.collect 8244,1,3501,1 
step << Hunter/Rogue
.goto Blasted Lands,48.00,20.13,80,0
.goto Blasted Lands,44.61,24.93,80,0
.goto Blasted Lands,44.72,33.85,80,0
.goto Blasted Lands,50.40,37.51,80,0
.goto Blasted Lands,54.88,44.05,80,0
.goto Blasted Lands,56.54,37.12,80,0
.goto Blasted Lands,62.30,28.86,80,0
.goto Blasted Lands,50.40,37.51
>>Kill |cRXP_ENEMY_Scorpids|r, |cRXP_ENEMY_Vultures|r and |cRXP_ENEMY_Boars|r. Loot them for their |cRXP_LOOT_Pincers|r, |cRXP_LOOT_Gizzards|r and |cRXP_LOOT_Lungs|r
.collect 8393,3,2585,1 
.collect 8396,2,2585,1 
.collect 8392,1,2585,1 
.mob Scorpok Stinger
.mob Black Slayer
.mob Ashmane Boar
step << Hunter/Rogue
.goto Blasted Lands,50.55,14.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drazial|r
.accept 2585 >>Accept The Decisive Striker
.turnin 2585 >>Turn in The Decisive Striker
.target Bloodmage Drazial
step << Druid/Warrior/Shaman
.goto Blasted Lands,48.00,20.13,80,0
.goto Blasted Lands,44.61,24.93,80,0
.goto Blasted Lands,44.72,33.85,80,0
.goto Blasted Lands,50.40,37.51,80,0
.goto Blasted Lands,54.88,44.05,80,0
.goto Blasted Lands,56.54,37.12,80,0
.goto Blasted Lands,62.30,28.86,80,0
.goto Blasted Lands,50.40,37.51
>>Kill |cRXP_ENEMY_Hyenas|r, |cRXP_ENEMY_Boars|r and |cRXP_ENEMY_Scorpids|r. Loot them for their |cRXP_LOOT_Jowls|r, |cRXP_LOOT_Lungs|r and |cRXP_LOOT_Pincers|r
.collect 8391,3,2581,1 
.collect 8392,2,2581,1 
.collect 8393,1,2581,1 
.mob Starving Snickerfang
.mob Snickerfang Hyena
.mob Scorpok Stinger
.mob Ashmane Boar
step << Druid/Warrior/Shaman
.goto Blasted Lands,50.55,14.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drazial|r
.accept 2581 >>Accept Snickerfang Jowls
.turnin 2581 >>Turn in Snickerfang Jowls
.target Bloodmage Drazial
step << Hunter/Rogue
.goto Blasted Lands,48.00,20.13,80,0
.goto Blasted Lands,44.61,24.93,80,0
.goto Blasted Lands,44.72,33.85,80,0
.goto Blasted Lands,50.40,37.51,80,0
.goto Blasted Lands,54.88,44.05,80,0
.goto Blasted Lands,56.54,37.12,80,0
.goto Blasted Lands,62.30,28.86,80,0
.goto Blasted Lands,50.40,37.51
>>Kill |cRXP_ENEMY_Hyenas|r, |cRXP_ENEMY_Boars|r, |cRXP_ENEMY_Scorpids|r, |cRXP_ENEMY_Vultures|r and |cRXP_ENEMY_Basilisks|r. Loot them for the following:
.collect 8391,5 
.collect 8392,5 
.collect 8393,3 
.collect 8396,12 
.collect 8394,11 
.mob Starving Snickerfang
.mob Snickerfang Hyena
.mob Ashmane Boar
.mob Scorpok Stinger
.mob Black Slayer
.mob Redstone Basilisk
.mob Redstone Crystalhide
step << Druid/Warrior/Shaman
.goto Blasted Lands,48.00,20.13,80,0
.goto Blasted Lands,44.61,24.93,80,0
.goto Blasted Lands,44.72,33.85,80,0
.goto Blasted Lands,50.40,37.51,80,0
.goto Blasted Lands,54.88,44.05,80,0
.goto Blasted Lands,56.54,37.12,80,0
.goto Blasted Lands,62.30,28.86,80,0
.goto Blasted Lands,50.40,37.51
>>Kill |cRXP_ENEMY_Hyenas|r, |cRXP_ENEMY_Boars|r, |cRXP_ENEMY_Scorpids|r, |cRXP_ENEMY_Vultures|r and |cRXP_ENEMY_Basilisks|r. Loot them for the following:
.collect 8391,2 
.collect 8392,4 
.collect 8393,5 
.collect 8396,14 
.collect 8394,11 
.mob Starving Snickerfang
.mob Snickerfang Hyena
.mob Ashmane Boar
.mob Scorpok Stinger
.mob Black Slayer
.mob Redstone Basilisk
.mob Redstone Crystalhide
step << !Hunter !Rogue !Druid !Warrior !Shaman
.goto Blasted Lands,48.00,20.13,80,0
.goto Blasted Lands,44.61,24.93,80,0
.goto Blasted Lands,44.72,33.85,80,0
.goto Blasted Lands,50.40,37.51,80,0
.goto Blasted Lands,54.88,44.05,80,0
.goto Blasted Lands,56.54,37.12,80,0
.goto Blasted Lands,62.30,28.86,80,0
.goto Blasted Lands,50.40,37.51
>>Kill |cRXP_ENEMY_Hyenas|r, |cRXP_ENEMY_Boars|r, |cRXP_ENEMY_Scorpids|r, |cRXP_ENEMY_Vultures|r and |cRXP_ENEMY_Basilisks|r. Loot them for the following:
.collect 8391,5 
.collect 8392,6 
.collect 8393,6 
.collect 8396,14 
.collect 8394,11 
.mob Starving Snickerfang
.mob Snickerfang Hyena
.mob Ashmane Boar
.mob Scorpok Stinger
.mob Black Slayer
.mob Redstone Basilisk
.mob Redstone Crystalhide
step
#label LuckyFragment
.goto Blasted Lands,51.8,35.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kum'isha|r
.accept 3501 >>Accept Everything Counts In Large Amounts
.turnin 3501 >>Turn in Everything Counts In Large Amounts
.target Kum'isha the Collector
.itemcount 10593,1
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drazial|r and |cRXP_FRIENDLY_Lynnore|r
.accept 2585 >>Accept The Decisive Striker << !Rogue !Hunter
.turnin 2585 >>Turn in The Decisive Striker << !Rogue !Hunter
.accept 2583 >>Accept A Boar's Vitality
.turnin 2583 >>Turn in A Boar's Vitality
.accept 2581 >>Accept Snickerfang Jowls << !Druid !Warrior !Shaman
.turnin 2581 >>Turn in Snickerfang Jowls << !Druid !Warrior !Shaman
.goto Blasted Lands,50.55,14.21
.accept 2601 >>Accept The Basilisk's Bite
.turnin 2601 >>Turn in The Basilisk's Bite
.accept 2603 >>Accept Vulture's Vigor
.turnin 2603 >>Turn in Vulture's Vigor
.goto Blasted Lands,50.64,14.30
.target Bloodmage Drazial
.target Bloodmage Lynnore
step << Warrior
.loop 25,Blasted Lands,62.4,39.4,62.4,43.0,64.6,47.8,64.0,45.6,63.6,42.6,63.6,39.2,62.4,39.4
.loop 25,Blasted Lands,65.02,32.94,64.15,30.73,63.79,34.18,65.85,34.46,65.02,32.94,65.85,31.97,66.29,30.40,67.39,31.77,68.32,31.21,67.61,29.06,68.32,31.21,67.39,31.77,66.29,30.40,65.85,31.97,65.02,32.94
.complete 8424,1 
.complete 8424,2 
.complete 8424,3 
>>|CRXP_WARN_If you go into the cave, be careful of the two elites at each end|r
step << Warrior
.goto Swamp of Sorrows,34.20,66.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r
.turnin 8424 >>Turn in War on the Shadowsworn
.target Fallen Hero of the Horde
step
#completewith next
.subzone 75 >> Travel to Stonard
.subzoneskip 75
step
.goto Swamp of Sorrows,45.78,52.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thultazor|r
.vendor >> |cRXP_BUY_Buy|r |T134833:0|t[Superior Healing Potions] |cRXP_BUY_from him if they're up|r
.target Thultazor
step
.goto Swamp of Sorrows,45.38,56.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rartar|r inside the inn
.vendor >> |cRXP_BUY_Buy|r |T134833:0|t[Superior Healing Potions] |cRXP_BUY_from him if they're up|r
.target Rartar
step
.goto Swamp of Sorrows,46.10,54.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Breyk|r
.fly Badlands>>Fly to Badlands
.target Breyk
step
.abandon 8554 >> Abandon Facing Negolash
.isOnQuest 8554
step
.abandon 630 >> Abandon Message in a Bottle
.isOnQuest 630
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 52-53 Searing Gorge/Burning Steppes
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 50-60
#next 53-54 Azshara
step
.goto Badlands,2.80,45.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gorn|r
.accept 793 >>Accept Broken Alliances
.target Gorn
.group
step
#completewith next
.goto Badlands,79.97,36.57,50,0
.subzone 339 >>Travel east to the Lethlor Ravine
.isOnQuest 793
.group
step
.goto Badlands,72.30,66.80
>>Loot the |cRXP_PICK_Pillar of Opal|r for the |cRXP_LOOT_Opal Runestone|r
.collect 4844,1 
.isOnQuest 793
.group 4
step
.goto Badlands,81.30,64.20
>>Loot the |cRXP_PICK_Pillar of Amethyst|r for the |cRXP_LOOT_Amethyst Runestone|r
.collect 4843,1 
.isOnQuest 793
.group 4
step
.goto Badlands,83.50,32.90
>>Loot the |cRXP_PICK_Pillar of Diamond|r for the |cRXP_LOOT_Diamond Runestone|r
.collect 4845,1 
.isOnQuest 793
.group 4
step
.goto Badlands,81.70,49.90
>>|TInterface/GossipFrame/HealerGossipIcon:0|tAfter collecting the 3 runestones, click the |cRXP_PICK_Seal of the Earth|r to summon |cRXP_ENEMY_Blacklash|r and |cRXP_ENEMY_Hematus|r
.accept 795 >>Accept Seal of the Earth
.turnin 795 >>Turn in Seal of the Earth
.isOnQuest 793
.group
step
.goto Badlands,81.70,49.90
>>Kill |cRXP_ENEMY_Blacklash|r and |cRXP_ENEMY_Hematus|r. Loot them for their |cRXP_LOOT_Bindings|r and |cRXP_LOOT_Chains|r
>>|cRXP_WARN_Simplify this encounter by killing|r |cRXP_ENEMY_Hematus|r |cRXP_WARN_first, as his flame buffet intensifies|r |cRXP_ENEMY_Blacklash's|r |cRXP_WARN_fire breath|r
.complete 793,1 
.complete 793,2 
.mob Blacklash
.mob Hematus
.isOnQuest 793
.group 4
step
>>If you don't have 15 Silk Cloth, collect it from |cRXP_ENEMY_Shadowforge dwarves|r in Angor Fortress or the Hammertoe Dig Site
>>|cRXP_WARN_You will need the cloth for an upcoming quest. Badlands mobs have a substantially higher drop rate than Searing Gorge mobs|r
.collect 4306,15 
.group
step
.goto Badlands,2.80,45.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gorn|r
.turnin 793 >>Turn in Broken Alliances
.target Gorn
.isQuestComplete 793
.group
step
.goto Badlands,3.40,48.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thal'trak|r
>>|cRXP_WARN_You may have to wait for|r |cRXP_FRIENDLY_Thal'trak|r |cRXP_WARN_to finish his RP. Just follow him|r
.accept 3821 >>Accept Dreadmaul Rock
.target Thal'trak Proudtusk
step
#completewith HoardO
>>If you don't have 15 Silk Cloth, collect it from |cRXP_ENEMY_Dustbelcher Ogres|r in the Dustbelch Grotto
>>|cRXP_WARN_You will need the cloth for an upcoming quest. Badlands mobs have a substantially higher drop rate than Searing Gorge mobs|r
.collect 4306,15 
step
.goto Badlands,3.62,61.88,50,0
.goto Searing Gorge,72.34,55.47
.zone Searing Gorge >>Travel to Searing Gorge
step
.goto Searing Gorge,65.55,62.15
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cRXP_PICK_Wooden Outhouse|r
.accept 4449 >>Accept Caught!
step
.goto Searing Gorge,63.43,60.91,20,0
.goto Searing Gorge,69.29,33.39
>>Kill |cRXP_ENEMY_Dark Iron Geologists|r
>>|cRXP_WARN_You may need to travel between the northern camp and the southern digsite to complete this quest|r
.complete 4449,1 
.mob Dark Iron Geologist
step
.goto Searing Gorge,39.10,39.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Velarok|r, then complete his dialogue
.accept 3441 >>Accept Divine Retribution
.complete 3441,1 
.target Velarok Windblade
.skipgossip
step
.goto Searing Gorge,39.05,38.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Velarok|r
.turnin 3441 >>Turn in Divine Retribution
.accept 3442 >>Accept The Flawless Flame
.target Velarok Windblade
step
#completewith next
.goto Searing Gorge,32.50,32.48,30,0
.subzone 1446 >>Travel west up the hill toward Thorium Point
step
.goto Searing Gorge,34.84,30.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grisha|r
.fp Thorium >>Get the Searing Gorge Flight Path
.target Grisha
step
.goto Searing Gorge,38.58,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hansel|r
.accept 7723 >>Accept Curse These Fat Fingers
.accept 7724 >>Accept Fiery Menace!
.accept 7727 >>Accept Incendosaurs? Whateverosaur is More Like It
.target Hansel Heavyhands
step
.goto Searing Gorge,37.64,26.47
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cRXP_PICK_Wanted/Missing/Lost & Found|r board
.accept 7728 >>Accept STOLEN: Smithing Tuyere and Lookout's Spyglass
.accept 7729 >>Accept JOB OPPORTUNITY: Culling the Competition
step
#completewith Spiders
>>Kill |cRXP_ENEMY_War Golems|r and |cRXP_ENEMY_Elementals|r. Loot them for their |cRXP_LOOT_Heart of Flame|r and |cRXP_LOOT_Golem Oil|r
>>|cRXP_WARN_Kill any|r |cRXP_ENEMY_Magma Elementals|r |cRXP_WARN_that you see. They can drop both quest items|r
.complete 3442,1 
.complete 3442,2 
.mob Heavy War Golem
.mob Tempered War Golem
.mob Inferno Elemental
.mob Blazing Elemental
.unitscan Magma Elemental
step
#completewith Elementals
.goto Searing Gorge,32.6,55.0,40,0
.goto Searing Gorge,36.2,61.6,40,0
.goto Searing Gorge,44.6,62.6,40,0
.goto Searing Gorge,52.4,57.8,40,0
.goto Searing Gorge,51.4,55.8,40,0
>>Kill |cRXP_ENEMY_Dark Iron Lookouts|r. Loot them for a |cRXP_LOOT_Lookout's Spyglass|r
.complete 7728,2 
.mob Dark Iron Lookout
step
#completewith Elementals
.goto Searing Gorge,38.0,49.8,40,0
.goto Searing Gorge,40.8,49.8,40,0
.goto Searing Gorge,42.8,51.6
>>Kill |cRXP_ENEMY_Dark Iron Steamsmiths|r. Loot them for a |cRXP_LOOT_Smithing Tuyere|r
.complete 7728,1 
.unitscan Dark Iron Steamsmith
step
#label Spiders
.loop 25,Searing Gorge,33.0,39.6,28.8,43.8,27.6,52.0,30.8,59.8,26.6,69.4,22.6,74.0,25.0,76.2,29.6,75.8,30.6,71.8,31.8,66.4,30.8,59.8,27.6,52.0,28.8,43.8,33.0,39.6,
>>Kill |cRXP_ENEMY_Greater Lava Spiders|r along the western/southwestern mountains
.complete 7724,1 
.mob Greater Lava Spider
step
#completewith next
.goto Searing Gorge,43.61,40.78,0
.goto Searing Gorge,32.54,47.19,0
>>Kill |cRXP_ENEMY_Heavy War Golems|r
.complete 7723,1 
.mob Heavy War Golem
step
#label Elementals
.loop 25,Searing Gorge,44.0,38.2,46.6,37.8,47.0,41.4,43.6,44.6,40.6,44.8,36.8,47.6,33.2,52.2,34.0,59.6,36.6,62.8,32.6,70.6,30.6,64.6,28.4,64.0,25.6,53.6,32.4,53.6,33.8,47.4,35.6,41.2,37.6,44.6,40.6,42.8,44.0,38.2
>>Finish killing |cRXP_ENEMY_War Golems|r and |cRXP_ENEMY_Elementals|r. Loot them for their |cRXP_LOOT_Heart of Flame|r and |cRXP_LOOT_Golem Oil|r
>>|cRXP_WARN_Kill any|r |cRXP_ENEMY_Magma Elementals|r |cRXP_WARN_that you see. They can drop both quest items|r
.complete 3442,1 
.complete 3442,2 
.mob Heavy War Golem
.mob Tempered War Golem
.mob Inferno Elemental
.mob Blazing Elemental
.unitscan Magma Elemental
step
#label WarGolems
.goto Searing Gorge,35.16,45.78,70,0
.goto Searing Gorge,40.40,44.42,70,0
.goto Searing Gorge,45.72,41.98,70,0
.goto Searing Gorge,50.66,39.23,70,0
.goto Searing Gorge,35.16,45.78,70,0
.goto Searing Gorge,40.40,44.42,70,0
.goto Searing Gorge,45.72,41.98
>>Kill |cRXP_ENEMY_Heavy War Golems|r
.complete 7723,1 
.mob Heavy War Golem
step
.goto Searing Gorge,39.05,38.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Velarok|r
.turnin 3442 >>Turn in The Flawless Flame
.accept 3443 >>Accept Forging the Shaft
.target Velarok Windblade
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hansel|r
.turnin 7724 >>Turn in Fiery Menace!
.turnin 7723 >>Turn in Curse These Fat Fingers
.goto Searing Gorge,38.58,27.80
.target Hansel Heavyhands
step
.goto Searing Gorge,37.64,26.47
.accept 7701 >>Accept WANTED: Overseer Maltorius
.group
step
.goto Searing Gorge,38.58,27.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Burninate|r
.accept 7722 >>Accept What the Flux?
.target Master Smith Burninate
.group
step
.goto Searing Gorge,47.54,46.89,30 >>Jump down to the platform, and go inside the cave
step
.goto Searing Gorge,51.49,36.55,40,0
.loop 25,Searing Gorge,51.36,32.24,50.35,24.24,46.76,20.91,44.04,25.41,48.64,27.42,49.68,31.63,51.36,32.24
>>Descend to the cave's lower level, then kill |cRXP_ENEMY_Incendosaurs|r
.complete 7727,1 
.mob Incendosaur
step
#completewith Shanksinnit
.goto Searing Gorge,48.41,41.08,40,0
.goto Searing Gorge,47.94,47.58,40,0
.goto Searing Gorge,49.86,45.97,40,0
.goto Searing Gorge,49.75,45.82,35 >>Exit the cave, then follow the platform up and re-enter the cave on its higher level
step
#completewith Shanksinnit
>>Kill |cRXP_ENEMY_Dark Iron Taskmasters|r and |cRXP_ENEMY_Dark Iron Slavers|r
.complete 7729,1 
.complete 7729,2 
.mob Dark Iron Taskmaster
.mob Dark Iron Slaver
step
.goto Searing Gorge,40.45,35.75
>>Exit the cave again and re-enter through its right side
>>Kill |cRXP_ENEMY_Overseer Maltorius|r. Loot him for his |cRXP_LOOT_Head|r and loot the |cRXP_PICK_Secret Plans: Fiery Flux|r
>>|cRXP_WARN_This is a challenging fight. Make a path for kiting or escape by clearing the entire room before getting the plans|r
.complete 7722,1 
.complete 7701,1 
.unitscan Overseer Maltorius
.isOnQuest 7701
.group 3
step
#label Shanksinnit
.loop 25,Searing Gorge,46.36,53.91,42.75,54.91,41.35,53.44,37.97,49.17,39.32,44.55,37.97,49.17,35.85,42.12,38.16,38.35,39.24,32.84,41.60,26.95,43.59,22.85,43.46,28.38,46.04,25.49,45.47,30.46,43.13,32.50,43.41,35.64,48.27,43.38,49.88,46.10,48.28,50.79,46.36,53.91
>>Kill all |cRXP_ENEMY_Dark Iron Dwarves|r and |cRXP_ENEMY_Slave Workers|r. Loot them for their |cRXP_LOOT_Daggers|r
.complete 3443,1 
.mob Dark Iron Steamsmith
.mob Dark Iron Lookout
.mob Dark Iron Slaver
.mob Dark Iron Taskmaster
.mob Dark Iron Geologist
.mob Dark Iron Watchman
.mob Dark Iron Steelshifter
.mob Dark Iron Kidnapper
step
.loop 25,Searing Gorge,46.36,53.91,42.75,54.91,41.35,53.44,37.97,49.17,39.32,44.55,37.97,49.17,35.85,42.12,38.16,38.35,39.24,32.84,41.60,26.95,43.59,22.85,43.46,28.38,46.04,25.49,45.47,30.46,43.13,32.50,43.41,35.64,48.27,43.38,49.88,46.10,48.28,50.79,46.36,53.91
>>Keep killing |cRXP_ENEMY_Dark Iron Dwarves|r until you loot the |T134246:0|t[|cFF00BCD4Grimesilt Outhouse Key|r]
>>|cRXP_WARN_Do not accept the quest yet! This may cause questlog issues|r
.collect 11818,1,4451 
.mob Dark Iron Steamsmith
.mob Dark Iron Lookout
.mob Dark Iron Slaver
.mob Dark Iron Taskmaster
.mob Dark Iron Geologist
.mob Dark Iron Watchman
.mob Dark Iron Steelshifter
.mob Dark Iron Kidnapper
step
#completewith next
.goto Searing Gorge,35.45,23.51,50 >>Logout skip out of the cave. There are MANY different spots you can use
.link https://www.youtube.com/watch?v=-mcsjDkeSUw >> Click HERE for reference
step
.goto Searing Gorge,39.05,38.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Velarok|r
.turnin 3443 >>Turn in Forging the Shaft
.accept 3452 >>Accept The Flame's Casing
.target Velarok Windblade
.group
step
.goto Searing Gorge,39.05,38.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Velarok|r
.turnin 3443 >>Turn in Forging the Shaft
.target Velarok Windblade
step
.goto Searing Gorge,26.56,35.03,70,0
.loop 25,Searing Gorge,24.56,39.25,22.50,39.77,22.18,36.45,24.52,34.62,25.02,31.00,25.74,29.39,22.33,26.85,25.73,25.38,27.43,24.93,25.74,29.39,25.02,31.00,24.52,34.62,24.56,39.25
>>Kill |cRXP_ENEMY_Twilight mobs|r. Loot them for the |cRXP_LOOT_Symbol of Ragnaros|r
.complete 3452,1 
.mob Twilight Dark Shaman
.mob Twilight Fire Guard
.mob Twilight Geomancer
.mob Twilight Idolater
.isOnQuest 3452
.group 3
step

.goto Searing Gorge,39.05,38.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Velarok|r
.turnin 3452 >>Turn in The Flame's Casing
.target Velarok Windblade
.isQuestComplete 3542
.group
step
.goto Searing Gorge,39.05,38.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Velarok|r, then wait for his RP
.accept 3453 >>Accept The Torch of Retribution
.turnin 3453 >>Turn in The Torch of Retribution
.accept 3454 >>Accept The Torch of Retribution
.target Velarok Windblade
.isQuestTurnedIn 3452
.group
step
.goto Searing Gorge,39.04,39.24
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the Torch of Retribution
.turnin 3454 >>Turn in The Torch of Retribution
.isQuestTurnedIn 3452
.group
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Velarok|r and |cRXP_FRIENDLY_Maltrake|r
.accept 3462 >>Accept Squire Maltrake
.goto Searing Gorge,39.06,38.99
.turnin 3462 >>Turn in Squire Maltrake
.accept 3463 >>Accept Set Them Ablaze!
.goto Searing Gorge,39.17,39.00
.target Velarok Windblade
.target Squire Maltrake
.isQuestTurnedIn 3452
.group
step
#completewith OuthouseAndy
.goto Searing Gorge,34.08,53.99,0
>>Kill |cRXP_ENEMY_Dark Iron Lookouts|r. Loot them for the |cRXP_LOOT_Lookout's Spyglass|r
.complete 7728,2 
.mob Dark Iron Lookout
step
#completewith WarGolems
.goto Searing Gorge,40.90,50.31,0
>>Kill |cRXP_ENEMY_Dark Iron Steamsmiths|r. Loot them for the |cRXP_LOOT_Smithing Tuyere|r
.complete 7728,1 
.unitscan Dark Iron Steamsmith
step
#completewith next
.goto Searing Gorge,43.61,40.78,0
.goto Searing Gorge,32.54,47.19,0
>>Kill |cRXP_ENEMY_Heavy War Golems|r
.complete 7723,1 
.mob Heavy War Golem
step
.goto Searing Gorge,33.30,54.47
.use 10515 >>Equip the |T135466:0|t[Torch of Retribution], then climb the tower and click the |cRXP_PICK_Sentry Brazier|r
.complete 3463,4 
.unitscan Dark Iron Sentry
.isQuestTurnedIn 3452
.group
step
#label WarGolems
.goto Searing Gorge,35.16,45.78,70,0
.goto Searing Gorge,40.40,44.42,70,0
.goto Searing Gorge,45.72,41.98,70,0
.goto Searing Gorge,50.66,39.23,70,0
.goto Searing Gorge,35.16,45.78,70,0
.goto Searing Gorge,40.40,44.42,70,0
.goto Searing Gorge,45.72,41.98
>>Kill |cRXP_ENEMY_Heavy War Golems|r
.complete 7723,1 
.mob Heavy War Golem
step
.goto Searing Gorge,42.91,51.73,50,0
.goto Searing Gorge,40.43,49.37,50,0
.goto Searing Gorge,37.81,49.66,50,0
.goto Searing Gorge,40.43,49.37
>>Kill |cRXP_ENEMY_Dark Iron Steamsmiths|r. Loot them for the |cRXP_LOOT_Smithing Tuyere|r
.complete 7728,1 
.unitscan Dark Iron Steamsmith
step
.goto Searing Gorge,35.66,60.68
.use 10515 >>Equip the |T135466:0|t[Torch of Retribution], then climb the tower and click the |cRXP_PICK_Sentry Brazier|r
.complete 3463,1 
.unitscan Dark Iron Sentry
.isQuestTurnedIn 3452
.group
step
.goto Searing Gorge,44.03,60.90
.use 10515 >>Equip the |T135466:0|t[Torch of Retribution], then climb the tower and click the |cRXP_PICK_Sentry Brazier|r
.complete 3463,2 
.unitscan Dark Iron Sentry
.isQuestTurnedIn 3452
.group
step
#label OuthouseAndy
.goto Searing Gorge,65.59,62.17
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cRXP_PICK_Wooden Outhouse|r
.turnin 4449 >>Turn in Caught!
step
.goto Searing Gorge,65.59,62.17
>>Use the |T134246:0|t[|cFF00BCD4Grimesilt Outhouse Key|r] to accept the quest
.collect 11818,1,4451 
.accept 4451 >>Accept The Key to Freedom
.use 11818
step
.goto Searing Gorge,65.59,62.17
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cRXP_PICK_Wooden Outhouse|r
.turnin 4451 >>Turn in The Key to Freedom
step
#label OuthouseAndy
.goto Searing Gorge,50.10,54.70
.use 10515 >>Equip the |T135466:0|t[Torch of Retribution], then climb the tower and click the |cRXP_PICK_Sentry Brazier|r
.complete 3463,3 
.unitscan Dark Iron Sentry
.isQuestTurnedIn 3452
.group
step
.goto Searing Gorge,34.08,53.99
>>Kill |cRXP_ENEMY_Dark Iron Lookouts|r. Loot them for the |cRXP_LOOT_Lookout's Spyglass|r
.complete 7728,2 
.mob Dark Iron Lookout
step
.loop 25,Searing Gorge,46.36,53.91,42.75,54.91,41.35,53.44,37.97,49.17,39.32,44.55,37.97,49.17,35.85,42.12,38.16,38.35,39.24,32.84,41.60,26.95,43.59,22.85,43.46,28.38,46.04,25.49,45.47,30.46,43.13,32.50,43.41,35.64,48.27,43.38,49.88,46.10,48.28,50.79,46.36,53.91
>>Kill |cRXP_ENEMY_Dark Iron Taskmasters|r and |cRXP_ENEMY_Dark Iron Slavers|r
.complete 7729,1 
.complete 7729,2 
.mob Dark Iron Taskmaster
.mob Dark Iron Slaver
step
#completewith next
.goto Searing Gorge,39.05,38.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maltrake|r
.turnin 3463 >>Turn in Set Them Ablaze!
.target Squire Maltrake
.isQuestTurnedIn 3452
.group
step
.goto Searing Gorge,38.85,38.99
>>|TInterface/GossipFrame/HealerGossipIcon:0|tOpen the chest on the ground twice, then open the |cRXP_PICK_Hoard of the Black Dragonflight|r and loot the |cRXP_LOOT_Black Dragonflight Molt|r
.accept 3481 >>Accept Trinkets...
.turnin 3481 >>Turn in Trinkets...
.isQuestTurnedIn 3452
.group
step
.goto Searing Gorge,37.60,26.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lolo|r
.turnin 7701 >>Turn in WANTED: Overseer Maltorius
.target Lookout Captain Lolo Longstriker
.isQuestComplete 7701
.group
step
#completewith next
.goto Searing Gorge,32.50,32.48,30,0
.subzone 1446 >>Travel to Thorium Point
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hansel|r and |cRXP_FRIENDLY_Scrange|r
.turnin 7723 >>Turn in Curse These Fat Fingers
.turnin 7724 >>Turn in Fiery Menace!
.turnin 7727 >>Turn in Incendosaurs? Whateverosaur is More Like It
.goto Searing Gorge,38.58,27.80
.turnin 7728 >>Turn in STOLEN: Smithing Tuyere and Lookout's Spyglass
.goto Searing Gorge,38.98,27.50
.target Hansel Heavyhands
.target Taskmaster Scrange
step
.goto Searing Gorge,38.80,28.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Burninate|r
.turnin 7722 >>Turn in What the Flux?
.target Master Smith Burninate
.isQuestComplete 7722
.group
step
.goto Searing Gorge,38.80,28.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scrange|r
.turnin 7729 >>Turn in JOB OPPORTUNITY: Culling the Competition
.target Taskmaster Scrange
.isQuestComplete 7729
step
#completewith next
.goto Searing Gorge,69.2,71.6,50,0
.goto Searing Gorge,73.2,76.0,50,0
.goto Searing Gorge,73.61,82.93
+Run down to southeast Searing Gorge where |cRXP_ENEMY_Margol the Rager|r is found. Wait for him to patrol all the way out of his cave, then logout skip from the mushrooms at the back << Druid/Shaman
>>Be careful as |cRXP_ENEMY_Margol|r is IMMUNE to nature spells << Shaman/Druid
+Run down to southeast Searing Gorge where Margol the Rager is found. Wait for him to patrol all the way out of his cave (or kill him), then logout skip from the mushrooms at the back << !Druid !Shaman
.link https://www.youtube.com/watch?v=0_g2SY2JKt8 >> Click HERE for reference
step
.goto Burning Steppes,28.43,17.70
.zone Burning Steppes >>Travel to the Burning Steppes using either the Margol Logout Skip or Blackrock Mountain
step
.goto Burning Steppes,65.69,24.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vahgruk|r
.fp Flame Crest >>Get the Burning Steppes Flight Path
.target Vahgruk
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tinkee|r and |cRXP_FRIENDLY_Maxwort|r
.accept 4726 >>Accept Broodling Essence
.goto Burning Steppes,65.24,24.01
.accept 4296 >>Accept Tablet of the Seven
.goto Burning Steppes,65.15,23.94
.target Tinkee Steamboil
.target Maxwort Uberglint
step
#completewith HoardO
.use 12284 >>Use your |T133001:0|t[Draco-Incarcinatrix 900] on |cRXP_ENEMY_Black Broodlings|r, then kill them and loot the |cRXP_LOOT_Broodling Essence|r from the |cRXP_PICK_Red Obelisk|r over their corpses
.complete 4726,1 
.mob Black Broodling
step
.goto Burning Steppes,54.10,40.70
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Stone Placard|r in front of the Dwarf statue to create a |cRXP_LOOT_Tablet Transcript|r
.complete 4296,1 
step
.goto Burning Steppes,77.68,38.23,60,0
.goto Burning Steppes,79.80,45.60
>>|TInterface/GossipFrame/HealerGossipIcon:0|tCross the bridge, then go up the mountain. Click on |cRXP_PICK_Sha'ni Proudtusk's Remains|r atop the altar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sha'ni|r
>>|cRXP_WARN_Be careful of|r |cRXP_ENEMY_Firegut Brutes'|r |cRXP_WARN_knockback, as it can knock you off the mountain|r
.turnin 3821 >>Turn in Dreadmaul Rock
.accept 3822 >>Accept Krom'Grul
.target Sha'ni Proudtusk
step
.goto Burning Steppes,77.20,47.50,25,0
.goto Burning Steppes,82.70,38.90,25,0
.goto Burning Steppes,81.60,48.20
>>Kill |cRXP_ENEMY_Krom'Grul|r. Loot him for |cRXP_LOOT_Sha'ni's Nose-Ring|r
>>|cRXP_WARN_He can spawn in any of three caves; you may have to search. Be careful of|r |cRXP_ENEMY_Firegut Brutes'|r |cRXP_WARN_knockback, as it can knock you off the mountain|r|r
.complete 3822,1 
.target Krom'Grul
step
#label HoardO
.goto Burning Steppes,95.09,31.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cyrus|r
>>|cRXP_WARN_Open your|r |T132595:0|t[Hoard of the Black Dragonflight] |cRXP_WARN_if you haven't yet|r
.accept 4022 >>Accept A Taste of Flame
.turnin 4022 >>Turn in A Taste of Flame
.target Cyrus Therepentous
.isQuestTurnedIn 3452
.group
step
.loop 25,Burning Steppes,81.8,27.8,85.8,30.2,90.6,29.8,92.0,39.4,90.6,49.4,88.8,56.2,85.2,61.4,82.0,61.6,84.6,56.0,89.4,52.6,88.6,44.8,91.6,38.4,89.8,33.6,86.4,32.0,81.8,27.8
.use 12284 >>Use your |T133001:0|t[Draco-Incarcinatrix 900] on |cRXP_ENEMY_Black Broodlings|r. Kill them and loot the |cRXP_LOOT_Broodling Essence|r from the |cRXP_PICK_Red Obelisk|r over their corpses
.complete 4726,1 
.mob Black Broodling
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tinkee|r and |cRXP_FRIENDLY_Maxwort|r
.turnin 4726 >>Turn in Broodling Essence
.accept 4808 >>Accept Felnok Steelspring
.goto Burning Steppes,65.24,24.01
.turnin 4296 >>Turn in Tablet of the Seven
.goto Burning Steppes,65.15,23.94
.target Tinkee Steamboil
.target Maxwort Uberglint
step
.goto Burning Steppes,65.70,24.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vahgruk|r
.fly Badlands >>Fly to Badlands
.target Vahgruk
.zoneskip Badlands
step
#completewith next
.goto Badlands,2.81,45.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shul'kar|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Shul'kar
step
.goto Badlands,3.40,48.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thal'trak|r
>>|cRXP_WARN_You may have to wait for Thal'trak to finish his RP. Just follow him|r
.turnin 3822 >>Turn in Krom'Grul
.target Thal'trak Proudtusk
step << Rogue/Shaman
.goto Badlands,4.00,44.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gorrik|r
.fly Tarren Mill
.target Gorrik
.zoneskip Hillsbrad Foothills
step << Rogue
.goto Hillsbrad Foothills,75.49,23.96,30,0
.goto Hillsbrad Foothills,75.61,19.52,30,0
.goto Hillsbrad Foothills,77.68,22.59,30,0
.goto Hillsbrad Foothills,77.58,19.61,30,0
.goto Alterac Mountains,86.02,78.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorach|r
.accept 8234 >>Accept Sealed Azure Bag
.target Lord Jorach Ravenholdt
step << Shaman
.goto Alterac Mountains,80.50,66.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bath'rah|r
.turnin 8410 >>Turn in Elemental Mastery
.accept 8412 >>Accept Spirit Totem
.target Bath'rah the Windwatcher
step << Shaman

.loop 25,Western Plaguelands,34.6,65.8,33.6,63.2,31.8,63.6,32.0,59.6,30.8,50.2,32.8,56.0,36.0,58.4,34.0,61.8,34.6,65.8
>>Run north into Western Plaguelands, then run west. Be careful of the small Alliance camp. Swim across the water.
>>Kill |cRXP_ENEMY_Venom Mist Lurkers|r, |cRXP_ENEMY_Carrion Vultures|r and |cRXP_ENEMY_Diseased Black Bears|r. Loot them for their |cRXP_LOOT_Eyes|r and |cRXP_LOOT_Claws|r
.complete 8412,1 
.complete 8412,2 
.mob Carrion Vulture
.mob Venom Mist Lurker
.mob Diseased Black Bear
step << Shaman
.goto Alterac Mountains,80.50,66.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bath'rah|r
.turnin 8412 >>Turn in Spirit Totem
.target Bath'rah the Windwatcher
step << Shaman
.goto Alterac Mountains,80.50,66.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bath'rah|r
.accept 8413 >> Accept Da Voodoo
.target Bath'rah the Windwatcher
.isQuestTurnedIn 8412
.dungeon ST
step << Rogue/Shaman
.goto Hillsbrad Foothills,60.14,18.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vahgruk|r
.fly Undercity >>Fly to Undercity
.target Vahgruk
.zoneskip Undercity
step << !Rogue !Shaman
.goto Badlands,4.00,44.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gorrik|r
.fly Undercity >>Fly to Undercity
.target Vahgruk
.zoneskip Undercity
step
.goto Undercity,47.46,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fuely|r
.accept 4293 >>Accept A Sample of Slime...
.accept 4294 >>Accept ... and a Match of Ooze
.target Chemist Fuely
step << Druid
#completewith DruidTraining8
.cast 18960 >>Cast |T135758:0|t[Teleport: Moonglade]
.zoneskip Moonglade
step << Druid
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 9894 >> Train your class spells
.target Loganaar
.xp <52,1
.xp >54,1
step << Druid
#label DruidTraining8
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 9904 >> Train your class spells
.target Loganaar
.xp <54,1
step << !Mage
#completewith next
.hs >>Hearth to Ratchet
.use 6948
step << !Mage
.goto The Barrens,63.08,37.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bragok|r
.fly Orgrimmar >>Fly to Orgrimmar
.target Bragok
.zoneskip Orgrimmar
step << Mage
.cast 3567 >>Cast |T135759:0|t[Teleport: Orgrimmar]
.zoneskip Orgrimmar
step
.abandon 795 >> Abandon Seal of the Earth
.isOnQuest 795
step
.abandon 793 >> Abandon Broken Alliances
.isOnQuest 793
step
.abandon 7701 >> Abandon WANTED: Overseer Maltorius
.isOnQuest 7701
step
.abandon 7722 >> Abandon What the Flux?
.isOnQuest 7722
step
.abandon 3452 >> Abandon The Flame's Casing
.isOnQuest 3452
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 53-54 Azshara
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 50-60
#next 54-54 Felwood
step
.goto Orgrimmar,54.10,68.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Innkeeper Grysha|r
.home >>Set your Hearthstone to Orgrimmar
.target Innkeeper Grysha
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 10467 >> Train your class spells
.target Kardris Dreamseeker
.xp <52,1
.xp >54,1
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 10408 >> Train your class spells
.target Kardris Dreamseeker
.xp <54,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 13543 >>Train your class spells
.target Ormak Grimshot
.xp <52,1
.xp >54,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14290 >>Train your class spells
.target Ormak Grimshot
.xp <54,1
step << Hunter
.goto Orgrimmar,66.33,14.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xao'tsu|r
.train 24631 >>Train your pet spells
.target Xao'tsu
.xp <54,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 11551 >>Train your class spells
.target Grezz Ragefist
.xp <52,1
.xp >54,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 11605 >> Train your class spells
.target Grezz Ragefist
.xp <54,1
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 11342 >> Train your class spells
.target Ormok
.xp <52,1
.xp >54,1
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 11294 >> Train your class spells
.target Ormok
.xp <54,1
step << Rogue
.goto Orgrimmar,42.10,49.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Rekkul|r|cRXP_BUY_. Buy |r |T134387:0|t[Flash Powder] |cRXP_BUY_from him|r
.collect 5140,20,2479,1 
.target Rekkul
step << Warlock
.goto Undercity,48.47,45.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Zevrost|r
.trainer >>Train your class spells
.accept 8419 >>Accept An Imp's Request
.target Zevrost
step << Warlock
.goto Orgrimmar,47.55,46.77
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kurgul|r
.vendor >>Upgrade your pet's abilities
.target Kurgul
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 10186 >> Train your class spells
.target Pephredo
.xp <52,1
.xp >54,1
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 10199 >> Train your class spells
.target Pephredo
.xp <54,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 10946 >> Train your class spells
.target Ur'kyo
.xp <52,1
.xp >54,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 15267 >> Train your class spells
.target Ur'kyo
.xp <54,1
step
.goto Orgrimmar,59.40,36.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dran|r
.turnin 81 >>Turn in Ripple Delivery
.target Dran Droffers
step
.goto Orgrimmar,55.60,34.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jes'rimon|r
.turnin 4300 >>Turn in Bone-Bladed Weapons
.target Jes'rimon
.isQuestComplete 4300
step
.goto Orgrimmar,75.00,34.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Belgrom|r
.accept 3504 >>Accept Betrayed
.target Belgrom Rockmaul
step
.goto Orgrimmar,45.13,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Splintertree Post >>Fly to Splintertree Post
.target Doras
.zoneskip Ashenvale
step
#completewith next
.goto Ashenvale,75.37,64.73,20,0
.goto Ashenvale,79.07,55.41,30,0
.goto Ashenvale,91.24,46.47,30,0
.goto Ashenvale,95.33,48.38,15,0
.subzone 879 >>Travel to Azshara
.target Doras
step
.goto Azshara,10.40,74.90,40,0
.goto Azshara,11.40,78.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loh'atu|r
.accept 5535 >>Accept Spiritual Unrest
.accept 5536 >>Accept A Land Filled with Hatred
.target Loh'atu
step
#completewith next
>>Kill |cRXP_ENEMY_Highborne Apparitions|r and |cRXP_ENEMY_Highborne Lichlings|r << !Priest
>>Kill |cRXP_ENEMY_Highborne Apparitions|r and |cRXP_ENEMY_Highborne Lichlings|r. Keep 1 |T134437:0|t[Ichor of Undeath] for your class quest << Priest
.complete 5535,1 
.complete 5535,2 
.collect 7972,1 << Priest 
.mob Highborne Apparition
.mob Highborne Lichling
step
.loop 25,Azshara,19.4,64.0,19.6,60.8,21.2,60.8,20.6,63.6,19.4,64.0
>>Kill |cRXP_ENEMY_Haldarr Satyrs|r, |cRXP_ENEMY_Haldarr Tricksters|r and |cRXP_ENEMY_Haldarr Felsworn|r
.complete 5536,1 
.complete 5536,2 
.complete 5536,3 
.mob Haldarr Satyr
.mob Haldarr Trickster
.mob Haldarr Felsworn
step
.loop 25,Azshara,17.8,67.8,16.6,71.8,14.6,73.6,13.6,72.6,16.6,68.6,17.2,66.0,17.8,67.8
>>Kill |cRXP_ENEMY_Highborne Apparitions|r and |cRXP_ENEMY_Highborne Lichlings|r << !Priest
>>Kill |cRXP_ENEMY_Highborne Apparitions|r and |cRXP_ENEMY_Highborne Lichlings|r. Keep 1 |T134437:0|t[Ichor of Undeath] for your class quest << Priest
.complete 5535,1 
.complete 5535,2 
.collect 7972,1 << Priest 
.mob Highborne Apparition
.mob Highborne Lichling
step
.goto Azshara,11.36,78.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loh'atu|r
.turnin 5535 >>Turn in Spiritual Unrest
.turnin 5536 >>Turn in A Land Filled with Hatred
.target Loh'atu
step
#completewith next
.goto Azshara,22.00,49.70,30,0
.subzone 1237 >> Travel northeast to Valormok
step
.goto Azshara,22.00,49.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kroum|r
.fp Azshara >>Get the Azshara Flight Path
.target Kroum
step
.goto Azshara,22.20,51.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ag'tor|r
.turnin 3504 >>Turn in Betrayed
.target Ag'tor Bloodfist
.isOnQuest 3504
step
.goto Azshara,22.20,51.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ag'tor|r
.accept 3505 >>Accept Betrayed
.target Ag'tor Bloodfist
.isQuestTurnedIn 3504
step
.goto Azshara,22.50,51.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jediga|r
.accept 3517 >>Accept Stealing Knowledge
.target Jediga
step << Rogue
.goto Azshara,44.20,22.40
>>Pickpocket |cRXP_ENEMY_Timbermaw Shamans|r until you loot a |cRXP_LOOT_Sealed Azure Bag|r
.complete 8234,1 
.mob Timbermaw Shaman
step << Rogue/Mage
.goto Azshara,28.11,50.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sanath Lim-yo|r
.turnin 3503 >>Turn in Meeting with the Master
.target Sanath Lim-yo
step << Rogue
.goto Azshara,27.64,41.49,30,0
.goto Azshara,29.7,40.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Archmage Xylem|r
>>|cRXP_WARN_The Archmage wanders his tower|r
.turnin 8234 >>Turn in Sealed Azure Bag
.accept 8235 >>Accept Encoded Fragments
.target Archmage Xylem
step << Mage
.goto Azshara,29.2,40.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Archmage Xylem|r
>>|cRXP_WARN_The Archmage wanders his tower|r
.accept 8251 >>Accept Magic Dust
.target Archmage Xylem
step << Rogue/Mage
.goto Azshara,26.47,46.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Nyrill|r
.turnin 3421 >>Turn in Return Trip
.target Nyrill
step << Hunter/Priest
#completewith next
.goto Azshara,41.61,42.68,50 >> Travel toward |cRXP_FRIENDLY_Ogtinc|r, he is located on a small peak
step << Hunter/Priest
.goto Azshara,42.40,42.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ogtinc|r
>>|cRXP_WARN_Be careful of falling as you approach him; he's in a precarious spot|r
.accept 8153 >>Accept Coursers Antlers << Hunter
.accept 8255 >>Accept Of Coursers We Know << Priest
.target Ogtinc
step << Hunter/Priest
.loop 25,Azshara,48.4,33.2,48.4,16.4,55.2,17.0,59.6,22.9,70.6,28.4,83.2,25.0,76.6,27.3,67.8,27.4,61.4,23.3,55.3,25.3,50.2,25.4,48.4,33.2
>>Kill |cRXP_ENEMY_Mosshoof Coursers|r. Loot them for their |cRXP_LOOT_Antlers|r << Hunter
>>Kill |cRXP_ENEMY_Mosshoof Coursers|r. Loot them for their |cRXP_LOOT_Glands|r << Priest
>>|cRXP_ENEMY_Mosshoof Coursers|r |cRXP_WARN_share respawn with Hippogryphs and Chimaeras|r
.complete 8153,1 << Hunter 
.complete 8255,1 << Priest 
.mob Mosshoof Courser
step << Hunter
.goto Azshara,42.40,42.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ogtinc|r
.turnin 8153 >>Turn in Coursers Antlers
.accept 8231 >>Accept Wavethrashing
.target Ogtinc
step
.goto Azshara,53.45,21.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kim'jael|r
.accept 3601 >>Accept Kim'jael Indeed!
.target Kim'jael
step
#completewith Magus
>>Loot the |cRXP_PICK_Kim'Jael's Equipment|r boxes scattered around the camp
.complete 3601,1 
.complete 3601,2 
.complete 3601,3 
.complete 3601,4 
step << !Mage
.loop 25,Azshara,55.8,25.9,57.8,26.4,58.0,28.2,59.2,29.6,57.9,31.4,57.0,30.3,56.9,27.5,56.0,29.7,55.4,29.7,55.8,25.9
>>Kill |cRXP_ENEMY_Blood Elf Reclaimers|r and |cRXP_ENEMY_Blood Elf Surveyors|r
>>|cRXP_WARN_Be careful!|r |cRXP_ENEMY_Surveyors|r |cRXP_WARN_have a short cooldown Fire Nova, and|r |cRXP_ENEMY_Reclaimers|r |cRXP_WARN_have a high-damage fireball|r
.complete 3505,1 
.complete 3505,2 
.mob Blood Elf Reclaimer
.mob Blood Elf Surveyor
.isOnQuest 3505
step << Mage
.loop 25,Azshara,55.8,25.9,57.8,26.4,58.0,28.2,59.2,29.6,57.9,31.4,57.0,30.3,56.9,27.5,56.0,29.7,55.4,29.7,55.8,25.9
>>Kill |cRXP_ENEMY_Blood Elf Reclaimers|r and |cRXP_ENEMY_Blood Elf Surveyors|r. Loot them for their |cRXP_LOOT_Dust|r
>>|cRXP_WARN_Be careful!|r |cRXP_ENEMY_Surveyors|r |cRXP_WARN_have a short cooldown Fire Nova, and|r |cRXP_ENEMY_Reclaimers|r |cRXP_WARN_have a high-damage fireball|r
.complete 3505,1 
.complete 3505,2 
.complete 8251,1 
.mob Blood Elf Reclaimer
.mob Blood Elf Surveyor
.isOnQuest 3505
step
.goto Azshara,59.40,31.20
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Kaldorei Tome of Summoning|r on the pedestal in the summoning circle
.complete 3505,3 
.complete 3505,4 
.turnin 3505 >>Turn in Betrayed
.isOnQuest 3505
step
.goto Azshara,59.50,31.20
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Kaldorei Tome of Summoning|r again
.accept 3506 >>Accept Betrayed
.isQuestTurnedIn 3505
step
#label Magus
.goto Azshara,59.50,31.40
>>Destroy one of the |cRXP_PICK_Arcane Focusing Crystals|r. This will summon a |cRXP_ENEMY_Blood Elf Defender|r
>>After 13 seconds |cRXP_ENEMY_Magus Rimtori|r will spawn. Kill her and loot her for her |cRXP_LOOT_Head|r
.complete 3506,1 
.isQuestTurnedIn 3505
.mob Blood Elf Defender
.unitscan Magus Rimtori
step
.goto Azshara,57.02,29.45
.loop 25,Azshara,58.5,25.0,58.9,28.3,59.6,30.9,57.0,29.9,56.5,28.4,58.5,25.0
>>Loot the |cRXP_PICK_Kim'Jael's Equipment|r boxes scattered around the camp
.complete 3601,1 
.complete 3601,2 
.complete 3601,3 
.complete 3601,4 
step
.loop 25,Azshara,55.8,25.9,57.8,26.4,58.0,28.2,59.2,29.6,57.9,31.4,57.0,30.3,56.9,27.5,56.0,29.7,55.4,29.7,55.8,25.9
.xp 54 >>Grind to level 54
step
.goto Azshara,53.45,21.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kim'jael|r
.turnin 3601 >>Turn in Kim'jael Indeed!
.accept 5534 >>Accept Kim'jael's "Missing" Equipment
.target Kim'jael
step << Hunter
.loop 25,Azshara,87.2,23.0,89.8,22.6,89.8,27.4,90.8,31.0,90.2,35.6,88.0,32.0,87.6,30.0,84.6,30.8,84.2,27.8,87.2,23.0
>>Kill all types of |cRXP_ENEMY_Wavethrashers|r. Loot them for their |cRXP_LOOT_Scales|r
.complete 8231,1 
.mob Wavethrasher
.mob Young Wavethrasher
.mob Great Wavethrasher
step << Rogue
.loop 25,Azshara,66.6,25.2,69.0,25.6,71.6,29.2,71.6,24.6,80.8,24.6,86.6,19.6,74.6,12.6,66.6,25.2
>>Kill |cRXP_ENEMY_Forest Oozes|r. Loot them for their |cRXP_LOOT_Encoded Fragments|r
.complete 8235,1 
.unitscan Forest Ooze
step << Mage
.goto Azshara,28.11,50.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sanath Lim-yo|r
.turnin 3503 >>Turn in Meeting with the Master
.target Sanath Lim-yo
step << Mage
.goto Azshara,29.2,40.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Archmage Xylem|r
>>|cRXP_WARN_The Archmage wanders his tower|r
.turnin 8251 >>Turn in Magic Dust
.accept 8252 >>Accept The Siren's Coral
.target Archmage Xylem
step << Mage
.goto Azshara,28.11,50.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sanath Lim-yo|r
.turnin 3503 >>Turn in Meeting with the Master
.target Sanath Lim-yo
step
#completewith Tablets
>>Kill all |cRXP_ENEMY_Spitelash Nagas|r. Loot them for an |cRXP_LOOT_Enchanted Coral|r and |cRXP_LOOT_Some Rune|r << Mage
>>|cRXP_WARN_The|r |cRXP_LOOT_Enchanted Coral|r |cRXP_WARN_is dropped by|r |cRXP_ENEMY_Spitelash Sirens|r |cRXP_WARN_specifically|r << Mage
>>Kill all |cRXP_ENEMY_Spitelash Nagas|r. Loot them for |cRXP_LOOT_Some Rune|r << !Mage
.complete 5534,1 
.complete 8252,1 << Mage 
.mob Spitelash Myrmidon
.mob Spitelash Enchantress
.mob Spitelash Battlemaster
.unitscan Spitelash Siren << Mage
step
.goto Azshara,47.80,60.80
.use 10687 >>Swim in the puddle and use the |T132793:0|t[Empty Vial Labeled #1]
.complete 3568,1 
step
.goto Azshara,47.80,51.30
.use 10688 >>Swim in the puddle and use the |T132793:0|t[Empty Vial Labeled #2]
.complete 3568,2 
step
.goto Azshara,48.70,48.50
.use 10689 >>Swim in the puddle and use the |T132793:0|t[Empty Vial Labeled #3]
.complete 3568,3 
step
.goto Azshara,47.50,46.20
.use 10870 >>Swim in the puddle and use the |T132793:0|t[Empty Vial Labeled #4]
.complete 3568,4 
step
#label Tablets
.goto Azshara,39.80,46.81,40,0
.goto Azshara,39.86,48.72,40,0
.goto Azshara,37.30,48.12,40,0
.goto Azshara,38.55,54.58,40,0
.goto Azshara,40.97,55.00,40,0
.goto Azshara,40.81,62.69,40,0
.goto Azshara,42.95,63.76,40,0
.goto Azshara,38.70,63.30,40,0
.goto Azshara,36.35,58.75,40,0
.goto Azshara,35.92,57.55,40,0
.goto Azshara,34.89,53.93,40,0
.goto Azshara,35.86,53.49
>>Loot the |cRXP_PICK_Glowing Tablets|r scattered around the ruins
.complete 3517,1 
.complete 3517,2 
.complete 3517,3 
.complete 3517,4 
step
.loop 25,Azshara,44.0,48.2,45.6,43.8,47.0,41.6,48.8,45.0,47.4,49.0,48.2,54.0,48.2,59.8,48.6,64.8,46.2,61.0,45.6,57.8,46.0,52.8,44.0,48.2
>>Kill all |cRXP_ENEMY_Spitelash Nagas|r. Loot them for an |cRXP_LOOT_Enchanted Coral|r and |cRXP_LOOT_Some Rune|r << Mage
>>Kill all |cRXP_ENEMY_Spitelash Nagas|r. Loot them for |cRXP_LOOT_Some Rune|r << !Mage
>>|cRXP_WARN_The|r |cRXP_LOOT_Enchanted Coral|r |cRXP_WARN_is dropped by|r |cRXP_ENEMY_Spitelash Sirens|r |cRXP_WARN_specifically|r << Mage
.complete 5534,1 
.complete 8252,1 << Mage 
.mob Spitelash Myrmidon
.mob Spitelash Enchantress
.mob Spitelash Battlemaster
.unitscan Spitelash Siren << Mage
step << Hunter/Priest
.goto Azshara,42.40,42.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ogtinc|r
.turnin 8231 >>Turn in Wavethrashing << Hunter
.turnin 8255 >>Turn in Accept Of Coursers We Know << Priest
.accept 8256 >>Accept The Ichor of Undeath << Priest
.turnin 8256 >>Turn in The Ichor of Undeath << Priest
.target Ogtinc
step << Hunter/Priest
.goto Azshara,42.400,42.619
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ogtinc|r
.accept 8232 >> Accept The Green Drake << Hunter
.accept 8257 >> Accept Blood of Morphaz << Priest
.target Ogtinc
.isQuestTurnedIn 8231 << Hunter
.isQuestTurnedIn 8256 << Priest
.dungeon ST
step
.goto Azshara,45.55,37.79,50,0
.goto Azshara,53.45,21.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tRun up the hill out of the ruins, then talk to |cRXP_FRIENDLY_Kim'jael|r
.turnin 5534 >>Turn in Kim'jael's "Missing" Equipment
.target Kim'jael
step
.goto Azshara,22.60,51.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jediga|r
.turnin 3517 >>Turn in Stealing Knowledge
.accept 3561 >>Accept Delivery to Archmage Xylem
.accept 3518 >>Accept Delivery to Magatha
.accept 3541 >>Accept Delivery to Jes'rimon
.target Jediga
step
.goto Azshara,22.26,51.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ag'tor|r
.turnin 3506 >>Turn in Betrayed
.accept 3507 >>Accept Betrayed
.target Ag'tor Bloodfist
.isQuestTurnedIn 3505
step
.goto Azshara,28.11,50.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sanath|r
.turnin 3503 >>Turn in Meeting with the Master
.target Sanath Lim-yo
step
.goto Azshara,29.7,40.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Archmage Xylem|r
.turnin 3561 >>Turn in Delivery to Archmage Xylem
.accept 3565 >>Accept Xylem's Payment to Jediga
.turnin 8252 >>Turn in The Siren's Coral << Mage
.turnin 8235 >>Turn in Encoded Fragments << Rogue
.target Archmage Xylem
step << Mage/Rogue
.goto Azshara,29.248,40.210
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Archamge Xylem|r atop the Tower
.accept 8253 >> Accept Destroy Morphaz << Mage
.accept 8236 >> Accept The Azure Key << Rogue
.target Archamge Xylem
.isQuestTurnedIn 8252 << Mage
.isQuestTurnedIn 8235 << Rogue
.dungeon ST
step
.goto Azshara,26.47,46.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nyrill|r
.turnin 3421 >>Turn in Return Trip
.target Nyrill
step
.goto Azshara,22.56,51.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jediga|r
.turnin 3565 >>Turn in Xylem's Payment to Jediga
.target Jediga
step
.goto Azshara,21.96,49.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kroum|r
.fly Splintertree Post >>Fly to Splintertree Post
.target Kroum
.zoneskip Ashenvale
step
.goto Ashenvale,55.78,28.12
.zone Felwood >>Travel to Felwood
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 54-54 Felwood
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 50-60
#next 54-56 Un'Goro Crater
step
#completewith next
#sticky
.abandon 3504 
.abandon 3568 
step
.goto Felwood,51.00,85.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grazle|r
.accept 8460 >>Accept Timbermaw Ally
.target Grazle
step
.goto Felwood,50.90,81.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Taronn|r
.accept 5156 >>Accept Verifying the Corruption
.target Taronn Redfeather
step
.goto Felwood,51.20,82.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greta|r
.accept 5155 >>Accept Forces of Jaedenar
.target Greta Mosshoof
step
.goto Felwood,46.70,83.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maybess|r
.accept 4102 >>Accept Cleansing Felwood
.target Maybess Riverbreeze
step
#completewith next
.subzone 1763 >> Travel to Jaedenar
step
.goto Felwood,38.45,60.72
>>Kill |cRXP_ENEMY_Jaedenar Hounds|r, |cRXP_ENEMY_Guardians|r, |cRXP_ENEMY_Adepts|r and |cRXP_ENEMY_Cultists|r
>>|cRXP_WARN_Be very careful of|r |cRXP_ENEMY_Jaedenar Adepts|r|cRXP_WARN_; they have blink, as well as a strong fireball and fire blast|r
.complete 5155,1 
.complete 5155,2 
.complete 5155,3 
.complete 5155,4 
.mob Jaedenar Hound
.mob Jaedenar Guardian
.mob Jaedenar Adept
.mob Jaedenar Cultist
step
#completewith next
.goto Felwood,37.37,49.83,40,0
.goto Felwood,35.45,50.10,40,0
.goto Felwood,34.57,52.12
.subzone 1997 >> Travel to Bloodvenom Post
step
.goto Felwood,34.80,52.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dreka'Sur|r
.accept 6162 >>Accept A Husband's Last Battle
.target Dreka'Sur
step
.goto Felwood,34.20,52.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Winna|r
.accept 4505 >>Accept Well of Corruption
.target Winna Hazzard
step
.goto Felwood,34.40,53.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brakkar|r
.fp Felwood >>Get the Felwood Flight Path
.target Brakkar
step << Warlock
#completewith next
.goto Felwood,33.0,66.4,30,0
.goto Felwood,37.6,66.6,30,0
.goto Felwood,37.2,69.8,30,0
>>Kill all |cRXP_ENEMY_Jadefire Satyrs|r until you loot 1 |cRXP_LOOT_Felcloth|r
.collect 14256,1 
.mob Jadefire Rogue
.mob Jadefire Felsworn
.unitscan Jadefire Shadowstalker
step
.goto Felwood,36.02,66.99,70,0
.goto Felwood,32.30,66.60
.use 12566 >>Travel to the green moonwell in the Ruins of Constellas, then use your |T134870:0|t[Hardened Flasket]
>>|cRXP_WARN_There are stealthed Satyrs with strong slowing poison in this area. Some of them patrol, so be careful|r
.complete 4505,1 
.unitscan Jadefire Shadowstalker << !Warlock
step << Warlock
.goto Felwood,33.0,66.4,30,0
.goto Felwood,37.6,66.6,30,0
.goto Felwood,37.2,69.8
>>Kill all |cRXP_ENEMY_Jadefire Satyrs|r until you loot 1 |cRXP_LOOT_Felcloth|r
.collect 14256,1 
.mob Jadefire Rogue
.mob Jadefire Felsworn
.unitscan Jadefire Shadowstalker
step
#completewith next
>>Kill |cRXP_ENEMY_Deadwood Warriors|r, |cRXP_ENEMY_Deadwood Pathfinders|r and |cRXP_ENEMY_Deadwood Gardeners|r
.complete 8460,1 
.complete 8460,2 
.complete 8460,3 
.mob Deadwood Warrior
.mob Deadwood Pathfinder
.mob Deadwood Gardener
step
.goto Felwood,48.20,94.30
>>Kill |cRXP_ENEMY_Overlord Ror|r. Loot him for his |cRXP_LOOT_Claw|r
>>|cRXP_WARN_Clear the area to avoid complications from his AoE fear|r
.complete 6162,1 
.unitscan Overlord Ror
step
.loop 25,Felwood,48.2,94.3,46.8,91.8,46.6,90.4,46.6,88.6,48.6,89.4,49.2,91.6,48.2,94.3
>>Kill |cRXP_ENEMY_Deadwood Warriors|r, |cRXP_ENEMY_Deadwood Pathfinders|r and |cRXP_ENEMY_Deadwood Gardeners|r
.complete 8460,1 
.complete 8460,2 
.complete 8460,3 
.mob Deadwood Warrior
.mob Deadwood Pathfinder
.mob Deadwood Gardener
step
.goto Felwood,51.00,85.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grazle|r
.turnin 8460 >>Turn in Timbermaw Ally
.accept 8462 >>Accept Speak to Nafien
.target Grazle
step
.goto Felwood,51.20,82.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greta|r
.turnin 5155 >>Turn in Forces of Jaedenar
.accept 5157 >>Accept Collection of the Corrupt Water
.target Greta Mosshoof
step
#completewith next
.subzone 1763 >> Travel to Jaedenar
step
.goto Felwood,35.20,59.80
.use 12922 >>Use your |T132788:0|t[Empty Canteen] in the green moonwell
>>|cRXP_WARN_Be very careful of Jaedenar Adepts; they have blink, as well as a strong fireball and fire blast|r
.complete 5157,1 
.unitscan Jaedenar Adept
step << Warlock
.goto Felwood,37.6,68.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Impsy|r
.turnin 8419 >>Turn in An Imp's Request
.accept 8421 >>Accept The Wrong Stuff
.target Impsy
step << !Warlock
.loop 25,Felwood,41.2,45.4,43.4,48.2,42.6,50.2,39.6,54.0,40.8,59.8,40.8,66.0,40.2,68.6,38.8,71.6,41.6,71.6,42.0,67.8,40.8,66.0,40.8,59.8,39.6,54.0,41.2,50.6,38.6,49.6,43.4,48.2,41.2,45.4
>>Kill |cRXP_ENEMY_Cursed Oozes|r and |cRXP_ENEMY_Tainted Oozes|r. Loot them for their |cRXP_LOOT_Slime Samples|r
.collect 12230,30 
.mob Cursed Ooze
.mob Tainted Ooze
step << Warlock
.loop 25,Felwood,41.2,45.4,43.4,48.2,42.6,50.2,39.6,54.0,40.8,59.8,40.8,66.0,40.2,68.6,38.8,71.6,41.6,71.6,42.0,67.8,40.8,66.0,40.8,59.8,39.6,54.0,41.2,50.6,38.6,49.6,43.4,48.2,41.2,45.4
>>Kill |cRXP_ENEMY_Cursed Oozes|r and |cRXP_ENEMY_Tainted Oozes|r. Loot them for their |cRXP_LOOT_Slime Samples|r and |cRXP_LOOT_Bloodvenom Essence|r
>>|cRXP_WARN_Only|r |cRXP_ENEMY_Tainted Oozes|r |cRXP_WARN_can drop|r |cRXP_LOOT_Bloodvenom Essence|r
.collect 12230,30 
.complete 8421,2 
.mob Cursed Ooze
.mob Tainted Ooze
step
#completewith next
>>Run into a crater
.complete 5156,3 
step
.loop 25,Felwood,40.6,42.4,42.0,37.6,45.6,38.6,44.6,42.6,40.6,42.4
>>Kill |cRXP_ENEMY_Entropic Beasts|r and |cRXP_ENEMY_Entropic Horrors|r
>>|cRXP_WARN_They share spawns, so you may have to kill extra of each type|r
.complete 5156,1 
.complete 5156,2 
.complete 5156,3 
.mob Entropic Horror
.mob Entropic Beast
step
.goto Felwood,41.20,42.82
>>Run into a crater
.complete 5156,3 
step << Warlock
.loop 25,Felwood,49.6,30.0,46.4,24.6,49.2,19.8,53.0,20.4,52.0,24.8,49.6,30.0
>>Kill |cRXP_ENEMY_Withered Protectors|, |cRXP_ENEMY_Irontree Stompers| and |cRXP_ENEMY_Irontree Wanderers|. Loot them for their |cRXP_LOOT_Rotting Wood|r
.complete 8421,1 
.mob Withered Protectors
.mob Irontree Stompers
.mob Irontree Wanderers
step << Warlock
.goto Felwood,37.6,68.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Impsy|r
.turnin 8421 >>Turn in The Wrong Stuff
.target Impsy
step << Warlock
.goto Felwood,41.52,44.99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Impsy|r
.accept 8422 >> Accept Trolls of a Feather
.target Impsy
.isQuestTurnedIn 8421
.dungeon ST
step
#completewith next
>>Kill |cRXP_ENEMY_Angerclaw Grizzlies|r and |cRXP_ENEMY_Felpaw Ravagers|r
.complete 4120,1 
.complete 4120,2 
.mob Angerclaw Grizzly
.mob Felpaw Ravager
step
.goto Felwood,56.6,17.4,40,0
.goto Felwood,57.8,19.2,40,0
.goto Felwood,57.6,21.8,40,0
.goto Felwood,59.2,20.4
>>Kill |cRXP_ENEMY_Warpwood Moss Flayers|r and |cRXP_ENEMY_Warpwood Shredders|r. Loot them for their |cRXP_LOOT_Blood Ambers|r
.complete 4102,1 
.mob Warpwood Moss Flayer
.mob Warpwood Shredder
step
.loop 25,Felwood,56.0,22.2,53.2,28.0,56.8,26.4,56.0,22.2,58.6,15.6,64.6,20.0,58.6,15.6,56.2,8.6,50.8,12.6,53.6,15.6,56.0,22.2
>>Finish killing |cRXP_ENEMY_Angerclaw Grizzlies|r and |cRXP_ENEMY_Felpaw Ravagers|r
.complete 4120,1 
.complete 4120,2 
.mob Angerclaw Grizzly
.mob Felpaw Ravager
step
#completewith next
.goto Felwood,64.70,8.10,70 >>Travel to the the Timbermaw Hold Entrance
step
.goto Felwood,64.70,8.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nafien|r
.turnin 8462 >>Turn in Speak to Nafien
.target Nafien
step
#completewith next
.goto Felwood,65.37,6.92,20,0
.goto Felwood,64.89,5.82,20,0
.goto Felwood,64.56,3.46,20,0
.goto Felwood,65.41,2.77,20,0
.goto Felwood,65.38,1.08,20,0
.goto Felwood,65.98,0.64,20,0
.goto Kalimdor,52.27,22.95,20,0
.goto Kalimdor,52.33,22.62,20,0
.goto Kalimdor,52.23,22.49,20,0
.goto Kalimdor,52.27,22.35,20,0
.goto Kalimdor,52.33,22.34,20,0
.goto Moonglade,35.74,72.37,20,0
.zone Moonglade >>Enter the tunnel, then take the north exit into Moonglade
.zoneskip Moonglade
.isOnQuest 7066
.dungeon MARA
step
.goto Moonglade,36.178,41.798
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Keeper Remulos|r
.turnin 7066 >> Turn in Seed of Life
.target Keeper Remulos
.isOnQuest 7066
.dungeon MARA
step
#completewith next
.goto Felwood,65.44,2.81,20,0
.goto Felwood,66.51,2.98,20,0
.goto Felwood,67.82,4.33,20,0
.goto Felwood,67.93,5.11,20,0
.zone Winterspring >>Travel through Timbermaw Hold to Winterspring
step
.goto Winterspring,31.30,45.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donova|r
.accept 5082 >>Accept Threat of the Winterfall
.target Donova Snowden
step
.goto Winterspring,31.30,45.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donova|r
.turnin 3908 >>Turn in It's a Secret to Everybody
.target Donova Snowden
step
#completewith next
>>Kill |cRXP_ENEMY_Winterfall Furbolgs|r until you loot an |T134865:0|t[|cFF00BCD4Empty Firewater Flask|r]. Use it to accept the quest
.collect 12771,1,5083 
.accept 5083 >>Accept Winterfall Firewater
.use 12771
.mob Winterfall Pathfinder
.mob Winterfall Den Watcher
.mob Winterfall Totemic
step
.loop 25,Winterspring,31.0,36.8,30.0,35.8,31.0,34.8,33.6,37.0,31.0,36.8
>>Kill |cRXP_ENEMY_Winterfall Pathfinders|r, |cRXP_ENEMY_Winterfall Den Watchers|r and |cRXP_ENEMY_Winterfall Totemics|r
>>|cRXP_WARN_Clear the southeastern camps if you run out of spawns|r
.complete 5082,1 
.complete 5082,2 
.complete 5082,3 
.mob Winterfall Pathfinder
.mob Winterfall Den Watcher
.mob Winterfall Totemic
step
.loop 25,Winterspring,39.0,42.8,41.8,44.6,42.4,42.4,39.0,42.8
>>Kill |cRXP_ENEMY_Winterfall Furbolgs|r until you loot an |T134865:0|t[|cFF00BCD4Empty Firewater Flask|r]. Use it to accept the quest
.collect 12771,1,5083 
.accept 5083 >>Accept Winterfall Firewater
.use 12771
.mob Winterfall Pathfinder
.mob Winterfall Den Watcher
.mob Winterfall Totemic
step
.goto Winterspring,31.30,45.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donova|r
.turnin 5082 >>Turn in Threat of the Winterfall
.turnin 5083 >>Turn in Winterfall Firewater
.accept 5084 >>Accept Falling to Corruption
.accept 3909 >>Accept The Videre Elixir 
.target Donova Snowden
step
#completewith next
.subzone 2255 >> Travel to Everlook
step
.goto Winterspring,61.60,38.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Felnok|r
.turnin 4808 >>Turn in Felnok Steelspring
.target Felnok Steelspring
step
.goto Winterspring,60.47,36.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yugrek|r
.fp Everlook >>Get the Everlook Flight Path
.fly Felwood >>Fly to Felwood
.target Yugrek
step
.goto Felwood,34.20,52.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Winna|r
.turnin 4505 >>Turn in Well of Corruption
.target Winna Hazzard
step
.goto Felwood,34.80,52.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dreka'Sur|r
.turnin 6162 >>Turn in A Husband's Last Battle
.target Dreka'Sur
step
.goto Felwood,46.60,83.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maybess|r
.turnin 4102 >>Turn in Cleansing Felwood
step
.goto Felwood,46.60,83.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maybess|r again to receive a |T134249:0|t[Cenarion Beacon]
.collect 11511,1 
.target Maybess Riverbreeze
.skipgossip
step
.goto Felwood,51.20,82.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greta|r
.turnin 5157 >>Turn in Collection of the Corrupt Water
.accept 5158 >>Accept Seeking Spiritual Aid
.target Greta Mosshoof
step
.goto Felwood,50.90,81.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Taronn|r
.turnin 5156 >>Turn in Verifying the Corruption
.target Taronn Redfeather
step
#completewith next
.hs >>Hearth to Orgrimmar
.use 6948
step
.goto Orgrimmar,54.10,68.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryshka|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Gryshka
step
#ah
.goto Orgrimmar,55.59,62.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thathung|r
>>|cRXP_BUY_Buy one|r |T133021:0|t[Mithril Casing] |cRXP_BUY_from the Auction House|r 
.target Auctioneer Thathung
.collect 10561,1
step
.goto Orgrimmar,55.52,34.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jes'rimon|r
.turnin 3541 >>Turn in Delivery to Jes'rimon
.accept 3563 >>Accept Jes'rimon's Payment to Jediga
.target Jes'rimon
.isOnQuest 3541
step
.goto Orgrimmar,75.20,34.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Belgrom|r
.turnin 3507 >>Turn in Betrayed
.target Belgrom Rockmaul
.isOnQuest 3507
step
.goto Orgrimmar,56.40,46.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zilzibin|r
.accept 4494 >>Accept March of the Silithid
.target Zilzibin Drumlore
step
.goto Orgrimmar,45.11,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Doras|r
.fly Camp Taurajo >>Fly to Camp Taurajo
.target Doras
.zoneskip The Barrens
step
.goto The Barrens,45.58,59.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Byula|r
.home >> Set your Hearthstone to Camp Taurajo
.target Innkeeper Byula
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 54-56 Un'Goro Crater
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 50-60
#next 56-57 Felwood/Winterspring
step
.goto The Barrens,44.45,59.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa|r
.fly Tanaris >>Fly to Tanaris
.target Omusa Thunderhorn
.zoneskip Tanaris
step
.goto Tanaris,50.90,27.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pestlezugg|r
.turnin 4494 >>Turn in March of the Silithid
.accept 4496 >>Accept Bungle in the Jungle
.target Alchemist Pestlezugg
step
.goto Tanaris,52.70,45.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Marvon|r
.turnin 3444 >>Turn in The Stone Circle
.target Marvon Rivetseeker
step
.goto Tanaris,51.60,25.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bullkrek|r
.fly Un'Goro Crater>>Fly to Un'Goro Crater
.target Bullkrek Ragefist
.zoneskip Un'Goro Crater
step
.goto Un'Goro Crater,43.89,7.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hol'anyee|r
.accept 3883 >>Accept Alien Ecology
.target Hol'anyee Marshal
step
.goto Un'Goro Crater,43.50,7.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Spark|r
.accept 3882 >>Accept Roll the Bones
.target Spark Nilminer
step
.goto Un'Goro Crater,43.61,8.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Spraggle|r
.accept 4501 >>Accept Beware of Pterrordax
.target Spraggle Frock
step
.goto Un'Goro Crater,45.53,8.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Larion|r
.accept 4145 >>Accept Larion and Muigin
.target Larion
step
.goto Tanaris,12.80,8.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shizzle|r
.accept 4503 >>Accept Shizzle's Flyer
.target Shizzle
step
#completewith Mighty
>>Kill every |cRXP_ENEMY_Ooze|r you encounter. Loot them for their |cRXP_LOOT_Slime Samples|r and |cRXP_LOOT_Un'Goro Soil|r
.collect 11018,25 
.collect 12235,30 
.mob Muculent Ooze
.mob Glutinous Ooze
.mob Primal Ooze
step
#completewith FungalRock
.goto Un'Goro Crater,62.97,17.39,40,0
.subzone 542 >>Travel to Fungal Rock
step
#completewith next
.goto Un'Goro Crater,52.8,13.4,40,0
.goto Un'Goro Crater,53.0,17.6,40,0
.goto Un'Goro Crater,56.6,16.6,40,0
.goto Un'Goro Crater,60.6,20.6,40,0
>>On your way to Fungal Rock, kill |cRXP_ENEMY_Bloodpetal Flayers|r
>>|cRXP_WARN_Their poison deals high damage. Do not focus on this. You can finish it later|r << Warrior/Rogue
>>|cRXP_WARN_Their poison deals high damage and drains mana. Do not focus on this. You can finish it later|r << !Warrior !Rogue
.complete 4145,3 
.mob Bloodpetal Flayer
step
#label FungalRock
.goto Un'Goro Crater,61.85,17.71,50,0
.goto Un'Goro Crater,64.32,16.35,25,0
.goto Un'Goro Crater,65.83,15.61,20,0
.goto Un'Goro Crater,68.70,17.13,20,0
.goto Un'Goro Crater,69.52,16.82,20,0
.goto Un'Goro Crater,68.63,14.36,20,0
.goto Un'Goro Crater,68.51,13.27,20,0
.goto Un'Goro Crater,65.64,14.60,20,0
.goto Un'Goro Crater,65.06,16.70,20,0
.goto Un'Goro Crater,63.91,16.35,20,0
.goto Un'Goro Crater,62.86,18.17
>>Kill |cRXP_ENEMY_Un'Goro Stompers|r, |cRXP_ENEMY_Un'Goro Thunderers|r. and |cRXP_ENEMY_Un'Goro gorillas|r. Loot them for their |cRXP_LOOT_Pelts|r
>>|cRXP_WARN_Be careful!|r |cRXP_ENEMY_Un'Goro Gorillas|r |cRXP_WARN_call for help in a 90 yard range.|r |cRXP_ENEMY_Un'Goro Thunderers|r |cRXP_WARN_have a high-damage, instant shock spell|r
.complete 4289,2 
.complete 4289,3 
.complete 4289,1 
.mob Un'Goro Thunderer
.mob Un'Goro Stomper
.mob Un'Goro Gorilla
step
#completewith Ucha
>>Kill |cRXP_ENEMY_Diemetradons|r. Loot them for their |cRXP_LOOT_Bones|r and |cRXP_LOOT_Scales|r
>>|cRXP_WARN_Be careful of|r |cRXP_ENEMY_Elder Diemetradons'|r |cRXP_WARN_Pummel ability, which interrupts spells|r << Warlock/Priest/Mage/Shaman/Druid
.complete 3882,1 
.complete 4503,1 
.mob Diemetradon
.mob Young Diemetradon
.mob Elder Diemetradon
step
.loop 25,Un'Goro Crater,57.6,36.8,64.4,30.8,68.2,24.0,71.2,31.0,74.2,39.6,76.0,47.4,74.2,39.6,69.4,38.0,66.6,35.6,60.0,39.4,57.6,36.8
>>Kill |cRXP_ENEMY_Bloodpetal Threshers|r and |cRXP_ENEMY_Bloodpetal Lashers|r
>>|cRXP_WARN_Their poison deals high damage and they can disarm|r << Warrior/Rogue/Shaman
>>|cRXP_WARN_Their poison deals high damage and drains mana|r << !Warrior !Rogue !Shaman
.complete 4145,4 
.complete 4145,1 
.mob Bloodpetal Thresher
.mob Bloodpetal Lasher
step
.goto Un'Goro Crater,71.64,75.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torwa|r
.turnin 4289 >>Turn in The Apes of Un'Goro
.accept 4292 >>Accept The Bait for Lar'korwi
.accept 4301 >>Accept The Mighty U'cha
.accept 9052 >>Accept Bloodpetal Poison << Druid
.target Torwa Pathfinder
step
.goto Un'Goro Crater,79.94,49.88
.use 11568 >>Open |T133635:0|t[Torwa's Pouch]
.use 11569 >>Stand near the big flat rock, then use the |T133970:0|t[Preserved Threshadon Meat]
.use 11570 >>Use the |T134743:0|t[Preserved Pheromone Mixture]
>>Kill |cRXP_ENEMY_Lar'korwi|r as he spawns. Loot him for his |cRXP_LOOT_Head|r
.complete 4292,1 
.mob Lar'korwi
step
#label Ucha
.goto Un'Goro Crater,71.64,75.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torwa|r
.turnin 4292 >>Turn in The Bait for Lar'korwi
.target Torwa Pathfinder
step << Druid
#sticky
#label bloodcap
>>Loot |cRXP_PICK_Bloodpetal Sprouts|r around the zone until you have 8 |cRXP_LOOT_Bloodcaps|r
.complete 9052,2 
step
.loop 25,Un'Goro Crater,68.2,75.0,67.0,71.2,67.8,67.0,68.0,61.6,64.8,62.6,63.0,66.4,61.6,70.8,59.8,75.2,59.4,79.0,62.0,82.4,61.8,76.0,63.6,77.2,66.2,77.8,68.2,75.0
>>Kill |cRXP_ENEMY_Ravasaur Raptors|r. Loot them for their |cRXP_LOOT_Claws|r
.complete 4300,1 
.mob Ravasaur
.mob Ravasaur Hunter
.mob Venomhide Ravasaur
.mob Ravasaur Runner
.mob Ravasaur Matriarch
.isOnQuest 4300
step
#completewith next
.goto Un'Goro Crater,50.59,77.06,0
>>Kill |cRXP_ENEMY_Gorishi Silithid|r. Loot them for a |cRXP_LOOT_Gorishi Scent Gland|r << !Druid
>>Kill |cRXP_ENEMY_Gorishi Silithid|r. Loot them for a |cRXP_LOOT_Gorishi Scent Gland|r and for |cRXP_LOOT_Gorishi Stings|r << Druid
.complete 4496,1 
.complete 9052,1 << Druid 
.mob Gorishi Worker
.mob Gorishi Wasp
.mob Gorishi Reaver
.mob Gorishi Tunneler
.mob Gorishi Stinger
.mob Gorishi Hive Guard
step
.goto Un'Goro Crater,49.97,81.36,40,0
.goto Un'Goro Crater,48.7,85.2
.use 11132 >>Enter the silithid cave, then hug the left wall. Use your |T134864:0|t[Scraping Vial] in the middle of the round chamber
.complete 3883,1 
step
.goto Un'Goro Crater,49.44,82.85,40,0
.goto Un'Goro Crater,50.35,79.55,50,0
.goto Un'Goro Crater,48.69,76.45,70,0
.goto Un'Goro Crater,47.58,81.58,70,0
.goto Un'Goro Crater,49.38,82.32,70,0
.goto Un'Goro Crater,52.38,84.31,70,0
.goto Un'Goro Crater,54.03,78.15,70,0
.goto Un'Goro Crater,51.74,75.36
>>Kill |cRXP_ENEMY_Gorishi Silithid|r. Loot them for a |cRXP_LOOT_Gorishi Scent Gland|r << !Druid
>>Kill |cRXP_ENEMY_Gorishi Silithid|r. Loot them for a |cRXP_LOOT_Gorishi Scent Gland|r and for |cRXP_LOOT_Gorishi Stings|r << Druid
.complete 4496,1 
.complete 9052,1 << Druid 
.mob Gorishi Worker
.mob Gorishi Wasp
.mob Gorishi Reaver
.mob Gorishi Tunneler
.mob Gorishi Stinger
.mob Gorishi Hive Guard
step
.goto Un'Goro Crater,56.2,88.2,40,0
.goto Un'Goro Crater,57.0,92.6,40,0
.goto Un'Goro Crater,50.4,87.8,40,0
.goto Un'Goro Crater,50.6,89.8,40,0
.goto Un'Goro Crater,43.0,85.2,40,0
.goto Un'Goro Crater,43.6,92.4
>>Kill |cRXP_ENEMY_Pterrordax|r in the southern mountains
.complete 4501,1 
.unitscan Pterrordax
step
#completewith BloodpetalTrappers
>>Kill |cRXP_ENEMY_Diemetradons|r. Loot them for their |cRXP_LOOT_Bones|r and |cRXP_LOOT_Scales|r
.complete 3882,1 
.complete 4503,1 
.mob Diemetradon
.mob Young Diemetradon
.mob Elder Diemetradon
step
#completewith next
.loop 25,Un'Goro Crater,36.6,65.8,40.8,62.8,41.8,56.8,40.6,51.2,39.6,43.4,37.8,36.6,32.6,34.4,27.6,37.2,26.0,45.4,26.8,58.2,30.8,68.0,38.4,74.0,40.8,67.2,32.8,63.2,30.8,59.6
>>Kill |cRXP_ENEMY_Frenzied Pterrordax|r. Loot them for their |cRXP_LOOT_Scales|r
.complete 4501,2 
.complete 4503,2 
.mob Frenzied Pterrordax
step
#label BloodpetalTrappers
.goto Un'Goro Crater,35.49,43.91
>>Kill |cRXP_ENEMY_Bloodpetal Trappers|r
>>|cRXP_WARN_Their poison deals high damage, and they can cast entangling roots|r << Warrior/Rogue/Shaman
>>|cRXP_WARN_Their poison deals high damage and drains mana. They can cast entangling roots|r << !Warrior !Rogue !Shaman
.complete 4145,2 
.mob Bloodpetal Trapper
step
#completewith next
>>Kill |cRXP_ENEMY_Frenzied Pterrordax|r. Loot them for their|cRXP_LOOT_Scales|r
.complete 4501,2 
.complete 4503,2 
.mob Frenzied Pterrordax
step
.goto Un'Goro Crater,29.0,54.8,40,0
.goto Un'Goro Crater,30.8,59.6,40,0
.goto Un'Goro Crater,33.0,65.6,40,0
.loop 25,Un'Goro Crater,36.6,65.8,40.8,62.8,41.8,56.8,40.6,51.2,39.6,43.4,37.8,36.6,32.6,34.4,27.6,37.2,26.0,45.4,26.8,58.2,30.8,68.0,38.4,74.0,40.8,67.2,32.8,63.2,30.8,59.6
>>Kill |cRXP_ENEMY_Diemetradons|r. Loot them for their |cRXP_LOOT_Bones|r and |cRXP_LOOT_Scales|r
.complete 3882,1 
.complete 4503,1 
.mob Diemetradon
.mob Young Diemetradon
.mob Elder Diemetradon
step
.loop 25,Un'Goro Crater,36.6,65.8,40.8,62.8,41.8,56.8,40.6,51.2,39.6,43.4,37.8,36.6,32.6,34.4,27.6,37.2,26.0,45.4,26.8,58.2,30.8,68.0,38.4,74.0,40.8,67.2,32.8,63.2,30.8,59.6
>>Kill |cRXP_ENEMY_Frenzied Pterrordax|r. Loot them for their|cRXP_LOOT_Scales|r
.complete 4501,2 
.complete 4503,2 
.mob Frenzied Pterrordax
step
#completewith next
.subzone 541 >> Travel to Marshal's Refuge
step
.goto Un'Goro Crater,43.61,8.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Spraggle|r
.turnin 4501 >>Turn in Beware of Pterrordax
.accept 4492 >>Accept Lost!
.target Spraggle Frock
step
.goto Un'Goro Crater,44.23,11.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shizzle|r
.turnin 4503 >>Turn in Shizzle's Flyer
.target Shizzle
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hol'anyee|r and |cRXP_FRIENDLY_Williden|r
.turnin 3883 >>Turn in Alien Ecology
.goto Un'Goro Crater,43.89,7.24
.accept 3881 >>Accept Expedition Salvation
.goto Un'Goro Crater,43.95,7.14
.target Hol'anyee Marshal
.target Williden Marshal
step
.goto Un'Goro Crater,43.50,7.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Spark|r
.turnin 3882 >>Turn in Roll the Bones
.target Spark Nilminer
step
.goto Un'Goro Crater,43.16,6.24,30,0
.goto Un'Goro Crater,41.90,2.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_J.D. Collie|r
.accept 4288 >>Accept The Western Pylon
.accept 4285 >>Accept The Northern Pylon
.accept 4287 >>Accept The Eastern Pylon
.target J.D. Collie
step
.goto Un'Goro Crater,45.53,8.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Larion|r
.turnin 4145 >>Turn in Larion and Muigin
.target Larion
step
.goto Un'Goro Crater,46.37,13.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karna|r
.accept 4243 >>Accept Chasing A-Me 01
.target Karna Remtravel
step
.goto Un'Goro Crater,56.49,12.44
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Northern Crystal Pylon|r
.complete 4285,1 
.isOnQuest 4285
step
.goto Un'Goro Crater,64.17,16.43,40,0
.goto Un'Goro Crater,67.66,16.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tHug the right wall as you enter the cave, then talk to |cRXP_FRIENDLY_A-Me 01|r
.turnin 4243 >>Turn in Chasing A-Me 01
.target A-Me 01
step
.goto Un'Goro Crater,68.0,13.2
>>Kill |cRXP_ENEMY_U'cha|r in the back of the cave. Loot him for his |cRXP_LOOT_Pelt|r
.complete 4301,1 
.unitscan U'cha
step
#ah
.goto Un'Goro Crater,67.67,16.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_A-Me|r
.accept 4244 >>Accept Chasing A-Me 01
.turnin 4244 >>Turn in Chasing A-Me 01
.accept 4245 >>Accept Chasing A-Me 01
.target A-Me 01
step
#ah
.goto Un'Goro Crater,67.67,16.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_A-Me|r
.accept 4245 >>Accept Chasing A-Me 01
.target A-Me 01
step
#ah
.goto Un'Goro Crater,46.37,13.43
>>Escort |cRXP_FRIENDLY_A-Me|r back to Marshal's Refuge
.complete 4245,1 
.isOnQuest 4245
step
#ah
.goto Un'Goro Crater,46.37,13.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karna|r
.turnin 4245 >>Turn in Chasing A-Me 01
.target Karna Remtravel
.isQuestComplete 4245
step
.goto Un'Goro Crater,68.54,36.54
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Crate of Foodstuffs|r
.complete 3881,1 
step
#requires bloodcap << Druid
.goto Un'Goro Crater,77.24,49.96
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Eastern Crystal Pylon|r
.complete 4287,1 
.isOnQuest 4287
step
#label Mighty
.goto Un'Goro Crater,71.64,75.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torwa|r
.turnin 4301 >>Turn in The Mighty U'cha
.turnin 9052 >>Turn in Bloodpetal Poison << Druid
.target Torwa Pathfinder
step << Druid
.goto Un'Goro Crater,71.64,75.96
>>|cRXP_WARN_When you make it to this quest's completion step, read our instructions very carefully. This quest is very dangerous|r
.accept 9051 >>Accept Toxic Test
.target Torwa Pathfinder
step
.goto Un'Goro Crater,38.46,66.07
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Research Equipment boxes|r
.complete 3881,2 
step
.goto Un'Goro Crater,23.87,59.21
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Western Crsytal Pylon|r
.complete 4288,1 
step
.goto Un'Goro Crater,30.94,50.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krakle|r
.accept 974 >>Accept Finding the Source
.target Krakle
step << Druid 
>>Track a |cRXP_ENEMY_Devilsaur|r or |cRXP_ENEMY_Ironhide Devilsaur|r
>>|cRXP_WARN_Do not engage a|r |cRXPTyrant Devilsaur|r|cRXP_WARN_; their fear ability is deadly|r
>>|cRXP_WARN_Spam Hibernate on the|r |cRXP_ENEMY_Devilsaur|r|cRXP_WARN_, and nothing else. If it breaks, spam it again.|r
>>|cRXP_ENEMY_Devilsaur|r |cRXP_WARN_have 170% movement speed; they cannot be outrun|r
.use 22432 >>Use your |T135125:0|t[Devilsaur Barb] on it while it's asleep
.complete 9051,1 
.unitscan Devilsaur
.unitscan Ironhide Devilsaur,
.unitscan Tyrant Devilsaur
step << Druid
.goto Un'Goro Crater,71.64,75.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torwa|r
.turnin 9051 >>Turn in Toxic Test
.target Torwa Pathfinder
step << Druid
.goto Un'Goro Crater,71.639,75.960
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torwa Pathfinder|r
.accept 9053 >> Accept A Better Ingredient
.target Torwa Pathfinder
.isQuestTurnedIn 9051
.dungeon ST
step
.goto Un'Goro Crater,46.60,62.37,70,0
.goto Un'Goro Crater,49.25,64.43,70,0
.goto Un'Goro Crater,50.93,67.97,70,0
.goto Un'Goro Crater,55.97,69.52,70,0
.goto Un'Goro Crater,57.84,63.53,70,0
.goto Un'Goro Crater,58.80,57.84,70,0
.goto Un'Goro Crater,58.43,52.67,70,0
.goto Un'Goro Crater,57.94,44.83,70,0
.goto Un'Goro Crater,50.93,67.97
>>Finish killing |cRXP_ENEMY_Oozes|r. Loot them for their |cRXP_LOOT_Slime Samples|r and |cRXP_LOOT_Un'Goro Soil|r
>>|cRXP_ENEMY_Primal Oozes|r |cRXP_WARN_to the south/west are the most abundant, but be careful of|r |cRXP_ENEMY_Devilsaur|r |cRXP_WARN_patrols through the area|r
.collect 11018,25 
.collect 12235,30 
.mob Muculent Ooze
.mob Glutinous Ooze
.mob Primal Ooze
step
#completewith HotSpot
.goto Un'Goro Crater,47.1,47.1,10,0
.goto Un'Goro Crater,47.7,48.3,10,0
.goto Un'Goro Crater,48.2,50.1,10,0
.goto Un'Goro Crater,48.6,49.8,20 >>The lava path on the west side of the volcano is a shortcut to the top
step
#completewith next
>>Kill |cRXP_ENEMY_Fire Elementals|r. Loot them for their |cRXP_LOOT_Ash|r
.complete 4502,1 
.mob Scorching Elemental
.mob Living Blaze
.mob Blazing Invader
step
#label HotSpot
.goto Un'Goro Crater,49.6,45.7
.use 12472 >>Climb up to the top of the volcano, then use |T132995:0|t[Krakle's Thermometer]
.complete 974,1 
step
.goto Un'Goro Crater,30.94,50.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Krakle|r
.turnin 974 >>Turn in Finding the Source
.accept 980 >>Accept The New Springs
.target Krakle
step
.loop 25,Un'Goro Crater,46.7,53.2,49.8,53.9,52.2,54.2,51.2,51.6,53.1,50.4,52.6,45.3,51.5,46.3,50.3,47.7,51.3,49.4,50.3,47.7,49.5,47.3,47.8,50.9,46.7,53.2
>>Kill |cRXP_ENEMY_Fire Elementals|r. Loot them for their |cRXP_LOOT_Ash|r
.complete 4502,1 
.mob Scorching Elemental
.mob Living Blaze
.mob Blazing Invader
step
#completewith next
.goto Un'Goro Crater,52.42,51.00,30 >> Enter the cave on the east side of the volcano
step
.goto Un'Goro Crater,51.90,49.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ringo|r
.turnin 4492 >>Turn in Lost!
.accept 4491 >>Accept A Little Help From My Friends
.target Ringo
step
.goto Un'Goro Crater,43.62,8.50
.use 11804 >>Escort |cRXP_FRIENDLY_Ringo|r to Marshal's Refuge. Use |T132805:0|t[Spraggle's Canteen] on him when he falls down
>>|cRXP_WARN_Be careful not to ride away too fast from Ringo|r
.complete 4491,1 
.target Ringo
step
.goto Un'Goro Crater,43.61,8.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Spraggle|r
.turnin 4491 >>Turn in A Little Help From My Friends
.target Spraggle Frock
step
.goto Un'Goro Crater,43.89,7.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Williden|r
.turnin 3881 >>Turn in Expedition Salvation
.target Williden Marshal
step
.goto Un'Goro Crater,43.16,6.24,30,0
.goto Un'Goro Crater,41.9,2.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_J.D. Collie|r
.turnin 4288 >> Turn in the Western Pylon
.turnin 4285 >>Turn in The Northern Pylon
.turnin 4287 >>Turn in The Eastern Pylon
.accept 4321 >>Accept Making Sense of It
.turnin 4321 >>Turn in Making Sense of It
.target J.D. Collie
step
.goto Un'Goro Crater,45.53,8.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Larion|r
.accept 4147 >>Accept Marvon's Workshop
.target Larion
step
.goto Un'Goro Crater,43.16,6.24,30,0
.goto Un'Goro Crater,45.23,5.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryfe|r
.fly Tanaris >>Fly to Tanaris
.target Gryfe
.zoneskip Tanaris
step
.goto Tanaris,50.90,27.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pestlezugg|r
.turnin 4496 >>Turn in Bungle in the Jungle
.target Alchemist Pestlezugg
step
.goto Tanaris,52.707,45.923
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Marvon Rivetseeker|r
.accept 3446 >> Accept Into the Depths
.accept 3447 >> Accept Secret of the Circle
.target Marvon Rivetseeker
.isQuestTurnedIn 3444
.dungeon ST
step
.goto Tanaris,66.989,22.354
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yeh'kinya|r
.accept 3528 >> Accept The God Hakkar
.target Yeh'kinya
.isQuestTurnedIn 4787 
.dungeon ST
step
.goto Tanaris,51.60,25.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bullkrek|r
.fly Feralas>>Fly to Feralas
.target Bullkrek Ragefist
.zoneskip Feralas
step
.goto Feralas,76.18,43.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Talo|r
.turnin 4120 >>Turn in The Strength of Corruption
.target Talo Thornhoof
step
.goto Feralas,60.07,47.44,50,0
.goto Feralas,59.59,43.45,10 >> Hug the wall outside of Dire Maul. This is to unlock a quest later
>>|cRXP_WARN_Make sure your general chat changes to "Dire Maul"|r
step
.goto Feralas,50.76,49.83,60,0
.goto Feralas,45.12,25.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gregan|r
>>|cRXP_BUY_Buy some|r |T134006:0|t[Bait] |cRXP_BUY_from him|r
.collect 11141,1,3909,1 
.target Gregan Brewspewer
step
.goto Feralas,44.60,10.19
>>Give some bait to |cRXP_ENEMY_Miblon Snarltooth|r, who's guarding the |cRXP_LOOT_Evoroot|r. Loot the |cRXP_LOOT_Evoroot|r in the Ruins
>>|cRXP_WARN_You can also get in from the backside of the building|r
.collect 11242,1,3909,1 
.unitscan Miblon Snarltooth
step
.goto Feralas,45.12,25.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gregan|r and trade in the |cRXP_LOOT_Evoroot|r
.complete 3909,1 
.target Gregan Brewspewer
step
#completewith next
.hs >>Hearth to Camp Taurajo
.use 6948
step
.goto The Barrens,45.58,59.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Byula|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Byula
step << !Mage
.goto The Barrens,44.45,59.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa|r
.fly Thunder Bluff >>Fly to Thunder Bluff
.target Omusa Thunderhorn
.zoneskip Thunder Bluff
step << Mage
.cast 3566 >>Cast |T135765:0|t[Teleport: Thunder Bluff]
.zoneskip Thunder Bluff
step << Mage
.goto Thunder Bluff,25.18,20.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thurston|r
.train 10199 >> Train your class spells
.target Thurston Xane
.xp <54,1
.xp >56,1
step << Mage
.goto Thunder Bluff,25.18,20.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thurston|r
.train 10157 >> Train your class spells
.target Thurston Xane
.xp <56,1
step
#sticky
#label BluffRunner
.goto Thunder Bluff,41.54,57.87,70,0
.goto Thunder Bluff,52.76,62.07,30,0
.goto Thunder Bluff,55.63,50.08,70,0
.goto Thunder Bluff,41.54,57.87,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bluff Runner Windstrider|r
>>|cRXP_WARN_He patrols the terraces, so you may have to look around for him|r
.accept 1000 >>Accept The New Frontier
.accept 5095 >>Accept A Call to Arms: The Plaguelands!
.target Bluff Runner Windstrider
step
.goto Thunder Bluff,45.80,64.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pala|r
.accept 3762 >>Accept Assisting Arch Druid Runetotem
.target Innkeeper Pala
step << Hunter
.goto Thunder Bluff,59.11,86.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 14290 >>Train your class spells
.target Urek Thunderhorn
.xp <54,1
.xp >56,1
step << Hunter
.goto Thunder Bluff,59.11,86.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 14305 >>Train your class spells
.target Urek Thunderhorn
.xp <56,1
step << Hunter
.goto Thunder Bluff,54.08,84.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hesuwa|r
.train 24631 >>Train your pet spells
.target Hesuwa Thunderhorn
.xp <54,1
step << Warrior
.goto Thunder Bluff,57.56,85.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ker|r
.train 11605 >>Train your class spells
.target Ker Ragetotem
.xp <54,1
.xp >56,1
step << Warrior
.goto Thunder Bluff,57.56,85.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ker|r
.train 20662 >> Train your class spells
.target Ker Ragetotem
.xp <56,1
step << Shaman
.goto Thunder Bluff,22.84,21.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 10408 >>Train your class spells
.target Tigor Skychaser
.xp <54,1
.xp >56,1
step << Shaman
.goto Thunder Bluff,22.84,21.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 10432 >>Train your class spells
.target Tigor Skychaser
.xp <56,1
step << Priest
.goto Thunder Bluff,24.56,22.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malakai|r
.train 10900 >> Train your class spells
.target Malakai Cross
.xp <54,1
.xp >56,1
step << Priest
.goto Thunder Bluff,24.56,22.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malakai|r
.train 10929 >> Train your class spells
.target Malakai Cross
.xp <56,1
step << Druid
.goto Thunder Bluff,76.46,27.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Turak|r
.train 9857 >>Train your class spells
.target Turak Runetotem
.xp <54,1
.xp >56,1
step << Druid
.goto Thunder Bluff,76.46,27.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Turak|r
.train 22829 >>Train your class spells
.target Tura
.xp <56,1
step
.goto Thunder Bluff,78.50,28.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hamuul|r
.turnin 1000 >>Turn in The New Frontier
.accept 1123 >>Accept Rabine Saturna
.turnin 3762 >>Turn in Assisting Arch Druid Runetotem
.accept 3761 >>Accept Un'Goro Soil
.target Arch Druid Hamuul Runetotem
step
.goto Thunder Bluff,77.30,22.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ghede|r
.turnin 3761 >>Turn in Un'Goro Soil
.target Ghede
step
.goto Thunder Bluff,78.40,28.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hamuul|r
.accept 3782 >>Accept Morrowgrain Research
.target Arch Druid Hamuul Runetotem
step
.goto Thunder Bluff,70.20,30.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Magatha|r
.turnin 3518 >>Turn in Delivery to Magatha
.target Magatha Grimtotem
.isOnQuest 3518
step
.goto Thunder Bluff,70.20,30.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Magatha|r
.accept 3562 >>Accept Magatha's Payment to Jediga
.target Magatha Grimtotem
.isQuestTurnedIn 3518
step
.goto Thunder Bluff,71.00,33.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bashana|r
.turnin 3782 >>Turn in Morrowgrain Research
.target Bashana Runetotem
step
.goto Thunder Bluff,47.02,49.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tal|r
.fly Ratchet>>Fly to Ratchet
.target Tal
.zoneskip Thunder Bluff,1
step
#sticky
#completewith EnterST
.subzone 1417 >> Now you should be looking for a group to Sunken Temple
.dungeon ST
step
.goto The Barrens,62.50,38.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Liv|r
.turnin 4502 >>Turn in Volcanic Activity
.turnin 4147 >>Turn in Marvon's Workshop
.target Liv Rizzlefix
step
.goto The Barrens,62.50,38.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Liv|r
.accept 4146 >>Accept Zapper Fuel
.target Liv Rizzlefix
.isQuestTurnedIn 4147
.dungeon ST
step
.goto The Barrens,65.80,43.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Islen|r
.turnin 5158 >>Turn in Seeking Spiritual Aid
.accept 5159 >>Accept Cleansed Water Returns to Felwood
.target Islen Waterseer
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 56-57 Felwood/Winterspring
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 50-60
#next 57-59 Western PL/Eastern PL
step
#completewith next
.goto The Barrens,63.74,38.66
.zone Stranglethorn Vale >> Take the boat to Stranglethorn Vale
.zoneskip Stranglethorn Vale
.dungeon ST
step
.goto Stranglethorn Vale,26.90,77.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|ttalk to |cRXP_FRIENDLY_Gringer|r
.fly Stonard>> Fly to Stonard
.target Gringer
.zoneskip Swamp of Sorrows
.dungeon ST
step
.goto Swamp of Sorrows,47.93,54.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fel'zerul|r
.accept 1445 >> Accept The Temple of Atal'Hakkar
.isQuestTurnedIn 1444
.dungeon ST
step << Warrior
.goto Swamp of Sorrows,34.287,66.134
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r
.accept 8425 >> Accept Voodoo Feathers
.target Fallen Hero of the Horde
.isQuestTurnedIn 8424
.dungeon ST
step
.goto 1415,56.33,76.28
.subzone 1477 >> Travel to Sunken Temple
.dungeon ST
step
#completewith next
>>Kill |cRXP_ENEMY_Atal'ai Trolls|r in the Sunken Temple. Loot them for their |cRXP_LOOT_Fetish of Hakkar|r
>>|cRXP_WARN_The trolls outside as well as inside Sunken Temple can drop these|r
.complete 1445,1 
.isOnQuest 1445
.dungeon ST
step
#label EnterST
.goto 1415,56.33,76.28,40,0
.goto 1415,56.46,75.54,20,0
.goto 1415,56.83,75.86,20,0
.goto 1415,56.94,76.03,15,0
.goto 1415,57.06,75.58,20,0
.goto 1415,56.76,75.35,15,0
.goto 1415,56.809,75.151
.subzone 1477,2 >> Zone into Sunken Temple
.dungeon ST
step
#sticky
>>Kill |cRXP_ENEMY_Atal'ai Trolls|r in the Sunken Temple. Loot them for their |cRXP_LOOT_Fetish of Hakkar|r
.complete 1445,1 
.isOnQuest 1445
.dungeon ST
step
#sticky
>>Kill |cRXP_ENEMY_Deep Lurkers|r, |cRXP_ENEMY_Murk Worms|r and |cRXP_ENEMY_Saturated Oozes|r. Loot them for their |cRXP_LOOT_Atal'ai Haze|r
>>|cRXP_ENEMY_Take a right down the stairs at the beginning of the instance to find these mobs|r
.complete 4146,1 
.isOnQuest 4146
.dungeon ST
step << Druid
#completewith Altar
>>Kill |cRXP_ENEMY_Atal'alarion|r. Loot him for the |cRXP_LOOT_Putrid Vine|r
>>|cRXP_ENEMY_Atal'alarion|r |cRXP_WARN_is on the lower level of Sunken Temple and is summoned by clicking all |cRXP_PICK_Atal'ai Statues|r on the platforms|r
.complete 9053,1 
.isOnQuest 9053
.dungeon ST
step 
#completewith next
>>Click on the |cRXP_PICK_Altar of Hakkar|r
>>|cRXP_WARN_The |cRXP_PICK_Altar of Hakkar|r is located on the lower level of Sunken Temple|r
.turnin 3446 >> Turn in Into the Depths
.isOnQuest 3446
.dungeon ST
step 
>>Click on the |cRXP_PICK_Idol of Hakkar|r
>>|cRXP_WARN_Clicking all of the |cRXP_PICK_Atal'ai Statues|r on the platforms will activate the|r |cRXP_PICK_Idol of Hakkar|r
>>|cRXP_WARN_The |cRXP_PICK_Idol of Hakkar|r is located on the lower level of Sunken Temple|r
.turnin 3447 >> Turn in Secret of the Circle
.isOnQuest 3447
.dungeon ST
step 
#label Altar
>>Click on the |cRXP_PICK_Altar of Hakkar|r
>>|cRXP_WARN_The |cRXP_PICK_Altar of Hakkar|r is located on the lower level of Sunken Temple|r
.turnin 3446 >> Turn in Into the Depths
.isOnQuest 3446
.dungeon ST
step << Druid
>>Kill |cRXP_ENEMY_Atal'alarion|r. Loot him for the |cRXP_LOOT_Putrid Vine|r
>>|cRXP_ENEMY_Atal'alarion|r |cRXP_WARN_is on the lower level of Sunken Temple and is summoned by clicking all |cRXP_PICK_Atal'ai Statues|r on the platforms|r
.complete 9053,1 
.isOnQuest 9053
.dungeon ST
step << Shaman/Warrior/Warlock
>>Kill |cRXP_ENEMY_Gasher|r and |cRXP_ENEMY_Zul'Lor|r. Loot them for their |cRXP_LOOT_Amber Voodoo Feathers|r
>>Kill |cRXP_ENEMY_Mijan|r and |cRXP_ENEMY_Hukku|r. Loot them for their |cRXP_LOOT_Blue Voodoo Feathers|r
>>Kill |cRXP_ENEMY_Zolo|r and |cRXP_ENEMY_Loro|r. Loot them for their |cRXP_LOOT_Green Voodoo Feathers|r
>>|cRXP_WARN_This quest is completed on the upper level of Sunken Temple|r
.complete 8413,1 << Shaman 
.complete 8413,2 << Shaman 
.complete 8413,3 << Shaman 
.complete 8425,1 << Warrior 
.complete 8425,2 << Warrior 
.complete 8425,3 << Warrior 
.complete 8422,1 << Warlock 
.complete 8422,2 << Warlock 
.complete 8422,3 << Warlock 
.isOnQuest 8413 << Shaman
.isOnQuest 8425 << Warrior
.isOnQuest 8422 << Warlock
.dungeon ST
step
>>|cRXP_WARN_Use the|r |T132834:0|t[Egg of Hakkar] |cRXP_WARN_while next to the Dragonflayer Skeleton, then complete the event|r
>>Kill the minions of |cRXP_ENEMY_Hakkar|r until the |cRXP_ENEMY_Avatar of Hakkar|r joins
>>Kill the |cRXP_ENEMY_Avatar of Hakkar|r. Loot it for the |T136148:0|t[|cRXP_LOOT_Essence of Hakkar|r]
>>|cRXP_WARN_Use the|r |T136148:0|t[|cRXP_LOOT_Essence of Hakkar|r] |cRXP_WARN_to fill the|r |T132834:0|t[Egg of Hakkar]
.collect 10663,1,3528,1 
.disablecheckbox
.complete 3528,1 
.use 10465 
.use 10663 
.isOnQuest 3528
.dungeon ST
step
>>Kill |cRXP_ENEMY_Jammal'an the Prophet|r. Loot him for his |cRXP_LOOT_Head|r
>>|cRXP_WARN_You must kill the 6 |cRXP_ENEMY_Trolls|r on the upper platforms to gain access to|r |cRXP_ENEMY_Jammal'an the Prophet|r
.complete 1446,1 
.isOnQuest 1446
.dungeon ST
step << Hunter/Mage/Priest/Rogue
>>Kill |cRXP_ENEMY_Morphaz|r. Loot it for the |cRXP_LOOT_Tooth of Morphaz|r << Hunter
>>Kill |cRXP_ENEMY_Morphaz|r. Loot it for the |cRXP_LOOT_Arcane Shard|r << Mage
>>Kill |cRXP_ENEMY_Morphaz|r. Loot it for the |cRXP_LOOT_Blood of Morphaz|r << Priest
>>Kill |cRXP_ENEMY_Morphaz|r. Loot it for the |cRXP_LOOT_Azure Key|r << Rogue
.complete 8232,1 << Hunter 
.complete 8253,1 << Mage 
.complete 8257,1 << Priest 
.complete 8236,1 << Rogue 
.isOnQuest 8232 << Hunter
.isOnQuest 8253 << Mage
.isOnQuest 8257 << Priest
.isOnQuest 8236 << Rogue
.dungeon ST
step
>>Kill the |cRXP_ENEMY_Shade of Eranikus|r. Loot him for the |T135229:0|t[|cRXP_LOOT_Essence of Eranikus|r]
>>|cRXP_WARN_Use the |T135229:0|t[|cRXP_LOOT_Essence of Eranikus|r] to start the quest|r
>>|cRXP_WARN_Ensure you have killed all |cRXP_ENEMY_Dragonkin|r mobs on the upper level before engaging the |cRXP_ENEMY_Shade of Eranikus|r otherwise they will all agro onto you|r
.collect 10454,1,3373,1 
.accept 3373 >> Accept The Essence of Eranikus
.dungeon ST
step
>>Click the |cRXP_PICK_Essence Font|r
.turnin 3373 >> Turn in The Essence of Eranikus
.isOnQuest 3373
.dungeon ST
step
.zone Swamp of Sorrows >> Leave the Sunken Temple Instance
step
.goto Swamp of Sorrows,47.93,54.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fel'zerul|r
.turnin 1445 >> Turn in The Temple of Atal'Hakkar
.isQuestComplete 1445
.dungeon ST
step << Warrior
.goto Swamp of Sorrows,34.287,66.134
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r
>>|cRXP_WARN_It is strongly advised you choose the|r |T132788:0|t[|cFF0070FFDiamond Flask|r] |cRXP_WARN_as your reward. Although the other rewards are also very good, you will not ever replace the|r |T132788:0|t[|cFF0070FFDiamond Flask|r]
.turnin 8425 >> Turn in Voodoo Feathers
.target Fallen Hero of the Horde
.isQuestComplete 842
.dungeon ST
step
.hs >>Hearth to Camp Taurajo
.use 6948
.dungeon ST
step
#completewith next
.goto The Barrens,44.45,59.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa|r
.fly Un'Goro Crater>>Fly to Un'Goro Crater
.target Omusa Thunderhorn
.zoneskip Un'Goro Crater
.isQuestComplete 4145
.dungeon ST
step
.goto Un'Goro Crater,45.53,8.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Larion|r
.turnin 4145 >>Turn in Zapper Fuel
.target Larion
.isQuestComplete 4145
.dungeon ST
step << Druid
#completewith next
.goto The Barrens,44.45,59.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa|r
.fly Un'Goro Crater>>Fly to Un'Goro Crater
.target Omusa Thunderhorn
.zoneskip Un'Goro Crater
.isQuestComplete 9053
.dungeon ST
step << Druid
.goto Un'Goro Crater,71.639,75.960
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torwa Pathfinder|r
.turnin 9053 >> Turn in A Better Ingredient
.target Torwa Pathfinder
.isQuestComplete 9053
.dungeon ST
step
.goto The Barrens,44.45,59.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa|r
.fly Tanaris >>Fly to Tanaris
.target Omusa Thunderhorn
.subzoneskip 378,1
.isQuestComplete 3528
.dungeon ST
step
#completewith next
.goto Un'Goro Crater,45.23,5.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryfe|r
.fly Tanaris >>Fly to Tanaris
.target Gryfe
.subzoneskip 541,1
.isQuestComplete 3528
.dungeon ST
step
.goto Tanaris,66.989,22.354
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yeh'kinya|r
.turnin 3528 >> Turn in The God Hakkar
.target Yeh'kinya
.isQuestComplete 3528
.dungeon ST
step
.goto Un'Goro Crater,45.23,5.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryfe|r
.fly Azshara >> Fly to Azshara
.target Gryfe
.subzoneskip 541,1
.dungeon ST
step
.goto Tanaris,51.60,25.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bullkrek|r
.fly Azshara >> Fly to Azshara
.target Bullkrek Ragefist
.zoneskip Tanaris,1
.dungeon ST
step
.goto The Barrens,44.45,59.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa|r
.fly Azshara >> Fly to Azshara
.target Omusa Thunderhorn
.subzoneskip 378,1
step
.goto Azshara,22.50,51.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jediga|r
.turnin 3562 >>Turn in Magatha's Payment to Jediga
.target Jediga
step
.goto Azshara,22.50,51.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jediga|r
.turnin 3563 >>Turn in Jes'rimon's Payment to Jediga
.target Jediga
step
.goto Azshara,22.50,51.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jediga|r
.accept 3542 >>Accept Delivery to Andron Gant
.target Jediga
step << Hunter/Priest
.goto Azshara,42.400,42.619
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ogtinc|r
.turnin 8232 >> Turn in The Green Drake << Hunter
.turnin 8257 >> Turn in Blood of Morphaz << Priest
.target Ogtinc
.isQuestComplete 8232 << Hunter
.isQuestComplete 8257 << Priest
.dungeon ST
step << Mage/Rogue
#completewith next
.goto Azshara,28.113,50.088
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sanath Lim-yo|r
>>|cRXP_WARN_This will teleport you to the top of the mountain|r
.turnin 3503 >> Turn in Meeting with the Master
.target Sanath Lim-yo
.isQuestComplete 8253 << Mage
.isQuestComplete 8236 << Rogue
.dungeon ST
step << Mage/Rogue
.goto Azshara,29.248,40.210
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Archamge Xylem|r atop the Tower
.turnin 8253 >> Turn in Destroy Morphaz << Mage
.turnin 8236 >> Turn in The Azure Key << Rogue
.target Archamge Xylem
.dungeon ST
.isQuestComplete 8253 << Mage
.isQuestComplete 8236 << Rogue
step << Mage/Rogue
.goto Azshara,26.466,46.271
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nyrill|r
>>|cRXP_WARN_This will teleport you back down|r
.turnin 3421 >> Turn in Return Trip
.timer 8,Return Trip RP
.target Nyrill
.dungeon ST
.isQuestTurnedIn 8253 << Mage
.isQuestTurnedIn 8236 << Rogue
step
.goto Azshara,22.00,49.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kroum|r
.fly Felwood>>Fly to Felwood
.target Kroum
.zoneskip Felwood
step
.goto Felwood,34.30,52.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Winna|r
.accept 4506 >>Accept Corrupted Sabers
.target Winna Hazzard
step
.goto Felwood,34.80,52.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Trull|r
.accept 4521 >>Accept Wild Guardians
.target Trull Failbane
step << Warlock
.goto Felwood,41.52,44.99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Impsy|r
.turnin 8422 >> Turn in Trolls of a Feather
.target Impsy
.isQuestComplete 8422
.dungeon ST
step
#completewith next
.subzone 2479 >> Travel to Emerald Sanctuary
step
.goto Felwood,51.20,82.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greta|r
.turnin 5159 >>Turn in Cleansed Water Returns to Felwood
.target Greta Mosshoof
step
.goto Felwood,51.20,82.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greta|r
.accept 5165 >>Accept Dousing the Flames of Protection
.target Greta Mosshoof
.group
step
.goto Felwood,46.70,83.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maybess|r
>>|cRXP_WARN_Select the option:|r "I need a Cenarion beacon"
.accept 5887 >>Accept Salve via Hunting
.collect 11511,1,5882,1 
.target Maybess Riverbreeze
step
#completewith eStart
.goto Felwood,35.367,58.376
.subzone 1770 >> Travel to Shadow Hold within Jaedenar
.group
step
#sticky
#label SoulShards
>>Collect |cRXP_LOOT_Corrupted Soul Shards|r. All mobs in Felwood have a chance of dropping these
.complete 5887,1 
step
#completewith next
>>Click the four |cRXP_PICK_Braziers|r on the ground
.complete 5165,1 
.goto Felwood,36.267,56.297
.complete 5165,4 
.goto Felwood,36.484,55.183
.complete 5165,3 
.goto Felwood,36.732,53.262
.complete 5165,2 
.goto Felwood,37.677,52.685
.group 2
step
>>Kill |cRXP_ENEMY_Jaedenar Enforcers|r, |cRXP_ENEMY_Jaedenar Darkweavers|r, |cRXP_ENEMY_Jaedenar Warlocks|r and |cRXP_ENEMY_Jaedenar Legionnaires|r. Loot them for a |T134235:0|t[|cRXP_LOOT_Blood Red Key|r]
>>|cRXP_WARN_Use the|r |T134235:0|t[|cRXP_LOOT_Blood Red Key|r] |cRXP_WARN_to start the quest|r
>>|cRXP_WARN_This will begin an escort quest. Start this escort even if you still need to Extinguish Braziers|r
.collect 13140,1,5202 
.accept 5202 >> Accept A Strange Red Key
.use 13140 
.mob Jaedenar Enforcer
.mob Jaedenar Darkweaver
.mob Jaedenar Warlock
.mob Jaedenar Legionnaire
.group 2
step
#label eStart
.goto Felwood,36.207,55.465
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Captured Arko'narin|r
.turnin 5202 >> Turn in A Strange Red Key
.accept 5203 >> Accept Rescue From Jaedenar
.target Captured Arko'narin
.group 2
step
#completewith next
>>Click the four |cRXP_PICK_Braziers|r on the ground
.complete 5165,1 
.goto Felwood,36.267,56.297
.complete 5165,4 
.goto Felwood,36.484,55.183
.complete 5165,3 
.goto Felwood,36.732,53.262
.complete 5165,2 
.goto Felwood,37.677,52.685
.group 2
step
.goto Felwood,35.44,59.01
>>Escort |cRXP_FRIENDLY_Arko'narin|r through Shadow Hold. After |cRXP_FRIENDLY_Arko'narin|r equips her armor, kill the 3 |cRXP_ENEMY_Felguard|r that spawn
>>|cRXP_FRIENDLY_Arko'narin|r |cRXP_WARN_has 6,000 HP; let her tank mobs. Extinguish the Braziers within Shadow Hold as you progress towards the entrance|r
>>Once |cRXP_FRIENDLY_Arko'narin|r leaves the cave, the |cRXP_ENEMY_Spirit of Trey Lightforge|r will spawn. Kill him
>>|cRXP_WARN_Be careful of adds. He has a 500 damage shock spell and hits very hard. Use all of your offensive cooldowns here, if you have them|r
.complete 5203,1 
.group 2
step
>>Click the four |cRXP_PICK_Braziers|r on the ground
.complete 5165,1 
.goto Felwood,36.267,56.297
.complete 5165,4 
.goto Felwood,36.484,55.183
.complete 5165,3 
.goto Felwood,36.732,53.262
.complete 5165,2 
.goto Felwood,37.677,52.685
.group 2
step
.goto Felwood,36.02,66.99,70,0
.goto Felwood,32.40,66.60
.use 12565 >>Use |T132599:0|t[Winna's Kitten Carrier] at the corrupted moonwell
step
#completewith next
.goto Felwood,37.37,49.83,40,0
.goto Felwood,35.45,50.10,40,0
.goto Felwood,34.57,52.12
.subzone 1997 >> Travel to Bloodvenom Post
step
.goto Felwood,34.20,52.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tApproach |cRXP_FRIENDLY_Winna|r, then talk to |cRXP_FRIENDLY_Winna|r
.turnin 4506 >>Turn in Corrupted Sabers
.target Winna Hazzard
.skipgossip
step
#completewith next
.goto Felwood,64.70,8.10,70 >>Travel to the the Timbermaw Hold Entrance
step
.goto Felwood,64.70,8.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nafien|r
.accept 8461 >>Accept Deadwood of the North
.target Nafien
step
#completewith next
.goto Felwood,62.68,8.06,0
>>Kill |cRXP_ENEMY_Deadwood Den Watchers|r, |cRXP_ENEMY_Deadwood Avengers|r ann |cRXP_ENEMY_Deadwood Shamans|r
>>|cRXP_WARN_Kill|r |cRXP_ENEMY_Deadwood Avengers|r |cRXP_WARN_first. If you multi-pull it will enrage if any furbolgs die nearby|r
.complete 8461,1 
.complete 8461,2 
.complete 8461,3 
.mob Deadwood Den Watcher
.mob Deadwood Shaman
.mob Deadwood Avenger
step
.goto Felwood,60.20,5.90
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Deadwood Cauldron|r
.turnin 5084 >>Turn in Falling to Corruption
.accept 5085 >>Accept Mystery Goo
step
.goto Felwood,61.67,7.23,50,0
.goto Felwood,62.68,8.39,50,0
.goto Felwood,62.55,10.49,50,0
.goto Felwood,63.19,13.01,50,0
.goto Felwood,61.67,7.23,50,0
.goto Felwood,62.68,8.39,50,0
.goto Felwood,62.55,10.49,50,0
.goto Felwood,63.19,13.01
>>Kill |cRXP_ENEMY_Deadwood Den Watchers|r, |cRXP_ENEMY_Deadwood Avengers|r ann |cRXP_ENEMY_Deadwood Shamans|r
>>|cRXP_WARN_Kill|r |cRXP_ENEMY_Deadwood Avengers|r |cRXP_WARN_first. If you multi-pull it will enrage if any furbolgs die nearby|r
.complete 8461,1 
.complete 8461,2 
.complete 8461,3 
.mob Deadwood Den Watcher
.mob Deadwood Shaman
.mob Deadwood Avenger
step
.goto Felwood,64.70,8.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nafien|r
.turnin 8461 >>Turn in Deadwood of the North
.accept 8465 >>Accept Speak to Salfa
.target Nafien
step
#completewith next
.goto Felwood,65.16,7.88,40,0
.goto Felwood,64.67,3.14,40,0
.goto Felwood,66.40,2.95,40,0
.goto Felwood,68.24,5.60,40,0
.goto Felwood,68.73,6.38
.zone Winterspring >>Travel through Timbermaw Hold to Winterspring
step
.goto Felwood,68.30,6.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Salfa|r
.turnin 8465 >>Turn in Speak to Salfa
.accept 8464 >>Accept Winterfall Activity
.target Salfa
step
.goto Winterspring,31.30,45.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donova|r
.turnin 980 >>Turn in The New Springs
.accept 4842 >>Accept Strange Sources
.turnin 3909 >>Turn in The Videre Elixir 
.accept 3912 >>Accept Meet at the Grave 
.turnin 5085 >>Turn in Mystery Goo
.accept 5086 >>Accept Toxic Horrors
.target Donova Snowden









step
#completewith Ursius
>>On your way to Everlook, kill |cRXP_ENEMY_Ragged Owlbeasts|r
.complete 4521,2 
.mob Ragged Owlbeast
step
.goto Winterspring,61.36,38.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vizzie|r
.home >>Set your Hearthstone to Everlook
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Vizzie
step
.goto Winterspring,60.88,37.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umi|r
.accept 3783 >>Accept Are We There, Yeti?
.target Umi Rumplesnicker
step
.loop 25,Winterspring,57.8,34.6,56.6,32.4,56.0,28.6,58.8,27.4,60.6,29.8,59.6,31.4,60.6,33.6,58.6,33.2,57.8,34.6
>>Kill |cRXP_ENEMY_Ragged Owlbeasts|r
.complete 4521,2 
.mob Ragged Owlbeast
step
#completewith ROwlbeasts
>>Kill all types of |cRXP_ENEMY_Ice Thistle Yetis|r. Loot them for their |cRXP_LOOT_Fur|r
>>|cRXP_WARN_Don't focus on this; you can finish it later|r
.complete 3783,1 
.mob Rogue Ice Thistle
.mob Ice Thistle Yeti
.mob Ice Thistle Patriarch
.mob Ice Thistle Matriarch
step
#label ROwlbeasts
.goto Winterspring,60.58,29.76,50,0
.goto Winterspring,58.82,27.41,70,0
.goto Winterspring,56.06,27.83,70,0
.goto Winterspring,55.97,30.25,70,0
.goto Winterspring,55.10,32.16,70,0
.goto Winterspring,60.58,29.76,50,0
.goto Winterspring,58.82,27.41
>>Kill |cRXP_ENEMY_Raging Owlbeasts|r
.complete 4521,1 
.mob Raging Owlbeast
step
.loop 25,Winterspring,66.5,41.7,64.9,40.2,65.9,43.6,66.2,45.8,67.6,45.6,67.6,43.8,67.2,43.0,67.6,41.9,68.4,41.5,69.00,41.3,69.5,40.0,69.8,41.8,70.1,42.0,70.3,40.8,71.3,40.8,71.8,39.8,70.5,38.3,71.8,39.8,71.3,40.8,70.3,40.8,69.5,40.0,69.00,41.3,68.4,41.5,66.5,41.7
>>Kill all types of |cRXP_ENEMY_Ice Thistle Yetis|r. Loot them for their |cRXP_LOOT_Fur|r
.complete 3783,1 
.mob Rogue Ice Thistle
.mob Ice Thistle Yeti
.mob Ice Thistle Patriarch
.mob Ice Thistle Matriarch
step << Shaman
#completewith next
.hs >>Hearth or Astrall Recall to Everlook
step
.goto Winterspring,60.88,37.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umi|r
.turnin 3783 >>Turn in Are We There, Yeti?
.target Umi Rumplesnicker
step
.goto Winterspring,61.36,38.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vizzie|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Vizzie
step
.goto Winterspring,60.47,36.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yugrek|r
.fly Felwood>>Fly to Felwood
.target Yugrek
.zoneskip Felwood
step
.goto Felwood,34.70,52.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Trull|r
.turnin 4521 >>Turn in Wild Guardians
.accept 4741 >>Accept Wild Guardians
.target Trull Failbane
step 
.goto Felwood,34.42,53.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brakkar|r
.fly Tanaris>>Fly to Tanaris
.target Brakkar
.zoneskip Tanaris
step
.goto Tanaris,53.90,23.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gaeriyan|r
.turnin 3912 >>Turn in Meet at the Grave 
.accept 3913 >>Accept A Grave Situation 
.target Gaeriyan
step
.goto Tanaris,53.80,29.10
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick |cRXP_PICK_A Conspicuous Gravestone|r
.turnin 3913 >>Turn in A Grave Situation 
.accept 3914 >>Accept Linken's Sword 
step
.goto Tanaris,51.60,25.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bullkrek|r
.fly Un'Goro Crater >>Fly to Un'Goro Crater
.target Bullkrek Ragefist
.zoneskip Un'Goro Crater
step
.goto Tanaris,13.10,6.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Linken|r
.turnin 3914 >>Turn in Linken's Sword 
.accept 3941 >>Accept A Gnome's Assistance 
.target Linken
step
.goto Tanaris,11.60,3.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_J.D. Collie|r
.turnin 3941 >>Turn in A Gnome's Assistance 
.accept 3942 >>Accept Linken's Memory 
.target J.D. Collie
step << Druid
#completewith DruidTraining9
.cast 18960 >>Cast |T135758:0|t[Teleport: Moonglade]
.zoneskip Moonglade
step << Druid
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 9857 >>Train your class spells
.target Loganaar
.xp <54,1
.xp >56,1
step << Druid
#label DruidTraining9
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 22829 >>Train your class spells
.target Loganaar
.xp <56,1
step
#completewith next
.hs >>Hearth to Winterspring
.use 6948
.zoneskip Winterspring
step
.goto Winterspring,61.36,38.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vizzie|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Vizzie
step
.goto Winterspring,61.34,38.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gregor|r
.accept 6029 >>Accept The Everlook Report
.accept 6030 >>Accept Duke Nicholas Zverenhoff
.accept 5601 >>Accept Sister Pamela
.target Gregor Greystone
step
.loop 25,Winterspring,63.6,22.6,63.4,20.8,65.2,19.6,63.6,16.2,65.2,19.6,66.0,18.6,66.6,21.4,66.8,24.6,65.4,22.6,63.6,22.6
>>Kill |cRXP_ENEMY_Moontouched Owlbeasts|r
>>|cRXP_WARN_Their moonfire hits fairly hard, and their rejuvenation is strong|r
.complete 4741,1 
.mob Moontouched Owlbeast
step
.goto Winterspring,60.09,73.34
>>Head to the border of Darkwhisper Gorge
.complete 4842,1 
step
#completewith next
.subzone 2255 >> Travel to Everlook
step
.goto Winterspring,60.47,36.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yugrek|r
.fly Felwood>>Fly to Felwood
.target Yugrek
.zoneskip Felwood
step
.goto Felwood,34.70,52.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Trull|r
.turnin 4741 >>Turn in Wild Guardians
.accept 4721 >>Accept Wild Guardians
.target Trull Failbane
step
#requires SoulShards
.goto Felwood,46.70,83.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maybess|r
.turnin 5887 >>Turn in Salve via Hunting
.target Maybess Riverbreeze
step
#completewith LeaveFelwood
+From this point on you may cleanse |cRXP_PICK_Corrupted Songflowers|r on the ground. After cleansing it, clicking on the |cRXP_PICK_Corrupted Songflower|r will provide a 5% crit buff as well as increasing all attributes by 15 for 1 hour
>>This requires you to use two |T132804:0|t[Cenarion Plant Salves]
step
.goto Felwood,51.20,82.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greta|r
.turnin 5165 >>Turn in Dousing the Flames of Protection
.accept 5242 >>Accept A Final Blow
.target Greta Mosshoof
.isQuestComplete 5165
.group
step
.goto Felwood,51.20,82.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greta|r
.accept 5242 >>Accept A Final Blow
.target Greta Mosshoof
.isQuestTurnedIn 5165
.group
step
.goto Felwood,51.30,82.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jessir|r
.turnin 5203 >>Turn in Rescue From Jaedenar
.accept 5204 >>Accept Retribution of the Light
.target Jessir Moonbow
.isQuestComplete 5203
.group
step
.goto Felwood,51.30,82.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jessir|r
.accept 5204 >>Accept Retribution of the Light
.target Jessir Moonbow
.isQuestTurnedIn 5203
.group
step
.goto Felwood,51.30,81.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Eridan|r
.turnin 3942 >>Turn in Linken's Memory 
.accept 4084 >>Accept Silver Heart 
.target Eridan Bluewind
step
#completewith ShadowLordFelidan
.goto Felwood,35.367,58.376
.subzone 1770 >> Travel to Shadow Hold within Jaedenar
.group
step
#completewith ShadowLordFelidan
>>Kill |cRXP_ENEMY_Felpaw wolves|r and |cRXP_ENEMY_Angerclaw bears|r. Loot them for their |cRXP_LOOT_Claws|r
>>Kill |cRXP_ENEMY_Irontree ents and treants|r. Loot them for their |cRXP_LOOT_Heart|r
.complete 4084,1 
.mob Irontree Stomper
.mob Irontree Wanderer
.mob Angerclaw Mauler
.mob Angerclaw Grizzly
.mob Angerclaw Bear
.mob Felpaw Wolf
.mob Felpaw Scavenger
.mob Felpaw Ravager
step
.goto Felwood,35.39,58.74,30,0
.goto Felwood,38.30,50.50
>>Go deep into Shadow Hold, then kill |cRXP_ENEMY_Rakaiah|r
.complete 5204,1 
.unitscan Rakaiah
.group 2
step
.goto Felwood,38.50,50.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Remains of Trey Lightforge|r
>>|cRXP_WARN_Mobs around the remains can bug by keeping you in combat, despite not attacking you|r
.turnin 5204 >>Turn in Retribution of the Light
.accept 5385 >>Accept The Remains of Trey Lightforge
.target Remains of Trey Lightforge
.isQuestTurnedIn 5203
.group
step
#label ShadowLordFelidan
.goto Felwood,38.90,46.80
>>Kill |cRXP_ENEMY_Shadow Lord Fel'dan|r, |cRXP_ENEMY_Moora|r and |cRXP_ENEMY_Salia|r. Loot |cRXP_ENEMY_Shadow Lord Fel'dan|r for his |cRXP_LOOT_Head|r
>>|cRXP_WARN_Linger outside of the room and use line of sight (LOS) to avoid Fel'dan's shadowbolts. When he starts casting, hide out of sight. As soon as his cast ends/fails, step into sight so he starts casting again/doesn't get too close to the LOS point|r
.complete 5242,1 
.complete 5242,2 
.complete 5242,3 
.mob Moora
.mob Salia
.unitscan Shadow Lord Felidan
.group 2
step
#completewith next
.goto Felwood,38.72,46.77
.goto Felwood,49.57,30.76,30 >> Perform a logout skip to teleport out of Shadow Hold
.link https://youtu.be/SWBtPqm5M0Q?t=128 >> |cRXP_WARN_CLICK HERE for an example|r
step
.loop 25,Felwood,49.6,30.0,46.4,24.6,49.2,19.8,53.0,20.4,52.0,24.8,49.6,30.0
>>Kill |cRXP_ENEMY_Irontree Treants|r. Loot them for their |cRXP_LOOT_Hearts|r
.complete 4084,2 
.mob Irontree Stomper
.mob Irontree Wanderer
step
.goto Felwood,50.87,23.72,50,0
.goto Felwood,49.44,23.39,50,0
.goto Felwood,48.86,24.80,50,0
.goto Felwood,49.76,27.29,50,0
.goto Felwood,50.87,23.72,50,0
.goto Felwood,49.44,23.39
>>Kill |cRXP_ENEMY_Toxic Horrors|r. Loot them for their |cRXP_LOOT_Droplets|r
.complete 5086,1 
.mob Toxic Horror
step
.goto Felwood,53.75,28.06,90,0
.goto Felwood,58.03,17.83,90,0
.goto Felwood,63.27,19.15
>>Kill |cRXP_ENEMY_Felpaw wolves|r and |cRXP_ENEMY_Angerclaw bears|r. Loot them for their |cRXP_LOOT_Claws|r
.complete 4084,1 
.mob Angerclaw Mauler
.mob Angerclaw Grizzly
.mob Angerclaw Bear
.mob Felpaw Wolf
.mob Felpaw Scavenger
.mob Felpaw Ravager
step
#label LeaveFelwood
#completewith next
.goto Felwood,65.16,7.88,40,0
.goto Felwood,64.67,3.14,40,0
.goto Felwood,66.40,2.95,40,0
.goto Felwood,68.24,5.60,40,0
.goto Felwood,68.73,6.38
.zone Winterspring >>Travel through Timbermaw Hold to Winterspring
step
.goto Winterspring,31.30,45.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donova|r
.turnin 4842 >>Turn in Strange Sources
.turnin 5086 >>Turn in Toxic Horrors
.accept 5087 >>Accept Winterfall Runners
.target Donova Snowden
step
.goto Winterspring,67.96,37.54,40,0
.goto Winterspring,66.16,33.66,40,0
.goto Winterspring,64.37,32.06,40,0
.goto Winterspring,62.41,25.53,40,0
.goto Winterspring,61.97,23.00,40,0
.goto Winterspring,57.30,28.05,40,0
.goto Winterspring,54.07,30.98,40,0
.goto Winterspring,53.49,34.13,40,0
.goto Winterspring,47.81,39.23,40,0
.goto Winterspring,39.36,41.28,40,0
.goto Winterspring,30.12,42.57,40,0
.goto Winterspring,28.01,34.60
>>Kill |cRXP_ENEMY_Winterfall Runners|r
>>|cRXP_WARN_They patrol the road between the Timbermaw Hold tunnel and Winterfall Village northeast of Everlook. Alternatively, run back through the cave to Felwood, and kill the Runner located at the cauldron in Felpaw Village|r
.complete 5087,1 
.unitscan Winterfall Runner
.zone Felwood
step
.goto Felwood,60.20,5.90
>>Kill |cRXP_ENEMY_Winterfall Runners|r
>>|cRXP_WARN_The Runner's located at the cauldron in the northwest of Felpaw Village|r
.complete 5087,1 
.unitscan Winterfall Runner
step
.goto Winterspring,31.30,45.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donova|r
.turnin 5087 >>Turn in Winterfall Runners
.target Donova Snowden
step
.goto Winterspring,31.30,45.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donova|r
.accept 5121 >>Accept High Chief Winterfall
.target Donova Snowden
.group
step << !Mage
.goto Winterspring,60.47,36.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yugrek|r
.fly Felwood>>Fly to Felwood
.target Yugrek
.zoneskip Felwood
step << Mage
#completewith next
.cast 3567 >>Cast |T135759:0|t[Teleport: Orgrimmar]
.zoneskip Orgrimmar
step << Mage
.goto Orgrimmar,45.13,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Splintertree Post >>Fly to Splintertree Post
.target Doras
.zoneskip Ashenvale
step
#completewith next
.subzone 2479 >> Travel to Emerald Sanctuary
step
.goto Felwood,51.35,81.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Eridan|r
.turnin 4084 >>Turn in Silver Heart 
.target Eridan Bluewind
step
.goto Felwood,51.23,82.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greta|r
.turnin 5242 >>Turn in A Final Blow
.target Greta Mosshoof
.isQuestComplete 5242
.group
step
.goto Felwood,51.35,82.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jessir|r
.turnin 5385 >>Turn in The Remains of Trey Lightforge
.target Jessir Moonbow
.isQuestTurnedIn 5204
.group
step << !Mage
#completewith next
.subzone 431 >> Travel to Splintertree Post
step << !Mage
.goto Ashenvale,73.18,61.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Vhulgra|r
.fly Orgrimmar>>Fly to Orgrimmar
.target Vhulgra
.zoneskip Orgrimmar
step << Mage
.cast 3567 >>Cast |T135759:0|t[Teleport: Orgrimmar]
.zoneskip Orgrimmar
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 10157 >> Train your class spells
.target Pephredo
.xp <56,1
.xp >58,1
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 10054 >> Train your class spells
.target Pephredo
.xp <58,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 10929 >> Train your class spells
.target Ur'kyo
.xp <56,1
.xp >58,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 10947 >> Train your class spells
.target Ur'kyo
.xp <58,1
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 10432 >> Train your class spells
.target Kardris Dreamseeker
.xp <56,1
.xp >58,1
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 10473 >> Train your class spells
.target Kardris Dreamseeker
.xp <58,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 20662 >> Train your class spells
.target Grezz Ragefist
.xp <56,1
.xp >58,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 11597 >> Train your class spells
.target Grezz Ragefist
.xp <58,1
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 11689 >> Train your class spells
.target Mirket
.xp <56,1
.xp >58,1
step << Warlock
.goto Orgrimmar,48.62,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirket|r
.train 11713 >> Train your class spells
.target Mirket
.xp <58,1
step << Warlock
.goto Orgrimmar,47.55,46.77
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kurgul|r
.vendor >>Upgrade your pet's abilities
.target Kurgul
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 11300 >> Train your class spells
.target Ormok
.xp <56,1
.xp >58,1
step << Rogue
.goto Orgrimmar,43.90,54.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 11305 >> Train your class spells
.target Ormok
.xp <58,1
step << Rogue
.goto Orgrimmar,42.09,49.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rekkul|r
.vendor >>Buy more |cRXP_BUY_Flash Powder and poisons|r if necessary
.target Rekkul
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14305 >> Train your class spells
.target Ormak Grimshot
.xp <56,1
.xp >58,1
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14322 >> Train your class spells
.target Ormak Grimshot
.xp <58,1
step
.goto Orgrimmar,55.60,34.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jes'rimon|r
.turnin 4300 >>Turn in Bone-Bladed Weapons
.target Jes'rimon
.isQuestComplete 4300
step << Mage
#completewith next
.cast 3563 >>Cast |T135766:0|t[Teleport: Undercity]
.zoneskip Undercity
step << Mage
.goto Undercity,82.79,15.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hannah Akeley|r
.vendor >> |cRXP_BUY_Buy at least two|r |T134419:0|t[Rune of Teleportation]
.collect 17031,2 
.target Hannah Akeley
step << !Mage
#completewith next
.zone Durotar >> Leave Orgrimmar
.zoneskip Durotar
step << !Mage
.goto Durotar,50.8,13.8,40 >>Go up the Zeppelin Tower
.zone Tirisfal Glades >>Take the Zeppelin to Tirisfal Glades
.zoneskip Tirisfal Glades
step << Shaman
#completewith next
.goto Undercity,63.27,48.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Michael|r
.fly Tarren Mill >> Fly to Tarren Mill
.target Michael Garrett
.zoneskip Hillsbrad Foothills
.isQuestComplete 8413
.dungeon ST
step << Shaman
.goto Alterac Mountains,80.50,66.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bath'rah|r
.turnin 8413 >> Turn in Da Voodoo
.target Bath'rah the Windwatcher
.isQuestComplete 8413
.dungeon ST
step
#completewith next
.goto Undercity,63.27,48.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Michael|r
.fly Tarren Mill >> Fly to Tarren Mill
.target Michael Garrett
.zoneskip Hillsbrad Foothills
.zoneskip Alterac Mountains
.isQuestComplete 1446
.dungeon ST
step
.goto The Hinterlands,33.751,75.210
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Atal'ai Exile|r
.turnin 1446 >> Turn in Jammal'an the Prophet
.target Atal'ai Exile
.isQuestComplete 1446
.dungeon ST
step
.goto Hillsbrad Foothills,60.14,18.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zarise|r
.fly Undercity >> Fly to Undercity
.target Zarise
.zoneskip Undercity
.zoneskip Tirisfal Glades
.dungeon ST
step
.abandon 1446 >> Abandon Jammal'an the Prophet
.isOnQuest 1446
.dungeon ST
step
.abandon 3447 >> Abandon Secret of the Circle
.isOnQuest 3447
.dungeon ST
step
.abandon 3528 >> Abandon The God Hakkar
.isOnQuest 3528
.dungeon ST
step
.abandon 4146 >> Abandon Zapper Fuel
.isOnQuest 4146
.dungeon ST
step
.abandon 1445 >> Abandon The Temple of Atal'Hakkar
.isOnQuest 1445
.dungeon ST
step
.abandon 5165 >> Abandon Dousing the Flames of Protection
.isOnQuest 5165
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 57-59 Western PL/Eastern PL
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 50-60
#next 59-59 Winterspring/Silithus I
step
#completewith next
.subzone 152 >> Travel toward the Bulwark
step
.goto Tirisfal Glades,83.15,68.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTravel to the Bulwark, then talk to |cRXP_FRIENDLY_Derrington|r
.turnin 5095 >>Turn in A Call to Arms: The Plaguelands!
.accept 5096 >>Accept Scarlet Diversions
.target High Executor Derrington
step
.goto Western Plaguelands,26.55,56.18
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Box of Incendiaries|r by the fire
.collect 12814,1 
step
.goto Tirisfal Glades,83.19,68.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Garush|r
.turnin 6029 >>Turn in The Everlook Report
.turnin 5405 >>Turn in Argent Dawn Commission
.target Argent Officer Garush
step
.goto Tirisfal Glades,83.30,72.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mickey|r
.accept 5901 >>Accept A Plague Upon Thee
.target Mickey Levine
step 
.goto Western Plaguelands,40.5,51.8
.use 12807 >>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Command Tent|r, then use your |T132484:0|t[Scourge Banner]
>>|cRXP_WARN_These mobs are relatively difficult and can chain-pull each other, so be careful|r
.complete 5096,1 
step
.goto Tirisfal Glades,83.15,68.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Derrington|r
.turnin 5096 >>Turn in Scarlet Diversions
.accept 5098 >>Accept All Along the Watchtowers
.accept 5228 >>Accept The Scourge Cauldrons
.target High Executor Derrington
step
.goto Tirisfal Glades,83.03,71.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vandis|r
.turnin 5228 >>Turn in The Scourge Cauldrons
.accept 5229 >>Accept Target: Felstone Field
.target Shadow Priestess Vandis
step
.goto Western Plaguelands,37.12,57.18
>>Kill |cRXP_ENEMY_Cauldron Lord Bilemaw|r. Loot him for his |cRXP_LOOT_Cauldron Key|r
.complete 5229,1 
.unitscan Cauldron Lord Bilemaw
step
.goto Western Plaguelands,37.2,56.8
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Scourge Cauldron|r roiling atop the dais
.turnin 5229 >>Turn in Target: Felstone Field
.accept 5230 >>Accept Return to the Bulwark
step
.goto Western Plaguelands,38.40,54.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Janice|r on the second floor of the house
.accept 5021 >>Accept Better Late Than Never
.target Janice Felstone
step
.goto Western Plaguelands,38.8,55.3
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick |cRXP_PICK_Janice's Parcel|r in the barn
>>|cRXP_WARN_You can click it through the hallway wall if you want to skip the mobs inside|r
.turnin 5021 >>Turn in Better Late Than Never
.accept 5023 >>Accept Better Late Than Never
step
#completewith next
.subzone 152 >> Return to The Bulwark
step
.goto Tirisfal Glades,83.03,71.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vandis|r
.turnin 5230 >>Turn in Return to the Bulwark
.accept 5231 >>Accept Target: Dalson's Tears
.target Shadow Priestess Vandis
step
.goto Western Plaguelands,46.04,52.33
>>Kill |cRXP_ENEMY_Cauldron Lord Malvinous|r. Loot him for his |cRXP_LOOT_Cauldron Key|r
.complete 5231,1 
.unitscan Cauldron Lord Malvinious
step
.goto Western Plaguelands,46.2,52.0
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Scourge Cauldron|r roiling atop the dais
.turnin 5231 >>Turn in Target: Dalson's Tears
.accept 5232 >>Accept Return to the Bulwark
step
.goto Western Plaguelands,47.8,50.6
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick |cRXP_PICK_Mrs. Dalson's Diary|r
.turnin 5058 >>Turn in Mrs. Dalson's Diary
step
.goto Western Plaguelands,47.49,51.00
>>Kill the |cRXP_ENEMY_Wandering Skeleton|r. Loot it for its |cRXP_LOOT_Outhouse Key|r
>>|cRXP_WARN_Grind Bone Fragments if the skeleton isn't spawned|r
.collect 12738,1 
.unitscan Wandering Skeleton
step
#completewith next
.goto Western Plaguelands,48.2,49.7
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Outhouse|r
.turnin 5059 >>Turn in Locked Away
step
.goto Western Plaguelands,48.2,49.7
>>Kill |cRXP_ENEMY_Farmer Dalson|r. Loot him for his |cRXP_LOOT_Cabinet Key|r
>>|cRXP_WARN_This mob has Thrash and Enrage. Be very careful|r
.collect 12739,1,5060 
.unitscan Farmer Dalson
step
.goto Western Plaguelands,47.4,49.7
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Locked Cabinet|r on the top floor of the house
.turnin 5060 >>Turn in Locked Away
step
.goto Western Plaguelands,39.46,66.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Chromie|r on the top floor of the inn
.accept 4971 >>Accept A Matter of Time
.target Chromie
.group
step
.goto Western Plaguelands,40.15,71.50
.use 12815 >>Use your |T135432:0|t[Beacon Torch] on the outside corner of the tower's doorway
>>|cRXP_WARN_Do not engage the elite inside|r
.complete 5098,1 
step
.goto Western Plaguelands,42.28,66.05
.use 12815 >>Use your |T135432:0|t[Beacon Torch] on the outside corner of the tower's doorway
>>|cRXP_WARN_Do not engage the elite inside|r
.complete 5098,2 
step
.goto Western Plaguelands,44.24,63.06
.use 12815 >>Use your |T135432:0|t[Beacon Torch] on the outside corner of the tower's doorway
>>|cRXP_WARN_Do not engage the elite inside|r
.complete 5098,3 
step
.goto Western Plaguelands,45.8,63.3
.use 12627 >>Spawn the |cRXP_ENEMY_Temporal Parasites|r by using your |T134229:0|t[Temporal Displacer] near the glowing silos
>>|cRXP_WARN_Temporal Parasites spam Slow and can spawn more parasites upon death. Be ready to run to the water if they begin overwhelming you; they cannot swim|r
.complete 4971,1 
.mob Temporal Parasite
.group 2
step
.goto Western Plaguelands,46.73,71.14
.use 12815 >>Use your |T135432:0|t[Beacon Torch] on the outside corner of the tower's doorway
>>|cRXP_WARN_Do not engage the elite inside|r
.complete 5098,4 
step
#completewith next
.subzone 152 >> Return to The Bulwark
step
.goto Tirisfal Glades,83.03,71.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vandis|r
.turnin 5232 >>Turn in Return to the Bulwark
.accept 5233 >>Accept Target: Writhing Haunt
.target Shadow Priestess Vandis
step
.goto Tirisfal Glades,83.15,68.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Derrington|r
.turnin 5098 >>Turn in All Along the Watchtowers
.accept 838 >>Accept Scholomance
.target High Executor Derrington
step
.goto Tirisfal Glades,83.28,69.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dithers|r
.turnin 838 >>Turn in Scholomance
.accept 964 >>Accept Skeletal Fragments
.target Apothecary Dithers
step
.goto Western Plaguelands,39.46,66.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Chromie|r on the top floor of the inn
.turnin 4971 >>Turn in A Matter of Time
.accept 4972 >>Accept Counting Out Time
.target Chromie
.isQuestComplete 4971
.group
step
.goto Western Plaguelands,39.46,66.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Chromie|r on the top floor of the inn
.accept 4972 >>Accept Counting Out Time
.target Chromie
.isQuestTurnedIn 4971
.group
step
#completewith next
>>Loot the |cRXP_PICK_Small Lockboxes|r in the ruined buildings for |cRXP_LOOT_Andorhal Watches|r
.complete 4972,1 
.isOnQuest 4972
.group
step
.goto Western Plaguelands,45.8,65.8,40,0
.loop 25,Western Plaguelands,46.4,70.0,45.6,72.2,42.6,71.4,41.6,73.2,38.8,71.0,38.8,68.2,40.4,66.4,42.6,70.0,43.4,64.4,45.8,65.8,46.4,70.0
>>Kill all |cRXP_ENEMY_Skeletons|r in Andorhal. Loot them for their |cRXP_LOOT_Fragments|r
>>|cRXP_ENEMY_Skeletal Executioners|r |cRXP_WARN_can execute|r
.complete 964,1 
.mob Skeletal Executioner
.mob Skeletal Acolyte
.mob Skeletal Warlord
.mob Skeletal Sorcerer
.mob Skeletal Flayer
.mob Skeletal Terror
step
.loop 25,Western Plaguelands,40.4,66.5,38.9,68.1,41.3,69.8,42.8,73.9,43.6,73.4,45.1,73.7,46.5,73.0,44.8,70.5,42.9,68.5,40.9,67.2,40.4,66.5
>>Loot the |cRXP_PICK_Small Lockboxes|r in the ruined buildings for |cRXP_LOOT_Andorhal Watches|r
.complete 4972,1 
.isOnQuest 4972
.group
step
.goto Western Plaguelands,39.46,66.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Chromie|r on the top floor of the inn
.turnin 4972 >>Turn in Counting Out Time
.target Chromie
.isQuestComplete 4972
.group
step
.goto Western Plaguelands,53.07,65.97
>>Kill |cRXP_ENEMY_Cauldron Lord Razarch|r. Loot him for his |cRXP_LOOT_Cauldron Key|r
>>|cRXP_ENEMY_Freezing Ghouls|r |cRXP_WARN_have a 5-second long, instant cast AoE stun|r
.complete 5233,1 
.unitscan Cauldron Lord Razarch
step
.goto Western Plaguelands,53.0,65.7
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Scourge Cauldron|r roiling atop the dais
>>|cRXP_ENEMY_Freezing Ghouls|r |cRXP_WARN_have a 5-second long, instant cast AoE stun|r
.turnin 5233 >>Turn in Target: Writhing Haunt
.accept 5234 >>Accept Return to the Bulwark
step
.goto Western Plaguelands,53.73,64.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mulgris|r inside the house
>>|cRXP_ENEMY_Freezing Ghouls|r |cRXP_WARN_have a 5-second long, instant cast AoE stun|r
.accept 4984 >>Accept The Wildlife Suffers Too
.target Mulgris Deepriver
step
#completewith Businessman
>>Kill |cRXP_ENEMY_Diseased Wolves|r
>>|cRXP_ENEMY_Diseased Wolves|r |cRXP_WARN_share spawns with|r |cRXP_ENEMY_Carrion Lurkers|r|cRXP_WARN_. If necessary, kill them to reset the area|r
.complete 4984,1 
.unitscan Diseased Wolf
step
.goto Western Plaguelands,51.92,28.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kirsta|r
.accept 6004 >>Accept Unfinished Business
.target Kirsta Deepshadow
step
#completewith next
>>Kill |cRXP_ENEMY_Scarlet Mages|r and |cRXP_ENEMY_Scarlet Knights|r
>>|cRXP_WARN_The|r |cRXP_ENEMY_Mages|r |cRXP_WARN_and|r |cRXP_ENEMY_Knights|r |cRXP_WARN_share respawns. If necessary, kill extra mobs to reset the area|r
.goto Western Plaguelands,50.43,41.12,70,0
.goto Western Plaguelands,53.50,36.85,70,0
.goto Western Plaguelands,50.43,41.12,70,0
.complete 6004,3 
.complete 6004,4 
.mob Scarlet Mage
.mob Scarlet Knight
step
>>Kill |cRXP_ENEMY_Scarlet Medics|r and |cRXP_ENEMY_Scarlet Hunters|r
>>|cRXP_ENEMY_Medics|r |cRXP_WARN_and|r |cRXP_ENEMY_Hunters|r |cRXP_WARN_can be found in the camps. If necessary, kill extra mobs to reset the area|r
.goto Western Plaguelands,51.77,44.13,70,0
.goto Western Plaguelands,40.83,52.30,70,0
.goto Western Plaguelands,47.35,51.54,0
.goto Western Plaguelands,51.77,44.13
.complete 6004,1 
.complete 6004,2 
.mob Scarlet Medic
.mob Scarlet Hunter
step
.goto Western Plaguelands,50.43,41.12,70,0
.goto Western Plaguelands,53.50,36.85,70,0
.goto Western Plaguelands,50.43,41.12
>>Finish killing |cRXP_ENEMY_Scarlet Mages|r and |cRXP_ENEMY_Scarlet Knights|r
>>|cRXP_WARN_The|r |cRXP_ENEMY_Mages|r |cRXP_WARN_and|r |cRXP_ENEMY_Knights|r |cRXP_WARN_share respawns. If necessary, kill extra mobs to reset the area|r
.complete 6004,3 
.complete 6004,4 
.mob Scarlet Mage
.mob Scarlet Knight
step
.goto Western Plaguelands,51.92,28.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kirsta|r
.turnin 6004 >>Turn in Unfinished Business
.accept 6023 >>Accept Unfinished Business
.target Kirsta Deepshadow
step
.goto Western Plaguelands,57.83,36.10
>>Kill |cRXP_ENEMY_Huntsman Radley|r
>>|cRXP_WARN_The mobs around her can chain pull easily. The Spellbinders cast Frost Nova|r
.complete 6023,1 
.unitscan Huntsman Radley
step
.goto Western Plaguelands,54.64,23.71
>>Kill |cRXP_ENEMY_Cavalier Durgen|r
>>|cRXP_WARN_This encounter is much more safe if you wait for him to patrol out of the tower before pulling. He has a 5 second, instant cast stun|r
.complete 6023,2 
.unitscan Cavalier Durgen
step
#label Businessman
.goto Western Plaguelands,51.92,28.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kirsta|r
.turnin 6023 >>Turn in Unfinished Business
.target Kirsta Deepshadow
step
.goto Western Plaguelands,50.0,36.8,40,0
.loop 25,Western Plaguelands,46.8,39.6,45.8,46.4,43.4,54.8,46.0,59.2,51.6,61.6,51.0,53.2,50.0,46.6,47.8,43.4,46.8,39.6
>>Kill |cRXP_ENEMY_Diseased Wolves|r
>>|cRXP_ENEMY_Diseased Wolves|r |cRXP_WARN_share spawns with|r |cRXP_ENEMY_Carrion Lurkers|r|cRXP_WARN_. If necessary, kill them to reset the area|r
.complete 4984,1 
.unitscan Diseased Wolf
step
.goto Western Plaguelands,53.73,64.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mulgris|r
.turnin 4984 >>Turn in The Wildlife Suffers Too
.accept 4985 >>Accept The Wildlife Suffers Too
.target Mulgris Deepriver
step
.loop 25,Western Plaguelands,57.0,60.8,58.6,53.8,55.2,50.4,58.6,53.8,66.2,47.4,66.0,55.6,66.2,47.4,58.6,53.8,55.2,50.4,58.6,53.8,57.0,60.8
>>Kill |cRXP_ENEMY_Diseased Grizzlies|r
>>|cRXP_ENEMY_Diseased Grizzlies|r |cRXP_WARN_share spawns with|r |cRXP_ENEMY_Plague Lurkers|r|cRXP_WARN_. If necessary, kill them to reset the area|r
.complete 4985,1 
.unitscan Diseased Grizzly
step
.goto Western Plaguelands,53.73,64.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mulgris|r
.turnin 4985 >>Turn in The Wildlife Suffers Too
.target Mulgris Deepriver
step
#completewith next
.goto Eastern Plaguelands,7.48,43.67,50 >> Travel toward |cRXP_FRIENDLY_Tirion|r in the Eastern Plaguelands
step
.goto Eastern Plaguelands,7.48,43.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.accept 5542 >>Accept Demon Dogs
.accept 5543 >>Accept Blood Tinged Skies
.accept 5544 >>Accept Carrion Grubbage
.target Tirion Fordring
step
#completewith WormMeat
>>Kill |cRXP_ENEMY_Carrion Worms|r. Loot them for their |cRXP_LOOT_Meat|r
.complete 5544,1 
.mob Carrion Worm
step
#completewith Pamela
>>Kill |cRXP_ENEMY_Plaguebats|r and |cRXP_ENEMY_Plaguehound Runts|r
.complete 5543,1 
.complete 5542,1 
.mob Plaguebat
.mob Plaguehound Runt
step
.goto Eastern Plaguelands,26.54,74.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nathanos|r
.accept 6042 >>Accept Un-Life's Little Annoyances
.target Nathanos Blightcaller
step
.goto Eastern Plaguelands,36.46,90.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pamela|r
.turnin 5601 >>Turn in Sister Pamela
.accept 5149 >>Accept Pamela's Doll
.target Pamela Redpath
step
.goto Eastern Plaguelands,38.25,92.23,40,0
.goto Eastern Plaguelands,39.58,92.60,40,0
.goto Eastern Plaguelands,39.63,90.12
>>Loot the 3 |cRXP_PICK_Doll Parts|r on the floor in ruined buildings
>>|cRXP_WARN_Clicking the doll pieces can spawn a few|r |cRXP_ENEMY_Ghosts of the Past|r |cRXP_WARN_which have ice armor and frost shock|r
.collect 12886,1 
.collect 12887,1 
.collect 12888,1 
.unitscan Ghost of the Past
step
.goto Eastern Plaguelands,36.4,90.8
.use 12886 >>|TInterface/GossipFrame/HealerGossipIcon:0|tClick |T134164:0|t[Pamela's Doll's Head] to combine the three pieces
.complete 5149,1 
step
#label Pamela
.goto Eastern Plaguelands,36.46,90.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pamela|r
.turnin 5149 >>Turn in Pamela's Doll
.accept 5152 >>Accept Auntie Marlene
.accept 5241 >>Accept Uncle Carlin
.target Pamela Redpath
step
.loop 25,Eastern Plaguelands,42.6,83.4,45.6,81.6,48.8,77.6,53.0,77.8,54.6,75.4,48.0,70.4,43.4,73.8,41.8,69.4,36.6,69.6,34.4,74.8,31.0,75.4,30.6,70.4,29.2,65.6,24.4,66.6,20.2,65.4,16.0,64.6,18.6,70.6,15.4,75.6,17.6,79.4,22.0,79.4,25.4,87.4,32.4,84.8,36.6,82.6,42.6,83.4
>>Kill |cRXP_ENEMY_Plaguebats|r and |cRXP_ENEMY_Plaguehound Runts|r
.complete 5543,1 
.complete 5542,1 
.mob Plaguebat
.mob Plaguehound Runt
step
.loop 25,Eastern Plaguelands,45.6,66.6,46.6,63.8,49.6,60.6,51.8,58.8,54.2,53.2,58.0,55.6,61.0,56.8,64.6,56.6,69.8,56.6,72.4,62.2,69.8,63.6,70.8,69.0,76.2,69.2,74.2,75.4,68.8,74.4,66.4,69.2,64.6,63.8,61.6,60.4,56.6,59.6,51.6,61.0,48.6,64.6,45.6,66.6
>>Kill |cRXP_ENEMY_Plaguehound|r and |cRXP_ENEMY_Noxious Plaguebats|r
.complete 5542,2 
.complete 6042,1 
.mob Plaguehound
.mob Noxious Plaguebat








step
#completewith next
.subzone 2268 >> Travel to Light's Hope Chapel
step
.goto Eastern Plaguelands,80.2,57.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Georgia|r
.fp Light's Hope Chapel	>>Get the Light's Hope Chapel flight path
.target Georgia
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nicholas|r and |cRXP_FRIENDLY_Carlin|r
.turnin 6030 >>Turn in Duke Nicholas Zverenhoff
.goto Eastern Plaguelands,75.66,53.89
.turnin 5241 >>Turn in Uncle Carlin
.accept 5211 >>Accept Defenders of Darrowshire
.goto Eastern Plaguelands,81.44,59.83
.target Duke Nicholas Zverenhoff
.target Carlin Redpath
step
.goto Eastern Plaguelands,79.54,63.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alen|r
.accept 6021 >>Accept Zaeldarr the Outcast
.accept 5281 >>Accept The Restless Souls
.target Caretaker Alen
step
.goto Eastern Plaguelands,77.11,48.00,90,0
.goto Eastern Plaguelands,67.85,41.13,90,0
.loop 25,Eastern Plaguelands,68.2,40.8,68.6,38.6,66.0,36.0,64.6,38.0,65.4,41.2,66.6,38.6,68.2,40.8
>>Kill |cRXP_ENEMY_Diseased Flayers|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Darrowshire Spirits|r that appear over their corpses
>>|cRXP_WARN_These mobs share spawns with a few mob types, so kill everything after all the ghouls have died|r
.complete 5211,1 
.mob Diseased Flayer
.skipgossip
step
#label WormMeat
.loop 25,Eastern Plaguelands,48.0,24.6,50.8,27.0,54.2,22.6,61.8,30.4,62.6,38.4,69.0,36.0,70.4,42.4,67.2,51.2,64.2,45.6,52.8,41.2,54.4,33.4,47.6,28.4,48.0,24.6
>>Kill |cRXP_ENEMY_Monstrous Plaguebats|r and |cRXP_ENEMY_Frenzied Plaguehounds|r
>>|cRXP_WARN_Be careful as|r |cRXP_ENEMY_Monstrous Plaguebats|r |cRXP_WARN_can silence for 10 seconds in melee range|r << !Rogue !Warrior
.complete 6042,2 
.complete 5542,3 
.mob Monstrous Plaguebat
.mob Frenzied Plaguehound
step
.goto Eastern Plaguelands,53.81,37.82,90,0
.goto Eastern Plaguelands,48.90,27.18,90,0
.loop 25,Eastern Plaguelands,42.6,83.4,45.6,81.6,48.8,77.6,53.0,77.8,54.6,75.4,48.0,70.4,43.4,73.8,41.8,69.4,36.6,69.6,34.4,74.8,31.0,75.4,30.6,70.4,29.2,65.6,24.4,66.6,20.2,65.4,16.0,64.6,18.6,70.6,15.4,75.6,17.6,79.4,22.0,79.4,25.4,87.4,32.4,84.8,36.6,82.6,42.6,83.4
>>Kill |cRXP_ENEMY_Carrion Worms|r. Loot them for their |cRXP_LOOT_Meat|r
.complete 5544,1 
.mob Carrion Worm
step
#completewith next
.subzone 2277 >> Travel to Plaguewood
step
.goto Eastern Plaguelands,35.94,16.67,50,0
.goto Eastern Plaguelands,32.58,17.02,50,0
.goto Eastern Plaguelands,21.85,19.43,50,0
.goto Eastern Plaguelands,18.48,21.90,50,0
.goto Eastern Plaguelands,21.69,32.83,50,0
.goto Eastern Plaguelands,28.30,30.72,50,0
.goto Eastern Plaguelands,32.88,29.14,50,0
.goto Eastern Plaguelands,34.61,29.90,50,0
.goto Eastern Plaguelands,36.41,26.66,50,0
.goto Eastern Plaguelands,35.94,16.67,50,0
.goto Eastern Plaguelands,32.58,17.02,50,0
.goto Eastern Plaguelands,21.85,19.43,50,0
.goto Eastern Plaguelands,18.48,21.90,50,0
.goto Eastern Plaguelands,21.69,32.83
>>Loot the tan |cRXP_PICK_Termite Mounds|r for its |cRXP_LOOT_Termites|r
.complete 5901,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tEnter the house, then talk to |cRXP_FRIENDLY_Egan|r and |cRXP_FRIENDLY_Augustus|r
.turnin 5281 >>Turn in The Restless Souls
.goto Eastern Plaguelands,14.45,33.74
.accept 6164 >>Accept Augustus' Receipt Book
.goto Eastern Plaguelands,14.45,33.48
.target Egan
.target Augustus the Touched
step
.goto Eastern Plaguelands,17.43,31.08
>>Loot |cRXP_PICK_Augustus' Receipt Book|r on the second floor of the inn
.complete 6164,1 
step
.goto Eastern Plaguelands,14.45,33.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Augustus|r back in the house
.turnin 6164 >>Turn in Augustus' Receipt Book
.target Augustus the Touched
step
.goto Eastern Plaguelands,14.45,33.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Augustus|r again
>>|cRXP_WARN_Make a lot of space in your bag 
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
step
#completewith next
.goto Eastern Plaguelands,27.59,43.33,40,0
.goto Eastern Plaguelands,24.43,41.00,40,0
.goto Eastern Plaguelands,23.33,42.30,40,0
.goto Eastern Plaguelands,21.80,40.36,40,0
.goto Eastern Plaguelands,19.58,42.98,40,0
.goto Eastern Plaguelands,18.71,40.81,40,0
.goto Eastern Plaguelands,16.37,42.00,40,0
.goto Eastern Plaguelands,10.99,47.75,40,0
+Perform the Eastern Plaguelands mountain skip to save time
>>|cRXP_WARN_You MUST have|r |T134863:0|t[Noggenfogger Elixirs] |cRXP_WARN_in your bag for this|r
.link https://www.youtube.com/watch?v=6VIULBxMyfU >> Click HERE for reference
step
.goto Eastern Plaguelands,7.48,43.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.turnin 5542 >>Turn in Demon Dogs
.turnin 5543 >>Turn in Blood Tinged Skies
.turnin 5544 >>Turn in Carrion Grubbage
.accept 5742 >>Accept Redemption
.target Tirion Fordring
step
.goto Eastern Plaguelands,7.48,43.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
>>|cRXP_WARN_Type /sit when listening to Tirion's Tale. You can be mounted when doing this|r
.complete 5742,1 
.turnin 5742 >>Turn in Redemption
.target Tirion Fordring
.skipgossip
step
.goto Eastern Plaguelands,7.48,43.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.accept 5781 >>Accept Of Forgotten Memories
.target Tirion Fordring
.group
step
.goto Eastern Plaguelands,26.54,74.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nathanos|r
.accept 6133 >>Accept The Ranger Lord's Behest
.accept 6022 >>Accept in To Kill With Purpose
.turnin 6042 >>Turn in Un-Life's Little Annoyances
.target Nathanos Blightcaller
.group
step
.goto Eastern Plaguelands,26.54,74.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nathanos|r
.accept 6022 >>Accept in To Kill With Purpose
.turnin 6042 >>Turn in Un-Life's Little Annoyances
.target Nathanos Blightcaller
step
.goto Eastern Plaguelands,28.31,86.90
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Loose Dirt Mound|r to summon |cRXP_ENEMY_Mercutio Filthgorger|r and 3 |cRXP_ENEMY_Crypt Robbers|r. Kill him, then loot him for his |cRXP_LOOT_Hammer|r
>>|cRXP_WARN_This quest is very dangerous. The|r |cRXP_ENEMY_Crypt Robbers|r |cRXP_WARN_are unusual; they take a LONG time to reset and can re-leash on a split pull|r
.complete 5781,1 
.mob Crypt Robber
.unitscan Mercutio Filthgorger
.group 2
step
.goto Eastern Plaguelands,27.47,84.85
>>Kill |cRXP_ENEMY_Zaeldarr the Outcast|r inside the crypt. Loot him for his |cRXP_LOOT_Head|r
.complete 6021,1 
.unitscan Zaeldarr the Outcast
step
.goto Eastern Plaguelands,27.28,85.23
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the big |cRXP_PICK_Torn Scroll|r on the ground inside the crypt
.accept 6024 >>Accept Hameya's Plea
.group
step
#requires HameyaP
#label Memories
.goto Eastern Plaguelands,7.48,43.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.turnin 5781 >>Turn in Of Forgotten Memories
.accept 5845 >>Accept Of Lost Honor
.target Tirion Fordring
.isQuestComplete 5781
.group
step
.goto Eastern Plaguelands,7.48,43.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.accept 5845 >>Accept Of Lost Honor
.target Tirion Fordring
.isQuestTurnedIn 5781
.group
step
.goto Eastern Plaguelands,26.54,74.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nathanos|r
.accept 6022 >>Accept To Kill With Purpose
.target Nathanos Blightcaller
step
#completewith RottingUndead
.subzone 2264 >> Travel to Corrin's Crossing
step
#completewith next
>>Kill |cRXP_ENEMY_Undead|r. Loot them for their |cRXP_LOOT_Living Rot|r.
>>|cRXP_WARN_Groups of elites patrol the north and east road. Invisible mobs patrol inside of Corrin's Crossing, so try to pull mobs out|r
.collect 15447,7 
.mob Hate Shrieker
.mob Scourge Warder
.mob Stitched Horror
.mob Gibbering Ghoul
.mob Unseen Servant
.mob Dark Caster
step
#label RottingUndead
.loop 25,Eastern Plaguelands,58.2,70.2,60.4,71.6,61.0,69.4,61.4,66.4,59.4,66.4,58.0,67.6,58.2,70.2
.use 15454 >>Use the |T133748:0|t[Mortar and Pestle] before the Living Rot expires
.complete 6022,1 
step
.goto Eastern Plaguelands,65.28,24.77,90,0
.goto Eastern Plaguelands,64.58,21.56,90,0
.goto Eastern Plaguelands,69.19,22.04,40,0
.goto Eastern Plaguelands,69.7,18.6
>>Kill |cRXP_ENEMY_Infiltrator Hameya|r. Loot her for her |cRXP_LOOT_Key|r
>>|cRXP_WARN_You should be able to avoid all the mobs en route up the mountain. Run past them all then run up the mountains to the east. Do not go near the graves|r
.complete 6024,1 
.unitscan Infiltrator Hameya
.group 2
step
#completewith next
.goto Eastern Plaguelands,52.2,18.4
>>Loot the |cRXP_LOOT_Quel'Thalas Registry|r on top of the bench
.complete 6133,4 
.group 2
step
.loop 25,Eastern Plaguelands,51.6,21.8,50.8,18.6,52.2,16.0,53.6,18.6,51.6,18.0,52.2,16.0,50.8,18.6,51.6,21.8
>>Kill |cRXP_ENEMY_Pathstriders|r, |cRXP_ENEMY_Rangers|r and |cRXP_ENEMY_Woodsmen|r
>>|cRXP_WARN_These mobs hit very hard for non-elites|r << !Rogue !Druid
>>|cRXP_WARN_These mobs hit very hard for non-elites; remember Pathstrider's Faerie Fire ability, in case you need to escape|r << Rogue/Druid
.complete 6133,1 
.complete 6133,2 
.complete 6133,3 
.mob Pathstrider
.mob Ranger
.mob Woodsman
.group 2
step
.goto Eastern Plaguelands,52.2,18.4
>>Loot the |cRXP_LOOT_Quel'Thalas Registry|r on top of the bench
.complete 6133,4 
.group 2
step
.goto Eastern Plaguelands,71.3,33.9
>>Loot the |cRXP_LOOT_Symbol of Lost Honor|r underwater
.complete 5845,1 
.isQuestTurnedIn 5781
.group
step
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alen|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
>>|cRXP_WARN_In a few steps you'll be going to Undercity and turning in cloth; you'll need at least 13 open bag spaces|r
.target Caretaker Alen
step
.goto Eastern Plaguelands,79.54,63.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alen|r
.turnin 6021 >>Turn in Zaeldarr the Outcast
.target Caretaker Alen
step
.goto Eastern Plaguelands,81.52,59.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carlin|r
.turnin 5211 >>Turn in Defenders of Darrowshire
.target Carlin Redpath
step << !Mage
.goto Eastern Plaguelands,80.2,57.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Georgia|r
.fly Undercity >>Fly to Undercity
.target Georgia
.zoneskip Undercity
step << Mage
#completewith next
.cast 3563 >>Cast |T135766:0|t[Teleport: Undercity]
step << Mage
.goto Undercity,85.15,10.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anastasia|r
.train 10157 >> Train your class spells
.target Anastasia Hartwell
.xp <56,1
.xp >58,1
step << Mage
.goto Undercity,85.15,10.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anastasia|r
.train 10054 >> Train your class spells
.target Anastasia Hartwell
.xp <58,1
step
.goto Undercity,69.79,43.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bauhaus|r
.turnin 5023 >>Turn in Better Late Than Never
.accept 5049 >>Accept The Jeremiah Blues
.target Royal Overseer Bauhaus
step
.goto Undercity,67.61,44.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jeremiah|r
.turnin 5049 >>Turn in The Jeremiah Blues
.accept 5050 >>Accept Good Luck Charm
.target Jeremiah Payson
step
#ah
#completewith UCClothTurnins
.goto Undercity,67.66,35.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cain|r
>>|cRXP_BUY_Buy 240 of each type of cloth on the auction house|r
.collect 2592,240 
.collect 4306,240 
.collect 4338,240 
.collect 14047,240 
.target Auctioneer Cain
step
#ah
#completewith next
.goto Undercity,68.15,38.26,0
+Go to the mailbox and retrieve the following:
.collect 2592,60 
.collect 4306,60 
.collect 4338,60 
.collect 14047,60 
step
#ah
#label UCClothTurnins
.goto Undercity,71.66,29.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ralston|r
>>|cRXP_WARN_Disable any other addons that automatically turn in reputation items, or you'll be told to buy cloth again later|r
.turnin 7813 >>Turn in A Donation of Wool
.turnin 7814 >>Turn in A Donation of Silk
.turnin 7817 >>Turn in A Donation of Mageweave
.turnin 7818 >>Turn in A Donation of Runecloth
.target Ralston Farnsley
step << Warlock
.goto Undercity,88.93,15.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Richard|r
.train 11689 >> Train your class spells
.target Richard Kerwin
.xp <56,1
.xp >58,1
step << Warlock
.goto Undercity,88.93,15.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Richard|r
.train 11713 >> Train your class spells
.target Richard Kerwin
.xp <58,1
step << Warlock
.goto Undercity,85.70,16.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Martha|r
.trainer >>Upgrade your pet's abilities
.target Martha Strain
step << Priest
.goto Undercity,47.55,18.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lazarus|r
.train 10929 >> Train your class spells
.target Father Lazarus
.xp <56,1
.xp >58,1
step << Priest
.goto Undercity,47.55,18.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lazarus|r
.train 10947 >> Train your class spells
.target Father Lazarus
.xp <58,1
step << Warrior
.goto Undercity,48.32,15.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Angela|r
.train 20662 >> Train your class spells
.target Angela Curthas
.xp <56,1
.xp >58,1
step << Warrior
.goto Undercity,48.32,15.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Angela|r
.train 11597 >> Train your class spells
.target Angela Curthas
.xp <58,1
step << Rogue
.goto Undercity,83.86,72.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carolyn|r
.train 11300 >> Train your class spells
.target Carolyn Ward
.xp <56,1
.xp >58,1
step << Rogue
.goto Undercity,83.86,72.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carolyn|r
.train 11305 >> Train your class spells
.target Carolyn Ward
.xp <58,1
step
.goto Undercity,48.50,71.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cuely|r
.turnin 3568 >>Turn in Seeping Corruption
.target Chemist Cuely
.isQuestComplete 3568
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cuely|r and |cRXP_FRIENDLY_Thersa|r
.accept 3569 >>Accept Seeping Corruption
.goto Undercity,48.71,71.40
.turnin 3569 >>Turn in Seeping Corruption
.turnin 3570 >>Turn in Seeping Corruption
.goto Undercity,49.03,70.81
.target Chemist Cuely
.target Thersa Windsong
.isQuestTurnedIn 3568
step
.goto Undercity,47.8,73.3
>>Use the |cRXP_PICK_Testing Equipment|r to test all of your samples
.use 15103 >>Open your |T134437:0|t[Corrupt Tested Samples]
.use 15102 >>Open your |T134437:0|t[Un'Goro Tested Samples]
.complete 4293,1 
.complete 4294,1 
step
.goto Undercity,48.50,71.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cuely|r
.turnin 4293 >>Turn in A Sample of Slime...
.turnin 4294 >>Turn in ... and a Match of Ooze
.accept 4642 >>Accept Melding of Influences
.target Chemist Cuely
step
.goto Undercity,54.81,76.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Andron|r
.turnin 3542 >>Turn in Delivery to Andron Gant
.accept 3564 >>Accept Andron's Payment to Jediga
.target Andron Gant
.isOnQuest 3542
step
.goto Undercity,54.81,76.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Andron|r
.accept 3564 >>Accept Andron's Payment to Jediga
.target Andron Gant
.isQuestComplete 3542
step
.goto Undercity,51.88,64.49,30,0
.goto Undercity,58.07,91.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sylvanas|r
.accept 5961 >>Accept The Champion of the Banshee Queen
.target Lady Sylvanas Windrunner
step
.goto Undercity,55.22,90.88
.goto Undercity,67.90,15.28,30 >>|cRXP_WARN_Perform a Logout Skip by positioning your character on the highest part of the lowest staircase until it looks like they're floating, then logging out and back in|r
.link https://www.youtube.com/watch?v=jj85AXyF1XE >> |cRXP_WARN_CLICK HERE for an example|r
>>|cRXP_WARN_If you can't do this, just run out of Undercity normally|r
step
#completewith next
.goto Tirisfal Glades,61.85,66.59,60 >>Exit Undercity
.zoneskip Tirisfal Glades
step
.goto Tirisfal Glades,83.28,69.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dithers|r
.turnin 964 >>Turn in Skeletal Fragments
.target Apothecary Dithers
step
.goto Tirisfal Glades,83.03,71.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vandis|r
.turnin 5234 >>Turn in Return to the Bulwark
.accept 5235 >>Accept Target: Gahrron's Withering
.target Shadow Priestess Vandis
step
.goto Tirisfal Glades,83.29,72.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mickey|r
.turnin 5901 >>Turn in A Plague Upon Thee
.accept 5902 >>Accept A Plague Upon Thee
.target Mickey Levine
step
.goto Western Plaguelands,38.40,54.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tClimb to the top floor of the building, then talk to |cRXP_FRIENDLY_Janice|r
.turnin 5050 >>Turn in Good Luck Charm
.accept 5051 >>Accept Two Halves Become One
.target Janice Felstone
step
.loop 25,Western Plaguelands,36.8,58.6,36.4,56.4,37.4,55.6,38.6,56.2,37.8,57.6,36.8,58.6
>>Kill the |cRXP_ENEMY_Jabbering Ghoul|r. Loot it for the |cRXP_LOOT_Good Luck Charm|r
.complete 5051,1 
.unitscan Jabbering Ghoul
step
.goto Western Plaguelands,38.40,54.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Janice|r on the top floor of the building
.turnin 5051 >>Turn in Two Halves Become One
.target Janice Felstone
step
.goto Western Plaguelands,49.13,78.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Marlene|r inside the house
.turnin 5152 >>Turn in Auntie Marlene
.accept 5153 >>Accept A Strange Historian
.target Marlene Redpath
step
.goto Western Plaguelands,49.69,76.75
>>Loot |cRXP_PICK_Joseph Redpath's Monument|r for |cRXP_LOOT_Joseph's Wedding Ring|r
.complete 5153,1 
step
.goto Western Plaguelands,39.46,66.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Chromie|r on the top floor of the inn
.turnin 5153 >>Turn in A Strange Historian
.accept 5154 >>Accept The Annals of Darrowshire
.target Chromie
step
.goto Western Plaguelands,43.4,69.6
>>Loot |cRXP_PICK_Musty Tomes|r inside the town hall until you loot the |cRXP_LOOT_Annals of Darrowshire|r
>>|cRXP_WARN_Many books are fake and spawn mobs when opened. The real books have entirely white pages, no gray/dark coloration. You may have to click fake books in order to spawn a real one|r
.complete 5154,1 
.link https://i.imgur.com/B2HDb6K.png >> Click HERE for visual example
step
.goto Western Plaguelands,39.46,66.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Chromie|r on the top floor of the inn
.turnin 5154 >>Turn in The Annals of Darrowshire
.accept 5210 >>Accept Brother Carlin
.target Chromie
step
.goto Western Plaguelands,53.73,64.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mulgris|r
.accept 4987 >>Accept Glyphed Oaken Branch
.target Mulgris Deepriver
step
.goto Western Plaguelands,62.80,58.76
>>Kill |cRXP_ENEMY_Cauldron Lord Soulwraith|r. Loot him for his |cRXP_LOOT_Cauldron Key|r
>>|cRXP_WARN_This mob has a 10-second silencing disease|r << !Priest
>>|cRXP_WARN_This mob has a 10-second silencing disease; pre-cast Abolish Disease and keep it up|r << Priest
.complete 5235,1 
.unitscan Cauldron Lord Soulwraith
step
.goto Western Plaguelands,62.5,58.6
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Scourge Cauldron|r roiling atop the dais
.turnin 5235 >>Turn in Target: Gahrron's Withering
.accept 5236 >>Accept Return to the Bulwark
step
.goto Eastern Plaguelands,7.48,43.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.turnin 5845 >>Turn in Of Lost Honor
.accept 5846 >>Accept Of Love and Family
.target Tirion Fordring
.isQuestTurnedIn 5781
.group
step
#completewith next
.subzone 2261 >> Travel to the Undercroft
step
.goto Eastern Plaguelands,28.04,86.16
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cRXP_PICK_mound of dirt|r behind the crypt
.turnin 6024 >>Turn in Hameya's Plea
.isQuestComplete 6024
.group
step
.goto Eastern Plaguelands,26.54,74.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nathanos|r
.turnin 5961 >>Turn in The Champion of the Banshee Queen
.turnin 6022 >>Turn in To Kill With Purpose
.turnin 6133 >>The Ranger Lord's Behest
.target Nathanos Blightcaller
.group
step
.goto Eastern Plaguelands,26.54,74.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nathanos|r
.turnin 5961 >>Turn in The Champion of the Banshee Queen
.turnin 6022 >>Turn in To Kill With Purpose
.target Nathanos Blightcaller
step
.goto Eastern Plaguelands,81.52,59.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carlin|r
.turnin 5210 >>Turn in Brother Carlin
.accept 5181 >>Accept Villains of Darrowshire
.accept 5168 >>Accept Heroes of Darrowshire
.target Carlin Redpath
.group
step
.goto Eastern Plaguelands,81.52,59.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carlin|r
.turnin 5210 >>Turn in Brother Carlin
.accept 5181 >>Accept Villains of Darrowshire
.target Carlin Redpath
step
.goto Eastern Plaguelands,46.56,44.39
>>Loot the |cRXP_LOOT_Skull of Horgus|r located in the middle of the lake
.complete 5181,1 
step
.goto Eastern Plaguelands,49.24,59.59
>>Loot the |cRXP_LOOT_Shatter Sword of Marduk|r in the Infectis Scar
.complete 5181,2 
step
.goto Eastern Plaguelands,81.52,59.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carlin|r
.turnin 5181 >>Turn in Villains of Darrowshire
.target Carlin Redpath
.solo
step
.goto Western Plaguelands,63.80,57.18
>>Loot |cRXP_LOOT_Redpath's Shield|r
.complete 5168,2 
.group
step
.goto Western Plaguelands,65.79,75.41
>>Swim to Caer Darrow << !Shaman/Priest
>>Waterwalk to Caer Darrow, or swim << Shaman
>>Use Levitate to Caer Darrow, or swim << Priest
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Renfray|r
.turnin 5846 >>Turn in Of Love and Family
.target Artist Renfray
.isOnQuest 5846
.group
step
#completewith next
.subzone 192 >>Travel to Northridge Lumber Camp
step
.goto Western Plaguelands,48.35,32.00
>>|TInterface/GossipFrame/HealerGossipIcon:0|tEnter the mill. Click the |cRXP_PICK_Northridge Lumber Mill Crate|r by the ramp, then click the |cRXP_PICK_Termite Barrel|r
.turnin 5902 >>Turn in A Plague Upon Thee
.accept 6390 >>Accept A Plague Upon Thee
step
.goto Western Plaguelands,51.92,28.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kirsta|r
.accept 6025 >>Accept Unfinished Business
.target Kirsta Deepshadow
.group
step
.goto Western Plaguelands,47.94,21.43,60,0
.goto Western Plaguelands,43.31,17.34,50,0
.goto Western Plaguelands,45.6,18.6
>>Run into Hearthglen and follow the arrow to reset the mobs once you're inside
>>Run up to the top of the tower. Be careful as the Paladins outside can heal. You can try running past them/Crowd controlling them and going to the top
>>|cRXP_WARN_Be mindful that mobs have no Z axis range. They can hit you from the bottom of the tower if they're directly below you|r
.complete 6025,1 
.group 2
step
.goto Western Plaguelands,42.53,18.99
>>Loot |cRXP_LOOT_Davil's Libram|r inside the church
>>|cRXP_WARN_Be careful, there are many elites inside|r
.complete 5168,1 
.group 5
step
.goto Western Plaguelands,51.92,28.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tLeave Hearthglen, then talk to |cRXP_FRIENDLY_Kirsta|r
.turnin 6025 >>Turn in Unfinished Business
.target Kirsta Deepshadow
.isQuestComplete 6025
.group
step
.goto Tirisfal Glades,83.03,71.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vandis|r
.turnin 5236 >>Turn in Return to the Bulwark
.target Shadow Priestess Vandis
step
.goto Tirisfal Glades,83.30,72.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mickey|r
.turnin 6390 >>Turn in A Plague Upon Thee
.target Mickey Levine
step
.goto Tirisfal Glades,83.15,68.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Derrington|r
.turnin 5238 >>Turn in Mission Accomplished!
.target High Executor Derrington
step
#completewith next
.subzone >> Travel back to Light's Hope Chapel
.group
step
.goto Eastern Plaguelands,81.52,59.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carlin|r
.turnin 5181 >>Turn in Villains of Darrowshire
.turnin 5168 >>Turn in Heroes of Darrowshire
.target Carlin Redpath
.isQuestComplete 5168
.group
step
.goto Eastern Plaguelands,81.52,59.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carlin|r
.turnin 5181 >>Turn in Villains of Darrowshire
.target Carlin Redpath
.group
step
.goto Eastern Plaguelands,81.52,59.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carlin|r again
.accept 5206 >>Accept Marauders of Darrowshire
.target Carlin Redpath
.isQuestTurnedIn 5181
.isQuestTurnedIn 5168
.group
step
.goto Eastern Plaguelands,70.72,44.77,50,0
.goto Eastern Plaguelands,75.19,37.98,50,0
.loop 25,Eastern Plaguelands,76.15,35.65,77.24,32.70,78.73,33.25,78.69,35.40,79.42,36.94,81.09,38.93,78.56,40.18,77.06,39.10,75.36,37.99,76.15,35.65
>>Kill |cRXP_ENEMY_Scourge Champions|r. Loot them for their |T133728:0|t[|cFF00BCD4Fetid Skulls|r]
.use 13156 >>Use your |T134095:0|t[Mystic Crystal] on the |T133728:0|t[|cFF00BCD4Fetid Skulls|r] to create |cRXP_LOOT_Resonating Skulls|r
.complete 5206,1 
.mob Scourge Champion
.isQuestTurnedIn 5206
.group
step
.goto Eastern Plaguelands,81.52,59.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carlin|r again
.accept 5206 >>Accept Marauders of Darrowshire
.target Carlin Redpath
.isQuestComplete 5206
.group
step
.hs >>Hearth to Everlook
.use 6948
.zoneskip Winterspring
step
.abandon 4971 >> Abandon A Matter of Time
.isOnQuest 4971
step
.abandon 5781 >> Abandon Of Forgotten Memories
.isOnQuest 5781
step
.abandon 6133 >> Abandon The Ranger Lord's Behest
.isOnQuest 6133
step
.abandon 6024 >> Abandon Hameya's Plea
.isOnQuest 6024
step
.abandon 5168 >> Abandon Heroes of Darrowshire
.isOnQuest 5168
step
.abandon 6025 >> Abandon Unfinished Business
.isOnQuest 6025
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#name 59-59 Winterspring/Silithus I
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 50-60
#next 59-60 Winterspring/Silithus II
step
.goto Winterspring,61.60,38.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Felnok|r
.accept 4809 >>Accept Chillwind Horns
.target Felnok Steelspring
step
.goto Winterspring,60.90,37.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umi|r
.accept 977 >>Accept Are We There, Yeti?
.target Umi Rumplesnicker
step
.loop 25,Winterspring,64.0,22.6,65.6,23.2,67.6,22.6,65.6,19.6,63.6,16.2,65.6,19.6,64.0,20.8,64.0,22.6
>>Kill |cRXP_ENEMY_Berserk Owlbeasts|r. Loot them for a |T133298:0|t[|cFF00BCD4Blue-feathered Necklace|r]. Use it to accept the quest
.complete 4721,1 
.collect 12558,1 
.accept 4882 >>Accept Guarding Secrets
.use 12558
.mob Berserk Owlbeast
step
#completewith next
>>Kill |cRXP_ENEMY_Winterfall Ursa|r, |cRXP_ENEMY_Winterfall Shamans|r and |cRXP_ENEMY_Winterfall Den Watchers|r
>>|cRXP_WARN_If there is too much competition, skip this step|r
.complete 8464,1 
.complete 8464,2 
.complete 8464,3 
.mob Winterfall Shaman
.mob Winterfall Den Watcher
.mob Winterfall Ursa
step
.goto Winterspring,69.62,38.31
>>Kill |cRXP_ENEMY_High Chief Winterfall|r. Loot him for his |T133740:0|t[|cFF00BCD4Crudely-written Log|r]. Use it to accept the quest
>>|cRXP_WARN_Kill the|r |cRXP_ENEMY_Winterfall Shaman|r |cRXP_WARN_first and reset afterwards for safety. Use your offensive cooldowns and CC if you can; his frost shock hits hard|r
.complete 5121,1 
.collect 12842,1,5123 
.accept 5123 >>Accept The Final Piece
.use 12842
.mob Winterfall Shaman
.unitscan High Chief Winterfall
.group 2
step
.loop 25,Winterspring,67.6,34.1,66.4,34.3,65.9,35.3,66.6,36.3,67.5,35.5,68.4,35.7,68.3,37.3,67.5,37.9,66.8,37.3,65.6,37.7,66.7,39.1,68.0,39.4,68.8,37.7,68.4,35.7,67.6,34.1
>>Kill |cRXP_ENEMY_Winterfall Ursa|r, |cRXP_ENEMY_Winterfall Shamans|r and |cRXP_ENEMY_Winterfall Den Watchers|r
>>|cRXP_WARN_If there is too much competition, skip this step|r
.complete 8464,1 
.complete 8464,2 
.complete 8464,3 
.mob Winterfall Shaman
.mob Winterfall Den Watcher
.mob Winterfall Ursa
step
.loop 25,Winterspring,66.5,41.7,64.9,40.2,65.9,43.6,66.2,45.8,67.6,45.6,67.6,43.8,67.2,43.0,67.6,41.9,68.4,41.5,69.00,41.3,69.5,40.0,69.8,41.8,70.1,42.0,70.3,40.8,71.3,40.8,71.8,39.8,70.5,38.3,71.8,39.8,71.3,40.8,70.3,40.8,69.5,40.0,69.00,41.3,68.4,41.5,66.5,41.7
>>Kill |cRXP_ENEMY_Ice Thistle Patriarchs and Matriachs|r until you loot a |cRXP_LOOT_Pristine Yeti Horn|r
.complete 977,1 
.mob Ice Thistle Patriarch
.mob Ice Thistle Matriarch
step
.loop 25,Winterspring,67.6,48.2,66.2,52.4,63.6,47.2,61.6,45.0,58.2,45.0,57.4,46.6,55.4,49.0,55.2,46.4,48.6,45.0,44.8,42.2,44.0,36.0,48.0,36.6,49.4,34.4,54.0,36.8,56.6,25.6,55.6,22.4,58.0,19.8,60.6,23.6,66.4,26.8,65.6,32.6,62.4,36.2,61.2,41.6,67.6,48.2
>>Kill |cRXP_ENEMY_all Chillwind Chimaeras|r north of Everlook. Loot them for their |cRXP_LOOT_Horns|r
.complete 4809,1 
.mob Fledgling Chillwind
.mob Chillwind Chimaera
.mob Chillwind Ravager
step << Shaman
#completewith next
.hs >>Hearth or Astrall Recall to Everlook
step
.goto Winterspring,61.6,38.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Felnok|r
.turnin 4809 >>Turn in Chillwind Horns
.target Felnok Steelspring
step
.goto Winterspring,60.90,37.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umi|r
.turnin 977 >>Turn in Are We There, Yeti?
.accept 5163 >>Accept Are We There, Yeti?
.target Umi Rumplesnicker
step
.goto Winterspring,61.50,38.60
.use 12928 >>Use the |T133003:0|t[Mechanical Yeti] on |cRXP_FRIENDLY_Legacki|r
.complete 5163,1 
.target Legacki
step
.goto Winterspring,61.36,38.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vizzie|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Vizzie
step
.goto Winterspring,31.30,45.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donova|r
.turnin 5121 >>Turn in High Chief Winterfall
.turnin 5123 >>Turn in The Final Piece
.accept 5128 >>Accept Words of the High Chief
.target Donova Snowden
.isQuestComplete 5121
.group
step
.goto Winterspring,31.30,45.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donova|r
.turnin 5123 >>Turn in The Final Piece
.accept 5128 >>Accept Words of the High Chief
.target Donova Snowden
.isOnQuest 5123
.group
step
.goto Winterspring,31.30,45.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donova|r
.accept 5128 >>Accept Words of the High Chief
.target Donova Snowden
.isQuestTurnedIn 5128
.group
step
.goto Felwood,68.30,6.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Salfa|r
.turnin 8464 >>Turn in Winterfall Activity
.target Salfa
.isQuestComplete 8464
step << !Druid
#completewith RabineSaturna
.goto Winterspring,27.40,33.64,40,0
.goto Winterspring,25.70,31.93,40,0
.goto Winterspring,25.35,31.36,40,0
.goto Winterspring,26.36,28.04,40,0
.goto Winterspring,26.61,24.49,40,0
.goto Winterspring,26.59,24.17
.zone Moonglade >>Enter the tunnel, then take the north exit into Moonglade
step << Druid
#completewith RabineSaturna
.cast 18960 >>Cast |T135758:0|t[Teleport: Moonglade]
.zoneskip Moonglade
step << Druid
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 22829 >>Train your class spells
.target Loganaar
.xp <56,1
.xp >58,1
step << Druid
#label DruidTraining10
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 9850 >>Train your class spells
.target Loganaar
.xp <58,1
step
#label RabineSaturna
.goto Moonglade,51.70,45.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rabine|r
.turnin 1123 >>Turn in Rabine Saturna
.accept 1124 >>Accept Wasteland
.target Rabine Saturna
step
.goto Moonglade,51.68,45.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rabine|r, then work through his dialogue
>>|cRXP_WARN_Skip this step if the Dire Maul dialogue is not available. It will be available if you have gone to Dire Maul's outdoor zone/discovered Dire Maul at any point|r
.accept 5527 >>Accept A Reliquary of Purity
.target Rabine Saturna
.skipgossip
step
.goto Moonglade,32.10,66.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Faustron|r
.fp Moonglade >>Get the Moonglade Flight Path << !Druid
.fly Felwood>>Fly to Felwood
.target Faustron
step
.goto Felwood,34.80,52.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Trull|r
.turnin 4721 >>Turn in Wild Guardians
.turnin 4882 >>Turn in Guarding Secrets
.accept 4883 >>Accept Guarding Secrets
.target Trull Failbane
.isQuestComplete 4721
step
.goto Felwood,34.80,52.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Trull|r
.turnin 4882 >>Turn in Guarding Secrets
.accept 4883 >>Accept Guarding Secrets
.target Trull Failbane
step
.goto Felwood,51.14,81.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kelek|r
.turnin 5128 >>Turn in Words of the High Chief
.target Kelek Skykeeper
.isQuestTurnedIn 5123
.group
step
.goto Felwood,51.35,81.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Eridan|r
.turnin 4084 >>Turn in Silver Heart
.accept 4005 >>Accept Aquementas 
.target Eridan Bluewind
step
#completewith next
.hs >>Hearth back to Winterspring
.use 6948
.cooldown item,6948,>0,1
step
.goto Winterspring,60.47,36.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yugrek|r
.fly Azshara>>Fly to Azshara
.target Yugrek
.cooldown item,6948,>0,1
.zoneskip Azshara
step
#completewith next
.subzone 431 >> Travel to Splintertree Post
.cooldown item,6948,<0,1
step
.goto Ashenvale,73.18,61.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Vhulgra|r
.fly Azshara>>Fly to Azshara
.target Vhulgra
.cooldown item,6948,<0,1
.zoneskip Azshara
step
.goto Azshara,22.50,51.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jediga|r
.turnin 3564 >>Turn in Andron's Payment to Jediga
.target Jediga
.isOnQuest 3564
step << !Mage
.goto Azshara,22.00,49.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kroum|r
.fly Thunder Bluff>>Fly to Thunder Bluff
.target Kroum
.zoneskip Thunder Bluff
step << Mage
.cast 3566 >>Cast |T135765:0|t[Teleport: Thunder Bluff]
.zoneskip Thunder Bluff
step << Mage
.goto Thunder Bluff,25.18,20.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thurston|r
.train 10157 >> Train your class spells
.target Thurston Xane
.xp <56,1
.xp >58,1
step << Mage
.goto Thunder Bluff,25.18,20.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thurston|r
.train 10054 >> Train your class spells
.target Thurston Xane
.xp <58,1
step
#ah
#completewith next
.goto Thunder Bluff,45.22,59.40
+If you bought enough cloth earlier, go to the mailbox and retrieve the following:
.collect 2592,60 
.collect 4306,60 
.collect 4338,60 
.collect 14047,60 
step
#ah
.goto Thunder Bluff,43.3,42.8
>>|cRXP_WARN_Disable any other addons that automatically turn in reputation items, or you'll be told to buy cloth again later|r
>>Buy 3 stacks of each cloth type from the Auction House if you don't have enough for donations
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rumstag|r
.turnin 7820 >>Turn in A Donation of Wool
.turnin 7821 >>Turn in A Donation of Silk
.turnin 7822 >>Turn in A Donation of Mageweave
.turnin 7823 >>Turn in A Donation of Runecloth
.target Auctioneer Stampi
.target Rumstag Proudstrider
step
.goto Thunder Bluff,75.80,31.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nara|r
.turnin 4987 >>Turn in Glyphed Oaken Branch
.turnin 4883 >>Turn in Guarding Secrets
.target Nara Wildmane
step << Hunter
.goto Thunder Bluff,59.11,86.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 14305 >>Train your class spells
.target Urek Thunderhorn
.xp <56,1
.xp >58,1
step << Hunter
.goto Thunder Bluff,59.11,86.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urek|r
.train 14322 >>Train your class spells
.target Urek Thunderhorn
.xp <58,1
step << Warrior
.goto Thunder Bluff,57.56,85.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ker|r
.train 20662 >>Train your class spells
.target Ker Ragetotem
.xp <56,1
.xp >58,1
step << Warrior
.goto Thunder Bluff,57.56,85.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ker|r
.train 11597 >> Train your class spells
.target Ker Ragetotem
.xp <58,1
step << Shaman
.goto Thunder Bluff,22.84,21.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 10432 >>Train your class spells
.target Tigor Skychaser
.xp <56,1
.xp >58,1
step << Shaman
.goto Thunder Bluff,22.84,21.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tigor|r
.train 10473 >>Train your class spells
.target Tigor Skychaser
.xp <58,1
step << Priest
.goto Thunder Bluff,24.56,22.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malakai|r
.train 10929 >> Train your class spells
.target Malakai Cross
.xp <56,1
.xp >58,1
step << Priest
.goto Thunder Bluff,24.56,22.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malakai|r
.train 10947 >> Train your class spells
.target Malakai Cross
.xp <58,1
step << Druid
.goto Thunder Bluff,76.46,27.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Turak|r
.train 22829 >>Train your class spells
.target Turak Runetotem
.xp <56,1
.xp >58,1
step << Druid
.goto Thunder Bluff,76.46,27.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Turak|r
.train 9850 >>Train your class spells
.target Tura
.xp <58,1
step
.goto Thunder Bluff,47.02,49.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tal|r
.fly Tanaris>>Fly to Tanaris
.target Tal
.zoneskip Tanaris
step
.goto Tanaris,51.56,26.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tran'rek|r
.accept 4504 >>Accept Super Sticky
.target Tran'rek
step
.goto Tanaris,51.10,26.90
.use 12928 >>Use the |T133003:0|t[Mechanical Yeti] on |cRXP_FRIENDLY_Sprinkle|r
.complete 5163,2 
.target Sprinkle
step
.goto Tanaris,50.90,27.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pestlezugg|r
.accept 4507 >>Accept Pawn Captures Queen
.target Alchemist Pestlezugg
.group
step
.goto Tanaris,70.40,49.90
.use 11617 >>Go through Lost Rigger Cove. Take all of the items out of |T133647:0|t[Eridan's Supplies] on your way
.use 11169 >>Run into the stone circle and use the |T133742:0|t[Book of Aquor]
>>Kill |cRXP_ENEMY_Aquementas|r
.complete 4005,1 
.unitscan Aquementas
step
.goto Tanaris,51.60,25.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bullkrek|r
.fly Un'Goro Crater >>Fly to Un'Goro Crater
.target Bullkrek Ragefist
.zoneskip Un'Goro Crater
step
.goto Un'Goro Crater,41.92,2.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_J.D. Collie|r
.turnin 4005 >>Turn in Aquementas 
.accept 3961 >>Accept Linken's Adventure 
.target J.D. Collie
step
.goto Un'Goro Crater,44.66,8.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Linken|r
.turnin 3961 >>Turn in Linken's Adventure 
.accept 3962 >>Accept It's Dangerous to Go Alone 
.target Linken
.isQuestTurnedIn 4005
.group
step
.goto Un'Goro Crater,44.66,8.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Linken|r
.turnin 3961 >>Turn in Linken's Adventure 
.target Linken
step
.goto Un'Goro Crater,43.70,9.40
.use 12928 >>Use the |T133003:0|t[Mechanical Yeti] on |cRXP_FRIENDLY_Quixxil|r
.complete 5163,3 
.target Quixxil
step
.loop 25,Un'Goro Crater,47.2,14.7,48.1,17.7,49.8,20.6,51.3,23.9,53.6,22.7,54.5,27.0,52.2,27.6,49.2,31.2,48.0,36.3,46.6,30.5,48.2,24.7,47.8,20.5,43.7,21.1,41.3,21.0,42.8,15.9,47.2,14.7
>>Kill |cRXP_ENEMY_Tar Elementals|r. Loot them for their |cRXP_LOOT_Super Sticky Tar|r
>>|cRXP_WARN_Be careful as the|r |cRXP_ENEMY_Tar Lords|r |cRXP_WARN_cast Entangling Roots|r << !Warrior !Rogue !Shaman
>>|cRXP_WARN_Be careful as the|r |cRXP_ENEMY_Tar Lords|r |cRXP_WARN_cast Entangling Roots.|r |cRXP_ENEMY_Tar Beasts|r |cRXP_WARN_can disarm you for four seconds when they are hit|r << Warrior/Rogue/Shaman
.complete 4504,1 
.mob Tar Beast
.mob Tar Creeper
.mob Tar Lord
.mob Tar Lurker
step
.goto Un'Goro Crater,51.6,34.8,40,0
.goto Un'Goro Crater,51.6,30.6,40,0
.goto Un'Goro Crater,47.6,26.8,40,0
.goto Un'Goro Crater,45.2,22.8,40,0
.goto Un'Goro Crater,54.0,18.6,40,0
.goto Un'Goro Crater,56.6,18.4,40,0
.use 12288 >>Let a |cRXP_ENEMY_Primal Ooze|r hit you in combat, then use the |T132622:0|t[Encased Corrupt Ooze]
>>Kill the |cRXP_ENEMY_Gargantuan Ooze|r. Loot it for its |cRXP_LOOT_Merged Ooze Sample|r
>>|cRXP_WARN_You can only use the quest item once. Let the ooze attack you before you release your own|r
.complete 4642,1 
.mob Primal Ooze
.unitscan Gargantuan Ooze





step
.goto Un'Goro Crater,52.90,44.38,30,0
.goto Un'Goro Crater,51.49,47.28,30,0
.goto Un'Goro Crater,49.13,48.80,30,0
.goto Un'Goro Crater,49.52,49.47
.use 11522 >>Equip the |T135467:0|t[Silver Totem of Aquementas], then use it on |cRXP_ENEMY_Blazerunner|r and kill him
.complete 3962,1 
.unitscan Blazerunner
.group 3
step
.goto Un'Goro Crater,50.28,49.98
>>Loot the |cRXP_PICK_Ornate Chest|r in the back of the cave for a |cRXP_LOOT_Golden Flame|r
.complete 3962,2 
.group
step
.goto Un'Goro Crater,50.15,79.98,40,0
.goto Un'Goro Crater,49.74,82.52,30,0
.goto Un'Goro Crater,45.19,82.20,30,0
.goto Un'Goro Crater,43.41,80.98
>>Go deep into the silithid hive, until you reach a tall crystal in a round chamber
.use 11833 >>Use your |T134809:0|t[Gorishi Queen Lure] to summon the |cRXP_ENEMY_Gorishi Hive Queen|r. Kill her, then loot her |cRXP_LOOT_Gorishi Queen Brain|r
>>|cRXP_WARN_Stop new waves from aggroing you by dragging mobs into the hallway. Depending on your kill speed, a hallway patrol may respawn after the second wave|r
.complete 4507,1 
.group 2
step
#completewith next
.goto Silithus,88.09,23.43,70,0
.goto Un'Goro Crater,30.15,10.41,70,0
.goto Un'Goro Crater,25.14,12.71,70,0
.goto Silithus,81.87,18.93
.zone Silithus >>Head to Silithus
step
.goto Silithus,81.87,18.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Layo|r
.turnin 1124 >>Turn in Wasteland
.accept 1125 >>Accept The Spirits of Southwind
.target Layo Starstrike
step
#completewith end
.xpto60hc >>Skip to Part 2 of the guide once you have enough xp to reach 60

step
#phase 4
.goto Silithus,51.80,38.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Beetix|r on the second floor of the inn
.accept 8277 >>Accept Deadly Desert Venom
.target Beetix Ficklespragg
step
#phase 4
.goto Silithus,51.30,38.20
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cRXP_PICK_Wanted Poster|r
.accept 8283 >>Accept Wanted - Deathclasp, Terror of the Sands
.group
step
#phase 4
#completewith next
.goto Silithus,51.15,38.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Proudhorn|r
.accept 8280 >>Accept Securing the Supply Lines
.target Windcaller Proudhorn
step
#phase 4
.goto Silithus,49.60,37.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Larksbane|r
.accept 8284 >>Accept The Twilight Mystery
.target Geologist Larksbane
step
#phase 4
.goto Silithus,49.20,34.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mar'alith|r
.accept 8304 >>Accept Dearest Natalia
.target Commander Mar'alith
step
#phase 4
.goto Silithus,48.57,37.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bor|r
.accept 8318 >>Accept Secret Communication
.target Bor Wildmane
step
#phase 4
#completewith s1
>>Kill |cRXP_ENEMY_Dredge Strikers|r
.complete 8280,1 
.mob Dredge Stalker
step
#phase 4
#completewith s1
>>Kill |cRXP_ENEMY_Stonelash Scorpids|r and |cRXP_ENEMY_Sand Skitterers|r. Loot them for their |cRXP_LOOT_Stingers|r and |cRXP_LOOT_Fangs|r
.complete 8277,1 
.complete 8277,2 
.mob Stonelash Scorpid
.mob Sand Skitterer
step
#completewith Spirits
.use 20461 >>Keep an eye out for |T133463:0|t[|cFF00BCD4Brann Bronzebeard's Lost Letter|r]. If it drops, use it to start the quest
.collect 20461,1,8308 
.accept 8308 >>Accept Brann Bronzebeard's Lost Letter
step
#completewith next
>>Kill |cRXP_ENEMY_Tortured Druids|r and |cRXP_ENEMY_Tortured Sentinels|r
>>|cRXP_WARN_They have a high chance to spawn a|r |cRXP_ENEMY_Hive'Ashi Drone|r |cRXP_WARN_after dying|r
.complete 1125,1 
.complete 1125,2 
.mob Tortured Druid
.mob Tortured Sentinel
step
.goto Silithus,63.22,55.35
>>Loot the |cRXP_PICK_Dusty Reliquary|r inside the lodge for the |cRXP_LOOT_Reliquary of Purity|r
.complete 5527,1 
.isOnQuest 5527
step
#label Spirits
.loop 25,Silithus,61.6,48.6,63.8,48.6,63.6,51.6,62.6,55.6,62.6,58.6,60.0,55.8,60.6,52.8,61.6,48.6
>>Kill |cRXP_ENEMY_Tortured Druids|r and |cRXP_ENEMY_Tortured Sentinels|r
>>|cRXP_WARN_They have a high chance to spawn a|r |cRXP_ENEMY_Hive'Ashi Drone|r |cRXP_WARN_after dying|r
.complete 1125,1 
.complete 1125,2 
.mob Tortured Druid
.mob Tortured Sentinel
step
.goto Silithus,81.87,18.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Layo|r
.turnin 1125 >>Turn in The Spirits of Southwind
.target Layo Starstrike
step
.goto Silithus,81.87,18.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Layo|r
.accept 1126 >>Accept Hive in the Tower
.target Layo Starstrike
.group
step
#completewith next
.use 20461 >>Keep an eye out for |T133463:0|t[|cFF00BCD4Brann Bronzebeard's Lost Letter|r]. If it drops, use it to start the quest
.collect 20461,1,8308 
.accept 8308 >>Accept Brann Bronzebeard's Lost Letter
step
.goto Silithus,60.22,52.55
>>|TInterface/GossipFrame/HealerGossipIcon:0|tClick on the |cRXP_PICK_Gooey Nest|r on the top of the tower
>>Kill the two |cRXP_ENEMY_Hive'Ashi Ambushers|r that spawn. Loot them for a |cRXP_LOOT_Encrusted Silithid Object|r
>>|cRXP_WARN_Three|r |cRXP_ENEMY_Hive'Ashi Drones|r |cRXP_WARN_will spawn when you enter the bottom floor of the tower!|r
.complete 1126,1 
.mob Hive'Ashi Drone
.mob Hive'Ashi Ambusher
.group 2
step
.goto Silithus,81.87,18.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Layo|r
.turnin 1126 >>Turn in Hive in the Tower
.accept 6844 >>Accept Umber, Archivist
.target Layo Starstrike
.isQuestComplete 1126
.group
step
.goto Silithus,81.87,18.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Layo|r
.accept 6844 >>Accept Umber, Archivist
.target Layo Starstrike
.isQuestTurnedIn 1126
.group
step
#phase 4
#label s1
.goto Silithus,30.0,28.0,50,0
.loop 25,Silithus,19.5,21.1,20.1,15.5,21.5,12.8,21.7,9.4,24.1,9.8,26.6,13.3,24.1,15.5,21.5,22.0
>>Loot the blue |cRXP_PICK_Glowing Tablets|r on the ground for |cRXP_LOOT_Twilight Tablet Fragments|r
.complete 8284,1 
step
#phase 4
#completewith next
>>Kill |cRXP_ENEMY_Dredge Strikers|r
.complete 8280,1 
.mob Dredge Stalker
step
#phase 4
.loop 25,Silithus,51.6,16.4,54.6,13.2,58.4,13.6,62.6,16.6,61.4,21.6,63.2,24.0,64.8,28.2,67.6,32.0,60.6,30.6,56.4,32.8,53.0,28.0,54.8,21.8,51.6,16.4
>>Kill |cRXP_ENEMY_Stonelash Scorpids|r and |cRXP_ENEMY_Sand Skitterers|r. Loot them for their |cRXP_LOOT_Stingers|r and |cRXP_LOOT_Fangs|r
.complete 8277,1 
.complete 8277,2 
.mob Stonelash Scorpid
.mob Sand Skitterer
step
#phase 4
.loop 25,Silithus,51.6,16.4,54.6,13.2,58.4,13.6,62.6,16.6,61.4,21.6,63.2,24.0,64.8,28.2,67.6,32.0,60.6,30.6,56.4,32.8,53.0,28.0,54.8,21.8,51.6,16.4
>>Kill |cRXP_ENEMY_Dredge Strikers|r
.complete 8280,1 
.mob Dredge Stalker
step
#phase 4
.goto Silithus,49.70,37.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Larksbane|r
.turnin 8284 >>Turn in The Twilight Mystery
.accept 8285 >>Accept The Deserter
.target Geologist Larksbane
step
#phase 4
.goto Silithus,51.15,38.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Proudhorn|r
.turnin 8280 >>Turn in Securing the Supply Lines
.accept 8281 >>Accept Stepping Up Security
.target Windcaller Proudhorn
step
#phase 4
.goto Silithus,51.80,38.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Beetix|r
.turnin 8277 >>Turn in Deadly Desert Venom
.accept 8278 >>Accept Noggle's Last Hope
.target Beetix Ficklespragg
step
#phase 4
#completewith Deserter
.goto Silithus,39.31,53.33,0
>>Kill |cRXP_ENEMY_Dredge Crushers|r
>>|cRXP_WARN_Don't focus on this; you can finish it later|r
.complete 8281,1 
.mob Dredge Crusher
step
#phase 4
#completewith Deserter
.goto Silithus,62.52,64.00,0
.goto Silithus,50.73,55.99,0
>>Kill |cRXP_ENEMY_Stonelash Flayers|r and |cRXP_ENEMY_Stonelash Pincers|r. Loot them for their |cRXP_LOOT_Stingers|r
>>Kill |cRXP_ENEMY_Rock Stalkers|r. Loot them for their |cRXP_LOOT_Fangs|r
>>|cRXP_WARN_Don't focus on this; you can finish it later|r
.complete 8278,1 
.complete 8278,2 
.complete 8278,3 
.mob Stonelash Flayer
.mob Stonelash Pincer
.mob Rock Stalker
step
#phase 4
.goto Silithus,41.30,88.50,10,0
.goto Silithus,40.80,88.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rutgar|r and |cRXP_FRIENDLY_Frankal|r
.complete 8304,2 
.complete 8304,1 
.target Rutgar Glyphshaper
.target Frankal Stonebridge
.skipgossip
step
.goto Silithus,41.30,88.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rutgar|r again
.turnin 8308 >>Turn in Brann Bronzebeard's Lost Letter
.target Rutgar Glyphshaper
.isOnQuest 8308
step
#phase 4
#label Deserter
.goto Silithus,67.19,69.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hermit|r
.turnin 8285 >>Turn in The Deserter
.accept 8279 >>Accept The Twilight Lexicon
.target Hermit Ortell
step
#phase 4
#completewith next
>>Kill |cRXP_ENEMY_Dredge Crushers|r
.complete 8281,1 
.mob Dredge Crusher
step
#phase 4
.loop 25,Silithus,62.2,63.2,57.0,59.2,50.8,58.0,47.8,54.6,40.8,50.2,34.6,49.4,36.2,39.4,33.6,34.6,27.8,43.4,33.0,49.0,34.6,53.6,34.6,60.4,34.2,65.4,39.4,64.6,42.6,61.4,48.8,62.4,52.8,63.0,59.0,64.4,62.6,66.2,62.2,63.2
>>Kill |cRXP_ENEMY_Stonelash Pincers|r. Loot them for their |cRXP_LOOT_Stingers|r
.complete 8278,2 
.mob Stonelash Pincer
step
#phase 4
.loop 25,Silithus,62.2,63.2,57.0,59.2,50.8,58.0,47.8,54.6,40.8,50.2,34.6,49.4,36.2,39.4,33.6,34.6,27.8,43.4,33.0,49.0,34.6,53.6,34.6,60.4,34.2,65.4,39.4,64.6,42.6,61.4,48.8,62.4,52.8,63.0,59.0,64.4,62.6,66.2,62.2,63.2
>>Kill |cRXP_ENEMY_Dredge Crushers|r
.complete 8281,1 
.mob Dredge Crusher
step
#phase 4
.loop 25,Silithus,42.6,86.4,38.6,87.4,38.2,83.2,34.0,76.6,32.0,81.0,27.6,85.2,24.6,82.0,23.4,77.2,27.6,76.4,31.6,74.8,34.6,71.4,38.6,69.2,43.0,68.4,46.8,69.6,44.2,75.6,45.4,80.2,45.4,85.6,42.6,86.4
>>Kill |cRXP_ENEMY_Stonelash Flayers|r and |cRXP_ENEMY_Rock Stalkers|r. Loot them for their |cRXP_LOOT_Stingers|r and |cRXP_LOOT_Fangs|r
.complete 8278,1 
.complete 8278,3 
.mob Stonelash Flayer
.mob Rock Stalker
step
#phase 4
.goto Silithus,51.15,38.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Proudhorn|r
.turnin 8281 >>Turn in Stepping Up Security
.target Windcaller Proudhorn
step
#phase 4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Beetix|r and |cRXP_FRIENDLY_Noggle|r
.turnin 8278 >>Turn in Noggle's Last Hope
.goto Silithus,51.80,38.51
.accept 8282 >>Accept Noggle's Lost Satchel
.goto Silithus,51.62,38.50
.target Beetix Ficklespragg
.target Noggle Ficklespragg
step
#phase 4
.goto Silithus,49.20,34.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mar'alith|r
.turnin 8304 >>Turn in Dearest Natalia
.target Commander Mar'alith
step
#phase 4
#completewith LexiconChapter2
>>Kill |cRXP_ENEMY_Twilight Cultists|r. Loot them for their |cRXP_LOOT_Encrypted Twilight Texts|r
>>|cRXP_ENEMY_Twilight Keepers|r|cRXP_WARN_,|r |cRXP_ENEMY_Overlords|r |cRXP_WARN_and|r |cRXP_ENEMY_Masters|r |cRXP_WARN_have very high burst potential|r
.collect 20404,10,8323,1 
.mob Twilight Stonecaller
.mob Twilight Avenger
.mob Twilight Geolord
.mob Twilight Flamereaver
.mob Twilight Master
.mob Twilight Overlord
.mob Twilight Marauder
step
#phase 4
.goto Silithus,40.86,42.22
>>Kill |cRXP_ENEMY_Twilight Keeper Havunth|r. Loot him for his |cRXP_LOOT_Twilight Lexicon Chapter|r
>>He patrols the east side of the camp that's just southwest of Cenarion Hold
>>|cRXP_WARN_Be careful, he has very high burst|r
.complete 8279,3 
.unitscan Twilight Keeper Havunth
step
#phase 4
.goto Silithus,26.34,36.62
>>Kill |cRXP_ENEMY_Twilight Keeper Mayna|r. Loot her for her |cRXP_LOOT_Twilight Lexicon Chapter|r
>>She patrols the camp far west of Cenarion Hold
>>|cRXP_WARN_Be careful, she has Psychic Scream (instant fear)|r
.complete 8279,1 
.unitscan Twilight Keeper Mayna
step
#phase 4
#label LexiconChapter2
.goto Silithus,16.08,86.37
>>Kill |cRXP_ENEMY_Twilight Keeper Exeter|r. Loot him for his |cRXP_LOOT_Twilight Lexicon Chapter|r
>>He's at the back of the camp very far to the southwest of Cenarion Hold/northwest of Ahn'Qiraj
>>|cRXP_WARN_Be careful, he has a stun and mortal strike|r
.complete 8279,2 
.unitscan Twilight Keeper Exeter
step
#phase 4
#completewith next
>>Loot |cRXP_LOOT_Noggle's Satchel|r
.complete 8282,1 
.unitscan Deathclasp
.group
step
#phase 4
.goto Silithus,45.00,92.20
>>Split pull the adds that patrol with |cRXP_ENEMY_Deathclasp|r. Kite them until |cRXP_ENEMY_Deathclasp|r resets, then kill them
>>Kill |cRXP_ENEMY_Deathclasp|r. Loot him for his |cRXP_LOOT_Pincer|r. Do everything that you can to prevent him from getting into melee range
>>|cRXP_WARN_This quest mob hits hard and has a poison debuff that can stun for 8 seconds. This quest is extremely dangerous if you are unfamiliar/unprepared; skip it if necessary|r
.complete 8283,1 
.mob Stonelash Flayer
.unitscan Deathclasp
.group 3
step
#phase 4
.goto Silithus,44.50,91.40
>>Loot |cRXP_LOOT_Noggle's Satchel|r on the ground
.complete 8282,1 
.unitscan Deathclasp
.group
step
#phase 4
.goto Silithus,44.50,91.40
>>Loot |cRXP_LOOT_Noggle's Satchel|r on the ground
>>|cRXP_WARN_Be careful not to aggro Deathclasp|r
.complete 8282,1 
.unitscan Deathclasp
.solo
step
#phase 4
.goto Silithus,67.20,69.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hermit|r
.turnin 8279 >>Turn in The Twilight Lexicon
.accept 8287 >>Accept A Terrible Purpose
.accept 8323 >>Accept True Believers
.turnin 8323 >>Turn in True Believers
.target Hermit Ortell
step

step
#phase 4
.goto Silithus,50.80,33.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vish|r
.turnin 8283 >>Turn in Wanted - Deathclasp, Terror of the Sands
.target Vish Kozus
.isQuestComplete 8283
.group
step
#phase 4
.goto Silithus,51.62,38.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Noggle|r
.turnin 8282 >>Turn in Noggle's Lost Satchel
.target Noggle Ficklespragg
step
#phase 4
.goto Silithus,49.20,34.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mar'alith|r
.turnin 8287 >>Turn in A Terrible Purpose
.target Commander Mar'alith
step
#phase 4
.loop 25,Silithus,38.8,45.4,38.2,43.8,38.8,42.6,40.4,42.4,41.4,45.6,40.0,46.2,38.8,45.4
>>Kill |cRXP_ENEMY_Twilight Cultists|r. Loot them for their |cRXP_LOOT_Encrypted Twilight Texts|r
>>|cRXP_ENEMY_Twilight Keepers|r|cRXP_WARN_,|r |cRXP_ENEMY_Overlords|r |cRXP_WARN_and|r |cRXP_ENEMY_Masters|r |cRXP_WARN_have very high burst potential|r
.complete 8318,1 
.mob Twilight Stonecaller
.mob Twilight Avenger
.mob Twilight Geolord
.mob Twilight Flamereaver
.mob Twilight Master
.mob Twilight Overlord
.mob Twilight Marauder
step
#phase 4
.goto Silithus,48.57,37.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bor|r
.turnin 8318 >>Turn in Secret Communication
.target Bor Wildmane
step
.goto Silithus,48.69,36.67,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Runk|r
.fly Un'Goro >>Fly to Un'Goro Crater
.target Runk Windtamer
.zoneskip Un'Goro Crater
step
.goto Un'Goro Crater,44.65,8.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Linken|r
.turnin 3962 >>Turn in It's Dangerous to Go Alone 
.target Linken
.isQuestComplete 3962
.group
step
#completewith end
.goto Un'Goro Crater,45.23,5.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryfe|r
.fly Tanaris >>Fly to Tanaris
.target Gryfe
.zoneskip Tanaris
step
.goto Tanaris,51.56,26.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tran'rek|r
.turnin 4504 >>Turn in Super Sticky
.target Tran'rek
step
.goto Tanaris,50.88,26.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pestlezugg|r
.turnin 4507 >>Turn in Pawn Captures Queen
.accept 4509 >>Accept Calm Before the Storm
.target Alchemist Pestlezugg
.isQuestComplete 4507
.group
step
#label end
.goto Tanaris,50.88,26.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pestlezugg|r
.accept 4509 >>Accept Calm Before the Storm
.target Alchemist Pestlezugg
.isQuestTurnedIn 4507
.group
]])
RXPGuides.RegisterGuide([[
#hardcore
#classic
<< Horde
#version 7
#group RestedXP Survival Guide (H)
#subgroup RXP Survival Guide 50-60
#name 59-60 Winterspring/Silithus II
step
#completewith next
.goto Tanaris,51.60,25.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bullkrek|r
.fly Un'Goro Crater >>Fly to Un'Goro Crater
.target Bullkrek Ragefist
.zoneskip Un'Goro Crater
step
.goto Un'Goro Crater,44.65,8.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Linken|r
.turnin 3962 >>Turn in It's Dangerous to Go Alone
.target Linken
.isQuestComplete 3962
.group
step
#completewith tanaris
.goto Un'Goro Crater,45.23,5.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryfe|r
.fly Tanaris >>Fly to Tanaris
.target Gryfe
.zoneskip Tanaris
step
.goto Tanaris,50.88,26.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pestlezugg|r
.turnin 4507 >>Turn in Pawn Captures Queen
.accept 4509 >>Accept Calm Before the Storm
.target Alchemist Pestlezugg
.isQuestComplete 4507
.group
step
.goto Tanaris,50.88,26.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pestlezugg|r
.accept 4509 >>Accept Calm Before the Storm
.target Alchemist Pestlezugg
.isQuestTurnedIn 4507
.group
step
#label tanaris
.goto Tanaris,51.56,26.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tran'rek|r
.turnin 4504 >>Turn in Super Sticky
.target Tran'rek
step
#completewith next
.hs >>Hearth to Everlook
.use 6948
.zoneskip Winterspring
step
.goto Winterspring,61.36,38.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vizzie|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Vizzie
step
.goto Winterspring,60.88,37.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umi|r
.turnin 5163 >>Turn in Are We There, Yeti?
.target Umi Rumplesnicker
step << Druid
.cast 18960 >>Cast |T135758:0|t[Teleport: Moonglade]
.zoneskip Moonglade
step << !Druid
#label moonglade
.goto Winterspring,60.47,36.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yugrek|r
.fly Moonglade>>Fly to Moonglade
.target Yugrek
.zoneskip Moonglade
step
.goto Moonglade,44.88,35.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umber|r
.turnin 6844 >>Turn in Umber, Archivist
.accept 6845 >>Accept Uncovering Past Secrets
.target Umber
.isQuestTurnedIn 1126
.group
step
.goto Moonglade,51.68,45.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rabine|r
.turnin 6845 >>Turn in Uncovering Past Secrets
.target Rabine Saturna
.isQuestTurnedIn 1126
.group
step
.goto Moonglade,51.68,45.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rabine|r
.turnin 5527 >>Turn in A Reliquary of Purity
.target Rabine Saturna
.isQuestComplete 5527
step
.goto Moonglade,44.87,35.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umber|r
.accept 1185 >>Accept Under the Chitin Was...
.turnin 1185 >>Turn in Under the Chitin Was...
.target Umber
.isQuestTurnedIn 1126
.group
step << !Mage
.goto Moonglade,32.10,66.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Faustron|r
.fly Orgrimmar>>Fly to Orgrimmar
.target Faustron
.zoneskip Orgrimmar
step << Mage
.cast 3567 >>Cast |T135759:0|t[Teleport: Orgrimmar]
.zoneskip Orgrimmar
step
.goto Orgrimmar,56.50,46.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zilzibin|r
.turnin 4509 >>Turn in Calm Before the Storm
.accept 4511 >>Accept Calm Before the Storm
.target Zilzibin Drumlore
.isQuestTurnedIn 4507
.group
step
#ah
.goto Orgrimmar,63.62,51.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rashona|r
>>|cRXP_WARN_Disable any other addons that automatically turn in reputation items, or you'll be told to buy cloth again later|r
.turnin 7826 >>Turn in A Donation of Wool
.turnin 7827 >>Turn in A Donation of Silk
.turnin 7831 >>Turn in A Donation of Mageweave
.turnin 7824 >>Turn in A Donation of Runecloth
.target Rashona Straglash
step
#ah
#completewith next
.goto Orgrimmar,50.68,70.37,0
>>If you bought enough cloth earlier, go to the mailbox and retrieve the following:
.collect 2592,60 
.collect 4306,60 
.collect 4338,60 
.collect 14047,60 
step
#ah
.goto Orgrimmar,37.69,87.92
>>|cRXP_WARN_Disable any other addons that automatically turn in reputation items, or you'll be told to buy cloth again later|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vehena|r
.turnin 7833 >>Turn in A Donation of Wool
.turnin 7834 >>Turn in A Donation of Silk
.turnin 7835 >>Turn in A Donation of Mageweave
.turnin 7836 >>Turn in A Donation of Runecloth
.target Vehena
step
.goto Orgrimmar,49.70,69.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karus|r
.turnin 4511 >>Turn in Calm Before the Storm
.target Karus
.isQuestTurnedIn 4507
.group
step
.goto Orgrimmar,54.10,68.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grysha|r
.home >>Set your Hearthstone to Orgrimmar
.target Innkeeper Grysha
step << Mage
.cast 3563 >>Cast |T135766:0|t[Teleport: Undercity]
.zoneskip Undercity
step << !Mage
#completewith next
.zone Durotar >> Leave Orgrimmar
.zoneskip Durotar
step << !Mage
.goto Durotar,50.8,13.8,40 >>Go up the Zeppelin Tower
.zone Tirisfal Glades >>Take the Zeppelin to Tirisfal Glades
.zoneskip Tirisfal Glades
step
.goto Undercity,48.50,71.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cuely|r
.turnin 4642 >>Turn in Melding of Influences
.target Chemist Cuely
step
#completewith next
.goto Tirisfal Glades,61.9,59.1
.zone Stranglethorn Vale >> Take the zeppelin to Grom'gol Basecamp
.zoneskip Stranglethorn Vale
step
.goto Stranglethorn Vale,32.5,29.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thysta|r
.fly Stonard>> Fly to Stonard
.target Thysta
.zoneskip Swamp of Sorrows
step
.goto Swamp of Sorrows,34.29,66.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r
.accept 2681 >>Accept The Stones That Bind Us
.target Fallen Hero of the Horde
step
#completewith Stonesthat
+Drag |cRXP_ENEMY_Servants|r towards a nearby |cRXP_PICK_Stone of Binding|r, then get them to 1% HP
+|TInterface/GossipFrame/HealerGossipIcon:0|tClick the |cRXP_PICK_Stone of Binding|r when the |cRXP_ENEMY_Servant|r becomes banished, then finish them off
step
#completewith next
>>Kill |cRXP_ENEMY_Servants of Allistarj|r
.complete 2681,3,1 
.mob Servant of Allistarj
step
.goto Blasted Lands,43.6,11.8,50,0
.goto Blasted Lands,41.6,14.2,50,0
.goto Blasted Lands,49.4,43.6
>>Kill |cRXP_ENEMY_Servants of Grol|r
.complete 2681,2,1 
.mob Servant of Grol
step
#completewith next
.goto Blasted Lands,43.4,40.4,50,0
.goto Blasted Lands,41.6,39.6,50,0
.goto Blasted Lands,38.6,34.0
>>Kill |cRXP_ENEMY_Servants of Allistarj|r
.complete 2681,3,1 
.mob Servant of Allistarj
step
.loop 25,Blasted Lands,53.2,59.6,51.8,56.8,53.8,53.6,55.6,51.0,60.0,50.6,62.2,51.6,63.8,55.8,62.2,51.6,60.0,50.6,55.6,51.0,53.8,53.6,51.8,56.8,53.2,59.6
>>Kill |cRXP_ENEMY_Servants of Razelikh|r
.complete 2681,1 
.mob Servant of Razelikh
step
#label Stonesthat
.goto Blasted Lands,64.6,46.6,50,0
.goto Blasted Lands,64.0,40.6,50,0
.goto Blasted Lands,64.8,34.6
>>Kill |cRXP_ENEMY_Servants of Sevine|r
.complete 2681,4,1 
.mob Servant of Sevine
step
#completewith next
.zone Swamp of Sorrows >>Travel to the Swamp of Sorrows
step
.goto Blasted Lands,52.76,2.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r
.turnin 2681 >>Turn in The Stones That Bind Us
.accept 2702 >>Accept Heroes of Old
.target Fallen Hero of the Horde
step
.goto Swamp of Sorrows,34.29,66.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r again
.turnin 2702 >>Turn in Heroes of Old
.accept 2701 >>Accept Heroes of Old
.target Fallen Hero of the Horde
step
.goto Swamp of Sorrows,34.29,66.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fallen Hero of the Horde|r one last time
.turnin 2701 >>Turn in Heroes of Old
.target Fallen Hero of the Horde
step
.hs >>Hearth to Orgrimmar
.use 6948
.zoneskip Orgrimmar
step
.goto Orgrimmar,45.13,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Azshara >>Fly to Azshara
.target Doras
.zoneskip Azshara
step
.loop 25,Azshara,55.8,25.9,57.8,26.4,58.0,28.2,59.2,29.6,57.9,31.4,57.0,30.3,56.9,27.5,56.0,29.7,55.4,29.7,55.8,25.9
.xp 60 >>Grind to level 60
]])
