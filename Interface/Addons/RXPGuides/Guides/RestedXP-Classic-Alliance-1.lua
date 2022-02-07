
RXPGuides.RegisterGuide("RestedXP Alliance 20-30",[[
#classic
<< Alliance Hunter
#name 21-23 Ashenvale/Stonetalon
#next 23-24 Wetlands


step
    .goto Ashenvale,34.67,48.83
    .turnin 1008 >> Turn in The Zoram Strand
step
    #era
    .goto Ashenvale,34.67,48.83
    .accept 1134 >> Accept Pridewings of Stonetalon
step <<  Hunter
    .goto Ashenvale,38.6,64.7
     >> Stable your pet 
    .train 2982>>Tame an Ashenvale Bear and learn Claw 3
    .train 17263 >> Tame a Ghostpaw Runner and learn Bite 3
step <<  Hunter
    #completewith start
    .stable  >> Run back to Astranaar and withdraw your main pet from stables
step
    .goto Ashenvale,36.61,49.58
    .turnin 1023 >> Turn in Raene's Cleansing
step
    #sticky
    .destroy 5505 >> Throw away Teronis' Journal 
step
    .goto Ashenvale,37.36,51.79
    .turnin 1034 >> Turn in The Ruins of Stardust
step
    #label start
    .goto Ashenvale,42.50,71.70 
    .zone Stonetalon Mountains >> Head to stonetalon
step
    #era
    #sticky
    #completewith wyv1
     >> Kill all wyverns you encounter
    .complete 1134,1
step
    .goto The Barrens,22.71,12.91
    .turnin 1070 >> Turn in On Guard in Stonetalon
    .accept 1085 >> Accept On Guard in Stonetalon
step
    .goto The Barrens,22.53,13.05
    .turnin 1085 >> Turn in On Guard in Stonetalon
    .accept 1071 >> Accept A Gnome's Respite
step
    .goto The Barrens,22.28,10.86
    .accept 1093 >> Accept Super Reaper 6000
step
    #sticky
    #label sr6000
    .goto The Barrens,23.91,6.24
    >> Look for Operators around Windshear Crag
    .complete 1093,1
    .unitscan Venture Co. Operator
step
    .goto The Barrens,25.86,5.28
    .complete 1071,1
    .complete 1071,2
step
    #requires sr6000
    .goto The Barrens,22.28,10.86
    .turnin 1093 >> Turn in Super Reaper 6000
step
    .goto The Barrens,22.53,13.05
    .turnin 1071 >> Turn in A Gnome's Respite
    .accept 1072 >> Accept An Old Colleague
    .accept 1075 >> Accept A Scroll from Mauren
step
    #era
    #label wyv1
    .xp 22+10000 >> Grind goblins to level 22 + 10k xp
step
    #era
    .goto Ashenvale,18.62,77.42
     >> Finish off killing wyverns
    .complete 1134,1
step
    .goto Ashenvale,4.61,52.55
    .turnin 1056 >> Turn in Journey to Stonetalon Peak
step
    .goto Stonetalon Mountains,36.46,7.24
    .fly Ashenvale >> Fly to Ashenvale
step
    #era
    .goto Ashenvale,34.67,48.83
    .turnin 1134 >> Turn in Pridewings of Stonetalon
step
    .goto Ashenvale,36.61,49.58
    .accept 1025 >> Accept An Aggressive Defense
step <<  Hunter
    .goto Ashenvale,37.36,51.79
    .accept 1035 >> Accept Fallen Sky Lake
step
    #era
    .goto Ashenvale,49.79,67.21
    .accept 1016 >> Accept Elemental Bracers
step <<  Hunter
    #era
     #completewith next
    .goto Ashenvale,50.14,67.94
    .trainer  >> Train skills
step
    #era
     >> Loot 5 Intact Elemental Bracers
    .collect 12220,5,1016,1
step
    #era
     >> Right click the Divining Scroll
    .complete 1016,1
step
    #era
    .goto Ashenvale,49.79,67.21
    .turnin 1016 >> Turn in Elemental Bracers
step
    .goto Ashenvale,54.05,62.83
    .complete 1025,1
    .complete 1025,2
    .complete 1025,3
    .complete 1025,4
step <<  Hunter
    .goto Ashenvale,66.67,82.18
     >> Kill the level 30 Oracle sitting in the middle of the lake island
    >>This quest can be hard, kite him along the road east
    .complete 1035,1
step
     #completewith next
    .zone Azshara >> Run east to Azshara
step
    .goto Azshara,11.90,77.57
    .fp Azshara>> Get the Azshara flight path
step
    .hs >> Hearth to Astranaar
	>> Buy food/water if needed
step
    .goto Ashenvale,36.61,49.58
    .turnin 1025 >> Turn in An Aggressive Defense
step
    .goto Ashenvale,39.54,36.47
     >> Kill Dal Bloodclaw
    .complete 1054,1
    .unitscan DAL BLOODCLAW
step
    .goto Ashenvale,25.27,60.68
     >> Kill Ilkrud Magthrull if you haven't done this quest yet
    .complete 973,1
    .isOnQuest 973
step
    .goto Ashenvale,26.19,38.69
    .turnin 973 >> Turn in The Tower of Althalaxx
step
	#softcore
    #completewith next
     .deathskip >> Death warp to Astranaar
step
	#softcore
	.goto Ashenvale,36.61,49.58
    .turnin 1054 >> Turn in Culling the Threat
step
	#hardcore
	>>Run to Astranaar
    .goto Ashenvale,36.61,49.58
    .turnin 1054 >> Turn in Culling the Threat
step <<  Hunter
    .goto Ashenvale,37.36,51.79
    .turnin 1035 >> Turn in Fallen Sky Lake
    .isQuestComplete 1035
step
    .goto Ashenvale,34.40,48.00
    .fly Darkshore>>Fly to Darkshore
step
    .goto Darkshore,33.70,42.45
     >> Level first aid/cooking while waiting for the Menethil boat
    .zone Wetlands >> Take the boat to Menethil Harbor
]])

RXPGuides.RegisterGuide("RestedXP Alliance 20-30",[[
#classic
<< Alliance Hunter
#name 23-24 Wetlands
#next 24-27 Duskwood/Redridge

step
    .goto Wetlands,8.54,55.73
    .accept 484 >> Accept Young Crocolisk Skins
step
    .goto Wetlands,8.30,58.53
    .accept 279 >> Accept Claws from the Deep
step << NightElf
    .goto Wetlands,9.49,59.70
    .fp >> Get the Wetlands Flight Path
step
    .goto Wetlands,10.89,59.66
    .accept 288 >> Accept The Third Fleet
    .accept 463 >> Accept The Greenwarden
step << !NightElf
    .goto Wetlands,10.70,60.95
    .home >> Set your Hearth to Menethil Harbor
     >> Buy a Flagon of Mead from the Innkeeper
    .complete 288,1
step
    .goto Wetlands,10.84,60.43
     >> Go upstairs, turn in The Absent Minded Prospector
    .turnin 942 >> Turn in The Absent Minded Prospector
    .accept 943 >> Accept The Absent Minded Prospector
step
    .goto Wetlands,10.89,59.66
    .turnin 288 >> Turn in The Third Fleet
step << Hunter
    .goto Wetlands,11.5,52.1
    .accept 305 >> Accept In Search of The Excavation Team
step
    #sticky
    .goto Wetlands,10.75,56.75
    .vendor 1448 >> Buy a Bronze Tube at the npc inside the keep
    >>This is a limited supply item, skip this step if he doesn't have it
--    >>You will need 2 bronze tubes for a quest later << Rogue
    .bronzetube
step
    #sticky
    #label crocs
     >> Kill Young Wetlands Crocolisks
    .complete 484,1
step
    .goto Wetlands,18.06,39.83
     >> Kill Murlocs. Keep an eye out for Gobbler
    .complete 279,1
    .complete 279,2
    .unitscan GOBBLER
step
    .goto Wetlands,26.40,25.76
    .vendor >> Look for a Bronze Tube at the gnome npc
    >>This is a limited supply item, skip this step if he doesn't have it
--    >>You will need 2 bronze tubes for a quest later << Rogue
    .bronzetube 
step << Hunter
    .isQuestTurnedIn 942
     #sticky
    #completewith fossil
     >> Kill and loot Raptors in Wetlands
    .complete 943,1
step << Hunter
    .goto Wetlands,38.2,50.9
    .accept 294 >> Accept Ormer's Revenge
step << Hunter
    .goto Wetlands,38.8,52.3
    .turnin 305 >> Turn in In Search of The Excavation Team
    >>Skip the follow-up
step
    .isQuestTurnedIn 942
    .goto Wetlands,38.85,52.20
     >> Loot the fossil on the ground at the back of the cave
    .complete 943,2
step << Hunter
    .goto Wetlands,24.7,48.6
	>>Be careful as Screechers call for help in a 60 yard radius at about 50% health
    .complete 294,1 --Kill Mottled Raptor (x10)
    .complete 294,2 --Kill Mottled Screecher (x10)
step << Hunter
    .goto Wetlands,38.2,50.9
    .turnin 294 >> Turn in Ormer's Revenge
    .accept 295 >> Accept Ormer's Revenge
step << Hunter
    .goto Wetlands,34.6,48.0
    .complete 295,1 --Kill Mottled Scytheclaw (x10)
    .complete 295,2 --Kill Mottled Razormaw (x10)
step << Hunter
    .goto Wetlands,38.2,50.9
    .turnin 295 >> Turn in Ormer's Revenge
    .accept 296 >> Accept Ormer's Revenge
step << Hunter
    .goto Wetlands,33.2,51.5
    .complete 296,1 --Collect Sarltooth's Talon (x1)
step << Hunter
    #label fossil
    .goto Wetlands,38.2,50.9
    .turnin 296 >> Turn in Ormer's Revenge
    >>By the time you finish this quest, if you havent found the stone of Relu from the raptors, skip this quest for now, you'll have another chance to finish that later at level 27
step
    .goto Wetlands,49.91,39.36
    .accept 469 >> Accept Daily Delivery
step
    .goto Wetlands,56.37,40.40
    .turnin 463 >> Turn in The Greenwarden
    .accept 276 >> Accept Tramping Paws
step
    .goto Wetlands,61.91,71.32
     >> Kill Gnolls
    .complete 276,1
    .complete 276,2
step
    #era
    .xp 24 >> Grind to level 24
step
	>>Keep grinding Gnolls until your hearth has <2 minutes left << !NightElf
    .goto Wetlands,56.37,40.40
    .turnin 276 >> Turn in Tramping Paws
    .accept 277 >> Accept Fire Taboo
step << NightElf
     #requires crocs
	#completewith next
	.goto Wetlands,63.9,78.6
	.zone Loch Modan >> Logout on top of the mushrooms at the back of the cave. When you log back in, this will teleport you to Thelsamar
	.link https://www.youtube.com/watch?v=21CuGto26Mk >> CLICK HERE for a reference
step << NightElf
	#requires crocs
    .goto Loch Modan,33.9,50.9
    .fp Thelsamar >> Get the Thelsamar flight path
step << NightElf
    .goto Loch Modan,21.30,68.60,40 >> Run to Dun Morogh
step << NightElf
	>>Go inside the South-eastern Trogg cave. Perform a logout skip
    .goto Dun Morogh,70.63,56.70,60,0
    .goto Dun Morogh,70.60,54.86
	.link https://www.youtube.com/watch?v=yQBW3KyguCM >> CLICK HERE
	.zone Ironforge >> Logout Skip or travel to Ironforge
step << !NightElf
    #requires crocs
    .hs >> Hearth to Menethil
	>> Buy food/water if needed
step << !NightElf
    .goto Wetlands,9.49,59.70
    .fly Ironforge >> Fly to Ironforge
step
    #sticky
    .goto Ironforge,50.82,5.61
    .turnin 968 >> Turn in The Powers Below
    .isOnQuest 968
step
    #sticky
    .goto Ironforge,72.08,51.87
    .turnin 1072 >> Turn in An Old Colleague
step
    #sticky
    .goto Ironforge,67.84,42.50
     >> Buy a Bronze Tube if you haven't already
    >>This is a limited supply item, skip this step if the npc doesn't have it
--    >>You will need 2 bronze tubes for a quest later << Rogue
    .bronzetube
step
    .goto Ironforge,76.03,50.98,30,0
    .zone Stormwind City >> Take the tram to Stormwind
]])

RXPGuides.RegisterGuide("RestedXP Alliance 20-30",[[
#classic
<< Alliance !Hunter
#name 21-23 Stonetalon/Ashenvale
#next 23-23 Wetlands
step
    .goto Ashenvale,37.36,51.79
    .accept 1033 >> Accept Elune's Tear
step
    .goto Ashenvale,46.37,46.38
     >> Loot the pearl shaped objects 
    >>Be careful with mobs sneaking underwater
    .complete 1033,1
step
    .goto Ashenvale,37.36,51.79
     >> Wait for the RP sequence to end
    .turnin 1033 >> Turn in Elune's Tear
    .accept 1034 >> Accept The Ruins of Stardust
step
    .goto Ashenvale,33.30,67.79
     >> Loot the bushes at the lake island
    .complete 1034,1
step
    #completewith next
    .goto Ashenvale,31.67,64.24,15 >> Head to the base of the mountain 
    .goto Ashenvale,31.21,61.60,15 >>Run straight north while climbing the mountain
step
    #completewith next
    .goto Ashenvale,27.50,60.76,8 >> Climb the hill next to the big tree to the right of the Fire Scar Shrine entrance 
    >>Jump over the tree root and hug the right to avoid aggroing mobs
step
    .goto Ashenvale,25.27,60.68
    >>Kill Ilkrud Magthrull
    .complete 973,1
step
    .goto Ashenvale,22.64,51.91
    .turnin 945 >> Turn in Therylune's Escape
    .isQuestComplete 945
step
    .goto Ashenvale,26.19,38.69
    .turnin 973 >> Turn in The Tower of Althalaxx
step
    .goto Ashenvale,14.79,31.29
    .accept 1007 >> Accept The Ancient Statuette
step
    #completewith nagas
     >> Kill nagas near the coast
    .complete 1008,1
step
    .goto Ashenvale,14.20,20.64
     >> Loot The Ancient Statuette
    .complete 1007,1
step
    .goto Ashenvale,14.79,31.29
    .turnin 1007 >> Turn in The Ancient Statuette
     >> Wait for the RP sequence
    .accept 1009 >> Accept Ruuzel
step
    #label nagas
    .goto Ashenvale,7.40,13.40
     >> Kill Ruuzel 
    >>Lady Vespia (rare) can also drop the ring
    .complete 1009,1
step
    .goto Ashenvale,7.00,15.20
     >> Finish off The Zoram Strand
    .complete 1008,1
step
    .goto Ashenvale,14.79,31.29
    .turnin 1009 >> Turn in Ruuzel
step
    .goto Ashenvale,20.31,42.33
    .turnin 991 >> Turn in Raene's Cleansing
    .accept 1023 >> Accept Raene's Cleansing
step
    .goto Ashenvale,20.41,43.82
     >> Kill Murlocs until the Glowing Gem drops
    .complete 1023,1
step << !Warlock
	#softcore
    .deathskip >> Die at the east side of the lake and spirit rez
step << !Warlock
	#hardcore
	>>Run back to Astranaar
    .goto Ashenvale,37.36,51.79
    .turnin 1034 >> Turn in The Ruins of Stardust
step << !Warlock
	#softcore
    .goto Ashenvale,37.36,51.79
    .turnin 1034 >> Turn in The Ruins of Stardust
step << !Warlock
    .goto Ashenvale,36.99,49.22
    .home >> Set your HS to Astranaar
step << !Warlock
    .goto Ashenvale,36.61,49.58
    .turnin 1023 >> Turn in Raene's Cleansing
    .accept 1025 >> Accept An Aggressive Defense
step <<  !Warlock
    #sticky
	#label Journal
     >> Throw away Teronis' Journal
    .destroy 5505
step <<  !Warlock
    .goto Ashenvale,34.67,48.83
    .turnin 1008 >> Turn in The Zoram Strand
step <<  !Warlock
    #era
    .goto Ashenvale,34.67,48.83
    .accept 1134 >> Accept Pridewings of Stonetalon
step <<  !Warlock
     #completewith next
    .goto Ashenvale,34.41,47.99
    .fly Auberdine >> Fly to Darkshore
step <<  !Warlock
	#requires Journal
    .goto Darkshore,36.62,45.59
    .turnin 4730 >> Turn in Beached Sea Creature
    .turnin 4731 >> Turn in Beached Sea Turtle
    .turnin 4732 >> Turn in Beached Sea Turtle
    .turnin 4733 >> Turn in Beached Sea Creature
step <<  !Warlock
    .goto Darkshore,37.70,43.39
    .turnin 4740 >> Turn in WANTED: Murkdeep!
step <<  !Warlock
    .goto Darkshore,39.37,43.48
    .turnin 995 >> Turn in Escape Through Stealth
step <<  !Warlock
    .goto Felwood,21.04,17.72
    .turnin 3765 >> Turn in The Corruption Abroad
step <<  !Warlock
    .goto Darkshore,37.44,41.83
    .turnin 731 >> Turn in The Absent Minded Prospector
    .accept 741 >> Accept The Absent Minded Prospector
step <<  NightElf
     #completewith next
    .goto Felwood,19.10,20.63
    .fly Teldrassil >> Fly to Teldrassil
step <<  !Warlock !NightElf
     .goto Darkshore,33.17,40.17,40,0
     .goto Darkshore,33.17,40.17,0
    .zone Teldrassil >> Take the boat to Darnassus
    .zoneskip Darnassus
step <<  !Warlock !NightElf
    .goto Teldrassil,58.39,94.01
    .fp Teldrassil >> Get the Rut'theran Village Flight Path
step << !Warlock
    #completewith next
    .goto Teldrassil,55.95,89.88
    .zone Darnassus >> Take the purple portal into Darnassus
step <<  !Warlock
    .goto Teldrassil,23.70,64.51
    .turnin 741 >> Turn in The Absent Minded Prospector
    .accept 942 >> Accept The Absent Minded Prospector
step << Druid
    .goto Darnassus,35.4,8.4
    .trainer >> Train your class spells
step << Druid
    .goto Darnassus,35.4,8.4
    .turnin 6125 >> Power over Poison
    .isOnQuest 6125
step << !Warlock
    .hs >> Hearth back to Astranaar
	>> Buy food/water if needed
step <<  Warlock
    .goto Ashenvale,34.67,48.83
     >> Head back to Astranaar
    .turnin 1008 >> Turn in The Zoram Strand
step <<  Warlock
    #era
    .goto Ashenvale,34.67,48.83
    .accept 1134 >> Accept Pridewings of Stonetalon
step <<  Warlock
    .goto Ashenvale,36.61,49.58
    .turnin 1023 >> Turn in Raene's Cleansing
    .accept 1025 >> Accept An Aggressive Defense
step <<  Warlock
    #sticky
     .destroy 5505 >> Throw away Teronis' Journal
step <<  Warlock
    .goto Ashenvale,37.36,51.79
    .turnin 1034 >> Turn in The Ruins of Stardust
step
    .goto Ashenvale,42.50,71.70
    .zone Stonetalon Mountains >> Head to stonetalon
step
    #era
    #sticky
    #completewith wyv1
     >> Kill all wyverns you encounter
    .complete 1134,1
step
    .goto The Barrens,22.71,12.91
    .turnin 1070 >> Turn in On Guard in Stonetalon
    .accept 1085 >> Accept On Guard in Stonetalon
step
    .goto The Barrens,22.53,13.05
    .turnin 1085 >> Turn in On Guard in Stonetalon
    .accept 1071 >> Accept A Gnome's Respite
step
    .goto The Barrens,22.28,10.86
    .accept 1093 >> Accept Super Reaper 6000
step
    #sticky
    #label sr6000
    .goto The Barrens,23.91,6.24
     >> Look for Operators around Windshear Crag
    .complete 1093,1
    .unitscan Venture Co. Operator
step
    .goto The Barrens,25.86,5.28
    .complete 1071,1
    .complete 1071,2
step
    #requires sr6000
    .goto The Barrens,22.28,10.86
    .turnin 1093 >> Turn in Super Reaper 6000
step
    #label wyv1
    .goto The Barrens,22.53,13.05
    .turnin 1071 >> Turn in A Gnome's Respite
    .accept 1072 >> Accept An Old Colleague
    .accept 1075 >> Accept A Scroll from Mauren
step
    #era
    .goto Ashenvale,18.62,77.42
     >> Finish off killing wyverns
    .complete 1134,1
step
    .goto Ashenvale,4.61,52.55
    .turnin 1056 >> Turn in Journey to Stonetalon Peak
step
    .goto Stonetalon Mountains,36.44,7.18
    .fp Stonetalon >> Get the Stonetalon Peak Flight Path << Warlock
    .fly Ashenvale >> Fly to Ashenvale << !Warlock
step << Warlock
    .goto Stonetalon Mountains,35.49,6.16
	.vendor >> vendor trash
step << Warlock
	#softcore
    #completewith next
    >>Make sure you have at least 4 soul shards before killing yourself, you're about to spirit rez 4 times total
    .deathskip >> Die and respawn at the Spirit Healer
step << Warlock
	#hardcore
    #completewith next
    >>You're about to go on a long journey for your Succubus since you can't deathskip
step << Warlock
    .goto The Barrens,35.10,27.80
    .zone The Barrens >>Run southeast to The Barrens
step << Warlock
	#softcore
    #completewith next
    .goto The Barrens,50.5,32.5,0
    .deathskip >> Once you get to The Barrens, Die and respawn at the Crossroads Graveyard
step << Warlock
    .goto The Barrens,49.30,57.09
    .turnin 1716 >> Turn in Devourer of Souls
    .accept 1738 >> Accept Heartswood
step << Warlock
	#softcore
    #completewith next
    .goto The Barrens,56.60,51.60
    .deathskip >> Run northeast. When the zone text changes to Raptor Grounds, Die and respawn back to Ratchet 
    >>Do your best to avoid the quilboar mobs
step << Warlock
    .goto The Barrens,62.98,37.21
    >>Head to Ratchet
    .turnin 1094 >> Turn in Further Instructions
step << Warlock
    .goto The Barrens,63.00,37.20
    .fp Ratchet>> Get the Ratchet Flight Path
step << Warlock
     #completewith next
    .hs >> Hearth back to Darkshore
	>> Buy food/water if needed
step << Warlock
    .goto Darkshore,36.62,45.59
    .turnin 4730 >> Turn in Beached Sea Creature
    .turnin 4731 >> Turn in Beached Sea Turtle
    .turnin 4732 >> Turn in Beached Sea Turtle
    .turnin 4733 >> Turn in Beached Sea Creature
step << Warlock
    .goto Darkshore,37.70,43.39
    .turnin 4740 >> Turn in WANTED: Murkdeep!
step << Warlock
    .goto Darkshore,39.37,43.48
    .turnin 995 >> Turn in Escape Through Stealth
step << Warlock
    .goto Felwood,21.04,17.72
    .turnin 3765 >> Turn in The Corruption Abroad
step << Warlock
    .goto Darkshore,37.44,41.83
    .turnin 731 >> Turn in The Absent Minded Prospector
    .accept 741 >> Accept The Absent Minded Prospector
step << Warlock
     .goto Darkshore,33.17,40.17,40,0
     .goto Darkshore,33.17,40.17,0
    .zone Teldrassil >> Take the boat to Darnassus
    .zoneskip Darnassus
step <<Warlock
    #completewith next
    .goto Teldrassil,55.95,89.88
    .zone Darnassus >> Take the purple portal into Darnassus
step << Warlock
    #label q741w
    .goto Teldrassil,23.70,64.51
    .turnin 741 >> Turn in The Absent Minded Prospector
    .accept 942 >> Accept The Absent Minded Prospector
step << Warlock
     #completewith next
    .goto Teldrassil,58.39,94.01
    >> Go back to Ruth'theran Village
    .fp Teldrassil >> Get the Ruth'theran Village Flight Path
step << Warlock
    .goto Teldrassil,58.39,94.01
    .fly Ashenvale >> Fly to Ashenvale
step
    #era
    .goto Ashenvale,34.67,48.83
    .turnin 1134 >> Turn in Pridewings of Stonetalon
step
    .goto Ashenvale,36.61,49.58
    .accept 1025 >> Accept An Aggressive Defense
step << skip
    .goto Ashenvale,37.36,51.79
    .accept 1035 >> Accept Fallen Sky Lake
step
    #era
    .goto Ashenvale,49.79,67.21
    .accept 1016 >> Accept Elemental Bracers
step
    #era
     >> Loot 5 Intact Elemental Bracers
    .collect 12220,5,1016,1
step
    #era
     >> Right click the Divining Scroll in your inventory
    .complete 1016,1
step
    #era
    .goto Ashenvale,49.79,67.21
    .turnin 1016 >> Turn in Elemental Bracers
step
    .goto Ashenvale,54.05,62.83
     >> Kill Furbolgs. Be careful of Den Watchers as they thrash
    .complete 1025,1
    .complete 1025,2
    .complete 1025,3
    .complete 1025,4
--KEKW
step << skip
    .goto Ashenvale,66.67,82.18
     >> Do Fallen Sky Lake 
    >>This quest requires you to kill a level 30 mob, skip it if necessary
    .complete 1035,1
step
     #completewith next
    .goto Ashenvale,95.57,48.62
    .zone Azshara >> Run east to Azshara
step
    .goto Azshara,11.90,77.57
    .fp Azshara>> Get the Azshara flight path
    .fly Astranaar >> Fly to Astranaar
step
    .goto Ashenvale,39.54,36.47
     >> Kill Dal Bloodclaw
    .complete 1054,1
    .unitscan DAL BLOODCLAW
step << !Warlock
	#softcore
     #completewith next
     .deathskip >> Die and respawn at Astranaar
step << Warlock
    .goto Ashenvale,31.50,31.50
     >> Click on the tree in the middle of the cultist camp
    .complete 1738,1
step << Warlock
	#softcore
    #completewith end
    .goto Ashenvale,24.5,39.1
    .deathskip >> Run to the base of the mountain southwest of the big tower and die back to Astranaar
step << skip
	#softcore
    .goto Ashenvale,37.36,51.79
    .turnin 1035 >> Turn in Fallen Sky Lake
step
	#hardcore
	>>Run back to Astranaar
    .goto Ashenvale,36.61,49.58
    .turnin 1025 >> Turn in An Aggressive Defense
    .turnin 1054 >> Turn in Culling the Threat
step
	#softcore
    .goto Ashenvale,36.61,49.58
    .turnin 1025 >> Turn in An Aggressive Defense
    .turnin 1054 >> Turn in Culling the Threat
step << skip
	#hardcore
    .goto Ashenvale,37.36,51.79
    .turnin 1035 >> Turn in Fallen Sky Lake
step
    #label end
    .goto Ashenvale,34.41,47.98
    .fly Darkshore>> Fly to Auberdine
step
    .goto Darkshore,33.70,42.45
     >> Level first aid/cooking while waiting for the Menethil boat
    .zone Wetlands >> Take the boat to Menethil Harbor

]])

