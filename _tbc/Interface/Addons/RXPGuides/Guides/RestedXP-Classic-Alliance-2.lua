
RXPGuides.RegisterGuide("RestedXP Alliance 40-50",[[
#classic
<< Alliance !Hunter
#name 39-40 Dustwallow/Desolace
#next 40-41 Badlands

step
    #completewith next
    .goto Wetlands,5.14,63.40,20 >> Go to the end of the dock. Wait here for the boat
step
    .goto Wetlands,4.79,63.67
    .zone Dustwallow Marsh >> Take the boat to Theramore
step <<  Warlock
    .goto Dustwallow Marsh,67.47,51.30
    .fly Ratchet>> Fly to Ratchet
step <<  Warlock
    #label orb1
     #completewith next
    .goto The Barrens,62.50,35.44
    .turnin 4965 >> Turn in Knowledge of the Orb of Orahil
    .accept 1799 >> Accept Fragments of the Orb of Orahil
step <<  Warlock
    #completewith orb1
    .goto The Barrens,62.50,35.44
    .turnin 4968 >> Turn in Knowledge of the Orb of Orahil
    .accept 1799 >> Accept Fragments of the Orb of Orahil
step <<  Warlock
    #label fs1
     #completewith next
    .goto The Barrens,62.62,35.49
    .turnin 4488 >> Turn in Summon Felsteed
step <<  Warlock
    #completewith fs1
    .goto The Barrens,62.62,35.49
    .turnin 4487 >> Turn in Summon Felsteed
step <<  Warlock
    .goto The Barrens,62.62,35.49
    .accept 4490 >> Accept Summon Felsteed
    .turnin 4490 >> Turn in Summon Felsteed
step <<  Warlock
    .goto The Barrens,62.64,35.30
    .accept 4962 >> Accept Shard of a Felhound
step <<  Warlock
    .goto The Barrens,63.08,37.16
    .fly Theramore>> Fly to Theramore
step
    .goto Dustwallow Marsh,68.21,48.62
    .accept 1286 >> Accept The Deserters
step
    #completewith start
    .goto Dustwallow Marsh,67.6,48.8
     >> Do the First Aid quest
    >> (Requires 225 First Aid)
	>> If you don't have 225 First Aid, skip this step
    .accept 6624 >> Accept Triage
    .turnin 6624 >> Turn in Triage
step
     #completewith next
    .goto The Barrens,69.87,77.51
    .turnin 1260 >> Turn in Morgan Stern
step
    #label start
    .goto The Barrens,69.87,77.51
    .accept 1204 >> Accept Mudrock Soup and Bugs
step
	#completewith next
    .goto Dustwallow Marsh,64.89,42.25,90,0
    .goto Dustwallow Marsh,63.14,36.98,90,0
    .goto Dustwallow Marsh,61.02,19.41,90,0
    .goto Dustwallow Marsh,59.67,17.69,0
     >> Kill Turtles along the coast. Loot them for their Tongues
    .complete 1204,1
step
    .goto Dustwallow Marsh,57.98,15.88,90,0
    .goto Dustwallow Marsh,57.11,21.33,90,0
    .goto Dustwallow Marsh,54.22,14.94
    .goto Dustwallow Marsh,57.11,21.33,0
    .goto Dustwallow Marsh,57.98,15.88,0
    >>Kill Mirefin Murlocs. Loot them for their Heads
    .complete 1177,1
    .isOnQuest 1177
step
    .goto Dustwallow Marsh,59.67,17.69,90,0
    .goto Dustwallow Marsh,61.02,19.41,90,0
    .goto Dustwallow Marsh,63.14,36.98,90,0
    .goto Dustwallow Marsh,64.89,42.25
     >> Kill Turtles along the coast. Loot them for their Tongues
    .complete 1204,1
step
    .goto The Barrens,64.22,67.57
    .accept 1206 >> Accept Jarl Needs Eyes
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
    .goto The Barrens,59.79,63.03
     >> Start the escort quest
    .accept 1222 >> Accept Stinky's Escape
step
    .goto Dustwallow Marsh,48.76,24.49,0
     >> Escort Stinky. This quest is easy. Just follow him
     .complete 1222,1
step
    .goto The Barrens,64.22,67.57
    .turnin 1206 >> Turn in Jarl Needs Eyes
step
    #softcore
    .goto Dustwallow Marsh,45.2,24.6
    .turnin 1266 >> Turn in The Missing Diplomat
    .accept 1324 >> Accept The Missing Diplomat
>> You have to beat a level 35 mob while dealing with 2 adds, if you can't do it at this level, skip this step, you will have another opportunity to finish it 
    .isQuestTurnedIn 1264
step
    #hardcore
    .goto Dustwallow Marsh,45.2,24.6
    >> BE CAREFUL, THIS NEXT QUEST WILL FLAG YOU FOR PVP
    >> Skip this step if you have to
	>> You have to beat a level 35 mob while dealing with 2 adds
    .turnin 1266 >> Turn in The Missing Diplomat
    .accept 1324 >> Accept The Missing Diplomat
    .isQuestTurnedIn 1264
step
	>> You have to beat a level 35 mob while dealing with 2 adds
    .goto Dustwallow Marsh,45.2,24.6
	.complete 1324,1
    .isOnQuest 1324
step
    .goto Dustwallow Marsh,45.2,24.2
	>>After beating Private Hendel, wait a few seconds until Archmage Trevosh show up
    .turnin 1324 >> Turn in The Missing Diplomat
	.isQuestComplete 1324
step
	.goto Dustwallow Marsh,45.2,24.2
	>>Talk to Lady Jaina Proudmoore
    .turnin 1267 >> Turn in The Missing Diplomat
	.isQuestTurnedIn 1324
step
	.goto Dustwallow Marsh,35.0,38.2
    .turnin 1177 >> Turn in Hungry
    .isQuestComplete 1177
step
    .goto The Barrens,54.20,82.09
     >> Beat Balos Jacken inside the tower. Talk to him afterward
    .turnin 1286 >> Turn in The Deserters
    .accept 1287 >> Accept The Deserters
step
    .goto Dustwallow Marsh,54.10,56.50
     >> Loot the box on the ground near the crashed Zeppelin
    .complete 1187,1
step
    .goto The Barrens,69.87,77.51
    .turnin 1204 >> Turn in Mudrock Soup and Bugs
    .accept 1258 >> Accept ... and Bugs
    .turnin 1222 >> Turn in Stinky's Escape
step
    .goto The Barrens,70.84,79.14
    .turnin 1287 >> Turn in The Deserters
step
    .goto Dustwallow Marsh,67.47,51.30
    .fly Desolace >> Fly to Desolace
step
    .goto Desolace,66.27,6.55
    .home >> Set your Hearthstone to Desolace
step
    .goto Desolace,66.51,7.90
    .accept 261 >> Accept Down the Scarlet Path
step
    .goto Desolace,66.20,9.62
    .accept 1466 >> Accept Reagents for Reclaimers Inc.
step
    .goto Desolace,47.83,61.82
    .accept 6134 >> Accept Ghost-o-plasm Round Up
step
    .goto Desolace,36.21,79.24
    .turnin 1373 >> Turn in Ongeku
    .accept 1374 >> Accept Khan Jehn
step
    #sticky
    #label reagents
    .goto Desolace,51.72,83.79
	>>Kill Felhounds for their Brains, Succubus for their Wings, and Doomwarders for their Blood
    .complete 1466,1
    .complete 1466,2
    .complete 1466,3
step <<  Warlock
    .goto Desolace,53.4,76.6,0
     >> Kill Burning Blade Summoners. Loot them for the Infernal Orb
    .complete 1799,1
     >> Kill a Felhound while draining it with the Felhas Ruby
    .complete 4962,1
step
     #sticky
     #requires reagents
     #label scarletpath
    .goto Desolace,63.76,90.25
	>>Kill Undead Ravagers in the area
    .complete 261,1
step
    #requires reagents
    .goto Desolace,64.00,91.70
     >> At the Valley of Bones, use the Crate of Ghost Magnets in your inventory. Kill the Ghosts that spawn. Loot them for the Ghost-O-Plasm
    .complete 6134,1
step
    #requires scarletpath
    .goto Desolace,65.94,80.40
     >> Kill Khan Jhen. Loot him for his Head
    .complete 1374,1 --Khan Jhen
step
	#softcore
    .goto Desolace,47.83,61.82
    .turnin 6134 >> Turn in Ghost-o-plasm Round Up
step
    .goto Desolace,36.21,79.24
    .turnin 1374 >> Turn in Khan Jehn
step
	#hardcore
    .goto Desolace,47.83,61.82
    .turnin 6134 >> Turn in Ghost-o-plasm Round Up
step
    #softcore
    .goto Desolace,41.13,91.72
    .zone Feralas >> Head to Feralas
step
    #softcore
    #completewith end
    .goto Feralas,40.6,8.6
    >> Once you get to Feralas, walk along the mountains to the west to avoid aggroing mobs and then die near the stone obelisks
    .deathskip >> Die and respawn at the Spirit Healer in Feathermoon
step
    #softcore
    #label end
    .goto Feralas,30.2,43.3
    .fp Feathermoon>>Get the Feathermoon Flight Path
    .fly Tanaris>> Fly to Tanaris
step
    #hardcore
    #label end
	>>Run back to Nijel's Point
    .goto Desolace,64.66,10.53
    .fly Tanaris>> Fly to Tanaris
step
     #completewith next
    .zone Thousand Needles >> Run north to Shimmering Flats
step
    .goto Thousand Needles,78.06,77.12
    .accept 1106 >> Accept Martek the Exiled
step
    .goto Thousand Needles,77.78,77.26
    .turnin 1117 >> Turn in Rumors for Kravel
     >> Wait for the RP sequence to finish
    .accept 1118 >> Accept Back to Booty Bay
step
    .goto Thousand Needles,80.32,76.09
    .turnin 1187 >> Turn in Razzeric's Tweaking
    .accept 1188 >> Accept Safety First
step
    .hs >> Hearth back to Nijel's Point
	>> Buy food/water if needed
step
    .goto Desolace,66.51,7.90
     >> Skip the follow up
    .turnin 261 >> Turn in Down the Scarlet Path
step
    .goto Desolace,66.20,9.62
    .turnin 1466 >> Turn in Reagents for Reclaimers Inc.
    .accept 1467 >> Accept Reagents for Reclaimers Inc.
step << !Mage
    #softcore
    >> Use the website unstuck service to teleport to Stormwind
    >>OR 
    .zone Wetlands >>Fly to Theramore and take the boat to Menethil
     .zoneskip Stormwind City
step << !Mage
    #hardcore
    .goto Desolace,64.66,10.53
    .fly Theramore>>Fly to Theramore
step << !Mage
    #hardcore
    .zone Wetlands >> Take the boat to Wetlands
step << Mage
	.zone Stormwind City >> Teleport to Stormwind
]])

RXPGuides.RegisterGuide("RestedXP Alliance 40-50",[[
#classic
<< Alliance Hunter
#name 40-40 Dustwallow Marsh
#next 40-41 Badlands

step
    .goto Wetlands,10.70,60.90
    .home >> Set your Hearthstone to Wetlands
step
     #completewith next
    .goto Wetlands,4.79,63.67
    .zone Dustwallow Marsh >> Take the boat to Theramore
step
    .goto The Barrens,70.84,79.14
    .accept 1286 >> Accept The Deserters
step
    #completewith start
    .goto Dustwallow Marsh,67.6,48.8
     >> Do the First Aid quest
    >> (Requires 225 First Aid)
	>> If you don't have 225 First Aid, skip this step
    .accept 6624 >> Accept Triage
    .turnin 6624 >> Turn in Triage
step
     #completewith next
    .goto The Barrens,69.87,77.51
    .turnin 1260 >> Turn in Morgan Stern
step
    #label start
    .goto The Barrens,69.87,77.51
    .accept 1204 >> Accept Mudrock Soup and Bugs
step
	#completewith next
    .goto Dustwallow Marsh,64.89,42.25,90,0
    .goto Dustwallow Marsh,63.14,36.98,90,0
    .goto Dustwallow Marsh,61.02,19.41,90,0
    .goto Dustwallow Marsh,59.67,17.69,0
     >> Kill Turtles along the coast. Loot them for their Tongues
    .complete 1204,1
step
    .goto Dustwallow Marsh,57.98,15.88,90,0
    .goto Dustwallow Marsh,57.11,21.33,90,0
    .goto Dustwallow Marsh,54.22,14.94
    .goto Dustwallow Marsh,57.11,21.33,0
    .goto Dustwallow Marsh,57.98,15.88,0
    >>Kill Mirefin Murlocs. Loot them for their Heads
    .complete 1177,1
    .isOnQuest 1177
step
    .goto Dustwallow Marsh,59.67,17.69,90,0
    .goto Dustwallow Marsh,61.02,19.41,90,0
    .goto Dustwallow Marsh,63.14,36.98,90,0
    .goto Dustwallow Marsh,64.89,42.25
     >> Kill Turtles along the coast. Loot them for their Tongues
    .complete 1204,1
step
    .goto The Barrens,64.22,67.57
    .accept 1206 >> Accept Jarl Needs Eyes
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
    .goto The Barrens,59.79,63.03
     >> Start the escort quest
    .accept 1222 >> Accept Stinky's Escape
step
    .goto Dustwallow Marsh,48.76,24.49,0
     >> Escort Stinky. This quest is easy. Just follow him
     .complete 1222,1
step
    .goto The Barrens,64.22,67.57
    .turnin 1206 >> Turn in Jarl Needs Eyes
step
    #softcore
    .goto Dustwallow Marsh,45.2,24.6
    .turnin 1266 >> Turn in The Missing Diplomat
    .accept 1324 >> Accept The Missing Diplomat
    .isQuestTurnedIn 1264
step
    #hardcore
    .goto Dustwallow Marsh,45.2,24.6
    >> BE CAREFUL, THIS NEXT QUEST WILL FLAG YOU FOR PVP
	>> You have to beat a level 35 mob while dealing with 2 adds
    .turnin 1266 >> Turn in The Missing Diplomat
    .accept 1324 >> Accept The Missing Diplomat
    .isQuestTurnedIn 1264
step
	>> You have to beat a level 35 mob while dealing with 2 adds
    .goto Dustwallow Marsh,45.2,24.6
	.complete 1324,1
    .isOnQuest 1324
step
    .goto Dustwallow Marsh,45.2,24.2
	>>After beating Private Hendel, wait a few seconds until Archmage Trevosh show up
    .turnin 1324 >> Turn in The Missing Diplomat
	.isQuestComplete 1324
step
	.goto Dustwallow Marsh,45.2,24.2
	>>Talk to Lady Jaina Proudmoore
    .turnin 1267 >> Turn in The Missing Diplomat
	.isQuestTurnedIn 1324
step
	.goto Dustwallow Marsh,35.0,38.2
    .turnin 1177 >> Turn in Hungry
    .isOnQuest 1177
step
    #sticky
    .abandon 1177 >> Abandon Hungry
step
    .goto The Barrens,54.20,82.09
     >> Beat Balos Jacken
    .turnin 1286 >> Turn in The Deserters
    .accept 1287 >> Accept The Deserters
step
    .goto Dustwallow Marsh,54.10,56.50
     >> Loot the box on the ground near the crashed Zeppelin
    .complete 1187,1
step
	#softcore
     #completewith next
     >> Grind until your Hearthstone cooldown is <10min 
    .deathskip >>Die and respawn at the Spirit Healer
step
	#softcore
    .goto The Barrens,69.87,77.51
    .turnin 1204 >> Turn in Mudrock Soup and Bugs
    .accept 1258 >> Accept ... and Bugs
    .turnin 1222 >> Turn in Stinky's Escape
step
	#hardcore
	>>Grind your way back to Theramore
    .goto The Barrens,69.87,77.51
    .turnin 1204 >> Turn in Mudrock Soup and Bugs
    .accept 1258 >> Accept ... and Bugs
    .turnin 1222 >> Turn in Stinky's Escape
step << Hunter
    .goto Dustwallow Marsh,66.00,45.50
    .stable >> Stable your pet    
step
    .goto The Barrens,70.84,79.14
    .turnin 1287 >> Turn in The Deserters
step
    .goto Dustwallow Marsh,67.47,51.30
    .fly Gadgetzan >> Fly to Tanaris
step << Hunter
    .goto Tanaris,54.07,32.21
    .train 2976 >> Tame a level 40/41 scorpid near Gadgetzan and learn Claw 6
step << Hunter
    .goto Dustwallow Marsh,66.00,45.50
    .stable >> Abandon the scorpid, take your pet out of the stable 
step
    .goto Tanaris,50.98,22.87,60,0
    .goto Thousand Needles,78.14,77.12
     >> Run to Shimmering Flats
    .accept 1106 >> Accept Martek the Exiled
step << Hunter
    .goto Thousand Needles,78.14,77.12
    .turnin 1107 >> Turn in Encrusted Tail Fins
    .isQuestComplete 1107
step
    .goto Thousand Needles,77.78,77.26
    .turnin 1117 >> Turn in Rumors for Kravel
step
    .goto Thousand Needles,77.78,77.26
     >> Wait for the RP sequence to finish
    .accept 1118 >> Accept Back to Booty Bay
step
    .goto Thousand Needles,80.32,76.09
    .turnin 1187 >> Turn in Razzeric's Tweaking
    .accept 1188 >> Accept Safety First
step
    .hs >> Hearth to Menethil
	>> Buy food/water if needed
step
    #label end
    .goto Wetlands,9.49,59.70
    .fly Ironforge>> Fly to Ironforge
]])

RXPGuides.RegisterGuide("RestedXP Alliance 40-50",[[
#classic
<< Alliance

#name 40-41 Badlands
#next 41-43 STV/Swamp of Sorrows

step <<  Warlock
	#softcore
    #completewith next
    #label sw1
    .goto Stormwind City,74.00,30.23
     >> If you used the unstuck service to teleport to Stormwind, turn in the following quests: 
    .turnin 543 >> Turn in The Perenolde Tiara
    .turnin 542 >> Turn in Return to Milton
    >>Skip the Stormwind turn ins if you're coming from Wetlands into Ironforge
step << Warlock
	#softcore
    #completewith sw1
    >>If you're coming from Wetlands, abandon the following quests:
     .abandon 196 >> Abandon Raptor Mastery
    .abandon 193 >> Abandon Panther Mastery
step << Warlock
	#hardcore
    #label sw1
    >>Abandon the following quests:
     .abandon 196 >> Abandon Raptor Mastery
    .abandon 193 >> Abandon Panther Mastery
step << !Druid
	#hardcore
    .goto Ironforge,69.88,82.90 << Hunter
    .goto Ironforge,65.90,88.41 << Warrior
    .goto Ironforge,50.34,5.67 << Warlock
    .goto Ironforge,51.50,15.34 << Rogue
    .goto Ironforge,25.21,10.75 << Priest
    .goto Ironforge,27.17,8.57 << Mage
    .goto Ironforge,24.55,4.46 << Paladin
     .trainer >> Train your class spells
    .goto Ironforge,52.7,6.1 << Warlock
     .vendor >> Buy pet spellbooks for your Succubus. Buy voidwalker ones too if you have a lot of gold << Warlock
step
    #sticky
	#softcore
    .trainer >> Train your class skills in Stormwind or Ironforge 
    .train 15149 >>Train Growl rank 5 << Hunter
step
	#softcore
    #sticky
    .goto Stormwind City,57.02,72.97,0
    .goto Ironforge,35.90,60.17,0
    .bankdeposit 5862,5826,4502 >> Deposit the following items into your bank: 
    >>Seaforium Booster 
    >>Kravel's Scheme 
    >>Sample Elven Gem
step
	#softcore
    #sticky
    .goto Stormwind City,57.02,72.97,0
    .goto Ironforge,35.90,60.17,0
    .bankwithdraw 4611,3404,5827 >> Withdraw the following items from your bank: 
    >>9 Blue Pearls (If you have them)
    >>Buzzard Wings 
    >>Fizzle Brassbolts' Letter
step
	#sticky
	#label BankS1
	#hardcore
    .goto Ironforge,35.90,60.17
    .bankdeposit 5862,5826,4502 >> Deposit the following items into your bank: 
    >>Seaforium Booster 
    >>Kravel's Scheme 
    >>Sample Elven Gem
step
	#hardcore
    .goto Ironforge,35.90,60.17
    .bankwithdraw 4611,3404,5827 >> Withdraw the following items from your bank: 
    >>9 Blue Pearls (If you have them)
    >>Buzzard Wings 
    >>Fizzle Brassbolts' Letter
step
	#softcore
    #requires sw1 << Warlock
    .zone Ironforge >> Head to Ironforge
step
    #completewith start
    #softcore
    .goto Ironforge,25.75,75.42,0
    >>Try to find the following items on the Auction House:
    .collect 3829,1,713,1--Frost Oil
    .collect 4389,1,714,1--Gyrochronatom 
    >>-
    .collect 929,1,715,1--Healing Potion
    .collect 3823,1,715,1--Lesser Invisibility Potion
    >>-
    .collect 2868,1,716,1--Patterned Bronze Bracers Recipe
    >>(This step is optional)
step
	#softcore
    .goto Ironforge,67.91,17.50
    .turnin 1467 >> Turn in Reagents for Reclaimers Inc.
    .isOnQuest 1467
step
	#hardcore
	#requires BankS1
    .goto Ironforge,67.91,17.50
    .turnin 1467 >> Turn in Reagents for Reclaimers Inc.
    .isOnQuest 1467
step
    .goto Ironforge,74.64,11.74
    .accept 707 >> Accept Ironband Wants You!
    .turnin 554 >> Turn in Stormpike's Deciphering
step
    .goto Ironforge,50.82,5.61
    .turnin 653 >> Turn in Myzrael's Allies
    .accept 687 >> Accept Theldurin the Lost
    .isQuestTurnedIn 652
step
    #label start
    .goto Ironforge,55.5,47.8
    .fly Loch Modan>> Fly to Loch Modan
step
    .goto Loch Modan,35.5,48.4
    .home >> Set your Hearthstone to Loch Modan
step
    .goto Loch Modan,37.06,49.37
    .accept 2500 >> Accept Badlands Reagent Run
step
    .goto Loch Modan,65.93,65.62
    .turnin 707 >> Turn in Ironband Wants You!
    .accept 738 >> Accept Find Agmond
step
    #completewith StudyR
     >> Kill Wolves/Vultures as you quest through Badlands. Loot them for Fangs and Gizzards
    .complete 2500,1
    .complete 2500,2
step
    #completewith StudyR
    >>Kill Vultures for 4 Buzzard Wings
    .collect 3404,4,703,1
step <<  Warlock
    .goto Badlands,53.02,33.94
     >> Click on the crumpled map next to the tent
    .accept 720 >> Accept A Sign of Hope
step <<  Warlock
    .goto Badlands,53.42,43.39
    .turnin 720 >> Turn in A Sign of Hope
step
    .goto Badlands,53.42,43.39
    .accept 719 >> Accept A Dwarf and His Tools
    .accept 718 >> Accept Mirages
step << !Warlock
    .goto Badlands,53.02,33.94
     >> Click on the crumpled map next to the tent
    .accept 720 >> Accept A Sign of Hope
step
    .goto Badlands,41.26,27.79
     >> Kill Shadowforge Dwarves. Loot them for the Pick
    .complete 719,1
step
    .goto Badlands,66.92,23.45
     >> Loot the crate in the Ogre camp
    .complete 718,1
step
    .goto Badlands,53.80,43.30
    .turnin 718 >> Turn in Mirages
    .accept 733 >> Accept Scrounging
    .turnin 719 >> Turn in A Dwarf and His Tools
    .turnin 720 >> Turn in A Sign of Hope
step
    .goto Thousand Needles,61.27,95.34
    .turnin 1106 >> Turn in Martek the Exiled
    .accept 1108 >> Accept Indurium
step
    #sticky
    #label pearldiving
    >>Skip this step and abandon the quest if you don't have 9 blue pearls
    .accept 705 >> Accept Pearl Diving
    .turnin 705 >> Turn in Pearl Diving
step
    #sticky
    #requires pearldiving
    .abandon 705 >> Abandon Pearl Diving
step
    .goto Badlands,42.38,52.92
    .accept 703 >> Accept Barbecued Buzzard Wings
step
	.isQuestComplete 703
    .goto Badlands,42.38,52.92
    .turnin 703 >> Turn in Barbecued Buzzard Wings
step
    .goto Badlands,61.93,54.26
    .accept 732 >> Accept Tremors of the Earth
step
    #sticky
    #label boss
     >> Look for Boss Tho'grun as you quest
    .complete 732,1
    .unitscan BOSS THO'GRUN
step
    .goto Badlands,50.89,62.40
    .turnin 738 >> Turn in Find Agmond
    .accept 739 >> Accept Murdaloc
step
    #label troggs
    #sticky
    .goto Badlands,50.40,68.29
     >> Kill Troggs
    .complete 739,1
    .complete 739,2
    .complete 1108,1
step
    .goto Badlands,51.38,76.87
    .turnin 687 >> Turn in Theldurin the Lost
    .accept 692 >> Accept The Lost Fragments
    .isQuestTurnedIn 652
step
    .goto Badlands,54.66,83.91
     >> Kill earth elementals
    .complete 692,1
    .complete 692,2
    .complete 692,3
    .isOnQuest 692
step
    .goto Badlands,51.38,76.87
    .turnin 692 >> Turn in The Lost Fragments
    .isOnQuest 692
step
    .goto Thousand Needles,61.27,95.34
     >> Speak to the goblin nearby and clear your bags while you wait for the RP sequence
    .turnin 1108 >> Turn in Indurium
    .accept 1137 >> Accept News for Fizzle
step
    .goto Badlands,25.94,44.86
    .accept 710 >> Accept Study of the Elements: Rock
step
    .goto Badlands,16.14,40.26
     >> Kill earth elementals
    .complete 710,1
step
    .goto Badlands,25.94,44.86
    .turnin 710 >> Turn in Study of the Elements: Rock
    .accept 711 >> Accept Study of the Elements: Rock
step
    .goto Badlands,14.70,35.30
    .complete 711,1
step
	#label StudyR
    .goto Badlands,25.94,44.86
    .turnin 711 >> Turn in Study of the Elements: Rock
    .accept 712 >> Accept Study of the Elements: Rock
step
	#sticky
	#label Wings
    .goto Badlands,16.12,60.47
     >> Kill Vultures. Loot them for Wings
    .complete 703,1
step
	#sticky
	#completewith next
    .goto Badlands,16.12,60.47
     >> Kill Vultures. Loot them for Gizzards
    .complete 2500,1
step
   .goto Badlands,54.80,52.75
     >> Finish off killing Wolves and looting them for Fangs
    .complete 2500,2
step
    .goto Badlands,16.12,60.47
     >> Kill Vultures. Loot them for Gizzards
    .complete 2500,1
step
	#requires Wings
    .goto Badlands,3.98,79.89
	>>Kill Greater Rock Elementals. Loot them for their Bracers
    .complete 712,1
step
    .goto Badlands,11.15,75.64
     >> Kill Ogres. Loot them for Scrap Metal
    .complete 733,1
step
    .goto Badlands,25.94,44.86
    .turnin 712 >> Turn in Study of the Elements: Rock
step
    .goto Badlands,42.38,52.92
    .turnin 703 >> Turn in Barbecued Buzzard Wings
step
    .goto Badlands,53.80,43.30
    .turnin 733 >> Turn in Scrounging
step
    #requires boss
    .goto Badlands,61.93,54.26
    .turnin 732 >> Turn in Tremors of the Earth
step
    #softcore
    .goto Badlands,3.62,61.88,50,0
    .goto Searing Gorge,72.34,55.47
	.zone Searing Gorge >> Ride to Searing Gorge
step
    #softcore
    #completewith next
    .goto Searing Gorge,63.40,60.83
    .deathskip >> Once you get to Searing Gorge, die and respawn at Thorium Point 
step
    #softcore
    .goto Searing Gorge,37.94,30.74
    .fp Searing Gorge>>Get the Searing Gorge Flight Path
    .fly Loch Modan>>Fly to Loch Modan << Warlock
step <<  !Warlock
    .hs >> Hearth back to Loch Modan
	>> Buy food/water if needed
step << Warlock
    #hardcore
    #completewith next
    .zone Loch Modan >> Run Back to Loch Modan
step << Warlock
    #hardcore
    .goto Loch Modan,65.93,65.62
    .turnin 739 >> Turn in Murdaloc
step
    .goto Loch Modan,37.06,49.37
    .turnin 2500 >> Turn in Badlands Reagent Run
step
    .goto Loch Modan,65.93,65.62
    .turnin 739 >> Turn in Murdaloc
step
	#softcore
    #completewith next
    .goto Loch Modan,68.47,62.82
    .deathskip >> Die on purpose and respawn at Thelsamar
step
    .goto Loch Modan,33.94,50.95
    .fly Ironforge>> Fly to Ironforge
]])

