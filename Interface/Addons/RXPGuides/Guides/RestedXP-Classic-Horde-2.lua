
RXPGuides.RegisterGuide("RestedXP Horde 40-50",[[
#classic
<< Horde

#name 45-46 Swamp of Sorrows
#next 46-48 Tanaris
#era

step
	#era
	>>Run toward the Blasted Lands border
    .goto Swamp of Sorrows,34.30,66.00
    .accept 2784 >> Accept Fall From Grace
step
	#era
    .goto Swamp of Sorrows,34.30,66.00
     >> Go through the whole dialogue
    .complete 2784,1
    .skipgossip 
step
	#era
    .goto Blasted Lands,52.76,2.93
    .turnin 2784 >> Turn in Fall From Grace
    .accept 2621 >> Accept The Disgraced One
step
	#era
    .goto Swamp of Sorrows,47.90,55.00
    .accept 1429 >> Accept The Atal'ai Exile
    .turnin 2621 >> Turn in The Disgraced One
    .accept 2622 >> Accept The Missing Orders
step
	#era
    .goto Swamp of Sorrows,81.31,80.97
    .accept 699 >> Accept Lack of Surplus
step
	#era
    .goto Swamp of Sorrows,74.10,17.34,0
     >> Kill Sawtooth Snappers. Loot them for their Claws
    .complete 699,1
step
	#era
    .goto Swamp of Sorrows,81.40,80.80
    .turnin 699 >> Turn in Lack of Surplus
    .accept 1422 >> Accept Threat From the Sea
step
	#era
    .goto Swamp of Sorrows,83.70,80.50
    .turnin 1422 >> Turn in Threat From the Sea
    .accept 1426 >> Accept Threat From the Sea
step
	#era
    .goto Swamp of Sorrows,83.55,90.37
	>>Kill the murlocs along the shore
    .complete 1426,1
    .complete 1426,2
    .complete 1426,3
step
	#era
    .goto Swamp of Sorrows,83.70,80.50
    .turnin 1426 >> Turn in Threat From the Sea
    .accept 1427 >> Accept Threat From the Sea
step
	#era
    .goto Swamp of Sorrows,81.40,80.80
    .turnin 1427 >> Turn in Threat From the Sea
step
	#era
    .goto Swamp of Sorrows,83.75,80.41
    .accept 1428 >> Accept Continued Threat
step
	#era
    .goto Swamp of Sorrows,66.08,77.67,60,0
    .goto Swamp of Sorrows,62.90,87.40
     >> Kill the Swamp Talker. Loot him for the Warchief's Orders
     >> This quest can be quite hard, save your cooldowns for the boss & kill the small mobs he spawns, they die in 1 hit.
    .complete 2623,1
    .unitscan Swamp Talker
step
	#era
    .goto Swamp of Sorrows,62.98,85.34
	>>Kill the murlocs along the shore... again
    .complete 1428,1
    .complete 1428,2
    .complete 1428,3
step
	#era
    .goto Swamp of Sorrows,83.70,80.40
    .turnin 1428 >> Turn in Continued Threat
step
	#softcore
	#era
     #completewith next
     >> Die and respawn at the Spirit Healer
step << Hunter
	#era
    .goto Swamp of Sorrows,47.3,53.4
	.trainer >> Go and train your class spells
step << Hunter
	#era
    .goto Swamp of Sorrows,47.4,52.4
     .trainer >> Go and train your pet spells
step << Warlock
	#era
    .goto Swamp of Sorrows,48.6,55.6
    .trainer >> Go and train your class spells
step << Warlock
	#era
    .goto Swamp of Sorrows,48.6,55.3
	.vendor >> Buy your pet upgrades if you got the money for it.
step << Shaman
	#era
    .goto Swamp of Sorrows,48.2,57.9
    .trainer >> Go and train your class spells
step << Warrior
	#era
    .goto Swamp of Sorrows,44.9,57.6
    .trainer >> Go and train your class spells
step
	#era
    .goto Swamp of Sorrows,34.30,66.00
    .turnin 2623 >> Turn in The Swamp Talker
    .accept 2801 >> Accept A Tale of Sorrow
step
	#era
     >> Go through the whole dialogue
    .complete 2801,1
    .skipgossip 
step
	#era
    .goto Blasted Lands,52.76,2.93
    .turnin 2801 >> Turn in A Tale of Sorrow
step
	#era
    .goto Swamp of Sorrows,22.90,48.30
	>>Underwater
    .turnin 624 >> Turn in Cortello's Riddle
    .accept 625 >> Accept Cortello's Riddle
step
	#era
    .hs >> Hearth to Camp Mojache
>> Buy food/water if needed
step << Druid
	#era
    .goto Feralas,76.0,42.3
	.trainer >> Go and train your class spells
step
	#era
    .goto Feralas,74.50,43.40
    .turnin 3122 >> Turn in Return to Witch Doctor Uzer'i
    .accept 3123 >> Accept Testing the Vessel
    .accept 3380 >> Accept The Sunken Temple
step
	#era
    .goto Feralas,75.45,44.36
    .fly Tanaris>> Fly to Tanaris
]])

RXPGuides.RegisterGuide("RestedXP Horde 40-50",[[
#classic
<< Horde

#name 46-48 Tanaris
#next 48-49 The Hinterlands
#somname 45-47 Tanaris


step << Druid
	#som
    .goto Feralas,76.0,42.3
	.trainer >> Go and train your class spells
step
	#som
    .goto Feralas,74.50,43.40
    .turnin 3122 >> Turn in Return to Witch Doctor Uzer'i
    .accept 3123 >> Accept Testing the Vessel
    .accept 3380 >> Accept The Sunken Temple
step
	#som
    .goto Feralas,75.45,44.36
    .fly Tanaris>> Fly to Tanaris
step
	#era
    .goto Tanaris,52.70,7.80
    .turnin 1119 >> Turn in Zanzil's Mixture and a Fool's Stout
step
    .goto Tanaris,54.30,7.10
    .turnin 1187 >> Turn in Razzeric's Tweaking
    .accept 1188 >> Accept Safety First
step
	#era
    .goto Tanaris,52.70,7.80
    .accept 1120 >> Accept Get the Gnomes Drunk
step
	#era
    .goto Tanaris,52.60,7.60
    .turnin 1120 >> Turn in Get the Gnomes Drunk
step
	#era
    .goto Tanaris,52.70,7.80
    .accept 1122 >> Accept Report Back to Fizzlebub
step
    .goto Tanaris,50.21,27.48
    .accept 82 >> Accept Noxious Lair Investigation
step
    .goto Tanaris,51.90,27.00
    .accept 2875 >> Accept WANTED: Andre Firebeard
step
    .goto Tanaris,51.56,26.75
    .accept 3362 >> Accept Thistleshrub Valley
step
    .goto Tanaris,51.00,27.30
    .turnin 1188 >> Turn in Safety First
step
    .goto Tanaris,51.80,28.60
    .accept 2605 >> Accept The Thirsty Goblin
step
    .goto Tanaris,52.50,27.90
    .home >> Set your Hearthstone to Gadgetzan
step
    .goto Tanaris,52.80,27.40
    .accept 5863 >> Accept The Dunemaul Compound
step
    .goto Tanaris,52.30,27.00
     >> Click on the Egg-O-Matic and turn in your Hippogryph Egg (The Super Egg-O-Matic) It's a small metal console sitting next to the teleporter
    .accept 2741 >> Accept The Super Egg-O-Matic
    .turnin 2741 >> Turn in The Super Egg-O-Matic
step
    .goto Tanaris,66.60,22.30
    .accept 8365 >> Accept Pirate Hats Ahoy!
step
    .goto Tanaris,67.00,22.40
    .turnin 3520 >> Turn in Screecher Spirits
step
    .goto Tanaris,67.10,23.90
    .accept 8366 >> Accept Southsea Shakedown
    .accept 2873 >> Accept Stoley's Shipment
step
	#completewith next
    .goto Tanaris,68.76,41.51,70 >> Head to Lost Rigger Cove
step
    #sticky
	#completewith Hats
    .goto Tanaris,73.37,47.14,0
     >> Kill Andre Firebeard by the campfire. Be careful as he pulls with the mobs behind him
	>> Split pull him if you can << Mage/Warlock
    .complete 2875,1
step
	#sticky
	#completewith Pirates
     >> Kill pirates. Loot them for their Hats
    .complete 8365,1
step
     #completewith next
    .goto Tanaris,73.97,47.50,0
	>>Kill Pirates in the Cove
    .complete 8366,1
    .complete 8366,2
    .complete 8366,3
    .complete 8366,4
step
    .goto Tanaris,72.63,46.81,30,0
    .goto Tanaris,72.15,46.76
     >> Loot the brown boxes upstairs in the building
    .complete 2873,1
step
	#completewith BugHole   
	>>Look out for the Distress Beacon drop as you quest throughout Tanaris
	.collect 8623,1,351
	.accept 351 >> Accept Find OOX-17/TN!
step
	#label Pirates
    .goto Tanaris,73.97,47.50
	>>Kill Pirates in the Cove
    .complete 8366,1
    .complete 8366,2
    .complete 8366,3
    .complete 8366,4
step
	#label Hats
    .goto Tanaris,73.97,47.50
     >> Kill pirates. Loot them for their Hats
    .complete 8365,1
step
    .goto Tanaris,73.37,47.14
     >> Kill Andre Firebeard by the campfire. Be careful as he pulls with the mobs behind him
	>> Split pull him if you can << Mage/Warlock
    .complete 2875,1
step
    .goto Tanaris,52.70,45.92
	>>Leave Lost Rigger Cove
    .turnin 3380 >> Turn in The Sunken Temple
    .accept 3161 >> Accept Gahz'ridian << !Hunter
step
    .goto Tanaris,34.54,39.82
     >> Kill Silithids. Loot them for their Insect Parts
	>> Be careful, as these mobs can be difficult
    .complete 82,1
step
	#sticky
	#label GorMarok
    .goto Tanaris,41.50,57.80
     >> Kill Gor'marok the Ravager in the cave. Be careful as he has Mortal Strike and deals a LOT of damage
    .complete 5863,3
step
    .goto Tanaris,41.32,55.22
     >> Kill Ogres in the area
    .complete 5863,1
    .complete 5863,2
step
	#requires GorMarok
     #sticky
	#label DewC
    .goto Tanaris,30.38,65.51
     >> Kill Dew Collectors. Loot them for the Laden Dew Gland
    .complete 2605,1
step
	#requires GorMarok
    .goto Tanaris,28.70,64.06
     >> Kill the Elementals in the area
    .complete 3362,1
    .complete 3362,2
step
	#requires DewC
    .goto Tanaris,29.37,59.97,80,0
    .goto Tanaris,28.70,67.32,80,0
    .goto Tanaris,31.66,74.70
    .goto Tanaris,29.37,59.97,0
    .goto Tanaris,28.70,67.32,0
     >> Look for Tooga. Start his escort quest
	>> Be VERY careful to not run too far ahead of Tooga and fail the quest
    .accept 1560 >> Accept Tooga's Quest
    .unitscan Tooga
step << !Hunter
   .goto Tanaris,40.53,72.80
     >> Equip the Helmet provided. Loot the patches of sand on the ground (and on the minimap). Loot them for the Ornaments
	>> Be VERY careful to not run too far ahead of Tooga and fail the quest
    .complete 3161,1
step
    .goto Tanaris,66.60,25.70
	>> Be VERY careful to not run too far ahead of Tooga and fail the quest
    .complete 1560,1 --Lead Tooga to Torta (1)
    .turnin 1560 >> Turn in Tooga's Quest
step
    .goto Tanaris,67.00,23.90
    .turnin 2875 >> Turn in WANTED: Andre Firebeard
    .turnin 8366 >> Turn in Southsea Shakedown
    .turnin 2873 >> Turn in Stoley's Shipment
    .accept 2874 >> Accept Deliver to MacKinley
step
    .goto Tanaris,66.60,22.30
    .turnin 8365 >> Turn in Pirate Hats Ahoy!
step
     #completewith next
    .hs >> Hearth back to Gadgetzan
>> Buy food/water if needed
step << skip
    .goto Tanaris,52.30,28.92
    .bankdeposit 9245 >> Deposit Stoley's Bottle in your bank
step
    .goto Tanaris,51.80,28.60
    .turnin 2605 >> Turn in The Thirsty Goblin
    .accept 2606 >> Accept In Good Taste
step
    .goto Tanaris,50.90,27.00
    .turnin 82 >> Turn in Noxious Lair Investigation
step
    .goto Tanaris,51.10,26.90
    .turnin 2606 >> Turn in In Good Taste
    .accept 2641 >> Accept Sprinkle's Secret Ingredient
step
    .goto Tanaris,50.20,27.50
    .accept 10 >> Accept The Scrimshank Redemption
step
    .goto Tanaris,51.50,26.80
    .turnin 3362 >> Turn in Thistleshrub Valley
step
    .goto Tanaris,52.80,27.40
    .turnin 5863 >> Turn in The Dunemaul Compound
step
    .goto Tanaris,52.70,45.90
    .turnin 3380 >> Turn in The Sunken Temple
    .turnin 3161 >> Turn in Gahz'ridian << !Hunter
step
	#label BugHole
    .goto Tanaris,55.69,69.44,50,0
    .goto Tanaris,56.36,68.44,30,0
    .goto Tanaris,57.45,70.45,30,0
    .goto Tanaris,55.96,71.16
     >> Enter the Silithid Hive underground. Loot the Machine Console
    .complete 10,1
step
    .isOnQuest 351
    .goto Tanaris,60.20,64.70
    .accept 351 >> Accept Find OOX-17/TN!
    .turnin 351 >> Turn in Find OOX-17/TN!
step
    .isQuestTurnedIn 351
    .goto Tanaris,60.23,64.71
     >> Start the escort quest
    .accept 648 >> Accept Rescue OOX-17/TN!
step
    .isQuestTurnedIn 351
    .goto Tanaris,67.09,23.18
     >> Escort the robot chicken back to Steamwheedle Port
	>> Be careful as this quest can be HARD. 2 Waves will spawn: A pack of 3 level 46-47 scorpions, and a pack of level 43-45 Wastewander mobs, one Shadow Mage, one Assassin, and one Scofflaw
	>> Be careful as the Scofflaw can execute you when you're below 20% health
    .complete 648,1
step << Shaman
	.hs >> Hearth to Gadgetzan
>> Buy food/water if needed
step
    .goto Tanaris,50.21,27.48
    .turnin 10 >> Turn in The Scrimshank Redemption
    .accept 110 >> Accept Insect Part Analysis
step
    .goto Tanaris,50.90,27.00
    .turnin 110 >> Turn in Insect Part Analysis
    .accept 113 >> Accept Insect Part Analysis
step
    .goto Tanaris,50.20,27.50
    .turnin 113 >> Turn in Insect Part Analysis
    .accept 32 >> Accept Rise of the Silithid
step
	#era
    .goto Tanaris,51.60,25.50
    .fly Brackenwall >> Fly to Brackenwall
step
	#era
    .goto Dustwallow Marsh,37.10,33.00
    .accept 1170 >> Accept The Brood of Onyxia
step
	#era
    .goto Dustwallow Marsh,36.30,31.40
    .turnin 1170 >> Turn in The Brood of Onyxia
    .accept 1171 >> Accept The Brood of Onyxia
step
	#era
    .goto Dustwallow Marsh,37.10,33.00
    .turnin 1171 >> Turn in The Brood of Onyxia
    .accept 1172 >> Accept The Brood of Onyxia
step
	#era
	>>Go inside the Raptor cave
    .goto Dustwallow Marsh,31.10,66.10
    .turnin 625 >> Turn in Cortello's Riddle
    .accept 626 >> Accept Cortello's Riddle
step
	#era
    .goto Dustwallow Marsh,48.50,75.30
	>>Right click on the Eggs in the stump
    .complete 1172,1
step
	#era
	>>Run back to Brackenwall
    .goto Dustwallow Marsh,37.15,33.08
    .turnin 1172 >> Turn in The Brood of Onyxia
step
	#era
    .goto Dustwallow Marsh,36.30,31.50
	>> Accepting this quest turns Overlord Mok'Morokk hostile. Be prepared
	>> Be careful, as this quest can be HARD
    .accept 1173 >> Accept Challenge Overlord Mok'Morokk
step
	#era
     >> Defeat Overlord Mok'Morokk by reducing his health to about 30%
    .complete 1173,1
step
	#era
    .goto Dustwallow Marsh,37.10,33.00
    .turnin 1173 >> Turn in Challenge Overlord Mok'Morokk
step << !Mage
	#era
    .goto Dustwallow Marsh,35.57,31.89
    .fly Thunder Bluff>> Fly to Thunder Bluff
step << !Mage
	#som
    .goto Tanaris,51.60,25.50
    .fly Thunder Bluff>> Fly to Thunder Bluff
step << Mage
	.zone Thunder Bluff >> Teleport to Thunder Bluff
step
    .goto Thunder Bluff,61.50,80.90
    .turnin 1205 >> Turn in Deadmire
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
step 
	#softcore
	>>Go to the Auction House. Buy 15 Silk Cloth
    .goto Thunder Bluff,40.42,51.74
      .collect 4306,15
step << !Mage
    .goto Thunder Bluff,46.9,49.9
    .fly Orgrimmar>> Fly to Orgrimmar
step << Mage
	.zone Orgrimmar >> Teleport to Orgrimmar
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
step << Mage
    .goto Orgrimmar,38.8,85.6
	.trainer >> Go and train your class spells
step << Priest
    .goto Orgrimmar,35.6,87.8
	.trainer >> Go and train your class spells
step
    .goto Orgrimmar,56.40,46.50
    .turnin 32 >> Turn in Rise of the Silithid
step
    .goto Orgrimmar,59.40,36.70
    .accept 649 >> Accept Ripple Recovery
step
    .goto Orgrimmar,59.50,36.80
    .turnin 649 >> Turn in Ripple Recovery
    .accept 650 >> Accept Ripple Recovery
step
    .goto Orgrimmar,55.52,34.07
    .accept 4300 >> Accept Bone-Bladed Weapons
step << !Mage
    #sticky
    #completewith next
	+Go to the Zeppelin tower. Take the zeppelin to Tirisfal
	.goto Durotar,50.8,13.8
step << !Mage
	.zone Tirisfal Glades >>Arrive in Tirisfal Glades
step << Mage
	.zone Undercity >> Teleport to Undercity
]])

