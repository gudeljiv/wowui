RXPGuides.RegisterGuide([[
#version 9
#wotlk
#group RestedXP Mage AoE 68-80
<< Mage
#name 68-80 Mage AoE

step
#completewith WHFP << Horde
#completewith VKHS << Alliance
+Welcome to the RXPGuides AoE Mage 68-80 Guide!
.link https://discord.com/invite/ApNgbdQNQy >> As this is Beta, the guide may have some bugs. If you encounter any while playing through, report them here!
step << Horde
#completewith BTZep1
.zone Orgrimmar >> Teleport to Orgrimmar
step << Horde
#level 68
.goto Orgrimmar,38.4,86.1
>>Go downstairs
.trainer >> Train your class spells
step << Horde
#label BTZep1
.goto Durotar,41.6,18.2,30,0
.goto Durotar,41.4,17.6
.zone BoreanTundra >>Take the Zeppelin from Durotar to Borean Tundra
step << Horde
#completewith end
#label WHHS
.goto BoreanTundra,41.92,54.49
.home >> Set your Hearthstone to Warsong Hold
step << Horde
#completewith end
#requires WHHS
#label WHFP
.goto BoreanTundra,40.72,52.54,20,0
.goto BoreanTundra,40.36,51.39
>> Take the stairs, and then the elevator to the top of the building
.fp Warsong Hold >> Get the Warsong Hold flight path
step << Alliance
#completewith Boat1
.zone Stormwind City >> Teleport to Stormwind
step << Alliance
#level 68
.goto Stormwind City,49.2,87.7
.trainer >> Train your class spells
step << Alliance
#label Boat1
.goto Stormwind City,43.5,52.7,70,0
.goto Stormwind City,17.7,25.5
.zone BoreanTundra >>Travel to the Stormwind Harbor. Get onto the boat when it comes. Take it to Borean Tundra
step << Alliance
#completewith end
#label VKFP
.goto BoreanTundra,58.9,68.3
.fp Valiance Keep >> Get the Valiance Keep flight path
step << Alliance
#completewith end
#requires VKFP
#label VKHS
.goto BoreanTundra,58.5,68.3,15,0
.goto BoreanTundra,58.3,68.1
>>Go inside the Inn
.home >> Set your Hearthstone to Valiance Keep
step << skip
.loop 75,BoreanTundra,54.0,48.8,55.1,42.4,53.6,39.2,54.8,38.4,61.8,40.0,62.2,31.7,55.6,27.1,57.3,34.2
.xp 72 >> AoE grind Mammoths, Wolves, Machines, Hawks and Caribous to 72
step
#requires WHFP << Horde
#requires VKHS << Alliance
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43,48.77,48.69
.xp 69 >> AoE grind Rhinos to 69
step
#level 69
#completewith next
.zone Undercity >> Teleport to Undercity << Horde
.zone Stormwind City >> Teleport to Stormwind << Alliance
step
#level 69
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >> Train your class spells
step
#completewith next
.hs >> Hearth to Valiance Keep << Alliance
.hs >> Hearth to Conquest Hold << Horde
step
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43,48.77,48.69
.xp 70 >> AoE grind Rhinos to 70
step
#level 70
#completewith next
.zone Undercity >> Teleport to Undercity << Horde
.zone Stormwind City >> Teleport to Stormwind << Alliance
step
#level 70
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >> Train your class spells
step
#completewith next
.hs >> Hearth to Conquest Hold << Horde
.hs >> Hearth to Valiance Keep << Alliance
step << skip
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43
.line BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43
.xp 71 >> AoE grind Rhinos to 71
step << skip
#level 71
#completewith next
.zone Undercity >> Teleport to Undercity << Horde
.zone Stormwind City >> Teleport to Stormwind << Alliance
step << skip
#level 71
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >> Train your class spells
step << skip
#completewith next
.hs >> Hearth to Conquest Hold << Horde
.hs >> Hearth to Valiance Keep << Alliance
step
.loop 75,BoreanTundra,48.77,48.69,42.48,47.53,43.11,42.42,47.18,40.43,48.77,48.69
.xp 72 >> AoE grind Rhinos to 72
step << skip
#level 72
#completewith next
.zone Undercity >> Teleport to Undercity << Horde
.zone Stormwind City >> Teleport to Stormwind << Alliance
step << skip
#level 72
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >> Train your class spells
step << skip
#completewith next
.hs >> Hearth to Conquest Hold << Horde
.hs >> Hearth to Valiance Keep << Alliance
step << skip
#completewith end
#label ALFP
.goto BoreanTundra,45.33,34.62
>>Travel to Amber Ledge
.fp Amber Ledge >> Get the Amber Ledge flight path
step << Horde
#completewith end
#label TaunFP
.goto BoreanTundra,77.76,37.77
>>Travel to Taunka'le
.fp Taunka'le Village >> Get the Taunka'le Village flight path
step << Alliance
#completewith end
#label UnuFP
.goto BoreanTundra,78.54,51.53
>>Travel to Unu'pe
.fp Unu'pe >> Get the Unu'pe flight path
step << Alliance
.goto BoreanTundra,82.17,46.41
>>Talk to Private Casey
.accept 12157 >>Accept The Lost Courier
step
#completewith next
.goto Dragonblight,12.39,55.22
.zone Dragonblight >> Travel to Dragonblight
step << Horde
#completewith end
#label AgmarFP
.goto Dragonblight,37.51,45.77
>>Travel to Agmar's Hammer
.fp Agmar's Hammer >> Get the Agmar's Hammer flight path
step << Horde
#completewith end
#requires WyrmFP
#label WyrmFP
.goto Dragonblight,60.32,51.55
>>Travel to Wyrmrest Temple
.fp Wyrmrest Temple >> Get the Wyrmrest Temple flight path
step << Horde
#completewith end
#requires WyrmFP
#label VenomFP
.goto Dragonblight,76.48,62.20
.fp Venomspite >> Get the Venomspite flight path
step << Horde
#completewith end
#requires VenomFP
#label VenomHS
.goto Dragonblight,76.87,63.13
.home >>Set your Hearth to Venomspite
step << Alliance
#completewith end
#label StarsFP
.goto Dragonblight,29.15,55.32
>>Travel to Stars' Rest
.fp Stars' Rest >> Get the Stars' Rest Flight Path
step << Alliance
.goto Dragonblight,28.84,56.16
>>Talk to Lanson
.turnin 12157 >>Turn in The Lost Courier
.accept 12171 >>Accept Of Traitors and Treason
step << Alliance
.goto Dragonblight,29.16,55.37
>>Talk to Palena
>>Accepting this quest will send you flying to Wintergarde Keep
.turnin 12171 >>Turn in Of Traitors and Treason
.accept 12174 >>Accept High Commander Halford Wyrmbane
step << Alliance
#completewith end
#label WinterFP
.goto Dragonblight,77.08,49.86
.fp Wintergarde Keep>>Get the Wintergarde Keep Flight Path
step << Alliance
#requires WinterFP
.goto Dragonblight,78.59,48.18
>>Talk to Halford Wyrmbane
.turnin 12174 >>Turn in High Commander Halford Wyrmbane
.accept 12235 >>Accept Naxxramas and the Fall of Wintergarde
step << Alliance
#completewith end
#label WinterHS
.goto Dragonblight,77.46,51.43
.home >>Set your Hearthstone to Wintergarde Keep
step << Alliance
#requires WinterHS
.goto Dragonblight,77.18,50.09
>>Go back up toward the Flight Master. talk to Urik
.turnin 12235 >>Turn in Naxxramas and the Fall of Wintergarde
.accept 12237 >>Accept Flight of the Wintergarde Defender
step << skip
#completewith next
.cast 48388 >> Use the Gryphon Whistle to mount a Wintergarde Gryphon. You can use this to fly in Wintergarde and The Carrion Fields
.use 37287
step << skip
#requires VenomHS
.loop 50,Dragonblight,87.90,41.21,87.00,42.19,86.45,40.12,85.51,41.24,83.78,41.98,84.14,40.72,84.49,37.06,87.64,35.43,87.90,41.21
.xp 73 >> AoE grind the Scarlets to 73
step << skip
#level 73
#completewith next
.zone Undercity >> Teleport to Undercity << Horde
.zone Stormwind City >> Teleport to Stormwind << Alliance
step << skip
#level 73
.goto Undercity,85.1,10.0 << Horde
.goto Stormwind City,49.2,87.7 << Alliance
.trainer >> Train your class spells
step << skip
#level 73
#label WinterHS1
#completewith next
.hs >> Hearth to Venomspite << Horde
.hs >> Hearth to Wintergarde Keep << Alliance
step << Alliance
#requires WinterHS1
#completewith next
.cast 48388 >> Use the Gryphon Whistle to mount a Wintergarde Gryphon. You can use this to fly in Wintergarde and The Carrion Fields
.use 37287
step
.loop 50,Dragonblight,87.90,41.21,87.00,42.19,86.45,40.12,85.51,41.24,83.78,41.98,84.14,40.72,84.49,37.06,87.64,35.43,87.90,41.21
.xp 74 >> AoE grind the Scarlets to 74
step
#label WinterHS2
#completewith next
.hs >> Hearth to Venomspite << Horde
.hs >> Hearth to Wintergarde Keep << Alliance
step
#completewith next
.goto Dragonblight,77.08,49.86 << Alliance
.fly Stars' Rest>>Fly to Stars' Rest << Alliance
.goto Dragonblight,76.48,62.20 << Horde
.fly Agmar >>Fly to Agmar's Hammer << Horde
.zoneskip Dalaran
.zoneskip SholazarBasin
step << Horde
.goto Dragonblight,38.05,46.22
>>Talk to Aethas
.accept 12791 >>Accept The Magical Kingdom of Dalaran
.zoneskip SholazarBasin
.zoneskip Dalaran
step << Horde
.goto Dragonblight,38.05,46.22
.zone Dalaran >>Ask Aethas for a teleport to Dalaran
.zoneskip SholazarBasin
.skipgossip
step << Alliance
.goto Dragonblight,29.0,55.5
>>Talk to Modera
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
.trainer >>Go inside the building. Train your Dalaran Portals
step
.goto Dalaran,54.94,46.19
.trainer >> Train your class spells
step
#completewith end
#label DalaranFP
.goto Dalaran,72.18,45.77
.fp Dalaran >> Get the Dalaran flight path
step
#requires DalaranFP
#completewith next
.goto Dalaran,68.54,42.07
>>Go to Krasus's Landing. Talk to Pentarus
.accept 12521 >>Accept Where in the World is Hemet Nesingwary?
step
#requires DalaranFP
.goto Dalaran,68.54,42.07
.zone SholazarBasin >>Ask Pentarus to take you to Sholazar Basin. This takes 50 seconds
.skipgossip
step
.goto SholazarBasin,39.70,58.65
>>Talk to Monte hanging from the tree
.turnin 12521 >>Turn in Where in the World is Hemet Nesingwary?
.accept 12489 >>Accept Welcome to Sholazar Basin
step
#completewith end
#label Nesingwary
.goto SholazarBasin,26.8,59.3,0,0
.home >> Set your Hearthstone to Nesingwary Base Camp
>>Buy food if needed
step
>>Travel to Nesingwary Base Camp. Talk to Hemet, Debaar, and Chad
.turnin 12489 >>Turn in Welcome to Sholazar Basin
.goto SholazarBasin,27.09,58.64
.accept 12524 >>Accept Venture Co. Misadventure
.goto SholazarBasin,27.25,59.90
.accept 12624 >>Accept It Could Be Anywhere!
.goto SholazarBasin,26.86,58.94
step
#requires Nesingwary
.goto SholazarBasin,25.35,58.48
>>Talk to Weslex
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
>>Talk to Engineer Helice to start her escort
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
.loop 75,SholazarBasin,36.21,51.02,37.13,45.50,32.88,45.11,31.67,48.72
.xp 75 >> AoE the Venture Co. to 75
step
.goto SholazarBasin,37.35,45.78,50,0
.goto SholazarBasin,33.31,45.31,50,0
.goto SholazarBasin,33.13,47.90
>>AoE the Venture Co. in Swindlegrin's Dig
.complete 12524,1 
step
#level 75
#completewith next
.zone Dalaran >> Teleport to Dalaran
step
#level 75
.goto Dalaran,54.94,46.19
.trainer >> Train your class spells
step
#completewith Debaar1
.hs >> Hearth to Nesingwary's Base Camp
step
>>Return to Nesingwary's Base Camp. Talk to Hemet and Debaar
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
>>Talk to Debaar
.turnin 12524 >>Turn in Venture Co. Misadventure
.accept 12525 >>Accept Wipe That Grin Off His Face
step
.goto SholazarBasin,26.86,58.94
>>Talk to Chad
.turnin 12624 >>Turn in It Could Be Anywhere!
.isQuestComplete 12624
step
.goto SholazarBasin,25.35,58.48
>>Talk to Weslex
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
#label VentureCo2
.loop 75,SholazarBasin,36.21,51.02,37.13,45.50,32.88,45.11,31.67,48.72
.xp 76 >> AoE the Venture Co. to 76
step
.goto SholazarBasin,33.2,45.7,50,0
.goto SholazarBasin,37.03,46.72
>>Loot the various spare parts found around Swindlegrin's Dig
.complete 12523,1 
step
>>Kill any mob in Sholazar for the Golden Engagement Ring. Don't focus on this quest at all
.complete 12624,1 
step
#level 76
#completewith next
.zone Dalaran >> Teleport to Dalaran
step
#level 76
.goto Dalaran,54.94,46.19
.trainer >> Train your class spells
step
#completewith Debaar1
.hs >> Hearth to Nesingwary's Base Camp
step
#completewith end
#label NesFP
.goto SholazarBasin,25.35,58.48
>>Talk to Weslex, then talk to the Flying Machine and Calvert
.turnin 12523 >>Turn in Have a Part, Give a Part
.fp Nesingwary Base Camp >> Get the Nesingwary Base Camp flight path
.goto SholazarBasin,25.27,58.45


step
#requires NesFP
>>Talk to Debaar, then Drostan
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
>>Talk to Chad
.turnin 12624 >>Turn in It Could Be Anywhere!
step
.loop 75,SholazarBasin,36.21,51.02,37.13,45.50,32.88,45.11,31.67,48.72
.xp 77 >> AoE the Venture Co. to 77
step
#completewith next
.zone Dalaran >> Teleport to Dalaran
step
#level 77
.goto Dalaran,54.94,46.19
.trainer >> Train your class spells
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
#completewith next
.zone Dalaran >> Teleport to Dalaran
step
#level 78
.goto Dalaran,54.94,46.19
.trainer >> Train your class spells
step
#completewith next
.goto IcecrownGlacier,59.0,73.8
.zone Icecrown >> Fly to Icecrown
step
.goto IcecrownGlacier,59.0,73.8
.xp 79 >> AoE the Undead to 79
step
#level 79
#completewith next
.zone Dalaran >> Teleport to Dalaran
step
#level 79
.goto Dalaran,54.94,46.19
.trainer >> Train your class spells
step
#completewith next
.goto IcecrownGlacier,59.0,73.8
.zone Icecrown >> Fly to Icecrown
step
.goto IcecrownGlacier,59.0,73.8
.xp 80 >> AoE the Undead to 80
step
+Congratulations on finishing the RestedXP 68-80 AoE leveling guide! Thank you for using RestedXP.
.link https://discord.com/invite/ApNgbdQNQy >> As this is Beta, the guide may have had some bugs. If you encountered any while playing through, report them here!
]])
RXPGuides.RegisterGuide([[
#version 9
#wotlk
#tbc
#group RestedXP Wrath Preparation
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
#version 9
#wotlk
#tbc
#group RestedXP Wrath Preparation
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
#version 9
#wotlk
#tbc
#group RestedXP Wrath Preparation
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
#version 9
#wotlk
#tbc
#group RestedXP Wrath Preparation
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
#version 9
#wotlk
#tbc
#group RestedXP Wrath Preparation
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
.unitscan Flanis
.skipgossip
.collect 30658,1,10583,1
step << Alliance
#requires elementald2
.goto Shadowmoon Valley,37.0,38.0
.use 30672 >> Head to the lower level then use the Elemental Displacer to disrupt the ritual where Summoner Skartax is
.unitscan Summnoner Skartax
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
.unitscan Summnoner Skartax
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
#version 9
#wotlk
#tbc
#group RestedXP Wrath Preparation
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
#version 9
#wotlk
#tbc
#group RestedXP Wrath Preparation
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
.unitscan Soridomi
.turnin 10445 >> Turn in The Vials of Eternity
step
.goto Tanaris,58.3,54.8
.reputation 989,friendly,<0,1
>> Arazmodu and Soridomi patrol around the room counter clockwise, run around until you find them. Accept the ring quest of your choice. This is not automated to prevent picking the wrong ring. Skip this step if none of the Friendly Ring quests are available.
.unitscan Soridomi
.dailyturnin 10462,10461,10460,10463 >> Turn in A Ring Pledge
step
.goto Tanaris,58.3,54.8
.reputation 989,honored,<0,1
>> Arazmodu and Soridomi patrol around the room counter clockwise, run around until you find them.
.unitscan Soridomi
.daily 10464,10465,10466,10467 >> Accept a Vow Ring Quest
.dailyturnin 10464,10465,10466,10467 >> Turn in a Vow Ring Quest
step
.goto Tanaris,58.3,54.8
.reputation 989,revered,<0,1
>> Arazmodu and Soridomi patrol around the room counter clockwise, run around until you find them.
.unitscan Soridomi
.daily 10468,10469,10470,10471 >> Accept an Oath Ring Quest
.dailyturnin 10468,10469,10470,10471 >> Turn in an Oath Ring Quest
step
.goto Tanaris,58.3,54.8
.reputation 989,exalted,<0,1
>> Arazmodu and Soridomi patrol around the room counter clockwise, run around until you find them.
.unitscan Soridomi
.daily 10472,10473,10474,10475 >> Accept an Covenant Ring Quest
.dailyturnin 10472,10473,10474,10475 >> Turn in an Covenant Ring Quest
step
.isOnQuest 10297
.goto Tanaris,57.6,62.7
>> Enter The Black Morass and turn in the quest
.turnin 10297 >> Turn in The Opening of the Dark Portal
]]);