RXPGuides.RegisterGuide("RestedXP Alliance 20-30",[[
#classic
<< Alliance !Hunter
#name 23-23 Wetlands
#next 24-27 Duskwood/Redridge

step
    .goto Wetlands,8.54,55.73
    .accept 484 >> Accept Young Crocolisk Skins
step
    .goto Wetlands,8.30,58.53
    .accept 279 >> Accept Claws from the Deep
step <<  NightElf
    .goto Wetlands,9.49,59.69
    .fp Wetlands>> Get the Wetlands flight path
step
    .goto Wetlands,10.89,59.66
    .accept 288 >> Accept The Third Fleet
    .accept 463 >> Accept The Greenwarden
step
    .goto Wetlands,10.69,60.95
    .home >> Set your Hearth to Menethil Harbor
     >> Buy a Flagon of Mead from the innkeeper
    .complete 288,1
step
    .goto Wetlands,10.84,60.43
     >> Go upstairs, turn in The Absent Minded Prospector, skip the follow up
    .turnin 942 >> Turn in The Absent Minded Prospector
step
    .goto Wetlands,10.89,59.66
    .turnin 288 >> Turn in The Third Fleet
step
    .goto Wetlands,10.75,56.75
    .vendor 1448 >> Look for a Bronze Tube at the npc inside the keep on the bottom floor
    >>This is a limited supply item, skip this step if the npc doesn't have it
--    >>You will need 2 bronze tubes for a quest later << Rogue
    .bronzetube
step
    #sticky
    #label crocs
     >> Kill Young Wetlands Crocolisks
    .complete 484,1
step
     >> Kill Murlocs. Keep an eye out for Gobbler
    .goto Wetlands,18.06,39.83
    .complete 279,1
    .complete 279,2
    .unitscan GOBBLER
step
    .goto Wetlands,26.40,25.76
    .vendor >> Look for a Bronze Tube at the gnome npc
    >>This is a limited supply item, skip this step if the npc doesn't have it
--    >>You will need 2 bronze tubes for a quest later << Rogue
    .bronzetube
step
    .goto Wetlands,49.91,39.36
    .accept 469 >> Accept Daily Delivery
step
    .goto Wetlands,56.37,40.40
    .turnin 463 >> Turn in The Greenwarden
    .accept 276 >> Accept Tramping Paws
step
	>>Kill Gnolls
    .goto Wetlands,61.91,71.32
    .complete 276,1
    .complete 276,2
step
	>>Keep grinding Gnolls until your hearth has <2 minutes left
    .goto Wetlands,56.37,40.40
    .turnin 276 >> Turn in Tramping Paws
    .accept 277 >> Accept Fire Taboo
step
    .goto Wetlands,61.91,71.32
    .xp 24 >> Grind gnolls to level 24
step
    #requires crocs
    .hs >> Hearth back to Menethil Harbor
	>> Buy food/water if needed
step
    .goto Wetlands,8.30,58.53
    .turnin 279 >> Turn in Claws from the Deep
    .accept 281 >> Accept Reclaiming Goods
step
    .goto Wetlands,8.54,55.73
    .turnin 469 >> Turn in Daily Delivery
    .turnin 484 >> Turn in Young Crocolisk Skins
    .accept 471 >> Accept Apprentice's Duties
step
    .goto Wetlands,9.49,59.69
    .fly Ironforge >> Fly to Ironforge
step << !Druid
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
step << Mage
     .goto Ironforge,25.51,7.09 << Mage
     .trainer >> Train the Ironforge Portal
step
    .goto Ironforge,50.82,5.61
    .turnin 968 >> Turn in The Powers Below
    .isOnQuest 968
step
    .goto Ironforge,67.84,42.50
    .vendor >> Buy a Bronze Tube if you haven't already
    >>This is a limited supply item, skip this step if the npc doesn't have it
--    >>You will need 2 bronze tubes for a quest later << Rogue
    .bronzetube
step
    .goto Ironforge,72.08,51.87
    .turnin 1072 >> Turn in An Old Colleague
step
   .goto Ironforge,76.61,51.28,30,0
    .zone Stormwind City >> Take the tram to Stormwind
]])

RXPGuides.RegisterGuide("RestedXP Alliance 20-30",[[
#classic
<< Alliance
#name 24-27 Duskwood/Redridge
#next 27-29 Wetlands/Hillsbrad
	
step << Hunter
    #sticky
    .bankdeposit 3618,3347,3397,5233,5234 >> Deposit the following items in your bank: 
    >>Gobbler's Head 
    >>Bundle of Crocolisk Skins 
    >>Young Crocolisk Skin (x4)
    >>Stone of Relu << Hunter
    >>Flagongut's Fossil << Hunter
step
    #completewith next
    .goto Stormwind City,55.21,7.04
    .vendor >> Buy a Bronze Tube if you haven't
    >>This is a limited supply item, skip this step if the npc doesn't have it
--    >>You will need 2 bronze tubes for a quest later << Rogue
    .bronzetube 
step << Warlock
    #sticky
    #completewith next
    .goto Stormwind City,29.2,74.0,20,0
    .goto Stormwind City,27.2,78.1,15 >> Go into The Slaughtered Lamb. Go downstairs
step << Warlock
    .goto Stormwind City,25.25,78.55
    .turnin 1738 >> Turn in Heartswood
    .accept 1739 >> Accept The Binding
step << Warlock
    .goto Stormwind City,25.16,77.43
     >> Run downstairs. Summon a Succubus, then kill her while running back to the quest giver
    .complete 1739,1
step << Warlock
     >>Use the Succubus from now on, as they deal a lot of damage
     >>Use a Voidwalker if you want to be really safe
    .goto Stormwind City,25.25,78.55
    .turnin 1739 >> Turn in The Binding
step
    #era
    .goto Stormwind City,42.79,80.15
    .turnin 1075 >> Turn in A Scroll from Mauren
    .accept 1076 >> Accept Devils in Westfall
step
    #som
    .goto Stormwind City,42.79,80.15
    .turnin 1075 >> Turn in A Scroll from Mauren
    >>Skip the follow up
step << Rogue
    .goto Stormwind City,52.8,65.4
    .home >> Set your Hearthstone to Stormwind
step << Mage
    #completewith next
    .goto Stormwind City,56.12,65.26
    .vendor >>Go into the building. Buy a Rune of Teleportation from Kyra
    .collect 17031,1 --Rune of Teleportation (1)
step
    #completewith next
	.goto Stormwind City,71.19,89.10
    .zone Elwynn Forest >> Head to Elwynn Forest
step
	>>Run to the north-west corner of Duskwood
    .goto Westfall,68.33,39.18
    .accept 226 >> Accept Wolves at Our Heels
step
	#sticky
    #label Wolves
    .goto Duskwood,48.0,17.2,85,0
    .goto Duskwood,48.0,17.2,0
     >> Kill Wolves along the North/North-West river bank
    .complete 226,1
    .complete 226,2
step
    .goto Duskwood,75.81,45.29
     >> Speak with Madame Eva
    .accept 66 >> Accept The Legend of Stalvan
    .accept 101 >> Accept The Totem of Infliction
step << !Rogue
    .goto Duskwood,73.90,43.40
    .home >> Set your hearth to Duskwood
step
    .goto Duskwood,73.59,46.89
     >> Head towards the Town Hall
    .accept 56 >> Accept The Night Watch
step
    .goto Duskwood,72.53,46.85
    .turnin 66 >> Turn in The Legend of Stalvan
    .accept 67 >> Accept The Legend of Stalvan
step
    .goto Duskwood,75.33,48.69
     >> Speak with Elaine Carevin
    .accept 163 >> Accept Raven Hill
    .accept 165 >> Accept The Hermit
step
    .goto Duskwood,75.33,48.69
    .accept 164 >> Accept Deliveries to Sven
    >>If you can't pick up this quest you need to drop Sven's Revenge from your quest log
step
    .goto Duskwood,77.5,44.3
    .fp Duskwood>> Get the Duskwood Flight Path
step
     #completewith next
    .goto Duskwood,77.99,48.33
    .vendor >> Buy a Bronze Tube if you don't have one
     >>This is a limited supply item, skip this step if the npc doesn't have it
--    >>You will need 2 bronze tubes for a quest later << Rogue
    .bronzetube 
step
    .goto Duskwood,79.80,48.02
    .accept 174 >> Accept Look To The Stars
step
    .goto Duskwood,79.80,48.02
     >> Skip this step if you haven't found a bronze tube yet
    .turnin 174 >> Turn in Look To The Stars
step
    .goto Duskwood,79.80,48.02
    .accept 175 >> Accept Look To The Stars
    .isQuestTurnedIn 174
step
    .goto Duskwood,81.46,59.02
     >> Head south towards the chapel
    .turnin 175 >> Turn in Look To The Stars
    .accept 177 >> Accept Look To The Stars
    .isQuestTurnedIn 174
step
	#completewith HistoryBook1
	>>Keep an eye out for the Old History Book (zone-wide drop). This is a free quest turnin
	.collect 2794,1,337 --An Old History Book (1)
	.accept 337 >> Accept An Old History Book
step
	#completewith next
	>>Kill Warriors and Mages
	>>Be careful as Mages have Frost Armor and Frostbolt, and Warriors Hamstring which deals a decent amount of damage
    .goto Duskwood,79.40,70.77
    .complete 56,1
    .complete 56,2
step
    .goto Duskwood,81.20,71.47
     >> Kill the Insane Ghoul. He can be inside the Chapel or patrol around the graveyard
    .complete 177,1
    .isQuestTurnedIn 174
step
	#label HistoryBook1
	>>Kill Warriors and Mages
	>>Be careful as Mages have Frost Armor and Frostbolt, and Warriors Hamstring which deals a decent amount of damage
    .goto Duskwood,79.40,70.77
    .complete 56,1
    .complete 56,2
step
    #era
    .goto Westfall,97.18,65.28
    .accept 245 >> Accept Eight-Legged Menaces
step
    .goto Westfall,76.55,57.05
    .turnin 163 >> Turn in Raven Hill
    .accept 5 >> Accept Jitters' Growling Gut
step
    #era
    #sticky
     >> Kill spiders along the western river bank 
    >>Don't go out of your way to do this quest, skip it if necessary
    .complete 245,1
step
   #requires Wolves
	.goto Duskwood,7.78,34.06
    .turnin 164 >> Turn in Deliveries to Sven
    .accept 95 >> Accept Sven's Revenge
step
    .goto Duskwood,7.71,33.19
    .turnin 226 >> Turn in Wolves at Our Heels
step
    .goto Westfall,84.06,37.84
    .turnin 165 >> Turn in The Hermit
    .accept 148 >> Accept Supplies from Darkshire
step
    >>Grind mobs until your Hearthstone cooldown is <5min 
    >>Kill Spiders in Duskwood
    .goto Duskwood,10.69,59.86,90,0
    .goto Duskwood,8.82,38.44
    .collect 2251,6,93,1
    .collect 1475,1,2607 << Rogue
    >>You'll need 1 venom sac to craft an anti-venom for the upcoming Rogue quest in Stormwind << Rogue
step
    #era
    #sticky
    #label devils
    .goto Westfall,40.14,60.85,0
     >> Look for dust devils, they can spawn all over the zone
     >>Use eagle eye to find them << Hunter
    .complete 1076,1
    .unitscan DUST DEVIL
step
    .goto Westfall,56.55,52.63
    .fp Westfall>> Get the Westfall Flight Path
step << Rogue
    .goto Westfall,68.5,70.0
    .turnin 2360 >> Turn in Mathias and the Defias
    .accept 2359 >> Accept Klaven's Tower
step << Rogue
    .goto Westfall,70.6,72.8
    >>Pickpocket one of the Defias Drones and loot the tower key
    .complete 2359,2 --Collect Defias Tower Key (x1)
step << Rogue
    .goto Westfall,70.4,74.0
    >>Climb to the top of the tower and loot the small chest on the floor
    .complete 2359,1 --Collect Klaven Mortwake's Journal (x1)
step
    #requires devils
    .goto Westfall,41.51,66.72
     >> Make sure you have at least 1 bag slot 
    >>Click on the footlocker on the ground
    .turnin 67 >> Turn in The Legend of Stalvan
    .accept 68 >> Accept The Legend of Stalvan
step << Druid
    .goto Westfall,18.0,33.2
    >>Loot the lockbox located deep underwater
    .collect 15882,1,272,1 --Collect Half Pendant of Aquatic Endurance (x1)
step << Druid
    .goto Moonglade,36.0,41.4
    >>Teleport to moonglade
    >>Combine the 2 pendants at the Shrine of Remulos
    .complete 272,1 --Collect Pendant of the Sea Lion (x1)
step << Druid
    .goto Moonglade,56.2,30.6
    >>Teleport back to Nighthaven
    .turnin 272 >> Turn in Trial of the Sea Lion
    .accept 5061 >> Accept Aquatic Form
step << Druid
    .goto Moonglade,52.53,40.56
     .trainer >> Train your class spells
step << Druid
    #sticky
    #completewith next
    .goto Moonglade,44.1,45.2
    .fly Teldrassil>> Fly to Teldrassil
step << Druid
    .goto Darnassus,35.4,8.3
    .turnin 5061 >> Turn in Aquatic Form
step << Rogue
    .hs >> Hearth to Stormwind
	.vendor >> Buy food if needed
step << Rogue
    .goto Stormwind City,74.90,54.00,20,0
    .goto Stormwind City,78.67,59.48,20,0
     .goto Stormwind City,75.9,59.9
    .turnin 2359 >> Turn in Klaven's Tower
    .accept 2607 >> Accept The Touch of Zanzil
step << Rogue
    .goto Stormwind City,78.1,59.0
    >>Head to the basement
    .turnin 2607 >> Turn in The Touch of Zanzil
--    .accept 2608 >> Accept The Touch of Zanzil
step << fRogue
    .goto Stormwind City,78.1,59.0
    >>Type /lay on the chat and wait until the quest complete itself
    .complete 2608,1 --Diagnosis Complete
step << fRogue
    .goto Stormwind City,78.0,58.8
    .turnin 2608 >> Turn in The Touch of Zanzil
    .accept 2609 >> Accept The Touch of Zanzil
step << fRogue
    .goto Stormwind City,78.2,59.0
    >>Buy a Leaded Vial from the Shady Dealer
    .complete 2609,2 --Collect Leaded Vial (x1)
step << fRogue
    >>Head to the flower vendor
    .complete 2609,1 --Collect Simple Wildflowers (x1)
    .goto Stormwind City,64.3,60.8
step << fRogue
    >>Buy a Bronze Tube at the Auction House
    .complete 2609,3 --Collect Bronze Tube (x1)
    .goto Stormwind City,53.6,59.3
    >>Head to the shop next to the bridge between the Cathedral Square and the Park
    .complete 2609,4 --Collect Spool of Light Chartreuse Silk Thread (x1)
    .goto Stormwind City,39.8,46.5
    >>If you can't find a bronze tube, you will have to skip this quest, train First Aid to 80, farm a small venom sac from spiders in Duskwood, craft an Anti-Venom and remove the Zanzil poison.
step << fRogue
    .goto Stormwind City,78.0,58.9
    .turnin 2609 >> Turn in The Touch of Zanzil
step << Rogue
    .goto Stormwind City,42.8,26.6
    .train 6452 >> Train First Aid to 80, use the Venom Sac you farmed earlier to craft an Anti-Venom and remove the Zanzil poison.
step << Rogue
    .goto Stormwind City,66.2,62.4
    .fly Duskwood>> Fly to Duskwood
step << Paladin
    .goto Westfall,42.5,88.6
    .turnin 1650 >>Turn in The Tome of Valor
    .accept 1651 >>Accept The Tome of Valor
step << Paladin
    .goto Westfall,42.5,88.6
    .complete 1651,1 --Protect Daphne Stilwell (1)
    .turnin 1651 >>Turn in The Tome of Valor
    .accept 1652 >>Accept The Tome of Valor
step << !Rogue
    .hs >> Hearth back to Duskwood
	>> Buy food/water if needed
step
	.goto Duskwood,73.88,43.45
    .turnin 5 >> Turn in Jitters' Growling Gut
    .accept 93 >> Accept Dusky Crab Cakes
step
    .goto Duskwood,73.59,46.89
    .turnin 56 >> Turn in The Night Watch
    .accept 57 >> Accept The Night Watch
step
    .goto Duskwood,72.53,46.85
    .turnin 68 >> Turn in The Legend of Stalvan
    .accept 69 >> Accept The Legend of Stalvan
step
    .goto Duskwood,75.81,45.29
    .turnin 148 >> Turn in Supplies from Darkshire
    .accept 149 >> Accept Ghost Hair Thread
step <<  Hunter
     #completewith next
    .goto Duskwood,81.83,19.77,60,0
    .goto Duskwood,93.93,10.67,60,0
    .goto Duskwood,93.93,10.67,0
    .zone Redridge Mountains >> Head to Redridge 
step << Hunter
    .goto Redridge Mountains,30.6,59.4
    .fp Redridge>>Get the Redridge Mountains Flight Path
step <<  Hunter
    #era
    .goto Redridge Mountains,31.53,57.85
    .accept 128 >> Accept Blackrock Bounty
step <<  !Hunter
     #completewith next
    .goto Duskwood,77.49,44.29
    .fly Redridge >> Fly to Redridge
step
    .goto Redridge Mountains,33.50,48.96
     >> Head to Lakeshire
    .accept 20 >> Accept Blackrock Menace
step << Hunter
    .goto Redridge Mountains,21.85,46.32
    .accept 34 >> Accept An Unwelcome Guest
step << Hunter
    .goto Redridge Mountains,15.68,49.30
     >> Kill Bellygrub. Loot her for her tusk
    .complete 34,1
step << Hunter
    .goto Redridge Mountains,21.85,46.32
    .turnin 34 >> Turn in An Unwelcome Guest
step
    .goto Redridge Mountains,27.34,47.29
    .accept 127 >> Accept Selling Fish
    .accept 150 >> Accept Murloc Poachers
step
    #sticky
    #label murlocs
    .goto Redridge Mountains,56.4,51.8,0
     >> Kill Murlocs. Loot them for Sunfish and Fins
    .complete 150,1
    .complete 127,1
step
    .goto Redridge Mountains,61.76,43.51
     >> Prioritize killing orcs 
     >>Once you clear the camp, kill murlocs southwest while you wait for respawns
    .complete 20,1
step
    #requires murlocs
    .goto Redridge Mountains,33.50,48.96
    .turnin 20 >> Turn in Blackrock Menace
step
     #completewith next
    .goto Redridge Mountains,26.75,46.43
     >> Click on the wanted poster
    .accept 180 >> Accept Wanted: Lieutenant Fangore
step
    .goto Redridge Mountains,27.72,47.38
    .turnin 127 >> Turn in Selling Fish
    .turnin 150 >> Turn in Murloc Poachers
step <<  Hunter
    .goto Redridge Mountains,26.75,46.43
     >> Click on the wanted poster
    .accept 180 >> Accept Wanted: Lieutenant Fangore
step <<  Hunter
    .goto Redridge Mountains,29.71,44.26
     >> Go inside the Town Hall
    .accept 91 >> Accept Solomon's Law
step
    #completewith next
    .goto Redridge Mountains,30.58,59.42
    .fly Duskwood >> Fly to Duskwood
step
    .goto Duskwood,81.98,59.08
     >> Head to the small farmhouse southeast of Darkshire
    .turnin 149 >> Turn in Ghost Hair Thread
    .accept 154 >> Accept Return the Comb
step
    .goto Duskwood,75.81,45.29
    .turnin 154 >> Turn in Return the Comb
    .accept 157 >> Accept Deliver the Thread
step
    .goto Duskwood,49.85,77.71
    .turnin 95 >> Turn in Sven's Revenge
    .accept 230 >> Accept Sven's Camp
step
    #era
    .goto Westfall,97.18,65.28
    .turnin 245 >> Turn in Eight-Legged Menaces
    .isQuestComplete 245
step
    #era
    #sticky
    .abandon 245 >> Abandon Eight-Legged Menaces if you haven't killed all 15 spiders
step
    .goto Westfall,84.06,37.84
    .turnin 157 >> Turn in Deliver the Thread
    .accept 158 >> Accept Zombie Juice
step
    .goto Westfall,68.38,39.85
    .turnin 230 >> Turn in Sven's Camp
    .accept 262 >> Accept The Shadowy Figure
step
    #era
    .goto Duskwood,21.35,46.80
    .xp 25+29845 >> Grind to 29845+/34000xp
step
    .goto Westfall,85.72,2.68
    >>Head to Goldshire
    .turnin 69 >> Turn in The Legend of Stalvan
    .accept 70 >> Accept The Legend of Stalvan
step
    .goto Westfall,86.25,2.70
     >> Run up the stairs 
    >>Loot the chest on the floor
    .complete 70,1
step << Mage
     #sticky
    .goto Stormwind City,43.08,80.39
     .zone Stormwind City >> Teleport to Stormwind
step
    #era
    .goto Stormwind City,43.08,80.39
    .turnin 1076 >> Turn in Devils in Westfall
    .accept 1078 >> Accept Retrieval for Mauren << !Hunter
step << !Warlock !Mage
    #sticky
    #completewith next
    .goto Stormwind City,29.2,74.0,20,0
    .goto Stormwind City,27.2,78.1,15 >> Head to the Slaughtered Lamb and go downstairs
step << !Warlock !Mage
    .goto Stormwind City,26.44,78.66
    .accept 335 >> Accept A Noble Brew
step
    .goto Stormwind City,29.56,61.93
    .turnin 70 >> Turn in The Legend of Stalvan
    .accept 72 >> Accept The Legend of Stalvan
step
    .goto Stormwind City,29.44,61.52
     >> Click on the crate nearby
    .turnin 72 >> Turn in The Legend of Stalvan
    .accept 74 >> Accept The Legend of Stalvan
step << Warlock/Mage
    #sticky
    #completewith next
    .goto Stormwind City,29.2,74.0,20,0
    .goto Stormwind City,27.2,78.1,15 >> Go into The Slaughtered Lamb and go downstairs
step << Warlock/Mage
    .goto Stormwind City,26.44,78.66
    .accept 335 >> Accept A Noble Brew
     .trainer >> Train your class spells << Warlock
step << Mage
     >>Teleport or run back to the mage tower
     .goto Stormwind City,36.87,81.14
     .trainer >> Train your class spells
step << !Mage !Warlock
    .goto Stormwind City,42.66,33.75,30,0 << Paladin/Priest
     .goto Stormwind City,39.81,29.79 << Paladin
    .turnin 1652 >>Turn in The Tome of Valor << Paladin
     .goto Stormwind City,38.68,32.85 << Paladin
    .goto Stormwind City,38.54,26.86 << Priest
    .goto Stormwind City,74.91,51.55,20,0 << Warrior
    .goto Stormwind City,78.67,45.80 << Warrior
    .goto Stormwind City,61.61,15.27 << Hunter
    .goto Stormwind City,74.64,52.82 << Rogue
    .goto Stormwind City,20.89,55.50 << Druid
    .trainer >> Train your class spells
step << Mage
    #completewith next
    .goto Stormwind City,56.12,65.26
    .vendor >>Go into the building. Buy 2 Runes of Teleportation from Kyra
    .collect 17031,2 --Rune of Teleportation (2)
step
    .goto Stormwind City,66.29,62.14
    .fly Darkshire >> Fly to Duskwood
step
	.isOnQuest 177
    .goto Duskwood,79.80,48.02
    .turnin 177 >> Turn in Look To The Stars
--    .accept 181 >> Accept Look To The Stars
step
    .goto Duskwood,75.30,48.04
    .accept 173 >>Accept Worgen in the Woods
step
    .goto Duskwood,75.81,45.29
     >> Speak with Madame Eva
    .turnin 262 >> Turn in The Shadowy Figure
    .accept 265 >> Accept The Shadowy Search Continues
step
    .goto Duskwood,72.53,46.85
    >>Head to the Town Hall
    .turnin 265 >> Turn in The Shadowy Search Continues
    .accept 266 >> Accept Inquire at the Inn
step
    .goto Duskwood,73.77,44.48
    >>Run to the Inn
    .turnin 158 >> Turn in Zombie Juice
    .accept 156 >> Accept Gather Rot Blossoms
    .turnin 266 >> Turn in Inquire at the Inn
    .accept 453 >> Accept Finding the Shadowy Figure
step
    .goto Duskwood,73.88,43.45
    .turnin 93 >> Turn in Dusky Crab Cakes
    .accept 240 >> Accept Return to Jitters
step
	#completewith HistoryBook
	>>Keep an eye out for the Old History Book (zone-wide drop). This is a free quest turnin
	.collect 2794,1,337 --An Old History Book (1)
	.accept 337 >> Accept An Old History Book
step
    .goto Westfall,79.63,48.10
     >> Kill skeletons at the Raven Hill Cemetery
    .complete 57,1
    .complete 57,2
    .complete 156,1
step
    .goto Duskwood,18.37,56.36
    .turnin 453 >> Turn in Finding the Shadowy Figure
    .accept 268 >> Accept Return to Sven
    .turnin 240 >> Turn in Return to Jitters
step
    .goto Duskwood,7.78,34.06
    .turnin 268 >> Turn in Return to Sven
    .accept 323 >> Accept Proving Your Worth
step
    .goto Duskwood,15.93,36.85
     >> Kill undead mobs around and inside the crypt, careful with the level 35 elite roaming the cemetery
    .complete 323,1
    .complete 323,2
    .complete 323,3
step
    .goto Duskwood,7.78,34.06
    .turnin 323 >> Turn in Proving Your Worth
    .accept 269 >> Accept Seeking Wisdom
step
    #completewith dusk2
    .hs >> Grind mobs until your Hearthstone is off cooldown, then hearth to Darkshire
	>> Buy food/water if needed
step
    #softcore
     #completewith next
    .fly Duskwood >> If you haven't found a Bronze Tube, save your Hearthstone cooldown and fly from Westfall to Duskwood
    .bronzetube 
step
    #label dusk2
    .goto Duskwood,73.77,44.48
    .turnin 156 >> Turn in Gather Rot Blossoms
    .accept 159 >> Accept Juice Delivery
step
    .goto Duskwood,73.59,46.89
    .turnin 57 >> Turn in The Night Watch
    .accept 58 >> Accept The Night Watch
step
	#label HistoryBook
     #completewith next
    .goto Duskwood,77.49,44.29
    .fly Redridge >> Fly to Redridge
step
    #sticky
    #softcore
    .home >> Set your Hearthstone to redridge if you haven't found a bronze tube 
    >>Skip this step if you purchased it already
    .bronzetube 
step
    #era
    .goto Redridge Mountains,31.53,57.85
    .accept 128 >> Accept Blackrock Bounty
step <<  Hunter/Warlock
    .goto Redridge Mountains,33.50,48.96
    .accept 19 >> Accept Tharil'zun
step
    .goto Redridge Mountains,31.00,47.30
    .accept 126 >> Accept Howling in the Hills
    .isQuestTurnedIn 124
step
    .goto Redridge Mountains,29.71,44.26
     >> Go inside the town hall
    .accept 91 >> Accept Solomon's Law
step
    .goto Redridge Mountains,26.75,46.43
     >> Click on the wanted poster
    .accept 180 >> Accept Wanted: Lieutenant Fangore
step << !Hunter
    .goto Redridge Mountains,21.85,46.32
    .accept 34 >> Accept An Unwelcome Guest
step << !Hunter
    .goto Redridge Mountains,15.68,49.30
     >> Kill Bellygrub. Loot her for her tusk
    .complete 34,1
step << !Hunter
    .goto Redridge Mountains,21.85,46.32
    .turnin 34 >> Turn in An Unwelcome Guest
step
    .goto Redridge Mountains,27.65,21.38
    >>Kill Yowler, he patrols along the northern gnoll camps
    .complete 126,1
    .isOnQuest 126
step
    #sticky
    #label fangore
    .goto Redridge Mountains,80.17,37.05
     >> Kill Lieutenant Fangore, you'll have to deal with him and 2 adds
     >> He is immune to Shadow, be careful << Warlock/Priest
    .complete 180,1
step
    #sticky
     #label Eye
    .goto Redridge Mountains,84.50,46.80
    .turnin 94 >> Turn in A Watchful Eye
    .isOnQuest 94
step
    .goto Redridge Mountains,77.52,36.31
     >> Kill Gnolls, loot their pendants
    .complete 91,1
step <<  Hunter/Warlock
    #requires Eye
     .goto Redridge Mountains,71.40,55.07
     >> Kite Tharil'zun towards Burning steppes
     >> You can pull him from down below with your pet
     >>This quest can be very hard, skip this step if you have to
     .link https://www.twitch.tv/videos/669042013?t=04h12m27s >> Click here for video reference << Warlock
     .link https://www.twitch.tv/videos/781037891?t=02h04m41s >> Click here for video reference << Hunter
    .complete 19,1
    .unitscan THARIL'ZUN
step
    #era
     #requires Eye
     .goto Redridge Mountains,28.89,13.20
     >> Do Blackrock Bounty
    .complete 128,1
step
	#era
    #sticky
    #softcore
    .goto Burning Steppes,78.12,75.48,90,0
    .goto Burning Steppes,66.06,21.96
    .vendor >> If you haven't found a bronze tube, skip the escort quest, run north to Burning Steppes, die on purpose, buy a bronze tube from Yuka in the cave at Flame's Crest and hearth back to Redridge
    .bronzetube 
step
	#som
    #sticky
    #softcore
    .goto Burning Steppes,78.12,75.48,90,0
    .goto Burning Steppes,66.06,21.96
    .vendor >> If you haven't found a bronze tube, run north to Burning Steppes, die on purpose, buy a bronze tube from Yuka in the cave at Flame's Crest and hearth back to Redridge
    .bronzetube 
step
    #era
    .goto Redridge Mountains,28.40,12.60
    >>Go to the back of the cave, and start the escort quest. This quest can be very hard, be careful to not pull too many mobs right after you leave the cave
    .accept 219 >> Accept Missing In Action
step
    #era
    >>Escort Keeshan, be careful to not pull too many mobs right after you leave the cave.
    .complete 219,1
step <<  Hunter/Warlock
    .goto Redridge Mountains,33.50,48.96
    .turnin 19 >> Turn in Tharil'zun
step
    #era
    .goto Redridge Mountains,33.50,48.96
    .turnin 219 >> Turn in Missing In Action
step
    .goto Redridge Mountains,29.71,44.26
    .turnin 91 >> Turn in Solomon's Law
    .turnin 180 >> Turn in Wanted: Lieutenant Fangore
step
    .goto Redridge Mountains,30.97,47.27
    .turnin 126 >> Turn in Howling in the Hills
    .isOnQuest 126
step
    #era
    .goto Redridge Mountains,31.53,57.85
    .turnin 128 >> Turn in Blackrock Bounty
step << !Mage
    .goto Redridge Mountains,30.58,59.42
    .fly Stormwind>> Fly to Stormwind
step << Mage
    .goto Redridge Mountains,30.58,59.42
    .zone Stormwind City>> Teleport or Fly to Stormwind
]])

