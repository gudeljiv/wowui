
RXPGuides.RegisterGuide("RestedXP Horde 22-30",[[
#classic
<< Horde
#name 22-24 Hillsbrad
#next 24-26 Southern Barrens/Stonetalon

step << Shaman
    .goto Orgrimmar,38.6,36.0
	.trainer >> Go and train your class spells
step << Hunter
    .goto Orgrimmar,66.1,18.5
	.trainer >> Go and train your class spells
step << Hunter
    .goto Orgrimmar,66.3,14.8
	.trainer >> Go and train your pet spells
step << Warrior
    .goto Orgrimmar,79.7,31.4
	.trainer >> Go and train your class spells
step << Rogue
    .goto Orgrimmar,44.0,54.6
	.trainer >> Go and train your class spells
	>>Make sure you have Rupture and Ambush trained. You need a Dagger too
step << Warlock
    .goto Orgrimmar,48.0,46.0
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,47.5,46.7
	.vendor >> Buy your pet spell upgrades if you got the money.
step << Mage
	#som
    .goto Orgrimmar,38.8,85.6
	.trainer >> Go and train your class spells
	>> Make sure to save at least 35 silver after training
step << Mage
	#era
    .goto Orgrimmar,38.8,85.6
	.trainer >> Go and train your class spells
	>> Make sure to save at least 55 silver after training
step << Mage
	#era
    .goto Orgrimmar,38.69,85.39
	.trainer >> Go upstairs. Train Portal: Orgrimmar
step << Priest
    .goto Orgrimmar,35.6,87.8
	.trainer >> Go and train your class spells
step << Priest/Warlock/Mage
    .goto Orgrimmar,44.4,48.6
    .collect 5211,1 >> Buy Dusk Wand if you got the money for it.
step << Warlock
    .goto Orgrimmar,48.2,45.3
    .turnin 1512 >>Turn in Love's Gift
    .accept 1513 >>Accept The Binding
step << Warlock
    >>Summon the Succubus at the circle in the building. Kill her
	.goto Orgrimmar,49.4,50.0
    .complete 1513,1 --Summoned Succubus (1)
step << Warlock
    .goto Orgrimmar,48.2,45.3
    .turnin 1513 >>Turn in The Binding
step << Rogue
    .goto Durotar,43.89,1.01
    .accept 2460 >>Accept The Shattered Salute
step << Rogue
    >>After Shenthul does his salute, type /Salute while targeting him.
    .complete 2460,1 --Shattered Salute Performed (1)
step << Rogue
    .turnin 2460 >>Turn in The Shattered Salute
    .accept 2458 >>Accept Deep Cover
step << Rogue
	#completewith next
    .goto Orgrimmar,11.5,67.0,50 >>Run to the west entrance of Orgrimmar. Make sure you have a Dagger so you can Ambush later
step << Rogue
    .goto Durotar,20.26,17.25 >>Use your Flare Gun TWICE, target Taskmaster Fizzule and type /Salute to turn in your quest.
    .turnin 2458 >>Turn in Deep Cover
step << Rogue
    .goto Durotar,19.52,16.25   
   .accept 2478 >>Accept Mission: Possible But Not Probable
step << Rogue
    #sticky
    #completewith roguetowerq
    +Each mob here will take increased damage to certain abilities.
    >>Ambush the Drones
    >>Rupture the Patrollers (1 combo point)
    >>Eviscerate the Lookouts one time (1 combo point)
step << Rogue
    .goto Durotar,18.31,16.95
    >>Pickpocket Foreman Silixiz to loot his Tower Key
    .complete 2478,5 --Silixiz's Tower Key (1)
step << Rogue
    #label roguetowerq
    .goto Durotar,18.34,16.55 >>Run into the Rogue Tower
    .complete 2478,1 --Mutated Venture Co. Drone (2)
    .complete 2478,3 --Venture Co. Patroller (2)
    .complete 2478,2 --Venture Co. Lookout (2)
step << Rogue
    .goto The Barrens,54.77,5.57
    >>At the top of the tower you'll find Gallywix. Ambush him to reduce his HP to half. Use Gouge to restore energy and Evasion as needed.
	>>Remember to use Potions if you have them
    .complete 2478,4 --Gallywix's Head (1)
step << Rogue
    .goto The Barrens,54.77,5.57
    >>Use your lock picking to open Gallywix's Lockbox & loot the mixture. 
    .complete 2478,6 --Cache of Zanzil's Altered Mixture (1)    
step << Rogue
    .goto Orgrimmar,43.15,53.61
    >>Return back to Orgrimmar to turn in your quest.
    .turnin 2478 >>Turn in Mission: Possible But Not Probable
    .accept 2479 >>Accept Hinott's Assistance    
step << Rogue   
    .goto Orgrimmar,42.20,49.60
    >>Purchase 10 or more of each Dust of Decay and an Empty Vial from Rekkul. These are for your poisons soon.
    .vendor 3334
step << Warlock
    .isQuestComplete 6284
    #sticky
	#completewith next
    .bankdeposit 16192 >> Deposit the following items in your bank: 
    >> Besseleth's Fang
step
    #sticky
    #completewith next
	+Go to the Zeppelin tower. Take the zeppelin to Tirisfal
	.goto Durotar,50.8,13.8
step
	.zone Tirisfal Glades >>Arrive in Tirisfal Glades
step
    .goto Tirisfal Glades,61.87,65.02,40 >> Run to Undercity
step
    .goto Tirisfal Glades,61.81,74.42,30 >> Run to the Elevator room
step << !Undead !Rogue
    >>Take one of the elevators down
    .goto Undercity,63.25,48.56
    .fp Undercity >> Get the Undercity Flight Path
step << Mage
    .goto Undercity,84.19,15.55
	.trainer >> Go to the Portal Trainer on top of the Ziggurat. Train Portal: Undercity
step << Mage
    .goto Undercity,82.79,15.82
    .vendor >> Go to Hannah. Buy a Rune of Teleportation (or more if you want)
    .collect 17031,1 --Rune of Teleportation (1)
step << Undead/Rogue
     #completewith next
    >>Take one of the elevators down
    .goto Undercity,63.25,48.56
    .fly The Sepulcher >> Fly to The Sepulcher
step << !Undead !Rogue
    .goto Undercity,46.16,43.97,50,0
    .goto Undercity,41.04,33.26,50,0
    .goto Undercity,23.86,35.90,50,0
    .goto Undercity,15.06,32.86,50 >> Exit Undercity via the Sewers
step << !Undead !Rogue
    .goto Silverpine Forest,67.57,5.00
	.zone Silverpine Forest >> Head south-west to Silverpine
step << !Undead !Rogue
    .goto Silverpine Forest,45.60,42.60
    .fp Sepulcher >>Run to The Sepulcher. Get The Sepulcher Flight Path
step
	>>Click the Tombstone
    .goto Silverpine Forest,44.10,42.60
    .turnin 264 >> Turn in Until Death Do Us Part
step
    .goto Silverpine Forest,43.06,41.92
    .turnin 3301 >> Turn in Mura Runetotem
step
    .goto Silverpine Forest,42.90,40.80
    .accept 493 >> Accept Journey to Hillsbrad Foothills
step
    .goto Hillsbrad Foothills,20.80,47.40
    .accept 494 >> Accept Time To Strike
step
    .goto Hillsbrad Foothills,60.10,18.60
    .fp Tarren Mill>> Get the Tarren Mill Flight Path
step << Rogue
     .goto Hillsbrad Foothills,61.55,19.19
    .turnin 2479 >>Turn in Hinott's Assistance
    .accept 2480 >>Accept Hinott's Assistance
step << Rogue
    >>Wait for Serge to complete the cure
    .complete 2480,1 --Cure Completed (1)
step << Rogue  
    .goto Hillsbrad Foothills,61.50,19.20 
    .turnin 2480 >>Turn in Hinott's Assistance 
step << Shaman
	.goto Hillsbrad Foothills,62.2,20.8
    >>Fill the Waterskin at the well
    .complete 1536,1 --Filled Red Waterskin (1)
step
	#era
    .goto Hillsbrad Foothills,61.50,19.20
    .turnin 493 >> Turn in Journey to Hillsbrad Foothills
    .turnin 1065 >> Turn in Journey to Tarren Mill
    .accept 1066 >> Accept Blood of Innocents
    .accept 496 >> Accept Elixir of Suffering
    .accept 501 >> Accept Elixir of Pain
step
	#som
    .goto Hillsbrad Foothills,61.50,19.20
    .turnin 493 >> Turn in Journey to Hillsbrad Foothills
    .turnin 1065 >> Turn in Journey to Tarren Mill
    .accept 1066 >> Accept Blood of Innocents
step
    .goto Hillsbrad Foothills,62.50,19.70
     >> Click the Wanted poster just outside of the Inn
    .accept 567 >> Accept Dangerous!
step
    .goto Hillsbrad Foothills,62.20,20.50
    .turnin 494 >> Turn in Time To Strike
    .accept 527 >> Accept Battle of Hillsbrad
step
    .goto Hillsbrad Foothills,62.60,20.70
    >>Click the Wanted poster next to Melisara
    .accept 549 >> Accept WANTED: Syndicate Personnel
step
    .goto Hillsbrad Foothills,63.20,20.70
    .accept 498 >> Accept The Rescue
step << Hunter
	#completewith next
	.goto Hillsbrad Foothills,62.56,19.91
	.vendor >> Buy arrows until your quiver is full
step
    .goto Hillsbrad Foothills,62.79,19.05
	.vendor 2388 >> Go inside the Inn. Vendor trash, and buy Food/Water from Shay
step << Shaman/Warrior
    .goto Hillsbrad Foothills,60.4,26.2
    .vendor >> Go buy Merciless Axe from the vendor if you have enough money. It's not always in the shop.
    .collect 12249,1
step << Rogue
    .goto Hillsbrad Foothills,60.4,26.2
    .vendor >> Go buy Broad Bladed Knife from the vendor if you have enough money. It's not always in the shop.
    .collect 12247,1
step
	#era
	#completewith next
	>>Kill Bears and Spiders en route to the syndicates
	.complete 496,1 --Collect Gray Bear Tongue (x10)
    .complete 496,2 --Collect Creeper Ichor (x1) 
step
	#era
	    .goto Hillsbrad Foothills,78.46,43.06,200 >> Run to Dornholde Keep
step
    #sticky
	#label syndicateq
	>>Kill Syndicates in the area
	.goto Hillsbrad Foothills,77.8,44.1,0
    .complete 549,1 --Kill Syndicate Rogue (x10)
	.complete 549,2 --Kill Syndicate Watchman (x10)
step
    #sticky
    #label shadowmage
    .goto Hillsbrad Foothills,80.61,45.40,0
    >>Kill Shadow Mages. Loot them for Vials of Innocent Blood
	.complete 1066,1 --Collect Vial of Innocent Blood (x5)
step << !Rogue !Hunter !Shaman
    #completewith next
	.goto Hillsbrad Foothills,80.1,38.9
    .vendor >> vendor trash, repair if needed
step << Rogue/Hunter/Shaman
	#completewith Drull
	.goto Hillsbrad Foothills,80.1,38.9
    .vendor >> Vendor & repair if needed. If Stalking Pants and/or Wolf Bracers are in the shop, buy them
step
	.goto Hillsbrad Foothills,79.8,39.3
	>>Kill Jailor Marlgen. Loot him for his Burnished Gold Key
    .collect 3499,1 
step
    >>Click the ball
	.goto Hillsbrad Foothills,79.8,39.6
    .complete 498,2 --Rescue Tog'thar (1)
step
    >>Kill Jailor Eston. Loot him for his Dull Iron Key
	.goto Hillsbrad Foothills,79.4,41.6
	.collect 3467,1
step
	#label Drull
    >>Click the ball
	.goto Hillsbrad Foothills,75.3,41.5
    .complete 498,1 --Rescue Drull (1)
step
	#som
	#requires shadowmage
step
	#era
        #requires shadowmage
	#completewith next
	>>Kill Bears. Loot them for their Tongues
	.complete 496,1 --Collect Gray Bear Tongue (x10)
step
	#era
        #requires syndicateq
	>>Kill Spiders. Loot them until Creeper Ichor drops
	.goto Hillsbrad Foothills,63.5,33.0,100,0
    .goto Hillsbrad Foothills,57.9,34.5,100,0
    .goto Hillsbrad Foothills,57.2,22.1,100,0
	.goto Hillsbrad Foothills,63.5,33.0,100,0
    .goto Hillsbrad Foothills,57.9,34.5,100,0
    .goto Hillsbrad Foothills,57.2,22.1,100,0
	.goto Hillsbrad Foothills,63.5,33.0
    .complete 496,2 --Collect Creeper Ichor (x1) 
step
	#requires syndicateq
    .goto Hillsbrad Foothills,61.5,19.1
    .turnin 1066 >> Turn in Blood of Innocents
step
    .goto Hillsbrad Foothills,62.38,20.52
	.turnin 549 >> Turn in WANTED: Syndicate Personnel
step
    .goto Hillsbrad Foothills,63.2,20.7
    .turnin 498 >> Turn in The Rescue
step << Hunter
	#completewith next
	.goto Hillsbrad Foothills,62.56,19.91
	.vendor >> Buy arrows until your quiver is full
step
    .goto Hillsbrad Foothills,62.79,19.05
	.vendor 2388 >> Go inside the Inn. Vendor trash, and buy Food/Water from Shay
step
	#era
	#completewith next
    >>Kill Bears and Mountain Lions en route to the Fields. Loot them for Tongues and Blood
	.complete 496,1 --Collect Gray Bear Tongue (x10)
	.complete 501,1 --Collect Mountain Lion Blood (x10)
step
	#som
	#completewith next
    >>Kill Mountain Lions en route to the Fields. Loot them for their Blood
	.complete 501,1 --Collect Mountain Lion Blood (x10)
step
    .goto Hillsbrad Foothills,36.02,39.19,150 >> Run to the Hillsbrad Fields
step
	#sticky
	#label Farmers
	>>Kill Farmers in and around the fields
    .complete 527,1 --Kill Hillsbrad Farmer (x6)
	.complete 527,2 --Kill Hillsbrad Farmhand (x6)
step
    #sticky
    #label Getz
    >>Kill Farmer Getz, he can be in the House, Barn, or Field
    .goto Hillsbrad Foothills,36.7,39.4,60,0
    .goto Hillsbrad Foothills,35.2,37.6,45,0
    .goto Hillsbrad Foothills,35.1,41.0,60,0
    .goto Hillsbrad Foothills,36.7,39.4,60,0
    .goto Hillsbrad Foothills,35.2,37.6,45,0
    .goto Hillsbrad Foothills,35.1,41.0,60,0
    .goto Hillsbrad Foothills,36.7,39.4
    .complete 527,4 --Farmer Getz (1)
step
    >>Kill Farmer Ray. He can be in the 1st or 2nd floor of the house. He can also be outside under the grapevine (hut)
    .goto Hillsbrad Foothills,33.7,35.5,20,0
    .goto Hillsbrad Foothills,33.2,34.8,20,0
    .goto Hillsbrad Foothills,33.7,35.5,20,0
    .goto Hillsbrad Foothills,33.2,34.8,20,0
    .goto Hillsbrad Foothills,33.7,35.5,20,0
    .goto Hillsbrad Foothills,33.2,34.8,20,0
    .goto Hillsbrad Foothills,33.7,35.5,20,0
    .goto Hillsbrad Foothills,33.2,34.8,20,0
    .goto Hillsbrad Foothills,33.7,35.5,20,0
    .goto Hillsbrad Foothills,33.2,34.8,20,0
    .goto Hillsbrad Foothills,33.2,34.8
    .complete 527,3 --Farmer Ray (1)
step
	#requires Getz
step
	#som
	#requires Farmers
	#completewith next
    >>Kill Mountain Lions. Loot them for their Blood
	.complete 501,1 --Collect Mountain Lion Blood (x10)
step
	#era
	#requires Farmers
	#completewith next
    >>Kill Bears and Mountain Lions. Loot them for Tongues and Blood
	.complete 496,1 --Collect Gray Bear Tongue (x10)
	.complete 501,1 --Collect Mountain Lion Blood (x10)
--N Claw rank 3?
step
	#requires Farmers
	>>Return to Tarren Mill
    .goto Hillsbrad Foothills,62.3,20.2
    .turnin 527 >> Turn in Battle of Hillsbrad
step
    .goto Hillsbrad Foothills,62.5,20.3
    .accept 528 >> Accept Battle of Hillsbrad
    .accept 546 >> Accept Souvenirs of Death
step
	#completewith next
	#era
    >>Kill Bears and Mountain Lions. Loot them for Tongues and Blood
	.goto Hillsbrad Foothills,54.9,29.8,90,0
    .goto Hillsbrad Foothills,50.5,37.7,90,0
    .goto Hillsbrad Foothills,43.7,39.9,90,0
    .goto Hillsbrad Foothills,38.4,34.9,90,0
    .goto Hillsbrad Foothills,39.1,45.4,90,0
	.goto Hillsbrad Foothills,54.9,29.8
	.complete 496,1 --Collect Gray Bear Tongue (x10)
	.complete 501,1 --Collect Mountain Lion Blood (x10)
step
	#completewith next
	#som
    >>Kill Mountain Lions. Loot them for their Blood
	.goto Hillsbrad Foothills,54.9,29.8,90,0
    .goto Hillsbrad Foothills,50.5,37.7,90,0
    .goto Hillsbrad Foothills,43.7,39.9,90,0
    .goto Hillsbrad Foothills,38.4,34.9,90,0
    .goto Hillsbrad Foothills,39.1,45.4,90,0
	.goto Hillsbrad Foothills,54.9,29.8
	.complete 501,1 --Collect Mountain Lion Blood (x10)
step
    .goto Hillsbrad Foothills,36.02,39.19,150 >> Run to the Hillsbrad Fields
step
    #sticky
    #label Wilkes
    >>Kill Citizen Wilkes. He patrols every road in the town
	.complete 567,2 --Kill Citizen Wilkes (x1)
step
    #sticky
    #label Kalaba
    >>Kill Farmer Kalaba. She patrols the field of Peasants
	.goto Hillsbrad Foothills,35.2,46.5
    .complete 567,4 --Kill Farmer Kalaba (x1)
step
    #label Peasants
	>>Kill Peasants in and around the field
	.goto Hillsbrad Foothills,35.2,46.5
	.complete 528,1 --Kill Hillsbrad Peasant (x15)
step
    #requires Wilkes
step
    #requires Kalaba
	#era
    >>Finish killing Bears and Mountain Lions. Loot them for Tongues and Blood
    .goto Hillsbrad Foothills,39.1,45.4,90,0
    .goto Hillsbrad Foothills,38.4,34.9,90,0
    .goto Hillsbrad Foothills,43.7,39.9,90,0
    .goto Hillsbrad Foothills,50.5,37.7,90,0
	.goto Hillsbrad Foothills,54.9,29.8,90,0
    .goto Hillsbrad Foothills,39.1,45.4
	.complete 496,1 --Collect Gray Bear Tongue (x10)
	.complete 501,1 --Collect Mountain Lion Blood (x10)
step
    #requires Kalaba
	#som
    >>Finish killing Mountain Lions. Loot them for their Blood
    .goto Hillsbrad Foothills,39.1,45.4,90,0
    .goto Hillsbrad Foothills,38.4,34.9,90,0
    .goto Hillsbrad Foothills,43.7,39.9,90,0
    .goto Hillsbrad Foothills,50.5,37.7,90,0
	.goto Hillsbrad Foothills,54.9,29.8,90,0
    .goto Hillsbrad Foothills,39.1,45.4
	.complete 501,1 --Collect Mountain Lion Blood (x10)
step
	>>Run back to Tarren Mill
	.goto Hillsbrad Foothills,62.4,20.3
    .turnin 528 >> Turn in Battle of Hillsbrad
    .accept 529 >> Accept Battle of Hillsbrad
step
	#era
    .goto Hillsbrad Foothills,61.5,19.1
    .turnin 496 >> Turn in Elixir of Suffering
    .accept 499 >> Accept Elixir of Suffering
    .turnin 501 >> Turn in Elixir of Pain
    .accept 502 >> Accept Elixir of Pain
    .turnin 499 >> Turn in Elixir of Suffering
    .accept 1067 >> Accept Return to Thunder Bluff
step
	#som
    .turnin 501 >> Turn in Elixir of Pain
    .accept 502 >> Accept Elixir of Pain
    .accept 1067 >> Accept Return to Thunder Bluff
step << Shaman/Warrior
    .goto Hillsbrad Foothills,60.4,26.2
    .vendor >> If you didn't get the Merciless Axe the first time, go buy it in the shop now.
    .collect 12249,1
step << Rogue
    .goto Hillsbrad Foothills,60.4,26.2
    .vendor >> If you didn't get the Broad Bladed Knife the first time, go buy it in the shop now.
    .collect 12247,1
step
    #sticky
    #completewith next
    +While turning in Elixir of Pain, you can kill Stanley after for a bunch of extra XP
step
	.goto Hillsbrad Foothills,32.6,35.6
    .turnin 502 >> Turn in Elixir of Pain
step
    #sticky
    #label Crate
	>>Run back to the Hillsbrad Fields
	>>Collect the crate inside the Blacksmith
	.goto Hillsbrad Foothills,32.0,45.4
    .complete 529,3 --Collect Shipment of Iron (x1)
step
	>>Kill Blacksmith Verringtan and his Apprentices
	.goto Hillsbrad Foothills,32.1,45.3
	.complete 529,1 --Kill Blacksmith Verringtan (x1)
    .complete 529,2 --Kill Hillsbrad Apprentice Blacksmith (x4)
step
	#requires Crate
    .hs >> Hearth to Thunder Bluff
	>> Buy food/water if needed
]])