RXPGuides.RegisterGuide("RestedXP Alliance 40-50",[[
#classic
<< Alliance

#name 41-43 STV/Swamp of Sorrows
#next 43-44 Tanaris << !Warlock
#next 43-44 Tanaris/Dustwallow << Warlock

step
    #sticky
    .bankwithdraw 3684,3660,5826,4502 >> Withdraw the following items from your bank: 
    >>Perenolde Tiara 
    >>Tomes of Alterac 
    >>Kravel's Scheme 
    >>Sample Elven Gem
--P Bank coords?
step
    #completewith start
    .trainer >> Visit your class trainer
    >>Make sure your pet has Frost Resistance maxed out << Hunter
step
     #sticky
	    .goto Ironforge,75.32,50.92,40,0
    .zone Stormwind City >> Take the tram to Stormwind
step
    .goto Stormwind City,74.00,30.23
    .turnin 543 >> Turn in The Perenolde Tiara
step
    .goto Stormwind City,74.16,7.49
    .turnin 542 >> Turn in Return to Milton
step
    .goto Stormwind City,41.52,64.38
     >> Run upstairs and turn in Mazen's Behest
    .accept 1363 >> Accept Mazen's Behest
    .turnin 1363 >> Turn in Mazen's Behest
    .accept 1364 >> Accept Mazen's Behest
step
    .goto Stormwind City,37.52,81.65
    .accept 1477 >> Accept Vital Supplies
step <<  Warlock
    .goto Stormwind City,53.57,64.79
    .home >> Set your Hearthstone to Stormwind
step << Warlock
    #completewith next
    .goto Stormwind City,66.20,62.40
    .fly Westfall>> Fly to Westfall
step << Warlock
    .goto Stranglethorn Vale,35.55,10.54
     >> Run to Stranglethorn Vale
    .accept 193 >> Accept Panther Mastery
    .accept 196 >> Accept Raptor Mastery
step << Warlock
    .hs >> Hearth to Stormwind
	>> Buy food/water if needed
    .zoneskip Stormwind City
step
    #label start
    .goto Stormwind City,66.20,62.40
    .fly Booty Bay>> Fly to Booty Bay
step
    .goto Stranglethorn Vale,26.94,77.20
    .turnin 1116 >> Turn in Dream Dust in the Swamp
step
    .goto Stranglethorn Vale,26.99,77.12
    .accept 209 >> Accept Skullsplitter Tusks
step
    .goto Stranglethorn Vale,27.17,77.00
    .turnin 669 >> Turn in Sunken Treasure
step
    .goto Stranglethorn Vale,27.28,77.52
    >>Head to the middle floor
    .turnin 603 >> Turn in Ansirem's Key
    .accept 610 >> Accept "Pretty Boy" Duncan
step
    .goto Stranglethorn Vale,27.11,77.21
    .accept 600 >> Accept Venture Company Mining
    .accept 621 >> Accept Zanzil's Secret
step
    .goto Stranglethorn Vale,27.11,77.21
    .turnin 1118 >> Turn in Back to Booty Bay
step
    .goto Stranglethorn Vale,27.04,77.31
    .home >> Set your Hearthstone to Booty Bay
step
    .goto Stranglethorn Vale,26.75,76.38
    .accept 617 >> Accept Akiris by the Bundle
step
    .goto Stranglethorn Vale,27.78,77.06
    .accept 606 >> Accept Scaring Shaky
step
    .goto Stranglethorn Vale,28.29,77.59
    .accept 628 >> Accept Excelsior
step
    .goto Stranglethorn Vale,28.09,76.21
    .accept 595 >> Accept The Bloodsail Buccaneers
step
    .goto Stranglethorn Vale,27.38,69.41
    >>Click on the map on top of a barrel
    .turnin 595 >> Turn in The Bloodsail Buccaneers
    .accept 597 >> Accept The Bloodsail Buccaneers
     >> Kill the named pirate
    .complete 610,1
step
    .goto Stranglethorn Vale,28.09,76.21
    .turnin 597 >> Turn in The Bloodsail Buccaneers
    .accept 599 >> Accept The Bloodsail Buccaneers
step
    .goto Stranglethorn Vale,27.28,77.52
    .turnin 610 >> Turn in "Pretty Boy" Duncan
    .accept 611 >> Accept The Curse of the Tides
step
    .goto Stranglethorn Vale,26.92,77.34
    .accept 587 >> Accept Up to Snuff
step
    .goto Stranglethorn Vale,27.17,77.00
    .turnin 599 >> Turn in The Bloodsail Buccaneers
step
    .goto Stranglethorn Vale,28.59,75.89
    .accept 576 >> Accept Keep An Eye Out
step
    .goto Stranglethorn Vale,33.58,66.24
     >> Kill gorillas
    >>Save Gorilla Fangs for later
    .complete 606,1
step
    .goto Stranglethorn Vale,31.45,42.46
     >> Do Raptor Mastery
    .complete 196,1
step
    .goto Stranglethorn Vale,28.73,44.84
     >> Kill Tethis if you have the associated quest, skip this step otherwise
    .complete 197,1
    .isOnQuest 197
step
    .goto Stranglethorn Vale,41.65,43.69
     >> Kill goblins
    .complete 600,1
step
    .goto Stranglethorn Vale,45.70,32.62
     >> Kill doctors/mystics 
    .complete 205,1
    >>Gather Skullsplitter Tusks
    .complete 209,1
step
    .goto Stranglethorn Vale,47.2,28.0,35,0
    .goto Stranglethorn Vale,49.8,24.6,35,0
    .goto Stranglethorn Vale,48.4,19.2,35,0
     .goto Stranglethorn Vale,47.2,28.0,0
    .goto Stranglethorn Vale,49.8,24.6,0
    .goto Stranglethorn Vale,48.4,19.2,0
     >> Look for Bhag'thera with eagle eye << Hunter
    >>Bhag'thera can spawn north or west of the ogre mound
    .complete 193,1
    .unitscan BHAG'THERA
step
    .goto Stranglethorn Vale,49.30,4.98
     >> Go deep into the cave north
    .complete 202,1
    .complete 202,2
    .complete 202,3
    >>You have to solo an elite at the end, skip it if you have to
step
    .goto Stranglethorn Vale,37.83,3.56
    .turnin 205 >> Turn in Troll Witchery
step
    .goto Stranglethorn Vale,38.04,3.01
    .turnin 202 >> Turn in Colonel Kurzen
    .isQuestComplete 202
step
    .goto Stranglethorn Vale,35.55,10.54
    .turnin 193 >> Turn in Panther Mastery
    .turnin 196 >> Turn in Raptor Mastery
    .accept 197 >> Accept Raptor Mastery
step
    .goto Stranglethorn Vale,29.57,23.88
     >> Look for an elite croc along the northwestern coast
    .complete 628,1
step
    .goto Stranglethorn Vale,24.96,23.59
     >> Use Catelyn's Blade at the altar underwater 
    >>Kill Gazban
    .complete 611,1
step
    .hs >> Hearth back to Booty Bay
	>> Buy food/water if needed
step
    .goto Stranglethorn Vale,27.11,77.21
    .turnin 600 >> Turn in Venture Company Mining
step
    .goto Stranglethorn Vale,26.99,77.12
    .turnin 209 >> Turn in Skullsplitter Tusks
step
    .goto Stranglethorn Vale,27.17,77.00
    .accept 604 >> Accept The Bloodsail Buccaneers
    .turnin 611 >> Turn in The Curse of the Tides
step
    #completewith start2
    .bankwithdraw 6065 >> Withdraw Khadgar's Essays on Dimensional Convergence if you have it
step
    #completewith start2
     + Withdraw Green Hills pages from your bank and try to buy the missing pages from the AH
    >>Ch.1: 1,4,6,8 
    >>Ch.2: 10,11,14,16 
    >>Ch.3: 18,20,21,24 
    >>Ch.4: 25,26,27
step
    .goto Stranglethorn Vale,26.89,73.59
    .turnin 606 >> Turn in Scaring Shaky
    .accept 607 >> Accept Return to MacKinley
step
    .goto Stranglethorn Vale,27.78,77.06
    .turnin 607 >> Turn in Return to MacKinley
    .accept 609 >> Accept Voodoo Dues
step
    #label start2
    .goto Stranglethorn Vale,28.29,77.59
    .turnin 628 >> Turn in Excelsior
step
    #sticky
     >> Kill every pirate you see
    .complete 587,1
step
    .goto Stranglethorn Vale,27.27,62.11
     >> Kill nagas around this area
    .complete 617,1
step
    #label bloodsail1
    #sticky
    .goto Stranglethorn Vale,29.98,89.34,0
     >> Kill pirates
    .complete 587,1
    .complete 576,1
step
    .goto Stranglethorn Vale,27.14,83.04
    .complete 604,1
     >> Look for the charts/orders next to the tents or next to the small rowboat
    .complete 604,2
    .complete 604,3
step
    #requires bloodsail1
    .goto Stranglethorn Vale,29.91,89.38,0
    .goto Stranglethorn Vale,33.6,88.3,0
    .goto Stranglethorn Vale,30.6,92.7,0
    >>Look for a small parchment that can spawn inside one of the 3 ships 
     >> Use eagle eye to find it first << Hunter
    >>Right click the parchment and accept the quest from the item in your bag
    .collect 4056,1,624
    .accept 624 >> Accept Cortello's Riddle
step
    #sticky
    #label zanzil
    .goto Stranglethorn Vale,39.99,58.24,0
    .goto Stranglethorn Vale,34.92,51.84,0
    >>Kill Zanzil mobs
    .complete 621,1
step
    .goto Stranglethorn Vale,39.99,58.24
     >> Kill Chucky "Ten Thumbs"
    .complete 609,3
step
    .goto Stranglethorn Vale,34.92,51.84
     >> Kill Jon-Jon the Crow 
    >> Kill Maury \"Club Foot\" Wilkins 
    .complete 609,1
    .complete 609,2
step
    #requires zanzil
    .goto Stranglethorn Vale,28.73,44.84
    >>Tethis spawns in a random location around this area
    .complete 197,1
step
    .goto Stranglethorn Vale,35.65,10.80
    .turnin 197 >> Turn in Raptor Mastery
    .accept 208 >> Accept Big Game Hunter
step
    .goto Stranglethorn Vale,38.20,35.57
     >> Kill King Bangalash
    >>Kite it towards the quest giver, keep hitting the adds to prevent them from resetting
    .complete 208,1
    >>This quest can be hard to solo, skip it if you have to
step
    .goto Stranglethorn Vale,35.65,10.80
    .turnin 208 >> Turn in Big Game Hunter
    .isQuestComplete 208
step
    #completewith next
    >>Turn in the journal pages at the Nesinguary camp
    .turnin 338 >> Turn in The Green Hills of Stranglethorn
    >>Skip this step if you don't have all the chapters
step
    .goto Duskwood,75.77,46.15
     >> Run to Duskwood
    .turnin 1477 >> Turn in Vital Supplies
    .accept 1395 >> Accept Supplies for Nethergarde
step
	#completewith next
    .goto Duskwood,88.47,41.00,50 >> Travel to Deadwind Pass
step
    .goto Deadwind Pass,48.02,34.60,60,0
    .goto Deadwind Pass,58.43,41.51,50 >> Travel to Swamp of Sorrows
    >>Nethergarde supplies has a 1hr timer, be mindful of that
step
    .goto Swamp of Sorrows,22.87,48.18
    >>Click on the small scroll under the brdige
    .turnin 624 >> Turn in Cortello's Riddle
    .isOnQuest 624
step
    .goto Swamp of Sorrows,22.87,48.18
    >>Click on the small scroll under the brdige
    .accept 625 >> Accept Cortello's Riddle
    .isQuestTurnedIn 624
step
    #completewith mazens
     >> Kill all swamp creatures you see
    .complete 1364,1
step
    .goto Swamp of Sorrows,26.74,59.82
    .accept 1398 >> Accept Driftwood
step
     #completewith next
    .goto Swamp of Sorrows,76.47,5.11
     >> Loot 8 pieces of driftwood along the coast
    .complete 1398,1
step
    .goto Swamp of Sorrows,76.47,5.11
     >> Kill crabs along the coast
    .complete 1258,1
step
    #label mazens
    .goto Swamp of Sorrows,91.91,69.08
     >> Finish off Driftwood
    .complete 1398,1
step
    .goto Swamp of Sorrows,14.97,37.31
     >> Finish off Mazen's Behest
    .complete 1364,1
step
    .goto Swamp of Sorrows,26.74,59.82
    .turnin 1398 >> Turn in Driftwood
    .accept 1425 >> Accept Deliver the Shipment
step
     #completewith next
    .goto Blasted Lands,51.98,7.43
    .zone Blasted Lands >> Run to Blasted Lands
step
    .goto Swamp of Sorrows,54.37,93.08
    .turnin 1395 >> Turn in Supplies for Nethergarde
step
    .goto Swamp of Sorrows,54.37,93.08
    .turnin 1425 >> Turn in Deliver the Shipment
step
    .goto Swamp of Sorrows,56.02,89.84
    .turnin 1364 >> Turn in Mazen's Behest
    .isQuestComplete 1364
step
    #sticky
    .goto Blasted Lands,65.54,24.34
    .abandon 1364 >> Abandon Mazen's Behest
step
    #completewith next
    .goto Blasted Lands,65.54,24.34
    .fp Blasted Lands>> Get the Blasted Lands Flight Path
step
    .goto Blasted Lands,65.54,24.34
    .fly Booty Bay>> Fly to Booty Bay
step
    .goto Stranglethorn Vale,26.92,77.34
    .turnin 587 >> Turn in Up to Snuff
    .accept 2864 >> Accept Tran'rek
step
    .goto Stranglethorn Vale,27.17,77.00
    .turnin 604 >> Turn in The Bloodsail Buccaneers
step
    .goto Stranglethorn Vale,27.11,77.21
    .turnin 621 >> Turn in Zanzil's Secret
    .accept 1119 >> Accept Zanzil's Mixture and a Fool's Stout
    .accept 580 >> Accept Whiskey Slim's Lost Grog
step
    .goto Stranglethorn Vale,26.75,76.38
    .turnin 617 >> Turn in Akiris by the Bundle
    .accept 623 >> Accept Akiris by the Bundle
step
    #sticky
    .bankdeposit 2799,4098 >> Deposit the following items:
    >>Gorilla Fangs 
    >>Carfully folded note
step
    #sticky
    .bankwithdraw 5862 >> Withdraw the following items: 
    >>Seaforium Booster
step
    .goto Stranglethorn Vale,27.78,77.06
    .accept 2872 >> Accept Stoley's Debt
step
    .goto Stranglethorn Vale,27.78,77.06
    .turnin 609 >> Turn in Voodoo Dues
step
    .goto Stranglethorn Vale,28.59,75.89
    .turnin 576 >> Turn in Keep An Eye Out
step
    .goto Stranglethorn Vale,25.8,73.1
    .zone The Barrens >> Take the Boat to Ratchet
]])

RXPGuides.RegisterGuide("RestedXP Alliance 40-50",[[
#classic
<< Alliance !Warlock

#name 43-44 Tanaris
#next 44-48 Feralas

step
    .goto The Barrens,63.08,37.16
    .fly Theramore>> Fly to Theramore
step
    .goto The Barrens,71.16,81.53
    .turnin 623 >> Turn in Akiris by the Bundle
step
    .goto Dustwallow Marsh,66.33,45.46
    .turnin 1258 >> Turn in ... and Bugs
step
    .goto Dustwallow Marsh,66.59,45.22
    .home >> Set your Hearthstone to Theramore
step
    #completewith next
    .goto Dustwallow Marsh,55.62,50.11,60 >> Swim to the hill west
step
    .goto Dustwallow Marsh,31.1,66.1
    .turnin 625 >> Turn in Cortello's Riddle
    .accept 626 >> Accept Cortello's Riddle
    .isQuestTurnedIn 624
step
     #completewith next
    .hs >> Hearth back to Theramore
	>> Buy food/water if needed
    .isOnQuest 626
step
     #completewith next
    .goto Dustwallow Marsh,67.47,51.30
    .fly Tanaris>> Fly to Tanaris
step
    .goto Tanaris,52.46,28.51
    .accept 1690 >> Accept Wastewander Justice
    .accept 1707 >> Accept Water Pouch Bounty
step << Hunter
    .goto Tanaris,52.25,28.00
    .stable >> Stable your pet
step
    .goto Tanaris,52.35,26.90
    .accept 3022 >> Accept Handle With Care
step
    .goto Tanaris,51.56,26.75
    .turnin 2864 >> Turn in Tran'rek
step
    #label pet1
    .goto Tanaris,50.96,27.24
    .turnin 1188 >> Turn in Safety First
    .accept 1189 >> Accept Safety First
step << Hunter
    #completewith st2
    .train 23111 >> Tame a Starving Blisterpaw just outside Gadgetzan and try to learn Dash 2 while you run through Thousand Needles
step
    .goto Thousand Needles,78.06,77.12
     >> Run to Shimmering Flats
    .turnin 1137 >> Turn in News for Fizzle
step
    .goto Thousand Needles,77.78,77.26
    .turnin 1119 >> Turn in Zanzil's Mixture and a Fool's Stout
step
    .goto Thousand Needles,77.78,77.26
    .accept 1120 >> Accept Get the Gnomes Drunk
step
    .goto Thousand Needles,77.56,76.94
    .turnin 1120 >> Turn in Get the Gnomes Drunk
step
    .goto Thousand Needles,77.78,77.26
    .accept 1122 >> Accept Report Back to Fizzlebub
step
    .goto Thousand Needles,80.32,76.09
    .turnin 1189 >> Turn in Safety First
step
    .goto Thousand Needles,80.17,75.88
    .accept 1190 >> Accept Keeping Pace
step
    #completewith next
    .goto Tanaris,54.00,7.63,15,0
    .goto Tanaris,54.00,7.63,0
    .turnin 1191 >> Talk with Zamek to create a diversion
step
    .goto Tanaris,52.36,7.88
    >>Click on the unguarded plans inside the metal hut
    .turnin 1190 >> Turn in Keeping Pace
    .accept 1194 >> Accept Rizzle's Schematics
step
    .goto Thousand Needles,80.17,75.88
    .turnin 1194 >> Turn in Rizzle's Schematics
step
     #sticky
    .destroy 5866 >> Throw away the Sample of Indurium Ore
step
    .goto Tanaris,50.50,18.52
    .zone Tanaris >> Run back to Tanaris
step <<  Hunter
    #label st2
    .stable >> Withdraw your main pet from the stable
step
    #completewith end
     >> Kill vultures as you quest through tanaris, don't go out of your way to finish this quest
    .complete 1452,1
step
    #sticky
    #label wastewander
    .goto Tanaris,60.4,24.6,0
    .goto Tanaris,63.6,31.0,0
    .complete 1690,1
    .complete 1690,2
    .complete 1707,1
step
    .goto Tanaris,66.55,22.26
    .accept 8365 >> Accept Pirate Hats Ahoy!
step
    .goto Tanaris,66.98,22.35
    .accept 3520 >> Accept Screecher Spirits
step
    .goto Tanaris,67.05,23.89
    .accept 8366 >> Accept Southsea Shakedown
    .turnin 2872 >> Turn in Stoley's Debt
    .accept 2873 >> Accept Stoley's Shipment
step <<  Hunter
    #requires wastewander
    .goto Tanaris,52.70,45.92
    .accept 3161 >> Accept Gahz'ridian
step <<  Hunter
    .goto Tanaris,47.31,65.14
    >>Use the helmet provided to find the small patches of sand around the ogre ruins southwest
    .complete 3161,1
step <<  Hunter
    .goto Tanaris,52.70,45.92
    .turnin 3161 >> Turn in Gahz'ridian
step
    #label end
    #requires wastewander
    .goto Tanaris,52.46,28.51
    .turnin 1690 >> Turn in Wastewander Justice
    .turnin 1707 >> Turn in Water Pouch Bounty
step
    .goto Tanaris,52.4,28.8
    .bankdeposit 5807,6257 >> Deposit the following items in your bank: 
    >>Fool's Stout Report 
    >>Roc Gizzard
]])

RXPGuides.RegisterGuide("RestedXP Alliance 40-50",[[
#classic
<< Alliance Warlock

#name 43-44 Tanaris/Dustwallow
#next 44-48 Feralas

step
    .goto Tanaris,51.01,29.35
    .fly Theramore>> Fly to Theramore
step
    .goto The Barrens,71.16,81.53
    .turnin 623 >> Turn in Akiris by the Bundle
step
    .goto Dustwallow Marsh,66.33,45.46
    .turnin 1258 >> Turn in ... and Bugs
step
    .goto Dustwallow Marsh,66.59,45.22
    .home >> Set your Hearthstone to Theramore
step
    .goto Dustwallow Marsh,67.47,51.30
    .fly >> Fly to Tanaris
step
    .goto Tanaris,52.46,28.51
    .accept 1690 >> Accept Wastewander Justice
    .accept 1707 >> Accept Water Pouch Bounty
step
    .goto Tanaris,52.35,26.90
    .accept 3022 >> Accept Handle With Care
step
    .goto Tanaris,51.56,26.75
    .turnin 2864 >> Turn in Tran'rek
step
    .goto Tanaris,50.96,27.24
    .turnin 1188 >> Turn in Safety First
    .accept 1189 >> Accept Safety First
step
    #sticky
    #completewith tend
     >> Kill vultures as you quest through tanaris, don't go out of your way to finish this quest
    .complete 1452,1
step
    #label wastewander
    #sticky
    .goto Tanaris,63.46,30.59,0
    .goto Tanaris,60.4,24.6,0
    .complete 1690,1
    .complete 1690,2
    .complete 1707,1
step
    .goto Tanaris,66.55,22.26
    .accept 8365 >> Accept Pirate Hats Ahoy!
step
    .goto Tanaris,66.98,22.35
    .accept 3520 >> Accept Screecher Spirits
step
    .goto Tanaris,67.05,23.89
    .accept 8366 >> Accept Southsea Shakedown
    .turnin 2872 >> Turn in Stoley's Debt
    .accept 2873 >> Accept Stoley's Shipment
step
    #label tend
    #requires wastewander
    .goto Tanaris,52.46,28.51
    .turnin 1690 >> Turn in Wastewander Justice
    .turnin 1707 >> Turn in Water Pouch Bounty
step
    .goto Thousand Needles,78.06,77.12
     >> Run to Shimmering Flats
    .turnin 1137 >> Turn in News for Fizzle
step
    .goto Thousand Needles,77.78,77.26
    .turnin 1119 >> Turn in Zanzil's Mixture and a Fool's Stout
step
    .goto Thousand Needles,77.78,77.26
    .accept 1120 >> Accept Get the Gnomes Drunk
step
    .goto Thousand Needles,77.56,76.94
    .turnin 1120 >> Turn in Get the Gnomes Drunk
step
    .goto Thousand Needles,77.78,77.26
    .accept 1122 >> Accept Report Back to Fizzlebub
step
    .goto Thousand Needles,80.32,76.09
    .turnin 1189 >> Turn in Safety First
step
    .goto Thousand Needles,80.17,75.88
    .accept 1190 >> Accept Keeping Pace
step
    #completewith next
    .goto Tanaris,54.00,7.63,15,0
    .goto Tanaris,54.00,7.63,0
    .turnin 1191 >> Talk with Zamek to create a diversion
step
    .goto Tanaris,52.36,7.88
    >>Click on the unguarded plans inside the metal hut
    .turnin 1190 >> Turn in Keeping Pace
    .accept 1194 >> Accept Rizzle's Schematics
step
    .goto Thousand Needles,80.17,75.88
    .turnin 1194 >> Turn in Rizzle's Schematics
step
     #sticky
    .destroy 5866 >> Throw away the Sample of Indurium Ore
step
    .hs >> Hearth back to Theramore
	>> Buy food/water if needed
step
    #completewith next
    .goto Dustwallow Marsh,55.62,50.11,45 >> Swim to the hill west
step
    .goto Thousand Needles,67.26,2.21
    .turnin 1799 >> Turn in Fragments of the Orb of Orahil
    .accept 4961 >> Accept Cleansing of the Orb of Orahil
step
     >> Kill the elite demon that spawns, just keep him feared to avoid getting hit
    .complete 4961,1
step
    .goto Thousand Needles,67.26,2.21
    .turnin 4961 >> Turn in Cleansing of the Orb of Orahil
    .accept 4976 >> Accept Returning the Cleansed Orb
step
    .goto Dustwallow Marsh,31.10,66.14
    .turnin 625 >> Turn in Cortello's Riddle
    .accept 626 >> Accept Cortello's Riddle
    .isQuestTurnedIn 624
step
	#softcore
     #completewith next
    .deathskip >> Die and respawn at the Spirit Healer in Theramore
step
    .goto Dustwallow Marsh,67.47,51.30
    .fly Ratchet>> Fly to Ratchet
step
    .goto The Barrens,62.50,35.44
    .turnin 4962 >> Turn in Shard of a Felhound
    .turnin 4976 >> Turn in Returning the Cleansed Orb
step
    .goto The Barrens,62.50,35.44
     >> Wait for the RP sequence to end
    .accept 4964 >> Accept The Completed Orb of Dar'Orahil
    .turnin 4964 >> Turn in The Completed Orb of Dar'Orahil
step
    .goto The Barrens,62.6,37.4
    .bankdeposit 5807,6257 >> Deposit the following items in your bank: 
    >>Fool's Stout Report 
    >>Roc Gizzard
]])

