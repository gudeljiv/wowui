RXPGuides.RegisterGuide([[
#classic
#version 1
<< Alliance
#group Custom Quests for RXP
#subgroup SoD Level 50 Quest Stacking
#name 50-1-How to Use this Guide
#displayname 1-How to Use this Guide
#next 50-2-Pre-Launch Collection Guide

-- |cRXP_FRIENDLY_, |cRXP_ENEMY_, |cRXP_LOOT_, |cRXP_WARN_, |cRXP_PICK_, |cRXP_BUY_
-- |c99ffff99 OR|r
-- |Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk

step
    >>Welcome to the |cRXP_WARN_SoD Level 50|r Quest Stacking Guide!
    +Use the Collection Guide to complete pre-req quests and gather items for launch day.
    +|cRXP_WARN_ON LAUNCH DAY|r, use the Turn-in Guide.
]])

RXPGuides.RegisterGuide([[
#classic
#version 4
<< Alliance
#group Custom Quests for RXP
#subgroup SoD Level 50 Quest Stacking
#name 50-2-Pre-Launch Collection Guide
#displayname 2-Pre-Launch Collection Guide
#next 50-3-Launch Day Turn-in Route

step
  .maxlevel 49
  >>|cRXP_WARN_NOTE|r: This guide is for |cRXP_WARN_HIGHER LEVEL|r characters.
  .xp 50
step
  >>|cRXP_WARN_LEVEL 50 ALLIANCE QUEST STACK|r
  >>This guide is for collection prior to launch day.
  +Only turn-in specified quests in this guide.
  +Other quests are left in your quest log for launch day.
  >>|cRXP_WARN_For more details see|r
  .link https://www.patreon.com/joardee >>Joardee's Patreon spreadsheet
step
  >>|cRXP_WARN_WARNING PLEASE READ CAREFULLY!!!!|r
  >>Many quest addons auto-turn-in quests (INCLUDING THIS ONE).
  >>It is your responsibility to safeguard your Launch Day quests.
  +|cRXP_PICK_I understand|r
  >>|cRXP_WARN_PRO TIP|r: Store turn-in items in the bank to prevent accidental turn-in.

-- STORMWIND CITY #1 --
 step
  .target Crier Goodman
  >>Talk to |cRXP_FRIENDLY_Crier Goodman|r in Stormwind. He patrols around the city.
  .accept 5066 >>Accept A Call to Arms: The Plaguelands!
  >>|cRXP_WARN_NOTE|r: This quest can also be picked up in Ironforge or Darnassus.
step
  .goto Stormwind City,64.2,20.8
  .target Brohann Caskbelly
  >>Talk to |cRXP_FRIENDLY_Brohann Caskbelly|r in Stormwind City
  .accept 1448 >>Accept In Search of The Temple
step
  .isQuestTurnedIn 1448
  .goto Stormwind City,64.2,20.8
  .target Brohann Caskbelly
  >>Talk to |cRXP_FRIENDLY_Brohann Caskbelly|r in Stormwind City
  .accept 1449 >>Accept To The Hinterlands
step
  .isQuestTurnedIn 1469
  .goto Stormwind City,64.2,20.8
  .target Brohann Caskbelly
  >>Talk to |cRXP_FRIENDLY_Brohann Caskbelly|r in Stormwind City
  .accept 82098 >>Accept Into the Temple of Atal'Hakkar
step
  .goto Stormwind City,53.6,59.6
  .target Auctioneer Jaxon
  >>Buy |cRXP_BUY_Un'Goro Soil|r from the Auction House
  .collect 11018,20,3764,1
  
-- BLASTED LANDS #1 --
step
  .goto Blasted Lands,67.6,19.2
  .target Ambassador Ardalan
  >>Talk to |cRXP_FRIENDLY_Ambassador Ardalan|r at Nethergarde Keep
  .accept 2783 >>Accept Petty Squabbles
step
  .goto Blasted Lands,63.6,20.6
  .target Enohar Thunderbrew
  >>Talk to |cRXP_FRIENDLY_Enohar Thunderbrew|r at Nethergarde Keep
  .accept 4128 >>Accept Ragnar Thunderbrew

-- SWAMP OF SORROWS #1 --
step
  .goto Swamp of Sorrows,34.2,66.0
  .target Fallen Hero of the Horde
  >>Talk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r in the Swamp of Sorrows
  .turnin 2783 >>Turn in Petty Squabbles
  .accept 2801 >>Accept A Tale of Sorrow
step
  .goto Swamp of Sorrows,34.2,66.0
  .target Fallen Hero of the Horde
  >>Listen to the |cRXP_FRIENDLY_Fallen Hero of the Horde's|r tale in Swamp of Sorrows
  .complete 2801,1 >>A Tale of Sorrow
  .turnin 2801 >>Turn in A Tale of Sorrow
  .accept 2681 >>Accept The Stones that Bind Us
step
  .goto Swamp of Sorrows,69,44
  >>Search for the |cRXP_FRIENDLY_Temple of Atal'Hakkar|r in the Swamp of Sorrows
  .complete 1448,1 >>In Search of The Temple

-- BLASTED LANDS #2 --
step
  #completewith blasted2
  >>Kill |cRXP_ENEMY_Mobs|r in Blasted Lands for the following items:
  .collect 10593,1,3501,1 -- Everything Counts In Large Amounts
  .collect 8391,5,2581,1 -- Snickerfang Jowls + Vulture's Vigor
  .collect 8393,6,2585,1 -- The Decisive Striker + Snickerfang Jowls + A Boar's Vitality
  .collect 8392,6,2583,1 -- A Boar's Vitality
  .collect 8394,11,2601,1 -- The Basilisk's Bite + A Boar's Vitality
  .collect 8396,14,2603,1 -- Vulture's Vigor + The Basilisk's Bite + The Decisive Striker
  >>|cRXP_WARN_SAVE THESE ITEMS FOR LAUNCH DAY TURN-IN|r
step
  .goto Blasted Lands,41.8,14.6
  >>Attack a |cRXP_ENEMY_Servant of Grol|r near a Stone of Binding.
  >>When the Servant's health is low enough, click the Stone of Binding.
  .complete 2681,2 >>The Stones that Bind Us
  .mob Servant of Grol
step
  .goto Blasted Lands,38.0,33.4
  >>Attack a |cRXP_ENEMY_Servant of Sevine|r near a Stone of Binding.
  >>When the Servant's health is low enough, click the Stone of Binding.
  .complete 2681,4 >>The Stones that Bind Us
  .mob Servant of Sevine
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  .goto Blasted Lands,58.0,49.8
  >>Attack a |cRXP_ENEMY_Servant of Razelikh|r near a Stone of Binding.
  >>When the Servant's health is low enough, click the Stone of Binding.
  .complete 2681,1 >>The Stones that Bind Us
  .mob Servant of Razelikh
step
  .goto Blasted Lands,64.6,47.6
  >>Attack a |cRXP_ENEMY_Servant of Allistarj|r near a Stone of Binding.
  >>When the Servant's health is low enough, click the Stone of Binding.
  .complete 2681,3 >>The Stones that Bind Us
  .mob Servant of Allistarj
step
  #label blasted2
  >>Kill |cRXP_ENEMY_Teremus the Devourer|r in Blasted Lands for the |cRXP_LOOT_Flawless Draenethyst Sphere|r
  .collect 8244,1,2521,1 >>To Serve Kum'isha
  .unitscan Teremus the Devourer
  >>|cRXP_WARN_SAVE THIS ITEM FOR LAUNCH DAY TURN-IN|r
step
  >>Kill |cRXP_ENEMY_Mobs|r in Blasted Lands for the following items:
  .collect 10593,1,3501,1 -- Everything Counts In Large Amounts
  .collect 8391,5,2581,1 -- Snickerfang Jowls + Vulture's Vigor
  .collect 8393,6,2585,1 -- The Decisive Striker + Snickerfang Jowls + A Boar's Vitality
  .collect 8392,6,2583,1 -- A Boar's Vitality
  .collect 8394,11,2601,1 -- The Basilisk's Bite + A Boar's Vitality
  .collect 8396,14,2603,1 -- Vulture's Vigor + The Basilisk's Bite + The Decisive Striker
  >>|cRXP_WARN_SAVE THESE ITEMS FOR LAUNCH DAY TURN-IN|r

-- STORMWIND CITY #2 --
step
  .goto Stormwind City,64.2,20.8
  .target Brohann Caskbelly
  >>Talk to |cRXP_FRIENDLY_Brohann Caskbelly|r in Stormwind City
  .turnin 1448 >>Turn in In Search of The Temple
  .accept 1449 >>Accept To The Hinterlands

-- BURNING STEPPES #1 --
step
  .goto Burning Steppes,85.6,69.0
  .target Helendis Riverhorn
  >>Talk to |cRXP_FRIENDLY_Helendis Riverhorn|r at Morgan's Vigil
  .accept 4182 >>Accept Dragonkin Menace
step
  .goto Burning Steppes,92.2,44.2
  >>Kill |cRXP_ENEMY_Dragonkin Mobs|r in Burning Steppes
  .complete 4182,1
  .complete 4182,2
  .complete 4182,3
  .complete 4182,4 >>Dragonkin Menace
  .mob Black Broodling
  .mob Black Dragonspawn
  .mob Black Drake
  .mob Black Wyrmkin
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  .goto Burning Steppes,85.4,70.0
  .target Jalinda Sprig
  >>Talk to |cRXP_FRIENDLY_Jalinda Sprig|r at Morgan's Vigil, Burning Steppes
  .accept 4262 >>Accept Overmaster Pyron

-- SEARING GORGE #1 --
step
  #completewith searing1
  >>Kill |cRXP_ENEMY_Dark Iron mobs|r in Searing Gorge for the |cRXP_LOOT_Grimesilt Outhouse Key|r
  .collect 11818,1,4451,1 -- The Key to Freedom
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  .goto Searing Gorge,63.8,60.8
  .target Dorius Stonetender
  >>Talk to |cRXP_FRIENDLY_Dorius Stonetender|r in Searing Gorge
  .accept 3367 >>Accept Suntara Stones
step
  .goto Searing Gorge,74.5,19.5
  .target Arko'narin
  >>Escort |cRXP_FRIENDLY_Dorius|r back to Ironforge
  .complete 3367,1 >>Suntara Stones
step
  .goto Searing Gorge,63.8,60.8
  .target Signed Letter
  >>Click the |cRXP_FRIENDLY_Signed Letter|r in Searing Gorge
  .turnin 3367 >>Turn in Suntara Stones
  .accept 3368 >>Accept Suntara Stones
step
  .goto Searing Gorge,39.0,39.0
  .target Velarok Windblade
  >>Talk to |cRXP_FRIENDLY_Velarok Windblade|r in Searing Gorge
  .accept 3441 >>Accept Divine Retribution
step
  .goto Searing Gorge,39.0,39.0
  .target Velarok Windblade
  >>Listen to |cRXP_FRIENDLY_Velarok Windblade|r tell his story
  .complete 3441,1 >>Divine Retribution
step
  .goto Searing Gorge,39.0,39.0
  .target Velarok Windblade
  >>Talk to |cRXP_FRIENDLY_Velarok Windblade|r in Searing Gorge
  .turnin 3441 >>Turn in Divine Retribution
  .accept 3442 >>Accept The Flawless Flame
step
  #completewith next
  >>Kill |cRXP_ENEMY_Elementals|r in Searing Gorge for |cRXP_LOOT_Hearts of Flame|r
  .complete 3442,1 >>The Flawless Flame
  .mob Inferno Elemental
  .mob Magma Elemental
  .mob Blazing Elemental
  >>|cRXP_WARN_NOTE|r: Mobs are located throughout the zone.
step
  >>Kill |cRXP_ENEMY_Golems|r in Searing Gorge for |cRXP_LOOT_Golem Oil|r
  .complete 3442,2 >>The Flawless Flame
  .mob Heavy War Golem
  .mob Tempered War Golem
  >>|cRXP_WARN_NOTE|r: Mobs are located throughout the zone.
step
  >>Kill |cRXP_ENEMY_Elementals|r in Searing Gorge for |cRXP_LOOT_Hearts of Flame|r
  .complete 3442,1 >>The Flawless Flame
  .mob Inferno Elemental
  .mob Magma Elemental
  .mob Blazing Elemental
  >>|cRXP_WARN_NOTE|r: Mobs are located throughout the zone.
step
  .goto Searing Gorge,39.0,39.0
  .target Velarok Windblade
  >>Talk to |cRXP_FRIENDLY_Velarok Windblade|r in Searing Gorge
  .turnin 3442 >>Turn in The Flawless Flame
  .accept 3443 >>Accept Forging the Shaft
step
  >>Kill |cRXP_ENEMY_Dark Iron mobs|r in Searing Gorge for |cRXP_LOOT_Thorium Plated Daggers|r
  .complete 3443,1 >>Forging the Shaft
  .mob Slave Worker
  .mob Dark Iron Taskmaster
  .mob Dark Iron Steamsmith
  .mob Dark Iron Slaver
  >>|cRXP_WARN_NOTE|r: Mobs are located throughout the zone.
step
  .goto Searing Gorge,39.0,39.0
  .target Velarok Windblade
  >>Talk to |cRXP_FRIENDLY_Velarok Windblade|r in Searing Gorge
  .turnin 3443 >>Turn in Forging the Shaft
  .accept 3452 >>Accept The Flame's Casing
step
  .goto Searing Gorge,21,36
  >>Kill |cRXP_ENEMY_Twilight mobs|r in Searing Gorge for the |cRXP_LOOT_Symbol of Ragnaros|r
  .complete 3452,1 >>The Flame's Casing
  .mob Twilight Dark Shaman
  .mob Twilight Fire Guard
  .mob Twilight Geomancer
  .mob Twilight Idolater
step
  .goto Searing Gorge,39.0,39.0
  .target Velarok Windblade
  >>Talk to |cRXP_FRIENDLY_Velarok Windblade|r in Searing Gorge
  .turnin 3452 >>Turn in The Flame's Casing
  .accept 3453 >>Accept The Torch of Retribution
step
  >>Wait for |cRXP_FRIENDLY_Velarok Windblade|r to complete the torch
  .complete 3453,1 >>The Torch of Retribution
  .turnin 3453 >>Turn in The Torch of Retribution
  .accept 3454 >>Accept The Torch of Retribution
step
  .goto Searing Gorge,39.0,39.1
  .target Torch of Retribution
  >>Click the |cRXP_FRIENDLY_Torch of Retribution|r next to Velarok Windblade
  .turnin 3454 >>Turn in The Torch of Retribution
step
  .goto Searing Gorge,39.0,39.0
  .target Velarok Windblade
  >>Talk to |cRXP_FRIENDLY_Velarok Windblade|r in Searing Gorge
  .accept 3462 >>Accept Squire Maltrake
step
  .goto Searing Gorge,39.0,39.0
  .target Squire Maltrake
  >>Talk to |cRXP_FRIENDLY_Squire Maltrake|r 
  .turnin 3462 >>Turn in Squire Maltrake
  .accept 3463 >>Accept Set Them Ablaze!
step
  .goto Searing Gorge,33,54
  .use 10515
  >>Use the |cRXP_PICK_Torch of Retribution|r to light the Northern Tower's Sentry Brazier 
  .complete 3463,4 >>Set Them Ablaze!
step
  .goto Searing Gorge,35,60
  .use 10515
  >>Use the |cRXP_PICK_Torch of Retribution|r to light the Western Tower's Sentry Brazier 
  .complete 3463,1 >>Set Them Ablaze!
step
  .goto Searing Gorge,43,60
  .use 10515
  >>Use the |cRXP_PICK_Torch of Retribution|r to light the Southern Tower's Sentry Brazier 
  .complete 3463,2 >>Set Them Ablaze!
step
  #label searing1
  .goto Searing Gorge,49,54
  .use 10515
  >>Use the |cRXP_PICK_Torch of Retribution|r to light the Eastern Tower's Sentry Brazier 
  .complete 3463,3 >>Set Them Ablaze!
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  >>Kill |cRXP_ENEMY_Dark Iron mobs|r in Searing Gorge for the |cRXP_LOOT_Grimesilt Outhouse Key|r
  .collect 11818,1,4451,1 -- The Key to Freedom
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- BLACKROCK MOUNTAIN #1 --
step
  >>Kill |cRXP_ENEMY_Overmaster Pyron|r right outside the BRD instance
  .complete 4262,1 >>Overmaster Pyron
  .unitscan Overmaster Pyron
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- WESTERN PLAGUELANDS #1 --
step
  .goto Western Plaguelands,42.8,84.0
  .target Commander Ashlam Valorfist
  >>Talk to |cRXP_FRIENDLY_Commander Ashlam Valorfist|r at Chillwind Camp in Western Plaguelands
  .turnin 5066 >>Turn in A Call to Arms: The Plaguelands!
  .accept 5092 >>Accept Clear the Way
step
  .goto Western Plaguelands,49.2,78.4
  .target Marlene Redpath
  >>Talk to |cRXP_FRIENDLY_Marlene Redpath|r in Western Plaguelands
  .accept 5142 >>Accept Little Pamela
step
  .goto Western Plaguelands,50.6,77.6
  >>Kill |cRXP_ENEMY_Skeletal Flayers and Slavering Ghouls|r in Western Plaguelands
  .complete 5092,1
  .complete 5092,2 >>Clear the Way
  .mob Skeletal Flayer
  .mob Slavering Ghoul
step
  .goto Western Plaguelands,42.8,84.0
  .target Commander Ashlam Valorfist
  >>Talk to |cRXP_FRIENDLY_Commander Ashlam Valorfist|r at Chillwind Camp
  .turnin 5092 >>Turn in Clear the Way
  .accept 5215 >>Accept The Scourge Cauldrons
  .accept 5097 >>Accept All Along the Watchtowers
step
  .goto Western Plaguelands,42.8,84.6
  .target High Priestess MacDonnell
  >>Talk to |cRXP_FRIENDLY_High Priestess MacDonnell|r at Chillwind Camp
  .turnin 5215 >>Turn in The Scourge Cauldrons
  .accept 5216 >>Accept Target: Felstone Field
step
  .goto Western Plaguelands,39,71
  .use 12815
  >>Use the |cRXP_PICK_Beacon Torch|r to mark Tower One in Western Plaguelands
  .complete 5097,1 >>All Along the Watchtowers
step
  .goto Western Plaguelands,42,65
  .use 12815
  >>Use the |cRXP_PICK_Beacon Torch|r to mark Tower Two in Western Plaguelands
  .complete 5097,2 >>All Along the Watchtowers
step
  .goto Western Plaguelands,44,63
  .use 12815
  >>Use the |cRXP_PICK_Beacon Torch|r to mark Tower Three in Western Plaguelands
  .complete 5097,3 >>All Along the Watchtowers
step
  .goto Western Plaguelands,46,70
  .use 12815
  >>Use the |cRXP_PICK_Beacon Torch|r to mark Tower Four in Western Plaguelands
  .complete 5097,4 >>All Along the Watchtowers
step
  .goto Western Plaguelands,37.0,56.4
  >>Kill |cRXP_ENEMY_Cauldron Lord Bilemaw|r in Western Plaguelands for the |cRXP_LOOT_Felstone Field Cauldron Key|r
  .complete 5216,1 >>Target: Felstone Field
  .unitscan Cauldron Lord Bilemaw
step
  .goto Western Plaguelands,37.2,56.9
  .target Scourge Cauldron
  >>Click the |cRXP_FRIENDLY_Scourge Cauldron|r in Felstone Field
  .turnin 5216 >>Turn in Target: Felstone Field
  .accept 5217 >>Accept Return to Chillwind Camp
step
  .goto Western Plaguelands,42.8,84.0
  .target Commander Ashlam Valorfist
  >>Talk to |cRXP_FRIENDLY_Commander Ashlam Valorfist|r at Chillwind Camp
  .turnin 5097 >>Turn in All Along the Watchtowers
  .accept 211 >>Accept Alas, Andorhal
step
  .goto Western Plaguelands,42.8,84.6
  .target High Priestess MacDonnell
  >>Talk to |cRXP_FRIENDLY_High Priestess MacDonnell|r at Chillwind Camp
  .turnin 5217 >>Turn in Return to Chillwind Camp
  .accept 5219 >>Accept Target: Dalson's Tears
step
  .goto Western Plaguelands,46.2,52.6
  >>Kill |cRXP_ENEMY_Cauldron Lord Malvinious|r in Western Plaguelands for the |cRXP_LOOT_Dalson's Tears Cauldron Key|r
  .complete 5219,1 >>Target: Dalson's Tears
  .unitscan Cauldron Lord Malvinious
step
  .goto Western Plaguelands,46.2,52.0
  .target Scourge Cauldron
  >>Click the |cRXP_FRIENDLY_Scourge Cauldron|r in Western Plaguelands
  .turnin 5219 >>Turn in Target: Dalson's Tears
  .accept 5220 >>Accept Return to Chillwind Camp
step
  .goto Western Plaguelands,42.8,84.6
  .target High Priestess MacDonnell
  >>Talk to |cRXP_FRIENDLY_High Priestess MacDonnell|r at Chillwind Camp
  .turnin 5220 >>Turn in Return to Chillwind Camp
  .accept 5222 >>Accept Target: Writhing Haunt
step
  .goto Western Plaguelands,52.8,66.0
  >>Kill |cRXP_ENEMY_Cauldron Lord Razarch|r in Western Plaguelands for the |cRXP_LOOT_Writhing Haunt Cauldron Key|r
  .complete 5222,1 >>Target: Writhing Haunt
  .unitscan Cauldron Lord Razarch
step
  .goto Western Plaguelands,53.0,65.7
  .target Scourge Cauldron
  >>Click the |cRXP_FRIENDLY_Scourge Cauldron|r in Western Plaguelands
  .turnin 5222 >>Turn in Target: Writhing Haunt
  .accept 5223 >>Accept Return to Chillwind Camp
step
  .goto Western Plaguelands,42.8,84.6
  .target High Priestess MacDonnell
  >>Talk to |cRXP_FRIENDLY_High Priestess MacDonnell|r at Chillwind Camp
  .turnin 5223 >>Turn in Return to Chillwind Camp
  .accept 5225 >>Accept Target: Gahrron's Withering
step
  .goto Western Plaguelands,62.8,58.0
  >>Kill |cRXP_ENEMY_Cauldron Lord Soulwrath|r in Western Plaguelands for the |cRXP_LOOT_Gahrron's Withering Cauldron Key|r
  .complete 5225,1 >>Target: Gahrron's Withering
  .unitscan Cauldron Lord Soulwrath
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  .goto Western Plaguelands,45.6,69.2
  >>Kill |cRXP_ENEMY_Araj the Summoner|r in Western Plaguelands for the |cRXP_LOOT_Araj's Phylactery Shard|r
  .complete 211,1 >>Alas, Andorhal
  .mob Araj the Summoner
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- EASTERN PLAGUELANDS #1 --
step
  .goto Eastern Plaguelands,36.6,90.8
  .target Pamela Redpath
  >>Talk to |cRXP_FRIENDLY_Pamela Redpath|r in Eastern Plaguelands
  .turnin 5142 >>Turn in Little Pamela
  .accept 5149 >>Accept Pamela's Doll
step
  >>Find |cRXP_FRIENDLY_Pamela's Doll's Head, Left side, and Right side|r spread around Darrowshire
  .complete 5149,1 >>Pamela's Doll
step
  .goto Eastern Plaguelands,36.6,90.8
  .target Pamela Redpath
  >>Talk to |cRXP_FRIENDLY_Pamela Redpath|r in Eastern Plaguelands
  .turnin 5149 >>Turn in Pamela's Doll
  .accept 5241 >>Accept Uncle Carlin
  .accept 5152 >>Accept Auntie Marlene
step
  .goto Eastern Plaguelands,81.4,59.8
  .target Carlin Redpath
  >>Talk to |cRXP_FRIENDLY_Carlin Redpath|r in Eastern Plaguelands
  .turnin 5241 >>Turn in Uncle Carlin
  .accept 5168 >>Accept Heroes of Darrowshire

-- WESTERN PLAGUELANDS #2 --
step
  .goto Western Plaguelands,49.2,78.4
  .target Marlene Redpath
  >>Talk to |cRXP_FRIENDLY_Marlene Redpath|r in Western Plaguelands
  .turnin 5152 >>Turn in Auntie Marlene
  .accept 5153 >>Accept A Strange Historian
step
  .goto Western Plaguelands,49.6,76.8
  >>Loot |cRXP_LOOT_Joseph's Wedding Ring|r at Joseph Redpath's Monument in Western Plaguelands
  .complete 5153,1 >>A Strange Historian
step
  .goto Western Plaguelands,39.4,66.8
  .target Chromie
  >>Talk to |cRXP_FRIENDLY_Chromie|r upstairs in the house
  .turnin 5153 >>Turn in A Strange Historian
  .accept 5154 >>Accept The Annals of Darrowshire
step
  .goto Western Plaguelands,43.5,70.0
  >>Loot the |cRXP_LOOT_Annals of Darrowshire|r from a Musty Tome in Western Plaguelands
  .complete 5154,1 >>The Annals of Darrowshire
  .link https://wow.zamimg.com/uploads/screenshots/normal/4980-annals-of-darrowshire.jpg >>See this image to find the correct tome
step
  .goto Western Plaguelands,39.4,66.8
  .target Chromie
  >>Talk to |cRXP_FRIENDLY_Chromie|r upstairs in the house
  .turnin 5154 >>Turn in The Annals of Darrowshire
  .accept 5210 >>Accept Brother Carlin
step
  .goto Western Plaguelands,42.5,18.9
  >>Loot the |cRXP_LOOT_Davil's Libram|r at Hearthglen in Western Plaguelands
  .complete 5168,1 >>Heroes of Darrowshire
step
  .goto Western Plaguelands,63.7,57.2
  >>Loot the |cRXP_LOOT_Redpath's Shield|r near the barn of Gahrron's Withering in Western Plaguelands
  .complete 5168,2 >>Heroes of Darrowshire

-- EASTERN PLAGUELANDS #2 --
step
  .goto Eastern Plaguelands,81.4,59.8
  .target Carlin Redpath
  >>Talk to |cRXP_FRIENDLY_Carlin Redpath|r in Eastern Plaguelands
  .turnin 5168 >>Turn in Heroes of Darrowshire
  .turnin 5210 >>Turn in Brother Carlin
  .accept 5181 >>Accept Villains of Darrowshire
step
  .goto Eastern Plaguelands,51.1,49.9
  >>Loot the |cRXP_LOOT_Skull of Horgus|r at the bottom of the lake in Eastern Plaguelands
  .complete 5181,1 >>Villains of Darrowshire
step
  .goto Eastern Plaguelands,53.9,65.8
  >>Loot the |cRXP_LOOT_Shattered Sword of Marduk|r at the infectous scar in Eastern Plaguelands
  .complete 5181,1 >>Villains of Darrowshire
step
  .goto Eastern Plaguelands,81.4,59.8
  .target Carlin Redpath
  >>Talk to |cRXP_FRIENDLY_Carlin Redpath|r in Eastern Plaguelands
  .turnin 5181 >>Turn in Villains of Darrowshire
  .accept 5206 >>Accept Marauders of Darrowshire
step
  .goto Eastern Plaguelands,84.6,37.8
  >>Kill |cRXP_ENEMY_Scourge Champions|r in Eastern Plaguelands for |cRXP_LOOT_Fetid Skulls|r
  .collect 13157,5,5206,1,-1 -- Marauders of Darrowshire
  .mob Scourge Champion
  .use 13156
  >>Use the |cRXP_PICK_Mystic Crystal|r to create |cRXP_LOOT_Resonating Skulls|r 
  .complete 5206,1 >>Marauders of Darrowshire
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- THE HINTERLANDS #1 --
step
  .goto The Hinterlands,11.8,46.8
  .target Falstad Wildhammer
  >>Talk to |cRXP_FRIENDLY_Falstad Wildhammer|r in Aerie Peak
  .turnin 1449 >>Turn in To The Hinterlands
  .accept 1450 >>Accept Gryphon Master Talonaxe
step
  .goto The Hinterlands,9.8,44.6
  .target Gryphon Master Talonaxe
  >>Talk to |cRXP_FRIENDLY_Gryphon Master Talonaxe|r in Aerie Peak
  .turnin 1450 >>Turn in Gryphon Master Talonaxe
  .accept 1451 >>Accept Rhapsody Shindigger
  .accept 2988 >>Accept Witherbark Cages
step
  .goto The Hinterlands,26.8,48.6
  .target Rhapsody Shindigger
  >>Talk to |cRXP_FRIENDLY_Rhapsody Shindigger|r in The Hinterlands
  .turnin 1451 >>Turn in Rhapsody Shindigger
  .accept 1452 >>Accept Rhapsody's Kalimdor Kocktail
step
  .goto The Hinterlands,23.2,58.7
  .target First Witherbark Cage
  >>Check the |cRXP_FRIENDLY_First Witherbark Cage|r in the Zun'Watha ruins
  .complete 2988,1 >>Witherbark Cages
step
  .goto The Hinterlands,23.1,58.7
  .target Second Witherbark Cage
  >>Check the |cRXP_FRIENDLY_Second Witherbark Cage|r in the Zun'Watha ruins
  .complete 2988,2 >>Witherbark Cages
step
  .goto The Hinterlands,31,57
  .target Third Witherbark Cage
  >>Check the |cRXP_FRIENDLY_Third Witherbark Cage|r in the Hiri'Watha ruins
  .complete 2988,3 >>Witherbark Cages
step
  .goto The Hinterlands,9.8,44.6
  .target Gryphon Master Talonaxe
  >>Talk to |cRXP_FRIENDLY_Gryphon Master Talonaxe|r at Aerie Peak
  .turnin 2988 >>Turn in Witherbark Cages
  .accept 2989 >>Accept The Altar of Zul
step
  .goto The Hinterlands,49,68
  >>Check the top of the |cRXP_FRIENDLY_The Altar of Zul|r in The Hinterlands
  .complete 2989,1 >>The Altar of Zul
step
  .goto The Hinterlands,9.8,44.6
  .target Gryphon Master Talonaxe
  >>Talk to |cRXP_FRIENDLY_Gryphon Master Talonaxe|r at Aerie Peak
  .turnin 2989 >>Turn in The Altar of Zul
  .accept 2990 >>Accept Thadius Grimshade

-- ARATHI HIGHLANDS #1 --
step
  .goto Arathi Highlands,62.5,33.8
  .target Shards of Myzrael
  >>Click the |cRXP_FRIENDLY_Shards of Myzrael|r in Arathi Highlands
  .accept 642 >>Accept The Princess Trapped
step
  .goto Arathi Highlands,82.6,38.0
  >>Kill |cRXP_ENEMY_Drywhisker Kobolds|r East of Hammerfall for the |cRXP_LOOT_Motes of Myzrael|r
  .complete 642,1 >>The Princess Trapped
  .mob Drywhisker Kobold
  .mob Drywhisker Digger
  .mob Drywhisker Surveyor
step
  .goto Arathi Highlands,80,40,5,0
  .goto Arathi Highlands,84.3,30.9
  .target Iridescent Shards
  >>Click the |cRXP_FRIENDLY_Iridescent Shards|r in the cave East of Hammerfall
  .turnin 642 >>Turn in The Princess Trapped
  .accept 651 >>Accept Stones of Binding
step
  .goto Arathi Highlands,66.7,29.8
  >>Loot the |cRXP_LOOT_Cresting Key|r by clicking the Stone of East Binding NW of Hamerfall
  .complete 651,2 >>Stones of Binding
step
  .goto Arathi Highlands,52.1,50.7
  >>Loot the |cRXP_LOOT_Thundering Key|r by clicking the Stone of Outer Binding in Arathi Highlands
  .complete 651,3 >>Stones of Binding
step
  .goto Arathi Highlands,25.5,30.2
  >>Loot the |cRXP_LOOT_Burning Key|r by clicking the Stone of West Binding in Arathi Highlands
  .complete 651,1 >>Stones of Binding
step
  .goto Arathi Highlands,36.2,57.5
  .target Stone of Inner Binding
  >>Click the |cRXP_FRIENDLY_Stone of Inner Binding|r in Arathi Highlands
  .turnin 651 >>Turn in Stones of Binding
  .accept 652 >>Accept Breaking the Keystone
step
  >>Kill |cRXP_ENEMY_Fozruk|r in Arathi Highlands for the |cRXP_LOOT_Rod of Order|r
  .complete 652,1 >>Breaking the Keystone
  .unitscan Fozruk
  >>|cRXP_WARN_NOTE|r: He patrols around the entire zone
step
  .goto Arathi Highlands,36.1,57.9
  .target Keystone
  >>Click the |cRXP_FRIENDLY_Keystone|r in Arathi Highlands
  .turnin 652 >>Turn in Breaking the Keystone
  .accept 653 >>Accept Myzrael's Allies

-- IRONFORGE #1 --
step
  .goto Ironforge,69.0,46.8
  .target Klockmort Spannerspan
  >>Talk to |cRXP_FRIENDLY_Klockmort Spannerspan|r 
  .accept 2769 >>Accept The Brassbolts Brothers
step
  .goto Ironforge,72.8,16.8
  .target Curator Thorius
  >>Talk to |cRXP_FRIENDLY_Curator Thorius|r in Ironforge
  .turnin 3368 >>Turn in Suntara Stones
  .accept 3371 >>Accept Dwarven Justice
step
  .goto Ironforge,77.2,11.8
  .target Historian Karnik
  >>Talk to |cRXP_FRIENDLY_Historian Karnik|r in Ironforge
  .accept 3448 >>Accept Passing the Burden
step
  .goto Ironforge,75.6,23.6
  .target Laris Geardawdle
  >>Talk to |cRXP_FRIENDLY_Laris Geardawdle|r in Ironforge
  .accept 4512 >>Accept A Little Slime Goes a Long Way
step
  .goto Ironforge,50.6,6.2
  .target Gerrig Bonegrip
  >>Talk to |cRXP_FRIENDLY_Gerrig Bonegrip|r in Ironforge
  .turnin 653 >>Turn in Myzrael's Allies
  .accept 687 >>Accept Theldurin the Lost
step
  .goto Ironforge,31.2,4.6
  .target Tymor
  >>Talk to |cRXP_FRIENDLY_Tymor|r in the Mystic Ward
  .turnin 3448 >>Turn in Passing the Burden
  .accept 3449 >>Accept Arcane Runes
step
  .goto Ironforge,38.6,55.6
  .target Royal Historian Archesonus
  >>Talk to |cRXP_FRIENDLY_Royal Historian Archesonus|r in Ironforge
  .accept 3702 >>Accept The Smoldering Ruins of Thaurissan
step
  .target Royal Historian Archesonus
  >>Listen to |cRXP_LOOT_Royal Historian Archesonus|r recant the history of Thaurissan
  .complete 3702,1 >>The Smoldering Ruins of Thaurissan
step
  .goto Ironforge,38.6,55.6
  .target Royal Historian Archesonus
  >>Talk to |cRXP_FRIENDLY_Royal Historian Archesonus|r in Ironforge
  .turnin 3702 >>Turn in The Smoldering Ruins of Thaurissan
  .accept 3701 >>Accept The Smoldering Ruins of Thaurissan
step
  .goto Ironforge,25.0,73.6
  >>Buy a |cRXP_BUY_Mithril Casing|r from the Auction House 
  .collect 10561,1,4244,1

-- BURNING STEPPES #2 --
step
  .goto Burning Steppes,64.6,37.0
  >>Loot |cRXP_LOOT_Thaurissan Relics|r at the Ruins of Thaurissan in Burning Steppes
  .complete 3701,1 >>The Smoldering Ruins of Thaurissan
step
  .goto Ironforge,38.6,55.6
  .target Royal Historian Archesonus
  >>Talk to |cRXP_FRIENDLY_Royal Historian Archesonus|r in Ironforge
  .turnin 3701 >>Turn in The Smoldering Ruins of Thaurissan
  >>|cRXP_WARN_DON'T ACCEPT THE NEXT QUEST - THIS IS YOUR BREADCRUMB|r

-- DUN MOROGH #1 --
step
  .goto Dun Morogh,46.8,52.4
  .target Ragnar Thunderbrew
  >>Talk to |cRXP_FRIENDLY_Ragnar Thunderbrew|r at Kharanos
  .turnin 4128 >>Turn in Ragnar Thunderbrew
  .accept 4126 >>Accept Hurley Blackbreath

-- SEARING GORGE #2 --
step
  .goto Searing Gorge,41.2,25.6
  .target Dying Archaeologist
  >>Talk to |cRXP_FRIENDLY_Dying Archaeologist|r inside the underground cavern in Searing Gorge
  .turnin 3371 >>Turn in Dwarven Justice
  .accept 3372 >>Accept Release Them
step
  .goto Searing Gorge,29.2,25.9
  >>Loot the |cRXP_LOOT_Mysterious Artifact|r guarded by the Twilight's Hammer in NW Searing Gorge
  .complete 3372,1 >>Release Them
step
  .goto Searing Gorge,41.4,25.4
  .target Altar of Suntara
  >>Click the |cRXP_FRIENDLY_Altar of Suntara|r inside the underground cavern in Searing Gorge
  .turnin 3372 >>Turn in Release Them
step
  .goto Searing Gorge,41.2,25.6
  .target Dying Archaeologist
  >>Talk to |cRXP_FRIENDLY_Dying Archaeologist|r inside the underground cavern in Searing Gorge
  .accept 3566 >>Accept Rise, Obsidion!
step
  .goto Searing Gorge,41.6,26.6
  >>Kill |cRXP_ENEMY_Lathoric the Black|r for the |cRXP_LOOT_Head of Lathoric the Black|r
  .complete 3566,1 >>Rise, Obsidion!
  .mob Lathoric the Black
  >>Kill |cRXP_ENEMY_Obsidion|r for the |cRXP_LOOT_Heart of Obsidion|r
  .complete 3566,2 >>Rise, Obsidion!
  .mob Obsidion
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- BLACKROCK MOUNTAIN #1 --
step
  >>Head to Blackrock Depths
  >>Kill |cRXP_ENEMY_Hurley Blackbreath|r at the Grim Guzzler for the |cRXP_LOOT_Lost Thunderbrew Recipe|r
  .complete 4126,1 >>Hurley Blackbreath
  .mob Hurley Blackbreath
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- BADLANDS #1 --
step
  .goto Badlands,51.4,76.8
  .target Theldurin the Lost
  >>Find |cRXP_FRIENDLY_Theldurin the Lost|r in the Badlands
  .turnin 687 >>Turn in Theldurin the Lost
  .accept 692 >>Accept The Lost Fragments
step
  .goto Badlands,54.8,86.0
  >>Kill |cRXP_ENEMY_Enraged Rock Elementals|r in the Badlands for the |cRXP_LOOT_Torn, Crumpled, and Singed Scroll Fragments|r
  .complete 692,1
  .complete 692,2
  .complete 692,3 >>The Lost Fragments
  .mob Enraged Rock Elemental
step
  .goto Badlands,51.4,76.8
  .target Theldurin the Lost
  >>Talk to |cRXP_FRIENDLY_Theldurin the Lost|r in the Badlands
  .turnin 692 >>Turn in The Lost Fragments
  .accept 656 >>Accept Summoning the Princess

-- BLASTED LANDS #3 --
step
  .goto Blasted Lands,67.0,19.4
  .target Thadius Grimshade
  >>Talk to |cRXP_FRIENDLY_Thadius Grimshade|r at Nethergarde Keep, Blasted Lands
  .turnin 2990 >>Turn in Thadius Grimshade
  .accept 2991 >>Accept Nekrum's Medallion

-- ARATHI HIGHLANDS #2 --
step
  .goto Arathi Highlands,62.6,34.6
  .use 4472
  >>Summon and Kill |cRXP_ENEMY_Myzrael|r in Arathi Highlands for the |cRXP_LOOT_Eldritch Shackles|r
  .complete 656,1 >>Summoning the Princess
  .mob Myzrael
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- --------------------------------------------------------------------- --

-- FELWOOD #1 --
step
  .goto Felwood,39.6,22.2
  >>Kill |cRXP_ENEMY_Xavaric|r in Felwood for the |cRXP_LOOT_Flute of Xavaric|r
  .collect 11668,1,939,1 >>Flute of Xavaric
  .unitscan Xavaric
step
  .itemcount 11668,1
  >>Use the Flute of Xavaric to Accept the quest
  .use 11668
  .accept 939 >>Accept Flute of Xavaric
  .goto Felwood,39.6,22.2
step
  .goto Felwood,42.6,18.6
  >>Kill |cRXP_ENEMY_Jadefire mobs|r in Felwood for |cRXP_LOOT_Jadefire Felbinds|r
  .complete 939,1 >>Flute of Xavaric
  .mob Jadefire Betrayer
  .mob Jadefire Trickster
  .mob Jadefire Hellcaller
step
  #completewith next
  .goto Felwood,38.6,49.6
  .use 11948
  >>Kill |cRXP_ENEMY_Tainted Oozes|r in Felwood then fill the |cRXP_PICK_Empty Tainted Ooze Jar|r while targeting the corpse
  .complete 4512,2 >>A Little Slime Goes a Long Way
  .mob Tainted Ooze
step
  .goto Felwood,40.2,68.6
  .use 11914
  >>Kill |cRXP_ENEMY_Cursed Oozes|r in Felwood then fill the |cRXP_PICK_Empty Cursed Ooze Jar|r while targeting the corpse
  .complete 4512,1 >>A Little Slime Goes a Long Way
  .mob Cursed Ooze
step
  .goto Felwood,38.6,49.6
  .use 11948
  >>Kill |cRXP_ENEMY_Tainted Oozes|r in Felwood then fill the |cRXP_PICK_Empty Tainted Ooze Jar|r while targeting the corpse
  .complete 4512,2 >>A Little Slime Goes a Long Way
  .mob Tainted Ooze
step
  .goto Felwood,51.2,82.2
  .target Greta Mosshoof
  >>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r in Felwood
  .accept 5155 >>Accept Forces of Jaedenar
step
  .goto Felwood,50.8,81.6
  .target Taronn Redfeather
  >>Talk to |cRXP_FRIENDLY_Taronn Redfeather|r in Felwood
  .accept 5156 >>Accept Verifying the Corruption
step
  .goto Felwood,54.2,86.8
  .target Arathandris Silversky
  >>Talk to |cRXP_FRIENDLY_Arathandris Silversky|r in Felwood
  .accept 4101 >>Accept Cleansing Felwood
step
  .goto Felwood,51.2,81.6
  .target Eridan Bluewind
  >>Talk to |cRXP_FRIENDLY_Eridan Bluewind|r at the Emerald Sanctuary
  .turnin 939 >>Turn in Flute of Xavaric
  .accept 4441 >>Accept Felbound Ancients
step
  .goto Felwood,34.6,60.2
  >>Kill |cRXP_ENEMY_Jaedenar Mobs|r in Felwood
  .complete 5155,1
  .complete 5155,2
  .complete 5155,3
  .complete 5155,4 >>Forces of Jaedenar
  .mob Jaedenar Hound
  .mob Jaedenar Guardian
  .mob Jaedenar Adept
  .mob Jaedenar Cultist
step
  >>Kill |cRXP_ENEMY_Jaedenar mobs|r in Jaedenar, Felwood for the |cRXP_LOOT_Blood Red Key|r
  .collect 13140,1,5202,1 >>A Strange Red Key
  .mob Jaedenar Warlock
  .mob Jaedenar Enforcer
  .mob Jaedenar Darkweaver
  .mob Jaedenar Legionnaire
step
  >>Use the Blood Red Key to Accept the quest
  .use 13140
  .accept 5202 >>Accept A Strange Red Key
  .goto Felwood,36.2,55.6
step
  .goto Felwood,36.2,55.6
  .target Captured Arko'narin
  >>Talk to |cRXP_FRIENDLY_Captured Arko'narin|r in Jaedenar, Felwood
  .turnin 5202 >>Turn in A Strange Red Key
  .accept 5203 >>Accept Rescue From Jaedenar
step
  .goto Felwood,36.2,55.6
  .target Arko'narin
  >>Escort and Protect |cRXP_FRIENDLY_Arko'narin|r to get her equipment and escape from Shadow Hold
  .complete 5203,1 >>Rescue From Jaedenar
step
  .goto Felwood,51.2,82.2
  .target Greta Mosshoof
  >>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r in Felwood
  .turnin 5155 >>Turn in Forces of Jaedenar
  .accept 5157 >>Accept Collection of the Corrupt Water
step
  .goto Felwood,51.2,82.0
  .target Jessir Moonbow
  >>Talk to |cRXP_FRIENDLY_Jessir Moonbow|r at the Emerald Sanctuary
  .turnin 5203 >>Turn in Rescue From Jaedenar
  .accept 5204 >>Accept Retribution of the Light
step
  .goto Felwood,35,59
  .use 12922
  >>Use the |cRXP_PICK_Empty Canteen|r to collect |cRXP_LOOT_Corrupt Moonwell Water|r from the Corrupted Moonwell in Jaedenar
  .complete 5157,1 >>Collection of the Corrupt Water
step
  .goto Felwood,38.8,49.8
  >>Kill |cRXP_ENEMY_Rakaiah|r in Jaedenar, Felwood
  .complete 5204,1 >>Retribution of the Light
  .mob Rakaiah
step
  .goto Felwood,38.6,50.4
  .target Remains of Trey Lightforge
  >>Click the |cRXP_FRIENDLY_Remains of Trey Lightforge|r in Jaedenar, Felwood
  .turnin 5204 >>Turn in Retribution of the Light
  .accept 5385 >>Accept The Remains of Trey Lightforge
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  .goto Felwood,43.4,40.2
  >>Kill |cRXP_ENEMY_Entropic Mobs|r in Felwood
  .complete 5156,1
  .complete 5156,2 >>Verifying the Corruption
  .mob Entropic Beast
  .mob Entropic Horror
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  .goto Felwood,51.2,82.2
  .target Greta Mosshoof
  >>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r in Felwood
  .turnin 5157 >>Turn in Collection of the Corrupt Water
  .accept 5158 >>Accept Seeking Spiritual Aid
step
  .goto Felwood,55.2,17.6
  >>Kill |cRXP_ENEMY_Warpwood Mobs|r in Northern Felwood for |cRXP_LOOT_Blood Ambers|r
  .complete 4101,1 >>Cleansing Felwood
  .mob Warpwood Moss Flayer
  .mob Warpwood Shredder
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- DARNASSUS #1 --
step
  .goto Darnassus,39,84
  .use 11682
  >>Use |cRXP_PICK_Eridan's Vial|r to collect a |cRXP_LOOT_Vial of Blessed Water|r from the Temple of the Moon in Darnassus
  .complete 4441,1 >>Felbound Ancients
step
  .goto Darnassus,42.0,85.8
  .target Gracina Spiritmight
  >>Talk to |cRXP_FRIENDLY_Gracina Spiritmight|r in Darnassus
  .accept 4493 >>Accept March of the Silithid

-- AZSHARA #1 --
step
  .goto Azshara,36,53
  .use 10445
  >>Use the |cRXP_PICK_Drawing Kit|r to collect the |cRXP_LOOT_Rubbing: Rune of Beth'Amara|r in Azshara
  .complete 3449,1 >>Arcane Runes
step
  .goto Azshara,39,50
  .use 10445
  >>Use the |cRXP_PICK_Drawing Kit|r to collect the |cRXP_LOOT_Rubbing: Rune of Jin'yael|r in Azshara
  .complete 3449,2 >>Arcane Runes
step
  .goto Azshara,39,55
  .use 10445
  >>Use the |cRXP_PICK_Drawing Kit|r to collect the |cRXP_LOOT_Rubbing: Rune of Markri|r in Azshara
  .complete 3449,3 >>Arcane Runes
step
  .goto Azshara,42,64
  .use 10445
  >>Use the |cRXP_PICK_Drawing Kit|r to collect the |cRXP_LOOT_Rubbing: Rune of Sael'hai|r in Azshara
  .complete 3449,4 >>Arcane Runes
step
  .goto Azshara,77.8,91.4
  .target Pilot Xiggs Fuselighter
  >>Talk to |cRXP_FRIENDLY_Pilot Xiggs Fuselighter|r in Azshara
  .turnin 3449 >>Turn in Arcane Runes
  .accept 3461 >>Accept Return to Tymor
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- THE BARRENS #1 --
step
  .goto The Barrens,65.8,43.8
  .target Islen Waterseer
  >>Talk to |cRXP_FRIENDLY_Islen Waterseer|r South of Ratchet in The Barrens
  .turnin 5158 >>Turn in Seeking Spiritual Aid
  .accept 5159 >>Accept Cleansed Water Returns to Felwood

-- STRANGLETHORN VALE #1 --
step
  .goto Stranglethorn Vale,23.0,71.2
  >>Kill |cRXP_ENEMY_Mok'rash|r in Stranglethorn Vale for the |cRXP_LOOT_Monogrammed Sash|r
  .collect 3985,1,8552,1 >>The Monogrammed Sash
  .unitscan Mok'rash
  >>|cRXP_WARN_DON'T ACCEPT THE ITEM'S QUEST - SAVE FOR LAUNCH DAY|r

-- FELWOOD #2 --
step
  .goto Felwood,51.2,82.2
  .target Greta Mosshoof
  >>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r in Felwood
  .turnin 5159 >>Turn in Cleansed Water Returns to Felwood
  .accept 5165 >>Accept Dousing the Flames of Protection
step
  .goto Felwood,51.2,81.6
  .target Eridan Bluewind
  >>Talk to |cRXP_FRIENDLY_Eridan Bluewind|r at the Emerald Sanctuary
  .turnin 4441 >>Turn in Felbound Ancients
  .accept 4442 >>Accept Purified!
step
  .goto Felwood,51.2,81.6
  .target Eridan Bluewind
  >>Wait for the RP, then speak to |cRXP_FRIENDLY_Eridan Bluewind|r again
  .turnin 4442 >>Turn in Purified!
step
  .goto Felwood,36,56
  .use 12906
  >>Use the |cRXP_PICK_Purified Moonwell Water|r to Extinguish the Brazier of Pain inside the cave at Jaedenar
  .complete 5165,1 >>Dousing the Flames of Protection
step
  .goto Felwood,37,55
  .use 12906
  >>Use the |cRXP_PICK_Purified Moonwell Water|r to Extinguish the Brazier of Hatred inside the cave at Jaedenar
  .complete 5165,4 >>Dousing the Flames of Protection
step
  .goto Felwood,37,53
  .use 12906
  >>Use the |cRXP_PICK_Purified Moonwell Water|r to Extinguish the Brazier of Suffering inside the cave at Jaedenar
  .complete 5165,3 >>Dousing the Flames of Protection
step
  .goto Felwood,38,53
  .use 12906
  >>Use the |cRXP_PICK_Purified Moonwell Water|r to Extinguish the Brazier of Malic inside the cave at Jaedenar
  .complete 5165,2 >>Dousing the Flames of Protection
step
  .goto Felwood,51.2,82.2
  .target Greta Mosshoof
  >>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r in Felwood
  .turnin 5165 >>Turn in Dousing the Flames of Protection
  .accept 5242 >>Accept A Final Blow
step
  .goto Felwood,35.8,64.6
  >>Kill |cRXP_ENEMY_Moora, Salia, and Shadow Lord Fel'dan|r inside the cave at Jaedenar and retrieve |cRXP_LOOT_Shadow Lord Fel'dan's Head|r
  .complete 5242,1
  .complete 5242,2
  .complete 5242,3 >>A Final Blow
  .mob Moora
  .mob Salia
  .mob Shadow Lord Fel'dan
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  .goto Felwood,50,31
  >>Travel to the Irontree Woods, use the Flute of the Ancients, and talk to |cRXP_FRIENDLY_Arei|r
  .use 11445
  .accept 4261 >>Accept Ancient Spirit
step
  .goto Felwood,49.4,14.6
  .target Arei
  >>Escort |cRXP_FRIENDLY_Arei|r to safety
  .complete 4261,1 >>Ancient Spirit
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- IRONFORGE #2 --
step
  .goto Ironforge,75.6,23.6
  .target Laris Geardawdle
  >>Talk to |cRXP_FRIENDLY_Laris Geardawdle|r in Ironforge
  .turnin 4512 >>Turn in A Little Slime Goes a Long Way
  .accept 4513 >>Accept A Little Slime Goes a Long Way

-- THOUSAND NEEDLES #1 --
step
  .goto Thousand Needles,78.0,77.0
  .target Wizzle Brassbolts
  >>Talk to |cRXP_FRIENDLY_Wizzle Brassbolts|r in The Shimmering Flats
  .accept 2770 >>Accept Gahz'rilla

-- TANARIS #1 --
step
  .goto Tanaris,50.8,27.0
  .target Alchemist Pestlezugg
  >>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r in Gadgetzan
  .turnin 4493 >>Turn in March of the Silithid
  .accept 4496 >>Accept Bungle in the Jungle
step
  .goto Tanaris,50.6,33.8
  >>Kill |cRXP_ENEMY_Rocs|r in Tanaris for |cRXP_LOOT_Roc Gizzards|r
  .complete 1452,1 >>Rhapsody's Kalimdor Kocktail
  .mob Roc
  .mob Fire Roc
  .mob Searing Roc
step
  .goto Tanaris,67.0,22.4
  .target Yeh'kinya
  >>Talk to |cRXP_FRIENDLY_Yeh'kinya|r in Steamweedle Port
  .accept 3520 >>Accept Screecher Spirits

-- UN'GORO CRATER #1 --
step
  #completewith ungoro1
  >>Kill |cRXP_ENEMY_ANY MOB|r in Un'Goro Crater for |cRXP_LOOT_A Mangled Journal|r
  .collect 11116,1,3884,1 -- Williden's Journal
  >>|cRXP_WARN_DON'T ACCEPT THE ITEM'S QUEST - SAVE FOR LAUNCH DAY|r
step
  #completewith ungoro1
  >>Click |cRXP_PICK_Power Crystal Nodes|r in Un'Goro Crater for |cRXP_LOOT_Power Crystals|r
  .collect 11186,7,4284,1
  .collect 11188,7,4284,1
  .collect 11185,7,4284,1
  .collect 11184,7,4284,1 >>Crystals of Power
step
  .goto Un'Goro Crater,63.1,68.5
  .target A Wrecked Raft
  >>Click the |cRXP_FRIENDLY_A Wrecked Raft|r in Un'Goro Crater
  .accept 3844 >>Accept It's a Secret to Everybody
step
  .goto Un'Goro Crater,63.1,69.0
  .target A Small Pack
  >>Click the |cRXP_FRIENDLY_A Small Pack|r in Un'Goro Crater
  .turnin 3844 >>Turn in It's a Secret to Everybody
  .accept 3845 >>Accept It's a Secret to Everybody
step
  .goto Un'Goro Crater,49.6,84.6
  >>Kill |cRXP_ENEMY_Gorishi bugs|r in Un'Goro Crater for the |cRXP_LOOT_Gorishi Scent Gland|r
  .complete 4496,1 >>Bungle in the Jungle
  .mob Gorishi Worker
  .mob Gorishi Wasp
  .mob Gorishi Reaver
  .mob Gorishi Tunneler
  .mob Gorishi Stinger
step
  >>Collect |cRXP_LOOT_Un'Goro Soil|r in Un'Goro Crater
  .complete 4496,2 >>Bungle in the Jungle
step
  .goto Un'Goro Crater,64.2,37.8
  .use 11953
  >>Kill |cRXP_ENEMY_Oozes|r in Un'Goro Crater then fill the |cRXP_PICK_Empty Pure Sample Jar|r while targeting the corpse
  .complete 4513,1 >>A Little Slime Goes a Long Way
  .mob Muculent Ooze
  .mob Glutinous Ooze
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  .goto Un'Goro Crater,44.6,8.2
  .target Linken
  >>Talk to |cRXP_FRIENDLY_Linken|r at Marshal's Refuge
  .turnin 3845 >>Turn in It's a Secret to Everybody
  .accept 3908 >>Accept It's a Secret to Everybody
step
  .goto Un'Goro Crater,43.6,8.6
  .target Spraggle Frock
  >>Talk to |cRXP_FRIENDLY_Spraggle Frock|r at Marshal's Refuge
  .accept 4492 >>Accept Lost!
step
  .goto Un'Goro Crater,51,50
  .target Ringo
  >>Talk to |cRXP_FRIENDLY_Ringo|r inside a small cave near the top of Fire Plume Ridge
  .turnin 4492 >>Turn in Lost!
  .accept 4491 >>Accept A Little Help From My Friends
step
  .goto Un'Goro Crater,43.6,8.6
  .use 11804
  .target Ringo
  >>Escort |cRXP_FRIENDLY_Ringo|r to Spraggle Frock at Marshal's Refuge
  >>If Ringo faints, use Spraggle's Canteen to revive him.
  .complete 4491,1 >>A Little Help From My Friends
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  .goto Un'Goro Crater,46.6,13.4
  .target Karna Remtravel
  >>Talk to |cRXP_FRIENDLY_Karna Remtravel|r at Marshal's Refuge
  .accept 4243 >>Accept Chasing A-Me 01
step
  .goto Un'Goro Crater,67.6,16.8
  .target A-Me 01
  >>Talk to |cRXP_FRIENDLY_A-Me 01|r in Un'Goro Crater
  .turnin 4243 >>Turn in Chasing A-Me 01
  .accept 4244 >>Accept Chasing A-Me 01
step
  .goto Un'Goro Crater,67.6,16.8
  .target A-Me 01
  >>Talk to |cRXP_FRIENDLY_A-Me 01|r in Un'Goro Crater
  .turnin 4244 >>Turn in Chasing A-Me 01
  .accept 4245 >>Accept Chasing A-Me 01
step
  #label ungoro1
  .goto Un'Goro Crater,46.6,13.4
  .target A-Me 01
  >>Escort |cRXP_FRIENDLY_A-Me 01|r to Karna Remtravel at Marshal's Refuge
  .complete 4245,1 >>Chasing A-Me 01
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- WINTERSPRING #1 --
step
  .goto Winterspring,31.2,45.2
  .target Donova Snowden
  >>Talk to |cRXP_FRIENDLY_Donova Snowden|r in Winterspring
  .turnin 3908 >>Turn in It's a Secret to Everybody
  .accept 3909 >>Accept The Videre Elixir
step
  .goto Winterspring,27.8,34.6
  .target Salfa
  >>Talk to |cRXP_FRIENDLY_Salfa|r in Winterspring
  .accept 8464 >>Accept Winterfall Activity
step
  .goto Winterspring,67.8,37.8
  >>Kill |cRXP_ENEMY_Winterfall mobs|r in Winterspring
  .complete 8464,1
  .complete 8464,2
  .complete 8464,3 >>Winterfall Activity
  .mob Winterfall Shaman
  .mob Winterfall Den Watcher
  .mob Winterfall Ursa
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- FERALAS #1 --
step
  .goto Feralas,44.8,36.6
  .use 10699
  >>Kill |cRXP_ENEMY_Vale Screechers|r in Feralas then use the |cRXP_PICK_Yeh'kinya's Bramble|r to capture the Screecher's Spirit|r
  .complete 3520,1 >>Screecher Spirits
  .mob Vale Screecher
  .mob Rogue Vale Screecher
step
  .goto Feralas,45.0,25.6
  .target Gregan Brewspewer
  >>Buy |cRXP_BUY_Bait|r from Gregan Brewspewer in Northern Feralas
  .collect 11141,1,3909,1
step
  .goto Feralas,44.6,10.6
  .use 11141
  >>Place the |cRXP_PICK_Bait|r near Miblon Snarltooth. The door will open, then gather the |cRXP_LOOT_Evoroot|r
  .collect 11242,1,3909,1 >>The Videre Elixir
step
  .goto Feralas,45.0,25.6
  >>Return to |cRXP_PICK_Gregan Brewspewer|r in Northern Feralas for the |cRXP_LOOT_Videre Elixir|r
  .collect 11243,1,3909,1 >>The Videre Elixir
step
  .goto Feralas,48.4,38.6
  >>Kill |cRXP_ENEMY_Ironfur Bears|r in Feralas for |cRXP_LOOT_Ironfur Livers|r
  .complete 1452,2 >>Rhapsody's Kalimdor Kocktail
  .mob Ironfur Bear
  .mob Grizzled Ironfur Bear
step
  .goto Feralas,50.2,49.6
  >>Kill |cRXP_ENEMY_Groddoc Apes|r in Feralas for |cRXP_LOOT_Groddoc Livers|r
  .complete 1452,3 >>Rhapsody's Kalimdor Kocktail
  .mob Groddoc Ape
  .mob Groddoc Thunderer
step
  >>Kill |cRXP_ENEMY_ANY MOB|r in Feralas for the |cRXP_LOOT_OOX-22/FE Distress Beacon|r
  .collect 8705,1,2766,1 -- Find OOX-22/FE!
step
  >>Use the OOX-22/FE Distress Beacon to Accept the quest
  .use 8705
  .accept 2766 >>Accept Find OOX-22/FE!
  .goto Feralas,53.4,55.6
  .target Homing Robot OOX-22/FE
  >>Talk to the |cRXP_FRIENDLY_Homing Robot OOX-22/FE|r 
  .turnin 2766 >>Turn in Find OOX-22/FE!
  .accept 2767 >>Accept Rescue OOX-22/FE!
step
  .goto Feralas,44.1,42.7
  .target Homing Robot OOX-22/FE
  >>Escort the |cRXP_FRIENDLY_Homing Robot OOX-22/FE|r to the dock along the Forgotten Coast
  .complete 2767,1 >>Rescue OOX-22/FE!
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- WINTERSPRING #2 --
step
  .goto Winterspring,31.2,45.2
  .target Donova Snowden
  >>Talk to |cRXP_FRIENDLY_Donova Snowden|r in Winterspring
  .turnin 3909 >>Turn in The Videre Elixir
  .accept 3912 >>Accept Meet at the Grave

-- TANARIS #2 --
step
  .goto Tanaris,52.4,28.4
  .target Chief Engineer Bilgewhizzle
  >>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r in Gadgetzan
  .accept 2768 >>Accept Divino-matic Rod
step
  .goto Tanaris,50.8,27.0
  .target Alchemist Pestlezugg
  >>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r in Gadgetzan
  .turnin 4496 >>Turn in Bungle in the Jungle
  .accept 4507 >>Accept Pawn Captures Queen
step
  .goto Tanaris,54.0,23.2
  .use 11243
  >>Use the |cRXP_PICK_Videre Elixir|r at the graveyard outside Gadgetzan (this will kill you)
  >>Then talk to |cRXP_FRIENDLY_Gaeriyan|r in ghost form 
  .turnin 3912 >>Turn in Meet at the Grave
  .accept 3913 >>Accept A Grave Situation
step
  .goto Tanaris,53.9,29.0
  .target A Conspicuous Gravestone
  >>Resurrect and Click |cRXP_FRIENDLY_A Conspicuous Gravestone|r in Tanaris
  .turnin 3913 >>Turn in A Grave Situation
  .accept 3914 >>Accept Linken's Sword
step
  .goto Tanaris,67.0,22.4
  .target Yeh'kinya
  >>Talk to |cRXP_FRIENDLY_Yeh'kinya|r in Steamweedle Port
  .turnin 3520 >>Turn in Screecher Spirits
  .accept 3527 >>Accept The Prophecy of Mosh'aru

-- UN'GORO CRATER #2 --
step
  .goto Un'Goro Crater,44.6,8.2
  .target Linken
  >>Talk to |cRXP_FRIENDLY_Linken|r at Marshal's Refuge
  .turnin 3914 >>Turn in Linken's Sword
  .accept 3941 >>Accept A Gnome's Assistance
step
  .goto Un'Goro Crater,41.8,2.6
  .target J.D. Collie
  >>Talk to |cRXP_FRIENDLY_J.D. Collie|r in the cave at Marshal's Refuge
  .turnin 3941 >>Turn in A Gnome's Assistance
  .accept 3942 >>Accept Linken's Memory
step
  .goto Un'Goro Crater,44.6,81.6
  .use 11833
  >>Summon and Kill the |cRXP_ENEMY_Gorishi Hive Queen|r in Un'Goro Crater for the |cRXP_LOOT_Gorishi Queen Brain|r
  .complete 4507,1 >>Pawn Captures Queen
  .mob Gorishi Hive Queen
step
  >>Kill |cRXP_ENEMY_ANY MOB|r in Un'Goro Crater for |cRXP_LOOT_A Mangled Journal|r
  .collect 11116,1,3884,1 -- Williden's Journal
  >>|cRXP_WARN_DON'T ACCEPT THE ITEM'S QUEST - SAVE FOR LAUNCH DAY|r
step
  >>Click |cRXP_PICK_Power Crystal Nodes|r in Un'Goro Crater for |cRXP_LOOT_Power Crystals|r
  .collect 11186,7,4284,1
  .collect 11188,7,4284,1
  .collect 11185,7,4284,1
  .collect 11184,7,4284,1 >>Crystals of Power

-- FELWOOD #3 --
step
  .goto Felwood,51.2,81.6
  .target Eridan Bluewind
  >>Talk to |cRXP_FRIENDLY_Eridan Bluewind|r in Southern Felwood
  .turnin 3942 >>Turn in Linken's Memory
  .accept 4084 >>Accept Silver Heart
step
  >>Kill |cRXP_ENEMY_Bears and Wolves|r in Felwood for |cRXP_LOOT_Silvery Claws|r
  .complete 4084,1 >>Silver Heart
  .mob Angerclaw Bear
  .mob Felpaw Wolf
  .mob Felpaw Scavenger
  .mob Angerclaw Mauler
  >>|cRXP_WARN_NOTE|r: Mobs are located throughout the zone.
step
  .goto Felwood,51.6,21.6
  >>Kill |cRXP_ENEMY_Irontree Elementals|r in Northern Felwood for the |cRXP_LOOT_Irontree Heart|r
  .complete 4084,2 >>Silver Heart
  .mob Irontree Stomper
  .mob Irontree Wanderer
step
  .goto Felwood,51.2,81.6
  .target Eridan Bluewind
  >>Talk to |cRXP_FRIENDLY_Eridan Bluewind|r in Southern Felwood
  .turnin 4084 >>Turn in Silver Heart
  .accept 4005 >>Accept Aquementas

-- TANARIS #3 --
step
  .goto Tanaris,50.8,27.0
  .target Alchemist Pestlezugg
  >>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r in Gadgetzan
  .turnin 4507 >>Turn in Pawn Captures Queen
  >>|cRXP_WARN_DON'T ACCEPT THE NEXT QUEST - THIS IS YOUR BREADCRUMB|r

-- ZUL'FARRAK #1 --
step
  >>Head to Zul'Farrak in Tanaris
  >>Kill |cRXP_ENEMY_Theka the Martyr|r for the |cRXP_LOOT_First Mosh'aru Tablet|r
  .complete 3527,1 >>The Prophecy of Mosh'aru
  .mob Theka the Martyr
  >>Kill |cRXP_ENEMY_Hydromancer Velratha|r for the |cRXP_LOOT_Second Mosh'aru Tablet|r
  .complete 3527,2 >>The Prophecy of Mosh'aru
  .mob Hydromancer Velratha
  >>Kill |cRXP_ENEMY_Sergeant Bly|r for the |cRXP_LOOT_Divino-matic Rod|r
  .complete 2768,1 >>Divino-matic Rod
  .mob Sergeant Bly
  >>Kill |cRXP_ENEMY_Nekrum Gutchewer|r for |cRXP_LOOT_Nekrum's Medallion|r
  .complete 2991,1 >>Nekrum's Medallion
  .mob Nekrum Gutchewer
step
  >>Use the Sacred Mallet to Summon and Kill |cRXP_ENEMY_Gahz'rilla|r for |cRXP_LOOT_Gahz'rilla's Electrified Scale|r
  .complete 2770,1 >>Gahz'rilla
  .mob Gahz'rilla
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- TANARIS #4 --
step
  .goto Tanaris,67.0,22.4
  .target Yeh'kinya
  >>Talk to |cRXP_FRIENDLY_Yeh'kinya|r in Steamweedle Port
  .turnin 3527 >>Turn in The Prophecy of Mosh'aru
  .accept 4787 >>Accept The Ancient Egg
step
  .goto Tanaris,74.8,47.6
  >>Kill |cRXP_ENEMY_Pirates|r in Lost Rigger Cove, Tanaris for the |cRXP_LOOT_Ship Schedule|r
  .collect 9250,1,2876,1 -- Ship Schedules
  >>|cRXP_WARN_NOTE|r: It's possible to receive The Ship Schedule from inside a Pirate's Footlocker
  >>|cRXP_WARN_DON'T ACCEPT THE ITEM'S QUEST - SAVE FOR LAUNCH DAY|r
step
  .goto Tanaris,70,50
  .use 11617
  .use 11169
  >>Remove all items from |cRXP_PICK_Eridan's Supplies|r
  >>Head to the Stone Summoning Circle in Tanaris then use the |cRXP_PICK_Book of Aquor|r to Summon Aquementas
  >>Stay in the Circle until Aquementas becomes hostile and your items turn into the |cRXP_LOOT_Silver Totem of Aquementas|r
  .complete 4005,1 >>Aquementas
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- BLASTED LANDS #4 --
step
  .goto Blasted Lands,67.0,19.4
  .target Thadius Grimshade
  >>Talk to |cRXP_FRIENDLY_Thadius Grimshade|r at Nethergarde Keep, Blasted Lands
  .turnin 2991 >>Turn in Nekrum's Medallion
  .accept 2992 >>Accept The Divination
step
  .goto Blasted Lands,67.0,19.4
  .target Thadius Grimshade
  >>Wait for the RP, then speak to |cRXP_FRIENDLY_Thadius Grimshade|r at Nethergarde Keep
  .turnin 2992 >>Turn in The Divination
  .accept 2993 >>Accept Return to the Hinterlands

-- THE HINTERLANDS #2 --
step
  .goto The Hinterlands,9.8,44.6
  .target Gryphon Master Talonaxe
  >>Talk to |cRXP_FRIENDLY_Gryphon Master Talonaxe|r at Aerie Peak, The Hinterlands
  .turnin 2993 >>Turn in Return to the Hinterlands
  .accept 2994 >>Accept Saving Sharpbeak
step
  .goto The Hinterlands,26.8,48.6
  .target Rhapsody Shindigger
  >>Talk to |cRXP_FRIENDLY_Rhapsody Shindigger|r in The Hinterlands
  .turnin 1452 >>Turn in Rhapsody's Kalimdor Kocktail
  .accept 1469 >>Accept Rhapsody's Tale
step
  .goto The Hinterlands,57.5,86.7
  >>Loot the |cRXP_LOOT_Ancient Egg|r in the cave at the top of Jintha'Alor in The Hinterlands
  .complete 4787,1 >>The Ancient Egg
step
  .goto The Hinterlands,59,77
  >>Kill |cRXP_ENEMY_Vile Priestess Hexx|r in Jintha'Alor for |cRXP_LOOT_Hexx's Key|r
  .collect 9472,1,2994,1 >>Saving Sharpbeak
  .mob Vile Priestess Hexx
step
  .goto The Hinterlands,53,66
  .target Sharpbeak's Cage
  >>Open |cRXP_FRIENDLY_Sharpbeak's Cage|r in Jintha'Alor
  .complete 2994,1 >>Saving Sharpbeak
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  >>Kill |cRXP_ENEMY_ANY MOB|r in The Hinterlands for the |cRXP_LOOT_OOX-09/HL Distress Beacon|r
  .collect 8704,1,485,1 -- Find OOX-09/HL!
step
  >>Use the OOX-09/HL Distress Beacon to Accept the quest
  .use 8704
  .accept 485 >>Accept Find OOX-09/HL!
  .goto The Hinterlands,49.4,37.6
  .target Homing Robot OOX-09/HL
  >>Talk to the |cRXP_FRIENDLY_Homing Robot OOX-09/HL|r 
  .turnin 485 >>Turn in Find OOX-09/HL!
  .accept 836 >>Accept Rescue OOX-09/HL!
step
  .goto The Hinterlands,79.2,47.7
  .target Homing Robot OOX-09/HL
  >>Escort the |cRXP_FRIENDLY_Homing Robot OOX-09/HL|r to the shoreline beyond Overlook Cliff
  .complete 836,1 >>Rescue OOX-09/HL!
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- TANARIS #5 -- 
step
  .goto Tanaris,67.0,22.4
  .target Yeh'kinya
  >>Talk to |cRXP_FRIENDLY_Yeh'kinya|r in Steamweedle Port
  .turnin 4787 >>Turn in The Ancient Egg
  .accept 82095 >>Accept The God Hakkar

-- STORMWIND CITY #3 --
step
  .goto Stormwind City,64.2,20.8
  .target Brohann Caskbelly
  >>Talk to |cRXP_FRIENDLY_Brohann Caskbelly|r in Stormwind City
  .turnin 1469 >>Turn in Rhapsody's Tale
  .accept 82098 >>Accept Into the Temple of Atal'Hakkar

-- SUNKEN TEMPLE #1 --
step
  .goto Swamp of Sorrows,70.0,55.1
  >>Head to Sunken Temple in the Swamp of Sorrows
  >>Loot |cRXP_LOOT_Atal'ai Tablets|r inside the Sunken Temple 
  .complete 82098,1 >>Into the Temple of Atal'Hakkar
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  >>Kill |cRXP_ENEMY_Avatar of Hakkar|r for the |cRXP_LOOT_Essence of Hakkar|r
  .complete 82095,1 >>The God Hakkar
  .mob Avatar of Hakkar

-- TANARIS #6 --
step
  .goto Tanaris,67.0,22.4
  .target Yeh'kinya
  >>Talk to |cRXP_FRIENDLY_Yeh'kinya|r in Steamweedle Port
  .turnin 82095 >>Turn in The God Hakkar
step
  .goto Tanaris,66.8,24.0
  .target Prospector Ironboot
  >>Talk to |cRXP_FRIENDLY_Prospector Ironboot|r in Steamweedle Port
  .accept 5065 >>Accept The Lost Tablets of Mosh'aru
step
  >>Kill |cRXP_ENEMY_ANY MOB|r in Tanaris for the |cRXP_LOOT_OOX-17/TN Distress Beacon|r
  .collect 8623,1,351,1 -- Find OOX-17/TN!
step
  >>Use the OOX-17/TN Distress Beacon to Accept the quest
  .use 8623
  .accept 351 >>Accept Find OOX-17/TN!
  .goto Tanaris,60.0,62.8
  .target Homing Robot OOX-17/TN
  >>Talk to the |cRXP_FRIENDLY_Homing Robot OOX-17/TN|r 
  .turnin 351 >>Turn in Find OOX-17/TN!
  .accept 648 >>Accept Rescue OOX-17/TN!
step
  .goto Tanaris,66.8,21.9
  .target Homing Robot OOX-17/TN
  >>Escort the |cRXP_FRIENDLY_Homing Robot OOX-17/TN|r to Steamwheedle Port
  .complete 648,1 >>Rescue OOX-17/TN!
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- EASTERN PLAGUELANDS #3 --
step
  .goto Eastern Plaguelands,72.5,12.9
  >>Loot the |cRXP_LOOT_Third Mosh'aru Tablet|r at Zul'Mashar in Eastern Plaguelands
  .complete 5065,1 >>The Lost Tablets of Mosh'aru
step
  .goto Eastern Plaguelands,72.7,15.7
  >>Loot the |cRXP_LOOT_Fourth Mosh'aru Tablet|r at Zul'Mashar in Eastern Plaguelands
  .complete 5065,2 >>The Lost Tablets of Mosh'aru
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

step
  +CONGRATULATIONS!!! You have completed this route.
]])