RXPGuides.RegisterGuide("RestedXP Alliance 20-30",[[
#classic
<< Alliance
#name 27-29 Wetlands/Hillsbrad
#next 29-32 Duskwood << Hunter
#next 29-30 Ashenvale << !Hunter

step
    .goto Stormwind City,56.48,73.41
    .bankdeposit 916,1451,2378,1130 >> Deposit the follwing items in the Bank: 
    >>A Torn Journal Page 
    >>Bottle of Zombie Juice 
    >>Skeleton Finger 
    >>Vial of Spider Venom 
step << Hunter
    .goto Stormwind City,56.48,73.41
    .bankwithdraw 3618,3347,3397,5233,5234 >> Withdraw the following items from your bank: 
    >>Gobbler's Head 
    >>Bundle of Crocolisk Skins 
    >>Young Crocolisk Skin (x4)
    >>Stone of Relu << Hunter
    >>Flagongut's Fossil << Hunter
step
    .goto Stormwind City,39.11,27.88
    .turnin 269 >> Turn in Seeking Wisdom
    .accept 270 >> Accept The Doomed Fleet
step
    .goto Stormwind City,40.55,30.91
    .accept 2923 >> Accept Tinkmaster Overspark
step
     #completewith next
    .goto Stormwind City,63.73,8.43,45,0
    .zone Ironforge >> Take the tram to Ironforge
	>>Teleport to Ironforge if you have a lot of money and/or runes << Mage
step
    .goto Ironforge,72.08,51.87
    .turnin 1072 >> Turn in An Old Colleague
step
    .goto Ironforge,69.54,50.32
    .turnin 2923 >> Turn in Tinkmaster Overspark
step
    .goto Ironforge,55.51,47.75
    .fly Wetlands>> Fly to Wetlands
step
    .goto Wetlands,10.58,60.59
    .turnin 270 >> Turn in The Doomed Fleet
     >> Skip the follow up for now
step
    .goto Wetlands,10.69,60.95
    .home >> Set your Hearthstone to Wetlands
step
    .isQuestTurnedIn 942
     .goto Wetlands,10.84,60.43
     >> Go upstairs
    .accept 943 >> Accept The Absent Minded Prospector
step
    .goto Wetlands,10.89,59.66
    .accept 289 >> Accept The Cursed Crew
step
    .goto Wetlands,11.79,57.99
    .accept 470 >> Accept Digging Through the Ooze
step
    .goto Wetlands,8.30,58.53
    .turnin 279 >> Turn in Claws from the Deep << Hunter
    .accept 281 >> Accept Reclaiming Goods
step
    .goto Wetlands,8.54,55.73
    .turnin 469 >> Turn in Daily Delivery << Hunter
    .turnin 484 >> Turn in Young Crocolisk Skins << Hunter
    .accept 471 >> Accept Apprentice's Duties
step << skip
     #completewith next
    .goto Wetlands,9.86,57.48
    .turnin 473 >> Turn in Report to Captain Stoutfist
step
    .goto Wetlands,9.86,57.48
     >> Enter the keep and head upstairs
    .accept 464 >> Accept War Banners
step
    .goto Wetlands,10.84,55.89
    .accept 472 >> Accept Fall of Dun Modr
step
    .goto Wetlands,11.50,52.13
    .accept 305 >> Accept In Search of The Excavation Team
step
    .goto Wetlands,13.52,41.37
    .turnin 281 >> Turn in Reclaiming Goods
    .accept 284 >> Accept The Search Continues
step
    .goto Wetlands,13.60,38.22
    .turnin 284 >> Turn in The Search Continues
    .accept 285 >> Accept Search More Hovels
step
    .goto Wetlands,13.94,34.81
    .turnin 285 >> Turn in Search More Hovels
    .accept 286 >> Accept Return the Statuette
step
    #completewith Gnolls
	.goto Wetlands,22.25,20.36,0
     >> Kill Giant Crocolisks found along the coastline en route to other quests
    .complete 471,1
step
    .goto Wetlands,14.00,29.80
    .goto Wetlands,15.0,24.0
     >> Kill ghosts, enter the ship by the hole on the hull and kill Snellig
    .complete 289,1
    .complete 289,2
    .complete 289,3
step
	#label Gnolls
    #completewith next
    .goto Wetlands,44.14,33.50,0
     >> Kill Gnolls on your way to other objectives
    .complete 277,1
step
    .goto Wetlands,43.14,42.62
     >> Kill Orcs. Loot them for their banners
	>>Be careful as they net, and attack fast
    .complete 464,1
step
    #completewith next
    .goto Wetlands,39.52,46.70,25 >> Head towards the mountain shortcut
step << !Hunter
    .goto Wetlands,38.17,50.88
    .accept 294 >> Accept Ormer's Revenge
step
    .goto Wetlands,38.90,52.33
    .turnin 305 >> Turn in In Search of The Excavation Team
    .accept 306 >> Accept In Search of The Excavation Team
    .accept 299 >> Accept Uncovering the Past
step
    .isQuestTurnedIn 942
    .goto Wetlands,38.85,52.20
     >> Loot the fossil on the ground
    .complete 943,2
step << Hunter
    .isQuestTurnedIn 942
     #sticky
    #label fossil2
     >> Kill and loot Raptors in Wetlands
    .complete 943,1
step << Hunter
    .goto Wetlands,34.71,49.95
     >> Search for the 4 relics, they have random spawn locations and can spawn anywhere at the digsite, including the elevated terrain around
    .complete 299,1
    .complete 299,2
    .complete 299,3
    .complete 299,4
step << Hunter
    .goto Wetlands,38.8,52.2
    #requires fossil2
    .turnin 299 >> Turn in Uncovering the Past
step
    #sticky
    #label slimes
    .goto Wetlands,44.25,25.61
     >> Kill Slimes. Loot them for Sida's Bag
    .complete 470,1
step
    .goto Wetlands,44.14,33.50
     >> Finish off killing and looting Gnolls for the Crude Flint
    .complete 277,1
step
    #requires slimes
    .goto Wetlands,56.37,40.40
    .turnin 277 >> Turn in Fire Taboo
    .accept 275 >> Accept Blisters on The Land
step
    .goto Wetlands,64.78,75.31
     >> Loot the Musquash Root by the base of the waterfall
    .complete 335,2
step << Druid
    >>Teleport to Moonglade
	.goto Moonglade,52.53,40.56
    .trainer >> Train your class spells
step
     #completewith next
    .hs >> Hearth to Menethil Harbor
	>> Buy food/water if needed
step
    .goto Wetlands,10.89,59.66
    .turnin 289 >> Turn in The Cursed Crew
    .accept 290 >> Accept Lifting the Curse
step
    .goto Wetlands,8.30,58.53
    .turnin 286 >> Turn in Return the Statuette
step
    .goto Wetlands,11.79,57.99
    .turnin 470 >> Turn in Digging Through the Ooze
step
    .goto Wetlands,9.86,57.48
    .turnin 464 >> Turn in War Banners
    .accept 465 >> Accept Nek'rosh's Gambit
step
    .goto Wetlands,11.50,52.13
    .turnin 306 >> Turn in In Search of The Excavation Team
step
    .isQuestTurnedIn 942
     #sticky
    #label fossil
     >> Kill and loot Raptors
    .complete 943,1
step << !Hunter
    .goto Wetlands,25.58,47.40
    .complete 294,1
    .complete 294,2
step << !Hunter
    .goto Wetlands,38.17,50.88
    .turnin 294 >> Turn in Ormer's Revenge
    .accept 295 >> Accept Ormer's Revenge
step << !Hunter
    #sticky
    #label relics
    .goto Wetlands,34.71,49.95,0
     >> Search for the 4 relics, they have random spawn locations and can spawn anywhere at the digsite, including the elevated terrain where Sarltooth is (to the South-West)
    .complete 299,1
    .complete 299,2
    .complete 299,3
    .complete 299,4
step << !Hunter
    .goto Wetlands,34.71,49.95
    .complete 295,1
    .complete 295,2
step << !Hunter
    .goto Wetlands,38.17,50.88
    .turnin 295 >> Turn in Ormer's Revenge
    .accept 296 >> Accept Ormer's Revenge
step << !Hunter
    .goto Wetlands,38.8,52.2,0
    #sticky
    #requires relics
    .turnin 299 >> Turn in Uncovering the Past
step << !Hunter
    .goto Wetlands,33.25,51.50
     >> Kill Sarltooth
    .complete 296,1
    .unitscan SARLTOOTH
step << !Hunter
    #requires relics
    .goto Wetlands,38.17,50.88
    .turnin 296 >> Turn in Ormer's Revenge
    .turnin 299 >> Turn in Uncovering the Past
step
    #requires fossil << !Hunter
    #completewith next
     >> Look for Fen Creepers that are stealthed along the river stream
    .complete 275,1
step
    #requires fossil
    .goto Wetlands,15.44,23.60
     >> Enter the ship by the broken mast 
    >>Kill Captain Halyndor
    .complete 290,1
step
    .goto Wetlands,14.37,24.04
     >> Dive to the bottom of the ship
    .turnin 290 >> Turn in Lifting the Curse
    .accept 292 >> Accept The Eye of Paleth
step
    .goto Wetlands,17.34,28.24,90,0
    .goto Wetlands,20.40,21.27,90,0
    .goto Wetlands,27.79,19.51
     >> Kill Giant Crocolisks found along the coastline
    .complete 471,1
step
    .goto Wetlands,37.86,33.25
     >> Finish off killing Fen Creepers. They're typically found stealthed in the shallow waters of western and central Wetlands
    .complete 275,1
	.unitscan Fen Creeper
step
    .goto Wetlands,47.45,47.01
    .turnin 465 >> Turn in Nek'rosh's Gambit
step << Hunter/Warlock
    .goto Wetlands,47.45,47.01
    .accept 474 >> Accept Defeat Nek'rosh
step << Hunter/Warlock
    #sticky
    #label nekrosh
    .goto Wetlands,53.2,56.0,40,0
    .goto Wetlands,53.2,56.0,0
     >>Kill Nek'rosh. This elite quest can be very hard to solo, skip this step if you have to
	>> You can split pull Nek'Rosh from the mobs around him by using Rain of Fire << Warlock
    .complete 474,1
	.link https://www.twitch.tv/videos/669042748?t=02h57m08s >> CLICK HERE for reference
step
    .goto Wetlands,56.37,40.40
    .turnin 275 >> Turn in Blisters on The Land
step
    #requires nekrosh << Hunter/Warlock
    .goto Wetlands,49.80,18.25
    .turnin 472 >> Turn in Fall of Dun Modr
    .accept 631 >> Accept The Thandol Span
step
    .goto Arathi Highlands,45.65,93.07
    >>Go down the spiral staircase and click on the dwarf corpse, be careful with the 2 elite mobs patrolling nearby, you don't need to deal with them, just get the quest and run back to Wetlands
    .turnin 631 >> Turn in The Thandol Span
    .accept 632 >> Accept The Thandol Span
step
    .goto Wetlands,49.91,18.21
    .turnin 632 >> Turn in The Thandol Span
    .accept 633 >> Accept The Thandol Span
step
    .goto Arathi Highlands,43.24,92.64
     >> Jump down into the small room inside the destroyed bridge's support column
    .accept 647 >> Accept MacKreel's Moonshine
        >>You can still get this quest if you don't have any kind of speed increase or slow fall
    .link https://www.twitch.tv/videos/646111384 >>Click here for reference
step
     #completewith next
    .goto Arathi Highlands,44.28,92.88
     >> Loot the Waterlogged Envelope underwater
     .collect 4433,1,637
    .accept 637 >> Accept Sully Balloo's Letter
step
    #completewith next
    .goto Arathi Highlands,52.5,90.4,45 >> Swim east toward the ramp here
step
    .goto Arathi Highlands,48.79,88.04
     >> Click on the cart full of explosives
    .complete 633,1
step
    .goto Wetlands,49.91,18.21
    .turnin 633 >> Turn in The Thandol Span
    .accept 634 >> Accept Plea To The Alliance
step
    >>Cross the bridge into Arathi
     .goto Arathi Highlands,45.83,47.55
    .turnin 634 >> Turn in Plea To The Alliance
step
    .goto Arathi Highlands,45.73,46.09
    .fp Arathi>> Get the Arathi Highlands FP
step << skip
     #completewith next
     .goto Arathi Highlands,27.0,58.8,0
     .vendor >> Buy all 3 first aid books inside Stromgarde if you are leveling first aid
step
    >>Run to Southshore, into the inn, then into the basement. If you fail the timed quest, abandon it and skip this step
    >>This is the only timed quest in the game that fails if you die, play safe.
    .goto Arathi Highlands,19.72,29.04,40,0
    .goto Hillsbrad Foothills,50.71,58.76,15,0
    .goto Hillsbrad Foothills,52.09,58.70
    .turnin 647 >> Turn in MacKreel's Moonshine
step
    .goto Hillsbrad Foothills,49.34,52.27
    .fp Southshore>> Get the Southshore Flight Path
step <<  Hunter
    #era
    #completewith end
    .xp 29.55 >> Do the murloc quests in Southshore or farm turtle meat until you are 55% into level 29
step <<  Hunter
     #completewith next
     >> Stable your pet and head east 
    .train 17264 >>Tame an Elder Moss Creeper, learn bite rank 4
step
    #era
     #completewith next
     + Kill turtles along the river and farm about 5 turtle meat, you'll need 10 for a quest later, don't go out of your way to kill them
step << Druid
    .goto Moonglade,52.53,40.56
    >>Teleport to Moonglade
    .trainer >> Train your class spells
step
    #label end
    .hs >> Hearth to Menethil Harbor
	>> Buy food/water if needed
step
    .goto Wetlands,10.58,60.59
    .turnin 292 >> Turn in The Eye of Paleth
    .accept 293 >> Accept Cleansing the Eye
step
    .goto Wetlands,10.58,60.59
    .accept 321 >> Accept Lightforge Iron
step
    .isQuestTurnedIn 942
     .goto Wetlands,10.84,60.43
     >> Go upstairs
    .turnin 943 >> Turn in The Absent Minded Prospector
step
    .goto Wetlands,12.10,64.19
    .turnin 321 >> Turn in Lightforge Iron
    .accept 324 >> Accept The Lost Ingots
step
    .goto Wetlands,9.54,69.70
     >> Kill murlocs
    .complete 324,1
step << Hunter
    .goto Wetlands,9.54,69.70
    .xp 30-15000 >> Grind until you are 15k xp away from level 30
step
    .goto Wetlands,8.54,55.73
    .turnin 471 >> Turn in Apprentice's Duties
step << Hunter/Warlock
    .isQuestComplete 474
     .goto Wetlands,9.86,57.48
    .turnin 474 >> Turn in Defeat Nek'rosh
step
    .abandon 474 >> Abandon Defeat Nek'rosh
step
    .goto Wetlands,10.58,60.59
    .turnin 324 >> Turn in The Lost Ingots
    .accept 322 >> Accept Blessed Arm
step <<  Hunter
    .goto Wetlands,9.49,59.70
    .fly Ironforge >> Fly to Ironforge
]])