RXPGuides.RegisterGuide("RestedXP Horde 40-50",[[
#classic
<< Horde

#name 48-49 The Hinterlands
#next 49-50 Feralas
#somname 47-49 The Hinterlands

step << Mage
    .goto Undercity,82.79,15.82
    .vendor >> Go to Hannah. Buy four Runes of Teleportation (or more if you want)
    .collect 17031,4 --Rune of Teleportation (4)
step
    .goto Undercity,73.20,32.80
    .accept 2995 >> Accept Lines of Communication
step
    .goto Undercity,48.50,71.90
    .accept 3568 >> Accept Seeping Corruption
step
    .isOnQuest 864
    .goto Undercity,50.00,68.20
    .turnin 864 >> Turn in Return to Apothecary Zinge
step
    .goto Undercity,63.25,48.56
    .fly Tarren Mill >> Fly to Tarren Mill
step
    .goto Hillsbrad Foothills,88.44,27.44,80 >> Take the path from Hillsbrad to The Hinterlands
step
	#completewith VenomB
	+As you quest through Hinterlands, keep an eye out for the Distress Beacon that can drop. Do NOT drop it
step
    #sticky
	#completewith ViHo
    .goto The Hinterlands,9.56,56.00,60,0
    .goto The Hinterlands,25.88,53.18,0
     >> Kill Wildkin. Use the Wildkin Muisek Vessel on their corpses
    .complete 3123,1
step
	#label VenomB
    .goto The Hinterlands,23.50,58.80
	>>Loot one of the bottles on the table
    .accept 2933 >> Accept Venom Bottles
step
    .goto The Hinterlands,26.70,48.60
    .turnin 650 >> Turn in Ripple Recovery
    .accept 77 >> Accept A Sticky Situation
step
	#label ViHo
    .goto The Hinterlands,72.50,66.20,50,0
    .goto The Hinterlands,77.10,80.00
     >> Head to Revantusk Village
    .accept 7839 >> Accept Vilebranch Hooligans
step
    .goto The Hinterlands,78.20,81.30
    .accept 7840 >> Accept Lard Lost His Lunch
step
    .goto The Hinterlands,80.40,81.50
    .accept 7815 >> Accept Snapjaws, Mon!
    .accept 7816 >> Accept Gammerita, Mon!
step
	#era
    #completewith Cortello
    .goto The Hinterlands,81.87,49.36,0
    .goto The Hinterlands,79.86,60.32,0
    .goto The Hinterlands,78.54,67.85,0
    .goto The Hinterlands,79.14,71.45,0
    .goto The Hinterlands,77.47,75.83,0
    .goto The Hinterlands,78.83,76.26,0
     >> Loot the blue bottles on the ground near the shore
    .complete 580,1
step
	#era
    #completewith Cortello
    .goto The Hinterlands,81.87,49.36,0
    .goto The Hinterlands,79.86,60.32,0
    .goto The Hinterlands,78.54,67.85,0
    .goto The Hinterlands,79.14,71.45,0
    .goto The Hinterlands,77.47,75.83,0
    .goto The Hinterlands,78.83,76.26,0
     >> Kill Gammerita. She patrols up and down
    .complete 7816,1
    .unitscan Gammerita
step
	#era
    #completewith Cortello
    .goto The Hinterlands,81.87,49.36,0
    .goto The Hinterlands,79.86,60.32,0
    .goto The Hinterlands,78.54,67.85,0
    .goto The Hinterlands,79.14,71.45,0
    .goto The Hinterlands,77.47,75.83,0
    .goto The Hinterlands,78.83,76.26,0
     >> Kill turtles along the shore
    .complete 7815,1
step
	#era
	#label Cortello
	>>Loot the chest beneath the waterfall
    .goto The Hinterlands,80.80,46.80
    .turnin 626 >> Turn in Cortello's Riddle
step
	#som
    #completewith Picnicbasket
    .goto The Hinterlands,81.87,49.36,0
    .goto The Hinterlands,79.86,60.32,0
    .goto The Hinterlands,78.54,67.85,0
    .goto The Hinterlands,79.14,71.45,0
    .goto The Hinterlands,77.47,75.83,0
    .goto The Hinterlands,78.83,76.26,0
     >> Loot the blue bottles on the ground near the shore
    .complete 580,1
step
	#som
    #completewith Picnicbasket
    .goto The Hinterlands,81.87,49.36,0
    .goto The Hinterlands,79.86,60.32,0
    .goto The Hinterlands,78.54,67.85,0
    .goto The Hinterlands,79.14,71.45,0
    .goto The Hinterlands,77.47,75.83,0
    .goto The Hinterlands,78.83,76.26,0
     >> Kill Gammerita. She patrols up and down
    .complete 7816,1
    .unitscan Gammerita
step
	#som
    #completewith Picnicbasket
    .goto The Hinterlands,81.87,49.36,0
    .goto The Hinterlands,79.86,60.32,0
    .goto The Hinterlands,78.54,67.85,0
    .goto The Hinterlands,79.14,71.45,0
    .goto The Hinterlands,77.47,75.83,0
    .goto The Hinterlands,78.83,76.26,0
     >> Kill turtles along the shore
    .complete 7815,1
step
	#label Picnicbasket
    .goto The Hinterlands,84.40,41.30
     >> Loot Lard's Picnic Basket. 3 level 49 mobs will spawn (they ALL have execute and can use it when you're below 20% health) - Loot one of them for Lard's Lunch
	>> This quest can be tricky
    .complete 7840,1
step
	#sticky
	#label Turtles
    .goto The Hinterlands,79.86,60.32,80,0
    .goto The Hinterlands,78.54,67.85,80,0
    .goto The Hinterlands,79.14,71.45,80,0
    .goto The Hinterlands,77.47,75.83,80,0
    .goto The Hinterlands,78.83,76.26
     >> Kill turtles along the shore
    .complete 7815,1
step
    #sticky
	#label Gammerita
    .goto The Hinterlands,79.86,60.32,80,0
    .goto The Hinterlands,78.54,67.85,80,0
    .goto The Hinterlands,79.14,71.45,80,0
    .goto The Hinterlands,77.47,75.83,80,0
    .goto The Hinterlands,78.83,76.26
     >> Kill Gammerita. She patrols up and down
    .complete 7816,1
    .unitscan Gammerita
step
    #sticky
	#label Bottles
    .goto The Hinterlands,79.86,60.32,80,0
    .goto The Hinterlands,78.54,67.85,80,0
    .goto The Hinterlands,79.14,71.45,80,0
    .goto The Hinterlands,77.47,75.83,80,0
    .goto The Hinterlands,78.83,76.26
     >> Loot the blue bottles on the ground near the shore
    .complete 580,1
step
	#requires Turtles
step
	#requires Gammerita
step
	#requires Bottles
    .goto The Hinterlands,80.30,81.40
    .turnin 7815 >> Turn in Snapjaws, Mon!
    .turnin 7816 >> Turn in Gammerita, Mon!
step
    .goto The Hinterlands,78.20,81.30
    .turnin 7840 >> Turn in Lard Lost His Lunch
step
    .goto The Hinterlands,78.80,78.40
    .accept 7844 >> Accept Cannibalistic Cousins
step
    .goto The Hinterlands,79.40,79.10
    .accept 7841 >> Accept Message to the Wildhammer
step
    .goto The Hinterlands,79.10,79.50
    .accept 7828 >> Accept Stalking the Stalkers
    .accept 7829 >> Accept Hunt the Savages
    .accept 7830 >> Accept Avenging the Fallen
step
    #completewith Bucket
    .goto The Hinterlands,70.90,62.40,0
     >> Kill Silvermane Stalkers
    .complete 7828,1
step
    #completewith Bucket
     >> Kill Savage Owlbeasts
    .complete 7829,1
step
    #completewith Bucket
	>>Kill Trolls
    .complete 7844,1
    .complete 7844,2
step
    #completewith next
    .goto The Hinterlands,72.60,53.00,0
    .goto The Hinterlands,71.00,48.60,0
    .goto The Hinterlands,66.40,44.80,0
    .goto The Hinterlands,57.40,42.40,0
    .goto The Hinterlands,53.30,38.80,0
     >> Loot the small bucket on the ground. It has 5 different possible spawn locations
    .complete 7839,1
step
    .goto The Hinterlands,57.50,39.50
     >> Loot the Horde Supply crates inside of the cave at Skulk Rock for the Honey Ripple
    .complete 77,1
step
	#label Bucket
    .goto The Hinterlands,72.60,53.00,10,0
    .goto The Hinterlands,71.00,48.60,10,0
    .goto The Hinterlands,66.40,44.80,10,0
    .goto The Hinterlands,57.40,42.40,10,0
    .goto The Hinterlands,53.30,38.80,10,0
    .goto The Hinterlands,72.60,53.00,0
    .goto The Hinterlands,71.00,48.60,0
    .goto The Hinterlands,66.40,44.80,0
    .goto The Hinterlands,57.40,42.40,0
    .goto The Hinterlands,53.30,38.80,0
     >> Loot the small bucket on the ground. It has 5 different possible spawn locations
    .complete 7839,1
step
	#completewith Tragan
    .goto The Hinterlands,47.56,59.04,0
     >> Kill Silvermane Howlers
    .complete 7828,2
step
    #sticky
	#completewith Tragan
    .goto The Hinterlands,9.56,56.00,60,0
    .goto The Hinterlands,25.88,53.18,0
     >> Kill Wildkin. Use the Wildkin Muisek Vessel on their corpses
	>> This will not work on the Savage Owlbeasts
    .complete 3123,1
step
	#completewith Escort
    .goto The Hinterlands,30.73,46.97,0
	>>Kill Highvales in the area
    .complete 7841,1
    .complete 7841,2
    .complete 7841,3
    .complete 7841,4
step
	#sticky
	#label Notes
    .goto The Hinterlands,29.60,48.70
     >> Burn the Highvale Notes on the ground
    .complete 2995,2
step
    .goto The Hinterlands,28.60,46.10
     >> Burn the Highvale Report on the table
    .complete 2995,3
step
	#requires Notes
    .goto The Hinterlands,32.00,46.90
     >> Burn the Highvale Records on the ground
    .complete 2995,1
step
    .goto The Hinterlands,30.73,46.97
     >> Talk to Rin'ji. Start the escort quest
    .accept 2742 >> Accept Rin'ji is Trapped!
step
	#label Escort
	>>Escort Rin'ji
    .goto The Hinterlands,34.98,56.92
    .complete 2742,1
step
    .goto The Hinterlands,31.00,49.49
	>>Finish killing the Highvale Elves
    .complete 7841,1
    .complete 7841,2
    .complete 7841,3
    .complete 7841,4
step
	#label Tragan
    .goto The Hinterlands,40.00,59.90
     >> Go underwater. Loot one of the mushrooms
    .complete 2641,1
step
    .goto The Hinterlands,26.23,62.21
     >> Kill Wildkin. Use the Wildkin Muisek Vessel on their corpses
	>> This will not work on the Savage Owlbeasts
    .complete 3123,1
step
    .goto The Hinterlands,47.56,59.04
     >> Kill Silvermane Howlers
    .complete 7828,2
step
   .goto The Hinterlands,48.00,67.15
	>>Finish killing the Scalpers and Soothsayers in the area. DONT go on top of the Altar, as there are elites up there
    .complete 7844,1
    .complete 7844,2
step
	#completewith Stalkers
    .goto The Hinterlands,64.90,62.40,0
     >> Kill Savage Owlbeasts
    .complete 7829,1
step
    #completewith Stalkers
    .goto The Hinterlands,62.90,52.40,0
     >> Find and kill a Razorbeak Skylord. Look it for a Skylord Plume
    .complete 7830,1
    .unitscan Razorbeak Skylord
step
	#label Stalkers
    .goto The Hinterlands,70.90,62.40
     >> Kill Silvermane Stalkers
    .complete 7828,1
step
	#completewith next
    .goto The Hinterlands,64.90,62.40,0
     >> Kill Savage Owlbeasts
    .complete 7829,1
step
    .goto The Hinterlands,62.90,52.40
     >> Find and kill a Razorbeak Skylord. Look it for a Skylord Plume
    .complete 7830,1
    .unitscan Razorbeak Skylord
step
    .goto The Hinterlands,64.90,62.40
     >> Kill Savage Owlbeasts
    .complete 7829,1
step
	>>Swim to the island to the far east
    .goto The Hinterlands,86.30,59.00
    .turnin 2742 >> Turn in Rin'ji is Trapped!
    .accept 2782 >> Accept Rin'ji's Secret
step
	>>Run back to Revantusk Village
    .goto The Hinterlands,77.20,80.20
    .turnin 7839 >> Turn in Vilebranch Hooligans
step
    .goto The Hinterlands,78.80,78.40
    .turnin 7844 >> Turn in Cannibalistic Cousins
step
    .goto The Hinterlands,79.10,79.50
    .turnin 7828 >> Turn in Stalking the Stalkers
    .turnin 7829 >> Turn in Hunt the Savages
    .turnin 7830 >> Turn in Avenging the Fallen
step
	#hardcore
	>>You can accept the follow-up to these quests, but be aware that it DOES flag you for PVP in a densely-populated Alliance area
    .goto The Hinterlands,79.30,79.10
    .turnin 7841 >> Turn in Message to the Wildhammer
    .accept 7842 >> Accept Another Message to the Wildhammer
    .turnin 7842 >> Turn in Another Message to the Wildhammer
step
    #softcore
    .goto The Hinterlands,79.38,79.08
    .turnin 7841 >> Turn in Message to the Wildhammer
    .accept 7842 >> Accept Another Message to the Wildhammer
    .turnin 7842 >> Turn in Another Message to the Wildhammer
    .accept 7843 >> Accept The Final Message to the Wildhammer
step
    .goto The Hinterlands,81.70,81.75
	.fp Hinterlands >> Get the Hinterlands Flight Path
    .fly Tarren Mill>> Fly to Tarren Mill
step
    .goto Hillsbrad Foothills,61.50,19.20
    .turnin 2933 >> Turn in Venom Bottles
    .accept 2934 >> Accept Undamaged Venom Sac
step
    .isOnQuest 7843
    .goto The Hinterlands,14.0,48.3
	>>Run back to The Hinterlands
    >> Go place the flag in Aerie Peak, wait for the guard to patrol away first.
    .complete 7843,1 
step
    .goto The Hinterlands,26.70,48.60
    .turnin 77 >> Turn in A Sticky Situation
    .accept 81 >> Accept Ripple Delivery
step
	>>Run to Shadra'Alor. Kill a Witherbark Broodguard. Loot it for its Undamaged Venom Sac
	>>Be careful as it expires after 30 minutes
    .goto The Hinterlands,35.76,64.24,60,0
    .goto The Hinterlands,25.2,70.8
    .complete 2934,1 
step
    .goto The Hinterlands,33.70,75.10
    .turnin 1429 >> Turn in The Atal'ai Exile
    .accept 1444 >> Accept Return to Fel'Zerul
step
    .goto The Hinterlands,49.30,37.70
     >> Manually skip this step if you haven't found the Distress Beacon
    .accept 485 >> Accept Find OOX-09/HL!
    .turnin 485 >> Turn in Find OOX-09/HL!
--N not changing this to a "lookout for this in the zone" as theres do many steps at once its awful
step
    .isQuestComplete 485
    .goto The Hinterlands,49.35,37.65
     >> Start the chicken escort
    .accept 836 >> Accept Rescue OOX-09/HL!
step
    .isQuestComplete 485
     >> Escort the robot chicken. 2 Waves will spawn: 3 level 46 Owlbeasts that Enrage and 3 level 47 Vilebranch Ambushers that can execute (Can instantly kill you when you're below 20% health)
	>> Be careful, as this quest is HARD
    .goto The Hinterlands,79.47,61.21
    .complete 836,1 --Escort OOX-09/HL to the shoreline beyond Overlook Cliff (1)
step
	.isOnQuest 7843
	>>Run back to Revantusk Village
    .goto The Hinterlands,79.40,79.10
    .turnin 7843 >> Turn in The Final Message to the Wildhammer
step
    .goto The Hinterlands,81.70,81.75
    .fly Tarren Mill>> Fly to Tarren Mill
step
    .goto Hillsbrad Foothills,61.50,19.20
    .turnin 2934 >> Turn in Undamaged Venom Sac
    .accept 2935 >> Accept Consult Master Gadrin << Troll
step << !Mage
    .goto Hillsbrad Foothills,60.10,18.60
    .fly Undercity >> Fly to Undercity
step << Mage
	.zone Undercity >> Teleport to Undercity
step << Mage
    .goto Undercity,82.79,15.82
    .vendor >> Go to Hannah. Buy four Runes of Teleportation (or more if you want)
    .collect 17031,4 --Rune of Teleportation (4)
step << Troll
    #sticky
    #completewith next
	.abandon 2935 >> Abandon Consult Master Gadrin IF you already have a mount. If u don't have a mount, keep it until you get one.
step
    .goto Undercity,73.50,32.70
    .turnin 2995 >> Turn in Lines of Communication
    .turnin 2782 >> Turn in Rin'ji's Secret
    .accept 8273 >> Accept Oran's Gratitude
    .turnin 8273 >> Turn in Oran's Gratitude
step
    .hs >> Hearth to Tanaris
>> Buy food/water if needed
step
    .goto Tanaris,51.10,26.90
    .turnin 2641 >> Turn in Sprinkle's Secret Ingredient
    .accept 2661 >> Accept Delivery for Marin
step
    .goto Tanaris,51.80,28.60
    .turnin 2661 >> Turn in Delivery for Marin
    .accept 2662 >> Accept Noggenfogger Elixir
    .turnin 2662 >> Turn in Noggenfogger Elixir
     >> Make sure you have 3 stacks of Noggenfogger from Marin, you will need it for later
    .collect 8529,60
step
    .goto Tanaris,51.60,25.50
    .fly Feralas>> Fly to Feralas
]])

RXPGuides.RegisterGuide("RestedXP Horde 40-50",[[
#classic
<< Horde

#name 49-50 Feralas
#next RestedXP Horde 50-60\50-51 Stranglethorn/Blasted Lands

step
    .goto Feralas,76.20,43.80
    .accept 3062 >> Accept Dark Heart
    .accept 3063 >> Accept Vengeance on the Northspring
    .accept 4120 >> Accept The Strength of Corruption
step
    .goto Feralas,74.50,42.90
    .accept 7734 >> Accept Improved Quality
step
    .goto Feralas,74.50,43.40
    .turnin 3123 >> Turn in Testing the Vessel
    .accept 3124 >> Accept Hippogryph Muisek
    .accept 3128 >> Accept Natural Materials
step
    .goto Feralas,54.4,68.1
	>>Kill Frayfeather Hippogryphs. Loot them for Metallic Fragments, then use the Hippogryph Muisek Vessel on their corpses
    .complete 3124,1 --Collect Hippogryph Muisek (x10)
    .complete 3128,4 --Collect Metallic Fragments (x40)
step
    .goto Feralas,74.4,43.4
    .turnin 3124 >> Turn in Hippogryph Muisek
    .accept 3125 >> Accept Faerie Dragon Muisek
step
    .goto Feralas,68.68,48.60
	>>Kill Faerie Dragons. Loot them for Encrusted Minerals, then use the Faerie Muisek Vessel on their corpses
    .complete 3125,1 --Collect Faerie Dragon Muisek (x8)
    .complete 3128,2 --Collect Encrusted Minerals (x6)	
step
    .goto Feralas,74.4,43.3
    .turnin 3125 >> Turn in Faerie Dragon Muisek
    .accept 3126 >> Accept Treant Muisek
step
	>> Follow the arrow. Kill Treants. Loot them for Splintered Logs, then use the Treant Muisek Vessel on their corpses
    .goto Feralas,69.4,44.6,70,0
    .goto Feralas,70.6,41.8,70,0
    .goto Feralas,75.0,38.6,70,0
    .goto Feralas,77.4,40.8,70,0
    .goto Feralas,78.6,42.4,70,0
    .goto Feralas,79.6,45.4,70,0
    .goto Feralas,69.4,44.6
	.collect 9590,1  --Collect Splintered Log (x1)
	.collect 9593,1 --Collect Treant Muisek (x1)
	.unitscan Wandering Forest Walker
step
	>> Follow the arrow. Kill Treants. Loot them for Splintered Logs, then use the Treant Muisek Vessel on their corpses
    .goto Feralas,73.0,51.0,70,0
    .goto Feralas,74.2,52.8,70,0
    .goto Feralas,72.6,57.4,70,0
    .goto Feralas,73.4,58.0,70,0
    .goto Feralas,70.2,58.2,70,0
    .goto Feralas,68.8,60.2,70,0
    .goto Feralas,73.0,51.0
	.collect 9590,2  --Collect Splintered Log (x2)
	.collect 9593,2 --Collect Treant Muisek (x2)
	.unitscan Wandering Forest Walker
step
	>> Follow the arrow. Kill the last Treant. Use the Treant Muisek Vessel on its corpse
    .goto Feralas,58.6,52.0,70,0
    .goto Feralas,60.0,48.8,70,0
    .goto Feralas,57.8,48.0,70,0
    .goto Feralas,55.6,47.0,70,0
    .goto Feralas,53.2,46.6,70,0
    .goto Feralas,51.6,49.0,70,0
    .goto Feralas,58.6,52.0
	.collect 9593,3 --Collect Treant Muisek (x3)
	.unitscan Wandering Forest Walker
step
    .goto Feralas,74.5,43.4
    .turnin 3126 >> Turn in Treant Muisek
    .accept 3127 >> Accept Mountain Giant Muisek
step
	>>Run west to the shore
    .goto Feralas,44.9,43.4
    .accept 7003 >> Accept Zapped Giants
step
	#sticky
	#completewith next
	>> Perfect Yeti Hide drops from the mobs which starts a quest. Skip it if you don't get it before all of the Rage Scar Yeti Hides. Don't accept the quest yet
	.collect 18972
step
	>>Kill Scar Yetis. Loot them for their Hides
    .goto Feralas,55.0,33.0
    .complete 7734,1 --Collect Rage Scar Yeti Hide (x10)
step
	>> Use Zorbin's Ultra-Shrinker to weaken the giants. Kill them. Loot them for their Residue, then use the Mountain Giant Musiek Vessel on their corpses
    .goto Feralas,38.8,21.6
    .complete 3127,1 --Collect Mountain Giant Muisek (x7)
    .complete 7003,1 --Collect Miniaturization Residue (x15)
step
	#completewith next
	>>Kill the Harpies in the area
    .goto Feralas,38.1,14.4,0
    .complete 3063,1 --Kill Northspring Harpy (x4)
    .complete 3063,2 --Kill Northspring Roguefeather (x4)
    .complete 3063,3 --Kill Northspring Slayer (x4)
    .complete 3063,4 --Kill Northspring Windcaller (x4)
step
	>>Go to the big rock. Use the Horn of Hatetalon in your inventory
	>>Kill Edana Hatetalon. Loot her for her Heart
    .goto Feralas,40.5,8.6
    .complete 3062,1 --Collect Edana's Dark Heart (x1)
step
	>>Kill the Harpies in the area
    .goto Feralas,38.1,14.4
    .complete 3063,1 --Kill Northspring Harpy (x4)
    .complete 3063,2 --Kill Northspring Roguefeather (x4)
    .complete 3063,3 --Kill Northspring Slayer (x4)
    .complete 3063,4 --Kill Northspring Windcaller (x4)
step
    .goto Feralas,44.9,43.4
    .turnin 7003 >> Turn in Zapped Giants
step
    .hs >>Hearth to Gadgetzan
>> Buy food/water if needed
step
	#completewith next
    	.goto Tanaris,27.00,55.66,150,0
    .goto Tanaris,27.00,50.21
	.zone Un'Goro Crater >> Run to Un'Goro Crater
step
    .goto Un'Goro Crater,71.63,75.95
    .accept 4289 >> Accept The Apes of Un'Goro
    .accept 4290 >> Accept The Fare of Lar'korwi
step
	#completewith Scent
    .goto Un'Goro Crater,60.73,78.34,0
     >> Kill Raptors. Loot them for Ravasaur Claws. Don't go out of your way to do this quest yet
    .complete 4300,1
step
     #completewith BoneBlade
    .goto Un'Goro Crater,70.60,53.26,0
     >> Save 25 Un'Goro Soil you loot from mobs throughout the zone. You'll finish this later
	.collect 11018,25
step
	#completewith BoneBlade
    .goto Un'Goro Crater,73.06,51.57,0
     >> As you quest through Un'Goro, loot 7 crystals of each color: Red, Yellow, Green, and Blue
        .collect 11186,7
	.collect 11188,7
	.collect 11185,7
	.collect 11184,7
step
    .goto Tanaris,27.50,42.80
    .accept 4289 >> Accept The Apes of Un'Goro
    .accept 4290 >> Accept The Fare of Lar'korwi
step
    .goto Un'Goro Crater,63.10,68.60
    .accept 3844 >> Accept It's a Secret to Everybody
step
	>Turn around, go under the water
    .goto Un'Goro Crater,63.10,69.00
    .turnin 3844 >> Turn in It's a Secret to Everybody
    .accept 3845 >> Accept It's a Secret to Everybody
step
    .goto Un'Goro Crater,68.80,56.80
     >> Click the giant Threshadon. Loot it for its carcass
    .complete 4290,1
step
    .goto Un'Goro Crater,71.60,76.00
    .turnin 4290 >> Turn in The Fare of Lar'korwi
    .accept 4291 >> Accept The Scent of Lar'korwi
step
    .goto Un'Goro Crater,67.30,73.10,20,0
    .goto Un'Goro Crater,66.60,66.70
     >> Step on the small egg nests to summon Lar'Kowi Mates. Kill and loot them for the Glands
    .complete 4291,1
step
	#label Scent
    .goto Un'Goro Crater,71.63,75.95
    .turnin 4291 >> Turn in The Scent of Lar'korwi
    .accept 4292 >> Accept The Bait for Lar'korwi
step
	#label BoneBlade
    .goto Un'Goro Crater,60.73,78.34
     >> Kill Raptors. Loot them for Ravasaur Claws
    .complete 4300,1
step
     >> Ride around Un'Goro, looting 7 crystals of each color: Red, Yellow, Green, and Blue
	>> Try to stick to the West/Northwest/North areas, since they have lower level mobs to run away from
        .collect 11186,7
	.collect 11188,7
	.collect 11185,7
	.collect 11184,7
--Yes, this has no waypoints
step
     #completewith next
    .goto Un'Goro Crater,44.70,8.10
     >> Open the small pack in your inventory
    .complete 3845,1
    .complete 3845,2
    .complete 3845,3
step
	>>Run to Marshal's Refuge
    .goto Un'Goro Crater,44.70,8.10
    .turnin 3845 >> Turn in It's a Secret to Everybody
    .accept 3908 >> Accept It's a Secret to Everybody
step
	>>Go into the cave
    .goto Un'Goro Crater,43.16,6.24,30,0
    .goto Un'Goro Crater,41.90,2.70
    .accept 4284 >> Accept Crystals of Power
    .turnin 4284 >> Turn in Crystals of Power
step
    .goto Un'Goro Crater,43.16,6.24,30,0
    .goto Un'Goro Crater,45.23,5.82
	>>Exit the Cave
	.fp Marshal >> Get the Un'Goro Crater Flight Path
    .fly Camp Mojache >> Fly to Camp Mojache
step
    .goto Feralas,74.5,43.3
    .turnin 3128 >> Turn in Natural Materials
    .turnin 3127 >> Turn in Mountain Giant Muisek
    .accept 3129 >> Accept Weapons of Spirit
step
	.isOnQuest 7738
    .goto Feralas,74.5,42.9
    .turnin 7734 >> Turn in Improved Quality
    .turnin 7738 >>Turn in Perfect Yeti Hide
step
    .goto Feralas,74.5,42.9
    .turnin 7734 >> Turn in Improved Quality
step
    .goto Feralas,76.1,43.8
    .turnin 3062 >> Turn in Dark Heart
    .turnin 3063 >> Turn in Vengeance on the Northspring
step
    .goto Feralas,74.4,43.4
    .turnin 3129 >> Turn in Weapons of Spirit
step << Druid
    .goto Feralas,76.0,42.3
	.trainer >> Go and train your class spells
step
    .goto Feralas,75.4,44.3,0
    .fly Ratchet >> Fly to Ratchet

]])

