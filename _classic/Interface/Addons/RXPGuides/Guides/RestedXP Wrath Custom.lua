RXPGuides.RegisterGuide([[
#version 23
#wotlk
#group RestedXP Mage AoE 68-80
<< Mage
#name 68-80 Mage AoE

step << Horde
#completewith HFZep1
.zone Undercity >> Teleport to Undercity
step << Horde
.goto Undercity,85.1,10.0
.train 27101 >> Train your class spells
.xp <68,1
step << Horde
#completewith next
.goto Undercity,82.36,15.31
.goto Undercity,67.88,14.97,30 >> Go to the Reagent Vendor on your right and perform a Logout Skip by positioning your character on the highest part of the lowest staircase until it looks like they're floating, then logging out and back in.
.link https://www.youtube.com/watch?v=-Bi95bCN8dM >> CLICK HERE for an example
>>If you can't do this, just run out of Undercity normally
step << Horde
#label HFZep1
.goto Undercity,66.23,4.43,30,0
.goto Tirisfal Glades,59.97,58.56,30,0
.goto Tirisfal Glades,58.98,59.07
.zone HowlingFjord >>Take the Zeppelin from Tirisfal Glades to Howling Fjord
step << Horde
.goto HowlingFjord,79.05,29.70
.fp Vengeance Landing >> Get the Vengeance Landing flight path
step << Horde
#label VLHS
#completewith Seals
.goto HowlingFjord,79.10,30.41,20,0
.goto BoreanTundra,79.73,30.85
.home >> Set your Hearthstone to Vengeance Landing
step << Alliance
#completewith Boat1
.zone Ironforge >> Teleport to Ironforge
step << Alliance
.goto Ironforge,28.6,7.2
.train 27101 >> Train your class spells
.xp <68,1
step << Alliance
#completewith next
.goto Ironforge,55.51,47.75
.fly Wetlands>> Fly to Wetlands
.zoneskip Wetlands
.zoneskip HowlingFjord
step << Alliance
#label Boat1
.goto Wetlands,4.7,57.3
.zone HowlingFjord >>Get onto the boat when it comes. Take it to Howling Fjord.
>>Note: This used to be the Auberdine boat but has been changed to the Howling Fjord boat in Wrath.
step << Alliance
#label VKHS
#completewith Seals
.goto HowlingFjord,58.6,63.1,15,0
.goto HowlingFjord,58.39,62.45
.home >> Set your Hearthstone to Valgarde
>>Buy some of the new food/water if you wish
step << Alliance
.goto HowlingFjord,59.79,63.24
.fp Valgarde >>Get the Valgarde Flight Path
step
#requires VLHS << Horde
#requires VKHS << Alliance
.loop 60,HowlingFjord,77.97,71.27,79.14,70.12,80.10,70.93,79.20,71.53,78.32,72.94,79.82,72.86,79.46,74.32,77.95,75.45,77.79,74.25,77.44,72.61,77.20,76.31,75.88,76.91,74.34,76.55,77.97,71.27
.xp 69 >> AoE grind Seals to 69
step
#completewith next
.zone Undercity >> Teleport to Undercity << Horde
.zone Stormwind City >> Teleport to Stormwind << Alliance
.xp <69,1
step
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.train 27124 >> Train your class spells
.xp <69,1
step
#completewith next
.hs >> Hearth to Valgarde << Alliance
.hs >> Hearth to Vengeance Landing << Horde
step
.loop 60,HowlingFjord,77.97,71.27,79.14,70.12,80.10,70.93,79.20,71.53,78.32,72.94,79.82,72.86,79.46,74.32,77.95,75.45,77.79,74.25,77.44,72.61,77.20,76.31,75.88,76.91,74.34,76.55,77.97,71.27
.xp 70 >> AoE grind Seals to 70
step
#completewith next
.zone Undercity >> Teleport to Undercity << Horde
.zone Stormwind City >> Teleport to Stormwind << Alliance
.xp <70,1
step
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.train 27126 >> Train your class spells
.xp <70,1
step
#completewith next
.hs >> Hearth to Vengeance Landing << Horde
.hs >> Hearth to Valgarde << Alliance
step
#label Seals
.loop 60,HowlingFjord,77.97,71.27,79.14,70.12,80.10,70.93,79.20,71.53,78.32,72.94,79.82,72.86,79.46,74.32,77.95,75.45,77.79,74.25,77.44,72.61,77.20,76.31,75.88,76.91,74.34,76.55,77.97,71.27
.xp 72 >> AoE grind Seals to 72
step
#completewith next
.zone Undercity >> Teleport to Undercity << Horde
.zone Stormwind City >> Teleport to Stormwind << Alliance
.xp <72,1
step
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.train 42930 >> Train your class spells
.xp <72,1
step
#completewith next
.hs >> Hearth to Vengeance Landing << Horde
.hs >> Hearth to Valgarde << Alliance
step << Horde
.goto HowlingFjord,49.6,11.6
.fp Camp Winterhoof >> Get the Camp Winterhoof flight path
step << Horde
.goto HowlingFjord,26.0,25.1
.fp Apothecary Camp >> Get the Apothecary Camp flight path
step << Horde
.goto GrizzlyHills,22.0,64.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kragh
.fp Conquest Hold >> Get the Conquest Hold flight path
step << Alliance
.goto HowlingFjord,31.26,43.98
.fp Westguard Keep >> Get the Westguard Keep flight path
step
#completewith next
.goto Dragonblight,92.39,64.02
.zone Dragonblight >> Travel to Dragonblight
step << Horde
.goto Dragonblight,76.48,62.20
.fp Venomspite >> Get the Venomspite flight path
step << Horde
#completewith Onslaught
.goto Dragonblight,76.87,63.13
.home >>Set your Hearth to Venomspite
step << Alliance
.goto Dragonblight,78.47,48.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to High Commander Halford Wyrmbane
.accept 12235 >>Accept Naxxramas and the Fall of Wintergarde
.target High Commander Halford Wyrmbane
step << Alliance
.goto Dragonblight,77.08,49.86
.fp Wintergarde Keep >>Get the Wintergarde Keep Flight Path
step << Alliance
.goto Dragonblight,77.18,50.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Urik
.turnin 12235 >>Turn in Naxxramas and the Fall of Wintergarde
.accept 12237 >>Accept Flight of the Wintergarde Defender
.target Gryphon Commander Urik
step << Alliance
#requires WinterHS1
#completewith next
.cast 48388 >> Use the Gryphon Whistle to mount a Wintergarde Gryphon. You can use this to fly in Wintergarde and The Carrion Fields
.use 37287
step << Alliance
.waypoint Dragonblight,86.38,50.91,0,rescue,VEHICLE_PASSENGERS_CHANGED,VEHICLE_UPDATE
>>Use "Rescue Villager" (1) to pick up Helpless Villagers (you can only pick up one at a time). Use "Drop Off Villager" (2) to drop them off at the filight master. Use "Soar" (3) on cooldown to move faster.
.complete 12237,1 
.goto Dragonblight,77.13,49.78
.use 37287
step << Alliance
.goto Dragonblight,77.16,50.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tDismount the Gryphon, Talk to Urik
.turnin 12237 >>Turn in Flight of the Wintergarde Defender
.accept 12251 >>Accept Return to the High Commander
step << Alliance
#completewith Onslaught
.goto Dragonblight,77.46,51.43
.home >>Set your Hearthstone to Wintergarde Keep
step << Alliance
.goto Dragonblight,78.47,48.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Halford
.turnin 12251 >>Turn in Return to the High Commander
step
#label Onslaught
.loop 50,Dragonblight,87.90,41.21,87.00,42.19,86.45,40.12,85.51,41.24,83.78,41.98,84.14,40.72,84.49,37.06,87.64,35.43,87.90,41.21
.xp 74 >> AoE grind the Scarlet Onslaught mobs to 74
step
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.train 42939 >> Train your class spells
.xp <74,1
step
#completewith next
.hs >> Hearth to Venomspite << Horde
.hs >> Hearth to Wintergarde Keep << Alliance
step
.loop 50,Dragonblight,87.90,41.21,87.00,42.19,86.45,40.12,85.51,41.24,83.78,41.98,84.14,40.72,84.49,37.06,87.64,35.43,87.90,41.21
.xp 76 >> AoE grind the Scarlets to 76
step
#completewith next
.hs >> Hearth to Venomspite << Horde
.hs >> Hearth to Wintergarde Keep << Alliance
step
.goto Dragonblight,60.32,51.55
>>Travel to Wyrmrest Temple
.fp Wyrmrest Temple >> Get the Wyrmrest Temple flight path
step << Horde
.goto Dragonblight,37.51,45.77
>>Travel to Agmar's Hammer
.fp Agmar's Hammer >> Get the Agmar's Hammer flight path
step << Horde
.goto Dragonblight,38.05,46.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Aethas
.accept 12791 >>Accept The Magical Kingdom of Dalaran
.zoneskip SholazarBasin
.zoneskip Dalaran
step << Horde
.goto Dragonblight,38.05,46.22
.zone Dalaran >>Ask Aethas for a teleport to Dalaran
.zoneskip SholazarBasin
.skipgossip
step << Alliance
.goto Dragonblight,29.15,55.32
>>Head east into Dragonblight
.fp Stars' Rest >> Get the Stars' Rest Flight Path
step << Alliance
.goto Dragonblight,29.0,55.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Modera
.accept 12794 >>Accept The Magical Kingdom of Dalaran
.zoneskip SholazarBasin
.zoneskip Dalaran
step << Alliance
.goto Dragonblight,29.0,55.5
.zone Dalaran >>Ask Modera for a teleport to Dalaran
.zoneskip SholazarBasin
.skipgossip
step
.abandon 12791 >> Abandon The Magical Kingdom of Dalaran. DO NOT TURN THIS IN << Horde
.abandon 12794 >> Abandon The Magical Kingdom of Dalaran. DO NOT TURN THIS IN << Alliance
step
.goto Dalaran,56.3,46.7
.train 53140 >>Go inside the building. Train Teleport: Dalaran
step
.goto Dalaran,54.94,46.19
.train 42920 >> Train your class spells
.xp <76,1
step
.goto Dalaran,72.18,45.77
.fp Dalaran >> Get the Dalaran flight path
step
#requires DalaranFP
#completewith next
.goto Dalaran,68.54,42.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tGo to Krasus's Landing. Talk to Pentarus
.accept 12521 >>Accept Where in the World is Hemet Nesingwary?
step
#requires DalaranFP
.goto Dalaran,68.54,42.07
.zone SholazarBasin >>Ask Pentarus to take you to Sholazar Basin. This takes 50 seconds
.skipgossip
step
.goto SholazarBasin,39.70,58.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Monte hanging from the tree
.turnin 12521 >>Turn in Where in the World is Hemet Nesingwary?
.accept 12489 >>Accept Welcome to Sholazar Basin
step
#completewith end
#label Nesingwary
.goto SholazarBasin,26.8,59.3,0,0
.home >> Set your Hearthstone to Nesingwary Base Camp
>>Buy food if needed
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTravel to Nesingwary Base Camp. Talk to Hemet, Debaar, and Chad
.turnin 12489 >>Turn in Welcome to Sholazar Basin
.goto SholazarBasin,27.09,58.64
.accept 12524 >>Accept Venture Co. Misadventure
.goto SholazarBasin,27.25,59.90
.accept 12624 >>Accept It Could Be Anywhere!
.goto SholazarBasin,26.86,58.94
step
#requires Nesingwary
.goto SholazarBasin,25.35,58.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Weslex
.accept 12522 >>Accept Need an Engine, Take an Engine
step
#completewith VentureCo2
>>Kill any mob in Sholazar for the Golden Engagement Ring. Don't focus on this quest at all
.complete 12624,1 
step
.goto SholazarBasin,38.69,56.72
>>Loot the "engine" outside of the water next to the flying machine
.complete 12522,1 
step
#completewith Helice
.goto SholazarBasin,36.8,47.3,0
>>AoE the Venture Co. in Swindlegrin's Dig
.complete 12524,1 
step
.goto SholazarBasin,35.55,47.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Engineer Helice to start her escort
.accept 12688 >>Accept Engineering a Disaster
step
#label Helice
.goto SholazarBasin,37.27,50.59
>>Escort Helice
.complete 12688,1 
step
#completewith next
>>AoE the Venture Co. in Swindlegrin's Dig
.complete 12524,1 
step
.goto SholazarBasin,37.35,45.78,50,0
.goto SholazarBasin,33.31,45.31,50,0
.goto SholazarBasin,33.13,47.90
>>AoE the Venture Co. in Swindlegrin's Dig
.complete 12524,1 
step
#completewith Debaar1
.hs >> Hearth to Nesingwary's Base Camp
.cooldown item,6948,>0
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to Nesingwary's Base Camp. Talk to Hemet and Debaar
.turnin 12688 >>Turn in Engineering a Disaster
.goto SholazarBasin,27.09,58.64
.turnin 12524 >>Turn in Venture Co. Misadventure
.accept 12525 >>Accept Wipe That Grin Off His Face
.goto SholazarBasin,27.25,59.90
.isQuestComplete 12688
step
#requires EscortEnd
#label Debaar1
.goto SholazarBasin,27.25,59.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Debaar
.turnin 12524 >>Turn in Venture Co. Misadventure
.accept 12525 >>Accept Wipe That Grin Off His Face
step
.goto SholazarBasin,26.86,58.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Chad
.turnin 12624 >>Turn in It Could Be Anywhere!
.isQuestComplete 12624
step
.goto SholazarBasin,25.35,58.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Weslex
.turnin 12522 >>Turn in Need an Engine, Take an Engine
.accept 12523 >>Accept Have a Part, Give a Part
step
#completewith VentureCo2
.goto SholazarBasin,33.2,45.7,0
>>Loot the various spare parts found around Swindlegrin's Dig
.complete 12523,1 
step
.goto SholazarBasin,35.49,50.00
>>Kill Foreman Swindlegrin and Meatpie on the wooden platform
.complete 12525,1 
.complete 12525,2 
step
.goto SholazarBasin,33.2,45.7,50,0
.goto SholazarBasin,37.03,46.72
>>Loot the various spare parts found around Swindlegrin's Dig
.complete 12523,1 
step
>>Kill any mob in Sholazar for the Golden Engagement Ring. Don't focus on this quest at all
.complete 12624,1 
step
#completewith Debaar1
.hs >> Hearth to Nesingwary's Base Camp
.cooldown item,6948,>0
step
#completewith end
#label NesFP
.goto SholazarBasin,25.35,58.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Weslex, then Talk to the Flying Machine and Calvert
.turnin 12523 >>Turn in Have a Part, Give a Part
.fp Nesingwary Base Camp >> Get the Nesingwary Base Camp flight path
.goto SholazarBasin,25.27,58.45


step
#requires NesFP
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Debaar, then Drostan
.turnin 12525 >>Turn in Wipe That Grin Off His Face
.goto SholazarBasin,27.25,59.90
.accept 12589 >>Accept Kick, What Kick?
.goto SholazarBasin,27.08,59.91
step
.goto SholazarBasin,27.08,59.91
.use 38573 >> Use the RJR Rifle in your bags to shoot Lucky Wilhelm. Do it until the objective completes, then re-equip your wand
.complete 12589,1 
.turnin 12589 >>Turn in Kick, What Kick?

step
.goto SholazarBasin,26.86,58.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Chad
.turnin 12624 >>Turn in It Could Be Anywhere!
step
.loop 75,SholazarBasin,36.21,51.02,37.13,45.50,32.88,45.11,31.67,48.72
.xp 77 >> AoE the Venture Co. to 77
step
#completewith next
.zone Dalaran >> Teleport to Dalaran
step
.goto Dalaran,54.94,46.19
.train 42985 >> Train your class spells
step
.goto Dalaran,69.81,45.45
.train 54197 >> Train Cold Weather Flying from Hira
step
#completewith next
>>If you have 295 or more spell hit (and the Precision talent) skip this step
.hs >> Hearth to Nesingwary's Base Camp
step
.loop 75,SholazarBasin,36.21,51.02,37.13,45.50,32.88,45.11,31.67,48.72
>>If you have 295 or more spell hit (and the Precision talent) skip this step
.xp 78 >> AoE the Venture Co. to 78
step
.zone Dalaran >> Teleport to Dalaran
step
.goto Dalaran,54.94,46.19
.train 42859 >> Train your class spells
.xp <78,1
step
#completewith next
.goto IcecrownGlacier,59.0,73.8
.zone Icecrown >> Fly to Icecrown
step
.goto IcecrownGlacier,59.0,73.8
.xp 79 >> AoE the Undead to 79
step
#completewith next
.zone Dalaran >> Teleport to Dalaran
.xp <79,1
step
.goto Dalaran,54.94,46.19
.train 43008 >> Train your class spells
.xp <79,1
step
#completewith next
.goto IcecrownGlacier,59.0,73.8
.zone Icecrown >> Fly to Icecrown
step
.goto IcecrownGlacier,59.0,73.8
.xp 80 >> AoE the Undead to 80
]])
RXPGuides.RegisterGuide([[
#version 23
#wotlk
#group RestedXP Completionist Guides
#name Emblems of Heroism 1 - Dragonblight/Zul'Drak
#next Emblems of Heroism 2 - The Storm Peaks
step
#completewith next
.zone Dragonblight >>Travel to Dragonblight
step << Alliance
.goto Dragonblight,78.56,48.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r
.accept 12235 >>Accept Naxxramas and the Fall of Wintergarde
.target High Commander Halford Wyrmbane
step << Alliance
.goto Dragonblight,77.10,50.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urik|r
.turnin 12235 >>Turn in Naxxramas and the Fall of Wintergarde
.accept 12237 >>Accept Flight of the Wintergarde Defender
.target Gryphon Commander Urik
step << Alliance
#completewith next
.goto Dragonblight,77.13,49.78,15,0
.cast 48388 >>Use the |T132161:0|t[Gryphon Whistle]
.use 37287
step << Alliance
#completewith next
.vehicle 27258 >>Mount the |cRXP_FRIENDLY_Wintergarde Gryphon|r
.target Wintergarde Gryphon
.use 37287
step << Alliance
.waypoint Dragonblight,86.38,50.91,0,rescue,VEHICLE_PASSENGERS_CHANGED,VEHICLE_UPDATE
.goto Dragonblight,77.13,49.78
>>|cRXP_WARN_Cast|r |T134148:0|t[Rescue Villager] (1) |cRXP_WARN_to pick up|r |cRXP_FRIENDLY_Helpless Wintergarde Villagers|r
>>|cRXP_WARN_Return to |cRXP_FRIENDLY_Urik|r after picking up a |cRXP_FRIENDLY_Helpless Wintergarde Villager|r,|r |cRXP_WARN_then cast|r |T134149:0|t[Drop Off Villager] (2)
>>|cRXP_WARN_Cast|r |T132172:0|t[Soar] (3) |cRXP_WARN_to fly faster|r
>>|cRXP_WARN_You can only pick up one|r |cRXP_FRIENDLY_Helpless Wintergarde Villager|r at a time|r
.complete 12237,1 
.target Helpless Wintergarde Villager
.use 37287
step << Alliance
.goto Dragonblight,77.10,50.12
>>|cRXP_WARN_Dismount the |cRXP_FRIENDLY_Wintergarde Gryphon|r|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urik|r
.turnin 12237 >>Turn in Flight of the Wintergarde Defender
.accept 12251 >>Accept Return to the High Commander
.target Gryphon Commander Urik
step << Alliance
.goto Dragonblight,78.56,48.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r
.turnin 12251 >>Turn in Return to the High Commander
.accept 12253 >>Accept Rescue from Town Square
.accept 12275 >>Accept The Demo-gnome
.target High Commander Halford Wyrmbane
step << Alliance
.goto Dragonblight,77.85,50.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Quarterflash|r
.turnin 12275 >>Turn in The Demo-gnome
.accept 12276 >>Accept The Search for Slinkin
.accept 12272 >>Accept The Bleeding Ore
.target Siege Engineer Quarterflash
step << Alliance Mage
.goto Dragonblight,77.28,51.19,12,0
.goto Dragonblight,77.48,51.37,12,0
.goto Dragonblight,77.40,51.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Illusia|r
.home >> Set your Hearthstone to Wintergarde Keep
.target Illusia Lune
step << Alliance
.loop 15,Dragonblight,80.03,48.85,80.22,49.83,80.71,50.43,80.82,51.19,80.51,52.17,79.64,51.36,78.84,51.26,79.88,50.41,80.03,48.85
.line Dragonblight,80.03,48.85,80.22,49.83,80.71,50.43,80.82,51.19,80.51,52.17,79.64,51.36,78.84,51.26,79.88,50.41,80.03,48.85
>>Kill |cRXP_ENEMY_Vengeful Geists|r to rescue the |cRXP_FRIENDLY_Trapped Wintergarde Villagers|r
.complete 12253,1 
.target Trapped Wintergarde Villager
.mob Vengeful Geist
step << Alliance
#completewith Slinkin
#label LowerMine
.goto Dragonblight,80.16,45.19,20 >>Enter the lower entrance of the Mine
step << Alliance
#completewith MineBomb
#requires LowerMine
>>Mine the |cRXP_PICK_Strange Ore Veins|r. Loot it for the |cRXP_LOOT_Strange Ore|r
.complete 12272,1 
step << Alliance
#completewith next
.goto Dragonblight,80.29,43.71,15,0
.goto Dragonblight,81.52,42.20,20 >>Travel toward |cRXP_FRIENDLY_Slinkin|r
step << Alliance
#label Slinkin
.goto Dragonblight,81.52,42.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Slinkin|r's corpse on the ground
.turnin 12276 >>Turn in The Search for Slinkin
.accept 12277 >>Accept Leave Nothing to Chance
step << Alliance
#label MineBomb
.goto Dragonblight,80.99,42.26,20,0
.goto Dragonblight,80.89,42.06,20,0
.goto Dragonblight,80.74,41.32
>>Loot the |T133717:0|t[|cRXP_LOOT_Wintergarde Mine Bomb|r] on the ground
.collect 37465,1,12277,1 
step << Alliance
.goto Dragonblight,80.54,40.82,25,0
.goto Dragonblight,80.79,40.06,25,0
.goto Dragonblight,80.15,40.34,25,0
.goto Dragonblight,79.76,39.26,25,0
.goto Dragonblight,80.09,44.20,25,0
.goto Dragonblight,79.56,43.13,25,0
.goto Dragonblight,78.99,42.24,25,0
.goto Dragonblight,79.58,41.66,25,0
.goto Dragonblight,79.99,41.83,25,0
.goto Dragonblight,80.61,42.96,25,0
.goto Dragonblight,80.54,40.82,25,0
.goto Dragonblight,80.79,40.06,25,0
.goto Dragonblight,80.15,40.34,25,0
.goto Dragonblight,79.76,39.26
>>Mine the |cRXP_PICK_Strange Ore Veins|r. Loot it for the |cRXP_LOOT_Strange Ore|r
.complete 12272,1,6 
step << Alliance
#completewith LeaveNothing
>>Mine the |cRXP_PICK_Strange Ore Veins|r. Loot it for the |cRXP_LOOT_Strange Ore|r
.complete 12272,1 
step << Alliance
#completewith next
.goto Dragonblight,80.90,42.89,20,0
.goto Dragonblight,80.29,43.71,20,0
.goto Dragonblight,80.16,45.19,20 >>Travel toward the lower entrance
step << Alliance
.goto Dragonblight,80.16,45.19
.cast 48741 >>Use the |T133717:0|t[|cRXP_LOOT_Wintergarde Mine Bomb|r] at the lower entrance of the Mine

.use 37465
.isOnQuest 12277
step << Alliance
#label LeaveNothing
.goto Dragonblight,80.41,44.81
.cast 48741 >>Use the |T133717:0|t[|cRXP_LOOT_Wintergarde Mine Bomb|r] at the upper entrance of the Mine

.use 37465
.isOnQuest 12277
step << Alliance
.goto Dragonblight,80.09,44.20,25,0
.goto Dragonblight,79.56,43.13,25,0
.goto Dragonblight,78.99,42.24,25,0
.goto Dragonblight,79.58,41.66,25,0
.goto Dragonblight,79.99,41.83,25,0
.goto Dragonblight,80.61,42.96,25,0
.goto Dragonblight,80.54,40.82,25,0
.goto Dragonblight,80.79,40.06,25,0
.goto Dragonblight,80.15,40.34,25,0
.goto Dragonblight,79.76,39.26,25,0
.goto Dragonblight,80.09,44.20,25,0
.goto Dragonblight,79.56,43.13,25,0
.goto Dragonblight,78.99,42.24,25,0
.goto Dragonblight,79.58,41.66,25,0
.goto Dragonblight,79.99,41.83,25,0
.goto Dragonblight,80.61,42.96,25,0
.goto Dragonblight,80.54,40.82,25,0
.goto Dragonblight,80.79,40.06,25,0
.goto Dragonblight,80.15,40.34,25,0
.goto Dragonblight,79.76,39.26
>>Mine the |cRXP_PICK_Strange Ore Veins|r. Loot it for the |cRXP_LOOT_Strange Ore|r
.complete 12272,1 
step << skip
#completewith next
.hs >> Hearth to Wintergarde Keep
.cooldown item,6948,>0

step << Alliance
.goto Dragonblight,77.85,50.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Quarterflash|r
.turnin 12272 >>Turn in The Bleeding Ore
.turnin 12277 >>Turn in Leave Nothing to Chance
.accept 12281 >>Accept Understanding the Scourge War Machine
.target Siege Engineer Quarterflash
step << Alliance
.goto Dragonblight,78.56,48.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r
.turnin 12281 >>Turn in Understanding the Scourge War Machine
.turnin 12253 >>Turn in Rescue from Town Square
.accept 12309 >>Accept Find Durkon!
.target High Commander Halford Wyrmbane
step << Alliance
.goto Dragonblight,79.06,53.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Durkon|r
.turnin 12309 >>Turn in Find Durkon!
.accept 12311 >>Accept The Noble's Crypt
.target Cavalier Durkon
step << Alliance
#completewith Amarion
.goto Dragonblight,78.83,52.89,10,0
.goto Dragonblight,78.61,52.82,10,0
.goto Dragonblight,78.62,52.59,10 >>Enter the Wintergarde Crypt
step << Alliance
#sticky
#label FleshBoundT
.goto Dragonblight,78.62,52.28,0,0
>>Click the |cRXP_PICK_Flesh-Bound Tome|r on the ground
.accept 12312 >>Accept Secrets of the Scourge
step << Alliance
#label Amarion
.goto Dragonblight,78.61,53.08,8,0
>>Kill |cRXP_ENEMY_Necrolord Amarion|r at the bottom of Wintergarde Crypt
.complete 12311,1 
.goto Dragonblight,78.60,52.36
.mob Necrolord Amarion
step << Alliance
#requires FleshBoundT
.goto Dragonblight,79.06,53.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Durkon|r
.turnin 12311 >>Turn in The Noble's Crypt
.turnin 12312 >>Turn in Secrets of the Scourge
.accept 12319 >>Accept Mystery of the Tome
.target Cavalier Durkon
step << Alliance
.goto Dragonblight,78.56,48.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r
.turnin 12319 >>Turn in Mystery of the Tome
.accept 12320 >>Accept Understanding the Language of Death
.target High Commander Halford Wyrmbane
step << skip
#completewith next
.goto Dragonblight,78.08,46.12,30,0
.goto Dragonblight,77.07,46.47,20,0
>>Climb the hill to the north, then turn left and enter the castle courtyard
.skill coldweatherflying,1,1

step << Alliance
#completewith next
.goto Dragonblight,76.95,47.72,12,0
.goto Dragonblight,76.62,47.53,10 >> Go downstairs to the Jail
step << Alliance
.goto Dragonblight,76.75,47.52,6,0
.goto Dragonblight,76.80,47.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hallard|r
.turnin 12320 >>Turn in Understanding the Language of Death
.accept 12321 >>Accept A Righteous Sermon
.timer 184,A Righteous Sermon RP
.target Inquisitor Hallard
step << Alliance
.goto Dragonblight,78.21,47.14
>>|cRXP_WARN_Wait out the RP at the arrow's location|r
>>If you travel too far and the quest fails, return to |cRXP_FRIENDLY_Hallard|r and start it again
.complete 12321,1 
.target Inquisitor Hallard
step << Alliance
.goto Dragonblight,78.56,48.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r
.turnin 12321 >>Turn in A Righteous Sermon
.accept 12325 >>Accept Into Hostile Territory
.target High Commander Halford Wyrmbane
step << skip
#completewith next
.goto Dragonblight,77.11,49.60,15,0
>>Mount any of the four |cRXP_FRIENDLY_Wintergarde Gryphons|r for a ride to Thorson's Post
.target Wintergarde Gryphon
.skill coldweatherflying,1,1

step << Alliance
.goto Dragonblight,89.68,46.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Foehammer|r
.turnin 12325 >>Turn in Into Hostile Territory
.accept 12326 >>Accept Steamtank Surprise
.target Duke August Foehammer
step << Alliance
#completewith next
.goto Dragonblight,89.89,46.82,-1
.goto Dragonblight,89.79,46.97,-1
.vehicle 27587 >>Get inside one of the |cRXP_FRIENDLY_Tanks|r
.target Alliance Steam Tank
step << Alliance
.loop 45,Dragonblight,89.08,48.71,89.93,50.21,88.99,49.78,88.11,50.60,87.42,49.67,86.40,49.13,85.65,49.09,85.09,50.16,84.25,51.61,85.10,51.96,86.28,51.85,86.68,52.61,87.48,53.40,88.49,52.21,88.11,50.60
>>Cast |T135836:0|t[Ice Cannon] (1) and |T135834:0|t[Ice Prison] (2) to kill |cRXP_ENEMY_Undead|r
>>|cRXP_WARN_Cast|r |T134165:0|t[Drop Off Gnome] (3) |cRXP_WARN_next to |cRXP_ENEMY_Plague Wagons|r to sabotage them|r
>>|cRXP_WARN_Wait out the RP after casting|r |T134165:0|t[Drop Off Gnome]
>>|cRXP_WARN_You can only sabotage one |cRXP_ENEMY_Plague Wagon|r at a time|r
>>|cRXP_WARN_If your |cRXP_FRIENDLY_7th Legion Siege Engineer|r gets stuck or dies, go back and get a new|r |cRXP_FRIENDLY_Tank|r
.complete 12326,1 
.cast 49109
.timer 15,Plague Wagon Sabotage RP
.mob Plague Wagon
.target 7th Legion Siege Engineer
step << Alliance
.goto Dragonblight,85.79,49.98
>>Cast |T135942:0|t[Drop Off Soldier] (4) in front of the Mausoleum
.complete 12326,2 
step << Alliance
#completewith next
.goto Dragonblight,86.12,50.27,10,0
.goto Dragonblight,85.94,50.87,12 >>Go down the Mausoleum toward |cRXP_FRIENDLY_Ambo|r
step << Alliance
.goto Dragonblight,85.94,50.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ambo|r
.turnin 12326 >>Turn in Steamtank Surprise
.accept 12455 >>Accept Scattered To The Wind
.target Ambo Cash
step << Alliance
#completewith next
.goto Dragonblight,86.12,50.27,10,0
.goto Dragonblight,85.88,50.04,10 >>Exit the Mausoleum
step << Alliance
.loop 45,Dragonblight,85.56,50.45,85.12,50.40,85.66,51.57,85.75,52.42,85.56,52.64,85.07,52.02,83.88,51.39,83.24,50.72,83.52,49.70,84.29,49.98,85.11,48.22,86.26,47.69,86.08,49.69,86.82,50.02,85.56,50.45
>>Open the |cRXP_PICK_Wintergarde Munitions Crates|r on the ground. Loot them for the |cRXP_LOOT_Wintergarde Munitions|r
.complete 12455,1 
step << Alliance
#completewith next
.goto Dragonblight,86.12,50.27,10,0
.goto Dragonblight,85.94,50.87,12 >>Go down the Mausoleum toward |cRXP_FRIENDLY_Ambo|r
step << Alliance
.goto Dragonblight,85.94,50.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ambo|r
.turnin 12455 >>Turn in Scattered To The Wind
.accept 12457 >>Accept The Chain Gun And You
.target Ambo Cash
step << Alliance
#completewith next
.goto Dragonblight,86.24,51.06,-1
.goto Dragonblight,86.19,51.19,-1
.goto Dragonblight,85.67,50.60,-1
.goto Dragonblight,85.62,50.75,-1
.vehicle >> Get inside a |cRXP_FRIENDLY_7th Legion Chain Gun|r
.target 7th Legion Chain Gun
step << Alliance
.goto Dragonblight,86.99,51.67,-1
.goto Dragonblight,84.87,50.13,-1
>>Cast |T132351:0|t[Call Out Injured Soldier] (2) on cooldown to summon |cRXP_FRIENDLY_Injured 7th Legion Soldiers|r
>>|cRXP_WARN_If you spam it fast enough, you can summon two|r [Call Out Injured Soldiers] |cRXP_WARN_at a time|r
>>Spam cast |T136186:0|t[7th Legion Chain Gun] (1) to kill |cRXP_ENEMY_Mindless Ghouls|r pursuing |cRXP_FRIENDLY_Injured 7th Legion Soldiers|r
.complete 12457,1 
.target Injured 7th Legion Soldier
step << Alliance
.goto Dragonblight,85.94,50.87
>>|cRXP_WARN_Dismount the|r |cRXP_FRIENDLY_7th Legion Chain Gun|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ambo|r
.turnin 12457 >>Turn in The Chain Gun And You
.accept 12463 >>Accept Plunderbeard Must Be Found!
.target Ambo Cash
step << Alliance
#completewith next
.goto Dragonblight,85.68,51.63,15,0
.goto Dragonblight,85.32,52.70,15,0
.goto Dragonblight,84.51,54.67,15,0
.goto Dragonblight,84.17,54.68,15 >>Travel toward |cRXP_FRIENDLY_Plunderbeard|r
step << Alliance
.goto Dragonblight,84.17,54.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Plunderbeard's|r corpse
.turnin 12463 >>Turn in Plunderbeard Must Be Found!
.accept 12465 >>Accept Plunderbeard's Journal
.target Plunderbeard
step << Alliance
#completewith next
.goto Dragonblight,84.16,55.69,12,0
.goto Dragonblight,83.98,56.03,12,0
.goto Dragonblight,83.69,56.61,12,0
.goto Dragonblight,83.43,55.24,12,0
.goto Dragonblight,83.01,54.92,12 >>Go further through the cave
step << Alliance
.goto Dragonblight,81.93,54.04,20,0
.goto Dragonblight,80.90,51.99,20,0
.goto Dragonblight,81.93,54.04,20,0
.goto Dragonblight,82.68,54.03
>>Kill |cRXP_ENEMY_Dreadbone Constructs|r and |cRXP_ENEMY_Wailing Souls|r. Loot them for |cRXP_LOOT_Plunderbeard's Journal Pages|r
.complete 12465,1 
.complete 12465,2 
.complete 12465,3 
.complete 12465,4 
.mob Dreadbone Construct;Wailing Soul
step << Alliance
#completewith next
.goto Dragonblight,80.90,51.99,20,0
.goto Dragonblight,81.07,50.85,15,0
.goto Dragonblight,81.94,50.69,15 >>Exit the Mausoleum from the other side
step << Alliance
#completewith next
.goto Dragonblight,86.12,50.27,10,0
.goto Dragonblight,85.94,50.87,12 >>Go down the Mausoleum toward |cRXP_FRIENDLY_Ambo|r
step << Alliance
.goto Dragonblight,85.94,50.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ambo|r
.turnin 12465 >>Turn in Plunderbeard's Journal
.accept 12466 >>Accept Chasing Icestorm: The 7th Legion Front
.target Ambo Cash
step << skip
#completewith next
.hs >> Hearth to Wintergarde Keep
.cooldown item,6948,>0

step << Alliance
#completewith next
.goto Dragonblight,86.12,50.27,10,0
.goto Dragonblight,85.88,50.04,10 >>Exit the Mausoleum
step << Alliance
.goto Dragonblight,64.74,27.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tyralion|r
.turnin 12466 >>Turn in Chasing Icestorm: The 7th Legion Front
.accept 12467 >>Accept Chasing Icestorm: Thel'zan's Phylactery
.target Legion Commander Tyralion
step << Alliance
#completewith next
.goto Dragonblight,64.61,27.25
.gossipoption 93435 >>Talk to |cRXP_FRIENDLY_"Wyrmbait"|r to summon |cRXP_ENEMY_Icestorm|r
.timer 45,Chasing Icestorm RP
.target "Wyrmbait"
.skipgossip 27843,1
step << Alliance
.goto Dragonblight,63.85,27.59
>>|cRXP_WARN_Wait out the RP|r
>>Kill |cRXP_ENEMY_Icestorm|r. Loot |cRXP_LOOT_Thel'zan's Phylactery|r that drops on the ground
.complete 12467,1 
.mob Icestorm
step << Alliance
.goto Dragonblight,39.52,25.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Derek|r
.fp Fordragon Hold >>Get the Fordragon Hold Flight Path
.target Derek Rammel
step << Alliance Mage
#completewith next
.hs >> Hearth to Wintergarde Keep
step << Alliance
.goto Dragonblight,78.56,48.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r
.turnin 12467 >>Turn in Chasing Icestorm: Thel'zan's Phylactery
.accept 12472 >>Accept Finality
.target High Commander Halford Wyrmbane
step << Alliance
#completewith next
.goto Dragonblight,81.87,50.71,15,0
.goto Dragonblight,81.17,50.65,12 >>Go down the Mausoleum's back entrance toward |cRXP_FRIENDLY_Yorik|r
step << Alliance
.goto Dragonblight,81.17,50.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yorik|r
.turnin 12472 >>Turn in Finality
.accept 12473 >>Accept An End And A Beginning
.timer 115,An End And A Beginning RP
.target Legion Commander Yorik
step << Alliance
.goto Dragonblight,80.98,50.63
>>|cRXP_WARN_Wait out the RP|r
>>Kill |cRXP_ENEMY_Thel'zan the Duskbringer|r
.complete 12473,1 
.mob Thel'zan the Duskbringer
step << Alliance
.goto Dragonblight,78.56,48.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford|r
.turnin 12473 >>Accept An End And A Beginning
.accept 12474 >>To Fordragon Hold!
.target High Commander Halford Wyrmbane
step << skip
#completewith next
.goto Dragonblight,77.00,49.79,15,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rodney Wells|r
.target Rodney Wells
.fly Fordragon >>Fly to Fordragon Hold
.skill coldweatherflying,1,1

step << Alliance
.goto Dragonblight,37.80,23.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bolvar|r
.turnin 12474 >>Turn in To Fordragon Hold!
.accept 12495 >>Accept Audience With The Dragon Queen
.target Highlord Bolvar Fordragon
step << skip
#completewith next
.goto Dragonblight,39.52,25.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Derek Rammel|r
.target Derek Rammel
.fly Wyrmrest >>Fly to Wyrmrest Temple
.skill coldweatherflying,1,1

step << Horde
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brighthoof|r and |cRXP_FRIENDLY_Roh'kill|r
>>|cRXP_FRIENDLY_Brighthoof|r |cRXP_WARN_patrols the inner circle of the camp|r
.accept 11978 >>Accept Into the Fold
.loop 20,Dragonblight,13.64,47.93,13.81,48.20,13.96,48.66,13.95,49.36,13.87,49.58,13.70,49.36,13.57,48.99,13.59,48.72,13.41,48.44,13.20,48.45,13.22,48.71,13.43,49.12,13.29,49.86,13.31,49.50,12.86,49.17,12.83,48.79,12.77,48.55,12.96,48.02,13.47,47.90,13.64,47.93
.accept 11980 >>Accept Pride of the Horde
.goto Dragonblight,14.21,49.82
.target Emissary Brighthoof
.target Blood Guard Roh'kill
step << Horde
#completewith next
.loop 40,Dragonblight,16.62,52.57,17.42,50.93,17.24,50.26,16.73,50.06,16.22,48.17,18.67,49.16,17.42,46.06,16.67,45.26,16.47,46.34,15.98,45.76,15.60,45.63,14.58,44.33,16.62,52.57
>>Open the |cRXP_PICK_Wooden Horde Crates|r on the ground. Loot them for the |cRXP_LOOT_Horde Armaments|r
.complete 11978,1 
step << Horde
.loop 40,Dragonblight,15.59,50.43,15.69,52.15,15.49,53.75,16.74,52.32,16.67,50.90,17.78,49.21,19.55,50.59,20.84,51.76,21.55,50.53,21.92,47.37,20.42,48.28,19.11,47.29,17.72,46.94,17.23,46.15,16.64,44.94,16.11,44.58,15.14,44.36,14.48,44.82,15.43,46.45,16.73,46.89,16.79,48.60,15.59,50.43
>>Kill |cRXP_ENEMY_Anub'ar Ambushers|r
.complete 11980,1 
.mob Anub'ar Ambusher
step << Horde
.loop 40,Dragonblight,16.62,52.57,17.42,50.93,17.24,50.26,16.73,50.06,16.22,48.17,18.67,49.16,17.42,46.06,16.67,45.26,16.47,46.34,15.98,45.76,15.60,45.63,14.58,44.33,16.62,52.57
>>Open the |cRXP_PICK_Wooden Horde Crates|r on the ground. Loot them for the |cRXP_LOOT_Horde Armaments|r
.complete 11978,1 
step << Horde
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Roh'kill|r and |cRXP_FRIENDLY_Brighthoof|r
>>|cRXP_FRIENDLY_Brighthoof|r |cRXP_WARN_patrols the inner circle of the camp|r
.turnin 11980 >>Turn in Pride of the Horde
.goto Dragonblight,14.21,49.82
.turnin 11978 >>Turn in Into the Fold
.accept 11983 >>Accept Blood Oath of the Horde
.loop 20,Dragonblight,13.64,47.93,13.81,48.20,13.96,48.66,13.95,49.36,13.87,49.58,13.70,49.36,13.57,48.99,13.59,48.72,13.41,48.44,13.20,48.45,13.22,48.71,13.43,49.12,13.29,49.86,13.31,49.50,12.86,49.17,12.83,48.79,12.77,48.55,12.96,48.02,13.47,47.90,13.64,47.93
.target Blood Guard Roh'kill
.target Emissary Brighthoof
step << Horde
.goto Dragonblight,13.41,48.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Taunka'le Refugees|r
.complete 11983,1 
.target Taunka'le Refugee
.skipgossip
step << Horde
.loop 20,Dragonblight,13.64,47.93,13.81,48.20,13.96,48.66,13.95,49.36,13.87,49.58,13.70,49.36,13.57,48.99,13.59,48.72,13.41,48.44,13.20,48.45,13.22,48.71,13.43,49.12,13.29,49.86,13.31,49.50,12.86,49.17,12.83,48.79,12.77,48.55,12.96,48.02,13.47,47.90,13.64,47.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brighthoof|r
>>|cRXP_FRIENDLY_Brighthoof|r |cRXP_WARN_patrols the inner circle of the camp|r
.turnin 11983 >>Turn in Blood Oath of the Horde
.accept 12008 >>Accept Agmar's Hammer
.target Emissary Brighthoof
step << Horde
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Agmar|r and |cRXP_FRIENDLY_Juktok|r
.turnin 12008 >>Turn in Agmar's Hammer
.accept 12034 >>Accept Victory Nears...
.goto Dragonblight,37.70,46.34,35,0
.goto Dragonblight,38.16,46.33
.turnin 12034 >>Turn in Victory Nears...
.accept 12036 >>Accept From the Depths of Azjol-Nerub
.goto Dragonblight,36.61,46.57
.target Overlord Agmar
.target Senior Sergeant Juktok
step << Horde
#completewith next
.goto Dragonblight,26.16,49.54,15 >> |cRXP_WARN_Jump down into The Pit of Narjun|r
step << Horde
.goto Dragonblight,26.17,50.14
>>Explore the Pit of Narjun
.complete 12036,1 
step << Horde
#completewith next
.goto Dragonblight,26.72,49.17,12,0
.goto Dragonblight,26.43,48.86,12 >> |cRXP_WARN_Exit the Pit of Narjun|r
step << Horde
.goto Dragonblight,36.61,46.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Juktok|r
.turnin 12036 >>Turn in From the Depths of Azjol-Nerub
.accept 12053 >>Accept The Might of the Horde
.target Senior Sergeant Juktok
step << Horde
#completewith next
.goto Dragonblight,25.54,40.80
.cast 47304 >>|cRXP_WARN_Use the|r |T132484:0|t[Warsong Battle Standard]
.timer 94,The Might of the Horde RP
.use 36738
step << Horde
.goto Dragonblight,25.54,40.80
>>|cRXP_WARN_Protect the|r |cRXP_FRIENDLY_Warsong Battle Standard|r|cRXP_WARN_. Kill the |cRXP_ENEMY_Anub'ar Invaders|r that attack it|r
.complete 12053,1 
.mob Anub'ar Invader
.use 36738
step << Horde
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Juktok|r and |cRXP_FRIENDLY_Valnok|r
.turnin 12053 >>Turn in The Might of the Horde
.accept 12071 >>Accept Attack by Air!
.goto Dragonblight,36.61,46.57
.turnin 12071 >>Turn in Attack by Air!
.accept 12072 >>Accept Blightbeasts be Damned!
.goto Dragonblight,37.21,45.71
.target Senior Sergeant Juktok
.target Valnok Windrager
step << Horde
#label IcemistV
#completewith Blightbeast
.goto Dragonblight,25.64,45.31,120 >> Travel to Icemist Village
step << Horde
#requires IcemistV
#label IcemistV2
#completewith Blightbeast
.goto Dragonblight,27.56,45.00
.cast 47423 >>|cRXP_WARN_Use|r |T134536:0|t[Valnok's Flare Gun] |cRXP_WARN_whilst in Icemist Village|r
.timer 2,Blightbeasts be Damned! RP
.use 36774
.isOnQuest 12072
step << Horde
#requires IcemistV2
#completewith next
.vehicle >> Mount the |cRXP_FRIENDLY_War Rider|r

.isOnQuest 12072

step << Horde
#label Blightbeast
.goto Dragonblight,26.62,47.13,50,0
.goto Dragonblight,25.35,47.48,50,0
.goto Dragonblight,24.08,47.37,50,0
.goto Dragonblight,23.47,40.70,50,0
.goto Dragonblight,22.59,38.85,50,0
.goto Dragonblight,24.15,37.16,50,0
.goto Dragonblight,25.75,37.13,50,0
.goto Dragonblight,27.31,37.88,50,0
.goto Dragonblight,27.02,40.12,50,0
.goto Dragonblight,26.62,47.13,50,0
.goto Dragonblight,25.35,47.48
>>|cRXP_WARN_Cast|r |T135786:0|t[Big Blue] (2) |cRXP_WARN_and|r |T135780:0|t[Blightbeast Bane] (1) |cRXP_WARN_to kill|r |cRXP_ENEMY_Anub'ar Blightbeasts|r
>>|cRXP_WARN_Cast|r |T135769:0|t[Field Medi-pack] |cRXP_WARN_to heal your|r |cRXP_FRIENDLY_War Rider|r
.complete 12072,1 
.mob Anub'ar Blightbeast
.use 36774
step << Horde
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Valnok|r and |cRXP_FRIENDLY_Icemist|r
.turnin 12072 >>Turn in Blightbeasts be Damned!
.goto Dragonblight,37.21,45.71
.accept 12063 >>Accept Strength of Icemist
.goto Dragonblight,35.82,47.04,40,0
.goto Dragonblight,35.75,45.95,40,0
.goto Dragonblight,36.02,45.56,40,0
.goto Dragonblight,36.32,45.20,40,0
.goto Dragonblight,36.62,45.51
.target Valnok Windrager
.target Greatmother Icemist
step << Horde
.goto Dragonblight,22.60,41.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Banthok|r
>>|cRXP_FRIENDLY_Banthok|r |cRXP_WARN_is under the cliff face next to the river|r
.turnin 12063 >>Turn in Strength of Icemist
.accept 12064 >>Accept Chains of the Anub'ar
.target Banthok Icemist
step << Horde
.goto Dragonblight,24.98,44.88,15,0
.goto Dragonblight,24.94,43.92
>>Enter the cave under the balcony
>>Kill |cRXP_ENEMY_Anok'ra the Manipulator|r. Loot him for |cRXP_LOOT_Anok'ra's Key Fragment|r
.complete 12064,1 
.mob Anok'ra the Manipulator
step << Horde
#completewith next
.goto Dragonblight,26.20,44.50,40,0
.goto Dragonblight,24.32,44.46,40,0
.goto Dragonblight,23.89,44.86,40,0
.goto Dragonblight,26.20,44.50,40,0
.goto Dragonblight,24.32,44.46,40,0
>>Kill |cRXP_ENEMY_Sinok the Shadowrager|r. Loot him for |cRXP_LOOT_Sinok's Key Fragment|r
>>He can be found all along the balcony
.complete 12064,3 
.mob Sinok the Shadowrager
step << Horde
.goto Dragonblight,26.75,39.04,30,0
.goto Dragonblight,23.87,39.10,30,0
.goto Dragonblight,26.75,39.04,30,0
.goto Dragonblight,23.87,39.10,30,0
.goto Dragonblight,26.75,39.04,30,0
.goto Dragonblight,23.87,39.10,30,0
.goto Dragonblight,23.87,39.13
>>Kill |cRXP_ENEMY_Tivax the Breaker|r. loot him for |cRXP_LOOT_Tivax's Key Fragment|r
>>He can be found in the north east or north west buildings in Icemist
.complete 12064,2 
.mob Tivax the Breaker
step << Horde
.goto Dragonblight,26.20,44.50,40,0
.goto Dragonblight,24.32,44.46,40,0
.goto Dragonblight,23.89,44.86,40,0
.goto Dragonblight,26.20,44.50,40,0
.goto Dragonblight,24.32,44.46,40,0
.goto Dragonblight,23.89,44.86
>>Kill |cRXP_ENEMY_Sinok the Shadowrager|r. Loot him for |cRXP_LOOT_Sinok's Key Fragment|r
>>He can be found all along the balcony
.complete 12064,3 
.mob Sinok the Shadowrager
step << Horde
.goto Dragonblight,22.60,41.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Banthok|r
>>|cRXP_FRIENDLY_Banthok|r |cRXP_WARN_is under the cliff face next to the river|r
.turnin 12064 >>Turn in Chains of the Anub'ar
.accept 12069 >>Accept Return of the High Chief
.target Banthok Icemist
step << Horde
#completewith next
.goto Dragonblight,25.56,40.90
.cast 47412 >>Click the |cRXP_PICK_Anub'ar Mechanism|r
.timer 56,Return of the High Chief RP
step << Horde
.goto Dragonblight,25.12,39.76
>>|cRXP_WARN_Wait out the RP|r
>>Kill |cRXP_ENEMY_Under-King Anub'et'kan|r. Open |cRXP_PICK_Anub'et'Kan's Carapace|r that drops next to him. Loot it for the |cRXP_LOOT_Fragment of Anub'et'kan's Husk|r
.complete 12069,1 
.mob Under-King Anub'et'kan
step << Horde
.goto Dragonblight,37.70,46.34,35,0
.goto Dragonblight,38.16,46.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Agmar|r
.turnin 12069 >>Turn in Return of the High Chief
.accept 12140 >>Accept All Hail Roanauk!
.target Overlord Agmar
step << Horde
.goto Dragonblight,36.25,45.44
.gossipoption 93081 >> Talk to |cRXP_FRIENDLY_Roanauk|r to start his RP
.timer 41,All Hail Roanauk! RP
.target Roanauk Icemist
.skipgossip
.isOnQuest 12140
step << Horde
#completewith next
>>|cRXP_WARN_Wait out the RP|r
.complete 12140,1 
step << Horde
.goto Dragonblight,36.33,45.59,5,0
.goto Dragonblight,37.70,46.34,35,0
.goto Dragonblight,38.16,46.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Agmar|r
.turnin 12140 >>Turn in All Hail Roanauk!
.target Overlord Agmar
step << Horde
.goto Dragonblight,36.08,48.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malefious|r
.accept 12189 >>Accept Imbeciles Abound!
.target Doctor Sintar Malefious
step << Horde Mage
#completewith next
.goto Dragonblight,76.87,62.96,10 >> Enter the building
step << Horde Mage
.goto Dragonblight,76.87,63.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Winterby|r
.home >> Set your Hearthstone to Venomspite
.target Mrs. Winterby
step << Horde
#completewith next
.goto Dragonblight,77.58,62.47,12 >> Enter the building
step << Horde
.goto Dragonblight,77.67,62.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Middleton|r
.turnin 12189 >>Turn in Imbeciles Abound!
.accept 12188 >>Accept The Forsaken Blight and You: How Not to Die
.target Chief Plaguebringer Middleton
step << Horde
.loop 50,Dragonblight,80.30,72.14,80.41,72.77,80.71,73.30,81.01,73.83,81.16,73.50,81.07,72.96,81.21,72.15,81.57,70.10,82.11,70.34,83.05,69.76,83.88,69.91,84.45,69.48,83.95,68.15,83.68,68.48,83.20,68.20,82.01,68.51,82.13,69.57,80.30,72.14
>>Kill |cRXP_ENEMY_Forgotten Captains|r, |cRXP_ENEMY_Forgotten Riflemen|r, |cRXP_ENEMY_Forgotten Peasants|r, |cRXP_ENEMY_Forgotten Knights|r, and |cRXP_ENEMY_Forgotten Footmen|r. Loot them for their |cRXP_LOOT_Ectoplasmic Residue|r
.complete 12188,1 
.mob Forgotten Captain
.mob Forgotten Rifleman
.mob Forgotten Peasant
.mob Forgotten Knight
.mob Forgotten Footman
step << Horde
.goto Dragonblight,77.67,62.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Middleton|r
.turnin 12188 >>Turn in The Forsaken Blight and You: How Not to Die
.accept 12200 >>Accept Emerald Dragon Tears
.target Chief Plaguebringer Middleton
step << Horde
.loop 45,Dragonblight,65.98,74.85,65.80,73.45,63.38,72.67,62.61,72.31,61.79,72.85,62.34,74.64,61.83,75.18,63.32,76.33,63.51,74.90,62.88,74.77,63.39,72.67,64.74,73.58,64.49,74.90,64.67,75.71,64.73,76.50,65.36,75.86,65.98,74.85
>>Loot |cRXP_LOOT_Emerald Dragon Tears|r on the ground
.complete 12200,1 
step << Horde Mage
#completewith next
.hs >> Hearth to Venomspite
step << Horde
.goto Dragonblight,77.67,62.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Middleton|r
.turnin 12200 >>Turn in Emerald Dragon Tears
.accept 12218 >>Accept Spread the Good Word
.target Chief Plaguebringer Middleton
step << Horde
#completewith next
.goto Dragonblight,77.79,61.48
.vehicle >>Get into a |cRXP_FRIENDLY_Forsaken Blight Spreader|r
.target Forsaken Blight Spreader
step << Horde
.goto Dragonblight,85.05,55.35
>>Cast |T135799:0|t[Blight Bomb] (1) on the |cRXP_ENEMY_Hungering Dead|r to kill them
>>|cRXP_WARN_You can bodypull the |cRXP_ENEMY_Hungering Dead|r into the Blight Cloud that spawns from the|r |T135799:0|t[Blight Bomb]
.complete 12218,1 
.mob Hungering Dead
step << Horde
.goto Dragonblight,77.67,62.79
>>|cRXP_WARN_Dismount the|r |cRXP_FRIENDLY_Forsaken Blight Spreader|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Middleton|r
.turnin 12218 >>Turn in Spread the Good Word
.accept 12221 >>Accept The Forsaken Blight
.target Chief Plaguebringer Middleton
step << Horde
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Malefious|r and |cRXP_FRIENDLY_Agmar|r
.turnin 12221 >>Turn in The Forsaken Blight
.goto Dragonblight,36.08,48.89
.accept 12224 >>Accept The Kor'kron Vanguard!
.goto Dragonblight,38.16,46.33
.target Doctor Sintar Malefious
.target Overlord Agmar
step << Horde
.goto Dragonblight,40.71,18.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Saurfang|r
.turnin 12224 >>Turn in The Kor'kron Vanguard!
.accept 12496 >>Accept Audience With The Dragon Queen
.target Saurfang the Younger
step << Horde
.goto Dragonblight,43.85,16.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Numo|r
.fp Kor'koron Vanguard>> Get the Kor'koron Vanguard flight path
.target Numo Spiritbreeze

step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alexstrasza|r and |cRXP_FRIENDLY_Torastrasza|r atop Wyrmrest Temple
.turnin 12495 >>Turn in Audience With The Dragon Queen << Alliance
.turnin 12496 >>Turn in Audience With The Dragon Queen << Horde
.accept 12497 >>Accept Galakrond and the Scourge
.goto Dragonblight,59.84,54.66
.turnin 12497 >>Turn in Galakrond and the Scourge
.accept 12498 >>Accept On Ruby Wings
.goto Dragonblight,59.51,53.33
.target Alexstrasza the Life-Binder
.target Torastrasza
step
#completewith next
.cast 50426 >>Use the |T134124:0|t[Ruby Beacon of the Dragon Queen] to summon a |cRXP_FRIENDLY_Wyrmrest Vanquisher|r
.use 38302
step
.vehicle >> Mount the |cRXP_FRIENDLY_Wyrmrest Vanquisher|r
.target Wyrmrest Vanquisher
.use 38302
.isOnQuest 12498
step
#completewith next
>>Cast |T135808:0|t[Engulfing Fireball] (2) to kill |cRXP_ENEMY_Waste Scavengers|r
>>Cast |T132278:0|t[Devour Ghoul] (3) on a |cRXP_ENEMY_Waste Scavenger|r to regain Health and Mana
.complete 12498,1 
.mob Wastes Scavenger
.use 38302
step
.goto Dragonblight,54.36,31.16
>>Cast |T135808:0|t[Engulfing Fireball] (2) to kill |cRXP_ENEMY_Thiassi the Lighting Bringer|r
>>|cRXP_WARN_Wait out the RP after killing him|r
>>Kill |cRXP_ENEMY_Grand Necrolord Antiok|r after he dismounts you
>>Loot the |cRXP_LOOT_Scythe of Antiok|r that drops on the ground
>>Cast |T132278:0|t[Devour Ghoul] (3) on a |cRXP_ENEMY_Waste Scavenger|r to regain Health and Mana
.complete 12498,2 
.mob Thiassi the Lightning Bringer
.mob Grand Necrolord Antiok
.use 38302
step
#completewith next
.cast 50426 >>Use the |T134124:0|t[Ruby Beacon of the Dragon Queen] to summon a |cRXP_FRIENDLY_Wyrmrest Vanquisher|r
.use 38302
step
#completewith next
.vehicle >> Mount the |cRXP_FRIENDLY_Wyrmrest Vanquisher|r
.target Wyrmrest Vanquisher
.use 38302
.isOnQuest 12498
step
.loop 50,Dragonblight,54.77,32.99,54.12,33.58,53.52,34.71,53.63,35.42,54.60,36.18,55.06,37.07,55.92,36.00,57.82,35.82,58.39,34.86,57.84,33.30,57.48,32.02,54.77,32.99
>>Cast |T135808:0|t[Engulfing Fireball] (2) to kill |cRXP_ENEMY_Waste Scavengers|r. Cast "Devour Ghoul" (3) in melee range of a Ghoul to recover Health and Mana.
>>Cast |T132278:0|t[Devour Ghoul] (2) on a |cRXP_ENEMY_Waste Scavenger|r to regain Health and Mana
.complete 12498,1 
.mob Wastes Scavenger
.use 38302
step
.goto Dragonblight,59.84,54.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alexstrasza|r
.turnin 12498 >>Turn in On Ruby Wings
.accept 12499 >>Accept Return to Angrathar << Alliance
.accept 12500 >>Accept Return to Angrathar << Horde
.target Alexstrasza the Life-Binder
step << skip
#completewith next
.goto Dragonblight,59.51,53.33
.fly >>Speak to |cRXP_FRIENDLY_Torastrasza|r to fly to the base of Wyrmrest Temple
.target Torastrasza
.skipgossip 1
.skill coldweatherflying,1,1
step << skip
#completewith next
.goto Dragonblight,60.32,51.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nethestrasz|r
.target Nethestrasz
.fly Fordragon >>Fly to Fordragon Hold
.skill coldweatherflying,1,1

step << Alliance
.goto Dragonblight,37.80,23.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bolvar|r
>>|cRXP_WARN_Press "Escape" on your keyboard to skip the cinematic|r
.turnin 12499 >>Turn in Return to Angrathar
.target Highlord Bolvar Fordragon
step << skip
#completewith next
.goto Dragonblight,39.52,25.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Derek Rammel|r
.target Derek Rammel
.fly Wintergarde Keep >>Fly to Wintergarde Keep
.skill coldweatherflying,1,1

step << Horde
.goto Dragonblight,40.71,18.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Saurfang|r
>>|cRXP_WARN_Press "Escape" on your keyboard to skip the cinematic|r
.turnin 12500 >>Turn in Return to Angrathar
.target Saurfang the Younger
step << Horde
.goto Dragonblight,38.41,19.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alexstrasza|r
.accept 13242 >>Accept Darkness Stirs
.target Alexstrasza the Life-Binder
step << Horde
.goto Dragonblight,38.16,18.70
>>Loot |cRXP_LOOT_Saurfang's Battle Armor|r on the ground
.complete 13242,1 
step << Horde !Mage
#completewith next
.hs >> Hearth to Dalaran
.zoneskip BoreanTundra
step << Horde !Mage
#completewith next
goto Dalaran,63.57,32.58,12,0
goto Dalaran,60.60,31.95,12,0
goto Dalaran,55.34,25.46
.zone Orgrimmar >> Take the Portal to Orgrimmar
.isOnQuest 13242
step << Horde Mage
#completewith next
.cast 3567 >> Cast [Teleport: Orgrimmar]
.zoneskip Orgrimmar
step << Horde
.goto Orgrimmar,38.88,77.71,40,0
.goto Orgrimmar,41.70,74.14,40,0
.goto Orgrimmar,52.06,85.40,30,0
.goto Orgrimmar,52.25,88.76,20,0
.goto Orgrimmar,49.33,91.08,20,0
.goto Orgrimmar,48.42,95.10,20,0
.goto Durotar,44.38,13.67
.zone Durotar >> Exit Orgrimmar
.zoneskip BoreanTundra
.isOnQuest 13242
step << Horde
#completewith next
.goto Durotar,41.69,18.11,10,0
.goto Durotar,41.54,18.40,6,0
.goto Durotar,41.45,18.30,6,0
.goto Durotar,41.54,18.40,6,0
.goto Durotar,41.45,18.30,6,0
.goto Durotar,41.54,18.40,6,0
.goto Durotar,41.45,18.30,6,0
.goto Durotar,41.42,17.98,6 >>Go up the Zeppelin Tower
step << Horde
.goto Durotar,41.42,17.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Greeb|r
.zone BoreanTundra >>Teleport to Warsong Hold
.target Greeb Ramrocket
.skipgossip
.isOnQuest 13242
step << Horde
.goto BoreanTundra,41.37,53.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Saurfang|r
>>|cRXP_FRIENDLY_Saurfang|r is on the bottom floor of Warsong Hold
.turnin 13242 >>Turn in Darkness Stirs
.target High Overlord Saurfang
step << Horde
.goto BoreanTundra,41.59,53.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kaelana|r
.accept 12791 >> Accept The Magical Kingdom of Dalaran
.zone Dalaran >>Teleport to Dalaran
.target Magistrix Kaelana
.skipgossip
.isQuestAvailable 12791
.zoneskip BoreanTundra,1
step << Horde
#completewith next
.abandon 12791 >> Abandon The Magical Kingdom of Dalaran
>>|cRXP_WARN_===DO NOT TURN THIS IN===|r
step
#completewith next
.zone ZulDrak >> Travel to Zul'Drak
step
.goto ZulDrak,42.69,48.53,45,0
.goto ZulDrak,42.39,41.83,45,0
.goto ZulDrak,41.15,47.42,45,0
.goto ZulDrak,39.18,44.84,45,0
.goto ZulDrak,38.21,41.78,45,0
.goto ZulDrak,42.69,48.53,45,0
.goto ZulDrak,42.39,41.83,45,0
.goto ZulDrak,41.15,47.42,45,0
.goto ZulDrak,39.18,44.84,45,0
.goto ZulDrak,38.21,41.78
>>Kill |cRXP_ENEMY_Champions of Sseratus|r and |cRXP_ENEMY_Priests of Sseratus|r. Loot them for their |T134810:0|t[|cRXP_LOOT_Strange Mojo|r]
>>|cRXP_WARN_Use the |T134810:0|t[|cRXP_LOOT_Strange Mojo|r] to start the quest|r
.collect 38321,1,12507,1 
.accept 12507 >>Accept Strange Mojo
.mob Champion of Sseratus
.mob Priest of Sseratus
.use 38321
step
.goto ZulDrak,40.52,65.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ubungo|r
.turnin 12507 >>Turn in Strange Mojo
.accept 12510 >>Accept Precious Elemental Fluids
.target Hexxer Ubungo
step
.loop 50,ZulDrak,41.34,71.92,42.81,76.28,45.88,79.42,43.77,80.28,43.18,83.16,41.53,78.86,38.65,75.65,40.83,74.73,41.34,71.92
>>Kill |cRXP_ENEMY_Crazed Water Spirits|r. Loot them for their |T135834:0|t[|cRXP_LOOT_Water Elemental Links|r]
.collect 38323,3 
.isOnQuest 12510
step
.goto ZulDrak,42.16,77.60
>>Turn your |T135834:0|t[|cRXP_LOOT_Water Elemental Links|r] into a |T136039:0|t[|cRXP_PICK_Tether to the Plane of Water|r]
>>|cRXP_WARN_You MUST do this to be able to loot|r |T135834:0|t[|cRXP_LOOT_Water Elemental Links|r] |cRXP_WARN_again|r
.collect 38324,1 
.use 38323
.isOnQuest 12510
step
.goto ZulDrak,42.16,77.60
>>Use the |T136039:0|t[|cRXP_PICK_Tether to the Plane of Water|r] to summon a |cRXP_ENEMY_Watery Lord|r. Kill him. Loot him for a |cRXP_LOOT_Precious Elemental Fluid|r
.collect 38324,1,12510,1,-1 
.complete 12510,1,1 
.mob Watery Lord
.use 38324
step
.loop 50,ZulDrak,41.34,71.92,42.81,76.28,45.88,79.42,43.77,80.28,43.18,83.16,41.53,78.86,38.65,75.65,40.83,74.73,41.34,71.92
>>Kill |cRXP_ENEMY_Crazed Water Spirits|r. Loot them for their |T135834:0|t[|cRXP_LOOT_Water Elemental Links|r]
.collect 38323,3 
.isOnQuest 12510
step
.goto ZulDrak,42.16,77.60
>>Turn your |T135834:0|t[|cRXP_LOOT_Water Elemental Links|r] into a |T136039:0|t[|cRXP_PICK_Tether to the Plane of Water|r]
>>|cRXP_WARN_You MUST do this to be able to loot|r |T135834:0|t[|cRXP_LOOT_Water Elemental Links|r] |cRXP_WARN_again|r
.collect 38324,1 
.use 38323
.isOnQuest 12510
step
.goto ZulDrak,42.16,77.60
>>Use the |T136039:0|t[|cRXP_PICK_Tether to the Plane of Water|r] to summon a |cRXP_ENEMY_Watery Lord|r. Kill him. Loot him for a |cRXP_LOOT_Precious Elemental Fluid|r
.collect 38324,2,12510,1,-1 
.complete 12510,1,2 
.mob Watery Lord
.use 38324
step
.loop 50,ZulDrak,41.34,71.92,42.81,76.28,45.88,79.42,43.77,80.28,43.18,83.16,41.53,78.86,38.65,75.65,40.83,74.73,41.34,71.92
>>Kill |cRXP_ENEMY_Crazed Water Spirits|r. Loot them for their |T135834:0|t[|cRXP_LOOT_Water Elemental Links|r]
.collect 38323,3 
.isOnQuest 12510
step
.goto ZulDrak,42.16,77.60
>>Turn your |T135834:0|t[|cRXP_LOOT_Water Elemental Links|r] into a |T136039:0|t[|cRXP_PICK_Tether to the Plane of Water|r]
>>|cRXP_WARN_You MUST do this to be able to loot|r |T135834:0|t[|cRXP_LOOT_Water Elemental Links|r] |cRXP_WARN_again|r
.collect 38324,1 
.use 38323
.isOnQuest 12510
step
#label Fluid1
.goto ZulDrak,42.16,77.60
>>Use the |T136039:0|t[|cRXP_PICK_Tether to the Plane of Water|r] to summon a |cRXP_ENEMY_Watery Lord|r. Kill him. Loot him for a |cRXP_LOOT_Precious Elemental Fluid|r
.collect 38324,3,12510,1,-1 
.complete 12510,1 
.mob Watery Lord
.use 38324
step
.goto ZulDrak,40.52,65.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ubungo|r
.turnin 12510 >>Turn in Precious Elemental Fluids
.accept 12514 >>Accept Mushroom Mixer
.target Hexxer Ubungo
step
.loop 40,ZulDrak,42.79,63.03,43.09,65.36,43.68,66.33,43.36,67.64,46.36,66.27,45.43,67.49,45.59,69.12,44.76,69.03,44.83,70.24,44.78,72.01,42.79,63.03
>>Loot the |cRXP_LOOT_Muddlecap Fungus|r on the ground
.complete 12514,1 
step
.goto ZulDrak,40.52,65.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Ubungo|r
.turnin 12514 >>Turn in Mushroom Mixer
.accept 12516 >>Accept Too Much of a Good Thing
.target Hexxer Ubungo
step
#completewith next
.cast 50706 >>Use the |T134731:0|t[Modified Mojo] on the |cRXP_ENEMY_Prophet of Sseratus|r to transform him into the |cRXP_ENEMY_Muddled Prophet of Sseratus|r
.timer 5,Too Much of a Good Thing RP
.mob Prophet of Sseratus
.use 38332
step
.goto ZulDrak,40.46,42.52
>>|cRXP_WARN_Wait out the RP|r
>>Kill the |cRXP_ENEMY_Muddled Prophet of Sseratus|r
.complete 12516,1 
.mob Muddled Prophet of Sseratus
.use 38332
step
.goto ZulDrak,40.52,65.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Ubungo|r
.turnin 12516 >>Turn in Too Much of a Good Thing
.accept 12623 >>Accept To the Witch Doctor
.target Hexxer Ubungo
step
.goto ZulDrak,60.04,56.71
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Maaka|r
.fp Zim'Torga >>Get the Zim'Torga Flight Path
.target Maaka
step
.goto ZulDrak,59.50,58.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Khufu|r
.turnin 12623 >>Turn in To the Witch Doctor
.accept 12627 >>Accept Breaking Through Jin'Alai
.target Witch Doctor Khufu
step
>>Click the |cRXP_PICK_Cauldrons|r
.complete 12627,3 
.goto ZulDrak,57.62,61.73,-1
.complete 12627,4 
.goto ZulDrak,58.78,62.70,-1
.complete 12627,2 
.goto ZulDrak,55.68,64.32,-1
.complete 12627,1 
.goto ZulDrak,57.21,65.35,-1
step
.goto ZulDrak,59.50,58.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Khufu|r
.turnin 12627 >>Turn in Breaking Through Jin'Alai
.accept 12628 >>Accept To Speak With Har'koa
.target Witch Doctor Khufu
step
.goto ZulDrak,63.71,70.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Har'koa|r
.turnin 12628 >>Turn in To Speak With Har'koa
.accept 12632 >>Accept But First My Offspring
.target Har'koa
step
.loop 50,ZulDrak,64.47,69.12,65.29,68.10,64.09,67.15,64.09,65.16,62.72,65.24,62.63,67.29,61.63,68.48,60.36,68.09,61.92,70.69,61.38,72.30,63.01,71.67,64.47,69.12,65.29,68.10,64.09,67.15,64.09,65.16,62.72,65.24,62.63,67.29,61.63,68.48,60.36,68.09,61.92,70.69,61.38,72.30,63.01,71.67,64.47,69.12
>>Kill |cRXP_ENEMY_Cursed Offsprings of Har'Koa|r. |cRXP_WARN_Use the|r |T134324:0|t[Whisker of Har'koa] |cRXP_WARN_on their corpses|r
.complete 12632,1 
.mob Cursed Offspring of Har'koa
.use 38676
step
.goto ZulDrak,63.71,70.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Har'koa|r
.turnin 12632 >>Turn in But First My Offspring
.accept 12642 >>Accept Spirit of Rhunok
.target Har'koa
step
.goto ZulDrak,53.39,39.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Spirit of Rhunok|r
.turnin 12642 >>Turn in Spirit of Rhunok
.accept 12646 >>Accept My Prophet, My Enemy
.target Spirit of Rhunok
step
.goto ZulDrak,54.07,47.54
>>Kill the |cRXP_ENEMY_Prophet of Rhunok|r underwater. Loot him for his |cRXP_LOOT_Mojo|r
.complete 12646,1 
.mob Prophet of Rhunok
step
.goto ZulDrak,53.39,39.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Spirit of Rhunok|r
.turnin 12646 >>Turn in My Prophet, My Enemy
.accept 12647 >>Accept An End to the Suffering
.target Spirit of Rhunok
step
#completewith next
.goto ZulDrak,53.38,35.79
>>Kill |cRXP_ENEMY_Rhunok's Tormentor|r. Loot him for his |T132855:0|t[|cRXP_LOOT_Tormentor's Incense|r]
.collect 38696,1,12647,1 
.mob Rhunok's Tormentor
step
#completewith next
.goto ZulDrak,53.50,34.45
.cast 51964 >>Use the |T132855:0|t[|cRXP_LOOT_Tormentor's Incense|r] on |cRXP_ENEMY_Rhunok|r
.timer 8,Rhunok RP
.target Rhunok
.use 38696
step
.goto ZulDrak,53.50,34.45
>>Kill |cRXP_ENEMY_Rhunok|r
.complete 12647,1 
.mob Rhunok
.use 38696
step
.goto ZulDrak,53.39,39.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Spirit of Rhunok|r
.turnin 12647 >>Turn in An End to the Suffering
.accept 12653 >>Accept Back to Har'koa
.target Spirit of Rhunok
step
.goto ZulDrak,63.71,70.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Har'koa|r
.turnin 12653 >>Turn in Back to Har'koa
.accept 12665 >>Accept I Sense a Disturbance
.target Har'koa
step
#completewith next
.goto ZulDrak,63.71,70.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t Talk to |cRXP_FRIENDLY_Har'koa|r
.vehicle >>Mount one of |cRXP_FRIENDLY_Har'koa's Kittens|r
.target Har'koa
.skipgossip 28401,1
.timer 131,I Sense a Disturbance RP
step
.goto ZulDrak,63.71,70.42,0
.goto ZulDrak,75.79,58.45
>>|cRXP_WARN_Wait out the RP|r
.complete 12665,1 
step
.goto ZulDrak,63.71,70.42
>>|cRXP_WARN_Dismount|r |cRXP_FRIENDLY_Har'koa's Kitten|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Har'Koa|r
.turnin 12665 >>Turn in I Sense a Disturbance
.accept 12666 >>Accept Preparations for the Underworld
.target Har'koa
step
.loop 50,ZulDrak,65.10,70.24,62.58,66.02,62.10,67.85,60.82,68.58,63.60,72.48,63.71,70.42,65.10,70.24
>>Kill |cRXP_ENEMY_Har'koan Subduers|r and |cRXP_ENEMY_Claws of Har'koa|r. Loot them for their |cRXP_LOOT_Adornments|r
.complete 12666,1 
.mob Har'koan Subduer
.mob Claw of Har'koa
step
.goto ZulDrak,63.71,70.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Har'koa|r
.turnin 12666 >>Turn in Preparations for the Underworld
.accept 12667 >>Accept Seek the Wind Serpent Goddess
.target Har'koa
]])
RXPGuides.RegisterGuide([[
#version 23
#wotlk
#group RestedXP Completionist Guides
#name Emblems of Heroism 2 - The Storm Peaks
#next Emblems of Heroism 3 - Icecrown
step
#completewith next
.hs >> Hearth to Dalaran << !Mage
.cast 53140 >> Cast |T237509:0|t[Teleport: Dalaran] << Mage
.zoneskip TheStormPeaks
.zoneskip Dalaran
step
#completewith next
.zone TheStormPeaks >> Travel to The Storm Peaks
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jeer|r, |cRXP_FRIENDLY_Gretchen|r, and |cRXP_FRIENDLY_Ricket|r
.accept 12818 >>Accept Clean Up
.goto TheStormPeaks,41.03,86.43
.accept 12843 >>Accept They Took Our Men!
.goto TheStormPeaks,41.01,85.95,10,0
.goto TheStormPeaks,41.15,86.14
.accept 12827 >>Accept Reclaimed Rations
.accept 12836 >>Accept Expression of Gratitude
.goto TheStormPeaks,40.93,85.30
.target Jeer Sparksocket
.target Gretchen Fizzlespark
.target Ricket
step
.loop 60,TheStormPeaks,40.18,87.59,39.78,88.32,38.70,87.45,39.66,86.86,38.86,84.78,39.61,84.65,40.18,87.59
>>Loot the |cRXP_LOOT_Charred Wreckage|r on the ground
.complete 12818,1 
step
.goto TheStormPeaks,41.03,86.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jeer|r
.turnin 12818 >>Turn in Clean Up
.accept 12819 >>Accept Just Around the Corner
step
.goto TheStormPeaks,35.09,87.79
>>Fly into the middle of the Minefield
>>Loot |cRXP_LOOT_Sparksocket's Tools|r on the ground
.complete 12819,1 

step
#completewith next
.goto TheStormPeaks,31.81,85.75,70,0
>>Loot the |cRXP_LOOT_Dried Gnoll Rations|r on the ground
>>Kill |cRXP_ENEMY_Savage Hill Scavengers|r, |cRXP_ENEMY_Savage Hill Mystics|r, and |cRXP_ENEMY_Savage Hill Brutes|r. Loot them for their |cRXP_LOOT_Dried Gnoll Rations|r
>>|cRXP_WARN_Focus on looting the |cRXP_LOOT_Dried Gnoll Rations|r from the|r |cRXP_PICK_Wooden Boxes|r
.complete 12827,1 
.mob Savage Hill Scavenger
.mob Savage Hill Mystic
.mob Savage Hill Brute
step
.goto TheStormPeaks,30.38,85.65
>>Kill |cRXP_ENEMY_Gnarlhide|r
.complete 12836,1 
.mob Gnarlhide
step
.loop 50,TheStormPeaks,30.19,86.24,30.93,86.08,31.26,86.35,32.10,85.93,31.85,85.05,31.22,84.33,30.61,85.34,30.19,86.24
>>Loot the |cRXP_LOOT_Dried Gnoll Rations|r on the ground
>>Kill |cRXP_ENEMY_Savage Hill Scavengers|r, |cRXP_ENEMY_Savage Hill Mystics|r, and |cRXP_ENEMY_Savage Hill Brutes|r. Loot them for their |cRXP_LOOT_Dried Gnoll Rations|r
>>|cRXP_WARN_Focus on looting the |cRXP_LOOT_Dried Gnoll Rations|r from the|r |cRXP_PICK_Wooden Boxes|r
.complete 12827,1 
.mob Savage Hill Scavenger
.mob Savage Hill Mystic
.mob Savage Hill Brute
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jeer|r and |cRXP_FRIENDLY_Ricket|r
.turnin 12819 >>Turn in Just Around the Corner
.accept 12826 >>Accept Slightly Unstable
.goto TheStormPeaks,41.03,86.43
.turnin 12826 >>Turn in Slightly Unstable
.accept 12820 >>Accept A Delicate Touch
.turnin 12827 >>Turn in Reclaimed Rations
.turnin 12836 >>Turn in Expression of Gratitude
.accept 12828 >>Accept Ample Inspiration
.goto TheStormPeaks,40.93,85.30
.target Jeer Sparksocket
.target Ricket
step
#completewith next
.goto TheStormPeaks,40.75,84.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Skizzle|r
.fp K3 >>Get the K3 Flight Path
.target Skizzle Slickslide
step
.goto TheStormPeaks,43.4,82.3
>>Use the |T134954:0|t[Improved Land Mines] to kill |cRXP_ENEMY_Snowblind Followers|r and |cRXP_ENEMY_Garm Attackers|r
>>You can also kill them without the |T134954:0|t[Improved Land Mines]
>>|cRXP_WARN_The |cRXP_ENEMY_Snowblind Followers|r and |cRXP_ENEMY_Garm Attackers|r don't aggro you, even when you attack them|r
.complete 12820,1 
.mob Snowblind Follower
.mob Garm Invader
.use 40676
step
.pin The Storm Peaks,41.63,80.01,Use the U.D.E.D. Dispenser next to |cRXP_FRIENDLY_Tore Rumblewrench|r
.waypoint The Storm Peaks,41.63,80.01,0,bombdispenser,BAG_UPDATE_DELAYED
.goto TheStormPeaks,37.63,83.85,60,0
.goto TheStormPeaks,35.97,83.22
>>|cRXP_WARN_Click the |cRXP_PICK_U.D.E.D. Dispenser|r to get a|r |T133712:0|t[U.D.E.D.]
>>|cRXP_WARN_The|r |T133712:0|t[U.D.E.D.] |cRXP_WARN_will explode in your bags if not used within 45 seconds|r
>>|cRXP_WARN_Use the|r |T133712:0|t[U.D.E.D.] |cRXP_WARN_on an|r |cRXP_ENEMY_Ironwool Mammoth|r
>>Open the |cRXP_PICK_Mammoth Carcass|r and then the |cRXP_PICK_Mammoth Meat|r on the ground. Loot it for the |cRXP_LOOT_Hearty Mammoth Meat|r
.collect 40686,1,12828,1,1 
.complete 12828,1 
.mob Ironwool Mammoth
.use 40686
.skipgossip
.isOnQuest 12828
step
#completewith next
.goto TheStormPeaks,40.47,77.77,50 >> Enter the Cave
step
#completewith next
.goto TheStormPeaks,41.37,74.16,30,0
.goto TheStormPeaks,41.91,74.28,30,0
.goto TheStormPeaks,42.31,73.97,20 >>Travel toward the |cRXP_FRIENDLY_Injured Goblin Miner|r
step
.goto TheStormPeaks,42.31,73.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Injured Goblin Miner|r
.accept 12831 >>Accept Only Partly Forgotten
.target Injured Goblin Miner
step
#completewith next
.goto TheStormPeaks,43.10,74.24,20,0
.goto TheStormPeaks,45.96,73.72,25,0
.goto TheStormPeaks,47.13,73.28,20,0
.goto TheStormPeaks,47.06,71.83,50 >>Travel toward the |cRXP_ENEMY_Icetip Crawlers|r
step
.goto TheStormPeaks,47.06,71.83,40,0
.goto TheStormPeaks,47.75,70.50
>>Kill an |cRXP_ENEMY_Icetip Crawler|r. Loot it for the |cRXP_LOOT_Icetip Venom Sac|r
.complete 12831,1 
.mob Icetip Crawler
step
#completewith next
.goto TheStormPeaks,47.13,73.28,20,0
.goto TheStormPeaks,45.96,73.72,25,0
.goto TheStormPeaks,43.10,74.24,20,0
.goto TheStormPeaks,42.31,73.97,20 >>Travel toward the |cRXP_FRIENDLY_Injured Goblin Miner|r
step
.goto TheStormPeaks,42.31,73.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Injured Goblin Miner|r
.turnin 12831 >>Turn in Only Partly Forgotten
.accept 12832 >>Accept Bitter Departure
.target Injured Goblin Miner
step
.goto TheStormPeaks,42.31,73.97
.gossipoption 93378 >>Talk to the |cRXP_FRIENDLY_Injured Goblin Miner|r to start the escort
.target Injured Goblin Miner
.skipgossip
.isOnQuest 12832
step
.goto TheStormPeaks,40.48,74.35,30,0
.goto TheStormPeaks,40.24,74.96,30,0
.goto TheStormPeaks,40.20,78.98
>>Escort the |cRXP_FRIENDLY_Injured Goblin Miner|r out of the Cave
>>|cRXP_WARN_Make sure you stay close to the |cRXP_FRIENDLY_Injured Goblin Miner|r or you might not complete the objective|r
.complete 12832,1 
.target Injured Goblin Miner
step
.loop 30,TheStormPeaks,39.47,72.24,39.27,72.74,39.47,72.24,39.79,73.16,41.77,74.33,41.68,73.42,41.53,72.30,41.64,70.25,41.40,70.67,40.74,69.24,41.02,71.42,40.67,71.41,39.47,72.24
>>|cRXP_WARN_Fly up to Sifreldar Village|r
>>Kill |cRXP_ENEMY_Sifreldar Storm Maidens|r |cRXP_ENEMY_Sifreldar Runekeepers|r. Loot them for their |T134239:0|t[|cRXP_LOOT_Cold Iron Keys|r]
>>Use the |T134239:0|t[|cRXP_LOOT_Cold Iron Keys|r] on the |cRXP_FRIENDLY_Goblin Prisoner|r cages
.collect 40641,5,12843,1,-1
.complete 12843,1 
.target Goblin Prisoner
.mob Sifreldar Storm Maiden
.mob Sifreldar Runekeeper
step
.goto TheStormPeaks,40.93,85.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ricket|r
.turnin 12820 >>Turn in A Delicate Touch
.turnin 12828 >>Turn in Ample Inspiration
.turnin 12832 >>Turn in Bitter Departure
.accept 12821 >>Accept Cell Block Tango
.target Ricket
step
.goto TheStormPeaks,45.12,82.38
>>Loot the |T237030:0|t[|cRXP_LOOT_Transporter Power Cell|r] on the ground
.complete 12821,1 
step
.goto TheStormPeaks,50.69,81.90
>>Use the |T237030:0|t[|cRXP_LOOT_Transporter Power Cell|r] at the |cRXP_PICK_Teleportation Pad|r
.complete 12821,2 
.use 40731
step
.goto TheStormPeaks,40.93,85.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ricket|r
.turnin 12821 >>Turn in Cell Block Tango
.accept 12822 >>Accept Know No Fear
.target Ricket
step
#completewith next
.goto TheStormPeaks,41.02,85.31
.goto TheStormPeaks,50.56,81.88,15 >>|cRXP_WARN_Run into the K3 Teleporter|r
step
.goto TheStormPeaks,50.48,81.66,7,0
.goto TheStormPeaks,49.99,81.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gino|r
.accept 12823 >>Accept A Flawless Plan
.target Gino
step
#completewith Tormar
#label FrostCave
.goto TheStormPeaks,48.36,80.79,50 >>Enter the cave
step
#requires FrostCave
#completewith Tormar
.goto TheStormPeaks,49.06,78.73,15,0
.goto TheStormPeaks,49.80,79.16,20,0
.goto TheStormPeaks,50.28,78.62,20,0
.goto TheStormPeaks,50.38,78.08,20,0
.goto TheStormPeaks,50.24,77.65,20,0
.goto TheStormPeaks,49.26,77.62,20 >>Travel up the cave toward |cRXP_PICK_Frostgut's Altar|r
step
#completewith Tormar
.goto TheStormPeaks,49.7,78.3,0,0
>>Kill |cRXP_ENEMY_Garm Watchers|r and |cRXP_ENEMY_Snowblind Devotees|r
.complete 12822,1 
.complete 12822,2 
.mob Garm Watcher;Snowblind Devotee
step
.goto TheStormPeaks,49.19,78.18,20,0
.goto TheStormPeaks,49.43,78.83,20,0
.goto TheStormPeaks,50.13,78.82,20,0
.goto TheStormPeaks,50.51,77.75
>>Use the |T133713:0|t[Hardpacked Explosive Bundle] at |cRXP_PICK_Frostgut's Altar|r
.complete 12823,1 
.use 41431
step
#label Tormar
.goto TheStormPeaks,50.17,79.08
>>Kill |cRXP_ENEMY_Tormar|r
.complete 12823,2 
.mob Tormar Frostgut
step
>>Kill |cRXP_ENEMY_Garm Watchers|r and |cRXP_ENEMY_Snowblind Devotees|r
.complete 12822,1 
.goto TheStormPeaks,48.9,78.7,40,0
.goto TheStormPeaks,48.8,79.8
.complete 12822,2 
.goto TheStormPeaks,50.1,80.0,50,0
.goto TheStormPeaks,50.7,78.7
.mob Garm Watcher;Snowblind Devotee
step
.goto TheStormPeaks,50.48,81.66,7,0
.goto TheStormPeaks,49.99,81.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gino|r
.turnin 12823 >>Turn in A Flawless Plan
.accept 12824 >>Accept Demolitionist Extraordinaire
.target Gino
step
#completewith next
.goto TheStormPeaks,50.68,81.91
.goto TheStormPeaks,40.99,85.36,15 >>|cRXP_WARN_Run into the Garm's Rise Teleporter|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ricket|r and |cRXP_FRIENDLY_Gretchen|r
.turnin 12822 >>Turn in Know No Fear
.turnin 12824 >>Turn in Demolitionist Extraordinaire
.goto TheStormPeaks,40.93,85.30
.turnin 12843 >>Turn in They Took Our Men!
.accept 12846 >>Accept Leave No Goblin Behind
.goto TheStormPeaks,41.15,86.14
.target Ricket
.target Gretchen Fizzlespark
step << Alliance
#completewith next
.goto TheStormPeaks,29.61,74.07,50 >>Fly up to Frosthold
step << Alliance !Mage
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Andorin|r, |cRXP_FRIENDLY_Lagnus|r, |cRXP_FRIENDLY_Glorthal|r, and |cRXP_FRIENDLY_Fjorlin|r
.accept 12854 >>Accept On Brann's Trail
.goto TheStormPeaks,29.61,74.07
.accept 12863 >>Accept Offering Thanks
.goto TheStormPeaks,29.40,73.76
.turnin 12863 >>Turn in Offering Thanks
.accept 12864 >>Accept Missing Scouts
.goto TheStormPeaks,29.18,74.91
.accept 12865 >>Accept Loyal Companions
.goto TheStormPeaks,29.83,75.72
.target Archaeologist Andorin
.target Lagnus
.target Glorthal Stiffbeard
.target Fjorlin Frostbrow
step << Alliance Mage
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Andorin|r and |cRXP_FRIENDLY_Lagnus|r
.accept 12854 >>Accept On Brann's Trail
.goto TheStormPeaks,29.61,74.07
.accept 12863 >>Accept Offering Thanks
.goto TheStormPeaks,29.40,73.76
.target Archaeologist Andorin
.target Lagnus
step << Alliance Mage
#completewith next
.goto TheStormPeaks,28.71,74.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gunda|r
.home >> Set your Hearthstone to Frosthold
.target Gunda Boldhammer
step << Alliance Mage
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Glorthal|r and |cRXP_FRIENDLY_Fjorlin|r
.turnin 12863 >>Turn in Offering Thanks
.accept 12864 >>Accept Missing Scouts
.goto TheStormPeaks,29.18,74.91
.accept 12865 >>Accept Loyal Companions
.goto TheStormPeaks,29.83,75.72
.target Glorthal Stiffbeard
.target Fjorlin Frostbrow
step << Alliance
#completewith next
.goto TheStormPeaks,29.50,74.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_WARN_Faldorf|r
.fp Frosthold >>Get the Frosthold Flight Path
.target Faldorf Bitterchill
step << Alliance
.goto TheStormPeaks,34.56,64.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Frostborn Scout|r's corpse
.complete 12864,1 
.target Frostborn Scout
.skipgossip
step << Horde Mage
#completewith next
.goto TheStormPeaks,37.12,49.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gakra|r
.home >> Set your Hearthstone to Grom'arsh Crash Site
.target Peon Gakra
step << Horde
.goto TheStormPeaks,37.31,49.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Boktar|r
.accept 12895 >>Accept The Missing Bronzebeard
.target Boktar Bloodfury
step
.goto TheStormPeaks,36.06,64.13
>>Open the |cRXP_PICK_Disturbed Snow|r on the ground. Loot it for the |cRXP_LOOT_Burlap-Wrapped Note|r
.complete 12854,1 << Alliance 
.complete 12895,1 << Horde 
step << Horde
.goto TheStormPeaks,37.31,49.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Boktar|r
.turnin 12895 >>Turn in The Missing Bronzebeard
.accept 12909 >>Accept The Nose Knows
.target Boktar Bloodfury
step << Horde
.goto TheStormPeaks,40.77,51.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Khaliisi|r
.turnin 12909 >>Turn in The Nose Knows
.accept 12910 >>Accept Sniffing Out the Perpetrator
.target Khaliisi
step << Horde
#completewith next
.goto TheStormPeaks,40.75,51.22
.vehicle >>Mount |cRXP_FRIENDLY_Frostbite|r
.timer 83,Perpetrator RP
.target Frostbite
step << Horde
.goto TheStormPeaks,48.02,60.98
>>Cast |T132149:0|t[Cast Net] on |cRXP_ENEMY_Stormforged Pursuers|r to net them
>>Cast |T135848:0|t[Ice Slick] to slow |cRXP_ENEMY_Stormforged Pursuers|r
>>|cRXP_WARN_Wait out the RP|r
.complete 12910,1 
.mob Stormforged Pursuer
step << Horde
.goto TheStormPeaks,48.56,60.82
>>Kill |cRXP_ENEMY_Tracker Thulin|r. Loot him for |T133866:0|t[|cRXP_LOOT_Brann's Communicator|r]
.complete 12910,2 
.collect 40971,1,12913,1 
.mob Tracker Thulin
step << Horde
#completewith next
.cast 61122 >> Use |T133866:0|t[|cRXP_LOOT_Brann's Communicator|r]
.use 40971
step << Horde
.goto TheStormPeaks,48.56,60.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brann|r
.turnin 12910 >>Turn in Sniffing Out the Perpetrator
.accept 12913 >>Accept Speak Orcish, Man!
.target Brann Bronzebeard
.use 40971
step << Alliance
.loop 60,TheStormPeaks,42.75,59.21,43.60,55.09,45.71,56.29,45.81,59.89,45.45,62.73,42.75,59.21
>>Kill |cRXP_ENEMY_Ice Steppe Rhinos|r and |cRXP_ENEMY_Ice Steppe Bulls|r. Loot them for their |cRXP_LOOT_Fresh Ice Rhino Meat|r
.collect 41340,8,12865,1 
.mob Ice Steppe Rhino;Ice Steppe Bull
step
#completewith next
.goto TheStormPeaks,42.10,69.50,60 >>Enter The Forlorn Mine
step
.goto TheStormPeaks,42.84,69.09,15,0
.goto TheStormPeaks,42.80,68.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lok'lira|r
.turnin 12846 >>Turn in Leave No Goblin Behind
.accept 12841 >>Accept The Crone's Bargain
.target Lok'lira the Crone
step
.goto TheStormPeaks,43.84,68.86,25,0
.goto TheStormPeaks,44.13,67.86,30,0
.goto TheStormPeaks,44.27,67.22,30,0
.goto TheStormPeaks,44.09,70.13,30,0
.goto TheStormPeaks,44.19,70.52,20,0
.goto TheStormPeaks,45.06,71.23,20,0
.goto TheStormPeaks,44.13,67.86,30,0
.goto TheStormPeaks,44.27,67.22,30,0
.goto TheStormPeaks,44.09,70.13,30,0
.goto TheStormPeaks,44.19,70.52,20,0
.goto TheStormPeaks,45.06,71.23,20,0
.goto TheStormPeaks,44.27,67.22
>>Kill |cRXP_ENEMY_Overseer Syra|r. Loot her for the |cRXP_LOOT_Runes of Yrkvinn|r
.complete 12841,1 
.mob Overseer Syra
step
.goto TheStormPeaks,42.80,68.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lok'lira|r
.turnin 12841 >>Turn in The Crone's Bargain
.accept 12905 >>Accept Mildred the Cruel
.target Lok'lira the Crone
step
#completewith next
.goto TheStormPeaks,44.84,68.49,20 >>Travel up the stairs to |cRXP_FRIENDLY_Mildred|r
step
.goto TheStormPeaks,44.39,68.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mildred|r
.turnin 12905 >>Turn in Mildred the Cruel
.accept 12906 >>Accept Discipline
.target Mildred the Cruel
step
.goto TheStormPeaks,44.92,67.08,20,0
.goto TheStormPeaks,44.76,70.33,20,0
.goto TheStormPeaks,44.37,71.00,20,0
.goto TheStormPeaks,44.48,70.61,20,0
.goto TheStormPeaks,45.13,71.00,20,0
.goto TheStormPeaks,44.02,70.12,15,0
.goto TheStormPeaks,43.68,70.05,20,0
.goto TheStormPeaks,44.05,68.17,20,0
.goto TheStormPeaks,44.37,66.84,20,0
.goto TheStormPeaks,44.92,67.08,20,0
.goto TheStormPeaks,44.76,70.33,20,0
.goto TheStormPeaks,44.37,71.00,20,0
.goto TheStormPeaks,44.48,70.61,20,0
.goto TheStormPeaks,45.13,71.00,20,0
.goto TheStormPeaks,44.02,70.12,15,0
.goto TheStormPeaks,43.68,70.05,20,0
.goto TheStormPeaks,44.05,68.17,20,0
.goto TheStormPeaks,44.37,66.84
>> Use the |T135147:0|t[|cRXP_LOOT_Disciplining Rod|r] on |cRXP_ENEMY_Exhausted Vrykul|r
.complete 12906,1 
.mob Exhausted Vrykul
.use 42837
step
.goto TheStormPeaks,44.39,68.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mildred|r
.turnin 12906 >>Turn in Discipline
.accept 12907 >>Accept Examples to be Made
.target Mildred the Cruel
step
.goto TheStormPeaks,45.26,68.87,15,0
.goto TheStormPeaks,45.41,69.10
>>Kill |cRXP_ENEMY_Garhal|r
.complete 12907,1 
.mob Garhal
step
.goto TheStormPeaks,44.39,68.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mildred|r
.turnin 12907 >>Turn in Examples to be Made
.accept 12908 >>Accept A Certain Prisoner
.target Mildred the Cruel
step
.goto TheStormPeaks,42.80,68.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lok'lira|r
.turnin 12908 >>Turn in A Certain Prisoner
.accept 12921 >>Accept A Change of Scenery
.target Lok'lira the Crone
step
#completewith next
.goto TheStormPeaks,41.80,69.62,30 >>Exit The Forlorn Mine
step
#completewith next
.goto TheStormPeaks,47.47,69.09,30 >>Fly to Brunnhildar Village
step
.goto TheStormPeaks,47.47,69.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lok'lira|r
.turnin 12921 >>Turn in A Change of Scenery
.accept 12969 >>Accept Is That Your Goblin?
.target Lok'lira the Crone
step
#completewith next
.goto TheStormPeaks,48.25,69.77
.gossipoption 93533 >>Talk to |cRXP_FRIENDLY_Agnetta Tyrsdottar|r to turn her hostile
.target Agnetta Tyrsdottar
.skipgossip
step
.goto TheStormPeaks,48.25,69.77
>>Kill |cRXP_ENEMY_Agnetta Tyrsdottar|r
.complete 12969,1 
.mob Agnetta Tyrsdottar
step
.goto TheStormPeaks,47.47,69.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lok'lira|r
.turnin 12969 >>Turn in Is That Your Goblin?
.accept 12970 >>Accept The Hyldsmeet
.complete 12970,1 
.skipgossip 29975,1
.turnin 12970 >>Turn in The Hyldsmeet
.accept 12971 >>Accept Taking on All Challengers
step
.loop 40,TheStormPeaks,47.96,70.48,48.25,70.15,50.33,68.62,50.45,68.32,50.42,67.54,51.19,66.86,51.49,66.65,51.55,66.04,51.15,65.44,51.02,66.39,49.92,66.78,47.96,70.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Victorious Challengers|r to turn them hostile
>>Kill |cRXP_ENEMY_Victorious Challengers|r
.complete 12971,1 
.mob Victorious Challenger
.skipgossip
step
.goto TheStormPeaks,47.47,69.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lok'lira|r
.turnin 12971 >>Turn in Taking on All Challengers
.accept 12972 >>Accept You'll Need a Bear
step
.goto TheStormPeaks,53.14,65.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brijana|r
.turnin 12972 >>Turn in You'll Need a Bear
.accept 12851 >>Accept Bearly Hanging On
step
#completewith next
.goto The Storm Peaks,53.12,65.61
.vehicle >>Mount |cRXP_FRIENDLY_Icefang|r
.target Icefang
step
.goto TheStormPeaks,53.1,65.6,0
.goto TheStormPeaks,57.4,63.0
>>|cRXP_WARN_Cast|r |T135825:0|t[Flaming Arrow] (1) |cRXP_WARN_to burn |cRXP_ENEMY_Frostworgs|r and|r |cRXP_ENEMY_Frost Giants|r
>>|cRXP_WARN_DON'T cast|r |T132276:0|t[Burst of Speed] (2)
>>|cRXP_WARN_Focus on hitting all the targets|r
>>|cRXP_WARN_Mount |cRXP_FRIENDLY_Icefang|r again if you didn't finish after getting dismounted|r
.complete 12851,1 
.complete 12851,2 
.mob Frostworg
.mob Niffelem Frost Giant
step
.goto TheStormPeaks,53.14,65.72
>>|cRXP_WARN_Cast|r |T132276:0|t[Burst of Speed] (2) |cRXP_WARN_to get back to |cRXP_FRIENDLY_Brijana|r faster|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brijana|r
.turnin 12851 >>Turn in Bearly Hanging On
.accept 12856 >>Accept Cold Hearted
.target Brijana
step
#completewith next
.goto TheStormPeaks,63.20,62.88,100 >>Fly to Dun Niffelem
step
#completewith next
.goto TheStormPeaks,63.20,62.88
.vehicle >>Mount a |cRXP_FRIENDLY_Captive Proto-Drake|r
.target Captive Proto-Drake
step
.waypoint TheStormPeaks,53.10,65.70,0,niffelen,VEHICLE_PASSENGERS_CHANGED,VEHICLE_UPDATE
.goto The Storm Peaks,66.75,60.63
>>Cast |T135844:0|t[Ice Shard] (1) near |cRXP_FRIENDLY_Brunnhildar Prisoners|r frozen in the Ice Block to free them
>>Return to Brunnhildar when you have three |cRXP_FRIENDLY_Brunnhildar Prisoners|r on your |cRXP_FRIENDLY_Captive Proto-Drake|r
>>|cRXP_WARN_Make sure to fly back toward Dun Niffelem after you get credit for rescuing the |cRXP_FRIENDLY_Brunnhildar Prisoners|r as it has a small delay before it dismounts you|r
.complete 12856,1,3 
.complete 12856,2,1 
.target Brunnhildar Prisoner
step
#completewith next
.goto TheStormPeaks,63.20,62.88
.vehicle >>Mount a |cRXP_FRIENDLY_Captive Proto-Drake|r
.target Captive Proto-Drake
step
.waypoint TheStormPeaks,53.10,65.70,0,niffelen,VEHICLE_PASSENGERS_CHANGED,VEHICLE_UPDATE
.goto The Storm Peaks,66.75,60.63
>>Cast |T135844:0|t[Ice Shard] (1) near |cRXP_FRIENDLY_Brunnhildar Prisoners|r frozen in the Ice Block to free them
>>Return to Brunnhildar when you have three |cRXP_FRIENDLY_Brunnhildar Prisoners|r on your |cRXP_FRIENDLY_Captive Proto-Drake|r
>>|cRXP_WARN_Make sure to fly back toward Dun Niffelem after you get credit for rescuing the |cRXP_FRIENDLY_Brunnhildar Prisoners|r as it has a small delay before it dismounts you|r
.complete 12856,1,6 
.complete 12856,2,2 
.target Brunnhildar Prisoner
step
#completewith next
.goto TheStormPeaks,63.20,62.88
.vehicle >>Mount a |cRXP_FRIENDLY_Captive Proto-Drake|r
.target Captive Proto-Drake
step
.waypoint TheStormPeaks,53.10,65.70,0,niffelen,VEHICLE_PASSENGERS_CHANGED,VEHICLE_UPDATE
.goto The Storm Peaks,66.75,60.63
>>Cast |T135844:0|t[Ice Shard] (1) near |cRXP_FRIENDLY_Brunnhildar Prisoners|r frozen in the Ice Block to free them
>>Return to Brunnhildar when you have three |cRXP_FRIENDLY_Brunnhildar Prisoners|r on your |cRXP_FRIENDLY_Captive Proto-Drake|r
.complete 12856,1 
.complete 12856,2 
.target Brunnhildar Prisoner
step
.goto TheStormPeaks,53.14,65.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brijana|r
.turnin 12856 >>Turn in Cold Hearted
.accept 13063 >>Accept Deemed Worthy
.target Brijana
step
.goto TheStormPeaks,49.75,71.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Astrid|r
.turnin 13063 >>Turn in Deemed Worthy
.accept 12900 >>Accept Making a Harness
.target Astrid Bjornrittar
step
.loop 50,TheStormPeaks,48.26,74.22,48.46,75.59,48.75,77.40,48.20,76.73,47.30,75.86,47.09,78.16,46.68,76.89,46.36,76.35,45.89,75.63,44.41,73.79,46.01,74.20,46.79,74.70,48.26,74.22
>>Kill |cRXP_ENEMY_Icemane Yetis|r. Loot them for |cRXP_LOOT_Icemane Yeti Hides|r
.complete 12900,1 
.mob Icemane Yeti
step
.goto TheStormPeaks,49.75,71.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Astrid|r
.turnin 12900 >>Turn in Making a Harness
.accept 12983 >>Accept The Last of Her Kind
.target Astrid Bjornrittar
step
#completewith next
.goto TheStormPeaks,55.80,63.82,30 >>Enter the Hibernal Cavern
step << skip
.goto TheStormPeaks,54.8,60.4
>>Kill the |cRXP_ENEMY_Jormungar|r in the cave
>>|cRXP_WARN_DO NOT ride the|r |cRXP_FRIENDLY_Injured Icemaw Matriarch|r |cRXP_WARN_in the middle of the cave yet|r
.complete 12989,1 
.mob Ravenous Jormungar
step
#completewith next
.goto TheStormPeaks,55.66,62.13,25,0
.goto TheStormPeaks,54.79,60.37
.vehicle >>Mount the |cRXP_FRIENDLY_Injured Icemaw Matriarch|r
.timer 69,The Last of Her Kind RP
.target Injured Icemaw Matriarch
step
.goto TheStormPeaks,49.82,71.12
>>|cRXP_WARN_Wait out the RP|r
>>Ride the |cRXP_FRIENDLY_Injured Icemaw Matriarch|r back to Brunnhildar
.complete 12983,1 
step
.goto TheStormPeaks,49.75,71.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Astrid|r
.turnin 12983 >>Turn in The Last of Her Kind
.accept 12996 >>Accept The Warm-Up
.target Astrid Bjornrittar
step
.goto TheStormPeaks,50.79,67.68,70 >>Travel toward |cRXP_ENEMY_Kirgaraak|r
.mob Kirgaraak
.isOnQuest 12996
step
#completewith next
.goto TheStormPeaks,50.79,67.68
.vehicle >>|cRXP_WARN_Use the|r |T236245:0|t[Reins of the Warbear Matriarch] |cRXP_WARN_to mount it|r
.use 42481
step
.goto TheStormPeaks,50.79,67.68
>>|cRXP_WARN_Kill|r |cRXP_ENEMY_Kirgaraak|r |cRXP_WARN_whilst mounted|r
>>|cRXP_WARN_Cast|r |T132131:0|t[Maul] (4) |cRXP_WARN_to deal damage|r
>>|cRXP_WARN_Cast|r |T132143:0|t[Smash] (5) |cRXP_WARN_then|r |T132337:0|t[Charge] (6) |cRXP_WARN_to deal more damage|r
.complete 12996,1 
.mob Kirgaraak
.use 42481
step
.goto TheStormPeaks,49.75,71.81
>>|cRXP_WARN_Dismount the|r |cRXP_FRIENDLY_Warbear Matriarch|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Astrid|r
.turnin 12996 >>Turn in The Warm-Up
.accept 12997 >>Accept Into the Pit
.target Astrid Bjornrittar
step
#completewith next
.goto TheStormPeaks,50.79,67.68
.vehicle >>|cRXP_WARN_Use the|r |T236245:0|t[Reins of the Warbear Matriarch] |cRXP_WARN_to mount it|r
.use 42499
step
.goto TheStormPeaks,49.24,68.46
>>|cRXP_WARN_Kill|r |cRXP_ENEMY_Hyldsmeet Warbears|r |cRXP_WARN_whilst mounted|r
>>|cRXP_WARN_Cast|r |T132131:0|t[Maul] (4) |cRXP_WARN_to deal damage|r
>>|cRXP_WARN_Cast|r |T132143:0|t[Smash] (5) |cRXP_WARN_then|r |T132337:0|t[Charge] (6) |cRXP_WARN_to deal more damage|r
>>|cRXP_WARN_Make sure you deal 50% or more damage to a |cRXP_ENEMY_Hyldsmeet Warbear|r to get credit|r
.complete 12997,1 
.mob Hyldsmeet Warbear
.use 42499
step
.goto TheStormPeaks,49.75,71.81
>>|cRXP_WARN_Dismount the|r |cRXP_FRIENDLY_Warbear Matriarch|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Astrid|r
.turnin 12997 >>Turn in Into the Pit
.accept 13061 >>Accept Prepare for Glory
.target Astrid Bjornrittar
step
.goto TheStormPeaks,47.47,69.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lok'lira|r
.turnin 13061 >>Turn in Prepare for Glory
.accept 13062 >>Accept Lok'lira's Parting Gift
step
.goto TheStormPeaks,50.88,65.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gretta|r
.turnin 13062 >>Turn in Lok'lira's Parting Gift
.accept 12886 >>Accept The Drakkensryd
.timer 80,The Drakkensryd Flight
step
#completewith next
>>|cRXP_WARN_Wait out the RP|r
.goto TheStormPeaks,31.89,53.35,40 >>Fly on the |cRXP_FRIENDLY_Hyldsmeet Proto-Drake|r to the Temple of Storms
step
.goto TheStormPeaks,35.4,57.8
>>Use the |T135127:0|t[Hyldnir Harpoon] to jump onto |cRXP_FRIENDLY_Hyldsmeet Proto-Drakes|r that have |cRXP_ENEMY_Hyldsmeet Drakeriders|r on them
>>Kill |cRXP_ENEMY_Hyldsmeet Drakeriders|r
>>|cRXP_WARN_Make sure you have "Game -> Combat -> Target of Target" enabled in your settings so you can see your health via the |cRXP_ENEMY_Hyldsmeet Drakerider|r's target window|r
.complete 12886,1 
.mob Hyldsmeet Drakerider
.use 41058
step
#completewith next
.goto TheStormPeaks,33.42,57.95,95 >>Use the |T135127:0|t[Hyldnir Harpoon] to jump onto a |cRXP_FRIENDLY_Column Ornament|r on the Columns of the Temple of Storms to jump onto it
.target Column Ornament
.use 41058
step
.goto TheStormPeaks,33.42,57.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thorim|r
.turnin 12886 >>Turn in The Drakkensryd
.accept 13064 >>Accept Sibling Rivalry
.complete 13064,1 
.skipgossip 29445,1
.turnin 13064 >>Turn in Sibling Rivalry
.accept 12915 >>Accept Mending Fences
step << Alliance
.goto TheStormPeaks,33.8,73.8
>>Use the |T237332:0|t[Fresh Ice Rhino Meat] on |cRXP_FRIENDLY_Stormcrest Eagles|r
>>|cRXP_WARN_You don't need to dismount|r
.collect 41340,8,12865,1,-1
.complete 12865,1 
.target Stormcrest Eagle
.use 41340
step << Alliance
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fjorlin|r, |cRXP_FRIENDLY_Andorin|r, and |cRXP_FRIENDLY_Glorthal|r
.turnin 12865 >>Turn in Loyal Companions
.accept 12867 >>Accept Baby Stealers
.goto TheStormPeaks,29.83,75.72
.turnin 12854 >>Turn in On Brann's Trail
.accept 12855 >>Accept Sniffing Out the Perpetrator
.goto TheStormPeaks,29.61,74.07
.turnin 12864 >>Turn in Missing Scouts
.accept 12866 >>Accept Stemming the Aggressors
.goto TheStormPeaks,29.18,74.91
.target Fjorlin Frostbrow
.target Archaeologist Andorin
.target Glorthal Stiffbeard
step << Alliance
#completewith next
.loop 45,TheStormPeaks,27.03,72.38,26.28,72.52,25.82,72.33,27.81,69.13,29.26,67.75,30.05,66.88,30.97,66.95,31.05,65.18,32.35,67.30,32.94,66.80,33.40,65.60,35.10,66.58,36.42,66.33,37.10,67.73,36.29,68.38,35.82,68.19,35.10,66.58
>>Open the |cRXP_PICK_Eagle Eggs|r on the ground around the trees. Loot them for the |cRXP_LOOT_Stormcrest Eagle Eggs|r
.complete 12867,1 
step << Alliance
.loop 45,TheStormPeaks,27.03,72.38,26.28,72.52,25.82,72.33,27.81,69.13,29.26,67.75,30.05,66.88,30.97,66.95,31.05,65.18,32.35,67.30,32.94,66.80,33.40,65.60,35.10,66.58,36.42,66.33,37.10,67.73,36.29,68.38,35.82,68.19,35.10,66.58
>>Kill |cRXP_ENEMY_Frostfeather Screechers|r and |cRXP_ENEMY_Frostfeather Witches|r
.complete 12866,1 
.complete 12866,2 
.mob Frostfeather Screecher;Frostfeather Witch
step << Alliance
.loop 45,TheStormPeaks,27.03,72.38,26.28,72.52,25.82,72.33,27.81,69.13,29.26,67.75,30.05,66.88,30.97,66.95,31.05,65.18,32.35,67.30,32.94,66.80,33.40,65.60,35.10,66.58,36.42,66.33,37.10,67.73,36.29,68.38,35.82,68.19,35.10,66.58
>>Open the |cRXP_PICK_Eagle Eggs|r on the ground around the trees. Loot them for the |cRXP_LOOT_Stormcrest Eagle Eggs|r
.complete 12867,1 
step << Alliance
#completewith next
.goto TheStormPeaks,36.43,64.20,50 >>Travel to the Abandoned Camp
step << Alliance
.goto TheStormPeaks,36.43,64.20
.vehicle >> |cRXP_WARN_Use|r |T133309:0|t[Frosthound's Collar]
.timer 114,Sniffing Out the Perpetrator RP
.use 41430
.isOnQuest 12855
step << Alliance
#label Thief
.goto TheStormPeaks,48.02,60.98
>>Cast |T132149:0|t[Cast Net] on |cRXP_ENEMY_Stormforged Pursuers|r to net them
>>Cast |T135848:0|t[Ice Slick] to slow |cRXP_ENEMY_Stormforged Pursuers|r
>>|cRXP_WARN_Wait out the RP|r
.complete 12855,1 
.mob Stormforged Pursuer
.use 41430
step << Alliance
.goto TheStormPeaks,48.56,60.82
>>Kill |cRXP_ENEMY_Tracker Thulin|r. Loot him for |T133866:0|t[|cRXP_LOOT_Brann's Communicator|r]
.complete 12855,2 
.collect 40971,1,12858,1 
.mob Tracker Thulin
step << Alliance
#completewith next
.cast 61122 >> Use |T133866:0|t[|cRXP_LOOT_Brann's Communicator|r]
.use 40971
step << Alliance
.goto TheStormPeaks,48.56,60.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brann|r
.turnin 12855 >>Turn in Sniffing Out the Perpetrator
.accept 12858 >>Accept Pieces to the Puzzle
.target Brann Bronzebeard
.use 40971
step << Alliance
#label Slag
.loop 50,TheStormPeaks,69.16,62.01,69.13,59.19,70.05,56.34,70.41,58.87,70.01,60.57,70.79,61.86,,69.16,62.01,72.98,63.65,74.22,62.53,75.97,63.93
>>Loot the |cRXP_LOOT_Granite Boulders|r on the ground around the edge of the lake (|cRXP_WARN_you may only carry one at a time|r)
>>|cRXP_WARN_After looting a |cRXP_LOOT_Granite Boulder|r, use|r |T134422:0|t[Thorim's Charm of Earth] |cRXP_WARN_on a |cRXP_ENEMY_Stormforged Iron Giant|r to summon |cRXP_FRIENDLY_Earthen Ironbanes|r to assist you|r
>>Kill a |cRXP_ENEMY_Stormforged Iron Giant|r. Loot it for its |T135228:0|t[|cRXP_LOOT_Slag Covered Metal|r]
>>|cRXP_WARN_Use the |T135228:0|t[|cRXP_LOOT_Slag Covered Metal|r] to start the quest|r
.collect 41506,1,12915,1,-1
.collect 41556,1,12922,1 
.accept 12922 >>Accept The Refiner's Fire
.mob Stormforged Iron Giant
.use 41505
.use 41556
step << Alliance
#completewith next
>>Loot the |cRXP_LOOT_Granite Boulders|r on the ground around the edge of the lake (|cRXP_WARN_you may only carry one at a time|r)
>>|cRXP_WARN_After looting a |cRXP_LOOT_Granite Boulder|r, use|r |T134422:0|t[Thorim's Charm of Earth] |cRXP_WARN_on a |cRXP_ENEMY_Stormforged Iron Giant|r to summon |cRXP_FRIENDLY_Earthen Ironbanes|r to assist you|r
>>Kill |cRXP_ENEMY_Stormforged Iron Giants|r
.collect 41506,1,12915,1,-1
.complete 12915,2 
.mob Stormforged Iron Giant
.use 41505
step << Alliance
.loop 50,TheStormPeaks,69.46,62.33,69.29,60.15,69.02,57.86,70.27,57.23,71.26,55.85,70.36,57.82,70.03,59.39,70.56,60.49,71.85,59.01,71.74,60.57,72.53,62.06,73.73,62.93,69.46,62.33,75.62,63.46,76.81,63.04,76.76,62.50,77.16,62.18,77.63,62.66,77.23,63.54,76.81,63.04
>>Kill |cRXP_ENEMY_Seething Revenants|r. Loot them for their |cRXP_LOOT_Furious Sparks|r
.complete 12922,1 
.mob Seething Revenant
step << Alliance
#sticky
#label FAnvil
.goto TheStormPeaks,77.17,62.84,0,0
>>Click |cRXP_PICK_Fjorn's Anvil|r
.turnin 12922 >>Turn in The Refiner's Fire
.accept 12956 >>Accept A Spark of Hope
step << Alliance
.goto TheStormPeaks,76.48,63.93,40,0
.goto TheStormPeaks,77.20,63.67,40,0
.goto TheStormPeaks,77.38,62.87
>>Loot the |cRXP_LOOT_Granite Boulders|r on the ground around in the snow (|cRXP_WARN_you may only carry one at a time|r)
>>|cRXP_WARN_After looting a |cRXP_LOOT_Granite Boulder|r, use|r |T134422:0|t[Thorim's Charm of Earth] |cRXP_WARN_on |cRXP_ENEMY_Fjorn|r to summon |cRXP_FRIENDLY_Earthen Ironbanes|r to assist you|r
>>Kill |cRXP_ENEMY_Fjorn|r
.collect 41506,1,12915,1,-1
.complete 12915,1 
.mob Fjorn
.use 41505
step << Alliance
#requires FAnvil
.loop 50,TheStormPeaks,69.16,62.01,69.13,59.19,70.05,56.34,70.41,58.87,70.01,60.57,70.79,61.86,,69.16,62.01,72.98,63.65,74.22,62.53,75.97,63.93
>>Loot the |cRXP_LOOT_Granite Boulders|r on the ground around the edge of the lake (|cRXP_WARN_you may only carry one at a time|r)
>>|cRXP_WARN_After looting a |cRXP_LOOT_Granite Boulder|r, use|r |T134422:0|t[Thorim's Charm of Earth] |cRXP_WARN_on a |cRXP_ENEMY_Stormforged Iron Giant|r to summon |cRXP_FRIENDLY_Earthen Ironbanes|r to assist you|r
>>Kill |cRXP_ENEMY_Stormforged Iron Giants|r
.collect 41506,1,12915,2,-1
.complete 12915,2 
.mob Stormforged Iron Giant
.use 41505
step << Alliance !Mage
#completewith next
.hs >> Hearth to Dalaran
step << Alliance !Mage
#completewith next
.goto TheStormPeaks,29.18,74.91,40 >>Travel toward |cRXP_FRIENDLY_Glorthal|r
step << Alliance Mage
#completewith next
.hs >> Hearth to Frosthold
step << Alliance
.goto TheStormPeaks,29.18,74.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Glorthal|r
.turnin 12866 >>Turn in Stemming the Aggressors
.accept 12868 >>Accept Sirana Iceshriek
.target Glorthal Stiffbeard
step << Alliance
#completewith next
.goto TheStormPeaks,33.42,57.95,40 >>Fly up the Temple of Storms toward |cRXP_FRIENDLY_Thorim|r
step << Alliance
.goto TheStormPeaks,33.42,57.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thorim|r
.turnin 12915 >>Turn in Mending Fences
.turnin 12956 >>Turn in A Spark of Hope
.accept 12924 >>Accept Forging an Alliance
.target Thorim
step << Horde
.goto TheStormPeaks,37.29,49.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Moteha|r
.turnin 12913 >>Turn in Speak Orcish, Man!
.accept 12917 >>Accept Speaking with the Wind's Voice
.target Moteha Windborn
step << Horde
.loop 55,TheStormPeaks,33.77,47.41,32.57,49.12,31.78,49.61,30.24,50.02,28.69,51.11,28.31,50.52,27.49,48.24,27.35,47.05,27.26,45.30,26.23,43.31,26.48,40.72,27.50,40.33,28.13,42.81,28.33,46.80,28.77,47.74,29.78,48.20,30.74,48.23,32.52,47.31,33.77,47.41
>>Kill |cRXP_ENEMY_Stormriders|r. Loot them for |cRXP_LOOT_Voices of the Wind|r
.complete 12917,1 
.mob Stormrider
step << Horde
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Moteha|r and |cRXP_FRIENDLY_Boktar|r
.turnin 12917 >>Turn in Speaking with the Wind's Voice
.goto TheStormPeaks,37.29,49.74
.accept 12920 >>Accept Catching up with Brann
.goto TheStormPeaks,37.31,49.66
.target Moteha Windborn
.target Boktar Bloodfury
step << Horde
#completewith next
.cast 61122 >> Use |T133866:0|t[|cRXP_LOOT_Brann's Communicator|r]
.use 40971
step << Horde
.goto TheStormPeaks,37.31,49.66
.gossipoption 93222 >>Talk to |cRXP_FRIENDLY_Brann|r
.timer 71,Catching up with Brann RP
.target Brann Bronzebeard
.use 40971
.skipgossip
step << Horde
#completewith next
.goto TheStormPeaks,37.31,49.66
>>|cRXP_WARN_Wait out the RP|r
.complete 12920,1 
step << Horde
.goto TheStormPeaks,37.31,49.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Boktar|r
.turnin 12920 >>Turn in Catching up with Brann
.accept 12926 >>Accept Pieces of the Puzzle
.target Boktar Bloodfury
step
.loop 50,TheStormPeaks,37.77,45.04,37.14,43.20,37.34,42.39,38.45,42.83,37.34,40.75,38.01,39.93,38.66,39.74,39.09,41.14,39.86,39.79,40.66,40.56,41.77,39.31,42.63,39.53,41.52,42.07,41.97,43.43,40.28,42.22,38.91,43.42,37.77,45.04
>>Kill |cRXP_ENEMY_Library Guardians|r. Loot them for |T133451:0|t[|cRXP_LOOT_Inventor's Disk Fragments|r]
.collect 41130,6,12858,1 << Alliance 
.collect 41130,6,12926,1 << Horde 
.mob Library Guardian
step
.goto TheStormPeaks,37.93,43.94
>>Use the |T133451:0|t[|cRXP_LOOT_Inventor's Disk Fragments|r]
.complete 12858,1 << Alliance 
.complete 12926,1 << Horde 
.use 41130
step
#completewith next
.cast 61122 >> Use |T133866:0|t[|cRXP_LOOT_Brann's Communicator|r]
.use 40971
step
.goto TheStormPeaks,37.93,43.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brann|r
.turnin 12858 >>Turn in Pieces to the Puzzle << Alliance
.accept 12860 >>Accept Data Mining << Alliance
.turnin 12926 >>Turn in Pieces to the Puzzle << Horde
.accept 12927 >>Accept Data Mining << Horde
.target Brann Bronzebeard
.use 40971
step
.loop 50,TheStormPeaks,37.23,43.48,37.50,42.57,37.79,41.58,37.04,40.74,37.67,40.47,39.10,41.16,39.52,40.18,39.89,39.44,40.16,40.86,40.70,42.25,39.79,42.08,38.76,42.92,38.54,44.23,37.23,43.48
>>|cRXP_WARN_Channel|r |T134375:0|t[The Inventor's Disk] next to |cRXP_FRIENDLY_Databanks|r
.complete 12860,1 << Alliance 
.complete 12927,1 << Horde 
.cast 55161
.timer 10,Data Mining RP
.target Databank
.use 41179
step
.goto TheStormPeaks,37.70,45.34,30,0
.goto TheStormPeaks,37.43,46.83,30 >> Go inside The Inventor's Library
.isOnQuest 12860 << Alliance
.isOnQuest 12927 << Horde
step
#completewith next
.cast 61122 >> Use |T133866:0|t[|cRXP_LOOT_Brann's Communicator|r]
.use 40971
step
.goto TheStormPeaks,37.43,46.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brann|r
.turnin 12860 >>Turn in Data Mining << Alliance
.accept 13415 >>Accept The Library Console << Alliance
.turnin 12927 >>Turn in Data Mining << Horde
.accept 13416 >>Accept The Library Console << Horde
.target Brann Bronzebeard
.use 40971
step
.goto TheStormPeaks,37.43,46.83
>>Click the |cRXP_PICK_Inventor's Library Console|r
.turnin 13415 >>Turn in The Library Console << Alliance
.accept 12872 >>Accept Norgannon's Shell << Alliance
.turnin 13416 >>Turn in The Library Console << Horde
.accept 12928 >>Accept Norgannon's Shell << Horde
step
.goto TheStormPeaks,37.53,46.52
.cast 55197 >> Use the |T134375:0|t[Charged Disk] to summon |cRXP_ENEMY_Archivist Mechaton|r
.timer 50,Norgannon's Shell RP
.use 44704
.isOnQuest 12872 << Alliance
.isOnQuest 12928 << Horde
step
.goto TheStormPeaks,37.53,46.52
>>|cRXP_WARN_Wait out the RP|r
>>Kill |cRXP_ENEMY_Archivist Mechaton|r. Loot him for |cRXP_LOOT_Norgannon's Shell|r
.complete 12872,1 << Alliance 
.complete 12928,1 << Horde 
.mob Archivist Mechaton
.use 44704
step
.goto TheStormPeaks,37.43,46.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brann|r
>>|cRXP_WARN_Summon him again with|r |T133866:0|t[|cRXP_LOOT_Brann's Communicator|r] |cRXP_WARN_if he disappeared|r
.turnin 12872 >>Turn in Norgannon's Shell << Alliance
.accept 12871 >>Accept Aid from the Explorers' League << Alliance
.turnin 12928 >>Turn in Norgannon's Shell << Horde
.accept 13273 >>Accept Going After the Core << Horde
.target Brann Bronzebeard
.use 40971
step
.goto TheStormPeaks,30.64,36.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Breck|r
.fp Bouldercrag's Refuge >> Get the Bouldercrag's Refuge flight path
.target Breck Rockbrow
step
#completewith next
.goto TheStormPeaks,30.67,37.06,30,0 << !Mage
.goto TheStormPeaks,30.67,37.06,30 >>Travel to Bouldercrag's Refuge << Mage
.goto TheStormPeaks,31.42,38.08,30 >>Travel toward |cRXP_FRIENDLY_Bouldercrag|r << !Mage
step << Mage
#completewith Plate
.goto TheStormPeaks,30.89,37.36
.home >> Set your Hearthstone to Bouldercrag's Refuge
step
.goto TheStormPeaks,31.42,38.08
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bouldercrag|r
>>|cRXP_WARN_Do NOT vendor any|r |T132908:0|t[Frostweave Cloth] |cRXP_WARN_you have|r
.accept 12930 >>Accept Rare Earth
.target Bouldercrag the Rockshaper
step
#completewith EEarth
.goto TheStormPeaks,30.67,37.06,30 >>Exit Bouldercrag's Refuge
step
.loop 50,TheStormPeaks,29.39,36.11,29.06,35.74,28.47,34.85,28.42,36.39,27.66,36.20,27.25,35.44,26.82,35.93,26.15,36.26,26.44,37.23,26.94,37.74,27.10,38.20,27.82,38.89,27.90,38.37,28.90,38.70,28.67,37.92,29.39,36.11
>>Kill |cRXP_ENEMY_Stormforged Raiders|r. Loot them for |cRXP_LOOT_Frostweave Cloth|r
.complete 12930,2 
.mob Stormforged Raider
step
#completewith next
.cast 2580 >> Cast |T136025:0|t[Find Minerals] to help you find the |cRXP_PICK_Enchanted Earth|r if it's not currently active
.skill mining,<1,1
step
#label EEarth
.goto TheStormPeaks,30.97,34.21,40,0
.goto TheStormPeaks,29.48,31.89,40,0
.goto TheStormPeaks,28.95,32.90,40,0
.goto TheStormPeaks,27.19,34.26,40,0
.goto TheStormPeaks,27.26,32.21,40,0
.goto TheStormPeaks,26.11,33.10,40,0
.goto TheStormPeaks,25.42,33.15,40,0
.goto TheStormPeaks,24.73,34.13,40,0
.goto TheStormPeaks,24.64,33.38,40,0
.goto TheStormPeaks,24.31,33.79,40,0
.goto TheStormPeaks,23.85,34.16,40,0
.goto TheStormPeaks,21.25,33.27,40,0
.goto TheStormPeaks,30.97,34.21,40,0
.goto TheStormPeaks,21.25,33.27
>>Loot the |cRXP_LOOT_Enchanted Earth|r on the ground along the cliff face
.complete 12930,1 
step
.goto TheStormPeaks,30.67,37.06,30,0
.goto TheStormPeaks,31.42,38.08
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bouldercrag|r
.turnin 12930 >>Turn in Rare Earth
.accept 12931 >>Accept Fighting Back
.accept 12937 >>Accept Relief for the Fallen
.target Bouldercrag the Rockshaper
step
#completewith next
>>Kill |cRXP_ENEMY_Stormforged Reavers|r and |cRXP_ENEMY_Stormforged Raiders|r
.complete 12931,1 
.mob Stormforged Reaver
.mob Stormforged Raider
step
.loop 50,TheStormPeaks,25.63,35.81,24.85,36.94,24.13,37.22,24.98,38.18,25.27,38.62,26.07,39.20,26.37,39.66,26.86,39.26,27.52,39.15,27.96,40.12,28.23,39.34,27.95,39.04,28.52,38.45,29.10,36.86,28.75,34.72,28.10,36.65,27.47,37.10,25.63,35.81
>>Use the |T133683:0|t[Telluric Poultice] on |cRXP_FRIENDLY_Fallen Earthen Defenders|r
>>|cRXP_WARN_You can cancel the channel after starting the cast|r
.complete 12937,1,7 
.use 41988
step
.loop 50,TheStormPeaks,25.63,35.81,24.85,36.94,24.13,37.22,24.98,38.18,25.27,38.62,26.07,39.20,26.37,39.66,26.86,39.26,27.52,39.15,27.96,40.12,28.23,39.34,27.95,39.04,28.52,38.45,29.10,36.86,28.75,34.72,28.10,36.65,27.47,37.10,25.63,35.81
.cast 55797	>>Use the |T133683:0|t[Telluric Poultice] on |cRXP_FRIENDLY_Fallen Earthen Defenders|r

.use 41988
.isOnQuest 12937
step
.loop 50,TheStormPeaks,29.39,36.11,29.06,35.74,28.47,34.85,28.42,36.39,27.66,36.20,27.25,35.44,26.82,35.93,26.15,36.26,26.44,37.23,26.94,37.74,27.10,38.20,27.82,38.89,27.90,38.37,28.90,38.70,28.67,37.92,29.39,36.11
>>Kill |cRXP_ENEMY_Stormforged Reavers|r and |cRXP_ENEMY_Stormforged Raiders|r
.complete 12931,1 
.mob Stormforged Reaver
.mob Stormforged Raider
step
.goto TheStormPeaks,30.67,37.06,30,0
.goto TheStormPeaks,31.42,38.08
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bouldercrag|r
.target Bouldercrag the Rockshaper
.turnin 12931 >>Turn in Fighting Back
.turnin 12937 >>Turn in Relief for the Fallen
.accept 12957 >>Accept Slaves of the Stormforged
.accept 12964 >>Accept The Dark Ore
step
#completewith next
.goto TheStormPeaks,30.67,37.06,30 >>Exit Bouldercrag's Refuge
step
#completewith next
.goto TheStormPeaks,27.40,49.77,30 >> Travel to The Frozen Mine
step
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Mechagnomes|r
.complete 12957,1 
.target Captive Mechagnome
.skipgossip
step
.loop 15,TheStormPeaks,27.50,49.74,26.95,50.04,26.77,49.99,26.40,49.74,26.64,50.40,26.40,50.84,26.92,51.06,26.87,51.39,26.61,51.84,26.16,52.07,25.93,52.34,25.82,51.40,26.12,51.14,
>>Kill |cRXP_ENEMY_Stormforged Taskmasters|r
>>Open the |cRXP_PICK_Ore Carts|r on the ground. Loot them for the |cRXP_LOOT_Dark Ore Samples|r
.complete 12957,2 
.complete 12964,1 
.mob Stormforged Taskmaster
step
.loop 15,TheStormPeaks,27.12,49.97,26.54,49.92,26.34,49.75,26.42,50.08,26.65,50.51,26.46,50.95,26.90,51.00,26.83,51.49,26.41,51.92,26.13,52.14,25.88,52.30,25.85,51.30,26.12,51.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Mechagnomes|r
.complete 12957,1 
.target Captive Mechagnome
.skipgossip
step << skip
#completewith next
.hs >> Hearth to Bouldercrag Refuge
.cooldown item,6948,>0

step
.goto TheStormPeaks,30.67,37.06,30,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bouldercrag|r and |cRXP_FRIENDLY_Bruor|r
.turnin 12957 >>Turn in Slaves of the Stormforged
.turnin 12964 >>Turn in The Dark Ore
.accept 12965 >>Accept The Gifts of Loken
.goto TheStormPeaks,31.42,38.08
.accept 12978 >>Accept Facing the Storm
.goto TheStormPeaks,31.28,38.17
.target Bouldercrag the Rockshaper
.target Bruor Ironbane
step
#completewith next
.goto TheStormPeaks,30.67,37.06,30 >>Exit Bouldercrag's Refuge
step
#completewith next
>>Kill |cRXP_ENEMY_Stormforged Champions|r and |cRXP_ENEMY_Stormforged Maguses|r
.complete 12978,1 
.mob Stormforged Champion
.mob Stormforged Magus
step
#label Plate
#completewith LokenOrb
>>Kill a |cRXP_ENEMY_Stormforged War Golem|r. Loot it for its |T237488:0|t[|cRXP_LOOT_Dark Armor Plate|r]
>>|cRXP_WARN_Use the |T237488:0|t[|cRXP_LOOT_Dark Armor Plate|r] to start the quest|r
.collect 42203,1,12979 
.accept 12979 >>Accept Armor of Darkness
.mob Stormforged War Golem
.use 42203
step
#requires Plate
#completewith LokenOrb
>>Kill |cRXP_ENEMY_Stormforged Champions|r and |cRXP_ENEMY_Stormforged Maguses|r
>>Kill |cRXP_ENEMY_Stormforged War Golems|r. Loot them for their |T237488:0|t[|cRXP_LOOT_Dark Armor Plates|r]
.complete 12978,1 
.complete 12979,1 
.mob Stormforged War Golem
.mob Stormforged Champion
.mob Stormforged Magus
step
.goto TheStormPeaks,26.16,47.71
>>Go inside the building
>>Click |cRXP_PICK_Loken's Power|r
.complete 12965,2 
step
.goto TheStormPeaks,24.59,47.74,30,0
.goto TheStormPeaks,24.55,48.44
>>Go inside the building
>>Click |cRXP_PICK_Loken's Favor|r
.complete 12965,3 
step
#label LokenOrb
.goto TheStormPeaks,24.01,42.62
>>Go inside the building
>>Click |cRXP_PICK_Loken's Fury|r
.complete 12965,1 
step
.loop 50,TheStormPeaks,26.41,44.53,26.26,44.95,25.56,44.67,25.04,42.31,24.49,42.06,24.78,43.93,25.14,45.27,25.76,46.26,26.00,47.03,24.44,45.67,24.38,47.37,25.19,47.46,25.54,49.09,25.43,50.30,25.94,50.98,24.79,51.58
>>Kill a |cRXP_ENEMY_Stormforged War Golem|r. Loot it for its |T237488:0|t[|cRXP_LOOT_Dark Armor Plate|r]
>>|cRXP_WARN_Use the |T237488:0|t[|cRXP_LOOT_Dark Armor Plate|r] to start the quest|r
.collect 42203,1,12979 
.accept 12979 >>Accept Armor of Darkness
.mob Stormforged War Golem
.use 42203
step
.loop 50,TheStormPeaks,26.41,44.53,26.26,44.95,25.56,44.67,25.04,42.31,24.49,42.06,24.78,43.93,25.14,45.27,25.76,46.26,26.00,47.03,24.44,45.67,24.38,47.37,25.19,47.46,25.54,49.09,25.43,50.30,25.94,50.98,24.79,51.58
>>Kill |cRXP_ENEMY_Stormforged Champions|r and |cRXP_ENEMY_Stormforged Maguses|r
>>Kill |cRXP_ENEMY_Stormforged War Golems|r. Loot them for their |T237488:0|t[|cRXP_LOOT_Dark Armor Plates|r]
.complete 12978,1 
.complete 12979,1 
.mob Stormforged War Golem
.mob Stormforged Champion
.mob Stormforged Magus
step
.goto TheStormPeaks,30.67,37.06,30,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bouldercrag|r and |cRXP_FRIENDLY_Bruor|r
.turnin 12965 >>Turn in The Gifts of Loken
.goto TheStormPeaks,31.42,38.08
.turnin 12978 >>Turn in Facing the Storm
.turnin 12979 >>Turn in Armor of Darkness
.accept 12980 >>Accept The Armor's Secrets
.goto TheStormPeaks,31.28,38.17
.target Bouldercrag the Rockshaper
.target Bruor Ironbane
step
#completewith next
.goto TheStormPeaks,30.55,36.77,20,0
.goto TheStormPeaks,32.53,36.58,65,0
.goto TheStormPeaks,33.47,39.72,45,0
.goto TheStormPeaks,32.03,40.74,40 >> Travel toward |cRXP_FRIENDLY_Tock|r
step
.goto TheStormPeaks,32.03,40.74
.gossipoption 93703 >> Talk to |cRXP_FRIENDLY_Tock|r
.timer 79,The Armor's Secrets RP
.target Attendant Tock
.skipgossip
.isOnQuest 12980
step
#completewith next
.goto TheStormPeaks,33.72,39.43,30,0
.goto TheStormPeaks,30.52,36.86,40,0
.goto TheStormPeaks,30.67,37.06,30,0
.goto TheStormPeaks,31.28,38.17,15 >> Travel toward |cRXP_FRIENDLY_Bruor|r
step
>>|cRXP_WARN_Wait out the RP|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bruor|r and |cRXP_FRIENDLY_Bouldercrag|r
.turnin 12980 >>Turn in The Armor's Secrets
.goto TheStormPeaks,31.28,38.17
.accept 12984 >>Accept Valduran the Stormborn
.goto TheStormPeaks,31.42,38.08
.target Bruor Ironbane
.target Bouldercrag the Rockshaper
step
.goto TheStormPeaks,24.65,51.76,30,0
.goto TheStormPeaks,24.28,52.15
.cast 56189 >> Use |T134227:0|t[Bouldercrag's War Horn] to start the RP
.timer 33,Valduran the Stormborn RP
.use 42419
.isOnQuest 12984
step
.goto TheStormPeaks,24.28,52.15
>>|cRXP_WARN_Wait out the RP|r
>>Kill |cRXP_ENEMY_Valduran the Stormborn|r
.complete 12984,1 
.mob Valduran the Stormborn
.use 42419
step
.goto TheStormPeaks,30.67,37.06,30,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bouldercrag|r and |cRXP_FRIENDLY_Bruor|r
.turnin 12984 >>Turn in Valduran the Stormborn
.accept 12988 >>Accept Destroy the Forges!
.goto TheStormPeaks,31.42,38.08
.accept 12991 >>Accept Hit Them Where it Hurts
.goto TheStormPeaks,31.28,38.17
.target Bouldercrag the Rockshaper
.target Bruor Ironbane
step
#completewith next
>>Kill |cRXP_ENEMY_Stormforged Artificers|r
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Stormforged Artificers|r cast|r |T136015:0|t[Lightning Infusion], |cRXP_WARN_an interruptable channel that deals about 1500 damage|r
.complete 12991,1 
.mob Stormforged Artificer
step
>>Use |T133716:0|t[Bouldercrag's Bomb] on the |cRXP_PICK_Lightning Forges|r
.complete 12988,1 
.goto TheStormPeaks,28.99,45.84,-1
.complete 12988,2 
.goto TheStormPeaks,29.53,45.89,-1
.complete 12988,3 
.goto TheStormPeaks,30.25,46.15,-1
.use 42441
step
.loop 40,TheStormPeaks,30.10,46.80,30.25,46.20,30.06,45.27,29.50,44.20,28.79,44.36,28.89,45.67,29.03,45.91,29.50,45.39,29.93,45.80,29.42,46.26,30.10,46.80
>>Kill |cRXP_ENEMY_Stormforged Artificers|r
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Stormforged Artificers|r cast|r |T136015:0|t[Lightning Infusion], |cRXP_WARN_an interruptable channel that deals about 1500 damage|r
.complete 12991,1 
.mob Stormforged Artificer
step
.goto TheStormPeaks,30.67,37.06,30,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bruor|r and |cRXP_FRIENDLY_Bouldercrag|r
.turnin 12991 >>Turn in Hit Them Where it Hurts
.goto TheStormPeaks,31.28,38.17
.turnin 12988 >>Turn in Destroy the Forges!
.accept 12993 >>Accept A Colossal Threat
.goto TheStormPeaks,31.42,38.08
.target Bruor Ironbane
.target Bouldercrag the Rockshaper
step
.goto TheStormPeaks,28.88,44.06
>>Loot the |cRXP_LOOT_Colossus Attack Specs|r on the table
.complete 12993,1 
step
.goto TheStormPeaks,29.90,45.81
>>Loot the |cRXP_LOOT_Colossus Defense Specs|r on the table
.complete 12993,2 
step
.goto TheStormPeaks,30.67,37.06,30,0
.goto TheStormPeaks,31.42,38.08
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bouldercrag|r
.turnin 12993 >>Turn in A Colossal Threat
.accept 12998 >>Accept The Heart of the Storm
.target Bouldercrag the Rockshaper
step
#completewith next
.goto TheStormPeaks,32.40,63.62,20,0
.goto TheStormPeaks,32.41,61.23,20 >> |cRXP_WARN_Fly through the hole 75% of the way down the mountain into Uldis|r
step
#completewith next
.goto TheStormPeaks,34.60,60.92,40,0
.goto TheStormPeaks,36.12,60.93,20 >>Travel toward |cRXP_PICK_The Heart of the Storm|r
step
.goto TheStormPeaks,36.13,60.93
.cast 3365 >>Click |cRXP_PICK_The Heart of the Storm|r
.timer 30,The Heart of the Storm RP
.isOnQuest 12998
step
.goto TheStormPeaks,36.13,60.93
>>|cRXP_WARN_Wait out the RP|r
.complete 12998,1 
step << !Mage
#completewith next
.goto TheStormPeaks,32.41,61.23,20,0
.goto TheStormPeaks,32.40,63.62,20 >> Exit Uldis
step << Mage
#completewith next
.hs >> Hearth to Bouldercrag
step
.goto TheStormPeaks,30.67,37.06,30,0 << !Mage
.goto TheStormPeaks,31.42,38.08
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bouldercrag|r
.turnin 12998 >>Turn in The Heart of the Storm
.accept 13007 >>Accept The Iron Colossus
.target Bouldercrag the Rockshaper
step
#completewith next
.goto TheStormPeaks,27.18,35.88
.vehicle >>Click the |cRXP_PICK_Jormungar Control Orb|r
step
.goto TheStormPeaks,27.19,43.06,50,0
.goto TheStormPeaks,28.78,47.99
>>|cRXP_WARN_Cast|r |T136025:0|t[Submerge] (1) |cRXP_WARN_to move|r
>>|cRXP_WARN_Move beneath the |cRXP_ENEMY_Iron Colossus|r, then cast|r |T237588:0|t[Emerge] (1) |cRXP_WARN_whilst|r |T136025:0|t[Submerged]
>>|cRXP_WARN_Right click the |cRXP_ENEMY_Iron Colossus|r to Auto Attack him. Cast|r |T132282:0|t[Jormungar Strike] (2) |cRXP_WARN_and|r |T136008:0|t[Acid Breath] (3) |cRXP_WARN_to deal damage|r
>>|cRXP_WARN_When the |cRXP_ENEMY_Iron Colossus|r emotes that he's "Preparing to slam the ground", cast|r |T136025:0|t[Submerge] (1), |cRXP_WARN_move behind him, then cast|r |T237588:0|t[Emerge] (1) |cRXP_WARN_whilst|r |T136025:0|t[Submerged]
.complete 13007,1 
.mob Iron Colossus
step
.goto TheStormPeaks,30.67,37.06,30,0
.goto TheStormPeaks,31.42,38.08
>>|cRXP_WARN_Exit the Jormungar|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bouldercrag|r
.turnin 13007 >>Turn in The Iron Colossus
.target Bouldercrag the Rockshaper
step << Horde
#label Slag
.loop 50,TheStormPeaks,69.16,62.01,69.13,59.19,70.05,56.34,70.41,58.87,70.01,60.57,70.79,61.86,,69.16,62.01,72.98,63.65,74.22,62.53,75.97,63.93
>>Loot the |cRXP_LOOT_Granite Boulders|r on the ground around the edge of the lake (|cRXP_WARN_you may only carry one at a time|r)
>>|cRXP_WARN_After looting a |cRXP_LOOT_Granite Boulder|r, use|r |T134422:0|t[Thorim's Charm of Earth] |cRXP_WARN_on a |cRXP_ENEMY_Stormforged Iron Giant|r to summon |cRXP_FRIENDLY_Earthen Ironbanes|r to assist you|r
>>Kill a |cRXP_ENEMY_Stormforged Iron Giant|r. Loot it for its |T135228:0|t[|cRXP_LOOT_Slag Covered Metal|r]
>>|cRXP_WARN_Use the |T135228:0|t[|cRXP_LOOT_Slag Covered Metal|r] to start the quest|r
.collect 41506,1,12915,1,-1
.collect 41556,1,12922,1 
.accept 12922 >>Accept The Refiner's Fire
.mob Stormforged Iron Giant
.use 41505
.use 41556
step << Horde
#completewith next
>>Loot the |cRXP_LOOT_Granite Boulders|r on the ground around the edge of the lake (|cRXP_WARN_you may only carry one at a time|r)
>>|cRXP_WARN_After looting a |cRXP_LOOT_Granite Boulder|r, use|r |T134422:0|t[Thorim's Charm of Earth] |cRXP_WARN_on a |cRXP_ENEMY_Stormforged Iron Giant|r to summon |cRXP_FRIENDLY_Earthen Ironbanes|r to assist you|r
>>Kill |cRXP_ENEMY_Stormforged Iron Giants|r
.collect 41506,1,12915,1,-1
.complete 12915,2 
.mob Stormforged Iron Giant
.use 41505
step << Horde
.loop 50,TheStormPeaks,69.46,62.33,69.29,60.15,69.02,57.86,70.27,57.23,71.26,55.85,70.36,57.82,70.03,59.39,70.56,60.49,71.85,59.01,71.74,60.57,72.53,62.06,73.73,62.93,69.46,62.33,75.62,63.46,76.81,63.04,76.76,62.50,77.16,62.18,77.63,62.66,77.23,63.54,76.81,63.04
>>Kill |cRXP_ENEMY_Seething Revenants|r. Loot them for their |cRXP_LOOT_Furious Sparks|r
.complete 12922,1 
.mob Seething Revenant
step << Horde
#sticky
#label FAnvil
.goto TheStormPeaks,77.17,62.84,0,0
>>Click |cRXP_PICK_Fjorn's Anvil|r
.turnin 12922 >>Turn in The Refiner's Fire
.accept 12956 >>Accept A Spark of Hope
step << Horde
.goto TheStormPeaks,76.48,63.93,40,0
.goto TheStormPeaks,77.20,63.67,40,0
.goto TheStormPeaks,77.38,62.87
>>Loot the |cRXP_LOOT_Granite Boulders|r on the ground around in the snow (|cRXP_WARN_you may only carry one at a time|r)
>>|cRXP_WARN_After looting a |cRXP_LOOT_Granite Boulder|r, use|r |T134422:0|t[Thorim's Charm of Earth] |cRXP_WARN_on |cRXP_ENEMY_Fjorn|r to summon |cRXP_FRIENDLY_Earthen Ironbanes|r to assist you|r
>>Kill |cRXP_ENEMY_Fjorn|r
.collect 41506,1,12915,1,-1
.complete 12915,1 
.mob Fjorn
.use 41505
step << Horde
#requires FAnvil
.loop 50,TheStormPeaks,69.16,62.01,69.13,59.19,70.05,56.34,70.41,58.87,70.01,60.57,70.79,61.86,,69.16,62.01,72.98,63.65,74.22,62.53,75.97,63.93
>>Loot the |cRXP_LOOT_Granite Boulders|r on the ground around the edge of the lake (|cRXP_WARN_you may only carry one at a time|r)
>>|cRXP_WARN_After looting a |cRXP_LOOT_Granite Boulder|r, use|r |T134422:0|t[Thorim's Charm of Earth] |cRXP_WARN_on a |cRXP_ENEMY_Stormforged Iron Giant|r to summon |cRXP_FRIENDLY_Earthen Ironbanes|r to assist you|r
>>Kill |cRXP_ENEMY_Stormforged Iron Giants|r
.collect 41506,1,12915,2,-1
.complete 12915,2 
.mob Stormforged Iron Giant
.use 41505
step << Horde
.goto TheStormPeaks,59.78,52.64
>>Loot |cRXP_LOOT_Prospector Khrona's Notes|r on the crate
.complete 13273,1 
step << Horde
.goto TheStormPeaks,59.25,51.48
>>Loot |cRXP_LOOT_Prospector Soren's Notes|r on the crate
.complete 13273,2 
step << Horde
#completewith next
.cast 61122 >> Use |T133866:0|t[|cRXP_LOOT_Brann's Communicator|r]
.use 40971
step << Horde
.goto TheStormPeaks,59.25,51.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brann|r
.turnin 13273 >>Turn in Going After the Core
.accept 13274 >>Accept The Core's Keeper
.use 40971
.target Brann Bronzebeard
step << Horde
#completewith next
.goto TheStormPeaks,56.40,58.46,20,0
.goto TheStormPeaks,54.97,57.48,20 >> |cRXP_WARN_Fly through the hole 75% of the way down the mountain into Loken's Bargain|r
step << Horde
#completewith next
.goto TheStormPeaks,55.69,54.34,40,0
.goto TheStormPeaks,56.38,52.11,40 >>Travel toward |cRXP_ENEMY_Athan|r
step << Horde
.goto TheStormPeaks,56.38,52.11
>>Kill |cRXP_ENEMY_Athan|r. Loot him for |cRXP_LOOT_Norgannon's Core|r
.complete 13274,1 
.mob Athan
step << Horde
.goto TheStormPeaks,56.16,52.41
.goto TheStormPeaks,54.34,50.04,20 >>|cRXP_WARN_Fly onto the edge of the wall. Perform a Logout Skip by logging out and then logging back in|r
.link https://www.youtube.com/watch?v=5x8OCvrl1do >> |cRXP_WARN_CLICK HERE|r
.isOnQuest 13274
step << Horde
#completewith next
.cast 61122 >> Use |T133866:0|t[|cRXP_LOOT_Brann's Communicator|r]
.use 40971
step << Horde
.goto TheStormPeaks,54.34,50.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brann|r
.turnin 13274 >>Turn in The Core's Keeper
.accept 13285 >>Accept Forging the Keystone
.use 40971
.target Brann Bronzebeard
step << Horde
#completewith next
.goto TheStormPeaks,45.48,49.49,40 >>Fly up the Temple of Invention toward |cRXP_FRIENDLY_Brann|r
step << Horde
.goto TheStormPeaks,45.48,49.50
.gossipoption 94560 >>Talk to |cRXP_FRIENDLY_Brann|r
>>|cRXP_WARN_DON'T Wait out |cRXP_FRIENDLY_Brann|r's RP|r

.skipgossip
.timer 55,Forging the Keystone RP
.target Brann Bronzebeard
.isOnQuest 13285
step << Horde
#completewith next
>>|cRXP_WARN_DON'T Wait out |cRXP_FRIENDLY_Brann|r's RP|r
.goto TheStormPeaks,33.42,57.95,40 >>Fly up the Temple of Storms toward |cRXP_FRIENDLY_Thorim|r
step << Horde
.goto TheStormPeaks,33.42,57.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thorim|r
.turnin 12915 >>Turn in Mending Fences
.turnin 12956 >>Turn in A Spark of Hope
.accept 12924 >>Accept Forging an Alliance
.target Thorim
step << Horde
.goto TheStormPeaks,37.31,49.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Boktar|r
.turnin 13285 >>Turn in Forging the Keystone
.accept 13426 >>Accept Xantaur, the Witness
.target Boktar Bloodfury
step << Alliance
#completewith Frosthold4
.goto TheStormPeaks,30.64,36.32
.fly Frosthold >> Fly to Frosthold
.target Breck Rockbrow
.skill riding,300,1
step << Alliance
#completewith next
.goto TheStormPeaks,24.94,66.87,50 >>Travel toward |cRXP_ENEMY_Sirana Iceshriek|r atop the mountain
step << Alliance
.loop 45,TheStormPeaks,24.00,66.40,24.42,67.54,24.93,67.98,25.39,67.71,25.44,66.44,24.73,65.25,24.10,65.04,23.86,65.49,24.00,66.40
>>Kill |cRXP_ENEMY_Sirana Iceshriek|r
>>|cRXP_WARN_Be careful of her|r |T135833:0|t[Ice Shriek], |cRXP_WARN_as it deals around 3000 damage and stuns for 4 seconds|r
>>|cRXP_WARN_Find a group for her if needed. Skip this step if you're unable to find a group or solo her|r
.complete 12868,1 
.mob Sirana Iceshriek
step << Alliance !Mage
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Andorin|r, |cRXP_FRIENDLY_Lagnus|r, |cRXP_FRIENDLY_Glorthal|r, and |cRXP_FRIENDLY_Fjorlin|r
.accept 12854 >>Accept On Brann's Trail
.goto TheStormPeaks,29.61,74.07
.accept 12863 >>Accept Offering Thanks
.goto TheStormPeaks,29.40,73.76
.turnin 12863 >>Turn in Offering Thanks
.accept 12864 >>Accept Missing Scouts
.goto TheStormPeaks,29.18,74.91
.accept 12865 >>Accept Loyal Companions
.goto TheStormPeaks,29.83,75.72
.target Archaeologist Andorin
.target Lagnus
.target Glorthal Stiffbeard
.target Fjorlin Frostbrow
step << Alliance Mage
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lagnus|r
.goto TheStormPeaks,29.40,73.76
.turnin 12871 >>Turn in Aid from the Explorers' League
.accept 12873 >>Accept The Frostborn King
.target Lagnus
step << Alliance Mage
#completewith next
.goto TheStormPeaks,28.71,74.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gunda|r
.home >> Set your Hearthstone to Frosthold
.target Gunda Boldhammer
step << Alliance
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lagnus|r, |cRXP_FRIENDLY_Glorthal|r, |cRXP_FRIENDLY_Yorg|r, and |cRXP_FRIENDLY_Fjorlin|r << !Mage
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Glorthal|r, |cRXP_FRIENDLY_Yorg|r, and |cRXP_FRIENDLY_Fjorlin|r << Mage
.turnin 12871 >>Turn in Aid from the Explorers' League << !Mage
.accept 12873 >>Accept The Frostborn King << !Mage
.goto TheStormPeaks,29.40,73.76 << !Mage
.turnin 12868 >>Turn in Sirana Iceshriek
.goto TheStormPeaks,29.18,74.91
.turnin 12873 >>Turn in The Frostborn King
.accept 12874 >>Accept Fervor of the Frostborn
.goto TheStormPeaks,30.26,74.76
.turnin 12867 >>Turn in Baby Stealers
.goto TheStormPeaks,29.83,75.72
.target Lagnus << !Mage
.target Glorthal Stiffbeard
.target Yorg Stormheart
.target Fjorlin Frostbrow
.isQuestComplete 12868
step << Alliance
#label Frosthold4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lagnus|r, |cRXP_FRIENDLY_Yorg|r, and |cRXP_FRIENDLY_Fjorlin|r << !Mage
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yorg|r and |cRXP_FRIENDLY_Fjorlin|r << Mage
.turnin 12871 >>Turn in Aid from the Explorers' League << !Mage
.accept 12873 >>Accept The Frostborn King << !Mage
.goto TheStormPeaks,29.40,73.76 << !Mage
.turnin 12873 >>Turn in The Frostborn King
.accept 12874 >>Accept Fervor of the Frostborn
.goto TheStormPeaks,30.26,74.76
.turnin 12867 >>Turn in Baby Stealers
.goto TheStormPeaks,29.83,75.72
.target Lagnus << !Mage
.target Yorg Stormheart
.target Fjorlin Frostbrow
step << Alliance
.abandon 12868 >> Abandon Sirana Iceshriek
step << Alliance
.goto TheStormPeaks,29.83,75.72
.gossipoption 93345 >> Talk to |cRXP_FRIENDLY_Fjorlin|r
.timer 160,Fervor of the Frostborn RP
.skipgossip
.target Fjorlin Frostbrow
.skill riding,300,1
.isOnQuest 12874
step << Alliance
.goto TheStormPeaks,53.61,35.14
>>|cRXP_WARN_Wait out the RP|r
>>Loot the |T132325:0|t[|cRXP_LOOT_Battered Storm Hammer|r] on the ground
.collect 42624,1 
.skill riding,300,1
.isOnQuest 12874
step << Alliance
#completewith next
.goto TheStormPeaks,53.61,35.14,100 >> Travel to the Terrace of the Makers
.skill riding,<300,1
step << Alliance
.goto TheStormPeaks,53.61,35.14
>>Loot the |T132325:0|t[|cRXP_LOOT_Battered Storm Hammer|r] on the ground
.collect 42624,1 
.isOnQuest 12874
step << Alliance
.goto TheStormPeaks,53.55,37.85
>>Kill |cRXP_ENEMY_The Iron Watcher|r
>>|cRXP_WARN_Use the|r |T132325:0|t[|cRXP_LOOT_Battered Storm Hammer|r] |cRXP_WARN_on the |cRXP_ENEMY_The Iron Watcher|r on cooldown|r
>>|cRXP_WARN_Make sure you're using your standard abilities too|r
.complete 12874,1 
.mob The Iron Watcher
.use 42624
step
.goto TheStormPeaks,62.64,60.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halvdan|r
.fp Dun Niffelem >> Get the Dun Niffelem flight path
.target Halvdan
step
.goto TheStormPeaks,65.45,60.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jokkum|r
.accept 12966 >>Accept You Can't Miss Him
.target King Jokkum
step
.goto TheStormPeaks,75.37,63.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Njormeld|r
.turnin 12966 >>Turn in You Can't Miss Him
.accept 12967 >>Accept Battling the Elements
.target Njormeld
step
#completewith next
.goto TheStormPeaks,75.71,63.91
.vehicle >>Mount |cRXP_FRIENDLY_Snorri|r :3
.target Snorri
step
.loop 40,TheStormPeaks,76.86,63.17,77.08,62.02,77.49,62.79,76.86,63.17
>>Cast |T135850:0|t[Gather Snow] (1) next to the |cRXP_PICK_Snowdrifts|r on the ground for a |cRXP_LOOT_Snowball|r
>>Kill |cRXP_ENEMY_Seething Revenants|r by casting |T132387:0|t[Throw Snowball] (2) on them
.complete 12967,1 
.mob Seething Revenant
step
.goto TheStormPeaks,75.37,63.57
>>Dismount |cRXP_FRIENDLY_Snorri|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Njormeld|r
>>|cRXP_WARN_You may need to fly away slightly then back to phase |cRXP_FRIENDLY_Njormeld|r back in|r
.turnin 12967 >>Turn in Battling the Elements
.complete 12924,1 
.target Njormeld
step
.goto TheStormPeaks,66.15,61.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lillehoff|r
.turnin 13559 >> Turn in Hodir's Tribute
.target Lillehoff
.itemcount 42780,10
.reputation 1119,neutral,>2675,1 - Skip if 325 rep away from Friendly (250 from In Memoriam, 75 from Monument. Optional 350 from hot and cold)
step
.goto TheStormPeaks,66.15,61.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lillehoff|r
.turnin 13559 >> Turn in Hodir's Tribute
.target Lillehoff
.itemcount 42780,10
.reputation 1119,neutral,>2675,1 - Skip if 325 rep away from Friendly (250 from In Memoriam, 75 from Monument. Optional 350 from hot and cold)
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Njormeld|r and |cRXP_FRIENDLY_Jokkum|r
.turnin 12924 >>Turn in Forging an Alliance
.accept 13009 >>Accept A New Beginning
.accept 12985 >>Accept Forging a Head
.goto TheStormPeaks,63.21,63.24
.accept 13011 >>Accept Culling Jorcuttar
.accept 12975 >>Accept In Memoriam
.goto TheStormPeaks,65.45,60.16
.target Njormeld
.target King Jokkum
.reputation 1119,friendly,<0,1
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Njormeld|r and |cRXP_FRIENDLY_Jokkum|r
.turnin 12924 >>Turn in Forging an Alliance
.accept 13009 >>Accept A New Beginning
.goto TheStormPeaks,63.21,63.24


.accept 12975 >>Accept In Memoriam
.goto TheStormPeaks,65.45,60.16
.target Njormeld
.target King Jokkum
.reputation 1119,friendly,>0,1 
step
.goto TheStormPeaks,63.21,63.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Njormeld|r
.accept 12985 >>Accept Forging a Head
.target Njormeld
.reputation 1119,friendly,<0,1
step << skip
.loop 50,TheStormPeaks,69.46,62.33,69.29,60.15,69.02,57.86,70.27,57.23,71.26,55.85,70.36,57.82,70.03,59.39,70.56,60.49,71.85,59.01,71.74,60.57,71.92,62.82,70.87,61.68,70.22,62.39,69.46,62.33
>>Kill |cRXP_ENEMY_Brittle Revenants|r. Loot them for their |T135852:0|t[|cRXP_LOOT_Essences of Ice|r]
.collect 42246,6,12981,1 
.mob Brittle Revenant
.isOnQuest 12981
step
.loop 30,TheStormPeaks,68.78,60.17,69.65,58.90,68.43,57.99,69.26,57.06,70.91,56.86,70.87,61.36,70.28,62.29,68.50,63.29,69.70,61.40,68.78,60.17
>>Use the |T134710:0|t[Diamond Tipped Pick] on |cRXP_ENEMY_Dead Iron Giants|r. Loot them for their |cRXP_LOOT_Stormforged Eyes|r
>>Kill |cRXP_ENEMY_Stormforged Ambushers|r if they spawn after using the |T134710:0|t[Diamond Tipped Pick]. Loot them for their |cRXP_LOOT_Stormforged Eyes|r
.complete 12985,1 
.target Dead Iron Giant
.mob Stormforged Ambusher
.use 42424
.isOnQuest 12985

step << skip
.loop 40,TheStormPeaks,73.29,62.93,74.38,62.94,75.62,63.46,76.81,63.04,76.76,62.50,77.16,62.18,77.63,62.66,77.23,63.54,76.81,63.04
>>Use the |T135852:0|t[|cRXP_LOOT_Essences of Ice|r] on the |cRXP_PICK_Smoldering Scrap|r on the ground to turn it into |cRXP_LOOT_Frozen Iron Scrap|r
>>Loot the |cRXP_LOOT_Frozen Iron Scrap|r on the ground
.collect 42246,6,12981,1,-1 
.complete 12981,1 
.use 42246
step
.loop 45,TheStormPeaks,70.97,52.15,71.23,52.18,71.87,51.82,72.32,52.10,72.43,51.45,72.70,50.14,73.67,49.59,74.68,48.56,73.53,47.90,72.15,47.50,71.69,48.86,70.83,48.33,70.12,48.97,70.73,49.43,70.21,50.48,70.83,50.51,70.97,52.15
>>Loot the |cRXP_LOOT_Horn Fragments|r on the ground
.complete 12975,1 
step
.loop 50,TheStormPeaks,69.46,62.33,69.29,60.15,69.02,57.86,70.27,57.23,71.26,55.85,70.36,57.82,70.03,59.39,70.56,60.49,71.85,59.01,71.74,60.57,71.92,62.82,70.87,61.68,70.22,62.39,69.46,62.33
>>Kill |cRXP_ENEMY_Brittle Revenants|r. Loot them for |cRXP_LOOT_Relics of Ulduar|r
.collect 42780,10,12985,1 
.reputation 1119,neutral,>2675,1
step << Horde
.goto TheStormPeaks,65.41,50.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hyeyoung|r
.fp Camp Tunka'lo >> Get the Camp Tunka'lo flight path
.target Hyeyoung Parka
step << Horde
.goto TheStormPeaks,65.77,51.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xarantaur|r
.turnin 13426 >>Turn in Xarantaur, the Witness
.accept 13034 >>Accept The Witness and the Hero
.target Xarantaur
step << Horde
>>Click the |cRXP_PICK_History Scrolls|r hanging off the walls
.complete 13034,1 
.goto TheStormPeaks,65.81,50.43,-1
.complete 13034,2 
.goto TheStormPeaks,66.84,50.10,-1
.complete 13034,3 
.goto TheStormPeaks,67.50,50.58,-1
step << Horde
.goto TheStormPeaks,65.77,51.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xarantaur|r
.turnin 13034 >>Turn in The Witness and the Hero
.accept 13037 >>Accept Memories of Stormhoof
.target Xarantaur
step << Horde
.goto TheStormPeaks,62.33,41.20,30 >> Enter the cave of Frostfloe Deep
.isOnQuest 13037
step << Horde
#completewith next
.goto TheStormPeaks,61.71,39.87,20,0
.goto TheStormPeaks,61.38,39.38,20,0
.goto TheStormPeaks,61.18,38.99,10 >> Travel toward |cRXP_FRIENDLY_Swiftspear|r
step << Horde
.goto TheStormPeaks,61.18,38.99,10,0
.gossipoption 93202 >>Talk to |cRXP_FRIENDLY_Swiftspear|r
.timer 44,Memories of Stormhoof RP
.accept 13038 >>Accept Distortions in Time

.target Chieftain Swiftspear
.skipgossip 30395,1
step << Horde
.loop 20,TheStormPeaks,61.75,39.83,61.95,40.00,62.63,40.42,62.24,40.36,61.98,41.00,61.95,40.00,61.75,39.83,61.74,38.89,61.73,38.29,61.61,38.06,61.42,38.73,61.08,39.36,61.74,38.89
>>|cRXP_WARN_DON'T Wait out |cRXP_FRIENDLY_Swiftspear|r's RP|r
>>Use |T133493:0|t[The Chieftain's Totem] on |cRXP_PICK_Frostfloe Rifts|r (Yellow Swirls)
.complete 13038,1,3 
.use 42781
step << Horde
.loop 20,TheStormPeaks,61.75,39.83,61.95,40.00,62.63,40.42,62.24,40.36,61.98,41.00,61.95,40.00,61.75,39.83,61.74,38.89,61.73,38.29,61.61,38.06,61.42,38.73,61.08,39.36,61.74,38.89
>>|cRXP_WARN_DON'T Wait out |cRXP_FRIENDLY_Swiftspear|r's RP|r
.cast 56765	>>Use |T133493:0|t[The Chieftain's Totem] on |cRXP_PICK_Frostfloe Rifts|r (Yellow Swirls)

.use 42781
step << Horde
.goto TheStormPeaks,61.18,38.99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Swiftspear|r
>>|cRXP_WARN_Wait out his RP|r
.complete 13037,1 
.target Chieftain Swiftspear
.skipgossip
.timer 44,Memories of Stormhoof RP (CONTINUE QUESTING)
step << Horde
.goto TheStormPeaks,65.77,51.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xarantaur|r
.turnin 13037 >>Turn in Memories of Stormhoof
.turnin 13038 >>Turn in Distortions in Time
.accept 13048 >>Accept Where Time Went Wrong
.accept 13049 >>Accept The Hero's Arms
.target Xarantaur
step << Horde
#completewith next
.goto TheStormPeaks,67.09,44.72,40 >>Enter The Howling Hollow
step << Horde
#completewith next
>>Kill |cRXP_LOOT_Scions of Storm|r. Loot them for |cRXP_LOOT_Stormhoof's Spear|r and |cRXP_LOOT_Stormhoof's Mail|r
.complete 13049,1 
.complete 13049,2 
.mob Scion of Storm
step << Horde
.loop 40,TheStormPeaks,67.06,44.48,67.34,43.74,67.98,44.43,68.49,44.10,68.59,42.84,69.60,42.58,69.70,40.90,69.41,41.56,69.11,42.14,68.44,41.26,68.57,40.95,68.72,40.16,67.90,39.67,67.84,40.98,67.99,42.19,67.06,44.48
>>Click |cRXP_PICK_Taunka Artifacts|r on the ground
.complete 13048,1 
step << Horde
.loop 40,TheStormPeaks,67.65,44.68,67.72,43.54,68.46,43.26,69.34,42.31,69.70,40.90,69.11,42.14,68.44,41.26,68.48,40.69,68.41,39.75,67.84,40.98,67.99,42.19,67.06,44.48
>>Kill |cRXP_LOOT_Scions of Storm|r. Loot them for |cRXP_LOOT_Stormhoof's Spear|r and |cRXP_LOOT_Stormhoof's Mail|r
.complete 13049,1 
.complete 13049,2 
.mob Scion of Storm
step << Horde
.goto TheStormPeaks,65.77,51.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xarantaur|r
.turnin 13048 >>Turn in Where Time Went Wrong
.turnin 13049 >>Turn in The Hero's Arms
.accept 13058 >>Accept Changing the Wind's Course
.target Xarantaur
step << Horde
#completewith next
.goto TheStormPeaks,64.55,46.88
.cast 56863 >> Use |T133526:0|t[The Lorehammer] to become |cRXP_FRIENDLY_Stormhoof|r
.use 42918
step << Horde
.goto TheStormPeaks,64.55,46.88
>>Kill |cRXP_ENEMY_The North Wind|r as |cRXP_FRIENDLY_Stormhoof|r
>>Cast |T135131:0|t[Rhino Strike] (1) to deal damage
>>Cast |T237589:0|t[Storm Call] (3) under |cRXP_ENEMY_The North Wind|r to deal damage. |cRXP_WARN_This is NOT a Channel|r
>>Cast |T136026:0|t[Earth Shock] (2) to interrupt |cRXP_ENEMY_The North Wind|r's |T136018:0|t[Cyclone] spell
>>|cRXP_WARN_Click the |cRXP_PICK_Horn of Elemental Fury|r that drops on the ground when |cRXP_ENEMY_The North Wind|r reaches 20% or less health|r
.complete 13058,1 
.mob The North Wind
.use 42918
step << Horde
.goto TheStormPeaks,65.77,51.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xarantaur|r
.turnin 13058 >>Turn in Changing the Wind's Course
.target Xarantaur
step
.goto TheStormPeaks,66.15,61.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lillehoff|r
.turnin 13559 >> Turn in Hodir's Tribute
.target Lillehoff
.itemcount 42780,10
.reputation 1119,neutral,>2675,1 - Skip if 325 rep away from Friendly (250 from In Memoriam, 75 from Monument. Optional 350 from hot and cold)
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jokkum|r and |cRXP_FRIENDLY_Njormeld|r
.turnin 12975 >>Turn in In Memoriam
.accept 12976 >>Accept A Monument to the Fallen
.goto TheStormPeaks,65.45,60.16


.turnin 12976 >>Turn in A Monument to the Fallen
.accept 12985 >>Accept Forging a Head
.goto TheStormPeaks,63.20,63.27
.target King Jokkum
.target Njormeld
.reputation 1119,friendly,>0,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jokkum|r and |cRXP_FRIENDLY_Njormeld|r
.turnin 12975 >>Turn in In Memoriam
.accept 12976 >>Accept A Monument to the Fallen
.accept 13011 >>Accept Culling Jorcuttar
.goto TheStormPeaks,65.45,60.16


.turnin 12976 >>Turn in A Monument to the Fallen
.accept 12985 >>Accept Forging a Head
.goto TheStormPeaks,63.20,63.27
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jokkum|r and |cRXP_FRIENDLY_Njormeld|r
.turnin 12975 >>Turn in In Memoriam
.accept 12976 >>Accept A Monument to the Fallen
.goto TheStormPeaks,65.45,60.16
.turnin 12976 >>Turn in A Monument to the Fallen
.turnin 12985 >>Turn in Forging a Head
.accept 12987 >>Accept Placing Hodir's Helm
.goto TheStormPeaks,63.20,63.27
.target King Jokkum
.target Njormeld
.isQuestComplete 12985
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jokkum|r and |cRXP_FRIENDLY_Njormeld|r
.turnin 12975 >>Turn in In Memoriam
.accept 12976 >>Accept A Monument to the Fallen
.goto TheStormPeaks,65.45,60.16
.turnin 12976 >>Turn in A Monument to the Fallen
.accept 12987 >>Accept Placing Hodir's Helm
.goto TheStormPeaks,63.20,63.27
.target King Jokkum
.target Njormeld
.isQuestTurnedIn 12985
step
.loop 30,TheStormPeaks,68.78,60.17,69.65,58.90,68.43,57.99,69.26,57.06,70.91,56.86,70.87,61.36,70.28,62.29,68.50,63.29,69.70,61.40,68.78,60.17
>>Use the |T134710:0|t[Diamond Tipped Pick] on |cRXP_ENEMY_Dead Iron Giants|r. Loot them for their |cRXP_LOOT_Stormforged Eyes|r
>>Kill |cRXP_ENEMY_Stormforged Ambushers|r if they spawn after using the |T134710:0|t[Diamond Tipped Pick]. Loot them for their |cRXP_LOOT_Stormforged Eyes|r
.complete 12985,1 
.target Dead Iron Giant
.mob Stormforged Ambusher
.use 42424
.isOnQuest 12985
step
.goto TheStormPeaks,63.20,63.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Njormeld|r
.turnin 12985 >>Turn in Forging a Head
.accept 12987 >>Accept Placing Hodir's Helm
.target Njormeld
.isQuestComplete 12985
step
.goto TheStormPeaks,63.20,63.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Njormeld|r
.accept 12987 >>Accept Placing Hodir's Helm
.target Njormeld
.isQuestTurnedIn 12985
step
.goto TheStormPeaks,64.24,59.23
>>|cRXP_WARN_Fly up to the Sparkling Ice Pike|r
>>|cRXP_WARN_Use the|r |T134465:0|t[Tablets of Pronouncement] |cRXP_WARN_when on your flying mount|r
.complete 12987,1 
.use 42442
step
.goto TheStormPeaks,63.20,63.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Njormeld|r
.turnin 12987 >>Turn in Placing Hodir's Helm
.target Njormeld
step
.goto TheStormPeaks,64.84,59.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Randvir|r
.accept 13001 >>Accept Forging Hodir's Spear
.target Lorekeeper Randvir
.reputation 1119,honored,<0,1
step
.loop 55,TheStormPeaks,58.25,60.13,58.94,61.67,57.78,63.59,56.10,66.05,56.16,67.71,55.57,67.15,53.89,65.30,54.47,64.87,56.75,64.02,57.14,61.83,58.25,60.13
>>Kill |cRXP_ENEMY_Stoic Mammoths|r. Loot them for their |cRXP_LOOT_Stoic Mammoth Hide|r
>>|cRXP_WARN_Try to kill the packs of |cRXP_ENEMY_Stoic Mammoths|r running around the Valley|r
.complete 13001,2 
.mob Stoic Mammoth
.isOnQuest 13001
step
#completewith EverS
.goto TheStormPeaks,55.80,63.82,30 >>Enter the Hibernal Cavern
step
#completewith EverS
.goto TheStormPeaks,55.53,63.25,20,0
.goto TheStormPeaks,55.62,61.31,20,0
.goto TheStormPeaks,54.81,61.12,15 >>Travel toward the |cRXP_LOOT_Everfrost Shards|r
.isQuestTurnedIn 13011
step
.goto TheStormPeaks,55.53,63.25,30,0
.goto TheStormPeaks,55.62,61.31,30,0
.goto TheStormPeaks,55.35,60.82,30,0
.goto TheStormPeaks,54.82,60.27,30,0
.goto TheStormPeaks,54.67,61.46,30,0
.goto TheStormPeaks,55.08,61.90,30,0
.goto TheStormPeaks,55.18,62.51,30,0
.goto TheStormPeaks,53.93,61.45,15,0
.goto TheStormPeaks,54.36,61.33,20,0
.goto TheStormPeaks,53.55,61.97,30,0
.goto TheStormPeaks,53.95,63.15,30,0
.goto TheStormPeaks,54.77,63.52,30,0
.goto TheStormPeaks,55.53,63.25,30,0
.goto TheStormPeaks,55.62,61.31,30,0
.goto TheStormPeaks,55.35,60.82,30,0
.goto TheStormPeaks,54.82,60.27,30,0
.goto TheStormPeaks,54.67,61.46,30,0
.goto TheStormPeaks,55.08,61.90,30,0
.goto TheStormPeaks,55.18,62.51,30,0
.goto TheStormPeaks,53.93,61.45,15,0
.goto TheStormPeaks,54.36,61.33,20,0
.goto TheStormPeaks,53.55,61.97,30,0
.goto TheStormPeaks,53.95,63.15,30,0
.goto TheStormPeaks,54.77,63.52
>>Use the |T135288:0|t[Everfrost Razor] on |cRXP_ENEMY_Dead Icemaw Bears|r. Loot them for the |T237332:0|t[|cRXP_LOOT_Icemaw Bear Flank|r]
.collect 42733,1,13011,1 
.target Dead Icemaw Bear
.use 42732
.isOnQuest 13011
step
#completewith next
.goto TheStormPeaks,54.73,60.80
.cast 56573 >>|cRXP_WARN_Use the|r |T237332:0|t[|cRXP_LOOT_Icemaw Bear Flank|r] |cRXP_WARN_in the middle of the frozen puddle to summon|r |cRXP_ENEMY_Jorcuttar|r
.timer 6,Culling Jorcuttar RP
.use 42733
step
.goto TheStormPeaks,54.73,60.80
>>Kill |cRXP_ENEMY_Jorcuttar|r
.complete 13011,1 
.mob Jormuttar
.use 42733
step
#label EverS
.loop 10,TheStormPeaks,54.82,61.16,54.65,60.57
>>Loot |cRXP_LOOT_Everfrost Shards|r on the ground
.complete 13001,1 
.isOnQuest 13001
step << Horde
#completewith HodirSpears
.goto TheStormPeaks,54.69,60.89
.goto TheStormPeaks,54.34,50.04,20 >>|cRXP_WARN_Run on top of the Everfrost Shard. Perform a Logout Skip by logging out and then logging back in|r
.link https://www.youtube.com/watch?v=NwW-xOpStN8 >> |cRXP_WARN_CLICK HERE|r
.isOnQuest 13011
step << Horde
#completewith HodirSpears
.goto TheStormPeaks,54.69,60.89
.goto TheStormPeaks,54.34,50.04,20 >>|cRXP_WARN_Run on top of the Everfrost Shard. Perform a Logout Skip by logging out and then logging back in|r
.link https://www.youtube.com/watch?v=NwW-xOpStN8 >> |cRXP_WARN_CLICK HERE|r
.isOnQuest 13001
.isQuestTurnedIn 13011
step << Alliance
#completewith next
.hs >> Hearth to Frosthold << Mage
.hs >> Hearth to Dalaran << !Mage
step << Alliance
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Yorg|r and |cRXP_FRIENDLY_Fjorlin|r
.turnin 12874 >>Turn in Fervor of the Frostborn
.accept 12875 >>Accept An Experienced Guide
.goto TheStormPeaks,30.26,74.76
.accept 12876 >>Accept Unwelcome Guests
.goto TheStormPeaks,29.83,75.72
.target Yorg Stormheart
.target Fjorlin Frostbrow
step << Alliance
#completewith next
.goto TheStormPeaks,26.73,66.86,30 >> Enter the cave of Frostgrip's Hollow
step << Alliance
#completewith Signet
>>Kill |cRXP_ENEMY_Stormforged Invaders|r
.complete 12876,1 
.mob Stormforged Pillager
.mob Stormforged Loreseeker
step << Alliance
.goto TheStormPeaks,26.34,66.73,15,0
.goto TheStormPeaks,26.10,67.23,15,0
.goto TheStormPeaks,26.14,69.10,15,0
.goto TheStormPeaks,25.23,68.70,12,0
.goto TheStormPeaks,25.24,68.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Drom|r at the end of the cave
.turnin 12875 >>Turn in An Experienced Guide
.accept 12877 >>Accept The Lonesome Watcher
.target Drom Frostgrip
step << Alliance
#completewith next
.goto TheStormPeaks,25.23,68.70,12,0
.goto TheStormPeaks,26.14,69.10,15,0
.goto TheStormPeaks,26.13,68.71,15,0
.goto TheStormPeaks,25.59,68.20,15 >>Travel toward the middle room to spawn the |cRXP_LOOT_Stormforged Monitor|r
step << Alliance
#label Signet
.goto TheStormPeaks,25.59,68.20
>>Kill the |cRXP_LOOT_Stormforged Monitor|r. Loot him for |cRXP_LOOT_Frostgrip's Signet Ring|r
.complete 12877,1 
.mob Stormforged Monitor
step << Alliance
.loop 20,TheStormPeaks,26.28,66.45,26.02,67.27,24.98,67.20,24.99,67.97,25.10,68.36,24.35,68.63,24.87,69.46,24.99,69.86,25.37,69.96,26.01,69.32,25.34,68.89,25.37,69.96,26.17,69.07,26.02,67.27
>>Kill |cRXP_ENEMY_Stormforged Invaders|r
.complete 12876,1 
.mob Stormforged Pillager
.mob Stormforged Loreseeker
step
#completewith next
.goto TheStormPeaks,33.42,57.95,40 >>Fly up the Temple of Storms toward |cRXP_FRIENDLY_Thorim|r
step
.goto TheStormPeaks,33.42,57.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thorim|r
.turnin 13009 >>Turn in A New Beginning
.accept 13050 >>Accept Veranus
.target Thorim
step << Alliance
.line TheStormPeaks,40.89,60.14,40.32,60.20,39.06,59.56,38.69,58.57
.goto TheStormPeaks,40.89,60.14,30,0
.goto TheStormPeaks,40.32,60.20,30,0
.goto TheStormPeaks,39.06,59.56,30,0
.goto TheStormPeaks,38.69,58.57,30,0
.goto TheStormPeaks,39.06,59.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Creteus|r
.turnin 12877 >>Turn in The Lonesome Watcher
.accept 12986 >>Accept Fate of the Titans
.target Creteus
step << Alliance
#completewith next
.cast 56510 >>Use |T237452:0|t[Creteus's Mobile Databank] to summon the |cRXP_FRIENDLY_Mobile Databank|r
.use 42679
step << Alliance
.goto TheStormPeaks,45.53,49.21
>>Fly onto the middle of the Temple of Invention with your |cRXP_FRIENDLY_Mobile Databank|r out
>>|cRXP_WARN_Wait out the RP|r
.complete 12986,1 
.use 42679
step << Alliance
>>Fly onto the middle of the Temple of Order with your |cRXP_FRIENDLY_Mobile Databank|r out
>>|cRXP_WARN_Wait out the RP|r
.complete 12986,4 
.goto TheStormPeaks,53.51,42.24
.use 42679
step << Alliance
>>Fly onto the middle of the Temple of Life with your |cRXP_FRIENDLY_Mobile Databank|r out
>>|cRXP_WARN_Wait out the RP|r
.complete 12986,3 
.goto TheStormPeaks,64.38,46.47
.use 42679
step << Alliance
>>Fly onto the middle of the Temple of Winter with your |cRXP_FRIENDLY_Mobile Databank|r out
>>|cRXP_WARN_Wait out the RP|r
.complete 12986,2 
.goto TheStormPeaks,52.58,56.93
.use 42679
step
#completewith next
.goto TheStormPeaks,45.46,66.73,30 >>Fly up to the Stormpeak Hatchling Nest
step
.goto TheStormPeaks,45.46,66.73,20,0
.goto TheStormPeaks,45.51,67.15,20,0
.goto TheStormPeaks,45.20,66.81,20,0
.goto TheStormPeaks,43.76,67.20,20,0
.goto TheStormPeaks,43.62,67.29,20,0
.goto TheStormPeaks,43.88,67.75,20,0
.goto TheStormPeaks,45.46,66.73,20,0
.goto TheStormPeaks,45.51,67.15,20,0
.goto TheStormPeaks,45.20,66.81,20,0
.goto TheStormPeaks,43.76,67.20,20,0
.goto TheStormPeaks,43.62,67.29,20,0
.goto TheStormPeaks,43.88,67.75
>>Loot |cRXP_LOOT_Small Proto-Drake Eggs|r on the ground in the nests
.complete 13050,1 
step << Alliance
.line TheStormPeaks,40.89,60.14,40.32,60.20,39.06,59.56,38.69,58.57
.goto TheStormPeaks,40.89,60.14,30,0
.goto TheStormPeaks,40.32,60.20,30,0
.goto TheStormPeaks,39.06,59.56,30,0
.goto TheStormPeaks,38.69,58.57,30,0
.goto TheStormPeaks,39.06,59.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Creteus|r
.turnin 12986 >>Turn in Fate of the Titans
.accept 12878 >>Accept The Hidden Relic
.target Creteus
step << Alliance
#completewith next
.goto TheStormPeaks,41.74,62.70,30 >>Enter The Frigid Tomb
step << Alliance
#completewith next
.goto TheStormPeaks,41.99,63.41,15,0
.goto TheStormPeaks,42.91,64.35,20,0
.goto TheStormPeaks,42.83,66.17,20,0
.goto TheStormPeaks,42.96,67.08,20,0
.goto TheStormPeaks,43.39,67.63,20,0
.goto TheStormPeaks,43.86,67.03,20,0
.goto TheStormPeaks,44.51,64.54,30 >>Travel toward The Guardian's Charge
step << Alliance
.goto TheStormPeaks,44.51,64.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Guardian's Charge|r
.turnin 12878 >>Turn in The Hidden Relic
.accept 12879 >>Accept Fury of the Frostborn King
.target The Guardian's Charge
step << Alliance
#completewith next
.goto TheStormPeaks,41.74,62.70,30 >>Exit The Frigid Tomb
step << Alliance
.goto TheStormPeaks,38.25,61.71
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Creteus|r
.turnin 12879 >>Turn in Fury of the Frostborn King
.accept 12880 >>Accept The Master Explorer
.target Creteus
step
#completewith next
.goto TheStormPeaks,33.42,57.95,40 >>Fly up the Temple of Storms toward |cRXP_FRIENDLY_Thorim|r
step
.goto TheStormPeaks,33.42,57.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thorim|r
.turnin 13050 >>Turn in Veranus
.accept 13051 >>Accept Territorial Trespass
.target Thorim
step
#completewith next
.goto TheStormPeaks,38.73,65.54
.cast 56788 >> Use the |T132833:0|t[Stolen Proto-Dragon Eggs] at The Broodmother's Nest to lure |cRXP_ENEMY_Veranus|r
.timer 42,Veranus RP
.use 42797
step
.goto TheStormPeaks,38.73,65.54
>>|cRXP_WARN_Wait out the RP|r
.complete 13051,1 
step
#completewith next
.goto TheStormPeaks,33.42,57.95,40 >>Fly up the Temple of Storms toward |cRXP_FRIENDLY_Thorim|r
step
.goto TheStormPeaks,33.42,57.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thorim|r
.turnin 13051 >>Turn in Territorial Trespass
.accept 13010 >>Accept Krolmir, Hammer of Storms
.target Thorim
step
#label HodirSpears
.goto TheStormPeaks,64.84,59.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Randvir|r
.turnin 13001 >>Turn in Forging Hodir's Spear
.target Lorekeeper Randvir
.isQuestComplete 13001
step
.goto TheStormPeaks,65.45,60.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jokkum|r
.turnin 13011 >>Turn in Culling Jorcuttar
.target King Jokkum
step
.goto TheStormPeaks,65.45,60.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jokkum|r
.vehicle >>Mount |cRXP_FRIENDLY_Jokkum|r
.timer 118,Krolmir Hammer of Storms RP
.target King Jokkum
.skipgossip
.isOnQuest 13010
step
.goto TheStormPeaks,71.37,48.78
>>|cRXP_WARN_Wait out the RP|r
.complete 13010,1 
step
.goto TheStormPeaks,71.37,48.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thorim|r
>>|cRXP_WARN_Do this quickly before he disappears|r
.turnin 13010 >>Turn in Krolmir, Hammer of Storms
.accept 13057 >>Accept The Terrace of the Makers
.target Thorim
step
#completewith next
.goto TheStormPeaks,56.26,51.36,30 >> Travel to the Terrace of the Makers
step
.goto TheStormPeaks,56.26,51.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thorim|r
.turnin 13057 >>Turn in The Terrace of the Makers
.accept 13005 >>Accept The Earthen Oath
.accept 13035 >>Accept Loken's Lackeys
.target Thorim
step
#completewith Eisenfaust
+Use the |T134229:0|t[Horn of the Peaks] to summon |cRXP_FRIENDLY_Oathbound Warders|r to protect you
>>|cRXP_WARN_Use|r |T135809:0|t[Lava Burst] |cRXP_WARN_and|r |T136026:0|t[Earth Shock] |cRXP_WARN_to deal damage|r
.use 42840
step
#completewith Duronn
>>Kill |cRXP_ENEMY_Iron Dwarf Assailants|r and |cRXP_ENEMY_Iron Sentinels|r
.complete 13005,1 
.complete 13005,2 
.mob Iron Dwarf Assailant
.mob Iron Sentinel
step
.goto TheStormPeaks,48.72,45.65
>>Kill |cRXP_ENEMY_Halefnir|r
>>|cRXP_WARN_Make sure you have your |cRXP_FRIENDLY_Oathbound Warders|r summoned|r
>>|cRXP_WARN_Use the|r |cRXP_FRIENDLY_Oathbound Warders|r' |T136026:0|t[Earth Shock] |cRXP_WARN_spell to interrupt |cRXP_ENEMY_Halefnir|r's|r |T136015:0|t[Chain Lightning] |cRXP_WARN_spell|r
.complete 13035,2 
.mob Halefnir the Windborn
step
#label Duronn
.goto TheStormPeaks,44.94,38.03
>>Kill |cRXP_ENEMY_Duronn|r
>>|cRXP_WARN_Make sure you have your |cRXP_FRIENDLY_Oathbound Warders|r summoned|r
>>|cRXP_WARN_Use the|r |cRXP_FRIENDLY_Oathbound Warders|r' |T136026:0|t[Earth Shock] |cRXP_WARN_spell to interrupt |cRXP_ENEMY_Duronn|r's|r |T135915:0|t[Reconstruction] |cRXP_WARN_spell|r
.complete 13035,3 
.mob Duronn the Runewrought
step
#completewith next
.goto TheStormPeaks,56.47,41.06,70,0
.goto TheStormPeaks,56.98,44.13,30 >>Travel toward |cRXP_ENEMY_Eisenfaust|r
step
#label Eisenfaust
.goto TheStormPeaks,55.30,43.32
>>Kill |cRXP_ENEMY_Eisenfaust|r
>>|cRXP_WARN_Make sure you have your |cRXP_FRIENDLY_Oathbound Warders|r summoned|r
.complete 13035,1 
.mob Eisenfaust
step
.loop 50,TheStormPeaks,57.61,47.13,58.07,46.66,58.79,45.75,59.61,45.44,59.80,44.08,59.42,43.78,57.78,43.87,57.61,45.61,57.21,46.89,57.61,47.13
>>Use the |T134229:0|t[Horn of the Peaks] to summon |cRXP_FRIENDLY_Oathbound Warders|r to protect you
>>|cRXP_WARN_Use|r |T135809:0|t[Lava Burst] |cRXP_WARN_and|r |T136026:0|t[Earth Shock] |cRXP_WARN_to deal damage|r
>>Kill the |cRXP_ENEMY_Iron Dwarf Assailants|r and |cRXP_ENEMY_Iron Sentinels|r
.complete 13005,1 
.complete 13005,2 
.mob Iron Dwarf Assailant
.mob Iron Sentinel
.use 42840
step
.goto TheStormPeaks,56.26,51.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thorim|r
.turnin 13005 >>Turn in The Earthen Oath
.turnin 13035 >>Turn in Loken's Lackeys
.accept 13047 >>Accept The Reckoning
.target Thorim
step
.goto TheStormPeaks,44.49,28.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shavalius|r
.fp Ulduar >> Get the Ulduar flight path
.target Shavalius the Fancy
step
.goto TheStormPeaks,35.93,31.52
.gossipoption 94051 >> Talk to |cRXP_FRIENDLY_Thorim|r to start the RP
.timer 100,The Reckoning RP
.target Thorim
.skipgossip
.isOnQuest 13047
step
.goto TheStormPeaks,34.23,34.21
>>|cRXP_WARN_Wait out the RP|r
.complete 13047,1 
step << skip
#completewith end
.goto TheStormPeaks,44.49,28.19
>>Fly to the outside of Ulduar
.fp Ulduar >> Get the Ulduar flight path
.target Shavalius the Fancy
.fly Dun Niffelem >> Fly to Dun Niffelem. This takes 1m 44s, so you can take a break during this time
.skill riding,300,1
step
.goto TheStormPeaks,65.45,60.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jokkum|r
.turnin 13047 >>Turn in The Reckoning
.target King Jokkum
step << Alliance
.goto TheStormPeaks,39.56,56.36
>>|cRXP_WARN_Travel to the bottom of the Engine of the Makers|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brann|r
.turnin 12880 >>Turn in The Master Explorer
.accept 12973 >>Accept The Brothers Bronzebeard
.target Brann Bronzebeard
step << Alliance
#completewith next
.goto TheStormPeaks,39.61,56.48
.vehicle >>Get into |cRXP_FRIENDLY_Brann's Flying Machine|r
.timer 148,The Brothers Bronzebeard RP
.target Brann's Flying Machine
step << Alliance
>>Kill |cRXP_ENEMY_Stormforged Soldiers|r that jump onto |cRXP_FRIENDLY_Brann's Flying Machine|r
.goto TheStormPeaks,42.76,55.08,25 >>Fly on |cRXP_FRIENDLY_Brann's Flying Machine|r out of the Engine of the Makers
.timer 264,The Brothers Bronzebeard RP
.mob Stormforged Soldier
.isOnQuest 12973
step << Alliance
.goto TheStormPeaks,30.11,73.91
>>|cRXP_WARN_Wait out the RP|r
.complete 12973,1 
.target Brann Bronzebeard
step << Alliance
>>Talk to |cRXP_FRIENDLY_Velog|r and |cRXP_FRIENDLY_Fjorlin|r
.turnin 12973 >>Turn in The Brothers Bronzebeard
.goto TheStormPeaks,30.26,74.76
.turnin 12876 >>Turn in Unwelcome Guests
.goto TheStormPeaks,29.83,75.72
.target Velog Icebellow
.target Fjorlin Frostbrow
step
.reputation 1119,honored >> |cRXP_WARN_Reach Honored with the Sons of Hodir to unlock an additional quest for an extra|r |T135947:0|t[Emblem of Heroism]
>>You can do this by:
>>|cRXP_WARN_Turning in|r |T237427:0|t[|cRXP_LOOT_Relics of Ulduar|r] |cRXP_WARN_at|r |cRXP_FRIENDLY_Lillehoff|r
>>OR
>>|cRXP_WARN_Completing the Sons of Hodir Daily Quests. To use a specific route for this, Activate Gold Assistant Mode -> Northrend Daily Quests -> Faction Daily Quests -> The Sons of Hodir Daily Quests Route|r
>>If you don't care, skip this step
.target Lillehoff
step
.goto TheStormPeaks,64.84,59.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Randvir|r
.accept 13001 >>Accept Forging Hodir's Spear
.target Lorekeeper Randvir
.reputation 1119,honored,<0,1
step
.loop 55,TheStormPeaks,58.25,60.13,58.94,61.67,57.78,63.59,56.10,66.05,56.16,67.71,55.57,67.15,53.89,65.30,54.47,64.87,56.75,64.02,57.14,61.83,58.25,60.13
>>Kill |cRXP_ENEMY_Stoic Mammoths|r. Loot them for their |cRXP_LOOT_Stoic Mammoth Hide|r
>>|cRXP_WARN_Try to kill the packs of |cRXP_ENEMY_Stoic Mammoths|r running around the Valley|r
.complete 13001,2 
.mob Stoic Mammoth
.isOnQuest 13001
step
#completewith next
.goto TheStormPeaks,55.80,63.82,30 >>Enter the Hibernal Cavern
step
#completewith next
.goto TheStormPeaks,55.53,63.25,20,0
.goto TheStormPeaks,55.62,61.31,20,0
.goto TheStormPeaks,54.81,61.12,15 >>Travel toward the |cRXP_LOOT_Everfrost Shards|r
step
.loop 10,TheStormPeaks,54.82,61.16,54.65,60.57
>>Loot |cRXP_LOOT_Everfrost Shards|r on the ground
.complete 13001,1 
.isOnQuest 13001
step
#completewith next
.goto TheStormPeaks,54.69,60.89
.goto TheStormPeaks,54.34,50.04,20 >>|cRXP_WARN_Run on top of the Everfrost Shard. Perform a Logout Skip by logging out and then logging back in|r
.link https://www.youtube.com/watch?v=NwW-xOpStN8 >> |cRXP_WARN_CLICK HERE|r
.isOnQuest 13001
step
.goto TheStormPeaks,64.84,59.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Randvir|r
.turnin 13001 >>Turn in Forging Hodir's Spear
.target Lorekeeper Randvir
.isQuestComplete 13001
]])
RXPGuides.RegisterGuide([[
#version 23
#wotlk
#group RestedXP Completionist Guides
#name Emblems of Heroism 3 - Icecrown
step
#completewith next
.hs >> Hearth to Dalaran
.zoneskip Dalaran
.zoneskip TheStormPeaks << Alliance
step
#completewith next
.zone IcecrownGlacier >>Travel to Icecrown
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r, |cRXP_FRIENDLY_Entari|r, |cRXP_FRIENDLY_Gustav|r, and |cRXP_FRIENDLY_Dalfors|r
.accept 13036 >>Accept Honor Above All Else
.goto IcecrownGlacier,87.46,75.83
.turnin 13036 >>Turn in Honor Above All Else
.accept 13008 >>Accept Scourge Tactics
.goto IcecrownGlacier,87.11,75.86
.accept 13040 >>Accept Curing The Incurable
.goto IcecrownGlacier,86.79,76.59
.accept 13039 >>Accept Defending The Vanguard
.goto IcecrownGlacier,86.07,75.78
.target Highlord Tirion Fordring
.target Crusade Commander Entari
.target Father Gustav
.target Crusader Lord Dalfors
step
#completewith next
.loop 45,IcecrownGlacier,84.58,78.82,84.44,78.00,84.20,77.01,83.77,76.11,83.14,76.88,83.22,75.86,83.72,74.69,83.83,73.82,83.21,73.64,83.20,72.64,82.69,71.87,84.28,72.26,84.79,73.25,85.05,73.94,85.89,73.99,85.05,73.94,84.38,74.29,84.34,75.33,84.79,75.99,84.84,77.37,84.44,78.00,84.58,78.82
>>Kill |cRXP_ENEMY_Webbed Crusaders|r to free |cRXP_FRIENDLY_Freed Crusaders|r
>>|cRXP_FRIENDLY_Freed Crusaders|r |cRXP_WARN_will buff you with|r |T135970:0|t[Blessing of Wisdom]|cRXP_WARN_,|r |T135906:0|t[Blessing of Might]|cRXP_WARN_, or|r |T135995:0|t[Blessing of Kings]|cRXP_WARN_, and heal you for about 5000 health|r << !Paladin
>>|cRXP_FRIENDLY_Freed Crusaders|r |cRXP_WARN_will buff you with|r |T135995:0|t[Blessing of Kings] |cRXP_WARN_and heal you for about 5000 health. Make sure you buff yourself with either|r |T135970:0|t[Blessing of Wisdom] |cRXP_WARN_or|r |T135906:0|t[Blessing of Might] << Paladin
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Forgotten Depths Ambushers|r may be hiding in the|r |cRXP_ENEMY_Webbed Crusaders|r
.complete 13008,1 
.mob Webbed Crusader
step
.loop 45,IcecrownGlacier,84.58,78.82,84.44,78.00,84.20,77.01,83.77,76.11,83.14,76.88,83.22,75.86,83.72,74.69,83.83,73.82,83.21,73.64,83.20,72.64,82.69,71.87,84.28,72.26,84.79,73.25,85.05,73.94,85.89,73.99,85.05,73.94,84.38,74.29,84.34,75.33,84.79,75.99,84.84,77.37,84.44,78.00,84.58,78.82
>>Kill |cRXP_ENEMY_Forgotten Depths Ambushers|r, |cRXP_ENEMY_Forgotten Depths Acolytes|r, |cRXP_ENEMY_Forgotten Depths Slayers|r, and |cRXP_ENEMY_Carrion Fleshstrippers|r. Loot them for their |cRXP_LOOT_Venom Sacs|r
.complete 13039,1 
.complete 13040,1 
.mob Forgotten Depths Ambusher
.mob Forgotten Depths Acolyte
.mob Forgotten Depths Slayer
.mob Carrion Fleshstripper
step
.loop 45,IcecrownGlacier,84.58,78.82,84.44,78.00,84.20,77.01,83.77,76.11,83.14,76.88,83.22,75.86,83.72,74.69,83.83,73.82,83.21,73.64,83.20,72.64,82.69,71.87,84.28,72.26,84.79,73.25,85.05,73.94,85.89,73.99,85.05,73.94,84.38,74.29,84.34,75.33,84.79,75.99,84.84,77.37,84.44,78.00,84.58,78.82
>>Kill |cRXP_ENEMY_Webbed Crusaders|r to free |cRXP_FRIENDLY_Freed Crusaders|r
>>|cRXP_FRIENDLY_Freed Crusaders|r |cRXP_WARN_will buff you with|r |T135970:0|t[Blessing of Wisdom]|cRXP_WARN_,|r |T135906:0|t[Blessing of Might]|cRXP_WARN_, or|r |T135995:0|t[Blessing of Kings]|cRXP_WARN_, and heal you for about 5000 health|r << !Paladin
>>|cRXP_FRIENDLY_Freed Crusaders|r |cRXP_WARN_will buff you with|r |T135995:0|t[Blessing of Kings] |cRXP_WARN_and heal you for about 5000 health. Make sure you buff yourself with either|r |T135970:0|t[Blessing of Wisdom] |cRXP_WARN_or|r |T135906:0|t[Blessing of Might] << Paladin
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Forgotten Depths Ambushers|r may be hiding in the|r |cRXP_ENEMY_Webbed Crusaders|r
.complete 13008,1 
.mob Webbed Crusader
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dalfors|r, |cRXP_FRIENDLY_Gustav|r, |cRXP_FRIENDLY_Entari|r, |cRXP_FRIENDLY_Penumbrius|r
.turnin 13039 >>Turn in Defending The Vanguard
.goto IcecrownGlacier,86.07,75.78
.turnin 13040 >>Turn in Curing The Incurable
.goto IcecrownGlacier,86.79,76.59
.turnin 13008 >>Turn in Scourge Tactics
.accept 13044 >>Accept If There Are Survivors...
.goto IcecrownGlacier,87.11,75.86
.turnin 13044 >>Turn in If There Are Survivors...
.accept 13045 >>Accept Into The Wild Green Yonder
.goto IcecrownGlacier,87.01,79.01
.target Crusader Lord Dalfors
.target Father Gustav
.target Crusade Commander Entari
.target Penumbrius
step
#completewith next
.goto IcecrownGlacier,87.10,79.14
.vehicle 30228 >> Mount an |cRXP_FRIENDLY_Argent Skytalon|r
.target Argent Skytalon
step
.pin Icecrown,78.75,67.05
.waypoint IcecrownGlacier,78.75,67.05,0,rescue,VEHICLE_PASSENGERS_CHANGED,VEHICLE_UPDATE
.goto Icecrown,86.81,76.73
>>|cRXP_WARN_Cast|r |T134148:0|t[Grab Captured Crusader] (1) |cRXP_WARN_to pick up|r |cRXP_FRIENDLY_Captured Crusaders|r |cRXP_WARN_(You can only grab one at a time)|r
>>|cRXP_WARN_Return to |cRXP_FRIENDLY_Gustav|r after picking up a |cRXP_FRIENDLY_Captured Crusader|r,|r |cRXP_WARN_then cast|r |T134149:0|t[Drop Off Captured Crusader] (2)
>>|cRXP_WARN_Cast|r |T132307:0|t[Soar] (3) |cRXP_WARN_to fly faster|r
.complete 13045,1 
.target Captured Crusader
.target Father Gustav
step
.goto IcecrownGlacier,87.46,75.83
>>|cRXP_WARN_Dismount the|r |cRXP_FRIENDLY_Argent Skytalon|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.turnin 13045 >>Turn in Into The Wild Green Yonder
.accept 13070 >>Accept A Cold Front Approaches
.target Highlord Tirion Fordring
step
.goto IcecrownGlacier,85.62,76.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fezzik|r
.turnin 13070 >>Turn in A Cold Front Approaches
.accept 13086 >>Accept The Last Line Of Defense
.target Siegemaster Fezzik
step
#completewith next
.goto IcecrownGlacier,85.32,75.84,-1
.goto IcecrownGlacier,85.85,76.72,-1
.goto IcecrownGlacier,85.95,75.85,-1
>>Fly toward an |cRXP_FRIENDLY_Argent Cannon|r
.vehicle >>Mount an |cRXP_FRIENDLY_Argent Cannon|r
.target Argent Cannon
step
.goto IcecrownGlacier,84.8,75.8
>>|cRXP_WARN_Cast|r |T134287:0|t[Argent Cannon] (1) |cRXP_WARN_to deal damage and regain Mana|r
>>|cRXP_WARN_Cast|r |T237541:0|t[Reckoning Bomb] (2) |cRXP_WARN_when the |cRXP_FRIENDLY_Argent Cannon|r has enough Mana to deal a LOT of damage|r
>>Kill |cRXP_ENEMY_Forgotten Depths Slayers|r and |cRXP_ENEMY_Frostbrood Slayers|r
>>|cRXP_WARN_Get into a new |cRXP_FRIENDLY_Argent Cannon|r if yours gets destroyed by a|r |cRXP_ENEMY_Frostbrood Slayers|r
.complete 13086,1 
.complete 13086,2 
.mob Forgotten Depths Slayer
.mob Frostbrood Slayer
step
.goto IcecrownGlacier,85.62,76.01
>>Dismount the |cRXP_FRIENDLY_Argent Cannon|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fezzik|r
.turnin 13086 >>Turn in The Last Line Of Defense
.target Siegemaster Fezzik
step
.goto IcecrownGlacier,86.03,75.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.accept 13104 >>Accept Once More Unto The Breach, Hero << !DK
.accept 13105 >>Accept Once More Unto The Breach, Hero << DK
.target Highlord Tirion Fordring
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Ebon Watcher|r, |cRXP_FRIENDLY_Silas|r, |cRXP_FRIENDLY_Spitzpatrick|r, and |cRXP_FRIENDLY_Gustav|r
.turnin 13104 >>Turn in Once More Unto The Breach, Hero << !DK
.turnin 13105 >>Turn in Once More Unto The Breach, Hero << DK
.accept 13118 >>Accept The Purging Of Scourgeholme
.accept 13122 >>Accept The Scourgestone
.goto IcecrownGlacier,83.01,72.93
.accept 13130 >>Accept The Stone That Started A Revolution
.goto IcecrownGlacier,83.02,73.07
.accept 13135 >>Accept It Could Kill Us All
.goto IcecrownGlacier,82.99,73.07
.accept 13110 >>Accept The Restless Dead
.goto IcecrownGlacier,82.87,72.78
.target The Ebon Watcher
.target Crusade Architect Silas
.target Crusade Engineer Spitzpatrick
.target Father Gustav
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Silas|r and |cRXP_FRIENDLY_Spitzpatrick|r
.turnin 13130 >>Turn in The Stone That Started A Revolution
.goto IcecrownGlacier,83.02,73.07
.turnin 13135 >>Turn in It Could Kill Us All
.goto IcecrownGlacier,82.99,73.07
.target Crusade Architect Silas
.target Crusade Engineer Spitzpatrick
.isQuestComplete 13130
.isQuestComplete 13135
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Silas|r
.turnin 13130 >>Turn in The Stone That Started A Revolution
.goto IcecrownGlacier,83.02,73.07
.target Crusade Architect Silas
.isQuestComplete 13130
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Spitzpatrick|r
.turnin 13135 >>Turn in It Could Kill Us All
.goto IcecrownGlacier,82.99,73.07
.target Crusade Engineer Spitzpatrick
.isQuestComplete 13135
step
#completewith Crusaders
>>Kill |cRXP_ENEMY_Forgotten Depths High Priests|r, |cRXP_ENEMY_Forgotten Depths Underkings|r, |cRXP_ENEMY_Wrathstrike Gargoyles|r, and |cRXP_ENEMY_Reanimated Crusaders|r. Loot them for |cRXP_LOOT_Scourgestones|r
.complete 13122,1 
.mob Forgotten Depths High Priest
.mob Forgotten Depths Underking
.mob Wrathstrike Gargoyle
.mob Reanimated Crusader
step
#completewith Kings
>>|cRXP_WARN_Kill |cRXP_ENEMY_Reanimated Crusaders|r. Use the|r |T134791:0|t[Holy Water] |cRXP_WARN_on their corpses|r
>>|cRXP_WARN_Be careful as|r |cRXP_ENEMY_Reanimated Crusaders|r |cRXP_WARN_cast|r |T237529:0|t[Hammer of Injustice] (|cRXP_WARN_6 second stun|r)
.complete 13118,3 
.complete 13110,1 
.mob Reanimated Crusader
.use 43153
step
#completewith next
>>Kill |cRXP_ENEMY_Forgotten Depths Underkings|r
.complete 13118,2 
.mob Forgotten Depths Underking
step
.goto IcecrownGlacier,79.19,64.00,15,0
.goto IcecrownGlacier,79.52,64.09,15,0
.goto IcecrownGlacier,79.65,64.12,15,0
.goto IcecrownGlacier,77.70,65.51,45,0
.goto IcecrownGlacier,77.34,68.28,15,0
.goto IcecrownGlacier,77.50,68.58,15,0
.goto IcecrownGlacier,77.58,68.73,15,0
.goto IcecrownGlacier,78.92,60.93,45,0
.goto IcecrownGlacier,79.35,60.05,45,0
.goto IcecrownGlacier,79.67,60.76,15,0
.goto IcecrownGlacier,79.94,60.36,30,0
.goto IcecrownGlacier,80.57,60.88,30,0
.goto IcecrownGlacier,80.20,61.97,30,0
.goto IcecrownGlacier,79.57,61.45
>>Kill |cRXP_ENEMY_Forgotten Depths High Priests|r
.complete 13118,1 
.mob Forgotten Depths High Priest
step
#label Kings
.loop 55,IcecrownGlacier,78.61,69.42,80.84,65.14,79.19,65.04,78.18,62.85,77.09,64.60,76.65,63.15,75.21,63.11,75.73,67.13,78.61,69.42
>>Kill |cRXP_ENEMY_Forgotten Depths Underkings|r
.complete 13118,2 
.mob Forgotten Depths Underking
step
#label Crusaders
.loop 55,IcecrownGlacier,78.52,63.80,79.29,65.43,80.81,63.66,81.36,65.23,80.53,66.15,80.46,68.07,79.05,69.85,78.31,69.79,78.08,68.01,76.80,67.71,78.23,65.65,78.52,63.80
>>|cRXP_WARN_Kill |cRXP_ENEMY_Reanimated Crusaders|r. Use the|r |T134791:0|t[Holy Water] |cRXP_WARN_on their corpses|r
>>|cRXP_WARN_Be careful as|r |cRXP_ENEMY_Reanimated Crusaders|r |cRXP_WARN_cast|r |T237529:0|t[Hammer of Injustice] (|cRXP_WARN_6 second stun|r)
.complete 13118,3 
.complete 13110,1 
.mob Reanimated Crusader
.use 43153
step
.loop 55,IcecrownGlacier,78.52,63.80,79.29,65.43,80.81,63.66,81.36,65.23,80.53,66.15,80.46,68.07,79.05,69.85,78.31,69.79,78.08,68.01,76.80,67.71,78.23,65.65,78.52,63.80
>>Kill |cRXP_ENEMY_Forgotten Depths High Priests|r, |cRXP_ENEMY_Forgotten Depths Underkings|r, |cRXP_ENEMY_Wrathstrike Gargoyles|r, and |cRXP_ENEMY_Reanimated Crusaders|r. Loot them for |cRXP_LOOT_Scourgestones|r
.complete 13122,1 
.mob Forgotten Depths High Priest
.mob Forgotten Depths Underking
.mob Wrathstrike Gargoyle
.mob Reanimated Crusader
step
#completewith next
.goto CrystalsongForest,61.1,52.4,0
.goto CrystalsongForest,58.9,62.8,0
.goto CrystalsongForest,81.1,72.4,0
.goto CrystalsongForest,89.2,55.7,0
.goto CrystalsongForest,61.1,52.4,0
>>Kill the |cRXP_ENEMY_Shandaral|r and |cRXP_ENEMY_Unbound|r. Loot them for their |cRXP_LOOT_Crystallized Energy|r
.complete 13135,1 
.mob Shandaral Hunter Spirit
.mob Shandaral Druid Spirit
.mob Shandaral Warrior Spirit
.mob Shandaral Spirit Wolf
.mob Unbound Dryad
.mob Unbound Ent
.mob Unbound Corrupter
.mob Unbound Trickster
step
>>Loot |cRXP_LOOT_Crystalline Heartwood|r and |cRXP_LOOT_Ancient Elven Masonry|r on the ground
.complete 13130,1 
.loop 65,CrystalsongForest,61.95,53.52,69.39,54.34,75.65,55.87,82.81,55.91,89.03,56.83,88.84,61.89,82.97,68.90,80.59,73.98,78.61,69.57,73.00,72.27,69.90,67.54,68.63,68.93,67.23,67.71,63.94,68.17,61.98,68.45,58.97,63.85,61.95,53.52
.complete 13130,2 
.loop 55,CrystalsongForest,72.44,57.45,72.85,63.89,75.80,65.26,79.85,67.87,81.26,67.01,79.09,62.79,82.63,59.78,83.84,63.46,85.53,58.70,88.20,59.56,88.51,60.92,83.79,63.53
step
.loop 55,CrystalsongForest,72.44,57.45,72.85,63.89,75.80,65.26,79.85,67.87,81.26,67.01,79.09,62.79,82.63,59.78,83.84,63.46,85.53,58.70,88.20,59.56,88.51,60.92,83.79,63.53
>>Kill the |cRXP_ENEMY_Shandaral|r and |cRXP_ENEMY_Unbound|r. Loot them for their |cRXP_LOOT_Crystallized Energy|r
.complete 13135,1 
.mob Shandaral Hunter Spirit
.mob Shandaral Druid Spirit
.mob Shandaral Warrior Spirit
.mob Shandaral Spirit Wolf
.mob Unbound Dryad
.mob Unbound Ent
.mob Unbound Corrupter
.mob Unbound Trickster
step
#completewith next
.hs >> Hearth to Dalaran << !Mage
.cast 53140 >> Cast |T237509:0|t[Teleport: Dalaran] << Mage
.cooldown item,6948,>0 << !Mage
.zoneskip Icecrown
.zoneskip Dalaran
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Silas|r, |cRXP_FRIENDLY_Spitzpatrick|r, |cRXP_FRIENDLY_The Ebon Watcher|r, and |cRXP_FRIENDLY_Gustav|r
.turnin 13130 >>Turn in The Stone That Started A Revolution
.goto IcecrownGlacier,83.02,73.07
.turnin 13135 >>Turn in It Could Kill Us All
.goto IcecrownGlacier,82.99,73.07
.turnin 13118 >>Turn in The Purging Of Scourgeholme
.turnin 13122 >>Turn in The Scourgestone
.accept 13125 >>Accept The Air Stands Still
.goto IcecrownGlacier,83.01,72.93
.turnin 13110 >>Turn in The Restless Dead
.goto IcecrownGlacier,82.87,72.78
.target Crusade Architect Silas
.target Crusade Engineer Spitzpatrick
.target The Ebon Watcher
.target Father Gustav
.isOnQuest 13130
.isOnQuest 13135
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Silas|r, |cRXP_FRIENDLY_The Ebon Watcher|r, and |cRXP_FRIENDLY_Gustav|r
.turnin 13130 >>Turn in The Stone That Started A Revolution
.goto IcecrownGlacier,83.02,73.07
.turnin 13118 >>Turn in The Purging Of Scourgeholme
.turnin 13122 >>Turn in The Scourgestone
.accept 13125 >>Accept The Air Stands Still
.goto IcecrownGlacier,83.01,72.93
.turnin 13110 >>Turn in The Restless Dead
.goto IcecrownGlacier,82.87,72.78
.target Crusade Architect Silas
.target The Ebon Watcher
.target Father Gustav
.isOnQuest 13130
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Spitzpatrick|r, |cRXP_FRIENDLY_The Ebon Watcher|r, and |cRXP_FRIENDLY_Gustav|r
.turnin 13135 >>Turn in It Could Kill Us All
.goto IcecrownGlacier,82.99,73.07
.turnin 13118 >>Turn in The Purging Of Scourgeholme
.turnin 13122 >>Turn in The Scourgestone
.accept 13125 >>Accept The Air Stands Still
.goto IcecrownGlacier,83.01,72.93
.turnin 13110 >>Turn in The Restless Dead
.goto IcecrownGlacier,82.87,72.78
.target Crusade Engineer Spitzpatrick
.target The Ebon Watcher
.target Father Gustav
.isOnQuest 13135
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Ebon Watcher|r and |cRXP_FRIENDLY_Gustav|r
.turnin 13118 >>Turn in The Purging Of Scourgeholme
.turnin 13122 >>Turn in The Scourgestone
.accept 13125 >>Accept The Air Stands Still
.goto IcecrownGlacier,83.01,72.93
.turnin 13110 >>Turn in The Restless Dead
.goto IcecrownGlacier,82.87,72.78
.target The Ebon Watcher
.target Father Gustav
step
#completewith next
.goto IcecrownGlacier,77.59,62.36,30,0
.cast 57906 >>Use the |T237377:0|t[War Horn of Acherus] to summon |cRXP_FRIENDLY_Munch|r
.timer 10,The Air Stands Still RP
.mob Salranax the Flesh Render
.use 43206
step
.goto IcecrownGlacier,77.32,61.89
>>Kill |cRXP_ENEMY_Salranax the Flesh Render|r
>>|cRXP_WARN_Let |cRXP_FRIENDLY_Munch|r tank|r |cRXP_ENEMY_Salranax the Flesh Render|r
>>|cRXP_WARN_Avoid |cRXP_ENEMY_Salranax the Flesh Render|r's|r |T135812:0|t[Fireballs] |cRXP_WARN_by LoSing his|r |T135812:0|t[Fireballs] |cRXP_WARN_around the building or interrupting him|r
.complete 13125,1 
.mob Salranax the Flesh Render
.use 43206
step
#completewith next
.goto IcecrownGlacier,79.40,60.75,30,0
.cast 57906 >>Use the |T237377:0|t[War Horn of Acherus] to summon |cRXP_FRIENDLY_Jayde|r
.timer 9,The Air Stands Still RP
.mob High Priest Yath'amon
.use 43206
step
.goto IcecrownGlacier,80.07,61.17
>>Kill |cRXP_ENEMY_High Priest Yath'amon|r
>>|cRXP_WARN_Let |cRXP_FRIENDLY_Jayde|r tank|r |cRXP_ENEMY_High Priest Yath'amon|r
>>|cRXP_ENEMY_High Priest Yath'amon|r |cRXP_WARN_casts|r |T136184:0|t[Psychic Scream] |cRXP_WARN_(3 second fear)
.complete 13125,3 
.mob High Priest Yath'amon
.use 43206
step
#completewith next
.cast 57906 >>Use the |T237377:0|t[War Horn of Acherus] to summon |cRXP_FRIENDLY_Darion|r
.timer 9,The Air Stands Still RP
.mob Underking Talonox
.use 43206
step
.loop 45,IcecrownGlacier,76.09,53.18,76.53,52.55,76.83,53.49,76.32,54.05,76.09,53.18
>>Kill |cRXP_ENEMY_Underking Talonox|r
>>|cRXP_WARN_Let |cRXP_FRIENDLY_Darion|r tank|r |cRXP_ENEMY_Underking Talonox|r
>>|cRXP_FRIENDLY_Darion|r |cRXP_WARN_deals a LOT of damage. You only need to tag |cRXP_ENEMY_Underking Talonox|r to get credit|r
.complete 13125,2 
.mob Underking Talonox
.use 43206
step
#completewith next
.goto IcecrownGlacier,83.03,72.62,100 >>Click |cRXP_FRIENDLY_Darion|r's |cRXP_PICK_Return to the Valley of Echoes|r portal
.target Highlord Darion Mograine
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Ebon Watcher|r and |cRXP_FRIENDLY_Gustav|r
.turnin 13125 >>Turn in The Air Stands Still
.goto IcecrownGlacier,83.01,72.93
.accept 13139 >>Accept Into The Frozen Heart Of Northrend
.goto IcecrownGlacier,82.87,72.78
.target The Ebon Watcher
.target Father Gustav
step
.goto IcecrownGlacier,86.03,75.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.turnin 13139 >>Turn in Into The Frozen Heart Of Northrend
.accept 13141 >>Accept The Battle For Crusaders' Pinnacle
.target Highlord Tirion Fordring
step
#completewith next
.goto IcecrownGlacier,80.06,71.96
.cast 58013 >> Use the |T132487:0|t[Blessed Banner of the Crusade] on the |cRXP_PICK_Pile of Crusader Skulls|r
.timer 264,The Battle For Crusaders' Pinnacle RP
.use 43243
step
.goto IcecrownGlacier,80.33,71.15
>>Kill |cRXP_ENEMY_Scourge Drudges|r, |cRXP_ENEMY_Reanimated Captains|r, and |cRXP_ENEMY_Hideous Plaguebringers|r
>>Kill |cRXP_ENEMY_Halof the Deathbringer|r when he spawns
.complete 13141,1 
.mob Halof the Deathbringer
.mob Scourge Drudge
.mob Reanimated Captain
.mob Hideous Plaguebringer
.use 43243
step
.goto IcecrownGlacier,82.87,72.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gustav|r
.turnin 13141 >>Turn in The Battle For Crusaders' Pinnacle
.accept 13157 >>Accept The Crusaders' Pinnacle
.target Father Gustav
step
.goto IcecrownGlacier,79.79,71.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.accept 13068 >>Accept A Tale of Valor
.turnin 13157 >>Turn in The Crusaders' Pinnacle
.target Highlord Tirion Fordring
step
.goto IcecrownGlacier,79.41,72.36
.fp Crusaders' Pinnacle >> Get the Crusaders' Pinnacle flight path
.target Penumbrius
step << Alliance
.goto Icecrown,79.57,72.61,10,0
.goto Icecrown,79.39,72.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ivalius|r
.accept 13225 >>Accept The Skybreaker
.target Marshal Ivalius
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Justin|r
.turnin 13418 >>Turn in Preparations for War
.turnin 13225 >>Turn in The Skybreaker
.accept 13231 >>Accept The Broken Front
.target High Captain Justin Bartlett
.isOnQuest 13418
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Justin|r
.turnin 13225 >>Turn in The Skybreaker
.accept 13231 >>Accept The Broken Front
.target High Captain Justin Bartlett
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.accept 12887 >>Accept It's All Fun and Games
.target Thassarian
step << skip
.goto IcecrownGlacier,65.1,57.2,0
.goto IcecrownGlacier,64.7,52.4,0
.goto IcecrownGlacier,62.1,45.9,0
.goto IcecrownGlacier,57.5,39.1,0
.goto IcecrownGlacier,54.7,35.3,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tGo up the stairs at the back of the ship and speak to |cRXP_FRIENDLY_Knight-Captain Drosche|r
.accept 13341 >>Accept Joining the Assault
.target Knight-Captain Drosche

step << skip
.goto IcecrownGlacier,65.1,57.2,0
.goto IcecrownGlacier,64.7,52.4,0
.goto IcecrownGlacier,62.1,45.9,0
.goto IcecrownGlacier,57.5,39.1,0
.goto IcecrownGlacier,54.7,35.3,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTake the stairs at the middle of the ship (behind |cRXP_FRIENDLY_Vindicator Maraad|r), then the stairs either side of the first staircase to go down into the engine room. Speak to |cRXP_FRIENDLY_Chief Engineer Boltwrench|r
.accept 13296 >>Accept Get to Ymirheim!
.target Vindicator Maraad; Chief Engineer Boltwrench

step << Horde
.goto IcecrownGlacier,79.57,72.61,10,0
.goto IcecrownGlacier,79.44,72.71
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hork|r
.accept 13224 >>Accept Orgrim's Hammer
.target Warlord Hork Strongbrow
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Korm|r and |cRXP_FRIENDLY_Koltira|r
.turnin 13419 >>Turn in Preperations for War
.turnin 13224 >>Turn in Orgrim's Hammer
.accept 13228 >>Accept The Broken Front
.accept 12892 >>Accept It's All Fun and Games
.target Sky-Reaver Korm Blackscar
.target Koltira Deathweaver
.isOnQuest 13419
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Korm|r and |cRXP_FRIENDLY_Koltira|r
.turnin 13224 >>Turn in Orgrim's Hammer
.accept 13228 >>Accept The Broken Front
.accept 12892 >>Accept It's All Fun and Games
.target Sky-Reaver Korm Blackscar
.target Koltira Deathweaver
step << skip
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_FRIENDLY_Davos|r |cRXP_WARN_patrols all over Orgrim's Hammer|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Davos|r
.accept 13340 >>Accept Joining the Assault
.target Warbringer Davos Rioht

step << skip
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_FRIENDLY_Copperclaw|r |cRXP_WARN_is in the back room on the bottom floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Copperclaw|r
.accept 13293 >>Accept Get to Ymirheim!
.target Chief Engineer Copperclaw

step
.goto IcecrownGlacier,79.85,30.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bridenbrad|r
.turnin 13068 >>Turn in A Tale of Valor
.accept 13072 >>Accept A Hero Remains
.target Crusader Bridenbrad
step << Alliance
#completewith Freemind
.goto IcecrownGlacier,75.97,19.92,30,0
.goto IcecrownGlacier,76.19,19.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Caris|r
.home >>Set your Hearthstone to the Silver Covenant Pavilion
.target Caris Sunlance
step << Horde
#completewith Freemind
.goto IcecrownGlacier,75.93,23.64,30,0
.goto IcecrownGlacier,76.10,23.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jarin|r
.home >> Set your Hearthstone to the Sunreaver Pavillion
.target Jarin Dawnglow
step
.goto IcecrownGlacier,44.34,21.52
>>|cRXP_WARN_Fly to the top of the tower at The Shadow Vault|r
>>|cRXP_WARN_Kill |cRXP_ENEMY_The Ocular|r by using the|r |T135636:0|t[Eyesore Blaster] |cRXP_WARN_to deal damage whilst on your flying mount|r
.complete 12887,1 << Alliance 
.complete 12892,1 << Horde 
.mob The Ocular
.use 41265
step
.goto IcecrownGlacier,44.15,24.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sliver|r
.turnin 12887 >>Turn in It's All Fun and Games << Alliance
.turnin 12892 >>Turn in It's All Fun and Games << Horde
.accept 12891 >>Accept I Have an Idea, But First...
.target Baron Sliver
step
>>Kill |cRXP_ENEMY_Shadow Cultists|r. Loot them for the |cRXP_LOOT_Cultist Rod|r
>>Kill |cRXP_ENEMY_Morbid Carcasses|r. Loot them for the |cRXP_LOOT_Abomination Hook|r
>>Kill |cRXP_ENEMY_Vault Geists|r. Loot them for the |cRXP_LOOT_Geist Rope|r
>>Kill |cRXP_ENEMY_Shadow Cultists|r, |cRXP_ENEMY_Morbid Carcasses|r, |cRXP_ENEMY_Vault Geists|r, |cRXP_ENEMY_Rabid Cannibals|r, and |cRXP_ENEMY_Death Knight Masters|r. Loot them for their |cRXP_LOOT_Scourge Essence|r
.complete 12891,1 
.loop 45,IcecrownGlacier,43.77,24.15,43.57,25.12,43.73,25.43,42.12,26.61,42.09,26.06,42.05,25.65,42.51,25.07,43.77,24.15
.complete 12891,3 
.loop 45,IcecrownGlacier,43.37,25.57,43.28,26.63,42.58,28.44,42.55,26.33,42.93,24.46,43.37,25.57
.complete 12891,2 
.loop 45,IcecrownGlacier,43.54,26.11,42.71,28.14,42.33,28.11,42.65,25.68,43.26,24.10,43.54,26.11
.complete 12891,4 
.loop 45,IcecrownGlacier,43.77,24.15,43.57,25.12,43.73,25.43,43.37,25.57,43.54,26.11,43.28,26.63,42.71,28.14,42.33,28.11,42.42,27.16,42.12,26.61,42.09,26.06,42.05,25.65,42.65,25.68,42.51,25.07,42.93,24.46,43.26,24.10,43.77,24.15
.mob Death Knight Master
.mob Shadow Cultist
.mob Morbid Carcass
.mob Rabid Cannibal
.mob Vault Geist
step
.goto IcecrownGlacier,44.15,24.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sliver|r
.turnin 12891 >>Turn in I Have an Idea, But First...
.accept 12893 >>Accept Free Your Mind
.target Baron Sliver
step
.goto IcecrownGlacier,44.42,27.00
>>|cRXP_WARN_Fly up to the balcony|r
>>Kill |cRXP_ENEMY_Vile|r
>>|cRXP_WARN_Channel the|r |T135481:0|t[Sovereign Rod] |cRXP_WARN_on |cRXP_ENEMY_Vile|r's corpse|r
.complete 12893,1 
.mob Vile
.cast 29070
.timer 5,Free Your Mind RP
.use 41366
step
.goto IcecrownGlacier,41.77,24.51
>>|cRXP_WARN_Fly up to the balcony|r
>>Kill |cRXP_ENEMY_Lady Nightswood|r
>>|cRXP_WARN_Channel the|r |T135481:0|t[Sovereign Rod] |cRXP_WARN_on |cRXP_ENEMY_Lady Nightswood|r's corpse|r
.complete 12893,2 
.mob Lady Nightswood
.cast 29070
.timer 5,Free Your Mind RP
.use 41366
step
.line IcecrownGlacier,42.95,23.25,43.64,24.02,44.62,24.23,45.40,23.75,46.00,22.44,46.13,21.07,45.84,19.99,45.27,19.22,44.66,18.86,43.99,18.84,43.28,19.28,42.95,19.89,42.58,21.17
.goto IcecrownGlacier,42.95,23.25,45,0
.goto IcecrownGlacier,43.64,24.02,45,0
.goto IcecrownGlacier,44.62,24.23,45,0
.goto IcecrownGlacier,45.40,23.75,45,0
.goto IcecrownGlacier,46.00,22.44,45,0
.goto IcecrownGlacier,46.13,21.07,45,0
.goto IcecrownGlacier,45.84,19.99,45,0
.goto IcecrownGlacier,45.27,19.22,45,0
.goto IcecrownGlacier,44.66,18.86,45,0
.goto IcecrownGlacier,43.99,18.84,45,0
.goto IcecrownGlacier,43.28,19.28,45,0
.goto IcecrownGlacier,42.95,19.89,45,0
.goto IcecrownGlacier,42.58,21.17
>>|cRXP_WARN_Fly up to the balcony|r
>>Kill |cRXP_ENEMY_The Leaper|r
>>|cRXP_WARN_Channel the|r |T135481:0|t[Sovereign Rod] |cRXP_WARN_on |cRXP_ENEMY_The Leaper|r's corpse|r
.complete 12893,3 
.mob The Leaper
.cast 29070
.timer 5,Free Your Mind RP
.use 41366
step
#label Freemind
.goto IcecrownGlacier,44.15,24.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sliver|r
.turnin 12893 >>Turn in Free Your Mind
.accept 12896 >>Accept If He Cannot Be Turned << Alliance
.accept 12897 >>Accept If He Cannot Be Turned << Horde
.target Baron Sliver
step
#completewith next
.goto IcecrownGlacier,43.96,23.35,40,0
.goto IcecrownGlacier,44.72,19.76 << Alliance
.goto IcecrownGlacier,44.92,19.90 << Horde
>>|cRXP_WARN_Go into the Shadow Vault|r
.cast 6477 >>Click the |cRXP_PICK_General's Weapon Rack|r on the ground to summon |cRXP_ENEMY_General Lightsbane|r
step
.goto IcecrownGlacier,44.67,20.30
>>Kill |cRXP_ENEMY_General Lightsbane|r
.complete 12896,1 << Alliance 
.complete 12897,1 << Horde 
.mob General Lightsbane
step << skip
.goto IcecrownGlacier,62.6,51.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tExit the building, then fly over and talk to |cRXP_FRIENDLY_Ground Commander Koup|r (on the ground)
.turnin 13341 >>Turn in Joining the Assault
.target Ground Commander Koup

step << skip
.goto IcecrownGlacier,58.34,46.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xutjja|r
.turnin 13340 >>Turn in Joining the Assault
.target Ground Commander Xutjja

step
#completewith next
.goto IcecrownGlacier,56.65,57.43,60 >>Enter the Saronite Mines
step
.goto IcecrownGlacier,54.49,59.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_R'khem|r
.accept 13308 >>Accept Mind Tricks
.target Darkspeaker R'khem
step
.goto IcecrownGlacier,55.13,59.34
>>Kill |cRXP_ENEMY_Foreman Thaldrin|r. Loot him for the |cRXP_LOOT_Foreman's Key|r
.complete 13308,1 
.mob Foreman Thaldrin
step
#label Rkhem
.goto IcecrownGlacier,54.49,59.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_R'khem|r
.turnin 13308 >>Turn in Mind Tricks
.target Darkspeaker R'khem
step
#completewith next
.goto IcecrownGlacier,56.65,57.43,50 >>Exit the Saronite Mines
step << skip
.goto Icecrown,57.01,62.53
>>Fly to |cRXP_FRIENDLY_Frazzle Geargrinder|r on the ground
.turnin 13296 >>Turn in Get to Ymirheim!
.target Frazzle Geargrinder

step << Alliance
.goto IcecrownGlacier,66.29,64.11,15,0
.goto IcecrownGlacier,66.76,64.04,15,0
.goto IcecrownGlacier,66.72,65.75,15,0
.goto IcecrownGlacier,66.46,66.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to a |cRXP_FRIENDLY_Dying Soldier|r on the ground
.complete 13231,1 

.target Dying Soldier
.skipgossip
step << skip
.loop 30,IcecrownGlacier,67.53,67.75,67.32,69.15,67.57,70.35,68.07,69.44,68.62,69.09,69.55,67.27,68.84,67.19,68.70,66.42,69.82,64.52,69.80,63.15,70.22,61.91,69.05,62.02,68.48,62.23,68.09,63.42,67.21,63.31,66.76,64.04,66.28,64.12,66.72,65.76,67.53,67.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to a |cRXP_FRIENDLY_Dying Soldiers|r on the ground
.complete 13232,1 
.target Dying Soldier
.skipgossip

step << skip
.goto IcecrownGlacier,51.94,57.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Blast Thunderbomb|r in western Ymirheim
.turnin 13293 >>Turn in Get to Ymirheim!
.target Blast Thunderbomb

step << Horde
.goto IcecrownGlacier,66.85,66.43,15,0
.goto IcecrownGlacier,67.08,67.30,15,0
.goto IcecrownGlacier,68.10,67.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to a |cRXP_FRIENDLY_Dying Berserker|r on the ground
.complete 13228,1 

.target Dying Berserker
.skipgossip
step << skip
.loop 30,IcecrownGlacier,67.53,67.75,67.32,69.15,67.57,70.35,68.07,69.44,68.62,69.09,69.55,67.27,68.84,67.19,68.70,66.42,69.82,64.52,69.80,63.15,70.22,61.91,69.05,62.02,68.48,62.23,68.09,63.42,67.21,63.31,66.76,64.04,66.28,64.12,66.72,65.76,67.53,67.75
>>Kill |cRXP_ENEMY_Dying Soldiers|r on the ground
.complete 13230,1 
.mob Dying Soldier

step
.goto IcecrownGlacier,79.79,71.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.turnin 13072 >>Turn in A Hero Remains
.accept 13073 >>Accept The Keeper's Favor
.target Highlord Tirion Fordring
step
#completewith next
.goto IcecrownGlacier,87.07,77.03
.gossipoption 94726 >>Talk to |cRXP_FRIENDLY_Lilliandra|r
.target Arch Druid Lilliandra
.skipgossip
step
#completewith next
.goto IcecrownGlacier,87.00,77.07
.zone Moonglade >> Take the |cRXP_FRIENDLY_Moonglade Portal|r to Moonglade
.target Moonglade Portal
step
.goto Moonglade,36.18,41.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Remulos|r
.turnin 13073 >>Turn in The Keeper's Favor
.accept 13074 >>Accept Hope Within the Emerald Nightmare
.target Keeper Remulos
step
.loop 20,Moonglade,36.67,40.90,37.40,43.63,34.63,41.48,34.88,43.63,33.65,44.08,32.46,43.65,32.18,40.31,33.99,39.09,35.44,38.34,36.67,40.90
>>Loot |cRXP_LOOT_Emerald Acorns|r on the ground
>>|cRXP_WARN_Avoid being hit by |cRXP_ENEMY_Nightmare Aberrations|r as they'll remove|r |T136090:0|t[Fitful Dream]
>>|cRXP_WARN_If you lose the|r |T136090:0|t[Fitful Dream]|cRXP_WARN_ buff, talk to |cRXP_FRIENDLY_Remulos|r again|r
.complete 13074,1 
.target Keeper Remulos
.skipgossip 11832,1
step
.goto Moonglade,36.18,41.80
>>|cRXP_WARN_Click the|r |T136090:0|t[Fitful Dream] |cRXP_WARN_buff to remove it|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Remulos|r
.turnin 13074 >>Turn in Hope Within the Emerald Nightmare
.accept 13075 >>Accept The Boon of Remulos
.target Keeper Remulos
step
#completewith Remulos
.goto Moonglade,36.04,42.15
.zone IcecrownGlacier >> Take the |cRXP_FRIENDLY_Moonglade Return Portal|r to Icecrown
.target Moonglade Return Portal
.cooldown item,6948,<0
step
#completewith next
.hs >> Hearth to the Silver Covenant Pavilion << Alliance
.hs >> Hearth to the Sunreaver Pavillion << Horde
.cooldown item,6948,>0
.zoneskip Icecrown
step
#label Remulos
.goto IcecrownGlacier,79.85,30.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bridenbrad|r
.turnin 13075 >>Turn in The Boon of Remulos
.accept 13076 >>Accept Time Yet Remains
.target Crusader Bridenbrad
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Justin|r
.turnin 13231 >>Turn in The Broken Front

.accept 13286 >>Accept ...All the Help We Can Get.

.target Vindicator Maraad
.target High Captain Justin Bartlett
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 12896 >>Turn in If He Cannot Be Turned
.accept 12898 >>Accept The Shadow Vault
.turnin 13286 >>Turn in ...All the Help We Can Get.
.accept 13287 >>Accept Poke and Prod
.target Thassarian
step << skip
.goto IcecrownGlacier,65.1,57.2,0
.goto IcecrownGlacier,64.7,52.4,0
.goto IcecrownGlacier,62.1,45.9,0
.goto IcecrownGlacier,57.5,39.1,0
.goto IcecrownGlacier,54.7,35.3,0
>>Take the stairs at the middle of the ship (behind Maraad), then the stairs either side of the first staircase to go down into the engine room. Speak to |cRXP_FRIENDLY_Chief Engineer Boltwrench|r
.turnin 13290 >>Turn in Your Attention, Please
.accept 13291 >>Accept Borrowed Technology
.target Chief Engineer Boltwrench
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Korm|r and |cRXP_FRIENDLY_Koltira|r
.turnin 13228 >>Turn in The Broken Front


.accept 13260 >>Accept Takes One to Know One
.turnin 12897 >>Turn in If He Cannot Be Turned
.accept 12899 >>Accept The Shadow Vault
.turnin 13260 >>Turn in Takes One to Know One
.accept 13237 >>Accept Poke and Prod
.target Koltira Deathweaver
.target Sky-Reaver Korm Blackscar
step << skip
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_FRIENDLY_Copperclaw|r |cRXP_WARN_is in the back room on the bottom floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Copperclaw|r
.turnin 13238 >>Turn in Good For Something?
.accept 13239 >>Accept Volatility
.target Chief Engineer Copperclaw
step << skip
.goto IcecrownGlacier,58.34,46.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xutjja|r
.turnin 13301 >>Turn in Assault by Ground
.target Ground Commander Xutjja
step
.goto IcecrownGlacier,42.84,24.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sliver|r
.accept 13106 >>Accept Blackwatch
.turnin 12898 >>Turn in The Shadow Vault << Alliance
.turnin 12899 >>Turn in The Shadow Vault << Horde
.accept 12938 >>Accept The Duke
.target Baron Sliver
step << skip
#completewith SLedge
.goto IcecrownGlacier,43.99,22.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Brenners|r
.home >> Set your Hearthstone to The Shadow Vault
.target Initiate Brenners
step
.goto IcecrownGlacier,44.66,20.34
>>Go inside The Shadow Vault
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lankral|r
.turnin 12938 >>Turn in The Duke
.accept 12939 >>Accept Honor Challenge
.target Duke Lankral
step
#label SLedge
.goto IcecrownGlacier,43.63,25.13,15,0
.goto IcecrownGlacier,43.29,25.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Leaper|r
.accept 12955 >>Accept Eliminate the Competition
.target The Leaper
step
#completewith TinkyW
>>|cRXP_WARN_Use the|r |T132484:0|t[Challenge Flag] |cRXP_WARN_on|r |cRXP_ENEMY_Mjordin Combatants|r |cRXP_WARN_from max range|r
>>|cRXP_WARN_You can challenge multiple |cRXP_ENEMY_Mjordin Combatants|r at once as long as you stay out of combat|r
>>|cRXP_WARN_This quest leads to a long quest chain for 2|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_where you have to kill a 5-man elite for each. If you don't wish to do this, skip this step|r
>>Loot them for their |cRXP_LOOT_Vrykul Bones|r
.collect 43089,15,13092,1,1 
.complete 12939,1 
.mob Mjordin Combatant
.use 41372
.isOnQuest 12939
step
#completewith next
.goto IcecrownGlacier,37.86,22.94
>>Fly to the Savage Ledge
.gossipoption 93700 >>|cRXP_WARN_Talk to |cRXP_FRIENDLY_Onu'zun|r to turn him hostile|r
.target Onu'zun
step
.goto IcecrownGlacier,37.86,22.94
>>Kill |cRXP_ENEMY_Onu'zun|r
.complete 12955,3 
.mob Onu'zun
step
#completewith next
.goto IcecrownGlacier,37.07,22.48
.gossipoption 93529 >>|cRXP_WARN_Talk to |cRXP_FRIENDLY_Sigrid Iceborn|r to turn her hostile|r
.target Sigrid Iceborn
step
.goto IcecrownGlacier,37.07,22.48
>>Kill |cRXP_ENEMY_Sigrid Iceborn|r
.complete 12955,1 
.mob Sigrid Iceborn
step
#completewith next
.goto IcecrownGlacier,36.15,23.57
.gossipoption 93534 >>|cRXP_WARN_Talk to |cRXP_FRIENDLY_Tinky Wickwhistle|r to turn her hostile|r
.target Tinky Wickwhistle
step
#label TinkyW
.goto IcecrownGlacier,36.15,23.57
>>Kill |cRXP_ENEMY_Tinky Wickwhistle|r
.complete 12955,4 
.mob Tinky Wickwhistle
step
.loop 45,IcecrownGlacier,36.34,24.22,36.71,24.33,37.02,24.60,37.53,24.73,37.87,24.41,37.76,23.69,37.41,22.87,37.03,23.14,36.58,23.54,36.34,24.22
>>|cRXP_WARN_Use the|r |T132484:0|t[Challenge Flag] |cRXP_WARN_on|r |cRXP_ENEMY_Mjordin Combatants|r |cRXP_WARN_from max range|r
>>|cRXP_WARN_You can challenge multiple |cRXP_ENEMY_Mjordin Combatants|r at once as long as you stay out of combat|r
>>|cRXP_WARN_This quest leads to a long quest chain for 2|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_where you have to kill a 5-man elite for each. If you don't wish to do this, skip this step|r
>>Loot them for their |cRXP_LOOT_Vrykul Bones|r
.collect 43089,15,13092,1,1 
.complete 12939,1 
.mob Mjordin Combatant
.use 41372
step
#completewith next
.goto IcecrownGlacier,37.86,25.12
.gossipoption 93528 >>|cRXP_WARN_Talk to |cRXP_FRIENDLY_Efrem the Faithful|r to turn him hostile|r
.target Efrem the Faithful
step
.goto IcecrownGlacier,37.86,25.12
>>Kill |cRXP_ENEMY_Efrem the Faithful|r
.complete 12955,2 
.mob Efrem the Faithful
step
.goto IcecrownGlacier,43.29,25.31,15,0
.goto IcecrownGlacier,43.63,25.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Leaper|r
.turnin 12955 >>Turn in Eliminate the Competition
.accept 12999 >>Accept The Bone Witch
.target The Leaper
step
.goto IcecrownGlacier,44.66,20.34
>>Go inside The Shadow Vault
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lankral|r
.turnin 12939 >>Turn in Honor Challenge
.accept 12943 >>Accept Shadow Vault Decree
.target Duke Lankral
.isQuestComplete 12939
step
.goto IcecrownGlacier,44.66,20.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lankral|r
.accept 12943 >>Accept Shadow Vault Decree
.target Duke Lankral
.isQuestTurnedIn 12939
step
.abandon 12939 >> Abandon Honor Challenge
step
#completewith next
.goto IcecrownGlacier,39.18,23.98,20 >> Enter Ufrang's Hall
step
.goto IcecrownGlacier,41.03,23.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vaelen|r
.accept 12949 >>Accept Get the Key
.target Vaelen the Flayed
.isQuestTurnedIn 12939
step
#completewith next
.goto IcecrownGlacier,40.12,23.93
.cast 31696 >>Use the |T134937:0|t[Shadow Vault Decree] on |cRXP_ENEMY_Thane Ufrang the Mighty|r
.timer 10,Shadow Vault Decree RP
.use 41776
.isQuestTurnedIn 12939
step
.goto IcecrownGlacier,40.12,23.93
>>Kill |cRXP_ENEMY_Thane Ufrang the Mighty|r
.complete 12943,1 
.mob Thane Ufrang the Mighty
.use 41776
.isQuestTurnedIn 12939
step
.line IcecrownGlacier,37.62,23.51,37.35,23.16,36.85,23.43,36.73,23.57,36.73,24.03,36.80,24.15,37.09,24.41,37.42,24.42,37.63,23.90,37.62,23.51
.goto IcecrownGlacier,37.62,23.51,40,0
.goto IcecrownGlacier,37.63,23.90,40,0
.goto IcecrownGlacier,37.42,24.42,40,0
.goto IcecrownGlacier,37.09,24.41,40,0
.goto IcecrownGlacier,36.80,24.15,40,0
.goto IcecrownGlacier,36.73,24.03,40,0
.goto IcecrownGlacier,36.73,23.57,40,0
.goto IcecrownGlacier,36.85,23.43,40,0
.goto IcecrownGlacier,37.35,23.16,40,0
.goto IcecrownGlacier,37.62,23.51
>>Kill |cRXP_ENEMY_Hroegar|r. Loot him for the |cRXP_LOOT_Key to Vaelen's Chains|r
.complete 12949,1 
.mob Instructor Hroegar
.isQuestTurnedIn 12939
step
.goto IcecrownGlacier,41.03,23.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vaelen|r
.turnin 12949 >>Turn in Get the Key
.accept 12951 >>Accept Let the Baron Know
.target Vaelen the Flayed
.isQuestTurnedIn 12939
step
.goto IcecrownGlacier,42.84,24.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sliver|r
.turnin 12951 >>Turn in Let the Baron Know
.accept 13085 >>Accept Vaelan Has Returned
.target Baron Sliver
.isQuestTurnedIn 12939
step << skip
.line IcecrownGlacier,43.55,24.21,43.15,25.13,42.84,26.09,42.53,27.96
.goto IcecrownGlacier,42.53,27.96,40,0
.goto IcecrownGlacier,42.84,26.09,40,0
.goto IcecrownGlacier,43.15,25.13,40,0
.goto IcecrownGlacier,43.55,24.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vile|r
>>|cRXP_WARN_You may need to kill the Undead near the stairs if |cRXP_FRIENDLY_Vile|r is aggroed onto them|r
.accept 12992 >>Accept Crush Dem Vrykuls!
.target Vile
step
.goto IcecrownGlacier,43.75,22.70,40,0
>>Go inside The Shadow Vault
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vaelen|r and |cRXP_FRIENDLY_Lankral|r
.turnin 13085 >>Turn in Vaelan Has Returned
.accept 12982 >>Accept Ebon Blade Prisoners
.goto IcecrownGlacier,43.12,21.07
.turnin 12943 >>Turn in Shadow Vault Decree

.goto IcecrownGlacier,44.66,20.34
.target Vaelen the Flayed
.target Duke Lankral
.isQuestTurnedIn 12939

step << skip
.goto IcecrownGlacier,31.76,41.59,55,0
.loop 50,IcecrownGlacier,31.76,41.59,32.14,41.02,32.05,40.30,32.20,39.57,31.62,39.06,31.52,37.62,31.08,37.13,29.85,37.49,29.15,38.02,28.84,39.59,29.00,40.73,29.30,40.01,29.41,39.15,30.04,38.94,30.80,39.86,31.31,40.29,31.76,41.59
>>Kill |cRXP_ENEMY_Njorndar Spear-Sisters|r, |cRXP_ENEMY_Mjordin Water Maguses|r, and |cRXP_ENEMY_Jotunheim Warriors|r. Loot them for their |cRXP_LOOT_Vrykul Bones|r
.collect 43089,15,13092,1 
.mob Njorndar Spear-Sister
.mob Mjordin Water Magus
.mob Jotunheim Warrior
step
.goto IcecrownGlacier,32.30,42.61,20,0
.goto IcecrownGlacier,32.50,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.turnin 12999 >>Turn in The Bone Witch
.accept 13042 >>Accept Deep in the Bowels of The Underhalls
.accept 13092 >>Accept Reading the Bones
.turnin 13092,2 >>Turn in Reading the Bones
.target The Bone Witch
.itemcount 43089,15 
step
.goto IcecrownGlacier,32.30,42.61,20,0
.goto IcecrownGlacier,32.50,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.turnin 12999 >>Turn in The Bone Witch
.accept 13042 >>Accept Deep in the Bowels of The Underhalls
.target The Bone Witch
step
#completewith DrTerr
.cast 57727 >> |cRXP_WARN_Use the|r |T134421:0|t[Fate Rune of Fleet Feet]
.use 43135
.itemcount 43135,1
step
.goto IcecrownGlacier,32.50,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.turnin 13093 >>Turn in Reading the Bones
.target The Bone Witch
.itemcount 43089,15 
step
>>Kill |cRXP_ENEMY_Njorndar Spear-Sisters|r, |cRXP_ENEMY_Mjordin Water Maguses|r, and |cRXP_ENEMY_Jotunheim Warriors|r. Loot them for |T134245:0|t[|cRXP_LOOT_Jotunheim Cage Keys|r]
>>Use the |T134245:0|t[|cRXP_LOOT_Jotunheim Cage Keys|r] on the |cRXP_PICK_Jotunheim Cages|r to free |cRXP_FRIENDLY_Ebon Blade Knights|r
.collect 42422,8,12982,1,-1 
.complete 12982,1 
.loop 50,IcecrownGlacier,32.16,40.94,32.21,39.93,31.65,38.87,31.01,37.02,29.16,36.28,28.91,35.10,29.74,33.97,32.03,32.49,32.84,31.23,33.95,28.96,33.24,26.02,32.08,27.34,30.64,31.33,28.91,35.10,29.16,36.28,29.70,37.58,27.45,39.46,27.80,40.32,28.13,41.18,29.38,40.06,28.76,39.50,29.48,39.24,29.91,39.00,30.66,39.66,32.16,40.94




.mob Njorndar Spear-Sister
.mob Mjordin Water Magus
.mob Jotunheim Warrior
.use 42480
.isQuestTurnedIn 12939
step << skip
#sticky
#label DaKeys
.destroy 42422 >>Destroy any leftover Jotunheim Cage Keys you have as they're no longer needed. They're in your keyring
step
#completewith next
.goto IcecrownGlacier,32.76,32.32,25 >> Enter The Underhalls
step << skip
>>Kill |cRXP_ENEMY_Valhalas Vargul|r within the Underhalls. |cRXP_WARN_Use the Ebon Blade Banner on their corpses.|r
.complete 12995,1 
.complete 12992,1 
.mob Valhalas Vargul
.use 42480
step << skip
.goto IcecrownGlacier,34.49,34.65,20,0
.goto IcecrownGlacier,36.1,33.1
>>Go in the North-East room of The Underhalls
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bethod|r
.accept 13059 >>Accept Revenge for the Vargul
.target Bethod Feigr
step << skip
.goto IcecrownGlacier,34.39,34.83,20,0
.goto IcecrownGlacier,33.1,37.7
>>Go down the first set of stairs. Use Bethod's Sword near |cRXP_ENEMY_Thane Illskar|r, then kill |cRXP_ENEMY_Volgur|r, |cRXP_ENEMY_Brita|r, and |cRXP_ENEMY_Thane Illskar|r
.complete 13059,1 
.complete 13059,2 
.mob Thane Illskar
.mob Volgur
.mob Brita
.use 42928
step
#label DrTerr
.goto IcecrownGlacier,34.15,36.10,20,0
.goto IcecrownGlacier,34.00,36.34
>>Go downstairs in The Underhalls
>>Kill |cRXP_ENEMY_Apprentice Osterkilgr|r. Loot him for |T133733:0|t[|cRXP_LOOT_Dr. Terrible's "Building a Better Flesh Giant"|r]
>>|cRXP_WARN_Use the |T133733:0|t[|cRXP_LOOT_Dr. Terrible's "Building a Better Flesh Giant"|r] to start the quest|r


.collect 42772,1,13043 
.accept 13043 >>Accept The Sum is Greater than the Parts
.mob Apprentice Osterkilgr
.use 42772
step
#completewith next
.goto IcecrownGlacier,34.37,34.68,25,0
.goto IcecrownGlacier,33.37,33.17
>>Go into the north-western room downstairs in The Underhalls
.vehicle >>Mount |cRXP_FRIENDLY_Nergeld|r
.timer 114,The Sum is Greater than the Parts RP
.target Nergeld
step
.goto IcecrownGlacier,33.81,33.82
>>|cRXP_WARN_Cast|r |T132298:0|t[Punch] (1) |cRXP_WARN_to deal AoE melee damage|r
>>|cRXP_WARN_Cast|r |T132352:0|t[Roar] (2) |cRXP_WARN_to deal AoE range damage|r
>>|cRXP_WARN_Cast|r |T236948:0|t[Stomp] (3) |cRXP_WARN_to deal AoE melee damage and knock down for 2 seconds|r
>>|cRXP_WARN_Cast|r |T135834:0|t[Chained Grip] (4) |cRXP_WARN_to pull |cRXP_ENEMY_Dr. Terrible|r to you when he spawns|r
>>|cRXP_WARN_Kill|r |cRXP_ENEMY_Dr. Terrible|r |cRXP_WARN_when he spawns|r
.complete 13043,1 
.mob Vargul Assailant
.mob Grimmr Hound
.mob Dr. Terrible
step << skip
#label Revenge2
.goto IcecrownGlacier,36.2,33.0
>>Go back upstairs to the top floor. Return to |cRXP_FRIENDLY_Bethod Feigr|r
.turnin 13059 >>Turn in Revenge for the Vargul
.target Bethod Feigr
step << skip
.goto IcecrownGlacier,34.8,35.2,30,0
.goto IcecrownGlacier,34.0,36.3
.use 42480 >>Kill |cRXP_ENEMY_Valhalas Vargul|r within the Underhalls. |cRXP_WARN_Use the Ebon Blade Banner on their corpses.|r
.complete 12995,1 
.complete 12992,1 
.mob Valhalas Vargul
step
#completewith ArtofWT
.goto IcecrownGlacier,34.83,34.57
.goto IcecrownGlacier,41.21,29.63,20 >>|cRXP_WARN_Jump onto the flag pole or the crates to the right of it. Perform a Logout Skip by logging out and then logging back in|r
.link https://www.youtube.com/watch?v=MIF-B9_bev4 >> |cRXP_WARN_CLICK HERE|r
step
#label Prisoners
.goto IcecrownGlacier,43.75,22.70,70,0
.goto IcecrownGlacier,43.12,21.07
>>Go inside the Shadow Vault
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vaelen|r
.turnin 12982 >>Turn in Ebon Blade Prisoners
.target Vaelen the Flayed
.isQuestTurnedIn 12939
step
.goto IcecrownGlacier,42.84,24.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sliver|r
.accept 12806 >>Accept To the Rise with all Due Haste!
.target Baron Sliver
.isQuestTurnedIn 12939
step
.goto IcecrownGlacier,32.30,42.61,20,0
.goto IcecrownGlacier,32.50,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.turnin 13042 >>Turn in Deep in the Bowels of The Underhalls
.turnin 13043 >>Turn in The Sum is Greater than the Parts
.accept 13091 >>Accept The Art of Being a Water Terror
.target The Bone Witch
.itemcount 43089,<15 
.isQuestComplete 13042
step
.goto IcecrownGlacier,32.30,42.61,20,0
.goto IcecrownGlacier,32.50,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.turnin 13042 >>Turn in Deep in the Bowels of The Underhalls
.turnin 13043 >>Turn in The Sum is Greater than the Parts
.accept 13091 >>Accept The Art of Being a Water Terror
.turnin 13093 >>Turn in Reading the Bones
.target The Bone Witch
.itemcount 43089,15 
.isQuestComplete 13042
step
#label ArtofWT
.goto IcecrownGlacier,32.30,42.61,20,0
.goto IcecrownGlacier,32.50,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.turnin 13043 >>Turn in The Sum is Greater than the Parts
.accept 13091 >>Accept The Art of Being a Water Terror
.target The Bone Witch
.itemcount 43089,<15 
step
.goto IcecrownGlacier,32.30,42.61,20,0
.goto IcecrownGlacier,32.50,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.turnin 13043 >>Turn in The Sum is Greater than the Parts
.accept 13091 >>Accept The Art of Being a Water Terror
.turnin 13093 >>Turn in Reading the Bones
.target The Bone Witch
.itemcount 43089,15 
step
#completewith Terror
.abandon 13042 >> Abandon Deep in the Bowels of The Underhalls
step
#completewith next
.goto Icecrown,31.37,41.24
.vehicle 30645 >> Click the |cRXP_PICK_Lock Gate|r to mount a |cRXP_FRIENDLY_Water Terror|r
>>Don't fly on top of the |cRXP_PICK_Lock Gate|r to do this or you won't be able to become a |cRXP_FRIENDLY_Water Terror|r
step
#label Terror
.loop 50,IcecrownGlacier,32.16,40.94,32.21,39.93,31.65,38.87,31.01,37.02,29.16,36.28,28.91,35.10,29.74,33.97,32.03,32.49,32.84,31.23,33.95,28.96,33.24,26.02,32.08,27.34,30.64,31.33,28.91,35.10,29.16,36.28,29.70,37.58,27.45,39.46,27.80,40.32,28.13,41.18,29.38,40.06,28.76,39.50,29.48,39.24,29.91,39.00,30.66,39.66,32.16,40.94
>>Kill |cRXP_ENEMY_Njorndar Spear-Sisters|r, |cRXP_ENEMY_Mjordin Water Maguses|r, and |cRXP_ENEMY_Jotunheim Warriors|r whilst inside the |cRXP_FRIENDLY_Water Terror|r
>>|cRXP_WARN_Cast|r |T135846:0|t[Frostbolt] |cRXP_WARN_to deal damage and gather enemies|r
>>|cRXP_WARN_Cast|r |T237590:0|t[Crashing Wave] |cRXP_WARN_to deal a LOT of AoE damage in a line|r
>>|cRXP_WARN_Cast|r |T132361:0|t[Spell Reflection] |cRXP_WARN_to reflect spells for 5 seconds|r
>>|cRXP_WARN_Cast|r |T135848:0|t[Frost Nova] |cRXP_WARN_to freeze enemies in place for 8 seconds|r
.complete 13091,1 
.mob Njorndar Spear-Sister
.mob Mjordin Water Magus
.mob Jotunheim Warrior
step
.goto IcecrownGlacier,32.30,42.61,20,0
.goto IcecrownGlacier,32.50,42.94
>>|cRXP_WARN_Dismount the|r |cRXP_FRIENDLY_Water Terror|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.turnin 13091 >>Turn in The Art of Being a Water Terror
.accept 13121 >>Accept Through the Eye
.target The Bone Witch
step << skip
#completewith next
.hs >> Hearth to The Shadow Vault
.cooldown item,6948,>0
step << skip
.goto IcecrownGlacier,42.7,26.8,60,0
.goto IcecrownGlacier,43.6,24.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to The Shadow Vault, then talk to |cRXP_FRIENDLY_Vile|r patrolling along the main road
.target Vile
.turnin 12992 >>Turn in Crush Dem Vrykuls!
step << skip
.goto IcecrownGlacier,44.7,20.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Duke Lankral|r
.target Duke Lankral
.turnin 13084 >>Turn in Vandalizing Jotunheim
step
.goto IcecrownGlacier,19.55,48.15
>>|cRXP_WARN_Travel to the platform of Death's Rise slightly above the ocean|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arete|r
.turnin 12806 >>Turn in To the Rise with all Due Haste!
.accept 12807 >>Accept The Story Thus Far...
.complete 12807,1 
.skipgossip 29344,1,1,2,2,2,2,2
.target Lord-Commander Arete
.isQuestTurnedIn 12939
step
.goto IcecrownGlacier,19.55,48.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arete|r
.turnin 12807 >>Turn in The Story Thus Far...

.target Lord-Commander Arete
.isQuestTurnedIn 12939
step
.line IcecrownGlacier,19.80,48.18,19.90,48.33,20.07,48.36,20.19,48.30,20.29,48.08,20.31,47.86,20.25,47.68,20.09,47.54,19.98,47.55,19.85,47.60,19.77,47.82,19.76,48.03,19.80,48.18
.goto IcecrownGlacier,19.80,48.18,15,0
.goto IcecrownGlacier,19.76,48.03,15,0
.goto IcecrownGlacier,19.77,47.82,15,0
.goto IcecrownGlacier,19.85,47.60,15,0
.goto IcecrownGlacier,19.98,47.55,15,0
.goto IcecrownGlacier,20.09,47.54,15,0
.goto IcecrownGlacier,20.25,47.68,15,0
.goto IcecrownGlacier,20.31,47.86,15,0
.goto IcecrownGlacier,20.29,48.08,15,0
.goto IcecrownGlacier,20.19,48.30,15,0
.goto IcecrownGlacier,20.07,48.36,15,0
.goto IcecrownGlacier,19.90,48.33,15,0
.goto IcecrownGlacier,19.80,48.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Aurochs|r
.accept 12838 >> Accept Intelligence Gathering
.target Aurochs Grimbane
.isQuestAvailable 12839
.isQuestTurnedIn 12939
step
.goto IcecrownGlacier,19.33,47.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dreadwind|r
.fp Death's Rise >> Get the Death's Rise flight path
.target Dreadwind
.isQuestTurnedIn 12939
step
.loop 40,IcecrownGlacier,10.23,45.09,10.23,45.59,10.09,46.35,10.26,46.55,10.36,46.28,10.81,45.60,10.47,44.09,10.30,43.97,10.98,40.60,10.54,39.03,9.99,36.27,9.07,36.33,8.47,36.87,6.81,38.16,7.01,38.46,7.02,39.27,6.00,37.81,4.93,38.24,6.06,39.15,5.19,43.35,5.72,43.69,6.03,44.58,7.58,43.58,8.18,43.31,8.98,42.34,8.41,44.25,8.96,47.09,9.01,46.80,8.88,46.45,8.84,44.76,10.16,44.73,10.23,45.09
>>Kill |cRXP_ENEMY_Onslaught Gryphon Riders|r, |cRXP_ENEMY_Onslaught Harbor Guards|r, |cRXP_ENEMY_Onslaught Raven Bishops|r, and |cRXP_ENEMY_Onslaught Paladins|r. Loot them for |T134239:0|t[|cRXP_LOOT_Scarlet Onslaught Trunk Keys|r]
>>|cRXP_WARN_Open the |cRXP_PICK_Scarlet Onslaught Trunks|r on the ground. Loot them for the|r |T134940:0|t[|cRXP_LOOT_Note from the Grand Admiral|r]
>>|cRXP_WARN_Use the |T134940:0|t[|cRXP_LOOT_Note from the Grand Admiral|r] to start the quest|r
.collect 40652,1,12839,1,-1 
.collect 40666,1,12839,1 
.accept 12839 >>Accept The Grand (Admiral's) Plan
.mob Onslaught Gryphon Rider
.mob Onslaught Harbor Guard
.mob Onslaught Raven Bishop
.mob Onslaught Paladin
.use 40666
.isQuestTurnedIn 12939
step
.line IcecrownGlacier,19.80,48.18,19.90,48.33,20.07,48.36,20.19,48.30,20.29,48.08,20.31,47.86,20.25,47.68,20.09,47.54,19.98,47.55,19.85,47.60,19.77,47.82,19.76,48.03,19.80,48.18
.goto IcecrownGlacier,19.80,48.18,15,0
.goto IcecrownGlacier,19.76,48.03,15,0
.goto IcecrownGlacier,19.77,47.82,15,0
.goto IcecrownGlacier,19.85,47.60,15,0
.goto IcecrownGlacier,19.98,47.55,15,0
.goto IcecrownGlacier,20.09,47.54,15,0
.goto IcecrownGlacier,20.25,47.68,15,0
.goto IcecrownGlacier,20.31,47.86,15,0
.goto IcecrownGlacier,20.29,48.08,15,0
.goto IcecrownGlacier,20.19,48.30,15,0
.goto IcecrownGlacier,20.07,48.36,15,0
.goto IcecrownGlacier,19.90,48.33,15,0
.goto IcecrownGlacier,19.80,48.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Aurochs|r
.turnin 12838 >> Turn in Intelligence Gathering
.target Aurochs Grimbane
.isQuestComplete 12838
.isQuestTurnedIn 12939
step
.abandon 12838 >> Abandon Intelligence Gathering
.itemcount 40640,<5
step << skip
.use 40551 >> Go out in the sea about 30-90 yards from the shore and kill |cRXP_ENEMY_Ravenous Jaws|r. |cRXP_WARN_Use your Gore Bladder next to their corpses|r
.mob Ravenous Jaws
.goto IcecrownGlacier,4.8,41.5,90,0
.goto IcecrownGlacier,4.3,35.9,90,0
.goto IcecrownGlacier,11.7,35.6,90,0
.goto IcecrownGlacier,13.7,42.0,90,0
.goto IcecrownGlacier,10.3,41.5,90,0
.goto IcecrownGlacier,4.8,41.5,90,0
.goto IcecrownGlacier,4.3,35.9,90,0
.goto IcecrownGlacier,11.7,35.6,90,0
.goto IcecrownGlacier,13.7,42.0,90,0
.goto IcecrownGlacier,10.3,41.5
.complete 12810,1 
step
.goto IcecrownGlacier,19.55,48.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arete|r


.turnin 12839 >>Turn in The Grand (Admiral's) Plan
.accept 12840 >>Accept In Strict Confidence
.target Lord-Commander Arete
.isQuestTurnedIn 12939
step
#sticky
#label Hartford
>>|cRXP_WARN_Fly onto the helms of the east ship|r
>>Kill |cRXP_ENEMY_Captain Hartford|r
.complete 12840,2 
.goto Icecrown,7.03,41.92,-1
.mob Captain Hartford
.isQuestTurnedIn 12939
step
>>|cRXP_WARN_Fly onto the helm of the west ship|r
>>Kill |cRXP_ENEMY_Captain Welsington|r
.complete 12840,1 
.goto Icecrown,5.67,41.93,-1
.mob Captain Welsington
.isQuestTurnedIn 12939
step << skip
.goto IcecrownGlacier,10.4,44.1
>> Kill Onslaught Gryphon Riders, then loot their Onslaught Gryphon Reins
.mob Onslaught Gryphon Rider
.collect 40970,1,12814,1 
step << skip
.goto IcecrownGlacier,19.6,47.8
>> Return to Death's Rise on your normal mount. When you get to the quest giver, use the Gryphon Reins and use "Deliver Gryphon" (1) to deliver it.
.complete 12814,1 
.use 40970
step << skip
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Uzo Deathcaller|r
.turnin 12814 >>Turn in You'll Need a Gryphon
.accept 12815 >>Accept No Fly Zone
.goto IcecrownGlacier,19.6,47.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lord-Commander Arete|r
.turnin 12840 >>Turn in In Strict Confidence
.accept 12847 >>Accept Second Chances
.goto IcecrownGlacier,19.56,48.14
step
.goto IcecrownGlacier,19.55,48.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arete|r
.turnin 12840 >>Turn in In Strict Confidence
.accept 12847 >>Accept Second Chances
.target Lord-Commander Arete
.isQuestTurnedIn 12939
step
#completewith next
.goto IcecrownGlacier,9.49,45.31,20 >>Enter the Crimson Cathedral
step
.goto IcecrownGlacier,9.53,47.28
>>Kill |cRXP_ENEMY_Archbishop Landgren|r
>>|cRXP_WARN_Use|r |T134430:0|t[Arete's Gate] |cRXP_WARN_on |cRXP_ENEMY_Archbishop Landgren|r's corpse|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You only get 1 |T135947:0|t[Emblem of Heroism] from this quest (and 1 more |T135947:0|t[Emblem of Heroism] from a similarly difficult followup)|r
.complete 12847,1 
.mob Archbishop Landgren
.isOnQuest 12847
step
.goto IcecrownGlacier,9.53,47.28
>>|cRXP_WARN_Use|r |T134430:0|t[Arete's Gate] |cRXP_WARN_on |cRXP_ENEMY_Archbishop Landgren|r's corpse|r
.complete 12847,2 

.target Archbishop Landgren
.use 40730
.isOnQuest 12847
step
.goto IcecrownGlacier,19.55,48.15
>>|cRXP_WARN_DO NOT Wait for the RP|r
>>Travel to Death's Rise
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arete|r
.turnin 12847 >> Turn in Second Chances
.accept 12852 >> Accept The Admiral Revealed
.target Lord-Commander Arete
.isQuestComplete 12847
step
.goto IcecrownGlacier,19.55,48.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arete|r
.accept 12852 >> Accept The Admiral Revealed
.target Lord-Commander Arete
.isQuestTurnedIn 12847
step
#completewith TheEye
.abandon 12847 >> Abandon Second Chances
step
#label HiddenH1
#completewith AdmiralW
.goto IcecrownGlacier,9.26,49.02,25 >> Enter The Hidden Hollow
.isOnQuest 12852
step
#requires HiddenH1
#completewith next
.goto IcecrownGlacier,9.44,47.26,20,0
.goto IcecrownGlacier,8.70,46.60,20,0
.goto IcecrownGlacier,8.31,46.38,20,0
.goto IcecrownGlacier,8.51,45.95,25 >> Travel toward |cRXP_ENEMY_Grand Admiral Westwind|r in the north-west room of the cave
.isOnQuest 12852
step
#label AdmiralW
.goto IcecrownGlacier,9.12,46.21
>>Kill |cRXP_ENEMY_Grand Admiral Westwind|r
>>|cRXP_WARN_Remove |cRXP_ENEMY_Grand Admiral Westwind|r's|r |T134430:0|t[Protection Sphere] |cRXP_WARN_buff by using the|r |T135441:0|t[Lord-Commander's Nullifier]|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You only get 1 |T135947:0|t[Emblem of Heroism] from this quest|r
.complete 12852,1 
.mob Grand Admiral Westwind
.isOnQuest 12852
step
#completewith next
.goto IcecrownGlacier,9.26,49.02,25 >> Exit The Hidden Hollow
.isOnQuest 12852
step
.goto IcecrownGlacier,19.55,48.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arete|r
.turnin 12852 >>Turn in The Admiral Revealed
.target Lord-Commander Arete
.isQuestComplete 12852
step
#completewith next
.goto IcecrownGlacier,25.09,61.29,30 >>Enter Kul'galar Keep
step
#label TheEye
.goto IcecrownGlacier,26.21,62.32
.gossipoption 94081 >>Talk to the |cRXP_FRIENDLY_Eye of the Lich King|r
.timer 65,Through The Eye RP

.isOnQuest 13121
step
.goto IcecrownGlacier,25.08,61.27
>>|cRXP_WARN_Edge your way outside until you can get onto your flying mount|r
>>|cRXP_WARN_Do NOT go out of range|r
>>|cRXP_WARN_Wait out the RP|r
.complete 13121,1 
step
.goto IcecrownGlacier,35.39,66.32
>>Fly to Blackwatch atop the mountain
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arly|r
.turnin 13106 >>Turn in Blackwatch
.accept 13117 >>Accept Where Are They Coming From?
.target Darkrider Arly
step
.goto IcecrownGlacier,36.75,70.72
>>Click the |cRXP_PICK_Summoning Altar|r
>>|cRXP_WARN_DO NOT kill|r |cRXP_ENEMY_Master Summoner Zarod|r
.complete 13117,1 
step
.goto IcecrownGlacier,35.39,66.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arly|r
.turnin 13117 >>Turn in Where Are They Coming From?
.accept 13119 >>Accept Destroying the Altars
.accept 13120 >>Accept Death's Gaze
.target Darkrider Arly
step
.loop 45,IcecrownGlacier,36.82,70.79,37.17,70.90,37.75,70.76,37.35,71.38,37.13,71.39,37.29,71.48,36.63,71.54,36.73,70.82,36.90,70.87,36.82,70.79
>>Kill |cRXP_ENEMY_Master Summoner Zarod|r. Loot him for the |T135202:0|t[|cRXP_LOOT_Master Summoner's Staff|r]
>>|cRXP_WARN_Don't worry about |cRXP_ENEMY_Summoned Soldiers|r and|r |cRXP_ENEMY_Risen Soldiers|r
.collect 43159,1,13119,1 
.mob Master Summoner Zarod
step
>>|cRXP_WARN_Channel the|r |T135202:0|t[|cRXP_LOOT_Master Summoner's Staff|r] |cRXP_WARN_on the|r |cRXP_PICK_Summoning Altars|r
>>|cRXP_WARN_The|r |T135202:0|t[|cRXP_LOOT_Master Summoner's Staff|r] |cRXP_WARN_is usable on your flying mount|r
>>|cRXP_WARN_Be careful of |cRXP_ENEMY_Scourgebeak Fleshrippers|r as they can|r |T135860:0|t[Daze] |cRXP_WARN_you off of your flying mount|r
.complete 13119,1 
.goto IcecrownGlacier,36.74,70.73,-1
.complete 13119,2 
.goto IcecrownGlacier,36.59,71.64,-1
.complete 13119,3 
.goto IcecrownGlacier,37.82,70.74,-1
.complete 13119,4 
.goto IcecrownGlacier,37.36,71.51,-1
.cast 57853
.timer 5,Destroying the Altars RP
.use 43159
step
.goto IcecrownGlacier,34.62,69.66
>>Click the |cRXP_PICK_Flesh Giant Lab Orb Stand|r on the ground
.complete 13120,2 
step
.goto IcecrownGlacier,32.59,70.58
>>Click the |cRXP_PICK_Abomination Lab Orb Stand|r on the ground
.complete 13120,1 
step
.goto IcecrownGlacier,30.53,65.08
>>Click the |cRXP_PICK_Cauldron Area Orb Stand|r on the ground
.complete 13120,3 
step
.goto IcecrownGlacier,35.39,66.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arly|r
.turnin 13119 >>Turn in Destroying the Altars
.turnin 13120 >>Turn in Death's Gaze
.accept 13134 >>Accept Spill Their Blood
.target Darkrider Arly
step << skip
#completewith Kamaros
>>Click the |cRXP_PICK_Blood Orbs|r and |cRXP_PICK_Embalming Fluid|r on the ground
.complete 13134,1 
.complete 13134,2 
step
#label JaggedS
#completewith OrbsVats
>>Kill |cRXP_ENEMY_Spiked Ghouls|r. Loot them for the |T132418:0|t[|cRXP_LOOT_Jagged Shard|r]
>>|cRXP_WARN_Use the |T132418:0|t[|cRXP_LOOT_Jagged Shard|r] to start the quest|r
.collect 43242,1,13136,1 
.accept 13136 >>Accept Jagged Shards
.mob Spiked Ghoul
.use 43242
step
#requires JaggedS
#completewith OrbsVats
>>Kill |cRXP_ENEMY_Spiked Ghouls|r. Loot them for their |cRXP_LOOT_Jagged Shards|r
.complete 13136,1 
.mob Spiked Ghoul
step << skip
.goto IcecrownGlacier,31.8,64.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Father Kamaros|r
.target Father Kamaros
.accept 13221 >>Accept I'm Not Dead Yet! << Alliance
.accept 13229 >>Accept I'm Not Dead Yet! << Horde
step << skip
#label Kamaros
.goto IcecrownGlacier,31.9,57.1
>>Escort |cRXP_FRIENDLY_Father Kamaros|r
.target Father Kamaros
.complete 13221,1 << Alliance 
.complete 13229,1 << Horde 
step
#label OrbsVats
>>Click the |cRXP_PICK_Blood Orbs|r and |cRXP_PICK_Embalming Fluid|r on the ground
.complete 13134,1 
.loop 50,IcecrownGlacier,32.07,65.05,32.13,64.28,30.00,65.03,30.07,66.12,31.68,66.47,32.06,68.47,31.56,68.52,31.36,69.37,31.23,69.86,31.89,70.90,32.63,69.54,34.69,69.89,33.66,68.98,34.08,68.50,32.07,65.05
.complete 13134,2 
.loop 50,IcecrownGlacier,33.41,65.61,32.19,64.64,30.26,64.88,31.47,69.09,31.35,70.16,31.74,70.78,32.10,70.86,32.43,70.69,32.85,70.60,32.40,68.99,34.78,69.45,33.73,69.65,33.57,68.39,33.59,68.01,33.41,65.61
step
.loop 50,IcecrownGlacier,32.18,64.93,31.79,63.89,31.35,64.10,31.86,61.15,31.95,60.75,31.61,60.15,30.90,59.36,30.78,60.19,30.97,62.27,30.64,62.32,30.86,63.63,30.48,64.39,30.90,64.62,30.01,65.32,29.97,66.05,30.20,66.05,30.48,64.39,31.54,66.14,31.87,66.09,31.74,66.68,32.23,69.08,32.34,69.35,32.35,69.69,32.51,69.75,31.68,69.61,31.94,70.23,33.24,70.68,34.81,71.07,35.18,72.15,35.65,71.78,35.32,71.53,35.69,70.17,34.41,68.96,33.84,69.79,33.86,68.97,34.05,68.34,32.18,64.93
>>Kill |cRXP_ENEMY_Spiked Ghouls|r. Loot them for their |cRXP_LOOT_Jagged Shards|r
.complete 13136,1 
.mob Spiked Ghoul
.isOnQuest 13136
step
.loop 50,IcecrownGlacier,32.18,64.93,31.79,63.89,31.35,64.10,31.86,61.15,31.95,60.75,31.61,60.15,30.90,59.36,30.78,60.19,30.97,62.27,30.64,62.32,30.86,63.63,30.48,64.39,30.90,64.62,30.01,65.32,29.97,66.05,30.20,66.05,30.48,64.39,31.54,66.14,31.87,66.09,31.74,66.68,32.23,69.08,32.34,69.35,32.35,69.69,32.51,69.75,31.68,69.61,31.94,70.23,33.24,70.68,34.81,71.07,35.18,72.15,35.65,71.78,35.32,71.53,35.69,70.17,34.41,68.96,33.84,69.79,33.86,68.97,34.05,68.34,32.18,64.93
>>Kill |cRXP_ENEMY_Spiked Ghouls|r. Loot them for the |T132418:0|t[|cRXP_LOOT_Jagged Shard|r]
>>|cRXP_WARN_Use the |T132418:0|t[|cRXP_LOOT_Jagged Shard|r] to start the quest|r
.collect 43242,1,13136,1 
.accept 13136 >>Accept Jagged Shards
.mob Spiked Ghoul
.use 43242
step
.loop 50,IcecrownGlacier,32.18,64.93,31.79,63.89,31.35,64.10,31.86,61.15,31.95,60.75,31.61,60.15,30.90,59.36,30.78,60.19,30.97,62.27,30.64,62.32,30.86,63.63,30.48,64.39,30.90,64.62,30.01,65.32,29.97,66.05,30.20,66.05,30.48,64.39,31.54,66.14,31.87,66.09,31.74,66.68,32.23,69.08,32.34,69.35,32.35,69.69,32.51,69.75,31.68,69.61,31.94,70.23,33.24,70.68,34.81,71.07,35.18,72.15,35.65,71.78,35.32,71.53,35.69,70.17,34.41,68.96,33.84,69.79,33.86,68.97,34.05,68.34,32.18,64.93
>>Kill |cRXP_ENEMY_Spiked Ghouls|r. Loot them for their |cRXP_LOOT_Jagged Shards|r
.complete 13136,1 
.mob Spiked Ghoul
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arly|r and |cRXP_FRIENDLY_Olakin|r
.turnin 13134 >>Turn in Spill Their Blood
.goto IcecrownGlacier,35.39,66.32
.turnin 13136 >>Turn in Jagged Shards
.accept 13138 >>Accept I'm Smelting... Smelting!
.accept 13140 >>Accept The Runesmiths of Malykriss
.goto IcecrownGlacier,35.50,66.44
.target Crusader Olakin Sainrith
.target Darkrider Arly
step
#completewith next
>>Kill |cRXP_ENEMY_Skeletal Runesmiths|r. Loot them for |cRXP_LOOT_Runed Saronite Plate|r
.complete 13140,1 
.mob Skeletal Runesmith
step
.goto IcecrownGlacier,57.83,74.36
>>|cRXP_WARN_Use the|r |T133649:0|t[Bag of Jagged Shards] |cRXP_WARN_next to the|r |cRXP_PICK_Furnace|r
.complete 13138,1 
.use 43289
step
.loop 50,IcecrownGlacier,57.71,74.52,57.77,74.10,58.69,73.45,59.41,73.41,59.43,74.23,58.66,74.25,57.71,74.52
>>Kill |cRXP_ENEMY_Skeletal Runesmiths|r. Loot them for |cRXP_LOOT_Runed Saronite Plate|r
.complete 13140,1 
.mob Skeletal Runesmith
step << skip
#sticky
#label FieldTest
.goto IcecrownGlacier,67.2,68.3,70,0
.goto IcecrownGlacier,68.0,70.9,70,0
.goto IcecrownGlacier,71.6,61.3,70,0
.goto IcecrownGlacier,67.2,68.3
>>Loot the |cRXP_PICK_pieces of abandoned equipment|r scattered on the ground around The Broken Front. Use Copperclaw's Volatile Oil when you have one of each piece of equipment (you don't need to wait for the RP) << Alliance
.collect 43609,3,13291,1,-1 << Alliance 
.collect 43610,3,13291,1,-1 << Alliance 
.collect 43616,3,13291,1,-1 << Alliance 
.complete 13291,1 << Alliance 
.use 43608 >>Loot the |cRXP_PICK_pieces of abandoned equipment|r scattered on the ground around The Broken Front. Use Copperclaw's Volatile Oil when you have one of each piece of equipment (you don't need to wait for the RP) << Horde
.collect 43609,3,13239,1,-1 << Horde 
.collect 43610,3,13239,1,-1 << Horde 
.collect 43616,3,13239,1,-1 << Horde 
.complete 13239,1 << Horde 
.use 44048 << Alliance
.use 43608 << Horde
step
.loop 50,IcecrownGlacier,66.66,63.14,66.65,64.19,67.11,65.05,66.61,66.08,67.39,68.40,67.59,70.51,68.97,68.66,69.13,67.03,70.59,67.35,71.49,69.37,70.59,67.35,69.82,65.98,70.36,65.32,69.69,63.93,70.21,63.42,71.56,62.25,70.96,60.79,69.72,62.55,68.66,63.24,66.66,63.14
>>Kill |cRXP_ENEMY_Hulking Abominations|r, |cRXP_ENEMY_Malefic Necromancers|r, and |cRXP_ENEMY_Shadow Adepts|r
.complete 13287,1 << Alliance 
.complete 13287,2 << Alliance 
.complete 13287,3 << Alliance 
.complete 13237,1 << Horde 
.complete 13237,2 << Horde 
.complete 13237,3 << Horde 
.mob Hulking Abomination
.mob Malefic Necromancer
.mob Shadow Adept
step
.goto IcecrownGlacier,79.79,71.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.turnin 13076 >>Turn in Time Yet Remains
.accept 13077 >>Accept The Touch of an Aspect
.target Highlord Tirion Fordring
step
.goto Dragonblight,59.84,54.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alextrasza|r atop Wyrmrest Temple
.turnin 13077 >>Turn in The Touch of an Aspect
.accept 13078 >>Accept Dahlia's Tears
.target Alexstrasza the Life-Binder
step
.goto Dragonblight,50.14,52.57,12,0
.goto Dragonblight,50.58,51.87,12,0
.goto Dragonblight,50.21,51.63,12,0
.goto Dragonblight,52.25,47.12,12,0
.goto Dragonblight,52.06,46.55,12,0
.goto Dragonblight,51.89,47.68,12,0
.goto Dragonblight,51.69,47.22,12,0
.goto Dragonblight,44.39,52.08,12,0
.goto Dragonblight,44.28,52.30,12,0
.goto Dragonblight,44.05,52.49,12,0
.goto Dragonblight,43.86,51.50,12,0
.goto Dragonblight,43.76,52.03,12,0
.goto Dragonblight,43.30,52.06,12,0
.goto Dragonblight,43.39,51.40
>>Loot |cRXP_LOOT_Dahlia's Tears|r on the ground
.complete 13078,1 
step
.goto Dragonblight,59.84,54.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alextrasza|r atop Wyrmrest Temple
.turnin 13078 >>Turn in Dahlia's Tears
.accept 13079 >>Accept The Boon of Alexstrasza
.target Alexstrasza the Life-Binder
step
#completewith next
.hs >> Hearth to the Silver Covenant Pavilion << Alliance
.hs >> Hearth to the Sunreaver Pavillion << Horde
.cooldown item,6948,>0
.zoneskip Icecrown
step
.goto IcecrownGlacier,79.85,30.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bridenbrad|r
.turnin 13079 >>Turn in The Boon of Alexstrasza
.accept 13080 >>Accept Hope Yet Remains
.target Crusader Bridenbrad
step << skip
#sticky
#label notdead
.goto IcecrownGlacier,65.1,57.2,0
.goto IcecrownGlacier,64.7,52.4,0
.goto IcecrownGlacier,62.1,45.9,0
.goto IcecrownGlacier,57.5,39.1,0
.goto IcecrownGlacier,54.7,35.3,0
.goto IcecrownGlacier,54.7,35.3,200,0
.goto IcecrownGlacier,65.1,57.2,200,0
.goto IcecrownGlacier,54.7,35.3
>>Find |cRXP_FRIENDLY_Absalan the Pious|r, he walks up and down the stairs around the back of the ship
.target Absalan the Pious
.turnin 13221 >>Turn in I'm Not Dead Yet!

step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13287 >>Turn in Poke and Prod
.accept 13288 >>Accept That's Abominable!
.accept 13294 >>Accept Against the Giants
.accept 13386 >>Accept Exploiting an Opening
.target Thassarian
step << skip
#requires notdead
.goto IcecrownGlacier,65.1,57.2,0
.goto IcecrownGlacier,64.7,52.4,0
.goto IcecrownGlacier,62.1,45.9,0
.goto IcecrownGlacier,57.5,39.1,0
.goto IcecrownGlacier,54.7,35.3,0
.goto IcecrownGlacier,54.7,35.3,200,0
.goto IcecrownGlacier,65.1,57.2,200,0
.goto IcecrownGlacier,54.7,35.3
>>Take the stairs at the middle of the ship (behind Maraad), then the stairs either side of the first staircase to go down into the engine room. Speak to Chief Engineer Boltwrench
.turnin 13291 >>Turn in Borrowed Technology

step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13237 >>Turn in Poke and Prod
.accept 13258 >>Accept Opportunity
.accept 13264 >>Accept That's Abominable!
.accept 13277 >>Accept Against the Giants
.target Koltira Deathweaver
step << skip
>> Find |cRXP_FRIENDLY_Brother Keltan|r on the stairs.
.target Brother Keltan
.turnin 13229 >>Turn in I'm Not Dead Yet!
step << skip
>> Go to |cRXP_FRIENDLY_Chief Engineer Copperclaw|r on the lower deck.
.target Chief Engineer Copperclaw
.turnin 13239 >>Turn in Volatility
step
.loop 50,IcecrownGlacier,63.43,56.62,63.21,57.67,65.15,59.53,65.05,62.81,65.75,62.99,65.05,62.81,65.15,59.53,66.02,60.20,65.15,59.53,69.06,57.47,69.89,57.65,69.47,58.92,69.89,57.65,70.38,57.84,71.14,58.17,72.71,58.74
>>Fly on top of Mord'rathar: The Death Gate
>>Kill |cRXP_ENEMY_Pustulent Horrors|r. Loot them for |cRXP_LOOT_Pustulant Spines|r
>>|cRXP_WARN_This quest can be difficult. Find a group for them if needed. Skip this step if you're unable to find a group or solo them. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 2|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
.complete 13277,1 << Horde 
.complete 13294,1 << Alliance 
.mob Pustulent Horror
.isOnQuest 13277 << Horde
.isOnQuest 13294 << Alliance
step
.loop 60,IcecrownGlacier,66.48,62.36,67.45,61.45,68.33,61.23,69.09,60.93,69.89,60.77
>>|cRXP_WARN_Kill |cRXP_ENEMY_Hulking Abominations|r. Loot them for|r |T237415:0|t[|cRXP_LOOT_Chilled Abomination Guts|r]
>>|cRXP_WARN_You can only have 1|r |T237415:0|t[|cRXP_LOOT_Chilled Abomination Gut|r] |cRXP_WARN_at a time|r
>>|cRXP_WARN_Use the|r |T133667:0|t[Abominations Reanimation Kit] |cRXP_WARN_with the|r |T237415:0|t[|cRXP_LOOT_Chilled Abomination Guts|r] |cRXP_WARN_to summon a |cRXP_FRIENDLY_Reanimated Abomination|r you control|r
>>|cRXP_WARN_Gather as many |cRXP_ENEMY_Icy Ghouls|r, |cRXP_ENEMY_Vicious Geists|r, and |cRXP_ENEMY_Risen Alliance Soldiers|r as possible by attacking them with the|r |cRXP_FRIENDLY_Reanimated Abomination|r
>>|cRXP_WARN_When your |cRXP_FRIENDLY_Reanimated Abomination|r is at low health, cast|r |T136133:0|t[Burst at the Seams] |cRXP_WARN_to kill all the |cRXP_ENEMY_Undead|r IN COMBAT near your|r |cRXP_FRIENDLY_Reanimated Abomination|r
>>|cRXP_WARN_Make sure your subzone is The Broken Front, or your |cRXP_FRIENDLY_Reanimated Abomination|r will disappear|r
>>|cRXP_WARN_This quest leads to a long quest chain for 4|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_where you have to kill 5-man elites for each. If you don't wish to do this, skip this step|r
.collect 43966,1,13288,1,1 << Alliance 
.collect 43966,1,13264,1,1 << Horde 
.complete 13288,1 << Alliance 
.complete 13264,1 << Horde 
.complete 13288,2 << Alliance 
.complete 13264,2 << Horde 
.complete 13288,3 << Alliance 
.complete 13264,3 << Horde 
.mob Hulking Abomination
.mob Icy Ghoul
.mob Vicious Geist
.mob Risen Alliance Soldier
.use 43968
.isOnQuest 13288 << Alliance
.isOnQuest 13264 << Horde
step << Alliance
.goto Icecrown,51.75,86.69
>>Fly down below Icecrown Citadel
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kendall|r
.turnin 13386 >>Turn in Exploiting an Opening
.accept 13387 >>Accept Securing the Perimeter
.target Captain Kendall
step << Horde
.goto IcecrownGlacier,54.94,84.18
>>Fly down below Icecrown Citadel
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kregga|r
.turnin 13258 >>Turn in Opportunity
.accept 13259 >>Accept Establishing Superiority
.target Sergeant Kregga
step
.loop 55,IcecrownGlacier,54.43,86.11,54.18,85.99,53.85,86.01,53.54,86.17,53.31,86.39,53.13,86.67,52.93,87.19,52.86,87.77,52.89,88.17,52.97,88.55,53.14,88.97,53.38,89.30,53.62,89.48,53.87,89.59,54.27,89.58,54.64,89.37,54.85,89.14,55.03,88.84,55.19,88.40,55.25,87.92,55.24,87.51,55.17,87.13,54.98,86.61,54.68,86.24,54.43,86.11
>>Kill |cRXP_ENEMY_Hulking Horrors|r
.complete 13387,1 << Alliance 
.complete 13259,1 << Horde 
.mob Hulking Horror
step << Alliance
.goto Icecrown,51.75,86.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kendall|r
.turnin 13387 >>Turn in Securing the Perimeter
.accept 13388 >>Accept Set it Off!
.target Captain Kendall
step << Horde
.goto IcecrownGlacier,54.94,84.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kregga|r
.turnin 13259 >>Turn in Establishing Superiority
.accept 13262 >>Accept Blow it Up!
.target Sergeant Kregga
step
.goto IcecrownGlacier,54.37,86.31
>>Click the |cRXP_PICK_Saronite Bomb Stack|r
.turnin 13388 >>Turn in Set it Off! << Alliance
.accept 13389 >>Accept A Short Fuse << Alliance
.turnin 13262 >>Turn in Blow it Up! << Horde
.accept 13263 >>Accept A Short Fuse << Horde
.timer 15,A Short Fuse RP
step
.goto Icecrown,53.99,87.29
>>|cRXP_WARN_Wait out the RP|r
>>Click the |cRXP_PICK_Pulsing Crystal|r underwater
.turnin 13389 >>Turn in A Short Fuse << Alliance
.accept 13390 >>Accept A Voice in the Dark << Alliance
.turnin 13263 >>Turn in A Short Fuse << Horde
.accept 13271 >>Accept A Voice in the Dark << Horde
step
.goto Icecrown,53.81,86.93
>>|cRXP_WARN_Do NOT click the|r |cRXP_PICK_Surface Portal|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Matthias|r
.turnin 13390 >>Turn in A Voice in the Dark << Alliance
.accept 13391 >>Accept Time to Hide << Alliance
.turnin 13271 >>Turn in A Voice in the Dark << Horde
.accept 13275 >>Accept Time to Hide << Horde
.target Matthias Lehner
step
.loop 40,IcecrownGlacier,54.58,87.18,55.01,86.53,56.07,85.33,56.73,85.83,55.70,87.08,54.80,88.65,54.41,89.86,53.68,89.63,54.58,87.18
>>|cRXP_WARN_Do NOT click the|r |cRXP_PICK_Surface Portal|r
>>Kill |cRXP_ENEMY_Faceless Lurkers|r. Loot them for the |cRXP_LOOT_Faceless One's Blood|r
.complete 13391,1 << Alliance 
.complete 13275,1 << Horde 
.mob Faceless Lurker
step
.goto Icecrown,53.81,86.93
>>|cRXP_WARN_Do NOT click the|r |cRXP_PICK_Surface Portal|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Matthias|r
.turnin 13391 >>Turn in Time to Hide << Alliance
.accept 13392 >>Accept Return to the Surface << Alliance
.turnin 13275 >>Turn in Time to Hide << Horde
.accept 13282 >>Accept Return to the Surface << Horde
.target Matthias Lehner
step
#completewith next
.goto IcecrownGlacier,53.78,86.84
.goto IcecrownGlacier,49.07,71.56,100 >> Click the |cRXP_PICK_Surface Portal|r behind |cRXP_FRIENDLY_Matthias|r to return to the surface
step
.goto IcecrownGlacier,79.79,71.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.turnin 13080 >>Turn in Hope Yet Remains
.accept 13081 >>Accept The Will of the Naaru
.timer 15,The Will of the Naaru RP
.target Highlord Tirion Fordring
step
#completewith next
.goto IcecrownGlacier,79.90,71.84
>>|cRXP_WARN_Wait out the RP|r
>>|cRXP_WARN_If you miss the portal, abandon "The Will of the Naaru" and accept it again|r << !Mage
>>|cRXP_WARN_If you miss the portal, cast |T135760:0|t[Teleport: Shattrath] << Mage
.zone Shattrath City >>|cRXP_WARN_Click the |cRXP_PICK_Portal to Shattrath|r that |cRXP_FRIENDLY_Rhydian|r summons for you|r
step
.goto Shattrath City,53.98,44.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_A'dal|r
.turnin 13081 >>Turn in The Will of the Naaru
.accept 13082 >>Accept The Boon of A'dal
.target A'dal
step
#completewith next
.hs >> Hearth to the Silver Covenant Pavilion << Alliance
.hs >> Hearth to the Sunreaver Pavillion << Horde
.cooldown item,6948,>0
.zoneskip Icecrown
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bridenbrad|r
>>Click |cRXP_PICK_Bridenbrad's Possessions|r on the ground
.turnin 13082 >>Turn in The Boon of A'dal
.goto IcecrownGlacier,79.85,30.82
.accept 13083 >>Accept Light Within the Darkness
.goto IcecrownGlacier,79.79,30.83
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13264 >>Turn in That's Abominable!

.turnin 13277 >>Turn in Against the Giants
.accept 13278 >>Accept Corpous the Defiled
.accept 13279 >>Accept Basic Chemistry
.accept 13351 >>Accept Sneak Preview
.turnin 13282 >>Turn in Return to the Surface
.accept 13304 >>Accept Field Repairs
.target Koltira Deathweaver
.isQuestComplete 13264
.isQuestComplete 13277
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13264 >>Turn in That's Abominable!

.accept 13351 >>Accept Sneak Preview
.turnin 13282 >>Turn in Return to the Surface
.accept 13304 >>Accept Field Repairs
.target Koltira Deathweaver
.isQuestComplete 13264
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13277 >>Turn in Against the Giants
.accept 13278 >>Accept Corpous the Defiled
.accept 13279 >>Accept Basic Chemistry
.turnin 13282 >>Turn in Return to the Surface
.accept 13304 >>Accept Field Repairs
.target Koltira Deathweaver
.isQuestComplete 13277
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r

.accept 13278 >>Accept Corpous the Defiled
.accept 13279 >>Accept Basic Chemistry
.accept 13351 >>Accept Sneak Preview
.turnin 13282 >>Turn in Return to the Surface
.accept 13304 >>Accept Field Repairs
.target Koltira Deathweaver
.isQuestTurnedIn 13264
.isQuestTurnedIn 13277
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.accept 13278 >>Accept Corpous the Defiled
.accept 13279 >>Accept Basic Chemistry
.turnin 13282 >>Turn in Return to the Surface
.accept 13304 >>Accept Field Repairs
.target Koltira Deathweaver
.isQuestTurnedIn 13277
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r

.accept 13351 >>Accept Sneak Preview
.turnin 13282 >>Turn in Return to the Surface
.accept 13304 >>Accept Field Repairs
.target Koltira Deathweaver
.isQuestTurnedIn 13264
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13282 >>Turn in Return to the Surface
.accept 13304 >>Accept Field Repairs
.target Koltira Deathweaver
step << Horde
#completewith Parting
.abandon 13264 >> Abandon That's Abominable!
step << Horde
#completewith Parting
.abandon 13277 >> Abandon Against the Giants
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13288 >>Turn in That's Abominable!
.turnin 13294 >>Turn in Against the Giants
.accept 13315 >>Accept Sneak Preview
.accept 13295 >>Accept Basic Chemistry
.accept 13298 >>Accept Coprous the Defiled
.turnin 13392 >>Turn in Return to the Surface
.accept 13393 >>Accept Field Repairs
.target Thassarian
.isQuestComplete 13288
.isQuestComplete 13294
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13288 >>Turn in That's Abominable!
.accept 13315 >>Accept Sneak Preview
.turnin 13392 >>Turn in Return to the Surface
.accept 13393 >>Accept Field Repairs
.target Thassarian
.isQuestComplete 13288
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13294 >>Turn in Against the Giants
.accept 13295 >>Accept Basic Chemistry
.accept 13298 >>Accept Coprous the Defiled
.turnin 13392 >>Turn in Return to the Surface
.accept 13393 >>Accept Field Repairs
.target Thassarian
.isQuestComplete 13294
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.accept 13315 >>Accept Sneak Preview
.accept 13295 >>Accept Basic Chemistry
.accept 13298 >>Accept Coprous the Defiled
.turnin 13392 >>Turn in Return to the Surface
.accept 13393 >>Accept Field Repairs
.target Thassarian
.isQuestTurnedIn 13288
.isQuestTurnedIn 13294
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.accept 13315 >>Accept Sneak Preview
.turnin 13392 >>Turn in Return to the Surface
.accept 13393 >>Accept Field Repairs
.target Thassarian
.isQuestTurnedIn 13288
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.accept 13295 >>Accept Basic Chemistry
.accept 13298 >>Accept Coprous the Defiled
.turnin 13392 >>Turn in Return to the Surface
.accept 13393 >>Accept Field Repairs
.target Thassarian
.isQuestTurnedIn 13294
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13392 >>Turn in Return to the Surface
.accept 13393 >>Accept Field Repairs
.target Thassarian
step << skip
.goto IcecrownGlacier,65.1,57.2,0
.goto IcecrownGlacier,64.7,52.4,0
.goto IcecrownGlacier,62.1,45.9,0
.goto IcecrownGlacier,57.5,39.1,0
.goto IcecrownGlacier,54.7,35.3,0
.goto IcecrownGlacier,54.7,35.3,200,0
.goto IcecrownGlacier,65.1,57.2,200,0
.goto IcecrownGlacier,54.7,35.3
>>Take the stairs at the middle of the ship (behind Maraad), then the stairs either side of the first staircase to go down into the engine room. Speak to Chief Engineer Boltwrench
.turnin 13292 >>Turn in The Solution Solution

step
>>Fly toward the different parts of Aldur'thar
.complete 13315,1 << Alliance 
.complete 13351,1 << Horde 
.goto Icecrown,55.64,46.73
.complete 13315,2 << Alliance 
.complete 13351,2 << Horde 
.goto Icecrown,54.10,43.43
.complete 13315,3 << Alliance 
.complete 13351,3 << Horde 
.goto Icecrown,54.09,35.33
.complete 13315,4 << Alliance 
.complete 13351,4 << Horde 
.goto Icecrown,52.06,34.21
.isOnQuest 13315 << Alliance
.isOnQuest 13351 << Horde
step
.goto IcecrownGlacier,44.06,24.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keritose|r
.accept 13168 >>Accept Parting Gifts
.target Keritose Bloodblade
step
.goto IcecrownGlacier,44.10,24.78,-1
.goto IcecrownGlacier,44.14,24.72,-1
.goto IcecrownGlacier,44.17,24.64,-1
>>Click an |cRXP_PICK_Eye of Dominion|r to take control of an |cRXP_FRIENDLY_Eidolon Watcher|r
.complete 13168,1 
.skipgossip
step
#label Parting
.goto IcecrownGlacier,44.06,24.53
>>|cRXP_WARN_Exit the|r |cRXP_FRIENDLY_Eidolon Watcher|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keritose|r
.turnin 13168 >>Turn in Parting Gifts
.accept 13169 >>Accept An Undead's Best Friend
.accept 13170 >>Accept Honor is for the Weak
.accept 13171 >>Accept From Whence They Came
.target Keritose Bloodblade
step
.goto IcecrownGlacier,44.10,24.78,-1
.goto IcecrownGlacier,44.14,24.72,-1
.goto IcecrownGlacier,44.17,24.64,-1
.vehicle >>Click an |cRXP_PICK_Eye of Dominion|r to take control of an |cRXP_FRIENDLY_Eidolon Watcher|r
.skipgossip
.isOnQuest 13171
step
#completewith next
+|cRXP_WARN_If you can't see well because of the ghost effect, copy paste this command into chat then type /reload|r
.link /console ffxDeath 0 >> |cRXP_WARN_CLICK HERE|r
step
.goto IcecrownGlacier,42.05,34.67,20,0
.goto IcecrownGlacier,41.54,35.66,20,0
.goto IcecrownGlacier,40.18,35.50,20,0
.goto IcecrownGlacier,39.78,35.44,20,0
.goto IcecrownGlacier,39.71,35.93,20,0
.goto IcecrownGlacier,39.55,35.93,20,0
.goto IcecrownGlacier,39.84,36.56,15,0
.goto IcecrownGlacier,39.62,36.47,12,0
.goto IcecrownGlacier,39.91,36.97,12,0
.goto IcecrownGlacier,40.00,36.81,12,0
.goto IcecrownGlacier,40.27,38.06,12,0
.goto IcecrownGlacier,39.66,39.00,12,0
.goto IcecrownGlacier,39.57,39.37,12,0
.goto IcecrownGlacier,40.04,40.06,12,0
.goto IcecrownGlacier,39.60,40.14,20,0
.goto IcecrownGlacier,39.26,40.14,12,0
.goto IcecrownGlacier,38.53,40.56,20,0
.goto IcecrownGlacier,40.54,38.90,12,0
.goto IcecrownGlacier,40.65,37.96,20,0
.goto IcecrownGlacier,40.77,37.76,12,0
.goto IcecrownGlacier,41.71,37.53,12,0
.goto IcecrownGlacier,41.13,36.93,12,0
.goto IcecrownGlacier,41.52,36.47,20,0
.goto IcecrownGlacier,41.91,35.95,12,0
.goto IcecrownGlacier,41.54,35.66,20,0
.goto IcecrownGlacier,40.18,35.50,20,0
.loop 20,Icecrown,41.54,35.66,40.18,35.50,40.03,35.28,39.53,35.92,39.88,36.61,39.73,37.05,39.66,39.00,39.60,40.14,38.53,40.56,39.60,40.14,40.65,37.96,41.52,36.47,41.54,35.66
>>|cRXP_WARN_Cast|r |T135736:0|t[Phase Jump] (1) |cRXP_WARN_to move faster and stop falling|r
>>|cRXP_WARN_Cast|r |T237513:0|t[Blood Siphon] (2) |cRXP_WARN_on a nearby enemy to regain Health|r
>>|cRXP_WARN_Cast|r |T132331:0|t[Dephase] (3) |cRXP_WARN_to move faster and drop aggro from enemies|r
>>|cRXP_WARN_Cast|r |T237395:0|t[Feed Hungering Plaguehound] (4) |cRXP_WARN_on |cRXP_ENEMY_Hungering Plaguehounds|r to make them fall asleep. You can walk past them when you get objective credit|r
>>|cRXP_WARN_Cast|r |T132293:0|t[Assassinate Restless Lookout] (5) |cRXP_WARN_to kill|r |cRXP_ENEMY_Restless Lookouts|r
>>|cRXP_WARN_Cast|r |T136213:0|t[Banish Scourge Crystal] (6) |cRXP_WARN_to banish the|r |cRXP_PICK_Scourge Crystals|r
>>|cRXP_WARN_Click an |cRXP_PICK_Eye of Dominion|r to take control of an |cRXP_FRIENDLY_Eidolon Watcher|r again if your |cRXP_FRIENDLY_Eidolon Watcher|r dies|r
.complete 13170,1 
.complete 13169,1 
.complete 13171,1 


.mob Hungering Plaguehound
.mob Restless Lookout
.skipgossip
step
.goto IcecrownGlacier,44.06,24.53
>>|cRXP_WARN_Exit the|r |cRXP_FRIENDLY_Eidolon Watcher|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keritose|r
.turnin 13169 >>Turn in An Undead's Best Friend
.turnin 13170 >>Turn in Honor is for the Weak
.turnin 13171 >>Turn in From Whence They Came
.accept 13172 >>Accept Seeds of Chaos
.accept 13174 >>Accept Amidst the Confusion
.target Keritose Bloodblade
step
#completewith next
.goto IcecrownGlacier,44.06,24.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keritose|r
.vehicle >> Mount the |cRXP_FRIENDLY_Skeletal Assault Gryphon|r
.target Keritose Bloodblade
.skipgossip 30946,1
step
.goto IcecrownGlacier,40.80,35.51,-1
.goto IcecrownGlacier,38.97,39.19,-1
.goto IcecrownGlacier,37.19,41.93,-1
>>|cRXP_WARN_Cast|r |T135826:0|t[Firebomb] (1) |cRXP_WARN_to kill |cRXP_ENEMY_Restless Lookouts|r and|r |cRXP_ENEMY_Risen Laborers|r
.complete 13172,1 
.mob Restless Lookout
.mob Risen Laborer
.skipgossip 30946,1
step
>>Exit the |cRXP_FRIENDLY_Skeletal Assault Gryphon|r
>>Loot the |cRXP_LOOT_Weeping Quarry Schedule|r, |cRXP_LOOT_Weeping Quarry Map|r, |cRXP_LOOT_Weeping Quarry Ledger|r, and |cRXP_LOOT_Weeping Quarry Document|r on the crates
>>|cRXP_ENEMY_Restless Lookouts|r |cRXP_WARN_and |cRXP_ENEMY_Risen Laborers|r will not aggro you|r
.complete 13174,4 
.goto IcecrownGlacier,37.22,41.64
.complete 13174,3 
.goto IcecrownGlacier,38.66,39.41
.complete 13174,2 
.goto IcecrownGlacier,39.16,36.68
.complete 13174,1 
.goto IcecrownGlacier,39.11,33.65
step
.goto IcecrownGlacier,44.06,24.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Keritose|r
.turnin 13172 >>Turn in Seeds of Chaos
.turnin 13174 >>Turn in Amidst the Confusion
.accept 13155 >>Accept Vereth the Cunning
.target Keritose Bloodblade
step
.goto IcecrownGlacier,32.30,42.61,20,0
.goto IcecrownGlacier,32.50,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.turnin 13121 >>Turn in Through the Eye
.accept 13133 >>Accept Find the Ancient Hero
.target The Bone Witch
step
#completewith next
.goto IcecrownGlacier,27.90,47.33,30 >> Enter the Halls of the Ancestors
step
.loop 15,Icecrown,27.45,47.88,27.26,47.66,27.45,47.88,27.65,48.14,27.45,47.88,26.80,49.18,27.02,49.43,26.80,49.18,26.57,49.01,26.80,49.18,26.41,49.94,26.03,49.62,25.27,50.40,25.71,51.13,26.20,51.77,26.65,50.42,26.41,49.94
>>|cRXP_WARN_Talk to |cRXP_FRIENDLY_Slumbering Mjordins|r to wake them. Kill them if it's not |cRXP_ENEMY_Iskalder|r. Do this until you find|r |cRXP_ENEMY_Iskalder|r
.cast 3921 >>|cRXP_WARN_Channel the|r |T135440:0|t[Bone Witch's Amulet] |cRXP_WARN_on|r |cRXP_ENEMY_Iskalder|r
.timer 5,Find the Ancient Hero RP
.mob Slumbering Mjordin
.mob Iskalder
.use 43166
.skipgossip
.isOnQuest 13133
step
.goto IcecrownGlacier,32.30,42.61,20,0
.goto IcecrownGlacier,32.50,42.94
>>|cRXP_WARN_Return to |cRXP_FRIENDLY_The Bone Witch|r with the|r |cRXP_FRIENDLY_Subjugated Iskalder|r
>>|cRXP_WARN_You can fly back on your flying mount|r
.complete 13133,1 
.target The Bone Witch
.skipgossip
.use 43166
step
.goto IcecrownGlacier,32.50,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.turnin 13133 >>Turn in Find the Ancient Hero
.accept 13137 >>Accept Not-So-Honorable Combat
.target The Bone Witch
step
#completewith next
.goto IcecrownGlacier,28.74,51.85
.cast 6477 >>Click the |cRXP_PICK_Battlescar Signal Fire|r to summon |cRXP_ENEMY_Iskalder|r
.timer 5,Not-So-Honorable Combat RP
step
.goto IcecrownGlacier,28.73,52.56
>>Kill |cRXP_ENEMY_Iskalder|r
>>|cRXP_WARN_This quest can be difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 7|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
.complete 13137,1 
.mob Iskalder
.isOnQuest 13137
step
.goto IcecrownGlacier,32.30,42.61,20,0
.goto IcecrownGlacier,32.50,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.turnin 13137 >>Turn in Not-So-Honorable Combat
.accept 13142 >>Accept Banshee's Revenge
.target The Bone Witch
.isQuestComplete 13137
step
.goto IcecrownGlacier,32.50,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.accept 13142 >>Accept Banshee's Revenge
.target The Bone Witch
.isQuestTurnedIn 13137
step
#completewith Smelting
.abandon 13137 >> Abandon Not-So-Honorable Combat
step
#completewith next
.goto IcecrownGlacier,18.24,56.43
.cast 6477 >>Click the |cRXP_PICK_War Horn of Jotunheim|r to summon |cRXP_ENEMY_Overthane Balargarde|r
.timer 47,Banshee's Revenge RP
step
.goto IcecrownGlacier,17.38,55.90
>>|cRXP_WARN_Wait out the RP|r
>>|cRXP_WARN_Damage |cRXP_ENEMY_Overthane Balargarde|r down to 50%|r
>>|cRXP_WARN_Wait out the RP (30 seconds)|r
>>|cRXP_WARN_Kill |cRXP_ENEMY_Overthane Balargarde|r. He is NOT interruptable|r
>>|cRXP_WARN_Run away when |cRXP_ENEMY_Overthane Balargarde|r casts|r |T132369:0|t[Whirlwind]
>>|cRXP_WARN_Move out of |cRXP_ENEMY_Overthane Balargarde|r's|r |T135857:0|t[Blizzard]
>>|cRXP_WARN_Move out of|r |T135836:0|t[Safirdrang's Chill] |cRXP_WARN_that is cast periodically on the ground|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 6|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
.complete 13142,1 
.mob Overthane Balargarde
.isOnQuest 13142
step
.goto IcecrownGlacier,32.30,42.61,20,0
.goto IcecrownGlacier,32.50,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.turnin 13142 >>Turn in Banshee's Revenge
.accept 13213 >>Accept Battle at Valhalas
.target The Bone Witch
.isQuestComplete 13142
step
.goto IcecrownGlacier,32.50,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_The Bone Witch|r
.accept 13213 >>Accept Battle at Valhalas
.target The Bone Witch
.isQuestTurnedIn 13142
step
#completewith Smelting
.abandon 13142 >> Abandon Banshee's Revenge
step
.goto IcecrownGlacier,30.74,28.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Geirrvif|r
.turnin 13213 >>Turn in Battle at Valhalas
.target Geirrvif
step
.goto IcecrownGlacier,30.74,28.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Geirrvif|r
>>|cRXP_WARN_This quest can be difficult. Find a group for them if needed. Skip this step if you're unable to find a group or solo them. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 5|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
>>|cRXP_WARN_Only accept this when your party is ready and on the same quest progression as you (Auto-accept is disabled for this questline)|r
.accept 13214,1 >>Accept Battle at Valhalas: Fallen Heroes
.timer 31,Battle at Valhalas: Fallen Heroes RP
.target Geirrvif
step
.goto IcecrownGlacier,30.84,29.72
>>|cRXP_WARN_Wait out the RP|r
>>|cRXP_WARN_Kill |cRXP_ENEMY_Father Jhadras|r, |cRXP_ENEMY_Rith|r, |cRXP_ENEMY_Masud|r, |cRXP_ENEMY_Talla|r, |cRXP_ENEMY_Eldreth|r, and|r |cRXP_ENEMY_Geness Half-Soul|r
>>|cRXP_WARN_This quest can be difficult. Find a group for them if needed. Skip this step if you're unable to find a group or solo them. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 5|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
.complete 13214,1 
.mob Father Jhadras
.mob Rith
.mob Masud
.mob Talla
.mob Eldreth
.mob Geness Half-Soul
.isOnQuest 13214
step
.goto IcecrownGlacier,31.57,30.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gjonner|r
.turnin 13214 >>Turn in Battle at Valhalas: Fallen Heroes
.target Gjonner the Merciless
.isQuestComplete 13214
step
#completewith Smelting
.abandon 13214 >> Abandon Battle at Valhalas: Fallen Heroes
step
.goto IcecrownGlacier,30.74,28.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Geirrvif|r
>>|cRXP_WARN_This quest can be difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 4|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
>>|cRXP_WARN_Only accept this when your party is ready and on the same quest progression as you (Auto-accept is disabled for this questline)|r
.accept 13215,1 >>Accept Battle at Valhalas: Khit'rix the Dark Master
.timer 27,Battle at Valhalas: Khit'rix the Dark Master RP
.target Geirrvif
.isQuestTurnedIn 13214
step
.goto IcecrownGlacier,31.59,29.81
>>|cRXP_WARN_Wait out the RP|r
>>|cRXP_WARN_Kill |cRXP_ENEMY_Khit'rix the Dark Master|r. He is NOT interruptable|r
>>|cRXP_ENEMY_Khit'rix the Dark Master|r |cRXP_WARN_casts|r |T136184:0|t[Psychic Scream] |cRXP_WARN_(3 second fear) and|r |T136208:0|t[Mind Flay] |cRXP_WARN_(channeled shadow damage)|r
>>|cRXP_WARN_Ignore the |cRXP_ENEMY_Bone Spiders|r when |cRXP_ENEMY_Khit'rix the Dark Master|r casts|r |T136187:0|t[Summon Bone Spiders]
>>|cRXP_WARN_This quest can be difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 4|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
.complete 13215,1 
.mob Khit'rix the Dark Master
.isOnQuest 13215
step
.goto IcecrownGlacier,31.57,30.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gjonner|r
.turnin 13215 >>Turn in Battle at Valhalas: Khit'rix the Dark
.target Gjonner the Merciless
.isQuestComplete 13215
step
#completewith Smelting
.abandon 13215 >> Abandon Battle at Valhalas: Khit'rix the Dark
step
.goto IcecrownGlacier,30.74,28.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Geirrvif|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for her if needed. Skip this step if you're unable to find a group or solo her. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 3|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
>>|cRXP_WARN_Only accept this when your party is ready and on the same quest progression as you (Auto-accept is disabled for this questline)|r
.accept 13216,1 >>Accept Battle at Valhalas: The Return of Sigrid Iceborn
.timer 42,Battle at Valhalas: The Return of Sigrid Iceborn RP
.target Geirrvif
.isQuestTurnedIn 13215
step
.goto IcecrownGlacier,30.47,28.81
>>|cRXP_WARN_Wait out the RP|r
>>|cRXP_WARN_Kill|r |cRXP_ENEMY_Sigrid Iceborn|r
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Sigrid Iceborn|r instantly casts|r |T135848:0|t[Flash Freeze]|cRXP_WARN_, dealing around 5000-6000 damage and stunning for 4 seconds|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for her if needed. Skip this step if you're unable to find a group or solo her. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 3|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
.complete 13216,1 
.mob Sigrid Iceborn
.isOnQuest 13216
step
.goto IcecrownGlacier,31.57,30.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gjonner|r
.turnin 13216 >>Turn in Battle at Valhalas: The Return of Sigrid Iceborn
.target Gjonner the Merciless
.isQuestComplete 13216
step
#completewith Smelting
.abandon 13216 >> Abandon Battle at Valhalas: The Return of Sigrid Iceborn
step
.goto IcecrownGlacier,30.74,28.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Geirrvif|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 2|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
>>|cRXP_WARN_Only accept this when your party is ready and on the same quest progression as you (Auto-accept is disabled for this questline)|r
.accept 13217,1 >>Accept Battle at Valhalas: Carnage!
.timer 43,Battle at Valhalas: Carnage! RP
.target Geirrvif
.isQuestTurnedIn 13216
step
.goto IcecrownGlacier,31.12,30.30
>>|cRXP_WARN_Wait out the RP|r
>>|cRXP_WARN_Kill|r |cRXP_ENEMY_Carnage|r
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Carnage|r instantly casts|r |T132091:0|t[War Stomp]|cRXP_WARN_, dealing around 2500 damage and stunning for 2 seconds|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 2|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
.complete 13217,1 
.mob Carnage
.isOnQuest 13217
step
.goto IcecrownGlacier,31.57,30.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gjonner|r
.turnin 13217 >>Turn in Battle at Valhalas: Carnage!
.target Gjonner the Merciless
.isQuestComplete 13217
step
#completewith Smelting
.abandon 13217 >> Abandon Battle at Valhalas: Carnage!
step
.goto IcecrownGlacier,30.74,28.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Geirrvif|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_from the last quest in the quest chain where you have to kill a 5-man elite|r
>>|cRXP_WARN_Only accept this when your party is ready and on the same quest progression as you (Auto-accept is disabled for this questline)|r
.accept 13218,1 >>Accept Battle at Valhalas: Thane Deathblow
.timer 43,Battle at Valhalas: Thane Deathblow RP
.target Geirrvif
.isQuestTurnedIn 13217
step
.goto IcecrownGlacier,30.94,29.35
>>|cRXP_WARN_Wait out the RP|r
>>|cRXP_WARN_Kill|r |cRXP_ENEMY_Thane Banahogg|r
>>|cRXP_WARN_Run away when |cRXP_ENEMY_Thane Banahogg|r casts|r |T132369:0|t[Whirlwind]
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Thane Banahogg|r instantly casts|r |T132355:0|t[Mortal Strike]|cRXP_WARN_ on his target, reducing healing received by 50% for 5 seconds|r
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Thane Banahogg|r instantly casts|r |T132090:0|t[Execute]|cRXP_WARN_ when the target is at 20% or less health, instantly dealing a LOT of damage|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_from the last quest in the quest chain where you have to kill a 5-man elite|r
.complete 13218,1 
.mob Thane Banahogg
.isOnQuest 13218
step
.goto IcecrownGlacier,31.57,30.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gjonner|r
.turnin 13218 >>Turn in Battle at Valhalas: Thane Deathblow
.target Gjonner the Merciless
.isQuestComplete 13218
step
#completewith Smelting
.abandon 13218 >> Abandon Battle at Valhalas: Thane Deathblow
step
.goto IcecrownGlacier,30.74,28.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Geirrvif|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_from this quest|r
>>|cRXP_WARN_Only accept this when your party is ready and on the same quest progression as you (Auto-accept is disabled for this questline)|r
.accept 13219,1 >>Accept Battle at Valhalas: Final Challenge
.timer 52,Battle at Valhalas: Final Challenge RP
.target Geirrvif
.isQuestTurnedIn 13218
step
.goto IcecrownGlacier,30.95,29.32
>>|cRXP_WARN_Wait out the RP|r
>>|cRXP_WARN_Kill|r |cRXP_ENEMY_Prince Sandoval|r
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Prince Sandoval|r instantly casts|r |T135805:0|t[Engulfing Strike]|cRXP_WARN_ on his target, dealing around 5000 fire damage with an additional 3500 over 9 seconds|r
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Prince Sandoval|r instantly casts|r |T135824:0|t[Fire Nova]|cRXP_WARN_, dealing around 5000 fire damage|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_from this quest|r
.complete 13219,1 
.mob Prince Sandoval
.isOnQuest 13219
step
.goto IcecrownGlacier,31.57,30.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gjonner|r
.turnin 13219 >>Turn in Battle at Valhalas: Final Challenge
.target Gjonner the Merciless
.isQuestComplete 13219
step
#completewith Smelting
.abandon 13219 >> Abandon Battle at Valhalas: Final Challenge
step
#label Smelting
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Olakin|r and |cRXP_FRIENDLY_Arly|r
.turnin 13138 >>Turn in I'm Smelting... Smelting!
.turnin 13140 >>Turn in The Runesmiths of Malykriss
.accept 13211 >>Accept By Fire Be Purged
.goto IcecrownGlacier,35.50,66.44
.accept 13152 >>Accept A Visit to the Doctor
.goto IcecrownGlacier,35.39,66.32
.target Crusader Olakin Sainrith
.target Darkrider Arly
step
#completewith next
.goto IcecrownGlacier,34.45,68.36,15 >> Enter the Sanctum of Reanimation
step
#completewith Patches
>>|cRXP_WARN_Use|r |T135433:0|t[Olakin's Torch] |cRXP_WARN_on|r |cRXP_FRIENDLY_Festering Corpses|r
.complete 13211,1 

.use 43524
step
.goto IcecrownGlacier,35.80,66.99
>>Click the |cRXP_PICK_Metal Stake|r to free |cRXP_FRIENDLY_Patches|r
.complete 13152,1 
.cast 3365
.timer 60, A Visit to the Doctor RP
.target "Patches"
step
#label Patches
.goto IcecrownGlacier,35.84,67.21
>>|cRXP_WARN_Wait out the RP. You can use|r |T135433:0|t[Olakin's Torch] |cRXP_WARN_on |cRXP_FRIENDLY_Festering Corpses|r whilst you wait, but be sure to run back when there's <20 seconds left|r
>>|cRXP_WARN_Stand on top of |cRXP_ENEMY_Doctor Sabnok|r to get credit|r
>>|cRXP_WARN_Click the |cRXP_PICK_Metal Stake|r to free |cRXP_FRIENDLY_Patches|r again if you somehow didn't get credit after the RP|r
.complete 13152,2 
.cast 3365
.timer 60, A Visit to the Doctor RP
.target Doctor Sabnok
step
.goto IcecrownGlacier,36.28,66.75,15,0
.goto IcecrownGlacier,36.63,67.59,15,0
.goto IcecrownGlacier,36.81,68.04,15,0
.goto IcecrownGlacier,36.65,68.08,15,0
.goto IcecrownGlacier,36.03,66.85,15,0
.goto IcecrownGlacier,35.79,66.84,15,0
.goto IcecrownGlacier,36.28,65.04,15,0
.goto IcecrownGlacier,36.73,65.35,15,0
.goto IcecrownGlacier,36.47,65.93,15,0
.goto IcecrownGlacier,35.74,65.91,15,0
.goto IcecrownGlacier,34.66,66.08,15,0
.goto IcecrownGlacier,34.97,66.71,15,0
.goto IcecrownGlacier,35.07,67.49,15,0
.goto IcecrownGlacier,35.63,66.47,15,0
.goto IcecrownGlacier,36.28,66.75
>>|cRXP_WARN_Use|r |T135433:0|t[Olakin's Torch] |cRXP_WARN_on|r |cRXP_FRIENDLY_Festering Corpses|r
.complete 13211,1 
.target Festering Corpse
.use 43524
step << skip
+Take the shortcut by wall jumping on the side of the cave. This is highly optional but will save you about 20s
.link https://www.youtube.com/watch?v=QbvHRC0nIds >> CLICK HERE
step
#completewith next
.goto IcecrownGlacier,34.45,68.36,15 >> Exit the Sanctum of Reanimation
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Olakin|r and |cRXP_FRIENDLY_Arly|r
.turnin 13211 >>Turn in By Fire Be Purged
.goto IcecrownGlacier,35.50,66.44
.turnin 13152 >>Turn in A Visit to the Doctor
.accept 13144 >>Accept Killing Two Scourge With One Skeleton
.goto IcecrownGlacier,35.39,66.32
.target Crusader Olakin Sainrith
.target Darkrider Arly
step
.loop 20,Icecrown,35.36,69.75,35.65,69.99,35.25,70.33,34.00,70.92,32.31,69.66,32.49,69.24,31.75,66.65,31.54,66.12,31.85,66.03,32.99,66.96,33.42,67.69,33.80,67.94,33.99,68.32,34.13,68.60,35.36,69.75
.cast 3365 >> |cRXP_WARN_Loot a |cRXP_PICK_Grasping Arm|r on the ground to summon a|r |cRXP_FRIENDLY_Burning Skeleton|r
>>|cRXP_WARN_You may only summon one |cRXP_FRIENDLY_Burning Skeleton|r at a time|r
.isOnQuest 13144
step
.loop 20,Icecrown,32.70,70.83,32.06,71.30,31.58,71.17,31.04,70.26,31.02,69.55,31.23,68.90
>>|cRXP_WARN_Fly next to a |cRXP_ENEMY_Chained Abomination|r whilst you have a |cRXP_FRIENDLY_Burning Skeleton|r summoned to burn it|r
>>|cRXP_WARN_Do NOT attack the|r |cRXP_ENEMY_Chained Abomination|r
.complete 13144,1,1 
.mob Chained Abomination
step
.loop 20,Icecrown,35.36,69.75,35.65,69.99,35.25,70.33,34.00,70.92,32.31,69.66,32.49,69.24,31.75,66.65,31.54,66.12,31.85,66.03,32.99,66.96,33.42,67.69,33.80,67.94,33.99,68.32,34.13,68.60,35.36,69.75
.cast 3365 >> |cRXP_WARN_Loot a |cRXP_PICK_Grasping Arm|r on the ground to summon a|r |cRXP_FRIENDLY_Burning Skeleton|r
>>|cRXP_WARN_You may only summon one |cRXP_FRIENDLY_Burning Skeleton|r at a time|r
.isOnQuest 13144
step
.loop 20,Icecrown,32.70,70.83,32.06,71.30,31.58,71.17,31.04,70.26,31.02,69.55,31.23,68.90
>>|cRXP_WARN_Fly next to a |cRXP_ENEMY_Chained Abomination|r whilst you have a |cRXP_FRIENDLY_Burning Skeleton|r summoned to burn it|r
>>|cRXP_WARN_Do NOT attack the|r |cRXP_ENEMY_Chained Abomination|r
.complete 13144,1,2 
.mob Chained Abomination
step
.loop 20,Icecrown,35.36,69.75,35.65,69.99,35.25,70.33,34.00,70.92,32.31,69.66,32.49,69.24,31.75,66.65,31.54,66.12,31.85,66.03,32.99,66.96,33.42,67.69,33.80,67.94,33.99,68.32,34.13,68.60,35.36,69.75
.cast 3365 >> |cRXP_WARN_Loot a |cRXP_PICK_Grasping Arm|r on the ground to summon a|r |cRXP_FRIENDLY_Burning Skeleton|r
>>|cRXP_WARN_You may only summon one |cRXP_FRIENDLY_Burning Skeleton|r at a time|r
.isOnQuest 13144
step
.loop 20,Icecrown,32.70,70.83,32.06,71.30,31.58,71.17,31.04,70.26,31.02,69.55,31.23,68.90
>>|cRXP_WARN_Fly next to a |cRXP_ENEMY_Chained Abomination|r whilst you have a |cRXP_FRIENDLY_Burning Skeleton|r summoned to burn it|r
>>|cRXP_WARN_Do NOT attack the|r |cRXP_ENEMY_Chained Abomination|r
.complete 13144,1 
.mob Chained Abomination
step
.goto IcecrownGlacier,35.39,66.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arly|r
.turnin 13144 >>Turn in Killing Two Scourge With One Skeleton
.accept 13212 >>Accept He's Gone to Pieces
.target Darkrider Arly
step
.goto IcecrownGlacier,33.88,68.27,45,0
.goto IcecrownGlacier,34.01,68.83,45,0
.goto IcecrownGlacier,33.78,69.58,45,0
.goto IcecrownGlacier,34.26,69.35,45,0
.goto IcecrownGlacier,35.87,70.29,45,0
.goto IcecrownGlacier,35.12,72.00,45,0
.goto IcecrownGlacier,35.50,72.08,45,0
.goto IcecrownGlacier,36.80,71.30,45,0
.goto IcecrownGlacier,37.31,71.14,45,0
.goto IcecrownGlacier,37.64,71.10,45,0
.goto IcecrownGlacier,37.66,70.47,45,0
.goto IcecrownGlacier,32.96,70.29,45,0
.goto IcecrownGlacier,31.99,70.57,45,0
.goto IcecrownGlacier,31.79,68.79
>>Kill |cRXP_ENEMY_Corpulent Horrors|r. Loot them for |cRXP_LOOT_Olakin's Torso|r, |cRXP_LOOT_Olakin's Legs|r, |cRXP_LOOT_Olakin's Left Arm|r, and |cRXP_LOOT_Olakin's Right Arm|r
.complete 13212,1 
.complete 13212,2 
.complete 13212,3 
.complete 13212,4 
.mob Corpulent Horror
step
.goto IcecrownGlacier,35.39,66.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arly|r
.turnin 13212 >>Turn in He's Gone to Pieces
.accept 13220 >>Accept Putting Olakin Back Together Again
.target Darkrider Arly
step
#completewith next
.goto IcecrownGlacier,34.45,68.36,15 >> Enter the Sanctum of Reanimation
step
.goto IcecrownGlacier,35.20,67.20,20,0
.goto IcecrownGlacier,34.95,66.34,12,0
.goto IcecrownGlacier,34.69,65.98
>>Loot the |cRXP_LOOT_Spool of Thread|r on the table
.collect 43567,1,13220,1 
step
.goto IcecrownGlacier,36.61,67.58
>>Loot |cRXP_LOOT_The Doctor's Cleaver|r on top of the operating table
.collect 43568,1,13220,1 
step
#completewith next
+|cRXP_WARN_Take the shortcut by wall jumping on the side of the cave. This is highly optional but will save you about 20 seconds|r
.link https://www.youtube.com/watch?v=QbvHRC0nIds >> |cRXP_WARN_CLICK HERE|r
step
.goto IcecrownGlacier,35.61,66.75
>>Go back upstairs
.cast 58856 >>Use |T133640:0|t[Crusader Olakin's Remains] on the skull slab
.timer 25,Putting Olakin Back Together Again RP
.use 43564
.isOnQuest 13220
step << skip
.goto IcecrownGlacier,34.41,68.42
>>|cRXP_WARN_Edge your way outside until you can get onto your flying mount|r
>>|cRXP_WARN_Do NOT go out of range|r
>>|cRXP_WARN_Wait out the RP|r
.complete 13220,1 
.use 43564
step
.goto IcecrownGlacier,34.41,68.42,10,0
.goto IcecrownGlacier,35.39,66.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arly|r
.turnin 13220 >>Turn in Putting Olakin Back Together Again
.accept 13235 >>Accept The Flesh Giant Champion
.target Darkrider Arly
step
.goto IcecrownGlacier,29.75,61.26
.gossipoption 94275 >>Talk to |cRXP_FRIENDLY_Margrave|r
.timer 38,The Flesh Giant Champion RP
.target Margrave Dhakar
.isOnQuest 13235
step
.goto IcecrownGlacier,29.67,61.55
>>|cRXP_WARN_Wait out the RP|r
>>Kill |cRXP_ENEMY_Morbidus|r
.complete 13235,1 
.mob Morbidus
.skipgossip
step
.goto IcecrownGlacier,35.39,66.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Arly|r
.turnin 13235 >>Turn in The Flesh Giant Champion
.target Darkrider Arly
step
.goto IcecrownGlacier,54.15,71.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vereth|r
.turnin 13155 >>Turn in Vereth the Cunning
.accept 13143 >>Accept New Recruit
.target Vereth the Cunning
step
.goto Icecrown,55.48,71.54,40,0
.goto Icecrown,55.76,74.00
>>Fly up to the platform above the wall
>>|cRXP_WARN_Attack a |cRXP_ENEMY_Lithe Stalker|r carefully down to 40% or less health|r
.cast 58151 >>|cRXP_WARN_Use the|r |T135309:0|t[Sigil of the Ebon Blade] |cRXP_WARN_to subdue a|r |cRXP_ENEMY_Lithe Stalker|r
.mob Lithe Stalker
.use 43315
.isOnQuest 13143
step
.goto IcecrownGlacier,55.21,70.76
>>|cRXP_WARN_Wait at the cliff with the |cRXP_ENEMY_Lithe Stalker|r until the objective completes|r
.complete 13143,1 
.use 43315
step
.goto IcecrownGlacier,54.15,71.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vereth|r
.turnin 13143 >>Turn in New Recruit
.accept 13145 >>Accept The Vile Hold
.target Vereth the Cunning
step
.goto IcecrownGlacier,58.07,70.63
>>Fly toward the |cRXP_PICK_Blood Forge|r
.complete 13145,2 
step
.goto IcecrownGlacier,60.43,68.74,30,0
.goto IcecrownGlacier,60.82,68.71
>>Fly toward the |cRXP_PICK_Icy Lookout|r
.complete 13145,3 
step
.goto IcecrownGlacier,58.93,74.65
>>Fly toward the |cRXP_PICK_Runeworks|r
.complete 13145,4 
step
.goto IcecrownGlacier,56.18,80.09
>>Fly toward the |cRXP_PICK_Altar of Sacrifice|r
.complete 13145,1 
step
.goto IcecrownGlacier,54.15,71.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vereth|r
.turnin 13145 >>Turn in The Vile Hold
.accept 13146 >>Accept Generosity Abounds
.accept 13147 >>Accept Matchmaker
.accept 13160 >>Accept Stunning View
.target Vereth the Cunning
step
#completewith next
.goto Icecrown,54.26,70.61
.vehicle 30895 >>Click the |cRXP_PICK_Eye of Dominion|r to take control of an |cRXP_FRIENDLY_Lithe Stalker|r
.skipgossip
step
.waypoint Icecrown,57.94,73.79,0,ironchain,UNIT_AURA
.goto Icecrown,58.46,72.80,4,0
.goto Icecrown,58.29,71.64,4,0
.goto Icecrown,57.90,71.65,4,0
.loop 6,Icecrown,58.46,72.80,58.29,71.64,57.90,71.65,58.46,72.80
>>|cRXP_WARN_Cast|r |T236171:0|t[Leap] (1) |cRXP_WARN_to move faster and jump up mountains|r
>>|cRXP_WARN_Cast|r |T133273:0|t[Iron Chain] (2) |cRXP_WARN_to pick up a |cRXP_FRIENDLY_Scourge Bomb|r. This has a 20 yard range|r
>>|cRXP_WARN_Move the |cRXP_FRIENDLY_Scourge Bomb|r toward|r |cRXP_FRIENDLY_Lumbering Atrocities|r
.complete 13146,1 
.target Lumbering Atrocity
.target Scourge Bomb
step
.loop 30,Icecrown,58.41,74.55,58.50,73.80,58.65,73.20,59.02,73.22,59.41,73.26,59.70,73.42,59.57,73.74,59.71,73.88,59.52,74.28,59.04,74.33,59.41,73.26,59.04,74.33,58.41,74.55
>>|cRXP_WARN_Cast|r |T236171:0|t[Leap] (1) |cRXP_WARN_to move faster and jump up mountains|r
>>|cRXP_WARN_Cast|r |T135236:0|t[Throw Rock] (4) |cRXP_WARN_on |cRXP_FRIENDLY_Umbral Brutes|r to start fights|r
.complete 13147,1 
.mob Umbral Brute
step
.loop 40,Icecrown,58.21,77.01,58.82,76.05,60.44,77.05,60.73,75.76,60.18,74.96,60.89,73.56,60.38,71.71,60.07,70.65
>>|cRXP_WARN_Cast|r |T236171:0|t[Leap] (1) |cRXP_WARN_to move faster and jump up mountains|r
>>|cRXP_WARN_Cast|r |T236306:0|t[Heave] (3) |cRXP_WARN_on |cRXP_FRIENDLY_Iceskin Sentries|r to destroy them|r
.complete 13160,1 
.mob Iceskin Sentry
step
.goto IcecrownGlacier,54.15,71.18
>>Exit the |cRXP_FRIENDLY_Lithe Stalker|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vereth|r
.turnin 13146 >>Turn in Generosity Abounds
.turnin 13147 >>Turn in Matchmaker
.turnin 13160 >>Turn in Stunning View
.accept 13161 >>Accept The Rider of the Unholy
.accept 13162 >>Accept The Rider of Frost
.accept 13163 >>Accept The Rider of Blood
.target Vereth the Cunning
step
.goto IcecrownGlacier,61.89,68.58
>>Fly to the Malykriss Balcony
>>Kill |cRXP_ENEMY_Sapph|r
>>|cRXP_ENEMY_Sapph|r |cRXP_WARN_instantly casts|r |T135834:0|t[Hungering Cold]|cRXP_WARN_, (melee AoE stun for 6 seconds. Breaks when you take damage)|r
>>|cRXP_WARN_This quest can be difficult. Find a group for her if needed. Skip this step if you're unable to find a group or solo her. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_from the last quest in the quest chain where you have to kill a 5-man elite|r
.complete 13162,1 
.mob Sapph
step
.goto IcecrownGlacier,59.29,72.19,30,0
.goto IcecrownGlacier,59.16,71.50
>>|cRXP_WARN_Kill |cRXP_ENEMY_Baelok|r. He is NOT interruptable|r
>>|cRXP_ENEMY_Baelok|r |cRXP_WARN_casts|r |T136131:0|t[Draw Soul]|cRXP_WARN_, dealing 4500-5500 lifesteal damage|r
>>|cRXP_WARN_This quest can be difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_from the last quest in the quest chain where you have to kill a 5-man elite|r
.complete 13163,1 
.mob Baelok
.mob
step
.goto IcecrownGlacier,55.99,80.30,15,0
.goto IcecrownGlacier,56.18,80.29,15,0
.goto IcecrownGlacier,56.40,80.22,15,0
.goto IcecrownGlacier,56.30,79.82,15,0
.goto IcecrownGlacier,56.02,80.18,15,0
.goto IcecrownGlacier,55.99,80.30
>>|cRXP_WARN_Kill |cRXP_ENEMY_Rokir|r. He is NOT interruptable|r
>>|cRXP_WARN_Move out of |cRXP_ENEMY_Rokir|r's|r |T136144:0|t[Death and Decay]
>>|cRXP_WARN_Kite |cRXP_ENEMY_Rokir|r away from the |cRXP_ENEMY_Shambling Zombies|r that spawn after |cRXP_ENEMY_Rokir|r casts|r |T237511:0|t[Zombie Horde]
>>|cRXP_ENEMY_Shambling Zombies|r |cRXP_WARN_cast|r |T136030:0|t[Plague Blast]|cRXP_WARN_ when within 10 yards of the target, dealing about 1500 damage with an additional 4000 over 12 seconds, killing the|r |cRXP_ENEMY_Shambling Zombie|r |cRXP_WARN_(this no longer gives experience)|r
>>|cRXP_WARN_This quest can be difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 5|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_for this quest, and 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_from the last quest in the quest chain where you have to kill a 5-man elite|r
.complete 13161,1 
.mob Rokir
step
.goto IcecrownGlacier,54.15,71.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vereth|r
.turnin 13161 >>Turn in The Rider of the Unholy
.turnin 13162 >>Turn in The Rider of Frost
.turnin 13163 >>Turn in The Rider of Blood
.accept 13164 >>Accept The Fate of Bloodbane
.target Vereth the Cunning
.isQuestComplete 13161
.isQuestComplete 13162
.isQuestComplete 13163
step
.goto IcecrownGlacier,54.15,71.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vereth|r
.turnin 13161 >>Turn in The Rider of the Unholy
.turnin 13162 >>Turn in The Rider of Frost
.target Vereth the Cunning
.isQuestComplete 13161
.isQuestComplete 13162
step
.goto IcecrownGlacier,54.15,71.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vereth|r
.turnin 13161 >>Turn in The Rider of the Unholy
.turnin 13163 >>Turn in The Rider of Blood
.target Vereth the Cunning
.isQuestComplete 13161
.isQuestComplete 13163
step
.goto IcecrownGlacier,54.15,71.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vereth|r
.turnin 13162 >>Turn in The Rider of Frost
.turnin 13163 >>Turn in The Rider of Blood
.target Vereth the Cunning
.isQuestComplete 13162
.isQuestComplete 13163
step
.goto IcecrownGlacier,54.15,71.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vereth|r
.turnin 13161 >>Turn in The Rider of the Unholy
.target Vereth the Cunning
.isQuestComplete 13161
step
.goto IcecrownGlacier,54.15,71.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vereth|r
.turnin 13162 >>Turn in The Rider of Frost
.target Vereth the Cunning
.isQuestComplete 13162
step
.goto IcecrownGlacier,54.15,71.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vereth|r
.turnin 13163 >>Turn in The Rider of Blood
.target Vereth the Cunning
.isQuestComplete 13163
step
.goto IcecrownGlacier,54.15,71.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vereth|r
.accept 13164 >>Accept The Fate of Bloodbane
.target Vereth the Cunning
.isQuestTurnedIn 13161
.isQuestTurnedIn 13162
.isQuestTurnedIn 13163
step
#completewith LightWithin
.abandon 13161 >>Abandon The Rider of the Unholy
.abandon 13162 >>Abandon The Rider of Frost
.abandon 13163 >>Abandon The Rider of Blood
step
.goto IcecrownGlacier,54.66,83.71,90,0
.goto IcecrownGlacier,54.44,86.13
>>Fly down below Icecrown Citadel
>>Kill |cRXP_ENEMY_Orbaz Bloodbane|r
>>|cRXP_WARN_At 40% or less health, |cRXP_FRIENDLY_Darion|r will spawn and start attacking |cRXP_ENEMY_Orbaz Bloodbane|r. If you die when this happens, simply fly back to your corpse and finish killing|r |cRXP_ENEMY_Orbaz Bloodbane|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_from this quest|r
.complete 13164,1 
.mob Orbaz Bloodbane
.isOnQuest 13164

step
.goto IcecrownGlacier,54.15,71.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Vereth|r
.turnin 13164 >>Turn in The Fate of Bloodbane
.target Vereth the Cunning
.isQuestComplete 13164
step
#completewith Coprous
.goto IcecrownGlacier,63,09,62.31,40 >>Enter Mord'rethar
step
.goto IcecrownGlacier,62.26,63.37
>>|cRXP_WARN_===YOU ARE UNABLE TO SOLO THIS QUEST===|r
>>|cRXP_WARN_Channel the|r |T134816:0|t[Pustulant Spinal Fluid] |cRXP_WARN_at a Cauldron|r
>>|cRXP_WARN_Kill |cRXP_ENEMY_Rampaging Ghouls|r and |cRXP_ENEMY_Living Plague|r when they spawn|r
>>|cRXP_WARN_When prompted to "Add Fluid Soon" or "Add fluid NOW!!", you or your fellow party member must channel the|r |T134816:0|t[Pustulant Spinal Fluid] |cRXP_WARN_at the Cauldron again|r
>>|cRXP_WARN_If prompted that the "Neutralizing agent FAILED!", channel the|r |T134816:0|t[Pustulant Spinal Fluid] |cRXP_WARN_to start the event again|r
>>|cRXP_WARN_Find a group for this quest. Skip this step if you're unable to find a group. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_from this quest|r
.complete 13295,1 << Alliance 
.complete 13279,1 << Horde 
.mob Living Plague
.mob Rampaging Ghoul
.mob Plague Drenched Ghoul
.cast 59655
.timer 90,Pustulant Spinal Fluid Cooldown
.use 44010
.isOnQuest 13295 << Alliance
.isOnQuest 13279 << Horde

step
#label Coprous
.goto IcecrownGlacier,60.74,62.16
>>Kill |cRXP_ENEMY_Coprous the Defiled|r
>>|cRXP_WARN_Run away when |cRXP_ENEMY_Coprous the Defiled|r casts|r |T135793:0|t[Acid Geyser]
>>|cRXP_WARN_This quest can be difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_from this quest|r
.complete 13298,1 << Alliance 
.complete 13278,1 << Horde 
.isOnQuest 13298 << Alliance
.isOnQuest 13278 << Horde
.mob Coprous the Defiled

step
.loop 50,Icecrown,64.82,56.06,64.30,55.12,63.77,53.91,63.74,52.14,63.91,50.19,65.24,51.18,65.75,51.28,67.65,50.23,67.30,52.74,68.32,53.02,68.69,56.24,66.79,56.01,64.82,56.06
>>Kill |cRXP_ENEMY_Scavenging Geists|r. Loot them for their |cRXP_LOOT_Demolisher Parts|r
.complete 13393,1 << Alliance 
.complete 13304,1 << Horde 
.mob Scavenging Geist
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Wrecked Demolisher|r and |cRXP_FRIENDLY_Matthias|r
.turnin 13393 >>Turn in Field Repairs << Alliance
.turnin 13304 >>Turn in Field Repairs << Horde
.goto Icecrown,68.04,51.81
.accept 13394 >>Accept Do Your Worst << Alliance
.accept 13305 >>Accept Do Your Worst << Horde
.goto Icecrown,68.02,51.59

.target Matthias Lehner
step
#completewith next
.goto IcecrownGlacier,68.04,51.83
.vehicle 31830 >> Get into the |cRXP_FRIENDLY_Refurbished Demolisher|r
.target Refurbished Demolisher
step
.goto IcecrownGlacier,68.04,51.83,0
.goto IcecrownGlacier,65.88,50.70,25,0
.loop 60,Icecrown,65.63,48.57,67.19,47.51,66.67,46.42,66.95,44.62,66.13,42.35,64.86,41.51,63.65,41.05,62.47,40.70,61.77,42.35,62.60,43.86,63.22,45.99,64.01,48.86,65.63,48.57
>>Kill |cRXP_ENEMY_Decomposed Ghouls|r, |cRXP_ENEMY_Frostskull Maguses|r, and |cRXP_ENEMY_Bone Giants|r
>>|cRXP_WARN_Cast|r |T135812:0|t[Hurl Boulder] (1) |cRXP_WARN_to deal damage at range|r
>>|cRXP_WARN_Cast|r |T252173:0|t[Ram] (2) |cRXP_WARN_to deal damage in melee|r
>>|cRXP_WARN_Cast|r |T136106:0|t[Double Speed] (3) |cRXP_WARN_to move faster|r
>>|cRXP_WARN_Get into a new |cRXP_FRIENDLY_Refurbished Demolisher|r if yours dies|r
.complete 13394,1 << Alliance 
.complete 13305,1 << Horde 
.complete 13394,2 << Alliance 
.complete 13305,2 << Horde 
.complete 13394,3 << Alliance 
.complete 13305,3 << Horde 
.mob Decomposed Ghoul
.mob Frostskull Magus
.mob Bone Giant
step
.goto IcecrownGlacier,64.52,43.99
>>|cRXP_WARN_Exit the |cRXP_FRIENDLY_Refurbished Demolisher|r out of combat|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Matthias|r
.turnin 13394 >>Turn in Do Your Worst << Alliance
.accept 13395 >>Accept Army of the Damned << Alliance
.turnin 13305 >>Turn in Do Your Worst << Horde
.accept 13236 >>Accept Army of the Damned << Horde
.target Matthias Lehner
step
.loop 30,Icecrown,64.93,43.92,65.23,44.42,65.84,43.97,65.20,43.41,64.93,43.92
>>Kill |cRXP_ENEMY_Lordaeron Footsoldiers|r and |cRXP_ENEMY_Lordaeron Captains|r
>>|cRXP_WARN_Cast|r |T237559:0|t[Deathstorm] (1) |cRXP_WARN_to kill 12 enemies at once|r
>>|cRXP_WARN_Cast|r |T135732:0|t[Soul Cleave] (2) |cRXP_WARN_to kill 3 enemies in a melee cleave and regain Mana|r
>>|cRXP_WARN_Cast|r |T136187:0|t[Gift of the Lich King] (3) |cRXP_WARN_to raise dead|r |cRXP_ENEMY_Lordaeron Footsoldiers|r
>>|cRXP_WARN_Cast|r |T136190:0|t[Consume Minions] (4) |cRXP_WARN_to regain Health and Mana|r
.complete 13395,1 << Alliance 
.complete 13236,1 << Horde 
.mob Lordaeron Footsoldier
step
.goto IcecrownGlacier,64.52,43.99
>>|cRXP_WARN_Exit the|r |cRXP_FRIENDLY_The Prodigal Leader|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Matthias|r
.turnin 13395 >>Turn in Army of the Damned << Alliance
.accept 13396 >>Accept Futility << Alliance
.turnin 13236 >>Turn in Army of the Damned << Horde
.accept 13348 >>Accept Futility << Horde
.target Matthias Lehner
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13295 >>Turn in Basic Chemistry
.turnin 13298 >>Turn in Coprous the Defiled
.turnin 13315 >>Turn in Sneak Preview
.accept 13318 >>Accept Drag and Drop
.turnin 13396 >>Turn in Futility



.target Thassarian
.isQuestComplete 13295
.isQuestComplete 13298
.isQuestComplete 13315
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13295 >>Turn in Basic Chemistry
.turnin 13298 >>Turn in Coprous the Defiled
.turnin 13396 >>Turn in Futility



.target Thassarian
.isQuestComplete 13295
.isQuestComplete 13298
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13295 >>Turn in Basic Chemistry
.turnin 13315 >>Turn in Sneak Preview
.accept 13318 >>Accept Drag and Drop
.turnin 13396 >>Turn in Futility



.target Thassarian
.isQuestComplete 13295
.isQuestComplete 13315
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13298 >>Turn in Coprous the Defiled
.turnin 13315 >>Turn in Sneak Preview
.accept 13318 >>Accept Drag and Drop
.turnin 13396 >>Turn in Futility



.target Thassarian
.isQuestComplete 13298
.isQuestComplete 13315
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13298 >>Turn in Coprous the Defiled
.turnin 13396 >>Turn in Futility



.target Thassarian
.isQuestComplete 13298
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13295 >>Turn in Basic Chemistry
.turnin 13396 >>Turn in Futility



.target Thassarian
.isQuestComplete 13295
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13315 >>Turn in Sneak Preview
.accept 13318 >>Accept Drag and Drop
.turnin 13396 >>Turn in Futility



.target Thassarian
.isQuestComplete 13315
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.accept 13318 >>Accept Drag and Drop
.turnin 13396 >>Turn in Futility



.target Thassarian
.isQuestTurnedIn 13315
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13396 >>Turn in Futility



.target Thassarian
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13278 >>Turn in Coprous the Defiled
.turnin 13279 >>Turn in Basic Chemistry
.turnin 13351 >>Turn in Sneak Preview
.accept 13352 >>Accept Drag and Drop


.turnin 13348 >>Turn in Futility

.target Koltira Deathweaver
.isQuestComplete 13278
.isQuestComplete 13279
.isQuestComplete 13351
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13278 >>Turn in Coprous the Defiled
.turnin 13279 >>Turn in Basic Chemistry


.turnin 13348 >>Turn in Futility

.target Koltira Deathweaver
.isQuestComplete 13278
.isQuestComplete 13279
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13279 >>Turn in Basic Chemistry
.turnin 13351 >>Turn in Sneak Preview
.accept 13352 >>Accept Drag and Drop


.turnin 13348 >>Turn in Futility

.target Koltira Deathweaver
.isQuestComplete 13279
.isQuestComplete 13351
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13278 >>Turn in Coprous the Defiled
.turnin 13351 >>Turn in Sneak Preview
.accept 13352 >>Accept Drag and Drop


.turnin 13348 >>Turn in Futility

.target Koltira Deathweaver
.isQuestComplete 13278
.isQuestComplete 13351
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13278 >>Turn in Coprous the Defiled


.turnin 13348 >>Turn in Futility

.target Koltira Deathweaver
.isQuestComplete 13278
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13279 >>Turn in Basic Chemistry


.turnin 13348 >>Turn in Futility

.target Koltira Deathweaver
.isQuestComplete 13279
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13351 >>Turn in Sneak Preview
.accept 13352 >>Accept Drag and Drop


.turnin 13348 >>Turn in Futility

.target Koltira Deathweaver
.isQuestComplete 13351
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.accept 13352 >>Accept Drag and Drop


.turnin 13348 >>Turn in Futility

.target Koltira Deathweaver
.isQuestTurnedIn 13351
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r


.turnin 13348 >>Turn in Futility

.target Koltira Deathweaver
step << Horde
#completewith LightWithin
.abandon 13278 >>Abandon Coprous the Defiled
.abandon 13279 >>Abandon Basic Chemistry
.abandon 13351 >>Abandon Sneak Preview
step << skip
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Chief Engineer Copperclaw|r on the lower deck.
.target Chief Engineer Copperclaw
.accept 13379 >>Accept Green Technology
step << skip
#completewith next
>>Fly up to the platform above the wall
>>Kill |cRXP_ENEMY_Bitter Initiates|r. Loot them for their |T134337:0|t[|cRXP_LOOT_Orbs of Illusion|r]
>>|cRXP_WARN_Use the|r |T134337:0|t[|cRXP_LOOT_Orbs of Illusion|r] |cRXP_WARN_on |cRXP_ENEMY_Dark Subjugators|r out of combat|r
.collect 44246,3,13318,1,-1 << Alliance 
.collect 44246,3,13352,1,-1 << Horde 
.complete 13318,1 << Alliance 
.complete 13352,1 << Horde 
.mob Bitter Initiate
.mob Dark Subjugator
.use 44246
.isOnQuest 13318 << Alliance
.isOnQuest 13352 << Horde
step << skip
.goto IcecrownGlacier,53.89,46.83
>>Kill |cRXP_ENEMY_Overseer Faedris|r in the big tent
.complete 13319,1 << Alliance 
.complete 13354,1 << Horde 
.mob Overseer Faedris
step
.loop 50,Icecrown,52.44,48.09,52.32,47.54,52.68,46.51,52.22,45.67,53.12,45.55,53.75,45.81,53.95,45.49,54.56,45.02,54.81,45.55,55.02,45.83,55.21,46.63,54.46,46.46,54.10,46.68,53.62,46.85,53.27,47.25,52.98,47.43,52.44,48.09
>>Kill |cRXP_ENEMY_Bitter Initiates|r. Loot them for their |T134337:0|t[|cRXP_LOOT_Orbs of Illusion|r]
>>|cRXP_WARN_Use the|r |T134337:0|t[|cRXP_LOOT_Orbs of Illusion|r] |cRXP_WARN_on |cRXP_ENEMY_Dark Subjugators|r out of combat|r
.collect 44246,3,13318,1,-1 << Alliance 
.collect 44246,3,13352,1,-1 << Horde 
.complete 13318,1,2 << Alliance 
.complete 13352,1,2 << Horde 
.mob Bitter Initiate
.mob Dark Subjugator
.use 44246
.isOnQuest 13318 << Alliance
.isOnQuest 13352 << Horde
step
.loop 50,Icecrown,52.44,48.09,52.32,47.54,52.68,46.51,52.22,45.67,53.12,45.55,53.75,45.81,53.95,45.49,54.56,45.02,54.81,45.55,55.02,45.83,55.21,46.63,54.46,46.46,54.10,46.68,53.62,46.85,53.27,47.25,52.98,47.43,52.44,48.09
>>Kill |cRXP_ENEMY_Bitter Initiates|r. Loot them for their |T134337:0|t[|cRXP_LOOT_Orbs of Illusion|r]
.collect 44246,3,13318,1,-1 << Alliance 
.collect 44246,3,13352,1,-1 << Horde 
.cast 5513 >>|cRXP_WARN_Use the|r |T134337:0|t[|cRXP_LOOT_Orbs of Illusion|r] |cRXP_WARN_on |cRXP_ENEMY_Dark Subjugators|r out of combat|r


.mob Bitter Initiate
.mob Dark Subjugator
.use 44246
.isOnQuest 13318 << Alliance
.isOnQuest 13352 << Horde
step
#completewith DragonsFell
.destroy 44246 >> Destroy the |T134337:0|t[|cRXP_LOOT_Orbs of Illusion|r] in your bags, as they're no longer needed
step << skip
>>Fly up to the platform above the wall
>>|cRXP_WARN_Use the|r |T134722:0|t[Partitioned Flask] |cRXP_WARN_on the Cauldrons|r
>>|cRXP_WARN_Using the|r |T134722:0|t[Partitioned Flask] |cRXP_WARN_dismounts you|r
.complete 13320,3 << Alliance 
.complete 13355,3 << Horde 
.goto IcecrownGlacier,49.66,34.37,-1
.complete 13320,2 << Alliance 
.complete 13355,2 << Horde 
.goto IcecrownGlacier,49.07,34.18,-1
.complete 13320,1 << Alliance 
.complete 13355,1 << Horde 
.goto IcecrownGlacier,48.95,33.20,-1
.use 44251
step << skip
.goto IcecrownGlacier,49.40,31.19
>>Kill |cRXP_ENEMY_Overseer Savryn|r
.complete 13319,4 << Alliance 
.complete 13354,4 << Horde 
.mob Overseer Savryn
step << skip
.goto IcecrownGlacier,54.72,32.62
>>Kill |cRXP_ENEMY_Overseer Jhaeqon|r
.complete 13319,2 << Alliance 
.complete 13354,2 << Horde 
.mob Overseer Jhaeqon
step << skip
.goto IcecrownGlacier,53.68,29.20
>>Fly up a level to the next platform
>>Kill |cRXP_ENEMY_Overseer Veraj|r
.complete 13319,3 << Alliance 
.complete 13354,3 << Horde 
.mob Overseer Veraj
step << skip
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly to the small platform in the air, then talk to |cRXP_FRIENDLY_Kibli Killohertz|r
.target Kibli Killohertz
.goto IcecrownGlacier,53.96,42.93
.turnin 13383 >>Turn in Killohertz
.accept 13380 >>Accept Leading the Charge

step << skip
.goto IcecrownGlacier,53.96,43.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karen No|r to get on a bomber. Use Charge Shield (1) to gain 100 shields then switch to Bomber Bay (5) and begin bombing scourge below until all Infantry and Captains are slain. Switch to Anti-Air Turret (4) and begin using Anti-Air Rockets (1) to shoot Gargoyles in the air. Once completing press the Leave Vehicle button and you will be returned to the platform
.target Karen No
.complete 13380,1 
.complete 13380,2 
.complete 13380,3 
.skipgossip

step << skip
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Kibli Killohertz|r
.target Kibli Killohertz
.goto IcecrownGlacier,53.96,42.93
.turnin 13380 >>Turn in Leading the Charge

step << skip
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly to the small platform in the air, then talk to |cRXP_FRIENDLY_Fringe Engineer Tezzla|r
.target Fringe Engineer Tezzla
.goto IcecrownGlacier,53.99,36.87
.turnin 13379 >>Turn in Green Technology
.accept 13373 >>Accept Fringe Science Benefits

step << skip
.goto IcecrownGlacier,54.00,36.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rizzy Ratchwiggle|r to get on a bomber. Use Charge Shield (1) to gain 100 shields then switch to Bomber Bay (5) and begin bombing scourge below until all Infantry and Captains are slain. Switch to Anti-Air Turret (4) and begin using Anti-Air Rockets (1) to shoot Gargoyles in the air. Once completing press the Leave Vehicle button and you will be returned to the platform
.target Rizzy Ratchwiggle
.complete 13373,1 
.complete 13373,2 
.complete 13373,3 
.skipgossip

step << skip
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Fringe Engineer Tezzla|r
.target Fringe Engineer Tezzla
.goto IcecrownGlacier,54.00,36.94
.turnin 13373 >>Turn in Fringe Science Benefits

step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13318 >>Turn in Drag and Drop


.accept 13345 >>Accept Need More Info
.target Thassarian
.isQuestComplete 13318
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r


.accept 13345 >>Accept Need More Info
.target Thassarian
.isQuestTurnedIn 13318
step << skip
.goto IcecrownGlacier,65.1,57.2,0
.goto IcecrownGlacier,64.7,52.4,0
.goto IcecrownGlacier,62.1,45.9,0
.goto IcecrownGlacier,57.5,39.1,0
.goto IcecrownGlacier,54.7,35.3,0
.goto IcecrownGlacier,54.7,35.3,200,0
.goto IcecrownGlacier,65.1,57.2,200,0
.goto IcecrownGlacier,54.7,35.3
>>Take the stairs at the middle of the ship (behind |cRXP_FRIENDLY_Vindicator Maraad|r), then the stairs either side of the first staircase to go down into the engine room. Speak to |cRXP_FRIENDLY_Chief Engineer Boltwrench|r
.target Vindicator Maraad
.target Chief Engineer Boltwrench
.turnin 13320 >>Turn in Cannot Reproduce
.accept 13321 >>Accept Retest Now
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r

.turnin 13352 >>Turn in Drag and Drop

.accept 13366 >>Accept Need More Info
.target Koltira Deathweaver
.isQuestComplete 13352
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r


.accept 13366 >>Accept Need More Info
.target Koltira Deathweaver
.isQuestTurnedIn 13352
step << skip
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tReturn to |cRXP_FRIENDLY_Chief Engineer Copperclaw|r on the lower deck.
.target Chief Engineer Copperclaw
.turnin 13355 >>Turn in Cannot Reproduce
.accept 13356 >>Accept Retest Now
step << skip
#label taintedessence
#sticky
.goto IcecrownGlacier,49.7,34.4,0,0
.use 44307 >>Use the Diluted Cult Tonic to gain the "Dark Discernment" Buff. This allows you to loot the Tainted Essences from all the humanoids you kill in the area
.mob Cult Blackguard
.mob Cult Taskmaster
.mob Cult Researcher
.mob Cultist Shard Watcher
.mob Damned Apothecary
.mob Dark Subjugator
.mob Vile Torturer
.mob Void Summoner
.collect 44301,10,13321,1 << Alliance
.collect 44301,10,13356,1 << Horde
step << skip
.goto IcecrownGlacier,54.1,31.4,70,0
.goto IcecrownGlacier,54.7,28.0,70,0
.goto IcecrownGlacier,57.0,28.8,70,0
.goto IcecrownGlacier,54.1,31.4
.use 44433 >> Kill 5 |cRXP_ENEMY_Enslaved Minions|r (voidwalkers), then |cRXP_WARN_use your Rod of Siphoning on their corpses to get Dark Matter|r
.mob Enslaved Minion
.collect 44434,5,13342,1 << Alliance 
step << skip
.goto IcecrownGlacier,53.8,33.6
>>Click on the Summoning Stone
.complete 13342,1 << Alliance 
.complete 13358,1 << Horde 
step
#completewith next
.goto Icecrown,52,01,32.44,40 >>Enter Aldur'thar
step
.loop 45,Icecrown,52.60,30.93,53.28,30.82,53.27,30.22,53.26,29.56,52.56,29.39,50.95,28.98,50.55,29.40,50.94,30.29,52.60,30.93
>>Kill |cRXP_ENEMY_Cult Researchers|r. Loot them for the |cRXP_LOOT_Cult of the Damned Research Pages|r
>>|cRXP_WARN_Be careful |cRXP_ENEMY_Cult Researchers|r cast|r |T136048:0|t[Wail of Souls]|cRXP_WARN_, dealing 2000 shadow damage and knocking you back|r
.collect 44459,1,13345,1 << Alliance 
.collect 44460,1,13345,1 << Alliance 
.collect 44461,1,13345,1 << Alliance 
.collect 44459,1,13366,1 << Horde 
.collect 44460,1,13366,1 << Horde 
.collect 44461,1,13366,1 << Horde 
.mob Cult Researcher
.isOnQuest 13345 << Alliance
.isOnQuest 13366 << Horde
step
.loop 45,Icecrown,52.60,30.93,53.28,30.82,53.27,30.22,53.26,29.56,52.56,29.39,50.95,28.98,50.55,29.40,50.94,30.29,52.60,30.93
>>Use the |T134332:0|t[|cRXP_LOOT_Cult of the Damned Research - Page 1|r] to combine all the |T134332:0|t[|cRXP_LOOT_Cult of the Damned Research Pages|r] into the |cRXP_LOOT_Cult of the Damned Thesis|r
.complete 13345,1 << Alliance 
.complete 13366,1 << Horde 
.use 44459
.isOnQuest 13345 << Alliance
.isOnQuest 13366 << Horde
step << skip
#requires taintedessence
.goto IcecrownGlacier,49.7,34.4
.use 44301
.use 44304 >> Right click the Tainted Essences to turn them into a Writhing Mass. Throw it into a cauldron
.complete 13321,1 << Alliance
.complete 13356,1 << Horde
step
#completewith next
.hs >> Hearth to the Silver Covenant Pavilion << Alliance
.hs >> Hearth to the Sunreaver Pavillion << Horde
.zoneskip Icecrown
step << skip
#requires Thesis
#completewith next
.hs >> Hearth to The Shadow Vault

step
#label DragonsFell
.goto Icecrown,71.55,37.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Matthias|r
.accept 13398 >>Accept Where Dragons Fell << Alliance
.accept 13359 >>Accept Where Dragons Fell << Horde
.target Matthias Lehner
step << skip
>>Kill the |cRXP_ENEMY_Wyrm Reanimators|r just north-east of you, then kill the other mobs in the area
>>Kill |cRXP_ENEMY_Frostbrood Whelps|r. Loot them for their |cRXP_LOOT_Whelp Bone Dust|r
.complete 13397,1 << Alliance 
.complete 13349,1 << Horde 
.goto IcecrownGlacier,72.3,36.7
.complete 13397,2 << Alliance 
.complete 13349,2 << Horde 
.complete 13397,3 << Alliance 
.complete 13349,3 << Horde 
.complete 13398,1 << Alliance 
.complete 13359,1 << Horde 
.goto IcecrownGlacier,71.2,36.1,70,0
.goto IcecrownGlacier,67.9,36.2,70,0
.goto IcecrownGlacier,67.9,41.1,70,0
.goto IcecrownGlacier,72.4,40.3,70,0
.goto IcecrownGlacier,71.2,36.1,70,0
.goto IcecrownGlacier,67.9,36.2,70,0
.goto IcecrownGlacier,67.9,41.1,70,0
.goto IcecrownGlacier,72.4,40.3
.mob Wyrm Reanimator
.mob Frostbrood Whelp
.mob Cultist Corrupter
.mob Vrykul Necrolord

step
.loop 55,Icecrown,71.19,37.92,72.10,38.72,71.57,39.25,71.14,39.63,71.10,40.52,70.64,40.01,70.18,40.31,69.95,40.76,68.82,40.93,68.45,40.89,68.19,39.57,67.77,39.16,67.41,38.17,66.40,36.36,67.93,37.63,67.72,35.87,68.08,35.59,68.94,37.01,69.93,36.33,70.57,35.93,70.73,37.10,71.19,37.92
>>Kill |cRXP_ENEMY_Frostbrood Whelps|r. Loot them for their |cRXP_LOOT_Whelp Bone Dust|r
.complete 13398,1 << Alliance 
.complete 13359,1 << Horde 
.mob Frostbrood Whelp
step
.goto Icecrown,71.55,37.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Matthias|r
.turnin 13398 >>Turn in Where Dragons Fell << Alliance
.timer 28,Where Dragons Fell RP << Alliance
.accept 13399 >>Accept Time for Answers << Alliance
.turnin 13359 >>Turn in Where Dragons Fell << Horde
.timer 28,Where Dragons Fell RP << Horde
.accept 13360 >>Accept Time for Answers << Horde
.target Matthias Lehner
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r


.turnin 13345 >>Turn in Need More Info
.accept 13346 >>Accept No Rest For The Wicked
.accept 13332 >>Accept Raise the Barricades
.target Thassarian
.isQuestComplete 13345
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r


.accept 13346 >>Accept No Rest For The Wicked
.accept 13332 >>Accept Raise the Barricades
.target Thassarian
.isQuestTurnedIn 13345
step << skip
.goto IcecrownGlacier,65.1,57.2,0
.goto IcecrownGlacier,64.7,52.4,0
.goto IcecrownGlacier,62.1,45.9,0
.goto IcecrownGlacier,57.5,39.1,0
.goto IcecrownGlacier,54.7,35.3,0
.goto IcecrownGlacier,54.7,35.3,200,0
.goto IcecrownGlacier,65.1,57.2,200,0
.goto IcecrownGlacier,54.7,35.3
>>Take the stairs at the middle of the ship (behind |cRXP_FRIENDLY_Vindicator Maraad|r), then the stairs either side of the first staircase to go down into the engine room. Speak to |cRXP_FRIENDLY_Chief Engineer Boltwrench|r
.target Chief Engineer Boltwrench
.turnin 13321 >>Turn in Retest Now
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r


.turnin 13366 >>Turn in Need More Info
.accept 13367 >>Accept No Rest For The Wicked
.accept 13306 >>Accept Raise the Barricades
.target Koltira Deathweaver
.isQuestComplete 13366
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r


.accept 13367 >>Accept No Rest For The Wicked
.accept 13306 >>Accept Raise the Barricades
.target Koltira Deathweaver
.isQuestTurnedIn 13366
step << skip
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_FRIENDLY_Copperclaw|r |cRXP_WARN_is in the back room on the bottom floor of the ship|r
.turnin 13356 >>Turn in Retest Now
.target Chief Engineer Copperclaw

step
#completewith Alumeth
.goto IcecrownGlacier,52,01,32.44,50 >>Enter Aldur'thar
.isOnQuest 13346 << Alliance
.isOnQuest 13367 << Horde

step
#label Alumeth1
#completewith Alumeth
.goto IcecrownGlacier,50.49,30.00
>>Loot the |cRXP_LOOT_Alumeth's Skull|r chest on the ground
.collect 44476,1,13346,1 << Alliance 
.collect 44476,1,13367,1 << Horde 
.isOnQuest 13346 << Alliance
.isOnQuest 13367 << Horde
step
#requires Alumeth1
#label Alumeth2
#completewith Alumeth
.goto IcecrownGlacier,52.82,30.66
>>Loot the |cRXP_LOOT_Alumeth's Heart|r chest on the ground
.collect 44477,1,13346,1 << Alliance 
.collect 44477,1,13367,1 << Horde 
.isOnQuest 13346 << Alliance
.isOnQuest 13367 << Horde
step
#requires Alumeth2
#label Alumeth3
#completewith Alumeth
.goto IcecrownGlacier,52.83,29.77
>>Loot the |cRXP_LOOT_Alumeth's Scepter|r chest on the ground
.collect 44478,1,13346,1 << Alliance 
.collect 44478,1,13367,1 << Horde 
.isOnQuest 13346 << Alliance
.isOnQuest 13367 << Horde
step
#requires Alumeth3
#label Alumeth4
#completewith Alumeth
.goto IcecrownGlacier,52.99,28.95
>>Loot the |T132712:0|t[|cRXP_LOOT_Alumeth's Robes|r] chest on the ground
.collect 44479,1,13346,1 << Alliance 
.collect 44479,1,13367,1 << Horde 
.isOnQuest 13346 << Alliance
.isOnQuest 13367 << Horde
step
#requires Alumeth4
#label Alumeth5
#completewith Alumeth
.goto IcecrownGlacier,51.93,28.63
>>Use |T132712:0|t[|cRXP_LOOT_Alumeth's Robes|r] to create |T136204:0|t[|cRXP_LOOT_Alumeth's Remains|r]
.collect 44480,1,13346,1 << Alliance 
.collect 44480,1,13367,1 << Horde 
.use 44479
.isOnQuest 13346 << Alliance
.isOnQuest 13367 << Horde
step
#requires Alumeth5
#completewith Alumeth
.goto IcecrownGlacier,51.93,28.63
.cast 60831 >> Channel |T136204:0|t[|cRXP_LOOT_Alumeth's Remains|r] to summon |cRXP_ENEMY_Alumeth the Ascended|r
.timer 3,No Rest For The Wicked RP
.use 44480
.isOnQuest 13346 << Alliance
.isOnQuest 13367 << Horde
step
#label Alumeth
.goto IcecrownGlacier,51.93,28.89
>>Kill |cRXP_ENEMY_Alumeth the Ascended|r
>>|cRXP_ENEMY_Alumeth the Ascended|r |cRXP_WARN_casts|r |T136184:0|t[Psychic Scream] |cRXP_WARN_(3 second Fear),|r |T136208:0|t[Mind Flay] |cRXP_WARN_(1700 channeled shadow damage), and|r |T136207:0|t[Shadow Word: Pain] |cRXP_WARN_(2000 shadow damage DoT every 3 seconds for 18 seconds)|r
>>|cRXP_WARN_This quest is VERY difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 3|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
>>|cRXP_WARN_If you die, you'll have to create|r |T136204:0|t[|cRXP_LOOT_Alumeth's Remains|r] |cRXP_WARN_again|r
.complete 13346,1 << Alliance 
.complete 13367,1 << Horde 
.mob Alumeth the Ascended
.isOnQuest 13346 << Alliance
.isOnQuest 13367 << Horde
step
.loop 60,Icecrown,52.37,41.76,51.57,40.45,52.19,39.43,52.11,37.79,51.61,37.05,50.69,37.28,50.39,38.28,49.90,38.88,49.18,39.30,49.62,40.00,49.02,41.37,49.62,42.72,50.23,43.22,50.61,41.72,52.37,41.76
>>Use the |T132766:0|t[Barricade Construction Kit] on the pulsing |cRXP_PICK_White Runes|r
.complete 13332,1 << Alliance 
.complete 13306,1 << Horde 
.use 44127
.isQuestComplete 13346 << Alliance
.isQuestComplete 13367 << Horde
step
.goto IcecrownGlacier,49.16,73.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Matthias|r
.turnin 13399 >>Turn in Time for Answers << Alliance
.turnin 13360 >>Turn in Time for Answers << Horde
.accept 13400 >>Accept The Hunter and the Prince << Alliance
.accept 13361 >>Accept The Hunter and the Prince << Horde
.target Matthias Lehner
step
#completewith next
.goto IcecrownGlacier,49.17,73.92,-1
.goto IcecrownGlacier,49.69,73.44,-1
.vehicle >> Click the |cRXP_PICK_Bloodstained Stone|r on the ground to take control of |cRXP_FRIENDLY_Arthas|r
.timer 7,The Hunter and the Prince RP
step
.goto IcecrownGlacier,49.82,73.53,-1
.goto IcecrownGlacier,49.27,74.15,-1
>>|cRXP_WARN_Wait out the RP|r
>>|cRXP_WARN_Kill|r |cRXP_ENEMY_Illidan Stormrage|r
>>|cRXP_WARN_Right click |cRXP_ENEMY_Illidan Stormrage|r to Auto Attack him|r
>>|cRXP_WARN_Cast|r |T132269:0|t[Parry] (1) |cRXP_WARN_on cooldown to regain Mana and prevent damage|r
>>|cRXP_WARN_Cast|r |T132350:0|t[Deathstrike] (2) |cRXP_WARN_on cooldown to deal damage|r
>>|cRXP_WARN_When you have 15000+ Mana, cast|r |T132219:0|t[Stomp] (3) |cRXP_WARN_into|r |T132346:0|t[Annihilate] (4) |cRXP_WARN_on cooldown to deal a LOT of damage|r
.complete 13400,1 << Alliance 
.complete 13361,1 << Horde 
.mob Illidan Stormrage
step
.goto IcecrownGlacier,49.16,73.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Matthias|r
.turnin 13400 >>Turn in The Hunter and the Prince << Alliance
.accept 13401 >>Accept Knowledge is a Terrible Burden << Alliance
.turnin 13361 >>Turn in The Hunter and the Prince << Horde
.accept 13362 >>Accept Knowledge is a Terrible Burden << Horde
.target Matthias Lehner
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r

.turnin 13332 >>Turn in Raise the Barricades
.turnin 13346 >>Turn in No Rest For The Wicked
.turnin 13401 >>Turn in Knowledge is a Terrible Burden
.accept 13337 >>Accept The Ironwall Rampart
.accept 13334 >>Accept Bloodspattered Banners
.accept 13402 >>Accept Tirion's Help
.target Thassarian
.isQuestComplete 13332
.isQuestComplete 13346
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r

.turnin 13332 >>Turn in Raise the Barricades
.turnin 13401 >>Turn in Knowledge is a Terrible Burden
.accept 13402 >>Accept Tirion's Help
.target Thassarian
.isQuestComplete 13332
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r

.turnin 13346 >>Turn in No Rest For The Wicked
.turnin 13401 >>Turn in Knowledge is a Terrible Burden
.accept 13402 >>Accept Tirion's Help
.target Thassarian
.isQuestComplete 13346
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r

.turnin 13401 >>Turn in Knowledge is a Terrible Burden
.accept 13337 >>Accept The Ironwall Rampart
.accept 13334 >>Accept Bloodspattered Banners
.accept 13402 >>Accept Tirion's Help
.target Thassarian
.isQuestTurnedIn 13332
.isQuestTurnedIn 13346
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r

.turnin 13401 >>Turn in Knowledge is a Terrible Burden
.accept 13402 >>Accept Tirion's Help
.target Thassarian
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13306 >>Turn in Raise the Barricades
.turnin 13367 >>Turn in No Rest For The Wicked
.accept 13307 >>Accept Bloodspattered Banners
.accept 13312 >>Accept The Ironwall Rampart
.turnin 13362 >>Turn in Knowledge is a Terrible Burden
.accept 13363 >>Accept Argent Aid
.target Koltira Deathweaver
.isQuestComplete 13306
.isQuestComplete 13367
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13306 >>Turn in Raise the Barricades

.turnin 13362 >>Turn in Knowledge is a Terrible Burden
.accept 13363 >>Accept Argent Aid
.target Koltira Deathweaver
.isQuestComplete 13306

step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13362 >>Turn in Knowledge is a Terrible Burden
.accept 13363 >>Accept Argent Aid
.turnin 13367 >>Turn in No Rest For The Wicked
.target Koltira Deathweaver
.isQuestComplete 13367
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.accept 13307 >>Accept Bloodspattered Banners
.accept 13312 >>Accept The Ironwall Rampart
.turnin 13362 >>Turn in Knowledge is a Terrible Burden
.accept 13363 >>Accept Argent Aid
.target Koltira Deathweaver
.isQuestTurnedIn 13306
.isQuestTurnedIn 13367
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13362 >>Turn in Knowledge is a Terrible Burden
.accept 13363 >>Accept Argent Aid
.target Koltira Deathweaver
step << Horde
#completewith LightWithin
.abandon 13367 >>Abandon No Rest For The Wicked
step
#completewith next
.goto IcecrownGlacier,45.46,46.55
>>|cRXP_WARN_Fly up to the balcony|r
.cast 60036 >>Use the |T237427:0|t[Rune of Distortion] on |cRXP_PICK_Grimkor's Orb|r to summon |cRXP_ENEMY_Grimkor the Wicked|r
.timer 15,The Ironwall Rampart RP
.use 44186
step
.goto IcecrownGlacier,45.34,45.95
>>|cRXP_WARN_Wait out the RP|r
>>Kill |cRXP_ENEMY_Grimkor the Wicked|r
>>|cRXP_WARN_This quest can be difficult. Find a group for him if needed. Skip this step if you're unable to find a group or solo him. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_for this quest, and 2|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
.complete 13337,1 << Alliance 
.complete 13312,1 << Horde 
.mob Grimkor the Wicked
.use 44186
.isOnQuest 13337 << Alliance
.isOnQuest 13312 << Horde
step
.loop 60,Icecrown,46.82,48.66,46.58,49.32,47.12,51.54,47.48,53.23,46.93,53.35,46.84,55.64,45.57,55.40,44.12,54.71,43.67,56.60,42.10,57.17,39.50,58.21,39.83,56.77,40.19,55.80,39.38,54.19,39.75,51.94,40.77,51.12,41.35,49.48,42.35,48.16,43.25,50.11,44.96,48.99,46.82,48.66
>>Kill |cRXP_ENEMY_Scourge Banner-Bearers|r and |cRXP_ENEMY_Converted Heroes|r
.complete 13334,1 << Alliance 
.complete 13334,2 << Alliance 
.complete 13307,1 << Horde 
.complete 13307,2 << Horde 
.mob Scourge Banner-Bearer
.mob Converted Hero
.isQuestComplete 13337 << Alliance
.isQuestComplete 13312 << Horde
step
.loop 70,Icecrown,52.37,41.76,51.57,40.45,52.19,39.43,52.11,37.79,51.61,37.05,50.69,37.28,50.39,38.28,49.90,38.88,49.18,39.30,49.62,40.00,49.02,41.37,49.62,42.72,50.23,43.22,50.61,41.72,52.37,41.76
>>Kill |cRXP_ENEMY_Scourge Converters|r
.complete 13334,3 << Alliance 
.complete 13307,3 << Horde 
.mob Scourge Converter
.isQuestComplete 13337 << Alliance
.isQuestComplete 13312 << Horde
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13334 >>Turn in Bloodspattered Banners
.turnin 13337 >>Turn in The Ironwall Rampart
.accept 13335 >>Accept Before the Gate of Horror
.target Thassarian
.isQuestComplete 13337
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13334 >>Turn in Bloodspattered Banners
.accept 13335 >>Accept Before the Gate of Horror
.target Thassarian
.isQuestTurnedIn 13337
step << Alliance
#completewith LightWithin
.abandon 13334 >> Abandon Bloodspattered Banners
step << Alliance
#completewith LightWithin
.abandon 13337 >> Abandon The Ironwall Rampart
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13307 >>Turn in Bloodspattered Banners
.turnin 13312 >>Turn in The Ironwall Rampart
.accept 13329 >>Accept Before the Gate of Horror
.target Koltira Deathweaver
.isQuestComplete 13312
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13307 >>Turn in Bloodspattered Banners
.accept 13329 >>Accept Before the Gate of Horror
.target Koltira Deathweaver
.isQuestTurnedIn 13312
step << Horde
#completewith LightWithin
.abandon 13307 >> Abandon Bloodspattered Banners
step << Horde
#completewith LightWithin
.abandon 13312 >> Abandon The Ironwall Rampart
step
.loop 60,Icecrown,48.27,61.80,47.12,61.79,46.57,60.94,45.61,61.31,44.01,62.09,,45.02,63.59,43.08,64.97,45.02,63.59,47.12,61.79
>>Kill |cRXP_ENEMY_Skeletal Reavers|r. Use the |T134742:0|t[Volatile Acid] on their corpses
>>|cRXP_WARN_This quest can be difficult. Find a group for them if needed. Skip this step if you're unable to find a group or solo them. You'll miss out on 2|r |T135947:0|t[Emblems of Heroism] |cRXP_WARN_from future quests in the quest chain where you have to kill 5-man elites for each|r
.complete 13335,1 << Alliance 
.complete 13329,1 << Horde 
.mob Skeletal Reaver
.use 44653
.isOnQuest 13335 << Alliance
.isOnQuest 13329 << Horde
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13335 >>Turn in Before the Gate of Horror
.accept 13338 >>Accept The Guardians of Corp'rethar
.accept 13339 >>Accept Shatter the Shards
.target Thassarian
.isQuestComplete 13335
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.accept 13338 >>Accept The Guardians of Corp'rethar
.accept 13339 >>Accept Shatter the Shards
.target Thassarian
.isQuestTurnedIn 13335
step << Alliance
#completewith LightWithin
.abandon 13335 >> Abandon Before the Gate of Horror
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13329 >>Turn in Before the Gate of Horror
.accept 13316 >>Accept The Guardians of Corp'rethar
.accept 13328 >>Accept Shatter the Shards
.target Koltira Deathweaver
.isQuestComplete 13329
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.accept 13316 >>Accept The Guardians of Corp'rethar
.accept 13328 >>Accept Shatter the Shards
.target Koltira Deathweaver
.isQuestTurnedIn 13329
step << Horde
#completewith LightWithin
.abandon 13329 >> Abandon Before the Gate of Horror
step
#label LightWithin
.goto IcecrownGlacier,79.79,71.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.turnin 13083 >>Turn in Light Within the Darkness
.turnin 13402 >>Turn in Tirion's Help << Alliance
.accept 13403 >>Accept Tirion's Gambit << Alliance
.turnin 13363 >>Turn in Argent Aid << Horde
.accept 13364 >>Accept Tirion's Gambit << Horde
.target Highlord Tirion Fordring
step
#completewith Suffering
.goto IcecrownGlacier,53.93,67.13,50,0
.goto IcecrownGlacier,52.04,67.36,50,0
.goto IcecrownGlacier,51.13,67.27,50,0
.goto IcecrownGlacier,50.03,66.58,50,0 
.goto IcecrownGlacier,50.37,64.91,50,0
.goto IcecrownGlacier,50.83,63.88,50,0
.goto IcecrownGlacier,51.66,62.59,50,0
.goto IcecrownGlacier,50.03,66.58,50,0
>>Kill |cRXP_ENEMY_Harbingers of Horror|r and |cRXP_ENEMY_Corp'rethar Guardians|r
>>|cRXP_WARN_This quest can be difficult. Find a group for them if needed. Skip this step if you're unable to find a group or solo them. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_from this quest|r
.complete 13338,1 << Alliance 
.complete 13338,2 << Alliance 
.complete 13316,1 << Horde 
.complete 13316,2 << Horde 
.mob Harbinger of Horror
.mob Corp'rethar Guardian
.isOnQuest 13338 << Alliance
.isOnQuest 13316 << Horde
step
.goto IcecrownGlacier,49.80,66.73
>>Fly up to the 1st floor of Corp'rethar
>>Loot the |cRXP_LOOT_Shard of Despair|r
.complete 13339,2 << Alliance 
.complete 13328,2 << Horde 
.isOnQuest 13339 << Alliance
.isOnQuest 13328 << Horde
step
#label Suffering
.goto IcecrownGlacier,45.84,69.51
>>Loot the |cRXP_LOOT_Shard of Suffering|r
.complete 13339,3 << Alliance 
.complete 13328,3 << Horde 
.isOnQuest 13339 << Alliance
.isOnQuest 13328 << Horde
step
#completewith next
.goto IcecrownGlacier,45.16,71.23,50,0
.goto IcecrownGlacier,44.70,72.21,50,0
.goto IcecrownGlacier,44.28,72.87,50,0
.goto IcecrownGlacier,45.84,69.51,50,0 
.goto IcecrownGlacier,44.50,69.17,50,0
.goto IcecrownGlacier,43.53,69.07,50,0
.goto IcecrownGlacier,42.65,69.19,50,0
.goto IcecrownGlacier,39.22,69.43,50,0
>>Kill |cRXP_ENEMY_Harbingers of Horror|r and |cRXP_ENEMY_Corp'rethar Guardians|r
>>|cRXP_WARN_This quest can be difficult. Find a group for them if needed. Skip this step if you're unable to find a group or solo them. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_from this quest|r
.complete 13338,1 << Alliance 
.complete 13338,2 << Alliance 
.complete 13316,1 << Horde 
.complete 13316,2 << Horde 
.mob Harbinger of Horror
.mob Corp'rethar Guardian
.isOnQuest 13338 << Alliance
.isOnQuest 13316 << Horde
step
.goto IcecrownGlacier,47.82,68.12
>>Fly up to the 2nd floor of Corp'rethar
>>Loot the |cRXP_LOOT_Shard of Horror|r
.complete 13339,1 << Alliance 
.complete 13328,1 << Horde 
.isOnQuest 13339 << Alliance
.isOnQuest 13328 << Horde
step
.loop 60,Icecrown,49.80,66.73,45.84,69.51,44.28,72.87,44.70,72.21,45.16,71.23,44.70,72.21,44.28,72.87,45.84,69.51,44.50,69.17,43.53,69.07,42.65,69.19,39.22,69.43,42.65,69.19,43.53,69.07,44.50,69.17,45.84,69.51,49.80,66.73,50.03,66.58,50.37,64.91,50.83,63.88,51.66,62.59,50.83,63.88,50.37,64.91,50.03,66.58,51.13,67.27,52.04,67.36,53.93,67.13
>>Kill the |cRXP_ENEMY_Harbingers of Horror|r and |cRXP_ENEMY_Corp'rethar Guardians|r on the 1st and 2nd floors of Corp'rethar
>>|cRXP_WARN_This quest can be difficult. Find a group for them if needed. Skip this step if you're unable to find a group or solo them. You'll miss out on 1|r |T135947:0|t[Emblem of Heroism] |cRXP_WARN_from this quest|r
.complete 13338,1 << Alliance 
.complete 13338,2 << Alliance 
.complete 13316,1 << Horde 
.complete 13316,2 << Horde 
.isOnQuest 13338 << Alliance
.isOnQuest 13316 << Horde
step
.goto Icecrown,45.17,78.71
>>Kill |cRXP_ENEMY_Cultist Acolytes|r. Loot them for the |T133131:0|t[|cRXP_LOOT_Cultist Acolyte's Hood|r]
.collect 44784,1,13403,1 << Alliance 
.collect 44784,1,13364,1 << Horde 
.mob Cultist Acolyte
step
#completewith next
.cast 61131 >> Use the |T133131:0|t[|cRXP_LOOT_Cultist Acolyte's Hood|r]
.use 44784
step
.goto IcecrownGlacier,44.41,76.21
.gossipoption 94489 >>|cRXP_WARN_Talk to |cRXP_FRIENDLY_Tirion|r to begin a long RP|r
.timer 361,Tirion's Gambit RP
.target Highlord Tirion Fordring
.isOnQuest 13403 << Alliance
.isOnQuest 13364 << Horde
.use 44784
step
.goto IcecrownGlacier,44.73,77.45,35,0
.goto IcecrownGlacier,42.84,78.77
>>|cRXP_WARN_Follow |cRXP_FRIENDLY_Tirion|r inside the Cathedral|r
>>|cRXP_WARN_Wait out the RP|r
>>|cRXP_WARN_Make sure you aren't AFK after the timer, as the |cRXP_ENEMY_The Lich King|r casts the|r |T237567:0|t[Lich King's Fury]|cRXP_WARN_, which will kill you|r
.complete 13403,1 << Alliance 
.complete 13364,1 << Horde 
.target Highlord Tirion Fordring
.use 44784
step
#completewith next
.goto IcecrownGlacier,42.84,78.77
.goto IcecrownGlacier,80.2,70.5,100 >> |cRXP_WARN_Take the |cRXP_PICK_Escape Portal|r to Crusaders' Pinnacle. Do this before |cRXP_ENEMY_The Lich King|r casts the|r |T237567:0|t[Lich King's Fury] |cRXP_WARN_or you will die|r
step
.goto IcecrownGlacier,79.79,71.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tirion|r
.turnin 13403 >>Turn in Tirion's Gambit << Alliance
.turnin 13364 >>Turn in Tirion's Gambit << Horde
.target Highlord Tirion Fordring
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13338 >>Turn in The Guardians of Corp'rethar
.turnin 13339 >>Turn in Shatter the Shards
.target Thassarian
.isQuestComplete 13338
step << Alliance
.loop 40,IcecrownGlacier,63.10,57.22,63.96,56.49,64.32,55.27,64.10,54.05,63.68,52.62,63.24,51.38,62.78,50.37,62.22,49.16,61.75,48.06,61.30,46.97,60.77,45.69,60.20,44.34,59.65,43.00,59.13,41.78,58.65,40.63,58.07,39.06,57.58,37.89,57.04,37.30,56.14,37.70,55.47,38.76,55.48,39.67,55.81,41.09,56.24,42.45,56.78,43.76,57.29,44.88,57.92,45.95,58.49,47.06,59.08,48.22,59.60,49.41,60.10,50.66,60.57,51.93,61.00,53.22,61.46,54.48,61.95,55.87,62.53,57.08,63.10,57.22
>>|cRXP_WARN_Fly up to The Skybreaker, the Alliance ship flying in the air|r
>>|cRXP_WARN_Go toward the back-left corner on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thassarian|r
.turnin 13339 >>Turn in Shatter the Shards
.target Thassarian
.isQuestComplete 13339
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13316 >>Turn in The Guardians of Corp'rethar
.turnin 13328 >>Turn in Shatter the Shards
.target Koltira Deathweaver
.isQuestComplete 13316
step << Horde
.loop 40,IcecrownGlacier,65.55,48.81,66.12,49.95,66.67,51.04,67.48,52.19,68.29,52.51,69.20,52.11,69.62,50.99,69.74,50.05,69.79,48.80,69.80,47.29,69.79,45.49,69.78,43.97,69.75,42.64,69.70,41.17,69.65,39.60,69.58,38.00,69.52,36.42,69.47,34.96,69.43,33.66,69.41,32.10,69.45,30.33,69.48,28.90,69.36,27.80,69.08,27.09,68.20,26.52,67.22,26.57,66.40,27.05,65.57,27.85,64.72,28.65,63.91,29.31,63.11,29.97,62.28,30.69,61.45,31.27,60.70,31.95,60.27,32.98,60.10,34.36,60.24,35.79,60.66,36.94,61.22,38.17,61.75,39.40,62.30,40.57,62.86,41.77,63.27,42.72,63.75,43.97,64.22,45.22,64.65,46.36,65.00,47.42,65.46,48.62,65.55,48.81
>>|cRXP_WARN_Fly up to Orgrim's Hammer, the Horde ship flying in the air|r
>>|cRXP_WARN_Go into the back room on the top floor of the ship|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Koltira|r
.turnin 13328 >>Turn in Shatter the Shards
.target Koltira Deathweaver
.isQuestComplete 13328
step << Alliance
.abandon 13338 >> Abandon The Guardians of Corp'rethar
step << Horde
.abandon 13316 >> Abandon The Guardians of Corp'rethar
step
+Congratulations on completing the |T135947:0|t[Emblems of Heroism] Guide!
]])
RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Horde
#name 30-32 Hillsbrad/Arathi JJ
#version 23
#group RestedXP Horde 30-45
#next 32-32 Thousand Needles II JJ
#xprate 1.48-1.68
step
#completewith next
.goto Orgrimmar,52.26,88.65,30,0
.goto Orgrimmar,49.42,90.90,30,0
.goto Orgrimmar,49.74,94.78,30,0
.goto Durotar,50.59,13.28
.zone Durotar >> Exit Orgrimmar
.zoneskip Undercity
.zoneskip Tirisfal Glades
step
#completewith Gromgol
.goto Durotar,50.59,13.28,12,0
.goto Durotar,50.80,13.10,6,0
.goto Durotar,50.84,13.26,6,0
.goto Durotar,50.80,13.10,6,0
.goto Durotar,50.84,13.26,6,0
.goto Durotar,50.80,13.10,6,0
.goto Durotar,50.84,13.26,6,0
.goto Durotar,50.47,12.40,-1
.goto Durotar,58.16,8.52,-1
>>Go up the Zeppelin Tower
.zone Stranglethorn Vale >>Take the Zeppelin to Grom'gol
.zoneskip Undercity
.zoneskip Tirisfal Glades
step
#completewith next
.goto Tirisfal Glades,61.06,58.86,12,0
.goto Tirisfal Glades,61.51,59.01,10,0
.goto Tirisfal Glades,61.27,59.22,8,0
.goto Tirisfal Glades,61.13,58.84,8,0
.goto Tirisfal Glades,61.38,58.71,8,0
.goto Tirisfal Glades,61.34,59.17,8,0
.goto Tirisfal Glades,61.17,58.90,8,0
.goto Tirisfal Glades,62.07,59.14,-1
.goto Tirisfal Glades,77.82,66.72,-1
>>Go up the Zeppelin Tower
.zone Stranglethorn Vale >>Take the Zeppelin to Grom'gol
.zoneskip Tirisfal Glades,1
step
#label Gromgol
.goto Stranglethorn Vale,32.54,29.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thysta|r
.fp Grom'gol >> Get the Grom'gol Base Camp flight path
.target Thysta
step << Mage
.cast 3563 >> Cast |T135766:0|t[Teleport: Undercity]
.itemcount 17031,1
.zoneskip Undercity
.zoneskip Tirisfal Glades
step
.goto Stranglethorn Vale,31.34,29.57,10,0
.goto Stranglethorn Vale,31.56,29.59,6,0
.goto Stranglethorn Vale,31.52,29.71,6,0
.goto Stranglethorn Vale,31.56,29.59,6,0
.goto Stranglethorn Vale,31.52,29.71,6,0
.goto Stranglethorn Vale,31.56,29.59,6,0
.goto Stranglethorn Vale,31.52,29.71,6,0
.goto Stranglethorn Vale,40.98,4.73,-1
>>Go up the Zeppelin Tower
.zone Tirisfal Glades >>Take the Zeppelin to Undercity
.zoneskip Undercity
step
.goto Undercity,63.85,49.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Genavie|r
.accept 1164 >> Accept To Steal From Thieves
.target Genavie Callow
step
.goto Undercity,62.15,44.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Eunice|r. This opens up a quest later
.train 2550 >> Train |T133971:0|t[Cooking]
.target Eunice Burch
step << Warlock
.goto Undercity,75.90,37.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorah|r
.turnin 1801 >> Turn in Tome of the Cabal
.accept 1803 >> Accept Tome of the Cabal
.target Jorah Annison
step << Hunter tbc
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Geoffrey|r and |cRXP_FRIENDLY_Benijah|r
>>|cRXP_BUY_Buy a|r |T135576:0|t[Bullova] |cRXP_BUY_from |cRXP_FRIENDLY_Geoffrey|r|r
>>|cRXP_BUY_Buy a|r |T134402:0|t[Heavy Quiver] |cRXP_BUY_from |cRXP_FRIENDLY_Benijah|r|r
.collect 2523,1,1164,1 
.goto Undercity,58.68,33.08,-1
.collect 7371,1,1164,1 
.goto Undercity,58.82,32.81,-1
.target Geoffrey Hartwell
.target Benijah Fenner
.isOnQuest 1164
step << Hunter wotlk
.goto Undercity,58.82,32.81,-1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Benijah|r
>>|cRXP_BUY_Buy a|r |T134402:0|t[Heavy Quiver] |cRXP_BUY_from him|r
.collect 7371,1,1164,1 
step << Rogue
.goto Undercity,58.68,33.08
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Geoffrey|r
>>|cRXP_BUY_Buy a|r |T135275:0|t[Broadsword] |cRXP_BUY_from him|r
.collect 2520,1,1164,1 
.itemStat 16,QUALITY,<7
.itemStat 16,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<17.6
step
#completewith next
.goto Undercity,63.25,48.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Michael|r
.fly Tarren Mill >> Fly to Tarren Mill << !Shaman
.fly The Sepulcher >> Fly to the Sepulcher << Shaman
.target Michael Garrett
step << Shaman
#completewith next
.goto Silverpine Forest,42.1,40.5,10 >> Jump up the side of the tree here

step << Shaman
.goto Silverpine Forest,41.6,41.8,15,0
.goto Silverpine Forest,40.3,42.1,15,0
.goto Silverpine Forest,38.9,43.3,20 >>Run down the mountain
.isOnQuest 63
step << Shaman
.use 972 >>Drink the water sapta then kill the Water Elemental. Loot it for its Bracers
.goto Silverpine Forest,38.8,44.3
.complete 63,1 
.use 6637
step << Shaman
.goto Silverpine Forest,38.3,44.6
.turnin 63 >>Turn in Call of Water
.target Tiev Mordune
>>Talk to |cRXP_FRIENDLY_Tiev Mordune|r
.accept 100 >>Accept Call of Water
step << Shaman
.goto Silverpine Forest,38.8,44.6
>>Talk to |cRXP_FRIENDLY_Minor Manifestation of Water|r
.turnin 100 >>Turn in Call of Water
.target Minor Manifestation of Water
.accept 96 >>Accept Call of Water
step << Shaman
#completewith next
.goto Silverpine Forest,45.62,42.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Karos|r
.fly Tarren Mill >> Fly to Tarren Mill
.target Karos Razok
step
.goto Hillsbrad Foothills,61.55,20.63,8,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bel'varil|r, |cRXP_FRIENDLY_Wordeen|r, |cRXP_FRIENDLY_Krusk|r, |cRXP_FRIENDLY_Humbert|r, and |cRXP_FRIENDLY_Thaivand|r
.accept 556 >> Accept Stone Tokens
.goto Hillsbrad Foothills,61.50,20.93
.accept 544 >> Accept Prison Break In
.goto Hillsbrad Foothills,61.60,20.85
.accept 533 >> Accept Infiltration
.goto Hillsbrad Foothills,62.95,20.59,8,0
.goto Hillsbrad Foothills,63.24,20.66
.accept 547 >> Accept Humbert's Sword
.goto Hillsbrad Foothills,62.76,20.21
.accept 552 >> Accept Helcular's Revenge
.goto Hillsbrad Foothills,63.88,19.66
.target Keeper Bel'varil
.target Magus Wordeen Voidglare
.target Krusk
.target Deathguard Humbert
.target Novice Thaivand
step
.goto Hillsbrad Foothills,47.28,31.12,40,0
.goto Hillsbrad Foothills,46.16,33.32,40,0
.goto Hillsbrad Foothills,45.93,31.64,20,0
.goto Hillsbrad Foothills,45.31,29.18,20,0
.goto Hillsbrad Foothills,44.52,27.87,20,0
.goto Hillsbrad Foothills,43.96,27.59,30,0
.goto Hillsbrad Foothills,43.59,29.76,25,0
.goto Hillsbrad Foothills,45.00,27.80,20,0
.goto Hillsbrad Foothills,43.74,27.10,40,0
.goto Hillsbrad Foothills,43.62,25.60,40,0
.goto Hillsbrad Foothills,44.76,25.09,40,0
.goto Hillsbrad Foothills,45.00,27.80,20,0
.goto Hillsbrad Foothills,43.22,30.86,30,0
.goto Hillsbrad Foothills,42.79,33.51,30,0
.goto Hillsbrad Foothills,41.80,32.71,30,0
.goto Hillsbrad Foothills,42.47,30.27,30,0
.goto Hillsbrad Foothills,47.28,31.12,40,0
.goto Hillsbrad Foothills,46.16,33.32,40,0
.goto Hillsbrad Foothills,45.93,31.64,20,0
.goto Hillsbrad Foothills,45.31,29.18,20,0
.goto Hillsbrad Foothills,44.52,27.87,20,0
.goto Hillsbrad Foothills,43.96,27.59,30,0
.goto Hillsbrad Foothills,43.59,29.76,25,0
.goto Hillsbrad Foothills,45.00,27.80,20,0
.goto Hillsbrad Foothills,43.74,27.10,40,0
.goto Hillsbrad Foothills,43.62,25.60,40,0
.goto Hillsbrad Foothills,44.76,25.09
>>Kill |cRXP_ENEMY_Cave Yetis|r and |cRXP_ENEMY_Ferocious Yetis|r in and around the cave. Loot them for |cRXP_LOOT_Helcular's Rod|r
.complete 552,1 
.mob Cave Yeti
.mob Ferocious Yeti
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
>>Kill |cRXP_ENEMY_Citizen Wilkes|r
>>|cRXP_WARN_He patrols around the roads of the town|r
.complete 567,2 
.unitscan Citizen Wilkes
step
#completewith Burnside
>>Kill |cRXP_ENEMY_Hillsbrad Councilmen|r
.complete 532,2 
.mob Hillsbrad Councilman
step
#completewith next
.goto Hillsbrad Foothills,31.48,41.89,30,0
.goto Hillsbrad Foothills,30.41,42.21,10 >>Enter the Town Hall
step
#label Burnside
.goto Hillsbrad Foothills,30.09,42.42,8,0
.goto Hillsbrad Foothills,29.92,42.83,8,0
>>Kill |cRXP_ENEMY_Clerk Horrace Whitesteed|r and |cRXP_ENEMY_Magistrate Burnside|r
>>Loot the |cRXP_LOOT_Hillsbrad Town Registry|r on the ground
>>Click the |cRXP_PICK_Hillsbrad Proclamation|r on the railing
.complete 567,1 
.goto Hillsbrad Foothills,29.51,42.41
.complete 532,1 
.goto Hillsbrad Foothills,31.48,41.89
.complete 532,4 
.goto Hillsbrad Foothills,29.51,41.53
.complete 532,3 
.goto Hillsbrad Foothills,29.73,41.76
.mob Clerk Horrace Whitesteed
.mob Magistrate Burnside
step
.loop 40,Hillsbrad Foothills,30.14,42.90,30.18,42.23,30.32,41.42,29.30,40.78,29.70,39.73,31.91,42.34,32.62,46.50,31.91,42.34,30.21,43.55,30.32,41.42
>>Kill |cRXP_ENEMY_Hillsbrad Councilmen|r
.complete 532,2 
.mob Hillsbrad Councilman
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Darthalia|r and |cRXP_FRIENDLY_Thaivand|r
.turnin 532 >> Turn in Battle of Hillsbrad
.accept 539 >> Accept Battle of Hillsbrad
.goto Hillsbrad Foothills,62.39,20.28
.turnin 552 >> Turn in Helcular's Revenge
.accept 553 >> Accept Helcular's Revenge
.goto Hillsbrad Foothills,63.88,19.66
.target High Executor Darthalia
.target Novice Thaivand
step
.goto Hillsbrad Foothills,62.53,19.58,8,0
.goto Hillsbrad Foothills,62.78,19.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shay|r
>>|cRXP_BUY_Buy|r |T132799:0|t[Sweet Nectar] |cRXP_BUY_from him|r << Priest/Mage/Warlock/Druid
>>|cRXP_BUY_Buy|r |T133969:0|t[Wild Hog Shanks] |cRXP_BUY_from him|r << !Priest !Mage !Warlock !Druid !Paladin
>>|cRXP_BUY_Buy|r |T132799:0|t[Sweet Nectar] |cRXP_BUY_and|r |T133969:0|t[Wild Hog Shanks] |cRXP_BUY_from him|r << Paladin
.collect 1708,20,553,1 << Priest/Mage/Warlock/Druid/Paladin 
.collect 3771,20,553,1 << !Priest !Mage !Warlock !Druid !Paladin 
.collect 3771,10,553,1 << Paladin 
.target Innkeeper Shay
.money <0.4000 << !Paladin
.money <0.6000 << Paladin/Shaman
.xp <24,1
.xp >35,1
step << Hunter
.goto Hillsbrad Foothills,62.56,19.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kayren|r
>>|cRXP_BUY_Buy|r |T132382:0|t[Razor Arrows] |cRXP_BUY_from her|r
.collect 3030,2000,553,1 
.target Kayren Soothallow
.money <0.2850 << BloodElf
.money <0.3000 << Troll/Orc
.xp <25,1
step << Hunter
.goto Hillsbrad Foothills,62.56,19.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kayren|r
>>|cRXP_BUY_Buy|r |T132382:0|t[Razor Arrows] |cRXP_BUY_from her|r
.collect 3030,1000,553,1 
.target Kayren Soothallow
.money <0.1425 << BloodElf
.money <0.1500 << Troll/Orc
.xp <25,1
step << Warlock
.goto Hillsbrad Foothills,27.78,72.80
>>Loot the |cRXP_LOOT_Moldy Tome|r on the ground
.complete 1803,1 
step
#completewith next
.goto Hillsbrad Foothills,27.42,59.17,30 >> Go inside the mine
step
#completewith Bonds
.goto Hillsbrad Foothills,27.43,58.28,20,0
.goto Hillsbrad Foothills,28.14,55.20,20,0
.goto Hillsbrad Foothills,28.37,52.97,20,0
.goto Hillsbrad Foothills,29.70,54.25,20,0
>>Kill |cRXP_ENEMY_Hillsbrad Miners|r
.complete 539,2 
.mob Hillsbrad Miner
step
#completewith next
>>Kill |cRXP_ENEMY_Miner Hackett|r
>>|cRXP_WARN_He has multiple spawnpoints inside the mine|r
.goto Hillsbrad Foothills,29.71,56.07,20,0
.goto Hillsbrad Foothills,31.08,56.64,20,0
.complete 567,3 
.unitscan Miner Hackett
step
#label Bonds
.goto Hillsbrad Foothills,31.21,56.02
>>Kill |cRXP_ENEMY_Foreman Bonds|r in the central room of the mine
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Foreman Bonds|r casts |r |T135963:0|t[Hammer of Justice]|cRXP_WARN_, Stunning you for 4 seconds|r
>>|cRXP_WARN_At 30% or less health, |cRXP_ENEMY_Foreman Bonds|r instantly summons two |cRXP_ENEMY_Dun Garok Soldiers|r (level 30) to defend him|r
.complete 539,1 
.mob Foreman Bonds
step
>>Kill |cRXP_ENEMY_Miner Hackett|r
>>|cRXP_WARN_He has multiple spawnpoints inside the mine|r
.loop 30,Hillsbrad Foothills,31.14,58.62,31.90,52.66,29.71,56.07,31.08,56.64
.complete 567,3 
.unitscan Miner Hackett
step
.loop 30,Hillsbrad Foothills,31.14,58.62,31.90,52.66,29.71,56.07,31.08,56.64
>>Kill |cRXP_ENEMY_Hillsbrad Miners|r
.complete 539,2 
.mob Hillsbrad Miner
step << wotlk
#completewith next
.goto Hillsbrad Foothills,29.89,52.37,-1
.goto Hillsbrad Foothills,29.44,56.22,-1
.goto Hillsbrad Foothills,32.40,55.38,-1
.goto Hillsbrad Foothills,31.16,56.88,-1
.goto Hillsbrad Foothills,29.62,45.82,30 >>|cRXP_WARN_Run on top of any of the Sawblades in the mine. Perform a Logout Skip by logging out and back in|r
.link https://www.youtube.com/watch?v=sT-LB2dKezY >> |cRXP_WARN_CLICK HERE|r
step
#completewith StoneTokens
>>Kill |cRXP_ENEMY_Dalaran Shield Guards|r and |cRXP_ENEMY_Dalaran Theurgists|r. Loot them for their |cRXP_LOOT_Worn Stone Tokens|r
>>|cRXP_WARN_Be VERY careful of the |cRXP_ENEMY_Dalaran Shield Guards|r, as they have a 10% chance when they take damage to proc|r |T136173:0|t[Violent Shield Effect]|cRXP_WARN_, (deals 85 damage per melee attack, and roots them in place)|r << Warrior/Rogue/Paladin
>>Don't worry too much about the |cRXP_ENEMY_Dalaran Theurgists|r's |T136075:0|t[Summon Spirit of Old] as they die in 1 hit
.complete 556,1 
.mob Dalaran Shield Guard
.mob Dalaran Theurgist
step
#sticky
#label Dermot
.goto Alterac Mountains,19.91,85.91,-1
>>Kill |cRXP_ENEMY_Dermot|r inside. Loot him for the |cRXP_LOOT_Bloodstone Wedge|r
.complete 544,1 
.mob Dermot
step
.goto Alterac Mountains,20.40,86.33,-1
>>Kill |cRXP_ENEMY_Alina|r inside. Loot her for the |cRXP_LOOT_Bloodstone Shard|r
.complete 544,3 
.mob Alina
step
#requires Dermot
>>Kill |cRXP_ENEMY_Ricter|r. Loot him for the |cRXP_LOOT_Bloodstone Marble|r
.goto Alterac Mountains,20.15,84.31
.complete 544,2 
.mob Ricter
step
#completewith next
.goto Alterac Mountains,18.69,84.43,10,0
.goto Alterac Mountains,18.20,82.90,10,0
.goto Alterac Mountains,17.89,83.86,10,0
.goto Alterac Mountains,17.83,84.11,6 >>Go into the building, then up to the second floor
step
#label StoneTokens
.goto Alterac Mountains,17.79,83.14
>>Kill |cRXP_ENEMY_Kegan Darkmar|r on the second floor. Loot him for the |cRXP_LOOT_Bloodstone Oval|r. Run away after looting it
>>|cRXP_WARN_You do not need to kill |cRXP_ENEMY_Warden Belamoore|r|r
>>|cRXP_WARN_Avoid |cRXP_ENEMY_Warden Belamoore|r's |T135812:0|t[Fireballs] as you're fighting |cRXP_ENEMY_Kegan Darkmar|r by LoSing her |T135812:0|t[Fireballs] around the building|r
.complete 544,4 
.mob Kegan Darkmar
.mob Warden Belamoore
step
.loop 30,Alterac Mountains,17.24,84.38,18.69,85.17,19.47,82.92,21.14,84.06,20.69,86.48,20.85,87.76,17.24,84.38
>>Kill |cRXP_ENEMY_Dalaran Shield Guards|r and |cRXP_ENEMY_Dalaran Theurgists|r. Loot them for their |cRXP_LOOT_Worn Stone Tokens|r
>>|cRXP_WARN_Be VERY careful of the |cRXP_ENEMY_Dalaran Shield Guards|r, as they have a 10% chance when they take damage to proc|r |T136173:0|t[Violent Shield Effect]|cRXP_WARN_, (deals 85 damage per melee attack, and roots them in place)|r << Warrior/Rogue/Paladin
>>Don't worry too much about the |cRXP_ENEMY_Dalaran Theurgists|r's |T136075:0|t[Summon Spirit of Old] as they die in 1 hit
.complete 556,1 
.mob Dalaran Shield Guard
.mob Dalaran Theurgist
step
.goto Alterac Mountains,37.44,68.08,30,0
.goto Alterac Mountains,37.54,66.22
>>Click the |cRXP_PICK_Flame of Uzel|r inside the cave
>>|cRXP_WARN_It has a 20 yard range|r
.complete 553,3 
step
.loop 40,Hillsbrad Foothills,46.49,81.84,47.77,83.27,48.70,82.63,48.71,81.28,47.69,79.75,46.49,81.84
>>Kill |cRXP_ENEMY_Syndicate Footpads|r and |cRXP_ENEMY_Syndicate Thieves|r. Loot them for the |cRXP_LOOT_Syndicate Missive|r
.complete 533,1 
.mob Syndicate Footpad
.mob Syndicate Thief
step
#completewith next
.goto Hillsbrad Foothills,45.93,31.64,20 >>Enter the Yeti cave
step
.goto Hillsbrad Foothills,45.62,31.13,20,0
.goto Hillsbrad Foothills,45.06,29.04,20,0
.goto Hillsbrad Foothills,44.26,28.10,20,0
.goto Hillsbrad Foothills,43.89,28.06
>>Click the |cRXP_PICK_Flame of Azel|r on the top floor
>>|cRXP_WARN_It has a 20 yard range|r
>>|cRXP_WARN_Stay on the top floor. Do not go down yet|r
.complete 553,1 
step
.goto Hillsbrad Foothills,44.77,28.71,20,0
.goto Hillsbrad Foothills,44.88,27.44,20,0
.goto Hillsbrad Foothills,44.04,26.55
>>|cRXP_WARN_Drop down a floor|r
>>Click the |cRXP_PICK_Flame of Veraz|r on the bottom floor
.complete 553,2 
step
#completewith next
.goto Hillsbrad Foothills,46.26,31.71,20 >>Exit the Yeti cave
step
.goto Hillsbrad Foothills,61.55,20.63,8,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bel'varil|r, |cRXP_FRIENDLY_Wordeen|r, |cRXP_FRIENDLY_Darthalia|r, and |cRXP_FRIENDLY_Krusk|r
.turnin 556 >> Turn in Stone Tokens
.goto Hillsbrad Foothills,61.50,20.93
.turnin 544 >> Turn in Prison Break In
.goto Hillsbrad Foothills,61.60,20.85
.turnin 539 >> Turn in Battle of Hillsbrad
.accept 541 >> Accept Battle of Hillsbrad
.turnin 567 >> Turn in Dangerous!
.goto Hillsbrad Foothills,62.39,20.28
.turnin 533 >> Turn in Infiltration
.goto Hillsbrad Foothills,62.95,20.59,8,0
.goto Hillsbrad Foothills,63.24,20.66
.target Keeper Bel'varil
.target Magus Wordeen Voidglare
.target High Executor Darthalia
.target Krusk
step
.goto Hillsbrad Foothills,68.01,18.99,40,0
.goto Hillsbrad Foothills,68.07,23.02,40,0
.goto Hillsbrad Foothills,68.32,25.88,40,0
.goto Hillsbrad Foothills,67.95,28.95,40,0
.goto Hillsbrad Foothills,67.79,32.76,40,0
.goto Hillsbrad Foothills,67.54,35.33,40,0
.goto Hillsbrad Foothills,66.11,38.29,40,0
.goto Hillsbrad Foothills,63.67,40.37,40,0
.goto Hillsbrad Foothills,61.91,42.95,40,0
.goto Hillsbrad Foothills,59.42,45.08,40,0
.goto Hillsbrad Foothills,57.47,47.67,40,0
.goto Hillsbrad Foothills,56.36,50.18,40,0
.goto Hillsbrad Foothills,55.45,53.46,40,0
.goto Hillsbrad Foothills,55.61,56.96
>>Kill |cRXP_ENEMY_Snapjaws|r. Loot them for their |cRXP_LOOT_Turtle Meat|r
.collect 3712,10,7321,1 
.train 2550,3 
.mob Snapjaw
step
#completewith next
.goto Hillsbrad Foothills,54.66,53.82,90 >>Approach |cRXP_PICK_Helcular's Grave|r from the river to avoid |cRXP_ENEMY_Southshore Guards|r
step
.goto Hillsbrad Foothills,52.75,53.37
>>Click |cRXP_PICK_Helcular's Grave|r
.turnin 553 >> Turn in Helcular's Revenge
step
#completewith Ironhill
.goto Hillsbrad Foothills,70.98,78.54,40 >> Enter Dun Garok
step
#completewith next
>>Kill |cRXP_ENEMY_Dun Garok Mountaineers|r, |cRXP_ENEMY_Dun Garok Riflemen|r, and |cRXP_ENEMY_Dun Garok Priests|r. Loot them for |cRXP_LOOT_Humbert's Sword|r
.complete 541,1 
.complete 541,2 
.complete 541,3 
.complete 547,1 
step
#label Ironhill
.goto Hillsbrad Foothills,70.84,79.42,10,0
.goto Hillsbrad Foothills,71.35,80.32,10,0
.goto Hillsbrad Foothills,72.37,81.43,10,0
.goto Hillsbrad Foothills,72.60,82.22,10,0
.goto Hillsbrad Foothills,72.28,82.67,10,0
.goto Hillsbrad Foothills,72.00,81.89,10,0
.goto Hillsbrad Foothills,71.12,80.28,10,0 
.goto Hillsbrad Foothills,73.12,81.34,10,0
.goto Hillsbrad Foothills,73.00,80.59,10,0
.goto Hillsbrad Foothills,72.05,79.32,10,0 
.goto Hillsbrad Foothills,71.35,80.32,10,0
.goto Hillsbrad Foothills,71.50,81.49,10,0
.goto Hillsbrad Foothills,71.73,80.89,10,0
.goto Hillsbrad Foothills,71.50,79.49 
>>Kill |cRXP_ENEMY_Captain Ironhill|r
>>|cRXP_WARN_He has multiple spawnpoints. He can be found upstairs or downstairs in the basement|r
.complete 541,4 
.unitscan Captain Ironhill
step
.loop 20,Hillsbrad Foothills,71.55,81.12,72.05,80.53,72.60,79.84,71.81,78.27,70.57,77.89,71.05,75.01,68.91,77.91,70.57,77.89,70.66,79.68,71.55,81.12
>>Kill |cRXP_ENEMY_Dun Garok Mountaineers|r, |cRXP_ENEMY_Dun Garok Riflemen|r, and |cRXP_ENEMY_Dun Garok Priests|r. Loot them for |cRXP_LOOT_Humbert's Sword|r
.complete 541,1 
.complete 541,2 
.complete 541,3 
.complete 547,1 
step
#completewith next
.goto Hillsbrad Foothills,80.06,60.19,15,0
.goto Hillsbrad Foothills,80.56,60.70,12,0
.goto Hillsbrad Foothills,80.14,62.52,12,0
.goto Arathi Highlands,34.74,44.14
.zone Arathi Highlands >> Travel to Arathi Highlands
step
#completewith Kenata
.goto Arathi Highlands,54.76,38.34,30,0
>>Kill |cRXP_ENEMY_Fardel Dabyrie|r. Loot him for |cRXP_LOOT_Fardel's Head|r
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Fardel|r casts|r |T136067:0|t[Deadly Poison]|cRXP_WARN_ (Deals 57 damage every 5 seconds, interruptable) and|r |T132152:0|t[Thrash] |cRXP_WARN_(2 extra attacks every 15 seconds)|r
.complete 1164,3 
.mob Fardel Dabyrie
step
.goto Arathi Highlands,54.21,38.08
>>Kill |cRXP_ENEMY_Marcel Dabyrie|r. Loot him for |cRXP_LOOT_Marcel's Head|r
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Marcel|r casts|r |T132362:0|t[Shield Wall]|cRXP_WARN_ (Reducing his damage taken by 75% for 10 seconds) and|r |T132357:0|t[Shield Bash] |cRXP_WARN_(spell interrupt)|r << !Rogue !Warrior
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Marcel|r casts|r |T132362:0|t[Shield Wall]|cRXP_WARN_ (Reducing his damage taken by 75% for 10 seconds)|r << Rogue/Warrior
.complete 1164,2 
.mob Marcel Dabyrie
step
#label Kenata
.goto Arathi Highlands,56.37,36.08
>>Kill |cRXP_ENEMY_Kenata Dabyrie|r inside. Loot her for |cRXP_LOOT_Kenata's Head|r
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Kenata|r casts|r |T132343:0|t[Disarm]|cRXP_WARN_ (Disarms you for 10 seconds)|r << Rogue/Warrior/Paladin/Shaman
.complete 1164,1 
.mob Kenata Dabyrie
step
.goto Arathi Highlands,56.63,38.80,30,0
.goto Arathi Highlands,56.78,40.47,30,0
.goto Arathi Highlands,54.76,38.34,30,0
.goto Arathi Highlands,56.63,38.80,30,0
.goto Arathi Highlands,56.78,40.47,30,0
.goto Arathi Highlands,54.76,38.34,30,0
.goto Arathi Highlands,56.63,38.80,30,0
.goto Arathi Highlands,56.78,40.47,30,0
.goto Arathi Highlands,54.76,38.34,30,0
.goto Arathi Highlands,56.63,38.80,30,0
.goto Arathi Highlands,56.78,40.47,30,0
.goto Arathi Highlands,54.76,38.34
>>Kill |cRXP_ENEMY_Fardel Dabyrie|r. Loot him for |cRXP_LOOT_Fardel's Head|r
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Fardel|r casts|r |T136067:0|t[Deadly Poison]|cRXP_WARN_ (Deals 57 damage every 5 seconds, interruptable) and|r |T132152:0|t[Thrash] |cRXP_WARN_(2 extra attacks every 15 seconds)|r
.complete 1164,3 
.mob Fardel Dabyrie
step
.goto Arathi Highlands,62.50,33.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Shards of Myzrael|r
.accept 642 >> Accept The Princess Trapped
step
.goto Arathi Highlands,73.79,33.03,10,0
.goto Arathi Highlands,73.84,32.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Adegwa|r
>>|cRXP_BUY_Buy|r |T132799:0|t[Sweet Nectar] |cRXP_BUY_from him|r << Priest/Mage/Warlock/Druid
>>|cRXP_BUY_Buy|r |T133994:0|t[Stormwind Brie] |cRXP_BUY_from him|r << !Priest !Mage !Warlock !Druid !Paladin
>>|cRXP_BUY_Buy|r |T132799:0|t[Sweet Nectar] |cRXP_BUY_and|r |T133994:0|t[Stormwind Brie] |cRXP_BUY_from him|r << Paladin
.collect 1708,20,1145,1 << Priest/Mage/Warlock/Druid/Paladin 
.collect 1707,20,1145,1 << !Priest !Mage !Warlock !Druid !Paladin 
.collect 1707,10,1145,1 << Paladin 
.target Innkeeper Adegwa
.money <0.4000 << !Paladin
.money <0.6000 << Paladin/Shaman
.xp <24,1
.xp >35,1
step << Mage
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Adegwa|r
.home >> Set your Hearthstone to Hammerfall
.target Innkeeper Adegwa
.itemcount 17031,1
step << Hunter
.goto Arathi Highlands,72.52,33.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mu'uta|r
.vendor 9551 >>|cRXP_BUY_Buy the|r |T135495:0|t[Dense Shortbow] |cRXP_BUY_if it's up and|r |T132382:0|t[Razor Arrows] |cRXP_BUY_from him|r
.collect 3030,2000,4767,1 
.target Mu'uta
.itemcount 3030,<2000
.money <2.8814
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<18.95

step << Hunter
.goto Arathi Highlands,72.52,33.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mu'uta|r
.vendor 9551 >>|cRXP_BUY_Buy the|r |T135495:0|t[Dense Shortbow] |cRXP_BUY_from him if it's up|r
.target Mu'uta
.money <2.5814
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<18.95
step << Hunter
.goto Arathi Highlands,72.52,33.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mu'uta|r
>>|cRXP_BUY_Buy|r |T132382:0|t[Razor Arrows] |cRXP_BUY_from him|r
.collect 3030,2000,4767,1 
.target Mu'uta
.itemcount 3030,<2000
.money <0.3000
step << Hunter
#completewith next
+Equip the |T135495:0|t[Dense Shortbow]
.use 11305
.itemcount 11305,1
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<18.95
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gor'mul|r and |cRXP_FRIENDLY_Tor'gan|r
.accept 655 >> Accept Hammerfall
.goto Arathi Highlands,72.64,33.92
.turnin 655 >> Turn in Hammerfall
.accept 671 >> Accept Foul Magics
.accept 672 >> Accept Raising Spirits
.goto Arathi Highlands,74.72,36.29
.target Gor'mul
.target Tor'gan
step << Mage
.loop 45,Arathi Highlands,70.40,32.28,70.77,34.72,69.16,39.78,68.55,37.67,68.73,36.09,67.05,33.98,65.78,36.03,65.85,37.77,65.60,38.88,65.21,39.48,65.80,41.65,67.02,42.51,66.17,44.35,64.87,45.11,64.42,46.39,62.56,46.52,63.25,44.87,63.85,43.06,64.65,40.33,61.89,43.36,60.87,37.77,59.38,38.32,58.71,40.97,60.34,42.86,60.73,44.50,61.14,45.68,60.42,46.13,58.89,43.01
>>Kill |cRXP_ENEMY_Highland Striders|r. Loot them for their |cRXP_LOOT_Highland Raptor Eyes|r
.complete 672,1,6 
.mob Highland Strider
.itemcount 17031,1
step << Mage
.loop 45,Arathi Highlands,55.57,45.96,56.98,46.90,55.84,48.06,54.88,46.98,53.01,46.56,51.11,46.43,52.29,45.57,54.05,44.86,53.27,43.74,51.36,41.17,50.98,40.50,49.90,41.49
>>Kill |cRXP_ENEMY_Highland Striders|r. Loot them for their |cRXP_LOOT_Highland Raptor Eyes|r
.complete 672,1 
.mob Highland Strider
.itemcount 17031,1
step
#completewith next
>>Kill |cRXP_ENEMY_Highland Striders|r and |cRXP_ENEMY_Highland Thrashers|r. Loot them for their |cRXP_LOOT_Highland Raptor Eyes|r
>>|cRXP_WARN_Be careful as the |cRXP_ENEMY_Highland Thrashers|r cast|r |T132152:0|t[Thrash] |cRXP_WARN_(2 extra attacks every 15 seconds)|r
.complete 672,1 
.mob Highland Strider
.mob Highland Thrasher
step
.loop 45,Arathi Highlands,34.76,29.97,34.66,31.24,34.17,32.81,32.86,32.74,31.65,32.76,30.07,30.04,30.34,28.81,30.31,28.00,30.63,25.77,32.28,25.16,32.91,24.39,33.62,25.43,33.91,26.55,34.20,26.96,34.77,27.14,34.76,29.97
>>Kill |cRXP_ENEMY_Syndicate Pathstalkers|r, |cRXP_ENEMY_Syndicate Mercenaries|r, and |cRXP_ENEMY_Syndicate Highwaymen|r. Loot them for their |cRXP_LOOT_Bloodstone Amulets|r
>>|cRXP_WARN_The |cRXP_ENEMY_Syndicate Highwaymen|r are stealthed|r
.complete 671,1 
.mob Syndicate Pathstalker
.mob Syndicate Mercenary
.mob Syndicate Highwayman
step
.loop 45,Arathi Highlands,55.57,45.96,56.98,46.90,55.84,48.06,54.88,46.98,53.01,46.56,51.11,46.43,52.29,45.57,54.05,44.86,53.27,43.74,51.36,41.17,50.98,40.50,49.90,41.49
>>Kill |cRXP_ENEMY_Highland Striders|r. Loot them for their |cRXP_LOOT_Highland Raptor Eyes|r
.complete 672,1,6 
.mob Highland Strider
step
.loop 45,Arathi Highlands,70.40,32.28,70.77,34.72,69.16,39.78,68.55,37.67,68.73,36.09,67.05,33.98,65.78,36.03,65.85,37.77,65.60,38.88,65.21,39.48,65.80,41.65,67.02,42.51,66.17,44.35,64.87,45.11,64.42,46.39,62.56,46.52,63.25,44.87,63.85,43.06,64.65,40.33,61.89,43.36,60.87,37.77,59.38,38.32,58.71,40.97,60.34,42.86,60.73,44.50,61.14,45.68,60.42,46.13,58.89,43.01
>>Kill |cRXP_ENEMY_Highland Striders|r. Loot them for their |cRXP_LOOT_Highland Raptor Eyes|r
.complete 672,1 
.mob Highland Strider
step << Mage
#completewith next
.hs >>Hearth to Hammerfall
.itemcount 17031,1
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tor'gan|r and |cRXP_FRIENDLY_Gor'mul|r
.turnin 671 >> Turn in Foul Magics
.turnin 672 >> Turn in Raising Spirits
.accept 674 >> Accept Raising Spirits
.goto Arathi Highlands,74.72,36.29
.turnin 674 >> Turn in Raising Spirits
.accept 675 >> Accept Raising Spirits
.goto Arathi Highlands,72.64,33.92
.target Tor'gan
.target Gor'mul
step
.goto Arathi Highlands,74.72,36.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tor'gan|r
.turnin 675 >> Turn in Raising Spirits
.target Tor'gan
step
#completewith TarrenMillF
.goto Arathi Highlands,73.07,32.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FFUrda|r
.fly Tarren Mill >> Fly to Tarren Mill
.target Urda
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Darthalia|r, |cRXP_FRIENDLY_Humbert|r, and |cRXP_FRIENDLY_Christoph|r
>>|cRXP_BUY_Buy|r |T134059:0|t[Soothing Spices] |cRXP_BUY_from |cRXP_FRIENDLY_Christoph|r|r << tbc
.turnin 541 >> Turn in Battle of Hillsbrad
.accept 550 >> Accept Battle of Hillsbrad
.goto Hillsbrad Foothills,62.39,20.28
.turnin 547 >> Turn in Humbert's Sword
.goto Hillsbrad Foothills,62.76,20.21
.collect 3713,1,7321,1 << tbc 
.accept 7321 >> Accept Soothing Turtle Bisque
.turnin 7321 >> Turn in Soothing Turtle Bisque
.goto Hillsbrad Foothills,62.52,19.61,12,0
.goto Hillsbrad Foothills,62.28,19.05
.target High Executor Darthalia
.target Deathguard Humbert
.target Christoph Jeffcoat
.itemcount 3712,10 
.train 2550,3 
step
#label TarrenMillF
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Darthalia|r and |cRXP_FRIENDLY_Humbert|r
.turnin 541 >> Turn in Battle of Hillsbrad
.accept 550 >> Accept Battle of Hillsbrad
.goto Hillsbrad Foothills,62.39,20.28
.turnin 547 >> Turn in Humbert's Sword
.goto Hillsbrad Foothills,62.76,20.21
.target High Executor Darthalia
.target Deathguard Humbert
step << skip
>> Ride up to Alterac Mountains
.goto Alterac Mountains,80.497,66.919
>>Talk to |cRXP_FRIENDLY_Bath'rah the Windwatcher|r
.turnin 1791 >>Turn in The Windwatcher
.target Bath'rah the Windwatcher
.accept 1712 >>Accept Cyclonian

step
#completewith next
.goto Hillsbrad Foothills,60.14,18.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zarise|r
.fly Undercity >> Fly to Undercity
.target Zarise
.zoneskip Hillsbrad Foothills,1
.itemcount 17031,<1 << Mage

step
.goto Undercity,63.85,49.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Genavie|r
.turnin 1164 >> Turn in To Steal From Thieves
.itemcount 17031,<1 << Mage
.target Genavie Callow
step << Mage
#completewith Thieves
.cast 3563 >>Cast |T135766:0|t[Teleport: Undercity]
.zoneskip Undercity
.itemcount 17031,1
step << Mage
.goto Undercity,82.77,15.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anastasia|r
.train 8422 >> Train your class spells
.target Anastasia Hartwell
.xp <32,1
.xp >34,1
step << Mage
.goto Undercity,82.77,15.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Anastasia|r
.train 8492 >> Train your class spells
.target Anastasia Hartwell
.xp <34,1
step << Mage
.goto Undercity,82.77,15.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hannah|r
>>|cRXP_BUY_Buy|r |T134419:0|t[Runes of Teleportation] |cRXP_BUY_from her|r
.collect 17031,5,496,1 
.target Hannah Akeley
step << Mage
#label Thieves
.goto Undercity,63.85,49.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Genavie|r
.turnin 1164 >> Turn in To Steal From Thieves
.target Genavie Callow
step << Warrior
#completewith WarriorTrain1
.goto Undercity,63.79,47.28,15,0
.goto Undercity,57.82,44.73,25,0
.goto Undercity,52.46,42.08,25,0
.goto Undercity,48.49,31.60,25,0
.goto Undercity,45.92,23.41,25,0
.goto Undercity,46.23,18.07,25,0
.goto Undercity,47.42,17.27,25 >>Travel toward |cRXP_FRIENDLY_Baltus|r
step << Warrior
.goto Undercity,47.42,17.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Baltus|r
.train 11549 >> Train your class spells
.target Baltus Fowler
.xp <32,1
.xp >34,1
step << Warrior
#label WarriorTrain1
.goto Undercity,47.42,17.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Baltus|r
.train 7379 >> Train your class spells
.target Baltus Fowler
.xp <34,1
step << Rogue
#completewith RogueTrain1
.goto Undercity,63.79,47.28,15,0
.goto Undercity,65.27,56.15,25,0
.goto Undercity,67.15,64.32,25,0
.goto Undercity,83.88,72.06,20 >>Travel toward |cRXP_FRIENDLY_Carolyn|r
step << Rogue
.goto Undercity,83.88,72.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carolyn|r
.train 8623 >> Train your class spells
.target Carolyn Ward
.xp <32,1
.xp >34,1
step << Rogue
#label RogueTrain1
.goto Undercity,83.88,72.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carolyn|r
.train 8696 >> Train your class spells
.target Carolyn Ward
.xp <34,1
step << Shaman/Warrior
#completewith next
.goto Undercity,63.77,47.25,15,0 << Shaman
.goto Undercity,65.43,56.36,30,0 << Shaman
.goto Undercity,64.78,64.48,30,0 << Shaman
.goto Undercity,52.68,77.65,15,0
.goto Undercity,51.15,80.09,12,0
.goto Undercity,49.06,78.17,12,0
.goto Undercity,47.80,75.46,15,0
.goto Undercity,48.81,69.28,20 >>Travel toward |cRXP_FRIENDLY_Faranell|r
step << Shaman/Warrior
.goto Undercity,48.81,69.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Faranell|r
.turnin 513 >> Turn in Elixir of Agony
step
#completewith next
.goto Undercity,47.80,75.46,15,0 << Shaman/Warrior
.goto Undercity,49.06,78.17,12,0 << Shaman/Warrior
.goto Undercity,51.15,80.09,12,0 << Shaman/Warrior
.goto Undercity,52.68,77.65,15,0 << Shaman/Warrior
.goto Undercity,54.70,67.53,25,0 << Shaman/Warrior
.goto Undercity,51.88,64.84,20,0
.goto Undercity,46.28,73.10,15,0
.goto Undercity,45.31,78.24,15,0
.goto Undercity,46.18,83.63,15,0
.goto Undercity,48.80,87.63,15,0
.goto Undercity,52.45,89.49,15,0
.goto Undercity,56.18,94.85,15,0
.goto Undercity,56.23,92.21,15 >> Travel toward |cRXP_FRIENDLY_Bragor|r inside the Royal Quarter << wotlk
.goto Undercity,56.23,92.21,15 >> Travel toward |cRXP_FRIENDLY_Varimathras|r inside the Royal Quarter << tbc
step
.goto Undercity,56.23,92.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bragor|r << wotlk
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Varimathras|r << tbc
.turnin 550 >> Turn in Battle of Hillsbrad
.target Bragor Bloodfist << wotlk
.target Varimathras << tbc
step << Paladin
.goto Undercity,58.00,90.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cyssa|r
.train 19836 >>Train your class spells
.target Champion Cyssa Dawnrose
.xp <32,1
.xp >34,1
step << Paladin
.goto Undercity,58.00,90.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cyssa|r
.train 642 >>Train your class spells
.target Champion Cyssa Dawnrose
.xp <34,1
step << Undead !Warlock
#completewith next
.goto Undercity,55.20,90.91
.goto Undercity,67.88,14.97,30 >>|cRXP_WARN_Go to the edge of the main platform in the Royal Quarter. Perform a Logout Skip by positioning your character until it looks like they're floating, then logging out and back in|r
.link https://www.youtube.com/watch?v=jj85AXyF1XE >> |cRXP_WARN_CLICK HERE|r
.skill riding,75,1
step << Undead !Warlock
.goto Undercity,66.21,4.90,15,0
.goto Tirisfal Glades,61.73,64.87
.zone Tirisfal Glades >>Exit Undercity
.skill riding,75,1
step << Undead !Warlock
.goto Tirisfal Glades,60.08,52.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Velma|r
.skill riding,75 >> Train |T136103:0|t[Apprentice Riding] from her
.target Velma Warnam
.money <4.5 << wotlk
.money <42.25 << tbc
.skill riding,75,1
step << Undead !Warlock
.goto Tirisfal Glades,59.87,52.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zachariah|r
+|cRXP_BUY_Buy any|r |T132264:0|t[Skeletal Horse] |cRXP_BUY_that you like from him|r
.target Zachariah Post
.itemcount 13331,<1 
.itemcount 13332,<1 
.itemcount 13333,<1 
.itemcount 46308,<1 
.money <0.9 << wotlk
.money <9.0000 << tbc
.skill riding,<75,1
step << Undead !Warlock
.cast 55884 >> Use the |T132264:0|t[Red Skeletal Horse] to learn it
.use 13331
.itemcount 13331,1
.skill riding,75,1
step << Undead !Warlock
.cast 55884 >> Use the |T132264:0|t[Blue Skeletal Horse] to learn it
.use 13332
.itemcount 13332,1
.skill riding,75,1
step << Undead !Warlock
.cast 55884 >> Use the |T132264:0|t[Brown Skeletal Horse] to learn it
.use 13333
.itemcount 13333,1
.skill riding,75,1
step << Undead !Warlock
.cast 55884 >> Use the |T132264:0|t[Black Skeletal Horse] to learn it
.use 46308
.itemcount 46308,1
.skill riding,75,1
step << Undead !Warlock
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132264:0|t[Red Skeletal Horse] |cRXP_WARN_onto your Action Bars|r
.cast 17462 >> Mount your |T132264:0|t[Red Skeletal Horse]
.train 17462,3
.zoneskip Undercity
.zoneskip Durotar
.zoneskip Orgrimmar
step << Undead !Warlock
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132264:0|t[Blue Skeletal Horse] |cRXP_WARN_onto your Action Bars|r
.cast 17463 >> Mount your |T132264:0|t[Blue Skeletal Horse]
.train 17463,3
.zoneskip Undercity
.zoneskip Durotar
.zoneskip Orgrimmar
step << Undead !Warlock
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132264:0|t[Brown Skeletal Horse] |cRXP_WARN_onto your Action Bars|r
.cast 17464 >> Mount your |T132264:0|t[Brown Skeletal Horse]
.train 17464,3
.zoneskip Undercity
.zoneskip Durotar
.zoneskip Orgrimmar
step << Undead !Warlock wotlk
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132264:0|t[Black Skeletal Horse] |cRXP_WARN_onto your Action Bars|r
.cast 64977 >> Mount your |T132264:0|t[Black Skeletal Horse]
.train 64977,3
.zoneskip Undercity
.zoneskip Durotar
.zoneskip Orgrimmar
step << Druid
#completewith next
.cast 18960 >> Cast |T135758:0|t[Teleport: Moonglade]
.zoneskip Moonglade
.xp <32,1
step << Druid
.goto Moonglade,52.53,40.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 6778 >> Train your class spells
.target Loganaar
.xp <32,1
]])
RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Horde
#name 32-32 Thousand Needles II JJ
#version 23
#group RestedXP Horde 30-45
#next 32-34 Shimmering Flats JJ
#xprate >1.4999
step << !Mage
#xprate <1.7
.hs >> Hearth to Orgrimmar
.zoneskip Orgrimmar
.zoneskip The Barrens
step << Hunter/Shaman/Priest
#completewith OrgTrain32
.goto Orgrimmar,50.68,61.69,35,0 << Hunter
.goto Orgrimmar,52.96,58.10,35,0 << Hunter
.goto Orgrimmar,56.02,56.88,35,0 << Hunter
.goto Orgrimmar,63.02,39.23,20,0 << Hunter
.goto Orgrimmar,64.32,38.11,20,0 << Hunter
.goto Orgrimmar,66.11,40.01,20,0 << Hunter
.goto Orgrimmar,72.23,23.56,30,0 << Hunter
.goto Orgrimmar,72.15,21.09,30,0 << Hunter
.goto Orgrimmar,67.53,14.87,20,0 << Hunter
.goto Orgrimmar,47.41,65.07,10,0 << Priest/Shaman
.goto Orgrimmar,46.59,64.54,6,0 << Priest/Shaman
.goto Orgrimmar,46.75,63.84,6,0 << Priest/Shaman
.goto Orgrimmar,46.59,64.54,6,0 << Priest/Shaman
.goto Orgrimmar,46.75,63.84,6,0 << Priest/Shaman
.goto Orgrimmar,46.59,64.54,6,0 << Priest/Shaman
.goto Orgrimmar,46.75,63.84,6,0 << Priest/Shaman
.goto Orgrimmar,41.89,64.39,20,0 << Priest/Shaman
.goto Orgrimmar,38.65,56.58,25,0 << Shaman
.goto Orgrimmar,38.78,54.87,25,0 << Shaman
.goto Orgrimmar,40.94,45.20,25,0 << Shaman
.goto Orgrimmar,42.30,37.44,30,0 << Shaman
.goto Orgrimmar,39.58,75.87,20,0 << Priest
.goto Orgrimmar,66.05,18.52,15 >> Travel toward |cRXP_FRIENDLY_Ormak|r << Hunter
.goto Orgrimmar,38.81,36.38,15 >> Travel toward |cRXP_FRIENDLY_Kardris|r << Shaman
.goto Orgrimmar,35.59,87.80,15 >> Travel toward |cRXP_FRIENDLY_Ur'kyo|r << Priest
step << skip
#xprate <1.7
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14263 >> Train your class spells
.target Ormak Grimshot
.xp <32,1
.xp >34,1

step << Hunter
#label OrgTrain32
#xprate <1.7
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 13813 >> Train your class spells
.target Ormak Grimshot
.xp <34,1
step << Shaman
#xprate <1.7
#label OrgTrain32 << tbc
.goto Orgrimmar,38.81,36.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 8499 >> Train your class spells
.target Kardris Dreamseeker
.xp <32,1
.xp >34,1 << wotlk
step << Shaman wotlk
#label OrgTrain32
#xprate <1.7
.goto Orgrimmar,38.81,36.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 52131 >> Train your class spells << wotlk
.target Kardris Dreamseeker
.xp <34,1
step << Priest
#xprate <1.7
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ur'kyo|r
.train 9473 >> Train your class spells
.target Ur'kyo
.xp <32,1
.xp >34,1
step << Priest
#xprate <1.7
#label OrgTrain32
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ur'kyo|r
.train 8105 >> Train your class spells
.target Ur'kyo
.xp <34,1
step << Troll
#completewith CampTStone2
.goto The Barrens,63.08,37.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bragok|r
.fly Camp Taurajo >> Fly to Camp Taurajo
.target Bragok
.zoneskip Orgrimmar
step << Undead/!Mage
#xprate >1.6999
#completewith CampTStone2
.hs >> Hearth to Orgrimmar
.cooldown item,6948,>0
.zoneskip Orgrimmar
step << Mage
#completewith CampTStone2
.cast 3563 >> Cast |T135765:0|t[Teleport: Thunder Bluff]
.zoneskip Thunder Bluff
.zoneskip The Barrens
.zoneskip Thousand Needles
step << Mage
.goto Thunder Bluff,22.77,14.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shymm|r
.train 8422 >> Train your class spells
.target Archmage Shymm
.xp <32,1
.xp >34,1
step << Mage
.goto Thunder Bluff,22.77,14.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shymm|r
.train 8492 >> Train your class spells
.target Archmage Shymm
.xp <34,1
step << Mage
.goto Thunder Bluff,46.22,49.14,6,0
.goto Thunder Bluff,46.01,49.90,6,0
.goto Thunder Bluff,47.00,49.83
>>Go up the tower
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tal|r
.fly Camp Taurajo >> Fly to Camp Taurajo
.target Tal
step << Undead
#xprate >1.6999
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
.cooldown item,6948,<0
.zoneskip Orgrimmar
.zoneskip Thunder Bluff
.zoneskip Thousand Needles
step
#completewith Doras1
.goto Orgrimmar,47.41,65.07,10,0
.goto Orgrimmar,46.59,64.54,6,0
.goto Orgrimmar,46.75,63.84,6,0
.goto Orgrimmar,46.59,64.54,6,0
.goto Orgrimmar,46.75,63.84,6,0
.goto Orgrimmar,46.59,64.54,6,0
.goto Orgrimmar,46.75,63.84,6,0
.goto Orgrimmar,45.12,63.88,10 >>Travel up the tower toward |cRXP_FRIENDLY_Doras|r
step << Warlock
#xprate <1.7
#completewith CampTStone2
.goto Orgrimmar,45.12,63.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Ratchet >> Fly to Ratchet
.target Doras
.zoneskip Orgrimmar,1
.xp <34,1
step << Warlock
#xprate <1.7
.goto The Barrens,62.44,35.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Babagaya|r
.train 7648 >> Train your class spells
.target Babagaya Shadowcleft
.xp <34,1
step << Warlock
#xprate <1.7
#completewith CampTStone2
.goto The Barrens,63.08,37.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bragok|r
.fly Camp Taurajo >> Fly to Camp Taurajo
.target Bragok
.zoneskip Orgrimmar
.xp <34,1
step
#label Doras1
#completewith CampTStone2
.goto Orgrimmar,45.12,63.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Camp Taurajo >> Fly to Camp Taurajo
.target Doras
.zoneskip Orgrimmar,1

step << !Shaman !Warrior
#xprate >1.6999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tatternack|r and |cRXP_FRIENDLY_Jorn|r
.turnin 893 >> Turn in Weapons of Choice
.accept 1153 >> Accept A New Ore Sample
.goto The Barrens,45.10,57.68
.turnin 884 >>Turn in Owatanka
.turnin 885 >>Turn in Washte Pawne
.turnin 897 >>Turn in The Harvester
.goto The Barrens,44.86,59.13
.target Tatternack Steelforge
.target Jorn Skyseer
.isOnQuest 884
.isOnQuest 885
.isOnQuest 897
step << !Shaman !Warrior
#xprate >1.6999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tatternack|r and |cRXP_FRIENDLY_Jorn|r
.turnin 893 >> Turn in Weapons of Choice
.accept 1153 >> Accept A New Ore Sample
.goto The Barrens,45.10,57.68
.turnin 885 >>Turn in Washte Pawne
.turnin 897 >>Turn in The Harvester
.goto The Barrens,44.86,59.13
.target Tatternack Steelforge
.target Jorn Skyseer
.isOnQuest 885
.isOnQuest 897
step << !Shaman !Warrior
#xprate >1.6999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tatternack|r and |cRXP_FRIENDLY_Jorn|r
.turnin 893 >> Turn in Weapons of Choice
.accept 1153 >> Accept A New Ore Sample
.goto The Barrens,45.10,57.68
.turnin 884 >>Turn in Owatanka
.turnin 897 >>Turn in The Harvester
.goto The Barrens,44.86,59.13
.target Tatternack Steelforge
.target Jorn Skyseer
.isOnQuest 884
.isOnQuest 897
step << !Shaman !Warrior
#xprate >1.6999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tatternack|r and |cRXP_FRIENDLY_Jorn|r
.turnin 893 >> Turn in Weapons of Choice
.accept 1153 >> Accept A New Ore Sample
.goto The Barrens,45.10,57.68
.turnin 884 >>Turn in Owatanka
.turnin 885 >>Turn in Washte Pawne
.goto The Barrens,44.86,59.13
.target Tatternack Steelforge
.target Jorn Skyseer
.isOnQuest 884
.isOnQuest 885
step << !Shaman !Warrior
#xprate >1.6999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tatternack|r and |cRXP_FRIENDLY_Jorn|r
.turnin 893 >> Turn in Weapons of Choice
.accept 1153 >> Accept A New Ore Sample
.goto The Barrens,45.10,57.68
.turnin 884 >>Turn in Owatanka
.goto The Barrens,44.86,59.13
.target Tatternack Steelforge
.target Jorn Skyseer
.isOnQuest 884
step << !Shaman !Warrior
#xprate >1.6999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tatternack|r and |cRXP_FRIENDLY_Jorn|r
.turnin 893 >> Turn in Weapons of Choice
.accept 1153 >> Accept A New Ore Sample
.goto The Barrens,45.10,57.68
.turnin 885 >>Turn in Washte Pawne
.goto The Barrens,44.86,59.13
.target Tatternack Steelforge
.target Jorn Skyseer
.isOnQuest 885
step << !Shaman !Warrior
#xprate >1.6999
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tatternack|r and |cRXP_FRIENDLY_Jorn|r
.turnin 893 >> Turn in Weapons of Choice
.accept 1153 >> Accept A New Ore Sample
.goto The Barrens,45.10,57.68
.turnin 897 >>Turn in The Harvester
.goto The Barrens,44.86,59.13
.target Tatternack Steelforge
.target Jorn Skyseer
.isOnQuest 897
step << !Shaman !Warrior
#xprate >1.6999
#label CampTStone2
.goto The Barrens,45.10,57.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tatternack|r
.turnin 893 >> Turn in Weapons of Choice
.accept 1153 >> Accept A New Ore Sample
.target Tatternack Steelforge
step
#xprate <1.7 << !Shaman !Warrior
#label CampTStone2
.goto The Barrens,45.10,57.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tatternack|r
.turnin 1153 >> Turn in A New Ore Sample
.target Tatternack Steelforge
step
#completewith next
.goto The Barrens,44.44,59.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa|r
.fly Freewind Post >> Fly to Freewind Post
.target Omusa Thunderhorn
step
.goto Thousand Needles,45.05,48.90,8,0
.goto Thousand Needles,44.83,48.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elu|r
.turnin 4767 >> Turn in Wind Rider
.target Elu
step << Hunter
.goto Thousand Needles,44.89,50.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Starn|r
.vendor 9551 >>|cRXP_BUY_Buy the|r |T135495:0|t[Dense Shortbow] |cRXP_BUY_if it's up and|r |T132382:0|t[Razor Arrows] |cRXP_BUY_from him|r
.collect 3030,2000,4767,1 
.target Starn
.itemcount 3030,<2000
.money <2.8814
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<18.95

step << Hunter
.goto Thousand Needles,44.89,50.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Starn|r
.vendor 9551 >>|cRXP_BUY_Buy the|r |T135495:0|t[Dense Shortbow] |cRXP_BUY_from him if it's up|r
.target Starn
.money <2.5814
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<18.95
step << Hunter
.goto Thousand Needles,44.89,50.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Starn|r
>>|cRXP_BUY_Buy|r |T132382:0|t[Razor Arrows] |cRXP_BUY_from him|r
.collect 3030,2000,4767,1 
.target Starn
.itemcount 3030,<2000
.money <0.3000
step << Hunter
#completewith next
+Equip the |T135495:0|t[Dense Shortbow]
.use 11305
.itemcount 11305,1
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<18.95
step
#completewith TestofE
.goto Thousand Needles,46.07,51.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Abeqwa|r
.home >> Set your Hearthstone to Freewind Post
.target Innkeeper Abeqwa
step
.goto Thousand Needles,46.07,51.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Abeqwa|r
>>|cRXP_BUY_Buy|r |T132799:0|t[Sweet Nectar] |cRXP_BUY_from him|r << Priest/Mage/Warlock/Druid
>>|cRXP_BUY_Buy|r |T133994:0|t[Stormwind Brie] |cRXP_BUY_from him|r << !Priest !Mage !Warlock !Druid !Paladin
>>|cRXP_BUY_Buy|r |T132799:0|t[Sweet Nectar] |cRXP_BUY_and|r |T133994:0|t[Stormwind Brie] |cRXP_BUY_from him|r << Paladin
.collect 1708,20,1145,1 << Priest/Mage/Warlock/Druid/Paladin 
.collect 1707,20,1145,1 << !Priest !Mage !Warlock !Druid !Paladin 
.collect 1707,10,1145,1 << Paladin 
.target Innkeeper Abeqwa
.money <0.4000 << !Paladin
.money <0.6000 << Paladin/Shaman
.xp <24,1
.xp >35,1
step
.goto Thousand Needles,46.21,50.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Elosai|r
.turnin 9434 >> Turn in Testing the Tonic
.target Magistrix Elosai
step
#completewith next
.goto Thousand Needles,54.57,44.36,12,0
.goto Thousand Needles,53.71,42.59,10,0 << !Shaman
.goto Thousand Needles,53.95,41.49,10 >>Travel toward |cRXP_FRIENDLY_Dorn|r << !Shaman
.goto Thousand Needles,53.54,42.65,10 >>Travel toward |cRXP_FRIENDLY_Prate|r << Shaman
step
#label TestofE
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Prate|r and |cRXP_FRIENDLY_Dorn|r << Shaman
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dorn|r << !Shaman
.turnin 1531 >> Turn in Call of Air << Shaman
.goto Thousand Needles,53.54,42.65 << Shaman
.turnin 1150 >> Turn in Test of Endurance
.accept 1151 >> Accept Test of Strength
.goto Thousand Needles,53.95,41.49
.target Prate Cloudseer << Shaman
.target Dorn Plainstalker
step
#completewith next
.goto Thousand Needles,31.30,36.87,20,0
.goto Thousand Needles,33.12,35.30,15,0
.goto Thousand Needles,32.92,32.51,15,0
.goto Thousand Needles,31.97,31.34,15,0
.goto Thousand Needles,32.28,28.59,15,0
.goto Thousand Needles,32.51,27.28,15,0
.goto Thousand Needles,33.30,28.62,15,0
.goto Thousand Needles,33.30,28.62,15,0
.goto Thousand Needles,34.87,31.85,15,0
.goto Thousand Needles,34.12,35.79,15,0
.goto Thousand Needles,33.26,36.25,15,0
.goto Thousand Needles,32.35,33.46,15,0
.goto Thousand Needles,31.78,32.58,10 >>Travel toward |cRXP_PICK_Document Chest #1|r
step
.goto Thousand Needles,31.78,32.58
>>Open the |cRXP_PICK_Document Chest #1|r. Loot it for the |cRXP_LOOT_Secret Note #1|r
.complete 5064,1 
step
#completewith next
.goto Thousand Needles,32.35,33.46,15,0
.goto Thousand Needles,33.23,36.41,15,0
.goto Thousand Needles,34.07,39.57,10,0
.goto Thousand Needles,33.77,39.98,10 >>Travel toward |cRXP_PICK_Document Chest #2|r
step
.goto Thousand Needles,33.77,39.98
>>Open the |cRXP_PICK_Document Chest #2|r. Loot it for the |cRXP_LOOT_Secret Note #2|r
.complete 5064,2 
step
#completewith next
.goto Thousand Needles,35.81,39.48,15,0
.goto Thousand Needles,38.38,40.53,15,0
.goto Thousand Needles,39.00,41.19,10,0
.goto Thousand Needles,39.35,41.52,10 >>Travel toward |cRXP_PICK_Document Chest #3|r
step
.goto Thousand Needles,39.35,41.52
>>Open the |cRXP_PICK_Document Chest #3|r. Loot it for the |cRXP_LOOT_Secret Note #3|r
.complete 5064,3 
step
#completewith next
.goto Thousand Needles,38.38,40.53,15,0
.goto Thousand Needles,35.67,39.24,15,0
.goto Thousand Needles,34.32,35.71,15,0
.goto Thousand Needles,35.02,31.78,15,0
.goto Thousand Needles,35.68,31.02,15,0
.goto Thousand Needles,36.92,31.84,15,0
.goto Thousand Needles,37.17,33.10,15,0
.goto Thousand Needles,37.77,34.99,15,0
.goto Thousand Needles,38.06,35.35,12 >>Travel toward the |cRXP_PICK_Sacred Fire of Life|r
step
.goto Thousand Needles,38.06,35.35
.cast 16996 >>Click the |cRXP_PICK_Sacred Fire of Life|r to summon |cRXP_ENEMY_Arikara|r
.timer 5,Arikara RP
.isOnQuest 5088
step
.goto Thousand Needles,38.22,35.48
>>|cRXP_WARN_Wait out the RP|r
>>Kill |cRXP_ENEMY_Arikara|r. Loot her for her |cRXP_LOOT_Serpent Skin|r
.complete 5088,1 
.complete 5088,2 
.mob Arikara

step
#completewith next
.goto Thousand Needles,37.77,34.99,15,0
.goto Thousand Needles,37.16,33.15,15,0
.goto Thousand Needles,37.72,31.46,15,0
.goto Thousand Needles,38.98,29.43,15,0
.goto Thousand Needles,38.07,26.74,30 >>Travel towards |cRXP_ENEMY_Arnak Grimtotem|r
step
.goto Thousand Needles,38.28,26.80,10,0
.goto Thousand Needles,38.07,26.74
>>Kill |cRXP_ENEMY_Arnak Grimtotem|r. Loot him for his |cRXP_LOOT_Hoof|r
.complete 5147,1 
.mob Arnak Grimtotem
step << skip
.goto Thousand Needles,37.98,26.59,8,0
.goto Thousand Needles,37.95,26.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lakota|r
.accept 4904 >> Accept Free at Last
.target Lakota Windsong

step << skip
>>Follow Lakota and protect her through the whole escort. Mobs will spawn periodically on the platforms.
.goto Thousand Needles,30.7,37.1
.complete 4904,1 
step << Mage/Paladin
#completewith Gizmo
.cast 1953 >> |cRXP_WARN_Jump down. Cast|r |T135736:0|t[Blink] |cRXP_WARN_just before hitting the bottom to avoid taking fall damage|r << Mage
.cast 5599 >> |cRXP_WARN_Jump down. Cast|r |T135964:0|t[Blessing of Protection] |cRXP_WARN_just before hitting the bottom to avoid taking fall damage|r << Paladin

step << !Mage !Paladin
#completewith next
.goto Thousand Needles,38.98,29.43,15,0
.goto Thousand Needles,37.56,31.46,15,0
.goto Thousand Needles,36.88,32.79,15,0
.goto Thousand Needles,35.96,34.38,20 >>Jump into the water below. If you die, run back to your corpse
>>|cRXP_WARN_Avoid the |cRXP_ENEMY_Scalding Elementals|r and|r |cRXP_ENEMY_Boiling Elementals|r

step
#completewith next
.goto Thousand Needles,22.75,24.63
.cast 17176 >>Click the |cRXP_PICK_Panther Cage|r to turn the |cRXP_ENEMY_Enraged Panther|r hostile
step
#label Gizmo
.goto Thousand Needles,22.75,24.63
>>Kill the |cRXP_ENEMY_Enraged Panther|r. Loot him for the |cRXP_LOOT_Hypercapacitor Gizmo|r
>>|cRXP_WARN_Make sure you have your cooldowns available|r
>>|cRXP_WARN_Find a group for him if needed|r
.complete 5151,1 
.mob Enraged Panther
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kanati|r, |cRXP_FRIENDLY_Motega|r, and |cRXP_FRIENDLY_Wizlo|r
>>|cRXP_WARN_Turn in quickly, as turning in "Assassination Plot" will summon three |cRXP_ENEMY_Galak Assassins|r that you have to protect |cRXP_FRIENDLY_Kanati|r from|r
.turnin 4881 >> Turn in Assassination Plot
.accept 4966 >> Accept Protect Kanati Greycloud
.goto Thousand Needles,21.25,32.05
.turnin 5088 >> Turn in Arikara
.goto Thousand Needles,21.43,32.35,5,0
.goto Thousand Needles,21.54,32.35
.turnin 5151 >> Turn in Hypercapacitor Gizmo
.goto Thousand Needles,21.43,32.55
.target Kanati Greycloud
.target Motega Firemane
.target Wizlo Bearingshiner
.isOnQuest 4881
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kanati|r, |cRXP_FRIENDLY_Motega|r, and |cRXP_FRIENDLY_Wizlo|r
>>|cRXP_WARN_Turn in quickly, as turning in "Assassination Plot" will summon three |cRXP_ENEMY_Galak Assassins|r that you have to protect |cRXP_FRIENDLY_Kanati|r from|r
.accept 4966 >> Accept Protect Kanati Greycloud
.goto Thousand Needles,21.25,32.05
.turnin 5088 >> Turn in Arikara
.goto Thousand Needles,21.43,32.35,5,0
.goto Thousand Needles,21.54,32.35
.turnin 5151 >> Turn in Hypercapacitor Gizmo
.goto Thousand Needles,21.43,32.55
.target Kanati Greycloud
.target Motega Firemane
.target Wizlo Bearingshiner
.isQuestTurnedIn 4881
.isQuestAvailable 4966
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Motega|r and |cRXP_FRIENDLY_Wizlo|r
.turnin 5088 >> Turn in Arikara
.goto Thousand Needles,21.43,32.35,5,0
.goto Thousand Needles,21.54,32.35
.turnin 5151 >> Turn in Hypercapacitor Gizmo
.goto Thousand Needles,21.43,32.55
.target Kanati Greycloud
.target Motega Firemane
.target Wizlo Bearingshiner
step
.goto Thousand Needles,21.25,32.05
>>Kill the |cRXP_ENEMY_Galak Assassins|r to protect |cRXP_FRIENDLY_Kanati|r
.complete 4966,1 
.mob Galak Assassin
.isOnQuest 4966
step
.goto Thousand Needles,21.25,32.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kanati|r
.turnin 4966 >> Turn in Protect Kanati Greycloud
.isQuestComplete 4966
step
.goto Thousand Needles,10.92,22.28,40,0
.goto Thousand Needles,10.60,22.80,40,0
.goto Thousand Needles,12.96,26.67,40,0
.goto Thousand Needles,17.18,37.08,40,0
.goto Thousand Needles,16.90,37.80,40,0
.goto Thousand Needles,21.22,39.04,40,0
.goto Thousand Needles,21.92,38.62,40,0
.goto Thousand Needles,25.43,41.71,40,0
.goto Thousand Needles,25.77,41.44,40,0
.goto Thousand Needles,10.92,22.28,40,0
.goto Thousand Needles,10.60,22.80,40,0
.goto Thousand Needles,12.96,26.67,40,0
.goto Thousand Needles,17.18,37.08,40,0
.goto Thousand Needles,16.90,37.80,40,0
.goto Thousand Needles,21.22,39.04,40,0
.goto Thousand Needles,21.92,38.62,40,0
.goto Thousand Needles,25.43,41.71,40,0
.goto Thousand Needles,25.77,41.44
>>Kill |cRXP_ENEMY_Rok'Alim the Pounder|r. Loot him for the |cRXP_LOOT_Fragments of Rok'Alim|r
>>|cRXP_ENEMY_Rok'Alim|r is immune to Nature damage << Shaman/Druid
.unitscan Rok'Alim the Pounder
.complete 1151,1 
step
#completewith FreewindEnd
.hs >> Hearth to Freewind Post
.cooldown item,6948,>0
step
#completewith FreewindEnd
.goto Thousand Needles,46.73,48.27,30 >> Travel to Freewind Post's Elevators
.cooldown item,6948,<0
step
#completewith FreewindEnd
.goto Thousand Needles,45.91,49.91,25 >> Take the Elevator up to Freewind
.cooldown item,6948,<0
step
.goto Thousand Needles,46.07,51.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Abeqwa|r
>>|cRXP_BUY_Buy|r |T132799:0|t[Sweet Nectar] |cRXP_BUY_from him|r << Priest/Mage/Warlock/Druid
>>|cRXP_BUY_Buy|r |T133994:0|t[Stormwind Brie] |cRXP_BUY_from him|r << !Priest !Mage !Warlock !Druid !Paladin
>>|cRXP_BUY_Buy|r |T132799:0|t[Sweet Nectar] |cRXP_BUY_and|r |T133994:0|t[Stormwind Brie] |cRXP_BUY_from him|r << Paladin
.collect 1708,20,1145,1 << Priest/Mage/Warlock/Druid/Paladin 
.collect 1707,20,1145,1 << !Priest !Mage !Warlock !Druid !Paladin 
.collect 1707,10,1145,1 << Paladin 
.target Innkeeper Abeqwa
.money <0.4000 << !Paladin
.money <0.6000 << Paladin/Shaman
.xp <24,1
.xp >35,1
step
#label FreewindEnd
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Longhorn|r
.goto Thousand Needles,45.70,50.63,8,0
.goto Thousand Needles,45.65,50.80
.turnin 5064 >> Turn in Grimtotem Spying
.turnin 5147 >> Turn in Wanted - Arnak Grimtotem
.target Cliffwatcher Longhorn
step << skip
.goto Thousand Needles,46.0,51.5
.target Thalia Amberhide
>>Talk to |cRXP_FRIENDLY_Thalia Amberhide|r
.turnin 4904 >> Turn in Free at Last
step << Warlock
#xprate <1.7
#completewith Manuscript
.goto Thousand Needles,44.12,37.22,20 >>Enter the cave
step << Warlock
#xprate <1.7
#completewith Manuscript
.goto Thousand Needles,44.41,36.40,20,0
.goto Thousand Needles,44.20,35.00,20,0
.goto Thousand Needles,44.31,32.87,20,0
.goto Thousand Needles,43.44,32.69,15 >>Travel toward the |cRXP_PICK_Damaged Chest|r
step << Warlock
#xprate <1.7
.goto Thousand Needles,43.44,32.69
>>Open the |cRXP_PICK_Damaged Chest|r on the ground. Loot it for the |cRXP_LOOT_Tattered Manuscript|r
.complete 1803,2 
step << Warlock
#xprate <1.7
#completewith next
.goto Thousand Needles,44.12,37.22,20 >>Exit the cave
step
#completewith next
.goto Thousand Needles,54.57,44.36,12,0
.goto Thousand Needles,53.71,42.59,10,0
.goto Thousand Needles,53.95,41.49,10 >>Travel toward |cRXP_FRIENDLY_Dorn|r
step
.goto Thousand Needles,53.95,41.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dorn|r
.turnin 1151 >> Turn in Test of Strength
.target Dorn Plainstalker
step << !Shaman !Warrior
#xprate >1.6999
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
.goto Thousand Needles,51.89,43.02
>>Kill |cRXP_ENEMY_Gravelsnout Surveyors|r, |cRXP_ENEMY_Gravelsnout Diggers|r, and |cRXP_ENEMY_Gibblesnik|r (if he's up). Loot them for an |cRXP_LOOT_Ore Sample|r
.complete 1153,1 
.unitscan Gravelsnout Digger;Gravelsnout Surveyor;Gibblesnik
step
.goto Thousand Needles,67.59,63.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Moktar|r
.turnin 1146 >> Turn in The Swarm Grows
.accept 1147 >> Accept The Swarm Grows
.target Moktar Krin
]])
RXPGuides.RegisterGuide([[
#tbc
#wotlk
<< Horde
#name 32-34 Shimmering Flats JJ
#version 23
#group RestedXP Horde 30-45
#next 34-38 Stranglethorn Vale / Dustwallow
#xprate >1.4999
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kravel|r, |cRXP_FRIENDLY_Fizzle|r, |cRXP_FRIENDLY_Wizzle|r, |cRXP_FRIENDLY_Pozzik|r, and |cRXP_FRIENDLY_Zherin|r
.accept 1110 >> Accept Rocket Car Parts
.accept 1111 >> Accept Wharfmaster Dizzywig
.accept 5762 >> Accept Hemet Nesingwary Jr.
.goto Thousand Needles,77.78,77.27
.accept 1104 >> Accept Salt Flat Venom
.goto Thousand Needles,78.06,77.12
.accept 1105 >> Accept Hardened Shells
.goto Thousand Needles,78.14,77.12
.accept 1176 >> Accept Load Lightening
.goto Thousand Needles,80.18,75.88
.accept 1175 >> Accept A Bump in the Road
.goto Thousand Needles,81.63,77.95
.target Kravel Koalbeard
.target Fizzle Brassbolts
.target Wizzle Brassbolts
.target Pozzik
.target Trackmaster Zherin
step
>>Loot |cRXP_LOOT_Rocket Car Parts|r on the ground
>>Kill |cRXP_ENEMY_Scorpid Reavers|r and |cRXP_ENEMY_Scorpid Terrors|r. Loot them for their |cRXP_LOOT_Venom|r
>>Kill |cRXP_ENEMY_Sparkleshell Tortoises|r and |cRXP_ENEMY_Sparkleshell Borers|r. Loot them for their |cRXP_LOOT_Hardened Tortoise Shells|r
>>|cRXP_WARN_Try to avoid killing |cRXP_ENEMY_Sparkleshell Snappers|r as they are very tanky|r
>>Kill |cRXP_ENEMY_Saltstone Basilisks|r
>>Kill |cRXP_ENEMY_Salt Flats Scavengers|r. Loot them for their |cRXP_LOOT_Bones|r
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Salt Flats Scavengers|r cast|r |T135358:0|t[Execute] |cRXP_WARN_when you're 20% or less health|r << Rogue/Warrior
>>Kill |cRXP_ENEMY_Saltstone Crystalhides|r and |cRXP_ENEMY_Saltstone Gazers|r
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Saltstone Crystalhides|r cast|r |T136170:0|t[Mana Burn] << !Rogue !Warrior
>>|cRXP_WARN_Be careful as |cRXP_ENEMY_Saltstone Gazers|r cast|r |T132154:0|t[Crystal Gaze] |cRXP_WARN_(run out of melee)|r
.complete 1110,1 
.goto Thousand Needles,84.06,82.00,60,0
.goto Thousand Needles,88.56,76.96,60,0
.goto Thousand Needles,86.90,72.23,60,0
.goto Thousand Needles,88.12,67.69,60,0
.goto Thousand Needles,87.82,65.82,60,0
.goto Thousand Needles,78.84,62.51,80,0
.goto Thousand Needles,85.99,59.45,60,0
.goto Thousand Needles,83.31,54.46,60,0
.goto Thousand Needles,80.82,55.68,60,0
.goto Thousand Needles,79.48,52.60,60,0
.goto Thousand Needles,76.29,52.98,60,0
.goto Thousand Needles,71.64,55.30,60,0
.goto Thousand Needles,69.26,61.49,60,0
.goto Thousand Needles,69.51,65.98,60,0
.goto Thousand Needles,71.64,73.36,60,0
.goto Thousand Needles,73.23,80.90,60,0
.loop 50,Thousand Needles,84.06,82.00,88.56,76.96,86.90,72.23,88.12,67.69,87.82,65.82,85.99,59.45,83.31,54.46,80.82,55.68,79.48,52.60,76.29,52.98,71.64,55.30,69.26,61.49,69.51,65.98,71.64,73.36,73.23,80.90,84.06,82.00
.complete 1104,1 
.goto Thousand Needles,71.59,74.22,50,0
.loop 50,Thousand Needles,71.59,74.22,71.05,72.56,70.97,68.79,69.47,64.42,71.99,65.92,74.95,64.90,73.44,61.91,72.42,59.43,71.77,58.10,74.55,58.53,74.34,54.34,75.87,54.27,75.88,51.16,77.71,51.40,78.57,52.74,78.86,54.73,82.85,59.98,83.95,62.60,82.78,66.31,83.71,71.62,82.64,73.35,76.97,73.71,72.38,73.30,71.59,74.22
.complete 1105,1 
.loop 50,Thousand Needles,69.47,67.05,70.11,65.82,70.76,63.39,69.37,59.98,73.20,58.42,74.54,62.91,75.42,64.24,74.98,61.38,76.74,59.03,74.12,55.34,74.98,52.08,77.22,54.11,81.26,52.82,82.02,54.40,82.86,54.82,83.99,54.20,83.26,57.79,83.64,60.36,80.21,66.44,77.20,68.33,76.43,70.35,77.57,72.28,76.46,72.50,69.47,67.05
.complete 1175,1 
.loop 50,Thousand Needles,69.70,68.11,71.13,65.70,71.33,64.91,68.79,61.48,69.82,60.22,73.89,59.61,73.38,56.68,74.26,53.25,76.44,52.17,76.64,54.47,76.17,56.48,76.80,57.41,75.46,57.28,75.83,62.30,77.22,60.80,77.83,59.58,78.58,59.12,78.46,61.48,80.85,60.42,80.47,64.47,79.14,63.59,79.37,65.60,77.59,65.11,78.13,63.27,71.70,67.52,69.70,68.11
.complete 1176,1 
.goto Thousand Needles,87.95,66.84,50,0
.loop 50,Thousand Needles,87.43,64.71,81.56,53.92,78.02,59.83,75.62,60.40,72.38,73.00,70.81,76.29,77.19,84.12,78.63,84.96,81.46,85.87,84.06,82.05,84.51,81.85,83.47,76.62,87.95,66.84,87.43,64.71
.complete 1175,2 
.loop 50,Thousand Needles,77.53,83.48,76.55,84.70,76.21,86.62,77.62,86.46,77.66,87.96,77.74,90.18,78.54,89.69,79.08,88.67,79.42,89.56,80.25,88.76,79.35,87.11,78.73,86.84,79.10,85.83,77.53,83.48
.complete 1175,3 
.loop 50,Thousand Needles,77.53,83.48,76.55,84.70,76.21,86.62,77.62,86.46,77.66,87.96,77.74,90.18,78.54,89.69,79.08,88.67,79.42,89.56,80.25,88.76,79.35,87.11,78.73,86.84,79.10,85.83,77.53,83.48
.mob Scorpid Reaver
.mob Scorpid Terror
.mob Salt Flats Scavenger
.mob Sparkleshell Tortoise
.mob Sparkleshell Borer
.mob Sparkleshell Snapper
.mob Saltstone Basilisk
.mob Saltstone Crystalhide
.mob Saltstone Gazer
step
.loop 45,Thousand Needles,70.58,82.39,71.81,83.64,71.09,86.04,71.00,86.90,70.07,86.97,70.20,88.51,69.20,89.23,68.53,88.14,67.99,87.07,67.96,85.92,65.65,86.30,65.15,85.17,63.87,85.92,65.15,85.17,65.65,86.30,67.96,85.92,67.38,83.63,67.07,82.42,68.09,81.75,69.63,81.21,70.58,82.39
>>Kill |cRXP_ENEMY_Silithid Searchers|r, |cRXP_ENEMY_Silithid Hive Drones|r, |cRXP_ENEMY_Silithid Invaders|r, and the |cRXP_ENEMY_Silithid Ravager|r (if it's up). Loot them for the |T135034:0|t[|cRXP_LOOT_Cracked Silithid Carapace|r]
>>|cRXP_WARN_Use the |T135034:0|t[|cRXP_LOOT_Cracked Silithid Carapace|r] to start the quest|r
.collect 5877,1,1148,1 
.accept 1148 >> Accept Parts of the Swarm
.use 5877
.mob Silithid Searcher
.mob Silithid Hive Drone
.mob Silithid Invader
.unitscan Silithid Ravager
step
#completewith next
.loop 45,Thousand Needles,70.58,82.39,71.81,83.64,71.09,86.04,71.00,86.90,70.07,86.97,70.20,88.51,69.20,89.23,68.53,88.14,67.99,87.07,67.96,85.92,65.65,86.30,65.15,85.17,63.87,85.92,65.15,85.17,65.65,86.30,67.96,85.92,67.38,83.63,67.07,82.42,68.09,81.75,69.63,81.21,70.58,82.39
>>Kill |cRXP_ENEMY_Silithid Hive Drones|r, |cRXP_ENEMY_Silithid Searchers|r, |cRXP_ENEMY_Silithid Invaders|r, and the |cRXP_ENEMY_Silithid Ravager|r (if it's up). Loot them for their |cRXP_LOOT_Silithid Hearts|r, |cRXP_LOOT_Silithid Talons|r, and |cRXP_LOOT_Intact Silithid Carapaces|r
.complete 1147,1 
.complete 1147,2 
.complete 1148,1 
.complete 1148,2 
.complete 1148,3 
.mob Silithid Hive Drone
.mob Silithid Searcher
.unitscan Silithid Ravager
step
.goto Thousand Needles,66.90,86.18,40,0
.goto Thousand Needles,65.77,86.21,20,0
.goto Thousand Needles,65.12,85.16,20,0
.goto Thousand Needles,63.52,85.80,40,0
.goto Thousand Needles,66.90,86.18,50,0
>>Kill |cRXP_ENEMY_Silithid Invaders|r inside the cave. They share spawns with the |cRXP_ENEMY_Silithid Hive Drones|r inside the cave
>>|cRXP_WARN_You may need to return to the cave a second time|r
.complete 1147,3 
.mob Silithid Invader
step
#completewith next
>>Kill |cRXP_ENEMY_Silithid Hive Drones|r, |cRXP_ENEMY_Silithid Searchers|r, |cRXP_ENEMY_Silithid Invaders|r, and the |cRXP_ENEMY_Silithid Ravager|r (if it's up). Loot them for their |cRXP_LOOT_Silithid Hearts|r, |cRXP_LOOT_Silithid Talons|r, and |cRXP_LOOT_Intact Silithid Carapaces|r
.complete 1147,2 
.complete 1148,1 
.complete 1148,2 
.complete 1148,3 
.mob Silithid Hive Drone
.mob Silithid Invader
.unitscan Silithid Ravager
step
.loop 45,Thousand Needles,70.58,82.39,71.81,83.64,71.09,86.04,71.00,86.90,70.07,86.97,70.20,88.51,69.20,89.23,68.53,88.14,67.99,87.07,67.96,85.92,67.96,85.92,67.38,83.63,67.07,82.42,68.09,81.75,69.63,81.21,70.58,82.39
>>Kill |cRXP_ENEMY_Silithid Searchers|r outside the cave
.complete 1147,1 
.mob Silithid Searcher
step
.loop 45,Thousand Needles,70.58,82.39,71.81,83.64,71.09,86.04,71.00,86.90,70.07,86.97,70.20,88.51,69.20,89.23,68.53,88.14,67.99,87.07,67.96,85.92,65.65,86.30,65.15,85.17,63.87,85.92,65.15,85.17,65.65,86.30,67.96,85.92,67.38,83.63,67.07,82.42,68.09,81.75,69.63,81.21,70.58,82.39
>>Kill |cRXP_ENEMY_Silithid Hive Drones|r, |cRXP_ENEMY_Silithid Searchers|r outside the cave, |cRXP_ENEMY_Silithid Invaders|r inside the cave, and the |cRXP_ENEMY_Silithid Ravager|r (if it's up). Loot them for their |cRXP_LOOT_Silithid Hearts|r, |cRXP_LOOT_Silithid Talons|r, and |cRXP_LOOT_Intact Silithid Carapaces|r
.complete 1147,2 
.complete 1148,1 
.complete 1148,2 
.complete 1148,3 
.mob Silithid Hive Drone
.mob Silithid Searcher
.mob Silithid Invader
.unitscan Silithid Ravager
step
.goto Thousand Needles,67.59,63.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Moktar|r
.turnin 1147 >> Turn in The Swarm Grows
.target Moktar Krin
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kravel|r, |cRXP_FRIENDLY_Fizzle|r, |cRXP_FRIENDLY_Wizzle|r, |cRXP_FRIENDLY_Pozzik|r, and |cRXP_FRIENDLY_Zherin|r
.turnin 1110 >> Turn in Rocket Car Parts
.goto Thousand Needles,77.78,77.27
.turnin 1104 >> Turn in Salt Flat Venom
.goto Thousand Needles,78.06,77.12
.turnin 1105 >> Turn in Hardened Shells
.accept 1107 >> Accept Encrusted Tail Fins << Druid/Warlock
.goto Thousand Needles,78.14,77.12
.accept 1106 >> Accept Martek the Exiled
.goto Thousand Needles,78.06,77.12
.turnin 1176 >> Turn in Load Lightening
.accept 1178 >> Accept Goblin Sponsorship
.goto Thousand Needles,80.18,75.88
.turnin 1175 >> Turn in A Bump in the Road
.goto Thousand Needles,81.63,77.95
.target Kravel Koalbeard
.target Fizzle Brassbolts
.target Wizzle Brassbolts
.target Pozzik
.target Trackmaster Zherin
step
#completewith Bulkrek
.abandon 1152 >> Abandon Test of Lore
step
.loop 50,Thousand Needles,77.53,83.48,76.55,84.70,76.21,86.62,77.62,86.46,77.66,87.96,77.74,90.18,78.54,89.69,79.08,88.67,79.42,89.56,80.25,88.76,79.35,87.11,78.73,86.84,79.10,85.83,77.53,83.48
.xp 32 >> Grind to 32
step
#completewith next
.goto Thousand Needles,74.36,93.86,30,0
.goto Thousand Needles,74.43,95.46,25,0
.goto Tanaris,51.14,20.85,30,0
.goto Tanaris,51.02,23.76,40,0
.goto Tanaris,51.60,25.44,30 >>Travel toward |cRXP_FRIENDLY_Bulkrek|r
step
#label Bulkrek
.goto Tanaris,51.60,25.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bulkrek|r
.fp Gadgetzan >> Get the Gadgetzan flight path
.target Bulkrek Ragefist
step << Druid
#completewith Moonglade1
.cast 18960 >> Cast |T135758:0|t[Teleport: Moonglade]
.zoneskip Moonglade
.xp <32,1
step << Druid
.goto Moonglade,52.53,40.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 6778 >> Train your class spells
.target Loganaar
.xp <32,1
.xp >34,1
step << Druid
#label Moonglade1
.goto Moonglade,52.53,40.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 3627 >> Train your class spells
.target Loganaar
.xp <34,1
step
#completewith SwarmPT
.hs >> Hearth to Freewind Post
step << Tauren
#completewith next
.goto Thousand Needles,45.14,49.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nyse|r
.fly Thunder Bluff >> Fly to Thunder Bluff
.target Nyse
.zoneskip Thunder Bluff
.skill riding,75,1
step << Tauren
.goto Mulgore,47.65,58.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kar|r
.skill riding,75 >> Train |T136103:0|t[Apprentice Riding] from him
.target Kar Stormsinger
.money <4.5 << wotlk
.money <42.25 << tbc
step << Tauren
.goto Mulgore,47.49,58.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Harb|r
+|cRXP_BUY_Buy any|r |T132243:0|t[Kodo] |cRXP_BUY_that you like from him|r
.target Harb Clawhoof
.itemcount 15277,<1 
.itemcount 15290,<1 
.itemcount 46100,<1 << wotlk 
.money <0.9 << wotlk
.money <9.0000 << tbc
.skill riding,<75,1
step << Tauren
.cast 55884 >> Use the |T132243:0|t[Gray Kodo] to learn it
.use 15277
.itemcount 15277,1
.skill riding,75,1
step << Tauren
.cast 55884 >> Use the |T132245:0|t[Brown Kodo] to learn it
.use 15290
.itemcount 15290,1
.skill riding,75,1
step << Tauren wotlk
.cast 55884 >> Use the |T132243:0|t[White Kodo] to learn it
.use 46100
.itemcount 46100,1
.skill riding,75,1

step << Tauren
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132243:0|t[Gray Kodo] |cRXP_WARN_onto your Action Bars|r
.cast 18989 >> Mount your |T132243:0|t[Gray Kodo]
.train 18989,3
.zoneskip Mulgore,1
step << Tauren
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132245:0|t[Brown Kodo] |cRXP_WARN_onto your Action Bars|r
.cast 18990 >> Mount your |T132245:0|t[Brown Kodo]
.train 18990,3
.zoneskip Mulgore,1
step << Tauren wotlk
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132243:0|t[White Kodo] |cRXP_WARN_onto your Action Bars|r
.cast 64657 >> Mount your |T132243:0|t[White Kodo]
.train 64657,3
.zoneskip Mulgore,1

step << Tauren
#label BarrensTr
#completewith next
.goto The Barrens,41.40,58.55
.zone The Barrens >>Travel to The Barrens
.zoneskip Mulgore,1
step << !Shaman !Warrior
#xprate >1.6999
#requires BarrensTr << Tauren
#completewith next
.goto Thousand Needles,45.14,49.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nyse|r
.fly Camp Taurajo >> Fly to Camp Taurajo
.zoneskip The Barrens
.target Nyse
step << !Shaman !Warrior
#xprate >1.6999
.goto The Barrens,45.10,57.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tatternack|r
.turnin 1153 >> Turn in A New Ore Sample
.target Tatternack Steelforge
step
#xprate <1.7
#requires BarrensTr
#label BarrensFly
#completewith next
.goto Thousand Needles,45.14,49.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nyse|r
.fly Crossroads >> Fly to Crossroads
.target Nyse
.zoneskip The Barrens
step
#requires BarrensFly
.goto The Barrens,44.44,59.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Omusa|r
.fly Crossroads >> Fly to Crossroads
.target Omusa Thunderhorn
step
#label SwarmPT
.goto The Barrens,51.07,29.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Korran|r
.turnin 1148 >> Turn in Parts of the Swarm
.accept 1184 >> Accept Parts of the Swarm
.target Korran
step << Mage
#label TeleportOrg
#completewith PartsOTS
.cast 3567 >> Cast |T135759:0|t[Teleport: Orgrimmar]
.itemcount 17031,1
.zoneskip Orgrimmar
step
#requires TeleportOrg << Mage
#completewith PartsOTS
.goto The Barrens,51.50,30.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Devrak|r
.fly Orgrimmar >> Fly to Orgrimmar
.target Devrak
.zoneskip The Barrens,1
step << Mage
#xprate >1.6999
.goto Orgrimmar,38.45,86.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Deino|r downstairs
.train 8422 >> Train your class spells
.target Deino
.xp <32,1
.xp >34,1
step << Mage
#xprate >1.6999
.goto Orgrimmar,38.45,86.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Deino|r downstairs
.train 8422 >> Train your class spells
.target Deino
.xp <34,1
step << Mage
#xprate <1.7
.goto Orgrimmar,38.45,86.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Deino|r downstairs
.train 8422 >> Train your class spells
.target Deino
.xp <32,1
.xp >34,1
step << Mage
#xprate <1.7
.goto Orgrimmar,38.45,86.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Deino|r downstairs
.train 8422 >> Train your class spells
.target Deino
.xp <34,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ur'kyo|r
.train 9473 >> Train your class spells
.target Ur'kyo
.xp <32,1
.xp >34,1
step << Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ur'kyo|r
.train 8105 >> Train your class spells
.target Ur'kyo
.xp <34,1
step << Shaman
.goto Orgrimmar,38.81,36.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 8499 >> Train your class spells
.target Kardris Dreamseeker
.xp <32,1
.xp >34,1 << wotlk
step << Shaman wotlk
.goto Orgrimmar,38.81,36.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 52131 >> Train your class spells
.target Kardris Dreamseeker
.xp <34,1
step << Paladin
.goto Orgrimmar,32.29,35.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pyreanor|r
.train 19836 >> Train your class spells
.target Master Pyreanor
.xp <32,1
.xp >34,1
step << Paladin
.goto Orgrimmar,32.29,35.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Pyreanor|r
.train 642 >> Train your class spells
.target Master Pyreanor
.xp <34,1
step << Rogue
.goto Orgrimmar,43.90,54.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 8623 >>Train your class spells
.target Ormok
.xp <32,1
.xp >34,1
step << Rogue
.goto Orgrimmar,43.90,54.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormok|r
.train 8696 >>Train your class spells
.target Ormok
.xp <34,1
step << skip
.goto Orgrimmar,47.99,45.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grol'dar|r
.train 6213 >> Train your class spells
.target Grol'dar

step
#completewith next
.goto Orgrimmar,62.56,38.52,20,0 << Paladin/Shaman
.goto Orgrimmar,62.98,39.35,20,0 << !Paladin !Shaman
.goto Orgrimmar,64.34,38.17,20,0
.goto Orgrimmar,75.23,34.24,20 >> Travel toward |cRXP_FRIENDLY_Belgrom|r
step
.goto Orgrimmar,75.23,34.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Belgrom|r
.turnin 1184 >> Turn in Parts of the Swarm
.target Belgrom Rockmaul
step << Warrior
.goto Orgrimmar,80.39,32.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sorek|r
.train 11549 >> Train your class spells
.target Sorek
.xp <32,1
.xp >34,1
step << Warrior
.goto Orgrimmar,80.39,32.38
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Sorek|r
.train 7379 >> Train your class spells
.target Sorek
.xp <34,1
step << Orc !Warlock
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kildar|r and |cRXP_FRIENDLY_Ogunaro|r
.skill riding,75 >> Train |T136103:0|t[Apprentice Riding] from |cRXP_FRIENDLY_Kildar|r
.goto Orgrimmar,69.41,13.11
+|cRXP_BUY_Buy any|r |T132224:0|t[Wolf] |cRXP_BUY_that you like from |cRXP_FRIENDLY_Ogunaro|r|r
.goto Orgrimmar,69.38,12.25
.target Kildar
.target Ogunaro Wolfrunner
.itemcount 1132,<1 
.itemcount 5665,<1 
.itemcount 5668,<1 
.itemcount 46099,<1 << wotlk 
.money <4.5 << wotlk
.money <42.25 << tbc
.skill riding,75,1
step << Orc !Warlock
.cast 55884 >> Use the |T132224:0|t[Horn of the Timber Wolf] to learn it
.use 1132
.itemcount 1132,1
.skill riding,75,1
step << Orc !Warlock
.cast 55884 >> Use the |T132266:0|t[Horn of the Dire Wolf] to learn it
.use 5665
.itemcount 5665,1
.skill riding,75,1
step << Orc !Warlock
.cast 55884 >> Use the |T132224:0|t[Horn of the Brown Wolf] to learn it
.use 5668
.itemcount 5668,1
.skill riding,75,1
step << Orc !Warlock wotlk
.cast 55884 >> Use the |T132224:0|t[Horn of the Black Wolf] to learn it
.use 46099
.itemcount 46099,1
.skill riding,75,1
step << Orc !Warlock
#completewith OrgTrain
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132224:0|t[Timber Wolf] |cRXP_WARN_onto your Action Bars|r
.cast 580 >> Mount your |T132224:0|t[Timber Wolf]
.train 580,3
step << Orc !Warlock
#completewith OrgTrain
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132266:0|t[Dire Wolf] |cRXP_WARN_onto your Action Bars|r
.cast 6653 >> Mount your |T132266:0|t[Dire Wolf]
.train 6653,3
step << Orc !Warlock
#completewith OrgTrain
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132224:0|t[Brown Wolf] |cRXP_WARN_onto your Action Bars|r
.cast 6654 >> Mount your |T132224:0|t[Brown Wolf]
.train 6654,3
step << Orc !Warlock wotlk
#completewith OrgTrain
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132224:0|t[Black Wolf] |cRXP_WARN_onto your Action Bars|r
.cast 64658 >> Mount your |T132224:0|t[Black Wolf]
.train 64658,3
step << skip
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 1543 >> Train your class spells
.target Ormak Grimshot

step
.goto Orgrimmar,54.10,68.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gryshka|r
.home >> Set your Hearthstone to Orgrimmar
.target Innkeeper Gryshka
step << Undead Mage
.cast 3563 >> Cast |T135766:0|t[Teleport: Undercity]
.itemcount 17031,1
.skill riding,75,1
.money <4.5 << wotlk
.money <42.25 << tbc
.train 3563,3
.zoneskip Undercity
.zoneskip Tirisfal Glades
step << Undead Mage
.goto Undercity,82.77,15.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hannah|r
.vendor >>|cRXP_BUY_Buy up to 20|r |T134419:0|t[Runes of Teleportation] |cRXP_BUY_from her|r
.target Horthus
.skill riding,75,1
.money <6.3125 << wotlk
.money <44.05 << tbc
.itemcount 17031,<20
.train 3563,3
.target Hannah Akeley
step << Undead Mage
#completewith next
.goto Undercity,82.28,15.47
.goto Undercity,67.90,15.29,30 >>|cRXP_WARN_Perform a Logout Skip by positioning your character on the highest part of the lowest staircase until it looks like they're floating, then logging out and back in|r
.link https://www.youtube.com/watch?v=-Bi95bCN8dM >> CLICK HERE
.skill riding,75,1
.money <4.5 << wotlk
.money <42.25 << tbc
.train 3563,3
.zoneskip Tirisfal Glades
step << Undead Mage
.goto Undercity,66.21,4.90,15,0
.goto Tirisfal Glades,61.73,64.87
.zone Tirisfal Glades >>Exit Undercity
.skill riding,75,1
.money <4.5 << wotlk
.money <42.25 << tbc
.train 3563,3
step << Undead !Warlock
#completewith next
.goto Orgrimmar,52.26,88.65,30,0
.goto Orgrimmar,49.42,90.90,30,0
.goto Orgrimmar,49.59,94.74,30,0
.goto Durotar,50.61,13.27
.zone Durotar >> Exit Orgrimmar
.money <4.5 << wotlk
.money <42.25 << tbc
.skill riding,75,1
.zoneskip Undercity
.zoneskip Tirisfal Glades
step << Undead !Warlock
.goto Durotar,50.61,13.27,12,0
.goto Durotar,50.82,13.07,6,0
.goto Durotar,50.83,13.27,6,0
.goto Durotar,50.82,13.07,6,0
.goto Durotar,50.83,13.27,6,0
.goto Durotar,50.82,13.07,6,0
.goto Durotar,50.83,13.27,6,0
.goto Durotar,50.89,14.14,-1
.goto Durotar,56.75,15.11,-1
>>Go up the Zeppelin Tower
.zone Tirisfal Glades >>Take the Zeppelin to Tirisfal
.money <4.5 << wotlk
.money <42.25 << tbc
.skill riding,75,1
.zoneskip Undercity
step << Undead !Warlock
.goto Tirisfal Glades,60.08,52.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Velma|r
.skill riding,75 >> Train |T136103:0|t[Apprentice Riding] from her
.target Velma Warnam
.money <4.5 << wotlk
.money <42.25 << tbc
.skill riding,75,1
step << Undead !Warlock
.goto Tirisfal Glades,59.87,52.69
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zachariah|r
+|cRXP_BUY_Buy any|r |T132264:0|t[Skeletal Horse] |cRXP_BUY_that you like from him|r
.target Zachariah Post
.itemcount 13331,<1 
.itemcount 13332,<1 
.itemcount 13333,<1 
.itemcount 46308,<1 
.money <0.9 << wotlk
.money <9.0000 << tbc
.skill riding,<75,1
step << Undead !Warlock
.cast 55884 >> Use the |T132264:0|t[Red Skeletal Horse] to learn it
.use 13331
.itemcount 13331,1
.skill riding,75,1
step << Undead !Warlock
.cast 55884 >> Use the |T132264:0|t[Blue Skeletal Horse] to learn it
.use 13332
.itemcount 13332,1
.skill riding,75,1
step << Undead !Warlock
.cast 55884 >> Use the |T132264:0|t[Brown Skeletal Horse] to learn it
.use 13333
.itemcount 13333,1
.skill riding,75,1
step << Undead !Warlock
.cast 55884 >> Use the |T132264:0|t[Black Skeletal Horse] to learn it
.use 46308
.itemcount 46308,1
.skill riding,75,1
step << Undead !Warlock
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132264:0|t[Red Skeletal Horse] |cRXP_WARN_onto your Action Bars|r
.cast 17462 >> Mount your |T132264:0|t[Red Skeletal Horse]
.train 17472,3
.zoneskip Undercity
.zoneskip Durotar
.zoneskip Orgrimmar
step << Undead !Warlock
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132264:0|t[Blue Skeletal Horse] |cRXP_WARN_onto your Action Bars|r
.cast 17463 >> Mount your |T132264:0|t[Blue Skeletal Horse]
.train 17463,3
.zoneskip Undercity
.zoneskip Durotar
.zoneskip Orgrimmar
step << Undead !Warlock
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132264:0|t[Brown Skeletal Horse] |cRXP_WARN_onto your Action Bars|r
.cast 17464 >> Mount your |T132264:0|t[Brown Skeletal Horse]
.train 17464,3
.zoneskip Undercity
.zoneskip Durotar
.zoneskip Orgrimmar
step << Undead !Warlock wotlk
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132264:0|t[Black Skeletal Horse] |cRXP_WARN_onto your Action Bars|r
.cast 64977 >> Mount your |T132264:0|t[Black Skeletal Horse]
.train 64977,3
.zoneskip Undercity
.zoneskip Durotar
.zoneskip Orgrimmar
step << Undead
#completewith next
.hs >> Hearth to Orgrimmar
.cooldown item,6948,>0
.zoneskip Orgrimmar
step << Undead Mage
#completewith Dizzywig
.cast 3567 >> Cast |T135759:0|t[Teleport: Orgrimmar]
.zoneskip Orgrimmar
step << Troll
#completewith next
.goto Orgrimmar,52.26,88.65,30,0
.goto Orgrimmar,49.42,90.90,30,0
.goto Orgrimmar,48.50,95.12
.zone Durotar >> Exit Orgrimmar
.money <4.5 << wotlk
.money <42.25 << tbc
.zoneskip Orgrimmar,1
.skill riding,75,1
step << Troll
#completewith next
.goto Durotar,49.41,20.97,35,0
.goto Durotar,50.21,26.30,35,0
.goto Durotar,49.93,28.80,35,0
.goto Durotar,52.26,34.68,35,0
.goto Durotar,55.28,75.48,50 >>Travel toward |cRXP_FRIENDLY_Xar'Ti|r
.money <4.5 << wotlk
.money <42.25 << tbc
.skill riding,75,1
step << Troll
.goto Durotar,55.28,75.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xar'Ti|r
.skill riding,75 >> Train |T136103:0|t[Apprentice Riding] from her
.target Xar'Ti
.money <4.5 << wotlk
.money <42.25 << tbc
.skill riding,75,1
step << Troll
.goto Durotar,55.23,75.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zjolnir|r
+|cRXP_BUY_Buy any|r |T132253:0|t[Raptor Whistle] |cRXP_BUY_that you like from him|r
.target Zjolnir
.itemcount 8588,<1 
.itemcount 8591,<1 
.itemcount 8592,<1 
.money <0.9 << wotlk
.money <9.0000 << tbc
.skill riding,<75,1
step << Troll
.cast 55884 >> Use the |T132253:0|t[Whistle of the Emerald Raptor] to learn it
.use 8588
.itemcount 8588,1
.skill riding,75,1
step << Troll
.cast 55884 >> Use the |T132253:0|t[Whistle of the Turquoise Raptor] to learn it
.use 8591
.itemcount 8591,1
.skill riding,75,1
step << Troll
.cast 55884 >> Use the |T132253:0|t[Whistle of the Violet Raptor] to learn it
.use 8592
.itemcount 8592,1
.skill riding,75,1
step << Troll
#completewith Bragok2
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132253:0|t[Emerald Raptor] |cRXP_WARN_onto your Action Bars|r
.cast 8395 >> Mount your |T132253:0|t[Emerald Raptor]
.train 8395,3
.zoneskip Orgrimmar
step << Troll
#completewith Bragok2
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132253:0|t[Turquoise Raptor] |cRXP_WARN_onto your Action Bars|r
.cast 10796 >> Mount your |T132253:0|t[Turquoise Raptor]
.train 10796,3
.zoneskip Orgrimmar
step << Troll
#completewith Bragok2
>>|cRXP_WARN_Press "Shift+P" to open your Mount tab|r
>>|cRXP_WARN_Drag the|r |T132253:0|t[Violet Raptor] |cRXP_WARN_onto your Action Bars|r
.cast 10799 >> Mount your |T132253:0|t[Violet Raptor]
.train 10799,3
.zoneskip Orgrimmar
step << Troll
#completewith Bragok2
.goto Durotar,46.94,69.10,100,0
.goto Durotar,46.02,69.32,40,0
.goto Durotar,41.38,73.54,15,0
.goto Durotar,66.29,35.94,30,0
.goto The Barrens,63.08,37.16,30 >>Travel toward |cRXP_FRIENDLY_Bragok|r
.zoneskip Durotar,1
step
#completewith next
.goto Orgrimmar,47.41,65.07,10,0
.goto Orgrimmar,46.59,64.54,6,0
.goto Orgrimmar,46.75,63.84,6,0
.goto Orgrimmar,46.59,64.54,6,0
.goto Orgrimmar,46.75,63.84,6,0
.goto Orgrimmar,46.59,64.54,6,0
.goto Orgrimmar,46.75,63.84,6,0
.goto Orgrimmar,45.12,63.88,10 >>Travel up the tower toward |cRXP_FRIENDLY_Doras|r
step
#completewith Dizzywig
.goto Orgrimmar,45.12,63.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Ratchet >> Fly to Ratchet
.target Doras
.zoneskip Orgrimmar,1
step << Warlock
#xprate >1.6999
.goto The Barrens,62.63,35.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Strahad|r
.turnin 2996 >> Turn in Seeking Strahad
.accept 1801 >> Accept Tome of the Cabal
.target Strahad Farsan
step << Warlock
.goto The Barrens,62.44,35.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Babagaya|r
.train 6213 >> Train your class spells
.target Babagaya Shadowcleft
.xp <32,1
.xp >34,1
step << Warlock
.goto The Barrens,62.44,35.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Babagaya|r
.train 7648 >> Train your class spells
.target Babagaya Shadowcleft
.xp <34,1
step
.goto The Barrens,62.78,36.43,15,0
.goto The Barrens,62.68,36.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gazlowe|r
.turnin 1178 >> Turn in Goblin Sponsorship
.accept 1180 >> Accept Goblin Sponsorship
.target Gazlowe
step
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Zikkel|r
.goto The Barrens,62.68,37.39,10 >>Bank any items if needed
.target Zikkel
step << Warrior
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mahreen|r
.turnin 874 >> Turn in Mahren Skyseer
.accept 873 >> Accept Isha Awak
.goto The Barrens,65.84,43.86
.target Mahren Skyseer
step << Shaman/Warrior
#xprate >1.6999 << Shaman
.goto The Barrens,65.51,47.32,70,0
.goto The Barrens,64.21,50.70,70,0
.goto The Barrens,63.63,53.85,70,0
.loop 70,The Barrens,65.51,47.32,64.21,50.70,63.63,53.85
>>Kill |cRXP_ENEMY_Isha Awak|r. Loot him for the |cRXP_LOOT_Heart of Isha Awak|r
.complete 873,1 
.unitscan Isha Awak
step << Warrior
#completewith next
.goto The Barrens,65.42,48.11,70,0
.goto The Barrens,68.61,49.16,30 >>Travel toward |cRXP_FRIENDLY_Klannoc|r
step << Warrior
.goto The Barrens,68.61,49.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Klannoc|r
.turnin 1718 >> Turn in The Islander
.accept 1719 >> Accept The Affray
.target Klannoc Macleod
step << Warrior
#completewith next
.goto The Barrens,68.61,48.72
>>Step onto the Grate to begin the event
.complete 1719,2 
.timer 8,The Affray RP
step << Warrior
.goto The Barrens,68.61,48.72
>>|cRXP_WARN_Wait out the RP|r
>>Kill the |cRXP_ENEMY_Affray Challengers|r that come one by one
>>Kill |cRXP_ENEMY_Big Will|r after killing all the |cRXP_ENEMY_Affray Challengers|r
>>|cRXP_WARN_You can eat after killing all of the|r |cRXP_ENEMY_Affray Challengers|r
.complete 1719,1 
.mob Affray Challenger
.mob Big Will
step << Warrior
.goto The Barrens,68.61,49.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Klannoc|r
.turnin 1719 >> Turn in The Affray

.target Klannoc Macleod
step << Shaman/Warrior
#xprate >1.6999 << Shaman
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mahreen|r and |cRXP_FRIENDLY_Islen|r << Shaman
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mahreen|r << Warrior
.turnin 873 >> Turn in Isha Awak
.goto The Barrens,65.77,48.02,50,0 << Warrior
.goto The Barrens,65.84,43.86
.turnin 220 >> Turn in Call of Water << Shaman
.accept 63 >> Accept Call of Water << Shaman
.goto The Barrens,65.83,43.77 << Shaman
.target Mahren Skyseer
.target Islen Waterseer << Shaman
step << Shaman
#xprate <1.7
.goto The Barrens,65.83,43.77
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Islen|r
.turnin 96 >> Turn in Call of Water
.target Islen Waterseer
step
#label Dizzywig
.goto The Barrens,63.01,38.16,20 << Shaman/Warrior
.goto The Barrens,63.35,38.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Dizzywig|r
.turnin 1111 >> Turn in Wharfmaster Dizzywig
.accept 1112 >> Accept Parts for Kravel
.target Wharfmaster Dizzywig
step
.goto The Barrens,63.83,38.66,20,0
.goto The Barrens,63.83,38.66,-1
.goto The Barrens,66.31,39.27,-1
.zone Stranglethorn Vale >> Take the Boat to Stranglethorn Vale
]])
RXPGuides.RegisterGuide([[
#version 23
#wotlk
#tbc
#group RestedXP Wrath Preparation
#defaultfor None
#name !How to Use This Guide
#hidewindow
step
#sticky
+Welcome to the RXP 70-71 Prep guide!
+Start with the Collectible Items and Launch Prep Guide chapters, as they will prepare you for all the quests you'll be turning in on launch. Complete them in full, turn in all quests it says to turn in. These are questlines you leave in the open world, not quests you keep in your quest log!
+Next, do the 25 Quest Log guide, these are quests you leave in your quest log. It is recommended you do around 24 quests and not the full 25 to make sure you have room for prepped quests on launch day. Do not do this guide before the previous step or you will need to backtrack!
+Then check out Turn In Day Speed Assistant to speed up your turn in route
+Lastly, you are good to use the Turn In Guide on launch day!
+Right now the Turn In guide is not out yet to prevent accidental use, keep an eye on our community discord to keep up to date
step << skip
+Once you finish the guide, it is highly recommended you copy your character over to the PTR and give the Turn in Guide a test whirl on the PTR so you know the route better!
]])
RXPGuides.RegisterGuide([[
#version 23
#wotlk
#tbc
#group RestedXP Wrath Preparation
#defaultfor None
#name Collectable Items
step
#completewith questdrops
#sticky
+This chapter of the guide is all items that drop from mobs that start quests. It is highly recommended you follow it to completion, even if it means finding a group for elite quests.
step
#sticky
.reputation 1015,friendly >> Get friendly with Netherwing.
step
.isQuestAvailable 10804
.goto Shadowmoon Valley,59.4,58.6
>> This questline will make you friendly with the Netherwing, which gives a lot of potential exp.
* The quest giver can be off fighting Rocknails or even die to them, you may need to wait for him to respawn.
.accept 10804 >> Accept Kindness
step
.isOnQuest 10804
.goto Shadowmoon Valley,62.4,58.6
.use 31372 >> Kill and loot Rocknail Flayers in the area for their caracass. Then feed their carcass to the Netherwing Drakes by placing it on the ground.
*Make sure to travel a bit when laying the meat, as the same drakes won't eat twice in a row
.complete 10804,1 
step
.isOnQuest 10804
.goto Shadowmoon Valley,59.4,58.6
>> The quest giver can be off fighting Rocknails or even die to them, you may need to wait for him to respawn.
.turnin 10804 >> Turn in Kindness
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,59.4,58.6
.accept 10811 >> Accept Seek Out Neltharaku.
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0,80,0
.goto Shadowmoon Valley,66.2,60.4,80,0
.goto Shadowmoon Valley,61.8,60.0
>> She is a ghostly dragon flying around above the Netherwing Fields, may need to look around for her.
.unitscan Neltharaku
.turnin 10811 >> Turn in Seek out Neltharaku
.accept 10814 >> Accept Neltharaku's Tale
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0
.skipgossip
>> Speak to Neltharaku
.turnin 10814 >> Turn in Neltharaku's Tale
.accept 10836 >> Accept Infiltrating Dragonmaw Fortress
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.0,60.0
>> Kill any Dragonmaw Orcs in the area, any but peons count towards the quest
.complete 10836,1 
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0
>> Find Neltharaku in the sky again, hopefully near where you last saw her
.unitscan Neltharaku
.turnin 10836 >> Turn in Infiltrating Dragonmaw Fortress
.accept 10837 >> Accept To Netherwing Ledge!
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.0,80.0,60,0
.goto Shadowmoon Valley,66.3,82.3,30,0
.goto Shadowmoon Valley,67.3,81.7,30,0
.goto Shadowmoon Valley,68.3,79.8,30,0
.goto Shadowmoon Valley,71.7,83.1,30,0
.goto Shadowmoon Valley,76.7,83.3,60,0
.goto Shadowmoon Valley,66.0,80.0
>> Loot Nethervine Crystals in the area. Find Minerals can track them despite them looking like plants.
.complete 10837,1 
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0
.unitscan Neltharaku
>> Find Neltharaku flying above the Netherwing Fields
.turnin 10837 >> Turn in To Netherwing Ledge!
.accept 10854 >> Accept The Force of Neltharaku
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,71.0,64.0 
.use 31652 >> Use the crystals on enslaved drakes. Don't stand too close or they will attack you and not the orcs.
*The drakes are very weak and will charge nearby orcs after freeing them, be quick to help them in combat or they will die.
.complete 10854,1 
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,61.8,60.0
.unitscan Neltharaku
>> Find Neltharaku flying above the Netherwing Fields
.turnin 10854 >> Turn in The Force of Neltharaku
.accept 10858 >> Accept Karynaku
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,69.8,61.4
>> Find Karynaku on the second floor of the fortress
.unitscan Karynaku
.turnin 10858 >> Turn in Karynaku
.accept 10872 >> Accept Zuluhed the Whacked
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,71.0,62.2
>> This is an elite quest, you may need help. Kill Zuluhed and loot him for the key.
.complete 10872,2
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,69.8,61.4
.use 31664 >> Use the key's on Karynaku's chains to free her.
.complete 10872,1
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,69.8,61.4
.turnin 10872 >> Turn in Zuluhed the Whacked
.accept 10871 >> Accept Ally of the Netherwing
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,59.4,58.6
>> The quest giver can be off fighting Rocknails or even die to them, you may need to wait for him to respawn.
.turnin 10871 >> Turn in Ally of the Netherwing
.accept 11012 >> Accept Blood Oath of the Netherwing
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,59.4,58.6
.turnin 11012 >> Turn in Blood Oath of the Netherwing
.accept 11013 >> Accept In Service of the Illidari
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.2,85.6
.turnin 11013 >> Turn in In Service of the Illidari
.accept 11014 >> Accept Enter the Taskmaster
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.0,86.4
.turnin 11014 >> Turn in Enter the Taskmaster
step
.isQuestAvailable 11041
.goto Shadowmoon Valley,73.4,86.0
>> Kill Arvoar the Rapacious and loot him. He is elite, you may need a group.
* Note, sometimes only one person per kill can loot the item, you may need to kill him multiple times.
.unitscan Arvoar the Rapacious
.collect 32621,1,11041,1
step
.isQuestAvailable 11041
.goto Shadowmoon Valley,73.4,86.0
.use 32621 >> Use the Partially Digested Hand in your bags to accept the quest
.accept 11041 >> Accept A Job Unfinished
step
.isOnQuest 11041
.goto Shadowmoon Valley,70.4,84.6
>> Kill Overmine Flayers and Barash the Den Mother in the area
.unitscan Barash the Den Mother
.complete 11041,1
.complete 11041,2
step
.isOnQuest 11041
.goto Shadowmoon Valley,66.2,85.6
.turnin 11041 >> Turn in A Job Unfinished
step
.isQuestTurnedIn 10804
.goto Shadowmoon Valley,66.0,86.4
.accept 11019 >> Accept Your Friend On The Inside
.turnin 11019 >> Turn in Your Friend On The Inside
step
.goto Shadowmoon Valley,66.0,86.4
.reputation 1015,friendly >> Get friendly with the Netherwing faction by doing dailies. Do not turn in any one time quests like Netherwing Eggs or Rise, Overseer!
.accept 11020 >> Accept A Slow Death
.accept 11015 >> Accept Netherwing Crystals
.accept 11035 >> Accept The Not-So-Friendly Skies...
>> These three quests require gathering professions and you can only do one per day.
.accept 11018 >> Accept Nethercite Ore
.accept 11017 >> Accept Netherdust Pollen
.accept 11016 >> Accept Nethermine Flayer Hide
step
.goto Shadowmoon Valley,63.0,87.8
>> Collect 25 Sludge-covered Object from the Black Blood of Draenor in the mines
*Note: You can copy your character onto the PTR, turn in "Rise, Overseer!" and "The Netherwing Mines" on the PTR then start opening them until you find one that has Murkblood Escape Plans. You can delete the rest, as that same one will have it on live servers.
.collect 32724,25,11081,1
step
.goto Shadowmoon Valley,53.0,62.4,60,0
.goto Shadowmoon Valley,52.7,68.6,60,0
.goto Shadowmoon Valley,51.6,63.8,60,0
.goto Shadowmoon Valley,52.3,59.1,60,0
.goto Shadowmoon Valley,53.0,62.4
.unitscan Val'zareq the Conqueror
>> Go kill Val'zareq the Conqueror. This is an elite quest, you will likely need to group up.
.collect 31345,1,10793,1 >> Get the Journal of Vel'zareq
step << Horde
.goto Shadowmoon Valley,67.6,36.6
>> Kill Smith Gorlunk and loot him
.unitscan Smith Gorlunk
.collect 31241,1,10755,1
step << Alliance
>> Kill Smith Gorlunk and loot him
.unitscan Smith Gorlunk
.goto Shadowmoon Valley,67.6,36.6
.collect 31239,1,10754,1
step
.requires quest,11370
.goto Shattrath City,75.0,36.4
.daily 11369,11384,11382,11363,11362,11375,11354,11386,11373,11378,11374,11372,11368,11388,11370 >> Accept the heroic dungeon daily
step
.requires quest,11387
.goto Shattrath City,75.4,37.6
.daily 11389,11371,11376,11383,11364,11385,11387 >> Accept the dungeon daily
step
.goto Terokkar Forest,69.6,78.6
>> Kill and loot Talonpriest Ishaal. If you have not completed the quest World of Shadows you will need to find someone who has completed it and group up with them, he is invisible without the elixir from that quest.
>> They can kill Talonpriest for you and you can loot him for the Journal. Do NOT complete World of Shadows to do this quest, World of Shadows is more exp on launch day.
>> Skip this step if you cannot find someone.
.unitscan Talonpriest Ishaal
.collect 32523,1,11021,1
step
.goto Terokkar Forest,41.2,56.8
>> Kill and loot Cabal enemies in the area until you get the quest item
.collect 31707,1,10880,1
step
.goto Hellfire Peninsula,25.6,76.6
.unitscan Avruu
>> Kill and loot Avruu
.collect 23580,1,9418,1
step << Horde
.goto Hellfire Peninsula,65.6,30.0
>> Kill and loot Razorsaw
.collect 29590,1,10393,1
step << Alliance
.goto Hellfire Peninsula,53.1,26.7
>> Kill and loot Warbringer Arix'Amal
.collect 29588,1,10395,1
step
.goto Hellfire Peninsula,48.6,39.6
>> Kill and loot Marauding Crust Bursters until you get the quest item
* You will need to run over the "Earthquakes" on the ground to spawn the enemies
.collect 23338,1,9373,1
step
.goto Hellfire Peninsula,17.8,40.6
>> Kill and loot a Raging Colossus
.collect 29476,1,10134,1
step << Alliance
.goto Zangarmarsh,80.2,41.0
>> Kill and loot Withered Giants until you get the quest item.
* Save the Bog Lord Tendrils if you need Sporeggar rep
.collect 24483,1,9827,1
step << Horde
.goto Zangarmarsh,80.2,41.0
>> Kill and loot Withered Giants until you get the quest item.
* Save the Bog Lord Tendrils if you need Sporeggar rep
.collect 24484,1,9828,1
step << skip
.goto Zangarmarsh,62.2,40.6
>> Kill and loot Steam Pump Overseers and other nagas in the area until you get the Drain Schematics
.collect 24330,1,9731,1
step
.goto Nagrand,73.6,59.2,40,0
.goto Nagrand,69.8,52.8,40,0
.goto Nagrand,72.8,44.6,40,0
.goto Nagrand,65.8,38.2,0
>> Kill and loot the lightning elementals in the area, Dust Howlers have the best droprate.
.collect 24504,1,9861,1
step << Alliance
.goto Nagrand,48.6,34.4,40,0
.goto Nagrand,43.0,31.6,40,0
.goto Nagrand,41.0,27.0,40,0
.goto Nagrand,35.8,26.0,40,0
.goto Nagrand,34.0,20.4,0
>> Kill and loot Murkblood Invaders, they patrol around so you may need to do multiple laps.
.collect 24559,1,9871,1
.unitscan Murkblood Invader
step << Horde
.goto Nagrand,48.6,34.4,40,0
.goto Nagrand,43.0,31.6,40,0
.goto Nagrand,41.0,27.0,40,0
.goto Nagrand,35.8,26.0,40,0
.goto Nagrand,34.0,20.4,0
>> Kill and loot Murkblood Invaders, they patrol around so you may need to do multiple laps.
.collect 24558,1,9872,1
.unitscan Murkblood Invader
step
.goto Zangarmarsh,32.9,59.6
>> Kill and loot "Count" Ungula
.collect 25459,1,9911,1
.unitscan "Count" Ungula
step
.goto Blade's Edge Mountains,75.8,23.6,40,0
.goto Blade's Edge Mountains,71.6,33.6,40,0
.goto Blade's Edge Mountains,70.6,44.8,0
>> Kill and loot a Fel Corrupter
.collect 31384,1,10810,1
.unitscan Fel Corrupter
step
.goto Blade's Edge Mountains,41.6,21.4
>> Kill and loot Grishna mobs in the area
.collect 31489,1,10825,1
step
.goto Netherstorm,59.8,86.8
>> Kill and loot Cohlien Frostweaver
.collect 29236,1,10307,1
.unitscan Cohlien Frostweaver
step
.goto Netherstorm,60.0,85.2
>> Kill and loot Conjurer Luminrath
.collect 29235,1,10306,1
.unitscan Conjurer Luminrath
step
.goto Netherstorm,60.6,87.6
>> Kill and loot Battle-Mage Dathric
.collect 29233,1,10182,1
.unitscan Battle-Mage Dathric
step
.goto Netherstorm,59.0,88.2
>> Kill and loot Abjurist Belmara
.collect 29234,1,10305,1
.unitscan Abjurist Belmara
step
.goto Netherstorm,55.0,43.4
>> Kill the Congealed Void Horror and loot him. This is an elite, you may need to group up. This mob has a 30 minute respawn time.
.collect 29738,1,10413,1
.unitscan Congealed Void Horror
step << Horde
>> Kill the last boss in Hellfire Ramparts.
.collect 23892,1,9588,1
step << Alliance
>> Kill the last boss in Hellfire Ramparts.
.collect 23890,1,9587,1
step
>> Kill mobs in The Steamvault until the Orders from Lady Vashj drop
.collect 24367,1,9764,1 >> Get Orders from Lady Vashj
step
#sticky
#label questdrops
#completewith BOEitems
+These quests are from raids get them if you can, otherwise skip this chapter
step << Alliance
>> Get Magtheridon Head from Magtheridon's Lair
.collect 32385,1,11002,1
step << Horde
>> Get Magtheridon Head from Magtheridon's Lair
.collect 32386,1,11003,1
step
>> Get Kael'thas and the Verdant Sphere from Tempest Keep.
.collect 32405,1,11007,1
step
>> Get Blood of the Warlord from Zul'Aman. This quest requires a summon to Ghostlands be an effecient turn in, skip if you won't have access to one on launch day.
.collect 33102,1,11178,1
step
#sticky
#completewith BOPitemslist
#label BOEitems
+This chapter is all items that can be bought on the Auction house and will be free delivery quests. Check them off as you purchase them.
step << Horde
.collect 31670,3,10860,1
.collect 31671,3,10860,1
step
.collect 24368,1,9765,1 
step

.collect 23445,4,10763,1
.collect 22445,2,10763,1
.collect 22574,4,10763,1
step
.collect 24449,6,9806,1 
step
.collect 24246,5,9715,1 
step
.reputation 970,friendly,0,1
.collect 24245,10,9808,1 
step
#aldor
.collect 25744,8,10024,1 
step
#aldor
.collect 29740,1,10420,1 
step
#aldor
.collect 30809,10,10653,1 
step << Alliance
.goto Blasted Lands,63.5,17.0
>>Head to Nethergarde keep in Blasted lands. Go inside the keep and buy 1 Nethergarde Bitter
.collect 23848,1,9563,1 
step
#aldor
.collect 29425,10,10325,1 
step
#scryer
.collect 30810,10,10656,1 
step
#scryer
.collect 29426,10,10412,1 
step
#scryer
.collect 29739,1,10416,1 
step
.collect 25719,30,10917,1 
step
.collect 32388,6,11004,1 
step
>> This quest requires you be neutral with the Consortium, we will be reducing our rep to Neutral later in the guides. Skip this step if you don't want to do that.
.collect 25463,27,9914,1 
step
>> This quest requires you be neutral with the Consortium, we will be reducing our rep to Neutral later in the guides. Skip this step if you don't want to do that.
.collect 25416,10,9882,1 
step
.collect 32601,1,11061,1 
step
.collect 32598,1,11030,1 
step
.collect 32464,40
.skill mining,<350,1 >> You can only turn in one Netherwing gathering daily, if you have two gathering professions skip the next purchase step
step
.collect 32468,40
.skill herbalism,<350,1 >> You can only turn in one Netherwing gathering daily, if you have two gathering professions skip the next purchase step
step
.collect 32470,35
.skill skinning,<350,1
step
#completewith BOEitems
.collect 24401,10,9802,1 
step
#sticky
#label BOPitemslist
#completewith BOPitems
+These items are BOP items and will need to be farmed on your character for free turn ins.
step

>>Kill Ogres in nagrand for Warbeads
.collect 25433,20,9893,1 
step << Alliance
.goto Nagrand,75.0,65.0
>> Grind any mobs in Nagrand for Oshu'gun Crystal Powder. Note it is Unique up to 100, including any in your bank
.collect 26043,20,10076,1
step << Horde
#label BOPitems
.goto Nagrand,75.0,65.0
>> Grind any mobs in an area of Nagrand of your choosing for Oshu'gun Crystal Powder. Note it is Unique up to 100, including any in your bank.
.collect 26042,20,10074,1
step
.goto Blade's Edge Mountains,30.2,75.2

>>Kill mobs around Ogri'la
.collect 32569,5 
step
.goto Netherstorm,30.6,75.2
>> Kill and loot Zaxxis Raiders and Stalkers in Netherstorm
.collect 29209,10,10262,1 
step
.goto Shadowmoon Valley,69.0,85.0
>> Kill mobs in the area and loot them for Netherwing Crystals
.collect 32427,30,11015,1 
step
.goto Shadowmoon Valley,69.0,85.0
.reputation 1015,friendly,<0,1
>> Can be found from herbing, mining, killing monsters in the area, or by finding one in the world. They look like large glowing columns, similar to the eggs at Celestial Ridge in Netherstorm.
.collect 32506,1,11049,1 
step << Alliance
.goto Blade's Edge Mountains,46.8,78.6,30,0
.goto Blade's Edge Mountains,43.2,80.4
>> Collect 11 Bloodmaul Brutebane Brew from Brewmasters or barrels on the ground.
.collect 29443,11,10511,1
]])
RXPGuides.RegisterGuide([[
#version 23
#wotlk
#tbc
#group RestedXP Wrath Preparation
#defaultfor None
#name 25 Questlog Guide
step
#sticky
+This guide will give you 25 quests in your questlog for launch. Prepare the last 10 quests after preparing all the other guides.
+ Some quests may seem out of order, it was impossible to make a 100% effecient route with everyone having different quests. Sorry if you have to double back at all!
step
.requires quest,10667
>> Go buy these items on the Auction House
.collect 23784,1,10664,1
.collect 23793,4,10664,1
step
.requires quest,9837
.goto Shattrath City,54.6,44.2
.accept 9836 >> Accept The Master's Touch

step
.requires quest,10297
.goto Tanaris,66.0,49.6
>> Make sure you're standing still and dismounted when you accept the quest in order to be flown down to the Caverns of Time. Abandon and re-accept the quest if you don't get flown.
.skipgossip
.accept 10279 >> Accept To The Master's Lair
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.turnin 10279 >> Turn in To The Master's Lair
.accept 10277 >> Accept The Caverns of Time
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.timer 540,Wait for the Custodian to show you around the Caverns of Time
>> Simply wait at the quest giver, you'll still get credit. This roleplay takes 9 minutes, take a stretch break.
.complete 10277,1
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.turnin 10277 >> Turn in The Caverns of Time
step
.requires quest,10445
.goto Tanaris,59.6,54.2
.accept 10445 >> Accept The Vials of Eternity
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.accept 10282 >> Accept Old Hillsbrad
step
.requires quest,10297
>> Go do Old Hillsbrad dungeon.
.turnin 10282 >> Turn in Old Hillsbrad
.accept 10283 >> Accept Taretha's Diversion
step
.requires quest,10297
+Set the buildings on fire.
complete 10283,1
step
.requires quest,10297
>> Find Thrall in the basement.
.turnin 10283 >> Taretha's Diversion
.accept 10284 >> Accept Escape from Durnholde
step
.requires quest,10297
>> When the dungeon is done turn in the quest.
.turnin 10284 >> Turn in Escape from Durnholde.
.accept 10285 >> Accept Return to Andormu
step
.requires quest,10297
.goto Tanaris,58.4,54.2
.turnin 10285 >> Turn in Return to Andormu
.accept 10296 >> Accept The Black Morass
step
.requires quest,10297
>> Go into the Black Morass and deliver the quest.
.turnin 10296 >> Turn in The Black Morass
.accept 10297 >> Accept The Opening of the Dark Portal
step
.requires quest,10297
>> Complete The Opening of the Dark Portal but don't deliver the quest.
.complete 10297,1
step
.requires quest,9837
>> Go to The Black Morass and complete the dungeon then turnin the quest
.turnin 9836 >> Turn in The Master's Touch
.accept 9837 >> Accept Return to Khadgar. Don't turn in this quest.
step
.requires quest,10445
>> Go and kill Lady Vashj in SSC.
.complete 10445,1
step
.requires quest,10445
>> Go and kill Kael'thas Sunstrider in Tempest Keep.
.complete 10445,2

step
.requires quest,9831
.zone Deadwind Pass >> Travel to Karazhan
step
.requires quest,9831
.goto Deadwind Pass,47.0,75.7
>>Talk to Archmage Alturus who will start the attunement chain.
.accept 9824 >>Accept Arcane Disturbances
.accept 9825 >>Accept Restless Activity
step
#completewith wellr
.requires quest,9831
.goto Deadwind Pass,48.6,78.7
+Go down the entrance of the cellar and head below towards the ghosts
step
#sticky
#completewith PondR
.requires quest,9831
>>Kill Ghosts. Loot them for Ghostly Essences
.complete 9825,1 
step
#label wellr
.requires quest,9831
.goto Deadwind Pass,54.7,81.8,30,0
.goto Deadwind Pass,53.3,90.2
.use 24474 >>Use the Violet Scrying Crystal in your inventory at the Well at the end of the cellar
* This quest is underground in the cellar, make sure you're below ground when following the arrow.
.complete 9824,1 
step
#completewith next
.requires quest,9831
.goto Deadwind Pass,48.6,78.1
+Go down the entrance of the other cellar
step
#label PondR
.requires quest,9831
.goto Deadwind Pass,47.0,74.2,30,0
.goto Deadwind Pass,44.5,74.0,20,0
.goto Deadwind Pass,42.8,78.1
.use 24474 >>Use the Violet Scrying Crystal in your inventory in the water
.complete 9824,2 
step
.requires quest,9831
.goto Deadwind Pass,43.4,71.2,20,0
.goto Deadwind Pass,45.6,71.6,40,0
.goto Deadwind Pass,41.3,70.0,40,0
.goto Deadwind Pass,41.5,63.0,40,0
.goto Deadwind Pass,41.7,76.8,40,0
.goto Deadwind Pass,46.8,75.1,40,0
.goto Deadwind Pass,43.4,71.2,20,0
.goto Deadwind Pass,45.6,71.6,40,0
.goto Deadwind Pass,41.3,70.0,40,0
.goto Deadwind Pass,41.5,63.0,40,0
.goto Deadwind Pass,41.7,76.8,40,0
.goto Deadwind Pass,46.8,75.1,40,0
.goto Deadwind Pass,43.4,71.2,20,0
.goto Deadwind Pass,45.6,71.6,40,0
.goto Deadwind Pass,41.3,70.0,40,0
.goto Deadwind Pass,41.5,63.0,40,0
.goto Deadwind Pass,41.7,76.8,40,0
.goto Deadwind Pass,46.8,75.1,40,0
>>Finish looting Ghosts for the essences. Split your group up to go back to the other cellar for more spawns if you wish
.complete 9825,1 
step
.requires quest,9831
.goto Deadwind Pass,47.0,75.6
>> Leave the cellars
.turnin 9825 >>Turn in Restless Activity
.turnin 9824 >>Turn in Arcane Disturbances
.accept 9826 >>Accept Contact from Dalaran
step << Alliance
#completewith next
.requires quest,9831
>>Ride back to Darkshire << !Mage
>> Make a portal to Ironforge << Mage
.goto Duskwood,77.5,44.3
.fly Southshore >>Fly to Southshore
step << Horde
#completewith next
.requires quest,9831
>> Ride back to Stonard << !Mage
>> Make a portal to the Undercity << Mage
.goto Swamp of Sorrows,46.0,54.7
.fly Tarren Mill >>Fly to Tarren Mill
step
.requires quest,9831
>>Ride to the Outskirts of Dalaran and speak to Archmage Cedric.
.goto Alterac Mountains,15.6,54.6
.turnin 9826 >>Turn in Contact from Dalaran
.accept 9829 >>Accept Khadgar
step
.zone Shattrath City >> Head to Shattrath City
.goto Shattrath City,54.7,44.4
step
.requires quest,9831
.goto Shattrath City,54.7,44.4
>> Ride to the Center of the City.
.turnin 9829 >>Turn in Khadgar
.accept 9831 >>Accept Entry Into Karazhan
step
#aldor
.requires quest,11492
.goto Shattrath City,30.6,34.4
.accept 11481 >> Accept Crisis at the Sunwell
step
#scryer
.requires quest,11492
.goto Shattrath City,54.4,80.8
.accept 11482 >> Accept Duty Calls
step << skip
.requires quest,11000
.goto Shattrath City,56.4,49.0
.accept 10984 >> Accept Speak with the Ogre
step << skip
.requires quest,11000
.goto Shattrath City,65.2,68.0
.turnin 10984 >> Turn in Speak with the Ogre
.accept 10983 >> Accept Mog'dorg the Wizened
step
.requires quest,11000
.goto Shattrath City,65.2,68.0
.accept 10983 >> Accept Mog'dorg the Wizened
step
.requires quest,10095
.goto Shattrath City,50.4,45.4
.accept 10177 >> Accept Trouble at Auchindoun
step
.requires quest,11514
.goto Shattrath City,49.2,42.6
.accept 11514 >> Accept Maintaining the Sunwell Portal
step
.requires quest,11877
.goto Shattrath City,62.7,36.2
.accept 11877 >> Accept Sunfury Attack Plans
step << Alliance
>> This quest requires 71 to deliver, if you do not prep enough XP to ding 71 skip this quest.
.goto Shattrath City,67.2,34.0
.daily 11337,11336,11335,11338 >> Accept the PvP Daily
step << Horde
>> This quest requires 71 to deliver, if you do not prep enough XP to ding 71 skip this quest.
.goto Shattrath City,67.0,56.6
.daily 11341,11340,11339,11342 >> Accept the PvP Daily
step
.requires quest,10667
>> Go to Shattrath and buy a Demon Warding Totem.
.goto Shattrath City,64.6,70.6
.collect 30823,1,10664,1

step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,23.6,34.4
.collect 30756,1,10621,1 >> Kill Overseer Ripsaw
step << Horde
.requires quest,10667
.goto Shadowmoon Valley,23.6,34.4
.collect 30579,1,10623,1 >> Kill Overseer Ripsaw
step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,36.8,54.8
.use 30576
.turnin 10621 >> Turn in Illidari-Bane Shard
.accept 10626 >> Accept Capture the Weapons
step << Horde
.requires quest,10667
.use 30579
.goto Shadowmoon Valley,29.8,31.2
.turnin 10623 >> Turn in Illidari-Bane Shard
.accept 10627 >> Accept Capture the Weapons
step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,24.0,33.8
>> Kill Makazradon
.unitscan Makazradon
.complete 10626,1
step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,23.6,38.2
>> Kill Morgroron
.unitscan Morgroron
.complete 10626,2
step << Horde
.requires quest,10667
.goto Shadowmoon Valley,24.0,33.8
>> Kill Makazradon
.unitscan Makazradon
.complete 10627,1
step << Horde
.requires quest,10667
.goto Shadowmoon Valley,23.6,38.2
>> Kill Morgroron
.unitscan Morgroron
.complete 10627,2
step << Alliance
.requires quest,10667
.goto Shadowmoon Valley,36.8,54.8
.turnin 10626 >> Turn in Capture the Weapons
.accept 10662 >> Accept The Hermit Smith
step << Horde
.requires quest,10667
.goto Shadowmoon Valley,29.8,31.2
.turnin 10627 >> Turn in Capture the Weapons
.accept 10663 >> Accept The Hermit Smith
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,61.2,29.2
.accept 10587 >> Accept Karabor Training Grounds
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,70.4,49.0
>> Kill Blood Elf demon hunters in the area until the quest is done.
.complete 10587,1
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,61.2,29.2
.turnin 10587 >> Turn in Karabor Training Grounds
.accept 10637 >> Accept A Necessary Distraction
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,69.0,51.0
.use 30811 >> Free Azaloth from the Warlocks banishing him.
.complete 10637,1
step
#aldor
.requires quest,10649
.goto Shadowmoon Valley,61.2,29.2
.turnin 10637 >> Turin in a Necessary Distraction
.accept 10640 >> Accept Altruis
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,62.6,28.4
.accept 10568 >> Accept Tablets of Baa'ri
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,59.8,35.6
.complete 10568,1
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,62.6,28.4
.turnin 10568 >> Turn in Tablets of Baa'ri
.accept 10571 >> Accept Oronu the Elder
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,57.2,32.6
.complete 10571,1
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,62.6,28.4
.turnin 10571 >> Turn in Oronu the Elder
.accept 10574 >> Accept The Ashtongue Corruptors
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,49.8,23.0
.complete 10574,3
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,48.2,39.4
.complete 10574,4
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,51.0,52.4
.complete 10574,1
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,57.0,73.4
.complete 10574,2
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,62.6,28.4
.turnin 10574 >> Turn in The Ashtongue Corruptors
.accept 10575 >> Accept The Warden's Cage
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,56.2,59.6
.accept 10683 >> Accept Tablets of Baa'ri
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,59.8,35.6
.complete 10683,1
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,56.2,59.6
.turnin 10683 >> Turn in Tablets of Baa'ri
.accept 10684 >> Accept Oronu the Elder
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,57.2,32.6
.complete 10684,1
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,56.2,59.6
.turnin 10684 >> Turn in Oronu the Elder
.accept 10685 >> Accept The Ashtongue Corruptors
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,57.0,73.4
.complete 10685,2
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,51.0,52.4
.complete 10685,1
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,48.2,39.4
.complete 10685,4
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,49.8,23.0
.complete 10685,3
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,56.2,59.6
.turnin 10685 >> Turn in The Ashtongue Corruptors
.accept 10686 >> Accept The Warden's Cage
step
#aldor
.requires quest,10707
.goto Shadowmoon Valley,57.2,49.6
.turnin 10575 >> Turn in The Warden's Cage
step
#scryer
.requires quest,10707
.goto Shadowmoon Valley,57.2,49.6
.turnin 10686 >> Turn in The Warden's Cage
step
.requires quest,10707
.goto Shadowmoon Valley,57.2,49.6
.accept 10622 >> Accept Proof of Allegiance
step
.requires quest,10707
>> Kill Zandras, he's outside ontop of the keep walls.
.goto Shadowmoon Valley,58.0,48.8
.complete 10622,1
step
.requires quest,10707
.goto Shadowmoon Valley,57.2,49.6
.turnin 10622 >> Turn in Proof of Allegiance
.accept 10628 >> Accept Akama
step
.requires quest,10707
.goto Shadowmoon Valley,58.0,48.2
>> Go speak to Akama. He's downstairs, go underwater and come up in the other tunnel.
.skipgossip
.turnin 10628 >> Turn in Akaama
.accept 10705 >> Accept Seer Udalo
step
.requires quest,10707
>> Go into The Arcatraz and deliver the quest.
.turnin 10705 >> Turn in Seer Udalo
.accept 10706 >> Accept A Mysterious Portent
step
.requires quest,10707
.goto Shadowmoon Valley,58.0,48.2
.turnin 10706 >> Turn in A Mysterious Portent
.accept 10707 >> Accept The Ata'mal Terrace
step
.requires quest,10707
.goto Shadowmoon Valley,71.4,35.4
>> Find a group and get Heart of Fury. Don't turn in this quest.
.complete 10707,1
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,55.8,58.2
.accept 10687 >> Accept Karabor Training Grounds
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,70.4,49.0
>> Kill Blood Elf's until the quest is done.
.complete 10687,1
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,55.8,58.2
.turnin 10687 >> Turn in Karabor Training Grounds
.accept 10688 >> Accept A Necessary Distraction
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,69.0,51.0
.use 30811 >> Free Azaloth from the Warlocks banishing him.
.complete 10688,1
step
#scryer
.requires quest,10649
.goto Shadowmoon Valley,55.8,58.2
.turnin 10688 >> Turin in a Necessary Distraction
.accept 10689 >> Accept Altruis
step
#aldor
.requires quest,10649
.goto Nagrand,27.4,43.0
.turnin 10640 >> Turn in Altruis
step
#scryer
.requires quest,10649
.goto Nagrand,27.4,43.0
.turnin 10689 >> Turn in Altruis
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.accept 10641 >> Accept Against the Legion
.accept	10668 >> Accept Against the Illidari
.accept 10669 >> Accept Against All Odds
step
.requires quest,10649
.goto Zangarmarsh,16.4,40.4
.use 30853 >> Use the Imbued Silver Spear to summon and kill Xeleth
.complete 10669,1
step
.requires quest,10649
.goto Shadowmoon Valley,28.6,50.6
>> Kill Lothros
.complete 10668,1
step
#sticky
.requires quest,10649
#completewith next
.collect 30850,1,10641,1 >> Kill a Wrath Priestess
step
.goto Netherstorm,41.8,22.2
.requires quest,10649
.use 30850 >> Use the Blood and summon Avatar of Sathal and kill her.
.complete 10641,1
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.turnin 10641 >> Turn in Against the Legion
.turnin	10668 >> Turn in Against the Illidari
.turnin 10669 >> Turn in Against All Odds
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.skipgossip
.accept 10646 >> Accept Illidan's Pupil
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.skipgossip
>> Listen to Altruis's story
.turnin 10646 >> Turn in Illidan's Pupil
step
.requires quest,10649
.goto Nagrand,27.4,43.0
.accept 10649 >> Accept The Book of Fel Names

step
.requires quest,10091
.goto Terokkar Forest,39.8,72.2
.accept 10178 >> Accept Find Spy To'gun
step << Horde
.requires quest,11506
.goto Terokkar Forest,49.8,46.6
.accept 11506 >> Accept Spirits of Auchindoun
step << Horde
.requires quest,11506
.goto Terokkar Forest,32.4,57.8,40,0
.goto Terokkar Forest,42.5,53.9,40,0
.goto Terokkar Forest,48.9,60.5,40,0
.goto Terokkar Forest,47.3,72.3,40,0
.goto Terokkar Forest,40.5,78.1,40,0
.complete 11506,1
step << Alliance
.requires quest,11505
.goto Terokkar Forest,55.8,53.8
.accept 11505 >> Accept Spirits of Auchindoun
step << Alliance
.requires quest,11505
.goto Terokkar Forest,32.4,57.8,40,0
.goto Terokkar Forest,42.5,53.9,40,0
.goto Terokkar Forest,48.9,60.5,40,0
.goto Terokkar Forest,47.3,72.3,40,0
.goto Terokkar Forest,40.5,78.1,40,0
.complete 11505,1
step
.requires quest,10164
.goto Terokkar Forest,35.0,65.2
.accept 10164 >> Accept Everything Will Be Alright
step
.requires quest,10667
.goto Terokkar Forest,77.6,38.6
.turnin 10663 >> Turn in The Hermit Smith << Horde
.turnin 10662 >> Turn in The Hermit Smith << Alliance
step
.requires quest,10667
.goto Terokkar Forest,77.6,38.6
.accept 10664 >> Accept Additional Materials
step
.requires quest,10667
.goto Terokkar Forest,77.6,38.6
.turnin 10664 >> Turn in Additional Materials
.accept 10665 >> Accept Fresh from the Mechanar
.accept 10666 >> Accept The Lexicon Demonica
step
.requires quest,10091
.goto Terokkar Forest,39.8,72.2
>> Enter the Shadow Labyrinth and find Spy To'gun. He's in the second room at the end of the corridor.
.turnin 10178 >> Turn in Find Spy To'gun
.accept 10091 >> Accept The Soul Devices
step
>> Go do Shadow Labyrinth and kill the third boss Grandmaster Vorpil. Then loot him to complete the quest.
.complete 10666,1
step
>> Go do Mechanar and loot the pink box near the Gatewatcher Iron-Hand to complete the quest.
.complete 10665,1
step
.requires quest,10667
.goto Terokkar Forest,77.6,38.6
.turnin 10665 >> Turn in Fresh from the Mechanar
.turnin 10666 >> Turn in The Lexicon Demonica
.accept 10670 >> Accept Tear of the Earthmother
.accept 10667 >> Accept Underworld Loam
step
.requires quest,10095
.goto Terokkar Forest,40.0,72.2
>> Head into Auchindoun's Portal Room on the south side of the ring, it is behind the locked doors.
* You get the key from the last boss in Sethekk Halls if nobody else can open it for you.
.turnin 10177 >> Turn in Trouble at Auchindoun
.accept 10094 >> Accept The Codex of Blood
step
.requires quest,10095
.goto Terokkar Forest,39.4,72.7
>> Go and do Shadow Labyrinth and turnin the quest.
.turnin 10094 >> Turn in The Codex of Blood
.accept 10095 >> Accept Into the Hearth of the Labyrinth
step
.requires quest,9831
.goto Terokkar Forest,39.4,72.7
>> Go to Shadow Labyrinth and get the First Key Fragment. Don't turn in the quest.
.complete 9831,1
step
.requires quest,10091
.goto Terokkar Forest,39.4,72.7
>> Complete the quest inside of Shadow Labyrinth. Don't turn in the quest.
.complete 10091,1
step
.requires quest,10649
.goto Terokkar Forest,39.4,72.7
>> Go complete Shadow Labyrinth and loot Book of Fel Names. Don't deliver the quest.
.complete 10649,1
step
.requires quest,10667
>> Go do Shadow Labyrinth and loot Lexicon Demonica from Grandmaster Vorpil
.complete 10665,1
step
.requires quest,10095
>> Kill Murmur inside of Shadow Labyrinth. Don't turn in the quest.
.complete 10095,1
step
.requires quest,10098
.goto Terokkar Forest,44.0,65.0
.accept 10098 >> Accept Terokk's Legacy
.accept 10097 >> Brother Against Brother
step
.requires quest,10098
>> Go complete Sethekk Halls. Don't deliver the quest(s).
.complete 10098,1
.complete 10098,2
.complete 10098,3
.complete 10097,1
.complete 10097,2
step
.requires quest,10165
.goto Terokkar Forest,39.4,58.6
.accept 10165 >> Accept Undercutting the Competition
step
.requires quest,10218
.goto Terokkar Forest,39.4,58.6
>> Go accept the quest outside the dungeon.
.accept 10216 >> Accept Safety Is Job One
step
.requires quest,10218
>> Go into Mana Tombs and complete the quest
.complete 10216,1
.complete 10216,2
.complete 10216,3
.complete 10216,4
step
.requires quest,10218
>> Deliver the quest inside the dungeon.
.turnin 10216 >> Turn in Safety Is Job One
step
.requires quest,10218
>> Accept this quest inside of Mana-Tombs from Cryo-Engineer Sha'heen
.accept 10218 >> Someone Else's Hard Work Pays Off
step
.requires quest,10218
>> Complete the escort inside the dungeon. Don't deliver the quest.
.complete 10218,1
step
.requires quest,10165
>> Complete the quest in Mana Tombs. Don't deliver the quest.
.complete 10165,1
step
.requires quest,10164
>> Go do Auchenai Crypts. Don't deliver the quest.
.complete 10164,1

step << Alliance
.requires quest,9492
.goto Hellfire Peninsula,56.6,66.6
.accept 9492 >> Accept Turning the Tide
step << Horde
.requires quest,9495
.goto Hellfire Peninsula,55.0,36.0
.accept 9495 >> Accept The Will of the Warcheif
step << Alliance
.requires quest,9494
.goto Hellfire Peninsula,53.8,65.6
.accept 9494,1 >> Accept Fel Embers
step << Alliance
.requires quest,9493
.goto Hellfire Peninsula,56.8,62.6
.accept 9493 >> Accept Pride of the Fel Horde
step << Horde
.requires quest,9496
.goto Hellfire Peninsula,55.0,36.2
.accept 9496 >> Accept Pride of the Fel Horde
step
.requires quest,9494
.use 23735 >> Go and kill Grand Warlock Netherkurse in Shattered Halls. Then use the Grand Warlock's Amulet that he drops near his throne. Don't deliver the quest.
.complete 9494,1
step
.requires quest,10667
>> Go do The Shattered Halls and kill Warbringer O'mrogg. Don't turn in the quest.
.complete 10670,1
step << Alliance
.requires quest,9492
>> Kill Warcheif Kargath's Fist in The Shattered Halls. Don't turn in the quest.
.complete 9492,1
step << Horde
.requires quest,9495
>> Kill Warcheif Kargath's Fist in The Shattered Halls. Don't turn in the quest.
.complete 9495,1
step << Alliance
.requires quest,9493
>> Go into The Shattered Halls and complete the quest. Don't deliver the quest.
.complete 9493,1
.complete 9493,2
.complete 9493,3
step << Horde
.requires quest,9496
>> Go into The Shattered Halls and complete the quest. Don't deliver the quest.
.complete 9496,1
.complete 9496,2
.complete 9496,3

step
.requires quest,10257
.goto Netherstorm,31.4,66.2
.accept 10173 >> Accept The Archmage's Staff.
step
.requires quest,10257
.goto Netherstorm,40.8,72.6
.use 29207
>> Use Conjuring Powder while standing next to the brazier to summon Ekkorash and slay her.
.complete 10173,1
step
.requires quest,10257
.goto Netherstorm,31.4,66.2
.turnin 10173 >> Turn in The Archmage's Staff.
.accept 10300 >> Accept Rebuilding the Staff.
step
.requires quest,10257
.goto Netherstorm,33.6,54.6
>> Kill and loot Disembodied Protectors and Vindicators for Crystals.
.complete 10300,1
step
.requires quest,10257
.goto Netherstorm,31.4,66.2
.turnin 10300 >> Turn in Rebuilding the Staff.
.accept 10174 >> Accept Curse of the Violet Tower.
.use 28455 >> Use the staff to summon the quest turn in
.turnin 10174 >> Turn in Curse of the Violet Tower to Archmage Vargoth after using the staff.
step
.requires quest,10257
.goto Netherstorm,51.8,80.4
.use 28455 >> Use the Archmage Vargoth's Staff to accept the quest
.accept 10188 >> Accept The Sigil of Krasus
step
.requires quest,10257
.goto Netherstorm,51.8,80.4
>> Find and kill Spellbinder Maryana, then loot her for the Krasus Sigil
.unitscan Spellbinder Maryana
.complete 10188,1
step
.requires quest,10257
.goto Netherstorm,51.8,80.4
.use 28455 >> Use the Archmage Vargoth's Staff
.turnin 10188 >> Turn in The Sigil of Krasus
.accept 10192 >> Accept Krasus's Compendium
step
.requires quest,10257
.goto Netherstorm,58.6,89.2,-1
.goto Netherstorm,57.6,89.6,-1
.goto Netherstorm,58.8,88.0,-1
>> Collect the Compendium Chapters from within the one-room houses.
.collect 28472,1,10192,1
.collect 28473,1,10192,1
.collect 28474,1,10192,1
step
.requires quest,10257
.goto Netherstorm,57.4,86.2
.use 28455 >> Use the Archmage Vargoth's Staff
.turnin 10192 >> Turn in Krasus's Compendium
.accept 10301 >> Accept Unlocking the Compendium
step
.requires quest,10257
.goto Netherstorm,56.4,79.0
>> Find and kill Spellreaver Marathelle, then loot her for the Oculus
.unitscan Spellreaver Marathelle
.complete 10301,1
step
.requires quest,10257
.goto Netherstorm,57.0,63.4
.use 28455 >> Use the Archmage Vargoth's Staff
.turnin 10301 >> Turn in Unlocking the Compendium
.accept 10209 >> Accept Summoner Kanthin's Prize
step
.requires quest,10257
.goto Netherstorm,57.0,63.4
>> Find and kill Summoner Kanthin, then loot him for the Stone of Glacius
.unitscan Summoner Kanthin
.complete 10209,1
step
.requires quest,10257
.goto Netherstorm,58.2,86.4
.use 28455 >> Use the Archmage Vargoth's Staff
.turnin 10209 >> Turn in Summoner Kanthin's Prize
.accept 10176 >> Accept Ar'kelos the Guardian
step
.requires quest,10257
.goto Netherstorm,58.0,86.0
>> Enter the Violet Tower at the center of Kirin'Var Village and defeat Ar'kelos
.complete 10176,1
step
.requires quest,10257
.goto Netherstorm,58.2,86.4
.turnin 10176 >> Turn in Ar'kelos the Guardian
.accept 10256 >> Accept Finding the Keymaster
step
.requires quest,10257
.goto Netherstorm,53.0,67.0
.unitscan Apex
>> Find and kill Apex, then loot him for the focus
.collect 28786,1,10256,1
step
.requires quest,10257
.goto Netherstorm,58.2,86.4
.use 28786 >> Use the Crystal Focus to find the Keymaster's Identity
.complete 10256,1
step
.requires quest,10257
.goto Netherstorm,58.2,86.4
.turnin 10256 >> Turn in Finding the Keymaster
.accept 10257 >> Accept Capturing the Keystone
step
.requires quest,10257
+Enter the Botanica and loot The Keystone from Commander Sarannis. Do not turn this quest in once complete.
.complete 10257,1
step
.requires quest,11877
.goto Netherstorm,23.4,72.4
>> Slay any Sunfury faction enemies for the plans
.complete 11877,1
step
.requires quest,10257
.goto Netherstorm,58.3,86.4
.turnin 10256 >> Turn in Finding the Keymaster
.accept 10257 >> Accept Capturing the Keystone
step
.requires quest,10257
>> Go and do Botanica and complete the quest. Don't turn in this quest.
.complete 10257,1
step
.requires quest,10667
>> Go do Mechanar and loot the purple box right before Mechano-Lord Capacitus
.complete 10665,1
step
.requires quest,10439
.goto Netherstorm,60.0,31.8
.accept 10437 >> Accept Recipe for Destruction
step
.requires quest,10439
.goto Netherstorm,61.2,43.6
>> Kill and loot Voidwraiths and Voidshriekers in the area
.complete 10437,1
step
.requires quest,10439
.goto Netherstorm,60.0,31.8
.turnin 10437 >> Turn In Recipe for Destruction
.accept 10438 >> Accept On Nethery Wings
step
.requires quest,10439
.goto Netherstorm,62.6,41.0
>> Jump on the mount at the questgiver.
.use 29778
.complete 10438,1
step
.requires quest,10439
.goto Netherstorm,60.0,31.8
.turnin 10438 >> Turn in On Nethery Wings
.accept 10439 >> Accept Dimensius the All-Devouring
step
.requires quest,10439
.goto Netherstorm,62.4,40.8
>> Find a group and complete the quest. Don't turn this quest in
.complete 10439,1
.complete 10439,2
step
.requires quest,10408
.goto Netherstorm,59.4,32.4
.accept 10339 >> Accept The Ethereum
step
.requires quest,10408
.goto Netherstorm,57.0,37.4
.complete 10339,1
.complete 10339,2
.complete 10339,3
.complete 10339,4
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10339 >> Turn in The Ethereum
.accept 10384 >> Accept Ethereum Data
step
.requires quest,10408
.goto Netherstorm,55.8,39.9
.complete 10384,1
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10384 >> Turn in Ethereum Data
.accept 10385 >> Accept Potential for Brain Damage = High
step
.requires quest,10408
.goto Netherstorm,56.2,41.4
.complete 10385,1
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10385 >> Turn in Potential for Brain Damage = High
.accept 10405 >> Accept S-A-B-O-T-A-G-E
step
.requires quest,10408
.goto Netherstorm,56.2,41.4
>> Kill Ethereum Archon & Overlord.
.complete 10405,1
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10405 >> Turn in S-A-B-O-T-A-G-E
.accept 10406 >> Delivering the Message
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
>>Make sure you are standing on the platform that summons the quest giver or the quest can bug.
.complete 10406,1
step
.requires quest,10408
.goto Netherstorm,56.8,38.6
.turnin 10406 >> Turn in Delivering the Message
.accept 10408 >> Accept Nexus-King Salhadaar
step
.requires quest,10408
.goto Netherstorm,53.4,42.0
.use 29618 >> Complete the quest in a group. Use the Protectorate Disruptor to unleash him. Don't turn in this quest.
.complete 10408,1

step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,52.6,59.0
.accept 10718 >> Accept The Spirits Have Voices
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10718 >> Turn in The Spirits Have Voices
.accept 10614 >> Accept Whispers on the Wind
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,75.2,60.8
.turnin 10614 >> Turn in Whispers on the Wind
.accept 10709 >> Accept Reunion
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10709 >> Turn in Reunion
.accept 10714 >> Accept On Spirit's Wings
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,58.0,30.0
.use 31128 >> Use the Whistle to spy on A Bloodmaul Taskmaster and Soothsayer at the same time
.complete 10714,1
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10714 >> Turn in On Spirit's Wings
.accept 10783 >> Accept Baron Sablemane
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,53.2,42.1
.turnin 10783 >> Turn in Baron Sablemane
.accept 10715 >> Accept Into the Churning Gulch
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,47.0,44.8
>> Kill and loot Crust Busters for their glands
.complete 10715,1
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10715 >> Turn in Into the Churning Gulch
.accept 10749 >> Accept Baron Sablemane's Poison
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10749 >> Turn in Baron Sablemane's Poison
.accept 10720 >> Accept The Smallest Creatures
step << Horde
#sticky
#completewith poisonkeybe
.requires quest,10742
.goto Blade's Edge Mountains,56.5,29.3
+Use the Kodohide Drum to take control of a Marmot. Use the stealth ability and run to the Kegs to poison them.
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,55.4,28.1
.complete 10720,2 
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,55.3,26.0
.complete 10720,1 
step << Horde
#label poisonkeybe
.requires quest,10742
.goto Blade's Edge Mountains,56.0,23.2
.complete 10720,3 
step
.requires quest,11514
.goto Blade's Edge Mountains,53.0,18.8
>>Collect Mana cells from Bash'ir Landing
.complete 11514,1
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10720 >>Turn in The Smallest Creatures
.accept 10721 >>Accept A Boaring Time for Grulloc
step << Horde
#completewith next
.requires quest,10742
.goto Blade's Edge Mountains,60.1,47.7
+Use Huffer's Whistle and wait for Huffer to aggro Grulloc. When he runs away, loot Grulloc's Sack.
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,60.9,47.8
.complete 10721,1 
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10721 >>Turn in A Boaring Time for Grulloc
.accept 10785 >>Accept It's a Trap!
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.3
.turnin 10785 >>Turn in It's a Trap!
.accept 10723 >>Accept Gorgrom the Dragon-Eater
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,30.6,22.2
>>Click Gorgrom's Altar to summon Misha. Wait for the short RP and when Gorgrom dies, place your 3 Grisly Totems.
.complete 10723,1 
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.3
.turnin 10723 >>Turn in Gorgrom the Dragon-Eater
.accept 10724 >> Accept Prisoner of the Bladespire
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,64.2,23.4
>> Find a group and complete the quest
.use 31144
.complete 10724,1
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,51.8,58.3
.turnin 10724 >> Turn in Prisoner of the Bladespire
.accept 10742 >> Accept Showdown
step << Horde
.requires quest,10742
.goto Blade's Edge Mountains,64.0,18.4
>> Find a group to help you. Don't deliver the quest.
.use 31146
.complete 10742,1
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,55.1,24.0
>>Go upstairs, kill and loot Dorgok then click on the item in your bags
.complete 10795,1 
.collect 31363,1,10797,1 
.accept 10797 >> Accept Favor of the Gronn
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,62.0,38.0
>>Click on the item in your bags
.turnin 10797 >> Turn in Favor of the Gronn
.accept 10798 >> Accept Pay the Baron a Visit
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,53.3,41.2
.turnin 10798 >> Turn in Pay the Baron a Visit
.accept 10799 >> Accept Into the Churning Gulch
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,48.4,43.7
.complete 10799,1 
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10799 >> Turn in Into the Churning Gulch
.accept 10800 >> Accept Goodnight, Gronn
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,60.9,47.7
>>Use Baron Sablemane's Sleeping Powder on Grulloc. Be careful as it can resist (just use it again)
.complete 10800,1 
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10800 >> Turn in Goodnight, Gronn
.accept 10801 >> Accept It's a Trap!
step << Alliance
.goto Blade's Edge Mountains,44.0,51.8
.accept 10516 >> Accept The Trappings of a Vindicator
step << Alliance
.goto Blade's Edge Mountains,42.6,59.4,40,0
.goto Blade's Edge Mountains,39.0,52.6
>> Kill Droggam and Mugdorg and loot them for the quest items
.complete 10516,2 
.complete 10516,1 
step << Alliance
.goto Blade's Edge Mountains,44.0,51.8
.turnin 10516 >> Turn in The Trappings of a Vindicator
.accept 10517 >> Accept Gorr'Dim, Your Time Has Come...
step << Alliance
.goto Blade's Edge Mountains,39.4,49.2
>> Kill Gorr'dim
.complete 10517,1 
step << Alliance
.goto Blade's Edge Mountains,44.0,51.8
.turnin 10517 >> Turn in Gorr'Dim, Your Time Has Come...
.accept 10518 >> Accept Planting the Banner
step << Alliance
.goto Blade's Edge Mountains,39.2,58.6,40,0
.goto Blade's Edge Mountains,46.4,74.6
>> Kill a Bladespire Champion and loot it for the banner
.unitscan Bladespire Champion
.collect 30416,1,10518,1
.use 30416 >> Use the banner ontop of the tower to lure out Gurn Grubnosh. Kill him for his helmet.
.collect 30417,1,10518,1
step << Alliance
.goto Blade's Edge Mountains,36.2,66.2
.turnin 10518 >> Turn in Planting the Banner
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,62.0,38.1
.turnin 10801 >> Turn in It's a Trap!
.accept 10802 >> Accept Gorgrom the Dragon-Eater
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,30.5,22.2
>>Click on the altar in the middle and drop the totems at the giant's corpse
.complete 10802,1 
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,62.0,38.0
.turnin 10802 >> Turn in Gorgrom the Dragon-Eater
.accept 10818 >> Accept Baron Sablemane Has Requested Your Presence
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10818 >> Turn in Baron Sablemane Has Requested Your Presence
.accept 10805 >> Accept Massacre at Gruul's Lair
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,63.0,20.2
.complete 10805,1
.complete 10805,2
.complete 10805,3
.complete 10805,4
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,51.8,58.3
.turnin 10805 >> Turn in Massacre at Gruul's Lair
.accept 10806 >> Accept Showdown
step << Alliance
.requires quest,10806
.goto Blade's Edge Mountains,64.0,18.4
>> Find a group to help you. Don't deliver the quest.
.use 31808
.complete 10806,1
step
.requires quest,11000
.goto Blade's Edge Mountains,55.4,44.8
.accept 10995 >> Accept Grulloc Has Two Skulls
.accept 10996 >> Accept Maggoc's Treasure Chest
.accept 10997 >> Accept Even Gronn Have Standards
step
.requires quest,11000
.goto Blade's Edge Mountains,60.6,47.6
>> Kill Grulloc
.complete 10995,1
step
.requires quest,11000
.goto Blade's Edge Mountains,66.0,55.5
>> Find Maggoc and kill him and loot the chest.
.complete 10996,1
step
.requires quest,11000
.goto Terokkar Forest,20.5,17.7
>> Kill Slaag
.complete 10997,1
step
.requires quest,11000
.goto Blade's Edge Mountains,55.4,44.8
.turnin 10995 >> Turn in Grulloc Has Two Skulls
.turnin 10996 >> Turn in Maggoc's Treasure Chest
.turnin 10997 >> Turn in Even Gronn Have Standards
.accept 10998 >> Accept Grim(oire) Business
step
.requires quest,11000
.goto Blade's Edge Mountains,77.4,31.2
>> Find a group and complete the 5 man group quest.
.complete 10998,1
step
.requires quest,11000
.goto Blade's Edge Mountains,55.4,44.8
>> Turn this in the quest, the followup is the chunky one.
.turnin 10998 >> Turnin Grim(oire) Business
step
.requires quest,11000
.goto Blade's Edge Mountains,55.4,44.8
.accept 11000 >> Accept Into the Soulgrinder.
step
.requires quest,11000
.goto Blade's Edge Mountains,60.6,25.6
>> Find a group again and complete the 5 man group quest. Don't turn in this quest.
.complete 11000,1

step
.requires quest,9738
.goto Zangarmarsh,52.2,36.0
>> Head into the underwater resevoir in the middle of the lake
.accept 9738 >> Accept Lost in Action
step
.requires quest,9763
.goto Zangarmarsh,52.2,36.0
>> Head into the underwater resevoir in the middle of the lake
.accept 9763 >> Accept The Warlord's Hideout
step
.requires quest,9738
>> Complete these two steps in Slave Pens
.complete 9738,3
.complete 9738,2
step
.requires quest,9738
>> Complete these two steps in Underbog. Don't deliver the quest.
.complete 9738,1
.complete 9738,4
step
.requires quest,9763
>> Kill the last boss in Steamvaults. Don't deliver the quest.
.complete 9763,3
step
.requires quest,10667
>> Go do Steamvaults and kill Hydromacer Thespia. Don't turn in the quest.
.complete 10667,1

step
.requires quest,11108
.goto Shadowmoon Valley,66.0,85.4
.reputation 1015,exalted,<0,1
>> This questline requires exalted.
.accept 11107 >> Accept Bow to the Highlord
step
.requires quest,11108
.goto Shadowmoon Valley,66.0,85.4
.turnin 11107 >> Turn in Accept Bow to the Highlord
.accept 11108 >> Accept Lord Illidan Stormrage
step
.requires quest,11108
>> Wait for the superlong RP. Don't turn in this quest. 
.complete 11108,1
step << Horde
.requires quest,9937
.goto Nagrand,55.7,37.9
.accept 9935 >> Accept Wanted: Giselda the Crone
.accept 9939 >> Accept Wanted: Zorbo the Advisor
step << Alliance
.requires quest,9938
.goto Nagrand,54.7,70.8
.accept 9936 >> Accept Wanted: Giselda the Crone
.accept 9940 >> Accept Wanted: Zorbo the Advisor
step << Horde
.requires quest,9937
.goto Nagrand,71.2,82.2
>> Kill Giselda the Crone and 15 Kil'sorrow Agents in the area
.complete 9935,1
.complete 9935,2
step << Alliance
.requires quest,9938
.goto Nagrand,71.2,82.2
>> Kill Giselda the Crone and 15 Kil'sorrow Agents in the area
.complete 9936,1
.complete 9936,2
step << Horde
.requires quest,9937
.goto Nagrand,46.0,19.0
>> Kill Zorbo the Advisor and Warmaul ogres in the area
.complete 9939,1
.complete 9939,2
.complete 9939,3
step << Alliance
.requires quest,9938
.goto Nagrand,46.0,19.0
>> Kill Zorbo the Advisor and Warmaul ogres in the area
.complete 9940,1
.complete 9940,2
.complete 9940,3
step << Alliance
.requires quest,9938
.goto Nagrand,54.7,70.8
.turnin 9936 >> Turn in Wanted: Giselda the Crone
.turnin 9940 >> Turn in Wanted: Zorbo the Advisor
step << Horde
.requires quest,9937
.goto Nagrand,55.8,37.8
.turnin 9935 >> Turn in Wanted: Giselda the Crone
.turnin 9939 >> Turn in Wanted: Zorbo the Advisor
step << Horde
.requires quest,9937
.goto Nagrand,55.8,37.8
.accept 9937 >> Accept Wanted: Durn the Hungerer
step << Alliance
.requires quest,9938
.goto Nagrand,55.8,37.8
.accept 9938 >> Accept Wanted: Durn the Hungerer
step << Horde
.requires quest,9937
.goto Nagrand,38.2,77.2,60,0
.goto Nagrand,47.0,70.0,60,0
.goto Nagrand,37.0,58.2,60,0
.goto Nagrand,31.0,69.2,60,0
>> Find and kill Durn the Hungerer, he patrols around the giant crystal. Do not turn in this quest once complete.
.unitscan Durn the Hungerer
.complete 9937,1
step << Alliance
.requires quest,9938
.goto Nagrand,38.2,77.2,60,0
.goto Nagrand,47.0,70.0,60,0
.goto Nagrand,37.0,58.2,60,0
.goto Nagrand,31.0,69.2,60,0
>> Find and kill Durn the Hungerer, he patrols around the giant crystal. Do not turn in this quest once complete.
.unitscan Durn the Hungerer
.complete 9938,1
step
.requires quest,9853
.goto Nagrand,61.2,22.2
>> The end of this quest chain is elite, you may need help.
.accept 9818 >> Accept The Underneath
step
.requires quest,9853
.goto Nagrand,61.0,22.0
>> Talk to the Earth Elemental
.skipgossip
.complete 9818,1
step
.requires quest,9853
.goto Nagrand,61.2,22.2
.turnin 9819 >> Turn in The Underneath
.accept 9819 >> Accept The Tortured Earth
step
.requires quest,9853
.goto Nagrand,67.0,32.0
>> Kill Tortured Earth Spirits in the area
.complete 9819,1 
step
.requires quest,9853
.goto Nagrand,61.2,22.2
.turnin 9819 >> Turn in The Tortured Earth
.accept 9821 >> Accept Eating Damnation
step
.requires quest,9853
.goto Nagrand,56.0,52.0
>> Kill and loot Enraged Crushers
.collect 24473,15,9821,1
step
.requires quest,9853
.goto Nagrand,61.2,22.2
.turnin 9821 >> Turn in Eating Damnation
.accept 9849 >> Accept Shattering the Veil
step
.requires quest,9853
.goto Nagrand,29.0,67.4,40,0
.goto Nagrand,32.0,80.6,40,0
.goto Nagrand,41.0,82.6,40,0
.use 24501 >> Use Gordawg's Boulder on Shattered Rumblers then kill the minions that spawn
.complete 9849,1
step
.requires quest,9853
.goto Nagrand,61.2,22.2
.turnin 9849 >> Turn in Shattering the Veil
.accept 9853 >> Accept Gurok the Usurper
step
.requires quest,9853
.goto Nagrand,29.0,24.8
>> Kill and loot Gurok the Usurper. Do not turn in this quest once complete.
.collect 24503,1,9853,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> This quest chain is elite, you may need help.
.accept 9962 >> Accept The Ring of Blood: Brokentoe
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> Go into the arena and defeat the boss
.complete 9962,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9962 >> Turnin The Ring of Blood: Brokentoe
.accept 9967 >> Accept The Ring of Blood: The Blue Brothers
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> Go into the arena and defeat the boss
.complete 9967,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9967 >> Turnin The Ring of Blood: The Blue Brothers
.accept 9970 >> Accept The Ring of Blood: Rokdar the Sundered Lord
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> Go into the arena and defeat the boss
.complete 9970,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9970 >> Turnin The Ring of Blood: Rokdar the Sundered Lord
.accept 9972 >> Accept The Ring of Blood: Skra'gath
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> Go into the arena and defeat the boss
.complete 9972,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9972 >> Turnin The Ring of Blood: Skra'gath
.accept 9973 >> Accept The Ring of Blood: The Warmaul Champion
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> Go into the arena and defeat the boss
.complete 9973,1
step
.requires quest,9977
.goto Nagrand,42.8,20.8
.turnin 9973 >> Turnin The Ring of Blood: The Warmaul Champion
.accept 9977 >> Accept The Ring of Blood: The Final Challenge
step
.requires quest,9977
.goto Nagrand,42.8,20.8
>> Go into the arena and defeat the boss. Don't turn in the quest once you're done!
.complete 9977,1
step
#sticky
+The following quests are Daily Quests. Due to you having a lot of normal quests completed on your character.

step
.requires quest,11369
.isOnQuest 11369
>> Go into The Botanica on Heroic difficulty and defeat The Black Stalker. Don't turn this quest in when complete.
.complete 11369,1
step
.requires quest,11384
.isOnQuest 11384
>> Go into Underbog on Heroic difficulty and defeat Warp Splinter. Don't turn this quest in when complete.
.complete 11384,1
step
.requires quest,11382
.isOnQuest 11382
>> Go into The Black Morass on Heroic difficulty and defeat Aeonus. Don't turn this quest in when complete.
.complete 11382,1
step
.requires quest,11363
.isOnQuest 11363
>> Go into The Shattered Halls on Heroic difficulty and defeat Warchief Kargath Bladefist. Don't turn this quest in when complete.
.complete 11363,1
step
.requires quest,11362
.isOnQuest 11362
>> Go into The Blood Furnace on Heroic difficulty and defeat Keli'dan the Breaker. Don't turn this quest in when complete.
.complete 11362,1
step
.requires quest,11375
.isOnQuest 11375
>> Go into Shadow Labyrinth on Heroic difficulty and defeat Murmur. Don't turn this quest in when complete.
.complete 11375,1
step
.requires quest,11354
.isOnQuest 11354
>> Go into Hellfire Ramparts on Heroic difficulty and defeat Nazan. Don't turn this quest in when complete.
.complete 11354,1
step
.requires quest,11386
.isOnQuest 11386
>> Go into The Mechanar on Heroic difficulty and defeat Pathaleon the Calculator. Don't turn this quest in when complete.
.complete 11386,1
step
.requires quest,11373
.isOnQuest 11373
>> Go into Mana-Tombs on Heroic difficulty and defeat Nexus-Prince Shaffar. Don't turn this quest in when complete.
.complete 11373,1
step
.requires quest,11378
.isOnQuest 11378
>> Go into Old Hillsbrad Foothills dungeon on Heroic difficulty and defeat Epoch Hunter. Don't turn this quest in when complete.
.complete 11378,1
step
.requires quest,11374
.isOnQuest 11374
>> Go into Auchenai Crypts on Heroic difficulty and defeat Exarch Maladaar. Don't turn this quest in when complete.
.complete 11374,1
step
.requires quest,11372
.isOnQuest 11372
>> Go into Sethekk Halls on Heroic difficulty and defeat Talon King Ikiss. Don't turn this quest in when complete.
.complete 11372,1
step
.requires quest,11368
.isOnQuest 11368
>> Go into The Slave Pens on Heroic difficulty and defeat Quagmirran. Don't turn this quest in when complete.
.complete 11368,1
step
.requires quest,11388
.isOnQuest 11388
>> Go into The Arcatraz on Heroic difficulty and defeat Harbinger Skyriss. Don't turn this quest in when complete.
.complete 11388,1
step
.requires quest,11370
.isOnQuest 11370
>> Go into The Steamvault on Heroic difficulty and defeat Warlord Kalithresh. Don't turn this quest in when complete.
.complete 11370,1

step
.requires quest,11377
.goto Shattrath City,61.6,15.8
.daily 11380,11377,11381,11379 >> Accept the cooking daily
step
.requires quest,11377
.isOnQuest 11380
.goto Netherstorm,46.0,11.0
>> Collect Mana Berries from Eco-Domes in Netherstorm. Don't turn this quest in when complete.
.complete 11380,1
step
.requires quest,11377
.isOnQuest 11377
>> Collect a Giant Kaliri Wing from Monstrous Kaliri flying around Skettis
.goto Terokkar Forest,61.2,74.2,20,0
.goto Terokkar Forest,69.8,75.0,20,0
.goto Terokkar Forest,74.6,88.4,20,0
.collect 33838,1,11377,1
step << Alliance
.requires quest,11377
.isOnQuest 11377
.goto Stormwind City,53.6,59.6
>> Cook up 3 Warp Burgers, or buy them off the auction house.
.collect 27659,3,11377,1
step << Horde
.requires quest,11377
.isOnQuest 11377
.goto Orgrimmar,55.6,62.8
>> Cook up 3 Warp Burgers, or buy them off the auction house.
.collect 27659,3,11377,1
step
.requires quest,11377
.isOnQuest 11377
.use 33837 >> Use your Cooking Pot with ingredients in your inventory. Don't turn this quest in when complete.
.complete 11377,1
step << Alliance
.requires quest,11377
.isOnQuest 11381
.goto Stormwind City,53.6,59.6
>> Cook up 4 Roasted Clefthoof, or buy them off the auction house.
.collect 27658,4,11381,1
step << Horde
.requires quest,11377
.isOnQuest 11381
.goto Orgrimmar,55.6,62.8
>> Cook up 4 Roasted Clefthoof, or buy them off the auction house.
.collect 27658,4,11381,1
step
.requires quest,11377
.isOnQuest 11381
.goto Nagrand,26.0,59.5
.use 33851 >> Use your Cooking Pot with ingredients in your inventory while standing within Ancestral Grounds. Don't turn this quest in when complete.
.complete 11381,1
step << Alliance
.requires quest,11377
.isOnQuest 11377
.goto Stormwind City,53.6,59.6
>> Cook up 2 Mok'Nathal Shortribs and a Crunchy Serpent, or buy them off the auction house.
.collect 31672,2,11377,1
.collect 31673,1,11377,1
step << Horde
.requires quest,11377
.isOnQuest 11377
.goto Orgrimmar,55.6,62.8
>> Cook up 2 Mok'Nathal Shortribs and a Crunchy Serpent, or buy them off the auction house.
.collect 31672,2,11377,1
.collect 31673,1,11377,1
step
.requires quest,11377
.isOnQuest 11377
.goto Blade's Edge Mountains,29.6,83.4
.use 33837 >> Use your Cooking Pot with ingredients in your inventory while standing on top of a dead Abyssal Flamebringer. Don't turn this quest in when complete.
.complete 11377,1

step
.requires quest,11387
.isOnQuest 11389
>> Go into The Arcatraz and defeat 5 Arcatraz Sentinels. Don't turn this quest in when complete.
.complete 11389,1
step
.requires quest,11387
.isOnQuest 11371
>> Go into The Steamvault and defeat 14 Coilfang Myrmidons. Don't turn this quest in when complete.
.complete 11371,1
step
.requires quest,11387
.isOnQuest 11376
>> Go into Shadow Labyrinth and defeat 3 Malicious Instructors. Don't turn this quest in when complete.
.complete 11376,1
step
.requires quest,11387
.isOnQuest 11383
>> Go into The Black Morass and defeat 4 Rift Lords. Don't turn this quest in when complete.
.complete 11383,1
step
.requires quest,11387
.isOnQuest 11364
>> Go into The Shattered Halls and defeat 4 Shattered Hand Centurions. Don't turn this quest in when complete.
.complete 11364,1
step
.requires quest,11387
.isOnQuest 11385
>> Go into The Botanica and defeat 6 Sunseeker Channelers. Don't turn this quest in when complete.
.complete 11385,1
step
.requires quest,11387
.isOnQuest 11387
>> Go into The Mechanar and defeat 5 Tempest-Forge Destroyers. Don't turn this quest in when complete.
.complete 11387,1

step
.requires quest,11523
.goto Isle of Quel'Danas,47.4,30.6
.accept 11523 >> Accept Arm the Wards!
step
.requires quest,11525
.goto Isle of Quel'Danas,47.2,30.6
.accept 11525 >> Accept Further Conversions
step
.requires quest,11521
.goto Isle of Quel'Danas,51.5,32.5
.accept 11521 >> Accept Rediscovering Your Roots
step
.requires quest,11546
.goto Isle of Quel'Danas,51.5,32.5
.accept 11546 >> Accept Open for Business
step
.requires quest,11541
.goto Isle of Quel'Danas,53.8,34.2
.accept 11541 >> Accept Disrupt the Greengill Coast from Captain Valindria.
step
.requires quest,11533
.goto Isle of Quel'Danas,47.6,35.2
.accept 11533 >> Accept The Air Strikes Must Continue
step
.requires quest,11547
.goto Isle of Quel'Danas,47.6,35.4
.accept 11547 >> Accept Know Your Ley Lines from Astromancer Darnarian.
step
.requires quest,11536
.goto Isle of Quel'Danas,50.4,40.6
.accept 11536 >> Accept Don't Stop Now....
step
.requires quest,11544
.goto Isle of Quel'Danas,50.6,40.8
.accept 11544 >> Accept Ata'mal Armaments
step
.requires quest,11542
.goto Isle of Quel'Danas,50.6,39.0
.accept 11542 >> Accept Intercept the Reinforcements from Vindicator Kaalan.
step
.requires quest,11539
.goto Isle of Quel'Danas,49.4,40.2
.accept 11539 >> Accept Taking the Harbor from Magister Ilastar
step
.requires quest,11536
.goto Isle of Quel'Danas,65.0,48.0
>> Open chests for Darkspine Ore
.collect 34479,3
step
.requires quest,11541
.goto Isle of Quel'Danas,60.9,51.6
.use 34483 >> Kill Darkspine Siren for Orbs of Murloc Control and use them on Greengill Slaves. Don't turn this quest in when complete.
.complete 11541,1
step
.requires quest,11547
.goto Isle of Quel'Danas,61.2,62.5
.use 34533 >> Use Astromancer's Crystal near the shrine. Don't turn this quest in when complete.
.complete 11547,2
step
.requires quest,11547
.goto Isle of Quel'Danas,48.4,45.5
.use 34533 >> Use Astromancer's Crystal near the portal.
.complete 11547,1
step
.requires quest,11523
.goto Isle of Quel'Danas,47.4,30.6
.use 34338 >> Use Mana Remnants to energize any ward around the base
.complete 11523,1
step
.requires quest,11539
.goto Isle of Quel'Danas,45.6,41.4
>>Kill Dawnblade enemies around the area. Don't turn this quest in when complete.
.complete 11539,1
.complete 11539,2
.complete 11539,3
step
.requires quest,11547
.goto Isle of Quel'Danas,42.0,35.2
.use 34533 >> Use Astromancer's Crystal near the bloodcrystal.
.complete 11547,3
step
.requires quest,11533
.goto Isle of Quel'Danas,48.4,25.2
.use 34475 >>Speak with Ayren Cloudbreaker to fly over Dear Scar and use Arcane Charges to kill enemies
.complete 11533,1
.complete 11533,2
.complete 11533,3
step
.requires quest,11542
.skipgossip
>> Speak with Ayren Cloudbreaker to go on a flight over the ships.
.goto Isle of Quel'Danas,48.4,25.2
step
.requires quest,11542
.goto Isle of Quel'Danas,48.4,25.2
.use 34489 >> Throw Flaming Oil on boat sails of each ship
.complete 11542,1
.complete 11542,2
.complete 11542,3
step
.requires quest,11542
.goto Isle of Quel'Danas,48.4,25.2
>> Kill Dawnblade Reservists when you land. Don't turn this quest in when complete.
.complete 11542,4
step
.requires quest,11546
.goto Isle of Quel'Danas,38.0,29.7
>> Loot the Bloodberries in the area.
.complete 11546,1
step
.requires quest,11523
.goto Isle of Quel'Danas,44.8,26.4,40,0
.goto Isle of Quel'Danas,40.6,30.4,40,0
.goto Isle of Quel'Danas,35.6,35.0
>>Kill Wretched enemies for Mana Remnants
.collect 34338,4,11523,1
step
.requires quest,11525
.goto Isle of Quel'Danas,43.8,26.6,40,0
.goto Isle of Quel'Danas,37.4,32.4,40,0
.goto Isle of Quel'Danas,34.6,38.8
.use 34368 >> Defeat Erratic Sentries and replace their cores
.complete 11525,1
step
#aldor
.requires quest,11492
.goto Isle of Quel'Danas,47.4,30.6
.turnin 11481 >> Turn in Crisis at the Sunwell
.accept 11488 >> Accept Magisters' Terrace
step
#scryer
.requires quest,11492
.goto Isle of Quel'Danas,47.4,30.6
.turnin 11482 >> Turn in Duty Calls
.accept 11488 >> Accept Magisters' Terrace
step
.requires quest,11492
>> Go into Magisters'Terrace
.turnin 11488 >> Turn in Magisters' Terrace
.accept 11490 >> Accept The Scryer's Scryer
step
.requires quest,11492
>> Complete the quest in Magisters'Terrace on the Orb.
.complete 11490,1
step
.requires quest,11492
>> Turn in the quest inside the instance.
.turnin 11490 >> Turn in The Scryer's Scryer
.accept 11492 >> Accept Hard to Kill
step
.requires quest,11492
>> Kill Kael'thas inside the instance. Don't turn in the quest.
.complete 11492,1
step
.requires quest,11544
.goto Shadowmoon Valley,69.5,39.6
>> Kill Orcs around Ata'mal Terrace for 5 Ata'mal Armaments.
.collect 34500,5,11544,1
step
.requires quest,11544
.goto Isle of Quel'Danas,50.1,40.5
.use 34500 >> Use Ata'mal Armaments while standing next to Hauthaa's Anvil. Don't turn this quest in when complete.
.complete 11544,1
step
.requires quest,11521
.goto Terokkar Forest,58.1,13.2
>> Kill Razorthorn Flayers for a Gland
.collect 34255,1,11521,1
step
.requires quest,11521
.use 34255 >> Use the Gland on Razorthorn Ravager to control it and expose the roots for you to dig up. Don't turn this quest in when complete.
.complete 11521,1

step
.requires quest,11020
.goto Shadowmoon Valley,66.0,86.4
.accept 11020 >> Accept A Slow Death from Yarzill the Merc
step
.requires quest,11020
.goto Shadowmoon Valley,45.8,61.5,20
>> Kill Felfire Diemetradon around here for Fel Glands.
.collect 32502,12,11020,1
step
.requires quest,11020
.goto Shadowmoon Valley,66.0,82.1,30,0
.goto Shadowmoon Valley,76.3,85.4,30,0
.use 32503>> Use Yarzill's Mutton near the Dragonmaw Peons to poison them. Don't turn this quest in when complete.
.complete 11020,1

step
.requires quest,11035
.goto Shadowmoon Valley,66.0,86.4
.accept 11035 >> Accept The Not-So-Friendly Skies... from Yarzill the Merc.
step
.requires quest,11035
.goto Shadowmoon Valley,72.3,64.3
>> Kill Dragonmaw Transporters for Netherwing Relics. Don't turn this quest in when complete.
.complete 11035,1

step
.requires quest,11515
.goto Hellfire Peninsula,58.2,17.6
.accept 11515 >> Accept Blood for Blood from Magistrix Seyla.
step
.requires quest,11516
.goto Hellfire Peninsula,58.2,17.6
.accept 11516 >> Accept Blast the Gateway
step
.requires quest,11516
.goto Hellfire Peninsula,58.2,17.6
.use 34253 >> Summon Living flare with Sizzling Embers and bring it close to fire elementals to power it up. When its done bring it to the demonic portal.
.complete 11516,1
step
.requires quest,11515
.use 34257 >> Kill Wrath Heralds for their Demonic Blood, then use Fel Siphon on Felblood Initiates. Don't turn this quest in when complete.
.complete 11515,1
step << Alliance
.requires quest,11502
.goto Nagrand,55.8,73.6
.accept 11502 >> Accept In Defense of Halaa from Lakoor in Telaar.
step << Alliance
.requires quest,11502
.goto Nagrand,55.8,73.6,20,0
>> Kill enemy faction guards or players around halaa. Don't turn this quest in when complete.
.complete 11502,1

step << Horde
.requires quest,11503
.goto Nagrand,52.8,36.0
.accept 11503 >> Accept Enemies, Old and New from Karrtog in Garadar.
step << Horde
.requires quest,11503
.goto Nagrand,55.8,73.6,20,0
>> Kill enemy faction guards or players around halaa. Don't turn this quest in when complete.
.complete 11503,1
step
.requires quest,11008
.goto Terokkar Forest,64.6,66.6
.accept 11008 >> Accept Fires Over Skettis
step
.requires quest,11008
.goto Terokkar Forest,70.4,80.1,10,0
.goto Terokkar Forest,74.7,88.3,10,0
.goto Terokkar Forest,67.6,86.0,10,0
.goto Terokkar Forest,62.6,80.8,10,0
.use 32406 >> Use Blasting Charges in your inventory while on your mount to destroy the eggs on top of the structures in the area. Don't turn this quest in when complete.
.complete 11008,1
]])
RXPGuides.RegisterGuide([[
#version 23
#wotlk
#tbc
#group RestedXP Wrath Preparation
#defaultfor None
#name RestedXP Total XP prepared
#hidewindow
step
>> So far the experienced you have prepared is:
.showtotalxp
>> Out of the total possible for your character:
.showtotalxp 1
>> For questlog quests, put the items into your bag so all the quests are marked as "(Complete)".
>>-
.show25quests >> CLICK HERE to see the list of 25 best quests for your character
]])
RXPGuides.RegisterGuide([[
#version 23
#wotlk
#tbc
#group RestedXP Wrath Preparation
#defaultfor None
#name Launch Prep Guide
step
#sticky
+This guide is about doing quest chains that can easily be picked up and turned in on launch, without keeping them in your quest log. If this chapter of the guide says to turn something in, turn it in! It's okay and you won't lose out on exp. Just don't turn in any quests it doesn't tell you to, those are the ones we're saving. They will be turned in by following the "Turn in Guide".
step
.reputation 989,revered >> Get Revered with Keepers of Time.
>> Spam Caverns of Time dungeons until revered. This is a MUST DO step unless you have a warlock that can summon you to the Caverns at launch instead.
step << Horde
.reputation 729,exalted >> Get exalted with the Frostwolf Clan
.goto Alterac Mountains,62.2,58.9
>> This step requires a summon to Alterac Mountains on launch day. Skip if you don't have one. We are turning in the AV Trinket Upgrade quest. Get to atleast revered, or exalted if you've already turned in the revered upgrade quest. Revered and Exalted give the same exp. This rep is gained by PvPing in Alterac Valley.
* Be sure to do Proving Grounds and unlock the base level of your trinket. This quest is picked up in Alterac Mountains
.accept 7161 >> Accept Proving Grounds
.turnin 7161 >> Turn in Proving Grounds
step << Alliance
.reputation 730,exalted >> Get exalted with the Stormpike Guard
.goto Alterac Mountains,39.6,81.2
>> This step requires a summon to Alterac Mountains on launch day. Skip if you don't have one. We are turning in the AV Trinket Upgrade quest. Get to atleast revered, or exalted if you've already turned in the revered upgrade quest. Revered and Exalted give the same exp. This rep is gained by PvPing in Alterac Valley.
* Be sure to do Proving Grounds and unlock the base level of your trinket. This quest is picked up in Alterac Mountains
.accept 7162 >> Accept Proving Grounds
.turnin 7162 >> Turn in Proving Grounds
step
.reputation 967,exalted >> Get exalted with The Violet Eye.
>> We are turning in the Kara ring upgrade quest. Get to atleast honored, all the turnins past honored are the same exp. Go up a rep rank if you've already turned in the ring upgrade quest this rank. You can stockpile multiple rep rewards for more exp! This rep is gained by running Karazhan.
step
.reputation 990,exalted >> Get exalted with The Scale of the Sands.
>> We are turning in the Hyjal ring upgrade quest. Get to atleast honored, all the turnins past honored are the same exp. Go up a rep rank if you've already turned in the ring upgrade quest this rank. This rep is gained by running Mount Hyjal.
step << Horde
.goto Hellfire Peninsula,87.4,48.2
.accept 10289 >> Accept Journey to Thrallmar
step << Horde
#completewith next
.goto Hellfire Peninsula,55.8,36.8
.fly Thrallmar >> Talk to the NPC again and fly to Thrallmar
step << Horde
.goto Hellfire Peninsula,55.8,36.8
.turnin 10289 >> Turn in Journey to Thrallnar
.accept 10291 >> Accept Report to Nazgrel
step << Horde
.goto Hellfire Peninsula,55.0,36.0
.turnin 10291 >> Turn in Report to Nazgrel
.accept 10121 >> Accept Eradicate the Burning Legion
step << Horde
>> Run outside of town
.goto Hellfire Peninsula,58.0,41.2
.turnin 10121 >> Turn in Eradicate the Burning Legion
.accept 10123 >> Accept Felspark Ravine
step << Horde
.goto Hellfire Peninsula,63.0,38.0
>> Kill Flamewalker Imps, Infernal Warbringers, and a Dreadcaller in the area
.complete 10123,1
.complete 10123,2
.complete 10123,3
step << Horde
.goto Hellfire Peninsula,58.0,41.2
.turnin 10123 >> Turn in Felspark Ravine
.accept 10124 >> Accept Forward Base: Reaver's Fall
step << Horde
.goto Hellfire Peninsula,65.8,43.6
.turnin 10124 >> Turn in Forward Base: Reaver's Fall
.accept 10208 >> Accept Disrupt Their Reinforcements
step << Horde
#sticky
#label disrupttransp
.goto Hellfire Peninsula,70.8,45.1
>>Use To'arch's Primers once you get 4 runestones to disable the Legion Transporter.
.complete 10208,1 
step << Horde
#label disrupttransp
.goto Hellfire Peninsula,74.1,38.9
>>Use To'arch's Primers once you gather 4 more runestones to disable the Legion Transporter.
.complete 10208,2 
step << Horde
#requires disrupttransp
.goto Hellfire Peninsula,65.9,43.6
.turnin 10208 >> Turn in Disrupt Their Reinforcements
.accept 10129 >> Accept Mission: Gateways Murketh and Shaadraz
step << Horde
.goto Hellfire Peninsula,78.0,51.2
.complete 10129,2 
step << Horde
.goto Hellfire Peninsula,78.2,47.7
.complete 10129,1 
step << Horde
.goto Hellfire Peninsula,65.9,43.6
.turnin 10129 >> Turn in Mission: Gateways Murketh and Shaadraz
.accept 10162 >> Accept Mission: The Abyssal Shelf
.accept 10388 >> Accept Return to Thrallmar
step << Horde
>>Use the Area 52 Special bomb to complete this quest as you fly over the Abyssal Shelf.
.complete 10162,3 
.complete 10162,1 
.complete 10162,2 
step << Horde
.goto Hellfire Peninsula,65.9,43.6
.turnin 10162 >> Turn in Mission: The Abyssal Shelf
step << Horde
.goto Hellfire Peninsula,55.0,36.0
.turnin 10388 >> Turn in Return to Thrallmar
.accept 9400 >> Accept The Assassin.
step << Horde
.goto Hellfire Peninsula,33.6,43.6
>> Fly to the orc corpse
.complete 9400,1
step << Horde
.goto Hellfire Peninsula,33.6,43.6
.turnin 9400 >> Turn in The Assassin
step << Alliance
.goto Hellfire Peninsula,87.4,50.7
.accept 10288 >> Accept Arrival in Outland
step << Alliance
.goto Hellfire Peninsula,87.4,52.4
.turnin 10288 >> Turn in Arrival in Outland
.accept 10140 >> Accept Journey to Honor Hold
step << Alliance
.goto Hellfire Peninsula,54.7,62.8
>> Either talk to the flight master again or fly yourself to Honor Hold
.skipgossip
.turnin 10140 >> Turn in Journey to Honor Hold
.accept 10254 >> Accept Force Commander Danath
step << Alliance
.goto Hellfire Peninsula,56.6,66.6
.turnin 10254 >> Accept Force Commander Danath
.accept 10141 >> Accept The Legion Reborn
step << Alliance
.goto Hellfire Peninsula,61.7,60.7
.turnin 10141 >> Turn in The Legion Reborn
.accept 10142 >> Accept The Path of Anguish
step << Alliance
.goto Hellfire Peninsula,67.0,58.6
>> Kill demons in the area
.complete 10142,1 
.complete 10142,2 
.complete 10142,3 
step << Alliance
.goto Hellfire Peninsula,61.7,60.7
.turnin 10142 >> Turn in The Path of Anguish
.accept 10143 >> Accept Expedition Point
step << Alliance
.goto Hellfire Peninsula,56.6,66.5
.accept 10047 >> Accept The Path of Glory from Warp-Scryer Kryv inside the keep.
step << Alliance
.goto Hellfire Peninsula,64.5,49.6,10,0
.goto Hellfire Peninsula,54.6,50.4,10,0
.use 25889
>> Use Draenei Holy Water on Trampled Skeletons found along the Path of Glory.
.complete 10047,1
step << Alliance
.goto Hellfire Peninsula,56.6,66.6
.turnin 10047 >> Turn in The Path of Glory
step << Alliance
.goto Hellfire Peninsula,23.0,40.4
>> Head to western Hellfire Peninsula
.accept 9390 >> Accept In Search of Sedai.
step << Alliance
.goto Hellfire Peninsula,26.8,37.6
.turnin 9390 >> Turn in In Search of Sedai.
step << Alliance
.reputation 946,friendly >> Get Friendly with Honor Hold so you can turn in Gaining Mirren's Trust at launch. Do this via spamming dungeons to minimize quest loss.
step << Horde
.goto Zangarmarsh,85.2,54.6
.accept 9774 >> Accept Thick Hydra Scales
step << Horde
.goto Zangarmarsh,84.1,39.0,80,0
.goto Zangarmarsh,85.2,54.6,80,0
.goto Zangarmarsh,80.1,34.3,80,0
.goto Zangarmarsh,81.0,41.3
>> Kill Hydras in the area and loot them for scales.
*They do NOT share spawns with the Giants.
.complete 9774,1
step << Horde
.goto Zangarmarsh,85.2,54.6
.turnin 9774 >> Turn in Thick Hydra Scales
step
.goto Zangarmarsh,78.4,62.0
.accept 9716 >> Accept Disturbance at Umbrafen Lake
step
.goto Zangarmarsh,70.8,81.3
.complete 9716,1
step
.goto Zangarmarsh,78.4,62.0
.turnin 9716 >> Turn in Disturbance at Umbrafen Lake
.accept 9718 >> Accept As the Crow Flies
step
.goto Zangarmarsh,78.4,62.0
.use 25465 >> Use Stormcrow Amulet and wait for quest to complete. It takes 2 minutes and 30 seconds, take a lil stretch break :)
.complete 9718,1
step
.goto Zangarmarsh,78.4,62.0
.turnin 9718 >> Turn in As the Crow Flies
.accept 9720 >> Accept Balance Must Be Preserved
step << skip
#label schemmy
.itemcount 24330,1
.use 24330 >> Use the Drain Schematics in your bag to accept the quest
.accept 9731 >> Accept Drain Schematics
step
.goto Zangarmarsh,70.6,80.3
.use 24355 >> Use the Ironvine Seeds to disable the console at Umbrafen Lake.
.complete 9720,1
step
.goto Zangarmarsh,25.2,43.6
.use 24355 >> Use the Ironvine Seeds to disable the console at Marshlight Lake.
.complete 9720,2
step << skip
#requires schemmy
.itemcount 24330,1
.goto Zangarmarsh,50.4,40.9
>> Explore the drain deep enough to get the quest completion.
.complete 9731,1
step
.goto Zangarmarsh,62.0,40.8
.use 24355 >> Use the Ironvine Seeds to disable at Serpent Lake.
.complete 9720,3
step
.goto Zangarmarsh,63.1,64.1
.use 24355 >> Use the Ironvine Seeds to disable at The Lagoon.
.complete 9720,4
step
.goto Zangarmarsh,78.4,62.0
.turnin 9720 >> Turn in Balance Must Be Preserved
step << skip
#requires schemmy
.itemcount 24330,1
.goto Zangarmarsh,78.4,62.0
.turnin 9731 >> Turn in Drain Schematics
step
#label thickysticky
.goto Terokkar Forest,44.4,26.2 
.accept 9968 >> Accept Strange Energy.
.accept 9971 >> Accept Clues in the Thicket.
step
#sticky
#requires thickysticky
.goto Terokkar Forest,45.1,21.8,40,0
.goto Terokkar Forest,44.4,30.8,40,0
.goto Terokkar Forest,45.1,21.8
>> Kill Terromoth and Vicious Terromoth for samples.
*Terromoths spawn on the south side, Vicious Terrormoths spawn north in the village.
.complete 9968,2
.complete 9968,1
step
.goto Terokkar Forest,45.1,21.8
>> Interact with the strange object on the floor of the inn.
.complete 9971,1
step
#requires thickysticky
.goto Terokkar Forest,44.4,26.2 
.turnin 9968 >> Turn in Strange Energy.
.turnin 9971 >> Turn in Clues in the Thicket.

step
.goto Terokkar Forest,44.4,26.2 
.accept 9978 >> Accept By Any Means Necessary.
step
.goto Terokkar Forest,38.3,26.6,80,0
.goto Terokkar Forest,50.3,29.0,80,0
.goto Terokkar Forest,38.3,26.6
.line Terokkar Forest,38.3,26.6,40.6,25.5,47.2,27.0,50.3,29.0
.skipgossip
>>Find Empoor on the road and fight him to convince him to tell you what he knows.
.unitscan Empoor
.turnin 9978 >> Turn in Accept By Any Means Necessary.
.accept 9979 >> Accept Wind Trader Lathrai.
step << Horde
.goto Terokkar Forest,48.8,45.6
.accept 10000 >> Accept An Unwelcome Presence
step << Horde
.goto Terokkar Forest,67.4,51.8
>> Kill Warped Peons in the area
.complete 10000,1 
step << Horde
.goto Terokkar Forest,63.4,42.6
.turnin 10000 >> Turn in An Unwelcome Presence
step << Alliance
.goto Terokkar Forest,58.2,54.8
.accept 9998 >> Accept Unruly Neighbors
step << Alliance
.goto Terokkar Forest,67.4,51.8
>> Kill Warped Peons in the area
.complete 9998,1 
step << Alliance
.goto Terokkar Forest,69.6,44.2
.turnin 9998 >> Turn in Unruly Neighbors
step
.goto Shattrath City,72.4,31.6
.turnin 9979 >> Turn in Wind Trader Lathrai.
.accept 10112 >> Accept A Personal Favor.
step
.goto Terokkar Forest,31.6,42.6
>> Kill and loot the Skithian mobs for stolen goods.
.complete 10112,1
step
.goto Shattrath City,72.2,30.9
.turnin 10112 >> Turn in A Personal Favor.
step
.goto Shattrath City,72.2,30.9
.accept 9990 >> Accept Investigate Tuurem.
step
>> Collect the sealed box in the ruins.
.goto Terokkar Forest,54.0,30.0
.complete 9990,1
step << Horde
.goto Terokkar Forest,44.4,26.2 
.turnin 9990 >> Turn in Investigate Tuurem.
.accept 9995 >> Accept What Are These Things?
step << Alliance
.goto Terokkar Forest,44.4,26.2 
.turnin 9990 >> Turn in Investigate Tuurem.
.accept 9994 >> Accept What Are These Things?
step << Horde
.goto Terokkar Forest,50.0,45.8
.turnin 9995 >> Turn in What Are These Things?
.accept 10448 >> Accept Report to Stonebreaker Camp.
step << Horde
.goto Terokkar Forest,50.0,44.8
.accept 9993 >> Accept Olemba Seed Oil.
step << Horde
#sticky
#completewith endofseedoil
#label seedoil
>> Collect Olemba Seeds around trees in Terokkar Forest as you quest.
* They look like little blue crystals.
.complete 9993,1
step << Horde
.goto Terokkar Forest,63.2,42.4
.turnin 10448 >> Turn in Report to Stonebreaker Camp.
.accept 9997 >> Accept Attack on Firewing Point.
step << Alliance
.goto Terokkar Forest,57.0,53.6
.turnin 9994 >> Turn in What Are These Things?
.accept 10444 >> Accept Report to the Allerian Post.
step << Alliance
.goto Terokkar Forest,69.6,44.0
.turnin 10444 >> Turn in Report to the Allerian Post.
.accept 9996 >> Accept Attack on Firewing Point.
step << Alliance
.goto Terokkar Forest,71.6,37.8
>> Kill the Firewing Defenders, Bloodwarders and Warlocks.
.complete 9996,1
.complete 9996,2
.complete 9996,3
step << Horde
.goto Terokkar Forest,71.6,37.8
>> Kill the Firewing Defenders, Bloodwarders and Warlocks.
.complete 9997,1
.complete 9997,2
.complete 9997,3
step << Alliance
.goto Terokkar Forest,69.6,44.0
.turnin 9996 >> Turn in Attack on Firewing Point.
.accept 10446 >> Accept The Final Code.
step << Horde
.goto Terokkar Forest,63.2,42.4
.turnin 9997 >> Turn in Attack on Firewing Point.
.accept 10447 >> Accept The Final Code.
step
#sticky
#completewith endofseedoil
.goto Terokkar Forest,73.6,36.0
>> Fly to the top of the tower
step << Alliance
.goto Terokkar Forest,73.8,35.8
>> Kill Sharth Voldoun for The Final Code.
.collect 29912,1,10446,1
step << Horde
.goto Terokkar Forest,73.8,35.8
>> Kill Sharth Voldoun for The Final Code.
.collect 29912,1,10447,1
step << Horde
.goto Terokkar Forest,71.3,37.4
.use 29912 >> Click on the pillar in the center of Firewing Point
.complete 10447,1
step << Alliance
.goto Terokkar Forest,71.3,37.4
.use 29912 >> Click on the pillar in the center of Firewing Point
.complete 10446,1
step << Horde
.goto Terokkar Forest,50.0,45.8
.turnin 10447 >> Turn in The Final Code.
step << Alliance
.goto Terokkar Forest,57.0,53.5
.turnin 10446 >> Turn in The Final Code.
step << Horde
#requires seedoil
.goto Terokkar Forest,50.1,44.9
.turnin 9993 >> Turn in Olemba Seed Oil.
step
#label endofseedoil
.goto Terokkar Forest,49.8,76.2
.accept 10920 >> Accept For the Fallen.
step
.goto Terokkar Forest,51.8,78.8,30,0
.goto Terokkar Forest,55.6,61.2
>> Kill Dreadfang Widows along the edges of the Bone Wastes.
.complete 10920,1
step
.goto Terokkar Forest,49.8,76.2
.turnin 10920 >> Turn in For the Fallen.
.accept 10921 >> Accept Terokkarantula.
step
.goto Terokkar Forest,54.0,81.6
>> Kill Terokkarantula. This is an elite quest, you may need help.
.complete 10921,1
step
.goto Terokkar Forest,49.8,76.2
.turnin 10921 >> Turn in Terokkarantula.
step
.goto Terokkar Forest,35.0,65.2
>> Find Ha'lei near the enterance to the Auchenai Crypts.
.accept 10227 >> Accept I See Dead Draenei.
step
.goto Terokkar Forest,35.1,66.0
.turnin 10227 >> Turn in I See Dead Draenei.
.accept 10228 >> Accept Ezekiel.
step << Horde
.goto Nagrand,55.6,37.6
>> Head to Nagrand
.accept 9888 >> Accept The Impotent Leader.
step << Horde
.goto Terokkar Forest,19.8,60.8
.turnin 9888 >> Turn in The Impotent Leader.
.accept 9889 >> Accept Don't Kill the Fat One.
step << Horde
.goto Terokkar Forest,19.8,62.6
>> Kill 10 Boulderfist Invaders. Do not fight Unkor the Ruthless yet.
.complete 9889,1
step << Horde
.goto Terokkar Forest,20.0,63.4
>> Beat up Unkor untill he submits.
.complete 9889,2
.turnin 9889 >> Turn in Don't Kill the Fat One.
.accept 9890 >> Accept Success!
step << Horde
.goto Terokkar Forest,19.6,60.8
.turnin 9890 >> Turn in Success!
.accept 9891 >> Accept Because Kilrath is a Coward.
step << Horde
.goto Nagrand,55.6,37.6
.turnin 9891 >> Turn in Because Kilrath is a Coward.
.accept 9906 >> Accept Message in a Battle.
step << Horde
.goto Nagrand,76.4,61.6,20,0
.goto Nagrand,74.6,69.6
>> Kill Boulderfist Ogres.
.complete 9906,1
.complete 9906,2
step << Horde
.goto Nagrand,55.6,37.6
.turnin 9906 >> Turn in Message in a Battle.
.accept 9907 >> Accept An Audacious Advance.
step << Horde
.goto Nagrand,49.6,56.4
.goto Nagrand,40.8,31.6
>> Kill Boulderfist Ogres.
.complete 9907,1
.complete 9907,2
step << Horde
.goto Nagrand,55.6,37.6
.turnin 9907 >> Turn in An Audacious Advance.
.accept 10107 >> Accept Diplomatic Measures.
step << Horde
.goto Nagrand,73.8,62.6
>> Speak to Lantressor and go through his dialogue
.skipgossip
.turnin 10107 >> Turn in Diplomatic Measures.
.accept 9928 >> Accept Armaments for Deception.
.accept 9927 >> Accept Ruthless Cunning.
step << Horde
.goto Nagrand,69.4,81.4
>> Pick up Kil'sorrow Armaments from boxes around the fortress.
.complete 9928,1
>> Kill Kil'sorrow enemies and plant banners on their corpses. You don't have to target the corpse.
.use 25552
.complete 9927,1
step << Horde
.goto Nagrand,73.8,62.6
.turnin 9928 >> Turn in Armaments for Deception.
.turnin 9927 >> Turn in Ruthless Cunning.
.accept 9931 >> Accept Returning the Favor.
.accept 9932 >> Accept Body of Evidence.
step << Horde
.goto Nagrand,54.8,39.8
.accept 9864 >> Accept The Missing War Party.
step << Horde
#sticky
.goto Nagrand,46.7,24.3
>> Use Damp Woolen Blanket while standing next to the pyre.
* Boulderfist Saboteurs will spawn, protect them if any ogres aggro to them.
.use 25658
.complete 9932,1
step << Horde
.goto Nagrand,46.0,20.2
>> Kill Warmaul Ogres and plant banners on their corpses. You don't have to target the corpse.
.use 25555
.complete 9931,1
step << Horde
.goto Nagrand,32.4,36.0
.turnin 9864 >> Turn in The Missing War Party.
.accept 9865 >> Accept Once Were Warriors.
step << Horde
.goto Nagrand,73.8,62.6
.turnin 9931 >> Turn in Returning the Favor.
.turnin 9932 >>	Turn in Body of Evidence.
step << Horde
.goto Nagrand,32.6,42.6
>> Kill Murkblood Scavengers and Raiders.
.complete 9865,1
.complete 9865,2
step << Horde
.goto Nagrand,32.4,36.0
.turnin 9865 >> Turn in Once Were Warriors.
step << Alliance
.goto Nagrand,55.0,70.6
.accept 9917 >> Accept Do My Eyes Deceive Me.
step << Alliance
.goto Nagrand,62.8,72.4
>> Kill Boulderfist Hunters for the Plans.
.complete 9917,1
step << Alliance
.goto Nagrand,55.0,70.6
.turnin 9917 >> Turn in Do My Eyes Deceive Me.
.accept 9918 >> Accept Not On My Watch!
step << Alliance
.goto Nagrand,62.6,71.6
>> Beat up Lump untill he surrenders, then speak to him.
.skipgossip
.complete 9918,1
step << Alliance
.goto Nagrand,55.0,70.6
.turnin 9918 >> Turn in Not On My Watch!
.accept 9920 >> Accept Mo'mor the Breaker.
step << Alliance
.goto Nagrand,54.6,72.2
.turnin 9920 >> Turn in Mo'mor the Breaker.
.accept 9921 >> Accept The Ruins of Burning Blade.
step << Alliance
.goto Nagrand,74.6,68.6,40,0
>> Kill Boulderfist Ogres around the camp
.complete 9921,1
.complete 9921,2
step << Alliance
.goto Nagrand,54.6,72.2
.turnin 9921 >> Turn in The Ruins of Burning Blade.
.accept 9922 >> Accept The Twin Clefts of Nagrand.
step << Alliance
.goto Nagrand,50.2,56.8,40,0
.goto Nagrand,40.8,31.6,40,0
>> Kill Boulderfist Ogres around the camp
.complete 9922,1
.complete 9922,2
step << Alliance
.goto Nagrand,54.6,72.2
.turnin 9922 >> Turn in The Twin Clefts of Nagrand.
.accept 10108 >> Accept Diplomatic Measures.
step << Alliance
.goto Nagrand,55.4,68.8
.accept 11044 >> Accept Visions of Destruction
step << Alliance
.goto Nagrand,73.8,62.6
>> Speak with Lantresor.
.skipgossip
.complete 10108,1
.turnin 10108 >> Turn in Diplomatic Measures.
.accept 9928 >> Accept Armaments for Deception.
.accept 9927 >> Accept Ruthless Cunning.
step << Alliance
.goto Nagrand,69.4,81.4
>> Pick up Kil'sorrow Armaments from boxes around the fortress.
.complete 9928,1
>> Kill Kil'sorrow enemies and plant banners.
.use 25552
.complete 9927,1
step << Alliance
.goto Nagrand,73.8,62.6
.turnin 9928 >> Turn in Armaments for Deception.
.turnin 9927 >> Turn in Ruthless Cunning.
.accept 9931 >> Accept Returning the Favor.
.accept 9932 >> Accept Body of Evidence.
step << Alliance
#sticky
.goto Nagrand,46.7,24.3
>> Use Damp Woolen Blanket while standing next to the pyre. Protect the Saboteurs once they spawn.
.use 25658
.complete 9932,1
step << Alliance
.goto Nagrand,46.0,20.2
>> Kill Warmaul Ogres and plant banners.
.use 25555
.complete 9931,1
step << Alliance
.goto Nagrand,73.8,62.6
.turnin 9931 >> Turn in Returning the Favor.
.turnin 9932 >>	Turn in Body of Evidence.
step
.goto Nagrand,27.4,43.0
>> Make sure you are dismounted.
.accept 9991 >> Accept Survey the Land.
step
>> Scout the forge camps while flying. This takes roughly 2 minutes, feel free to get up and stretch :D
.complete 9991,1
.turnin 9991 >> Turn in Survey the Land.
.accept 9999 >> Accept Buying Time.
step
.goto Nagrand,24.4,37.4,30,0
.goto Nagrand,19.6,51.4
>> Kill the demons around the forge camps. This is an elite quest, you may need help.
.complete 9999,1
.complete 9999,2
.complete 9999,3
step
.goto Nagrand,27.4,43.0
.turnin 9999 >> Turn in Buying Time.
.accept 10001 >> Accept The Master Planner.
step
.goto Nagrand,23.6,34.8
>> Kill Mo'arg Master Planner for the blueprints.
.complete 10001,1
step
.goto Nagrand,27.4,43.0
.turnin 10001 >> Turn in The Master Planner.
.accept 10004 >> Accept Patience and Understanding.
step
.goto Shattrath City,77.2,34.8
.skipgossip
>> Head to Shattrath. Speak with Sal'salabim to fight him. << !Mage
>> Teleport to Shattrath. Speak with Sal'salabim to fight him. << Mage
.turnin 10004 >> Turn in Patience and Understanding.
.accept 10009 >> Accept Crackin' Some Skulls.
step
.goto Shattrath City,75.0,31.8
.skipgossip
>> Get the debt from Raliq the Drunk.
.complete 10009,1
step
.goto Shattrath City,61.2,49.6
>> Find Ezekiel, go around the structure counter-clockwise.
.unitscan Ezekiel
.turnin 10228 >> Turn in Ezekiel.
.accept 10231 >> Accept What Book? I Don't See Any Book.
step
.goto Shattrath City,43.6,29.4
.skipgossip
>> Go beat down Dirty Larry. You may need to wait for him to respawn if he's not alive.
* He is an elite, you may need help.
.complete 10231,1
step
.goto Shattrath City,43.6,29.4
.turnin 10231 >> Turn in What Book? I Don't See Any Book.
step
.goto Zangarmarsh,81.0,91.6
.skipgossip
>> Get the debt from Coosh'coosh.
.complete 10009,2
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 11044 >> Turn in Visions of Destruction
.accept 10562 >> Accept Besieged!
step << Alliance
.goto Shadowmoon Valley,36.4,56.8
.accept 10680 >> Accept The Hand of Gul'dan
step << Alliance
.goto Shadowmoon Valley,38.8,54.2
.accept 10569 >> Accept The Skethlon Wreckage
step << Alliance
.goto Shadowmoon Valley,39.0,50.0
>> Head north and kill Infernals, the ones around the keep don't always give credit
.complete 10562,1 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10562 >> Turn in Besieged!
.accept 10563 >> Accept To Legion Hold
step << Alliance
.goto Shadowmoon Valley,23.4,36.8
.use 30638 >> Use the Box of Tricks to disguise yourself next to the communication device. This roleplay takes roughly a minute.
.complete 10563,1 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10563 >> Turn in To Legion Hold
.accept 10572 >> Accept Setting Up the Bomb
step << Alliance
.goto Shadowmoon Valley,26.2,41.1,40,-1
.goto Shadowmoon Valley,22.2,35.4,40,-1
>> Loot the Fel Reaver Power Core and Armor plate from the ground. The power core is underwater.
.complete 10572,1 
.complete 10572,2 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10572 >> Turn in Setting Up the Bomb
.accept 10564 >> Accept Blast the Infernals!
step << Alliance
.goto Shadowmoon Valley,22.6,39.9
.use 30614 >> Use the bomb in the green circle. It pulses every 5 seconds if you don't see it right away.
.complete 10564,1 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10564 >> Turn in Blast the Infernals
.accept 10573 >> Accept The Deathforge
step << Alliance
.goto Shadowmoon Valley,40.4,41.4
.turnin 10573 >> Turn in The Deathforge
.accept 10582 >> Accept Minions of the Shadow Council
step << Alliance
.goto Shadowmoon Valley,40.0,39.0
>> Head into the cave and kill Deathforge enemies in the area
.complete 10582,1 
.complete 10582,2 
step << Alliance
.goto Shadowmoon Valley,40.4,41.4
>> Head back to the tower
.turnin 10582 >> Turn in Minions of the Shadow Council
.accept 10583 >> Accept The Fate of Flanis
.accept 10585 >> Accept The Summoning Chamber
step << Alliance
#sticky
#label elementald2
.goto Shadowmoon Valley,40.0,39.0
>> Kill Deathforge Smiths and Tinkerers. Loot them for an Elemental Displacer
.collect 30672,1,10585,1
step << Alliance
.goto Shadowmoon Valley,40.0,38.0,60,0
.goto Shadowmoon Valley,34.0,39.0
>> Head back into the caves below. Continue across the bridge then take a right past the Infernals. Talk to the corpse of Flanis
.unitscan Flanis Swiftwing
.skipgossip
.collect 30658,1,10583,1
step << Alliance
#requires elementald2
.goto Shadowmoon Valley,37.0,38.0
.use 30672 >> Head to the lower level then use the Elemental Displacer to disrupt the ritual where Summoner Skartax is
.unitscan Summoner Skartax
.complete 10585,1 
step << Alliance
.goto Shadowmoon Valley,40.4,41.4
>> Head back to the tower
.turnin 10583 >> Turn in The Fate of Flanis
.turnin 10585 >> Turn in The Summoning Chamber
.accept 10586 >> Accept Bring Down the Warbringer!
step << Alliance
.goto Shadowmoon Valley,39.0,46.0,20,0
.goto Shadowmoon Valley,37.4,42.6
.use 30688 >> Head back into the upper level caves, cross the bridge then use the key to open the porticulus on the left hand side. Kill Warbringer Razuun at the back of the room and loot him for his orders.
.unitscan Warbringer Razuun
.complete 10586,1 
.collect 30689,1,10586,1
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10586 >> Turn in Bring Down the Warbringer!
.accept 10589 >> Accept Gaining Access
step << Alliance
.goto Shadowmoon Valley,42.2,45.0
.turnin 10680 >> Turn in The Hand of Gul'dan
.accept 10458 >> Accept Enraged Spirits of Fire and Earth
step << Alliance
.goto Shadowmoon Valley,46.7,46.1
.use 30094 >>Use the totem of spirits and kill fire/earth elementals next to the totem.
*The range is around 25 yards for the totem to work.
.complete 10458,1 
.complete 10458,2 
step << Alliance
.goto Shadowmoon Valley,42.1,45.1
.turnin 10458 >> Turn in Enraged Spirits of Fire and Earth
.accept 10480 >> Accept Enraged Spirits of Water
step << Alliance
.goto Shadowmoon Valley,51.4,27.5
.use 30094 >>Use the totem of spirits in your bags and kill water elementals next to the totem
*The range is around 25 yards for the totem to work.
.complete 10480,1 
step << Alliance
.goto Shadowmoon Valley,42.2,45.1
.turnin 10480 >> Turn in Enraged Spirits of Water
.accept 10481 >> Accept Enraged Spirits of Air
step << Alliance
.goto Shadowmoon Valley,60.8,66.6
.use 30094 >>Use the totem of spirits in your bags and kill air elementals next to the totem. Some elementals can also spawn in the Netherwing Fields to the north.
*The range is around 25 yards for the totem to work.
.complete 10481,1 
step << Alliance
.goto Shadowmoon Valley,42.3,45.0
.turnin 10481 >> Turn in Enraged Spirits of Air
.accept 10513 >> Accept Oronok Torn-heart
step << Alliance
.goto Shadowmoon Valley,22.4,33.4
>> Kill Mo'arg Weaponsmith and loot them for a Legion Teleporter Control
.collect 30695,1,10589,1
step << Alliance
.goto Shadowmoon Valley,37.4,30.4
>> Kill Dark Conclave mobs in the area and loot them for their journal pages
.complete 10569,1 
.complete 10569,2 
.complete 10569,3 
step << Alliance
.goto Shadowmoon Valley,39.4,53.6
.turnin 10589 >> Turn in Gaining Access
.accept 10766 >> Accept Invasion Point: Cataclysm
step << Alliance
.goto Shadowmoon Valley,38.8,54.2
.turnin 10569 >> Turn in The Skethlon Wreckage
.accept 10759 >> Accept Find the Deserter
step << Alliance
.goto Shadowmoon Valley,35.4,41.8
.turnin 10759 >> Turn in Find the Deserter
.accept 10777 >> Accept Asghar's Totem
step << Alliance
.goto Shadowmoon Valley,40.0,30.8
>> Find Asghar, kill and loot him for his totem
.unitscan Asghar
.complete 10777,1 
step << Alliance
.goto Shadowmoon Valley,40.8,22.2
.turnin 10766 >> Turn in Invasion Point: Cataclysm
.accept 10606 >> Accept The Art of Fel Reaver Maintenance
step << Alliance
.goto Shadowmoon Valley,39.6,19.6
>> Kill Doctor Gutrick and loot him for the Doctor's Key.
.unitscan Doctor Gutrick
.collect 30712,1,10606,1
step << Alliance
.goto Shadowmoon Valley,39.6,19.6
.use 30712 >>Use the key to open the Doctor's Strongbox to retrieve The Art of Fel Reaver Maintenance
.collect 30713,1,10606,1
step << Alliance
.goto Shadowmoon Valley,40.8,22.2
.turnin 10606 >> Turn in The Art of Fel Reaver Maintenance
.accept 10612 >> Accept The Fel and the Furious
step << Alliance
.goto Shadowmoon Valley,40.8,22.2
>> Use a Fel Reaver Control Console to destroy 60 Deathforged Infernals
.complete 10612,1 
step << Alliance
.goto Shadowmoon Valley,40.8,22.2
.turnin 10612 >> Turn in The Fel and the Furious
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.accept 10595 >> Accept Besieged!
step << Horde
.goto Shadowmoon Valley,29.8,27.8
.accept 10624 >> Accept A Haunted History
step << Horde
.goto Shadowmoon Valley,31,29.8
.accept 10760 >> Accept The Sketh'lon Wreckage
step << Horde
#sticky
#completewith next
>> Loot Ever-Burning Ash piles as you kill Infernal Attackers
.complete 10624,1 
step << Horde
.goto Shadowmoon Valley,32.0,32.0,80,0
.goto Shadowmoon Valley,30.7,36.2,60,0
.goto Shadowmoon Valley,32.0,32.0
>> Kill Infernal Attackers
.complete 10595,1 
step << Horde
.goto Shadowmoon Valley,32.2,38.1,60,0
>> Finish looting Ever-Burning Ash Piles
.complete 10624,1 
step << Horde
.goto Shadowmoon Valley,37.4,30.4
>> Kill Dark Conclave mobs in the area and loot them for their journal pages
.complete 10760,1 
.complete 10760,2 
.complete 10760,3 
step << Horde
.goto Shadowmoon Valley,29.8,27.8
.turnin 10624 >> Turn in A Haunted History
.accept 10625 >> Accept Spectrcles
step << Horde
.goto Shadowmoon Valley,29.8,27.8
.use 30719 >> Equip the goggles and kill spirits around the town
.complete 10625,1 
step << Horde
.goto Shadowmoon Valley,29.8,27.8
>> Make sure to re-equip your normal helmet
.turnin 10625 >> Turn in Spectercles
step << Horde
.goto Shadowmoon Valley,31.0,29.8
.turnin 10760 >> Turn in The Sketh'lon Wreckage
.accept 10761 >> Accept Find the Deserter
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10595 >> Turn in Besieged!
.accept 10596 >> Accept To Legion Hold
step << Horde
.goto Shadowmoon Valley,23.4,36.8
.use 30638 >> Use the Box of Tricks to disguise yourself next to the communication device. This roleplay takes roughly a minute.
.complete 10596,1 
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10596 >> Turn in To Legion Hold
.accept 10597 >> Setting Up the Bomb
step << Horde
.goto Shadowmoon Valley,26.2,41.1,20,-1
.goto Shadowmoon Valley,22.2,35.4,20,-1
>> Loot the Fel Reaver Power Core and Armor plate. The power core is underwater.
.complete 10597,1 
.complete 10597,2 
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10597 >> Turn in Setting Up the Bomb
.accept 10598 >> Accept Blast the Infernals!
step << Horde
.goto Shadowmoon Valley,22.6,39.9
.use 30614 >> Use the fel bomb in the green circle. It pulses every 5 seconds if you don't see it right away.
.complete 10598,1 
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10598 >> Turn in Blast the Infernals!
.accept 10599 >> Accept The Deathforge
step << Horde
.goto Shadowmoon Valley,38.6,38.2
>> Head to the roof
.turnin 10599 >> Turn in The Deathforge
.accept 10600 >> Accept Minions of the Shadow Council
step << Horde
.goto Shadowmoon Valley,40.0,39.0
>> Head into the cave and kill Deathforge enemies in the area
.complete 10600,1 
.complete 10600,2 
step << Horde
.goto Shadowmoon Valley,38.6,38.2
.turnin 10600 >> Turn in Minions of the Shadow Council
.accept 10601 >> Accept The Fate of Kagrosh
.accept 10602 >> Accept The Summoning Circle
step << Horde
#sticky
#label elementald
.goto Shadowmoon Valley,40.0,39.0
>> Kill Deathforge Smiths and Tinkerers. Loot them for an Elemental Displacer
.collect 30672,1,10602,1
step << Horde
.goto Shadowmoon Valley,40.0,39.0,40,0
.goto Shadowmoon Valley,35.2,40.1
.unitscan Kagrosh
.skipgossip
>> Head back into the caves below. Continue across the bridge then take a right past the Infernals. Talk to the orc body and take his pack
.collect 30659,1,10601,1
step << Horde
#requires elementald
.goto Shadowmoon Valley,37.0,38.0
.use 30672 >> Head to the lower level then use the Elemental Displacer to disrupt the ritual where Summoner Skartax is
.unitscan Summoner Skartax
.complete 10602,1 
step << Horde
.goto Shadowmoon Valley,38.6,38.2
>> Head back outside to the tower roof
.turnin 10601 >> Turn in The Fate of Kagrosh
.turnin 10602 >> Turn in The Summoning Circle
.accept 10603 >> Accept Bring Down the Warbringer!
step << Horde
.goto Shadowmoon Valley,40.0,39.0,40,0
.goto Shadowmoon Valley,38.9,46.7
.use 30688 >> Head back into the caves where you killed Smiths and Tinkerers. Use the key to open the porticulus on the left side of the room, then kill Warbringer Razuun and loot him for his orders.
.unitscan Warbringer Razuun
.complete 10603,1 
.collect 30689,1,10603,1
step << Horde
>> Head back to the tower
.goto Shadowmoon Valley,30.4,32.4
.turnin 10603 >> Turn in Bring Down the Warbringer
.accept 10604 >> Accept Gaining Access
step << Horde
.goto Shadowmoon Valley,35.4,41.8
.turnin 10761 >> Turn in Find the Deserter
.unitscan Parshah
.accept 10777 >> Accept Asghar's Totem
step << Horde
.goto Shadowmoon Valley,40.0,30.8
>> Find Asghar, kill and loot him for his totem
.unitscan Asghar
.complete 10777,1 
step << Horde
.goto Shadowmoon Valley,28.4,26.6
.accept 10681 >> Accept The Hand of Gul'dan
step << Horde
.goto Shadowmoon Valley,42.2,45.0
.turnin 10681 >> Turn in The Hand of Gul'dan
.accept 10458 >> Accept Enraged Spirits of Fire and Earth
step << Horde
.goto Shadowmoon Valley,46.7,46.1
.use 30094 >>Use the totem of spirits and kill fire/earth elementals next to the totem.
*The range is around 25 yards for the totem to work.
.complete 10458,1 
.complete 10458,2 
step << Horde
.goto Shadowmoon Valley,42.1,45.1
.turnin 10458 >> Turn in Enraged Spirits of Fire and Earth
.accept 10480 >> Accept Enraged Spirits of Water
step << Horde
.goto Shadowmoon Valley,51.4,27.5
.use 30094 >>Use the totem of spirits in your bags and kill water elementals next to the totem
*The range is around 25 yards for the totem to work.
.complete 10480,1 
step << Horde
.goto Shadowmoon Valley,42.2,45.1
.turnin 10480 >> Turn in Enraged Spirits of Water
.accept 10481 >> Accept Enraged Spirits of Air
step << Horde
.goto Shadowmoon Valley,60.8,66.6
.use 30094 >>Use the totem of spirits in your bags and kill air elementals next to the totem. Some elementals can also spawn in the Netherwing Fields to the north.
*The range is around 25 yards for the totem to work.
.complete 10481,1 
step << Horde
.goto Shadowmoon Valley,42.3,45.0
.turnin 10481 >> Turn in Enraged Spirits of Air
.accept 10513 >> Accept Oronok Torn-heart
step << Horde
.goto Shadowmoon Valley,22.4,33.4
>> Kill Mo'arg Weaponsmith and loot them for a Legion Teleporter Control
.collect 30695,1,10604,1
step << Horde
.goto Shadowmoon Valley,30.4,32.4
.turnin 10604 >> Turn in Gaining Access
.accept 10767 >> Accept Invasion Point: Cataclysm
step << Horde
.goto Shadowmoon Valley,27.4,21.2
.turnin 10767 >> Turn in Invasion Point: Cataclysm
.accept 10611 >> Accept The Art of Fel Reaver Maintenance
step << Horde
.goto Shadowmoon Valley,28.9,20.6
>> Kill Doctor Maleficus and loot him for the Doctor's Key.
.unitscan Doctor Maleficus
.collect 30712,1,10611,1
step << Horde
.goto Shadowmoon Valley,38.9,20.5
.use 30712 >>Use the key to open the Doctor's Strongbox to retrieve The Art of Fel Reaver Maintenance
.collect 30713,1,10611,1
step << Horde
.goto Shadowmoon Valley,27.4,21.2
.turnin 10611 >> Turn in The Art of Fel Reaver Maintenance
.accept 10613 >> Accept The Fel and the Furious
step << Horde
.goto Shadowmoon Valley,27.8,19.8
>> Use a Fel Reaver Control Console to destroy 60 Deathforged Infernals
* Using the first Fel Reaver ability destroys the Infernals, the rest of the buttons are rather irrelevant.
.complete 10613,1 
step << Horde
.goto Shadowmoon Valley,27.4,21.2
.turnin 10613 >> Turn in The Fel and the Furious
step
.goto Shadowmoon Valley,54.0,23.6
.turnin 10513 >> Turn in Oronok Torn-heart
.accept 10514 >> Accept I Was A Lot Of Things...
step
.goto Shadowmoon Valley,54.0,16.0
.use 30462 >>Stand on top of the small plants on the ground and use the boar whistle to have a nearby boar dig out the tubers. Click it afterwards.
* You may need to kill Flayers in the area, so they stop killing the boars near tubers.
.complete 10514,1 
step
.goto Shadowmoon Valley,53.9,23.5
.turnin 10514 >> Turn in I Was A Lot Of Things...
.accept 10515 >> Accept A Lesson Learned
step
.goto Shadowmoon Valley,56.6,17.0
>>Destroy eggs around this area, be careful with the big elite mob patrolling the area
.complete 10515,1 
step
.goto Shadowmoon Valley,53.9,23.4
.turnin 10515 >> Turn in A Lesson Learned
.accept 10519 >> Accept The Cipher of Damnation - Truth and History
>> Speak with Oronok
.skipgossip
.complete 10519,1 
step
.goto Shadowmoon Valley,53.9,23.4
.turnin 10519 >> Turn in The Cipher of Damnation - Truth and History
.accept 10521 >> Accept Grom'tor, Son of Oronok
.accept 10527 >> Accept Ar'tor, Son of Oronok
.accept 10546 >> Accept Borak, Son of Oronok
step
.goto Shadowmoon Valley,44.6,23.7
.turnin 10521 >> Turn in Grom'tor, Son of Oronok
.accept 10522 >> Accept The Cipher of Damnation - Grom'tor's Charge
step
.goto Shadowmoon Valley,46.0,28.2
>>Kill Nagas to get Chest Keys, open the chests until you loot the fragment
.complete 10522,1 
step
.goto Shadowmoon Valley,44.6,23.7
.turnin 10522 >> Turn in The Cipher of Damnation - Grom'tor's Charge
step
.goto Shadowmoon Valley,35.4,41.8
.turnin 10777 >> Turn in Asghar's Totem
.accept 10778 >> Accept The Rod of Lianthe
step
.goto Shadowmoon Valley,47.5,57.3
.turnin 10546 >> Turn in Borak, Son of Oronok
.accept 10547 >> Accept Of Thistleheads and Eggs...
step
.goto Shadowmoon Valley,45.1,57.4
>>Look for rotten eggs on the ground, be careful because they can damage you upon looting
.complete 10547,1 
step
.goto Shattrath City,64.1,69.8
>> Head to Shattrath. Hearth if it's up and set to Shattrath.
.turnin 10547 >> Turn in Of Thistleheads and Eggs...
.accept 10550 >> Accept The Bundle of Bloodthistle
step
.isOnQuest 10009
.goto Terokkar Forest,27.2,57.8
.skipgossip
>> Get the debt from Floon.
.complete 10009,3
step
>> Head back to Shadowmoon Valley
.goto Shadowmoon Valley,29.6,50.3
.turnin 10527 >> Turn in Ar'tor, Son of Oronok
.accept 10528 >> Accept Demonic Crystal Prisons
step
.goto Shadowmoon Valley,28.0,47.7
>>Slay Painmistress Gabrissa
.complete 10528,1 
step
.goto Shadowmoon Valley,29.6,50.5
.turnin 10528 >> Turn in Demonic Crystal Prisons
>> Wait for Ar'tor to die then talk to his spirit
.accept 10537 >> Accept Lohn'goron, Bow of the Torn-heart
step
.goto Shadowmoon Valley,30.5,50.0
>>Kill and loot Illidari mobs around the quest giver.
* The drop rate is very low, just keep killing
.complete 10537,1 
step
.goto Shadowmoon Valley,29.5,50.5
.turnin 10537 >> Turn in Lohn'goron, Bow of the Torn-heart
.accept 10540 >> Accept The Cipher of Damnation - Ar'tor's Charge
step
.goto Shadowmoon Valley,29.5,57.5
>>Head southeast while Ar'tor's spirit is following you, walk around this area until Ar'tor summons Veneratus the Many
.complete 10540,1 
>>Be ready for a long fight, Veneratus has 3 times more health than a normal mob
step
.goto Shadowmoon Valley,29.5,50.6
.turnin 10540 >> Turn in The Cipher of Damnation - Ar'tor's Charge
step
.goto Shadowmoon Valley,47.5,57.2
.turnin 10550 >> Turn in The Bundle of Bloodthistle
.accept 10570 >> Accept To Catch A Thistlehead
step
.goto Shadowmoon Valley,48.9,57.4
>>Plant the bundle of Bloodthistle at the end of the bridge. Head back to the other side, then go attakc once Borak whispers to you.
.complete 10570,1 
step
.goto Shadowmoon Valley,47.6,57.2
.turnin 10570 >> Turn in To Catch A Thistlehead
.accept 10576 >> Accept The Shadowmoon Shuffle
step
#sticky
#label liantherod
.goto Shadowmoon Valley,47.2,67.0
>> Kill Eclipsion mobs in the area until they drop Lianthe's Key
.complete 10778,1 
step
.goto Shadowmoon Valley,49.6,62.2
>> Kill and loot Eclipsion mobs in the area
.complete 10576,1 
step
#requires liantherod
.goto Shadowmoon Valley,47.5,71.7
>> Use the key on Lianthe's Strongbox and loot the Rod of Lianthe
.complete 10778,2 
step
.goto Shadowmoon Valley,35.4,41.8
>> The turn in can patrol up the road from here
.turnin 10778 >> Turn in Rod of Lianthe
.accept 10780 >> Accept Sketh'lon Feathers
step
.goto Shadowmoon Valley,43.7,57.5
>> Loot feathers on the ground
.complete 10780,1 
step
.goto Shadowmoon Valley,47.6,57.2
.turnin 10576 >> Turn in The Shadowmoon Shuffle
.accept 10577 >> Accept What Illidan Wants, Illidan Gets...
step
.goto Shadowmoon Valley,46.5,71.9
.skipgossip
>>Use the disguise provided and talk to the blood elf guarded by 2 orcs
.complete 10577,1 
step
.goto Shadowmoon Valley,47.5,57.2
.turnin 10577 >> Turn in What Illidan Wants, Illidan Gets...
.accept 10578 >> Accept The Cipher of Damnation - Borak's Charge
step
.goto Shadowmoon Valley,62.6,57.2
>> Kill and loot Ruul the Darkener
* You will need to group for this quest, he is very difficult.
.unitscan Ruul the Darkener
.complete 10578,1 
step
.goto Shadowmoon Valley,47.5,57.2
.turnin 10578 >> Turn in The Cipher of Damnation - Borak's Charge
step
.goto Shadowmoon Valley,35.4,41.8
.turnin 10780 >> Turn in Sketh'lon Feathers
step
>> Head back to Shattrath. << !Mage
>> Teleport back to Shattrath << Mage
.goto Shattrath City,77.2,34.8
.turnin 10009 >> Turn in Crackin' Some Skulls.

step
.goto Shattrath City,59.7,41.5
.accept 10210 >> Accept A'dal
step
.goto Shattrath City,54.5,44.9
.turnin 10210 >> Turn in A'dal
step
.goto Shattrath City,54.5,44.9
>> Speak with Khadgar
.accept 10211 >> Accept City of Light
step
.goto Shattrath City,48.1,42.0
>> Head to the second floor tunnel near G'eras and wait. If someone elses Servant arrives in the meantime, you can target it and it will complete the quest for you. Otherwise it will take 8 minutes and 30 seconds for your own servant to arrive. Take a stretch break!
.complete 10211,1 
step
.goto Shattrath City,54.5,44.9
.turnin 10211 >> Turn in City of Light
step
#label choice
#completewith aldorOrScryer
.goto Shattrath City,54.5,44.1
+ Choose an Allegiance to the Aldor or Scryer. They both give the same amount of prep exp for Wrath, so choose whichever you prefer. Manually skip this step once you have chosen.
* If you do not see aldor or scryer specific quest steps after this, type "/reload" into your ingame chat box
step
#scryer
#label aldorOrScryer
.goto Shattrath City,54.5,44.1
.turnin 10552 >> Turn in Allegiance to the Scryer
step
#aldor
#label aldorOrScryer
.goto Shattrath City,54.5,44.1
.turnin 10551 >> Turn in Allegiance to the Aldor
step
#sticky
#requires choice
#completewith notofftoarea52
>> Head to Netherstorm
* 5 other quests count as the same pre-requisite as Off to Area 52, if it's not here for you, it means you did a different pre-requisite, you can skip this step.
.goto Netherstorm,20.6,55.7
.accept 10183 >> Accept Off to Area 52
step
#label notofftoarea52
.goto Netherstorm,32.7,64.9
.turnin 10183 >> Turn in Off to Area 52
step
.goto Netherstorm,32.7,64.9
.accept 10186 >> Accept You're Hired!
step
.goto Netherstorm,32.4,64.2
.accept 10265 >> Accept Consortium Crystal Collection.
step
.goto Netherstorm,31.4,66.2
.accept 10173 >> Accept The Archmage's Staff.
step
#aldor
.goto Netherstorm,32.1,64.3
.accept 10241 >> Accept Distraction at Manaforge B'naar
step
#scryer
.goto Netherstorm,32.0,64.0
.accept 10189 >> Accept Manaforge B'naar.
step
#aldor
.goto Netherstorm,26.6,68.4
>> Slay Sunfury enemies in the area
.complete 10241,1 
.complete 10241,2 
step
#scryer
.goto Netherstorm,28.0,65.6
>> Kill Captain Arathyn and loot him for the quest item.
.complete 10189,1
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10189 >> Turn in Manaforge B'naar.
.accept 10193 >> Accept High Value Targets.
step
#scryer
.goto Netherstorm,25.4,71.8,100,0
.goto Netherstorm,22.0,72.7,40,0
.goto Netherstorm,25.4,71.8
>> Kill Sunfury enemies in the area.
.complete 10193,1
.complete 10193,2
.complete 10193,3
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10193 >> Turn in High Value Targets.
.accept 10329 >> Accept Shutting Down Manaforge B'naar.
step
#aldor
.goto Netherstorm,32.1,64.3
.turnin 10241 >> Turn in Distraction at Manaforge B'naar
.accept 10313 >> Accept Measuring Warp Energies
.accept 10243 >> Accept Naaru Technology
step
#scryer
.goto Netherstorm,23.8,70.6
>> Kill and loot Overseer Theredis inside the Mana Forge for the B'naar Access Crystal
.collect 29366,1,10329,1
step
#scryer
.goto Netherstorm,23.2,68.1
>> Click on the console and defend it from technicians that spawn. This takes 2 minutes.
.skipgossip
.complete 10329,1
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10329 >> Turn in Shutting Down Manaforge B'naar.
.accept 10194 >> Accept Stealth Flight.
step
#scryer
.goto Netherstorm,33.8,64.2
.turnin 10194 >> Turn in Stealth Flight.
.accept 10652 >> Accept Behind Enemy Lines
step
#aldor
.goto Netherstorm,25.4,60.3
>>Use the Warp-Attuned Orb in your bags while next to the pipe
.complete 10313,1 
step
#aldor
.goto Netherstorm,20.7,67.5
>>Stand on top of the scaffolding and use the Orb
.complete 10313,4 
step
#aldor
.goto Netherstorm,20.3,70.9
>> Use the orb while standing next to this pipe
.complete 10313,3 
step
#aldor
.goto Netherstorm,23.2,68.1
>> Head inside the building then click on the pillar
.turnin 10243 >> Turn in Naaru Technology
.accept 10245 >> Accept B'naar Console Transcription
step
#aldor
.goto Netherstorm,29.1,72.8
>>Use the Warp-Attuned Orb in your bags while next to the pipe
.complete 10313,2 
step
#aldor
.goto Netherstorm,32.1,64.2
.turnin 10245 >> Turn in B'naar Console Transcription
.accept 10299 >> Accept Shutting Down Manaforge B'naar
.turnin 10313 >> Turn in Measuring Warp Energies
step
#aldor
.goto Netherstorm,23.7,70.1
>> Head back inside the building. Kill and loot the Overseer
.complete 10299,2 
step
#aldor
.goto Netherstorm,23.2,68.1
.skipgossip
>>Click on the pylon to start the shutdown timer, kill any mobs trying to stop it. This takes 2 minutes.
.complete 10299,1 
step
#aldor
.goto Netherstorm,32.1,64.2
.turnin 10299 >> Turn in Shutting Down Manaforge B'naar
.accept 10321 >> Accept Shutting Down Manaforge Coruu
.accept 10246 >> Accept Attack on Manaforge Coruu
step
.goto Netherstorm,42.6,72.6
>> Kill and loot Pentatharon for the Crystal.
.complete 10265,1
step
.goto Netherstorm,40.8,72.6
.use 29207
>> Use Conjuring Powder while standing next to the brazier to summon Ekkorash and slay her.
.complete 10173,1
step
.goto Netherstorm,32.4,64.2
.turnin 10265 >> Turn in Consortium Crystal Collection.
.accept 10262 >> Accept A Heap of Ethereals.
step
.goto Netherstorm,29.3,78.1
>> Kill Zaxxis mobs in the area and loot them for insignias
.collect 29209,10,10262,1
step
.goto Netherstorm,32.4,64.2
.turnin 10262 >> Turn in A Heap of Ethereals
.accept 10205 >> Accept Warp-Raider Nesaad
step
.goto Netherstorm,31.4,66.2
.turnin 10173 >> Turn in The Archmage's Staff.
.accept 10300 >> Accept Rebuilding the Staff.
step
.goto Netherstorm,28.3,79.9
>> Kill Warp-Raider Nesaad
.unitscan Warp-Raider Nesaad
.complete 10205,1
step
.goto Netherstorm,32.4,64.2
.turnin 10205 >> Turn in Warp-Raider Nesaad
.accept 10266 >> Accept Request for Assistance
step
#sticky
#label crystalmatrixs
.goto Netherstorm,33.1,54.4
>> Loot the red crystals on the ground in the area
* You can use your racial Find Treasure to track them on the minimap << Dwarf
.complete 10186,1 
step
.goto Netherstorm,33.6,54.6
>> Kill and loot Disembodied Protectors and Vindicators for Crystals.
.complete 10300,1
step
#requires crystalmatrixs
.goto Netherstorm,32.7,64.9
.turnin 10186 >> Turn in You're Hired!
step
.goto Netherstorm,31.4,66.2
.turnin 10300 >> Turn in Rebuilding the Staff.
step
#scryer
.goto Netherstorm,48.2,86.6
.turnin 10652 >> Turn in Behind Enemy Lines.
.accept 10197 >> Accept A Convincing Disguise.
step
#scryer
.goto Netherstorm,49.0,81.6
>> Kill and loot mobs in the area. Gather parts for your disguise.
* Researchers are inside, Guardsmen are found on the eastern side. Arcanists are on the west side.
.complete 10197,1
.complete 10197,2
.complete 10197,3
step
#scryer
.goto Netherstorm,48.2,86.6
.turnin 10197 >> Turn in A Convincing Disguise.
.accept 10198 >> Accept Information Gathering.
step
#scryer
>> Use your disguise and head into Manaforge Coruu, find Commander Dawnforge and stand next to him to get credit for the quest.
* You may need to wait for the Arcane Annihilator to patrol away from the door
.use 28607
.goto Netherstorm,48.2,84.0
.complete 10198,1
step
#scryer
.goto Netherstorm,48.2,86.6
.turnin 10198 >> Turn in Information Gathering.
.accept 10330 >> Accept Shutting Down Manaforge Coruu.
step
#scryer
.goto Netherstorm,49.0,81.6
>> Click off your disguisee then kill Overseer Seylanna for her Access Crystal and use it on the console.
.complete 10330,1
step
#scryer
.goto Netherstorm,48.2,86.6
.turnin 10330 >> Turn in Shutting Down Manaforge Coruu.
step
#aldor
#sticky
#label researcherkills
.goto Netherstorm,48.7,82.2
>> Kill Researchers around the room
.complete 10246,1 
step
#aldor
.goto Netherstorm,49.0,81.5
>>Kill the Overseer right next to the console
.complete 10321,2 
step
#aldor
.goto Netherstorm,49.0,81.5
.skipgossip
>>Click on the pylon to start the shutdown timer, kill any mobs trying to stop it. Grind Centurions in the area between mobs.
* Kill Researchers in the area while waiting.
.complete 10321,1 
step
#aldor
#requires researcherkills
.goto Netherstorm,49.6,80.6
>> Head outside and kill Arcanists
.complete 10246,2 
step
.goto Netherstorm,57.4,86.2
.accept 10184 >> Accept Malevolent Remnants.
step
.goto Netherstorm,59.4,87.4
>> Kill spirits around Kirin'Var.
.complete 10184,1
step
.goto Netherstorm,57.4,86.2
.turnin 10184 >> Turn in Malevolent Remnants.
.accept 10312 >> Accept The Annals of Kirin'Var.
step
.goto Netherstorm,60.6,87.6
>> Kill Battle-Mage Dathric and collect the tome. Do NOT turn in his blade. We will use it in the 70-71 turn in route.
.complete 10312,1
step
.goto Netherstorm,57.4,86.2
.turnin 10312 >> Turn in The Annals of Kirin'Var.
step
#aldor
.goto Netherstorm,32.1,64.3
.turnin 10321 >> Turn in Shutting Down Manaforge Coruu
.turnin 10246 >> Turn in Attack on Manaforge Coruu
.accept 10322 >> Accept Shutting Down Manaforge Duro
.accept 10328 >> Accept Sunfury Briefings
step
#scryer
.goto Netherstorm,32.0,64.0
.accept 10341 >> Accept Kick Them While They're Down.
step
#scryer
.goto Netherstorm,59.0,66.8
>> Kill Sunfury enemies. Centurions are typically found at entrances to the mana forge.
.complete 10341,1
.complete 10341,2
.complete 10341,3
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10341 >> Turn in Kick Them While They're Down.
.accept 10202 >> Accept A Defector.
step
#scryer
.goto Netherstorm,26.2,41.6
.turnin 10202 >> Turn in A Defector.
.accept 10432 >> Accept Damning Evidence.
step
#scryer
.goto Netherstorm,26.4,44.0
>> Head into the caves below the mana forge. Kill and loot demons for the orders.
.collect 29797,8,10432,1
step
#aldor
#sticky
#label militarymanaforge
.goto Netherstorm,58.5,63.6
>>Kill and loot Sunfury Centurions inside Manaforge Duro
.complete 10328,1 
step
#aldor
.goto Netherstorm,60.0,68.5
>>Kill and loot Overseer Athanel inside the southern wing of the mana forge
.complete 10322,2 
step
#aldor
.goto Netherstorm,59.1,66.6
.skipgossip
>> Talk to the Pylon and start the shut down. Kill any mobs that try to stop you.
.complete 10322,1 
step
#aldor
#requires militarymanaforge
.goto Netherstorm,57.2,64.2
>> Kill and loot Sunfury Conjurers around the mana forge
.complete 10328,2 
step
#aldor
.goto Netherstorm,32.0,64.2
.turnin 10328 >> Turn in Sunfury Briefings
.accept 10431 >> Accept Outside Assistance
.turnin 10322 >> Turn in Shutting Down Manaforge Duro
.accept 10323 >> Accept Shutting Down Manaforge Ara
step
#aldor
.goto Netherstorm,34.8,38.2
.turnin 10431 >> Turn in Outside Assistance
.accept 10380 >> Accept A Dark Pact
step
#aldor
.goto Netherstorm,26.4,43.5
>> Kill Gan'arg and Mo'arg demons in the cave
.complete 10380,1 
.complete 10380,3 
step
#aldor
.goto Netherstorm,26.4,43.5,40,0
.goto Netherstorm,28.5,39.9
>> Leave the cave and fly around Manaforge Ara looking for Daughter of Destiny
* The demons don't social aggro with the blood elves if you ranged pull them.
.unitscan Daughter of Destiny
.complete 10380,2 
step
#aldor
.goto Netherstorm,34.8,38.3
.turnin 10380 >> Turn in A Dark Pact
.accept 10381 >> Accept Aldor No More
step
#aldor
.goto Netherstorm,26.0,38.7
>> Kill Overseer Azarad. Loot him for the Access Crystal. Then talk to the pylon and protect it like the previous times.
*This quest can be very overwhelming compared to the previous ones, be ready and you may need help. Clear a safe space in the room beforehand.
.skipgossip
.complete 10323,2 
.complete 10323,1 
step
#aldor
.goto Netherstorm,32.0,64.2
.turnin 10381 >> Turn in Aldor No More
.accept 10407 >> Accept Socrethar's Shadow
.turnin 10323 >> Turn in Shutting Down Manaforge Ara
step
#aldor
.goto Netherstorm,36.2,26.4
>> Kill and loot Forgemaster Morug. He is elite, you may need help.
.unitscan Forgemaster Morug
.complete 10407,1 
step
#aldor
.goto Netherstorm,40.8,19.5
>> Kill and loot Silroth, he is elite, you may need help.
.unitscan Silroth
.complete 10407,2 
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10432 >> Turn in Damning Evidence.
.accept 10508 >> Accept A Gift for Voren'thal.
step
#scryer
>> Get both halfs of Socrethar's Stone from Morug and Silroth.
.goto Netherstorm,36.8,27.6,10,0
.goto Netherstorm,40.8,19.4
.complete 10508,1
.complete 10508,2
step
#aldor
.goto Netherstorm,32.1,64.3
.turnin 10407 >> Turn in Socrethar's Shadow
step
#scryer
.goto Netherstorm,32.0,64.0
.turnin 10508 >> Turn in A Gift for Voren'thal.
step << skip
#aldor
.goto Netherstorm,32.0,64.2
.accept 10263 >> Accept Assisting the Consortium.
step << skip
#scryer
.goto Netherstorm,32.0,64.2
.accept 10264 >> Accept Assisting the Consortium.
step << skip
#aldor
.goto Netherstorm,32.4,64.2
.turnin 10263 >> Turn in Assisting the Consortium.
step << skip
#scryer
.goto Netherstorm,32.4,64.2
.turnin 10264 >> Turn in Assisting the Consortium.
step
.goto Netherstorm,33.0,64.6
.accept 10206 >> Accept Pick your Part
step
.goto Netherstorm,28.9,77.6
>> Loot Ethereal Technology in the area, its in little boxes
.complete 10206,1 
step
.goto Netherstorm,33.0,64.6
.turnin 10206 >> Turn in Pick your Part
.accept 10333 >> Accept Help Mama Wheeler.
step
.goto Netherstorm,46.4,56.4
.accept 10417 >> Accept Run a Diagnostic!
.accept 10433 >> Accept Keeping Up Appearances.
step
.goto Netherstorm,48.2,55.0
>> Collect Diagnostic Results by clicking on the pillar
.complete 10417,1
step
.goto Netherstorm,46.4,56.4
.turnin 10417 >> Turn in Run a Diagnostic!
.accept 10418 >> Accept Deal With the Saboteurs.
step
.goto Netherstorm,46.6,57.0
.turnin 10266 >> Turn in Request for Assistance
.accept 10267 >> Accept Rightful Repossession
step
.goto Netherstorm,56.9,63.8
>> Collect research equipment around the Manaforge. They look like tiny gray colored crates.
.complete 10267,1
step
.goto Netherstorm,46.6,57.0
.turnin 10267 >> Turn in Rightful Repossession
.accept 10268 >> Accept An Audience with the Prince
step
#sticky
#label croctimes
.goto Netherstorm,47.0,52.6
>> Kill Crocolisks around the area.
.complete 10418,1
step
.goto Netherstorm,44.0,49.4,20,0
.goto Netherstorm,44.8,57.2,20,0
.goto Netherstorm,44.0,49.4
>> Kill Ripfang Lynx under the Eco-dome for their pelts.
.complete 10433,1
step
#requires croctimes
.goto Netherstorm,46.4,56.4
.turnin 10418 >> Turn in Deal With the Saboteurs.
.turnin 10433 >> Turn in Keeping Up Appearances.
step
.goto Netherstorm,46.6,56.6
.turnin 10333 >> Turn in Help Mama Wheeler.
.accept 10234 >> Accept One Demon's Trash...
step
.goto Netherstorm,50.4,58.9
>> Collect Fel reaver parts around the area.
.complete 10234,1
step
.goto Netherstorm,46.6,56.6
.turnin 10234 >> Turn in One Demon's Trash...
.accept 10235 >> Accept Declawing Doomclaw.
step
.goto Netherstorm,50.8,57.6
>> Kill Doomclaw and collect quest item.
.complete 10235,1
step
.goto Netherstorm,46.6,56.6
.turnin 10235 >> Turn Declawing Doomclaw.
.accept 10237 >> Accept Warn Area 52!
step
.goto Netherstorm,45.9,36.0
.turnin 10268 >> Turn in An Audience with the Prince
.accept 10269 >> Accept Triangulation Point One
step
.goto Netherstorm,66.7,33.8
.use 28962 >> Use the Triangulation Device in the area
.complete 10269,1
step
.goto Netherstorm,58.4,31.3
.turnin 10269 >> Turn in Triangulation Point One
.accept 10275 >> Accept Triangulation Point Two
step
.goto Netherstorm,28.9,41.3
.use 29018 >> Use the Triangulation Device in the area
.complete 10275,1
step
.goto Netherstorm,34.6,37.9
.turnin 10275 >> Turn in Triangulation Point Two
.accept 10276 >> Accept Full Triangle
step
.goto Netherstorm,53.5,21.4
>> Kill and loot Culuthas for the crystal. You may need help if you are undergeared.
.complete 10276,1
step
.goto Netherstorm,45.8,36.0
.turnin 10276 >> Turn in Full Triangle
step
.goto Netherstorm,32.6,64.8
.turnin 10237 >> Turn in Warn Area 52!
.accept 10247 >> Accept Doctor Vomisa, Ph.T.
step
.goto Netherstorm,37.2,63.8
.turnin 10247 >> Turn in Doctor Vomisa, Ph.T.
.accept 10248 >> Accept You, Robot.
step
.goto Netherstorm,37.2,63.8
>> Use your controller on Scrap Reaver and defeat Negatron. Make sure to use your robot's abiilities on cooldown.
* Save the stun for when Negatron uses earthquake. Only use Smash if you start getting threat, otherwise heal Scrap Reaver and stun Negatron during earthquake.
* Scrap Reaver is buffable as well << Paladin/Priest/Druid
.use 28634
.complete 10248,1
step
.goto Netherstorm,37.2,63.8
.turnin 10248 >> Turn in You, Robot.
step
.goto Blade's Edge Mountains,55.4,44.9
.accept 10995 >> Accept Grulloc Has Two Skulls
.accept 10996 >> Accept Maggoc's Treasure Chest
.accept 10997 >> Accept Even Gronn Have Standards
step
#sticky
#completewith gronnsdone
.goto Blade's Edge Mountains,60.3,47.5
>> Kill Grulloc and loot the item on the ground when he dies.
.complete 10995,1
step
#sticky
#completewith gronssdone
.goto Blade's Edge Mountains,58.5,60.8,40,0
.goto Blade's Edge Mountains,64.5,54.8,40,0
.goto Blade's Edge Mountains,68.3,74.8
>> Find Maggoc, he patrols around the Scalewing Shelf. Kill him and loot the item he drops on the ground
.unitscan Maggoc
.complete 10996,1
step
#sticky
#completewith gronssdone
.goto Terokkar Forest,20.3,15.9
>> Kill Slaag and loot him for the item he drops on the ground
.complete 10997,1
step
#completewith next
#label gronnprep
+These next 3 quests are all elite and require a group, however, they are unique in that the boss drops an item that can be right clicked on the ground for the quest reward, even if you aren't in the group that got the kill. You can do them in any order, two are in Blade's Edge, one is above Shattrath.
step
#label gronnsdone
#requires gronnprep
.goto Blade's Edge Mountains,55.4,44.9
.turnin 10995 >> Turn in Grulloc Has Two Skulls
.turnin 10997 >> Turn in Even Gronn Have Standards
.turnin 10996 >> Turn in Maggoc's Treasure Chest
.accept 10998 >> Accept Grim(oire) Business
step
.goto Blade's Edge Mountains,77.4,31.2
>> Kill Vim'gol the Vile for his book, once again loot the item on the ground. You do not need to be in the group that killed him to loot it.
.complete 10998,1
step
.goto Blade's Edge Mountains,55.4,44.9
.turnin 10998 >> Turn in Grim(oire) Business
.accept 11000 >> Accept Into the Soulgrinder
step
.goto Blade's Edge Mountains,60.0,24.1
.use 32467 >> Step on the altar and use the grimoire to start the encounter. Survive the waves then kill the boss and loot the soul he drops on the ground.
.complete 11000,1


step
.goto Deadwind Pass,47.0,75.6
.reputation 967,honored 
>> Head to Deadwind Pass
.accept 9630 >> Accept Medivh's Journal.
step

>> Get into Karazhan and talk to Wravien in the room right after Curator boss.
.turnin 9630 >> Turn in Medivh's Journal.
.accept 9638 >> Accept In Good Hands.
step
>> Gradav is a little further ahead from Wravien.
.turnin 9638 >> Turn in In Good Hands.
.accept 9639 >> Accept Kamsis.
step
>> Like before, Kamsis is a bit ahead from Gradav.
.turnin 9639 >> Turn in Kamsis.
.accept 9640 >> Accept The Shade of Aran.
step
>> Get the Journal from defeating Shade of Aran.
.complete 9640,1
step
.turnin 9640 >> Turn in The Shade of Aran with Kamsis.
.accept 9645 >> Accept The Master's Terrace.
step
>> Go to Master's Terrace within Karazhan and read the Journal.
.use 23934
.complete 9645,1
step
.goto Deadwind Pass,47.0,75.6
.turnin 9645 >> Turn in The Master's Terrace.
.accept 9680 >> Accept Digging Up the Past.
step
.goto Deadwind Pass,45.0,78.8
>> Collect Charred Bone Fragment off the ground.
.complete 9680,1
step
.goto Deadwind Pass,47.0,75.6
.turnin 9680 >> Turn in Digging Up the Past.
step
#sticky
.goto Netherstorm,43.5,35.0
+Class quests are not included in the guide due to complexity, however they can be a lot of exp at 70 due to exp scaling. If you have any low level class quests available, like Cure Poison for Druids, Resurrection for Paladins etc, prepare them to turn in at launch. Some level 10 class quests can give up to 30k exp due to scaling.
step
.goto Netherstorm,43.5,35.0
+Head to the Stormspire and attack an enemy player to aggro the guards. Kill guards until you are 0/3000 neutral with the Consortium. You lose 125 rep a kill. Having a friend on the opposite faction will speed this up a lot.
>>Neutral reputation is required to turn in the following quests: Stealing from Thieves and A Head Full of Ivory
*Skip this step if those 2 quests are already complete
step
.goto Shadowmoon Valley,66.0,84.6
.reputation 1015,exalted
+Reach exalted with Netherwing by doing the below dailies. Do not turn in any one time quests!
.accept 11020 >> Accept A Slow Death
.accept 11015 >> Accept Netherwing Crystals
.accept 11035 >> Accept The Not-So-Friendly Skies...
step
.goto Shadowmoon Valley,66.0,84.6
.accept 11018 >> Accept Nethercite Ore
.skill mining,<350,1
step
.goto Shadowmoon Valley,66.0,84.6
.skill herbalism,<350,1
.accept 11017 >> Accept Netherdust Pollen
step
.goto Shadowmoon Valley,66.0,84.6
.skill skinning,<350,1
.accept 11016 >> Accept Nethermine Flayer Hide
]])
RXPGuides.RegisterGuide([[
#version 23
#wotlk
#tbc
#group RestedXP Wrath Preparation
#defaultfor None
#name Turn In Day Speed Assistant
step << !Mage
#sticky
#completewith next
+If you don't have "Know Your Ley Lines" as one of your quests in your questlog, go and do "Know Your Ley Lines" a few hours before launch, it gives you a scroll to teleport to Shattrath. This item gets removed when the daily becomes available again. Optionally skip this step if you're friends with a warlock or mage willing to port/summon you.
step << !Mage
.goto Isle of Quel'Danas,47.6,35.4
.accept 11547 >> Accept Know Your Ley Lines
step << !Mage
.isOnQuest 11547
.goto Isle of Quel'Danas,42.0,34.9,-1
.goto Isle of Quel'Danas,48.4,44.4,-1
.goto Isle of Quel'Danas,61.0,62.1,-1
.use 34533 >> Use the Astromancer's Crystal to take readings of the Portal, Shrine, and Bloodcrystal.
.complete 11547,1
.complete 11547,2
.complete 11547,3
step << !Mage
.isOnQuest 11547
.goto Isle of Quel'Danas,47.6,35.4
.turnin 11547 >> Turn in Know Your Ley Lines
step
>> Items that will boost your turnin speed.
.collect 6372,1
.collect 7052,1
.collect 2459,5
.collect 25653,1
step
>> Optionally you can also get Swiftness of Zanza. It will save you a lot of time because in works on mounts in WOTLK (Requires Revered with Zandalar Tribe)
.reputation 270,revered
.collect 20081,1
step
>> Rocket boots combined with noggenfogger can save you a lot of time as well.
*There is a cloth and leather version of the boots, pick whichever is best for your spec. << Druid/Shaman/Paladin
.skill engineering,<330,1
.collect 8529,40
.collect 35581,1 << Warlock/Mage/Priest/Shaman/Druid/Paladin
.collect 23824,1 << Warrior/Paladin/Rogue/Hunter/Shaman/Druid
.collect 30542,1
]])
RXPGuides.RegisterGuide([[
#version 23
#wotlk
#tbc
#group RestedXP Wrath Preparation
#defaultfor None
#name Launch Turn in Guide
#next RestedXP Alliance 70-80\70.5-71.5 Borean Tundra Prequest Start << Alliance
#next RestedXP Horde 70-80\70.5-71.5 Borean Tundra Prequest Start << Horde
step
#sticky
#completewith start1
+ This is the guide you use when WOTLK is out and you are turning in quests for exp. Please DO NOT turn in quests in this guide until launch day.
step
#sticky
#completewith start1
+ Add quest accept items from your inventory onto your hotbar and keybind them to accept them faster. This will save a lot of time looking for them later.
step
#sticky
#completewith start1
+Due to Karazhan placement you need to start Karazhan if u can't get a summon, this means you can only have 24 qlog quests instead of 25. If you can get a summon to Karazhan instead, then start in Shat & get ported to Karazhan right after.
step
.isQuestTurnedIn 9680
>> Head to the Deadwind Pass
.goto Deadwind Pass,47.0,75.6
.accept 9631 >> Accept A Colleague's Aid.
step
.goto Deadwind Pass,47.1,75.2
.reputation 967,friendly,<0,1
>> Choose a ring path, skip this step once you've chosen one.
.dailyturnin 10730,10732,10729,10731 >> Turn in Path of the Violet Blank
step
.goto Deadwind Pass,47.1,75.2
.reputation 967,honored,<0,1
.daily 10735,10736,10733,10734 >> Accept the Honored Ring Quest. Skip this step if you're above honored
.dailyturnin 10735,10736,10733,10734 >> Turn in the Honored Ring Quest. Skip this step if you're above honored
step
.goto Deadwind Pass,47.1,75.2
.reputation 967,revered,<0,1
.daily 10739,10740,10741,10738 >> Accept the Revered Ring Quest. Skip this step if you're above revered
.dailyturnin 10739,10740,10741,10738 >> Turn in the Revered Ring Quest. Skip this step if you're above revered
step
.goto Deadwind Pass,47.1,75.2
.reputation 967,exalted,<0,1
.daily 10725,10728,10727,10726 >> Accept the Exalted Ring Quest
.dailyturnin 10725,10728,10727,10726 >> Turn in the Exalted Ring Quest
step
.zone Shattrath City >> Head to Shattrath City
step
#scryer
.itemcount 30810,10
.goto Shattrath City,45.5,81.4
.accept 10656 >> Accept Sunfury Signets
.turnin 10656 >> Turn in Sunfury Signets
step
#scryer
.itemcount 29426,10
.goto Shattrath City,45.4,81.4
.accept 10412 >> Accept Firewing Signets
.turnin 10412 >> Turn in Firewing Signets
step
#scryer
.itemcount 29739,1
.goto Shattrath City,42.6,91.4
.accept 10416 >> Accept Synthesis of Power
.turnin 10416 >> Turn in Synthesis of Power
step
#aldor
.itemcount 30809,10
.goto Shattrath City,30.8,34.6
.accept 10653 >> Accept Marks of Sargeras
.turnin 10653 >> Turn in Marks of Sargeras
step
#aldor
.itemcount 29425,10
.goto Shattrath City,30.8,34.6
.accept 10325 >> Accept Marks of Kil'jaeden
.turnin 10325 >> Turn in Marks of Kil'jaeden
step
#aldor
.itemcount 29740,1
.goto Shattrath City,24.2,29.8
.accept 10420 >> Accept A Cleansing Light
.turnin 10420 >> Turn in A Cleansing Light
step
.itemcount 32405,1
.goto Shattrath City,54.0,44.6
.use 32405
.accept 11007 >> Click on the Verdant Sphere and accept the quest
.turnin 11007 >> Turn in Kael'thas and the Verdant Sphere
step
.isOnQuest 9837
.goto Shattrath City,54.6,44.2
.turnin 9837 >> Turn in Return to Khadgar
step
.isOnQuest 9831
.goto Shattrath City,54.6,44.2
.turnin 9831 >> Turn in Entry Into Karazhan
step
.isQuestAvailable 11550
.goto Shattrath City,53.4,43.6
.accept 11550 >> Accept Enter the Deceiver...
step
.itemcount 27480,5
.goto Shattrath City,50.4,45.4
.turnin 10091 >> Turn in The Soul Devices
step
.isOnQuest 10095
.goto Shattrath City,50.4,45.4
.turnin 10095 >> Turn in Into the Heart of the Labyrinth
step
.itemcount 34246,10
.goto Shattrath City,49.2,42.4
.turnin 11514 >> Turn in Maintaining the Sunwell Portal
step
.isOnQuest 11108
.goto Shattrath City,66.6,16.8
.turnin 11108 >> Turn in Lord Illidan Stormrage
step
.itemcount 35231,1
.goto Shattrath City,62.6,36.0
.turnin 11877 >> Turn in Sunfury Attack Plans
step << Alliance
>> You need to be 71 to deliver this quest, skip it if you are not 71.
.goto Shattrath City,67.2,34.0
.dailyturnin 11337,11336,11335,11338 >> Turn in the PvP Daily
step << Horde
>> You need to be 71 to deliver this quest, skip it if you are not 71.
.goto Shattrath City,67.0,56.6
.dailyturnin 11341,11340,11339,11342 >> Turn in the PvP Daily
step
.itemcount 25719,30
.goto Shattrath City,49.0,18.4
>> Vekax walks around the area
.unitscan Vekax
.accept 10917 >> Accept The Outcast's Plight
.turnin 10917 >> Turn in The Outcast's Plight
step
#aldor
.itemcount 25744,8
.goto Shattrath City,54.8,22.6
.accept 10024 >> Accept Voren'thal's Visions
.turnin 10024 >> Turn in Voren'thal's Visions
step
.itemcount 33849,15
.goto Shattrath City,61.6,15.8
.turnin 11380 >> Turn in Manalicious
step
.itemcount 33839,1
.goto Shattrath City,61.6,15.8
.turnin 11377 >> Turn in Revenge is Tasty
step
.itemcount 33850,1
.goto Shattrath City,61.6,15.8
.turnin 11381 >> Turn in Soup for the Soul
step
.itemcount 33848,1
.goto Shattrath City,61.6,15.8
.turnin 11379 >> Turn in Super Hot Stew
step
#scryer
.itemcount 25802,8
.goto Shattrath City,64.4,15.6
.accept 10017 >> Accept Strained Supplies
.turnin 10017 >> Turn in Strained Supplies
step
.itemcount 33826,1
.goto Shattrath City,75.0,36.4
.turnin 11369 >> Turn in Wanted: A Black Stalker Egg
step
.itemcount 33859,1
.goto Shattrath City,75.0,36.4
.turnin 11384 >> Turn in Wanted: A Warp Splinter Clipping
step
.itemcount 33858,1
.goto Shattrath City,75.0,36.4
.turnin 11382 >> Turn in Wanted: Aeonus's Hourglass
step
.itemcount 11363,1
.goto Shattrath City,75.0,36.4
.turnin 11363 >> Turn in Wanted: Bladefist's Seal
step
.itemcount 33840,1
.goto Shattrath City,75.0,36.4
.turnin 11375 >> Turn in Wanted: Murmur's Whisper
step
.itemcount 33833,1
.goto Shattrath City,75.0,36.4
.turnin 11354 >> Turn in Wanted: Nazan's Riding Crop
step
.itemcount 33860,1
.goto Shattrath City,75.0,36.4
.turnin 11386 >> Turn in Wanted: Pathaleon's Projector
step
.itemcount 33835,1
.goto Shattrath City,75.0,36.4
.turnin 11373 >> Turn in Wanted: Shaffar's Wondrous Pendan
step
.itemcount 33847,1
.goto Shattrath City,75.0,36.4
.turnin 11378 >> Turn in Wanted: The Epoch Hunter's Head
step
.itemcount 33836,1
.goto Shattrath City,75.0,36.4
.turnin 11374 >> Turn in Wanted: The Exarch's Soul Gem
step
.itemcount 33834,1
.goto Shattrath City,75.0,36.4
.turnin 11372 >> Turn in Wanted: The Headfeathers of Ikiss
step
.itemcount 33821,1
.goto Shattrath City,75.0,36.4
.turnin 11368 >> Turn in Wanted: The Heart of Quagmirran
step
.itemcount 33861,1
.goto Shattrath City,75.0,36.4
.turnin 11388 >> Turn in Wanted: The Scroll of Skyriss
step
.itemcount 33827,1
.goto Shattrath City,75.0,36.4
.turnin 11370 >> Turn in Wanted: The Warlord's Treatise
step << Horde
.isQuestTurnedIn 9993
.goto Terokkar Forest,50.0,44.8
.accept 10201 >> Accept And Now, the Moment of Truth
step << Horde
.isOnQuest 10201
.goto Terokkar Forest,49.8,45.2
>> Talk to Grek
.skipgossip
.complete 10201,1
step << Horde
.isOnQuest 10201
.goto Terokkar Forest,50.0,44.8
.turnin 10201 >> Turn in And Now, the Moment of Truth
step << Horde
.isQuestTurnedIn 10447
.goto Terokkar Forest,50.0,45.8
.accept 10006 >> Accept Letting Earthbinder Tavgren Know
step << Horde
.isOnQuest 10006
.goto Terokkar Forest,44.4,26.2 
.turnin 10006 >> Turn in Letting Earthbinder Tavgren Know
step << Horde
.isOnQuest 11506
.goto Terokkar Forest,49.8,45.6
.turnin 11506 >> Turn in Spirits of Auchindoun

step << Horde
.isQuestAvailable 10013
.goto Terokkar Forest,67.9,53.5
>> Click on the scroll inside of the building
.accept 10013 >> Accept An Unseen Hand.
step << Alliance
.isQuestTurnedIn 10446
.goto Terokkar Forest,57.0,53.6
.accept 10005 >> Accept Earthbinder Tavgren Know.
step << Alliance
.isOnQuest 11505
.goto Terokkar Forest,55.8,53.8
.turnin 11505 >> Turn in Spirits of Auchindoun
step << Alliance
.isQuestAvailable 10038
.goto Terokkar Forest,57.6,55.6
.accept 10038 >> Accept Speak with Private Weeks
step << Alliance
.isQuestAvailable 10012
.goto Terokkar Forest,67.9,53.5
>> Click on the scroll inside of the building
.accept 10012 >> Accept Fel Orc Plans.
step
#label start1
.itemcount 30829,1
.goto Terokkar Forest,77.4,38.6
.turnin 10670 >> Turn in Tear of the Earthmother
step
.itemcount 30828,1
.goto Terokkar Forest,77.4,38.6
.turnin 10667 >> Turn in Underworld Loam
step
.goto Terokkar Forest,77.4,38.6
>> Accept and turn in the quest, then wait for him to craft the sword. Skip this if needed.
.accept 10676 >> Accept Bane of the Illidari
step
>> Should take 30s before you can deliver. It has a follow up quest which is quite free.
.isOnQuest 10676
.goto Terokkar Forest,77.4,38.6
.turnin 10676 >> Turn in Bane of the Illidari
step
.isQuestTurnedIn 10676
.goto Terokkar Forest,77.4,38.6
>> After he finishes forging the blade accept the new quest
.accept 10679 >> Accept Quenching the Blade
step << Alliance
.isOnQuest 10005
.goto Terokkar Forest,44.4,26.2 
.turnin 10005 >> Turn in Letting Earthbinder Tavgren Know
step << Horde
.isOnQuest 10013
.goto Terokkar Forest,49.0,44.7
.turnin 10013 >> Turn in An Unseen Hand.
step << Horde
.isQuestAvailable 10847
.goto Terokkar Forest,49.0,44.7
.accept 10862 >> Accept in Surrender to the Horde.
step << Horde
.isQuestAvailable 10039
>> Speak to the blood elf
.goto Terokkar Forest,48.8,44.6
.accept 10039 >> Accept Speak with Scout Neftis
step << Horde
.isOnQuest 10039
.goto Terokkar Forest,39.0,43.8
.turnin 10039 >> Turn in Speak with Scout Neftis
step << Alliance
.isOnQuest 10038
.goto Terokkar Forest,40.4,36.0
.turnin 10038 >> Turn in Speak with Private Weeks
step
.itemcount 31707,1
.goto Terokkar Forest,37.4,51.2
.use 31707,1 >> Use the Cabal Orders in your bags to accept the quest
.accept 10880 >> Accept Cabal Orders
.turnin 10880 >> Turn in Cabal Orders
step
.isOnQuest 10218
.goto Terokkar Forest,39.4,58.4
.turnin 10218 >> Turn in Someone Else's Hard Work Pays Off
step
.isOnQuest 10165
.goto Terokkar Forest,39.4,58.4
.turnin 10165 >> Turn in Undercutting the Competition
step
.isOnQuest 10097
.goto Terokkar Forest,44.0,65.0
.turnin 10097 >> Turn in Brother Against Brother
step
.isOnQuest 10098
.goto Terokkar Forest,44.0,65.0
.turnin 10098 >> Turn in Terokk's Legacy
step
.isQuestTurnedIn 10921
.goto Terokkar Forest,49.8,76.2
.accept 10926 >> Accept Return to Sha'tari Base Camp.
step
.isOnQuest 10926
.goto Terokkar Forest,31.4,75.6
.turnin 10926 >> Turn in Return to Sha'tari Base Camp.
step
.isOnQuest 10164
.goto Terokkar Forest,35.0,65.2
.turnin 10164 >> Turn in Everything Will Be Alright
step << Alliance
.isOnQuest 10012
.goto Terokkar Forest,58.2,54.8
.turnin 10012 >> Turn in Fel Orc Plans.
step << Alliance
.isQuestAvailable 10847
.goto Terokkar Forest,57.6,56.0
.accept 10863 >> Accept Secrets of the Arakkoa.
step
.itemcount 32523,1
.goto Terokkar Forest,64.0,66.8
.use 32523 >> Use Ishaal's Almanac in your bags to accept the quest
.accept 11021 >> Accept Ishaal's Almanac
.turnin 11021 >> Turn in Ishaal's Almanac
step
.isQuestTurnedIn 11021
.goto Terokkar Forest,64.0,66.8
.accept 11024 >> Accept An Ally in Lower City
step
.itemcount 32388,6
.goto Terokkar Forest,64.0,66.8
.accept 11004 >> Accept World of Shadows
.turnin 11004 >> Turn in World of Shadows
step
.isOnQuest 11008
.goto Terokkar Forest,64.6,66.6
.turnin 11008 >> Turn in Fires over Skettis
step << Alliance
.isQuestTurnedIn 10612
.goto Shadowmoon Valley,40.8,22.2
.accept 10744 >> Accept News of Victory
step << Alliance
.isQuestTurnedIn 10522
.goto Shadowmoon Valley,44.6,23.7
.accept 10523 >> Accept The Cipher of Damnation - The First Fragment Recovered
step << Horde
.isQuestTurnedIn 10613
.goto Shadowmoon Valley,27.4,21.2
.accept 10745 >> Accept News of Victory
step << Horde
.isOnQuest 10745
.goto Shadowmoon Valley,28.4,26.4
.turnin 10745 >> Turn in News of Victory
step << Horde
.isQuestAvailable 10750
.goto Shadowmoon Valley,28.4,26.4
.accept 10750 >> Accept The Path of Conquest
step << Horde
.isQuestTurnedIn 10625
.goto Shadowmoon Valley,29.8,27.8
.accept 10633 >> Accept Teron Gorefiend - Lore and Legend
step
.isQuestTurnedIn 10780
.goto Shadowmoon Valley,35.4,41.8
>> Parshah, the quest giver, patrols along the road
.unitscan Parshah
.accept 10782 >> Accept Imbuing the Headpiece
step
.isOnQuest 10782
.goto Shadowmoon Valley,43.1,44.9
.use 31360 >> Equip the trinket immediately as it has a CD, then use it near the altar
.complete 10782,1 
step
.isOnQuest 10782
.goto Shadowmoon Valley,35.4,41.8
>> Re-equip your normal trinket!
.turnin 10782 >> Turn in Imbuing the Headpiece
step
.isQuestTurnedIn 10540
.goto Shadowmoon Valley,29.5,50.6
.accept 10541 >> Accept The Cipher of Damnation - The Second Fragment Recovered
step << Alliance
.isOnQuest 10744
.goto Shadowmoon Valley,35.8,57.6
>> Go down the stairs in the building.
.turnin 10744 >> Turn in News of Victory
step << Alliance
.isQuestAvailable 10772
.goto Shadowmoon Valley,36.2,57.0
.accept 10772 >> Accept The Path of Conquest
step
.isQuestTurnedIn 10578
.goto Shadowmoon Valley,47.5,57.2
.accept 10579 >> Accept The Cipher of Damnation - The Third Fragment Recovered
step << Alliance
.isOnQuest 10772
.goto Shadowmoon Valley,51.8,61.0
.use 31310 >> Use the flare to summon the gryphon rider once you discover the path. You have to touch the ground in a safe location.
.turnin 10772 >> Turn in The Path of Conquest
step << Horde
.isOnQuest 10750
.goto Shadowmoon Valley,51.4,60.4
.use 31108 >> Use the flare to summon the wyvern rider once you discover the path. You have to touch the ground in a safe location.
.turnin 10750 >> Turn in The Path of Conquest
step
.itemcount 31345,1
.goto Shadowmoon Valley,51.4,72.7
.use 31345 >> Use the Journal of Val'zareq in your bags to accept the quest
.accept 10793 >> Accept The Journal of Val'zareq: Portends of War
.turnin 10793 >> Turn in The Journal of Val'zareq: Portends of War
step << Horde
.isOnQuest 10633
.goto Shadowmoon Valley,58.2,70.8
.turnin 10633 >> Turn in Teron Gorefiend - Lore and Legend
step
.itemcount 32427,30
.goto Shadowmoon Valley,66.0,86.4
.accept 11015 >> Accept Netherwing Crystals
.turnin 11015 >> Turn in Netherwing Crystals
step
.isOnQuest 11020
.goto Shadowmoon Valley,66.0,86.4
.turnin 11020 >> Turn in A Slow Death
step
.itemcount 32506,1
.goto Shadowmoon Valley,66.0,86.4
.accept 11049 >> Accept The Great Netherwing Egg Hunt
.turnin 11049 >> Turnin The Great Netherwing Egg Hunt
step
.itemcount 32464,40
.reputation 1015,neutral,<0,1
.goto Shadowmoon Valley,66.0,86.4
.skill mining,<350,1
>> You can only turn in one gathering daily, if you have two gathering professions skip the next one.
.accept 11018 >> Accept Nethercite Ore
.turnin 11018 >> Turn in Nethercite Ore
step
.itemcount 32468,40
.reputation 1015,neutral,<0,1
.goto Shadowmoon Valley,66.0,86.4
.skill herbalism,<350,1
>> You can only turn in one gathering daily, if you have two gathering professions skip the next one.
.accept 11017 >> Accept Netherdust Pollen
.turnin 11017 >> Turn in Netherdust Pollen
step
.itemcount 32470,435
.reputation 1015,neutral,<0,1
.goto Shadowmoon Valley,66.0,86.4
.skill skinning,<350,1
>> You can only turn in one gathering daily, if you have two gathering professions skip the next one.
.accept 11016 >> Accept Nethermine Flayer Hide
.turnin 11016 >> Turn in Nethermine Flayer Hide
step
.goto Shadowmoon Valley,66.0,86.4
.reputation 1015,friendly,<0,1
.accept 11053 >> Accept Rise, Overseer!
step
.isOnQuest 11053
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,friendly,<0,1
.turnin 11053 >> Turn in Rise, Overseer!
step
.goto Shadowmoon Valley,66.2,86.4
.reputation 1015,friendly<0,1
.accept 11075 >> Accept The Netherwing Mines
step
.isQuestAvailable 11084
.goto Shadowmoon Valley,66.0,86.4
.reputation 1015,honored,<0,1
.accept 11084 >> Accept Stand Tall, Captain!
step
.isOnQuest 11084
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,honored,<0,1
.turnin 11084 >> Turn in Stand Tall, Captain!
step
.isQuestAvailable 11092
.goto Shadowmoon Valley,66.0,86.4
.reputation 1015,revered,<0,1
.accept 11092 >> Accept Hail, Commander!
step
.isOnQuest 11092
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,revered,<0,1
.turnin 11092 >> Turn in Hail, Commander!
step
#aldor
.isQuestAvailable 11099
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,revered,<0,1
.accept 11099 >> Accept Kill Them All
step
#scryer
.isQuestAvailable 11094
.goto Shadowmoon Valley,66.2,85.6
.reputation 1015,revered,<0,1
.accept 11094 >> Accept Kill Them All
step
.goto Shadowmoon Valley,66.0,86.4
.itemcount 32509,10
.turnin 11035 >> Turn in The Not-So-Friendly Skies...
step
.isOnQuest 11075
.goto Shadowmoon Valley,63.0,87.8
.turnin 11075 >> Turn in The Netherwing Mines
step
.itemcount 32724,1
>> Open your Sludge Covered Objects until you get a Murkblood Escape plan
.collect 32726,1,11081,1
step
.itemcount 32726,1
.goto Shadowmoon Valley,63.0,87.8
.use 32726 >> Use the Murkblood Escape Plans in your bag to accept the quest
.accept 11081 >> Accept The Great Murkblood Revolt
.turnin 11081 >> Turn in The Great Murkblood Revolt
step
#scryer
.isOnQuest 11094
.goto Shadowmoon Valley,56.2,59.6
.reputation 1015,revered,<0,1
.turnin 11094 >> Turn in Kill Them All
step
.isOnQuest 10707
.goto Shadowmoon Valley,58.0,48.2
.turnin 10707 >> Turn in The Ata'mal Terrace
step
.isOnQuest 10679
.goto Shadowmoon Valley,51.9,40.2
.use 30875 >> Use the Forged Illidari-Bane Blade in the lava pools
.complete 10679,1
step << Horde
.isQuestTurnedIn 10522
.goto Shadowmoon Valley,44.6,23.7
.accept 10523 >> Accept The Cipher of Damnation - The First Fragment Recovered
step
#aldor
.isOnQuest 11099
.goto Shadowmoon Valley,62.6,28.4
.reputation 1015,revered
.turnin 11099 >> Turn in Kill Them All
step
.isOnQuest 10523
.goto Shadowmoon Valley,53.9,23.4
.turnin 10523 >> Turn in The Cipher of Damnation - The First Fragment Recovered
step
.isOnQuest 10541
.goto Shadowmoon Valley,53.9,23.4
.turnin 10541 >> Turn in The Cipher of Damnation - The Second Fragment Recovered
step
.isOnQuest 10579
.goto Shadowmoon Valley,53.9,23.4
.turnin 10579 >> Turn in The Cipher of Damnation - The Third Fragment Recovered
step
.isOnQuest 10679
.goto Terokkar Forest,77.4,38.6
.turnin 10679 >> Turn in Quenching the Blade
step
.itemcount 23580,1
.goto Hellfire Peninsula,28.8,81.4
.use 23580 >> Use the Avruu's Orb in your bags to accept the quest
.accept 9418 >> Accept Avruu's Orb
.turnin 9418 >> Turn in Avruu's Orb
step << Alliance
.itemcount 23848,1
.goto Hellfire Peninsula,24.0,72.2
.reputation 946,friendly,<0,1 >> You need at least Friendly standing with Honor Hold for this step.
.accept 9563 >> Accept Gaining Mirren's Trust.
.turnin 9563 >> Turn in Gaining Mirren's Trust.
step << Horde
.isQuestTurnedIn 9400
.goto Hellfire Peninsula,33.6,43.6
.accept 9401 >> Accept A Strange Weapon.
step << Horde
.isOnQuest 9401
.goto Hellfire Peninsula,55.0,36.0
.turnin 9401 >> Turn in A Strange Weapon
step << Horde
.isQuestTurnedIn 9401
.goto Hellfire Peninsula,55.0,36.0
.accept 9405 >> Accept The Warchief's Mandate.
step << Horde
.itemcount 29590,1
.goto Hellfire Peninsula,55.0,36.0
.use 29590 >> Use the Burning Legion Missive in your bags to accept the quest
.accept 10393 >> Accept Vile Plans
step << Horde
.goto Hellfire Peninsula,55.0,36.0
.turnin 10393 >> Turn in Vile Plans
step << Horde
.itemcount 23892,1
.goto Hellfire Peninsula,55.0,36.0
.use 23892 >> Accept the quest from the Ominous Letter in your inventory
.accept 9588 >> Accept Dark Tidings
step
.isOnQuest 9588
.goto Hellfire Peninsula,55.0,36.0
.turnin 9588 >> Turn in Dark Tidings
step << Horde
.itemcount 31241,1
.goto Hellfire Peninsula,55.0,36.0
.use 31241 >> Accept the quest using the Primed Key Mold in your inventory
.accept 10755 >> Accept Entry Into the Citadel
step << Horde
.isOnQuest 10755
.goto Hellfire Peninsula,55.0,36.0
.turnin 10755 >> Turn in Entry Into the Citadel
step << Horde
.isQuestTurnedIn 10755
.goto Hellfire Peninsula,55.0,36.0
.accept 10756 >> Accept Grand Master Rohok
step << Horde
.itemcount 32386,1
.goto Hellfire Peninsula,55.0,36.0
.use 32386 >> Use Magtheridon's Head to accept the quest
.accept 11003 >> Accept The Fall of Magtheridon
.turnin 11003 >> Turn in The Fall of Magtheridon
step << Horde
.itemcount 23723,1
.goto Hellfire Peninsula,55.0,36.0
.turnin 9495 >> Turn in The Will of the Warchief
step << Horde
.isOnQuest 9405
.goto Hellfire Peninsula,54.2,37.8
.turnin 9405 >> Turn in The Warchief's Mandate.
step << Horde
.isOnQuest 10756
.goto Hellfire Peninsula,53.2,38.2
.turnin 10756 >> Turn in Grand Master Rohok
step << Horde
.isQuestTurnedIn 10756
.goto Hellfire Peninsula,53.2,38.2
.accept 10757 >> Accept Rohok's Request
.turnin 10757 >> Turn in Rohok's Request
step << Alliance
.isOnQuest 9493
.goto Hellfire Peninsula,56.8,62.6
.turnin 9493 >> Turn in Pride of the Fel Horde
step << Alliance
.isQuestTurnedIn 10047
.goto Hellfire Peninsula,56.6,66.6
.accept 10093 >> Accept The Temple of Telhamat from Warp-Scryer Kryv inside the keep.
step << Alliance
.itemcount 29590,1
.goto Hellfire Peninsula,56.6,66.4
.use 29590 >> Use the Burning Legion Missive in your bags to accept the quest
.accept 10395 >> Accept The Dark Missive
step << Alliance
.isOnQuest 10395
.goto Hellfire Peninsula,56.6,66.4
.turnin 10395 >> Turn in The Dark Missive
step << Alliance
.itemcount 23890,1
.goto Hellfire Peninsula,56.6,66.4
.use 23890 >> Use the Ominous Letter in your bags to accept the quest
.accept 9587 >> Accept Dark Tidings
step << Alliance
.isOnQuest 9587
.goto Hellfire Peninsula,56.6,66.4
.turnin 9587 >> Turn in Dark Tidings
step << Alliance
.itemcount 32385,1
.goto Hellfire Peninsula,56.6,66.4
.use 32385 >> Use Magtheridon's Head to accept the quest
.accept 11002 >> Accept The Fall of Magtheridon
.turnin 11002 >> Turn in The Fall of Magtheridon
step << Alliance
.itemcount 31239,1
.goto Hellfire Peninsula,56.6,66.6
.use 31239 >> Accept the quest by using the Primed Key Mold in your inventory
.accept 10754 >> Accept Entry Into the Citadel
step << Alliance
.isOnQuest 10754
.goto Hellfire Peninsula,56.6,66.6
.turnin 10754 >> Turn in Entry Into the Citadel
step << Alliance
.isQuestAvailable 10762
.goto Hellfire Peninsula,56.6,66.6
.accept 10762 >> Accept Grand Master Dumphry
step << Alliance
.isOnQuest 9492
.goto Hellfire Peninsula,56.6,66.4
.turnin 9492 >> Turn in Turning the Tide
step << Alliance
.isOnQuest 9494
.goto Hellfire Peninsula,53.8,65.6
.turnin 9494 >> Turn in Fel Embers
step << Alliance
.isOnQuest 10762
.goto Hellfire Peninsula,51.2,60.2
.turnin 10762 >> Turn in Grand Master Dumphry
step << Alliance
.isQuestTurnedIn 10762
.goto Hellfire Peninsula,51.2,60.2
.accept 10763 >> Accept Dumphry's Request
.turnin 10763 >> Turn in Dumphry's Request
step
.isOnQuest 11515
.goto Hellfire Peninsula,58.2,17.6
.turnin 11515 >> Turn in Blood for Blood
step
.isOnQuest 11516
.goto Hellfire Peninsula,58.2,17.6
.turnin 11516 >> Turn in Blast the Gateway
step << Alliance
.isQuestTurnedIn 9390
.goto Hellfire Peninsula,26.8,37.6
>> Speak to the corpse
.accept 9423 >> Accept Return to Obadei.
step << Alliance
.isOnQuest 10093
.goto Hellfire Peninsula,23.4,36.6
.turnin 10093 >> Turn in The Temple of Telhamat.
step << Alliance
.isQuestAvailable 9423
.goto Hellfire Peninsula,23.0,40.4
.turnin 9423 >> Turn in Return to Obadei.
step
.itemcount 23338,1
.goto Hellfire Peninsula,15.6,52.2
.use 23338 >> Use the Eroded Leather Case in your bags to accept the quest
.accept 9373 >> Accept the Missing Missive
.turnin 9373 >> Turn in the Missing Missive
step
.itemcount 29476,1
.goto Hellfire Peninsula,15.6,52.2
.use 29476 >> Use the Crimson Crystal Shard in your bags to accept the quest
.accept 10134 >> Accept Crimson Crystal Clue
.turnin 10134 >> Turn in Crimson Crystal Clue
step << Horde
.isQuestTurnedIn 9774
.goto Zangarmarsh,85.2,54.6
.accept 9771 >> Accept Searching for Scout Jyoba.
step << Horde
.isQuestAvailable 9775
.goto Zangarmarsh,85.2,54.6
.accept 9775 >> Accept Report to Shadow Hunter Denjai.
step << Horde
.itemcount 24484,1
.goto Zangarmarsh,85.0,54.0
.use 24484 >> Use the Withered Basidium in your inventory to accept the quest
.accept 9828 >> Accept Withered Basidium
.turnin 9828 >> Turn in Withered Basidium
step << Horde
.isOnQuest 9771
.goto Zangarmarsh,80.8,36.2
.turnin 9771 >> Turn in Searching for Scout Jyoba.
step
.isQuestTurnedIn 9731
.goto Zangarmarsh,78.4,62.0
.accept 9724 >> Accept Warning the Cenarion Circle.
step
.itemcount 24367,1
.goto Zangarmarsh,78.4,62.0
.use 24367 >> Use the Orders from Lady Vashj in your bags to accept the quest
.accept 9764 >> Accept Orders from Lady Vashj
.turnin 9764 >> Turn in Orders from Lady Vashj
step
.isQuestTurnedIn 9764
.goto Zangarmarsh,78.4,62.0
.accept 9765 >> Accept Preparing for War
.turnin 9765 >> Turn in Preparing for War
step
.isQuestAvailable 9697
.goto Zangarmarsh,78.6,63.2
.reputation 942,friendly,<0,1 >> Skip this step if you arent at least Friendly with Cenarion Expedition.
.accept 9697 >> Accept Watcher Leesa'oh
step
.itemcount 24401,10
.goto Zangarmarsh,80.2,64.2
.accept 9802 >> Accept Plants of Zangarmarsh
.turnin 9802 >> Turn in Plants of Zangarmarsh
step
.isQuestAvailable 9785
.goto Zangarmarsh,80.4,64.6
.accept 9785 >> Accept Blessings of the Ancients
step
.isOnQuest 9785
.goto Zangarmarsh,81.0,64.0,20,0
.goto Zangarmarsh,79.8,64.4
.skipgossip
>> Talk to Ancient Ashyen and Keleth to receive their mark.
.unitscan Ashyen
.unitscan Keleth
.complete 9785,1
.complete 9785,2
step
.isOnQuest 9785
.goto Zangarmarsh,80.4,64.6
.turnin 9785 >> Turn in Blessings of the Ancients
step << skip
.isQuestAvailable 9957
.goto Zangarmarsh,78.6,63.0
.accept 9957 >> Accept What's Wrong at Cenarion Thicket?
step
.isQuestTurnedIn 9731
.goto Hellfire Peninsula,16.0,52.2
.turnin 9724 >> Turn in Warning the Cenarion Circle.
step
.isQuestTurnedIn 9731
.goto Hellfire Peninsula,16.0,52.2
.accept 9732 >> Accept Return to the Marsh.
step
.isQuestTurnedIn 9731
.goto Zangarmarsh,78.4,62.0
.turnin 9732 >> Turn in Return to the Marsh.
step << Alliance
.itemcount 24483,1
.goto Zangarmarsh,68.6,48.8
.use 24483 >> Use the Withered Basidium in your inventory to accept the quest
.accept 9827 >> Accept Withered Basidium
.turnin 9827 >> Turn in Withered Basidium
step
.isQuestTurnedIn 10231
.goto Shattrath City,43.6,29.6
>> Skip this step if "Dirty" Larry is dead.
.accept 10251 >> Accept The Master's Grand Design?
step << Alliance
.isOnQuest 10863
.goto Shattrath City,52.6,20.8
.turnin 10863 >> Turn in Secrets of the Arakkoa.
step << Horde
.isOnQuest 10862
.goto Shattrath City,52.6,20.8
.turnin 10862 >> Turn in Surrender to the Horde.
step
.isQuestTurnedIn 10009
.goto Shattrath City,77.2,34.8
.accept 10010 >> Accept It's Just That Easy?
step
#completewith isleofquel
.goto Shattrath City,48.7,42.2
.zone 122 >> Take the portal in Shattrath to the Isle of Quel'Danas
step
.isOnQuest 11521
.goto Isle of Quel'Danas,53.8,34.2
.turnin 11521 >> Turn in Rediscovering Your Roots
step
.isOnQuest 11546
.goto Isle of Quel'Danas,53.8,34.2
.turnin 11546 >> Turn in Open for Business
step
.isOnQuest 11541
.goto Isle of Quel'Danas,51.4,32.6
.turnin 11541 >> Turn in Disrupt the Greengill Coast
step
.isOnQuest 11550
.goto Isle of Quel'Danas,50.2,28.2
.turnin 11550 >> Turn in Enter the Deceiver...
step
.isOnQuest 11523
.goto Isle of Quel'Danas,47.4,30.6
.turnin 11523 >> Turn in Arm the Wards!
step
.isOnQuest 11525
.goto Isle of Quel'Danas,47.2,30.6
.turnin 11525 >> Turn in Further Conversions
step
.isOnQuest 11533
.goto Isle of Quel'Danas,47.6,35.2
.turnin 11533 >> Turn in The Air Strikes Must Continue
step
.isOnQuest 11547
.goto Isle of Quel'Danas,47.6,35.4
>> Use the scroll reward it gives you to return to Shattrath if you are not going to turn in the Zul'Aman or Alteran Valley quests.
.turnin 11547 >> Turn in Know Your Ley Lines
step
.isOnQuest 11536
.goto Isle of Quel'Danas,50.4,40.6
.turnin 11536 >> Turn in Don't Stop Now....
step
.itemcount 34501,5
.goto Isle of Quel'Danas,50.4,40.6
.turnin 11544 >> Turn in Ata'mal Armaments
step
.isOnQuest 11542
.goto Isle of Quel'Danas,50.4,39.0
.turnin 11542 >> Turn in Intercept the Reinforcements
step
.isOnQuest 11543
.goto Isle of Quel'Danas,50.4,39.0
.turnin 11543 >> Turn in Keeping the Enemy at Bay
step
.isOnQuest 11539
.goto Isle of Quel'Danas,49.4,40.0
.turnin 11539 >> Turn in Taking the Harbor
step
#label isleofquel
.isOnQuest 11540
.goto Isle of Quel'Danas,49.4,40.0
.turnin 11540 >> Turn in Crush the Dawnblade
step
.itemcount 33102,1
>> This step requires a summon to Ghostlands and a mage portal back to Shattrath to be effecient, skip if you don't have access to those.
.goto Ghostlands,70.4,67.8
.use 33102 >> Use the Blood of Zul'jin to accept the quest
.accept 11178 >> Accept Blood of the Warlord
.turnin 11178 >> Turn in Blood of the Warlord
.accept 11163 >> Accept Undercover Sister
step
.isQuestTurnedIn 11178
.goto Ghostlands,70.6,68.2
.turnin 11163 >> Turn in Undercover Sister
step << Alliance
.isOnQuest 7141
.goto Alterac Mountains,40.6,79.8
>> This step requires a summon to Alterac Mountains and a mage portal back to Shattrath to be effecient, skip if you don't have access to those.
.turnin 7141 >> Turn in The Battle of Alterac
step << Alliance
.isQuestAvailable 8271
.goto Alterac Mountains,40.6,79.8
>> This step requires a summon to Alterac Mountains and a mage portal back to Shattrath to be effecient, skip if you don't have access to those.
.turnin 8271 >> Turn in Hero of the Stormpike
step << Alliance
.isQuestAvailable 7169
.goto Alterac Mountains,39.6,81.2
>> This step requires a summon to Alterac Mountains and a mage portal back to Shattrath to be effecient, skip if you don't have access to those.
.turnin 7169 >> Turn in Honored Amongst the Guard
step << Alliance
.isQuestAvailable 7170
.goto Alterac Mountains,39.6,81.2
>> This step requires a summon to Alterac Mountains and a mage portal back to Shattrath to be effecient, skip if you don't have access to those.
.turnin 7170 >> Turn in Earned Reverence
step << Alliance
.isQuestAvailable 7171
.goto Alterac Mountains,39.6,81.2
>> This step requires a summon to Alterac Mountains and a mage portal back to Shattrath to be effecient, skip if you don't have access to those.
.turnin 7171 >> Turn in Legendary Heroes
step << Alliance
.isQuestAvailable 7172
.goto Alterac Mountains,39.6,81.2
>> This step requires a summon to Alterac Mountains and a mage portal back to Shattrath to be effecient, skip if you don't have access to those.
.turnin 7172 >> Turn in The Eye of Command
step << Horde
.isOnQuest 7142
.goto Alterac Mountains,63.0,60.0
>> This step requires a summon to Alterac Mountains and a mage portal back to Shattrath to be effecient, skip if you don't have access to those.
.turnin 7142 >> Turn in The Battle for Alterac
step << Horde
.isQuestAvailable 8272
.goto Alterac Mountains,63.0,60.0
>> This step requires a summon to Alterac Mountains and a mage portal back to Shattrath to be effecient, skip if you don't have access to those.
.turnin 8272 >> Turn in Hero of the Frostwolf
step << Horde
.isQuestAvailable 7164
.goto Alterac Mountains,62.2,58.9
>> This step requires a summon to Alterac Mountains and a mage portal back to Shattrath to be effecient, skip if you don't have access to those.
.turnin 7164 >> Turn in Honored Amongst the Guard
step << Horde
.isQuestAvailable 7165
.goto Alterac Mountains,62.2,58.9
>> This step requires a summon to Alterac Mountains and a mage portal back to Shattrath to be effecient, skip if you don't have access to those.
.turnin 7165 >> Turn in Earned Reverence
step << Horde
.isQuestAvailable 7166
.goto Alterac Mountains,62.2,58.9
>> This step requires a summon to Alterac Mountains and a mage portal back to Shattrath to be effecient, skip if you don't have access to those.
.turnin 7166 >> Turn in Legendary Heroes
step << Horde
.isQuestAvailable 7167
.goto Alterac Mountains,62.2,58.9
>> This step requires a summon to Alterac Mountains and a mage portal back to Shattrath to be effecient, skip if you don't have access to those.
.turnin 7167 >> Turn in The Eye of Command
step
#completewith postav
.zoneskip Ghostlands,1
.zone Shattrath City >> Arrive in Shattrath City
>> Port to Shattrath. Do NOT hearth << !Shaman
>> Port or Hearth to Shattrath << Shaman
step
#completewith postav
.zoneskip Alterac Mountains,1
.zone Shattrath City >> Arrive in Shattrath City
>> Port to Shattrath. Do NOT hearth << !Shaman
>> Port or Hearth to Shattrath << Shaman
step
#completewith postav
.zoneskip Isle of Quel'Danas,1
.zone Shattrath City >> Arrive in Shattrath City
>> Port to Shattrath. Do NOT hearth << !Shaman
>> Port or Hearth to Shattrath << Shaman
step
#sticky
#label postav
.zone Shattrath City >> Arrive back in Shattrath City. Skip this step manually if you're already in Outlands.
step << Horde
.isQuestTurnedIn 9928
.goto Nagrand,73.8,62.6
.accept 9934 >> Accept Message to Garadar.
step << Alliance
.isQuestTurnedIn 9932
.goto Nagrand,73.8,62.6
.accept 9933 >> Accept Message to Telaar.
step
.isOnQuest 10251
.goto Nagrand,51.8,56.8
.turnin 10251 >> Turn in The Master's Grand Design?
step << Horde
.isOnQuest 9934
.goto Nagrand,55.4,37.6
.turnin 9934 >> Turn in Message to Garadar.
step << Horde
.isOnQuest 9937
.goto Nagrand,55.8,37.8
.turnin 9937 >> Turn in Wanted: Durn the Hungerer
step << Alliance
.isOnQuest 11502
.goto Nagrand,55.8,73.6
.turnin 11502 >> Turn in In Defense of Halaa
step << Alliance
.isOnQuest 9933
.goto Nagrand,55.4,68.8
.turnin 9933 >> Turn in Message to Telaar.
step << Alliance
.isOnQuest 9938
.goto Nagrand,55.8,37.8
.turnin 9938 >> Turn in Wanted: Durn the Hungerer
step << Alliance
.itemcount 24559,1
.goto Nagrand,55.4,68.8
.use 24559 >> Use the Murkblood Invasion Plans in your inventory to accept the quest
.accept 9871 >> Accept Murkblood Invaders
.turnin 9871 >> Turn in Murkblood Invaders
step << Alliance
.itemcount 25433,10
.goto Nagrand,54.8,70.8
.accept 10476 >> Accept Fierce Enemies.
.turnin 10476 >> Turn in Fierce Enemies.
step << Horde
.goto Nagrand,57.0,34.8
>> Find Matron Drakia around the hut
.unitscan Matron Drakia
.accept 9944 >> Accept Missing Mag'hari Procession.
step
.goto Nagrand,31.4,57.6
.reputation 933,neutral,<0,1
.itemcount 25416,10
.accept 9882 >> Accept Stealing from Thieves
.turnin 9882 >> Turn in Stealing from Thieves
step
.goto Nagrand,31.6,56.8
.reputation 933,neutral,<0,1
.itemcount 25463,3
>> Turn in A Head Full of Ivory until you are friendly. Should be 9 turnins total.
.accept 9914 >> Accept A Head Full of Ivory
.turnin 9914 >> Turn in A Head Full of Ivory
step
.goto Nagrand,31.4,57.6
.reputation 933,friendly,<0,1
.itemcount 25433,10
.accept 9893 >> Accept Obsidian Warbeads
.turnin 9893 >> Turn in Obsidian Warbeads
step << Horde
>> If it's controlled by the Alliance, skip this step.
.itemcount 26042,10
.goto Nagrand,41.2,44.3
.accept 10074 >> Accept Oshu'gun Crystal Powder
.turnin 10074 >> Turn in Oshu'gun Crystal Powder
step << Horde
.isOnQuest 10010
.goto Nagrand,27.4,43.0
.turnin 10010 >> Turn in It's Just That Easy?
step << Horde
.isOnQuest 10649
.goto Nagrand,27.4,43.0
.turnin 10649 >> Turn in The Book of Fel Names
step << Horde
.isOnQuest 9944
.goto Nagrand,32.2,36.2
.turnin 9944 >> Turn in Missing Mag'hari Procession.
step << Horde
.isQuestTurnedIn 9865
.goto Nagrand,32.4,36.0
.accept 9866 >> Accept He Will Walk The Earth...
step << Horde
.isOnQuest 11503
.goto Nagrand,52.8,36.0
.turnin 11503 >> Turn in Enemies, Old and New
step << Horde
.isOnQuest 9866
.goto Nagrand,54.8,39.8
.turnin 9866 >> Turn in He Will Walk The Earth...
step << Horde
.itemcount 24558,1
.goto Nagrand,55.4,37.6
.use 24558 >> Use the Murkblood Invasion Plans in your inventory to accept the quest
.accept 9872 >> Accept Murkblood Invaders
.turnin 9872 >> Turn in Murkblood Invaders
step << Horde
.isQuestAvailable 9870
.goto Nagrand,55.6,37.8
>> Find Elementalist Yal'hah around the town
.unitscan Elementalist Yal'hah
.accept 9870 >> Accept The Throne of the Elements.
step << Horde
.itemcount 25433,10
.goto Nagrand,55.8,37.8
.accept 10479 >> Accept Proving Your Strength.
.turnin 10479 >> Turn in Proving Your Strength.
step << Horde
.isOnQuest 9870
.goto Nagrand,60.6,22.2
.turnin 9870 >> Turn in The Throne of the Elements.
step << Horde
.isOnQuest 9853
.goto Nagrand,61.2,22.2
.turnin 9853 >> Turn in Gurok the Usurper
step << Horde
.itemcount 24504,1
.goto Nagrand,60.6,22.2
.use 24504 >> Use the Howling Wind in your inventory to accept the quest
.accept 9861 >> Accept The Howling Wind
.turnin 9861 >> Turn in The Howling Wind
step << Alliance
.isOnQuest 10010
.goto Nagrand,27.4,43.0
.turnin 10010 >> Turn in It's Just That Easy?
step << Alliance
.isOnQuest 10649
.goto Nagrand,24.7,43.0
.turnin 10649 >> Turn in The Book of Fel Names
step << Alliance
>> If it's controlled by the Horde, skip this step.
.itemcount 26043,10
.goto Nagrand,41.2,44.2
.accept 10076 >> Accept Oshu'gun Crystal Powder
.turnin 10076 >> Turn in Oshu'gun Crystal Powder
step << Alliance
.itemcount 24504,1
.goto Nagrand,60.6,22.2
.use 24504 >> Use the Howling Wind in your inventory to accept the quest
.accept 9861 >> Accept The Howling Wind
.turnin 9861 >> Turn in The Howling Wind
step << Alliance
.isOnQuest 9853
.goto Nagrand,61.2,22.2
.turnin 9853 >> Turn in Gurok the Usurper
step
.isOnQuest 9977
.goto Nagrand,42.8,20.6
.turnin 9977 >> Turn in The Ring of Blood: The Final Challenge
step
.isOnQuest 9697
.goto Zangarmarsh,23.2,66.2
>> If she is not here someone may have turned in a quest recently that causes her to disappear. If the area is packed don't wait around for her, skip this step.
.turnin 9697 >> Turn in Watcher Leesa'oh
step
.isQuestAvailable 9697
.goto Zangarmarsh,23.2,66.2
.accept 9701 >> Accept Observing the Sporelings
step
.itemcount 24291,6
.goto Zangarmarsh,19.0,62.6
.accept 9743 >> Accept Natural Enemies
.turnin 9743 >> Turn in Natural Enemies
step
.itemcount 24290,10
.goto Zangarmarsh,19.0,62.6
.accept 9739 >> Accept The Sporelings' Plight
.turnin 9739 >> Turn in The Sporelings' Plight
step
.isQuestAvailable 9919
.goto Zangarmarsh,19.0,63.6
.reputation 970,neutral,<0,1 >> You must be atleast neutral with Sporeggar to accept this quest
.accept 9919 >> Accept Sporeggar
step
.isOnQuest 9701
.goto Zangarmarsh,15.3,61.9
>> Explore the area.
.complete 9701,1
.complete 9701,2
step
.isOnQuest 9919
.goto Zangarmarsh,19.6,52.0
.turnin 9919 >> Turn in Sporeggar
step
#completewith next
.goto Zangarmarsh,19.0,62.6
.reputation 970,friendly >> Finish turning in Bog Lord Tendrils or Mature Spore Sacs until you are friendly.
step
.goto Zangarmarsh,19.2,49.4
.reputation 970,friendly,<0,1
.itemcount 24245,10
.accept 9808 >> Accept Glowcap Mushrooms
.turnin 9808 >> Turn in Glowcap Mushrooms
step
.itemcount 24246,5
.goto Zangarmarsh,19.5,50.1
.reputation 970,friendly,<0,1
.accept 9715 >> Accept Bring Me A Shrubbery!
.turnin 9715 >> Turn in Bring Me A Shrubbery!
step
.itemcount 24449,6
.goto Zangarmarsh,19.2,49.4
.reputation 970,friendly,<0,1
.accept 9806 >> Accept Fertile Spores
.turnin 9806 >> Turn in Fertile Spores
step
#label sporenomore
.itemcount 25459,1
.goto Zangarmarsh,23.2,66.2
.use 25459 >> Use "Count" Ungula's Mandible in your inventory to accept the quest
.accept 9911 >> Accept The Count of the Marshes
.turnin 9911 >> Turn in The Count of the Marshes
step
.isOnQuest 9701
.goto Zangarmarsh,23.2,66.2
.turnin 9701 >> Turn in Observing the Sporelings
step << Horde
.isOnQuest 9775
.goto Zangarmarsh,30.6,50.8
>> He's on the second floor of the hut
.turnin 9775 >> Turn in Report to Shadow Hunter Denjai.
step << Horde
.isQuestAvailable 9795
.goto Zangarmarsh,30.6,50.8
.accept 9795 >> Accept The Ogre Threat.
step << skip 
.isQuestTurnedIn 9968
.goto Terokkar Forest,44.4,26.2
.turnin 9957 >> Turn in What's Wrong at Cenarion Thicket?
step << Alliance
.isQuestAvailable 9794
.goto Zangarmarsh,41.2,28.6
.accept 9794 >> Accept No Time for Curiosity.
step
.isOnQuest 9738
.goto Zangarmarsh,52.2,36.0
>> Head into the underwater resevoir in the middle of the lake
.turnin 9738 >> Turn in Lost In Action
step
.isOnQuest 9763
.goto Zangarmarsh,52.2,36.0
.turnin 9763 >> Turn in The Warlord's Hideout
step << Alliance
.isOnQuest 9794
.goto Blade's Edge Mountains,36.0,67.8
.turnin 9794 >> Turn in No Time for Curiosity.
step << Alliance
.itemcount 29443,11
.goto Blade's Edge Mountains,37.4,64.6
.accept 10511 >> Accept Strange Brew.
.turnin 10511 >> Turn in Strange Brew.
step << Alliance
.isQuestAvailable 10581
.goto Blade's Edge Mountains,36.6,66.4
.accept 10580 >> Accept Where Did Those Darn Gnomes Go?
step
.isOnQuest 11000
.goto Blade's Edge Mountains,55.4,44.9
.turnin 11000 >> Turn in Into the Soulgrinder
step
.isQuestTurnedIn 11000
.goto Blade's Edge Mountains,55.4,44.9
.accept 11009 >> Accept Ogre Heaven
step << Horde
.isOnQuest 10742
.goto Blade's Edge Mountains,51.8,58.4
.turnin 10742 >> Turn in Showdown
step << Alliance
.isOnQuest 10806
.goto Blade's Edge Mountains,53.2,41.2
.turnin 10806 >> Turn in Showdown
step << Horde
.isOnQuest 9795
.goto Blade's Edge Mountains,51.8,57.8
.turnin 9795 >> Turn in The Ogre Threat.
step
.isOnQuest 11009
.goto Blade's Edge Mountains,28.7,57.4
.turnin 11009 >> Turn in Ogre Heaven
step
.itemcount 32569,5
.goto Blade's Edge Mountains,28.8,57.4
.accept 11025 >> Accept The Crystals.
.turnin 11025 >> Turn in The Crystals.
step
.itemcount 32598,1
.goto Blade's Edge Mountains,28.4,57.6
.accept 11030 >> Accept Our Boy Wants To Be A Skyguard Ranger.
.turnin 11030 >> Turn in Our Boy Wants To Be A Skyguard Ranger.
step
.itemcount 32601,1
.goto Blade's Edge Mountains,28.4,57.6
.accept 11061 >> Accept A Father's Duty
.turnin 11061 >> Turn in A Father's Duty
step << Alliance
.isOnQuest 10580
.goto Blade's Edge Mountains,55.0,72.8
.turnin 10580 >> Turn in Where Did Those Darn Gnomes Go?
step << Alliance
.isQuestTurnedIn 10580
.goto Blade's Edge Mountains,55.0,72.8
.accept 10581 >> Accept Follow the Breadcrumbs.
step << Alliance
.isOnQuest 10581
.goto Blade's Edge Mountains,60.4,69.0
.turnin 10581 >> Turn in Follow the Breadcrumbs.
step
.itemcount 31384,1
.goto Blade's Edge Mountains,62.6,40.2
.use 31384
.accept 10810 >> Accept Damaged Mask from the quest item in your inventory.
.turnin 10810 >> Turn in Damaged Mask.
.accept 10812 >> Accept Mystery Mask.
step
.itemcount 31489,1
.goto Blade's Edge Mountains,62.0,39.4
.use 31489 >> Use the Orb of the Grishna in your inventory to accept the quest
.accept 10825 >> Accept The Truth Unorbed
.turnin 10825 >> Turn in The Truth Unorbed
step
.isQuestAvailable 10682
.goto Blade's Edge Mountains,62.0,39.4
.accept 10682 >> Accept A Time for Negotiation...
step
.isOnQuest 10682
.goto Blade's Edge Mountains,62.7,44.0,80,0
.goto Blade's Edge Mountains,58.5,39.4,80,0
.goto Blade's Edge Mountains,62.0,32.1
.line Blade's Edge Mountains,63.0,45.8,58.4,38.6,63.0,27.2
.unitscan Overseer Nuaar
>> Go up and down the line looking for Oversee Nuarr then speak to him
.skipgossip
.complete 10682,1
step
.isOnQuest 10682
.goto Blade's Edge Mountains,62.0,39.4
.turnin 10682 >> Turn in A Time for Negotiation...
step
.isOnQuest 10812
.goto Blade's Edge Mountains,61.6,38.4
>> The quest giver walks around i a circle in the city.
.turnin 10812 >> Turn in Mystery Mask.
step
.isQuestTurnedIn 10819
.goto Blade's Edge Mountains,61.6,38.4
.accept 10819 >> Accept Felsworn Gas Mask.
step
.isOnQuest 10819
.goto Blade's Edge Mountains,73.3,40.1
.use 31366 >> Wear the Felsworn Gas Mask.
.turnin 10819 >> Turn in Felsworn Gas Mask.
step << Horde
.itemcount 31670,3
.goto Blade's Edge Mountains,76.0,60.2
.accept 10860 >> Accept Mok'Nathal Treats.
.turnin 10860 >> Turn in Mok'Nathal Treats.

step
.isQuestAvailable 10317
.goto Netherstorm,34.6,37.8
.accept 10317 >> Accept Dealing with the Foreman.
step
.isOnQuest 10317
.goto Netherstorm,26.4,42.2
.turnin 10317 >> Turn in Dealing with the Foreman just inside the mine.
step
.isOnQuest 9631
.goto Netherstorm,32.2,63.6
.turnin 9631 >> Turn in A Colleague's Aid.
step
.isQuestTurnedIn 10186
.goto Netherstorm,32.7,64.9
.accept 10225 >> Accept Report to Engineering
step
.isOnQuest 10225
.goto Netherstorm,32.4,66.6
.turnin 10225 >> Turn in Report to Engineering
step
#aldor
.isQuestTurnedIn 10407
.goto Netherstorm,32.0,64.2
.accept 10410 >> Accept Ishanah's Help
step
#scryer
.isQuestTurnedIn 10508
.goto Netherstorm,32.0,64.0
.accept 10509 >> Accept Bound for Glory.
step
.isQuestTurnedIn 10248
.goto Netherstorm,37.2,63.8
.accept 10249 >> Accept Back to the Chief!
step
.isOnQuest 10249
.goto Netherstorm,32.6,64.8
.turnin 10249 >> Turn in Back to the Chief!
step
.isQuestTurnedIn 10312
.goto Netherstorm,57.4,86.2
.accept 10316 >> Accept Searching for Evidence.
step
>> Go inside the tower and go to teh top of the tower.
.itemcount 28769,1
.goto Netherstorm,58.2,86.4
.turnin 10257 >> Turn in Capturing the Keystone
step
.isQuestAvailable 10334
.goto Netherstorm,57.6,85.0
.accept 10334 >> Accept Needs More Cowbell.
step
.itemcount 29233,1
.goto Netherstorm,56.9,86.8
.use 29233 >> Use Dathric's Blade to accept the quest
.accept 10182 >> Accept Battle-Mage Dathric
step
.itemcount 29235,1
.goto Netherstorm,56.4,87.8
.use 29235 >> Use Luminrath's Mantle to accept the quest
.accept 10306 >> Accept Conjurer Luminrath
step
.itemcount 29236,1
.goto Netherstorm,55.5,87.0
.use 29236 >> Use Cohlien's Cap to accept the quest
.accept 10307 >> Accept Cohlein Frostweaver
step
.itemcount 29234,1
.goto Netherstorm,55.5,86.5
.use 29234 >> Use Belmara's Tome to accept the quest
.accept 10305 >> Accept Abjurist Belmara
step
.isOnQuest 10182
.goto Netherstorm,56.9,86.8
.use 28351 >> Use the quest item to place Dathric's Blade on the weapon rack inside the town hall
.complete 10182,1
step
.isOnQuest 10307
.goto Netherstorm,55.5,87.0
.use 28353 >> Use the quest item to place Cohlien's cap inside the footlocker in the house
.complete 10307,1
step
.isOnQuest 10305
.goto Netherstorm,55.5,86.5
.use 28336 >> Use the quest item to place Belmara's Tome on the bookshelf in her house
.complete 10305,1
step
.isOnQuest 10306
.goto Netherstorm,56.4,87.8
.use 28352 >> Use the quest item to place Luminrath's Mantle in the dresser inside his house
.complete 10306,1
step
.isOnQuest 10307
.goto Netherstorm,57.4,86.2
.turnin 10307 >> Turn in Cohlien Frostweaver
step
.isOnQuest 10182
.goto Netherstorm,57.4,86.2
.turnin 10182 >> Turn in Battle-Mage Dathric
step
.isOnQuest 10305
.goto Netherstorm,57.4,86.2
.turnin 10305 >> Turn in Abjurist Belmara
step
.isOnQuest 10306
.goto Netherstorm,57.4,86.2
.turnin 10306 >> Turn in Conjurer Luminrath
step
.isOnQuest 10334
.goto Netherstorm,59.2,78.8
.turnin 10334 >> Turn in Needs More Cowbell.
step
.isOnQuest 10316
.goto Netherstorm,60.3,78.0
.turnin 10316 >> Turn in Searching for Evidence inside a barn.
step
.isQuestTurnedIn 10418
.goto Netherstorm,46.4,56.4
.accept 10423 >> Accept To the Stormspire.
step
.isQuestTurnedIn 10433
.goto Netherstorm,46.4,56.4
.accept 10434 >> Accept The Dynamic Duo.
step
>> Click on the Transponder Pod
.isOnQuest 10408
.goto Netherstorm,56.8,38.6
.turnin 10408 >> Turn in Nexus-King Salhadaar
step
.itemcount 29738,1
.goto Netherstorm,59.2,32.4
.use 29738 >> Use the Vial of Void Horror Ooze in your inventory to accept the quest
.accept 10413 >> Accept The Horrors of Pollution
.turnin 10413 >> Turn in The Horrors of Pollution
step
.isOnQuest 10439
.goto Netherstorm,60.0,31.8
.turnin 10439 >> Turn in Dimensius The All-Devouring
step
.isOnQuest 10423
.goto Netherstorm,43.6,35.0
.turnin 10423 >> Turn in To the Stormspire.
step
.isOnQuest 10434
.goto Netherstorm,44.8,36.6
.turnin 10434 >> Turn in The Dynamic Duo.
step
.isQuestTurnedIn 10276
.goto Netherstorm,45.8,36.0
>> Run through the purple circle teleporter to your left to teleport to Shattrath after accepting the quest
.accept 10280 >> Accept Special Delivery to Shattrath City
step
#completewith shat
.zone Shattrath City >> Head to Shattrath. Do NOT hearth if you have Caverns of Time quests to turn in. If you had the quest Special Delivery to Shattrath City use the portal it provides to Shattrath.
step
.isOnQuest 10280
.goto Shattrath City,54.0,44.6
.turnin 102080 >> Turn in Special Delivery to Shattrath City
step
#aldor
.isOnQuest 10410
.goto Shattrath City,24.2,29.8
.turnin 10410 >> Turn in Ishanah's Help
step
#scryer
.isOnQuest 10509
.goto Shattrath City,42.6,91.6
.turnin 10509 >> Turn in Bound for Glory.
step
#label shat
.isOnQuest 11024
.goto Shattrath City,52.6,20.8
.turnin 11024 >> Turn in An Ally in Lower City
step
.goto Shattrath City,74.7,31.5
.reputation 989,revered,<0,1 >> If you are revered with the Keepers of Time, talk to Zephyr to be ported to the Caverns of Time
.zone Tanaris >> If you are revered with the Keepers of Time, talk to Zephyr to be ported to the Caverns of Time
step
.zoneskip Tanaris
.goto Tanaris,66.1,49.7
+ Get a summon to Caverns of Time. The guide is finished if you don't have one, it's not worth the time if you need to run there. Off to Northrend!
step
.isOnQuest 10445
.goto Tanaris,58.3,54.8
>> Arazmodu and Soridomi patrol around the room counter clockwise, run around until you find them.
.unitscan Soridormi
.turnin 10445 >> Turn in The Vials of Eternity
step
.goto Tanaris,58.3,54.8
.reputation 989,friendly,<0,1
>> Arazmodu and Soridomi patrol around the room counter clockwise, run around until you find them. Accept the ring quest of your choice. This is not automated to prevent picking the wrong ring. Skip this step if none of the Friendly Ring quests are available.
.unitscan Soridormi
.dailyturnin 10462,10461,10460,10463 >> Turn in A Ring Pledge
step
.goto Tanaris,58.3,54.8
.reputation 989,honored,<0,1
>> Arazmodu and Soridomi patrol around the room counter clockwise, run around until you find them.
.unitscan Soridormi
.daily 10464,10465,10466,10467 >> Accept a Vow Ring Quest
.dailyturnin 10464,10465,10466,10467 >> Turn in a Vow Ring Quest
step
.goto Tanaris,58.3,54.8
.reputation 989,revered,<0,1
>> Arazmodu and Soridomi patrol around the room counter clockwise, run around until you find them.
.unitscan Soridormi
.daily 10468,10469,10470,10471 >> Accept an Oath Ring Quest
.dailyturnin 10468,10469,10470,10471 >> Turn in an Oath Ring Quest
step
.goto Tanaris,58.3,54.8
.reputation 989,exalted,<0,1
>> Arazmodu and Soridomi patrol around the room counter clockwise, run around until you find them.
.unitscan Soridormi
.daily 10472,10473,10474,10475 >> Accept an Covenant Ring Quest
.dailyturnin 10472,10473,10474,10475 >> Turn in an Covenant Ring Quest
step
.isOnQuest 10297
.goto Tanaris,57.6,62.7
>> Enter The Black Morass and turn in the quest
.turnin 10297 >> Turn in The Opening of the Dark Portal
]])