RXPGuides.RegisterGuide("RestedXP Alliance 20-30",[[
<< Alliance !Hunter
#classic
#era
#name 29-30 Ashenvale
#next RestedXP Alliance 30-40\29-32 Duskwood
step
    #sticky
    #completewith next
    .goto Wetlands,4.7,57.3,30 >> Go to the boat
    .goto Wetlands,4.7,57.3,0
step
    .zone Darkshore >>Get onto the boat when it comes
step
    .goto Darkshore,36.33,45.58
    .fly Stonetalon >> Fly to Stonetalon
step
    .goto Stonetalon Mountains,37.10,8.10
    .accept 1057 >> Accept Reclaiming the Charred Vale
step
    #sticky
    #label basilisks
     >> Kill Basilisks. Loot them for their Scales
    .complete 1078,1
step
    .goto The Barrens,8.84,10.23
     >> Kill Harpies around the Charred Vale
    .complete 1057,1
    .complete 1057,2
    .complete 1057,3
    .complete 1057,4
step
    #completewith next
    .goto Desolace,54.76,0.47
    .zone Desolace >> Head south to Desolace
step
    .goto Desolace,64.66,10.53
    .fp Desolace>>Get the Desolace Flight Path
    .fly Stonetalon>> Fly to Stonetalon
step
    .goto Stonetalon Mountains,37.10,8.10
    .turnin 1057 >> Turn in Reclaiming the Charred Vale
    .accept 1059 >> Accept Reclaiming the Charred Vale
step
    .goto Stonetalon Mountains,36.44,7.18
    .fly Ashenvale>> Fly to Ashenvale
step
    .goto Ashenvale,34.67,48.83
    .accept 4581 >> Accept Kayneth Stillwind
step
    .goto Ashenvale,36.61,49.58
    .accept 1024 >> Accept Raene's Cleansing
    .accept 1025 >> Accept An Aggressive Defense
    .accept 1054 >> Accept Culling the Threat
step

    .goto Ashenvale,34.69,44.30,30,0
    .goto Ashenvale,35.43,41.46,30,0
    .goto Ashenvale,36.28,38.48,30,0
    .goto Ashenvale,36.83,37.56,30,0
    .goto Ashenvale,36.06,36.59,0
    .goto Ashenvale,37.00,33.77,0
    .goto Ashenvale,35.88,31.90,0
    .goto Ashenvale,38.73,36.32,0
    .goto Ashenvale,34.74,44.67
    >>Take the mountain shortcut 
    >>Look for Dal Bloodclaw and loot him for his Skull. He patrols the camp
    .complete 1054,1
    .unitscan DAL BLOODCLAW
step
    .goto Ashenvale,22.23,52.98
    .accept 1022 >> Accept The Howling Vale
step
    .goto Ashenvale,21.73,53.34
    .accept 1021 >> Accept Vile Satyr! Dryads in Danger!
step
    .goto Ashenvale,26.19,38.69
    .accept 1140 >> Accept The Tower of Althalaxx
step
    .goto Ashenvale,36.61,49.58
    .turnin 1054 >> Turn in Culling the Threat
step
    .goto Ashenvale,37.36,51.79
    .accept 1035 >> Accept Fallen Sky Lake
step
    .goto Ashenvale,53.53,46.21
    .turnin 1024 >> Turn in Raene's Cleansing
    .accept 1026 >> Accept Raene's Cleansing
step
    .goto Ashenvale,54.41,35.39
     >> Kill Treants until a Wooden Key drops 
    >>Loot the chest
    .complete 1026,1
step
    .goto Ashenvale,50.49,39.12
     >> Click on the book next to the big obelisk.
    .complete 1022,1
step
    .goto Ashenvale,63.81,43.90
    .turnin 1021 >> Turn in Vile Satyr! Dryads in Danger!
    .accept 1031 >> Accept The Branch of Cenarius
step
    .goto Ashenvale,77.99,42.41
     >> Kill Geltharis. Loot him for the Branch of Cenarius
    .complete 1031,1
step
    .goto Ashenvale,85.23,44.71
    .turnin 4581 >> Turn in Kayneth Stillwind
    .accept 1011 >> Accept Forsaken Diseases
step
    .goto Azshara,11.90,77.57
    .fly Ashenvale>> Fly to Ashenvale
step
    .goto Ashenvale,22.23,52.98
    .turnin 1022 >> Turn in The Howling Vale
    .accept 1037 >> Accept Velinde Starsong
step
    .goto Ashenvale,21.73,53.34
    .turnin 1031 >> Turn in The Branch of Cenarius
    .accept 1032 >> Accept Satyr Slaying!
step
    .goto Ashenvale,41.84,49.48
    .turnin 1026 >> Turn in Raene's Cleansing
    .accept 1027 >> Accept Raene's Cleansing
step
    .goto Ashenvale,49.79,67.21
    .accept 1016 >> Accept Elemental Bracers
step
    #completewith next
     >> Loot 5 Intact Elemental Bracers
    .collect 12220,5,1016,1
step
    >>Click on the Divining Scroll 
    .complete 1016,1
step
    .goto Ashenvale,49.79,67.21
    .turnin 1016 >> Turn in Elemental Bracers
step
    .goto Ashenvale,54.05,62.83
     >> Do An Aggressive Defense
    .complete 1025,1
    .complete 1025,2
    .complete 1025,3
    .complete 1025,4
step
    .goto Ashenvale,61.15,71.95
     >> Kill a Shadethicket Oracle. Loot it for the Moonstone
    .complete 1035,1
step
    #sticky
    #label slimes
     >> Kill slimes, loot the chest that spawn from their corpse
    .complete 1027,1
step
    .goto Ashenvale,75.29,72.00
    >> Loot one of the bottles at the forsaken camp 
    >>Lots of stealthed mobs nearby, be careful
    .complete 1011,1
step
    #requires slimes
    .goto Ashenvale,85.23,44.71
    .turnin 1011 >> Turn in Forsaken Diseases
step
    .goto Ashenvale,81.59,48.57
     >> Click on the first red crystal
    .complete 1140,2
step
    .goto Ashenvale,66.62,56.99
     >> Click on the second red crystal
    .complete 1140,1
step
    .goto Ashenvale,81.42,49.87
     >> Kill Satyrs in Night Run
    .complete 1032,1
step
    .goto Ashenvale,53.53,46.21
    .turnin 1027 >> Turn in Raene's Cleansing
    .accept 1028 >> Accept Raene's Cleansing
step
    .goto Ashenvale,55.69,51.24
    .turnin 1028 >> Turn in Raene's Cleansing
    .accept 1055 >> Accept Raene's Cleansing
step
    .goto Ashenvale,53.53,46.21
    .turnin 1055 >> Turn in Raene's Cleansing
    .accept 1029 >> Accept Raene's Cleansing
step
    .goto Ashenvale,37.36,51.79
    .turnin 1035 >> Turn in Fallen Sky Lake
step
    .goto Ashenvale,36.61,49.58
    .turnin 1025 >> Turn in An Aggressive Defense
    .turnin 1029 >> Turn in Raene's Cleansing
    .accept 1030 >> Accept Raene's Cleansing
step
    .goto Ashenvale,51.96,68.27
     >> Use the rod of transformation
    .turnin 1030 >> Turn in Raene's Cleansing
    .accept 1045 >> Accept Raene's Cleansing
step
    .goto Ashenvale,54.73,79.11
    .complete 1045,1
    .complete 1045,2
step
    .goto Ashenvale,50.84,75.07
    .turnin 1045 >> Turn in Raene's Cleansing
    .accept 1046 >> Accept Raene's Cleansing
step
	#softcore
     #completewith next
     .deathskip >> Death warp to Astranaar
step
    #completewith end
     +You can either turn in Raene's Cleansing for 3k xp or abandon it if you wish to keep the Furbolg Rod to transform into a Furbolg whenever
step
    .goto Ashenvale,21.73,53.34
    .turnin 1032 >> Turn in Satyr Slaying!
step
    .goto Ashenvale,26.19,38.69
    .turnin 1140 >> Turn in The Tower of Althalaxx
step
    #label end
    .goto Ashenvale,34.41,47.98
    .fly Teldrassil>> Fly to Teldrassil
step << Warrior
    .goto Darnassus,58.72,34.90
     .trainer >> Train your class spells
step
    .goto Teldrassil,30.04,55.08
    .turnin 1037 >> Turn in Velinde Starsong
    .accept 1038 >> Accept Velinde's Effects
step
    .goto Teldrassil,30.15,64.25
     >> Loot the chest upstairs
    .complete 1038,1
    .complete 1038,2
step << Mage
    .goto Darnassus,40.61,82.14
     .trainer >> Train the Darnassus portal
step << Priest
    .goto Darnassus,37.90,82.73
     .trainer >> Train your class spells
step
    .goto Teldrassil,30.04,55.08
    .turnin 1038 >> Turn in Velinde's Effects
    .accept 1039 >> Accept The Barrens Port
step << Rogue
    .goto Darnassus,32.12,16.48,20,0
    .goto Darnassus,31.55,18.44,20,0
    .goto Darnassus,36.99,21.90
     .trainer >> Train your class spells
step << Mage
     .zone Ironforge >> Teleport to Ironforge
     .trainer >> Train your class spells
step << !Mage
    .hs >> Hearth to Wetlands
	>> Buy food/water if needed
step << !Mage
    .goto Wetlands,9.49,59.69
    .fly Ironforge>> Fly to Ironforge
]])

RXPGuides.RegisterGuide("RestedXP Alliance 30-40",[[
#classic
<< Alliance
#name 29-32 Duskwood
#next 32-33 Hillsbrad/Arathi

step
    #completewith start
     + This segment has a long grinding session, you can substitute that for a Gnomeregan run
step
    .goto Ironforge,23.11,6.15 << Paladin
    .goto Ironforge,50.35,5.63 << Warlock
	.trainer >> Train your class spells
step << Mage
    .goto Ironforge,31.33,27.80
    >>Go into the building. Buy 3 Runes of Teleportation from Ginny
    .collect 17031,3 --Rune of Teleportation (3)
step << Warlock
    .goto Ironforge,52.71,6.07 << Warlock
	.vendor >> Buy spellbooks for your Succubus/Voidwalker if needed
step << Priest
	#completewith next
    .goto Ironforge,23.32,17.62,20,0
    .goto Ironforge,23.12,15.93
	>>Buy the Pestilent Wand from the vendor if it's better than your current wand
	.collect 5347,1 --Pestilent Wand (1)
step << Hunter
	.goto Ironforge,61.34,89.25
	>>Go inside the building, head downstairs and buy a level 30 quiver from Thalgus Thunderfist
	.collect 7371,1
step
    .goto Ironforge,63.50,67.30
    .turnin 637 >> Turn in Sully Balloo's Letter
    >>Wait for the RP sequence
    .accept 683 >> Accept Sara Balloo's Plea
step
    .goto Ironforge,39.09,56.19
    .turnin 683 >> Turn in Sara Balloo's Plea
    .accept 686 >> Accept A King's Tribute
step
    .goto Ironforge,35.87,60.20
    .bankwithdraw 916,1451,2378,1130,2794 >> >> Withdraw the following items from your bank: 
    >>A Torn Journal Page 
    >>Bottle of Zombie Juice 
    >>Skeleton Finger 
    >>Vial of Spider Venom 
    >>An Old History Book (if you have it)
step
    .goto Ironforge,39.03,88.05
    .turnin 686 >> Turn in A King's Tribute
    .accept 689 >> Accept A King's Tribute
step
    .goto Ironforge,72.74,94.03
    .accept 1179 >>Accept The Brassbolts Brothers
step << Hunter
    .goto Ironforge,69.88,82.87
    .trainer >> Train your class skills
    >>Train pet skills
    >>Make sure you have frost/nature resistance maxed out on your pet
step << !Mage
     #completewith next
    .goto Ironforge,76.61,51.28,30,0
     .zone Stormwind City>> Take the tram to Stormwind
step << Mage
     #completewith next
    .goto Ironforge,76.61,51.28,30,0
     .zone Stormwind City>> Teleport to Stormwind
step
    .goto Stormwind City,51.75,12.06
    .turnin 322 >> Turn in Blessed Arm
    .accept 325 >> Accept Armed and Ready
step << Hunter
    #completewith start
    .trainer >> If you get level 30 turning in the next few quests in Stormwind, remember to buy class/pet skills
step
    #sticky
	#label Eye
    .goto Stormwind City,39.60,27.20
    .turnin 293 >> Turn in Cleansing the Eye
step
    .goto Stormwind City,38.72,25.89
    .accept 1274 >> Accept The Missing Diplomat
step
	#requires Eye
    .goto Stormwind City,78.30,25.45
    .turnin 1274 >> Turn in The Missing Diplomat
    .accept 1241 >> Accept The Missing Diplomat
step
    .goto Stormwind City,73.17,78.42
    .turnin 1241 >> Turn in The Missing Diplomat
    .accept 1242 >> Accept The Missing Diplomat
step
    .goto Stormwind City,57.00,72.88
    .bankdeposit 2784,5849,3712 >>  Deposit the following items into your bank:
    >>Musquash Root 
    >>Crate of Crash Helmets 
    >>Turtle Meat
step
    .goto Stormwind City,59.90,64.17
    .turnin 1242 >> Turn in The Missing Diplomat
    .accept 1243 >> Accept The Missing Diplomat
step
    #label start
    .goto Stormwind City,66.27,62.12
    .fly Duskwood>> Fly to Duskwood
step
    .goto Duskwood,79.80,48.02
     >> Skip this step if you haven't found a bronze tube
    .accept 174 >> Accept Look To The Stars
    .turnin 174 >> Turn in Look To The Stars
step
    .goto Duskwood,79.80,48.02
    .accept 175 >> Accept Look To The Stars
    .isQuestTurnedIn 174
step
    .goto Duskwood,81.46,59.02
     >> Head south towards the chapel
    .turnin 175 >> Turn in Look To The Stars
    .accept 177 >> Accept Look To The Stars
    .isQuestTurnedIn 174
step
    .goto Duskwood,81.20,71.47
     >> Kill the Insane Ghoul inside the chapel
    .complete 177,1
    .isQuestTurnedIn 174
step
    .goto Duskwood,79.80,48.02
    .turnin 177 >> Turn in Look To The Stars
    .isQuestTurnedIn 174
step
    .goto Duskwood,79.80,48.02
    .accept 181 >> Accept Look To The Stars
    .isQuestTurnedIn 174
step
    .goto Duskwood,75.75,47.56
    .accept 173 >> Accept Worgen in the Woods
step
    .goto Duskwood,73.59,46.89
    .accept 58 >> Accept The Night Watch
step
    .goto Duskwood,73.87,44.40
    .home >> Set your Hearthstone to Darkshire
step
    .goto Duskwood,72.55,33.54
    .turnin 1243 >> Turn in The Missing Diplomat
    .accept 1244 >> Accept The Missing Diplomat
step
	>>Kill Shadow Weavers in the area
    .goto Duskwood,63.00,41.60
    .complete 173,1
	.unitscan Nightbane Shadow Weaver
step
    .goto Duskwood,75.75,47.56
    .turnin 173 >> Turn in Worgen in the Woods
    .accept 221 >> Accept Worgen in the Woods
step
	>>Kill Dark Runners in the area. Be careful as they run faster than normal mobs, and have a larger aggro range
    .goto Duskwood,61.80,45.30
    .complete 221,1
step
    .goto Elwynn Forest,84.60,69.37
     >> Head northeast to Elwynn Forest
    .turnin 74 >> Turn in The Legend of Stalvan
    .accept 75 >> Accept The Legend of Stalvan
step
    .goto Elwynn Forest,85.70,69.53
     >> Loot the chest upstairs
    .complete 75,1
step
    .goto Elwynn Forest,84.60,69.37
    .turnin 75 >> Turn in The Legend of Stalvan
    .accept 78 >> Accept The Legend of Stalvan
step
	>>Run to North-west Duskwood
    .goto Duskwood,28.10,31.46
    .turnin 159 >> Turn in Juice Delivery
    .accept 133 >> Accept Ghoulish Effigy
step
    .goto Duskwood,24.26,32.90
     >> Kill Ghouls/Plague Spreaders
    .complete 58,1
    .complete 133,1
    .complete 101,1
step
    .goto Duskwood,28.10,31.46
    .turnin 133 >> Turn in Ghoulish Effigy
    .accept 134 >> Accept Ogre Thieves
step
    .goto Westfall,80.83,69.17
     >> Loot the chest inside the farmhouse
    .complete 1244,1
step
    .goto Duskwood,33.41,76.35
     >> Click on the crate on the ground
    .complete 134,1
step
    .goto Duskwood,36.81,83.78
     >> Kill Zzarc'Vul inside the cave
    .complete 181,1
    ---
step
    #som
    #completewith welcome
    .goto Duskwood,44.7,88.3
    .zone Stranglethorn Vale >> Head south to Stranglethorn Vale
step
    #som
    #completewith stvEnd
    .goto Stranglethorn Vale,40.32,8.45,0
    >> Look out for Private Thorsen's RP event while you quest. Guard him from the mobs that attack him, and accept his quest
    >>He patrols down the road down the Rebel Camp every ~30 minutes 
    .accept 215 >> Accept Jungle Secrets
    .turnin 215 >> Turn in Jungle Secrets
step
    #label welcome
    #som
    .goto Stranglethorn Vale,35.66,10.52
    .accept 583 >> Accept Welcome to the Jungle
    .turnin 583 >> Turn in Welcome to the Jungle
step
    #som
    .goto Stranglethorn Vale,35.61,10.61
    .accept 185 >> Accept Tiger Mastery
    .accept 190 >> Accept Panther Mastery
step
    #som
     #sticky
     #label panthers
	>>Kill Young Panthers
    .goto Stranglethorn Vale,41.50,12.00
    .complete 190,1
step
    #som
	>>Kill Young Tigers
    .goto Stranglethorn Vale,35.40,12.50
    .complete 185,1
step
    #som
    #requires panthers
    .goto Stranglethorn Vale,35.61,10.61
    .turnin 185 >> Turn in Tiger Mastery
    .accept 186 >> Accept Tiger Mastery
    .turnin 190 >> Turn in Panther Mastery
step
    #som
    #completewith note
    #label stvEnd
    .goto Duskwood,44.7,85.6
    .zone Duskwood >> Head back to Duskwood
step
     >> Finish off The Totem of Infliction
    .complete 101,2
    .goto Duskwood,29.0,49.4
    .complete 101,3
    .goto Duskwood,23.0,44.0
step
    #label note
    .goto Duskwood,28.10,31.46
    .turnin 134 >> Turn in Ogre Thieves
    .accept 160 >> Accept Note to the Mayor
step
    .goto Duskwood,17.72,29.07
    .accept 225 >> Accept The Weathered Grave
step
    .goto Duskwood,7.78,34.06
    .turnin 325 >> Turn in Armed and Ready
    .accept 55 >> Accept Morbent Fel
step
	#som
    .hs >> Hearth back to Darkshire
	>> Buy food/water if needed
step
	#era
    .hs >> Hearth back to Darkshire
	>> Buy food/water. You'll need at least 2 1/2 stacks for the upcoming segment
step << Hunter
    #era
    .goto Duskwood,73.28,44.76
    .vendor 228 >>Fill your quiver with arrows. Buy a few stacks extra for the upcoming segment
step
    .goto Duskwood,73.77,44.48
    .turnin 78 >> Turn in The Legend of Stalvan
    .accept 79 >> Accept The Legend of Stalvan
step
    .goto Duskwood,73.59,46.89
    .turnin 58 >> Turn in The Night Watch
    .turnin 79 >> Turn in The Legend of Stalvan
    .accept 80 >> Accept The Legend of Stalvan
step
    .goto Duskwood,72.53,46.85
    .turnin 80 >> Turn in The Legend of Stalvan
    .accept 97 >> Accept The Legend of Stalvan
step
    .goto Duskwood,72.64,47.61
    .turnin 225 >> Turn in The Weathered Grave
    .accept 227 >> Accept Morgan Ladimore
step
    .goto Duskwood,71.93,46.41
    .turnin 160 >> Turn in Note to the Mayor
    .accept 251 >> Accept Translate Abercrombie's Note
step
    .goto Duskwood,72.64,47.61
    .turnin 251 >> Turn in Translate Abercrombie's Note
    .accept 401 >> Accept Wait for Sirra to Finish
    .turnin 401 >> Turn in Wait for Sirra to Finish
    .accept 252 >> Accept Translation to Ello
step
    .goto Duskwood,71.93,46.41
     >> Talk to the mayor again
    .turnin 252 >> Turn in Translation to Ello
step
    .goto Duskwood,71.93,46.41
    .accept 253 >> Accept Bride of the Embalmer
step
    .goto Duskwood,73.59,46.89
    .turnin 97 >> Turn in The Legend of Stalvan
    .accept 98 >> Accept The Legend of Stalvan
    .turnin 227 >> Turn in Morgan Ladimore
    .accept 228 >> Accept Mor'Ladim
step
    #label exit1
    .goto Duskwood,72.55,33.54
    .turnin 1244 >> Turn in The Missing Diplomat
    .accept 1245 >> Accept The Missing Diplomat
step
    .goto Duskwood,78.35,35.94
     >> Loot the small flower at the farm
    .complete 335,1
step
    .goto Duskwood,77.30,36.20
     >> Kill Stalvan inside the house
	>>Be careful as Stalvan is quite hard. Kite him back to town and get help from the guards if needed
    .complete 98,1
step
    .goto Duskwood,75.81,45.29
    .turnin 98 >> Turn in The Legend of Stalvan
    .turnin 101 >> Turn in The Totem of Infliction
step
    .goto Duskwood,75.75,47.56
    .turnin 221 >> Turn in Worgen in the Woods
    .accept 222 >> Accept Worgen in the Woods
step
    .goto Duskwood,79.80,48.02
    .turnin 181 >> Turn in Look To The Stars
    .isQuestTurnedIn 174
step
    .goto Duskwood,62.33,81.77
     >> Kill Vile Fangs/Tainted Ones
	>>Be careful as all the mobs in the area respawn at once after a few minutes
    .complete 222,1
    .complete 222,2
step
    #era
    .goto Duskwood,62.33,81.77
     >> Grind worgen mobs until you find An Old History Book
    .collect 2794,1,337
    .accept 337 >> Accept An Old History Book
step
    #era
    .goto Duskwood,62.33,81.77
    .xp 32 >> Grind until you are anywhere between level 31 & 75% and level 32 << !Druid
	.xp 32 >> Grind until you are anywhere between 31 & 85% and 32 << Druid
    >>Keep grinding until your Hearthstone cooldown is <25 minutes
step
    #era
    #completewith next
    .goto Duskwood,62.33,81.77,0
    +Keep grinding worgens until your Hearthstone cooldown is <25 minutes
step
    .goto Duskwood,28.80,31.00
     >> Click on the grave to summon Eliza 
    >>Kill Eliza and loot her heart
    >>You can avoid dealing with her skeleton adds by using the wagon to jump on top of Abercrombie's shed << Hunter/Mage/Warlock/Priest
    >>This quest can be fairly diffult, skip this step if you have to. You can evade her skeleton adds by jumping on top of Abercrombie's shed << Warrior/Rogue/Druid/Paladin
    .complete 253,1
step
    .goto Duskwood,16.90,33.40
    >> Equip Morbent's Bane in your off-hand 
    >>Kill Morbent Fel, use the off-hand weapon to make him vulnerable to your attacks
    >>This quest is HARD, you can skip this step, you'll have another opportunity to do this quest at level 35
    .complete 55,1
step
    .goto Duskwood,7.78,34.06
    .turnin 55 >> Turn in Morbent Fel
    .isQuestComplete 55
step
    #completewith DuskwoodEnd
    .goto Duskwood,19.59,37.28
     >> Kill Mor'Ladim, he hits very hard but he can be easily kited around some of the larger trees in the area
    >>(Level 35 elite roaming the cemetery)
    >>This quest is HARD, you can skip this step, you'll have another opportunity to do this quest at level 35
    .complete 228,1
    .unitscan MOR'LADIM
step
    #som
    #label DuskwoodEnd
    .goto Westfall,56.55,52.63
    .fly Duskwood >> Go to Sentinel Hill in Westfall. Fly to Duskwood
step
    #era
    #label DuskwoodEnd
    .goto Duskwood,21.4,88.6
    .zone Stranglethorn Vale >> Head south to Stranglethorn Vale
step
    #era
    .goto Stranglethorn Vale,35.66,10.52
    .accept 583 >> Accept Welcome to the Jungle
    .turnin 583 >> Turn in Welcome to the Jungle
step
    #era
    .goto Stranglethorn Vale,35.61,10.61
    .accept 185 >> Accept Tiger Mastery
    .accept 190 >> Accept Panther Mastery
step
    #era
    #completewith stvEnd2
    .goto Stranglethorn Vale,40.32,8.45,0
    >> Look out for Private Thorsen's event while you quest. Guard him from the mobs that attack him, and accept his quest
    >>He patrols down the road down the Rebel Camp every ~30 minutes 
    .accept 215 >> Accept Jungle Secrets
    .turnin 215 >> Turn in Jungle Secrets
step
    #era
     #sticky
     #label panthers
	>>Kill Young Panthers
    .goto Stranglethorn Vale,41.50,12.00
    .complete 190,1
step
    #era
	>>Kill Young Tigers
    .goto Stranglethorn Vale,35.40,12.50
    .complete 185,1
step
    #era
    #requires panthers
    .goto Stranglethorn Vale,35.61,10.61
    .turnin 185 >> Turn in Tiger Mastery
    .accept 186 >> Accept Tiger Mastery
step
    #era
    .goto Stranglethorn Vale,35.55,10.54
    .turnin 190 >> Turn in Panther Mastery
step << Druid
    #era
    .goto Stranglethorn Vale,33.43,11.85
	.xp 32 >> Grind to 32
step << Druid
    #era
    >>Teleport to Moonglade
	.goto Moonglade,52.53,40.56
    .trainer >> Train your class spells
step
    #era
    #label stvEnd2
    .hs >> Hearth to Darkshire
	>> Buy food/water if needed
step
    .goto Duskwood,73.59,46.89
    .turnin 228 >> Turn in Mor'Ladim
    .isQuestComplete 228
step
    .goto Duskwood,73.59,46.89
    .isQuestTurnedIn 228
    .accept 229 >> Accept The Daughter Who Lived
step
    .goto Duskwood,71.93,46.41
    .turnin 253 >> Turn in Bride of the Embalmer
    .isQuestComplete 253
step
    #sticky
    .destroy 3248 >>Throw away the Translated Letter from The Embalmer
step
    .goto Duskwood,74.54,46.08
    .turnin 229 >> Turn in The Daughter Who Lived
    .accept 231 >> Accept A Daughter's Love
    .isQuestTurnedIn 228
step
    .goto Duskwood,75.75,47.56
    .turnin 222 >> Turn in Worgen in the Woods
    .accept 223 >> Accept Worgen in the Woods
step
    .goto Duskwood,75.32,49.02
    .turnin 223 >> Turn in Worgen in the Woods
step << !Mage
    .goto Duskwood,77.49,44.28
    .fly Stormwind>> Fly to Stormwind
step << Mage
	.zone Stormwind City >> Teleport to Stormwind
	.trainer >> Train your class spells
step << Mage
    #completewith next
    .goto Stormwind City,29.2,74.0,20,0
    .goto Stormwind City,27.2,78.1,15 >> Go into The Slaughtered Lamb and go downstairs
step << Mage
    .goto Stormwind City,26.44,78.66
    .turnin 335 >> Turn in A Noble Brew
    .accept 336 >> Accept A Noble Brew
step << Mage
    .goto Stormwind City,39.76,81.45
    .accept 690 >> Accept Malin's Request
step << Mage
	.goto Stormwind City,40.62,91.83
    >>Go to the tavern's kitchen
    .accept 1301 >> Accept James Hyal
step << Mage
    #era
    .isOnQuest 1078
    .goto Stormwind City,43.08,80.39
    .turnin 1078 >> Turn in Retrieval for Mauren
step
    .goto Stormwind City,57.00,72.88
    .bankwithdraw 2784,5849,3712,2794 >> Withdraw the following items: 
    >>Crate of Crash Helmets 
    >>Turtle Meat 
    >>Musquash Root 
    >>An Old History Book
step
    .goto Stormwind City,59.90,64.17
    .turnin 1245 >> Turn in The Missing Diplomat
    .accept 1246 >> Accept The Missing Diplomat
step << Warrior/Rogue
    .goto Stormwind City,74.64,52.82 << Rogue
    .goto Stormwind City,74.91,51.55,20,0 << Warrior
    .goto Stormwind City,78.67,45.80 << Warrior
	.trainer >> Train your class spells
step
	.goto Stormwind City,70.53,44.88
    >>When you handin the quest, 2 mobs will spawn and Dashel will turn hostile. Just try to kill Dashel as fast as possible
    .turnin 1246 >> Turn in The Missing Diplomat
    .accept 1447 >> Accept The Missing Diplomat
step
    #completewith next
     >> Beat Dashel Stonefist. Be careful as his 2 adds turn friendly, then back to hostile a few seconds after being beaten
     .complete 1447,1
step
    .goto Stormwind City,70.53,44.88
    .turnin 1447 >> Turn in The Missing Diplomat
    .accept 1247 >> Accept The Missing Diplomat
step
    .goto Stormwind City,59.90,64.17
    .turnin 1247 >> Turn in The Missing Diplomat
    .accept 1248 >> Accept The Missing Diplomat
step << !Mage
    #era
    .goto Stormwind City,43.08,80.39
    .turnin 1078 >> Turn in Retrieval for Mauren
    .isOnQuest 1078
step << !Mage
    .goto Stormwind City,39.76,81.45
    .accept 690 >> Accept Malin's Request
step << !Mage
    >>Enter the Inn
	.goto Stormwind City,40.62,91.83
    .accept 1301 >> Accept James Hyal
step << !Mage
    #completewith next
    .goto Stormwind City,29.2,74.0,20,0
    .goto Stormwind City,27.2,78.1,15 >> Go into The Slaughtered Lamb and go downstairs
step << !Mage
    .goto Stormwind City,26.44,78.66
    .turnin 335 >> Turn in A Noble Brew
    .accept 336 >> Accept A Noble Brew
step << Paladin/Priest
    .goto Stormwind City,42.66,33.75,30,0 << Paladin/Priest
     .goto Stormwind City,38.68,32.85 << Paladin
    .goto Stormwind City,38.54,26.86 << Priest
	.trainer >> Train your class spells
step << Warlock
    .goto Stormwind City,25.25,78.55
    .accept 1798 >> Accept Seeking Strahad
	.trainer >> Train your class spells
step << Warlock
    .goto Stormwind City,25.28,78.22
     >> Skip this step if you already have the same quest from the Ironforge Warlock trainer
    .accept 4738 >> Accept In Search of Menara Voidrender
step
    .goto Stormwind City,75.22,31.67
    .turnin 336 >> Turn in A Noble Brew
step
    .goto Stormwind City,74.16,7.49
    >>Skip this step if you haven't found An Old History Book
    .turnin 337 >> Turn in An Old History Book
    .accept 538 >> Accept Southshore
step << Hunter
    .goto Stormwind City,61.61,15.27
	.trainer >> Train your class spells
step << !Mage
     #completewith next
    .goto Stormwind City,63.73,8.43,30,0
    .zone Ironforge >> Take the Tram to Ironforge
step << Mage
     #completewith next
    .goto Stormwind City,63.73,8.43,30,0
    .zone Ironforge >> Take the Tram or Teleport to Ironforge
step
    .goto Ironforge,55.50,47.70
    .fly Wetlands>> Fly to Wetlands
]])