RXPGuides.RegisterGuide("RestedXP Horde 50-60",[[
#classic
<< Horde

#name 50-51 Stranglethorn/Blasted Lands
#next 51-52 Searing Gorge/Burning Steppes


step
    .goto The Barrens,62.50,38.70
    .accept 4502 >> Accept Volcanic Activity
step
    .goto The Barrens,62.50,38.60
     >> Loot the small wooden chest just outside the building for The Stone Circle
    .complete 3444,1
step
    .goto The Barrens,62.05,39.41
    .home >> Set your Hearthstone to Ratchet
step
    .goto The Barrens,63.74,38.66
     .zone Stranglethorn Vale >> Take the boat to Stranglethorn Vale
step << Warlock/Hunter
    .goto Stranglethorn Vale,23.35,72.11
     >> Kill and loot Mok'rash at the goblin statue on the island. Right click The Monogrammed Sash.
	>> Be careful as this quest is HARD. It's also impossible to run due to the surrounding water.
	.collect 3985,1,8552
    .accept 8552 >> Accept The Monogrammed Sash
step
	.isQuestComplete 648
	.isQuestComplete 836
	.isQuestComplete 2767
    .goto Stranglethorn Vale,28.40,76.30
    .turnin 648 >> Turn in Rescue OOX-17/TN!
    .turnin 836 >> Turn in Rescue OOX-09/HL!
    .turnin 2767 >> Turn in Rescue OOX-22/FE!
    .accept 3721 >> Accept An OOX of Your Own
    .turnin 3721 >> Turn in An OOX of Your Own
step
	.isQuestComplete 648
    .goto Stranglethorn Vale,28.40,76.30
    .turnin 648 >> Turn in Rescue OOX-17/TN!
step
	.isQuestComplete 836
    .goto Stranglethorn Vale,28.40,76.30
    .turnin 836 >> Turn in Rescue OOX-09/HL!
step
	.isQuestComplete 2767
    .goto Stranglethorn Vale,28.40,76.30
    .turnin 2767 >> Turn in Rescue OOX-22/FE!
step << Warlock/Hunter
    .isOnQuest 8552
    .goto Stranglethorn Vale,26.70,73.60
    .turnin 8552 >> Turn in The Monogrammed Sash
step
	.isQuestTurnedIn 8552
    .goto Stranglethorn Vale,26.70,73.60
    .accept 615 >> Accept The Captain's Cutlass
    .turnin 615 >> Turn in The Captain's Cutlass
step
    .goto Stranglethorn Vale,27.70,77.10
    .turnin 2874 >> Turn in Deliver to MacKinley
step
    .goto Stranglethorn Vale,27.10,77.50
    .turnin 580 >> Turn in Whiskey Slim's Lost Grog
step
    .goto Stranglethorn Vale,27.10,77.30
    .turnin 1122 >> Turn in Report Back to Fizzlebub
step
	#sticky
	#completewith next
	+ Take out 15 Silkcloth from the bank if you have any
step
	#era
    .goto Stranglethorn Vale,26.87,77.10
    .fly Stonard>> Fly to Stonard
step
	#era
    .goto Swamp of Sorrows,47.90,55.00
    .turnin 1444 >> Turn in Return to Fel'Zerul
step
    #era
    #completewith FlyBL
    #label fragment
    >>Try to loot a Draenethyst fragment from any of the mobs in Blasted Lands
    .collect 10593,1,3501,1
step
    #era
    #requires fragment
    #completewith FlyBL
    .goto Blasted Lands,51.8,35.6
    .accept 3501 >> Accept Everything Counts In Large Amounts
    .turnin 3501 >> Turn in Everything Counts In Large Amounts
step
    #era
    #completewith FlyBL
     #label blquests
    .blastedLands
    *Basilisks share spawns with boars and hyenas share spawns with scorpids
step << Hunter/Rogue
    #era
    .goto Blasted Lands,50.55,14.20
    >>Go back to the quest giver once you get the following:
    >>3 Scorpok Pincer 
    >>2 Vulture Gizzard 
    >>1 Blasted Boar Lung
    .accept 2585 >> Accept The Decisive Striker
    .turnin 2585 >> Turn in The Decisive Striker
step << Druid/Paladin/Warrior/Shaman
    #era
    .goto Blasted Lands,50.55,14.20
    >>Go back to the quest giver once you get the following:
    >>3 Snickerfang Jowl
    >>2 Blasted Boar Lung
    >>1 Scorpok Pincer
    .accept 2581 >> Accept Snickerfang Jowls
    .turnin 2581 >> Turn in Snickerfang Jowls
step
    #era
    #requires blquests
    .goto Blasted Lands,50.55,14.20
    .accept 2585 >> Accept The Decisive Striker << !Rogue !Hunter
    .turnin 2585 >> Turn in The Decisive Striker << !Rogue !Hunter
    .accept 2583 >> Accept A Boar's Vitality
    .turnin 2583 >> Turn in A Boar's Vitality
    .accept 2581 >> Accept Snickerfang Jowls << !Druid !Warrior !Shaman
    .turnin 2581 >> Turn in Snickerfang Jowls << !Druid !Warrior !Shaman
    .accept 2601 >> Accept The Basilisk's Bite
    .turnin 2601 >> Turn in The Basilisk's Bite
    .accept 2603 >> Accept Vulture's Vigor
    .turnin 2603 >> Turn in Vulture's Vigor
step
	#era
	#label FlyBL
    .goto Swamp of Sorrows,46.10,54.80
    .fly Badlands>> Fly to Badlands
step
	#som
    .goto Stranglethorn Vale,26.87,77.10
    .fly Badlands>> Fly to Badlands
]])

RXPGuides.RegisterGuide("RestedXP Horde 50-60",[[
#classic
<< Horde

#name 51-52 Searing Gorge/Burning Steppes
#next 52-53 Azshara

step
    .goto Badlands,3.40,48.10
     >> You may have to wait for Thal'trak to finish his RP event. Just follow him around for a bit
    .accept 3821 >> Accept Dreadmaul Rock
	.unitscan Thal'trak Proudtusk
step
    .goto Badlands,3.62,61.88,50,0
    .goto Searing Gorge,72.34,55.47
	.zone Searing Gorge >> Ride to Searing Gorge
step
	#label silkcloth15
	#sticky
	Collect 15 silk cloth in the zone
	.collect 4306,15
step
	>>Click on the Outhouse
    .goto Searing Gorge,65.55,62.15
    .accept 4449 >> Accept Caught!
step
     .goto Searing Gorge,63.43,60.91,20,0
     .goto Searing Gorge,63.43,60.91,0
    .goto Searing Gorge,69.10,33.53,20,0
    .goto Searing Gorge,69.10,33.53,0
     .goto Searing Gorge,63.43,60.91
     >> Kill all Dark Iron Geologists you see. You may not be able to get them all at the digsite. If not, go to the camp and kill the Geologists there, then go back to the digsite
    .complete 4449,1
step
    .goto Searing Gorge,39.10,39.00
    .accept 3441 >> Accept Divine Retribution
     >> Talk to Kalaran Windblade Go through his whole dialogue
    .complete 3441,1
    .skipgossip 
step
    .goto Searing Gorge,39.05,38.98
    .turnin 3441 >> Turn in Divine Retribution
    .accept 3442 >> Accept The Flawless Flame
step
    .goto Searing Gorge,32.50,32.48,30,0
	>>Run to Thorium Point
    .goto Searing Gorge,34.84,30.89
    .fp Thorium >> Get the Searing Gorge Flight Path
step
    .goto Searing Gorge,38.58,27.80
    .accept 7723 >> Accept Curse These Fat Fingers
    .accept 7724 >> Accept Fiery Menace!
step
    .goto Searing Gorge,37.64,26.47
     >> Click on the wanted board
    .accept 7728 >> Accept STOLEN: Smithing Tuyere and Lookout's Spyglass
    .accept 7729 >> Accept JOB OPPORTUNITY: Culling the Competition
step << !Shaman !Druid
    .goto Searing Gorge,38.58,27.80
    .accept 7722 >> Accept What the Flux?
    .accept 7727 >> Accept Incendosaurs? Whateverosaur is More Like It
step
    .goto Searing Gorge,38.58,27.80
    .accept 7727 >> Accept Incendosaurs? Whateverosaur is More Like It
step
    #completewith Spiders
    .goto Searing Gorge,30.41,76.05,0
    .goto Searing Gorge,27.99,63.35,0
    .goto Searing Gorge,24.23,53.91,0
    .goto Searing Gorge,31.16,43.52,0
    .goto Searing Gorge,43.98,35.35,0
     >> Kill Fire Golems and Elementals. Loot them for Hearts and Oil. Prioritise this
    .complete 3442,1
    .complete 3442,2
step
    #completewith Elementals
    .goto Searing Gorge,34.08,53.99,0
     >> Kill Dark Iron Lookouts around the towers. Loot them for the Spyglass
    .complete 7728,2
step
    #completewith Elementals
    .goto Searing Gorge,40.90,50.31,0
     >> Kill Steamsmiths. Loot them for the Tuyere
    .complete 7728,1
step
    #label Spiders
    .goto Searing Gorge,27.70,46.58,100,0
    .goto Searing Gorge,28.02,75.91,100,0
    .goto Searing Gorge,27.70,46.58
     >> Kill Lava Spiders along the western edge of the map
    .complete 7724,1
step
    #completewith next
    .goto Searing Gorge,43.61,40.78,0
    .goto Searing Gorge,32.54,47.19,0
     >> Kill War Golems
    .complete 7723,1
step
	#label Elementals
    .goto Searing Gorge,30.41,76.05,90,0
    .goto Searing Gorge,27.99,63.35,90,0
    .goto Searing Gorge,24.23,53.91,90,0
    .goto Searing Gorge,31.16,43.52,90,0
    .goto Searing Gorge,43.98,35.35,90,0
    .goto Searing Gorge,30.41,76.05
     >> Kill Fire Golems and Elementals. Loot them for Hearts and Oil
    .complete 3442,1
    .complete 3442,2
step
    .goto Searing Gorge,39.05,38.98
    .turnin 3442 >> Turn in The Flawless Flame
    .accept 3443 >> Accept Forging the Shaft
step
    .goto Searing Gorge,47.54,46.89,30 >> Jump down to the platform, and go inside the cave
step
    .goto Searing Gorge,46.66,42.48,40,0
    .goto Searing Gorge,51.67,37.02,40,0
    .goto Searing Gorge,45.41,21.65
	>>Start killing the Incendosaurs in the lower level of the cave
    .complete 7727,1
step
    .goto Searing Gorge,48.41,41.08,40,0
    .goto Searing Gorge,47.94,47.58,40,0
    .goto Searing Gorge,49.86,45.97,40,0
    .goto Searing Gorge,49.75,45.82,35 >> Run back out of the cave, then follow the platform up to the higher part of the cave
step
    #completewith Shanksinnit
     >> Kill Taskmasters and Slavers
    .complete 7729,1
    .complete 7729,2
step << !Shaman !Druid
    .goto Searing Gorge,40.5,35.7
    >> Go outside the cave again and go in via the right door this time. Clear the entire room before getting the plans to make an escape path.
	>> Be careful as this quest can be VERY hard and risky. Don't be ashamed to skip it << Warrior/Priest/Rogue
    >> Pull all 3 mobs with your pet and go loot the plans.  << Hunter
    >> Pull all 3 mobs with a Voidwalker and go loot the plans. << Warlock
    >> Build up 25+ rage, then fear all 3 mobs at the same time and click to loot the plans. << Warrior
    >> Go pull all 3 mobs and use your AOE fear to loot the plans. << Priest
    >> With improved gouge this is possible. Use Sap on one target, the prepare urself near the plans. Use blind on a second target. Last one is the hard one, you have to use gouge (5.5 sec cd) and instantly start looting the plans (5 sec) << Rogue
    >> Use Polymorph on Maltorius then frostnova the other 2 elites and blink to the plans and loot them. << Mage
    .complete 7722,1
step
	#label Shanksinnit
    .goto Searing Gorge,42.81,28.11
	>> Kill Dwarves. Loot them Thorium Plated Daggers
    .complete 3443,1
step
    .goto Searing Gorge,43.72,29.81
     >> Keep grinding dwarves until you get the Grimesilt Outhouse Key. Accept the quest from it
	.collect 11818,1,4451
    .accept 4451 >> Accept The Key to Freedom
step
	#completewith next
	+Logout skip out of the cave. There are MANY different spots you can use
	.link https://www.youtube.com/watch?v=-mcsjDkeSUw >> CLICK HERE for reference
step
    .goto Searing Gorge,39.05,38.98
    .turnin 3443 >> Turn in Forging the Shaft
    .accept 3452 >> Accept The Flame's Casing
step
	#softcore
    .goto Searing Gorge,16.84,38.84
     >> Kill the Twilight mobs in the area. Loot them for the Symbol of Ragnaros. Group up for this quest if needed
	>> Be careful as this quest can be VERY hard. Be aware that the Dark Shamans have a 2000 health heal, and 500 damage instant shock spell
    .complete 3452,1
step
	#hardcore
    .goto Searing Gorge,16.84,38.84
     >> Kill the Twilight mobs in the area. Loot them for the Symbol of Ragnaros
	>> Be careful as this quest can be VERY hard. Be aware that the Dark Shamans have a 2000 health heal, and 500 damage instant shock spell
    .complete 3452,1
step
    #requires smithing
	.isQuestComplete 3542
    .goto Searing Gorge,39.05,38.98
    .turnin 3452 >> Turn in The Flame's Casing
step
	.isQuestTurnedIn 3452
    .goto Searing Gorge,39.05,38.98
     >> Stay next to the NPC while the RP event is going
    .accept 3453 >> Accept The Torch of Retribution
    .turnin 3453 >> Turn in The Torch of Retribution
    .accept 3454 >> Accept The Torch of Retribution
step
	.isQuestTurnedIn 3452
    .goto Searing Gorge,39.04,39.24
     >> Click on the Torch of Retribution
    .turnin 3454 >> Turn in The Torch of Retribution
step
	.isQuestTurnedIn 3452
    .goto Searing Gorge,39.05,38.98
    .accept 3462 >> Accept Squire Maltrake
    .turnin 3462 >> Turn in Squire Maltrake
    .accept 3463 >> Accept Set Them Ablaze!
step
    #completewith OuthouseAndy
    .goto Searing Gorge,34.08,53.99,0
     >> Kill Dark Iron Lookouts around the towers. Loot them for the Spyglass
    .complete 7728,2
step
    #completewith WarGolems
    .goto Searing Gorge,40.90,50.31,0
     >> Kill Steamsmiths. Loot them for the Tuyere
    .complete 7728,1
step
    #completewith next
    .goto Searing Gorge,43.61,40.78,0
    .goto Searing Gorge,32.54,47.19,0
     >> Kill War Golems
    .complete 7723,1
step
	.isQuestTurnedIn 3452
    .goto Searing Gorge,33.30,54.47
     >> Set the first tower ablaze by equipping the Torch of Retribution and clicking on the brazier at the top of the tower
    .complete 3463,4
step
	#label WarGolems
    .goto Searing Gorge,43.61,40.78
     >> Kill War Golems
    .complete 7723,1
step
    .goto Searing Gorge,40.90,50.31
     >> Kill Steamsmiths. Loot them for the Tuyere
    .complete 7728,1
step
	.isQuestTurnedIn 3452
    .goto Searing Gorge,35.66,60.68
     >> Set the second tower ablaze by equipping the Torch of Retribution and clicking on the brazier at the top of the tower
    .complete 3463,1
step
	.isQuestTurnedIn 3452
    .goto Searing Gorge,44.03,60.90
     >> Set the third tower ablaze by equipping the Torch of Retribution and clicking on the brazier at the top of the tower
    .complete 3463,2
step
	#requires silkcloth15
	#label OuthouseAndy
    .goto Searing Gorge,65.59,62.17
    .turnin 4449 >> Turn in Caught!
    .turnin 4451 >> Turn in The Key to Freedom
step
	#label OuthouseAndy
	.isQuestTurnedIn 3452
    .goto Searing Gorge,50.10,54.70
     >> Set the fourth tower ablaze by equipping the Torch of Retribution and clicking on the brazier at the top of the tower
    .complete 3463,3
step
    .goto Searing Gorge,34.08,53.99
     >> Kill Dark Iron Lookouts around the towers. Loot them for the Spyglass
    .complete 7728,2
step
	#completewith next
	.isQuestTurnedIn 3452
    .goto Searing Gorge,39.05,38.98
    .turnin 3463 >> Turn in Set Them Ablaze!
step
	.isQuestTurnedIn 3452
    .goto Searing Gorge,38.85,38.99
	>>Open the chest on the ground (twice)
	>>Open the Hoard of the Black Dragonflight. Make sure you keep the Black Dragonflight Molt for later
    .accept 3481 >> Accept Trinkets...
    .turnin 3481 >> Turn in Trinkets...
step
    .goto Searing Gorge,38.97,27.50
	>>Run back to Thorium Point
    .turnin 7723 >> Turn in Curse These Fat Fingers
    .turnin 7724 >> Turn in Fiery Menace!
    .turnin 7728 >> Turn in STOLEN: Smithing Tuyere and Lookout's Spyglass
step
	.isQuestComplete 7722
    .goto Searing Gorge,38.80,28.50
    .turnin 7727 >> Turn in Incendosaurs? Whateverosaur is More Like It
    .turnin 7729 >> Turn in JOB OPPORTUNITY: Culling the Competition
    .turnin 7722 >> Turn in What the Flux? << !Shaman
step
    .goto Searing Gorge,38.80,28.50
    .turnin 7727 >> Turn in Incendosaurs? Whateverosaur is More Like It
    .turnin 7729 >> Turn in JOB OPPORTUNITY: Culling the Competition
step
	#completewith next
	+Run down to South-east Searing Gorge where Margol the Rager is found. Wait for him to patrol all the way out of his cave, then logout skip from the mushrooms at the back << Druid/Shaman
	>>Be careful as Margol is IMMUNE to nature spells << Shaman/Druid
	+Run down to South-east Searing Gorge where Margol the Rager is found. Wait for him to patrol all the way out of his cave (or kill him), then logout skip from the mushrooms at the back << !Druid !Shaman
	.link https://www.youtube.com/watch?v=0_g2SY2JKt8 >> CLICK HERE
step
    .goto Burning Steppes,28.43,17.70,0
	.zone Burning Steppes >> Travel to the Burning Steppes either through the Margol Logout Skip (which is A LOT faster) or Blackrock Mountain
step
    .goto Burning Steppes,65.70,24.20
    .fp Flame Crest >> Get the Burning Steppes Flight Path
step
    .goto Burning Steppes,65.30,23.80
    .accept 4726 >> Accept Broodling Essence
    .accept 4296 >> Accept Tablet of the Seven
step
    #completewith HoardO
    .goto Burning Steppes,77.97,27.99,0
    .goto Burning Steppes,92.03,33.78,0
    .goto Burning Steppes,85.24,60.46,0
     >> Use the Draco-Incarcinatrix-900 on Whelps, then kill them. Loot the object they drop
    .complete 4726,1
step
    .goto Burning Steppes,54.10,40.70
     >> Loot the rock in front of the Dwarf statue
    .complete 4296,1
step
	>>Cross the bridge, then go up the mountain. Click on the remains on the altar
    .goto Burning Steppes,77.68,38.23,60,0
    .goto Burning Steppes,79.80,45.60
    .turnin 3821 >> Turn in Dreadmaul Rock
step
    .goto Burning Steppes,77.68,38.23
    .xp 52 >> Grind mobs in the area to level 52
step
	.isQuestTurnedIn 3452
	#label HoardO
    .goto Burning Steppes,95.09,31.56
     >> Go to the cave and turn in A Taste of Flame. Remember to open the Hoard of the Black Dragonflight from earlier
    .accept 4022 >> Accept A Taste of Flame
    .turnin 4022 >> Turn in A Taste of Flame
step
    #completewith HoardO
    .goto Burning Steppes,85.24,60.46,60,0
    .goto Burning Steppes,92.03,33.78,60,0
    .goto Burning Steppes,77.97,27.99
     >> Use the Draco-Incarcinatrix-900 on Whelps, then kill them. Loot the object they drop
    .complete 4726,1
step
	>>Travel back to Flame Crest
    .goto Burning Steppes,65.30,23.80
    .turnin 4726 >> Turn in Broodling Essence
    .accept 4808 >> Accept Felnok Steelspring
    .turnin 4296 >> Turn in Tablet of the Seven
step << Druid
	>> Use the spell Teleport to Moonglade
    .goto Moonglade,52.5,40.5
	.trainer >> Go and train your class spells
step << !Mage
     #completewith next
    .hs >> Hearth to Ratchet
	>> Buy food/water if needed
step << !Mage
    .goto Stranglethorn Vale,26.90,77.10
    .fly Orgrimmar >> Fly To Orgrimmar
step << Mage
	.zone Orgrimmar >> Teleport to Orgrimmar

]])