RXPGuides.RegisterGuide("RestedXP Alliance 40-50",[[
#classic
<< Alliance

#name 44-48 Feralas
#next 48-49 Tanaris/Hinterlands

step
    #sticky
    #completewith start
     + There is A LOT of grinding required in this segment, you can substitute some of that for Zul'Farrak/Uldaman/Maraudon runs
step
    #hardcore
    .goto The Barrens,63.08,37.16
    .fly Thalanaar>>Fly to Thalanaar
step
    #softcore
    .goto The Barrens,63.08,37.16
    .fly Feathermoon>> Fly to Feathermoon
step
    #hardcore
	>>Run to Feathermoon Stronghold. Be careful of the horde guards in Camp Mojache en route
    .goto Feralas,30.2,43.3
    .fp Feathermoon>>Get the Feathermoon Flight Path
step <<  Hunter
     #completewith next
     .goto Feralas,31.6,43.2
     .stable >> Stable your pet
step <<  Hunter
    .train 17266 >> Tame a wolf south of Feathermoon Stronghold and learn Bite 6
step
    #sticky
     >> Restock on supplies, very long grinding session ahead 
    .vendor >>Buy 5 stacks of food/water 
    >>Make sure you have 25 stacks of ammo  << Hunter
step
    .goto Feralas,30.63,42.70
    .accept 2821 >> Accept The Mark of Quality
step
    .goto Feralas,31.0,43.4
    .home >> Set your Hearthstone to Feralas
step
    .goto Feralas,30.37,46.17
    .accept 4124 >> Accept The Missing Courier
    .accept 2866 >> Accept The Ruins of Solarsal 
step
    .goto Feralas,31.78,45.50
    .accept 2939 >> Accept In Search of Knowledge
    .accept 2982 >> Accept The High Wilderness
step
    #label start
    .goto Feralas,31.86,45.13
     >> Go upstairs
    .turnin 4124 >> Turn in The Missing Courier
    .accept 4125 >> Accept The Missing Courier
step
    .goto Feralas,26.30,52.33
     >> Click on the gazebo
    .turnin 2866 >> Turn in The Ruins of Solarsal 
    .accept 2867 >> Accept Return to Feathermoon Stronghold
step
    .goto Feralas,30.27,46.16
    .turnin 2867 >> Turn in Return to Feathermoon Stronghold
    .accept 3130 >> Accept Against the Hatecrest
    .turnin 3130 >> Turn in Against the Hatecrest
    .accept 2869 >> Accept Against the Hatecrest
step
    .goto Feralas,26.6,53.4
    >>Kill any type of naga
    .complete 2869,1
step
    .goto Feralas,30.37,46.17
    .turnin 2869 >> Turn in Against the Hatecrest
    .accept 2870 >> Accept Against Lord Shalzaru
step
    #completewith next
    .goto Feralas,26.1,67.3,35 >> Enter the naga cave
step
    .goto Feralas,28.49,70.46
    >>Kill Lord Shalzaru
    .complete 2870,1
step
    #softcore
     >> Grind mobs until you find a Distress Beacon
    .collect 8705,1,2766
    .accept 2766 >> Accept Find OOX-22/FE!
step
    .xp 46 >> Grind to level 46
step
    #completewith next
    .goto Feralas,38.72,75.07,40 >> Exit the naga cave and head southeast towards the ocean
    .goto Feralas,41.24,74.54,40 >> Swim to the mainland
step
    .goto Feralas,45.44,64.96
     >> Click on the Wrecked Row Boat
    .turnin 4125 >> Turn in The Missing Courier
    .accept 4127 >> Accept Boat Wreckage
step
    .hs >> Hearth back to Feathermoon
	>> Buy food/water if needed
step
    .goto Feralas,31.86,45.13
    .turnin 4127 >> Turn in Boat Wreckage
    .accept 4129 >> Accept The Knife Revealed
step
    .goto Feralas,32.44,43.78
    .turnin 4129 >> Turn in The Knife Revealed
    .accept 4130 >> Accept Psychometric Reading
step
    .goto Feralas,31.86,45.13
    .turnin 4130 >> Turn in Psychometric Reading
    .accept 4131 >> Accept The Woodpaw Gnolls
step
    .goto Feralas,30.37,46.17
    .turnin 2870 >> Turn in Against Lord Shalzaru
    .accept 2871 >> Accept Delivering the Relic
step
    .goto Feralas,30.07,45.05
    .turnin 2871 >> Turn in Delivering the Relic
step
    #completewith next
    .goto Feralas,47.3,44.7,45 >> Swim to the mainland
step
    #sticky
    #completewith spirits
     >> Kill wind serpents, use the quest item provided on their corpse
    .complete 3520,1
    --10699 (bramble)
step
    #sticky
    #label kalimdor
    .goto Feralas,58.8,59.0,0
     >> Kill Bears and Apes
    .complete 1452,2
    .complete 1452,3
step
    .goto The Barrens,8.77,97.09
    .goto The Barrens,7.47,99.05
    >>Kill Yetis
    .complete 2821,1--yetis
step
    #completewith next
    .goto The Barrens,8.77,97.09
    .accept 2766 >> Accept Find OOX-22/FE!
    .turnin 2766 >> Turn in Find OOX-22/FE!
step
    .goto The Barrens,8.77,97.09
    >> Do the chicken escort
    >>Skip this step if you haven't found a distress beacon
    >>This quest is HARD, skip this quest if you have to
    .accept 2767 >> Accept Rescue OOX-22/FE!
step
     >> Escort the robot chicken
     >>This quest is HARD, waves of 3/4 mobs will spawn along the way, don't be afraid to run away and skip this quest if it gets out of hand
    .complete 2767,1
    .isOnQuest 2767
step
    #sticky
    #label egg
    .goto Feralas,56.64,75.89
     >> Head south and look for Hippogryph nests by the mountains 
    >>Loot an Hyppogryph Egg
    .collect 8564,1,2741,1
step
    #label spirits
    .goto Feralas,59.46,65.12
     >> Kill Ogres
    .complete 2982,1
    .complete 2982,2
    .complete 2982,3
step
    #requires egg
    .goto Feralas,56.5,56.3,0
    .goto Feralas,53.2,47.6,0
     >> Finish off Screecher Spirits
    .complete 3520,1
step
    #requires kalimdor
    .goto Feralas,65.94,45.65
    >>Clear some mobs around the wooden cage nearby before accepting this escort quest
    .accept 2969 >> Accept Freedom for All Creatures
step
     >> Open the bamboo cage and protect the faerie dragons trying to escape
     .complete 2969,1
step
    .goto Feralas,65.94,45.65
    .turnin 2969 >> Turn in Freedom for All Creatures
    .accept 2970 >> Accept Doling Justice
step
    .goto Feralas,69.0,39.0
    .complete 2970,1
    .complete 2970,2
    .complete 2970,3
step
    .goto Feralas,65.94,45.60
    .turnin 2970 >> Turn in Doling Justice
    .accept 2972 >> Accept Doling Justice
step
    .goto Feralas,73.31,56.30
     >> Click on the 2 pouches hanging on the tree
    .turnin 4131 >> Turn in The Woodpaw Gnolls
    .accept 4135 >> Accept The Writhing Deep
step
    #sticky
    #label parcel
     >> Click on the Undelivered Parcel in your bags
    .collect 11463,1,4281
    .goto Feralas,73.31,56.30
    .accept 4281 >> Accept Thalanaar Delivery
step
    .goto Feralas,72.06,63.71
    >>Go deep into the silithid hive
    .turnin 4135 >> Turn in The Writhing Deep
    .accept 4265 >> Accept Freed from the Hive
step
     >> Wait for the RP sequence to end
     .complete 4265,1
step
    #era
    #requires parcel
    >> Grind mobs until your Hearthstone is off cooldown 
    .hs >>Hearth to Feathermoon
	>> Buy food/water if needed
step
    #som
    #requires parcel
    .goto Feralas,89.63,46.56
    .turnin 4281 >> Turn in Thalanaar Delivery
step
    #som
    #completewith next
    .goto The Barrens,33.57,90.34
    .fly Feathermoon>>Fly to Feathermoon
step
    .goto Feralas,31.86,45.13
     >> Go upstairs
    .turnin 4265 >> Turn in Freed from the Hive
    .accept 4266 >> Accept A Hero's Welcome
step
    .goto Feralas,30.27,46.16
    .turnin 4266 >> Turn in A Hero's Welcome
    .accept 4267 >> Accept Rise of the Silithid
step
     #completewith next
    .vendor >> Restock on food/water and supplies
step << !Warlock !Paladin
    #som
    #completewith next
    .goto Feralas,26.19,67.51
    .xp 47.75 >> At this point you should be close to having your mount money, if you're close to the 100g mark, grind nagas until you have enough to buy a mount, otherwise skip this step and fly to Teldrassil
step
    #era
    #completewith next
    .goto Feralas,26.19,67.51
    +Grind nagas until your Hearthstone cooldown is less than 10min, don't head out to Teldrassil without having your hearthstone ready to go back
    >>Grind a little bit more if you need money for a mount (100g) << !Paladin !Warlock
step
    .goto Feralas,30.2,43.3
    .fly Teldrassil>>Fly to Teldrassil
step
    .goto Teldrassil,55.49,92.04
    .accept 3661 >> Accept Favored of Elune?
step
    .goto Teldrassil,55.49,92.04
    .turnin 3022 >> Turn in Handle With Care
step
    .goto Teldrassil,55.41,92.23
    .turnin 2939 >> Turn in In Search of Knowledge
step
    .goto Teldrassil,55.22,91.45
     >> Click on the green book on the ground
    .accept 2940 >> Accept Feralas: A History
step
    .goto Teldrassil,55.41,92.23
    .turnin 2940 >> Turn in Feralas: A History
    .accept 2941 >> Accept The Borrower
step
    .goto Teldrassil,25.90,64.74
     >> Head to the temple of the mooon
    .turnin 4267 >> Turn in Rise of the Silithid
step
    .goto Teldrassil,25.33,63.90
    .turnin 2972 >> Turn in Doling Justice
step <<  NightElf
     #completewith next
    .trainer >> Train skills in Darnassus
step <<  NightElf
     #completewith next
     .goto Darnassus,38.6,15.6
     +Buy a mount if you have enough money
step << Human !Warlock !Paladin
     #completewith next
     .goto Elwynn Forest,84.0,65.4
     +If you still haven't bought your mount and you have 100g, take the boat to Wetlands, fly to Stormwind, head to the Eastvale Logging Camp in Elwynn Forest and buy a mount
step << Dwarf !Paladin
     #completewith next
     .goto Dun Morogh,63.4,50.6
     +If you still haven't bought your mount and you have 100g, take the boat to Wetlands, fly to Ironforge, head to the Amberstill Ranch in Dun Morogh and buy a mount
step << Gnome !Warlock
     #completewith next
     .goto Dun Morogh,49.2,48.0
     +If you still haven't bought your mount and you have 100g, take the boat to Wetlands, fly to Ironforge, head to Kharanos in Dun Morogh and buy a mount
step
    .hs >> Hearth back to Feralas
	>> Buy food/water if needed
step
    #som
    .goto Feralas,26.19,67.51
    .xp 47.75 >> Head back to the naga cave and grind to level 47+75%
step
    #era
    #phase 4
    .goto Feralas,26.19,67.51
    .xp 48 >> Head back to the naga cave and grind to level 48
step
    #era
    #phase 1-3
    .goto Feralas,26.19,67.51
    .xp 48.5 >> Head back to the naga cave and grind to level 48 + 50%
step
    #completewith next
    .hs >> Hearth back to Feathermoon if your Hearthstone is off cooldown
	>> Buy food/water if needed
step
    .goto Feralas,31.82,45.61
    .turnin 2982 >> Turn in The High Wilderness
    .accept 3445 >> Accept The Sunken Temple
step
    .goto Feralas,30.63,42.70
    .turnin 2821 >> Turn in The Mark of Quality
step << Hunter
    .goto Feralas,30.64,43.43
    .vendor >> Restock/resupply 
     >> Make sure to buy extra stacks of ammo for the next segment
step
    #completewith next
    .goto Feralas,30.2,43.3
    .fly Thalanaar>> Fly to Thalanaar
step
    .goto Feralas,89.63,46.56
    .accept 4281 >> Accept Thalanaar Delivery
    .turnin 4281 >> Turn in Thalanaar Delivery
step
    .goto Feralas,89.50,45.85
    .fly Tanaris>> Fly to Tanaris
]])

RXPGuides.RegisterGuide("RestedXP Alliance 40-50",[[
#classic
#name 48-49 Tanaris/Hinterlands
#next 49-50 Tanaris/Un'Goro
<< Alliance

step
    #completewith start
    .goto Tanaris,52.4,28.8
    .bankwithdraw 6257,6258,6259 >> Withdraw Roc Gizzard from your bank if you have it
step
    .goto Tanaris,51.80,28.66
    .accept 2605 >> Accept The Thirsty Goblin
step
    .goto Tanaris,52.35,26.90
    .turnin 2941 >> Turn in The Borrower
    .accept 2944 >> Accept The Super Snapper FX
step
    .goto Tanaris,52.30,27.00
     >> Click on the Egg-O-Matic and turn in your Hippogryph Egg 
    >>(The Super Egg-O-Matic) 
    >>It's a small metal console sitting next to the teleporter looking thing
    .turnin 2741 >> Turn in The Super Egg-O-Matic
step
    .goto Tanaris,51.56,26.75
    .accept 3362 >> Accept Thistleshrub Valley
step
    #label start
    .goto Tanaris,50.21,27.48
    .accept 992 >> Accept Gadgetzan Water Survey
step
    #sticky
    #completewith vultures
     >> Kill vultures as you go
    .complete 1452,1
step
    .goto Tanaris,39.00,29.40
     >> Use the dowsing widget at the small pond of water
    .complete 992,1
step
    .goto Tanaris,50.21,27.48
    .turnin 992 >> Turn in Gadgetzan Water Survey
    .accept 82 >> Accept Noxious Lair Investigation
step
    #label vultures
    .goto Tanaris,31.61,45.45
     >> Kill silithid mobs
    .complete 82,1
step
    .goto Tanaris,44.60,39.60
     >> Finish off Rhapsody's Kalimdor Kocktail
    .complete 1452,1

step
    .goto Tanaris,28.70,64.06
     >> Kill Dew Collectors. Loot them for the Dew Gland
    .complete 2605,1
    .complete 3362,1
    .complete 3362,2
step
	#softcore
     #completewith next
    .deathskip >>Die and respawn at the Spirit Healer in Gadgetzan
step
    .goto Tanaris,51.80,28.66
    .turnin 2605 >> Turn in The Thirsty Goblin
    .accept 2606 >> Accept In Good Taste
step
    .goto Tanaris,52.51,27.91
    .home >> Set your Hearthstone to Gadgetzan
step
    .goto Tanaris,51.05,26.87
    .turnin 2606 >> Turn in In Good Taste
    .accept 2641 >> Accept Sprinkle's Secret Ingredient
step
    .goto Tanaris,50.88,26.96
    .turnin 82 >> Turn in Noxious Lair Investigation
    .accept 10 >> Accept The Scrimshank Redemption
step
    .goto Tanaris,51.01,29.35
    .fly Theramore>> Fly to Theramore
step
    #completewith next
    .goto Dustwallow Marsh,71.51,56.36,20 >> Go to the end of the dock. Wait here for the boat
step
    .goto Dustwallow Marsh,71.63,56.46
    .zone Wetlands >> Take the boat to Menethil Harbor
step
     #completewith next
    .goto Wetlands,9.49,59.69
    .fly Hinterlands>> Fly to The Hinterlands
step
    .goto The Hinterlands,9.75,44.47
    .accept 2988 >> Accept Witherbark Cages
step
    .goto The Hinterlands,14.83,44.56
    .accept 2880 >> Accept Troll Necklace Bounty
step
    #sticky
    #label feathers
     >> Loot wildkin feathers on the ground
    .complete 3661,1
step
    .goto The Hinterlands,26.94,48.58
    .turnin 1452 >> Turn in Rhapsody's Kalimdor Kocktail
    .accept 1469 >> Accept Rhapsody's Tale
step
    .goto The Hinterlands,31.98,57.31
     >> Click on the third cage
    .complete 2988,3
step
    #sticky
    #label necklaces
     >> Kill forest trolls
    .complete 2880,1
step
     >> Click on the first/second cage
    .complete 2988,2
    .goto The Hinterlands,23.12,58.82
    .complete 2988,1
    .goto The Hinterlands,23.28,58.81
step
    #requires necklaces
    .goto The Hinterlands,14.83,44.56
    .turnin 2880 >> Turn in Troll Necklace Bounty
    .accept 2877 >> Accept Skulk Rock Clean-up
step
    .goto The Hinterlands,9.75,44.47
    .turnin 2988 >> Turn in Witherbark Cages
    .accept 2989 >> Accept The Altar of Zul
step
    .goto The Hinterlands,40.63,59.65
     >> Loot a purple mushroom underwater
    .complete 2641,1
step
    .goto The Hinterlands,48.86,68.50
     >> Climb the stairs of the pyramid, try to avoid fighting the elite mobs at the top
    .complete 2989,1
step
    .goto The Hinterlands,57.71,42.42
     >> Do Skulk Rock Clean-up
    .complete 2877,1
    .complete 2877,2
step
    #requires feathers
     >> Grind until your Hearthstone cooldown is <6 minutes
     >>If you managed to find a Distress beacon, right click it
    .accept 485 >> Accept Find OOX-09/HL!
    >>Skip this step if you haven't found it
step
    .goto The Hinterlands,49.35,37.65
    .turnin 485 >> Turn in Find OOX-09/HL!
    .isOnQuest 485
step
    .goto The Hinterlands,49.35,37.65
     >> Start the escort quest
    .accept 836 >> Accept Rescue OOX-09/HL!
    .isQuestTurnedIn 485
step
     >> Escort the robot chicken
     >>This quest is HARD, you'll have to fight waves of 3 mobs along the way, be ready to abandon this quest if things get out of hand
    .complete 836,1
    .isOnQuest 836
step
    #sticky
    #label turtle
    .goto The Hinterlands,78.19,77.81,0
     >> Head down to the coast, find Gammerita and use the Super Snapper FX on her.
    .complete 2944,1
    .unitscan GAMMERITA
step
    .goto The Hinterlands,78.19,77.81
     >> Look for small blue bottles along the coast
    .complete 580,1
step
    #requires turtle
    .goto The Hinterlands,80.78,46.82
    .turnin 626 >> Turn in Cortello's Riddle
    .isOnQuest 626
step
     >> Grind mobs until your Hearthstone is off cooldown 
    .hs >>Hearth to back Tanaris
	>> Buy food/water if needed
]])