RXPGuides.RegisterGuide("RestedXP Alliance 30-40",[[
#classic
<< Alliance
#name 32-33 Hillsbrad/Arathi
#next 33-34 Thousand Needles

step
    #sticky
    .goto Wetlands,10.80,60.40
    .turnin 1301 >> Turn in James Hyal
    .accept 1302 >> Accept James Hyal
step
    .goto Wetlands,10.59,60.77
	>>Turning this quest in will start an event. Two level 34 mobs will spawn outside the Inn. Attack them
    .turnin 1248 >> Turn in The Missing Diplomat
    .accept 1249 >> Accept The Missing Diplomat
step
     >> Go outside and defeat Tapoke Jahn. Try to Crowd Control (CC) his friend
     .complete 1249,1
step
    .goto Wetlands,10.59,60.77
    .turnin 1249 >> Turn in The Missing Diplomat
step
    .goto Wetlands,10.54,60.25
    .accept 1250 >> Accept The Missing Diplomat
step
    .goto Wetlands,10.59,60.77
    .turnin 1250 >> Turn in The Missing Diplomat
    .accept 1264 >> Accept The Missing Diplomat
step
    .goto Wetlands,9.49,59.70
    .fly Southshore>> Fly to Southshore
step
    #completewith start
    >>Keep a look out for the Syndicate Assassin event in Southshore
    >>If you manage to kill an Assassin, loot it, turn in the quest, and skip the follow up
	.collect 3668,1,522
    .accept 522 >> Accept Assassin's Contract
    .turnin 522 >> Turn in Assassin's Contract
	.unitscan Shadowy Assassin
step
    .goto Hillsbrad Foothills,52.41,55.96
    .accept 564 >> Accept Costly Menace
step
    .goto Hillsbrad Foothills,50.57,57.09
    .turnin 538 >> Turn in Southshore
step
    .goto Hillsbrad Foothills,50.34,59.04
    .accept 659 >> Accept Hints of a New Plague?
step
    .goto Hillsbrad Foothills,51.46,58.38
    .accept 536 >> Accept Down the Coast
step
    #era
    .goto Hillsbrad Foothills,51.88,58.67
    .accept 555 >> Accept Soothing Turtle Bisque
step
    .goto Hillsbrad Foothills,51.17,58.93
    .home >> Set your Hearthstone to Southshore
step
    .goto Hillsbrad Foothills,46.18,66.57
    .complete 536,1
    .complete 536,2
step
    .goto Hillsbrad Foothills,51.46,58.38
    .turnin 536 >> Turn in Down the Coast
    .accept 559 >> Accept Farren's Proof
step
    .goto Hillsbrad Foothills,32.04,72.81
    .complete 559,1
step
    .goto Hillsbrad Foothills,51.46,58.38
    .turnin 559 >> Turn in Farren's Proof
    .accept 560 >> Accept Farren's Proof
step
    .goto Hillsbrad Foothills,49.47,58.73
    .turnin 560 >> Turn in Farren's Proof
    .accept 561 >> Accept Farren's Proof
step
    .goto Hillsbrad Foothills,48.13,59.10
    .accept 505 >> Accept Syndicate Assassins
step
    .goto Hillsbrad Foothills,51.46,58.38
    .turnin 561 >> Turn in Farren's Proof
    .accept 562 >> Accept Stormwind Ho!
step
    .goto Hillsbrad Foothills,57.31,67.82
     >> Kill Nagas
    .complete 562,1
    .complete 562,2
step
    .goto Hillsbrad Foothills,51.46,58.38
    .turnin 562 >> Turn in Stormwind Ho!
    .accept 563 >> Accept Reassignment
step
    #som
    #label start
    .goto Hillsbrad Foothills,48.96,55.06
     >> Buy 3 Soothing Spices from Micha Yance
     .collect 3713,3
step
    #era
    #label start
    .goto Hillsbrad Foothills,48.96,55.06
     >> Buy 4 Soothing Spices from Micha Yance
     .collect 3713,4
step
    .goto Alterac Mountains,40.15,92.44
     >> Loot granite chunks inside the Yeti cave
    .complete 689,1
step
    #sticky
    #label lions
    .goto Alterac Mountains,30.92,84.58
    .complete 564,1
    .complete 564,2
step
	#sticky
	#label Secretplanz
    .goto Alterac Mountains,58.31,67.92
    .goto Alterac Mountains,48.0,82.0
	>>Click on the scroll on top of the table on either Syndicate camp
    .accept 510 >> Accept Foreboding Plans
    .accept 511 >> Accept Encrypted Letter
step
	>>Kill Syndicates in the area
    .goto Alterac Mountains,58.31,67.92,90,0
    .goto Alterac Mountains,48.0,82.0,90,0
    .goto Alterac Mountains,58.31,67.92
    .goto Alterac Mountains,48.0,82.0,0
    .complete 505,1
    .complete 505,2
step
    #era
    #requires lions
    .goto Hillsbrad Foothills,69.30,12.40
     >> Kill turtles along the river
    .complete 555,1
step
    #requires lions
    #completewith next
    .goto Western Plaguelands,42.93,85.06
    .fp Chillwind>> Get the Western Plaguelands FP
step
    #requires lions
    .goto Western Plaguelands,42.93,85.06
    .fly Southshore>> Fly to Southshore
step
    .goto Hillsbrad Foothills,50.57,57.09
    .turnin 511 >> Turn in Encrypted Letter
    .accept 514 >> Accept Letter to Stormpike
step
    #era
    .goto Hillsbrad Foothills,51.88,58.67
    .turnin 555 >> Turn in Soothing Turtle Bisque
step
    .goto Hillsbrad Foothills,48.13,59.10
    .turnin 505 >> Turn in Syndicate Assassins
    .turnin 510 >> Turn in Foreboding Plans
step
    .goto Hillsbrad Foothills,52.41,55.96
    .turnin 564 >> Turn in Costly Menace
step
    .goto Hillsbrad Foothills,49.34,52.27
    .fly Arathi>> Fly to Arathi Highlands
step
    .goto Arathi Highlands,45.83,47.55
    .accept 681 >> Accept Northfold Manor
step
    .goto Arathi Highlands,46.65,47.01
    .turnin 690 >> Turn in Malin's Request
step
    .goto Arathi Highlands,60.18,53.84
    .turnin 659 >> Turn in Hints of a New Plague?
    .accept 658 >> Accept Hints of a New Plague?
step
    #completewith courier
     >> Use Eagle Eye to find the Forsaken Courier << Hunter
    >> Kill the Forsaken courier if you happen to bump into her. Loot her for the Sealed Folder. She patrols the road between Tarren Mill and Go'Shek Farm
    >>If the courier is not in Arathi, look for it in Hillsbrad after finishing Northfold Manor << Hunter
    .complete 658,1
    .unitscan FORSAKEN COURIER
step
    .goto Arathi Highlands,33.25,30.13
    .complete 681,1
    .complete 681,2
step << Hunter
     #completewith next
    .hs >> Hearth back to Southshore
	>> Buy food/water if needed
step << Hunter
    .goto Hillsbrad Foothills,50.42,58.80
    .stable >> Stable your pet
step <<  Hunter
     #completewith next
    .goto Hillsbrad Foothills,49.34,52.27
    .fly Arathi>> Fly to Arathi Highlands
step
    .goto Arathi Highlands,45.83,47.55
    .turnin 681 >> Turn in Northfold Manor
step <<  Hunter
    #sticky
     >> Use eagle eye to find a level 32/33 spider 
    .train 17265>>Tame it and learn Bite rank 5
step
    #label courier
    .goto Arathi Highlands,60.18,53.84
    >>Turn in the Forsaken Courier quest
     >> Don't go out of your way to find the courier, you can skip this step and finish it later
    .turnin 658 >> Turn in Hints of a New Plague?
step <<  !Hunter
     #completewith next
    .hs >> Hearth to Southshore if you are far away from the Flight Path
	>> Buy food/water if needed
step
    .fly Wetlands>> Fly to Wetlands
]])

RXPGuides.RegisterGuide("RestedXP Alliance 30-40",[[
#classic
<< Alliance
#name 33-34 Thousand Needles
#next 34-35 Stranglethorn Vale I
	
step
    #completewith next
    .goto Wetlands,5.14,63.40,20 >> Go to the end of the dock. Wait here for the boat
step
    .goto Wetlands,4.79,63.67
    .zone Dustwallow Marsh >> Take the boat to Theramore
step
    .goto Dustwallow Marsh,67.47,51.30
    .fp Theramore >> Get the Theramore Flight Path
step
    .goto Dustwallow Marsh,66.15,46.06
    .accept 1282 >> Accept They Call Him Smiling Jim
step
    .goto Dustwallow Marsh,66.45,45.14
    .accept 1135 >> Accept Highperch Venom
step
    .goto Dustwallow Marsh,66.6,45.2
    .home >> Set your Hearthstone to Theramore
step << Hunter
    .goto Dustwallow Marsh,66.0,45.6
    .stable  >> Withdraw your main pet from the stables
step
    .goto Dustwallow Marsh,67.8,48.2
     >>Head to the 2nd floor of the keep, speak with Clerk Lendry
    .turnin 1302 >> Turn in James Hyal
step
    .goto The Barrens,70.74,79.19
    .turnin 1264 >> Turn in The Missing Diplomat
    .accept 1265 >> Accept The Missing Diplomat
    .turnin 1282 >> Turn in They Call Him Smiling Jim
step
    #sticky
    .goto Dustwallow Marsh,66.4,51.4
     >> Make sure you have 3 Soothing Spices
    .collect 3713,3
step
    .goto Dustwallow Marsh,59.72,41.17
     >> Head inside the tower at Sentry Point
     .complete 1265,1
	>>When you turn in, the quest npc will buff you - don't LoS his buff by running out the tower too early
    .turnin 1265 >> Turn in The Missing Diplomat
    .accept 1266 >> Accept The Missing Diplomat
step
    .goto Dustwallow Marsh,55.43,26.26
    .accept 1218 >> Accept Soothing Spices
    .turnin 1218 >> Turn in Soothing Spices
step
    .goto Dustwallow Marsh,55.44,25.92
     >> Click the dirt mound and accept The Orc Report
    .accept 1219 >> Accept The Orc Report
step
    #softcore
    .goto Dustwallow Marsh,45.2,24.6
	>> This next quest you have to beat a level 35 mob while dealing with 2 adds, if you can't do it at this level, skip this step, you will have another opportunity to finish it later
    .turnin 1266 >> Turn in The Missing Diplomat
    .accept 1324 >> Accept The Missing Diplomat
    .isQuestTurnedIn 1264
step
    #hardcore
    .goto Dustwallow Marsh,45.2,24.6
	>> This next quest you have to beat a level 35 mob while dealing with 2 adds, if you can't do it at this level, skip this step, you will have another opportunity to finish it later
    >> BE CAREFUL, THIS QUEST WILL FLAG YOU FOR PVP
    .turnin 1266 >> Turn in The Missing Diplomat
    .accept 1324 >> Accept The Missing Diplomat
    .isQuestTurnedIn 1264
step
	>> You have to beat a level 35 mob while dealing with 2 adds, if you can't do it at this level, skip this step, you will have another opportunity to finish it 
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
	#sticky
	.abandon 1324 >> Abandon The Missing Diplomat quest if you still have it in your quest log
step
	.goto Dustwallow Marsh,35.0,38.2
    .accept 1177 >> Accept Hungry
step
    --.goto Dustwallow Marsh,29.69,47.63
     >> Click on the badge on top of a wooden plank, on the black shield hanging on top of the fireplace and on the hoofprint right outside the inn
    .accept 1284 >> Accept Suspicious Hoofprints
    .goto The Barrens,50.89,78.64
    .accept 1253 >> Accept The Black Shield
    .goto The Barrens,50.86,79.15
    .accept 1252 >> Accept Lieutenant Paval Reethe
    .goto The Barrens,50.96,78.95
step
	#sticky
	#completewith next
    .goto Thousand Needles,32.09,22.33
    .zone Thousand Needles>>Head southwest to Thousand Needles
step
    .goto Thousand Needles,30.72,24.34
    >>Click on the book next to the dead dwarf
    .accept 1100 >> Lonebrow's Journal
step
    .goto Feralas,89.50,45.85
    .fp Thalanaar >> Get the Thalanaar flight path
step
    .goto Thousand Needles,8.1,19.0
    .turnin 1100 >> Turn in Lonebrow's Journal
step
    .goto Thousand Needles,8.05,19.00
    .turnin 1059 >> Turn in Reclaiming the Charred Vale
    .isOnQuest 1059
step
    .goto Dustwallow Marsh,4.16,90.45
     >> Kill Wyverns. Loot them for their Venom Sacs
    .complete 1135,1
step
    .goto Thousand Needles,77.78,77.26
     >> Talk to Kravel Koalbeard 
    .accept 1110 >> Accept Rocket Car Parts
    >>Skip the other 2 quests from this quest giver
step
    .goto Thousand Needles,78.06,77.12
     >> Talk with the gnome brothers
    .accept 1104 >> Accept Salt Flat Venom
    .turnin 1179 >> Turn in The Brassbolts Brothers
    .accept 1105 >> Accept Hardened Shells
step
    .goto Thousand Needles,80.17,75.88
    .accept 1176 >> Accept Load Lightening
step
    .goto Thousand Needles,81.63,77.95
    .accept 1175 >> Accept A Bump in the Road
step
	#label sflats
	#sticky
	>>Run in circles around the race track killing mobs and looting car parts on the ground
    .complete 1176,1 --Collect Hollow Vulture Bone (x10)
    .goto Thousand Needles,87.5,65.6,0
    .complete 1105,1 --Collect Hardened Tortoise Shell (x9)
	.goto Thousand Needles,82.6,54.8,0
    .complete 1175,1 --Kill Saltstone Basilisk (x10)
    .goto Thousand Needles,73.5,59.9,0
    .complete 1104,1 --Collect Salty Scorpid Venom (x6)
    .goto Thousand Needles,71.8,73.4,0
    .complete 1110,1 --Collect Rocket Car Parts (x30)
step
    .goto Thousand Needles,77.6,87.4,0
    .complete 1175,2 --Kill Saltstone Crystalhide (x10)
    .complete 1175,3 --Kill Saltstone Gazer (x6)
step
    #requires sflats
    .goto Thousand Needles,81.63,77.95
    .turnin 1175 >> Turn in A Bump in the Road
step
    .goto Thousand Needles,80.17,75.88
    .turnin 1176 >> Turn in Load Lightening
    .accept 1178 >> Accept Goblin Sponsorship
step
    .goto Thousand Needles,78.14,77.12
    .turnin 1105 >> Turn in Hardened Shells
    .turnin 1104 >> Turn in Salt Flat Venom
step
    .goto Thousand Needles,77.78,77.26
    .turnin 1110 >> Turn in Rocket Car Parts
    .accept 1111 >> Accept Wharfmaster Dizzywig
    .accept 5762 >> Accept Hemet Nesingwary
step
    .goto Tanaris,51.01,29.35
    .fp Tanaris>> Get the Tanaris Flight Path
step
     #completewith next
    .hs >> Hearth to Theramore
	>> Buy food/water if needed
step
    .goto Dustwallow Marsh,66.45,45.14
    .turnin 1135 >> Turn in Highperch Venom
step
    .goto Dustwallow Marsh,68.13,50.41
    .turnin 1219 >> Turn in The Orc Report
    .accept 1220 >> Accept Captain Vimes
step
    .goto Dustwallow Marsh,68.21,48.62
    .turnin 1220 >> Turn in Captain Vimes
    .turnin 1252 >> Turn in Lieutenant Paval Reethe
    .accept 1259 >> Accept Lieutenant Paval Reethe
    .turnin 1253 >> Turn in The Black Shield
    .accept 1319 >> Accept The Black Shield
    .turnin 1284 >> Turn in Suspicious Hoofprints
step
    .goto Dustwallow Marsh,68.04,48.11
    .turnin 1259 >> Turn in Lieutenant Paval Reethe
    .accept 1285 >> Accept Daelin's Men
step
    .goto Dustwallow Marsh,68.21,48.62
    .turnin 1285 >> Turn in Daelin's Men
step
    .goto Dustwallow Marsh,64.75,50.42
    .turnin 1319 >> Turn in The Black Shield
    .accept 1320 >> Accept The Black Shield
step
    .goto Dustwallow Marsh,68.21,48.62
    .turnin 1320 >> Turn in The Black Shield
step <<  Warlock
    .goto Dustwallow Marsh,67.47,51.30
    .fly Ratchet>> Fly to Ratchet
step << !Warlock
    #completewith next
    .goto Dustwallow Marsh,54.25,9.20,80  >> Grind your way northwest towards Ratchet
step << !Warlock
    .goto The Barrens,62.68,36.23
    .zone The Barrens >> Head to the Barrens
step
    .goto The Barrens,62.67,37.44
    .bankdeposit 3721,3521,4521,5847 >> Deposit the following items into your bank:
    >>Farren's Report 
    >>Cleverly Encrypted Letter 
    >>Alterac Granite 
    >>Mirefin Head
step << !Warlock
    .goto The Barrens,63.08,37.16
    .fp Ratchet>> Get the Ratchet Flight Path
step
    .goto The Barrens,62.68,36.23
    .turnin 1178 >> Turn in Goblin Sponsorship
    .accept 1180 >> Accept Goblin Sponsorship
step <<  Warlock
     .isOnQuest 4736
    .goto The Barrens,62.50,35.44
    .turnin 4736 >> Turn in In Search of Menara Voidrender
step <<  Warlock
	.isOnQuest 4738
    .goto The Barrens,62.50,35.44
    .turnin 4738 >> Turn in In Search of Menara Voidrender
step <<  Warlock
    .goto The Barrens,62.62,35.49
    .turnin 1798 >> Turn in Seeking Strahad
    .accept 1758 >> Accept Tome of the Cabal
step
    .goto The Barrens,63.35,38.45
    .turnin 1111 >> Turn in Wharfmaster Dizzywig
    .accept 1112 >> Accept Parts for Kravel
step
    .goto The Barrens,63.35,38.45
    .turnin 1039 >> Turn in The Barrens Port
    .accept 1040 >> Accept Passage to Booty Bay
    .isQuestTurnedIn 1038
step
    #completewith next
	.goto The Barrens,63.64,38.61,40 >> Run to the Ratchet Dock
step
    .goto The Barrens,63.74,38.66
    .zone Stranglethorn Vale >> Take the Boat to Booty Bay
]])