RXPGuides.RegisterGuide("RestedXP Horde 50-60",[[
#classic
<< Horde

#name 52-53 Azshara
#next 53-53 Felwood

step
    .goto Orgrimmar,54.1,68.4
    .home >> Set your Hearthstone to Orgrimmar
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
step << Mage
    .goto Orgrimmar,38.8,85.6
	.trainer >> Go and train your class spells
step << Priest
    .goto Orgrimmar,35.6,87.8
	.trainer >> Go and train your class spells
step
    .goto Orgrimmar,56.40,46.50
    .accept 4494 >> Accept March of the Silithid
step
    .goto Orgrimmar,59.40,36.90
    .turnin 81 >> Turn in Ripple Delivery
step
    .goto Orgrimmar,55.60,34.20
    .turnin 4300 >> Turn in Bone-Bladed Weapons
step
    .goto Orgrimmar,75.00,34.30
    .accept 3504 >> Accept Betrayed
	>>Blizzard -may- have recently removed this questline due to the quest text (check Wowhead). If that's the case, skip this step
--N will Blizzard add this back? Bowl of fruit treatment pls
step
    .goto Orgrimmar,45.2,63.9
    .fly Splintertree Post>> Fly to Splintertree Post
step
    .goto Azshara,10.40,74.90,40,0
    .goto Azshara,11.40,78.10
     >> Head to Azshara
    .accept 5535 >> Accept Spiritual Unrest
    .accept 5536 >> Accept A Land Filled with Hatred
step
    .goto Azshara,20.09,61.79
     >> Kill Satyrs in the area
    .complete 5536,1
    .complete 5536,2
    .complete 5536,3
step
    .goto Azshara,17.20,68.41
     >> Kill Undead in the area
    .complete 5535,1
    .complete 5535,2
step
    .goto Azshara,11.36,78.16
    .turnin 5535 >> Turn in Spiritual Unrest
    .turnin 5536 >> Turn in A Land Filled with Hatred
step
    .goto Azshara,22.00,49.70
    .fp Azshara >> Get the Azshara Flight Path
step
	.isOnQuest 3504
    .goto Azshara,22.20,51.50
    .turnin 3504 >> Turn in Betrayed
step
	.isQuestTurnedIn 3504
    .goto Azshara,22.20,51.50
    .accept 3505 >> Accept Betrayed
step
    .goto Azshara,22.50,51.40
    .accept 3517 >> Accept Stealing Knowledge
step
    .goto Azshara,53.45,21.82
    .accept 3601 >> Accept Kim'jael Indeed!
step
    #completewith Magus
    .goto Azshara,57.02,29.45,0
     >> Loot the boxes scattered around the camp
    .complete 3601,1
    .complete 3601,2
    .complete 3601,3
    .complete 3601,4
step
	.isOnQuest 3505
    .goto Azshara,57.02,29.45
     >> Kill blood elves in the area. Be careful as Surveyors Fire Nova, and Reclaimers Heal and Fireball
    .complete 3505,2
    .complete 3505,3
step
	.isOnQuest 3505
    .goto Azshara,59.40,31.20
	>>Run toward the Summoning Circle, then click the book on the pedestal
    .complete 3505,1
    .goto Azshara,59.50,31.20
    .turnin 3505 >> Turn in Betrayed
    .accept 3506 >> Accept Betrayed
step
	#label Magus
	.isQuestTurnedIn 3505
    .goto Azshara,59.50,31.40
     >>Click on the crystals nearby to summon a mob, and then Magus Rimtori. Kill and loot her for her head
    .complete 3506,1
step
    .goto Azshara,57.02,29.45
     >> Loot the boxes scattered around the camp near the tents
    .complete 3601,1
    .complete 3601,2
    .complete 3601,3
    .complete 3601,4
step
    .goto Azshara,57.02,29.45
    .xp 53 >> Grind to level 53, this is your last grinding spot needed before level 60. If you don't want to grind this much you can do a dungeon or two instead.
	#era
step
    .goto Azshara,53.45,21.82
    .turnin 3601 >> Turn in Kim'jael Indeed!
    .accept 5534 >> Accept Kim'jael's "Missing" Equipment
step
	#label nagaasz
    #sticky
     >> Kill Nagas. Loot them for "Some Rune"
    .complete 5534,1
step
	>>These tablets are scattered everywhere in these ruins. Find one of each.
    .goto Azshara,37.53,53.48
    .complete 3517,1
    .complete 3517,2
    .complete 3517,3
    .complete 3517,4
step
    .goto Azshara,47.80,60.80
     >> Use the first Vial
    .complete 3568,1
step
    .goto Azshara,47.80,51.30
     >> Use the second Vial
    .complete 3568,2
step
    .goto Azshara,48.70,48.50
     >> Use the third Vial
    .complete 3568,3
step
    .goto Azshara,47.50,46.20
     >> Use the fourth Vial
    .complete 3568,4
step
	#requires nagaasz
   .goto Azshara,45.55,37.79,50,0
    .goto Azshara,53.45,21.82
	>> Run up the ramp north out of the shore part of Azshara. Run back to Kim'jael 
    .turnin 5534 >> Turn in Kim'jael's "Missing" Equipment
step
    .goto Azshara,22.60,51.40
     >> Skip the other quest for now
    .turnin 3517 >> Turn in Stealing Knowledge
    .accept 3561 >> Accept Delivery to Archmage Xylem
    .accept 3518 >> Accept Delivery to Magatha
    .accept 3541 >> Accept Delivery to Jes'rimon
step
	.isQuestTurnedIn 3505
    .goto Azshara,22.3,51.5
    .turnin 3506 >>Turn in Betrayed
    .accept 3507 >>Accept Betrayed
step
    .goto Azshara,28.1,50.0
    .turnin 3503 >>Turn in Meeting with the Master
step
    .goto Azshara,29.7,40.4
    .turnin 3561 >>Turn in Delivery to Archmage Xylem
   .accept 3565 >>Accept Xylem's Payment to Jediga
step
    .goto Azshara,26.5,46.3
    .turnin 3421 >>Turn in Return Trip
step
    .goto Azshara,22.5,51.5
    .turnin 3565 >>Turn in Xylem's Payment to Jediga
step
    .goto Azshara,22.0,49.6
    .fly Splintertree Post >>Fly to Splintertree Post
]])

RXPGuides.RegisterGuide("RestedXP Horde 50-60",[[
#classic
<< Horde

#name 53-53 Felwood
#next 53-54 Un'Goro Crater

step
    .goto Ashenvale,55.78,28.12
     .zone Felwood >> Travel to Felwood
step
    .goto Felwood,51.00,85.00
    .accept 8460 >> Accept Timbermaw Ally
step
    .goto Felwood,50.90,81.70
    .accept 5156 >> Accept Verifying the Corruption
step
    .goto Felwood,51.20,82.10
    .accept 5155 >> Accept Forces of Jaedenar
step
    .goto Felwood,46.70,83.30
    .accept 4102 >> Accept Cleansing Felwood
step
    .goto Felwood,38.45,60.72
     >> Kill the mobs found throughout Jaedenar
	>> Be careful of Adepts, as they have Fire Blast and Blink
    .complete 5155,1
    .complete 5155,2
    .complete 5155,3
    .complete 5155,4
step
    .goto Felwood,34.80,52.70
    .accept 6162 >> Accept A Husband's Last Battle
step
    .goto Felwood,34.20,52.30
    .accept 4505 >> Accept Well of Corruption
step
    .goto Felwood,34.40,53.90
    .fp Felwood >> Get the Felwood Flight Path
step
    .goto Felwood,36.02,66.99,70,0
    .goto Felwood,32.30,66.60
     >> Use the Hardened Flasket in your inventory at the green moonwell
    .complete 4505,1
step
	#completewith next
    .goto Felwood,48.93,90.22,0
     >> Kill the Deadwood Furbolgs in the area
    .complete 8460,1
    .complete 8460,2
    .complete 8460,3
step
    .goto Felwood,48.20,94.30
     >> Kill Overlord Ror. Loot him for his claw
    .complete 6162,1
step
    .goto Felwood,48.93,90.22
     >> Kill the Deadwood Furbolgs in the area
    .complete 8460,1
    .complete 8460,2
    .complete 8460,3
step
    .goto Felwood,51.00,85.00
    .turnin 8460 >> Turn in Timbermaw Ally
    .accept 8462 >> Accept Speak to Nafien
step
    .goto Felwood,51.20,82.20
    .turnin 5155 >> Turn in Forces of Jaedenar
    .accept 5157 >> Accept Collection of the Corrupt Water
step
    .goto Felwood,35.20,59.80
     >> Use the Empty Canteen on the green well found in Jaedenar
    .complete 5157,1
step
	#completewith next
    .goto Felwood,40.87,42.03,0
    .goto Felwood,46.03,38.06,0
     >> Kill Entropic Beasts and Horrors in the area.
	>> If you can't find Horrors and can only find Beasts, kill some Beasts to force respawns on the Horrors
    .complete 5156,2
    .complete 5156,3
	.unitscan Entropic Horror
step
    .goto Felwood,41.20,42.82
	>>Run into one of the Craters in Shatter Scar Vale
    .complete 5156,1 --Explore the craters in Shatter Scar Vale (1)
step
    .goto Felwood,40.87,42.03,90,0
    .goto Felwood,46.03,38.06
     >> Kill Entropic Beasts and Horrors in the area.
	>> If you can't find Horrors and can only find Beasts, kill some Beasts to force respawns on the Horrors
    .complete 5156,2
    .complete 5156,3
	.unitscan Entropic Horror
step
	#completewith next
    .goto Winterspring,17.63,50.02,0
     >> Kill Angerclaw Grizzlys and Felpaw Ravagers that you see
    .complete 4120,1
    .complete 4120,2
step
    .goto Felwood,55.70,17.4
     >> Travel to Irontree Cavern. Kill Warpwood mobs in and outside. Loot them for Blood Amber
    .complete 4102,1
step
    .goto Felwood,53.75,28.06,90,0
    .goto Felwood,58.03,17.83,90,0
    .goto Felwood,63.27,19.15
     >> Finish killing Angerclaw Grizzlys and Felpaw Ravagers
    .complete 4120,1
    .complete 4120,2
step
    .goto Felwood,64.70,8.20
    .turnin 8462 >> Turn in Speak to Nafien
step
     #completewith next
    .goto Felwood,65.16,7.88,40,0
    .goto Felwood,64.67,3.14,40,0
    .goto Felwood,66.40,2.95,40,0
    .goto Felwood,68.24,5.60,40,0
    .goto Felwood,68.73,6.38
	.zone Winterspring >> Travel through Timbermaw Hold to Winterspring
step
    .goto Winterspring,31.30,45.10
    .accept 5082 >> Accept Threat of the Winterfall
    .turnin 3908 >> Turn in It's a Secret to Everybody
step
    #completewith next
    .goto Winterspring,30.80,36.20,0
     >> Kill Furbolgs until you loot an Empty Firewater Flask
	.collect 12771,1,5083
    .accept 5083 >> Accept Winterfall Firewater
step
    .goto Winterspring,30.81,35.89,90,0
    .goto Winterspring,33.20,37.01,90,0
    .goto Winterspring,30.81,35.89,90,0
    .goto Winterspring,41.13,42.90,0
    .goto Winterspring,33.20,37.01
     >> Kill Furbolgs in the area. Kill the Furbolgs to the South-east if you run out of spawns
    .complete 5082,1
    .complete 5082,2
    .complete 5082,3
step
    .goto Winterspring,30.81,35.89,90,0
    .goto Winterspring,33.20,37.01,90,0
    .goto Winterspring,30.81,35.89,90,0
    .goto Winterspring,41.13,42.90,0
    .goto Winterspring,33.20,37.01
     >> Kill Furbolgs until you loot an Empty Firewater Flask
	.collect 12771,1,5083
    .accept 5083 >> Accept Winterfall Firewater
step
    .goto Winterspring,31.30,45.20
    .turnin 5082 >> Turn in Threat of the Winterfall
    .turnin 5083 >> Turn in Winterfall Firewater
    .accept 5084 >> Accept Falling to Corruption
    .accept 3909 >> Accept The Videre Elixir
step
	#softcore
     #completewith next
     .deathskip >> Die and respawn at the Spirit Healer
step
    .goto Winterspring,61.60,38.60
    .turnin 4808 >> Turn in Felnok Steelspring
step
    .goto Winterspring,60.47,36.30
	.fp Everlook >> Get the Everlook Flight Path
    .fly Felwood >> Fly to Felwood
step
    .goto Felwood,34.20,52.30
    .turnin 4505 >> Turn in Well of Corruption
step
    .goto Felwood,34.80,52.70
    .turnin 6162 >> Turn in A Husband's Last Battle
step
    #softcore
     #completewith next
    .goto Felwood,41.30,67.10
     >> Head towards the slime pond south of Jaedenar. Die and respawn at the Spirit Healer in Southern Felwood
step
    .goto Felwood,51.20,82.10
    .turnin 5157 >> Turn in Collection of the Corrupt Water
    .accept 5158 >> Accept Seeking Spiritual Aid
step
    .goto Felwood,50.90,81.70
    .turnin 5156 >> Turn in Verifying the Corruption
step
    .goto Felwood,46.60,83.00
    .turnin 4102 >> Turn in Cleansing Felwood
     >> Ask Arathandris for a Cenarion Beacon
    .collect 11511,1
step
    .hs >> Hearth to Orgrimmar
	>> Buy food/water if needed
step
	#softcore
    .goto Orgrimmar,55.55,64.74
	>>Go to the Auction House. Buy a Mithril Casing for later if there's one available
	.collect 10561,1 --Mithril Casing (1)
step
    .goto Orgrimmar,55.52,34.07
    .turnin 3541 >> Turn in Delivery to Jes'rimon
    .accept 3563 >> Accept Jes'rimon's Payment to Jediga
step
	.isOnQuest 3507
    .goto Orgrimmar,75.20,34.00
    .turnin 3507 >> Turn in Betrayed
step
    .goto Orgrimmar,45.11,63.89
    .fly Camp Taurajo >> Fly to Camp Taurajo
step
    .goto The Barrens,45.6,59.0
	.home >> Set your Hearthstone to Camp Taurajo
]])