RXPGuides.RegisterGuide("RestedXP Alliance 40-50",[[
#classic
#name 49-50 Tanaris/Un'Goro
#next RestedXP Alliance 50-60\50-50 Stranglethorn Vale

<< Alliance

step
    #sticky
    .goto Tanaris,52.4,28.8
    .bankdeposit 9328,9330,10819,3900,6287 >> Deposit the following items: 
    >>Wildkin Feather 
    >>Raschal's Report
    >>Atal'ai Tablet Fragment
step
    .goto Tanaris,50.21,27.48
    .accept 10 >> Accept The Scrimshank Redemption
step
    .goto Tanaris,51.05,26.87
    .turnin 2641 >> Turn in Sprinkle's Secret Ingredient
    .accept 2661 >> Accept Delivery for Marin
step
    .goto Tanaris,51.56,26.75
    .turnin 3362 >> Turn in Thistleshrub Valley
step
    .goto Tanaris,51.84,27.02
     >> Click on the wanted poster
    .accept 2781 >> Accept WANTED: Caliph Scorpidsting
    .accept 2875 >> Accept WANTED: Andre Firebeard
step
    .goto Tanaris,52.81,27.40
    .accept 5863 >> Accept The Dunemaul Compound
step
    .goto Tanaris,52.46,28.51
    .accept 1691 >> Accept More Wastewander Justice
step
    .goto Tanaris,51.80,28.66
    .turnin 2661 >> Turn in Delivery for Marin
    .accept 2662 >> Accept Noggenfogger Elixir
    .turnin 2662 >> Turn in Noggenfogger Elixir
step
     #completewith next
     + Make sure you carry 1 stack of noggenfogger with you at all times, buy 2 extra stacks and bank it
step
    .goto Tanaris,52.70,45.92
    .turnin 3445 >> Turn in The Sunken Temple
    .accept 3444 >> Accept The Stone Circle
step
    .goto Tanaris,52.70,45.92
    .accept 3161 >> Accept Gahz'ridian
step
    .goto Tanaris,61.76,38.16
    .complete 1691,1
    .complete 1691,2
    .complete 1691,3
     >> Kill Caliph Scorpid Sting, he patrols around the area with 2 stealthed mobs
    .complete 2781,1
step
    #completewith next
    .goto Tanaris,68.85,41.55,25 >> Head to Lost Rigger Cove
step
    #label andre
    #sticky
    .goto Tanaris,73.97,47.50,0
     >> Kill Andre Firebeard by the campfire
    .complete 2875,1
step
     #sticky
     #label pirates
    .goto Tanaris,73.97,47.50,0
     >> Kill pirates
    .complete 8365,1
    .complete 8366,1
    .complete 8366,2
    .complete 8366,3
    .complete 8366,4
step
    .goto Tanaris,72.15,46.76
     >> Loot Stoley's Shipment upstairs
    .complete 2873,1
step
    #completewith next
    #requires pirates
    >>Grind pirates until you find a distress beacon.
    >>If you can't find the Distress Beacon by the time you are level 49, skip this step
    .accept 351 >> Accept Find OOX-17/TN!
step
    #requires pirates
    .xp 49 >> Grind to level 49
step
    #requires andre
    .goto Tanaris,47.31,65.14
     >> Look for small patches of sand around the ogre ruins
    .complete 3161,1
step
    #completewith next
    .goto Tanaris,54.63,70.75,20 >> Enter the eastern bug hole
step 
    .goto Tanaris,55.97,71.18
    >>Loot the machine console looking thing
    .complete 10,1
step
    >>Click on the Distress Beacon if you happen to have one, otherwise, skip this step
    .collect 8623,1,351
    .accept 351 >> Accept Find OOX-17/TN
step
    .goto Tanaris,60.23,64.71
    .turnin 351 >> Turn in Find OOX-17/TN!
    .isOnQuest 351
step
    .goto Tanaris,60.23,64.71
     >> Start the escort quest
    .accept 648 >> Accept Rescue OOX-17/TN!
    .isQuestTurnedIn 351
step
     >> Escort the robot chicken
     >>This quest is HARD, you'll have to deal with waves of 3 mobs along the way, be ready to abandon this quest if the situation spiral out of control
    .complete 648,1
    .isQuestTurnedIn 351
step
    .goto Tanaris,67.05,23.89
    .turnin 2875 >> Turn in WANTED: Andre Firebeard
    .turnin 8366 >> Turn in Southsea Shakedown
    .turnin 2873 >> Turn in Stoley's Shipment
    .accept 2874 >> Accept Deliver to MacKinley
step
    .goto Tanaris,66.55,22.26
    .turnin 8365 >> Turn in Pirate Hats Ahoy!
step
    .goto Tanaris,66.98,22.35
    .turnin 3520 >> Turn in Screecher Spirits
step << Hunter
    #completewith next
    .goto Tanaris,67.0,22.0
    .vendor >> Buy arrows before leaving the port
step
    .hs >> Hearth back to Gadgetzan
	>> Buy food/water if needed
step
    .goto Tanaris,52.46,28.51
    .turnin 1691 >> Turn in More Wastewander Justice
    .turnin 2781 >> Turn in WANTED: Caliph Scorpidsting
step
    .goto Tanaris,52.81,27.40
    .accept 5863 >> Accept The Dunemaul Compound
step
    .goto Tanaris,51.80,28.66
    .accept 2605 >> Accept The Thirsty Goblin
step
    .goto Tanaris,50.21,27.48
    .turnin 10 >> Turn in The Scrimshank Redemption
    .accept 110 >> Accept Insect Part Analysis
step
    .goto Tanaris,50.88,26.96
    .turnin 110 >> Turn in Insect Part Analysis
    .accept 113 >> Accept Insect Part Analysis
step
    .goto Tanaris,51.56,26.75
    .accept 3362 >> Accept Thistleshrub Valley
step
    .goto Tanaris,50.21,27.48
    .turnin 113 >> Turn in Insect Part Analysis
step
    .goto Tanaris,52.70,45.92
    .turnin 3161 >> Turn in Gahz'ridian
step
    .goto Tanaris,52.70,45.92
    .accept 3444 >> Accept The Stone Circle
step
     #label gormarok
     #sticky
    .goto Tanaris,41.50,57.81
     >>Kill Gor'marok
    .complete 5863,3
step
    .goto Tanaris,41.78,54.85
     >> Kill Ogres
    .complete 5863,1
    .complete 5863,2
step
    #requires gormarok
    .goto Un'Goro Crater,71.63,75.95
     >> Run to Un'goro Crater
    .accept 4289 >> Accept The Apes of Un'Goro
    .accept 4290 >> Accept The Fare of Lar'korwi
step
     #completewith next
     + Save Un'Goro Soil, you will need 25 later
step
    #sticky
    #label crystals
     >> As you quest through Un'Goro, loot 7 crystals of each color
    .collect 11186,7,4284,1
    .collect 11185,7,4284,1
    .collect 11184,7,4284,1
    .collect 11188,7,4284,1
step
    .goto Un'Goro Crater,63.02,68.60
     >> Click on the Wrecked Raft
    .accept 3844 >> Accept It's a Secret to Everybody
step
    .goto Un'Goro Crater,63.10,69.05
     >> Click on the small pack underwater
    .turnin 3844 >> Turn in It's a Secret to Everybody
    .accept 3845 >> Accept It's a Secret to Everybody
step
    .goto Un'Goro Crater,68.73,56.70
     >> Loot the threshadon carcass
    .complete 4290,1
step
     >> Run north to Marshal's Refuge
    .goto Un'Goro Crater,44.23,11.58
    .accept 4503 >> Accept Shizzle's Flyer
step
    .goto Un'Goro Crater,42.94,9.63
    .accept 4141 >> Accept Muigin and Larion
step
    .goto Un'Goro Crater,43.49,7.42
    .accept 3882 >> Accept Roll the Bones
step
     #completewith next
     >> Open the small pack in your inventory
    .complete 3845,1
    .complete 3845,2
    .complete 3845,3
step
    .goto Un'Goro Crater,44.65,8.09
    .turnin 3845 >> Turn in It's a Secret to Everybody
    .accept 3908 >> Accept It's a Secret to Everybody
step
    #sticky
    .destroy 11108 >> Destroy the faded photograph
step
    .goto Un'Goro Crater,45.23,5.83
    .fp Un'Goro>> Get the Un'Goro Crater Flight Path
step
    #completewith Uend
     >> Kill dinos as you quest - This step is going to be finished later, don't go out of your way to complete this
    .complete 4503,1
    .complete 4503,2
    .complete 3882,1
step
    #sticky
    #completewith lashers
    .goto Un'Goro Crater,67.0,28.0,0
     >> Kill level 48-50 Lashers in northeastern Un'goro
    .complete 4141,1
step
    .goto Un'Goro Crater,71.63,75.95
    .turnin 4290 >> Turn in The Fare of Lar'korwi
    .accept 4291 >> Accept The Scent of Lar'korwi
step
    .goto Un'Goro Crater,67.30,73.10,15,0
    .goto Un'Goro Crater,66.6,66.7,15,0
    .goto Un'Goro Crater,67.30,73.10,0
    .goto Un'Goro Crater,66.6,66.7,0
     >>Step on raptor nests and kill Lar'kowi Mates
    .complete 4291,1
step
    #label lashers
    .goto Un'Goro Crater,71.63,75.95
    .turnin 4291 >> Turn in The Scent of Lar'korwi
    .accept 4292 >> Accept The Bait for Lar'korwi
step
    .goto Un'Goro Crater,69.52,31.02
     >> Finish off Muigin and Larion
    .complete 4141,1
step
    #label Uend
     >> Grind mobs in Un'Goro until you find A Mangled Journal
     .collect 11116,1,3884
    .accept 3884 >> Accept Williden's Journal
step
	#softcore
    #requires crystals
    .hs >> Hearth back to Tanaris 
    >>Alternatively you can run to tanaris, die on purpose and respawn at Gadgetzan
    .zoneskip Tanaris
step
	#hardcore
    #requires crystals
    .hs >> Hearth back to Tanaris 
	>> Buy food/water if needed
    .zoneskip Tanaris
step
    #sticky
    .bankwithdraw 2799,4098,5807,3900,6287 >> Withdraw the following items: 
    >>Carefully Folded Note (if you have it) 
    >>Gorilla Fangs 
    >>Fool's Stout Report 
    >>Pupellyverbos Port 
    >>Atal'ai Tablet Fragment
step
    #sticky
    .bankdeposit 11568,11569,11570,11830,11018,11133,8594,11114,11831,11316 >> Deposit the following items in your bank: 
    >>Torwa's Pouch 
    >>Webbed Diemetradon Scale 
    >>Webbed Pterrordax Scale 
    >>Dinosaur Bone 
    >>Un'Goro Soil 
    >>Linken's Training Sword 
    >>Insect Analysis Report
    >>Bloodpetal
step
    .goto Tanaris,51.80,28.66
    .turnin 2605 >> Turn in The Thirsty Goblin
    .accept 2606 >> Accept In Good Taste
step
    .goto Tanaris,52.81,27.40
    .turnin 5863 >> Turn in The Dunemaul Compound
step
    .goto Tanaris,51.05,26.87
    .turnin 2606 >> Turn in In Good Taste
    .accept 2641 >> Accept Sprinkle's Secret Ingredient
step
    .goto Tanaris,50.21,27.48
    .accept 162 >> Accept Rise of the Silithid
step
    .goto Tanaris,51.01,29.35
    .fly Un'Goro Crater>> Fly to Un'Goro Crater
step
    .goto Un'Goro Crater,43.94,7.13
    .turnin 3884 >> Turn in Williden's Journal
step
    .goto Un'Goro Crater,42.94,9.63
    .turnin 4141 >> Turn in Muigin and Larion
    .accept 4142 >> Accept A Visit to Gregan
step
    .goto Un'Goro Crater,41.91,2.69
    .accept 4284 >> Accept Crystals of Power
    .turnin 4284 >> Turn in Crystals of Power
step
    #softcore
    .goto Stormwind City,52.80,65.40
    .home >> Use the website unstuck self service to teleport to Stormwind and set your Hearthstone to Stormwind
    >>OR
    >>Fly to Ratchet and take the boat to Stranglethorn Vale
    .zoneskip Stranglethorn Vale
step
    #hardcore
    #completewith next
    .goto Un'Goro Crater,45.23,5.83
    .fly Ratchet>> Fly to Ratchet
step
	#hardcore
    #completewith next
	.goto The Barrens,63.64,38.61,40 >> Run to the Ratchet Dock
step
	#hardcore
    .goto The Barrens,63.74,38.66
    .zone Stranglethorn Vale >> Take the Boat to Booty Bay
]])



RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance

#name 50-50 Stranglethorn Vale
#next 50-51 Searing Gorge
step
     #completewith next
     .fly Booty>> Fly or take the boat to Booty Bay
     .zoneskip Stranglethorn Vale
step
    #hardcore
    .goto Stranglethorn Vale,26.69,73.61
    .accept 8551 >> Accept The Captain's Chest
step
    >>Head to the top floor of the inn
    .goto Stranglethorn Vale,27.17,77.00
    .accept 608 >> Accept The Bloodsail Buccaneers
step
    .goto Stranglethorn Vale,27.11,77.21
    .turnin 1122 >> Turn in Report Back to Fizzlebub
step
    .goto Stranglethorn Vale,27.13,77.44
    .turnin 580 >> Turn in Whiskey Slim's Lost Grog
step
    #hardcore
    .home >> Set your Hearthstone to Booty Bay
step
    .goto Stranglethorn Vale,27.78,77.06
    .turnin 2874 >> Turn in Deliver to MacKinley
step
    .goto Stranglethorn Vale,27.60,76.73
    .accept 348 >> Accept Stranglethorn Fever
step
    .goto Stranglethorn Vale,28.35,76.35
    .turnin 2767 >> Turn in Rescue OOX-22/FE!
    .isQuestComplete 2767
step
    .goto Stranglethorn Vale,28.35,76.35
    .turnin 648 >> Turn in Rescue OOX-17/TN!
    .isQuestComplete 648
step
    .goto Stranglethorn Vale,28.35,76.35
    .turnin 836 >> Turn in Rescue OOX-09/HL!
    .isQuestComplete 836
step
    .goto Stranglethorn Vale,28.35,76.35
    .accept 3721 >> Accept An OOX of Your Own
    .turnin 3721 >> Turn in An OOX of Your Own
    .isQuestTurnedIn 836
    .isQuestTurnedIn 648
    .isQuestTurnedIn 2767
step
    #softcore
    .goto Stranglethorn Vale,26.69,73.61
    .accept 8551 >> Accept The Captain's Chest
step << !Warrior !Rogue !Paladin
    #sticky
     >> Look for Mok'rash, an elite giant at the giant goblin statue
    >>Set up a slow trap near the goblin statue and kite him with cheetah << Hunter
    >>Kill him by kiting in circles around the goblin statue
    >>Fear him as much as you can, he's not immune to fear or slows << Priest/Warlock
    >>Once he gets to around 60% hp, use Levitate to kite him back to Booty Bay << Priest
    >>Only use ranged spells (root/starfire/moonfire) he hits HARD << Druid
    >>Loot and right click The Monogrammed Sash 
    .accept 8552 >> Accept The Monogrammed Sash
    >>This can be a very hard elite to solo, skip this step if you have to
    .link https://www.youtube.com/watch?v=xw2mGnQaCQM >> Click here for video reference << Priest
    .link https://www.twitch.tv/videos/850022146?t=04h16m26s >> Click here for video reference << !Priest
step
    #completewith bottle
     >> Loot the green bottles along the southeastern coast
     .collect 4098,1,594
    .accept 594 >> Accept Message in a Bottle
step
    .goto Stranglethorn Vale,29.32,88.29
     >> Kill Captain Keelhaul
    .complete 608,2
step
    .goto Stranglethorn Vale,30.58,90.63
     >> Kill Fleet Master Firallon
    .complete 608,3
step
    .goto Stranglethorn Vale,32.87,88.20
     >> Kill Captain Stillwater
    .complete 608,1
step
    #label bottle
    .goto Stranglethorn Vale,38.53,80.57
    .turnin 594 >> Turn in Message in a Bottle
step << Mage/Warlock/Hunter/Druid
    .goto Stranglethorn Vale,38.53,80.57
    .accept 630 >> Accept Message in a Bottle
step << Mage/Warlock/Hunter/Druid
    .goto Stranglethorn Vale,40.94,83.89
     >> Kill King Mukla by running in circles around a big tree
     >>Keep him feared, be careful as he also can fear you << Warlock
     >>This can be a very difficult elite to solo, skip if you have to
    .complete 630,1
    .link https://www.twitch.tv/videos/850022146?t=04h30m47s >> Click here for video reference
step << Mage/Warlock/Hunter/Druid
    .goto Stranglethorn Vale,38.53,80.57
    .turnin 630 >> Turn in Message in a Bottle
    .isQuestComplete 630
step
    .goto Stranglethorn Vale,36.95,69.73
     >> Kill Gorlash, the level 47 elite sea giant, try to kite him to the guards in town
     >>Don't try to solo him if you don't have cooldowns ready/healing pots << Rogue/Warrior/Paladin
    .complete 8551,1
step
    .goto Stranglethorn Vale,35.27,60.42
     >> Turn in 10 gorilla fangs to summon Mokk the savage, you'll have to deal with 3 waves of gorillas, you don't need to kill all the gorillas from the last wave, just kill Mokk, and loot his heart
     >>The last wave is very dangerous, you have to deal with 6 level 41 gorillas, this quest can be very hard to solo
    .complete 348,1
    .link https://www.twitch.tv/videos/850022146?t=04h38m04s >> Click here for video reference
step
    .goto Stranglethorn Vale,26.69,73.61
     >> Go back to Booty Bay
    .turnin 8551 >> Turn in The Captain's Chest
    .isQuestComplete 8551
step
    .goto Stranglethorn Vale,26.69,73.61
    .turnin 8552 >> Turn in The Monogrammed Sash
    .isQuestComplete 8552
step
    #sticky
    .accept 615 >> Accept The Captain's Cutlass
    .turnin 615 >> Turn in The Captain's Cutlass
    .isQuestTurnedIn 8552
step
    .goto Stranglethorn Vale,26.69,73.61
    .accept 8553 >> Accept The Captain's Cutlass
    .turnin 8553 >> Turn in The Captain's Cutlass
    .isQuestTurnedIn 8552
step
    .goto Stranglethorn Vale,27.60,76.73
    .turnin 348 >> Turn in Stranglethorn Fever
    .isQuestComplete 348
step
    .goto Stranglethorn Vale,27.17,77.00
    .turnin 608 >> Turn in The Bloodsail Buccaneers
step
    .fly Stormwind>> Fly to Stormwind
    >>Hearth back to SW instead if your hearthstone is set to Stormwind
    .zoneskip Stormwind City
step
     #completewith end
     >> Make sure you have 15 Silk Cloth in your bags before starting the next segment
    .collect 4306,15,4449,1
step <<  Hunter
     #completewith end
    .trainer >> Train skills 
    .train 15150 >>Train Growl Rank 6 
    >>Retrain your pet, learn fire resistance rank 4 and shadow resistance rank 3
step
     #completewith end
    .goto Stormwind City,52.80,65.60
    .home >> Set your HS to Stormwind
step
    .goto Stormwind City,64.33,20.65
    .turnin 1469 >> Turn in Rhapsody's Tale
step
     #completewith next
    .zone Ironforge >> Take the tram to Ironforge
step
    #label end
    .fly Thorium Point>> Fly to Searing Gorge
]])

RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance
#name 50-51 Searing Gorge
#next 51-51 Blasted Lands

step
     >> Make sure you have 15 on your bags before starting this segment
    .collect 4306,15,4449,1
step
    .goto Searing Gorge,38.58,27.80
     >> Talk to Hansel Heavyhands
    .accept 7723 >> Accept Curse These Fat Fingers
    .accept 7724 >> Accept Fiery Menace!
step
    .goto Searing Gorge,37.64,26.47
     >> Click on the wanted board
    .accept 7728 >> Accept STOLEN: Smithing Tuyere and Lookout's Spyglass
    .accept 7729 >> Accept JOB OPPORTUNITY: Culling the Competition
step
    .goto Searing Gorge,39.05,38.98
    .accept 3441 >> Accept Divine Retribution
step
     >> Talk to Kalaran Windblade 
     >>Go through his whole dialogue
    .complete 3441,1
    .skipgossip
step
    .goto Searing Gorge,39.05,38.98
    .turnin 3441 >> Turn in Divine Retribution
    .accept 3442 >> Accept The Flawless Flame
step
	#sticky
	#label key
	>>Kill any type of Dark Iron Dwarf
	.collect 11818,1,4451
step
    #sticky
    #label flawlessflame
     >> Make sure you prioritize Fire Elementals/Golems
    .complete 3442,1
    .goto Searing Gorge,30.0,76.8
    .complete 3442,2
    .goto Searing Gorge,30.0,76.8
step
    #sticky
     >> Kill Lava Spiders along the western edge of the map
    .complete 7724,1
    .goto Searing Gorge,28.8,63.2
     >> Kill War Golems
    .complete 7723,1
    .goto Searing Gorge,34.2,46.4
step
    #sticky
     >> Kill Steamsmiths around the cauldron
    .complete 7728,1
    .goto Searing Gorge,40.90,50.31
     >> Kill Dark Iron Lookouts around the towers
    .complete 7728,2
    .goto Searing Gorge,34.08,53.99,0
    .goto Searing Gorge,35.7,60.6,0
step
    #requires flawlessflame
    .goto Searing Gorge,39.05,38.98
    .turnin 3442 >> Turn in The Flawless Flame
    .accept 3443 >> Accept Forging the Shaft
step
    .goto Searing Gorge,40.90,50.31
    >>Kill Dark Iron Dwarves
    .complete 3443,1
step
    .goto Searing Gorge,39.05,38.98
    .turnin 3443 >> Turn in Forging the Shaft
    .accept 3452 >> Accept The Flame's Casing
step
    .goto Searing Gorge,24.1,36.4
	>>Kill Twilight cultists
    >>This elite quest can be difficult, skip this step if you have to
    .complete 3452,1 --Collect Symbol of Ragnaros (x1)
step
    .goto Searing Gorge,38.97,27.50
    .turnin 7723 >> Turn in Curse These Fat Fingers
    .turnin 7724 >> Turn in Fiery Menace!
step
    .accept 7727 >> Accept Incendosaurs? Whateverosaur is More Like It
    .goto Searing Gorge,38.58,27.80
    .accept 7722 >> Accept What the Flux?
    .goto Searing Gorge,38.80,28.50
step
    .goto Searing Gorge,39.1,39.1
    .turnin 3452 >> Turn in The Flame's Casing
    .isQuestComplete 3452
step
    .goto Searing Gorge,39.1,39.1
    .accept 3453 >> Accept The Torch of Retribution
    .isQuestTurnedIn 3452
step
    .goto Searing Gorge,39.1,39.1
	>>Wait for the RP sequence, don't go too far away from the NPC or the quest will fail
    .complete 3453,1 --Torch Creation
    .isQuestTurnedIn 3452
step
    .goto Searing Gorge,39.1,39.1
    .turnin 3453 >> Turn in The Torch of Retribution
    .accept 3454 >> Accept The Torch of Retribution
    .turnin 3454 >> Turn in The Torch of Retribution
    .accept 3462 >> Accept Squire Maltrake
    .turnin 3462 >> Turn in Squire Maltrake
    .accept 3463 >> Accept Set Them Ablaze!
    .isQuestTurnedIn 3452
step
    .goto Searing Gorge,33.3,54.4
    >>Equip the torch in your bags and click on the small brazier at the top of the tower
    .complete 3463,4 --Collect Northern Tower Ablaze (x1)
    .isQuestTurnedIn 3452
step
    .goto Searing Gorge,35.7,60.6
    .complete 3463,1 --Collect Western Tower Ablaze (x1)
    .isQuestTurnedIn 3452
step
    .goto Searing Gorge,44.0,60.9
    .complete 3463,2 --Collect Southern Tower Ablaze (x1)
    .isQuestTurnedIn 3452
step
	#sticky
	#requires key
	.goto Searing Gorge,65.6,62.2,0
	>>Click on the outhouse key and turn in the quest
	.accept 4451 >> The Key to Freedom
	.turnin 4451 >> The Key to Freedom
step
    .goto Searing Gorge,65.59,62.17
    .accept 4449 >> Accept Caught!
step
    #sticky
    #label geologists
    .goto Searing Gorge,63.6,59.4,0
    .goto Searing Gorge,69.2,34.4,0
    >>Clear the camp next to the quest giver, you likely won't find enough of them to finish this quest in one pass
    .complete 4449,1
    .complete 4449,2
step
    #sticky
    #label lookout
    .goto Searing Gorge,50.10,54.70
    .goto Searing Gorge,44.0,60.9
    >>Kill Dark Iron Lookouts next to the eastern towers
    .complete 7728,2
step
    .goto Searing Gorge,50.10,54.70
     >> Set the fourth tower on fire, make sure you finsh off the spyglass quest
    .complete 3463,3
    .isQuestTurnedIn 3452
step
    #requires lookout
    .goto Searing Gorge,72.20,73.64
     >> Kill Margol the Rager, loot Margol's Horn and right click it
    .accept 3181 >> Accept The Horn of the Beast
step
    #sticky
    #requires geologists
    #label caught
    .goto Searing Gorge,65.59,62.17
    .turnin 4449 >> Turn in Caught!
step
    .goto Searing Gorge,63.92,60.98
     >> Start the escort quest
    .accept 3367 >> Accept Suntara Stones
step
     >> Escort Dorius
    .complete 3367,1
step
    .goto Searing Gorge,74.44,19.28
     >> Click on the singed letter on the ground
    .turnin 3367 >> Turn in Suntara Stones
    .accept 3368 >> Accept Suntara Stones

step
    #requires caught
    #completewith next
    .goto Searing Gorge,35.27,42.61,25 >> Jump down into the square hole just outside Thorium Point
step
    #completewith dwarves
    #requires caught
    >>Kill Dark Iron dwarves
    .goto Searing Gorge,42.81,28.11,0
    .complete 7729,1
    .complete 7729,2
step
    #requires caught
    .goto Searing Gorge,40.44,35.73
     >> Find the steel ramp that leads to the 2nd floor Pull mobs away with your pet Loot the plans laying on top of the bench
    .complete 7722,1
step
    #label dwarves
    .goto Searing Gorge,47.53,24.87
     >> Kill Incendosaurs
    .complete 7727,1
step
    .goto Searing Gorge,42.81,28.11,0
    .complete 7729,1
    .complete 7729,2
step
    #completewith end
    .deathskip >> Die and respawn at Thorium Point
step
    #label end
    .turnin 7727 >> Turn in Incendosaurs? Whateverosaur is More Like It
    .goto Searing Gorge,38.58,27.80
    .turnin 7729 >> Turn in JOB OPPORTUNITY: Culling the Competition
    .goto Searing Gorge,38.97,27.50
    .turnin 7722 >> Turn in What the Flux?
    .goto Searing Gorge,38.80,28.50
    .turnin 7728 >> Turn in STOLEN: Smithing Tuyere and Lookout's Spyglass
step
    .goto Searing Gorge,39.0,39.0
    .turnin 3463 >> Turn in Set Them Ablaze!
    .accept 3481 >> Accept Trinkets...
     >> Open the Hoard of the Black Dragonflight and keep the Black Dragonflight Molt
    .turnin 3481 >> Turn in Trinkets...
    .isQuestTurnedIn 3452
step
    .fly Loch Modan>> Fly to Loch Modan
step
    .goto Badlands,16.73,8.64
    .turnin 3181 >> Turn in The Horn of the Beast
    .accept 3182 >> Accept Proof of Deed
step
     #completewith next
    .hs >> Hearth to Stormwind
	>> Buy food/water if needed
step
    .goto Stormwind City,44.27,73.99
     >> Do the Stormwind cloth turn ins, you'll need 3 stacks of each cloth type:
    .turnin 7791 >> Turn in A Donation of Wool
    .turnin 7793 >> Turn in A Donation of Silk
    .turnin 7794 >> Turn in A Donation of Mageweave
step << Hunter
    #completewith next
    .vendor >> Make sure you refill your quiver before heading to Blasted Lands
step
    .fly Blasted Lands>> Fly to Blasted Lands

]])

RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance

#name 51-51 Blasted Lands
#next 51-52 WPL


step
    .goto Blasted Lands,67.56,19.29
     >> Climb the tower and accept Petty Squabbles
    .accept 2783 >> Accept Petty Squabbles
step
    .goto Swamp of Sorrows,34.29,66.15
    .turnin 2783 >> Turn in Petty Squabbles
    .accept 2801 >> Accept A Tale of Sorrow
step
     >> Go through his whole dialogue.
    .complete 2801,1
    .skipgossip 
step
    .goto Blasted Lands,52.76,2.93
    .turnin 2801 >> Turn in A Tale of Sorrow
step
    #completewith BLend
    #label fragment
    >>Try to loot a Draenethyst fragment from any of the mobs in Blasted Lands
    .collect 10593,1,3501,1
step
    #requires fragment
    #completewith BLend
    .goto Blasted Lands,51.8,35.6
    .accept 3501 >> Accept Everything Counts In Large Amounts
    .turnin 3501 >> Turn in Everything Counts In Large Amounts
step
    #completewith BLend
     #label blquests
    .blastedLands
    *Basilisks share spawns with boars and hyenas share spawns with scorpids
step << Hunter/Rogue
    .goto Blasted Lands,50.55,14.20
    >>Go back to the quest giver once you get the following:
    >>3 Scorpok Pincer 
    >>2 Vulture Gizzard 
    >>1 Blasted Boar Lung
    .accept 2585 >> Accept The Decisive Striker
    .turnin 2585 >> Turn in The Decisive Striker
step << Druid/Paladin/Warrior/Shaman
    .goto Blasted Lands,50.55,14.20
    >>Go back to the quest giver once you get the following:
    >>3 Snickerfang Jowl
    >>2 Blasted Boar Lung
    >>1 Scorpok Pincer
    .accept 2581 >> Accept Snickerfang Jowls
    .turnin 2581 >> Turn in Snickerfang Jowls
step
    #requires blquests
    .goto Blasted Lands,50.55,14.20
    .accept 2585 >> Accept The Decisive Striker << !Rogue !Hunter
    .turnin 2585 >> Turn in The Decisive Striker << !Rogue !Hunter
    .accept 2583 >> Accept A Boar's Vitality
    .turnin 2583 >> Turn in A Boar's Vitality
    .accept 2581 >> Accept Snickerfang Jowls << !Druid !Paladin !Warrior !Shaman
    .turnin 2581 >> Turn in Snickerfang Jowls << !Druid !Paladin !Warrior !Shaman
    .accept 2601 >> Accept The Basilisk's Bite
    .turnin 2601 >> Turn in The Basilisk's Bite
    .accept 2603 >> Accept Vulture's Vigor
    .turnin 2603 >> Turn in Vulture's Vigor
step--som?
    #label BLend
    .fly Redridge>> Fly to Redridige
step
    .goto Burning Steppes,84.55,68.67
     >> Head to Burning Steppes
    .accept 3823 >> Accept Extinguish the Firegut
step
    .goto Burning Steppes,80.74,44.38
    .complete 3823,1
    .complete 3823,2
    .complete 3823,3
step
    .goto Burning Steppes,84.55,68.67
    .turnin 3823 >> Turn in Extinguish the Firegut
step
    .fly Ironforge>> Fly to Ironforge
step
    #sticky
    .bankwithdraw 9328,9330,10819 >> Withdraw the following items from your bank: 
    >>Super Snapper FX 
    >>Snapshot of Gammerita 
    >>Wildkin Feather
step
    #sticky
    #label cloth1
    .goto Ironforge,43.22,31.57
     >> Do the Gnomeregan cloth turn ins, you'll need 3 stacks of each
    .turnin 7807 >> Turn in A Donation of Wool
    .turnin 7808 >> Turn in A Donation of Silk
    .turnin 7809 >> Turn in A Donation of Mageweave
step
    #sticky
    #label cloth2
    .goto Ironforge,43.22,31.57
     >> Do the Ironforge cloth turn ins, you'll need 3 stacks of each
    .turnin 7802 >> Turn in A Donation of Wool
    .turnin 7803 >> Turn in A Donation of Silk
    .turnin 7804 >> Turn in A Donation of Mageweave