RXPGuides.RegisterGuide("RestedXP Alliance 30-40",[[
#classic
<< Alliance
#name 34-35 Stranglethorn Vale I
#next 35-36 Desolace << Hunter
#next 35-37 Desolace << !Hunter

step
    .goto Stranglethorn Vale,26.34,73.56
    .turnin 1180 >> Turn in Goblin Sponsorship
    .accept 1181 >> Accept Goblin Sponsorship
step
    .goto Stranglethorn Vale,27.36,74.08
    .turnin 1040 >> Turn in Passage to Booty Bay
    .accept 1041 >> Accept The Caravan Road
    .isQuestTurnedIn 1038
step
    .goto Stranglethorn Vale,27.11,77.21
     >> Enter the inn from the bottom floor
    .accept 605 >> Accept Singing Blue Shards
step
	.goto Stranglethorn Vale,27.04,77.31
    .home >> Set your Hearthstone to Booty Bay
step
    .goto Stranglethorn Vale,26.99,77.12
     >> Go upstairs. Speak to Kebok and Krazek 
    .accept 213 >> Accept Hostile Takeover
    .accept 198 >> Accept Supplies to Private Thorsen
    .accept 201 >> Accept Investigate the Camp
    .accept 616 >> Accept The Haunted Isle
step
    .goto Stranglethorn Vale,27.22,76.87
     >> Talk to Baron Revilgaz
    .turnin 616 >> Turn in The Haunted Isle
    .accept 578 >> Accept The Stone of the Tides
    .turnin 1181 >> Turn in Goblin Sponsorship
    .accept 1182 >> Accept Goblin Sponsorship
step
    .goto Stranglethorn Vale,28.29,77.59
    .accept 575 >> Accept Supply and Demand
step
    #sticky
	#label Scrip
    .destroy 3898 >> Throw away the Library Scrip
step
    .goto Stranglethorn Vale,27.53,77.78
    .fly Westfall>> Fly to Westfall
step
	#requires Scrip
    .goto Duskwood,17.72,29.07
    .turnin 231 >> Turn in A Daughter's Love
    .isOnQuest 231
step
    #som
    #completewith ThorsenR
    .goto Duskwood,44.7,88.3
    .zone Stranglethorn Vale >> Head south to Stranglethorn Vale
step
    #sticky
	#completewith STVend
    .goto Stranglethorn Vale,40.32,8.45,0
    >>Look out for Private Thorsen's event while you quest. Guard him from the mobs that attack him, and accept his quest
    >>He patrols down the road down the Rebel Camp every ~30 minutes 
    .accept 215 >> Accept Jungle Secrets
    .turnin 215 >> Turn in Jungle Secrets
	.unitscan Private Thorsen
step
	#label ThorsenR
     >> Run to the Rebel Camp
	>>Skip this step if Private Thorsen isn't here. If you haven't accepted his quest yet, run down the road and look for him
    .goto Stranglethorn Vale,38.01,3.42
    .turnin 198 >> Turn in Supplies to Private Thorsen
step
    .goto Westfall,92.05,81.87
    .accept 203 >> Accept The Second Rebellion
    .accept 204 >> Accept Bad Medicine
step
    #completewith basilisks
     >> Kill Basilisks. Loot them for Shards
    .goto Stranglethorn Vale,24.4,17.2,0
	.goto Stranglethorn Vale,48.48,8.85,0
    .complete 605,1
step
    #sticky
    #label crocs
    .goto Stranglethorn Vale,40.7,14.7,0
	>>Kill River Crocolisks along the river between Lake Nazfereti and the Westfall border
    .complete 575,1
step
    .goto Stranglethorn Vale,35.66,10.52
    .accept 583 >> Accept Welcome to the Jungle
    .turnin 583 >> Turn in Welcome to the Jungle
step
    .goto Stranglethorn Vale,35.61,10.61
    .accept 185 >> Accept Tiger Mastery
    .accept 190 >> Accept Panther Mastery
step
     #completewith next
    .goto Westfall,87.74,95.51
    .turnin 5762 >> Turn in Hemet Nesingwary
step
    .goto Stranglethorn Vale,35.40,12.50
    .complete 185,1
step
    #requires panthers
    .goto Stranglethorn Vale,35.61,10.61
    .turnin 185 >> Turn in Tiger Mastery
    .accept 186 >> Accept Tiger Mastery
step
	#sticky
	#label Boxes
    .goto Stranglethorn Vale,44.08,9.54
	>>Loot the brown boxes outside the house
    .complete 204,2
step
    .goto Stranglethorn Vale,44.93,10.25
     >> Kill Jungle Fighters. Kill Medicine Men for Jungle Remedies
    .complete 203,1
    .complete 204,1
step
	#requires Boxes
    .goto Stranglethorn Vale,46.75,15.81
     >> Kill Tigers, look for Basilisks northeast
    .complete 186,1
step
	#completewith Prints
    .goto Stranglethorn Vale,45.48,20.24,0
     >> Kill Geologists. Loot them for Shards
    .complete 213,1
step
	.goto Stranglethorn Vale,42.52,18.45
	>>Get the key from Foreman Cozzle at the top of the oil rig
	.collect 5851,1
step
    #label Prints
	.goto Stranglethorn Vale,43.4,20.4
	>>Use the Foreman's key to open the chest inside the house
    .complete 1182,1 --Collect Fuel Regulator Blueprints (x1)
step
    .goto Stranglethorn Vale,45.48,20.24
     >> Kill Geologists. Loot them for Shards
    .complete 213,1
step
    .goto Stranglethorn Vale,41.89,12.49
    .complete 190,1
step
    .goto Stranglethorn Vale,37.70,3.30
    .accept 210 >> Accept Krazek's Cookery
step
    .goto Westfall,92.05,81.87
    .turnin 203 >> Turn in The Second Rebellion
    .turnin 204 >> Turn in Bad Medicine
step
    .goto Stranglethorn Vale,38.01,3.42
    .turnin 198 >> Turn in Supplies to Private Thorsen
step
     #completewith next
    .goto Stranglethorn Vale,35.55,10.54
    .turnin 190 >> Turn in Panther Mastery
step
    .goto Westfall,87.67,95.16
    .turnin 186 >> Turn in Tiger Mastery
    .accept 187 >> Accept Tiger Mastery
    .turnin 5762 >> Turn in Hemet Nesingwary
    .accept 194 >> Accept Raptor Mastery
    .accept 191 >> Accept Panther Mastery
step
    #requires crocs
    .goto Stranglethorn Vale,32.8,18.3
    .complete 187,1 --Kill Elder Stranglethorn Tiger (x10)
step
    .goto Stranglethorn Vale,28.5,13.2
    .complete 191,1 --Kill Panther (x10)
step
    #label basilisks
    .goto Stranglethorn Vale,26.87,16.32
     >> Kill Stranglethorn Raptors
    .complete 194,1
step
    .goto Stranglethorn Vale,25.55,17.89
     >> Kill Basilisks. Loot them for Shards
    .complete 605,1
step
    .goto Stranglethorn Vale,20.70,22.70
     >>Head to the Island to the west
     .complete 578,1
step
	#softcore
     #completewith next
     .deathskip >> Die and respawn at the Spirit Healer
step
	#softcore
    .goto Westfall,87.67,95.16
    .turnin 187 >> Turn in Tiger Mastery
    .accept 188 >> Accept Tiger Mastery
    .turnin 191 >> Turn in Panther Mastery
    .accept 192 >> Accept Panther Mastery
    .turnin 194 >> Turn in Raptor Mastery
    .accept 195 >> Accept Raptor Mastery
step
	#hardcore
	>>Run back to Hemet's Camp
    .goto Westfall,87.67,95.16
    .turnin 187 >> Turn in Tiger Mastery
    .accept 188 >> Accept Tiger Mastery
    .turnin 191 >> Turn in Panther Mastery
    .accept 192 >> Accept Panther Mastery
    .turnin 194 >> Turn in Raptor Mastery
    .accept 195 >> Accept Raptor Mastery
step << Druid
    >>Teleport to Moonglade
	.goto Moonglade,52.53,40.56
    .trainer >> Train your class spells
step
	#label STVend
    .hs >> Hearth to Booty Bay
	>> Buy food/water if needed
step
    .goto Stranglethorn Vale,27.11,77.21
    .turnin 605 >> Turn in Singing Blue Shards
step
    .goto Stranglethorn Vale,26.94,77.20
    .turnin 201 >> Turn in Investigate the Camp
    .turnin 210 >> Turn in Krazek's Cookery
step
    .goto Stranglethorn Vale,26.99,77.12
    .turnin 213 >> Turn in Hostile Takeover
    .accept 189 >> Accept Bloodscalp Ears
step
    .goto Stranglethorn Vale,27.22,76.87
    .turnin 1182 >> Turn in Goblin Sponsorship
    .accept 1183 >> Accept Goblin Sponsorship
    .turnin 578 >> Turn in The Stone of the Tides
    .accept 601 >> Accept Water Elementals
step
    .goto Stranglethorn Vale,28.29,77.59
    .turnin 575 >> Turn in Supply and Demand
    .accept 577 >> Accept Some Assembly Required
step << !Hunter
    #completewith next
    .goto Stranglethorn Vale,27.53,77.79
    .fly Duskwood >> Fly to Duskwood
step << !Hunter
    .goto Duskwood,72.6,46.8
    .turnin 1041
    .accept 1042
    .isQuestTurnedIn 1040
step << !Hunter
    .goto Duskwood,75.2,48.8
    .turnin 1042
    .accept 1043
    .isQuestTurnedIn 1040
step << !Hunter
    .goto Duskwood,733.7,79.0
    >>Click on the dirt mound inside the mine
    .complete 1043,1
    .isQuestTurnedIn 1040
step << !Hunter
	#softcore
    #completewith next
    .deathskip >> Die and respawn at the graveyard
step << !Hunter
	#softcore
    .goto Duskwood,75.2,48.8
    .turnin 1043
    .accept 1044
    .isQuestTurnedIn 1040
step << !Hunter
	#hardcore
	>>Run back to Darkshire
    .goto Duskwood,75.2,48.8
    .turnin 1043
    .accept 1044
    .isQuestTurnedIn 1040
step << Mage
	.zone Stormwind City >> Teleport to Stormwind
	.trainer >> Train your class spells
step << !Mage
    .goto Duskwood,77.49,44.29 << !Hunter
    .goto Stranglethorn Vale,27.53,77.78 << Hunter
    .fly Stormwind>> Fly to Stormwind
step << !Warlock
    #completewith next
    >>Withdraw water breathing potions from your bank if you have them. Otherwise, skip this step
    .collect 5996,1
step
    .goto Stormwind City,57.00,72.88
    .bankwithdraw 3721,3521,4521 >> Withdraw the following items: 
    >>Farren's Report 
    >>Cleverly Encrypted Letter 
    >>Alterac Granite 
step << !Mage !Warlock !Hunter
    .goto Stormwind City,74.64,52.82 << Rogue
    .goto Stormwind City,74.91,51.55,20,0 << Warrior
    .goto Stormwind City,78.67,45.80 << Warrior
    .goto Stormwind City,42.66,33.75,30,0 << Paladin/Priest
     .goto Stormwind City,38.68,32.85 << Paladin
    .goto Stormwind City,38.54,26.86 << Priest
    .goto Stormwind City,74.91,51.55,20,0 << Warrior
    .goto Stormwind City,78.67,45.80 << Warrior
    .goto Stormwind City,74.64,52.82 << Rogue
	.trainer >> Train your class spells
step
    .goto Stormwind City,72.60,15.85
    .turnin 563 >> Turn in Reassignment
step
    .goto Stormwind City,74.16,7.49
     >> Skip this step if you haven't found the quest item
    .accept 337 >> Accept An Old History Book
    .turnin 337 >> Turn in An Old History Book
    .accept 538 >> Accept Southshore
step << Hunter
    .goto Stormwind City,61.61,15.27
	.trainer >> Train your class and pet spells
step
     #completewith next
    .goto Stormwind City,63.73,8.43,30,0
    .zone Ironforge >> Take the tram to Ironforge
step
    .goto Ironforge,67.91,17.50
    .accept 1453 >> Accept Reclaimers' Business in Desolace
step <<  Warlock
    .goto Ironforge,74.18,9.39
    .turnin 1758 >> Turn in Tome of the Cabal
step << Warlock
    .goto Ironforge,50.35,5.63 << Warlock
	.trainer >> Train your class spells
step << Warlock
    .goto Ironforge,52.71,6.07 << Warlock
	.vendor >> Buy spellbooks for your Succubus/Voidwalker if needed
step
    .goto Ironforge,74.64,11.74
    .turnin 514 >> Turn in Letter to Stormpike
    .accept 525 >> Accept Further Mysteries
step
    .goto Ironforge,39.03,88.05
    .turnin 689 >> Turn in A King's Tribute
     >> Wait for the RP sequence to end (takes about 75 seconds)
    .accept 700 >> Accept A King's Tribute
step
    .goto Ironforge,39.09,56.19
    .turnin 700 >> Turn in A King's Tribute
step
    #label end
    .goto Ironforge,55.50,47.74
    .fly Wetlands>> Fly to Wetlands
]])

RXPGuides.RegisterGuide("RestedXP Alliance 30-40",[[
#classic
<< Alliance Hunter
#name 35-36 Desolace
#next 36-38 Stranglethorn Vale II

step
    #completewith next
    +Wait here for the boat
    .goto Wetlands,4.7,57.3
step
    .zone Darkshore >>Get onto the boat when it comes. Take it to Darkshore.
step
    .goto Darkshore,36.33,45.58
    .fly Stonetalon>> Fly to Stonetalon
step
     #completewith next
    .goto Desolace,54.76,0.47
    .zone Desolace >> Head to Desolace
    >>Fly to Desolace if you have the flight path
step
    .goto Desolace,66.40,11.82
    .accept 1437 >> Accept Vahlarriel's Search
step
    .goto Desolace,64.66,10.53
    .fp Desolace>> Get the Desolace Flight Path
step
    .goto Desolace,66.28,6.55
    .home >> Set your Hearthstone to Nijel's Point
step
    #som
    .goto Desolace,66.51,7.90
    .accept 261 >> Accept Down the Scarlet Path
step
    .goto Desolace,66.20,9.62
    .turnin 1453 >> Turn in Reclaimers' Business in Desolace
    .accept 1454 >> Accept The Karnitol Shipwreck
    .accept 1458 >> Accept Reagents for Reclaimers Inc.
step
    .goto Desolace,66.74,10.87
    .accept 1387 >> Accept Centaur Bounty
    .accept 1382 >> Accept Strange Alliance
step
    .goto Desolace,78.06,22.55
     >> Kill Satyrs. Loot them for Claws and Horns
    .complete 1458,1
    .complete 1458,2
step
    .goto Desolace,66.20,9.62
    .turnin 1458 >> Turn in Reagents for Reclaimers Inc.
    .accept 1459 >> Accept Reagents for Reclaimers Inc.
step
    #completewith kodos
     >> Kill Scorpids/Aged Kodos as you quest. Loot them for Venom and Hides
	>>If you can't find that many Scorpids, you may have to kill Basilisks as they share spawns with each other
    .complete 1459,1
    .complete 1459,2
step
    .goto Desolace,56.52,17.84
    .turnin 1437 >> Turn in Vahlarriel's Search
    .accept 1465 >> Accept Vahlarriel's Search
step
    .goto Desolace,38.88,27.16
    .accept 5741 >> Accept Sceptre of Light
step
    .goto Desolace,36.11,30.45
     >> Click on the small chest on the ground
    .turnin 1454 >> Turn in The Karnitol Shipwreck
    .accept 1455 >> Accept The Karnitol Shipwreck
step
    .goto Desolace,36.06,30.40
     >> Click on the small book on the ground next to the chest
    .accept 6161 >> Accept Claim Rackmore's Treasure!
step
    .goto Desolace,33.10,29.80
     >> Murder some crab people. Loot the evil crab people for the Silver Key
    .complete 6161,1
step
     #completewith next
     >> Grind until your Hearthstone is off cooldown 
    .hs >>Hearth back to Nijel's Point
	>> Buy food/water if needed
step
    .goto Desolace,66.20,9.62
    .turnin 1455 >> Turn in The Karnitol Shipwreck
    .accept 1456 >> Accept The Karnitol Shipwreck
step
    .goto Desolace,66.44,11.81
    .turnin 1465 >> Turn in Vahlarriel's Search
    .accept 1438 >> Accept Vahlarriel's Search
step
    .goto Desolace,55.16,30.14
     >> Climb the tower, kill a Burning Blade Seer
    .complete 5741,1
step
    .goto Desolace,54.85,26.12
    .turnin 1438 >> Turn in Vahlarriel's Search
    .accept 1439 >> Accept Search for Tyranis
step
    .goto Desolace,53.00,29.07
	>>Go into the building. Kill Tyranis and loot him for the Pendant
    .complete 1439,1
step
    #completewith next
    .goto Desolace,54.85,26.12
    .turnin 1439 >> Turn in Search for Tyranis
step
    .goto Desolace,54.85,26.12
    >> Start the escort quest
    .accept 1440 >> Accept Return to Vahlarriel
step
     >> Escort Dalinda Malem
     .complete 1440,1
step
    .goto Desolace,62.32,38.98
    .accept 5501 >> Accept Bone Collector
step
    .goto Desolace,60.86,61.86
    .accept 5561 >> Accept Kodo Roundup
step
    .goto Desolace,72.00,76.00
     >> Kill Centaurs. Loot them for their Ears
    .complete 1387,1
    .reputation 92,friendly >> Keep killing Centaurs until you get friendly reputation with Gelkis Centaur
step
    #sticky
    #label bones
    .goto Desolace,49.7,57.2,0
    >>Loot the Kodo Bones around the graveyard. Be careful as mobs can spawn from them
    .complete 5501,1
step
    .goto Desolace,60.86,61.86,0
    >>Head towards the Kodo Graveyard and use the Kodo Kombobulator in your inventory to escort a Kodo back to the quest giver
    >>Be on the lookout for the Kodos that patrol the zone
    .complete 5561,1
step
    #label kodos
    .goto Desolace,60.86,61.86
    .turnin 5561 >> Turn in Kodo Roundup
step
    #era
    #hardcore
    .goto Desolace,36.21,79.24
    .turnin 1382 >> Turn in Strange Alliance
step
    .goto Desolace,70.14,33.92
     >> Finish off the Scorpids and Aged Kodos, looting them for Venom and Hides
	>>If you can't find that many Scorpids, you may have to kill Basilisks as they share spawns with each other
    .complete 1459,1
    .complete 1459,2
step
    #requires bones
    .goto Desolace,62.32,38.98
    .turnin 5501 >> Turn in Bone Collector
step
    .goto Desolace,38.88,27.16
    .turnin 5741 >> Turn in Sceptre of Light
    .accept 6027 >> Accept Book of the Ancients
step
    #sticky
    #label key
     >> Kill Nagas. Loot them for the Key
    .complete 6161,2
step
    #sticky
    #label nagas
     >> Kill Sea Witches/Tidehunters. Loot them for the Satchel
	>>This item has a low droprate. Be patient
    .complete 1456,1
step
    .goto Desolace,28.26,6.57
     >> Click on the Naga Statue to summon Lord Kragaru. Kill and loot him for the Book
    .complete 6027,1
step
    #requires key
    .goto Desolace,30.00,8.70
	>>Click on the chest
    .turnin 6161 >> Turn in Claim Rackmore's Treasure!
step
    #requires nagas
	>>Swim back to the mainland
    .goto Desolace,38.88,27.16
    .turnin 6027 >> Turn in Book of the Ancients
step
    #era
    #softcore
    #completewith next
    .hs >> Hearth to Nijel's Point
	>> Buy food/water if needed
step << Hunter
    #era
    #softcore
     #completewith tame
    .stable >> Stable your pet
step
    .goto Desolace,66.20,9.62
    .turnin 1456 >> Turn in The Karnitol Shipwreck
    .accept 1457 >> Accept The Karnitol Shipwreck
    .turnin 1459 >> Turn in Reagents for Reclaimers Inc.
step
    #som
    .goto Desolace,66.20,9.62
    .accept 1466 >> Accept Reagents for Reclaimers Inc.
step
    .goto Desolace,66.74,10.87
    .turnin 1387 >> Turn in Centaur Bounty
step
    .goto Desolace,66.44,11.81
    .turnin 1440 >> Turn in Return to Vahlarriel
step <<  Hunter
    #label tame
    #era
    #sticky
    .goto Desolace,43.6,62.4,0
    .goto Desolace,78.8,15.8,0
     >> Tame a Scorpashi Lasher 
    .train 2975 >>Learn claw rank 5
step
    #som
    .goto Desolace,63.76,90.25
    .complete 261,1
step
    #som
    .goto Desolace,51.72,83.79
    >>Kill Felhounds/Succubi/Doomwarder Captains. Loot them for brains, wings and blood
    .complete 1466,1
    .complete 1466,2
    .complete 1466,3
step
    #softcore
    #era
    #completewith next
    .deathskip >> Die and respawn at the Kodo Graveyard
step
    .goto Desolace,36.21,79.24
    .turnin 1382 >> Turn in Strange Alliance
step
    #hardcore
    .hs >> Hearth to Nijel's Point
	>> Buy food/water if needed
step
    #hardcore
    #som
    .goto Desolace,66.51,7.90
    .turnin 261 >> Turn in Down the Scarlet Path
    .accept 1052 >> Accept Down the Scarlet Path
step
    #hardcore
    #som
    .goto Desolace,66.20,9.62
    .turnin 1466 >> Turn in Reagents for Reclaimers Inc.
    .accept 1467 >> Accept Reagents for Reclaimers Inc.
step <<  Hunter
    #hardcore
     #completewith next
    .stable >> Stable your pet
step <<  Hunter
    #hardcore
    #sticky
    .goto Desolace,43.6,62.4,0
    .goto Desolace,78.8,15.8,0
     >> Tame a Scorpashi Lasher 
    .train 2975 >>Learn Claw Rank 5
step
    #softcore
    .goto Desolace,41.13,91.72
    .zone Feralas >> Head to Feralas
step
    #softcore
    #completewith end
    .goto Feralas,40.6,8.6
    >> Once you get to Feralas, walk along the mountains to the west to avoid aggroing mobs and then die near the stone obelisks
    .deathskip >> Spirit rez at Feathermoon
step
    #softcore
    #label end
    .goto Feralas,30.2,43.3
    .fp Feathermoon>>Get the Feathermoon flight path
    .fly Tanaris>> Fly to Tanaris
step
	#hardcore
    .goto Desolace,64.66,10.54
    .fly Tanaris>> Fly to Tanaris
step
    .goto Thousand Needles,77.78,77.26
     >> Run to Thousand Needles
    .turnin 1112 >> Turn in Parts for Kravel
step << Hunter
    .goto Thousand Needles,78.14,77.12
    .accept 1107 >> Accept Encrusted Tail Fins
step
    .goto Thousand Needles,80.17,75.88
    .turnin 1183 >> Turn in Goblin Sponsorship
    .accept 1186 >> Accept The Eighteenth Pilot
step
    .goto Thousand Needles,80.32,76.09
    .turnin 1186 >> Turn in The Eighteenth Pilot
    .accept 1187 >> Accept Razzeric's Tweaking
step
    .goto Thousand Needles,77.78,77.26
    .accept 1114 >> Accept Delivery to the Gnomes
step
    .goto Thousand Needles,78.06,77.12
    .turnin 1114 >> Turn in Delivery to the Gnomes
step
    .goto Thousand Needles,77.78,77.26
    .accept 1115 >> Accept The Rumormonger
step
    #som
    #softcore
    .hs >> Hearth to Nijel's Point
	>> Buy food/water if needed
step <<  Hunter
    #som
    #softcore
    .stable >> Stable your pet
step
    #som
    #softcore
    .goto Desolace,66.51,7.90
    .turnin 261 >> Turn in Down the Scarlet Path
    .accept 1052 >> Accept Down the Scarlet Path
step
    #som
    #softcore
    .goto Desolace,66.20,9.62
    .turnin 1466 >> Turn in Reagents for Reclaimers Inc.
    .accept 1467 >> Accept Reagents for Reclaimers Inc.
step <<  Hunter
    #som
    #softcore
    #sticky
    .goto Desolace,43.6,62.4,0
    .goto Desolace,78.8,15.8,0
     >> Tame a Scorpashi Lasher 
    .train 2975 >>Learn claw rank 5
step
	#hardcore
    .goto Desolace,64.66,10.54
    .fly Ratchet >> Fly to Ratchet and take the boat to Booty Bay
step
	#hardcore
    #completewith next
	.goto The Barrens,63.64,38.61,40 >> Run to the Booty bay Dock
step
	#hardcore
    .goto The Barrens,63.74,38.66
    .zone Stranglethorn Vale >> Take the Boat to Booty Bay
step
	#softcore
    #label booty
    #completewith sw
    .goto Desolace,64.66,10.54
    .fly Ratchet >> Fly to Ratchet and take the boat to Booty Bay 
step
	#softcore
    #label sw
    #completewith booty
    .zone Stormwind City >>Alternatively, you can use the unstuck self service through the battle.net website and teleport to Stormwind
]])

