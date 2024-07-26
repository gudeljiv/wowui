RXPGuides.RegisterGuide([[
#classic
#version 1
<< Horde
#group Custom Quests for RXP
#subgroup SoD Level 50 Quest Stacking
#name 50-1-How to Use this Guide
#displayname 1-How to Use this Guide
#next 50-2-Pre-Launch Collection Guide

step
  >>Welcome to the |cRXP_WARN_SoD Level 50|r Quest Stacking Guide!
  +Use the Collection Guide to complete pre-req quests and gather items for launch day.
  +|cRXP_WARN_ON LAUNCH DAY|r, use the Turn-in Guide.
]])

RXPGuides.RegisterGuide([[
#classic
#version 3
<< Horde
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
  >>|cRXP_WARN_LEVEL 50 HORDE QUEST STACK|r
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

-- SWAMP OF SORROWS #1 --
step
  .goto Swamp of Sorrows,34.2,66.0
  .target Fallen Hero of the Horde
  >>Talk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r in the Swamp of Sorrows
  .accept 2784 >>Accept Fall From Grace
step
  .goto Swamp of Sorrows,34.2,66.0
  .target Fallen Hero of the Horde
  .skipgossip
  >>Listen to the |cRXP_FRIENDLY_Fallen Hero of the Horde's|r tale in Swamp of Sorrows
  .complete 2784,1 >>Fall From Grace
step
  .goto Swamp of Sorrows,34.2,66.0
  .target Fallen Hero of the Horde
  >>Talk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r in the Swamp of Sorrows
  .turnin 2784 >>Turn in Fall From Grace
  .accept 2621 >>Accept The Disgraced One
step
  .goto Swamp of Sorrows,47.8,55.0
  .target Dispatch Commander Ruag
  >>Talk to |cRXP_FRIENDLY_Dispatch Commander Ruag|r in Stonard
  .turnin 2621 >>Turn in The Disgraced One
  .accept 2622 >>Accept The Missing Orders
step
  .goto Swamp of Sorrows,45.0,57.2
  .target Bengor
  >>Talk to |cRXP_FRIENDLY_Bengor|r in Stonard
  .turnin 2622 >>Turn in The Missing Orders
  .accept 2623 >>Accept The Swamp Talker
step
  .goto Swamp of Sorrows,62.8,88.2
  >>Kill |cRXP_ENEMY_Swamp Talker|r in the Swamp of Sorrows for the |cRXP_LOOT_Warchief's Orders|r
  .complete 2623,1 >>The Swamp Talker
  .unitscan Swamp Talker
step
  .goto Swamp of Sorrows,34.2,66.0
  .target Fallen Hero of the Horde
  >>Talk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r in the Swamp of Sorrows
  .turnin 2623 >>Turn in The Swamp Talker
  .accept 2801 >>Accept A Tale of Sorrow
step
  .goto Swamp of Sorrows,34.2,66.0
  .target Fallen Hero of the Horde
  .skipgossip
  >>Listen to the |cRXP_FRIENDLY_Fallen Hero of the Horde's|r tale in Swamp of Sorrows
  .complete 2801,1 >>A Tale of Sorrow
  .turnin 2801 >>Turn in A Tale of Sorrow
  .accept 2681 >>Accept The Stones that Bind Us

-- BLASTED LANDS #1 --
step
  #completewith blasted1
  >>Kill |cRXP_ENEMY_Mobs|r in Blasted Lands for the following items:
  .collect 10593,1,3501,1 -- Everything Counts In Large Amounts
  .collect 8391,5,2581,1 -- Snickerfang Jowls + Vulture's Vigor
  .collect 8393,6,2585,1 -- The Decisive Striker + Snickerfang Jowls + A Boar's Vitality
  .collect 8392,6,2583,1 -- A Boar's Vitality
  .collect 8394,11,2601,1 -- The Basilisk's Bite + A Boar's Vitality
  .collect 8396,14,2603,1 -- Vulture's Vigor + The Basilisk's Bite + The Decisive Striker
  >>|cRXP_WARN_SAVE THESE ITEMS FOR LAUNCH DAY TURN-IN|r
step
  .goto Blasted Lands,58.0,49.8
  >>Attack a |cRXP_ENEMY_Servant of Razelikh|r near a Stone of Binding.
  >>When the Servant's health is low enough, click the Stone of Binding.
  .complete 2681,1 >>The Stones that Bind Us
  .mob Servant of Razelikh
step
  .goto Blasted Lands,41.8,14.6
  >>Attack a |cRXP_ENEMY_Servant of Grol|r near a Stone of Binding.
  >>When the Servant's health is low enough, click the Stone of Binding.
  .complete 2681,2 >>The Stones that Bind Us
  .mob Servant of Grol
step
  .goto Blasted Lands,64.6,47.6
  >>Attack a |cRXP_ENEMY_Servant of Allistarj|r near a Stone of Binding.
  >>When the Servant's health is low enough, click the Stone of Binding.
  .complete 2681,3 >>The Stones that Bind Us
  .mob Servant of Allistarj
step
  .goto Blasted Lands,38.0,33.4
  >>Attack a |cRXP_ENEMY_Servant of Sevine|r near a Stone of Binding.
  >>When the Servant's health is low enough, click the Stone of Binding.
  .complete 2681,4 >>The Stones that Bind Us
  .mob Servant of Sevine
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  #label blasted1
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

-- BADLANDS #1 --
step
  .goto Badlands,3.6,48.0
  .target Thunderheart
  >>Talk to |cRXP_FRIENDLY_Thunderheart|r at Kargath in the Badlands
  .accept 3906 >>Accept Disharmony of Flame

-- SEARING GORGE #1 --
step
  #completewith searing1
  >>Kill |cRXP_ENEMY_Dark Iron mobs|r in Searing Gorge for the |cRXP_LOOT_Grimesilt Outhouse Key|r
  .collect 11818,1,4451,1 -- The Key to Freedom
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  .goto Searing Gorge,39.0,39.0
  .target Velarok Windblade
  >>Talk to |cRXP_FRIENDLY_Velarok Windblade|r in Searing Gorge
  .accept 3441 >>Accept Divine Retribution
step
  .skipgossip
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
  >>Kill |cRXP_ENEMY_Elementals|r in Searing Gorge for |cRXP_LOOT_Hearts of Flame|r
  .complete 3442,1 >>The Flawless Flame
  .mob Inferno Elemental
  .mob Magma Elemental
  .mob Blazing Elemental
step
  >>Kill |cRXP_ENEMY_Golems|r in Searing Gorge for |cRXP_LOOT_Golem Oil|r
  .complete 3442,2 >>The Flawless Flame
  .mob Heavy War Golem
  .mob Tempered War Golem
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
  .complete 3906,1 >>Disharmony of Flame
  .unitscan Overmaster Pyron

-- BADLANDS #2 --
step
  .goto Badlands,3.6,48.0
  .target Thunderheart
  >>Talk to |cRXP_FRIENDLY_Thunderheart|r in Kargath
  .turnin 3906 >>Turn in Disharmony of Flame
  .accept 3907 >>Accept Disharmony of Fire

-- BLACKROCK MOUNTAIN #2 --
step
  >>Head to Blackrock Depths
  >>Kill |cRXP_ENEMY_Lord Incendius|r for the |cRXP_LOOT_Tablet of Kurniya|r
  .complete 3907,1 >>Disharmony of Fire
  .mob Lord Incendius
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- UNDERCITY #1 --
step
  .target Harbinger Balthazad
  >>Talk to |cRXP_FRIENDLY_Harbinger Balthazad|r in Undercity. He patrols around the city center.
  .accept 5094 >>Accept A Call to Arms: The Plaguelands!
  >>|cRXP_WARN_NOTE|r: This quest can also be picked up in Orgrimmar or Thunder Bluff.
step
  .goto Undercity,47.6,73.0
  .target Chemist Fuely
  >>Talk to |cRXP_FRIENDLY_Chemist Fuely|r in The Apothecarium
  .accept 4294 >>Accept ... and a Batch of Ooze
  .accept 4293 >>Accept A Sample of Slime...

-- TIRISFAL GLADES #1 --
step
  .goto Tirisfal Glades,83.0,69.0
  .target High Executor Derrington
  >>Talk to |cRXP_FRIENDLY_High Executor Derrington|r in Tirisfal Glades
  .turnin 5094 >>Turn in A Call to Arms: The Plaguelands!
  .accept 5096 >>Accept Scarlet Diversions
  .accept 5098 >>Accept All Along the Watchtowers
step
  .goto Tirisfal Glades,83.1,69.1
  >>Click the |cRXP_PICK_Box of Incendiaries|r next to High Executor Derrington for the |cRXP_LOOT_Flame in a Bottle|r
  .collect 12814,1,5096,1 >>Scarlet Diversions

-- WESTERN PLAGUELANDS #1 --
step
  .goto Western Plaguelands,39,71
  .use 12815
  >>Use the |cRXP_PICK_Beacon Torch|r to mark Tower One in Western Plaguelands
  .complete 5098,1 >>All Along the Watchtowers
step
  .goto Western Plaguelands,42,65
  .use 12815
  >>Use the |cRXP_PICK_Beacon Torch|r to mark Tower Two in Western Plaguelands
  .complete 5098,2 >>All Along the Watchtowers
step
  .goto Western Plaguelands,44,63
  .use 12815
  >>Use the |cRXP_PICK_Beacon Torch|r to mark Tower Three in Western Plaguelands
  .complete 5098,3 >>All Along the Watchtowers
step
  .goto Western Plaguelands,46,70
  .use 12815
  >>Use the |cRXP_PICK_Beacon Torch|r to mark Tower Four in Western Plaguelands
  .complete 5098,4 >>All Along the Watchtowers
step
  .goto Western Plaguelands,40.76,51.81
  .use 12814
  .use 12807
  >>Burn the tent and Plant the |cRXP_PICK_Scourge Banner|r at the Scarlet Crusade's base camp in Western Plaguelands
  .complete 5096,1 >>Scarlet Diversions

-- TIRISFAL GLADES #2 --
step
  .goto Tirisfal Glades,83.0,69.0
  .target High Executor Derrington
  >>Talk to |cRXP_FRIENDLY_High Executor Derrington|r in Tirisfal Glades
  .turnin 5096 >>Turn in Scarlet Diversions
  .turnin 5098 >>Turn in All Along the Watchtowers
  .accept 5228 >>Accept The Scourge Cauldrons
  .accept 105 >>Accept Alas, Andorhal
step
  .goto Tirisfal Glades,83.0,71.8
  .target Shadow Priestess Vandis
  >>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r in Tirisfal Glades
  .turnin 5228 >>Turn in The Scourge Cauldrons
  .accept 5229 >>Accept Target: Felstone Field

-- WESTERN PLAGUELANDS #2 --
step
  .goto Western Plaguelands,49.2,78.4
  .target Marlene Redpath
  >>Talk to |cRXP_FRIENDLY_Marlene Redpath|r in Western Plaguelands
  .accept 5142 >>Accept Little Pamela
step
  .goto Western Plaguelands,45.6,69.2
  >>Kill |cRXP_ENEMY_Araj the Summoner|r in Western Plaguelands for the |cRXP_LOOT_Araj's Phylactery Shard|r
  .complete 105,1 >>Alas, Andorhal
  .mob Araj the Summoner
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  .goto Western Plaguelands,37.0,56.4
  >>Kill |cRXP_ENEMY_Cauldron Lord Bilemaw|r in Western Plaguelands for the |cRXP_LOOT_Felstone Field Cauldron Key|r
  .complete 5229,1 >>Target: Felstone Field
  .unitscan Cauldron Lord Bilemaw
step
  .goto Western Plaguelands,37.2,56.9
  .target Scourge Cauldron
  >>Click the |cRXP_FRIENDLY_Scourge Cauldron|r in Felstone Field
  .turnin 5229 >>Turn in Target: Felstone Field
  .accept 5230 >>Accept Return to the Bulwark

-- TIRISFAL GLADES #3 --
step
  .goto Tirisfal Glades,83.0,71.8
  .target Shadow Priestess Vandis
  >>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r in Tirisfal Glades
  .turnin 5230 >>Turn in Return to the Bulwark
  .accept 5231 >>Accept Target: Dalson's Tears

-- WESTERN PLAGUELANDS #3 --
step
  .goto Western Plaguelands,46.2,52.6
  >>Kill |cRXP_ENEMY_Cauldron Lord Malvinious|r in Western Plaguelands for the |cRXP_LOOT_Dalson's Tears Cauldron Key|r
  .complete 5231,1 >>Target: Dalson's Tears
  .unitscan Cauldron Lord Malvinious
step
  .goto Western Plaguelands,46.2,52.0
  .target Scourge Cauldron
  >>Click the |cRXP_FRIENDLY_Scourge Cauldron|r in Western Plaguelands
  .turnin 5231 >>Turn in Target: Dalson's Tears
  .accept 5232 >>Accept Return to the Bulwark

-- TIRISFAL GLADES #4 --
step
  .goto Tirisfal Glades,83.0,71.8
  .target Shadow Priestess Vandis
  >>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r in Tirisfal Glades
  .turnin 5232 >>Turn in Return to the Bulwark
  .accept 5233 >>Accept Target: Writhing Haunt

-- WESTERN PLAGUELANDS #4 --
step
  .goto Western Plaguelands,52.8,66.0
  >>Kill |cRXP_ENEMY_Cauldron Lord Razarch|r in Western Plaguelands for the |cRXP_LOOT_Writhing Haunt Cauldron Key|r
  .complete 5233,1 >>Target: Writhing Haunt
  .unitscan Cauldron Lord Razarch
step
  .goto Western Plaguelands,53.0,65.7
  .target Scourge Cauldron
  >>Click the |cRXP_FRIENDLY_Scourge Cauldron|r in Western Plaguelands
  .turnin 5233 >>Turn in Target: Writhing Haunt
  .accept 5234 >>Accept Return to the Bulwark

-- TIRISFAL GLADES #5 --
step
  .goto Tirisfal Glades,83.0,71.8
  .target Shadow Priestess Vandis
  >>Talk to |cRXP_FRIENDLY_Shadow Priestess Vandis|r in Tirisfal Glades
  .turnin 5234 >>Turn in Return to the Bulwark
  .accept 5235 >>Accept Target: Gahrron's Withering

-- WESTERN PLAGUELANDS #5 --
step
  .goto Western Plaguelands,62.8,58.0
  >>Kill |cRXP_ENEMY_Cauldron Lord Soulwrath|r in Western Plaguelands for the |cRXP_LOOT_Gahrron's Withering Cauldron Key|r
  .complete 5235,1 >>Target: Gahrron's Withering
  .unitscan Cauldron Lord Soulwrath
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

-- WESTERN PLAGUELANDS #6 --
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
  >>Kill |cRXP_ENEMY_Scourge Champions|r in Eastern Plaguelands for |cRXP_LOOT_Fetid Skulls|r
  .collect 13157,5,5206,1,-1 -- Marauders of Darrowshire
  .mob Scourge Champion
  .use 13156
  >>Use the |cRXP_PICK_Mystic Crystal|r to create |cRXP_LOOT_Resonating Skulls|r 
  .complete 5206,1 >>Marauders of Darrowshire
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- THE HINTERLANDS #1 --
step
  .goto The Hinterlands,79.0,79.0
  .target Call to Arms!
  >>Click the |cRXP_FRIENDLY_Call to Arms!|r in Revantusk Village, The Hinterlands
  .accept 7862 >>Accept Job Opening: Guard Captain of Revantusk Village
step
  .goto The Hinterlands,64.6,81.8
  >>Kill |cRXP_ENEMY_Vilebranch mobs|r in Jintha'Alor
  .complete 7862,1
  .complete 7862,2
  .complete 7862,3
  .complete 7862,4 >>Job Opening: Guard Captain of Revantusk Village
  .mob Vilebranch Berserker
  .mob Vilebranch Shadow Hunter
  .mob Vilebranch Blood Drinker
  .mob Vilebranch Soul Eater
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  .goto The Hinterlands,23.6,58.7
  .target Venom Bottle
  >>Click the |cRXP_FRIENDLY_Venom Bottle|r in The Hinterlands
  .accept 2933 >>Accept Venom Bottles

-- HILLSBRAD FOOTHILLS #1 --
step
  .goto Hillsbrad Foothills,61.4,19.2
  .target Apothecary Lydon
  >>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r in Tarren Mill
  .turnin 2933 >>Turn in Venom Bottles
  .accept 2934 >>Accept Undamaged Venom Sac

-- THE HINTERLANDS #2 --
step
  .goto The Hinterlands,35.8,64.6
  >>Kill |cRXP_ENEMY_Witherbark Broodguards|r in The Hinterlands for the |cRXP_LOOT_Undamaged Venom Sac|r
  .complete 2934,1 >>Undamaged Venom Sac
  .mob Witherbark Broodguard

-- HILLSBRAD FOOTHILLS #2 --
step
  .goto Hillsbrad Foothills,61.4,19.2
  .target Apothecary Lydon
  >>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r in Tarren Mill
  .turnin 2934 >>Turn in Undamaged Venom Sac
  .accept 2935 >>Accept Consult Master Gadrin

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
  .accept 688 >>Accept Myzrael's Allies
step
  .goto Arathi Highlands,74.4,35.6
  .target Zaruk
  >>Talk to |cRXP_FRIENDLY_Zaruk|r in Arathi Highlands
  .turnin 688 >>Turn in Myzrael's Allies
  .accept 687 >>Accept Theldurin the Lost

-- BADLANDS #3 --
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
  .goto Felwood,51.2,82.2
  .target Greta Mosshoof
  >>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r in Felwood
  .accept 5155 >>Accept Forces of Jaedenar
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
  >>Kill |cRXP_ENEMY_Slime mobs|r in Felwood for |cRXP_LOOT_Felwood Slime Samples|r
  .collect 12230,100,4293,1 -- A Sample of Slime...
  .mob Cursed Ooze
  .mob Tainted Ooze
step
  .goto Felwood,51.2,82.2
  .target Greta Mosshoof
  >>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r in Felwood
  .turnin 5157 >>Turn in Collection of the Corrupt Water
  .accept 5158 >>Accept Seeking Spiritual Aid

-- THE BARRENS #1 --
step
  .goto The Barrens,65.8,43.8
  .target Islen Waterseer
  >>Talk to |cRXP_FRIENDLY_Islen Waterseer|r South of Ratchet in The Barrens
  .turnin 5158 >>Turn in Seeking Spiritual Aid
  .accept 5159 >>Accept Cleansed Water Returns to Felwood

-- Stranglethorn Vale #1 --
step
  .goto Stranglethorn Vale,23.0,71.2
  >>Kill |cRXP_ENEMY_Mok'rash|r in Stranglethorn Vale for the |cRXP_LOOT_Monogrammed Sash|r
  .collect 3985,1,8552,1 >>The Monogrammed Sash
  .unitscan Mok'rash
  >>|cRXP_WARN_DON'T ACCEPT THE ITEM'S QUEST - SAVE FOR LAUNCH DAY.|r

-- DUROTAR #1 --
step
  .goto Durotar,56.0,74.6
  .target Master Gadrin
  >>Talk to |cRXP_FRIENDLY_Master Gadrin|r in Durotar
  .turnin 2935 >>Turn in Consult Master Gadrin
  .accept 2936 >>Accept The Spider God

-- ORGRIMMAR #1 --
step
  .goto Orgrimmar,55.6,64.6
  >>Buy a |cRXP_BUY_Mithril Casing|r from the Auction House 
  .collect 10561,1,4244,1
step
  .goto Orgrimmar,56.6,46.4
  .target Zilzibin Drumlore
  >>Talk to |cRXP_FRIENDLY_Zilzibin Drumlore|r in Orgrimmar
  .accept 4494 >>Accept March of the Silithid
step
  .goto Orgrimmar,75.0,34.2
  .target Belgrom Rockmaul
  >>Talk to |cRXP_FRIENDLY_Belgrom Rockmaul|r in The Valley of Honor
  .accept 3504 >>Accept Betrayed

-- AZSHARA #1 --
step
  .goto Azshara,22.2,51.6
  .target Ag'tor Bloodfist
  >>Talk to |cRXP_FRIENDLY_Ag'tor Bloodfist|r in Azshara
  .turnin 3504 >>Turn in Betrayed
  .accept 3505 >>Accept Betrayed
step
  .goto Azshara,53.4,21.8
  .target Kim'jael
  >>Talk to |cRXP_FRIENDLY_Kim'jael|r in Azshara
  .accept 3601 >>Accept Kim'jael Indeed!
step
  .goto Azshara,58.6,29.1
  >>Loot |cRXP_LOOT_Kim'jael's Compass, Scope, Stuffed Chicken, and Wizzlegoober|r from the Equipment containers at the Blood Elf camp
  .complete 3601,1
  .complete 3601,2
  .complete 3601,3
  .complete 3601,4 >>Kim'jael Indeed!
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  .goto Azshara,59.5,31.3
  >>Kill |cRXP_ENEMY_Blood Elves|r in Azshara
  .complete 3505,1
  .complete 3505,2 >>Betrayed
  .mob Blood Elf Reclaimer
  .mob Blood Elf Surveyor
step
  .goto Azshara,59.5,31.3
  .target Kaldorei Tome of Summoning
  >>Click the |cRXP_FRIENDLY_Kaldorei Tome of Summoning|r at Magus Rimtori's camp
  .turnin 3505 >>Turn in Betrayed
  .accept 3506 >>Accept Betrayed
step
  .goto Azshara,59.6,31.4
  >>Summon |cRXP_ENEMY_Magus Rimtori|r by destroying the correct arcane crystal. Then kill her for the |cRXP_LOOT_Head of Magus Rimtori|r
  .complete 3506,1 >>Betrayed
  .mob Magus Rimtori
step
  .goto Azshara,22.2,51.6
  .target Ag'tor Bloodfist
  >>Talk to |cRXP_FRIENDLY_Ag'tor Bloodfist|r in Azshara
  .turnin 3506 >>Turn in Betrayed
  >>|cRXP_WARN_DON'T ACCEPT THE NEXT QUEST - THIS IS YOUR BREADCRUMB.|r

-- FELWOOD #2 --
step
  .goto Felwood,51.2,82.2
  .target Greta Mosshoof
  >>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r in Felwood
  .turnin 5159 >>Turn in Cleansed Water Returns to Felwood
  .accept 5165 >>Accept Dousing the Flames of Protection
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

-- TANARIS #1 --
step
  .goto Tanaris,50.8,27.0
  .target Alchemist Pestlezugg
  >>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r in Gadgetzan
  .turnin 4494 >>Turn in March of the Silithid
  .accept 4496 >>Accept Bungle in the Jungle
step
  .goto Tanaris,52.4,28.4
  .target Chief Engineer Bilgewhizzle
  >>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r in Gadgetzan
  .accept 2768 >>Accept Divino-matic Rod
step
  .goto Thousand Needles,78.0,77.0
  .target Wizzle Brassbolts
  >>Talk to |cRXP_FRIENDLY_Wizzle Brassbolts|r in The Shimmering Flats
  .accept 2770 >>Accept Gahz'rilla
step
  .goto Tanaris,67.0,22.4
  .target Yeh'kinya
  >>Talk to |cRXP_FRIENDLY_Yeh'kinya|r in Steamweedle Port
  .accept 3520 >>Accept Screecher Spirits

-- UN'GORO CRATER #1 --
step
  #completewith ungoro1
  >>Kill |cRXP_ENEMY_ANY MOB|r in Un'Goro Crater for the |cRXP_LOOT_A Mangled Journal|r
  .collect 11116,1,3884,1 -- Williden's Journal
  >>|cRXP_WARN_DON'T ACCEPT THE ITEM'S QUEST - SAVE FOR LAUNCH DAY.|r
step
  #completewith ungoro1
  >>Click |cRXP_PICK_Power Crystal Nodes|r in Un'Goro Crater for |cRXP_LOOT_Power Crystals|r
  .collect 11186,7,4284,1
  .collect 11188,7,4284,1
  .collect 11185,7,4284,1
  .collect 11184,7,4284,1 >>Crystals of Power
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
  .goto Un'Goro Crater,71.6,76.0
  .target Torwa Pathfinder
  >>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r in Un'Goro Crater
  .accept 4290 >>Accept The Fare of Lar'korwi
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
  .goto Un'Goro Crater,68.7,56.7
  >>Loot the |cRXP_LOOT_Piece of Threshadon Carcass|r from the Fresh Threshadon Carcass in Un'Goro Crater
  .complete 4290,1 >>The Fare of Lar'korwi
step
  .goto Un'Goro Crater,71.6,76.0
  .target Torwa Pathfinder
  >>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r in Un'Goro Crater
  .turnin 4290 >>Turn in The Fare of Lar'korwi
  .accept 4291 >>Accept The Scent of Lar'korwi
step
  .goto Un'Goro Crater,66.6,67.6
  >>Kill |cRXP_ENEMY_Lar'korwi Mate|r in Un'Goro Crater for |cRXP_LOOT_Ravasaur Pheromone Glands|r
  .complete 4291,1 >>The Scent of Lar'korwi
  .mob Lar'korwi Mate
step
  .goto Un'Goro Crater,71.6,76.0
  .target Torwa Pathfinder
  >>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r in Un'Goro Crater
  .turnin 4291 >>Turn in The Scent of Lar'korwi
  .accept 4292 >>Accept The Bait for Lar'korwi
step
  .goto Un'Goro Crater,79.6,49.8
  .use 11569
  >>Summon and Kill |cRXP_ENEMY_Lar'korwi|r in Un'Goro Crater for |cRXP_LOOT_Lar'korwi's Head|r
  .complete 4292,1 >>The Bait for Lar'korwi
  .mob Lar'korwi
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  >>Kill |cRXP_ENEMY_Slime mobs|r in Un'Goro Crater for |cRXP_LOOT_Un'Goro Slime Samples|r
  .collect 12235,100,4294,1 -- ... and a Batch of Ooze
  .mob Muculent Ooze
  .mob Glutinous Ooze
  .mob Primal Ooze
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
  .goto Un'Goro Crater,46.6,13.4
  .target A-Me 01
  >>Escort |cRXP_FRIENDLY_A-Me 01|r to Karna Remtravel at Marshal's Refuge
  .complete 4245,1 >>Chasing A-Me 01
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
  #label ungoro1
  >>Collect |cRXP_LOOT_Un'Goro Soil|r in Un'Goro Crater
  .complete 4496,2 >>Bungle in the Jungle

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

-- WINTERSPRING #1 --
step
  .goto Winterspring,31.2,45.2
  .target Donova Snowden
  >>Talk to |cRXP_FRIENDLY_Donova Snowden|r in Winterspring
  .turnin 3909 >>Turn in The Videre Elixir
  .accept 3912 >>Accept Meet at the Grave

-- TANARIS #2 --
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
  >>Kill |cRXP_ENEMY_ANY MOB|r in Un'Goro Crater for the |cRXP_LOOT_A Mangled Journal|r
  .collect 11116,1,3884,1 -- Williden's Journal
  >>|cRXP_WARN_DON'T ACCEPT THE ITEM'S QUEST - SAVE FOR LAUNCH DAY.|r
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

-- Zul'Farrak #1 --
step
  >>Head to Zul'Farrak in Tanaris
  >>Kill |cRXP_ENEMY_Theka the Martyr|r for the |cRXP_LOOT_First Mosh'aru Tablet|r
  .complete 3527,1 >>The Prophecy of Mosh'aru
  .mob Theka the Martyr
  >>Kill |cRXP_ENEMY_Hydromancer Velratha|r for the |cRXP_LOOT_Second Mosh'aru Tablet|r
  .complete 3527,2 >>The Prophecy of Mosh'aru
  .mob Hydromancer Velratha
  >>Kill |cRXP_ENEMY_Theka the Martyr|r, then read his tablet
  .complete 2936,1 >>The Spider God
  .mob Theka the Martyr
  >>Kill |cRXP_ENEMY_Sergeant Bly|r for the |cRXP_LOOT_Divino-matic Rod|r
  .complete 2768,1 >>Divino-matic Rod
  .mob Sergeant Bly
step
  >>Use the Sacred Mallet to Summon and Kill |cRXP_ENEMY_Gahz'rilla|r for |cRXP_LOOT_Gahz'rilla's Electrified Scale|r
  .complete 2770,1 >>Gahz'rilla
  .mob Gahz'rilla
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- TANARIS #3 --
step
  .goto Tanaris,50.8,27.0
  .target Alchemist Pestlezugg
  >>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r in Gadgetzan
  .turnin 4507 >>Turn in Pawn Captures Queen
  >>|cRXP_WARN_DON'T ACCEPT THE NEXT QUEST - THIS IS YOUR BREADCRUMB.|r
step
  .goto Tanaris,67.0,22.4
  .target Yeh'kinya
  >>Talk to |cRXP_FRIENDLY_Yeh'kinya|r in Steamweedle Port
  .turnin 3527 >>Turn in The Prophecy of Mosh'aru
  .accept 4787 >>Accept The Ancient Egg
step
  >>Kill |cRXP_ENEMY_Pirates|r in Lost Rigger Cove, Tanaris for the |cRXP_LOOT_Ship Schedule|r
  .collect 9250,1,2876,1 -- Ship Schedules
  >>|cRXP_WARN_NOTE|r: It's possible to receive The Ship Schedule from inside a Pirate's Footlocker
  >>|cRXP_WARN_DON'T ACCEPT THE ITEM'S QUEST - SAVE FOR LAUNCH DAY.|r
step
  .goto Tanaris,70,50
  .use 11617
  .use 11169
  >>Remove all items from |cRXP_PICK_Eridan's Supplies|r
  >>Head to the Stone Summoning Circle in Tanaris then use the |cRXP_PICK_Book of Aquor|r to Summon Aquementas
  >>Stay in the Circle until Aquementas becomes hostile and your items turn into the |cRXP_LOOT_Silver Totem of Aquementas|r
  .complete 4005,1 >>Aquementas
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- DUROTAR #2 --
step
  .goto Durotar,56.0,74.6
  .target Master Gadrin
  >>Talk to |cRXP_FRIENDLY_Master Gadrin|r in Durotar
  .turnin 2936 >>Turn in The Spider God
  .accept 2937 >>Accept Summoning Shadra

-- UNDERCITY #2 --
step
  .goto Undercity,47.6,73.0
  .use 12235
  >>Use the |cRXP_PICK_Testing Equipment|r to create |cRXP_LOOT_Pure Un'Goro Sample|r next to Chemist Fuely in Undercity
  .complete 4294,1 >>... and a Batch of Ooze
step
  .goto Undercity,47.6,73.0
  .use 12235
  >>Use the |cRXP_PICK_Testing Equipment|r to create |cRXP_LOOT_Pure Un'Goro Sample|r next to Chemist Fuely in Undercity
  .complete 4293,1 >>A Sample of Slime...
step
  .goto Undercity,47.6,73.0
  .target Chemist Fuely
  >>Talk to |cRXP_FRIENDLY_Chemist Fuely|r in The Apothecarium
  .turnin 4294 >>Turn in ... and a Batch of Ooze
  .turnin 4293 >>Turn in A Sample of Slime...
  .accept 4642 >>Accept Melding of Influences

-- THE HINTERLANDS #3 --
step
  .goto The Hinterlands,57.5,86.7
  >>Loot the |cRXP_LOOT_Ancient Egg|r in the cave at the top of Jintha'Alor in The Hinterlands
  .complete 4787,1 >>The Ancient Egg
step
  .goto The Hinterlands,34.4,72.2
  .use 9323
  >>Summon and Kill |cRXP_ENEMY_Shadra|r in The Hinterlands for |cRXP_LOOT_Shadra's Venom|r
  .complete 2937,1 >>Summoning Shadra
  .mob Shadra
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

-- TANARIS #4 --
step
  .goto Tanaris,67.0,22.4
  .target Yeh'kinya
  >>Talk to |cRXP_FRIENDLY_Yeh'kinya|r in Steamweedle Port
  .turnin 4787 >>Turn in The Ancient Egg
  .accept 82095 >>Accept The God Hakkar

-- UN'GORO CRATER #3 --
step
  .goto Un'Goro Crater,44,24
  .use 12288
  >>Use the Encased Corrupt Ooze on a Primal Ooze in Un'Goro Crater
  >>Kill the |cRXP_ENEMY_Gargantuan Ooze|r that spawns for the |cRXP_LOOT_Merged Ooze Sample|r
  .complete 4642,1 >>Melding of Influences
  .mob Primal Ooze
  .mob Gargantuan Ooze
  >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- SUNKEN TEMPLE #1 --
step
  >>Head to Sunken Temple in the Swamp of Sorrows
  >>Kill |cRXP_ENEMY_Avatar of Hakkar|r for the |cRXP_LOOT_Essence of Hakkar|r
  .complete 82095,1 >>The God Hakkar
  .mob Avatar of Hakkar

-- TANARIS #5 --
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
#version 2
<< Horde
#group Custom Quests for RXP
#subgroup SoD Level 50 Quest Stacking
#name 50-3-Launch Day Turn-in Route
#displayname 3-Launch Day Turn-in Route

step
  #sticky
  +|cRXP_WARN_WARNING: ONLY LOAD THIS GUIDE ON LAUNCH DAY, DO NOT ACCIDENTALLY TURN IN YOUR PRE QUESTS|r
step
    >>|cRXP_WARN_LEVEL 50 HORDE QUEST STACK|r
    >>This is a community guide that may have ERRORS.
    >>I recommend testing on the PTR prior to Phase 4 launch.
    +|cRXP_PICK_I understand|r
step
  .isOnQuest 4245
  .goto Un'Goro Crater,46.6,13.4
  .target Karna Remtravel
  >>Talk to |cRXP_FRIENDLY_Karna Remtravel|r at Marshal's Refuge, Un'Goro
  .turnin 4245 >>Turn in Chasing A-Me 01
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
  .isOnQuest 4292
  .goto Un'Goro Crater,71.6,76.0
  .target Torwa Pathfinder
  >>Talk to |cRXP_FRIENDLY_Torwa Pathfinder|r in Un'Goro Crater
  .turnin 4292 >>Turn in The Bait for Lar'korwi
step
  .fly Gadgetzan
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
  >>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r 
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
  .isQuestTurnedIn 4507
  .goto Tanaris,50.8,27.0
  .target Alchemist Pestlezugg
  >>Talk to |cRXP_FRIENDLY_Alchemist Pestlezugg|r in Gadgetzan
  .accept 4509 >>Accept Calm Before the Storm
step
  .isQuestTurnedIn 2854
  .fly Camp Mojache >>Fly to Camp Mojache, Feralas if you are turning in Leatherworking quests
step
  .isQuestTurnedIn 2854
  .itemcount 8193,2
  .itemcount 8197,2
  .itemcount 8153,2
  .goto Feralas,74.4,42.8
  .target Jangdor Swiftstrider
  >>Talk to |cRXP_FRIENDLY_Jangdor Swiftstrider|r in Camp Mojache
  .accept 2858 >>Accept Wild Leather Boots
  .turnin 2858 >>Turn in Wild Leather Boots
step
  .isQuestTurnedIn 2854
  .itemcount 8175,2
  .itemcount 8176,2
  .itemcount 8153,1
  .goto Feralas,74.4,42.8
  .target Jangdor Swiftstrider
  >>Talk to |cRXP_FRIENDLY_Jangdor Swiftstrider|r in Camp Mojache
  .accept 2857 >>Accept Wild Leather Helmet
  .turnin 2857 >>Turn in Wild Leather Helmet
step
  .isQuestTurnedIn 2854
  .itemcount 8191,2
  .itemcount 8198,2
  .itemcount 8153,2
  .goto Feralas,74.4,42.8
  .target Jangdor Swiftstrider
  >>Talk to |cRXP_FRIENDLY_Jangdor Swiftstrider|r in Camp Mojache
  .accept 2859 >>Accept Wild Leather Leggings
  .turnin 2859 >>Turn in Wild Leather Leggings
step
  .isQuestTurnedIn 2854
  .itemcount 8173,6
  .itemcount 8153,1
  .goto Feralas,74.4,42.8
  .target Jangdor Swiftstrider
  >>Talk to |cRXP_FRIENDLY_Jangdor Swiftstrider|r in Camp Mojache
  .accept 2855 >>Accept Wild Leather Shoulders
  .turnin 2855 >>Turn in Wild Leather Shoulders
step
  .isQuestTurnedIn 2854
  .itemcount 8189,2
  .itemcount 8187,2
  .itemcount 8153,1
  .goto Feralas,74.4,42.8
  .target Jangdor Swiftstrider
  >>Talk to |cRXP_FRIENDLY_Jangdor Swiftstrider|r in Camp Mojache
  .accept 2856 >>Accept Wild Leather Vest
  .turnin 2856 >>Turn in Wild Leather Vest
step
  .isQuestTurnedIn 2855
  .isQuestTurnedIn 2856
  .isQuestTurnedIn 2857
  .isQuestTurnedIn 2858
  .isQuestTurnedIn 2859
  .goto Feralas,74.4,42.8
  .target Jangdor Swiftstrider
  >>Talk to |cRXP_FRIENDLY_Jangdor Swiftstrider|r in Camp Mojache
  .accept 2860 >>Accept Master of the Wild Leather
step << Mage
  .zone Thunder Bluff >>Teleport to Thunder Bluff
step << !Mage
  .fly Thunder Bluff
step
  .goto Thunder Bluff,43.8,42.2
  .target Rumstag Proudstrider
  >>Talk to |cRXP_FRIENDLY_Rumstag Proudstrider|r in Thunder Bluff
  .turnin 7820 >>Turn in A Donation of Wool
  .turnin 7821 >>Turn in A Donation of Silk
  .turnin 7822 >>Turn in A Donation of Mageweave
  .turnin 7823 >>Turn in A Donation of Runecloth
step
  .isOnQuest 2860
  .goto Thunder Bluff,41.8,42.6
  .target Una
  >>Talk to |cRXP_FRIENDLY_Una|r in Thunder Bluff
  .turnin 2860 >>Turn in Master of the Wild Leather
step << Mage
  .zone Orgrimmar >>Teleport to Orgrimmar
step << !Mage
  .fly Orgrimmar
step
  .goto Orgrimmar,37.8,87.6
  .target Vehena
  >>Talk to |cRXP_FRIENDLY_Vehena|r in The Valley of Spirits
  .turnin 7833 >>Turn in A Donation of Wool
  .turnin 7834 >>Turn in A Donation of Silk
  .turnin 7835 >>Turn in A Donation of Mageweave
  .turnin 7836 >>Turn in A Donation of Runecloth
step
  .isOnQuest 4509
  .goto Orgrimmar,56.6,46.4
  .target Zilzibin Drumlore
  >>Talk to |cRXP_FRIENDLY_Zilzibin Drumlore|r in The Drag
  .turnin 4509 >>Turn in Calm Before the Storm
step
  .isQuestTurnedIn 4509
  .goto Orgrimmar,56.6,46.4
  .target Zilzibin Drumlore
  >>Talk to |cRXP_FRIENDLY_Zilzibin Drumlore|r in The Drag
  .accept 4511 >>Accept Calm Before the Storm
step
  .isOnQuest 4511
  .goto Orgrimmar,49.8,70.0
  .target Karus
  >>Talk to |cRXP_FRIENDLY_Karus|r at the Orgrimmar bank
  .turnin 4511 >>Turn in Calm Before the Storm
step
  .goto Orgrimmar,63.6,51.0
  .target Rashona Straglash
  >>Talk to |cRXP_FRIENDLY_Rashona Straglash|r in The Drag
  .turnin 7826 >>Turn in A Donation of Wool
  .turnin 7827 >>Turn in A Donation of Silk
  .turnin 7831 >>Turn in A Donation of Mageweave
  .turnin 7824 >>Turn in A Donation of Runecloth
step
  .fly Valormok >>Fly to Valormok, Azshara
step << Mage
  .isQuestTurnedIn 3506
  .goto Azshara,22.2,51.6
  .target Ag'tor Bloodfist
  >>Talk to |cRXP_FRIENDLY_Ag'tor Bloodfist|r in Azshara
  .accept 3507 >>Accept Betrayed
step << Mage
  .isOnQuest 82114
  .goto Azshara,29.6,40.6
  .target Archmage Xylem
  >>Talk to |cRXP_FRIENDLY_Archmage Xylem|r in Azshara
  .turnin 82114 >>Turn in Destroy Morphaz
step
  .isOnQuest 3601
  .goto Azshara,53.4,21.8
  .target Kim'jael
  >>Talk to |cRXP_FRIENDLY_Kim'jael|r in Azshara
  .turnin 3601 >>Turn in Kim'jael Indeed!
step
  .fly Bloodvenom Post >>Fly to Bloodvenom Post, Felwood
step
  .isOnQuest 8464
  .goto Winterspring,27.8,34.6
  .target Salfa
  >>Talk to |cRXP_FRIENDLY_Salfa|r in Winterspring
  .turnin 8464 >>Turn in Winterfall Activity
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
  .isOnQuest 5385
  .goto Felwood,51.2,82.0
  .target Jessir Moonbow
  >>Talk to |cRXP_FRIENDLY_Jessir Moonbow|r at the Emerald Sanctuary
  .turnin 5385 >>Turn in The Remains of Trey Lightforge
step
  .isOnQuest 5242
  .goto Felwood,51.2,82.2
  .target Greta Mosshoof
  >>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r in Felwood
  .turnin 5242 >>Turn in A Final Blow
step << Priest
  .isOnQuest 8257
  .goto Felwood,51.2,82.2
  .target Greta Mosshoof
  >>Talk to |cRXP_FRIENDLY_Greta Mosshoof|r in Felwood
  .turnin 8257 >>Turn in Blood of Morphaz
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
step << Mage
  .isOnQuest 3507
  .zone Orgrimmar >> Teleport to Orgrimmar
step << Mage
  .isOnQuest 3507
  .goto Orgrimmar,75.0,34.2
  .target Belgrom Rockmaul
  >>Talk to |cRXP_FRIENDLY_Belgrom Rockmaul|r in The Valley of Honor
  .turnin 3507 >>Turn in Betrayed
step
  .hs >>Hearth to Booty Bay
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
  .fly Stonard
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
step << Warrior
  .isOnQuest 82107
  .goto Swamp of Sorrows,34.2,66.0
  .target Fallen Hero of the Horde
  >>Talk to the |cRXP_FRIENDLY_Fallen Hero of the Horde|r in the Swamp of Sorrows
  .turnin 82107 >>Turn in Voodoo Feathers
step
  .itemcount 10593,1
  .goto Blasted Lands,51.8,35.6
  .target Kum'isha the Collector
  >>Talk to |cRXP_FRIENDLY_Kum'isha the Collector|r in the Blasted Lands
  .accept 3501 >>Accept Everything Counts In Large Amounts
  .turnin 3501 >>Turn in Everything Counts In Large Amounts
step
  .itemcount 8244,1
  .goto Blasted Lands,51.8,35.6
  .target Kum'isha the Collector
  >>Talk to |cRXP_FRIENDLY_Kum'isha the Collector|r in the Blasted Lands
  .accept 2521 >>Accept To Serve Kum'isha
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
step
  .fly Kargath >>Fly to Kargath, Badlands
step
  .target Innkeeper Shul'kar
  .home >>Set your hearthstone at Kargath, Badlands
step
  .isOnQuest 3906
  .goto Badlands,3.6,48.0
  .target Thunderheart
  >>Talk to |cRXP_FRIENDLY_Thunderheart|r in Kargath
  .turnin 3906 >>Turn in Disharmony of Flame
  >>|cRXP_WARN_NOTE|r: If Thunderheart is on patrol, skip this step for now
step
  .isOnQuest 3907
  .goto Badlands,3.6,48.0
  .target Thunderheart
  >>Talk to |cRXP_FRIENDLY_Thunderheart|r in Kargath
  .turnin 3907 >>Turn in Disharmony of Fire
  >>|cRXP_WARN_NOTE|r: If Thunderheart is on patrol, skip this step for now
step
  .isQuestTurnedIn 3906
  .goto Badlands,3.6,48.0
  .target Thunderheart
  >>Talk to |cRXP_FRIENDLY_Thunderheart|r in Kargath
  .accept 3981 >>Accept Commander Gor'shak
  >>|cRXP_WARN_NOTE|r: If Thunderheart is on patrol, skip this step for now
step
  .isOnQuest 656
  .fly Hammerfall
step
  .isOnQuest 656
  .goto Arathi Highlands,62.5,33.8
  .target Shards of Myzrael
  >>Click the |cRXP_FRIENDLY_Shards of Myzrael|r 
  .turnin 656 >>Turn in Summoning the Princess
step
  .isOnQuest 7862
  .fly Revantusk Village
step
  .isOnQuest 7862
  .goto The Hinterlands,78.2,81.2
  .target Primal Torntusk
  >>Talk to |cRXP_FRIENDLY_Primal Torntusk|r in Revantusk Village
  .turnin 7862 >>Turn in Job Opening: Guard Captain of Revantusk Village
step
  .isOnQuest 5206
  .fly Light's Hope Chapel
step
  .isOnQuest 5206
  .goto Eastern Plaguelands,81.4,59.8
  .target Carlin Redpath
  >>Talk to |cRXP_FRIENDLY_Carlin Redpath|r in Eastern Plaguelands
  .turnin 5206 >>Turn in Marauders of Darrowshire
step
  .fly Tarren Mill
step
  .isOnQuest 2937
  .goto Hillsbrad Foothills,61.4,19.2
  .target Apothecary Lydon
  >>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r in Tarren Mill
  .turnin 2937 >>Turn in Summoning Shadra
step
  .isQuestTurnedIn 2937
  .goto Hillsbrad Foothills,61.4,19.2
  .target Apothecary Lydon
  >>Talk to |cRXP_FRIENDLY_Apothecary Lydon|r in Tarren Mill
  .accept 2938 >>Accept Venom to the Undercity
step << Mage
  .zone Undercity >>Teleport to Undercity
step << !Mage
  .fly Undercity
step
  .goto Undercity,71.8,29.0
  .target Ralston Farnsley
  >>Talk to |cRXP_FRIENDLY_Ralston Farnsley|r in Undercity
  .turnin 7813 >>Turn in A Donation of Wool
  .turnin 7814 >>Turn in A Donation of Silk
  .turnin 7817 >>Turn in A Donation of Mageweave
  .turnin 7818 >>Turn in A Donation of Runecloth
step
  .isOnQuest 2938
  .goto Undercity,48.6,69.6
  .target Master Apothecary Faranell
  >>Talk to |cRXP_FRIENDLY_Master Apothecary Faranell|r in Undercity
  .turnin 2938 >>Turn in Venom to the Undercity
step
  .isQuestTurnedIn 4293
  .isQuestTurnedIn 4294
  .goto Undercity,47.6,73.0
  .target Chemist Fuely
  >>Talk to |cRXP_FRIENDLY_Chemist Fuely|r in The Apothecarium
  .turnin 4642 >>Turn in Melding of Influences
step
  .isOnQuest 105
  .goto Tirisfal Glades,83.0,69.0
  .target High Executor Derrington
  >>Talk to |cRXP_FRIENDLY_High Executor Derrington|r in Tirisfal Glades
  .turnin 105 >>Turn in Alas, Andorhal
step
  .isOnQuest 5235
  .goto Western Plaguelands,62.5,58.6
  .target Scourge Cauldron
  >>Click the |cRXP_FRIENDLY_Scourge Cauldron|r in Western Plaguelands
  .turnin 5235 >>Turn in Target: Gahrron's Withering
step
  .zone Badlands >>Run to Scarlet Monastery and Ghetto Hearth to Kargath
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
  >>Talk to |cRXP_FRIENDLY_Squire Maltrake|r in Searing Gorge
  .turnin 3463 >>Turn in Set Them Ablaze!
step
  .isQuestTurnedIn 3463
  .goto Searing Gorge,39.0,38.9
  .target Hoard of the Black Dragonflight Chest
  >>Click the |cRXP_FRIENDLY_Hoard of the Black Dragonflight Chest|r in Searing Gorge
  .accept 3481 >>Accept Trinkets...
  .turnin 3481 >>Turn in Trinkets...

step
    +CONGRATULATIONS!!! You have completed this route.
]])