step
    #completewith end
     >>Look for the courier that walks around Ironforge
     >>Skip this quest if you can't find the courier
    .accept 5090 >> Accept A Call to Arms: The Plaguelands!
    .unitscan COURIER HAMMERFALL
step
    #requires cloth1
step
    #requires cloth2
    #sticky
    #label slime
    .goto Ironforge,75.4,23.0
    .accept 4512 >> Accept A Little Slime Goes a Long Way
step
    #requires cloth2
    .goto Ironforge,71.83,16.12
    .turnin 3182 >> Turn in Proof of Deed
    .accept 3201 >> Accept At Last!
step
    .goto Ironforge,71.83,16.12
    .turnin 3368 >> Turn in Suntara Stones
step
    #requires slime
    .goto Ironforge,77.54,11.82
    .accept 3448 >> Accept Passing the Burden
step <<  Warlock
    #som
    .goto Ironforge,51.10,6.60
    .accept 8419 >> Accept An Imp's Request
step <<  Warlock
    #era
    #phase 4
    .goto Ironforge,51.10,6.60
    .accept 8419 >> Accept An Imp's Request
step
    .goto Ironforge,30.96,4.82
    .turnin 3448 >> Turn in Passing the Burden
    .accept 3449 >> Accept Arcane Runes
    .accept 3450 >> Accept An Easy Pickup
step
    .goto Ironforge,18.10,51.60
    .home >> Set your HS to Ironforge
step <<  Hunter
    #era
    #phase 4
    .goto Ironforge,70.90,83.60
    .accept 8151 >> Accept The Hunter's Charm
step <<  Hunter
    #som
    .goto Ironforge,70.90,83.60
    .accept 8151 >> Accept The Hunter's Charm
step
    .goto Ironforge,70.86,94.56
    .turnin 3450 >> Turn in An Easy Pickup
    .accept 3451 >> Accept Signal for Pickup
    .turnin 3451 >> Turn in Signal for Pickup
step
     #completewith next
    .fly Loch Modan >> Fly to Loch Modan
step
    .goto Badlands,16.73,8.64
    .turnin 3201 >> Turn in At Last!
step
     #completewith next
    .fly Hinterlands>> Fly to The Hinterlands
step
    .goto The Hinterlands,14.83,44.56
    .turnin 2877 >> Turn in Skulk Rock Clean-up
    .turnin 2989 >> Turn in The Altar of Zul
step
    .fly Western Plaguelands>> Fly to Western Plaguelands
]])

RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance

#name 51-52 WPL
#next 52-52 Felwood

step
     #completewith next
    .goto Tirisfal Glades,98.54,95.59
    .turnin 5066 >> Turn in A Call to Arms: The Plaguelands!
    .turnin 5090 >> Turn in A Call to Arms: The Plaguelands!
    .turnin 5091 >> Turn in A Call to Arms: The Plaguelands!
step
    .goto Western Plaguelands,42.70,84.03
    .accept 5092 >> Accept Clear the Way
step
    .goto Western Plaguelands,50.80,77.80
    .complete 5092,1
    .complete 5092,2
step
    .goto Western Plaguelands,42.70,84.03
    .turnin 5092 >> Turn in Clear the Way
    .accept 5215 >> Accept The Scourge Cauldrons
step
    .goto Western Plaguelands,42.97,84.50
    .turnin 5215 >> Turn in The Scourge Cauldrons
    .accept 5216 >> Accept Target: Felstone Field
step
    .goto Western Plaguelands,37.17,56.94
     >> Kill the cauldron lord
    .complete 5216,1
step
    .goto Western Plaguelands,37.24,56.78
     >> Click on the cauldron
    .turnin 5216 >> Turn in Target: Felstone Field
    .accept 5217 >> Accept Return to Chillwind Camp
step
    .goto Western Plaguelands,38.40,54.05
     >> Talk to Janice Felstone inside the farm house
    .accept 5021 >> Accept Better Late Than Never
step
    .goto Western Plaguelands,38.72,55.24
     >> Click on the parcel inside the barn
    .turnin 5021 >> Turn in Better Late Than Never
    .accept 5022 >> Accept Better Late Than Never
step <<  Hunter
    .xp 52-16950 >> Grind until you are 16950 XP away from 52 
    >>If you are not yet close, do one more cauldron quest to get you where you need to be
step
    #completewith next
    .deathskip >> Die and spirit rez at Chillwind Camp
step
    .goto Western Plaguelands,42.97,84.50
    .turnin 5217 >> Turn in Return to Chillwind Camp
step << !Mage
    .fly Wetlands>> Fly to Wetlands
]])

RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance

#name 52-52 Felwood
#next 52-53 Feralas

step << Mage
    .trainer >> Teleport to Ironforge and train skills
step << !Mage
     #completewith next
    .zone Darkshore >> Take the boat to Darkshore
step << !Mage
    .goto Darkshore,37.0,44.0
    .home >> Set your Hearthstone to Auberdine
step << !Mage
    .fly Teldrassil>> Fly to Teldrassil
step << !Mage
    .goto Teldrassil,55.49,92.04
    .turnin 3661 >> Turn in Favored of Elune?
step << !Mage
    #completewith next
    .goto Teldrassil,55.49,92.04
    .accept 978 >> Accept Moontouched Wildkin
    >>Skip this step if you're not yet level 52
step << !Mage
    .goto Teldrassil,55.41,92.23
    .turnin 2944 >> Turn in The Super Snapper FX
    .accept 2943 >> Accept Return to Troyas
step
    #sticky
    .bankdeposit 12724,10444,10445 >> Deposit the follwing items: 
    >>Janice's Parcel 
    >>Flare gun 
    >>Drawing kit
step
    #sticky
    .bankwithdraw 9368,11466,8594,11133,11912,11316 >> Withdraw the following items: 
    >>Jer'kai's Signet Ring 
    >>Raschal's Report 
    >>Insect Analysis Report 
    >>Linken's Training Sword 
    >>Package of Empty Ooze Containers 
    >>Bloodpetal
step << !Paladin !Warlock !Mage
    #sticky
    .trainer >> Train skills
step << !Mage
    .zone Darnassus >> Teleport to Darnassus
step
    #sticky
    .vendor >> Restock on supplies, long grinding session ahead
step <<  Hunter
    #sticky
    .goto Darnassus,42.44,7.36
    .accept 8151 >> Accept The Hunter's Charm
step
    .goto Teldrassil,25.90,64.74
    .turnin 162 >> Turn in Rise of the Silithid
    .accept 4493 >> Accept March of the Silithid
step
    .goto Teldrassil,25.90,64.74
    .turnin 4267 >> Turn in Rise of the Silithid
step
    .goto Teldrassil,25.33,63.90
    .turnin 2972 >> Turn in Doling Justice
step << !Mage
    .goto Teldrassil,55.49,92.04
     >> If you are not yet level 52, skip this step
    .accept 978 >> Accept Moontouched Wildkin
step << Mage
    .goto Teldrassil,55.49,92.04
    .turnin 3661 >> Turn in Favored of Elune?
step << Mage
    #sticky
    #label q52
    .goto Teldrassil,55.49,92.04
    .accept 978 >> Accept Moontouched Wildkin
    >>Skip this step if you're not yet level 52
step << Mage
    .goto Teldrassil,55.41,92.23
    .turnin 2944 >> Turn in The Super Snapper FX
    .accept 2943 >> Accept Return to Troyas
step << Mage
    #requires q52
    .fly Darkshore>> Fly to Darkshore
step << Mage
    .home >> Set your Hearthstone to Auberdine
step
     #completewith next
    .fly >> Fly to Azshara
step
    .goto Azshara,11.36,78.16
    .accept 5535 >> Accept Spiritual Unrest
    .accept 5536 >> Accept A Land Filled with Hatred
step
    #sticky
    #label unrest
    .goto Azshara,16.5,68.0,0
     >> Do Spiritual Unrest
    .complete 5535,1
    .complete 5535,2
step
    .goto Azshara,20.09,61.79
     >> Do A Land Filled with Hatred 
    >>Make sure to prioritize satyrs
    .complete 5536,1
    .complete 5536,2
    .complete 5536,3
step
    #requires unrest
    .goto Azshara,11.36,78.16
    .turnin 5535 >> Turn in Spiritual Unrest
    .turnin 5536 >> Turn in A Land Filled with Hatred
step
     #completewith next
    .zone Felwood >> Head to Felwood
step
    .goto Felwood,54.14,86.83
    .accept 4101 >> Accept Cleansing Felwood
step
    .goto Felwood,50.92,85.00
    .accept 8460 >> Accept Timbermaw Ally
step
    .goto Felwood,51.21,82.10
     >> Run to the Emerald Sanctuary
    .accept 5155 >> Accept Forces of Jaedenar
    .accept 5156 >> Accept Verifying the Corruption
    .accept 4421 >> Accept The Corruption of the Jadefire
step
    .goto Felwood,40.77,66.86
     >> Kill slimes, use the Ooze jar on their corpses
    .complete 4512,1
step <<  Warlock
    #era
    #phase 4
    #sticky
    #label felcloth
     >> Kill satyrs
    .complete 8419,1
step <<  Warlock
    #som
    #sticky
    #label felcloth
     >> Kill satyrs
    .complete 8419,1
step
    .goto Felwood,32.27,67.05
     >> Do The Corruption of the Jadefire
    .complete 4421,1
    .complete 4421,2
    .complete 4421,3
    .complete 4421,4
step <<  Warlock
    #requires felcloth
    #era
    #phase 4
    .goto Winterspring,5.91,66.03
    .turnin 8419 >> Turn in An Imp's Request
    .accept 8421 >> Accept The Wrong Stuff
step <<  Warlock
    #requires felcloth
    #som
    .goto Winterspring,5.91,66.03
    .turnin 8419 >> Turn in An Imp's Request
    .accept 8421 >> Accept The Wrong Stuff
step <<  Warlock
    #phase 4
    #era
    .goto Winterspring,6.69,68.57
     >> Kill Tainted Oozes
    .complete 8421,2
step <<  Warlock
    #som
    .goto Winterspring,6.69,68.57
     >> Kill Tainted Oozes
    .complete 8421,2
step
     #completewith next
     >> Kill slimes, use the Ooze jar on their corpses
    .complete 4512,2
step
    .goto Felwood,38.45,60.72
     >> Do Forces of Jaedenar
    .complete 5155,1
    .complete 5155,2
    .complete 5155,3
    .complete 5155,4
step
    .goto Felwood,40.48,59.07
     >> Finish off A Little Slime Goes a Long Way
    .complete 4512,2
step
    .goto Felwood,51.21,82.10
    .turnin 5155 >> Turn in Forces of Jaedenar
    .accept 5157 >> Accept Collection of the Corrupt Water
step
    .goto Felwood,51.34,81.50
    .turnin 4421 >> Turn in The Corruption of the Jadefire
step
    .goto Felwood,51.34,81.50
    .accept 4906 >> Accept Further Corruption
step
    .goto Felwood,50.88,81.61
    .accept 5156 >> Accept Verifying the Corruption
step
    .goto Felwood,50.92,85.00
    .accept 8460 >> Accept Timbermaw Ally
step
    .goto Felwood,48.93,90.22
    .complete 8460,1
    .complete 8460,2
    .complete 8460,3
step
    .goto Felwood,50.92,85.00
    .turnin 8460 >> Turn in Timbermaw Ally
    .accept 8462 >> Accept Speak to Nafien
step
    #era
    #sticky
    .goto Felwood,48.93,90.22
    .reputation 576,Unfriendly
step
    .goto Felwood,35.16,59.77
     >> Fill the empty canteen at the Jaedenar moonwell
    .complete 5157,1
step
    .goto Felwood,44.03,40.20
     >> Kill fire elementals, be careful with the elite infernals roaming the place
    .complete 5156,1
    .complete 5156,2
    .complete 5156,3
step
    .goto Felwood,39.07,22.31
     >> Kill Xavaric, loot his flute and right click it
    .complete 4906,4
    .accept 939 >> Accept Flute of Xavaric
step
    .goto Felwood,41.81,19.36
     >> Kill Satyrs
    .complete 4906,1
    .complete 4906,2
    .complete 4906,3
    .complete 939,1
step <<  Warlock
    .goto Winterspring,12.64,45.66
     >> Kill Irontree mobs
    .complete 8421,1
step
    .goto Felwood,56.10,17.00
     >> Kill Warpwood mobs inside the cave
    .complete 4101,1
step
    #softcore
     #completewith next
    .vendor >> Vendor stuff, you're about to spirit rez 3 times on the upcoming segment
step
    .goto Felwood,62.50,24.24
    .fp Felwood>> Get the Felwood FP
step
    .goto Felwood,64.76,8.12
    .turnin 8462 >> Turn in Speak to Nafien
step
    .goto Winterspring,27.76,34.59
    .zone Winterspring >> Enter the furbolg tunnel and take the east exit into Winterspring
    *Depending on your reputation standing, the npcs guarding the tunnel will attack you, if that's the case, be careful to not fall into the pit at the tunnel intersection
step
    .goto Winterspring,31.26,45.16
    .turnin 3908 >> Turn in It's a Secret to Everybody
    .accept 3909 >> Accept The Videre Elixir
step
    .goto Winterspring,43.78,43.39
     >> Look for Moontouched feathers on the ground 
    >>Skip this step if you don't have this quest
    .complete 978,1
    .isOnQuest 978
step
     #completewith next
     .deathskip >> Die and spirit rez at Everlook
step <<  Hunter
     #completewith next
    .goto Winterspring,60.38,37.92
    .stable >> Stable your pet
step
    .goto Winterspring,62.2,36.6
    .fly Felwood>> Fly to Felwood
step <<  Hunter
    .goto Felwood,61.7,18.7,0
    .train 17267 >> Tame a Felpaw Ravager, learn bite 7
step
     #completewith next
    .deathskip >> Death warp to the graveyard
step <<  Hunter
     #completewith next
     .goto Felwood,49.1,36.4,0
    .train 2977 >> Tame an Ironbeak Hunter or Angerclaw Mauler and learn claw 7
step <<  Warlock
    #phase 4
    #era
    .goto Winterspring,5.91,66.03
    .turnin 8421 >> Turn in The Wrong Stuff
step <<  Warlock
    #som
    .goto Winterspring,5.91,66.03
    .turnin 8421 >> Turn in The Wrong Stuff
step
     #completewith next
    .goto Felwood,40.84,66.78
     >> Run south to the slime pond 
    .deathskip >>Death warp to southern felwood
step
    #softcore
    .goto Felwood,54.14,86.83
    .turnin 4101 >> Turn in Cleansing Felwood
step
    #softcore
    .goto Winterspring,16.27,99.89
     >> Speak to the quest giver and make sure you have a Cenarion Beacon
    .collect 11511,1
step
    .goto Felwood,51.21,82.10
    .turnin 5157 >> Turn in Collection of the Corrupt Water
    .accept 5158 >> Accept Seeking Spiritual Aid
step
    .goto Felwood,51.34,81.50
    .turnin 939 >> Turn in Flute of Xavaric
    .accept 4441 >> Accept Felbound Ancients
    .turnin 4906 >> Turn in Further Corruption
step
    .goto Felwood,50.88,81.61
    .turnin 5156 >> Turn in Verifying the Corruption
step
    #hardcore
    .goto Felwood,54.14,86.83
    .turnin 4101 >> Turn in Cleansing Felwood
step
    #hardcore
    .goto Winterspring,16.27,99.89
     >> Speak to the quest giver and make sure you have a Cenarion Beacon
    .collect 11511,1
step
    .hs >> Hearth to Darkshore
	>> Buy food/water if needed
step
    .fly Feathermoon>> Fly to Feathermoon
]])

RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance

#name 52-53 Feralas
#next 53-53 Azshara

step <<  Hunter
    #completewith start
    .stable >> Withdraw your pet from the stables
step
    .goto Feralas,30.63,42.70
    .accept 7733 >> Accept Improved Quality
step
    .home >> Set your HS to Feathermoon
step
    .goto Feralas,31.78,45.50
    .turnin 2943 >> Turn in Return to Troyas
    .accept 2879 >> Accept The Stave of Equinex
step
    #label start
    .goto Feralas,44.81,43.42
     >> Swim to the mainland
    .accept 7003 >> Accept Zapped Giants
    .accept 7721 >> Accept Fuel for the Zapping
step
    .goto Feralas,46.12,62.73
    >>Use the giant zapper to kill the sea giants along the coast
     >> Kill water elementals
    .complete 7003,1
    .complete 7721,1
step
    .goto Feralas,44.81,43.42
    .turnin 7003 >> Turn in Zapped Giants
    .turnin 7721 >> Turn in Fuel for the Zapping
step
    #completewith next
     >> Keep an eye out for a pristine yeti hide while you kill them (rare drop)
     .collect 18969,1,7735
    .accept 7735 >> Accept Pristine Yeti Hide
step
    .goto Feralas,54.84,32.84
     >> Kill Yetis
    .complete 7733,1
step
    .goto Feralas,45.12,25.56
    .turnin 4142 >> Turn in A Visit to Gregan
step
    .goto Feralas,45.12,25.56
     >> Buy some bait from Gregan
    .collect 11141,1,3909,1
step
    .goto Feralas,42.38,21.99
    .accept 2844 >> Accept The Giant Guardian
step
    .goto Feralas,44.64,10.59
     >> Give the bait you just purchased to the gnoll guarding the Evoroot to gain access to it
    .collect 11242,1,3909,1
step
    #completewith next
     >> Loot all 4 flames
     .collect 9257,1,2879,1
     .goto Feralas,40.6,12.6
     .collect 9258,1,2879,1
     .goto Feralas,38.5,15.8
     .collect 9255,1,2879,1
     .goto Feralas,37.8,12.1
     .collect 9256,1,2879,1
     .goto Feralas,39.9,9.5
step
    .goto Feralas,38.88,13.13
    >>Right click on Troyas' Staff at the monolith
    .complete 2879,1
step
    .goto Feralas,38.82,13.17
     >> Click on the monolith
    .turnin 2879 >> Turn in The Stave of Equinex
    .accept 2942 >> Accept The Morrow Stone
step
    #completewith next
     + Grind harpies until your HS cooldown is <8 minutes
step
    #completewith next
    .goto Feralas,38.22,10.29
    .turnin 2844 >> Turn in The Giant Guardian
step
    .goto Feralas,38.22,10.29
    >>Start the escort quest
    .accept 2845 >> Accept Wandering Shay
step
    .goto Feralas,38.25,10.29
     >> Loot the chest next to the quest giver
    .complete 2845,1
step
    .goto Feralas,42.38,22.00
     >> Escort Shay
    .complete 2845,2
step
    .goto Feralas,42.38,21.99
    .turnin 2845 >> Turn in Wandering Shay
step
    .goto Feralas,45.12,25.56
     >> Talk to Gregan and trade in the Evoroot
    .complete 3909,1
step
    #era
    #phase 2
     #completewith next
    .deathskip >> Die and respawn at the Dire Maul graveyard, hug the side wall until the General chat channel changes to dire maul, this is a pre-requisite for a moonglade quest later
step
    #som
     #completewith next
    .deathskip >> Die and respawn at the Dire Maul graveyard, hug the side wall until the General chat channel changes to dire maul, this is a pre-requisite for a moonglade quest later
step
    .hs >> Hearth back to Feathermoon
	>> Buy food/water if needed
step << !Mage
    #completewith end2
    +Make sure you buy food/water before flying off
    >>Long grinding session ahead
    >>Make sure to buy extra stacks of ammo<< Hunter
step
    .goto Feralas,31.78,45.50
    .turnin 2942 >> Turn in The Morrow Stone
step
    #completewith end2
    .turnin 7735 >> Turn in Pristine Yeti Hide
    .isOnQuest 7735
step
    .goto Feralas,30.63,42.70
    .turnin 7733 >> Turn in Improved Quality
step
    #label end2
    .fly Ratchet>> Fly to Ratchet
]])

RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance

#name 53-53 Azshara
#next 53-54 UnGoro Crater

step
    #sticky
    .bankdeposit 11682,11511,11947,11949 >> Deposit the follwing items: 
    >>Eridan's Vial 
    >>Cenarion Beacon 
    >>Filled Cursed Ooze Jar 
    >>Filled Tainted Ooze Jar
step
    #sticky
    .bankwithdraw 10445,12906 >> Withdraw the following: 
    >>Drawing Kit 
    >>Flare Gun
step
     >> Make sure you have at least 1 stack of noggenfogger for this next segment, skip this step if you dont have any noggenfogger in your bank
    .collect 8529,20
step
    .goto The Barrens,62.0,39.4
    .home >> Set your HS to Ratchet
step
    .goto The Barrens,63.00,37.20
    .fly Azshara>> Fly to Azshara
step <<  Hunter
    #era
    #phase 4
    .goto Azshara,42.37,42.61
    .turnin 8151 >> Turn in The Hunter's Charm
    .accept 8153 >> Accept Courser Antlers
step <<  Hunter
    #era
    #phase 4
    #sticky
     >> Kill mosshoof coursers as you quest
    .complete 8153,1
step <<  Hunter
    #som
    .goto Azshara,42.37,42.61
    .turnin 8151 >> Turn in The Hunter's Charm
    .accept 8153 >> Accept Courser Antlers
step <<  Hunter
    #som
    #sticky
     >> Kill mosshoof coursers as you quest
    .complete 8153,1
step
    .goto Azshara,53.45,21.82
    .accept 3601 >> Accept Kim'jael Indeed!
step
    .goto Azshara,57.02,29.45
     >> Loot the boxes scattered around the camp
    .complete 3601,1
    .complete 3601,2
    .complete 3601,3
    .complete 3601,4
step
    .goto Azshara,53.45,21.82
    .turnin 3601 >> Turn in Kim'jael Indeed!
    .accept 5534 >> Accept Kim'jael's "Missing" Equipment
step
    #label nagas
    #sticky
    .goto Azshara,37.7,53.3,0
    .goto Azshara,46.2,48.8,0
     >> Kill Sirens/Myrmidons
    .complete 5534,1
step
    .goto Azshara,39.57,50.32
     >> Click on the first monolith
    .complete 3449,2
step
    .goto Azshara,36.95,53.18
     >> Click on the second monolith
    .complete 3449,1
step
    .goto Azshara,39.33,55.42
     >> Click on the third monolith
    .complete 3449,3
step
    .goto Azshara,42.34,64.14
     >> Click on the fourth monolith
    .complete 3449,4
step
    #requires nagas
    .goto Azshara,53.45,21.82
    .turnin 5534 >> Turn in Kim'jael's "Missing" Equipment
step
    #som
    .xp 53.4 >> Grind elves until you are 40% into level 53
step
    #era
    #phase 4
    .xp 53.4 >> Grind elves until you are 40% into level 53
step
    #era
    #phase 1-3
    .xp 54+20000 >> Grind elves to level 54+20k xp
step <<  Hunter
    #som
    .goto Winterspring,71.97,97.87
    .turnin 8153 >> Turn in Courser Antlers
step <<  Hunter
    #era
    #phase 4
    .goto Winterspring,71.97,97.87
    .turnin 8153 >> Turn in Courser Antlers
step
    #completewith next
    .goto Azshara,73.22,87.87,25 >> Go behind the giant statue 
step
    .goto Azshara,77.80,91.32
    >>Use Noggenfoger Elixir until you get the slow fall buff and jump down to the small island east 
    >>Use the flare gun at the landing pad and wait for the quest giver to show up
    .turnin 3449 >> Turn in Arcane Runes
    .accept 3461 >> Accept Return to Tymor
step
    #sticky
    .destroy 10444 >> Destroy the flare gun
step
    .hs >> Hearth to Ratchet
	>> Buy food/water if needed
step
    .goto The Barrens,65.82,43.77
    .turnin 5158 >> Turn in Seeking Spiritual Aid
    .accept 5159 >> Accept Cleansed Water Returns to Felwood
step
    #sticky
    .bankdeposit 10445,12906 >> Deposit the following items: 
    >>Drawing kit 
    >>Purified Moonwell Water
step
    .goto The Barrens,62.44,38.73
    .accept 4502 >> Accept Volcanic Activity
step
    .goto The Barrens,62.50,38.54
     >> Loot the small chest outside the metal hut
    .complete 3444,1
step
    .fly Tanaris>> Fly to Tanaris
]])

RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance

#name 53-54 UnGoro Crater
#next 54-55 Felwood/Winterspring

step
    .goto The Barrens,65.82,43.77
    .turnin 5158 >> Turn in Seeking Spiritual Aid
    .accept 5159 >> Accept Cleansed Water Returns to Felwood
step
    .goto The Barrens,62.44,38.73
    .accept 4502 >> Accept Volcanic Activity
step
    .goto The Barrens,62.50,38.54
     >> Loot the small chest outside the metal hut
    .complete 3444,1
step
    #sticky
    .bankwithdraw 11568,11569,11570,11830,11018,11114,11831 >> Withdraw the follwing items: 
    >>Torwa's Pouch 
    >>Webbed Diemetradon Scale 
    >>Webbed Pterrordax Scale 
    >>Dinosaur Bone
step
    .goto Tanaris,50.88,26.96
    .turnin 4493 >> Turn in March of the Silithid
    .accept 4496 >> Accept Bungle in the Jungle
step
    .goto Tanaris,52.70,45.92
    .turnin 3444 >> Turn in The Stone Circle
step
    .fly Un'Goro>> Fly to Un'Goro
step
    .goto Un'Goro Crater,71.6,76.0
    .accept 4290 >> Accept The Fare of Lar'korwi
    .accept 4289 >> Accept The Apes of Un'Goro
step
	#label ungoroc
	#sticky
    >>Keep questing in Un'Goro until you have the following:
    .accept 3884 >> Williden's Journal
    .complete 4284,1 --Collect Blue Power Crystal (x7)
    .complete 4284,2 --Collect Green Power Crystal (x7)
    .complete 4284,3 --Collect Red Power Crystal (x7)
    .complete 4284,4 --Collect Yellow Power Crystal (x7)
step
    .goto Un'Goro Crater,63.0,68.7
    .accept 3844 >> Accept It's a Secret to Everybody
step
    .goto Un'Goro Crater,63.1,69.0
    .turnin 3844 >> Turn in It's a Secret to Everybody
    .accept 3845 >> Accept It's a Secret to Everybody
step
    .goto Un'Goro Crater,68.8,56.7
    .complete 4290,1 --Collect Piece of Threshadon Carcass (x1)