RXPGuides.RegisterGuide("RestedXP Alliance 30-40",[[
#classic
<< Alliance !Hunter
#name 35-37 Desolace
#next 36-38 Stranglethorn Vale II

step
    .goto Ironforge,67.91,17.50
     >> Go to Ironforge
    .accept 1453 >> Accept Reclaimers' Business in Desolace
step
    #completewith next
    .goto Ironforge,55.49,47.75
    .fly Wetlands>> Fly to Wetlands
step
    #sticky
    #completewith next
    +Wait here for the boat.
    .goto Wetlands,4.7,57.3
step
    .zone Darkshore >>Get onto the boat when it comes. Take it to Darkshore.
step
    .goto Darkshore,36.33,45.58
    .fly Stonetalon>> Fly to Stonetalon
step
     #completewith next
    .goto Desolace,54.76,0.47
    .zone Desolace >> Head to Desolace
    >>Fly to Desolace if you have the flight path
step
    .goto Desolace,66.44,11.81
    .accept 1437 >> Accept Vahlarriel's Search
step
    .goto Desolace,64.66,10.53
    .fp Desolace>> Get the Desolace Flight Path
step
    .goto Desolace,66.28,6.55
    .home >> Set your Hearthstone to Nijel's Point
step
    .goto Desolace,66.20,9.62
    .turnin 1453 >> Turn in Reclaimers' Business in Desolace
    .accept 1454 >> Accept The Karnitol Shipwreck
    .accept 1458 >> Accept Reagents for Reclaimers Inc.
step
    .goto Desolace,66.74,10.87
    .accept 1387 >> Accept Centaur Bounty
    .accept 1382 >> Accept Strange Alliance
step
    .goto Desolace,78.06,22.55
     >> Kill Satyrs. Loot them for Claws and Horns
    .complete 1458,1
    .complete 1458,2
step
    .goto Desolace,66.20,9.62
    .turnin 1458 >> Turn in Reagents for Reclaimers Inc.
    .accept 1459 >> Accept Reagents for Reclaimers Inc.
step
    #sticky
    #label reagents
     >> Kill Scorpids/Aged Kodos as you quest. Loot them for Venom and Hides
	>>If you can't find that many Scorpids, you may have to kill Basilisks as they share spawns with each other
    .complete 1459,1
    .complete 1459,2
step
    .goto Desolace,56.52,17.84
    .turnin 1437 >> Turn in Vahlarriel's Search
    .accept 1465 >> Accept Vahlarriel's Search
step
    .goto Desolace,38.88,27.16
    .accept 5741 >> Accept Sceptre of Light
step
    .goto Desolace,36.11,30.45
     >> Click on the small chest on the ground
    .turnin 1454 >> Turn in The Karnitol Shipwreck
    .accept 1455 >> Accept The Karnitol Shipwreck
step
    .goto Desolace,36.06,30.40
     >> Click on the small book on the ground next to the chest
    .accept 6161 >> Accept Claim Rackmore's Treasure!
step
    .goto Desolace,33.10,29.80
     >> Murder some crab people. Loot the evil crab people for the Silver Key
    .complete 6161,1
step
    .goto Desolace,60.86,61.86
    .accept 5561 >> Accept Kodo Roundup
step
    .goto Desolace,72.00,76.00
     >> Kill Centaurs. Loot them for their Ears
    .complete 1387,1
     >> Keep killing centaurs until you get friendly rep. with Gelkis centaur
    .reputation 92,friendly
step
    .goto Desolace,36.21,79.24
    .turnin 1382 >> Turn in Strange Alliance
    .accept 1384 >> Accept Raid on the Kolkar
step
     #completewith next
	>> Grind until your Hearthstone is off cooldown 
    .hs >>Hearth back to Nijel's Point
	>> Buy food/water if needed
step
    .goto Desolace,66.20,9.62
    .turnin 1455 >> Turn in The Karnitol Shipwreck
    .accept 1456 >> Accept The Karnitol Shipwreck
step
    .goto Desolace,66.44,11.81
    .turnin 1465 >> Turn in Vahlarriel's Search
    .accept 1438 >> Accept Vahlarriel's Search
step
    .goto Desolace,73.46,48.63
    >>Kill Centaurs. Loot them for their Charms
    .complete 1384,1
step
    .goto Desolace,62.32,38.98
    .accept 5501 >> Accept Bone Collector
step
    .goto Desolace,55.16,30.14
     >> Climb the tower, kill a Burning Blade Seer
    .complete 5741,1
step
    .goto Desolace,54.85,26.12
    .turnin 1438 >> Turn in Vahlarriel's Search
    .accept 1439 >> Accept Search for Tyranis
step
    .goto Desolace,53.00,29.07
    .complete 1439,1
step
    #completewith next
    .goto Desolace,54.85,26.12
    .turnin 1439 >> Turn in Search for Tyranis
step
    .goto Desolace,54.85,26.12
    >>Start the escort quest
    .accept 1440 >> Accept Return to Vahlarriel
step
     >> Escort Dalinda Malem
     .complete 1440,1
step
    .goto Desolace,38.88,27.16
    .turnin 5741 >> Turn in Sceptre of Light
    .accept 6027 >> Accept Book of the Ancients
step
    #sticky
    #label key
     >> Kill Nagas. Loot them for the Key
    .complete 6161,2
step
    #label nagas
    #sticky
     >> Kill Sea Witches/Tidehunters. Loot them for the Satchel
	>>This item has a low droprate. Be patient
    .complete 1456,1
step
    .goto Desolace,28.26,6.57
     >> Click on the Naga Statue to summon Lord Kragaru. Kill and loot him for the Book
    .complete 6027,1
step
    #requires key
    .goto Desolace,30.00,8.70
    .turnin 6161 >> Turn in Claim Rackmore's Treasure!
step
    #requires nagas
    .goto Desolace,38.88,27.16
    .turnin 6027 >> Turn in Book of the Ancients
step
    .goto Desolace,36.21,79.24
    .turnin 1384 >> Turn in Raid on the Kolkar
    .accept 1370 >> Accept Stealing Supplies
step
     #completewith next
    .goto Desolace,52.50,58.56
     >> Loot the Kodo Bones around the graveyard. Be careful as mobs can spawn from them once looted
    .complete 5501,1
step
    .goto Desolace,60.86,61.86
    >> Use the quest item provided to wrangle kodos to the quest giver
    >>Be on the lookout for the kodos that patrol the area
    .complete 5561,1
step
    .goto Desolace,60.86,61.86
    .turnin 5561 >> Turn in Kodo Roundup
step
    .goto Desolace,73.59,73.73
    >>Look for yellow bags on the ground. Loot them for the Dried Meat
    .complete 1370,1
step
    .goto Desolace,52.50,58.56
     >> Loot the Kodo Bones around the graveyard. Be careful as mobs can spawn from them once looted
    .complete 5501,1
step
    .goto Desolace,52.19,57.50
     >> Kill Aged Kodos. Loot them for their Aged Kodo Hides
    .complete 1459,2
step
    .goto Desolace,62.32,38.98
    .turnin 5501 >> Turn in Bone Collector
step
    .goto Desolace,70.14,33.92
     >> Kill Scorpids. Loot them for their Venom
	>>If you can't find that many Scorpids, you may have to kill Basilisks as they share spawns with each other
    .complete 1459,1
step
	#softcore
     #completewith next
     .deathskip >> Die and respawn at the Spirit Healer
step
	#softcore
    .goto Desolace,36.21,79.24
    .turnin 1370 >> Turn in Stealing Supplies
    .accept 1373 >> Accept Ongeku
step
	#hardcore
	>>Run South-west to the Centaur
    .goto Desolace,36.21,79.24
    .turnin 1370 >> Turn in Stealing Supplies
    .accept 1373 >> Accept Ongeku
step
    .hs >> Hearth back to Nijel's Point
	>> Buy food/water if needed
step
    .goto Desolace,66.20,9.62
    .turnin 1456 >> Turn in The Karnitol Shipwreck
    .accept 1457 >> Accept The Karnitol Shipwreck
    .turnin 1459 >> Turn in Reagents for Reclaimers Inc.
step
    .goto Desolace,66.74,10.87
    .turnin 1387 >> Turn in Centaur Bounty
step
    .goto Desolace,66.44,11.81
    .turnin 1440 >> Turn in Return to Vahlarriel
step
    .goto Desolace,64.66,10.54
    .fly Tanaris>> Fly to Tanaris
step
    .goto Thousand Needles,77.78,77.26
     >> Run to Thousand Needles
    .turnin 1112 >> Turn in Parts for Kravel
step
    .goto Thousand Needles,80.17,75.88
    .turnin 1183 >> Turn in Goblin Sponsorship
    .accept 1186 >> Accept The Eighteenth Pilot
step
    .goto Thousand Needles,80.32,76.09
    .turnin 1186 >> Turn in The Eighteenth Pilot
    .accept 1187 >> Accept Razzeric's Tweaking
step
    .goto Thousand Needles,77.78,77.26
    .accept 1114 >> Accept Delivery to the Gnomes
step
    .goto Thousand Needles,78.06,77.12
    .turnin 1114 >> Turn in Delivery to the Gnomes
step
    .goto Thousand Needles,77.78,77.26
    .accept 1115 >> Accept The Rumormonger
step
	#hardcore
    .goto Tanaris,50.52,18.94
    .fly Ratchet >>Fly to Ratchet and take the boat to Booty Bay
step
	#hardcore
    #completewith next
	.goto The Barrens,63.64,38.61,40 >> Run to the Booty bay Dock
step
	#hardcore
    .goto The Barrens,63.74,38.66
    .zone Stranglethorn Vale >> Take the Boat to Booty Bay
step
	#softcore
    #label booty
    #completewith sw
    .goto Tanaris,50.52,18.94
    >> You have 2 options going into the next segment: 
    .fly Ratchet >>Fly to Ratchet and take the boat to Booty Bay 
step
	#softcore
    #label sw
    #completewith booty
    .zone Stormwind City >>Alternatively, you can use the unstuck self service through the battle.net website and teleport to Stormwind
--N Trainer add here? having the two route thing is very convoluted
]])