RXPGuides.RegisterGuide("RestedXP Horde 50-60",[[
#classic
<< Horde

#name 53-54 Un'Goro Crater
#next 54-56 Felwood/Winterspring

step
    .goto The Barrens,44.45,59.15
    .fly Tanaris >> Fly to Tanaris
step
    .goto Tanaris,50.90,27.00
    .turnin 4494 >> Turn in March of the Silithid
    .accept 4496 >> Accept Bungle in the Jungle
step
    .goto Tanaris,51.60,25.50
    .fly Un'Goro Crater>> Fly to Un'Goro Crater
step
    .goto Tanaris,12.70,5.90
    .accept 3881 >> Accept Expedition Salvation
    .accept 3883 >> Accept Alien Ecology
step
    .goto Tanaris,12.50,6.00
    .accept 3882 >> Accept Roll the Bones
step
	>>Go into the cave
    .goto Un'Goro Crater,43.16,6.24,30,0
    .goto Un'Goro Crater,41.90,2.70
    .accept 4288 >> Accept The Western Pylon
    .accept 4285 >> Accept The Northern Pylon
   .accept 4287 >> Accept The Eastern Pylon
step
    .goto Tanaris,12.50,6.50
    .accept 4492 >> Accept Lost!
    .accept 4501 >> Accept Beware of Pterrordax
step
    .goto Tanaris,12.80,8.10
    .accept 4503 >> Accept Shizzle's Flyer
step
    .goto Un'Goro Crater,45.53,8.72
    .accept 4145 >> Accept Larion and Muigin
step
    .goto Un'Goro Crater,46.1,13.5
    .accept 4243 >> Accept Chasing A-Me 01
step
	#completewith Larkowi
	>>Collect Un'Goro Soil from mobs as you quest through the zone
	.collect 11018,25 --Un'Goro Soil (25)
step
    .goto Un'Goro Crater,46.86,15.11,100,0
    .goto Un'Goro Crater,42.03,21.77,100,0
    .goto Un'Goro Crater,49.54,20.49,100,0
    .goto Un'Goro Crater,52.00,27.21,100,0
    .goto Un'Goro Crater,64.11,24.14,100,0
    .goto Un'Goro Crater,59.65,31.29
	>>Kill the Tar Beasts in the area. Loot them for their Tar
	>>Be careful as the Tar Lords cast Entangling Roots << !Warrior !Rogue !Shaman
	>>Be careful as the Tar Lords cast Entangling Roots, and all Tar Beasts have a thorns-like effect where you can be Disarmed for 4 seconds << Warrior/Rogue/Shaman
    .complete 4504,1 --Collect Super Sticky Tar (x12)
step
	#completewith next
    .goto Un'Goro Crater,44.11,91.63,0
	>>Loot the Pterrordax you kill for their scales. You'll finish this later
	.complete 4503,2 --Collect Webbed Pterrordax Scale (x8)
step
	#completewith Gorillaz
	>> Kill some of the Pterrordax found north of the Northern Pylon
    .goto Un'Goro Crater,44.5,88.2
    .complete 4501,1 --Kill Pterrordax (x10)
step
	>>Interact with the Pylon
    .goto Un'Goro Crater,56.6,12.6
    .complete 4285,1 --Discover and examine the Northern Crystal Pylon
step
	#label Gorillaz
    .goto Un'Goro Crater,62.97,17.39,150 >> Travel to Fungal Rock
step
    .goto Un'Goro Crater,63.3,16.8
	>>Kill the Gorrilas inside and outside the cave. Loot them for their pelts
	>>Be careful as the normal Gorillas call for help in a 90 yard range, and the Thunderers have a high-damage, instant shock spell
    .complete 4289,2 --Collect Un'Goro Stomper Pelt (x2)
    .complete 4289,3 --Collect Un'Goro Thunderer Pelt (x2)
    .complete 4289,1 --Collect Un'Goro Gorilla Pelt (x2)
step
	#completewith Ucha
    .goto Un'Goro Crater,65.02,35.93,0
	>>Kill the Young Diemetradons that you see. Loot them for Bones and Scales
    .complete 3882,1 --Collect Dinosaur Bone (x8)
	.complete 4503,1 --Collect Webbed Diametradon Scale (x8)
step
    .goto Un'Goro Crater,57.6,20.7
	>>Kill Bloodpetal Flayers. Be careful of their Poison as it deals a lot of damage << Warrior/Rogue
	>>Kill Bloodpetal Flayers. Be careful of their Poison as it deals a lot of damage, and drains a lot of mana << !Warrior !Rogue
	.complete 4145,3 --Kill Bloodpetal Flayer (x5)
step
	>>Loot the Crate on the ground
    .goto Un'Goro Crater,68.4,36.5
    .complete 3881,1 --Collect Crate of Foodstuffs (x1)
step
    .goto Un'Goro Crater,69.2,36.9
	>>Kill Bloodpetal Threshers and Lashers. Be careful of their Poison as it deals a lot of damage, and Lashers can disarm you << Warrior/Rogue/Shaman
	>>Kill Bloodpetal Threshers and Lashers. Be careful of their Poison as it deals a lot of damage, and drains a lot of mana << !Warrior !Rogue !Shaman
    .complete 4145,4 --Kill Bloodpetal Thresher (x5)
    .complete 4145,1 --Kill Bloodpetal Lasher (x5)
step
	>>Interact with the Pylon
    .goto Un'Goro Crater,77.3,50.0
    .complete 4287,1 --Discover and examine the Eastern Crystal Pylon
step
	#label Ucha
    .goto Un'Goro Crater,71.6,75.9
    .turnin 4291 >> Turn in The Scent of Lar'korwi
    .accept 4292 >> Accept The Bait for Lar'korwi
    .turnin 4289 >> Turn in The Apes of Un'Goro
    .accept 4301 >> Accept The Mighty U'cha
step
	#completewith next
    .goto Un'Goro Crater,50.59,77.06,0
	>>Kill Silithid mobs in the area. Loot them for the Scent Gland
    .complete 4496,1 --Collect Gorishi Scent Gland (x1)
step	
	>> Go down into the Silithid cave. Hug the left wall toward the first room
	>> Use the Scraping Vial when you're in the middle of the room
    .goto Un'Goro Crater,49.97,81.36,40,0
    .goto Un'Goro Crater,48.7,85.2
    .complete 3883,1 --Collect Hive Wall Sample (x1)
step
    .goto Un'Goro Crater,50.59,77.06
	>>Kill Silithid mobs in the area. Loot them for the Scent Gland
    .complete 4496,1 --Collect Gorishi Scent Gland (x1)
step
	#completewith next
    .goto Un'Goro Crater,44.11,91.63,0
	>>Loot the Pterrordax you kill for their scales. You'll finish this later
	.complete 4503,2 --Collect Webbed Pterrordax Scale (x8)
step
	>> Kill the rest of the Pterrordax needed in the southern mountains
   .goto Un'Goro Crater,50.49,90.54,60,0
    .goto Un'Goro Crater,44.11,91.63
    .complete 4501,1 --Kill Pterrordax (x10)
	.unitscan Pterrordax
step
	#completewith Springs
    .goto Un'Goro Crater,36.76,35.47,0
	>>Kill Bloodpetal Trappers that you see
	.complete 4145,2 --Kill Bloodpetal Trapper (x5)
step
	#completewith Springs
    .goto Un'Goro Crater,50.5,65.2,0
	>>Kill Diemetradons that you see. Loot them for Bones and Scales
    .complete 3882,1 --Collect Dinosaur Bone (x8)
	.complete 4503,1 --Collect Webbed Diemetradon Scale (x8)
step
    .goto Un'Goro Crater,38.6,66.1
	>>Loot the boxes on the ground
    .complete 3881,2 --Collect Research Equipment (x1)	
step
	>>Interact with the Pylon
    .goto Un'Goro Crater,23.87,59.21
    .complete 4288,1 --Discover and examine the Western Crystal Pylon
step
	#completewith Springs
    .goto Un'Goro Crater,20.95,59.45,80,0
    .goto Un'Goro Crater,36.76,35.47,0
	>>Kill Frenzied Pterrordax. Loot them for their scales
	.complete 4501,2 --Kill Frenzied Pterrordax (x15)
	.complete 4503,2 --Collect Webbed Pterrordax Scale (x8)
step
    .goto Un'Goro Crater,30.9,50.2
    .accept 974 >> Accept Finding the Source
step
	#completewith next
	.goto Un'Goro Crater,47.1,47.1,10,0
    .goto Un'Goro Crater,47.7,48.3,10,0
    .goto Un'Goro Crater,48.2,50.1,10,0
    .goto Un'Goro Crater,48.6,49.8,20 >> You can go up the lava path on the west side of the volcano as a short-cut
step
	>>Climb up to the top of the volcano. Use Krakle's Thermometer
    .goto Un'Goro Crater,49.6,45.7
    .complete 974,1 --Find the hottest area of Fire Plume Ridge
step
	#label Springs
	>>Travel back to Krackle
    .goto Un'Goro Crater,30.9,50.5
    .turnin 974 >> Turn in Finding the Source
    .accept 980 >> Accept The New Springs
step
	#completewith PterrordaxAndys
    .goto Un'Goro Crater,35.49,43.91,0
	>>Kill Diemetradons that you see. Loot them for Bones and Scales
    .complete 3882,1 --Collect Dinosaur Bone (x8)
	.complete 4503,1 --Collect Webbed Diemetradon Scale (x8)
step
	#completewith next
    .goto Un'Goro Crater,20.95,59.45,80,0
    .goto Un'Goro Crater,36.76,35.47,0
	>>Kill Frenzied Pterrordax. Loot them for their scales
	.complete 4501,2 --Kill Frenzied Pterrordax (x15)
	.complete 4503,2 --Collect Webbed Pterrordax Scale (x8)
step
    .goto Un'Goro Crater,35.49,43.91
	>>Kill Bloodpetal Trappers that you see
	.complete 4145,2 --Kill Bloodpetal Trapper (x5)
step
	#label PterrordaxAndys
    .goto Un'Goro Crater,28.23,30.76
	>>Kill Frenzied Pterrordax. Loot them for their scales
	.complete 4501,2 --Kill Frenzied Pterrordax (x15)
	.complete 4503,2 --Collect Webbed Pterrordax Scale (x8)
step
    .goto Un'Goro Crater,40.94,41.57
	>>Kill Diemetradons that you see. Loot them for Bones and Scales
    .complete 3882,1 --Collect Dinosaur Bone (x8)
	.complete 4503,1 --Collect Webbed Diemetradon Scale (x8)
step
	>>Return to the Volcano. Kill and loot Elementals for Un'Goro Ash
    .goto Un'Goro Crater,53.4,50.9
    .complete 4502,1 --Collect Un'Goro Ash (x9)
step
	>>Ride toward the east side of the volcano. Go into the cave
    .goto Un'Goro Crater,51.9,49.9
    .turnin 4492 >> Turn in Lost!
    .accept 4491 >> Accept A Little Help From My Friends
step
	>> For this escort quest, remember to use the Canteen in your bags to wake him up when he stops moving. Be careful not to ride away too fast from Ringo
    .complete 4491,1 --Escort Ringo to Spraggle Frock at Marshal's Refuge
step
	    .goto Un'Goro Crater,43.6,8.5
    .turnin 4501 >> Turn in Beware of Pterrordax
step
	.goto Un'Goro Crater,44.2,11.4
    .turnin 4503 >> Turn in Shizzle's Flyer
step
    .goto Un'Goro Crater,43.9,7.3
    .turnin 3883 >> Turn in Alien Ecology
    .turnin 3881 >> Turn in Expedition Salvation
step
	>>Go into the cave
    .goto Un'Goro Crater,43.16,6.24,30,0
    .goto Un'Goro Crater,41.9,2.6
    .turnin 4285 >> Turn in The Northern Pylon
    .turnin 4288 >> Turn in The Western Pylon
    .turnin 4287 >> Turn in The Eastern Pylon
    .accept 4321 >> Accept Making Sense of It
    .turnin 4321 >> Turn in Making Sense of It
step
    .goto Un'Goro Crater,43.5,7.5
    .turnin 3882 >> Turn in Roll the Bones
step
    .goto Un'Goro Crater,43.6,8.4
    .turnin 4491 >> Turn in A Little Help From My Friends
step
    .goto Un'Goro Crater,45.5,8.7
    .turnin 4145 >> Turn in Larion and Muigin
    .accept 4147 >> Accept Marvon's Workshop
step
	>>Travel back to the Gorilla cave. Hug the right wall when you enter the cave
    .goto Un'Goro Crater,64.17,16.43,40,0
    .goto Un'Goro Crater,67.6,16.8
    .turnin 4243 >> Turn in Chasing A-Me 01
step
    >>Run to the back of the cave. Kill U'cha. Loot him for his pelt
   .goto Un'Goro Crater,68.0,13.2
    .complete 4301,1 --Collect U'cha's Pelt (x1)
step
	#softcore
	>>If you got a Mithril Casing from the Auction House earlier, turn in the quests at A-Me 01
	>>If you didn't get a Mithril Casing, skip this step
    .goto Un'Goro Crater,67.67,16.75
	.accept 4244 >> Accept Chasing A-Me 01
	.turnin 4244 >> Turn in Chasing A-Me 01
	.accept 4245 >> Accept Chasing A-Me 01
step
	#softcore
	.isOnQuest 4245
	>>Escort A-Me back to the outside of Marshal's Refuge
    .goto Un'Goro Crater,46.37,13.43
    .complete 4245,1 --Protect A-Me 01 until you reach Karna Remtravel (1)
step
	#softcore
	.isOnQuest 4245
    .goto Un'Goro Crater,46.37,13.43
    .turnin 4245 >>Turn in Chasing A-Me 01
step
	#label Larkowi
	>> Open Torwa's Pouch. Place the Threshadon Meat on the flat rock, then apply the Pheromone Mixture on it
	>> KIll Lar'korwi once he's summoned. Loot his head
    .goto Un'Goro Crater,79.94,49.88
    .complete 4292,1 --Collect Lar'korwi's Head (x1)
step
    .goto Un'Goro Crater,67.09,72.94
	>>Collect Un'Goro Soil from mobs or soil patches
	.collect 11018,25 --Un'Goro Soil (25)
step
    .goto Un'Goro Crater,71.6,76.0
    .turnin 4301 >> Turn in The Mighty U'cha
    .turnin 4292 >> Turn in The Bait for Lar'korwi
step << Shaman
	#hardcore
	.hs >> Hearth to Camp Taurajo
	>> Buy food/water if needed
step << Shaman
	#hardcore
    .goto The Barrens,44.45,59.15
	.fly Gadgetzan >> Fly to Gadgetzan
step
    .goto Tanaris,27.06,56.58
	.zone Tanaris >> Travel back up to Tanaris
step
     #completewith next
    #softcore
    .goto Tanaris,27.89,59.02
	.deathskip >> Die and respawn at the Spirit Healer in Gadgetzan
step
	#hardcore
	>>Travel back to Gadgetzan
    .goto Tanaris,51.6,26.8
    .turnin 4504 >> Turn in Super Sticky
step
	#softcore
    .goto Tanaris,51.6,26.8
    .turnin 4504 >> Turn in Super Sticky
step
    .goto Tanaris,50.90,27.00
    .turnin 4496 >> Turn in Bungle in the Jungle
step
    .goto Tanaris,51.60,25.50
    .fly Feralas>> Fly to Feralas
step
    .goto Feralas,76.18,43.83
    .turnin 4120 >> Turn in The Strength of Corruption
step
	>>Travel to Dire Maul
    .goto Feralas,60.07,47.44,50,0
    .goto Feralas,59.59,43.45,10 >> Hug the wall outside of Dire Maul. Make sure your general chat changes to "Dire Maul". This is to unlock a quest later
step
    .goto Feralas,50.76,49.83,60,0
    .goto Feralas,45.12,25.56
     >> Buy some bait from Gregan
    .collect 11141,1
step
    .goto Feralas,44.60,10.19
     >> Give some bait to Miblion who's guarding the Evoroot. Loot the Evoroot in the Ruins
    .collect 11242,1
step
    .goto Feralas,45.12,25.56
     >> Talk to Gregan and trade in the Evoroot
    .complete 3909,1
step << !Mage
    .hs >> Hearth to Camp Taurajo
	>> Buy food/water if needed
step << !Mage
    .goto The Barrens,44.45,59.15
    .fly Thunder Bluff >> Fly to Thunder Bluff
step << Mage
	.zone Thunder Bluff >> Teleport to Thunder Bluff
step << Mage
    .goto Thunder Bluff,25.2,20.9
	.trainer >> Go and train your class spells
step
    #sticky
	#label BluffRunner
    .goto Thunder Bluff,41.54,57.87,70,0
    .goto Thunder Bluff,52.76,62.07,30,0
    .goto Thunder Bluff,55.63,50.08,70,0
    .goto Thunder Bluff,41.54,57.87,0
	>>Find Bluff Runner Windstrider. Accept his quest
    .accept 1000 >> Accept The New Frontier
	.unitscan Bluff Runner Windstrider
step
    .goto Thunder Bluff,45.80,64.70
    .accept 3762 >> Accept Assisting Arch Druid Runetotem
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
step
    .goto Thunder Bluff,78.50,28.60
    .turnin 1000 >> Turn in The New Frontier
    .accept 1123 >> Accept Rabine Saturna
    .turnin 3762 >> Turn in Assisting Arch Druid Runetotem
    .accept 3761 >> Accept Un'Goro Soil
step
    .goto Thunder Bluff,77.30,22.20
    .turnin 3761 >> Turn in Un'Goro Soil
step
    .goto Thunder Bluff,78.40,28.80
    .accept 3782 >> Accept Morrowgrain Research
step
    .goto Thunder Bluff,70.20,30.70
    .turnin 3518 >> Turn in Delivery to Magatha
    .accept 3562 >> Accept Magatha's Payment to Jediga
step
    .goto Thunder Bluff,71.00,33.80
    .turnin 3782 >> Turn in Morrowgrain Research
step
	#requires BluffRunner
    .goto Thunder Bluff,46.8,50.0
    .fly Ratchet>> Fly to Ratchet
]])

