RXPGuides.RegisterGuide([[
#classic
#version 1
<< Alliance
#group Custom Quests for RXP
#subgroup SoD Level 40 Quest Stacking
#name 40-1-How to Use this Guide
#displayname 1-How to Use this Guide
#next 40-2-Pre-Launch Collection Guide

-- |cRXP_FRIENDLY_, |cRXP_ENEMY_, |cRXP_LOOT_, |cRXP_WARN_, |cRXP_PICK_, |cRXP_BUY_
-- |c99ffff99 OR|r
-- |Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk

step
    >>Welcome to the |cRXP_WARN_SoD Level 40|r Quest Stacking Guide!
    +Use the Collection Guide to complete pre-req quests and gather items for launch day.
    +|cRXP_WARN_ON LAUNCH DAY|r, use the Turn-in Guide.
]])

RXPGuides.RegisterGuide([[
#classic
#version 2
<< Alliance
#group Custom Quests for RXP
#subgroup SoD Level 40 Quest Stacking
#name 40-2-Pre-Launch Collection Guide
#displayname 2-Pre-Launch Collection Guide
#next 40-3-Launch Day Turn-in Route

step
    .maxlevel 39
    >>|cRXP_WARN_NOTE|r: This guide is for |cRXP_WARN_HIGHER LEVEL|r characters.
    .xp 40
step
    >>|cRXP_WARN_LEVEL 40 ALLIANCE QUEST STACK|r
    >>This guide is for collection prior to launch day.
    +Only turn-in specified quests in this guide.
    +Other quests are left in your quest log for launch day.
    >>|cRXP_WARN_NOTE|r: This is an |cRXP_PICK_UNFINISHED|r route. For more details, check
    .link https://www.patreon.com/joardee >>Joardee's Patreon spreadsheet
step
    >>|cRXP_WARN_WARNING PLEASE READ CAREFULLY!!!!|r
    >>Many quest addons auto-turn-in quests (INCLUDING THIS ONE).
    >>It is your responsibility to safeguard your Launch Day quests.
    +|cRXP_PICK_I understand|r
    >>|cRXP_WARN_PRO TIP|r: Store turn-in items in the bank to prevent accidental turn-in.

-- PROFESSIONS --
step
    .train 2550 >>Train Cooking
    +Level your cooking to 225
    >>You will need it leveled for a breadcrumb quest
    .skill cooking,225,1
step
    .train 3273 >> Train First Aid
    +Level your first aid to 225
    >>You will need it leveled for a breadcrumb quest
    .skill firstaid,225,1

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
    .goto Ironforge,50.6,6.2
    .target Gerrig Bonegrip
    >>Talk to |cRXP_FRIENDLY_Gerrig Bonegrip|r in Ironforge
    .turnin 653 >>Turn in Myzrael's Allies
    .accept 687 >>Accept Theldurin the Lost

-- BADLANDS #1 --
step
    .goto Badlands,53.0,34.1
    >>Click the |cRXP_FRIENDLY_Crumpled Map|r at Hammertoe's Digsite
    .accept 720 >>Accept A Sign of Hope
step
    .goto Badlands,53.4,43.6
    .target Prospector Ryedol
    >>Talk to |cRXP_FRIENDLY_Prospector Ryedol|r in the Badlands
    .turnin 720 >>Turn in A Sign of Hope
    .accept 721 >>Accept A Sign of Hope
step
    .goto Badlands,53.8,43.6
    .target Sigrun Ironhew
    >>Talk to |cRXP_FRIENDLY_Sigrun Ironhew|r in the Badlands
    .accept 718 >>Accept Mirages
step
    .goto Badlands,66.89,23.45
    >>Loot the |cRXP_LOOT_Supply Crate|r from the Excavation Supply Crate at Camp Kosh
    .complete 718,1 >>Mirages
step
    .goto Badlands,53.8,43.6
    .target Sigrun Ironhew
    >>Talk to |cRXP_FRIENDLY_Sigrun Ironhew|r in the Badlands
    .turnin 718 >>Turn in Mirages
step
    .goto Badlands,61.8,54.8
    .target Garek
    >>Talk to |cRXP_FRIENDLY_Garek|r in the Badlands
    .accept 732 >>Accept Tremors of the Earth
step
    #completewith badlands1
    >>Kill |cRXP_ENEMY_Boss Tho'grun|r  for the |cRXP_LOOT_Sign of the Earth|r
    .complete 732,1 >>Tremors of the Earth
    .unitscan Boss Tho'grun
    >>|cRXP_WARN_NOTE|r: He patrols around the zone
step
    .goto Badlands,51.4,76.8
    .target Theldurin the Lost
    >>Find |cRXP_FRIENDLY_Theldurin the Lost|r in the Badlands
    .turnin 687 >>Turn in Theldurin the Lost
    .accept 692 >>Accept The Lost Fragments
    .accept 709 >>Accept Solution to Doom
step
    .goto Badlands,54.8,86.0
    >>Kill |cRXP_ENEMY_Enraged Rock Elementals|r in the Badlands for the |cRXP_LOOT_Torn, Crumpled, and Singed Scroll Fragments|r
    .complete 692,1 >>The Lost Fragments
    .complete 692,2
    .complete 692,3
    .mob Enraged Rock Elemental
step
    .goto Badlands,37.94,10.53
    .target Hammertoe Grez
    >>Talk to |cRXP_FRIENDLY_Hammertoe Grez|r in the Uldaman cave (outside the instance)
    .turnin 721 >>Turn in A Sign of Hope
    .accept 722 >>Accept Amulet of Secrets
step
    .goto Eastern Kingdoms,54.14,58.22
    >>Loot the |cRXP_LOOT_Tablet of Ryun'eh|r from the Ancient Chest in the Sealed Hall (outside the instance)
    .complete 709,1 >>Solution to Doom
step
    .goto Eastern Kingdoms,54.14,58.22
    >>Kill |cRXP_ENEMY_Magregan Deepshadow|r in the Sealed Hall (outside the instance) for |cRXP_LOOT_Hammertoe's Amulet|r
    .complete 722,1 >>Amulet of Secrets
    .unitscan Magregan Deepshadow
step
    .goto Badlands,37.94,10.53
    .target Hammertoe Grez
    >>Talk to |cRXP_FRIENDLY_Hammertoe Grez|r in the Uldaman cave (outside the instance)
    .turnin 722 >>Turn in Amulet of Secrets
    .accept 723 >>Accept Prospect of Faith
step
    .goto Badlands,53.4,43.6
    .target Prospector Ryedol
    >>Talk to |cRXP_FRIENDLY_Prospector Ryedol|r in the Badlands
    .turnin 723 >>Turn in Prospect of Faith
    >>|cRXP_WARN_DON'T ACCEPT THE NEXT QUEST - THIS IS YOUR BREADCRUMB.|r
step
    #label badlands1
    .goto Badlands,51.4,76.8
    .target Theldurin the Lost
    >>Return to |cRXP_FRIENDLY_Theldurin the Lost|r in the Badlands
    .turnin 692 >>Turn in The Lost Fragments
    .accept 656 >>Accept Summoning the Princess
    .turnin 709 >>Turn in Solution to Doom
    .accept 727 >>Accept To Ironforge for Yagyin's Digest
step
    >>Kill |cRXP_ENEMY_Boss Tho'grun|r  for the |cRXP_LOOT_Sign of the Earth|r
    .complete 732,1 >>Tremors of the Earth
    .unitscan Boss Tho'grun
    >>|cRXP_WARN_NOTE|r: He patrols around the zone
step
    .goto Badlands,61.8,54.8
    .target Garek
    >>Talk to |cRXP_FRIENDLY_Garek|r in the Badlands
    .turnin 732 >>Turn in Tremors of the Earth
    .accept 717 >>Accept Tremors of the Earth
step
    .goto Badlands,81.6,49.8
    >>Kill |cRXP_ENEMY_Blacklash|r in the Badlands for |cRXP_LOOT_Blacklash's Bindings|r
    .complete 717,1 >>Tremors of the Earth
    .unitscan Blacklash
step
    >>Kill |cRXP_ENEMY_Hematus|r in the Badlands for the |cRXP_LOOT_Chains of Hematus|r
    .complete 717,2 >>Tremors of the Earth
    .unitscan Hematus
    >>|cRXP_WARN_NOTE|r: He patrols around the zone
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- SEARING GORGE #1 --
step
    .goto Searing Gorge,29.6,26.6
    .target Zamael Lunthistle
    >>Talk to |cRXP_FRIENDLY_Zamael Lunthistle|r in Searing Gorge
    .accept 3377 >>Accept Prayer to Elune
    .complete 3377,1 >>Complete Prayer to Elune
    .turnin 3377 >>Turn in Prayer to Elune
    .accept 3378 >>Accept Prayer to Elune
step
    .goto Searing Gorge,22.2,26.6
    >>Kill |cRXP_ENEMY_Twilight mobs|r in Searing Gorge for the |cRXP_LOOT_Prayer to Elune|r
    .complete 3378,1 >>Prayer to Elune
    .mob Twilight Dark Shaman
    .mob Twilight Fire Guard
    .mob Twilight Geomancer
    .mob Twilight Idolater
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- IRONFORGE #2 --
step
    .goto Ironforge,50.6,6.2
    .target Gerrig Bonegrip
    >>Talk to |cRXP_FRIENDLY_Gerrig Bonegrip|r in The Forlorn Cavern
    .turnin 727 >>Turn in To Ironforge for Yagyin's Digest
    .accept 735 >>Accept The Star, The Hand, and the Heart

-- ALTERAC MOUNTAINS #1 --
step
    .goto Alterac Mountains,36.6,51.4
    >>Kill |cRXP_ENEMY_Grel'borg the Miser|r in the Ruins of Alterac for the |cRXP_LOOT_Star of Xil'yeh|r
    .complete 735,1 >>The Star, The Hand, and the Heart
    .unitscan Grel'borg the Miser

-- ARATHI HIGHLANDS #2 --
step
    .goto Arathi Highlands,62.6,34.6
    .use 4472
    >>Summon and Kill |cRXP_ENEMY_Myzrael|r in Arathi Highlands for the |cRXP_LOOT_Eldritch Shackles|r
    .complete 656,1 >>Summoning the Princess
    .mob Myzrael
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- STORMWIND CITY #1 --
step
    .goto Stormwind City,64.2,20.8
    .target Brohann Caskbelly
    >>Talk to |cRXP_FRIENDLY_Brohann Caskbelly|r in Stormwind City
    .accept 1448 >>Accept In Search of The Temple

-- Stranglethorn Vale #1 --
step
    .goto Stranglethorn Vale,27.6,76.8
    .target Fin Fizracket
    >>Talk to |cRXP_FRIENDLY_Fin Fizracket|r in Booty Bay
    .accept 348 >>Accept Stranglethorn Fever
step
    .goto Stranglethorn Vale,35.2,60.4
    >>Kill |cRXP_ENEMY_Mokk the Savage|r in Stranglethorn Vale for the |cRXP_LOOT_Heart of Mokk|r
    .complete 348,1 >>Stranglethorn Fever
    .unitscan Mokk the Savage
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    .goto Stranglethorn Vale,47.6,44.2
    >>Kill |cRXP_ENEMY_Mogh the Undying|r in Stranglethorn Vale for the |cRXP_LOOT_The Legacy Heart|r
    .complete 735,3 >>The Star, The Hand, and the Heart
    .mob Mogh the Undying

-- SWAMP OF SORROWS #1 --
step
    .goto Swamp of Sorrows,69,44
    >>Search for the |cRXP_FRIENDLY_Temple of Atal'Hakkar|r in the Swamp of Sorrows
    .complete 1448,1 >>In Search of The Temple

-- STORMWIND CITY #2 --
step
    .goto Stormwind City,64.2,20.8
    .target Brohann Caskbelly
    >>Talk to |cRXP_FRIENDLY_Brohann Caskbelly|r in Stormwind City
    .turnin 1448 >>Turn in In Search of The Temple
    .accept 1449 >>Accept To The Hinterlands

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
step
    .goto The Hinterlands,26.8,48.6
    .target Rhapsody Shindigger
    >>Talk to |cRXP_FRIENDLY_Rhapsody Shindigger|r in The Hinterlands
    .turnin 1451 >>Turn in Rhapsody Shindigger
    .accept 1452 >>Accept Rhapsody's Kalimdor Kocktail

-- DUSTWALLOW MARSH #1 --
step
    .goto Dustwallow Marsh,63.6,7.0
    >>Kill |cRXP_ENEMY_Mirefin Oracles|r in Dustwallow Marsh for the |cRXP_LOOT_Enchanted Sea Kelp|r
    .collect 4639,1,735,2 >>The Star, The Hand, and the Heart
    .mob Mirefin Oracle
step
    .goto Dustwallow Marsh,59.4,9.6
    .use 4639
    >>Summon and Kill |cRXP_ENEMY_Dagun the Ravenous|r in Dustwallow Marsh for the |cRXP_LOOT_Hand of Dagun|r
    .complete 735,2 >>The Star, The Hand, and the Heart
    .unitscan Dagun the Ravenous
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    .goto Dustwallow Marsh,29.8,48.2
    >>Click the |cRXP_FRIENDLY_Theramore Guard Badge|r in Dustwallow Marsh
    .accept 1252 >>Accept Lieutenant Paval Reethe
step
    .goto Dustwallow Marsh,68.2,48.6
    .target Captain Garran Vimes
    >>Talk to |cRXP_FRIENDLY_Captain Garran Vimes|r in Theramore
    .turnin 1252 >>Turn in Lieutenant Paval Reethe
    >>|cRXP_WARN_DON'T ACCEPT THE NEXT QUEST - THIS IS YOUR BREADCRUMB.|r

-- TANARIS #1 --
step
    .goto Tanaris,50.6,33.8
    >>Kill |cRXP_ENEMY_Rocs|r in Tanaris for |cRXP_LOOT_Roc Gizzards|r
    .complete 1452,1 >>Rhapsody's Kalimdor Kocktail
    .mob Roc
    .mob Fire Roc
    .mob Searing Roc
step
    .goto Tanaris,29.6,60.6
    .target Tooga
    >>Talk to |cRXP_FRIENDLY_Tooga|r in Thistleshrub Valley
    .accept 1560 >>Accept Tooga's Quest
step
    .goto Tanaris,66.6,25.6
    .target Torta
    >>Escort |cRXP_FRIENDLY_Tooga|r to Torta near Steamwheedle Port
    .complete 1560,1 >>Tooga's Quest
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- FERALAS #1 --
step
    .goto Feralas,30.4,46.0
    .target Latronicus Moonspear
    >>Talk to |cRXP_FRIENDLY_Latronicus Moonspear|r in Feathermoon Stronghold
    .accept 4124 >>Accept The Missing Courier
step
    .goto Feralas,31.8,45.2
    .target Ginro Hearthkindle
    >>Talk to |cRXP_FRIENDLY_Ginro Hearthkindle|r in Feathermoon Stronghold
    .turnin 4124 >>Turn in The Missing Courier
    .accept 4125 >>Accept The Missing Courier
step
    .goto Feralas,45.5,64.9
    .target Wrecked Row Boat
    >>Click the |cRXP_FRIENDLY_Wrecked Row Boat|r in Feralas
    .turnin 4125 >>Turn in Boat Wreckage
    .accept 4127 >>Accept Boat Wreckage
step
    .goto Feralas,31.8,45.2
    .target Ginro Hearthkindle
    >>Talk to |cRXP_FRIENDLY_Ginro Hearthkindle|r in Feathermoon Stronghold
    .turnin 4127 >>Turn in Boat Wreckage
    .accept 4129 >>Accept The Knife Revealed
step
    .goto Feralas,32.4,43.8
    .target Quintis Jonespyre
    >>Talk to |cRXP_FRIENDLY_Quintis Jonespyre|r in Feathermoon Stronghold
    .turnin 4129 >>Turn in The Knife Revealed
    .accept 4130 >>Accept Psychometric Reading
step
    .goto Feralas,31.8,45.2
    .target Ginro Hearthkindle
    >>Talk to |cRXP_FRIENDLY_Ginro Hearthkindle|r in Feathermoon Stronghold
    .turnin 4130 >>Turn in Psychometric Reading
    .accept 4131 >>Accept The Woodpaw Gnolls
step
    .goto Feralas,73.3,56.3
    .target Large Leather Backpacks
    >>Click the |cRXP_FRIENDLY_Large Leather Backpacks|r in Feralas
    .turnin 4131 >>Turn in The Woodpaw Gnolls
    .accept 4135 >>Accept The Writhing Deep
step
    .goto Feralas,72.1,63.8
    .target Zukk'ash Pod
    >>Click the |cRXP_FRIENDLY_Zukk'ash Pod|r in Feralas
    .turnin 4135 >>Turn in The Writhing Deep
    .accept 4265 >>Accept Freed from the Hive
    >>Free |cRXP_FRIENDLY_Raschal|r from the Zukk'ash Pod
    .complete 4265,1 >>Freed from the Hive
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    .goto Feralas,78.8,46.6,5,0
    .goto Feralas,50.2,49.6
    >>Kill |cRXP_ENEMY_Ironfur Bears|r in Feralas for |cRXP_LOOT_Ironfur Livers|r
    .complete 1452,2 >>Rhapsody's Kalimdor Kocktail
    .mob Ironfur Bear
    .mob Grizzled Ironfur Bear
    >>Kill |cRXP_ENEMY_Groddoc Apes|r in Feralas for |cRXP_LOOT_Groddoc Livers|r
    .complete 1452,3 >>Rhapsody's Kalimdor Kocktail
    .mob Groddoc Ape
    .mob Groddoc Thunderer

-- THE HINTERLANDS #2 --
step
    .goto The Hinterlands,26.8,48.6
    .target Rhapsody Shindigger
    >>Talk to |cRXP_FRIENDLY_Rhapsody Shindigger|r in The Hinterlands
    .turnin 1452 >>Turn in Rhapsody's Kalimdor Kocktail
    .accept 1469 >>Accept Rhapsody's Tale

-- STORMWIND CITY #3 --
step
    .goto Stormwind City,64.2,20.8
    .target Brohann Caskbelly
    >>Talk to |cRXP_FRIENDLY_Brohann Caskbelly|r in Stormwind City
    .turnin 1469 >>Turn in Rhapsody's Tale
    .accept 1475 >>Accept Into the Temple of Atal'Hakkar

-- SWAMP OF SORROWS #2 --
step
    .goto Swamp of Sorrows,70.0,55.1
    >>Loot |cRXP_LOOT_Atal'ai Tablets|r inside the Sunken Temple entrance (outside the instance) 
    .complete 1475,1 >>Into the Temple of Atal'Hakkar
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_This guide is actively being developed|r
    >>There is no guarantee it will be finished before Phase 3 launch.
    +Check back later for updates
]])