RXPGuides.RegisterGuide("RestedXP Alliance 30-40",[[
#classic
<< Alliance
#name 36-38 Stranglethorn Vale II
#next 38-39 Swamp of Sorrows

step
	#sticky
	#label BankD1
	>>Head to Booty Bay
    .goto Stranglethorn Vale,26.56,76.50
    .bankdeposit 6253,3518,5539,6245,5827,3404 >> Deposit the following items into your bank:
    >>Karnitol's Satchel 
    >>Decrypted Letter 
    >>Letter of Commendation 
    >>Fizzle Brassbolts' Letter 
    >>Buzzard Wing
step
	#sticky
	#label BankW1
    .bankwithdraw 2719,5996 >> Withdraw the Small Brass Key from your bank (if you have it) << !Warlock
    .bankwithdraw 2719 >> Withdraw the Small Brass Key from your bank (if you have it) << Warlock
	>>Withdraw the Water Breathing Potions from your bank (if you have them) << !Warlock
	>>If you don't have one or other of the items, skip this step
step
	#requires BankD1
step << !Warlock
	#requires BankW1
    .goto Stranglethorn Vale,26.59,76.37
    >>If you didn't have any Water Breathing potions in your bank, buy some from the neutral Auction House. Skip this step if you can't find them.
    .collect 5996,1
step
	#requires BankW1
     #completewith next
    .goto Stranglethorn Vale,26.94,77.20
    .turnin 1115 >> Turn in The Rumormonger
step
    .goto Stranglethorn Vale,26.99,77.12
    .accept 189 >> Accept Bloodscalp Ears
    .accept 601 >> Accept Water Elementals
    .accept 577 >> Accept Some Assembly Required
step
    #sticky
	#softcore
    .home >> Set your Hearthstone to Booty Bay 
    >>OR
    >>Set your Hearthstone to Duskwood or Westfall if you used the unstuck self service to teleport to Stormwind
step
    #sticky
	#hardcore
    .goto Stranglethorn Vale,27.04,77.31
    .home >> Set your Hearthstone to Booty Bay 
step
	#hardcore
    .goto Stranglethorn Vale,27.53,77.79
    .fly Westfall >> Fly to Westfall
step
	#softcore
    #label start1
    #completewith start2
    .fly >> Fly to Westfall or Duskwood
step
    .goto Duskwood,7.78,34.06
    .turnin 325 >> Turn in Armed and Ready
    .accept 55 >> Accept Morbent Fel
step
    .goto Duskwood,19.59,37.28
     >> Kill Mor'Ladim, he patrols around the northern side of the graveyard
    >>He hits very hard but can be easily kited
    .complete 228,1
    .unitscan MOR'LADIM
step
    .goto Duskwood,16.90,33.40
     >> Kill Morbent Fel 
    >>Use the off-hand weapon provided to remove his shield
    >>This quest can be hard, proceed with caution
    .complete 55,1
step
    .goto Duskwood,7.78,34.06
    .turnin 55 >> Turn in Morbent Fel
step
    #label start2
    .goto Stranglethorn Vale,38.01,3.32
	>>Run to Rebel camp in northern Stranglethorn Vale
	.accept 574 >> Accept Special Forces
    .accept 207 >> Accept Kurzen's Mystery
step
	.isQuestTurnedIn 215
    .goto Stranglethorn Vale,38.04,3.01
    .accept 200 >> Accept Bookie Herod
step
    .goto Stranglethorn Vale,35.55,10.54
    .accept 192 >> Accept Panther Mastery
    .accept 195 >> Accept Raptor Mastery
    .accept 188 >> Accept Tiger Mastery
step
    .goto Stranglethorn Vale,43.67,9.37
     >> Click on the pile of books upstairs in the house
    .turnin 200 >> Turn in Bookie Herod
    .accept 328 >> Accept The Hidden Key
    .isQuestTurnedIn 215
step
    .goto Stranglethorn Vale,49.61,7.56
    >>Enter the cave north of the compound
    .turnin 328 >> Turn in The Hidden Key
    .accept 329 >> Accept The Spy Revealed!
    .isQuestTurnedIn 215
step
    .goto Stranglethorn Vale,47.05,7.47
    >>Enter the cave north of the compound. Kill Commandos (they're stealthed and stun), and Headshrinkers
    .complete 574,1
    .complete 574,2
step
    .goto Stranglethorn Vale,48.64,22.95,90,0
    .goto Stranglethorn Vale,36.09,37.29,90,0
    .goto Stranglethorn Vale,48.64,22.95
    .goto Stranglethorn Vale,36.09,37.29,0
     >> Kill Shadowmaw Panthers in the area. They're stealthed
	>> You can find more further south-west if needed
    .complete 192,1
step
    #sticky
    #label raptors
    .goto Stranglethorn Vale,38.10,20.50
     >> Kill Lashtail Raptors. Be careful as they have a 2 second stun and Disarm
    .complete 195,1
step
    .goto Stranglethorn Vale,39.1,27.2
    >> Kill Crocolisks along the river between Lake Nazfereti and the river mouth. Loot them for their skin
    .complete 577,1
step
    #requires raptors
    >>Kill Sin'Dall. Loot him for his Paw
	>>He can either be on top of the Plateau, or patrolling around it
	.goto Stranglethorn Vale,32.2,17.4
    .complete 188,1 --Collect Paw of Sin'Dall (x1)
	.unitscan Sin'Dall
step
    #sticky
     #label ears
    .goto Stranglethorn Vale,25.52,9.36,0
     >> Kill Bloodscalp Trolls. Loot them for their ears
    .complete 189,1
step
    .goto Stranglethorn Vale,29.48,19.14
     >> Loot the first tablet
    .complete 207,1
step
    .goto Stranglethorn Vale,24.69,8.92
     >> Loot the fourth tablet
    .complete 207,4
step
    .goto Stranglethorn Vale,22.94,12.01
     >> Loot the third tablet
    .complete 207,3
step
    #requires ears
    .goto Stranglethorn Vale,25.52,9.36
     xp 38+58000 >> Grind to level 38 and 58000+/80000xp
step
    .goto Stranglethorn Vale,21.55,23.51
     >> Kill Water Elementals. Loot them for their bracers
    .complete 601,1
step
    .goto Stranglethorn Vale,24.82,23.02
     >> Loot the second tablet underwater
    .complete 207,2
step
    #sticky
    #label pearls
    .goto Stranglethorn Vale,24.42,24.46
     >> Collect 9 Blue Pearls from the clams around the coral reef while avoiding the elite murlocs
     >>Skip this step if you don't have water breathing potions << !Warlock
     >>This quest can be hard, skip it if you have to << !Hunter
    .collect 4611,9
step <<  Hunter
    .goto Stranglethorn Vale,24.42,24.46
     >> Kill Murlocs for Encrusted Tail Fins, only kill 1 murloc at a time and avoid fighting the casters, they are more trouble than they are worth
     >>Skip this step if you don't have water breathing potions
    .complete 1107,1
step
    #requires pearls
    .goto Stranglethorn Vale,21.55,23.51
    .xp 38+62200 >> Grind to level 38 and 62200+/80000xp
step
	#softcore
     #completewith next
     .deathskip >> Die and respawn at the Spirit Healer
step
	#softcore
    .goto Stranglethorn Vale,37.83,3.56
    .turnin 207 >> Turn in Kurzen's Mystery
    .accept 205 >> Accept Troll Witchery
step
	#hardcore
	>>Swim and run back to the Rebel Camp
    .goto Stranglethorn Vale,37.83,3.56
    .turnin 207 >> Turn in Kurzen's Mystery
    .accept 205 >> Accept Troll Witchery
step
    .goto Stranglethorn Vale,38.04,3.01
    .turnin 329 >> Turn in The Spy Revealed!
    .accept 330 >> Accept Patrol Schedules
step
    .goto Stranglethorn Vale,38.04,3.01
    .turnin 574 >> Turn in Special Forces
    .accept 202 >> Accept Colonel Kurzen
step
    .goto Stranglethorn Vale,37.66,3.39
    .turnin 330 >> Turn in Patrol Schedules
    .accept 331 >> Accept Report to Doren
step
    .goto Stranglethorn Vale,38.04,3.01
    .turnin 331 >> Turn in Report to Doren
step
    .goto Stranglethorn Vale,35.61,10.61
    .turnin 188 >> Turn in Tiger Mastery
    .turnin 195 >> Turn in Raptor Mastery
    .accept 196 >> Accept Raptor Mastery
    .turnin 192 >> Turn in Panther Mastery
    .accept 193 >> Accept Panther Mastery
step
    .hs >> Use your Hearthstone
	>> Buy food/water if needed
step
    #completewith next
    .fly Booty Bay>> Fly to Booty Bay
step
    .goto Stranglethorn Vale,26.94,77.20
    .turnin 1115 >> Turn in The Rumormonger
    .accept 1116 >> Accept Dream Dust in the Swamp
    .turnin 189 >> Turn in Bloodscalp Ears
step
    .goto Stranglethorn Vale,27.22,76.87
    .turnin 601 >> Turn in Water Elementals
    .accept 602 >> Accept Magical Analysis
step
    #completewith end
    .goto Stranglethorn Vale,27.04,77.31
    .home >> Set your Hearthstone to Booty Bay if you haven't
    --.bindlocation Booty Bay
step
    .goto Stranglethorn Vale,28.29,77.59
    .turnin 577 >> Turn in Some Assembly Required
step
    .xp 38 >> Make sure you are level 38 before starting the next segment
step << !Mage
    #label end
    .goto Stranglethorn Vale,27.53,77.79
    .fly Stormwind>> Fly to Stormwind
step << Mage
	.zone Stormwind City >> Teleport to Stormwind
	.trainer >> Train your class spells
]])

RXPGuides.RegisterGuide("RestedXP Alliance 30-40",[[
#classic
<< Alliance
#name 38-39 Swamp of Sorrows
#next 39-40 Alterac/Arathi

step
    .goto Stormwind City,57.00,72.88,0
	#completewith FlyDW
	.bankdeposit 4306 >> Make sure you have 15 Silk Cloth in the bank for later
step << Warlock
    #sticky
    #completewith next
    .goto Stormwind City,29.2,74.0,20,0
    .goto Stormwind City,27.2,78.1,15 >> Go into The Slaughtered Lamb and go downstairs
step
    .goto Stormwind City,74.64,52.82 << Rogue
    .goto Stormwind City,74.91,51.55,20,0 << Warrior
    .goto Stormwind City,78.67,45.80 << Warrior
    .goto Stormwind City,42.66,33.75,30,0 << Paladin/Priest
     .goto Stormwind City,38.68,32.85 << Paladin
    .goto Stormwind City,38.54,26.86 << Priest
    .goto Stormwind City,74.91,51.55,20,0 << Warrior
    .goto Stormwind City,78.67,45.80 << Warrior
    .goto Stormwind City,74.64,52.82 << Rogue
    .goto Stormwind City,61.61,15.27 << Hunter
    .goto Stormwind City,26.12,77.23 << Warlock
    .goto Stormwind City,20.90,55.49 << Druid
	.trainer >> Train your class and pet spells << Hunter
	.trainer >> Train your class spells
	  .goto Stormwind City,25.66,77.63 << Warlock
	.vendor >> Buy Demon books for your Succubus/Voidwalker if required << Warlock
step << Mage
    .goto Stormwind City,41.50,89.38
    .accept 1260 >> Accept Morgan Stern
step
    .goto Stormwind City,64.33,20.65
    .accept 1448 >> Accept In Search of The Temple
step << Hunter
    .goto Stormwind City,61.61,15.27
	.trainer >> Train your class and pet spells
step <<  Hunter
    .goto Stormwind City,41.52,64.38
    .accept 1363 >> Accept Mazen's Behest
     >> Run upstairs
    .turnin 1363 >> Turn in Mazen's Behest
    .accept 1364 >> Accept Mazen's Behest
step << !Mage
    .goto Stormwind City,41.50,89.38
    .accept 1260 >> Accept Morgan Stern
step
	#label FlyDW
    .goto Stormwind City,66.27,62.13
    .fly Duskwood>> Fly to Duskwood
step
    .goto Duskwood,73.59,46.89
    .turnin 228 >> Turn in Mor'Ladim
    .accept 229 >> Accept The Daughter Who Lived
step
    .goto Duskwood,74.54,46.08
    .turnin 229 >> Turn in The Daughter Who Lived
step
    .goto Swamp of Sorrows,6.59,60.19
    .zone Swamp of Sorrows >> Run to Swamp of Sorrows
step
     #completewith next
    .goto Swamp of Sorrows,13.96,61.67,100,0
    .goto Swamp of Sorrows,13.96,61.67,0
     >> Start by grinding whelps 
    >>You won't find enough whelps to finish this quest in 1 pass
    .complete 1116,1
step
    .goto Swamp of Sorrows,26.74,59.82
    .accept 1396 >> Accept Encroaching Wildlife
step
    #sticky
    #completewith end
     >> Kill all swamp creatures you see, loot them for Khadgar's Essays. The droprate is very low, so don't go out of your way to complete this quest
    .complete 1364,1
step
    #sticky
    #label wildlife1
     >> Kill beasts as you quest
    .complete 1396,1
    .complete 1396,2
    .complete 1396,3
step
    .goto Swamp of Sorrows,47.10,38.83
     >> Kill Noboru, loot him for the Cudgel, then click it. He patrols around the top-center of the zone
     .collect 6196,1,1392
    .accept 1392 >> Accept Noboru the Cudgel
    .unitscan NOBORU THE CUDGEL
--N may need better .gotos
step
    .goto Swamp of Sorrows,25.98,31.40
    .accept 1389 >> Accept Draenethyst Crystals
    .turnin 1392 >> Turn in Noboru the Cudgel
step
    #completewith wildlife2
    .goto Swamp of Sorrows,14.97,37.31,70 >> Kill some swamp elementals
step
    .goto Swamp of Sorrows,13.96,61.67
     >> Finish off Dream Dust in the Swamp
    .complete 1116,1
step
    #label wildlife2
    #requires wildlife1
    .goto Swamp of Sorrows,26.74,59.82
    .turnin 1396 >> Turn in Encroaching Wildlife
    .accept 1421 >> Accept The Lost Caravan
step
    #completewith chestcart
     >> Kill Ongeku. Loot him for his Shard. He can be found all over the Fallow Sanctuary
    .complete 1373,1
    .isOnQuest 1373
	.unitscan Ongeku
step
    #sticky
    #label crystals
    .goto Swamp of Sorrows,63.26,22.35,0
     >> Loot 6 blue crystals around the wooden huts
    .complete 1389,1
step
	#label chestcart
    .goto Swamp of Sorrows,64.46,18.30
	>>Clear out the mobs around the huts about 40 yards south of the chest
     >> Loot the chest on top of the broken cart
    .complete 1421,1
step
    .goto Swamp of Sorrows,64.74,22.46
     >> Kill Ongeku. Loot him for his Shard. He can be found all over the Fallow Sanctuary
    .complete 1373,1
    .isOnQuest 1373
	.unitscan Ongeku
step
    .goto Swamp of Sorrows,65.46,18.16
     >> Start the escort quest
    .accept 1393 >> Accept Galen's Escape
step
     >> Escort Galen
     .complete 1393,1
step
    #requires crystals
    .goto Swamp of Sorrows,47.80,39.75
     >> Click on Galen's Strongbox
    .turnin 1393 >> Turn in Galen's Escape
step
    .goto Swamp of Sorrows,25.98,31.40
    .turnin 1389 >> Turn in Draenethyst Crystals
step
    .goto Swamp of Sorrows,26.74,59.82
    .turnin 1421 >> Turn in The Lost Caravan
step
    #label end
    .goto Swamp of Sorrows,67.00,47.00
     >> Swim to the middle of the lake
     .complete 1448,1
step
    .hs >> Grind mobs until your Hearthstone is off cooldown 
    >>Hearth to Booty Bay
	>> Buy food/water if needed
step << Rogue
    .goto Stranglethorn Vale,26.82,77.15
	.trainer >> Go up one floor and talk to Ian. Train your class spells
step
    #completewith next
    .goto Stranglethorn Vale,26.94,77.20
    >>Speak to Krazek at the top floor of the inn
    .turnin 1116 >> Turn in Dream Dust in the Swamp
step
    >>Wait for RP sequence
    .goto Stranglethorn Vale,26.94,77.20
    .accept 1117 >> Accept Rumors for Kravel
step << !Mage
    .goto Stranglethorn Vale,27.53,77.79
    .fly Stormwind>> Fly to Stormwind
step << Mage
	.zone Stormwind City >> Teleport to Stormwind
	.trainer >> Train your class spells
step
    #sticky
	#label Bankandy1
    .goto Stormwind City,56.48,73.41
    .bankwithdraw 6253,3518,5539,6245,3960,5796,5847,5996 >> Withdraw the following items from your bank: << !Warlock
    .bankwithdraw 6253,3518,5539,6245,3960,5796,5847 >> Withdraw the following items from your bank: << Warlock
    >>Water Breathing Potions << !Warlock
    >>Decrypted Letter 
    >>Letter of Commendation 
    >>Karnitol's Satchel 
    >>Bag of Water Elemental Bracers 
    >>Encrusted Tail Fins 
    >>Mirefin Head
--N unsure if removing water breathing pot for lock was needed, added it anyway
step
    .goto Stormwind City,56.48,73.41
    .bankdeposit 6065,4611,4306 >> Deposit the following items into your bank: << Hunter
    .bankdeposit 6065,4306 >> Deposit the Blue Pearls in your bank << !Hunter
    >>Blue Pearls 
	>>Silk Cloth (15)
    >>Khadgar's Essays on Dimensional Convergence (if you have it) << Hunter
step << Priest
	#requres Bankandy1
    #completewith next
	.goto Stormwind City,44.21,70.03,40,0
    .goto Stormwind City,42.85,65.14
	>>Buy the Pitchwood Wand from the vendor if it's better than your current wand. Equip it at 40
	.collect 5238,1 --Pitchwood Wand (1)
step << !Mage !Hunter
	#requires Bankandy1
    .goto Stormwind City,74.91,51.55,20,0 << Warrior
    .goto Stormwind City,78.67,45.80 << Warrior
    .goto Stormwind City,42.66,33.75,30,0 << Paladin/Priest
     .goto Stormwind City,38.68,32.85 << Paladin
    .goto Stormwind City,38.54,26.86 << Priest
    .goto Stormwind City,74.91,51.55,20,0 << Warrior
    .goto Stormwind City,78.67,45.80 << Warrior
    .goto Stormwind City,26.12,77.23 << Warlock
	.trainer >> Train your class spells
	  .goto Stormwind City,25.66,77.63 << Warlock
	.vendor >> Buy Demon books for your Succubus/Voidwalker if required << Warlock
step
	#requires Bankandy1
    .goto Stormwind City,74.00,30.23
    .accept 543 >> Accept The Perenolde Tiara
step
    .goto Stormwind City,64.33,20.65
    .turnin 1448 >> Turn in In Search of The Temple
    .accept 1449 >> Accept To The Hinterlands
step << Hunter
    .goto Stormwind City,61.61,15.27 << Hunter
	.trainer >> Train your class and pet spells << Hunter
step
     #completewith next
    .goto Stormwind City,63.73,8.43,30,0
    .goto Stormwind City,63.73,8.43,0
     .zone Ironforge >> Take the Tram to Ironforge << !Mage
     .zone Ironforge >> Take the Tram or Teleport to Ironforge << Mage
step
    .goto Ironforge,67.91,17.50
    .turnin 1457 >> Turn in The Karnitol Shipwreck
step << !Warlock
	#softcore
     #completewith next
    .goto Ironforge,25.75,75.42
     >>If you don't have a Water Breathing Potion, buy one from the Auction House
	.collect 5996,1
step
    .goto Ironforge,55.50,47.74
    .fly Southshore>> Fly to Southshore
]])

RXPGuides.RegisterGuide("RestedXP Alliance 30-40",[[
#classic
<< Alliance
#name 39-40 Alterac/Arathi
#next RestedXP Alliance 40-50\40-40 Dustwallow Marsh << Hunter
#next RestedXP Alliance 40-50\39-40 Dustwallow/Desolace << !Hunter

step
    .goto Hillsbrad Foothills,50.34,59.04
    .accept 659 >> Accept Hints of a New Plague?
step
    #sticky
    #completewith start
    .goto Hillsbrad Foothills,48.2,59.2,0
     >> Kill Syndicate Assassins in Southshore
    >>Accept/turn in Assassin's Contract 
    >>The scripted event related to this quest only happens once every several hours, skip this step if you can't find the assassins
    .accept 523 >> Accept Baron's Demise
step
    .goto Hillsbrad Foothills,51.17,58.93
    .home >> Set your Hearthstone to Southshore
step
    .goto Hillsbrad Foothills,51.36,58.55
    >>Head upstairs
    .turnin 1052 >> Turn in Down the Scarlet Path
    .isOnQuest 1052
step
    .goto Hillsbrad Foothills,49.47,58.73
    .accept 500 >> Accept Crushridge Bounty
step
    .goto Hillsbrad Foothills,48.13,59.10
    .turnin 525 >> Turn in Further Mysteries
    .accept 537 >> Accept Dark Council
    .accept 512 >> Accept Noble Deaths
step
    .goto Hillsbrad Foothills,50.60,57.10
     >> Skip this step if you haven't found the old history book in duskwood
    .turnin 538 >> Turn in Southshore
    .accept 540 >> Accept Preserving Knowledge
    .isQuestTurnedIn 337
step
    .goto Alterac Mountains,18.83,78.48
    .turnin 602 >> Turn in Magical Analysis
    .accept 603 >> Accept Ansirem's Key
step
    .goto Alterac Mountains,32.36,68.22
    .zone Alterac Mountains >> Head to ruins of alterac
step
    #completewith Ruins
    #hardcore
    +The next couple quests in Ruins of Alterac can be a little difficult to do but they are soloable, tread carefully and avoid aggroing multiple mobs
step
    .goto Alterac Mountains,39.08,51.22
     >> Kill Grel'borg, he patrols around the ruins of alterac
     >> He's an elite mob but he's quite easy to deal with as long as you deal with him alone.
    .complete 543,1
    .unitscan GREL'BORG THE MISER
step
    #label Ruins
    .goto Alterac Mountains,38.5,46.5
     >> Click on the bookshelf inside the town hall 
     >> There is an elite mob inside the town hall guarding the bookshelf, you dont need to deal with it, just cc him, loot the book and run away
    .complete 540,2
    .isOnQuest 540
step
    #label signets
    #sticky
    .goto Alterac Mountains,62.39,43.64,0
     >> Kill syndicate mobs
    .complete 512,1
step
    .goto Alterac Mountains,39.22,14.31
     >> Kill Nagaz
    .complete 537,2
step
    .goto Alterac Mountains,39.17,14.66
     >> Click on the wooden chest on the ground
     .collect 3706,1,551
    .accept 551 >> Accept The Ensorcelled Parchment
step
	#completewith next
     >> Kill Shadow Mages around the syndicate camps in northern Alterac
    .complete 537,1
step
    .goto Alterac Mountains,47.8,17.1,70,0
    .goto Alterac Mountains,53.6,20.6,70,0
    .goto Alterac Mountains,56.2,26.8,70,0
    .goto Alterac Mountains,58.1,29.9,70,0
    .goto Alterac Mountains,59.7,43.9
	>>Search each camp, as well as the basement inn of Strahnbrad, for Baron Vardus. Kill him and loot his head.
	.complete 523,1
    .isOnQuest 523
	.unitscan Baron Vardus
--P
step
    .goto Alterac Mountains,60.8,43.8
     >> Kill Shadow Mages around the Syndicate camps in northern Alterac
    .complete 537,1
step
    .goto Alterac Mountains,48.31,41.55
     >> Kill Ogres. Loot them for their Knucklebones
    .complete 500,1
step
    .goto Alterac Mountains,37.41,53.63
     >> Keep killing Ogres and looting them for Recovered Tomes
    .complete 540,1
    .isOnQuest 540
step <<  Hunter
    #completewith next
     + Grind mobs until your Hearthstone cooldown is <6min
step
    .goto Alterac Mountains,59.52,62.68,65,0
    .goto Hillsbrad Foothills,71.43,21.04,35,0
    .goto Hillsbrad Foothills,84.23,31.99,45,0
    .goto The Hinterlands,6.23,61.87
    .zone The Hinterlands >> Head to The Hinterlands
step
    .goto The Hinterlands,11.80,46.75
    .turnin 1449 >> Turn in To The Hinterlands
    .accept 1450 >> Accept Gryphon Master Talonaxe
step
    .goto The Hinterlands,11.08,46.16
    .fp Hinterlands>> Get The Hinterlands Flight Path
step
    .goto The Hinterlands,9.75,44.47
    .turnin 1450 >> Turn in Gryphon Master Talonaxe
    .accept 1451 >> Accept Rhapsody Shindigger
step
    .goto The Hinterlands,26.94,48.58
    .turnin 1451 >> Turn in Rhapsody Shindigger
step
    .goto The Hinterlands,26.94,48.58
    .accept 1452 >> Accept Rhapsody's Kalimdor Kocktail
step
     #completewith next
    .hs >> Hearth to Southshore
	>> Buy food/water if needed
step
    .goto Hillsbrad Foothills,49.47,58.73
    .turnin 500 >> Turn in Crushridge Bounty
step
    .goto Hillsbrad Foothills,48.13,59.10
    .turnin 512 >> Turn in Noble Deaths
    .turnin 537 >> Turn in Dark Council
step
    .goto Hillsbrad Foothills,48.13,59.10
    .turnin 523 >> Turn in Baron's Demise
    .isOnQuest 523
step
    .goto Hillsbrad Foothills,50.57,57.09
    .turnin 551 >> Turn in The Ensorcelled Parchment
    .accept 554 >> Accept Stormpike's Deciphering
step
     >> Skip this step if you don't have this quest
    .turnin 540 >> Turn in Preserving Knowledge
    .accept 542 >> Accept Return to Milton
    .isQuestTurnedIn 337
step
    >> Look for the Forsaken Courier. Loot her for the Sealed Folder
    >> She patrols the road between Tarren Mill and Go'Shek farm
    .goto Hillsbrad Foothills,55.70,22.72,70,0
    .goto Hillsbrad Foothills,57.81,36.66,70,0
    .goto Hillsbrad Foothills,62.30,41.42,70,0
    .goto Hillsbrad Foothills,67.13,44.02,70,0
    .goto Hillsbrad Foothills,83.51,58.80,70 >> After you've checked Hillsbrad for her, travel to Arathi Highlands
    .complete 658,1
    .unitscan FORSAKEN COURIER
step
     #completewith next
    .goto Arathi Highlands,46.19,47.75
    .zone Arathi Highlands >> Travel to Arathi Highlands
step
    >> Look for the Forsaken Courier. Loot her for the Sealed Folder
    >> She patrols the road between Tarren Mill and Go'Shek farm
    .goto Arathi Highlands,22.73,36.59,70,0
    .goto Arathi Highlands,24.46,45.65,70,0
    .goto Arathi Highlands,31.60,52.00,70,0
    .goto Arathi Highlands,43.23,55.49,70,0
    .goto Arathi Highlands,47.62,59.82,70,0
    .goto Arathi Highlands,58.80,63.26,70,0
    .goto Arathi Highlands,60.93,59.40
	>>If you haven't found her by the time you reached Go'Shek, grind the Orcs there for 5 minutes, then skip the step if she hasn't spawned in Jorell's house by then
    .complete 658,1
    .unitscan FORSAKEN COURIER
step
     #completewith next
    .goto Arathi Highlands,46.19,47.75
    .zone Arathi Highlands >> Travel to Arathi Highlands
step
    .goto Arathi Highlands,46.19,47.75
     >> Speak with Apprentice Kryten
    .accept 691 >> Accept Worth Its Weight in Gold
step <<  Hunter/Druid/Rogue
    .goto Arathi Highlands,46.04,47.76
     >> Click on the Wanted Poster
    .accept 684 >> Accept Wanted! Marez Cowl
step
    .goto Arathi Highlands,62.50,33.72
    .accept 642 >> Accept The Princess Trapped
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
    .goto Arathi Highlands,66.70,29.71
     >> Loot the rock in the middle of the elementals
    .complete 651,2
step
    .goto Arathi Highlands,68.33,75.39
    >>Prioritize killing Witch Doctors/Shadow Hunters
    .complete 691,1
    .complete 691,2
    .complete 691,3
step
	.isQuestComplete 658
    .goto Arathi Highlands,60.18,53.84
    .accept 658 >> Accept Hints of a New Plague?
    .turnin 658 >> Turn in Hints of a New Plague?
    .accept 657 >> Accept Hints of a New Plague?
step
	.isQuestTurnedIn 658
    .goto Arathi Highlands,60.23,53.91
     >> Speak with Kinelory and start the escort quest
    .turnin 657 >> Turn in Hints of a New Plague?
    .accept 660 >> Accept Hints of a New Plague?
step
	.isQuestTurnedIn 658
    .goto Arathi Highlands,60.18,53.84
     >> Escort Kinelory around the farm
     .complete 660,1
step
	.isQuestTurnedIn 658
    .goto Arathi Highlands,60.18,53.84
    .turnin 660 >> Turn in Hints of a New Plague?
    .accept 661 >> Accept Hints of a New Plague?
step
    .goto Arathi Highlands,52.03,50.72
     >> Loot the rock in the middle of the elementals
    .complete 651,3
step
    .goto Arathi Highlands,46.19,47.75
    .turnin 691 >> Turn in Worth Its Weight in Gold
step
    .goto Arathi Highlands,46.65,47.01
    .accept 693 >> Accept Wand over Fist
step
    .goto Arathi Highlands,54.75,81.87
     >> Kill Kor'Gresh at the back of the cave
    .complete 693,1
step
	#completewith next
	+Perform a Logout skip on the banner next to Kor'Gresh to teleport to the Elementals
	.link https://youtu.be/SWBtPqm5M0Q?t=61 >> CLICK HERE
step
    .goto Arathi Highlands,25.60,30.38
     >> Loot the rock in the middle of the elementals
    .complete 651,1
step <<  Hunter/Druid/Rogue
    .goto Arathi Highlands,29.62,62.96
     >> Head to Stromgarde Keep
    >>Use Eagle Eye to find her first << Hunter
    >>Marez Cowl has 2 different spawn locations
    >>Getting there can be tricky, you can skip this quest if necessary << Hunter
    .complete 684,1
    .unitscan MAREZ COWL
step
    .goto Arathi Highlands,36.22,57.37
    .turnin 651 >> Turn in Stones of Binding
    .accept 652 >> Accept Breaking the Keystone
step <<  Hunter
    #sticky
     >> Use Eagle Eye to find Fozruk 
    >>Make sure to kill Sleeby and the rest of the kobolds first, you can kill one add at a time and reset the fight 
    >>Kill Fozruk by kiting him around Refuge Point
    .complete 652,1
    .unitscan Fozruk
step <<  !Hunter
    .goto Arathi Highlands,61.43,48.09
     >> Find and kill Fozruk but don't go out of your way to finish this step, he patrols the whole zone 
    >>This is a difficult elite to solo, consider skipping this step
    .complete 652,1
    .unitscan Fozruk
step
    .goto Arathi Highlands,46.65,47.01
    .turnin 693 >> Turn in Wand over Fist
step <<  Hunter/Druid/Rogue
    .goto Arathi Highlands,45.83,47.55
    .turnin 684 >> Turn in Wanted! Marez Cowl
step
    .goto Arathi Highlands,36.07,58.09
     >> Skip this step if you haven't found Fozruk
     >>After turning in this quest, an elite mob will spawn, be ready to run away
    .turnin 652 >> Turn in Breaking the Keystone
    .isQuestComplete 652
step
    .goto Arathi Highlands,36.07,58.09
    .accept 653 >> Accept Myzrael's Allies
    .isQuestTurnedIn 652
step
    #completewith next
    .goto Arathi Highlands,21.50,72.60,40 >> Head to Faldir's Cove, follow the path between the mountains and Stromgarde's southeastern wall 
step
    .goto Arathi Highlands,31.78,82.68
    .accept 663 >> Accept Land Ho!
step
    .goto Arathi Highlands,32.28,81.37
    .turnin 663 >> Turn in Land Ho!
step
    .goto Arathi Highlands,32.79,81.48
    .accept 662 >> Accept Deep Sea Salvage
step
    #sticky
    #label escort
    .goto Arathi Highlands,33.86,80.54
    >>Start the escort quest.
    .accept 665 >> Accept Sunken Treasure
    .accept 664 >> Accept Drowned Sorrows
step
    #requires escort
     >> Do the escort quest. Kill the 2 adds that spawn at the mouth of the cave before they attack the goblin
     .complete 665,1
step
    .goto Arathi Highlands,33.85,80.44
    .turnin 665 >> Turn in Sunken Treasure
    .accept 666 >> Accept Sunken Treasure
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
	>>Re-Equip your helm
step
    .goto Arathi Highlands,34.00,80.79
    .turnin 664 >> Turn in Drowned Sorrows
    .turnin 666 >> Turn in Sunken Treasure
    .accept 668 >> Accept Sunken Treasure
step
    .goto Arathi Highlands,32.28,81.37
    .turnin 668 >> Turn in Sunken Treasure
    .accept 669 >> Accept Sunken Treasure
step <<  Warlock/Paladin
     .xp 40 >> Grind to level 40
step << Druid
	#level 40
    >>Teleport to Moonglade
	.goto Moonglade,52.53,40.56
    .trainer >> Train your class spells
step
    .hs >> Hearth to Southshore
	>> Buy food/water if needed
step
	.isQuestTurnedIn 658
    .goto Hillsbrad Foothills,50.34,59.04
    .turnin 661 >> Turn in Hints of a New Plague?
--N find out amount of exp from faldirs turnins, then put a grind to X xp at nagas
step <<  Warlock
    .goto Hillsbrad Foothills,49.33,52.27
    .fly Ironforge>> Fly to Ironforge
step <<  Warlock
     .goto Ironforge,50.4,6.0
    .turnin 653 >> Turn in Myzrael's Allies
     >> Skip the follow up
     .isOnQuest 653
step <<  Warlock
    .goto Ironforge,50.34,5.65
     >> Speak with the Warlock trainers in Ironforge
    .accept 4487 >> Accept Summon Felsteed
    .accept 4965 >> Accept Knowledge of the Orb of Orahil
	.trainer >> Train your class spells
step <<  Paladin
    .goto Hillsbrad Foothills,49.33,52.27
    .fly Stormwind>> Fly to Stormwind City
step << Paladin
    .goto Stormwind City,42.66,33.75,30,0
     .goto Stormwind City,39.81,29.79 
    .accept 1661 >>Accept The Tome of Nobility
	.turnin 1661 >>Turnin The Tome of Nobility
step << Paladin
     .goto Stormwind City,38.68,32.85
	.trainer >> Train your class spells
step
    .goto Hillsbrad Foothills,49.34,52.27 << !Warlock !Paladin
    .goto Ironforge,55.50,47.70 << Warlock
    .goto Stormwind City,66.27,62.13 << Paladin
    .fly Wetlands>> Fly to Wetlands
]])