RXPGuides.RegisterGuide("RestedXP Horde 22-30",[[
#classic
<< Horde

#name 24-26 Southern Barrens/Stonetalon
#next 26-28 Ashenvale

step << Shaman/Warrior
    .goto Thunder Bluff,54.0,57.3
    .vendor >> Go buy Merciless Axe if u didn't get it in Hillsbrad
    .collect 12249,1
step << Hunter
    .goto Thunder Bluff,59.1,86.9
	.trainer >> Go and train your class spells
step << Hunter
    .goto Thunder Bluff,54.1,83.9
	.trainer >> Go and train your pet spells
step << Warrior
    .goto Thunder Bluff,57.6,85.5
	.trainer >> Go and train your class spells
step << Druid
    .goto Thunder Bluff,77.0,29.9
	.trainer >> Go and train your class spells
step << Shaman
    .goto Thunder Bluff,22.8,21.0
	.trainer >> Go and train your class spells
step << Priest
    .goto Thunder Bluff,24.6,22.6
	.trainer >> Go and train your class spells
step << Mage
    .goto Thunder Bluff,25.2,20.9
	.trainer >> Go and train your class spells
step <<  Hunter
    #completewith next
     .vendor >> Buy a LOT of level 25 arrows (1200+). Remember to equip them at level 25
step << Hunter
    .goto Thunder Bluff,46.9,45.7
    >> Go and buy the Sturdy Recurve if it's in the shop. If it's not, skip this step
    .collect 11306,1
step << Warlock
    .isOnQuest 6284
    >> Withdraw the following items from your bank: 
    >>  Besseleth's Fang
    .bankwithdraw 16192
step << Rogue
 	>> If you are able to use the AH or able to get these items somehow prepare them now.
	.collect 5996,1
	.collect 6050,1
	.collect 1710,1
step
	.goto Thunder Bluff,22.90,21.00
    .turnin 1067 >> Turn in Return to Thunder Bluff
    .accept 1086 >> Accept The Flying Machine Airport
step
    .goto Thunder Bluff,54.70,51.30
    .accept 1195 >> Accept The Sacred Flame
step
    .goto Thunder Bluff,46.8,50.0
    .fly Camp Taurajo >> Fly to Camp Taurajo
step
    .goto The Barrens,45.6,59.0
    .home >>Set your Hearthstone to Camp Taurajo
step
	#completewith next
    .goto The Barrens,45.60,59.00
	.turnin 5046 >> Turn in Razorhide for the Thorns buff if you have 4 Bloodshards
step << Warrior
    >>In the building
	.goto The Barrens,44.7,59.4
	.turnin 1823 >>Turn in Speak with Ruga
    .accept 1824 >>Accept Trial at the Field of Giants
step
    .goto The Barrens,44.6,59.2
    .accept 879 >> Accept Betrayal from Within
step
	#sticky
	#label Owatanka2
	#completewith next
	.goto The Barrens,44.2,62.1,0
	.goto The Barrens,49.2,62.6,0
	.goto The Barrens,49.6,60.0,0
	>>Search for Owatanka (Blue Thunder Lizard) around this area. If you find him, loot his Tailspike and start the quest. If you can't find him, skip this quest
	.collect 5102,1,884 --Collect Owatanka's Tailspike
	.accept 884 >>Accept Owatanka
step << Warrior
    >>Kill Silithid mobs in the area. Loot them for Twitching Antennae. Be quick as they have a 15m duration
	.goto The Barrens,48.1,70.3
	.complete 1824,1 --Twitching Antenna (5)
step << Warrior
    >>In the building
	.goto The Barrens,44.7,59.4
    .turnin 1824 >>Turn in Trial at the Field of Giants
    .accept 1825 >>Accept Speak with Thun'grim
step
	#completewith next
	>>Keep an eye out for the Silithid Harvester. If you see it, kill it and loot it for its head
	.collect 5138,1,897 --Harvester's Head
	.accept 897 >> Accept The Harvester
	.unitscan Silithid Harvester
step 
	>>Loot the big mounds found near the silithids
    .goto The Barrens,44.97,69.74,90,0
    .goto The Barrens,42.81,69.88,90,0
    .goto The Barrens,43.07,71.67,90,0
    .goto The Barrens,44.93,72.57,90,0
    .goto The Barrens,48.79,70.04
	.complete 868,1 --Silithid Egg (12)
step << Shaman
    .goto The Barrens,43.4,77.4
    .turnin 1534 >>Turn in Call of Water
    .accept 220 >>Accept Call of Water
step
	#sticky
	#label Washte
	#completewith next
	.goto The Barrens,44.7,74.7,0
	.goto The Barrens,44.7,77.8,0
	.goto The Barrens,47.6,79.8,0
	>>Search for Washte Pawne (Red Wind Serpent) around the area. He drops a quest. Accept Gann's Reclamation if you see him en route
	.collect 5103,1 --Collect Washte Pawne's Feather
	.accept 885 >>Accept Washte Pawne
step
    .goto The Barrens,46.0,76.2,90,0
	.goto The Barrens,46.0,81.2,90,0
    .goto The Barrens,46.0,76.2
	.accept 843 >> Accept Gann's Reclamation
	.unitscan Gann Stonespire
step
	#sticky
	#label Washte
	#completewith next
	.goto The Barrens,44.7,74.7,0
	>>Search for Washte Pawne (Red Wind Serpent) around the area. He drops a quest. If you can't find him in this last spot, skip the quest
	.collect 5103,1 --Collect Washte Pawne's Feather
	.accept 885 >>Accept Washte Pawne
step << Shaman
	.goto The Barrens,43.4,77.4
	.turnin 1536 >>Turn in Call of Water
	.accept 1534 >>Accept Call of Water
step
    #sticky
    #label Weapons
    >>Kill mobs in the area for Weapons of Choice. Wand from Seers, Backstabber from Stalkers or Pathfinders, and Shield from Warfrenzies
    .collect 5092,1 --Collect Charred Razormane Wand (x1) 
	.collect 5093,1 --Collect Razormane Backstabber (x1)
    .collect 5094,1 --Collect Razormane War Shield (x1)
step
	.goto The Barrens,43.4,78.8
    >> Kuz can be found patrolling all around the ridge
	.unitscan Kuz
    .complete 879,1 --Collect Kuz's Skull (x1)
step
    .goto The Barrens,40.6,80.7 
	>> In the building up from the Ramp
	.unitscan Lok
    .complete 879,3 --Collect Lok's Skull (x1)
step
    .goto The Barrens,43.8,83.5 
	>> Around the southern part of the Ridge
    .complete 879,2 --Collect Nak's Skull (x1)
	.unitscan Nak
step
    #requires Weapons
    #sticky
    #label Baeldun
	>>Kill Dwarves in the area for Gann's Reclamation
    .complete 843,1 --Kill Bael'dun Excavator (x15)
    .complete 843,2 --Kill Bael'dun Foreman (x5)
step
    #requires Weapons
	>>Kill Prospector Khazgorm. Loot him for his Journal
	.goto The Barrens,48.3,86.2
	.complete 843,3 --Collect Khazgorm's Journal (x1)
step
	#requires Baeldun
	.goto The Barrens,46.0,81.2,90,0
	.goto The Barrens,46.0,76.2
	.turnin 843 >> Turn in Gann's Reclamation
    .accept 846 >> Accept Revenge of Gann
	.unitscan Gann Stonespire
step
    >>Kill mobs and loot them for Revenge of Gann
	.goto The Barrens,49.4,84.3
    .complete 846,1 --Collect Nitroglycerin (x6)
    .complete 846,2 --Collect Wood Pulp (x6)
    .complete 846,3 --Collect Sodium Nitrate (x6)
step
	.goto The Barrens,46.0,81.2,90,0
	.goto The Barrens,46.0,76.2
	.turnin 846 >> Turn in Revenge of Gann
    .accept 849 >> Accept Revenge of Gann
	.unitscan Gann Stonespire
step
    >>Right click the Flying Machine at the top of the launch pad
	.goto The Barrens,47.0,85.6
    .complete 849,1 --Collect Bael Modan Flying Machine destroyed (x1)
step
	.goto The Barrens,46.0,81.2,90,0
	.goto The Barrens,46.0,76.2,90,0
	.goto The Barrens,46.0,81.2,90,0
	.goto The Barrens,46.0,76.2,90,0
	.turnin 849 >> Turn in Revenge of Gann
step 
    .goto Dustwallow Marsh,29.35,42.92
    .zone Dustwallow Marsh >> Head to Dustwallow 
step << Warrior/Shaman
    .goto Dustwallow Marsh,36.20,31.60
	>>Run to Brackenwall Village. Try to stick to the roads
	>>Be VERY careful when running through here due to the high level mobs in the area. Don't try to attack them if you pull them, just keep running
	>>Be VERY careful when running through here due to the high level mobs in the area. Don't try to attack them if you pull them, just stay in Ghost Wolf and keep running
	.vendor 4884 >> Buy the Big Stick from Zulrg if it's in the shop.
step
    .goto Dustwallow Marsh,35.60,31.80
	>>Run to Brackenwall Village. Try to stick to the roads << !Shaman !Warrior
	.fp Brackenwall >> Get the Brackenwall Village Flight Path
    .fly Ratchet >> Fly to Ratchet
step
    .goto The Barrens,62.29,39.03
    .accept 891 >>Accept The Guns of Northwatch
	>>IF YOUR HEARTHSTONE IS UP, SKIP THIS QUEST
step
    .goto The Barrens,65.80,43.90
    .turnin 874 >> Turn in Mahren Skyseer
    .accept 873 >> Accept Isha Awak
step
	.goto The Barrens,65.6,47.1,100,0
        .goto The Barrens,63.3,54.2,100,0
	.goto The Barrens,65.6,47.1,100,0
        .goto The Barrens,63.3,54.2
    >>Search up and down the coast in the water for Isha Awak (Red Threshadon). Kill & loot it for its heart
    .complete 873,1 --Heart of Isha Awak (1)
	.unitscan Isha Awak
step
	.isOnQuest 891
	#sticky
	>> If your hearth isn't up after killing Isha Awak, do the Northwatch quests. Otherwise, abandon The Guns of Northwatch
    .complete 891,4 --Theramore Medal (10)
step
	.isOnQuest 891
	>>Go upstairs in the tower. Kill Cannoneer Smythe
    .goto The Barrens,63.17,56.58
    .complete 891,3 --Cannoneer Smythe (1)
step
	.isOnQuest 891
	>>Go upstairs in the tower. Kill Cannoneer Whessan
    .goto The Barrens,60.43,54.78
    .complete 891,2 --Cannoneer Whessan (1)
step
	.isOnQuest 891
	>>Go upstairs in the tower. Kill Captain Fairmount
	>>Do NOT accept the quest downstairs
    .goto The Barrens,61.85,54.65
    .complete 891,1 --Captain Fairmount (1)
step
	.isOnQuest 891
    .goto The Barrens,61.97,54.96
    .accept 898 >>Accept Free From the Hold
step
	.isOnQuest 891
	>>Escort Gilthares
    .goto The Barrens,62.40,39.40
    .complete 898,1 --Escort Gilthares Firebough back to Ratchet (1)
step
    .goto The Barrens,65.83,43.85
    .turnin 873 >> Turn in Isha Awak
step
    .hs >> Hearth back to Camp Taurajo
	>> Buy food/water if needed
step
    .isOnQuest 897
    .turnin 897 >> Turn in The Harvester
step
    .goto The Barrens,45.10,57.70
    .accept 893 >> Accept Weapons of Choice
    .turnin 893 >> Turn in Weapons of Choice
    .accept 1153 >> Accept A New Ore Sample
step
	.isOnQuest 885
    .goto The Barrens,44.60,59.20
    .turnin 879 >> Turn in Betrayal from Within
    .accept 906 >> Accept Betrayal from Within
	.turnin 885 >> Turn in Washte Pawne
step
    .goto The Barrens,44.60,59.20
    .turnin 879 >> Turn in Betrayal from Within
    .accept 906 >> Accept Betrayal from Within
step
	#sticky
	#label Washte
	#completewith next
	.goto The Barrens,44.7,74.7,0
	>>Search for Washte Pawne (Red Wind Serpent) around the area. He drops a quest. If you can't find him in this last spot, skip the quest
	.collect 5103,1,885 --Collect Washte Pawne's Feather
	.accept 885 >>Accept Washte Pawne
step
   .goto The Barrens,44.45,59.15
    .fly Crossroads >> Fly to The Crossroads
step
    .goto The Barrens,51.50,30.90
    .turnin 906 >> Turn in Betrayal from Within
step
	#completewith next
	+If you have over 12 Silithid Eggs, split the stack and delete the extras that you have
step
    .goto The Barrens,51.10,29.60
    .turnin 868 >> Turn in Egg Hunt
step << Hunter
    .goto The Barrens,51.50,30.34
	.fly Orgrimmar >> Fly to Orgrimmar
step << Hunter
    .goto Orgrimmar,48.13,80.53
	.vendor >> Fill your quiver with level 25 arrows. Also upgrade your bags to 4 bags of 8 slots (if they're bigger).
step
    .goto The Barrens,51.5,30.3 << !Hunter
    .goto Orgrimmar,45.11,63.89 << Hunter
    .fly Sun Rock >> Fly to Stonetalon Mountains
step
	#era
    .goto Stonetalon Mountains,45.90,60.40
    .accept 1087 >> Accept Cenarius' Legacy
step
    .goto Stonetalon Mountains,47.30,64.30
    .accept 6393 >> Accept Elemental War
step
    .goto Stonetalon Mountains,47.40,58.40
    .accept 6301 >> Accept Cycle of Rebirth
step
    .goto Stonetalon Mountains,47.30,61.10
    .accept 5881 >> Accept Calling in the Reserves
    .accept 6282 >> Accept Harpies Threaten
step << Warlock
    .isQuestComplete 6284
    .goto Stonetalon Mountains,47.19,61.15
    .turnin 6284 >> Turn in Arachnophobia
step << !Warlock
    .goto Stonetalon Mountains,59.10,75.73
    .accept 6284 >>Accept Arachnophobia
step << !Warlock
	>>Be careful as Besseleth is a level 21 elite and has a net and poison. Group up if needed
    .goto Stonetalon Mountains,52.03,73.89
    .complete 6284,1 --Besseleth's Fang (1)
	.unitscan Besseleth
step
    .goto Stonetalon Mountains,59.00,62.60
    .accept 1096 >> Accept Gerenzo Wrenchwhistle
step
    .goto Stonetalon Mountains,66.40,45.40
     >> Place the Toxic Fogger
    .complete 1086,1
step
    .goto Stonetalon Mountains,64.48,40.25
    >>Climb up the mountain to find Gerenzo. Clear the mobs around him and kill him.
    .complete 1096,1
    .unitscan Gerenzo Wrenchwhistle
step
    .goto Stonetalon Mountains,62.6,40.2
	.vendor >> Go and buy gear upgrades from the vendor at the end of platform. He has the chance of having gear upgrades for every class.
step
    .goto Stonetalon Mountains,58.98,62.59
    .turnin 1096 >> Turn in Gerenzo Wrenchwhistle
step
    #label Gaea
    #sticky
     >> Loot Gaea Seeds as you pass through the lake and around the lake.
    .complete 6301,1
step
	#era
    .goto Stonetalon Mountains,38.4,18.4
	>>Kill all the Coursers you see en route to Stonetalon Peak. Loot them for their eyes
	.complete 1058,3
step
	#era
    .goto Stonetalon Mountains,35.84,13.09
	>>Kill the Dryads and Night Elves in the area
    .complete 1087,1
    .complete 1087,2
    .complete 1087,3
step
	#era
    .goto Stonetalon Mountains,38.4,18.4
	>>Kill Sap Beasts for Stonetalon Sap, Runners for Whiskers, and Fey Dragons for the Scale
	.complete 1058,1
	.complete 1058,2
	.complete 1058,4
step
    #requires Gaea
    #sticky
	#label firelemental
     >> Kill Fire Elementals
    .complete 6393,1
step
    #requires Gaea
    .goto Stonetalon Mountains,31.10,61.27
	>>Kill Harpies. Be careful as the Slayers execute you when you're below 20% health, Ambushers shock for a LOT of instant damage on low cooldown, and Roguefeathers thrash (multiple attacks at once every 10 seconds or so)
    .complete 6282,1
    .complete 6282,2
    .complete 6282,3
    .complete 6282,4
step
	#era
    .goto Stonetalon Mountains,46.00,60.50
     >> Head to Sun Rock Retreat
    .turnin 1087 >> Turn in Cenarius' Legacy
    .accept 1088 >> Accept Ordanus
step << !Warlock
    .goto Stonetalon Mountains,47.24,61.14
    .turnin 6284 >>Turn in Arachnophobia
step
    .goto Stonetalon Mountains,47.10,61.10
    .turnin 6282 >> Turn in Harpies Threaten
    .accept 6283 >> Accept Bloodfury Bloodline
step
    .goto Stonetalon Mountains,47.40,58.50
    .turnin 6301 >> Turn in Cycle of Rebirth
    .accept 6381 >> Accept New Life
step
	#sticky treesvale
    .goto Stonetalon Mountains,31.10,61.27
	>> Plant the trees in the vale.
	.complete 6381,1
step
	#requires Fireelemental
    .goto Stonetalon Mountains,30.75,61.91
    >>Clear out the Harpies next to Bloodfury Ripper. She has a large social pull radius so be careful. Group if you can't solo this quest.
    .complete 6283,1
    .unitscan Bloodfury Ripper
step
	#requires treesvale
    .goto Stonetalon Mountains,47.20,64.40
     >> Head to Sun Rock Retreat
    .turnin 6393 >> Turn in Elemental War
step
    .isQuestComplete 6283
    .goto Stonetalon Mountains,47.19,61.15
    .turnin 6283 >> Turn in Bloodfury Bloodline
step
    .goto Stonetalon Mountains,47.46,58.37
    .turnin 6381 >> Turn in New Life
step
	#era
    .goto Stonetalon Mountains,74.50,97.90
    .turnin 1060 >> Turn in Letter to Jin'Zil
    .turnin 1058 >> Turn in Jin'Zil's Forest Magic
step
	#som
    .goto Stonetalon Mountains,74.50,97.90
    .turnin 1060 >> Turn in Letter to Jin'Zil
step
    .goto The Barrens,35.30,27.90
    .turnin 1068 >> Turn in Shredding Machines
step << Hunter
    .hs >> Hearth to Camp Taurajo
	>> Buy food/water if needed
step << Hunter
    .goto The Barrens,44.45,59.15
    .fly Splintertree >> Fly to Splintertree Post
step << !Hunter
    .goto Ashenvale,68.66,85.86
	.zone Ashenvale >> Walk to Ashenvale from Stonetalon via The Barrens
]])

RXPGuides.RegisterGuide("RestedXP Horde 22-30",[[
#classic
<< Horde

#name 26-28 Ashenvale
#next 28-30 Thousand Needles

step  << !Hunter
    .goto Ashenvale,68.30,75.30
     >> Start the escort quest
    .accept 6544 >> Accept Torek's Assault
step  << !Hunter
     >> Escort Torek. When you kill the mobs 4 inside, run to the end platform (as more mobs will spawn), and let the orcs take aggro
     >> Kill the mobs that have aggro on Torek, then kill the rest.
    .complete 6544,1 --Take Silverwing Outpost. (1)
step << !Hunter
    .goto Ashenvale,71.20,68.10
    .accept 6503 >> Accept Ashenvale Outrunners
step  << !Hunter
    .goto Ashenvale,73.00,62.50
    .turnin 6544 >> Turn in Torek's Assault
step  << !Hunter
    .goto Ashenvale,73.78,61.46
    .turnin 6382 >> Turn in The Ashenvale Hunt
    .turnin 6383 >> Turn in The Ashenvale Hunt
step
    .goto Ashenvale,73.10,61.50
    .accept 6441 >> Accept Satyr Horns
step << Hunter
    .goto Ashenvale,73.38,61.01
	.stable >> Talk to Qeeju. Stable your pet
step
    .goto Ashenvale,73.60,60.10
    .accept 25 >> Accept Stonetalon Standstill
step << Rogue
    .goto Ashenvale,74.0,60.6
    .home >>Set your Hearthstone to Splintertree Post
step << Hunter
	#completewith Outrunners
   .goto Ashenvale,68.84,60.54
	+Leave Splintertree and cross the river. Tame an Elder Ashenvale Bear
	>>Attack mobs with the Bear using Rank 4 Claw until you see that you've learnt it in your chat window
	.unitscan Elder Ashenvale Bear
step << Hunter
    .goto Ashenvale,73.38,61.01
	.stable >>Abandon the Bear. Go back to the stable and equip your pet
step << Hunter
	#sticky
	#label Sharptalon
	>>Kill Sharptalon by kiting him back to the guards. M
step << Hunter
	#label Outrunners
    .goto Ashenvale,71.20,68.10
    .accept 6503 >> Accept Ashenvale Outrunners
step
	 >>Kill Ashenvale Outrunners that are stealthed around the area.
	.goto Ashenvale,72.5,72.5,90,0
    .goto Ashenvale,76.3,71.1,90,0
    .goto Ashenvale,76.3,67.3,90,0
    .goto Ashenvale,72.5,72.5
    .complete 6503,1 --Kill Ashenvale Outrunner (x9)
step
    #sticky
    #completewith next
    .goto Ashenvale,71.75,63.83,90,0
	.goto Ashenvale,72.3,49.8,90 >>Run along the side of the river to here
step
    >>Kill Satyrs in the area. Loot them for their Horns
	.goto Ashenvale,68.2,54.0
    .complete 6441,1 --Collect Satyr Horns (x16)
step
    #sticky
    #completewith next
    >>Kill Laughing Sisters until they drop Etched Phial
    .collect 5867 --Collect Etched Phial (x1)
step
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful
    #hardcore
step
	#era
    .goto Ashenvale,62.07,51.32
	>> Ordanus can be quite hard, your should try to burst him, loot him and then jump down from the building. 
    .complete 1088,1 --Ordanus' Head (1)
step
	>>Look for Shadumbra (a panther) and loot her for Shadumbra's Head, then accept it.
	.goto Ashenvale,62.2,49.6,90,0
    .goto Ashenvale,58.0,56.2,90,0
    .goto Ashenvale,51.9,54.3,90,0
    .goto Ashenvale,61.2,51.5
    .collect 16304,1,24 --Collect Shadumbra's Head
	.accept 24 >> Accept Shadumbra's Head
	.unitscan Shadumbra
step
    >>Kill Laughing Sisters until they drop Etched Phial
    .goto Ashenvale,61.3,51.9
    .collect 5867 --Collect Etched Phial (x1)
step
    #requires Phial
    .goto Ashenvale,44.62,55.47,150,0
	.goto Ashenvale,38.5,36.1,90 >>Run to Thistlefur Village
step
    #sticky
    #completewith next
    >>Kill some of the Furbolgs en route to the cave
    .complete 216,2 --Kill Thistlefur Shaman (x8)
	.complete 216,1 --Kill Thistlefur Avenger (x8)
step
	#completewith next
	.goto Ashenvale,38.4,30.6,60 >>Run into Thistlefur Hold
step
    .goto Ashenvale,41.08,32.74
	>>Loot the tiny chests inside the tunnel
	.complete 6462,1 --Collect Troll Charm (x8)
step
    >>Go to the back of the cave. Talk to the Bear. This starts an escort
	.goto Ashenvale,41.5,34.5
    .accept 6482 >> Accept Freedom to Ruul
step
    .goto Ashenvale,38.5,36.4
    .complete 6482,1 --Escort Ruul from the Thistlefurs.
step
    >>Finish killing the Furbolgs
	.goto Ashenvale,35.9,36.7
    .complete 216,2 --Kill Thistlefur Shaman (x8)
	.complete 216,1 --Kill Thistlefur Avenger (x8)
step << Shaman
    >>Fill the Waterskin
	.goto Ashenvale,33.5,67.5
    .complete 1534,1 --Filled Blue Waterskin (1)
step
    .goto Ashenvale,41.5,67.4,90,0
    .goto Ashenvale,44.3,68.6,90,0
    .goto Ashenvale,43.8,63.6,90,0
    .goto Ashenvale,41.4,65.9,90,0
    .goto Ashenvale,41.5,67.4
	>>Look for Ursangous (Bear). He patrols clockwise. Kill and loot him for Ursangous's Paw, then accept it
    .collect 16303,1,23 --Collect Ursangous's Paw (x1)
    .accept 23 >> Accept Ursangous's Paw
	.unitscan Ursangous
step
    #sticky
    #label Tideress
    >>Kill Tideress who is located around the middle of the lake. Loot her for a Befouled Water Globe, then click it to accept the quest
    .collect 16408,1,1918 --Collect Befouled Water Globe (x1)
    .accept 1918 >>Accept The Befouled Element
step
    #sticky
    #completewith next
    >>Kill Water Elementals throughout the lake
    .complete 25,1 --Kill Befouled Water Elemental (x12)
step
    >>Run under the Gazebo in the middle of the lake
	.goto Ashenvale,48.9,69.6
    .complete 25,2 --Scout the gazebo on Mystral Lake that overlooks the nearby Alliance outpost.
step
    >>Kill Water Elementals throughout the lake
	.goto Ashenvale,48.9,69.6
    .complete 25,1 --Kill Befouled Water Elemental (x12)
step
    #requires Tideress
	>>Use the Etched Phial from earlier at the moonwell
	.goto Ashenvale,60.2,72.9
    .complete 1195,1 --Collect Filled Etched Phial (x1)
step
    .goto Ashenvale,71.2,68.1
    .turnin 6503 >> Turn in Ashenvale Outrunners
step
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful
    #hardcore
step
    .goto Ashenvale,72.4,72.1,90,0
    .goto Ashenvale,75.7,70.0,90,0
    .goto Ashenvale,78.2,65.5,90,0
    .goto Ashenvale,72.4,72.1,90,0
    .goto Ashenvale,75.7,70.0,90,0
    .goto Ashenvale,78.2,65.5,90,0
    .goto Ashenvale,75.3,72.0,0
	>>Look for Sharptalon (Big Bird). He Patrols clockwise. Kill and loot him for Sharptalon's Claw, then accept it. Solo him down to about 60%, then kite him to the undead camp to kill him.
    .collect 16305,1,2 --Collect Sharptalon's Claw
    .accept 2 >> Accept Sharptalon's Claw
	.unitscan Sharptalon
step
    >>Go back to town
	.goto Ashenvale,73.1,62.5
    .turnin 6544 >> Turn in Torek's Assault
step
    .goto Ashenvale,73.8,61.5
    .turnin 2 >> Turn in Sharptalon's Claw
    .turnin 24 >> Turn in Shadumbra's Head
    .turnin 23 >> Turn in Ursangous's Paw
    .turnin 247 >> Turn in The Hunt Completed
step
    .goto Ashenvale,73.1,61.5
    .turnin 6441 >> Turn in Satyr Horns
step
    .goto Ashenvale,73.7,60.0
    .turnin 25 >> Turn in Stonetalon Standstill
    .turnin 1918 >> Turn in The Befouled Element
    .accept 824 >> Accept Je'neu of the Earthen Ring
step
    .goto Ashenvale,74.1,60.9
    .turnin 6482 >> Turn in Freedom to Ruul
step
    .goto Ashenvale,73.2,61.5
    .fly Zoram'gar >> Fly to Zoram'gar Outpost
step
    .goto Ashenvale,11.9,34.5
    .turnin 216 >> Turn in Between a Rock and a Thistlefur
step
    .goto Ashenvale,11.7,34.8
    .turnin 6462 >> Turn in Troll Charm
step
    .goto Ashenvale,11.6,34.3
    .turnin 824 >> Turn in Je'neu of the Earthen Ring
step << Rogue
    .goto Ashenvale,11.59,34.27
    .accept 6921 >>Accept Amongst the Ruins
    .accept 6563 >>Accept The Essence of Aku'Mai
step << Rogue
    .goto Ashenvale,14.0,15.0,100 >> Go to the entrance of Blackfathom Deeps
step << Rogue
    .goto Ashenvale,13.15,12.96
	>> Kill Blackfathom Tide Priestesses until Damp Note drops. Start the quest
	.collect 16790,1,6564
    .accept 6564 >> Accept Allegiance to the Old Gods
step << Rogue
    .goto Ashenvale,17.04,12.29
	>> Stealth towards the dungeon while looting the 20 Sapphires on the walls
    .complete 6563,1 --Sapphire of Aku'Mai (20)
step << Rogue
	#completewith next
	+To solo this quest you need to play correctly in 2 ways. First of all you need to not die to breath, that means before you aggro the boss you should have full breath. The second thing to be aware of is that you need to kick EVERY frostbolt you can and use evasion after a kick. Most of his damage will be from frostbolts. Remember you can vanish and try again 5 mins later, aslong as you don't die to breath.
	.link https://youtu.be/ehXV0stmDrM?t=202 >> CLICK HERE for a guide on this section
step << Rogue
	>> Stealth all the way to the Moonshine Ruins, then swim under the Bridge and prepare for the boss (Use all buffs you have)
	>> Loot the Fathom Core, this spawns the boss.
	>> Loot the Globe from Baron Aquanis. Accept the quest
	.collect 16762,1,6922 
	.accept 6922 >> Accept Baron Aquanis
	.trainer >> Go and train your class spells
step << !Rogue
    .hs >> Hearth to Camp Taurajo
	>> Buy food/water if needed
step << Rogue
    .hs >> Hearth to Splintertree Post
	>> Buy food/water if needed
step << Rogue
    .goto Ashenvale,73.2,61.5
    .fly Zoram'gar >> Fly to Zoram'gar Outpost
step << Rogue
    .goto Ashenvale,11.57,34.28
    .turnin 6563 >>Turn in The Essence of Aku'Mai
    .turnin 6921 >>Turn in Amongst the Ruins
    .turnin 909 >>Turn in Baron Aquanis
    .turnin 6564 >>Turn in Allegiance to the Old Gods
step << Warlock/Rogue
    .goto Ashenvale,12.24,33.80
    .fly Orgrimmar >> Fly to Orgrimmar
step << Rogue
    .goto Orgrimmar,44.0,54.6
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,48.0,46.0
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,47.5,46.7
	.vendor >> Buy your pet upgrades if you got the money for it.
step
    .goto Orgrimmar,45.11,63.89 << Warlock/Rogue
	    .goto The Barrens,44.45,59.16 << !Warlock !Rogue
    .fly Thunder Bluff >> Fly to Thunder Bluff

]])

RXPGuides.RegisterGuide("RestedXP Horde 22-30",[[
#classic
<< Horde

#name 28-30 Thousand Needles
#next RestedXP Horde 30-40\30-32 Hillsbrad/Arathi

step << Shaman/Warrior
    .goto Thunder Bluff,54.0,57.3
    >> Go and buy the Merciless Axe if it's in the shop. If it's not, skip this step
    .collect 12249,1
step << Hunter
    .goto Thunder Bluff,46.9,45.7
    >> Go and buy the Sturdy Recurve if it's in the shop. If it's not, skip this step
    >> Buy arrows until your quiver is full
    .collect 11306,1
step
    .goto Thunder Bluff,54.90,51.60
    .turnin 1195 >> Turn in The Sacred Flame
    .accept 1196 >> Accept The Sacred Flame
step << Druid
    .goto Thunder Bluff,77.0,29.9
	.trainer >> Go and train your class spells
step << Hunter
    .goto Thunder Bluff,59.1,86.9
	.trainer >> Go and train your class spells
step << Hunter
    .goto Thunder Bluff,54.1,83.9
	.trainer >> Go and train your pet spells
step << Warrior
    .goto Thunder Bluff,57.6,85.5
	.trainer >> Go and train your class spells
step << Shaman
    .goto Thunder Bluff,22.8,21.0
	.trainer >> Go and train your class spells
step << Priest
    .goto Thunder Bluff,24.6,22.6
	.trainer >> Go and train your class spells
step << Mage
    .goto Thunder Bluff,25.2,20.9
	.trainer >> Go and train your class spells
step
	#era
    .goto Thunder Bluff,22.80,20.80
    .turnin 1086 >> Turn in The Flying Machine Airport
step
    .goto Thunder Bluff,45.80,64.60
    .home >> Set your Hearthstone to Thunder Bluff
step
    .goto Thunder Bluff,61.53,80.91
    .accept 1131 >> Accept Steelsnap
step
	>>Run up the tower to the Flight Master
    .goto Thunder Bluff,47.00,49.83
    .fly Camp Taurajo >> Fly to Camp Taurajo
step
    .goto The Barrens,45.10,57.70
    .accept 1153 >> Accept A New Ore Sample
step << Warlock/Hunter
    .goto The Barrens,48.90,86.30
    .accept 857 >> Accept The Tear of the Moons
	#softcore
step << Warlock/Hunter
    .goto The Barrens,49.12,84.25
     >> Enter the keep, go downstairs, and loot the chest.
    .complete 857,1
	#softcore
step << Warlock/Hunter
    .goto The Barrens,48.99,86.29
    .turnin 857 >> Turn in The Tear of the Moons
	#softcore
step
    .goto The Barrens,44.00,92.00
    .turnin 5881 >> Turn in Calling in the Reserves
step
    .goto The Barrens,44.20,92.20
    .accept 4542 >> Accept Message to Freewind Post
step
    #sticky
	#completewith GalakM
     >> Keep an eye out & kill the Galak Messenger that patrols the area as you quest. Loot him for the Assassination Note
	.collect 12564,1,4881
    .accept 4881 >> Accept Assassination Plot
    .unitscan Galak Messenger
step
    #sticky
	#completewith Faith
     >> Kill all Kobolds you encounter
    .complete 1153,1
    .unitscan Gravelsnout Digger,Gravelsnout Surveyor,Gibblesnik
step
	>>Take the lift up to Freewind Post
    .goto Thousand Needles,46.74,47.98,30,0
    .goto Thousand Needles,45.10,49.10
    .fp Freewind >> Get the Freewind Post Flight Path
step
    .goto Thousand Needles,44.90,48.90
    .accept 4767 >> Accept Wind Rider
step
    .goto Thousand Needles,44.70,50.30
    .accept 4821 >> Accept Alien Egg
step << Hunter
    .goto Thousand Needles,44.9,50.7
    >> Go buy Dense Shortbow if it's in the shop. If it's not, skip this step
	>> Buy arrows until your quiver is full
    .collect 11305,1
step
    .goto Thousand Needles,45.70,50.80
    .turnin 4542 >> Turn in Message to Freewind Post
    .accept 4841 >> Accept Pacify the Centaur
step
    .goto Thousand Needles,46.10,51.60
    .turnin 1196 >> Turn in The Sacred Flame
    .accept 1197 >> Accept The Sacred Flame
step
    .goto Thousand Needles,46.00,50.80
     >> Click on the wanted poster
    .accept 5147 >> Accept Wanted - Arnak Grimtotem
step
	#completewith next
     >> Kill Centaurs in the area
    .complete 4841,1
    .complete 4841,2
    .complete 4841,3
step
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful
    #hardcore
step
    .goto Thousand Needles,44.11,37.16,50,0
    .goto Thousand Needles,42.00,31.60
     >> Go to the Centaur Cave. Click on the brazier at the back of it. Loot the item from it
    .complete 1197,1
step
    .goto Thousand Needles,40.89,38.45
     >> Finish killing the remaining Centaurs
    .complete 4841,1
    .complete 4841,2
    .complete 4841,3
step
    .goto Thousand Needles,53.90,41.60
    .accept 1149 >> Accept Test of Faith
step
     >> Jump off the small wooden platform. You will be teleported back to the cave mid-air
    .complete 1149,1
--N needs fixing, retrieving quest data bug
step
	#label Faith
    .goto Thousand Needles,53.94,41.48
    .turnin 1149 >> Turn in Test of Faith
    .accept 1150 >> Accept Test of Endurance
step
	#sticky
	#label Kobolds
    .goto Thousand Needles,65.74,49.89,90,0
    .goto Thousand Needles,67.87,58.33,90,0
    .goto Thousand Needles,66.03,62.14,90,0
    .goto Thousand Needles,58.95,57.84,90,0
    .goto Thousand Needles,65.74,49.89
     >> Kill all Kobolds you encounter
    .complete 1153,1
    .unitscan Gravelsnout Digger,Gravelsnout Surveyor,Gibblesnik
step
    .goto Thousand Needles,56.30,50.40,20,0
    .goto Thousand Needles,52.33,55.25,20,0
    .goto Thousand Needles,37.64,56.01,20,0
    .goto Thousand Needles,56.30,50.40,20,0
    .goto Thousand Needles,52.33,55.25,20,0
    .goto Thousand Needles,37.64,56.01,20,0
    .goto Thousand Needles,56.30,50.40,0
    .goto Thousand Needles,52.33,55.25,0
    .goto Thousand Needles,37.64,56.01,0
    >>Look for the white Alien Egg at the Wind Serpent nests. It can be in multiple spawnpoints
    .complete 4821,1
step
	#requires Kobolds
    .goto Thousand Needles,46.10,51.60
    .turnin 1197 >> Turn in The Sacred Flame
step
    .goto Thousand Needles,45.70,50.80
    .turnin 4841 >> Turn in Pacify the Centaur
    .accept 5064 >> Accept Grimtotem Spying
step
    .goto Thousand Needles,44.70,50.30
    .turnin 4821 >> Turn in Alien Egg
    .accept 4865 >> Accept Serpent Wild
step
    .goto Thousand Needles,25.90,54.80
     >> Head to the harpy cave. Destroy all the boxes at the end of it to summon Grenka Bloodscreech. 
	>> Be careful as this quest is VERY HARD. Find a group if you're unable to solo this or skip it.
	.link https://www.youtube.com/watch?v=EVy-6OjB5bs&t=27300s >> CLICK HERE for a visual reference if you think it's doable
    .complete 1150,1
step
    #completewith SteelsnapG
     >> Kill Steelsnap. He patrols the zone. Try to split pull him if you know how
    .complete 1131,1
    .unitscan Steelsnap
step
    #completewith Paoka
	>>Loot the eggs on the ground. Try to have 7-8 before starting the Escort, and finish it during the escort
    .complete 4767,1
step
    .goto Thousand Needles,14.05,32.01,60,0
    .goto Thousand Needles,12.65,34.49,60,0
    .goto Thousand Needles,13.45,40.29,40,0
    .goto Thousand Needles,17.90,40.60
     >> Start the escort quest
    .accept 4770 >> Accept Homeward Bound
step
	#label Paoka
     >> Escort Pao'ka to safety. Be careful of Heartrazor (level 32 rare elite)
    .complete 4770,1
	.unitscan Heartrazor
step
    .goto Thousand Needles,11.60,35.21
     >> Finish gathering the Highperch Eggs
    .complete 4767,1
step
	#completewith next
    .goto Thousand Needles,21.06,31.87
	.vendor >> vendor trash, buy food/water if needed
step
	.isOnQuest 4881
    .goto Thousand Needles,21.34,31.95
    .turnin 4881 >>Turn in Assassination Plot
	>>Accepting this quest will start an escort. 3 Mobs will attack at once
    .accept 4966 >>Accept Protect Kanati Greycloud
step
	.isQuestTurnedIn 4881
    .goto Thousand Needles,21.34,31.95
	>>Kill the 3 mobs that spawn
    .complete 4966,1 --Protect Kanati Greycloud (1)
    .turnin 4966 >>Turn in Protect Kanati Greycloud
step
    .goto Thousand Needles,21.50,32.50
    .accept 5151 >> Accept Hypercapacitor Gizmo
    .turnin 4865 >> Turn in Serpent Wild
    .accept 5062 >> Accept Sacred Fire
    .turnin 4770 >> Turn in Homeward Bound
step
	#softcore
    .goto Thousand Needles,22.90,24.40
     >> Click on the panther cage and kill the elite inside. Group up if he's too hard to solo.
	>>Be careful as this quest is HARD
    .complete 5151,1
--N LINK
step
	#hardcore
    .goto Thousand Needles,22.90,24.40
     >> Click on the panther cage and kill the elite inside
	>>Be careful as this quest is HARD
    .complete 5151,1
--N LINK
step
	.goto Thousand Needles,18.7,22.2
	.xp 28+29000 >> Grind to 29000+/41400xp
step
    .goto Thousand Needles,21.43,32.55
    .isQuestComplete 5151
    .turnin 5151 >> Turn in Hypercapacitor Gizmo
step
	#label SteelsnapG
    .goto The Barrens,35.22,92.47
     >> Finish off A New Ore Sample
    .complete 1153,1
step
	#label GalakM
	>>Search for Steelsnap (Hyena). He patrols counter-clockwise
	>>Scout him out with Eagle Eye << Hunter
	>>Scout him out with Far Sight if you have it trained << Shaman
	.goto Thousand Needles,10.9,23.2,90,0
    .goto Thousand Needles,17.1,18.4,90,0
    .goto Thousand Needles,18.3,26.8,90,0
    .goto Thousand Needles,15.2,30.5,90,0
    .goto Thousand Needles,18.3,26.8,90,0
    .goto Thousand Needles,17.1,18.4,90,0
	.goto Thousand Needles,10.9,23.2,90,0
    .goto Thousand Needles,17.1,18.4,90,0
    .goto Thousand Needles,18.3,26.8,90,0
    .goto Thousand Needles,15.2,30.5,90,0
	.complete 1131,1 --Collect Steelsnap's Rib (x1)
	.unitscan Steelsnap
step
	>>Search for the Galak Messenger. He starts at a camp, goes on the road, then goes to the other camp
	>>Scout him out with Eagle Eye << Hunter
	>>Scout him out with Far Sight if you have it trained << Shaman
    .goto Thousand Needles,18.4,22.2,90,0
    .goto Thousand Needles,25.2,33.8,90,0
    .goto Thousand Needles,36.0,29.0,90,0
    .goto Thousand Needles,39.6,33.6,90,0
	.goto Thousand Needles,36.0,29.0,90,0
    .goto Thousand Needles,25.2,33.8,90,0
    .goto Thousand Needles,18.4,22.2,90,0
    .goto Thousand Needles,25.2,33.8,90,0
    .goto Thousand Needles,36.0,29.0,90,0
    .goto Thousand Needles,39.6,33.6,90,0
    .collect 12564,1,4881 --Collect Assassination Note (x1)
    .accept 4881 >> Accept Assassination Plot
	.unitscan Galak Messenger
step
	>>Loot the plants in and around the whole body of water
    .goto Thousand Needles,36.80,38.11
    .complete 5062,1
step
    #completewith next
    .hs >> Hearth to Thunder Bluff
	>> Buy food/water if needed
step
    .goto Thunder Bluff,61.53,80.91
    .turnin 1131 >> Turn in Steelsnap
step << Hunter
    .goto Thunder Bluff,59.1,86.9
	.trainer >> Go and train your class spells
step << Hunter
    .goto Thunder Bluff,54.1,83.9
	.trainer >> Go and train your pet spells
step << Warrior
    .goto Thunder Bluff,57.6,85.5
	.trainer >> Go and train your class spells
step
    .goto Thunder Bluff,70.20,30.90
    .turnin 5062 >> Turn in Sacred Fire
    .accept 5088 >> Accept Arikara
step << Druid
    .goto Thunder Bluff,77.0,29.9
	.trainer >> Go and train your class spells
step << Shaman
    .goto Thunder Bluff,22.8,21.0
	.trainer >> Go and train your class spells
step << Priest
    .goto Thunder Bluff,24.6,22.6
	.trainer >> Go and train your class spells
step << Mage
    .goto Thunder Bluff,25.2,20.9
	.trainer >> Go and train your class spells
step
    .goto Thunder Bluff,46.8,50.0
    .fly Camp Taurajo >> Fly to Camp Taurajo
step
    .goto The Barrens,45.10,57.70
    .turnin 1153 >> Turn in A New Ore Sample
step
   .goto The Barrens,44.45,59.15
    .fly Freewind >> Fly to Thousand Needles
step
    .goto Thousand Needles,45.00,49.00
    .turnin 4767 >> Turn in Wind Rider
step
    .goto Thousand Needles,53.90,41.60
    .turnin 1150 >> Turn in Test of Endurance
    .accept 1151 >> Accept Test of Strength
step
    .goto Thousand Needles,25.60,45.60,0
    .goto Thousand Needles,8.60,20.00,0
     >> Kill Rok'Alim the Pounder. He patrols a large portion of the south-western part of the zone
	>> Be careful as this quest is HARD. Skip it if you need to
    .complete 1151,1
    .unitscan Rok'Alim the Pounder
step
    .goto Thousand Needles,31.50,36.70,30 >> Head to Darkcloud Pinnacle
step
    .goto Thousand Needles,31.80,32.70
     >> Loot the chest on top of the plataeu. Collect Secret Note #1
    .complete 5064,1
step
    .goto Thousand Needles,33.80,39.90
     >> Loot the chest in the building. Collect Secret Note #2
    .complete 5064,2
step
    .goto Thousand Needles,39.20,41.60
     >> Loot the chest in the building. Collect Secret Note #3
    .complete 5064,3
step
    >>Clear the mobs around the Bonfire. Light it, then kill Arikara. Loot her
	>>Be careful as she is a level 28 elite, use scrolls/potions/cooldowns etc if you have them
    .goto Thousand Needles,38.00,35.30
    .complete 5088,2
    .complete 5088,1
step
    .goto Thousand Needles,38.00,26.80
     >> Kill Arnak Grimtotem. Loot him for his Hoof
    .complete 5147,1
step
    .goto Thousand Needles,38.00,26.60
     >> Start the escort quest
    .accept 4904 >> Accept Free at Last
step
	>>Escort Lakota. Whenever she reaches a new platform, 2 mobs will spawn - try and stay ahead of her to clear the platforms if you have respawns behind
	>>Be careful as this quest is HARD. Don't be afraid to escape by running behind you and failing the escort
	>>If you can't do it, abandon the quest
    .goto Thousand Needles,30.98,37.08
    .complete 4904,1 --Escort Lakota Windsong from the Darkcloud Pinnacle. (1)
step
    .goto Thousand Needles,28.69,40.81,90,0
    .goto Thousand Needles,26.89,47.50,90,0
    .goto Thousand Needles,21.87,41.58,90,0
    .goto Thousand Needles,23.66,36.46,90,0
    .goto Thousand Needles,20.98,39.78,90,0
    .goto Thousand Needles,18.42,38.40,90,0
    .goto Thousand Needles,15.11,32.54,90,0
    .goto Thousand Needles,11.94,24.77,90,0
    .goto Thousand Needles,8.74,20.58,90,0
    .goto Thousand Needles,9.31,17.90
	#completewith next
     >> Kill Rok'Alim the Pounder. He patrols a large portion of the south-western part of the zone
	>> Be careful as this quest is HARD. Skip it if you need to
    .complete 1151,1
    .unitscan Rok'Alim the Pounder
step
	.isQuestComplete 1151
    .goto Thousand Needles,53.90,41.50
    .turnin 1151 >> Turn in Test of Strength
step
    .goto Thousand Needles,77.78,77.26
     >> Talk to Kravel Koalbeard
    .accept 1110 >> Accept Rocket Car Parts
    .accept 1111 >> Accept Wharfmaster Dizzywig
step
    .goto Thousand Needles,78.06,77.12
     >> Talk with the Gnomes
    .accept 1104 >> Accept Salt Flat Venom
    .accept 1105 >> Accept Hardened Shells
step
    .goto Thousand Needles,80.17,75.88
    .accept 1176 >> Accept Load Lightening
step
    .goto Thousand Needles,81.63,77.95
    .accept 1175 >> Accept A Bump in the Road
step
    .goto Tanaris,51.60,25.40
	.fp Gadgetzan >> Get the Gadgetzan Flight Path
    .fly Freewind >> Fly to Freewind Post
step
    .goto Thousand Needles,45.70,50.80
    .turnin 5064 >> Turn in Grimtotem Spying
    .turnin 5147 >> Turn in Wanted - Arnak Grimtotem
step
	.isQuestComplete 4904
    .goto Thousand Needles,46.00,51.50
    .turnin 4904 >> Turn in Free at Last
step
    .goto Thousand Needles,46.00,52.0
    .home >> Set your Hearthstone to Freewind Post
step
    .goto Thousand Needles,46.65,48.36,30 >> Take the lift down from Freewind Post
step
    .goto Thousand Needles,21.50,32.20
    .turnin 5088 >> Turn in Arikara
step
    .goto Thousand Needles,21.34,31.95
    .turnin 4881 >>Turn in Assassination Plot
	>>Accepting this quest will start an escort. 3 Mobs will attack at once
    .accept 4966 >>Accept Protect Kanati Greycloud
step
    .goto Thousand Needles,21.34,31.95
	>>Kill the 3 mobs that spawn
    .complete 4966,1 --Protect Kanati Greycloud (1)
    .turnin 4966 >>Turn in Protect Kanati Greycloud
step
	#softcore
    .goto Feralas,88.97,41.13
	.zone Feralas >> Run North-West into Feralas
step
    #softcore
	.goto Feralas,75.40,44.40
	.deathskip >> Once your zone changes to Feralas, pull a high level mob. Die and Respawn in Camp Mojache
step
    #hardcore
	.goto Feralas,75.40,44.40
     >> Follow the road to Camp Mojache. Be careful of the high level mobs
    .fp Camp Mojache >> Get the Camp Mojache Flight Path
    .fly Crossroads >> Fly to Crossroads
step
	#softcore
	.goto Feralas,75.40,44.40
    .fp Camp Mojache >> Get the Camp Mojache Flight Path
    .fly Crossroads >> Fly to Crossroads
step
    .goto The Barrens,51.10,29.60
    .accept 1145 >> Accept The Swarm Grows
step
    .goto The Barrens,51.5,30.3
    .fly Ratchet >> Fly to Ratchet
step
    .goto The Barrens,63.30,38.40
    .turnin 1111 >> Turn in Wharfmaster Dizzywig
    .accept 1112 >> Accept Parts for Kravel
step << !Mage
    .goto The Barrens,63.1,37.1
    .fly Orgrimmar >> Fly to Orgrimmar
step << Mage
	.zone Orgrimmar >> Teleport to Orgrimmar
step << Mage
    .goto Orgrimmar,38.8,85.6
	.trainer >> Go and train your class spells
step << Shaman
    .goto Orgrimmar,38.6,36.0
	.trainer >> Go and train your class spells
step << Hunter
    .goto Orgrimmar,66.1,18.5
	.trainer >> Go and train your class spells
	>>Save at least 1 Gold 88 Silver for later
step << Hunter
    .goto Orgrimmar,66.3,14.8
	.trainer >> Go and train your pet spells
	>>Save at least 1 Gold 88 Silver for later
step << Hunter
    .goto Orgrimmar,81.62,19.59
	.train 197 >> Train 2h Axes from Hanashi
step << Warrior
    .goto Orgrimmar,79.7,31.4
	.trainer >> Go and train your class spells
	.accept 1718 >> Accept The Islander
step << Rogue
    .goto Orgrimmar,44.0,54.6
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,48.0,46.0
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,47.5,46.7
	.vendor >> Buy your pet spellbooks if you have the money for it.
step << Mage
    .goto Orgrimmar,45.44,56.54
    .vendor >> Go to Horthus. Buy two Runes of Teleportation (or more if you want)
    .collect 17031,2 --Rune of Teleportation (2)
step
    .goto Orgrimmar,75.00,34.10
    .turnin 1145 >> Turn in The Swarm Grows
    .accept 1146 >> Accept The Swarm Grows
step
    .goto Orgrimmar,44.70,52.00
    .accept 1431 >> Accept Alliance Relations
step << Priest
    .goto Orgrimmar,44.8,48.8
	 >> Go into the Cleft of Shadow and talk to Katis. Buy the Pestilent Wand. Equip it
    .collect 5347,1
step << Priest
    .goto Orgrimmar,35.6,87.8
	.trainer >> Go and train your class spells
step
	>>Run to the western exit of Orgrimmar
    .goto Orgrimmar,36.30,72.87,50,0
    .goto Orgrimmar,22.50,52.60
    .turnin 1431 >> Turn in Alliance Relations
    .accept 1432 >> Accept Alliance Relations
step << Warrior
    .goto Orgrimmar,45.14,63.89
	.fly Ratchet >> Fly to Ratchet
step << Warrior
	>>Run (not swim) to Fray Island 
    .goto The Barrens,65.09,47.81,90,0
    .goto The Barrens,68.61,49.16
    .turnin 1718 >>Turn in The Islander
    .accept 1719 >>Accept The Affray
step << Warrior
	>>Step onto the grate behind you. Quickly kill the challengers that come, then kill Big Will
    .goto The Barrens,68.59,48.76
    .complete 1719,1 --Step on the grate to begin the Affray (1)
    .complete 1719,2 --Big Will (1)
step << Warrior
	>>This will teach you Berserker Stance
    .goto The Barrens,68.62,49.16
    .turnin 1719 >>Turn in The Affray
    .accept 1791 >>Accept The Windwatcher
step << Warrior
	>>Run back to Ratchet
    .goto The Barrens,65.09,47.81,90,0
    .goto The Barrens,63.08,37.16
	.fly Orgrimmar >> Fly to Orgrimmar
]])

RXPGuides.RegisterGuide("RestedXP Horde 30-40",[[
#classic
<< Horde

#name 30-33 Hillsbrad/Arathi
#next 33-34 Shimmering Flats
#somname 30-32 Hillsbrad/Arathi

step << Mage
	.zone Undercity >> Teleport to Undercity
step << Mage
    .goto Undercity,82.79,15.82
    .vendor >> Go to Hannah. Buy two Runes of Teleportation (or more if you want)
    .collect 17031,2 --Rune of Teleportation (2)
step << !Mage
    #sticky
    #completewith next
    .goto Durotar,50.8,13.8
	+Go to the Zeppelin tower. Take the Zeppelin to Undercity
step << !Mage
    .zone Tirisfal Glades >>Arrive in Tirisfal
step << Hunter
    .goto Undercity,57.8,31.6
    .train 5011 >> Train Crossbows
	.train 202 >> Train Two-Handed Swords
step << Hunter
	#som
    .goto Undercity,58.6,32.7
    .vendor >> Go and buy a Heavy Quiver and a Heavy Crossbow if you can afford it. Fill your new quiver with arrows
	>>Sell your current bow if it gives you enough money for the Crossbow. Equip it
    .collect 7371,1
	.collect 15809,1
-- .collect 2523,1
--N Not enough money for Bullova in SoM
step << Hunter
	#era
    .goto Undercity,58.6,32.7
    .vendor >> Go and buy a Heavy Quiver and a Heavy Crossbow if you can afford it. Fill your new quiver with arrows
	>>Sell your current bow if it gives you enough money for the Crossbow. Equip it
	>>If you have extra money, you can also buy a Bullova from Geoffrey
    .collect 7371,1
	.collect 15809,1
step << Rogue   
    #sticky
    #completewith next
    .goto Undercity,58.6,32.7
    .vendor >> Go and buy Broadsword if u didn't solo Blackfathom Deeps for Outlaw Sabre.
    .collect 2520,1
step
    .goto Undercity,64.20,49.60
    .accept 1164 >> Accept To Steal From Thieves
step
    .goto Undercity,62.14,44.92
	.train 2550 >> Go to Eunice Burch. Train Cooking for a quest later
step
    .goto Undercity,62.30,43.08
	>>Talk to Ronald Burch. Buy 4 Soothing Spices from him
	.collect 3713,4 --Soothing Spices (4)
step << !Undead !Rogue
    .goto Undercity,63.3,48.4
    .fp Undercity >> Get the Undercity Flight Path
step
    .goto Undercity,63.2,48.3
    .fly Tarren Mill >> Fly to Tarren Mill << !Shaman
	.fly Sepulcher >> Fly to The Sepulcher << Shaman
step << Shaman
	#sticky
	#completewith next 
	 .goto Silverpine Forest,42.1,40.5,10 >> Jump up the side of the tree here
step << Shaman
    .goto Silverpine Forest,41.6,41.8,15,0
    .goto Silverpine Forest,41.6,41.8,15,0
    .goto Silverpine Forest,40.3,42.1,15,0
    .goto Silverpine Forest,38.9,43.3,20 >>Run down the mountain
step << Shaman
    >>Drink the water sapta, then kill the Water Elemental. Loot it for its Bracers
   .goto Silverpine Forest,38.8,44.3
    .complete 63,1 --Corrupt Manifestation's Bracers (1)
step << Shaman
    .goto Silverpine Forest,38.3,44.6
	.turnin 63 >>Turn in Call of Water
    .accept 100 >>Accept Call of Water
step << Shaman
    .goto Silverpine Forest,38.8,44.6
    .turnin 100 >>Turn in Call of Water
    .accept 96 >>Accept Call of Water
step << Shaman
    .goto Silverpine Forest,45.6,42.6
    .fly Tarren Mill >> Fly to Tarren Mill
step
    .goto Hillsbrad Foothills,61.4,19.2
	.accept 509 >> Accept Elixir of Agony
step
    .goto Hillsbrad Foothills,61.8,19.8
    .accept 676 >> Accept The Hammer May Fall
step
    .goto Hillsbrad Foothills,62.4,20.3
    .turnin 529 >> Turn in Battle of Hillsbrad
    .accept 532 >> Accept Battle of Hillsbrad
step
    .goto Hillsbrad Foothills,63.2,20.6
    .accept 533 >> Accept Infiltration
step
    .goto Hillsbrad Foothills,63.9,19.7
    .accept 552 >> Accept Helcular's Revenge
step << !Warrior
	>>Go up and down the river killing Turtles. Loot them for their Meat
    .goto Hillsbrad Foothills,61.97,42.80,100,0
    .goto Hillsbrad Foothills,66.95,37.54,100,0
    .goto Hillsbrad Foothills,70.15,11.79
	.collect 3712,10 --Turtle Meat (10)
step << Warrior
	#completewith next
	>>Go up the river killing Turtles. Loot them for their Meat
	.collect 3712,10 --Turtle Meat (10)
step << Warrior
    .goto Alterac Mountains,80.5,66.9
    .turnin 1791 >>Turn in The Windwatcher
    .accept 1712 >>Accept Cyclonian
step << Warrior
	>>Go down the river killing Turtles. Loot them for their Meat
    .goto Hillsbrad Foothills,70.15,11.79,100,0
    .goto Hillsbrad Foothills,66.95,37.54,100,0
    .goto Hillsbrad Foothills,61.97,42.80
	.collect 3712,10 --Turtle Meat (10)
step
	>>Go into the Inn
    .goto Hillsbrad Foothills,62.3,19.1
	.accept 7321 >> Accept Soothing Turtle Bisque
    .turnin 7321 >> Turn in Soothing Turtle Bisque
step
    .goto Hillsbrad Foothills,61.5,20.9
    .accept 556 >> Accept Stone Tokens
    .accept 544 >> Accept Prison Break In
step
    .goto Hillsbrad Foothills,47.9,31.5,60,0
    .goto Hillsbrad Foothills,46.1,33.2,60,0
    .goto Hillsbrad Foothills,43.5,27.3,60,0
    .goto Hillsbrad Foothills,43.9,30.2,60,0
    .goto Hillsbrad Foothills,41.8,30.6,60,0
    .goto Hillsbrad Foothills,43.6,24.9,60,0
    .goto Hillsbrad Foothills,47.9,31.5
	>>Kill the Yetis in and around the cave. Loot them for Helcular's Rod.
    .complete 552,1 --Collect Helcular's Rod (x1)
step
	#sticky
	#label Council
    >>Kill the Councilmans. Be careful as they Frost Nova and Frostbolt
    .goto Hillsbrad Foothills,29.63,42.33
    .complete 532,2 --Hillsbrad Councilman (5)
step
    >>Kill Magistrate Burnside inside the Hall. Loot the book and Burn the scroll after
    .goto Hillsbrad Foothills,29.67,41.64
    .complete 532,1 --Magistrate Burnside (1)
    .goto Hillsbrad Foothills,29.52,41.53
    .complete 532,4 --Hillsbrad Town Registry (1)
    .goto Hillsbrad Foothills,29.73,41.75
    .complete 532,3 --Hillsbrad Proclamation destroyed (1)
step
	>>Run back to Tarren Mill
	#requires Council
    .goto Hillsbrad Foothills,62.3,20.3
    .turnin 532 >> Turn in Battle of Hillsbrad
    .accept 539 >> Accept Battle of Hillsbrad
step
    #softcore
    .goto Hillsbrad Foothills,63.9,19.7
    .turnin 552 >> Turn in Helcular's Revenge
    .accept 553 >> Accept Helcular's Revenge
step
    #hardcore
    .goto Hillsbrad Foothills,63.9,19.7
    .turnin 552 >> Turn in Helcular's Revenge
step << Hunter
    .goto Hillsbrad Foothills,62.55,19.91
	.vendor >> Go to Kayren. Buy arrows until your quiver is full. You have a long grind ahead
step
    .goto Hillsbrad Foothills,62.79,19.02
	.vendor >> Go into the Inn. Buy food/water if needed. You have a long grind ahead
step
	#sticky
	#completewith Bonds
	>>Kill Humans. Loot them for their skulls
    .complete 546,1 --Collect Hillsbrad Human Skull (x30)
step
    .goto Hillsbrad Foothills,26.95,59.55,100 >> Run to Azurelode Mine
step
	#sticky
	#label Hackett
	>>Kill Miner Hackett. He can be located in multiple areas in the mine
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
    .complete 567,3 --Kill Miner Hackett (x1)
	.unitscan Miner Hackett
step
    #label Bonds
	>>Kill Foreman Bonds. He's located in the main (central) room of the mine. Also finish killing Miners
	.goto Hillsbrad Foothills,31.2,56.0
    .complete 539,1 --Kill Foreman Bonds (x1)
	.complete 539,2 --Kill Hillsbrad Miner (x10)
step
	#requires Hackett
	.goto Hillsbrad Foothills,29.9,55.6
	>>Finish killing Humans and looting them for their skulls
    .complete 546,1 --Collect Hillsbrad Human Skull (x30)
step
    .goto Hillsbrad Foothills,29.8,55.0
	.xp 32 >> Grind to 32 in the Mine. Go back to Tarren Mill if you ever need to restock
	#era
step
    .goto Hillsbrad Foothills,29.8,55.0
	.xp 31 >> Grind to 31 in the Mine
	#som
step
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful
    #hardcore
step
    #sticky
	#completewith Stonetoken
	>>Kill the Dalaran mobs. Loot them for Worn Stone Tokens
    .complete 556,1 --Collect Worn Stone Token (x10)
step
   >>Kill Alina. Loot her for the Shard. Kill Dermot, loot him for the Wedge 
	.goto Alterac Mountains,20.2,86.3
    .complete 544,3 --Collect Bloodstone Shard (x1)
    .complete 544,1 --Collect Bloodstone Wedge (x1)
step
   >>Go outside and kill Ricter. Loot him for the Marble
   .goto Alterac Mountains,19.7,84.6
    .complete 544,2 --Collect Bloodstone Marble (x1)
step
	#label Stonetoken
	>>Go into the second floor of the other building. Kill Kegan. Loot him for the Oval
	 .goto Alterac Mountains,18.6,84.4,15,0
	.goto Alterac Mountains,17.8,83.2
    .complete 544,4 --Collect Bloodstone Oval (x1)
step
    .goto Alterac Mountains,20.1,86.2,90,0
    .goto Alterac Mountains,17.9,83.0,90,0
    .goto Alterac Mountains,10.7,76.6,90,0
    .goto Alterac Mountains,19.4,75.6,90,0
    .goto Alterac Mountains,20.1,86.2,90,0
    .goto Alterac Mountains,17.9,83.0,90,0
    .goto Alterac Mountains,10.7,76.6,90,0
    .goto Alterac Mountains,19.4,75.6
	>>Kill the Dalaran mobs. Loot them for Worn Stone Tokens
    .complete 556,1 --Collect Worn Stone Token (x10)
step
	>>Go to the Yeti cave. Click the Brazier (it has quite a high range)
	.goto Alterac Mountains,37.5,66.3
	.complete 553,3 --Collect Flame of Uzel charged (x1)
    #softcore
step
	>>Run back into the yeti cave and charge the flames.
.goto Hillsbrad Foothills,46.2,31.8,30,0
    .goto Hillsbrad Foothills,43.9,28.1
    .complete 553,1 --Collect Flame of Azel charged (x1)   
    #softcore
step
    >>Drop down to the lower floor, and go through the north side of the cave. Charge the flame
	.goto Hillsbrad Foothills,44.7,28.6,20,0
    .goto Hillsbrad Foothills,44.2,26.7
    .complete 553,2 --Collect Flame of Veraz charged (x1)
    #softcore
step
	>>Kill Syndicates and loot them around the camps until the Missive drops.
    .goto Alterac Mountains,47.7,81.7,90,0
    .goto Alterac Mountains,58.4,67.7,90,0
    .goto Alterac Mountains,47.7,81.7,90,0
    .goto Alterac Mountains,58.4,67.7,90,0
    .goto Alterac Mountains,47.7,81.7
    .complete 533,1 --Collect Syndicate Missive (x1)
step
    .goto Hillsbrad Foothills,61.5,20.9
    .turnin 544 >> Turn in Prison Break In
    .turnin 556 >> Turn in Stone Tokens
step
    .goto Hillsbrad Foothills,62.1,19.7
    .turnin 546 >> Turn in Souvenirs of Death
step
    .goto Hillsbrad Foothills,62.3,20.3
    .turnin 539 >> Turn in Battle of Hillsbrad
    .turnin 567 >> Turn in Dangerous!
step
    .goto Hillsbrad Foothills,63.3,20.7
    .turnin 533 >> Turn in Infiltration
step << Hunter
    .goto Hillsbrad Foothills,62.55,19.91
	.vendor >> Go to Kayren. Buy arrows until your quiver is full
step
    .goto Hillsbrad Foothills,62.79,19.02
	.vendor >> Go into the Inn. Buy food/water if needed
step
    #softcore
    .goto Hillsbrad Foothills,52.9,53.4
    .turnin 553 >> Turn in Helcular's Revenge
step
    >>Loot the white mushrooms around the farm
	.goto Hillsbrad Foothills,64.7,61.4
    .complete 509,1 --Collect Mudsnout Blossoms (x6)
step
    .goto Arathi Highlands,20.19,29.54
	.zone Arathi Highlands >> Head to Arathi Highlands
step
	>>Kill Ogres in and around the Ogre Mound
    .goto Hillsbrad Foothills,83.09,58.18,90,0
    .goto Arathi Highlands,33.90,44.60
    .complete 676,1
    .complete 676,2
step
    .goto Arathi Highlands,54.20,38.20
     >> Kill Marcel. Loot him for his head
	>> Be careful as he Shield Walls (reduced damage taken) after a few seconds
    .complete 1164,2
step << Rogue/Warrior/Shaman
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful
    #hardcore
step
    .goto Arathi Highlands,56.40,36.10
     >> Kill Kenata. Loot her for her head
    .complete 1164,1
step
    .goto Arathi Highlands,56.50,38.70
     >> Kill Fardel. Loot him for his head
	>> Be careful as he thrashes and has high-damage poison
    .complete 1164,3
step
    .goto Arathi Highlands,62.50,33.80
    .accept 642 >> Accept The Princess Trapped
step
	>>Run to Hammerfall
    .goto Arathi Highlands,73.10,32.70
    .fp >> Get the Hammerfall Flight Path
step
    .goto Arathi Highlands,74.20,33.90
    .turnin 676 >> Turn in The Hammer May Fall
    .accept 677 >> Accept Call to Arms
step
    .goto Arathi Highlands,72.90,34.20
    .accept 655 >> Accept Hammerfall
step
    .goto Arathi Highlands,74.60,36.30
    .turnin 655 >> Turn in Hammerfall
    .accept 672 >> Accept Raising Spirits
    .accept 671 >> Accept Foul Magics
step
	#sticky
	#completewith next
	+Keep an eye out for Nimar the Slayer (rare). He can drop really good BoEs
	.unitscan Nimar the Slayer
step
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful
    #hardcore
step
    .goto Arathi Highlands,71.7,60.3,90,0
    .goto Arathi Highlands,73.4,65.2,90,0
    .goto Arathi Highlands,70.6,69.3,90,0
    .goto Arathi Highlands,68.3,74.5,90,0
    .goto Arathi Highlands,66.2,69.2,90,0
    .goto Arathi Highlands,64.8,73.1,90,0
    .goto Arathi Highlands,61.3,72.4,90,0
    .goto Arathi Highlands,63.3,67.7,90,0
    .goto Arathi Highlands,66.5,63.7,90,0
    .goto Arathi Highlands,71.7,60.3
	>>Kill Witherbark Trolls in the area
    .complete 677,3 --Kill Witherbark Witch Doctor (x8)
    .complete 677,2 --Kill Witherbark Headhunter (x10)
	.complete 677,1 --Kill Witherbark Axe Thrower (x10)
step
	#completewith xpgate
	>>Kill Raptors whenever you see them. Loot them for their Eyes. Be careful as the Thrashers thrash
	.complete 672,1 --Collect Highland Raptor Eye (x10)	
step
    >>Kill Syndicates in the area. Loot them for their Amulets and Silk Cloth
	.goto Arathi Highlands,33.8,31.8
    .complete 671,1 --Collect Bloodstone Amulet (x10)
	.collect 4306,15 -- Silk Cloth (15)
step
	#label xpgate
    .goto Arathi Highlands,33.8,31.8
	.xp 33>> Grind to level 33
	#era
step
	#label xpgate
    .goto Arathi Highlands,33.8,31.8
	.xp 32+10000 >> Grind to level 32 and 10000+/54500xp
	#som
step
    .goto Arathi Highlands,37.1,29.3,90,0
    .goto Arathi Highlands,36.4,37.3,90,0
    .goto Arathi Highlands,40.6,39.0,90,0
    .goto Arathi Highlands,42.1,30.5,90,0
    .goto Arathi Highlands,45.7,36.1,90,0
    .goto Arathi Highlands,37.7,51.1
	>>Finish killing Raptors and looting them for their Eyes
	.complete 672,1 --Collect Highland Raptor Eye (x10)
step
    .goto Arathi Highlands,74.3,33.9
    .turnin 677 >> Turn in Call to Arms
step
    .goto Arathi Highlands,74.7,36.4
    .turnin 672 >> Turn in Raising Spirits
    .accept 674 >> Accept Raising Spirits
    .turnin 671 >> Turn in Foul Magics
step
    .goto Arathi Highlands,72.6,33.9
    .turnin 674 >> Turn in Raising Spirits
step
    .goto Arathi Highlands,72.8,34.1
    .accept 675 >> Accept Raising Spirits
step
    .goto Arathi Highlands,74.7,36.3
    .turnin 675 >> Turn in Raising Spirits
step
    .goto Arathi Highlands,73.0,32.5
    .fly Tarren Mill >> Fly to Tarren Mill
step
    .goto Hillsbrad Foothills,61.50,19.20
    .turnin 509 >> Turn in Elixir of Agony
    .accept 513 >> Accept Elixir of Agony
step
    .fly Undercity >> Fly to Undercity
step
    .goto Undercity,48.60,69.60
    .turnin 513 >> Turn in Elixir of Agony
step
    .goto Undercity,64.20,49.60
    .turnin 1164 >> Turn In To Steal From Thieves
step << Priest
    .goto Undercity,47.6,18.9
.trainer >> Go and train your class spells
step << Warrior
    .goto Undercity,48.3,15.9
.trainer >> Go and train your class spells
step << Mage
    .goto Undercity,56.3,16.3
.trainer >> Go and train your class spells
step << Warlock
    .goto Undercity,88.9,15.9
.trainer >> Go and train your class spells
step << Rogue
    .goto Undercity,85.2,71.5
.trainer >> Go and train your class spells
step << Druid
	>> Use the spell Teleport to Moonglade
    .goto Moonglade,52.5,40.5
	.trainer >> Go and train your class spells
step
    .hs >> Hearth back to Freewind Post
	>> Buy food/water if needed
]])

RXPGuides.RegisterGuide("RestedXP Horde 30-40",[[
#classic
<< Horde

#name 33-34 Shimmering Flats
#next 34-35 Desolace
#somname 32-33 Shimmering Flats

step
    .goto Thousand Needles,45.70,50.70
    .accept 5361 >> Accept Family Tree
step << Hunter
    .goto Thousand Needles,44.89,50.69
	.vendor >> Go to Starn. Buy arrows until your quiver is full
step << Shaman
   #sticky
	#completewith next
	 .goto Thousand Needles,54.7,44.4,30 >> Run up the ramp here
step << Shaman
	>>Turning this in gives you a 40% movespeed, 30% attack speed buff for 1 hour
	.goto Thousand Needles,53.5,42.7
    .turnin 1531 >>Turn in Call of Air
step
    .goto Thousand Needles,67.6,64.0
    .turnin 1146 >> Turn in The Swarm Grows
    .accept 1147 >> Accept The Swarm Grows
step
	#sticky
	#label CarParts
	.accept 1110 >> Accept Rocket Car Parts
step
    .goto Thousand Needles,77.8,77.2
    .turnin 1112 >> Turn in Parts for Kravel
step
	#requires CarParts
    .goto Thousand Needles,78.1,77.1
    .accept 1105 >> Accept Hardened Shells
step
	#sticky
	#label SaltVenom
	.accept 1104 >> Accept Salt Flat Venom
step
    .goto Thousand Needles,77.9,77.2
    .accept 1114 >> Accept Delivery to the Gnomes
    .turnin 1114 >> Turn in Delivery to the Gnomes
    .accept 1115 >> Accept The Rumormonger
step
	#requires SaltVenom
    .goto Thousand Needles,80.2,75.8
    .accept 1176 >> Accept Load Lightening
step
    .goto Thousand Needles,81.7,78.0
    .accept 1175 >> Accept A Bump in the Road
step
	#completewith next
	>>Collect some of the Rocket Car Parts found on the ground
	.complete 1110,1 --Collect Rocket Car Parts (x30)
step
	#completewith next
	>>Kill Crystalhides that you see. You can finish this later
	.complete 1175,2 --Kill Saltstone Crystalhide (x10)
step
   	>>Kill Gazers in the area
	.goto Thousand Needles,78.4,89.1
	.complete 1175,3 --Kill Saltstone Gazer (x6)
step
	#sticky
	#label Swarm
	>>Grind the Silithid creatures until you get a Cracked Silithid Carapace. Click it to accept a quest.
	.collect 5877,1
	.accept 1148 >> Accept Parts of the Swarm
step
    .goto Thousand Needles,67.8,85.7
	.complete 1148,1 --Collect Silithid Heart (x1)
    .complete 1148,2 --Collect Silithid Talon (x5)
    .complete 1147,3 --Kill Silithid Invader (x5)	
    .complete 1147,1 --Kill Silithid Searcher (x5)
    .complete 1148,3 --Collect Intact Silithid Carapace (x3)
    .complete 1147,2 --Kill Silithid Hive Drone (x5)
step
	#label ShimmeringF
	#requires Swarm
	>>Circle the area, killing and collecting for the Shimmering Flats quests
	.complete 1110,1 --Collect Rocket Car Parts (x30)
	.complete 1104,1 --Collect Salty Scorpid Venom (x6)
	.complete 1176,1 --Collect Hollow Vulture Bone (x10)
    .complete 1105,1 --Collect Hardened Tortoise Shell (x9)
	.complete 1175,1 --Kill Saltstone Basilisk (x10)
	.complete 1175,2 --Kill Saltstone Crystalhide (x10)	
step
    .goto Thousand Needles,67.6,63.9
    .turnin 1147 >> Turn in The Swarm Grows
step
    .goto Thousand Needles,77.8,77.2
    .turnin 1110 >> Turn in Rocket Car Parts
	.accept 5762 >> Accept Hemet Nesingwary
step
    .goto Thousand Needles,78.0,77.1
    .turnin 1104 >> Turn in Salt Flat Venom
    .turnin 1105 >> Turn in Hardened Shells
    .accept 1106 >> Accept Martek the Exiled
step
    .goto Thousand Needles,80.2,75.8
    .turnin 1176 >> Turn in Load Lightening
    .accept 1178 >> Accept Goblin Sponsorship
step
    .goto Thousand Needles,81.6,78.0
    .turnin 1175 >> Turn in A Bump in the Road
step
    .goto Tanaris,51.6,25.5
    .fly Camp Taurajo >> Fly to Camp Taurajo
step
    .goto The Barrens,45.60,59.0
    .home >>Set your Hearthstone to Camp Taurajo
step
   .goto The Barrens,44.45,59.15
    .fly Crossroads >> Fly to The Crossroads
step
    .goto The Barrens,51.10,29.60
    .turnin 1148 >> Turn in Parts of the Swarm
    .accept 1184 >> Accept Parts of the Swarm
step
    .goto The Barrens,51.5,30.3
    .fly Ratchet >> Fly to Ratchet
step
   .goto The Barrens,62.68,37.42
    .bankdeposit 4306 >> Deposit the 15 Silk Cloth from earlier into your bank: 
    >>Silk Cloth (15)
step
    .goto The Barrens,62.70,36.30
    .turnin 1178 >> Turn in Goblin Sponsorship
    .accept 1180 >> Accept Goblin Sponsorship
step
    .goto The Barrens,63.30,38.50
    .turnin 1111 >> Turn in Wharfmaster Dizzywig
    .accept 1112 >> Accept Parts for Kravel
step
     #completewith next
    .goto The Barrens,63.74,38.66
     .zone Stranglethorn Vale >> Take the boat to Stranglethorn Vale
step
    .goto Stranglethorn Vale,26.30,73.50
    .turnin 1180 >> Turn in Goblin Sponsorship
    .accept 1181 >> Accept Goblin Sponsorship
step << Warrior/Shaman
	#sticky
	#label Protection
	#completewith BigStick
 .goto Stranglethorn Vale,28.3,75.5
    .vendor >> Go to the vendor and buy Staff of Protection or Big Stick if it's in the shop.
    .collect 12252,1
step << Warrior/Shaman
	#sticky
	#label BigStick
	#completewith Protection 
 .goto Stranglethorn Vale,28.3,75.5
    .collect 12251,1
step
	>>Bottom floor of the Inn
    .goto Stranglethorn Vale,27.10,77.30
    .accept 605 >> Accept Singing Blue Shards
step << Rogue
	>>Go to the first room of the second floor of the Inn. Talk to Ian
    .goto Stranglethorn Vale,26.8,77.2
	.trainer >> Go and train your class spells
step
	>>Go to the third floor of the Inn
    .goto Stranglethorn Vale,26.94,77.20
    .accept 201 >> Accept Investigate the Camp
    .turnin 1115 >> Turn in The Rumormonger
--    .accept 1116 >> Accept Dream Dust in the Swamp
    .accept 189 >> Accept Bloodscalp Ears
    .accept 213 >> Accept Hostile Takeover
step
	>>Exit the third floor toward Baron Revilgaz
    .goto Stranglethorn Vale,27.20,76.90
    .turnin 1181 >> Turn in Goblin Sponsorship
    .accept 1182 >> Accept Goblin Sponsorship
step
	>>Stay on the balcony. Go to the small pathway that Seahorn is facing
    .goto Stranglethorn Vale,26.90,77.10
    .fp >> Get the Booty Bay Flight Path
step
	>>Inside the Leatherworks shop
    .goto Stranglethorn Vale,28.30,77.60
    .accept 575 >> Accept Supply and Demand
step
    .hs >> Hearth back to Camp Taurajo
	>> Buy food/water if needed
step
   .goto The Barrens,44.45,59.15
    .fly Thunder Bluff >> Fly to Thunder Bluff
step
    .goto Thunder Bluff,45.8,64.60
    .home >>Set your Hearthstone to Thunder Bluff
step << Druid
    .goto Thunder Bluff,77.0,29.9
	.trainer >> Go and train your class spells
step << Hunter
    .goto Thunder Bluff,59.1,86.9
	.trainer >> Go and train your class spells
step << Hunter
    .goto Thunder Bluff,54.1,83.9
	.trainer >> Go and train your pet spells
step << Warrior
    .goto Thunder Bluff,57.6,85.5
	.trainer >> Go and train your class spells
step << Shaman
    .goto Thunder Bluff,22.8,21.0
	.trainer >> Go and train your class spells
step << Priest
    .goto Thunder Bluff,24.6,22.6
	.trainer >> Go and train your class spells
step << Mage
    .goto Thunder Bluff,25.2,20.9
	.trainer >> Go and train your class spells
step << Mage
    .goto Thunder Bluff,22.49,16.90
	.trainer >> Go to Birgitte. Train Portal: Thunder Bluff
step
    .goto Thunder Bluff,46.9,49.9
    .fly Sun Rock >> Fly to Stonetalon Mountains
]])

RXPGuides.RegisterGuide("RestedXP Horde 30-40",[[
#classic
<< Horde

#name 34-35 Desolace
#next 35-37 Northern Stranglethorn
#somname 33-35 Desolace

step
    .goto Stonetalon Mountains,46.00,60.50
    .turnin 1088 >> Turn in Ordanus
	#era
step
    .goto Stonetalon Mountains,44.63,61.55,60,0
    .goto Stonetalon Mountains,38.77,68.65,60,0
    .goto Stonetalon Mountains,30.22,75.61,60,0
    .goto Stonetalon Mountains,29.29,79.69
	.zone Desolace >> Walk west into where the Harpies are and go south into Desolace.
step
    .goto Desolace,55.80,30.10
    >>Grind Burning Blade mobs until you get a Flayed Demon Skin
	.collect 20310,1,1480
    .accept 1480 >> Accept The Corrupter
step
    .goto Desolace,38.90,27.20
    .accept 5741 >> Accept Sceptre of Light
step
	#era
    .goto Desolace,56.20,59.60
    .accept 1365 >> Accept Khan Dez'hepah
    .accept 1368 >> Accept Gelkis Alliance
step
	#som
    .goto Desolace,56.20,59.60
    .accept 1365 >> Accept Khan Dez'hepah
step
    .goto Desolace,55.40,55.70
    .turnin 5361 >> Turn in Family Tree
step
    .goto Desolace,52.60,54.40
    .turnin 1432 >> Turn in Alliance Relations
    .accept 1433 >> Accept Alliance Relations
    .accept 1434 >> Accept Befouled by Satyr
step
    .goto Desolace,52.20,53.50
    .turnin 1433 >> Turn in Alliance Relations
    .accept 1435 >> Accept The Burning of Spirits
    .turnin 1480 >> Turn in The Corrupter
    .accept 1481 >> Accept The Corrupter
step
    .goto Desolace,73.20,41.80,60,0
    .goto Desolace,73.00,46.80,60,0
    .goto Desolace,74.80,48.80,60,0
    .goto Desolace,73.20,41.80,0
    .goto Desolace,73.00,46.80,0
    .goto Desolace,74.80,48.80
     >> Kill Khan Dez'hepah, he has 3 different spawn locations
    .complete 1365,1
    .unitscan Khan Dez'hepah
step
	#sticky
	#label shadowstalkers
    .goto Desolace,76.70,19.40,0
     >> Kill Shadowstalkers. Loot them for their scalp
    .complete 1481,1
step
    .goto Desolace,76.70,19.40
     >> Prioritize Hatefury Rogues
    .complete 1434,1
    .complete 1434,2
    .complete 1434,3
    .complete 1434,4
    .unitscan Hatefury Rogue
step
	#requires shadowstalkers
    .goto Desolace,62.30,39.00
    .accept 5501 >> Accept Bone Collector
step
	>>Run back to Ghost Walker Post
    .goto Desolace,52.60,54.40
    .turnin 1434 >> Turn in Befouled by Satyr
step
    .goto Desolace,52.20,53.40
    .turnin 1481 >> Turn in The Corrupter
    .accept 1482 >> Accept The Corrupter
step
    .goto Desolace,51.20,53.27
	>> Buy food/water if needed
step
    .goto Desolace,56.20,59.50
    .turnin 1365 >> Turn in Khan Dez'hepah
    .accept 1366 >> Accept Centaur Bounty
step
    .goto Desolace,60.80,61.90
    .accept 5561 >> Accept Kodo Roundup
step
	#era
    .goto Desolace,69.90,75.10
     >> Kill Centaurs. Loot them for their Ears
    .complete 1366,1
step
	#era
    .goto Desolace,69.90,75.10
     >> Grind Centaurs until you are friendly with the Gelkis Centaur
    .reputation 92,Friendly
step
	#era
    .goto Desolace,56.20,59.60
    .turnin 1366 >> Turn in Centaur Bounty
step
    #completewith next
    .goto Desolace,49.7,57.2,0
    >>Loot the Kodo Bones around the graveyard. Be careful as mobs can spawn from them
    .complete 5501,1
step
    .goto Desolace,60.86,61.86,0
    >>Head towards the Kodo Graveyard and use the Kodo Kombobulator in your inventory to escort a Kodo back to the quest giver
    >>Be on the lookout for the Kodos that patrol the zone
    .complete 5561,1
step
    .goto Desolace,49.7,57.2
    >>Loot the Kodo Bones around the graveyard. Be careful as mobs can spawn from them
    .complete 5501,1
step
    .goto Desolace,60.80,61.90
    .turnin 5561 >> Turn in Kodo Roundup
step
	#era
    .goto Desolace,36.30,79.20
    .turnin 1368 >> Turn in Gelkis Alliance
    .accept 1370 >> Accept Stealing Supplies
step
	>>Run to Shadowprey Village
    .goto Desolace,26.16,74.57,50,0
    .goto Desolace,25.10,72.20
    .accept 5763 >> Accept Hunting in Stranglethorn
step << Hunter
    .goto Desolace,24.93,71.84
    .vendor >> Go to Tukk. Buy arrows until your quiver is full.
step
    .goto Desolace,25.80,68.20
    .accept 5381 >> Accept Hand of Iruxos
step
    .goto Desolace,22.70,72.10
    .accept 6142 >> Accept Clam Bait
step
    .goto Desolace,23.30,72.90
    .accept 6143 >> Accept Other Fish to Fry
step
	>>Run to the end of the dock
    .goto Desolace,21.60,74.14
	.fp >> Get the Shadowprey Village Flight Path
step
	    .goto Desolace,47.80,61.8
	.accept 6134 >> Accept Ghost-o-plasm Round Up
	#era
step
	#som
    .goto Desolace,73.33,47.94
     >> Run to the Kolkar Village. Kill Centaurs. Loot them for their Ears
    .complete 1366,1
step
	#som
    .goto Desolace,73.33,47.94
	.xp 34+17500 >> Grind to 34 and 17500+/62800
step
    .goto Desolace,62.30,39.00
    .turnin 5501 >> Turn in Bone Collector
step
	#label infused
    #sticky
     >> Kill Burning Blade mobs using the Burning Gem
    .complete 1435,1
step
    .goto Desolace,55.20,30.10
     >> Kill the Seer at the top of the tower
    .complete 5741,1
step
    .goto Desolace,54.90,26.70
     >> Go into the main building. Use the Demon Pick on the crystal in the circle
	>> A level 37 demon will spawn. Kill it
    .complete 5381,1
step
	#requires infused
    .goto Desolace,38.90,27.10
    .turnin 5741 >> Turn in Sceptre of Light
    .accept 6027 >> Accept Book of the Ancients
step
    .goto Desolace,36.00,30.40
	>>Click the book on the ground
    .accept 6161 >> Accept Claim Rackmore's Treasure!
step
	#label oracledeso
    #completewith Nagas
    .goto Desolace,36.88,23.16,0
     >> Kill Slitherblade Oracles. Loot them for the crystal
	>> They share spawns with other Nagas, so you may have to kill them
    .complete 1482,1
step
	#label desogoldenkey
    #sticky
    .goto Desolace,36.88,23.16,0
     >> Kill Nagas. Loot them for the Golden Key
    .complete 6161,2
step
	#label clambait
    #sticky
    .goto Desolace,33.09,29.79,0
     >> Look for clams underwater. Loot them for the Meat
    .complete 6142,1
step
    .goto Desolace,32.40,29.20
     >> Kill Mak'kura. Loot them for the Silver Key.
    .complete 6161,1
step
	#completewith Rackmore
    .goto Desolace,36.88,23.16,0
     >> Kill the Naga in the area
    .complete 6143,1
    .complete 6143,2
    .complete 6143,3
step	
	.isQuestComplete 6161
    .goto Desolace,30.00,8.80
    .turnin 6161 >> Turn in Claim Rackmore's Treasure!
step
    .goto Desolace,28.20,6.60
	>> Clear the mobs out that are around the statue
     >> Click on the statue. Kill the level 38 naga that spawns
    .complete 6027,1
step	
	#label Rackmore
	#requires desogoldenkey
    .goto Desolace,30.00,8.80
    .turnin 6161 >> Turn in Claim Rackmore's Treasure!
step
	#label Nagas
    .goto Desolace,36.88,23.16 
     >> Kill the Naga in the area
    .complete 6143,1
    .complete 6143,2
    .complete 6143,3
step
    .goto Desolace,28.69,8.05
     >> Kill Slitherblade Oracles. Loot them for the crystal
	>> They share spawns with other Nagas, so you may have to kill them
    .complete 1482,1
	.unitscan Slitherblade Oracles
step
	#requires clambait
    .goto Desolace,38.88,27.16
    .turnin 6027 >> Turn in Book of the Ancients
step
    .goto Desolace,52.24,53.44
    .turnin 1435 >> Turn in The Burning of Spirits
    .turnin 1482 >> Turn in The Corrupter
step
	#som
    .goto Desolace,56.20,59.60
    .turnin 1366 >> Turn in Centaur Bounty
step
    .goto Desolace,52.56,54.38
    .accept 1436 >> Accept Alliance Relations
    .accept 1484 >> Accept The Corrupter
step
	#era
    .goto Desolace,69.90,75.10
     >> Collect Crudely Dried Meat (x6)
    .complete 1370,1
step
	#era
    .goto Desolace,36.21,79.24
    .turnin 1370 >> Turn in Stealing Supplies
    .accept 1373 >> Accept Ongeku
step <<  Hunter
    .goto Desolace,24.90,68.66
     >> Stable your pet, tame a Scorpashi Lasher, learn Claw 5
step
    .goto Desolace,25.80,68.20
    .turnin 5381 >> Turn in Hand of Iruxos
step
    .goto Desolace,23.40,72.80
    .turnin 6143 >> Turn in Other Fish to Fry
step
    .goto Desolace,22.70,72.10
    .turnin 6142 >> Turn in Clam Bait
step
    .goto Desolace,42.78,70.12
	.xp 35 >> Grind to 35
step << Druid
    #sticky
    #completewith next
	>> Use the spell Teleport to Moonglade
    .goto Moonglade,52.5,40.5
.trainer >> Go and train your class spells
step
    .hs >> Hearth back to Thunder Bluff
	>> Buy food/water if needed
step << Warrior
	#softcore
	>>Go to the Auction House. Buy 8 Liferoot
    .goto Thunder Bluff,40.42,51.74
      .collect 3357,8
step
    .goto Thunder Bluff,61.4,81.0
    .accept 1136 >> Accept Frostmaw
    .accept 1205 >> Accept Deadmire
step << Hunter
    .goto Thunder Bluff,59.1,86.9
	.trainer >> Go and train your class spells
step << Hunter
    .goto Thunder Bluff,54.1,83.9
	.trainer >> Go and train your pet spells
step << Warrior
    .goto Thunder Bluff,57.6,85.5
	.trainer >> Go and train your class spells
step << Shaman
    .goto Thunder Bluff,46.9,49.9
    .fly Ratchet >>Fly to Ratchet
step << Shaman
	#completewith next
    .goto The Barrens,62.05,39.41
	.home >> Set your Hearthstone to Ratchet
step << Shaman
    .goto The Barrens,65.8,43.8
    .turnin 96 >>Turn in Call of Water
step << Shaman
	#completewith next
    .goto The Barrens,62.05,39.41
	.hs >> Hearth to Ratchet
>> Buy food/water if needed
step << !Mage
    .goto Thunder Bluff,46.9,49.9 << !Shaman
    .goto The Barrens,63.08,37.16 << Shaman
    .fly Orgrimmar >> Fly to Orgrimmar
step << Mage
	.zone Orgrimmar >> Teleport to Orgrimmar
step << Shaman
    .goto Orgrimmar,38.6,36.0
	.trainer >> Go and train your class spells
step << Rogue
    .goto Orgrimmar,44.0,54.6
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,48.0,46.0
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,47.5,46.7
	.vendor >> Buy your pet upgrades if you got the money for it.
step << Mage
    .goto Orgrimmar,38.8,85.6
	.trainer >> Go and train your class spells
step << Priest
    .goto Orgrimmar,35.6,87.8
	.trainer >> Go and train your class spells
step
    .goto Orgrimmar,22.40,52.80
    .turnin 1436 >> Turn in Alliance Relations
step
    .goto Orgrimmar,75.20,34.30
    .turnin 1184 >> Turn in Parts of the Swarm
step
    .goto Orgrimmar,54.1,68.4
    .home >> Set your Hearthstone to Orgrimmar
step
	#completewith next
   .goto Durotar,45.53,11.79,60 >> Run out of Orgrimmar
step
	>>Run up the Zeppelin Tower outside of Orgrimmar
    .goto Durotar,50.53,12.52
    .zone Stranglethorn Vale >> Take the Zeppelin to Stranglethorn Vale
]])

RXPGuides.RegisterGuide("RestedXP Horde 30-40",[[
#classic
<< Horde

#name 35-37 Northern Stranglethorn
#next 37-38 Dustwallow Marsh

step
    .goto Stranglethorn Vale,32.10,29.20
    .accept 570 >> Accept Mok'thardin's Enchantment
step
    .goto Stranglethorn Vale,32.20,28.90
    .accept 568 >> Accept The Defense of Grom'gol
step
    .goto Stranglethorn Vale,32.20,27.80
    .accept 596 >> Accept Bloody Bone Necklaces
    .accept 629 >> Accept The Vile Reef
step
    .goto Stranglethorn Vale,32.20,27.80
    .accept 581 >> Accept Hunt for Yenniku
step
    .goto Stranglethorn Vale,35.66,10.52
    .turnin 5762 >> Turn in Hemet Nesingwary
    .turnin 5763 >> Turn in Hunting in Stranglethorn
    .accept 583 >> Accept Welcome to the Jungle
    .turnin 583 >> Turn in Welcome to the Jungle
    .accept 194 >> Accept Raptor Mastery
    .accept 185 >> Accept Tiger Mastery
    .accept 190 >> Accept Panther Mastery
step
	#sticky
	#completewith YoungTigers
	>>Kill Crocolisks along the river. Loot them for their Skin
    .goto Stranglethorn Vale,37.0,9.9,90,0
    .goto Stranglethorn Vale,39.9,11.8,90,0
    .goto Stranglethorn Vale,40.9,14.5
    .complete 575,1 --Collect Large River Crocolisk Skin (x2)	
step
    .goto Stranglethorn Vale,43.0,13.4,90,0
    .goto Stranglethorn Vale,42.2,9.4,90,0
    .goto Stranglethorn Vale,40.2,10.4,90,0
    .goto Stranglethorn Vale,41.3,8.1,90,0
    .goto Stranglethorn Vale,43.0,13.4
	>>Kill all the Panthers you see
    .complete 190,1 --Kill Young Panther (x10)
step << Warrior
	#softcore
    .goto Stranglethorn Vale,44.52,9.99
	>>If you haven't collected enough Liferoot yet, Go to the Kurzen Compound. Grind Medicine Men for Liferoot
	>>Note that Jungle Fighters and Medicine Men share spawns, so you'll have to kill both
      .collect 3357,8
step << Warrior
	#hardcore
    .goto Stranglethorn Vale,44.52,9.99
	>>Go to the Kurzen Compound. Grind Medicine Men for Liferoot
	>>Note that Jungle Fighters and Medicine Men share spawns, so you'll have to kill both
      .collect 3357,8
step
   #label YoungTigers
	.goto Stranglethorn Vale,35.7,12.3,90,0
    .goto Stranglethorn Vale,34.0,11.7,90,0
    .goto Stranglethorn Vale,30.7,7.5,90,0
    .goto Stranglethorn Vale,35.7,12.3,90,0
    .goto Stranglethorn Vale,34.0,11.7,90,0
    .goto Stranglethorn Vale,30.7,7.5,90,0
    .goto Stranglethorn Vale,35.7,12.3
    .complete 185,1 --Kill Young Stranglethorn Tiger (x10)
step
    #sticky
	#completewith next
	.goto Stranglethorn Vale,32.5,8.6,40,0
    .goto Stranglethorn Vale,35.7,10.7
	>>Kill Crocolisks along the river. Loot them for their skin
    .complete 575,1 --Collect Large River Crocolisk Skin (x2)	
step
    .goto Stranglethorn Vale,35.6,10.6
    .turnin 185 >> Turn in Tiger Mastery
    .accept 186 >> Accept Tiger Mastery
    .turnin 190 >> Turn in Panther Mastery
    .accept 191 >> Accept Panther Mastery
step	
    .goto Stranglethorn Vale,31.0,11.2,90,0
    .goto Stranglethorn Vale,29.7,8.9,90,0
    .goto Stranglethorn Vale,28.4,12.3,90,0
    .goto Stranglethorn Vale,28.8,13.6,90,0
    .goto Stranglethorn Vale,28.5,16.9,90,0
    .goto Stranglethorn Vale,30.6,13.9,90,0
    .goto Stranglethorn Vale,31.0,11.2
   >>Kill Panthers and Tigers in the area
    .complete 191,1 --Kill Panther (x10)
    .complete 186,1 --Kill Stranglethorn Tiger (x10)
step
    .goto Stranglethorn Vale,27.7,14.7,90,0
    .goto Stranglethorn Vale,26.9,17.3,90,0
    .goto Stranglethorn Vale,23.8,15.5,90,0
    .goto Stranglethorn Vale,27.7,14.7,90,0
    .goto Stranglethorn Vale,26.9,17.3,90,0
    .goto Stranglethorn Vale,23.8,15.5
     >>Kill Raptors in the area
    .complete 194,1 --Kill Stranglethorn Raptor (x10)
step
    .goto Stranglethorn Vale,35.6,10.5
    .turnin 191 >> Turn in Panther Mastery
    .accept 192 >> Accept Panther Mastery
    .turnin 186 >> Turn in Tiger Mastery
    .accept 187 >> Accept Tiger Mastery
    .turnin 194 >> Turn in Raptor Mastery
    .accept 195 >> Accept Raptor Mastery
step
	#sticky
	#completewith BloodscalpTr
	>>Kill Stranglethorn Tigers en route to other objectives
    .complete 187,1 --Kill Elder Stranglethorn Tiger (x10)
step
    #label BloodscalpTr
	>>Kill Trolls. Loot them for their tusks
    .goto Stranglethorn Vale,33.9,15.6,90,0
    .goto Stranglethorn Vale,33.2,13.7,90,0
    .goto Stranglethorn Vale,28.8,19.6,90,0
    .goto Stranglethorn Vale,29.8,19.4,90,0
    .goto Stranglethorn Vale,30.6,18.9,90,0
    .goto Stranglethorn Vale,33.9,15.6
	>> Kill Bloodscalp Trolls. Loot them for their Tusks
	.complete 581,1 --Collect Bloodscalp Tusk (x9)
step
    .goto Stranglethorn Vale,32.1,15.8,90,0
    .goto Stranglethorn Vale,31.4,18.4,90,0
    .goto Stranglethorn Vale,31.8,20.0,90,0
    .goto Stranglethorn Vale,34.2,17.6,90,0
    .goto Stranglethorn Vale,32.1,15.8
	>>Finish killing Stranglethorn Tigers
    .complete 187,1 --Kill Elder Stranglethorn Tiger (x10)
step
    .goto Stranglethorn Vale,31.9,20.9,90,0
    .goto Stranglethorn Vale,30.4,24.7,90,0
    .goto Stranglethorn Vale,32.5,23.4,90,0
    .goto Stranglethorn Vale,34.1,25.5,90,0
    .goto Stranglethorn Vale,36.0,26.8,90,0
    .goto Stranglethorn Vale,38.9,25.1,90,0
    .goto Stranglethorn Vale,38.1,28.1,90,0
    .goto Stranglethorn Vale,31.9,20.9
    >>Kill Lashtail Raptors. Be careful as they stun and disarm
    .complete 568,1 --Kill Lashtail Raptor (x15)
step
    .goto Stranglethorn Vale,32.2,27.8
    .turnin 581 >> Turn in Hunt for Yenniku
    .accept 582 >> Accept Headhunting
step
    .goto Stranglethorn Vale,32.2,28.9
    .turnin 568 >> Turn in The Defense of Grom'gol
    .accept 569 >> Accept The Defense of Grom'gol
step << Hunter
    .goto Stranglethorn Vale,31.55,27.95
	.vendor >> Go to Uthok. Buy arrows until your quiver is full.
step << Hunter
	#level 36
    .goto Stranglethorn Vale,31.23,28.68
	.trainer >> Train your class spells
step
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful from breath and not pulling elites.
    #hardcore
step
    .goto Stranglethorn Vale,24.8,22.9
	>>Loot the tablet against the wall in the water
    .complete 629,1 --Collect Tablet Shard (x1)
step
	>>Kill Basilisks for Singing Crystal Shards.
    .goto Stranglethorn Vale,23.2,17.7,90,0
    .goto Stranglethorn Vale,24.6,17.9,90,0
    .goto Stranglethorn Vale,23.7,16.8,90,0
    .goto Stranglethorn Vale,27.4,18.6,90,0
    .goto Stranglethorn Vale,23.2,17.7,90,0
    .goto Stranglethorn Vale,24.6,17.9,90,0
    .goto Stranglethorn Vale,23.7,16.8,90,0
    .goto Stranglethorn Vale,27.4,18.6
	>>Kill Basilisks. Loot them for their Shards. You have to go back and forth here forcing dynamic respawns
    .complete 605,1 --Collect Singing Crystal Shard (x10)
step
    .goto Stranglethorn Vale,20.7,14.1,90,0
    .goto Stranglethorn Vale,20.2,12.1,90,0
    .goto Stranglethorn Vale,21.4,10.2,90,0
    .goto Stranglethorn Vale,20.7,14.1,90,0
    .goto Stranglethorn Vale,20.2,12.1,90,0
    .goto Stranglethorn Vale,21.4,10.2
    >>Grind trolls in the area. Loot them for objectives. Heads only drop from Headhunters, Ears and Necklaces from all trolls
    .complete 189,1 --Collect Bloodscalp Ear (x15)
    .complete 582,1 --Collect Shrunken Head (x20)
    .complete 596,1 --Collect Bloody Bone Necklace (x25)
step << Warrior
    .goto Stranglethorn Vale,20.7,14.1,90,0
    .goto Stranglethorn Vale,20.2,12.1,90,0
    .goto Stranglethorn Vale,21.4,10.2,90,0
    .goto Stranglethorn Vale,20.7,14.1
    >>Grind Trolls in the area. Loot them for Tusks.
    .complete 1712,2 --Bloodscalp Tusk (30)
step
    .goto Stranglethorn Vale,32.2,27.8
    .turnin 582 >> Turn in Headhunting
    .turnin 596 >> Turn in Bloody Bone Necklaces
    .turnin 629 >> Turn in The Vile Reef
step
	#sticky
	#completewith next
    .goto Stranglethorn Vale,37.3,30.9,100,0
	>>There aren't enough of each to complete this quest now. Grind a few mobs, then go to Cozzle
    .complete 569,1 --Kill Mosh'Ogg Brute (x10)
	.complete 569,2 --Kill Mosh'Ogg Witch Doctor (x5)
step
    #sticky
	#completewith CozzleBl
	>>Kill Geologists. Loot them for Tumbled Crystals en route to other objectives
    .complete 213,1 --Collect Tumbled Crystal (x8)
step
	.goto Stranglethorn Vale,42.6,18.6
	>>Run up the watchtower. Kill Foreman Cozzle and loot him for his key.
	.collect 5851,1
step
    #label CozzleBl
	.goto Stranglethorn Vale,43.3,20.3
	>>Open Cozzle's Footlocker in his house
    .complete 1182,1 --Collect Fuel Regulator Blueprints (x1)
step
    .goto Stranglethorn Vale,37.3,30.9
	>>Go back to Mizjah Ruins, finish killing the Mosh'Ogg ogres, waiting for respawns if needed
    .complete 569,1 --Kill Mosh'Ogg Brute (x10)
	.complete 569,2 --Kill Mosh'Ogg Witch Doctor (x5)
step
    .goto Stranglethorn Vale,43.8,17.3,90,0
    .goto Stranglethorn Vale,42.6,22.3,90,0
    .goto Stranglethorn Vale,46.4,23.4
	>>Kill Geologists. Loot them for Tumbled Crystals
    .complete 213,1 --Collect Tumbled Crystal (x8)
step
	#era
    .goto Stranglethorn Vale,45.2,20.5
	.xp 36+50000 >> Grind to 50000+/71600 xp
step
	#som
    .goto Stranglethorn Vale,45.2,20.5
	.xp 36+30000 >> Grind to 30000+/71600 xp
step
	#sticky
	#completewith next
    >>Kill Stranglethorn Tigresses. Loot them for a Fang
    .complete 570,2 --Collect Pristine Tigress Fang (x1)
step
    .goto Stranglethorn Vale,47.7,22.6,90,0
    .goto Stranglethorn Vale,49.6,25.4,90,0
    .goto Stranglethorn Vale,49.5,20.4,90,0
    .goto Stranglethorn Vale,47.7,22.6
    >>Kill Shadowmaw Panthers (they're stealthed). Loot them for Shadowmaw Claws. Look in spots where other mobs aren't near, specifically around trees
    .complete 570,1 --Collect Shadowmaw Claw (x8)
    .complete 192,1 --Kill Shadowmaw Panther (x10)
step
    .goto Stranglethorn Vale,47.7,22.6,90,0
    .goto Stranglethorn Vale,49.6,25.4,90,0
    .goto Stranglethorn Vale,49.5,20.4
    >>Kill Stranglethorn Tigresses. Loot them for a Fang
    .complete 570,2 --Collect Pristine Tigress Fang (x1)
step
    .goto Stranglethorn Vale,39.9,14.3,90,0
    .goto Stranglethorn Vale,39.9,11.6,90,0
    .goto Stranglethorn Vale,41.0,14.3,90,0
    .goto Stranglethorn Vale,31.9,8.4,90,0
    .goto Stranglethorn Vale,39.9,14.3
	>>Backtrack and finish killing and looting Crocolisks for their skin if you haven't gotten 2
    .complete 575,1 --Collect Large River Crocolisk Skin (x2)	
step
    .goto Stranglethorn Vale,35.6,10.8
    .turnin 195 >> Turn in Raptor Mastery
    .accept 196 >> Accept Raptor Mastery
    .turnin 187 >> Turn in Tiger Mastery
    .accept 188 >> Accept Tiger Mastery
    .turnin 192 >> Turn in Panther Mastery
    .accept 193 >> Accept Panther Mastery
step
    >>Kill Sin'Dall. Loot him for his Paw
	>>He can either be on top of the Plateau, or patrolling around it
	.goto Stranglethorn Vale,32.2,17.4
    .complete 188,1 --Collect Paw of Sin'Dall (x1)
	.unitscan Sin'Dall
step
    .goto Stranglethorn Vale,35.6,10.7
    .turnin 188 >> Turn in Tiger Mastery
step
    .goto Stranglethorn Vale,32.2,28.8
    .turnin 569 >> Turn in The Defense of Grom'gol
step
    .goto Stranglethorn Vale,32.1,29.2
    .turnin 570 >> Turn in Mok'thardin's Enchantment
    .accept 572 >> Accept Mok'thardin's Enchantment
step
    .goto Stranglethorn Vale,32.5,29.3
    .fly Booty Bay >> Fly to Booty Bay
step
    .goto Stranglethorn Vale,27.2,76.9
    .turnin 1182 >> Turn in Goblin Sponsorship
    .accept 1183 >> Accept Goblin Sponsorship
step
    .goto Stranglethorn Vale,27.0,77.2
    .turnin 189 >> Turn in Bloodscalp Ears
    .turnin 213 >> Turn in Hostile Takeover
    .turnin 201 >> Turn in Investigate the Camp
    .turnin 605 >> Turn in Singing Blue Shards
    .accept 1116 >> Accept Dream Dust in the Swamp
step
    .goto Stranglethorn Vale,28.3,77.6
    .turnin 575 >> Turn in Supply and Demand
step << Druid
	>> Use the spell Teleport to Moonglade
    .goto Moonglade,52.5,40.5
	.trainer >> Go and train your class spells
step
    #completewith next
    .hs >>Hearth to Orgrimmar
	>> Buy food/water if needed
step << Shaman
    .goto Orgrimmar,38.6,36.0
	.trainer >> Go and train your class spells
step << Hunter
    .goto Orgrimmar,66.1,18.5
	.trainer >> Go and train your class spells
step << Hunter
    .goto Orgrimmar,66.3,14.8
	.trainer >> Go and train your pet spells
step << Warrior
    .goto Orgrimmar,79.7,31.4
	.trainer >> Go and train your class spells
step << Rogue
    .goto Orgrimmar,44.0,54.6
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,48.0,46.0
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,47.5,46.7
	.vendor >> Buy Lash of pain 3
step << Mage
    .goto Orgrimmar,38.8,85.6
	.trainer >> Go and train your class spells
step << Priest
    .goto Orgrimmar,35.6,87.8
	.trainer >> Go and train your class spells
step
    .goto Orgrimmar,45.2,63.9
    .fly Camp Taurajo >>Fly to Camp Taurajo

]])

RXPGuides.RegisterGuide("RestedXP Horde 30-40",[[
#classic
<< Horde

#name 37-38 Dustwallow Marsh
#next 38-39 Alterac/Arathi

step
	#completewith next
    .goto The Barrens,50.2,78.5,100 >>Run to Dustwallow Marsh
step
	#sticky
	#label Hoofprints
    >>Click the Hoofprints on the ground
	.goto Dustwallow Marsh,29.7,47.6
    .accept 1268 >> Accept Suspicious Hoofprints
step
	#sticky
	#label Badge
    >>Click the Dadge on the plank of wood
	.goto Dustwallow Marsh,29.8,48.2
    .accept 1269 >> Accept Lieutenant Paval Reethe
step
    >>Click the Shield above the fireplace
    .goto Dustwallow Marsh,29.6,48.6
    .accept 1251 >> Accept The Black Shield
step
	#requires Hoofprints
step
	#requires Badge
    .goto Dustwallow Marsh,35.1,38.2
    .accept 1177 >> Accept Hungry!
step << skip
    .goto Dustwallow Marsh,35.5,32.0
    .fp Brackenwall >> Get the Brackenwall Village flight path
--N you currently get it earlier in the 20-30 guide after southern barrens
step
    .goto Dustwallow Marsh,35.2,30.6
    .accept 1201 >> Accept Theramore Spies
step
    .goto Dustwallow Marsh,36.41,31.88
    .turnin 1268 >> Turn in Suspicious Hoofprints
    .turnin 1269 >> Turn in Lieutenant Paval Reethe
step
    .goto Dustwallow Marsh,36.41,31.88
    .turnin 1251 >> Turn in The Black Shield
    .accept 1321 >> Accept The Black Shield
step
    .goto Dustwallow Marsh,36.50,30.80
    .turnin 1321 >> Turn in The Black Shield
    .accept 1322 >> Accept The Black Shield
step
	#sticky
	#completewith Infiltrator
    .goto Dustwallow Marsh,39.0,21.6,0
    .goto Dustwallow Marsh,39.7,23.9,0
    .goto Dustwallow Marsh,37.6,26.9,0
    .goto Dustwallow Marsh,41.0,25.5,0
    .goto Dustwallow Marsh,44.2,27.4,0
    .goto Dustwallow Marsh,37.9,37.4,0
    .goto Dustwallow Marsh,39.0,21.6,0
	>>Kill the Darkfang (Red) spiders in the area. Loot them for Sacs
	>> Bloodfen Raptors share spawns with the spiders. Kill them too if needed
    .complete 1322,1 --Collect Acidic Venom Sac (x6)
step
    .goto Dustwallow Marsh,41.00,36.70
     >> Start the escort quest
    .accept 1273 >> Accept Questioning Reethe
step
    .goto Dustwallow Marsh,42.50,38.00
    >> Escort Ogron
    >> When you reach the camp, 4 mobs will spawn, and go through a short rp sequence. When they start attacking, let Ogron aggro one whilst you kill the other 3 using cooldowns.
    .complete 1273,1
step
    .goto Dustwallow Marsh,46.90,17.50
     >> Start the escort quest
    .accept 1270 >> Accept Stinky's Escape
step
     >> Escort Stinky
    .complete 1270,1
step
	#sticky
	#label Mound
    .goto Dustwallow Marsh,55.44,25.92
     >> Click on the Dirt Mound
    .accept 1238 >> Accept The Lost Report
step
    .goto Dustwallow Marsh,55.43,26.26
    .accept 1218 >> Accept Soothing Spices
    .turnin 1218 >> Turn in Soothing Spices
    .accept 1206 >> Accept Jarl Needs Eyes
step
	#requires Mound
    .goto Dustwallow Marsh,57.25,20.99
     >> Kill Murlocs in the area. Loot them for their heads
    .complete 1177,1
step
	#sticky
	#completewith next
	>>Kill some Infiltrators if you come across them en route to spiders. They are stealthed.
    .complete 1201,1 --Kill Theramore Infiltrator
step
    .goto Dustwallow Marsh,35.9,20.7,90,0
    .goto Dustwallow Marsh,32.8,21.4,90,0
    .goto Dustwallow Marsh,34.4,25.2,90,0
    .goto Dustwallow Marsh,35.9,20.7,90,0
    .goto Dustwallow Marsh,32.8,21.4,90,0
    .goto Dustwallow Marsh,34.4,25.2
	>>Kill all the Spiders you see. Loot them for Eyes
	.complete 1206,1 --Collect Unpopped Darkmist Eye (x40)
step
	#label Infiltrator
    .goto Dustwallow Marsh,39.0,21.6,70,0
    .goto Dustwallow Marsh,39.7,23.9,70,0
    .goto Dustwallow Marsh,37.6,26.9,70,0
    .goto Dustwallow Marsh,41.0,25.5,70,0
    .goto Dustwallow Marsh,44.2,27.4,70,0
    .goto Dustwallow Marsh,37.9,37.4,70,0
    .goto Dustwallow Marsh,39.0,21.6,70,0
    .goto Dustwallow Marsh,39.7,23.9
	>>These are stealthed around the area. Find them and kill them
    .complete 1201,1 --Kill Theramore Infiltrator
	.unitscan Theramore Infiltrator
step
    .goto Dustwallow Marsh,39.0,21.6,70,0
    .goto Dustwallow Marsh,39.7,23.9,70,0
    .goto Dustwallow Marsh,37.6,26.9,70,0
    .goto Dustwallow Marsh,41.0,25.5,70,0
    .goto Dustwallow Marsh,44.2,27.4,70,0
    .goto Dustwallow Marsh,37.9,37.4,70,0
    .goto Dustwallow Marsh,39.0,21.6,70,0
   .goto Dustwallow Marsh,39.96,14.10
	>>Kill the Darkfang (Red) spiders in the area. Loot them for Sacs
    .complete 1322,1 --Collect Acidic Venom Sac (x6)
step
    .goto Dustwallow Marsh,35.30,30.70
    .turnin 1201 >> Turn in Theramore Spies
    .turnin 1238 >> Turn in The Lost Report
step
    .goto Dustwallow Marsh,35.30,30.70
    .accept 1202 >> Accept The Theramore Docks
	#softcore
step
    .goto Dustwallow Marsh,36.50,30.80
    .turnin 1322 >> Turn in The Black Shield
    .accept 1323 >> Accept The Black Shield
step
    .goto Dustwallow Marsh,36.50,31.80
    .turnin 1323 >> Turn in The Black Shield
    .turnin 1273 >> Turn in Questioning Reethe
    .accept 1276 >> Accept The Black Shield
step
    .goto Dustwallow Marsh,35.20,38.30
    .turnin 1177 >> Turn in Hungry!
step
    .goto Dustwallow Marsh,55.40,25.90
    .accept 1239 >> Accept The Severed Head
step
    .goto Dustwallow Marsh,55.43,26.26
    .turnin 1206 >> Turn in Jarl Needs Eyes
step
	#era
    .goto Dustwallow Marsh,46.9,17.5
	.xp 37+67550 >> Grind to 67550+/76100xp
	#softcore
step
	#era
    .goto Dustwallow Marsh,46.9,17.5
	.xp 37+70300 >> Grind to 70300+/76100xp
	#hardcore
step
	#som
    .goto Dustwallow Marsh,46.9,17.5
	.xp 37+64130 >> Grind to 64130+/76100xp
	#softcore
step
	#som
    .goto Dustwallow Marsh,46.9,17.5
	.xp 37+67980 >> Grind to 67980+/76100xp
	#hardcore
step
    .goto Dustwallow Marsh,71.50,51.30
     >> Swim along the eastern side of Theramore. Be VERY careful of guards. Look in the water for a chest. Open it and loot the Documents
    .complete 1202,1
	#softcore
step
     #completewith next
    .goto Dustwallow Marsh,69.60,49.96
     .deathskip >> Die and respawn back at the Spirit Healer
	#softcore
step
    .goto Dustwallow Marsh,35.30,30.70
    .turnin 1239 >> Turn in The Severed Head
    .accept 1240 >> Accept The Troll Witchdoctor
step
    .goto Dustwallow Marsh,35.30,30.70
    .turnin 1202 >> Turn in The Theramore Docks
	#softcore
step
    .goto Dustwallow Marsh,35.6,31.9
    .fly Gadgetzan >> Fly to Gadgetzan
step
    .goto Thousand Needles,80.2,75.8
    .turnin 1183 >> Turn in Goblin Sponsorship
    .accept 1186 >> Accept The Eighteenth Pilot
step
    .goto Thousand Needles,80.3,76.1
    .turnin 1186 >> Turn in The Eighteenth Pilot
    .accept 1187 >> Accept Razzeric's Tweaking
step << Druid
	>> Use the spell Teleport to Moonglade
    .goto Moonglade,52.5,40.5
	.trainer >> Go and train your class spells
step
    .hs >> Hearth to Orgrimmar
	>> Buy food/water if needed
step << Shaman
    .goto Orgrimmar,38.6,36.0
	.trainer >> Go and train your class spells
step << Hunter
    .goto Orgrimmar,66.1,18.5
	.trainer >> Go and train your class spells
step << Hunter
    .goto Orgrimmar,66.3,14.8
	.trainer >> Go and train your pet spells
step << Warrior
    .goto Orgrimmar,79.7,31.4
	.trainer >> Go and train your class spells
step << Rogue
    .goto Orgrimmar,44.0,54.6
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,48.0,46.0
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,47.5,46.7
	.vendor >> Buy your pet upgrades if you got the money for it.
step << Priest
    .goto Orgrimmar,35.6,87.8
	.trainer >> Go and train your class spells
step
	#completewith next
   .goto Durotar,45.53,11.79,60 >> Run out of Orgrimmar
step
	>>Run up the Zeppelin Tower outside of Orgrimmar
    .goto Durotar,50.53,12.52
    .zone Stranglethorn Vale >> Take the Zeppelin to Stranglethorn Vale
step
    .goto Stranglethorn Vale,32.20,27.80
    .turnin 1240 >> Turn in The Troll Witchdoctor
step << Hunter
	>>Go to the bottom of the Zeppelin Tower
    .goto Stranglethorn Vale,31.49,29.75
    .home >> Set your Hearthstone to Grom'Gol Base Camp
step << !Mage
    .goto Stranglethorn Vale,31.55,28.99
    .zone Tirisfal Glades >> Run back up the Zeppelin Tower. Take the Zeppelin to Undercity 
step << Mage
	.zone Undercity >> Teleport to Undercity
step << Mage
    .goto Undercity,85.13,10.03
	.trainer >> Train your class spells
	>>Make sure you save at least 30 silver for later
step << Mage
    .goto Undercity,82.79,15.82
    .vendor >> Go to Hannah. Buy three Runes of Teleportation (or more if you want)
    .collect 17031,3 --Rune of Teleportation (3)
]])

RXPGuides.RegisterGuide("RestedXP Horde 30-40",[[
#classic
<< Horde

#name 38-39 Alterac/Arathi
#next 39-40 Badlands

step
    .goto Undercity,50.2,68.8
    .accept 232 >> Accept Errand for Apothecary Zinge
step	
    .goto Undercity,58.5,55.4
    .turnin 232 >> Turn in Errand for Apothecary Zinge
    .accept 238 >> Accept Errand for Apothecary Zinge
step	
    .goto Undercity,49.9,67.9
    .turnin 238 >> Turn in Errand for Apothecary Zinge
--	.accept 243 >> Accept Into the Fiekd
step << Hunter
    .goto Undercity,58.6,33.0
    >> Buy a Great Axe if you're melee weaving. Otherwise, skip this step
    .collect 2531,1
step << Hunter
    .goto Undercity,54.7,38.6
    >> Talk to Abigail. Buy a Massive Longbow. if it's not in the shop, skip this step and buy it in a capital city later.
    .collect 11307,1
step << Rogue
   .goto Undercity,58.66,33.07
    >> Talk to Geoffrey. Buy a Rondel and a Falchion
    .collect 2534,1
    .collect 2528,1
step << Priest
    .goto Undercity,69.54,26.93
	.collect 5239,1 >> Talk to Zane. Buy a Blackbone Wand
step << Warrior
    .goto Undercity,77.48,49.60
	.vendor 4592 >> Go to Nathaniel. Buy 2 stacks of level 35 thrown from him. Equip them for later
step << Warrior
	#softcore
	#completewith next
	>>You can also buy these items now to save a LOT of time (if you have the money)
      .collect 4480,8
      .collect 4479,8
      .collect 4481,8
      .collect 3357,8
step << Warrior
	#softcore
    .goto Undercity,64.3,35.8
    >> Go to the Auction house and buy an Elixir of Water Breathing and Nature Protection Potions
      .collect 5996,1
      .collect 6052,2
step
    .goto Undercity,49.9,68.3
    .accept 243 >> Accept Into the Field
step << Warrior
	#completewith next
    .goto Undercity,63.27,48.59
	.fly Hammerfall >> Fly to Hammerfall
step << Warrior
    .goto Arathi Highlands,66.72,29.72
	#label Cresting
	>>Kill Cresting Exiles. Loot them for their Charms
      .collect 4481,8
step << Warrior
	>>Kill Thundering Exiles. Loot them for their Charms
	>>Be careful as these mobs can be difficult
    .goto Arathi Highlands,52.06,50.60
      .collect 4480,8
step << Warrior
	>>Kill Burning Exiles. Loot them for their Charms
    .goto Arathi Highlands,25.47,30.09
      .collect 4479,8
step << !Warrior
    .goto Undercity,63.27,48.59
    .fly Tarren Mill >> Fly to Tarren Mill
step
    .goto Hillsbrad Foothills,61.5,20.9
    .accept 557 >> Accept Bracers of Binding
step
    .goto Hillsbrad Foothills,61.6,20.6
    .accept 545 >> Accept Dalaran Patrols
step
    .goto Hillsbrad Foothills,62.60,20.70
    .accept 566 >> Accept WANTED: Baron Vardus
step
    .goto Hillsbrad Foothills,63.20,20.70
    .accept 503 >> Accept Gol'dir
step << Warrior
	#softcore
	#completewith Whirlwind
	+If you didn't get the Nature Protection Potions from the Auction House, it is VERY important that you watch this video on how to cheese Cyclonian for the Whirlwind Axe
	.link https://www.youtube.com/watch?v=BiuWeMSHEhA >> CLICK HERE	
step << Warrior
	#hardcore
	#completewith Whirlwind
	+it is VERY important that you watch this video on how to cheese Cyclonian for the Whirlwind Axe
	.link https://www.youtube.com/watch?v=BiuWeMSHEhA >> CLICK HERE	
step << Warrior
	#softcore
	>>Use one of your nature protection potions en route to here if you bought them
    .goto Alterac Mountains,80.5,66.9
    .turnin 1714 >> Turn in Essence of the Exile
step << Warrior
	#hardcore
    .goto Alterac Mountains,80.5,66.9
    .turnin 1714 >> Turn in Essence of the Exile
step << Warrior
    .goto Alterac Mountains,80.5,66.9
    .turnin 1712 >>Turn in Cyclonian
    .accept 1713 >>Accept The Summoning
step << Warrior
	#softcore
	#label Whirlwind
	>>Follow the NPC that's about to spawn Cyclonian. Make sure you equipped your throwns from earlier if you didn't get the Nature Protection Potions
	>>If you have another Nature Protection Potion, use it when your current one wears off
    >>Kill and loot Cyclonian for the Whirlwind Heart
    .goto Alterac Mountains,80.6,62.2
    .complete 1713,1 --Whirlwind Heart (1)
step << Warrior
	#hardcore
	#label Whirlwind
	>>Follow the NPC that's about to spawn Cyclonian. Make sure you equipped your throwns from earlier
    >>Kill and loot Cyclonian for the Whirlwind Heart
    .goto Alterac Mountains,80.6,62.2
    .complete 1713,1 --Whirlwind Heart (1)
step << Warrior
	>> Pick the Axe
    .goto Alterac Mountains,80.5,66.9
    .turnin 1713 >>Turn in The Summoning
	.turnin 1792 >>Turn in Whirlwind Weapon
step
    .goto Alterac Mountains,63.20,43.90
     >> Kill Jailor Borhuin. Loot him for his key
    .complete 503,2
    .unitscan Jailor Borhuin
step
    .goto Alterac Mountains,60.00,43.80
    .turnin 503 >> Turn in Gol'dir
    .accept 506 >> Accept Blackmoore's Legacy
step
    .goto Alterac Mountains,62.10,82.50
    .turnin 506 >> Turn in Blackmoore's Legacy
    .accept 507 >> Accept Lord Aliden Perenolde
step
	#sticky
	#completewith next
    .goto Alterac Mountains,42.2,77.8,90,0
    .goto Alterac Mountains,46.2,78.2,90,0
	>>Kill Mountain Lions around the area for a Carcass if you didn't get one before, or it expired
	.collect 5810,1
step
	>>Use your Fresh Carcass on the Flame of Uzel inside the cave to summon Frostmaw. Kill and loot him for his Mane. 
	>>Be careful, as this quest can be quite hard.
    .goto Alterac Mountains,37.5,66.2
    .complete 1136,1 --Collect Frostmaw's Mane (x1)
step
    .goto Alterac Mountains,10.3,78.5,90,0
    .goto Alterac Mountains,20.5,75.2,90,0
    .goto Alterac Mountains,21.3,53.5,90,0
    .goto Alterac Mountains,17.8,56.2,90,0
    .goto Alterac Mountains,21.3,53.5,90,0
    .goto Alterac Mountains,20.5,75.2,90,0
    .goto Alterac Mountains,10.3,78.5
	>>Kill the Rock Elementals in the area. Loot them for their Bracers. Kill Summoners too
    .complete 545,2 --Kill Elemental Slave (x12)
    .complete 557,1 --Collect Bracers of Earth Binding (x4)
	.complete 545,1 --Kill Dalaran Summoner (x6)
step
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful
    #hardcore
step
   >> On the 2nd floor of the House. He priest bubbles, renews, and sleeps if you have pet/another player with you
	.goto Alterac Mountains,39.3,14.6
    .complete 507,1 --Kill Lord Aliden Perenolde (x1)
step
   >>Turn in at Elysa behind him
	.goto Alterac Mountains,39.3,14.3
    .turnin 507 >> Turn in Lord Aliden Perenolde
    .accept 508 >> Accept Taretha's Gift
step
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful
    #hardcore
step
    .goto Alterac Mountains,47.8,17.1,70,0
    .goto Alterac Mountains,53.6,20.6,70,0
    .goto Alterac Mountains,56.2,26.8,70,0
    .goto Alterac Mountains,58.1,29.9,70,0
    .goto Alterac Mountains,59.7,43.9
	>>Search each camp, as well as the basement inn of Strahnbrad, for Baron Vardus. Kill him and loot his head.
    .complete 566,1 --Collect Head of Baron Vardus (x1)
	.unitscan Baron Vardus
step
    .goto Alterac Mountains,61.10,82.40
    .turnin 566 >> Turn in WANTED: Baron Vardus
step
    .goto Alterac Mountains,62.10,82.50
    .turnin 508 >> Turn in Taretha's Gift
step
    .goto Hillsbrad Foothills,61.6,20.8
    .turnin 545 >> Turn in Dalaran Patrols
    .turnin 557 >> Turn in Bracers of Binding
step
    .goto Hillsbrad Foothills,60.15,18.63
    .fly Hammerfall >> Fly to Hammerfall
step
    .goto Arathi Highlands,73.80,33.90
    .turnin 638 >> Turn in Trollbane
step
    .goto Arathi Highlands,74.30,33.80
    .accept 678 >> Accept Call to Arms
step << Rogue
    .goto Arathi Highlands,74.7,36.3
    .accept 673 >> Accept Foul Magics
step
    .goto Arathi Highlands,72.70,34.20
    .accept 675 >> Accept Raising Spirits
step
    .goto Arathi Highlands,74.70,36.40
    .accept 701 >> Accept Guile of the Raptor
step
    .goto Arathi Highlands,84.97,31.61
     >> Kill Kobolds. Loot them for Motes of Myzrael
    .complete 642,1
step
    .goto Arathi Highlands,84.30,30.95
    >>Click on the stone obelisk inside the back of the cave
    .turnin 642 >> Turn in The Princess Trapped
    .accept 651 >> Accept Stones of Binding
step
    .goto Arathi Highlands,66.70,29.80
     >> Loot the rock in the middle of the elementals
    .complete 651,2
step
    .goto Arathi Highlands,52.00,50.80
     >> Loot the rock in the middle of the elementals
    .complete 651,3
step
    .goto Arathi Highlands,25.50,30.10
     >> Loot the rock in the middle of the elementals
    .complete 651,1
step << Rogue
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful
    #hardcore
step << Rogue
    .goto Arathi Highlands,29.4,61.6,90,0
    .goto Arathi Highlands,29.6,63.0,90,0
    .goto Arathi Highlands,29.4,64.4,90,0
    .goto Arathi Highlands,29.4,61.6
	>>Kill Marez Cowl. Loot her for the Befouled Bloodstone Orb (she's not inside the buildings), you can stealth to her, usually she is on the left side.
    .complete 673,1 --Collect Befouled Bloodstone Orb (x1)
step
    .goto Arathi Highlands,36.20,57.30
    .turnin 651 >> Turn in Stones of Binding
    .accept 652 >> Accept Breaking the Keystone
step
	>>Kill Raptors. Loot them for their Hearts
    .goto Arathi Highlands,46.81,78.45
    .complete 701,1
step
	>>Kill Ogres in the area
    .goto Arathi Highlands,53.26,74.19
    .complete 678,1
    .complete 678,2
step
    .goto Arathi Highlands,74.70,36.40
    .turnin 673 >> Turn in Foul Magics << Rogue
    .turnin 701 >> Turn in Guile of the Raptor
    .accept 702 >> Accept Guile of the Raptor
step
    .goto Arathi Highlands,72.70,34.20
    .turnin 702 >> Turn in Guile of the Raptor
step
    .goto Arathi Highlands,74.20,33.90
    .turnin 678 >> Turn in Call to Arms
step
    .goto Arathi Highlands,72.80,34.10
    .accept 847 >> Accept Guile of the Raptor
step
    .goto Arathi Highlands,74.70,36.40
    .turnin 847 >> Turn in Guile of the Raptor
step
    .goto Arathi Highlands,21.6,75.6,30,0
    .goto Arathi Highlands,22.1,79.9,25 >> Run through the cave to Faldir's Cove
step
    .goto Arathi Highlands,31.9,82.6
    .accept 663 >> Accept Land Ho!
step
    .goto Arathi Highlands,32.3,81.5
    .turnin 663 >> Turn in Land Ho!
step
    .goto Arathi Highlands,33.0,81.4
    .accept 662 >> Accept Deep Sea Salvage
step
    .goto Arathi Highlands,33.9,80.7
    .accept 664 >> Accept Drowned Sorrows
    .accept 665 >> Accept Sunken Treasure
step
    >>Two water elementals will spawn when Phizzle kneels at the stone. Attack them before they aggro onto Phizzle. Kill them
    .goto Arathi Highlands,35.7,79.7
    .complete 665,1 --Defend Professor Phizzlethorpe
step
    .goto Arathi Highlands,33.8,80.5
    .turnin 665 >> Turn in Sunken Treasure
    .accept 666 >> Accept Sunken Treasure
step
    #sticky
    #completewith next
    +These water quests can be quite hard, make sure to always get air after each mob and the warriors can net you.
    #hardcore
step
	#completewith next
	+Use the Water Breathing Potion you bought from the Auction House.
	#softcore
step << !Druid !Warlock !Shaman
	#softcore
	#completewith SLog
	>>Elven Gems are big stones located on the sea floor. Equip your Goggles of Gem hunting to see them on the minimap.
    .complete 666,1 --Collect Elven Gem (x10)
step << !Druid !Warlock !Shaman
	#hardcore
	#completewith SLog
	>>Be VERY careful of your breath. Elven Gems are big stones located on the sea floor. Equip your Goggles of Gem hunting to see them on the minimap.
    .complete 666,1 --Collect Elven Gem (x10)
step << Warlock/Shaman
	#completewith SLog
	>>Use your Water Breathing spell. Elven Gems are big stones located on the sea floor. Equip your Goggles of Gem Hunting to see them on the minimap.
    .complete 666,1 --Collect Elven Gem (x10)
step << Druid
	#completewith SLog
	>>Use your Aquatic Form when your breath gets low. Elven Gems are big stones located on the sea floor. Equip your Goggles of Gem Hunting to see them on the minimap.
    .complete 666,1 --Collect Elven Gem (x10)
step
	#sticky
	#completewith SLog
   >>Kill the Nagas in the area
    .complete 664,1 --Kill Daggerspine Raider (x10)
    .complete 664,2 --Kill Daggerspine Sorceress (x3)	
step
   >>2nd floor of the ship, in the cauldron
	.goto Arathi Highlands,23.4,85.1
    .complete 662,2 --Collect Maiden's Folly Log (x1)
step
    >>2nd floor of the ship on the pillar
	.goto Arathi Highlands,23.0,84.5
    .complete 662,1 --Collect Maiden's Folly Charts (x1)
step
   >>2nd floor of other ship, top of the crate next to the cannon
	.goto Arathi Highlands,20.5,85.6
    .complete 662,3 --Collect Spirit of Silverpine Charts (x1)	
step
	#label SLog
   >>Bottom of the ship on the ground of the sea floor
	.goto Arathi Highlands,20.6,85.1
    .complete 662,4 --Collect Spirit of Silverpine Log (x1)
step
	#sticky
	#label ElvenGems
    .goto Arathi Highlands,19.3,84.1,90,0
    .goto Arathi Highlands,17.7,89.5,90,0
    .goto Arathi Highlands,25.5,90.8,90,0
    .goto Arathi Highlands,24.1,85.7,90,0
    .goto Arathi Highlands,23.2,89.7,90,0
    .goto Arathi Highlands,19.3,84.1,90,0
    .goto Arathi Highlands,17.7,89.5,90,0
    .goto Arathi Highlands,25.5,90.8,90,0
    .goto Arathi Highlands,24.1,85.7,90,0
    .goto Arathi Highlands,23.2,89.7,90,0
    .goto Arathi Highlands,19.3,84.1
	>>Use your Goggles of Gem Finding to find Elven Gems. Loot them
    .complete 666,1 --Collect Elven Gem (x10)
step
    .goto Arathi Highlands,19.3,84.1,90,0
    .goto Arathi Highlands,17.7,89.5,90,0
    .goto Arathi Highlands,25.5,90.8,90,0
    .goto Arathi Highlands,24.1,85.7,90,0
    .goto Arathi Highlands,23.2,89.7,90,0
    .goto Arathi Highlands,19.3,84.1
	>>Finish killing the Nagas in the area
    .complete 664,1 --Kill Daggerspine Raider (x10)
    .complete 664,2 --Kill Daggerspine Sorceress (x3)
step
   #requires ElvenGems
	.goto Arathi Highlands,32.8,81.3
    .turnin 662 >> Turn in Deep Sea Salvage
	>>Re-equip your helm
step
    .goto Arathi Highlands,33.9,80.6
    .turnin 666 >> Turn in Sunken Treasure
    .accept 668 >> Accept Sunken Treasure
step
    .goto Arathi Highlands,34.0,80.8
    .turnin 664 >> Turn in Drowned Sorrows
step
    .goto Arathi Highlands,32.2,81.5
    .turnin 668 >> Turn in Sunken Treasure
    .accept 669 >> Accept Sunken Treasure

]])

RXPGuides.RegisterGuide("RestedXP Horde 30-40",[[
#classic
<< Horde

#name 39-40 Badlands
#next RestedXP Horde 40-50\40-41 STV/Swamp of Sorrows

step
   .goto Wetlands,32.78,13.12
    .zone Wetlands >> Swim to Wetlands
step
    .goto Wetlands,53.86,46.42,150,0
	.goto Wetlands,63.9,78.6
	.zone Loch Modan >> Logout on top of the mushrooms at the back of the cave. When you log back in, this will teleport you to just outside of Thelsamar
	.link https://www.youtube.com/watch?v=21CuGto26Mk >> CLICK HERE for a reference
	>>be VERY careful not to move forward when you log in as there are level 30-40 guards around and you may get PVP flagged. Instead run to the other side of the road and try to avoid the guards
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
	.link https://www.youtube.com/watch?v=oNFXup-DCM0 >> CLICK HERE
step
    .goto Badlands,4.1,44.7
    .fp Kargath >> Get the Kargath Flight Path
step
	#level 40
    .goto Badlands,2.9,45.6
    .accept 782 >> Accept Broken Alliances
step
    .goto Badlands,2.6,46.1
    .accept 2258 >> Accept Badlands Reagent Run
step
    .goto Badlands,6.4,47.5
    .accept 1419 >> Accept Coyote Thieves
step
	#era
    .goto Badlands,6.4,47.0
	.accept 1420 >> Accept Report to Helgrum
step
    .goto Badlands,25.8,45.0
    .accept 710 >> Accept Study of the Elements: Rock
step
    .goto Badlands,23.2,47.0,90,0
    .goto Badlands,19.5,46.4,90,0
    .goto Badlands,22.1,43.1,90,0
    .goto Badlands,12.7,39.5,90,0
    .goto Badlands,15.1,32.6,90,0
    .goto Badlands,23.2,47.0
	>>Kill all of the Elementals you see. Loot the Small Stone Shards from the lesser Elementals, and the Rock Elemental Shards from both
    .complete 2258,3 --Collect Rock Elemental Shard (x5)
    .complete 710,1 --Collect Small Stone Shard (x10)		
step
    .goto Badlands,26.0,44.9
    .turnin 710 >> Turn in Study of the Elements: Rock
    .accept 711 >> Accept Study of the Elements: Rock
step
    .goto Badlands,23.2,47.0
	.xp 40 >> Grind to 40
step
    .goto Badlands,2.9,45.6
    .accept 782 >> Accept Broken Alliances
step
    .goto Badlands,42.4,52.8
    .accept 703 >> Accept Barbecued Buzzard Wings
    .turnin 1106 >> Turn in Martek the Exiled
    .accept 1108 >> Accept Indurium
step
	.isOnQuest 782
	#sticky
	#label signofearthBL
	>>Find & kill Tho'grun. He's an ogre who patrols around the zone with a pack of guards.
	>>Kite him away from his guards. Loot him for the Sign of the Earth << !Warlock !Mage
	>>Split Pull him away from his guards using Rain of Fire. Loot him for the Sign of the Earth << Warlock
	>>Split Pull him away from his guards using Blizzard. Loot him for the Sign of the Earth << Mage
    .complete 782,1 --Collect Sign of the Earth (x1)
	.unitscan Boss Tho'grun
step
	#sticky
	#label badlandscollect
	>>Complete these as you quest through Badlands.
	.complete 2258,1 --Collect Buzzard Gizzard (x5)
	.complete 1419,1 --Collect Coyote Jawbone (x30)
	.complete 2258,2 --Collect Crag Coyote Fang (x10)	
step
	#sticky
	#label bbqwingsBL
	.complete 703,1 --Collect Buzzard Wing (x4)
step
    .goto Badlands,36.2,75.1,90,0
    .goto Badlands,46.0,78.4,90,0
    .goto Badlands,42.8,87.2,90,0
    .goto Badlands,36.2,75.1,90,0
    .goto Badlands,46.0,78.4,90,0
    .goto Badlands,42.8,87.2
	>>Kill Rock Elementals. Loot them for Large Stone Slabs
    .complete 711,1 --Collect Large Stone Slab (x3)
step
	>>Kill Troggs. Loot them for Indurium Flakes
    .goto Badlands,50.1,67.2
    .complete 1108,1 --Collect Indurium Flake (x10)
step
	#requires bbqwingsBL
    .goto Badlands,42.4,52.7
    .turnin 703 >> Turn in Barbecued Buzzard Wing
    .turnin 1108 >> Turn in Indurium
step
	#requires badlandscollect
    .goto Badlands,6.4,47.3
    .turnin 1419 >> Turn in Coyote Thieves
step
    .goto Badlands,2.4,45.9
    .turnin 2258 >> Turn in Badlands Reagent Run
step
	#requires signofearthBL
    .goto Badlands,2.8,45.6
    .turnin 782 >> Turn in Broken Alliances
step
    .goto Badlands,26.0,44.9
    .turnin 711 >> Turn in Study of the Elements: Rock
step << Druid
	>> Use the spell Teleport to Moonglade
    .goto Moonglade,52.5,40.5
	.trainer >> Go and train your class spells
step
    .hs >> Hearth to Orgrimmar
	>> Buy food/water if needed
]])

RXPGuides.RegisterGuide("RestedXP Horde 40-50",[[
#classic
<< Horde
#name 40-41 STV/Swamp of Sorrows
#next 41-41 Desolace II


step << Shaman
    .goto Orgrimmar,38.6,36.0
	.trainer >> Go and train your class spells
step << Hunter
    .goto Orgrimmar,66.1,18.5
	.trainer >> Go and train your class spells
step << Hunter
    .goto Orgrimmar,66.3,14.8
	.trainer >> Go and train your pet spells
step << Warrior
    .goto Orgrimmar,79.7,31.4
	.trainer >> Go and train your class spells
step << Rogue
    .goto Orgrimmar,44.0,54.6
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,48.0,46.0
	.trainer >> Go and train your class spells
step << Mage
    .goto Orgrimmar,38.8,85.6
	.trainer >> Go and train your class spells
step << Priest
    .goto Orgrimmar,35.6,87.8
	.trainer >> Go and train your class spells
step << Hunter
    .goto Orgrimmar,78.1,38.4
    >> Go and buy a Massive Longbow from Jin'sora. If it's not at the vendor, skip this step
    .collect 11307,1
step
    .goto Orgrimmar,75.0,74.2
    .accept 2981 >> Accept A Threat in Feralas
step
	#completewith next
   .goto Durotar,45.53,11.79,60 >> Run out of Orgrimmar
step
	>>Run up the Zeppelin Tower outside of Orgrimmar
    .goto Durotar,50.53,12.52
    .zone Stranglethorn Vale >> Take the Zeppelin to Stranglethorn Vale
step
    .goto Stranglethorn Vale,31.4,29.60
    .home >>Set your Hearthstone to Grom'Gol Base Camp
step
    .goto Stranglethorn Vale,32.10,27.80
    .accept 584 >> Accept Bloodscalp Clan Heads
step
    .goto Stranglethorn Vale,32.20,27.70
    .accept 598 >> Accept Split Bone Necklace
step
    .goto Stranglethorn Vale,23.40,8.00
     >> Kill Gan'Zulah. Loot him for his Head
    .complete 584,1
    .unitscan Gan'zulah
step
    .goto Stranglethorn Vale,23.50,9.50
     >> Kill Nezzliok. Loot him for his Head
    .complete 584,2
	.unitscan Nezzliok
step
    .goto Stranglethorn Vale,32.20,27.60
     >> Click on the Bubbling Cauldron
    .turnin 584 >> Turn in Bloodscalp Clan Heads
    .accept 585 >> Accept Speaking with Nezzliok
step
    .goto Stranglethorn Vale,32.10,29.20
    .accept 572 >> Accept Mok'thardin's Enchantment
step
    .goto Stranglethorn Vale,31.00,42.50
     >> Kill Jungle Stalkers. Loot them for Jungle Stalker Feathers
    .complete 196,1
    .complete 572,1
step
    .goto Stranglethorn Vale,41.60,43.60
     >> Kill Goblins. Loot them for the Blue Crystals
    .complete 600,1
step
    #sticky
	#completewith SkullP
	>>Kill Trolls in the area. Loot them for Tusks and Necklaces
    .complete 209,1
    .complete 598,1
step
    .goto Stranglethorn Vale,42.20,36.10
     >> Loot the Skull Pile on the ground
    .complete 585,2
step
    .goto Stranglethorn Vale,47.60,39.60
     >> Loot the Skull Pile on the ground
    .complete 585,3
step
	#label SkullP
    .goto Stranglethorn Vale,46.10,32.30
     >> Loot the Skull Pile on the ground
    .complete 585,1
step
    .goto Stranglethorn Vale,42.25,36.06
	>>Kill Trolls in the area. Loot them for Tusks and Necklaces
    .complete 209,1
    .complete 598,1
step
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful
    #hardcore
step
    .goto Stranglethorn Vale,47.26,28.58,70,0
    .goto Stranglethorn Vale,49.61,23.98,70,0
    .goto Stranglethorn Vale,48.95,19.87,70,0
    .goto Stranglethorn Vale,47.26,28.58
    .goto Stranglethorn Vale,49.61,23.98,0
    .goto Stranglethorn Vale,48.95,19.87,0
    >> Look for Bhag'thera. Kill and loot him for his Fang
    .complete 193,1
    .unitscan BHAG'THERA
step
	#era
    .hs >> Hearth to Grom'Gol
	>> Buy food/water if needed
step << Hunter
	#era
    .goto Stranglethorn Vale,31.55,27.95
	.vendor >> Go to Uthok. Buy arrows until your quiver is full
step
	#era
    .goto Stranglethorn Vale,32.20,27.80
    .turnin 598 >> Turn in Split Bone Necklace
    .turnin 585 >> Turn in Speaking with Nezzliok
    .accept 1261 >> Accept Marg Speaks
step
	#era
    .goto Stranglethorn Vale,32.10,29.20
    .turnin 572 >> Turn in Mok'thardin's Enchantment
step
    .goto Stranglethorn Vale,35.60,10.60
    .turnin 196 >> Turn in Raptor Mastery
    .accept 197 >> Accept Raptor Mastery
    .turnin 193 >> Turn in Panther Mastery
step
	#som
    .hs >> Hearth to Grom'Gol
	>> Buy food/water if needed
step << Hunter
	#era
    .goto Stranglethorn Vale,31.55,27.95
	.vendor >> Go to Uthok. Buy arrows until your quiver is full
step
	#som
    .goto Stranglethorn Vale,32.20,27.80
    .turnin 598 >> Turn in Split Bone Necklace
    .turnin 585 >> Turn in Speaking with Nezzliok
    .accept 1261 >> Accept Marg Speaks
step
	#som
    .goto Stranglethorn Vale,32.10,29.20
    .turnin 572 >> Turn in Mok'thardin's Enchantment
step
	#era
	#completewith next
    .goto Stranglethorn Vale,39.30,6.49,60,0
    .goto Stranglethorn Vale,40.60,3.15,50 >> Travel to Duskwood
step
	#era
    .goto Deadwind Pass,28.10,29.60
    .accept 1372 >> Accept Nothing But The Truth
    .turnin 1372 >> Turn in Nothing But The Truth
step
	#era
	#completewith next
    .goto Duskwood,88.47,41.00,50 >> Travel to Deadwind Pass
step
	#era
    .goto Deadwind Pass,48.02,34.60,60,0
    .goto Deadwind Pass,58.43,41.51,50 >> Travel to Swamp of Sorrows
step
	#era
	#completewith next
    .goto Swamp of Sorrows,14.32,59.97,100 >> Head to where the Whelps are
step
	#era
     #completewith next
    .goto Swamp of Sorrows,13.27,67.96,0
    .goto Swamp of Sorrows,16.68,54.52,0
    >>Kill the Whelps in the area. Loot them for Dream Dust
    >>You won't find enough Whelps to finish this quest in the first loop
    >>Head to Stonard after the first loop
    .complete 1116,1
step
	#era
    .goto Swamp of Sorrows,44.70,57.10
    .accept 698 >> Accept Lack of Surplus
step
	#era
    .goto Swamp of Sorrows,46.10,54.70
    .fp Stonard >> Get the Stonard Flight Path
step
	#era
    .goto Swamp of Sorrows,47.80,55.20
    .turnin 1420 >> Turn in Report to Helgrum
    .accept 1424 >> Accept Pool of Tears
step
	#era
    #sticky
    .goto Swamp of Sorrows,57.68,38.36,0
     >> Kill Sawtooth Crocolisks and Sawtooth Snappers. Loot them for Sawtooth Flanks
    .complete 698,1
step
	#era
    .goto Swamp of Sorrows,47.10,38.83
     >> Kill Noboru, loot him for the Cudgel, then click it. He patrols around the top-center of the zone
     .collect 6196,1,1392
    .accept 1392 >> Accept Noboru the Cudgel
    .unitscan NOBORU THE CUDGEL
step
	#era
    .goto Swamp of Sorrows,26.00,31.40
    .accept 1389 >> Accept Draenethyst Crystals
    .turnin 1392 >> Turn in Noboru the Cudgel
step
	#era
	#completewith Draene
     >> Kill Ongeku. Loot him for his Shard. He can be found all over the Fallow Sanctuary
    .complete 1373,1
    .isOnQuest 1373
	.unitscan Ongeku
step
	#era
    #sticky
    #completewith GalenE
    .goto Swamp of Sorrows,63.26,22.35,0
     >> Loot 6 Blue Crystals around the wooden huts
    .complete 1389,1
step
	#era
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful
    #hardcore
step
	#era
	#label Galen
    .goto Swamp of Sorrows,65.46,18.16
     >> Accepting this quest will start an escort. Try clearing out the mobs around the camp 40 yards south from Galen before starting this quest
    .accept 1393 >> Accept Galen's Escape
step
	#era
	#label GalenE
     >> Escort Galen
    .complete 1393,1
step
	#era
	#label Draene
    .goto Swamp of Sorrows,63.26,22.35
     >> Finish off Draenethyst Crystals
    .complete 1389,1
step
	#era
    .goto Swamp of Sorrows,64.74,22.46
     >> Kill Ongeku. Loot him for his Shard. He can be found all over the Fallow Sanctuary
    .complete 1373,1
    .isOnQuest 1373
	.unitscan Ongeku
step
	#era
    .goto Swamp of Sorrows,47.80,39.75
     >> Click on Galen's Strongbox
    .turnin 1393 >> Turn in Galen's Escape
step
	#era
    .goto Swamp of Sorrows,57.68,38.36
     >> Kill Sawtooth Crocolisks and Sawtooth Snappers. Loot them for Sawtooth Flanks
    .complete 698,1
step
	#era
    .goto Swamp of Sorrows,81.40,81.00
    .turnin 698 >> Turn in Lack of Surplus
    .accept 699 >> Accept Lack of Surplus
step
	#era
	>>Loot the various artifacts found underwater in the lake
    .goto Swamp of Sorrows,71.40,61.25
    .complete 1424,1
step
	#era
	>>Run back to Stonard
    .goto Swamp of Sorrows,48.00,54.90
    .turnin 1424 >> Turn in Pool of Tears
step
	#era
    .goto Swamp of Sorrows,25.90,31.50
    .turnin 1392 >> Turn in Noboru the Cudgel
    .turnin 1389 >> Turn in Draenethyst Crystals
step
	#era
    .goto Swamp of Sorrows,13.96,61.67
     >> Kill Whelps. Loot them for Dream Dust
    .complete 1116,1
step
	#era
    .hs >> Hearth back to Grom'Gol
	>> Buy food/water if needed
step
    .goto Stranglethorn Vale,32.54,29.36
    .fly Booty Bay >> Fly to Booty Bay
step
	#era
	>>Top floor of the Inn
    .goto Stranglethorn Vale,27.00,77.20
    .turnin 1116 >> Turn in Dream Dust in the Swamp
    .turnin 209 >> Turn in Skullsplitter Tusks
step
	#som
	>>Top floor of the Inn
    .goto Stranglethorn Vale,27.00,77.10
    .turnin 209 >> Turn in Skullsplitter Tusks
step
	>>Balcony of the Inn
    .goto Stranglethorn Vale,27.10,77.00
    .turnin 669 >> Turn in Sunken Treasure
    .accept 1183 >> Accept Goblin Sponsorship
step
	#era
    .goto Stranglethorn Vale,27.00,77.20
    .accept 1117 >> Accept Rumors for Kravel
    .accept 2864 >> Accept Tran'rek
step
	#som
    .goto Stranglethorn Vale,27.00,77.20
    .accept 2864 >> Accept Tran'rek
step
    .goto Stranglethorn Vale,27.10,77.30
    .turnin 600 >> Turn in Venture Company Mining
step
    .goto Stranglethorn Vale,27.70,77.10
    .accept 2872 >> Accept Stoley's Debt
step
    #completewith next
    .goto Stranglethorn Vale,25.90,73.14,40 >> Run to the Booty Bay Dock
step
    .goto Stranglethorn Vale,25.76,73.04
    .zone The Barrens >> Take the Boat to Ratchet
step
    .goto The Barrens,62.40,37.60
    .turnin 1270 >> Turn in Stinky's Escape
step
	#era
    .goto The Barrens,63.08,37.16
    .fly Camp Taurajo >> Fly to Camp Taurajo
]])

RXPGuides.RegisterGuide("RestedXP Horde 40-50",[[
#classic
<< Horde

#name 41-41 Desolace II
#next 41-43 Tanaris/Dustwallow
#somname 41-41 Thunder Bluff
	
step
	#era
    .goto The Barrens,45.6,59.0
    .home >> Set your Hearthstone to Camp Taurajo
step << !Mage
    .goto The Barrens,44.45,59.15
    .fly Thunder Bluff >> Fly to Thunder Bluff
step << Mage
	.zone Thunder Bluff >> Teleport to Thunder Bluff
step
    .goto Thunder Bluff,54.00,80.90
    .turnin 1276 >> Turn in The Black Shield
step
    .goto Thunder Bluff,61.40,80.70
    .accept 1205 >> Accept Deadmire
    .turnin 1136 >> Turn in Frostmaw
step
	#era
    .goto Thunder Bluff,47.00,49.83
    .fly Desolace >> Fly to Desolace
step
	#era
    .goto Desolace,25.80,68.20
    .accept 5581 >> Accept Portals of the Legion
step
	#era
    .goto Desolace,36.30,79.20
    .turnin 1373 >> Turn in Ongeku
    .accept 1374 >> Accept Khan Jehn
step
	#era
    .goto Desolace,47.80,61.80
    .accept 6134 >> Accept Ghost-o-plasm Round Up
--P
step
	#era
    .goto Desolace,52.20,53.50
    .accept 1484 >> Accept The Corrupter
step
	#era
    .goto Desolace,52.60,54.30
    .turnin 1484 >> Turn in The Corrupter
    .accept 1488 >> Accept The Corrupter
step
	#era
    #completewith KhanJ
    .goto Desolace,53.36,79.47,0
	>>Use the Hand of Iruxos to close the purple portals in the area
	>>You don't need to finish this now, you can do it later
    .complete 5581,1
step
	#era
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful
    #hardcore
step
	#era
    #completewith next
    .goto Desolace,55.90,77.80,0
     >> Kill Lord Azrethoc, this can be quite hard, but should be doable on all classes with cooldowns.
	>> He patrols all around the edges of Mannoroc Cavern
    .complete 1488,1
    .unitscan Lord Azrethoc
step
	#era
	#label Jugkar
    .goto Desolace,55.90,77.80
     >> Kill Jugkar Grim'rod
    .complete 1488,2
step
	#era
	#label Azrethoc
    .goto Desolace,55.90,77.80
     >> Kill Lord Azrethoc, this can be quite hard, but should be doable on all classes with cooldowns.
	>> He patrols all around the edges of Mannoroc Cavern
    .complete 1488,1
    .unitscan Lord Azrethoc
step
	#era
	#label KhanJ
    .goto Desolace,66.30,80.10
     >> Kill Khan Jhen. Loot him for his Head
    .complete 1374,1
step
	#era
    .goto Desolace,64.00,91.70
     >> At the Valley of Bones, use the Crate of Ghost Magnets in your inventory. Kill the Ghosts that spawn. Loot them for the Ghost-O-Plasm
    .complete 6134,1
step
	#era
    .goto Desolace,53.36,79.47
	>>Use the Hand of Iruxos to close the purple portals in the area
    .complete 5581,1
step
	#era
    .goto Desolace,36.30,79.30
    .turnin 1374 >> Turn in Khan Jehn
step
	#era
    .goto Desolace,25.81,68.21
    .turnin 5581 >> Turn in Portals of the Legion
step
	#era
	#softcore
    .goto Desolace,33.90,53.60
     >> Start the escort quest
	>> Be careful, as this quest is HARD
    .accept 6132 >> Accept Get Me Out of Here!
--N this quest sucks, and although im against gating quests for hardcore, i am for this one
step
	#era
	#softcore
	>> The first wave you can ignore completely, the mobs wont run into the escort. The 2nd wave is 5 mobs, so use all cooldowns for it. If you die, skip the quest.
     >> Finish the escort quest
    .complete 6132,1
step
	#era
	#softcore
    .goto Desolace,47.80,61.80
    .turnin 6132 >> Turn in Get Me Out of Here!
step
	#era
    .goto Desolace,47.83,61.82
    .turnin 6134 >> Turn in Ghost-o-plasm Round Up
step
	#era
    .goto Desolace,52.60,54.40
    .turnin 1488 >> Turn in The Corrupter
step
	#era
    .hs >> Hearth back to Camp Taurajo
>> Buy food/water if needed
step
    .goto The Barrens,44.45,59.15
    .fly Tanaris >> Fly to Tanaris
]])

RXPGuides.RegisterGuide("RestedXP Horde 40-50",[[
#classic
<< Horde


#name 41-43 Tanaris/Dustwallow
#next 43-44 Feralas
#somname 41-42 Tanaris/Dustwallow


step << !Mage
	#som
    .goto The Barrens,63.08,37.17
    .fly Thunder Bluff >> Fly to Thunder Bluff
step << Mage
	#som
    .zone Thunder Bluff >> Teleport to Thunder Bluff
step
	#som
    .goto Thunder Bluff,54.00,80.90
    .turnin 1276 >> Turn in The Black Shield
step
	#som
    .goto Thunder Bluff,61.40,80.70
    .accept 1205 >> Accept Deadmire
    .turnin 1136 >> Turn in Frostmaw
step
	#som
    .goto Thunder Bluff,47.00,49.83
    .fly Tanaris >> Fly to Tanaris
step
    .goto Tanaris,51.60,26.80
    .turnin 2864 >> Turn in Tran'rek
step
    .goto Tanaris,51.80,26.90
    .accept 2781 >> Accept WANTED: Caliph Scorpidsting
step
    .goto Tanaris,52.50,27.90
    .home >> Set your Hearthstone to Gadgetzan
step
    .goto Tanaris,52.40,28.50
    .turnin 243 >> Turn in Into the Field
    .accept 379 >> Accept Slake That Thirst
step
    .goto Tanaris,52.46,28.51
    .accept 1690 >> Accept Wastewander Justice
    .accept 1707 >> Accept Water Pouch Bounty
step
    .goto Tanaris,50.20,27.50
    .accept 992 >> Accept Gadgetzan Water Survey
step
    .goto Tanaris,39.10,29.30
     >> Use the Untapped Widget at the pool. Run from the mobs that spawn
    .complete 992,1
step
    #completewith next
    .goto Tanaris,60.18,23.29,0
     >> Kill Bandits and Thieves in Noonshade Ruins en route to Steamwheedle Port. Loot them for Water Pouches
    .complete 1690,1
    .complete 1690,2
    .collect 8483,10
step
    .goto Tanaris,67.00,22.40
    .accept 3520 >> Accept Screecher Spirits
step
    .goto Tanaris,67.10,24.00
    .turnin 2872 >> Turn in Stoley's Debt
step
    .goto Tanaris,63.70,31.15
     >> Kill Bandits and Thieves. Loot them for Water Pouches
    .complete 1690,1
    .complete 1690,2
    .collect 8483,10
step << Shaman
	.hs >> Hearth to Gadgetzan
>> Buy food/water if needed
step
    .goto Tanaris,52.50,28.50
    .turnin 1707 >> Turn in Water Pouch Bounty
    .turnin 379 >> Turn in Slake That Thirst
    .turnin 1690 >> Turn in Wastewander Justice
    .accept 1691 >> Accept More Wastewander Justice
step
	#som
	#sticky
	.destroy 8524 >> Destroy the Model 4711-FTZ Power Source in your bags
step
    .goto Tanaris,50.21,27.48
    .turnin 992 >> Turn in Gadgetzan Water Survey
step
	#era
    .goto Tanaris,52.70,7.80
     >> Head north to the Shimmering Flats
    .turnin 1117 >> Turn in Rumors for Kravel
step
    .goto Tanaris,52.90,7.70
    .turnin 1137 >> Turn in News for Fizzle
step
    .goto Tanaris,54.20,6.90
    .turnin 1183 >> Turn in Goblin Sponsorship
    .accept 1186 >> Accept The Eighteenth Pilot
    .accept 1190 >> Accept Keeping Pace
step
    .goto Tanaris,54.30,7.00
    .turnin 1186 >> Turn in The Eighteenth Pilot
    .accept 1187 >> Accept Razzeric's Tweaking
step
     #completewith next
    .goto Thousand Needles,79.81,77.02
     >>Talk with Zamek to create a diversion 
    .turnin 1191 >> Turn in Zamek's Distraction
step
    .goto Thousand Needles,77.21,77.41
    >>Click on the unguarded plans inside the metal hut
    .turnin 1190 >> Turn in Keeping Pace
    .accept 1194 >> Accept Rizzle's Schematics
step
	#era
    .goto Tanaris,52.70,7.80
    .accept 1118 >> Accept Back to Booty Bay
step
    .goto Tanaris,54.20,6.90
    .turnin 1194 >> Turn in Rizzle's Schematics
step
	#sticky
	#completewith next
	>> If your Hearthstone is up, hearth to Gadgetzan, otherwise walk back and fly.
	.hs >> Hearth to Gadgetzan
>> Buy food/water if needed
step
    .goto Tanaris,51.60,25.50
    .fly Brackenwall >> Fly to Dustwallow Marsh
step
    .goto Dustwallow Marsh,36.30,31.40
    .accept 1166 >> Accept Overlord Mok'Morokk's Concern
step
    .goto Dustwallow Marsh,37.10,33.00
    .accept 1169 >> Accept Identifying the Brood
step
    .goto Dustwallow Marsh,37.30,31.40
    .accept 1168 >> Accept Army of the Black Dragon
step
    #completewith Dragondeez
    .unitscan Deadmire
    .goto Dustwallow Marsh,50.5,53.1,0
    .goto Dustwallow Marsh,49.3,57.4,0
    .goto Dustwallow Marsh,45.8,61.6,0
    .goto Dustwallow Marsh,46.4,60.3,0
    .goto Dustwallow Marsh,46.2,54.1,0
    >>Find & kill Deadmire. He's a White Crocolisk who patrols in the water mires around the area. Loot him for his tooth
    .complete 1205,1 --Collect Deadmire's Tooth (x1)
    .unitscan Deadmire
step
    .goto Dustwallow Marsh,54.10,56.50
     >> Loot the box on the ground near the crashed Zeppelin
    .complete 1187,1
step
    .goto Dustwallow Marsh,55.40,63.10
     >> Kill the Makrura mobs on the beach. Loot them for the Pendant
    .complete 1261,1
step
    .goto Dustwallow Marsh,44.50,66.00
     >> Loot the Barrel on the ground
    .complete 1166,1
step
    .goto Dustwallow Marsh,38.70,65.60
     >> Loot the Vase on the ground. Go inside the cave afterward
    .complete 1166,2
step
    .goto Dustwallow Marsh,36.60,69.50
     >> Loot the Chest in the back of the cave. Kill the Scalebanes whilst you're inside
    .complete 1166,3
    .complete 1168,3
step
	#completewith next
    .goto Dustwallow Marsh,44.64,65.97,0
	>>Kill Whelps you see on the borders of the area. Loot them for Tongues and Hearts
    .complete 1169,1
    .complete 1169,2
step
    .goto Dustwallow Marsh,44.64,65.97
     >> Kill the Dragonkin in the area
    .complete 1168,1
    .complete 1168,2
step
	#label Dragondeez
    .goto Dustwallow Marsh,42.12,80.82
	>>Kill the Whelps in the area. Loot them for Tongues and Hearts
    .complete 1169,1
    .complete 1169,2
step
    .goto Dustwallow Marsh,50.5,53.1,90,0
    .goto Dustwallow Marsh,50.1,56.1,90,0
    .goto Dustwallow Marsh,49.3,57.4,90,0
    .goto Dustwallow Marsh,47.9,55.5,90,0
    .goto Dustwallow Marsh,45.8,61.6,90,0
    .goto Dustwallow Marsh,44.1,62.2,90,0
    .goto Dustwallow Marsh,46.4,60.3,90,0
    .goto Dustwallow Marsh,47.8,55.5,90,0
    .goto Dustwallow Marsh,46.2,54.1,90,0
    .goto Dustwallow Marsh,44.2,50.0,90,0
    .goto Dustwallow Marsh,50.5,53.1
    >>Find and kill Deadmire. He's a White Crocolisk who patrols in the water mires around the area. Loot him for his Tooth
    .complete 1205,1 --Collect Deadmire's Tooth (x1)
step
	>>Run back to Brackenwall Village
    .goto Dustwallow Marsh,37.10,33.00
    .turnin 1169 >> Turn in Identifying the Brood
step
    .goto Dustwallow Marsh,36.30,31.50
    .turnin 1166 >> Turn in Overlord Mok'Morokk's Concern
step
    .goto Dustwallow Marsh,37.30,31.40
    .turnin 1168 >> Turn in Army of the Black Dragon
step
    .goto Dustwallow Marsh,35.30,30.60
    .turnin 1261 >> Turn in Marg Speaks
    .accept 1262 >> Accept Report to Zor
step
    .hs >> Hearth to Gadgetzan
	>> Buy food/water if needed
step
    .goto Tanaris,51.80,26.90
	>>Click on the wanted poster
    .accept 2781 >> Accept WANTED: Caliph Scorpidsting
step   
	#era
	#level 43
     >> Click on the Power Source (Orange tablet) in your bags.
    .accept 654 >> Accept Tanaris Field Sampling
step
	#era
	.isOnQuest 654
    >> Go around the zone and kill Scorpions, Basilisk and Hyenas for Samples. Click the looted Samples to test them to see if they're acceptable
	>> do NOT delete any untested samples you have that you don't need
    .complete 654,1
    .complete 654,2
    .complete 654,3
step
	#era
    .goto Tanaris,52.40,28.50
	.isOnQuest 654
    .turnin 654 >> Turn in Tanaris Field Sampling
    .accept 864 >> Accept Return to Apothecary Zinge
step
    #completewith next
        .goto Tanaris,62.22,37.75,0
    >>Look for Caliph Scorpidsting in the area. Kill and loot him for his head
    >>Be careful as he has two stealthed adds right next to him
   .complete 2781,1 --Caliph Scorpidsting's Head (1)
    .unitscan Caliph Scorpidsting
step
    .goto Tanaris,59.09,37.87
     >> Do More Wastewander Justice
    .complete 1691,1
    .complete 1691,2
    .complete 1691,3
step
        .goto Tanaris,62.22,37.75
    >>Look for Caliph Scorpidsting in the area. Kill and loot him for his head
    >>Be careful as he has two stealthed adds right next to him
   .complete 2781,1 --Caliph Scorpidsting's Head (1)
    .unitscan Caliph Scorpidsting
step <<  Hunter
    .goto Tanaris,52.70,45.92
    .accept 3161 >> Accept Gahz'ridian
step <<  Hunter
    .goto Tanaris,47.31,65.14
    .goto Tanaris,40.48,72.82
     >> Equip the Helmet provided. Loot the patches of sand on the ground (and on the minimap). Loot them for the Ornaments
    .complete 3161,1
step <<  Hunter
    .goto Tanaris,52.70,45.92
	>>Re-equip your normal Helmet
    .turnin 3161 >> Turn in Gahz'ridian
step
    .goto Tanaris,52.40,28.50
    .turnin 1691 >> Turn in More Wastewander Justice
    .turnin 2781 >> Turn in WANTED: Caliph Scorpidsting
step
    .goto Tanaris,51.60,25.50
    .fly Feralas >> Fly to Feralas
]])

RXPGuides.RegisterGuide("RestedXP Horde 40-50",[[
#classic
<< Horde
#name 43-44 Feralas
#next 44-45 Southern Stranglethorn
#somname 42-43 Feralas

step
    .goto Feralas,75.70,44.30
    .accept 2987 >> Accept Gordunni Cobalt
step
    #sticky
	#label RokOrhan
    .goto Feralas,75.70,43.62,0
    >> Speak to Rok Orhan. She patrols the road inside of Camp Mojache
    .turnin 2981 >> Turn in A Threat in Feralas
    .accept 2975 >> Accept The Ogres of Feralas
step
    .goto Feralas,76.00,42.70
    .accept 2973 >> Accept A New Cloak's Sheen
step
    .goto Feralas,74.90,42.50
    .accept 2862 >> Accept War on the Woodpaw
step
	>>Inside the building
    .goto Feralas,74.50,42.90
    .accept 2822 >> Accept The Mark of Quality
step << Shaman
    .goto Feralas,74.80,45.20
    .home >> Set your Hearthstone to Feralas
step
	#sticky
	#completewith YetiHide         
	>>Look out for the Distress Beacon drop as you quest throughout Feralas
	.collect 8705,1,2766
	.accept 2766 >> Accept Find OOX-22/FE!
step
	#requires RokOrhan
    .goto Feralas,73.76,45.76,90,0
    .goto Feralas,72.03,36.89
     >> Kill the Woodpaw Gnolls North-west of Camp Mojache. Loot them for their Manes
    .complete 2862,1
step
    #completewith Scroll
    .goto Feralas,75.30,28.26,0
     >> Use Orwin's Shovel in your bags on the blue patches on the ground. Loot them for the Cobalt
    .complete 2987,1
step
	#completewith Shovel
    .goto Feralas,76.10,33.20,0
	>>Kill Ogres at the Gordunni Outpost
    .complete 2975,1
    .complete 2975,2
    .complete 2975,3
step
	#label Scroll
    .goto Feralas,75.25,34.44,60,0
    .goto Feralas,79.4,34.8,15,0
    .goto Feralas,80.5,34.3,15,0
    .goto Feralas,80.8,35.0,15,0
    .goto Feralas,75.1,29.8,15,0
    .goto Feralas,75.2,28.7,15,0
    .goto Feralas,74.6,27.9,15,0
    .goto Feralas,79.4,34.8,15,0
    .goto Feralas,80.5,34.3,15,0
    .goto Feralas,80.8,35.0,15,0
    .goto Feralas,75.1,29.8,15,0
    .goto Feralas,75.2,28.7,15,0
    .goto Feralas,74.6,27.9,15,0
    .goto Feralas,79.4,34.8,
     >> Run to the Gordunni Outpost and look for the small parchment. It can spawn in the main camp or in the east camp in the mountains. Follow the arrow for spawn points.
    .accept 2978 >> Accept The Gordunni Scroll
step
	#label Shovel
    .goto Feralas,75.30,28.26,60,0
    .goto Feralas,74.59,30.23
     >> Use Orwin's Shovel in your bags on the blue patches on the ground. Loot them for the Cobalt
    .complete 2987,1
step
    .goto Feralas,76.10,33.20
	>>Kill Ogres at the Gordunni Outpost
    .complete 2975,1
    .complete 2975,2
    .complete 2975,3
step << Shaman
	#completewith next
	.hs >> Hearth to Camp Mojache
>> Buy food/water if needed
step
    .goto Feralas,74.90,42.46
    .turnin 2862 >> Turn in War on the Woodpaw
    .accept 2863 >> Accept Alpha Strike
step
    .goto Feralas,75.80,43.58
    .turnin 2975 >> Turn in The Ogres of Feralas
    .accept 2980 >> Accept The Ogres of Feralas
    .turnin 2978 >> Turn in The Gordunni Scroll
    .accept 2979 >> Accept Dark Ceremony
step
    .goto Feralas,75.70,44.30
    .turnin 2987 >> Turn in Gordunni Cobalt
step << !Shaman
    .goto Feralas,74.80,45.20
    .home >> Set your Hearthstone to Camp Mojache
step
    .goto Feralas,68.80,48.00
     >> Kill Sprite Darters. Loot them for their Wings
    .complete 2973,1
step
    .goto Feralas,67.50,55.60
    .goto Feralas,69.05,55.78,0
    .goto Feralas,68.60,54.25,0
    .goto Feralas,71.51,55.98,0
    .goto Feralas,72.42,56.63,0
    .goto Feralas,73.21,56.25,0
     >> Kill Woodpaw Alphas. There's usually one in each camp
    .complete 2863,1
    .unitscan Woodpaw Alpha
step
     #completewith next
    .hs >> Hearth back to Camp Mojache
>> Buy food/water if needed
step
    .goto Feralas,76.00,42.80
    .turnin 2973 >> Turn in A New Cloak's Sheen
    .accept 2974 >> Accept A Grim Discovery
step
    .goto Feralas,74.90,42.50
    .turnin 2863 >> Turn in Alpha Strike
    .accept 2902 >> Accept Woodpaw Investigation
step
    .goto Feralas,67.10,46.40
     >> Kill Grimtotems in the area. Loot them for their horns
    .complete 2974,1
step
    .goto Feralas,71.60,55.90
     >> Click on the map sitting on top of the box
    .turnin 2902 >> Turn in Woodpaw Investigation
    .accept 2903 >> Accept The Battle Plans
step
    .goto Feralas,76.00,42.80
    .turnin 2974 >> Turn in A Grim Discovery
    .accept 2976 >> Accept A Grim Discovery
step
    .goto Feralas,74.90,42.40
    .turnin 2903 >> Turn in The Battle Plans
    .accept 7730 >> Accept Zukk'ash Infestation
    .accept 7731 >> Accept Stinglasher
step
	#completewith next
    .goto Feralas,73.38,62.94,0
     >> Kill Silithid mobs in the area. Loot them for their Carapaces
    .complete 7730,1
step
    .goto Feralas,76.90,61.60
     >> Kill Stinglasher. Loot it for its Glands
	>> It patrols all around the outside of the Silithid Hives
    .complete 7731,1
    .unitscan Stinglasher
step
    .goto Feralas,73.38,62.94
     >> Kill Silithid mobs in the area. Loot them for their Carapaces
    .complete 7730,1
step
    .goto Feralas,56.15,46.88,0
    #completewith egghypo
     >> Kill Rogue Vale Screechers. Use the Bramble on their corpses after killing them
    .complete 3520,1
	.unitscan Rogue Vale Screecher
step
    #completewith next
    .goto Feralas,58.59,69.85,0
     >> Kill Gordunni Mage-Lords. Loot them for the Gordunni Orb
    .complete 2979,1
step
    .goto Feralas,59.58,65.02
     >> Kill Gordunni Ogres in the area
    .complete 2980,1
    .complete 2980,2
    .complete 2980,3
step
    .goto Feralas,58.59,69.85
     >> Kill Gordunni Mage-Lords. Loot them for the Gordunni Orb
    .complete 2979,1
	.unitscan Gordunni Mage-Lord
step
	#label egghypo
    .goto Feralas,56.66,75.89
    >> Head south and look for Hippogryph nests by the mountains. Loot one of the Hippogryph Eggs
	.collect 8564,1 --Hippogryph Egg
step
    #label longelegant
    #sticky
    .goto Feralas,56.46,63.08,0
     >> Grind Frayfeather Hippogryphs. Loot them for Long Elegant Feathers
    .collect 4589,10
step
    .goto Feralas,56.15,46.88
     >> Kill Rogue Vale Screechers. Use the Bramble on their corpses after killing them
    .complete 3520,1
	.unitscan Rogue Vale Screecher
step
	#label YetiHide
    .goto Feralas,55.14,56.35,70,0
    .goto Feralas,53.12,56.27,70,0
    .goto Feralas,52.05,58.40
     >> Kill Yetis. Loot them for their Hides
    .complete 2822,1
step
    #requires longelegant
	.isOnQuest 2766
     >> Skip this step if you didn't find the Distress Beacon. 
    .accept 2766 >> Accept Find OOX-22/FE!
    .turnin 2766 >> Turn in Find OOX-22/FE!
step
	.isQuestTurnedIn 2766
    .goto Feralas,53.35,55.69
     >> Start the chicken escort. Be careful as this escort is HARD
	>> 3 Waves will spawn: 3 Yetis (each level 46), 3 Bears, then 4 Gnolls. Save all your very long cooldowns for the Gnolls, and use some on the Yetis
    .accept 2767 >> Accept Rescue OOX-22/FE!
step
     #completewith next
    .hs >> Hearth back to Camp Mojache
>> Buy food/water if needed
step
    .goto Feralas,75.80,43.58
    .turnin 2980 >> Turn in The Ogres of Feralas
    .turnin 2979 >> Turn in Dark Ceremony
    .accept 3002 >> Accept The Gordunni Orb
step
    .goto Feralas,74.40,43.40
    .accept 3121 >> Accept A Strange Request
step
    .goto Feralas,74.40,42.90
    .turnin 2822 >> Turn in The Mark of Quality
step
    .goto Feralas,74.90,42.50
    .turnin 7730 >> Turn in Zukk'ash Infestation
    .turnin 7731 >> Turn in Stinglasher
    .accept 7732 >> Accept Zukk'ash Report
step << Druid
    .goto Feralas,76.0,42.3
	.trainer >> Go and train your class spells
step << !Mage
    .goto Feralas,75.45,44.36
    .fly Orgrimmar >> Fly to Orgrimmar
step << Mage
	.zone Orgrimmar >> Teleport to Orgrimmar
step
    .goto Orgrimmar,39.20,86.30
    .turnin 3002 >> Turn in The Gordunni Orb
step << Mage
    .goto Orgrimmar,38.8,85.6
	.trainer >> Go and train your class spells
step << Priest
    .goto Orgrimmar,35.6,87.8
	.trainer >> Go and train your class spells
step
    .goto Orgrimmar,39.00,38.10
    .turnin 1262 >> Turn in Report to Zor
    .accept 7541 >> Accept Service to the Horde
    .turnin 7541 >> Turn in Service to the Horde
step << Shaman
    .goto Orgrimmar,38.6,36.0
	.trainer >> Go and train your class spells
step << Hunter
    .goto Orgrimmar,66.1,18.5
	.trainer >> Go and train your class spells
step << Hunter
    .goto Orgrimmar,66.3,14.8
	.trainer >> Go and train your pet spells
step << Warrior
    .goto Orgrimmar,79.7,31.4
	.trainer >> Go and train your class spells
step
    .goto Orgrimmar,56.50,46.60
    .turnin 7732 >> Turn in Zukk'ash Report
step
    .goto Orgrimmar,75.20,34.20
    .turnin 2976 >> Turn in A Grim Discovery
step
    .goto Orgrimmar,49.60,50.40
    .turnin 3121 >> Turn in A Strange Request
    .accept 3122 >> Accept Return to Witch Doctor Uzer'i
step << Rogue
    .goto Orgrimmar,44.0,54.6
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,48.0,46.0
	.trainer >> Go and train your class spells
step << Warlock
    .goto Orgrimmar,47.5,46.7
	.vendor >> Buy your pet upgrades if you got the money for it.
step
	#completewith next
   .goto Durotar,45.53,11.79,60 >> Run out of Orgrimmar
step
	>>Run up the Zeppelin Tower outside of Orgrimmar
    .goto Durotar,50.53,12.52
    .zone Stranglethorn Vale >> Take the Zeppelin to Stranglethorn Vale

]])

RXPGuides.RegisterGuide("RestedXP Horde 40-50",[[
#classic
<< Horde

#name 44-45 Southern Stranglethorn
#next 45-46 Swamp of Sorrows
#somname 43-45 Southern Stranglethorn

step
    .goto Stranglethorn Vale,32.20,27.60
    .accept 586 >> Accept Speaking with Gan'zulah
step
    .goto Stranglethorn Vale,32.10,29.20
    .accept 571 >> Accept Mok'thardin's Enchantment
step
    .goto Stranglethorn Vale,28.80,44.80
     >> Kill Tethis. Loot him for his Talon
	>> He patrols all around the raptor area
    .complete 197,1
	.unitscan Tethis
step
	#sticky
	#completewith Anathek
	>>Kill Trolls in the area. Loot them for Tusks and Necklaces
	.complete 586,1 --Kill Skullsplitter Hunter (x8)
    .complete 586,3 --Kill Skullsplitter Berserker (x4)
    .complete 586,2 --Kill Skullsplitter Headhunter (x6)
step
    #sticky
    #completewith next
    +This next quest can be quite hard, be extra careful
    #hardcore
step
   #label Anathek
	.goto Stranglethorn Vale,44.3,44.9,30,0
    .goto Stranglethorn Vale,45.8,41.2,30,0
    .goto Stranglethorn Vale,47.1,40.7,30,0
    .goto Stranglethorn Vale,44.3,44.9,30,0
    .goto Stranglethorn Vale,45.8,41.2,30,0
    .goto Stranglethorn Vale,47.1,40.7,30,0
    .goto Stranglethorn Vale,44.3,44.9,30,0
    .goto Stranglethorn Vale,45.8,41.2,30,0
    .goto Stranglethorn Vale,47.1,40.7,30,0
	>>Find & kill Ana'thek the Cruel. Loot his broken armor.
    .complete 586,4 --Collect Broken Armor of Ana'thek (x1)
step
    .goto Stranglethorn Vale,47.9,42.9,40,0
    .goto Stranglethorn Vale,47.6,44.1,40,0
    .goto Stranglethorn Vale,46.0,42.8,40,0
    .goto Stranglethorn Vale,44.4,41.9,40,0
    .goto Stranglethorn Vale,47.4,39.8,40,0
    .goto Stranglethorn Vale,47.9,42.9,40,0
    .goto Stranglethorn Vale,47.6,44.1,40,0
    .goto Stranglethorn Vale,46.0,42.8,40,0
    .goto Stranglethorn Vale,44.4,41.9,40,0
    .goto Stranglethorn Vale,47.4,39.8,40,0
    .goto Stranglethorn Vale,47.9,42.9,40,0
    .goto Stranglethorn Vale,47.6,44.1,40,0
    .goto Stranglethorn Vale,46.0,42.8,40,0
    .goto Stranglethorn Vale,44.4,41.9,40,0
    .goto Stranglethorn Vale,47.4,39.8,40,0
    .goto Stranglethorn Vale,47.9,42.9,40,0
    .goto Stranglethorn Vale,47.6,44.1,40,0
    .goto Stranglethorn Vale,46.0,42.8,40,0
    .goto Stranglethorn Vale,44.4,41.9,40,0
    .goto Stranglethorn Vale,47.4,39.8,40,0
	>>Kill Trolls in the area. Loot them for Tusks and Necklaces
	.complete 586,1 --Kill Skullsplitter Hunter (x8)
    .complete 586,3 --Kill Skullsplitter Berserker (x4)
    .complete 586,2 --Kill Skullsplitter Headhunter (x6)
step
    .goto Stranglethorn Vale,35.70,10.80
    .turnin 197 >> Turn in Raptor Mastery
    .accept 208 >> Accept Big Game Hunter
step
    .goto Stranglethorn Vale,32.20,27.70
     >> Click on the cauldron
    .turnin 586 >> Turn in Speaking with Gan'zulah
    .accept 588 >> Accept The Fate of Yenniku
step
    .goto Stranglethorn Vale,32.20,27.70
    .turnin 588 >> Turn in The Fate of Yenniku
    .accept 589 >> Accept The Singing Crystals
step
    .goto Stranglethorn Vale,32.54,29.36
    .fly Booty Bay >> Fly to Booty Bay
step
    .goto Stranglethorn Vale,26.70,76.40
    .accept 617 >> Accept Akiris by the Bundle
step
    .goto Stranglethorn Vale,27.10,77.30
    .accept 621 >> Accept Zanzil's Secret
step
	#era
    .goto Stranglethorn Vale,27.11,77.21
    .turnin 1118 >> Turn in Back to Booty Bay
step
    .goto Stranglethorn Vale,27.70,77.10
    .accept 606 >> Accept Scaring Shaky
step
    .goto Stranglethorn Vale,27.70,76.80
    .accept 348 >> Accept Stranglethorn Fever
step
    .goto Stranglethorn Vale,28.10,76.20
    .accept 595 >> Accept The Bloodsail Buccaneers
step
    .goto Stranglethorn Vale,26.70,73.60
    .accept 8551 >> Accept The Captain's Chest
step
    .goto Stranglethorn Vale,27.27,69.51
    .turnin 595 >> Turn in The Bloodsail Buccaneers
    .accept 597 >> Accept The Bloodsail Buccaneers
step
    .goto Stranglethorn Vale,28.09,76.21
    .turnin 597 >> Turn in The Bloodsail Buccaneers
    .accept 599 >> Accept The Bloodsail Buccaneers
step
    .goto Stranglethorn Vale,26.92,77.34
    .accept 587 >> Accept Up to Snuff
step
    .goto Stranglethorn Vale,27.17,77.00
    .turnin 599 >> Turn in The Bloodsail Buccaneers
    .accept 604 >> Accept The Bloodsail Buccaneers
step
	.isQuestComplete 2767
    .goto Stranglethorn Vale,28.35,76.35
    .turnin 2767 >> Turn in Rescue OOX-22/FE!
step
    .goto Stranglethorn Vale,28.59,75.89
    .accept 576 >> Accept Keep An Eye Out
step
	#completewith Orders
	>>Kill Bloodsail mobs. Loot them for Dizzy's Eye. You can finish this later
	.complete 576,1
step
	#completewith Orders
	>>Kill Bloodsail mobs. Loot them for Snuff. You can finish this later
	.complete 587,1
step
	#sticky
	#completewith next
    .goto Stranglethorn Vale,29.61,80.89,0
    .goto Stranglethorn Vale,27.75,83.13,0
    .goto Stranglethorn Vale,27.18,82.66,0
    .goto Stranglethorn Vale,26.94,82.49,0
	>> Loot the Bloodsail Orders and Bloodsail Charts. They look like scrolls on the ground
    .complete 604,2
    .complete 604,3
step
    .goto Stranglethorn Vale,28.00,82.40
     >> Kill Bloodsail Swashbucklers
    .complete 604,1
step
	#label Orders
    .goto Stranglethorn Vale,29.61,80.89,20,0
    .goto Stranglethorn Vale,27.75,83.13,20,0
    .goto Stranglethorn Vale,27.18,82.66,20,0
    .goto Stranglethorn Vale,26.94,82.49
	>> Loot the Bloodsail Orders and Bloodsail Charts. They look like scrolls on the ground
    .complete 604,2
    .complete 604,3
step
	#softcore
     #completewith next
    .goto Stranglethorn Vale,32.80,65.80,0
     >>Kill Gorillas. Loot them for Gorilla Fangs
    .collect 2799,10
step
	#hardcore
     #completewith next
    .goto Stranglethorn Vale,32.80,65.80,0
     >>Kill Gorillas. Loot them for Gorilla Fangs
	>>You can skip this if you want, the quest proceeding this is VERY difficult
    .collect 2799,10
step
    .goto Stranglethorn Vale,32.80,65.80
     >> Kill Gorillas. Loot them for their Giblets and Sinew
    .complete 606,1
    .complete 571,1
step
    .goto Stranglethorn Vale,32.80,65.80
     >> Keep grinding gorillas until you get 10 Gorilla fangs
    .collect 2799,10
step
	#completewith next
	+This quest will be very hard, consider skipping it.
	#hardcore
step
    .goto Stranglethorn Vale,35.27,60.40
	>> This quest is very hard. Use no cooldowns on wave 1. Use all cooldowns on wave 2. On wave 3 avoid them by going a bit up the mountain, then when they aggro the NPC kill the named mob only and loot it.
	.turnin 349 >> Turn in Stranglethorn Fever
step
    >> This quest is very hard. Use no cooldowns on wave 1. Use all cooldowns on wave 2. On wave 3 avoid them by going a bit up the mountain, then when they aggro the NPC kill the named mob only and loot it.
    .goto Stranglethorn Vale,35.27,60.40
     >> Collect Heart of Mokk
    .complete 348,1
step
	>>Run back to Booty Bay
    .goto Stranglethorn Vale,26.90,73.70
    .turnin 606 >> Turn in Scaring Shaky
    .accept 607 >> Accept Return to MacKinley
step
    .goto Stranglethorn Vale,27.60,76.70
    .turnin 348 >> Turn in Stranglethorn Fever
step
    .goto Stranglethorn Vale,27.70,77.10
    .turnin 607 >> Turn in Return to MacKinley
    .accept 609 >> Accept Voodoo Dues
step
    .goto Stranglethorn Vale,27.20,77.00
    .turnin 604 >> Turn in The Bloodsail Buccaneers
    .accept 608 >> Accept The Bloodsail Buccaneers
step
    .goto Stranglethorn Vale,26.87,77.10
    .fly Grom'gol >> Fly to Grom'gol
step
    .goto Stranglethorn Vale,32.10,29.20
    .turnin 571 >> Turn in Mok'thardin's Enchantment
    .accept 573 >> Accept Mok'thardin's Enchantment
step
    .goto Stranglethorn Vale,38.18,35.60
     >> Kill King Bangalash. Loot him for his head
	>> Be careful as this quest is HARD. He comes with 2 mobs when he spawns, and spawns 2 more at about 50%.
    .complete 208,1
--N Link?
step
    .goto Stranglethorn Vale,39.48,47.42,60,0
    .goto Stranglethorn Vale,41.67,50.19,60,0
    .goto Stranglethorn Vale,43.84,47.77
     >> Go into the cave. Kill Ironjaw Basilisks. Loot them for their Blue Shards 
    .complete 589,1
step
    #completewith Chucky
    .goto Stranglethorn Vale,35.26,51.28,0
     >> Kill Zanzil mobs. Loot them for the Mixture
    .complete 621,1
step
    .goto Stranglethorn Vale,37.46,49.46,70,0
    .goto Stranglethorn Vale,35.26,51.28,0
     >> Kill Maury. Loot his Clubbed Foot
    .complete 609,1
step
    .goto Stranglethorn Vale,34.92,51.84
     >> Kill Jon-Jon. Loot his Golden Spyglass
    .complete 609,2
step
    #label Chucky
	.goto Stranglethorn Vale,34.07,54.11,70,0
    .goto Stranglethorn Vale,40.00,58.24
     >> Kill Chucky. Loot his Huge Ring
    .complete 609,3
step
    .goto Stranglethorn Vale,39.44,58.47
     >> Kill Zanzil mobs. Loot them for the Mixture
	>> Do NOT pull or attack Zanzil the Outcast
    .complete 621,1
step
     >> Kill Gorlash. Loot him for Smotts' Chest
     >> You can kite him back to the Booty Bay guards, and get credit as long as you did the majority damage
	>> This quest is HARD depending on how well you can kite and do damage on the move. You can skip this quest if needed
    .goto Stranglethorn Vale,37.00,69.50
    .complete 8551,1
.link https://youtu.be/lNy2ohTWeLw?t=1037 >> CLICK HERE for a reference
step
	#era
    #sticky
    #completewith next
    +These next ships quests can be very aard. Be careful
    #hardcore
step
	#era
    #label Cortello
    #sticky
    .goto Stranglethorn Vale,32.90,88.20,0
    .goto Stranglethorn Vale,30.60,90.60,0
    .goto Stranglethorn Vale,29.30,88.30,0
     >> Look for Cortello's Riddle. It's a small scroll that can spawn in any of the 3 ships on the bottom and middle levels.
    .accept 624 >> Accept Cortello's Riddle
step
    .goto Stranglethorn Vale,32.90,88.20
     >> Kill Captain Stillwater in the 2nd floor at the back of the ship
    .complete 608,1
step
    .goto Stranglethorn Vale,30.60,90.60
     >> Kill Fleet Master Firallon in the 2nd floor at the back of the ship
    .complete 608,3
step
    .goto Stranglethorn Vale,29.30,88.30
     >> Kill Captain Keelhaul in the 2nd floor at the back of the ship. Be careful of Garr Salthoof who's just outside the room guarding him, as he is difficult
	>>Garr can charge for a LOT of damage, stun for 2 seconds, and Thrash
    .complete 608,2
step
	#completewith Orders
	>>Kill Bloodsail mobs. Loot them for Dizzy's Eye. You can finish this later
	.complete 576,1
step
	#completewith Orders
	>>Kill Bloodsail mobs. Loot them for Snuff. You can finish this later
	.complete 587,1
step
	#era
    #requires Cortello
	#sticky
	#label Dizzy
   .goto Stranglethorn Vale,26.97,82.70
	>>Kill Bloodsail mobs. Loot them for Dizzy's Eye. You can finish this later
	.complete 576,1
step
	#era
	#requires Cortello
   .goto Stranglethorn Vale,26.97,82.70
	>>Kill Bloodsail mobs. Loot them for Snuff. You can finish this later
	.complete 587,1
step
	#som
	#sticky
	#label Dizzy
   .goto Stranglethorn Vale,26.97,82.70
	>>Kill Bloodsail mobs. Loot them for Dizzy's Eye. You can finish this later
	.complete 576,1
step
	#som
   .goto Stranglethorn Vale,26.97,82.70
	>>Kill Bloodsail mobs. Loot them for Snuff. You can finish this later
	.complete 587,1
step
	#requires Dizzy
    #completewith next
     >> Kill Nagas. Loot them for Akiris Reed
    .complete 573,1
    .complete 617,1
step
	#requires Dizzy
    .goto Stranglethorn Vale,27.04,67.80,60,0
    .goto Stranglethorn Vale,24.75,63.60,60,0
    .goto Stranglethorn Vale,28.97,61.92
     >> Go up the mountain, across the bridge, and loot the Holy Spring Water from the spring
    .complete 573,2
step
    .goto Stranglethorn Vale,25.86,62.04
     >> Kill Nagas. Loot them for Akiris Reed
    .complete 573,1
    .complete 617,1
step
	.isQuestComplete 8551
	>>Run back to Booty Bay
    .goto Stranglethorn Vale,26.70,73.60
    .turnin 8551 >> Turn in The Captain's Chest
step
    .abandon 8551 >> Abandon The Captain's Chest
step
    .goto Stranglethorn Vale,28.60,75.90
    .turnin 576 >> Turn in Keep An Eye Out
step
    .goto Stranglethorn Vale,27.80,77.10
    .turnin 609 >> Turn in Voodoo Dues
step
    .goto Stranglethorn Vale,26.70,76.40
    .turnin 617 >> Turn in Akiris by the Bundle
step
    .goto Stranglethorn Vale,27.11,77.21
    .turnin 621 >> Turn in Zanzil's Secret
step
    .goto Stranglethorn Vale,27.13,77.44
    .accept 580 >> Accept Whiskey Slim's Lost Grog
step
	#era
    .goto Stranglethorn Vale,27.11,77.21
    .accept 1119 >> Accept Zanzil's Mixture and a Fool's Stout
step
    .goto Stranglethorn Vale,27.00,77.30
    .turnin 587 >> Turn in Up to Snuff
step
    .goto Stranglethorn Vale,27.10,77.00
    .turnin 608 >> Turn in The Bloodsail Buccaneers
step
    .goto Stranglethorn Vale,26.87,77.10
    .fly Grom'gol >> Fly to Grom'gol
step
    .goto Stranglethorn Vale,32.10,29.20
    .turnin 573 >> Turn in Mok'thardin's Enchantment
step
    .goto Stranglethorn Vale,32.20,27.80
    .turnin 589 >> Turn in The Singing Crystals
step
     #completewith next
    .goto Stranglethorn Vale,35.70,10.80,0
     +Turn in all journal pages that you have.
step
    .goto Stranglethorn Vale,35.70,10.80
    .turnin 208 >> Turn in Big Game Hunter
step
	#som
    .hs >> Hearth to Camp Mojache
>> Buy food/water if needed
step
	#era
    .goto Stranglethorn Vale,32.6,29.2
    .fly Stonard>> Fly to Stonard
]])