step
    .goto Un'Goro Crater,71.7,75.9
    .turnin 4290 >> Turn in The Fare of Lar'korwi
    .accept 4291 >> Accept The Scent of Lar'korwi
    .turnin 9063 >> Turn in Torwa Pathfinder << Druid
step
    .goto Un'Goro Crater,67.3,73.1
    .goto Un'Goro Crater,66.6,66.7
    >>Look for raptor nests and step on the eggs to summon the raptors you need to kill
    .complete 4291,1 --Collect Ravasaur Pheromone Gland (x2)
step
    .goto Un'Goro Crater,71.6,75.9
    .turnin 4291 >> Turn in The Scent of Lar'korwi
    .accept 4292 >> Accept The Bait for Lar'korwi
step
    .goto Un'Goro Crater,44.3,11.6
    .accept 4503 >> Accept Shizzle's Flyer
step
    .goto Un'Goro Crater,43.0,9.7
    .accept 4141 >> Accept Muigin and Larion
step
    .goto Un'Goro Crater,43.5,7.5
    .accept 3882 >> Accept Roll the Bones
step
    .goto Un'Goro Crater,44.7,8.2
    .turnin 3845 >> Turn in It's a Secret to Everybody
step
	#requires ungoroc
    .goto Un'Goro Crater,43.9,7.2
    .turnin 3884 >> Turn in Williden's Journal
step
    .goto Un'Goro Crater,43.9,7.2
    .accept 3881 >> Accept Expedition Salvation
    .accept 3883 >> Accept Alien Ecology
step
    .goto Un'Goro Crater,43.6,7.5
    .accept 3882 >> Accept Roll the Bones
step
    .goto Un'Goro Crater,41.9,2.7
    .accept 4284 >> Accept Crystals of Power
    .turnin 4284 >> Turn in Crystals of Power
step
    .goto Un'Goro Crater,41.9,2.6
    .accept 4285 >> Accept The Northern Pylon
    .accept 4287 >> Accept The Eastern Pylon
    .accept 4288 >> Accept The Western Pylon
step
    .goto Un'Goro Crater,43.6,8.4
    .accept 4501 >> Accept Beware of Pterrordax
    .accept 4492 >> Accept Lost!
step << skip
    .goto Un'Goro Crater,43.0,9.7
    .accept 4141 >> Accept Muigin and Larion
step
    .goto Un'Goro Crater,44.2,11.5
    .accept 4503 >> Accept Shizzle's Flyer
step
    .goto Un'Goro Crater,46.4,13.4
    .accept 4243 >> Accept Chasing A-Me 01
step
	#sticky
	#label dinos
	>>Kill any type of Diemetradon
    .complete 3882,1 --Collect Dinosaur Bone (x8)
    .complete 4503,1 --Collect Webbed Diemetradon Scale (x8)
step
	#sticky
	#completewith equipment
	>>Kill Pterrordaxes
	.complete 4503,2 --Collect Webbed Pterrordax Scale (x8)
step
    .goto Un'Goro Crater,56.4,12.4
    .complete 4285,1 --Discover and examine the Northern Crystal Pylon
step
	#sticky
	#label chasingame
    .goto Un'Goro Crater,67.6,16.8
    .turnin 4243 >> Turn in Chasing A-Me 01
step
    .goto Un'Goro Crater,64.0,16.4
    .complete 4289,1 --Collect Un'Goro Gorilla Pelt (x2)
    .complete 4289,2 --Collect Un'Goro Stomper Pelt (x2)
    .complete 4289,3 --Collect Un'Goro Thunderer Pelt (x2)
step << skip
	#requires chasingame
    .goto Un'Goro Crater,67.8,26.3
	>>Kill lashers in northeastern Un'Goro
    .complete 4141,1 --Collect Bloodpetal (x15)
step
	#requires chasingame
    .goto Un'Goro Crater,68.5,36.6
	>>Loot the boxes at the abandoned camp
    .complete 3881,1 --Collect Crate of Foodstuffs (x1)
step
    .goto Un'Goro Crater,77.2,49.8
    .complete 4287,1 --Discover and examine the Eastern Crystal Pylon
step
    .goto Un'Goro Crater,79.8,49.9
	>>Open Torwa's Pouch and place the meat and the pheromone mixture on top of the stone slab lying on the floor to summon Lar'korwi
    .complete 4292,1 --Collect Lar'korwi's Head (x1)
step
    .goto Un'Goro Crater,71.6,75.9
    .turnin 4289 >> Turn in The Apes of Un'Goro
    .accept 4301 >> Accept The Mighty U'cha
    .turnin 4292 >> Turn in The Bait for Lar'korwi
step
    .goto Un'Goro Crater,56.3,90.6
    .goto Un'Goro Crater,44.3,90.4
    .complete 4501,1 --Kill Pterrordax (x10)
step
	#sticky
	#label bungle
	>>Kill silithid mobs
	.complete 4496,1
step
    .goto Un'Goro Crater,48.8,85.3
	>>Enter the silithid hive and use the scraping vial at the center of the circular room
    .complete 3883,1 --Collect Hive Wall Sample (x1)
step
	#requires bungle
	#label equipment
    .goto Un'Goro Crater,38.5,66.1
	>>Loot the boxes at the abandoned camp
    .complete 3881,2 --Collect Research Equipment (x1)
step
    .goto Un'Goro Crater,40.6,48.1,0
	#sticky
	#label Pterrordax
    .complete 4501,2 --Kill Frenzied Pterrordax (x15)
    .complete 4503,2 --Collect Webbed Pterrordax Scale (x8)
step
    .goto Un'Goro Crater,30.9,50.4
    .accept 974 >> Accept Finding the Source
step
    .goto Un'Goro Crater,24.0,59.2
    .complete 4288,1 --Discover and examine the Western Crystal Pylon
step
    .goto Un'Goro Crater,49.7,45.8
	>>Climb to the top of the volcano and use the thermometer at the fiery obelisk
    .complete 974,1 --Find the hottest area of Fire Plume Ridge
step
	#requires Pterrordax
    .goto Un'Goro Crater,30.9,50.4
    .turnin 974 >> Turn in Finding the Source
    .accept 980 >> Accept The New Springs
step
	#requires dinos
    .goto Un'Goro Crater,52.0,50.0
    .turnin 4492 >> Turn in Lost!
    .accept 4491 >> Accept A Little Help From My Friends
step
    .goto Un'Goro Crater,43.6,8.5
    >>Escort Ringo to Marshal's Refuge, use Spraggle's Canteen on him if he faints and stop following you.
    .complete 4491,1
step
    .goto Un'Goro Crater,43.6,8.5
    .turnin 4491 >> Turn in A Little Help From My Friends
step
	.goto Un'Goro Crater,43.6,8.5
    .turnin 4501 >> Turn in Beware of Pterrordax
step
    .goto Un'Goro Crater,43.6,7.5
    .turnin 3882 >> Turn in Roll the Bones
step
    .goto Un'Goro Crater,43.9,7.3
    .turnin 3881 >> Turn in Expedition Salvation
    .turnin 3883 >> Turn in Alien Ecology
step
    .goto Un'Goro Crater,41.8,2.7
    .turnin 4285 >> Turn in The Northern Pylon
    .turnin 4287 >> Turn in The Eastern Pylon
    .turnin 4288 >> Turn in The Western Pylon
    .accept 4321 >> Accept Making Sense of It
    .turnin 4321 >> Turn in Making Sense of It
step << skip
    .goto Un'Goro Crater,43.0,9.6
    .turnin 4141 >> Turn in Muigin and Larion
step
    .goto Un'Goro Crater,44.2,11.6
    .turnin 4503 >> Turn in Shizzle's Flyer
step
    .goto Un'Goro Crater,44.7,8.2
    .accept 3908 >> Accept It's a Secret to Everybody
step
    .goto Un'Goro Crater,68.2,12.6
    >>Kill the named Gorilla at the end of the cave
    .complete 4301,1 --Collect U'cha's Pelt (x1)
step
    .goto Un'Goro Crater,71.6,76.0
    .turnin 4301 >> Turn in The Mighty U'cha
step
     >> Make sure you have 25 Un'Goro Soil before leaving Un'Goro
    .collect 11018,25
step
    #hardcore
    >>Run back to Tanaris
    .goto Tanaris,50.88,26.96
    .turnin 4496 >> Turn in Bungle in the Jungle
step
    .hs >> Hearth to Ratchet 
	>> Buy food/water if needed
--    >>You can also pull a mob, death skip at the Tanaris border and use HS batching in Gadgetzan to save you 5 minutes later on
step
    .goto The Barrens,62.44,38.73
    .turnin 4502 >> Turn in Volcanic Activity
step
    #sticky
    .bankwithdraw 11682,12906,11511,12383 >> Withdraw the following: 
    >>Eridan's vial 
    >>Purified Moonwell Water 
    >>Cenarion beacon 
    >>Moontouched Feathers
step
    .fly Teldrassil>> Fly to Teldrassil
step
    .goto Teldrassil,55.49,92.04
    .accept 978 >> Accept Moontouched Wildkin
step
    .goto Teldrassil,55.49,92.04
     >> Skip this step if you just got this quest (Moontouched Wildkin)
    .turnin 978 >> Turn in Moontouched Wildkin
    .isQuestComplete 978
step
    .goto Teldrassil,55.49,92.04
    .accept 979 >> Accept Find Ranshalla
    .isQuestTurnedIn 978
step
    .goto Teldrassil,55.41,92.23
     >> Run upstairs
    .accept 5250 >> Accept Starfall
step
    #sticky
    #label herald
    >>Find Herald Moonstalker, she walks around Darnassus
    .accept 1047 >> Accept The New Frontier
    .unitscan Herald Moonstalker
step
    #completewith end
    .goto Darnassus,63.8,22.8,0
     >> Do the Darnassus cloth turn ins, you'll need 3 stacks of each cloth
    .turnin 7792 >> Turn in A Donation of Wool
    .turnin 7798 >> Turn in A Donation of Silk
    .turnin 7799 >> Turn in A Donation of Mageweave
    .turnin 7800 >> Turn in A Donation of Runecloth
step
    #completewith end
    .vendor  >> Buy food/water before flying off to Felwood
step
    .goto Darnassus,39.19,85.12
     >> Use Eridan's Vial at the fountain inside the temple
    .complete 4441,1
step
    .goto Darnassus,67.38,15.68
    .accept 3763 >> Accept Assisting Arch Druid Staghelm
step
    #requires herald
    .goto Darnassus,34.81,9.25
    .turnin 3763 >> Turn in Assisting Arch Druid Staghelm
    .accept 3764 >> Accept Un'Goro Soil
step
    #requires herald
     #completewith next
    .goto Darnassus,34.81,9.25
    .turnin 1047 >> Turn in The New Frontier
step
    #requires herald
    .goto Darnassus,34.81,9.25
    .accept 6761 >> Accept The New Frontier
step
    .goto Darnassus,31.48,8.23
     >> Jump down to the ground level, just outside the tree house
    .turnin 3764 >> Turn in Un'Goro Soil
step
    .goto Darnassus,34.81,9.25
     >> Run upstairs and speak with the Arch Druid
    .accept 3781 >> Accept Morrowgrain Research
step
     #completewith next
    .goto Darnassus,35.37,8.40
     >> Run down to the middle floor, speak with Mathrengyl Bearwalker
    .turnin 6761 >> Turn in The New Frontier
step
    .goto Darnassus,35.37,8.40
    .accept 6762 >> Accept Rabine Saturna
step
    .goto Darnassus,35.37,8.40
    .turnin 3781 >> Turn in Morrowgrain Research
step
    #label end
    .goto Darnassus,30.41,41.40
    .zone Teldrassil >> Exit Darnassus and go back to Ruth'theran Village
step
    .goto Teldrassil,58.4,94.0
    .fly Felwood>> Fly to Felwood
]])




RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance

#name 54-55 Felwood/Winterspring
#next 55-56 Winterspring

step
    #sticky
    #label shards
     >> Kill mobs in felwood
    .collect 11515,6,5882,1
step
    .goto Felwood,51.34,81.50
     >> Go inside the small hut and turn in Felbound Ancients first
    .turnin 4441 >> Turn in Felbound Ancients
step
    .goto Felwood,51.21,82.10
    .turnin 5159 >> Turn in Cleansed Water Returns to Felwood
    .accept 5165 >> Accept Dousing the Flames of Protection
step
    .goto Felwood,51.34,81.50
    .accept 4442 >> Accept Purified!
    .turnin 4442 >> Turn in Purified!
step
    #requires shards
    .goto Felwood,54.20,86.80
    .accept 5882 >> Accept Salve via Hunting
    .turnin 5882 >> Turn in Salve via Hunting
step
	#sticky
	#completewith brazier
	.goto Felwood,35.38,58.66,50 >> Head to Shadow Hold, Jaedenar's underground lair
step
	#sticky
	#label redkey
    .goto Felwood,36.2,55.6,0
    >>Grind mobs inside the Shadow Hold
	.collect 13140,1,5202
	>>Click on the key to accept the quest
    .accept 5202 >> Accept A Strange Red Key
step
	#sticky
	#requires redkey
	#label eStart
    .goto Felwood,36.2,55.5,0
	>>Start the escort quest
    .turnin 5202 >> Turn in A Strange Red Key
    .accept 5203 >> Accept Rescue From Jaedenar
step
	#sticky
	#requires eStart
	#label escortEnd
    .complete 5203,1 --Protect Arko'narin out of Shadow Hold
    >>Once you get close to the last brazier and Arko'narin gets hold of her equipment, 3 felguards will spawn, be careful
step
	#label brazier
    .goto Felwood,36.3,56.2
    .complete 5165,1 --Collect Extinguish the Brazier of Pain (x1)
step
    .goto Felwood,36.5,55.1
    .complete 5165,4 --Collect Extinguish the Brazier of Hatred (x1)
step
    .goto Felwood,36.7,53.3
    .complete 5165,3 --Collect Extinguish the Brazier of Suffering (x1)
step
    .goto Felwood,37.6,52.7
    .complete 5165,2 --Collect Extinguish the Brazier of Malice (x1)
step
    #requires escortEnd
    .goto Felwood,49.55,29.71
     >> Stop by the northern graveyard, right click on the flute of the ancients and start the escort quest 
    .accept 4261 >> Accept Ancient Spirit
step
     >> Escort Arei
    .complete 4261,1
step
    .goto Felwood,64.76,8.12
    .accept 8461 >> Accept Deadwood of the North
step
    .goto Felwood,62.59,11.16
    .complete 8461,1
    .complete 8461,2
    .complete 8461,3
step
    .goto Felwood,64.76,8.12
    .turnin 8461 >> Turn in Deadwood of the North
    .accept 8465 >> Accept Speak to Salfa
step
    .goto Felwood,68.30,6.07
     >> Run to Winterspring
    .turnin 8465 >> Turn in Speak to Salfa
    .accept 8464 >> Accept Winterfall Activity
step
    .goto Winterspring,31.26,45.16
    .turnin 3909 >> Turn in The Videre Elixir
step
    #softcore
    .goto Winterspring,31.26,45.16
    .accept 3912 >> Accept Meet at the Grave
step
    .goto Winterspring,31.26,45.16
    .turnin 980 >> Turn in The New Springs
    .accept 4842 >> Accept Strange Sources
    .accept 5082 >> Accept Threat of the Winterfall
step
    #sticky
    #label furbolgs
    .goto Winterspring,30.59,36.04
    .complete 5082,1
    .complete 5082,2
    .complete 5082,3
step
    .goto Winterspring,67.17,35.52,0
     >> Kill furbolgs until you get an Empty Firewater Flask
     .collect 12771,1,5083
    .accept 5083 >> Accept Winterfall Firewater
step
    #requires furbolgs
    .goto Winterspring,31.26,45.16
    .turnin 5082 >> Turn in Threat of the Winterfall
    .turnin 5083 >> Turn in Winterfall Firewater
    .accept 5084 >> Accept Falling to Corruption
step
    .goto Felwood,60.2,5.9
     >>Run back to Felwood
     >> Click on the cauldron guarded by a bunch of furbolgs
     >>You don't need to kill all of them, you can create an escape route, click on the cauldron and run away
    .turnin 5084 >> Turn in Falling to Corruption
    .accept 5085 >> Accept Mystery Goo
step
    .goto Winterspring,31.26,45.16
     >> Run back to Winterspring
    .turnin 5085 >> Turn in Mystery Goo
    .accept 5086 >> Accept Toxic Horrors
step
    .goto Winterspring,43.78,43.39
     >> Look for blue feathers on the ground
    .complete 978,1
    .isOnQuest 978
step <<  Hunter
     #completewith next
    .deathskip >> Die and respawn at Everlook
step <<  Hunter
     #completewith next
    .fly Teldrassil>> Fly to Teldrassil
step <<  Hunter
    .goto Teldrassil,55.49,92.04
    .turnin 978 >> Turn in Moontouched Wildkin
    .accept 979 >> Accept Find Ranshalla
    .isQuestTurnedIn 3661
step
    .hs >> Hearth to Ratchet
    >> Buy food/water if needed
step
    #softcore
    .fly Tanaris>> Fly to Tanaris
    .zoneskip Tanaris
step
    #softcore
    .goto Tanaris,51.56,26.75
    .accept 4504 >> Accept Super Sticky
step
    #softcore
    .goto Tanaris,50.88,26.96
    .turnin 4496 >> Turn in Bungle in the Jungle
step
    #softcore
     #completewith next
    .goto Tanaris,53.81,29.06,0
    .goto Tanaris,53.81,29.06,40,0
    .cast 14050 >> Use the Videre Elixir at the Tanaris graveyard, just east of Gadgetzan
step
    #softcore
    .goto Tanaris,53.93,23.33
     >> Speak to the ghost just north of the graveyard, you can only see him while dead
    .turnin 3912 >> Turn in Meet at the Grave
    .accept 3913 >> Accept A Grave Situation
step
    #softcore
    .goto Tanaris,53.81,29.06
     >> Click on the Conspicuous Gravestone
    .turnin 3913 >> Turn in A Grave Situation
    .accept 3914 >> Accept Linken's Sword
step
    #softcore
    .fly Un'Goro>> Fly to Un'Goro
step
    #softcore
    .goto Un'Goro Crater,44.65,8.09
    .turnin 3914 >> Turn in Linken's Sword
    .accept 3941 >> Accept A Gnome's Assistance
step
    #softcore
    .goto Un'Goro Crater,41.91,2.69
    .turnin 3941 >> Turn in A Gnome's Assistance
    .accept 3942 >> Accept Linken's Memory
step
    #softcore
    .goto Tanaris,16.71,16.13
    .complete 4504,1
step
    #softcore
    .fly Tanaris>> Fly to Tanaris
step
    #softcore
    .goto Tanaris,51.56,26.75
    .turnin 4504 >> Turn in Super Sticky
step
    .fly Azshara>> Fly to Azshara
step
    .goto Ashenvale,85.23,44.71
     >> Run to Ashenvale
    .turnin 4261 >> Turn in Ancient Spirit
step
    #sticky
    .destroy 11445 >> Throw away the Flute of the Ancients
step
    .goto Felwood,54.15,86.84
    .accept 5882 >> Accept Salve via Hunting
    .turnin 5882 >> Turn in Salve via Hunting
step
    .goto Felwood,51.21,82.10
    .turnin 5165 >> Turn in Dousing the Flames of Protection
    .accept 5242 >> Accept A Final Blow
step
    .goto Felwood,51.34,82.01
    .turnin 5203 >> Turn in Rescue From Jaedenar
    .accept 5204 >> Accept Retribution of the Light
step
    #softcore
    .goto Winterspring,14.00,95.58
    .turnin 3942 >> Turn in Linken's Memory
    .accept 4084 >> Accept Silver Heart
step
    #softcore
    #completewith next
     >> Kill Bears/Wolves as you go through Felwood
    .complete 4084,1
step
	#sticky
	#completewith next
	.goto Felwood,35.38,58.66,50 >> Head to Shadow Hold, Jaedenar's underground lair
step
    .goto Felwood,38.49,50.40
    >>Kill the succubus next to the ritual circle
    .complete 5204,1
step
    .goto Felwood,38.49,50.40
    .turnin 5204 >> Turn in Retribution of the Light
    .accept 5385 >> Accept The Remains of Trey Lightforge
step
    .goto Felwood,38.86,46.79
     >> Go deeper into the Shadow Hold
    .complete 5242,1
    .complete 5242,2
    .complete 5242,3
step
    #softcore
    #sticky
    #label silverheart
     >> Finish off Bears/Wolves
    .complete 4084,1
step << Rogue/Warrior --Weapon upgrade
    .goto Felwood,51.21,82.10
    .turnin 5242 >> Turn in A Final Blow
step << Rogue/Warrior
    .goto Felwood,51.34,82.01
    .turnin 5385 >> Turn in The Remains of Trey Lightforge
step
    .goto Felwood,49.52,25.10
    >>Kill water elementals
    .complete 5086,1
step
    #softcore
    .goto Winterspring,12.64,45.66
     >> Kill Irontree Stompers
    .complete 4084,2
step
    #requires silverheart
    .goto Felwood,65.40,7.10,30 >> Go to Winterspring through the furbolg tunnel
    .zoneskip Winterspring
step
    #requires silverheart
    .goto Winterspring,31.26,45.16
     >> Run to Winterspring
    .turnin 5086 >> Turn in Toxic Horrors
    .accept 5087 >> Accept Winterfall Runners
step
    #sticky
    #completewith end
     >> Look for winterfall runners as you quest
    .complete 5087,1
    .unitscan WINTERFALL RUNNER
step
    .goto Winterspring,51.97,30.38
    .turnin 5250 >> Turn in Starfall
    .accept 5244 >> Accept The Ruins of Kel'Theril
step
    .goto Winterspring,52.13,30.42
    .accept 4861 >> Accept Enraged Wildkin
    .turnin 5244 >> Turn in The Ruins of Kel'Theril
    .accept 5245 >> Accept Troubled Spirits of Kel'Theril
step
    #label end
    .goto Winterspring,50.88,41.71
    >>Click on the patch of ice on top of the frozen lake
    .complete 5245,2
step
    .goto Winterspring,52.42,41.50
    .complete 5245,4
step
    .goto Winterspring,53.30,43.43
    .complete 5245,3
step
    .goto Winterspring,55.13,42.98
    .complete 5245,1
]])

RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance

#name 55-56 Winterspring
#next 56-57 Burning Steppes

step
    .goto Winterspring,61.30,38.90
    .home >> Set your Hearthstone to Everlook
step
    #sticky
    .bankdeposit 15788,15790,17355,11511,11172,11173,13562,13207,12891,12896,12897,12898,12899 >> Deposit the following items: 
    >>Everlook report 
    >>Studies in spirit speaking 
    >>Rabine's Letter 
    >>Cenarion Beacon 
    >>Silvery Claws  << !Rogue !Warrior
    >>Irontree Heart  << !Rogue !Warrior
    >>Remains of Trey Lightforge  << !Rogue !Warrior
    >>Shadow Lord Fel'dan's Head << !Rogue !Warrior
    >>Jaron's Pick 
    >>All 4 Relics
step <<  Hunter
    .goto Winterspring,61.91,38.29
    .accept 969 >> Accept Luck Be With You
step
    #sticky
    #completewith next
     >> Look for winterfall runners as you quest
    .complete 5087,1
    .unitscan WINTERFALL RUNNER
step
    .goto Winterspring,67.08,35.48
     >> Finish off Winterfall Activity 
    >>Abandon this quest if the village is too crowded
    .complete 8464,1
    .complete 8464,2
    .complete 8464,3
step
    .goto Winterspring,58.99,59.78
     >> Click on the damaged crate, be careful with the level 59 owlkins that roam the area
    .turnin 4861 >> Turn in Enraged Wildkin
    .accept 4863 >> Accept Enraged Wildkin
step
    .goto Winterspring,61.44,60.67
    .turnin 4863 >> Turn in Enraged Wildkin
    .accept 4864 >> Accept Enraged Wildkin
step
    .goto Winterspring,61.40,60.72
     >> Click on the small crate next to Jaron's Wagon
    .complete 4864,1
step
     #sticky
     #label amulet
    .goto Winterspring,65.49,60.50
     >> Kill Owlbeasts 
    .complete 4864,2
step <<  Hunter
    #completewith next
    .goto Winterspring,63.07,59.47
    .turnin 979 >> Turn in Find Ranshalla
step << Hunter
    >>Kill the high level mobs from the thicket before starting the escort quest
    .accept 4901 >> Accept Guardians of the Altar
step <<  !Hunter
    .goto Winterspring,63.07,59.47
    .turnin 979 >> Turn in Find Ranshalla
     >> Skip the follow up
    .isOnQuest 979
step <<  Hunter
     >> Escort Ranshalla 
    >>Click on the torches once she gets inside one of the caves 
    >>Right click the stone altar at the end
    .complete 4901,1
step <<  Hunter
    #requires amulet
    #sticky
     >> Loot the blue crystals around the outer perimeter of the canyon, use your pet to bait the giants away from the crystals
    >>This is a hard quest to solo, skip this quest if you have to
    .complete 969,1
    .link https://www.twitch.tv/videos/850027450?t=00h26m14s >> Click here for video reference
step
    #requires amulet
    .goto Winterspring,59.52,75.23
     >> Run south to Darkwhisper Gorge
    .complete 4842,1
step
    .hs >> Hearth to Everlook
    >> Buy food/water if needed
step
    .goto Winterspring,61.34,38.97
    .accept 6030 >> Accept Duke Nicholas Zverenhoff
    .accept 6028 >> Accept The Everlook Report
    .accept 5601 >> Accept Sister Pamela
step <<  Hunter
    .goto Winterspring,61.91,38.29
    .turnin 969 >> Turn in Luck Be With You
    .isQuestComplete 969
step
    .goto Winterspring,52.13,30.42
    .turnin 4864 >> Turn in Enraged Wildkin
step
    .goto Winterspring,53.14,34.68
     >> Find the Winterfall Runners, they patrol the road between winterfall village and the furbolg tunnel west
     >> Use eagle eye to find them << Hunter
    .complete 5087,1
    .unitscan WINTERFALL RUNNER
step
    .goto Winterspring,31.26,45.16
    .turnin 4842 >> Turn in Strange Sources
    .turnin 5087 >> Turn in Winterfall Runners
    .accept 5121 >> Accept High Chief Winterfall