RXPGuides.RegisterGuide("RestedXP Horde 50-60",[[
#classic
<< Horde

#name 54-56 Felwood/Winterspring
#next 56-58 Western PL/Eastern PL

step
    .goto The Barrens,62.50,38.70
    .turnin 4502 >> Turn in Volcanic Activity
step
    .goto The Barrens,62.50,38.70
    .turnin 4147 >> Turn in Marvon's Workshop
step
    .goto The Barrens,65.80,43.80
    .turnin 5158 >> Turn in Seeking Spiritual Aid
    .accept 5159 >> Accept Cleansed Water Returns to Felwood
step
    .goto The Barrens,63.1,37.1
    .fly Azshara>> Fly to Azshara
step
    .goto Azshara,22.50,51.40
    .turnin 3562 >> Turn in Magatha's Payment to Jediga
    .turnin 3563 >> Turn in Jes'rimon's Payment to Jediga
    .accept 3542 >> Accept Delivery to Andron Gant
step
    .goto Azshara,22.00,49.70
    .fly Felwood>> Fly to Felwood
step
    .goto Felwood,34.30,52.30
    .accept 4506 >> Accept Corrupted Sabers
step
    .goto Felwood,34.80,52.80
    .accept 4521 >> Accept Wild Guardians
step
    #sticky
	#label SoulShards
     >> Collect 6 Corrupted Soul Shards from mobs you kill and loot with the Beacon in your inventory
    .collect 11515,6
step
    .goto Felwood,51.20,82.10
    .turnin 5159 >> Turn in Cleansed Water Returns to Felwood
    .accept 5165 >> Accept Dousing the Flames of Protection
step
    .goto Felwood,36.02,66.99,70,0
    .goto Felwood,32.40,66.60
    .cast 15647 >> Use Winna's Kitten Carrier at the corrupted moonwell
    
--P Super important to get .castspell working
step
    #sticky
	#label StrangeRed
    .goto Felwood,37.96,54.37,0
     >> Grind Jaedenar mobs inside of Shadow Hold until you get the Blood Red Key
	.collect 13140,1,5202
    .accept 5202 >> Accept A Strange Red Key
step
	#sticky
	#label StrangeRed2
	#requires StrangeRed
    .goto Felwood,36.21,55.50
    .turnin 5202 >>Turn in A Strange Red Key
    .accept 5203 >>Accept Rescue From Jaedenar
step
	#sticky
	#label Arko
	#requires StrangeRed2
	>>Protect Arko'narin as you extinguish the Braziers within Shadow Hold
	>>Be careful as this quest can be HARD. 3 Felguards will spawn after Arko'narin equips her armor (use short <3 minute cooldowns)
	>>An elite will spawn at the end once Arko'narin leaves the cave. Be careful as he has a 500 damage instant shock spell
    .complete 5203,1 --Protect Arko'narin out of Shadow Hold (1)
step
    .goto Felwood,38.47,59.51,50,0
    .goto Felwood,35.39,58.74,30,0
    .goto Felwood,36.26,56.30
     >> Run down into Shadow Hold in Jaedenar. Douse the first Brazier
    .complete 5165,1
step
    .goto Felwood,36.48,55.18
     >> Douse the second Brazier
    .complete 5165,4
step
    .goto Felwood,36.73,53.26
     >> Douse the third Brazier
    .complete 5165,3
step
    .goto Felwood,37.67,52.68
     >> Douse the fourth Brazier
    .complete 5165,2
step
	#requires Arko
    .goto Felwood,34.20,52.30
	>>Talk to the Cat when you get near to Winna (or you won't be able to turn in)
    .turnin 4506 >> Turn in Corrupted Sabers
step
	>>Travel up to northern Felwood
    .goto Felwood,64.70,8.10
    .accept 8461 >> Accept Deadwood of the North
step
    #completewith next
    .goto Felwood,62.68,8.06,0
     >> Kill Furbolgs in the area
    .complete 8461,1
    .complete 8461,2
    .complete 8461,3
step
    .goto Felwood,60.20,5.90
	>>Click on the Cauldron
    .turnin 5084 >> Turn in Falling to Corruption
    .accept 5085 >> Accept Mystery Goo
step
    .goto Felwood,62.68,8.06
     >> Kill Furbolgs in the area
    .complete 8461,1
    .complete 8461,2
    .complete 8461,3
step
    .goto Felwood,64.70,8.20
    .turnin 8461 >> Turn in Deadwood of the North
    .accept 8465 >> Accept Speak to Salfa
step
     #completewith next
    .goto Felwood,65.16,7.88,40,0
    .goto Felwood,64.67,3.14,40,0
    .goto Felwood,66.40,2.95,40,0
    .goto Felwood,68.24,5.60,40,0
    .goto Felwood,68.73,6.38
	.zone Winterspring >> Travel through Timbermaw Hold to Winterspring
step
    .goto Felwood,68.30,6.10
    .turnin 8465 >> Turn in Speak to Salfa
    .accept 8464 >> Accept Winterfall Activity
step
	#softcore
    .goto Winterspring,31.30,45.10
    .turnin 980 >> Turn in The New Springs
    .accept 4842 >> Accept Strange Sources
    .turnin 3909 >> Turn in The Videre Elixir
    .accept 3912 >> Accept Meet at the Grave
    .turnin 5085 >> Turn in Mystery Goo
    .accept 5086 >> Accept Toxic Horrors
step
	#hardcore
    .goto Winterspring,31.30,45.10
    .turnin 980 >> Turn in The New Springs
    .accept 4842 >> Accept Strange Sources
    .turnin 3909 >> Turn in The Videre Elixir
    .turnin 5085 >> Turn in Mystery Goo
    .accept 5086 >> Accept Toxic Horrors
step
	#completewith Ursius
    .goto Winterspring,44.98,37.83,0
     >> Kill Ragged Owlbeasts en route to Everlook
    .complete 4521,2
step
	>>Run to Everlook
    .goto Winterspring,61.2,38.8
    .home >> Set your Hearthstone to Everlook
step
    .goto Winterspring,60.88,37.61
    .accept 3783 >> Accept Are We There, Yeti?
step
	#label Ursius
    .goto Winterspring,61.93,38.37
    .accept 5054 >> Accept Ursius of the Shardtooth
step
    .goto Winterspring,44.98,37.83
     >> Kill Ragged Owlbeasts west of Everlook
    .complete 4521,2
step
	#completewith ROwlbeasts
    .goto Winterspring,58.22,33.79,0
	>>Kill Yetis. Loot them for their Fur
    .complete 3783,1
step
	#completewith next
    .goto Winterspring,60.67,29.81,0
    .goto Winterspring,58.64,34.51,0
	>>Kill Raging Owlbeasts
    .complete 4521,1
step
    .goto Winterspring,56.62,32.34,70,0
    .goto Winterspring,60.50,33.02,70,0
    .goto Winterspring,62.55,30.83,70,0
    .goto Winterspring,62.43,28.08,70,0
    .goto Winterspring,63.40,27.04
     >> Kill Ursius. You can kite him back to Everlook if needed. Remember to deal 51%+ damage
	>> Be careful, as this quest can be difficult
    .complete 5054,1
    .unitscan Ursius
step
	#label ROwlbeasts
    .goto Winterspring,60.67,29.81,60,0
    .goto Winterspring,58.64,34.51
	>>Kill Raging Owlbeasts
    .complete 4521,1
step
    .goto Winterspring,65.97,41.47
	>>Kill Yetis. Loot them for their Fur
    .complete 3783,1
step << Shaman
	.hs >> Hearth to Everlook
	>> Buy food/water if needed
step
    .goto Winterspring,61.90,38.40
    .turnin 5054 >> Turn in Ursius of the Shardtooth
    .accept 5055 >> Accept Brumeran of the Chillwind
    .accept 969 >> Accept Luck Be With You << Hunter
step
    .goto Winterspring,60.88,37.61
    .turnin 3783 >> Turn in Are We There, Yeti?
step
	#softcore
    .goto Winterspring,54.7,46.0,60,0
    .goto Winterspring,56.6,52.4,60,0
    .goto Winterspring,60.5,55.6,60,0
    .goto Winterspring,62.4,58.9,60,0
    .goto Winterspring,58.8,63.5
     >> Kill Brumeran, group up for him if needed.
	>>This quest is HARD. Skip this quest if needed
    .complete 5055,1
    .unitscan Brumeran
step
	#hardcore
    .goto Winterspring,54.7,46.0,60,0
    .goto Winterspring,56.6,52.4,60,0
    .goto Winterspring,60.5,55.6,60,0
    .goto Winterspring,62.4,58.9,60,0
    .goto Winterspring,58.8,63.5
     >> Kill Brumeran
	>>This quest is HARD. Skip this quest if needed
    .complete 5055,1
    .unitscan Brumeran
step << Hunter
    #completewith next
    .goto Winterspring,60.43,65.31,0
     >> Loot the blue crystals around the outer perimeter of the canyon, use your pet to bait the giants away from the crystals. Run away after looting one
    >>This is a hard quest to solo, skip this quest if you have to
    .complete 969,1
    .link https://www.twitch.tv/videos/850027450?t=00h26m14s >> Click here for video reference
step
     >> Head to the border of Darkwhisper Gorge
    .goto Winterspring,60.09,73.34
    .complete 4842,1 --Discover Darkwhisper Gorge (1)
step << Hunter
    .goto Winterspring,60.43,65.31
     >> Loot the blue crystals around the outer perimeter of the canyon, use your pet to bait the giants away from the crystals. Run away after looting one
    >>This is a hard quest to solo, skip this quest if you have to
    .complete 969,1
    .link https://www.twitch.tv/videos/850027450?t=00h26m14s >> Click here for video reference
step
    #softcore
     #completewith next
     .deathskip >> Once you finish all quests, die on purpose and respawn at Everlook
step
    #hardcore
	#requires brumeran2
    .hs >> Hearth to Everlook
	>> Buy food/water if needed
step
	#requires brumeran2
	#softcore
     #completewith next
     .deathskip >> Once you finish all quests, die on purpose and respawn at Everlook
step << Hunter
    .goto Winterspring,61.90,38.40
    .turnin 969 >> Turn in Luck Be With You
    .isQuestComplete 969
step
    .goto Winterspring,61.90,38.40
    .turnin 5055 >> Turn in Brumeran of the Chillwind
    .isQuestComplete 5055
step
    #softcore
    .fly Tanaris>> Fly to Tanaris
step
	#softcore
    .goto Winterspring,60.47,36.30
    .fly Tanaris>> Fly to Tanaris
step
	#softcore
    .goto Tanaris,53.90,23.40
     >> Use the Videre Elixir at the Tanaris Graveyard
    .turnin 3912 >> Turn in Meet at the Grave
    .accept 3913 >> Accept A Grave Situation
step
    #softcore
    .goto Tanaris,53.80,29.10
    .turnin 3913 >> Turn in A Grave Situation
    .accept 3914 >> Accept Linken's Sword
step
    #softcore
    .fly Un'Goro Crater>> Fly to Un'Goro Crater
step
	#softcore
    .goto Tanaris,51.60,25.50
    .fly Un'Goro Crater>> Fly to Un'Goro Crater
step
	#softcore
    .goto Tanaris,13.10,6.40
    .turnin 3914 >> Turn in Linken's Sword
    .accept 3941 >> Accept A Gnome's Assistance
step
	#softcore
    .goto Tanaris,11.60,3.40
    .turnin 3941 >> Turn in A Gnome's Assistance
    .accept 3942 >> Accept Linken's Memory
step
    #softcore
    #completewith next
    .hs >> Hearth to Winterspring
	>> Buy food/water if needed
step
    .goto Winterspring,61.34,38.97
    .accept 6029 >> Accept The Everlook Report
    .accept 6030 >> Accept Duke Nicholas Zverenhoff
step
    .goto Winterspring,60.47,36.30
    .fly Felwood>> Fly to Felwood
step
    .goto Felwood,34.70,52.70
    .turnin 4521 >> Turn in Wild Guardians
    .accept 4741 >> Accept Wild Guardians
step
    .goto Felwood,51.20,82.10
    .turnin 5165 >> Turn in Dousing the Flames of Protection
    .accept 5242 >> Accept A Final Blow
step
    .goto Felwood,51.30,82.00
    .turnin 5203 >> Turn in Rescue From Jaedenar
    .accept 5204 >> Accept Retribution of the Light
step
	#softcore
    .goto Felwood,51.30,81.50
    .turnin 3942 >> Turn in Linken's Memory
    .accept 4084 >> Accept Silver Heart
step
	#label wolvesbears
    #completewith next
     >> Kill Wolves/Bears. Loot them for their claws
    .complete 4084,1
step
    .goto Felwood,38.47,59.51,50 >> Run to Jaedenar (Shadow Hold)
step
    .goto Felwood,35.39,58.74,30,0
    .goto Felwood,38.30,50.50
     >> Go deep into Shadow Hold. Kill Rakaiah
    .complete 5204,1
step
    .goto Felwood,38.50,50.40
	>> Be careful when clearing mobs around the corpse, as they can bug by keeping you in combat, but not attacking you
    .turnin 5204 >> Turn in Retribution of the Light
    .accept 5385 >> Accept The Remains of Trey Lightforge
step
    .goto Felwood,38.90,46.80
	>> Go deeper into the cave
	>> Kill Moora and Salia. Abuse the Line of Sight to avoid Fel'dan's Shadow Bolts by using the out-sticking wall just outside the room
     >> Kill Shadow-Lord Fel'dan, then loot his Head.
    .complete 5242,1
    .complete 5242,2
    .complete 5242,3
step
	#completewith next
    .goto Felwood,38.72,46.77
	+Perform a logout skip to teleport out of Shadow Hold
	.link https://youtu.be/SWBtPqm5M0Q?t=128 >> CLICK HERE for reference
step << Rogue
    .goto Winterspring,13.90,96.10
    .turnin 5242 >> Turn in A Final Blow
step << Rogue
    .goto Winterspring,14.00,96.00
    .turnin 5385 >> Turn in The Remains of Trey Lightforge
step
    .goto Felwood,51.90,21.80
     >> Kill Treants. Loot them for the Irontree Heart
    .complete 4084,2
step
    .goto Winterspring,12.41,50.58
     >> Kill Toxic Horrors. Loot them for their Droplets
    .complete 5086,1
step
    .goto Felwood,53.75,28.06,90,0
    .goto Felwood,58.03,17.83,90,0
    .goto Felwood,63.27,19.15
     >> Kill Wolves/Bears. Loot them for their claws
    .complete 4084,1
step
     #completewith next
    .goto Felwood,65.16,7.88,40,0
    .goto Felwood,64.67,3.14,40,0
    .goto Felwood,66.40,2.95,40,0
    .goto Felwood,68.24,5.60,40,0
    .goto Felwood,68.73,6.38
	.zone Winterspring >> Travel through Timbermaw Hold to Winterspring
step
    .goto Winterspring,31.30,45.20
    .turnin 4842 >> Turn in Strange Sources
    .turnin 5086 >> Turn in Toxic Horrors
    .accept 5087 >> Accept Winterfall Runners
step
    .goto Winterspring,67.96,37.54,0
    .goto Winterspring,66.16,33.66,0
    .goto Winterspring,64.37,32.06,0
    .goto Winterspring,62.41,25.53,0
    .goto Winterspring,61.97,23.00,0
    .goto Winterspring,57.30,28.05,0
    .goto Winterspring,54.07,30.98,0
    .goto Winterspring,53.49,34.13,0
    .goto Winterspring,47.81,39.23,0
    .goto Winterspring,39.36,41.28,0
    .goto Winterspring,30.12,42.57,0
    .goto Winterspring,28.01,34.60,0
    .goto Felwood,60.20,5.90
    >> Look for Winterfall Runners. They patrol the road between the Timbermaw Hold tunnel and Winterfall Village northeast of Everlook
     >> Alternatively, run back through the cave to Felwood, and kill the Runner located at the cauldron in Felpaw Village
    .complete 5087,1
    .unitscan Winterfall Runner
step
    .goto Winterspring,31.30,45.20
    .turnin 5087 >> Turn in Winterfall Runners
    .accept 5121 >> Accept High Chief Winterfall
step << !Mage
	#softcore
    .deathskip >> Die and respawn at the Spirit Healer in Everlook
step << !Mage
    .goto Winterspring,60.47,36.30
    .fly Orgrimmar>> Fly to Orgrimmar
step << Mage
    .zone Undercity >> Teleport to Undercity
]])

RXPGuides.RegisterGuide("RestedXP Horde 50-60",[[
#classic
<< Horde

#name 56-58 Western PL/Eastern PL
#next 59-59 Winterspring/Silithus I

step << !Mage
    #sticky
    #completewith next
    .goto Durotar,50.8,13.8,40 >> Go to the Zeppelin tower. Take the zeppelin to Undercity
step << !Mage
    .zone Tirisfal Glades >>Arrive in Tirisfal
step
	>>Run to The Bulwark
    .goto Tirisfal Glades,83.1,68.9
    .turnin 5093 >>Turn in A Call to Arms: The Plaguelands!
    .accept 5096 >>Accept Scarlet Diversions
step
	.goto Western Plaguelands,26.55,56.18
        >>Loot the crate next to the fire
        .collect 12814,1 --Flame in a Bottle (1)	
step
    .goto Tirisfal Glades,83.2,68.6
    .turnin 6029 >>Turn in The Everlook Report
    .turnin 5405 >>Turn in Argent Dawn Commission
step
    .goto Tirisfal Glades,83.3,72.1
    .accept 5901 >>Accept A Plague Upon Thee
step
	>> Be careful as the mobs are relatively difficult, and can chain-pull each other here
    >>Burn the command tent down, then use the banner in your inventory on top of it
    .goto Western Plaguelands,40.5,51.8
    .complete 5096,1 --Destroy the command tent and plant the Scourge banner in the camp (1)
step
    .goto Tirisfal Glades,83.0,69.0
    .turnin 5096 >>Turn in Scarlet Diversions
    .accept 5098 >>Accept All Along the Watchtowers
    .accept 5228 >>Accept The Scourge Cauldrons
step
    .goto Tirisfal Glades,83.0,71.9
    .turnin 5228 >>Turn in The Scourge Cauldrons
    .accept 5229 >>Accept Target: Felstone Field
step
    >>Kill Cauldron Lord Bilemaw. Loot him for the key
    .goto Western Plaguelands,37.12,57.18
    .complete 5229,1 --Felstone Field Cauldron Key (1)
    .unitscan Cauldron Lord Bilemaw
step
    .goto Western Plaguelands,37.2,56.8
    .turnin 5229 >>Turn in Target: Felstone Field
    .accept 5230 >>Accept Return to the Bulwark
step
	>>Second floor of the house
    .goto Western Plaguelands,38.3,54.1
    .accept 5021 >>Accept Better Late Than Never
step
	>>Loot the parcel in the barn
    .goto Western Plaguelands,38.8,55.3
    .turnin 5021 >>Turn in Better Late Than Never
    .accept 5023 >>Accept Better Late Than Never
step
	>>Run back to The Bulwark
    .goto Tirisfal Glades,83.0,72.0
    .turnin 5230 >>Turn in Return to the Bulwark
    .accept 5231 >>Accept Target: Dalson's Tears
step
    >>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
    .goto Western Plaguelands,42.28,66.05
    .complete 5098,2 --Tower Two marked (1)
step
    >>Kill Cauldron Lord Malvinous. Loot him for the key
    .goto Western Plaguelands,46.04,52.33
    .complete 5231,1 --Dalson's Tears Cauldron Key (1)
step
    .goto Western Plaguelands,46.2,52.0
    .turnin 5231 >>Turn in Target: Dalson's Tears
    .accept 5232 >>Accept Return to the Bulwark
step
	>>Turn in at the book in the farm
    .goto Western Plaguelands,47.8,50.6
    .turnin 5058 >>Turn in Mrs. Dalson's Diary
step	
    .goto Western Plaguelands,47.49,51.00
        >>Kill the Wandering Skeleton that is behind both buildings & loot the Outhouse Key. If he's not up, grind more Bone Fragments.
        .collect 12738,1
	.unitscan Wandering Skeleton
step
	#completewith next
    >>Click the outhouse. This will spawn a mob. Kill it
    .goto Western Plaguelands,48.2,49.7
    .turnin 5059 >> Turn in Locked Away
step
    .goto Western Plaguelands,48.2,49.7
	>>Kill Farmer Dalson. Be careful as he thrashes
    .collect 12739,1,5060 --Collect Dalson Cabinet Key (x1)
step
    .goto Western Plaguelands,47.4,49.7
	>>Click on the cabinet at the top floor of the farmhouse
    .turnin 5060 >> Turn in Locked Away
step
    >>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
    .goto Western Plaguelands,40.15,71.50
    .complete 5098,1 --Tower One marked (1)
step
	>>Go to the top floor of the Inn. Talk to Chromie
    .goto Western Plaguelands,39.4,66.9
    .accept 4971 >>Accept A Matter of Time
step
    >>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
    .goto Western Plaguelands,44.24,63.06
    .complete 5098,3 --Tower Three marked (1)
step
    .goto Western Plaguelands,45.8,63.3
	>>Use the Temporal Displacer near the blue-glowing silos of Andorhal to spawn the parasites.
	>>Be careful as the Parasites can spawn up to 3 at once, and have a 50% chance of respawning when killed. They also cast Slow
	>>They are evadeable in the water near Andorhal
    .complete 4971,1 --Temporal Parasite (15)
step
    >>Use the Beacon Torch in your bags on the side of the doorway (do NOT kill the elite inside)
    .goto Western Plaguelands,46.73,71.14
    .complete 5098,4 --Tower Four marked (1)
step
    .goto Tirisfal Glades,83.0,71.9
    .turnin 5232 >>Turn in Return to the Bulwark
    .accept 5233 >>Accept Target: Writhing Haunt
step
    .goto Tirisfal Glades,83.0,68.9
    .turnin 5098 >>Turn in All Along the Watchtowers
    .accept 838 >>Accept Scholomance
step
    .goto Tirisfal Glades,83.2,69.3
    .turnin 838 >>Turn in Scholomance
    .accept 964 >>Accept Skeletal Fragments
step
	>>Go to the top floor of the Inn. Talk to Chromie
    .goto Western Plaguelands,39.5,66.8
    .turnin 4971 >>Turn in A Matter of Time
    .accept 4972 >>Accept Counting Out Time
step
	#completewith next
	>>Loot the tiny gray Lockboxes found throughout the buildings of the ruins. There's usually 1 per building
    .goto Western Plaguelands,42.8,68.3,0
    .complete 4972,1 --Andorhal Watch (5)
step
    .goto Western Plaguelands,47.79,70.90
	>>Kill Skeletons in Andorhal. Loot them for Skeletal Fragments
    .complete 964,1 --Skeletal Fragments (15)
step
	>>Loot the tiny gray Lockboxes found throughout the buildings of the ruins. There's usually 1 per building
    .goto Western Plaguelands,42.8,68.3
    .complete 4972,1 --Andorhal Watch (5)
step
    >>Kill Cauldron Lord Razarch. Loot him for the key
	>>Be careful of the Freezing Ghouls nearby, as they have a 5-second long, instant cast AoE stun
    .goto Western Plaguelands,53.07,65.97
    .complete 5233,1 --Writhing Haunt Cauldron Key (1)
step
    .goto Western Plaguelands,53.0,65.7
	>>Be careful of the Freezing Ghouls nearby, as they have a 5-second long, instant cast AoE stun
    .turnin 5233 >>Turn in Target: Writhing Haunt
    .accept 5234 >>Accept Return to the Bulwark
step
    .goto Western Plaguelands,53.7,64.8
	>>Go into the house. Accept the quest from Mulgris
	>>Be careful of the Freezing Ghouls nearby, as they have a 5-second long, instant cast AoE stun
    .accept 4984 >>Accept The Wildlife Suffers Too
step
	#completewith Businessman
    .goto Western Plaguelands,46.41,42.36,0
	>>Kill Diseased Wolves that you see
    .complete 4984,1 --Diseased Wolf (8)
	.unitscan Diseased Wolf
step
    .goto Western Plaguelands,51.9,28.2
    .accept 6004 >>Accept Unfinished Business	
step
	#completewith next
     >>Kill the Scarlet Mages and Knights along the road. Come back later if you can't find 2 of each
	>>The Mages and Knights share respawns, so you may have to kill some to respawn the ones you need (about 75% Knight, 25% Mage)
    .goto Western Plaguelands,50.43,41.12,70,0
    .goto Western Plaguelands,53.50,36.85,70,0
    .goto Western Plaguelands,50.43,41.12
    .complete 6004,3 --Scarlet Mage (2)
	.complete 6004,4 --Scarlet Knight (2)
step
	>>Kill Scarlet Medics and Hunters found in the camps
	>>The Medics and Hunters share respawns with other mobs, so you may have to kill some other types to respawn the ones you need
    .goto Western Plaguelands,51.77,44.13,70,0
    .goto Western Plaguelands,40.83,52.30,70,0
    .goto Western Plaguelands,47.35,51.54,0
    .goto Western Plaguelands,51.77,44.13
    .complete 6004,1 --Scarlet Medic (2)
    .complete 6004,2 --Scarlet Hunter (2)
step
     >>Kill the Scarlet Mages and Knights along the road. Come back later if you can't find 2 of each
	>>The Mages and Knights share respawns, so you may have to kill some to respawn the ones you need (about 75% Knight, 25% Mage)
    .goto Western Plaguelands,50.43,41.12,70,0
    .goto Western Plaguelands,53.50,36.85,70,0
    .goto Western Plaguelands,50.43,41.12
    .complete 6004,3 --Scarlet Mage (2)
	.complete 6004,4 --Scarlet Knight (2)
step
    .goto Western Plaguelands,52.0,28.1
    .turnin 6004 >>Turn in Unfinished Business
    .accept 6023 >>Accept Unfinished Business
step
	>>Kill Huntsman Radley. Be careful not to chain pull the mobs around her
	>>Be careful of the Spellbinders in the area, as they cast Frost Nova
    .goto Western Plaguelands,57.83,36.10
    .complete 6023,1 --Huntsman Radley (1)
step
	>>Kill Cavalier Durgen. Be careful as he has a 5 second, instant cast stun
	>>Try to kill him when he patrols outside to the front of the tower
    .goto Western Plaguelands,54.1,25.1
    .complete 6023,2 --Cavalier Durgen (1)
	.unitscan Cavalier Durgen
step
	#label Businessman
    .goto Western Plaguelands,51.9,28.2
    .turnin 6023 >>Turn in Unfinished Business
    .accept 6025 >>Accept Unfinished Business
step
	#completewith Businessman
    .goto Western Plaguelands,47.92,39.63,90,0
    .goto Western Plaguelands,46.70,47.77,90,0
    .goto Western Plaguelands,51.35,48.78,90,0
    .goto Western Plaguelands,52.13,61.17,90,0
    .goto Western Plaguelands,47.92,39.63
	>>Kill Diseased Wolves. They share spawns with Carrion Lurkers. Kill them too if you're unable to find wolves.
    .complete 4984,1 --Diseased Wolf (8)
	.unitscan Diseased Wolf
step
    .goto Western Plaguelands,53.7,64.7
    .turnin 4984 >>Turn in The Wildlife Suffers Too
    .accept 4985 >>Accept The Wildlife Suffers Too
step
    .goto Western Plaguelands,56.08,63.26,90,0
    .goto Western Plaguelands,60.15,59.93,90,0
    .goto Western Plaguelands,59.43,52.40,90,0
    .goto Western Plaguelands,68.18,46.23,90,0
    .goto Western Plaguelands,56.08,63.26
	>>Kill Diseased Grizzlys
    .complete 4985,1 --Diseased Grizzly (8)
	.unitscan Diseased Grizzly
step
	>>Travel to Tirion Fordring
    .goto Eastern Plaguelands,7.5,43.6
    .accept 5542 >>Accept Demon Dogs
    .accept 5543 >>Accept Blood Tinged Skies
    .accept 5544 >>Accept Carrion Grubbage
step
	#completewith WormMeat
    .goto Eastern Plaguelands,16.80,64.61,0
    .goto Eastern Plaguelands,25.28,70.11,0
    .goto Eastern Plaguelands,30.37,69.59,0
    .goto Eastern Plaguelands,42.26,69.09,0
    .goto Eastern Plaguelands,44.43,82.82,0
    .goto Eastern Plaguelands,57.29,79.85,0
	>>Kill Carrion Worms. Loot them for their Meat
    .complete 5544,1 --Collect Slab of Carrion Worm Meat (x15)
step
	#completewith Pamela
    .goto Eastern Plaguelands,16.80,64.61,0
    .goto Eastern Plaguelands,25.28,70.11,0
    .goto Eastern Plaguelands,30.37,69.59,0
    .goto Eastern Plaguelands,42.26,69.09,0
    .goto Eastern Plaguelands,44.43,82.82,0
    .goto Eastern Plaguelands,57.29,79.85,0
	>>Kill Plaguebats and Plaguehounds in the area
    .complete 5543,1 --Kill Plaguebat (x30)
    .complete 5542,1 --Kill Plaguehound Runt (x20)
step
	>>Travel to Nathanos
    .goto Eastern Plaguelands,26.6,74.8
    .accept 6022 >>Accept To Kill With Purpose
    .accept 6042 >>Accept Un-Life's Little Annoyances
    .accept 6133 >>Accept The Ranger Lord's Behest
step
    .goto Eastern Plaguelands,36.4,90.8
    .turnin 5601 >>Turn in Sister Pamela
    .accept 5149 >>Accept Pamela's Doll
step
    .goto Eastern Plaguelands,38.25,92.23,40,0
    .goto Eastern Plaguelands,39.58,92.60,40,0
    .goto Eastern Plaguelands,39.63,90.12
	>>Find the 3 doll parts scattered around the town on the floor. Kill the mobs guarding them, then put the Doll pieces back together.
	.collect 12886,1
	.collect 12887,1
	.collect 12888,1
step
    .goto Eastern Plaguelands,36.4,90.8
	>>Click one of the 3 pieces and combine them together.
    .complete 5149,1 --Pamela's Doll (1)
step
	#label Pamela
    .goto Eastern Plaguelands,36.4,90.8
    .turnin 5149 >>Turn in Pamela's Doll
    .accept 5152 >>Accept Auntie Marlene
    .accept 5241 >>Accept Uncle Carlin
step
    .goto Eastern Plaguelands,16.80,64.61,80,0
    .goto Eastern Plaguelands,25.28,70.11,80,0
    .goto Eastern Plaguelands,30.37,69.59,80,0
    .goto Eastern Plaguelands,42.26,69.09,80,0
    .goto Eastern Plaguelands,44.43,82.82,80,0
    .goto Eastern Plaguelands,57.29,79.85,80,0
    .goto Eastern Plaguelands,16.80,64.61
	>>Kill Plaguebats and Plaguehounds in the area
    .complete 5543,1 --Kill Plaguebat (x30)
    .complete 5542,1 --Kill Plaguehound Runt (x20)
step
    .goto Eastern Plaguelands,72.94,54.96
	>>Kill Plaguehounds in the area
    .complete 5542,2 --Kill Plaguehound (x5)
step
	#completewith next
	>> Get 7 Living Rot from the undead mobs in town and turn it into a Coagulated Rot before they expire
	.collect 15447,7 --Living Rot (7)
step
	>> Use the Mortar and Pestle to combine the Living Rot into Coagulated Rot
    .goto Eastern Plaguelands,62.5,66.5
    .complete 6022,1 --Coagulated Rot (1)
step
    .goto Eastern Plaguelands,51.67,60.09,90,0
    .goto Eastern Plaguelands,72.94,54.96
	>>Kill Plaguehounds and Noxious Plaguebats in the area
    .complete 5542,2 --Kill Plaguehound (x5)
	.complete 6042,1 --Noxious Plaguebat (20)
step
    .goto Eastern Plaguelands,79.6,63.9
    .accept 6021 >>Accept Zaeldarr the Outcast
    .accept 5281 >>Accept The Restless Souls
step
    .goto Eastern Plaguelands,81.4,59.9
    .turnin 6030 >>Turn in Duke Nicholas Zverenhoff
    .turnin 5241 >>Turn in Uncle Carlin
    .accept 5211 >>Accept Defenders of Darrowshire
step
    .goto Eastern Plaguelands,80.2,57.0
    .fp Light's Hope Chapel >> Get the Light's Hope Chapel flight path
step
	#completewith Memories
	>>These can be hard to find. Kill Ghouls and the Darrowshire Spirits will emerge from the corpses. Talk to them to free their spirit.
    .goto Eastern Plaguelands,77.11,48.00,90,0
    .goto Eastern Plaguelands,67.85,41.13,90,0
    .goto Eastern Plaguelands,63.70,38.55,90,0
    .goto Eastern Plaguelands,77.11,48.00,0
    .goto Eastern Plaguelands,67.85,41.13,0
    .goto Eastern Plaguelands,63.70,38.55,0
    .goto Eastern Plaguelands,61.04,66.91,0
    .goto Eastern Plaguelands,39.02,52.71,0
    .complete 5211,1 --Darrowshire Spirits Freed (15)
	.unitscan Diseased Flayer,Gibbering Ghoul
step
	#label WormMeat
    .goto Eastern Plaguelands,46.5,38.7
	>>Kill Monstrous Plaguebats and Frenzied Plaguehounds
	>>Be careful as Plaguebats can silence for 10 seconds in melee range << !Rogue !Warrior
	.complete 6042,2 --Monstrous Plaguebat (10)
	.complete 5542,3 --Frenzied Plaguehound (5)
step
    .goto Eastern Plaguelands,53.81,37.82,90,0
    .goto Eastern Plaguelands,48.90,27.18
	>>Kill Carrion Worms. Loot them for their Meat
    .complete 5544,1 --Collect Slab of Carrion Worm Meat (x15)
	.unitscan Carrion Devourer
step
	>>Loot the Termite Mounds found around Plaguewood. They look like half-cut tree logs
    .goto Eastern Plaguelands,25.68,32.38
    .complete 5901,1 --Plagueland Termites (100)
step
	>>Inside the house
    .goto Eastern Plaguelands,14.5,33.7
    .turnin 5281 >>Turn in The Restless Souls
    .accept 6164 >>Accept Augustus' Receipt Book
step
	>>Second floor of the Inn on the floor
    .goto Eastern Plaguelands,17.5,31.2
    .complete 6164,1 --Augustus' Receipt Book (1)
step
	>>Run back to the house
    .goto Eastern Plaguelands,14.5,33.6
    .turnin 6164 >>Turn in Augustus' Receipt Book
--P SKIP LINK
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
	+Cut through the mountain to save travel time by performing the Eastern PL mountain skip
	>>You MUST have Noggenfogger Elixirs in your bag for this
	.link https://www.youtube.com/watch?v=6VIULBxMyfU >> CLICK HERE for reference
step
    .goto Eastern Plaguelands,7.6,43.7
    .turnin 5542 >>Turn in Demon Dogs
    .turnin 5543 >>Turn in Blood Tinged Skies
    .turnin 5544 >>Turn in Carrion Grubbage
    .accept 5742 >>Accept Redemption
step
    .goto Eastern Plaguelands,7.6,43.7
	>>Type /sit when listening to Tirion's Tale. You can be mounted when doing this
    .complete 5742,1 --Tirion's Tale (1)
	.skipgossip
    .turnin 5742 >>Turn in Redemption
    .accept 5781 >>Accept Of Forgotten Memories
step
	>>Run back to Nathanos
    .goto Eastern Plaguelands,26.6,74.8
    .turnin 6022 >>Turn in To Kill With Purpose
    .turnin 6042 >>Turn in Un-Life's Little Annoyances
step
	>>Click on the dirt grave to summon Mercutio and 3 adds. Kill Mercutio, and loot him for Taelan's hammer
	>>Be careful, as the adds take a LONG time to reset and break leash for some reason. 
	>>This quest is one of the hardest in the game. Skip it if you need to << !Mage !Warlock !Hunter !Rogue !Druid
	>> Split pull the pack that spawns with Blizzard. Kite Mercutio away until the other mobs break leash << Mage
	>> Split pull the pack that spawns with Rain of Fire. Kite Mercutio away until the other mobs break leash << Warlock
	>> Split pull the pack that spawns with Volley. Kite Mercutio away until the other mobs break leash << Hunter
	>> Stealth into the middle of the pack that spawns, then de-stealth, immediately aggroing all mobs at once. Keep refreshing leash on Mercutio whilst sprinting away from the other mobs << Rogue
	>> Stealth into the middle of the pack that spawns, then de-stealth, immediately aggroing all mobs at once. Keep refreshing leash on Mercutio whilst dashing away from the other mobs << Druid
    .goto Eastern Plaguelands,28.4,85.3
    .complete 5781,1 --Taelan's Hammer (1)
	.link https://www.twitch.tv/videos/850028806?t=02h34m49s >> CLICK HERE for reference << Mage/Warlock/Hunter/Druid/Rogue
step
	#sticky
	#label HameyaP
    .goto Eastern Plaguelands,27.3,85.4
	>>Loot the scroll on the ground inside of the crypt
    .accept 6024 >>Accept Hameya's Plea
step
	>>Go into the crypt. Kill Zaeldarr
    .goto Eastern Plaguelands,27.4,85.1
    .complete 6021,1 --Zaeldarr's Head (1)
step
	#requires HameyaP
	#label Memories
	.isQuestComplete 5781
    .goto Eastern Plaguelands,7.4,43.7
    .turnin 5781 >>Turn in Of Forgotten Memories
    .accept 5845 >>Accept Of Lost Honor
step
	#completewith next
	>>These can be hard to find. Kill Ghouls and the Darrowshire Spirits will emerge from the corpses. Talk to them to free their spirit.
    .goto Eastern Plaguelands,61.04,66.91,90,0
    .goto Eastern Plaguelands,39.02,52.71,150,0
    .goto Eastern Plaguelands,77.11,48.00,0
    .goto Eastern Plaguelands,67.85,41.13,0
    .goto Eastern Plaguelands,63.70,38.55,0
    .goto Eastern Plaguelands,77.11,48.00,0
    .goto Eastern Plaguelands,67.85,41.13,0
    .goto Eastern Plaguelands,63.70,38.55,0
    .complete 5211,1 --Darrowshire Spirits Freed (15)
	.unitscan Diseased Flayer,Gibbering Ghoul
step

    .goto Eastern Plaguelands,65.28,24.77,90,0
    .goto Eastern Plaguelands,64.58,21.56,90,0
    .goto Eastern Plaguelands,69.19,22.04,40,0
    .goto Eastern Plaguelands,69.7,18.6
	>>You should be able to avoid all the mobs en route up the mountain. Run past them all then run up the mountains to the east
	>>Kill Infiltrator Hameya. Loot him for his key
    .complete 6024,1 --Hameya's Key (1)
step
	>>Kill Ghouls and the Darrowshire Spirits will emerge from the corpses. Talk to them to free their spirit.
    .goto Eastern Plaguelands,77.11,48.00,90,0
    .goto Eastern Plaguelands,67.85,41.13,90,0
    .goto Eastern Plaguelands,63.70,38.55,90,0
    .goto Eastern Plaguelands,77.11,48.00,0
    .goto Eastern Plaguelands,67.85,41.13,0
    .goto Eastern Plaguelands,63.70,38.55,0
    .goto Eastern Plaguelands,61.04,66.91,0
    .goto Eastern Plaguelands,39.02,52.71
    .complete 5211,1 --Darrowshire Spirits Freed (15)
	.unitscan Diseased Flayer,Gibbering Ghoul
step
	.isQuestTurnedIn 5781
	>>Loot the banner underwater
    .goto Eastern Plaguelands,71.3,33.9
    .complete 5845,1 --Symbol of Lost Honor (1)
step
    .goto Eastern Plaguelands,81.5,59.9
    .turnin 5211 >>Turn in Defenders of Darrowshire
step
    .goto Eastern Plaguelands,79.6,63.9
    .turnin 6021 >>Turn in Zaeldarr the Outcast
step << !Mage
    .goto Eastern Plaguelands,80.2,57.1
    .fly Undercity >>Fly to Undercity
step << Mage
	.zone Undercity >> Teleport to Undercity
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
step << Paladin
    .goto Undercity,58.0,90.3
	.trainer >> Go and train your class spells
step
	>>Buy cloth from the AH. Buy 3 stacks of each for now. This is optional. If you can't get the cloth skip this step.
    .goto Undercity,71.8,29.0
    .turnin 7813 >> Turn in A Donation of Wool
    .turnin 7814 >> Turn in A Donation of Silk
    .turnin 7817 >> Turn in A Donation of Mageweave
    .turnin 7818 >> Turn in A Donation of Runecloth
	#softcore
step
    .goto Undercity,69.7,43.7
    .turnin 5023 >>Turn in Better Late Than Never
    .accept 5049 >>Accept The Jeremiah Blues
step
	>>Under the stairs
    .goto Undercity,67.4,44.4
    .turnin 5049 >>Turn in The Jeremiah Blues
    .accept 5050 >>Accept Good Luck Charm
step
    .goto Undercity,48.8,71.5
    .turnin 3568 >>Turn in Seeping Corruption
    .accept 3569 >>Accept Seeping Corruption
	>>Turn in at the Tauren nearby
    .turnin 3569 >>Turn in Seeping Corruption
    .turnin 3570 >>Turn in Seeping Corruption
step
    .goto Undercity,55.0,76.6
    .turnin 3542 >>Turn in Delivery to Andron Gant
step
    .goto Undercity,54.9,75.8
    .accept 3564 >>Accept Andron's Payment to Jediga
step
	>>Travel to the Royal Quarter
   .goto Undercity,51.88,64.49,30,0
    .goto Undercity,57.3,91.3
    .accept 5961 >>Accept The Champion of the Banshee Queen
step
    .goto Undercity,55.22,90.88
    +Go to the edge of the main platform and perform a Logout Skip by positioning your character until it looks like they're floating, then logging out and back in.
    .link https://www.youtube.com/watch?v=jj85AXyF1XE >> Open this tab when running to the turn in. CLICK HERE for an example
    >>If you can't do this, just run out of Undercity normally
step
    .goto Tirisfal Glades,61.85,66.59,60 >> Exit Undercity
step
    .goto Tirisfal Glades,83.3,69.2
    .turnin 964 >>Turn in Skeletal Fragments
step
    .goto Tirisfal Glades,83.0,72.0
    .turnin 5234 >>Turn in Return to the Bulwark
    .accept 5235 >>Accept Target: Gahrron's Withering
step
    .goto Tirisfal Glades,83.3,72.3
    .turnin 5901 >>Turn in A Plague Upon Thee
    .accept 5902 >>Accept A Plague Upon Thee
step
	>>Top floor of the building
    .goto Western Plaguelands,38.4,54.1
    .turnin 5050 >>Turn in Good Luck Charm
    .accept 5051 >>Accept Two Halves Become One
step
    .goto Western Plaguelands,38.0,54.7
	>>Find a Jabbering Ghoul. Kill him and loot the Good Luck Charm
    .complete 5051,1 --Good Luck Charm (1)
	.unitscan Jabbering Ghoul
step
	>>Top floor of the building
    .goto Western Plaguelands,38.4,54.1
    .turnin 5051 >>Turn in Two Halves Become One
step
	>>Talk to Marlene inside the house
    .goto Western Plaguelands,48.9,78.4
    .turnin 5152 >>Turn in Auntie Marlene
    .accept 5153 >>Accept A Strange Historian
step
	>>Click the gravestone. Loot it for the ring
    .goto Western Plaguelands,49.69,76.75
    .complete 5153,1 --Joseph's Wedding Ring (1)
step
	>>Go to the top floor of the Inn. Talk to Chromie
    .goto Western Plaguelands,39.4,66.8
    .turnin 4972 >>Turn in Counting Out Time
    .turnin 5153 >>Turn in A Strange Historian
    .accept 5154 >>Accept The Annals of Darrowshire
step
	>> Enter the town hall. Be very careful to not aggro the mobs outside when entering inside
	>> Look for a real book on the ground. Loot it. 
	>> The correct book will be WHITE only on the pages when you hover over it. Not half gray/half white.
	>> You may need to loot some fake books to spawn real ones if you can't find any (as they share spawns)
    .goto Western Plaguelands,43.4,69.6
    .complete 5154,1 --Annals of Darrowshire (1)
	.link https://i.imgur.com/B2HDb6K.png >> CLICK HERE for visual example
step
	>>Go to the top floor of the Inn. Talk to Chromie
    .goto Western Plaguelands,39.5,66.8
    .turnin 5154 >>Turn in The Annals of Darrowshire
    .accept 5210 >>Accept Brother Carlin
step
	>>Run back to the farm with the dead Tauren
    .goto Western Plaguelands,53.6,64.7
    .turnin 4985 >>Turn in The Wildlife Suffers Too
    .accept 4987 >>Accept Glyphed Oaken Branch
step
    >>Kill Cauldron Lord Soulwraith. Loot him for the key
    .goto Western Plaguelands,62.80,58.76
    .complete 5235,1 --Gahrron's Withering Cauldron Key (1)
step
    .goto Western Plaguelands,62.5,58.6
    .turnin 5235 >>Turn in Target: Gahrron's Withering
    .accept 5236 >>Accept Return to the Bulwark
step
	>>Click the crate. Place the Termite Barrel. Click the Termite Barrel
    .goto Western Plaguelands,48.4,32.0
    .turnin 5902 >>Turn in A Plague Upon Thee
    .accept 6390 >>Accept A Plague Upon Thee
step
    .goto Western Plaguelands,47.94,21.43,60,0
    .goto Western Plaguelands,43.31,17.34,50,0
    .goto Western Plaguelands,45.6,18.6
	>>Run into Hearthglen past the mobs. Follow the arrow to reset them once you're inside Hearthglen
	>>Run up to the top of the tower. Be careful as the Paladins outside can heal. You can try running past them/Crowd controlling them and going to the top, but be mindful that mobs have no Y axis range (they can hit you from the bottom of the tower)
    .complete 6025,1 --Overlook Hearthglen from a high vantage point (1)
step
	>>Travel out of Hearthglen back to Kirsta
    .goto Western Plaguelands,51.9,28.1
    .turnin 6025 >>Turn in Unfinished Business
step
	>>Travel back to The Bulwark
    .goto Tirisfal Glades,83.0,71.9
    .turnin 5236 >>Turn in Return to the Bulwark
step
    .goto Tirisfal Glades,83.2,72.3
    .turnin 6390 >>Turn in A Plague Upon Thee
step
    .goto Tirisfal Glades,83.1,68.9
    .turnin 5238 >>Turn in Mission Accomplished!
step
	>>Ride back to Tirion
    .goto Eastern Plaguelands,7.5,43.6
    .turnin 5845 >>Turn in Of Lost Honor
    .accept 5846 >>Accept Of Love and Family
step
	>>Swim to Caer Darrow << !Shaman
	>>Waterwalk to Caer Darrow if you have the Reagents. Otherwise, swim << Shaman
    .goto Western Plaguelands,65.7,75.3
    .turnin 5846 >>Turn in Of Love and Family
    .accept 5848 >>Accept Of Love and Family
step
    .goto Eastern Plaguelands,26.6,74.7
    .turnin 5961 >>Turn in The Champion of the Banshee Queen
step
	>>Click on the mound of dirt outside behind the crypt
    .goto Eastern Plaguelands,28.1,86.1
    .turnin 6024 >>Turn in Hameya's Plea
step
	>>Run back to Light's Hope Chapel
    .goto Eastern Plaguelands,81.5,59.7
    .turnin 5210 >>Turn in Brother Carlin
step
    .hs >> Hearth to Everlook
]])

local events = {"PLAYER_XP_UPDATE","QUEST_LOG_UPDATE"}
local IsQuestFlaggedCompleted = RXP_.IsQuestTurnedIn
local IsQuestComplete = RXP_.IsQuestComplete
local IsOnQuest = C_QuestLog.IsOnQuest
local group = RXPGuides["RestedXP Horde 50-60"]

function group.xpto60(self,...)
	
    if type(self) == "string" then
        local element = {}
        local text = ...
        element.icon = RXP_.icons.xp
        element.event = events
        if not text or text == "" then
            element.text = ""
            element.rawtext = element.text
        else
            text = text.."\n"
            element.text = text
            element.rawtext = text
        end
        return element
    end

    local event = ...
    local element = self.element
    local step = element.step
    if self.button and step and step.sticky then
        self.button:Disable()
        self.button:Hide()
    end
    if not element.step.active then
		element.questXP = nil
		return 
	end
    
    local xpMod = 1
    local eliteMod = 1
	--1.90980392157?
    
    if RXPCData and RXPCData.SoM then
        xpMod = 1.4
        eliteMod = 1.7
    end

    local questXP = element.questXP
	if event == "QUEST_LOG_UPDATE" or not element.questXP then
        questXP = 0
		if IsOnQuest(6844) then --Moonglade chain
			questXP = questXP + (3000 + 7550 + 3000)*xpMod
            questXP = floor(questXP)
		elseif IsQuestFlaggedCompleted(6844) then
			if not IsQuestFlaggedCompleted(6845) then
				questXP = questXP + 7550*xpMod
                questXP = floor(questXP)
			end
			if not IsQuestFlaggedCompleted(1185) then
				questXP = questXP + 3000*xpMod
                questXP = floor(questXP)
			end
		end
		
		if IsQuestComplete(4504) then --super sticky
			questXP = questXP + 5450*xpMod
            questXP = floor(questXP)
		end
		
		if IsQuestComplete(4809) then --chillwind horns
			questXP = questXP + 5450*xpMod
            questXP = floor(questXP)
		end
		
		if IsQuestComplete(4507) then --pawn captures queen
			questXP = questXP + (5450 + 550  + 8150)*xpMod
            questXP = floor(questXP)
		elseif IsQuestFlaggedCompleted(4507) then
			if IsOnQuest(4509) then
				questXP = questXP + (550 + 8150)*xpMod
                questXP = floor(questXP)
			elseif not IsQuestFlaggedCompleted(4511) and IsQuestFlaggedCompleted(4509) then
				questXP = questXP + 8150*xpMod
                questXP = floor(questXP)
			end
		end

		if IsQuestComplete(3962) then --It's dangerous to go alone
			questXP = questXP + 7300*eliteMod
            questXP = floor(questXP)
		end

		if IsQuestComplete(5163) then --Are we there yeti?
			questXP = questXP + 7750*xpMod
            questXP = floor(questXP)
		end

		if IsQuestComplete(5527) then --A Reliquary of Purity
			questXP = questXP + 6600*xpMod
            questXP = floor(questXP)
		end

		if IsQuestComplete(4721) then--Wild Guardians
			questXP = questXP + 6400*xpMod
            questXP = floor(questXP)
		end
		
		
		questXP = questXP - 50*(xpMod - 1)
	end
	
	local missingXP = UnitXPMax("player") - UnitXP("player") - questXP
    local level = UnitLevel('player')
    if level == 58 then
        missingXP = missingXP + 209800
    end
    
	if missingXP <= 0 and level == 59 then
        return group.next(self) or RXP_.SetElementComplete(self,true)
	end
    
    if event == "PLAYER_XP_UPDATE" or questXP ~= element.questXP then
        if questXP > 0 then
            local qXP = RXP_.FormatNumber(questXP)
            element.text = string.format("%sYou have %s XP worth of quest turn ins outside Silithus\nXP needed: %s + %s",element.rawtext,qXP,RXP_.FormatNumber(missingXP),qXP)
        else
            element.text = string.format("%sXP needed: %s",element.rawtext,RXP_.FormatNumber(missingXP))
        end
        RXP_.UpdateStepText(self)
    end
    
    element.questXP = questXP
    
end

RXPGuides.RegisterGuide("RestedXP Horde 50-60",[[
#classic
<< Horde

#name 59-59 Winterspring/Silithus I
#next 59-60 Winterspring/Silithus II

step
    .goto Winterspring,61.60,38.60
    .accept 4809 >> Accept Chillwind Horns
step
    .goto Winterspring,60.90,37.70
    .accept 977 >> Accept Are We There, Yeti?
step
    #completewith next
    .goto Winterspring,67.19,35.81,0
     >> Kill Furbolgs at the village. west Skip this step if the village is too crowded
    .complete 8464,1
    .complete 8464,2
    .complete 8464,3
step
    .goto Winterspring,69.62,38.31
     >> Kill High Chief Winterfall. Kill his Shaman bodyguard, run, then kill Winterfall if needed
	>> Be careful, as Winterfall does cast Frost Shock
    .complete 5121,1
     >> Loot the Crudely-written Log from Winterfall. Accept the quest
	.collect 12842,1,5123
    .accept 5123 >> Accept The Final Piece
step
    .goto Winterspring,67.19,35.81
     >> Kill Furbolgs at the village. Skip this step if the village is too crowded
    .complete 8464,1
    .complete 8464,2
    .complete 8464,3
step
    .goto Winterspring,67.66,41.70,50,0
    .goto Winterspring,70.00,41.88
     >> Go into the cave. Kill Yeti Patriarchs and Matriachs. Loot them for the Pristine Yeti Horn
    .complete 977,1
step << Shaman
	.hs >> Hearth to Everlook
>> Buy food/water if needed
step
    .goto Winterspring,60.90,37.70
    .turnin 977 >> Turn in Are We There, Yeti?
    .accept 5163 >> Accept Are We There, Yeti?
step
    .goto Winterspring,61.50,38.60
     >> Use the Mechanical Yeti on Legacki
    .complete 5163,1
step
    .goto Winterspring,65.10,21.10
     >> Kill Moontouched Owlbeasts in the area. Be careful as they cast Moonfire and Rejuvenation
    .complete 4741,1
step
     #completewith next
    .deathskip >> Death skip to Everlook
    #softcore
step
	>>Travel back to Donova
    .goto Winterspring,31.30,45.20
    .turnin 5121 >> Turn in High Chief Winterfall
    .turnin 5123 >> Turn in The Final Piece
    .accept 5128 >> Accept Words of the High Chief
step
    .goto Felwood,68.30,6.07
    .turnin 8464 >> Turn in Winterfall Activity
    .isQuestComplete 8464
step << !Druid
     #completewith next
    .goto Winterspring,27.40,33.64,40,0
    .goto Winterspring,25.70,31.93,40,0
    .goto Winterspring,25.35,31.36,40,0
    .goto Winterspring,26.36,28.04,40,0
    .goto Winterspring,26.61,24.49,40,0
    .goto Winterspring,26.59,24.17
    .zone Moonglade >> Enter the furbolg tunnel and take the north exit into Moonglade
step << Druid
    .zone Moonglade >> Teleport to Moonglade
step
    .goto Moonglade,51.70,45.00
    .turnin 1123 >> Turn in Rabine Saturna
    .accept 1124 >> Accept Wasteland
step
    .goto Moonglade,51.68,45.09
     >> Finish the dialogue with Rabine. Skip this step if the Dire Maul dialogue is not available
    .accept 5527 >> Accept A Reliquary of Purity
    .skipgossip 
step
    .goto Moonglade,32.10,66.60
	.fp Moonglade >> Get the Moonglade Flight Path << !Druid
    .fly Felwood>> Fly to Felwood
step
    .goto Felwood,34.70,52.80
    .turnin 4741 >> Turn in Wild Guardians
    .accept 4721 >> Accept Wild Guardians
step << !Rogue !Warrior
    .goto Winterspring,13.90,96.10
    .turnin 5242 >> Turn in A Final Blow
step << !Rogue !Warrior
    .goto Winterspring,14.00,96.00
    .turnin 5385 >> Turn in The Remains of Trey Lightforge
step
    .goto Winterspring,13.90,95.80
    .turnin 5128 >> Turn in Words of the High Chief
step
    #softcore
    .goto Winterspring,14.00,95.60
    .turnin 4084 >> Turn in Silver Heart
    .accept 4005 >> Accept Aquementas
step
     #completewith next
    .hs >> Hearth back to Winterspring, then fly to Azshara
>> Buy food/water if needed
step
     #completewith next
    .goto Ashenvale,62.70,39.80
     .zone Ashenvale >>If your Hearthstone is on cooldown, head to Splintertree Post
step
    .fly Azshara>> Fly to Azshara
step
    .goto Azshara,22.50,51.40
    .turnin 3564 >> Turn in Andron's Payment to Jediga
step << !Mage
    .goto Azshara,22.00,49.70
    .fly Thunder Bluff>> Fly to Thunder Bluff
step << Mage
	.zone Thunder Bluff >> Teleport to Thunder Bluff
step
    .goto Thunder Bluff,43.3,42.8
	>>Buy 3 stacks of each cloth on the AH if you weren't able to earlier.
    .turnin 7820 >> Turn in A Donation of Wool
    .turnin 7821 >> Turn in A Donation of Silk
    .turnin 7822 >> Turn in A Donation of Mageweave
    .turnin 7823 >> Turn in A Donation of Runecloth
	#softcore
step
    .goto Thunder Bluff,75.80,31.20
    .turnin 4987 >> Turn in Glyphed Oaken Branch
step
    .goto Thunder Bluff,46.8,50.0
    .fly Tanaris>> Fly to Tanaris
step
    .goto Tanaris,51.10,26.90
     >> Use the Mechanical Yeti on Sprinkle
    .complete 5163,2
step
    .goto Tanaris,50.90,27.00
    .accept 4507 >> Accept Pawn Captures Queen
step
    #softcore
    .goto Tanaris,70.40,49.90
     >>Head to the pirate area and use the supplies provided at the stone circle to summon Aquementas
    .complete 4005,1
step
    .goto Tanaris,51.6,25.5
    .fly Un'Goro Crater>> Fly to Un'Goro Crater
step
    #softcore
    .goto Tanaris,11.60,3.40
    .turnin 4005 >> Turn in Aquementas
    .accept 3961 >> Accept Linken's Adventure
step
    #softcore
    .goto Tanaris,13.10,6.40
    .turnin 3961 >> Turn in Linken's Adventure
    .accept 3962 >> Accept It's Dangerous to Go Alone
step
    .goto Un'Goro Crater,43.70,9.40
     >> Use the Mechanical Yeti on Quixxil
    .complete 5163,3
step
    #softcore
    #completewith next
    .goto Un'Goro Crater,50.28,49.98
     >> Click on the chest at the back of the cave
    .complete 3962,2
step
    #softcore
    .goto Un'Goro Crater,50.28,49.98,0
     >> Equip the Silver Totem of Aquementas on your off-hand 
    >>Use it to weaken Blazerunner at the top of the volcano
    .complete 3962,1
step
    #softcore
    .goto Un'Goro Crater,50.28,49.98
     >> Click on the chest at the back of the cave
    .complete 3962,2
step
	.goto Un'Goro Crater,44.6,81.6
	>>Go deep into the silithid hive and use the quest item provided at the silithid crystal to summon the Hive Queen
	>>Proceed with caution, clear the room before summoning the queen, this quest is hard, you have to deal with 3 waves of 3 mobs and you only have 1 attempt on this quest (so it's optional). Remember to kill mobs outside the room so you can eat/drink after
	*At the last wave, you can ignore the 2 adds, kill the queen and loot the quest item
	>>Be careful, as this quest is VERY Hard if you haven't done it before
	.complete 4507,1
	.link https://www.twitch.tv/videos/680871694?t=00h49m29s >> CLICK HERE if you need a reference
step
	#completewith next
    .goto Silithus,88.09,23.43,70,0
    .goto Un'Goro Crater,30.15,10.41,70,0
    .goto Un'Goro Crater,25.14,12.71,70,0
    .goto Silithus,81.87,18.93
    .zone Silithus >> Head to Silithus
step
    .goto Silithus,81.87,18.93
    .turnin 1124 >> Turn in Wasteland
    .accept 1125 >> Accept The Spirits of Southwind
step
     #completewith end
    .xpto60 >> Skip to the part 2 of the guide once you have enough xp to ding 60
step
    #phase 4
    .goto Silithus,51.80,38.60
     >> Talk to the goblin on the 2nd floor of the inn
    .accept 8277 >> Accept Deadly Desert Venom
step << Mage/Hunter/Warlock
    #phase 4
    .goto Silithus,51.30,38.20
     >> Click on the wanted poster
    .accept 8283 >> Accept Wanted - Deathclasp, Terror of the Sands
step
    #phase 4
     #completewith next
    .goto Silithus,51.15,38.29
    .turnin 8275 >> Turn in Taking Back Silithus
    .accept 8280 >> Accept Securing the Supply Lines
step
    #phase 4
    .goto Silithus,49.60,37.30
    .accept 8284 >> Accept The Twilight Mystery
step
    #phase 4
    .goto Silithus,49.20,34.20
    .accept 8304 >> Accept Dearest Natalia
step
    #phase 4
    .goto Silithus,48.60,37.80
    .accept 8318 >> Accept Secret Communication
step
    #phase 4
    #completewith s1
    .goto Silithus,67.81,31.57,0
    .goto Silithus,55.74,23.17,0
	>>Kill Dredge Stalkers in the area
    .complete 8280,1
step
    #phase 4
    #sticky
    #completewith s1
    .goto Silithus,67.81,31.57,0
    .goto Silithus,55.74,23.17,0
     >>Kill Stonelash Scorpids and Sand Skitterers. Loot them for their Stingers and Fangs
    .complete 8277,1
    .complete 8277,2
step
	#completewith Spirits
	>> Kill the mobs that spawn from the spirits. Loot them for a low chance at Brann's Letter. Accept the quest from it
	.collect 20461,1,8308 --Brann
	.accept 8308
step
    #completewith next
    .goto Silithus,63.53,49.90,0
     >> Kill Spirits around the village. Be careful every time a spirit dies it has a high chance of spawning a bug
	>> Be careful as the Druids can Moonfire and Rejuvenate
    .complete 1125,1
    .complete 1125,2
step
    .goto Silithus,63.22,55.35
     >> Click on the small urn inside the lodge
    .complete 5527,1
    .isOnQuest 5527
step
	#label Spirits
    .goto Silithus,63.53,49.90
     >> Kill Spirits around the village. Be careful every time a spirit dies it has a high chance of spawning a bug
	>> Be careful as the Druids can Moonfire and Rejuvenate
    .complete 1125,1
    .complete 1125,2
step
    .goto Silithus,81.87,18.93
    .turnin 1125 >> Turn in The Spirits of Southwind
    .accept 1126 >> Accept Hive in the Tower
step
    .goto Silithus,60.22,52.55
     >> Clear the 3 bugs that spawn at the base of the tower 
    >>Click on the object at the top of the tower 
    >>Kill the 2 ambushers that spawn after clicking it
    .complete 1126,1
step
    .goto Silithus,81.87,18.93
    .turnin 1126 >> Turn in Hive in the Tower
    .accept 6844 >> Accept Umber, Archivist
step
    #phase 4
    #label s1
    .goto Silithus,23.50,13.70
     >>Loot the small glowing tablets on the ground
    .complete 8284,1
step
    #phase 4
	#completewith next
    .goto Silithus,67.68,41.98
	>>Kill Dredge Stalkers in the area
    .complete 8280,1
step
    #phase 4
    .goto Silithus,67.68,41.98
     >>Kill Stonelash Scorpids and Sand Skitterers. Loot them for their Stingers and Fangs
    .complete 8277,1
    .complete 8277,2
    .complete 8280,1
step
    #phase 4
    .goto Silithus,67.68,41.98
	>>Kill Dredge Stalkers in the area
    .complete 8280,1
step
    #phase 4
    .goto Silithus,49.70,37.30
    .turnin 8284 >> Turn in The Twilight Mystery
    .accept 8285 >> Accept The Deserter
step
    #phase 4
    .goto Silithus,51.10,38.20
    .turnin 8280 >> Turn in Securing the Supply Lines
    .accept 8281 >> Accept Stepping Up Security
step
    #phase 4
    .goto Silithus,51.70,38.50
    .turnin 8277 >> Turn in Deadly Desert Venom
    .accept 8278 >> Accept Noggle's Last Hope
step
    #phase 4
    #label s3
    #sticky
    .goto Silithus,39.31,53.33,0
     >> Kill Dredge Crusher (x20)
    .complete 8281,1
step
    #phase 4
    #completewith Deserter
    .goto Silithus,62.52,64.00,0
    .goto Silithus,50.73,55.99,0
	>>Kill Stonelash Flayers and Pincers. Loot them for their Stingers
	>>Kill Rock Stalkers. Loot them for their Fangs
    .complete 8278,1
    .complete 8278,2
    .complete 8278,3
step
    #phase 4
    .goto Silithus,41.30,88.50
     >> Speak with Rutgar
    .complete 8304,2
    .goto Silithus,40.80,88.80
     >> Speak with Frankal
    .complete 8304,1
step << Mage/Hunter/Warlock
    #phase 4
    .goto Silithus,45.00,92.20
     >> Kill Deathclasp. Loot him for his Pincer
	>> Be careful as this quest is HARD. skip it if needed
	>> do NOT let him get in melee range, as he has an 8-second stun
    .complete 8283,1
step
    #phase 4
	#label Deserter
    .goto Silithus,67.20,69.70
    .turnin 8285 >> Turn in The Deserter
    .accept 8279 >> Accept The Twilight Lexicon
step
	#phase 4
    .goto Silithus,62.52,64.00,90,0
    .goto Silithus,50.73,55.99
	>>Kill Stonelash Pincers. Loot them for their Stingers
    .complete 8278,2
step
	#phase 4
    .goto Silithus,43.98,84.22,90,0
    .goto Silithus,36.25,67.89
	>>Kill Stonelash Flayers. Loot them for their Stingers
	>>Kill Rock Stalkers. Loot them for their Fangs
    .complete 8278,1
    .complete 8278,3
step
    #phase 4
    .goto Silithus,51.10,38.20
    .turnin 8281 >> Turn in Stepping Up Security
step
    #phase 4
    .goto Silithus,51.70,38.50
    .turnin 8278 >> Turn in Noggle's Last Hope
    .accept 8282 >> Accept Noggle's Lost Satchel
step
    #phase 4
    .goto Silithus,49.20,34.30
    .turnin 8304 >> Turn in Dearest Natalia
step << Mage/Warlock/Hunter
    #phase 4
    .goto Silithus,50.80,33.60
    .turnin 8283 >> Turn in Wanted - Deathclasp, Terror of the Sands
step
    #sticky
    #phase 4
    #sticky
    #label texts
     >> Kill twilight cultists. Loot them for Encrypted Twilight Texts
    .collect 20404,10,8323,1
step
    #phase 4
    .goto Silithus,40.86,42.22
     >> Kill Twilight Keeper Havunth 
    >>He patrols the twilight camp next to Cenarion Hold
    .complete 8279,3
    .unitscan TWILIGHT KEEPER HAVUNTH
step
    #phase 4
    .goto Silithus,26.34,36.62
     >> Kill Twilight Keeper Mayna 
    >>She patrols the twilight camp directly west of Cenarion Hold
    .complete 8279,1
    .unitscan TWILIGHT KEEPER MAYNA
step
    #phase 4
    .goto Silithus,16.08,86.37
     >> Kill Twilight Keeper Exeter 
    >>He is at the back of the southwestern twilight camp
    .complete 8279,2
step
    #phase 4
    #requires texts
    .goto Silithus,44.50,91.40
     >> Collect Noggle's Satchel. Be careful not to aggro Deathclasp
    .complete 8282,1
step
    #phase 4
    .goto Silithus,67.20,69.80
    .turnin 8279 >> Turn in The Twilight Lexicon
    .accept 8287 >> Accept A Terrible Purpose
    .accept 8323 >> Accept True Believers
    .turnin 8323 >> Turn in True Believers
step
    #phase 4
    .goto Silithus,51.70,38.50
     >> Head to Cenarion Hold
    .turnin 8282 >> Turn in Noggle's Lost Satchel
step
    #phase 4
    .goto Silithus,49.20,34.20
    .turnin 8287 >> Turn in A Terrible Purpose
step
    #phase 4
    .goto Silithus,48.70,37.50
     >> Kill cultists. Loot them for Encrypted Twilight Texts
    .complete 8318,1
step
    #phase 4
    .goto Silithus,48.60,37.70
    .turnin 8318 >> Turn in Secret Communication
step
    #softcore
    #completewith next
    .goto Silithus,50.59,34.45
    .fly Un'Goro >> Fly to Un'Goro Crater
step
    #softcore
    .goto Un'Goro Crater,44.65,8.09
    .turnin 3962 >> Turn in It's Dangerous to Go Alone
step
    #completewith end
    .goto Un'Goro Crater,45.23,5.82
    .fly Tanaris>> Fly to Tanaris
step
    #label end
    .goto Tanaris,50.88,26.96
    .turnin 4507 >> Turn in Pawn Captures Queen
    .accept 4509 >> Accept Calm Before the Storm
]])

RXPGuides.RegisterGuide("RestedXP Horde 50-60",[[
#classic
<< Horde
#name 59-60 Winterspring/Silithus II

step
     #completewith next
     .fly Un'Goro>> Fly to Un'Goro Crater
step
    .goto Un'Goro Crater,44.65,8.09
    .turnin 3962 >> Turn in It's Dangerous to Go Alone
step
     #completewith tanaris
    .fly Tanaris>> Fly to Tanaris
step
    .goto Tanaris,50.88,26.96
    .turnin 4507 >> Turn in Pawn Captures Queen
    .accept 4509 >> Accept Calm Before the Storm
step
    #label tanaris
    .goto Tanaris,51.56,26.75
    .turnin 4504 >> Turn in Super Sticky
step
    .hs >> Hearth to Everlook
>> Buy food/water if needed
step
    .goto Winterspring,60.88,37.61
    .turnin 5163 >> Turn in Are We There, Yeti?
step
    #completewith moonglade
    #label ding60
    .xpto60 >> Stop questing in Winterspring once you have enough XP
step
    #label owlbeasts
    #completewith ding60
    .goto Winterspring,65.20,20.30
    .complete 4721,1
    .unitscan Berserk Owlbeast
step
    #requires owlbeasts
     #completewith ding60
     #label horns
    >>Kill chimeras just north of Everlook
    .complete 4809,1
    .goto Winterspring,60.4,23.2
    .turnin 4809 >> Turn in Chillwind Horns
    .goto Winterspring,61.6,38.6
step
    #label moonglade
    #requires horns
    .goto Winterspring,60.47,36.30
    .fly Moonglade>> Fly to Moonglade
step
    .goto Moonglade,44.88,35.60
    .turnin 6844 >> Turn in Umber, Archivist
    .accept 6845 >> Accept Uncovering Past Secrets
--    .isQuestTurnedIn 1126
step
    .goto Moonglade,51.68,45.09
    .turnin 6845 >> Turn in Uncovering Past Secrets
--    .isQuestTurnedIn 1126
step
    .goto Moonglade,51.68,45.09
    .turnin 5527 >> Turn in A Reliquary of Purity
    .isQuestComplete 5527
step
    .goto Moonglade,44.87,35.62
    .accept 1185 >> Accept Under the Chitin Was...
    .turnin 1185 >> Turn in Under the Chitin Was...
    .isQuestTurnedIn 1126
step
	.zone Felwood >> Run back through the cave to Felwood
step
    .goto Felwood,62.9,8.4
    .xpto60 >> Grind Furbolgs in northern felwood until you have enough XP to ding 60
step
    .goto Moonglade,32.2,66.6
    .fly Bloodvenom >> Fly to Felwood
step
    .goto Winterspring,0.50,72.30
    .turnin 4721 >> Turn in Wild Guardians
--    .isQuestComplete 4721
step << !Mage
    .goto Felwood,34.44,53.97
    .fly Orgrimmar>> Fly to Orgrimmar
step << Mage
    .zone Orgrimmar>> Teleport to Orgrimmar
step
    .goto Orgrimmar,56.50,46.40
    .turnin 4509 >> Turn in Calm Before the Storm
    .accept 4511 >> Accept Calm Before the Storm
step
    .goto Orgrimmar,49.70,69.30
    .turnin 4511 >> Turn in Calm Before the Storm
]])