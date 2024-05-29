RXPGuides.RegisterGuide([[
#classic
<< Horde
#xprate >1.99
#name 24-26 Southern Barrens
#version 20
#group RestedXP Horde 22-30
#next 26-28 Ashenvale;26-28 SoD Ashenvale
step
.goto The Barrens,44.55,59.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mangletooth|r
.accept 879 >> Accept Betrayal from Within
.target Mangletooth
step
#completewith CampTHS2
+|cRXP_WARN_Use your remaining|r |T134128:0|t[Blood Shards] |cRXP_WARN_to get|r |T136104:0|t[Razorhide] |cRXP_WARN_and other buffs|r << !Mage !Druid
+|cRXP_WARN_Use your remaining|r |T134128:0|t[Blood Shards] |cRXP_WARN_to get buffs|r << Mage/Druid
+|cRXP_WARN_Make sure to turn off any autocomplete functions from addons such as Questie or Leatrix Plus for this!|r
step
.goto The Barrens,44.85,59.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorn Skyseer|r
.daily 235,742,6382 >> Accept The Ashenvale Hunt
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
.dungeon WC
step
#label CampTHS2
.goto The Barrens,45.58,59.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Byula|r
.vendor >>|cRXP_BUY_Sell your junk, then restock on food and water if necessary|r << !Rogue !Warrior
.vendor >>|cRXP_BUY_Sell your junk, then restock on food if necessary|r << Rogue/Warrior
.target Innkeeper Byula
.dungeon !WC
step
#completewith next
>>Kill a |cRXP_ENEMY_Thunderhawk|r. Loot it for its |cRXP_LOOT_Wings|r
.complete 913,1 
.mob Thunderhawk Hatchling
.mob Thunderhawk Cloudscraper
.mob Greater Thunderhawk
step
.goto The Barrens,44.63,62.71,80,0
.goto The Barrens,45.78,63.09,80,0
.goto The Barrens,49.57,59.36
>>Find & kill |cRXP_ENEMY_Owatanka|r (Blue Thunder Lizard) around this area. Loot him for |T133723:0|t[|cRXP_LOOT_Owatanka's Tailspike|r]. Use it to start the quest
>>|cRXP_WARN_Skip this quest if you can't find him|r
.collect 5102,1,884 
.accept 884 >>Accept Owatanka
.use 5102
.unitscan Owatanka
step << Warrior
.loop 25,The Barrens,45.17,69.08,43.87,68.84,42.17,69.65,42.35,71.85,42.77,72.28,43.86,72.06,45.38,72.25,45.17,69.08
>>Kill |cRXP_ENEMY_Silithid Protectors|r, |cRXP_ENEMY_Silithid Swarmers|r, |cRXP_ENEMY_Silithid Creepers|r and |cRXP_ENEMY_Silithid Grubs|r. Loot them for their |T133027:0|t[Twitching Antenna]
>>|cRXP_WARN_NOTE: The |T133027:0|t[Twitching Antenna] only have a 15 minute duration, do not AFK or logout during this quest|r
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
>>Kill the |cRXP_ENEMY_Silithid Harvester|r. Loot it for the |T134321:0|t[|cRXP_LOOT_Harvester's Head|r]. Use it to start the quest
>>|cRXP_WARN_Skip this quest if you can't find him|r
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
.isOnQuest 868
.maxlevel 26
step << Shaman
#completewith next
.goto The Barrens,44.76,74.79,45,0
>>Kill |cRXP_ENEMY_Washte Pawne|r. Loot him for |T135992:0|t[|cRXP_LOOT_Washte Pawne's Feather|r]. Use it to start the quest
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
>>Kill |cRXP_ENEMY_Washte Pawne|r. Loot him for |T135992:0|t[|cRXP_LOOT_Washte Pawne's Feather|r]. Use it to start the quest
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
>>|cRXP_FRIENDLY_Gann|r |cRXP_WARN_patrols North and South on the road|r
.accept 843 >> Accept Gann's Reclamation
.target Gann Stonespire
.maxlevel 26
step << Mage
#season 2
.train 415936,1
.train 1953,3 
.goto The Barrens,45.45,80.00
.aura 421063,1 >>|cRXP_WARN_Blink against the|r |cRXP_PICK_Etched Carving|r |cRXP_WARN_on the wall to obtain the|r |T236168:0|t[Path of no Steps] |cRXP_WARN_buff|r
step << Mage
#season 2
.train 415936,1
.train 1953,3 
.goto The Barrens,45.28,80.14,5,0
.goto The Barrens,45.23,80.42,5,0
.goto The Barrens,45.06,80.57,5,0
.goto The Barrens,44.94,80.80,5,0
.goto The Barrens,44.87,81.08,5,0
.goto The Barrens,44.80,81.37
.train 415936 >>|cRXP_WARN_Cast|r |T135736:0|t[Blink] |cRXP_WARN_onto the green circles one by one. At the end, blink against the|r |cRXP_PICK_Etched Carving|r |cRXP_WARN_to train|r |T236220:0|t[Living Bomb]
step
#completewith Lok
>>Kill |cRXP_ENEMY_Razormane Stalkers|r and |cRXP_ENEMY_Razormane Pathfinders|r. Loot them for the |T135640:0|t[|cRXP_LOOT_Razormane Backstabber|r]
>>Kill |cRXP_ENEMY_Razormane Seers|r. Loot them for the |T135139:0|t[|cRXP_LOOT_Charred Razormane Wand|r]
>>Kill |cRXP_ENEMY_Razormane Warfrenzies|r. Loot them for the |T134955:0|t[|cRXP_LOOT_Razormane War Shield|r]
>>|cRXP_WARN_The |cRXP_ENEMY_Razormane Stalkers|r are stealthed|r
.collect 5093,1,893,1 
.collect 5092,1,893,1 
.collect 5094,1,893,1 
.mob Razormane Stalker
.mob Razormane Pathfinder
.mob Razormane Seer
.mob Razormane Warfrenzy
step
#completewith next
.goto The Barrens,44.85,78.81,45,0
.goto The Barrens,44.44,78.97,45,0
>>Kill |cRXP_ENEMY_Washte Pawne|r. Loot him for |T135992:0|t[|cRXP_LOOT_Washte Pawne's Feather|r]. Use it to start the quest
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
>>Kill |cRXP_ENEMY_Kuz|r. Loot him for |cRXP_LOOT_Kuz's Skull|r
>>|cRXP_ENEMY_Kuz|r patrols around slightly
.complete 879,1 
.unitscan Kuz
step
#completewith next
.goto The Barrens,43.14,80.75,45,0
.goto The Barrens,43.35,81.16,45,0
>>Kill |cRXP_ENEMY_Washte Pawne|r. Loot him for |T135992:0|t[|cRXP_LOOT_Washte Pawne's Feather|r]. Use it to start the quest
.collect 5103,1,885 
.accept 885 >>Accept Washte Pawne
.use 5103
.unitscan Washte Pawne
step
#label Lok
.goto The Barrens,40.31,80.70,20,0
.goto The Barrens,40.14,80.56
>>Kill |cRXP_ENEMY_Lok Orcbane|r. Loot him for |cRXP_LOOT_Lok's Skull|r
.complete 879,3 
.mob Lok Orcbane
step
#completewith WandShield
.goto The Barrens,44.85,78.81,45,0
.goto The Barrens,44.44,78.97,45,0
.goto The Barrens,43.14,80.75,45,0
.goto The Barrens,43.35,81.16,45,0
>>Kill |cRXP_ENEMY_Washte Pawne|r. Loot him for |T135992:0|t[|cRXP_LOOT_Washte Pawne's Feather|r]. Use it to start the quest
.collect 5103,1,885 
.accept 885 >>Accept Washte Pawne
.use 5103
.unitscan Washte Pawne
step
#completewith NakSkull
>>Kill |cRXP_ENEMY_Razormane Stalkers|r and |cRXP_ENEMY_Razormane Pathfinders|r. Loot them for a |T135640:0|t[|cRXP_LOOT_Razormane Backstabber|r]
>>|cRXP_WARN_The |cRXP_ENEMY_Razormane Stalkers|r are stealthed|r
.collect 5093,1,893,1 
.mob Razormane Stalker
.mob Razormane Pathfinder
step
#label WandShield
.loop 25,The Barrens,42.57,78.81,42.12,78.48,41.49,78.69,41.22,79.72,40.91,80.60,40.55,80.84,41.62,80.92,41.54,82.28,42.48,82.28,42.57,78.81
>>Kill |cRXP_ENEMY_Razormane Seers|r. Loot them for a |T135139:0|t[|cRXP_LOOT_Charred Razormane Wand|r]
>>Kill |cRXP_ENEMY_Razormane Warfrenzies|r. Loot them for a |T134955:0|t[|cRXP_LOOT_Razormane War Shield|r]
.collect 5092,1,893,1 
.collect 5094,1,893,1 
.mob Razormane Seer
.mob Razormane Warfrenzy
step
#label NakSkull
.goto The Barrens,43.87,83.43
>>Kill |cRXP_ENEMY_Nak|r. Loot him for |cRXP_LOOT_Nak's Skull|r
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
>>Kill |cRXP_ENEMY_Razormane Stalkers|r and |cRXP_ENEMY_Razormane Pathfinders|r. Loot them for a |T135640:0|t[|cRXP_LOOT_Razormane Backstabber|r]
>>|cRXP_WARN_The |cRXP_ENEMY_Razormane Stalkers|r are stealthed|r
.collect 5093,1,893,1 
.mob Razormane Stalker
.mob Razormane Pathfinder
step
#completewith next
>>Kill |cRXP_ENEMY_Bael'dun Excavators|r and |cRXP_ENEMY_Bael'dun Foremen|r
.complete 843,1 
.complete 843,2 
.mob Bael'dun Excavator
.mob Bael'dun Foreman
.isOnQuest 843
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
>>Kill |cRXP_ENEMY_Prospector Khazgorm|r. Loot him for |cRXP_LOOT_Khazgorm's Journal|r
.complete 843,3 
.mob Prospector Khazgorm
.isOnQuest 843
step
#loop
.goto The Barrens,47.22,84.98,40,0
.goto The Barrens,47.28,85.74,40,0
.goto The Barrens,47.60,85.66,40,0
.goto The Barrens,48.43,86.34,40,0
.goto The Barrens,48.03,85.46,40,0
.goto The Barrens,47.94,84.86,40,0
.goto The Barrens,47.37,84.01,40,0
.goto The Barrens,46.92,84.22,40,0
.goto The Barrens,46.99,85.82,40,0
.goto The Barrens,47.22,84.98,40,0
>>Kill |cRXP_ENEMY_Bael'dun Excavators|r and |cRXP_ENEMY_Bael'dun Foremen|r
.complete 843,1 
.complete 843,2 
.mob Bael'dun Excavator
.mob Bael'dun Foreman
.isOnQuest 843
step
#completewith BaelModan
.goto The Barrens,47.21,79.35,45,0
.goto The Barrens,47.22,79.72,45,0
>>Kill |cRXP_ENEMY_Washte Pawne|r. Loot him for |T135992:0|t[|cRXP_LOOT_Washte Pawne's Feather|r]. Use it to start the quest
.collect 5103,1,885 
.accept 885 >>Accept Washte Pawne
.use 5103
.unitscan Washte Pawne
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
>>|cRXP_FRIENDLY_Gann|r |cRXP_WARN_patrols North and South on the road|r
.turnin 843 >> Turn in Gann's Reclamation
.accept 846 >> Accept Revenge of Gann
.target Gann Stonespire
.isQuestComplete 843
step
#optional
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
>>|cRXP_FRIENDLY_Gann|r |cRXP_WARN_patrols North and South on the road|r
.accept 846 >> Accept Revenge of Gann
.target Gann Stonespire
.isQuestTurnedIn 843
step
#label BaelModan
.goto The Barrens,48.63,84.49,110 >>Travel to Bael Modan
.isQuestTurnedIn 843
step
#completewith TearMoons2
>>Kill |cRXP_ENEMY_Bael'dun Dwarves|r. Loot them for their |cRXP_LOOT_Nitroglycerin|r, |cRXP_LOOT_Wood Pulp|r, and |cRXP_LOOT_Sodium Nitrate|r
>>|cRXP_WARN_Be Careful!|r |cRXP_ENEMY_Bael'dun Officers|r |cRXP_WARN_have a 50% increased parry chance for 8 seconds after they do their defense stance animation|r << Rogue/Warrior/Druid/Shaman
.complete 846,1 
.complete 846,2 
.complete 846,3 
.mob Bael'dun Rifleman
.mob Bael'dun Soldier
.mob Bael'dun Officer
.group 0
.isQuestTurnedIn 843
step
.goto The Barrens,48.94,86.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Feegly|r
.accept 857 >> Accept The Tear of the Moons
.target Feegly the Exiled
.group 3
.isQuestTurnedIn 843
step
#completewith next
.goto The Barrens,49.01,84.48,8,0
.goto The Barrens,49.06,84.59,8,0
.goto The Barrens,49.38,84.48,8,0
.goto The Barrens,49.53,84.42,8,0
.goto The Barrens,49.43,84.28,6 >>Go down to the bottom floor of Bael'dun
.group
.isQuestTurnedIn 843
step
.goto The Barrens,49.13,84.25
>>Open |cRXP_PICK_General Twinbraid's Strongbox|r. Loot it for the |cRXP_LOOT_Tear of the Moons|r
>>|cRXP_WARN_Be careful! It is very easy overpull in |cRXP_ENEMY_General Twinbraid|r's room|r
>>|cRXP_WARN_Directly pull any mob other than |cRXP_ENEMY_General Twinbraid|r|r
.complete 857,1 
.group 3
.isQuestTurnedIn 843
step
#completewith next
.goto The Barrens,49.43,84.28,8,0
.goto The Barrens,49.53,84.42,8,0
.goto The Barrens,49.38,84.48,8,0
.goto The Barrens,49.06,84.59,8,0
.goto The Barrens,49.01,84.48,8,0
.goto The Barrens,48.75,84.63,20 >>Exit Bael'dun's Keep
.group
.isQuestTurnedIn 843
step
#label TearMoons2
.goto The Barrens,48.94,86.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Feegly|r
.turnin 857 >> Turn in The Tear of the Moons
.target Feegly the Exiled
.isQuestComplete 857
.group
step
#loop
.goto The Barrens,48.96,84.36,30,0
.goto The Barrens,48.88,84.02,30,0
.goto The Barrens,49.28,83.76,30,0
.goto The Barrens,49.22,84.21,30,0
.goto The Barrens,49.47,84.41,30,0
.goto The Barrens,49.09,84.67,30,0
.goto The Barrens,48.96,84.36,30,0
>>Kill |cRXP_ENEMY_Bael'dun Dwarves|r. Loot them for their |cRXP_LOOT_Nitroglycerin|r, |cRXP_LOOT_Wood Pulp|r, and |cRXP_LOOT_Sodium Nitrate|r
>>|cRXP_WARN_Be Careful!|r |cRXP_ENEMY_Bael'dun Officers|r |cRXP_WARN_have a 50% increased parry chance for 8 seconds after they do their defense stance animation|r << Rogue/Warrior/Druid/Shaman
.complete 846,1 
.complete 846,2 
.complete 846,3 
.mob Bael'dun Rifleman
.mob Bael'dun Soldier
.mob Bael'dun Officer
.isQuestTurnedIn 843
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
>>|cRXP_FRIENDLY_Gann|r |cRXP_WARN_patrols North and South on the road|r
.turnin 846 >> Turn in Revenge of Gann
.accept 849 >> Accept Revenge of Gann
.target Gann Stonespire
.isQuestTurnedIn 843
step
.goto The Barrens,46.97,85.63
>>Click the |cRXP_PICK_Bael Modan Flying Machine|r atop the platform
>>|cRXP_WARN_This has a 50 yard range|r
.complete 849,1 
.isQuestTurnedIn 843
step
#completewith WashtethePawne
>>Kill a |cRXP_ENEMY_Thunderhawk|r. Loot it for its |cRXP_LOOT_Wings|r
.complete 913,1 
.mob Thunderhawk Hatchling
.mob Thunderhawk Cloudscraper
.mob Greater Thunderhawk
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
>>|cRXP_FRIENDLY_Gann|r |cRXP_WARN_patrols North and South on the road|r
.turnin 849 >> Turn in Revenge of Gann
.target Gann Stonespire
.isQuestTurnedIn 843
step
#label WashtethePawne
.loop 25,The Barrens,44.85,78.81,44.44,78.97,43.14,80.75,43.35,81.16,47.22,79.72,47.21,79.35,44.76,74.79,44.85,78.81
>>Kill |cRXP_ENEMY_Washte Pawne|r. Loot him for |T135992:0|t[|cRXP_LOOT_Washte Pawne's Feather|r]. Use it to start the quest
.collect 5103,1,885 
.accept 885 >>Accept Washte Pawne
.use 5103
.unitscan Washte Pawne
step
#loop
.goto The Barrens,47.08,78.69,0
.goto The Barrens,47.45,74.53,0
.goto The Barrens,44.95,75.19,0
.waypoint The Barrens,46.81,76.47,60,0
.waypoint The Barrens,47.08,78.69,60,0
.waypoint The Barrens,46.98,79.83,60,0
.waypoint The Barrens,48.73,79.22,60,0
.waypoint The Barrens,47.45,74.53,60,0
.waypoint The Barrens,44.95,75.19,60,0
>>Kill a |cRXP_ENEMY_Thunderhawk|r. Loot it for its |cRXP_LOOT_Wings|r
.complete 913,1 
.mob Thunderhawk Hatchling
.mob Thunderhawk Cloudscraper
.mob Greater Thunderhawk
step
.goto The Barrens,50.48,78.72,100 >> Travel into Dustwallow Marsh
.zoneskip Dustwallow Marsh
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
>>|cRXP_WARN_Be careful! There are level 36-38 mobs in the area. Follow the waypoint for safety|r
step << Warrior/Shaman
.goto Dustwallow Marsh,36.17,31.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Zulrg|r|cRXP_BUY_. Buy a|r |T135158:0|t[Big Stick] |cRXP_BUY_from him if it's up|r
.collect 12251,1,873,1 
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
>>|cRXP_BUY_Buy the|r |T133735:0|t[First Aid Manuals] |cRXP_BUY_from her|r
.collect 16112,1,873,1 >> Manual: Heavy Silk Bandage (1)
.collect 16113,1,873,1 >> Manual: Mageweave Bandage (1)
.collect 16084,1,873,1 >> Manual: Expert First Aid - Under Wraps (1)
.target Balai Lok'Wein
.skill firstaid,<1,1
step
#completewith WeaponsofChoiceTurnin
.goto Dustwallow Marsh,35.57,31.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shardi|r
.fp Brackenwall >> Get the Brackenwall Village Flight Path
.fly Camp Taurajo >> Fly to Camp Taurajo
.target Shardi
.zoneskip The Barrens
.cooldown item,6948,<0
step
.goto Dustwallow Marsh,35.57,31.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Shardi|r
.fp Brackenwall >> Get the Brackenwall Village Flight Path
.target Shardi
.zoneskip The Barrens
.cooldown item,6948,>0
step << Druid
#completewith DruidTraining33
.cast 18960 >>Cast |T135758:0|t[Teleport: Moonglade]
.zoneskip Moonglade
.cooldown item,6948,>0,1
step << Druid
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 1075 >> Train your class spells
.target Loganaar
.xp <24,1
.xp >26,1
.cooldown item,6948,>0,1
step << Druid
#optional
#label DruidTraining33
.goto Moonglade,52.53,40.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Loganaar|r
.train 1850 >> Train your class spells
.target Loganaar
.xp <26,1
.cooldown item,6948,>0,1
step
#completewith WeaponsofChoiceTurnin
.hs >> Hearth to Camp Taurajo
.use 6948
.cooldown item,6948,>0
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
.accept 884 >>Accept Owatanka
.turnin 884 >>Turn in Owatanka
.itemcount 5102,1
.target Jorn Skyseer
step
.goto The Barrens,44.86,59.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorn|r
.accept 885 >>Accept Washte Pawne
.turnin 885 >>Turn in Washte Pawne
.target Jorn Skyseer
.itemcount 5103,1
step
.goto The Barrens,44.86,59.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorn|r
.accept 897 >>Accept The Harvester
.turnin 897 >>Turn in The Harvester
.itemcount 5138,1
.target Jorn Skyseer
step
.goto The Barrens,44.85,59.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Jorn|r
.turnin 913 >>Turn in Cry of the Thunderhawk
.accept 874 >>Accept Mahren Skyseer
.accept 6382 >>Accept The Ashenvale Hunt
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
.goto The Barrens,51.07,29.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Korran|r
.turnin 868 >> Turn in Egg Hunt
.target Korran
.isQuestComplete 868
step
#optional
.destroy 5058 >>Destroy any extra |T132834:0|t[Silithid Eggs] you still have
.itemcount 5058,1
step
#optional
.abandon 868 >> Abandon Egg Hunt
.isOnQuest 868
step << skip
.goto The Barrens,51.99,29.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Innkeeper Boorand|r
.home >>Set your Hearthstone to Crossroads
.target Innkeeper Boorand Plainswind
step << Rogue
.goto The Barrens,51.39,30.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hula'mahi|r
.vendor >>|cRXP_BUY_Stock up on|r |T134387:0|t[Flash Powder] |cRXP_BUY_and supplies for|r |T132273:0|t[Instant Poison]
.target Hula'mahi
step
.goto The Barrens,51.50,30.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Devrak|r
.fly Ratchet >> Fly to Ratchet
.target Devrak
step
.goto The Barrens,65.84,43.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mahren|r
.turnin 874 >>Turn in Mahren Skyseer
.accept 873 >>Accept Isha Awak
.target Mahren Skyseer
step
#loop
.goto The Barrens,65.67,46.63,0
.goto The Barrens,64.74,50.35,0
.goto The Barrens,63.60,53.54,0
.waypoint The Barrens,65.77,45.28,50,0
.waypoint The Barrens,65.67,46.63,50,0
.waypoint The Barrens,64.74,50.35,50,0
.waypoint The Barrens,63.60,53.54,50,0
>>Kill |cRXP_ENEMY_Isha Awak|r. Loot him for the |cRXP_LOOT_Heart of Isha Awak|r
>>|cRXP_WARN_He has four different spawn locations alongside the coast|r
.complete 873,1 
.unitscan Isha Awak
step
.goto The Barrens,65.84,43.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Mahren|r
.turnin 873 >> Turn in Isha Awak
.target Mahren Skyseer
step
.goto The Barrens,63.09,37.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bragok|r
.fly Orgrimmar >> Fly to Orgrimmar
.target Bragok
step << Warlock
.goto Orgrimmar,48.25,45.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gan'rul|r
.trainer >> Train your class spells
.turnin 1512 >>Turn in Love's Gift
.accept 1513 >>Accept The Binding
.target Gan'rul Bloodeye
step << Warlock
#completewith next
.cast 9224 >>Use |T133290:0|t[Dogran's Pendant] at the Summoning Circle
.use 6626
step << Warlock
.goto Orgrimmar,49.66,50.15
>>Kill the |cRXP_ENEMY_Summoned Succubus|r
.complete 1513,1 
.mob Summoned Succubus
.use 6626
step << Warlock
.goto Orgrimmar,48.25,45.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Gan'rul|r
.turnin 1513 >>Turn in The Binding
.target Gan'rul Bloodeye
step << Mage
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 2121 >> Train your class spells
.target Pephredo
.xp <24,1
.xp >26,1
step << Mage
#optional
.goto Orgrimmar,38.36,85.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Pephredo|r
.train 120 >> Train your class spells
.target Pephredo
.xp <26,1
step << Mage
.goto Orgrimmar,38.66,85.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Thuul|r at the top of the hut
.train 3567 >> Train |T135759:0|t[Teleport: Orgrimmar]
.target Thuul
step << Troll Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.turnin 5642 >> Turn in Shadowguard
.trainer >> Train your class spells
.target Ur'kyo
step << Undead Priest
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 3747 >> Train your class spells
.target Ur'kyo
.xp <24,1
.xp >26,1
step << Undead Priest
#optional
.goto Orgrimmar,35.59,87.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|r |cRXP_FRIENDLY_Ur'kyo|r
.train 992 >> Train your class spells
.target Ur'kyo
.xp <26,1
step << Priest/Warlock
.goto Orgrimmar,44.16,48.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Katis|r|cRXP_BUY_. Buy a|r |T135139:0|t[Burning Wand] |cRXP_BUY_from her|r
.collect 5210,1 
.money <0.5808
.itemStat 18,QUALITY,<7
.itemStat 18,ITEM_MOD_DAMAGE_PER_SECOND_SHORT,<17.4
.target Katis
step << Shaman
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 905 >> Train your class spells
.target Kardris Dreamseeker
.xp <24,1
.xp >26,1
step << Shaman
#optional
.goto Orgrimmar,38.82,36.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kardris|r
.train 943 >> Train your class spells
.target Kardris Dreamseeker
.xp <26,1
step << Warrior
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 5308 >> Train your class spells
.target Grezz Ragefist
.xp <24,1
.xp >26,1
step << Warrior
#optional
.goto Orgrimmar,79.91,31.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Grezz|r
.train 6178 >> Train your class spells
.target Grezz Ragefist
.xp <26,1
step << Troll Warrior/Undead Warrior/Tauren Warrior
.goto Orgrimmar,81.52,19.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hanashi|r
.train 197 >>Train Two-Handed Axes
.target Hanashi
step << Hunter
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 14262 >> Train your class spells
.target Ormak Grimshot
.xp <24,1
.xp >26,1
step << Hunter
#optional
.goto Orgrimmar,66.05,18.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ormak|r
.train 3045 >> Train your class spells
.target Ormak Grimshot
.xp <26,1
step << Hunter
.goto Orgrimmar,66.34,14.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Xao'tsu|r
.train 24558 >> Train your pet spells
.target Xao'tsu
.xp <24,1
step << Hunter
.goto Orgrimmar,78.08,38.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Jin'sora|r
>>|cRXP_BUY_Buy|r |T132382:0|t[Sharp Arrows] |cRXP_BUY_from him|r
.collect 2515,1800 << Hunter 
.target Jin'sora
.itemcount 2515,<1000
.xp >25,1
step << Hunter
.goto Orgrimmar,78.08,38.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|t|cRXP_BUY_Talk to|r |cRXP_FRIENDLY_Jin'sora|r
>>|cRXP_BUY_Buy|r |T132382:0|t[Razor Arrows] |cRXP_BUY_from him|r
.collect 3030,1800 << Hunter 
.target Jin'sora
.xp <25,1
.itemcount 3030,<1000
step << Shaman
#xprate >1.99
#season 2
.equip 18,206387 >> |cRXP_WARN_Equip the|r |T134920:0|t|cRXP_LOOT_[Kajaric Icon]|r
.use 206387
.itemcount 206387,1 
.train 410095,1
step << Shaman
#xprate >1.99
#season 2
.goto Orgrimmar,52.77,48.97
.subzone 2437 >> Enter Ragefire Chasm inside the Cleft of Shadow
.itemStat 18,QUALITY,2
.train 410095,1
step << Shaman
#xprate >1.99
#season 2
>>|cRXP_WARN_Hug the right side of the wall. After going down the ramp (just after the 5th mob), walk into the shallow lava pool on your right|r
>>|cRXP_WARN_Damage taken from|r |T135805:0|t[Lava] |cRXP_WARN_is reduced to 91 whilst the|r |T134920:0|t|cRXP_LOOT_[Kajaric Icon]|r |cRXP_WARN_is equipped|r
.aura 408828 >>|cRXP_WARN_Take damage from the |T135805:0|t[Lava] |cRXP_WARN_source 5 times|r
.itemStat 18,QUALITY,2
.train 410095,1
step << Shaman
#xprate >1.99
#season 2
>>|cRXP_WARN_Move out of the|r |T135805:0|t[Lava]
.cast 402265 >>|cRXP_WARN_Use the|r |T134920:0|t|cRXP_LOOT_[Kajaric Icon]|r |cRXP_WARN_to learn|r |T133816:0|t[Engrave Gloves - Lava Burst]
.use 206387
.aura -408828
.itemStat 18,QUALITY,2
.train 410095,1
step
#ah
.goto Orgrimmar,55.59,62.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Thathung|r
>>|cRXP_BUY_Buy the|r |T133021:0|t[Shredder Operating Manual Pages] |cRXP_BUY_from the Auction House if they're available|r 
.target Auctioneer Thathung
.collect 16645,1,6504,1 
.collect 16646,1,6504,1 
.collect 16647,1,6504,1 
.collect 16648,1,6504,1 
.collect 16649,1,6504,1 
.collect 16650,1,6504,1 
.collect 16651,1,6504,1 
.collect 16652,1,6504,1 
.collect 16653,1,6504,1 
.collect 16654,1,6504,1 
.collect 16655,1,6504,1 
.collect 16656,1,6504,1 
step << Hunter
.goto Orgrimmar,45.12,63.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Doras|r
.fly Splintertree Post >> Fly to Splintertree Post
.target Doras
.zoneskip Thunder Bluff
step << !Hunter
#completewith next
.goto Orgrimmar,26.22,61.58,80,0
.goto Orgrimmar,15.66,63.33,30,0
.zone The Barrens >> Leave Orgrimmar through the Western exit
.zoneskip The Barrens
step << !Hunter
#completewith next
.goto Kalimdor,56.80,45.45,15,0
.goto Ashenvale,94.54,76.15,40,0
.goto Ashenvale,93.49,73.76,40,0
.goto Ashenvale,92.47,71.18,40,0
.goto Ashenvale,91.85,68.71,40,0
.goto Ashenvale,91.39,65.86,25 >> Travel north alongside the river into Ashenvale
step << !Hunter
.goto Ashenvale,89.87,68.07,40,0
.goto Ashenvale,86.89,68.65,40,0
.goto Ashenvale,79.89,68.38,40,0
.goto Ashenvale,73.52,63.50,30 >>Travel to Splintertree Post
>>|cRXP_WARN_You may encounter a few level 29-30 mobs, avoid them if possible|r
]])