step
    .goto Felwood,68.30,6.07
    .turnin 8464 >> Turn in Winterfall Activity
    .isOnQuest 8464
step
     #completewith next
    .deathskip >> Die and respawn at the graveyard
step
     #completewith next
     .goto Winterspring,62.2,36.6
    .fly Teldrassil>> Fly to Teldrassil
step <<  !Hunter
    .goto Teldrassil,55.49,92.04
    .turnin 978 >> Turn in Moontouched Wildkin
    .accept 979 >> Accept Find Ranshalla
step <<  Hunter
    .goto Teldrassil,55.49,92.04
    .turnin 4901 >> Turn in Guardians of the Altar
    .accept 4902 >> Accept Wildkin of Elune
step <<  Hunter
    #sticky
    .bankwithdraw 10445,11947,11949,12724,10575 >> Withdraw the following: 
    >>Drawing Kit 
    >>Filled Cursed Ooze Jar 
    >>Filled Tainted Ooze Jar 
    >>Janice's Parcel 
    >>Black Dragonflight Molt
step <<  Hunter
    #sticky
    .trainer >> Train skills
step <<  Hunter
    .goto Teldrassil,24.44,48.86
    .turnin 4902 >> Turn in Wildkin of Elune
step
    .goto Teldrassil,58.4,94.0
    .fly Darkshore>> Fly to Darkshore
step
    .goto Darkshore,32.4,43.8
    .zone Wetlands >> Take the boat to Wetlands
step
    .goto Wetlands,9.49,59.70
    .fly Ironforge>> Fly to Ironforge
]])

RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance

#name 56-57 Burning Steppes
#next 57-59 Western/Eastern Plaguelands

step <<  !Hunter
    #sticky
    .bankwithdraw 10445,11947,11949,12724,10575 >> Withdraw the following: 
    >>Drawing Kit 
    >>Filled Cursed Ooze Jar 
    >>Filled Tainted Ooze Jar 
    >>Janice's Parcel 
    >>Black Dragonflight Molt
step
    .goto Ironforge,75.76,23.38
    .turnin 4512 >> Turn in A Little Slime Goes a Long Way
step
    .goto Ironforge,30.96,4.82
    .turnin 3461 >> Turn in Return to Tymor
step
    .goto Ironforge,18.54,51.66
    .home >> Set your HS to Ironforge
step
    .goto Ironforge,38.36,55.30
    .accept 3702 >> Accept The Smoldering Ruins of Thaurissan
step
    .goto Ironforge,38.36,55.30
     >> Listen to her story
    .complete 3702,1
    .skipgossip 
step
    .goto Ironforge,38.36,55.30
    .turnin 3702 >> Turn in The Smoldering Ruins of Thaurissan
    .accept 3701 >> Accept The Smoldering Ruins of Thaurissan
step
    .fly Burning Steppes>> Fly to Burning Steppes
step
    .goto Burning Steppes,84.55,68.67
    .accept 3823 >> Accept Extinguish the Firegut
step
    .goto Burning Steppes,84.55,68.67
    .accept 4283 >> Accept FIFTY! YEP!
step
    .goto Burning Steppes,85.82,68.94
    .accept 4182 >> Accept Dragonkin Menace
step
    .goto Burning Steppes,82.80,37.40
     >> Finish off Extinguish the Firegut
    .complete 3823,1
    .complete 3823,2
    .complete 3823,3
step
    .goto Burning Steppes,84.55,68.67
    .turnin 3823 >> Turn in Extinguish the Firegut
step
    .goto Burning Steppes,84.55,68.67
    .accept 3824 >> Accept Gor'tesh the Brute Lord
step
    #sticky
    .goto Burning Steppes,95.09,31.56
     >> Skip this step if you don't have the Black Dragonflight Molt
    .accept 4022 >> Accept A Taste of Flame
    .turnin 4022 >> Turn in A Taste of Flame
step
    .goto Burning Steppes,65.23,24.00
    .accept 4726 >> Accept Broodling Essence
    .accept 4296 >> Accept Tablet of the Seven
step
    #sticky
    #label broodlings
     >> Kill broodlings as you go along, use the quest item when they get low
    .complete 4726,1
step
    #softcore
    .goto Burning Steppes,85.4,27.4,0
    .goto Burning Steppes,88.8,37.6,0
    .goto Burning Steppes,93.4,56.2,0
    .goto Burning Steppes,78.2,62.6,0
    .goto Burning Steppes,56.8,61.0,0
     >> Prioritize killing broodlings over anything else
    .complete 4182,1
    .complete 4182,2
    .complete 4182,3
    .complete 4182,4
    >>This is a hard quest solo but it's worth a lot of xp in the end, try to find a group or skip this quest if you're struggling with it
step << !Warrior !Paladin !Rogue
    #hardcore
    .goto Burning Steppes,85.4,27.4,0
    .goto Burning Steppes,88.8,37.6,0
    .goto Burning Steppes,93.4,56.2,0
    .goto Burning Steppes,78.2,62.6,0
    .goto Burning Steppes,56.8,61.0,0
     >> Prioritize killing broodlings over anything else
    .complete 4182,1
    .complete 4182,2
    .complete 4182,3
    .complete 4182,4
    .isOnQuest 4182
    >>This is a very hard quest solo, skip this quest if you have to.
step
    #requires broodlings
    #label q3701
    #sticky
    .goto Burning Steppes,57.4,36.4,0
     >> Right click on the small stone obelisks on the ground near the dwarf ruins
    .complete 3701,1
step
    #requires broodlings
    .goto Burning Steppes,54.06,40.71
     >> Transcribe the tablet
    .complete 4296,1
    .skipgossip 
step
    #requires q3701
    #label gortesh
    #sticky
    .goto Burning Steppes,38.89,54.73
    >>Gor'tesh hits very hard and has a thrash attack, be careful
    .complete 3824,1
step
    #requires q3701
    .goto Burning Steppes,41.25,34.71
     >> Kill Orcs
    .complete 4283,1
step
    #requires gortesh
    .goto Burning Steppes,85.82,68.94
    .turnin 4182 >> Turn in Dragonkin Menace
    .isQuestComplete 4182
step
    .goto Burning Steppes,85.82,68.94
    .accept 4183 >> Accept The True Masters
    .isQuestTurnedIn 4182
step
    .goto Burning Steppes,84.55,68.67
    .turnin 4283 >> Turn in FIFTY! YEP!
    .turnin 3824 >> Turn in Gor'tesh the Brute Lord
    .accept 3825 >> Accept Ogre Head On A Stick = Party
step
    #completewith next
    .fly Redridge>> Fly to Redridge Mountains
step
    .goto Redridge Mountains,29.98,44.45
    .turnin 4183 >> Turn in The True Masters
    .accept 4184 >> Accept The True Masters
    .isQuestTurnedIn 4182
step
    .fly Stormwind>> Fly to Stormwind
step << Paladin
    #phase 4
    #era
    .goto Stormwind City,37.2,33.1
    .accept 8415 >>Accept Chillwind Camp
step << Paladin
    #som
    .goto Stormwind City,37.2,33.1
    .accept 8415 >>Accept Chillwind Camp
step
    .goto Stormwind City,48.46,30.54
    .turnin 5022 >> Turn in Better Late Than Never
    .isOnQuest 5022
step
    .goto Stormwind City,48.46,30.54
    .accept 5048 >> Accept Good Natured Emma
    .isQuestTurnedIn 5022
step
    .goto Stormwind City,52.48,41.95
     >> Find Ol'Emma, she can roam around SW from time to time
    .turnin 5048 >> Turn in Good Natured Emma
    .accept 5050 >> Accept Good Luck Charm
    .unitscan Ol' Emma
    .isQuestTurnedIn 5022
step
    .goto Stormwind City,78.22,17.97
    .accept 6182 >> Accept The First and the Last
step
    .goto Stormwind City,78.22,17.97
    .turnin 4184 >> Turn in The True Masters
    .accept 4185 >> Accept The True Masters
    .isQuestTurnedIn 4182
step
     >> Speak with Lady Katrana Prestor and go through her whole dialogue
    .complete 4185,1
    .skipgossip
    .isQuestTurnedIn 4182
step
    .goto Stormwind City,78.22,17.97
    .turnin 4185 >> Turn in The True Masters
    .isQuestTurnedIn 4182
step
    .goto Stormwind City,78.22,17.97
    .accept 4186 >> Accept The True Masters
    .isQuestTurnedIn 4182
step
    .goto Stormwind City,75.77,59.84
    .turnin 6182 >> Turn in The First and the Last
    .accept 6183 >> Accept Honor the Dead
    .turnin 6183 >> Turn in Honor the Dead
    .accept 6184 >> Accept Flint Shadowmore
step
    #completewith next
    .fly Redridge>> Fly to Redridge Mountains
step
    .goto Redridge Mountains,29.98,44.45
    .turnin 4186 >> Turn in The True Masters
    .accept 4223 >> Accept The True Masters
    .isQuestTurnedIn 4182
step
    .fly Burning Steppes>> Fly to Burning Steppes
    .zoneskip Burning Steppes
step
    .goto Burning Steppes,84.74,69.01
    .turnin 4223 >> Turn in The True Masters
    .accept 4224 >> Accept The True Masters
    .isQuestTurnedIn 4182
step
    .goto Burning Steppes,65.23,24.00
    .turnin 4726 >> Turn in Broodling Essence
    .accept 4808 >> Accept Felnok Steelspring
    .turnin 4296 >> Turn in Tablet of the Seven
step
     >> Talk to Ragged John
    .complete 4224,1
    .skipgossip
    .isQuestTurnedIn 4182
step
    .goto Burning Steppes,81.04,46.71
     >> Click on the dirt mound on top of the mountain
    .complete 3825,1
step
    .goto Burning Steppes,84.55,68.67
    .turnin 3825 >> Turn in Ogre Head On A Stick = Party
step
    .goto Burning Steppes,84.74,69.01
    .turnin 4224 >> Turn in The True Masters
    .isQuestTurnedIn 4182
step << Druid
    .trainer >>Teleport to Moonglade and train your level 56 spells
step
    .hs >> Hearth to Ironforge
    >> Buy food/water if needed
step << !Druid
	#sticky
	#completewith end
	.trainer >> Train your level 56 spells
step
    #sticky
    .bankwithdraw 15788,15790,12891,12896,12897,12898,12899 >> Withdraw the follwing items: 
    >>Everlook report 
    >>Studies in spirit speaking 
    >>4 relic fragments and Jaron's pick
step
    #sticky
    .bankdeposit 12438 >> Deposit Tinkee's Letter in your bank
step << !Priest !Mage
     >> Make sure you have 2 stacks of noggenfogger with you, having slow fall will save you about 5+ minutes later on
     >>Skip this step if you don't have any in your bank
    .collect 8529,40
step << Priest/Mage
    >> Make sure you have some light feathers for the next segment, having Slow Fall will save you about 5+ minutes later on << Mage
    >> Make sure you have some light feathers for the next segment, having Levitate will save you about 5+ minutes later on << Priest
    .collect 17056,5
step
    #sticky
    .goto Ironforge,43.22,31.57
     >> Do the Gnomeregan cloth turn ins
    .turnin 7807 >> Turn in A Donation of Wool
    .turnin 7808 >> Turn in A Donation of Silk
    .turnin 7809 >> Turn in A Donation of Mageweave
    .turnin 7811 >> Turn in A Donation of Runecloth
step
    #sticky
    .goto Ironforge,43.22,31.57
     >> Do the Ironforge cloth turn ins
    .turnin 7802 >> Turn in A Donation of Wool
    .turnin 7803 >> Turn in A Donation of Silk
    .turnin 7804 >> Turn in A Donation of Mageweave
    .turnin 7805 >> Turn in A Donation of Runecloth
step
    .goto Ironforge,38.36,55.30
    .turnin 3701 >> Turn in The Smoldering Ruins of Thaurissan
]])

RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance

#name 57-59 Western/Eastern Plaguelands
#next 59-59 Winterspring/Silithus part 1

step << Paladin
    #phase 4
    .goto Stormwind City,37.2,33.1
    .accept 8415 >>Accept Chillwind Camp
step
    .goto Stormwind City,48.8,30.6
    .turnin 5022 >> Turn in Better Late Than Never
    .isOnQuest 5022
step
    .goto Stormwind City,48.8,30.6
    .accept 5048 >> Accept Good Natured Emma
    .isQuestTurnedIn 5022
step
    .goto Stormwind City,52.3,41.1
    >>Find Ol'Emma, she walks around Stormwind
    .turnin 5048 >> Turn in Good Natured Emma
    .accept 5050 >> Accept Good Luck Charm
    .isQuestTurnedIn 5022
step
    .goto Stormwind City,78.1,18.0
    .accept 6182 >> Accept The First and the Last
step
    .goto Stormwind City,78.1,18.0
    >>Skip this step if you're not level 56
    .accept 6182 >> Accept The First and the Last
step
    .goto Stormwind City,75.9,59.8
    >>Skip this step if you're not level 56
    .turnin 6182 >> Turn in The First and the Last
    .accept 6183 >> Accept Honor the Dead
    .turnin 6183 >> Turn in Honor the Dead
    .accept 6184 >> Accept Flint Shadowmore
step
	#label sshore
    .fly Southshore>> Fly to Southshore
step
    .goto Hillsbrad Foothills,51.17,58.93
    .home >> Set your Hearthstone to Southshore
step
    .goto Hillsbrad Foothills,49.34,52.27
    .fly Western Plaguelands>> Fly to Western Plaguelands
step << Paladin
    #phase 4
    #era
    .goto Western Plaguelands,42.8,84.1
    .turnin 8415 >>Turn in Chillwind Camp
    .accept 8414 >>Accept Dispelling Evil
step << Paladin
    #phase 4
    #era
    .goto Western Plaguelands,43.0,83.6
    >>Make sure you have the Argent Dawn Trinket
    .collect 12846,1
step << Paladin
    #phase 4
    #era
    #label sstones
    #sticky
    >>Equip the Arget Dawn trinket and kill undead mobs
    .complete 8414,1
step << Paladin
    #som
    .goto Western Plaguelands,42.8,84.1
    .turnin 8415 >>Turn in Chillwind Camp
    .accept 8414 >>Accept Dispelling Evil
step << Paladin
    #som
    .goto Western Plaguelands,43.0,83.6
    >>Make sure you have the Argent Dawn Trinket
    .collect 12846,1
step << Paladin
    #som
    #label sstones
    #sticky
    >>Equip the Arget Dawn trinket and kill undead mobs
    .complete 8414,1
step
    .goto Western Plaguelands,42.7,84.1
    .accept 5092 >> Accept Clear the Way
step
    .goto Western Plaguelands,50.3,79.0
    .complete 5092,1 --Kill Skeletal Flayer (x10)
    .complete 5092,2 --Kill Slavering Ghoul (x10)
step
    .goto Western Plaguelands,42.7,84.0
    .turnin 5092 >> Turn in Clear the Way
    .accept 5215 >> Accept The Scourge Cauldrons
step
    .goto Western Plaguelands,43.0,84.4
    .turnin 5215 >> Turn in The Scourge Cauldrons
    .accept 5216 >> Accept Target: Felstone Field
step
    .goto Western Plaguelands,37.3,56.8
    .turnin 5216 >> Turn in Target: Felstone Field
    .accept 5217 >> Accept Return to Chillwind Camp
step
    .goto Western Plaguelands,42.9,84.5
    .turnin 5217 >> Turn in Return to Chillwind Camp
step
    .goto Western Plaguelands,42.9,84.5
    .accept 5219 >> Accept Target: Dalson's Tears
step
    .goto Western Plaguelands,42.8,84.0
    .accept 5097 >> Accept All Along the Watchtowers
step
    .goto Western Plaguelands,43.0,83.6
    .turnin 6028 >> Turn in The Everlook Report
step
    .goto Western Plaguelands,43.4,84.8
    .accept 5903 >> Accept A Plague Upon Thee
step
    .goto Western Plaguelands,43.6,84.5
    .turnin 6184 >> Turn in Flint Shadowmore
    .accept 6185 >> Accept The Eastern Plagues
step
    .goto Western Plaguelands,46.6,71.2
	>>Use the beacon torch in your bags
    .complete 5097,4 --Tower Four marked
step
    .goto Western Plaguelands,53.7,64.7
    .accept 4984 >> Accept The Wildlife Suffers Too
step
    #label wolves
    #sticky
    .goto Western Plaguelands,49.2,58.4,0
    .goto Western Plaguelands,51.6,47.6,0
    .goto Western Plaguelands,43.0,48.2,0
    .goto Western Plaguelands,43.4,57.8,0
    .goto Western Plaguelands,46.6,40.4,0
	>>The Diseased Wolves share spawns with Carrion Lurkers. Kill them too if you're unable to find Wolves.
    .complete 4984,1 --Kill Diseased Wolf (x8)
step
    .goto Western Plaguelands,47.8,50.8
	>>Click on the diary inside the barn
    .turnin 5058 >> Turn in Mrs. Dalson Diary
step
	#completewith lockedaway
	#label outhousekey
    .goto Western Plaguelands,46.9,51.5,0
	>>Look for the Wandering Skeleton that patrols the area around the farmhouse
    .collect 12738,1,5060,1 --Collect Dalson Outhouse Key (x1)
    .unitscan Wandering Skeleton
step
    .goto Western Plaguelands,46.2,52.1
    >>Kill the cauldron lord and loot his key
    .turnin 5219 >> Turn in Target: Dalson's Tears
    .accept 5220 >> Accept Return to Chillwind Camp
step
	#requires outhousekey
	#sticky
	#completewith next
    .goto Western Plaguelands,48.2,49.7
    .turnin 5059 >> Turn in Locked Away
step
	#requires outhousekey
    .goto Western Plaguelands,48.2,49.7
	>>Kill Farmer Dalson
    .collect 12739,1,5060,1 --Collect Dalson Cabinet Key (x1)
step
    #label lockedaway
    .goto Western Plaguelands,47.4,49.7
	>>Click on the cabinet at the top floor of the farmhouse
    .turnin 5060 >> Turn in Locked Away
step
	#requires wolves
    .goto Western Plaguelands,38.4,54.1
    .turnin 5050 >> Turn in Good Luck Charm
    .accept 5051 >> Accept Two Halves Become One
    .isQuestTurnedIn 5022
step
	#sticky
	#completewith next
    .goto Western Plaguelands,36.9,58.2
	>>Kill the Jabbering ghoul that walks around the farm
	.collect 12722,1
    .isQuestTurnedIn 5022
step
	>>Right click on the half-charm to combine them
    .complete 5051,1 --Collect Good Luck Charm (x1)
    .isQuestTurnedIn 5022
step
    .goto Western Plaguelands,38.4,54.1
    .turnin 5051 >> Turn in Two Halves Become One
    .isQuestTurnedIn 5022
step
    .goto Western Plaguelands,44.3,63.2
	>>Use the beacon torch in your bags
    .complete 5097,3 --Tower Three marked
step
    .goto Western Plaguelands,42.3,66.2
    .complete 5097,2 --Tower Two marked
step
    .goto Western Plaguelands,40.1,71.6
    .complete 5097,1 --Tower One marked
step
    .goto Western Plaguelands,42.7,84.0
    .turnin 5097 >> Turn in All Along the Watchtowers
    .accept 211 >> Accept Alas, Andorhal
    .accept 5533 >> Accept Scholomance
step
    .goto Western Plaguelands,42.7,83.7
    .turnin 5533 >> Turn in Scholomance
    .accept 5537 >> Accept Skeletal Fragments
step
    .goto Western Plaguelands,42.9,84.4
    .turnin 5220 >> Turn in Return to Chillwind Camp
    .accept 5222 >> Accept Target: Writhing Haunt
step
    .goto Western Plaguelands,53.1,66.0
    .complete 5222,1 --Collect Writhing Haunt Cauldron Key (x1)
step
    .goto Western Plaguelands,53.0,65.7
    .turnin 5222 >> Turn in Target: Writhing Haunt
    .accept 5223 >> Accept Return to Chillwind Camp
step
    .goto Western Plaguelands,53.7,64.7
    .turnin 4984 >> Turn in The Wildlife Suffers Too
    .accept 4985 >> Accept The Wildlife Suffers Too
step
    .goto Eastern Plaguelands,7.6,43.6
    .accept 5542 >> Accept Demon Dogs
    .accept 5543 >> Accept Blood Tinged Skies
    .accept 5544 >> Accept Carrion Grubbage
step
	#label grubs
	#sticky
	>>Kill Carrion Worms
    .complete 5544,1 --Collect Slab of Carrion Worm Meat (x15)
step
	#label fordring1
	#sticky
    .goto Eastern Plaguelands,40.8,68.1,0
    .complete 5543,1 --Kill Plaguebat (x30)
    .complete 5542,1 --Kill Plaguehound Runt (x20)
    
--Fredo: 2/Blightcaller: 4/Turyen: 3/Rutger: 1
  
step
    .goto Eastern Plaguelands,27.2,75.0
	>>Click the skeleton on the ground. Loot it for the Insignia
    .complete 6185,2 --SI:7 Insignia (Fredo) (1)
    .complete 6185,4 --The Blightcaller Uncovered (1)
step
    .goto Eastern Plaguelands,28.8,74.9
	>>Click the skeleton on the ground. Loot it for the Insignia
    .complete 6185,3 --SI:7 Insignia (Turyen) (1)
step
    .goto Eastern Plaguelands,28.8,79.8
	>>Click the skeleton on the ground. Loot it for the Insignia
    .complete 6185,1 --SI:7 Insignia (Rutger) (1)
    
step
    .goto Eastern Plaguelands,36.5,90.8
    .turnin 5601 >> Turn in Sister Pamela
    .accept 5149 >> Accept Pamela's Doll
step
    .goto Eastern Plaguelands,39.2,91.6
    >>Loot the 3 doll parts around Darrowshire and then combine them together
    .complete 5149,1 --Collect Pamela's Doll (x1)
step
    .goto Eastern Plaguelands,36.4,90.9
    .turnin 5149 >> Turn in Pamela's Doll
    .accept 5152 >> Accept Auntie Marlene
    .accept 5241 >> Accept Uncle Carlin
step
	#requires fordring1
    .goto Eastern Plaguelands,52.7,59.1,0
    .goto Eastern Plaguelands,52.7,59.1,120,0
    .complete 5542,2 --Kill Plaguehound (x5)
step
    .goto Eastern Plaguelands,81.4,59.8
    .turnin 6030 >> Turn in Duke Nicholas Zverenhoff
step
    .goto Eastern Plaguelands,81.6,59.3
    .fp Chapel >> Get the Light's Hope Chapel flight path
step
    .goto Eastern Plaguelands,81.4,59.9
    .turnin 5241 >> Turn in Uncle Carlin
    .accept 5211 >> Accept Defenders of Darrowshire
step
    .goto Eastern Plaguelands,79.7,63.6
    .accept 5281 >> Accept The Restless Souls
    .accept 6021 >> Accept Zaeldarr the Outcast
step
	#sticky
	#completewith EPL1
	>>Kill ghouls and then talk to the Darrowshire spirits that spawn from their corpses
	.complete 5211,1
step
    .goto Eastern Plaguelands,53.5,22.1
    .turnin 5245 >> Turn in Troubled Spirits of Kel'Theril
step
    .goto Eastern Plaguelands,34.0,28.1
	>>Look for termite mounds around Plaguewood
    .complete 5903,1 --Collect Plagueland Termites (x100)
step
    .goto Eastern Plaguelands,14.5,33.6
    .turnin 5281 >> Turn in The Restless Souls
step
    .goto Eastern Plaguelands,23.5,37.4
    .complete 5542,3 --Kill Frenzied Plaguehound (x5)
step
	#requires grubs
	#label EPL1
    .goto Eastern Plaguelands,7.6,43.7--825-417
    .turnin 5542 >> Turn in Demon Dogs
    .turnin 5543 >> Turn in Blood Tinged Skies
    .turnin 5544 >> Turn in Carrion Grubbage
    .accept 5742 >> Accept Redemption
step
    .goto Eastern Plaguelands,7.6,43.7
    >>Go through his whole dialogue
    .complete 5742,1 --Tirion's Tale
    .skipgossip
step
    .goto Eastern Plaguelands,7.6,43.7
    .turnin 5742 >> Turn in Redemption
    .accept 5781 >> Accept Of Forgotten Memories
step
    .goto Eastern Plaguelands,27.4,84.9
    >>Enter the troll crypt
    .complete 6021,1 --Collect Zaeldarr's Head (x1)
step
    .goto Eastern Plaguelands,27.3,85.2
    >>Click on the scroll on the ground
    .accept 6024 >> Accept Hameya's Plea
step
    .goto Eastern Plaguelands,28.4,86.6
    >>Summon Mercutio and his goons by clicking on the dirt pile, you have to kill him while handling 3 other adds
    >>This quest can be very hard, skip it if you have to
    .complete 5781,1 --Collect Taelan's Hammer (x1)
step
    .goto Eastern Plaguelands,7.6,43.7
    .turnin 5781 >> Turn in Of Forgotten Memories
    .isQuestComplete 5781
step
    .goto Eastern Plaguelands,7.6,43.7
    .accept 5845 >> Accept Of Lost Honor
    .isQuestTurnedIn 5781
step
    .hs >> Hearth to Southshore
    >> Buy food/water if needed
step
    .fly Western Plaguelands>> Fly to Western Plaguelands
step
    .goto Western Plaguelands,43.0,84.5
    .turnin 5223 >> Turn in Return to Chillwind Camp
    .accept 5225 >> Accept Target: Gahrron's Withering
step
    .goto Western Plaguelands,43.4,84.8
    .turnin 5903 >> Turn in A Plague Upon Thee
    .accept 5904 >> Accept A Plague Upon Thee
step
    .goto Western Plaguelands,43.6,84.6
    .turnin 6185 >> Turn in The Eastern Plagues
    .accept 6186 >> Accept The Blightcaller Cometh
step
    .goto Western Plaguelands,49.2,78.6
    .turnin 5152 >> Turn in Auntie Marlene
    .accept 5153 >> Accept A Strange Historian
step
    .goto Western Plaguelands,49.6,76.8
	>>Loot the gravestone right outside the house
    .complete 5153,1 --Collect Joseph's Wedding Ring (x1)
step << Paladin
    #phase 4
    #requires sstones
    .goto Western Plaguelands,52.0,83.5
    .turnin 8414 >>Turn in Dispelling Evil
    .accept 8416 >>Accept Inert Scourgestones