RXPGuides.RegisterGuide([[
#classic
#version 2
<< Alliance
#group Custom Quests for RXP
#subgroup SoD Level 40 Quest Stacking
#name 40-3-Launch Day Turn-in Route
#displayname 3-Launch Day Turn-in Route

step
    #sticky
    +|cRXP_WARN_WARNING: ONLY LOAD THIS GUIDE ON LAUNCH DAY, DO NOT ACCIDENTALLY TURN IN YOUR PRE QUESTS|r
step
    >>|cRXP_WARN_LEVEL 40 ALLIANCE QUEST STACK|r
    >>This is a community guide that may have ERRORS.
    >>I recommend testing on the PTR prior to Phase 3 launch.
    +|cRXP_PICK_I understand|r
step
    .isOnQuest 2781
    .goto Tanaris,52.4,28.4
    .target Chief Engineer Bilgewhizzle
    >>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r in Gadgetzan
    .turnin 2781 >>Turn in Wanted: Caliph Scorpidsting
step
    .isOnQuest 10
    .goto Tanaris,50.2,27.4
    .target Senior Surveyor Fizzledowser
    >>Talk to |cRXP_FRIENDLY_Senior Surveyor Fizzledowser|r in Gadgetzan
    .turnin 10 >>Turn in The Scrimshank Redemption
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
    .isOnQuest 1691
    .goto Tanaris,52.4,28.4
    .target Chief Engineer Bilgewhizzle
    >>Talk to |cRXP_FRIENDLY_Chief Engineer Bilgewhizzle|r in Gadgetzan
    .turnin 1691 >>Turn in More Wastewander Justice
step
    .itemcount 8483,5
    .goto Tanaris,52.4,28.4
    .target Spigot Operator Luglunket
    >>Talk to |cRXP_FRIENDLY_Spigot Operator Luglunket|r in Gadgetzan
    .accept 1707 >>Accept Water Pouch Bounty
    .turnin 1707 >>Turn in Water Pouch Bounty
step
    .fly in Feathermoon Stronghold
    .goto Tanaris,51.0,29.2
    .target Bera Stonehammer
step
    .isOnQuest 4265
    .goto Feralas,31.8,45.2
    .target Ginro Hearthkindle
    >>Talk to |cRXP_FRIENDLY_Ginro Hearthkindle|r in Feathermoon Stronghold
    .turnin 4265 >>Turn in Freed from the Hive
step
    .isQuestTurnedIn 4265
    .goto Feralas,31.8,45.2
    .target Ginro Hearthkindle
    >>Talk to |cRXP_FRIENDLY_Ginro Hearthkindle|r in Feathermoon Stronghold
    .accept 4266 >>Accept A Hero's Welcome
step
    .isOnQuest 4266
    .goto Feralas,30.2,46.0
    .target Shandris Feathermoon
    >>Talk to |cRXP_FRIENDLY_Shandris Feathermoon|r in Feathermoon Stronghold
    .turnin 4266 >>Turn in A Hero's Welcome
step
    .isQuestTurnedIn 4266
    .goto Feralas,30.2,46.0
    .target Shandris Feathermoon
    >>Talk to |cRXP_FRIENDLY_Shandris Feathermoon|r in Feathermoon Stronghold
    .accept 4267 >>Accept Rise of the Silithid
step
    .isQuestTurnedIn 2870
    .goto Feralas,30.4,46.0
    .target Latronicus Moonspear
    >>Talk to |cRXP_FRIENDLY_Latronicus Moonspear|r in Feathermoon Stronghold
    .accept 2871 >>Accept Delivering the Relic
step
    .isOnQuest 2871
    .goto Feralas,30.0,45.0
    .target Vestia Moonspear
    >>Talk to |cRXP_FRIENDLY_Vestia Moonspear|r in Feathermoon Stronghold
    .turnin 2871 >>Turn in Delivering the Relic
step
    .itemcount 18969,1
    >>Use the Pristine Yeti Hide to Accept the quest
    .use 18969
    .accept 7735 >>Accept Pristine Yeti Hide
    .goto Feralas,30.6,42.6
step
    .isOnQuest 7735
    .goto Feralas,30.6,42.6
    .target Pratt McGrubben
    >>Talk to |cRXP_FRIENDLY_Pratt McGrubben|r in Feathermoon Stronghold
    .accept 7735 >>Accept Pristine Yeti Hide
step
    .isOnQuest 7733
    .goto Feralas,30.6,42.6
    .target Pratt McGrubben
    >>Talk to |cRXP_FRIENDLY_Pratt McGrubben|r in Feathermoon Stronghold
    .turnin 7733 >>Turn in Improved Quality
step
    .fly Nijel's Point
    .goto Feralas,30.2,43.2
    .target Fyldren Moonfeather
step
    .isQuestTurnedIn 1466
    .goto Desolace,66.2,9.6
    .target Kreldig Ungor
    >>Talk to |cRXP_FRIENDLY_Kreldig Ungor|r Nijel's Point
    .accept 1467 >>Accept Reagents for Reclaimers Inc
step
    .isQuestTurnedIn 1456
    .goto Desolace,66.2,9.6
    .target Kreldig Ungor
    >>Talk to |cRXP_FRIENDLY_Kreldig Ungor|r Nijel's Point
    .accept 1457 >>Accept The Karnitol Shipwreck
step
    .fly Rut'Theran Village
    .goto Desolace,64.6,10.6
    .target Baritanas Skyriver
step
    .goto Darnassus,63.8,22.8
    .target Raedon Duskstriker
    >>Talk to |cRXP_FRIENDLY_Raedon Duskstriker|r in Darnassus
    .turnin 7792 >>Turn in A Donation of Wool
    .turnin 7798 >>Turn in A Donation of Silk
    .turnin 7799 >>Turn in A Donation of Mageweave
step
    .isOnQuest 4267
    .goto Darnassus,42.0,85.8
    .target Gracina Spiritmight
    >>Talk to |cRXP_FRIENDLY_Gracina Spiritmight|r in Darnassus
    .turnin 4267 >>Turn in Rise of the Silithid
step
    .isOnQuest 3378
    .goto Darnassus,38.6,80.8
    .target Astarii Starseeke
    >>Talk to |cRXP_FRIENDLY_Astarii Starseeke|r in Darnassus
    .turnin 3378 >>Turn in Prayer to Elune
step
    .goto Darnassus,39.8,42.6
    .target Idriana
    >>Talk to |cRXP_FRIENDLY_Idriana|r in Darnassus
    .bankwithdraw 3712,10005 >>Withdraw any needed items from your bank
step
    .hs >>Hearth to Aerie Peak, Hinterlands
step
    .isOnQuest 2877
    .goto The Hinterlands,14.8,44.6
    .target Fraggar Thundermantle
    >>Talk to |cRXP_FRIENDLY_Fraggar Thundermantle|r in Aerie Peak
    .turnin 2877 >>Turn in Skulk Rock Clean-up
step
    .isQuestTurnedIn 2989
    .goto The Hinterlands,9.8,44.6
    .target Gryphon Master Talonaxe
    >>Talk to |cRXP_FRIENDLY_Gryphon Master Talonaxe|r in Aerie Peak
    .accept 2990 >>Accept Thadius Grimshade
step
    .fly Refuge Point
    .goto The Hinterlands,11.0,46.0
    .target Guthrum Thunderfist
step
    .goto Arathi Highlands,46.0,45.2
    .target Samuel Hawke
    >>Talk to |cRXP_FRIENDLY_Samuel Hawke|r at Refuge Point
    .accept 8261 >>Accept Arathor Standard Care Package
    .turnin 8261 >>Turn in Arathor Standard Care Package
step
    .isQuestTurnedIn 696
    .goto Arathi Highlands,46.6,47.0
    .target Skuerto
    >>Talk to |cRXP_FRIENDLY_Skuerto|r at Refuge Point
    .accept 697 >>Accept Malin's Request
step
    .isQuestTurnedIn 660
    .goto Arathi Highlands,60.2,53.8
    .target Quae
    >>Talk to |cRXP_FRIENDLY_Quae|r at Go'Shek Farm
    .accept 661 >>Accept Hints of a New Plague?
step
    .isOnQuest 656
    .goto Arathi Highlands,62.5,33.8
    .target Shards of Myzrael
    >>Click the |cRXP_FRIENDLY_Shards of Myzrael|r in Arathi Highlands
    .turnin 656 >>Turn in Summoning the Princess
step
    .fly Southshore
    .goto Arathi Highlands,45.6,46.0
    .target Cedrik Prose
step
    .isOnQuest 1053
    .goto Hillsbrad Foothills,51.4,58.6
    .target Raleigh the Devout
    >>Talk to |cRXP_FRIENDLY_Raleigh the Devout|r in Southshore
    .turnin 1053 >>Turn in In the Name of the Light
step
    .isOnQuest 504
    .goto Hillsbrad Foothills,49.6,58.6
    .target Marshal Redpath
    >>Talk to |cRXP_FRIENDLY_Marshal Redpath|r in Southshore
    .turnin 504 >>Turn in Crushridge Warmongers
step
    .isOnQuest 661
    .goto Hillsbrad Foothills,50.2,58.8
    .target Phin Odelic
    >>Talk to |cRXP_FRIENDLY_Phin Odelic|r in Southshore
    .turnin 661 >>Turn in Hints of a New Plague?
step
    .itemcount 3712,10
    .goto Hillsbrad Foothills,51.8,58.6
    .target Chef Jessen
    >>Talk to |cRXP_FRIENDLY_Chef Jessen|r in Southshore
    .accept 555 >>Accept Soothing Turtle Bisque
    .turnin 555 >>Turn in Soothing Turtle Bisque
step
    .isQuestTurnedIn 511
    .goto Hillsbrad Foothills,50.6,57.0
    .target Loremaster Dibbs
    >>Talk to |cRXP_FRIENDLY_Loremaster Dibbs|r in Southshore
    .accept 514 >>Accept Letter to Stormpike
step
    .fly Thelsamar
    .goto Hillsbrad Foothills,49.4,52.6
    .target Darla Harris
step
    .home >>Set your hearthstone at Stoutlager Inn, Loch Modan
step
    .itemcount 10005,1
    >>Use Margol's Horn to Accept the quest
    .use 10005
    .accept 3181 >>Accept The Horn of the Beast
    .goto Loch Modan,18.2,83.8
step
    .isOnQuest 3181
    .goto Loch Modan,18.2,83.8
    .target Mountaineer Pebblebitty
    >>Talk to |cRXP_FRIENDLY_Mountaineer Pebblebitty|r in Loch Modan
    .turnin 3181 >>Turn in The Horn of the Beast
step
    .isQuestTurnedIn 3181
    .goto Loch Modan,18.2,83.8
    .target Mountaineer Pebblebitty
    >>Talk to |cRXP_FRIENDLY_Mountaineer Pebblebitty|r in Loch Modan
    .accept 3182 >>Accept Proof of Deed
step
    .fly Ironforge
    .goto Loch Modan,33.8,50.8
    .target Thorgrum Borrelson
step
    .isOnQuest 1467
    .goto Ironforge,68.2,17.4
    .target Roetten Stonehammer
    >>Talk to |cRXP_FRIENDLY_Roetten Stonehammer|r in The Hall of Explorers
    .turnin 1467 >>Turn in Reagents for Reclaimers Inc
step
    .isOnQuest 1457
    .goto Ironforge,68.2,17.4
    .target Roetten Stonehammer
    >>Talk to |cRXP_FRIENDLY_Roetten Stonehammer|r in The Hall of Explorers
    .turnin 1457 >>Turn in The Karnitol Shipwreck
step
    .isOnQuest 514
    .goto Ironforge,74.6,12.0
    .target Prospector Stormpike
    >>Talk to |cRXP_FRIENDLY_Prospector Stormpike|r in The Hall of Explorers
    .turnin 514 >>Turn in Letter to Stormpike
step
    .goto Ironforge,74.6,12.0
    .target Prospector Stormpike
    >>Talk to |cRXP_FRIENDLY_Prospector Stormpike|r in The Hall of Explorers
    .accept 707 >>Accept Ironband Wants You!
step
    .isOnQuest 2240
    .goto Ironforge,74.6,12.0
    .target Prospector Stormpike
    >>Talk to |cRXP_FRIENDLY_Prospector Stormpike|r in The Hall of Explorers
    .turnin 2240 >>Turn in The Hidden Chamber
step
    .isOnQuest 3182
    .goto Ironforge,71.6,14.4
    .target Curator Thorius
    >>Talk to |cRXP_FRIENDLY_Curator Thorius|r in The Hall of Explorers
    .turnin 3182 >>Turn in Proof of Deed
step
    .isQuestTurnedIn 3182
    .goto Ironforge,71.6,14.4
    .target Curator Thorius
    >>Talk to |cRXP_FRIENDLY_Curator Thorius|r in The Hall of Explorers
    .accept 3201 >>Accept At Last!
step
    .isOnQuest 2279
    .goto Ironforge,69.8,18.4
    .target High Explorer Magellas
    >>Talk to |cRXP_FRIENDLY_High Explorer Magellas|r in The Hall of Explorers
    .turnin 2279 >>Turn in The Platinum Discs
step
    .isQuestTurnedIn 2279
    .goto Ironforge,69.8,18.4
    .target High Explorer Magellas
    >>Talk to |cRXP_FRIENDLY_High Explorer Magellas|r in The Hall of Explorers
    .accept 2439 >>Accept The Platinum Discs
step
    .isOnQuest 735
    .goto Ironforge,50.6,6.2
    .target Gerrig Bonegrip
    >>Talk to |cRXP_FRIENDLY_Gerrig Bonegrip|r in the Forlorn Cavern
    .turnin 735 >>Turn in The Star, The Hand, and the Heart
step
    .isQuestTurnedIn 735
    .goto Ironforge,50.6,6.2
    .target Gerrig Bonegrip
    >>Talk to |cRXP_FRIENDLY_Gerrig Bonegrip|r in the Forlorn Cavern
    .accept 737 >>Accept Forbidden Knowledge
step
    .goto Ironforge,43.6,33.2
    .target Mistina Steelshield
    >>Talk to |cRXP_FRIENDLY_Mistina Steelshield|r in Ironforge
    .turnin 7802 >>Turn in A Donation of Wool
    .turnin 7803 >>Turn in A Donation of Silk
    .turnin 7804 >>Turn in A Donation of Mageweave
step
    .goto Ironforge,60.4,38.0
    .target Daryl Riknussun
    >>Talk to |cRXP_FRIENDLY_Daryl Riknussun|r in Ironforge
    .accept 6612 >>Accept I Know A Guy...
step
    .goto Ironforge,54.8,58.6
    .target Nissa Firestone
    >>Talk to |cRXP_FRIENDLY_Nissa Firestone|r in Ironforge
    .accept 6625 >>Accept Alliance Trauma
step
    .isOnQuest 2439
    .goto Ironforge,33.8,60.6
    .target Dinita Stonemantle
    >>Talk to |cRXP_FRIENDLY_Dinita Stonemantle|r in The Commons
    .turnin 2439 >>Turn in The Platinum Discs
step
    .zone 226 >>Head to Gnomeregan
step
    .itemcount 9308,1
    .target The Sparklematic 5200
    >>Click |cRXP_FRIENDLY_The Sparklematic 5200|r inside Gnomeregan
    .accept 80161 >>Accept The Sparklematic 5200!
    .turnin 80161 >>Turn in The Sparklematic 5200!
step
    .itemcount 216661,1
    >>Use the Grime-Encrusted Ring to Accept the quest
    .use 216661
    .accept 79986 >>Accept Grime-Encrusted Ring
step
    .isOnQuest 79986
    .target The Sparklematic 5200
    >>Click |cRXP_FRIENDLY_The Sparklematic 5200|r inside Gnomeregan
    .turnin 79986 >>Turn in Grime-Encrusted Ring
step
    .zone Loch Modan >>Drop group inside Gnomeregan to Ghetto Hearth to Loch Modan
step
    .isOnQuest 3201
    .goto Loch Modan,18.2,83.8
    .target Mountaineer Pebblebitty
    >>Talk to |cRXP_FRIENDLY_Mountaineer Pebblebitty|r in the Valley of the Kings
    .turnin 3201 >>Turn in At Last!
step
    .isOnQuest 707
    .goto Loch Modan,65.8,65.6
    .target Prospector Ironband
    >> |cRXP_FRIENDLY_Prospector Ironband|r at Ironband's Excavation Site
    .turnin 707 >>Turn in Ironband Wants You!
step
    .isQuestTurnedIn 707
    .goto Loch Modan,65.8,65.6
    .target Prospector Ironband
    >> |cRXP_FRIENDLY_Prospector Ironband|r at Ironband's Excavation Site
    .accept 738 >>Accept Find Agmond
step
    .zone Badlands >>Head to Hammertoe's Digsite, Badlands
step
    .isQuestTurnedIn 723
    .goto Badlands,53.4,43.6
    .target Prospector Ryedol
    >>Talk to |cRXP_FRIENDLY_Prospector Ryedol|r in the Badlands
    .accept 724 >>Accept Prospect of Faith
step
    .isOnQuest 717
    .goto Badlands,61.8,54.8
    .target Garek
    >>Talk to |cRXP_FRIENDLY_Garek|r in the Badlands
    .turnin 717 >>Turn in Tremors of the Earth
step
    .isOnQuest 737
    .goto Badlands,51.4,76.8
    .target Theldurin the Lost
    >>Talk to |cRXP_FRIENDLY_Theldurin the Lost|r in the Badlands
    .turnin 737 >>Turn in Forbidden Knowledge
step
    .isOnQuest 738
    .goto Badlands,50.9,62.5
    .target Battered Dwarven Skeleton
    >>Click the |cRXP_FRIENDLY_Battered Dwarven Skeleton|r in the Badlands
    .turnin 738 >>Turn in Find Agmond
step
    .itemcount 4611,9
    .goto Badlands,42.4,52.8
    .target Rigglefuzz
    >>Talk to |cRXP_FRIENDLY_Rigglefuzz|r in the Badlands
    .accept 705 >>Accept Pearl Diving
    .turnin 705 >>Turn in Pearl Diving
step
    .itemcount 3404,4
    .goto Badlands,42.4,52.8
    .target Rigglefuzz
    >>Talk to |cRXP_FRIENDLY_Rigglefuzz|r in the Badlands
    .accept 703 >>Accept Barbecued Buzzard Wings
    .turnin 703 >>Turn in Barbecued Buzzard Wings
step
    .isQuestTurnedIn 1108
    .goto Badlands,42.2,52.6
    .target Martek the Exiled
    >>Talk to |cRXP_FRIENDLY_Martek the Exiled|r in the Badlands
    .accept 1137 >>Accept News for Fizzle
step
    .itemcount 3829,1
    .goto Badlands,26.0,45.8
    .target Lotwil Veriatus
    >>Talk to |cRXP_FRIENDLY_Lotwil Veriatus|r in the Badlands
    .accept 713 >>Accept Coolant Heads Prevail
    .turnin 713 >>Turn in Coolant Heads Prevail
step
    .itemcount 4389,1
    .goto Badlands,26.0,45.8
    .target Lotwil Veriatus
    >>Talk to |cRXP_FRIENDLY_Lotwil Veriatus|r in the Badlands
    .accept 714 >>Accept Gyro... What?
    .turnin 714 >>Turn in Gyro... What?
step
    .isQuestTurnedIn 712
    .isQuestTurnedIn 714
    .itemcount 929,1
    .itemcount 3823,1
    .goto Badlands,25.8,44.6
    .target Lucien Tosselwrench
    >>Talk to |cRXP_FRIENDLY_Lucien Tosselwrench|r in the Badlands
    .accept 715 >>Accept Liquid Stone
    .turnin 715 >>Turn in Liquid Stone
step
    .isQuestTurnedIn 712
    .isQuestTurnedIn 714
    .itemcount 2868,1
    .goto Badlands,25.8,44.6
    .target Lucien Tosselwrench
    >>Talk to |cRXP_FRIENDLY_Lucien Tosselwrench|r in the Badlands
    .accept 716 >>Accept Stone Is Better than Cloth
    .turnin 716 >>Turn in Stone Is Better than Cloth
step
    .isQuestTurnedIn 712
    .isQuestTurnedIn 714
    .goto Badlands,26.0,45.8
    .target Lotwil Veriatus
    >>Talk to |cRXP_FRIENDLY_Lotwil Veriatus|r in the Badlands
    .accept 734 >>Accept This Is Going to Be Hard
step
    .isOnQuest 734
    .goto Badlands,25.8,44.6
    .target Lucien Tosselwrench
    >>Talk to |cRXP_FRIENDLY_Lucien Tosselwrench|r in the Badlands
    .turnin 734 >>Turn in This Is Going to Be Hard
step
    .isQuestTurnedIn 734
    .goto Badlands,25.8,44.6
    .target Lucien Tosselwrench
    >>Talk to |cRXP_FRIENDLY_Lucien Tosselwrench|r in the Badlands
    .accept 777 >>Accept This Is Going to Be Hard
step
    .isOnQuest 777
    .goto Badlands,26.0,45.8
    .target Lotwil Veriatus
    >>Talk to |cRXP_FRIENDLY_Lotwil Veriatus|r in the Badlands
    .turnin 777 >>Turn in This Is Going to Be Hard
step
    #completewith next
    .zone Ironforge >>Head to Ironforge
step
    .isOnQuest 724
    .goto Ironforge,77.2,11.8
    .target Historian Karnik
    >>Talk to |cRXP_FRIENDLY_Historian Karnik|r in The Hall of Explorers
    .turnin 724 >>Turn in Prospect of Faith
step
    >>The remainder of this guide is unfinished
    +See the maps in Joardee's Patreon sheet
]])