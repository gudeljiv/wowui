RXPGuides.RegisterGuide([[
#version 5
#cata
#Cata
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 59-61 Hellfire Peninsula
#displayname 58-61 Hellfire Peninsula << !tbc !wotlk
#version 5
#next 61-63 Zangarmarsh
step << tbc
#xprate <1.5
#completewith honorhold
+As you quest through Outland, try to do as many group quests as you can, if you skip elite quests or dungeon quests you might have to grind about 1/3 of a level later after finishing Blade's Edge at level 66
step << tbc
#completwith next
.goto Stormwind City,66.28,62.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dungar Longdrink|r
.fly Nethergarde Keep >> Fly to Nethergarde Keep
.zoneskip Blasted Lands
.target Dungar Longdrink
step << !TBC
#completewith next
.goto Stormwind City,48.99,87.36
.zone Blasted Lands >> Take the portal from Stormwind to Blasted Lands
step << tbc/wotlk
.goto Blasted Lands,66.57,18.95,20,0
.goto Blasted Lands,67.57,19.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ambassador Ardalan|r up inside the tower
.accept 2783 >> Accept Petty Squabbles
.zoneskip Hellfire Peninsula
.target Ambassador Ardalan
step

.goto Blasted Lands,64.22,16.64,20,0
.goto Blasted Lands,63.51,17.01
>>Go inside Nethergarde Keep
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bernie Heisten|r on the bottom floor
>>|cRXP_BUY_Buy a|r |T132791:0|t[|cRXP_LOOT_Nethergarde Bitter|r]
.collect 23848,1,9563,1 
.target Bernie Heisten

step << tbc/wotlk
.goto Swamp of Sorrows,34.28,66.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r on the border of Swamp of Sorrows
.turnin 2783 >> Turn in Petty Squabbles
.accept 2801 >> Accept A Tale of Sorrow
.complete 2801,1 
.skipgossip 7572,1
.zoneskip Hellfire Peninsula
.target Fallen Hero of the Horde
step << tbc/wotlk
.goto Swamp of Sorrows,34.28,66.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r on the border of Swamp of Sorrows
.turnin 2801 >> Turn in A Tale of Sorrow
.zoneskip Hellfire Peninsula
.target Fallen Hero of the Horde
step
#optional
.goto Blasted Lands,58.33,55.90 << tbc/wotlk
.goto 1419/0,-3196.90015,-11815.10059 << !tbc !wotlk
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Watch Commander Relthorn Netherwane|r outside the Dark Portal
.turnin -64038 >>Turn in The Dark Portal
.accept 10119 >> Accept Through the Dark Portal
.isOnQuest 64038
.target Watch Commander Relthorn Netherwane
step
.goto Blasted Lands,58.33,55.90 << tbc/wotlk
.goto 1419/0,-3196.90015,-11815.10059 << !tbc !wotlk
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Watch Commander Relthorn Netherwane|r outside the Dark Portal
.accept 10119 >> Accept Through the Dark Portal
.target Watch Commander Relthorn Netherwane
step

#completewith next
.goto Blasted Lands,58.74,60.28
.zone Hellfire Peninsula >> Go through the Dark Portal
step
.goto Hellfire Peninsula,87.32,50.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Duron|r
.turnin 10119 >> Turn in Through the Dark Portal
.accept 10288 >> Accept Arrival in Outland
.target Commander Duron
step
.goto Hellfire Peninsula,87.36,52.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amish Wildhammer|r
.turnin 10288 >> Turn in Arrival in Outland
.accept 10140 >> Accept Journey to Honor Hold
.target Amish Wildhammer
step
#completewith next
.goto Hellfire Peninsula,87.36,52.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amish Wildhammer|r
.fly Honor Hold >> Fly to Honor Hold
.target Amish Wildhammer
step
.goto Hellfire Peninsula,54.47,62.80,20,0
.goto Hellfire Peninsula,54.84,62.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Marshal Isildor|r
.turnin 10140 >> Turn in Journey to Honor Hold
.accept 10254 >> Accept Force Commander Danath
.target Marshal Isildor
step
#completewith next
.goto Hellfire Peninsula,54.81,63.61,15,0
.goto Hellfire Peninsula,54.67,63.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Marshal Isildor|r
.vendor >>|cRXP_BUY_Buy some gems from |cRXP_FRIENDLY_Markus Scylan|r for later quest gear rewards if you wish|r
.target Markus Scylan
step
#completewith HonorHS
.goto Hellfire Peninsula,54.22,63.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sid Limbardi|r
.home >> Set your Hearthstone to Honor Hold
>>Buy some of the new food/water if needed << !Warrior !Rogue !DK
>>Buy some of the new food if needed << Warrior/Rogue/DK
.target Sid Limbardi
step
.goto Hellfire Peninsula,56.37,65.99,20,0
.goto Hellfire Peninsula,56.61,66.77,14,0
.goto Hellfire Peninsula,56.64,66.70
>>Go inside the Keep to the top floor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Force Commander Danath Trollbane|r
.turnin 10254 >> Turn in Force Commander Danath
.accept 10160 >> Accept Know your Enemy
.accept 10141 >> Accept The Legion Reborn
.target Force Commander Danath Trollbane
step
>>Travel to the tower
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dumphry|r and |cRXP_FRIENDLY_Amadi|r
.accept 10055 >> Accept Waste Not, Want Not
.goto Hellfire Peninsula,51.30,60.35,20,0
.goto Hellfire Peninsula,51.19,59.99,20,0
.goto Hellfire Peninsula,50.99,60.51
.target +Dumphry
.turnin 10160 >> Turn in Know your Enemy
.accept 10482 >> Accept Fel Orc Scavengers
.goto Hellfire Peninsula,50.91,60.19
.target +Lieutenant Amadi
step
#loop
.goto Hellfire Peninsula,54.53,54.12,50,0
.goto Hellfire Peninsula,54.23,52.51,50,0
.goto Hellfire Peninsula,55.53,53.32,50,0
.goto Hellfire Peninsula,57.07,53.05,50,0
.goto Hellfire Peninsula,57.62,51.67,50,0
.goto Hellfire Peninsula,58.55,52.43,50,0
.goto Hellfire Peninsula,59.54,51.80,50,0
.goto Hellfire Peninsula,62.09,50.91,50,0
.goto Hellfire Peninsula,54.53,54.12,50,0
.goto Hellfire Peninsula,54.53,54.12,0
>>Kill |cRXP_ENEMY_Bonechewers|r
>>Loot the |cRXP_PICK_Metal|r and |cRXP_PICK_Wood|r on the ground
>>|cRXP_WARN_Avoid|r |cRXP_ENEMY_Tagar Spinebreaker|r |cRXP_WARN_who is a level 61 elite that patrols the area|r
.complete 10482,1 
.mob +Bonechewer Mutant
.mob +Bonechewer Raider
.mob +Bonechewer Peon
.mob +Bonechewer Scavenger
.mob +Bonechewer Evoker
.mob +Bonechewer Orc
.complete 10055,1 
.complete 10055,2 
.unitscan Tagar Spinebreaker
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dumphry|r and |cRXP_FRIENDLY_Amadi|r
.turnin 10055 >> Turn in Waste Not, Want Not
.accept 10078 >> Accept Laying Waste to the Unwanted
.goto Hellfire Peninsula,51.30,60.35,20,0
.goto Hellfire Peninsula,51.19,59.99,20,0
.goto Hellfire Peninsula,50.99,60.51
.target +Dumphry
.turnin 10482 >> Turn in Fel Orc Scavengers
.accept 10483 >> Accept Ill Omens
.goto Hellfire Peninsula,50.91,60.19
.target +Lieutenant Amadi
step
>>Travel to the East Supply Caravan
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sergeant Altumus|r
.goto Hellfire Peninsula,61.74,60.67,15,0
.goto Hellfire Peninsula,61.69,60.90
.turnin 10141 >> Turn in The Legion Reborn
.accept 10142 >> Accept The Path of Anguish
.target Sergeant Altumus
step
#loop
.line Hellfire Peninsula,65.83,59.06,67.03,58.91,69.16,59.36,69.64,57.71,68.15,56.25,67.55,54.60,66.82,56.63,65.55,55.62,65.83,59.06
.goto Hellfire Peninsula,65.83,59.06,50,0
.goto Hellfire Peninsula,67.03,58.91,50,0
.goto Hellfire Peninsula,69.16,59.36,50,0
.goto Hellfire Peninsula,69.64,57.71,50,0
.goto Hellfire Peninsula,68.15,56.25,50,0
.goto Hellfire Peninsula,67.55,54.60,50,0
.goto Hellfire Peninsula,66.82,56.63,50,0
.goto Hellfire Peninsula,65.55,55.62,50,0
.goto Hellfire Peninsula,65.83,59.06,50,0
>>Kill a |cRXP_ENEMY_Dreadcaller|r, |cRXP_ENEMY_Flamewaker Imps|r and |cRXP_ENEMY_Infernal Warbringers|r
.complete 10142,1 
.mob +Dreadcaller
.complete 10142,2 
.mob +Flamewaker Imp
.complete 10142,3 
.mob +Infernal Warbringer
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sergeant Altumus|r
.goto Hellfire Peninsula,61.74,60.67,15,0
.goto Hellfire Peninsula,61.69,60.90
.turnin 10142 >> Turn in The Path of Anguish
.accept 10143 >> Accept Expedition Point
.target Sergeant Altumus
step
.goto Hellfire Peninsula,67.88,66.92,50,0
.goto Hellfire Peninsula,70.53,68.13,50,0
.goto Hellfire Peninsula,70.79,71.38
>>Kill |cRXP_ENEMY_Bleeding Hollow Orcs|r. Loot them for a |cRXP_LOOT_Talisman|r
.complete 10483,1 
.mob Bleeding Hollow Dark Shaman
.mob Bleeding Hollow Grunt
.mob Bleeding Hollow Necrolyte
.mob Bleeding Hollow Tormentor
.mob Bleeding Hollow Peon
step
.goto 1944/530,1875.7,-702.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Corporal Ironridge|r
.target Corporal Ironridge
.turnin 10483 >>Turn in Ill Omens
.accept 10484 >>Accept Cursed Talismans
step
#label HonorHS
>>Travel to Expedition Point
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Forward Commander Kingston|r and |cRXP_FRIENDLY_Wing Commander Dabir'ee|r
.turnin 10143 >> Turn in Expedition Point
.accept 10144 >> Accept Disrupt Their Reinforcements
.goto Hellfire Peninsula,71.34,62.76
.target +Forward Commander Kingston
.accept 10895 >> Accept Zeth'Gor Must Burn!
.goto Hellfire Peninsula,71.41,62.48
.target +Wing Commander Dabir'ee
step
.goto Hellfire Peninsula,71.57,59.63,50,0
.goto Hellfire Peninsula,73.12,59.90,50,0
.goto Hellfire Peninsula,73.23,58.36
>>Kill |cRXP_ENEMY_Demons|r. Loot them for their |cRXP_LOOT_Rune Stones|r
.collect 28513,4,10144,1 
.mob Subjugator Shi'aziv
.mob Fel Handler
.mob Wrathguard
.mob Doomwhisperer
.mob Netherhound
step
.goto Hellfire Peninsula,72.73,58.94
>>Click |cRXP_PICK_Portal Kaalez|r to disrupt it
.complete 10144,2 
step << skip
.goto Hellfire Peninsula,71.80,52.87,50,0
.goto Hellfire Peninsula,70.83,55.36,50,0
.goto Hellfire Peninsula,72.05,55.28,50,0
.goto Hellfire Peninsula,71.57,59.63,50,0
.goto Hellfire Peninsula,73.12,59.90,50,0
.goto Hellfire Peninsula,73.23,58.36
>>Kill |cRXP_ENEMY_Demons|r. Loot them for their |cRXP_LOOT_Rune Stones|r
.collect 28513,4 
.isOnQuest 10144
.mob Subjugator Shi'aziv
.mob Fel Handler
.mob Wrathguard
.mob Doomwhisperer
.mob Netherhound

step
.goto Hellfire Peninsula,71.49,55.17
>>Kill |cRXP_ENEMY_Demons|r. Loot them for |cRXP_LOOT_Rune Stones|r. Then click |cRXP_PICK_Portal Grimh|r to disrupt it
.collect 28513,4,10144,1,-1 
.complete 10144,1 
.mob Subjugator Shi'aziv
.mob Fel Handler
.mob Wrathguard
.mob Doomwhisperer
.mob Netherhound
step
#label Disrupt
.goto Hellfire Peninsula,71.34,62.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Forward Commander Kingston|r
.turnin 10144 >> Turn in Disrupt Their Reinforcements
.accept 10146 >> Accept Mission: The Murketh and Shaadraz Gateways
.target Forward Commander Kingston
step
#completewith next
.goto Hellfire Peninsula,71.41,62.48
.fly >> |Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Dabir'ee|r to start the bombing run
.skipgossip 19409,1
.timer 102,Mission: Gateways Flight
.target Wing Commander Dabir'ee
step
.use 28038 >>|cRXP_WARN_Use the|r |T133712:0|t[Seaforium PU-36 Explosive Nether Modulator] |cRXP_WARN_on |cRXP_PICK_Gateway Shaadraz|r and |cRXP_PICK_Gateway Murketh|r during the flight|r
.complete 10146,2 
.goto Hellfire Peninsula,77.73,51.80,-1
.complete 10146,1 
.goto Hellfire Peninsula,78.00,47.24,-1
step
.goto Hellfire Peninsula,71.34,62.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Forward Commander Kingston|r
.turnin 10146 >> Turn in Mission: The Murketh and Shaadraz Gateways
.accept 10340 >> Accept Shatter Point
.target Forward Commander Kingston
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Bleeding Hollow Orcs|r. Loot them for their |cRXP_LOOT_Talismans|r
.complete 10484,1 
.mob Bleeding Hollow Dark Shaman
.mob Bleeding Hollow Grunt
.mob Bleeding Hollow Necrolyte
.mob Bleeding Hollow Tormentor
.mob Bleeding Hollow Peon
.mob Worg Master Kruush
step
.use 31739 >>|cRXP_WARN_Use the|r |T132622:0|t[Smoke Beacon] |cRXP_WARN_on the four Towers|r
.complete 10895,3 
.goto Hellfire Peninsula,70.05,69.11
.complete 10895,4 
.goto Hellfire Peninsula,70.86,71.35
.complete 10895,2 
.goto Hellfire Peninsula,66.45,76.47
.complete 10895,1 
.goto Hellfire Peninsula,67.95,66.87
step
#loop
.line Hellfire Peninsula,68.13,69.69,69.16,69.29,70.05,69.12,70.85,71.32,68.88,72.50,69.44,75.37,69.10,76.55,68.58,75.71,66.44,76.44,68.13,69.69
.goto Hellfire Peninsula,68.13,69.69,50,0
.goto Hellfire Peninsula,69.16,69.29,50,0
.goto Hellfire Peninsula,70.05,69.12,50,0
.goto Hellfire Peninsula,70.85,71.32,50,0
.goto Hellfire Peninsula,68.88,72.50,50,0
.goto Hellfire Peninsula,69.44,75.37,50,0
.goto Hellfire Peninsula,69.10,76.55,50,0
.goto Hellfire Peninsula,68.58,75.71,50,0
.goto Hellfire Peninsula,66.44,76.44,50,0
.goto Hellfire Peninsula,68.13,69.69,50,0
>>Kill |cRXP_ENEMY_Bleeding Hollow Orcs|r. Loot them for their |cRXP_LOOT_Talismans|r
.complete 10484,1 
.mob Bleeding Hollow Dark Shaman
.mob Bleeding Hollow Grunt
.mob Bleeding Hollow Necrolyte
.mob Bleeding Hollow Tormentor
.mob Bleeding Hollow Peon
.mob Worg Master Kruush
step
.goto Hellfire Peninsula,70.97,63.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Corporal Ironridge|r
.turnin 10484 >> Turn in Cursed Talismans
.accept 10485 >> Accept Warlord of the Bleeding Hollow
.target Corporal Ironridge
step
.goto Hellfire Peninsula,71.41,62.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Dabir'ee|r
.turnin 10895 >> Turn in Zeth'Gor Must Burn!
.target Wing Commander Dabir'ee
step
.goto Hellfire Peninsula,69.65,76.48,15,0
.goto Hellfire Peninsula,70.47,76.15,15,0
.goto Hellfire Peninsula,70.08,77.08
>>Enter the Stronghold
>>Kill |cRXP_ENEMY_Warlord Morkh|r. Loot him for his |cRXP_LOOT_Armor|r
.complete 10485,1 
.mob Warlord Morkh
step
.goto Hellfire Peninsula,70.97,63.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Corporal Ironridge|r
.turnin 10485 >> Turn in Warlord of the Bleeding Hollow
.accept 10903 >> Accept Return to Honor Hold
.target Corporal Ironridge
step
#completewith next
.goto Hellfire Peninsula,71.41,62.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Dabir'ee|r
.gossip 19409,1 >> Fly to Shatter Point
.skipgossip 19409,1
.timer 56,Shatter Point Flight
.target Wing Commander Dabir'ee
step
.goto Hellfire Peninsula,78.42,34.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Runetog Wildhammer|r
.target Runetog Wildhammer
.turnin 10340 >>Turn in Shatter Point
.accept 10344 >>Accept Wing Commander Gryphongar
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Gryphongar|r
.goto Hellfire Peninsula,79.34,33.86
.turnin 10344 >> Turn in Wing Commander Gryphongar
.accept 10163 >> Accept Mission: The Abyssal Shelf
.target Wing Commander Gryphongar
step
#completewith next
.goto Hellfire Peninsula,78.25,34.45
.gossip 20235,1 >>Talk to |cRXP_FRIENDLY_Gryphoneer Windbellow|r to fly to the Abyssal Shelf. If you don't kill everything after the first flight, talk to her again
.timer 154,Mission: The Abyssal Shelf Flight
.skipgossip 20235,1
.target Gryphoneer Windbellow
step
.goto Hellfire Peninsula,72.21,23.78,-1
.goto Hellfire Peninsula,72.60,19.99,-1
.goto Hellfire Peninsula,73.04,15.18,-1
.goto Hellfire Peninsula,72.69,11.19,-1
.use 28132 >>|cRXP_WARN_Use the|r |T133709:0|t[Area 52 Special] |cRXP_WARN_on the |cRXP_ENEMY_Gan'arg Peons|r, |cRXP_ENEMY_Mo'arg Overseers|r and |cRXP_ENEMY_Fel Cannons|r during the flight|r
.complete 10163,1 
.mob +Gan'arg Peon
.complete 10163,2 
.mob +Mo'arg Overseer
.complete 10163,3 
.mob +Fel Cannon
step
.goto Hellfire Peninsula,79.34,33.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Gryphongar|r
.turnin 10163 >> Turn in Mission: The Abyssal Shelf
.accept 10382 >> Accept Go to the Front
.target Wing Commander Gryphongar
step
#completewith next
.goto Hellfire Peninsula,78.25,34.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryphoneer Windbellow|r
.fly Honor Point >> Fly to Honor Point
.skipgossip 20235,1
.timer 40,Honor Point Flight
.target Gryphoneer Windbellow
step
.goto Hellfire Peninsula,68.29,28.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Field Marshal Brock|r
.turnin 10382 >> Turn in Go to the Front
.accept 10394 >> Accept Disruption - Forge Camp: Mageddon
.target Field Marshal Brock
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Gan'arg Servants|r
.complete 10394,1 
.mob Gan'arg Servant
step
#loop
.goto Hellfire Peninsula,65.55,32.56,40,0
.goto Hellfire Peninsula,65.06,31.45,40,0
.goto Hellfire Peninsula,64.53,32.48,40,0
.goto Hellfire Peninsula,64.14,31.94,40,0
.goto Hellfire Peninsula,64.16,30.67,40,0
.goto Hellfire Peninsula,65.42,29.81,40,0
.goto Hellfire Peninsula,66.06,31.33,40,0
.goto Hellfire Peninsula,65.55,32.56,40,0
.line Hellfire Peninsula,65.55,32.56,65.06,31.45,64.53,32.48,64.14,31.94,64.16,30.67,65.42,29.81,66.06,31.33,65.55,32.56
>>Kill |cRXP_ENEMY_Razorsaw|r
>>|cRXP_ENEMY_Razorsaw|r |cRXP_WARN_patrols counter-clockwise around the camp|r
.complete 10394,2 
.unitscan Razorsaw
step
#loop
.goto Hellfire Peninsula,63.50,31.00,50,0
.goto Hellfire Peninsula,64.32,33.31,50,0
.goto Hellfire Peninsula,65.88,32.45,50,0
.goto Hellfire Peninsula,66.09,30.07,50,0
.goto Hellfire Peninsula,59.62,32.39,50,0
.goto Hellfire Peninsula,58.07,32.87,50,0
.goto Hellfire Peninsula,58.07,32.87,0
>>Kill |cRXP_ENEMY_Gan'arg Servants|r
.complete 10394,1 
.mob Gan'arg Servant
step
.goto Hellfire Peninsula,68.29,28.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Field Marshal Brock|r
.turnin 10394 >> Turn in Disruption - Forge Camp: Mageddon
.accept 10396 >> Accept Enemy of my Enemy...
.target Field Marshal Brock
step
#loop
.goto Hellfire Peninsula,66.57,32.01,50,0
.goto Hellfire Peninsula,65.48,33.49,50,0
.goto Hellfire Peninsula,64.53,33.17,50,0
.goto Hellfire Peninsula,64.10,33.47,50,0
.goto Hellfire Peninsula,63.40,32.49,50,0
.goto Hellfire Peninsula,63.51,31.06,50,0
.goto Hellfire Peninsula,63.51,31.06,0
>>Kill |cRXP_ENEMY_Fel Cannon MKIs|r
.complete 10396,1 
.mob Fel Cannon MKI
step
.goto Hellfire Peninsula,68.29,28.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Field Marshal Brock|r
.turnin 10396 >> Turn in Enemy of my Enemy...
.accept 10397 >> Accept Invasion Point: Annihilator
.target Field Marshal Brock
step
.goto Hellfire Peninsula,53.09,26.46
>>Kill |cRXP_ENEMY_Arix'Amal|r. Loot him for the |cRXP_LOOT_Burning Legion Gate Key|r and the |T133473:0|t[|cRXP_LOOT_Burning Legion Missive|r]
.use 29588 >>|cRXP_WARN_Use the|r |T133473:0|t[|cRXP_LOOT_Burning Legion Missive|r] |cRXP_WARN_to start the quest|r
.complete 10397,1 
.complete 10397,3 
.collect 29588,1,10395 
.accept 10395 >> Accept The Dark Missive
.unitscan Warbringer Arix'Amal
step
.goto Hellfire Peninsula,53.04,27.71
>>Click the |cRXP_PICK_Rune of Spite|r inside the Gate
.complete 10397,2 
step
.goto Hellfire Peninsula,68.29,28.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Field Marshal Brock|r
.turnin 10397 >> Turn in Invasion Point: Annihilator
.target Field Marshal Brock
step
#completewith next
.goto Hellfire Peninsula,68.65,28.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryphoneer Leafbeard|r
.fly Shatter >> Fly to Shatter Point
.cooldown item,6948,<0
.skipgossip
.timer 31,Shatter Point Flight
.target Gryphoneer Leafbeard
step
.goto Hellfire Peninsula,78.19,34.34,5 >> Return to Shatter Point
.isOnQuest 10395
.cooldown item,6948,<0
step
#completewith next
.goto Hellfire Peninsula,78.42,34.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Runetog Wildhammer|r
.fly Honor Hold >> Fly to Honor Hold
.cooldown item,6948,<0
.target Runetog Wildhammer
step
#completewith next
.hs >> Hearth to Honor Hold
.cooldown item,6948,>2
step
.goto 1944/530,2736.60010,-708.29999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Father Malgor Devidicus|r
.target Father Malgor Devidicus
.accept 10058 >>Accept An Old Gift
step
.goto Hellfire Peninsula,54.27,63.17,8,0
.goto Hellfire Peninsula,54.32,63.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Assistant Klatu|r upstairs
.turnin 10903 >> Turn in Return to Honor Hold
.accept 10909 >> Accept Fel Spirits
.accept 10916 >> Accept Digging for Prayer Beads
.target Assistant Klatu
step
.goto Hellfire Peninsula,54.63,63.71
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hama|r on the second floor of the Inn
>>|cRXP_BUY_Buy a|r |T132906:0|t[Silken Thread]|cRXP_BUY_. You may need this to progress a quest later|r
.collect 4291,1,10916,1 
.isOnQuest 10916
.target Hama

step
.goto Hellfire Peninsula,56.37,65.99,20,0
.goto Hellfire Peninsula,56.61,66.77,14,0
.goto Hellfire Peninsula,56.70,66.52
>>Go inside the Keep to the top floor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Warp-Scryer Kryv|r
.target Warp-Scryer Kryv
.turnin 10395 >>Turn in The Dark Missive
.accept 10399 >>Accept The Heart of Darkness
.accept 10047 >>Accept The Path of Glory
step
.goto Hellfire Peninsula,56.64,66.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Force Commander Danath Trollbane|r
.target Force Commander Danath Trollbane
.accept 10400 >>Accept Overlord
step
#completewith treat
#label Beads1
.goto Hellfire Peninsula,54.16,63.32,3,0
.goto Hellfire Peninsula,54.16,63.32,0
>>Loot the |cRXP_PICK_Dirt Mound|r outside the Inn for the |cRXP_LOOT_Prayer Beads|r
>>|cRXP_WARN_The |cRXP_PICK_Dirt Mound|r will despawn on server restart, if you're unlucky, you'll have to give |cRXP_FRIENDLY_Fei Fei|r a treat|r
.complete 10916,1 
step
#completewith Beads1
#label DTreat
>>|cRXP_WARN_If the |cRXP_PICK_Dirt Mound|r is not there:|r
>>|cRXP_BUY_Buy a|r |T132165:0|t[Fei Fei Doggy Treat] |cRXP_BUY_from|r |cRXP_FRIENDLY_Warrant Officer Tracy Proudwell|r
.goto Hellfire Peninsula,56.33,62.84
.collect 31799,1,10916,1 
.isOnQuest 10916
.target Warrant Officer Tracy Proudwell
step
#completewith next
#label treat
#requires DTreat
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fei Fei|r
.goto Hellfire Peninsula,56.39,62.90
.turnin 10919 >> Turn in Fei Fei's Treat
.timer 120,Fei Fei RP
.isOnQuest 10916
.target Fei Fei
step << skip
#completewith next
.goto Hellfire Peninsula,50.87,60.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Honor Guard Wesilow|r. You can do this while waiting for |cRXP_FRIENDLY_Fei Fei|r
.accept 10050 >> Accept Unyielding Souls
.target Honor Guard Wesilow
step
#completewith next
#requires DTreat
.goto Hellfire Peninsula,54.16,63.32,0
>>|cRXP_FRIENDLY_Fei Fei|r will dig up the |cRXP_PICK_Dirt Mound|r containing the |cRXP_LOOT_Prayer Beads|r after a couple minutes.
>>|cRXP_WARN_You don't need to wait for the full RP, you will come back for this quest later|r
.complete 10916,1 
.isOnQuest 10916
.target Fei Fei
step
.goto Hellfire Peninsula,50.87,60.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Honor Guard Wesilow|r
.accept 10050 >> Accept Unyielding Souls
.target Honor Guard Wesilow
step
.goto Hellfire Peninsula,52.02,62.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foreman Biggums|r
.accept 9355 >> Accept A Job for an Intelligent Man
.accept 10079 >> Accept When This Mine's a-Rockin'
.target Foreman Biggums
step
.goto Hellfire Peninsula,52.38,62.35,20,0
.goto Hellfire Peninsula,54.17,64.51,15,0
.goto Hellfire Peninsula,56.17,62.31
>>Kill |cRXP_ENEMY_Gan'arg Sappers|r inside the Mine
.complete 10079,1 
.mob Gan'arg Sapper
step
.goto Hellfire Peninsula,52.02,62.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foreman Biggums|r
.turnin 10079 >> Turn in When This Mine's a-Rockin'
.accept 10099 >> Accept The Mastermind
.target Foreman Biggums
step
.goto Hellfire Peninsula,52.38,62.35,20,0
.goto Hellfire Peninsula,54.17,64.51,15,0
.goto Hellfire Peninsula,56.28,61.30
>>Kill |cRXP_ENEMY_Z'kral|r at the end of the Mine
.complete 10099,1 
.mob Z'kral
step
.goto Hellfire Peninsula,52.02,62.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foreman Biggums|r
.turnin 10099 >> Turn in The Mastermind
.target Foreman Biggums
step
#loop
.line Hellfire Peninsula,51.42,63.90,48.95,64.85,47.09,63.73,45.95,65.21,47.26,65.97,48.19,66.40,48.28,68.19,49.73,67.25,51.42,63.90
.goto Hellfire Peninsula,51.42,63.90,55,0
.goto Hellfire Peninsula,48.95,64.85,55,0
.goto Hellfire Peninsula,47.09,63.73,55,0
.goto Hellfire Peninsula,45.95,65.21,55,0
.goto Hellfire Peninsula,47.26,65.97,55,0
.goto Hellfire Peninsula,48.19,66.40,55,0
.goto Hellfire Peninsula,48.28,68.19,55,0
.goto Hellfire Peninsula,49.73,67.25,55,0
.goto Hellfire Peninsula,51.42,63.90,55,0
.use 23338 >>Kill |cRXP_ENEMY_Marauding Crust Bursters|r by running over the moving rocks. Loot them for an |T133651:0|t[|cRXP_LOOT_Eroded Leather Case|r]
>>|cRXP_WARN_Use the|r |T133651:0|t[|cRXP_LOOT_Eroded Leather Case|r] |cRXP_WARN_to start the quest|r
.complete 9355,1 
.collect 23338,1,9373,1 
.accept 9373 >> Accept Missing Missive
.mob Marauding Crust Burster
step
#questguide << !tbc
#xprate <1.5 << tbc
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Legassi|r and |cRXP_FRIENDLY_"Screaming" Screed Luckheed|r
.accept 9349 >> Accept Ravager Egg Roundup
.target +Legassi
.goto Hellfire Peninsula,49.24,74.83
.accept 10161 >> Accept In Case of Emergency...
.target +"Screaming" Screed Luckheed
.goto Hellfire Peninsula,49.15,74.87
step
#xprate >1.499 << TBC
.goto Hellfire Peninsula,49.24,74.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Legassi|r
.accept 9349 >> Accept Ravager Egg Roundup

.target Legassi
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Unyielding Footmen|r, |cRXP_ENEMY_Unyielding Sorcerers|r and |cRXP_ENEMY_Unyielding Knights|r
.complete 10050,1 
.mob +Unyielding Footman
.complete 10050,2 
.mob +Unyielding Sorcerer
.complete 10050,3 
.mob +Unyielding Knight
step
.goto Hellfire Peninsula,54.96,86.82
>>Loot the |cRXP_PICK_Mysteries of the Light|r book on the ground
.complete 10058,1 
step
>>Kill |cRXP_ENEMY_Unyielding Footmen|r, |cRXP_ENEMY_Unyielding Sorcerers|r and |cRXP_ENEMY_Unyielding Knights|r
.complete 10050,1 
.goto Hellfire Peninsula,58.50,79.42,50,0
.goto Hellfire Peninsula,58.54,77.36,50,0
.goto Hellfire Peninsula,57.70,75.28,50,0
.goto Hellfire Peninsula,56.70,74.36,50,0
.goto Hellfire Peninsula,55.59,79.20
.mob +Unyielding Footman
.complete 10050,2 
.goto Hellfire Peninsula,55.89,79.86,50,0
.goto Hellfire Peninsula,55.47,81.52,50,0
.goto Hellfire Peninsula,54.45,81.43,50,0
.goto Hellfire Peninsula,54.21,79.08,50,0
.goto Hellfire Peninsula,55.11,79.59
.mob +Unyielding Sorcerer
.complete 10050,3 
.goto Hellfire Peninsula,56.44,77.81,50,0
.goto Hellfire Peninsula,54.57,78.22,50,0
.goto Hellfire Peninsula,53.58,85.16,50,0
.goto Hellfire Peninsula,55.25,85.59
.mob +Unyielding Knight
step
.goto Hellfire Peninsula,41.83,85.16,50,0
.goto Hellfire Peninsula,40.37,87.33,50,0
.goto Hellfire Peninsula,38.42,88.82,50,0
.goto Hellfire Peninsula,36.72,88.50,50,0
.goto Hellfire Peninsula,36.88,91.36,50,0
.goto Hellfire Peninsula,32.54,93.32
>>Kill |cRXP_ENEMY_Razorfang Ravagers|r. Loot them for their |cRXP_LOOT_Ravager Eggs|r
>>You can also find |cRXP_LOOT_Ravager Eggs|r on the ground
.complete 9349,1 
.mob Razorfang Ravager
step << tbc/wotlk
#completewith next
.goto Shattrath City,64.05,41.12
>>Travel to Shattrath City
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nutral|r
.fp Shattrath >> Get the Shattrath flight path
.target Nutral
step << Mage (tbc/wotlk)
#completewith next
.zone Stormwind City >> Teleport to Stormwind
step << (Warlock/Shaman/Paladin) (tbc/wotlk)
.goto Shattrath City,55.7,36.9
.zone Stormwind City >> Take the portal to Stormwind
step << (Warlock/Shaman/Paladin/Mage) (tbc/wotlk)
.goto StormwindClassic,25.3,78.7 << Warlock
.goto StormwindClassic,38.6,32.8 << Paladin
.goto StormwindClassic,61.9,84.0 << Shaman
.goto StormwindClassic,39.6,79.6 << Mage
.trainer >> Train your class spells
.target Ursula Deline << Warlock
.target Demisette Cloyce << Warlock
.target Sandahl << Warlock
.target Arthur the Faithful << Paladin
.target Katherine the Pure << Paladin
.target Lord Grayson Shadowbreaker << Paladin
.target Farseer Umbrua << Shaman
.target Elsharin << Mage
.target Jennea Cannon << Mage
step << Mage (tbc/wotlk)
#completewith next
.zone Darnassus >> Teleport to Darnassus
.isOnQuest 4986
step << (Warrior/Hunter/Rogue/Priest/Druid) (tbc/wotlk)
#completewith next
.goto Shattrath City,55.2,36.5
.zone Darnassus >> Take the portal to Darnassus
step << (Warrior/Hunter/Rogue/Priest) (tbc/wotlk)
.goto Darnassus,39.0,83.2 << Priest
.goto Darnassus,40.6,9.2 << Hunter
.goto Darnassus,31.5,17.4 << Rogue
.goto Darnassus,58.75,35.16 << Warrior
.trainer >> Train your class spells
.target Jandria << Priest
.target Jocaste << Hunter
.target Anishar << Rogue
.target Erion Shadewhisper << Rogue
.target Syurna << Rogue
.target Arias'ta Bladesinger << Warrior
step << (Warrior/Hunter/Rogue/Priest/Druid/Mage) (tbc/wotlk)
.turnin 4986 >> Turn in Glyphed Oaken Branch
.goto Darnassus,35.2,8.1
.isOnQuest 4986
.target Mathrengyl Bearwalker
step << (NightElf/Draenei) (tbc/wotlk)
#optional
#completewith next
.goto Darnassus,29.10,41.22,15,0
.goto Teldrassil,55.93,89.74,30 >> Go through the purple portal to Teldrassil
step << (NightElf/Draenei) (tbc/wotlk)
.goto Teldrassil,55.50,92.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Erelas Ambersky|r
.turnin 978 >> Turn in Moontouched Wildkin
.isOnQuest 978
.target Erelas Ambersky
step << Druid
>>Teleport to Moonglade
.goto Moonglade,52.4,40.6
.trainer 12042 >> Train your class spells
.target Loganaar << Druid
step
#completewith next
.hs >> Hearth back to Honor Hold
.cooldown item,6948,>2
step
.goto Hellfire Peninsula,54.29,63.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Father Malgor Devidicus|r
.turnin 10058 >> Turn in An Old Gift
.target Father Malgor Devidicus
step
.goto 1944/530,2910.0,-595.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Honor Guard Wesilow|r
.target Honor Guard Wesilow
.turnin 10050 >>Turn in Unyielding Souls
.accept 10057 >>Accept Looking to the Leadership
step
.goto 1944/530,2854.7,-669.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foreman Biggums|r
.target Foreman Biggums
.turnin 9355 >>Turn in A Job for an Intelligent Man
step
.goto Hellfire Peninsula,44.82,75.34
.use 31772 >>|cRXP_WARN_Use the|r |T134423:0|t[Anchorite Relic]
>>Kill the |cRXP_ENEMY_Shattered Hand Berserkers|r targeted by the |T134423:0|t[Anchorite Relic]
>>Kill the |cRXP_ENEMY_Fel Spirits|r that spawn afterwards
.complete 10909,1 
.mob Shattered Hand Berserker
.mob Fel Spirit
step
.goto Hellfire Peninsula,49.24,74.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Legassi|r
.turnin 9349 >> Turn in Ravager Egg Roundup
.accept 9361 >> Accept Helboar, the Other White Meat
.target Legassi
step
#optional
#questguide << !tbc
#xprate <1.5 << tbc
#completewith BuzWing
>>Loot the |cRXP_PICK_Zeppelin Debris|r on the ground
.complete 10161,1 
step
#loop
.line Hellfire Peninsula,46.10,71.85,45.11,71.84,45.39,70.17,46.89,68.32,50.01,64.14,52.83,70.37,46.10,71.85
.goto Hellfire Peninsula,46.10,71.85,55,0
.goto Hellfire Peninsula,45.11,71.84,55,0
.goto Hellfire Peninsula,45.39,70.17,55,0
.goto Hellfire Peninsula,46.89,68.32,55,0
.goto Hellfire Peninsula,50.01,64.14,55,0
.goto Hellfire Peninsula,52.83,70.37,55,0
.goto Hellfire Peninsula,46.10,71.85,55,0
>>Kill |cRXP_ENEMY_Deranged Helboars|r. Loot them for their |cRXP_LOOT_Tainted Meat|r
.use 23268 >>|cRXP_WARN_Use the|r |T134720:0|t[Purification Mixture] |cRXP_WARN_to convert the |cRXP_LOOT_Tainted Meat|r into|r |cRXP_LOOT_Purified Helboar Meat|r
.collect 23270,8,9361,1,-1
.complete 9361,1 
.mob Deranged Helboar
step
.goto Hellfire Peninsula,49.24,74.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Legassi|r
.turnin 9361 >> Turn in Helboar, the Other White Meat
.accept 9356 >> Accept Smooth as Butter
.target Legassi
step
>>Kill |cRXP_ENEMY_Arch Mage Xintor|r and |cRXP_ENEMY_Commander Thalvos|r
.complete 10057,1 
.mob +Arch Mage Xintor
.goto Hellfire Peninsula,53.67,81.10
.complete 10057,2 
.mob +Lieutenant Commander Thalvos
.goto Hellfire Peninsula,54.75,83.71
step
#label BuzWing
#loop
.line Hellfire Peninsula,57.50,72.75,58.66,69.95,62.44,69.12,64.18,66.08,65.00,64.65,65.95,62.08,62.47,65.22,61.12,66.85,57.71,69.65,57.50,72.75
.goto Hellfire Peninsula,57.50,72.75,55,0
.goto Hellfire Peninsula,58.66,69.95,55,0
.goto Hellfire Peninsula,62.44,69.12,55,0
.goto Hellfire Peninsula,64.18,66.08,55,0
.goto Hellfire Peninsula,65.00,64.65,55,0
.goto Hellfire Peninsula,65.95,62.08,55,0
.goto Hellfire Peninsula,62.47,65.22,55,0
.goto Hellfire Peninsula,61.12,66.85,55,0
.goto Hellfire Peninsula,57.71,69.65,55,0
.goto Hellfire Peninsula,57.50,72.75,55,0
>>Kill |cRXP_ENEMY_Bonestripper Buzzards|r. Loot them for their |cRXP_LOOT_Wings|r
.complete 9356,1 
.mob Bonestripper Buzzard
step
#questguide << !tbc
#xprate <1.5 << tbc
#loop
.line Hellfire Peninsula,57.50,72.75,58.66,69.95,62.44,69.12,64.18,66.08,65.00,64.65,65.95,62.08,62.47,65.22,61.12,66.85,57.71,69.65,57.50,72.75
.goto Hellfire Peninsula,57.50,72.75,55,0
.goto Hellfire Peninsula,58.66,69.95,55,0
.goto Hellfire Peninsula,62.44,69.12,55,0
.goto Hellfire Peninsula,64.18,66.08,55,0
.goto Hellfire Peninsula,65.00,64.65,55,0
.goto Hellfire Peninsula,65.95,62.08,55,0
.goto Hellfire Peninsula,62.47,65.22,55,0
.goto Hellfire Peninsula,61.12,66.85,55,0
.goto Hellfire Peninsula,57.71,69.65,55,0
.goto Hellfire Peninsula,57.50,72.75,55,0
>>Loot the |cRXP_LOOT_Zeppelin Debris|r on the ground
.complete 10161,1 
step << Shaman
#completewith prayerbeads1
.hs >> Hearth to Honor Hold
step
.goto Hellfire Peninsula,54.16,63.32
>>Loot the |cRXP_PICK_Dirt Mound|r outside the Inn for the |cRXP_LOOT_Prayer Beads|r
>>|cRXP_WARN_The |cRXP_PICK_Dirt Mound|r will despawn on server restart, if you got unlucky, you'll have to give |cRXP_FRIENDLY_Fei Fei|r a treat|r
.complete 10916,1 
step
#label prayerbeads1
.goto Hellfire Peninsula,54.27,63.17,8,0
.goto Hellfire Peninsula,54.32,63.65
>>Return to Honor Hold. Go to the second floor of the Inn
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Assistant Klatu|r
.turnin 10909 >> Turn in Fel Spirits
.turnin 10916 >> Turn in Digging for Prayer Beads
.accept 10935 >> Accept The Exorcism of Colonel Jules
.target Assistant Klatu
step
#completewith next
.goto 1944/530,2754.11,-707.211
.gossip 22431,1 >> Talk to |cRXP_FRIENDLY_Anchorite Barada|r in the bedroom to start the exorcism
.target Anchorite Barada
.timer 215,Colonel Jules RP
step
.goto 1944/530,2754.36,-710.211
.use 31828 >>|cRXP_WARN_Use the|r |T133290:0|t[Ritual Prayer Beads] |cRXP_WARN_to instantly kill the spirits that spawn|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Colonel Jules|r once the RP finishes
.complete 10935,1 
.skipgossip 22431,1
.skipgossip 22432,1
.target Colonel Jules
step
.goto Hellfire Peninsula,54.32,63.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Assistant Klatu|r
.turnin 10935 >> Turn in The Exorcism of Colonel Jules
.accept 10936 >> Accept Trollbane is Looking for You
.target Assistant Klatu
step
.goto 1944/530,2736.10010,-707.29999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sid Limbardi|r
.target Sid Limbardi
.accept 9558 >>Accept The Longbeards
step
.goto Hellfire Peninsula,56.37,65.99,20,0
.goto Hellfire Peninsula,56.61,66.77,14,0
>>Go inside the Keep to the top floor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Force Commander Danath Trollbane|r
.turnin 10936 >> Turn in Trollbane is Looking for You
.accept 10937 >> Accept Drill the Drillmaster
.goto Hellfire Peninsula,56.64,66.70
.target Force Commander Danath Trollbane
step
.goto Hellfire Peninsula,50.87,60.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Honor Guard Wesilow|r
.turnin 10057 >> Turn in Looking to the Leadership
.target Honor Guard Wesilow
step
.goto Hellfire Peninsula,48.07,56.17
>>Kill |cRXP_ENEMY_Drillmaster Zurok|r
>>|cRXP_WARN_Use your pet to pull him from down out of the pit, then kite him back to Honor Hold and have the guards help you|r << (tbc/wotlk) (Hunter/Warlock/DK)
>>|cRXP_WARN_This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r << tbc
.complete 10937,1 
.isOnQuest 10937
.mob Drillmaster Zurok
step
.goto Hellfire Peninsula,49.63,52.08,50,0
.goto Hellfire Peninsula,52.70,50.73,50,0
.goto Hellfire Peninsula,63.42,49.34,50,0
.goto Hellfire Peninsula,52.70,50.73
>>Click the |cRXP_PICK_Trampled Skeleton|r corpses along the path
.complete 10047,1 
step
.use 26002 >>|cRXP_WARN_Use the|r |T135432:0|t[Flaming Torch] |cRXP_WARN_on the Catapults|r
.complete 10078,1 
.goto Hellfire Peninsula,58.50,47.64
.complete 10078,2 
.goto Hellfire Peninsula,55.70,47.48
.complete 10078,3 
.goto Hellfire Peninsula,53.55,48.24
.complete 10078,4 
.goto Hellfire Peninsula,52.64,48.01
step
.goto Hellfire Peninsula,51.37,30.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foreman Razelcraz|r outside Thrallmar Mine
.accept 10236 >> Accept Outland Sucks!
.target Foreman Razelcraz
step
.goto Hellfire Peninsula,49.02,37.63,50,0
.goto Hellfire Peninsula,47.98,37.39,50,0
.goto Hellfire Peninsula,48.41,40.86,50,0
.goto Hellfire Peninsula,47.28,42.34,50,0
.goto Hellfire Peninsula,47.17,43.74,50,0
.goto Hellfire Peninsula,48.85,35.37,50,0
.goto Hellfire Peninsula,47.28,42.34
>>Loot the |cRXP_PICK_Shredder Parts|r boxes on the ground
.complete 10236,1 
step
.goto Hellfire Peninsula,51.37,30.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foreman Razelcraz|r
.turnin 10236 >> Turn in Outland Sucks!
.accept 10238 >> Accept How to Serve Goblins
.target Foreman Razelcraz
step
>>Free |cRXP_FRIENDLY_Manni|r, |cRXP_FRIENDLY_Moh|r and |cRXP_FRIENDLY_Jakk|r from the cages
.complete 10238,1 
.target +Manni
.goto Hellfire Peninsula,45.12,41.11
.complete 10238,2 
.target +Moh
.goto Hellfire Peninsula,46.42,45.18
.complete 10238,3 
.target +Jakk
.goto Hellfire Peninsula,47.50,46.63
step
#questguide << !tbc
.goto Hellfire Peninsula,51.37,30.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foreman Razelcraz|r
.turnin 10238 >> Turn in How to Serve Goblins
.accept 10629 >> Accept Shizz Work
.target Foreman Razelcraz
step
#questguide << !tbc
.goto Hellfire Peninsula,51.37,30.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foreman Razelcraz|r
.turnin 10238 >> Turn in How to Serve Goblins
.accept 10629 >> Accept Shizz Work
.target Foreman Razelcraz
step
#questguide << !tbc
.goto Hellfire Peninsula,51.37,30.52
#completewith next
.cast 37690 >> |cRXP_WARN_Use the|r |T133942:0|t[Felhound Whistle] |cRXP_WARN_whilst beside |cRXP_FRIENDLY_Foreman Razelcraz|r to summon a|r |cRXP_FRIENDLY_Felhound|r
.use 30803
step
#questguide << !tbc
.goto Hellfire Peninsula,50.7,28.9
>>Kill |cRXP_ENEMY_Deranged Helboars|r. Loot the |cRXP_LOOT_Droppings|r after the |cRXP_FRIENDLY_Felhound's RP|r for the |cRXP_PICK_Shredder Keys|r
.complete 10629,1 
.use 30803
.mob Deranged Helboar
step
#questguide << !tbc
.goto Hellfire Peninsula,51.37,30.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foreman Razelcraz|r
.turnin 10629 >> Turn in Shizz Work
.accept 10630 >> Accept Beneath Thrallmar
.target Foreman Razelcraz
step
#questguide << !tbc
.goto Hellfire Peninsula,51.72,31.68,20,0
.goto Hellfire Peninsula,52.57,30.59,20,0
.goto Hellfire Peninsula,54.39,31.57
>>Kill |cRXP_ENEMY_Urga'zz|r in the back of Thrallmar Mine
.complete 10630,1 
.mob Urga'zz
step
#questguide << !tbc
.goto Hellfire Peninsula,51.37,30.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foreman Razelcraz|r
.turnin 10630 >> Turn in Beneath Thrallmar
.target Foreman Razelcraz
step
#completewith next
.goto Hellfire Peninsula,51.37,30.52,80 >> Follow the path to the Temple of Telhamat
.skill riding,225,1
step
#sticky
#label dpredators
.goto 1944/530,4335.4,70.7,0
#loop
.waypoint Hellfire Peninsula,23.36,41.29,50,0
.waypoint Hellfire Peninsula,23.32,39.88,50,0
.waypoint Hellfire Peninsula,23.36,38.59,50,0
.waypoint Hellfire Peninsula,23.36,37.45,50,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scout Vanura|r, she patrols up and down the central ramp
.target Scout Vanura
.accept 9398 >>Accept Deadly Predators
step
.goto 1944/530,4350.0,90.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Obadei|r
.target Anchorite Obadei
.accept 9390 >>Accept In Search of Sedai
step
.goto 1944/530,4347.2,92.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ikan|r
.target Ikan
.accept 9399 >>Accept Cruel Taskmasters
.accept 9490 >>Accept The Rock Flayer Matriarch
step
#requires dpredators
#completewith Telhamat
.goto Hellfire Peninsula,23.35,36.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Caregiver Ophera Windfury|r
.home >> Set your Hearthstone to Temple of Telhamat
.target Caregiver Ophera Windfury
step
#requires dpredators
#optional
.xp <61,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elsaana|r and |cRXP_FRIENDLY_Amaan the Wise|r
.accept 9383 >> Accept An Ambitious Plan
.goto Hellfire Peninsula,23.21,36.66
.target +Elsaana
.accept 10443 >> Accept Helping the Cenarion Post
.goto Hellfire Peninsula,23.42,36.55
.accept 9426 >> Accept The Pools of Aggonar
.goto Hellfire Peninsula,23.42,36.55
.target Amaan the Wise
step
.goto Hellfire Peninsula,23.42,36.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amaan the Wise|r
.target Amaan the Wise
.accept 9426 >>Accept The Pools of Aggonar
step
#completewith next
.goto Hellfire Peninsula,25.19,37.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kuma|r
.fp Temple of Telhamat >> Get the Temple of Telhamat flight path
.target Kuma
step << Mage/DK
.goto Hellfire Peninsula,24.40,38.77
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vodesiin|r
>>Buy 20 |T134419:0|tRunes of Teleportation from him << Mage
.collect 17031,20 << Mage 
>>Buy 60 |T133849:0|tCorpse Dust from him << DK
.collect 37201,60 << DK 
.target Vodesiin
step
.goto Hellfire Peninsula,26.89,37.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sedai's Corpse|r
.turnin 9390 >> Turn in In Search of Sedai
.accept 9423 >> Accept Return to Obadei
.target Sedai's Corpse
step
#label Telhamat
>>Return to the Temple of Telhamat
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Obadei|r and |cRXP_FRIENDLY_Makuru|r
.turnin 9423 >> Turn in Return to Obadei
.target +Anchorite Obadei
.goto Hellfire Peninsula,23.00,40.37
.accept 9424 >> Accept Makuru's Vengeance
.target +Makuru
.goto Hellfire Peninsula,23.14,40.16
step
#completewith next
.goto Hellfire Peninsula,31.99,33.13,50 >>Run up the mountain path leading toward the Mag'har Grounds
.skill riding,225,1
step
#loop
.line Hellfire Peninsula,34.10,32.54,33.30,29.46,36.22,27.59,36.22,30.25,36.54,33.98,36.14,35.53,34.10,32.54
.goto Hellfire Peninsula,34.10,32.54,45,0
.goto Hellfire Peninsula,33.30,29.46,45,0
.goto Hellfire Peninsula,36.22,27.59,45,0
.goto Hellfire Peninsula,36.22,30.25,45,0
.goto Hellfire Peninsula,36.54,33.98,45,0
.goto Hellfire Peninsula,36.14,35.53,45,0
.goto Hellfire Peninsula,34.10,32.54,45,0
>>Kill |cRXP_ENEMY_Debilitated Mag'har Grunts|r and |cRXP_ENEMY_Mag'har Grunts|r. Loot them for their |cRXP_LOOT_Beads|r
.complete 9424,1 
.mob Debilitated Mag'har Grunt
.mob Mag'har Grunt
step
.goto Hellfire Peninsula,43.81,31.56
>>Kill |cRXP_ENEMY_Arazzius the Cruel|r
>>|cRXP_WARN_This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r << tbc/wotlk
>>|cRXP_WARN_This quest is highly recommended as it rewards a trinket that'll last you a long time|r << tbc/wotlk
.complete 10400,1 
.isOnQuest 10400
.mob Arazzius the Cruel
step
#loop
.line Hellfire Peninsula,44.25,29.53,42.30,30.09,39.77,27.81,38.94,29.46,38.92,31.26,39.79,34.29,38.87,35.98,39.31,38.57,38.39,41.37,39.87,41.62,40.48,37.90,41.20,32.65,44.25,29.53
.goto Hellfire Peninsula,44.25,29.53,45,0
.goto Hellfire Peninsula,42.30,30.09,45,0
.goto Hellfire Peninsula,39.77,27.81,45,0
.goto Hellfire Peninsula,38.94,29.46,45,0
.goto Hellfire Peninsula,38.92,31.26,45,0
.goto Hellfire Peninsula,39.79,34.29,45,0
.goto Hellfire Peninsula,38.87,35.98,45,0
.goto Hellfire Peninsula,39.31,38.57,45,0
.goto Hellfire Peninsula,38.39,41.37,45,0
.goto Hellfire Peninsula,39.87,41.62,45,0
.goto Hellfire Peninsula,40.48,37.90,45,0
.goto Hellfire Peninsula,41.20,32.65,45,0
.goto Hellfire Peninsula,44.25,29.53,45,0
>>Kill |cRXP_ENEMY_Terrorfiends|r and |cRXP_ENEMY_Blistering Rots|r
.complete 9426,2 
.mob +Blistering Rot
.complete 10399,1 
.mob +Terrorfiend
step << !tbc
.goto Hellfire Peninsula,51.37,30.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foreman Razelcraz|r
.turnin 10238 >> Turn in How to Serve Goblins
.target Foreman Razelcraz
step
#completewith next
.hs >> Hearth to the Temple of Telhamat
.cooldown item,6948,>2
step
.goto 1944/530,4341.30029,97.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Makuru|r
.target Makuru
.turnin 9424 >>Turn in Makuru's Vengeance
.timer 22,Makuru's Vengeance RP
step
.goto 1944/530,4349.9,92.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Obadei|r, you have to wait for the RP sequence to end
.target Anchorite Obadei
.accept 9543 >>Accept Atonement
step
.goto 1944/530,4330.0,220.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amaan the Wise|r
.target Amaan the Wise
.turnin 9543 >>Turn in Atonement
.accept 9430 >>Accept Sha'naar Relics
.turnin 9426 >>Turn in The Pools of Aggonar
.accept 9427 >>Accept Cleansing the Waters
step
#completewith next
.goto Hellfire Peninsula,40.14,30.78
.cast 29297 >>|cRXP_WARN_Use the|r |T134861:0|t[Cleansing Vial] |cRXP_WARN_to summon|r |cRXP_ENEMY_Aggonis|r
step
.goto Hellfire Peninsula,40.14,30.78
>>Kill |cRXP_ENEMY_Aggonis|r
.use 23361
.complete 9427,1 
.mob Aggonis
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Stonescythe Alphas|r and |cRXP_ENEMY_Stonescythe Whelps|r
.complete 9398,1 
.mob +Stonescythe Alpha
.complete 9398,2 
.mob +Stonescythe Whelp
step
.goto Hellfire Peninsula,33.94,63.93,30,0
.goto Hellfire Peninsula,33.34,65.16
>>Kill |cRXP_ENEMY_Blacktalon the Savage|r. Loot him for his |cRXP_LOOT_Claws|r
>>|cRXP_WARN_This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r << tbc
.complete 9490,1 
.isOnQuest 9490
.mob Blacktalon the Savage
step
.goto Hellfire Peninsula,34.74,60.88,50,0
.goto Hellfire Peninsula,32.20,58.92,50,0
.goto Hellfire Peninsula,28.31,66.50
>>Kill |cRXP_ENEMY_Stonescythe Alphas|r and |cRXP_ENEMY_Stonescythe Whelps|r
.complete 9398,1 
.mob +Stonescythe Alpha
.complete 9398,2 
.mob +Stonescythe Whelp
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gremni Longbeard|r and |cRXP_FRIENDLY_Mirren Longbeard|r
.turnin 9558 >> Turn in The Longbeards
.accept 9417 >> Accept The Arakkoa Threat
.accept 9385 >> Accept Rampaging Ravagers
.target +Gremni Longbeard
.goto Hellfire Peninsula,23.89,72.17
.accept 9563 >> Accept Gaining Mirren's Trust
.turnin 9563 >> Turn in Gaining Mirren's Trust
.target +Mirren Longbeard
.goto Hellfire Peninsula,23.97,72.35
.itemcount 23848,1
step
.goto Hellfire Peninsula,23.97,72.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mirren Longbeard|r
.accept 9420 >> Accept The Finest Down
.isQuestTurnedIn 9563
.target Mirren Longbeard
step
#optional
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gremni Longbeard|r
.turnin 9558 >> Turn in The Longbeards
.accept 9417 >> Accept The Arakkoa Threat
.accept 9385 >> Accept Rampaging Ravagers
.goto Hellfire Peninsula,23.89,72.17
.target Gremni Longbeard
step
#loop
.line Hellfire Peninsula,21.71,70.55,22.68,67.28,24.03,65.47,22.24,60.51,21.57,63.11,21.45,66.57,21.71,70.55
.goto Hellfire Peninsula,21.71,70.55,50,0
.goto Hellfire Peninsula,22.68,67.28,50,0
.goto Hellfire Peninsula,24.03,65.47,50,0
.goto Hellfire Peninsula,22.24,60.51,50,0
.goto Hellfire Peninsula,21.57,63.11,50,0
.goto Hellfire Peninsula,21.45,66.57,50,0
.goto Hellfire Peninsula,21.71,70.55,50,0
>>Kill |cRXP_ENEMY_Quillfang Ravagers|r << tbc/wotlk
>>Kill |cRXP_ENEMY_Quillfang Ravagers|r and |cRXP_ENEMY_Quillfang Skitterers|r << !tbc !wotlk
.complete 9385,1 
.mob Quillfang Ravager
.mob Quillfang Skitterer << !tbc !wotlk
step
#optional
#completewith Kaliri
>>Kill |cRXP_ENEMY_Haal'eshi Windwalkers|r and |cRXP_ENEMY_Haal'eshi Talonguards|r
.complete 9417,1 
.mob +Haal'eshi Windwalker
.complete 9417,2 
.mob +Haal'eshi Talonguard
step
#optional
#completewith AvruuO
>>Kill |cRXP_ENEMY_Kaliri Matriarchs|r, |cRXP_ENEMY_Kaliri Swoopers|r, |cRXP_ENEMY_Male Kaliri Hatchlings|r and |cRXP_ENEMY_Female Kaliri Hatchlings|r. Loot them for their |cRXP_LOOT_Feathers|r
>>|cRXP_WARN_Click the nests to spawn |cRXP_ENEMY_Male Kaliri Hatchlings|r and|r |cRXP_ENEMY_Female Kaliri Hatchlings|r
.complete 9420,1 
.isOnQuest 9420
.mob Kaliri Matriarch
.mob Kaliri Swooper
.mob Male Kaliri Hatchling
.mob Female Kaliri Hatchling
step
.goto Hellfire Peninsula,25.67,75.13,30,0
.goto Hellfire Peninsula,25.72,76.44
.use 23580 >>Kill |cRXP_ENEMY_Avruu|r. Loot him for |T134124:0|t[|cRXP_LOOT_Avruu's Orb|r]
>>|cRXP_WARN_Use|r |T134124:0|t[|cRXP_LOOT_Avruu's Orb|r] |cRXP_WARN_to start the quest|r
.collect 23580,1,9418,1 
.accept 9418 >> Accept Avruu's Orb
.unitscan Avruu
step
#label AvruuO
.goto Hellfire Peninsula,28.93,81.46
>>Click the |cRXP_PICK_Haal'eshi Altar|r to summon |cRXP_FRIENDLY_Aeranas|r

>>Defeat |cRXP_ENEMY_Aeranas|r afterwards
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Aeranas|r
.turnin 9418 >> Turn in Avruu's Orb
.mob Aeranas
.skipgossip
step
#label Kaliri
.goto Hellfire Peninsula,27.55,77.86,30,0
.goto Hellfire Peninsula,25.79,76.61,30,0
.goto Hellfire Peninsula,25.79,74.95,30,0
.goto Hellfire Peninsula,26.38,74.25,30,0
.goto Hellfire Peninsula,25.11,76.08,30,0
.goto Hellfire Peninsula,24.69,76.47
>>Kill |cRXP_ENEMY_Kaliri Matriarchs|r, |cRXP_ENEMY_Kaliri Swoopers|r, |cRXP_ENEMY_Male Kaliri Hatchlings|r and |cRXP_ENEMY_Female Kaliri Hatchlings|r. Loot them for their |cRXP_LOOT_Feathers|r
>>|cRXP_WARN_Click the nests to spawn |cRXP_ENEMY_Male Kaliri Hatchlings|r and|r |cRXP_ENEMY_Female Kaliri Hatchlings|r
.complete 9420,1 
.isOnQuest 9420
.mob Kaliri Matriarch
.mob Kaliri Swooper
.mob Male Kaliri Hatchling
.mob Female Kaliri Hatchling
step
.goto Hellfire Peninsula,25.97,78.32,50,0
.goto Hellfire Peninsula,26.14,72.23
>>Kill |cRXP_ENEMY_Haal'eshi Windwalkers|r and |cRXP_ENEMY_Haal'eshi Talonguards|r
.complete 9417,1 
.mob +Haal'eshi Windwalker
.complete 9417,2 
.mob +Haal'eshi Talonguard
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gremni Longbeard|r and |cRXP_FRIENDLY_Mirren Longbeard|r
.turnin 9420 >> Turn in The Finest Down
.target +Mirren Longbeard
.goto Hellfire Peninsula,23.97,72.35
.turnin 9417 >> Turn in The Arakkoa Threat
.turnin 9385 >> Turn in Rampaging Ravagers
.goto Hellfire Peninsula,23.89,72.17
.isQuestComplete 9420
.target Gremni Longbeard
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gremni Longbeard|r
.turnin 9417 >> Turn in The Arakkoa Threat
.turnin 9385 >> Turn in Rampaging Ravagers
.goto Hellfire Peninsula,23.89,72.17
.target Gremni Longbeard
step
#optional
#completewith Arzeth
>>Kill |cRXP_ENEMY_Illidari Taskmasters|r
>>Loot the |cRXP_PICK_Relics|r on the ground
.complete 9399,1 
.complete 9430,1 
.mob Illidari Taskmaster
step
.goto Hellfire Peninsula,15.59,58.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Akoru the Firecaller|r
.accept 10403 >> Accept Naladu
.target Akoru the Firecaller
step
.goto Hellfire Peninsula,16.27,65.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Naladu|r
.turnin 10403 >> Turn in Naladu
.accept 10367 >> Accept A Traitor Among Us
.target Naladu
step
.goto Hellfire Peninsula,14.34,63.50
>>Open the |cRXP_PICK_Metal Coffer|r. Loot it for the |cRXP_LOOT_Sha'naar Key|r
.complete 10367,1 
step
.goto Hellfire Peninsula,16.27,65.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Naladu|r
.turnin 10367 >> Turn in A Traitor Among Us
.accept 10368 >> Accept The Dreghood Elders
.target Naladu
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the captured |cRXP_FRIENDLY_Broken|r in the Ruins
.complete 10368,1 
.target +Morod the Windstirrer
.goto Hellfire Peninsula,13.13,61.04
.complete 10368,3 
.target +Aylaan the Waterwaker
.goto Hellfire Peninsula,13.01,58.42
.complete 10368,2 
.goto Hellfire Peninsula,15.59,58.74
.target +Akoru the Firecaller
.skipgossip
step
.goto Hellfire Peninsula,16.27,65.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Naladu|r
.turnin 10368 >> Turn in The Dreghood Elders
.accept 10369 >> Accept Arzeth's Demise
.target Naladu
step
.goto Hellfire Peninsula,14.29,62.38,50,0
.goto Hellfire Peninsula,14.35,56.99
>>|cRXP_WARN_Use the|r |T135225:0|t[Staff of the Dreghood Elders] |cRXP_WARN_to weaken|r |cRXP_ENEMY_Arzeth the Merciless|r
.use 29513 >>Kill |cRXP_ENEMY_Arzeth|r, he patrol around the central path
.complete 10369,1 
.mob Arzeth the Merciless
.mob Arzeth the Powerless
step
#label Arzeth
.goto Hellfire Peninsula,16.27,65.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Naladu|r
.turnin 10369 >> Turn in Arzeth's Demise
.target Naladu
step
#loop
.line Hellfire Peninsula,14.90,64.00,14.60,63.10,13.33,62.20,13.06,61.70,13.66,60.65,12.16,57.78,13.30,58.39,13.67,57.49,15.69,57.72,14.54,59.47,14.90,64.00
.goto Hellfire Peninsula,14.90,64.00,50,0
.goto Hellfire Peninsula,14.60,63.10,50,0
.goto Hellfire Peninsula,13.33,62.20,50,0
.goto Hellfire Peninsula,13.06,61.70,50,0
.goto Hellfire Peninsula,13.66,60.65,50,0
.goto Hellfire Peninsula,12.16,57.78,50,0
.goto Hellfire Peninsula,13.30,58.39,50,0
.goto Hellfire Peninsula,13.67,57.49,50,0
.goto Hellfire Peninsula,15.69,57.72,50,0
.goto Hellfire Peninsula,14.54,59.47,50,0
.goto Hellfire Peninsula,14.90,64.00,50,0
>>Kill |cRXP_ENEMY_Illidari Taskmasters|r
>>Loot the |cRXP_PICK_Relics|r on the ground
.complete 9399,1 
.mob +Illidari Taskmaster
.complete 9430,1 
step
>>Travel to the Cenarion Post
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amythiel Mistwalker|r, |cRXP_FRIENDLY_Mahuram Stouthoof|r, |cRXP_FRIENDLY_Thiah Redmane|r and |cRXP_FRIENDLY_Tola'thion|r
.accept 9912 >> Accept The Cenarion Expedition
.target +Amythiel Mistwalker
.goto Hellfire Peninsula,16.04,52.15
.accept 10159 >> Accept Keep Thornfang Hill Clear!
.target +Mahuram Stouthoof
.goto Hellfire Peninsula,15.65,52.15
.turnin -10443 >> Turn in Helping the Cenarion Post
.turnin -9373 >> Turn in Missing Missive
.accept 9372 >> Accept Demonic Contamination
.target +Thiah Redmane
.goto Hellfire Peninsula,15.70,52.08
.accept 10132 >>Accept Colossal Menace
.target +Tola'thion
.goto Hellfire Peninsula,15.62,52.04
step
#optional
#completewith next
.goto Hellfire Peninsula,15.0,45.7,0
.use 29476 >>Kill a |cRXP_ENEMY_Raging Colossus|r. Loot it for a |T134081:0|t[|cRXP_LOOT_Crimson Crystal Shard|r]
>>|cRXP_WARN_Use the|r |T134081:0|t[|cRXP_LOOT_Crimson Crystal Shard|r] |cRXP_WARN_to start the quest|r
>>|cRXP_WARN_Find a group for them if needed. Skip this step if you're unable to find a group or solo them without all cooldowns|r << tbc/wotlk
.collect 29476,1,10134,1 
.accept 10134 >>Accept Crimson Crystal Clue
.mob Raging Colossus
step
.goto Hellfire Peninsula,14.38,44.64,50,0
.goto Hellfire Peninsula,17.96,40.76
>>Kill |cRXP_ENEMY_Raging Colossuses|r
>>|cRXP_WARN_Find a group for them if needed. Skip this step if you're unable to find a group or solo them without all cooldowns|r << tbc/wotlk
.complete 10132,1 
.mob Raging Colossus
step
.goto Hellfire Peninsula,14.38,44.64,50,0
.goto Hellfire Peninsula,17.96,40.76
.use 29476 >>Kill a |cRXP_ENEMY_Raging Colossus|r. Loot it for a |T134081:0|t[|cRXP_LOOT_Crimson Crystal Shard|r]
>>|cRXP_WARN_Use the|r |T134081:0|t[|cRXP_LOOT_Crimson Crystal Shard|r] |cRXP_WARN_to start the quest|r
>>|cRXP_WARN_Find a group for them if needed. Skip this step if you're unable to find a group or solo them without all cooldowns|r << tbc/wotlk
.collect 29476,1,10134,1 
.accept 10134 >>Accept Crimson Crystal Clue
.mob Raging Colossus
step << Shaman
#completewith next
.hs >> Hearth to the Temple of Telhamat
.cooldown item,6948,>2
step << Shaman
.goto 1944/530,4331.10010,220.70000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amaan the Wise|r
.target Amaan the Wise
.turnin 9427 >>Turn in Cleansing the Waters
.turnin 9430 >>Turn in Sha'naar Relics
.accept 9545 >>Accept The Seer's Relic
step << Shaman
.goto 1944/530,4341.30029,217.60001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elsaana|r
.target Elsaana
.accept 9383 >>Accept An Ambitious Plan
step
#label dpred2
#sticky
.goto 1944/530,4333.4,179.6,0
#loop
.waypoint Hellfire Peninsula,23.36,41.29,50,0
.waypoint Hellfire Peninsula,23.32,39.88,50,0
.waypoint Hellfire Peninsula,23.36,38.59,50,0
.waypoint Hellfire Peninsula,23.36,37.45,50,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scout Vanura|r, she patrols up and down the central ramp
.target Scout Vanura
.turnin 9398 >>Turn in Deadly Predators
step
.goto 1944/530,4346.8,94.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ikan|r
.target Ikan
.turnin 9399 >>Turn in Cruel Taskmasters
.turnin 9490 >>Turn in The Rock Flayer Matriarch
.isQuestComplete 9490
step
#optional
.goto 1944/530,4346.8,94.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ikan|r
.target Ikan
.turnin 9399 >>Turn in Cruel Taskmasters
step << !Shaman
.goto 1944/530,4331.10010,220.70000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amaan the Wise|r
.target Amaan the Wise
.turnin 9427 >>Turn in Cleansing the Waters
.turnin 9430 >>Turn in Sha'naar Relics
.accept 9545 >>Accept The Seer's Relic
step << !Shaman
.goto 1944/530,4341.30029,217.60001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elsaana|r
.target Elsaana
.accept 9383 >>Accept An Ambitious Plan
step
#requires dpred2
#completewith next
.goto Hellfire Peninsula,25.19,37.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kuma|r
.fly Honor Hold >> Fly to Honor Hold
.target Kuma
step
#requires dpred2
>>Return to Honor Hold. Go inside the Keep to the top floor
.goto Hellfire Peninsula,56.37,65.99,20,0
.goto Hellfire Peninsula,56.61,66.77,14,0
.goto 1944/530,2615.0,-810.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Warp-Scryer Kryv|r
.target Warp-Scryer Kryv
.turnin 10047 >>Turn in The Path of Glory
.accept 10093 >>Accept The Temple of Telhamat
.turnin 10399 >>Turn in The Heart of Darkness
step
#sticky
#label overlord
.goto 1944/530,2615.30005,-812.70001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Force Commander Danath Trollbane|r
.target Force Commander Danath Trollbane
.turnin 10400 >>Turn in Overlord
.isQuestComplete 10400
step
.goto 1944/530,2615.30005,-812.70001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Force Commander Danath Trollbane|r
.target Force Commander Danath Trollbane
.isQuestComplete 10937
.turnin 10937 >>Turn in Drill the Drillmaster
step
#requires overlord
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dumphry|r
.goto Hellfire Peninsula,51.30,60.35,20,0
.goto Hellfire Peninsula,51.19,59.99,20,0
.goto Hellfire Peninsula,50.99,60.51
.turnin 10078 >> Turn in Laying Waste to the Unwanted
.target Dumphry
step
#questguide << !tbc
#xprate <1.5 << TBC
>>Return to the Zeppelin Crash
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Legassi|r and |cRXP_FRIENDLY_"Screaming" Screed Luckheed|r
.turnin 9356 >> Turn in Smooth as Butter
.target +Legassi
.goto Hellfire Peninsula,49.24,74.83
.turnin 10161 >> Turn in In Case of Emergency...
.accept 9351 >> Accept Voidwalkers Gone Wild
.goto Hellfire Peninsula,49.15,74.87
.target +"Screaming" Screed Luckheed
step
#xprate >1.499 << TBC
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Legassi|r
.turnin 9356 >> Turn in Smooth as Butter
.goto Hellfire Peninsula,49.24,74.83
.target Legassi
step
#questguide << !tbc
#xprate <1.5 << tbc
#completewith next
#optional
>>Kill |cRXP_ENEMY_Rogue Voidwalkers|r and |cRXP_ENEMY_Uncontrolled Voidwalkers|r. Loot them for their |cRXP_LOOT_Essence|r
.complete 9351,1 
.mob Uncontrolled Voidwalker
.mob Rogue Voidwalker
step
.goto Hellfire Peninsula,50.07,83.29,50,0
.goto Hellfire Peninsula,46.25,83.22
.use 23417 >>|cRXP_WARN_Damage an|r |cRXP_ENEMY_Uncontrolled Voidwalker|r |cRXP_WARN_down to 20% or less health, then use the|r |T132878:0|t[Sanctified Crystal] |cRXP_WARN_on it|r
.complete 9383,1 
.mob Uncontrolled Voidwalker
step
#questguide << !tbc
#xprate <1.5 << tbc
#loop
.line Hellfire Peninsula,46.32,81.97,45.65,84.23,47.81,84.70,50.15,83.32,51.18,82.56,50.45,81.79,48.50,81.74,46.32,81.97
.goto Hellfire Peninsula,46.32,81.97,50,0
.goto Hellfire Peninsula,45.65,84.23,50,0
.goto Hellfire Peninsula,47.81,84.70,50,0
.goto Hellfire Peninsula,50.15,83.32,50,0
.goto Hellfire Peninsula,51.18,82.56,50,0
.goto Hellfire Peninsula,50.45,81.79,50,0
.goto Hellfire Peninsula,48.50,81.74,50,0
.goto Hellfire Peninsula,46.32,81.97,50,0
>>Kill |cRXP_ENEMY_Rogue Voidwalkers|r and |cRXP_ENEMY_Uncontrolled Voidwalkers|r. Loot them for their |cRXP_LOOT_Essence|r
.complete 9351,1 
.mob Uncontrolled Voidwalker
.mob Rogue Voidwalker
step
#questguide << !tbc
#xprate <1.5 << tbc
.goto Hellfire Peninsula,49.15,74.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_"Screaming" Screed Luckheed|r
.turnin 9351 >> Turn in Voidwalkers Gone Wild
.target "Screaming" Screed Luckheed
step
#completewith Temple
.hs >> Hearth to Temple of Telhamat
.cooldown item,6948,>2
step
#completewith next
.goto Hellfire Peninsula,54.68,62.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Flightmaster Krill Bitterhue|r
.fly Temple of Telhamat >> Fly to the Temple of Telhamat
.cooldown item,6948,<0
.target Flightmaster Krill Bitterhue
step
#label Temple
>>Return to the Temple of Telhamat
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amaan the Wise|r and |cRXP_FRIENDLY_Elsaana|r
.turnin 10093 >> Turn in The Temple of Telhamat
.goto Hellfire Peninsula,23.42,36.55
.target +Amaan the Wise
.turnin 9383 >> Turn in An Ambitious Plan
.goto Hellfire Peninsula,23.21,36.66
.target +Elsaana
step
.goto Hellfire Peninsula,26.89,37.44
.cast 30489 >>|cRXP_WARN_Use the|r |T134907:0|t[Seer's Relic] |cRXP_WARN_on |cRXP_FRIENDLY_Sedai's Corpse|r. Do NOT wait for the RP|r

.timer 21,The Seer's Relic RP
.use 23645
.isOnQuest 9545
.target Sedai's Corpse
step
.goto Hellfire Peninsula,23.42,36.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amaan the Wise|r
.turnin 9545 >> Turn in The Seer's Relic
.target Amaan the Wise
step
.goto Hellfire Peninsula,24.99,51.58,60,0
.goto Hellfire Peninsula,23.73,57.53,60,0
.goto Hellfire Peninsula,17.33,53.85
>>Kill |cRXP_ENEMY_Hulking Helboars|r. Loot them for their |cRXP_LOOT_Blood Samples|r
.complete 9372,1 
.mob Hulking Helboar
step
#sticky
#label Thiah
>>Return to Cenarion Post
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thiah Redmane|r
.turnin 9372 >> Turn in Demonic Contamination
.accept 10255 >> Accept Testing the Antidote
.goto Hellfire Peninsula,15.70,52.08
.target Thiah Redmane
step
#optional
#completewith next
.goto Hellfire Peninsula,15.62,52.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tola'thion|r
.turnin 10132 >>Turn in Colossal Menace
.isQuestComplete 10132
.target Tola'thion
step
.goto Hellfire Peninsula,15.62,52.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tola'thion|r
.turnin 10134 >>Turn in Crimson Crystal Clue
.isOnQuest 10134
.target Tola'thion
step
.goto Hellfire Peninsula,15.62,52.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tola'thion|r
.accept 10349 >>Accept The Earthbinder
.isQuestTurnedIn 10134
.target Tola'thion
step
.goto Hellfire Peninsula,15.62,52.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tola'thion|r
.turnin 10132 >>Turn in Colossal Menace
.isQuestComplete 10132
.target Tola'thion
step
#requires Thiah
.goto Hellfire Peninsula,15.97,51.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthbinder Galandria Nightbreeze|r
.turnin 10349 >>Turn in The Earthbinder
.accept 10351 >>Accept Natural Remedies
.isQuestTurnedIn 10134
.target Earthbinder Galandria Nightbreeze
step
.goto Hellfire Peninsula,18.40,52.73,60,0
.goto Hellfire Peninsula,22.17,56.14
.use 23337 >>|cRXP_WARN_Use the|r |T134801:0|t[Cenarion Antidote] |cRXP_WARN_on a|r |cRXP_ENEMY_Hulking Helboar|r to turn them into |cRXP_ENEMY_Dreadtusk|r
>>Kill the |cRXP_ENEMY_Dreadtusk|r
.complete 10255,1 
.mob Dreadtusk
.mob Hulking Helboar
step
#completewith next
.goto Hellfire Peninsula,13.63,39.10
.cast 35413 >>|cRXP_WARN_Channel the|r |T133944:0|t[Seed of Revitalization] |cRXP_WARN_while standing on the green circle to summon|r |cRXP_ENEMY_Goliathon|r
.timer 49,Goliathon Summon RP
step
.goto Hellfire Peninsula,13.52,39.70
>>Kill |cRXP_ENEMY_Goliathon|r
>>|cRXP_WARN_This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r << tbc/wotlk
.use 29478 >>|cRXP_WARN_Be careful as |cRXP_ENEMY_Goliathon|r has a HUGE (60 yard) knockback|r
.complete 10351,1 
.isQuestTurnedIn 10134
.mob Goliathon
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthbinder Galandria Nightbreeze|r and |cRXP_FRIENDLY_Thiah Redmane|r
.turnin 10351 >>Turn in Natural Remedies
.goto Hellfire Peninsula,15.97,51.57
.turnin 10255 >> Turn in Testing the Antidote
.goto Hellfire Peninsula,15.70,52.08
.isQuestComplete 10351
.target Earthbinder Galandria Nightbreeze
.target Thiah Redmane
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thiah Redmane|r
.turnin 10255 >> Turn in Testing the Antidote
.goto Hellfire Peninsula,15.70,52.08
.target Thiah Redmane
step
#optional
#sticky
>>Abandon the elite quests if you were unable to complete them
.abandon 10132 >>Abandon Colossal Menace
step
#optional
#sticky
>>Abandon the elite quests if you were unable to complete them
.abandon 10351 >> Abandon Natural Remedies
step
.goto Hellfire Peninsula,12.15,46.50,50,0
.goto Hellfire Peninsula,9.13,49.47,50,0
.goto Hellfire Peninsula,11.60,55.18,50,0
.goto Hellfire Peninsula,7.41,49.74,50,0
.goto Hellfire Peninsula,5.37,51.43,50,0
.goto Hellfire Peninsula,9.13,49.47
>>Kill |cRXP_ENEMY_Thornfang Venomspitters|r and |cRXP_ENEMY_Thornfang Ravagers|r
.complete 10159,2 
.mob +Thornfang Venomspitter
.complete 10159,1 
.mob +Thornfang Ravager
]])
RXPGuides.RegisterGuide([[
#version 5
#cata
#Cata
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 61-63 Zangarmarsh
#displayname 61-64 Zangarmarsh << !tbc !wotlk
#version 5
#next 63-65 Terokkar Forest;65-67 Blade's Edge << tbc/wotlk
#next 64-66 Nagrand;65-67 Blade's Edge << !tbc !wotlk

step
.goto Zangarmarsh,82.81,64.85
.zone Zangarmarsh >> Travel to Zangarmarsh
step
#completewith next
>>|cRXP_WARN_Below is a list of items that drop in Zangarmarsh that are required for quests. Make a mental note of these items. Save them as they drop. You need a total of:|r
.collect 24291,6,9743,1 
.collect 24245,10,9808,1 
.collect 24401,10,9802,1 
.collect 24449,6,9806,1 
step
.goto 1946/530,5434.70020,-216.70000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ikeyen|r
.target Ikeyen
.accept 9747 >>Accept The Umbrafen Tribe
step
.goto 1946/530,5440.10010,-219.50000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lauranna Thar'well|r
.target Lauranna Thar'well
.accept 9802 >>Accept Plants of Zangarmarsh
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Wanted Poster|r and |cRXP_FRIENDLY_Warden Hamoot|r upstairs
.accept 9817 >> Accept Leader of the Bloodscale
.accept 9730 >> Accept Leader of the Darkcrest
.goto Zangarmarsh,79.08,64.88
.accept 9728 >> Accept A Warm Welcome
.goto Zangarmarsh,79.09,65.27
.target Warden Hamoot
step
#label RefugeHS
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lethyn Moonfire|r and |cRXP_FRIENDLY_Ysiel Windsinger|r
.accept 9895 >> Accept The Dying Balance
.goto Zangarmarsh,78.53,63.15,-1
.target +Lethyn Moonfire
.turnin 9912 >> Turn in The Cenarion Expedition
.accept 9716 >> Accept Disturbance at Umbrafen Lake
.goto Zangarmarsh,78.40,62.02,-1
.target +Ysiel Windsinger
step
#optional << tbc
.goto Zangarmarsh,67.83,51.46
>>Travel to Telredor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Munci|r
.fp Telredor >> Get the Telredor flight path
.skill riding,<225,1
.target Munci
step
#completewith Telredor
.goto Zangarmarsh,70.24,49.27,20 >> Use the elevator to get up to Telredor
.skill riding,225,1
step
#sticky
#label deadmire1
.groundgoto 1946/530,6039.70020,258.50000,0,0
.flygoto 1946/530,6039.70020,258.50000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Idaar|r
.target Vindicator Idaar
.accept 9782 >>Accept The Dead Mire
step
.goto 1946/530,6034.80029,283.10001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Prospector Conall|r
.target Prospector Conall
.accept 9901 >>Accept Unfinished Business
step
.goto 1946/530,6044.70020,283.70001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Ahuurn|r
.target Anchorite Ahuurn
.accept 9786 >>Accept The Boha'mu Ruins
step
.goto 1946/530,6033.30029,298.89999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ruam|r
.target Ruam
.accept 9777 >>Accept Fulgor Spores
step
#label Telredor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Haalrun|r
.accept 9781 >>Accept Too Many Mouths to Feed
.goto 1946/530,6065.60010,328.70001
.target +Haalrun
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Noraani|r
.accept 9791 >>Accept Menacing Marshfangs
.goto 1946/530,6074.80029,331.30002
.target +Noraani
step
#completewith Sporewing
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Caregiver Abidaar|r
.goto Zangarmarsh,67.14,49.03
.home 3644>> Set your Hearthstone to Telredor
.target Caregiver Abidaar
step
#optional << !tbc
.goto Zangarmarsh,67.83,51.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Munci|r
.fp Telredor >> Get the Telredor flight path
.skill riding,225,1
.target Munci
step
#requires deadmire1
step
#optional
#completewith Rippers
>>Kill |cRXP_ENEMY_Fen Striders|r and |cRXP_ENEMY_Sporebats|r. Loot them for their |cRXP_LOOT_Fertile Spores|r
.collect 24449,6,9806,1 
.mob *Fen Strider
.mob *Marsh Walker
.mob *Sporebat
.mob *Greater Sporebat
step
#optional
#completewith Sporewing
>>Kill |cRXP_ENEMY_Marshfang Rippers|r
.complete 9791,1 
.mob Marshfang Ripper
step
#loop
.line Zangarmarsh,68.81,47.75,68.03,48.34,66.01,46.49,65.86,47.37,64.74,49.34,66.46,52.07,70.99,53.95,70.74,50.20,71.57,45.46,68.81,47.75
.goto Zangarmarsh,68.81,47.75,45,0
.goto Zangarmarsh,68.03,48.34,45,0
.goto Zangarmarsh,66.01,46.49,45,0
.goto Zangarmarsh,65.86,47.37,45,0
.goto Zangarmarsh,64.74,49.34,45,0
.goto Zangarmarsh,66.46,52.07,45,0
.goto Zangarmarsh,70.99,53.95,45,0
.goto Zangarmarsh,70.74,50.20,45,0
.goto Zangarmarsh,71.57,45.46,45,0
.goto Zangarmarsh,68.81,47.75,45,0
>>Loot the |cRXP_PICK_Fulgor Spores|r on the ground
.complete 9777,1 
step
#label Sporewing
.goto Zangarmarsh,76.80,45.97,60,0
.goto Zangarmarsh,77.29,45.84,60,0
.goto Zangarmarsh,77.76,45.39,60,0
.goto Zangarmarsh,78.64,45.49,60,0
.goto Zangarmarsh,78.83,46.82,60,0
.goto Zangarmarsh,79.79,47.25,60,0
.goto Zangarmarsh,79.79,47.25,0
.line Zangarmarsh,76.80,45.97,77.29,45.84,77.76,45.39,78.64,45.49,78.83,46.82,79.79,47.25
>>Kill |cRXP_ENEMY_Sporewing|r
>>|cRXP_ENEMY_Sporewing|r |cRXP_WARN_patrol path is marked on your map|r
.complete 9901,1 
.unitscan Sporewing
step
.goto Zangarmarsh,83.82,43.29,-1
.goto Zangarmarsh,80.67,43.45,-1
.goto Zangarmarsh,79.95,42.06,-1
>>Loot the |cRXP_PICK_Dead Mire Soil|r on the ground
.complete 9782,1 
step
#label Rippers
#loop
.line Zangarmarsh,71.61,44.61,76.33,45.27,77.92,46.48,79.79,49.98,84.36,47.15,85.19,47.91,85.42,49.75,84.98,51.50,83.16,52.43,77.63,54.34,76.78,56.41,74.54,54.83,72.82,51.77,71.61,44.61
.goto Zangarmarsh,71.61,44.61,50,0
.goto Zangarmarsh,76.33,45.27,50,0
.goto Zangarmarsh,77.92,46.48,50,0
.goto Zangarmarsh,79.79,49.98,50,0
.goto Zangarmarsh,84.36,47.15,50,0
.goto Zangarmarsh,85.19,47.91,50,0
.goto Zangarmarsh,85.42,49.75,50,0
.goto Zangarmarsh,84.98,51.50,50,0
.goto Zangarmarsh,83.16,52.43,50,0
.goto Zangarmarsh,77.63,54.34,50,0
.goto Zangarmarsh,76.78,56.41,50,0
.goto Zangarmarsh,74.54,54.83,50,0
.goto Zangarmarsh,72.82,51.77,50,0
.goto Zangarmarsh,71.61,44.61,50,0
>>Kill |cRXP_ENEMY_Marshfang Rippers|r
.complete 9791,1 
.mob Marshfang Ripper
step
#completewith next
.hs >> Hearth to Telredor
.cooldown item,6948,>2

step
.goto 1946/530,6074.10010,329.80002
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Noraani|r
.target Noraani
.turnin 9791 >>Turn in Menacing Marshfangs
.accept 9780 >>Accept Umbrafen Eel Filets
step
.goto 1946/530,6027.70020,302.20001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ruam|r
.target Ruam
.turnin 9777 >>Turn in Fulgor Spores
step
.goto 1946/530,6030.89990,280.10001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Prospector Conall|r
.target Prospector Conall
.turnin 9901 >>Turn in Unfinished Business
.accept 9896 >>Accept Blacksting's Bane
step
.goto 1946/530,6038.20020,257.20001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Idaar|r
.target Vindicator Idaar
.turnin 9782 >>Turn in The Dead Mire
.accept 9783 >>Accept An Unnatural Drought
step
#optional
#completewith boglash
>>Kill |cRXP_ENEMY_Fen Striders|r and |cRXP_ENEMY_Sporebats|r. Loot them for their |cRXP_LOOT_Fertile Spores|r
.collect 24449,6,9806,1 
.mob *Fen Strider
.mob *Marsh Walker
.mob *Sporebat
.mob *Greater Sporebat
step
#optional
#label Basidium
#completewith next
>>Kill |cRXP_ENEMY_Withered Giants|r. Loot them for their |T134001:0|t[|cRXP_LOOT_Withered Basidium|r]
>>|cRXP_WARN_This is a rare drop, don't go out of your way to loot this|r << !tbc
.collect 24483,1,9827 
.mob Withered Giant
step
#label Giants
#loop
.line Zangarmarsh,82.12,44.97,79.44,42.62,77.86,35.41,80.99,31.26,84.94,36.18,85.96,42.24,82.12,44.97
.goto Zangarmarsh,82.12,44.97,60,0
.goto Zangarmarsh,79.44,42.62,60,0
.goto Zangarmarsh,77.86,35.41,60,0
.goto Zangarmarsh,80.99,31.26,60,0
.goto Zangarmarsh,84.94,36.18,60,0
.goto Zangarmarsh,85.96,42.24,60,0
.goto Zangarmarsh,82.12,44.97,60,0
>>Kill |cRXP_ENEMY_Withered Giants|r, loot the |cRXP_LOOT_Bog Lord Tendrils|r for a quest later
.collect 24291,6,9743,1,1 
.complete 9783,1 
.mob Withered Giant
step
#questguide << !tbc
#label BasidiumX
#loop
.line Zangarmarsh,82.12,44.97,79.44,42.62,77.86,35.41,80.99,31.26,84.94,36.18,85.96,42.24,82.12,44.97
.goto Zangarmarsh,82.12,44.97,60,0
.goto Zangarmarsh,79.44,42.62,60,0
.goto Zangarmarsh,77.86,35.41,60,0
.goto Zangarmarsh,80.99,31.26,60,0
.goto Zangarmarsh,84.94,36.18,60,0
.goto Zangarmarsh,85.96,42.24,60,0
.goto Zangarmarsh,82.12,44.97,60,0
.use 24483 >>Kill |cRXP_ENEMY_Withered Giants|r. Loot them for their |T134001:0|t[|cRXP_LOOT_Withered Basidium|r]
.collect 24291,6,9743,1,1 
.collect 24483,1,9827 
.mob Withered Giant
step
#sticky
#optional
.use 24483>>|cRXP_WARN_Use the|r |T134001:0|t[|cRXP_LOOT_Withered Basidium|r] |cRXP_WARN_to start the quest|r
.itemcount 24483,1
.accept 9827 >> Accept Withered Basidium
step << !Warlock
#completewith eels
#optional
.cast 22807 >> |cRXP_WARN_Use the|r |T134716:0|t[Potion of Water Breathing]
.use 25539
.itemcount 25539,1
step
#label Scales
#completewith lakeEnd
>>Kill |cRXP_ENEMY_Mire Hydras|r
.complete 9781,1 
.mob Mire Hydra
step
#label eels
#loop
.line Zangarmarsh,73.89,61.37,75.28,63.48,76.32,66.48,76.78,71.37,76.74,75.66,76.76,79.11,74.88,81.27,73.91,79.38,71.94,81.30,73.44,76.43,73.94,72.76,72.92,69.75,73.98,67.64,72.26,66.54,71.63,62.34,73.89,61.37
.goto Zangarmarsh,73.89,61.37,50,0
.goto Zangarmarsh,75.28,63.48,50,0
.goto Zangarmarsh,76.32,66.48,50,0
.goto Zangarmarsh,76.78,71.37,50,0
.goto Zangarmarsh,76.74,75.66,50,0
.goto Zangarmarsh,76.76,79.11,50,0
.goto Zangarmarsh,74.88,81.27,50,0
.goto Zangarmarsh,73.91,79.38,50,0
.goto Zangarmarsh,71.94,81.30,50,0
.goto Zangarmarsh,73.44,76.43,50,0
.goto Zangarmarsh,73.94,72.76,50,0
.goto Zangarmarsh,72.92,69.75,50,0
.goto Zangarmarsh,73.98,67.64,50,0
.goto Zangarmarsh,72.26,66.54,50,0
.goto Zangarmarsh,71.63,62.34,50,0
.goto Zangarmarsh,73.89,61.37,50,0
.use 25539 >>Kill |cRXP_ENEMY_Umbrafen Eels|r. Loot them for their |cRXP_LOOT_Filets|r
.complete 9780,1 
.mob Umbrafen Eel
step
.goto Zangarmarsh,70.57,80.28
>>Travel near to the Water Pump
.complete 9716,1 
step
#label lakeEnd
.goto Zangarmarsh,85.29,90.93,160 >> Head to Umbrafen Village
.isOnQuest 9747
.subzoneskip 3641
step
#completewith Kataru2
>>Kill |cRXP_ENEMY_Umbrafen Oracles|r, |cRXP_ENEMY_Umbrafen Seers|r and |cRXP_ENEMY_Umbrafen Witchdoctors|r
.complete 9747,2 
.mob +Umbrafen Oracle
.complete 9747,3 
.mob +Umbrafen Seer
.complete 9747,4 
.mob +Umbrafen Witchdoctor
step
#label Kataru2
.groundgoto Zangarmarsh,84.99,90.27,20,0
.goto Zangarmarsh,85.29,90.93
>>Kill |cRXP_ENEMY_Kataru|r atop the tower
.complete 9747,1 
.unitscan Kataru
step
#loop
.line Zangarmarsh,83.52,89.16,83.76,88.09,85.50,88.89,84.45,86.16,85.14,82.69,85.71,81.14,85.10,81.08,83.64,81.11,83.60,79.54,83.07,81.06,83.72,82.93,83.38,84.68,82.37,84.73,83.52,89.16
.goto Zangarmarsh,83.52,89.16,50,0
.goto Zangarmarsh,83.76,88.09,50,0
.goto Zangarmarsh,85.50,88.89,50,0
.goto Zangarmarsh,84.45,86.16,50,0
.goto Zangarmarsh,85.14,82.69,50,0
.goto Zangarmarsh,85.71,81.14,50,0
.goto Zangarmarsh,85.10,81.08,50,0
.goto Zangarmarsh,83.64,81.11,50,0
.goto Zangarmarsh,83.60,79.54,50,0
.goto Zangarmarsh,83.07,81.06,50,0
.goto Zangarmarsh,83.72,82.93,50,0
.goto Zangarmarsh,83.38,84.68,50,0
.goto Zangarmarsh,82.37,84.73,50,0
.goto Zangarmarsh,83.52,89.16,50,0
>>Kill |cRXP_ENEMY_Umbrafen Oracles|r, |cRXP_ENEMY_Umbrafen Seers|r and |cRXP_ENEMY_Umbrafen Witchdoctors|r
.complete 9747,2 
.mob +Umbrafen Oracle
.complete 9747,3 
.mob +Umbrafen Seer
.complete 9747,4 
.mob +Umbrafen Witchdoctor
step
.goto Zangarmarsh,83.38,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kayra Longmane|r
*|cRXP_WARN_You may need to wait for |cRXP_FRIENDLY_Kayra Longmane|r to respawn|r
.accept 9752 >> Accept Escape from Umbrafen
.target Kayra Longmane
step
#optional
#completewith next
.goto Zangarmarsh,83.89,78.58,100,0
.goto Zangarmarsh,82.63,77.98,80,0
.goto Zangarmarsh,81.72,75.58,60,0
.goto Zangarmarsh,82.11,73.88,60,0
.goto Zangarmarsh,81.73,72.94,60,0
.goto Zangarmarsh,81.75,72.20
.line Zangarmarsh,83.89,78.58,82.63,77.98,81.72,75.58,82.11,73.88,81.73,72.94,81.75,72.20
>>Kill |cRXP_ENEMY_Boglash|r using |cRXP_FRIENDLY_Kayra Longmane|r to assist you
>>|cRXP_WARN_Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r << tbc
.complete 9895,1 
.unitscan Boglash
.target Kayra Longmane
step
.goto Zangarmarsh,79.83,71.17
>>Escort |cRXP_FRIENDLY_Kayra Longmane|r. She can heal and assist you in combat
.complete 9752,1 
.target Kayra Longmane
step
.goto Zangarmarsh,83.89,78.58,60,0
.goto Zangarmarsh,82.63,77.98,60,0
.goto Zangarmarsh,81.72,75.58,60,0
.goto Zangarmarsh,82.11,73.88,60,0
.goto Zangarmarsh,81.73,72.94,60,0
.goto Zangarmarsh,81.75,72.20
.line Zangarmarsh,83.89,78.58,82.63,77.98,81.72,75.58,82.11,73.88,81.73,72.94,81.75,72.20
>>Kill |cRXP_ENEMY_Boglash|r
>>|cRXP_WARN_Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r << tbc
.complete 9895,1 
.unitscan Boglash
step
#label boglash
>>Kill any mob in Zangarmarsh
.collect 24401,10,9802,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ikeyen|r
.target Ikeyen
.goto Zangarmarsh,80.39,64.15
.turnin 9747 >>Turn in The Umbrafen Tribe
.accept 9788 >>Accept A Damp, Dark Place
step
.goto Zangarmarsh,80.32,64.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lauranna Thar'well|r
.target Lauranna Thar'well
.turnin 9802 >>Turn in Plants of Zangarmarsh
.accept 10096 >>Accept Saving the Sporeloks
step
#sticky
#label blessing1a
.goto 1946/530,5434.60010,-233.50000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Windcaller Blackhoof|r
.target Windcaller Blackhoof
.accept 9785 >>Accept Blessings of the Ancients
.reputation 942,friendly,<0,1
step
.goto 1946/530,5434.60010,-233.50000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Windcaller Blackhoof|r
.target Windcaller Blackhoof
.accept 9894 >>Accept Safeguarding the Watchers
step
#requires blessing1a
.goto 1946/530,5525.50000,-182.30000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lethyn Moonfire|r
.target Lethyn Moonfire
.turnin 9895 >>Turn in The Dying Balance
step
.goto 1946/530,5533.39990,-145.20000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ysiel Windsinger|r
.target Ysiel Windsinger
.turnin 9752 >> Turn in Escape from Umbrafen
.isQuestComplete 9752
step
#label CenarionPost2
.goto 1946/530,5533.39990,-145.20000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ysiel Windsinger|r
.target Ysiel Windsinger
.turnin 9716 >>Turn in Disturbance at Umbrafen Lake
.accept 9718 >>Accept As the Crow Flies
step
.goto Zangarmarsh,78.40,62.02
>>|cRXP_WARN_Use the|r |T134911:0|t[Stormcrow Amulet]
.complete 9718,1 
.cast 31606
.timer 155,As the Crow Flies RP
.use 25465
step
.goto Zangarmarsh,78.40,62.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ysiel Windsinger|r
.turnin 9718 >> Turn in As the Crow Flies
.accept 9720 >> Accept Balance Must Be Preserved
.target Ysiel Windsinger
step
#optional
#completewith Klaq
>>Kill |cRXP_ENEMY_Fen Striders|r and |cRXP_ENEMY_Sporebats|r. Loot them for their |cRXP_LOOT_Fertile Spores|r
.collect 24449,6,9806,1 
.mob *Fen Strider
.mob *Marsh Walker
.mob *Sporebat
.mob *Greater Sporebat
.subzoneskip 3652
step
#sticky
#label q10096
#loop
.goto Zangarmarsh,74.44,92.06,0
.goto Zangarmarsh,72.39,93.82,0
.waypoint Zangarmarsh,74.44,92.06,50,0
.waypoint Zangarmarsh,72.39,93.82,50,0
>>Kill |cRXP_ENEMY_Marsh Dredgers|r and |cRXP_ENEMY_Marsh Lurkers|r inside the Cavern. Loot them for their |cRXP_LOOT_Plant Parts|r
.complete 10096,1 
.mob +Marsh Dredger
.complete 10096,2 
.mob +Marsh Lurker
step
#label Klaq
.goto Zangarmarsh,74.44,92.06,60,0
.goto Zangarmarsh,72.39,93.82
>>Enter the Funggor Cavern. Drop down into the middle of the Cavern
>>Kill |cRXP_ENEMY_Lord Klaq|r
.complete 9894,1 
.unitscan Lord Klaq
step
#label Ikeyen
.goto Zangarmarsh,72.94,96.60,20,0
.goto Zangarmarsh,70.53,97.91
>>Loot |cRXP_PICK_Ikeyen's Belongings|r in the back of the Cavern
.complete 9788,1 
step
#requires q10096
step
#optional
#completewith Blacksting
>>Kill |cRXP_ENEMY_Fen Striders|r and |cRXP_ENEMY_Sporebats|r. Loot them for their |cRXP_LOOT_Fertile Spores|r
.collect 24449,6,9806,1 
.mob *Fen Strider
.mob *Marsh Walker
.mob *Sporebat
.mob *Greater Sporebat
step
#completewith hydra1end
>>Kill |cRXP_ENEMY_Darkcrest Nagas|r. Loot them for their |cRXP_LOOT_Claws|r
.complete 9728,1 
.mob *Darkcrest Siren
.mob *Darkcrest Slaver
.mob *Darkcrest Sorceress
.mob *Darkcrest Taskmaster
.subzoneskip 3642
step
#completewith Lagoon
.use 24330 >>Kill |cRXP_ENEMY_Steam Pump Overseers|r that spawn after using the |T136074:0|t[Ironvine Seeds] on the Lake Controls. Loot them for their |T134944:0|t[|cRXP_LOOT_Drain Schematics|r]
.collect 24330,1,9731 
.mob Steam Pump Overseer
step
.goto Zangarmarsh,70.60,80.29
.use 24355 >>|cRXP_WARN_Use the|r |T136074:0|t[Ironvine Seeds] |cRXP_WARN_Lake Controls|r
.complete 9720,1 
step
#label Rajah
.goto Zangarmarsh,65.10,68.67
>>Kill |cRXP_ENEMY_Rajah Haghazed|r
>>|cRXP_WARN_Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r << tbc/wotlk
.complete 9730,1 
.unitscan Rajah Haghazed
step
#label Lagoon
.goto Zangarmarsh,63.11,64.09
>>|cRXP_WARN_Use the|r |T136074:0|t[Ironvine Seeds] |cRXP_WARN_Lake Controls|r
.complete 9720,4 
.use 24355
step
.goto Zangarmarsh,63.11,64.09
.use 24355 >>|cRXP_WARN_Keep using the|r |T136074:0|t[Ironvine Seeds] |cRXP_WARN_on the Lake Controls to spawn and kill|r |cRXP_ENEMY_Steam Pump Overseers|r. Loot them for their |T134944:0|t[|cRXP_LOOT_Drain Schematics|r]
>>Farm |cRXP_LOOT_Naga Claws|r while you wait for the Seeds to come off cooldown
.collect 24330,1,9731 
step
#sticky
.use 24330 >>|cRXP_WARN_Click the|r |T134944:0|t[|cRXP_LOOT_Drain Schematics|r] |cRXP_WARN_to start the quest|r
.accept 9731 >> Accept Drain Schematics
.mob Steam Pump Overseer
.itemcount 24330,1
step
#label hydra1end
.goto Zangarmarsh,53.79,66.14
>>Kill |cRXP_ENEMY_Mire Hydras|r
.complete 9781,1 
.mob Mire Hydra
step
#label Blacksting
.goto Zangarmarsh,49.80,59.44
>>Kill |cRXP_ENEMY_Blacksting|r. Loot him for his |cRXP_LOOT_Stinger|r
.complete 9896,1 
.mob Blacksting
step
.goto Zangarmarsh,44.13,68.91
>>Enter the Boha'mu Ruins
>>|cRXP_WARN_You don't need to pull the elite!|r
.complete 9786,1 
step
.goto Zangarmarsh,50.39,40.92
>>Head to the middle of the lake, then dive underwater toward the drain
.complete 9731,1 
step
#optional
#completewith next
>>Loot the |cRXP_PICK_Orange Mushrooms|r on the ground throughout Zangarmarsh
.collect 24245,10,9808,1 
step
#completewith next
.goto Zangarmarsh,41.28,29.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halu|r
.fp Orebor Harborage >> Get the Orebor Harborage flight path
.target Halu
step << !Shaman
#completewith next
.goto Zangarmarsh,41.28,29.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halu|r
.fly Telredor >> Fly to Telredor
.target Halu
step << Shaman
#completewith next
.hs >>Hearth to Telredor
step << !Shaman
.goto 1946/530,6040.00000,257.10001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Idaar|r
.target Vindicator Idaar
.turnin 9783 >>Turn in An Unnatural Drought
.accept 9793 >>Accept The Fate of Tuurem << tbc/wotlk
step << !Shaman
.goto 1946/530,6044.89990,278.89999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Ahuurn|r
.target Anchorite Ahuurn
.turnin 9786 >>Turn in The Boha'mu Ruins
.accept 9787 >>Accept Idols of the Feralfen
.accept 9776 >>Accept The Orebor Harborage
step << !Shaman
.goto 1946/530,6030.89990,283.60001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Prospector Conall|r
.target Prospector Conall
.turnin 9896 >>Turn in Blacksting's Bane
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Noraani|r
.turnin 9780 >>Turn in Umbrafen Eel Filets
.target +Noraani
.goto 1946/530,6075.50000,329.39999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Haalrun|r
.turnin 9781 >>Turn in Too Many Mouths to Feed
.accept 9790 >>Accept Diaphanous Wings
.goto 1946/530,6065.70020,327.50000
.target +Haalrun
step
.goto Zangarmarsh,68.62,48.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ruam|r
.target Ruam
.turnin 9827 >> Turn in Withered Basidium
.isOnQuest 9827
step << Shaman
.goto 1946/530,6030.89990,283.60001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Prospector Conall|r
.target Prospector Conall
.turnin 9896 >>Turn in Blacksting's Bane
step << Shaman
.goto 1946/530,6044.89990,278.89999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Ahuurn|r
.target Anchorite Ahuurn
.turnin 9786 >>Turn in The Boha'mu Ruins
.accept 9787 >>Accept Idols of the Feralfen
.accept 9776 >>Accept The Orebor Harborage
step << Shaman
.goto 1946/530,6040.00000,257.10001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Idaar|r
.target Vindicator Idaar
.turnin 9783 >>Turn in An Unnatural Drought
.accept 9793 >>Accept The Fate of Tuurem << tbc/wotlk
step << !tbc
.goto 1946/530,5534.89990,-142.30000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ysiel Windsinger|r
.target Ysiel Windsinger
.turnin 9731 >>Turn in Drain Schematics
.accept 9724 >>Accept Warning the Cenarion Circle
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lauranna Thar'well|r
.turnin 9802 >>Turn in Plants of Zangarmarsh
.turnin 10096 >>Turn in Saving the Sporeloks
.goto 1946/530,5438.20020,-215.70000
.target +Lauranna Thar'well
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ikeyen|r
.turnin 9788 >>Turn in A Damp, Dark Place
.goto 1946/530,5434.70020,-215.40001
.target +Ikeyen
step
.goto 1946/530,5438.20020,-215.70000
.dailyturnin 9784>>Talk to |cRXP_FRIENDLY_Lauranna Thar'well|r
.disablecheckbox
+Turn in all your |T133940:0|t[Unidentified Plant Parts]
.itemcount 24401,10
.reputation 942,honored,0,1
.target Lauranna Thar'well
step
.goto 1946/530,5434.10010,-234.00000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Windcaller Blackhoof|r
.target Windcaller Blackhoof
.turnin 9894 >>Turn in Safeguarding the Watchers
.accept 9785 >> Accept Blessings of the Ancients
step
#sticky
#label ashyen
.goto Zangarmarsh,81.11,63.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ashyen|r
.complete 9785,1 
.skipgossip
.target Ashyen
step
#loop
.goto Zangarmarsh,81.11,64.37,40,0
.goto Zangarmarsh,79.57,64.48,40,0
.goto Zangarmarsh,78.25,63.88,40,0
.goto Zangarmarsh,78.24,65.82,40,0
.goto Zangarmarsh,78.71,66.49,40,0
.goto Zangarmarsh,78.96,67.44,40,0
.line Zangarmarsh,78.96,67.44,78.71,66.49,78.24,65.82,78.25,63.88,79.57,64.48,81.11,64.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keleth|r
>>|cRXP_FRIENDLY_Keleth|r |cRXP_WARN_patrols slighty|r
.complete 9785,2 
.skipgossip
.unitscan Keleth
step
#requires ashyen
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Windcaller Blackhoof|r
.turnin 9785 >> Turn in Blessings of the Ancients
.goto Zangarmarsh,80.37,64.73
.target Windcaller Blackhoof
step
#sticky
#label hamoot1a
.goto Zangarmarsh,79.09,65.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Warden Hamoot|r in the Tower
.turnin 9728 >> Turn in A Warm Welcome
.isQuestComplete 9728
.target Warden Hamoot
step
#sticky
#label hamoot2a
.goto Zangarmarsh,79.09,65.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Warden Hamoot|r in the Tower
.turnin 9817 >> Turn in Leader of the Bloodscale
.isQuestComplete 9817
.target Warden Hamoot
step
.goto Zangarmarsh,79.09,65.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Warden Hamoot|r in the Tower
.turnin 9730 >> Turn in Leader of the Darkcrest
.isQuestComplete 9730
.target Warden Hamoot
step
#requires hamoot1a
step
#requires hamoot2a
.goto Zangarmarsh,78.53,63.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lethyn Moonfire|r
.accept 9697 >> Accept Watcher Leesa'oh
.accept 9957 >> Accept What's Wrong at Cenarion Thicket? << tbc/wotlk
.target Lethyn Moonfire
step << tbc
.goto 1946/530,5534.89990,-142.30000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ysiel Windsinger|r
.target Ysiel Windsinger
.turnin 9731 >>Turn in Drain Schematics
.accept 9724 >>Accept Warning the Cenarion Circle
step
>>Travel to Cenarion Post
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mahuram Stouthoof|r and |cRXP_FRIENDLY_Amythiel Mistwalker|r
.turnin -10159 >> Turn in Keep Thornfang Hill Clear!
.goto Hellfire Peninsula,15.65,52.15
.turnin 9724 >> Turn in Warning the Cenarion Circle
.accept 9732 >> Accept Return to the Marsh
.goto Hellfire Peninsula,16.04,52.15
.target Mahuram Stouthoof
.target Amythiel Mistwalker
step << Shaman (tbc/wotlk)
#completewith next
.hs >> Hearth to Telredor
.skill riding,225,1
step << tbc/wotlk
#completewith Adal
.goto Hellfire Peninsula,25.19,37.23 << !Shaman
.goto Zangarmarsh,67.83,51.46 << Shaman
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kuma|r << !Shaman
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Munci|r << Shaman
.fly Shattrath >> Fly to Shattrath City
.skill riding,225,1
.target Kuma << !Shaman
.target Munci << Shaman
step << tbc/wotlk
#completewith Adal
.goto Shattrath City,59.66,41.45
.zone Shattrath City >> Travel to Shattrath City
.skill riding,<225,1
step << tbc/wotlk
#label Adal
.goto 1955/530,5362.10010,-1832.90002
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Haggard War Veteran|r
.target Haggard War Veteran
.accept 10210 >>Accept A'dal
step << tbc/wotlk
.goto 1955/530,5426.70020,-1862.70007
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_A'dal|r
.target A'dal
.turnin 10210 >>Turn in A'dal
step << tbc/wotlk
.goto 1955/530,5421.80029,-1859.00000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Khadgar's Servant|r
.target Khadgar
.accept 10211 >>Accept City of Light
.timer 462,City of Light RP
step << tbc/wotlk
#completewith next
#xprate <1.5
>>Whilst following |cRXP_FRIENDLY_Khadgar's Servant|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Seth|r
.accept 10037 >> Accept Rather Be Fishin'
.target +Seth
.goto Shattrath City,63.94,15.52
.goto Shattrath City,52.54,21.03
.target Khadgar's Servant
step << tbc/wotlk
.goto Shattrath City,50.36,42.87
>>Follow |cRXP_FRIENDLY_Khadgar's Servant|r << wotlk
>>Head up to the second floor with |cRXP_FRIENDLY_G'eras|r and wait out the RP. If someone elses |cRXP_FRIENDLY_Khadgar's Servant|r arrives in the meantime, you can target it and it will complete the quest for you. If the quest fails, abandon it, accept the quest from |cRXP_FRIENDLY_Khadgar's Servant|r again, then follow the |cRXP_FRIENDLY_Khadgar's Servant|r around << tbc
.complete 10211,1 
.target Khadgar's Servant
step << Mage (tbc/wotlk)
.goto Shattrath City,58.77,47.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Iorioa|r
.train 35715 >> Train Teleport: Shattrath and Portal: Shattrath
.target Iorioa
step << tbc/wotlk
.goto Shattrath City,54.74,44.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Khadgar's Servant|r
.turnin 10211 >> Turn in City of Light
.target Khadgar
step << tbc/wotlk
.goto Shattrath City,54.74,44.32
.turninmultiple 10551,10552>>Talk to |cRXP_FRIENDLY_Khadgar's Servant|r. Pledge your Allegiance to either the Aldor or Scryers
*If you do not see Aldor or Scryer specific quest steps after this, type "/reload" into your ingame chat box
.target Khadgar
.isQuestAvailable 10551
.isQuestAvailable 10552
step << tbc/wotlk
#scryer
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Khadgar's Servant|r
.goto Shattrath City,54.74,44.32
.accept 10553 >>Accept Voren'thal the Seer
.target Khadgar
step << tbc/wotlk
#aldor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Khadgar's Servant|r
.goto Shattrath City,54.74,44.32
.accept 10554 >> Accept Ishanah
.target Khadgar
step << (Warlock/Shaman/Paladin/Mage) (tbc/wotlk)
#completewith next
.goto Shattrath City,55.7,36.9 << !Mage
.zone Stormwind City >> Take the portal to Stormwind << !Mage
.zone Stormwind City >> Teleport to Stormwind << Mage
step << (Warlock/Shaman/Paladin/Mage) (tbc/wotlk)
.goto StormwindClassic,25.3,78.7 << Warlock
.goto StormwindClassic,38.6,32.8 << Paladin
.goto StormwindClassic,61.9,84.0 << Shaman
.goto StormwindClassic,39.6,79.6 << Mage
.trainer >> Train your class spells
.target Ursula Deline << Warlock
.target Demisette Cloyce << Warlock
.target Sandahl << Warlock
.target Arthur the Faithful << Paladin
.target Katherine the Pure << Paladin
.target Lord Grayson Shadowbreaker << Paladin
.target Farseer Umbrua << Shaman
.target Elsharin << Mage
.target Jennea Cannon << Mage
step << (Warrior/Hunter/Rogue/Priest) (tbc/wotlk)
#completewith next
.goto Shattrath City,55.2,36.5
.zone Darnassus >> Take the portal to Darnassus
step << (Warrior/Hunter/Rogue/Priest) (tbc/wotlk)
.goto Darnassus,39.0,83.2 << Priest
.goto Darnassus,40.6,9.2 << Hunter
.goto Darnassus,31.5,17.4 << Rogue
.goto Darnassus,58.75,35.16 << Warrior
.trainer >> Train your class spells
.target Jandria << Priest
.target Jocaste << Hunter
.target Anishar << Rogue
.target Erion Shadewhisper << Rogue
.target Syurna << Rogue
.target Arias'ta Bladesinger << Warrior

step << Druid (tbc/wotlk)
>>Teleport to Moonglade
.goto Moonglade,52.4,40.6
.trainer 12042 >> Train your class spells
.target Loganaar << Druid
step << DK (tbc/wotlk)
#completewith next
.cast 50977 >> Cast Death Gate
.zoneskip Eastern Plaguelands
step << DK (tbc/wotlk)
.goto Eastern Plaguelands,80.3,48.0
>>Go through the Death Gate
.trainer >> Train your class spells from |cRXP_FRIENDLY_Amal'thazad|r in Acherus
.target Amal'thazad
step
#completewith Vial
.hs >> Hearth to Telredor

step
#completewith next
.goto Zangarmarsh,67.83,51.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Munci|r
.fly Orebor Harborage >> Fly to Orebor Harborage
.skill riding,300,1
.target Munci
step
.goto 1946/530,7400.70020,973.50000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Timothy Daniels|r
.target Timothy Daniels
.accept 9848 >>Accept Secrets of the Daggerfen
step
.goto 1946/530,7376.20020,1019.90002
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cRXP_FRIENDLY_Wanted Poster|r
.accept 10116 >>Accept Wanted: Chieftain Mummaki
step
.goto 1946/530,7367.70020,1022.60004
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ikuti|r
.target Ikuti
.accept 9835 >>Accept Ango'rosh Encroachment
.accept 10115 >>Accept Daggerfen Deviance
.turnin 9776 >>Turn in The Orebor Harborage
step
#optional
#completewith Vial
>>Kill |cRXP_ENEMY_Greater Sporebats|r and |cRXP_ENEMY_Marsh Walkers|r. Loot them for their |cRXP_LOOT_Fertile Spores|r
.collect 24449,6,9806,1 
.mob *Greater Sporebat
.mob *Marsh Walker
.subzoneskip 3640
step
#optional
#completewith Vial
>>Loot the |cRXP_PICK_Orange Mushrooms|r on the ground throughout Zangarmarsh
.collect 24245,10,9808,1 
step
#optional
#completewith Mummaki
>>Kill |cRXP_ENEMY_Daggerfen Assassins|r and |cRXP_ENEMY_Daggerfen Muckdwellers|r
.complete 10115,1 
.mob +Daggerfen Assassin
.complete 10115,2 
.mob +Daggerfen Muckdweller
step
#label Vial
.goto Zangarmarsh,26.40,22.85
>>Loot the small |cRXP_PICK_Daggerfen Poison Vial|r on the ground
.complete 9848,2 
step
#label Mummaki
>>Kill |cRXP_ENEMY_Chieftain Mummaki|r atop the tower. Loot him for his |cRXP_LOOT_Totem|r
>>Loot the |cRXP_PICK_Daggerfen Poison Manual|r book on the top floor near |cRXP_ENEMY_Mummaki|r
.complete 10116,1 
.goto Zangarmarsh,23.77,26.74,-1
.complete 9848,1 
.goto Zangarmarsh,24.40,27.00,-1
.unitscan Chieftain Mummaki
step
#optional
#completewith Oreboring
>>Kill |cRXP_ENEMY_Greater Sporebats|r and |cRXP_ENEMY_Marsh Walkers|r. Loot them for their |cRXP_LOOT_Fertile Spores|r
.collect 24449,6,9806,1 
.mob *Greater Sporebat
.mob *Marsh Walker
step
#loop
.line Zangarmarsh,24.58,26.44,25.83,27.17,27.06,25.42,28.18,23.79,28.50,22.23,26.24,22.36,26.31,20.43,25.00,20.56,24.87,22.28,22.89,21.07,22.24,22.32,24.22,24.50,25.74,24.95,24.58,26.44
.goto Zangarmarsh,24.58,26.44,50,0
.goto Zangarmarsh,25.83,27.17,50,0
.goto Zangarmarsh,27.06,25.42,50,0
.goto Zangarmarsh,28.18,23.79,50,0
.goto Zangarmarsh,28.50,22.23,50,0
.goto Zangarmarsh,26.24,22.36,50,0
.goto Zangarmarsh,26.31,20.43,50,0
.goto Zangarmarsh,25.00,20.56,50,0
.goto Zangarmarsh,24.87,22.28,50,0
.goto Zangarmarsh,22.89,21.07,50,0
.goto Zangarmarsh,22.24,22.32,50,0
.goto Zangarmarsh,24.22,24.50,50,0
.goto Zangarmarsh,25.74,24.95,50,0
.goto Zangarmarsh,24.58,26.44,50,0
>>Kill |cRXP_ENEMY_Daggerfen Assassins|r and |cRXP_ENEMY_Daggerfen Muckdwellers|r
.complete 10115,1 
.mob +Daggerfen Assassin
.complete 10115,2 
.mob +Daggerfen Muckdweller
step
#optional
#completewith Oreboring
>>Loot |cRXP_PICK_Glowcaps|r on the ground throughout Zangarmarsh
.collect 24245,10,9808,1 
step
#loop
.line Zangarmarsh,28.90,27.88,29.29,26.89,30.66,26.89,32.03,27.30,33.20,28.97,35.19,26.85,37.09,26.88,38.88,28.22,37.80,28.63,36.08,29.61,36.41,32.55,36.40,33.65,35.11,34.53,34.27,33.37,34.45,31.45,33.94,30.16,32.44,32.76,31.67,30.44,29.97,30.13,28.90,27.88
.goto Zangarmarsh,28.90,27.88,50,0
.goto Zangarmarsh,29.29,26.89,50,0
.goto Zangarmarsh,30.66,26.89,50,0
.goto Zangarmarsh,32.03,27.30,50,0
.goto Zangarmarsh,33.20,28.97,50,0
.goto Zangarmarsh,35.19,26.85,50,0
.goto Zangarmarsh,37.09,26.88,50,0
.goto Zangarmarsh,38.88,28.22,50,0
.goto Zangarmarsh,37.80,28.63,50,0
.goto Zangarmarsh,36.08,29.61,50,0
.goto Zangarmarsh,36.41,32.55,50,0
.goto Zangarmarsh,36.40,33.65,50,0
.goto Zangarmarsh,35.11,34.53,50,0
.goto Zangarmarsh,34.27,33.37,50,0
.goto Zangarmarsh,34.45,31.45,50,0
.goto Zangarmarsh,33.94,30.16,50,0
.goto Zangarmarsh,32.44,32.76,50,0
.goto Zangarmarsh,31.67,30.44,50,0
.goto Zangarmarsh,29.97,30.13,50,0
.goto Zangarmarsh,28.90,27.88,50,0
>>Kill |cRXP_ENEMY_Ango'rosh Shamans|r and |cRXP_ENEMY_Ogres|r
.complete 9835,1 
.mob +Ango'rosh Shaman
.complete 9835,2 
.mob +Ango'rosh Ogre
step
#label Oreboring
.goto Zangarmarsh,41.94,27.19
>>Return to Orebor Harborage
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ikuti|r
.turnin 9835 >> Turn in Ango'rosh Encroachment
.accept 9839 >> Accept Overlord Gorefist
.turnin 10115 >> Turn in Daggerfen Deviance
.turnin 10116 >> Turn in Wanted: Chieftain Mummaki
.target Ikuti
step
#completewith Sporelings
.goto Zangarmarsh,41.85,26.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Kerp|r
.home >> Set your Hearthstone to Orebor Harborage
.target Innkeeper Kerp
step
.goto 1946/530,7382.50000,1019.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maktu|r
.target Maktu
.accept 9834 >>Accept Natural Armor
step
.goto 1946/530,7401.50000,976.40002
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Timothy Daniels|r
.target Timothy Daniels
.turnin 9848 >>Turn in Secrets of the Daggerfen
step
.goto 1946/530,7421.0,976.29999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Puluu|r
.target Puluu
.accept 9830 >>Accept Stinger Venom
.accept 9833 >>Accept Lines of Communication
.accept 9902 >>Accept The Terror of Marshlight Lake
step
#optional
#completewith Sporelings
>>Loot |cRXP_PICK_Glowcaps|r on the ground throughout Zangarmarsh
.collect 24245,10,9808,1 
step
#optional
#completewith Sporelings
>>Kill |cRXP_ENEMY_Greater Sporebats|r and |cRXP_ENEMY_Marsh Walkers|r. Loot them for their |cRXP_LOOT_Fertile Spores|r
.collect 24449,6,9806,1 
.mob *Greater Sporebat
.mob *Marsh Walker
step
#optional
#completewith Sporelings
>>Kill |cRXP_ENEMY_Marshfang Slicers|r
.complete 9833,1 
.mob Marshfang Slicer
step
#label Leesa1
.goto Zangarmarsh,23.32,66.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Watcher Leesa'oh|r
.turnin 9697 >> Turn in Watcher Leesa'oh
.accept 9701 >> Accept Observing the Sporelings
.target Watcher Leesa'oh
step
#label Sporelings
.goto Zangarmarsh,19.03,62.34,50,0
.goto Zangarmarsh,19.19,64.60
.line Zangarmarsh,19.03,62.34,19.19,64.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fahssn|r. He patrols around slightly
.accept 9739 >> Accept The Sporelings' Plight
.accept 9743 >> Accept Natural Enemies
.target Fahssn
step
#optional
#completewith Tendrils
>>Collect |cRXP_PICK_Sacs|r (they look like balloons) on the ground
.complete 9739,1 
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Bog Lords|r. Loot them for their |cRXP_LOOT_Tendrils|r
.complete 9743,1 
.mob Starving Fungal Giant
.mob Starving Bog Lord
.mob Bog Lord
step
.goto Zangarmarsh,14.95,59.88
>>Travel near to the Spawning Glen
.complete 9701,1 
step
#label Tendrils
#loop
.line Zangarmarsh,13.76,57.97,10.51,60.28,10.53,62.68,13.24,63.84,17.35,63.48,17.46,57.13,13.76,57.97
.goto Zangarmarsh,13.76,57.97,60,0
.goto Zangarmarsh,10.51,60.28,60,0
.goto Zangarmarsh,10.53,62.68,60,0
.goto Zangarmarsh,13.24,63.84,60,0
.goto Zangarmarsh,17.35,63.48,60,0
.goto Zangarmarsh,17.46,57.13,60,0
.goto Zangarmarsh,13.76,57.97,60,0
>>Kill |cRXP_ENEMY_Bog Lords|r. Loot them for their |cRXP_LOOT_Tendrils|r
.complete 9743,1 
.mob Starving Fungal Giant
.mob Starving Bog Lord
.mob Bog Lord
step
#loop
.line Zangarmarsh,13.76,57.97,10.51,60.28,10.53,62.68,13.24,63.84,17.35,63.48,17.46,57.13,13.76,57.97
.goto Zangarmarsh,13.76,57.97,60,0
.goto Zangarmarsh,10.51,60.28,60,0
.goto Zangarmarsh,10.53,62.68,60,0
.goto Zangarmarsh,13.24,63.84,60,0
.goto Zangarmarsh,17.35,63.48,60,0
.goto Zangarmarsh,17.46,57.13,60,0
.goto Zangarmarsh,13.76,57.97,60,0
>>Collect |cRXP_PICK_Sacs|r (they look like balloons) on the ground
.complete 9739,1 
step
#optional
#completewith Idols
>>Loot |cRXP_PICK_Glowcaps|r on the ground throughout Zangarmarsh
.collect 24245,10,9808,1 
step
#optional
#completewith Ungula
>>Kill |cRXP_ENEMY_Marshfang Slicers|r
.complete 9833,1 
.mob Marshfang Slicer
step
.goto Zangarmarsh,19.03,62.34,50,0
.goto Zangarmarsh,19.19,64.60
.line Zangarmarsh,19.03,62.34,19.19,64.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fahssn|r. He patrols around slightly
.turnin 9739 >> Turn in The Sporelings' Plight
.turnin 9743 >> Turn in Natural Enemies
.target Fahssn
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Greater Sporebats|r and |cRXP_ENEMY_Marsh Walkers|r. Loot them for their |cRXP_LOOT_Fertile Spores|r
.collect 24449,6,9806,1 
.mob *Greater Sporebat
.mob *Marsh Walker
step
#label Lessa2
.goto Zangarmarsh,23.32,66.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Watcher Leesa'oh|r
.turnin 9701 >> Turn in Observing the Sporelings
.accept 9702 >> Accept A Question of Gluttony
.target Watcher Leesa'oh
step
#label Nutriment
#loop
.line Zangarmarsh,26.31,62.73,27.31,66.10,28.34,63.77,29.80,65.23,31.36,67.21,32.31,65.48,33.59,65.76,32.31,65.48,30.89,63.10,31.89,60.49,29.28,59.50,29.10,62.48,26.31,62.73
.goto Zangarmarsh,26.31,62.73,60,0
.goto Zangarmarsh,27.31,66.10,60,0
.goto Zangarmarsh,28.34,63.77,60,0
.goto Zangarmarsh,29.80,65.23,60,0
.goto Zangarmarsh,31.36,67.21,60,0
.goto Zangarmarsh,32.31,65.48,60,0
.goto Zangarmarsh,33.59,65.76,60,0
.goto Zangarmarsh,32.31,65.48,60,0
.goto Zangarmarsh,30.89,63.10,60,0
.goto Zangarmarsh,31.89,60.49,60,0
.goto Zangarmarsh,29.28,59.50,60,0
.goto Zangarmarsh,29.10,62.48,60,0
.goto Zangarmarsh,26.31,62.73,60,0
>>Loot the |cRXP_PICK_Discarded Nutriments|r (small mushrooms) on the ground
.complete 9702,1 
step << !tbc
.goto Zangarmarsh,32.86,59.52
.use 25459 >>Kill |cRXP_ENEMY_"Count" Ungula|r. Loot him for his |cRXP_LOOT_Mandible|r. Click |T135592:0|t["Count" Ungula's Mandible] in your bags
.collect 25459,1,9911 
.accept 9911 >> Accept The Count of the Marshes
.unitscan "Count" Ungula
step << tbc
#loop
.line Zangarmarsh,26.31,62.73,27.31,66.10,28.34,63.77,29.80,65.23,31.36,67.21,32.31,65.48,33.59,65.76,32.31,65.48,30.89,63.10,31.89,60.49,29.28,59.50,29.10,62.48,26.31,62.73
.goto Zangarmarsh,26.31,62.73,60,0
.goto Zangarmarsh,27.31,66.10,60,0
.goto Zangarmarsh,28.34,63.77,60,0
.goto Zangarmarsh,29.80,65.23,60,0
.goto Zangarmarsh,31.36,67.21,60,0
.goto Zangarmarsh,32.31,65.48,60,0
.goto Zangarmarsh,33.59,65.76,60,0
.goto Zangarmarsh,32.31,65.48,60,0
.goto Zangarmarsh,30.89,63.10,60,0
.goto Zangarmarsh,31.89,60.49,60,0
.goto Zangarmarsh,29.28,59.50,60,0
.goto Zangarmarsh,29.10,62.48,60,0
.goto Zangarmarsh,26.31,62.73,60,0
>>Kill |cRXP_ENEMY_Bog Lords|r. Loot them for their |cRXP_LOOT_Tendrils|r
.collect 24291,6 
.reputation 970,neutral,0,1
.mob Starving Fungal Giant
.mob Starving Bog Lord
.mob Bog Lord
step
#loop
.line Zangarmarsh,26.31,62.73,27.31,66.10,28.34,63.77,29.80,65.23,31.36,67.21,32.31,65.48,33.59,65.76,32.31,65.48,30.89,63.10,31.89,60.49,29.28,59.50,29.10,62.48,26.31,62.73
.goto Zangarmarsh,26.31,62.73,60,0
.goto Zangarmarsh,27.31,66.10,60,0
.goto Zangarmarsh,28.34,63.77,60,0
.goto Zangarmarsh,29.80,65.23,60,0
.goto Zangarmarsh,31.36,67.21,60,0
.goto Zangarmarsh,32.31,65.48,60,0
.goto Zangarmarsh,33.59,65.76,60,0
.goto Zangarmarsh,32.31,65.48,60,0
.goto Zangarmarsh,30.89,63.10,60,0
.goto Zangarmarsh,31.89,60.49,60,0
.goto Zangarmarsh,29.28,59.50,60,0
.goto Zangarmarsh,29.10,62.48,60,0
.goto Zangarmarsh,26.31,62.73,60,0
.reputation 970,neutral,0 >> Grind |cRXP_ENEMY_Bog Lords|r until you're |cRXP_WARN_Neutral|r with Sporeggar
.mob Starving Fungal Giant
.mob Starving Bog Lord
.mob Bog Lord
step << !tbc
.goto Zangarmarsh,19.03,62.34,50,0
.goto Zangarmarsh,19.19,64.60
.line Zangarmarsh,19.03,62.34,19.19,64.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fahssn|r. He patrols around slightly
.accept 9919 >> Accept Sporeggar
.mob Starving Fungal Giant
.mob Starving Bog Lord
.mob Bog Lord
step
#questguide << !tbc
.goto Zangarmarsh,23.32,66.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lessa'oh|r
.turnin 9702 >> Turn in A Question of Gluttony
.accept 9708 >> Accept Familiar Fungi
.target Watcher Leesa'oh
step << tbc
#label Ungula
.goto Zangarmarsh,32.86,59.52
.use 25459 >>Kill |cRXP_ENEMY_"Count" Ungula|r. Loot him for his |cRXP_LOOT_Mandible|r. Click |T135592:0|t["Count" Ungula's Mandible] in your bags
.collect 25459,1,9911 
.accept 9911 >> Accept The Count of the Marshes
.unitscan "Count" Ungula
step << !tbc
#label Ungula
.goto Zangarmarsh,23.32,66.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lessa'oh|r
.turnin 9911 >> Turn in The Count of the Marshes
.turnin 9702 >> Turn in A Question of Gluttony
.target Watcher Leesa'oh
step
#optional
#completewith Idols
>>Kill |cRXP_ENEMY_Fen Striders|r and |cRXP_ENEMY_Greater Sporebats|r. Loot them for their |cRXP_LOOT_Fertile Spores|r
.collect 24449,6,9806,1 
.mob *Greater Sporebat
.mob *Fen Strider
.mob *Marsh Walker
.mob *Sporebat
step
#loop
.line Zangarmarsh,32.12,59.16,32.87,60.25,34.12,62.12,35.08,63.37,37.14,62.08,39.08,63.53,38.99,59.32,36.85,56.26,34.96,59.53,33.60,57.06,32.12,59.16
.goto Zangarmarsh,32.12,59.16,50,0
.goto Zangarmarsh,32.87,60.25,50,0
.goto Zangarmarsh,34.12,62.12,50,0
.goto Zangarmarsh,35.08,63.37,50,0
.goto Zangarmarsh,37.14,62.08,50,0
.goto Zangarmarsh,39.08,63.53,50,0
.goto Zangarmarsh,38.99,59.32,50,0
.goto Zangarmarsh,36.85,56.26,50,0
.goto Zangarmarsh,34.96,59.53,50,0
.goto Zangarmarsh,33.60,57.06,50,0
.goto Zangarmarsh,32.12,59.16,50,0
>>Kill |cRXP_ENEMY_Marshfang Slicers|r
.complete 9833,1 
.mob Marshfang Slicer
step
#label Idols
.goto Zangarmarsh,46.09,57.76,20,0
.goto Zangarmarsh,46.17,59.79,20,0
.goto Zangarmarsh,45.93,60.71,20,0
.goto Zangarmarsh,46.25,60.96,20,0
.goto Zangarmarsh,47.46,61.77,20,0
.goto Zangarmarsh,49.09,61.27,20,0
.goto Zangarmarsh,49.24,60.72,20,0
.goto Zangarmarsh,49.70,61.09,20,0
.goto Zangarmarsh,48.19,63.81,20,0
.goto Zangarmarsh,47.90,64.20,20,0
.goto Zangarmarsh,48.59,64.71,20,0
.goto Zangarmarsh,43.24,62.40
>>Loot the small stone |cRXP_PICK_Idols|r on the ground
.complete 9787,1 
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Fen Striders|r and |cRXP_ENEMY_Sporebats|r. Loot them for their |cRXP_LOOT_Fertile Spores|r
.collect 24449,6,9806,1 
.mob *Greater Sporebat
.mob *Fen Strider
.mob *Marsh Walker
.mob *Sporebat
.subzoneskip 3653
step << !Warlock
#completewith next
.cast 22807 >> Use the |T134716:0|t[Potion of Water Breathing] in your bags
.use 25539
step
#loop
.line Zangarmarsh,48.35,45.31,49.52,44.88,50.82,45.18,51.57,44.16,51.35,42.51,52.25,43.34,52.99,42.77,53.30,41.79,52.45,41.36,52.67,39.01,50.99,37.35,50.26,36.26,48.89,38.04,48.07,39.03,48.73,40.09,47.66,40.78,47.74,41.81,49.00,42.23,48.35,45.31
.goto Zangarmarsh,48.35,45.31,50,0
.goto Zangarmarsh,49.52,44.88,50,0
.goto Zangarmarsh,50.82,45.18,50,0
.goto Zangarmarsh,51.57,44.16,50,0
.goto Zangarmarsh,51.35,42.51,50,0
.goto Zangarmarsh,52.25,43.34,50,0
.goto Zangarmarsh,52.99,42.77,50,0
.goto Zangarmarsh,53.30,41.79,50,0
.goto Zangarmarsh,52.45,41.36,50,0
.goto Zangarmarsh,52.67,39.01,50,0
.goto Zangarmarsh,50.99,37.35,50,0
.goto Zangarmarsh,50.26,36.26,50,0
.goto Zangarmarsh,48.89,38.04,50,0
.goto Zangarmarsh,48.07,39.03,50,0
.goto Zangarmarsh,48.73,40.09,50,0
.goto Zangarmarsh,47.66,40.78,50,0
.goto Zangarmarsh,47.74,41.81,50,0
.goto Zangarmarsh,49.00,42.23,50,0
.goto Zangarmarsh,48.35,45.31,50,0
>>Kill |cRXP_ENEMY_Fenclaw Thrashers|r underwater. Loot them for their |cRXP_LOOT_Hides|r
.complete 9834,1 
.mob Fenclaw Thrasher
step << Shaman
#completewith next
.hs >> Hearth to Orebor Harborage
step
#optional
#completewith Orebor1
>>Kill |cRXP_ENEMY_Greater Sporebats|r. Loot them for their |cRXP_LOOT_Fertile Spores|r
.collect 24449,6,9806,1 
.mob *Greater Sporebat
.mob *Marsh Walker
step
#optional
#completewith FSpores
>>Loot |cRXP_PICK_Glowcaps|r on the ground throughout Zangarmarsh
.collect 24245,10,9808,1 
step
.goto 1946/530,7383.70020,1020.29999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maktu|r
.target Maktu
.turnin 9834 >>Turn in Natural Armor
.accept 9905 >>Accept Maktu's Revenge
step
.goto 1946/530,7422.10010,974.29999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Puluu|r
.target Puluu
.turnin 9833 >>Turn in Lines of Communication
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Bogflare Needlers|r. Loot them for their |cRXP_LOOT_Wings|r
.complete 9790,1 
.mob Bogflare Needler
step
.goto Zangarmarsh,42.24,41.40
>>Kill |cRXP_ENEMY_Mragesh|r
.complete 9905,1 
.unitscan Mragesh
step
#questguide << !tbc
#loop
.line Zangarmarsh,28.90,27.88,29.29,26.89,30.66,26.89,32.03,27.30,33.20,28.97,35.19,26.85,37.09,26.88,38.88,28.22,37.80,28.63,36.08,29.61,36.41,32.55,36.40,33.65,35.11,34.53,34.27,33.37,34.45,31.45,33.94,30.16,32.44,32.76,31.67,30.44,29.97,30.13,28.90,27.88
.goto Zangarmarsh,28.90,27.88,50,0
.goto Zangarmarsh,29.29,26.89,50,0
.goto Zangarmarsh,30.66,26.89,50,0
.goto Zangarmarsh,32.03,27.30,50,0
.goto Zangarmarsh,33.20,28.97,50,0
.goto Zangarmarsh,35.19,26.85,50,0
.goto Zangarmarsh,37.09,26.88,50,0
.goto Zangarmarsh,38.88,28.22,50,0
.goto Zangarmarsh,37.80,28.63,50,0
.goto Zangarmarsh,36.08,29.61,50,0
.goto Zangarmarsh,36.41,32.55,50,0
.goto Zangarmarsh,36.40,33.65,50,0
.goto Zangarmarsh,35.11,34.53,50,0
.goto Zangarmarsh,34.27,33.37,50,0
.goto Zangarmarsh,34.45,31.45,50,0
.goto Zangarmarsh,33.94,30.16,50,0
.goto Zangarmarsh,32.44,32.76,50,0
.goto Zangarmarsh,31.67,30.44,50,0
.goto Zangarmarsh,29.97,30.13,50,0
.goto Zangarmarsh,28.90,27.88,50,0
>>Kill |cRXP_ENEMY_Ango'rosh Ogres|r, |cRXP_ENEMY_Ango'rosh Sentries|r and |cRXP_ENEMY_Ango'rosh Shamans|r. Loot them for their |cRXP_LOOT_Mushrooms|r
.complete 9708,1 
.mob Ango'rosh Ogre
.mob Ango'rosh Sentry
.mob Ango'rosh Shaman
.mob Boss Grog'ak
step
#optional
#completewith MarshControls
>>Kill |cRXP_ENEMY_Marshlight Bleeders|r. Loot them for their |cRXP_LOOT_Venom|r and |cRXP_LOOT_Wings|r
.complete 9830,1 
.complete 9790,1 
.mob Marshlight Bleeder
step
#questguide << !tbc
.goto Zangarmarsh,23.32,66.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lessa'oh|r
.turnin 9708 >> Turn in Familiar Fungi
.accept 9709 >> Accept Stealing Back the Mushrooms
.turnin 9911 >> Turn in The Count of the Marshes
.target Watcher Leesa'oh
step
#label Orebor1
step << tbc
#optional
#completewith next
>>Kill |cRXP_ENEMY_Greater Sporebats|r and |cRXP_ENEMY_Marsh Walkers|r. Loot them for their |cRXP_LOOT_Fertile Spores|r
.collect 24449,6,9806,1 
.mob Greater Sporebat
.mob Marsh Walker
step << tbc
#label Sporeggar
.goto Zangarmarsh,19.03,62.34,60,0
.goto Zangarmarsh,19.19,64.60
.line Zangarmarsh,19.03,62.34,19.19,64.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fahssn|r. He patrols around slightly
.accept 9919 >> Accept Sporeggar
.turnin 9744 >> Turn in More Tendrils!
.target Fahssn
step
#label FSpores
#loop
.line Zangarmarsh,20.87,66.51,21.59,60.30,22.02,58.36,20.27,57.74,18.36,55.46,21.05,52.64,25.47,57.26,20.87,66.51
.goto Zangarmarsh,20.87,66.51,50,0
.goto Zangarmarsh,21.59,60.30,50,0
.goto Zangarmarsh,22.02,58.36,50,0
.goto Zangarmarsh,20.27,57.74,50,0
.goto Zangarmarsh,18.36,55.46,50,0
.goto Zangarmarsh,21.05,52.64,50,0
.goto Zangarmarsh,25.47,57.26,50,0
.goto Zangarmarsh,20.87,66.51,50,0
>>Kill |cRXP_ENEMY_Greater Sporebats|r and |cRXP_ENEMY_Marsh Walkers|r. Loot them for their |cRXP_LOOT_Fertile Spores|r
.collect 24449,6,9806,1 
.mob Greater Sporebat
.mob Marsh Walker
step
#loop
.line Zangarmarsh,19.40,64.97,22.18,63.38,32.63,54.20,27.28,52.55,27.74,47.76,21.27,54.58,19.70,51.18,19.40,64.97
.goto Zangarmarsh,19.40,64.97,50,0
.goto Zangarmarsh,22.18,63.38,50,0
.goto Zangarmarsh,32.63,54.20,50,0
.goto Zangarmarsh,27.28,52.55,50,0
.goto Zangarmarsh,27.74,47.76,50,0
.goto Zangarmarsh,21.27,54.58,50,0
.goto Zangarmarsh,19.70,51.18,50,0
.goto Zangarmarsh,19.40,64.97,50,0
>>Loot |cRXP_PICK_Glowcaps|r on the ground throughout Zangarmarsh
.collect 24245,10,9808,1 
step
.goto 1946/530,8487.50000,191.90001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Msshi'fn|r
.target Msshi'fn
.turnin 9919 >>Turn in Sporeggar
.accept 9808 >>Accept Glowcap Mushrooms
.turnin 9808 >>Turn in Glowcap Mushrooms
step
.goto 1946/530,8511.79980,278.50000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gshaff|r
.target Gshaff
.accept 9806 >>Accept Fertile Spores
.turnin 9806 >>Turn in Fertile Spores
step
#questguide << !tbc
.goto Zangarmarsh,15.58,60.02
.reputation 970,friendly >> Grind |cRXP_ENEMY_Bog Lords|r until you're at |cRXP_FRIENDLY_Friendly|r Reputation
.mob Starving Fungal Giant
.mob Starving Bog Lord
.mob Bog Lord
step
#questguide << !tbc
>>Talk to |cRXP_FRIENDLY_Gzhun'tt|r
.accept 9726 >> Accept Now That We're Friends...
.goto Zangarmarsh,19.54,50.04
.target Gzhun'tt
step
.goto Zangarmarsh,22.34,45.89
>>Kill |cRXP_ENEMY_Terroclaw|r on the island
.complete 9902,1 
.unitscan Terrorclaw
step
#optional
#completewith Bloodscale
>>Kill |cRXP_ENEMY_Bloodscale Slavedrivers|r and |cRXP_ENEMY_Bloodscale Enchantresses|r. Loot them for their |cRXP_LOOT_Claws|r
.complete 9728,1 
.mob Bloodscale Enchantress
.mob Bloodscale Slavedriver
step
#questguide << !tbc
#optional
#completewith next
>>Kill |cRXP_ENEMY_Bloodscale Slavedrivers|r and |cRXP_ENEMY_Bloodscale Enchantresses|r
.complete 9726,1 
.mob +Bloodscale Slavedriver
.complete 9726,2 
.mob +Bloodscale Enchantress
.isOnQuest 9726
step
#label MarshControls
.goto Zangarmarsh,25.41,42.86
.use 24355 >>|cRXP_WARN_Use the|r |T136074:0|t[Ironvine Seeds] |cRXP_WARN_on the Lake Controls|r
.complete 9720,2 
step
#questguide << !tbc
#loop
.line Zangarmarsh,24.93,41.85,26.13,40.93,25.79,39.22,24.82,38.46,24.94,36.37,26.38,35.80,28.29,36.89,29.06,38.57,28.49,40.87,28.02,41.90,29.07,44.08,27.72,44.48,26.80,43.70,26.68,46.24,25.85,47.27,25.18,43.82,24.93,41.85
.goto Zangarmarsh,24.93,41.85,50,0
.goto Zangarmarsh,26.13,40.93,50,0
.goto Zangarmarsh,25.79,39.22,50,0
.goto Zangarmarsh,24.82,38.46,50,0
.goto Zangarmarsh,24.94,36.37,50,0
.goto Zangarmarsh,26.38,35.80,50,0
.goto Zangarmarsh,28.29,36.89,50,0
.goto Zangarmarsh,29.06,38.57,50,0
.goto Zangarmarsh,28.49,40.87,50,0
.goto Zangarmarsh,28.02,41.90,50,0
.goto Zangarmarsh,29.07,44.08,50,0
.goto Zangarmarsh,27.72,44.48,50,0
.goto Zangarmarsh,26.80,43.70,50,0
.goto Zangarmarsh,26.68,46.24,50,0
.goto Zangarmarsh,25.85,47.27,50,0
.goto Zangarmarsh,25.18,43.82,50,0
.goto Zangarmarsh,24.93,41.85,50,0
>>Kill |cRXP_ENEMY_Bloodscale Slavedrivers|r and |cRXP_ENEMY_Bloodscale Enchantresses|r
.complete 9726,1 
.mob +Bloodscale Slavedriver
.complete 9726,2 
.mob +Bloodscale Enchantress
.isOnQuest 9726
step
#label Bloodscale
step
#optional
#completewith Gorefist
.goto Zangarmarsh,27.73,32.32,60,0
.goto Zangarmarsh,25.87,33.28,60,0
.goto Zangarmarsh,25.71,31.64,60,0
.goto Zangarmarsh,24.78,29.79,60,0
.goto Zangarmarsh,24.27,31.62,60,0
.goto Zangarmarsh,22.83,31.15,60,0
.goto Zangarmarsh,21.23,32.21,60,0
.goto Zangarmarsh,20.51,31.27,60,0
.goto Zangarmarsh,18.84,35.49,60,0
>>Kill |cRXP_ENEMY_Marshlight Bleeders|r. Loot them for their |cRXP_LOOT_Venom|r and |cRXP_LOOT_Wings|r
.complete 9830,1 
.complete 9790,1 
.mob Marshlight Bleeder
.subzoneskip 3651
step
#completewith Gorefist
.goto Zangarmarsh,17.08,13.10,40 >> Cross the Mushroom bridge
.skill riding,225,1
step
#sticky
#label Gorefist
.goto Zangarmarsh,18.40,7.79
>>Kill |cRXP_ENEMY_Gorefist|r inside the building
.complete 9839,1 
.unitscan Overlord Gorefist
step
#questguide << !tbc
#loop
.goto Zangarmarsh,16.64,7.63,50,0
.goto Zangarmarsh,17.13,4.07,50,0
.goto Zangarmarsh,19.14,4.08,50,0
.goto Zangarmarsh,21.02,4.08,50,0
.goto Zangarmarsh,20.93,8.05,50,0
.goto Zangarmarsh,17.28,9.84,50,0
.goto Zangarmarsh,19.93,6.70,50,0
.goto Zangarmarsh,19.14,4.08,50,0
.goto Zangarmarsh,16.64,7.63,50,0
.goto Zangarmarsh,17.13,4.07,50,0
.goto Zangarmarsh,19.14,4.08,50,0
.goto Zangarmarsh,21.02,4.08,50,0
.goto Zangarmarsh,20.93,8.05,50,0
.goto Zangarmarsh,17.28,9.84,50,0
.goto Zangarmarsh,19.93,6.70,50,0
.goto Zangarmarsh,19.14,4.08,0
>>Kill |cRXP_ENEMY_Ango'rosh Maulers|r. Loot them for their |cRXP_LOOT_Boxes of Mushrooms|r
>>You can also loot |cRXP_LOOT_Boxes of Mushrooms|r on the ground
.complete 9839,2 
.disablecheckbox
.complete 9709,1 
.mob Ango'rosh Mauler
step
#loop
.goto Zangarmarsh,16.64,7.63,50,0
.goto Zangarmarsh,17.13,4.07,50,0
.goto Zangarmarsh,19.14,4.08,50,0
.goto Zangarmarsh,21.02,4.08,50,0
.goto Zangarmarsh,20.93,8.05,50,0
.goto Zangarmarsh,17.28,9.84,50,0
.goto Zangarmarsh,19.93,6.70,50,0
.goto Zangarmarsh,19.14,4.08,50,0
.goto Zangarmarsh,16.64,7.63,50,0
.goto Zangarmarsh,17.13,4.07,50,0
.goto Zangarmarsh,19.14,4.08,50,0
.goto Zangarmarsh,21.02,4.08,50,0
.goto Zangarmarsh,20.93,8.05,50,0
.goto Zangarmarsh,17.28,9.84,50,0
.goto Zangarmarsh,19.93,6.70,50,0
.goto Zangarmarsh,19.14,4.08,0
>>Finish off |cRXP_ENEMY_Ango'rosh Maulers|r
.complete 9839,2 
.mob Ango'rosh Mauler
step
#requires Gorefist
.goto Zangarmarsh,27.73,32.32,60,0
.goto Zangarmarsh,25.87,33.28,60,0
.goto Zangarmarsh,25.71,31.64,60,0
.goto Zangarmarsh,24.78,29.79,60,0
.goto Zangarmarsh,24.27,31.62,60,0
.goto Zangarmarsh,22.83,31.15,60,0
.goto Zangarmarsh,21.23,32.21,60,0
.goto Zangarmarsh,20.51,31.27,60,0
.goto Zangarmarsh,18.84,35.49,60,0
.goto Zangarmarsh,16.37,37.32,60,0
.goto Zangarmarsh,15.49,40.37,60,0
.goto Zangarmarsh,15.15,45.80,60,0
.goto Zangarmarsh,16.70,45.10,60,0
.goto Zangarmarsh,19.25,46.80
>>Kill |cRXP_ENEMY_Marshlight Bleeders|r and |cRXP_ENEMY_Fenglow Stingers|r. Loot them for their |cRXP_LOOT_Venom|r and |cRXP_LOOT_Wings|r
.complete 9830,1 
.complete 9790,1 
.mob Marshlight Bleeder
.mob Fenglow Stinger
step
#questguide << !tbc
.goto Zangarmarsh,19.54,50.04
>>Return to Sporeggar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gzhun'tt|r
.turnin 9726 >> Turn in Now That We're Friends...
.target Gzhun'tt
step
#questguide << !tbc
.goto Zangarmarsh,23.32,66.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lessa'oh|r
.turnin 9709 >> Turn in Stealing Back the Mushrooms
.target Watcher Leesa'oh
step
#xprate <1.5 << !Shaman
#completewith next
.hs >> Hearth to Orebor Harborage
step
.goto 1946/530,7364.00000,1023.79999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ikuti|r
.target Ikuti
.turnin 9839 >>Turn in Overlord Gorefist
step
.goto 1946/530,7383.10010,1019.50000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maktu|r
.target Maktu
.turnin 9905 >>Turn in Maktu's Revenge
step
.goto 1946/530,7419.39990,976.70001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Puluu|r
.target Puluu
.turnin 9830 >>Turn in Stinger Venom
.turnin 9902 >>Turn in The Terror of Marshlight Lake
step
#completewith next
.goto Zangarmarsh,41.28,29.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halu|r
.fly Telredor >> Fly to Telredor
.target Halu
step
#questguide << !tbc
>>Return to Telredor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Ahuurn|r and |cRXP_FRIENDLY_Haalrun|r
.turnin 9787 >> Turn in Idols of the Feralfen
.goto Zangarmarsh,68.20,49.37
.accept 9801 >>Accept Gathering the Reagents
.turnin 9790 >> Turn in Diaphanous Wings
.goto Zangarmarsh,68.81,48.91
.target Anchorite Ahuurn
.target Haalrun
step
#sticky
#label idols1
.goto 1946/530,6045.39990,279.89999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Ahuurn|r
.target Anchorite Ahuurn
.turnin 9787 >>Turn in Idols of the Feralfen
step
#questguide << !tbc
.goto 1946/530,6045.39990,279.89999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Ahuurn|r
.target Anchorite Ahuurn
.accept 9801 >>Accept Gathering the Reagents
step
#requires idols1
.goto 1946/530,6066.80029,328.60001
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Haalrun|r
.target Haalrun
.turnin 9790 >>Turn in Diaphanous Wings
step
#questguide << !tbc
#completewith NagaC
>>Kill |cRXP_ENEMY_Fen Striders|r. Loot them for their |cRXP_LOOT_Tentacles|r
>>Kill |cRXP_ENEMY_Sporebats|r. Loot them for their |cRXP_LOOT_Eyes|r
.complete 9801,2 
.mob +Fen Strider
.complete 9801,1 
.mob +Young Sporebat
.mob +Greater Sporebat
.mob +Sporebat
step
#optional
#completewith Rajis
>>Kill |cRXP_ENEMY_Bloodscale Overseers|r and |cRXP_ENEMY_Bloodscale Wavecallers|r. Loot them for their |cRXP_LOOT_Claws|r
.complete 9728,1 
.mob Bloodscale Overseer
.mob Bloodscale Wavecaller
step
.goto Zangarmarsh,61.97,40.84
.use 24355 >>|cRXP_WARN_Use the|r |T136074:0|t[Ironvine Seeds] |cRXP_WARN_on the Lake Controls|r
.complete 9720,3 
step
#label Rajis
.goto Zangarmarsh,65.15,40.91
>>Kill |cRXP_ENEMY_Rajis Fyashe|r
>>|cRXP_WARN_Find a group for her if needed. Skip this step if you're unable to find a group or solo her|r << tbc/wotlk
>>|cRXP_WARN_Try to Line of Sight her spells. Run away from the|r |T135833:0|t[Freezing Circle] |cRXP_WARN_she casts|r << tbc/wotlk
.complete 9817,1 
.isOnQuest 9817
.mob Rajis Fyashe
step
#label NagaC
#loop
.line Zangarmarsh,62.09,38.27,63.29,37.85,64.54,40.10,65.71,39.87,66.39,41.25,63.82,43.15,63.34,44.22,63.15,41.53,61.93,40.26,62.09,38.27
.goto Zangarmarsh,62.09,38.27,55,0
.goto Zangarmarsh,63.29,37.85,55,0
.goto Zangarmarsh,64.54,40.10,55,0
.goto Zangarmarsh,65.71,39.87,55,0
.goto Zangarmarsh,66.39,41.25,55,0
.goto Zangarmarsh,63.82,43.15,55,0
.goto Zangarmarsh,63.34,44.22,55,0
.goto Zangarmarsh,63.15,41.53,55,0
.goto Zangarmarsh,61.93,40.26,55,0
.goto Zangarmarsh,62.09,38.27,55,0
>>Kill |cRXP_ENEMY_Bloodscale Overseers|r and |cRXP_ENEMY_Bloodscale Wavecallers|r. Loot them for their |cRXP_LOOT_Claws|r
.complete 9728,1 
.mob Bloodscale Overseer
.mob Bloodscale Wavecaller
step
#questguide << !tbc
#completewith next
.goto Zangarmarsh,68.48,43.46,60,0
.goto Zangarmarsh,72.01,43.27,60,0
.goto Zangarmarsh,74.14,40.66,60,0
.goto Zangarmarsh,74.75,41.17,60,0
.goto Zangarmarsh,74.61,46.52,60,0
.goto Zangarmarsh,75.22,48.26,60,0
.goto Zangarmarsh,73.70,48.35,60,0
.goto Zangarmarsh,73.50,50.21,60,0
.goto Zangarmarsh,76.75,55.29,60,0
.goto Zangarmarsh,73.96,56.23,60,0
.goto Zangarmarsh,71.85,55.12,60,0
.goto Zangarmarsh,68.41,57.39,60,0
.goto Zangarmarsh,69.72,59.22,60,0
>>Kill |cRXP_ENEMY_Sporebats|r. Loot them for their |cRXP_LOOT_Eyes|r
>>Kill |cRXP_ENEMY_Fen Striders|r. Loot them for their |cRXP_LOOT_Tentacles|r
.complete 9801,1 
.mob +Young Sporebat
.mob +Greater Sporebat
.mob +Sporebat
.complete 9801,2 
.unitscan +Fen Strider
step
.goto Zangarmarsh,78.40,62.02
>>Return to the Cenarion Refuge
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ysiel Windsinger|r
.turnin 9720 >> Turn in Balance Must Be Preserved
.turnin 9732 >> Turn in Return to the Marsh
.target Ysiel Windsinger
step
.goto Zangarmarsh,79.09,65.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Warden Hamoot|r upstairs in the tower
.turnin 9728 >> Turn in A Warm Welcome
.turnin 9817 >> Turn in Leader of the Bloodscale
.isQuestComplete 9817
.target Warden Hamoot
step
#optional
.goto Zangarmarsh,79.09,65.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Warden Hamoot|r upstairs in the tower
.turnin 9728 >> Turn in A Warm Welcome
.target Warden Hamoot
step
#questguide << !tbc
.goto Zangarmarsh,80.66,69.19,60,0
.goto Zangarmarsh,81.79,72.99,60,0
.goto Zangarmarsh,78.58,82.28,60,0
.goto Zangarmarsh,76.14,84.24,60,0
.goto Zangarmarsh,73.71,87.66,60,0
.goto Zangarmarsh,79.51,87.69,60,0
.goto Zangarmarsh,80.66,69.19,60,0
.goto Zangarmarsh,81.79,72.99,60,0
.goto Zangarmarsh,78.58,82.28,60,0
.goto Zangarmarsh,76.14,84.24,60,0
.goto Zangarmarsh,73.71,87.66,60,0
.goto Zangarmarsh,79.51,87.69
>>Kill |cRXP_ENEMY_Sporebats|r. Loot them for their |cRXP_LOOT_Eyes|r
>>Kill |cRXP_ENEMY_Fen Striders|r. Loot them for their |cRXP_LOOT_Tentacles|r
.complete 9801,1 
.mob +Young Sporebat
.mob +Greater Sporebat
.mob +Sporebat
.complete 9801,2 
.unitscan +Fen Strider
step << !tbc !wotlk
.goto 1955/530,5362.10010,-1832.90002
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Haggard War Veteran|r
.target Haggard War Veteran
.accept 10210 >>Accept A'dal
step << !tbc !wotlk
.goto 1955/530,5426.70020,-1862.70007
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_A'dal|r
.target A'dal
.turnin 10210 >>Turn in A'dal
step << !tbc !wotlk
.goto 1955/530,5421.80029,-1859.00000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Khadgar's Servant|r
.target Khadgar
.accept 10211 >>Accept City of Light
.timer 462,City of Light RP
step << !tbc !wotlk
.goto Shattrath City,50.36,42.87
>>Follow |cRXP_FRIENDLY_Khadgar's Servant|r << wotlk
>>Head up to the second floor with |cRXP_FRIENDLY_G'eras|r and wait out the RP. If someone elses |cRXP_FRIENDLY_Khadgar's Servant|r arrives in the meantime, you can target it and it will complete the quest for you. If the quest fails, abandon it, accept the quest from |cRXP_FRIENDLY_Khadgar's Servant|r again, then follow the |cRXP_FRIENDLY_Khadgar's Servant|r around << tbc
.complete 10211,1 
.target Khadgar's Servant
step << Mage !tbc !wotlk
.goto Shattrath City,58.77,47.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Iorioa|r
.train 35715 >> Train Teleport: Shattrath and Portal: Shattrath
.target Iorioa
step << !tbc !wotlk
.goto Shattrath City,54.74,44.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Khadgar's Servant|r
.turnin 10211 >> Turn in City of Light
.target Khadgar
step << !tbc !wotlk
.goto Shattrath City,54.74,44.32
.accept 10551 >>Allegiance to the Aldor
.turnin 10551>>Talk to |cRXP_FRIENDLY_Khadgar|r. Pledge your Allegiance to the Aldor
.target Khadgar
step << !tbc !wotlk
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Khadgar's Servant|r
.goto Shattrath City,54.74,44.32
.accept 10554 >> Accept Ishanah
.target Khadgar
step << !tbc !wotlk
#xprate >1.499
.goto 1955/530,5821.60010,-1732.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ishanah|r
.target Ishanah
.turnin 10554 >>Turn in Ishanah
step
#xprate >1.499
.hs >> Hearth to Orebor Harborage
.cooldown item,6948,>0
step << !tbc !wotlk
.goto Shattrath City,64.05,41.12
>>Travel to Shattrath City
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nutral|r
.fly Orebor >> Fly to Orebor Harborage
.target Nutral
.subzoneskip 3766
.zoneskip Blade's Edge Mountains
]])
RXPGuides.RegisterGuide([[
#version 5
#cata
#Cata
#group RXP Cataclysm 60-80 (A)
<< Alliance
#questguide << !tbc
#name 63-65 Terokkar Forest
#version 5
#next 64-66 Nagrand
#xprate <1.5

step
>>Travel to Shattrath
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Seth|r
.accept 10037 >> Accept Rather Be Fishin'
.goto Shattrath City,63.94,15.52
.target Seth
step
.goto Terokkar Forest,36.78,3.77
.zone Terokkar Forest >> Travel to Terokkar Forest
step
#questguide << !tbc
#aldor
#completewith Eel
>>Kill |cRXP_ENEMY_Dampscale Basilisks|r. Loot them for their |cRXP_LOOT_Eyes|r
.collect 25744,8,10024,1 
.mob Dampscale Basilisk
step << !Warlock
#completewith next
.cast 22807 >> Use the |T134716:0|t[Potion of Water Breathing] in your bags
.use 25539 
.itemcount 25539,1
step
#loop
.line Terokkar Forest,42.34,14.24,42.55,12.57,41.08,11.55,40.00,8.53,38.23,5.40,38.37,3.86,36.64,3.64,37.91,6.36,38.19,9.34,39.72,13.61,42.34,14.24
.goto Terokkar Forest,42.34,14.24,60,0
.goto Terokkar Forest,42.55,12.57,60,0
.goto Terokkar Forest,41.08,11.55,60,0
.goto Terokkar Forest,40.00,8.53,60,0
.goto Terokkar Forest,38.23,5.40,60,0
.goto Terokkar Forest,38.37,3.86,60,0
.goto Terokkar Forest,36.64,3.64,60,0
.goto Terokkar Forest,37.91,6.36,60,0
.goto Terokkar Forest,38.19,9.34,60,0
.goto Terokkar Forest,39.72,13.61,60,0
.goto Terokkar Forest,42.34,14.24,60,0
>>Kill |cRXP_ENEMY_Shimmerscale Eels|r. Loot the |cRXP_LOOT_Pristine Eels|r
.complete 10037,1 
.mob Shimmerscale Eel
step
#label Eel
.goto Terokkar Forest,44.33,26.31
>>Travel to the Cenarion Thicket
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthbinder Tavgren|r
.turnin -9957 >> Turn in What's Wrong at Cenarion Thicket?
.accept 9971 >> Accept Clues in the Thicket
.accept 9968 >> Accept Strange Energy
.target Earthbinder Tavgren
step
#optional
#completewith WatchingYou
.goto Terokkar Forest,45.12,21.78,0
>>Loot the |cRXP_PICK_Strange Object|r on the ground
.complete 9971,1 
step
#optional
#completewith Object
>>Kill |cRXP_ENEMY_Vicious Teremoths|r. Loot them for their |cRXP_LOOT_Samples|r
.complete 9968,2 
.mob Vicious Teromoth
step
#loop
.line Terokkar Forest,44.47,25.69,44.42,24.76,44.31,23.50,44.40,22.97,44.21,22.01,44.53,21.81,45.17,21.89,45.01,22.80,45.43,21.58,45.17,20.81,44.87,21.14,44.36,21.82,43.69,23.11,43.28,23.03,43.44,22.36
.goto Terokkar Forest,44.47,25.69,30,0
.goto Terokkar Forest,44.42,24.76,30,0
.goto Terokkar Forest,44.31,23.50,30,0
.goto Terokkar Forest,44.40,22.97,30,0
.goto Terokkar Forest,44.21,22.01,30,0
.goto Terokkar Forest,44.53,21.81,30,0
.goto Terokkar Forest,45.17,21.89,30,0
.goto Terokkar Forest,45.01,22.80,30,0
.goto Terokkar Forest,45.43,21.58,30,0
.goto Terokkar Forest,45.17,20.81,30,0
.goto Terokkar Forest,44.87,21.14,30,0
.goto Terokkar Forest,44.36,21.82,30,0
.goto Terokkar Forest,43.69,23.11,30,0
.goto Terokkar Forest,43.28,23.03,30,0
.goto Terokkar Forest,43.44,22.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Warden Treelos|r. He patrols the Cenarion Thicket
.accept 9951 >> Accept It's Watching You!
.unitscan Warden Treelos
step
.groundgoto Terokkar Forest,43.46,22.31,20,0
.goto Terokkar Forest,43.40,22.10
>>Kill |cRXP_ENEMY_Naphthal'ar|r atop the tower
.complete 9951,1 
.mob Naphthal'ar
step
#label WatchingYou
#loop
.line Terokkar Forest,44.47,25.69,44.42,24.76,44.31,23.50,44.40,22.97,44.21,22.01,44.53,21.81,45.17,21.89,45.01,22.80,45.43,21.58,45.17,20.81,44.87,21.14,44.36,21.82,43.69,23.11,43.28,23.03,43.44,22.36
.goto Terokkar Forest,44.47,25.69,30,0
.goto Terokkar Forest,44.42,24.76,30,0
.goto Terokkar Forest,44.31,23.50,30,0
.goto Terokkar Forest,44.40,22.97,30,0
.goto Terokkar Forest,44.21,22.01,30,0
.goto Terokkar Forest,44.53,21.81,30,0
.goto Terokkar Forest,45.17,21.89,30,0
.goto Terokkar Forest,45.01,22.80,30,0
.goto Terokkar Forest,45.43,21.58,30,0
.goto Terokkar Forest,45.17,20.81,30,0
.goto Terokkar Forest,44.87,21.14,30,0
.goto Terokkar Forest,44.36,21.82,30,0
.goto Terokkar Forest,43.69,23.11,30,0
.goto Terokkar Forest,43.28,23.03,30,0
.goto Terokkar Forest,43.44,22.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Warden Treelos|r. He patrols the Cenarion Thicket
.turnin 9951 >> Turn in It's Watching You!
.unitscan Warden Treelos
step
#label Object
.goto Terokkar Forest,45.12,21.78
>>Loot the |cRXP_PICK_Strange Object|r on the ground
.complete 9971,1 
step
#loop
.line Terokkar Forest,44.29,20.34,46.11,20.95,46.39,24.38,43.77,25.38,44.40,22.84,41.81,22.69,44.29,20.34
.goto Terokkar Forest,44.29,20.34,50,0
.goto Terokkar Forest,46.11,20.95,50,0
.goto Terokkar Forest,46.39,24.38,50,0
.goto Terokkar Forest,43.77,25.38,50,0
.goto Terokkar Forest,44.40,22.84,50,0
.goto Terokkar Forest,41.81,22.69,50,0
.goto Terokkar Forest,44.29,20.34,50,0
>>Kill |cRXP_ENEMY_Vicious Teremoths|r. Loot them for their |cRXP_LOOT_Samples|r
.complete 9968,2 
.mob Vicious Teromoth
step
.goto Terokkar Forest,41.85,28.77,50,0
.goto Terokkar Forest,43.77,30.34,50,0
.goto Terokkar Forest,44.07,27.41,50,0
.goto Terokkar Forest,47.16,28.09,50,0
.goto Terokkar Forest,45.81,31.81
>>Kill |cRXP_WARN_neutral|r |cRXP_ENEMY_Teremoths|r. Loot them for their |cRXP_LOOT_Samples|r
.complete 9968,1 
.mob Teromoth
step
.goto Terokkar Forest,44.33,26.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthbinder Tavgren|r
.turnin 9971 >> Turn in Clues in the Thicket
.turnin 9968 >> Turn in Strange Energy
.accept 9978 >> Accept By Any Means Necessary
.target Earthbinder Tavgren
step
#loop
.line Terokkar Forest,37.58,25.83,38.33,26.72,39.17,26.57,40.53,25.45,39.96,24.43,39.11,24.04,39.96,24.43,40.53,25.45,41.44,25.95,42.30,26.62,43.07,26.59,43.92,26.05,45.40,26.56,46.39,26.22,47.18,27.10,48.20,27.25,48.98,27.96,49.66,28.21,50.48,29.26,51.14,29.30
.goto Terokkar Forest,37.58,25.83,50,0
.goto Terokkar Forest,38.33,26.72,50,0
.goto Terokkar Forest,39.17,26.57,50,0
.goto Terokkar Forest,40.53,25.45,50,0
.goto Terokkar Forest,39.96,24.43,50,0
.goto Terokkar Forest,39.11,24.04,50,0
.goto Terokkar Forest,39.96,24.43,50,0
.goto Terokkar Forest,40.53,25.45,50,0
.goto Terokkar Forest,41.44,25.95,50,0
.goto Terokkar Forest,42.30,26.62,50,0
.goto Terokkar Forest,43.07,26.59,50,0
.goto Terokkar Forest,43.92,26.05,50,0
.goto Terokkar Forest,45.40,26.56,50,0
.goto Terokkar Forest,46.39,26.22,50,0
.goto Terokkar Forest,47.18,27.10,50,0
.goto Terokkar Forest,48.20,27.25,50,0
.goto Terokkar Forest,48.98,27.96,50,0
.goto Terokkar Forest,49.66,28.21,50,0
.goto Terokkar Forest,50.48,29.26,50,0
.goto Terokkar Forest,51.14,29.30,50,0
>>Follow the road between Shattrath and Tuurem until you find |cRXP_ENEMY_Empoor|r. Talk to him and then defeat him
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Empoor|r again after
.turnin 9978 >> Turn in By Any Means Necessary
.accept 9979 >> Accept Wind Trader Lathrai
.unitscan Empoor
.skipgossip
step
#sticky
.abandon 10847 >> Abandon The Eyes of Skettis
>>Having this quest will prevent you from accepting an important quest later
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Biribi|r
.target Innkeeper Biribi
.goto 1952/530,4020.19995,-2921.10010
.home >>Set your Hearthstone to Allerian Stronghold
step
.goto 1952/530,3962.40015,-2952.19995
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thander|r
.target Thander
.accept 9986 >>Accept Stymying the Arakkoa
step
>>Click the |cRXP_FRIENDLY_Wanted Poster|r
.goto 1952/530,3971.90015,-2968.10010
.accept 10033 >>Accept Wanted: Bonelashers Dead!
step
.goto 1952/530,3982.69995,-2995.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ros'eleth|r
.target Ros'eleth
.accept 9992 >>Accept Olemba Seeds
step
.goto 1952/530,3978.69995,-3007.90015
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Gravelhammer|r
.target Lieutenant Gravelhammer
.accept 10038 >>Accept Speak with Private Weeks
.accept 10869 >>Accept Thin the Flock
step
.goto 1952/530,3963.50000,-3015.60010
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lady Dena Kennedy|r
.target Lady Dena Kennedy
.accept 10863 >>Accept Secrets of the Arakkoa
step
.goto 1952/530,3935.60010,-2971.50000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bertelm|r
.target Bertelm
.accept 9998 >>Accept Unruly Neighbors
step
#questguide << !tbc
.goto 1952/530,3936.30005,-2971.60010
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bertelm|r
.target Bertelm
.accept 10016 >>Accept Timber Worg Tails
step
.goto 1952/530,3923.90015,-2928.69995
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Andarl|r
.target Andarl
.turnin -9793 >>Turn in The Fate of Tuurem
.accept 10026 >>Accept Magical Disturbances
step << Mage
.goto Terokkar Forest,59.44,55.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Furnan Skysoar|r
.fp Allerian Stronghold >> Get the Allerian Stronghold flight path
.target Furnan Skysoar
step << !Mage
#completewith next
.goto Terokkar Forest,59.44,55.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Furnan Skysoar|r
.fly Shattrath >> Fly to Shattrath City
.target Furnan Skysoar
step << Mage
#completewith next
.zone Shattrath City >> Teleport to Shattrath
step
#aldor
#completewith next
.goto Shattrath City,41.73,38.60,30 >> Take the Elevator up to Aldor Rise
.skill riding,225,1
step
#aldor
#label Lathrai1
.goto 1955/530,5821.60010,-1732.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ishanah|r
.target Ishanah
.accept 10021 >>Accept Restoring the Light
.turnin 10554 >>Turn in Ishanah
step
.goto 1955/530,5444.4,-1657.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rilak the Redeemed|r
.target Rilak the Redeemed
.turnin 10863 >>Turn in Secrets of the Arakkoa
.accept 10847 >>Accept The Eyes of Skettis
step
#sticky
#label fishing1end
.goto 1955/530,5300.0,-1610.6,0,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Seth|r
.target Seth
.turnin 10037 >>Turn in Rather Be Fishin'
step
#aldor
.goto 1955/530,5295.70020,-1614.40002
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sha'nir|r
.target Sha'nir
.accept 10020 >>Accept A Cure for Zahlia
step
#requires fishing1end
.goto 1955/530,5190.6001,-1742.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wind Trader Lathrai|r
.target Wind Trader Lathrai
.turnin 9979 >>Turn in Wind Trader Lathrai
.accept 10112 >>Accept A Personal Favor
step
#scryer
#label Lathrai1
>>Travel to Shattrath
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rilak the Redeemed|r, |cRXP_FRIENDLY_Seth|r and |cRXP_FRIENDLY_Wind Trader Lathrai|r
.turnin 10863 >> Turn in Secrets of the Arakkoa
.accept 10847 >> Accept The Eyes of Skettis
.goto Shattrath City,52.54,21.03
.turnin 10037 >> Turn in Rather Be Fishin'
.goto Shattrath City,63.94,15.52
.turnin 9979 >> Turn in Wind Trader Lathrai
.accept 10112 >> Accept A Personal Favor
.goto Shattrath City,72.23,30.72
.target Rilak the Redeemed
.target Seth
.target Wind Trader Lathrai
step << skip
.accept 10024 >> Accept Voren'thal's Visions
step
#questguide << !tbc
#aldor
#completewith Altar
>>Kill |cRXP_ENEMY_Dampscale Basilisks|r. Loot them for their |cRXP_LOOT_Eyes|r
.complete 10024,1 
.mob Dampscale Basilisk
step << skip
#scryer
#completewith Ashkaz
>>Kill Dreadfang Lurkers. Loot them for their Sacs
.complete 10017,1 
.mob Dreadfang Lurker
step
#questguide << !tbc
#optional
#completewith next
>>Kill |cRXP_ENEMY_Timber Worgs|r. Loot them for their |cRXP_LOOT_Tails|r
.complete 10016,1 
.mob Timber Worg
step
#optional
#completewith Talonite
>>Loot the |cRXP_PICK_Olemba Seeds|r (light blue cones) on the ground throughout Terokkar
.complete 9992,1 
step
#label Altar
#aldor
.goto Terokkar Forest,48.10,14.51
>>Click the |cRXP_PICK_Western Altar|r
.complete 10021,3 
step
#optional
#completewith Talonite
>>Kill |cRXP_ENEMY_Arakkoa|r. Loot them for their |cRXP_LOOT_Feathers|r
.collect 25719,30,10917,1 
step
#optional
#completewith Shienor
>>Kill |cRXP_ENEMY_Shienor Talonites|r and |cRXP_ENEMY_Sorcerers|r
.complete 10869,1 
.mob +Shienor Talonite
.complete 10869,2 
.mob +Shienor Sorcerer
step
#aldor
.goto Terokkar Forest,50.67,16.54
>>Click the |cRXP_PICK_Northern Altar|r
.complete 10021,1 
step
#optional
.groundgoto Terokkar Forest,49.79,16.64,30,0
.goto Terokkar Forest,49.11,16.89
>>Climb up the stairs to the tree platform. Kill |cRXP_ENEMY_Ashkaz|r
.complete 9986,1 
.skill riding,225,1
.unitscan Ashkaz
step
#label Ashkaz
.goto Terokkar Forest,49.11,16.89
>>Kill |cRXP_ENEMY_Ashkaz|r atop the tree platform
.complete 9986,1 
.skill riding,<225,1
.unitscan Ashkaz
step
#optional
.goto Terokkar Forest,50.12,19.37
>>Cross the bridge. Loot the |cRXP_PICK_Eye of Veil Reskk|r (purple eye) on the other tree platform
.complete 10847,1 
.skill riding,225,1
step
.goto Terokkar Forest,50.12,19.37
>>Loot the |cRXP_PICK_Eye of Veil Reskk|r (purple eye) on the other tree platform
.complete 10847,1 
.skill riding,<225,1
step
#aldor
.goto Terokkar Forest,49.25,20.32
>>Click the |cRXP_PICK_Eastern Altar|r
.complete 10021,2 
step
#optional
.goto Terokkar Forest,57.89,23.15
>>Fly up to the tree platform on the tree. Loot the |cRXP_PICK_Eye of Veil Reskk|r (purple eye)
.complete 10847,2 
.skill riding,<225,1
step
.goto Terokkar Forest,59.42,23.50
>>Kill |cRXP_ENEMY_Ayit|r inside the building below the tree
.complete 9986,2 
.unitscan Ayit
step
#label Shienor
.groundgoto Terokkar Forest,59.74,25.11,20,0
.goto Terokkar Forest,57.89,23.15
>>Take the stairs up that are inside of the tree. Cross the bridge. Loot the |cRXP_PICK_Eye of Veil Reskk|r (purple eye) on the other tree platform
.complete 10847,2 
.skill riding,225,1
step
#label Talonite
#loop
.line Terokkar Forest,58.62,22.03,57.27,24.31,56.23,25.41,58.02,27.19,59.10,27.49,60.08,26.83,60.52,25.96,60.37,23.41,59.35,24.60,58.32,24.76,58.62,22.03
.goto Terokkar Forest,58.62,22.03,50,0
.goto Terokkar Forest,57.27,24.31,50,0
.goto Terokkar Forest,56.23,25.41,50,0
.goto Terokkar Forest,58.02,27.19,50,0
.goto Terokkar Forest,59.10,27.49,50,0
.goto Terokkar Forest,60.08,26.83,50,0
.goto Terokkar Forest,60.52,25.96,50,0
.goto Terokkar Forest,60.37,23.41,50,0
.goto Terokkar Forest,59.35,24.60,50,0
.goto Terokkar Forest,58.32,24.76,50,0
.goto Terokkar Forest,58.62,22.03,50,0
>>Kill |cRXP_ENEMY_Shienor Talonites|r and |cRXP_ENEMY_Sorcerers|r
.complete 10869,1 
.mob +Shienor Talonite
.complete 10869,2 
.mob +Shienor Sorcerer
step
#aldor
#loop
.goto Terokkar Forest,60.77,23.14,50,0
.goto Terokkar Forest,60.97,24.34,50,0
.goto Terokkar Forest,61.46,25.43,50,0
.goto Terokkar Forest,62.10,27.12,50,0
.goto Terokkar Forest,62.77,27.68,50,0
.goto Terokkar Forest,63.32,28.38,50,0
.goto Terokkar Forest,63.72,29.37,50,0
.goto Terokkar Forest,64.54,30.01,50,0
.goto Terokkar Forest,66.31,30.54,50,0
.goto Terokkar Forest,67.93,30.85,50,0
.goto Terokkar Forest,68.35,31.31,50,0
.goto Terokkar Forest,69.16,31.22,50,0
.goto Terokkar Forest,69.63,30.88,50,0
.goto Terokkar Forest,70.35,29.82,50,0
.goto Terokkar Forest,71.26,28.70,50,0
.line Terokkar Forest,71.26,28.70,70.35,29.82,69.63,30.88,69.16,31.22,68.35,31.31,67.93,30.85,66.31,30.54,64.54,30.01,63.72,29.37,63.32,28.38,62.77,27.68,62.10,27.12,61.46,25.43,60.97,24.34,60.77,23.14
>>Kill |cRXP_ENEMY_Stonegazer|r. Loot him for his |cRXP_LOOT_Blood|r. He patrols around.
>>This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. << tbc
.complete 10020,1 
.unitscan Stonegazer
step << !Shaman !Mage
#questguide << !tbc
#completewith next
>>Kill |cRXP_ENEMY_Timber Worgs|r. Loot them for their |cRXP_LOOT_Tails|r
>>Kill |cRXP_ENEMY_Warp Stalkers|r
>>Loot the |cRXP_PICK_Olemba Seeds|r (light blue cones) on the ground throughout Terokkar
.complete 10016,1 
.complete 10026,1 
.complete 9992,1 
.mob Timber Worg
.mob Timber Worg Alpha
.mob Warp Stalker
step << !Shaman !Mage
#completewith eyet1
>>Loot the |cRXP_PICK_Olemba Seeds|r (light blue cones) on the ground throughout Terokkar
>>Kill |cRXP_ENEMY_Warp Stalkers|r
.complete 9992,1 
.complete 10026,1 
.mob Warp Stalker
.subzoneskip 3684
.zoneskip Shattrath City
step << Shaman
#completewith next
.hs >> Hearth to Allerian Stronghold
step << !Mage
.goto Terokkar Forest,59.44,55.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Furnan Skysoar|r
.fly Shattrath >> Fly to Shattrath City
.target Furnan Skysoar
.isOnQuest 10847
step << Mage
.zone Shattrath City >> Teleport to Shattrath
.isOnQuest 10847
step
#label eyet1
.goto Shattrath City,52.54,21.03
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rilak the Redeemed|r
.turnin 10847 >> Turn in The Eyes of Skettis
.accept 10849 >> Accept Seek Out Kirrik
.target Rilak the Redeemed
step
#aldor
>>Return to Shattrath
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sha'nir|r
.turnin 10020 >> Turn in A Cure for Zahlia
.goto Shattrath City,64.47,15.13
.isQuestComplete 10020
.target Sha'nir
step
#sticky
#label olembaseeds1
#loop
.line Terokkar Forest,37.42,33.69,38.70,34.70,39.73,34.95,40.88,34.26,41.58,34.11,43.12,35.06,43.31,35.75,44.75,34.81,44.27,33.07,44.96,31.18,44.74,29.80,37.97,31.29,37.42,33.69
.goto Terokkar Forest,37.42,33.69,20,0
.goto Terokkar Forest,38.70,34.70,20,0
.goto Terokkar Forest,39.73,34.95,20,0
.goto Terokkar Forest,40.88,34.26,20,0
.goto Terokkar Forest,41.58,34.11,20,0
.goto Terokkar Forest,43.12,35.06,20,0
.goto Terokkar Forest,43.31,35.75,20,0
.goto Terokkar Forest,44.75,34.81,20,0
.goto Terokkar Forest,44.27,33.07,20,0
.goto Terokkar Forest,44.96,31.18,20,0
.goto Terokkar Forest,44.74,29.80,20,0
.goto Terokkar Forest,37.97,31.29,20,0
.goto Terokkar Forest,37.42,33.69,20,0
>>Loot the |cRXP_PICK_Olemba Seeds|r (light blue cones) on the ground throughout Terokkar
.complete 9992,1 
step
#questguide << !tbc
#loop
.line Terokkar Forest,37.42,33.69,38.70,34.70,39.73,34.95,40.88,34.26,41.58,34.11,43.12,35.06,43.31,35.75,44.75,34.81,44.27,33.07,44.96,31.18,44.74,29.80,37.97,31.29,37.42,33.69
.goto Terokkar Forest,37.42,33.69,40,0
.goto Terokkar Forest,38.70,34.70,40,0
.goto Terokkar Forest,39.73,34.95,40,0
.goto Terokkar Forest,40.88,34.26,40,0
.goto Terokkar Forest,41.58,34.11,40,0
.goto Terokkar Forest,43.12,35.06,40,0
.goto Terokkar Forest,43.31,35.75,40,0
.goto Terokkar Forest,44.75,34.81,40,0
.goto Terokkar Forest,44.27,33.07,40,0
.goto Terokkar Forest,44.96,31.18,40,0
.goto Terokkar Forest,44.74,29.80,40,0
.goto Terokkar Forest,37.97,31.29,40,0
.goto Terokkar Forest,37.42,33.69,40,0
>>Kill |cRXP_ENEMY_Timber Worgs|r. Loot them for their |cRXP_LOOT_Tails|r
.complete 10016,1 
.mob Timber Worg
step
#requires olembaseeds1
.goto Terokkar Forest,40.46,36.16
>>|cRXP_WARN_Make sure to Dismount before talking to|r |cRXP_FRIENDLY_Private Weeks|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Private Weeks|r
.turnin 10038 >> Turn in Speak with Private Weeks
.accept 10040 >> Accept Who Are They?
.target Private Weeks
step << skip
#completewith next
.goto Terokkar Forest,40.46,36.16
.cast 32756 >>Talk to Weeks while dismounted to ask for a disguise
.skipgossip 18715,1
.target Private Weeks
step
.goto Terokkar Forest,40.46,36.16,0
>>Talk to |cRXP_FRIENDLY_Private Weeks|r if your disguise breaks or you don't currently have it on
>>Go into Grangol'var. |cRXP_WARN_DO NOT mount or cast any spells|r. Talk to the |cRXP_FRIENDLY_Advisor|r inside the building, the |cRXP_FRIENDLY_Initiate|r near the pond, and the |cRXP_FRIENDLY_Laborer|r patrolling around outside
>>Be careful as |cRXP_ENEMY_Shadowy Hunters|r can break your disguise!
#loop
.line Terokkar Forest,39.86,42.20,39.25,41.69,39.02,40.97,38.60,40.67,38.09,40.74,38.04,41.12,39.47,40.77,40.02,40.52,40.59,40.49,41.00,40.66
.complete 10040,3 
.goto Terokkar Forest,39.90,39.50,30,0
.goto Terokkar Forest,40.32,39.04
.mob +Shadowy Advisor
.complete 10040,1 
.goto Terokkar Forest,39.03,39.69
.mob +Shadowy Initiate
.complete 10040,2 
.mob +Shadowy Laborer
.goto Terokkar Forest,39.86,42.20,40,0
.goto Terokkar Forest,39.25,41.69,40,0
.goto Terokkar Forest,39.02,40.97,40,0
.goto Terokkar Forest,38.60,40.67,40,0
.goto Terokkar Forest,38.09,40.74,40,0
.goto Terokkar Forest,38.04,41.12,40,0
.goto Terokkar Forest,39.47,40.77,40,0
.goto Terokkar Forest,40.02,40.52,40,0
.goto Terokkar Forest,40.59,40.49,40,0
.goto Terokkar Forest,41.00,40.66,40,0
.skipgossip
.skipgossip 18715,1
.target Private Weeks
.target Shadowy Hunter
step
.goto Terokkar Forest,40.46,36.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Private Weeks|r
.turnin 10040 >> Turn in Who Are They?
.accept 10042 >> Accept Kill the Shadow Council!
.target Private Weeks
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Shadowy Executioners|r and |cRXP_ENEMY_Summoners|r
.complete 10042,1 
.mob +Shadowy Executioner
.complete 10042,2 
.mob +Shadowy Summoner
step
.groundgoto Terokkar Forest,39.90,39.50,30,0
.goto Terokkar Forest,40.37,39.15
>>Kill |cRXP_ENEMY_Shadowmaster Grieve|r inside the building
.complete 10042,3 
.unitscan Shadowmaster Grieve
step
#loop
.line Terokkar Forest,41.22,40.84,40.77,42.98,38.88,41.70,36.64,40.89,38.19,39.12,39.25,38.45,39.43,40.45,41.22,40.84
.goto Terokkar Forest,41.22,40.84,50,0
.goto Terokkar Forest,40.77,42.98,50,0
.goto Terokkar Forest,38.88,41.70,50,0
.goto Terokkar Forest,36.64,40.89,50,0
.goto Terokkar Forest,38.19,39.12,50,0
.goto Terokkar Forest,39.25,38.45,50,0
.goto Terokkar Forest,39.43,40.45,50,0
.goto Terokkar Forest,41.22,40.84,50,0
>>Kill |cRXP_ENEMY_Shadowy Executioners|r and |cRXP_ENEMY_Summoners|r
.complete 10042,1 
.mob +Shadowy Executioner
.complete 10042,2 
.mob +Shadowy Summoner
step
#optional
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mekeda|r. He patrols around counter-clockwise
.accept 10878 >> Accept Before Darkness Falls
.target Mekeda
step
#label Caravan
>>Travel to the Refugee Caravan
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lakotae|r, |cRXP_FRIENDLY_Kirrik the Awakened|r and |cRXP_FRIENDLY_Ethan|r
.accept 10896 >> Accept The Infested Protectors
.target +Lakotae
.goto Terokkar Forest,37.86,51.69
.turnin 10849 >> Turn in Seek Out Kirrik
.accept 10839 >> Accept Veil Skith: Darkstone of Terokk
.target +Kirrik the Awakened
.goto Terokkar Forest,37.56,51.50,30,0
.goto Terokkar Forest,37.09,50.69
.accept 10852 >> Accept Missing Friends
.target +Ethan
.goto Terokkar Forest,37.74,51.34
step
.goto Terokkar Forest,37.73,51.80,30,0
.goto Terokkar Forest,37.28,50.99,30,0
.goto Terokkar Forest,37.23,50.32,30,0
.goto Terokkar Forest,37.51,49.98,30,0
.goto Terokkar Forest,37.86,50.06,30,0
.goto Terokkar Forest,38.38,51.14,30,0
.goto Terokkar Forest,38.20,51.74
.line Terokkar Forest,38.20,51.74,38.38,51.14,37.86,50.06,37.51,49.98,37.23,50.32,37.28,50.99,37.73,51.80,38.20,51.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mekeda|r. He patrols around counter-clockwise
.accept 10878 >> Accept Before Darkness Falls
.target Mekeda
step
#optional
#completewith vskith
>>Kill |cRXP_ENEMY_Bonelashers|r
.complete 10033,1 
.mob *Bonelasher
step
#optional
#completewith vskith
>>Kill |cRXP_ENEMY_Rotting Forest-Ragers|r and |cRXP_ENEMY_Infested Root-Walkers|r to |cRXP_WARN_spawn|r |cRXP_ENEMY_Wood Mites|r. Kill them
.complete 10896,1,12 
.mob Wood Mite
.mob Rotting Forest-Rager
.mob Infested Root-Walker
step
#label vskith
.goto Terokkar Forest,30.82,42.02,110 >> Travel to Veil Skith
.subzoneskip 3677
.isOnQuest 10839
step
#optional
#completewith Children
>>Kill |cRXP_ENEMY_Arakkoa|r. Loot them for their |cRXP_LOOT_Feathers|r
.collect 25719,30,10917,1 
.mob Skithian Windripper
.mob Skithian Dreadhawk
step
#optional
#completewith Urdak
>>Kill the |cRXP_ENEMY_Skithian|r. Loot them for their |cRXP_LOOT_Prison Keys|r and |cRXP_LOOT_Stolen Goods|r
>>Use the keys on the cages on the tree platforms and on the ground in Veil Skith
.collect 31655,12,10852,1,-1
.complete 10852,1 
.complete 10112,1 
.mob Skithian Windripper
.mob Skithian Dreadhawk
step
.goto Terokkar Forest,30.82,42.02
.use 31610 >>Channel the |T135463:0|t[Rod of Purification] in your bags on the Darkstone
.complete 10839,1 
.cast 38736
.timer 10,Channel the Rod RP
step
#optional
.goto Terokkar Forest,31.41,42.55,12,0
.goto Terokkar Forest,31.49,42.00,12,0
.goto Terokkar Forest,31.86,42.31
>>Kill |cRXP_ENEMY_Urdak|r atop the tree platform
.complete 9986,3 
.skill riding,<225,1
.unitscan Urdak
step
#label Urdak
.groundgoto Terokkar Forest,29.97,43.06,20,0
.groundgoto Terokkar Forest,30.80,43.50,20,0
.goto Terokkar Forest,31.41,42.55,12,0
.goto Terokkar Forest,31.49,42.00,12,0
.goto Terokkar Forest,31.86,42.31
>>Go up the stairs, then cross the bridge. Kill |cRXP_ENEMY_Urdak|r atop the tree platform
.complete 9986,3 
.skill riding,225,1
.unitscan Urdak
step
#label Children
#loop
.line Terokkar Forest,31.13,40.66,29.61,42.92,30.61,43.88,31.46,42.38,31.13,40.66
.goto Terokkar Forest,31.13,40.66,40,0
.goto Terokkar Forest,29.61,42.92,40,0
.goto Terokkar Forest,30.61,43.88,40,0
.goto Terokkar Forest,31.46,42.38,40,0
.goto Terokkar Forest,31.13,40.66,40,0
>>Kill the |cRXP_ENEMY_Skithian|r. Loot them for their |cRXP_LOOT_Prison Keys|r and |cRXP_LOOT_Stolen Goods|r
>>Use the keys on the cages on the tree platforms and on the ground in Veil Skith
.collect 31655,12,10852,1,-1
.complete 10852,1 
.complete 10112,1 
.mob Skithian Windripper
.mob Skithian Dreadhawk
step << !tbc
#loop
.line Terokkar Forest,31.13,40.66,29.61,42.92,30.61,43.88,31.46,42.38,31.13,40.66
.goto Terokkar Forest,31.13,40.66,40,0
.goto Terokkar Forest,29.61,42.92,40,0
.goto Terokkar Forest,30.61,43.88,40,0
.goto Terokkar Forest,31.46,42.38,40,0
.goto Terokkar Forest,31.13,40.66,40,0
>>Kill |cRXP_ENEMY_Arakkoa|r. Loot them for their |cRXP_LOOT_Feathers|r
.collect 25719,30,10917,1 
.mob Skithian Windripper
.mob Skithian Dreadhawk
step
#loop
.goto Terokkar Forest,34.16,49.24,50,0
.goto Terokkar Forest,35.02,47.93,50,0
.goto Terokkar Forest,38.49,46.89,50,0
.goto Terokkar Forest,39.92,47.76,50,0
.goto Terokkar Forest,40.75,49.86,50,0
.goto Terokkar Forest,40.75,49.86,0
>>Kill |cRXP_ENEMY_Rotting Forest-Ragers|r and |cRXP_ENEMY_Infested Root-Walkers|r to |cRXP_WARN_spawn|r |cRXP_ENEMY_Wood Mites|r. Kill them
.complete 10896,1 
.mob Wood Mite
.mob Rotting Forest-Rager
.mob Infested Root-Walker
step
.goto 1952/530,5064.39990,-2835.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kirrik the Awakened|r
.target Kirrik the Awakened
.turnin 10839 >>Turn in Veil Skith: Darkstone of Terokk
.accept 10848 >>Accept Veil Rhaze: Unliving Evil
step
.goto 1952/530,5046.89990,-2849.19995
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ethan|r
.target Ethan
.turnin 10852 >>Turn in Missing Friends
step
.goto 1952/530,5040.80029,-2860.50000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lakotae|r
.target Lakotae
.turnin 10896 >>Turn in The Infested Protectors
step
.goto 1952/530,5060.80029,-2827.80005
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_High Priest Orglum|r
.target High Priest Orglum
.accept 10840 >>Accept The Tomb of Lights
.accept 10842 >>Accept Vengeful Souls << !TBC
step
#optional
#completewith lootorder1
>>Kill |cRXP_ENEMY_Bonelashers|r
.complete 10033,1 
.mob *Bonelasher
step
#aldor
#completewith Orders
>>Kill |cRXP_ENEMY_Cabal|r orcs. Loot them for their |cRXP_LOOT_Marks of Kil'jaeden|r, save them for a quest later
.collect 29425,10,10325,1 
step
#label lootorder1
#loop
.line Terokkar Forest,40.96,56.31,41.55,58.82,39.66,60.28,38.99,58.43,37.71,58.77,37.72,55.93,39.28,55.01,40.96,56.31
.goto Terokkar Forest,40.96,56.31,50,0
.goto Terokkar Forest,41.55,58.82,50,0
.goto Terokkar Forest,39.66,60.28,50,0
.goto Terokkar Forest,38.99,58.43,50,0
.goto Terokkar Forest,37.71,58.77,50,0
.goto Terokkar Forest,37.72,55.93,50,0
.goto Terokkar Forest,39.28,55.01,50,0
.goto Terokkar Forest,40.96,56.31,50,0
.use 31707 >>Kill the |cRXP_ENEMY_Cabal|r. Loot them for the |cRXP_LOOT_Orders|r. Click the |T134332:0|t[Cabal Orders] in your bags
.collect 31707,1,10880 
.accept 10880 >> Accept Cabal Orders
.mob Cabal Tomb-Raider
.mob Cabal Spell-weaver
.mob Cabal Skirmisher
.mob Cabal Initiate
.mob Cabal Abjurist
step
#label Orders
#loop
.line Terokkar Forest,40.96,56.31,41.55,58.82,39.66,60.28,38.99,58.43,37.71,58.77,37.72,55.93,39.28,55.01,40.96,56.31
.goto Terokkar Forest,40.96,56.31,50,0
.goto Terokkar Forest,41.55,58.82,50,0
.goto Terokkar Forest,39.66,60.28,50,0
.goto Terokkar Forest,38.99,58.43,50,0
.goto Terokkar Forest,37.71,58.77,50,0
.goto Terokkar Forest,37.72,55.93,50,0
.goto Terokkar Forest,39.28,55.01,50,0
.goto Terokkar Forest,40.96,56.31,50,0
>>Kill |cRXP_ENEMY_Cabal Skirmishers|r, |cRXP_ENEMY_Spell-weavers|r and |cRXP_ENEMY_Initiates|r
.complete 10878,1 
.mob +Cabal Skirmisher
.complete 10878,2 
.mob +Cabal Spell-weaver
.complete 10878,3 
.mob +Cabal Initiate
step
.goto Terokkar Forest,37.73,51.80,30,0
.goto Terokkar Forest,37.28,50.99,30,0
.goto Terokkar Forest,37.23,50.32,30,0
.goto Terokkar Forest,37.51,49.98,30,0
.goto Terokkar Forest,37.86,50.06,30,0
.goto Terokkar Forest,38.38,51.14,30,0
.goto Terokkar Forest,38.20,51.74
.line Terokkar Forest,38.20,51.74,38.38,51.14,37.86,50.06,37.51,49.98,37.23,50.32,37.28,50.99,37.73,51.80,38.20,51.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mekeda|r. He patrols around the caravan counter-clockwise
.turnin 10878 >> Turn in Before Darkness Falls
.turnin 10880 >> Turn in Cabal Orders
.accept 10881 >> Accept The Shadow Tomb
.target Mekeda
step
.goto Terokkar Forest,30.68,50.76,50,0
.goto Terokkar Forest,27.41,51.45,50,0
.goto Terokkar Forest,25.98,57.68,50,0
.goto Terokkar Forest,30.68,50.76
>>Kill |cRXP_ENEMY_Deathtalon Spirits|r, |cRXP_ENEMY_Screeching Spirits|r and |cRXP_ENEMY_Spirit Ravens|r
.complete 10848,1 
.mob +Deathtalon Spirit
.complete 10848,2 
.mob +Screeching Spirit
.complete 10848,3 
.mob +Spirit Raven
step
#optional
#aldor
#completewith Akuno
>>Kill |cRXP_ENEMY_Cabal|r orcs. Loot them for their |cRXP_LOOT_Marks of Kil'jaeden|r, save them for a quest later
.collect 29425,10,10325,1 
step
#completewith next
.goto Terokkar Forest,31.07,52.67,20 >> Enter the Shadow Tomb
step
>>Inside the Shadow Tomb, loot the chests containing the |cRXP_PICK_Gavel|r, |cRXP_PICK_Drape|r and |cRXP_PICK_Scroll|r
.complete 10881,2 
.goto Terokkar Forest,29.67,51.69
.complete 10881,1 
.goto Terokkar Forest,32.09,51.19
.complete 10881,3 
.goto Terokkar Forest,31.16,46.69
step
.goto Terokkar Forest,30.61,49.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Akuno|r inside the Shadow Tomb
.accept 10887 >> Accept Escaping the Tomb
.target Akuno
step
#label Akuno
.goto Terokkar Forest,33.77,51.61
>>Escort |cRXP_FRIENDLY_Akuno|r out of the tomb. You'll get ambushed by two |cRXP_ENEMY_Orcs|r in the main connecting room and two |cRXP_ENEMY_Orcs|r when you reach the outside.
.complete 10887,1 
.target Akuno
step
#aldor
.goto Terokkar Forest,31.16,46.69
>>Kill |cRXP_ENEMY_Cabal|r inside the Shadow Tomb. Loot them for their |cRXP_LOOT_Marks of Kil'jaeden|r
.collect 29425,10,10325,1 
.mob Cabal Tomb-Raider
.mob Cabal Spell-weaver
.mob Cabal Skirmisher
.mob Cabal Initiate
.mob Cabal Abjurist
step << !TBC
#completewith next
>>Kill |cRXP_ENEMY_Bonelashers|r
.complete 10033,1 
.mob Bonelasher
step << !TBC
#completewith Draenei
.goto Terokkar Forest,47.00,55.14,20 >> Enter the Tomb of Lights
step << !TBC
#optional
#completewith next
>>Kill |cRXP_ENEMY_Ethereal Nethermancers|r and |cRXP_ENEMY_Ethereal Plunderers|r
.complete 10840,1 
.mob +Ethereal Nethermancer
.complete 10840,2 
.mob +Ethereal Plunderer
step << !TBC
#label Draenei
.goto Terokkar Forest,47.76,52.87,40,0
.goto Terokkar Forest,47.72,56.96,40,0
.goto Terokkar Forest,50.94,54.75,40,0
.goto Terokkar Forest,47.76,52.87,40,0
.goto Terokkar Forest,47.72,56.96,40,0
.goto Terokkar Forest,50.94,54.75
>>Kill the |cRXP_ENEMY_Vengeful Draenei|r inside the Tomb of Lights
.complete 10842,1 
.isOnQuest 10842
.mob Vengeful Draenei
step << !TBC
.goto Terokkar Forest,47.79,56.55,40,0
.goto Terokkar Forest,47.62,53.58,40,0
.goto Terokkar Forest,46.03,54.26,40,0
.goto Terokkar Forest,46.34,56.51,40,0
.goto Terokkar Forest,47.72,56.96,15,0
.goto Terokkar Forest,47.76,52.87,40,0
.goto Terokkar Forest,47.72,56.96,40,0
.goto Terokkar Forest,50.94,54.75,40,0
.goto Terokkar Forest,46.34,56.51
>>Kill |cRXP_ENEMY_Ethereal Nethermancers|r and |cRXP_ENEMY_Ethereal Plunderers|r. Go inside the Tomb of Lights if you need to kill more
.complete 10840,1 
.mob +Ethereal Nethermancer
.complete 10840,2 
.mob +Ethereal Plunderer
step
.goto Terokkar Forest,43.86,49.67,60,0
.goto Terokkar Forest,42.76,53.31,60,0
.goto Terokkar Forest,42.11,50.31,60,0
.goto Terokkar Forest,39.59,50.22,60,0
.goto Terokkar Forest,39.01,53.40,60,0
.goto Terokkar Forest,42.76,53.31
>>Kill |cRXP_ENEMY_Bonelashers|r
.complete 10033,1 
.mob Bonelasher
step
#optional
#completewith next
.line Terokkar Forest,38.20,51.74,38.38,51.14,37.86,50.06,37.51,49.98,37.23,50.32,37.28,50.99,37.73,51.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mekeda|r. He patrols around the caravan counter-clockwise
.turnin 10881 >> Turn in The Shadow Tomb
.turnin 10887 >> Turn in Escaping the Tomb
.target Mekeda
step
#questguide << !tbc
>>Return to the Refugee Caravan
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kirrik the Awakened|r
.goto Terokkar Forest,37.56,51.50,30,0
.goto Terokkar Forest,37.09,50.69
.turnin 10848 >> Turn in Veil Rhaze: Unliving Evil
.accept 10861 >> Accept Veil Lithic: Preemptive Strike
.target Kirrik the Awakened
step
>>Return to the Refugee Caravan
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kirrik the Awakened|r
.goto Terokkar Forest,37.56,51.50,30,0
.goto Terokkar Forest,37.09,50.69
.turnin 10848 >> Turn in Veil Rhaze: Unliving Evil

.target Kirrik the Awakened
step << !TBC
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_High Priest Orglum|r
.goto Terokkar Forest,37.45,50.76
.turnin 10840 >> Turn in The Tomb of Lights
.turnin 10842 >> Turn in Vengeful Souls
.target High Priest Orglum
step
.goto Terokkar Forest,37.73,51.80,30,0
.goto Terokkar Forest,37.28,50.99,30,0
.goto Terokkar Forest,37.23,50.32,30,0
.goto Terokkar Forest,37.51,49.98,30,0
.goto Terokkar Forest,37.86,50.06,30,0
.goto Terokkar Forest,38.38,51.14,30,0
.goto Terokkar Forest,38.20,51.74
.line Terokkar Forest,38.20,51.74,38.38,51.14,37.86,50.06,37.51,49.98,37.23,50.32,37.28,50.99,37.73,51.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mekeda|r. He patrols around the caravan counter-clockwise
.turnin 10881 >> Turn in The Shadow Tomb
.turnin 10887 >> Turn in Escaping the Tomb
.target Mekeda
step << Shaman
#completewith next
.hs >> Hearth to Allerian Stronghold
step
.goto 1952/530,3982.80005,-2994.19995
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ros'eleth|r
.target Ros'eleth
.turnin 9992 >>Turn in Olemba Seeds
step
.goto 1952/530,3991.80005,-3007.60010
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Gravelhammer|r
.target Lieutenant Gravelhammer
.turnin 10042 >>Turn in Kill the Shadow Council!
.turnin 10869 >>Turn in Thin the Flock
step
.goto 1952/530,3963.10010,-2955.50000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thander|r
.target Thander
.turnin 9986 >>Turn in Stymying the Arakkoa
step
#questguide << !tbc
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bertelm|r
.goto Terokkar Forest,58.30,54.76
.turnin 10016 >> Turn in Timber Worg Tails
.accept 10022 >> Accept The Elusive Ironjaw
.target Bertelm
step
.goto 1952/530,3946.60010,-2923.50000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Taela Everstride|r
.target Taela Everstride
.turnin 10033 >>Turn in Wanted: Bonelashers Dead!
step
#questguide << !tbc
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Taela Everstride|r
.target Taela Everstride
.goto 1952/530,3946.60010,-2923.50000
.accept 10035 >>Accept Torgos!
step
.goto 1952/530,3922.40015,-2927.90015
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Andarl|r
.target Andarl
.turnin 10026 >>Turn in Magical Disturbances
.isQuestComplete 10026
step
#completewith sreturn1
.goto Terokkar Forest,59.44,55.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Furnan Skysoar|r
.fly Shattrath >> Fly to Shattrath City
.target Furnan Skysoar
.zoneskip Shattrath City
step
#optional
>>Return to Shattrath
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wind Trader Lathrai|r and |cRXP_FRIENDLY_Vekax|r
.turnin 10112 >> Turn in A Personal Favor
.accept 9990 >> Accept Investigate Tuurem
.goto Shattrath City,72.23,30.72
.target +Wind Trader Lathrai
.accept 10917 >> Accept The Outcast's Plight
.turnin 10917 >> Turn in The Outcast's Plight
.goto Shattrath City,52.38,16.47,30,0
.goto Shattrath City,43.73,21.73,30,0
.goto Shattrath City,46.47,20.12
.itemcount 25719,30 
.target +Vekax
step
#label sreturn1
>>Return to Shattrath
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wind Trader Lathrai|r
.turnin 10112 >> Turn in A Personal Favor
.accept 9990 >> Accept Investigate Tuurem
.goto Shattrath City,72.23,30.72
.target Wind Trader Lathrai
step << skip
.complete 10028,1 
step
.goto Terokkar Forest,54.00,29.99
>>Travel to Tuurem
>>Loot the |cRXP_PICK_Sealed Box|r
.complete 9990,1 
step
.goto Terokkar Forest,44.33,26.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthbinder Tavgren|r
.turnin 9990 >> Turn in Investigate Tuurem
.accept 9994 >> Accept What Are These Things?
.target Earthbinder Tavgren
step
#completewith next
.hs >> Hearth to Allerian Stronghold
.cooldown item,6948,>2
step
.goto Terokkar Forest,57.01,53.49
>>Return to Allerian Stronghold
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jenai Starwhisper|r
.turnin 9994 >> Turn in What Are These Things?
.accept 10444 >> Accept Report to the Allerian Post
.target Jenai Starwhisper

step
.goto Terokkar Forest,63.47,53.57,50,0
.goto Terokkar Forest,63.52,52.13,50,0
.goto Terokkar Forest,65.53,49.58,50,0
.goto Terokkar Forest,66.70,49.22,50,0
.goto Terokkar Forest,65.89,51.84,40,0
.goto Terokkar Forest,68.74,50.92,50,0
.goto Terokkar Forest,69.20,54.09,50,0
.goto Terokkar Forest,68.34,54.53
>>Kill |cRXP_ENEMY_Warped Peons|r
.complete 9998,1 
.mob Warped Peon
step
#completewith next
>>Kill |cRXP_ENEMY_Warp Stalkers|r
.complete 10026,1 
.mob Warp Stalker
step
>>Travel to Allerian Post
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Meridian|r and |cRXP_FRIENDLY_Theloria Shadecloak|r
.turnin 10444 >> Turn in Report to the Allerian Post
.accept 9996 >> Accept Attack on Firewing Point
.goto Terokkar Forest,69.79,44.56,20,0
.goto Terokkar Forest,69.64,44.25
.target +Lieutenant Meridian
.turnin 9998 >> Turn in Unruly Neighbors
.accept 10002 >> Accept The Firewing Liaison
.accept 10007 >> Accept Thinning the Ranks
.goto Terokkar Forest,69.74,44.24
.target +Theloria Shadecloak
step
#optional
#completewith Lisaile
>>Kill |cRXP_ENEMY_Bonechewer Backbreakers|r and |cRXP_ENEMY_Devastators|r
.complete 10007,2 
.mob +Bonechewer Backbreaker
.complete 10007,1 
.mob +Bonechewer Devastator
step
#optional
#completewith next
.goto Terokkar Forest,67.93,53.56,0
>>Loot the |T134940:0|tFel Orc Plans on the ground
.accept 10012 >> Accept Fel Orc Plans
step
#label Lisaile
.groundgoto Terokkar Forest,67.15,54.38,20,0
>>Kill |cRXP_ENEMY_Lisaile|r inside the building
.complete 10002,1 
.goto Terokkar Forest,67.85,53.28
.unitscan Lisaile Fireweaver
step
.goto Terokkar Forest,67.93,53.56
>>Loot the |T134940:0|tFel Orc Plans on the ground
.accept 10012 >> Accept Fel Orc Plans
step
.goto Terokkar Forest,66.87,54.76,50,0
.goto Terokkar Forest,65.54,55.78,50,0
.goto Terokkar Forest,64.29,54.69,50,0
.goto Terokkar Forest,66.37,52.11,50,0
.goto Terokkar Forest,66.87,54.76,50,0
.goto Terokkar Forest,65.54,55.78,50,0
.goto Terokkar Forest,64.29,54.69,50,0
.goto Terokkar Forest,66.37,52.11
>>Kill |cRXP_ENEMY_Bonechewer Backbreakers|r and |cRXP_ENEMY_Devastators|r
.complete 10007,2 
.mob +Bonechewer Backbreaker
.complete 10007,1 
.mob +Bonechewer Devastator
step
.goto Terokkar Forest,69.74,44.24
>>Return to Allerian Post
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Theloria Shadecloak|r
.turnin 10002 >> Turn in The Firewing Liaison
.turnin 10007 >> Turn in Thinning the Ranks
.target Theloria Shadecloak
step
#questguide << !tbc
#aldor
#loop
.line Terokkar Forest,59.50,37.41,61.07,40.41,62.79,44.12,62.50,47.85,61.17,50.28,60.11,51.98,60.97,52.18,63.40,49.61,64.29,45.84,65.38,46.13,65.83,45.05
.goto Terokkar Forest,59.50,37.41,50,0
.goto Terokkar Forest,61.07,40.41,50,0
.goto Terokkar Forest,62.79,44.12,50,0
.goto Terokkar Forest,62.50,47.85,50,0
.goto Terokkar Forest,61.17,50.28,50,0
.goto Terokkar Forest,60.11,51.98,50,0
.goto Terokkar Forest,60.97,52.18,50,0
.goto Terokkar Forest,63.40,49.61,50,0
.goto Terokkar Forest,64.29,45.84,50,0
.goto Terokkar Forest,65.38,46.13,50,0
.goto Terokkar Forest,65.83,45.05,50,0
>>Kill |cRXP_ENEMY_Dampscale Devourers|r. Loot them for their |cRXP_LOOT_Eyes|r
.complete 10024,1 
.mob Dampscale Devourer
step
#scryer
#completewith FirewingD
>>Kill |cRXP_ENEMY_Firewings|r. Loot them for their |cRXP_LOOT_Signets|r
.collect 29426,10,10412,1 
step
#optional
#completewith Isla
>>Kill |cRXP_ENEMY_Firewing Defenders|r, |cRXP_ENEMY_Bloodwarders|r and |cRXP_ENEMY_Warlocks|r
.complete 9996,1 
.mob +Firewing Defender
.complete 9996,2 
.mob +Firewing Bloodwarder
.complete 9996,3 
.mob +Firewing Warlock
step
.goto Terokkar Forest,71.00,37.97,0
.goto Terokkar Forest,71.70,37.97,0
.goto Terokkar Forest,73.93,35.16
>>Kill the groups of |cRXP_ENEMY_Warlocks|r on the southern side of the circle before starting the escort to make it a LOT easier
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Isla Starmane|r in the cage to start the escort
.accept 10051 >> Accept Escape from Firewing Point!
.target Isla Starmane
step
#label Isla
.goto Terokkar Forest,71.95,38.09,50,0
.goto Terokkar Forest,67.51,37.28
>>Escort |cRXP_FRIENDLY_Isla Starmane|r. Stay close to her as she can die quickly
.complete 10051,1 
.target Isla Starmane
step
#label FirewingD
#loop
.line Terokkar Forest,68.22,36.56,70.07,35.63,71.63,34.99,72.86,34.90,72.32,37.25,73.87,35.76,72.22,39.36,71.41,40.25,70.87,38.26,68.22,36.56
.goto Terokkar Forest,68.22,36.56,50,0
.goto Terokkar Forest,70.07,35.63,50,0
.goto Terokkar Forest,71.63,34.99,50,0
.goto Terokkar Forest,72.86,34.90,50,0
.goto Terokkar Forest,72.32,37.25,50,0
.goto Terokkar Forest,73.87,35.76,50,0
.goto Terokkar Forest,72.22,39.36,50,0
.goto Terokkar Forest,71.41,40.25,50,0
.goto Terokkar Forest,70.87,38.26,50,0
.goto Terokkar Forest,68.22,36.56,50,0
>>Kill |cRXP_ENEMY_Firewing Defenders|r, |cRXP_ENEMY_Bloodwarders|r and |cRXP_ENEMY_Warlocks|r
.complete 9996,1 
.mob +Firewing Defender
.complete 9996,2 
.mob +Firewing Bloodwarder
.complete 9996,3 
.mob +Firewing Warlock
step
.goto Terokkar Forest,69.79,44.56,20,0
.goto Terokkar Forest,69.64,44.25
>>Return to Allerian Post
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Meridian|r
.turnin 9996 >> Turn in Attack on Firewing Point
.accept 10446 >> Accept The Final Code
.target Lieutenant Meridian
step
#optional
#scryer
#completewith MBomb
>>Kill |cRXP_ENEMY_Firewings|r. Loot them for their |cRXP_LOOT_Signets|r
.collect 29426,10,10412,1 
.mob Firewing Bloodwarder
.mob Firewing Defender
.mob Firewing Warlock
step
#optional
#completewith Code
.goto Terokkar Forest,73.31,34.59
.cast 32568 >>Fly to the balcony of the building. Take the Orb of Translocation to the top of the tower
.skill riding,<225,1
step
#completewith next
.goto Terokkar Forest,73.47,36.15,20,0
.goto Terokkar Forest,74.27,35.99,15,0
.goto Terokkar Forest,73.31,34.59
.cast 32568 >>Go into the building. Take the Orb of Translocation to the top of the tower
.skill riding,225,1
step
#label Code
.groundgoto Terokkar Forest,74.06,35.71,14,0
.groundgoto Terokkar Forest,73.90,36.16,14,0
.goto Terokkar Forest,73.92,37.80
>>Kill |cRXP_ENEMY_Sharth Voldoun|r at the top of the tower. Loot him for |cRXP_LOOT_The Final Code|r
.collect 29912,1,10446,1 
.unitscan Sharth Voldoun
step
#completewith next
.goto Terokkar Forest,74.18,36.52
.cast 32569 >>Take the Orb of Translocation to the bottom of the tower
step
#label MBomb
.goto Terokkar Forest,71.27,37.37
>>Kill the |cRXP_ENEMY_Warlocks|r around the Mana Bomb in the centre of the town. Click it
.complete 10446,1 
.mob Firewing Warlock
step
#scryer
#loop
.line Terokkar Forest,68.22,36.56,70.07,35.63,71.63,34.99,72.86,34.90,72.32,37.25,73.87,35.76,72.22,39.36,71.41,40.25,70.87,38.26,68.22,36.56
.goto Terokkar Forest,68.22,36.56,50,0
.goto Terokkar Forest,70.07,35.63,50,0
.goto Terokkar Forest,71.63,34.99,50,0
.goto Terokkar Forest,72.86,34.90,50,0
.goto Terokkar Forest,72.32,37.25,50,0
.goto Terokkar Forest,73.87,35.76,50,0
.goto Terokkar Forest,72.22,39.36,50,0
.goto Terokkar Forest,71.41,40.25,50,0
.goto Terokkar Forest,70.87,38.26,50,0
.goto Terokkar Forest,68.22,36.56,50,0
>>Kill |cRXP_ENEMY_Firewings|r. Loot them for their |cRXP_LOOT_Signets|r
.collect 29426,10,10412,1 
step
#sticky
#label WarpStalker
#loop
.line Terokkar Forest,69.04,32.58,66.61,36.48,62.88,40.28,64.86,33.63,61.87,34.36,60.94,23.97,62.03,24.73,65.79,33.83,69.04,32.58
.goto Terokkar Forest,69.04,32.58,50,0
.goto Terokkar Forest,66.61,36.48,50,0
.goto Terokkar Forest,62.88,40.28,50,0
.goto Terokkar Forest,64.86,33.63,50,0
.goto Terokkar Forest,61.87,34.36,50,0
.goto Terokkar Forest,60.94,23.97,50,0
.goto Terokkar Forest,62.03,24.73,50,0
.goto Terokkar Forest,65.79,33.83,50,0
.goto Terokkar Forest,69.04,32.58,50,0
>>Kill |cRXP_ENEMY_Warp Stalkers|r. They're invisible about 75% of the time
.complete 10026,1 
.mob Warp Stalker
step
.goto Terokkar Forest,63.73,35.31,60,0
.goto Terokkar Forest,64.41,35.33,60,0
.goto Terokkar Forest,64.78,35.11,60,0
.goto Terokkar Forest,65.61,34.88,60,0
.goto Terokkar Forest,66.03,34.85,60,0
.goto Terokkar Forest,66.64,35.14,60,0
.goto Terokkar Forest,66.97,34.87,60,0
.goto Terokkar Forest,67.89,35.24,60,0
.goto Terokkar Forest,68.19,35.00,60,0
.goto Terokkar Forest,68.25,33.65,60,0
.goto Terokkar Forest,68.55,33.06,60,0
.goto Terokkar Forest,69.07,33.05
.line Terokkar Forest,63.73,35.31,64.41,35.33,64.78,35.11,65.61,34.88,66.03,34.85,66.64,35.14,66.97,34.87,67.89,35.24,68.19,35.00,68.25,33.65,68.55,33.06,69.07,33.05
>>Kill |cRXP_ENEMY_Ironjaw|r. Loot him for his |cRXP_LOOT_Pelt|r. He patrols around
.complete 10023,1 
.unitscan Ironjaw
.isOnQuest 10023
step
#questguide << !tbc
#aldor
.goto Terokkar Forest,59.8,36.2,60,0
.goto Terokkar Forest,63.5,44.9,80,0
.goto Terokkar Forest,70.6,42.0,60,0
.goto Terokkar Forest,63.5,44.9,80,0
.goto Terokkar Forest,59.8,36.2
>>Kill remaining |cRXP_ENEMY_Basilisks|r along the river edge. Loot them for their |cRXP_LOOT_Eyes|r
.complete 10024,1 
.mob Dampscale Basilisk
step
#optional
#requires WarpStalker
step
#completewith next
.hs >> Hearth to Allerian Stronghold
.cooldown item,6948,>2 << !Shaman
step
#requires WarpStalker
.goto 1952/530,4004.30005,-2926.40015
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jenai Starwhisper|r
.target Jenai Starwhisper
.turnin 10446 >>Turn in The Final Code
.accept 10005 >>Accept Letting Earthbinder Tavgren Know
step
.goto 1952/530,3992.40015,-3005.60010
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Captain Auric Sunchaser|r
.target Captain Auric Sunchaser
.turnin 10051 >>Turn in Escape from Firewing Point!
step
.goto 1952/530,3937.90015,-2971.50000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bertelm|r
.target Bertelm
.turnin 10012 >>Turn in Fel Orc Plans
.turnin -10022 >> Turn in The Elusive Ironjaw
step
.goto 1952/530,3922.40015,-2927.90015
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Andarl|r
.target Andarl
.turnin 10026 >>Turn in Magical Disturbances
.isQuestComplete 10026
step << tbc
.goto Terokkar Forest,46.8,55.9
>>Kill |cRXP_ENEMY_Ethereal Nethermancers|r and |cRXP_ENEMY_Ethereal Plunderers|r
.complete 10840,1 
.complete 10840,2 
.mob Ethereal Nethermancer
.mob Ethereal Plunderer
step
#questguide << !tbc
.goto Terokkar Forest,43.2,51.6
>>Kill |cRXP_ENEMY_Trachela|r. Loot |cRXP_LOOT_Trachela's Carcass|r
.collect 30618,1 
.isOnQuest 10035
.mob Trachela
step << tbc
>> Return to the Caravan
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_High Priest Orglum|r
.turnin 10840 >> Turn in The Tomb of Lights
.goto Terokkar Forest,37.4,50.8
.target High Priest Orglum
step
#questguide << !tbc
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Soolaveen|r
.accept 10030 >> Accept Recover the Bones
.goto Terokkar Forest,37.1,49.5
.target Soolaveen
step
#questguide << !tbc
#label bones
#sticky
#completewith boneaway
>>Loot the |cRXP_PICK_Restless Bones|r on the ground all around Auchindoun as you quest
.complete 10030,1 
step
#questguide << !tbc
.goto Terokkar Forest,27.0,55.6
>>Use Trachela's Carcass to summon Torgos (elite)
.complete 10035,1 
>>This quest can be hard to solo, skip this step if you have to
.mob Torgos
step
#questguide << !tbc
#requires bones
#label boneaway
.goto Terokkar Forest,23.7,72.3
>>Look for egg nests around the village
.complete 10861,1 
.complete 10861,2 
.mob Malevolent Hatchling
step
#questguide << !tbc
.goto Terokkar Forest,31.3,76.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Chief Archaeologist Letoll|r
.accept 10922 >> Accept Digging Through Bones
.target Chief Archaeologist Letoll
step
#questguide << !tbc
>>Follow the |cRXP_FRIENDLY_Explorers|r
.complete 10922,1 
step
#questguide << !tbc
.goto Terokkar Forest,31.0,76.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dwarfowitz|r and |cRXP_FRIENDLY_Commander Ra'vaj|r
.turnin 10922 >> Turn in Digging Through Bones
.accept 10929 >> Accept Fumping
.accept 10913 >> Accept An Improper Burial
.target Dwarfowitz
.target Commander Ra'vaj
step
#questguide << !tbc
.goto Terokkar Forest,31.8,76.3
>>Use the Fumper close to the guards (as soon as your subzone is The Bone Wastes). They will help kill the mobs that spawn.
.complete 10929,1 
.mob Mature Bone Sifter
step
#questguide << !tbc
.goto Terokkar Forest,31.0,76.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dwarfowitz|r
.turnin 10929 >> Turn in Fumping

.target Dwarfowitz
step
#questguide << !tbc
.goto Terokkar Forest,31.0,76.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oakun|r
.accept 10877 >> Accept The Dread Relic
.target Oakun
step
#questguide << !tbc
.goto Terokkar Forest,31.4,75.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scout Navrin|r
.accept 10873 >> Accept Taken in the Night
.target Scout Navrin
step
#questguide << !tbc
.goto Terokkar Forest,36.0,76.1
>>Use the torch in your bags
.complete 10913,1 
.complete 10913,2 
.mob Sha'tar Vindicator
.mob Auchenai Warrior
step
#questguide << !tbc
.goto Terokkar Forest,31.0,76.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Ra'vaj|r
.turnin 10913 >> Turn in An Improper Burial
.accept 10914 >> Accept A Hero Is Needed
.target Commander Ra'vaj
step
#questguide << !tbc
.goto Terokkar Forest,35.1,65.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ha'lei|r
.accept 10227 >> Accept I See Dead Draenei
.target Ha'lei
step
#questguide << !tbc
.goto Terokkar Forest,35.2,66.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Soolaveen|r and |cRXP_FRIENDLY_Ramdor the Mad|r
.turnin 10030 >> Turn in Recover the Bones
.accept 10031 >> Accept Helping the Lost Find Their Way
.turnin 10227 >> Turn in I See Dead Draenei
.accept 10228 >> Accept Ezekiel
.target Soolaveen
.target Ramdor the Mad
step
#questguide << !tbc
.goto Terokkar Forest,37.3,51.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kirrik the Awakened|r
.turnin 10861 >> Turn in Veil Lithic: Preemptive Strike
.accept 10874 >> Accept Veil Shalas: Signal Fires
.target Kirrik the Awakened
step << Hunter tbc
>>Run back to Shattrath and go into a capital city
.train 34074>> Train Aspect of the Viper
step << Hunter tbc
#completewith next
.hs >> Hearth to Allerian Stronghold
step << Hunter tbc
.goto Terokkar Forest,58.1,53.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Taela Everstride|r
.turnin 10035 >> Turn in Torgos!
.isQuestComplete 10035
.target Taela Everstride
step
#questguide << !tbc
#sticky
#label skeletons
.goto Terokkar Forest,50.2,71.7,0
.goto Terokkar Forest,48.1,63.5,0
.goto Terokkar Forest,40.0,77.0,0
>>Kill |cRXP_ENEMY_Broken Skeletons|r
.complete 10031,2 
.mob Broken Skeleton
step << skip
.goto Terokkar Forest,53.8,72.4
>>Start the Skywing escort
.accept 10898 >> Accept Skywing
step << skip
#sticky
.complete 10898,1 
.mob Skywing
step
#questguide << !tbc
.goto Terokkar Forest,56.1,72.4
>>Look for an opening at the base of the tree and climb the spiral ramp inside
.complete 10874,4 
step
#questguide << !tbc
.goto Terokkar Forest,56.6,69.2
>>Run across the bridge and extinguish the next brazier
.complete 10874,3 
step
#questguide << !tbc
.goto Terokkar Forest,55.5,69.8
.complete 10874,2 
step
#questguide << !tbc
.goto Terokkar Forest,55.2,67.2
.complete 10874,1 
step
#questguide << !tbc
>>Kill |cRXP_ENEMY_Arakkoa|r. Loot them for their |cRXP_LOOT_Feathers|r
.collect 25719,30 
step
#questguide << !tbc
.goto Terokkar Forest,49.8,76.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Haylen|r
.accept 10920 >> Accept For the Fallen
step
#questguide << !tbc
.goto Terokkar Forest,52.0,80.1
>>Attack the Webs to free |cRXP_FRIENDLY_Sha'tar Warriors|r. Kill any |cRXP_ENEMY_Dreadfang Widows|r that come out
.complete 10873,1 
.complete 10920,1 
.mob Netherweb Victim
.mob Dreadfang Widow
step
#questguide << !tbc
.goto Terokkar Forest,49.7,76.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Haylen|r
.turnin 10920 >> Turn in For the Fallen
.target Vindicator Haylen
step << Hunter tbc / Warlock tbc
.goto Terokkar Forest,49.7,76.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Haylen|r
.accept 10921 >> Accept Terokkarantula
.target Vindicator Haylen
step << Hunter tbc / Warlock tbc
.goto Terokkar Forest,54.2,81.8
>>This elite quest can be very difficult to solo (the mob has 45k hp, runs very fast and is not slowable), skip if you have to
>>Kill |cRXP_ENEMY_Terokkarantula|r
.complete 10921,1 
.mob Terokkarantula
step
#questguide << !tbc
.goto Terokkar Forest,49.7,76.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Haylen|r
.turnin 10921 >> Turn in Terokkarantula
.isQuestComplete 10921
.target Vindicator Haylen
step
#questguide << !tbc
.goto Terokkar Forest,49.7,76.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Haylen|r
.accept 10926 >> Accept Return to Sha'tari Base Camp
.isQuestTurnedIn 10921
.target Vindicator Haylen
step
#questguide << !tbc
#sticky
#completewith next
.goto Terokkar Forest,40.0,79.0
>>Kill |cRXP_ENEMY_Lost Spirits|r
.complete 10031,1 
.mob Lost Spirit
step
#questguide << !tbc
.goto Terokkar Forest,44.0,76.5
>>Loot the chest next to the broken wagon
>>Once you open the chest, a bunch of slow moving mobs will spawn around it, just run away from it
.complete 10877,1 
step
#questguide << !tbc
#label spirits
.goto Terokkar Forest,40.0,79.0
>>Kill |cRXP_ENEMY_Lost Spirits|r
.complete 10031,1 
.mob Lost Spirit
step
#questguide << !tbc
#requires skeletons
.goto Terokkar Forest,36.2,74.7
>>Kill |cRXP_ENEMY_Auchenai Initiates|r and |cRXP_ENEMY_Auchenai Doomsayers|r
.complete 10914,1 
.complete 10914,2 
.mob Auchenai Initiate
.mob Auchenai Doomsayer
step
#questguide << !tbc
.goto Terokkar Forest,31.4,75.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scout Navrin|r
.turnin 10873 >> Turn in Taken in the Night
.target Scout Navrin
step
#questguide << !tbc
.goto Terokkar Forest,31.4,75.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scout Navrin|r
.turnin 10926 >> Turn in Return to Sha'tari Base Camp
.isOnQuest 10926
.target Scout Navrin
step
#questguide << !tbc
.goto Terokkar Forest,31.1,76.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scout Oakun|r
.turnin 10877 >> Turn in The Dread Relic
.accept 10923 >> Evil Draws Near
.target Oakun
step
#questguide << !tbc
.goto Terokkar Forest,31.0,76.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Ra'vaj|r
.turnin 10914 >> Turn in A Hero Is Needed
.accept 10915 >> Accept The Fallen Exarch
.target Commander Ra'vaj
step
#questguide << !tbc
.goto Terokkar Forest,35.7,65.7
.complete 10915,1 
step
#questguide << !tbc
.goto Terokkar Forest,31.0,76.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Ra'vaj|r
.turnin 10915 >> Turn in The Fallen Exarch
.target Commander Ra'vaj
step
#questguide << !tbc
.goto Terokkar Forest,37.0,49.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Soolaveen|r
.turnin 10031 >> Turn in Helping the Lost Find Their Way
.target Soolaveen
step
#questguide << !tbc
.goto Terokkar Forest,37.4,51.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kirrik the Awakened|r
.turnin 10874 >> Turn in Veil Shalas: Signal Fires
.accept 10889 >> Accept Return to Shattrath
.target Kirrik the Awakened
step << Shaman tbc
#completewith next
.hs >> Hearth to Allerian Stronghold
step << !Hunter tbc
.goto Terokkar Forest,58.1,53.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Taela Everstride|r
.turnin 10035 >> Turn in Torgos!
.isQuestComplete 10035
.target Taela Everstride
step << !Hunter tbc
.abandon 10035 >> Abandon Torgos! If you skipped it
step << !Hunter tbc
#completewith next
.goto Terokkar Forest,59.44,55.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Furnan Skysoar|r
.fly Shattrath >> Fly to Shattrath City
.target Furnan Skysoar

step << Hunter/!tbc
.goto Terokkar Forest,44.33,26.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthbinder Tavgren|r
.turnin 10005 >> Turn in Letting Earthbinder Tavgren Know
.isOnQuest 10005
.target Earthbinder Tavgren
step << tbc/wotlk
#aldor
.goto Shattrath City,28.3,49.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Minalei|r
.home >> Set your Hearthstone to Shattrath City
.target Minalei
step << tbc/wotlk
#scryer
.goto Shattrath City,56.3,81.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Haelthol|r
.home >> Set your Hearthstone to Shattrath City
.target Innkeeper Haelthol
step
#questguide << !tbc
.isOnQuest 10228
.goto Shattrath City,51.2,34.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ezekiel|r. He walks around the city inner ring
.turnin 10228 >> Turn in Ezekiel
.accept 10231 >> Accept What Book? I Don't See Any Book.
.target Ezekiel
step << skip
#scryer
.goto Shattrath City,54.60,44.68
.accept 10553 >>Accept Voren'thal the Seer
step
#scryer
.goto Shattrath City,45.30,81.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Magistrix Fyalenn|r
.accept 10412 >>Accept Firewing Signets
.turnin 10412 >>Turn in Firewing Signets
.target Magistrix Fyalenn
step
#scryer
.goto Shattrath City,42.95,91.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Voren'thal the Seer|r
.turnin 10553 >>Turn in Voren'thal the Seer
.target Voren'thal the Seer
step << skip
#scryer
.goto Shattrath City,47.01,83.30
.accept 10169 >>Accept Losing Gracefully
step << skip
#scryer
.goto Shattrath City,61.31,51.46
>>Click on Haronem's Regiment Cooking Pot
.turnin 10169 >>Turn in Losing Gracefully
step
#questguide << !tbc
.isOnQuest 10231
.goto Shattrath City,43.6,29.6
>>Attack |cRXP_ENEMY_"Dirty" Larry|r until he turns Friendly
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_"Dirty" Larry|r
>>|cRXP_WARN_This quest is hard, try to get help from someone or skip if you have to|r
.complete 10231,1 
.turnin 10231 >> Turn in What Book? I Don't See Any Book.
.target "Dirty" Larry
step
#questguide << !tbc
.goto Shattrath City,43.6,29.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_"Dirty" Larry|r
.accept 10251 >> Accept The Master's Grand Design?
.isQuestTurnedIn 10231
.target "Dirty" Larry
step
#questguide << !tbc
.goto Shattrath City,52.5,20.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rilak the Redeemed|r
.turnin 10898 >> Turn in Skywing
.isQuestComplete 10898
.target Rilak the Redeemed
step
#questguide << !tbc
.isOnQuest 10889
.goto Shattrath City,52.5,20.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rilak the Redeemed|r
.turnin 10889 >> Turn in Return to Shattrath
.target Rilak the Redeemed
step
#questguide << !tbc
.isQuestTurnedIn 10879
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rilak the Redeemed|r
.goto Shattrath City,52.0,20.8
.accept 10879 >> Accept The Skettis Offensive
.target Rilak the Redeemed
step
#questguide << !tbc
.isOnQuest 10879
>>Survive the waves of bird attacks and kill the big bird at the end
.complete 10879,1 
>>This quest can be hard, skip if you have to
step
#questguide << !tbc
.goto Shattrath City,52.2,20.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rilak the Redeemed|r
.turnin 10879 >> Turn in The Skettis Offensive
.isQuestComplete 10879
.target Rilak the Redeemed
step
#questguide << !tbc
#aldor
.isQuestComplete 10024
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arcanist Adyria|r
.goto Shattrath City,54.9,22.4
.turnin 10024 >> Turn in Voren'thal's Visions
.target Arcanist Adyria
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vekax|r
.goto Shattrath City,52.3,16.6
.accept 10917 >> Accept The Outcast's Plight
.turnin 10917 >> Turn in The Outcast's Plight
.itemcount 25719,30 
.target Vekax
step << !Hunter tbc
.goto Terokkar Forest,44.33,26.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthbinder Tavgren|r
.turnin -10005 >> Turn in Letting Earthbinder Tavgren Know
.target Earthbinder Tavgren
step << Mage (tbc/wotlk)
.cast 3561 >> Teleport to Stormwind
.zone Stormwind City >> Arrive in Stormwind
step << (tbc/wotlk) (Warlock/Shaman/Paladin)
.goto Shattrath City,55.7,36.9
.zone Stormwind City >> Take the portal to Stormwind
step << (tbc/wotlk) (Warlock/Shaman/Paladin/Mage)
.goto StormwindClassic,25.3,78.7 << Warlock
.goto StormwindClassic,38.6,32.8 << Paladin
.goto StormwindClassic,61.9,84.0 << Shaman
.goto StormwindClassic,39.6,79.6 << Mage
.target Farseer Umbrua << Shaman
.target Elsharin << Mage
.target Jennea Cannon << Mage
.target Arthur the Faithful << Paladin
.target Katherine the Pure << Paladin
.target Lord Grayson Shadowbreaker << Paladin
.target Ursula Deline << Warlock
.target Demisette Cloyce << Warlock
.target Sandahl << Warlock
.trainer >> Train your class spells
step << (tbc/wotlk) (Warrior/Hunter/Rogue/Priest)
.goto Shattrath City,55.2,36.5
.zone Darnassus >> Take the portal to Darnassus
step << (tbc/wotlk) (Warrior/Hunter/Rogue/Priest)
.goto Darnassus,39.0,83.2 << Priest
.goto Darnassus,40.6,9.2 << Hunter
.goto Darnassus,31.5,17.4 << Rogue
.goto Darnassus,58.75,35.16 << Warrior
.trainer >> Train your class spells
.target Jandria << Priest
.target Jocaste << Hunter
.target Anishar << Rogue
.target Erion Shadewhisper << Rogue
.target Syurna << Rogue
.target Arias'ta Bladesinger << Warrior
step << Druid (tbc/wotlk)
>>Teleport to Moonglade
.goto Moonglade,52.4,40.6
.trainer 12042 >> Train your class spells
.target Loganaar << Druid
step << DK (tbc/wotlk)
#completewith next
.cast 50977 >> Cast Death Gate
.zoneskip Eastern Plaguelands
step << DK (tbc/wotlk)
.goto Eastern Plaguelands,80.3,48.0
>>Go through the Death Gate
.trainer >> Train your class spells from Amal'thazad in Acherus
.target Amal'thazad
step << tbc/wotlk
#completewith next
.hs >> Hearth to Shattrath City
step << tbc/wotlk
.zone Shattrath City >> Arrive in Shattrath City
.zoneskip Nagrand
step
#aldor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Adyen the Lightwarden|r
.goto Shattrath City,30.72,34.63
.accept 10325 >> Accept Marks of Kil'jaeden
.turnin 10325 >> Turn in Marks of Kil'jaeden
.target Adyen the Lightwarden
.itemcount 29425,10
step
#aldor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ishanah|r
.goto Shattrath City,23.98,29.74
.turnin 10021 >> Turn in Restoring the Light
.target Ishanah
]])
RXPGuides.RegisterGuide([[
#version 5
#cata
#Cata
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 64-66 Nagrand
#defaultfor !wotlk
#version 5
#next 65-67 Blade's Edge
#xprate <1.5 << tbc/wotlk
step << !tbc !wotlk
.goto 1955/530,5362.10010,-1832.90002
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Haggard War Veteran|r
.target Haggard War Veteran
.accept 10210 >>Accept A'dal
step << !tbc !wotlk
.goto 1955/530,5426.70020,-1862.70007
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_A'dal|r
.target A'dal
.turnin 10210 >>Turn in A'dal
step << !tbc !wotlk
.goto 1955/530,5421.80029,-1859.00000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Khadgar's Servant|r
.target Khadgar
.accept 10211 >>Accept City of Light
.timer 462,City of Light RP
step << !tbc !wotlk
.goto Shattrath City,50.36,42.87
>>Follow |cRXP_FRIENDLY_Khadgar's Servant|r << wotlk
>>Head up to the second floor with |cRXP_FRIENDLY_G'eras|r and wait out the RP. If someone elses |cRXP_FRIENDLY_Khadgar's Servant|r arrives in the meantime, you can target it and it will complete the quest for you. If the quest fails, abandon it, accept the quest from |cRXP_FRIENDLY_Khadgar's Servant|r again, then follow the |cRXP_FRIENDLY_Khadgar's Servant|r around << tbc
.complete 10211,1 
.target Khadgar's Servant
step << Mage !tbc !wotlk
.goto Shattrath City,58.77,47.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Iorioa|r
.train 35715 >> Train Teleport: Shattrath and Portal: Shattrath
.target Iorioa
step << !tbc !wotlk
.goto Shattrath City,54.74,44.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Khadgar's Servant|r
.turnin 10211 >> Turn in City of Light
.target Khadgar
step << !tbc !wotlk
.goto Shattrath City,54.74,44.32
.accept 10551 >>Allegiance to the Aldor
.turnin 10551>>Talk to |cRXP_FRIENDLY_Khadgar|r. Pledge your Allegiance to the Aldor
.target Khadgar
step << !tbc !wotlk
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Khadgar's Servant|r
.goto Shattrath City,54.74,44.32
.accept 10554 >> Accept Ishanah
.target Khadgar
step << Rogue !tbc !wotlk
.goto 1955/530,5357.10010,-1880.09998
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ifram|r
.trainer >>Train your class spells
.target Windstalker Ifram
step << Shaman !tbc !wotlk
.goto 1955/530,5367.80029,-1890.09998
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Luknar|r
.trainer >>Train your class spells
.target Luknar
step << Warlock !tbc !wotlk
.goto 1955/530,5371.10010,-1892.59998
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fel-Caller Guloto|r
.trainer >>Train your class spells
.target Fel-Caller Guloto
step << Mage !tbc !wotlk
.goto 1955/530,5412.70020,-1792.70007
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Raluhi|r
.trainer >>Train your class spells
.target Raluhi
step << Priest !tbc !wotlk
.goto 1955/530,5409.20020,-1789.70007
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Salha|r
.trainer >>Train your class spells
.target Salha
step << Paladin !tbc !wotlk
.goto 1955/530,5402.50000,-1796.59998
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ordo|r
.trainer >>Train your class spells
.target Ordo
step << Warrior !tbc !wotlk
.goto 1955/530,5399.89990,-1798.59998
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bratu|r
.trainer >>Train your class spells
.target Bratu
step << Hunter !tbc !wotlk
.goto 1955/530,5403.10010,-1800.59998
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Irva|r
.trainer >>Train your class spells
.target Irva
step << !tbc !wotlk
.goto 1955/530,5821.60010,-1732.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ishanah|r
.target Ishanah
.turnin 10554 >>Turn in Ishanah
step
#aldor
.goto Shattrath City,21.62,50.35,30,0
.goto Nagrand,78.23,54.62
.zone Nagrand >> Travel to Aldor Rise. Take the backdoor to Nagrand
.skill riding,<225,1
step
#scryer
.goto Shattrath City,21.62,50.35,30,0
.goto Nagrand,78.23,54.62
.zone Nagrand >> Travel to Aldor Rise. Take the backdoor to Nagrand
>>Make sure to avoid the |cRXP_WARN_Aldor Vindicators|r that roam the area, if they engage you, you will get teleported out of the Aldor Rise, you can spot them by hovering your mouse over them
.skill riding,<225,1
.target Aldor Vindicator
step << !tbc
#completewith Wazat
.goto Nagrand,61.6,67.0
.zone Nagrand >> Travel to Nagrand
.skill riding,225,1
step
#completewith next
>>Kill |cRXP_ENEMY_Wild Elekks|r. Loot them for their |cRXP_LOOT_Tusks|r
.collect 25463,3,9914,1 
.mob Wild Elekk
step
#label Wazat
.goto Nagrand,61.70,67.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wazat|r
.accept 10109 >> Accept I Must Have Them!
.target Wazat
step
#optional
.goto Nagrand,55.05,70.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Huntress Bintook|r
.accept 9917 >> Accept Do My Eyes Deceive Me
.reputation 978,neutral,0,1
.target Huntress Bintook
step
#optional
.goto Nagrand,62.89,73.28,40,0
.goto Nagrand,62.74,71.49
>>Kill |cRXP_ENEMY_Boulderfist Ogres|r. Loot them for their |cRXP_LOOT_Plans|r
.complete 9917,1 
.mob Boulderfist Hunter
.reputation 978,neutral,0,1
step
#optional
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Huntress Bintook|r
.goto Nagrand,55.05,70.54
.turnin 9917 >> Turn in Do My Eyes Deceive Me
.accept 9918 >> Accept Not On My Watch!
.reputation 978,neutral,0,1
.target Huntress Bintook
step
#optional
.goto Nagrand,62.74,71.48
>>Damage |cRXP_ENEMY_Lump|r to 30% or less health
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lump|r
.skipgossip
.complete 9918,1 
.target Lump
.reputation 978,neutral,0,1
step
#optional
.goto Nagrand,55.05,70.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Huntress Bintook|r
.turnin 9918 >> Turn in Not On My Watch!
.target Huntress Bintook
.isQuestComplete 9918
step
.goto 1951/530,7253.600,-2557.800
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Huntress Bintook|r
.target Huntress Bintook
.accept 9917 >>Accept Do My Eyes Deceive Me
step
.goto 1951/530,7259.100,-2551.100
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_"Shotgun" Jones|r
.target "Shotgun" Jones
.accept 10113 >>Accept The Nesingwary Safari
step
.goto 1951/530,7229.100,-2492.000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elementalist Ioki|r
.target Elementalist Ioki
.accept 9869 >>Accept The Throne of the Elements
step
.goto 1951/530,7273.300,-2567.000
>>Click the |cRXP_FRIENDLY_Telaar Bulletin Board|r
.accept 9936 >>Accept Wanted: Giselda the Crone
.accept 9940 >>Accept Wanted: Zorbo the Advisor
step
.goto 1951/530,7286.100,-2613.300
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Otonbu the Sage|r
.target Otonbu the Sage
.accept 9874 >>Accept Stopping the Spread
step
.goto 1951/530,7287.600,-2623.400
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Poli'lukluk the Wiser|r
.target Poli'lukluk the Wiser
.accept 9878 >>Accept Solving the Problem
step
#completewith BPlans
.goto Nagrand,54.21,76.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Caregiver Isel|r
.home >> Set your Hearthstone to Telaar
.target Caregiver Isel
step
.goto Nagrand,54.17,75.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Furgu|r on the balcony at the top of the building
.fp Telaar >> Get the Telaar flight path
.target Furgu
step
#optional
#completewith Staghoofs
.use 24504 >>Kill |cRXP_ENEMY_Dust Howlers|r. Loot them for their |cRXP_LOOT_Elemental Gas|r and |cRXP_LOOT_Howling Wind|r. Click the |T135988:0|t[Howling Wind] in your bags
.complete 10109,1 
.collect 24504,1,9861 
.accept 9861 >> Accept The Howling Wind
.mob Dust Howler
step
#label BPlans
.goto Nagrand,62.89,73.28,40,0
.goto Nagrand,62.74,71.49
>>Kill |cRXP_ENEMY_Boulderfist Ogres|r. Loot them for their |cRXP_LOOT_Plans|r
.complete 9917,1 
.mob Boulderfist Hunter
step
#completewith Throne1
>>Kill |cRXP_ENEMY_Wild Elekks|r. Loot them for their |cRXP_LOOT_Tusks|r
.collect 25463,3,9914,1 
.mob Wild Elekk
step
#sticky
#hidewindow
#label saved1a
#completewith Safari1
.subzone 3673 >> 1
step
#requires saved1a
#completewith Safari1
>>Sometimes |cRXP_ENEMY_Gankly|r can appear at the Safari. This is a rare event
>>Kill |cRXP_ENEMY_Gankly|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kristen Dipswitch|r
.accept 9897 >> Accept I'm Saved!
.goto Nagrand,71.42,40.60,0
.unitscan Gankly Rottenfist
.target Kristen Dipswitch
step
#label Safari1
>>Travel to the Nesingwary Safari
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shado 'Fitz' Farstrider|r, |cRXP_FRIENDLY_Harold Lane|r and |cRXP_FRIENDLY_Hemet Nesingwary|r
.turnin 10113 >>Turn in The Nesingwary Safari
.accept 9854 >>Accept Windroc Mastery
.goto Nagrand,71.57,40.52,-1
.target +Shado 'Fitz' Farstrider
.accept 9857 >>Accept Talbuk Mastery
.goto Nagrand,71.38,40.62,-1
.target +Harold Lane
.accept 9789 >>Accept Clefthoof Mastery
.goto Nagrand,71.52,40.82,-1
.target +Hemet Nesingwary
step
#optional
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harold Lane|r
.turnin 9897 >> Turn in I'm Saved!
.target Harold Lane
.goto Nagrand,71.38,40.62
.isOnQuest 9897
step
#completewith Throne1
.goto Nagrand,70.22,38.37,60,0
.goto Nagrand,68.58,40.18,60,0
.goto Nagrand,62.42,35.46,60,0
>>Kill |cRXP_ENEMY_Windrocs|r
.complete 9854,1 
.mob Windroc
.subzoneskip 3614
.subzoneskip 3615
step
#label Throne1
.goto 1951/530,6945.300,-793.900
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elementalist Untrag|r
.target Elementalist Untrag
.accept 9818 >>Accept The Underneath
step
.goto 1951/530,6936.700,-783.600
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elementalist Lo'ap|r
.target Elementalist Lo'ap
.accept 9800 >>Accept A Rare Bean
.accept 9815 >>Accept Muck Diving
step
.goto 1951/530,6944.600,-773.100
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elementalist Sharvak|r
.target Elementalist Sharvak
.turnin 9869 >>Turn in The Throne of the Elements
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elementalist Morgh|r
.turnin 9861 >> Turn in The Howling Wind
.accept 9862 >>Accept Murkblood Corrupters
.goto Nagrand,60.50,22.37
.isOnQuest 9861
.target Elementalist Morgh
step
#optional
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elementalist Morgh|r
.accept 9862 >>Accept Murkblood Corrupters
.goto Nagrand,60.50,22.37
.isQuestTurnedIn 9861
.target Elementalist Morgh
step
#loop
.goto Nagrand,62.19,22.60,50,0
.goto Nagrand,61.99,22.09,50,0
.goto Nagrand,61.28,22.24,50,0
.goto Nagrand,60.88,21.39,50,0
.goto Nagrand,60.38,20.88,50,0
.goto Nagrand,59.87,21.32,50,0
.goto Nagrand,59.58,22.48,50,0
.goto Nagrand,60.08,24.41,50,0
.goto Nagrand,60.57,25.04,50,0
.goto Nagrand,61.15,24.92,50,0
.goto Nagrand,61.72,24.54,50,0
.line Nagrand,62.19,22.60,61.99,22.09,61.28,22.24,60.88,21.39,60.38,20.88,59.87,21.32,59.58,22.48,60.08,24.41,60.57,25.04,61.15,24.92,61.72,24.54,62.19,22.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gordawg|r patrolling clockwise at the Throne of the Elements
.turnin 9818 >>Turn in The Underneath
.accept 9819 >>Accept The Tortured Earth
.unitscan Gordawg
step
#optional
#completewith Throne2
>>Kill |cRXP_ENEMY_Wild Elekks|r. Loot them for their |cRXP_LOOT_Tusks|r
.collect 25463,3,9914,1 
.mob Wild Elekk
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Tortured Earth Spirits|r usually near small hills or the base of the mountain
.complete 9819,1 
.mob Tortured Earth Spirit
step
#loop
.goto Nagrand,62.64,48.31,60,0
.goto Nagrand,62.42,35.46,60,0
.goto Nagrand,68.58,40.18,60,0
.goto Nagrand,70.22,38.37,60,0
.goto Nagrand,62.64,48.31,0
.goto Nagrand,62.42,35.46,0
.goto Nagrand,68.58,40.18,0
.goto Nagrand,70.22,38.37,0
>>Kill |cRXP_ENEMY_Windrocs|r
.complete 9854,1 
.mob Windroc
step
#optional
#completewith next
.goto Nagrand,62.42,35.46,60,0
.goto Nagrand,66.64,38.34,60,0
>>Kill |cRXP_ENEMY_Talbuk Stags|r and |cRXP_ENEMY_Clefthoofs|r
.complete 9857,1 
.mob +Talbuk Stag
.complete 9789,1 
.mob +Clefthoof
step
#loop
.goto Nagrand,65.00,51.32,60,0
.goto Nagrand,61.94,54.94,60,0
.goto Nagrand,65.00,51.32,0
.goto Nagrand,61.94,54.94,0
>>Kill |cRXP_ENEMY_Tortured Earth Spirits|r
.complete 9819,1 
.mob Tortured Earth Spirit
step
#label Staghoofs
#loop
.line Nagrand,57.61,60.98,59.50,58.79,61.32,62.32,70.43,56.50,65.39,63.76,71.13,62.77,70.44,72.05,66.97,75.29,66.01,67.94,57.61,60.98
.goto Nagrand,57.61,60.98,60,0
.goto Nagrand,59.50,58.79,60,0
.goto Nagrand,61.32,62.32,60,0
.goto Nagrand,70.43,56.50,60,0
.goto Nagrand,65.39,63.76,60,0
.goto Nagrand,71.13,62.77,60,0
.goto Nagrand,70.44,72.05,60,0
.goto Nagrand,66.97,75.29,60,0
.goto Nagrand,66.01,67.94,60,0
.goto Nagrand,57.61,60.98,60,0
>>Kill |cRXP_ENEMY_Talbuk Stags|r and |cRXP_ENEMY_Clefthoofs|r
.complete 9857,1 
.mob +Talbuk Stag
.complete 9789,1 
.mob +Clefthoof
step
.goto Nagrand,66.11,62.07,60,0
.goto Nagrand,68.76,63.70,60,0
.goto Nagrand,67.52,65.69,60,0
.goto Nagrand,66.10,72.83,60,0
.goto Nagrand,67.50,74.48,60,0
.goto Nagrand,60.33,63.82,60,0
.goto Nagrand,60.85,61.08,60,0
.goto Nagrand,62.41,59.43,60,0
.goto Nagrand,66.11,62.07,60,0
.goto Nagrand,68.76,63.70,60,0
.goto Nagrand,67.52,65.69,60,0
.goto Nagrand,66.10,72.83,60,0
.goto Nagrand,67.50,74.48,60,0
.goto Nagrand,60.33,63.82,60,0
.goto Nagrand,60.85,61.08,60,0
.goto Nagrand,62.41,59.43
.use 24504 >>Kill |cRXP_ENEMY_Dust Howlers|r. Loot them for their |cRXP_LOOT_Elemental Gas|r and |cRXP_LOOT_Howling Wind|r. Click the |T135988:0|t[Howling Wind] in your bags
.complete 10109,1 
.collect 24504,1,9861 
.accept 9861 >> Accept The Howling Wind
.unitscan Dust Howler
step
#sticky
#hidewindow
#label saved2a
#completewith Safari1
.subzone 3673 >> 1
step
#requires saved2a
#completewith Safari2
>>Sometimes |cRXP_ENEMY_Gankly|r can appear at the Safari. This is a rare event
>>Kill |cRXP_ENEMY_Gankly|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kristen Dipswitch|r
.accept 9897 >> Accept I'm Saved!
.goto Nagrand,71.42,40.60,0
.unitscan Gankly Rottenfist
.target Kristen Dipswitch
step
#label Safari2
>>Return to the Safari
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shado 'Fitz' Farstrider|r, |cRXP_FRIENDLY_Hemet Nesingwary|r and |cRXP_FRIENDLY_Harold Lane|r
.turnin 9854 >>Turn in Windroc Mastery
.accept 9855 >>Accept Windroc Mastery
.target +Shado 'Fitz' Farstrider
.goto Nagrand,71.57,40.52
.turnin 9789 >>Turn in Clefthoof Mastery
.accept 9850 >>Accept Clefthoof Mastery
.target +Hemet Nesingwary
.goto Nagrand,71.52,40.82
.turnin 9857 >>Turn in Talbuk Mastery
.accept 9858 >>Accept Talbuk Mastery
.target +Harold Lane
.goto Nagrand,71.38,40.62
step
#optional
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harold Lane|r
.turnin 9897 >> Turn in I'm Saved!
.target Harold Lane
.goto Nagrand,71.38,40.62
.isOnQuest 9897
step
#label Throne2
.goto Nagrand,62.19,22.60,50,0
.goto Nagrand,61.99,22.09,50,0
.goto Nagrand,61.28,22.24,50,0
.goto Nagrand,60.88,21.39,50,0
.goto Nagrand,60.38,20.88,50,0
.goto Nagrand,59.87,21.32,50,0
.goto Nagrand,59.58,22.48,50,0
.goto Nagrand,60.08,24.41,50,0
.goto Nagrand,60.57,25.04,50,0
.goto Nagrand,61.15,24.92,50,0
.goto Nagrand,61.72,24.54
.line Nagrand,62.19,22.60,61.99,22.09,61.28,22.24,60.88,21.39,60.38,20.88,59.87,21.32,59.58,22.48,60.08,24.41,60.57,25.04,61.15,24.92,61.72,24.54,62.19,22.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gordawg|r patrolling clockwise at the Throne of the Elements
.turnin 9819 >>Turn in The Tortured Earth
.accept 9821 >>Accept Eating Damnation
.unitscan Gordawg
step
#completewith Caracoli
.destroy 24475 >> You can delete |T135241:0|t[Gordawg's Imprint] from your bags. It's no longer needed
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elementalist Morgh|r
.turnin 9861 >> Turn in The Howling Wind
.accept 9862 >>Accept Murkblood Corrupters
.goto Nagrand,60.50,22.37
.isOnQuest 9861
.target Elementalist Morgh
step
#optional
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elementalist Morgh|r
.accept 9862 >>Accept Murkblood Corrupters
.goto Nagrand,60.50,22.37
.isQuestTurnedIn 9861
.target Elementalist Morgh
step
#optional
#completewith Gordawg3
>>Kill |cRXP_ENEMY_Wild Elekks|r. Loot them for their |cRXP_LOOT_Tusks|r
.collect 25463,3,9914,1 
.mob Wild Elekk
step
#completewith Dung
#optional
>>Kill |cRXP_ENEMY_Clefthoof Bulls|r and |cRXP_ENEMY_Talbuk Thorngrazers|r
.complete 9850,1,20 
.mob +Clefthoof Bull
.complete 9858,1 
.mob +Talbuk Thorngrazer
step
#completewith eccore
>>Loot the |cRXP_PICK_Digested Caracoli|r dung on the ground
.complete 9800,1 
step
#label eccore
#loop
.goto Nagrand,56.76,18.16,60,0
.goto Nagrand,55.16,20.27,60,0
.goto Nagrand,51.36,19.50,60,0
.goto Nagrand,48.73,18.92,60,0
.goto Nagrand,56.76,18.16,60,0
.goto Nagrand,55.16,20.27,60,0
.goto Nagrand,51.36,19.50,60,0
.goto Nagrand,48.73,18.92,60,0

.goto Nagrand,56.76,18.16,0
.goto Nagrand,55.16,20.27,0
.goto Nagrand,51.36,19.50,0
.goto Nagrand,48.73,18.92,0
.goto Nagrand,56.76,18.16,0
.goto Nagrand,55.16,20.27,0
.goto Nagrand,51.36,19.50,0
.goto Nagrand,48.73,18.92,0
>>Kill |cRXP_ENEMY_Enraged Crushers|r. Loot them for their |cRXP_LOOT_Cores|r
.complete 9821,1 
.mob Enraged Crusher
step
#label Dung
#loop
.line Nagrand,53.23,28.38,53.12,25.86,54.63,23.85,57.92,23.11,57.71,20.88,55.71,20.76,52.57,22.34,50.79,19.94,51.26,24.12,51.50,26.70,50.31,27.35,48.83,27.92,46.77,28.29,47.42,33.33,53.23,28.38
.goto Nagrand,53.23,28.38,60,0
.goto Nagrand,53.12,25.86,60,0
.goto Nagrand,54.63,23.85,60,0
.goto Nagrand,57.92,23.11,60,0
.goto Nagrand,57.71,20.88,60,0
.goto Nagrand,55.71,20.76,60,0
.goto Nagrand,52.57,22.34,60,0
.goto Nagrand,50.79,19.94,60,0
.goto Nagrand,51.26,24.12,60,0
.goto Nagrand,51.50,26.70,60,0
.goto Nagrand,50.31,27.35,60,0
.goto Nagrand,48.83,27.92,60,0
.goto Nagrand,46.77,28.29,60,0
.goto Nagrand,47.42,33.33,60,0
.goto Nagrand,53.23,28.38,60,0
>>Loot the |cRXP_PICK_Digested Caracoli|r dung on the ground
.complete 9800,1 
step
.goto Nagrand,60.81,22.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elementalist Lo'ap|r
.turnin 9800 >>Turn in A Rare Bean
.accept 9804 >>Accept Agitated Spirits of Skysong
.target Elementalist Lo'ap
step
.goto Nagrand,62.19,22.60,50,0
.goto Nagrand,61.99,22.09,50,0
.goto Nagrand,61.28,22.24,50,0
.goto Nagrand,60.88,21.39,50,0
.goto Nagrand,60.38,20.88,50,0
.goto Nagrand,59.87,21.32,50,0
.goto Nagrand,59.58,22.48,50,0
.goto Nagrand,60.08,24.41,50,0
.goto Nagrand,60.57,25.04,50,0
.goto Nagrand,61.15,24.92,50,0
.goto Nagrand,61.72,24.54
.line Nagrand,62.19,22.60,61.99,22.09,61.28,22.24,60.88,21.39,60.38,20.88,59.87,21.32,59.58,22.48,60.08,24.41,60.57,25.04,61.15,24.92,61.72,24.54,62.19,22.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gordawg|r patrolling clockwise at the Throne of the Elements
.turnin 9821 >>Turn in Eating Damnation
.unitscan Gordawg
.isQuestComplete 9821
step
#questguide << !tbc
#label Gordawg3
.goto Nagrand,62.19,22.60,50,0
.goto Nagrand,61.99,22.09,50,0
.goto Nagrand,61.28,22.24,50,0
.goto Nagrand,60.88,21.39,50,0
.goto Nagrand,60.38,20.88,50,0
.goto Nagrand,59.87,21.32,50,0
.goto Nagrand,59.58,22.48,50,0
.goto Nagrand,60.08,24.41,50,0
.goto Nagrand,60.57,25.04,50,0
.goto Nagrand,61.15,24.92,50,0
.goto Nagrand,61.72,24.54
.line Nagrand,62.19,22.60,61.99,22.09,61.28,22.24,60.88,21.39,60.38,20.88,59.87,21.32,59.58,22.48,60.08,24.41,60.57,25.04,61.15,24.92,61.72,24.54,62.19,22.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gordawg|r patrolling clockwise at the Throne of the Elements
.accept 9849 >>Accept Shattering the Veil
.unitscan Gordawg
.isQuestTurnedIn 9821
step << !Warlock
#completewith next
.cast 31920 >> Use the |T133999:0|t[Nagrand Cherry] in your bags
.use 24421
step
.goto Nagrand,61.62,29.65,60,0
.goto Nagrand,60.41,27.38,60,0
.goto Nagrand,59.40,27.55,60,0
.goto Nagrand,54.80,25.90,60,0
.goto Nagrand,61.62,29.65,60,0
.goto Nagrand,60.41,27.38,60,0
.goto Nagrand,59.40,27.55,60,0
.goto Nagrand,54.80,25.90
.use 24421 >>Kill |cRXP_ENEMY_Lake Spirits|r
.complete 9804,1 
.mob Lake Spirit
step
.goto Nagrand,60.81,22.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elementalist Lo'ap|r
.turnin 9804 >>Turn in Agitated Spirits of Skysong
.accept 9805 >>Accept Blessing of Incineratus
.target Elementalist Lo'ap
step
#optional
#completewith Telaar2
>>Kill |cRXP_ENEMY_Wild Elekks|r. Loot them for their |cRXP_LOOT_Tusks|r
.collect 25463,3,9914,1 
.mob Wild Elekk
step
#optional
#completewith ThorngrazersEnd
>>Kill |cRXP_ENEMY_Clefthoof Bulls|r
.complete 9850,1 
.mob Clefthoof Bull
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Talbuk Thorngrazers|r
.complete 9858,1 
.mob Talbuk Thorngrazer
step
.goto Nagrand,47.37,34.95,60,0
.goto Nagrand,46.08,33.41,60,0
.goto Nagrand,42.95,30.75,60,0
.goto Nagrand,41.16,26.99,60,0
.goto Nagrand,40.03,26.17,60,0
.goto Nagrand,38.03,27.55,60,0
.goto Nagrand,36.34,26.96,60,0
.goto Nagrand,35.40,25.60,60,0
.goto Nagrand,34.49,21.76,60,0
.goto Nagrand,33.78,20.12,60,0
.goto Nagrand,40.03,26.17
.line Nagrand,47.37,34.95,46.08,33.41,42.95,30.75,41.16,26.99,40.03,26.17,38.03,27.55,36.34,26.96,35.40,25.60,34.49,21.76,33.78,20.12
.use 24559 >>Kill the |cRXP_ENEMY_Murkblood Invaders|r. Loot them for their |cRXP_LOOT_Plans|r. Click the |T134269:0|t[Murkblood Invasion Plans] in your bags
.collect 24559,1,9871 
.accept 9871 >>Accept Murkblood Invaders
.unitscan Murkblood Invader
step
#label ThorngrazersEnd
#loop
.line Nagrand,53.23,28.38,53.12,25.86,54.63,23.85,57.92,23.11,57.71,20.88,55.71,20.76,52.57,22.34,50.79,19.94,51.26,24.12,51.50,26.70,50.31,27.35,48.83,27.92,46.77,28.29,47.42,33.33,53.23,28.38
.goto Nagrand,53.23,28.38,60,0
.goto Nagrand,53.12,25.86,60,0
.goto Nagrand,54.63,23.85,60,0
.goto Nagrand,57.92,23.11,60,0
.goto Nagrand,57.71,20.88,60,0
.goto Nagrand,55.71,20.76,60,0
.goto Nagrand,52.57,22.34,60,0
.goto Nagrand,50.79,19.94,60,0
.goto Nagrand,51.26,24.12,60,0
.goto Nagrand,51.50,26.70,60,0
.goto Nagrand,50.31,27.35,60,0
.goto Nagrand,48.83,27.92,60,0
.goto Nagrand,46.77,28.29,60,0
.goto Nagrand,47.42,33.33,60,0
.goto Nagrand,53.23,28.38,60,0
>>Kill |cRXP_ENEMY_Talbuk Thorngrazers|r
.complete 9858,1 
.mob Talbuk Thorngrazer
step
#loop
.line Nagrand,50.79,27.99,48.31,31.88,47.13,39.34,48.66,40.86,51.65,39.18,50.33,35.67,50.95,31.54,52.50,29.87,50.79,27.99
.goto Nagrand,50.79,27.99,60,0
.goto Nagrand,48.31,31.88,60,0
.goto Nagrand,47.13,39.34,60,0
.goto Nagrand,48.66,40.86,60,0
.goto Nagrand,51.65,39.18,60,0
.goto Nagrand,50.33,35.67,60,0
.goto Nagrand,50.95,31.54,60,0
.goto Nagrand,52.50,29.87,60,0
.goto Nagrand,50.79,27.99,60,0
>>Kill |cRXP_ENEMY_Clefthoof Bulls|r
.complete 9850,1 
.mob Clefthoof Bull
step
.goto Nagrand,41.18,44.33
>>Travel to Halaa if the Alliance is controlling it
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kartos|r
*If the Horde or nobody is controlling Halaa, skip this step
.accept 10076 >> Accept Oshu'gun Crystal Powder
.turnin 10076 >> Turn in Oshu'gun Crystal Powder
.itemcount 26043,20 
.target Chief Researcher Kartos
step
#questguide << !tbc
#optional
#completewith next
>>Kill |cRXP_ENEMY_Ravenous Windrocs|r
.complete 9855,1 
.mob Ravenous Windroc
step
#questguide << !tbc
.goto Nagrand,51.82,56.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nitrin the Learned|r on the bottom floor inside the building
.turnin 10251 >> Turn in The Master's Grand Design?
.accept 10252 >> Accept Vision of the Dead
.isQuestTurnedIn 10231
.target Nitrin the Learned
step
#loop
.line Nagrand,49.47,58.46,51.83,61.23,50.08,63.89,49.10,61.11,47.43,60.82,43.08,56.34,43.82,54.76,47.43,60.82,49.47,58.46
.goto Nagrand,49.47,58.46,60,0
.goto Nagrand,51.83,61.23,60,0
.goto Nagrand,50.08,63.89,60,0
.goto Nagrand,49.10,61.11,60,0
.goto Nagrand,47.43,60.82,60,0
.goto Nagrand,43.08,56.34,60,0
.goto Nagrand,43.82,54.76,60,0
.goto Nagrand,47.43,60.82,60,0
.goto Nagrand,49.47,58.46,60,0
>>Kill |cRXP_ENEMY_Ravenous Windrocs|r
.complete 9855,1 
.mob Ravenous Windroc
step
.goto Nagrand,29.1,56.9
.use 24559 >>Kill the |cRXP_ENEMY_Murkblood Invaders|r. Loot them for their |cRXP_LOOT_Plans|r. Click the |T134269:0|t[Murkblood Invasion Plans] in your bags
.collect 24559,1,9871 
.accept 9871 >>Accept Murkblood Invaders
.unitscan Murkblood Invader
step << !Shaman
.goto Nagrand,51.11,69.77
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Consortium Recruiter|r
.accept 9913 >>Accept The Consortium Needs You!
.target Consortium Recruiter
step << Shaman
#completewith next
.hs >> Hearth to Telaar
.cooldown item,6948,>2
step
#label Telaar2
.goto 1951/530,7231.500,-2489.900
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arechron|r
.target Arechron
.turnin 9871 >>Turn in Murkblood Invaders
.accept 9873 >>Accept Ortor My Old Friend...
step
.goto 1951/530,7255.800,-2556.300
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Huntress Bintook|r
.target Huntress Bintook
.turnin 9917 >>Turn in Do My Eyes Deceive Me
.accept 9918 >>Accept Not On My Watch!
step
.goto Nagrand,62.74,71.48
>>Damage |cRXP_ENEMY_Lump|r to 30% or less health
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lump|r
.skipgossip
.complete 9918,1 
.target Lump
step
.goto 1951/530,7252.400,-2556.900
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Huntress Bintook|r
.target Huntress Bintook
.turnin 9918 >>Turn in Not On My Watch!
.accept 9920 >>Accept Mo'mor the Breaker
step
.goto 1951/530,7278.300,-2618.100
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mo'mor the Breaker|r
.target Mo'mor the Breaker
.turnin 9920 >>Turn in Mo'mor the Breaker
.accept 9921 >>Accept The Ruins of Burning Blade
step
.goto Nagrand,61.68,67.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wazat|r
.turnin 10109 >> Turn in I Must Have Them!
.accept 10111 >> Accept Bring Me The Egg!
.target Wazat
step
#completewith next
.goto Nagrand,61.82,68.84,30 >>Use the Jump-A-Tron 4000 next to Wazat to get the Slowfall buff. Mount up then run up the cliff to your south and jump toward the tree with the nest of eggs
.skill riding,225,1
step
.goto Nagrand,61.33,66.98
>>Click on the egg inside the nest in the tree. A |cRXP_ENEMY_Windroc Matriach|r will spawn after you loot the egg.
.complete 10111,1 
.cast 3365
.timer 37,Bring Me The Egg! RP
step
>>Kill the |cRXP_ENEMY_Windroc Matriach|r
>>Kite it back to Telaar so that the guards help you. Remember that you need the majority damage over either of the guards to get kill credit, or you'll have to summon the |cRXP_ENEMY_Matriach|r again. Loot it for its |cRXP_LOOT_Talon|r. This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. <<tbc/wotlk
*|cRXP_WARN_The Matriarch IS slowable|r << tbc/wotlk
.goto Nagrand,61.57,66.52,0
.goto Nagrand,57.09,70.21
.complete 10111,2 
.unitscan Windroc Matriarch
step
.goto Nagrand,61.68,67.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wazat|r
.turnin 10111 >> Turn in Bring Me The Egg!
.target Wazat
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Wild Elekks|r. Loot them for their |cRXP_LOOT_Tusks|r
.collect 25463,3,9914,1 
.mob Wild Elekk
step
#completewith CorkiC
>>Kill |cRXP_ENEMY_Boulderfist Ogres|r
.complete 9921,1 

.complete 9921,2 

step
.goto Nagrand,72.53,70.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Corki|r
.accept 9923 >> Accept HELP!
.target Corki
step
#loop
.line Nagrand,72.24,70.14,73.43,71.66,74.64,71.55,73.99,70.78,72.45,67.91,72.24,70.14,72.45,67.91,75.82,68.49,75.56,64.67,76.17,62.47,78.16,58.99,76.17,62.47,73.67,62.37,74.25,64.80,75.82,68.49,72.45,67.91
.goto Nagrand,72.24,70.14,50,0
.goto Nagrand,73.43,71.66,50,0
.goto Nagrand,74.64,71.55,50,0
.goto Nagrand,73.99,70.78,50,0
.goto Nagrand,72.45,67.91,50,0
.goto Nagrand,72.24,70.14,50,0
.goto Nagrand,72.45,67.91,50,0
.goto Nagrand,75.82,68.49,50,0
.goto Nagrand,75.56,64.67,50,0
.goto Nagrand,76.17,62.47,50,0
.goto Nagrand,78.16,58.99,50,0
.goto Nagrand,76.17,62.47,50,0
.goto Nagrand,73.67,62.37,50,0
.goto Nagrand,74.25,64.80,50,0
.goto Nagrand,75.82,68.49,50,0
.goto Nagrand,72.45,67.91,50,0
>>Kill |cRXP_ENEMY_Boulderfist Ogres|r. Loot them for the |cRXP_LOOT_Boulderfist Key|r
.collect 25490,1,9923,1 
.mob Boulderfist Crusher
.mob Boulderfist Mystic
step
#label CorkiC
.goto Nagrand,72.53,70.74
>>Click on |cRXP_FRIENDLY_Corki's|r Cage
.complete 9923,1 
.target Corki
step
#loop
.line Nagrand,72.24,70.14,73.43,71.66,74.64,71.55,73.99,70.78,72.45,67.91,72.24,70.14,72.45,67.91,75.82,68.49,75.56,64.67,76.17,62.47,78.16,58.99,76.17,62.47,73.67,62.37,74.25,64.80,75.82,68.49,72.45,67.91
.goto Nagrand,72.24,70.14,50,0
.goto Nagrand,73.43,71.66,50,0
.goto Nagrand,74.64,71.55,50,0
.goto Nagrand,73.99,70.78,50,0
.goto Nagrand,72.45,67.91,50,0
.goto Nagrand,72.24,70.14,50,0
.goto Nagrand,72.45,67.91,50,0
.goto Nagrand,75.82,68.49,50,0
.goto Nagrand,75.56,64.67,50,0
.goto Nagrand,76.17,62.47,50,0
.goto Nagrand,78.16,58.99,50,0
.goto Nagrand,76.17,62.47,50,0
.goto Nagrand,73.67,62.37,50,0
.goto Nagrand,74.25,64.80,50,0
.goto Nagrand,75.82,68.49,50,0
.goto Nagrand,72.45,67.91,50,0
>>Kill |cRXP_ENEMY_Boulderfist Ogres|r
.complete 9921,1 
.mob +Boulderfist Crusher
.complete 9921,2 
.mob +Boulderfist Mystic
step
#optional
#completewith Throne3
>>Kill |cRXP_ENEMY_Wild Elekks|r. Loot them for their |cRXP_LOOT_Tusks|r
.collect 25463,3,9914,1 
.mob Wild Elekk
step
.use 24467 >> Use the |T134813:0|t[Living Fire] in your bags on the Huts in Windyreed Village
.complete 9805,4 
.goto Nagrand,72.74,54.68
.complete 9805,3 
.goto Nagrand,71.22,53.24
.complete 9805,2 
.goto Nagrand,70.75,51.11
.complete 9805,1 
.goto Nagrand,72.38,50.39
step
#label Saved3
#completewith Safari3
>>Sometimes |cRXP_ENEMY_Gankly|r can appear at the Safari. This is a rare event
>>Kill |cRXP_ENEMY_Gankly|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kristen Dipswitch|r
.accept 9897 >> Accept I'm Saved!
.goto Nagrand,71.42,40.60,0
.unitscan Gankly Rottenfist
.target Kristen Dipswitch
step
#requires Saved3
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harold Lane|r
.turnin 9897 >> Turn in I'm Saved!
.goto Nagrand,71.38,40.62
.target Harold Lane
step
#label Safari3
>>Return to Nesingwary's Camp
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harold Lane|r, |cRXP_FRIENDLY_Hemet Nesingwary|r and |cRXP_FRIENDLY_Shado 'Fitz' Farstrider|r
.turnin 9858 >>Turn in Talbuk Mastery
.accept 9859 >>Accept Talbuk Mastery
.target +Harold Lane
.goto Nagrand,71.38,40.62
.turnin 9850 >>Turn in Clefthoof Mastery
.accept 9851 >>Accept Clefthoof Mastery
.target +Hemet Nesingwary
.goto Nagrand,71.52,40.82
.turnin 9855 >> Turn in Windroc Mastery
.accept 9856 >> Accept Windroc Mastery
.goto Nagrand,71.57,40.52
.target +Shado 'Fitz' Farstrider
step
#questguide << !tbc
.goto Nagrand,62.19,22.60,50,0
.goto Nagrand,61.99,22.09,50,0
.goto Nagrand,61.28,22.24,50,0
.goto Nagrand,60.88,21.39,50,0
.goto Nagrand,60.38,20.88,50,0
.goto Nagrand,59.87,21.32,50,0
.goto Nagrand,59.58,22.48,50,0
.goto Nagrand,60.08,24.41,50,0
.goto Nagrand,60.57,25.04,50,0
.goto Nagrand,61.15,24.92,50,0
.goto Nagrand,61.72,24.54
.line Nagrand,62.19,22.60,61.99,22.09,61.28,22.24,60.88,21.39,60.38,20.88,59.87,21.32,59.58,22.48,60.08,24.41,60.57,25.04,61.15,24.92,61.72,24.54,62.19,22.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gordawg|r patrolling clockwise at the Throne of the Elements
.turnin 9821 >>Turn in Eating Damnation
.accept 9849 >>Accept Shattering the Veil
.unitscan Gordawg
step << !tbc
.goto Nagrand,62.19,22.60,50,0
.goto Nagrand,61.99,22.09,50,0
.goto Nagrand,61.28,22.24,50,0
.goto Nagrand,60.88,21.39,50,0
.goto Nagrand,60.38,20.88,50,0
.goto Nagrand,59.87,21.32,50,0
.goto Nagrand,59.58,22.48,50,0
.goto Nagrand,60.08,24.41,50,0
.goto Nagrand,60.57,25.04,50,0
.goto Nagrand,61.15,24.92,50,0
.goto Nagrand,61.72,24.54
.line Nagrand,62.19,22.60,61.99,22.09,61.28,22.24,60.88,21.39,60.38,20.88,59.87,21.32,59.58,22.48,60.08,24.41,60.57,25.04,61.15,24.92,61.72,24.54,62.19,22.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gordawg|r patrolling clockwise at the Throne of the Elements
.turnin 9821 >>Turn in Eating Damnation
.unitscan Gordawg
step
#label Throne3
.goto Nagrand,60.81,22.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elementalist Lo'ap|r
.turnin 9805 >>Turn in Blessing of Incineratus
.accept 9810 >>Accept The Spirit Polluted
.target Elementalist Lo'ap
step
#completewith Telaar3
.hs >> Hearth to Telaar
step
#sticky
#label caravan1
.waypoint Nagrand,53.69,68.70,40,0
.waypoint Nagrand,54.01,69.11,40,0
.waypoint Nagrand,54.33,70.32,40,0
.waypoint Nagrand,54.75,70.41,40,0
.waypoint Nagrand,54.97,70.91,40,0
.waypoint Nagrand,55.30,71.42,40,0
.waypoint Nagrand,55.70,72.60,40,0
.waypoint Nagrand,55.61,73.18,40,0
.waypoint Nagrand,54.71,73.30,40,0
.waypoint Nagrand,54.53,73.66,40,0
.waypoint Nagrand,54.53,72.64,40,0
.waypoint Nagrand,54.30,72.28,40,0
.waypoint Nagrand,53.71,72.24,40,0
.waypoint Nagrand,53.52,71.94,40,0
.waypoint Nagrand,53.82,71.30,40,0
.waypoint Nagrand,53.42,70.82,40,0
.waypoint Nagrand,52.93,70.80,40,0
.waypoint Nagrand,53.16,70.24,40,0
.waypoint Nagrand,53.56,70.43,40,0
.waypoint Nagrand,54.10,69.56,40,0
.waypoint Nagrand,54.03,69.16,40,0
.waypoint Nagrand,53.69,68.70,40,0
.line Nagrand,53.69,68.70,54.03,69.16,54.10,69.56,53.56,70.43,53.16,70.24,52.93,70.80,53.42,70.82,53.82,71.30,53.52,71.94,53.71,72.24,54.30,72.28,54.53,72.64,54.53,73.66,54.71,73.30,55.61,73.18,55.70,72.60,55.30,71.42,54.97,70.91,54.75,70.41,54.33,70.32,54.01,69.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Huntress Kima|r. She patrols counter-clockwise around Telaar
.accept 9956 >> Accept The Ravaged Caravan
.accept 9982 >> Accept He Called Himself Altruis...
.unitscan Huntress Kima
.xp <66,1
step
#label kima2
#optional
#requires caravan1
#sticky
.waypoint Nagrand,53.69,68.70,40,0
.waypoint Nagrand,54.01,69.11,40,0
.waypoint Nagrand,54.33,70.32,40,0
.waypoint Nagrand,54.75,70.41,40,0
.waypoint Nagrand,54.97,70.91,40,0
.waypoint Nagrand,55.30,71.42,40,0
.waypoint Nagrand,55.70,72.60,40,0
.waypoint Nagrand,55.61,73.18,40,0
.waypoint Nagrand,54.71,73.30,40,0
.waypoint Nagrand,54.53,73.66,40,0
.waypoint Nagrand,54.53,72.64,40,0
.waypoint Nagrand,54.30,72.28,40,0
.waypoint Nagrand,53.71,72.24,40,0
.waypoint Nagrand,53.52,71.94,40,0
.waypoint Nagrand,53.82,71.30,40,0
.waypoint Nagrand,53.42,70.82,40,0
.waypoint Nagrand,52.93,70.80,40,0
.waypoint Nagrand,53.16,70.24,40,0
.waypoint Nagrand,53.56,70.43,40,0
.waypoint Nagrand,54.10,69.56,40,0
.waypoint Nagrand,54.03,69.16,40,0
.waypoint Nagrand,53.69,68.70,40,0
.line Nagrand,53.69,68.70,54.03,69.16,54.10,69.56,53.56,70.43,53.16,70.24,52.93,70.80,53.42,70.82,53.82,71.30,53.52,71.94,53.71,72.24,54.30,72.28,54.53,72.64,54.53,73.66,54.71,73.30,55.61,73.18,55.70,72.60,55.30,71.42,54.97,70.91,54.75,70.41,54.33,70.32,54.01,69.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Huntress Kima|r. She patrols counter-clockwise around Telaar
.accept 9956 >> Accept The Ravaged Caravan
.unitscan Huntress Kima
step
#label Telaar3
.goto 1951/530,7278.200,-2618.400
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mo'mor the Breaker|r
.target Mo'mor the Breaker
.turnin 9921 >>Turn in The Ruins of Burning Blade
.accept 9922 >>Accept The Twin Clefts of Nagrand
step
.goto 1951/530,7231.100,-2489.500
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arechron|r
.target Arechron
.turnin 9923 >>Turn in HELP!
.accept 9924 >>Accept Corki's Gone Missing Again!
step
#requires kima2
.goto Nagrand,51.11,69.77
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Consortium Recruiter|r
.accept 9913 >>Accept The Consortium Needs You!
.target Consortium Recruiter
step
#optional
#completewith Corki2
.goto Nagrand,40.0,30.0,0
.goto Nagrand,50.0,56.0,0
>>Kill |cRXP_ENEMY_Boulderfist Warriors|r and |cRXP_ENEMY_Mages|r
.complete 9922,1 
.mob +Boulderfist Warrior
.complete 9922,2 
.mob +Boulderfist Mage
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Boulderfist Warriors|r and |cRXP_ENEMY_Mages|r. Loot them for the |cRXP_LOOT_Cleft Key|r
.collect 25509,1,9924,1 
.mob Boulderfist Warrior
.mob Boulderfist Mage
step
#loop
.goto Nagrand,44.87,49.83,60,0
.goto Nagrand,40.15,46.19,60,0
.goto Nagrand,39.99,37.46,60,0
.goto Nagrand,42.11,37.80,60,0
.goto Nagrand,45.28,42.85,60,0
.goto Nagrand,45.28,42.85,0
>>Kill |cRXP_ENEMY_Muck Spawns|r. Loot them for their |cRXP_LOOT_Cores|r
.complete 9815,1 
.mob Muck Spawn
step
#loop
.goto Nagrand,41.33,32.64,50,0
.goto Nagrand,41.59,34.86,50,0
.goto Nagrand,40.49,33.98,50,0
.goto Nagrand,40.74,31.28,20,0
.goto Nagrand,39.42,30.73,20,0
.goto Nagrand,39.61,28.98,20,0
.goto Nagrand,39.36,27.61,20,0
.goto Nagrand,40.16,29.45,20,0
.goto Nagrand,41.33,32.64,50,0
.goto Nagrand,41.59,34.86,50,0
.goto Nagrand,40.49,33.98,50,0
.goto Nagrand,40.74,31.28,20,0
.goto Nagrand,39.42,30.73,20,0
.goto Nagrand,39.61,28.98,20,0
.goto Nagrand,39.36,27.61,20,0
.goto Nagrand,40.16,29.45,20,0
.goto Nagrand,40.16,29.45,0
>>Kill |cRXP_ENEMY_Boulderfist Warriors|r and |cRXP_ENEMY_Mages|r. Loot them for the |cRXP_LOOT_Cleft Key|r
.collect 25509,1,9924,1 
.mob Boulderfist Warrior
.mob Boulderfist Mage
step
#label Corki2
.goto Nagrand,39.25,27.43
>>Click on |cRXP_FRIENDLY_Corki's|r Cage inside the Cave
.complete 9924,1 
.target Corki
step
#loop
.goto Nagrand,41.33,32.64,50,0
.goto Nagrand,41.59,34.86,50,0
.goto Nagrand,40.49,33.98,50,0
.goto Nagrand,40.74,31.28,20,0
.goto Nagrand,39.42,30.73,20,0
.goto Nagrand,39.61,28.98,20,0
.goto Nagrand,39.36,27.61,20,0
.goto Nagrand,40.16,29.45,20,0
.goto Nagrand,41.33,32.64,50,0
.goto Nagrand,41.59,34.86,50,0
.goto Nagrand,40.49,33.98,50,0
.goto Nagrand,40.74,31.28,20,0
.goto Nagrand,39.42,30.73,20,0
.goto Nagrand,39.61,28.98,20,0
.goto Nagrand,39.36,27.61,20,0
.goto Nagrand,40.16,29.45,20,0
.goto Nagrand,40.16,29.45,0
>>Kill |cRXP_ENEMY_Boulderfist Warriors|r and |cRXP_ENEMY_Mages|r
.complete 9922,1 
.mob +Boulderfist Warrior
.complete 9922,2 
.mob +Boulderfist Mage
step
#questguide << !tbc
#optional
#completewith Beaks
.goto Nagrand,35.2,61.2,0
>>Kill |cRXP_ENEMY_Aged Clefthoofs|r. Loot them for their |cRXP_LOOT_Blubber|r
.complete 10252,3 
.isOnQuest 10252
.mob Aged Clefthoof
step
#questguide << !tbc
#optional
#completewith next
>>Kill |cRXP_ENEMY_Greater Windrocs|r. Loot them for their |cRXP_LOOT_Beak|r
.complete 10252,2 
.isOnQuest 10252
.mob Greater Windroc
step
#loop
.line Nagrand,32.66,24.25,33.01,20.84,34.16,20.04,35.46,19.31,36.93,20.77,35.87,23.93,33.32,27.93,31.32,30.74,32.95,28.13,32.66,26.83,32.66,24.25
.goto Nagrand,32.66,26.83,60,0
.goto Nagrand,32.95,28.13,60,0
.goto Nagrand,31.32,30.74,60,0
.goto Nagrand,33.32,27.93,60,0
.goto Nagrand,35.87,23.93,60,0
.goto Nagrand,36.93,20.77,60,0
.goto Nagrand,35.46,19.31,60,0
.goto Nagrand,34.16,20.04,60,0
.goto Nagrand,33.01,20.84,60,0
.goto Nagrand,32.66,24.25,60,0
>>Kill |cRXP_ENEMY_Gutripper|r. Loot him for his |cRXP_LOOT_Eye|r. He patrols around clockwise and may be too high to pull at times. He runs VERY fast.
>>This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him.<< tbc/wotlk
.complete 9856,1 
.unitscan Gutripper
step
#questguide << !tbc
#label Beaks
#loop
.line Nagrand,35.97,29.37,35.71,18.67,32.69,22.30,33.39,26.11,30.88,32.97
.goto Nagrand,35.97,29.37,55,0
.goto Nagrand,35.71,18.67,55,0
.goto Nagrand,32.69,22.30,55,0
.goto Nagrand,33.39,26.11,55,0
.goto Nagrand,30.88,32.97,55,0
>>Kill |cRXP_ENEMY_Greater Windrocs|r. Loot them for their |cRXP_LOOT_Beak|r
.complete 10252,2 
.isOnQuest 10252
.mob Greater Windroc
step
#optional
#completewith Murkblood
.use 24560 >>Use the |T135432:0|t[Torch of Liquid Fire] in your bags on Villager Corpses
.complete 9874,1 
.target Sunspring Villager
step
#optional
#completewith StayCaptive
.goto Nagrand,33.2,46.6,0
>>Kill |cRXP_ENEMY_Murkblood Putrefiers|r, |cRXP_ENEMY_Scavengers|r and |cRXP_ENEMY_Raiders|r
.complete 9862,1 
.mob +Murkblood Putrifier
.complete 9878,1 
.mob +Murkblood Scavenger
.complete 9878,2 
.mob +Murkblood Raider
step
.goto Nagrand,30.83,42.36
>>Kill |cRXP_ENEMY_Ortor of Murkblood|r
.complete 9873,1 
.mob Ortor of Murkblood
step
.goto Nagrand,33.19,42.30
>>Clear all the mobs around the hut and make sure you're at full health/mana before talking to the |cRXP_FRIENDLY_Kurenai Captive|r inside << !Rogue !Warrior !DK
>>Clear all the mobs around the hut and make sure you're at full health before talking to the |cRXP_FRIENDLY_Kurenai Captive|r inside << Rogue/Warrior/DK
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Kurenai Captive|r
.accept 9879 >> Accept The Totem of Kar'dash
.target Kurenai Captive
step
#label StayCaptive
.goto Nagrand,32.37,40.04,50,0
.goto Nagrand,31.57,38.77
>>Escort the |cRXP_FRIENDLY_Kurenai Captive|r. Be ready with cooldowns for an ambush close to the fork in the road
.complete 9879,1 
.target Kurenai Captive
step
#label Murkblood
>>Kill |cRXP_ENEMY_Murkblood Putrefiers|r, |cRXP_ENEMY_Scavengers|r and |cRXP_ENEMY_Raiders|r
.complete 9862,1 
.mob +Murkblood Putrifier
.goto Nagrand,31.49,46.91,50,0
.goto Nagrand,32.98,46.84,50,0
.goto Nagrand,33.98,47.50,50,0
.goto Nagrand,34.28,45.97,50,0
.goto Nagrand,33.49,43.25,50,0
.goto Nagrand,32.24,43.46
.complete 9878,2 
.mob +Murkblood Raider
.goto Nagrand,31.48,42.47,50,0
.goto Nagrand,31.14,43.33,50,0
.goto Nagrand,32.10,46.26,50,0
.goto Nagrand,32.77,45.08,50,0
.goto Nagrand,33.31,42.50,50,0
.goto Nagrand,32.24,43.46
.complete 9878,1 
.mob +Murkblood Scavenger
.goto Nagrand,32.20,45.33,50,0
.goto Nagrand,33.31,44.25,50,0
.goto Nagrand,32.84,42.59,50,0
.goto Nagrand,33.23,40.93,50,0
.goto Nagrand,31.58,39.66,50,0
.goto Nagrand,30.66,41.29,50,0
.goto Nagrand,31.14,41.52,50,0
.goto Nagrand,32.24,43.46
step
#optional
#completewith Surgers
.goto Nagrand,33.17,48.36,50,0
.use 24560 >>Use the |T135432:0|t[Torch of Liquid Fire] in your bags on Villager Corpses
.complete 9874,1 
.target Sunspring Villager
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Lake Surgers|r << !Mage
>>Kill |cRXP_ENEMY_Lake Surgers|r. Be careful as they are immune to frost << Mage
.complete 9810,2 
.mob Lake Surger
step
>>Kill |cRXP_ENEMY_Watoosun's Polluted Essence|r
.complete 9810,1 
.goto Nagrand,33.03,50.86
.mob Watoosun's Polluted Essence
step
#label Surgers
.goto Nagrand,30.98,50.56,60,0
.goto Nagrand,33.23,48.87,60,0
.goto Nagrand,35.17,46.01,60,0
.goto Nagrand,36.91,46.72,60,0
.goto Nagrand,33.26,54.42,60,0
.goto Nagrand,30.98,50.56
>>Kill |cRXP_ENEMY_Lake Surgers|r << !Mage
>>Kill |cRXP_ENEMY_Lake Surgers|r. Be careful as they are immune to frost << Mage
.complete 9810,2 
.mob Lake Surger
step
.goto Nagrand,33.17,48.36,50,0
.goto Nagrand,34.52,47.21,50,0
.goto Nagrand,34.96,46.15
.use 24560 >>Use the |T135432:0|t[Torch of Liquid Fire] in your bags on Villager Corpses
.complete 9874,1 
.target Sunspring Villager
step
#optional
#completewith next
.line Nagrand,26.34,51.07,25.93,53.93,25.27,51.74,24.45,50.91,23.69,49.61,24.47,49.04,23.93,48.94,24.36,46.98,23.77,44.47,25.33,41.39,25.72,40.82,26.35,39.23,28.22,38.16,28.35,37.22,28.12,35.92,29.35,34.24,30.07,34.90,30.64,35.79,30.65,37.70,28.90,38.17,28.49,39.43,27.84,42.01,27.25,45.30,26.91,46.66,26.65,48.17,26.34,51.07
>>Kill |cRXP_ENEMY_Bach'lor|r. Loot him for his |cRXP_LOOT_Hoof|r. He patrols around counter-clockwise.
>>This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him.<< tbc/wotlk
.complete 9859,1 
.unitscan Bach'lor
step
.goto Nagrand,27.33,43.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Huntress Kima|r
.turnin 9982 >> Turn in He Called Himself Altruis...
.isOnQuest 9982
.target Altruis the Sufferer
step
#questguide << tbc/wotlk
.goto Nagrand,27.33,43.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Altruis the Sufferer|r
.accept 9991 >> Accept Surveying the Land
.timer 135,Surveying the Land RP
.target Altruis the Sufferer
.xp <66,1
step
#questguide << tbc/wotlk
.goto Nagrand,27.33,43.09
>>Wait out the flight
.turnin 9991 >> Turn in Surveying the Land
.accept 9999 >> Accept Buying Time
.target Altruis the Sufferer
.xp <66,1
step
#questguide << tbc/wotlk
#loop
.goto 1951/530,8987.400,-1346.100,60,0
.goto 1951/530,8975.500,-1357.300,60,0
.goto 1951/530,8853.800,-1347.800,60,0
.goto 1951/530,8987.400,-1346.100,0
.goto 1951/530,8975.500,-1357.300,0
.goto 1951/530,8853.800,-1347.800,0
>>Kill |cRXP_ENEMY_Gan'arg Tinkerer|r, |cRXP_ENEMY_Mo'arg Engineer|r and |cRXP_ENEMY_Felguard Legionnaire|r
.complete 9999,3 
.mob +Gan'arg Tinkerer
.complete 9999,2 
.mob +Mo'arg Engineer
.complete 9999,1 
.mob +Felguard Legionnaire
.xp <66,1
step
#questguide << tbc/wotlk
.goto 1951/530,8785.601,-1543.900
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Altruis the Sufferer|r
.target Altruis the Sufferer
.turnin 9999 >>Turn in Buying Time
.accept 10001 >>Accept The Master Planner
.xp <66,1
step
#questguide << tbc/wotlk
.goto 1951/530,8990.500,-1234.000
>>Kill |cRXP_ENEMY_The Master Planner|r and loot his |cRXP_LOOT_Blueprints|r
.complete 10001,1 
.xp <66,1
.mob Mo'arg Master Planner
step
#questguide << tbc/wotlk
.goto 1951/530,8785.500,-1545.900
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Altruis the Sufferer|r
.target Altruis the Sufferer
.turnin 10001 >>Turn in The Master Planner
.xp <66,1
step
#questguide << !tbc
#optional
#completewith Banthar
.goto Nagrand,35.2,61.2,0
>>Kill |cRXP_ENEMY_Aged Clefthoofs|r. Loot them for their |cRXP_LOOT_Blubber|r
.complete 10252,3 
.isOnQuest 10252
.mob Aged Clefthoof
step
#questguide << !tbc
#optional
#completewith next
.goto Nagrand,24.37,41.81,0
>>Kill a |cRXP_ENEMY_Mountain Gronn|r. Loot it for its |cRXP_LOOT_Eyeball|r
.complete 10252,1 
.isOnQuest 10252
.unitscan Mountain Gronn
step
#label Bachlor
#loop
.goto Nagrand,26.34,51.07,60,0
.goto Nagrand,25.93,53.93,60,0
.goto Nagrand,25.27,51.74,60,0
.goto Nagrand,24.45,50.91,60,0
.goto Nagrand,23.69,49.61,60,0
.goto Nagrand,24.47,49.04,60,0
.goto Nagrand,23.93,48.94,60,0
.goto Nagrand,24.36,46.98,60,0
.goto Nagrand,23.77,44.47,60,0
.goto Nagrand,25.33,41.39,60,0
.goto Nagrand,25.72,40.82,60,0
.goto Nagrand,26.35,39.23,60,0
.goto Nagrand,28.22,38.16,60,0
.goto Nagrand,28.35,37.22,60,0
.goto Nagrand,28.12,35.92,60,0
.goto Nagrand,29.35,34.24,60,0
.goto Nagrand,30.07,34.90,60,0
.goto Nagrand,30.64,35.79,60,0
.goto Nagrand,30.65,37.70,60,0
.goto Nagrand,28.90,38.17,60,0
.goto Nagrand,28.49,39.43,60,0
.goto Nagrand,27.84,42.01,60,0
.goto Nagrand,27.25,45.30,60,0
.goto Nagrand,26.91,46.66,60,0
.goto Nagrand,26.65,48.17,60,0
.line Nagrand,26.34,51.07,25.93,53.93,25.27,51.74,24.45,50.91,23.69,49.61,24.47,49.04,23.93,48.94,24.36,46.98,23.77,44.47,25.33,41.39,25.72,40.82,26.35,39.23,28.22,38.16,28.35,37.22,28.12,35.92,29.35,34.24,30.07,34.90,30.64,35.79,30.65,37.70,28.90,38.17,28.49,39.43,27.84,42.01,27.25,45.30,26.91,46.66,26.65,48.17,26.34,51.07
>>Kill |cRXP_ENEMY_Bach'lor|r. Loot him for his |cRXP_LOOT_Hoof|r. He patrols around counter-clockwise.
>>This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him.<<tbc/wotlk
.complete 9859,1 
.unitscan Bach'lor
step
#questguide << !tbc
.goto Nagrand,24.37,41.81
>>Kill a |cRXP_ENEMY_Mountain Gronn|r. Loot it for its |cRXP_LOOT_Eyeball|r
.complete 10252,1 
.isOnQuest 10252
.unitscan Mountain Gronn
step
.goto 1951/530,8540.400,-2049.800
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shadrek|r
.target Shadrek
.accept 9914 >>Accept A Head Full of Ivory
.turnin 9914 >>Turn in A Head Full of Ivory
.itemcount 25463,3
step
.goto 1951/530,8562.300,-2085.900
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gezhe|r
.target Gezhe
.turnin 9913 >>Turn in The Consortium Needs You!
.accept 9882 >>Accept Stealing from Thieves
step
.goto 1951/530,8594.900,-2099.600
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zerid|r
.target Zerid
.accept 9900 >>Accept Gava'xi
.accept 9925 >>Accept Matters of Security
step
#optional
#completewith Voidspawns
>>Kill |cRXP_ENEMY_Wild Elekks|r. Loot them for their |cRXP_LOOT_Tusks|r
.collect 25463,3,9914,1 
.unitscan Wild Elekk
step
#optional
#completewith Gava
>>Kill |cRXP_ENEMY_Raiders|r. Loot them for their |cRXP_LOOT_Crystals|r. The |cRXP_LOOT_Crystals|r can also be found on the ground
>>Kill |cRXP_ENEMY_Voidspawns|r
.complete 9882,1 
.mob +Vir'aani Raider
.complete 9925,1 
.mob +Voidspawn
step
#questguide << !tbc
.goto Nagrand,25.84,73.34,60,0
.goto Nagrand,27.73,74.09,60,0
.goto Nagrand,28.36,78.70,60,0
.goto Nagrand,32.07,81.44,60,0
.goto Nagrand,40.34,84.18
.use 24501 >>Use |T135242:0|t[Gordawg's Boulder] on |cRXP_ENEMY_Shattered Rumblers|r to spawn the |cRXP_ENEMY_Minions of Gurok|r. Kill them. You can use the |T135242:0|tBoulder while moving
.complete 9849,1 
.mob Shattered Rumbler
.mob Minion of Gurok
step
#label Gava
.goto Nagrand,42.39,73.49,50,0
.goto Nagrand,43.65,74.59,50,0
.goto Nagrand,43.47,72.86,50,0
.goto Nagrand,42.45,72.32,50,0
.goto Nagrand,41.53,71.33
>>Kill |cRXP_ENEMY_Gava'xi|r. He patrols around from the little cliff to the crystal slightly north of it
.complete 9900,1 
.unitscan Gava'xi
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Voidspawns|r
.complete 9925,1 
.mob Voidspawn
step
#loop
.goto Nagrand,41.61,70.68,50,0
.goto Nagrand,36.88,66.96,50,0
.goto Nagrand,34.53,62.93,60,0
.goto Nagrand,30.53,76.12,60,0
.goto Nagrand,41.61,70.68,0
.goto Nagrand,36.88,66.96,0
.goto Nagrand,34.53,62.93,0
.goto Nagrand,30.53,76.12,0
>>Kill |cRXP_ENEMY_Raiders|r. Loot them for their |cRXP_LOOT_Crystals|r. The |cRXP_LOOT_Crystals|r can also be found on the ground
.complete 9882,1 
.mob Vir'aani Raider
step
#label Voidspawns
#loop
.line Nagrand,30.51,66.79,32.23,69.85,31.75,74.99,36.51,77.38,38.03,79.58,40.19,77.22,37.87,76.04,39.87,72.76,39.35,67.61,41.46,62.82,37.64,66.21,34.90,65.37,32.91,67.36,30.51,66.79
.goto Nagrand,30.51,66.79,60,0
.goto Nagrand,32.23,69.85,60,0
.goto Nagrand,31.75,74.99,60,0
.goto Nagrand,36.51,77.38,60,0
.goto Nagrand,38.03,79.58,60,0
.goto Nagrand,40.19,77.22,60,0
.goto Nagrand,37.87,76.04,60,0
.goto Nagrand,39.87,72.76,60,0
.goto Nagrand,39.35,67.61,60,0
.goto Nagrand,41.46,62.82,60,0
.goto Nagrand,37.64,66.21,60,0
.goto Nagrand,34.90,65.37,60,0
.goto Nagrand,32.91,67.36,60,0
.goto Nagrand,30.51,66.79,60,0
>>Kill |cRXP_ENEMY_Voidspawns|r
.complete 9925,1 
.mob Voidspawn
step
#optional
#completewith AerisL
>>Kill |cRXP_ENEMY_Banthar|r. Loot him for his |cRXP_LOOT_Horn|r. He patrols around.
>>This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him.<<tbc/wotlk
.complete 9851,1 
.unitscan Banthar
step
#loop
.line Nagrand,44.13,76.74,35.70,58.91,29.60,61.89,33.11,77.90,44.13,76.74
.goto Nagrand,44.13,76.74,60,0
.goto Nagrand,35.70,58.91,60,0
.goto Nagrand,29.60,61.89,60,0
.goto Nagrand,33.11,77.90,60,0
.goto Nagrand,44.13,76.74,60,0
>>Kill |cRXP_ENEMY_Wild Elekks|r. Loot them for their |cRXP_LOOT_Tusks|r
>>|cRXP_WARN_Bull Elekks do NOT drop them!|r
.collect 25463,3,9914,1 
.unitscan Wild Elekk
step
#label AerisL
.goto 1951/530,8595.000,-2100.100
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zerid|r
.target Zerid
.turnin 9900 >>Turn in Gava'xi
.turnin 9925 >>Turn in Matters of Security
step
.goto 1951/530,8563.800,-2086.600
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gezhe|r
.target Gezhe
.turnin 9882 >>Turn in Stealing from Thieves
step
.goto Nagrand,31.77,56.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shadrek|r
.accept 9914 >>Accept A Head Full of Ivory
.turnin 9914 >>Turn in A Head Full of Ivory
.target Shadrek
step
#loop
.line Nagrand,30.88,63.61,32.53,61.08,33.99,60.44,36.31,58.76,37.39,58.63,38.67,59.52,40.46,60.74,44.52,61.64,46.20,63.09,46.71,66.40,46.31,67.69,45.46,68.24,43.63,68.35,43.05,67.77,42.75,66.72,42.56,64.36,41.98,62.64,40.82,61.30,38.67,59.52
.goto Nagrand,30.88,63.61,50,0
.goto Nagrand,32.53,61.08,50,0
.goto Nagrand,33.99,60.44,50,0
.goto Nagrand,36.31,58.76,50,0
.goto Nagrand,37.39,58.63,50,0
.goto Nagrand,38.67,59.52,50,0
.goto Nagrand,40.46,60.74,50,0
.goto Nagrand,44.52,61.64,50,0
.goto Nagrand,46.20,63.09,50,0
.goto Nagrand,46.71,66.40,50,0
.goto Nagrand,46.31,67.69,50,0
.goto Nagrand,45.46,68.24,50,0
.goto Nagrand,43.63,68.35,50,0
.goto Nagrand,43.05,67.77,50,0
.goto Nagrand,42.75,66.72,50,0
.goto Nagrand,42.56,64.36,50,0
.goto Nagrand,41.98,62.64,50,0
.goto Nagrand,40.82,61.30,50,0
.goto Nagrand,38.67,59.52,50,0
>>Kill |cRXP_ENEMY_Banthar|r. Loot him for his |cRXP_LOOT_Horn|r. He patrols around.
>>This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him.<<tbc/wotlk
.complete 9851,1 
.unitscan Banthar
step
#questguide << !tbc
#loop
.line Nagrand,30.88,63.61,32.53,61.08,33.99,60.44,36.31,58.76,37.39,58.63,38.67,59.52,40.46,60.74,44.52,61.64,46.20,63.09,46.71,66.40,46.31,67.69,45.46,68.24,43.63,68.35,43.05,67.77,42.75,66.72,42.56,64.36,41.98,62.64,40.82,61.30,38.67,59.52
.goto Nagrand,30.88,63.61,50,0
.goto Nagrand,32.53,61.08,50,0
.goto Nagrand,33.99,60.44,50,0
.goto Nagrand,36.31,58.76,50,0
.goto Nagrand,37.39,58.63,50,0
.goto Nagrand,38.67,59.52,50,0
.goto Nagrand,40.46,60.74,50,0
.goto Nagrand,44.52,61.64,50,0
.goto Nagrand,46.20,63.09,50,0
.goto Nagrand,46.71,66.40,50,0
.goto Nagrand,46.31,67.69,50,0
.goto Nagrand,45.46,68.24,50,0
.goto Nagrand,43.63,68.35,50,0
.goto Nagrand,43.05,67.77,50,0
.goto Nagrand,42.75,66.72,50,0
.goto Nagrand,42.56,64.36,50,0
.goto Nagrand,41.98,62.64,50,0
.goto Nagrand,40.82,61.30,50,0
.goto Nagrand,38.67,59.52,50,0
>>Kill |cRXP_ENEMY_Aged Clefthoofs|r. Loot them for their |cRXP_LOOT_Blubber|r
.complete 10252,3 
.isOnQuest 10252
.unitscan Aged Clefthoof
step
#questguide << !tbc
.goto Nagrand,51.82,56.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nitrin the Learned|r on the bottom floor
.turnin 10252 >> Turn in Vision of the Dead
.isQuestComplete 10252
.target Nitrin the Learned
step
#questguide << !tbc
#sticky
#optional
.abandon 10252 >> Abandon Vision of the Dead
step << Shaman
#completewith next
.hs >> Hearth to Telaar
step
#sticky
#label problem
.goto 1951/530,7286.700,-2622.700
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Poli'lukluk the Wiser|r
.target Poli'lukluk the Wiser
.turnin 9878 >>Turn in Solving the Problem
step
.goto 1951/530,7278.000,-2618.700
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Mo'mor the Breaker
.turnin 9922 >>Turn in The Twin Clefts of Nagrand
.accept 10108 >>Accept Diplomatic Measures
.target Mo'mor the Breaker
step
.goto 1951/530,7286.000,-2612.700
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Otonbu the Sage|r
.target Otonbu the Sage
.turnin 9874 >>Turn in Stopping the Spread
step
#requires problem
.goto 1951/530,7270.600,-2568.500
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Warden Moi'bff Jill|r
.target Warden Moi'bff Jill
.accept 10476 >>Accept Fierce Enemies
.turnin 10476 >>Turn in Fierce Enemies
.itemcount 25433,10 
step
.goto 1951/530,7231.500,-2489.600
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arechron|r
.target Arechron
.turnin 9873 >>Turn in Ortor My Old Friend...
.turnin 9924 >>Turn in Corki's Gone Missing Again!
.turnin 9879 >>Turn in The Totem of Kar'dash
.accept 9954 >>Accept Corki's Ransom
step
.goto Nagrand,73.81,62.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lantresor of the Blade|r
.complete 10108,1 
.skipgossip 18261,1
.target Lantresor of the Blade
step
.goto Nagrand,73.81,62.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lantresor of the Blade|r
.turnin 10108 >> Turn in Diplomatic Measures
.accept 9928 >> Accept Armaments for Deception
.accept 9927 >> Accept Ruthless Cunning
.target Lantresor of the Blade
step
#optional
#aldor
#completewith ksf1
>>Kill |cRXP_ENEMY_Kil'sorrow|r orcs. Loot them for their |cRXP_LOOT_Marks of Kil'jaeden|r, save them for a quest later
.collect 29425,10,10325,1 
step
#optional
#completewith next
.goto Nagrand,70.51,79.79,0
.use 25552 >>Kill |cRXP_ENEMY_Orcs|r. Use the |T132484:0|t[Warmaul Ogre Banner] in your bags on their corpses
>>Loot the |cRXP_PICK_Wooden Boxes|r on the ground
.complete 9936,2 
.complete 9927,1 
.complete 9928,1 
.mob Kil'sorrow Spellbinder
.mob Kil'sorrow Cultist
.mob Kil'sorrow Deathsworn
.mob Kil'sorrow Invader
.mob Kil'sorrow Ritualist
.mob Kil'sorrow Agent
step
.goto Nagrand,70.98,81.48,30,0
.goto Nagrand,71.16,82.36
>>Kill |cRXP_ENEMY_Giselda|r inside the Fortress
.complete 9936,1 
.unitscan Giselda the Crone
step
#label ksf1
#loop
.line Nagrand,71.70,80.65,72.14,82.16,71.70,79.25,70.26,79.11,69.46,79.66,68.34,82.79,69.64,81.65,70.83,80.61,71.70,80.65
.goto Nagrand,71.70,80.65,40,0
.goto Nagrand,72.14,82.16,40,0
.goto Nagrand,71.70,79.25,40,0
.goto Nagrand,70.26,79.11,40,0
.goto Nagrand,69.46,79.66,40,0
.goto Nagrand,68.34,82.79,40,0
.goto Nagrand,69.64,81.65,40,0
.goto Nagrand,70.83,80.61,40,0
.goto Nagrand,71.70,80.65,40,0
.goto Nagrand,71.70,80.65,40,0
.goto Nagrand,72.14,82.16,40,0
.goto Nagrand,71.70,79.25,40,0
.goto Nagrand,70.26,79.11,40,0
.goto Nagrand,69.46,79.66,40,0
.goto Nagrand,68.34,82.79,40,0
.goto Nagrand,69.64,81.65,40,0
.goto Nagrand,70.83,80.61,40,0
.goto Nagrand,71.70,80.65,40,0
.goto Nagrand,72.14,82.16,40,0
.goto Nagrand,71.70,79.25,40,0
.goto Nagrand,70.26,79.11,40,0
.goto Nagrand,69.46,79.66,40,0
.goto Nagrand,68.34,82.79,40,0
.goto Nagrand,69.64,81.65,40,0
.goto Nagrand,70.83,80.61,40,0
.use 25552 >>Kill |cRXP_ENEMY_Orcs|r. Use the |T132484:0|t[Warmaul Ogre Banner] in your bags on their corpses
>>Loot the wooden boxes on the ground
.complete 9936,2 
.complete 9927,1 
.complete 9928,1 
.mob Kil'sorrow Spellbinder
.mob Kil'sorrow Cultist
.mob Kil'sorrow Deathsworn
.mob Kil'sorrow Invader
.mob Kil'sorrow Ritualist
.mob Kil'sorrow Agent
step
#aldor
#loop
.line Nagrand,71.70,80.65,72.14,82.16,71.70,79.25,70.26,79.11,69.46,79.66,68.34,82.79,69.64,81.65,70.83,80.61,71.70,80.65
.goto Nagrand,71.70,80.65,40,0
.goto Nagrand,72.14,82.16,40,0
.goto Nagrand,71.70,79.25,40,0
.goto Nagrand,70.26,79.11,40,0
.goto Nagrand,69.46,79.66,40,0
.goto Nagrand,68.34,82.79,40,0
.goto Nagrand,69.64,81.65,40,0
.goto Nagrand,70.83,80.61,40,0
.goto Nagrand,71.70,80.65,40,0
.goto Nagrand,71.70,80.65,40,0
.goto Nagrand,72.14,82.16,40,0
.goto Nagrand,71.70,79.25,40,0
.goto Nagrand,70.26,79.11,40,0
.goto Nagrand,69.46,79.66,40,0
.goto Nagrand,68.34,82.79,40,0
.goto Nagrand,69.64,81.65,40,0
.goto Nagrand,70.83,80.61,40,0
.goto Nagrand,71.70,80.65,40,0
.goto Nagrand,72.14,82.16,40,0
.goto Nagrand,71.70,79.25,40,0
.goto Nagrand,70.26,79.11,40,0
.goto Nagrand,69.46,79.66,40,0
.goto Nagrand,68.34,82.79,40,0
.goto Nagrand,69.64,81.65,40,0
.goto Nagrand,70.83,80.61,40,0
>>Kill |cRXP_ENEMY_Kil'sorrow|r orcs. Loot them for their |cRXP_LOOT_Marks of Kil'jaeden|r, save them for a quest later
.collect 29425,10,10325,1 
.mob Kil'sorrow Spellbinder
.mob Kil'sorrow Cultist
.mob Kil'sorrow Deathsworn
.mob Kil'sorrow Invader
.mob Kil'sorrow Ritualist
.mob Kil'sorrow Agent
step
.goto Nagrand,73.81,62.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lantresor of the Blade|r
.turnin 9928 >>Turn in Armaments for Deception
.turnin 9927 >>Turn in Ruthless Cunning
.accept 9931 >>Accept Returning the Favor
.accept 9932 >>Accept Body of Evidence
.target Lantresor of the Blade
step
#sticky
#hidewindow
#label saved4a
#completewith Safari4
.subzone 3673 >> 1
step
#requires saved4a
#label Saved4
#completewith Safari4
>>Sometimes |cRXP_ENEMY_Gankly|r can appear at the Safari. This is a rare event
>>Kill |cRXP_ENEMY_Gankly|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kristen Dipswitch|r
.accept 9897 >> Accept I'm Saved!
.goto Nagrand,71.42,40.60,0
.unitscan Gankly Rottenfist
.target Kristen Dipswitch
step
#requires Saved4
#completewith Safari4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harold Lane|r
.turnin 9897 >> Turn in I'm Saved!
.goto Nagrand,71.38,40.62
.target Harold Lane
step
#sticky
#label talbuk3
.goto 1951/530,6350.300,-1455.900
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harold Lane|r
.target Harold Lane
.turnin 9859 >>Turn in Talbuk Mastery
.isQuestComplete 9859
step
#sticky
#label windroc3
.goto 1951/530,6342.000,-1451.800
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shado 'Fitz' Farstrider|r
.target Shado 'Fitz' Farstrider
.turnin 9856 >>Turn in Windroc Mastery
.isQuestComplete 9856
step
.goto 1951/530,6343.300,-1461.000
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hemet Nesingwary|r
.target Hemet Nesingwary
.turnin 9851 >>Turn in Clefthoof Mastery
.isQuestComplete 9851
step
#requires windroc3
step
#requires talbuk3
#label Safari4
.goto Nagrand,71.52,40.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hemet Nesingwary|r
.accept 9852 >>Accept The Ultimate Bloodsport
.isQuestTurnedIn 9856
.isQuestTurnedIn 9859
.isQuestTurnedIn 9851
.target Hemet Nesingwary
step
#optional
#questguide << !tbc
#completewith next
.line Nagrand,62.19,22.60,61.99,22.09,61.28,22.24,60.88,21.39,60.38,20.88,59.87,21.32,59.58,22.48,60.08,24.41,60.57,25.04,61.15,24.92,61.72,24.54,62.19,22.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gordawg|r patrolling clockwise at the Throne of the Elements
.turnin 9849 >>Turn in Shattering the Veil
.isQuestComplete 9849


.unitscan Gordawg
step
.goto 1951/530,6937.200,-782.800
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elementalist Lo'ap|r
.target Elementalist Lo'ap
.turnin 9810 >> Turn in The Spirit Polluted
.turnin 9815 >>Turn in Muck Diving
step
.goto 1951/530,6952.800,-782.200
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elementalist Morgh|r
.target Elementalist Morgh
.turnin 9862 >>Turn in Murkblood Corrupters
step
#questguide << !tbc
.goto Nagrand,62.19,22.60,50,0
.goto Nagrand,61.99,22.09,50,0
.goto Nagrand,61.28,22.24,50,0
.goto Nagrand,60.88,21.39,50,0
.goto Nagrand,60.38,20.88,50,0
.goto Nagrand,59.87,21.32,50,0
.goto Nagrand,59.58,22.48,50,0
.goto Nagrand,60.08,24.41,50,0
.goto Nagrand,60.57,25.04,50,0
.goto Nagrand,61.15,24.92,50,0
.goto Nagrand,61.72,24.54
.line Nagrand,62.19,22.60,61.99,22.09,61.28,22.24,60.88,21.39,60.38,20.88,59.87,21.32,59.58,22.48,60.08,24.41,60.57,25.04,61.15,24.92,61.72,24.54,62.19,22.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gordawg|r patrolling clockwise at the Throne of the Elements
.turnin 9849 >>Turn in Shattering the Veil

.unitscan Gordawg
step
#optional
#completewith Zorbo
.use 25555 >>Kill |cRXP_ENEMY_Orcs|r. Use the |T132484:0|t[Kil'sorrow Banner] in your bags on their corpses
.complete 9940,2 
.mob +Warmaul Shaman
.complete 9940,3 
.complete 9931,1 
.mob +Warmaul Reaver
step
#completewith next
.goto Nagrand,46.57,24.40
.cast 32408 >> Use the |T133680:0|t[Damp Woolen Blanket] in your bags at the Funeral Pyre. Kill any |cRXP_ENEMY_Ogres|r the |cRXP_FRIENDLY_Saboteurs|r are attacking
.timer 62,Body of Evidence RP
.use 25658 

step
.goto Nagrand,46.57,24.40
>>Kill |cRXP_ENEMY_Ogres|r until the objective completes
.complete 9932,1 
step
#label Zorbo
.goto Nagrand,46.21,18.79,30,0
.goto Nagrand,46.49,18.18
>>Kill |cRXP_ENEMY_Zorbo|r
.complete 9940,1 
.mob Zorbo the Advisor
step
.goto Nagrand,49.22,21.66,50,0
.goto Nagrand,48.24,23.60,50,0
.goto Nagrand,46.59,24.43,50,0
.goto Nagrand,45.44,22.01,50,0
.goto Nagrand,43.65,21.51,50,0
.goto Nagrand,42.54,22.55
.use 25555 >>Kill |cRXP_ENEMY_Orcs|r. Use the |T132484:0|t[Kil'sorrow Banner] in your bags on their corpses
.complete 9940,2 
.mob +Warmaul Shaman
.complete 9940,3 
.complete 9931,1 
.mob +Warmaul Reaver
step
.goto Nagrand,42.77,20.73
>>Look for a group for The Ring of Blood questline. There are 6 elite quests that give a LOT of fast xp and a weapon that'll last you to 70. Only accept this when your party is ready and on the same quest progression as you. (Auto-accept is disabled for this questline). Skip this step if you can't find a group for it
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gurgthock|r
.accept 9962,1 >> Accept The Ring of Blood: Brokentoe
.target Gurgthock
step
.goto Nagrand,43.66,20.37
>>Kill |cRXP_ENEMY_Brokentoe|r in the Ring of Blood
.complete 9962,1 
.isOnQuest 9962
.mob Brokentoe
step
.goto Nagrand,42.77,20.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wodin the Troll-Servant|r
.turnin 9962 >> Turn in The Ring of Blood: Brokentoe
.isQuestComplete 9962
.target Wodin the Troll-Servant
step
.goto Nagrand,42.77,20.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gurgthock|r
.accept 9967,1 >> Accept The Ring of Blood: The Blue Brothers
.isQuestTurnedIn 9962
.target Gurgthock
step
.goto Nagrand,43.66,20.37
>>Kill the |cRXP_ENEMY_Blue Brothers|r in the Ring of Blood
.complete 9967,1 
.isOnQuest 9967
.mob Murkblood Twin
step
.goto Nagrand,42.77,20.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wodin the Troll-Servant|r
.turnin 9967 >> Turn in The Ring of Blood: The Blue Brothers
.isQuestComplete 9967
.target Wodin the Troll-Servant
step
.goto Nagrand,42.77,20.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gurgthock|r
.accept 9970,1 >> Accept The Ring of Blood: Rokdar the Sundered Lord
.isQuestTurnedIn 9967
.target Gurgthock
step
.goto Nagrand,43.66,20.37
>>Kill |cRXP_ENEMY_Rokdar the Sundered Lord|r in the Ring of Blood
.complete 9970,1 
.isOnQuest 9970
.mob Rokdar the Sundered Lord
step
.goto Nagrand,42.77,20.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wodin the Troll-Servant|r
.turnin 9970 >> Turn in The Ring of Blood: Rokdar the Sundered Lord
.isQuestComplete 9970
.target Wodin the Troll-Servant
step
.goto Nagrand,42.77,20.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gurgthock|r
.accept 9972,1 >> Accept The Ring of Blood: Skra'gath
.isQuestTurnedIn 9970
.target Gurgthock
step
.goto Nagrand,43.66,20.37
>>Kill |cRXP_ENEMY_Skra'gath|r in the Ring of Blood
.complete 9972,1 
.isOnQuest 9972
.mob Skra'gath
step
.goto Nagrand,42.77,20.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wodin the Troll-Servant|r
.turnin 9972 >> Turn in The Ring of Blood: Skra'gath
.isQuestComplete 9972
.target Wodin the Troll-Servant
step
.goto Nagrand,42.77,20.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gurgthock|r
.accept 9973,1 >> Accept The Ring of Blood: The Warmaul Champion
.isQuestTurnedIn 9972
.target Gurgthock
step
.goto Nagrand,43.66,20.37
>>Kill |cRXP_ENEMY_The Warmaul Champion|r in the Ring of Blood
.complete 9973,1 
.isOnQuest 9973
.mob Warmaul Champion
step
.goto Nagrand,42.77,20.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wodin the Troll-Servant|r
.turnin 9973 >> Turn in The Ring of Blood: The Warmaul Champion
.isQuestComplete 9973
.target Wodin the Troll-Servant
step
.goto Nagrand,42.77,20.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gurgthock|r
.accept 9977,1 >> Accept The Ring of Blood: The Final Challenge
.isQuestTurnedIn 9973
.target Gurgthock
step
.goto Nagrand,43.43,20.57
>>Kill |cRXP_ENEMY_Mogor|r in the Ring of Blood (twice)
.complete 9977,1 
.isOnQuest 9977
.mob Mogor
step
.goto Nagrand,42.77,20.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wodin the Troll-Servant|r
.turnin 9977 >> Turn in The Ring of Blood: The Final Challenge
.isQuestComplete 9977
.target Wodin the Troll-Servant
step
#completewith Corki4
.goto Nagrand,26.50,22.70,0
>>Loot the silver |cRXP_PICK_Supply Crates|r on the ground in the caves and outside
.complete 9956,1 
step
#completewith SupplyC
>>Kill |cRXP_ENEMY_Ogres|r. Loot them for their |cRXP_LOOT_Warbeads|r
.collect 25433,10,10476,1 
.mob Warmaul Brute
.mob Warmaul Warlock
step
#optional
#completewith next
.goto Nagrand,28.69,30.85,40,0
.goto Nagrand,25.93,28.93,40,0
.goto Nagrand,24.57,24.66,40 >> Take the path up to the top of the mountain
.skill riding,225,1
step
#label Corki4
.goto Nagrand,29.54,26.06
>>Go into the southern ogre cave atop the mountain.
>>|cRXP_FRIENDLY_Corki|r is guarded by an |cRXP_WARN_Elite Ogre|r, |cRXP_ENEMY_Bufferlo|r. You |cRXP_WARN_DO NOT|r have to kill |cRXP_ENEMY_Bufferlo|r. Just talk to |cRXP_FRIENDLY_Corki|r and run away<<tbc/wotlk
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Corki|r
.turnin 9954 >> Turn in Corki's Ransom
.target Corki
step
#questguide << tbc/wotlk
.goto Nagrand,29.54,26.06
>>Go into the southern ogre cave atop the mountain.
>>|cRXP_FRIENDLY_Corki|r is guarded by an |cRXP_WARN_Elite Ogre|r, |cRXP_ENEMY_Bufferlo|r. You |cRXP_WARN_DO NOT|r have to kill |cRXP_ENEMY_Bufferlo|r. Just talk to |cRXP_FRIENDLY_Corki|r and run away<<tbc/wotlk
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Corki|r
.accept 9955 >> Accept Cho'war the Pillager
.target Corki
step
#questguide << tbc/wotlk
#completewith next
.flygoto Nagrand,27.55,11.22,45 >> Fly up to the back entrance of the cave
step
#questguide << tbc/wotlk
.goto Nagrand,25.38,15.31,30,0
.goto Nagrand,26.23,15.61,30,0
.goto Nagrand,25.91,13.72
>>Kill |cRXP_ENEMY_Cho'war the Pillager|r. Loot him for his |cRXP_LOOT_Key|r. This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him.
.collect 25648,1,9955,1 
.mob Cho'war the Pillager
step
#questguide << tbc/wotlk
#label Corki4
.goto Nagrand,29.54,26.06
>>Go into the southern ogre cave atop the mountain. Click on |cRXP_FRIENDLY_Corki's|r Cage.
>>|cRXP_FRIENDLY_Corki|r is guarded by an |cRXP_WARN_Elite Ogre|r, |cRXP_ENEMY_Bufferlo|r. You will have to kill or distract him in order to open the cage << tbc/wotlk
.complete 9955,1 
step
#label SupplyC
#loop
.groundgoto Nagrand,28.96,31.19,60,0
.groundgoto Nagrand,28.09,29.94,60,0
.goto Nagrand,24.71,30.48,50,0
.goto Nagrand,23.63,31.77,30,0
.goto Nagrand,23.14,29.32,50,0
.goto Nagrand,23.43,28.29,50,0
.goto Nagrand,24.67,27.54,50,0
.groundgoto Nagrand,26.42,29.74,40,0
.groundgoto Nagrand,24.60,24.92,40,0
.goto Nagrand,25.64,24.47,30,0
.goto Nagrand,27.24,23.87,30,0
.goto Nagrand,29.21,25.74,30,0
.goto Nagrand,25.81,20.33,50,0
.goto Nagrand,27.64,18.92,50,0
.groundgoto Nagrand,28.96,31.19,60,0
.groundgoto Nagrand,28.09,29.94,60,0
.goto Nagrand,24.71,30.48,50,0
.goto Nagrand,23.63,31.77,30,0
.goto Nagrand,23.14,29.32,50,0
.goto Nagrand,23.43,28.29,50,0
.goto Nagrand,24.67,27.54,50,0
.groundgoto Nagrand,26.42,29.74,40,0
.groundgoto Nagrand,24.60,24.92,40,0
.goto Nagrand,25.64,24.47,30,0
.goto Nagrand,27.24,23.87,30,0
.goto Nagrand,29.21,25.74,30,0
.goto Nagrand,25.81,20.33,50,0
.goto Nagrand,27.64,18.92,0
>>Loot the silver |cRXP_PICK_Supply Crates|r on the ground in the caves and outside
.complete 9956,1 
step
#loop
.groundgoto Nagrand,28.96,31.19,60,0
.groundgoto Nagrand,28.09,29.94,60,0
.goto Nagrand,24.71,30.48,50,0
.goto Nagrand,23.63,31.77,30,0
.goto Nagrand,23.14,29.32,50,0
.goto Nagrand,23.43,28.29,50,0
.goto Nagrand,24.67,27.54,50,0
.groundgoto Nagrand,26.42,29.74,40,0
.groundgoto Nagrand,24.60,24.92,40,0
.goto Nagrand,25.64,24.47,30,0
.goto Nagrand,27.24,23.87,30,0
.goto Nagrand,29.21,25.74,30,0
.goto Nagrand,25.81,20.33,50,0
.goto Nagrand,27.64,18.92,50,0
.groundgoto Nagrand,28.96,31.19,60,0
.groundgoto Nagrand,28.09,29.94,60,0
.goto Nagrand,24.71,30.48,50,0
.goto Nagrand,23.63,31.77,30,0
.goto Nagrand,23.14,29.32,50,0
.goto Nagrand,23.43,28.29,50,0
.goto Nagrand,24.67,27.54,50,0
.groundgoto Nagrand,26.42,29.74,40,0
.groundgoto Nagrand,24.60,24.92,40,0
.goto Nagrand,25.64,24.47,30,0
.goto Nagrand,27.24,23.87,30,0
.goto Nagrand,29.21,25.74,30,0
.goto Nagrand,25.81,20.33,50,0
.goto Nagrand,27.64,18.92,0
>>Kill |cRXP_ENEMY_Ogres|r. Loot them for their |cRXP_LOOT_Warbeads|r
.collect 25433,10,10476,1 
.mob Warmaul Brute
.mob Warmaul Warlock
step
#completewith next
.hs >> Hearth to Telaar
step
#sticky
#label HuntKima
.goto Nagrand,53.69,68.70,40,0
.goto Nagrand,54.01,69.11,40,0
.goto Nagrand,54.33,70.32,40,0
.goto Nagrand,54.75,70.41,40,0
.goto Nagrand,54.97,70.91,40,0
.goto Nagrand,55.30,71.42,40,0
.goto Nagrand,55.70,72.60,40,0
.goto Nagrand,55.61,73.18,40,0
.goto Nagrand,54.71,73.30,40,0
.goto Nagrand,54.53,73.66,40,0
.goto Nagrand,54.53,72.64,40,0
.goto Nagrand,54.30,72.28,40,0
.goto Nagrand,53.71,72.24,40,0
.goto Nagrand,53.52,71.94,40,0
.goto Nagrand,53.82,71.30,40,0
.goto Nagrand,53.42,70.82,40,0
.goto Nagrand,52.93,70.80,40,0
.goto Nagrand,53.16,70.24,40,0
.goto Nagrand,53.56,70.43,40,0
.goto Nagrand,54.10,69.56,40,0
.goto Nagrand,54.03,69.16,40,0
.goto Nagrand,53.69,68.70,40,0
.line Nagrand,53.69,68.70,54.03,69.16,54.10,69.56,53.56,70.43,53.16,70.24,52.93,70.80,53.42,70.82,53.82,71.30,53.52,71.94,53.71,72.24,54.30,72.28,54.53,72.64,54.53,73.66,54.71,73.30,55.61,73.18,55.70,72.60,55.30,71.42,54.97,70.91,54.75,70.41,54.33,70.32,54.01,69.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Huntress Kima|r. She patrols counter-clockwise around Telaar
.turnin 9956 >> Turn in The Ravaged Caravan
.unitscan Huntress Kima
step
.goto 1951/530,7270.600,-2568.500
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Warden Moi'bff Jill|r
.target Warden Moi'bff Jill
.accept 10476 >>Accept Fierce Enemies
.turnin 10476 >>Turn in Fierce Enemies
.turnin 9936 >>Turn in Wanted: Giselda the Crone
.turnin 9940 >>Turn in Wanted: Zorbo the Advisor
.accept 9938 >>Accept Wanted: Durn the Hungerer << !tbc !wotlk
step
#optional << tbc/wotlk
#requires HuntKima
.goto 1951/530,7230.800,-2489.700
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arechron|r
.target Arechron
.turnin 9955 >>Turn in Cho'war the Pillager
.isQuestComplete 9955
step
>>Kill |cRXP_ENEMY_Tusker|r. Loot her for her |cRXP_LOOT_Heart|r
>>You can kite her back to Telaar if needed. She is NOT slowable, but moves at only about 110% movespeed. This quest is difficult. Find a group for her if needed. Skip this step if you're unable to find a group or solo her.<<tbc/wotlk
.goto Nagrand,44.50,65.24
.complete 9852,1 
.isOnQuest 9852
.mob Tusker
step << !tbc !wotlk
#loop
.goto Nagrand,46.6,61.4,60,0
.goto Nagrand,43.6,75.8,60,0
.goto Nagrand,34.4,78.0,60,0
.goto Nagrand,30.2,62.0,60,0
.goto Nagrand,40,60,90,0
.goto Nagrand,46.6,61.4,0
.goto Nagrand,43.6,75.8,0
.goto Nagrand,34.4,78.0,0
.goto Nagrand,30.2,62.0,0
.goto Nagrand,40,60,0
>>Kill |cRXP_ENEMY_Durn the Hungerer|r, he patrols around Oshu'gun
.complete 9938,1 
.mob Durn the Hungerer
step << Mage
#completewith next
.zone Shattrath City >> Teleport to Shattrath
.skill riding,<225,1
step
.goto Nagrand,73.81,62.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lantresor of the Blade|r
.turnin 9931 >> Turn in Returning the Favor
.turnin 9932 >> Turn in Body of Evidence
.accept 9933 >> Accept Message to Telaar
.target Lantresor of the Blade
step
#completewith next
.hs >> Hearth to Telaar
.cooldown item,6948,>2
step << !tbc !wotlk
.goto 1951/530,7270.600,-2569.500
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Warden Moi'bff Jill|r
.target Warden Moi'bff Jill
.turnin 9938 >>Turn in Wanted: Durn the Hungerer
step
.goto Nagrand,55.48,68.70
>>Return to Telaar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arechron|r
.turnin 9933 >> Turn in Message to Telaar
.target Arechron
step
#label Saved5
#completewith Safari5
>>Sometimes |cRXP_ENEMY_Gankly|r can appear at the Safari. This is a rare event
>>Kill |cRXP_ENEMY_Gankly|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kristen Dipswitch|r
.accept 9897 >> Accept I'm Saved!
.goto Nagrand,71.42,40.60,0
.unitscan Gankly Rottenfist
.target Kristen Dipswitch
step
#requires Saved5
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harold Lane|r
.turnin 9897 >> Turn in I'm Saved!
.goto Nagrand,71.38,40.62
.target Harold Lane
step
#label Safari5
.goto Nagrand,71.52,40.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hemet Nesingwary|r
.turnin 9852 >>Turn in The Ultimate Bloodsport
.isQuestComplete 9852
.target Hemet Nesingwary
step
#aldor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Adyen the Lightwarden|r
.goto Shattrath City,30.72,34.63
.accept 10325 >> Accept Marks of Kil'jaeden
.turnin 10325 >> Turn in Marks of Kil'jaeden
.target Adyen the Lightwarden
.itemcount 29425,10
]])
RXPGuides.RegisterGuide([[
#version 5
#cata
#Cata
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 65-67 Blade's Edge
#version 5

#next 67-69 Netherstorm << TBC
#next 67-67 Blade's Edge Turn-ins << !TBC
step
#completewith next
.goto Shattrath City,64.05,41.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nutral|r
.fly Telredor >> Fly to Telredor
.zoneskip Nagrand
.zoneskip Zangarmarsh
.skill riding,300,1
.target Nutral
step
#questguide << !tbc
.goto Zangarmarsh,68.3,49.4
>>Return to Telredor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Ahuurn|r
.turnin 9801 >>Turn in Gathering the Reagents
.isQuestComplete 9801
.target Anchorite Ahuurn
step
#optional
#completewith Moonwhisper
.goto Shattrath City,64.05,41.12,-1
.goto Zangarmarsh,67.83,51.46,-1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nutral|r or |cRXP_FRIENDLY_Munci|r
>>|cRXP_WARN_The arrow will point you to the closest Flight Master|r
.fly Orebor Harborage >> Fly to Orebor Harborage
.skill riding,300,1
.target Nutral
.target Munci
step
.goto Zangarmarsh,41.21,28.68
>>Travel to Orebor Harborage
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Timothy Daniels|r
.accept 9794 >> Accept No Time for Curiosity
.maxlevel 66,bemend	<< !tbc
.target Timothy Daniels
step
#label Moonwhisper
.goto Blade's Edge Mountains,32.20,91.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sentinel Moonwhisper|r outside the tunnel entrance
.accept 10927 >> Accept Killing the Crawlers
.maxlevel 66,bemend	<< !tbc
.target Sentinel Moonwhisper
step
.goto Blade's Edge Mountains,34.61,88.05,40,0
.goto Blade's Edge Mountains,35.00,85.60,40,0
.goto Blade's Edge Mountains,36.83,83.44,40,0
.goto Blade's Edge Mountains,37.20,81.01
>>Kill |cRXP_ENEMY_Cavern Crawlers|r
>>|cRXP_WARN_You can mount up inside the cave|r
.complete 10927,1 
.isOnQuest 10927
.mob Cavern Crawler
step
>>Travel to Sylvanaar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kialon Nightblade|r, |cRXP_FRIENDLY_Rina Moonspring|r, |cRXP_FRIENDLY_The Wanted Poster|r and |cRXP_FRIENDLY_Commander Skyshadow|r
.turnin 9794 >> Turn in No Time for Curiosity
.goto Blade's Edge Mountains,35.97,67.76,30,0
.goto Blade's Edge Mountains,36.61,67.34
.target +Kialon Nightblade
.accept 10455 >> Accept The Encroaching Wilderness
.goto Blade's Edge Mountains,36.21,67.13
.target +Rina Moonspring
.accept 10690 >> Accept The Den Mother
.goto Blade's Edge Mountains,36.61,67.29
.accept 10502 >> Accept The Bloodmaul Ogres
.turnin 10927 >> Turn in Killing the Crawlers
.goto Blade's Edge Mountains,36.28,66.24
.target +Commander Skyshadow
.maxlevel 66,bemend	<< !tbc
step
#completewith Lashh
.goto Blade's Edge Mountains,35.80,63.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Shaunessy|r
.home >> Set your Hearthstone to Sylvanaar
.maxlevel 66,bemend	<< !tbc
.target Innkeeper Shaunessy
step
.goto Blade's Edge Mountains,37.82,61.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amerun Leafshade|r
.fp Sylvanaar >> Get the Sylvanaar flight path
.maxlevel 66,bemend	<< !tbc
.target Amerun Leafshade
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Borgrim Stouthammer|r, |cRXP_FRIENDLY_Bronwyn Stouthammer|r inside and |cRXP_FRIENDLY_Daranelle|r outside
.accept 10511 >> Accept Strange Brew
.goto Blade's Edge Mountains,37.40,64.66
.target +Borgrim Stouthammer
.accept 10510 >> Accept Into the Draenethyst Mine
.goto Blade's Edge Mountains,37.41,65.05
.target +Bronwyn Stouthammer
.accept 10555 >> Accept Malaise
.goto Blade's Edge Mountains,37.07,65.62
.target +Daranelle
.maxlevel 66,bemend	<< !tbc
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Grovestalker Lynxes|r
.complete 10455,1 
.isOnQuest 10455
.mob Grovestalker Lynx
step
#label Lashh
.goto Blade's Edge Mountains,35.75,73.61,40,0
.goto Blade's Edge Mountains,34.23,75.61,40,0
.goto Blade's Edge Mountains,34.92,78.78,40,0
.goto Blade's Edge Mountains,35.72,75.07,40,0
.goto Blade's Edge Mountains,34.31,77.40
>>Kill |cRXP_ENEMY_Lashh'an|r. Loot them for their |cRXP_LOOT_Feathers|r
.complete 10555,1 
.isOnQuest 10555
.mob Lashh'an Matriarch
.mob Lashh'an Talonite
.mob Lashh'an Windwalker
.mob Lashh'an Windwalker
step
.goto Blade's Edge Mountains,34.31,77.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Tome|r atop the tree platform
.turnin 10555 >> Turn in Malaise
.accept 10556 >> Accept Scratches
.maxlevel 66,bemend	<< !tbc
step
.goto Blade's Edge Mountains,35.23,77.31
.cast 36904 >> |cRXP_WARN_Use the|r |T132926:0|t[Fistful of Feathers] |cRXP_WARN_at the summoning circle|r
.use 30530
.isOnQuest 10556
step
.goto Blade's Edge Mountains,35.23,77.31,0
.goto Blade's Edge Mountains,36.94,79.00,50,0
.goto Blade's Edge Mountains,38.17,79.10,50,0
.goto Blade's Edge Mountains,37.94,73.50,50,0
.goto Blade's Edge Mountains,39.44,71.43,50,0
.goto Blade's Edge Mountains,41.51,67.91,50,0
.goto Blade's Edge Mountains,39.59,67.21,50,0
.goto Blade's Edge Mountains,37.84,71.74,50,0
.goto Blade's Edge Mountains,35.44,71.09
>>|cRXP_WARN_After using the|r |T132926:0|t[Fistful of Feathers]|cRXP_WARN_, a |cRXP_FRIENDLY_Small Bird Companion|r will follow you around|r
>>|cRXP_WARN_Be aware that the |cRXP_FRIENDLY_Bird|r can't keep up with you if you run off on your mount|r
>>Kill |cRXP_ENEMY_Grovestalker Lynxes|r
.complete 10455,1 
.isOnQuest 10455
.use 30530
.mob Grovestalker Lynx
.target Kaliri Totem
step
>>Escort the |cRXP_FRIENDLY_Bird|r back to Sylvanaar
>>|cRXP_WARN_Be aware that the |cRXP_FRIENDLY_Bird|r can't keep up with you if you run off on your mount|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Daranelle|r and |cRXP_FRIENDLY_Rina Moonspring|r
.turnin 10556 >> Turn in Scratches
.goto Blade's Edge Mountains,37.07,65.62
.target +Daranelle
.turnin 10455 >> Turn in The Encroaching Wilderness
.accept 10456 >> Accept Marauding Wolves
.goto Blade's Edge Mountains,36.21,67.13
.target +Rina Moonspring
.use 30530
.target Kaliri Totem
.maxlevel 66,bemend	<< !tbc
step
#optional
#completewith next
.goto Blade's Edge Mountains,41.81,65.64,50,0
.goto Blade's Edge Mountains,48.40,65.00,50 >> Cross the bridge to the Jagged Ridge
.skill riding,225,1
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Thunderlord Dire Wolves|r. Loot them for their |cRXP_LOOT_Tails|r
.complete 10456,1 
.isOnQuest 10456
.mob Thunderlord Dire Wolf
step
.goto Blade's Edge Mountains,51.62,74.97
>>Kill |cRXP_ENEMY_Rema|r
.complete 10690,1 
.isOnQuest 10690
.mob Rema
step
#loop
.line Blade's Edge Mountains,51.93,73.59,51.99,72.57,52.51,71.54,52.53,69.57,55.12,68.14,54.67,65.56,52.94,67.62,51.69,66.58,50.94,65.14,50.61,60.12,49.31,62.79,50.28,67.75,49.33,69.22,50.32,70.41,51.93,73.59
.goto Blade's Edge Mountains,51.93,73.59,50,0
.goto Blade's Edge Mountains,51.99,72.57,50,0
.goto Blade's Edge Mountains,52.51,71.54,50,0
.goto Blade's Edge Mountains,52.53,69.57,50,0
.goto Blade's Edge Mountains,55.12,68.14,50,0
.goto Blade's Edge Mountains,54.67,65.56,50,0
.goto Blade's Edge Mountains,52.94,67.62,50,0
.goto Blade's Edge Mountains,51.69,66.58,50,0
.goto Blade's Edge Mountains,50.94,65.14,50,0
.goto Blade's Edge Mountains,50.61,60.12,50,0
.goto Blade's Edge Mountains,49.31,62.79,50,0
.goto Blade's Edge Mountains,50.28,67.75,50,0
.goto Blade's Edge Mountains,49.33,69.22,50,0
.goto Blade's Edge Mountains,50.32,70.41,50,0
.goto Blade's Edge Mountains,51.93,73.59,50,0
>>Kill |cRXP_ENEMY_Thunderlord Dire Wolves|r. Loot them for their |cRXP_LOOT_Tails|r
.complete 10456,1 
.isOnQuest 10456
.mob Thunderlord Dire Wolf
step
#optional
#completewith next
.goto Blade's Edge Mountains,56.09,72.09,50,0
.goto Blade's Edge Mountains,56.81,70.12,50,0
.goto Blade's Edge Mountains,57.72,70.31,50 >> Go up the path toward Toshley's Station
.skill riding,225,1
step
.goto Blade's Edge Mountains,61.16,70.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rip Pedalslam|r
.fp Toshley's Station >> Get the Toshley's Station flight path
.target Rip Pedalslam
step
#completewith SylHS
.hs >> Hearth to Sylvanaar
.cooldown item,6948,>2
step
#optional
#completewith next
.goto Blade's Edge Mountains,61.16,70.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rip Pedalslam|r
.fly Sylvanaar >> Fly to Sylvanaar
.cooldown item,6948,<0
.target Rip Pedalslam
step
#label SylHS
>>Return to Sylvanaar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Skyshadow|r and |cRXP_FRIENDLY_Rina Moonspring|r
.turnin 10690 >> Turn in The Den Mother
.goto Blade's Edge Mountains,36.28,66.24
.target +Commander Skyshadow
.turnin 10456 >> Turn in Marauding Wolves
.accept 10457 >> Accept Protecting Our Own
.goto Blade's Edge Mountains,36.21,67.13
.target +Rina Moonspring
.maxlevel 66,bemend	<< !tbc
step
#loop
.line Blade's Edge Mountains,36.43,69.86,36.44,71.16,35.95,71.95,37.26,72.60,37.73,73.94,38.27,72.71,38.85,73.59,39.01.71.93,40.24,70.33,39.85,69.00,38.21,69.06,36.43,69.86
.goto Blade's Edge Mountains,36.43,69.86,30,0
.goto Blade's Edge Mountains,36.44,71.16,30,0
.goto Blade's Edge Mountains,35.95,71.95,30,0
.goto Blade's Edge Mountains,37.26,72.60,30,0
.goto Blade's Edge Mountains,37.73,73.94,30,0
.goto Blade's Edge Mountains,38.27,72.71,30,0
.goto Blade's Edge Mountains,38.85,73.59,30,0
.goto Blade's Edge Mountains,70.33,40.24,30,0
.goto Blade's Edge Mountains,69.00,39.85,30,0
.goto Blade's Edge Mountains,69.06,38.21,30,0
.goto Blade's Edge Mountains,69.86,36.43,30,0
>>Click the |cRXP_PICK_Grove Seedlings|r on the ground
.complete 10457,1 
.isOnQuest 10457
step
>>Return to Sylvanaar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rina Moonspring|r
.turnin 10457 >> Turn in Protecting Our Own
.accept 10506 >> Accept A Dire Situation
.goto Blade's Edge Mountains,36.21,67.13
.maxlevel 66,bemend	<< !tbc
.target Rina Moonspring
step
#optional
#completewith MineC
>>Kill |cRXP_ENEMY_Bloodmaul Ogres|r. Loot |cRXP_ENEMY_Bloodmaul Brewmasters|r for their |cRXP_LOOT_Bloodmaul Brutebane Brew|r
>>Open the |cRXP_PICK_Bloodmaul Brew Kegs|r. Loot them for the |cRXP_LOOT_Bloodmaul Brutebane Brew|r
.use 30251 >> |cRXP_WARN_Use|r |T133852:0|t[Rina's Diminution Powder] |cRXP_WARN_on|r |cRXP_ENEMY_Bloodmaul Wolves|r
.complete 10502,1 
.complete 10511,1 
.complete 10506,1 
.mob +Bloodmaul Dire Wolf
.isOnQuest 10502
.isOnQuest 10506
.isOnQuest 10511
.mob Bloodmaul Skirmisher
.mob Bloodmaul Geomancer
.mob Bloodmaul Lookout
.mob Bloodmaul Brewmaster
.mob Bloodmaul Shaman
.mob Bloodmaul Brute
.mob Bloodmaul Drudger
step
#completewith next
.goto Blade's Edge Mountains,42.48,83.51,40 >>Enter the mine
step
#label MineC
.goto Blade's Edge Mountains,42.38,84.54,30,0
.goto Blade's Edge Mountains,41.15,85.56,30,0
.goto Blade's Edge Mountains,40.59,83.58,30,0
.goto Blade's Edge Mountains,39.73,83.35,30,0
.goto Blade's Edge Mountains,39.45,85.72,30,0
.goto Blade's Edge Mountains,40.09,85.42
>>Kill |cRXP_ENEMY_Bloodmaul Drudgers|r. Loot them for their |cRXP_LOOT_Draenethyst Crystals|r
>>|cRXP_WARN_The|r |cRXP_LOOT_Draenethyst Crystals|r |cRXP_WARN_can also be looted inside the mine|r
.complete 10510,1 
.isOnQuest 10510
.mob Bloodmaul Drudger
step
#loop
.line Blade's Edge Mountains,46.38,76.02,47.76,74.83,46.81,79.64,45.90,77.84,44.37,82.35,43.36,81.29,41.88,83.17,42.07,79.05,43.73,77.33,42.78,73.28,46.38,76.02
.goto Blade's Edge Mountains,46.38,76.02,55,0
.goto Blade's Edge Mountains,47.76,74.83,55,0
.goto Blade's Edge Mountains,46.81,79.64,55,0
.goto Blade's Edge Mountains,45.90,77.84,55,0
.goto Blade's Edge Mountains,44.37,82.35,55,0
.goto Blade's Edge Mountains,43.36,81.29,55,0
.goto Blade's Edge Mountains,41.88,83.17,55,0
.goto Blade's Edge Mountains,42.07,79.05,55,0
.goto Blade's Edge Mountains,43.73,77.33,55,0
.goto Blade's Edge Mountains,42.78,73.28,55,0
.goto Blade's Edge Mountains,46.38,76.02,55,0
>>Kill |cRXP_ENEMY_Bloodmaul Ogres|r. Loot |cRXP_ENEMY_Bloodmaul Brewmasters|r for their |cRXP_LOOT_Bloodmaul Brutebane Brew|r
>>Open the |cRXP_PICK_Bloodmaul Brew Kegs|r. Loot them for the |cRXP_LOOT_Bloodmaul Brutebane Brew|r
.use 30251 >> |cRXP_WARN_Use|r |T133852:0|t[Rina's Diminution Powder] |cRXP_WARN_on|r |cRXP_ENEMY_Bloodmaul Wolves|r
.complete 10502,1 
.complete 10511,1 
.complete 10506,1 
.mob +Bloodmaul Dire Wolf
.isOnQuest 10502
.isOnQuest 10506
.isOnQuest 10511
.mob Bloodmaul Skirmisher
.mob Bloodmaul Geomancer
.mob Bloodmaul Lookout
.mob Bloodmaul Brewmaster
.mob Bloodmaul Shaman
.mob Bloodmaul Brute
.mob Bloodmaul Drudger
step
#completewith next
.hs >> Hearth to Sylvanaar
.cooldown item,6948,>2
step
>>Return to Sylvanaar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rina Moonspring|r, |cRXP_FRIENDLY_Commander Skyshadow|r, |cRXP_FRIENDLY_Bronwyn Stouthammer|r and |cRXP_FRIENDLY_Borgrim Stouthammer|r
.turnin 10506 >> Turn in A Dire Situation
.goto Blade's Edge Mountains,36.21,67.13
.target +Rina Moonspring
.turnin 10502 >> Turn in The Bloodmaul Ogres
.accept 10504 >> Accept The Bladespire Ogres
.goto Blade's Edge Mountains,36.28,66.24
.target +Commander Skyshadow
.turnin 10510 >> Turn in Into the Draenethyst Mine
.goto Blade's Edge Mountains,37.41,65.05
.target +Bronwyn Stouthammer
.turnin 10511 >> Turn in Strange Brew
.accept 10512 >> Accept Getting the Bladespire Tanked
.goto Blade's Edge Mountains,37.40,64.66
.target +Borgrim Stouthammer
.maxlevel 66,bemend	<< !tbc
step
#optional
#completewith BladeDrunk
>>Kill |cRXP_ENEMY_Bladespire Ogres|r
.complete 10504,1 
.isOnQuest 10504
.mob Bladespire Shaman
.mob Bladespire Cook
.mob Bladespire Champion
.mob Bladespire Sober Defender
.mob Bladespire Brute
step
#optional
.goto Blade's Edge Mountains,44.01,51.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Vuuleen|r
>>|cRXP_WARN_You can carefully jump down the northern side of Sylvanaar to get to her|r
.accept 10516 >> Accept The Trappings of a Vindicator
.skill riding,225,1
.maxlevel 66,bemend	<< !tbc
.target Vindicator Vuuleen
step
.goto Blade's Edge Mountains,44.01,51.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Vuuleen|r
.accept 10516 >> Accept The Trappings of a Vindicator
.skill riding,<225,1
.maxlevel 66,bemend	<< !tbc
.target Vindicator Vuuleen
step
.goto Blade's Edge Mountains,38.77,52.61
>>|cRXP_WARN_Kill the two |cRXP_ENEMY_Ogres|r nearest to the door|r
>>|cRXP_WARN_Use the|r |T132621:0|t[Brutebane Keg] |cRXP_WARN_to lure |cRXP_ENEMY_Droggam|r away from the elite guards|r
>>Kill |cRXP_ENEMY_Droggam|r. Loot him for the |cRXP_LOOT_Blade|r
.complete 10516,1 
.use 30353
.isOnQuest 10516
.mob Bladespire Shaman
.mob Bladespire Brute
.unitscan Droggam
step
.goto Blade's Edge Mountains,42.46,58.96
>>|cRXP_WARN_Kill the three |cRXP_ENEMY_Ogres|r nearest to the door|r
>>|cRXP_WARN_Use the|r |T132621:0|t[Brutebane Keg] |cRXP_WARN_to lure |cRXP_ENEMY_Mugdorg|r away from the elite guards|r
>>Kill |cRXP_ENEMY_Mugdorg|r. Loot him for the |cRXP_LOOT_Shield|r
.complete 10516,2 
.use 30353
.isOnQuest 10516
.mob Bladespire Shaman
.mob Bladespire Brute
.unitscan Mugdorg
step
.goto Blade's Edge Mountains,44.01,51.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Vuuleen|r
.turnin 10516 >> Turn in The Trappings of a Vindicator
.accept 10517 >> Accept Gorr'Dim, Your Time Has Come...
.maxlevel 66,bemend	<< !tbc
.target Vindicator Vuuleen
step
.goto Blade's Edge Mountains,39.38,49.06
>>|cRXP_WARN_Kill the three |cRXP_ENEMY_Ogres|r nearest to the door|r
>>|cRXP_WARN_Use the|r |T132621:0|t[Brutebane Keg] |cRXP_WARN_to lure |cRXP_ENEMY_Gorr'Dim|r away from the elite guards|r
>>Kill |cRXP_ENEMY_Gorr'Dim|r. Loot him for the |cRXP_LOOT_Shield|r
.complete 10517,1 
.use 30353
.isOnQuest 10517
.mob Bladespire Shaman
.mob Bladespire Brute
.unitscan Gorr'Dim
step
.goto Blade's Edge Mountains,44.01,51.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Vuuleen|r
.turnin 10517 >> Turn in Gorr'Dim, Your Time Has Come...
.accept 10518 >> Accept Planting the Banner
.maxlevel 66,bemend	<< !tbc
.target Vindicator Vuuleen
step
.goto Blade's Edge Mountains,41.29,46.72
>>Kill the |cRXP_ENEMY_Bladespire Champion|r. Loot him for his |cRXP_LOOT_Banner|r
.complete 10518,1 
.isOnQuest 10518
.mob Bladespire Champion
step
#label BladeDrunk
#loop
.line Blade's Edge Mountains,43.48,46.85,41.40,46.63,39.81,49.22,38.90,52.64,38.44,56.05,38.99,57.99,40.23,58.34,42.32,58.35,42.57,54.37,42.11,52.30,47.50,52.35,49.61,50.17,42.91,48.97,43.48,46.85
.goto Blade's Edge Mountains,43.48,46.85,60,0
.goto Blade's Edge Mountains,41.40,46.63,60,0
.goto Blade's Edge Mountains,39.81,49.22,60,0
.goto Blade's Edge Mountains,38.90,52.64,60,0
.goto Blade's Edge Mountains,38.44,56.05,60,0
.goto Blade's Edge Mountains,38.99,57.99,60,0
.goto Blade's Edge Mountains,40.23,58.34,60,0
.goto Blade's Edge Mountains,42.32,58.35,60,0
.goto Blade's Edge Mountains,42.57,54.37,60,0
.goto Blade's Edge Mountains,42.11,52.30,60,0
.goto Blade's Edge Mountains,47.50,52.35,60,0
.goto Blade's Edge Mountains,49.61,50.17,60,0
.goto Blade's Edge Mountains,42.91,48.97,60,0
.goto Blade's Edge Mountains,43.48,46.85,60,0
>>|cRXP_WARN_Use the|r |T132621:0|t[Brutebane Keg] |cRXP_WARN_near |cRXP_ENEMY_Ogres|r to get them drunk|r
.complete 10512,1 
.use 30353
.isOnQuest 10512
.mob Bladespire Shaman
.mob Bladespire Cook
.mob Bladespire Champion
.mob Bladespire Sober Defender
.mob Bladespire Brute
step
#loop
.line Blade's Edge Mountains,43.48,46.85,41.40,46.63,39.81,49.22,38.90,52.64,38.44,56.05,38.99,57.99,40.23,58.34,42.32,58.35,42.57,54.37,42.11,52.30,47.50,52.35,49.61,50.17,42.91,48.97,43.48,46.85
.goto Blade's Edge Mountains,43.48,46.85,60,0
.goto Blade's Edge Mountains,41.40,46.63,60,0
.goto Blade's Edge Mountains,39.81,49.22,60,0
.goto Blade's Edge Mountains,38.90,52.64,60,0
.goto Blade's Edge Mountains,38.44,56.05,60,0
.goto Blade's Edge Mountains,38.99,57.99,60,0
.goto Blade's Edge Mountains,40.23,58.34,60,0
.goto Blade's Edge Mountains,42.32,58.35,60,0
.goto Blade's Edge Mountains,42.57,54.37,60,0
.goto Blade's Edge Mountains,42.11,52.30,60,0
.goto Blade's Edge Mountains,47.50,52.35,60,0
.goto Blade's Edge Mountains,49.61,50.17,60,0
.goto Blade's Edge Mountains,42.91,48.97,60,0
.goto Blade's Edge Mountains,43.48,46.85,60,0
>>Kill |cRXP_ENEMY_Bladespire Ogres|r
.complete 10504,1 
.isOnQuest 10504
.mob Bladespire Shaman
.mob Bladespire Cook
.mob Bladespire Champion
.mob Bladespire Sober Defender
.mob Bladespire Brute
step
.goto Blade's Edge Mountains,46.66,74.82
>>|cRXP_WARN_Use the|r |T132484:0|t[Bladespire Banner] |cRXP_WARN_atop the tower to start the event. You will have to deal with 3 waves of 3 mobs|r
>>|cRXP_WARN_Use the|r |T132621:0|t[Brutebane Keg] |cRXP_WARN_at the end of the ramp to pick them apart and only deal with 1 or 2 |cRXP_ENEMY_Ogres|r at a time|r
>>|cRXP_WARN_Be aware that |cRXP_ENEMY_Gurn|r enrages after a few seconds, increasing attack speed by 300% for 6 seconds, but stunning him at the end for 3 seconds. You can jump off the tower and heal if you need to|r
.complete 10518,2 
.use 30416 
.use 30353
.isOnQuest 10518
.mob Gurn Grubnosh
step
#completewith next
.hs >> Hearth to Sylvanaar
.cooldown item,6948,>2
step
>>Return to Sylvanaar
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Skyshadow|r and |cRXP_FRIENDLY_Borgrim Stouthammer|r
.turnin 10504 >> Turn in The Bladespire Ogres
.turnin 10518 >> Turn in Planting the Banner
.accept 10580 >> Accept Where Did Those Darn Gnomes Go?
.goto Blade's Edge Mountains,36.28,66.24
.target +Commander Skyshadow
.turnin 10512 >> Turn in Getting the Bladespire Tanked
.goto Blade's Edge Mountains,37.40,64.66
.target +Borgrim Stouthammer
.maxlevel 66,bemend	<< !tbc
step
#completewith Tally
.goto Blade's Edge Mountains,37.82,61.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amerun Leafshade|r
.fly Toshley's Station >> Fly to Toshley's Station
.skill riding,300,1
.target Amerun Leafshade
step
#completewith TestTally
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Razak Ironsides|r patrolling the Station
.accept 10632 >> Accept Cutting Your Teeth
.maxlevel 66,bemend << !tbc
.target Razak Ironsides
step
#label Tally
>>Travel to Toshley's Station
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nickwinkle the Metro-Gnome|r and |cRXP_FRIENDLY_Tally Zapnabber|r
.accept 10608 >> Accept Crystal Clear
.goto Blade's Edge Mountains,60.22,68.94
.target +Nickwinkle the Metro-Gnome
.accept 10557 >> Accept Test Flight: The Zephyrium Capacitorium
.goto Blade's Edge Mountains,60.28,68.39
.target +Tally Zapnabber
.maxlevel 66,bemend << !tbc
step
.goto Blade's Edge Mountains,60.175,68.794
.gossipoption 92114 >> Talk to |cRXP_FRIENDLY_Rally Zapnabber|r
.timer 48,Test Flight RP
.skipgossip
.isOnQuest 10557
.target Rally Zapnabber
step
#label TestTally
>>Wait out the RP
.complete 10557,1 
.isOnQuest 10557
step
.goto Blade's Edge Mountains,55.11,72.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_R-3D0|r
.turnin 10580 >> Turn in Where Did Those Darn Gnomes Go?
.accept 10581 >> Accept Follow the Breadcrumbs
.maxlevel 66,bemend << !tbc
.target R-3D0
step
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Razak Ironsides|r patrolling the Station
.accept 10632 >> Accept Cutting Your Teeth
.maxlevel 66,bemend << !tbc
.target Razak Ironsides
step
>>Return to Toshley's Station
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Toshley|r, |cRXP_FRIENDLY_Tally Zapnabber|r and |cRXP_FRIENDLY_Fizit "Doc" Clocktock|r
.turnin 10581 >> Turn in Follow the Breadcrumbs
.accept 10584 >> Accept Picking Up Some Power Converters
.goto Blade's Edge Mountains,60.53,68.97
.target +Toshley
.turnin 10557 >> Turn in Test Flight: The Zephyrium Capacitorium
.accept 10710 >> Accept Test Flight: The Singing Ridge
.goto Blade's Edge Mountains,60.28,68.39
.target +Tally Zapnabber
.accept 10609 >> Accept What Came First, the Drake or the Egg?
.goto Blade's Edge Mountains,60.98,68.11
.target +Fizit "Doc" Clocktock
.maxlevel 66,bemend << !tbc
step
#completewith ToshStation
.goto Blade's Edge Mountains,60.98,68.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizit "Doc" Clocktock|r
.home >> Set your Hearthstone to Toshley's Station
.target Fizit "Doc" Clocktock
step
.use 30540 >>|cRXP_WARN_Use|r |T134939:0|t[Tally's Waiver]
.collect 30539,1,10710,1 
.isOnQuest 10710
step
#requires ToshleyHS
#loop
.line Blade's Edge Mountains,57.94,60.39,58.24,59.08,58.54,57.48,57.74,57.20,57.51,55.84,58.14,55.17,56.95,55.01,56.45,59.74,57.94,60.39
.goto Blade's Edge Mountains,57.94,60.39,30,0
.goto Blade's Edge Mountains,58.24,59.08,30,0
.goto Blade's Edge Mountains,58.54,57.48,30,0
.goto Blade's Edge Mountains,57.74,57.20,30,0
.goto Blade's Edge Mountains,57.51,55.84,30,0
.goto Blade's Edge Mountains,58.14,55.17,30,0
.goto Blade's Edge Mountains,56.95,55.01,30,0
.goto Blade's Edge Mountains,56.45,59.74,30,0
.goto Blade's Edge Mountains,57.94,60.39,30,0
.use 30656 >>|cRXP_WARN_Click the|r |cRXP_WARN_Power Converters|r |cRXP_WARN_to spawn|r |cRXP_ENEMY_Electromentals|r
>>|cRXP_WARN_Use the|r |T132488:0|t[Protovoltaic Magneto Collector] |cRXP_WARN_on the |cRXP_ENEMY_Electromentals|r to make it an|r |cRXP_ENEMY_Encased Electromental|r
>>Kill the |cRXP_ENEMY_Encased Electromentals|r
.complete 10584,1 
.isOnQuest 10584
.mob Electromental
.mob Encased Electromental
step
#optional
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Razak Ironsides|r patrolling the Station
.accept 10632 >> Accept Cutting Your Teeth
.maxlevel 66,bemend << !tbc
.target Razak Ironsides
step
#label ToshStation
>>Return to Toshley's Station
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Toshley|r and |cRXP_FRIENDLY_Dizzy Dina|r
.turnin 10584 >> Turn in Picking Up Some Power Converters
.goto Blade's Edge Mountains,60.53,68.97
.target +Toshley
.accept 10620 >> Accept Ridgespine Menace
.goto Blade's Edge Mountains,60.40,68.75
.target +Dizzy Dina
.maxlevel 66,bemend << !tbc
step
#loop
.goto Blade's Edge Mountains,59.99,69.32,30,0
.goto Blade's Edge Mountains,60.28,68.98,30,0
.goto Blade's Edge Mountains,60.11,68.37,30,0
.goto Blade's Edge Mountains,59.81,68.29,30,0
.goto Blade's Edge Mountains,60.03,67.79,30,0
.goto Blade's Edge Mountains,60.31,68.23,30,0
.goto Blade's Edge Mountains,60.42,67.91,30,0
.goto Blade's Edge Mountains,60.54,68.76,30,0
.goto Blade's Edge Mountains,60.44,69.37,30,0
.line Blade's Edge Mountains,59.99,69.32,60.28,68.98,60.11,68.37,59.81,68.29,60.03,67.79,60.31,68.23,60.42,67.91,60.54,68.76,60.44,69.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Razak Ironsides|r patrolling the Station
.accept 10632 >> Accept Cutting Your Teeth
.unitscan Razak Ironsides
.maxlevel 66,bemend << !tbc
step
#completewith next
.goto Blade's Edge Mountains,60.175,68.794
.gossip 21461,1 >> Talk to |cRXP_FRIENDLY_Rally Zapnabber|r
.timer 30,Test Flight RP
.isOnQuest 10710
step
>>Wait out the RP
.goto Blade's Edge Mountains,60.175,68.794
.complete 10710,1 
.skipgossip 21461,1
.isOnQuest 10710
.target Rally Zapnabber
step
.goto Blade's Edge Mountains,67.71,72.74,50,0
.goto Blade's Edge Mountains,68.61,70.81,50,0
.goto Blade's Edge Mountains,69.40,66.26,50,0
.goto Blade's Edge Mountains,68.47,64.72,50,0
.goto Blade's Edge Mountains,66.98,63.63,50,0
.goto Blade's Edge Mountains,67.05,58.87,50,0
.goto Blade's Edge Mountains,67.90,49.98,50,0
.goto Blade's Edge Mountains,64.44,51.45,50,0
.goto Blade's Edge Mountains,62.32,52.92,50,0
.goto Blade's Edge Mountains,65.52,55.81
>>Kill |cRXP_ENEMY_Ridgespine Stalkers|r. |cRXP_WARN_They are stealthed so listen for the stealth sound|r
>>Kill |cRXP_ENEMY_Daggermaws|r. Loot them for their |cRXP_LOOT_Teeth|r
.complete 10632,1 
.mob +Daggermaw Lashtail
.complete 10620,1 
.mob +Ridgespine Stalker
.isOnQuest 10620
.isOnQuest 10632
step
#completewith next
.hs >> Hearth to Toshley's Station
.cooldown item,6948,>2
step
#optional
#completewith next
>>Click the |cRXP_PICK_Nether Drake Eggs|r to spawn a |cRXP_ENEMY_Nether Whelp|r
>>|cRXP_WARN_Use the|r |T133869:0|t[Temporal Phase Modulator] |cRXP_WARN_on the |cRXP_ENEMY_Nether Whelps|r that spawn to convert it into a|r |cRXP_ENEMY_Nether Drake|r
>>|cRXP_WARN_You can use the|r |T133869:0|t[Temporal Phase Modulator] |cRXP_WARN_multiple times on the same |cRXP_ENEMY_Nether Drake|r to change it to a different type|r
.complete 10609,1 
.mob +Proto-Nether Drake
.complete 10609,2 
.mob +Adolescent Nether Drake
.complete 10609,3 
.mob +Mature Nether Drake
.use 30742
.isOnQuest 10609
step
#loop
.line Blade's Edge Mountains,67.28,75.42,68.41,76.83,67.75,76.85,66.11,77.96,65.14,78.62,64.55,77.86,62.33,79.30,61.64,79.15,59.69,79.16,59.65,78.19,60.16,75.98,61.24,75.24,62.18,76.39,62.56,76.54,63.56,77.26,64.49,75.34,65.35,76.09,65.54,75.34,66.42,74.79,67.28,75.42
.goto Blade's Edge Mountains,67.28,75.42,40,0
.goto Blade's Edge Mountains,68.41,76.83,40,0
.goto Blade's Edge Mountains,67.75,76.85,40,0
.goto Blade's Edge Mountains,66.11,77.96,40,0
.goto Blade's Edge Mountains,65.14,78.62,40,0
.goto Blade's Edge Mountains,64.55,77.86,40,0
.goto Blade's Edge Mountains,62.33,79.30,40,0
.goto Blade's Edge Mountains,61.64,79.15,40,0
.goto Blade's Edge Mountains,59.69,79.16,40,0
.goto Blade's Edge Mountains,59.65,78.19,40,0
.goto Blade's Edge Mountains,60.16,75.98,40,0
.goto Blade's Edge Mountains,61.24,75.24,40,0
.goto Blade's Edge Mountains,62.18,76.39,40,0
.goto Blade's Edge Mountains,62.56,76.54,40,0
.goto Blade's Edge Mountains,63.56,77.26,40,0
.goto Blade's Edge Mountains,64.49,75.34,40,0
.goto Blade's Edge Mountains,65.35,76.09,40,0
.goto Blade's Edge Mountains,65.54,75.34,40,0
.goto Blade's Edge Mountains,66.42,74.79,40,0
.goto Blade's Edge Mountains,67.28,75.42,40,0
>>Kill |cRXP_ENEMY_Crystal Flayers|r
.complete 10608,1 
.isOnQuest 10608
.mob Crystal Flayer
step
#loop
.line Blade's Edge Mountains,67.28,75.42,68.41,76.83,67.75,76.85,66.11,77.96,65.14,78.62,64.55,77.86,62.33,79.30,61.64,79.15,59.69,79.16,59.65,78.19,60.16,75.98,61.24,75.24,62.18,76.39,62.56,76.54,63.56,77.26,64.49,75.34,65.35,76.09,65.54,75.34,66.42,74.79,67.28,75.42
.goto Blade's Edge Mountains,67.28,75.42,40,0
.goto Blade's Edge Mountains,68.41,76.83,40,0
.goto Blade's Edge Mountains,67.75,76.85,40,0
.goto Blade's Edge Mountains,66.11,77.96,40,0
.goto Blade's Edge Mountains,65.14,78.62,40,0
.goto Blade's Edge Mountains,64.55,77.86,40,0
.goto Blade's Edge Mountains,62.33,79.30,40,0
.goto Blade's Edge Mountains,61.64,79.15,40,0
.goto Blade's Edge Mountains,59.69,79.16,40,0
.goto Blade's Edge Mountains,59.65,78.19,40,0
.goto Blade's Edge Mountains,60.16,75.98,40,0
.goto Blade's Edge Mountains,61.24,75.24,40,0
.goto Blade's Edge Mountains,62.18,76.39,40,0
.goto Blade's Edge Mountains,62.56,76.54,40,0
.goto Blade's Edge Mountains,63.56,77.26,40,0
.goto Blade's Edge Mountains,64.49,75.34,40,0
.goto Blade's Edge Mountains,65.35,76.09,40,0
.goto Blade's Edge Mountains,65.54,75.34,40,0
.goto Blade's Edge Mountains,66.42,74.79,40,0
.goto Blade's Edge Mountains,67.28,75.42,40,0
>>Click the |cRXP_PICK_Nether Drake Eggs|r to spawn a |cRXP_ENEMY_Nether Whelp|r
>>|cRXP_WARN_Use the|r |T133869:0|t[Temporal Phase Modulator] |cRXP_WARN_on the |cRXP_ENEMY_Nether Whelps|r that spawn to convert it into a|r |cRXP_ENEMY_Nether Drake|r
>>|cRXP_WARN_You can use the|r |T133869:0|t[Temporal Phase Modulator] |cRXP_WARN_multiple times on the same |cRXP_ENEMY_Nether Drake|r to change it to a different type|r
.use 30742
.isOnQuest 10609
.complete 10609,1 
.mob +Proto-Nether Drake
.complete 10609,2 
.mob +Adolescent Nether Drake
.complete 10609,3 
.mob +Mature Nether Drake
step
#completewith CrystalClear
.goto Blade's Edge Mountains,59.99,69.32,30,0
.goto Blade's Edge Mountains,60.28,68.98,30,0
.goto Blade's Edge Mountains,60.11,68.37,30,0
.goto Blade's Edge Mountains,59.81,68.29,30,0
.goto Blade's Edge Mountains,60.03,67.79,30,0
.goto Blade's Edge Mountains,60.31,68.23,30,0
.goto Blade's Edge Mountains,60.42,67.91,30,0
.goto Blade's Edge Mountains,60.54,68.76,30,0
.goto Blade's Edge Mountains,60.44,69.37
.line Blade's Edge Mountains,59.99,69.32,60.28,68.98,60.11,68.37,59.81,68.29,60.03,67.79,60.31,68.23,60.42,67.91,60.54,68.76,60.44,69.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Razak Ironsides|r patrolling the Station
.turnin 10632 >> Turn in Cutting Your Teeth
.unitscan Razak Ironsides
.maxlevel 66,bemend << !tbc
step
#questguide
>>Return to Toshley's Station
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nickwinkle the Metro-Gnome|r and |cRXP_FRIENDLY_Dizzy Dina|r
.turnin 10608 >> Turn in Crystal Clear
.accept 10594 >> Accept Gauging the Resonant Frequency
.goto Blade's Edge Mountains,60.22,68.94
.target +Nickwinkle the Metro-Gnome
.turnin 10620 >> Turn in Ridgespine Menace
.accept 10671 >> Accept More than a Pound of Flesh
.goto Blade's Edge Mountains,60.40,68.75
.target +Dizzy Dina
.maxlevel 66,bemend << !tbc
step
#label CrystalClear
>>Return to Toshley's Station
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nickwinkle the Metro-Gnome|r and |cRXP_FRIENDLY_Dizzy Dina|r
.turnin 10608 >> Turn in Crystal Clear
.accept 10594 >> Accept Gauging the Resonant Frequency
.goto Blade's Edge Mountains,60.22,68.94
.target +Nickwinkle the Metro-Gnome
.turnin 10620 >> Turn in Ridgespine Menace

.goto Blade's Edge Mountains,60.40,68.75
.target +Dizzy Dina
.maxlevel 66,bemend << !tbc
step
.goto Blade's Edge Mountains,59.99,69.32,30,0
.goto Blade's Edge Mountains,60.28,68.98,30,0
.goto Blade's Edge Mountains,60.11,68.37,30,0
.goto Blade's Edge Mountains,59.81,68.29,30,0
.goto Blade's Edge Mountains,60.03,67.79,30,0
.goto Blade's Edge Mountains,60.31,68.23,30,0
.goto Blade's Edge Mountains,60.42,67.91,30,0
.goto Blade's Edge Mountains,60.54,68.76,30,0
.goto Blade's Edge Mountains,60.44,69.37
.line Blade's Edge Mountains,59.99,69.32,60.28,68.98,60.11,68.37,59.81,68.29,60.03,67.79,60.31,68.23,60.42,67.91,60.54,68.76,60.44,69.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Razak Ironsides|r patrolling the Station
.turnin 10632 >> Turn in Cutting Your Teeth
.unitscan Razak Ironsides
.maxlevel 66,bemend << !tbc
step
.goto Blade's Edge Mountains,60.21,74.83
>>|cRXP_WARN_Use the|r |T132995:0|t[Oscillating Frequency Scanners] |cRXP_WARN_to plant a rod in the ground. You need to position them in a pentagonal formation 40 yards from each other. After planting 5 rods, stand in the middle of it|r
.complete 10594,1 
.use 30701
.isOnQuest 10594
step
#questguide
>>Return to Toshley's Station
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Razak Ironsides|r, |cRXP_FRIENDLY_Tally Zapnabber|r and |cRXP_FRIENDLY_Fizit "Doc" Clocktock|r
Talk to Nickwinkle, Tally, and Fizit
.turnin 10594 >> Turn in Gauging the Resonant Frequency
.goto Blade's Edge Mountains,60.22,68.94
.target +Nickwinkle the Metro-Gnome
.turnin 10710 >> Turn in Test Flight: The Singing Ridge
.accept 10711 >> Accept Test Flight: Razaan's Landing
.goto Blade's Edge Mountains,60.28,68.39
.target +Tally Zapnabber
.turnin 10609 >> Turn in What Came First, the Drake or the Egg?
.goto Blade's Edge Mountains,60.98,68.11
.target +Fizit "Doc" Clocktock
.maxlevel 66,bemend << !tbc
step
>>Return to Toshley's Station
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nickwinkle the Metro-Gnome|r, |cRXP_FRIENDLY_Tally Zapnabber|r and |cRXP_FRIENDLY_Fizit "Doc" Clocktock|r
.turnin 10594 >> Turn in Gauging the Resonant Frequency
.goto Blade's Edge Mountains,60.22,68.94
.target +Nickwinkle the Metro-Gnome
.turnin 10710 >> Turn in Test Flight: The Singing Ridge

.goto Blade's Edge Mountains,60.28,68.39
.target +Tally Zapnabber
.turnin 10609 >> Turn in What Came First, the Drake or the Egg?
.goto Blade's Edge Mountains,60.98,68.11
.target +Fizit "Doc" Clocktock
.maxlevel 66,bemend << !tbc
step
#questguide
.goto Blade's Edge Mountains,60.175,68.794
.gossipoption 92112 >> Talk to |cRXP_FRIENDLY_Rally Zapnabber|r
.timer 40,Test Flight RP
.skipgossip
.isOnQuest 10711
.target Rally Zapnabber
step
#questguide
.complete 10711,1 
.goto Blade's Edge Mountains,66.98,48.90,300 >> Wait out the RP
.isOnQuest 10711
step
#questguide
.goto Blade's Edge Mountains,67.2,43.6
>>Kill |cRXP_ENEMY_Fiendling Flesh Beasts|r. Loot them for their |cRXP_LOOT_Flesh|r
.complete 10671,1 
.isOnQuest 10671
.target Fiendling Flesh Beast
step
>>Travel to Evergrove
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Timeon|r and |cRXP_FRIENDLY_Tree Warden Chawn|r
.accept 10567 >>Accept Creating the Pendant
.goto Blade's Edge Mountains,62.16,39.11
.target +Timeon
.accept 10682 >>Accept A Time for Negotiation...
.goto Blade's Edge Mountains,61.97,39.47
.target +Tree Warden Chawn
.maxlevel 66,bemend << !tbc
step
.goto Blade's Edge Mountains,61.68,39.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fhyn Leafshadow|r
.fp Evergrove >> Get the Evergrove flight path
.target Fhyn Leafshadow
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mosswood the Ancient|r, |cRXP_FRIENDLY_Commander Haephus Stonewall|r, |cRXP_FRIENDLY_Lieutenant Fairweather|r and |cRXP_FRIENDLY_Faradrella|r
.accept 10770 >>Accept Little Embers
.accept 10771 >>Accept From the Ashes
.goto Blade's Edge Mountains,61.25,38.46
.target +Mosswood the Ancient
.accept 10795 >> Accept A Date with Dorgok
.goto Blade's Edge Mountains,61.98,37.98
.target +Commander Haephus Stonewall
.accept 10796 >> Accept Crush the Bloodmaul Camp!
.goto Blade's Edge Mountains,61.98,37.94
.target +Lieutenant Fairweather
.accept 10753 >>Accept Culling the Wild
.goto Blade's Edge Mountains,62.56,38.23
.target +Faradrella
.maxlevel 66,bemend << !tbc
step
#completewith Damaged
.goto Blade's Edge Mountains,62.86,38.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Aelerya|r
.home >> Set your Hearthstone to Evergrove
.maxlevel 66,bemend << !tbc
.target Innkeeper Aelerya
step
#completewith next
.goto Blade's Edge Mountains,65.43,39.76,40,0
.goto Blade's Edge Mountains,66.89,38.38,40 >> Run up the mountain path
.skill riding,225,1
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Felsworn Scalewings|r and |cRXP_ENEMY_Daggermaws|r
.complete 10753,1 
.mob +Felsworn Scalewing
.complete 10753,2 
.mob +Felsworn Daggermaw
.isOnQuest 10753
step
#label Damaged
.goto Blade's Edge Mountains,69.23,37.45,60,0
.goto Blade's Edge Mountains,68.66,33.30,60,0
.goto Blade's Edge Mountains,71.75,32.63,60,0
.goto Blade's Edge Mountains,70.98,27.92
.use 31384 >>Kill |cRXP_ENEMY_Fel Corrupters|r. Loot them for their |T133133:0|t[|cRXP_LOOT_Damaged Mask|r]
>>|cRXP_WARN_Use the|r |T133133:0|t[|cRXP_LOOT_Damaged Mask|r] |cRXP_WARN_to start the quest|r
.complete 10753,3 
.collect 31384,1,10810,1 
.accept 10810 >>Accept Damaged Mask
.unitscan Fel Corrupter
.isOnQuest 10753
step
#loop
.line Blade's Edge Mountains,68.77,34.63,68.31,30.34,70.65,30.50,70.91,26.73,73.67,26.67,73.39,30.11,71.84,34.87,68.77,34.63
.goto Blade's Edge Mountains,68.77,34.63,60,0
.goto Blade's Edge Mountains,68.31,30.34,60,0
.goto Blade's Edge Mountains,70.65,30.50,60,0
.goto Blade's Edge Mountains,70.91,26.73,60,0
.goto Blade's Edge Mountains,73.67,26.67,60,0
.goto Blade's Edge Mountains,73.39,30.11,60,0
.goto Blade's Edge Mountains,71.84,34.87,60,0
.goto Blade's Edge Mountains,68.77,34.63,60,0
>>Kill |cRXP_ENEMY_Felsworn Scalewings|r and |cRXP_ENEMY_Daggermaws|r
.complete 10753,1 
.mob +Felsworn Scalewing
.complete 10753,2 
.mob +Felsworn Daggermaw
.isOnQuest 10753
step
#completewith next
>>Kill |cRXP_ENEMY_Scorch Imps|r
.complete 10770,1 
.isOnQuest 10770
.mob Scorch Imp
step
.use 31300 >>|cRXP_WARN_Use the|r |T134059:0|t[Ironroot Seeds] |cRXP_WARN_on the patches of|r |cRXP_PICK_Volcanic Soil|r
.complete 10771,1 
.goto Blade's Edge Mountains,71.66,22.38
.complete 10771,2 
.goto Blade's Edge Mountains,71.61,20.31
.complete 10771,3 
.goto Blade's Edge Mountains,71.59,18.50
.isOnQuest 10771
step
#loop
.line Blade's Edge Mountains,70.65,18.63,70.63,20.56,70.65,22.68,71.06,23.80,71.92,24.64,72.31,22.97,71.71,21.21,73.06,20.10,73.44,18.06,70.65,18.63
.goto Blade's Edge Mountains,70.65,18.63,50,0
.goto Blade's Edge Mountains,70.63,20.56,50,0
.goto Blade's Edge Mountains,70.65,22.68,50,0
.goto Blade's Edge Mountains,71.06,23.80,50,0
.goto Blade's Edge Mountains,71.92,24.64,50,0
.goto Blade's Edge Mountains,72.31,22.97,50,0
.goto Blade's Edge Mountains,71.71,21.21,50,0
.goto Blade's Edge Mountains,73.06,20.10,50,0
.goto Blade's Edge Mountains,73.44,18.06,50,0
.goto Blade's Edge Mountains,70.65,18.63,50,0
>>Kill |cRXP_ENEMY_Scorch Imps|r
.complete 10770,1 
.isOnQuest 10770
.mob Scorch Imp
step
#completewith next
.hs >>Hearth to Evergrove
.cooldown item,6948,>2
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Faradrella|r, |cRXP_FRIENDLY_Mosswood the Ancient|r and |cRXP_FRIENDLY_O'Mally Zapnabber|r
.turnin 10753 >>Turn in Culling the Wild
.goto Blade's Edge Mountains,62.56,38.23
.target +Faradrella
.turnin 10770 >>Turn in Little Embers
.turnin 10771 >>Turn in From the Ashes
.goto Blade's Edge Mountains,61.25,38.46
.target +Mosswood the Ancient
.turnin 10810 >>Turn in Damaged Mask
.accept 10812 >> Accept Mystery Mask
.goto Blade's Edge Mountains,62.66,40.38
.target +O'Mally Zapnabber
.maxlevel 66,bemend << !tbc
step
.goto Blade's Edge Mountains,62.53,39.91,40,0
.goto Blade's Edge Mountains,62.00,40.21,40,0
.goto Blade's Edge Mountains,61.45,39.73,40,0
.goto Blade's Edge Mountains,61.28,38.77,40,0
.goto Blade's Edge Mountains,62.20,38.15,40,0
.goto Blade's Edge Mountains,62.69,39.13
.line Blade's Edge Mountains,62.53,39.91,62.00,40.21,61.45,39.73,61.28,38.77,62.20,38.15,62.69,39.13,62.53,39.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wildlord Antelarion|r, he patrols counter-clockwise around the town
.turnin 10812 >>Turn in Mystery Mask
.accept 10819 >> Accept Felsworn Gas Mask
.maxlevel 66,bemend << !tbc
.target Wildlord Antelarion
step
#completewith next
.equip 1,10819 >> |cRXP_WARN_Equip the|r |T133133:0|t[Felsworn Gas Mask] |cRXP_WARN_to be able to talk to the|r |cRXP_FRIENDLY_Legion Communicator|r
.use 10819
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Legion Communicator|r with your |T133133:0|t[Felsworn Gas Mask] equipped
.goto Blade's Edge Mountains,73.27,40.03
.turnin 10819 >>Turn in Felsworn Gas Mask
.accept 10820 >>Accept Deceive thy Enemy
.use 31366
.maxlevel 66,bemend << !tbc
step
#loop
.line Blade's Edge Mountains,74.28,38.54,75.39,39.66,74.93,40.17,75.30,41.73,74.22,42.56,73.77,41.02,74.28,38.54
.goto Blade's Edge Mountains,74.28,38.54,40,0
.goto Blade's Edge Mountains,75.39,39.66,40,0
.goto Blade's Edge Mountains,74.93,40.17,40,0
.goto Blade's Edge Mountains,75.30,41.73,40,0
.goto Blade's Edge Mountains,74.22,42.56,40,0
.goto Blade's Edge Mountains,73.77,41.02,40,0
.goto Blade's Edge Mountains,74.28,38.54,40,0
>>|cRXP_WARN_Re-equip your normal helmet|r
>>Kill |cRXP_ENEMY_Doomforge Attendants|r and |cRXP_ENEMY_Engineers|r
.complete 10820,1 
.mob +Doomforge Attendant
.complete 10820,2 
.mob +Doomforge Engineer
.isOnQuest 10820
step
#completewith next
.equip 1,10819 >> |cRXP_WARN_Equip the|r |T133133:0|t[Felsworn Gas Mask] |cRXP_WARN_to be able to talk to the|r |cRXP_FRIENDLY_Legion Communicator|r
.use 10819
step
.goto Blade's Edge Mountains,73.27,40.03
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Legion Communicator|r with your |T133133:0|t[Felsworn Gas Mask] equipped
.turnin 10820 >>Turn in Deceive thy Enemy
.accept 10821 >> Accept You're Fired!
.maxlevel 66,bemend << !tbc

step
#loop
.line Blade's Edge Mountains,73.63,39.14,72.82,40.35,72.90,40.76,72.92,41.50,72.90,41.96,73.36,42.46,73.39,43.64,74.38,41.90,74.01,38.52,73.63,39.14
.goto Blade's Edge Mountains,73.63,39.14,40,0
.goto Blade's Edge Mountains,72.82,40.35,40,0
.goto Blade's Edge Mountains,72.90,40.76,40,0
.goto Blade's Edge Mountains,72.92,41.50,40,0
.goto Blade's Edge Mountains,72.90,41.96,40,0
.goto Blade's Edge Mountains,73.36,42.46,40,0
.goto Blade's Edge Mountains,73.39,43.64,40,0
.goto Blade's Edge Mountains,74.38,41.90,40,0
.goto Blade's Edge Mountains,74.01,38.52,40,0
.goto Blade's Edge Mountains,73.63,39.14,40,0
>>Kill |cRXP_ENEMY_Anger Guards|r. Loot them for |cRXP_LOOT_Camp Anger Keys|r
>>|cRXP_WARN_Don't click any |cRXP_WARN_Obelisks|r yet|r
.collect 31536,5,10821,1 
.isOnQuest 10821
.mob Anger Guard
step
#completewith Doomcryer
#label FirstO
.goto Blade's Edge Mountains,73.53,43.51
.cast 38746 >>Click the |cRXP_PICK_First Obelisk|r
>>|cRXP_WARN_*If you cannot click it, skip this step|r
.isOnQuest 10821
step
#completewith Doomcryer
#requires FirstO
#label SecondO
.goto Blade's Edge Mountains,73.82,41.03
.cast 38746 >>Click the |cRXP_PICK_Second Obelisk|r
>>|cRXP_WARN_*If you cannot click it, skip this step|r
.isOnQuest 10821
step
#completewith Doomcryer
#requires SecondO
#label ThirdO
.goto Blade's Edge Mountains,73.94,39.89
.cast 38746 >>Click the |cRXP_PICK_Third Obelisk|r
>>|cRXP_WARN_*If you cannot click it, skip this step|r
.isOnQuest 10821
step
#completewith Doomcryer
#requires ThirdO
#label FourthO
.goto Blade's Edge Mountains,75.45,40.52
.cast 38746 >>Click the |cRXP_PICK_Fourth Obelisk|r
>>|cRXP_WARN_*If you cannot click it, skip this step|r
.isOnQuest 10821
step
#completewith Doomcryer
#requires FourthO
.goto Blade's Edge Mountains,75.33,41.74
.cast 38746 >>Click the |cRXP_PICK_Fifth Obelisk|r
>>|cRXP_WARN_*If you cannot click it, skip this step|r
.timer 30,Doomcryer Spawn
.isOnQuest 10821
step
#label Doomcryer
.goto Blade's Edge Mountains,74.32,42.52
>>Click the |cRXP_PICK_Five Obelisks|r around the camp to summon |cRXP_ENEMY_Doomcryer|r
>>Kill |cRXP_ENEMY_Doomcryer|r
>>|cRXP_ENEMY_Doomcryer|r |cRXP_WARN_can be affected by a number of crowd-controlling abilities such as Slows and Fear|r
>>|cRXP_WARN_This quest is difficult. Find a group for her if needed. Skip this step if you're unable to find a group or solo her|r
.complete 10821,1 
.isOnQuest 10821
.mob Doomcryer
step
#completewith Nuaar
.hs >>Hearth to Evergrove
.cooldown item,6948,>2
step
.goto Blade's Edge Mountains,62.53,39.91,40,0
.goto Blade's Edge Mountains,62.00,40.21,40,0
.goto Blade's Edge Mountains,61.45,39.73,40,0
.goto Blade's Edge Mountains,61.28,38.77,40,0
.goto Blade's Edge Mountains,62.20,38.15,40,0
.goto Blade's Edge Mountains,62.69,39.13
.line Blade's Edge Mountains,62.53,39.91,62.00,40.21,61.45,39.73,61.28,38.77,62.20,38.15,62.69,39.13,62.53,39.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wildlord Antelarion|r, he patrols counter-clockwise around the town
.turnin 10821 >> Turn in You're Fired!
.isQuestComplete 10821
.maxlevel 66,bemend << !tbc
.target Wildlord Antelarion
step
.goto Blade's Edge Mountains,62.53,39.91,40,0
.goto Blade's Edge Mountains,62.00,40.21,40,0
.goto Blade's Edge Mountains,61.45,39.73,40,0
.goto Blade's Edge Mountains,61.28,38.77,40,0
.goto Blade's Edge Mountains,62.20,38.15,40,0
.goto Blade's Edge Mountains,62.69,39.13
.line Blade's Edge Mountains,62.53,39.91,62.00,40.21,61.45,39.73,61.28,38.77,62.20,38.15,62.69,39.13,62.53,39.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wildlord Antelarion|r, he patrols counter-clockwise around the town
.accept 10910 >> Accept Death's Door
.isQuestTurnedIn 10821
.maxlevel 66,bemend << !tbc
.target Wildlord Antelarion
step
#label Nuaar
.line Blade's Edge Mountains,62.82,25.94,63.12,27.41,63.34,27.87,63.28,28.37,62.73,28.77,62.45,29.31,62.37,29.65,62.44,31.66,62.11,33.34,61.80,34.00,61.43,34.10,60.61,33.98,60.12,34.47,60.01,34.80,60.08,35.15,59.90,35.72,59.60,36.07,59.11,36.21,58.96,36.61,58.65,36.91,58.18,36.96,57.90,37.34,57.84,37.81,59.13,39.47,59.90,40.27,60.51,40.90,61.50,42.02,61.78,42.41,62.62,43.95,62.97,45.05,63.06,46.38
63.06,46.38
.goto Blade's Edge Mountains,63.06,46.38,60,0
.goto Blade's Edge Mountains,62.97,45.05,60,0
.goto Blade's Edge Mountains,62.62,43.95,60,0
.goto Blade's Edge Mountains,61.78,42.41,60,0
.goto Blade's Edge Mountains,61.50,42.02,60,0
.goto Blade's Edge Mountains,60.51,40.90,60,0
.goto Blade's Edge Mountains,59.90,40.27,60,0
.goto Blade's Edge Mountains,59.13,39.47,60,0
.goto Blade's Edge Mountains,57.84,37.81,60,0
.goto Blade's Edge Mountains,57.90,37.34,60,0
.goto Blade's Edge Mountains,58.18,36.96,60,0
.goto Blade's Edge Mountains,58.65,36.91,60,0
.goto Blade's Edge Mountains,58.96,36.61,60,0
.goto Blade's Edge Mountains,59.11,36.21,60,0
.goto Blade's Edge Mountains,59.60,36.07,60,0
.goto Blade's Edge Mountains,59.90,35.72,60,0
.goto Blade's Edge Mountains,60.08,35.15,60,0
.goto Blade's Edge Mountains,60.01,34.80,60,0
.goto Blade's Edge Mountains,60.12,34.47,60,0
.goto Blade's Edge Mountains,60.61,33.98,60,0
.goto Blade's Edge Mountains,61.80,34.00,60,0
.goto Blade's Edge Mountains,62.11,33.34,60,0
.goto Blade's Edge Mountains,62.44,31.66,60,0
.goto Blade's Edge Mountains,62.37,29.65,60,0
.goto Blade's Edge Mountains,62.45,29.31,60,0
.goto Blade's Edge Mountains,62.73,28.77,60,0
.goto Blade's Edge Mountains,63.28,28.37,60,0
.goto Blade's Edge Mountains,63.34,27.87,60,0
.goto Blade's Edge Mountains,63.12,27.41,60,0
.goto Blade's Edge Mountains,62.82,25.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Overseer Nuaar|r
>>|cRXP_FRIENDLY_Overseer Nuaar|r |cRXP_WARN_patrols the Wyrmcult camps of Ruuan Weald|r
.complete 10682,1 
.unitscan Overseer Nuaar
.skipgossip
.isOnQuest 10682
step
>>Return to Evergrove
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tree Warden Chawn|r and |cRXP_FRIENDLY_Samia Inkling|r
.turnin 10682 >>Turn in A Time for Negotiation...
.accept 10713 >>Accept ...and a Time for Action
.goto Blade's Edge Mountains,61.97,39.47
.target +Tree Warden Chawn
.accept 10717 >>Accept Poaching from Poachers
.goto Blade's Edge Mountains,61.94,39.45
.target +Samia Inkling
.maxlevel 66,bemend << !tbc
step
#completewith next
#loop
.line Blade's Edge Mountains,63.61,34.11,65.32,34.83,65.52,31.59,65.32,29.29,63.99,31.39,63.61,34.11
.goto Blade's Edge Mountains,63.61,34.11,50,0
.goto Blade's Edge Mountains,65.32,34.83,50,0
.goto Blade's Edge Mountains,65.52,31.59,50,0
.goto Blade's Edge Mountains,65.32,29.29,50,0
.goto Blade's Edge Mountains,63.99,31.39,50,0
.goto Blade's Edge Mountains,63.61,34.11,50,0
>>Kill the |cRXP_ENEMY_Ruuan'ok|r. Loot them for their |cRXP_LOOT_Claws|r
.collect 30704,6,10567,1 
.isOnQuest 10567
.mob Ruuan'ok Cloudgazer
.mob Ruuan'ok Skyfury
.mob Ruuan'ok Ravenguard
.mob Ruuan'ok Matriarch
step
.goto Blade's Edge Mountains,64.48,33.09
.use 30704 >>|cRXP_WARN_Use the|r |T134295:0|t[Ruuan'ok Claws] |cRXP_WARN_in the green circle to summon the|r |cRXP_ENEMY_Harbinger of the Raven|r
>>Kill the |cRXP_ENEMY_Harbinger of the Raven|r. Loot him for his |cRXP_LOOT_Pendant|r
.cast 37426
.timer 8,Creating the Pendant RP
.complete 10567,1 
.isOnQuest 10567
.mob Harbinger of the Raven
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Wyrmcult Hewers|r and |cRXP_ENEMY_Wyrmcult Poachers|r. Loot them for the |T134942:0|t[|cRXP_LOOT_Meeting Note|r]
.use 31120 >>|cRXP_WARN_Use the|r |T134942:0|t[|cRXP_LOOT_Meeting Note|r] |cRXP_WARN_to start the quest|r
.collect 31120,1,10719,1 
.accept 10719 >>Accept Did You Get The Note?
.isOnQuest 10713
step
#loop
.line Blade's Edge Mountains,59.62,38.72,57.43,39.14,57.71,37.76,59.10,36.09,59.93,35.16,60.82,33.54,62.10,32.35,61.78,27.86,62.89,25.82,63.56,27.91,62.10,32.35,61.55,34.48,60.09,36.97,59.62,38.72
.goto Blade's Edge Mountains,59.62,38.72,50,0
.goto Blade's Edge Mountains,57.43,39.14,50,0
.goto Blade's Edge Mountains,57.71,37.76,50,0
.goto Blade's Edge Mountains,59.10,36.09,50,0
.goto Blade's Edge Mountains,59.93,35.16,50,0
.goto Blade's Edge Mountains,60.82,33.54,50,0
.goto Blade's Edge Mountains,62.10,32.35,50,0
.goto Blade's Edge Mountains,61.78,27.86,50,0
.goto Blade's Edge Mountains,62.89,25.82,50,0
.goto Blade's Edge Mountains,63.56,27.91,50,0
.goto Blade's Edge Mountains,62.10,32.35,50,0
.goto Blade's Edge Mountains,61.55,34.48,50,0
.goto Blade's Edge Mountains,60.09,36.97,50,0
.goto Blade's Edge Mountains,59.62,38.72,50,0
>>Kill |cRXP_ENEMY_Wyrmcult Poachers|r and |cRXP_ENEMY_Wyrmcult Hewers|r. Loot the |cRXP_ENEMY_Poachers|r for their |cRXP_LOOT_Nets|r
.complete 10717,1 
.mob +Wyrmcult Poacher
.mob +Wyrmcult Hewer
.complete 10713,1 
.mob +Wyrmcult Hewer
.isOnQuest 10713
step
#loop
.line Blade's Edge Mountains,59.62,38.72,57.43,39.14,57.71,37.76,59.10,36.09,59.93,35.16,60.82,33.54,62.10,32.35,61.78,27.86,62.89,25.82,63.56,27.91,62.10,32.35,61.55,34.48,60.09,36.97,59.62,38.72
.goto Blade's Edge Mountains,59.62,38.72,50,0
.goto Blade's Edge Mountains,57.43,39.14,50,0
.goto Blade's Edge Mountains,57.71,37.76,50,0
.goto Blade's Edge Mountains,59.10,36.09,50,0
.goto Blade's Edge Mountains,59.93,35.16,50,0
.goto Blade's Edge Mountains,60.82,33.54,50,0
.goto Blade's Edge Mountains,62.10,32.35,50,0
.goto Blade's Edge Mountains,61.78,27.86,50,0
.goto Blade's Edge Mountains,62.89,25.82,50,0
.goto Blade's Edge Mountains,63.56,27.91,50,0
.goto Blade's Edge Mountains,62.10,32.35,50,0
.goto Blade's Edge Mountains,61.55,34.48,50,0
.goto Blade's Edge Mountains,60.09,36.97,50,0
.goto Blade's Edge Mountains,59.62,38.72,50,0
>>Kill |cRXP_ENEMY_Wyrmcult Hewers|r and |cRXP_ENEMY_Wyrmcult Poachers|r. Loot them for the |T134942:0|t[|cRXP_LOOT_Meeting Note|r]
.use 31120 >>|cRXP_WARN_Use the|r |T134942:0|t[|cRXP_LOOT_Meeting Note|r] |cRXP_WARN_to start the quest|r
.collect 31120,1,10719,1 
.accept 10719 >>Accept Did You Get The Note?
.isOnQuest 10713
.mob Wyrmcult Hewer
.mob Wyrmcult Poacher
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Bloodmaul Maulers|r and |cRXP_ENEMY_Bloodmaul Warlocks|r
.complete 10796,1 
.mob +Bloodmaul Mauler
.complete 10796,2 
.mob +Bloodmaul Warlock
.isOnQuest 10796
step
.goto Blade's Edge Mountains,54.80,24.71,30,0
.goto Blade's Edge Mountains,55.15,24.05
>>|cRXP_WARN_Head upstairs|r
.use 31363 >>Kill |cRXP_ENEMY_Dorgok|r. Loot him for the |T134451:0|t[|cRXP_LOOT_Favor of the Gronn|r]
>>|cRXP_WARN_Use the|r |T134451:0|t[|cRXP_LOOT_Favor of the Gronn|r] |cRXP_WARN_to start the quest|r
.complete 10795,1 
.collect 31363,1,10797,1 
.accept 10797 >> Accept Favor of the Gronn
.isOnQuest 10796
.mob Dorgok
step
#loop
.line Blade's Edge Mountains,57.05,27.86,55.30,27.11,55.18,24.26,56.40,22.11,57.70,24.45,56.91,25.87,57.93,29.95,54.68,33.92,57.05,27.86
.goto Blade's Edge Mountains,57.05,27.86,50,0
.goto Blade's Edge Mountains,55.30,27.11,50,0
.goto Blade's Edge Mountains,55.18,24.26,50,0
.goto Blade's Edge Mountains,56.40,22.11,50,0
.goto Blade's Edge Mountains,57.70,24.45,50,0
.goto Blade's Edge Mountains,56.91,25.87,50,0
.goto Blade's Edge Mountains,57.93,29.95,50,0
.goto Blade's Edge Mountains,54.68,33.92,50,0
.goto Blade's Edge Mountains,57.05,27.86,50,0
>>Kill |cRXP_ENEMY_Bloodmaul Maulers|r and |cRXP_ENEMY_Bloodmaul Warlocks|r
.complete 10796,1 
.mob +Bloodmaul Mauler
.complete 10796,2 
.mob +Bloodmaul Warlock
.isOnQuest 10796
step
#completewith Evergrove2
.goto Blade's Edge Mountains,59.12,32.12,40,0
.goto Blade's Edge Mountains,60.38,28.77,40,0
.goto Blade's Edge Mountains,61.54,29.73,40 >> Ride up the mountain path
.cooldown item,6948,<0
.skill riding,225,1
step
#optional
#completewith next
.hs >>Hearth to Evergrove
.cooldown item,6948,>2
step
#label Evergrove2
>>Return to Evergrove
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Fairweather|r, |cRXP_FRIENDLY_Commander Haephus Stonewall|r, |cRXP_FRIENDLY_Timeon|r, |cRXP_FRIENDLY_Tree Warden Chawn|r and |cRXP_FRIENDLY_Samia Inkling|r
.turnin 10796 >> Turn in Crush the Bloodmaul Camp!
.goto Blade's Edge Mountains,61.98,37.94
.target +Lieutenant Fairweather
.turnin 10795 >> Turn in A Date with Dorgok
.turnin 10797 >> Turn in Favor of the Gronn
.accept 10798 >> Accept Pay the Baron a Visit
.goto Blade's Edge Mountains,61.98,37.98
.target +Commander Haephus Stonewall
.turnin 10567 >>Turn in Creating the Pendant
.accept 10607 >>Accept Whispers of the Raven God
.goto Blade's Edge Mountains,62.16,39.11
.target +Timeon
.turnin 10713 >>Turn in ...and a Time for Action
.turnin 10719 >>Turn in Did You Get The Note?
.accept 10894 >>Accept Wyrmskull Watcher
.goto Blade's Edge Mountains,61.97,39.47
.target +Tree Warden Chawn
.turnin 10717 >>Turn in Poaching from Poachers
.accept 10747 >>Accept Whelps of the Wyrmcult
.goto Blade's Edge Mountains,61.94,39.45
.target +Samia Inkling
.maxlevel 66,bemend << !tbc
step
.goto Blade's Edge Mountains,53.25,41.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Baron Sablemane|r
.turnin 10798 >> Turn in Pay the Baron a Visit
.accept 10799 >> Accept Into the Churning Gulch
.maxlevel 66,bemend << !tbc
.target Baron Sablemane
step
#loop
.line Blade's Edge Mountains,51.18,37.94,48.99,41.05,49.28,44.96,47.16,45.03,45.19,47.89,44.82,44.78,47.03,43.18,48.99,41.05
.goto Blade's Edge Mountains,51.18,37.94,50,0
.goto Blade's Edge Mountains,48.99,41.05,50,0
.goto Blade's Edge Mountains,49.28,44.96,50,0
.goto Blade's Edge Mountains,47.16,45.03,50,0
.goto Blade's Edge Mountains,45.19,47.89,50,0
.goto Blade's Edge Mountains,44.82,44.78,50,0
.goto Blade's Edge Mountains,47.03,43.18,50,0
.goto Blade's Edge Mountains,48.99,41.05,50,0
>>Kill |cRXP_ENEMY_Young Crust Bursters|r and |cRXP_ENEMY_Greater Crust Bursters|r. Loot them for their |cRXP_LOOT_Venom Glands|r
.complete 10799,1 
.isOnQuest 10799
.mob Greater Crust Burster
.mob Young Crust Burster
step
.goto Blade's Edge Mountains,53.25,41.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Baron Sablemane|r
.turnin 10799 >> Turn in Into the Churning Gulch
.accept 10800 >> Accept Goodnight, Gronn
.maxlevel 66,bemend << !tbc
.target Baron Sablemane
step
#completewith next
.cast 38510 >> |cRXP_WARN_Use|r |T132858:0|t[Sablemane's Sleeping Powder] |cRXP_WARN_on|r |cRXP_ENEMY_Grulloc|r
.use 31403
.isOnQuest 10800
.target Grulloc
step
.goto Blade's Edge Mountains,60.90,47.77
>>|cRXP_WARN_If the|r |T132858:0|t[Sleeping Powder] |cRXP_WARN_resists, use it on|r |cRXP_ENEMY_Grulloc|r |cRXP_WARN_again|r. Loot the |cRXP_LOOT_Sack|r next to |cRXP_ENEMY_Grulloc|r
.complete 10800,1 
.use 31403
.isOnQuest 10800
.target Grulloc
step
.goto Blade's Edge Mountains,53.25,41.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Baron Sablemane|r
.turnin 10800 >> Turn in Goodnight, Gronn
.accept 10801 >> Accept It's a Trap!
.maxlevel 66,bemend << !tbc
.target Baron Sablemane
step << !Shaman
#completewith Evergrove3
.goto Blade's Edge Mountains,58.64,46.20,40,0
.goto Blade's Edge Mountains,59.95,44.60,40,0
.goto Blade's Edge Mountains,58.50,43.70,40,0
.goto Blade's Edge Mountains,59.40,42.14,40 >> Ride up the mountain path
.cooldown item,6948,<0
.skill riding,225,1
step << Shaman
#completewith next
.hs >>Hearth to Evergrove
.cooldown item,6948,>2
step
#label Evergrove3
>>Return to Evergrove
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Haephus Stonewall|r and |cRXP_FRIENDLY_Lieutenant Fairweather|r
.turnin 10801 >> Turn in It's a Trap!
.accept 10802 >> Accept Gorgrom the Dragon-Eater
.goto Blade's Edge Mountains,61.98,37.98
.target +Commander Haephus Stonewall
.accept 10803 >> Accept Slaughter at Boulder'mok
.goto Blade's Edge Mountains,61.98,37.94
.target +Lieutenant Fairweather
.maxlevel 66,bemend << !tbc
step
#completewith Evergrove3
.goto Blade's Edge Mountains,55.90,39.76,60,0
.goto Blade's Edge Mountains,59.40,42.14,40 >> Cross the bridge
.skill riding,225,1
step
.goto Blade's Edge Mountains,50.35,36.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Watcher Moonshade|r atop the bridge
.turnin 10894 >>Turn in Wyrmskull Watcher
.accept 10893 >>Accept Longtail is the Lynchpin
.maxlevel 66,bemend << !tbc
.target Watcher Moonshade
step
>>Kill |cRXP_ENEMY_Draaca Longtail|r inside of the tunnel
.goto Blade's Edge Mountains,46.03,32.93,40,0
.goto Blade's Edge Mountains,45.81,32.90,40,0
.goto Blade's Edge Mountains,44.78,32.07
.complete 10893,1 
.unitscan Draaca Longtail
.isOnQuest 10893
step
.goto Blade's Edge Mountains,49.92,35.92,20,0
.goto Blade's Edge Mountains,50.35,36.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Watcher Moonshade|r
.turnin 10893 >>Turn in Longtail is the Lynchpin
.accept 10722 >>Accept Meeting at the Blackwing Coven
.maxlevel 66,bemend << !tbc
.target Watcher Moonshade
step
#optional
#completewith Prophecy
>>Kill |cRXP_ENEMY_Grishna|r. Loot them for the |T136210:0|t[|cRXP_LOOT_Orb of the Grishna|r]
.use 31489 >>|cRXP_WARN_Use the|r |T136210:0|t[|cRXP_LOOT_Orb of the Grishna|r] |cRXP_WARN_to start the quest|r
.collect 31489,1,10825,1 
.accept 10825 >>Accept The Truth Unorbed
.isOnQuest 10607
.mob Grishna Falconwing
.mob Grishna Harbinger
.mob Grishna Matriarch
.mob Grishna Scorncrow
step
#optional
#completewith Prophecy
+Kill |cRXP_ENEMY_Grishna|r
>>|cRXP_WARN_Stand next to them when they die for a chance to gain the|r |T132188:0|t[Understanding Ravenspeech] |cRXP_WARN_buff which is needed to receive the|r |cRXP_PICK_Prophecies|r
.aura 37642
.aura 37466
.isOnQuest 10607
.mob Grishna Falconwing
.mob Grishna Harbinger
.mob Grishna Matriarch
.mob Grishna Scorncrow
step
>>|cRXP_WARN_Go to the |cRXP_PICK_Prophecies|r in Grishnath to receive them|r
.complete 10607,4 
.goto Blade's Edge Mountains,40.18,23.02
.complete 10607,3 
.goto Blade's Edge Mountains,40.67,18.63
.isOnQuest 10607
step
#completewith next
.goto Blade's Edge Mountains,40.61,17.46,20,0
.goto Blade's Edge Mountains,39.92,16.42,20,0
.goto Blade's Edge Mountains,39.02,17.25,20 >>|cRXP_WARN_Go up the tree platform on the west side. Cross the bridge, then click the|r |cRXP_PICK_Prophecy|r
.skill riding,225,1
step
>>|cRXP_WARN_Go to the |cRXP_PICK_Prophecy|r on the tree platform|r
.complete 10607,1 
.goto Blade's Edge Mountains,39.02,17.25
.isOnQuest 10607
step
#completewith next
.goto Blade's Edge Mountains,41.08,18.18,20,0
.goto Blade's Edge Mountains,42.35,19.18,20,0
.goto Blade's Edge Mountains,42.47,21.63,20 >>|cRXP_WARN_Go up the tree platform on the east side. Cross the bridge, go down a floor, then click the|r |cRXP_PICK_Prophecy|r
.skill riding,225,1
step
#label Prophecy
>>|cRXP_WARN_Go to the |cRXP_PICK_Prophecy|r on the bottom floor of the tree platform|r
.goto Blade's Edge Mountains,42.47,21.63
.complete 10607,2 
.isOnQuest 10607
step
#loop
.line Blade's Edge Mountains,42.30,24.63,41.37,20.69,39.96,22.83,38.41,20.01,39.33,17.50,40.80,17.74,42.15,18.55,42.73,21.32,42.30,24.63
.goto Blade's Edge Mountains,42.30,24.63,60,0
.goto Blade's Edge Mountains,41.37,20.69,60,0
.goto Blade's Edge Mountains,39.96,22.83,60,0
.goto Blade's Edge Mountains,38.41,20.01,60,0
.goto Blade's Edge Mountains,39.33,17.50,60,0
.goto Blade's Edge Mountains,40.80,17.74,60,0
.goto Blade's Edge Mountains,42.15,18.55,60,0
.goto Blade's Edge Mountains,42.73,21.32,60,0
.goto Blade's Edge Mountains,42.30,24.63,60,0
>>Kill |cRXP_ENEMY_Grishna|r. Loot them for the |T136210:0|t[|cRXP_LOOT_Orb of the Grishna|r]
.use 31489 >>|cRXP_WARN_Use the|r |T136210:0|t[|cRXP_LOOT_Orb of the Grishna|r] |cRXP_WARN_to start the quest|r
.collect 31489,1,10825,1 
.accept 10825 >>Accept The Truth Unorbed
.isOnQuest 10607
.mob Grishna Falconwing
.mob Grishna Harbinger
.mob Grishna Matriarch
.mob Grishna Scorncrow
step
#optional
#completewith Plant
>>Kill |cRXP_ENEMY_Boulder'mok Brutes|r and |cRXP_ENEMY_Boulder'mok Shaman|r
.complete 10803,1 
.mob +Boulder'mok Brute
.complete 10803,2 
.mob +Boulder'mok Shaman
.isOnQuest 10803
step
#loop
.line Blade's Edge Mountains,31.88,21.40,31.59,22.91,30.89,24.19,29.49,23.96,30.41,22.68,30.38,21.06,31.19,19.79,31.88,21.40
.goto Blade's Edge Mountains,31.88,21.40,60,0
.goto Blade's Edge Mountains,31.59,22.91,60,0
.goto Blade's Edge Mountains,30.89,24.19,60,0
.goto Blade's Edge Mountains,29.49,23.96,60,0
.goto Blade's Edge Mountains,30.41,22.68,60,0
.goto Blade's Edge Mountains,30.38,21.06,60,0
.goto Blade's Edge Mountains,31.19,19.79,60,0
.goto Blade's Edge Mountains,31.88,21.40,60,0
>>Kill |cRXP_ENEMY_Boulder'mok Ogres|r. Loot them for their |cRXP_LOOT_Totems|r
.collect 31754,3,10802,1 
.isOnQuest 10802
.mob Boulder'mok Chieftain
.mob Boulder'mok Brute
.mob Boulder'mok Shaman
step
#completewith next
.goto Blade's Edge Mountains,30.58,22.18
.cast 39264 >>|cRXP_WARN_Click |cRXP_PICK_Gorgrom's Altar|r to start the RP|r
.timer 12,Gorgrom RP
.isOnQuest 10802
step
#label Plant
.goto Blade's Edge Mountains,30.64,22.13
.use 31754 >>|cRXP_WARN_Wait for the short RP|r
>>|cRXP_WARN_When |cRXP_ENEMY_Gorgrom|r dies, use|r |T132352:0|t[Grisly Totems] |cRXP_WARN_on him 3 times|r
.complete 10802,1 
.isOnQuest 10802
.mob Gorgrom the Dragon-Eater
step
#loop
.line Blade's Edge Mountains,31.88,21.40,31.59,22.91,30.89,24.19,29.49,23.96,30.41,22.68,30.38,21.06,31.19,19.79,31.88,21.40
.goto Blade's Edge Mountains,31.88,21.40,60,0
.goto Blade's Edge Mountains,31.59,22.91,60,0
.goto Blade's Edge Mountains,30.89,24.19,60,0
.goto Blade's Edge Mountains,29.49,23.96,60,0
.goto Blade's Edge Mountains,30.41,22.68,60,0
.goto Blade's Edge Mountains,30.38,21.06,60,0
.goto Blade's Edge Mountains,31.19,19.79,60,0
.goto Blade's Edge Mountains,31.88,21.40,60,0
>>Kill |cRXP_ENEMY_Boulder'mok Brutes|r and |cRXP_ENEMY_Boulder'mok Shaman|r
.complete 10803,1 
.mob +Boulder'mok Brute
.complete 10803,2 
.mob +Boulder'mok Shaman
.isOnQuest 10803
step
#loop
.line Blade's Edge Mountains,30.77,31.59,31.05,33.60,33.35,32.28,33.10,30.99,30.77,31.59
.goto Blade's Edge Mountains,30.77,31.59,50,0
.goto Blade's Edge Mountains,31.05,33.60,50,0
.goto Blade's Edge Mountains,33.35,32.28,50,0
.goto Blade's Edge Mountains,33.10,30.99,50,0
.goto Blade's Edge Mountains,30.77,31.59,50,0
>>Kill |cRXP_ENEMY_Wyrmcult|r. Loot them for their |cRXP_LOOT_Costume Scraps|r
.collect 31121,3,10747,1 
.isOnQuest 10722
.mob Wyrmcult Acolyte
.mob Wyrmcult Blessed
.mob Wyrmcult Zealot
.mob Wyrmcult Scout
step
#completewith Scraps
.goto Blade's Edge Mountains,32.04,33.87,20 >> Enter the Blackwing Coven
step
#optional
#completewith Kolphis
>>|cRXP_WARN_Use the|r |T134325:0|t[Blackwhelp Net] |cRXP_WARN_on|r |cRXP_ENEMY_Wyrmcult Blackwhelps|r
>>|cRXP_WARN_You can step on the eggs in the cave to spawn more|r |cRXP_ENEMY_Wyrmcult Blackwhelps|r
.complete 10747,1 
.use 31129
.isOnQuest 10747
.mob Wyrmcult Blackwhelp
step
#label Scraps
.goto Blade's Edge Mountains,32.25,34.77,30,0
.goto Blade's Edge Mountains,33.90,34.36,30,0
.goto Blade's Edge Mountains,31.55,36.03,40,0
.goto Blade's Edge Mountains,31.85,37.27,30,0
.goto Blade's Edge Mountains,32.25,34.77,30,0
.goto Blade's Edge Mountains,33.90,34.36,30,0
.goto Blade's Edge Mountains,31.55,36.03,40,0
.goto Blade's Edge Mountains,31.85,37.27,30,0
>>Kill |cRXP_ENEMY_Wyrmcult|r. Loot them for their |cRXP_LOOT_Costume Scraps|r
>>|cRXP_WARN_You can get more outside if needed|r
.collect 31121,5,10747,1 
.isOnQuest 10722
.mob Wyrmcult Acolyte
.mob Wyrmcult Blessed
.mob Wyrmcult Zealot
.mob Wyrmcult Scout
step
.use 31121 >> |cRXP_WARN_Use the|r |T132911:0|t[Costume Scraps] |cRXP_WARN_to make the|r |T132760:0|t[Overseer Disguise]
.collect 31122,1,10747,1 
.isOnQuest 10722
step
.cast 38157 >>|cRXP_WARN_Use the|r |T132760:0|t[Overseer Disguise]
.use 31122
.isOnQuest 10722
step
#label Kolphis
.goto Blade's Edge Mountains,32.66,37.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kolphis Darkscale|r at the end of the cave while disguised
>>|cRXP_WARN_Be careful as the disguise only lasts 3 minutes|r
.complete 10722,1 
.use 31122
.skipgossip
.isOnQuest 10722
.target Kolphis Darkscale
step
.goto Blade's Edge Mountains,33.62,37.14,30,0
.goto Blade's Edge Mountains,33.64,35.63,30,0
.goto Blade's Edge Mountains,33.92,34.33,30,0
.goto Blade's Edge Mountains,31.41,36.29,30,0
.goto Blade's Edge Mountains,33.62,37.14,30,0
.goto Blade's Edge Mountains,33.64,35.63,30,0
.goto Blade's Edge Mountains,33.92,34.33,30,0
.goto Blade's Edge Mountains,31.41,36.29
>>|cRXP_WARN_Use the|r |T134325:0|t[Blackwhelp Net] |cRXP_WARN_on|r |cRXP_ENEMY_Wyrmcult Blackwhelps|r
>>|cRXP_WARN_You can step on the eggs in the cave while undisguised to spawn more|r |cRXP_ENEMY_Blackwhelps|r
.complete 10747,1 
.use 31129
.isOnQuest 10747
.mob Wyrmcult Blackwhelp
step
#completewith next
.hs >>Hearth to Evergrove
step
#questguide
>>Return to Evergrove
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Fairweather|r, |cRXP_FRIENDLY_Commander Haephus Stonewall|r, |cRXP_FRIENDLY_Timeon|r, |cRXP_FRIENDLY_Tree Warden Chawn|r and |cRXP_FRIENDLY_Samia Inkling|r
.turnin 10803 >> Turn in Slaughter at Boulder'mok
.goto Blade's Edge Mountains,61.98,37.94
.target +Lieutenant Fairweather
.turnin 10802 >> Turn in Gorgrom the Dragon-Eater
.accept 10818 >> Accept Baron Sablemane Has Requested Your Presence
.goto Blade's Edge Mountains,61.98,37.98
.target +Commander Haephus Stonewall
.turnin 10607 >> Turn in Whispers of the Raven God
.goto Blade's Edge Mountains,62.16,39.11
.target +Timeon
.turnin 10722 >> Turn in Meeting at the Blackwing Coven
.turnin 10825 >> Turn in The Truth Unorbed
.accept 10748 >> Maxnar Must Die!
.accept 10829 >> Treebole Must Know
.goto Blade's Edge Mountains,61.97,39.47
.target +Tree Warden Chawn
.turnin 10747 >> Turn in Whelps of the Wyrmcult
.goto Blade's Edge Mountains,61.94,39.45
.target +Samia Inkling
.maxlevel 66,bemend << !tbc
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Fairweather|r, |cRXP_FRIENDLY_Commander Haephus Stonewall|r, |cRXP_FRIENDLY_Timeon|r, |cRXP_FRIENDLY_Tree Warden Chawn|r and |cRXP_FRIENDLY_Samia Inkling|r
.turnin 10803 >> Turn in Slaughter at Boulder'mok
.goto Blade's Edge Mountains,61.98,37.94
.target +Lieutenant Fairweather
.turnin 10802 >> Turn in Gorgrom the Dragon-Eater

.goto Blade's Edge Mountains,61.98,37.98
.target +Commander Haephus Stonewall
.turnin 10607 >> Turn in Whispers of the Raven God
.goto Blade's Edge Mountains,62.16,39.11
.target +Timeon
.turnin 10722 >> Turn in Meeting at the Blackwing Coven
.turnin 10825 >> Turn in The Truth Unorbed


.goto Blade's Edge Mountains,61.97,39.47
.target +Tree Warden Chawn
.turnin 10747 >> Turn in Whelps of the Wyrmcult
.goto Blade's Edge Mountains,61.94,39.45
.target +Samia Inkling
.maxlevel 66,bemend << !tbc
step
#completewith Signal
.goto Blade's Edge Mountains,61.68,39.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fhyn Leafshadow|r
.fly Toshley >> Fly to Toshley's Station
.skill riding,300,1
.isQuestTurnedIn 10821
.target Fhyn Leafshadow
step
#questguide
>>Travel to Toshley's Station
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tally Zapnabber|r and |cRXP_FRIENDLY_Dizzy Dina|r
.turnin 10711 >> Turn in Test Flight: Razaan's Landing
.goto Blade's Edge Mountains,60.28,68.39
.turnin 10671 >> Turn in More than a Pound of Flesh
.goto Blade's Edge Mountains,60.40,68.75
.maxlevel 66,bemend << !tbc
.target Tally Zapnabber
.target Dizzy Dina
step
#optional
#completewith Signal
.goto Blade's Edge Mountains,64.31,70.67
>>|cRXP_WARN_Carefully jump down east of Toshley's Station to Death's Door|r
.cast 38782 >>|cRXP_WARN_Use the|r |T135815:0|t[Druid Signal] |cRXP_WARN_to summon an |cRXP_FRIENDLY_Evergrove Druid|r at Death's Door|r
.timer 18,Druid Signal RP
.skill riding,225,1
.isOnQuest 10910
step
#completewith next
.goto Blade's Edge Mountains,64.31,70.67
.cast 38782 >>|cRXP_WARN_Use the|r |T135815:0|t[Druid Signal] |cRXP_WARN_to summon an |cRXP_FRIENDLY_Evergrove Druid|r at Death's Door|r
.timer 18,Druid Signal RP
.skill riding,<225,1
.isOnQuest 10910
step
#label Signal
.goto Blade's Edge Mountains,64.31,70.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Evergrove Druid|r
.turnin 10910 >> Turn in Death's Door
.accept 10904 >> Accept Harvesting the Fel Ammunition
.use 31763
.isQuestTurnedIn 10821
.maxlevel 66,bemend << !tbc
.target Evergrove Druid
step
#loop
.line Blade's Edge Mountains,63.79,70.87,63.76,68.70,63.08,66.67,62.35,61.39,61.57,59.57,63.39,59.88,63.07,63.93,64.96,67.57,63.79,70.87
.goto Blade's Edge Mountains,63.79,70.87,45,0
.goto Blade's Edge Mountains,63.76,68.70,45,0
.goto Blade's Edge Mountains,63.08,66.67,45,0
.goto Blade's Edge Mountains,62.35,61.39,45,0
.goto Blade's Edge Mountains,61.57,59.57,45,0
.goto Blade's Edge Mountains,63.39,59.88,45,0
.goto Blade's Edge Mountains,63.07,63.93,45,0
.goto Blade's Edge Mountains,64.96,67.57,45,0
.goto Blade's Edge Mountains,63.79,70.87,45,0
>>Kill the |cRXP_ENEMY_Deathforge|r and |cRXP_ENEMY_Death Demons|r. Loot them for their |cRXP_LOOT_Cannonballs|r
.complete 10904,1 
.isOnQuest 10904
.mob Death's Might
.mob Death's Watch
.mob Deathforge Over-Smith
.mob Deathforge Technician
step
#completewith next
.goto Blade's Edge Mountains,64.81,68.32,-1
.goto Blade's Edge Mountains,61.96,60.29,-1
.cast 38782 >>|cRXP_WARN_Use the|r |T135815:0|t[Druid Signal] |cRXP_WARN_to summon an |cRXP_FRIENDLY_Evergrove Druid|r at Death's Door|r
.timer 18,Druid Signal RP
.isOnQuest 10904
step
.goto Blade's Edge Mountains,64.81,68.32,-1
.goto Blade's Edge Mountains,61.96,60.29,-1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Evergrove Druid|r
.turnin 10904 >> Turn in Harvesting the Fel Ammunition
.accept 10911 >> Accept Fire At Will!
.isQuestTurnedIn 10821
.maxlevel 66,bemend << !tbc
.target Evergrove Druid
step
>>|cRXP_WARN_Use the|r |T136030:0|t[Naturalized Ammunition] |cRXP_WARN_to take control of a|r |cRXP_ENEMY_Fel Cannon|r
>>|cRXP_WARN_Cast|r |T135803:0|t[Artillery on the Warp-Gate] (1) |cRXP_WARN_to destroy the |cRXP_ENEMY_Warp-Gates|r while defending it|r
.complete 10911,1 
.goto Blade's Edge Mountains,64.81,68.32,-1
.complete 10911,2 
.goto Blade's Edge Mountains,61.96,60.29,-1
.isOnQuest 10911
.isQuestTurnedIn 10821
.use 31807
step
#completewith next
.goto Blade's Edge Mountains,62.50,60.17
.cast 38782 >>|cRXP_WARN_Use the|r |T135815:0|t[Druid Signal] |cRXP_WARN_to summon an |cRXP_FRIENDLY_Evergrove Druid|r at Death's Door|r
.timer 18,Druid Signal RP
.isOnQuest 10911
step
.goto Blade's Edge Mountains,62.50,60.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Evergrove Druid|r
.turnin 10911 >> Turn in Fire At Will!
.accept 10912 >> Accept The Hound-Master
.isQuestTurnedIn 10821
.maxlevel 66,bemend << !tbc
.target Evergrove Druid
step
.goto Blade's Edge Mountains,63.62,59.11
.use 31809 >>|cRXP_WARN_Use the|r |T133749:0|t[Evergrove Wand] |cRXP_WARN_to summon |cRXP_FRIENDLY_Evergorve Ancients|r. They will help you fight|r |cRXP_ENEMY_Baelmon the Hound-Master|r
>>Kill |cRXP_ENEMY_Baelmon the Hound-Master|r
>>|cRXP_WARN_This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r <<tbc/wotlk
.complete 10912,1 
.use 31809
.isQuestTurnedIn 10821
.isOnQuest 10912
.mob Baelmon the Hound-Master
step
#completewith HoundMaster
.goto Blade's Edge Mountains,61.15,70.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rip Pedalslam|r
.fly Evergrove >> Fly to Evergrove
.cooldown item,6948,<0
.skill riding,225,1
.isQuestTurnedIn 10821
.target Rip Pedalslam
step
#optional
#completewith next
.hs >>Hearth to Evergrove
.cooldown item,6948,>2
.isQuestTurnedIn 10821
step
#label HoundMaster
.goto Blade's Edge Mountains,62.53,39.91,40,0
.goto Blade's Edge Mountains,62.00,40.21,40,0
.goto Blade's Edge Mountains,61.45,39.73,40,0
.goto Blade's Edge Mountains,61.28,38.77,40,0
.goto Blade's Edge Mountains,62.20,38.15,40,0
.goto Blade's Edge Mountains,62.69,39.13
.line Blade's Edge Mountains,62.53,39.91,62.00,40.21,61.45,39.73,61.28,38.77,62.20,38.15,62.69,39.13,62.53,39.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wildlord Antelarion|r, he patrols counter-clockwise around the town
.turnin 10912 >> Turn in The Hound-Master
.isQuestComplete 10912
.maxlevel 66,bemend << !tbc
.target Wildlord Antelarion
step
.abandon 10912 >> Abandon The Hound-Master
step << skip
.goto Blade's Edge Mountains,60.3,68.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tally Zapnabber|r
.accept 10712 >> Accept Test Flight: Ruuan Weald
.target Tally Zapnabber
step << skip
.goto Blade's Edge Mountains,60.2,68.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tally Zapnabber|r to launch you towards Ruaan Weald
.complete 10712,1 
>>IMPORTANT: Use the item in your bags during the flight
.complete 10712,2 
.target Tally Zapnabber
step << skip
.goto Blade's Edge Mountains,62.7,40.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_O'Mally Zapnabber|r
.turnin 10712 >> Turn in Test Flight: Ruuan Weald
.target O'Mally Zapnabber
step
#questguide
#label Treebole
.goto Blade's Edge Mountains,37.1,22.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Treebole|r
.turnin 10829 >> Turn in Treebole Must Know
.accept 10830 >> Accept Exorcising the Trees
.maxlevel 66,bemend << !tbc
.target Treebole
step
#questguide
#completewith leafbeardE
.goto Blade's Edge Mountains,34.3,19.8
.goto Blade's Edge Mountains,40.3,23.0,0
.goto Blade's Edge Mountains,40.0,22.8,0
.goto Blade's Edge Mountains,40.2,20.6,0
.goto Blade's Edge Mountains,39.3,17.4,0
.goto Blade's Edge Mountains,41.3,21.9,0
>>Kill |cRXP_ENEMY_Dire Ravens|r. Loot them for their |cRXP_LOOT_Pinfeathers|r
>>Loot the |cRXP_LOOT_Grishnath Orbs|r on the ground
.collect 31495,5 
.collect 31517,5 
.maxlevel 66,bemend << !tbc
.mob Dire Raven
step
#questguide
#label leafbeardE
.goto Blade's Edge Mountains,34.3,19.8
>>|cRXP_WARN_Use the|r |T136210:0|t[Grishnath Orb] |cRXP_WARN_and|r |T132915:0|t[Dire Pinfeather] |cRXP_WARN_to create an|r |T132920:0|t[Exorcism Feather]
>>|cRXP_WARN_Use them on the|r |cRXP_ENEMY_Raven's Wood Leafbeards|r
>>|cRXP_WARN_The |cRXP_ENEMY_Raven's Wood Leafbeards|r will become friendly after you kill the|r |cRXP_ENEMY_Koi-Koi Spirits|r
.use 31518
.use 31495
.complete 10830,1 
.maxlevel 66,bemend << !tbc
.mob Raven's Wood Leafbeard
.mob Koi-Koi Spirit
step
#questguide
.goto Blade's Edge Mountains,37.1,22.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Treebole|r
.turnin 10830 >>Turn in Exorcising the Trees
.maxlevel 66,bemend << !tbc
.target Treebole
step
#questguide
.goto Blade's Edge Mountains,33.7,35.9
>>Run to the back of the Blackwing Coven
>>Kill |cRXP_ENEMY_Maxnar the Ashmaw|r
.complete 10748,1 
.maxlevel 66,bemend << !tbc
.mob Maxnar the Ashmaw
step
#questguide
.goto Blade's Edge Mountains,62.0,39.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tree Warden Chawn|r
.turnin 10748 >>Turn in Maxnar Must Die!
.maxlevel 66,bemend << !tbc
.target Tree Warden Chawn
step
#label bemend
]])
RXPGuides.RegisterGuide([[
#version 5
#cata
#Cata
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 67-68 Netherstorm
#version 5
#displayname 67-69 Netherstorm << !tbc !wotlk
#next 69-70 Shadowmoon Valley (Aldor) << TBC
#next RXP Cataclysm 60-80 (A)\68-71 Howling Fjord << !TBC
step
#include RXPGuides\67-68 Netherstorm
]])
RXPGuides.RegisterGuide([[
#version 5
#cata
#Cata
#questguide << !tbc
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 67-69 Netherstorm
#version 5
#next 69-70 Shadowmoon Valley (Aldor) << TBC
#next 68-71 Howling Fjord << !TBC
step
#include RXPGuides\67-69 Netherstorm
]])
RXPGuides.RegisterGuide([[
#version 5
#cata
#Cata
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 67-67 Blade's Edge Turn-ins
#version 5
#next 67-68 Netherstorm
#defaultfor !tbc
step
+As you're now Level 67 (or higher) and have completed all of your current Blade's Edge objectives, the guide will now turn in all remaining quests before sending you off to Netherstorm.
*Click the box here to begin this process
.isQuestAvailable 10912
.xp 67,1

step
#optional
#completewith next
.goto Shattrath City,64.05,41.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nutral|r
.fly Telredor >> Fly to Telredor
.zoneskip Nagrand
.zoneskip Zangarmarsh
.skill riding,300,1
.target Nutral
step
#questguide << !tbc
.goto Zangarmarsh,68.3, 49.4
>>Return to Telredor
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Ahuurn|r
.turnin 9801 >>Turn in Gathering the Reagents
.isQuestComplete 9801
.target Anchorite Ahuurn
step
#optional
#completewith Moonwhisper
.goto Shattrath City,64.05,41.12,-1
.goto Zangarmarsh,67.83,51.46,-1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nutral|r or |cRXP_FRIENDLY_Munci|r
>>|cRXP_WARN_The arrow will point you to the closest Flight Master|r
.fly Orebor Harborage >> Fly to Orebor Harborage
.skill riding,300,1
.target Nutral
.target Munci
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kialon Nightblade|r
.turnin 9794 >> Turn in No Time for Curiosity
.goto Blade's Edge Mountains,35.97,67.76,30,0
.goto Blade's Edge Mountains,36.61,67.34
.isQuestComplete 9794
.target Kialon Nightblade
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Skyshadow|r
.turnin 10927 >> Turn in Killing the Crawlers
.goto Blade's Edge Mountains,36.28,66.24
.isQuestComplete 10927
.target Commander Skyshadow
step
.goto Blade's Edge Mountains,34.31,77.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Tome|r atop the tree platform
.turnin 10555 >> Turn in Malaise
.isQuestComplete 10555
step
#completewith next
.goto Blade's Edge Mountains,35.23,77.31
.cast 36904 >> Use the |T132926:0|t[Fistful of Feathers] in your bags at the summoning circle
.use 30530
.isOnQuest 10556
step
.goto Blade's Edge Mountains,37.07,65.62
>>After using the |T132926:0|tFeathers, a |cRXP_FRIENDLY_Small Bird Companion|r will follow you around
>>|cRXP_WARN_Be aware|r that the |cRXP_FRIENDLY_Bird|r can't keep up with you if you run off on your mount
>>Escort the |cRXP_FRIENDLY_Bird|r back to |cRXP_FRIENDLY_Daranelle|r
.complete 10556,1 
.isOnQuest 10556
.target Daranelle
step
#label Scratches
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Daranelle|r
.turnin 10556 >> Turn in Scratches
.goto Blade's Edge Mountains,37.07,65.62
.isQuestComplete 10556
.target Daranelle
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rina Moonspring|r
.turnin 10455 >> Turn in The Encroaching Wilderness
.goto Blade's Edge Mountains,36.21,67.13
.isQuestComplete 10455
.target Rina Moonspring
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Skyshadow|r
.turnin 10690 >> Turn in The Den Mother
.goto Blade's Edge Mountains,36.28,66.24
.isQuestComplete 10690
.target Commander Skyshadow
step
#label SylHS
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rina Moonspring|r
.turnin 10456 >> Turn in Marauding Wolves
.goto Blade's Edge Mountains,36.21,67.13
.isQuestComplete 10456
.target Rina Moonspring
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rina Moonspring|r
.turnin 10457 >> Turn in Protecting Our Own
.isQuestComplete 10457
.target Rina Moonspring
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rina Moonspring|r
.turnin 10506 >> Turn in A Dire Situation
.goto Blade's Edge Mountains,36.21,67.13
.isQuestComplete 10506
.target Rina Moonspring
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Skyshadow|r
.turnin 10502 >> Turn in The Bloodmaul Ogres
.goto Blade's Edge Mountains,36.28,66.24
.isQuestComplete 10502
.target Commander Skyshadow
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bronwyn Stouthammer|r
.turnin 10510 >> Turn in Into the Draenethyst Mine
.goto Blade's Edge Mountains,37.41,65.05
.isQuestComplete 10510
.target Bronwyn Stouthammer
step
#label Borgrim2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Borgrim Stouthammer|r
.turnin 10511 >> Turn in Strange Brew
.goto Blade's Edge Mountains,37.40,64.66
.isQuestComplete 10511
.target Borgrim Stouthammer
step
.goto Blade's Edge Mountains,44.01,51.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Vuuleen|r
.turnin 10516 >> Turn in The Trappings of a Vindicator
.accept 10517 >> Accept Gorr'Dim, Your Time Has Come...
.isQuestComplete 10516
.target Vindicator Vuuleen
step
.goto Blade's Edge Mountains,44.01,51.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Vuuleen|r
.accept 10517 >> Accept Gorr'Dim, Your Time Has Come...
.isQuestTurnedIn 10516
.target Vindicator Vuuleen
step
.goto Blade's Edge Mountains,39.38,49.06
>>Kill the two |cRXP_ENEMY_Ogres|r nearest to the door, then use the |T132621:0|t[Brutebane Keg] in your bags to lure |cRXP_ENEMY_Gorr'Dim|r away from the elite guards. Kill him
.complete 10517,1 
.isOnQuest 10517
.mob Bladespire Shaman
.mob Bladespire Brute
.mob Gorr'Dim
step
.goto Blade's Edge Mountains,44.01,51.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Vuuleen|r
.turnin 10517 >> Turn in Gorr'Dim, Your Time Has Come...
.isQuestComplete 10517
.target Vindicator Vuuleen
step
#completewith BorgrimT
.hs >> Hearth to Sylvanaar
.cooldown item,6948,>2
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Skyshadow|r
.turnin 10504 >> Turn in The Bladespire Ogres
.goto Blade's Edge Mountains,36.28,66.24
.isQuestComplete 10504
.target Commander Skyshadow
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Skyshadow|r
.turnin 10518 >> Turn in Planting the Banner
.goto Blade's Edge Mountains,36.28,66.24
.isQuestComplete 10518
.target Commander Skyshadow
step
#label BorgrimT
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Borgrim Stouthammer|r
.turnin 10512 >> Turn in Getting the Bladespire Tanked
.goto Blade's Edge Mountains,37.40,64.66
.isQuestComplete 10512
.target Borgrim Stouthammer
step
.goto Blade's Edge Mountains,55.11,72.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_R-3D0|r
.turnin 10580 >> Turn in Where Did Those Darn Gnomes Go?
.accept 10581 >> Accept Follow the Breadcrumbs
.isQuestComplete 10580
.target R-3D0
step
.goto Blade's Edge Mountains,55.11,72.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_R-3D0|r
.accept 10581 >> Accept Follow the Breadcrumbs
.isQuestTurnedIn 10580
.target R-3D0
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Toshley|r
.turnin 10581 >> Turn in Follow the Breadcrumbs
.goto Blade's Edge Mountains,60.53,68.97
.isQuestComplete 10581
.target Toshley
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tally Zapnabber|r
.turnin 10557 >> Turn in Test Flight: The Zephyrium Capacitorium
.goto Blade's Edge Mountains,60.28,68.39
.isQuestComplete 10557
.target Tally Zapnabber
step
#label ToshStation
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Toshley|r
.turnin 10584 >> Turn in Picking Up Some Power Converters
.goto Blade's Edge Mountains,60.53,68.97
.isQuestComplete 10584
.target Toshley
step
#completewith CrystalClear
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Razak Ironsides|r patrolling the Station
.turnin 10632 >> Turn in Cutting Your Teeth
.isQuestComplete 10632
.target Razak Ironsides
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nickwinkle the Metro-Gnome|r
.turnin 10608 >> Turn in Crystal Clear
.goto Blade's Edge Mountains,60.22,68.94
.isQuestComplete 10608
.target Nickwinkle the Metro-Gnome
step
#label CrystalClear
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dizzy Dina|r
.turnin 10620 >> Turn in Ridgespine Menace
.goto Blade's Edge Mountains,60.40,68.75
.isQuestComplete 10620
.target Dizzy Dina
step
.goto Blade's Edge Mountains,59.99,69.32,30,0
.goto Blade's Edge Mountains,60.28,68.98,30,0
.goto Blade's Edge Mountains,60.11,68.37,30,0
.goto Blade's Edge Mountains,59.81,68.29,30,0
.goto Blade's Edge Mountains,60.03,67.79,30,0
.goto Blade's Edge Mountains,60.31,68.23,30,0
.goto Blade's Edge Mountains,60.42,67.91,30,0
.goto Blade's Edge Mountains,60.54,68.76,30,0
.goto Blade's Edge Mountains,60.44,69.37
.line Blade's Edge Mountains,59.99,69.32,60.28,68.98,60.11,68.37,59.81,68.29,60.03,67.79,60.31,68.23,60.42,67.91,60.54,68.76,60.44,69.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Razak Ironsides|r patrolling the Station
.turnin 10632 >> Turn in Cutting Your Teeth
.isQuestComplete 10632
.target Razak Ironsides
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nickwinkle the Metro-Gnome|r
.turnin 10594 >> Turn in Gauging the Resonant Frequency
.goto Blade's Edge Mountains,60.22,68.94
.isQuestComplete 10594
.target Nickwinkle the Metro-Gnome
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tally Zapnabber|r
.turnin 10710 >> Turn in Test Flight: The Singing Ridge
.goto Blade's Edge Mountains,60.28,68.39
.isQuestComplete 10710
.target Tally Zapnabber
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizit "Doc" Clocktock|r
.turnin 10609 >> Turn in What Came First, the Drake or the Egg?
.goto Blade's Edge Mountains,60.98,68.11
.isQuestComplete 10609
.target Fizit "Doc" Clocktock
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Faradrella|r
.turnin 10753 >>Turn in Culling the Wild
.goto Blade's Edge Mountains,62.56,38.23
.isQuestComplete 10753
.target Faradrella
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mosswood the Ancient|r
.turnin 10770 >>Turn in Little Embers
.goto Blade's Edge Mountains,61.25,38.46
.isQuestComplete 10770
.target Mosswood the Ancient
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mosswood the Ancient|r
.turnin 10771 >>Turn in From the Ashes
.goto Blade's Edge Mountains,61.25,38.46
.isQuestComplete 10771
.target Mosswood the Ancient
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_O'Mally Zapnabber|r
.turnin 10810 >>Turn in Damaged Mask
.accept 10812 >>Accept Mystery Mask
.goto Blade's Edge Mountains,62.66,40.38
.isQuestComplete 10810
.target O'Mally Zapnabber
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_O'Mally Zapnabber|r
.accept 10812 >>Accept Mystery Mask
.goto Blade's Edge Mountains,62.66,40.38
.isQuestTurnedIn 10810
.target O'Mally Zapnabber
step
.goto Blade's Edge Mountains,62.53,39.91,40,0
.goto Blade's Edge Mountains,62.00,40.21,40,0
.goto Blade's Edge Mountains,61.45,39.73,40,0
.goto Blade's Edge Mountains,61.28,38.77,40,0
.goto Blade's Edge Mountains,62.20,38.15,40,0
.goto Blade's Edge Mountains,62.69,39.13
.line Blade's Edge Mountains,62.53,39.91,62.00,40.21,61.45,39.73,61.28,38.77,62.20,38.15,62.69,39.13,62.53,39.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wildlord Antelarion|r, he patrols counter-clockwise around the town
.turnin 10812 >>Turn in Mystery Mask
.isQuestComplete 10812
.target Wildlord Antelarion
step
.goto Blade's Edge Mountains,62.53,39.91,40,0
.goto Blade's Edge Mountains,62.00,40.21,40,0
.goto Blade's Edge Mountains,61.45,39.73,40,0
.goto Blade's Edge Mountains,61.28,38.77,40,0
.goto Blade's Edge Mountains,62.20,38.15,40,0
.goto Blade's Edge Mountains,62.69,39.13
.line Blade's Edge Mountains,62.53,39.91,62.00,40.21,61.45,39.73,61.28,38.77,62.20,38.15,62.69,39.13,62.53,39.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wildlord Antelarion|r, he patrols counter-clockwise around the town
.accept 10819 >>Accept Felsworn Gas Mask
.isQuestTurnedIn 10812
.target Wildlord Antelarion
step
#completewith next
.cast 38448 >> Equip the |T133133:0|t[Felsworn Gas Mask] in your bags to be able to talk to the |cRXP_FRIENDLY_Legion Communicator|r

step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Legion Communicator|r with your |T133133:0|t[Felsworn Gas Mask] equipped
.goto Blade's Edge Mountains,73.27,40.03
.turnin 10819 >>Turn in Felsworn Gas Mask
.isQuestComplete 10819

step
#completewith next
.cast 38448 >> Equip the |T133133:0|t[Felsworn Gas Mask] in your bags to be able to talk to the |cRXP_FRIENDLY_Legion Communicator|r

step
.goto Blade's Edge Mountains,73.27,40.03
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Legion Communicator|r with your |T133133:0|t[Felsworn Gas Mask] equipped
.turnin 10820 >>Turn in Deceive thy Enemy
.isQuestComplete 10820

step
#completewith Nuaar
.hs >>Hearth to Evergrove
.cooldown item,6948,>2
step
.goto Blade's Edge Mountains,62.53,39.91,40,0
.goto Blade's Edge Mountains,62.00,40.21,40,0
.goto Blade's Edge Mountains,61.45,39.73,40,0
.goto Blade's Edge Mountains,61.28,38.77,40,0
.goto Blade's Edge Mountains,62.20,38.15,40,0
.goto Blade's Edge Mountains,62.69,39.13
.line Blade's Edge Mountains,62.53,39.91,62.00,40.21,61.45,39.73,61.28,38.77,62.20,38.15,62.69,39.13,62.53,39.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wildlord Antelarion|r, he patrols counter-clockwise around the town
.turnin 10821 >> Turn in You're Fired!
.isQuestComplete 10821
.target Wildlord Antelarion
step
#label Nuaar
.line Blade's Edge Mountains,62.82,25.94,63.12,27.41,63.34,27.87,63.28,28.37,62.73,28.77,62.45,29.31,62.37,29.65,62.44,31.66,62.11,33.34,61.80,34.00,61.43,34.10,60.61,33.98,60.12,34.47,60.01,34.80,60.08,35.15,59.90,35.72,59.60,36.07,59.11,36.21,58.96,36.61,58.65,36.91,58.18,36.96,57.90,37.34,57.84,37.81,59.13,39.47,59.90,40.27,60.51,40.90,61.50,42.02,61.78,42.41,62.62,43.95,62.97,45.05,63.06,46.38
63.06,46.38
.goto Blade's Edge Mountains,63.06,46.38,60,0
.goto Blade's Edge Mountains,62.97,45.05,60,0
.goto Blade's Edge Mountains,62.62,43.95,60,0
.goto Blade's Edge Mountains,61.78,42.41,60,0
.goto Blade's Edge Mountains,61.50,42.02,60,0
.goto Blade's Edge Mountains,60.51,40.90,60,0
.goto Blade's Edge Mountains,59.90,40.27,60,0
.goto Blade's Edge Mountains,59.13,39.47,60,0
.goto Blade's Edge Mountains,57.84,37.81,60,0
.goto Blade's Edge Mountains,57.90,37.34,60,0
.goto Blade's Edge Mountains,58.18,36.96,60,0
.goto Blade's Edge Mountains,58.65,36.91,60,0
.goto Blade's Edge Mountains,58.96,36.61,60,0
.goto Blade's Edge Mountains,59.11,36.21,60,0
.goto Blade's Edge Mountains,59.60,36.07,60,0
.goto Blade's Edge Mountains,59.90,35.72,60,0
.goto Blade's Edge Mountains,60.08,35.15,60,0
.goto Blade's Edge Mountains,60.01,34.80,60,0
.goto Blade's Edge Mountains,60.12,34.47,60,0
.goto Blade's Edge Mountains,60.61,33.98,60,0
.goto Blade's Edge Mountains,61.80,34.00,60,0
.goto Blade's Edge Mountains,62.11,33.34,60,0
.goto Blade's Edge Mountains,62.44,31.66,60,0
.goto Blade's Edge Mountains,62.37,29.65,60,0
.goto Blade's Edge Mountains,62.45,29.31,60,0
.goto Blade's Edge Mountains,62.73,28.77,60,0
.goto Blade's Edge Mountains,63.28,28.37,60,0
.goto Blade's Edge Mountains,63.34,27.87,60,0
.goto Blade's Edge Mountains,63.12,27.41,60,0
.goto Blade's Edge Mountains,62.82,25.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Overseer Nuaar|r
>>He patrols the Wyrmcult camps of Ruuan Weald
.complete 10682,1 
.unitscan Overseer Nuaar
.skipgossip
.isOnQuest 10682
step
>>Return to Evergrove. Talk to Chawn
.turnin 10682 >>Turn in A Time for Negotiation...
.goto Blade's Edge Mountains,61.97,39.47
.isQuestComplete 10682
.target Tree Warden Chawn
step
>>Return to Evergrove
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Haephus Stonewall|r
.turnin 10795 >> Turn in A Date with Dorgok
.goto Blade's Edge Mountains,61.98,37.98
.isQuestComplete 10795
.target Commander Haephus Stonewall
step
>>Return to Evergrove
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Haephus Stonewall|r
.turnin 10797 >> Turn in Favor of the Gronn
.goto Blade's Edge Mountains,61.98,37.98
.isQuestComplete 10797
.target Commander Haephus Stonewall
step
>>Return to Evergrove
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Fairweather|r
.turnin 10796 >> Turn in Crush the Bloodmaul Camp!
.goto Blade's Edge Mountains,61.98,37.94
.isQuestComplete 10796
.target Lieutenant Fairweather
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Timeon|r
.turnin 10567 >>Turn in Creating the Pendant
.goto Blade's Edge Mountains,62.16,39.11
.isQuestComplete 10567
.target Timeon
step
.goto Blade's Edge Mountains,61.97,39.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tree Warden Chawn|r and |cRXP_FRIENDLY_Samia Inkling|r
.turnin 10713 >>Turn in ...and a Time for Action
.isQuestComplete 10713
.target Tree Warden Chawn
step
.goto Blade's Edge Mountains,61.97,39.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tree Warden Chawn|r
.turnin 10719 >>Turn in Did You Get The Note?
.target Tree Warden Chawn
.isQuestComplete 10719
step
.goto Blade's Edge Mountains,61.94,39.45
.turnin 10717 >>Turn in Poaching from Poachers
.isQuestComplete 10717
.target Samia Inkling
step
.goto Blade's Edge Mountains,53.25,41.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Baron Sablemane|r
.turnin 10798 >> Turn in Pay the Baron a Visit
.isQuestComplete 10798
.target Baron Sablemane
step
.goto Blade's Edge Mountains,53.25,41.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Baron Sablemane|r
.turnin 10799 >> Turn in Into the Churning Gulch
.isQuestComplete 10799
.target Baron Sablemane
step
.goto Blade's Edge Mountains,53.25,41.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Baron Sablemane|r
.turnin 10800 >> Turn in Goodnight, Gronn
.isQuestComplete 10800
.target Baron Sablemane
step
#label Evergrove3
>>Return to Evergrove
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Haephus Stonewall|r
.turnin 10801 >> Turn in It's a Trap!
.goto Blade's Edge Mountains,61.98,37.98
.isQuestComplete 10801
.target Commander Haephus Stonewall
step
.goto Blade's Edge Mountains,50.35,36.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Watcher Moonshade|r atop the bridge
.turnin 10894 >>Turn in Wyrmskull Watcher
.isQuestComplete 10894
.target Watcher Moonshade
step
.goto Blade's Edge Mountains,50.35,36.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Watcher Moonshade|r atop the bridge
.accept 10893 >>Accept Longtail is the Lynchpin
.isQuestTurnedIn 10894
.target Watcher Moonshade
step
>>Kill |cRXP_ENEMY_Draaca|r inside of the tunnel
.goto Blade's Edge Mountains,46.03,32.93,40,0
.goto Blade's Edge Mountains,45.81,32.90,40,0
.goto Blade's Edge Mountains,44.78,32.07
.complete 10893,1 
.unitscan Draaca Longtail
.isOnQuest 10893
step
.goto Blade's Edge Mountains,49.92,35.92,20,0
.goto Blade's Edge Mountains,50.35,36.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Watcher Moonshade|r
.turnin 10893 >>Turn in Longtail is the Lynchpin
.isQuestComplete 10893
.target Watcher Moonshade
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Fairweather|r
.turnin 10803 >> Turn in Slaughter at Boulder'mok
.goto Blade's Edge Mountains,61.98,37.94
.isQuestComplete 10803
.target Lieutenant Fairweather
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Haephus Stonewall|r
.turnin 10802 >> Turn in Gorgrom the Dragon-Eater
.goto Blade's Edge Mountains,61.98,37.98
.isQuestComplete 10802
.target Commander Haephus Stonewall
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Timeon|r
.turnin 10607 >> Turn in Whispers of the Raven God
.goto Blade's Edge Mountains,62.16,39.11
.isQuestComplete 10607
.target Timeon
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tree Warden Chawn|r
.turnin 10722 >> Turn in Meeting at the Blackwing Coven
.goto Blade's Edge Mountains,61.97,39.47
.isQuestComplete 10722
.target Tree Warden Chawn
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tree Warden Chawn|r
.turnin 10825 >> Turn in The Truth Unorbed
.goto Blade's Edge Mountains,61.97,39.47
.isQuestComplete 10825
.target Tree Warden Chawn
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Samia Inkling|r
.turnin 10747 >> Turn in Whelps of the Wyrmcult
.goto Blade's Edge Mountains,61.94,39.45
.isQuestComplete 10747
.target Samia Inkling
step
#completewith next
.goto Blade's Edge Mountains,64.81,68.32,-1
.goto Blade's Edge Mountains,61.96,60.29,-1
.cast 38782 >>Use the |T135815:0|t[Druid Signal] in your bags to summon an |cRXP_FRIENDLY_Evergrove Druid|r
.timer 18,Druid Signal RP
.isQuestComplete 10904
step
.goto Blade's Edge Mountains,64.81,68.32,-1
.goto Blade's Edge Mountains,61.96,60.29,-1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Evergrove Druid|r
.turnin 10904 >> Turn in Harvesting the Fel Ammunition
.isQuestComplete 10904
.target Evergrove Druid
step
#completewith next
.goto Blade's Edge Mountains,62.50,60.17
.cast 38782 >>Use the |T135815:0|t[Druid Signal] in your bags to summon an |cRXP_FRIENDLY_Evergrove Druid|r
.timer 18,Druid Signal RP
.isOnQuest 10911
step
.goto Blade's Edge Mountains,62.50,60.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Evergrove Druid|r
.turnin 10911 >> Turn in Fire At Will!
.accept 10912 >> Accept The Hound-Master
.isQuestTurnedIn 10821
.target Evergrove Druid
step
#completewith next
.goto Blade's Edge Mountains,63.62,59.11
.use 31809 >>Use the |T133749:0|t[Evergrove Wand] in your bags to summon |cRXP_FRIENDLY_Evergorve Ancients|r. They will help you fight |cRXP_ENEMY_Baelmon|r
>>Kill |cRXP_ENEMY_Baelmon|r
.isOnQuest 10912
.mob Baelmon the Hound-Master
step
.goto Blade's Edge Mountains,63.62,59.11
>>Kill |cRXP_ENEMY_Baelmon the Hound-Master|r. This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him.
.complete 10912,1 
.use 31809
.isQuestTurnedIn 10821
.isOnQuest 10912
.target Baelmon the Hound-Master
step
#label HoundMaster
.goto Blade's Edge Mountains,62.53,39.91,40,0
.goto Blade's Edge Mountains,62.00,40.21,40,0
.goto Blade's Edge Mountains,61.45,39.73,40,0
.goto Blade's Edge Mountains,61.28,38.77,40,0
.goto Blade's Edge Mountains,62.20,38.15,40,0
.goto Blade's Edge Mountains,62.69,39.13
.line Blade's Edge Mountains,62.53,39.91,62.00,40.21,61.45,39.73,61.28,38.77,62.20,38.15,62.69,39.13,62.53,39.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wildlord Antelarion|r, he patrols counter-clockwise around the town
.turnin 10912 >> Turn in The Hound-Master
.isQuestComplete 10912
.target Wildlord Antelarion
step
.abandon 10912 >> Abandon The Hound-Master
]])
RXPGuides.RegisterGuide([[
#cata
#Cata
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 68-71 Howling Fjord
#version 5
#next 71-73 Borean Tundra
#questguide << !wotlk
step
#completewith HowlingTP
.cast 387060 >> |cRXP_WARN_Use the|r |T134943:0|t[Teleport Scroll: Menethil Harbor] |cRXP_WARN_to teleport to Menethil Harbor|r
.use 199335
.zoneskip Wetlands
.zoneskip HowlingFjord
.itemcount 199335,1
step
.goto Shattrath City,56.32,36.96 << !Mage
.zone Ironforge >> Travel to Ironforge << !Mage
.zone Ironforge >> Teleport to Ironforge << Mage
.zoneskip Wetlands
.zoneskip HowlingFjord
.itemcount 199335,<1
step
#completewith next
.goto Ironforge,55.51,47.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryth|r
.fly Wetlands>> Fly to Wetlands
.zoneskip Wetlands
.zoneskip HowlingFjord
.itemcount 199335,<1
.target Gryth Thurden
step
#label HowlingTP
.goto Wetlands,4.52,57.28
.zone HowlingFjord >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ludin|r
>>Ask |cRXP_FRIENDLY_Ludin|r for a teleport to Valgarde
.skipgossip
.target Ludin Farrow
step
#label Dock
.goto HowlingFjord,60.80,62.50
>>|cRXP_WARN_Jump off the boat when you see the dock|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Macalroy|r
.accept 11228 >>Accept Hell Has Frozen Over...
.target Macalroy
step
.goto HowlingFjord,60.36,60.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keller|r
.turnin 11228 >>Turn in Hell Has Frozen Over...
.accept 11243 >>Accept If Valgarde Falls...
.target Vice Admiral Keller
step << skip
#completewith next
.goto HowlingFjord,60.11,61.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torik|r
.vendor >> Buy ammunition if needed
.target Torik
step
.goto HowlingFjord,58.66,59.65,50,0
.goto HowlingFjord,57.33,58.20,50,0
.goto HowlingFjord,59.00,56.65,50,0
.goto HowlingFjord,59.00,59.93
>>Kill |cRXP_ENEMY_Dragonflayer Invaders|r and |cRXP_ENEMY_Dragonflayer Worgs|r
.complete 11243,1 
.mob Dragonflayer Invader
.mob Dragonflayer Worg
step
.goto HowlingFjord,60.57,61.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keller|r
.turnin 11243 >>Turn in If Valgarde Falls...
.accept 11244 >>Accept Rescuing the Rescuers
.target Vice Admiral Keller
step
.goto HowlingFjord,58.90,56.28,40,0
.goto HowlingFjord,57.1,56.7,40,0
.goto HowlingFjord,58.90,56.28,40,0
.goto HowlingFjord,57.1,56.7
>>Click the |cRXP_LOOT_Ceremonial Dragonflayer Harpoons|r to rescue |cRXP_FRIENDLY_Impaled Valgarde Scouts|r
.complete 11244,1 
.target Impaled Valgarde Scout
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keller|r, |cRXP_FRIENDLY_Beltrand|r and |cRXP_FRIENDLY_Thoralius|r
.turnin 11244 >>Turn in Rescuing the Rescuers
.accept 11255 >>Accept Prisoners of Wyrmskull
.goto HowlingFjord,60.57,61.30
.accept 11273 >>Accept The Human League
.goto HowlingFjord,60.17,61.03
.accept 11333 >>Accept Into the World of Spirits
.goto HowlingFjord,59.80,61.47
.target Vice Admiral Keller
.target Beltrand McSorf
.target Thoralius the Wise
step
#completewith Ares
.goto HowlingFjord,58.6,63.1,15,0
.goto HowlingFjord,58.39,62.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hazel|r
.home >> Set your Hearthstone to Valgarde
>>|cRXP_BUY_Buy new food/water if needed|r
.target Innkeeper Hazel Lagras
step
.goto HowlingFjord,59.79,63.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pricilla|r
.fp Valgarde >>Get the Valgarde Flight Path
.target Pricilla Winterwind
step
.goto HowlingFjord,60.12,62.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zorek|r
.accept 11420 >>Accept The Path to Payback
.target Guard Captain Zorek
step
#questguide
#completewith next
>>Loot the |cRXP_LOOT_Reagent Pouch|r on the sunken ship
.complete 11333,1 
step
#questguide
.goto HowlingFjord,62.7,58.0,60,0
.goto HowlingFjord,62.5,60.9,60,0
.goto HowlingFjord,61.5,58.4,60,0
.goto HowlingFjord,62.0,56.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harold Lagras|r. |cRXP_WARN_He walks along the bottom of the water|r
.accept 11443 >>Accept Daggercap Divin'
.unitscan Harold Lagras
step << !Druid !Warlock
#questguide
#completewith next
.cast 50002 >>Equip the |T133151:0|t[Diving Helm]
.use 34082
step
#questguide
#completewith next
.goto HowlingFjord,62.7,57.4,0
>>Loot the |cRXP_LOOT_Valgarde Supply Crates|r
.complete 11443,1 
step
.goto HowlingFjord,62.07,57.64,-1
.goto HowlingFjord,62.39,59.32,-1
>>Loot the |cRXP_LOOT_Reagent Pouch|r on the sunken ship
.complete 11333,1 
step
#questguide
.goto HowlingFjord,61.8,56.2,50,0
.goto HowlingFjord,62.73,61.58,50,0
.goto HowlingFjord,62.3,60.9,50,0
.goto HowlingFjord,61.1,57.7
>>Loot the |cRXP_LOOT_Valgarde Supply Crates|r
.complete 11443,1 
step
#questguide
.goto HowlingFjord,62.7,58.0,60,0
.goto HowlingFjord,62.5,60.9,60,0
.goto HowlingFjord,61.5,58.4,60,0
.goto HowlingFjord,62.0,56.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harold Lagras|r. |cRXP_WARN_He walks along the bottom of the water|r
.turnin 11443 >>Turn in Daggercap Divin'
.unitscan Harold Lagras
step
.goto HowlingFjord,59.80,61.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thoralius|r
.turnin 11333 >>Turn in Into the World of Spirits
.accept 11343 >>Accept The Echo of Ymiron
.target Thoralius the Wise
step
#completewith next
.goto HowlingFjord,57.9,53.6,60,0
.goto HowlingFjord,58.8,54.2,0
.goto HowlingFjord,58.7,52.7,0
.goto HowlingFjord,59.9,53.1,0
.goto HowlingFjord,59.4,51.3,0
.goto HowlingFjord,57.9,51.4,0
>>Kill |cRXP_ENEMY_Dragonflayer Death Weavers|r, |cRXP_ENEMY_Dragonflayer Harpooners|r, |cRXP_ENEMY_Dragonflayer Tribesmen|r and |cRXP_ENEMY_Dragonflayers Thanes|r. Loot them for their |T134242:0|t[|cRXP_LOOT_Dragonflayer Cage Keys|r]
>>|cRXP_WARN_Use the|r |T134242:0|t[|cRXP_LOOT_Dragonflayer Cage Keys|r] |cRXP_WARN_on the |cRXP_FRIENDLY_Captured Valgarde|r cages|r
.collect 33308,3,11255,1,-1
.complete 11255,1 
.mob Dragonflayer Death Weaver
.mob Dragonflayer Harpooner
.mob Dragonflayer Tribesman
.mob Dragonflayer Thane
step
.goto HowlingFjord,59.19,54.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pulroy|r
.turnin 11273 >>Turn in The Human League
.accept 11274 >>Accept Zedd's Probably Dead
.target Pulroy the Archaeologist
step
.goto HowlingFjord,58.70,52.68,30,0
.goto HowlingFjord,59.94,53.17,30,0
.goto HowlingFjord,59.44,51.28,30,0
.goto HowlingFjord,57.86,51.31,30,0
.goto HowlingFjord,57.76,53.35,30,0
.goto HowlingFjord,56.44,54.33
>>Kill |cRXP_ENEMY_Dragonflayer Death Weavers|r, |cRXP_ENEMY_Dragonflayer Harpooners|r, |cRXP_ENEMY_Dragonflayer Tribesmen|r and |cRXP_ENEMY_Dragonflayers Thanes|r. Loot them for their |T134242:0|t[|cRXP_LOOT_Dragonflayer Cage Keys|r]
>>|cRXP_WARN_Use the|r |T134242:0|t[|cRXP_LOOT_Dragonflayer Cage Keys|r] |cRXP_WARN_on the |cRXP_FRIENDLY_Captured Valgarde|r cages|r
.collect 33308,3,11255,1,-1
.complete 11255,1 
.mob Dragonflayer Death Weaver
.mob Dragonflayer Harpooner
.mob Dragonflayer Tribesman
.mob Dragonflayer Thane
step
#questguide
#completewith next
.goto HowlingFjord,56.4,55.1,30 >> Travel toward |cRXP_FRIENDLY_Valory|r
step
#questguide
.goto HowlingFjord,55.95,55.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Valory|r
.accept 11251 >>Accept Fresh Legs
.target Scout Valory
step
.goto HowlingFjord,60.57,61.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keller|r
.turnin 11255 >>Turn in Prisoners of Wyrmskull
.accept 11290 >>Accept Dragonflayer Battle Plans
.target Vice Admiral Keller
step
.goto HowlingFjord,56.63,52.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zedd|r (|cRXP_WARN_the corpse on the ground|r)
.turnin 11274 >>Turn in Zedd's Probably Dead
.accept 11276 >>Accept And Then There Were Two...
.target Zedd
step
#completewith next
.goto HowlingFjord,55.69,52.58,20 >> Enter the cave
step
.goto HowlingFjord,55.69,52.58
>>Loot the |cRXP_LOOT_Dragonflayer Battle Plans|r on the wall
.complete 11290,1 
step
#completewith next
.goto HowlingFjord,56.60,48.97,30 >> Travel across the bridge above you, then follow the path into the Utgarde Catacombs
>>|cRXP_WARN_You can also jump up via the north side of the cave and skip the bridge entirely to avoid being dismounted|r
.skill coldweatherflying,1,1
step
#completewith next
.goto HowlingFjord,56.05,49.20,20,0
.goto HowlingFjord,56.3,51.8,25 >> Travel down the winding path into the Utgarde Catacombs
step
.goto HowlingFjord,56.94,53.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Glorenfeld|r
.turnin 11276 >>Turn in And Then There Were Two...
.accept 11277 >>Accept The Depths of Depravity
.target Glorenfeld
step
#completewith Ares
.goto HowlingFjord,57.7,56.6,0
>>Loot the |cRXP_LOOT_Wyrmskull Tablets|r on the ground
.complete 11277,1 
step
#completewith next
.goto HowlingFjord,57.7,56.2,30 >> Travel to |cRXP_FRIENDLY_Ares|r
step
.goto HowlingFjord,59.34,55.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ares|r
>>|cRXP_WARN_This will quest will give you a buff with a 10 minute timer|r
.accept 11288 >>Accept The Shining Light
.target Ares the Oathbound
step
.goto HowlingFjord,59.26,55.37
>>Loot the |cRXP_LOOT_Harpoon Operation Manual|r on the ground
.complete 11420,1 
step
#completewith next
.goto HowlingFjord,56.3,56.8,50,0
.goto HowlingFjord,57.1,55.7,20 >> Travel all the way down the stairs. Run straight through the |cRXP_ENEMY_Ghouls|r into the room on the bottom floor
step
.goto HowlingFjord,56.64,53.43
>>Loot the |cRXP_LOOT_Sacred Artifact|r on the ground
.complete 11288,1 
step
#completewith next
.goto HowlingFjord,56.83,57.16,15,0
.goto HowlingFjord,56.43,56.48,15 >> Travel back upstairs to |cRXP_FRIENDLY_Ares|r
step
#label Ares
.goto HowlingFjord,59.34,55.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ares|r
.turnin 11288 >>Turn in The Shining Light
.accept 11289 >>Accept Guided by Honor
.target Ares the Oathbound
step
.goto HowlingFjord,56.94,53.76,40,0
.goto HowlingFjord,59.34,55.42,40,0
.goto HowlingFjord,56.94,53.76,40,0
.goto HowlingFjord,59.34,55.42,40,0
.goto HowlingFjord,56.94,53.76
>>Loot the |cRXP_LOOT_Wyrmskull Tablets|r on the ground
.complete 11277,1 
step
.goto HowlingFjord,56.94,53.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Glorenfeld|r
.turnin 11277 >>Turn in The Depths of Depravity
.accept 11299 >>Accept The Ring of Judgement
.target Glorenfeld
step
#completewith next
.goto HowlingFjord,57.0,56.3,45 >> Travel down the stairs one floor toward |cRXP_FRIENDLY_Daegarn|r
step
.goto HowlingFjord,55.72,57.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Daegarn|r in the cage
.turnin 11299 >>Turn in The Ring of Judgement
.accept 11300 >>Accept Stunning Defeat at the Ring
.target Daegarn
step
.goto HowlingFjord,54.94,57.38
>>Kill the |cRXP_ENEMY_Gladiators|r that enter the |cRXP_WARN_Ring of Judgement|r, until |cRXP_ENEMY_Oluf the Violent|r enters
>>Kill |cRXP_ENEMY_Oluf the Violent|r. Loot the |cRXP_LOOT_Ancient Cipher|r he drops on the ground
.complete 11300,1 
.mob Firjus the Soul Crusher
.mob Jlarborn the Strategist
.mob Yorus the Flesh Harvester
.mob Oluf the Violent
step
#completewith next
.goto HowlingFjord,57.18,55.59,15 >> Travel toward |cRXP_FRIENDLY_Glorenfeld|r
step
.goto HowlingFjord,56.94,53.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Glorenfeld|r
.turnin 11300 >>Turn in Stunning Defeat at the Ring
.accept 11278 >>Accept Return to Valgarde
.target Glorenfeld
step
#completewith next
.hs >> Hearth to Valgarde Keep
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Irulon|r, |cRXP_FRIENDLY_Zorek|r, |cRXP_FRIENDLY_Keller|r, and |cRXP_FRIENDLY_Beltrand|r
.turnin 11289 >>Turn in Guided by Honor
.goto HowlingFjord,59.74,62.44
.turnin 11420 >>Turn in The Path to Payback
.accept 11426 >>Accept Locating the Mechanism
.goto HowlingFjord,60.12,62.43
.turnin 11290 >>Turn in Dragonflayer Battle Plans
.accept 11291 >>Accept To Westguard Keep!
.goto HowlingFjord,60.57,61.30
.turnin 11278 >>Turn in Return to Valgarde
.accept 11448 >>Accept The Explorers' League Outpost
.goto HowlingFjord,60.17,61.03
.target Lord Irulon Trueblade
.target Vice Admiral Keller
.target Beltrand McSorf
.target Guard Captain Zorek
step
#completewith SecretsW
.goto HowlingFjord,60.1,53.4,70,0
.goto HowlingFjord,60.8,51.1,0
>>Kill |cRXP_ENEMY_Dragonflayer Harpooners|r. Loot them for the |cRXP_LOOT_Harpoon Control Mechanism|r
.complete 11426,1 
.mob Dragonflayer Harpooner
step
#completewith next
.goto HowlingFjord,60.28,50.51
.cast 42786 >> |cRXP_WARN_Use the|r |T132845:0|t[Incense Burner] |cRXP_WARN_outside of the building|r
.use 33637
step
#label SecretsW
.goto HowlingFjord,60.13,50.75,10 >>|cRXP_WARN_Go inside the building|r. |cRXP_WARN_Wait out the RP event|r
>>|cRXP_WARN_Do NOT go back outside or you'll have to click off the|r |T135867:0|t[Echo of Ymiron] |cRXP_WARN_Buff|r, |cRXP_WARN_then use the|r |T132845:0|t[Incense Burner] |cRXP_WARN_again|r
.timer 47,Secrets of Wyrmskull RP
.goto HowlingFjord,60.13,50.75
.use 33637
.complete 11343,1 
step
.goto HowlingFjord,60.8,51.1,15,0
.goto HowlingFjord,60.1,53.4
>>|cRXP_WARN_Click off your|r |T135867:0|t[Echo of Ymiron] |cRXP_WARN_buff|r
>>Kill |cRXP_ENEMY_Dragonflayer Harpooners|r. Loot them for the |cRXP_LOOT_Harpoon Control Mechanism|r
.complete 11426,1 
.mob Dragonflayer Harpooner
step
#questguide
#completewith next
.goto HowlingFjord,60.7,48.9,25 >> Travel up the path to |cRXP_FRIENDLY_Mordun|r
step
#questguide
.goto HowlingFjord,59.56,48.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mordun|r
>>|cRXP_WARN_Click off your|r |T135867:0|t[Echo of Ymiron] |cRXP_WARN_buff if you still have it|r
.turnin 11251 >>Turn in Fresh Legs


.target Defender Mordun
step << skip
#completewith next
.hs >> Hearth to Valgarde
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thoralius|r and |cRXP_FRIENDLY_Zorek|r
.turnin 11343 >>Turn in The Echo of Ymiron
.accept 11344 >>Accept Anguish of Nifflevar
.goto HowlingFjord,59.80,61.47
.turnin 11426 >>Turn in Locating the Mechanism
.accept 11427 >>Accept Meet Lieutenant Icehammer...
.vehicle >> Ask Zorek for a ride
.timer 30,Fly to Icehammer
.goto HowlingFjord,60.12,62.43
.skipgossip
.target Thoralius the Wise
.target Guard Captain Zorek
step
#completewith next
.goto HowlingFjord,64.43,46.95,90 >> Travel toward |cRXP_FRIENDLY_Lieutenant Icehammer|r
step
.goto HowlingFjord,64.43,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Icehammer|r
.turnin 11427 >>Turn in Meet Lieutenant Icehammer...
.accept 11429 >>Accept Drop It then Rock It!
.target Lieutenant Icehammer
step
.goto HowlingFjord,64.81,39.95
.use 34051 >>|cRXP_WARN_Use the|r |T132486:0|t[Alliance Banner] |cRXP_WARN_near the|r |cRXP_PICK_Bonfire|r
>>Kill the |cRXP_ENEMY_Winterskorn|r attackers
.complete 11429,2 
.cast 44117
.timer 60,Banner Defended
.complete 11429,1 
.mob Winterskorn Defender
.mob Winterskorn Bonegrinder
step
.goto HowlingFjord,64.43,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Icehammer|r
.turnin 11429 >>Turn in Drop It then Rock It!
.accept 11430 >>Accept Harpoon Master Yavus
.target Lieutenant Icehammer
step
.goto HowlingFjord,65.15,56.58
>>Kill |cRXP_ENEMY_Yavus|r inside
.complete 11430,1 
.mob Harpoon Master Yavus
step
#completewith next
.goto HowlingFjord,68.95,54.44
.cast 43466 >>|cRXP_WARN_Use the|r |T132845:0|t[Incense Burner] |cRXP_WARN_in Nifflevar|r
.timer 68,Secrets of Nifflevar RP
.use 33774
step
.goto HowlingFjord,68.95,54.44
>>|cRXP_WARN_Wait out the RP|r
.complete 11344,1 
.use 33774
step
#completewith next
.goto HowlingFjord,74.95,65.41,100 >>Travel to the Explorers' League Outpost
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stanwad|r, |cRXP_FRIENDLY_Walt|r, and |cRXP_FRIENDLY_Hidalgo|r
.turnin 11448 >>Turn in The Explorers' League Outpost
.accept 11474 >>Accept Problems on the High Bluff
.goto HowlingFjord,74.95,65.41
.turnin 11474 >>Turn in Problems on the High Bluff
.accept 11475 >>Accept Tools to Get the Job Done
.goto HowlingFjord,75.05,65.52
.accept 11460 >>Accept Trust is Earned
.goto HowlingFjord,75.27,64.97
.target Stanwad
.target Walt
.target Hidalgo the Master Falconer
step
#completewith next
.goto HowlingFjord,75.80,64.56
>>Open a |cRXP_PICK_Loose Rock|r. Loot it for a |cRXP_LOOT_Fjord Grub|r
.collect 34102,1,11460,1 
step
.goto HowlingFjord,75.24,64.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Rock Falcon|r in the cage
.complete 11460,1 
.skipgossip
.target Rock Falcon
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hidalgo|r
.goto HowlingFjord,75.27,64.97
.turnin 11460 >>Turn in Trust is Earned
.accept 11465 >>Accept The Ransacked Caravan
.target Hidalgo the Master Falconer
step
#completewith next
.groundgoto HowlingFjord,74.67,56.35,80,0
.groundgoto HowlingFjord,74.42,53.15,70,0
.groundgoto HowlingFjord,76.51,50.18,70,0
.goto HowlingFjord,78.80,48.86,100 >> Travel to Ivald's Ruin
step
.goto HowlingFjord,78.80,48.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donny|r
.accept 11477 >>Accept Out of My Element?

.target Donny
step
#completewith next
.goto HowlingFjord,77.0,47.2,0
>>Kill |cRXP_ENEMY_Iron Rune Laborers|r, |cRXP_ENEMY_Iron Rune Destroyers|r and |cRXP_ENEMY_Iron Rune Sages|r
.complete 11477,2 
.complete 11477,1 
.complete 11477,3 
.mob Iron Rune Laborer
.mob Iron Rune Destroyer
.mob Iron Rune Sage
step
.goto HowlingFjord,79.00,47.56
>>Loot the |cRXP_LOOT_Building Tools|r on the wooden platform
.complete 11475,1 
step
>>Kill |cRXP_ENEMY_Iron Rune Laborers|r, |cRXP_ENEMY_Iron Rune Destroyers|r and |cRXP_ENEMY_Iron Rune Sages|r
.complete 11477,2 
.goto HowlingFjord,79.1,46.3,30,0
.goto HowlingFjord,78.0,46.5,30,0
.goto HowlingFjord,78.0,48.4
.complete 11477,1 
.goto HowlingFjord,77.3,49.0,25,0
.goto HowlingFjord,77.2,45.6,25,0
.goto HowlingFjord,79.6,45.5
.complete 11477,3 
.goto HowlingFjord,77.8,46.3,-1
.goto HowlingFjord,79.5,47.2,-1
.mob Iron Rune Laborer
.mob Iron Rune Destroyer
.mob Iron Rune Sage
step
.goto HowlingFjord,78.80,48.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donny|r
.turnin 11477 >>Turn in Out of My Element?
.target Donny
step
#completewith next
.groundgoto HowlingFjord,76.51,50.18,70,0
.groundgoto HowlingFjord,74.42,53.15,70,0
.groundgoto HowlingFjord,74.67,56.35,80,0
.goto HowlingFjord,75.05,65.52,100 >> Travel to the Explorers' League Outpost
step
.goto HowlingFjord,75.05,65.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Walt|r
.turnin 11475 >>Turn in Tools to Get the Job Done
.accept 11483 >>Accept We Can Rebuild It
.accept 11484 >>Accept We Have the Technology
.target Walt
step
#completewith Turkey
.goto HowlingFjord,73.49,66.08,40,0
.goto HowlingFjord,69.6,67.2
>>Kill |cRXP_ENEMY_Shoveltusks|r. Loot them for their |cRXP_LOOT_Pristine Hide|r
.complete 11484,1 
.mob Shoveltusk
.mob Shoveltusk Calf
.mob Shoveltusk Stag
step
.goto HowlingFjord,70.71,68.31,10,0
.goto HowlingFjord,70.53,68.13,10,0
.goto HowlingFjord,69.56,66.62,10,0
.goto HowlingFjord,68.67,66.92,10,0
.goto HowlingFjord,68.82,66.38
>>Open |cRXP_PICK_Loose Rocks|r. Loot them for |cRXP_LOOT_Fjord Grubs|r
.collect 34102,5,11465,1 
step
#label Turkey
.use 34111 >>|cRXP_WARN_Use the|r |T132598:0|t[Trained Rock Falcon] |cRXP_WARN_while you have a |cRXP_LOOT_Grub|r to capture a|r |cRXP_ENEMY_Fjord Turkey|r
.collect 34102,5,11465,1,-1 
.complete 11465,1 
.goto HowlingFjord,69.19,64.68
.target Fjord Turkey
step
.goto HowlingFjord,70.02,67.61,40,0
.goto HowlingFjord,68.91,69.88
>>Kill |cRXP_ENEMY_Shoveltusks|r. Loot them for their |cRXP_LOOT_Pristine Hide|r
.complete 11484,1 
.mob Shoveltusk
.mob Shoveltusk Calf
.mob Shoveltusk Stag
step
.goto HowlingFjord,64.43,46.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Icehammer|r
.turnin 11430 >>Turn in Harpoon Master Yavus
.accept 11421 >>Accept It Goes to 11...
.target Lieutenant Icehammer
step
#completewith next
.goto HowlingFjord,64.57,40.97,100 >> Travel to Baleheim
step
.goto HowlingFjord,64.57,40.97
>>Loot the |cRXP_LOOT_Industrial Strength Rope|r on the ground
.complete 11483,2 
step
#completewith 11
.goto HowlingFjord,67.9,53.5,0
>>Kill |cRXP_ENEMY_Dragonflayer Warriors|r and |cRXP_ENEMY_Dragonflayer Rune-Seers|r. Loot them for the |cRXP_LOOT_Steel Ribbing|r
.complete 11484,2 
.mob Dragonflayer Warrior
.mob Dragonflayer Rune-Seer
step
.goto HowlingFjord,67.58,52.25
>>Loot the |cRXP_LOOT_Large Barrel|r on the ground
.complete 11483,1 
step
#completewith next
.goto HowlingFjord,64.73,52.65,80 >> Travel to the Niffelvar cliff face
step
.goto HowlingFjord,64.73,52.65
.vehicle >>|cRXP_WARN_Use the|r |T133572:0|t[Harpoon Control Mechanism] |cRXP_WARN_on a|r |cRXP_PICK_Vrykul Harpoon Gun|r
.use 34032
step
>>|cRXP_WARN_Cast|r |T135826:0|t[Fiery Harpoon] (1) |cRXP_WARN_to destroy the Longhouse, Dockhouse and Storage Facility|r
>>|cRXP_WARN_Cast|r |T135825:0|t[Fiery Lance] (2) |cRXP_WARN_to kill the attacking|r |cRXP_ENEMY_Dragonflayer Defenders|r
>>|cRXP_ENEMY_Dragonflayer Defenders|r |cRXP_WARN_will spawn as you destroy the buildings|r
.complete 11421,2 
.complete 11421,3 
.complete 11421,4 
.complete 11421,1 
.use 34032
.mob Dragonflayer Defender
step
#label 11
.goto HowlingFjord,64.43,46.95
>>|cRXP_WARN_Exit the Harpoon|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Icehammer|r
.turnin 11421 >>Turn in It Goes to 11...
.accept 11436 >>Accept Let's Go Surfing Now
.target Lieutenant Icehammer
step
.goto HowlingFjord,67.1,55.4,50,0
.goto HowlingFjord,67.86,53.30,50,0
.goto HowlingFjord,68.72,52.36,50,0
.goto HowlingFjord,69.14,55.60,50,0
.goto HowlingFjord,67.64,56.45,50,0
.goto HowlingFjord,67.86,53.30
>>Kill |cRXP_ENEMY_Dragonflayer Warriors|r and |cRXP_ENEMY_Dragonflayer Rune-Seers|r. Loot them for the |cRXP_LOOT_Steel Ribbing|r
.complete 11484,2 
.mob Dragonflayer Warrior
.mob Dragonflayer Rune-Seer
step
#completewith next
.goto HowlingFjord,65.23,57.22,60 >> Travel to the balcony of the building
step
#completewith next
.goto HowlingFjord,65.23,57.22
.vehicle >>Click the |cRXP_PICK_Large Harpoon Lever|r
.timer 14,Ride the Harpoon
step
.goto HowlingFjord,60.03,62.09
>>Ride the Harpoon back to Valgarde Keep
.complete 11436,1 
step
.goto HowlingFjord,60.12,62.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zorek|r
.turnin 11436 >>Turn in Let's Go Surfing Now
.target Guard Captain Zorek
step
.goto HowlingFjord,59.80,61.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thoralius|r
.turnin 11344 >>Turn in Anguish of Nifflevar
.target Thoralius the Wise
step
.goto HowlingFjord,60.84,61.58
.gossipoption 93511 >> Talk to |cRXP_FRIENDLY_McGoyver|r
>>|cRXP_WARN_Choose the second option: "Walt sent me to pick up some dark iron ingots"|r
>>|cRXP_WARN_STOP TALKING TO HIM AFTER YOU GET THE INGOTS|r
.complete 11483,3 
.skipgossip
.target McGoyver
step
#completewith next
.goto HowlingFjord,63.4,64.7,40,0
.goto HowlingFjord,65.5,65.1,40 >>Travel east across the water. Ride up the small mountain path
.skill coldweatherflying,1,1
step
#completewith next
.goto HowlingFjord,75.05,65.52,100 >>Travel to the Explorers' League Outpost
step
#label OutpostX
.goto HowlingFjord,75.05,65.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Walt|r
.turnin 11483 >>Turn in We Can Rebuild It
.turnin 11484 >>Turn in We Have the Technology
.accept 11485 >>Accept Iron Rune Constructs and You: Rocket Jumping
.target Walt
step
#completewith next
.goto HowlingFjord,75.12,65.51
.vehicle >>Click the |cRXP_PICK_Work Bench|r
.skipgossip
step
.goto HowlingFjord,75.15,65.43
>>|cRXP_WARN_Cast|r |T133031:0|t[Rocket Jump] (1) |cRXP_WARN_to jump to the other rune on the ground|r
.complete 11485,1 
step
>>|cRXP_WARN_Exit the Iron Rune Construct|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hidalgo|r and |cRXP_FRIENDLY_Walt|r
.turnin 11465 >>Turn in The Ransacked Caravan
.accept 11468 >>Accept Falcon Versus Hawk
.goto HowlingFjord,75.27,64.97
.turnin 11485 >>Turn in Iron Rune Constructs and You: Rocket Jumping
.accept 11489 >>Accept Iron Rune Constructs and You: Collecting Data
.goto HowlingFjord,75.05,65.52
.target Walt
.target Hidalgo the Master Falconer
step
#completewith next
.goto HowlingFjord,75.12,65.51
.vehicle >>Click the |cRXP_PICK_Work Bench|r
.skipgossip
step
.goto HowlingFjord,74.82,65.74
>>Walk on top of the |cRXP_PICK_Blue Crystal|r
>>|cRXP_WARN_Cast|r |T133594:0|t[Collect Data] (1) |cRXP_WARN_to channel and collect the data|r
.complete 11489,1 
step
.goto HowlingFjord,75.05,65.52
>>|cRXP_WARN_Exit the Iron Rune Construct|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Walt|r
.turnin 11489 >>Turn in Iron Rune Constructs and You: Collecting Data
.accept 11491 >>Accept Iron Rune Constructs and You: The Bluff
.target Walt
step
#completewith next
.goto HowlingFjord,75.12,65.51
.vehicle >>Click the |cRXP_PICK_Work Bench|r
.skipgossip
step
.goto HowlingFjord,74.80,65.27
>>Walk on top of |cRXP_FRIENDLY_Lebronski's|r |cRXP_PICK_Rug|r
>>|cRXP_WARN_Cast|r |T135740:0|t[Bluff] (1) |cRXP_WARN_twice|r
.complete 11491,1 
.target Lebronski
step
.goto HowlingFjord,75.05,65.52
>>|cRXP_WARN_Exit the Iron Rune Construct|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Walt|r
.turnin 11491 >>Turn in Iron Rune Constructs and You: The Bluff
.accept 11494 >>Accept Lightning Infused Relics
.accept 11495 >>Accept The Delicate Sound of Thunder
.target Walt
step
#completewith next
.goto HowlingFjord,75.12,65.51
.vehicle >>Click the |cRXP_PICK_Work Bench|r
.skipgossip
step
.goto HowlingFjord,72.6,67.9,60,0
.goto HowlingFjord,72.12,70.40,10,0
.goto HowlingFjord,74.33,70.82,15 >>Travel in the Golem Suit to Baelgun's Excavation Site. |cRXP_WARN_Cast|r |T135740:0|t[Bluff] (3) |cRXP_WARN_if a |cRXP_ENEMY_Dwarf|r ever questions your|r |cRXP_FRIENDLY_Golem|r|cRXP_WARN_. Go onto the wooden platform and|r |T133031:0|t[Rocket Jump] (1) |cRXP_WARN_on the |cRXP_PICK_middle rune|r. Avoid the|r |cRXP_ENEMY_Rampaging Earth Elementals|r
step
#completewith next
.goto HowlingFjord,71.4,72.3,0
>>|cRXP_WARN_Cast|r |T133594:0|t[Collect Data] (2) |cRXP_WARN_when you are next to a|r |cRXP_PICK_small blue crystal|r |cRXP_WARN_to channel the collection of|r |cRXP_PICK_Rune Data|r
>>|cRXP_WARN_Cast|r |T135740:0|t[Bluff] (3) |cRXP_WARN_if a |cRXP_ENEMY_Dwarf|r ever questions your |cRXP_FRIENDLY_Golem|r
>>Avoid the|r |cRXP_ENEMY_Rampaging Earth Elementals|r
.complete 11494,1 
step
.goto HowlingFjord,73.4,70.3,20,0
.goto HowlingFjord,71.5,69.4,18 >>|cRXP_WARN_Travel into the cave. Halfway through the cave an RP event will trigger|r
>>|cRXP_WARN_Wait out the RP|r
.timer 46,Thundering Cave RP
.goto HowlingFjord,71.5,69.4
.complete 11495,1 
step
.goto HowlingFjord,71.4,72.3,30,0
.goto HowlingFjord,72.6,75.2,50,0
.goto HowlingFjord,73.4,72.0,50,0
.goto HowlingFjord,73.2,73.4
>>|cRXP_WARN_Run out of the cave|r. |cRXP_WARN_Drop down to the ground and wooden platforms below|r
>>|cRXP_WARN_Cast|r |T133594:0|t[Collect Data] (2) |cRXP_WARN_when you are next to a|r |cRXP_PICK_small blue crystal|r |cRXP_WARN_to channel the collection of|r |cRXP_PICK_Rune Data|r
>>|cRXP_WARN_Cast|r |T135740:0|t[Bluff] (3) |cRXP_WARN_if a |cRXP_ENEMY_Dwarf|r ever questions your |cRXP_FRIENDLY_Golem|r
>>Avoid the|r |cRXP_ENEMY_Rampaging Earth Elementals|r
.complete 11494,1 
step
#completewith next
.goto HowlingFjord,73.20,73.37,8,0
.goto HowlingFjord,71.97,70.10,30 >>|cRXP_WARN_Cast|r |T133031:0|t[Rocket Jump] (1) |cRXP_WARN_on the rune near the two tents at the bottom of the excavation site to jump back up to the top|r
step
.goto HowlingFjord,68.59,68.71,50,0
.goto HowlingFjord,68.01,63.80,50,0
.goto HowlingFjord,70.89,63.24,50,0
.goto HowlingFjord,74.20,59.48
>>|cRXP_WARN_Exit the Iron Rune Construct|r
>>Open |cRXP_PICK_Loose Rocks|r. Loot them for |cRXP_LOOT_Fjord Grubs|r
.use 34121 >>|cRXP_WARN_Use the|r |T132598:0|t[Trained Rock Falcon] |cRXP_WARN_while you have a |cRXP_LOOT_Grub|r to capture a|r |cRXP_ENEMY_Fjord Hawk|r
>>|cRXP_WARN_You can find these perched on top of rocks or about 50 yards high in the air|r
.collect 34102,10,11468,1,-1 
.complete 11468,1 
.target Fjord Hawk
step
#completewith next
.goto HowlingFjord,75.27,64.97,100 >>Travel to the Explorers' League Outpost
step
.goto HowlingFjord,75.27,64.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hidalgo|r
.turnin 11468 >>Turn in Falcon Versus Hawk
.accept 11470 >>Accept There Exists No Honor Among Birds
.target Hidalgo the Master Falconer
step
#completewith next
.goto HowlingFjord,76.70,67.78,60 >> Travel to the Vrykul Hawk Roost
step
#completewith next
.goto HowlingFjord,76.70,67.78
.cast 50019 >>|cRXP_WARN_Use the|r |T132598:0|t[Trained Rock Falcon] |cRXP_WARN_at the|r |cRXP_PICK_Hawk Roost|r
.use 34124
step
.goto HowlingFjord,76.70,67.78
.use 34124 >>|cRXP_WARN_Dive down the cliff face to the east|r
>>|cRXP_WARN_Cast|r |T132834:0|t[Scavenge] (1) |cRXP_WARN_to start collecting|r |cRXP_LOOT_Fjord Hawk Eggs|r
>>|cRXP_WARN_Cast|r |T132172:0|t[Soar] (2) |cRXP_WARN_on cooldown to move faster|r
>>|cRXP_WARN_Cast|r |T132927:0|t[Escape] (3) |cRXP_WARN_to temporarily confuse an enemy|r |cRXP_ENEMY_Hawk|r
>>|cRXP_WARN_If your |cRXP_FRIENDLY_Falcon|r dies, use the|r |T132598:0|t[Trained Rock Falcon] |cRXP_WARN_again|r
.complete 11470,1 
stepm
>>|cRXP_WARN_Exit out of the bird|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hidalgo|r and |cRXP_FRIENDLY_Walt|r
.turnin 11470 >>Turn in There Exists No Honor Among Birds
.goto HowlingFjord,75.27,64.97
.turnin 11495 >>Turn in The Delicate Sound of Thunder
.turnin 11494 >>Turn in Lightning Infused Relics
.accept 11501 >>Accept News From the East
.goto HowlingFjord,75.05,65.52
.target Walt
.target Hidalgo the Master Falconer
step
#completewith next
.goto HowlingFjord,75.05,65.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Walt|r

.vehicle >> Fly to Westguard Keep
.timer 106,News From the East RP

.skipgossip
.target Walt
step
#completewith RootC
.goto HowlingFjord,30.9,42.0,15,0
.goto HowlingFjord,30.86,41.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Celeste|r
.home >> Set your Hearthstone to Westguard Keep
.target Innkeeper Celeste Goodhutch
step
.goto HowlingFjord,31.17,40.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kettleblack|r
.accept 11155 >>Accept Shoveltusk Soup Again?
.target Chef Kettleblack
step
.goto HowlingFjord,28.84,44.13
>>|cRXP_WARN_Go to the main room of Westguard Keep|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Adams|r
.turnin 11291 >>Turn in To Westguard Keep!
.turnin 11501 >>Turn in News From the East
.accept 11157 >>Accept The Clutches of Evil
.target Captain Adams
step << skip
.goto HowlingFjord,28.9,42.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Petrov|r
.accept 11153 >>Accept Break the Blockade
.target Bombardier Petrov

step << skip
.goto HowlingFjord,20.9,48.5
.use 33098 >> Use |T133710:0|t[Petrov's Cluster Bombs] to destroy the |cRXP_ENEMY_Cannons|r and |cRXP_ENEMY_Pirates|r on the ships
.complete 11153,2 
.complete 11153,1 
.mob Blockade Captain
.mob Blockade Pirate
step << skip
.goto HowlingFjord,28.9,42.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Petrov|r
.turnin 11153 Turn in Break the Blockade
.target Bombardier Petrov
step
>>Exit the Keep
.goto HowlingFjord,31.26,43.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greer|r
.fp Westguard Keep >> Get the Westguard Keep flight path
.target Greer Orehammer
step
.goto HowlingFjord,33.98,43.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ely|r
.accept 11190 >>Accept One Size Does Not Fit All
.target Cannoneer Ely
step
#completewith next
.goto HowlingFjord,40.5,41.3,0
>>Kill |cRXP_ENEMY_Shoveltusks|r. Loot them for their |cRXP_LOOT_Meat|r
.complete 11155,1 
.mob Shoveltusk
.mob Shoveltusk Calf
.mob Shoveltusk Stag
step
#loop
.line HowlingFjord,35.78,40.45,38.89,40.27,39.95,42.16,37.70,44.50,35.74,44.74,35.33,49.67,34.54,51.57,33.48,47.74
.goto HowlingFjord,35.78,40.45,60,0
.goto HowlingFjord,38.89,40.27,60,0
.goto HowlingFjord,39.95,42.16,60,0
.goto HowlingFjord,37.70,44.50,60,0
.goto HowlingFjord,35.74,44.74,60,0
.goto HowlingFjord,35.33,49.67,60,0
.goto HowlingFjord,34.54,51.57,60,0
.goto HowlingFjord,33.48,47.74,60,0
>>Loot the |cRXP_LOOT_Westguard Cannonballs|r on the ground
.complete 11190,1 
step
#loop
.line HowlingFjord,35.78,40.45,38.89,40.27,39.95,42.16,37.70,44.50,35.74,44.74,35.33,49.67,34.54,51.57,33.48,47.74
.goto HowlingFjord,35.78,40.45,60,0
.goto HowlingFjord,38.89,40.27,60,0
.goto HowlingFjord,39.95,42.16,60,0
.goto HowlingFjord,37.70,44.50,60,0
.goto HowlingFjord,35.74,44.74,60,0
.goto HowlingFjord,35.33,49.67,60,0
.goto HowlingFjord,34.54,51.57,60,0
.goto HowlingFjord,33.48,47.74,60,0
>>Kill |cRXP_ENEMY_Shoveltusks|r. Loot them for their |cRXP_LOOT_Meat|r
.complete 11155,1 
.mob Shoveltusk
.mob Shoveltusk Calf
.mob Shoveltusk Stag
step
#completewith RootC
.goto HowlingFjord,40.6,48.5,0
>>Kill |cRXP_ENEMY_Proto Whelps|r
.complete 11157,2 
.mob Proto-Whelp
step
#completewith RootC
.goto HowlingFjord,39.1,48.2,0
>>Kill |cRXP_ENEMY_Proto-Drake Eggs|r
.complete 11157,1 
.mob Proto-Drake Egg
step
.goto HowlingFjord,36.57,48.63,-1
.goto HowlingFjord,41.16,49.41,-1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to an |cRXP_FRIENDLY_Ember Clutch Ancient|r in Ember Clutch
.accept 11182 >>Accept Root Causes
.target Ember Clutch Ancient
step
#completewith next
>>Kill |cRXP_ENEMY_Dragonflayer Handlers|r
.complete 11182,1 
.mob Dragonflayer Handler
step
>>Kill |cRXP_ENEMY_Skeld Drakeson|r inside the building
.complete 11182,2 
.goto HowlingFjord,41.46,52.34
.mob Skeld Drakeson
step
>>Kill |cRXP_ENEMY_Dragonflayer Handlers|r
.complete 11182,1 
.goto HowlingFjord,40.37,52.23,45,0
.goto HowlingFjord,41.29,53.09,45,0
.goto HowlingFjord,42.48,54.07,45,0
.goto HowlingFjord,40.37,52.23,45,0
.goto HowlingFjord,42.48,54.07
.mob Dragonflayer Handler
step
#label RootC
.goto HowlingFjord,41.16,49.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to an |cRXP_FRIENDLY_Ember Clutch Ancient|r in Ember Clutch
.turnin 11182 >>Turn in Root Causes
.target Ember Clutch Ancient
step
#completewith next
.goto HowlingFjord,40.6,48.5,0
>>Kill |cRXP_ENEMY_Proto Whelps|r
.complete 11157,2 
.mob Proto-Whelp
step
#loop
.line HowlingFjord,41.15,50.78,39.44,51.32,37.67,51.03,36.66,48.95,37.90,47.94,39.63,48.40,41.42,49.93
.goto HowlingFjord,41.15,50.78,60,0
.goto HowlingFjord,39.44,51.32,60,0
.goto HowlingFjord,37.67,51.03,60,0
.goto HowlingFjord,36.66,48.95,60,0
.goto HowlingFjord,37.90,47.94,60,0
.goto HowlingFjord,39.63,48.40,60,0
.goto HowlingFjord,41.42,49.93,60,0
>>Kill |cRXP_ENEMY_Proto-Drake Eggs|r
.complete 11157,1 
.mob Proto-Drake Egg
step
#loop
.line HowlingFjord,41.15,50.78,39.44,51.32,37.67,51.03,36.66,48.95,37.90,47.94,39.63,48.40,41.42,49.93
.goto HowlingFjord,41.15,50.78,60,0
.goto HowlingFjord,39.44,51.32,60,0
.goto HowlingFjord,37.67,51.03,60,0
.goto HowlingFjord,36.66,48.95,60,0
.goto HowlingFjord,37.90,47.94,60,0
.goto HowlingFjord,39.63,48.40,60,0
.goto HowlingFjord,41.42,49.93,60,0
>>Kill |cRXP_ENEMY_Proto Whelps|r
.complete 11157,2 
.mob Proto-Whelp
step << Druid
#completewith next
.cast 18960 >> Cast Teleport: Moonglade
.zoneskip Moonglade
.xp <69,1
step << Druid
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 26982 >> Train your class spells
.xp <69,1
.target Loganaar

step << DK
#completewith next
.cast 50977 >> Cast Death Gate
.zoneskip Eastern Plaguelands
.xp <69,1
step << DK
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49928 >> Train your class spells
.xp <69,1
.target Amal'thazad

step << Mage
#completewith next
.zone Stormwind City >> Teleport to Stormwind
.xp <69,1
step << Mage
.goto Stormwind City,49.55,85.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 27125 >> Train your class spells
.xp <69,1
.target Elsharin
.target Jennea Cannon

step
#completewith next
.hs >> Hearth to Westguard Keep
step
.goto HowlingFjord,31.17,40.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kettleblack|r
.turnin 11155 >>Turn in Shoveltusk Soup Again?
.target Chef Kettleblack
step
>>|cRXP_WARN_Go to the main room of Westguard Keep|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Adams|r and |cRXP_FRIENDLY_Malister|r
.turnin 11157 >>Turn in The Clutches of Evil
.accept 11187 >>Accept Mage-Lieutenant Malister
.goto HowlingFjord,28.84,44.13
.turnin 11187 >>Turn in Mage-Lieutenant Malister
.accept 11188 >>Accept Two Wrongs...
.goto HowlingFjord,28.94,44.19
.target Mage-Lieutenant Malister
.target Captain Adams
step
.goto HowlingFjord,33.98,43.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ely|r
.turnin 11190 >>Turn in One Size Does Not Fit All
.target Cannoneer Ely
step
#loop
.line HowlingFjord,41.15,50.78,39.44,51.32,37.67,51.03,36.66,48.95,37.90,47.94,39.63,48.40,41.42,49.93
.goto HowlingFjord,41.15,50.78,60,0
.goto HowlingFjord,39.44,51.32,60,0
.goto HowlingFjord,37.67,51.03,60,0
.goto HowlingFjord,36.66,48.95,60,0
.goto HowlingFjord,37.90,47.94,60,0
.goto HowlingFjord,39.63,48.40,60,0
.goto HowlingFjord,41.42,49.93,60,0
.use 33119 >>|cRXP_WARN_Use|r |T135463:0|t[Malister's Frost Wand] |cRXP_WARN_on |cRXP_ENEMY_Proto-Drakes|r in the air above Ember Clutch|r
>>Kill |cRXP_ENEMY_Proto-Drakes|r
.complete 11188,1 
.mob Proto-Drake
step << Shaman
#completewith next
.hs >> Hearth back to Westguard Keep
step
>>|cRXP_WARN_Go to the main room of Westguard Keep|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malister|r and |cRXP_FRIENDLY_Adams|r
.turnin 11188 >>Turn in Two Wrongs...
.goto HowlingFjord,28.94,44.19
.accept 11199 >>Accept Report to Scout Knowles
.goto HowlingFjord,28.84,44.13
.target Mage-Lieutenant Malister
.target Captain Adams
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Steelring|r and |cRXP_FRIENDLY_Abigail|r
.accept 11218 >>Accept Danger! Explosives!
.goto HowlingFjord,29.11,41.78
.accept 11224 >>Accept Send Them Packing
.goto HowlingFjord,31.62,41.50
.target Sapper Steelring
.target Explorer Abigail
step
.goto HowlingFjord,32.3,46.7
.abandon 11153 >> Abandon Break the Blockade if you picked it up
step
.goto HowlingFjord,32.27,46.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lunk|r
.accept 11573 >>Accept Orfus of Kamagua
.target Lunk-tusk
step
.goto HowlingFjord,44.47,57.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scout Knowles|r
.turnin 11199 >>Turn in Report to Scout Knowles
.accept 11202 >>Accept Mission: Eternal Flame
.target Scout Knowles
step
.use 33164 >>|cRXP_WARN_Use the|r |T135432:0|t[Ever-burning Torch] |cRXP_WARN_on |cRXP_WARN_Plague Tanks|r around the border of Halgrind|r
.complete 11202,1 
.goto HowlingFjord,48.50,55.85
.complete 11202,2 
.goto HowlingFjord,48.13,52.77
.complete 11202,3 
.goto HowlingFjord,51.17,50.27
.complete 11202,4 
.goto HowlingFjord,51.42,57.60
step
.goto HowlingFjord,44.47,57.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scout Knowles|r
.turnin 11202 >>Turn in Mission: Eternal Flame
.accept 11327 >>Accept Mission: Package Retrieval
.target Scout Knowles
step
#completewith next
.goto HowlingFjord,50.75,53.89,200 >> Travel to Halgrind
step
.goto HowlingFjord,50.75,53.89
>>Loot the |cRXP_LOOT_Apothecary's Package|r on the ground
.complete 11327,1 
step
.goto HowlingFjord,44.47,57.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scout Knowles|r
.turnin 11327 >>Turn in Mission: Package Retrieval
.accept 11328 >>Accept Mission: Forsaken Intel
.target Scout Knowles
step
.goto HowlingFjord,40.29,60.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Orfus|r
.turnin 11573 >>Turn in Orfus of Kamagua
.accept 11504 >>Accept The Dead Rise!
.target Orfus of Kamagua
step
#completewith next
.goto HowlingFjord,57.68,77.54,200 >> Travel to Shield Hill
step
#completewith next
>>Open the |cRXP_PICK_Mound of Debris|r. Loot it for |cRXP_LOOT_Fengir's Clue|r
.complete 11504,1 
.goto HowlingFjord,57.68,77.54
step
#completewith next
>>Open the |cRXP_PICK_Unlocked Chest|r. Loot it for |cRXP_LOOT_Rodin's Clue|r
.complete 11504,2 
.goto HowlingFjord,59.23,76.97
step
#completewith next
>>Open the |cRXP_PICK_Long Tail Feather|r. Loot it for |cRXP_LOOT_Isuldof's Clue|r
.complete 11504,3 
.goto HowlingFjord,59.80,79.40
step
>>Open the |cRXP_PICK_Cannonball|r. Loot it for |cRXP_LOOT_Windan's Clue|r
.complete 11504,4 
.goto HowlingFjord,61.98,80.05
step
.goto HowlingFjord,40.29,60.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Orfus|r
.turnin 11504 >>Turn in The Dead Rise!
.accept 11507 >>Accept Elder Atuik and Kamagua
.target Orfus of Kamagua
step
#completewith next
+|cRXP_WARN_If you just missed the lift|r, |T135992:0|tSlow Fall, |cRXP_WARN_then mount up and jump toward the land below|r << Mage
+|cRXP_WARN_If you just missed the lift|r, |cRXP_WARN_jump into the water and swim to the mainland of the island west of you|r << !Mage
>>|cRXP_WARN_Otherwise|r, |cRXP_WARN_wait for the lift|r. |cRXP_WARN_Take it to the island|r
.skill coldweatherflying,1,1
step
#completewith next
.goto HowlingFjord,25.02,56.96,150 >> Travel to Kamagua
step
.goto HowlingFjord,25.02,56.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Atuik|r
.turnin 11507 >>Turn in Elder Atuik and Kamagua
.accept 11508 >>Accept Grezzix Spindlesnap
.accept 11456 >>Accept Feeding the Survivors
.target Elder Atuik
step
.goto HowlingFjord,24.66,57.77
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kip|r
.fp Kamagua >> Get the Kamagua flight path
.target Kip Trawlskip
step
#completewith Eagle
.goto HowlingFjord,25.39,59.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Iqniq|r underground
.home >> Set your Hearthstone to Kamagua
.target Caregiver Iqniq
step
.goto HowlingFjord,27.38,60.93,60,0
.goto HowlingFjord,28.76,65.49,60,0
.goto HowlingFjord,29.60,69.05,60,0
.goto HowlingFjord,32.72,66.13,60,0
.goto HowlingFjord,30.77,61.94,60,0
.goto HowlingFjord,30.72,58.88,60,0
.goto HowlingFjord,28.81,58.18,60,0
.goto HowlingFjord,27.38,60.93,60,0
.goto HowlingFjord,28.76,65.49,60,0
.goto HowlingFjord,29.60,69.05,60,0
.goto HowlingFjord,32.72,66.13,60,0
.goto HowlingFjord,30.77,61.94,60,0
.goto HowlingFjord,30.72,58.88,60,0
.goto HowlingFjord,28.81,58.18
>>Kill |cRXP_ENEMY_Island Shoveltusks|r. Loot them for their |cRXP_LOOT_Meat|r
.complete 11456,1 
.mob Island Shoveltusk
step
.goto HowlingFjord,25.02,56.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Atuik|r
.turnin 11456 >>Turn in Feeding the Survivors
.accept 11457 >>Accept Arming Kamagua
.target Elder Atuik
step
.goto HowlingFjord,29.77,54.75,50,0
.goto HowlingFjord,26.1,53.4,50,0
.goto HowlingFjord,26.1,66.2,50,0
.goto HowlingFjord,26.1,68.2,50,0
.goto HowlingFjord,28.0,67.0,50,0
.goto HowlingFjord,29.4,54.8
>>Kill |cRXP_ENEMY_Frostwing Chimaeras|r. Loot them for their |cRXP_LOOT_Horns|r
.complete 11457,1 
.mob Frostwing Chimaera
step
.goto HowlingFjord,25.02,56.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Atuik|r
.turnin 11457 >>Turn in Arming Kamagua
.accept 11458 >>Accept Avenge Iskaal
.target Elder Atuik
step
.goto HowlingFjord,23.08,62.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezzix|r on the rowboat
.turnin 11508 >>Turn in Grezzix Spindlesnap
.accept 11509 >>Accept Street "Cred"
.target Grezzix Spindlesnap
step
#completewith next
.goto HowlingFjord,23.10,62.57
.vehicle >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lou|r in the rowboat. He will take you to Scalawag Point
.skipgossip
.timer 90,Street "Cred" RP
.skill coldweatherflying,1,1
.target Lou the Cabin Boy
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harry|r and |cRXP_FRIENDLY_Terry|r
.turnin 11509 >>Turn in Street "Cred"
.accept 11510 >>Accept "Scoodles"
.goto HowlingFjord,35.09,80.94
.accept 11434 >>Accept Forgotten Treasure
.goto HowlingFjord,35.60,80.22
.target "Silvermoon" Harry
.target Handsome Terry
.skill coldweatherflying,1,1
step
#completewith next
.goto HowlingFjord,35.09,80.94,150 >> Travel to Scalawag Point
.skill coldweatherflying,<1,1
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harry|r and |cRXP_FRIENDLY_Terry|r
.turnin 11509 >>Turn in Street "Cred"
.accept 11510 >>Accept "Scoodles"
.goto HowlingFjord,35.09,80.94
.accept 11434 >>Accept Forgotten Treasure
.goto HowlingFjord,35.60,80.22
.target "Silvermoon" Harry
.target Handsome Terry
.skill coldweatherflying,<1,1
step
#completewith next
.goto HowlingFjord,37.75,79.58,70 >> Travel toward |cRXP_FRIENDLY_Scuttle|r on the Ship
step
.goto HowlingFjord,37.75,79.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scuttle|r
.accept 11469 >>Accept Swabbin' Soap
.target Scuttle Frostprow
step
#completewith next
.use 34076 >>|cRXP_WARN_Use the|r |T134339:0|t[Fish Bladder] |cRXP_WARN_to give yourself|r |cRXP_WARN_3 minutes of Water Breathing|r << !Warlock !Druid
>>|cRXP_WARN_Cast|r |T136148:0|t[Unending Breath] |cRXP_WARN_on yourself|r << Warlock
>>Kill |cRXP_ENEMY_"Scoodles"|r. Loot him for the |cRXP_LOOT_Scrying Crystal|r
>>|cRXP_ENEMY_"Scoodles"|r |cRXP_WARN_is an Orca that patrols the water|r
.complete 11510,1 
.unitscan "Scoodles"
step
>>Loot the |cRXP_LOOT_Eagle Figurine|r and |cRXP_LOOT_Amani Vase|r on the the ships underwater
>>|cRXP_WARN_The |cRXP_LOOT_Eagle Figurine|r is on the second floor|r
.complete 11434,2 
.goto HowlingFjord,37.75,84.63,-1
.complete 11434,1 
.goto HowlingFjord,37.14,85.51,-1
step
#loop
.line HowlingFjord,35.80,84.66,35.66,86.12,37.53,86.30,38.93,86.15,39.57,85.79,39.46,84.50,38.33,83.70,37.41,83.83,36.07,84.75
.goto HowlingFjord,35.80,84.66,90,0
.goto HowlingFjord,35.66,86.12,90,0
.goto HowlingFjord,37.53,86.30,90,0
.goto HowlingFjord,38.93,86.15,90,0
.goto HowlingFjord,39.57,85.79,90,0
.goto HowlingFjord,39.46,84.50,90,0
.goto HowlingFjord,38.33,83.70,90,0
.goto HowlingFjord,37.41,83.83,90,0
.goto HowlingFjord,36.07,84.75,90,0
.use 34076 >>|cRXP_WARN_Use the|r |T134339:0|t[Fish Bladder] |cRXP_WARN_to give yourself|r |cRXP_WARN_3 minutes of Water Breathing|r << !Warlock !Druid
>>|cRXP_WARN_Cast|r |T136148:0|t[Unending Breath] |cRXP_WARN_on yourself|r << Warlock
>>Kill |cRXP_ENEMY_"Scoodles"|r. Loot him for the |cRXP_LOOT_Scrying Crystal|r
>>|cRXP_ENEMY_"Scoodles"|r |cRXP_WARN_is an Orca that patrols the water|r
.complete 11510,1 
.unitscan "Scoodles"
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harry|r, |cRXP_FRIENDLY_Terry|r, and |cRXP_FRIENDLY_Taruk|r
.turnin 11510 >>Turn in "Scoodles"
.accept 11511 >>Accept The Staff of Storm's Fury
.accept 11512 >>Accept The Frozen Heart of Isuldof
.accept 11519 >>Accept The Lost Shield of the Aesirites
.accept 11567 >>Accept The Ancient Armor of the Kvaldir
.goto HowlingFjord,35.09,80.94
.turnin 11434 >>Turn in Forgotten Treasure
.accept 11455 >>Accept The Fragrance of Money
.goto HowlingFjord,35.60,80.22
.accept 11464 >>Accept Gambling Debt
.goto HowlingFjord,36.33,80.48
.target "Silvermoon" Harry
.target Handsome Terry
.target Taruk
step
#completewith next
.goto HowlingFjord,35.09,80.94
.gossipoption 93516 >> Talk to |cRXP_FRIENDLY_Harry|r to turn him hostile
.skipgossip
.isOnQuest 11464
.target "Silvermoon" Harry
step
.goto HowlingFjord,35.09,80.94
>>|cRXP_WARN_Attack |cRXP_ENEMY_Harry|r down to 20% health. Do NOT kill him|r
.gossipoption 93102 >> Talk to |cRXP_FRIENDLY_Harry|r once he submits
.complete 11464,1 
.skipgossip
.isOnQuest 11464
.target "Silvermoon" Harry
step
.goto HowlingFjord,36.33,80.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Taruk|r
.turnin 11464 >>Turn in Gambling Debt
.accept 11466 >>Accept Jack Likes His Drink
.target Taruk
step
#completewith next
.goto HowlingFjord,35.3,80.2,20,0
.goto HowlingFjord,35.6,79.6,15,0
.goto HowlingFjord,35.31,79.59,10 >> Travel toward |cRXP_FRIENDLY_Olga|r inside the Inn
.isOnQuest 11466
step
#completewith next
.goto HowlingFjord,35.31,79.59
.gossipoption 93104 >> Talk to |cRXP_FRIENDLY_Olga|r. Buy |cRXP_FRIENDLY_Jack|r a drink
.skipgossip 24639,1,1
.timer 32,Jack Likes His Drink RP
.isOnQuest 11466
.target Olga, the Scalawag Wench
step
.goto HowlingFjord,35.48,79.38
>>|cRXP_WARN_Wait out the RP|r
.gossipoption 93103 >> Talk to |cRXP_FRIENDLY_Jack|r once he passes out
.complete 11466,1 
.skipgossip
.isOnQuest 11466
.target Jack Adams
step
.goto HowlingFjord,36.33,80.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Taruk|r
.turnin 11466 >>Turn in Jack Likes His Drink
.accept 11467 >>Accept Dead Man's Debt
.target Taruk
step
#completewith next
.goto HowlingFjord,36.8,77.6,60 >> Travel north out of Scalawag Point
.skill coldweatherflying,1,1
step
.goto HowlingFjord,35.40,78.20,60,0
.goto HowlingFjord,34.04,79.30,60,0
.goto HowlingFjord,33.55,82.27,60,0
.goto HowlingFjord,32.69,78.83,60,0
.goto HowlingFjord,34.25,76.36,60,0
.goto HowlingFjord,32.38,75.01,60,0
.goto HowlingFjord,35.40,78.20,60,0
.goto HowlingFjord,34.04,79.30,60,0
.goto HowlingFjord,33.55,82.27,60,0
.goto HowlingFjord,32.69,78.83,60,0
.goto HowlingFjord,34.25,76.36,60,0
.goto HowlingFjord,32.38,75.01
>>Kill |cRXP_ENEMY_Rabid Brown Bears|r. Loot them for their |cRXP_LOOT_Musk|r
.complete 11455,1 
.mob Rabid Brown Bear
step
.goto HowlingFjord,31.35,79.16,40,0
.goto HowlingFjord,31.37,78.00
>>Kill |cRXP_ENEMY_Big Roy|r in the water. Loot him for his |cRXP_LOOT_Blubber|r
.complete 11469,1 
.unitscan Big Roy
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Terry|r and |cRXP_FRIENDLY_Zeh'gehn|r
.turnin 11455 >>Turn in The Fragrance of Money
.accept 11473 >>Accept A Traitor Among Us
.goto HowlingFjord,35.60,80.22
.turnin 11473 >>Turn in A Traitor Among Us
.accept 11459 >>Accept Zeh'gehn Sez
.goto HowlingFjord,35.55,80.63
.target Handsome Terry
.target Zeh'gehn
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Terry|r
.turnin 11459 >>Turn in Zeh'gehn Sez
.accept 11476 >>Accept A Carver and a Croaker
.goto HowlingFjord,35.60,80.22
.target Handsome Terry
step
.goto HowlingFjord,35.59,81.71
>>Loot a |cRXP_LOOT_Scalawag Frog|r on the ground
.complete 11476,1 
.target Scalawag Frog
step
.goto HowlingFjord,35.09,80.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harry|r
>>Buy a |T135643:0|t[Shiny Knife] from him
.complete 11476,2 

.target "Silvermoon" Harry
step
.goto HowlingFjord,35.55,80.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zeh'gehn|r
.turnin 11476 >>Turn in A Carver and a Croaker
.timer 22,A Carver and a Croaker RP
.target Zeh'gehn
step
.goto HowlingFjord,35.55,80.63
>>|cRXP_WARN_Wait for the RP|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zeh'gehn|r
.accept 11479 >>Accept "Crowleg" Dan
.target Zeh'gehn
step
#completewith next
.goto HowlingFjord,35.95,83.60,50 >> Travel toward |cRXP_FRIENDLY_"Crowleg" Dan|r on the Ship
.isOnQuest 11479
step
#completewith next
.goto HowlingFjord,35.95,83.60
.gossipoption 93398 >> Talk to |cRXP_FRIENDLY_"Crowleg" Dan|r to turn him hostile
.timer 7,"Crowleg" Dan RP
.skipgossip
.isOnQuest 11479
.target "Crowleg" Dan
step
.goto HowlingFjord,35.95,83.60
>>|cRXP_WARN_Wait out the RP|r
>>Kill |cRXP_ENEMY_"Crowleg" Dan|r
.complete 11479,1 
.skipgossip
.mob "Crowleg" Dan
step
.goto HowlingFjord,35.60,80.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Terry|r
.turnin 11479 >>Turn in "Crowleg" Dan
.accept 11480 >>Accept Meet Number Two
.target Handsome Terry
step
.goto HowlingFjord,35.27,80.19,10,0
.goto HowlingFjord,35.57,79.58,10,0
.goto HowlingFjord,35.15,79.50,10,0
.goto HowlingFjord,35.49,79.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Annie|r on the second floor of the Inn
.turnin 11480 >>Turn in Meet Number Two
.accept 11471 >>Accept The Jig is Up
.target Annie Bonn
step
.goto HowlingFjord,37.75,79.58
>>|cRXP_WARN_Go up the plank onto the Ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Scuttle|r
.turnin 11469 >>Turn in Swabbin' Soap
.target Scuttle Frostprow
step
.goto HowlingFjord,37.86,74.77
>>|cRXP_WARN_Wait on the island for the Ship to arrive. It is a 4 minute round trip|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Captain Ellis|r on the top deck
.turnin 11519 >>Turn in The Lost Shield of the Aesirites
.accept 11527 >>Accept Mutiny on the Mercy
.skill coldweatherflying,1,1
.target Captain Ellis
step
.goto HowlingFjord,37.54,75.20,60,0
.goto HowlingFjord,34.99,74.24,60,0
.goto HowlingFjord,33.40,71.96,60,0
.goto HowlingFjord,34.89,68.13,60,0
.goto HowlingFjord,36.41,67.14,60,0
.goto HowlingFjord,37.85,68.04,60,0
.goto HowlingFjord,38.65,70.91,60,0
.goto HowlingFjord,39.20,73.29,60,0
.goto HowlingFjord,40.66,75.70,60,0
.goto HowlingFjord,41.49,76.64,60,0
.goto HowlingFjord,42.80,77.53,60,0
.goto HowlingFjord,45.76,79.84,60,0
.goto HowlingFjord,46.09,82.37,60,0
.goto HowlingFjord,43.90,83.87,60,0
.goto HowlingFjord,38.86,80.19,60,0
.goto HowlingFjord,37.98,77.29,60,0
.goto HowlingFjord,37.93,75.95,60,0
.goto HowlingFjord,37.54,75.20
.line HowlingFjord,37.54,75.20,37.93,75.95,37.98,77.29,38.86,80.19,43.90,83.87,46.09,82.37,45.76,79.84,42.80,77.53,41.49,76.64,40.66,75.70,39.20,73.29,38.65,70.91,37.85,68.04,36.41,67.14,34.89,68.13,33.40,71.96,34.99,74.24,37.54,75.20
>>|cRXP_WARN_Fly onto the moving Ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Captain Ellis|r on the top deck
.turnin 11519 >>Turn in The Lost Shield of the Aesirites
.accept 11527 >>Accept Mutiny on the Mercy
.skill coldweatherflying,<1,1
.target Captain Ellis
step
>>|cRXP_WARN_Go down onto the bottom floor of the Ship|r
>>Kill |cRXP_ENEMY_Mutinous Sea Dogs|r. Loot them for their |cRXP_LOOT_Blasting Powder|r
.complete 11527,1 
.mob Mutinous Sea Dog
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Captain Ellis|r on the top deck
.turnin 11527 >>Turn in Mutiny on the Mercy
.accept 11529 >>Accept Sorlof's Booty
.target Captain Ellis
step
>>|cRXP_WARN_Move toward |cRXP_FRIENDLY_The Big Gun|r located at the front end on the top deck of the Ship|r
>>|cRXP_WARN_Wait for the Ship to approach |cRXP_ENEMY_Sorlof|r near the shoreline|r
>>|cRXP_WARN_Click |cRXP_FRIENDLY_The Big Gun|r multiple times to deal heavy damage to|r |cRXP_ENEMY_Sorlof|r
>>Kill |cRXP_ENEMY_Sorlof|r. Loot |cRXP_LOOT_Sorlof's Booty|r on the ground
.complete 11529,1 
.unitscan Sorlof
.target The Big Gun
step
.goto HowlingFjord,37.54,75.20,60,0
.goto HowlingFjord,34.99,74.24,60,0
.goto HowlingFjord,33.40,71.96,60,0
.goto HowlingFjord,34.89,68.13,60,0
.goto HowlingFjord,36.41,67.14,60,0
.goto HowlingFjord,37.85,68.04,60,0
.goto HowlingFjord,38.65,70.91,60,0
.goto HowlingFjord,39.20,73.29,60,0
.goto HowlingFjord,40.66,75.70,60,0
.goto HowlingFjord,41.49,76.64,60,0
.goto HowlingFjord,42.80,77.53,60,0
.goto HowlingFjord,45.76,79.84,60,0
.goto HowlingFjord,46.09,82.37,60,0
.goto HowlingFjord,43.90,83.87,60,0
.goto HowlingFjord,38.86,80.19,60,0
.goto HowlingFjord,37.98,77.29,60,0
.goto HowlingFjord,37.93,75.95,60,0
.goto HowlingFjord,37.54,75.20
.line HowlingFjord,37.54,75.20,37.93,75.95,37.98,77.29,38.86,80.19,43.90,83.87,46.09,82.37,45.76,79.84,42.80,77.53,41.49,76.64,40.66,75.70,39.20,73.29,38.65,70.91,37.85,68.04,36.41,67.14,34.89,68.13,33.40,71.96,34.99,74.24,37.54,75.20
>>|cRXP_WARN_Fly onto the moving Ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Captain Ellis|r on the top deck
.turnin 11529 >>Turn in Sorlof's Booty
.accept 11530 >>Accept The Shield of the Aesirites
.skill coldweatherflying,<1,1
.target Captain Ellis
step
#completewith next
.goto HowlingFjord,34.02,64.24,100 >> Travel to Iskaal
>>|cRXP_WARN_Cast |T135863:0|t[Water Walking] to cross the Ocean|r << Shaman
>>|cRXP_WARN_Cast |T237528:0|t[Path of Frost] to cross the Ocean|r << DK
.skill coldweatherflying,1,1
step << skip 
#completewith next
.cast 47455 >>|cRXP_WARN_Use the|r |T134229:0|t[Horn of Kamagua] |cRXP_WARN_to summon a |cRXP_FRIENDLY_Tuskarr|r to increase your damage|r
.use 36777
.skill coldweatherflying,1,1
step
#loop
.line HowlingFjord,34.59,63.39,33.91,64.27,33.59,63.13,34.24,62.22
.goto HowlingFjord,34.59,63.39,55,0
.goto HowlingFjord,33.91,64.27,55,0
.goto HowlingFjord,33.59,63.13,55,0
.goto HowlingFjord,34.24,62.22,55,0
>>Kill |cRXP_ENEMY_Crazed Northsea Slavers|r
.complete 11458,1 
.mob Crazed Northsea Slaver
.skill coldweatherflying,1,1
step
#completewith next
.goto HowlingFjord,34.94,63.68,20,0
.goto HowlingFjord,35.37,64.74,12,0
.goto HowlingFjord,35.46,63.78,9 >> Run onto the Ship and go to the bottom level << !Shaman !DK
.goto HowlingFjord,35.46,63.78,9 >> Run onto the Ship and go to the bottom level << Shaman/DK
>>|cRXP_WARN_Avoid |cRXP_ENEMY_Abdul|r. He patrols the top deck|r
.unitscan Abdul the Insane
.skill coldweatherflying,1,1
step
.goto HowlingFjord,35.27,64.84
>>Loot |cRXP_LOOT_The Staff of Storm's Fury|r on the bottom level
.complete 11511,1 
.unitscan Abdul the Insane
.skill coldweatherflying,1,1
step
#completewith next
.goto HowlingFjord,35.37,64.74,12,0
.goto HowlingFjord,35.46,63.78,9 >> Travel to Iskaal. Fly onto the Ship. Go to the bottom level
>>|cRXP_WARN_Avoid |cRXP_ENEMY_Abdul|r. He patrols the top deck of the Ship|r
.skill coldweatherflying,<1,1
.unitscan Abdul the Insane
step
.goto HowlingFjord,35.27,64.84
>>Loot |cRXP_LOOT_The Staff of Storm's Fury|r on the bottom level
.complete 11511,1 
.skill coldweatherflying,<1,1
.unitscan Abdul the Insane
step << skip 
#completewith next
.cast 47455 >>|cRXP_WARN_Use the|r |T134229:0|t[Horn of Kamagua] |cRXP_WARN_to summon a |cRXP_FRIENDLY_Tuskarr|r to increase your damage|r
.use 36777
.skill coldweatherflying,<1,1
step
#loop
.line HowlingFjord,34.59,63.39,33.91,64.27,33.59,63.13,34.24,62.22
.goto HowlingFjord,34.59,63.39,55,0
.goto HowlingFjord,33.91,64.27,55,0
.goto HowlingFjord,33.59,63.13,55,0
.goto HowlingFjord,34.24,62.22,55,0
>>Kill |cRXP_ENEMY_Crazed Northsea Slavers|r
.complete 11458,1 
.mob Crazed Northsea Slaver
.skill coldweatherflying,<1,1
step
#completewith next
.goto HowlingFjord,29.26,60.70,30 >>Travel across the bridge above you
.skill coldweatherflying,1,1
step
.goto HowlingFjord,32.70,60.21
>>|cRXP_WARN_Click the |cRXP_PICK_Dirt Mound|r on the ground. |cRXP_ENEMY_Black Conrad's Ghost|r and 2 |cRXP_ENEMY_Spectral Sailors|r will spawn|r
>>Kill |cRXP_ENEMY_Black Conrad's Ghost|r. Loot him for his |cRXP_LOOT_Treasure|r
.complete 11467,1 
.mob Black Conrad's Ghost
step
#completewith next
.hs >> Hearth to Kamagua
step
.goto HowlingFjord,25.02,56.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Atuik|r
.turnin 11458 >>Turn in Avenge Iskaal
.target Elder Atuik
step << skip
.goto HowlingFjord,24.59,58.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anuniaq|r
.daily 11472 >>Accept The Way to His Heart...
.accept 12118 >>Accept Travel to Moa'ki Harbor
.target Anuniaq
step << skip
.goto HowlingFjord,29.6,73.8
.use 40946 >>Collect 8 |cRXP_PICK_Reef Fish|r by using |T134325:0|t[Anuniaq's Net] on the |cRXP_WARN_Reef Fish|r schools , or by killing |cRXP_ENEMY_Great Reef Sharks|r
.collect 34127,8 
.mob Great Reef Shark
step << skip
.goto HowlingFjord,31.2,74.8,30,0
.goto HowlingFjord,30.96,71.85
.use 34127 >>Throw the |T133895:0|t[Tasty Reef Fish] at max range at a |cRXP_ENEMY_Reef Bull|r, it'll now go to where you stand
>>|cRXP_WARN_Lead it on top of a Reef Cow on the other side of the coastline|r
>>|cRXP_WARN_If you run out of|r |T133895:0|t[Tasty Reef Fish] |cRXP_WARN_get 7-8 more and try again|r
.complete 11472,1 
.target Reef Bull
.target Reef Cow
step << skip
#completewith Armor
.destroy 34127 >> Destroy any remaining |T133895:0|t[Tasty Reef Fish]. They are no longer needed
step
#completewith next
.goto HowlingFjord,33.61,75.92,20,0
.goto HowlingFjord,33.80,78.01,30,0
.goto HowlingFjord,33.57,78.18,12 >> Enter Garvan's Reef Cave
step
.goto HowlingFjord,33.44,78.19
>>Kill |cRXP_ENEMY_"Mad" Jonah Sterling|r
>>|cRXP_WARN_Do not use any major cooldowns on |cRXP_ENEMY_"Mad" Jonah Sterling|r. You will need them afterwards for|r |cRXP_ENEMY_Hozzer|r
>>|cRXP_WARN_Drop down through the window after killing|r |cRXP_ENEMY_"Mad" Jonah Sterling|r
>>Kill |cRXP_ENEMY_Hozzer|r. Loot him for the |cRXP_LOOT_Spyglass|r. |cRXP_WARN_Use all your cooldowns here|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group if needed. Skip this step if you're unable to find a group or solo it|r
.complete 11471,1 
.mob "Mad" Jonah Sterling
.mob Hozzer
step
.goto HowlingFjord,32.34,78.67
>>|cRXP_WARN_Run to the end of Garvan's Reef Cave|r
>>Loot the |cRXP_LOOT_The Frozen Heart of Isuldof|r on the ground
.complete 11512,1 
step
#completewith next
.goto HowlingFjord,33.6,75.6,30 >> |cRXP_WARN_Take the shortcut by wall jumping on the side of the cave|r. |cRXP_WARN_This is highly optional but will save you about 20s|r
.link https://www.youtube.com/watch?v=QbvHRC0nIds >> |cRXP_WARN_CLICK HERE|r
step
#completewith next
.goto HowlingFjord,33.6,75.8,20,0
.goto HowlingFjord,36.33,80.48,100 >> Travel to Scalawag Point
step
.goto HowlingFjord,36.33,80.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Taruk|r
.turnin 11467 >>Turn in Dead Man's Debt
.target Taruk
step
.goto HowlingFjord,35.27,80.19,10,0
.goto HowlingFjord,35.57,79.58,10,0
.goto HowlingFjord,35.15,79.50,10,0
.goto HowlingFjord,35.49,79.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Annie|r on the second floor of the Inn
.turnin 11471 >>Turn in The Jig is Up
.isQuestComplete 11471
.target Annie Bonn
step
#completewith next
.goto HowlingFjord,36.09,81.60
.vehicle >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alanya|r
.timer 90,The Ancient Armor of the Kvaldir RP
.skipgossip
.target Alanya

step
#label Armor
.goto HowlingFjord,82.33,74.81,12,0
.goto HowlingFjord,81.77,73.91
>>|cRXP_WARN_Travel onto the Ship. Go to the bottom level|r
>>Loot the |cRXP_LOOT_The Ancient Armor of the Kvaldir|r on the bottom level
.complete 11567,1 
step
#completewith next
#label Alanya2
.goto HowlingFjord,80.87,75.11
.vehicle >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harry's Bomber|r
.timer 65,The Ancient Armor of the Kvaldir RP
.skipgossip
.target Harry's Bomber

step
.goto HowlingFjord,37.86,74.77
>>|cRXP_WARN_Wait on the island for the Ship to arrive. It is a 4 minute round trip|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Captain Ellis|r on the top deck
.turnin 11529 >>Turn in Sorlof's Booty
.accept 11530 >>Accept The Shield of the Aesirites
.skill coldweatherflying,1,1
.target Captain Ellis
step
#completewith next
.goto HowlingFjord,42.07,67.72,15 >> Travel to the Westwind Lift. Take it to the top
.skill coldweatherflying,1,1
step
.goto HowlingFjord,40.29,60.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Orfus|r
.turnin 11511 >>Turn in The Staff of Storm's Fury
.turnin 11567 >>Turn in The Ancient Armor of the Kvaldir
.turnin 11530 >>Turn in The Shield of the Aesirites
.turnin 11512 >>Turn in The Frozen Heart of Isuldof
.accept 11568 >>Accept A Return to Resting
.target Orfus of Kamagua
step
#completewith next
.goto HowlingFjord,57.68,77.54,200 >> Travel to Shield Hill
step
#completewith next
.use 34624 >>|cRXP_WARN_Use the|r |T133667:0|t[Bundle of Vrykul Artifacts] |cRXP_WARN_while next to|r |cRXP_ENEMY_Fengir the Disgraced|r
.complete 11568,1 
.goto HowlingFjord,57.68,77.54
step
#completewith next
.use 34624 >>|cRXP_WARN_Use the|r |T133667:0|t[Bundle of Vrykul Artifacts] |cRXP_WARN_while next to|r |cRXP_ENEMY_Rodin the Reckless|r
.complete 11568,2 
.goto HowlingFjord,59.23,76.97
step
#completewith next
.use 34624 >>|cRXP_WARN_Use the|r |T133667:0|t[Bundle of Vrykul Artifacts] |cRXP_WARN_while next to|r |cRXP_ENEMY_Isuldorf Iceheart|r
.complete 11568,3 
.goto HowlingFjord,59.80,79.40
step
.use 34624 >>|cRXP_WARN_Use the|r |T133667:0|t[Bundle of Vrykul Artifacts] |cRXP_WARN_while next to|r |cRXP_ENEMY_Windan of the Kvaldir|r
.complete 11568,4 
.goto HowlingFjord,61.98,80.05
step
.goto HowlingFjord,40.29,60.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Orfus|r
.turnin 11568 >>Turn in A Return to Resting
.accept 11572 >>Accept Return to Atuik
.target Orfus of Kamagua
step
#completewith next
+|cRXP_WARN_If you just missed the lift,|r |T135992:0|t[Slow Fall]|cRXP_WARN_, then mount up and jump toward the land below|r << Mage
+|cRXP_WARN_If you just missed the lift, jump into the water and swim to Kamagua|r << !Mage
>>|cRXP_WARN_Otherwise, wait for the lift. Take it to the island|r
.skill coldweatherflying,1,1
step
#completewith next
.goto HowlingFjord,25.02,56.96,250 >> Travel to Kamagua
step << skip
.goto HowlingFjord,24.59,58.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anuniaq|r
.turnin 11472 >>Turn in The Way to His Heart...
.isQuestComplete 11472
.target Anuniaq
step
.goto HowlingFjord,25.02,56.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Atuik|r
.turnin 11572 >>Turn in Return to Atuik
.target Elder Atuik
step
#completewith next
.goto HowlingFjord,24.66,57.77
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kip|r
.fly Westguard Keep >> Fly to Westguard Keep
.target Kip Trawlskip
step
.goto HowlingFjord,30.9,42.0,15,0
.goto HowlingFjord,30.77,41.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Peppy|r in the Inn
.turnin 11328 >>Turn in Mission: Forsaken Intel
.accept 11330 >>Accept Absholutely... Thish Will Work!
.target Peppy Wrongnozzle
step
#completewith next
.goto HowlingFjord,29.36,44.05,15,0
.goto HowlingFjord,29.46,43.39,10 >> Enter Westguard Keep. Open the Gate and go downstairs into the Jail
step
.goto HowlingFjord,29.46,43.39
.use 33627 >>|cRXP_WARN_Use|r |T134799:0|t[Peppy's Special Mix] |cRXP_WARN_on the|r |cRXP_ENEMY_Dragonflayer Vrykul Prisoner|r
.complete 11330,1 
.mob Dragonflayer Vrykul Prisoner
step
#completewith Rotgill
.goto HowlingFjord,30.9,42.0,15,0
.goto HowlingFjord,30.86,41.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Celeste|r
.home >> Set your Hearthstone to Westguard Keep
.target Innkeeper Celeste Goodhutch
step
.goto HowlingFjord,30.77,41.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Peppy|r
.turnin 11330 >>Turn in Absholutely... Thish Will Work!
.accept 11331 >>Accept You Tell Him ...Hic!
.target Peppy Wrongnozzle
step
>>|cRXP_WARN_Go to the main room of Westguard Keep|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Adams|r and |cRXP_FRIENDLY_Malister|r
.goto HowlingFjord,28.84,44.13
.turnin 11331 >>Turn in You Tell Him ...Hic!
.accept 11332 >>Accept Mission: Plague This!
.target Captain Adams
.target Mage-Lieutenant Malister
step
#completewith next
.goto HowlingFjord,31.26,43.97
.gossipoption 93430 >> Talk to |cRXP_FRIENDLY_Greer|r. He will send you on the bombing run
.skipgossip
.target Greer Orehammer
.isOnQuest 11332

step
.goto HowlingFjord,51.2,68.5,-1
.goto HowlingFjord,52.4,68.2,-1
.goto HowlingFjord,53.1,66.7,-1
.goto HowlingFjord,53.9,68.1,-1
.goto HowlingFjord,52.8,65.6,-1
.use 33634 >>|cRXP_WARN_Use|r |T133717:0|t[Orehammer's Precision Bombs] |cRXP_WARN_on the |cRXP_PICK_Green Plague Tanks|r in New Agamand|r
.complete 11332,1 
step
.goto HowlingFjord,28.84,44.13
>>|cRXP_WARN_Go to the main room of Westguard Keep|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Adams|r
.turnin 11332 >>Turn in Mission: Plague This!
.accept 11248 >>Accept Operation: Skornful Wrath
.target Captain Adams
step
#sticky
.destroy 33634 >> Destroy |T133717:0|t[Orehammer's Precision Bombs]. They are no longer needed
step
.goto HowlingFjord,30.63,42.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brevin|r
.accept 11406 >>Accept Everything Must Be Ready
.target Quartermaster Brevin
step
#completewith next
.groundgoto HowlingFjord,32.13,38.62,50,0
.goto HowlingFjord,30.05,28.58,150 >> Travel to Steel Gate
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Moonleaf|r, |cRXP_FRIENDLY_Feknut|r, and |cRXP_FRIENDLY_Irena|r
.accept 11322 >>Accept The Cleansing
.goto HowlingFjord,30.05,28.58
.accept 11154 >>Accept Scare the Guano Out of Them!
.goto HowlingFjord,30.15,28.69
.accept 11393 >>Accept Where is Explorer Jaren?
.accept 11176 >>Accept See to the Operations
.goto HowlingFjord,30.28,28.64
.target Watcher Moonleaf
.target Engineer Feknut
.target Overseer Irena Stonemantle
step
.goto HowlingFjord,30.81,28.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Chief|r
.turnin 11176 >>Turn in See to the Operations
.accept 11390 >>Accept I've Got a Flying Machine!
.target Steel Gate Chief Archaeologist
step
#completewith next
.goto HowlingFjord,30.88,28.18
.vehicle >> |cRXP_WARN_Enter the|r |cRXP_FRIENDLY_Steel Gate Flying Machine|r
.target Steel Gate Flying Machine
step

.waypoint HowlingFjord,30.9,25.7,0,rescue,VEHICLE_PASSENGERS_CHANGED,VEHICLE_UPDATE

.goto HowlingFjord,30.75,27.76 
>>|cRXP_WARN_Cast|r |T135623:0|t[Grappling Hook] (1) |cRXP_WARN_on |cRXP_PICK_Sacks of Relics|r on the ground below|r
>>|cRXP_WARN_Return the |cRXP_PICK_Sacks of Relics|r onto the platforms held by the cranes above by landing on them. The platforms have a red arrow marking the dropoff location
>>|cRXP_WARN_Repeat this process 3 times|r
.complete 11390,1 
step
>>|cRXP_WARN_Exit the|r |cRXP_FRIENDLY_Steel Gate Flying Machine|r
.goto HowlingFjord,30.81,28.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Chief|r
.turnin 11390 >>Turn in I've Got a Flying Machine!
.daily 11391 >>Accept Steel Gate Patrol
.target Steel Gate Chief Archaeologist
step
#completewith next
.goto HowlingFjord,30.88,28.18
.vehicle >> |cRXP_WARN_Enter the|r |cRXP_FRIENDLY_Steel Gate Flying Machine|r
.target Steel Gate Flying Machine
step
.goto HowlingFjord,31.20,26.53
>>|cRXP_WARN_Wait for the Gargoyle Attack to start|r
>>Kill |cRXP_ENEMY_Gjalerbron Gargoyles|r
>>|cRXP_WARN_Cast|r |T134273:0|t[Rockets] (2) |cRXP_WARN_to instantly kill|r |cRXP_ENEMY_Gjalerbron Gargoyles|r
>>|cRXP_WARN_Cast|r |T132383:0|t[Machine Gun] (1) |cRXP_WARN_on |cRXP_ENEMY_Gjalerbron Gargoyles|r when|r |T134273:0|t[Rockets] |cRXP_WARN_are on cooldown|r
>>|cRXP_WARN_Cast|r |T135788:0|t[Boosters] (4) |cRXP_WARN_to fly around faster|r
.complete 11391,1 
.isOnQuest 11391
.mob Gjalerbron Gargoyle
step
.goto HowlingFjord,30.81,28.56
>>|cRXP_WARN_Exit the|r |cRXP_FRIENDLY_Steel Gate Flying Machine|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Chief|r
.turnin 11391 >>Turn in Steel Gate Patrol
.isQuestComplete 11391
.target Steel Gate Chief Archaeologist
step
#completewith next
.groundgoto HowlingFjord,33.8,33.8,50,0
.groundgoto HowlingFjord,33.7,36.4,60,0
.goto HowlingFjord,31.0,36.5,60 >> Travel to Whisper Gulch
step
#completewith next
.goto HowlingFjord,33.5,38.9,0
>>|cRXP_WARN_Target the |cRXP_FRIENDLY_Abandoned Pack Mules|r of Whisper Gulch when you're within 15 yards to automatically /raise at them|r
.complete 11224,1 
.emote raise,23977
.target Abandoned Pack Mule
step
.goto HowlingFjord,31.0,36.5,60,0
.goto HowlingFjord,32.00,33.39,60,0
.goto HowlingFjord,31.0,36.5,60,0
.goto HowlingFjord,33.63,36.61,60,0
.goto HowlingFjord,36.02,36.65,60,0
.goto HowlingFjord,31.0,36.5,60,0
.goto HowlingFjord,32.00,33.39,60,0
.goto HowlingFjord,31.0,36.5
.use 33190 >>|cRXP_WARN_Use|r |T133711:0|t[Steelring's Foolproof Dynamite] |cRXP_WARN_on the |cRXP_PICK_Ore Veins|r scattered throughout|r |cRXP_WARN_Whisper Gulch|r
>>Loot the |cRXP_LOOT_Whisper Gulch Gems|r and |cRXP_LOOT_Whisper Gulch Ore Fragments|r that spawn on the ground after
.complete 11218,1 
.complete 11218,2 
step
.goto HowlingFjord,31.0,36.5,60,0
.goto HowlingFjord,32.00,33.39,60,0
.goto HowlingFjord,31.0,36.5,60,0
.goto HowlingFjord,33.63,36.61,60,0
.goto HowlingFjord,36.02,36.65,60,0
.goto HowlingFjord,31.0,36.5,60,0
.goto HowlingFjord,32.00,33.39,60,0
.goto HowlingFjord,31.0,36.5
>>|cRXP_WARN_Target the |cRXP_FRIENDLY_Abandoned Pack Mules|r of Whisper Gulch when you're within 15 yards to automatically /raise at them|r
.complete 11224,1 
.emote raise,23977
.target Abandoned Pack Mule
step
#completewith next
.goto HowlingFjord,24.24,32.46,150 >> Travel to Chillmere Coast
.skill coldweatherflying,<1,1
step
.goto HowlingFjord,24.25,32.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jaren|r
.turnin 11393 >>Turn in Where is Explorer Jaren?
.accept 11394 >>Accept And You Thought Murlocs Smelled Bad!
.target Explorer Jaren
.skill coldweatherflying,<1,1
step
#completewith next
.goto HowlingFjord,24.24,32.46,150 >> Carefully drop down the cliff. Travel to Chillmere Coast
.skill coldweatherflying,1,1
step
.goto HowlingFjord,24.25,32.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jaren|r
.turnin 11393 >>Turn in Where is Explorer Jaren?
.accept 11394 >>Accept And You Thought Murlocs Smelled Bad!
.target Explorer Jaren
.skill coldweatherflying,1,1
step
#completewith next
.goto HowlingFjord,21.85,24.21,0
>>Kill |cRXP_ENEMY_Necrotechs|r, |cRXP_ENEMY_Servitor Shades|r, |cRXP_ENEMY_Unstable Mur'ghouls|r, |cRXP_ENEMY_Mur'ghoul Flesheaters|r and |cRXP_ENEMY_Mur'ghoul Corrupters|r
.complete 11394,1 
.mob Unstable Mur'ghoul
.mob Mur'ghoul Flesheater
.mob Servitor Shade
.mob Necrotech
.mob Rotgill
.mob Mur'ghoul Corrupter
step
.goto HowlingFjord,22.71,31.13,45,0
.goto HowlingFjord,22.08,31.85,45,0
.goto HowlingFjord,21.85,28.22,45,0
.goto HowlingFjord,20.64,28.60,45,0
.goto HowlingFjord,22.08,31.85,45,0
.goto HowlingFjord,22.71,31.13,45,0
.goto HowlingFjord,21.85,28.22
.use 33961 >>Kill |cRXP_ENEMY_Necrotechs|r, |cRXP_ENEMY_Servitor Shades|r, |cRXP_ENEMY_Unstable Mur'ghouls|r, |cRXP_ENEMY_Mur'ghoul Flesheaters|r and |cRXP_ENEMY_Mur'ghoul Corrupters|r. Loot them for the |T135483:0|t[|cRXP_LOOT_Scourge Device|r]
>>|cRXP_WARN_Use the |T135483:0|t[|cRXP_LOOT_Scourge Device|r] to start the quest|r
.collect 33961,1,11395 
.accept 11395 >>Accept It's a Scourge Device
.mob Servitor Shade
.mob Necrotech
.mob Unstable Mur'ghoul
.mob Mur'ghoul Flesheater
.mob Mur'ghoul Corrupter
step
#completewith MoreScourge
.goto HowlingFjord,24.25,32.46,55 >> Travel toward |cRXP_FRIENDLY_Jaren|r
step
.goto HowlingFjord,24.25,32.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jaren|r
.turnin 11395 >>Turn in It's a Scourge Device
.turnin 11394 >>Turn in And You Thought Murlocs Smelled Bad!
.accept 11396 >>Accept Bring Down Those Shields
.isQuestComplete 11394
.target Explorer Jaren
step
#label MoreScourge
.goto HowlingFjord,24.25,32.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jaren|r
.turnin 11395 >>Turn in It's a Scourge Device
.accept 11396 >>Accept Bring Down Those Shields
.target Explorer Jaren
step
#completewith Rotgill
.goto HowlingFjord,21.8,24.2
>>Kill |cRXP_ENEMY_Necrotechs|r, |cRXP_ENEMY_Servitor Shades|r, |cRXP_ENEMY_Unstable Mur'ghouls|r, |cRXP_ENEMY_Mur'ghoul Flesheaters|r and |cRXP_ENEMY_Mur'ghoul Corrupters|r
.complete 11394,1 
.mob Unstable Mur'ghoul
.mob Mur'ghoul Flesheater
.mob Servitor Shade
.mob Necrotech
.mob Mur'ghoul Corrupter
step
.goto HowlingFjord,22.69,31.15,20,0
.goto HowlingFjord,21.92,28.75,20,0
.goto HowlingFjord,21.51,24.61,20,0
.goto HowlingFjord,21.75,22.46
.use 33960 >>|cRXP_WARN_Channel the|r |T135483:0|t[Scourging Crystal Controller] |cRXP_WARN_on|r |cRXP_ENEMY_Scourging Crystals|r
>>Kill |cRXP_ENEMY_Scourging Crystals|r once they activate|r
>>|cRXP_WARN_Ensure you are the one to kill it and not your pet as you won't get credit if you pet kills it|r << Warlock/DK/Hunter
.complete 11396,1 
.mob Scourging Crystal
step
.goto HowlingFjord,19.78,22.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Old Icefin|r
.accept 11422 >>Accept Trident of the Son
.target Old Icefin
step
#label Rotgill
.goto HowlingFjord,24.9,36.2,70,0
.goto HowlingFjord,22.4,32.9,70,0
.goto HowlingFjord,24.9,36.2
>>Kill |cRXP_ENEMY_Rotgill|r. Loot him for his |cRXP_LOOT_Trident|r
.complete 11422,1 
.unitscan Rotgill
step
.goto HowlingFjord,22.9,30.7
>>Kill |cRXP_ENEMY_Necrotechs|r, |cRXP_ENEMY_Servitor Shades|r, |cRXP_ENEMY_Unstable Mur'ghouls|r, |cRXP_ENEMY_Mur'ghoul Flesheaters|r and |cRXP_ENEMY_Mur'ghoul Corrupters|r
.complete 11394,1 
.mob Unstable Mur'ghoul
.mob Mur'ghoul Flesheater
.mob Servitor Shade
.mob Necrotech
.mob Rotgill
.mob Mur'ghoul Corrupter
step
.goto HowlingFjord,24.25,32.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jaren|r
.turnin 11396 >>Turn in Bring Down Those Shields
.turnin 11394 >>Turn in And You Thought Murlocs Smelled Bad!
.target Explorer Jaren
step
.goto HowlingFjord,19.78,22.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Old Icefin|r
.turnin 11422 >>Turn in Trident of the Son
.target Old Icefin
step << Druid
#completewith next
.cast 18960 >> Cast Teleport: Moonglade
.zoneskip Moonglade
.xp <70,1
step << Druid
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 26990 >> Train your class spells
.xp <70,1
.target Loganaar
step << DK
#completewith next
.cast 50977 >> Cast Death Gate
.zoneskip Eastern Plaguelands
.xp <70,1
step << DK
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 45463 >> Train your class spells
.xp <70,1
.target Amal'thazad
step << Mage
#completewith next
.zone Stormwind City >> Teleport to Stormwind
.xp <70,1
step << Mage
.goto Stormwind City,49.55,85.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 27126 >> Train your class spells
.xp <70,1
.target Elsharin
.target Jennea Cannon
step
#completewith next
.goto HowlingFjord,31.6,41.5
.hs >> Hearth to Westguard Keep
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Steelring|r and |cRXP_FRIENDLY_Abigail|r
.turnin 11218 >>Turn in Danger! Explosives!
.accept 11240 >>Accept Leader of the Deranged
.goto HowlingFjord,29.11,41.78
.turnin 11224 >>Turn in Send Them Packing
.goto HowlingFjord,31.62,41.50
.target Explorer Abigail
.target Sapper Steelring
step
#completewith next
.goto HowlingFjord,60.27,18.69,100 >> Travel to Fort Wildervar
step
.goto HowlingFjord,60.27,18.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Christopher|r
.accept 11329 >>Accept I'll Try Anything!

.target Christopher Sloan
step
#loop
.line HowlingFjord,60.72,19.11,62.64,19.75,64.57,21.43,66.27,21.66,67.69,20.05,65.84,18.98,63.99,18.14
.goto HowlingFjord,60.72,19.11,60,0
.goto HowlingFjord,62.64,19.75,60,0
.goto HowlingFjord,64.57,21.43,60,0
.goto HowlingFjord,66.27,21.66,60,0
.goto HowlingFjord,67.69,20.05,60,0
.goto HowlingFjord,65.84,18.98,60,0
.goto HowlingFjord,63.99,18.14,60,0
>>|cRXP_WARN_Open the |cRXP_PICK_Water Plants|r at Caldemere Lake. There is a 30% chance a |cRXP_ENEMY_Northern Barbfish|r will spawn|r
>>Kill |cRXP_ENEMY_Northern Barbfish|r. Loot the |cRXP_LOOT_Northern Barbfish|r
.complete 11329,1 
.mob Northern Barbfish

step
.goto HowlingFjord,60.27,18.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Christopher|r
.turnin 11329 >>Turn in I'll Try Anything!
.accept 11410 >>Accept The One That Got Away
.target Christopher Sloan
step << Shaman
.goto HowlingFjord,60.05,16.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_James|r
.fp Fort Wildervar >> Get the Fort Wildervar Flight Path
.target James Ormsby
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Colbey|r, |cRXP_FRIENDLY_Maeve|r, |cRXP_FRIENDLY_Belvar|r, |cRXP_FRIENDLY_Aderan|r, |cRXP_FRIENDLY_Gil|r, and |cRXP_FRIENDLY_Jethan|r
.accept 11284 >>Accept The Yeti Next Door
.goto HowlingFjord,60.18,15.61
.accept 11302 >>Accept The Enigmatic Frost Nymphs
.goto HowlingFjord,61.83,17.20
.accept 11346 >>Accept The Book of Runes
.goto HowlingFjord,62.28,17.22
.accept 11355 >>Accept March of the Giants
.goto HowlingFjord,62.58,16.52
.turnin 11406 >>Turn in Everything Must Be Ready
.accept 11269 >>Accept Down to the Wire
.goto HowlingFjord,62.60,16.82
.accept 11292 >>Accept Preying Upon the Weak
.goto HowlingFjord,62.66,16.80
.target Foreman Colbey
.target Lieutenant Maeve
.target Prospector Belvar
.target Researcher Aderan
.target Gil Grisert
.target Trapper Jethan
step
#completewith next
.goto HowlingFjord,63.96,19.57,75 >> Travel to the center of Caldemere Lake
step
.goto HowlingFjord,63.96,19.57
>>|cRXP_WARN_Use the|r |T134030:0|t[Fresh Barbfish Bait] |cRXP_WARN_near the Sunken Boat underwater at the center of Caldemere Lake to summon|r |cRXP_ENEMY_Frostfin|r
>>Kill |cRXP_ENEMY_Frostfin|r
.use 34013
.complete 11410,1 
.mob Frostfin
step
#completewith Witherleaf
.goto HowlingFjord,56.0,27.4,0
>>Loot the |cRXP_LOOT_Spotted Hippogryph Down|r on the ground
>>|cRXP_WARN_They look like Hippogryph Feathers|r
.complete 11269,1 
step
.goto HowlingFjord,67.61,23.75,50,0
.goto HowlingFjord,69.87,21.91,50,0
.goto HowlingFjord,70.31,24.20,50,0
.goto HowlingFjord,70.84,22.81,50,0
.goto HowlingFjord,72.00,23.04
>>Kill |cRXP_ENEMY_Iron Rune Binders|r and |cRXP_ENEMY_Iron Rune Stonecallers|r. Loot them for their |T134937:0|t[|cRXP_LOOT_Book of Runes - Chapter 1|r], |T134938:0|t[|cRXP_LOOT_Book of Runes - Chapter 2|r] and |T134943:0|t[|cRXP_LOOT_Book of Runes - Chapter 3|r]
.collect 33778,1,11346,1 
.collect 33779,1,11346,1 
.collect 33780,1,11346,1 
.mob Iron Rune Binder
.mob Iron Rune Stonecaller
step
.goto HowlingFjord,61.49,22.86
>>|cRXP_WARN_Use the|r |T134937:0|t[|cRXP_LOOT_Book of Runes - Chapter 1|r]|cRXP_WARN_,|r |T134938:0|t[|cRXP_LOOT_Book of Runes - Chapter 2|r] |cRXP_WARN_or|r |T134943:0|t[|cRXP_LOOT_Book of Runes - Chapter 3|r] |cRXP_WARN_to combine them into|r |cRXP_LOOT_The Book of Runes|r
.complete 11346,1 
.use 33778 
.use 33779 
.use 33780 
step
#completewith Witherleaf
.goto HowlingFjord,56.0,27.4,0
>>Open the |cRXP_PICK_Sprung Traps|r. Loot them for the |cRXP_LOOT_Trapped Prey|r
>>Kill |cRXP_ENEMY_Prowling Worgs|r that may spawn when opening the |cRXP_PICK_Sprung Traps|r. Loot them for their |cRXP_LOOT_Trapped Prey|r
.complete 11292,1 
.unitscan Trapped Animal
.mob Prowling Worg
step
.goto HowlingFjord,61.49,22.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lurielle|r
.turnin 11302 >>Turn in The Enigmatic Frost Nymphs
.accept 11313 >>Accept Spirits of the Ice
.target Lurielle
step
.goto HowlingFjord,59.7,23.3,70,0
.goto HowlingFjord,60.2,20.7,70,0
.goto HowlingFjord,63.4,23.7,70,0
.goto HowlingFjord,62.9,25.9,70,0
.goto HowlingFjord,59.7,23.3,70,0
.goto HowlingFjord,60.2,20.7,70,0
.goto HowlingFjord,63.4,23.7
>>Kill |cRXP_ENEMY_Ice Elementals|r. Loot them for their |cRXP_LOOT_Icy Cores|r
.complete 11313,1 
.mob Ice Elemental
step
.goto HowlingFjord,61.49,22.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lurielle|r
.turnin 11313 >>Turn in Spirits of the Ice
.accept 11315 >>Accept Wild Vines
.accept 11314 >>Accept The Fallen Sisters
.target Lurielle
step
.goto HowlingFjord,53.2,28.1,60,0
.goto HowlingFjord,51.2,29.1,60,0
.goto HowlingFjord,50.3,26.5,60,0
.goto HowlingFjord,52.0,26.0,60,0
.goto HowlingFjord,53.2,28.1,60,0
.goto HowlingFjord,51.2,29.1,60,0
.goto HowlingFjord,50.3,26.5,60,0
.goto HowlingFjord,52.0,26.0
>>|cRXP_WARN_Attack |cRXP_ENEMY_Chill Nymphs|r to 60% or less health so they become weakened|r
>>|cRXP_WARN_Use|r |T133299:0|t[Lurielle's Pendant] |cRXP_WARN_on |cRXP_ENEMY_Chill Nymphs|r to free them|r
>>Kill |cRXP_ENEMY_Scarlet Ivys|r
.use 33606
.complete 11314,1 
.complete 11315,1 
.mob Chill Nymph
.mob Scarlet Ivy
step
#completewith next
.goto HowlingFjord,61.49,22.86,100 >>Travel toward |cRXP_FRIENDLY_Lurielle|r
step
.goto HowlingFjord,61.49,22.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lurielle|r
.turnin 11315 >>Turn in Wild Vines
.turnin 11314 >>Turn in The Fallen Sisters
.accept 11316 >>Accept Spawn of the Twisted Glade
.accept 11319 >>Accept Seeds of the Blacksouled Keepers
.target Lurielle
step
#completewith next
.goto HowlingFjord,60.27,18.69,100 >>Travel to Fort Wildervar
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Christopher|r and |cRXP_FRIENDLY_Belvar|r
.turnin 11410 >>Turn in The One That Got Away
.goto HowlingFjord,60.27,18.69
.turnin 11346 >>Turn in The Book of Runes
.accept 11349 >>Accept Mastering the Runes
.goto HowlingFjord,62.28,17.22
.target Christopher Sloan
.target Prospector Belvar
step
.goto HowlingFjord,52.2,16.5,60,0
.goto HowlingFjord,52.5,19.7,60,0
.goto HowlingFjord,54.5,18.2,60,0
.goto HowlingFjord,52.2,16.5,60,0
.goto HowlingFjord,52.5,19.7,60,0
.goto HowlingFjord,54.5,18.2
>>Kill |cRXP_ENEMY_Thornvine Creepers|r and |cRXP_ENEMY_Spores|r
>>|cRXP_WARN_Use the|r |T133268:0|t[Enchanted Ice Core] |cRXP_WARN_on |cRXP_ENEMY_Spore|r corpses|r
>>|cRXP_WARN_Focus on |cRXP_ENEMY_Spores|r as the|r |T133268:0|t[Enchanted Ice Core] |cRXP_WARN_has a 15 second cooldown|r
.use 33607
.complete 11319,1 
.complete 11316,1 
.mob Spore
.mob Thornvine Creeper
step
.goto HowlingFjord,61.49,22.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lurielle|r
.turnin 11316 >>Turn in Spawn of the Twisted Glade
.turnin 11319 >>Turn in Seeds of the Blacksouled Keepers
.accept 11428 >>Accept Keeper Witherleaf
.target Lurielle
step
.goto HowlingFjord,67.54,23.33
>>Loot the |cRXP_LOOT_Iron Rune Carving Tools|r on the ground
.complete 11349,1 
step
#completewith next
.goto HowlingFjord,53.2,17.7,100 >> Travel to The Twisted Glade
step
#label Witherleaf
.goto HowlingFjord,53.2,17.7,50,0
.goto HowlingFjord,53.8,17.2,50,0
.goto HowlingFjord,53.9,15.6,50,0
.goto HowlingFjord,54.2,17.3,50,0
.goto HowlingFjord,53.3,18.7,50,0
.goto HowlingFjord,55.2,17.3,50,0
.goto HowlingFjord,54.2,17.3
>>Kill |cRXP_ENEMY_Keeper Winterleaf|r
.complete 11428,1 
.unitscan Keeper Witherleaf
step
#completewith next
.goto HowlingFjord,56.0,27.4,0
>>Loot the |cRXP_LOOT_Spotted Hippogryph Down|r on the ground
>>|cRXP_WARN_They look like Hippogryph Feathers|r
.complete 11269,1 
step
.goto HowlingFjord,50.4,12.8,50,0
.goto HowlingFjord,61.5,22.8,50,0
.goto HowlingFjord,59.51,26.77,50,0
.goto HowlingFjord,53.94,21.02
>>Open the |cRXP_PICK_Sprung Traps|r. Loot them for the |cRXP_LOOT_Trapped Prey|r
>>Kill |cRXP_ENEMY_Prowling Worgs|r that may spawn when opening the |cRXP_PICK_Sprung Traps|r. Loot them for their |cRXP_LOOT_Trapped Prey|r
.complete 11292,1 
.unitscan Trapped Animal
.mob Prowling Worg
step
.goto HowlingFjord,50.4,12.8,50,0
.goto HowlingFjord,61.5,22.8,50,0
.goto HowlingFjord,59.51,26.77,50,0
.goto HowlingFjord,53.94,21.02
>>Loot the |cRXP_LOOT_Spotted Hippogryph Down|r on the ground
>>|cRXP_WARN_They look like Hippogryph Feathers|r
.complete 11269,1 
step
.goto HowlingFjord,56.3,14.0,70,0
.goto HowlingFjord,57.7,7.9,70,0
.goto HowlingFjord,65.67,2.68,50,0
.goto HowlingFjord,61.10,1.98
>>Kill |cRXP_ENEMY_Frosthorn Rams|r. Loot them for their |cRXP_LOOT_Tough Ram Meat|r
.collect 33352,4 
.mob Frosthorn Ram
step
.goto HowlingFjord,61.10,1.98
>>|cRXP_WARN_Use the|r |T134025:0|t[Tough Ram Meat] |cRXP_WARN_to combine them into a|r |cRXP_LOOT_Giant Yeti Meal|r
.use 33352
.collect 33477,1 
step
.goto HowlingFjord,61.10,1.98
>>|cRXP_WARN_Click the |cRXP_PICK_Frostblade Shrine|r atop the mountain|r << !Druid !Shaman
>>|cRXP_WARN_Click the |cRXP_PICK_Frostblade Shrine|r atop the mountain. Make sure you're not shapeshifted|r << Druid
>>|cRXP_WARN_Click the |cRXP_PICK_Frostblade Shrine|r atop the mountain. Make sure you're not in|r |T136095:0|t[Ghost Wolf] << Shaman
>>Kill |cRXP_ENEMY_Your Inner Turmoil|r that spawns
.complete 11322,1 
.mob Your Inner Turmoil
step
#completewith next
.goto HowlingFjord,59.8,13.7,100 >> |cRXP_WARN_Jump down WITHOUT MOUNTING OR USING A MOVESPEED BUFF to Fort Wildervar with the|r |T135992:0|t[Slow Fall] |cRXP_WARN_buff you just received|r
.skill coldweatherflying,1,1
step
#completewith next
.goto HowlingFjord,59.8,13.7,30 >> Enter Wildervar Mine
step
.goto HowlingFjord,59.8,13.7,20,0
.goto HowlingFjord,60.46,11.89
.use 33477
>>|cRXP_WARN_Use the|r |T134054:0|t[Giant Yeti Meal] |cRXP_WARN_next to|r |cRXP_ENEMY_Shatterhorn|r
>>Kill |cRXP_ENEMY_Shatterhorn|r
.complete 11284,1 
.mob Shatterhorn
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tExit the mine. Talk to |cRXP_FRIENDLY_Colbey|r, |cRXP_FRIENDLY_Jethan|r, and |cRXP_FRIENDLY_Gil|r
.turnin 11284 >>Turn in The Yeti Next Door
.goto HowlingFjord,60.18,15.61
.turnin 11292 >>Turn in Preying Upon the Weak
.goto HowlingFjord,62.66,16.80
.turnin 11269 >>Turn in Down to the Wire
.accept 11418 >>Accept We Call Him Steelfeather
.goto HowlingFjord,62.60,16.82
.target Foreman Colbey
.target Trapper Jethan
.target Gil Grisert
step
.goto HowlingFjord,62.2,16.6
.use 34026 >>Target |cRXP_ENEMY_Steelfeather|r
>>|cRXP_WARN_Use the|r |T135225:0|t[Feathered Charm] |cRXP_WARN_to watch her|r
>>|cRXP_WARN_Wait for the objective to complete|r
.complete 11418,1 
.unitscan Steelfeather

step
>>|cRXP_WARN_Click off the|r |T135225:0|t[Feathered Charm] |cRXP_WARN_buff|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gil|r and |cRXP_FRIENDLY_Belvar|r
.turnin 11418 >>Turn in We Call Him Steelfeather
.goto HowlingFjord,62.60,16.82
.turnin 11349 >>Turn in Mastering the Runes
.accept 11348 >>Accept The Rune of Command
.goto HowlingFjord,62.28,17.22
.target Gil Grisert
.target Prospector Belvar
step
.goto HowlingFjord,61.49,22.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lurielle|r
.turnin 11428 >>Turn in Keeper Witherleaf
.target Lurielle
step
.goto HowlingFjord,70.41,23.92,20,0
.goto HowlingFjord,71.95,23.22
>>|cRXP_WARN_Use the|r |T134425:0|t[Rune of Command] |cRXP_WARN_on a neutral |cRXP_ENEMY_Stone Giant|r to gain control of it|r
.use 33796
.complete 11348,1 
.target Stone Giant
step
#completewith next
.goto HowlingFjord,70.0,29.6,0
.goto HowlingFjord,72.7,18.5,0
.goto HowlingFjord,66.8,25.1,0
>>|cRXP_WARN_You now have a |cRXP_FRIENDLY_Stone Giant|r pet|r
.use 33806 >>Kill |cRXP_ENEMY_Runed Stone Giants|r
>>|cRXP_WARN_Use the|r |T134708:0|t[Runeseeking Pick] |cRXP_WARN_on their corpses|r
.complete 11355,1 
.mob Runed Stone Giant
step
.goto HowlingFjord,71.85,24.56
>>Kill |cRXP_ENEMY_Binder Murdis|r
.complete 11348,2 
.mob Binder Murdis
step
.goto HowlingFjord,70.0,29.6,60,0
.goto HowlingFjord,72.7,18.5,60,0
.goto HowlingFjord,66.8,25.1,60,0
.goto HowlingFjord,68.09,29.03,60,0
.goto HowlingFjord,70.0,29.6
>>|cRXP_WARN_You now have a |cRXP_FRIENDLY_Stone Giant|r pet|r
.use 33806 >>Kill |cRXP_ENEMY_Runed Stone Giants|r
>>|cRXP_WARN_Use the|r |T134708:0|t[Runeseeking Pick] |cRXP_WARN_on their corpses|r
.complete 11355,1 
.mob Runed Stone Giant
.use 33796
step
#completewith next
.goto HowlingFjord,62.58,16.52,100 >> Travel to Fort Wildervar
step
.goto HowlingFjord,62.58,16.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Aderan|r
>>|cRXP_WARN_Do NOT Turn in at |cRXP_FRIENDLY_Belvar|r as you'll lose your pet|r
.turnin 11355 >> Turn in March of the Giants
.accept 11358 >> Accept The Lodestone
.target Researcher Aderan
step
.goto HowlingFjord,71.64,17.65
.use 33819 >> |cRXP_WARN_Use the|r |T134424:0|t[Rune Sample] |cRXP_WARN_at the|r |cRXP_PICK_Broken Tablet|r
>>|cRXP_WARN_Wait out the RP|r
.cast 43692
.timer 23,The Lodestone RP
.complete 11358,1 
.use 33796
step
.goto HowlingFjord,62.58,16.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Aderan|r
>>|cRXP_WARN_Do NOT Turn in at |cRXP_FRIENDLY_Belvar|r as you'll lose your pet|r
.turnin 11358 >>Turn in The Lodestone
.accept 11359 >>Accept Demolishing Megalith
.target Researcher Aderan

step
.goto HowlingFjord,69.4,11.5,70,0
.goto HowlingFjord,66.1,9.4
.use 33796 >>|cRXP_WARN_Use the|r |T134425:0|t[Rune of Command] |cRXP_WARN_on a neutral |cRXP_ENEMY_Stone Giant|r if you lost your pet|r
>>Kill |cRXP_ENEMY_Megalith|r with your |cRXP_FRIENDLY_Stone Giant|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r
.complete 11359,1 
.use 33796
.mob Megalith
step
#completewith end
#label Megalith2
.goto HowlingFjord,62.58,16.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Aderan|r
.turnin 11359 >>Turn in Demolishing Megalith
.isQuestComplete 11359
.target Researcher Aderan
step
.goto HowlingFjord,62.28,17.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Belvar|r
.turnin 11348 >>Turn in The Rune of Command
.target Prospector Belvar
step << !Shaman
#requires Megalith2
.goto HowlingFjord,60.1,16.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_James|r
.fp Fort Wildervar >> Get the Fort Wildervar Flight Path
.fly Westguard Keep >> Fly to Westguard Keep
.target James Ormsby
step << Shaman
#requires Megalith2
#completewith next
.hs >> Hearth to Westguard Keep
step
#completewith next
.goto HowlingFjord,31.2,35.6,100 >> Travel to Whisper Gulch
.skill coldweatherflying,<1,1
step
.goto HowlingFjord,31.2,35.6,40,0
.goto HowlingFjord,32.0,33.3
>>Kill |cRXP_ENEMY_Squeeg Idolhunter|r
.complete 11240,1 
.unitscan Squeeg Idolhunter
.skill coldweatherflying,<1,1
step
#completewith next
.goto HowlingFjord,31.2,35.6,40,0
.goto HowlingFjord,32.0,33.3,30 >> Travel to Whisper Gulch. Carefully jump down
.skill coldweatherflying,1,1
step
.goto HowlingFjord,31.2,35.6,40,0
.goto HowlingFjord,32.0,33.3
>>Kill |cRXP_ENEMY_Squeeg Idolhunter|r
.complete 11240,1 
.unitscan Squeeg Idolhunter
.skill coldweatherflying,1,1
step
#completewith next
.groundgoto HowlingFjord,33.75,35.89,50,0
.goto HowlingFjord,30.1,28.6,100 >> Travel to Steel Gate
step
.goto HowlingFjord,30.06,28.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Moonleaf|r
.turnin 11322 >>Turn in The Cleansing
.accept 11325 >>Accept In Worg's Clothing
.target Watcher Moonleaf
step
.goto HowlingFjord,30.81,20.76,40,0
.use 33129 >>|cRXP_WARN_Use|r |T133715:0|t[Feknut's Firecrackers] |cRXP_WARN_underneath a |cRXP_ENEMY_Darkclaw Bat|r in the air.|r Loot the |cRXP_LOOT_Darkclaw Guano|r that drops below them
>>|cRXP_WARN_You can avoid combat with them if you loot fast enough|r
.complete 11154,1 
.mob Darkclaw Bat

step
#completewith next
.goto HowlingFjord,29.45,6.51,150 >> Travel to Rivenwood
step
#completewith next
.goto HowlingFjord,29.45,6.51
.cast 43369 >>|cRXP_WARN_Use the|r |T132203:0|t[Worg Disguise] |cRXP_WARN_before you approach the cave. This will turn all the |cRXP_ENEMY_Worgs|r friendly|r
.use 33618
step
.goto HowlingFjord,29.68,5.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ulfang|r
>>|cRXP_WARN_Don't take damage or cast any spells|r
.turnin 11325 >>Turn in In Worg's Clothing
.accept 11414 >>Accept Brother Betrayers
.use 33618
.target Ulfang
step
.goto HowlingFjord,26.11,21.22,60,0
.goto HowlingFjord,27.12,21.69,60,0
.goto HowlingFjord,28.04,23.84,60,0
.goto HowlingFjord,28.40,23.76,60,0
.goto HowlingFjord,28.87,23.27,60,0
.goto HowlingFjord,28.96,22.66,60,0
.goto HowlingFjord,28.69,21.91,60,0
.goto HowlingFjord,27.37,21.08,60,0
.goto HowlingFjord,26.83,19.75,60,0
.goto HowlingFjord,26.45,19.58,60,0
.goto HowlingFjord,26.08,19.92
>>|cRXP_WARN_Click off the|r |T132203:0|t[Worg Disguise] |cRXP_WARN_buff|r
>>Kill |cRXP_ENEMY_Bjomolf|r. |cRXP_WARN_He patrols around clockwise|r
.line HowlingFjord,26.08,19.92,26.45,19.58,26.83,19.75,27.37,21.08,28.69,21.91,28.96,22.66,28.87,23.27,28.40,23.76,28.04,23.84,27.12,21.69,26.11,21.22,26.08,19.92
.complete 11414,1 
.unitscan Bjomolf
step
.goto HowlingFjord,33.81,29.12,60,0
.goto HowlingFjord,33.68,29.77,60,0
.goto HowlingFjord,34.00,30.78,60,0
.goto HowlingFjord,34.53,31.43,60,0
.goto HowlingFjord,34.98,31.52,60,0
.goto HowlingFjord,35.24,31.40,60,0
.goto HowlingFjord,35.79,30.11,60,0
.goto HowlingFjord,35.82,29.61,60,0
.goto HowlingFjord,35.74,29.22,60,0
.goto HowlingFjord,35.49,28.86,60,0
.goto HowlingFjord,34.99,28.66
.line HowlingFjord,34.99,28.66,35.49,28.86,35.74,29.22,35.82,29.61,35.79,30.11,35.24,31.40,34.98,31.52,34.53,31.43,34.00,30.78,33.68,29.77,33.81,29.12,34.99,28.66
>>Kill |cRXP_ENEMY_Varg|r. |cRXP_WARN_He patrols around clockwise|r
.complete 11414,2 
.unitscan Varg
step
#completewith next
.goto HowlingFjord,29.45,6.51,250 >> Travel to Rivenwood
step
#completewith next
.goto HowlingFjord,29.45,6.51
.cast 43369 >>|cRXP_WARN_Use the|r |T132203:0|t[Worg Disguise] |cRXP_WARN_before you approach the cave. This will turn all the |cRXP_ENEMY_Worgs|r friendly|r
.use 33618
step
.goto HowlingFjord,29.68,5.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ulfang|r
>>|cRXP_WARN_Don't take damage or cast any spells|r
.turnin 11414 >>Turn in Brother Betrayers
.accept 11416 >>Accept Eyes of the Eagle
.use 33618
.target Ulfang
step
#completewith next
.goto HowlingFjord,44.3,26.2,200 >> |cRXP_WARN_Click off the|r |T132203:0|t[Worg Disguise] |cRXP_WARN_buff.|r Travel to Skorn
step
#completewith next
.cast 43042 >> |cRXP_WARN_Use the|r |T135438:0|t[Westguard Command Insignia] |cRXP_WARN_to summon a|r |cRXP_FRIENDLY_Westguard Sergeant|r
.use 33311
step
.goto HowlingFjord,44.3,26.2
.use 33311 >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Sergeant|r
.turnin 11248 >>Turn in Operation: Skornful Wrath
.accept 11245 >>Accept Towers of Certain Doom
.accept 11246 >>Accept Gruesome, But Necessary
.accept 11247 >>Accept Burn Skorn, Burn!
.target Westguard Sergeant
step
#completewith Dismember
.goto HowlingFjord,44.9,34.7,0
.use 33310 >>Kill the |cRXP_ENEMY_Winterskorn|r. |cRXP_WARN_Use|r |T135662:0|t[The Sergeant's Machete] |cRXP_WARN_on their corpses|r
.complete 11246,1 
.mob Winterskorn Berserker
.mob Winterskorn Elder
.mob Winterskorn Raider
.mob Winterskorn Shield-Maiden
.mob Winterskorn Tribesman
.mob Winterskorn Warrior
.mob Winterskorn Woodsman



step
#completewith SETower
.goto HowlingFjord,44.9,34.7,0
.use 33314 >>Kill the |cRXP_ENEMY_Winterskorn|r. Loot them for their |T136244:0|t[|cRXP_LOOT_Vrykul Scroll of Ascension|r]
>>|cRXP_WARN_Use the |T136244:0|t[|cRXP_LOOT_Vrykul Scroll of Ascension|r] to start the quest|r
.collect 33314,1,11249,1 
.accept 11249 >> Accept Stop The Ascension!
.mob Winterskorn Berserker
.mob Winterskorn Elder
.mob Winterskorn Raider
.mob Winterskorn Shield-Maiden
.mob Winterskorn Tribesman
.mob Winterskorn Warrior
.mob Winterskorn Woodsman



step
.goto HowlingFjord,43.66,28.57
.use 33321 >>|cRXP_WARN_Use the|r |T135434:0|t[Sergeant's Torch] |cRXP_WARN_and|r |T132863:0|t[Sergeant's Flare] |cRXP_WARN_while inside the building|r
.use 33323
.complete 11247,1 
.complete 11245,1 

step
.use 33321 >>|cRXP_WARN_Use the|r |T135434:0|t[Sergeant's Torch] |cRXP_WARN_while inside the buildings|r
.complete 11247,2 
.goto HowlingFjord,46.39,28.13
.complete 11247,3 
.goto HowlingFjord,45.93,30.71
step
#label SETower
.use 33323 >>|cRXP_WARN_Use the|r |T132863:0|t[Sergeant's Flare] |cRXP_WARN_while outside the towers. It has a 90 yard range|r
.complete 11245,2 
.goto HowlingFjord,46.72,32.82
.complete 11245,4 
.goto HowlingFjord,47.10,36.87
step
.goto HowlingFjord,45.62,35.34,60,0
.goto HowlingFjord,43.85,35.60,60,0
.goto HowlingFjord,44.68,32.16,60,0
.goto HowlingFjord,44.10,29.17,60,0
.goto HowlingFjord,45.37,27.39,60,0
.goto HowlingFjord,46.17,32.24
.use 33314 >>Kill the |cRXP_ENEMY_Winterskorn|r. Loot them for their |T136244:0|t[|cRXP_LOOT_Vrykul Scroll of Ascension|r]
>>|cRXP_WARN_Use the |T136244:0|t[|cRXP_LOOT_Vrykul Scroll of Ascension|r] to start the quest|r
.collect 33314,1,11249,1 
.accept 11249 >> Accept Stop The Ascension!
.mob Winterskorn Berserker
.mob Winterskorn Elder
.mob Winterskorn Raider
.mob Winterskorn Shield-Maiden
.mob Winterskorn Tribesman
.mob Winterskorn Warrior
.mob Winterskorn Woodsman



step
#completewith next
.goto HowlingFjord,44.84,34.93
.cast 43089 >>|cRXP_WARN_Use the|r |T136244:0|t[Vrykul Scroll of Ascension] |cRXP_WARN_at |cRXP_PICK_Thane's Pyre|r to summon|r |cRXP_ENEMY_Halfdan the Ice-Hearted|r
.use 33314
step
#label Dismember
.goto HowlingFjord,44.98,35.92
.use 33339 >>Kill |cRXP_ENEMY_Halfdan the Ice-Hearted|r
.complete 11249,1 
.mob Halfdan the Ice-Hearted
step
.goto HowlingFjord,45.62,35.34,60,0
.goto HowlingFjord,43.85,35.60,60,0
.goto HowlingFjord,44.68,32.16,60,0
.goto HowlingFjord,44.10,29.17,60,0
.goto HowlingFjord,45.37,27.39,60,0
.goto HowlingFjord,46.17,32.24
.use 33310 >>Kill the |cRXP_ENEMY_Winterskorn|r. |cRXP_WARN_Use|r |T135662:0|t[The Sergeant's Machete] |cRXP_WARN_on their corpses|r
.complete 11246,1 
.mob Winterskorn Berserker
.mob Winterskorn Elder
.mob Winterskorn Raider
.mob Winterskorn Shield-Maiden
.mob Winterskorn Tribesman
.mob Winterskorn Warrior
.mob Winterskorn Woodsman



step
.goto HowlingFjord,43.11,36.15
.use 33323 >>|cRXP_WARN_Use the|r |T132863:0|t[Sergeant's Flare] |cRXP_WARN_while outside the towers. It has a 90 yard range|r
.complete 11245,3 
step
#completewith next
.cast 43042 >> |cRXP_WARN_Use the|r |T135438:0|t[Westguard Command Insignia] |cRXP_WARN_to summon a|r |cRXP_FRIENDLY_Westguard Sergeant|r
.use 33311
step
.goto HowlingFjord,44.41,35.84
.use 33311 >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Sergeant|r
.turnin 11245 >>Turn in Towers of Certain Doom
.turnin 11246 >>Turn in Gruesome, But Necessary
.turnin 11247 >>Turn in Burn Skorn, Burn!
.accept 11250 >>Accept All Hail the Conqueror of Skorn!
.target Westguard Sergeant
step
#completewith next
.goto HowlingFjord,41.47,37.70,100 >> Travel to the bottom of the waterfall
>>|cRXP_WARN_Carefully descend the mountain|r
.skill coldweatherflying,1,1
step
.goto HowlingFjord,41.47,37.70
>>|cRXP_WARN_Click |cRXP_PICK_Talonshrike's Egg|r to summon|r |cRXP_ENEMY_Talonshrike|r
>>Kill |cRXP_ENEMY_Talonshrike|r. Loot him for the |cRXP_LOOT_Eyes of the Eagle|r
.complete 11416,1 
.cast 3365
.timer 13,Eyes of the Eagle RP
.mob Talonshrike
step << Shaman
#completewith next
.hs >> Hearth to Westguard Keep
step
#completewith next
.goto HowlingFjord,28.84,44.13,200 >> Travel to Westguard Keep
step
>>|cRXP_WARN_Go to the main room of Westguard Keep|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Adams|r and |cRXP_FRIENDLY_Levariol|r
.turnin 11250 >>Turn in All Hail the Conqueror of Skorn!
.accept 11235 >>Accept Dealing With Gjalerbron
.goto HowlingFjord,28.84,44.13
.turnin 11249 >>Turn in Stop the Ascension!
.accept 11231 >>Accept Of Keys and Cages
.goto HowlingFjord,28.86,43.97
.target Captain Adams
.target Father Levariol
step
.goto HowlingFjord,29.11,41.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Steelring|r
.turnin 11240 >>Turn in Leader of the Deranged
.target Sapper Steelring
step
.goto HowlingFjord,35.8,11.4
.abandon 12171 >> Abandon Of Traitors and Treason
step
#completewith next
.goto HowlingFjord,35.30,17.31,200 >> Travel to Gjalerbron
step
#completewith next
.goto HowlingFjord,35.8,11.4,0
.use 33289 >>Kill |cRXP_ENEMY_Gjalerbron Warriors|r, |cRXP_ENEMY_Gjalerbron Sleep-Watchers|r and |cRXP_ENEMY_Gjalerbron Rune-Casters|r. Loot them for their |T134941:0|t[|cRXP_LOOT_Gjalerbron Attack Plans|r]
>>|cRXP_WARN_Use the |T134941:0|t[|cRXP_LOOT_Gjalerbron Attack Plans|r] to start the quest|r
.collect 33289,1,11237,1 
.accept 11237 >>Accept Gjalerbron Attack Plans
.mob Gjalerbron Warrior
.mob Gjalerbron Sleep-Watcher
.mob Gjalerbron Rune-Caster
step
.goto HowlingFjord,35.8,18.1,60,0
.goto HowlingFjord,34.5,14.4,60,0
.goto HowlingFjord,36.9,11.4,60,0
.goto HowlingFjord,35.9,9.8,60,0
.goto HowlingFjord,33.5,12.0,60,0
.goto HowlingFjord,31.1,13.1,60,0
.goto HowlingFjord,35.8,18.1,60,0
.goto HowlingFjord,34.5,14.4,60,0
.goto HowlingFjord,36.9,11.4,60,0
.goto HowlingFjord,35.9,9.8,60,0
.goto HowlingFjord,33.5,12.0,60,0
.goto HowlingFjord,31.1,13.1,60,0
.goto HowlingFjord,35.8,18.1,60,0
.goto HowlingFjord,34.5,14.4
>>Kill |cRXP_ENEMY_Gjalerbron Warriors|r, |cRXP_ENEMY_Sleep-Watchers|r and |cRXP_ENEMY_Gjalerbron Rune-Casters|r. Loot them for their |cRXP_LOOT_Gjalerbron Cage Keys|r. |cRXP_WARN_Open the |cRXP_PICK_Gjalerbron Cages|r to free|r |cRXP_FRIENDLY_Gjalerbron Prisoners|r
>>|cRXP_WARN_If you loot a |cRXP_LOOT_Large Gjalerbron Cage Key|r, you can use it to open the |cRXP_PICK_Large Gjalerbron Cage|r in the middle of the second level|r
.complete 11235,1 
.complete 11235,2 
.complete 11235,3 
.collect 33290,1,11231,1,1 
.collect 33284,10,11231,1,-1 
.complete 11231,1 
.mob Gjalerbron Warrior
.mob Gjalerbron Sleep-Watcher
.mob Gjalerbron Rune-Caster
.target Gjalerbron Prisoner
step
.goto HowlingFjord,35.8,18.1,60,0
.goto HowlingFjord,34.5,14.4,60,0
.goto HowlingFjord,36.9,11.4,60,0
.goto HowlingFjord,35.9,9.8,60,0
.goto HowlingFjord,33.5,12.0,60,0
.goto HowlingFjord,31.1,13.1,60,0
.goto HowlingFjord,35.8,18.1,60,0
.goto HowlingFjord,34.5,14.4,60,0
.goto HowlingFjord,36.9,11.4,60,0
.goto HowlingFjord,35.9,9.8,60,0
.goto HowlingFjord,33.5,12.0,60,0
.goto HowlingFjord,31.1,13.1,60,0
.goto HowlingFjord,35.8,18.1,60,0
.goto HowlingFjord,34.5,14.4
.use 33289 >>Kill |cRXP_ENEMY_Gjalerbron Warriors|r, |cRXP_ENEMY_Gjalerbron Sleep-Watchers|r and |cRXP_ENEMY_Gjalerbron Rune-Casters|r. Loot them for their |T134941:0|t[|cRXP_LOOT_Gjalerbron Attack Plans|r]
>>|cRXP_WARN_Use the |T134941:0|t[|cRXP_LOOT_Gjalerbron Attack Plans|r] to start the quest|r
.collect 33289,1,11237,1 
.accept 11237 >>Accept Gjalerbron Attack Plans
.mob Gjalerbron Warrior
.mob Gjalerbron Sleep-Watcher
.mob Gjalerbron Rune-Caster
step
#completewith next
.goto HowlingFjord,29.45,6.51
.cast 43369 >>|cRXP_WARN_Use the|r |T132203:0|t[Worg Disguise] |cRXP_WARN_before you approach the cave. This will turn all the |cRXP_ENEMY_Worgs|r friendly|r
.use 33618
step
.goto HowlingFjord,29.68,5.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ulfang|r
>>|cRXP_WARN_Don't take damage or cast any spells|r
.turnin 11416 >>Turn in Eyes of the Eagle
.accept 11326 >>Accept Alpha Worg
.use 33618
.target Ulfang
step
.goto HowlingFjord,29.37,15.93,50,0
.goto HowlingFjord,29.40,15.45,50,0
.goto HowlingFjord,29.19,14.57,50,0
.goto HowlingFjord,28.52,13.93,50,0
.goto HowlingFjord,28.25,13.04,50,0
.goto HowlingFjord,28.50,11.04,50,0
.goto HowlingFjord,28.30,9.85,50,0
.goto HowlingFjord,27.63,8.33,50,0
.goto HowlingFjord,27.27,8.00,50,0
.goto HowlingFjord,26.91,8.08,50,0
.goto HowlingFjord,26.69,8.37,50,0
.goto HowlingFjord,26.47,9.37,50,0
.goto HowlingFjord,26.42,10.65,50,0
.goto HowlingFjord,26.98,12.96,50,0
.goto HowlingFjord,26.94,14.56,50,0
.goto HowlingFjord,28.53,17.25,50,0
.goto HowlingFjord,29.30,16.81,50,0
.goto HowlingFjord,29.53,17.47,50,0
.goto HowlingFjord,29.42,17.83,50,0
.goto HowlingFjord,29.44,18.18,50,0
.goto HowlingFjord,29.76,18.57,50,0
.goto HowlingFjord,30.44,18.32,50,0
.goto HowlingFjord,30.68,18.09,50,0
.goto HowlingFjord,30.75,17.67,50,0
.goto HowlingFjord,29.37,15.93
.line HowlingFjord,30.75,17.67,30.68,18.09,30.44,18.32,29.94,18.43,29.76,18.57,29.44,18.18,29.42,17.83,29.53,17.47,29.30,16.81,28.53,17.25,26.94,14.56,26.98,12.96,26.42,10.65,26.47,9.37,26.69,8.37,26.91,8.08,27.27,8.00,27.63,8.33,28.30,9.85,28.50,11.04,28.25,13.04,28.52,13.93,29.19,14.57,29.40,15.45,29.37,15.93,30.75,17.67
>>Kill |cRXP_ENEMY_Garwal|r. |cRXP_WARN_He patrols around clockwise|r
>>|cRXP_WARN_Make sure you have the|r |T132150:0|t[Eyes of the Eagle] |cRXP_WARN_buff, otherwise he will be invisible|r. |cRXP_WARN_If you lose the buff, abandon the quest and take it again|r
.complete 11326,1 
.unitscan Garwal
step
#completewith next
.goto HowlingFjord,30.05,28.58
>>Ask |cRXP_FRIENDLY_Moonleaf|r for another disguise
.complete 11326,2 
.skipgossip 24273,2
.target Watcher Moonleaf
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Moonleaf|r and |cRXP_FRIENDLY_Feknut|r
.turnin 11326 >>Turn in Alpha Worg
.goto HowlingFjord,30.05,28.58
.turnin 11154 >>Turn in Scare the Guano Out of Them!
.goto HowlingFjord,30.15,28.69
.target Watcher Moonleaf
.target Engineer Feknut
step
#completewith next
.goto HowlingFjord,28.84,44.13,200 >> Travel to Westguard Keep
step
>>|cRXP_WARN_Go to the main room of Westguard Keep|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Adams|r, |cRXP_FRIENDLY_Levariol|r, and |cRXP_FRIENDLY_Malister|r
.turnin 11235 >>Turn in Dealing With Gjalerbron
.accept 11236 >>Accept Necro Overlord Mezhen
.goto HowlingFjord,28.84,44.13
.turnin 11231 >>Turn in Of Keys and Cages
.accept 11239 >>Accept In Service to the Light
.goto HowlingFjord,28.86,43.97
.turnin 11237 >>Turn in Gjalerbron Attack Plans
.accept 11238 >>Accept The Frost Wyrm and its Master
.accept 11432 >>Accept Sleeping Giants
.goto HowlingFjord,28.94,44.19
.target Captain Adams
.target Father Levariol
.target Mage-Lieutenant Malister
step
.goto HowlingFjord,38.7,12.7
.abandon 12171 >> Abandon Of Traitors and Treason
step
#completewith next
.goto HowlingFjord,38.79,13.08,300 >> Travel to Gjalerbron
step
#completewith Glacion
.goto HowlingFjord,38.7,12.7,0
>>Kill |cRXP_ENEMY_Necrolords|r. Loot them for their |cRXP_LOOT_Awakening Rods|r
.collect 34083,5,11432,1 
.mob Necrolord
step
#completewith Necrolord
.goto HowlingFjord,39.6,7.8,0
>>Kill |cRXP_ENEMY_Putrid Wights|r
.complete 11239,3 
.mob Putrid Wight
step
#completewith Wight
.goto HowlingFjord,33.7,10.0,0
>>Kill |cRXP_ENEMY_Deathless Watchers|r
.complete 11239,1 
.mob Deathless Watcher
step
.groundgoto HowlingFjord,35.33,13.69,70,0
.groundgoto HowlingFjord,38.23,10.45,70,0
.goto HowlingFjord,38.79,13.08
.use 34090 >>Kill |cRXP_ENEMY_Necro Overlord Mezhen|r. Loot him for |T134946:0|t[|cRXP_LOOT_Mezhen's Writings|r]
>>|cRXP_WARN_Use |T134946:0|t[|cRXP_LOOT_Mezhen's Writings|r] to start the quest|r
.complete 11236,1 
.collect 34090,1,11452 
.accept 11452 >> Accept The Slumbering King
.mob Necro Overlord Mezhen
step
#completewith next
.goto HowlingFjord,39.90,7.46,40 >> Enter Winter's Terrace
step
.goto HowlingFjord,39.6,7.8,40,0
.goto HowlingFjord,40.88,6.49
>>Kill |cRXP_ENEMY_Queen Angerboda|r
.complete 11452,1 
.mob Queen Angerboda
step
#completewith next
.goto HowlingFjord,39.45,7.99,30 >> Exit Winter's Terrace
step
#label Glacion
.goto HowlingFjord,36.46,7.35
>>Kill |cRXP_ENEMY_Wymcaller Vile|r. Loot him for his |cRXP_LOOT_Horn|r
.complete 11238,1 
.complete 11238,3 
.mob Wyrmcaller Vile
step
.goto HowlingFjord,36.46,7.35
.use 33282 >>|cRXP_WARN_Use the|r |T134228:0|t[Wyrmcaller's Horn] |cRXP_WARN_to summon|r |cRXP_ENEMY_Glacion|r
>>|cRXP_WARN_It takes |cRXP_ENEMY_Glacion|r 20-35 seconds to land|r
>>Kill |cRXP_ENEMY_Glacion|r
.complete 11238,2 
.cast 42817
.timer 20,Glacion RP
.mob Glacion
step
#label Necrolord
.goto HowlingFjord,38.64,12.83,70,0
.goto HowlingFjord,36.88,15.78,70,0
.goto HowlingFjord,33.15,9.22,70,0
.goto HowlingFjord,38.64,12.83,70,0
.goto HowlingFjord,36.88,15.78,70,0
.goto HowlingFjord,33.15,9.22,70,0
.goto HowlingFjord,38.64,12.83
>>Kill |cRXP_ENEMY_Necrolords|r. Loot them for their |cRXP_LOOT_Awakening Rods|r
.collect 34083,5,11432,1 
.mob Necrolord
step
#label Wight
.goto HowlingFjord,38.64,12.83,70,0
.goto HowlingFjord,36.88,15.78,70,0
.goto HowlingFjord,33.15,9.22,70,0
.goto HowlingFjord,38.64,12.83,70,0
.goto HowlingFjord,36.88,15.78,70,0
.goto HowlingFjord,33.15,9.22,70,0
.goto HowlingFjord,38.64,12.83
>>Kill |cRXP_ENEMY_Putrid Wights|r
.complete 11239,3 
.unitscan Putrid Wight
step
.goto HowlingFjord,38.64,12.83,70,0
.goto HowlingFjord,36.88,15.78,70,0
.goto HowlingFjord,33.15,9.22,70,0
.goto HowlingFjord,38.64,12.83,70,0
.goto HowlingFjord,36.88,15.78,70,0
.goto HowlingFjord,33.15,9.22,70,0
.goto HowlingFjord,38.64,12.83
>>Kill |cRXP_ENEMY_Deathless Watchers|r
.complete 11239,1 
.mob Deathless Watcher
step
#completewith next
.goto HowlingFjord,34.52,13.09,25 >> Enter The Waking Halls
step
.goto HowlingFjord,34.52,13.09,25,0
.goto HowlingFjord,35.18,11.86,20,0
.goto HowlingFjord,34.63,10.03,20,0
.goto HowlingFjord,32.68,8.99
.use 34083 >>Kill |cRXP_ENEMY_Fearsome Horrors|r
>>|cRXP_WARN_Channel the|r |T135480:0|t[Awakening Rods] |cRXP_WARN_on |cRXP_ENEMY_Dormant Vrykuls|r to kill them|r
>>|cRXP_WARN_Be careful as dot damage from the|r |cRXP_ENEMY_Fearsome Horrors|r |cRXP_WARN_can interrupt the|r |T135480:0|t[Awakening Rod] |cRXP_WARN_channel|r
.complete 11239,2 
.collect 34083,5,11433,1,-1
.complete 11432,1 
.mob Fearsome Horror
.mob Dormant Vrykul
step << Druid
#completewith next
.cast 18960 >> Cast Teleport: Moonglade
.zoneskip Moonglade
.xp <71,1
step << Druid
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 48442 >> Train your class spells
.xp <71,1
.target Loganaar
step << skip
#completewith next
.cast 50977 >> Cast Death Gate
.zoneskip Eastern Plaguelands
.xp <71,1
step << skip
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.trainer >> Train your class spells
.xp <71,1
.target Amal'thazad

step << skip
#completewith next
.zone Stormwind City >> Teleport to Stormwind
.xp <71,1
step << skip
.goto Stormwind City,49.55,85.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 43023 >> Train your class spells
.xp <71,1
.target Elsharin
.target Jennea Cannon

step
#completewith next
.hs >> Hearth to Westguard Keep
step
#label end
>>|cRXP_WARN_Go to the main room of Westguard Keep|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malister|r, |cRXP_FRIENDLY_Adams|r, and |cRXP_FRIENDLY_Levariol|r
.turnin 11238 >>Turn in The Frost Wyrm and its Master
.turnin 11432 >>Turn in Sleeping Giants
.goto HowlingFjord,28.94,44.19
.turnin 11236 >>Turn in Necro Overlord Mezhen
.turnin 11452 >>Turn in The Slumbering King
.goto HowlingFjord,28.84,44.13
.turnin 11239 >>Turn in In Service to the Light
.goto HowlingFjord,28.86,43.97
.target Mage-Lieutenant Malister
.target Captain Adams
.target Father Levariol
step
.abandon 12171 >> Abandon Of Traitors and Treason
step << Mage
#completewith MaTraining
.zone Stormwind City >> Teleport to Stormwind
step << Mage
.goto Stormwind City,49.55,85.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 27126 >> Train your class spells
.xp <70,1
.target Elsharin
.target Jennea Cannon
step << Mage
#label MaTraining
.goto Stormwind City,49.55,85.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 43023 >> Train your class spells
.xp <71,1
.target Elsharin
.target Jennea Cannon
step << !Mage
.cast 387064 >> |cRXP_WARN_Use the|r |T134943:0|t[Teleport Scroll: Stormwind Harbor] |cRXP_WARN_to teleport to Stormwind|r
.use 199336
.itemcount 199336,1
step << !Mage
#completewith next
.goto HowlingFjord,31.26,43.98
.zone Stormwind City >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greer|r
.fly Valgarde >>Fly to Valgarde. Alternatively pay a |T626001:0|t|cFF3FC7EBMage|r for a portal to Stormwind
.zoneskip Stormwind City
.zoneskip Wetlands
.itemcount 199336,<1
.target Greer Orehammer
step << !Mage
#completewith next
.goto HowlingFjord,61.31,62.57
.zone Wetlands >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Basil|r on the Docks. Ask him for a teleport to Menethil Harbor
.zoneskip Stormwind City
.zoneskip Wetlands
.skipgossip
.itemcount 199336,<1
.target Basil Crowe
step << !Mage
#completewith next
.goto Wetlands,9.49,59.69
.zone Stormwind City >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shellei|r
.fly Stormwind City >> Fly to Stormwind City
.zoneskip Stormwind City
.itemcount 199336,<1
.target Shellei Brondir
step << Shaman
.goto Stormwind City,61.9,84.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umbrua|r
.train 25472 >> Train your class spells
.xp <70,1
.target Farseer Umbrua
step << Shaman
.goto Stormwind City,61.9,84.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umbrua|r
.train 58699 >> Train your class spells
.xp <71,1
.target Farseer Umbrua
step
.goto Stormwind City,61.4,70.0,12,0
.goto Stormwind City,61.2,70.7,12,0
.goto Stormwind City,61.6,70.7
>>|cRXP_WARN_Buy an|r |T237290:0|t[Overcharged Capacitor] |cRXP_WARN_from the Auction House if it's cheap. This is a minor boost in XP for later. If it's too expensive, skip this step|r
.collect 39682,1 
step << Warlock
#completewith WLTraining
.goto Stormwind City,29.2,74.0,20,0
.goto Stormwind City,27.2,78.1,15 >> Go into The Slaughtered Lamb and go downstairs
step << Warlock
.goto Stormwind City,25.3,78.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ursula|r, |cRXP_FRIENDLY_Demisette|r or |cRXP_FRIENDLY_Sandahl|r
.train 27260 >> Train your class spells
.xp <70,1
.target Ursula Deline
.target Demisette Cloyce
.target Sandahl
step << Warlock
#label WLTraining
.goto Stormwind City,25.3,78.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ursula|r, |cRXP_FRIENDLY_Demisette|r or |cRXP_FRIENDLY_Sandahl|r
.train 47812 >> Train your class spells
.xp <71,1
.target Ursula Deline
.target Demisette Cloyce
.target Sandahl
step << Paladin/Priest
#completewith PaPrTraining
.goto Stormwind City,52.9,50.9,20 >> Enter the Stormwind Cathedral
step << Paladin
.goto Stormwind City,49.8,48.5,20,0
.goto Stormwind City,38.6,32.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arthur|r or |cRXP_FRIENDLY_Katherine|r
.train 31884 >> Train your class spells
.xp <70,1
.target Arthur the Faithful
.target Katherine the Pure
step << Paladin
#label PaPrTraining
.goto Stormwind City,49.8,48.5,20,0
.goto Stormwind City,38.6,32.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arthur|r or |cRXP_FRIENDLY_Katherine|r
.train 54428 >> Train your class spells
.xp <71,1
.target Arthur the Faithful
.target Katherine the Pure
step << Priest
#label PaPrTraining
.goto Stormwind City,38.5,26.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Joshua|r
.train 25368 >> Train your class spells
.xp <70,1
.target Brother Joshua

step << Hunter
.goto Stormwind City,67.3,37.1,15,0
.goto Stormwind City,67.3,36.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Einris|r
.train 27019 >> Train your class spells
.xp <70,1
.target Einris Brightspear
step << Hunter
.goto Stormwind City,67.3,37.1,15,0
.goto Stormwind City,67.3,36.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Einris|r
.train 49051 >> Train your class spells
.xp <71,1
.target Einris Brightspear
step << skip
.goto Stormwind City,74.6,52.8 << Rogue
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Osborne|r
.train 51724 >> Train your class spells
.xp <71,1
.target Osborne the Night Man

step << Warrior
.goto Stormwind City,77.7,64.3,15,0
.goto Stormwind City,80.1,61.5,15,0
.goto Stormwind City,81.4,59.5,15,0
.goto Stormwind City,78.6,45.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wu|r or |cRXP_FRIENDLY_Ilsa|r
.train 25236 >> Train your class spells
.xp <70,1
.target Wu Shen
.target Ilsa Corbin

]])
RXPGuides.RegisterGuide([[
#version 5
#cata
#Cata
#questguide << !tbc
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 69-70 Shadowmoon Valley (Aldor)
#version 5
#aldor
step
.goto Shattrath City,24.2,29.8
>>Withdraw Marks of Sargeras/Fel Armaments from your bank
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ishanah|r
.accept 10420 >> Accept A Cleansing Light
.turnin 10420 >> Turn in A Cleansing Light


.target Ishanah
step
.goto Shattrath City,30.9,34.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Adyen the Lightwarden|r
.accept 10653 >> Accept Marks of Sargeras
.turnin 10653 >> Turn in Marks of Sargeras
.target Adyen the Lightwarden
step
.goto Shattrath City,64.1,41.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nutral|r
.fly Allerian Stronghold >> Fly to Allerian Stronghold
.target Nutral
step << skip
.goto Terokkar Forest,50.8,54.7
>>Head to the tomb of lights and use the Tomb Relic at the end of the corridor
>>Protect the Tomb Guardian
.turnin 10842 >> Turn in The Vengeful Harbinger
.target Draenei Tomb Guardian
step
#sticky
.zone Shadowmoon Valley >> Head east to Shadowmoon Valley
step
.goto Shadowmoon Valley,39.5,53.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r

.accept 10562 >> Accept Besieged!
.target Wing Commander Nuainn
step
.goto Shadowmoon Valley,40.8,52.3
>>Kill |cRXP_ENEMY_Infernal Attackers|r
.complete 10562,1 
.mob Infernal Attacker
step
.goto Shadowmoon Valley,39.6,53.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r
.turnin 10562 >> Turn in Besieged!
.accept 10563 >> Accept To Legion Hold
.target Wing Commander Nuainn
step
.goto Shadowmoon Valley,38.8,54.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryphonrider Kieran|r
.accept 10569 >> Accept The Sketh'lon Wreckage
.target Gryphonrider Kieran
step << skip
.goto Shadowmoon Valley,38.2,54.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Wanted Poster|r
.accept 10648 >> Accept Wanted: Uvuros, Scourge of Shadowmoon
step
.goto Shadowmoon Valley,37.6,55.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brubeck Stormfoot|r
.fp Wildhammer Stronghold >> Get the Wildhammer Stronghold flight path
.target Brubeck Stormfoot
step
#sticky
.goto Shadowmoon Valley,36.8,54.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zorus the Judicator|r
.accept 10642 >> Accept A Ghost in the Machine
.target Zorus the Judicator
step
.goto Shadowmoon Valley,36.6,55.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gnomus|r
.accept 10661 >> Accept Spleendid!
.target Gnomus
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thane Yoregar|r and |cRXP_FRIENDLY_Earthmender Sophurus|r
.goto Shadowmoon Valley,36.3,57.0
.accept 10703 >> Accept Put On Yer Kneepads...
.accept 10772 >> Accept The Path of Conquest
.accept 10680 >> Accept The Hand of Gul'dan
.target Thane Yoregar
.target Earthmender Sophurus
step
.goto Shadowmoon Valley,37.1,58.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dreg Cloudsweeper|r
.home >> Set your Hearthstone to Wildhammer Stronghold
.target Dreg Cloudsweeper
step << !Shaman
#sticky
#label smv1
.goto Shadowmoon Valley,32.9,40.4,0
>>Kill the |cRXP_ENEMY_Shadowmoon Valley Wildlife|r (Diemetradons don't count)
>>Kill |cRXP_ENEMY_Diemetradons|r. Loot them for their |cRXP_LOOT_Felfire Spleens|r
>>Collect |cRXP_PICK_Ever-burning Ash|r on the ground
.complete 10703,1 
.complete 10642,1 
.complete 10661,1 
.mob Scorchshell Pincer
.mob Felboar
.mob Vilewing Chimaera
.mob Shadow Serpent
.mob Felfire Diemetradon
step << Shaman
#sticky
#label smv1
.goto Shadowmoon Valley,32.9,40.4,0
>>Kill the |cRXP_ENEMY_Shadowmoon Valley Wildlife|r (Diemetradons don't count)
.complete 10703,1 
.mob Scorchshell Pincer
.mob Felboar
.mob Vilewing Chimaera
.mob Shadow Serpent
step
.goto Shadowmoon Valley,23.6,37.0
.use 30638 >>Use the |T132763:0|t[Box o' Tricks] in your bags at the top of the balcony
.complete 10563,1 
step
.hs >> Hearth to Wildhammer Stronghold
step
.goto Shadowmoon Valley,39.5,53.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r
.turnin 10563 >> Turn in To Legion Hold
.accept 10572 >> Accept Setting Up the Bomb
.target Wing Commander Nuainn
step << Shaman
.goto Shadowmoon Valley,29.9,38.1
>>Kill |cRXP_ENEMY_Diemetradons|r. Loot them for their |cRXP_LOOT_Felfire Spleens|r
>>Collect |cRXP_PICK_Ever-burning Ash|r on the ground
.complete 10642,1 
.complete 10661,1 
.mob Felfire Diemetradon
step << !Shaman
#sticky
#completewith next
.use 30756 >>Kill |cRXP_ENEMY_Overseer Ripsaw|r if you see him. Loot him for his |cRXP_LOOT_Shard|r. Click the |T135241:0|t[Illidari-Bane Shard] in your bags
.collect 30756,1,10621
.accept 10621 >>Accept Illidari-Bane Shard
.unitscan Overseer Ripsaw
step << !Shaman
.goto Shadowmoon Valley,22.3,35.6
>>Loot the |cRXP_PICK_Armor Plate|r sorrounded by a green glow
.complete 10572,2 
step << Shaman
#requires smv1
#sticky
#completewith next
.use 30756 >>Kill |cRXP_ENEMY_Overseer Ripsaw|r if you see him. Loot him for his |cRXP_LOOT_Shard|r. Click the |T135241:0|t[Illidari-Bane Shard] in your bags
.collect 30756,1,10621
.accept 10621 >>Accept Illidari-Bane Shard
.unitscan Overseer Ripsaw
step << Shaman
#requires smv1
.goto Shadowmoon Valley,22.3,35.6
>>Loot the |cRXP_PICK_Armor Plate|r sorrounded by a green glow
.complete 10572,2 
step
.goto Shadowmoon Valley,21.5,35.9,30,0
.goto Shadowmoon Valley,26.0,35.5,30,0
.use 30756 >>Kill |cRXP_ENEMY_Overseer Ripsaw|r. Loot him for his |cRXP_LOOT_Shard|r. Click the |T135241:0|t[Illidari-Bane Shard] in your bags
.collect 30756,1,10621
.accept 10621 >>Accept Illidari-Bane Shard
.unitscan Overseer Ripsaw
step
.goto Shadowmoon Valley,26.3,41.2
>>Loot the |cRXP_PICK_Power Core|r at the bottom of the small pond
.complete 10572,1 
step << !Shaman
#requires smv1
.goto Shadowmoon Valley,39.5,53.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r
.turnin 10572 >> Turn in Setting Up the Bomb
.accept 10564 >> Accept Blast the Infernals!
.target Wing Commander Nuainn
step << Shaman
.hs >> Hearth to Wildhammer Stronghold
step << Shaman
.goto Shadowmoon Valley,39.5,53.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r
.turnin 10572 >> Turn in Setting Up the Bomb
.accept 10564 >> Accept Blast the Infernals!
.target Wing Commander Nuainn
step
#sticky
.goto Shadowmoon Valley,36.8,55.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zorus the Judicator|r
.turnin 10642 >> Turn in A Ghost in the Machine
.accept 10643 >> Accept Harbingers of Shadowmoon
.unitscan Zorus the Judicator
step
.goto Shadowmoon Valley,36.6,55.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gnomus|r
.turnin 10661 >> Turn in Spleendid!
.accept 10677 >> Accept The Second Course...
.target Gnomus
step
.goto Shadowmoon Valley,36.9,54.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ordinn Thunderfist|r
.turnin 10621 >> Turn in Illidari-Bane Shard
.target Ordinn Thunderfist
step
.goto Shadowmoon Valley,36.3,57.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thane Yoregar|r
.turnin 10703 >> Turn in Put On Yer Kneepads...
.target Thane Yoregar
step
.goto Shadowmoon Valley,37.2,55.3
.use 30719 >>Equip the |T133149:0|t[Spectrecles] in your bags
>>Kill |cRXP_ENEMY_Shadowmoon Harbingers|r
.complete 10643,1 
.mob Shadowmoon Harbinger
step
.goto Shadowmoon Valley,36.7,55.2
>>|cRXP_WARN_Equip your normal Helmet!|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zorus the Judicator|r
.turnin 10643 >> Turn in Harbingers of Shadowmoon
.accept 10644 >> Accept Teron Gorefiend - Lore and Legend
.unitscan Zorus the Judicator
step
.goto Shadowmoon Valley,42.2,45.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthmender Torlok|r
.turnin 10680 >> Turn in The Hand of Gul'dan
.accept 10458 >> Accept Enraged Spirits of Fire and Earth
.target Earthmender Torlok
step
.goto Shadowmoon Valley,46.7,46.1
.use 30094 >>Use the |T135462:0|t[Totem of Spirits] in your bags and kill |cRXP_ENEMY_Fire Elementals|r and |cRXP_ENEMY_Earth Elementals|r next to the totem
.complete 10458,1 
.complete 10458,2 
.mob Enraged Fire Spirit
.mob Enraged Earth Spirit
step
.goto Shadowmoon Valley,42.1,45.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthmender Torlok|r
.turnin 10458 >> Turn in Enraged Spirits of Fire and Earth
.accept 10480 >> Accept Enraged Spirits of Water
.target Earthmender Torlok
step
.goto Shadowmoon Valley,38.0,32.1
>>Kill |cRXP_ENEMY_Dark Conclave Hawkeyes|r, |cRXP_ENEMY_Ravenguards|r and |cRXP_ENEMY_Shadowmancers|r. Loot them for their |cRXP_LOOT_Journals|r
.complete 10569,1 
.complete 10569,2 
.complete 10569,3 
.mob Dark Conclave Hawkeye
.mob Dark Conclave Ravenguard
.mob Dark Conclave Shadowmancer
step
#sticky
#completewith gizzard
.goto Shadowmoon Valley,51.4,27.5,0
>>Kill |cRXP_ENEMY_Greater Felfire Diemetradons|r around the lava streams in the eastern part of the zone
.complete 10677,1 
>>This quest has a super low drop rate, if you don't get it on your first few kills, skip this step
.mob Greater Felfire Diemetradon
step
.goto Shadowmoon Valley,51.4,27.5
.use 30094 >>Use the |T135462:0|t[Totem of Spirits] in your bags and kill |cRXP_ENEMY_Water Elementals|r next to the totem
.complete 10480,1 
.mob Enraged Water Spirit
step
.goto Shadowmoon Valley,61.2,29.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Exarch Onaala|r and |cRXP_FRIENDLY_Vindicator Aluumen|r
.accept 10619 >> Accept The Ashtongue Tribe
.accept 10587 >> Accept Karabor Training Grounds
.target Exarch Onaala
.target Vindicator Aluumen
step
.goto Shadowmoon Valley,62.6,28.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Ceyla|r
.accept 10568 >> Accept Tablets of Baa'ri
.target Anchorite Ceyla
step
.goto Shadowmoon Valley,63.3,30.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maddix|r
.fp Altar of Sha'tar >> Get the Altar of Sha'tar flight path
.target Maddix
step
.goto Shadowmoon Valley,60.0,35.6
>>Kill the |cRXP_ENEMY_Ashtongues|r. Loot |cRXP_PICK_Baa'ri Fragments|r in the area
.complete 10568,1 
.complete 10619,1 
.complete 10619,2 
.complete 10619,3 
.mob Ashtongue Handler
.mob Ashtongue Warrior
.mob Ashtongue Shaman
step
.goto Shadowmoon Valley,61.3,29.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vindicator Aluumen|r
.turnin 10619 >> Turn in The Ashtongue Tribe
.accept 10816 >> Accept Reclaiming Holy Grounds
.target Vindicator Aluumen
step
.goto Shadowmoon Valley,62.5,28.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Ceyla|r
.turnin 10568 >> Turn in Tablets of Baa'ri
.accept 10571 >> Accept Oronu the Elder
.target Anchorite Ceyla
step
.goto Shadowmoon Valley,57.2,33.0
>>Kill |cRXP_ENEMY_Oronu|r at top of the balcony
.complete 10571,1 
.mob Oronu the Elder
step
.goto Shadowmoon Valley,62.5,28.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Ceyla|r
.turnin 10571 >> Turn in Oronu the Elder
.accept 10574 >> Accept The Ashtongue Corruptors
.target Anchorite Ceyla
step << !Shaman
#completewith next
.goto Shadowmoon Valley,63.3,30.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maddix|r
.fly Wildhammer Stronghold >> Fly to Wildhammer Stronghold
.target Maddix
step << Shaman
.hs Wildhammer Stronghold >> Hearth to Wildhammer Stronghold
step
#label gizzard
.isQuestComplete 10677
.goto Shadowmoon Valley,36.5,55.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gnomus|r
.turnin 10677 >> Turn in The Second Course...
.target Gnomus
step
.goto Shadowmoon Valley,36.5,55.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gnomus|r
.accept 10678 >> Accept The Main Course!
.isQuestTurnedIn 10677
.target Gnomus
step
.goto Shadowmoon Valley,38.8,54.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryphonrider Kieran|r
.turnin 10569 >> Turn in The Sketh'lon Wreckage
.accept 10759 >> Accept Find the Deserter
.target Gryphonrider Kieran
step
.goto Shadowmoon Valley,35.3,39.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Parshah|r. He patrols up and down the road
.turnin 10759 >> Turn in Find the Deserter
.accept 10777 >> Accept Asghar's Totem
.unitscan Parshah
step
.goto Shadowmoon Valley,39.7,29.7
>>Kill |cRXP_ENEMY_Asghar|r. Loot him for his |cRXP_LOOT_Totem|r
.complete 10777,1 
.mob Asghar
step
.goto Shadowmoon Valley,35.3,39.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Parshah|r. He patrols up and down the road
.turnin 10777 >> Turn in Asghar's Totem
.accept 10778 >> Accept The Rod of Lianthe
.unitscan Parshah
step
.goto Shadowmoon Valley,42.2,45.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthmender Torlok|r
.turnin 10480 >> Turn in Enraged Spirits of Water
.accept 10481 >> Accept Enraged Spirits of Air
.target Earthmender Torlok
step
.goto Shadowmoon Valley,52.17,58.45
>>Run up the hill and slowly move forward until you complete the quest objective
.complete 10772,1
step
.goto Shadowmoon Valley,51.0,59.1
.use 31310 >>Use the |T135619:0|t[Wildhammer Flare Gun] in your bags at the waypoint location to summon a |cRXP_FRIENDLY_Wildhammer Gryphon Rider|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Wildhammer Gryphon Rider|r
.turnin 10772 >> Turn in The Path of Conquest
.accept 10773 >> Accept Breaching the Path
.target Wildhammer Gryphon Rider
step
.goto Shadowmoon Valley,47.5,71.7
>>Kill |cRXP_ENEMY_Eclipsion Archmages|r, |cRXP_ENEMY_Bloodwarders|r and |cRXP_ENEMY_Centurions|r
.complete 10778,1 
>>Open the chest at the back of the camp
.complete 10778,2 
.mob Eclipsion Archmage
.mob Eclipsion Bloodwarder
.mob Eclipsion Centurion
step
#sticky
#label air
.goto Shadowmoon Valley,62.7,62.1,60,0
.use 30094 >>Use the |T135462:0|t[Totem of Spirits] in your bags and kill |cRXP_ENEMY_Air Elementals|r next to the totem
.complete 10481,1 
.mob Enraged Air Spirit
step
.goto Shadowmoon Valley,58.2,70.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Ancient Shadowmoon Spirit|r
.turnin 10644 >> Turn in Teron Gorefiend - Lore and Legend

.accept 10635 >> Accept Divination: Gorefiend's Cloak
.accept 10636 >> Accept Divination: Gorefiend's Truncheon
.target Ancient Shadowmoon Spirit
step
.goto Shadowmoon Valley,57.1,73.6
>>Destroy the totems protecting |cRXP_ENEMY_Haalum|r. Kill and loot him for his |cRXP_LOOT_Medallion Fragment|r
.complete 10574,2 
.mob Haalum
step
#requires air
#sticky
>>Whenever you are traveling through the main road, equip your |T133149:0|t[Spectrecles] to look for the |cRXP_ENEMY_Ghostrider of Karabor|r. They patrol the zone in a counter-clockwise direction
>>Loot them for |cRXP_LOOT_Gorefiend's Truncheon|r
.complete 10636,1
.mob Ghostrider of Karabor
step
#requires air
.goto Shadowmoon Valley,56.1,44.3
>>Kill |cRXP_ENEMY_Felspine the Greater|r. Loot him for |cRXP_LOOT_Felspine's Hide|r
.complete 10678,1 
.isOnQuest 10678
.mob Felspine the Greater
step
.goto Shadowmoon Valley,51.1,52.9
>>Destroy the totems protecting |cRXP_ENEMY_Eykenen|r. Kill and loot him for his |cRXP_LOOT_Medallion Fragment|r
.complete 10574,1 
.mob Eykenen
step
.goto Shadowmoon Valley,42.2,45.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthmender Torlok|r
.turnin 10481 >> Turn in Enraged Spirits of Air
.accept 10513 >> Accept Oronok Torn-heart
.target Earthmender Torlok
step
.goto Shadowmoon Valley,35.2,40.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Parshah|r. He patrols up and down the road
.turnin 10778 >> Turn in The Rod of Lianthe
.accept 10780 >> Accept Sketh'lon Feathers
.unitscan Parshah
step
.goto Shadowmoon Valley,22.7,39.9
.use 30614 >>Use the |T133013:0|t[Fel Bomb] in your bags at the green circle on the ground
.complete 10564,1 
step
.hs >> Hearth to Wildhammer Stronghold
step
.goto Shadowmoon Valley,39.5,53.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r
.turnin 10564 >> Turn in Blast the Infernals!
.accept 10573 >> Accept The Deathforge
.target Wing Commander Nuainn
step
.goto Shadowmoon Valley,40.5,41.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stormer Ewan Wildwing|r
.turnin 10573 >> Turn in The Deathforge
.accept 10582 >> Accept Minions of the Shadow Council
.target Stormer Ewan Wildwing
step
#completewith next
.goto Shadowmoon Valley,40.16,38.23,15 >> Enter The Deathforge from the northern entrance
step
.goto Shadowmoon Valley,40.3,38.1
>>Kill |cRXP_ENEMY_Deathforge Guardians|r and |cRXP_ENEMY_Summoners|r
.complete 10582,1 
.complete 10582,2 
.mob Deathforge Guardian
.mob Deathforge Summoner
step
.goto Shadowmoon Valley,40.5,41.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stormer Ewan Wildwing|r
.turnin 10582 >> Turn in Minions of the Shadow Council
.accept 10583 >> Accept The Fate of Flanis
.accept 10585 >> Accept The Summoning Chamber
.target Stormer Ewan Wildwing
step
#completewith next
.goto Shadowmoon Valley,40.16,38.23,15 >> Enter The Deathforge from the northern entrance
step
.goto Shadowmoon Valley,34.7,39.9
>>Kill |cRXP_ENEMY_Deathforge Smiths|r and |cRXP_ENEMY_Deathforge Tinkerers|r. Loot them for the |cRXP_LOOT_Elemental Displacer|r
.complete 10585,2 
>>Click on the dead dwarf at the end of the corridor for |cRXP_PICK_Flanis's Pack|r
.complete 10583,1 
.mob Deathforge Smith
.mob Deathforge Tinkerer
step
.goto Shadowmoon Valley,37.8,38.3
.use 30672>>Jump down the bridge and use the |T135470:0|t[Elemental Displacer] in your bags at the summoning spot
.complete 10585,1 
step
.goto Shadowmoon Valley,40.4,41.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stormer Ewan Wildwing|r
.turnin 10583 >> Turn in The Fate of Flanis
.turnin 10585 >> Turn in The Summoning Chamber
.accept 10586 >> Accept Bring Down the Warbringer!
.target Stormer Ewan Wildwing
step
.goto Shadowmoon Valley,39.0,46.7
>>Enter The Shadowforge through the top entrance and go through the locked gate
>>Kill |cRXP_ENEMY_Warbringer Razuun|r. Loot him for |cRXP_LOOT_Razuun's Orders|r
.complete 10586,1 
.complete 10586,2 
.mob Warbringer Razuun
step
.goto Shadowmoon Valley,48.3,39.5
>>Destroy the totems protecting |cRXP_ENEMY_Uylaru|r. Kill and loot him for his |cRXP_LOOT_Medallion Fragment|r
.complete 10574,4 
.mob Uylaru
step
.goto Shadowmoon Valley,49.9,23.0
>>Destroy the totems protecting |cRXP_ENEMY_Lakaan|r. Kill and loot him for his |cRXP_LOOT_Medallion Fragment|r
.complete 10574,3 
.mob Lakaan
step
.goto Shadowmoon Valley,54.0,23.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oronok Torn-heart|r
.turnin 10513 >> Turn in Oronok Torn-heart
.accept 10514 >> Accept I Was A Lot Of Things...
.target Oronok Torn-heart
step
.goto Shadowmoon Valley,54.0,16.0
.use 30462 >>Stand on top of the small plants on the ground and use |T132161:0|t[Oronok's Boar Whistle] to have a nearby boars dig out the tubers
.complete 10514,1 
step
.goto Shadowmoon Valley,53.9,23.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oronok Torn-heart|r
.turnin 10514 >> Turn in I Was A Lot Of Things...
.accept 10515 >> Accept A Lesson Learned
.target Oronok Torn-heart
step
.goto Shadowmoon Valley,56.6,17.0
>>Destroy the |cRXP_ENEMY_Ravenous Flayer Eggs|r by right clicking them. Watch out for the elite that patrols around
.complete 10515,1 
step
.goto Shadowmoon Valley,53.9,23.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oronok Torn-heart|r
.turnin 10515 >> Turn in A Lesson Learned
.accept 10519 >> Accept The Cipher of Damnation - Truth and History
.complete 10519,1 
.skipgossip
.target Oronok Torn-heart
step
.goto Shadowmoon Valley,53.9,23.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oronok Torn-heart|r
.turnin 10519 >> Turn in The Cipher of Damnation - Truth and History
.accept 10521 >> Accept Grom'tor, Son of Oronok
.accept 10527 >> Accept Ar'tor, Son of Oronok
.accept 10546 >> Accept Borak, Son of Oronok
.target Oronok Torn-heart
step
.goto Shadowmoon Valley,62.5,28.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anchorite Ceyla|r
.turnin 10574 >> Turn in The Ashtongue Corruptors
.accept 10575 >> Accept The Warden's Cage
.target Anchorite Ceyla
step << !Shaman
#completewith next
.goto Shadowmoon Valley,63.3,30.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maddix|r
.fly Wildhammer Stronghold >> Fly to Wildhammer Stronghold
.target Maddix
step << Shaman
.hs >> Hearth to Wildhammer Stronghold
step
.goto Shadowmoon Valley,36.6,55.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gnomus|r
.turnin 10678 >> Turn in The Main Course!
.isOnQuest 10678
.target Gnomus
step
.goto Shadowmoon Valley,39.5,53.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r
.turnin 10586 >> Turn in Bring Down the Warbringer!
.accept 10589 >> Accept Gaining Access
.target Wing Commander Nuainn
step
.goto Shadowmoon Valley,47.5,57.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Borak, Son of Oronok|r
.turnin 10546 >> Turn in Borak, Son of Oronok
.accept 10547 >> Accept Of Thistleheads and Eggs...
.target Borak, Son of Oronok
step
.goto Shadowmoon Valley,43.5,57.4
>>Loot the |cRXP_PICK_Sketh'lon Feathers|r on the ground
.complete 10780,1 
>>Loot the |cRXP_PICK_Rotten Eggs|r on the ground. Be careful because they can damage you upon looting
.complete 10547,1 
step
.goto Shadowmoon Valley,35.2,40.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Parshah|r. He patrols up and down the road
.turnin 10780 >> Turn in Sketh'lon Feathers
.accept 10782 >> Accept Imbuing the Headpiece
.unitscan Parshah
step
.goto Shadowmoon Valley,42.8,45.0
.use 31360 >>Equip the |T135160:0|t[Unfinished Headpiece] trinket and use it at the center of the altar
.complete 10782,1 
step
.goto Shadowmoon Valley,35.2,40.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Parshah|r. He patrols up and down the road
.turnin 10782 >> Turn in Imbuing the Headpiece
.accept 10808 >> Accept Thwart the Dark Conclave
.unitscan Parshah
step
.goto Shadowmoon Valley,24.7,36.4
>>Kill |cRXP_ENEMY_Mo'arg Weaponsmiths|r. Loot them for the |cRXP_LOOT_Legion Teleporter Control|r
.complete 10589,1 
.mob Mo'arg Weaponsmith
step
.goto Shadowmoon Valley,29.6,50.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Spirit of Ar'tor|r
.turnin 10527 >> Turn in Ar'tor, Son of Oronok
.accept 10528 >> Accept Demonic Crystal Prisons
.target Ar'tor, Son of Oronok
step
.goto Shadowmoon Valley,28.0,47.7
>>Kill |cRXP_ENEMY_Painmistress Gabrissa|r. Loot her for the |cRXP_LOOT_Crystalline Key|r
.complete 10528,1 
.mob Painmistress Gabrissa
step
.goto Shadowmoon Valley,29.6,50.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Spirit of Ar'tor|r
.turnin 10528 >> Turn in Demonic Crystal Prisons
.accept 10537 >> Accept Lohn'goron, Bow of the Torn-heart
.target Ar'tor, Son of Oronok
step
.goto Shadowmoon Valley,30.5,50.0
>>Kill the |cRXP_ENEMY_Illidari|r. Loot them for the |cRXP_LOOT_Bow|r
.complete 10537,1 
.mob Illidari Dreadbringer
.mob Illidari Painlasher
.mob Illidari Shadowstalker
.mob Illidari Shocktrooper
step
.goto Shadowmoon Valley,29.5,50.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Spirit of Ar'tor|r
.turnin 10537 >> Turn in Lohn'goron, Bow of the Torn-heart
.accept 10540 >> Accept The Cipher of Damnation - Ar'tor's Charge
.target Spirit of Ar'tor
step
.goto Shadowmoon Valley,29.5,57.5
>>Head southeast while |cRXP_FRIENDLY_Ar'tor's|r spirit is following you, walk around this area until |cRXP_FRIENDLY_Spirit of Ar'tor|r summons |cRXP_ENEMY_Veneratus the Many|r
.complete 10540,1 
>>Be ready for a long fight, |cRXP_ENEMY_Veneratus the Many|r has 3 times more health than a normal mob
>>Kill |cRXP_ENEMY_Veneratus the Many|r
.mob Veneratus the Many
.target Spirit of Ar'tor
step
.goto Shadowmoon Valley,29.5,50.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Spirit of Ar'tor|r
.turnin 10540 >> Turn in The Cipher of Damnation - Ar'tor's Charge
.accept 10541 >> Accept The Cipher of Damnation - The Second Fragment Recovered
.target Spirit of Ar'tor
step
.goto Shadowmoon Valley,39.5,53.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r
.turnin 10589 >> Turn in Gaining Access
.accept 10766 >> Accept Invasion Point: Cataclysm
.target Wing Commander Nuainn
step
.goto Shadowmoon Valley,40.7,60.1
.use 31386 >>Use the |T135225:0|t[Staff of Parshah] in your bags to stop the ritual
.complete 10808,1 
step
.goto Shadowmoon Valley,35.2,40.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Parshah|r. He patrols up and down the road
.turnin 10808 >> Turn in Thwart the Dark Conclave
.unitscan Parshah
step
.goto Shadowmoon Valley,25.5,36.3,50 >>Enter the Legion Hold teleporter
step
.goto Shadowmoon Valley,40.9,22.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Plexi|r
.turnin 10766 >> Turn in Invasion Point: Cataclysm
.accept 10606 >> Accept The Art of Fel Reaver Maintenance
.target Plexi
step
.goto Shadowmoon Valley,39.4,19.6
>>Kill |cRXP_ENEMY_Doctor Gutrick|r. Loot his chest for |cRXP_LOOT_The Art of Fel Reaver Maintenance|r
.complete 10606,2
.complete 10606,1 
.mob Doctor Gutrick
step
.goto Shadowmoon Valley,40.8,22.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Plexi|r
.turnin 10606 >> Turn in The Art of Fel Reaver Maintenance
.accept 10612 >> Accept The Fel and the Furious
.target Plexi
step
.goto Shadowmoon Valley,40.8,21.7
>>Dismiss your pet << Hunter/Warlock
>>Use the console to control a |cRXP_FRIENDLY_Fel Reaver|r and use it to destroy the |cRXP_ENEMY_Infernals|r
.complete 10612,1 
.mob Deathforged Infernal
step
.goto Shadowmoon Valley,40.8,22.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Plexi|r
.turnin 10612 >> Turn in The Fel and the Furious
.accept 10744 >> Accept News of Victory
.target Plexi
step
.goto Shadowmoon Valley,44.6,23.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grom'tor, Son of Oronok|r
.turnin 10521 >> Turn in Grom'tor, Son of Oronok
.accept 10522 >> Accept The Cipher of Damnation - Grom'tor's Charge
.target Grom'tor, Son of Oronok
step
.goto Shadowmoon Valley,46.0,28.2
>>Kill |cRXP_ENEMY_Coilskar Nagas|r. Loot them for their |cRXP_LOOT_Coilskar Chest Keys|r
>>Open the chests until you loot the |cRXP_PICK_First Fragment of the Cipher of Damnation|r
.complete 10522,1 
.mob Coilskar Defender
.mob Coilskar Muckwatcher
.mob Coilskar Myrmidon
.mob Coilskar Siren
.mob Coilskar Sorceress
.mob Coilskar Waterkeeper
step
.goto Shadowmoon Valley,44.6,23.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grom'tor, Son of Oronok|r
.turnin 10522 >> Turn in The Cipher of Damnation - Grom'tor's Charge
.accept 10523 >> Accept The Cipher of Damnation - The First Fragment Recovered
.target Grom'tor, Son of Oronok
step
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maddix|r or |cRXP_FRIENDLY_Brubeck Stormfoot|r
>>|cRXP_WARN_The arrow will point you to the closest Flight Master|r
.fly Shattrath >> Fly to Shattrath City
.goto Shadowmoon Valley,37.6,55.3,-1
.goto Shadowmoon Valley,63.3,30.4,-1
.target Maddix
.target Brubeck Stormfoot
step
.goto Shattrath City,64.1,69.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tobias the Filth Gorger|r
.turnin 10547 >> Turn in Of Thistleheads and Eggs...
.accept 10550 >> Accept The Bundle of Bloodthistle
.target Tobias the Filth Gorger
step
#completewith next
.hs >> Hearth to Wildhammer Stronghold
step
.goto Shadowmoon Valley,35.7,57.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kurdran Wildhammer|r
.turnin 10744 >> Turn in News of Victory
.target Kurdran Wildhammer
step
.goto Shadowmoon Valley,47.5,57.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Borak, Son of Oronok|r
.turnin 10550 >> Turn in The Bundle of Bloodthistle
.accept 10570 >> Accept To Catch A Thistlehead
.target Borak, Son of Oronok
step
.goto Shadowmoon Valley,48.9,57.4
.use 30616 >>Plant the |T133651:0|t[Bundle of Bloodthistle] in your bags at the end of the bridge
.complete 10570,1 
step
.goto Shadowmoon Valley,47.6,57.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Borak, Son of Oronok|r
.turnin 10570 >> Turn in To Catch A Thistlehead
.accept 10576 >> Accept The Shadowmoon Shuffle
.target Borak, Son of Oronok
step
.goto Shadowmoon Valley,49.6,62.2
>>Kill |cRXP_ENEMY_Eclipsions|r. Loot them for their |cRXP_LOOT_Armor|r
.complete 10576,1 
.mob Eclipsion Archmage
.mob Eclipsion Blood Knight
.mob Eclipsion Bloodwarder
.mob Eclipsion Centurion
step
.goto Shadowmoon Valley,47.6,57.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Borak, Son of Oronok|r
.turnin 10576 >> Turn in The Shadowmoon Shuffle
.accept 10577 >> Accept What Illidan Wants, Illidan Gets...
.target Borak, Son of Oronok
step
.goto Shadowmoon Valley,46.5,71.9
.use 30639 >>Use the |T133564:0|t[Blood Elf Disguise] in your bags
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grand Commander Ruusk|r
.skipgossip
.target Grand Commander Ruusk
.complete 10577,1 
step
.goto Shadowmoon Valley,47.5,57.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Borak, Son of Oronok|r
.turnin 10577 >> Turn in What Illidan Wants, Illidan Gets...
.accept 10578 >> Accept The Cipher of Damnation - Borak's Charge
.target Borak, Son of Oronok
step
#completewith next
.goto Shadowmoon Valley,37.6,55.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brubeck Stormfoot|r
.fly the Altar of Sha'tar >> Fly to the Altar of Sha'tar
.target Brubeck Stormfoot
step
.goto Shadowmoon Valley,64.5,39.9
>>Equip your |T133149:0|t[Spectrecles] in your bags
>>Kill |cRXP_ENEMY_Clerics of Karabor|r. Loot them for |cRXP_LOOT_Gorefiend's Cloak|r
.complete 10635,1 
.mob Cleric of Karabor
step << Druid/70
.goto Shadowmoon Valley,67.3,38.2
>>Kill |cRXP_ENEMY_Shadowmoon Slayers|r, |cRXP_ENEMY_Darkweavers|r and |cRXP_ENEMY_Chosen|r
>>Skip this quest if you don't have a flying mount
.complete 10816,1 
.complete 10816,2 
.complete 10816,3 
.mob Shadowmoon Slayer
.mob Shadowmoon Chosen
.mob Shadowmoon Darkweaver
step << Druid/70
.goto Shadowmoon Valley,67.6,36.2
.use 31239 >>Kill |cRXP_ENEMY_Smith Gorlunk|r. Loot him for his |cRXP_LOOT_Key Mold|r. Click the |T134459:0|t[Primed Key Mold] in your bags
>>Skip this quest if you don't have a flying mount
.collect 31239,1,10754 
.accept 10754 >> Accept Entry Into the Citadel
.unitscan Smith Gorlunk
step << Druid/70
.goto Shadowmoon Valley,68.8,49.2
>>Kill |cRXP_ENEMY_Demon Hunter Initiates|r and |cRXP_ENEMY_Demon Hunter Supplicants|r. Loot them for their |cRXP_LOOT_Sunfury Glaives|r
>>Skip this quest if you don't have a flying mount
.complete 10587,1 
.mob Demon Hunter Supplicant
.mob Demon Hunter Initiate
step << Druid/70
.goto Shadowmoon Valley,61.2,29.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Exarch Onaala|r and |cRXP_FRIENDLY_Vindicator Aluumen|r
.turnin 10587 >> Turn in Karabor Training Grounds
.accept 10637 >> Accept A Necessary Distraction
.turnin 10816 >> Turn in Reclaiming Holy Grounds
.target Exarch Onaala
.target Vindicator Aluumen
step << Druid/70
.goto Shadowmoon Valley,69.7,51.3
>>Kill |cRXP_ENEMY_Sunfury Warlocks|r. Loot them for the |cRXP_LOOT_Scroll of Demonic Unbanishing|r
.use 30811 >> Use the |T134937:0|t[Scroll of Demonic Unbanishing] on |cRXP_ENEMY_Azaloth|r
.collect 30811,1 
.complete 10637,1 
.mob Sunfury Warlock
.mob Azaloth
step
.goto Shadowmoon Valley,57.3,49.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sanoru|r
.turnin 10575 >> Turn in The Warden's Cage
.accept 10622 >> Accept Proof of Allegiance
.target Sanoru
step
.goto Shadowmoon Valley,57.8,50.3
>>Kill |cRXP_ENEMY_Zandras|r
.complete 10622,1 
.mob Zandras
step
.goto Shadowmoon Valley,57.4,49.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sanoru|r
.turnin 10622 >> Turn in Proof of Allegiance
.accept 10628 >> Accept Akama
.target Sanoru
step
.goto Shadowmoon Valley,58.1,48.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Akama|r
.turnin 10628 >> Turn in Akama
.accept 10705 >> Accept Seer Udalo
.target Akama
step
>>Equip your |T133149:0|t[Spectrecles] to look for the |cRXP_ENEMY_Ghostriders of Karabor|r. They patrol along the main road. Loot them for |cRXP_LOOT_Gorefiend's Truncheon|r
.complete 10636,1 
.mob Ghostrider of Karabor
step
.goto Shadowmoon Valley,58.2,70.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Ancient Shadowmoon Spirit|r
.turnin 10635 >> Turn in Divination: Gorefiend's Cloak
.turnin 10636 >> Turn in Divination: Gorefiend's Truncheon
.target Ancient Shadowmoon Spirit
step << Druid/70
.goto Shadowmoon Valley,61.2,29.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Exarch Onaala|r
.turnin 10637 >> Turn in A Necessary Distraction
.accept 10640 >> Accept Altruis
.target Exarch Onaala
]])
RXPGuides.RegisterGuide([[
#version 5
#cata
#Cata
#questguide << !tbc
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 69-70 Shadowmoon Valley (Scryer)
#version 5
#scryer
step
.goto Shattrath City,45.29,81.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Magistrix Fyalenn|r
.accept 10656 >>Accept Sunfury Signets
.turnin 10656 >>Turn in Sunfury Signets
.target Magistrix Fyalenn
step
.goto Shattrath City,42.89,91.71
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Voren'thal the Seer|r
.accept 10416 >>Accept Synthesis of Power
.turnin 10416 >>Turn in Synthesis of Power
.target Voren'thal the Seer
step
.goto Shattrath City,64.1,41.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nutral|r
.fly Allerian Stronghold >> Fly to Allerian Stronghold
.target Nutral
step << skip
.goto Terokkar Forest,50.8,54.7
>>Head to the tomb of lights and use the Tomb Relic at the end of the corridor
>>Protect the Tomb Guardian
.turnin 10842 >> Turn in The Vengeful Harbinger
.target Draenei Tomb Guardian
step
#sticky
.zone Shadowmoon Valley >> Head east to Shadowmoon Valley
step
.goto Shadowmoon Valley,39.5,53.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r

.accept 10562 >> Accept Besieged!
.target Wing Commander Nuainn
step
.goto Shadowmoon Valley,38.8,54.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryphonrider Kieran|r
.accept 10569 >> Accept The Sketh'lon Wreckage
.target Gryphonrider Kieran
step
.goto Shadowmoon Valley,38.2,54.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Wanted Poster|r
.accept 10648 >> Accept Wanted: Uvuros, Scourge of Shadowmoon
step
.goto Shadowmoon Valley,37.6,55.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brubeck Stormfoot|r
.fp Wildhammer Stronghold >> Get the Wildhammer Stronghold flight path
.target Brubeck Stormfoot
step
#sticky
.goto Shadowmoon Valley,36.8,54.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zorus the Judicator|r
.accept 10642 >> Accept A Ghost in the Machine
.target Zorus the Judicator
step
.goto Shadowmoon Valley,36.6,55.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gnomus|r
.accept 10661 >> Accept Spleendid!
.target Gnomus
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thane Yoregar|r and |cRXP_FRIENDLY_Earthmender Sophurus|r
.goto Shadowmoon Valley,36.3,57.0
.accept 10703 >> Accept Put On Yer Kneepads...
.accept 10772 >> Accept The Path of Conquest
.accept 10680 >> Accept The Hand of Gul'dan
.target Thane Yoregar
.target Earthmender Sophurus
step
.goto Shadowmoon Valley,37.1,58.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dreg Cloudsweeper|r
.home >> Set your Hearthstone to Wildhammer Stronghold
.target Dreg Cloudsweeper
step
.goto Shadowmoon Valley,40.8,52.3
>>Kill |cRXP_ENEMY_Infernal Attackers|r
.complete 10562,1 
.mob Infernal Attacker
step
.goto Shadowmoon Valley,39.6,53.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r
.turnin 10562 >> Turn in Besieged!
.accept 10563 >> Accept To Legion Hold
.target Wing Commander Nuainn
step
#sticky
#label smv1
.goto Shadowmoon Valley,32.9,40.4,0
>>Kill the |cRXP_ENEMY_Shadowmoon Valley Wildlife|r (Diemetradons don't count)
.complete 10703,1 
>>Kill |cRXP_ENEMY_Diemetradons|r. Loot them for their |cRXP_LOOT_Felfire Spleens|r
>>Collect |cRXP_PICK_Ever-burning Ash|r on the ground
.complete 10642,1 
.complete 10661,1 
.mob Scorchshell Pincer
.mob Felboar
.mob Vilewing Chimaera
.mob Shadow Serpent
.mob Felfire Diemetradon
step
.goto Shadowmoon Valley,23.6,37.0
.use 30638 >>Use the |T132763:0|t[Box o' Tricks] in your bags at the top of the balcony
.complete 10563,1 
step
.goto Shadowmoon Valley,39.5,53.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r
.turnin 10563 >> Turn in To Legion Hold
.accept 10572 >> Accept Setting Up the Bomb
.target Wing Commander Nuainn
step
.goto Shadowmoon Valley,22.3,35.6
>>Loot the |cRXP_PICK_Armor Plate|r sorrounded by a green glow
.complete 10572,2 
step
.use 30756 >>Kill |cRXP_ENEMY_Overseer Ripsaw|r. Loot him for his |cRXP_LOOT_Shard|r. Click the |T135241:0|t[Illidari-Bane Shard] in your bags
.collect 30756,1,10621
.accept 10621 >>Accept Illidari-Bane Shard
.unitscan Overseer Ripsaw
step
.goto Shadowmoon Valley,26.3,41.2
>>Loot the |cRXP_PICK_Power Core|r at the bottom of the small pond
.complete 10572,1 
step
#requires smv1
.goto Shadowmoon Valley,39.5,53.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r
.turnin 10572 >> Turn in Setting Up the Bomb
.accept 10564 >> Accept Blast the Infernals!
.target Wing Commander Nuainn
step
#sticky
.goto Shadowmoon Valley,36.8,55.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zorus the Judicator|r
.turnin 10642 >> Turn in A Ghost in the Machine
.accept 10643 >> Accept Harbingers of Shadowmoon
.unitscan Zorus the Judicator
step
.goto Shadowmoon Valley,36.6,55.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gnomus|r
.turnin 10661 >> Turn in Spleendid!
.accept 10677 >> Accept The Second Course...
.target Gnomus
step
.goto Shadowmoon Valley,36.9,54.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ordinn Thunderfist|r
.turnin 10621 >> Turn in Illidari-Bane Shard
.target Ordinn Thunderfist
step
.goto Shadowmoon Valley,36.3,57.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thane Yoregar|r
.turnin 10703 >> Turn in Put On Yer Kneepads...
.target Thane Yoregar
step
.goto Shadowmoon Valley,37.2,55.3
.use 30719 >>Equip the |T133149:0|t[Spectrecles] in your bags
>>Kill |cRXP_ENEMY_Shadowmoon Harbingers|r
.complete 10643,1 
.mob Shadowmoon Harbinger
step
.goto Shadowmoon Valley,36.7,55.2
>>|cRXP_WARN_Equip your normal Helmet!|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zorus the Judicator|r
.turnin 10643 >> Turn in Harbingers of Shadowmoon
.accept 10644 >> Accept Teron Gorefiend - Lore and Legend
.unitscan Zorus the Judicator
step
.goto Shadowmoon Valley,42.2,45.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthmender Torlok|r
.turnin 10680 >> Turn in The Hand of Gul'dan
.accept 10458 >> Accept Enraged Spirits of Fire and Earth
.target Earthmender Torlok
step
.goto Shadowmoon Valley,46.7,46.1
.use 30094 >>Use the |T135462:0|t[Totem of Spirits] in your bags and kill |cRXP_ENEMY_Fire Elementals|r and |cRXP_ENEMY_Earth Elementals|r next to the totem
.complete 10458,1 
.complete 10458,2 
.mob Enraged Fire Spirit
.mob Enraged Earth Spirit
step
.goto Shadowmoon Valley,42.1,45.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthmender Torlok|r
.turnin 10458 >> Turn in Enraged Spirits of Fire and Earth
.accept 10480 >> Accept Enraged Spirits of Water
.target Earthmender Torlok
step
.goto Shadowmoon Valley,52.17,58.45
>>Run up the hill and slowly move forward until you complete the quest objective
.complete 10772,1
step
.goto Shadowmoon Valley,51.0,59.1
.use 31310 >>Use the |T135619:0|t[Wildhammer Flare Gun] in your bags at the waypoint location to summon a |cRXP_FRIENDLY_Wildhammer Gryphon Rider|r
.turnin 10772 >> Turn in The Path of Conquest
.accept 10773 >> Accept Breaching the Path
.target Wildhammer Gryphon Rider
step
.goto Shadowmoon Valley,54.7,58.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Varen the Reclaimer|r
.accept 10807 >> Accept The Ashtongue Broken
.target Varen the Reclaimer
step
.goto Shadowmoon Valley,56.3,57.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alieshor|r
.fp Sanctum of the Stars >> Get the Sanctum of the Stars flight path
.target Alieshor
step
.goto Shadowmoon Valley,55.8,58.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Larissa Sunstrike|r
.accept 10687 >> Accept Karabor Training Grounds
.target Larissa Sunstrike
step
.goto Shadowmoon Valley,56.3,59.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arcanist Thelis|r
.accept 10683 >> Accept Tablets of Baa'ri
.target Arcanist Thelis
step
.goto Shadowmoon Valley,60.0,35.6
>>Kill the |cRXP_ENEMY_Ashtongues|r. Loot |cRXP_PICK_Baa'ri Fragments|r in the area
.complete 10683,1 
.complete 10807,1 
.complete 10807,2 
.complete 10807,3 
.mob Ashtongue Handler
.mob Ashtongue Warrior
.mob Ashtongue Shaman
step
#sticky
#completewith gizzard
.goto Shadowmoon Valley,51.4,27.5,0
>>Kill |cRXP_ENEMY_Greater Felfire Diemetradons|r around the lava streams in the eastern part of the zone
.complete 10677,1 
>>This quest has a super low drop rate. If you don't get it on your first few kills, skip this step
.mob Greater Felfire Diemetradon
step
.goto Shadowmoon Valley,49.7,24.2
.use 30094 >>Use the |T135462:0|t[Totem of Spirits] in your bags and kill |cRXP_ENEMY_Water Elementals|r next to the totem
.complete 10480,1 
.mob Enraged Water Spirit
step
.goto Shadowmoon Valley,38.8,31.6
>>Kill |cRXP_ENEMY_Dark Conclave Hawkeyes|r, |cRXP_ENEMY_Ravenguards|r and |cRXP_ENEMY_Shadowmancers|r. Loot them for their |cRXP_LOOT_Journals|r
.complete 10569,1 
.complete 10569,2 
.complete 10569,3 
.mob Dark Conclave Hawkeye
.mob Dark Conclave Ravenguard
.mob Dark Conclave Shadowmancer
step
.goto Shadowmoon Valley,22.7,39.9
.use 30614 >>Use the |T133013:0|t[Fel Bomb] in your bags at the green circle on the ground
.complete 10564,1 
step
.hs >> Hearth to Wildhammer Stronghold
step
#label gizzard
.isQuestComplete 10677
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gnomus|r
.goto Shadowmoon Valley,36.5,55.3
.turnin 10677 >> Turn in The Second Course...
.target Gnomus
step
.goto Shadowmoon Valley,36.5,55.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gnomus|r
.accept 10678 >> Accept The Main Course!
.isQuestTurnedIn 10677
.target Gnomus
step
.goto Shadowmoon Valley,38.8,54.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryphonrider Kieran|r
.turnin 10569 >> Turn in The Sketh'lon Wreckage
.accept 10759 >> Accept Find the Deserter
.target Gryphonrider Kieran
step
.goto Shadowmoon Valley,39.5,53.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r
.turnin 10564 >> Turn in Blast the Infernals!
.accept 10573 >> Accept The Deathforge
.target Wing Commander Nuainn
step
.goto Shadowmoon Valley,42.2,45.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthmender Torlok|r
.turnin 10480 >> Turn in Enraged Spirits of Water
.accept 10481 >> Accept Enraged Spirits of Air
.target Earthmender Torlok
step
.goto Shadowmoon Valley,35.3,39.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Parshah|r. He patrols up and down the road
.turnin 10759 >> Turn in Find the Deserter
.accept 10777 >> Accept Asghar's Totem
.unitscan Parshah
step
.goto Shadowmoon Valley,40.5,41.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stormer Ewan Wildwing|r
.turnin 10573 >> Turn in The Deathforge
.accept 10582 >> Accept Minions of the Shadow Council
.target Stormer Ewan Wildwing
step
.goto Shadowmoon Valley,40.3,38.1
>>Kill |cRXP_ENEMY_Deathforge Guardians|r and |cRXP_ENEMY_Summoners|r
.complete 10582,1 
.complete 10582,2 
.mob Deathforge Guardian
.mob Deathforge Summoner
step
.goto Shadowmoon Valley,40.5,41.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stormer Ewan Wildwing|r
.turnin 10582 >> Turn in Minions of the Shadow Council
.accept 10583 >> Accept The Fate of Flanis
.accept 10585 >> Accept The Summoning Chamber
.target Stormer Ewan Wildwing
step
#completewith next
.goto Shadowmoon Valley,40.16,38.23,15 >> Enter The Deathforge from the northern entrance
step
.goto Shadowmoon Valley,34.7,39.9
>>Kill |cRXP_ENEMY_Deathforge Smiths|r and |cRXP_ENEMY_Deathforge Tinkerers|r. Loot them for the |cRXP_LOOT_Elemental Displacer|r
.complete 10585,2 
>>Click on the dead dwarf at the end of the corridor for |cRXP_PICK_Flanis's Pack|r
.complete 10583,1 
.mob Deathforge Smith
.mob Deathforge Tinkerer
step
.goto Shadowmoon Valley,37.8,38.3
.use 30672>>Jump down the bridge and use the |T135470:0|t[Elemental Displacer] in your bags at the summoning spot
.complete 10585,1 
step
.goto Shadowmoon Valley,40.4,41.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stormer Ewan Wildwing|r
.turnin 10583 >> Turn in The Fate of Flanis
.turnin 10585 >> Turn in The Summoning Chamber
.accept 10586 >> Accept Bring Down the Warbringer!
.target Stormer Ewan Wildwing
step
.goto Shadowmoon Valley,39.0,46.7
>>Enter The Shadowforge through the top entrance and go through the locked gate
>>Kill |cRXP_ENEMY_Warbringer Razuun|r. Loot him for |cRXP_LOOT_Razuun's Orders|r
.complete 10586,1 
.complete 10586,2 
.mob Warbringer Razuun
step
.goto Shadowmoon Valley,39.7,29.7
>>Kill |cRXP_ENEMY_Asghar|r. Loot him for his |cRXP_LOOT_Totem|r
.complete 10777,1 
.mob Asghar
step
.goto Shadowmoon Valley,35.3,39.0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Parshah|r. He patrols up and down the road
.turnin 10777 >> Turn in Asghar's Totem
.accept 10778 >> Accept The Rod of Lianthe
.unitscan Parshah
step
.goto Shadowmoon Valley,39.5,53.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r
.turnin 10586 >> Turn in Bring Down the Warbringer!
.accept 10589 >> Accept Gaining Access
.target Wing Commander Nuainn
step
.goto Shadowmoon Valley,47.5,71.7
>>Kill |cRXP_ENEMY_Eclipsion Archmages|r, |cRXP_ENEMY_Bloodwarders|r and |cRXP_ENEMY_Centurions|r
.complete 10778,1 
>>Open the chest at the back of the camp
.complete 10778,2 
.mob Eclipsion Archmage
.mob Eclipsion Bloodwarder
.mob Eclipsion Centurion
step
.goto Shadowmoon Valley,54.8,58.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Varen the Reclaimer|r
.turnin 10807 >> Turn in The Ashtongue Broken
.accept 10817 >> Accept The Great Retribution
.target Varen the Reclaimer
step
.goto Shadowmoon Valley,56.3,59.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arcanist Thelis|r
.turnin 10683 >> Turn in Tablets of Baa'ri
.accept 10684 >> Accept Oronu the Elder
.target Arcanist Thelis
step
.goto Shadowmoon Valley,56.1,44.3
>>Kill |cRXP_ENEMY_Felspine the Greater|r. Loot him for |cRXP_LOOT_Felspine's Hide|r
.complete 10678,1 
.isOnQuest 10678
.mob Felspine the Greater
step
.goto Shadowmoon Valley,57.2,32.9
>>Kill |cRXP_ENEMY_Oronu|r at top of the balcony
.complete 10684,1 
.mob Oronu the Elder
step
.goto Shadowmoon Valley,56.2,59.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arcanist Thelis|r
.turnin 10684 >> Turn in Oronu the Elder
.accept 10685 >> Accept The Ashtongue Corruptors
.target Arcanist Thelis
step
#sticky
#label air
.goto Shadowmoon Valley,62.7,62.1,60,0
.use 30094 >>Use the |T135462:0|t[Totem of Spirits] in your bags and kill |cRXP_ENEMY_Air Elementals|r next to the totem
.complete 10481,1 
.mob Enraged Air Spirit
step
.goto Shadowmoon Valley,58.3,70.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Ancient Shadowmoon Spirit|r
.turnin 10644 >> Turn in Teron Gorefiend - Lore and Legend
.accept 10634 >> Accept Divination: Gorefiend's Armor
.accept 10635 >> Accept Divination: Gorefiend's Cloak
.accept 10636 >> Accept Divination: Gorefiend's Truncheon
.target Ancient Shadowmoon Spirit
step
.goto Shadowmoon Valley,57.1,73.7
>>Destroy the totems protecting |cRXP_ENEMY_Haalum|r. Kill and loot him for his |cRXP_LOOT_Medallion Fragment|r
.complete 10685,2 
.mob Haalum
step
#requires air
#sticky
>>Whenever you are traveling through the main road, equip your |T133149:0|t[Spectrecles] to look for the |cRXP_ENEMY_Ghostrider of Karabor|r. They patrol the zone in a counter-clockwise direction
>>Loot them for |cRXP_LOOT_Gorefiend's Truncheon|r
.complete 10636,1
.mob Ghostrider of Karabor
step
#requires air
.goto Shadowmoon Valley,51.2,52.8
>>Destroy the totems protecting |cRXP_ENEMY_Eykenen|r. Kill and loot him for his |cRXP_LOOT_Medallion Fragment|r
.complete 10685,1 
.mob Eykenen
step
.goto Shadowmoon Valley,48.3,39.6
>>Destroy the totems protecting |cRXP_ENEMY_Uylaru|r. Kill and loot him for his |cRXP_LOOT_Medallion Fragment|r
.complete 10685,4 
.mob Uylaru
step
.goto Shadowmoon Valley,42.2,45.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Earthmender Torlok|r
.turnin 10481 >> Turn in Enraged Spirits of Air
.accept 10513 >> Accept Oronok Torn-heart
.target Earthmender Torlok
step
.goto Shadowmoon Valley,35.2,40.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Parshah|r. He patrols up and down the road
.turnin 10778 >> Turn in The Rod of Lianthe
.accept 10780 >> Accept Sketh'lon Feathers
.unitscan Parshah
step
.goto Shadowmoon Valley,24.7,36.4
>>Kill |cRXP_ENEMY_Mo'arg Weaponsmiths|r. Loot them for the |cRXP_LOOT_Legion Teleporter Control|r
.complete 10589,1 
.mob Mo'arg Weaponsmith
step
.goto Shadowmoon Valley,39.5,53.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wing Commander Nuainn|r
.turnin 10589 >> Turn in Gaining Access
.accept 10766 >> Accept Invasion Point: Cataclysm
.target Wing Commander Nuainn
step
.goto Shadowmoon Valley,36.6,55.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gnomus|r
.turnin 10678 >> Turn in The Main Course!
.isOnQuest 10678
.target Gnomus
step
.goto Shadowmoon Valley,43.7,58.0
>>Loot the |cRXP_PICK_Sketh'lon Feathers|r on the ground
.complete 10780,1 
step
.goto Shadowmoon Valley,35.2,40.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Parshah|r. He patrols up and down the road
.turnin 10780 >> Turn in Sketh'lon Feathers
.accept 10782 >> Accept Imbuing the Headpiece
.unitscan Parshah
step
.goto Shadowmoon Valley,42.8,45.0
.use 31360 >>Equip the |T135160:0|t[Unfinished Headpiece] trinket and use it at the center of the altar
.complete 10782,1 
step
.goto Shadowmoon Valley,35.2,40.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Parshah|r. He patrols up and down the road
.turnin 10782 >> Turn in Imbuing the Headpiece
.accept 10808 >> Accept Thwart the Dark Conclave
.unitscan Parshah
step
#sticky
#completewith next
.goto Shadowmoon Valley,25.5,36.3,42
>>Enter the Legion Hold teleporter
step
.goto Shadowmoon Valley,40.9,22.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Plexi|r
.turnin 10766 >> Turn in Invasion Point: Cataclysm
.accept 10606 >> Accept The Art of Fel Reaver Maintenance
.target Plexi
step
.goto Shadowmoon Valley,39.4,19.6
>>Kill |cRXP_ENEMY_Doctor Gutrick|r. Loot his chest for |cRXP_LOOT_The Art of Fel Reaver Maintenance|r
.complete 10606,2
.complete 10606,1 
.mob Doctor Gutrick
step
.goto Shadowmoon Valley,40.8,22.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Plexi|r
.turnin 10606 >> Turn in The Art of Fel Reaver Maintenance
.accept 10612 >> Accept The Fel and the Furious
.target Plexi
step
.goto Shadowmoon Valley,40.8,21.7
>>Dismiss your pet << Hunter/Warlock
>>Use the console to control a |cRXP_FRIENDLY_Fel Reaver|r and use it to destroy the |cRXP_ENEMY_Infernals|r
.complete 10612,1 
.mob Deathforged Infernal
step
.goto Shadowmoon Valley,40.8,22.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Plexi|r
.turnin 10612 >> Turn in The Fel and the Furious
.accept 10744 >> Accept News of Victory
.target Plexi
step
.goto Shadowmoon Valley,49.9,23.0
>>Destroy the totems protecting |cRXP_ENEMY_Lakaan|r. Kill and loot him for his |cRXP_LOOT_Medallion Fragment|r
.complete 10685,3 
.mob Lakaan
step
.goto Shadowmoon Valley,54.0,23.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oronok Torn-heart|r
.turnin 10513 >> Turn in Oronok Torn-heart
.accept 10514 >> Accept I Was A Lot Of Things...
.target Oronok Torn-heart
step
.goto Shadowmoon Valley,54.0,16.0
.use 30462 >>Stand on top of the small plants on the ground and use |T132161:0|t[Oronok's Boar Whistle] to have a nearby boars dig out the tubers
.complete 10514,1 
step
.goto Shadowmoon Valley,53.9,23.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oronok Torn-heart|r
.turnin 10514 >> Turn in I Was A Lot Of Things...
.accept 10515 >> Accept A Lesson Learned
.target Oronok Torn-heart
step
.goto Shadowmoon Valley,56.6,17.0
>>Destroy the |cRXP_ENEMY_Ravenous Flayer Eggs|r by right clicking them. Watch out for the elite that patrols around
.complete 10515,1 
step
.goto Shadowmoon Valley,53.9,23.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oronok Torn-heart|r
.turnin 10515 >> Turn in A Lesson Learned
.accept 10519 >> Accept The Cipher of Damnation - Truth and History
.complete 10519,1 
.skipgossip
.target Oronok Torn-heart
step
.goto Shadowmoon Valley,53.9,23.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Oronok Torn-heart|r
.turnin 10519 >> Turn in The Cipher of Damnation - Truth and History
.accept 10521 >> Accept Grom'tor, Son of Oronok
.accept 10527 >> Accept Ar'tor, Son of Oronok
.accept 10546 >> Accept Borak, Son of Oronok
.target Oronok Torn-heart
step
.goto Shadowmoon Valley,44.6,23.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grom'tor, Son of Oronok|r
.turnin 10521 >> Turn in Grom'tor, Son of Oronok
.accept 10522 >> Accept The Cipher of Damnation - Grom'tor's Charge
.target Grom'tor, Son of Oronok
step
.goto Shadowmoon Valley,46.0,28.2
>>Kill |cRXP_ENEMY_Coilskar Nagas|r. Loot them for their |cRXP_LOOT_Coilskar Chest Keys|r
>>Open the chests until you loot the |cRXP_PICK_First Fragment of the Cipher of Damnation|r
.complete 10522,1 
.mob Coilskar Defender
.mob Coilskar Muckwatcher
.mob Coilskar Myrmidon
.mob Coilskar Siren
.mob Coilskar Sorceress
.mob Coilskar Waterkeeper
step
.goto Shadowmoon Valley,44.6,23.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grom'tor, Son of Oronok|r
.turnin 10522 >> Turn in The Cipher of Damnation - Grom'tor's Charge
.accept 10523 >> Accept The Cipher of Damnation - The First Fragment Recovered
.target Grom'tor, Son of Oronok
step
.hs >> Hearth to Wildhammer Stronghold
step
.goto Shadowmoon Valley,35.7,57.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kurdran Wildhammer|r
.turnin 10744 >> Turn in News of Victory
.target Kurdran Wildhammer
step
.goto Shadowmoon Valley,47.5,57.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Borak, Son of Oronok|r
.turnin 10546 >> Turn in Borak, Son of Oronok
.accept 10547 >> Accept Of Thistleheads and Eggs...
.target Borak, Son of Oronok
step
.goto Shadowmoon Valley,40.7,60.1
.use 31386 >>Use the |T135225:0|t[Staff of Parshah] in your bags to stop the ritual
.complete 10808,1 
step
.goto Shadowmoon Valley,45.1,57.4
>>Loot the |cRXP_PICK_Rotten Eggs|r on the ground. Be careful because they can damage you upon looting
.complete 10547,1 
step
.goto Shadowmoon Valley,35.2,40.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Parshah|r. He patrols up and down the road
.turnin 10808 >> Turn in Thwart the Dark Conclave
.unitscan Parshah
step
.goto Shadowmoon Valley,29.6,50.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Spirit of Ar'tor|r
.turnin 10527 >> Turn in Ar'tor, Son of Oronok
.accept 10528 >> Accept Demonic Crystal Prisons
.target Ar'tor, Son of Oronok
step
.goto Shadowmoon Valley,28.0,47.7
>>Kill |cRXP_ENEMY_Painmistress Gabrissa|r. Loot her for the |cRXP_LOOT_Crystalline Key|r
.complete 10528,1 
.mob Painmistress Gabrissa
step
.goto Shadowmoon Valley,29.6,50.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Spirit of Ar'tor|r
.turnin 10528 >> Turn in Demonic Crystal Prisons
.accept 10537 >> Accept Lohn'goron, Bow of the Torn-heart
.target Ar'tor, Son of Oronok
step
.goto Shadowmoon Valley,30.5,50.0
>>Kill the |cRXP_ENEMY_Illidari|r. Loot them for the |cRXP_LOOT_Bow|r
.complete 10537,1 
.mob Illidari Dreadbringer
.mob Illidari Painlasher
.mob Illidari Shadowstalker
.mob Illidari Shocktrooper
step
.goto Shadowmoon Valley,29.5,50.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Spirit of Ar'tor|r
.turnin 10537 >> Turn in Lohn'goron, Bow of the Torn-heart
.accept 10540 >> Accept The Cipher of Damnation - Ar'tor's Charge
.target Spirit of Ar'tor
step
.goto Shadowmoon Valley,29.5,57.5
>>Head southeast while |cRXP_FRIENDLY_Ar'tor's|r spirit is following you, walk around this area until |cRXP_FRIENDLY_Spirit of Ar'tor|r summons |cRXP_ENEMY_Veneratus the Many|r
.complete 10540,1 
>>Be ready for a long fight, |cRXP_ENEMY_Veneratus the Many|r has 3 times more health than a normal mob
.mob Veneratus the Many
.target Spirit of Ar'tor
step
.goto Shadowmoon Valley,29.5,50.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Spirit of Ar'tor|r
.turnin 10540 >> Turn in The Cipher of Damnation - Ar'tor's Charge
.accept 10541 >> Accept The Cipher of Damnation - The Second Fragment Recovered
.target Spirit of Ar'tor
step
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maddix|r or |cRXP_FRIENDLY_Brubeck Stormfoot|r
>>|cRXP_WARN_The arrow will point you to the closest Flight Master|r
.fly Shattrath >> Fly to Shattrath City
.goto Shadowmoon Valley,37.6,55.3,-1
.goto Shadowmoon Valley,63.3,30.4,-1
.target Maddix
.target Brubeck Stormfoot
step
.goto Shattrath City,64.1,69.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tobias the Filth Gorger|r
.turnin 10547 >> Turn in Of Thistleheads and Eggs...
.accept 10550 >> Accept The Bundle of Bloodthistle
.target Tobias the Filth Gorger
step
#completewith next
.goto Shattrath City,64.05,41.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nutral|r
.fly Wildhammer Stronghold >> Fly to Wildhammer Stronghold
.target Nutral
step
.goto Shadowmoon Valley,47.5,57.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Borak, Son of Oronok|r
.turnin 10550 >> Turn in The Bundle of Bloodthistle
.accept 10570 >> Accept To Catch A Thistlehead
.target Borak, Son of Oronok
step
.goto Shadowmoon Valley,48.9,57.4
.use 30616 >>Plant the |T133651:0|t[Bundle of Bloodthistle] in your bags at the end of the bridge
.complete 10570,1 
step
.goto Shadowmoon Valley,47.6,57.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Borak, Son of Oronok|r
.turnin 10570 >> Turn in To Catch A Thistlehead
.accept 10576 >> Accept The Shadowmoon Shuffle
.target Borak, Son of Oronok
step
.goto Shadowmoon Valley,49.6,62.2
>>Kill |cRXP_ENEMY_Eclipsions|r. Loot them for their |cRXP_LOOT_Armor|r
.complete 10576,1 
.mob Eclipsion Archmage
.mob Eclipsion Blood Knight
.mob Eclipsion Bloodwarder
.mob Eclipsion Centurion
step
.goto Shadowmoon Valley,47.6,57.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Borak, Son of Oronok|r
.turnin 10576 >> Turn in The Shadowmoon Shuffle
.accept 10577 >> Accept What Illidan Wants, Illidan Gets...
.target Borak, Son of Oronok
step
.goto Shadowmoon Valley,46.5,71.9
.use 30639 >>Use the |T133564:0|t[Blood Elf Disguise] in your bags
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grand Commander Ruusk|r
.skipgossip
.target Grand Commander Ruusk
.complete 10577,1 
step
.goto Shadowmoon Valley,47.5,57.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Borak, Son of Oronok|r
.turnin 10577 >> Turn in What Illidan Wants, Illidan Gets...
.accept 10578 >> Accept The Cipher of Damnation - Borak's Charge
.target Borak, Son of Oronok
step
.goto Shadowmoon Valley,56.3,59.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arcanist Thelis|r
.turnin 10685 >> Turn in The Ashtongue Corruptors
.accept 10686 >> Accept The Warden's Cage
.target Arcanist Thelis
step
.goto Shadowmoon Valley,56.3,59.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Roldemar|r
.home >> Set your Hearthstone to Sanctum of the Stars
.target Roldemar
step
.goto Shadowmoon Valley,57.3,49.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sanoru|r
.turnin 10686 >> Turn in The Warden's Cage
.accept 10622 >> Accept Proof of Allegiance
.target Sanoru
step
.goto Shadowmoon Valley,57.8,50.3
>>Kill |cRXP_ENEMY_Zandras|r
.complete 10622,1 
.mob Zandras
step
.goto Shadowmoon Valley,57.4,49.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sanoru|r
.turnin 10622 >> Turn in Proof of Allegiance
.accept 10628 >> Accept Akama
.target Sanoru
step
.goto Shadowmoon Valley,58.1,48.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Akama|r
.turnin 10628 >> Turn in Akama
.accept 10705 >> Accept Seer Udalo
.target Akama
step
.goto Shadowmoon Valley,64.5,39.9
>>Equip your |T133149:0|t[Spectrecles] in your bags
>>Kill |cRXP_ENEMY_Clerics of Karabor|r. Loot them for |cRXP_LOOT_Gorefiend's Cloak|r
.complete 10635,1 
.mob Cleric of Karabor
step << Druid/70
.goto Shadowmoon Valley,68.8,49.2
>>Kill |cRXP_ENEMY_Demon Hunter Initiates|r and |cRXP_ENEMY_Demon Hunter Supplicants|r. Loot them for their |cRXP_LOOT_Sunfury Glaives|r
>>Skip this quest if you don't have a flying mount
.complete 10687,1 
.mob Demon Hunter Supplicant
.mob Demon Hunter Initiate
step << Druid/70
.goto Shadowmoon Valley,55.8,58.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Larissa Sunstrike|r
.turnin 10687 >> Turn in Karabor Training Grounds
.accept 10688 >> Accept A Necessary Distraction
.target Larissa Sunstrike
step << Druid/70
.goto Shadowmoon Valley,69.8,51.5
>>Kill |cRXP_ENEMY_Sunfury Warlocks|r. Loot them for the |cRXP_LOOT_Scroll of Demonic Unbanishing|r
.use 30811 >> Use the |T134937:0|t[Scroll of Demonic Unbanishing] on |cRXP_ENEMY_Azaloth|r
.collect 30811,1 
.complete 10688,1 
.mob Sunfury Warlock
.mob Azaloth
step << Druid/70
.goto Shadowmoon Valley,67.4,38.0
>>Kill |cRXP_ENEMY_Shadowmoon Slayers|r, |cRXP_ENEMY_Darkweavers|r and |cRXP_ENEMY_Chosen|r
>>Skip this quest if you don't have a flying mount
.complete 10817,1 
.complete 10817,2 
.complete 10817,3 
.mob Shadowmoon Slayer
.mob Shadowmoon Chosen
.mob Shadowmoon Darkweaver
step << Druid/70
.goto Shadowmoon Valley,67.6,36.2
.use 31239 >>Kill |cRXP_ENEMY_Smith Gorlunk|r. Loot him for his |cRXP_LOOT_Key Mold|r. Click the |T134459:0|t[Primed Key Mold] in your bags
>>Skip this quest if you don't have a flying mount
.collect 31239,1,10754 
.accept 10754 >> Accept Entry Into the Citadel
.unitscan Smith Gorlunk
step
.hs >> Hearth to Sanctum of the Stars
step << Druid/70
.goto Shadowmoon Valley,55.8,58.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Larissa Sunstrike|r
.turnin 10688 >> Turn in A Necessary Distraction
.accept 10689 >> Accept Altruis
.target Larissa Sunstrike
step
.goto Shadowmoon Valley,54.8,58.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Varen the Reclaimer|r
.turnin 10817 >> Turn in The Great Retribution
.target Varen the Reclaimer
step
>>Equip your |T133149:0|t[Spectrecles] to look for the |cRXP_ENEMY_Ghostriders of Karabor|r. They patrol along the main road. Loot them for |cRXP_LOOT_Gorefiend's Truncheon|r
.complete 10636,1 
.mob Ghostrider of Karabor
step
.goto Shadowmoon Valley,58.2,70.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Ancient Shadowmoon Spirit|r
.turnin 10635 >> Turn in Divination: Gorefiend's Cloak
.turnin 10636 >> Turn in Divination: Gorefiend's Truncheon
.mob Ancient Shadowmoon Spirit
]])
RXPGuides.RegisterGuide([[
#version 5
#cata
#Cata
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 71-73 Borean Tundra
#version 5
#displayname 69-73 Borean Tundra << !wotlk
#next 72-74 Dragonblight; 73-75 Grizzly Hills << wotlk
#next 73-74 Dragonblight << !wotlk
step
.goto 1453/0,1407.6,-8291.2 << !wotlk
.goto StormwindNew,43.5,52.7,70,0 << wotlk
.goto StormwindNew,18.47,26.49 << wotlk
>>Travel to the Stormwind Harbor
.zone BoreanTundra >> Take the boat to Borean Tundra << !wotlk
.zone BoreanTundra >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Leesha|r. Ask her for a teleport to Valiance Keep << wotlk
.skipgossip << wotlk
.target Leesha Tannerby << wotlk
step
#completewith enlist
.goto BoreanTundra,58.97,68.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tomas|r
.fp Valiance Keep >> Get the Valiance Keep flight path
.target Tomas Riverwell
step
#completewith Hawthorn5
.groundgoto BoreanTundra,58.5,68.3,15,0
.goto BoreanTundra,58.29,68.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_James|r inside the Inn
.home >> Set your Hearthstone to Valiance Keep
>>|cRXP_BUY_Buy new food/water if needed|r
.target James Deacon
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Recruitment Officer Blythe|r and |cRXP_FRIENDLY_Rollick|r
.accept 11672 >>Accept Enlistment Day
.goto BoreanTundra,57.85,67.60
.accept 13088 >> Accept Northern Cooking
.goto BoreanTundra,57.93,71.54
.skill cooking,<350,1
.target Recruitment Officer Blythe
.target Rollick MacKreel
step
#label enlist
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Recruitment Officer Blythe|r
.accept 11672 >>Accept Enlistment Day
.goto BoreanTundra,57.85,67.60
.target Recruitment Officer Blythe
step
#optional
#completewith next
.goto BoreanTundra,57.1,71.8,15,0
.goto BoreanTundra,57.2,72.3,15,0
.goto BoreanTundra,56.67,72.64,10 >> Travel into the Keep
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arlos|r
.turnin 11672 >>Turn in Enlistment Day
.accept 11727 >>Accept A Time for Heroes
.goto BoreanTundra,56.67,72.64
.target General Arlos
step
#completewith next
.goto BoreanTundra,56.87,71.29,20 >> Exit the Keep
step
.goto 114/571,5321.100,2223.300
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sergeant Hammerhill|r
.target Sergeant Hammerhill
.turnin 11727 >>Turn in A Time for Heroes
.accept 11797 >>Accept The Siege
step
.goto 114/571,5400.100,2248.800
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Medic Hawthorn|r
.target Medic Hawthorn
.accept 11789 >>Accept A Soldier in Need
step
.goto BoreanTundra,53.5,69.1,70,0
.goto BoreanTundra,53.1,72.8,60,0
.goto BoreanTundra,52.29,70.53,60,0
.goto BoreanTundra,53.90,67.07,60,0
.goto BoreanTundra,54.85,65.09
>>Kill |cRXP_ENEMY_Crypt Crawlers|r
.complete 11797,1 
.mob Crypt Crawler
step
.goto BoreanTundra,56.36,69.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hammerhill|r
.turnin 11797 >>Turn in The Siege
.accept 11889 >>Accept Death From Above
.target Sergeant Hammerhill
step
.goto BoreanTundra,54.8,70.2,40,0
.goto BoreanTundra,54.83,71.43,40,0
.goto BoreanTundra,54.8,70.2
.use 35278 >>|cRXP_WARN_Use the|r |T134325:0|t[Reinforced Net] |cRXP_WARN_to bring down the flying|r |cRXP_ENEMY_Scourged Flamespitters|r
>>Kill |cRXP_ENEMY_Scourged Flamespitters|r
.complete 11889,1 
.mob Scourged Flamespitter
step
.goto BoreanTundra,56.36,69.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hammerhill|r
.turnin 11889 >>Turn in Death From Above
.accept 11897 >>Accept Plug the Sinkholes
.target Sergeant Hammerhill
step
#completewith next
.goto BoreanTundra,56.96,68.75,10 >> Travel onto The Stormbreaker. Head to the lower level
step
>>Open the |cRXP_PICK_First Aid Supplies|r. Loot it for |cRXP_LOOT_Hawthorn's Anti-Venom|r
>>Click on the |cRXP_PICK_Cultist Shrine|r
.complete 11789,1 
.goto BoreanTundra,57.50,69.27
.accept 11920 >>Accept Cultists Among Us
.goto BoreanTundra,57.56,69.13
step
#completewith next
.goto BoreanTundra,56.96,68.75,10 >> Travel toward |cRXP_FRIENDLY_Captain "Lefty"|r and |cRXP_FRIENDLY_Admiral Cantlebree|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Captain "Lefty"|r and |cRXP_FRIENDLY_Admiral Cantlebree|r
.turnin 11920 >>Turn in Cultists Among Us
.goto BoreanTundra,57.83,69.20
.target +Captain "Lefty" Lugsail
.accept 11791 >>Accept Notify Arlos
.target +Admiral Cantlebree
.goto BoreanTundra,57.79,69.19
step
#completewith next
.goto BoreanTundra,57.1,71.8,15,0
.goto BoreanTundra,57.2,72.3,15,0
.goto BoreanTundra,56.67,72.64,10 >> Travel into the Keep
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arlos|r, |cRXP_FRIENDLY_Talbot|r, and |cRXP_FRIENDLY_Vurenn|r
.turnin 11791 >>Turn in Notify Arlos
.goto BoreanTundra,56.67,72.64
.target +General Arlos
.accept 12141 >>Accept A Diplomatic Mission
.goto BoreanTundra,56.72,72.62
.target +Counselor Talbot
.accept 11792 >>Accept Enemies of the Light
.target +Harbinger Vurenn
.goto BoreanTundra,56.60,72.46
step
#completewith next
.goto BoreanTundra,56.87,71.29,20 >> Exit the Keep
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hawthorn|r
.turnin 11789 >>Turn in A Soldier in Need
.goto BoreanTundra,55.00,68.91
.target Medic Hawthorn
step
.goto BoreanTundra,54.08,63.73,-1
.goto BoreanTundra,54.77,63.08,-1
.use 35704 >> |cRXP_WARN_Use the|r |T133713:0|t[Incendiary Explosives] |cRXP_WARN_at the|r |cRXP_PICK_Northern Sinkhole|r
.complete 11897,2 
step
#loop
.line BoreanTundra,54.04,62.42,53.84,60.33,55.25,63.43,54.04,62.42
.goto BoreanTundra,54.04,62.42,40,0
.goto BoreanTundra,53.84,60.33,40,0
.goto BoreanTundra,55.25,63.43,40,0
.goto BoreanTundra,54.04,62.42,40,0
>>Kill |cRXP_ENEMY_Cultist Necrolytes|r. Loot them for their |cRXP_LOOT_Communique|r
.complete 11792,1 
.mob Cultist Necrolyte
step
.goto BoreanTundra,50.46,71.38,-1
.goto BoreanTundra,50.88,72.29,-1
.use 35704 >> |cRXP_WARN_Use the|r |T133713:0|t[Incendiary Explosives] |cRXP_WARN_at the|r |cRXP_PICK_Southern Sinkhole|r
.complete 11897,1 
step
.goto BoreanTundra,47.13,75.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karuk|r
.turnin 12141 >>Turn in A Diplomatic Mission
.accept 11613 >>Accept Karuk's Oath
.target Karuk
step
#completewith Karuk2
#label CTPrisoner2
.goto BoreanTundra,44.10,77.90,50,0
>>Kill |cRXP_ENEMY_Skadir Longboatsmen|r and the |cRXP_ENEMY_Riplash Myrmidon|r surrounding the |cRXP_FRIENDLY_Captured Tuskarr Prisoner|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Prisoner|r
>>|cRXP_WARN_Ignore this if the |cRXP_FRIENDLY_Prisoner|r isn't there|r
.accept 12471 >>Accept Cruelty of the Kvaldir
.unitscan Captured Tuskarr Prisoner
step
#loop
.goto BoreanTundra,44.08,78.16,50,0
.goto BoreanTundra,46.02,79.49,50,0
.goto BoreanTundra,46.80,80.74,50,0
.goto BoreanTundra,48.40,79.83,50,0
.goto BoreanTundra,50.33,78.08,50,0
.goto BoreanTundra,48.22,76.00,50,0
.goto BoreanTundra,47.69,77.59,50,0
.goto BoreanTundra,44.08,78.16,50,0
.goto BoreanTundra,46.02,79.49,50,0
.goto BoreanTundra,46.80,80.74,50,0
.goto BoreanTundra,48.40,79.83,50,0
.goto BoreanTundra,50.33,78.08,50,0
.goto BoreanTundra,48.22,76.00,50,0
.goto BoreanTundra,47.69,77.59,0
>>Kill |cRXP_ENEMY_Skadir Longboatsmen|r and |cRXP_ENEMY_Skadir Raiders|r
.complete 11613,2 
.mob +Skadir Longboatsman
.complete 11613,1 
.mob +Skadir Raider
step
#optional
#completewith end
#requires CTPrisoner2
#label Cruelty2
.goto BoreanTundra,47.13,75.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karuk|r
.turnin 12471 >>Turn in Cruelty of the Kvaldir
.isOnQuest 12471
.target Karuk
step
#label Karuk2
.goto BoreanTundra,47.13,75.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karuk|r
.turnin 11613 >>Turn in Karuk's Oath
.accept 11619 >>Accept Gamel the Cruel
.target Karuk
step
#optional
#requires Cruelty2
#completewith next
.groundgoto BoreanTundra,46.3,78.8,20,0
.goto BoreanTundra,46.42,78.23,15 >> Travel into the Cave
step
.goto BoreanTundra,46.42,78.23
>>Kill |cRXP_ENEMY_Gamel the Cruel|r inside the cave
.complete 11619,1 
.mob Gamel the Cruel
step
#optional
#completewith Karuk3
#label CTPrisoner3
.goto BoreanTundra,44.10,77.90,50,0
>>Kill |cRXP_ENEMY_Skadir Longboatsmen|r and the |cRXP_ENEMY_Riplash Myrmidon|r surrounding the |cRXP_FRIENDLY_Captured Tuskarr Prisoner|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Prisoner|r
>>|cRXP_WARN_Ignore this if the |cRXP_FRIENDLY_Prisoner|r isn't there|r
.accept 12471 >>Accept Cruelty of the Kvaldir
.unitscan Captured Tuskarr Prisoner
step
#optional
#completewith end
#requires CTPrisoner3
#label Cruelty3
.goto BoreanTundra,47.13,75.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karuk|r
.turnin 12471 >>Turn in Cruelty of the Kvaldir
.isOnQuest 12471
.target Karuk
step
#label Karuk3
.goto BoreanTundra,47.13,75.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karuk|r
.turnin 11619 >>Turn in Gamel the Cruel
.accept 11620 >>Accept A Father's Words
.target Karuk
step
#optional
#completewith Veehja
#label CTPrisoner4
.goto BoreanTundra,44.10,77.90,50,0
>>Kill |cRXP_ENEMY_Skadir Longboatsmen|r and the |cRXP_ENEMY_Riplash Myrmidon|r surrounding the |cRXP_FRIENDLY_Captured Tuskarr Prisoner|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Prisoner|r
>>|cRXP_WARN_Ignore this if the |cRXP_FRIENDLY_Prisoner|r isn't there|r
.accept 12471 >>Accept Cruelty of the Kvaldir
.unitscan Captured Tuskarr Prisoner
step
#optional
#completewith end
#requires CTPrisoner4
.goto BoreanTundra,47.13,75.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karuk|r
.turnin 12471 >>Turn in Cruelty of the Kvaldir
.isOnQuest 12471
.target Karuk
step << wotlk
.goto BoreanTundra,43.60,80.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Veehja|r << DK
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Veehja|r. Only accept this quest if you have enough [|cRXP_WARN_Fish Oil|r] << Shaman
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Veehja|r. Only accept this quest if you have multiple |T134794:0|t[|cRXP_WARN_Elixir of Water Walking|r] or are partied with a |T135771:0|t|cFFC41E3ADeath Knight|r << !Shaman !DK
.turnin 11620 >>Turn in A Father's Words
.accept 11625 >>Accept The Trident of Naz'jan
.itemcount 17058,5 << Shaman
.itemcount 8827,5 << !Shaman !DK
.skill coldweatherflying,1,1
.target Veehja
step
#label Veehja2
.goto BoreanTundra,43.60,80.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Veehja|r
.turnin 11620 >>Turn in A Father's Words
.accept 11625 >>Accept The Trident of Naz'jan
.skill coldweatherflying,<1,1
.target Veehja
step
#label Veehja
.goto BoreanTundra,43.60,80.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Veehja|r
.turnin 11620 >>Turn in A Father's Words
.target Veehja
step
#requires Veehja2
#completewith next
.groundgoto BoreanTundra,53.7,91.1,40,0
.goto BoreanTundra,54.85,88.78,100 >> Travel to the Riplash Ruins
.isOnQuest 11625
step

.goto BoreanTundra,55.03,88.51
>>Kill |cRXP_ENEMY_Ragnar Drakkarlund|r. Loot him for his |cRXP_LOOT_Trident|r
.complete 11625,1 
.isOnQuest 11625
.mob Ragnar Drakkarlund
step
.goto BoreanTundra,43.63,80.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Veehja|r
.turnin 11625 >>Turn in The Trident of Naz'jan
.isQuestComplete 11625
.target Veehja
step
.goto BoreanTundra,43.63,80.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Veehja|r
.accept 11626 >>Accept The Emissary
.isQuestTurnedIn 11625
.target Veehja
step
.goto BoreanTundra,51.90,88.46
.use 35850 >> |cRXP_WARN_Use the|r |T135127:0|t[Trident of Naz'jan] |cRXP_WARN_to deal significant damage to |cRXP_ENEMY_Leviroth|r underwater|r
>>Kill |cRXP_ENEMY_Leviroth|r
.complete 11626,1 
.isQuestTurnedIn 11625
.mob Leviroth
step
#completewith Karuk5
#label CTPrisoner5
.goto BoreanTundra,44.10,77.90,50,0
>>Kill |cRXP_ENEMY_Skadir Longboatsmen|r and the |cRXP_ENEMY_Riplash Myrmidon|r surrounding the |cRXP_FRIENDLY_Captured Tuskarr Prisoner|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Prisoner|r
>>|cRXP_WARN_Ignore this if the |cRXP_FRIENDLY_Prisoner|r isn't there|r
.accept 12471 >>Accept Cruelty of the Kvaldir
.unitscan Captured Tuskarr Prisoner
.mob Skadir Longboatsman
.isQuestTurnedIn 11625
step
#completewith end
#requires CTPrisoner5
.goto BoreanTundra,47.13,75.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karuk|r
.turnin 12471 >>Turn in Cruelty of the Kvaldir
.isOnQuest 12471
.target Karuk
step
#label Karuk5
.goto BoreanTundra,47.13,75.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karuk|r
.turnin 11626 >>Turn in The Emissary
.isQuestTurnedIn 11625
.target Karuk
step
#completewith Oculus
.hs >> Hearth to Valiance Keep
step
#completewith Oculus
.goto BoreanTundra,57.1,71.8,15,0
.goto BoreanTundra,57.2,72.3,15,0
.goto BoreanTundra,56.67,72.64,10 >> Travel into the Keep
step
#optional
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vurenn|r, |cRXP_FRIENDLY_Rollick|r, |cRXP_FRIENDLY_Hammerhill|r, |cRXP_FRIENDLY_Mark|r, and |cRXP_FRIENDLY_Skyhopper|r outside
.turnin 11792 >>Turn in Enemies of the Light
.accept 11793 >>Accept Further Investigation
.goto BoreanTundra,56.60,72.46
.turnin 13088 >> Turn in Northern Cooking
.goto BoreanTundra,57.93,71.54
.turnin 11897 >>Turn in Plug the Sinkholes
.accept 11928 >>Accept Farshire
.goto BoreanTundra,56.36,69.58
.accept 11927 >>Accept Word on the Street
.goto BoreanTundra,56.77,69.51
.accept 11707 >>Accept Distress Call
.goto BoreanTundra,58.84,68.72
.isQuestComplete 13088
.skill cooking,<350,1
.target Sergeant Hammerhill
.target Harbinger Vurenn
.target Rollick MacKreel
.target Mark Hanes
.target Airman Skyhopper
step
.goto 114/571,5305.900,2112.700
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harbinger Vurenn|r
.target Harbinger Vurenn
.turnin 11792 >>Turn in Enemies of the Light
.accept 11793 >>Accept Further Investigation
step
.goto 114/571,5321.000,2223.200
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sergeant Hammerhill|r
.target Sergeant Hammerhill
.turnin 11897 >>Turn in Plug the Sinkholes
.accept 11928 >>Accept Farshire
step
.goto 114/571,5296.800,2225.700
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mark Hanes|r
.target Mark Hanes
.accept 11927 >>Accept Word on the Street
step
.goto 114/571,5179.900,2255.900
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Airman Skyhopper|r
.target Airman Skyhopper
.accept 11707 >>Accept Distress Call
step
.goto BoreanTundra,58.5,68.3,15,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Midge|r, then |cRXP_FRIENDLY_Leryssa|r and |cRXP_FRIENDLY_Yaala|r upstairs
.accept 11575 >>Accept Nick of Time
.goto BoreanTundra,58.41,67.79
.target +Midge
.turnin 11927 >>Turn in Word on the Street
.accept 11599 >>Accept Thassarian, My Brother
.goto BoreanTundra,58.4,67.6,15,0
.goto BoreanTundra,58.75,68.36
.target +Leryssa
.turnin 11793 >>Turn in Further Investigation
.accept 11794 >>Accept The Hunt is On
.target +Vindicator Yaala
.goto BoreanTundra,58.55,67.29
step
#label Oculus
.use 35125 >> |cRXP_WARN_Use the|r |T134335:0|t[Oculus of the Exorcist] |cRXP_WARN_to buff yourself with|r |T135895:0|t[Righteous Vision]
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to then kill |cRXP_ENEMY_"Salty" John Thorpe|r in the Inn, |cRXP_ENEMY_Tom Hegger|r on the Dock, and |cRXP_ENEMY_Guard Mitchels|r in the Prison below the Keep
.complete 11794,3 
.goto BoreanTundra,58.57,67.13
.mob +"Salty" John Thorpe
.complete 11794,1 
.goto BoreanTundra,59.26,68.19
.mob +Tom Hegger
.complete 11794,2 
.goto BoreanTundra,56.9,72.2,12,0
.goto BoreanTundra,56.72,71.83
.mob +Guard Mitchells
.skipgossip 25248,2
.skipgossip 25827,1
.skipgossip 25828,1
.skipgossip
.timer 13,The Hunt is On RP
step
#completewith next
.goto BoreanTundra,58.21,62.82,70 >> Travel to Farshire
step
.goto BoreanTundra,58.21,62.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gerald|r
.turnin 11928 >>Turn in Farshire
.accept 11901 >>Accept Military? What Military?
.target Gerald Green
step
#completewith next
.goto BoreanTundra,56.7,57.2,40 >> Enter Farshire Mine
step
.goto BoreanTundra,56.81,55.56
>>Click the |cRXP_PICK_Plagued Grain|r on the ground
.turnin 11901 >>Turn in Military? What Military?
.accept 11902 >>Accept Pernicious Evidence
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gerald|r, |cRXP_FRIENDLY_Jeremiah|r, and |cRXP_FRIENDLY_Wendy|r
.turnin 11902 >>Turn in Pernicious Evidence
.accept 11903 >>Accept It's Time for Action
.goto BoreanTundra,58.21,62.82
.target +Gerald Green
.accept 11908 >>Accept Reference Material
.target +Jeremiah Hawning
.goto BoreanTundra,58.19,62.98
.accept 11913 >>Accept Take No Chances
.target +Wendy Darren
.goto BoreanTundra,58.28,62.77
step
#completewith next
.use 35491 >> |cRXP_WARN_Use|r |T135432:0|t[Wendy's Torch] |cRXP_WARN_to burn the|r |cRXP_PICK_Farshire Grains|r
>>Kill |cRXP_ENEMY_Plagued Scavengers|r
.complete 11913,1 
.complete 11903,1 
.mob +Plagued Scavenger
step
.goto BoreanTundra,55.75,58.32
>>Loot the |cRXP_LOOT_Fields, Factories and Workshops|r, it looks like a red book inside the burning house
.complete 11908,1 
step
#loop
.line BoreanTundra,56.84,61.57,55.59,62.11,54.56,60.67,55.89,60.80,55.32,59.32,55.81,57.69,56.83,58.39,56.84,61.57
.goto BoreanTundra,56.84,61.57,50,0
.goto BoreanTundra,55.59,62.11,50,0
.goto BoreanTundra,54.56,60.67,50,0
.goto BoreanTundra,55.89,60.80,50,0
.goto BoreanTundra,55.32,59.32,50,0
.goto BoreanTundra,55.81,57.69,50,0
.goto BoreanTundra,56.83,58.39,50,0
.goto BoreanTundra,56.84,61.57,50,0
.use 35491 >> |cRXP_WARN_Use|r |T135432:0|t[Wendy's Torch] |cRXP_WARN_to burn the|r |cRXP_PICK_Farshire Grains|r
>>Kill |cRXP_ENEMY_Plagued Scavengers|r
.complete 11913,1 
.complete 11903,1 
.mob +Plagued Scavenger
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wendy|r, |cRXP_FRIENDLY_Gerald|r and |cRXP_FRIENDLY_Jeremiah|r
.turnin 11913 >>Turn in Take No Chances
.target +Wendy Darren
.goto BoreanTundra,58.28,62.77,-1
.turnin 11903 >>Turn in It's Time for Action
.accept 11904 >>Accept Fruits of Our Labor
.goto BoreanTundra,58.21,62.82,-1
.target +Gerald Green
.turnin 11908 >>Turn in Reference Material
.accept 12035 >>Accept Repurposed Technology
.target +Jeremiah Hawning
.goto BoreanTundra,58.19,62.98,-1
step
.goto BoreanTundra,58.30,61.20,40,0
.goto BoreanTundra,56.52,62.19,40,0
.goto BoreanTundra,58.30,61.20
.use 35943 >> Kill |cRXP_ENEMY_Harvest Collectors|r. |cRXP_WARN_Use|r |T134520:0|t[Jeremiah's Tools] |cRXP_WARN_on their corpses|r
.complete 12035,1 
.mob Harvest Collector
step
#completewith next
.goto BoreanTundra,56.7,57.2,40 >> Enter Farshire Mine
step
.goto BoreanTundra,56.04,55.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_William's|r corpse
.turnin 11599 >>Turn in Thassarian, My Brother
.accept 11600 >>Accept The Late William Allerton
.target William Allerton
step
.goto BoreanTundra,57.99,53.54
>>Kill |cRXP_ENEMY_Captain Jacobs|r. Loot him for the |cRXP_LOOT_Cart Release Key|r
.collect 35705,1,11904,1 
.unitscan Captain Jacobs
step
.goto BoreanTundra,57.18,54.65
>>Click the |cRXP_PICK_Cart Release|r lever next to the |cRXP_FRIENDLY_Ore Cart|r
.complete 11904,1 
step
#completewith next
.goto BoreanTundra,56.7,57.2,40,0
.goto BoreanTundra,58.21,62.82,80 >> Travel toward |cRXP_FRIENDLY_Gerald|r and |cRXP_FRIENDLY_Jeremiah|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gerald|r and |cRXP_FRIENDLY_Jeremiah|r
.turnin 11904 >>Turn in Fruits of Our Labor
.accept 11962 >>Accept One Last Delivery
.target +Gerald Green
.goto BoreanTundra,58.21,62.82
.turnin 12035 >>Turn in Repurposed Technology
.goto BoreanTundra,58.19,62.98
.target +Jeremiah Hawning
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hilda|r
.turnin 11962 >>Turn in One Last Delivery
.accept 11963 >>Accept Weapons for Farshire
.goto BoreanTundra,57.32,66.64
.target Hilda Stoneforge
step
.goto BoreanTundra,58.75,68.42
>>|cRXP_WARN_Jump up on the cart then onto the bottom ledge of the window|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Leryssa|r
.turnin 11600 >>Turn in The Late William Allerton
.accept 11601 >>Accept Lost and Found
.target Leryssa
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_James|r and then |cRXP_FRIENDLY_Yaala|r upstairs
.turnin 11601 >>Turn in Lost and Found
.accept 11603 >>Accept In Wine, Truth
.target +James Deacon
.goto BoreanTundra,58.29,68.05
.turnin 11794 >>Turn in The Hunt is On
.target +Vindicator Yaala
.goto BoreanTundra,58.55,67.29
step
.goto BoreanTundra,58.21,62.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gerald|r
.turnin 11963 >>Turn in Weapons for Farshire
.accept 11965 >>Accept Call to Arms!
.target Gerald Green
step
#completewith next
.goto BoreanTundra,57.32,59.39,30 >> Enter the Farshire Bell Tower
step
.goto BoreanTundra,57.32,59.39
>>|cRXP_WARN_Run up the stairs slightly|r
>>Click the |cRXP_PICK_Bell Rope|r hanging from the ceiling
.complete 11965,1 
step
.goto BoreanTundra,58.21,62.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gerald|r
.turnin 11965 >>Turn in Call to Arms!
.target Gerald Green
step
#completewith next
.goto BoreanTundra,57.05,44.32,120 >> Travel to the D.E.H.T.A. Encampment
step
.goto BoreanTundra,57.05,44.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arch Druid Lathorius|r
.accept 11864 >>Accept A Mission Statement
.turnin 11864 >>Turn in A Mission Statement
.accept 11866 >>Accept Ears of Our Enemies
.accept 11876 >>Accept Help Those That Cannot Help Themselves
.target Arch Druid Lathorius
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Killinger|r patrolling around the statue, |cRXP_FRIENDLY_Zaza|r, and |cRXP_FRIENDLY_Cenius|r
.accept 11865 >>Accept Unfit for Death
.goto BoreanTundra,56.79,44.04
.target +Zaza
.accept 11869 >>Accept Happy as a Clam
.goto BoreanTundra,57.33,44.08
.target +Hierophant Cenius
.accept 11884 >>Accept Ned, Lord of Rhinos...
.goto BoreanTundra,57.17,43.59,7,0
.goto BoreanTundra,57.33,44.08,7,0
.goto BoreanTundra,57.05,44.32,7,0
.goto BoreanTundra,56.79,44.04
.target +Killinger the Den Watcher
step
#completewith LastTrap
.goto BoreanTundra,55.9,47.4,0
>>Kill |cRXP_ENEMY_Loot Crazed Poachers|r. Loot them for their |cRXP_LOOT_Ears|r
.complete 11866,1 
.mob Loot Crazed Poacher
.mob Loot Crazed Diver
step
#label LastTrap
#loop
.goto BoreanTundra,56.2,46.1,60,0
.goto BoreanTundra,57.7,46.4,60,0
.goto BoreanTundra,57.9,48.7,60,0
.goto BoreanTundra,56.5,50.2,60,0
.goto BoreanTundra,57.6,52.1,60,0
.goto BoreanTundra,57.6,52.1,0
>>|cRXP_WARN_Use the|r |T134263:0|t[Pile of Fake Furs] |cRXP_WARN_on the |cRXP_PICK_Caribou Traps|r on the ground|r
.use 35127 >> |cRXP_WARN_Do NOT wait for the RP|r
.complete 11865,1
.isOnQuest 11865
step
#loop
.goto BoreanTundra,51.7,47.0,70,0
.goto BoreanTundra,52.3,44.8,70,0
.goto BoreanTundra,52.9,43.0,70,0
.goto BoreanTundra,50.0,44.1,70,0
.goto BoreanTundra,50.0,44.1,0
>>Kill |cRXP_ENEMY_Loot Crazed Divers|r. Loot them for their |cRXP_LOOT_Ears|r
>>|cRXP_WARN_Do not go out of your way to collect all |cRXP_LOOT_Ears|r now. You will collect more later|r
.complete 11869,1 
.collect 35188,15,11866,1,1 
.mob Loot Crazed Diver
step
#optional
#completewith next
>>Kill |cRXP_ENEMY_Wooly Rhino Matriarchs|r, |cRXP_ENEMY_Wooly Rhino Bulls|r and |cRXP_ENEMY_Wooly Rhino Calves|r. Loot them for their |cRXP_LOOT_Chilled Meat|r
.complete 13088,1 
.isOnQuest 13088
.mob Wooly Rhino Matriarch
.mob Wooly Rhino Calf
.mob Wooly Rhino Bull
step
#loop
.goto BoreanTundra,48.6,40.0,50,0
.goto BoreanTundra,44.9,45.7,50,0
.goto BoreanTundra,46.7,45.6,50,0
.goto BoreanTundra,48.6,40.0,50,0
.goto BoreanTundra,44.9,45.7,0
.goto BoreanTundra,48.6,40.0,0
>>Kill |cRXP_ENEMY_Nedar, Lord of Rhinos|r and |cRXP_ENEMY_"Lunchbox"|r. Kill |cRXP_ENEMY_"Lunchbox"|r first
.complete 11884,2 
.complete 11884,1 
.unitscan Nedar, Lord of Rhinos
.mob "Lunchbox"
step
.goto BoreanTundra,48.6,40.0,50,0
.goto BoreanTundra,44.9,45.7,50,0
.goto BoreanTundra,46.7,45.6,50,0
.goto BoreanTundra,44.9,45.7,0
.goto BoreanTundra,48.6,40.0
>>Kill |cRXP_ENEMY_Wooly Rhino Matriarchs|r, |cRXP_ENEMY_Wooly Rhino Bulls|r and |cRXP_ENEMY_Wooly Rhino Calves|r. Loot them for their |cRXP_LOOT_Chilled Meat|r
.complete 13088,1 
.isOnQuest 13088
.mob Wooly Rhino Matriarch
.mob Wooly Rhino Calf
.mob Wooly Rhino Bull
step
#completewith next
.goto BoreanTundra,45.33,34.62,100 >> Travel to Amber Ledge
step
#sticky
#label ALFP
.goto BoreanTundra,45.33,34.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Surristrasz|r
.fp Amber Ledge >> Get the Amber Ledge flight path
.target Surristrasz
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donathan|r and |cRXP_FRIENDLY_Garren|r
.turnin 11575 >>Turn in Nick of Time
.accept 11587 >>Accept Prison Break
.goto BoreanTundra,45.26,33.35
.target +Librarian Donathan
.accept 11576 >>Accept Monitoring the Rift: Cleftcliff Anomaly
.goto BoreanTundra,44.98,33.38
.target +Librarian Garren
step
#requires ALFP
#completewith next
.goto BoreanTundra,54.29,36.09,100 >> Travel to Coldrock Quarry
step

>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Etaruk|r and |cRXP_FRIENDLY_Atkanok|r (|cRXP_WARN_the stone|r)
.accept 11612 >>Accept Reclaiming the Quarry
.goto BoreanTundra,54.29,36.09
.accept 11605 >>Accept The Honored Ancestors
.goto BoreanTundra,54.63,35.88
.target Etaruk
step
.goto BoreanTundra,55.5,41.1,60,0
.goto BoreanTundra,55.3,38.4,60,0
.goto BoreanTundra,57.6,38.4,60,0
.goto BoreanTundra,59.5,31.3,60,0
.goto BoreanTundra,55.4,27.7,60,0
.goto BoreanTundra,53.3,28.0,60,0
.goto BoreanTundra,56.8,37.7
.use 35228 >> |cRXP_WARN_Use the|r |T133539:0|t[D.E.H.T.A. Trap Smasher] |cRXP_WARN_to free|r |cRXP_FRIENDLY_Trapped Mammoth Calves|r
>>|cRXP_WARN_Do NOT wait for the RP|r
.complete 11876,1,7 
.target Trapped Mammoth Calf
step
.goto BoreanTundra,55.5,41.1,60,0
.goto BoreanTundra,55.3,38.4,60,0
.goto BoreanTundra,57.6,38.4,60,0
.goto BoreanTundra,59.5,31.3,60,0
.goto BoreanTundra,55.4,27.7,60,0
.goto BoreanTundra,53.3,28.0,60,0
.goto BoreanTundra,56.8,37.7
.cast 46201 >> |cRXP_WARN_Use the|r |T133539:0|t[D.E.H.T.A. Trap Smasher] |cRXP_WARN_to free|r |cRXP_FRIENDLY_Trapped Mammoth Calves|r
>>|cRXP_WARN_Do NOT wait for the RP|r
.use 35228
.isOnQuest 11876
.target Trapped Mammoth Calf
step
>>|cRXP_WARN_If you have the |T132311:0|t[Animal Blood] debuff, jump in some water to remove it or wait for it to expire before going into the camp, other wise the guards will attack you|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Killinger|r, |cRXP_FRIENDLY_Cenius|r, |cRXP_FRIENDLY_Lathorius|r, and |cRXP_FRIENDLY_Zaza|r
.turnin 11869 >>Turn in Happy as a Clam
.accept 11870 >>Accept The Abandoned Reach
.goto BoreanTundra,57.33,44.08
.turnin 11876 >>Turn in Help Those That Cannot Help Themselves
.goto BoreanTundra,57.05,44.32
.turnin 11865 >>Turn in Unfit for Death
.accept 11868 >>Accept The Culler Cometh
.goto BoreanTundra,56.79,44.04
.target +Zaza
.turnin 11884 >>Turn in Ned, Lord of Rhinos...
.goto BoreanTundra,57.17,43.59,20,0
.goto BoreanTundra,57.33,44.08,15,0
.goto BoreanTundra,57.05,44.32,15,0
.goto BoreanTundra,56.79,44.04
.target +Killinger the Den Watcher
.target Hierophant Cenius
.target Arch Druid Lathorius
step
.goto BoreanTundra,57.2,56.5
>>Kill |cRXP_ENEMY_Karen "I Don't Caribou" the Culler|r
.complete 11868,1 
.mob Karen "I Don't Caribou" the Culler
step
.goto BoreanTundra,57.80,55.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Liandra|r
.turnin 11870 >>Turn in The Abandoned Reach
.accept 11871 >>Accept Not On Our Watch
.target Hierophant Liandra
step
#completewith Liandra
.goto BoreanTundra,60.8,63.1,0
>>Kill |cRXP_ENEMY_Northsea Thugs|r and |cRXP_ENEMY_Northsea Mercenaries|r. Loot them for their |cRXP_LOOT_Ears|r
.complete 11866,1 
.mob Northsea Mercenary
.mob Northsea Thug
step
.goto BoreanTundra,59.2,55.6,50,0
.goto BoreanTundra,58.6,58.3,50,0
.goto BoreanTundra,60.3,58.0,50,0
.goto BoreanTundra,59.7,60.5,50,0
.goto BoreanTundra,60.0,64.1,50,0
.goto BoreanTundra,61.8,63.5
>>Loot the |cRXP_LOOT_Shipments of Animal Parts|r on the ground
.complete 11871,1 
step
#label Liandra
.goto BoreanTundra,57.80,55.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Liandra|r
.turnin 11871 >>Turn in Not On Our Watch
.accept 11872 >>Accept The Nefarious Clam Master...
.target Hierophant Liandra
step
.goto BoreanTundra,59.2,55.6,50,0
.goto BoreanTundra,58.6,58.3,50,0
.goto BoreanTundra,60.3,58.0,50,0
.goto BoreanTundra,59.7,60.5,50,0
.goto BoreanTundra,60.0,64.1,50,0
.goto BoreanTundra,61.8,63.5
>>Kill |cRXP_ENEMY_Northsea Thugs|r and |cRXP_ENEMY_Northsea Mercenaries|r. Loot them for their |cRXP_LOOT_Ears|r
.complete 11866,1 
.mob Northsea Mercenary
.mob Northsea Thug
step
#sticky
#label wine
.goto BoreanTundra,61.90,65.67
>>Open the |cRXP_PICK_Wine Crate|r underwater. Loot it for the |cRXP_LOOT_Kul Tiras Wine|r
.complete 11603,1 
step
.goto BoreanTundra,61.0,66.5,30,0
.goto BoreanTundra,62.5,66.2
>>Kill |cRXP_ENEMY_Clam Master K|r underwater
.complete 11872,1 
.unitscan Clam Master K
step
#requires wine
#completewith next
.goto BoreanTundra,58.5,68.2,100 >> Travel to Valiance Keep
step

.goto BoreanTundra,58.53,68.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Colburn|r
.turnin 11603 >>Turn in In Wine, Truth
.accept 11604 >>Accept A Deserter
.target Old Man Colburn

step
.goto BoreanTundra,57.93,71.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rollick|r
.turnin 13088 >> Turn in Northern Cooking
.isQuestComplete 13088
.skill cooking,<350,1
.target Rollick MacKreel
step
#completewith next
.goto BoreanTundra,56.9,72.2,10 >> Travel to Valiance Keep Prison
step
.goto BoreanTundra,56.68,71.44
>>Run down stairs to the Prison
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brau|r
.turnin 11604 >>Turn in A Deserter
.accept 11932 >>Accept Cowards and Fools
.target Private Brau
step
#completewith next
.goto BoreanTundra,56.9,72.2,10,0
.goto BoreanTundra,58.97,68.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tomas|r
.fly Amber Ledge >> Fly to Amber Ledge
.target Tomas Riverwell
step
>>Kill |cRXP_ENEMY_Beryl Mage Hunters|r. Loot them for a |T134242:0|t[|cRXP_LOOT_Beryl Prison Key|r]
>>|cRXP_WARN_Use the|r |T134242:0|t[|cRXP_LOOT_Beryl Prison Key|r] |cRXP_WARN_on a|r |cRXP_PICK_Arcane Prison|r
>>|cRXP_WARN_Continue opening |cRXP_PICK_Arcane Prisons|r until you are successful in saving an|r |cRXP_FRIENDLY_Arcane Prisoner|r
.collect 34688,1,11587,0x1,-1 
#loop
.line BoreanTundra,42.60,36.75,40.43,39.16,41.78,42.53,42.60,36.75
.goto BoreanTundra,42.60,36.75,20,0
.goto BoreanTundra,40.43,39.16,20,0
.goto BoreanTundra,41.78,42.53,20,0
.goto BoreanTundra,42.60,36.75,20,0
.complete 11587,1 
.goto BoreanTundra,42.60,36.75,40,0
.goto BoreanTundra,40.43,39.16,40,0
.goto BoreanTundra,41.78,42.53
.mob Beryl Mage Hunter
step
#completewith next
.groundgoto BoreanTundra,45.03,37.97,60,0
.goto BoreanTundra,45.26,33.35,50 >> Travel toward |cRXP_FRIENDLY_Donathan|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donathan|r
.turnin 11587 >>Turn in Prison Break
.accept 11590 >>Accept Abduction
.goto BoreanTundra,45.26,33.35
.target Librarian Donathan
step
.goto BoreanTundra,43.2,36.6,60,0
.goto BoreanTundra,41.6,37.4
.use 34691 >>|cRXP_WARN_Damage a |cRXP_ENEMY_Beryl Sorcerer|r to 50% or less health. Do NOT kill the|r |cRXP_ENEMY_Beryl Sorcerer|r
>>|cRXP_WARN_Channel the|r |T133273:0|t[Arcane Binder] |cRXP_WARN_to capture the |cRXP_ENEMY_Beryl Sorcerer|r once it's weakened|r
.complete 11590,1 
.mob Beryl Sorcerer
step
#completewith next
.groundgoto BoreanTundra,45.03,37.97,60,0
.goto BoreanTundra,45.26,33.35,50 >> Travel toward |cRXP_FRIENDLY_Donathan|r
>>|cRXP_WARN_You can ignore the |cRXP_ENEMY_Beryl Sorcerer|r. It will continue to follow you|r
step
.goto BoreanTundra,45.26,33.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donathan|r
.turnin 11590 >>Turn in Abduction
.accept 11646 >>Accept The Borean Inquisition
.target Librarian Donathan
step
#completewith next
.goto BoreanTundra,46.60,32.94,40 >> Enter the Mage Tower. Run up to the first floor
step
.goto BoreanTundra,46.32,32.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Normantis|r
.turnin 11646 >>Turn in The Borean Inquisition
.accept 11648 >>Accept The Art of Persuasion
.target Librarian Normantis
step
.goto BoreanTundra,46.33,32.92
.use 34811 >> |cRXP_WARN_Use the|r |T135470:0|t[Neural Needler] |cRXP_WARN_on the |cRXP_ENEMY_Imprisoned Beryl Sorcerer|r next to |cRXP_FRIENDLY_Normantis|r until the objective completes|r
.complete 11648,1 
.mob Imprisoned Beryl Sorcerer
step
.goto BoreanTundra,46.32,32.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Normantis|r
.turnin 11648 >>Turn in The Art of Persuasion
.accept 11663 >>Accept Sharing Intelligence
.target Librarian Normantis
step
.goto BoreanTundra,45.26,33.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Donathan|r outside
.turnin 11663 >>Turn in Sharing Intelligence
.accept 11671 >>Accept A Race Against Time
.target Librarian Donathan
step
#completewith next
.goto BoreanTundra,41.30,41.79,70,0
.goto BoreanTundra,39.85,42.18,50,0 << !Shaman !DK
.goto BoreanTundra,38.46,43.37,50,0 << !Shaman !DK
.goto BoreanTundra,35.15,43.52,50,0 << !Shaman !DK
.goto BoreanTundra,34.44,42.35,50 >> Travel to The Westrift
>>|cRXP_WARN_Cast |T135863:0|t[Water Walking] to cross the water|r << Shaman
>>|cRXP_WARN_Cast |T237528:0|t[Path of Frost] to cross the water|r << DK
.skill coldweatherflying,1,1
step
.goto BoreanTundra,34.44,42.35
.use 34669 >> |cRXP_WARN_Use the|r |T133015:0|t[Arcanometer] |cRXP_WARN_at the |cRXP_PICK_Cleftcliff Anomaly|r on the ground|r
.complete 11576,1 
.skill coldweatherflying,1,1
step
#completewith next
.goto BoreanTundra,34.44,42.35,100 >> Travel to The Westrift
.skill coldweatherflying,<1,1
step
.goto BoreanTundra,34.44,42.35
.use 34669 >> |cRXP_WARN_Use the|r |T133015:0|t[Arcanometer] |cRXP_WARN_at the |cRXP_PICK_Cleftcliff Anomaly|r on the ground|r
.complete 11576,1 
.skill coldweatherflying,<1,1
step
#completewith next
.goto BoreanTundra,35.15,43.52,40,0 << !Shaman !DK
.goto BoreanTundra,38.46,43.37,50,0 << !Shaman !DK
.goto BoreanTundra,39.85,42.18,50,0 << !Shaman !DK
.goto BoreanTundra,41.30,41.79,70,0
.goto BoreanTundra,41.80,39.16,100 >> Travel back to Beryl Point
>>|cRXP_WARN_Cast |T135863:0|t[Water Walking] to cross the water|r << Shaman
>>|cRXP_WARN_Cast |T237528:0|t[Path of Frost] to cross the water|r << DK
.skill coldweatherflying,1,1
step
#completewith next
.cast 45780 >> |cRXP_WARN_Use the|r |T133709:0|t[Beryl Shield Detonator] |cRXP_WARN_to disable |cRXP_ENEMY_Inquisitor Salrand's|r shield|r
.use 34897
.skill coldweatherflying,1,1
step
.goto BoreanTundra,41.80,39.16
.use 34897 >> Kill |cRXP_ENEMY_Inquisitor Salrand|r. Loot |cRXP_PICK_Salrand's Lockbox|r that she drops on the ground for |cRXP_LOOT_Salrand's Broken Key|r
.complete 11671,1 
.mob Inquisitor Salrand
.skill coldweatherflying,1,1
step
#completewith next
.goto BoreanTundra,41.80,39.16,100 >> Travel to Beryl Point
.skill coldweatherflying,<1,1
step
#completewith next
.cast 45780 >> |cRXP_WARN_Use the|r |T133709:0|t[Beryl Shield Detonator] |cRXP_WARN_to disable |cRXP_ENEMY_Inquisitor Salrand's|r shield|r
.use 34897
.skill coldweatherflying,<1,1
step
.goto BoreanTundra,41.80,39.16
.use 34897 >> Kill |cRXP_ENEMY_Inquisitor Salrand|r. Loot |cRXP_PICK_Salrand's Lockbox|r that she drops on the ground for |cRXP_LOOT_Salrand's Broken Key|r
.complete 11671,1 
.mob Inquisitor Salrand
.skill coldweatherflying,<1,1
step
#completewith next
.groundgoto BoreanTundra,45.03,37.97,60,0
.goto BoreanTundra,45.26,33.35,60 >> Travel to Amber Ledge
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Garren|r, |cRXP_FRIENDLY_Donathan|r and |cRXP_FRIENDLY_Surristrasz|r
.turnin 11576 >>Turn in Monitoring the Rift: Cleftcliff Anomaly
.accept 11582 >>Accept Monitoring the Rift: Sundered Chasm
.goto BoreanTundra,44.98,33.38
.turnin 11671 >>Turn in A Race Against Time
.accept 11679 >>Accept Reforging the Key
.goto BoreanTundra,45.26,33.35
.turnin 11679 >>Turn in Reforging the Key
.accept 11680 >>Accept Taking Wing
.goto BoreanTundra,45.33,34.62
.target Librarian Donathan
.target Librarian Garren
.target Surristrasz
step
.goto BoreanTundra,46.38,37.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anzim|r
.turnin 11680 >>Turn in Taking Wing
.accept 11681 >>Accept Rescuing Evanor
.timer 53,Rescuing Evanor RP
.target Warmage Anzim
step
.goto BoreanTundra,43.01,43.86,-1
.goto BoreanTundra,46.37,32.39,-1
>>|cRXP_WARN_Wait for the flight and RP to finish. You will get teleported to the quest turn in once all RP completes|r
>>|cRXP_WARN_If the event didn't start, abandon Rescuing Evanor and Accept it again|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Evanor|r
.turnin 11681 >>Turn in Rescuing Evanor
.accept 11682 >>Accept Dragonspeak
.target Archmage Evanor
step
.goto BoreanTundra,43.83,29.41
>>|cRXP_WARN_Carefully descend the mountain or jump into the water below|r
.use 34669 >> |cRXP_WARN_Use the|r |T133015:0|t[Arcanometer] |cRXP_WARN_at the |cRXP_PICK_Sundered Chasm|r on the sea floor|r
.complete 11582,1 
.skill coldweatherflying,1,1
step
.goto BoreanTundra,43.83,29.41
>>|cRXP_WARN_Fly into the water below|r
.use 34669 >> |cRXP_WARN_Use the|r |T133015:0|t[Arcanometer] |cRXP_WARN_at the |cRXP_PICK_Sundered Chasm|r on the sea floor|r
.complete 11582,1 
.skill coldweatherflying,<1,1
step
#completewith next
.groundgoto BoreanTundra,45.5,31.2,20,0
.groundgoto BoreanTundra,47.12,29.16,20,0
.goto BoreanTundra,50.07,30.72,80 >> Travel to Coldrock Quarry
step
#completewith next
.goto BoreanTundra,54.1,34.5,0,0
.goto BoreanTundra,52.0,30.6,0
.goto BoreanTundra,50.9,33.4,0
>>Kill |cRXP_ENEMY_Beryl Treasure Hunters|r
.complete 11612,1 
.mob Beryl Treasure Hunter
step
>>Click the markers for |cRXP_PICK_"Elder Kesuk"|r, |cRXP_PICK_"Elder Takret"|r and |cRXP_PICK_"Elder Sagani"|r on the ground
.complete 11605,1 
.goto BoreanTundra,50.86,32.43
.complete 11605,3 
.goto BoreanTundra,52.31,31.13
.complete 11605,2 
.goto BoreanTundra,52.81,34.02
step
.goto BoreanTundra,54.1,34.5,70,0
.goto BoreanTundra,52.0,30.6,70,0
.goto BoreanTundra,50.9,33.4,70,0
.goto BoreanTundra,54.1,34.5
>>Kill |cRXP_ENEMY_Beryl Treasure Hunters|r
.complete 11612,1 
.mob Beryl Treasure Hunter
step
.goto BoreanTundra,54.63,35.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Atkanok|r
.turnin 11605 >>Turn in The Honored Ancestors
.accept 11607 >>Accept The Lost Spirits
step
.goto BoreanTundra,54.29,36.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Etaruk|r
.turnin 11612 >>Turn in Reclaiming the Quarry
.accept 11617 >>Accept Hampering Their Escape
.target Etaruk
step
#label cores
#completewith coresEnd
.waypoint BoreanTundra,51.7,31.6,15,0
.waypoint BoreanTundra,52.3,31.0,40,0
.waypoint BoreanTundra,51.0,32.3,40,0
.goto BoreanTundra,51.7,31.6,0,0
>>Kill |cRXP_ENEMY_Beryl Hounds|r. Loot them for their |T134337:0|t[|cRXP_LOOT_Cores of Malice|r]
.use 34711 >>|cRXP_WARN_Use the|r |T134337:0|t[|cRXP_LOOT_Cores of Malice|r] |cRXP_WARN_on |cRXP_FRIENDLY_Kaskala Craftsmen|r and|r |cRXP_FRIENDLY_Kaskala Shaman|r
.collect 34711,6,11607,0x3,-1 
.complete 11607,1 
.complete 11607,2 
.mob Beryl Hound
step
.goto BoreanTundra,52.6,35.5
>>Kill |cRXP_ENEMY_Beryl Reclaimers|r. Loot them for their |T133717:0|t[|cRXP_LOOT_Gnomish Grenades|r]
>>|cRXP_WARN_Stand at the edge of the cliff|r
.use 34772 >> |cRXP_WARN_Use the|r |T133717:0|t[|cRXP_LOOT_Gnomish Grenades|r] |cRXP_WARN_to destroy the|r |cRXP_PICK_East Platform|r
.collect 34772,3,11617,0x7,-1 
.complete 11617,1 
.mob Beryl Reclaimer
step
.goto BoreanTundra,50.3,34.1
>>Kill |cRXP_ENEMY_Beryl Reclaimers|r. Loot them for their |T133717:0|t[|cRXP_LOOT_Gnomish Grenades|r]
>>|cRXP_WARN_Stand at the edge of the cliff|r
.use 34772 >> |cRXP_WARN_Use the|r |T133717:0|t[|cRXP_LOOT_Gnomish Grenades|r] |cRXP_WARN_to destroy the|r |cRXP_PICK_West Platform|r
.collect 34772,3,11617,0x7,-1 
.complete 11617,3 
.mob Beryl Reclaimer
step
#label North
.goto BoreanTundra,52.6,32.4
>>Kill |cRXP_ENEMY_Beryl Reclaimers|r. Loot them for their |T133717:0|t[|cRXP_LOOT_Gnomish Grenades|r]
>>|cRXP_WARN_Stand directly below the|r |cRXP_PICK_North Platform|r
.use 34772 >> |cRXP_WARN_Use the|r |T133717:0|t[|cRXP_LOOT_Gnomish Grenades|r] |cRXP_WARN_to destroy the|r |cRXP_PICK_North Platform|r
.collect 34772,3,11617,0x7,-1 
.complete 11617,2 
.mob Beryl Reclaimer
step
#requires cores
#label coresEnd
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Atkanok|r and |cRXP_FRIENDLY_Etaruk|r
.turnin 11607 >>Turn in The Lost Spirits
.accept 11609 >>Accept Picking Up the Pieces
.goto BoreanTundra,54.63,35.88
.turnin 11617 >>Turn in Hampering Their Escape
.accept 11623 >>Accept A Visit to the Curator
.goto BoreanTundra,54.29,36.09
.target Etaruk
step
#completewith next
.goto BoreanTundra,51.2,36.5,50,0
.goto BoreanTundra,52.9,32.6,0
>>Loot the |cRXP_LOOT_Tuskarr Ritual Objects|r on the ground
>>|cRXP_WARN_They look like White and Blue Incense Holders or Anvils|r
.complete 11609,1 
step
.goto BoreanTundra,50.1,32.6
>>Kill |cRXP_ENEMY_Curator Insivius|r
.complete 11623,1 
.mob Curator Insivius
step
.goto BoreanTundra,52.9,32.6,70,0
.goto BoreanTundra,53.9,35.0,70,0
.goto BoreanTundra,50.9,33.2
>>Loot the |cRXP_LOOT_Tuskarr Ritual Objects|r on the ground
>>|cRXP_WARN_They look like White and Blue Incense Holders or Anvils|r
.complete 11609,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Atkanok|r and |cRXP_FRIENDLY_Etaruk|r
.turnin 11609 >>Turn in Picking Up the Pieces
.accept 11610 >>Accept Leading the Ancestors Home
.goto BoreanTundra,54.63,35.88
.turnin 11623 >>Turn in A Visit to the Curator
.goto BoreanTundra,54.29,36.09
.target Etaruk
step
.use 34715 >>|cRXP_WARN_Use the|r |T134378:0|t[Tuskarr Ritual Object] |cRXP_WARN_next to the markers for |cRXP_PICK_"Elder Sagani"|r, |cRXP_PICK_"Elder Takret"|r and|r |cRXP_PICK_"Elder Kesuk"|r
>>|cRXP_WARN_Do NOT wait for the RP|r
.complete 11610,2 
.goto BoreanTundra,52.81,34.04
.complete 11610,3 
.goto BoreanTundra,52.32,31.15
.complete 11610,1 
.goto BoreanTundra,50.85,32.40
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Atkanok|r
.turnin 11610 >>Turn in Leading the Ancestors Home
.goto BoreanTundra,54.63,35.88
step
#completewith next
.goto BoreanTundra,57.05,44.32,120 >> Travel to the D.E.H.T.A. Encampment
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zaza|r, |cRXP_FRIENDLY_Lathorius|r and |cRXP_FRIENDLY_Cenius|r
.turnin 11868 >>Turn in The Culler Cometh
.goto BoreanTundra,56.80,44.04
.turnin 11866 >>Turn in Ears of Our Enemies
.accept 11878 >>Accept Khu'Nok Will Know
.goto BoreanTundra,57.05,44.32
.turnin 11872 >>Turn in The Nefarious Clam Master...
.goto BoreanTundra,57.33,44.08
.target Hierophant Cenius
.target Zaza
.target Arch Druid Lathorius
step << skip
.goto BoreanTundra,57.0,44.3,0
.goto BoreanTundra,59.25,30.83
>>Escort the |cRXP_FRIENDLY_Mammoth Calf|r north to |cRXP_FRIENDLY_Khu'Nok|r. |cRXP_WARN_Don't travel out of render range (100 yards) as this will despawn the Calf|r.
>>|cRXP_WARN_If the Calf despawns, abandon and retake the quest from|r |cRXP_FRIENDLY_Lathorius|r
.complete 11878,1 
.target Khu'nok the Behemoth
.target Arch Druid Lathorius
step
#completewith next
.goto BoreanTundra,59.43,30.38,80 >> Travel toward |cRXP_FRIENDLY_Khu'nok|r
step
.goto BoreanTundra,59.43,30.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Khu'nok|r
.turnin 11878 >>Turn in Khu'nok Will Know
.accept 11879 >>Accept Kaw the Mammoth Destroyer
.target Khu'nok the Behemoth
step
#completewith next
.goto BoreanTundra,53.7,24.4
.vehicle >>Click on a |cRXP_FRIENDLY_Wooly Mammoth Bull|r to Mount it
.unitscan Wooly Mammoth Bull
step
.goto BoreanTundra,53.84,24.08
>>Engage |cRXP_ENEMY_Kaw the Mammoth Destroyer|r by running near him
>>|cRXP_WARN_Cast|r |T132337:0|t[Mammoth Charge] (2) |cRXP_WARN_to deal damage and stun for 3 seconds|r
>>|cRXP_WARN_Cast|r |T132255:0|t[Mammoth Trample] (1) |cRXP_WARN_to deal significant damage when in melee range|r
>>|cRXP_WARN_Alternatively, if your damage is high, you can kill |cRXP_ENEMY_Kaw the Mammoth Destroyer|r faster whilst dismounted|r
>>Kill |cRXP_ENEMY_Kaw the Mammoth Destroyer|r. Dismount the |cRXP_FRIENDLY_Wooly Mammoth Bull|r. Loot |cRXP_LOOT_Kaw's War Halberd|r on the ground
.complete 11879,1 
.mob Kaw the Mammoth Destroyer
step
#completewith next
.goto BoreanTundra,56.56,20.07,100 >> Travel to Fizzcrank Airstrip
step
.goto BoreanTundra,56.56,20.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kara|r
.fp Fizzcrank >> Get the Fizzcrank Airstrip Flight Path
.target Kara Thricestar
step
#completewith next
.goto BoreanTundra,57.05,44.32,120 >> Travel to the D.E.H.T.A. Encampment
step
.goto BoreanTundra,57.05,44.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lathorious|r
.turnin 11879 >>Turn in Kaw the Mammoth Destroyer
.accept 11892 >>Accept The Assassination of Harold Lane
.target Arch Druid Lathorius
step
.goto BoreanTundra,49.90,41.50
.use 35293 >>Kill |cRXP_ENEMY_Harold Lane|r
>>|cRXP_WARN_Use the|r |T134229:0|t[Cenarion Horn] |cRXP_WARN_to summon |cRXP_FRIENDLY_Stampeding Mammoths|r which will deal significant damage to |cRXP_ENEMY_Harold Lane|r. Move away from any traps he places
>>|cRXP_WARN_This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r
.complete 11892,1 
.unitscan Harold Lane
.isOnQuest 11892
step
.goto BoreanTundra,57.05,44.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lathorious|r
.turnin 11892 >>Turn in The Assassination of Harold Lane
.isQuestComplete 11892
.target Arch Druid Lathorius
step
#sticky
#label AbandonAss
.goto BoreanTundra,63.8,46.1
.abandon 11892 >> Abandon The Assassination of Harold Lane
step
#completewith next
.goto BoreanTundra,63.80,46.12,80 >> Travel to Kaskala
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ataika|r and |cRXP_FRIENDLY_Utaik|r
.turnin 11932 >>Turn in Cowards and Fools
.accept 12086 >>Accept The Son of Karkut
.accept 11949 >>Accept Not Without a Fight!
.goto BoreanTundra,63.80,46.12
.daily 11945 >>Accept Preparing for the Worst
.goto BoreanTundra,63.95,45.72
.target Ataika
.target Utaik
step
#requires AbandonAss
#completewith Raiders
.goto BoreanTundra,66.2,45.9,0
.goto BoreanTundra,63.7,52.2,0
>>Loot the |cRXP_LOOT_Kaskala Supplies|r on the ground
.complete 11945,1 
.isOnQuest 11945
step << !DK
#requires AbandonAss
.goto BoreanTundra,67.3,47.7,60,0
.goto BoreanTundra,63.61,53.93
>>Kill |cRXP_ENEMY_Kvaldir Raiders|r
.complete 11949,1 
.skill coldweatherflying,1,1
.mob Kvaldir Raider
step
#requires AbandonAss
#label Raiders
.goto BoreanTundra,67.3,47.7,60,0
.goto BoreanTundra,63.61,53.93,60,0
.goto BoreanTundra,66.38,55.90,60,0
.goto BoreanTundra,67.96,56.69
>>Kill |cRXP_ENEMY_Kvaldir Raiders|r
.complete 11949,1 
.skill coldweatherflying,<1,1 << !DK
.mob Kvaldir Raider
step
.goto BoreanTundra,67.3,47.7,60,0
.goto BoreanTundra,63.61,53.93,60,0
.goto BoreanTundra,66.38,55.90,60,0
.goto BoreanTundra,67.96,56.69
>>Loot the |cRXP_LOOT_Kaskala Supplies|r on the ground
.complete 11945,1 
.isOnQuest 11945
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ataika|r and |cRXP_FRIENDLY_Utaik|r
.turnin 11949 >>Turn in Not Without a Fight!
.accept 11950 >>Accept Muahit's Wisdom
.goto BoreanTundra,63.80,46.12
.turnin 11945 >>Turn in Preparing for the Worst
.goto BoreanTundra,63.95,45.72
.isOnQuest 11945
.target Ataika
.target Utaik
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ataika|r
.turnin 11949 >>Turn in Not Without a Fight!
.accept 11950 >>Accept Muahit's Wisdom
.goto BoreanTundra,63.80,46.12
.target Ataika
step
#completewith next
.goto BoreanTundra,67.21,54.86,100 >> Travel toward |cRXP_FRIENDLY_Muahit|r
step
.goto BoreanTundra,67.21,54.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Muahit|r
.turnin 11950 >>Turn in Muahit's Wisdom
.accept 11961 >>Accept Spirits Watch Over Us
.target Elder Muahit
step
.goto BoreanTundra,67.65,50.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Iruk's|r corpse underwater
.complete 11961,1 
.skipgossip
.target Iruk
step
.goto BoreanTundra,67.21,54.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Muahit|r
.turnin 11961 >>Turn in Spirits Watch Over Us
.accept 11968 >>Accept The Tides Turn
.target Elder Muahit
step
.goto BoreanTundra,67.41,56.87
>>Kill |cRXP_ENEMY_Heigarr the Horrible|r
>>|cRXP_WARN_You may not get credit the first time if his health is below 50%|r
.complete 11968,1 
.unitscan Heigarr the Horrible
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Muahit|r and |cRXP_FRIENDLY_Hotawa|r
.turnin 11968 >>Turn in The Tides Turn
.goto BoreanTundra,67.21,54.86
.accept 12117 >>Accept Travel to Moa'ki Harbor
.goto BoreanTundra,67.27,54.86
.target Elder Muahit
.target Hotawa
step << skip
.goto BoreanTundra,78.5,51.5
>>Travel to Unu'pe
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bilko|r
.fp Unu'pe >> Get the Unu'pe flight path
.target Bilko Driftspark
step
#completewith next
.goto BoreanTundra,82.01,46.42,100 >> Travel to Death's Stand
step
.goto BoreanTundra,82.01,46.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Venn|r
.turnin 12086 >>Turn in The Son of Karkut
.accept 11944 >>Accept Surrounded!
.target Corporal Venn
step
#level 71
.goto BoreanTundra,82.17,46.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Casey|r
.accept 12157 >>Accept The Lost Courier
.target Private Casey
step
.goto BoreanTundra,81.46,43.80,50,0
.goto BoreanTundra,82.78,43.69,50,0
.goto BoreanTundra,83.24,40.40,50,0
.goto BoreanTundra,81.46,43.80
>>Kill |cRXP_ENEMY_Ziggurat Defenders|r
.complete 11944,1 
.mob Ziggurat Defender
step
.goto BoreanTundra,82.01,46.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Venn|r
.turnin 11944 >>Turn in Surrounded!
.accept 12088 >>Accept Thassarian, the Death Knight
.target Corporal Venn
step
#completewith next
.goto BoreanTundra,84.7,41.0,30 >> Travel toward |cRXP_FRIENDLY_Thassarian|r inside the Ziggurat
step
.goto BoreanTundra,84.80,41.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 12088 >>Turn in Thassarian, the Death Knight
.accept 11956 >>Accept Finding the Phylactery
.target Thassarian
step
.goto BoreanTundra,85.40,33.34
>>Click the |cRXP_PICK_Frozen Phylactery|r underwater to summon the |cRXP_ENEMY_Phylactery Guardian|r
>>Kill the |cRXP_ENEMY_Phylactery Guardian|r. Loot it for |cRXP_LOOT_Tanathal's Phylactery|r
.complete 11956,1 
.mob Phylactery Guardian
step
.goto BoreanTundra,84.80,41.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 11956 >>Turn in Finding the Phylactery
.accept 11938 >>Accept Buying Some Time
.target Thassarian
step
.goto BoreanTundra,84.42,32.06,60,0
.goto BoreanTundra,83.35,30.70,60,0
.goto BoreanTundra,85.28,28.18,60,0
.goto BoreanTundra,86.85,28.94,60,0
.goto BoreanTundra,88.14,27.45,60,0
.goto BoreanTundra,84.49,24.31,60,0
.goto BoreanTundra,85.7,27.3
.use 35944 >>Kill the |cRXP_ENEMY_En'kilah|r
>>|cRXP_WARN_Use|r |T133730:0|t[Lurid's Bones] |cRXP_WARN_to summon |cRXP_FRIENDLY_Lurid|r to help you kill the|r |cRXP_ENEMY_En'kilah|r
.complete 11938,1 
.mob En'kilah Necromancer
.mob En'kilah Abomination
.mob En'kilah Crypt Fiend
.mob En'kilah Gargoyle
.mob En'kilah Ghoul
.mob En'kilah Necrolord
step
.goto BoreanTundra,84.80,41.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 11938 >>Turn in Buying Some Time
.accept 11942 >>Accept Words of Power
.target Thassarian
step
#completewith next
.groundgoto BoreanTundra,85.0,28.9,70,0
.goto BoreanTundra,88.59,28.30,40 >> Travel to the Spire of Pain in En'kilah
step
.goto BoreanTundra,89.38,28.86
>>Kill the |cRXP_ENEMY_Mystical Webbings|r to free |cRXP_ENEMY_High Priest Talet-Kha|r
>>Kill |cRXP_ENEMY_High Priest Talet-Kha|r. Loot him for his |cRXP_LOOT_Scroll|r
.complete 11942,3 
.mob High Priest Talet-Kha
.mob Mystical Webbing
.mob En'kilah Crypt Fiend
step
#completewith next
.groundgoto BoreanTundra,87.7,22.0,40,0
.goto BoreanTundra,88.68,21.72,25 >> Travel to the Spire of Blood in En'kilah. Enter through the side entrance
step
.goto BoreanTundra,88.05,20.94
>>Kill |cRXP_ENEMY_High Priest Andorath|r. Loot him for his |cRXP_LOOT_Scroll|r
.complete 11942,1 
.mob High Priest Andorath
step
#completewith next
.goto BoreanTundra,84.2,21.8,40 >> Travel to the Spire of Decay
step
.goto BoreanTundra,83.9,20.5
>>Kill the |cRXP_ENEMY_En'kilah Necromancers|r to free |cRXP_ENEMY_High Priest Naferset|r
>>Kill |cRXP_ENEMY_High Priest Naferset|r. Loot him for his |cRXP_LOOT_Scroll|r
.complete 11942,2 
.mob High Priest Naferset
.mob En'kilah Necromancer
step
.goto BoreanTundra,84.80,41.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 11942 >>Turn in Words of Power
.accept 12019 >>Accept Last Rites
.target Thassarian
step
#completewith next
.goto BoreanTundra,86.5,28.7,15 >> |cRXP_WARN_Take the teleporter up to the Ziggurat in the sky|r
.goto BoreanTundra,86.7,30.2,8 >>|cRXP_WARN_After taking the 1st teleporter, take the 2nd (blue) teleporter directly above the green circle where you first entered|r
.isOnQuest 12019
step
.goto BoreanTundra,86.64,31.38
.gossipoption 93099 >> Talk to |cRXP_FRIENDLY_Thassarian|r to start the RP
.timer 142,Last Rites RP
.skipgossip
.target Thassarian
.isOnQuest 12019
step
>>Kill |cRXP_ENEMY_Prince Valanar|r
>>|cRXP_WARN_Let |cRXP_FRIENDLY_Thassarian|r tank |cRXP_ENEMY_Prince Valanar|r for a few seconds before you start doing damage|r
>>|cRXP_WARN_BEWARE OF|r |T136157:0|t[Soul Deflection]
>>|cRXP_WARN_THIS DEBUFF |cRXP_ENEMY_Prince Valanar|r APPLIES TO YOU REFLECTS 100% OF THE DAMAGE YOU DEAL FOR 6 SECONDS. STOP ATTACKING DURING THIS. IF YOU HAVE DoT's ON |cRXP_ENEMY_Prince Valanar|r THEY WILL ALSO BE REFLECTED|r
>>|cRXP_WARN_This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r
.complete 12019,1 
.goto BoreanTundra,86.7,30.2
.mob Prince Valanar
step
.goto BoreanTundra,86.80,30.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r atop the Ziggurat
.turnin 12019 >>Turn in Last Rites
.target Thassarian
step
#completewith next
.goto BoreanTundra,86.96,28.93,12,0
.goto BoreanTundra,86.96,28.93,10 >>|cRXP_WARN_Take the teleporters down to the ground|r
step
#completewith next
.groundgoto BoreanTundra,85.15,28.46,50,0
.goto Dragonblight,29.15,55.32,150 >> Travel to Stars' Rest in Dragonblight
step
.goto Dragonblight,29.15,55.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Palena|r
.fp Stars' Rest >> Get the Stars' Rest Flight Path
.target Palena Silvercloud
step
.goto Dragonblight,28.83,56.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lanson|r
>>|cRXP_WARN_Don't accept the next quest|r
.turnin 12157 >>Turn in The Lost Courier
.isOnQuest 12157
.target Courier Lanson
step
#completewith GarrenM
.hs >> Hearth to Valiance Keep
step
#completewith GarrenM
.goto BoreanTundra,44.98,33.38,100 >> Travel to Amber Ledge
.skill coldweatherflying,<1,1
step
#completewith GarrenM
.goto BoreanTundra,58.97,68.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tomas|r
.fly Amber Ledge >>Fly to Amber Ledge
.skill coldweatherflying,1,1
.skill riding,300,1
.target Tomas Riverwell
step
#label GarrenM
.goto BoreanTundra,44.98,33.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Garren|r
.turnin 11582 >>Turn in Monitoring the Rift: Sundered Chasm
.accept 12728 >>Accept Monitoring the Rift: Winterfin Cavern
.target Librarian Garren
step 
.goto BoreanTundra,45.33,34.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Surristrasz|r
>>|cRXP_WARN_This will fly you to Coldarra. This flight takes 1m 2s|r
.turnin 11682 >>Turn in Dragonspeak
.accept 11733 >>Accept Traversing the Rift
.timer 62,Coldarra flight
.target Surristrasz
step
#completewith next
.goto BoreanTundra,45.33,34.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Surristrasz|r
.fly Coldarra >> Fly to Coldarra
.target Surristrasz
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Berinand|r, |cRXP_FRIENDLY_Raelorasz|r and |cRXP_FRIENDLY_Serrah|r
.turnin 11733 >>Turn in Traversing the Rift
.accept 11900 >>Accept Reading the Meters
.accept 11910 >>Accept Secrets of the Ancients
.goto BoreanTundra,32.94,34.40
.accept 11918 >>Accept Basic Training
.goto BoreanTundra,33.32,34.54
.accept 11912 >>Accept Nuts for Berries
.goto BoreanTundra,33.49,34.38
.target Archmage Berinand
.target Raelorasz
.target Librarian Serrah
step
#sticky
#completewith Weaver1
>>Kill |cRXP_ENEMY_Coldarra Spellweavers|r
>>Open |cRXP_PICK_Frostberry Bushes|r. Loot them for |cRXP_LOOT_Frostberries|r
.complete 11918,1 
.complete 11912,1 
.mob Coldarra Spellweaver
step
.goto BoreanTundra,32.69,27.79,70,0
.goto BoreanTundra,33.45,25.68,70,0
.goto BoreanTundra,33.73,29.97,70,0
.goto BoreanTundra,31.54,28.28,70,0
.goto BoreanTundra,34.79,26.95
.use 35648 >>Kill |cRXP_ENEMY_Coldarra Spellbinders|r. Loot them for their |T134923:0|t[|cRXP_LOOT_Scintillating Fragment|r]
>>|cRXP_WARN_Use the |T134923:0|t[|cRXP_LOOT_Scintillating Fragment|r] to start the quest|r
.collect 35648,1,11941,1 
.accept 11941 >>Accept Puzzling...
.mob Coldarra Spellbinder
step
.goto BoreanTundra,33.31,34.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Raelorasz|r
.turnin 11941 >>Turn in Puzzling...
.accept 11943 >>Accept The Cell
.target Raelorasz
step
#completewith splinters
>>Kill |cRXP_ENEMY_Glacial Ancients|r and |cRXP_ENEMY_Magic-bound Ancients|r. Loot them for their |cRXP_LOOT_Splinters|r
.complete 11910,1 
.complete 11910,2 
.mob Glacial Ancient
.mob Magic-bound Ancient
step
.goto BoreanTundra,28.81,34.91,-1
.goto BoreanTundra,28.25,35.04,-1
>>Click the |cRXP_PICK_Coldarra Geological Monitor|r on the ground
.complete 11900,2 
step
.goto BoreanTundra,24.14,29.60
>>Kill |cRXP_ENEMY_Warbringer Goredrak|r. Loot him for his |cRXP_LOOT_Energy Core|r
.complete 11943,1 
.mob Warbringer Goredrak
step
.goto BoreanTundra,22.36,24.21,-1
.goto BoreanTundra,22.62,23.42,-1
>>Click the |cRXP_PICK_Coldarra Geological Monitor|r on the ground
.complete 11900,4 
step
.goto BoreanTundra,27.32,20.41
>>Kill |cRXP_ENEMY_General Cerulean|r. Loot him for his |cRXP_LOOT_Prison Casing|r
.complete 11943,2 
.mob General Cerulean
step
#label Weaver1
.goto BoreanTundra,31.25,20.18,-1
.goto BoreanTundra,31.72,20.57,-1
>>Click the |cRXP_PICK_Coldarra Geological Monitor|r on the ground
.complete 11900,3 
step
#sticky
#label berries2
#loop
.goto BoreanTundra,33.7,23.1,100,0
.goto BoreanTundra,34.3,31.2,100,0
.goto BoreanTundra,24.4,35.2,100,0
.goto BoreanTundra,21.5,26.9,100,0
.goto BoreanTundra,21.5,26.9,0
.goto BoreanTundra,24.4,35.2,0
.goto BoreanTundra,34.3,31.2,0
.goto BoreanTundra,33.7,23.1,0
>>Kill |cRXP_ENEMY_Coldarra Spellweavers|r
.complete 11918,1 
.mob Coldarra Spellweaver
step
#loop
.goto BoreanTundra,33.7,23.1,100,0
.goto BoreanTundra,34.3,31.2,100,0
.goto BoreanTundra,24.4,35.2,100,0
.goto BoreanTundra,21.5,26.9,100,0
.goto BoreanTundra,21.5,26.9,0
.goto BoreanTundra,24.4,35.2,0
.goto BoreanTundra,34.3,31.2,0
.goto BoreanTundra,33.7,23.1,0
>>Open |cRXP_PICK_Frostberry Bushes|r. Loot them for |cRXP_LOOT_Frostberries|r
.complete 11912,1 
step
#completewith next
.goto BoreanTundra,33.49,34.38,100 >> Travel to Transitus
step
#requires berries2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Serrah|r and |cRXP_FRIENDLY_Raelorasz|r
.turnin 11912 >>Turn in Nuts for Berries
.accept 11914 >>Accept Keep the Secret Safe
.goto BoreanTundra,33.49,34.38
.turnin 11918 >>Turn in Basic Training
.accept 11936 >>Accept Hatching a Plan
.turnin 11943 >>Turn in The Cell
.goto BoreanTundra,33.32,34.54
.target Raelorasz
.target Librarian Serrah
step
.use 35671 >> |cRXP_WARN_Use the|r |T133836:0|t[Augmented Arcane Prison] |cRXP_WARN_to summon|r |cRXP_FRIENDLY_Keristrasza|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keristrasza|r
.accept 11946 >>Accept Keristrasza
.turnin 11946 >>Turn in Keristrasza
.accept 11951 >>Accept Bait and Switch
.target Keristrasza
step
#completewith next
#loop
.line BoreanTundra,28.69,30.93,30.12,28.57,29.84,24.39,27.68,22.32,25.25,24.59,25.39,28.67
.goto BoreanTundra,28.69,30.93,40,0
.goto BoreanTundra,30.12,28.57,40,0
.goto BoreanTundra,29.84,24.39,40,0
.goto BoreanTundra,27.68,22.32,40,0
.goto BoreanTundra,25.25,24.59,40,0
.goto BoreanTundra,25.39,28.67,40,0
>>Open the |cRXP_PICK_Crystallized Mana|r. Loot them for the |cRXP_LOOT_Crystallized Mana Shards|r
.complete 11951,1 
step
.goto BoreanTundra,29.5,30.81,90,0
.goto BoreanTundra,28.7,33.6,70,0
.goto BoreanTundra,27.5,31.3,70,0
.goto BoreanTundra,24.9,31.2,70,0
.goto BoreanTundra,25.2,24.2
>>Kill |cRXP_ENEMY_Coldarra Wyrmkins|r. Loot them for their |T132394:0|t[|cRXP_LOOT_Frozen Axes|r]
.collect 35586,5,11936,1 
.mob Coldarra Wyrmkin
step
#loop
.line BoreanTundra,28.69,30.93,30.12,28.57,29.84,24.39,27.68,22.32,25.25,24.59,25.39,28.67
.goto BoreanTundra,28.69,30.93,40,0
.goto BoreanTundra,30.12,28.57,40,0
.goto BoreanTundra,29.84,24.39,40,0
.goto BoreanTundra,27.68,22.32,40,0
.goto BoreanTundra,25.25,24.59,40,0
.goto BoreanTundra,25.39,28.67,40,0
>>Open the |cRXP_PICK_Crystallized Mana|r. Loot them for the |cRXP_LOOT_Crystallized Mana Shards|r
.complete 11951,1 
step
#sticky
#label reading
.goto BoreanTundra,28.31,28.46
>>Click the |cRXP_PICK_Coldarra Geological Monitor|r on the ground
.complete 11900,1 
step
#label splinters
.goto BoreanTundra,29.3,27.4,50,0
.goto BoreanTundra,28.2,24.4,50,0
.goto BoreanTundra,26.2,25.4,50,0
.goto BoreanTundra,26.04,27.72,50,0
.goto BoreanTundra,28.31,28.46,50,0
.goto BoreanTundra,29.3,27.4,50,0
.goto BoreanTundra,28.2,24.4,50,0
.goto BoreanTundra,26.2,25.4,50,0
.goto BoreanTundra,26.04,27.72,50,0
.goto BoreanTundra,28.31,28.46
>>Kill |cRXP_ENEMY_Arcane Serpents|r. Loot them for their |cRXP_LOOT_Essences|r
>>|cRXP_WARN_Use the|r |T132394:0|t[|cRXP_LOOT_Frozen Axes|r] |cRXP_WARN_on the|r |cRXP_PICK_Blue Dragon Eggs|r
.collect 35586,5,11936,1,-1 
.complete 11936,1 
.complete 11914,1 
.mob Arcane Serpent
step
#requires reading
.goto BoreanTundra,30.1,23.4,70,0
.goto BoreanTundra,32.6,28.2,70,0
.goto BoreanTundra,28.0,33.5,70,0
.goto BoreanTundra,25.0,30.6,70,0
.goto BoreanTundra,25.5,35.6
>>Kill |cRXP_ENEMY_Glacial Ancients|r and |cRXP_ENEMY_Magic-bound Ancients|r. Loot them for their |cRXP_LOOT_Splinters|r
.complete 11910,1 
.complete 11910,2 
.mob Glacial Ancient
.mob Magic-bound Ancient
step
.use 35671 >> |cRXP_WARN_Use the|r |T133836:0|t[Augmented Arcane Prison] |cRXP_WARN_to summon|r |cRXP_FRIENDLY_Keristrasza|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keristrasza|r
>>|cRXP_WARN_If you lost it, Talk to |cRXP_FRIENDLY_Raelorasz|r for a new one|r
.turnin 11951 >>Turn in Bait and Switch
.accept 11957 >>Accept Saragosa's End
.target Keristrasza
.target Raelorasz
step
.gossipoption 93094 >> Talk to |cRXP_FRIENDLY_Keristrasza|r to teleport to Saragosa's Landing
.skipgossip
.target Keristrasza
.use 35671
.isOnQuest 11957
step
#completewith next
.goto BoreanTundra,21.30,22.44
.cast 46793 >>|cRXP_WARN_Use the|r |T132866:0|t[Arcane Power Focus] |cRXP_WARN_to summon|r |cRXP_ENEMY_Saragosa|r
.timer 21,Saragosa's End RP
.use 35690
step
>>Kill |cRXP_ENEMY_Saragosa|r. Loot her for her |cRXP_LOOT_Corpse|r
.complete 11957,1 
.goto BoreanTundra,22.07,22.65
.use 35690
.skipgossip
.mob Saragosa
step
.use 35671 >> |cRXP_WARN_Use the|r |T133836:0|t[Augmented Arcane Prison] |cRXP_WARN_to summon|r |cRXP_FRIENDLY_Keristrasza|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keristrasza|r
.turnin 11957 >>Turn in Saragosa's End
.accept 11967 >>Accept Mustering the Reds
.goto BoreanTundra,21.57,22.55
.cooldown item,6948,>2
.target Keristrasza
step
.use 35671 >> |cRXP_WARN_Use the|r |T133836:0|t[Augmented Arcane Prison] |cRXP_WARN_to summon|r |cRXP_FRIENDLY_Keristrasza|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keristrasza|r
.turnin 11957 >>Turn in Saragosa's End
.accept 11967 >>Accept Mustering the Reds
.goto BoreanTundra,21.57,22.55
.skill coldweatherflying,1,1
.target Keristrasza

step
#questguide
.goto BoreanTundra,21.6,22.5,0
>>|cRXP_WARN_DO NOT Ride back to Transitus|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keristrasza|r for a teleport back to Transitus
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Serrah|r, |cRXP_FRIENDLY_Raelorasz|r and |cRXP_FRIENDLY_Berinand|r
.turnin 11914 >>Turn in Keep the Secret Safe
.goto BoreanTundra,33.49,34.38
.turnin 11967 >>Turn in Mustering the Reds
.turnin 11936 >>Turn in Hatching a Plan
.accept 11969 >>Accept Springing the Trap
.accept 11919 >>Accept Drake Hunt
.goto BoreanTundra,33.32,34.54
.turnin 11900 >>Turn in Reading the Meters
.turnin 11910 >>Turn in Secrets of the Ancients
.goto BoreanTundra,32.94,34.40
.skipgossip
.isOnQuest 11967
.target Keristrasza
.target Archmage Berinand
.target Raelorasz
.target Librarian Serrah
step
#questguide
.goto BoreanTundra,21.6,22.5,0
>>Fly back to Transitus
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Serrah|r, |cRXP_FRIENDLY_Raelorasz|r and |cRXP_FRIENDLY_Berinand|r
.turnin 11914 >>Turn in Keep the Secret Safe
.goto BoreanTundra,33.49,34.38
.turnin 11936 >>Turn in Hatching a Plan
.accept 11919 >>Accept Drake Hunt
.goto BoreanTundra,33.32,34.54
.turnin 11900 >>Turn in Reading the Meters
.turnin 11910 >>Turn in Secrets of the Ancients
.goto BoreanTundra,32.94,34.40
.skipgossip
.target Archmage Berinand
.target Raelorasz
.target Librarian Serrah
step
.goto BoreanTundra,21.6,22.5,0
>>|cRXP_WARN_DO NOT Ride back to Transitus|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keristrasza|r for a teleport back to Transitus
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Serrah|r, |cRXP_FRIENDLY_Raelorasz|r and |cRXP_FRIENDLY_Berinand|r
.turnin 11914 >>Turn in Keep the Secret Safe
.goto BoreanTundra,33.49,34.38
.turnin 11967 >>Turn in Mustering the Reds
.turnin 11936 >>Turn in Hatching a Plan
.goto BoreanTundra,33.32,34.54
.turnin 11900 >>Turn in Reading the Meters
.turnin 11910 >>Turn in Secrets of the Ancients
.goto BoreanTundra,32.94,34.40
.skipgossip
.isOnQuest 11967
.target Keristrasza
.target Archmage Berinand
.target Raelorasz
.target Librarian Serrah
step
>>Fly back to Transitus
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Serrah|r, |cRXP_FRIENDLY_Raelorasz|r and |cRXP_FRIENDLY_Berinand|r
.turnin 11914 >>Turn in Keep the Secret Safe
.goto BoreanTundra,33.49,34.38
.turnin 11936 >>Turn in Hatching a Plan
.goto BoreanTundra,33.32,34.54
.turnin 11900 >>Turn in Reading the Meters
.turnin 11910 >>Turn in Secrets of the Ancients
.goto BoreanTundra,32.94,34.40
.skill coldweatherflying,<1,1
.target Archmage Berinand
.target Raelorasz
.target Librarian Serrah
step
.use 35671 >> |cRXP_WARN_Use the|r |T133836:0|t[Augmented Arcane Prison] |cRXP_WARN_to summon|r |cRXP_FRIENDLY_Keristrasza|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keristrasza|r
.turnin 11957 >>Turn in Saragosa's End
.accept 11967 >>Accept Mustering the Reds
.goto BoreanTundra,21.57,22.55
.skill coldweatherflying,<1,1
.target Keristrasza
step
#questguide
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Raelorasz|r
.turnin 11967 >>Turn in Mustering the Reds
.accept 11969 >>Accept Springing the Trap
.goto BoreanTundra,33.32,34.54
.target Raelorasz
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Raelorasz|r
.turnin 11967 >>Turn in Mustering the Reds
.goto BoreanTundra,33.32,34.54
.skill coldweatherflying,<1,1
.target Raelorasz

step
#questguide
.goto BoreanTundra,25.34,21.82
.cast 62272 >> |cRXP_WARN_Use|r |T132862:0|t[Raelorasz' Spark] |cRXP_WARN_next to the|r |cRXP_PICK_Signal Fire|r
.timer 195,Springing the Trap RP
>>|cRXP_WARN_Wait out the RP|r
.use 44950
.complete 11969,1 
.isOnQuest 11969
step
#questguide
#completewith next
+|cRXP_WARN_Dismount |cRXP_FRIENDLY_Keristrasza|r, then cast |T135992:0|t[Slow Fall]|r << Mage
+|cRXP_WARN_Dismount |cRXP_FRIENDLY_Keristrasza|r, then cast |T135928:0|t[Levitate] when you're near the ground|r << Priest
+|cRXP_WARN_Dismount |cRXP_FRIENDLY_Keristrasza|r, then cast |T135896:0|t[Divine Shield] or |T135964:0|t[Hand of Protection] when you're near the ground|r << Paladin
.itemcount 17056,1 << Mage/Priest
step
#questguide
#completewith next
.goto BoreanTundra,21.91,30.45
.use 35506 >> |cRXP_WARN_Look for a |cRXP_ENEMY_Nexus Drake Hatchling|r flying around the north-western edge of Coldarra|r
.cast 46607 >>|cRXP_WARN_Use|r |T135134:0|t[Raelorasz's Spear] |cRXP_WARN_on a |cRXP_ENEMY_Nexus Drake Hatchling|r to capture it|r
>>|cRXP_WARN_Do NOT kill the|r |cRXP_ENEMY_Nexus Drake Hatchling|r
.unitscan Nexus Drake Hatchling
.isOnQuest 11919
step
#questguide
.goto BoreanTundra,33.28,34.47
>>Take the |cRXP_FRIENDLY_Nexus Drake Hatchling|r back to |cRXP_FRIENDLY_Raelorasz|r in Transitus
>>|cRXP_WARN_The |cRXP_FRIENDLY_Nexus Drake Hatchling|r will match your movement speed|r
.complete 11919,1 
.target Raelorasz
.isOnQuest 11919
step
#questguide
.goto BoreanTundra,33.32,34.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Raelorasz|r
.turnin 11919 >>Turn in Drake Hunt
.turnin 11969 >>Turn in Springing the Trap
.accept 11931 >>Accept Cracking the Code
.daily 11940 >>Accept Drake Hunt
.target Raelorasz
step
#questguide
#completewith next
.goto BoreanTundra,32.72,27.88,0
>>Kill |cRXP_ENEMY_Coldarra Spellbinders|r. Loot them for their |cRXP_LOOT_Shimmering Runes|r
.complete 11931,1 
.mob Coldarra Spellbinder
step
#questguide
.goto BoreanTundra,32.72,27.88
>>Kill |cRXP_ENEMY_Inquisitor Caleras|r. Loot him for the |cRXP_LOOT_Azure Codex|r
.complete 11931,2 
.mob Inquisitor Caleras
step
#questguide
.goto BoreanTundra,21.91,30.45
.use 35506 >> |cRXP_WARN_Look for a |cRXP_ENEMY_Nexus Drake Hatchling|r flying around the north-western edge of Coldarra|r
.cast 46607 >>|cRXP_WARN_Use|r |T135134:0|t[Raelorasz's Spear] |cRXP_WARN_on a |cRXP_ENEMY_Nexus Drake Hatchling|r to capture it|r
>>|cRXP_WARN_Do NOT kill the|r |cRXP_ENEMY_Nexus Drake Hatchling|r
.unitscan Nexus Drake Hatchling
.isOnQuest 11940
step
#questguide
.goto BoreanTundra,32.69,27.79,70,0
.goto BoreanTundra,33.45,25.68,70,0
.goto BoreanTundra,33.73,29.97,70,0
.goto BoreanTundra,31.54,28.28,70,0
.goto BoreanTundra,34.79,26.95
>>Kill |cRXP_ENEMY_Coldarra Spellbinders|r. Loot them for their |cRXP_LOOT_Shimmering Runes|r
.complete 11931,1 
.mob Coldarra Spellbinder
step
#questguide
.goto BoreanTundra,33.28,34.47
>>Take the |cRXP_FRIENDLY_Nexus Drake Hatchling|r back to |cRXP_FRIENDLY_Raelorasz|r in Transitus
>>|cRXP_WARN_The |cRXP_FRIENDLY_Nexus Drake Hatchling|r will match your movement speed|r
.complete 11940,1 
.target Raelorasz
.isOnQuest 11940
step
#questguide
.goto BoreanTundra,33.32,34.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Raelorasz|r
.turnin 11931 >>Turn in Cracking the Code
.turnin -11940 >>Turn in Drake Hunt
.target Raelorasz

step
#completewith next
.goto BoreanTundra,33.13,34.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Adami|r
.fly Fizzcrank >>Fly to Fizzcrank Airstrip
.target Warmage Adami
step
#completewith ED
.goto BoreanTundra,57.12,18.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_"Charlie"|r
.home >>Set your Hearthstone to Fizzcrank Airstrip
.target "Charlie" Northtop
step
.goto BoreanTundra,56.98,18.71
>>|cRXP_WARN_Take the elevator up to|r |cRXP_FRIENDLY_Fizzcrank|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzcrank|r
.turnin 11707 >>Turn in Distress Call
.accept 11708 >>Accept The Mechagnomes
.target Fizzcrank Fullthrottle
step
.goto BoreanTundra,56.98,18.71
.gossipoption 93085 >> Talk to |cRXP_FRIENDLY_Fizzcrank|r to hear his tale
.skipgossip
.isOnQuest 11708
.target Fizzcrank Fullthrottle
step
.goto BoreanTundra,56.98,18.71
.gossipoption 93086 >> Talk to |cRXP_FRIENDLY_Fizzcrank|r to hear his tale
.skipgossip
.isOnQuest 11708
.target Fizzcrank Fullthrottle
step
.goto BoreanTundra,56.98,18.71
.gossipoption 93088 >> Talk to |cRXP_FRIENDLY_Fizzcrank|r to hear his tale
.skipgossip 25590,2
.isOnQuest 11708
.target Fizzcrank Fullthrottle
step
.goto BoreanTundra,56.98,18.71
.gossipoption 93090 >> Talk to |cRXP_FRIENDLY_Fizzcrank|r to hear his tale
.skipgossip 25590,2
.isOnQuest 11708
.target Fizzcrank Fullthrottle
step
.goto BoreanTundra,56.98,18.71
.gossipoption 93225 >> Talk to |cRXP_FRIENDLY_Fizzcrank|r to hear his tale
.skipgossip 25590,2
.isOnQuest 11708
.target Fizzcrank Fullthrottle
step
.goto BoreanTundra,56.98,18.71
.gossipoption 93227 >> Talk to |cRXP_FRIENDLY_Fizzcrank|r to hear his tale
.skipgossip 25590,2
.isOnQuest 11708
.target Fizzcrank Fullthrottle
step
.goto BoreanTundra,56.98,18.71
.gossipoption 93229 >> Talk to |cRXP_FRIENDLY_Fizzcrank|r to hear his tale
.skipgossip 25590,2
.isOnQuest 11708
.target Fizzcrank Fullthrottle
step
.goto BoreanTundra,56.98,18.71
.gossipoption 93231 >> Talk to |cRXP_FRIENDLY_Fizzcrank|r to hear his tale
.skipgossip 25590,2
.isOnQuest 11708
.target Fizzcrank Fullthrottle
step
.goto BoreanTundra,56.98,18.71
.gossipoption 93233 >> Talk to |cRXP_FRIENDLY_Fizzcrank|r to hear his tale
.skipgossip 25590,2
.isOnQuest 11708
.complete 11708,1 
.target Fizzcrank Fullthrottle
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jinky|r, |cRXP_FRIENDLY_Mordle|r, and |cRXP_FRIENDLY_Crafty|r
>>|cRXP_FRIENDLY_Crafty|r |cRXP_WARN_patrols the outside|r
.turnin 11708 >>Turn in The Mechagnomes
.accept 11712 >>Accept Re-Cursive
.goto BoreanTundra,57.44,18.73
.accept 11704 >>Accept King Mrgl-Mrgl
.accept 11710 >>Accept What's the Matter with the Transmatter?
.goto BoreanTundra,57.52,18.62
.accept 11645 >>Accept Dirty, Stinkin' Snobolds!
.goto BoreanTundra,57.51,18.72,30,0
.goto BoreanTundra,58.2,18.3
.target Jinky Twizzlefixxit
.target Mordle Cogspinner
.target Crafty Wobblesprocket
step
#questguide << !Druid !Shaman !Druid
#completewith Bonker
.goto BoreanTundra,57.3,13.1,0
.goto BoreanTundra,56.2,12.1,0
.goto BoreanTundra,55.0,13.1,0
.goto BoreanTundra,53.1,13.9,0
>>Loot |cRXP_LOOT_Crafty's Stuff|r on the ground
.complete 11645,1 

step
#questguide << !Druid !Shaman !Druid
#completewith CStuff
.goto BoreanTundra,53.8,13.8,30 >> Enter the Magmoth Cave
step
#questguide << !Druid !Shaman !Druid
.goto BoreanTundra,53.8,13.8,40,0
.goto BoreanTundra,55.57,12.58
>>Drop down to |cRXP_FRIENDLY_Bonker|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bonker|r
.accept 11673 >>Accept Get Me Outa Here!
.target Bonker Togglevolt
step
#questguide << !Druid !Shaman !Druid
.goto BoreanTundra,53.8,13.8
>>|cRXP_WARN_Escort |cRXP_FRIENDLY_Bonker|r just outside of Magmoth Cave|r
.complete 11673,1 
step
#label CStuff
.goto BoreanTundra,54.9,15.7,50,0
.goto BoreanTundra,57.3,13.1,50,0
.goto BoreanTundra,56.2,12.1,50,0
.goto BoreanTundra,55.0,13.1,50,0
.goto BoreanTundra,53.1,13.9
>>Loot |cRXP_LOOT_Crafty's Stuff|r on the ground
.complete 11645,1 
.target Bonker Togglevolt
step
.goto BoreanTundra,57.1,19.0,20,0
.goto BoreanTundra,57.0,18.7
>>|cRXP_WARN_Take the elevator up to|r |cRXP_FRIENDLY_Fizzcrank|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzcrank|r
.turnin 11673 >>Turn in Get Me Outa Here!
.isQuestComplete 11673
.target Fizzcrank Fullthrottle
step
.goto BoreanTundra,57.51,18.72,30,0
.goto BoreanTundra,58.2,18.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crafty|r
>>|cRXP_FRIENDLY_Crafty|r |cRXP_WARN_patrols the outside|r
.turnin 11645 >>Turn in Dirty, Stinkin' Snobolds!
.accept 11650 >>Accept Just a Few More Things...
.itemcount 39682,1 
.target Crafty Wobblesprocket
step
.goto BoreanTundra,57.51,18.72,30,0
.goto BoreanTundra,58.2,18.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crafty|r
>>|cRXP_FRIENDLY_Crafty|r |cRXP_WARN_patrols the outside|r
.turnin 11645 >>Turn in Dirty, Stinkin' Snobolds!
.target Crafty Wobblesprocket
step
#completewith next
.goto BoreanTundra,61.6,15.0,0
.goto BoreanTundra,59.4,17.6,0
.goto BoreanTundra,58.2,23.4,0
.goto BoreanTundra,63.5,22.4,0
.goto BoreanTundra,64.5,18.2,0
.use 34984 >> Kill |cRXP_ENEMY_Defendo-tank 66Ds|r, |cRXP_ENEMY_Scavenge-bot 004-A8s|r and |cRXP_ENEMY_Sentry-bot 57-Ks|r. Loot them for |T134429:0|t[|cRXP_LOOT_The Ultrasonic Screwdriver|r]
>>|cRXP_WARN_Use |T134429:0|t[|cRXP_LOOT_The Ultrasonic Screwdriver|r] to start the quest|r
.collect 34984,1,11729,1
.accept 11729 >> Accept The Ultrasonic Screwdriver
.mob Sentry-bot 57-K
.mob Scavenge-bot 004-A8
.mob Defendo-tank 66D


step
.goto BoreanTundra,61.7,20.9,70,0
.goto BoreanTundra,65.2,17.9,70,0
.goto BoreanTundra,64.2,23.2
.use 34973 >> Kill |cRXP_ENEMY_Fizzcrank Mechagnomes|r. |cRXP_WARN_Use the|r |T136093:0|t[Re-Cursive Transmatter Injection] |cRXP_WARN_on their corpses|r
>>Loot the |cRXP_LOOT_Fizzcrank Spare Parts|r on the ground
.complete 11712,1 
.complete 11710,1 
.mob Fizzcrank Mechagnome
step
#questguide
.goto BoreanTundra,61.6,15.0,70,0
.goto BoreanTundra,59.4,17.6,70,0
.goto BoreanTundra,58.2,23.4,70,0
.goto BoreanTundra,63.5,22.4,70,0
.goto BoreanTundra,64.5,18.2
.use 34984 >> Kill |cRXP_ENEMY_Defendo-tank 66Ds|r, |cRXP_ENEMY_Scavenge-bot 004-A8s|r and |cRXP_ENEMY_Sentry-bot 57-Ks|r. Loot them for |T134429:0|t[|cRXP_LOOT_The Ultrasonic Screwdriver|r]
>>|cRXP_WARN_Use |T134429:0|t[|cRXP_LOOT_The Ultrasonic Screwdriver|r] to start the quest|r
.collect 34984,1,11729,1
.accept 11729 >> Accept The Ultrasonic Screwdriver
.mob Sentry-bot 57-K
.mob Scavenge-bot 004-A8
.mob Defendo-tank 66D


step
#questguide
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crafty|r, |cRXP_FRIENDLY_Mordle|r, and |cRXP_FRIENDLY_Jinky|r
>>|cRXP_FRIENDLY_Crafty|r |cRXP_WARN_patrols the outside|r
.turnin 11729 >> Turn in The Ultrasonic Screwdriver
.accept 11730 >> Accept Master and Servant
.goto BoreanTundra,57.51,18.72,30,0
.goto BoreanTundra,58.2,18.3
.turnin 11710 >>Turn in What's the Matter with the Transmatter?
.accept 11692 >>Accept Check in With Bixie
.goto BoreanTundra,57.52,18.62
.turnin 11712 >>Turn in Re-Cursive
.accept 11788 >>Accept Lefty Loosey, Righty Tighty
.goto BoreanTundra,57.44,18.73
.target Jinky Twizzlefixxit
.target Mordle Cogspinner
.target Crafty Wobblesprocket
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crafty|r, |cRXP_FRIENDLY_Mordle|r, and |cRXP_FRIENDLY_Jinky|r
>>|cRXP_FRIENDLY_Crafty|r |cRXP_WARN_patrols the outside|r
.turnin 11729 >> Turn in The Ultrasonic Screwdriver

.goto BoreanTundra,57.51,18.72,30,0
.goto BoreanTundra,58.2,18.3
.turnin 11710 >>Turn in What's the Matter with the Transmatter?
.accept 11692 >>Accept Check in With Bixie
.goto BoreanTundra,57.52,18.62
.turnin 11712 >>Turn in Re-Cursive
.accept 11788 >>Accept Lefty Loosey, Righty Tighty
.goto BoreanTundra,57.44,18.73
.target Jinky Twizzlefixxit
.target Mordle Cogspinner
.target Crafty Wobblesprocket
step
#completewith ED
.goto BoreanTundra,61.6,15.0,70,0
.goto BoreanTundra,59.4,17.6,70,0
.goto BoreanTundra,58.2,23.4,70,0
.goto BoreanTundra,63.5,22.4,70,0
.goto BoreanTundra,64.5,18.2
.use 34984 >> Kill |cRXP_ENEMY_Defendo-tank 66Ds|r, |cRXP_ENEMY_Scavenge-bot 004-A8s|r and |cRXP_ENEMY_Sentry-bot 57-Ks|r. Loot them for |T134429:0|t[|cRXP_LOOT_The Ultrasonic Screwdriver|r]
>>|cRXP_WARN_Use |T134429:0|t[|cRXP_LOOT_The Ultrasonic Screwdriver|r] to start the quest|r
.collect 34984,1,11729,1
.accept 11729 >> Accept The Ultrasonic Screwdriver
.mob Sentry-bot 57-K
.mob Scavenge-bot 004-A8
.mob Defendo-tank 66D


step
#questguide
#completewith ED
.use 35116 >> Kill |cRXP_ENEMY_Defendo-tank 66Ds|r, |cRXP_ENEMY_Scavenge-bot 004-A8s|r and |cRXP_ENEMY_Sentry-bot 57-Ks|r. |cRXP_WARN_Use|r |T134429:0|t[|cRXP_LOOT_The Ultrasonic Screwdriver|r] |cRXP_WARN_on their corpses|r
.complete 11730,1 
.mob Sentry-bot 57-K
.mob Scavenge-bot 004-A8
.mob Defendo-tank 66D


step
.goto BoreanTundra,60.24,20.39
>>Click the |cRXP_PICK_West Point Station Valve|r to summon |cRXP_ENEMY_Twonky|r
>>Kill |cRXP_ENEMY_Twonky|r
.complete 11788,1 
.mob Twonky
step
.goto BoreanTundra,63.68,22.50
>>Click the |cRXP_PICK_Mid Point Station Valve|r to summon |cRXP_ENEMY_Max Blasto|r
>>Kill |cRXP_ENEMY_Max Blasto|r
.complete 11788,3 
.mob Max Blasto
step
.goto BoreanTundra,64.40,23.14
>>Loot |cRXP_LOOT_Crafty's Tools|r on the ground
.complete 11650,1 
.itemcount 39682,1 
.isOnQuest 11650
step
#label ED
.goto BoreanTundra,65.41,17.51
>>Click the |cRXP_PICK_North Point Station Valve|r to summon |cRXP_ENEMY_ED-210|r
>>Kill |cRXP_ENEMY_ED-210|r
.complete 11788,2 
.mob ED-210
step
#questguide
.goto BoreanTundra,61.0,17.0,70,0
.goto BoreanTundra,58.5,20.8,70,0
.goto BoreanTundra,63.1,21.7
.use 35116 >> Kill |cRXP_ENEMY_Defendo-tank 66Ds|r, |cRXP_ENEMY_Scavenge-bot 004-A8s|r and |cRXP_ENEMY_Sentry-bot 57-Ks|r
>>|cRXP_WARN_Use|r |T134429:0|t[|cRXP_LOOT_The Ultrasonic Screwdriver|r] |cRXP_WARN_on their corpses|r
.complete 11730,1 
.mob Sentry-bot 57-K
.mob Scavenge-bot 004-A8
.mob Defendo-tank 66D


step
#completewith next
.goto BoreanTundra,73.42,18.78,100 >> Travel toward |cRXP_FRIENDLY_Bixie|r near Talramas
step
.goto BoreanTundra,73.42,18.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bixie|r
.turnin 11692 >>Turn in Check in With Bixie
.accept 11693 >>Accept Oh Great... Plagued Magnataur!
.target Bixie Wrenchshanker
step
.goto BoreanTundra,82.0,29.3,70,0
.goto BoreanTundra,71.8,15.6,70,0
.goto BoreanTundra,82.0,29.3,70,0
.goto BoreanTundra,71.8,15.6
>>Kill |cRXP_ENEMY_Plagued Magnataurs|r
.complete 11693,1 
.mob Plagued Magnataur
step
.goto BoreanTundra,73.42,18.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bixie|r
.turnin 11693 >>Turn in Oh Great... Plagued Magnataur!
.accept 11694 >>Accept There's Something Going On In Those Caves
.target Bixie Wrenchshanker
step
#completewith next
.goto BoreanTundra,74.77,14.10,70 >> Enter the Den of Dying
step
.goto BoreanTundra,74.77,14.10
.use 34915 >> |cRXP_WARN_Use|r |T133590:0|t[Bixie's Inhibiting Powder] |cRXP_WARN_on the|r |cRXP_PICK_Den of Dying Plague Cauldron|r
.complete 11694,1 
step
.goto BoreanTundra,73.42,18.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bixie|r
.turnin 11694 >>Turn in There's Something Going On In Those Caves
.accept 11697 >>Accept Rats, Tinky Went into the Necropolis!
.accept 11698 >>Accept Might As Well Wipe Out the Scourge
.target Bixie Wrenchshanker
step
#completewith Tinky
.goto BoreanTundra,69.3,14.1,0
>>Kill the |cRXP_ENEMY_Talramas Undead|r
.complete 11698,1 
.mob Cult Plaguebringer
.mob Doctor Razorgrin
.mob Lich-Lord Chillwinter
.mob Talramas Abomination
.mob Bone Warrior
.mob Festering Ghoul
step
#completewith next
.goto BoreanTundra,68.7,15.3,60 >> Travel toward |cRXP_FRIENDLY_Tinky|r inside Talramas
step
.goto BoreanTundra,68.7,15.3,70,0
.goto BoreanTundra,69.89,14.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tinky|r
.turnin 11697 >>Turn in Rats, Tinky Went into the Necropolis!
.accept 11699 >>Accept I'm Stuck in this Damned Cage... But Not For Long!
.target Tinky Wickwhistle
step
#completewith Gyroscope
.goto BoreanTundra,68.97,14.76,0
>>Kill |cRXP_ENEMY_Festering Ghouls|r. Loot them for their |cRXP_LOOT_Crystal|r
.complete 11699,1 
.mob Festering Ghoul
step
.goto BoreanTundra,68.7,15.3,40,0
.goto BoreanTundra,68.1,11.6,60,0
.goto BoreanTundra,69.4,11.4,40,0
.goto BoreanTundra,69.08,13.26,30,0
.goto BoreanTundra,69.64,13.88
>>|cRXP_WARN_Travel to the top of Talramas from the outside|r
>>Kill |cRXP_ENEMY_Lich-Lord Chillwinter|r. Loot him for the |cRXP_LOOT_Scourgestone|r
.complete 11699,3 
.mob Lich-Lord Chillwinter
step
#label Gyroscope
.goto BoreanTundra,69.88,13.33
>>|cRXP_WARN_Drop down into the center pit|r
>>Kill |cRXP_ENEMY_Doctor Razorgrin|r. Loot him for the |cRXP_LOOT_Gyroscope|r
.complete 11699,2 
.mob Doctor Razorgrin
step
.goto BoreanTundra,71.2,15.0,70,0
.goto BoreanTundra,68.2,16.9,70,0
.goto BoreanTundra,67.2,12.5,70,0
.goto BoreanTundra,69.7,13.8
>>Kill |cRXP_ENEMY_Festering Ghouls|r. Loot them for their |cRXP_LOOT_Crystal|r
.complete 11699,1 
.mob Festering Ghoul
step
#label Tinky
.goto BoreanTundra,69.89,14.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tinky|r
.turnin 11699 >>Turn in I'm Stuck in this Damned Cage... But Not For Long!
.accept 11700 >>Accept Let Bixie Know
.target Tinky Wickwhistle
step
.goto BoreanTundra,71.2,15.0,70,0
.goto BoreanTundra,68.2,16.9,70,0
.goto BoreanTundra,67.2,12.5,70,0
.goto BoreanTundra,69.7,13.8
>>Kill |cRXP_ENEMY_Talramas Undead|r
.complete 11698,1 
.mob Cult Plaguebringer
.mob Doctor Razorgrin
.mob Lich-Lord Chillwinter
.mob Talramas Abomination
.mob Bone Warrior
.mob Festering Ghoul
step
.goto BoreanTundra,73.42,18.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bixie|r
.turnin 11698 >>Turn in Might As Well Wipe Out the Scourge
.turnin 11700 >>Turn in Let Bixie Know
.accept 11701 >>Accept Back to the Airstrip
.target Bixie Wrenchshanker
step << Druid wotlk
#completewith DruidTrain
.cast 18960 >> Cast Teleport: Moonglade
.zoneskip Moonglade
.xp <71,1
step << Druid wotlk
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 48442 >> Train your class spells
.xp <71,1
.target Loganaar
step << Druid wotlk
#label DruidTrain
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 48464 >> Train your class spells
.xp <72,1
.target Loganaar
step << DK wotlk
#completewith next
.cast 50977 >> Cast Death Gate
.zoneskip Eastern Plaguelands
.xp <72,1
step << DK wotlk
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49940 >> Train your class spells
.xp <72,1
.target Amal'thazad
step << Mage wotlk
#completewith MageTrain
.zone Stormwind City >> Teleport to Stormwind
.xp <71,1
step << Mage wotlk
.goto StormwindNew,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 43023 >> Train your class spells
.xp <71,1
.target Elsharin
.target Jennea Cannon
step << Mage wotlk
#label MageTrain
.goto StormwindNew,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42930 >> Train your class spells
.xp <72,1
.target Elsharin
.target Jennea Cannon
step
#completewith next
.hs >> Hearth to Fizzcrank Airstrip
step
.goto BoreanTundra,56.95,18.75
>>|cRXP_WARN_Take the elevator up to|r |cRXP_FRIENDLY_Fizzcrank|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzcrank|r
.turnin 11701 >>Turn in Back to the Airstrip
.accept 11725 >>Accept Finding Pilot Tailspin
.target Fizzcrank Fullthrottle
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crafty|r
>>|cRXP_FRIENDLY_Crafty|r |cRXP_WARN_patrols the outside|r
.turnin 11729 >> Turn in The Ultrasonic Screwdriver
.goto BoreanTundra,57.51,18.72,30,0
.goto BoreanTundra,58.2,18.3
.isOnQuest 11729
.target Crafty Wobblesprocket
step
#questguide
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crafty|r
>>|cRXP_FRIENDLY_Crafty|r |cRXP_WARN_patrols the outside|r
.turnin 11730 >> Turn in Master and Servant
.goto BoreanTundra,57.51,18.72,30,0
.goto BoreanTundra,58.2,18.3
.target Crafty Wobblesprocket
step
.goto BoreanTundra,65.25,28.78
>>Click the |cRXP_PICK_South Point Station Valve|r to summon |cRXP_ENEMY_The Grinder|r
>>Kill |cRXP_ENEMY_The Grinder|r
.complete 11788,4 
.mob The Grinder
step
#completewith next
.goto BoreanTundra,61.68,35.79,130 >> Travel to the Scalding Pools
step
#label Iggy
.goto BoreanTundra,61.68,35.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Iggy|r
.turnin 11725 >>Turn in Finding Pilot Tailspin
.accept 11726 >>Accept A Little Bit of Spice
.target Iggy "Tailspin" Cogtoggle
step
.goto BoreanTundra,64.9,41.2,70,0
.goto BoreanTundra,67.1,40.6,70,0
.goto BoreanTundra,68.7,42.2
>>Kill the |cRXP_ENEMY_Gorloc Gibberers|r, |cRXP_ENEMY_Gorloc Steam Belchers|r and |cRXP_ENEMY_Gorloc Waddlers|r. Loot them for their |cRXP_LOOT_Pouches|r
.complete 11726,1 
.mob Gorloc Gibberer
.mob Gorloc Steam Belcher
.mob Gorloc Waddler
step
#completewith next
.goto BoreanTundra,81.5,42.5,100 >> Travel to Frozen Reach
.isOnQuest 11650
step
.goto BoreanTundra,81.5,42.5
>>Kill |cRXP_ENEMY_Rocknar|r. Loot him for his |cRXP_LOOT_Grit|r
.complete 11650,3 
.itemcount 39682,1 
.isOnQuest 11650
.mob Rocknar
step
.goto BoreanTundra,61.68,35.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Iggy|r
.turnin 11726 >>Turn in A Little Bit of Spice
.accept 11728 >>Accept Lupus Pupus
.target Iggy "Tailspin" Cogtoggle
step
.goto BoreanTundra,60.95,32.94
.use 35121 >> |cRXP_WARN_Use the|r |T134045:0|t[Wolf Bait] |cRXP_WARN_on |cRXP_ENEMY_Oil-stained Wolves|r. |cRXP_WARN_Wait for their RP|r
>>Open the |cRXP_PICK_Wolf Droppings|r. Loot it for the |cRXP_LOOT_Microfilm|r
.complete 11728,1 
.mob Oil-stained Wolf
step
.goto BoreanTundra,61.68,35.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Iggy|r
.turnin 11728 >>Turn in Lupus Pupus
.accept 11795 >>Accept Emergency Protocol: Section 8.2, Paragraph C
.target Iggy "Tailspin" Cogtoggle
step
.goto BoreanTundra,62.94,35.81,40,0
.goto BoreanTundra,61.53,38.76,40,0
.goto BoreanTundra,60.56,38.44,40,0
.goto BoreanTundra,60.67,35.80,40,0
.goto BoreanTundra,61.35,33.82,40,0
.goto BoreanTundra,62.79,32.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the dead |cRXP_FRIENDLY_Fizzcrank Recon Pilots|r. Loot them for their |cRXP_LOOT_Pilot's Insignias|r
.complete 11795,1 
.skipgossip
.target Fizzcrank Recon Pilot
step
.goto BoreanTundra,61.68,35.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Iggy|r
.turnin 11795 >>Turn in Emergency Protocol: Section 8.2, Paragraph C
.accept 11796 >>Accept Emergency Protocol: Section 8.2, Paragraph D
.target Iggy "Tailspin" Cogtoggle
step
.use 35224 >> |cRXP_WARN_Use the|r |T135488:0|t[Emergency Torch] |cRXP_WARN_on the wreckages of the|r |cRXP_PICK_Flying Machines|r
.complete 11796,3 
.goto BoreanTundra,60.85,33.63
.complete 11796,2 
.goto BoreanTundra,61.07,40.01
.complete 11796,1 
.goto BoreanTundra,63.40,36.95
step
#label Iggy2
.goto BoreanTundra,61.68,35.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Iggy|r
.turnin 11796 >>Turn in Emergency Protocol: Section 8.2, Paragraph D
.accept 11873 >>Accept Give Fizzcrank the News
.target Iggy "Tailspin" Cogtoggle
step << Shaman
#completewith next
.hs >> Hearth to Fizzcrank Airstrip
step << Shaman
.goto BoreanTundra,57.01,18.68
>>|cRXP_WARN_Take the elevator up to|r |cRXP_FRIENDLY_Fizzcrank|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzcrank|r
.turnin 11873 >>Turn in Give Fizzcrank the News
.target Fizzcrank Fullthrottle
step << !Shaman
#completewith next
.goto BoreanTundra,57.46,18.79,100 >>Travel to Fizzcrank Airstrip
step
.goto BoreanTundra,57.46,18.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jinky|r
.turnin 11788 >>Turn in Lefty Loosey, Righty Tighty
.accept 11798 >>Accept The Gearmaster
.target Jinky Wingnut
step
#completewith next
.goto BoreanTundra,57.1,19.0,20,0
.goto BoreanTundra,57.0,18.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crafty|r
>>|cRXP_FRIENDLY_Crafty|r |cRXP_WARN_patrols the outside|r
.accept 11653 >>Accept Hah... You're Not So Big Now!
.target Crafty Wobblesprocket
step
.goto BoreanTundra,57.1,19.0,20,0
.goto BoreanTundra,57.0,18.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crafty|r
>>|cRXP_FRIENDLY_Crafty|r |cRXP_WARN_patrols the outside|r
.turnin 11650 >>Turn in Just a Few More Things...
.isQuestComplete 11650
.target Crafty Wobblesprocket
step
#completewith next
.goto BoreanTundra,54.2,13.1,60 >> Enter the Magmoth Cave
.isOnQuest 11653
step
.goto BoreanTundra,54.2,13.1,70,0
.goto BoreanTundra,55.1,12.0
.use 34812 >> |cRXP_WARN_Use|r |T133037:0|t[Crafty's Shortening Blaster] |cRXP_WARN_on |cRXP_ENEMY_Magmoth Crushers|r and|r |cRXP_ENEMY_Mates of Magmothregar|r
.complete 11653,1 
.isQuestTurnedIn 11650
.mob Magmoth Crusher
.mob Mate of Magmothregar
step
.goto BoreanTundra,57.1,19.0,20,0
.goto BoreanTundra,57.0,18.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crafty|r
>>|cRXP_FRIENDLY_Crafty|r |cRXP_WARN_patrols the outside|r
.turnin 11653 >>Turn in Hah... You're Not So Big Now!
.accept 11658 >>Accept Plan B
.isQuestTurnedIn 11650
.target Crafty Wobblesprocket
step << !Shaman
.goto BoreanTundra,57.01,18.68
>>|cRXP_WARN_Take the elevator up to|r |cRXP_FRIENDLY_Fizzcrank|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzcrank|r
.turnin 11873 >>Turn in Give Fizzcrank the News
.target Fizzcrank Fullthrottle
step
#completewith next
.goto BoreanTundra,49.3,21.4,0
.goto BoreanTundra,50.4,24.7,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_ENEMY_Dead Caravan Guards|r and |cRXP_ENEMY_Dead Caravan Workers|r. Loot them for their |cRXP_LOOT_Outfits|r
.complete 11658,1 
.skipgossip
.isQuestTurnedIn 11650
.mob Dead Caravan Guard
.mob Dead Caravan Worker
step
.goto BoreanTundra,49.59,26.68
>>Loot the |cRXP_LOOT_Warsong Banner|r on the ground
.complete 11658,2 
.isQuestTurnedIn 11650
step
.goto BoreanTundra,49.3,21.4,70,0
.goto BoreanTundra,50.4,24.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_ENEMY_Dead Caravan Guards|r and |cRXP_ENEMY_Dead Caravan Workers|r. Loot them for their |cRXP_LOOT_Outfits|r
.complete 11658,1 
.skipgossip
.isQuestTurnedIn 11650
.mob Dead Caravan Guard
.mob Dead Caravan Worker
step
#completewith next
.goto BoreanTundra,57.06,20.12,100 >> Travel to Fizzcrank Airstrip
.isQuestTurnedIn 11650
step
.goto BoreanTundra,57.06,20.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Abner|r
.accept 11713 >>Accept Scouting the Sinkholes
.target Abner Fizzletorque
step
.goto BoreanTundra,57.1,19.0,20,0
.goto BoreanTundra,57.0,18.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crafty|r
>>|cRXP_FRIENDLY_Crafty|r |cRXP_WARN_patrols the outside|r
.turnin 11658 >>Turn in Plan B
.accept 11670 >>Accept It Was The Orcs, Honest!
.isQuestTurnedIn 11650
.target Crafty Wobblesprocket
step 
#completewith next
.goto BoreanTundra,54.2,13.3
.use 34871 >> |cRXP_WARN_Open|r |T133647:0|t[Crafty's Sack] |cRXP_WARN_for the|r |T132485:0|t[|cRXP_LOOT_Warsong Banner|r] |cRXP_WARN_and|r |T134475:0|t[|cRXP_LOOT_Warsong Orc Disguise|r]
.isQuestTurnedIn 11650
.collect 34869,1,11670,1 
.collect 34870,1,11670,1 
step
.goto BoreanTundra,54.2,13.3,40,0
.goto BoreanTundra,55.6,12.1
.use 34870 >> |cRXP_WARN_Use the|r |T134475:0|t[|cRXP_LOOT_Warsong Orc Disguise|r] |cRXP_WARN_in the Magmoth Cave|r
.complete 11670,2 
.isQuestTurnedIn 11650
step
.goto BoreanTundra,55.6,12.1
.use 34869 >>Kill |cRXP_ENEMY_Magmothregar|r inside Magmoth. |cRXP_WARN_Use the|r |T132485:0|t[|cRXP_LOOT_Warsong Banner|r] |cRXP_WARN_on his corpse|r
.complete 11670,1 
.isQuestTurnedIn 11650
.mob Magmothregar
step
#questguide
.goto BoreanTundra,55.6,12.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bonker|r
.accept 11673 >>Accept Get Me Outa Here!
.isQuestTurnedIn 11650
.target Bonker Togglevolt
step
#questguide
.goto BoreanTundra,53.8,13.8
>>Escort |cRXP_FRIENDLY_Bonker|r just outside of the cave
.complete 11673,1 
.isQuestTurnedIn 11650
.target Bonker Togglevolt
step
#completewith next
.goto BoreanTundra,64.43,23.40,100 >> Travel to the Fizzcrank Pumping Station
.isOnQuest 11798
step
#completewith next
.groundgoto BoreanTundra,65.62,22.95,20,0
.groundgoto BoreanTundra,64.87,24.14,15,0
.groundgoto BoreanTundra,64.71,22.93,15,0
.goto BoreanTundra,64.53,23.42
>>|cRXP_WARN_Go into the small house on the top level|r
.cast 3365 >>Click |cRXP_PICK_The Gearmaster's Manual|r on top of the table to summon |cRXP_ENEMY_Mechazod|r
.timer 51,The Gearmaster RP
.isOnQuest 11798
step
.goto BoreanTundra,64.54,23.26
|cRXP_WARN_Wait out his RP|r
>>Kill |cRXP_ENEMY_Mechazod|r. Loot him for his |cRXP_LOOT_Head|r
.complete 11798,1 
.complete 11798,2 
.mob Gearmaster Mechazod
step
#completewith next
.goto BoreanTundra,66.25,32.13,100 >> Travel to the Geyser Fields
step
#label Sinkhole
.use 34920 >> |cRXP_WARN_Use the|r |T134269:0|t[Map of the Geyser Fields] |cRXP_WARN_when standing on the edge of the|r |cRXP_PICK_Sinkholes|r
.complete 11713,3 
.goto BoreanTundra,66.25,32.13
.complete 11713,2 
.goto BoreanTundra,69.51,32.80
.complete 11713,1 
.goto BoreanTundra,70.24,36.36
step << Druid wotlk
#completewith DruidTrain2
.cast 18960 >> Cast Teleport: Moonglade
.zoneskip Moonglade
.xp <71,1
.cooldown item,6948,>2
step << Druid wotlk
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 48442 >> Train your class spells
.xp <71,1
.cooldown item,6948,>2
.target Loganaar
step << Druid wotlk
#label DruidTrain2
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 48464 >> Train your class spells
.xp <72,1
.cooldown item,6948,>2
.target Loganaar
step << DK wotlk
#completewith DKTraining3
.cast 50977 >> Cast Death Gate
.zoneskip Eastern Plaguelands
.xp <72,1
.cooldown item,6948,>2
step << DK wotlk
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49940 >> Train your class spells
.xp <72,1
.cooldown item,6948,>2
.target Amal'thazad
step << DK wotlk
#label DKTraining3
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49904 >> Train your class spells
.xp <73,1
.cooldown item,6948,>2
.target Amal'thazad
step << Mage wotlk
#completewith MageTrain2
.zone Stormwind City >> Teleport to Stormwind
.xp <71,1
.cooldown item,6948,>2
step << Mage wotlk
.goto StormwindNew,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 43023 >> Train your class spells
.xp <71,1
.cooldown item,6948,>2
.target Elsharin
.target Jennea Cannon
step << Mage wotlk
#label MageTrain2
.goto StormwindNew,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42930 >> Train your class spells
.xp <72,1
.cooldown item,6948,>2
.target Elsharin
.target Jennea Cannon
step
#completewith GearM
.hs >> Hearth to Fizzcrank Airstrip
.cooldown item,6948,>2
step
.goto BoreanTundra,57.04,18.60
>>|cRXP_WARN_Take the elevator up to|r |cRXP_FRIENDLY_Fizzcrank|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzcrank|r
.turnin 11798 >>Turn in The Gearmaster
.isQuestTurnedIn 11673
.target Fizzcrank Fullthrottle
step
#label GearM
.goto BoreanTundra,57.04,18.60
>>|cRXP_WARN_Take the elevator up to|r |cRXP_FRIENDLY_Fizzcrank|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fizzcrank|r
.turnin 11798 >>Turn in The Gearmaster
.turnin 11673 >>Turn in Get Me Outa Here!
.target Fizzcrank Fullthrottle
step
#questguide << !wotlk
.goto BoreanTundra,57.08,20.03
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Abner|r
.turnin 11713 >>Turn in Scouting the Sinkholes
.accept 11715 >>Accept Fueling the Project
.target Abner Fizzletorque
step << !wotlk
.goto BoreanTundra,57.08,20.03
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Abner|r
.turnin 11713 >>Turn in Scouting the Sinkholes
.target Abner Fizzletorque
step
.goto BoreanTundra,57.1,19.0,20,0
.goto BoreanTundra,57.0,18.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crafty|r
>>|cRXP_FRIENDLY_Crafty|r |cRXP_WARN_patrols the outside|r
.turnin 11670 >>Turn in It Was The Orcs, Honest!
.isQuestComplete 11670
.target Crafty Wobblesprocket
step
#questguide << !wotlk
.goto BoreanTundra,56.8,26.2,70,0
.goto BoreanTundra,62.4,29.4,70,0
.goto BoreanTundra,61.8,36.0
.use 34975 >>|cRXP_WARN_Use the|r |T132997:0|t[Portable Oil Collector] |cRXP_WARN_on |cRXP_PICK_Oil Patches|r on the ground|r
.complete 11715,1 
step
#completewith next
.goto BoreanTundra,43.50,13.97,120 >>Travel to Winterfin Retreat
step
.goto BoreanTundra,43.50,13.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_King Mrgl-Mrgl|r
.accept 11571 >>Accept Learning to Communicate
.turnin 11704 >>Turn in King Mrgl-Mrgl
.target King Mrgl-Mrgl
step
.goto BoreanTundra,43.0,18.1,60,0
.goto BoreanTundra,42.5,15.4
.use 34598 >>Kill |cRXP_ENEMY_Scalder|r underwater. |cRXP_WARN_Use|r |T134431:0|t[The King's Empty Conch] |cRXP_WARN_on its corpse|r
>>|cRXP_ENEMY_Scalder|r |cRXP_WARN_patrols the seabed|r
.complete 11571,1 
.unitscan Scalder
step
.goto BoreanTundra,43.50,13.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_King Mrgl-Mrgl|r
.turnin 11571 >>Turn in Learning to Communicate
.accept 11559 >>Accept Winterfin Commerce
.target King Mrgl-Mrgl
step
.goto BoreanTundra,40.5,15.8,70,0
.goto BoreanTundra,41.6,18.9
>>Kill |cRXP_ENEMY_Winterfin Oracles|r, |cRXP_ENEMY_Winterfin Shorestrikers|r and |cRXP_ENEMY_Winterfin Warriors|r. Loot them for their |cRXP_LOOT_Winterfin Clams|r
>>|cRXP_WARN_Alternatively|r Loot the |cRXP_LOOT_Winterfin Clams|r on the ground
>>|cRXP_WARN_They are usually found next to Murloc huts but can be difficult to spot|r
.complete 11559,1 
.mob Winterfin Oracle
.mob Winterfin Shorestriker
.mob Winterfin Warrior
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ahlurglgr|r, |cRXP_FRIENDLY_King Mrgl-Mrgl|r, and |cRXP_FRIENDLY_Brglmurgl|r
.turnin 11559 >>Turn in Winterfin Commerce
.goto BoreanTundra,43.04,13.82
.accept 11560 >>Accept Oh Noes, the Tadpoles!
.goto BoreanTundra,43.50,13.97
.accept 11561 >>Accept Them!
.goto BoreanTundra,42.82,13.65
.target Brglmurgl
.target Ahlurglgr
.target King Mrgl-Mrgl
step
#completewith next
.goto BoreanTundra,41.0,15.6,0
.goto BoreanTundra,41.3,19.0,0
.goto BoreanTundra,39.2,18.3,0
.goto BoreanTundra,37.6,15.9,0
>>Kill |cRXP_ENEMY_Winterfin Oracles|r, |cRXP_ENEMY_Winterfin Shorestrikers|r and |cRXP_ENEMY_Winterfin Warriors|r
>>|cRXP_WARN_Do not prioritize this|r
.complete 11561,1 
.mob Winterfin Oracle
.mob Winterfin Shorestriker
.mob Winterfin Warrior
step
#sticky
#label tadpoles
.goto BoreanTundra,41.0,15.6,40,0
.goto BoreanTundra,41.3,19.0,40,0
.goto BoreanTundra,39.2,18.3,40,0
.goto BoreanTundra,37.6,15.9,40,0
.goto BoreanTundra,41.0,15.6,40,0
.goto BoreanTundra,41.3,19.0,40,0
.goto BoreanTundra,40.04,19.80,40,0
.goto BoreanTundra,39.2,18.3,40,0
.goto BoreanTundra,37.6,15.9
>>Click the |cRXP_PICK_Cages|r to rescure |cRXP_FRIENDLY_Winterfin Tadpoles|r
>>|cRXP_WARN_You may have to go inside the Winterfin Caverns for more|r
.complete 11560,1 
.target Winterfin Tadpole
step
.goto BoreanTundra,40.04,19.80
.use 34669 >> |cRXP_WARN_Use the|r |T133015:0|t[Arcanometer] |cRXP_WARN_at the entrance of the Winterfin Caverns|r
.complete 12728,1 
step
#completewith end
#requires tadpoles
#label Murloc2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brglmurgl|r
.turnin 11561 >>Turn in Them!
.goto BoreanTundra,42.82,13.65,0,0
.isQuestComplete 11561
.target Brglmurgl
step
#requires tadpoles
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_King Mrgl-Mrgl|r
.turnin 11560 >>Turn in Oh Noes, the Tadpoles!
.accept 11562 >>Accept I'm Being Blackmailed By My Cleaner
.goto BoreanTundra,43.50,13.97
.target King Mrgl-Mrgl
step
#requires Murloc2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mrmrglmr|r and |cRXP_FRIENDLY_Bmurglbrm|r
.turnin 11562 >>Turn in I'm Being Blackmailed By My Cleaner
.accept 11563 >>Accept Grmmurggll Mrllggrl Glrggl!!!
.goto BoreanTundra,41.98,12.77
.accept 11564 >>Accept Succulent Orca Stew
.goto BoreanTundra,42.03,13.16
.target Mrmrglmr
.target Brglmurgl
step
#completewith next
.goto BoreanTundra,38.0,9.5,0
.goto BoreanTundra,36.4,8.8,0
.goto BoreanTundra,37.4,6.3,0
.goto BoreanTundra,39.3,8.3,0
>>Kill |cRXP_ENEMY_Glimmer Bay Orcas|r. Loot them for their |cRXP_LOOT_Blubbers|r
.complete 11564,1 
.mob Glimmer Bay Orca
step
.goto BoreanTundra,38.0,9.5,70,0
.goto BoreanTundra,36.4,8.8,70,0
.goto BoreanTundra,37.4,6.3,70,0
.goto BoreanTundra,39.3,8.3
>>Kill |cRXP_ENEMY_Glrggl|r. Loot him for his |cRXP_LOOT_Head|r. |cRXP_WARN_He patrols counter-clockwise around the two northern icebergs|r
.complete 11563,1 
.unitscan Glrggl
step
.goto BoreanTundra,40.1,12.2,70,0
.goto BoreanTundra,39.3,6.7,70,0
.goto BoreanTundra,36.0,8.1
>>Kill |cRXP_ENEMY_Glimmer Bay Orcas|r. Loot them for their |cRXP_LOOT_Blubbers|r
.complete 11564,1 
.mob Glimmer Bay Orca
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mrmrglmr|r, |cRXP_FRIENDLY_Bmurglbrm|r, and |cRXP_FRIENDLY_King Mrgl-Mrgl|r
.turnin 11563 >>Turn in Grmmurggll Mrllggrl Glrggl!!!
.accept 11565 >>Accept The Spare Suit
.goto BoreanTundra,41.98,12.77
.turnin 11564 >>Turn in Succulent Orca Stew
.goto BoreanTundra,42.03,13.16
.turnin 11565 >>Turn in The Spare Suit
.accept 11566 >>Accept Surrender... Not!
.goto BoreanTundra,43.50,13.97
.target King Mrgl-Mrgl
.target Mrmrglmr
.target Cleaver Bmurglbrm
step
#completewith next
.goto BoreanTundra,37.84,23.23,165 >> Enter Winterfin Caverns
step
#completewith Lurgglbr
.goto BoreanTundra,41.0,15.6,0
.goto BoreanTundra,41.3,19.0,0
.goto BoreanTundra,39.2,18.3,0
.goto BoreanTundra,37.6,15.9,0
>>Kill |cRXP_ENEMY_Winterfin Oracles|r, |cRXP_ENEMY_Winterfin Shorestrikers|r and |cRXP_ENEMY_Winterfin Warriors|r
>>|cRXP_WARN_Do not prioritize this|r
.complete 11561,1 
.mob Winterfin Oracle
.mob Winterfin Shorestriker
.mob Winterfin Warrior
step
.goto BoreanTundra,37.84,23.23
>>|cRXP_WARN_Stick to the left side once you enter Winterfin Caverns|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Glrglrglr|r
>>|cRXP_WARN_Do NOT Talk to |r|cRXP_FRIENDLY_Lurgglbr|r |cRXP_WARN_yet|r
.accept 11569 >>Accept Keymaster Urmgrgl
.target Glrglrglr
step
.goto BoreanTundra,38.0,22.2,12,0
.goto BoreanTundra,39.0,22.7,30,0
.goto BoreanTundra,39.8,22.5,30,0
.goto BoreanTundra,39.3,23.7
>>|cRXP_WARN_Run down the ramp below|r
>>Kill |cRXP_ENEMY_Keymaster Urmgrgl|r. Loot him for his |cRXP_LOOT_Key|r
.complete 11569,1 
.unitscan Keymaster Urmgrgl
step
#completewith next
.goto BoreanTundra,37.0,21.8,40,0
.goto BoreanTundra,36.9,24.0,40 >> Travel to the end of Winterfin Caverns
step
.goto BoreanTundra,37.55,27.53
>>Kill |cRXP_ENEMY_Claximus|r. Loot him for his |cRXP_LOOT_Claw|r
.complete 11566,1 
.mob Claximus
step
#completewith next
.goto BoreanTundra,36.80,23.22,40,0
.goto BoreanTundra,37.87,21.52,25,0
.goto BoreanTundra,37.84,23.23,30 >> Travel toward |cRXP_FRIENDLY_Glrglrglr|r near the entrance
step
.goto BoreanTundra,37.84,23.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Glrglrglr|r
.turnin 11569 >>Turn in Keymaster Urmgrgl
.target Glrglrglr
step
#questguide
.goto BoreanTundra,37.72,23.03
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lurgglbr|r
.accept 11570 >>Accept Escape from the Winterfin Caverns
.target Lurgglbr
step
#questguide
#label Lurgglbr
.goto BoreanTundra,39.9,19.8,40,0
.goto BoreanTundra,39.6,18.1,40,0
.goto BoreanTundra,41.36,16.32
>>Escort |cRXP_FRIENDLY_Lurgglbr|r. |cRXP_WARN_Try to kill |cRXP_ENEMY_Murlocs|r that he'd otherwise run into so that he doesn't waste time by stopping and attacking|r
.complete 11570,1 
.target Lurgglbr
step
.goto BoreanTundra,41.0,15.6,70,0
.goto BoreanTundra,41.3,19.0,70,0
.goto BoreanTundra,39.2,18.3,70,0
.goto BoreanTundra,37.6,15.9
>>Kill |cRXP_ENEMY_Winterfin Oracles|r, |cRXP_ENEMY_Winterfin Shorestrikers|r and |cRXP_ENEMY_Winterfin Warriors|r
.complete 11561,1 
.mob Winterfin Oracle
.mob Winterfin Shorestriker
.mob Winterfin Warrior
step
.goto BoreanTundra,42.82,13.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brglmurgl|r
.turnin 11561 >>Turn in Them!
.target Brglmurgl
step
#label Murliver
.goto BoreanTundra,43.04,13.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ahlurglgr|r
.vendor >>Purchase as many |T134800:0|t[Murliver Oils] as you can
.itemcount 34597,2
.isQuestTurnedIn 11559
.target Ahlurglgr
step
#questguide
.goto BoreanTundra,43.50,13.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_King Mrgl-Mrgl|r
.turnin 11566 >>Turn in Surrender... Not!
.turnin 11570 >>Turn in Escape from the Winterfin Caverns
.target King Mrgl-Mrgl
step
.goto BoreanTundra,43.50,13.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_King Mrgl-Mrgl|r
.turnin 11566 >>Turn in Surrender... Not!
.target King Mrgl-Mrgl
step << Druid wotlk
#requires Murliver
#completewith DruidTrain3
.cast 18960 >> Cast Teleport: Moonglade
.zoneskip Moonglade
.xp <71,1
.cooldown item,6948,>2
step << Druid wotlk
#requires Murliver
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 48442 >> Train your class spells
.xp <71,1
.cooldown item,6948,>2
.target Loganaar
step << Druid wotlk
#requires Murliver
#label DruidTrain3
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 48464 >> Train your class spells
.xp <72,1
.cooldown item,6948,>2
.target Loganaar
step << DK wotlk
#requires Murliver
#completewith next
.cast 50977 >> Cast Death Gate
.zoneskip Eastern Plaguelands
.xp <72,1
.cooldown item,6948,>2
step << DK wotlk
#requires Murliver
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49940 >> Train your class spells
.xp <72,1
.cooldown item,6948,>2
.target Amal'thazad
step << Mage wotlk
#requires Murliver
#completewith MageTrain3
.zone Stormwind City >> Teleport to Stormwind
.xp <71,1
.cooldown item,6948,>2
step << Mage wotlk
#requires Murliver
.goto StormwindNew,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 43023 >> Train your class spells
.xp <71,1
.cooldown item,6948,>2
.target Elsharin
.target Jennea Cannon
step << Mage wotlk
#requires Murliver
#label MageTrain3
.goto StormwindNew,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42930 >> Train your class spells
.xp <72,1
.cooldown item,6948,>2
.target Elsharin
.target Jennea Cannon
step << (Shaman/DK/Mage/Druid) wotlk
#completewith next
.hs >> Hearth to Fizzcrank Airstrip
.cooldown item,6948,>2
step << (!Shaman !DK !Mage !Druid) wotlk
#completewith next
.goto BoreanTundra,57.02,20.12,150 >> Travel to Fizzcrank Airstrip
step
#questguide << !wotlk
.goto BoreanTundra,57.02,20.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Abner|r
.turnin 11715 >>Turn in Fueling the Project
.accept 11718 >>Accept A Bot in Mammoth's Clothing
.target Abner Fizzletorque
step
#questguide << !wotlk
.goto BoreanTundra,53.55,21.34,70,0
.goto BoreanTundra,53.6,31.2,70,0
.goto BoreanTundra,52.9,40.5,70,0
.goto BoreanTundra,53.55,21.34
>>Kill |cRXP_ENEMY_Wooly Mammoths|r, |cRXP_ENEMY_Wooly Mammoth Bulls|r and |cRXP_ENEMY_Mammoth Calves|r. Loot them for their |cRXP_LOOT_Hides|r
.complete 11718,1 
.mob Mammoth Calf
.mob Wooly Mammoth
.mob Wooly Mammoth Bull
step
#completewith next
.groundgoto BoreanTundra,48.4,36.4,50,0
.goto BoreanTundra,44.98,33.38,50 >> Travel to Amber Ledge
step
.goto BoreanTundra,44.98,33.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Garren|r
.turnin 12728 >>Turn in Monitoring the Rift: Winterfin Cavern
.target Librarian Garren
step
#questguide << !wotlk
#completewith next
.goto BoreanTundra,45.33,34.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Surristrasz|r
.fly Fizzcrank >> Fly to Fizzcrank Airstrip
.target Surristrasz
step
#questguide << !wotlk
.goto BoreanTundra,57.05,20.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Abner|r
.turnin 11718 >>Turn in A Bot in Mammoth's Clothing
.accept 11723 >>Accept Deploy the Shake-n-Quake!
.target Abner Fizzletorque
step
#questguide << !wotlk
#completewith next
.goto BoreanTundra,70.20,36.40,120 >> Travel to the Geyser Fields
.isOnQuest 11723
step
#questguide << !wotlk
#completewith next
.goto BoreanTundra,70.20,36.40
.cast 46017 >> |cRXP_WARN_Use the|r |T133015:0|t[Shake-n-Quake 5000 Control Unit] |cRXP_WARN_next to the |cRXP_PICK_Sinkhole|r to summon|r |cRXP_ENEMY_Lord Kryxix|r
.use 34981
.timer 36,Deploy the Shake-n-Quake! RP
step
#questguide << !wotlk
.goto BoreanTundra,69.78,36.46
>>|cRXP_WARN_Wait out the RP |r
>>Kill |cRXP_ENEMY_Lord Kryxix|r
.complete 11723,1 
.complete 11723,2 
.use 34981
.mob Lord Kryxix
step
#questguide << !wotlk
#completewith next
.goto BoreanTundra,57.09,20.07,150 >> Travel to Fizzcrank Airstrip
step
#questguide << !wotlk
#label end
.goto BoreanTundra,57.09,20.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Abner|r
.turnin 11723 >>Turn in Deploy the Shake-n-Quake!
.target Abner Fizzletorque
step << (Shaman/Warlock/Paladin/Hunter/Rogue/Warrior) wotlk
#completewith next
.goto BoreanTundra,56.56,20.07
.zone Stormwind City >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kara|r
.fly Valiance Keep >> Fly to Valiance Keep. Alternatively pay a |T626001:0|t|cFF3FC7EBMage|r for a portal to Stormwind
.zoneskip Elwynn Forest
.zoneskip Stormwind City
.target Kara Thricestar
step << (Shaman/Warlock/Paladin/Hunter/Rogue/Warrior) wotlk
#completewith ShamanTrain << Shaman
#completewith next << !Shaman
.goto BoreanTundra,59.70,69.26
.zone Stormwind City >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nelno|r. Ask him for a teleport to Stormwind Harbor
.zoneskip Elwynn Forest
.skipgossip
.target Nelno Copperbeam
step << Shaman wotlk
.goto StormwindNew,67.52,89.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umbrua|r
.train 58801 >> Train your class spells
.xp <71,1
.target Farseer Umbrua
step << Shaman wotlk
#label ShamanTrain
.goto StormwindNew,67.52,89.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umbrua|r
.train 49237 >> Train your class spells
.xp <73,1
.target Farseer Umbrua
step << Warlock wotlk
.goto StormwindNew,42.26,81.77,20,0
.goto StormwindNew,40.64,84.94,15,0
.goto StormwindNew,39.88,84.19
>>Go into The Slaughtered Lamb and go downstairs
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ursula|r, |cRXP_FRIENDLY_Demisette|r or |cRXP_FRIENDLY_Sandahl|r
.train 47812 >> Train your class spells
.xp <71,1
.target Ursula Deline
.target Demisette Cloyce
.target Sandahl
step << Paladin wotlk
.goto StormwindNew,52.9,50.9,20,0
.goto StormwindNew,49.8,48.5,20,0
.goto StormwindNew,49.60,49.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arthur|r or |cRXP_FRIENDLY_Katherine|r
.train 54428 >> Train your class spells
.xp <71,1
.target Arthur the Faithful
.target Katherine the Pure
step << Hunter wotlk
.goto StormwindNew,67.3,37.1,15,0
.goto StormwindNew,67.35,36.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Einris|r
.train 49051 >> Train your class spells
.xp <71,1
.target Einris Brightspear
step << Rogue wotlk
.goto StormwindNew,77.42,65.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Osborne|r
.train 48667 >> Train your class spells
.xp <73,1
.target Osborne the Night Man
step << Warrior wotlk
.goto StormwindNew,78.31,63.53,15,0
.goto StormwindNew,81.66,59.50,15,0
.goto StormwindNew,80.56,59.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wu|r or |cRXP_FRIENDLY_Ilsa|r
.train 47470 >> Train your class spells
.xp <73,1
.target Wu Shen
.target Ilsa Corbin
step << (Shaman/Warlock/Paladin/Hunter/Rogue/Warrior) wotlk
#completewith next
.hs >> Hearth to Fizzcrank Airstrip
.zoneskip BoreanTundra
step
#completewith next
.goto BoreanTundra,45.33,34.54,-1
.goto BoreanTundra,56.57,20.08,-1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kara Thricestar|r or |cRXP_FRIENDLY_Surristrasz|r
.fly Stars >> Fly to Stars' Rest
.target Surristrasz
.target Kara Thricestar
step
.goto Dragonblight,12.16,55.22
.zone Dragonblight >> Travel to Dragonblight
step << wotlk
#xprate >1.499
.goto Dragonblight,28.84,56.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lanson|r
.accept 12171 >>Accept Of Traitors and Treason
.target Courier Lanson
step << wotlk
#xprate >1.499
.goto Dragonblight,29.16,55.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Palena|r
>>|cRXP_WARN_Accepting this quest will send you flying to eastern Dragonblight|r
.turnin 12171 >>Turn in Of Traitors and Treason
.accept 12174 >>Accept High Commander Halford Wyrmbane
.timer 88,Westguard Keep Flight
.target Palena Silvercloud
step << wotlk
#xprate >1.499
.goto Dragonblight,77.08,49.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rodney|r
.fp Wintergarde Keep >>Get the Wintergarde Keep Flight Path
.target Rodney Wells
step << wotlk
#xprate >1.499
.goto Dragonblight,78.59,48.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford Wyrmbane|r
.turnin 12174 >>Turn in High Commander Halford Wyrmbane
.target High Commander Halford Wyrmbane
step << wotlk
#xprate >1.499
.xp <73,1
#label Hills
.goto Dragonblight,77.13,50.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urik|r
>>|cRXP_WARN_Accepting this quest will send you flying to Grizzly Hills|r
.accept 12511 >>Accept The Hills Have Us
.timer 150,Fly to Amberpine Lodge
.target Gryphon Commander Urik
step << wotlk
#xprate >1.499
.zone Grizzly Hills >> Travel to Grizzly Hills
]])
RXPGuides.RegisterGuide([[
#cata
#Cata
#xprate <1.5 << wotlk
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 72-74 Dragonblight
#version 5
#next 73-75 Grizzly Hills
#xprate <1.5 << wotlk
#questguide << !wotlk
step
#label pt1start
#completewith DBStart
.goto Dragonblight,29.18,55.32,200 >> Travel to Stars' Rest
step
.goto Dragonblight,29.18,55.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Palena|r
.fp Stars' Rest >> Get the Stars' Rest Flight Path
.target Palena Silvercloud
step
#label DBStart
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Modera|r and |cRXP_FRIENDLY_Jodi|r
.accept 12000 >>Accept Rifle the Bodies
.goto Dragonblight,29.00,55.45
.accept 12166 >>Accept The Liquid Fire of Elune
.goto Dragonblight,29.18,55.65
.target Image of Archmage Modera
.target Warden Jodi Moonsong
step
.goto Dragonblight,28.83,56.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lanson|r
>>|cRXP_WARN_Do NOT accept the next quest|r
.turnin 12157 >>Turn in The Lost Courier
.isOnQuest 12157
.target Courier Lanson
step
#completewith Trader
.goto Dragonblight,28.89,56.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Naohain|r
.home >> Set your Hearthstone to Stars' Rest
.target Naohain
step
.goto Dragonblight,31.9,45.9,70,0
.goto Dragonblight,28.8,51.5,70,0
.goto Dragonblight,23.8,50.0,70,0
.goto Dragonblight,28.8,51.5,70,0
.goto Dragonblight,31.9,45.9
.use 36956 >> Kill |cRXP_ENEMY_Blighted Elks|r and |cRXP_ENEMY_Rabid Grizzlies|r. |cRXP_WARN_Use the|r |T135777:0|t[Liquid Fire of Elune] |cRXP_WARN_on their corpses|r
.complete 12166,1 
.mob +Blighted Elk
.complete 12166,2 
.mob +Rabid Grizzly
step
#completewith next
.goto Dragonblight,24.19,60.06,100 >> Travel to the Moonrest Gardens
step
#sticky
#label moonshadow
.goto Dragonblight,24.19,60.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ethenial|r
.accept 12006 >>Accept Avenge this Atrocity!
.target Ethenial Moonshadow
step
.goto Dragonblight,22.7,58.1,70,0
.goto Dragonblight,23.3,61.3,70,0
.goto Dragonblight,25.9,58.7,70,0
.goto Dragonblight,22.75,57.36,70,0
.goto Dragonblight,21.62,54.84,70,0
.goto Dragonblight,24.72,54.84,70,0
.goto Dragonblight,22.7,58.1
.use 35792 >>Loot |cRXP_FRIENDLY_Dead Mage Hunters|r for their |T133641:0|t[|cRXP_LOOT_Mage Hunter's Personal Effects|r]
>>Open their |T133641:0|t[|cRXP_LOOT_Mage Hunter's Personal Effects|r] until you receive the |cRXP_PICK_Moonrest Gardens Plans|r
.complete 12000,1 
.target Dead Mage Hunter
step
#requires moonshadow
#completewith next
.goto Dragonblight,29.00,55.45,100 >> Travel to Stars' Rest
step
.goto Dragonblight,29.00,55.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Modera|r
.turnin 12000 >>Turn in Rifle the Bodies
.accept 12004 >>Accept Prevent the Accord
.target Image of Archmage Modera
step
.goto Dragonblight,29.18,55.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jodi|r
.turnin 12166 >>Turn in The Liquid Fire of Elune
.accept 12167 >>Accept Kill the Cultists
.target Warden Jodi Moonsong
step
#completewith next
.groundgoto Dragonblight,28.2,45.9,50,0
.groundgoto Dragonblight,27.7,45.6,40,0
.goto Dragonblight,25.96,45.19,60 >> Travel to Icemist Village
step
.goto Dragonblight,23.7,46.1,50,0
.goto Dragonblight,26.7,42.8,50,0
.goto Dragonblight,26.1,42.7,30,0
.goto Dragonblight,26.1,44.1,40,0
.goto Dragonblight,23.8,44.2,40,0
.goto Dragonblight,25.7,38.1,40,0
.goto Dragonblight,25.48,41.66
.use 36958 >>Kill |cRXP_ENEMY_Anub'ar Cultists|r. Loot them for their |cRXP_LOOT_Cultist Suits|r and |T133330:0|t[|cRXP_LOOT_The Favor of Zangus|r]
>>|cRXP_WARN_Use |T133330:0|t[|cRXP_LOOT_The Favor of Zangus|r] to start the quest|r
.complete 12167,1 
.collect 36958,1,12168
.accept 12168 >>Accept The Favor of Zangus
.mob Anub'ar Cultist
step
#completewith next
.goto Dragonblight,29.18,55.65,100 >> Travel to Stars' Rest
step
.goto Dragonblight,29.18,55.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jodi|r
.turnin 12167 >>Turn in Kill the Cultists
.turnin 12168 >>Turn in The Favor of Zangus
.accept 12169 >>Accept The High Cultist
.target Warden Jodi Moonsong
step
#completewith next
.goto Dragonblight,26.15,49.48,15 >> Drop down into The Pit of Narjun
step
.goto Dragonblight,28.85,49.72
>>Kill |cRXP_ENEMY_High Cultist Zangus|r in The Pit of Narjun
.complete 12169,1 
.mob High Cultist Zangus
step
#completewith Trader
.hs >> Hearth to Stars' Rest
.cooldown item,6948,>2
step
#completewith Trader
.goto Dragonblight,26.9,49.5,30,0
.goto Dragonblight,26.7,48.7,15,0
.goto Dragonblight,26.3,49.0,25 >> Exit The Pit of Narjun
.cooldown item,6948,<0
step << skip
.goto Dragonblight,29.18,55.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jodi|r
.turnin 12169 >>Turn in The High Cultist
.target Warden Jodi Moonsong
step
#completewith moonrest
>>Kill |cRXP_ENEMY_Surge Needle Sorcerers|r, |cRXP_ENEMY_Moonrest Stalkers|r, |cRXP_ENEMY_Focus Wizards|r and |cRXP_ENEMY_Dragonblight Mage Hunters|r
.complete 12006,1 
.mob Surge Needle Sorcerer
.mob Moonrest Stalker
.mob Focus Wizard
.mob Dragonblight Mage Hunter
step
#label Trader
.goto Dragonblight,18.39,58.89
>>Kill |cRXP_ENEMY_Wind Trader Mu'Fah|r. Loot him for his |cRXP_LOOT_Remains|r
.complete 12004,1 
.mob Wind Trader Mu'fah
step
.goto Dragonblight,19.46,58.03
.use 36742 >>Kill |cRXP_ENEMY_Goramosh|r. Loot him for his |cRXP_LOOT_Scales|r and |T134889:0|t[|cRXP_LOOT_Goramosh's Strange Device|r]
>>|cRXP_WARN_Use |T134889:0|t[|cRXP_LOOT_Goramosh's Strange Device|r] to start the quest|r
.complete 12004,2 
.collect 36742,1,12055 
.accept 12055 >>Accept A Strange Device
.mob Goramosh
step
#completewith next
.goto Dragonblight,29.00,55.45,100 >> Travel to Stars' Rest
step
#label moonrest
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Modera|r and |cRXP_FRIENDLY_Jodi|r
.turnin 12004 >>Turn in Prevent the Accord
.turnin 12055 >>Turn in A Strange Device
.accept 12060 >>Accept Projections and Plans
.goto Dragonblight,29.00,55.45
.turnin 12169 >>Turn in The High Cultist
.goto Dragonblight,29.18,55.65
.target Image of Archmage Modera
.target Warden Jodi Moonsong
step
#completewith next
.goto Dragonblight,25.4,56.2,60 >> Travel to the Moonrest Gardens
step
#completewith Observe
>>Kill |cRXP_ENEMY_Surge Needle Sorcerers|r, |cRXP_ENEMY_Moonrest Stalkers|r, |cRXP_ENEMY_Focus Wizards|r and |cRXP_ENEMY_Dragonblight Mage Hunters|r
.complete 12006,1 
.mob Surge Needle Sorcerer
.mob Moonrest Stalker
.mob Focus Wizard
.mob Dragonblight Mage Hunter
step
.goto Dragonblight,25.4,56.2,-1
.cast 47097 >> |cRXP_WARN_Use the|r |T134889:0|t[Surge Needle Teleporter] |cRXP_WARN_to teleport to the Surge Needle|r
.goto Dragonblight,19.59,59.77,-1
.use 36747
.isOnQuest 12060
step
#label Observe
.goto Dragonblight,19.79,59.82
>>|cRXP_WARN_Move slightly towards the center of the platform to complete the objective|r
.complete 12060,1 
.use 36747
step
#completewith Atrocity
.cast 47097 >> |cRXP_WARN_Use the|r |T134889:0|t[Surge Needle Teleporter] |cRXP_WARN_to teleport back down|r
.use 36747
step
.goto Dragonblight,20.96,55.17,70,0
.goto Dragonblight,21.73,60.34,70,0
.goto Dragonblight,19.80,61.84,70,0
.goto Dragonblight,17.54,58.47,70,0
.goto Dragonblight,20.96,55.17,70,0
.goto Dragonblight,21.73,60.34,70,0
.goto Dragonblight,19.36,62.30
>>Kill |cRXP_ENEMY_Surge Needle Sorcerers|r, |cRXP_ENEMY_Moonrest Stalkers|r, |cRXP_ENEMY_Focus Wizards|r and |cRXP_ENEMY_Dragonblight Mage Hunters|r
.complete 12006,1 
.mob Surge Needle Sorcerer
.mob Moonrest Stalker
.mob Focus Wizard
.mob Dragonblight Mage Hunter
step
#label Atrocity
.goto Dragonblight,24.19,60.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ethenial|r
.turnin 12006 >>Turn in Avenge this Atrocity!
.accept 12013 >>Accept End Arcanimus
.target Ethenial Moonshadow
step
.groundgoto Dragonblight,20.63,60.86,30,0
.goto Dragonblight,20.03,59.74
>>Kill |cRXP_ENEMY_Arcanimus|r
.complete 12013,1 
.mob Arcanimus
step
.goto Dragonblight,24.19,60.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ethenial|r
.turnin 12013 >>Turn in End Arcanimus
.target Ethenial Moonshadow
step
#completewith next
.goto Dragonblight,29.00,55.45,100 >> Travel to Stars' Rest
step
.goto Dragonblight,29.00,55.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Modera|r
.turnin 12060 >>Turn in Projections and Plans
.accept 12065 >>Accept The Focus on the Beach
.target Image of Archmage Modera
step
.goto Dragonblight,26.32,64.85
.use 36756 >>Kill |cRXP_ENEMY_Captain Emmy Malin|r. Loot her for her |cRXP_LOOT_Ring|r and |T133469:0|t[|cRXP_LOOT_Captain Malin's Letter|r]
>>|cRXP_WARN_Use |T133469:0|t[|cRXP_LOOT_Captain Malin's Letter|r] to start the quest|r
.collect 36751,1,12065,1
.collect 36756,1,12067
.accept 12067 >>Accept A Letter for Home
.mob Captain Emmy Malin
step
.goto Dragonblight,26.54,65.08
.use 36751 >>|cRXP_WARN_Use the|r |T133377:0|t[Ley Line Focus Control Ring] |cRXP_WARN_on the|r |cRXP_PICK_Ley Line Focus|r
>>|cRXP_WARN_You may start mounting up once the cast completes|r
.complete 12065,1 
step
#completewith next
.groundgoto Dragonblight,25.09,60.98,50,0
.goto Dragonblight,29.00,55.45,100 >> Travel to Stars' Rest
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Modera|r and |cRXP_FRIENDLY_Saia|r
.turnin 12065 >>Turn in The Focus on the Beach
.accept 12083 >>Accept Atop the Woodlands
.goto Dragonblight,29.00,55.45
.turnin 12067 >>Turn in A Letter for Home
.goto Dragonblight,29.04,55.42
.target Image of Archmage Modera
.target Commander Saia Azuresteel
step
.goto Dragonblight,28.73,57.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sarendryana|r
.accept 12092 >>Accept Strengthen the Ancients
.target Sarendryana
step
.goto Dragonblight,33.8,60.2,70,0
.goto Dragonblight,36.2,61.7,70,0
.goto Dragonblight,30.6,66.7,70,0
.goto Dragonblight,34.3,68.3,70,0
.goto Dragonblight,29.8,71.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Woodland Walkers|r to receive their |T134882:0|t[|cRXP_LOOT_Barks of the Walkers|r]
>>Kill |cRXP_ENEMY_Woodland Walkers|r if they turn hostile. Loot them for their |T134882:0|t[|cRXP_LOOT_Barks of the Walkers|r]
.use 36786 >>|cRXP_WARN_Use the|r |T134882:0|t[|cRXP_LOOT_Barks of the Walkers|r] |cRXP_WARN_on|r |cRXP_FRIENDLY_Lothalor Ancients|r
.collect 36786,3,12092,1,-1 
.complete 12092,1 
.skipgossip
.mob Woodlands Walker
.target Lothalor Ancient
step
#completewith next
.goto Dragonblight,33.1,71.5,60,0
.goto Dragonblight,32.4,72.7,60,0
.goto Dragonblight,31.5,72.0,60,0
.goto Dragonblight,31.9,70.4
>>Kill |cRXP_ENEMY_Lieutenant Ta'zinni|r. Loot him for his |T133312:0|t[|cRXP_LOOT_Ley Line Focus Control Amulet|r]
>>|cRXP_ENEMY_Lieutenant Ta'zinni|r |cRXP_WARN_patrols the Lothalor Woodlands|r
.collect 36779,1,12083,1 
.unitscan Lieutenant Ta'zinni
step
.goto Dragonblight,32.2,71.4
.use 36779 >>|cRXP_WARN_Use the|r |T133312:0|t[|cRXP_LOOT_Ley Line Focus Control Amulet|r] |cRXP_WARN_on the|r |cRXP_PICK_Ley Line Focus|r
>>|cRXP_WARN_You may start mounting up once the cast completes|r
.complete 12083,1 
step
#completewith next
.goto Dragonblight,28.73,57.10,100 >> Travel to Stars' Rest
step
.goto Dragonblight,28.73,57.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sarendryana|r
.turnin 12092 >>Turn in Strengthen the Ancients
.target Sarendryana
step
.goto Dragonblight,29.00,55.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Modera|r
.turnin 12083 >>Turn in Atop the Woodlands
.accept 12098 >>Accept Search Indu'le Village
.target Image of Archmage Modera
step
#completewith next
.goto Dragonblight,40.25,66.85,70 >> Travel to Lake Indu'le
step
.goto Dragonblight,40.25,66.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the corpse of |cRXP_FRIENDLY_Mage-Commander Evenstar|r underwater
.turnin 12098 >>Turn in Search Indu'le Village
.accept 12107 >>Accept The End of the Line
.target Mage-Commander Evenstar
step
.goto Dragonblight,39.79,67.03
.use 36815 >> |cRXP_WARN_Use the|r |T133442:0|t[|cRXP_LOOT_Ley Line Focus Control Talisman|r] |cRXP_WARN_on the |cRXP_PICK_Ley Line Focus|r underwater|r
.complete 12107,1 
step
#completewith Konani
.goto Dragonblight,48.52,74.39,100 >> Travel to Moa'ki Harbor
.skill coldweatherflying,<1,1
step
#completewith next
.goto Dragonblight,48.52,74.39,100 >> Travel to Moa'ki Harbor
>>|cRXP_WARN_Be careful when dropping off the cliff as you approach Moa'ki Harbor|r
.skill coldweatherflying,1,1
step
#completewith Konani
#label MoaFP
.goto Dragonblight,48.52,74.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cid|r
.fp Moa'ki >> Get the Moa'ki Harbor flight path
.target Cid Flounderfix
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mau'i|r and |cRXP_FRIENDLY_Ko'nani|r
.daily 11960 >>Accept Planning for the Future
.goto Dragonblight,48.25,74.35
.accept 11958 >>Accept Let Nothing Go To Waste
.turnin 12117 >>Turn in Travel to Moa'ki Harbor
.goto Dragonblight,48.00,74.87
.isOnQuest 12117
.target Trapper Mau'i
.target Elder Ko'nani
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mau'i|r and |cRXP_FRIENDLY_Ko'nani|r
.daily 11960 >>Accept Planning for the Future
.goto Dragonblight,48.25,74.35
.accept 11958 >>Accept Let Nothing Go To Waste
.turnin 12118 >>Turn in Travel to Moa'ki Harbor
.goto Dragonblight,48.00,74.87
.isOnQuest 12118
.target Trapper Mau'i
.target Elder Ko'nani

step
#label Konani
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mau'i|r and |cRXP_FRIENDLY_Ko'nani|r
.daily 11960 >>Accept Planning for the Future
.goto Dragonblight,48.25,74.35
.accept 11958 >>Accept Let Nothing Go To Waste
.goto Dragonblight,48.00,74.87
.target Trapper Mau'i
.target Elder Ko'nani

step
#completewith next
.goto Dragonblight,52.92,65.64,20 >> Travel to Azure Dragonshrine
step
.goto Dragonblight,52.92,65.64
>>Observe the Azure Dragonshrine
.complete 12107,2 
step
#requires MoaFP
#loop
.line Dragonblight,49.07,63.26,47.35,64.41,47.33,61.52,44.89,61.37,45.24,63.72,43.85,68.47,42.64,71.91,44.57,71.43,46.01,68.68,47.33,64.45,49.07,63.26
.goto Dragonblight,49.07,63.26,55,0
.goto Dragonblight,47.35,64.41,55,0
.goto Dragonblight,47.33,61.52,55,0
.goto Dragonblight,44.89,61.37,55,0
.goto Dragonblight,45.24,63.72,55,0
.goto Dragonblight,43.85,68.47,55,0
.goto Dragonblight,42.64,71.91,55,0
.goto Dragonblight,44.57,71.43,55,0
.goto Dragonblight,46.01,68.68,55,0
.goto Dragonblight,47.33,64.45,55,0
.goto Dragonblight,49.07,63.26,55,0
>>Kill |cRXP_ENEMY_Snowfall Glade Den Mothers|r, |cRXP_ENEMY_Snowfall Reavers|r, |cRXP_ENEMY_Snowfall Shaman|r and |cRXP_ENEMY_Snowfall Wolvar|r. Loot them for their |cRXP_LOOT_Goods|r
>>Loot |cRXP_LOOT_Snowfall Glade Pups|r. |cRXP_WARN_Do NOT kill them|r
.complete 11958,1 
.complete 11960,1 
.isOnQuest 11960
.target Snowfall Glade Den Mother
.target Snowfall Glade Reaver
.target Snowfall Glade Shaman
.target Snowfall Glade Wolvar
.target Snowfall Glade Pup
step
#requires MoaFP
#loop
.line Dragonblight,49.07,63.26,47.35,64.41,47.33,61.52,44.89,61.37,45.24,63.72,43.85,68.47,42.64,71.91,44.57,71.43,46.01,68.68,47.33,64.45,49.07,63.26
.goto Dragonblight,49.07,63.26,55,0
.goto Dragonblight,47.35,64.41,55,0
.goto Dragonblight,47.33,61.52,55,0
.goto Dragonblight,44.89,61.37,55,0
.goto Dragonblight,45.24,63.72,55,0
.goto Dragonblight,43.85,68.47,55,0
.goto Dragonblight,42.64,71.91,55,0
.goto Dragonblight,44.57,71.43,55,0
.goto Dragonblight,46.01,68.68,55,0
.goto Dragonblight,47.33,64.45,55,0
.goto Dragonblight,49.07,63.26,55,0
>>Kill |cRXP_ENEMY_Snowfall Glade Den Mothers|r, |cRXP_ENEMY_Snowfall Reavers|r, |cRXP_ENEMY_Snowfall Shaman|r and |cRXP_ENEMY_Snowfall Wolvar|r. Loot them for their |cRXP_LOOT_Goods|r
.complete 11958,1 
.target Snowfall Glade Den Mother
.target Snowfall Glade Reaver
.target Snowfall Glade Shaman
.target Snowfall Glade Wolvar
step
#completewith next
.goto Dragonblight,48.25,74.35,100 >> Travel to Moa'ki Harbor
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mau'i|r and |cRXP_FRIENDLY_Ko'nani|r
.turnin 11960 >>Turn in Planning for the Future
.goto Dragonblight,48.25,74.35
.turnin 11958 >>Turn in Let Nothing Go To Waste
.accept 11959 >>Accept Slay Loguhn
.goto Dragonblight,48.00,74.87
.target Trapper Mau'i
.target Elder Ko'nani
step
.use 35688 >> Kill |cRXP_ENEMY_Loguhn|r. Loot him for the |T136168:0|t[|cRXP_LOOT_Blood of Loguhn|r]
>>|cRXP_WARN_Use the|r |T136168:0|t[|cRXP_LOOT_Blood of Loguhn|r]
.collect 35688,1,11959,1 
.goto Dragonblight,46.34,59.13
.complete 11959,1 
.goto Dragonblight,48.03,74.82
.unitscan Loguhn
step
#completewith next
.goto Dragonblight,48.00,74.87,100 >> Travel to Moa'ki Harbor
step
.goto Dragonblight,48.00,74.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ko'nani|r
.turnin 11959 >>Turn in Slay Loguhn
.target Elder Ko'nani
step
#questguide << !wotlk
.goto Dragonblight,48.00,76.15,20,0
.goto Dragonblight,47.69,76.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tua'kea|r
.accept 12009 >>Accept Tua'kea's Crab Traps
.target Tua'kea
step
.goto Dragonblight,49.15,75.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Toalu'u|r
.accept 12028 >>Accept Spiritual Insight
.target Toalu'u the Mystic
step
.goto Dragonblight,48.94,75.75
.use 35907 >> |cRXP_WARN_Use|r |T132859:0|t[Toalu'u's Spiritual Incense] |cRXP_WARN_next to|r |cRXP_PICK_Toalu'u's Brazier|r
>>|cRXP_WARN_Wait out the RP|r
.cast 47190
.timer 160,Spiritual Insight RP
.complete 12028,1 
step
.goto Dragonblight,49.15,75.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Toalu'u|r
.turnin 12028 >>Turn in Spiritual Insight
.accept 12030 >>Accept Elder Mana'loa
.target Toalu'u the Mystic
step
#completewith Kili
.cast 48359 >> |cRXP_WARN_Use|r |T132822:0|t[Tua'kea's Breathing Bladder]
.use 37265
step
#completewith next
.use 38351 >>|cRXP_WARN_Use a|r |T134800:0|t[Murliver Oil] |cRXP_WARN_to increase your swim speed|r
.itemcount 38351,1
.isQuestTurnedIn 11559
step
#questguide << !wotlk
#completewith Kili
.goto Dragonblight,46.5,76.2,0
>>Loot the |cRXP_LOOT_Tua'kea Crab Traps|r on the sea floor
.complete 12009,1 
step
.goto Dragonblight,47.72,79.99
>>Click the |cRXP_PICK_Wrecked Crab Trap|r on the sea floor
.accept 12011 >>Accept Signs of Big Watery Trouble
step
.goto Dragonblight,47.7,76.6,20,0
.goto Dragonblight,47.99,76.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tua'kea|r
.turnin 12011 >>Turn in Signs of Big Watery Trouble
.accept 12016 >>Accept The Bait
.target Tua'kea
step << !Shaman !DK wotlk
#completewith next
.use 38351 >>|cRXP_WARN_Use a|r |T134800:0|t[Murliver Oil] |cRXP_WARN_to increase your swim speed|r
.itemcount 38351,1
.isQuestTurnedIn 11559
step
#label Kili
.goto Dragonblight,43.9,82.7,60,0
.goto Dragonblight,42.00,79.86
>>Kill |cRXP_ENEMY_Kili'ua|r. Loot him for his |cRXP_LOOT_Pincers|r
.complete 12016,1 
.unitscan Kili'ua
step << wotlk
#completewith next
.use 38351 >>|cRXP_WARN_Use a|r |T134800:0|t[Murliver Oil] |cRXP_WARN_to increase your swim speed|r
.itemcount 38351,1
.isQuestTurnedIn 11559
step
#questguide << !wotlk
#loop
.line Dragonblight,44.59,80.85,45.88,81.77,46.31,80.21,45.33,79.80,44.60,79.57,45.53,78.37,46.03,78.29,46.15,76.58,46.66,75.83,46.61,77.50,47.15,78.65,48.33,78.85,45.88,81.77
.goto Dragonblight,44.59,80.85,45,0
.goto Dragonblight,45.88,81.77,45,0
.goto Dragonblight,46.31,80.21,45,0
.goto Dragonblight,45.33,79.80,45,0
.goto Dragonblight,44.60,79.57,45,0
.goto Dragonblight,45.53,78.37,45,0
.goto Dragonblight,46.03,78.29,45,0
.goto Dragonblight,46.15,76.58,45,0
.goto Dragonblight,46.66,75.83,45,0
.goto Dragonblight,46.61,77.50,45,0
.goto Dragonblight,47.15,78.65,45,0
.goto Dragonblight,48.33,78.85,45,0
.goto Dragonblight,45.88,81.77,45,0
.use 37265 >>Loot the |cRXP_LOOT_Tua'kea Crab Traps|r on the sea floor
.complete 12009,1 
step
#questguide << !wotlk
.goto Dragonblight,47.7,76.6,20,0
.goto Dragonblight,47.99,76.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tua'kea|r
.turnin 12009 >>Turn in Tua'kea's Crab Traps
.turnin 12016 >>Turn in The Bait
.accept 12017 >>Accept Meat on the Hook
.target Tua'kea
step << !wotlk
.goto Dragonblight,47.7,76.6,20,0
.goto Dragonblight,47.99,76.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tua'kea|r
.turnin 12016 >>Turn in The Bait
.accept 12017 >>Accept Meat on the Hook
.target Tua'kea
step
.goto Dragonblight,46.74,78.18
.use 35838 >> |cRXP_WARN_Use|r |T134036:0|t[Tu'u'gwar's Bait] |cRXP_WARN_on |cRXP_PICK_Tua'Kea's Fishing Hook|r underwater to summon|r |cRXP_ENEMY_Tu'u'gwar|r
>>Kill |cRXP_ENEMY_Tu'u'gwar|r
.cast 47159
.timer 35,Meat on the Hook RP
.complete 12017,1 
.mob Tu'u'gwar
step
.goto Dragonblight,47.99,76.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tua'kea|r
.turnin 12017 >>Turn in Meat on the Hook
.target Tua'kea
step
#completewith next
.groundgoto Dragonblight,48.5,67.8,50,0
.goto Dragonblight,36.63,64.96,50 >> Travel north to Indu'le Village
step
.goto Dragonblight,36.63,64.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elder Mana'loa|r. |cRXP_WARN_Don't kill any |cRXP_ENEMY_Indu'le|r en route|r
.turnin 12030 >>Turn in Elder Mana'loa
.accept 12031 >>Accept Freedom for the Lingering
.target Elder Mana'loa
step
.goto Dragonblight,36.5,65.5,50,0
.goto Dragonblight,37.0,70.8,50,0
.goto Dragonblight,42.1,71.1,50,0
.goto Dragonblight,41.4,63.7
>>Kill |cRXP_ENEMY_Indu'le Mystics|r, |cRXP_ENEMY_Indu'le Warriors|r and |cRXP_ENEMY_Indu'le Fishermen|r
.complete 12031,1 
.mob Indu'le Mystic
.mob Indu'le Warrior
.mob Indu'le Fisherman
step
#questguide << !wotlk
.goto Dragonblight,36.63,64.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elder Mana'loa|r
.turnin 12031 >>Turn in Freedom for the Lingering
.accept 12032 >>Accept Conversing With the Depths
.target Elder Mana'loa
step << !wotlk
.goto Dragonblight,36.63,64.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elder Mana'loa|r
.turnin 12031 >>Turn in Freedom for the Lingering
.target Elder Mana'loa
step
#questguide << !wotlk
#completewith next
.groundgoto Dragonblight,34.5,80.1,40,0
.groundgoto Dragonblight,35.1,82.5,40,0
.goto Dragonblight,33.91,83.22,40 >> Travel to The Briny Pinnacle
step
#questguide << !wotlk
.waypoint Dragonblight,34.11,84.76,-47098,wpbuff,UNIT_AURA
.goto Dragonblight,33.96,83.49
>>Click |cRXP_PICK_The Pearl of the Depths|r
>>|cRXP_WARN_Wait out the RP|r
>>|cRXP_WARN_Once you have the|r |T135895:0|t[Oacha'noa's Compulsion] |cRXP_WARN_buff, jump into the water to|r |cRXP_FRIENDLY_Oacha'noa|r
.cast 3365
.timer 40,Oach'a'noa RP
.complete 12032,1 
.target Oacha'noa
step << Druid wotlk
#completewith DruidTrain1
.cast 18960 >> Cast Teleport: Moonglade
.zoneskip Moonglade
.xp <72,1
step << Druid wotlk
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 48464 >> Train your class spells
.xp <72,1
.target Loganaar
step << Druid wotlk
#label DruidTrain1
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 53307 >> Train your class spells
.xp <74,1
.target Loganaar
step << DK wotlk
#completewith DKTrain1
.cast 50977 >> Cast Death Gate
.zoneskip Eastern Plaguelands
.xp <72,1
step << DK wotlk
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49940 >> Train your class spells
.xp <72,1
.target Amal'thazad
step << DK wotlk
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49904 >> Train your class spells
.xp <73,1
.target Amal'thazad
step << DK wotlk
#label DKTrain1
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49929 >> Train your class spells
.xp <74,1
.target Amal'thazad
step << Mage wotlk
#completewith MageTrain1
.zone Stormwind City >> Teleport to Stormwind
.xp <72,1
step << Mage wotlk
.goto Stormwind City,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42930 >> Train your class spells
.xp <72,1
.target Elsharin
.target Jennea Cannon
step << Mage wotlk
.goto Stormwind City,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 43019 >> Train your class spells
.xp <73,1
.target Elsharin
.target Jennea Cannon
step << Mage wotlk
#label MageTrain1
.goto Stormwind City,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42939 >> Train your class spells
.xp <74,1
.target Elsharin
.target Jennea Cannon
step
#label pt1end
#completewith next
.hs >> Hearth to Stars' Rest
step
.goto Dragonblight,29.00,55.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Modera|r
.turnin 12107 >>Turn in The End of the Line
.accept 12119 >>Accept Gaining an Audience
.target Image of Archmage Modera
step
#label pt2start
.goto Dragonblight,28.84,56.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lanson|r
.accept 12171 >>Accept Of Traitors and Treason
.target Courier Lanson
step
.goto Dragonblight,29.18,55.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Palena|r
.turnin 12171 >>Turn in Of Traitors and Treason
.accept 12174 >>Accept High Commander Halford Wyrmbane
.timer 88,Westguard Keep Flight
>>|cRXP_WARN_Accepting this quest will send you flying to eastern Dragonblight|r
.target Palena Silvercloud
step
#completewith next
.goto Dragonblight,77.08,49.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rodney|r
.fp Wintergarde Keep>>Get the Wintergarde Keep Flight Path
.target Rodney Wells
step
.goto Dragonblight,78.59,48.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford Wyrmbane|r
.turnin 12174 >>Turn in High Commander Halford Wyrmbane
.accept 12235 >>Accept Naxxramas and the Fall of Wintergarde
.target High Commander Halford Wyrmbane
step
.goto Dragonblight,77.10,50.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urik|r
.turnin 12235 >>Turn in Naxxramas and the Fall of Wintergarde
.accept 12237 >>Accept Flight of the Wintergarde Defender
.target Gryphon Commander Urik
step
#completewith next
.goto Dragonblight,77.13,49.78
.vehicle 27258 >> |cRXP_WARN_Use the|r |T132161:0|t[Wintergarde Gryphon Whistle] |cRXP_WARN_to mount a|r |cRXP_FRIENDLY_Gryphon|r
.use 37287
step
.waypoint Dragonblight,86.38,50.91,0,rescue,VEHICLE_PASSENGERS_CHANGED,VEHICLE_UPDATE
>>|cRXP_WARN_Fly to The Carrion Fields|r
>>|cRXP_WARN_Cast|r |T134148:0|t[Rescue Villager] (1) |cRXP_WARN_to pick up |cRXP_FRIENDLY_Helpless Villagers|r. You can only pick up one at a time|r
>>|cRXP_WARN_Cast|r |T134149:0|t[Drop Off Villager] (2) |cRXP_WARN_to drop them off at|r |cRXP_FRIENDLY_Urik|r
>>|cRXP_WARN_Cast|r |T132172:0|t[Soar] (3) |cRXP_WARN_on cooldown to fly faster|r
.complete 12237,1 
.goto Dragonblight,77.13,49.78
.use 37287
.target Helpless Wintergarde Villager
step
.goto Dragonblight,77.10,50.12
>>|cRXP_WARN_Dismount the Gryphon|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urik|r
.turnin 12237 >>Turn in Flight of the Wintergarde Defender
.accept 12251 >>Accept Return to the High Commander
.target Gryphon Commander Urik
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford Wyrmbane|r and |cRXP_FRIENDLY_Windstryke|r
.turnin 12251 >>Turn in Return to the High Commander
.accept 12253 >>Accept Rescue from Town Square
.accept 12275 >>Accept The Demo-gnome
.goto Dragonblight,78.47,48.28
.accept 12258 >>Accept The Fate of the Dead
.goto Dragonblight,78.64,48.18
.target High Commander Halford Wyrmbane
.target Commander Lynore Windstryke
step
.goto Dragonblight,79.15,47.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zelig|r
.accept 12282 >>Accept Imprints on the Past
.target Zelig the Visionary
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Quarterflash|r and |cRXP_FRIENDLY_Von Zeldig|r
.turnin 12275 >>Turn in The Demo-gnome
.accept 12276 >>Accept The Search for Slinkin
.accept 12272 >>Accept The Bleeding Ore
.goto Dragonblight,77.84,50.29
.accept 12269 >>Accept Not in Our Mine
.goto Dragonblight,77.80,50.34
.target Siege Engineer Quarterflash
.target Highlord Leoric Von Zeldig
step
#completewith chief
.goto Dragonblight,77.47,51.41,10,0
.goto Dragonblight,77.41,51.84,10,0
.goto Dragonblight,77.47,51.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Illusia|r
.home >> Set your Hearthstone to Wintergarde Keep
.target Illusia Lune
step
.goto Dragonblight,77.34,51.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tClick on |cRXP_FRIENDLY_The Wanted Poster|r
.accept 12438 >>Accept Wanted: Kreug Oathbreaker
.accept 12441 >>Accept Wanted: High Shaman Bloodpaw
.accept 12442 >>Accept Wanted: Onslaught Commander Iustus
step
#completewith next
.groundgoto Dragonblight,78.84,48.23,50,0
.goto Dragonblight,79.6,50.5,15 >> Enter the Town Hall
step
#label orb
#sticky
.goto Dragonblight,79.6,50.5,10,0
.goto Dragonblight,78.86,50.88
>>|cRXP_WARN_Travel up the stairs in the Town Hall|r
>>Loot the |cRXP_LOOT_Scrying Orb|r on the 2nd floor
.complete 12282,1 
step
.goto Dragonblight,78.98,51.61,60,0
.goto Dragonblight,79.83,51.69,60,0
.goto Dragonblight,80.89,51.51,60,0
.goto Dragonblight,80.70,48.22,60,0
.goto Dragonblight,79.89,52.17
>>Kill |cRXP_ENEMY_Vengeful Geists|r surrounding the |cRXP_FRIENDLY_Trapped Wintergarde Villagers|r
.complete 12258,1 
.complete 12253,1 
.mob Vengeful Geist
step
#completewith next
.goto Dragonblight,80.21,44.87,15 >> Travel to the Wintergarde Mine. Enter through the lower mine shaft
step
#sticky
#label mine
.goto Dragonblight,78.9,42.1,0,0
>>Kill |cRXP_ENEMY_Risen Wintergarde Miners|r. Loot them for their |cRXP_LOOT_Cards|r
>>|cRXP_ENEMY_Wintergarde Defenders|r |cRXP_WARN_do NOT drop them|r
>>Loot the |cRXP_LOOT_Strange Ore|r on the ground
.complete 12269,1 
.complete 12272,1 
.mob Risen Wintergarde Miner
step
.goto Dragonblight,81.53,42.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the corpse of |cRXP_FRIENDLY_Slinkin|r
.turnin 12276 >>Turn in The Search for Slinkin
.accept 12277 >>Accept Leave Nothing to Chance
.target Slinkin the Demo-gnome
step
.goto Dragonblight,80.74,41.31
>>Loot the |T133717:0|t[|cRXP_LOOT_Wintergarde Mine Bomb|r] on the ground
.collect 37465,1,12277,1
step
.goto Dragonblight,80.14,45.35
.cast 48741 >>|cRXP_WARN_Use the|r |T133717:0|t[|cRXP_LOOT_Wintergarde Mine Bomb|r] |cRXP_WARN_at the Lower Mine Shaft entrance|r

.use 37465
.isOnQuest 12277
step
.goto Dragonblight,80.42,44.95
.cast 48741 >>|cRXP_WARN_Use the|r |T133717:0|t[|cRXP_LOOT_Wintergarde Mine Bomb|r] |cRXP_WARN_at the Upper Mine Shaft entrance|r

.use 37465
.isOnQuest 12277
step
.groundgoto Dragonblight,81.54,48.75,50,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r and |cRXP_FRIENDLY_Windstryke|r
.turnin 12253 >>Turn in Rescue from Town Square
.accept 12309 >>Accept Find Durkon!
.goto Dragonblight,78.58,48.20
.turnin 12258 >>Turn in The Fate of the Dead
.goto Dragonblight,78.64,48.18
.target High Commander Halford Wyrmbane
.target Commander Lynore Windstryke
step
.goto Dragonblight,79.15,47.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zelig|r
.turnin 12282 >>Turn in Imprints on the Past
.accept 12287 >>Accept Orik Trueheart and the Forgotten Shore
.target Zelig the Visionary
step
.goto Dragonblight,77.81,50.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Quarterflash|r and |cRXP_FRIENDLY_Von Zeldig|r
.turnin 12272 >>Turn in The Bleeding Ore
.turnin 12277 >>Turn in Leave Nothing to Chance
.accept 12281 >>Accept Understanding the Scourge War Machine
.goto Dragonblight,77.84,50.29
.turnin 12269 >>Turn in Not In Our Mine
.goto Dragonblight,77.80,50.34
.target Siege Engineer Quarterflash
.target Highlord Leoric Von Zeldig
step
.goto Dragonblight,78.54,48.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r
.turnin 12281 >>Turn in Understanding the Scourge War Machine
.target High Commander Halford Wyrmbane
step
#completewith next
.goto Dragonblight,79.06,53.21,50 >> Travel toward |cRXP_FRIENDLY_Durkon|r at the Wintergarde Crypt
step
.goto Dragonblight,79.06,53.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Durkon|r
.turnin 12309 >>Turn in Find Durkon!
.accept 12311 >>Accept The Noble's Crypt
.target Cavalier Durkon
step
.goto Dragonblight,78.62,52.28
>>|cRXP_WARN_Enter the Wintergarde Crypt|r
>>Kill |cRXP_ENEMY_Necrolord Amarion|r
>>Click the |cRXP_PICK_Flesh-bound Tome|r on the ground
.complete 12311,1 
.accept 12312 >>Accept Secrets of the Scourge
.mob Necrolord Amarion
step
#label pt2end
.goto Dragonblight,79.06,53.21
>>|cRXP_WARN_Exit Wintergarde Crypt|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Durkon|r
.turnin 12311 >>Turn in The Noble's Crypt
.turnin 12312 >>Turn in Secrets of the Scourge
.accept 12319 >>Accept Mystery of the Tome
.target Cavalier Durkon
step
.goto Dragonblight,78.56,48.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r
.turnin 12319 >>Turn in Mystery of the Tome
.accept 12320 >>Accept Understanding the Language of Death
.target High Commander Halford Wyrmbane
step
#completewith next
.groundgoto Dragonblight,78.2,46.7,40,0
.goto Dragonblight,76.81,47.51,40 >> Travel to the Keep
step
.goto Dragonblight,76.81,47.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Commander Eligor|r
.accept 12464 >>Accept My Old Enemy
.target Commander Eligor Dawnbringer
step
.goto Dragonblight,76.99,47.92,12,0
.goto Dragonblight,76.82,47.52
>>|cRXP_WARN_Enter the Jail downstairs|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hallard|r
.turnin 12320 >>Turn in Understanding the Language of Death
.accept 12321 >>Accept A Righteous Sermon
.timer 184,A Righteous Sermon RP
.target Inquisitor Hallard
step
.goto Dragonblight,78.2,47.2
>>|cRXP_WARN_Exit the Keep|r
>>|cRXP_WARN_Wait where the arrow is pointing while |cRXP_FRIENDLY_Inquisitor Hallard|r delivers his Righteous Sermon|r
>>|cRXP_WARN_If you go too far and the quest fails, go back and pick it up again|r
>>|cRXP_WARN_He takes 2 minutes and 55 seconds. You can take a break during this time|r
.complete 12321,1 
step
.goto Dragonblight,78.48,48.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r
.turnin 12321 >>Turn in A Righteous Sermon
.accept 12325 >>Accept Into Hostile Territory
.target High Commander Halford Wyrmbane
step
#completewith next
.goto Dragonblight,77.20,49.54,-1
.goto Dragonblight,89.68,46.36,-1
.vehicle >> Mount a |cRXP_FRIENDLY_Wintergarde Gryphon|r to fly to Thorson's Post
.timer 40,Into Hostile Territory RP
.target Wintergarde Gryphon
.skill coldweatherflying,1,1
step
.goto Dragonblight,89.68,46.36
>>|cRXP_WARN_Wait out the flight to Thorson's Post|r
>>|cRXP_WARN_Click off the|r |T135992:0|t[Parachute] |cRXP_WARN_buff when you're close to the ground|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foehammer|r
.turnin 12325 >>Turn in Into Hostile Territory
.accept 12326 >>Accept Steamtank Surprise
.target Duke August Foehammer
.skill coldweatherflying,1,1
step
.goto Dragonblight,89.68,46.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foehammer|r
.turnin 12325 >>Turn in Into Hostile Territory
.accept 12326 >>Accept Steamtank Surprise
.target Duke August Foehammer
step
.goto Dragonblight,90.1,52.7
>>Kill |cRXP_ENEMY_Kreug Oathbreaker|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r
.complete 12438,1 
.mob Kreug Oathbreaker
step
#completewith next
.goto Dragonblight,89.8,46.8,10,0
.goto Dragonblight,89.7,45.6
.vehicle 27587 >> Enter an |cRXP_FRIENDLY_Alliance Steam Tank|r
.target Alliance Steam Tank
step
>>|cRXP_WARN_Cast|r |T135836:0|t[Ice Cannon] (1) |cRXP_WARN_and|r |T135834:0|t[Ice Prison] (2) |cRXP_WARN_to kill the|r |cRXP_ENEMY_Scourge|r
>>|cRXP_WARN_Cast|r |T134165:0|t[Drop Off Gnome] (3) |cRXP_WARN_when next to |cRXP_ENEMY_Plague Wagons|r to sabotage them. You can only sabotage 1 |cRXP_ENEMY_Plague Wagon|r at a time|r
>>|cRXP_WARN_If the |cRXP_FRIENDLY_Gnome|r stops sabotaging a |cRXP_ENEMY_Plague Wagon|r, return to |cRXP_FRIENDLY_Foehammer|r and get a new |cRXP_FRIENDLY_Tank|r|r
.goto Dragonblight,87.25,50.97
.complete 12326,1 
.cast 49109
.timer 15,Plague Wagon Sabotage RP
.mob Plague Wagon
step
#completewith next
.goto Dragonblight,85.60,49.90,20 >> Travel to the Wintergarde Mausoleum
>>|cRXP_WARN_Stay in the|r |cRXP_FRIENDLY_Alliance Steam Tank|r
step
.goto Dragonblight,85.60,49.90
>>|cRXP_WARN_Cast|r |T135942:0|t[Drop Off Soldier] (4) |cRXP_WARN_at the entrance of the Wintergarde Mausoleum|r
.complete 12326,2 
step
#completewith next
.goto Dragonblight,86.18,50.26,12 >> Enter the Wintergarde Mausoleum
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ambo|r and |cRXP_FRIENDLY_Yord|r inside the Mausoleum
.turnin 12326 >>Turn in Steamtank Surprise
.accept 12455 >>Accept Scattered To The Wind
.goto Dragonblight,85.94,50.87
.accept 12462 >>Accept Breaking Off A Piece
.goto Dragonblight,85.86,51.03
.target Ambo Cash
.target Yord "Calamity" Icebeard
step
#completewith next
.goto Dragonblight,86.16,50.18,12 >> Exit the Wintergarde Mausoleum
step
.goto Dragonblight,83.3,46.4,70,0
.goto Dragonblight,83.4,51.0,70,0
.goto Dragonblight,89.1,53.0,70,0
.goto Dragonblight,83.4,51.0
>>Open the |cRXP_PICK_Wintergarde Munitions Crates|r. Loot them for the |cRXP_LOOT_Wintergarde Munitions|r
.complete 12455,1 
step
#completewith next
.goto Dragonblight,85.60,49.90,15,0
.goto Dragonblight,86.18,50.26,12 >> Enter the Wintergarde Mausoleum
step
.goto Dragonblight,85.94,50.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ambo|r
.turnin 12455 >>Turn in Scattered To The Wind
.accept 12457 >>Accept The Chain Gun And You
.target Ambo Cash
step
.goto Dragonblight,86.24,51.06
#completewith next
.vehicle >> Get into a |cRXP_FRIENDLY_Chain Gun|r
step
.goto Dragonblight,86.24,51.06
>>|cRXP_WARN_Cast|r |T132351:0|t[Call Out Injured Soldier] (2) |cRXP_WARN_to make a |cRXP_FRIENDLY_Soldier|r run for safety|r
>>|cRXP_WARN_Cast|r |T136186:0|t[7th Legion Chain Gun] (1) |cRXP_WARN_to kill the |cRXP_ENEMY_Undead|r attacking the|r |cRXP_FRIENDLY_Soldier|r
.complete 12457,1 
step
>>|cRXP_WARN_Exit the|r |cRXP_FRIENDLY_Chain Gun|r
.goto Dragonblight,85.94,50.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ambo|r
.turnin 12457 >>Turn in The Chain Gun And You
.accept 12463 >>Accept Plunderbeard Must Be Found!
.target Ambo Cash
step
.goto Dragonblight,85.7,51.7,12,0
>>|cRXP_WARN_Travel further down into the Mausoleum|r
>>Kill |cRXP_ENEMY_Necrolord X'avius|r and |cRXP_ENEMY_Necrolord Horus|r
>>Kill the |cRXP_ENEMY_Naxxramas Scourge|r
.complete 12462,2 
.mob +Necrolord X'avius
.goto Dragonblight,84.35,51.01
.complete 12462,1 
.mob +Necrolord Horus
.complete 12462,3 
.goto Dragonblight,86.69,52.91
.mob Tattered Abomination
.mob Scourge Technician
.mob Leprous Servant
.mob Naxxramas Dreadguard
.mob Naxxramas Shade
.mob Dreadbone Construct
.mob Wailing Soul
step
.goto Dragonblight,85.86,51.03
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yord|r
.turnin 12462 >>Turn in Breaking Off A Piece
.target Yord "Calamity" Icebeard
step
.goto Dragonblight,84.17,54.68
>>|cRXP_WARN_Travel downstairs to the back of the Mausoleum. Enter the small tunnel at the back right corner|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the corpse of |cRXP_FRIENDLY_Plunderbeard|r
.turnin 12463 >>Turn in Plunderbeard Must Be Found!
.accept 12465 >>Accept Plunderbeard's Journal
.target Plunderbeard
step
.goto Dragonblight,84.0,56.1,20,0
.goto Dragonblight,83.4,55.1,20,0
.goto Dragonblight,82.2,54.0
>>|cRXP_WARN_Continue through to the end of the tunnel|r
>>Kill |cRXP_ENEMY_Dreadbone Constructs|r and |cRXP_ENEMY_Wailing Souls|r. Loot them for their |cRXP_LOOT_Journal Pages|r
.complete 12465,1 
.complete 12465,2 
.complete 12465,3 
.complete 12465,4 
.mob Dreadbone Construct
.mob Wailing Soul
step
.goto Dragonblight,80.9,51.9,20,0
.goto Dragonblight,81.55,50.70,20 >> |cRXP_WARN_Keep going through the Mausoleum and exit through the other entrance|r
.isOnQuest 12465
step
#completewith next
.goto Dragonblight,85.60,49.90,15,0
.goto Dragonblight,86.18,50.26,12 >> Enter the Wintergarde Mausoleum
step
.goto Dragonblight,85.94,50.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ambo|r in the Mausoleum
.turnin 12465 >>Turn in Plunderbeard's Journal
.accept 12466 >>Accept Chasing Icestorm: The 7th Legion Front
.target Ambo Cash
step
#completewith next
.goto Dragonblight,86.16,50.18,12,0
.goto Dragonblight,85.73,49.99,12 >> Exit the Wintergarde Mausoleum
step
.goto Dragonblight,87.17,57.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Orik|r
.turnin 12287 >>Turn in Orik Trueheart and the Forgotten Shore
.accept 12290 >>Accept The Murkweed Elixir
.target Orik Trueheart
step
#label chief
#sticky
.goto Dragonblight,90.67,72.89
>>Kill |cRXP_ENEMY_High Shaman Bloodpaw|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r
>>|cRXP_WARN_Cast|r |T136075:0|t[Purge] |cRXP_WARN_when he has Bloodlust|r << Shaman
>>|cRXP_WARN_Cast|r |T135894:0|t[Dispel Magic] |cRXP_WARN_when he has Bloodlust|r << Priest
.complete 12441,1 
.mob High Shaman Bloodpaw
step
.goto Dragonblight,89.2,65.4,70,0
.goto Dragonblight,90.2,74.6,70,0
.goto Dragonblight,89.28,65.60,70,0
.goto Dragonblight,90.22,72.24
>>Loot the |cRXP_LOOT_Murkweed|r on the ground
.complete 12290,1 
step
#requires chief
.goto Dragonblight,87.17,57.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Orik|r
.turnin 12290 >>Turn in The Murkweed Elixir
.accept 12291 >>Accept The Forgotten Tale
.target Orik Trueheart
step
#completewith next
.goto Dragonblight,87.1,67.3,100 >> Travel to The Forgotten Shore
step
>>|cRXP_WARN_Use the|r |T134711:0|t[Murkweed Elixir] |cRXP_WARN_at The Forgotten Shore|r
.use 37570 >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to a |cRXP_FRIENDLY_Forgotten Peasant|r, |cRXP_FRIENDLY_Forgotten Rifleman|r, |cRXP_FRIENDLY_Forgotten Knight|r and |cRXP_FRIENDLY_Forgotten Footman|r
.complete 12291,1 
.goto Dragonblight,87.1,67.3
.complete 12291,2 
.goto Dragonblight,86.2,67.5
.complete 12291,3 
.goto Dragonblight,86.6,68.6,50,0
.goto Dragonblight,85.1,69.7
.complete 12291,4 
.goto Dragonblight,85.2,68.5
.skipgossip
.target Forgotten Peasant
.target Forgotten Rifleman
.target Forgotten Knight
.target Forgotten Footman
step
.goto Dragonblight,87.17,57.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Orik|r
.turnin 12291 >>Turn in The Forgotten Tale
.accept 12301 >>Accept The Truth Shall Set Us Free
.target Orik Trueheart
step
#completewith next
.goto Dragonblight,86.80,66.19,100 >> Travel to The Forgotten Shore
step
.goto Dragonblight,86.80,66.19
.use 37577 >>|cRXP_WARN_Use|r |T134334:0|t[Orik's Crystalline Orb] |cRXP_WARN_when standing next to the blue |cRXP_PICK_Forgotten Ruins|r on the ground|r
>>|cRXP_WARN_Wait out the RP|r
.cast 48866
.timer 129,The Truth Shall Set Us Free RP
.complete 12301,1 
step
.goto Dragonblight,87.17,57.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Orik|r
.turnin 12301 >>Turn in The Truth Shall Set Us Free
.accept 12305 >>Accept Parting Thoughts
.target Orik Trueheart
step << Shaman
#completewith next
.hs >> Hearth to Wintergarde Keep
.cooldown item,6948,>2
step << !Shaman
#completewith next
.goto Dragonblight,79.15,47.17,100 >> Travel to Wintergarde Keep
step
.goto Dragonblight,79.15,47.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zelig|r
.turnin 12305 >>Turn in Parting Thoughts
.accept 12475 >>Accept What Secrets Men Hide
.target Zelig the Visionary
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r and |cRXP_FRIENDLY_Windstryke|r
.accept 12477 >>Accept The Path of Redemption
.goto Dragonblight,78.58,48.20
.accept 12476 >>Accept The Return of the Crusade?
.goto Dragonblight,78.64,48.18
.target High Commander Halford Wyrmbane
.target Commander Lynore Windstryke
step
#completewith Iustus
.goto Dragonblight,84.7,37.1,0,0
>>Kill |cRXP_ENEMY_Onslaught Infantry|r, |cRXP_ENEMY_Onslaught Scouts|r and |cRXP_ENEMY_Onslaught Masons|r. Loot them for the |cRXP_LOOT_Path of Redemption|r
.complete 12476,1 
.complete 12477,1 
.mob Onslaught Infantry
.mob Onslaught Scout
.mob Onslaught Mason
.mob Onslaught Commander Iustus
.mob Scarlet Highlord Daion
step
.goto Dragonblight,87.57,38.13
>>Loot the |cRXP_PICK_Onslaught Map|r on top of the table
.complete 12475,1 
step
#label Iustus
.goto Dragonblight,87.4,38.1
>>|cRXP_WARN_Travel up the Tower|r
>>Kill |cRXP_ENEMY_Commander Iustus|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r
.complete 12442,1 
.mob Onslaught Commander Iustus
step
#label scarlet
.goto Dragonblight,87.39,35.30,70,0
.goto Dragonblight,84.58,37.12,70,0
.goto Dragonblight,84.21,40.99,70,0
.goto Dragonblight,86.37,40.31,70,0
.goto Dragonblight,87.85,40.92
>>Kill |cRXP_ENEMY_Onslaught Infantry|r, |cRXP_ENEMY_Onslaught Scouts|r and |cRXP_ENEMY_Onslaught Masons|r. Loot them for the |cRXP_LOOT_Path of Redemption|r
.complete 12476,1 
.complete 12477,1 
.mob Onslaught Infantry
.mob Onslaught Scout
.mob Onslaught Mason
.mob Onslaught Commander Iustus
.mob Scarlet Highlord Daion
step << Shaman
#completewith next
.hs >> Hearth to Wintergarde Keep
.cooldown item,6948,>2
step << !Shaman
#requires scarlet
#completewith next
.goto Dragonblight,79.15,47.17,100 >> Travel to Wintergarde Keep
step
.goto Dragonblight,79.15,47.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zelig|r in Wintergarde Keep
.turnin 12475 >>Turn in What Secrets Men Hide
.accept 12478 >>Accept Frostmourne Cavern
.target Zelig the Visionary
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r and |cRXP_FRIENDLY_Windstryke|r
.turnin 12477 >>Turn in The Path of Redemption
.goto Dragonblight,78.58,48.20
.turnin 12476 >>Turn in The Return of the Crusade?
.goto Dragonblight,78.64,48.18
.target High Commander Halford Wyrmbane
.target Commander Lynore Windstryke
step
.goto Dragonblight,77.80,50.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Von Zeldig|r
.turnin 12438 >>Turn in Wanted: Kreug Oathbreaker
.turnin 12441 >>Turn in Wanted: High Shaman Bloodpaw
.turnin 12442 >>Turn in Wanted: Onslaught Commander Iustus
.isQuestComplete 12438
.isQuestComplete 12441
.isQuestComplete 12442
.target Highlord Leoric Von Zeldig
step
.goto Dragonblight,77.80,50.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Von Zeldig|r
.turnin 12438 >>Turn in Wanted: Kreug Oathbreaker
.turnin 12441 >>Turn in Wanted: High Shaman Bloodpaw
.isQuestComplete 12438
.isQuestComplete 12441
.target Highlord Leoric Von Zeldig
step
.goto Dragonblight,77.80,50.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Von Zeldig|r
.turnin 12438 >>Turn in Wanted: Kreug Oathbreaker
.turnin 12442 >>Turn in Wanted: Onslaught Commander Iustus
.isQuestComplete 12438
.isQuestComplete 12442
.target Highlord Leoric Von Zeldig
step
.goto Dragonblight,77.80,50.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Von Zeldig|r
.turnin 12441 >>Turn in Wanted: High Shaman Bloodpaw
.turnin 12442 >>Turn in Wanted: Onslaught Commander Iustus
.isQuestComplete 12441
.isQuestComplete 12442
.target Highlord Leoric Von Zeldig
step
.goto Dragonblight,77.80,50.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Von Zeldig|r
.turnin 12438 >>Turn in Wanted: Kreug Oathbreaker
.isQuestComplete 12438
.target Highlord Leoric Von Zeldig
step
.goto Dragonblight,77.80,50.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Von Zeldig|r
.turnin 12441 >>Turn in Wanted: High Shaman Bloodpaw
.isQuestComplete 12441
.target Highlord Leoric Von Zeldig
step
.goto Dragonblight,77.80,50.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Von Zeldig|r
.turnin 12442 >>Turn in Wanted: Onslaught Commander Iustus
.isQuestComplete 12442
.target Highlord Leoric Von Zeldig
step
#completewith Audience
>>Abandon the Elite quests you were unable to complete
.abandon 12438 >> Abandon Wanted: Kreug Oathbreaker
.abandon 12441 >> Abandon Wanted: High Shaman Bloodpaw
.abandon 12442 >> Abandon Wanted: Onslaught Commander Iustus
step
#completewith Audience
.goto Dragonblight,74.8,51.6,50,0
.goto Dragonblight,60.36,51.59,100 >> Travel to Wyrmrest Temple
step
.goto Dragonblight,60.32,51.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nethestrasz|r
.fp Wyrmrest >> Get the Wyrmrest Temple Flight Path
.target Nethestrasz
step
#label Audience
.goto Dragonblight,57.91,54.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tariolstrasz|r
.turnin 12119 >>Turn in Gaining an Audience
.accept 12766 >>Accept Speak with your Ambassador
.target Tariolstrasz
step
#completewith next
.goto Dragonblight,57.91,54.17
.gossipoption 93560 >>Talk to |cRXP_FRIENDLY_Tariolstrasz|r to fly to the top of Wyrmrest Temple
.timer 19,Flight to top of Wyrmrest Temple
.skill coldweatherflying,1,1
.target Tariolstrasz
step
>>|cRXP_WARN_Atop Wyrmrest Temple|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Itharius|r, |cRXP_FRIENDLY_Chromie|r, and |cRXP_FRIENDLY_Nalice|r
.accept 12458 >>Accept Seeds of the Lashers
.goto Dragonblight,59.60,54.47
.accept 12470 >>Accept Mystery of the Infinite
.goto Dragonblight,60.00,54.51
.accept 12447 >>Accept The Obsidian Dragonshrine
.goto Dragonblight,60.07,54.20
.target Nalice
.target Chromie
.target Lord Itharius
step
#completewith next
.goto Dragonblight,59.51,53.33
.gossipoption 93074 >>Talk to |cRXP_FRIENDLY_Torastrasza|r to fly to the bottom of Wyrmrest Temple
.timer 19,Flight to bottom of Wyrmrest Temple
.skill coldweatherflying,1,1
.target Torastrasza
step
#completewith next
.groundgoto Dragonblight,69.87,45.71,30,0
.goto Dragonblight,71.1,39.5,100 >> Travel to the Bronze Dragonshrine
step
.goto Dragonblight,71.1,39.5
>>|cRXP_WARN_Use the|r |T133018:0|t[Hourglass of Eternity]|cRXP_WARN_. Protect it against the incoming waves|r
.cast 49890
.timer 175,Hourglass of Eternity
.complete 12470,1 
.use 37923
.mob Infinite Assailant
.mob Infinite Destroyer
.mob Infinite Chrono-Magus
step
#completewith next
.goto Dragonblight,64.74,27.93,100 >> Travel to the 7th Legion Front
step
.goto Dragonblight,64.74,27.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tyralion|r
.turnin 12466 >>Turn in Chasing Icestorm: The 7th Legion Front
.accept 12467 >>Accept Chasing Icestorm: Thel'zan's Phylactery
.target Legion Commander Tyralion
step
.goto Dragonblight,64.61,27.45
.gossipoption 93435 >> Talk to |cRXP_FRIENDLY_"Wyrmbait"|r to make |cRXP_ENEMY_Icestorm|r land
.skipgossip
.timer 45,Chasing Icestorm: Thel'zan's Phylactery RP
.isOnQuest 12467
.target "Wyrmbait"
step
#label Pest
.goto Dragonblight,64.60,27.46,8,0
.goto Dragonblight,64.47,26.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Duane|r
.accept 12142 >>Accept Pest Control
.target Duane
step
.goto Dragonblight,63.8,27.5
>>|cRXP_WARN_Wait for |cRXP_ENEMY_Icestorm|r to be harpooned|r
>>Kill |cRXP_ENEMY_Icestorm|r. Loot the |cRXP_LOOT_Phylactery|r that drops on the ground
.complete 12467,1 
.mob Icestorm
step
#requires Pest
.goto Dragonblight,70.20,32.71,0
.goto Dragonblight,70.20,32.71,60,0
.goto Dragonblight,65.30,42.60,60,0
.goto Dragonblight,70.20,32.71,60,0
.goto Dragonblight,65.30,42.60
>>Kill |cRXP_ENEMY_Snowplain Zealots|r, |cRXP_ENEMY_Snowplain Disciples|r and |cRXP_ENEMY_Snowplain Shaman|r
>>Kill |cRXP_ENEMY_Magnataur Patriarchs|r, |cRXP_ENEMY_Magnataur Younglings|r and |cRXP_ENEMY_Magnataur Alphas|r
.complete 12142,1 
.complete 12142,2 
.mob Snowplain Zealot
.mob Snowplain Shaman
.mob Snowplain Disciple
.mob Magnataur Patriarch
.mob Magnataur Youngling
.mob Magnataur Alpha
step
#completewith next
.goto Dragonblight,64.74,27.93,100 >> Travel to the 7th Legion Front
step
.goto Dragonblight,64.47,26.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Duane|r
.turnin 12142 >>Turn in Pest Control
.accept 12143 >>Accept Canyon Chase
.target Duane
step
#label Chilltusk
.goto Dragonblight,72.0,27.5,60,0
.goto Dragonblight,72.41,28.86
>>Kill |cRXP_ENEMY_Chilltusk|r. Loot him for his |T134229:0|t[|cRXP_LOOT_Emblazoned Battle Horn|r]
>>|cRXP_WARN_Use the |T134229:0|t[|cRXP_LOOT_Emblazoned Battle Horn|r] to start the quest|r
>>|cRXP_ENEMY_Chilltusk|r |cRXP_WARN_patrols inside the canyon|r
.complete 12143,1 
.collect 36855,1,12146
.accept 12146 >>Accept Disturbing Implications
.use 36855
.unitscan Chilltusk
step
.goto Dragonblight,71.1,39.5
>>Travel to the Bronze Dragonshrine
>>|cRXP_WARN_Use the|r |T133018:0|t[Hourglass of Eternity]|cRXP_WARN_. Protect it against the incoming waves|r
.cast 49890
.timer 175,Hourglass of Eternity
.complete 12470,1 
.use 37923
.mob Infinite Assailant
.mob Infinite Destroyer
.mob Infinite Chrono-Magus
step
#completewith next
.goto Dragonblight,74.3,23.6,60 >> Travel to Frostmourne Cavern
step
.goto Dragonblight,74.3,23.6,50,0
.goto Dragonblight,75.08,20.21
.use 37933 >> |cRXP_WARN_Use|r |T134334:0|t[Zelig's Scrying Orb] |cRXP_WARN_at the|r |cRXP_PICK_Frostmourne Altar|r
>>|cRXP_WARN_Wait out the RP|r
.cast 49817
.timer 110,Frostmourne Cavern RP
.complete 12478,1 
step << Druid wotlk
#completewith DruidTrain2
.cast 18960 >> Cast Teleport: Moonglade
.zoneskip Moonglade
.xp <72,1
step << Druid wotlk
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 48464 >> Train your class spells
.xp <72,1
.target Loganaar
step << Druid wotlk
#label DruidTrain2
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 53307 >> Train your class spells
.xp <74,1
.target Loganaar
step << DK wotlk
#completewith DKTrain2
.cast 50977 >> Cast Death Gate
.zoneskip Eastern Plaguelands
.xp <72,1
step << DK wotlk
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49940 >> Train your class spells
.xp <72,1
.target Amal'thazad
step << DK wotlk
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49904 >> Train your class spells
.xp <73,1
.target Amal'thazad
step << DK wotlk
#label DKTrain2
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49929 >> Train your class spells
.xp <74,1
.target Amal'thazad
step << Mage wotlk
#completewith MageTrain2
.zone Stormwind City >> Teleport to Stormwind
.xp <72,1
step << Mage wotlk
.goto Stormwind City,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42930 >> Train your class spells
.xp <72,1
.target Elsharin
.target Jennea Cannon
step << Mage wotlk
.goto Stormwind City,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 43019 >> Train your class spells
.xp <73,1
.target Elsharin
.target Jennea Cannon
step << Mage wotlk
#label MageTrain2
.goto Stormwind City,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42939 >> Train your class spells
.xp <74,1
.target Elsharin
.target Jennea Cannon
step
#completewith next
.hs >> Hearth to Wintergarde Keep
step
.goto Dragonblight,78.55,48.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r
.turnin 12467 >>Turn in Chasing Icestorm: Thel'zan's Phylactery
.accept 12472 >>Accept Finality
.target High Commander Halford Wyrmbane
step
.goto Dragonblight,79.15,47.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zelig|r
.turnin 12478 >>Turn in Frostmourne Cavern
.target Zelig the Visionary
step
#completewith next
.goto Dragonblight,81.9,50.7,20 >> Enter the Wintergarde Mausoleum
step
.goto Dragonblight,81.19,50.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yorik|r inside the Mausoleum
.turnin 12472 >>Turn in Finality
.accept 12473 >>Accept An End And A Beginning
.timer 115,Thel'zan Summon RP
.target Legion Commander Yorik
step
.goto Dragonblight,80.98,50.63
>>|cRXP_WARN_Wait out the RP|r
>>Kill |cRXP_ENEMY_Thel'zan the Duskbringer|r
>>|cRXP_ENEMY_Thel'zan the Duskbringer|r |cRXP_WARN_hits hard, so let the |cRXP_FRIENDLY_7th Legion|r tank him|r
.complete 12473,1 
.mob Thel'zan the Duskbringer
step
#completewith next
.goto Dragonblight,82.06,50.73,20 >> Exit the Wintergarde Mausoleum
step
.goto Dragonblight,78.58,48.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r
.turnin 12473 >>Turn in An End And A Beginning
.accept 12474 >>Accept To Fordragon Hold!
.target High Commander Halford Wyrmbane
step
#completewith DWard
.goto Dragonblight,77.01,49.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rodney|r
.fly Wyrmrest >> Fly to Wyrmrest Temple
.skill coldweatherflying,1,1
.skill riding,300,1
.target Rodney Wells
step
#completewith next
.goto Dragonblight,59.80,54.24,200 >> Travel to Wyrmrest Temple
step
#completewith DWard
.goto Dragonblight,59.80,54.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Demestrasz|r
>>|cRXP_FRIENDLY_Demestrasz|r |cRXP_WARN_is on the ground level of the Temple|r
.home >>Set your Hearthstone to Wyrmrest Temple
.target Demestrasz
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lauriel|r and |cRXP_FRIENDLY_Aurastrasza|r
>>|cRXP_FRIENDLY_Lauriel|r |cRXP_WARN_and |cRXP_FRIENDLY_Aurastrasza|r are on the ground level of the Temple|r
.turnin 12766 >>Turn in Speak with your Ambassador
.accept 12460 >>Accept Report to the Ruby Dragonshrine
.goto Dragonblight,60.00,55.09
.turnin 12146 >>Turn in Disturbing Implications
.accept 12148 >>Accept One of a Kind
.goto Dragonblight,60.02,55.20
.target Lauriel Trueblade
.target Aurastrasza
step
.goto Dragonblight,53.7,60.0,60,0
.goto Dragonblight,50.8,59.1,60,0
.goto Dragonblight,49.1,57.8,60,0
.goto Dragonblight,53.7,60.0
>>Kill |cRXP_ENEMY_Bonesunder|r. Loot him for his |cRXP_LOOT_Horn|r
>>|cRXP_WARN_Avoid his|r |T136105:0|t[Bone Crack] |cRXP_WARN_by moving away when he starts casting it|r
>>|cRXP_ENEMY_Bonesunder|r |cRXP_WARN_patrols slighty|r
.complete 12148,1 
.unitscan Bonesunder
step
#completewith next
.goto Dragonblight,52.21,50.04,60 >> Travel toward |cRXP_FRIENDLY_Ceristrasz|r
step
.goto Dragonblight,52.21,50.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ceristrasz|r
.turnin 12460 >>Turn in Report to the Ruby Dragonshrine
.accept 12416 >>Accept Heated Battle
.target Ceristrasz
step
.goto Dragonblight,50.34,52.20,-1
.goto Dragonblight,52.34,46.66,-1
>>Kill |cRXP_ENEMY_Frigid Ghoul Attackers|r, |cRXP_ENEMY_Frigid Geist Attackers|r and a |cRXP_ENEMY_Frigid Abomination Attacker|r
>>|cRXP_WARN_The mobs come in waves. They can spawn either south or north of the quest giver so pay attention to your chat|r
>>|cRXP_FRIENDLY_Captain Iskandar|r |cRXP_WARN_will announce where they are coming from. You can follow him around if you get stuck|r
.complete 12416,1 
.complete 12416,2 
.complete 12416,3 
.mob Frigid Ghoul Attacker
.mob Frigid Geist Attacker
.mob Frigid Abomination Attacker
.target Captain Iskandar
step
.goto Dragonblight,52.21,50.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ceristrasz|r
.turnin 12416 >>Turn in Heated Battle
.accept 12417 >>Accept Return to the Earth
.target Ceristrasz
step
.goto Dragonblight,48.7,48.9,60,0
.goto Dragonblight,47.5,47.6,60,0
.goto Dragonblight,49.2,45.0,80,0
.goto Dragonblight,45.5,47.2,80,0
.goto Dragonblight,46.1,52.6,80,0
.goto Dragonblight,49.3,49.7
>>Loot |T133944:0|t[|cRXP_LOOT_Ruby Acorns|r] on the ground. |cRXP_WARN_They look like small red crystals|r
.use 37727 >>|cRXP_WARN_Use the|r |T133944:0|t[|cRXP_LOOT_Ruby Acorns|r] |cRXP_WARN_on the corpses of|r |cRXP_FRIENDLY_Ruby Keepers|r
.collect 37727,6,12417,1,-1 
.complete 12417,1 
.target Ruby Keeper
step
.goto Dragonblight,52.21,50.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ceristrasz|r
.turnin 12417 >>Turn in Return to the Earth
.accept 12418 >>Accept Through Fields of Flame
.target Ceristrasz
step
#completewith next
.goto Dragonblight,48.2,50.2,0
.goto Dragonblight,48.4,48.2,0
.goto Dragonblight,47.0,47.5,0
.goto Dragonblight,46.6,49.9,0
>>Kill |cRXP_ENEMY_Frigid Necromancers|r
.complete 12418,1 
.mob Frigid Necromancer
step
.goto Dragonblight,47.89,49.64,30,0
.goto Dragonblight,47.64,48.97
>>|cRXP_WARN_Travel into the Giant Tree Trunk|r
>>Kill |cRXP_ENEMY_Dahlia Suntouch|r. Loot her for her |T133302:0|t[|cRXP_LOOT_Ruby Brooch|r]
>>|cRXP_WARN_Use the |T133302:0|t[|cRXP_LOOT_Ruby Brooch|r] to start the quest|r
.complete 12418,2 
.collect 37833,1,12419
.accept 12419 >>Accept The Fate of the Ruby Dragonshrine
.use 37833
.mob Dahlia Suntouch
step
.goto Dragonblight,48.2,50.2,60,0
.goto Dragonblight,48.4,48.2,60,0
.goto Dragonblight,47.0,47.5,60,0
.goto Dragonblight,46.6,49.9
>>Kill |cRXP_ENEMY_Frigid Necromancers|r
.complete 12418,1 
.mob Frigid Necromancer
step
.goto Dragonblight,52.21,50.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ceristrasz|r
.turnin 12418 >>Turn in Through Fields of Flame
.accept 12768 >>Accept The Steward of Wyrmrest Temple
.target Ceristrasz
step
#completewith next
.goto Dragonblight,37.1,31.8,45 >>Travel to the Maw of Neltharion
step
.goto Dragonblight,35.21,30.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Serinar|r
.turnin 12447 >>Turn in The Obsidian Dragonshrine
.accept 12261 >>Accept No Place to Run
.accept 12262 >>Accept No One to Save You
.target Serinar
step
#completewith next
.goto Dragonblight,37.1,31.8,45 >> Exit the Maw of Neltharion
step
#completewith next
.goto Dragonblight,39.13,31.87,0
>>Kill |cRXP_ENEMY_Burning Depths Necrolytes|r and |cRXP_ENEMY_Smoldering Skeletons|r
.complete 12262,1 
.complete 12262,2 
.mob Burning Depths Necrolyte
.mob Smoldering Skeleton
step
#label DWard
.goto Dragonblight,41.4,31.9
>>|cRXP_WARN_Use the|r |T135824:0|t[Destructive Wards]. |cRXP_WARN_Defend it against the incoming waves|r
.complete 12261,1 
.cast 48711
.timer 80,Destructive Ward RP
.use 37445
step
.goto Dragonblight,39.52,31.21,70,0
.goto Dragonblight,37.87,33.74,70,0
.goto Dragonblight,40.00,32.18,70,0
.goto Dragonblight,37.16,31.75
>>Kill |cRXP_ENEMY_Burning Depths Necrolytes|r and |cRXP_ENEMY_Smoldering Skeletons|r
.complete 12262,1 
.complete 12262,2 
.mob Burning Depths Necrolyte
.mob Smoldering Skeleton
step
#completewith next
.goto Dragonblight,37.1,31.8,45 >> Travel toward |cRXP_FRIENDLY_Serinar|r in the Maw of Neltharion
step
.goto Dragonblight,35.21,30.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Serinar|r
.turnin 12261 >>Turn in No Place to Run
.turnin 12262 >>Turn in No One to Save You
.accept 12263 >>Accept The Best of Intentions
.target Serinar
step << !Gnome/!Female
#completewith next
+|cRXP_WARN_Jump up the|r "|cRXP_WARN_exit route|r" |cRXP_WARN_on the side just as you start heading up the cave. This will save you 45 seconds each time you successfuly jump up|r
.link https://www.youtube.com/watch?v=xYKP3ECePVw >> |cRXP_WARN_CLICK HERE|r
step
.goto Dragonblight,34.9,32.0,30,0
.goto Dragonblight,34.2,31.4,30,0
.goto Dragonblight,32.2,31.4,30,0
.goto Dragonblight,31.68,30.96
>>|cRXP_WARN_Travel deep into the Maw of Neltharion and observe |cRXP_ENEMY_Rothin the Decaying|r from close range. Cross the lava instead of going through the center to avoid fighting mobs|r
.complete 12263,1 
step
.goto Dragonblight,35.21,30.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Serinar|r
.turnin 12263 >>Turn in The Best of Intentions
.accept 12264 >>Accept Culling the Damned
.accept 12265 >>Accept Defiling the Defilers
.target Serinar
step << !Gnome/!Female
#completewith next
+|cRXP_WARN_Jump up the|r "|cRXP_WARN_exit route|r" |cRXP_WARN_on the side just as you start heading up the cave. This will save you 45 seconds each time you successfuly jump up|r
.link https://www.youtube.com/watch?v=xYKP3ECePVw >> |cRXP_WARN_CLICK HERE|r
step
.goto Dragonblight,32.8,30.5,50,0
.goto Dragonblight,33.7,28.7,50,0
.goto Dragonblight,31.9,28.1,50,0
.goto Dragonblight,30.7,29.0,50,0
.goto Dragonblight,31.8,30.6,50,0
.goto Dragonblight,34.1,26.2
>>Kill |cRXP_ENEMY_Burning Depths Necromancers|r, |cRXP_ENEMY_Smoldering Constructs|r and |cRXP_ENEMY_Smoldering Geists|r
>>Click the |cRXP_PICK_Necromantic Runes|r on the ground
.complete 12264,1 
.complete 12264,2 
.complete 12264,3 
.complete 12265,1 
.mob Burning Depths Necromancer
.mob Smoldering Construct
.mob Smoldering Geist
step
.goto Dragonblight,35.21,30.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Serinar|r
.turnin 12264 >>Turn in Culling the Damned
.turnin 12265 >>Turn in Defiling the Defilers
.accept 12267 >>Accept Neltharion's Flame
.target Serinar
step << !Gnome/!Female
#completewith next
+|cRXP_WARN_Jump up the|r "|cRXP_WARN_exit route|r" |cRXP_WARN_on the side just as you start heading up the cave. This will save you 45 seconds each time you successfuly jump up|r
.link https://www.youtube.com/watch?v=xYKP3ECePVw >> |cRXP_WARN_CLICK HERE|r
step
.goto Dragonblight,34.9,32.0,30,0
.goto Dragonblight,34.2,31.4,30,0
.goto Dragonblight,32.2,31.4,30,0
>>|cRXP_WARN_Use|r |T134807:0|t[Neltharion's Flame] |cRXP_WARN_near|r |cRXP_ENEMY_Rothin the Decaying|r
>>Kill |cRXP_ENEMY_Rothin the Decaying|r
.complete 12267,1 
.goto Dragonblight,31.9,31.3
.complete 12267,2 
.goto Dragonblight,31.43,31.01
.use 37539
.mob Rothin the Decaying
step
.goto Dragonblight,35.21,30.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Serinar|r
.turnin 12267 >>Turn in Neltharion's Flame
.accept 12266 >>Accept Tales of Destruction
.target Serinar
step
#completewith next
.goto Dragonblight,35.13,31.65
.goto Dragonblight,42.26,29.65,50 >> |cRXP_WARN_Jump onto the hand's biggest finger. Log out, then back in|r
.link https://www.youtube.com/watch?v=0r54ZZ1o0W8 >> |cRXP_WARN_CLICK HERE|r
step
.goto Dragonblight,39.51,25.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Derek|r
.fp Fordragon Hold >>Get the Fordragon Hold Flight Path
.target Derek Rammel
step
.goto Dragonblight,37.81,23.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bolvar|r
.turnin 12474 >>Turn in To Fordragon Hold!
.accept 12495 >>Accept Audience With The Dragon Queen
.target Highlord Bolvar Fordragon
step
#completewith next
.hs >>Hearth to Wyrmrest Temple
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Aurastrasza|r and |cRXP_FRIENDLY_Tariolstrasz|r
>>|cRXP_FRIENDLY_Aurastrasza|r |cRXP_WARN_and |cRXP_FRIENDLY_Tariolstrasz|r are on the ground level of the Temple|r
.turnin 12148 >>Turn in One of a Kind
.accept 12149 >>Accept Mighty Magnataur
.goto Dragonblight,60.02,55.20
.turnin 12768 >>Turn in The Steward of Wyrmrest Temple
.accept 12123 >>Accept Informing the Queen
.goto Dragonblight,57.91,54.17
.target Aurastrasza
.target Tariolstrasz
step
#completewith next
.goto Dragonblight,57.91,54.17
.gossipoption 93560 >>Talk to |cRXP_FRIENDLY_Tariolstrasz|r to fly to the top of Wyrmrest Temple
.timer 19,Flight to top of Wyrmrest Temple
.skill coldweatherflying,1,1
.target Tariolstrasz
step
>>|cRXP_WARN_Atop Wyrmrest Temple|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nalice|r, |cRXP_FRIENDLY_Chromie|r and |cRXP_FRIENDLY_Alexstrasza|r
.turnin 12266 >>Turn in Tales of Destruction
.goto Dragonblight,60.06,54.18
.turnin 12470 >>Turn in Mystery of the Infinite

.goto Dragonblight,59.99,54.50
.turnin 12495 >>Turn in Audience With The Dragon Queen
.accept 12497 >>Accept Galakrond and the Scourge
.turnin 12123 >>Turn in Informing the Queen
.accept 12435 >>Accept Report to Lord Devrestrasz
.goto Dragonblight,59.83,54.66
.turnin 12419 >>Turn in The Fate of the Ruby Dragonshrine
.goto Dragonblight,59.79,54.70
.target Nalice
.target Chromie
.target Alexstrasza the Life-Binder
step
.goto Dragonblight,59.51,53.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torastrasza|r atop Wyrmrest Temple
.turnin 12497 >>Turn in Galakrond and the Scourge
.accept 12498 >>Accept On Ruby Wings
.target Torastrasza
step
#completewith Bloodfeast
+|cRXP_WARN_Use the|r |T134124:0|t[Ruby Beacon of the Dragon Queen] |cRXP_WARN_from this point on to travel through the middle of Dragonblight|r
.use 38302
.skill coldweatherflying,1,1
step
#sticky
#label lashers
.goto Dragonblight,64.87,73.49,0,0
>>Kill |cRXP_ENEMY_Emerald Lashers|r. Loot them for their |cRXP_LOOT_Seeds|r
.complete 12458,1 
.mob Emerald Lasher
step
.goto Dragonblight,63.7,76.0,60,0
.goto Dragonblight,62.5,74.5,60,0
.goto Dragonblight,62.8,72.1,60,0
.goto Dragonblight,64.9,72.3,60,0
.goto Dragonblight,64.7,76.4,60,0
.goto Dragonblight,62.8,72.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nishera|r
>>|cRXP_FRIENDLY_Nishera|r |cRXP_WARN_patrols the road|r
.accept 12454 >>Accept Cycle of Life
.unitscan Nishera the Garden Keeper
step
.goto Dragonblight,64.4,71.5,70,0
.goto Dragonblight,65.4,75.4,70,0
.goto Dragonblight,62.2,75.4
>>Kill |cRXP_ENEMY_Emerald Skytalons|r
.complete 12454,1 
.mob Emerald Skytalon
step
.goto Dragonblight,63.7,76.0,60,0
.goto Dragonblight,62.5,74.5,60,0
.goto Dragonblight,62.8,72.1,60,0
.goto Dragonblight,64.9,72.3,60,0
.goto Dragonblight,64.7,76.4,60,0
.goto Dragonblight,62.8,72.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nishera|r
>>|cRXP_FRIENDLY_Nishera|r |cRXP_WARN_patrols the road|r
.turnin 12454 >>Turn in Cycle of Life
.accept 12456 >>Accept The Plume of Alystros
.unitscan Nishera the Garden Keeper
step
.goto Dragonblight,64.7,77.0
.use 37881 >>|cRXP_WARN_Use the|r |T136087:0|t[Skytalon Molts] |cRXP_WARN_to bring down |cRXP_ENEMY_Alystros the Verdant Keeper|r perching from the hill in front of you|r
>>Kill |cRXP_ENEMY_Alystros the Verdant Keeper|r. Loot it for the |cRXP_LOOT_Plume|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for it if needed. Skip this step if you're unable to find a group or solo it|r
.complete 12456,1 
.mob Alystros the Verdant Keeper
step
.goto Dragonblight,63.7,76.0,60,0
.goto Dragonblight,62.5,74.5,60,0
.goto Dragonblight,62.8,72.1,60,0
.goto Dragonblight,64.9,72.3,60,0
.goto Dragonblight,64.7,76.4,60,0
.goto Dragonblight,62.8,72.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nishera|r
>>|cRXP_FRIENDLY_Nishera|r |cRXP_WARN_patrols the road|r
.turnin 12456 >>Turn in The Plume of Alystros
.unitscan Nishera the Garden Keeper
.isQuestComplete 12456
step
.abandon 12456 >> Abandon The Plume of Alystros
step
#requires lashers
#completewith next
.groundgoto Dragonblight,66.42,73.52,30,0
.groundgoto Dragonblight,68.40,67.76,30,0
.goto Dragonblight,65.92,70.48,55 >> Exit the Emerald Dragonshrine
step
#label Bloodfeast
.goto Dragonblight,65.92,70.48,20,0
.goto Dragonblight,67.40,70.74,20,0
.goto Dragonblight,65.92,70.48
>>Kill |cRXP_ENEMY_Bloodfeast|r
.complete 12149,2 
.unitscan Bloodfeast
step
#completewith Abbendis
.vehicle >> |cRXP_WARN_Use the|r |T134124:0|t[Ruby Beacon of the Dragon Queen] |cRXP_WARN_to fly directly to Abendis's Chapel and avoid fighting the|r |cRXP_ENEMY_Onslaught|r
.use 38302
.skill coldweatherflying,1,1
step
#completewith next
.goto Dragonblight,70.90,75.98,35 >> Travel into the Chapel in New Hearthglen
.skill coldweatherflying,<1,1
step
#label Abbendis
.goto Dragonblight,71.08,77.84
>>Kill |cRXP_ENEMY_High General Abbendis|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for her if needed. Skip this step if you're unable to find a group or solo her|r
.complete 12464,1 
.mob High General Abbendis
step
#completewith next
.goto Dragonblight,66.0,51.5,80 >> Travel to The Mirror of Dawn in central Dragonblight
.skill coldweatherflying,<1,1
step
.goto Dragonblight,66.0,51.5,70,0
.goto Dragonblight,67.9,50.1,70,0
.goto Dragonblight,69.2,51.4
>>Kill |cRXP_ENEMY_Iceshatter|r
>>|cRXP_WARN_Avoid his|r |T135851:0|t[Pulsing Shards] |cRXP_WARN_by moving away when he starts casting it|r
>>|cRXP_ENEMY_Iceshatter|r |cRXP_WARN_patrols the north side of the frozen lake|r
.complete 12149,1 
.unitscan Iceshatter
.skill coldweatherflying,<1,1
step
#completewith next
.goto Dragonblight,68.85,72.52,25,0
.goto Dragonblight,69.09,71.68,15,0
.goto Dragonblight,68.70,71.34
.cast 50426 >> Exit New Hearthglen via the gap in the walls
.vehicle >>|cRXP_WARN_Move directly to where the waypoint is and then use the|r |T134124:0|t[Ruby Beacon of the Dragon Queen] |cRXP_WARN_to mount up|r
.use 38302
.skill coldweatherflying,1,1
step
.goto Dragonblight,66.0,51.5,70,0
.goto Dragonblight,67.9,50.1,70,0
.goto Dragonblight,69.2,51.4
>>|cRXP_WARN_Dismount the |cRXP_FRIENDLY_Wyrmrest Vanquisher|r once you're at|r |cRXP_ENEMY_Iceshatter|r
>>Kill |cRXP_ENEMY_Iceshatter|r
>>|cRXP_WARN_Avoid his|r |T135851:0|t[Pulsing Shards] |cRXP_WARN_by moving away when he starts casting it|r
>>|cRXP_ENEMY_Iceshatter|r |cRXP_WARN_patrols the north side of the frozen lake|r
.complete 12149,1 
.unitscan Iceshatter
.skill coldweatherflying,1,1
step
#completewith Shredder
+|cRXP_WARN_From this point forward you can continuously use the|r |T134124:0|t[Ruby Beacon of the Dragon Queen] |cRXP_WARN_to fly through the middle of Dragonblight|r
.use 38302
.skill coldweatherflying,1,1
step << skip
.goto Dragonblight,71.1,39.5
>>Ride to the Bronze Dragonshrine. Use the Hourglass of Eternity in your bags, and then protect it against the incoming waves. The objective should complete after 2m 55s
>>This quest functions differently to the previous one for some reason, so you cannot cheese/skip it like before
.complete 13343,1 
.use 44450
step
.goto Dragonblight,68.3,43.1,70,0
.goto Dragonblight,67.5,39.5,70,0
.goto Dragonblight,68.6,36.4
>>Kill |cRXP_ENEMY_Drakegore|r
>>|cRXP_ENEMY_Drakegore|r |cRXP_WARN_patrols slighty|r
.complete 12149,3 
.unitscan Drakegore
step
#completewith next
.hs >>Hearth to Wyrmrest Temple
.cooldown item,6948,>2
step << skip
>>Head back to the top of the temple
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Chromie|r
.turnin 13343 >>Turn in Mystery of the Infinite, Redux
.goto Dragonblight,59.99,54.50
.target Chromie
step
.goto Dragonblight,60.02,55.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Aurastrasza|r
>>|cRXP_FRIENDLY_Aurastrasza|r |cRXP_WARN_is on the ground level of the Temple|r
.turnin 12149 >>Turn in Mighty Magnataur
.accept 12150 >>Accept Reclusive Runemaster
.target Aurastrasza
step
.goto Dragonblight,73.27,50.55
>>Attack |cRXP_ENEMY_Dregmar Runebrand|r. |cRXP_WARN_He will submit at 20% health|r
>>|cRXP_WARN_MOVE AWAY from|r |T135826:0|t[Explosive Runes] |cRXP_WARN_he places beneath you. They detonate after 4 seconds and deal significant fire damage|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r
.complete 12150,1 
.mob Dregmar Runebrand
step
#completewith next
.goto Dragonblight,64.47,26.36,100 >> Travel to the 7th Legion Front
step
.goto Dragonblight,64.47,26.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Duane|r
.turnin 12143 >>Turn in Canyon Chase
.target Duane
step << skip
#sticky
.goto Dragonblight,58.02,39.16,0,0
>>Look for a |cRXP_ENEMY_Frost Wyrm|r flying around the Dragon Wastes and then use the |T134339:0|t[Seeds of Nature's Wrath] on it and kill it. Use the |T134124:0|t[Ruby Beacon of the Dragon Queen] to summon a flying mount if you're having trouble pulling them.
.complete 12459,1 
.use 37887
.use 38302
.isOnQuest 12459
.unitscan Reanimated Frost Wyrm
.mob Weakened Reanimated Frost Wyrm
step << skip
#questguide
.goto Dragonblight,48.44,24.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Goblin|r corpse on the ground
.accept 12469 >>Accept Return to Sender
.target Nozzlerust Supply Runner
step
#completewith NozzleP
.goto Dragonblight,54.46,23.60,100 >> Travel to Nozzlerust Post
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Narf|r, |cRXP_FRIENDLY_Zivlix|r and |cRXP_FRIENDLY_Xink|r
>>|cRXP_FRIENDLY_Narf|r |cRXP_WARN_patrols slighty|r
.accept 12043 >>Accept Nozzlerust Defense
.goto Dragonblight,54.46,23.60
.accept 12045 >>Accept Shaved Ice
.goto Dragonblight,54.70,23.25
.turnin 12469 >>Turn in Return to Sender
.accept 12044 >>Accept Stocking Up
.goto Dragonblight,55.02,23.42
.isOnQuest 12469
.target Narf
.target Zivlix
.target Xink
step
#label NozzleP
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Narf|r, |cRXP_FRIENDLY_Zivlix|r and |cRXP_FRIENDLY_Xink|r
>>|cRXP_FRIENDLY_Narf|r |cRXP_WARN_patrols slighty|r
.accept 12043 >>Accept Nozzlerust Defense
.goto Dragonblight,54.46,23.60
.accept 12045 >>Accept Shaved Ice
.goto Dragonblight,54.70,23.25
.accept 12044 >>Accept Stocking Up
.goto Dragonblight,55.02,23.42
.target Narf
.target Zivlix
.target Xink
step
.goto Dragonblight,53.6,20.3,70,0
.goto Dragonblight,57.3,16.8,70,0
.goto Dragonblight,55.0,18.8,70,0
.goto Dragonblight,47.2,18.6
>>Kill |cRXP_ENEMY_Crystalline Ice Elementals|r. Loot them for their |cRXP_LOOT_Shard Clusters|r
.complete 12045,1 
.mob Crystalline Ice Elemental
step
#completewith next
.goto Dragonblight,54.46,31.18,100 >> Travel to The Dragon Wastes
step
.goto Dragonblight,54.46,31.18
>>|cRXP_WARN_Use the|r |T134124:0|t[Ruby Beacon of the Dragon Queen] |cRXP_WARN_and mount the|r |cRXP_FRIENDLY_Wyrmrest Vanquisher|r
>>|cRXP_WARN_Cast|r |T135808:0|t[Engulfing Fireball] (2) |cRXP_WARN_to kill|r |cRXP_ENEMY_Thiassi the Lightning Bringer|r
>>Kill |cRXP_ENEMY_Grand Necrolord Antiok|r after you get dismounted. Loot the |cRXP_LOOT_Scythe of Antiok|r he drops on the ground
.complete 12498,2 
.use 38302
.mob Thiassi the Lightning Bringer
.mob Grand Necrolord Antiok
step
.goto Dragonblight,55.78,34.34
>>|cRXP_WARN_Use the|r |T134124:0|t[Ruby Beacon of the Dragon Queen] |cRXP_WARN_to mount the |cRXP_FRIENDLY_Wyrmrest Vanquisher|r again|r
>>|cRXP_WARN_Cast|r |T135808:0|t[Engulfing Fireball] (2) |cRXP_WARN_to kill|r |cRXP_ENEMY_Wastes Scavengers|r
>>|cRXP_WARN_Cast|r |T132278:0|t[Devour Ghoul] (3) |cRXP_WARN_when in melee range of a|r |cRXP_ENEMY_Wastes Scavenger|r |cRXP_WARN_to recover Health and Mana|r
.complete 12498,1 
.use 38302
.mob Wastes Scavenger
step
.goto Dragonblight,56.22,27.17,60,0
.goto Dragonblight,59.04,31.16,60,0
.goto Dragonblight,59.26,31.84,60,0
.goto Dragonblight,56.22,27.17,60,0
.goto Dragonblight,59.04,31.16,60,0
.goto Dragonblight,59.26,31.84
>>|cRXP_WARN_Dismount the|r |cRXP_FRIENDLY_Wyrmrest Vanquisher|r
>>Kill a |cRXP_ENEMY_Wastes Taskmaster|r and |cRXP_ENEMY_Wastes Diggers|r
>>Loot the |cRXP_LOOT_Composite Ore|r on the ground
.complete 12043,1 
.complete 12043,2 
.complete 12044,1 
.mob Wastes Taskmaster
.mob Wastes Digger
step
#completewith next
.goto Dragonblight,55.0,23.9,100 >> Travel to Nozzlerust Post
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Narf|r, |cRXP_FRIENDLY_Zivlix|r and |cRXP_FRIENDLY_Xink|r
>>|cRXP_FRIENDLY_Narf|r |cRXP_WARN_patrols slighty|r
.turnin 12043 >>Turn in Nozzlerust Defense
.goto Dragonblight,55.0,23.9,20,0
.goto Dragonblight,54.50,23.70
.turnin 12045 >>Turn in Shaved Ice
.accept 12046 >>Accept Soft Packaging
.goto Dragonblight,54.70,23.25
.turnin 12044 >>Turn in Stocking Up
.goto Dragonblight,55.02,23.42
.target Narf
.target Zivlix
.target Xink
step
.goto Dragonblight,53.9,26.2,70,0
.goto Dragonblight,51.1,26.3,70,0
.goto Dragonblight,51.1,24.0,70,0
.goto Dragonblight,53.9,26.2
>>Kill |cRXP_ENEMY_Jormungar Tunnelers|r and |cRXP_ENEMY_Dragonbone Condors|r. Loot them for their |cRXP_LOOT_Hides|r
.complete 12046,1 
.mob Dragonbone Condor
.mob Jormungar Tunneler
step
#completewith next
.goto Dragonblight,54.70,23.25,100 >> Travel to Nozzlerust Post
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zivlix|r and |cRXP_FRIENDLY_Xink|r
.turnin 12046 >>Turn in Soft Packaging
.accept 12047 >>Accept Something That Doesn't Melt
.goto Dragonblight,54.70,23.25
.accept 12049 >>Accept Hard to Swallow
.goto Dragonblight,55.02,23.42
.target Zivlix
.target Xink
step
#sticky
#label bonechunks
.goto Dragonblight,57.3,24.1,70,0
.goto Dragonblight,59.6,26.0,70,0
.goto Dragonblight,60.7,28.1,70,0
.goto Dragonblight,62.9,29.3,70,0
.goto Dragonblight,53.0,25.7,70,0
.goto Dragonblight,51.3,26.5,70,0
.goto Dragonblight,57.3,24.1,70,0
.goto Dragonblight,59.6,26.0,70,0
.goto Dragonblight,60.7,28.1
>>Loot the |cRXP_LOOT_Splintered Bone Chunks|r on the ground
>>|cRXP_WARN_They are found around the massive dragon bones in The Dragon Wastes|r
.complete 12047,1 
step
.goto Dragonblight,58.4,23.2
>>|cRXP_WARN_Attack a |cRXP_ENEMY_Hulking Jormungar|r to 80% health to weaken it. A yellow message will pop up saying "The Hulking Jormungar falters..."|r
>>|cRXP_WARN_Use the|r |T133715:0|t[Potent Explosive Charges] |cRXP_WARN_on the |cRXP_ENEMY_Hulking Jormungar|r to blow it up once it's weakened|r
>>Loot the |cRXP_LOOT_Seared Jormungar Meat|r on the ground after
.use 36732
.complete 12049,1 
.mob Hulking Jormungar
step
#requires bonechunks
#completewith next
.goto Dragonblight,54.70,23.25,100 >> Travel to Nozzlerust Post
step
#label Shredder
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zivlix|r, |cRXP_FRIENDLY_Xink|r, and |cRXP_FRIENDLY_Narf|r
>>|cRXP_FRIENDLY_Narf|r |cRXP_WARN_patrols slighty|r
.turnin 12047 >>Turn in Something That Doesn't Melt
.goto Dragonblight,54.70,23.25
.turnin 12049 >>Turn in Hard to Swallow
.accept 12050 >>Accept Lumber Hack
.goto Dragonblight,55.02,23.42
.accept 12052 >>Accept Harp on This!
.goto Dragonblight,55.0,23.9,20,0
.goto Dragonblight,54.50,23.70
.target Narf
.target Zivlix
.target Xink
step
#label harpies
>>|cRXP_WARN_Use|r |T133015:0|t[Xink's Shredder Control Device] |cRXP_WARN_to take control of|r |cRXP_FRIENDLY_Xink's Shredder|r
>>|cRXP_WARN_Cast|r |T132407:0|t[Twisting Blade] (1) |cRXP_WARN_and|r |T134427:0|t[Launch Saw Blades] (2) |cRXP_WARN_to kill |cRXP_ENEMY_Coldwind Harpies|r and the|r |cRXP_ENEMY_Mistress of the Coldwind|r
>>|cRXP_WARN_Cast|r |T136222:0|t[Hustle] (3) |cRXP_WARN_to move faster|r
>>|cRXP_WARN_Cast|r |T135769:0|t[Emergency Repair Kit] (4) |cRXP_WARN_to heal|r |cRXP_FRIENDLY_Xink's Shredder|r
>>|cRXP_WARN_Cast|r |T135437:0|t[Gather Lumber] (6) |cRXP_WARN_on |cRXP_PICK_Coldwind Trees|r to harvest|r |cRXP_LOOT_Coldwind Lumber|r
>>|cRXP_WARN_You may also kill |cRXP_ENEMY_Coldwind Harpies|r while not inside|r |cRXP_FRIENDLY_Xink's Shredder|r
.complete 12052,1 
.goto Dragonblight,45.8,12.5,70,0
.goto Dragonblight,44.6,7.8,70,0
.goto Dragonblight,46.6,10.5
.complete 12052,2 
.goto Dragonblight,47.3,18.6,70,0
.goto Dragonblight,52.8,19.1
.complete 12050,1 
.goto Dragonblight,47.3,18.6,70,0
.goto Dragonblight,52.8,19.1
.use 36734
.use 38302
.unitscan Mistress of the Coldwind
.mob Coldwind Waste Huntress
.mob Coldwind Witch
step
#completewith StiffN
+|cRXP_WARN_From this point forward you can continuously use the|r |T134124:0|t[Ruby Beacon of the Dragon Queen] |cRXP_WARN_to fly through the middle of Dragonblight|r
.use 38302
.skill coldweatherflying,1,1
step
#requires harpies
#completewith next
.goto Dragonblight,55.02,23.42,100 >> Travel to Nozzlerust Post
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xink|r and |cRXP_FRIENDLY_Narf|r
>>|cRXP_FRIENDLY_Narf|r |cRXP_WARN_patrols slighty|r
.turnin 12050 >>Turn in Lumber Hack
.goto Dragonblight,55.02,23.42
.turnin 12052 >>Turn in Harp on This!
.accept 12112 >>Accept Stiff Negotiations
.goto Dragonblight,55.0,23.9,20,0
.goto Dragonblight,54.50,23.70
.target Narf
.target Xink
step
#completewith next
.goto Dragonblight,59.40,18.19,100 >> Travel to The Crystal Vice
>>|cRXP_WARN_Go down through the canyon|r
step
#label StiffN
.goto Dragonblight,59.40,18.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zort|r
.turnin 12112 >>Turn in Stiff Negotiations
.accept 12075 >>Accept Slim Pickings
.target Zort
step
#completewith next
.goto Dragonblight,59.8,15.5,60,0
.goto Dragonblight,57.3,12.4,60,0
.goto Dragonblight,56.13,11.90,60 >> Enter the Ice Heart Cavern
step
.goto Dragonblight,56.13,11.90
>>Loot the |cRXP_FRIENDLY_Ravaged Crystalline Ice Giant|r for the |cRXP_LOOT_Sample of Rockflesh|r
.complete 12075,1 
.target Ravaged Crystalline Ice Giant
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zort|r
.goto Dragonblight,59.40,18.19
.turnin 12075 >>Turn in Slim Pickings
.accept 12076 >>Accept Messy Business
.target Zort
step
.goto Dragonblight,58.97,17.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ko'char|r
.accept 12079 >>Accept Stomping Grounds
.target Ko'char the Unbreakable
step
.goto Dragonblight,60.24,16.51
>>|cRXP_WARN_Agro an |cRXP_ENEMY_Ice Heart Jormungar|r. Tank them until you get affected by their|r |T136007:0|t[Corrosive Spit] |cRXP_WARN_debuff|r
>>|cRXP_WARN_Once you have the|r |T136007:0|t[Corrosive Spit] |cRXP_WARN_debuff, use|r |T134436:0|t[Zort's Scraper] |cRXP_WARN_to collect it. Do this twice|r
.complete 12076,1 
.use 36775
.mob Ice Heart Jormungar Spawn
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zort|r, |cRXP_FRIENDLY_Ko'char|r, then |cRXP_FRIENDLY_Zort|r again
.turnin 12076 >>Turn in Messy Business
.accept 12077 >>Accept Apply This Twice A Day
.goto Dragonblight,59.40,18.19
.turnin 12077 >>Turn in Apply This Twice A Day
.accept 12080 >>Accept Really Big Worm
.goto Dragonblight,58.97,17.82
.accept 12078 >>Accept Worm Wrangler
.goto Dragonblight,59.40,18.19
.target Zort
.target Ko'char the Unbreakable
step
#completewith next
.goto Dragonblight,59.8,15.5,60,0
.goto Dragonblight,57.18,12.17,100 >> Enter the Ice Heart Cavern
step
#completewith next
.goto Dragonblight,53.8,11.4,60,0
.goto Dragonblight,52.7,17.3,60 >> Travel toward |cRXP_ENEMY_Rattlebore|r at the end of the Cavern
step
#sticky
#label JormungarCave
.goto Crystalsong Forest,31.97,75.86,0,0
>>Kill |cRXP_ENEMY_Ice Heart Jormungar Feeders|r
>>|cRXP_WARN_Use the|r |T132762:0|t[Sturdy Crates] |cRXP_WARN_on |cRXP_ENEMY_Ice Heart Jormungar Spawns|r to capture them.|r Loot the |cRXP_LOOT_Captured Jormungar Spawn|r on the ground after
.complete 12079,1 
.complete 12078,1 
.use 36771
.mob Ice Heart Jormungar Feeder
.mob Ice Heart Jormungar Spawn
step
.goto Dragonblight,50.68,17.79
>>|cRXP_WARN_Use|r |T134873:0|t[Zort's Protective Elixir] |cRXP_WARN_to protect yourself from|r |T136007:0|t[Corrosive Spit]
>>Kill |cRXP_ENEMY_Rattlebore|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r
.complete 12080,1 
.mob Rattlebore
.use 36770
step
#requires JormungarCave
#completewith next
.goto Dragonblight,49.86,16.61,-1
.goto Dragonblight,46.39,21.56,-1
>>|cRXP_WARN_Jump onto one of the |cRXP_PICK_Large Blue Rocks|r. Log out, then back in|r
.vehicle >>|cRXP_WARN_Use the|r |T134124:0|t[Ruby Beacon of the Dragon Queen] |cRXP_WARN_to mount the |cRXP_FRIENDLY_Wyrmrest Vanquisher|r again to fly to |cRXP_FRIENDLY_Zort|r and|r |cRXP_FRIENDLY_Ko'char|r
.link https://www.youtube.com/watch?v=oRQQMuodz4A >> |cRXP_WARN_CLICK HERE|r
.use 38302
step
#requires JormungarCave
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zort|r and |cRXP_FRIENDLY_Ko'char|r
.turnin 12078 >>Turn in Worm Wrangler
.goto Dragonblight,59.40,18.19
.turnin 12079 >>Turn in Stomping Grounds
.turnin -12080 >>Turn in Really Big Worm
.goto Dragonblight,58.97,17.82
.target Zort
.target Ko'char the Unbreakable
step
#sticky
#label RBWorm
.abandon 12080 >>Abandon Really Big Worm
step << Druid
#completewith DruidTrain3
.cast 18960 >> Cast Teleport: Moonglade
.zoneskip Moonglade
.xp <74,1
step << Druid
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 53307 >> Train your class spells
.xp <74,1
.target Loganaar
step << Druid
#label DruidTrain3
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 48440 >> Train your class spells
.xp <75,1
.target Loganaar
step << DK
#completewith DKTrain3
.cast 50977 >> Cast Death Gate
.zoneskip Eastern Plaguelands
.xp <73,1
step << DK
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49904 >> Train your class spells
.xp <73,1
.target Amal'thazad
step << DK
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49929 >> Train your class spells
.xp <74,1
.target Amal'thazad
step << DK
#label DKTrain3
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49923 >> Train your class spells
.xp <75,1
.target Amal'thazad
step << Druid/DK
#completewith Runemaster
.hs >> Hearth to Wyrmrest Temple
.cooldown item,6948,>2
step
#completewith Runemaster
.goto Dragonblight,60.02,55.20,100 >> Travel to Wyrmrest Temple
step
#completewith wings
+|cRXP_WARN_From this point forward you can use the|r |T134124:0|t[Ruby Beacon of the Dragon Queen] |cRXP_WARN_in your bags to summon a flying mount to travel through the middle of Dragonblight|r
.use 38302
.skill coldweatherflying,1,1
step
#label Runemaster
.goto Dragonblight,60.02,55.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Aurastrasza|r
>>|cRXP_FRIENDLY_Aurastrasza|r |cRXP_WARN_is on the ground level of the Temple|r
.turnin 12150 >>Turn in Reclusive Runemaster
.accept 12151 >>Accept Wanton Warlord
.target Aurastrasza
step
#completewith next
.goto Dragonblight,57.2,76.0,100 >> Travel south of the Azure Dragonshrine
step
#requires RBWorm
.goto Dragonblight,57.2,76.0
>>|cRXP_WARN_Use the|r |T134229:0|t[Emblazoned Battle Horn] |cRXP_WARN_to summon|r |cRXP_ENEMY_Grom'thar the Thunderbringer|r
>>Kill |cRXP_ENEMY_Grom'thar the Thunderbringer|r. Loot him for his |cRXP_LOOT_Head|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r
.complete 12151,1 
.use 36864
.mob Grom'thar the Thunderbringer
step
#completewith next
.goto Dragonblight,60.02,55.20,100 >> Travel to Wyrmrest Temple
step
.goto Dragonblight,60.02,55.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Aurastrasza|r
>>|cRXP_FRIENDLY_Aurastrasza|r |cRXP_WARN_is on the ground level of the Temple|r
.turnin 12151 >>Turn in Wanton Warlord
.target Aurastrasza
step
#label wings
.use 38302 >>|cRXP_WARN_Use the|r |T134124:0|t[Ruby Beacon of the Dragon Queen] |cRXP_WARN_to mount the |cRXP_FRIENDLY_Wyrmrest Vanquisher|r again and fly to the top of Wyrmrest Temple|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alexstrasza|r and |cRXP_FRIENDLY_Itharius|r
.turnin 12498 >>Turn in On Ruby Wings
.accept 12499 >>Accept Return To Angrathar
.goto Dragonblight,59.83,54.66
.turnin 12458 >>Turn in Seeds of the Lashers

.goto Dragonblight,59.60,54.46
.target Alexstrasza the Life-Binder
.target Lord Itharius
step
#completewith next
.goto Dragonblight,59.51,53.33
.gossipoption 93073 >>Talk to |cRXP_FRIENDLY_Torastrasza|r to fly to the middle level of the Temple
.timer 25,Flight to Devrestrasz
.skill coldweatherflying,1,1
.isOnQuest 12435
.target Torastrasza
step
.goto Dragonblight,59.24,54.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Devrestrasz|r
>>|cRXP_FRIENDLY_Devrestrasz|r |cRXP_WARN_is on the middle level of the Temple|r
.turnin 12435 >>Turn in Report to Lord Devrestrasz
.daily 12372 >>Accept Defending Wyrmrest Temple
.target Lord Devrestrasz
step
.goto Dragonblight,58.35,55.22,-1
.goto Dragonblight,58.28,53.73,-1
>>|cRXP_WARN_Dismount before talking to a|r |cRXP_FRIENDLY_Wyrmrest Defender|r
.gossipoption 93574 >>Mount a |cRXP_FRIENDLY_Wyrmrest Defender|r
>>|cRXP_FRIENDLY_Wyrmrest Defenders|r |cRXP_WARN_are on the middle level of the Temple|r
.isOnQuest 12372
.target Wyrmrest Defender
step
#completewith next
>>|cRXP_WARN_Cast|r |T135789:0|t[Destabilize Azure Dragonshrine] (5) |cRXP_WARN_on the |cRXP_PICK_Skybeam|r near the ground to destabilize Azure Dragonshrine|r
.complete 12372,3 
.goto Dragonblight,55.34,66.20
.isOnQuest 12372
step
>>|cRXP_WARN_Cast|r |T135812:0|t[Flame Breath] (1) |cRXP_WARN_and|r |T135817:0|t[Immolation] (2) |cRXP_WARN_to kill |cRXP_ENEMY_Azure Dragons|r and|r |cRXP_ENEMY_Azure Drakes|r
>>|cRXP_WARN_Cast|r |T135953:0|t[Renew] (3) |cRXP_WARN_to heal your|r |cRXP_FRIENDLY_Wyrmrest Defender|r
>>|cRXP_WARN_Cast|r |T135788:0|t[Blazing Speed] (4) |cRXP_WARN_on cooldown to move faster|r
>>|cRXP_WARN_Make sure you're within 100 yards of a mob when it dies or you won't get credit|r
.complete 12372,1 
.goto Dragonblight,55.2,54.3,100,0
.goto Dragonblight,61.4,61.1,100,0
.goto Dragonblight,55.2,66.7
.complete 12372,2 
.goto Dragonblight,55.2,54.3,100,0
.goto Dragonblight,61.4,61.1,100,0
.goto Dragonblight,55.2,66.7
.isOnQuest 12372
.mob Azure Dragon
.mob Azure Drake
.skipgossip
step
>>|cRXP_WARN_Cast|r |T135789:0|t[Destabilize Azure Dragonshrine] (5) |cRXP_WARN_on the |cRXP_PICK_Skybeam|r near the ground to destabilize Azure Dragonshrine|r
.complete 12372,3 
.goto Dragonblight,55.34,66.20
.isOnQuest 12372
step
>>|cRXP_WARN_Cast|r |T135812:0|t[Flame Breath] (1) |cRXP_WARN_and|r |T135817:0|t[Immolation] (2) |cRXP_WARN_to kill |cRXP_ENEMY_Azure Dragons|r and|r |cRXP_ENEMY_Azure Drakes|r
>>|cRXP_WARN_Cast|r |T135953:0|t[Renew] (3) |cRXP_WARN_to heal your|r |cRXP_FRIENDLY_Wyrmrest Defender|r
>>|cRXP_WARN_Cast|r |T135788:0|t[Blazing Speed] (4) |cRXP_WARN_on cooldown to move faster|r
>>|cRXP_WARN_Make sure you're within 100 yards of a mob when it dies or you won't get credit|r
.complete 12372,1 
.goto Dragonblight,55.2,54.3,100,0
.goto Dragonblight,61.4,61.1,100,0
.goto Dragonblight,55.2,66.7
.complete 12372,2 
.goto Dragonblight,55.2,54.3,100,0
.goto Dragonblight,61.4,61.1,100,0
.goto Dragonblight,55.2,66.7
.isOnQuest 12372
.mob Azure Dragon
.mob Azure Drake
step
#completewith next
.goto Dragonblight,49.15,75.65,100 >> |cRXP_WARN_Fly to Moa'ki Harbor on the|r |cRXP_FRIENDLY_Wyrmrest Defender|r
>>|cRXP_WARN_Cast|r |T135788:0|t[Blazing Speed] (4) |cRXP_WARN_if it's available|r
.isOnQuest 12372
step
.goto Dragonblight,49.15,75.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Toalu'u|r
.turnin 12032 >>Turn in Conversing With the Depths
.isQuestComplete 12032
.target Toalu'u the Mystic
step
#completewith next
.goto Dragonblight,48.52,74.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cid|r
.fly Wyrmrest Temple >> Fly to Wyrmrest Temple
.target Cid Flounderfix
.skill coldweatherflying,1,1
.skill riding,300,1
step
#completewith DWT
.goto Dragonblight,57.91,54.17
.gossipoption 93559 >>Talk to |cRXP_FRIENDLY_Tariolstrasz|r to fly to the middle level of the Temple
.timer 16,Flight to Devrestrasz
.skill coldweatherflying,1,1
.isOnQuest 12372
.target Tariolstrasz
step
#completewith next
.goto Dragonblight,59.24,54.32,200 >> Travel to Wyrmrest Temple
.skill coldweatherflying,<1,1
step
#label DWT
.goto Dragonblight,59.24,54.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Devrestrasz|r
>>|cRXP_FRIENDLY_Devrestrasz|r |cRXP_WARN_is on the middle level of the Temple|r
.turnin 12372 >>Turn in Defending Wyrmrest Temple
.isOnQuest 12372
.target Lord Devrestrasz
step
#completewith Angrathar
.goto Dragonblight,60.32,51.55
>>|cRXP_WARN_Drop down to the flight master. Cast|r |T135896:0|t[Divine Shield] |cRXP_WARN_or|r |T135964:0|t[Hand of Protection] |cRXP_WARN_to not die to fall damage|r << Paladin
>>|cRXP_WARN_Drop down to the flight master. Be careful to not die to fall damage|r << !Paladin
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nethestrasz|r
.fly Fordragon >> Fly to Fordragon Hold
.target Nethestrasz
.skill coldweatherflying,1,1
step
#completewith next
.goto Dragonblight,37.81,23.41,100 >> Travel to Fordragon Hold
.skill coldweatherflying,<1,1
step
#label Angrathar
.groundgoto Dragonblight,37.0,25.1,30,0
.goto Dragonblight,37.81,23.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bolvar|r
>>|cRXP_WARN_Get ready to press Escape if you don't want to watch the cinematic|r
.turnin 12499 >>Turn in Return To Angrathar
.target Highlord Bolvar Fordragon
step << !Druid !DK
.goto Dragonblight,38.42,19.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alexstrasza|r
.accept 13347 >>Accept Reborn From The Ashes
.target Alexstrasza the Life-Binder
step << !Druid !DK
.goto Dragonblight,38.01,19.64
>>Loot |cRXP_PICK_Fordragon's Shield|r on the ground
.complete 13347,1 
step << Mage
.goto Dragonblight,37.77,23.43
.zone Stormwind City >> Move away from |cRXP_FRIENDLY_Alexstrasza|r to lose the |T237543:0|t[Serenity] buff. Teleport to Stormwind
step << Mage
.goto Stormwind City,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 43019 >> Train your class spells
.xp <73,1
.target Elsharin
.target Jennea Cannon
step << Mage
.goto Stormwind City,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42939 >> Train your class spells
.xp <74,1
.target Elsharin
.target Jennea Cannon
step << Mage
.goto Stormwind City,49.55,85.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42955 >> Train your class spells
.xp <75,1
.target Elsharin
.target Jennea Cannon
step << !Druid !DK !Mage
#completewith next
.goto Dragonblight,39.51,25.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Derek|r
.fly Valiance Keep >> Fly to Valiance Keep. Alternatively pay a |T626001:0|t|cFF3FC7EBMage|r for a portal to Stormwind
.zoneskip Stormwind City
.zoneskip Elwynn Forest
.xp >73,1
.skill coldweatherflying,1,1
.target Derek Rammel
step << !DK !Druid !Mage
.goto BoreanTundra,59.70,69.26
.zone Stormwind City >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nelno|r. Ask him for a teleport to Stormwind Harbor
.zoneskip Elwynn Forest
.skipgossip
.xp >73,1
.skill coldweatherflying,1,1
.target Nelno Copperbeam
step << !Druid !DK !Mage
#completewith Modera
.goto Dragonblight,39.51,25.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Derek|r
.fly Stars' Rest >> Fly to Stars' Rest. Alternatively pay a |T626001:0|t|cFF3FC7EBMage|r for a portal to Stormwind
.zoneskip Stormwind City
.zoneskip Elwynn Forest
.zoneskip Dalaran
.xp <74,1
.skill coldweatherflying,1,1
.target Derek Rammel
step << !Druid !DK !Mage
.goto Dragonblight,29.00,55.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Modera|r
.accept 12794 >>Accept The Magical Kingdom of Dalaran
.zoneskip Elwynn Forest
.zoneskip Stormwind City
.zoneskip Dalaran
.xp <74,1
.skill coldweatherflying,1,1
.target Image of Archmage Modera
step << !DK !Druid !Mage
#label Modera
.goto Dragonblight,29.00,55.45
.zone Dalaran >>Ask |cRXP_FRIENDLY_Modera|r for a teleport to Dalaran
.zoneskip Stormwind City
.skipgossip
.xp <74,1
.skill coldweatherflying,1,1
.isOnQuest 12794
.target Image of Archmage Modera
step << !DK !Druid !Mage
.abandon 12794 >> Abandon The Magical Kingdom of Dalaran. |cRXP_WARN_DO NOT TURN THIS IN|r
step << !DK !Druid !Mage
.goto Dalaran,40.10,62.78,150 >> Travel to Dalaran
.zoneskip Stormwind City
.skill coldweatherflying,<1,1
.isOnQuest 13347
step << !DK !Druid !Mage
.goto Dalaran,40.2,56.3,50,0
.goto Dalaran,40.10,62.78
.zone Stormwind City >>Go into The Silver Enclave in Dalaran. Take the portal to Stormwind
.skill coldweatherflying,<1,1
.zoneskip Stormwind City
.isOnQuest 13347
step << !DK !Druid !Mage
.goto Dalaran,40.2,56.3,50,0
.goto Dalaran,40.10,62.78
.zone Stormwind City >>Go into The Silver Enclave in Dalaran. Take the portal to Stormwind
.xp <74,1
.skill coldweatherflying,1,1
.zoneskip Stormwind City
.isOnQuest 13347
step << Shaman
.goto StormwindNew,67.52,89.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umbrua|r
.train 49237 >> Train your class spells
.xp <73,1
.target Farseer Umbrua
step << Shaman
.goto StormwindNew,67.52,89.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umbrua|r
.train 49270 >> Train your class spells
.xp <74,1
.target Farseer Umbrua
step << Shaman
.goto StormwindNew,67.52,89.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umbrua|r
.train 49280 >> Train your class spells
.xp <75,1
.target Farseer Umbrua
step << Warlock
.goto StormwindNew,42.26,81.77,20,0
.goto StormwindNew,40.64,84.94,15,0
.goto StormwindNew,39.88,84.19
>>Go into The Slaughtered Lamb and go downstairs
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ursula|r, |cRXP_FRIENDLY_Demisette|r or |cRXP_FRIENDLY_Sandahl|r
.train 47892 >> Train your class spells
.xp <74,1
.target Ursula Deline
.target Demisette Cloyce
.target Sandahl
step << Paladin/Priest
#completewith PaPrTraining1
.goto StormwindNew,52.9,50.9,20 >> Enter the Stormwind Cathedral
step << Paladin
.goto StormwindNew,49.8,48.5,20,0
.goto StormwindNew,49.60,49.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arthur|r or |cRXP_FRIENDLY_Katherine|r
.train 48931 >> Train your class spells
.xp <73,1
.target Arthur the Faithful
.target Katherine the Pure
step << Paladin
.goto StormwindNew,49.8,48.5,20,0
.goto StormwindNew,49.60,49.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arthur|r or |cRXP_FRIENDLY_Katherine|r
.train 48805 >> Train your class spells
.xp <74,1
.target Arthur the Faithful
.target Katherine the Pure
step << Paladin
#label PaPrTraining1
.goto StormwindNew,49.8,48.5,20,0
.goto StormwindNew,49.60,49.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arthur|r or |cRXP_FRIENDLY_Katherine|r
.train 48818 >> Train your class spells
.xp <75,1
.target Arthur the Faithful
.target Katherine the Pure
step << Priest
.goto StormwindNew,49.51,45.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Joshua|r
.train 48126 >> Train your class spells
.xp <74,1
.target Brother Joshua
step << Priest
#label PaPrTraining1
.goto StormwindNew,49.51,45.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Joshua|r
.train 48124 >> Train your class spells
.xp <75,1
.target Brother Joshua
step << Hunter
.goto StormwindNew,67.3,37.1,15,0
.goto StormwindNew,67.35,36.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Einris|r
.train 49044 >> Train your class spells
.xp <73,1
.target Einris Brightspear
step << Hunter
.goto StormwindNew,67.3,37.1,15,0
.goto StormwindNew,67.35,36.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Einris|r
.train 61846 >> Train your class spells
.xp <74,1
.target Einris Brightspear
step << Hunter
.goto StormwindNew,67.3,37.1,15,0
.goto StormwindNew,67.35,36.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Einris|r
.train 61005 >> Train your class spells
.xp <75,1
.target Einris Brightspear
step << Rogue
.goto StormwindNew,77.42,65.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Osborne|r
.train 48667 >> Train your class spells
.xp <73,1
.target Osborne the Night Man
step << Warrior
.goto StormwindNew,78.31,63.53,15,0
.goto StormwindNew,81.66,59.50,15,0
.goto StormwindNew,80.56,59.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wu|r or |cRXP_FRIENDLY_Ilsa|r
.train 47470 >> Train your class spells
.xp <73,1
.target Wu Shen
.target Ilsa Corbin
step << Warrior
.goto StormwindNew,78.31,63.53,15,0
.goto StormwindNew,81.66,59.50,15,0
.goto StormwindNew,80.56,59.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wu|r or |cRXP_FRIENDLY_Ilsa|r
.train 55694 >> Train your class spells
.xp <75,1
.target Wu Shen
.target Ilsa Corbin
step << !Druid !DK
#completewith next
.goto StormwindNew,73.69,45.98,20 >> Travel to Stormwind Keep
step << !Druid !DK
.goto StormwindNew,80.01,38.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Varian|r
.turnin 13347 >>Turn in Reborn From The Ashes
.accept 13369 >>Accept Fate, Up Against Your Will
.target King Varian Wrynn
step << !Druid !DK
#completewith next
.goto StormwindNew,80.06,38.63
.gossipoption 94297 >>Talk to |cRXP_FRIENDLY_Jaina|r. She will open a portal to Orgrimmar
.timer 12,Jaina Portal to Orgrimmar
.isOnQuest 13369
.target Lady Jaina Proudmoore
step << !Druid !DK
#completewith next
.goto StormwindNew,80.08,38.90
.zone Orgrimmar >> Take the Portal to Orgrimmar
step << !Druid !DK
.goto Orgrimmar,32.5,37.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thrall|r
.turnin 13369 >>Turn in Fate, Up Against Your Will
.accept 13370 >>Accept A Royal Coup
.target Thrall
step << !Druid !DK
#completewith Varian
.goto Orgrimmar,33.22,37.69
.zone Stormwind City >>Take the portal behind you back to Stormwind Keep
step << !Druid !DK
#questguide
.goto StormwindNew,80.01,38.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Varian|r
.turnin 13370 >>Turn in A Royal Coup
.accept 13371 >>Accept The Killing Time
.target King Varian Wrynn
step << !Druid !DK
#label Varian
.goto StormwindNew,80.01,38.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Varian|r
>>|cRXP_WARN_Skip the Battle for Undercity follow ups. It is strongly recommended you skip it due to its terrible XP/Hr|r
.turnin 13370 >>Turn in A Royal Coup
.target King Varian Wrynn
step << skip
#questguide
#completewith next
.goto Stormwind City,80.5,39.4
.zone Tirisfal Glades >> Take the portal in the keep to Tirisfal Glades
step << skip
#questguide
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Broll|r in Tirisfal
.turnin 13371 >> Turn in The Killing Time
.target Broll Bearmantle
step << Shaman
.goto StormwindNew,67.52,89.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umbrua|r
.train 49237 >> Train your class spells
.xp <73,1
.target Farseer Umbrua
step << Shaman
.goto StormwindNew,67.52,89.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umbrua|r
.train 49270 >> Train your class spells
.xp <74,1
.target Farseer Umbrua
step << Shaman
.goto StormwindNew,67.52,89.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Umbrua|r
.train 49280 >> Train your class spells
.xp <75,1
.target Farseer Umbrua
step << Warlock
.goto StormwindNew,42.26,81.77,20,0
.goto StormwindNew,40.64,84.94,15,0
.goto StormwindNew,39.88,84.19
>>Go into The Slaughtered Lamb and go downstairs
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ursula|r, |cRXP_FRIENDLY_Demisette|r or |cRXP_FRIENDLY_Sandahl|r
.train 47892 >> Train your class spells
.xp <74,1
.target Ursula Deline
.target Demisette Cloyce
.target Sandahl
step << Paladin/Priest
#completewith PaPrTraining2
.goto StormwindNew,52.9,50.9,20 >> Enter the Stormwind Cathedral
step << Paladin
.goto StormwindNew,49.8,48.5,20,0
.goto StormwindNew,49.60,49.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arthur|r or |cRXP_FRIENDLY_Katherine|r
.train 48931 >> Train your class spells
.xp <73,1
.target Arthur the Faithful
.target Katherine the Pure
step << Paladin
.goto StormwindNew,49.8,48.5,20,0
.goto StormwindNew,49.60,49.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arthur|r or |cRXP_FRIENDLY_Katherine|r
.train 48805 >> Train your class spells
.xp <74,1
.target Arthur the Faithful
.target Katherine the Pure
step << Paladin
#label PaPrTraining
.goto StormwindNew,49.8,48.5,20,0
.goto StormwindNew,49.60,49.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arthur|r or |cRXP_FRIENDLY_Katherine|r
.train 48818 >> Train your class spells
.xp <75,1
.target Arthur the Faithful
.target Katherine the Pure
step << Priest
.goto StormwindNew,49.51,45.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Joshua|r
.train 48126 >> Train your class spells
.xp <74,1
.target Brother Joshua
step << Priest
#label PaPrTraining2
.goto StormwindNew,49.51,45.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Joshua|r
.train 48124 >> Train your class spells
.xp <75,1
.target Brother Joshua
step << Hunter
.goto StormwindNew,67.3,37.1,15,0
.goto StormwindNew,67.35,36.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Einris|r
.train 49044 >> Train your class spells
.xp <73,1
.target Einris Brightspear
step << Hunter
.goto StormwindNew,67.3,37.1,15,0
.goto StormwindNew,67.35,36.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Einris|r
.train 61846 >> Train your class spells
.xp <74,1
.target Einris Brightspear
step << Hunter
.goto StormwindNew,67.3,37.1,15,0
.goto StormwindNew,67.35,36.25
.train 61005 >> Train your class spells
.xp <75,1
step << Rogue
.goto StormwindNew,77.42,65.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Osborne|r
.train 48667 >> Train your class spells
.xp <73,1
.target Osborne the Night Man
step << Warrior
.goto StormwindNew,78.31,63.53,15,0
.goto StormwindNew,81.66,59.50,15,0
.goto StormwindNew,80.56,59.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wu|r or |cRXP_FRIENDLY_Ilsa|r
.train 47470 >> Train your class spells
.xp <73,1
.target Wu Shen
.target Ilsa Corbin
step << Warrior
.goto StormwindNew,78.31,63.53,15,0
.goto StormwindNew,81.66,59.50,15,0
.goto StormwindNew,80.56,59.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wu|r or |cRXP_FRIENDLY_Ilsa|r
.train 55694 >> Train your class spells
.xp <75,1
.target Wu Shen
.target Ilsa Corbin
step << !DK !Druid
#completewith Hills
.hs >> Hearth to Wyrmrest Temple
step << !DK !Druid
#completewith Hills
.goto Dragonblight,60.32,51.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nethestrasz|r
.fly Wintergarde Keep >> Fly to Wintergarde Keep
.target Nethestrasz
step << DK/Druid
#completewith Hills
.goto Dragonblight,39.51,25.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Derek|r
.fly Wintergarde Keep >> Fly to Wintergarde Keep
.target Derek Rammel
step
#label end
.groundgoto Dragonblight,78.2,46.7,40,0
.goto Dragonblight,76.81,47.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Eligor|r
.turnin 12464 >>Turn in My Old Enemy
.target Commander Eligor Dawnbringer
.isQuestComplete 12464
step
.abandon 12464 >> Abandon My Old Enemy
step
.goto Dragonblight,25.61,51.30,0
#loop
.line Dragonblight,87.90,41.21,87.00,42.19,86.45,40.12,85.51,41.24,83.78,41.98,84.14,40.72,84.49,37.06,87.64,35.43,87.90,41.21
.goto Dragonblight,87.90,41.21,50,0
.goto Dragonblight,87.00,42.19,50,0
.goto Dragonblight,86.45,40.12,50,0
.goto Dragonblight,85.51,41.24,50,0
.goto Dragonblight,83.78,41.98,50,0
.goto Dragonblight,84.14,40.72,50,0
.goto Dragonblight,84.49,37.06,50,0
.goto Dragonblight,87.64,35.43,50,0
.goto Dragonblight,87.90,41.21,50,0
.xp 73 >> Grind the |cRXP_ENEMY_Scarlet Onslaught|r to level 73. Alternatively, do Azjol-Nerub and its quests
.mob Onslaught Bloodhound
.mob Onslaught Infantry
.mob Onslaught Mason
step
#label Hills
.goto Dragonblight,77.10,50.12
>>|cRXP_WARN_This will fly you to Grizzly Hills|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urik|r
.accept 12511 >>Accept The Hills Have Us
.timer 150,Fly to Amberpine Lodge
.target Gryphon Commander Urik
step
.zone Grizzly Hills >> Travel to Grizzly Hills
]])
RXPGuides.RegisterGuide([[
#cata
#Cata
#speedrunguide
#xprate >1.49 << wotlk
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 73-74 Dragonblight
#version 5
#next 74-75 Grizzly Hills

#include 72-74 Dragonblight@pt1start-pt1end
step
.goto Dragonblight,29.00,55.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Modera|r
.turnin 12107 >>Turn in The End of the Line
>>|cRXP_WARN_Skip the follow-up|r
.target Image of Archmage Modera
step

#include 72-74 Dragonblight@pt2start-pt2end
step
.goto Dragonblight,87.17,57.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Orik|r
.turnin 12287 >>Turn in Orik Trueheart and the Forgotten Shore
.accept 12290 >>Accept The Murkweed Elixir
.target Orik Trueheart
step
#label chief
#sticky
.goto Dragonblight,90.67,72.89
>>Kill |cRXP_ENEMY_High Shaman Bloodpaw|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r << wotlk
>>|cRXP_WARN_Cast|r |T136075:0|t[Purge] |cRXP_WARN_when he has Bloodlust|r << Shaman wotlk
>>|cRXP_WARN_Cast|r |T135894:0|t[Dispel Magic] |cRXP_WARN_when he has Bloodlust|r << Priest wotlk
.complete 12441,1 
.mob High Shaman Bloodpaw
step
.goto Dragonblight,89.2,65.4,70,0
.goto Dragonblight,90.2,74.6,70,0
.goto Dragonblight,89.28,65.60,70,0
.goto Dragonblight,90.22,72.24
>>Loot the |cRXP_LOOT_Murkweed|r on the ground
.complete 12290,1 
step
#requires chief
.goto Dragonblight,87.17,57.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Orik|r
.turnin 12290 >>Turn in The Murkweed Elixir
step << !wotlk
.goto Dragonblight,90.1,52.7
>>Kill |cRXP_ENEMY_Kreug Oathbreaker|r
.complete 12438,1 
.mob Kreug Oathbreaker
step
.goto Dragonblight,87.4,38.1
>>|cRXP_WARN_Travel up the Tower|r
>>Kill |cRXP_ENEMY_Commander Iustus|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r << wotlk
.complete 12442,1 
.mob Onslaught Commander Iustus
step
.goto 115/571,-780.500,3772.300
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_High Commander Halford Wyrmbane|r
.target High Commander Halford Wyrmbane
.turnin 12319 >>Turn in Mystery of the Tome
>>|cRXP_WARN_Skip the follow-up|r
step
.goto 115/571,-736.100,3692.600
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Highlord Leoric Von Zeldig|r
.target Highlord Leoric Von Zeldig
.turnin 12438 >>Turn in Wanted: Kreug Oathbreaker << !wotlk
.turnin 12441 >>Turn in Wanted: High Shaman Bloodpaw
.turnin 12442 >>Turn in Wanted: Onslaught Commander Iustus
step
.goto Dragonblight,77.10,50.12
>>|cRXP_WARN_This will fly you to Grizzly Hills|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urik|r
.accept 12511 >>Accept The Hills Have Us
.timer 150,Fly to Amberpine Lodge
.target Gryphon Commander Urik
step
.zone Grizzly Hills >> Travel to Grizzly Hills
]])
RXPGuides.RegisterGuide([[
#cata
#Cata
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 73-75 Grizzly Hills
#version 5
#next 75-77 Zul'Drak
#xprate <1.5 << wotlk
#questguide << !wotlk
step
#label pt1start
.goto Grizzly Hills,31.80,59.55
>>Click on the |cRXP_PICK_Basket|r |cRXP_WARN_on the left as soon as you enter the lodge|r (|cRXP_WARN_NOT upstairs|r)
.accept 12225 >>Accept Mmm... Amberseeds!
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anderhol|r and |cRXP_FRIENDLY_Dumont|r inside the Lodge
.turnin 12225 >>Turn in Mmm... Amberseeds!
.accept 12226 >>Accept Just Passing Through
.accept 12212 >>Accept Replenishing the Storehouse
.accept 12215 >>Accept Them or Us!
.goto Grizzly Hills,32.10,59.97
.turnin 12511 >>Turn in The Hills Have Us
.accept 12292 >>Accept Local Support
.goto Grizzly Hills,31.83,60.16
.isOnQuest 12511
.target Master Woodsman Anderhol
.target Lieutenant Dumont
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anderhol|r and |cRXP_FRIENDLY_Dumont|r inside the Lodge
.turnin 12225 >>Turn in Mmm... Amberseeds!
.accept 12226 >>Accept Just Passing Through
.accept 12212 >>Accept Replenishing the Storehouse
.accept 12215 >>Accept Them or Us!
.goto Grizzly Hills,32.10,59.97
.accept 12292 >>Accept Local Support
.goto Grizzly Hills,31.83,60.16
.target Master Woodsman Anderhol
.target Lieutenant Dumont
step
#completewith Cedar
.goto Grizzly Hills,31.96,60.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennifer|r
.home >> Set your Hearthstone to Amberpine Lodge
>>|cRXP_BUY_Buy food/water if needed|r
.target Jennifer Bell
step
.goto Grizzly Hills,31.31,59.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vana|r
.fp Amberpine Lodge >> Get the Amberpine Lodge flight path
.target Vana Grey
step
.goto Grizzly Hills,29.01,55.09,60,0
.goto Grizzly Hills,29.56,59.02
>>Loot the |cRXP_PICK_Plants|r along the river
.complete 12226,1 
step
#pvp
.goto Grizzly Hills,29.91,59.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carter|r
>>|cRXP_WARN_This quest|r (|cRXP_WARN_and keeping it in your questlog|r) |cRXP_WARN_flags you for PVP|r. |cRXP_WARN_Skip it if you wish|r
.accept 12444 >>Accept Blackriver Skirmish
.target Scout Captain Carter
step
#pvp
.goto Grizzly Hills,28.42,60.96,60,0
.goto Grizzly Hills,27.57,64.80,60,0
.goto Grizzly Hills,27.67,68.24
>>Kill the |cRXP_ENEMY_Conquest Hold Raiders|r (or |cRXP_ENEMY_Horde Players|r) in Blackriver
.complete 12444,1 
.isOnQuest 12444
.mob Conquest Hold Raider
step
#completewith next
>>Kill |cRXP_ENEMY_Stags|r. Loot them for their |cRXP_LOOT_Venison|r
.complete 12212,1 
.mob Tallhorn Stag
step
.goto Grizzly Hills,26.05,67.22,60,0
.goto Grizzly Hills,24.70,67.38,60,0
.goto Grizzly Hills,25.19,70.50,60,0
.goto Grizzly Hills,24.01,71.68,60,0
.goto Grizzly Hills,19.95,73.83,60,0
.goto Grizzly Hills,26.05,67.22
>>Kill |cRXP_ENEMY_Graymist Hunters|r
.complete 12215,1 
.mob Graymist Hunter
step
.goto Grizzly Hills,23.10,71.92,60,0
.goto Grizzly Hills,21.32,73.82,60,0
.goto Grizzly Hills,20.65,71.32,60,0
.goto Grizzly Hills,17.42,71.30,60,0
.goto Grizzly Hills,14.37,69.89,60,0
.goto Grizzly Hills,12.74,72.29,60,0
.goto Grizzly Hills,11.17,69.22,60,0
.goto Grizzly Hills,12.97,65.10,60,0
.goto Grizzly Hills,17.77,66.23,60,0
.goto Grizzly Hills,23.10,71.92
>>Kill |cRXP_ENEMY_Stags|r. Loot them for their |cRXP_LOOT_Venison|r
.complete 12212,1 
.mob Tallhorn Stag
step
#label Cedar
.goto Grizzly Hills,15.87,65.27
>>Go inside the guarded building. Loot the |cRXP_PICK_chest|r
.complete 12292,1 
step
#completewith next
.hs >> Hearth to Amberpine Lodge
.cooldown item,6948,>2
step
>>Return to Amberpine Lodge
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dumont|r and |cRXP_FRIENDLY_Anderhol|r
.turnin 12292 >>Turn in Local Support
.accept 12293 >>Accept Close the Deal
.goto Grizzly Hills,31.83,60.16
.turnin 12212 >>Turn in Replenishing the Storehouse
.accept 12216 >>Accept Take Their Rear!
.turnin 12226 >>Turn in Just Passing Through
.accept 12227 >>Accept Doing Your Duty
.turnin 12215 >>Turn in Them or Us!
.accept 12217 >>Accept Eagle Eyes
.goto Grizzly Hills,32.10,59.97
.target Lieutenant Dumont
.target Master Woodsman Anderhol
step
.goto Grizzly Hills,32.22,58.89
>>Use the |cRXP_PICK_Amberpine Outhouse|r outside
.complete 12227,1 
.skipgossip
step
#completewith next
.goto Grizzly Hills,32.0,47.1,0
>>Kill |cRXP_ENEMY_Imperial Eagles|r that you see
.complete 12217,1 
.mob Imperial Eagle
step
.goto Grizzly Hills,34.77,55.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ivan|r inside the building
.turnin 12293 >>Turn in Close the Deal
.accept 12294 >>Accept A Tentative Pact
.target Ivan
step
.goto Grizzly Hills,34.68,51.30,60,0
.goto Grizzly Hills,31.21,49.57,60,0
.goto Grizzly Hills,32.53,47.63
>>Kill |cRXP_ENEMY_Imperial Eagles|r that you see
.complete 12217,1 
.mob Imperial Eagle
step
.goto Grizzly Hills,30.41,45.04,60,0
.goto Grizzly Hills,29.41,52.57,60,0
.goto Grizzly Hills,28.73,58.30
>>Kill |cRXP_ENEMY_Grizzly Bears|r. Loot them for their |cRXP_LOOT_Flanks|r
.complete 12216,1 
.mob Grizzly Bear
step
#pvp
.goto Grizzly Hills,29.91,59.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carter|r
.turnin 12444 >>Turn in Blackriver Skirmish
.isQuestComplete 12444
.target Scout Captain Carter
step
.abandon 12444 >> Abandon Blackriver Skirmish
step
>>Return to Amberpine Lodge
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dumont|r, |cRXP_FRIENDLY_Anderhol|r, and |cRXP_FRIENDLY_Drake|r outside
.turnin 12294 >>Turn in A Tentative Pact
.accept 12295 >>Accept An Exercise in Diplomacy
.accept 12210 >>Accept Troll Season!
.goto Grizzly Hills,31.83,60.16
.turnin 12217 >>Turn in Eagle Eyes
.turnin 12216 >>Turn in Take Their Rear!
.turnin 12227 >>Turn in Doing Your Duty
.goto Grizzly Hills,32.10,59.97
.accept 12222 >>Accept Secrets of the Flamebinders
.accept 12223 >>Accept Thinning the Ranks
.goto Grizzly Hills,32.42,59.94
.target Lieutenant Dumont
.target Master Woodsman Anderhol
.target Woodsman Drake
step
#sticky
#label Talismans
.goto Grizzly Hills,30.2,77.3,0,0
>>Kill |cRXP_ENEMY_Dragonflayer Flamebinders|r. Loot them for their |cRXP_LOOT_Talismans|r
.complete 12222,1 
.mob Dragonflayer Flamebinder
step
.goto Grizzly Hills,31.61,78.70,60,0
.goto Grizzly Hills,31.51,80.42,60,0
.goto Grizzly Hills,28.23,75.89,60,0
.goto Grizzly Hills,27.82,72.09
>>Kill |cRXP_ENEMY_Dragonflayer Huscarls|r
.complete 12223,1 
.mob Dragonflayer Huscarl
step << Shaman
#requires Talismans
#completewith next
.hs >> Hearth to Amberpine Lodge
.cooldown item,6948,>2
step
#requires Talismans
.goto Grizzly Hills,32.42,59.94
>>Ride back to Amberpine Lodge
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drake|r
.turnin 12222 >>Turn in Secrets of the Flamebinders
.turnin 12223 >>Turn in Thinning the Ranks
.accept 12255 >>Accept The Thane of Voldrune
.target Woodsman Drake
step << wotlk
#pvp
>>Ride down to Venture Bay
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Barblefink|r, |cRXP_FRIENDLY_Freeman|r, |cRXP_FRIENDLY_Stuart|r, and |cRXP_FRIENDLY_Downey|r
>>|cRXP_WARN_This quest|r (|cRXP_WARN_and keeping it in your questlog|r) |cRXP_WARN_flags you for PVP|r. |cRXP_WARN_Skip it if you wish|r
.accept 12443 >>Accept Seeking Solvent
.goto Grizzly Hills,23.02,80.16
.accept 12314 >>Accept Down With Captain Zorna!
.goto Grizzly Hills,22.11,81.28
.accept 12316 >>Accept Keep Them at Bay!
.goto Grizzly Hills,22.07,81.30
.accept 12323 >>Accept Smoke 'Em Out
.goto Grizzly Hills,21.98,80.72
.target Barblefink
.target Baron Freeman
.target Lieutenant Stuart
.target Sergeant Downey
step << wotlk
#completewith Zorna
#pvp
.goto Grizzly Hills,18.1,79.5,40,0
.goto Grizzly Hills,16.4,76.5,40,0
.goto Grizzly Hills,14.5,76.4,0
.use 37621 >> Use the |T133717:0|t[Smoke Bomb] in your bags on the |cRXP_ENEMY_Venture Co. Stragglers|r in the buildings. |cRXP_WARN_You can bodypull them to stack them better for the bomb|r
.complete 12323,1 
.isOnQuest 12323
.mob Venture Co. Straggler
step << wotlk
#completewith Smoke
#pvp
.goto Grizzly Hills,15.4,76.6,0
>>Kill |cRXP_ENEMY_Conquest Hold Berserkers|r (or |cRXP_ENEMY_Horde Players|r) in Venture Bay
.complete 12316,1 
.isOnQuest 12316
.mob Conquest Hold Berserker
step << skip
#pvp
#questguide
>>Check to see if Venture Bay is controlled by Alliance or Horde. If it's controlled by Horde, skip this step
>>|cRXP_WARN_This quest|r (|cRXP_WARN_and keeping it in your questlog|r) |cRXP_WARN_flags you for PVP|r. |cRXP_WARN_Skip it if you wish|r
.goto Grizzly Hills,14.8,86.6
.accept 12437 >>Accept Riding the Red Rocket
step << skip
#pvp
#questguide
.goto Grizzly Hills,16.0,81.1,20,0
.goto Grizzly Hills,16.4,80.4
>>Enter the Venture.Co ship. Go to the back of the ship on the bottom floor and loot the Element 115. Be careful as it has a 3 minute duration
.collect 37664,1 
.isOnQuest 12437

step << skip
#pvp
#questguide
#completewith next
.goto Grizzly Hills,13.7,89.1
.vehicle >> Travel to the Dock of Venture Bay. Get into the Rocket Propelled Warhead
.isOnQuest 12437
step << skip
#pvp
#questguide
.goto Grizzly Hills,9.6,79.0
>>You move the rocket with the direction your camera is facing. Ride it into the Warsong Lumber Boat. If it bumps into an Iceberg or the land, it'll explode and you'll need to get the Element 115 again and run all the way back.
.complete 12437,1 
.isOnQuest 12437
step << skip
#pvp
#questguide
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tSwim back to Venture Bay's Dock. Talk to Howser
.goto Grizzly Hills,14.8,86.6
.turnin 12437 >>Turn in Riding the Red Rocket
.isQuestComplete 12437
step << wotlk
#pvp
#label Zorna
.goto Grizzly Hills,13.36,80.19
>>Kill |cRXP_ENEMY_Captain Zorna|r on the dock. |cRXP_WARN_Use all your cooldowns|r. |cRXP_WARN_If you can't kill her|r, |cRXP_WARN_skip this step|r
.complete 12314,1 
.isOnQuest 12314
.mob Captain Zorna
step << wotlk
#pvp
#label Smoke
.goto Grizzly Hills,14.5,76.4,40,0
.goto Grizzly Hills,16.4,76.5,40,0
.goto Grizzly Hills,18.1,79.5
.use 37621 >> Use the |T133717:0|t[Smoke Bomb] in your bags on the |cRXP_ENEMY_Venture Co. Stragglers|r in the buildings. |cRXP_WARN_You can bodypull them to stack them better for the bomb|r
.complete 12323,1 
.isOnQuest 12323
.mob Venture Co. Straggler
step << wotlk
#pvp
.goto Grizzly Hills,11.57,79.32,60,0
.goto Grizzly Hills,15.14,78.52,60,0
.goto Grizzly Hills,14.84,76.47
>>Kill |cRXP_ENEMY_Conquest Hold Berserkers|r (or |cRXP_ENEMY_Horde Players|r) in Venture Bay
.complete 12316,1 
.isOnQuest 12316
.mob Conquest Hold Berserker
step << wotlk
#pvp
.goto Grizzly Hills,16.0,81.1,20,0
.goto Grizzly Hills,16.36,80.26
>>Enter the Venture Co. Ship
>>|cRXP_WARN_Go to the back of the ship on the bottom floor and loot the|r |cRXP_PICK_Element 115|r. |cRXP_WARN_Be careful as it has a 3 minute duration|r
.complete 12443,1 
.isOnQuest 12443
step << wotlk
#pvp
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Downey|r
.goto Grizzly Hills,21.98,80.72
.turnin 12323 >>Turn in Smoke 'Em Out
.isQuestComplete 12323
.target Sergeant Downey
step << wotlk
#completewith end
#label CZorna
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stuart|r
.goto Grizzly Hills,22.07,81.30
.turnin 12316 >>Turn in Keep Them at Bay!
.isQuestComplete 12316
.target Lieutenant Stuart
step << wotlk
#pvp
.goto Grizzly Hills,22.11,81.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Freeman|r
.turnin 12314 >>Turn in Down With Captain Zorna!
.isQuestComplete 12314
.target Baron Freeman
step << wotlk
#pvp
#requires CZorna
.goto Grizzly Hills,23.02,80.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Barblefink|r
.turnin 12443 >>Turn in Seeking Solvent
.isQuestComplete 12443
.target Barblefink
step << wotlk
#completewith Sacrifices
>>Abandon the PVP quests you were unable to complete
.abandon 12314 >>Abandon Down With Captain Zorna!
.abandon 12316 >>Abandon Keep Them at Bay!
.abandon 12443 >>Abandon Seeking Solvent
.abandon 12323 >>Abandon Smoke 'Em Out
step
#completewith next
.goto Grizzly Hills,26.59,77.85
.vehicle >> Mount |cRXP_WARN_Flamebringer|r in Voldrune
.skipgossip
.target Flamebringer
step
#label pt1end
.goto Grizzly Hills,27.6,72.9
>>Kill |cRXP_ENEMY_Torvald|r
>>Use |T134316:0|t"Wing Buffet" (2) to combo with |T135830:0|t"Molten Fury" (3). Spam |T135805:0|t"Flame Breath" (1), when the other spells are on cooldown
>>|cRXP_WARN_If you have a very strong character you can dismount next to|r |cRXP_ENEMY_Torvald|r |cRXP_WARN_on the ledge and kill him normally|r
.complete 12255,1 
.mob Thane Torvald Eriksson
step
.goto Grizzly Hills,16.19,47.60
>>Travel to Granite Springs on |cRXP_FRIENDLY_Flamebringer|r and then your mount
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Samir|r
.turnin 12210 >>Turn in Troll Season!
.accept 11984 >>Accept Filling the Cages
.target Samir
step
.goto Grizzly Hills,16.37,48.26,10,0
.goto Grizzly Hills,15.0,60.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Budd|r in Granite Springs. Ask him to follow you. Save him from |cRXP_ENEMY_Worgs|r that may attack him
.use 35736 >>Use |cRXP_FRIENDLY_Budd's|r |T132310:0|t"Tag Troll" ability on an |cRXP_ENEMY_Ice Troll|r (|cRXP_WARN_It is on your Pet Bar|r). Then, use the |T132599:0|t[Bounty Hunter's Cage] in your bags on the |cRXP_ENEMY_Troll|r
.complete 11984,1 
.skipgossip
.target Budd
.mob Drakkari Shaman
.mob Drakkari Warrior
step
>>Return to Granite Springs
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Samir|r and then |cRXP_FRIENDLY_Drakuru|r in the cage
.turnin 11984 >>Turn in Filling the Cages
.goto Grizzly Hills,16.19,47.60
.accept 11989 >>Accept Truce?
.goto Grizzly Hills,16.43,47.77
.target Samir
.target Drakuru
step
#completewith next
.goto Grizzly Hills,16.54,47.76
.cast 50141 >>Loot the |cRXP_PICK_Knife|r that's lodged into the log to the right of |cRXP_FRIENDLY_Drakuru|r. Use the |T135650:0|t[Dull Carving Knife]
.collect 38083,1,11989,1 
.use 38083
step
.use 38083 >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drakuru|r again
.complete 11989,1 
.turnin 11989 >>Turn in Truce?
.accept 11990 >>Accept Vial of Visions
.goto Grizzly Hills,16.43,47.77
.skipgossip
.target Drakuru
step
.goto Grizzly Hills,15.96,47.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ameenah|r. Buy an |T132379:0|tImbued Vial from her
.complete 11990,1 

.target Ameenah
step
.goto Grizzly Hills,16.7,43.4,70,0
.goto Grizzly Hills,12.6,41.4
>>Loot the small |cRXP_PICK_Bruiseweed-esque|r plants on the ground
.complete 11990,2 
step
.goto Grizzly Hills,15.30,40.08
>>Loot the |cRXP_PICK_Waterweed Frond|r underwater
.complete 11990,3 
step
.goto Grizzly Hills,16.43,47.77
>>Return to Granite Springs
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drakuru|r
.turnin 11990 >>Turn in Vial of Visions
.accept 11991 >>Accept Subject to Interpretation
.target Drakuru
step
.accept 12484 >>Accept Scourgekabob
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Prigmon|r, then loot one of the |cRXP_PICK_Scourged Troll Mummys|r next to him on the ground
.goto Grizzly Hills,15.73,46.69
.collect 38149,1,12484,1 
.goto Grizzly Hills,15.84,46.72,-1
.goto Grizzly Hills,15.70,46.85,-1
.target Prigmon
step
.use 38149 >>Use the |T133798:0|t[Scourged Troll Mummy] in your bags to throw it into the fire
.complete 12484,1 
.goto Grizzly Hills,16.84,48.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mack|r. |cRXP_WARN_Wait out the RP event|r
.turnin 12484 >>Turn in Scourgekabob
.accept 12029 >>Accept Seared Scourge
.goto Grizzly Hills,16.67,48.30
.target Mack Fearsen
step
.goto Grizzly Hills,15.73,46.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Prigmon|r
.accept 12483 >>Accept Shimmercap Stew
.target Prigmon
step
#completewith IEyes
#label FrozenMojo
.goto Grizzly Hills,13.7,58.1,70,0
.goto Grizzly Hills,14.2,62.3,70,0
.goto Grizzly Hills,10.9,62.4,70,0
.goto Grizzly Hills,11.7,59.3,70,0
.goto Grizzly Hills,13.7,58.1,70,0
.goto Grizzly Hills,14.2,62.3,70,0
.goto Grizzly Hills,10.9,62.4,70,0
.goto Grizzly Hills,11.7,59.3
>>Kill |cRXP_ENEMY_Ice Trolls|r in the area. Loot them for |cRXP_LOOT_5 Frozen Mojo|r
.collect 35799,5 
.mob Drakkari Shaman
.mob Drakkari Warrior
step
#completewith next
>>Kill |cRXP_ENEMY_Ice Serpents|r in the area. Loot them for their |cRXP_LOOT_Eyes|r
.goto Grizzly Hills,13.7,58.1,70,0
.goto Grizzly Hills,14.2,62.3,70,0
.goto Grizzly Hills,10.9,62.4,70,0
.goto Grizzly Hills,11.7,59.3
.complete 12483,1 
.mob Ice Serpent
step
.goto Grizzly Hills,10.70,64.19,60,0
.goto Grizzly Hills,11.1,59.3
>>Loot the |cRXP_PICK_frozen mushrooms|r on the ground
.complete 12483,2 
step
#label IEyes
>>Kill |cRXP_ENEMY_Ice Serpents|r in the area. Loot them for their |cRXP_LOOT_Eyes|r
.goto Grizzly Hills,13.7,58.1,70,0
.goto Grizzly Hills,14.2,62.3,70,0
.goto Grizzly Hills,10.9,62.4,70,0
.goto Grizzly Hills,11.7,59.3,70,0
.goto Grizzly Hills,13.7,58.1,70,0
.goto Grizzly Hills,14.2,62.3,70,0
.goto Grizzly Hills,10.9,62.4,70,0
.goto Grizzly Hills,11.7,59.3
.complete 12483,1 
.mob Ice Serpent
step
#completewith end
#label FrozenMojo3
.goto Grizzly Hills,13.7,58.1,70,0
.goto Grizzly Hills,14.2,62.3,70,0
.goto Grizzly Hills,10.9,62.4,70,0
.goto Grizzly Hills,11.7,59.3,70,0
.goto Grizzly Hills,13.7,58.1,70,0
.goto Grizzly Hills,14.2,62.3,70,0
.goto Grizzly Hills,10.9,62.4,70,0
.goto Grizzly Hills,11.7,59.3
>>Kill |cRXP_ENEMY_Ice Trolls|r in the area. Loot them for |cRXP_LOOT_5 Frozen Mojo|r
.collect 35799,5 
.mob Drakkari Shaman
.mob Drakkari Warrior
step
#requires FrozenMojo3
.goto Grizzly Hills,13.24,60.87
>>Use |T134812:0|t[Drakuru's Elixir] on top of the broken building at the Ruins of Drak'Zin to summon |cRXP_FRIENDLY_Drakuru|r
.use 35797 >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drakuru|r
.turnin 11991 >>Turn in Subject to Interpretation
.accept 12007 >>Accept Sacrifices Must be Made
.target Drakuru
step
#completewith next
.goto Grizzly Hills,16.8,37.0,0
.goto Grizzly Hills,13.6,38.7,0
.goto Grizzly Hills,12.6,36.9,0
.goto Grizzly Hills,13.8,34.8,0
.goto Grizzly Hills,17.1,34.4,0
>>Loot the |cRXP_PICK_small green plants|r scattered throughout Zeb'Halak
.complete 12483,3 
step
#completewith end
#label ZimBom
.goto Grizzly Hills,14.50,38.01
>>Kill |cRXP_ENEMY_Warlord Zim'Bo|r. Loot him for his |cRXP_LOOT_Mojo|r
.collect 35836,1 
.mob Warlord Zim'bo
step
#requires ZimBom
.goto Grizzly Hills,16.0,28.7
.use 35908 >>Use |T132798:0|t[Mack's Dark Grog] in your inventory. Spam throw it on the |cRXP_ENEMY_Undead Trolls|r in the area
>>The |T132798:0|tGrog |cRXP_WARN_requires you to throw it from at least 30 yards away|r, however it can be used in combat << !Mage !Hunter !Warlock
>>The |T132798:0|tGrog |cRXP_WARN_requires you to throw it from at least 30 yards away|r. Gather up as many mobs as you can, |T135848:0|tFrost Nova them, then use the |T132798:0|tGrog on them from range << Mage
>>The |T132798:0|tGrog |cRXP_WARN_requires you to throw it from at least 30 yards away|r. Gather up as many mobs as you can with your pet, then use the |T132798:0|tGrog on them from range << Hunter/Warlock
.complete 12029,1 
step
#completewith Sacrifices
.goto Grizzly Hills,16.8,37.0,0
.goto Grizzly Hills,13.6,38.7,0
.goto Grizzly Hills,12.6,36.9,0
.goto Grizzly Hills,13.8,34.8,0
.goto Grizzly Hills,17.1,34.4,0
>>Loot the |cRXP_PICK_small green plants|r scattered throughout Zeb'Halak
.complete 12483,3 
step
.goto Grizzly Hills,17.96,36.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Statue|r at the top of Zeb'Halak. Loot it for the |cRXP_LOOT_Eye of the Prophets|r
.complete 12007,1 
.skipgossip
step
#label Sacrifices
.goto Grizzly Hills,17.42,36.36
>>Use |T134812:0|t[Drakuru's Elixir] at the top of the stairs
.use 35797 >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drakuru|r
.turnin 12007 >>Turn in Sacrifices Must be Made
.accept 12042 >>Accept Heart of the Ancients
.target Drakuru
step
.goto Grizzly Hills,17.1,34.4,70,0
.goto Grizzly Hills,16.8,37.0,70,0
.goto Grizzly Hills,13.6,38.7,70,0
.goto Grizzly Hills,12.6,36.9,70,0
.goto Grizzly Hills,13.8,34.8
>>Loot the |cRXP_PICK_small green plants|r scattered throughout Zeb'Halak
.complete 12483,3 
step
>>Return to Granite Springs
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Prigmon|r and |cRXP_FRIENDLY_Mack|r
.turnin 12483 >>Turn in Shimmercap Stew
.accept 12190 >>Accept Say Hello to My Little Friend
.goto Grizzly Hills,15.73,46.69
.turnin 12029 >>Turn in Seared Scourge


.goto Grizzly Hills,16.67,48.30
.target Prigmon
.target Mack Fearsen
step
#label pt2start
>>Travel to Silverbrook
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ducal|r, |cRXP_FRIENDLY_Sergei|r, and |cRXP_FRIENDLY_Katja|r
.turnin 12295 >>Turn in An Exercise in Diplomacy
.goto Grizzly Hills,26.41,35.70
.accept 12299 >>Accept Northern Hospitality
.goto Grizzly Hills,26.48,35.78
.accept 12307 >>Accept Wolfsbane Root
.goto Grizzly Hills,25.61,33.30
.target Envoy Ducal
.target Sergei
.target Katja
step
#completewith next
.goto Grizzly Hills,23.9,37.7,0
.goto Grizzly Hills,24.4,29.7,0
.goto Grizzly Hills,22.5,30.7,0
>>Click the |cRXP_PICK_Roots|r on the ground
.complete 12307,1 
step
.goto Grizzly Hills,24.05,31.18,60,0
.goto Grizzly Hills,23.90,36.26
>>Kill |cRXP_ENEMY_Conquest Hold Marauders|r in the area
.complete 12299,1 
.mob Conquest Hold Marauder
step
.goto Grizzly Hills,24.22,37.23,60,0
.goto Grizzly Hills,28.29,38.63,60,0
.goto Grizzly Hills,30.09,34.83
>>Click the |cRXP_PICK_Roots|r on the ground
.complete 12307,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Katja|r and |cRXP_FRIENDLY_Sergei|r
.turnin 12307 >>Turn in Wolfsbane Root
.goto Grizzly Hills,25.61,33.30
.turnin 12299 >>Turn in Northern Hospitality
.accept 12300 >>Accept Test of Mettle
.goto Grizzly Hills,26.48,35.78
.target Sergei
.target Katja
step
#label pt2end
.goto Grizzly Hills,21.93,29.92
>>Kill the |cRXP_ENEMY_Orcs|r surrounding the |cRXP_FRIENDLY_Captured Trapper|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Trapper|r after
.complete 12300,1 
.turnin 12300 >>Turn in Test of Mettle
.accept 12302 >>Accept Words of Warning
.target Captured Trapper
.mob Conquest Hold Marauder
step << skip
.goto Grizzly Hills,19.4,27.7
.use 35908 >>Use Mack's Dark Grog in your inventory. Spam throw it on the Undead Trolls in the area
.complete 12038,1 
step
.goto Grizzly Hills,26.46,31.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Caged Prisoner|r inside
.turnin 12302 >>Turn in Words of Warning
.accept 12308 >>Accept Escape from Silverbrook
.target Caged Prisoner
step
#completewith next
.goto Grizzly Hills,26.25,31.10
.vehicle >>Follow the |cRXP_FRIENDLY_Alliance Scout|r to the horses. Get on |cRXP_FRIENDLY_Ducal's Horse|r when it spawns
.target Freed Alliance Scout
.target Ducal's Horse
step
.goto Grizzly Hills,32.50,59.04
>>Use |T132120:0|t"Gallop" (2) on cooldown. Use |T136105:0|t"Trample" (3) when mobs are close to you. Use |T135809:0|t"Burning Oil" (1) to kill the |cRXP_ENEMY_Worgen|r chasing you
.complete 12308,1 
.mob Silverbrook Worgen
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drake|r and |cRXP_FRIENDLY_Dumont|r
.turnin 12255 >>Turn in The Thane of Voldrune
.goto Grizzly Hills,32.42,59.94
.turnin 12308 >>Turn in Escape from Silverbrook
.accept 12310 >>Accept A Swift Response
.goto Grizzly Hills,31.83,60.16
.target Woodsman Drake
.target Lieutenant Dumont
step
#sticky
#label SilverbrookH
.goto Grizzly Hills,35.6,68.1,0,0
>>Kill |cRXP_ENEMY_Silverbrook Hunters|r in the area
.complete 12310,1 
.mob Silverbrook Hunter
step
.goto Grizzly Hills,36.26,67.85
>>Travel to Forest's Edge Post
.use 36940 >>Kill |cRXP_ENEMY_Vladek|r. Loot him for his |cRXP_LOOT_Journal|r. Click |T133741:0|t[Mikhail's Journal] in your bags
.complete 12310,2 
.collect 36940,1,12105,1 
.accept 12105 >> Accept Descent into Darkness
.mob Vladek
step
#requires SilverbrookH
>>Return to Amberpine Lodge
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dumont|r and |cRXP_FRIENDLY_Thayreen|r
.turnin 12105 >>Turn in Descent into Darkness
.accept 12109 >>Accept Report to Gryan Stoutmantle... Again
.turnin 12310 >>Turn in A Swift Response
.goto Grizzly Hills,31.83,60.16
.accept 12219 >>Accept The Failed World Tree
.accept 12220 >>Accept A Dark Influence
.goto Grizzly Hills,31.16,59.47
.target Lieutenant Dumont
.target Hierophant Thayreen
step << skip
.goto Grizzly Hills,16.7,48.3
>>Ride to Granite Springs
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mack|r
.turnin 12038 >>Turn in Seared Scourge
.target Mack Fearsen
step
#completewith Tears
.goto Grizzly Hills,27.1,46.0,0
.goto Grizzly Hills,34.6,50.1,0
.goto Grizzly Hills,38.9,49.3,0
>>Kill |cRXP_ENEMY_Oozes|r at the parts of Vordrassil. Loot them for |cRXP_LOOT_Slime Samples|r
.complete 12219,1 
.mob Entropic Ooze
step
.goto Grizzly Hills,28.6,45.0,25,0
.goto Grizzly Hills,30.19,43.93
.use 37173 >>Enter the hole in the tree. Go down inside of it and use the |T134125:0|t[Geomancer's Orb] in your bags at the end
.complete 12220,3 
step
#label Tears
.goto Grizzly Hills,33.2,48.3,25,0
.goto Grizzly Hills,32.34,46.16
>>Leave the tree at Vordrassil's Tears
.use 37173 >>Enter the hole in the tree. Go down inside of it and use the |T134125:0|t[Geomancer's Orb] in your bags at the end
.complete 12220,2 
step
.goto Grizzly Hills,38.29,49.86,60,0
.goto Grizzly Hills,39.17,51.82,60,0
.goto Grizzly Hills,41.15,50.21,60,0
.goto Grizzly Hills,38.97,48.15
>>Leave the tree at Vordrassil's Limb
>>Kill |cRXP_ENEMY_Oozes|r at the parts of Vordrassil. Loot them for |cRXP_LOOT_Slime Samples|r
.complete 12219,1 
.mob Entropic Ooze
step
.goto Grizzly Hills,40.8,52.1,25,0
.goto Grizzly Hills,41.16,54.27
.use 37173 >>Enter the hole in the tree. Go down inside of it and use the |T134125:0|t[Geomancer's Orb] in your bags at the end
.complete 12220,1 
step
#completewith next
.goto Grizzly Hills,40.93,54.90
.goto Grizzly Hills,33.75,56.64,70 >> |cRXP_WARN_Jump onto the mushroom|r. |cRXP_WARN_Log out|r, |cRXP_WARN_then log back in|r
.link https://www.youtube.com/watch?v=f_RtIujejaI >> CLICK HERE for a guide
step
.goto Grizzly Hills,31.16,59.47
>>Return to Amberpine Lodge
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thayreen|r
.turnin 12219 >>Turn in The Failed World Tree
.turnin 12220 >>Turn in A Dark Influence
.accept 12246 >>Accept A Possible Link
.accept 12247 >>Accept Children of Ursoc
.target Hierophant Thayreen
step
#completewith next
.goto Grizzly Hills,53.1,55.4,0
>>Kill |cRXP_ENEMY_Furbolgs|r in the area. Loot them for their |cRXP_LOOT_Blood|r
.complete 12246,1 
.mob Frostpaw Warrior
.mob Frostpaw Shaman
step
.goto Grizzly Hills,48.37,58.40,30,0
.goto Grizzly Hills,48.07,58.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Orsonn|r in the cave of Rage Fang Shrine
.complete 12247,1 
.skipgossip
.target Orsonn
step
#completewith next
.goto Grizzly Hills,53.1,55.4,60,0
.goto Grizzly Hills,66.4,59.3,0
>>Kill |cRXP_ENEMY_Furbolgs|r in the area. Loot them for their |cRXP_LOOT_Blood|r
>>|cRXP_WARN_You will get the rest of the|r |cRXP_LOOT_Blood|r |cRXP_WARN_later|r
.complete 12246,1 
.mob Frostpaw Warrior
.mob Frostpaw Shaman
step
.goto Grizzly Hills,66.79,61.86,30,0
.goto Grizzly Hills,66.89,62.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kodian|r in the cave of Heart's Blood Shrine
.complete 12247,2 
.skipgossip
.target Kodian
step
.goto Grizzly Hills,66.5,53.5
>>Kill |cRXP_ENEMY_Furbolgs|r in the area. Loot them for their |cRXP_LOOT_Blood|r
.complete 12246,1 
.mob Redfang Elder
.mob Redfang Hunter
step << Druid
#completewith DruidTrain1
.cast 18960 >> Cast Teleport: Moonglade
.zoneskip Moonglade
.xp <74,1
step << Druid
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 53307 >> Train your class spells
.xp <74,1
.target Loganaar
step << Druid
#label DruidTrain1
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 48440 >> Train your class spells
.xp <75,1
.target Loganaar
step << DK
#completewith DKTrain1
.cast 50977 >> Cast Death Gate
.zoneskip Eastern Plaguelands
.xp <74,1
step << DK
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49929 >> Train your class spells
.xp <74,1
.target Amal'thazad
step << DK
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49923 >> Train your class spells
.xp <75,1
.target Amal'thazad
step << DK
#label DKTrain1
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49894 >> Train your class spells
.xp <76,1
.target Amal'thazad
step << Mage
#completewith MageTrain1
.zone Stormwind City >> Teleport to Stormwind
.xp <74,1
step << Mage
.goto Stormwind City,49.55,85.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42939 >> Train your class spells
.xp <74,1
.target Elsharin
.target Jennea Cannon
step << Mage
.goto Stormwind City,49.55,85.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42955 >> Train your class spells
.xp <75,1
.target Elsharin
.target Jennea Cannon
step << Mage
#label MageTrain1
.goto Stormwind City,49.55,85.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42920 >> Train your class spells
.xp <76,1
.target Elsharin
.target Jennea Cannon
step
#completewith next
.hs >> Hearth to Amberpine Lodge
step
.goto Grizzly Hills,31.16,59.47
>>Return to Amberpine Lodge
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thayreen|r
.turnin 12246 >>Turn in A Possible Link
.turnin 12247 >>Turn in Children of Ursoc
.accept 12248 >>Accept Vordrassil's Sapling
.accept 12250 >>Accept Vordrassil's Seeds
.target Hierophant Thayreen
step
#completewith next
.goto Grizzly Hills,52.6,46.1,0
.goto Grizzly Hills,54.1,41.8,0
.goto Grizzly Hills,52.9,38.1,0
>>Loot |cRXP_PICK_Seeds|r in but primarily outside of Vordrassil
.complete 12250,1 
step
.goto Grizzly Hills,50.5,46.0,45,0
.goto Grizzly Hills,50.7,42.9
.use 37306 >>Enter Vordrassil. |cRXP_WARN_Jump down to the bottom of the tree|r, then use the |T135432:0|t[Verdant Torch] at the bottom
.complete 12248,1 
step
.goto Grizzly Hills,52.6,46.1,60,0
.goto Grizzly Hills,54.1,41.8,60,0
.goto Grizzly Hills,52.9,38.1
>>Exit Vordrassil
>>Loot |cRXP_PICK_Seeds|r in but primarily outside of Vordrassil
.complete 12250,1 
step
#questguide
#completewith next
.hs >> Hearth to Amberpine Lodge
.cooldown item,6948,>2
step
#questguide
.goto Grizzly Hills,31.16,59.47
>>Return to Amberpine Lodge
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thayreen|r
.turnin 12248 >>Turn in Vordrassil's Sapling
.turnin 12250 >>Turn in Vordrassil's Seeds
.accept 12249 >>Accept Ursoc, the Bear God
.target Hierophant Thayreen
step
#questguide
#pvp
>>Travel to the Blue Sky Logging Grounds
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hartsman|r, |cRXP_FRIENDLY_Synipus|r, |cRXP_FRIENDLY_Pipthwack|r, and |cRXP_FRIENDLY_Rheanna|r
>>|cRXP_WARN_This quest|r (|cRXP_WARN_and keeping it in your questlog|r) |cRXP_WARN_flags you for PVP|r. |cRXP_WARN_Skip it if you wish|r
.accept 12289 >>Accept Kick 'Em While They're Down
.goto Grizzly Hills,39.36,43.87
.accept 12244 >>Accept Shredder Repair
.goto Grizzly Hills,39.54,43.57
.accept 12268 >>Accept Pieces Parts
.goto Grizzly Hills,39.64,43.38
.accept 12296 >>Accept Life or Death
.goto Grizzly Hills,40.47,42.66
.target Sergeant Hartsman
.target Synipus
.target Pipthwack
.target Rheanna
step
#questguide
#pvp
#completewith Dudes
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1
>>Loot the |cRXP_PICK_Cogs|r, |cRXP_PICK_Sprockets|r and |cRXP_PICK_Springs|r that you see in the area
.complete 12268,1 
.complete 12268,2 
.complete 12268,3 
.isOnQuest 12268
step
#questguide
#pvp
#completewith Infantry
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1
>>Kill |cRXP_ENEMY_Wounded Skirmishers|r (or |cRXP_ENEMY_Horde Players|r) in the area
.complete 12289,1 
.isOnQuest 12289
.mob Wounded Skirmisher
step
#questguide
#pvp
#completewith Engineer
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,39.6,43.5,0
>>Enter a |cRXP_FRIENDLY_Broken-down Shredder|r. Use |T136106:0|t"Overclock" (3) to run faster.
>>Take it back to |cRXP_FRIENDLY_Pipthwack|r and use |T134248:0|t"Shredder Delivery" (4).
.complete 12244,1 
.isOnQuest 12244
.target Broken-down Shredder
.target Pipthwack
step
#questguide
#pvp
#label Infantry
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1
.use 37576 >>Use the |T133686:0|t[Renewing Bandage] in your bags on |cRXP_FRIENDLY_Wounded Westfall Infantries|r. |cRXP_WARN_Focus on this|r. |cRXP_WARN_The quest item has a long cooldown|r
.complete 12296,1 
.isOnQuest 12296
.target Wounded Westfall Infantry
step
#questguide
#pvp
#label Dudes
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1
>>Kill |cRXP_ENEMY_Wounded Skirmishers|r (or |cRXP_ENEMY_Horde Players|r) in the area
.complete 12289,1 
.isOnQuest 12289
.mob Wounded Skirmisher
step
#questguide
#pvp
#label Engineer
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1
>>Loot the |cRXP_PICK_Cogs|r, |cRXP_PICK_Sprockets|r and |cRXP_PICK_Springs|r that you see in the area
.complete 12268,1 
.complete 12268,2 
.complete 12268,3 
.isOnQuest 12268
step
#questguide
#pvp
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,39.6,43.5
>>Enter a |cRXP_FRIENDLY_Broken-down Shredder|r. Use |T136106:0|t"Overclock" (3) to run faster.
>>Take it back to |cRXP_FRIENDLY_Pipthwack|r and use |T134248:0|t"Shredder Delivery" (4).
.complete 12244,1 
.isOnQuest 12244
.target Broken-down Shredder
.target Pipthwack
step
#questguide
#pvp
#label PiecesP
#completewith end
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pipthwack|r
.turnin 12268 >>Turn in Pieces Parts
.goto Grizzly Hills,39.64,43.38,-1
.isQuestComplete 12268
.target Pipthwack
step
#questguide
#pvp
#label ShredderR
#completewith end
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Synipus|r
.turnin 12244 >>Turn in Shredder Repair
.goto Grizzly Hills,39.54,43.57,-1
.isQuestComplete 12244
.target Synipus
step
#questguide
#pvp
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hartsman|r
.turnin 12289 >>Turn in Kick 'Em While They're Down
.goto Grizzly Hills,39.36,43.87,-1
.isQuestComplete 12289
.target Sergeant Hartsman
step
#questguide
#pvp
#requires ShredderR
step
#questguide
#pvp
#requires PiecesP
.goto Grizzly Hills,40.47,42.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rheanna|r
.turnin 12296 >>Turn in Life or Death
.isQuestComplete 12296
.target Rheanna
step
#questguide
#completewith end
>>Abandon the PVP quests you were unable to complete
.abandon 12268 >>Abandon Pieces Parts
.abandon 12244 >>Abandon Shredder Repair
.abandon 12289 >>Abandon Kick 'Em While They're Down
.abandon 12296 >>Abandon Life or Death
step
#questguide
.goto Grizzly Hills,38.1,32.0,30,0
.goto Grizzly Hills,36.95,32.36
>>|cRXP_WARN_Go up the tower in the water on the north-side of the Blue Sky Logging grounds|r
>>Go inside the little room at the top and loot the |cRXP_PICK_gem|r on the ground
.turnin 12042 >>Turn in Heart of the Ancients
.accept 12802 >>Accept My Heart is in Your Hands
step
#questguide
#completewith end
#label DesperateMojo
.goto Grizzly Hills,43.41,28.26,60,0
.goto Grizzly Hills,44.89,30.56,60,0
.goto Grizzly Hills,46.76,28.20,60,0
.goto Grizzly Hills,44.87,25.77
>>Kill the |cRXP_ENEMY_Drakkari Trolls|r in the area. Loot them for their |cRXP_LOOT_Mojo|r
>>|cRXP_ENEMY_Drakkari Witch Doctors|r |cRXP_WARN_do not drop it|r
.collect 36743,5 
.mob Drakkari Defender
.mob Injured Drakkari Refugee
step
#questguide
#requires DesperateMojo
.goto Grizzly Hills,45.00,28.36
>>Use |T134812:0|t[Drakuru's Elixir] at the Brazier
.use 35797 >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drakuru|r
.turnin 12802 >>Turn in My Heart is in Your Hands
.accept 12068 >>Accept Voices From the Dust
.target Drakuru
step
#questguide
.goto Grizzly Hills,49.20,34.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Emily|r inside. This starts an escort
.accept 12027 >>Accept Mr. Floppy's Perilous Adventure

.target Emily
step
#questguide
.goto Grizzly Hills,52.4,34.3,50,0
.goto Grizzly Hills,53.81,33.34
>>Escort |cRXP_FRIENDLY_Emily|r
.complete 12027,1 
.target Emily
step
#questguide
#Level 74
>>Travel to the Westfall Brigade Encampment
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Percy|r, |cRXP_FRIENDLY_Walter|r, and |cRXP_FRIENDLY_Gryan|r
.accept 12414 >>Accept Mounting Up
.goto Grizzly Hills,59.09,26.61
.turnin 12027 >>Turn in Mr. Floppy's Perilous Adventure
.goto Grizzly Hills,59.08,26.48
.turnin 12109 >>Turn in Report to Gryan Stoutmantle... Again
.accept 12158 >>Accept Hollowstone Mine
.accept 11998 >>Accept Softening the Blow
.accept 12770 >>Accept Reallocating Resources
.goto Grizzly Hills,59.42,26.00
.isQuestComplete 12027
.target Squire Percy
.target Squire Walter
.target Captain Gryan Stoutmantle
step
#questguide
>>Travel to the Westfall Brigade Encampment
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Percy|r, |cRXP_FRIENDLY_Walter|r, and |cRXP_FRIENDLY_Gryan|r
.accept 12414 >>Accept Mounting Up
.goto Grizzly Hills,59.09,26.61
.turnin 12027 >>Turn in Mr. Floppy's Perilous Adventure
.goto Grizzly Hills,59.08,26.48
.turnin 12109 >>Turn in Report to Gryan Stoutmantle... Again
.accept 12158 >>Accept Hollowstone Mine
.accept 11998 >>Accept Softening the Blow
.goto Grizzly Hills,59.42,26.00
.isQuestComplete 12027
.target Squire Percy
.target Squire Walter
.target Captain Gryan Stoutmantle
step
#questguide
#Level 74
>>Travel to the Westfall Brigade Encampment
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Percy|r and |cRXP_FRIENDLY_Gryan|r
.accept 12414 >>Accept Mounting Up
.goto Grizzly Hills,59.09,26.61
.turnin 12109 >>Turn in Report to Gryan Stoutmantle... Again
.accept 12158 >>Accept Hollowstone Mine
.accept 11998 >>Accept Softening the Blow
.accept 12770 >>Accept Reallocating Resources
.goto Grizzly Hills,59.42,26.00
.target Squire Percy
.target Captain Gryan Stoutmantle
step
#questguide
>>Travel to the Westfall Brigade Encampment
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Percy|r and |cRXP_FRIENDLY_Gryan|r
.accept 12414 >>Accept Mounting Up
.goto Grizzly Hills,59.09,26.61
.turnin 12109 >>Turn in Report to Gryan Stoutmantle... Again
.accept 12158 >>Accept Hollowstone Mine
.accept 11998 >>Accept Softening the Blow
.goto Grizzly Hills,59.42,26.00
.target Squire Percy
.target Captain Gryan Stoutmantle
step
#Level 74
>>Travel to the Westfall Brigade Encampment
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryan|r
.turnin 12109 >>Turn in Report to Gryan Stoutmantle... Again
.accept 12158 >>Accept Hollowstone Mine
.accept 11998 >>Accept Softening the Blow
.accept 12770 >>Accept Reallocating Resources
.goto Grizzly Hills,59.42,26.00
.target Captain Gryan Stoutmantle
step
>>Travel to the Westfall Brigade Encampment
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryan|r
.turnin 12109 >>Turn in Report to Gryan Stoutmantle... Again
.accept 12158 >>Accept Hollowstone Mine
.accept 11998 >>Accept Softening the Blow
.goto Grizzly Hills,59.42,26.00
.target Captain Gryan Stoutmantle
step
#completewith UMiners
.goto Grizzly Hills,59.56,26.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_McCarty|r
.home >> Set your Hearthstone to the Westfall Brigade Encampment
.target Quartermaster McCarty
step
.goto Grizzly Hills,59.89,26.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Samuel|r
.fp Westfall Brigade Encampment >> Get the Westfall Brigade Encampment flight path
.target Samuel Clearbook
step
#questguide
.goto Grizzly Hills,61.9,32.1,80,0
.goto Grizzly Hills,59.1,26.6,30,0
.goto Grizzly Hills,61.9,32.1,80,0
.goto Grizzly Hills,59.1,26.6,30,0
.goto Grizzly Hills,61.9,32.1,80,0
.goto Grizzly Hills,59.1,26.6,30,0
.goto Grizzly Hills,61.9,32.1,80,0
.goto Grizzly Hills,59.1,26.6,30,0
.goto Grizzly Hills,61.9,32.1,80,0
.goto Grizzly Hills,59.1,26.6,30,0
.goto Grizzly Hills,61.9,32.1
.use 37707 >>Loot a |cRXP_PICK_Wild Carrot|r scattered around the area for each |cRXP_FRIENDLY_Mustang|r you have to return
.use 37708 >>Equip the |T132932:0|t[Stick], then use it on a |cRXP_FRIENDLY_Highland Mustang|r - Ride it back to |cRXP_FRIENDLY_Squire Percy|r in the Westfall Bridge Encampment, then use |T132226:0|t"Hand Over Reins" (1). |cRXP_WARN_You can't loot carrots whilst mounted|r.
.complete 12414,1 
.target Highland Mustang
.target Squire Percy

step
#questguide
.goto Grizzly Hills,59.09,26.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Percy|r
.turnin 12414 >>Turn in Mounting Up
.target Squire Percy
step
#questguide
#completewith next
.goto Grizzly Hills,51.65,26.79,40,0
.goto Grizzly Hills,51.70,25.75,40,0
.goto Grizzly Hills,50.61,24.29,40 >> Travel up the road to |cRXP_FRIENDLY_Tur Ragepaw|r
step
#questguide
.goto Grizzly Hills,52.62,24.06,10,0
.goto Grizzly Hills,52.62,24.06,0
.goto Grizzly Hills,52.07,18.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tur Ragepaw|r
>>Select which role you want him to play while you kill |cRXP_ENEMY_Ursoc|r. |cRXP_WARN_Bear = Tank|r, |cRXP_WARN_Subdue = DPS|r, |cRXP_WARN_Healer = Healer|r
>>Follow him toward |cRXP_ENEMY_Ursoc|r. Kill |cRXP_ENEMY_Ursoc|r and the |cRXP_ENEMY_Blood|r when summoned
>>Use the |T133849:0|t[Purified Ashes of Vordrassil] on the corpse of |cRXP_ENEMY_Ursoc|r
>>|cRXP_WARN_This quest is difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him|r
.use 37307
.complete 12249,1 
.mob Ursoc
.mob Blood of the Old God
.isOnQuest 12249
step
.goto Grizzly Hills,55.13,23.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Petrov|r inside of Hollowstone Mine
.turnin 12158 >>Turn in Hollowstone Mine
.accept 12159 >>Accept Souls at Unrest
.target Petrov
step
#label UMiners
.goto Grizzly Hills,54.0,22.8,70,0
.goto Grizzly Hills,53.3,19.8
.use 37932 >>Kill |cRXP_ENEMY_Undead Miners|r. Use the |T134249:0|t[Miner's Lantern] in your bags on their corpses to put them to rest
.complete 12159,1 
.mob Undead Miner
step
.goto Grizzly Hills,55.13,23.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Petrov|r inside of Hollowstone Mine
.turnin 12159 >>Turn in Souls at Unrest
.accept 12160 >>Accept A Name from the Past
.target Petrov
step
>>Return to the Westfall Brigade Encampment
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryan|r and |cRXP_FRIENDLY_Arun|r
.turnin 12160 >>Turn in A Name from the Past
.goto Grizzly Hills,59.42,26.00
.accept 12161 >>Accept Ruuna the Blind
.goto Grizzly Hills,59.17,26.18
.target Captain Gryan Stoutmantle
.target Private Arun
step
.goto Grizzly Hills,44.04,47.94
>>Travel to Ruuna's Camp
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ruuna|r
.turnin 12161 >>Turn in Ruuna the Blind
.accept 12328 >>Accept Ruuna's Request
.target Ruuna the Blind
step
#pvp
>>Travel to the Blue Sky Logging Grounds
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hartsman|r, |cRXP_FRIENDLY_Synipus|r, |cRXP_FRIENDLY_Pipthwack|r, and |cRXP_FRIENDLY_Rheanna|r
>>|cRXP_WARN_This quest|r (|cRXP_WARN_and keeping it in your questlog|r) |cRXP_WARN_flags you for PVP|r. |cRXP_WARN_Skip it if you wish|r
.accept 12289 >>Accept Kick 'Em While They're Down
.goto Grizzly Hills,39.36,43.87
.accept 12244 >>Accept Shredder Repair
.goto Grizzly Hills,39.54,43.57
.accept 12268 >>Accept Pieces Parts
.goto Grizzly Hills,39.64,43.38
.accept 12296 >>Accept Life or Death
.goto Grizzly Hills,40.47,42.66
.target Sergeant Hartsman
.target Synipus
.target Pipthwack
.target Rheanna
step
#pvp
#completewith Dudes
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1
>>Loot the |cRXP_PICK_Cogs|r, |cRXP_PICK_Sprockets|r and |cRXP_PICK_Springs|r that you see in the area
.complete 12268,1 
.complete 12268,2 
.complete 12268,3 
.isOnQuest 12268
step
#pvp
#completewith Infantry
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1
>>Kill |cRXP_ENEMY_Wounded Skirmishers|r (or |cRXP_ENEMY_Horde Players|r) in the area
.complete 12289,1 
.isOnQuest 12289
.mob Wounded Skirmisher
step
#pvp
#completewith Engineer
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,39.6,43.5,0
>>Enter a |cRXP_FRIENDLY_Broken-down Shredder|r. Use |T136106:0|t"Overclock" (3) to run faster.
>>Take it back to |cRXP_FRIENDLY_Pipthwack|r and use |T134248:0|t"Shredder Delivery" (4).
.complete 12244,1 
.isOnQuest 12244
.target Broken-down Shredder
.target Pipthwack
step
#pvp
#label Infantry
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1
.use 37576 >>Use the |T133686:0|t[Renewing Bandage] in your bags on |cRXP_FRIENDLY_Wounded Westfall Infantries|r. |cRXP_WARN_Focus on this|r. |cRXP_WARN_The quest item has a long cooldown|r
.complete 12296,1 
.isOnQuest 12296
.target Wounded Westfall Infantry
step
#pvp
#label Dudes
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1
>>Kill |cRXP_ENEMY_Wounded Skirmishers|r (or |cRXP_ENEMY_Horde Players|r) in the area
.complete 12289,1 
.isOnQuest 12289
.mob Wounded Skirmisher
step
#pvp
#label Engineer
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1
>>Loot the |cRXP_PICK_Cogs|r, |cRXP_PICK_Sprockets|r and |cRXP_PICK_Springs|r that you see in the area
.complete 12268,1 
.complete 12268,2 
.complete 12268,3 
.isOnQuest 12268
step
#pvp
.goto Grizzly Hills,33.8,40.9,70,0
.goto Grizzly Hills,35.7,38.1,70,0
.goto Grizzly Hills,39.6,43.5
>>Enter a |cRXP_FRIENDLY_Broken-down Shredder|r. Use |T136106:0|t"Overclock" (3) to run faster.
>>Take it back to |cRXP_FRIENDLY_Pipthwack|r and use |T134248:0|t"Shredder Delivery" (4).
.complete 12244,1 
.isOnQuest 12244
.target Broken-down Shredder
.target Pipthwack
step
#pvp
#label PiecesP
#completewith end
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pipthwack|r
.turnin 12268 >>Turn in Pieces Parts
.goto Grizzly Hills,39.64,43.38,-1
.isQuestComplete 12268
.target Pipthwack
step
#pvp
#label ShredderR
#completewith end
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Synipus|r
.turnin 12244 >>Turn in Shredder Repair
.goto Grizzly Hills,39.54,43.57,-1
.isQuestComplete 12244
.target Synipus
step
#pvp
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hartsman|r
.turnin 12289 >>Turn in Kick 'Em While They're Down
.goto Grizzly Hills,39.36,43.87,-1
.isQuestComplete 12289
.target Sergeant Hartsman
step
#pvp
#requires ShredderR
step
#pvp
#requires PiecesP
.goto Grizzly Hills,40.47,42.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rheanna|r
.turnin 12296 >>Turn in Life or Death
.isQuestComplete 12296
.target Rheanna
step
#completewith end
>>Abandon the PVP quests you were unable to complete
.abandon 12268 >>Abandon Pieces Parts
.abandon 12244 >>Abandon Shredder Repair
.abandon 12289 >>Abandon Kick 'Em While They're Down
.abandon 12296 >>Abandon Life or Death
step
.goto Grizzly Hills,38.1,32.0,30,0
.goto Grizzly Hills,36.95,32.36
>>|cRXP_WARN_Go up the tower in the water on the north-side of the Blue Sky Logging grounds|r
>>Go inside the little room at the top and loot the |cRXP_PICK_gem|r on the ground
.turnin 12042 >>Turn in Heart of the Ancients
.accept 12802 >>Accept My Heart is in Your Hands
step
#completewith end
#label DesperateMojo2
.goto Grizzly Hills,43.41,28.26,60,0
.goto Grizzly Hills,44.89,30.56,60,0
.goto Grizzly Hills,46.76,28.20,60,0
.goto Grizzly Hills,44.87,25.77
>>Kill the |cRXP_ENEMY_Drakkari Trolls|r in the area. Loot them for their |cRXP_LOOT_Mojo|r
>>|cRXP_ENEMY_Drakkari Witch Doctors|r |cRXP_WARN_do not drop it|r
.collect 36743,5 
.mob Drakkari Defender
.mob Injured Drakkari Refugee
step
#requires DesperateMojo2
.goto Grizzly Hills,45.00,28.36
>>Use |T134812:0|t[Drakuru's Elixir] at the Brazier
.use 35797 >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drakuru|r
.turnin 12802 >>Turn in My Heart is in Your Hands
.accept 12068 >>Accept Voices From the Dust
.target Drakuru
step
.goto Grizzly Hills,52.1,29.7,70,0
.goto Grizzly Hills,46.5,40.8
>>Kill |cRXP_ENEMY_Fern Feeder Moths|r. Loot them for their |cRXP_LOOT_Dust|r
.complete 12328,1 
.mob Fern Feeder Moth
step
.goto Grizzly Hills,44.04,47.94
>>Travel to Ruuna's Camp
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ruuna|r
.turnin 12328 >>Turn in Ruuna's Request
.accept 12327 >>Accept Out of Body Experience
.target Ruuna the Blind
step
.goto Grizzly Hills,44.09,47.86
.use 37661 >>Use the |T134810:0|t[Gossamer Potion] at Ruuna's crystal ball in front of her. |cRXP_WARN_Wait out the RP event|r
.cast 49097
.timer 15,Out of Body Experience RP
.complete 12327,1 
step
.goto Grizzly Hills,44.04,47.94
>>Click off the |T135876:0|t"Out of Body Experience" buff
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ruuna|r
.turnin 12327 >>Turn in Out of Body Experience
.accept 12329 >>Accept Fate and Coincidence
.target Ruuna the Blind
step
.goto Grizzly Hills,57.52,41.26
>>Travel to the White Pine Trading Post
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sasha|r
.turnin 12329 >>Turn in Fate and Coincidence
.accept 12134 >>Accept Sasha's Hunt
.accept 12330 >>Accept Anatoly Will Talk
.target Sasha
step
.goto Grizzly Hills,61.46,42.89,60,0
.goto Grizzly Hills,62.40,41.46
>>Kill |cRXP_ENEMY_Solstice Hunters|r in the area. You can LoS them into buildings if needed (as they are ranged). |cRXP_WARN_Do NOT kill|r |cRXP_ENEMY_Tatjana|r
.complete 12134,1 
.mob Solstice Hunter
step
#completewith next
.goto Grizzly Hills,62.19,42.39
.vehicle >>Use the |T135660:0|t[Tranquilizer Dart] in your bags on |cRXP_ENEMY_Tatjana|r or the |cRXP_ENEMY_Horse|r
.timer 36,Tatjana Horse RP
>>Ride |cRXP_ENEMY_Tatjana's Horse|r back to |cRXP_FRIENDLY_Sasha|r
.use 37665
.mob Tatjana
.mob Tatjana's Horse
step
.goto Grizzly Hills,57.78,41.66
.use 37665 >> Ride |cRXP_ENEMY_Tatjana's Horse|r back to |cRXP_FRIENDLY_Sasha|r
.complete 12330,1 
step
.goto Grizzly Hills,57.52,41.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sasha|r
.turnin 12134 >>Turn in Sasha's Hunt
.turnin 12330 >>Turn in Anatoly Will Talk
.accept 12411 >>Accept A Sister's Pledge
.target Sasha
step
#questguide
.goto Grizzly Hills,65.7,43.3,25,0
.goto Grizzly Hills,64.80,43.41
>>Enter Duskhowl Den (|cRXP_WARN_the cave below the village|r)
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anya|r in the cage then |cRXP_FRIENDLY_Sasha|r when she runs into the cave
.turnin 12411 >>Turn in A Sister's Pledge
.goto Grizzly Hills,64.80,43.41
.accept 12164 >>Accept Hour of the Worg
.goto Grizzly Hills,64.94,43.43
.target Anya
.target Sasha
step
.goto Grizzly Hills,65.7,43.3,25,0
.goto Grizzly Hills,64.80,43.41
>>Enter Duskhowl Den (|cRXP_WARN_the cave below the village|r)
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anya|r in the cage
.turnin 12411 >>Turn in A Sister's Pledge
.target Anya
step
.goto Grizzly Hills,69.10,40.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hugh Glass|r
>>Buy a |T132621:0|tHowlin' Good Moonshine
.accept 12279 >>Accept A Bear of an Appetite

.complete 11998,1 
.target Hugh Glass
step
#completewith next
.hs >> Hearth back to the Westfall Brigade Encampment
.cooldown item,6948,>2
step
.goto Grizzly Hills,59.80,27.57
>>Return to the Westfall Brigade Encampment
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brugar|r
.turnin 11998 >>Turn in Softening the Blow
.accept 12002 >>Accept Brothers in Battle
.target Brugar Stoneshear
step
#completewith JournalX
.goto Grizzly Hills,63.3,22.9,0
.goto Grizzly Hills,65.9,23.6,0
>>Kill the |cRXP_ENEMY_Runic Battle Golems|r in the area
.complete 12002,1 
.mob Runic Battle Golem
step
.goto Grizzly Hills,63.68,23.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Fallen Earthen Warrior|r corpse on the ground
.accept 11981 >>Accept Find Kurun!
.target Fallen Earthen Warrior
step
#label JournalX
.goto Grizzly Hills,64.29,19.76
>>Loot the |cRXP_PICK_journal|r on the ground
.accept 11986 >>Accept The Damaged Journal
step
#completewith Golem
#label Pages
.goto Grizzly Hills,64.2,21.7,0
>>Loot |cRXP_PICK_8 Missing Journal Pages|r from the scrolls scattered on the ground throughout Thor Modan
.collect 35737,8,11986,1 
step
#completewith Golem
#label Journal
#requires Pages
.goto Grizzly Hills,64.2,21.7,0
.use 35739 >>Combine the Missing Journal Pages by clicking the |T133743:0|t[Incomplete Journal] in your inventory
.complete 11986,1 
step
#label Golem
.goto Grizzly Hills,63.3,22.9,60,0
.goto Grizzly Hills,65.9,23.6
>>Kill the |cRXP_ENEMY_Runic Battle Golems|r in the area
.complete 12002,1 
.mob Runic Battle Golem
step
#completewith next
#label MJPage
#loop
.line Grizzly Hills,64.19,20.00,62.95,22.18,63.39,26.41,65.02,26.37,65.90,22.87,64.19,20.00
.goto Grizzly Hills,64.19,20.00,45,0
.goto Grizzly Hills,62.95,22.18,45,0
.goto Grizzly Hills,63.39,26.41,45,0
.goto Grizzly Hills,65.02,26.37,45,0
.goto Grizzly Hills,65.90,22.87,45,0
.goto Grizzly Hills,64.19,20.00,45,0
>>Loot |cRXP_PICK_8 Missing Journal Pages|r from the scrolls scattered on the ground throughout Thor Modan
.collect 35737,8,11986,1 
step
#completewith next
.goto Grizzly Hills,59.80,27.57,0,0
.use 35739 >>Combine the Missing Journal Pages by clicking the |T133743:0|t[Incomplete Journal] in your inventory
.complete 11986,1 
step
#requires MJPage
>>Return to the Westfall Brigade Encampment
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torthen|r and |cRXP_FRIENDLY_Brugar|r
.turnin 11986 >>Turn in The Damaged Journal
.accept 11988 >>Accept The Runic Keystone
.goto Grizzly Hills,59.76,27.44
.turnin 12002 >>Turn in Brothers in Battle
.accept 12003 >>Accept Uncovering the Tunnels
.goto Grizzly Hills,59.80,27.57
.target Torthen Deepdig
.target Brugar Stoneshear
step
#completewith next
.goto Grizzly Hills,65.1,19.4,0
.goto Grizzly Hills,66.0,17.0,0
.goto Grizzly Hills,68.6,15.3,0
>>Kill |cRXP_ENEMY_Rune Dwarves|r in the area. Loot them for |cRXP_LOOT_Keystone Fragments|r
.complete 11988,1 
.mob Iron Rune-Shaper
.mob Rune Reaver
step
#label EastB
>>|cRXP_WARN_Go deep inside of the buildings in Thor Modan|r
.complete 12003,3 
.goto Grizzly Hills,63.37,28.60
.complete 12003,2 
.goto Grizzly Hills,66.79,24.57
.complete 12003,1 
.goto Grizzly Hills,62.64,20.67
step
.goto Grizzly Hills,65.1,19.4,70,0
.goto Grizzly Hills,66.0,17.0,70,0
.goto Grizzly Hills,68.6,15.3
>>Kill |cRXP_ENEMY_Rune Dwarves|r in the area. Loot them for |cRXP_LOOT_Keystone Fragments|r
.complete 11988,1 
.mob Iron Rune-Shaper
.mob Rune Reaver
step
>>Return to the Westfall Brigade Encampment
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torthen|r and |cRXP_FRIENDLY_Brugar|r
.turnin 11988 >>Turn in The Runic Keystone
.accept 11993 >>Accept The Runic Prophecies
.goto Grizzly Hills,59.76,27.44
.turnin 12003 >>Turn in Uncovering the Tunnels
.accept 12010 >>Accept The Fate of Orlond
.goto Grizzly Hills,59.80,27.57
.target Torthen Deepdig
.target Brugar Stoneshear
step
.groundgoto Grizzly Hills,61.5,18.3,100,0
.goto Grizzly Hills,65.77,17.78
>>Travel to top of the mountain |cRXP_WARN_ABOVE|r Thor Modan
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kurun|r
.turnin 11981 >>Turn in Find Kurun!
.accept 11982 >>Accept Raining Down Destruction
.target Kurun
step
.goto Grizzly Hills,65.34,13.06,20,0
.goto Grizzly Hills,67.43,12.42,20,0
>>Collect the |cRXP_PICK_glowing boulders|r on the ground
.collect 35734,5,11982,1,-1 
.use 35734 >>Throw a |T132384:0|t[Boulder] 5 times down onto an |cRXP_ENEMY_Iron Dwarf|r below (|cRXP_WARN_it can be the same|r |cRXP_ENEMY_Dwarf|r). Collect more |cRXP_PICK_Boulders|r if needed
.complete 11982,1 
.goto Grizzly Hills,67.76,14.89
.mob Iron Rune-Shaper
.mob Rune Reaver
step
.goto Grizzly Hills,65.77,17.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kurun|r
.turnin 11982 >>Turn in Raining Down Destruction
.accept 12070 >>Accept Rallying the Troops
.target Kurun
step
.goto Grizzly Hills,67.37,10.52,60,0
.goto Grizzly Hills,70.41,8.54,60,0
.goto Grizzly Hills,69.99,3.76
.use 36764 >>Go up to a |cRXP_FRIENDLY_Grizzly Hills Giant|r and use the |T133451:0|t[Shard of the Earth] in your bags on them. Kill the |cRXP_ENEMY_Iron Rune Avengers|r that spawn
.complete 12070,1 
.complete 12070,2 
.target Grizzly Hills Giant
.mob Iron Rune Avenger
step
.goto Grizzly Hills,65.77,17.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kurun|r
.turnin 12070 >>Turn in Rallying the Troops
.accept 11985 >>Accept Into the Breach
.target Kurun
step
.goto Grizzly Hills,67.50,15.27
>>|cRXP_WARN_Carefully jump down into Thor Modan|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the corpse of |cRXP_FRIENDLY_Surveyor Orlond|r
.turnin 12010 >>Turn in The Fate of Orlond
.accept 12014 >>Accept Steady as a Rock?
.target Surveyor Orlond
step
#completewith next
.goto Grizzly Hills,67.5,15.5,0
>>Kill |cRXP_ENEMY_Threshadons|r in the water. Loot them for the |cRXP_LOOT_Portable Seismograph|r
.complete 12014,2 
.mob Subterranean Thresher
step
>>|cRXP_WARN_Click the letters on the wall to read the prophecies|r
.complete 11993,3 
.goto Grizzly Hills,68.52,16.21
.complete 11993,1 
.goto Grizzly Hills,68.99,14.43
step
#completewith end
#label Secondpr
.goto Grizzly Hills,70.18,14.68,0,0
>>|cRXP_WARN_Click the letters on the wall to read the prophecy|r
.complete 11993,2 
step
.goto Grizzly Hills,70.0,14.0,20,0
.goto Grizzly Hills,67.5,15.5
>>Kill |cRXP_ENEMY_Threshadons|r in the water. Loot them for the |cRXP_LOOT_Portable Seismograph|r
.complete 12014,2 
.mob Subterranean Thresher
step
#completewith end
#label Argrum
.goto Grizzly Hills,70.21,12.93,0,0
>>Kill |cRXP_ENEMY_Iron Thane Argrum|r
.complete 11985,1 
.mob Iron Thane Argrum
step
.goto Grizzly Hills,70.61,13.38
.use 35837 >>Use the |T133870:0|t[Portable Seismograph] in your bags near the bridge. Loot the |cRXP_PICK_Stability Profile|r after placing the Seismograph
.complete 12014,1 
step
#requires Argrum
.groundgoto Grizzly Hills,65.1,19.5,40,0
.groundgoto Grizzly Hills,60.9,19.8,70,0
.goto Grizzly Hills,65.77,17.78
>>Leave Thor Modan
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kurun|r
.turnin 11985 >>Turn in Into the Breach
.accept 12081 >>Accept Gavrock
.target Kurun
step
#completewith Prophecies
.hs >> Hearth to Westfall Brigade Encampment
.cooldown item,6948,>2
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryan|r
.goto Grizzly Hills,59.42,26.00
.accept 12770 >>Accept Reallocating Resources
.target Captain Gryan Stoutmantle
step
#label Prophecies
>>Return to the Westfall Brigade Encampment
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Torthen|r and |cRXP_FRIENDLY_Brugar|r
.turnin 11993 >>Turn in The Runic Prophecies
.goto Grizzly Hills,59.76,27.44
.turnin 12014 >>Turn in Steady as a Rock?
.accept 12128 >>Accept Check Up on Raegar
.goto Grizzly Hills,59.80,27.57
.target Torthen Deepdig
.target Brugar Stoneshear
step
>>Travel to Harkor's Camp
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harkor|r and |cRXP_FRIENDLY_Kraz|r
.turnin 12190 >>Turn in Say Hello to My Little Friend
.accept 12113 >>Accept Nice to Meat You
.accept 12114 >>Accept Therapy
.goto Grizzly Hills,73.77,34.02
.accept 12116 >>Accept It Takes Guts....
.goto Grizzly Hills,73.91,34.12
.target Harkor
.target Kraz
step
#completewith Gavrock12
.goto Grizzly Hills,72.5,33.1,0
.goto Grizzly Hills,65.8,33.3,0
.goto Grizzly Hills,68.8,32.9,0
.goto Grizzly Hills,75.8,39.2,0
>>Kill |cRXP_ENEMY_Shovelhorns|r and |cRXP_ENEMY_Prowlers|r in the area. Loot them for their |cRXP_LOOT_Steaks|r and |cRXP_LOOT_Meat|r
.complete 12113,1 
.complete 12113,2 
.mob Longhoof Grazer
.mob Duskhowl Prowler
step
#completewith next
.cast 43308 >> Cast Find Fish to track the Northern Salmon schools
.spellmissing 43308
step
#completewith next
.goto Grizzly Hills,81.1,36.3,0
.use 37542 >>Use the |T134325:0|t[Fishing Net] in your bags on the schools of |cRXP_PICK_Northern Salmon|r fish
.complete 12279,1 
step
#label Gavrock12
.goto Grizzly Hills,79.76,33.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gavrock|r on the island
.turnin 12081 >>Turn in Gavrock
.accept 12093 >>Accept Runes of Compulsion
.target Gavrock
step
#questguide
>>Travel to Bloodmoon Isle. Kill |cRXP_ENEMY_Selas|r and |cRXP_ENEMY_Varlam|r
.complete 12164,2 
.goto Grizzly Hills,85.94,27.91
.complete 12164,1 
.goto Grizzly Hills,84.91,23.31
.isOnQuest 12164
.mob Selas
.mob Varlam

step
#questguide
.groundgoto Grizzly Hills,86.34,23.88,40,0
.groundgoto Grizzly Hills,86.5,26.8,20,0
.goto Grizzly Hills,86.96,26.50
>>Follow the path up and then to the side of the keep. Kill |cRXP_ENEMY_Goremaw|r
.complete 12164,3 
.unitscan Goremaw
step
#questguide
.groundgoto Grizzly Hills,86.82,25.85,15,0
.goto Grizzly Hills,87.65,26.48
>>Enter Shadowfang Tower. Go to the top, then kill |cRXP_ENEMY_Arugal|r
.complete 12164,4 
.mob Shade of Arugal
step
#completewith CJars
.goto Grizzly Hills,72.5,33.1,0
.goto Grizzly Hills,65.8,33.3,0
.goto Grizzly Hills,68.8,32.9,0
.goto Grizzly Hills,75.8,39.2,0
>>Kill |cRXP_ENEMY_Shovelhorns|r and |cRXP_ENEMY_Prowlers|r in the area. Loot them for their |cRXP_LOOT_Steaks|r and |cRXP_LOOT_Meat|r
.complete 12113,1 
.complete 12113,2 
.mob Longhoof Grazer
.mob Duskhowl Prowler
step
#completewith next
.goto Grizzly Hills,81.1,36.3,0
.use 37542 >>Use the |T134325:0|t[Fishing Net] in your bags on the schools of |cRXP_PICK_Northern Salmon|r fish
.complete 12279,1 
step
.goto Grizzly Hills,75.03,37.18
>>Kill the |cRXP_ENEMY_Iron Rune-Weavers|r around the purple circle. Kill |cRXP_ENEMY_Overseer Lochli|r when he spawns.
.complete 12093,3 
.mob Iron Rune-Weaver
.mob Overseer Lochli
step
.goto Grizzly Hills,71.85,34.26
>>Kill the |cRXP_ENEMY_Iron Rune-Weavers|r around the purple circle. Kill |cRXP_ENEMY_Overseer Korgan|r when he spawns.
.complete 12093,2 
.mob Iron Rune-Weaver
.mob Overseer Korgan
step
.goto Grizzly Hills,67.52,29.46
>>Kill the |cRXP_ENEMY_Iron Rune-Weavers|r around the purple circle. Kill |cRXP_ENEMY_Overseer Durval|r when he spawns.
.complete 12093,1 
.mob Iron Rune-Weaver
.mob Overseer Durval
step
.goto Grizzly Hills,78.79,43.70
>>Kill the |cRXP_ENEMY_Iron Rune-Weavers|r around the purple circle. Kill |cRXP_ENEMY_Overseer Brunon|r when he spawns.
.complete 12093,4 
.mob Iron Rune-Weaver
.mob Overseer Brunon
step
#completewith Stones3
.goto Grizzly Hills,81.1,36.3,0
.use 37542 >>Use the |T134325:0|t[Fishing Net] in your bags on the schools of |cRXP_PICK_Northern Salmon|r fish
.complete 12279,1 
step
.goto Grizzly Hills,79.76,33.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gavrock|r
.turnin 12093 >>Turn in Runes of Compulsion
.accept 12094 >>Accept Latent Power
.target Gavrock
step
#label Stones3
.use 36787 >>Use the |T134562:0|t[Shard of Gavrock] on the |cRXP_PICK_blue glowing stones|r around eastern Grizzly Hills
.complete 12094,1 
.goto Grizzly Hills,71.25,39.73
step
.use 36787 >>Use the |T134562:0|t[Shard of Gavrock] on the |cRXP_PICK_blue glowing stones|r around eastern Grizzly Hills
.complete 12094,3 
.goto Grizzly Hills,74.08,44.23
step
#completewith Gavrock4
.goto Grizzly Hills,81.1,36.3,0
.use 37542 >>Use the |T134325:0|t[Fishing Net] in your bags on the schools of |cRXP_PICK_Northern Salmon|r fish
.complete 12279,1 
step
.use 36787 >>Use the |T134562:0|t[Shard of Gavrock] on the |cRXP_PICK_blue glowing stones|r around eastern Grizzly Hills
.complete 12094,2 
.goto Grizzly Hills,78.88,39.97
step
#label Gavrock4
.goto Grizzly Hills,79.76,33.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gavrock|r
.turnin 12094 >>Turn in Latent Power
.accept 12099 >>Accept Free at Last
.target Gavrock
step
.goto Grizzly Hills,75.48,34.51,60,0
.goto Grizzly Hills,77.85,37.64,60,0
.goto Grizzly Hills,80.04,38.56,60,0
.goto Grizzly Hills,81.59,37.94,60,0
.goto Grizzly Hills,81.35,45.70,60,0
.goto Grizzly Hills,75.48,34.51
.use 37542 >>Use the |T134325:0|t[Fishing Net] in your bags on the schools of |cRXP_PICK_Northern Salmon|r fish
.complete 12279,1 
step
.goto Grizzly Hills,76.1,41.4,70,0
.goto Grizzly Hills,66.4,29.7
.use 36796 >>Use |T134397:0|t[Gavrock's Runebreaker] in your bags on a |cRXP_ENEMY_Runed Giant|r. |cRXP_WARN_If it fails and the giant is still hostile|r, |cRXP_WARN_use it on it again|r (|cRXP_WARN_until it becomes|r |cRXP_FRIENDLY_friendly|r). |cRXP_WARN_Kill mobs or complete other objectives whilst waiting for the item cooldown|r
.complete 12099,1 
.mob Runed Giant
step
.goto Grizzly Hills,69.10,40.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hugh Glass|r
.turnin 12279 >>Turn in A Bear of an Appetite
.target Hugh Glass
step
#questguide
.goto Grizzly Hills,57.5,41.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sasha|r
.turnin 12164 >>Turn in Hour of the Worg
.isQuestComplete 12164
.target Sasha
step
#completewith next
.abandon 12164 >>Abandon Hour of the Worg
step
.goto Grizzly Hills,79.76,33.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gavrock|r
.turnin 12099 >>Turn in Free at Last
.target Gavrock
step
#completewith next
.goto Grizzly Hills,73.0,24.6,0
.goto Grizzly Hills,72.6,26.8,0
.goto Grizzly Hills,70.1,26.7,0
.goto Grizzly Hills,70.2,23.5,0
>>Kill |cRXP_ENEMY_Drakkari Oracles|r and |cRXP_ENEMY_Protectors|r in the area. Loot them for their |cRXP_LOOT_Mojo|r
.complete 12114,1 
.complete 12114,2 
.collect 36758,5,12120,1 
.mob Drakkari Oracle
.mob Drakkari Protector
step
#label CJars
.goto Grizzly Hills,71.4,22.9,30,0
.goto Grizzly Hills,71.2,21.4,30,0
.goto Grizzly Hills,70.7,19.1
>>Enter the Drakil'jin ruins
>>Loot the |cRXP_PICK_Drakkari Canopic Jars|r in the room full of spirits. |cRXP_WARN_Try to loot them all at once so you don't aggro more than 1 spirit|r
.complete 12116,1 
step
.goto Grizzly Hills,69.49,17.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harrison Jones|r in the cage. Start his escort
.accept 12082 >>Accept Dun-da-Dun-tah!
.timer 107,Campfire Room Closes
.target Harrison Jones
step
.goto Grizzly Hills,69.37,18.23
>>|cRXP_WARN_Quickly loot the|r |cRXP_PICK_Drakkari tablet|r |cRXP_WARN_in the same room that the cage is in before the campfire room closes|r
.complete 12068,1 
step
#completewith next
.goto Grizzly Hills,73.0,24.6,0
.goto Grizzly Hills,72.6,26.8,0
.goto Grizzly Hills,70.1,26.7,0
.goto Grizzly Hills,70.2,23.5,0
>>Kill |cRXP_ENEMY_Drakkari Oracles|r and |cRXP_ENEMY_Protectors|r in the area. Loot them for their |cRXP_LOOT_Mojo|r
.complete 12114,1 
.complete 12114,2 
.collect 36758,5,12120,1 
.mob Drakkari Oracle
.mob Drakkari Protector
step
#label Harrison
.goto Grizzly Hills,70.5,17.7,25,0
.goto Grizzly Hills,73.52,24.02
>>|cRXP_WARN_Stay in the bonfire room for the |cRXP_ENEMY_Snake|r event|r. Focus on killing the adds whilst |cRXP_FRIENDLY_Harrison|r builds threat on the |cRXP_ENEMY_Snake|r. After the adds are dead, kill the |cRXP_ENEMY_Snake|r (|cRXP_WARN_You can just kill the|r |cRXP_ENEMY_Snake|r |cRXP_WARN_if you're strong enough|r)
>>|cRXP_WARN_Follow|r |cRXP_FRIENDLY_Harrison|r |cRXP_WARN_out of the ruins|r
.complete 12082,1 
.target Harrison Jones
.mob Tecahuna
step
.goto Grizzly Hills,73.0,24.6,70,0
.goto Grizzly Hills,72.6,26.8,70,0
.goto Grizzly Hills,70.1,26.7,70,0
.goto Grizzly Hills,73.0,24.6,70,0
.goto Grizzly Hills,72.6,26.8,70,0
.goto Grizzly Hills,70.1,26.7,70,0
.goto Grizzly Hills,70.2,23.5
>>Kill |cRXP_ENEMY_Drakkari Oracles|r and |cRXP_ENEMY_Protectors|r in the area. Loot them for their |cRXP_LOOT_Mojo|r
.complete 12114,1 
.complete 12114,2 
.collect 36758,5,12120,1 
.mob Drakkari Oracle
.mob Drakkari Protector
step
#completewith next
.goto Grizzly Hills,68.8,32.9,0
.goto Grizzly Hills,75.8,39.2,0
>>Kill |cRXP_ENEMY_Shovelhorns|r in the area. Loot them for their |cRXP_LOOT_Steaks|r
.complete 12113,2 
.mob Longhoof Grazer
step
.goto Grizzly Hills,72.5,33.1,60,0
.goto Grizzly Hills,65.8,33.3
>>Kill |cRXP_ENEMY_Prowlers|r in the area. Loot them for their |cRXP_LOOT_Meat|r
.complete 12113,1 
.mob Duskhowl Prowler
step
.goto Grizzly Hills,68.84,32.96,60,0
.goto Grizzly Hills,77.90,43.10,60,0
.goto Grizzly Hills,78.40,39.37,60,0
.goto Grizzly Hills,69.64,38.64
>>Kill |cRXP_ENEMY_Shovelhorns|r in the area. Loot them for their |cRXP_LOOT_Steaks|r
.complete 12113,2 
.mob Longhoof Grazer
step
>>Return to Harkor's Camp
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harkor|r and |cRXP_FRIENDLY_Kraz|r
.turnin 12113 >>Turn in Nice to Meat You
.turnin 12082 >>Turn in Dun-da-Dun-tah!
.turnin 12114 >>Turn in Therapy
.goto Grizzly Hills,73.77,34.02,-1
.turnin 12116 >>Turn in It Takes Guts....
.accept 12120 >>Accept Drak'aguul's Mallet
.goto Grizzly Hills,73.91,34.12,-1
.target Harkor
.target Kraz
step
.goto Grizzly Hills,71.54,29.78,50,0
.goto Grizzly Hills,73.69,29.72
.line Grizzly Hills,71.54,29.78,,73.69,29.72
>>Kill |cRXP_ENEMY_Drak'aguul|r. Loot him for his |cRXP_LOOT_Mallet|r
.complete 12120,1 
.unitscan Drak'aguul
step
.goto Grizzly Hills,73.91,34.12
>>Return to Harkor's Camp
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kraz|r
.turnin 12120 >>Turn in Drak'aguul's Mallet
.accept 12121 >>Accept See You on the Other Side
.target Kraz
step
.goto Grizzly Hills,71.74,26.20
>>Go to the Brazier (|cRXP_WARN_NOT the fire surrounded by the 3 gongs|r). Use |T134812:0|t[Drakuru's Elixir]
.use 35797 >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drakuru|r
.turnin 12068 >>Turn in Voices From the Dust

.target Drakuru
step
.goto Grizzly Hills,71.41,24.55
.use 36834 >>Go to the 3 gongs at Drakil'jin ruins. Use the |T133474:0|t[Charged Drakil'jin Mallet] in your bags
.cast 47701
.timer 13,See You on the Other Side RP
.complete 12121,1 
step
.goto Grizzly Hills,71.4,22.9,30,0
.goto Grizzly Hills,71.2,21.4,30,0
.goto Grizzly Hills,69.41,19.48
>>Enter the Drakil'jin Ruins (|cRXP_WARN_You CAN cast spells in the ghost form|r)
>>Go into the main room just before the one you escorted |cRXP_FRIENDLY_Harrison|r out of
.use 36834 >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gan'jo|r. (|cRXP_WARN_Use the Gong again if you somehow lose the|r |T132094:0|t"On the Other Side" |cRXP_WARN_buff|r)
.link /console ffxDeath 0 >>If you can't see because of the ghost effect, copy paste this command (Click here), then type /reload
.turnin 12121 >>Turn in See You on the Other Side
.accept 12137 >>Accept Chill Out, Mon
.target Gan'jo
step
.goto Grizzly Hills,69.36,19.57
>>Loot the |cRXP_PICK_green chest|r inside the mini water fountain-like structure
.complete 12137,1 
step
.goto Grizzly Hills,69.41,19.48,9,0
.goto Grizzly Hills,71.4,19.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gan'jo|r again. |cRXP_WARN_Ask him to return you to the world of the living|r
.use 36859 >>Use the |T133850:0|t[Snow of Eternal Slumber] on the |cRXP_ENEMY_Ancient Drakkaris|r in the room you got the jars from, then loot the |cRXP_PICK_Mummys|r that they run to
.complete 12137,2 
.skipgossip
.target Gan'jo
.mob Ancient Drakkari Soothsayer
.mob Ancient Drakkari Warmonger
step
.goto Grizzly Hills,73.91,34.12
>>Return to Harkor's Camp
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kraz|r
.turnin 12137 >>Turn in Chill Out, Mon
.accept 12152 >>Accept Jin'arrak's End
.target Kraz
step
#completewith end
#label SacreD
.goto Grizzly Hills,71.4,22.9,30,0
.goto Grizzly Hills,71.2,21.4,30,0
.goto Grizzly Hills,71.25,19.66
>>Enter the Drakil'jin Ruins
>>Loot the |cRXP_PICK_bowl of fruit|r on the north-east wall of the room
.collect 36870,1 
step
#requires SacreD
#completewith next
.goto Grizzly Hills,71.4,22.9,30,0
.goto Grizzly Hills,71.41,24.55
.use 36873 >>Use the |T132123:0|t[Drakkari Spirit Dust] in your inventory to make the |T134056:0|tInfused Drakkari Offering
.collect 37063,1 
step
#requires SacreD
.goto Grizzly Hills,71.41,24.55
.use 37063 >>Go back to the 3 gongs just outside of the Drakil'jin Ruins. Use the |T134056:0|t[Infused Drakkari Offering]
.complete 12152,1 
step
.goto Grizzly Hills,73.91,34.12
>>Return to Harkor's Camp
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kraz|r
.turnin 12152 >>Turn in Jin'arrak's End
.target Kraz
step
>>Travel to Prospector's Point
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kilian|r and |cRXP_FRIENDLY_Raegar|r
.turnin 12128 >>Turn in Check Up on Raegar
.accept 12129 >>Accept The Perfect Plan
.goto Grizzly Hills,77.09,48.64
.accept 12180 >>Accept The Captive Prospectors
.goto Grizzly Hills,76.97,48.44
.target Mountaineer Kilian
.target Raegar Breakbrow
step
#completewith Varana
#label Blueprints
.goto Grizzly Hills,81.5,60.3,0
.goto Grizzly Hills,76.3,62.9,0
.goto Grizzly Hills,75.0,57.0,0
>>Kill |cRXP_ENEMY_Iron Rune-Smiths|r in the area. Loot them for the |cRXP_LOOT_Golem Blueprints|r
.collect 36849,1,12129,1 
.collect 36850,1,12129,1 
.collect 36851,1,12129,1 
.mob Iron Rune-Smith
step
#completewith next
#requires Blueprints
.use 36849 >>Click on any of the |T134331:0|t[Golem Blueprint Sections] in your bags to combine them into the |T134332:0|tWar Golem Blueprint
.complete 12129,1 
step
#label Varana
>>Kill |cRXP_ENEMY_Overseers|r, |cRXP_ENEMY_War Golems|r, and |cRXP_ENEMY_Sentries|r. Loot them for |cRXP_LOOT_Dun Argol Cage Keys|r
>>Use the |cRXP_LOOT_Keys|r to free |cRXP_FRIENDLY_Prospector Gann|r inside the cage in the building, |cRXP_FRIENDLY_Prospector Torgan|r outside, and |cRXP_FRIENDLY_Prospector Varana|r outside
.collect 37013,3,12180,7,-1 
.complete 12180,1 
.goto Grizzly Hills,76.46,55.43
.complete 12180,2 
.goto Grizzly Hills,76.35,58.53
.complete 12180,3 
.goto Grizzly Hills,76.06,61.07
.mob Iron Rune Overseer
.mob Runic Lightning Gunner
.mob Runic War Golem
.mob Lightning Sentry
.target Prospector Gann
.target Prospector Torgan
.target Prospector Varana
step
.goto Grizzly Hills,76.68,63.62,30,0
.goto Grizzly Hills,76.77,58.73,30,0
.goto Grizzly Hills,75.19,57.22,30,0
.goto Grizzly Hills,76.56,55.09
>>Kill |cRXP_ENEMY_Iron Rune-Smiths|r in the area. Loot them for the |cRXP_LOOT_Golem Blueprints|r
.collect 36849,1,12129,1 
.collect 36850,1,12129,1 
.collect 36851,1,12129,1 
.mob Iron Rune-Smith
step
.goto Grizzly Hills,77.09,48.64
.use 36849 >>Click on any of the |T134331:0|t[Golem Blueprint Sections] in your bags to combine them into the |T134332:0|tWar Golem Blueprint
.complete 12129,1 
step
>>Travel to Prospector's Point
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Raegar|r and |cRXP_FRIENDLY_Kilian|r
.turnin 12129 >>Turn in The Perfect Plan
.accept 12130 >>Accept Why Fabricate When You Can Appropriate?
.goto Grizzly Hills,77.09,48.64
.turnin 12180 >>Turn in The Captive Prospectors
.accept 12183 >>Accept Looking the Part
.goto Grizzly Hills,76.97,48.44
.target Raegar Breakbrow
.target Mountaineer Kilian
step
#completewith next
.goto Grizzly Hills,76.2,62.8,0
>>Loot the |cRXP_PICK_War Golem Parts|r mainly scattered throughout the main building of Dun Argol's middle and top floors. |cRXP_WARN_DO NOT go downstairs|r
.complete 12130,1 
step
.goto Grizzly Hills,75.99,57.88,30,0
.goto Grizzly Hills,77.81,59.06,30,0
.goto Grizzly Hills,79.13,59.52
>>Kill an |cRXP_ENEMY_Iron Rune Overseer|r. Loot him for his |cRXP_LOOT_Uniform|r
.complete 12183,1 
.mob Iron Rune Overseer
step
.goto Grizzly Hills,75.77,57.02,40,0
.goto Grizzly Hills,75.49,58.20,40,0
.goto Grizzly Hills,73.56,60.02,40,0
.goto Grizzly Hills,76.18,62.77,30,0
.goto Grizzly Hills,77.07,62.52,30,0
.goto Grizzly Hills,75.90,63.94,30,0
.goto Grizzly Hills,75.99,57.88
>>Loot the |cRXP_PICK_War Golem Parts|r mainly scattered throughout the main building of Dun Argol's middle and top floors. |cRXP_WARN_DO NOT go downstairs|r
.complete 12130,1 
step
>>Return to Prospector's Point
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Raegar|r and |cRXP_FRIENDLY_Kilian|r
.turnin 12130 >>Turn in Why Fabricate When You Can Appropriate?
.accept 12131 >>Accept We Have the Power
.goto Grizzly Hills,77.09,48.64
.turnin 12183 >>Turn in Looking the Part
.accept 12184 >>Accept Cultivating an Image
.goto Grizzly Hills,76.97,48.44
.target Raegar Breakbrow
.target Mountaineer Kilian
step
#completewith next
.goto Grizzly Hills,76.2,62.8,0
.use 37045 >>Kill |cRXP_ENEMY_Iron Dwarves|r in Dun Argol. Use |T134442:0|t[Kilian's Camera] in your bags on their corpses
.complete 12184,1 
.mob Iron Rune Overseer
.mob Iron Rune-Smith
.mob Runic Lightning Gunner
step
>>Go inside either building
>>Kill |cRXP_ENEMY_Rune-Smith Durar|r and |cRXP_ENEMY_Rune-Smith Kalthorn|r. Loot them for their |cRXP_LOOT_Power Cells|r
.complete 12131,1 
.goto Grizzly Hills,74.89,56.91,-1
.complete 12131,2 
.goto Grizzly Hills,76.83,59.35,-1
.mob Rune-Smith Durar
.mob Rune-Smith Kathorn
step
.goto Grizzly Hills,76.52,55.06,30,0
.goto Grizzly Hills,76.68,63.61
.use 37045 >>Kill |cRXP_ENEMY_Iron Dwarves|r in Dun Argol. Use |T134442:0|t[Kilian's Camera] in your bags on their corpses
.complete 12184,1 
.mob Iron Rune Overseer
.mob Iron Rune-Smith
.mob Runic Lightning Gunner
step
>>Return to Prospector's Point
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Raegar|r and |cRXP_FRIENDLY_Kilian|r
.turnin 12131 >>Turn in We Have the Power
.accept 12138 >>Accept ... Or Maybe We Don't
.goto Grizzly Hills,77.09,48.64
.turnin 12184 >>Turn in Cultivating an Image
.accept 12185 >>Accept Put on Your Best Face for Loken
.goto Grizzly Hills,76.97,48.44
.target Raegar Breakbrow
.target Mountaineer Kilian
step
.goto Grizzly Hills,75.55,50.72,60,0
.goto Grizzly Hills,73.21,51.94,60,0
.goto Grizzly Hills,73.30,57.38
.use 36936 >>Use the |T133015:0|t[Golem Control Unit] in your bags. Kill |cRXP_ENEMY_Lightning Sentries|r with the |cRXP_FRIENDLY_Depleted War Golem|r out (|cRXP_WARN_within 30 yards or less|r) and then wait for it (|cRXP_WARN_again|r, |cRXP_WARN_within 30 yards or less|r) to collect the |cRXP_PICK_Sentry's Charge|r
>>Be careful, as the |cRXP_ENEMY_Lightning Sentries|r are Nature immune << Shaman/Druid
.complete 12138,1 
.mob Lightning Sentry
step
#completewith next
.cast 48064 >> Mount up, then use the |T133665:0|t[Overseer Disguise Kit] in your bags.
step
.groundgoto Grizzly Hills,78.20,59.20,60,0
.goto Grizzly Hills,81.60,60.34
.cast 3365 >>|cRXP_WARN_Do NOT cast any spells whilst disguised|r. Ride to the easternmost building and click on |cRXP_PICK_Loken's Pedestal|r. |cRXP_WARN_Do NOT wait out the RP event|r
.timer 24,Message from Loken RP

.use 37071
step
>>Return to Prospector's Point
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Raegar|r and |cRXP_FRIENDLY_Kilian|r
.turnin 12138 >>Turn in ... Or Maybe We Don't
.accept 12153 >>Accept The Iron Thane and His Anvil
.accept 12154 >>Accept Blackout
.goto Grizzly Hills,77.09,48.64
.turnin 12185 >>Turn in Put on Your Best Face for Loken
.goto Grizzly Hills,76.97,48.44
.target Raegar Breakbrow
.target Mountaineer Kilian
step
#completewith next
.goto Grizzly Hills,75.95,63.28
.vehicle >>Travel to the top building and take the elevator down to the bottom floor. Use the |T133015:0|t[Golem Control Unit]
.use 36865
step
>>Use |T136099:0|t"EMP" (2) to remove |cRXP_ENEMY_Furyhammer's|r invulnerability and stun |cRXP_ENEMY_The Anvil|r. Spam |T136049:0|t"Charged Smash" (1) and right click him to kill |cRXP_ENEMY_Furyhammer|r
.complete 12153,1 
.goto Grizzly Hills,76.36,63.72
.use 36865
.mob Iron Thane Furyhammer
step
>>|cRXP_WARN_Exit the golem|r
.use 36935 >>Use |T133715:0|t[Raegar's Explosives] in your bags |cRXP_WARN_in the middle of the bottom floor to destroy the Power Core|r
.complete 12154,1 
.goto Grizzly Hills,76.46,63.25
.use 36865
step
.goto Grizzly Hills,77.09,48.64
>>Return to Prospector's Point
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Raegar|r
.turnin 12153 >>Turn in The Iron Thane and His Anvil
.turnin 12154 >>Turn in Blackout
.target Raegar Breakbrow
step << Druid
#completewith DruidTrain2
.cast 18960 >> Cast Teleport: Moonglade
.zoneskip Moonglade
.xp <75,1
step << Druid
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 48440 >> Train your class spells
.xp <75,1
.target Loganaar
step << Druid
#label DruidTrain2
.goto Moonglade,52.53,40.57
>>Go to Moonglade
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 48443 >> Train your class spells
.xp <77,1
.target Loganaar
step << DK
#completewith DKTrain2
.cast 50977 >> Cast Death Gate
.zoneskip Eastern Plaguelands
.xp <75,1
step << DK
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49923 >> Train your class spells
.xp <75,1
.target Amal'thazad
step << DK
#label DKTrain2
.goto Eastern Plaguelands,80.30,48.01
>>Go through the Death Gate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Amal'thazad|r
.train 49894 >> Train your class spells
.xp <76,1
.target Amal'thazad
step << Mage
#completewith MageTrain2
.zone Stormwind City >> Teleport to Stormwind
.xp <75,1
step << Mage
.goto Stormwind City,49.55,85.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42955 >> Train your class spells
.xp <75,1
.target Elsharin
.target Jennea Cannon
step << Mage
.goto Stormwind City,49.55,85.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42920 >> Train your class spells
.xp <76,1
.target Elsharin
.target Jennea Cannon
step << Mage
#label MageTrain2
.goto Stormwind City,49.55,85.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jennea|r
.train 42985 >> Train your class spells
.xp <77,1
.target Elsharin
.target Jennea Cannon
step << Shaman/Druid/DK/Mage
#completewith next
.hs >> Hearth to the Westfall Brigade Encampment
step
#completewith next
.goto Grizzly Hills,59.89,26.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Samuel|r
.fly Amberpine Lodge >> Fly to Amberpine Lodge
.noflyable Grizzly Hills,300
.target Samuel Clearbook
step
#questguide
.goto Grizzly Hills,31.16,59.47
>>Return to Amberpine Lodge
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thayreen|r
.turnin 12248 >>Turn in Vordrassil's Sapling
.turnin 12250 >>Turn in Vordrassil's Seeds
.turnin 12249 >>Turn in Ursoc, the Bear God
.isQuestComplete 12249
.target Hierophant Thayreen
step
#label end
.goto Grizzly Hills,31.16,59.47
>>Return to Amberpine Lodge
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thayreen|r
.turnin 12248 >>Turn in Vordrassil's Sapling
.turnin 12250 >>Turn in Vordrassil's Seeds
.target Hierophant Thayreen
step << DK/Mage/Druid
.goto Grizzly Hills,31.31,59.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vana|r
.fly Westfall Brigade >> Fly to the Westfall Brigade Encampment
.target Vana Grey
step << !DK !Mage !Druid
#completewith next
.goto Grizzly Hills,32.00,59.78
.zone Dalaran >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Magistrix Haelani|r
.target Magistrix Haelenai
.accept 12794 >>Accept The Magical Kingdom of Dalaran
.zoneskip Stormwind City
.zoneskip Dalaran
.target Magistrix Haelenai
step << !DK !Mage !Druid
.goto Grizzly Hills,32.00,59.78
.zone Dalaran >>Ask |cRXP_FRIENDLY_Magistrix Haelani|r to be teleported to Dalaran
.target Magistrix Haelenai
.zoneskip Stormwind City
.skipgossip
step << !DK !Druid !Mage
.abandon 12794 >> Abandon The Magical Kingdom of Dalaran. |cRXP_WARN_DO NOT TURN THIS IN|r
step << Rogue/Warlock/Priest/Paladin
#completewith next
.goto Dalaran,38.65,59.33,15,0
.goto Dalaran,39.48,63.98
.zone Ironforge >>Go into The Silver Enclave. Take the portal to Ironforge
step << Rogue/Warlock
#completewith next
.goto Ironforge,40.10,12.16,30,0
.goto Ironforge,52.92,12.82,10,0 << Rogue
.goto Ironforge,50.20,7.46,10 >>Go inside the building << Warlock
.goto Ironforge,51.88,14.30,10 >>Go inside the building << Rogue
step << Warlock
.goto Ironforge,50.35,5.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Briarthorn|r
.target Briarthorn
.train 47813 >> Train your class spells
.xp <77,1
step << Rogue
.goto Ironforge,51.50,15.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fenthwick|r
.target Fenthwick
.train 48637 >> Train your class spells
.xp <76,1
step << Priest
.goto Ironforge,24.40,9.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Braenna Flintcrag|r
.target Braenna Flintcrag
.train 48124 >> Train your class spells
.xp <75,1
step << Paladin
.goto Ironforge,24.55,4.47,-1
.goto Ironforge,23.11,6.13,-1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Beldruk Doombrow|r or |cRXP_FRIENDLY_Brandur Ironhammer|r
.target Beldruk Doombrow
.target Brandur Ironhammer
.train 48818 >> Train your class spells
.xp <75,1
step << Shaman/Hunter/Warrior
#completewith next
.goto Dalaran,38.65,59.33,15,0
.goto Dalaran,38.21,66.36
.zone The Exodar >>Go into The Silver Enclave. Take the portal to the Exodar
step << Shaman
#completewith ShamanTraining2
.goto The Exodar,35.15,48.76,20,0
.goto The Exodar,34.96,43.68,20 >>Travel toward |cRXP_FRIENDLY_Gurrag|r
step << Shaman
.goto The Exodar,24.27,39.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gurrag|r
.target Gurrag
.train 49280 >> Train your class spells
.xp 75,1
step << Shaman
#label ShamanTraining2
.goto The Exodar,24.27,39.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gurrag|r
.target Gurrag
.train 58803 >> Train your class spells
.xp 75,1
step << Hunter/Warrior
#completewith next
.goto The Exodar,46.17,72.79,20,0
.goto The Exodar,49.21,74.94,20,0
.goto The Exodar,53.74,85.39,30,0 << Warrior
.goto The Exodar,53.74,85.39,30 >>Travel toward |cRXP_FRIENDLY_Deremiis|r << Hunter
.goto The Exodar,50.87,80.83,15,0 << Warrior
.goto The Exodar,54.07,78.05,15 >>Travel toward |cRXP_FRIENDLY_Behomat|r << Warrior
step << Hunter
.goto The Exodar,47.07,86.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Deremiis|r
.target Deremiis
.train 61005 >> Train your class spells
.xp <75,1
step << Hunter
.goto The Exodar,47.07,86.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Deremiis|r
.target Deremiis
.train 53338 >> Train your class spells
.xp <76,1
step << Warrior
.goto The Exodar,55.58,82.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Behomat|r
.target Behomat
.train 55694 >> Train your class spells
.xp <75,1
step << !DK !Druid !Mage
#completewith ZulDrak
.hs >> Hearth to the Westfall Brigade Encampment
step
.goto Grizzly Hills,59.42,26.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryan|r
.accept 12770 >>Accept Reallocating Resources
.target Captain Gryan Stoutmantle
step
#label ZulDrak
.goto Grizzly Hills,59.89,26.69
.zone Zul'Drak >>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Samuel|r. Ask for a flight to Light's Breach
.skipgossip 26876,2
.target Samuel Clearbook
]])
RXPGuides.RegisterGuide([[
#cata
#Cata
#speedrunguide
#xprate >1.49 << wotlk
#group RXP Cataclysm 60-80 (A)
<< Alliance
#name 74-75 Grizzly Hills
#version 5
#next 75-76 Zul'Drak
#include 73-75 Grizzly Hills@pt1start-pt1end
step
.goto 116/571,-2812.200,3418.200
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Woodsman Drake|r
.target Woodsman Drake
.turnin 12255 >>Turn in The Thane of Voldrune
step
#include 73-75 Grizzly Hills@pt2start-pt2end
step
.goto Grizzly Hills,26.46,31.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Caged Prisoner|r inside
.turnin 12302 >>Turn in Words of Warning
>>|cRXP_WARN_Skip the follow-up quest|r
step
.goto ZulDrak,32.18,74.39
.zone ZulDrak >> Head northwest to Zul'Drak
]])