step
	#sticky
	#label skeletons
    .goto Western Plaguelands,42.4,68.0,0
	>>Kill skeletons in Andorhal
    .complete 5537,1 --Collect Skeletal Fragments (x15)
step
    .goto Western Plaguelands,39.5,66.9
    .turnin 5153 >> Turn in A Strange Historian
    .accept 5154 >> Accept The Annals of Darrowshire
    .accept 4971 >> Accept A Matter of Time
step
	#sticky
	#label parasites
    .goto Western Plaguelands,46.7,62.3
	>>Use the temporal displacer on the grain silos
    .complete 4971,1 --Kill Temporal Parasite (x10)
step
    .goto Western Plaguelands,43.4,69.6
	>>Loot books inside the Andorhal town hall until you get the correct one
	*The correct book's pages has a lighter shade of grey and sometimes the correct book won't spawn
	*If you're unlucky, you have to keep looting bad tomes until a good one spawns
    .complete 5154,1 --Collect Annals of Darrowshire (x1)
step
	#requires parasites
    .goto Western Plaguelands,39.5,66.8
    .turnin 4971 >> Turn in A Matter of Time
    .accept 4972 >> Accept Counting Out Time
    .turnin 5154 >> Turn in The Annals of Darrowshire
    .accept 5210 >> Accept Brother Carlin
step
    .goto Western Plaguelands,41.3,67.1
    >>Look for small lockboxes inside the burnt houses
    .complete 4972,1 --Collect Andorhal Watch (x5)
step
    .goto Western Plaguelands,39.4,66.9
    .turnin 4972 >> Turn in Counting Out Time
step
	#requires skeletons
    .goto Western Plaguelands,42.7,83.9
    .turnin 5537 >> Turn in Skeletal Fragments
step << Paladin
    #phase 4
    .goto Western Plaguelands,42.6,84.1
    .turnin 8416 >>Turn in Inert Scourgestones
step
    .fly Eastern Plaguelands>> Fly to Eastern Plaguelands
step
    #phase 6
    .home >> Set your Hearthstone to Light's Hope Chapel
step
    .goto Eastern Plaguelands,81.5,59.8
    .turnin 5210 >> Turn in Brother Carlin
    .accept 5181 >> Accept Villains of Darrowshire
    .accept 5168 >> Accept Heroes of Darrowshire
step
    .goto Eastern Plaguelands,79.7,63.7
    .turnin 6021 >> Turn in Zaeldarr the Outcast
step
    .goto Eastern Plaguelands,71.3,34.0
    >>Loot the banner underwater
    .complete 5845,1 --Collect Symbol of Lost Honor (x1)
    .isQuestTurnedIn 5781
step
    .goto Eastern Plaguelands,70.8,16.2
    >>Kill Infiltrator Hameya, he walks around the shallow graves
    *Tread carefully, troll scouts will run away and call for help and Shadow Hunters can dismount you
    .complete 6024,1 --Collect Hameya's Key (x1)
step
    .goto Eastern Plaguelands,51.2,49.9
    >>Loot the skull underwater
    .complete 5181,1 --Collect Skull of Horgus (x1)
step
	.goto Eastern Plaguelands,60.6,68.4
	>>Kill ghouls and then talk to the Darrowshire spirits that spawn from their corpses
	.complete 5211,1
step
    .goto Eastern Plaguelands,53.9,65.8
    >>Loot the sword on the ground
    .complete 5181,2 --Collect Shattered Sword of Marduk (x1)
step
    .goto Eastern Plaguelands,28.1,86.1
    .turnin 6024 >> Turn in Hameya's Plea
step
    .goto Eastern Plaguelands,7.6,43.6
    .turnin 5845 >> Turn in Of Lost Honor
    .accept 5846 >> Accept Of Love and Family
    .isQuestTurnedIn 5781
step
	#sticky
    #label bears1
    .goto Western Plaguelands,63.3,49.5,0
	>>The Diseased Grizzlies share spawns with Plague Lurkers. Kill them too if you're unable to find Grizzlies.
    .complete 4985,1 --Kill Diseased Grizzly (x8)
step
    .goto Western Plaguelands,63.8,57.2
    >>Loot the shield on the ground, just outside the barn
    .complete 5168,2 --Collect Redpath's Shield (x1)
step
    .goto Western Plaguelands,62.8,58.7
    .complete 5225,1 --Collect Gahrron's Withering Cauldron Key (x1)
step
    .goto Western Plaguelands,62.9,58.5
    .turnin 5225 >> Turn in Target: Gahrron's Withering
    .accept 5226 >> Accept Return to Chillwind Camp
step
    #requires bears1
    .goto Western Plaguelands,53.7,64.7
    .turnin 4985 >> Turn in The Wildlife Suffers Too
    .accept 4986 >> Accept Glyphed Oaken Branch
step
    .goto Western Plaguelands,48.4,31.9
    .turnin 5904 >> Turn in A Plague Upon Thee
    .accept 6389 >> Accept A Plague Upon Thee
step
    .goto Western Plaguelands,51.9,28.2
    .accept 6004 >> Accept Unfinished Business
step
    .goto Western Plaguelands,51.80,44.25,90,0
    .goto Western Plaguelands,40.53,51.79,90,0
    .goto Western Plaguelands,40.53,51.79,0
    .goto Western Plaguelands,51.80,44.25
    .complete 6004,1 --Scarlet Medic (2)
    .complete 6004,2 --Scarlet Hunter (2)
    .complete 6004,3 --Scarlet Mage (2)
    .complete 6004,4 --Scarlet Knight (2)
step
    .goto Western Plaguelands,51.9,28.1
    .turnin 6004 >> Turn in Unfinished Business
    .accept 6023 >> Accept Unfinished Business
step
    .goto Western Plaguelands,55.1,23.5
    >>Look for the named mob that patrols up and down the tower
    *There is a level 63 elite mob that can spawn at the top of the tower (Scarlet High Clerist), if that's the case just be patient and wait for Durgen to come down
    .complete 6023,2 --Kill Cavalier Durgen (x1)
    .unitscan SCARLET HIGH CLERIST
step
    .goto Western Plaguelands,57.8,36.2
    .complete 6023,1 --Kill Huntsman Radley (x1)
step
    .goto Western Plaguelands,51.9,28.0
    .turnin 6023 >> Turn in Unfinished Business
    .accept 6025 >> Accept Unfinished Business
step
    .goto Western Plaguelands,45.7,18.8
    >>Climb the tower in the middle of the town, you don't need to deal with the elite mobs, just run straight to the top of the tower and jump down
    >>Be careful with the level 61 elite that patrols the town, he is very strong
    >>This quest can be a little difficult, skip it if you have to
    .complete 6025,1 --Climb the Tower
    .link https://www.twitch.tv/videos/680869322?t=00h43m31s >> Click here for video reference
step
    .goto Western Plaguelands,42.5,18.9
    >>Loot the libram inside the town hall
    >>The elite mobs guarding the libram are fairly weak but you will be in serious trouble if you have to fight more than one at a time
    >>Be careful with the level 61 elite that patrols the town, he is very strong
    >>Skip this quest if you have to
    .complete 5168,1 --Collect Davil's Libram (x1)
    .link https://www.twitch.tv/videos/680869322?t=00h51m03s >> Click here for video reference
step
    .goto Western Plaguelands,51.9,28.0
    .turnin 6025 >> Turn in Unfinished Business
    .isQuestComplete 6025
step
    #phase 1-5
    .hs >> Hearth to Southshore
    >> Buy food/water if needed
step
    #phase 1-5
    .goto Hillsbrad Foothills,49.33,52.27
    .fly Western Plaguelands>> Fly to Western Plaguelands
step
    #phase 1-5
    .goto Western Plaguelands,42.9,84.5
    .turnin 5226 >> Turn in Return to Chillwind Camp
step
    #phase 1-5
    .goto Western Plaguelands,42.7,84.0
    .turnin 5237 >> Turn in Mission Accomplished!
step
    #phase 1-5
    .goto Western Plaguelands,43.4,84.8
    .turnin 6389 >> Turn in A Plague Upon Thee
step
    #phase 1-5
    .goto Western Plaguelands,65.7,75.4
    .turnin 5846 >> Turn in Of Love and Family
    .isQuestTurnedIn 5781
step
    #phase 1-5
    .fly Light's Hope>>Fly to Eastern Plaguelands
step
    #phase 6
    .hs >> Hearth to Light's Hope Chapel
    >> Buy food/water if needed
step
    .goto Eastern Plaguelands,81.5,59.8
    .turnin 5181 >> Turn in Villains of Darrowshire
    .turnin 5211 >> Turn in Defenders of Darrowshire
step
    .goto Eastern Plaguelands,81.5,59.8
    .turnin 5168 >> Turn in Heroes of Darrowshire
    .isQuestComplete 5168
step
    #phase 6
    #completewith next
    .fly Western Plaguelands>> Fly to Western Plaguelands
step
    #phase 6
    .goto Western Plaguelands,42.9,84.5
    .turnin 5226 >> Turn in Return to Chillwind Camp
step
    #phase 6
    .goto Western Plaguelands,42.7,84.0
    .turnin 5237 >> Turn in Mission Accomplished!
step
    #phase 6
    .goto Western Plaguelands,43.4,84.8
    .turnin 6389 >> Turn in A Plague Upon Thee
step
    #phase 6
    .goto Western Plaguelands,65.7,75.4
    .turnin 5846 >> Turn in Of Love and Family
    .isQuestTurnedIn 5781
step << !Mage
    #softcore
   >>Use the website unstuck tool to teleport to Stormwind
    >>OR 
     .fly Ironforge>>Fly to Ironforge
     .zoneskip Stormwind City
     .zoneskip Elwynn Forest
step << !Mage
    #hardcore
     .fly Ironforge>>Fly to Ironforge
step
    .zone Stormwind City>>Take tram to Stormwind << !Mage
    .zone Stormwind City>>Teleport to Stormwind << Mage
]])

local events = {"PLAYER_XP_UPDATE","QUEST_LOG_UPDATE"}
local IsQuestFlaggedCompleted = RXP_.IsQuestTurnedIn
local IsQuestComplete = RXP_.IsQuestComplete
local IsOnQuest = C_QuestLog.IsOnQuest
local group = RXPGuides["RestedXP Alliance 50-60"]

function group.xpto60(self,...) --PLAYER_XP_UPDATE,QUEST_LOG_UPDATE
	
    if type(self) == "string" then --on parse
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
			questXP = floor(questXP + (3000 + 7550 + 3000)*xpMod)
		elseif IsQuestFlaggedCompleted(6844) then
			if not IsQuestFlaggedCompleted(6845) then
				questXP = floor(questXP + 7550*xpMod)
			end
			if not IsQuestFlaggedCompleted(1185) then
				questXP = floor(questXP + 3000*xpMod)
			end
		end

		if IsQuestComplete(4507) then --pawn captures queen
			questXP = floor(questXP + (5450 + 550  + 8150)*xpMod)
		elseif IsQuestFlaggedCompleted(4507) then
			if IsOnQuest(4508) then
				questXP = floor(questXP + (550 + 8150) * xpMod )
			elseif not IsQuestFlaggedCompleted(4510) and IsQuestFlaggedCompleted(4508) then
				questXP = floor(questXP + 8150*xpMod)
			end
		end
		
		if IsQuestComplete(4504) then --super sticky
			questXP = floor(questXP + 5450*xpMod)
		end
		
		if IsQuestComplete(4809) then --chillwind horns
			questXP = floor(questXP + 5450*xpMod)
		end
		
		if IsQuestComplete(3962) then --It's dangerous to go alone
			questXP = floor(questXP + 7300*eliteMod)
		end

		if IsQuestComplete(5163) then --Are we there yeti?
			questXP = floor(questXP + 7750*xpMod)
		end

		if IsQuestComplete(5527) then --A Reliquary of Purity
			questXP = floor(questXP + 6600*xpMod)
		end

		if IsOnQuest(4986) then--Glyphed Oaken Branch
			questXP = floor(questXP + 5800*xpMod)
		end
		
		if IsQuestComplete(4901) then --Guardians of the altar
			questXP = floor(questXP + (4800 + 6000)*xpMod)
		end
		
		
		questXP = questXP - 50*(xpMod - 1)
	end
	
	local missingXP = UnitXPMax("player") - UnitXP("player") - questXP
    local level = UnitLevel('player')
    if level == 58 then
        missingXP = missingXP + 209800
    end
    
	if missingXP <= 0 and level == 59 then
		--RXP_.SetElementComplete(self)
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

RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance

#name 59-59 Winterspring/Silithus part 1
#next 59-60 Winterspring/Silithus part 2

step
    #completewith WSstart
    .bankwithdraw 12438 >> Withdraw Tinkee's Letter from your bank
step
    .goto Stormwind City,78.22,17.97
    .turnin 6186 >> Turn in The Blightcaller Cometh
step
    #completewith next
    .goto Stormwind City,44.27,73.99
     >> Do the Stormwind cloth turn ins: 
    .turnin 7791 >> Turn in A Donation of Wool
    .turnin 7793 >> Turn in A Donation of Silk
    .turnin 7794 >> Turn in A Donation of Mageweave
    .turnin 7795 >> Turn in A Donation of Runecloth
step
    #completewith next
    .goto Stormwind City,66.27,62.13
    .fly Booty Bay>> Fly to Booty Bay
step
    .goto Stranglethorn Vale,25.8,73.1
    .zone The Barrens >> Take the Boat to Ratchet
step
    .fly Winterspring >> Fly to Winterspring
step <<  Hunter
    #completewith next
    .stable >> Stable your current pet
step << Hunter
    #sticky
    .train 3666 >> Head to northern winterspring and look for a level 58/59 Owl, learn Claw rank 8
step
    .goto Winterspring,61.30,38.90
    .home >> Set your HS to Everlook
step
    #label WSstart
    .goto Winterspring,61.62,38.61
    .turnin 4808 >> Turn in Felnok Steelspring
    .accept 4809 >> Accept Chillwind Horns
step << !Warrior !Mage
    #som << Paladin
    .goto Winterspring,61.91,38.29
    .accept 969 >> Accept Luck Be With You
step
    .goto Winterspring,60.88,37.61
    .accept 3783 >> Accept Are We There, Yeti?
step
    .goto Winterspring,66.3,42.6
     >> Kill Yetis
    .complete 3783,1
step
    .goto Winterspring,60.88,37.61
    .turnin 3783 >> Turn in Are We There, Yeti?
step
    .goto Winterspring,60.88,37.61
    .accept 977 >> Accept Are We There, Yeti?
step
    #completewith WSend
     >> Kill chillwind chimeras, don't go out of your way to finish this quest
    .complete 4809,1
step
    .goto Winterspring,69.56,38.30
     >> Kill High Chief Winterfall, he is an elite mob followed by 2 adds, proceed with caution, you can kill the adds, reset the fight and deal with him alone
    .complete 5121,1
step
    .goto Winterspring,69.56,38.30
     >> Loot the Crudely-written Log from the High Chief and right click it
    .accept 5123 >> Accept The Final Piece
step
    .goto Winterspring,67.9,41.9
     >> Kill Patriarchs/Matriarchs inside the cave
    .complete 977,1
step
    .goto Winterspring,63.07,59.47
     >> Start the escort quest
    .accept 4901 >> Accept Guardians of the Altar
    .isQuestTurnedIn 979
step
     >> Escort Ranshalla and click on the torches once she enters one of the caves
    .complete 4901,1
step << !Warrior !Mage
    #som << Paladin
    .goto Winterspring,59.06,68.33
     >> Head south to Frowstwhisper Gorge 
    >>Loot the ice shards around the outer perimiter of the canyon
    >>Crowd control the giants guarding the crystals, loot and run away << !Hunter
    >>You can use your pet to bait the giants away from the crystals << Hunter/Warlock
    >>This quest can be HARD, skip this step if you have to
    .complete 969,1
step
    .hs >> Hearth to Everlook
	>> Buy food/water if needed
step
    .goto Winterspring,60.88,37.61
    .turnin 977 >> Turn in Are We There, Yeti?
    .accept 5163 >> Accept Are We There, Yeti?
step
    .goto Winterspring,61.54,38.61
     >> Use the Mechanical Yet on Legacki
    .complete 5163,1
step << !Warrior !Mage
    #som << Paladin
    .goto Winterspring,61.91,38.29
    .turnin 969 >> Turn in Luck Be With You
    .isQuestComplete 969
step
    #sticky
    .bankwithdraw 17355,11172,11173,13562,13207 >> Withdraw from your bank: 
    >>Rabine's Letter 
    >>Silvery Claws 
    >>Irontree Heart 
    >>Remains of Trey Lightforge 
    >>Shadow Lord Fel'dan's Head
step
    .goto Winterspring,31.26,45.16
    .turnin 5121 >> Turn in High Chief Winterfall
    .turnin 5123 >> Turn in The Final Piece
    .accept 5128 >> Accept Words of the High Chief
step << !Druid
     #completewith next
     .goto Moonglade,35.6,73.3
    .zone Moonglade >> Enter the furbolg tunnel and take the north exit into Moonglade
step << Druid
    .zone Moonglade >> Teleport to Moonglade
step
    .goto Moonglade,51.68,45.09
    .turnin 6762 >> Turn in Rabine Saturna
    .accept 1124 >> Accept Wasteland
step
    --?#phase 2
    .goto Moonglade,51.68,45.09
     >> Finish the dialogue with Rabine 
    >>Skip this step if the Dire Maul dialogue is not available
    .accept 5527 >> Accept A Reliquary of Purity
    .skipgossip 
step << !Druid
    #completewith next
    .goto Moonglade,48.13,67.34
    .fp Moonglade >> Get the Moonglade FP
step
    #hardcore
    .goto Moonglade,48.13,67.34
    .fly Talonbranch >> Fly to Felwood
step
    .goto Felwood,49.4,31.0
     >> Head back to the furbolg tunnel
     >>Open your reputation panel, mark "At War" with Timbermaw Hold
    >> Once the General chat changes to Felwood, pull a bunch of furbolgs and die
    .deathskip >> Spirit rez at Irontree Woods
step
    .goto Felwood,40.84,66.78
     >> Run south to the slime pond 
    .deathskip >>Death warp to southern Felwood
step
    .goto Felwood,51.21,82.10
    .turnin 5242 >> Turn in A Final Blow
step
    .goto Felwood,51.34,82.01
    .turnin 5385 >> Turn in The Remains of Trey Lightforge
step
    .goto Winterspring,13.83,95.78
    .turnin 5128 >> Turn in Words of the High Chief
step
    #softcore
    .goto Winterspring,14.00,95.58
    .turnin 4084 >> Turn in Silver Heart
    .accept 4005 >> Accept Aquementas
step
     #completewith next
     >>Pull a mob from Felwood into the Ashenvale border
    .deathskip >> Once the General chat changes to Ashenvale, die and spirit rez at Astranaar
step
    .goto Ashenvale,34.41,47.99
    .fly Tanaris>> Fly to Tanaris
step
    .goto Tanaris,50.88,26.96
    .accept 4507 >> Accept Pawn Captures Queen
step
    .goto Tanaris,51.05,26.87
     >> Use the Mechanical Yeti on Sprinkle
    .complete 5163,2
step
    .goto Tanaris,51.56,26.75
    .accept 4504 >> Accept Super Sticky
step
    #softcore
    .goto Tanaris,70.43,49.93
     >> Head to the pirate area 
    >>Right click on Eridan's Supplies 
    >>Use the book of Aquor to summon Aquementas
    .complete 4005,1
step
    .goto Tanaris,51.01,29.35
    >> Head back to Gadgetzan 
    .fly Un'Goro>>Fly to Un'Goro Crater
step
    #softcore
    .goto Un'Goro Crater,41.91,2.69
    .turnin 4005 >> Turn in Aquementas
    .accept 3961 >> Accept Linken's Adventure
step
    #softcore
    .goto Un'Goro Crater,44.65,8.09
    .turnin 3961 >> Turn in Linken's Adventure
    .accept 3962 >> Accept It's Dangerous to Go Alone
step
    .goto Un'Goro Crater,43.67,9.38
     >> Use the Mechanical Yeti on Quixxil
    .complete 5163,3
step
    .goto Tanaris,16.71,16.13
     >> Finish off Super Sticky
    .complete 4504,1
step
    #softcore
    #sticky
    #label chest
    .goto Un'Goro Crater,50.28,49.98
     >> Click on the chest at the back of the cave
    .complete 3962,2
step
    #softcore
    #sticky
    .goto Un'Goro Crater,50.28,49.98,0
     >> Equip the Silver Totem of Aquementas on your off-hand 
    >>Use it to weaken Blazerunner at the top of the volcano
    .complete 3962,1
step
    #requires chest
	.goto Un'Goro Crater,44.6,81.6
	>>Go deep into the silithid hive and use the quest item provided at the silithid crystal to summon the Hive Queen
	>>Proceed with caution, clear the room before summoning the queen, this quest is hard, you have to deal with 3 waves of 3 mobs and you only have 1 attempt on this quest (so it's optional). Remember to kill mobs outside the room so you can eat/drink after
	*At the last wave, you can ignore the 2 adds, kill the queen and loot the quest item
	.complete 4507,1
step
    #completewith next
    .goto Silithus,88.40,23.81,60,0
    .goto Silithus,88.40,23.81,0
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
     >> Talk to the goblin at the 2nd floor of the inn
    .accept 8277 >> Accept Deadly Desert Venom
step
    #phase 4
    .goto Silithus,51.30,38.20
     >> Click on the wanted poster
    .accept 8283 >> Accept Wanted - Deathclasp, Terror of the Sands
step
    #phase 4
     #completewith next
    .goto Silithus,51.15,38.29
    .turnin 8275 >> Turn in Taking Back Silithus
step
    #phase 4
    .goto Silithus,51.20,38.20
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
    .complete 8280,1
step
    #phase 4
    #sticky
    #completewith s1
     >>Kill Stonelash Scorpids/Sand Skitterers
    .complete 8277,1
    .complete 8277,2
step
    #sticky
    #label spirits
    .goto Silithus,63.53,49.90
     >> Kill spirits around the village, be careful every time a spirit dies it has a chance of spawning a bug
    .complete 1125,1
    .complete 1125,2
step
    .goto Silithus,63.22,55.35
     >> Click on the small urn inside the lodge
    .complete 5527,1
    .isOnQuest 5527
step
    #requires spirits
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
     >>Look for small tablets on the ground
    .complete 8284,1
step
    #phase 4
    .goto Silithus,67.68,41.98
    .complete 8277,1
    .complete 8277,2
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
    #sticky
    #label s2
    .complete 8278,1
    .complete 8278,2
    .complete 8278,3
step
    #phase 4
    #label s3
    #sticky
    .goto Silithus,39.31,53.33,0
     >> Kill Dredge Crusher (x20)
    .complete 8281,1
step
    #phase 4
    .goto Silithus,41.30,88.50
     >> Speak with Rutgar
    .complete 8304,2
step
    #phase 4
    .goto Silithus,40.80,88.80
     >> Speak with Frankal
    .complete 8304,1
step
    #phase 4
    .goto Silithus,45.00,92.20
     >> Collect Deathclasp's Pincer
    .complete 8283,1
step
    #phase 4
    .goto Silithus,67.20,69.70
    .turnin 8285 >> Turn in The Deserter
    .accept 8279 >> Accept The Twilight Lexicon
step
    #phase 4
    #requires s2
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
step
    #phase 4
    .goto Silithus,50.80,33.60
    .turnin 8283 >> Turn in Wanted - Deathclasp, Terror of the Sands
step
    #sticky
    #phase 4
    #sticky
    #label texts
     >> Kill twilight cultists
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
     >> Collect Noggle's Satchel
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
     >> Kill cultists
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
    .fly Tanaris>> Fly to Tanaris
step
    .goto Tanaris,50.88,26.96
    .turnin 4507 >> Turn in Pawn Captures Queen
    .accept 4508 >> Accept Calm Before the Storm
step
    #label end
    .goto Tanaris,51.56,26.75
    .turnin 4504 >> Turn in Super Sticky
]])

RXPGuides.RegisterGuide("RestedXP Alliance 50-60",[[
#classic
<< Alliance

#name 59-60 Winterspring/Silithus part 2

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
    #completewith tanaris
    .fly Tanaris>> Fly to Tanaris
step
    .goto Tanaris,50.88,26.96
    .turnin 4507 >> Turn in Pawn Captures Queen
    .accept 4508 >> Accept Calm Before the Storm
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
    #label horns
     #completewith next
    >>Kill chimeras just north of Everlook
    .complete 4809,1
    .goto Winterspring,60.4,23.2
    .turnin 4809 >> Turn in Chillwind Horns
    .goto Winterspring,61.6,38.6
step
     #completewith horns
     .xpto60 >> Skip the Winterspring quests and turn in the quests you have once you're ready to ding 60
step
    .fly Moonglade>> Fly to Moonglade
step
    .goto Moonglade,44.88,35.60
    .turnin 6844 >> Turn in Umber, Archivist
    .accept 6845 >> Accept Uncovering Past Secrets
step
    .goto Moonglade,51.68,45.09
    .turnin 6845 >> Turn in Uncovering Past Secrets
step
    .goto Moonglade,51.68,45.09
    .turnin 5527 >> Turn in A Reliquary of Purity
step
    .goto Moonglade,44.87,35.62
    .accept 1185 >> Accept Under the Chitin Was...
    .turnin 1185 >> Turn in Under the Chitin Was...
step
    #sticky
    .xpto60 >> Grind Furbolgs in northern felwood until you have enough XP to 60
step
    .fly >> Fly to Teldrassil
step
    .goto Teldrassil,55.49,92.04
    .turnin 4901 >> Turn in Guardians of the Altar
step
    .goto Teldrassil,55.49,92.04
    .accept 4902 >> Accept Wildkin of Elune
step
    .goto Darnassus,41.85,85.64
    .turnin 4508 >> Turn in Calm Before the Storm
    .accept 4510 >> Accept Calm Before the Storm
step
    .goto Darnassus,39.38,42.43
    .turnin 4510 >> Turn in Calm Before the Storm
step
    .goto Teldrassil,24.56,48.68
    .turnin 4986 >> Turn in Glyphed Oaken Branch
step
    .goto Teldrassil,24.44,48.86
    .turnin 4902 >> Turn in Wildkin of Elune
]])