RXPGuides.RegisterGuide([[
#classic
#version 3
<< Alliance
#group Custom Quests for RXP
#subgroup SoD Level 50 Quest Stacking
#name 50-3-Launch Day Turn-in Route
#displayname 3-Launch Day Turn-in Route

step
    #sticky
    +|cRXP_WARN_WARNING: ONLY LOAD THIS GUIDE ON LAUNCH DAY, DO NOT ACCIDENTALLY TURN IN YOUR PRE QUESTS|r
step
    >>|cRXP_WARN_LEVEL 50 ALLIANCE QUEST STACK|r
    >>This is a community guide that may have ERRORS.
    >>I recommend testing on the PTR prior to Phase 4 launch.
    +|cRXP_PICK_I understand|r
step
  .isOnQuest 5385
  .goto Felwood,51.2,82.0
  .target Jessir Moonbow
  >>Talk to |cRXP_FRIENDLY_Jessir Moonbow|r in Felwood
  .turnin 5385 >>Turn in The Remains of Trey Lightforge
step
  .isOnQuest 5242
  .goto Felwood,51.2,82.2
  .target Greta Mosshoof
  >>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r in Felwood
  .turnin 5242 >>Turn in A Final Blow
step << Priest
  .isOnQuest 82111
  .goto Felwood,51.2,82.2
  .target Greta Mosshoof
  >>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r in Felwood
  .turnin 82111 >>Turn in Blood of Morphaz
step
  .isOnQuest 5156
  .goto Felwood,50.8,81.6
  .target Taronn Redfeather
  >>Talk to |cRXP_FRIENDLY_Taronn Redfeather|r in Felwood
  .turnin 5156 >>Turn in Verifying the Corruption
step
  .isOnQuest 4102
  .goto Felwood,46.8,83.0
  .target Maybess Riverbreeze
  >>Talk to |cRXP_FRIENDLY_Maybess Riverbreeze|r in Felwood
  .turnin 4102 >>Turn in Cleansing Felwood
step << Warlock
  .isOnQuest 7603
  .goto Felwood,41.6,44.8
  .target Niby the Almighty
  >>Talk to |cRXP_FRIENDLY_Niby the Almighty|r in Felwood
  .turnin 7603 >>Turn in Kroshius' Infernal Core
step << Warlock
  .isOnQuest 82115
  .goto Felwood,41.6,44.8
  .target Impsy
  >>Talk to |cRXP_FRIENDLY_Impsy|r in Felwood
  .turnin 82115 >>Turn in Trolls of a Feather
step
  .isOnQuest 8464
  .goto Winterspring,27.8,34.6
  .target Salfa
  >>Talk to |cRXP_FRIENDLY_Salfa|r in Winterspring
  .turnin 8464 >>Turn in Winterfall Activity
step << !Mage
  .fly Rut'theran Village >>Fly to Darnassus
step << Mage
  .zone Darnassus >>Teleport to Darnassus
step
  .isQuestTurnedIn 4508
  .goto Darnassus,42.0,85.8
  .target Gracina Spiritmight
  >>Talk to |cRXP_FRIENDLY_Gracina Spiritmight|r in Darnassus
  .accept 4510 >>Accept Calm Before the Storm
step
  .isOnQuest 4510
  .goto Darnassus,39.8,42.6
  .target Idriana
  >>Talk to |cRXP_FRIENDLY_Idriana|r in Darnassus
  .turnin 4510 >>Turn in Calm Before the Storm
step
  .goto Darnassus,67.2,15.8
  .target Innkeeper Saelienne
  >>Talk to |cRXP_FRIENDLY_Innkeeper Saelienne|r in Darnassus
  .accept 3763 >>Accept Assisting Arch Druid Staghelm
step
  .isOnQuest 3763
  .goto Darnassus,34.8,8.8
  .target Arch Druid Fandral Staghelm
  >>Talk to |cRXP_FRIENDLY_Arch Druid Fandral Staghelm|r in Darnassus
  .turnin 3763 >>Turn in Assisting Arch Druid Staghelm
step
  .isQuestTurnedIn 3763
  .itemcount 11018,20
  .goto Darnassus,34.8,8.8
  .target Arch Druid Fandral Staghelm
  >>Talk to |cRXP_FRIENDLY_Arch Druid Fandral Staghelm|r in Darnassus
  .accept 3764 >>Accept Un'Goro Soil
step
  .isOnQuest 3764
  .goto Darnassus,31.8,7.0
  .target Jenal
  >>Talk to |cRXP_FRIENDLY_Jenal|r in Darnassus
  .turnin 3764 >>Turn in Un'Goro Soil
step
  .isQuestTurnedIn 3764
  .goto Darnassus,34.8,8.8
  .target Arch Druid Fandral Staghelm
  >>Talk to |cRXP_FRIENDLY_Arch Druid Fandral Staghelm|r in Darnassus
  .accept 3781 >>Accept Morograin Research
step
  .isOnQuest 3781
  .goto Darnassus,35.2,8.0
  .target Mathrengyl Bearwalker
  >>Talk to |cRXP_FRIENDLY_Mathrengyl Bearwalker|r in Darnassus
  .turnin 3781 >>Turn in Morograin Research
step
  .isQuestTurnedIn 3781
  .itemcount 11040,10
  .goto Darnassus,35.2,8.0
  .target Mathrengyl Bearwalker
  >>Talk to |cRXP_FRIENDLY_Mathrengyl Bearwalker|r in Darnassus
  .accept 3785 >>Accept Morograin Research
  .turnin 3785 >>Turn in Morograin Research
step
  .isQuestTurnedIn 3785
  .itemcount 11040,10
  .goto Darnassus,35.2,8.0
  .target Mathrengyl Bearwalker
  >>Talk to |cRXP_FRIENDLY_Mathrengyl Bearwalker|r in Darnassus
  .accept 3803 >>Accept Morrowgrain to Darnassus
  .turnin 3803 >>Turn in Morrowgrain to Darnassus
step
  .goto Darnassus,63.8,22.8
  .target Raedon Duskstriker
  >>Talk to |cRXP_FRIENDLY_Raedon Duskstriker|r in Darnassus
  .turnin 7792 >>Turn in A Donation of Wool
  .turnin 7798 >>Turn in A Donation of Silk
  .turnin 7799 >>Turn in A Donation of Mageweave
  .turnin 7800 >>Turn in A Donation of Runecloth
step
  .isOnQuest 4261
  .fly Talrendis Point >>Fly to Talrendis Point, Azshara
step
  .isOnQuest 4261
  .goto Ashenvale,85.2,44.6
  .target Kayneth Stillwind
  >>Talk to |cRXP_FRIENDLY_Kayneth Stillwind|r in Eastern Ashenvale
  .turnin 4261 >>Turn in Ancient Spirit
step << Mage
  .isOnQuest 82114
  .goto Azshara,29.6,40.6
  .target Archmage Xylem
  >>Talk to |cRXP_FRIENDLY_Archmage Xylem|r in Azshara
  .turnin 82114 >>Turn in Destroy Morphaz
step
  .hs >>Hearth to Gadgetzen
step
  .itemcount 12207,12
  .itemcount 7974,10
  .itemcount 8932,20
  .goto Tanaris,52.6,28.0
  .target Dirge Quikcleave
  >>Talk to |cRXP_FRIENDLY_Dirge Quikcleave|r in Gadgetzan
  .accept 6610 >>Accept Clamlette Surprise
  .turnin 6610 >>Turn in Clamlette Surprise
step
  .isOnQuest 2768
  .goto Tanaris,52.4,28.4
  .target Chief Engineer Bilgewhizzle
  >>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r in Gadgetzan
  .turnin 2768 >>Turn in Divino-matic Rod
step << Paladin/Warrior
  .isQuestTurnedIn 2760
  .itemcount 7931,2
  .itemcount 7928,1
  .goto Tanaris,51.4,28.6
  .target Trenton Lighthammer
  >>Talk to |cRXP_FRIENDLY_Trenton Lighthammer|r in Gadgetzan
  .accept 2771 >>Accept A Good Head On Your Shoulders
  .turnin 2771 >>Turn in A Good Head On Your Shoulders
step
  .isQuestTurnedIn 2760
  .itemcount 7930,2
  .itemcount 7927,1
  .goto Tanaris,51.4,28.6
  .target Trenton Lighthammer
  >>Talk to |cRXP_FRIENDLY_Trenton Lighthammer|r in Gadgetzan
  .accept 2773 >>Accept The Mithril Kid
  .turnin 2773 >>Turn in The Mithril Kid
step
  .isQuestTurnedIn 2760
  .itemcount 7933,2
  .itemcount 7926,1
  .goto Tanaris,51.4,28.6
  .target Trenton Lighthammer
  >>Talk to |cRXP_FRIENDLY_Trenton Lighthammer|r in Gadgetzan
  .accept 2772 >>Accept The World At Your Feet
  .turnin 2772 >>Turn in The World At Your Feet
step << Paladin/Warrior/Rogue
  .isQuestTurnedIn 2760
  .itemcount 7931,2
  .itemcount 7928,1
  .goto Tanaris,51.4,28.6
  .target Trenton Lighthammer
  >>Talk to |cRXP_FRIENDLY_Trenton Lighthammer|r in Gadgetzan
  .accept 3321 >>Accept Did You Lose This?
  .turnin 3321 >>Turn in Did You Lose This?
step
  .isQuestTurnedIn 4507
  .goto Tanaris,50.8,27.0
  .target Alchemist Pestlezugg
  >>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r in Gadgetzan
  .accept 4508 >>Accept Calm Before the Storm
step
  .isOnQuest 2770
  .goto Thousand Needles,78.0,77.0
  .target Wizzle Brassbolts
  >>Talk to |cRXP_FRIENDLY_Wizzle Brassbolts|r in The Shimmering Flats
  .turnin 2770 >>Turn in Gahz'rilla
step
  .itemcount 9250,1
  >>Use the Ship Schedule to Accept the quest
  .use 9250
  .accept 2876 >>Accept Ship Schedules
  .goto Tanaris,67.0,23.8
step
  .isOnQuest 2876
  .goto Tanaris,67.0,23.8
  .target Security Chief Bilgewhizzle
  >>Talk to |cRXP_FRIENDLY_Security Chief Bilgewhizzle|r in Steamwheedle Port
  .turnin 2876 >>Turn in Ship Schedules
step
  .isOnQuest 5065
  .goto Tanaris,66.8,24.0
  .target Prospector Ironboot
  >>Talk to |cRXP_FRIENDLY_Prospector Ironboot|r in Steamweedle Port
  .turnin 5065 >>Turn in The Lost Tablets of Mosh'aru
step
  .fly Marshal's Refuge >>Fly to Marshal's Refuge, Un'Goro Crater
step
  .isOnQuest 4005
  .goto Un'Goro Crater,41.8,2.6
  .target J.D. Collie
  >>Talk to |cRXP_FRIENDLY_J.D. Collie|r in the cave at Marshal's Refuge
  .turnin 4005 >>Turn in Aquementas
step
  .isQuestTurnedIn 4005
  .goto Un'Goro Crater,41.8,2.6
  .target J.D. Collie
  >>Talk to |cRXP_FRIENDLY_J.D. Collie|r in the cave at Marshal's Refuge
  .accept 3961 >>Accept Linken's Adventure
step
  .itemcount 11186,7
  .goto Un'Goro Crater,41.8,2.6
  .target J.D. Collie
  >>Talk to |cRXP_FRIENDLY_J.D. Collie|r in the cave at Marshal's Refuge
  .accept 4284 >>Accept Crystals of Power
  .turnin 4284 >>Turn in Crystals of Power
step
  .isOnQuest 3961
  .goto Un'Goro Crater,44.6,8.2
  .target Linken
  >>Talk to |cRXP_FRIENDLY_Linken|r at Marshal's Refuge
  .turnin 3961 >>Turn in Linken's Adventure
step
  .itemcount 11116,1
  >>Use the A Mangled Journal to Accept the quest
  .use 11116
  .accept 3884 >>Accept Williden's Journal
  .goto Un'Goro Crater,43.8,7.2
step
  .isOnQuest 3884
  .goto Un'Goro Crater,43.8,7.2
  .target Williden Marshal
  >>Talk to |cRXP_FRIENDLY_Williden Marshal|r at Marshal's Refuge
  .turnin 3884 >>Turn in Williden's Journal
step
  .isOnQuest 4501
  .goto Un'Goro Crater,43.6,8.6
  .target Spraggle Frock
  >>Talk to |cRXP_FRIENDLY_Spraggle Frock|r at Marshal's Refuge
  .turnin 4501 >>Turn in Beware of Pterrordax
step
  .isOnQuest 4491
  .goto Un'Goro Crater,43.6,8.6
  .target Spraggle Frock
  >>Talk to |cRXP_FRIENDLY_Spraggle Frock|r at Marshal's Refuge
  .turnin 4491 >>Turn in A Little Help From My Friends
step
  .isOnQuest 4245
  .goto Un'Goro Crater,46.6,13.4
  .target Karna Remtravel
  >>Talk to |cRXP_FRIENDLY_Karna Remtravel|r at Marshal's Refuge
  .turnin 4245 >>Turn in Chasing A-Me 01
step
  .isQuestTurnedIn 2847
  .fly Feathermoon Stronghold >>Fly to Feathermoon Stronghold, Feralas if you are turning in Leatherworking quests
step
  .isQuestTurnedIn 2847
  .itemcount 8193,2
  .itemcount 8197,2
  .itemcount 8153,2
  .goto Feralas,30.6,42.6
  .target Pratt McGrubben
  >>Talk to |cRXP_FRIENDLY_Pratt McGrubben|r in Feathermoon Stronghold
  .accept 2851 >>Accept Wild Leather Boots
  .turnin 2851 >>Turn in Wild Leather Boots
step
  .isQuestTurnedIn 2847
  .itemcount 8175,2
  .itemcount 8176,2
  .itemcount 8153,1
  .goto Feralas,30.6,42.6
  .target Pratt McGrubben
  >>Talk to |cRXP_FRIENDLY_Pratt McGrubben|r in Feathermoon Stronghold
  .accept 2850 >>Accept Wild Leather Helmet
  .turnin 2850 >>Turn in Wild Leather Helmet
step
  .isQuestTurnedIn 2847
  .itemcount 8191,2
  .itemcount 8198,2
  .itemcount 8153,2
  .goto Feralas,30.6,42.6
  .target Pratt McGrubben
  >>Talk to |cRXP_FRIENDLY_Pratt McGrubben|r in Feathermoon Stronghold
  .accept 2852 >>Accept Wild Leather Leggings
  .turnin 2852 >>Turn in Wild Leather Leggings
step
  .isQuestTurnedIn 2847
  .itemcount 8173,6
  .itemcount 8153,1
  .goto Feralas,30.6,42.6
  .target Pratt McGrubben
  >>Talk to |cRXP_FRIENDLY_Pratt McGrubben|r in Feathermoon Stronghold
  .accept 2848 >>Accept Wild Leather Shoulders
  .turnin 2848 >>Turn in Wild Leather Shoulders
step
  .isQuestTurnedIn 2847
  .itemcount 8189,2
  .itemcount 8187,2
  .itemcount 8153,1
  .goto Feralas,30.6,42.6
  .target Pratt McGrubben
  >>Talk to |cRXP_FRIENDLY_Pratt McGrubben|r in Feathermoon Stronghold
  .accept 2849 >>Accept Wild Leather Vest
  .turnin 2849 >>Turn in Wild Leather Vest
step
  .isQuestTurnedIn 2848
  .isQuestTurnedIn 2849
  .isQuestTurnedIn 2850
  .isQuestTurnedIn 2851
  .isQuestTurnedIn 2852
  .goto Feralas,30.6,42.6
  .target Pratt McGrubben
  >>Talk to |cRXP_FRIENDLY_Pratt McGrubben|r in Feathermoon Stronghold
  .accept 2853 >>Accept Master of the Wild Leather
step << Mage
  .zone Ironforge >>Teleport to Ironforge
step << !Mage
  .fly Theramore
step << !Mage
  .zone Wetlands >>Take the boat to Menthil Harbor
step
  .isOnQuest 5206
  .fly Light's Hope Chapel >>Fly to Light's Hope Chapel, Eastern Plaguelands
step
  .isOnQuest 5206
  .goto Eastern Plaguelands,81.4,59.8
  .target Carlin Redpath
  >>Talk to |cRXP_FRIENDLY_Carlin Redpath|r in Eastern Plaguelands
  .turnin 5206 >>Turn in Marauders of Darrowshire
step
  .isOnQuest 211
  .fly Chillwind Camp >>Fly to Chillwind Camp, Western Plaguelands
step
  .isOnQuest 5225
  .goto Western Plaguelands,62.5,58.6
  .target Scourge Cauldron
  >>Click the |cRXP_FRIENDLY_Scourge Cauldron|r in Western Plaguelands
  .turnin 5225 >>Turn in Target: Gahrron's Withering
step
  .isOnQuest 211
  .goto Western Plaguelands,42.8,84.0
  .target Commander Ashlam Valorfist
  >>Talk to |cRXP_FRIENDLY_Commander Ashlam Valorfist|r at Chillwind Camp
  .turnin 211 >>Turn in Alas, Andorhal
step
  .isOnQuest 2994
  .fly Aerie Peak >>Aerie Peak, The Hinterlands
step
  .isOnQuest 2994
  .goto The Hinterlands,9.8,44.6
  .target Gryphon Master Talonaxe
  >>Talk to |cRXP_FRIENDLY_Gryphon Master Talonaxe|r at Aerie Peak
  .turnin 2994 >>Turn in Saving Sharpbeak
step
  .isOnQuest 2994
  .fly Refuge Point >>Refuge Point, Arathi Highlands
step
  .isOnQuest 656
  .goto Arathi Highlands,62.5,33.8
  .target Shards of Myzrael
  >>Click the |cRXP_FRIENDLY_Shards of Myzrael|r in Arathi Highlands
  .turnin 656 >>Turn in Summoning the Princess
step << Mage
  .zone Ironforge >>Teleport to Ironforge
step << !Mage
  .fly Ironforge
step
  .isOnQuest 3566
  .goto Ironforge,72.8,16.8
  .target Curator Thorius
  >>Talk to |cRXP_FRIENDLY_Curator Thorius|r in Ironforge
  .turnin 3566 >>Turn in Rise, Obsidion!
step
  .isOnQuest 4513
  .goto Ironforge,75.6,23.6
  .target Laris Geardawdle
  >>Talk to |cRXP_FRIENDLY_Laris Geardawdle|r in Ironforge
  .turnin 4513 >>Turn in A Little Slime Goes a Long Way
step
  .goto Ironforge,73.8,47.8
  .target Bubulo Acerbus
  >>Talk to |cRXP_FRIENDLY_Bubulo Acerbus|r in Tinker Town
  .turnin 7807 >>Turn in A Donation of Wool
  .turnin 7808 >>Turn in A Donation of Silk
  .turnin 7809 >>Turn in A Donation of Mageweave
  .turnin 7811 >>Turn in A Donation of Runecloth
step
  .isOnQuest 3461
  .goto Ironforge,31.2,4.6
  .target Tymor
  >>Talk to |cRXP_FRIENDLY_Tymor|r in the Mystic Ward
  .turnin 3461 >>Turn in Return to Tymor
step
  .goto Ironforge,43.6,33.2
  .target Mistina Steelshield
  >>Talk to |cRXP_FRIENDLY_Mistina Steelshield|r in Ironforge
  .turnin 7802 >>Turn in A Donation of Wool
  .turnin 7803 >>Turn in A Donation of Silk
  .turnin 7804 >>Turn in A Donation of Mageweave
  .turnin 7805 >>Turn in A Donation of Runecloth
step
  .isQuestTurnedIn 3701
  .goto Ironforge,40.0,55.2
  .target King Magni Bronzebeard
  >>Talk to |cRXP_FRIENDLY_King Magni Bronzebeard|r in Ironforge
  .accept 4341 >>Accept Kharan Mighthammer
step
  .isOnQuest 4126
  .goto Dun Morogh,46.8,52.4
  .target Ragnar Thunderbrew
  >>Talk to |cRXP_FRIENDLY_Ragnar Thunderbrew|r at Kharanos
  .turnin 4126 >>Turn in Hurley Blackbreath
step
  .fly Thorium Point
step
  .itemcount 11818,1
  >>Use the Grimesilt Outhouse Key to Accept the quest
  .use 11818
  .accept 4451 >>Accept The Key to Freedom
  .goto Searing Gorge,65.6,62.5
step
  .isOnQuest 4451
  .goto Searing Gorge,65.6,62.5
  .target Wooden Outhouse
  >>Click the |cRXP_FRIENDLY_Wooden Outhouse|r in Searing Gorge
  .turnin 4451 >>Turn in The Key to Freedom
step
  .isOnQuest 3463
  .goto Searing Gorge,39.0,39.0
  .target Squire Maltrake
  >>Talk to |cRXP_FRIENDLY_Squire Maltrake|r 
  .turnin 3463 >>Turn in Set Them Ablaze!
step
  .isQuestTurnedIn 3463
  .goto Searing Gorge,39.0,38.9
  .target Hoard of the Black Dragonflight Chest
  >>Click the |cRXP_FRIENDLY_Hoard of the Black Dragonflight Chest|r in Searing Gorge
  .accept 3481 >>Accept Trinkets...
  .turnin 3481 >>Turn in Trinkets...
step
  .fly Morgan's Vigil
step
  .isOnQuest 4182
  .goto Burning Steppes,85.6,69.0
  .target Helendis Riverhorn
  >>Talk to |cRXP_FRIENDLY_Helendis Riverhorn|r at Morgan's Vigil
  .turnin 4182 >>Turn in Dragonkin Menace
step
  .isQuestTurnedIn 4182
  .goto Burning Steppes,85.6,69.0
  .target Helendis Riverhorn
  >>Talk to |cRXP_FRIENDLY_Helendis Riverhorn|r at Morgan's Vigil
  .accept 4183 >>Accept The True Masters
step
  .isOnQuest 4262
  .goto Burning Steppes,85.4,70.0
  .target Jalinda Sprig
  >>Talk to |cRXP_FRIENDLY_Jalinda Sprig|r at Morgan's Vigil
  .turnin 4262 >>Turn in Overmaster Pyron
step
  .fly Lakeshire
step
  .isOnQuest 4183
  .goto Redridge Mountains,30.0,44.2
  .target Magistrate Solomon
  >>Talk to |cRXP_FRIENDLY_Magistrate Solomon|r in Lakeshire
  .turnin 4183 >>Turn in The True Masters
step
  .isQuestTurnedIn 4183
  .goto Redridge Mountains,30.0,44.2
  .target Magistrate Solomon
  >>Talk to |cRXP_FRIENDLY_Magistrate Solomon|r in Lakeshire
  .accept 4184 >>Accept The True Masters
step << Mage
  .zone Stormwind City >>Teleport to Stormwind
step << !Mage
  .fly Stormwind City
step
  .isOnQuest 4184
  .goto Stormwind City,78.0,18.0
  .target Highlord Bolvar Fordragon
  >>Talk to |cRXP_FRIENDLY_Highlord Bolvar Fordragon|r in Stormwind
  .turnin 4184 >>Turn in The True Masters
step
  .isQuestTurnedIn 4184
  .goto Stormwind City,78.0,18.0
  .target Highlord Bolvar Fordragon
  >>Talk to |cRXP_FRIENDLY_Highlord Bolvar Fordragon|r in Stormwind
  .accept 4185 >>Accept The True Masters
step
  .isOnQuest 4185
  .goto Stormwind City,78.0,17.8
  .target Lady Katrana Prestor
  >>Speak with |cRXP_FRIENDLY_Lady Katrana Prestor|r in Stormwind
  .complete 4185,1 >>The True Masters
step
  .isOnQuest 4185
  .goto Stormwind City,78.0,18.0
  .target Highlord Bolvar Fordragon
  >>Talk to |cRXP_FRIENDLY_Highlord Bolvar Fordragon|r in Stormwind
  .turnin 4185 >>Turn in The True Masters
step
  .isQuestTurnedIn 4185
  .goto Stormwind City,78.0,18.0
  .target Highlord Bolvar Fordragon
  >>Talk to |cRXP_FRIENDLY_Highlord Bolvar Fordragon|r in Stormwind
  .accept 4186 >>Accept The True Masters
step
  .isOnQuest 82098
  .goto Stormwind City,64.2,20.8
  .target Brohann Caskbelly
  >>Talk to |cRXP_FRIENDLY_Brohann Caskbelly|r in The Dwarven District
  .turnin 82098 >>Turn in Into the Temple of Atal'Hakkar
step
  .goto Stormwind City,37.6,81.6
  .target High Sorcerer Andromath
  >>Talk to |cRXP_FRIENDLY_High Sorcerer Andromath|r at The Mage Quarter in Stormwind City
  .accept 1477 >>Accept Vital Supplies
step
  .goto Stormwind City,44.2,73.6
  .target Clavicus Knavingham
  >>Talk to |cRXP_FRIENDLY_Clavicus Knavingham|r in Stormwind
  .turnin 7791 >>Turn in A Donation of Wool
  .turnin 7793 >>Turn in A Donation of Silk
  .turnin 7794 >>Turn in A Donation of Mageweave
  .turnin 7795 >>Turn in A Donation of Runecloth
step
  .fly Booty Bay
step
  .isOnQuest 836
  .goto Stranglethorn Vale,28.2,76.2
  .target Oglethorpe Obnoticus
  >>Talk to |cRXP_FRIENDLY_Oglethorpe Obnoticus|r in Booty Bay
  .turnin 836 >>Turn in Rescue OOX-09/HL!
step
  .isOnQuest 648
  .goto Stranglethorn Vale,28.2,76.2
  .target Oglethorpe Obnoticus
  >>Talk to |cRXP_FRIENDLY_Oglethorpe Obnoticus|r in Booty Bay
  .turnin 648 >>Turn in Rescue OOX-17/TN!
step
  .isOnQuest 2767
  .goto Stranglethorn Vale,28.2,76.2
  .target Oglethorpe Obnoticus
  >>Talk to |cRXP_FRIENDLY_Oglethorpe Obnoticus|r in Booty Bay
  .turnin 2767 >>Turn in Rescue OOX-22/FE!
step
  .isQuestTurnedIn 648
  .isQuestTurnedIn 836
  .isQuestTurnedIn 2767
  .goto Stranglethorn Vale,28.2,76.2
  .target Oglethorpe Obnoticus
  >>Talk to |cRXP_FRIENDLY_Oglethorpe Obnoticus|r in Booty Bay
  .accept 3721 >>Accept An OOX of Your Own
  .turnin 3721 >>Turn in An OOX of Your Own
step
  .itemcount 3985,1
  >>Use the Monogrammed Sash to Accept the quest
  .use 3985
  .accept 8552 >>Accept The Monogrammed Sash
  .goto Stranglethorn Vale,26.6,73.6
step
  .isOnQuest 8552
  .goto Stranglethorn Vale,26.6,73.6
  .target Captain Hecklebury Smotts
  >>Talk to |cRXP_FRIENDLY_Captain Hecklebury Smotts|r in Booty Bay
  .turnin 8552 >>Turn in The Monogrammed Sash
step
  .isQuestTurnedIn 8552
  .goto Stranglethorn Vale,26.6,73.6
  .target Captain Hecklebury Smotts
  >>Talk to |cRXP_FRIENDLY_Captain Hecklebury Smotts|r in Booty Bay
  .accept 8553 >>Accept The Captain's Cutlass
step
  .isOnQuest 8553
  .goto Stranglethorn Vale,26.6,73.6
  .target Sprogger
  >>Talk to |cRXP_FRIENDLY_Sprogger|r in Booty Bay
  .turnin 8553 >>Turn in The Captain's Cutlass
step
  .fly Darkshire
step
  .isOnQuest 1477
  .goto Duskwood,75.8,46.2
  .target Watchmaster Sorigal
  >>Talk to |cRXP_FRIENDLY_Watchmaster Sorigal|r in Darkshire
  .turnin 1477 >>Turn in Vital Supplies
step
  .isQuestTurnedIn 1477
  .goto Duskwood,75.8,46.2
  .target Watchmaster Sorigal
  >>Talk to |cRXP_FRIENDLY_Watchmaster Sorigal|r in Darkshire
  .accept 1395 >>Accept Supplies for Nethergarde
step
  .fly Nethergarde Keep
step
  .itemcount 10593,1
  .goto Blasted Lands,51.8,35.6
  .target Kum'isha the Collector
  >>Talk to |cRXP_FRIENDLY_Kum'isha the Collector|r in the Blasted Lands
  .accept 3501 >>Accept Everything Counts In Large Amounts
  .turnin 3501 >>Turn in Everything Counts In Large Amounts
step
  .isOnQuest 3501
  .goto Blasted Lands,51.8,35.6
  .target Kum'isha the Collector
  >>Talk to |cRXP_FRIENDLY_Kum'isha the Collector|r in the Blasted Lands
  .turnin 3501 >>Turn in Everything Counts In Large Amounts
step
  .itemcount 8244,1
  .goto Blasted Lands,51.8,35.6
  .target Kum'isha the Collector
  >>Talk to |cRXP_FRIENDLY_Kum'isha the Collector|r in the Blasted Lands
  .accept 2521 >>Accept To Serve Kum'isha
  .turnin 2521 >>Turn in To Serve Kum'isha
step
  .isOnQuest 2521
  .goto Blasted Lands,51.8,35.6
  .target Kum'isha the Collector
  >>Talk to |cRXP_FRIENDLY_Kum'isha the Collector|r in the Blasted Lands
  .turnin 2521 >>Turn in To Serve Kum'isha
step
  .itemcount 8391,3
  .itemcount 8392,2
  .itemcount 8393,1
  .goto Blasted Lands,50.6,14.2
  .target Bloodmage Drazial
  >>Talk to |cRXP_FRIENDLY_Bloodmage Drazial|r in the Blasted Lands
  .accept 2581 >>Accept Snickerfang Jowls
  .turnin 2581 >>Turn in Snickerfang Jowls
step
  .itemcount 8393,3
  .itemcount 8396,2
  .itemcount 8392,1
  .goto Blasted Lands,50.6,14.2
  .target Bloodmage Drazial
  >>Talk to |cRXP_FRIENDLY_Bloodmage Drazial|r in the Blasted Lands
  .accept 2585 >>Accept The Decisive Striker
  .turnin 2585 >>Turn in The Decisive Striker
step
  .itemcount 8392,3
  .itemcount 8393,2
  .itemcount 8394,1
  .goto Blasted Lands,50.6,14.2
  .target Bloodmage Drazial
  >>Talk to |cRXP_FRIENDLY_Bloodmage Drazial|r in the Blasted Lands
  .accept 2583 >>Accept A Boar's Vitality
  .turnin 2583 >>Turn in A Boar's Vitality
step
  .itemcount 8394,10
  .itemcount 8396,2
  .goto Blasted Lands,50.6,14.2
  .target Bloodmage Lynnore
  >>Talk to |cRXP_FRIENDLY_Bloodmage Lynnore|r in the Blasted Lands
  .accept 2601 >>Accept The Basilisk's Bite
  .turnin 2601 >>Turn in The Basilisk's Bite
step
  .itemcount 8396,10
  .itemcount 8391,2
  .goto Blasted Lands,50.6,14.2
  .target Bloodmage Lynnore
  >>Talk to |cRXP_FRIENDLY_Bloodmage Lynnore|r in the Blasted Lands
  .accept 2603 >>Accept Vulture's Vigor
  .turnin 2603 >>Turn in Vulture's Vigor
step << Warrior
  .isOnQuest 82107
  .goto Swamp of Sorrows,34.2,66.0
  .target Fallen Hero of the Horde
  >>Talk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r in the Swamp of Sorrows
  .turnin 82107 >>Turn in Voodoo Feathers
step
  .isOnQuest 2681
  .goto Swamp of Sorrows,34.2,66.0
  .target Fallen Hero of the Horde
  >>Talk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r in the Swamp of Sorrows
  .turnin 2681 >>Turn in The Stones that Bind Us
step
  .isQuestTurnedIn 2681
  .goto Swamp of Sorrows,34.2,66.0
  .target Fallen Hero of the Horde
  >>Talk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r in the Swamp of Sorrows
  .accept 2702 >>Accept Heroes of Old
step
  .isOnQuest 2702
  .goto Swamp of Sorrows,33.6,66.0
  .target Corporal Thund Splithoof
  >>Talk to |cRXP_FRIENDLY_Corporal Thund Splithoof|r in the Swamp of Sorrows
  .turnin 2702 >>Turn in Heroes of Old
step
  .isQuestTurnedIn 2702
  .goto Swamp of Sorrows,33.6,66.0
  .target Corporal Thund Splithoof
  >>Talk to |cRXP_FRIENDLY_Corporal Thund Splithoof|r in the Swamp of Sorrows
  .accept 2701 >>Accept Heroes of Old
step
  .isOnQuest 2701
  .goto Swamp of Sorrows,33.5,66.0
  .target Spectral Lockbox
  >>Click the |cRXP_FRIENDLY_Spectral Lockbox|r in the Swamp of Sorrows
  .turnin 2701 >>Turn in Heroes of Old
step
  .isOnQuest 1395
  .goto Blasted Lands,66.4,21.6
  .target Quartermaster Lungertz
  >>Talk to |cRXP_FRIENDLY_Quartermaster Lungertz|r at Nethergarde Keep
  .turnin 1395 >>Turn in Supplies for Nethergarde
step
  .fly Redridge Mountains
step
  .isOnQuest 4186
  .goto Redridge Mountains,30.0,44.2
  .target Magistrate Solomon
  >>Talk to |cRXP_FRIENDLY_Magistrate Solomon|r in Lakeshire
  .turnin 4186 >>Turn in The True Masters
step
  .isQuestTurnedIn 4186
  .goto Redridge Mountains,30.0,44.2
  .target Magistrate Solomon
  >>Talk to |cRXP_FRIENDLY_Magistrate Solomon|r in Lakeshire
  .accept 4223 >>Accept The True Masters
step
  .fly Morgan's Vigil
step
  .isOnQuest 4223
  .goto Burning Steppes,84.6,68.8
  .target Marshal Maxwell
  >>Talk to |cRXP_FRIENDLY_Marshal Maxwell|r at Morgan's Vigil
  .turnin 4223 >>Turn in The True Masters
step
  .isQuestTurnedIn 4223
  .goto Burning Steppes,84.6,68.8
  .target Marshal Maxwell
  >>Talk to |cRXP_FRIENDLY_Marshal Maxwell|r at Morgan's Vigil
  .accept 4224 >>Accept The True Masters
step
  .isOnQuest 4224
  .goto Burning Steppes,84.6,68.8
  .target Marshal Maxwell
  >>Talk to |cRXP_FRIENDLY_Marshal Maxwell|r at Morgan's Vigil
  .turnin 4224 >>Turn in The True Masters
step
  .isQuestTurnedIn 4224
  .goto Burning Steppes,84.6,68.8
  .target Marshal Maxwell
  >>Talk to |cRXP_FRIENDLY_Marshal Maxwell|r at Morgan's Vigil
  .accept 4241 >>Accept Marshal Windsor

step
  +CONGRATULATIONS!!! You have completed this route.
]])