RXPGuides.RegisterGuide([[
#classic
#version 3
<< Alliance
#group Custom Quests for RXP
#subgroup SoD Level 25 Quest Stacking
#name 25-1-How to Use this Guide
#displayname 1-How to Use this Guide
#next 25-2-Pre-Launch Collection Guide

-- |cRXP_FRIENDLY_, |cRXP_ENEMY_, |cRXP_LOOT_, |cRXP_WARN_, |cRXP_PICK_, |cRXP_BUY_
-- |c99ffff99 OR|r
-- |Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk

step
    >>Welcome to the |cRXP_WARN_SoD Level 25|r Quest Stacking Guide!
    +Use the Collection Guide to complete pre-req quests and gather items for launch day.
    +|cRXP_WARN_ON LAUNCH DAY|r, use the Turn-in Guide.
]])

RXPGuides.RegisterGuide([[
#classic
#version 3
<< Alliance
#group Custom Quests for RXP
#subgroup SoD Level 25 Quest Stacking
#name 25-2-Pre-Launch Collection Guide
#displayname 2-Pre-Launch Collection Guide
#next 25-3-Launch Day Turn-in Route

step
    .maxlevel 19
    >>|cRXP_WARN_NOTE|r: This guide is for |cRXP_WARN_HIGHER LEVEL|r characters.
    .xp 20
step
    >>|cRXP_WARN_LEVEL 25 ALLIANCE QUEST STACK|r
    >>This guide is for collection prior to launch day.
    +Only turn-in specified quests in this guide.
    +Other quests are left in your quest log for launch day.
    >>|cRXP_WARN_NOTE|r: This is an |cRXP_PICK_EXPERIMENTAL|r route. For more details, check
    .link https://www.patreon.com/joardee >>Joardee's Patreon spreadsheet
step
    >>|cRXP_WARN_WARNING PLEASE READ CAREFULLY!!!!|r
    >>Many quest addons auto-turn-in quests (INCLUDING THIS ONE).
    >>It is your responsibility to safeguard your Launch Day quests.
    +|cRXP_PICK_I understand|r
    >>|cRXP_WARN_PRO TIP|r: Store turn-in items in the bank to prevent accidental turn-in.

-- DUSKWOOD --
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    .goto Duskwood,75.8,45.2
    .target Madame Eva
    >>Talk to |cRXP_FRIENDLY_Madame Eva|r in Darkshire
    .accept 66 >>The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    .goto Duskwood,72.6,46.8
    .target Clerk Daltry
    >>Talk to |cRXP_FRIENDLY_Clerk Daltry|r in Darkshire
    .turnin 66 >>The Legend of Stalvan
    .accept 67 >>The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,75.2,48.6
    .target Elaine Carevin
    >>Talk to |cRXP_FRIENDLY_Elaine Carevin|r in Darkshire
    .accept 165 >>Accept The Hermit
step
    >>|cRXP_WARN_MAIN QUEST - Worgen in the Woods|r
    .goto Duskwood,75.6,47.6
    .target Calor
    >>Talk to |cRXP_FRIENDLY_Calor|r in Darkshire
    .accept 173 >>Accept Worgen in the Woods

-- WESTFALL --
step
    >>|cRXP_WARN_MAIN QUEST - Dry Times|r
    >>Gather or Buy |cRXP_BUY_5 Hops|r from the Auction House 
    .complete 117,1 >>Dry Times
step
    >>|cRXP_WARN_MAIN QUEST - The Defias Brotherhood|r
    .goto Westfall,56.2,47.6
    .target Gryan Stoutmantle
    >>Talk to |cRXP_FRIENDLY_Gryan Stoutmantle|r at Sentinel Hill
    .accept 65 >>Accept The Defias Brotherhood
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    .goto Westfall,41.5,66.8
    >>Click the |cRXP_FRIENDLY_Old Footlocker|r in Moonbrook, Westfall
    .turnin 67 >>The Legend of Stalvan
    .accept 68 >>The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - Dry Times|r
    .goto Westfall,44.6,80.2
    .target Grimbooze Thunderbrew
    >>Talk to |cRXP_FRIENDLY_Grimbooze Thunderbrew|r 
    .accept 117 >>Accept Thunderbrew
    .turnin 117 >>Turn in Thunderbrew
    >>|cRXP_WARN_NOTE|r: Hops drop from mechanical mobs in Westfall.
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Westfall,42.56,71.53
    >>Kill |cRXP_ENEMY_Edwin VanCleef|r inside the Deadmines for |cRXP_LOOT_An Unsent Letter|r
    .mob Edwin VanCleef
    .accept 373 >>Accept The Unsent Letter
    .use 2874

-- DUSKWOOD --
step
    #sticky
    >>|cRXP_WARN_MAIN QUEST - Preserving Knowledge|r
    >>- Farm the |cRXP_LOOT_Old History Book|r (can drop from any mob in Duskwood)
    .accept 337 >>Accept An Old History Book
    .use 2794
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Duskwood,7.8,34.0
    .target Sven Yorgen
    >>Talk to |cRXP_FRIENDLY_Sven Yorgen|r at the camp NW of Raven Hill
    .accept 95 >>Sven's Revenge
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,28.0,31.6
    .target Abercrombie
    >>Talk to |cRXP_FRIENDLY_Abercrombie|r in the shack near Raven Hill cemetery
    .turnin 165 >>Turn in The Hermit
    .accept 148 >>Accept Supplies from Darkshire
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Duskwood,49.8,77.9
    >>Click the |cRXP_FRIENDLY_Mound of loose dirt|r in South Duskwood
    .turnin 95 >>Sven's Revenge
    .accept 230 >>Sven's Camp
step
    >>|cRXP_WARN_MAIN QUEST - Worgen in the Woods|r
    .goto Duskwood,60.0,72.4
    >>Kill |cRXP_ENEMY_Nightbane Shadow Weavers|r in Duskwood
    .complete 173,1 >>Worgen in the Woods
    .mob Nightbane Shadow Weaver
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    .goto Duskwood,72.6,46.8
    .target Clerk Daltry
    >>Talk to |cRXP_FRIENDLY_Clerk Daltry|r in Darkshire
    .turnin 68 >>The Legend of Stalvan
    .accept 69 >>The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - Worgen in the Woods|r
    .goto Duskwood,75.6,47.6
    .target Calor
    >>Talk to |cRXP_FRIENDLY_Calor|r in Darkshire
    .turnin 173 >>Turn in Worgen in the Woods
    .accept 221 >>Accept Worgen in the Woods
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,75.8,45.2
    .target Madame Eva
    >>Talk to |cRXP_FRIENDLY_Madame Eva|r in Darkshire
    .turnin 148 >>Turn in Supplies from Darkshire
    .accept 149 >>Accept Ghost Hair Thread
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,81.8,59.2
    .target Blind Mary
    >>Talk to |cRXP_FRIENDLY_Blind Mary|r SE of Darkshire
    .turnin 149 >>Turn in Ghost Hair Thread
    .accept 154 >>Accept Return the Comb
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,75.8,45.2
    .target Madame Eva
    >>Talk to |cRXP_FRIENDLY_Madame Eva|r in Darkshire
    .turnin 154 >>Turn in Return the Comb
    .accept 157 >>Accept Deliver the Thread
step
    >>|cRXP_WARN_MAIN QUEST - Worgen in the Woods|r
    .goto Duskwood,60.0,72.4
    >>Kill |cRXP_ENEMY_Nightbane Dark Runners|r in Duskwood
    .complete 221,1 >>Worgen in the Woods
    .mob Nightbane Dark Runner
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,28.0,31.6
    .target Abercrombie
    >>Talk to |cRXP_FRIENDLY_Abercrombie|r in the shack near Raven Hill cemetery
    .turnin 157 >>Turn in Deliver the Thread
    .accept 158 >>Accept Zombie Juice
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Duskwood,7.8,34.0
    .target Sven Yorgen
    >>Talk to |cRXP_FRIENDLY_Sven Yorgen|r at the camp NW of Raven Hill
    .turnin 230 >>Sven's Camp
    .accept 262 >>The Shadowy Figure
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Duskwood,75.8,45.2
    .target Madame Eva
    >>Talk to |cRXP_FRIENDLY_Madame Eva|r in Darkshire
    .turnin 262 >>The Shadowy Figure
    .accept 265 >>The Shadowy Search Continues
step
    >>|cRXP_WARN_MAIN QUEST - Worgen in the Woods|r
    .goto Duskwood,75.6,47.6
    .target Calor
    >>Talk to |cRXP_FRIENDLY_Calor|r in Darkshire
    .turnin 221 >>Turn in Worgen in the Woods
    .accept 222 >>Accept Worgen in the Woods
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Duskwood,72.6,46.8
    .target Clerk Daltry
    >>Talk to |cRXP_FRIENDLY_Clerk Daltry|r in Darkshire
    .turnin 265 >>The Shadowy Search Continues
    .accept 266 >>Accept Inquire at the Inn
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Duskwood,74.0,44.8
    .target Tavernkeep Smitts
    >>Talk to |cRXP_FRIENDLY_Tavernkeep Smitts|r in Darkshire
    .turnin 266 >>Inquire at the Inn
    .accept 453 >>Accept Finding the Shadowy Figure
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,74.0,44.8
    .target Tavernkeep Smitts
    >>Talk to |cRXP_FRIENDLY_Tavernkeep Smitts|r in Darkshire
    .turnin 158 >>Turn in Zombie Juice
    .accept 156 >>Accept Gather Rot Blossoms
step
    >>|cRXP_WARN_MAIN QUEST - Worgen in the Woods|r
    .goto Duskwood,74.2,78.2
    >>Kill |cRXP_ENEMY_Worgens|r in Duskwood
    .complete 222,1 >>Worgen in the Woods
    .complete 222,2
    .mob Nightbane Vile Fang
    .mob Nightbane Tainted One
step
    >>|cRXP_WARN_MAIN QUEST - Dusky Crab Cakes|r
    .goto Duskwood,18.4,56.6
    .target Jitters
    >>Talk to |cRXP_FRIENDLY_Jitters|r at Raven Hill
    .accept 5 >>Accept Jitters' Growling Gut
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Duskwood,18.4,56.6
    .target Jitters
    >>Talk to |cRXP_FRIENDLY_Jitters|r at Raven Hill
    .turnin 453 >>Turn in Finding the Shadowy Figure
    .accept 268 >>Accept Return to Sven
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,16.2,45.8
    >>Kill |cRXP_ENEMY_Skeletal Mobs|r in Raven Hill Cemetery for the |cRXP_LOOT_Rot Blossoms|r
    .complete 156,1 >>Gather Rot Blossoms
    .mob Skeletal Horror
    .mob Skeletal Fiend
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Duskwood,7.8,34.0
    .target Sven Yorgen
    >>Talk to |cRXP_FRIENDLY_Sven Yorgen|r at the camp NW of Raven Hill
    .turnin 268 >>Turn in Return to Sven
    .accept 323 >>Accept Proving Your Worth
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Duskwood,15.8,38.0
    >>Kill |cRXP_ENEMY_Skeletal Mobs|r in Raven Hill Cemetery
    .complete 323,1 >>Proving Your Worth
    .complete 323,2
    .complete 323,3
    .mob Skeletal Raider
    .mob Skeletal Healer
    .mob Skeletal Warder
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Duskwood,7.8,34.0
    .target Sven Yorgen
    >>Talk to |cRXP_FRIENDLY_Sven Yorgen|r at the camp NW of Raven Hill
    .turnin 323 >>Turn in Proving Your Worth
    .accept 269 >>Accept Seeking Wisdom

-- ELWYNN FOREST / STORMWIND --
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    .goto Elwynn Forest,43.8,65.8
    .target Innkeeper Farley
    >>Talk to |cRXP_FRIENDLY_Innkeeper Farley|r in Goldshire, Elwynn Forest
    .turnin 69 >>The Legend of Stalvan
    .accept 70 >>The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - Dry Times|r
    .goto Elwynn Forest,43.8,65.8
    .target Barkeep Dobbins
    >>Buy a |cRXP_BUY_Skin of Sweet Rum|r from Barkeep Dobbins in Goldshire
    .complete 116,4 >>Dry Times
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    .goto Elwynn Forest,44.29,65.82
    >>Loot |cRXP_LOOT_An Undelivered Letter|r from the Storage Chest upstairs in the Goldshire Inn
    .complete 70,1 >>The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - A Noble Brew|r
    .goto Stormwind City,26.4,78.4
    .target Zardeth of the Black Claw
    >>Talk to |cRXP_FRIENDLY_Zardeth of the Black Claw|r in the Basement of The Slaughtered Lamb, Stormwind
    .accept 335 >>Accept A Noble Brew
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    .goto Stormwind City,30.0,61.4
    .target Caretaker Folsom
    >>Talk to |cRXP_FRIENDLY_Caretaker Folsom|r in Stormwind
    .turnin 70 >>The Legend of Stalvan
    .accept 72 >>The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    .goto Stormwind City,29.6,61.8
    >>Click the |cRXP_FRIENDLY_Sealed Crate|r in Stormwind
    .turnin 72 >>The Legend of Stalvan
    .accept 74 >>The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Stormwind City,39.6,28.6
    .target Bishop Farthing
    >>Talk to |cRXP_FRIENDLY_Bishop Farthing|r in Cathedral Square, Stormwind
    .turnin 269 >>Turn in Seeking Wisdom
    .accept 270 >>Accept The Doomed Fleet
step
    >>|cRXP_WARN_MAIN QUEST - Rethban Ore|r
    .goto Stormwind City,45.8,38.6
    .target Brother Kristoff
    >>Talk to |cRXP_FRIENDLY_Brother Kristoff|r in Cathedral Square
    .accept 343 >>Accept Speaking of Fortitude
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Stormwind City,49.0,30.2
    .target Baros Alexston
    >>Talk to |cRXP_FRIENDLY_Baros Alexston|r in Cathedral Square
    .turnin 373 >>Turn in The Unsent Letter
    .accept 389 >>Accept Bazil Thredd
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Stormwind City,41.2,58.0
    .target Warden Thelwater
    >>Talk to |cRXP_FRIENDLY_Warden Thelwater|r outside the Stockades
    .turnin 389 >>Turn in Bazil Thredd
    .accept 391 >>Accept The Stockade Riots
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Stormwind City,39.99,54.59
    >>Kill |cRXP_ENEMY_Bazil Thredd|r inside the Stockades for the |cRXP_LOOT_Head of Bazil Thredd|r
    .complete 391,1 >>The Stockade Riots
    .mob Bazil Thredd
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Stormwind City,41.2,58.0
    .target Warden Thelwater
    >>Talk to |cRXP_FRIENDLY_Warden Thelwater|r outside the Stockades
    .turnin 391 >>Turn in The Stockade Riots
    .accept 392 >>Accept The Curious Visitor
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Stormwind City,49.0,30.2
    .target Baros Alexston
    >>Talk to |cRXP_FRIENDLY_Baros Alexston|r in Cathedral Square
    .turnin 392 >>Turn in The Curious Visitor
    .accept 393 >>Accept Shadow of the Past
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Stormwind City,75.8,59.8
    .target Master Mathias Shaw
    >>Talk to |cRXP_FRIENDLY_Master Mathias Shaw|r in Old Town
    .turnin 393 >>Turn in Shadow of the Past
    .accept 350 >>Accept Look to an Old Friend
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Stormwind City,60.0,64.4
    .target Elling Trias
    >>Talk to |cRXP_FRIENDLY_Elling Trias|r in the Cheese Shop
    .turnin 350 >>Turn in Look to an Old Friend
    .accept 2745 >>Accept Infiltrating the Castle
step
    >>|cRXP_WARN_MAIN QUEST - Rethban Ore|r
    .goto Stormwind City,74.0,7.6
    .target Milton Sheaf
    >>Talk to |cRXP_FRIENDLY_Milton Sheaf|r in Stormwind Keep
    .turnin 343 >>Turn in Speaking of Fortitude
    .accept 344 >>Accept Brother Paxton
step
    >>|cRXP_WARN_MAIN QUEST - Preserving Knowledge|r
    .goto Stormwind City,74.0,7.6
    .target Milton Sheaf
    >>Talk to |cRXP_FRIENDLY_Milton Sheaf|r in Stormwind Keep
    .turnin 337 >>Turn in An Old History Book
    .accept 538 >>Accept Southshore
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Stormwind City,69.2,14.6
    .target Tyrion
    >>Talk to |cRXP_FRIENDLY_Tyrion|r in Stormwind Keep
    .turnin 2745 >>Turn in Infiltrating the Castle
    .accept 2746 >>Accept Items of Some Consequence
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    >>Buy |cRXP_BUY_3 Silk Cloth|r from the Auction House 
    .complete 2746,1 >>Brotherhood's End
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Elwynn Forest,34.0,57.2
    >>Loot |cRXP_LOOT_Clara's Fresh Apples|r from the table inside the house, outside Stormwind
    .complete 2746,2 >>Items of Some Consequence
step
    >>|cRXP_WARN_MAIN QUEST - Rethban Ore|r
    .goto Elwynn Forest,49.6,40.4
    .target Brother Paxton
    >>Talk to |cRXP_FRIENDLY_Brother Paxton|r in Northshire Valley, Elwynn Forest
    .turnin 344 >>Turn in Brother Paxton
    .accept 345 >>Accept Ink Supplies
step
    >>|cRXP_WARN_MAIN QUEST - Morganth|r
    .goto Elwynn Forest,65.2,69.8
    .target Theocritus
    >>Talk to |cRXP_FRIENDLY_Theocritus|r atop the Tower of Azora, Elwynn Forest
    .accept 94 >>Accept A Watchful Eye
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    .goto Elwynn Forest,84.6,69.6
    .target Marshal Haggard
    >>Talk to |cRXP_FRIENDLY_Marshal Haggard|r in the Eastvale Logging Camp
    .turnin 74 >>The Legend of Stalvan
    .accept 75 >>The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    .goto Elwynn Forest,85.6,69.6
    >>Loot |cRXP_LOOT_A Faded Journal Page|r from the Marshal Haggard's Chest upstairs in the house
    .complete 75,1 >>The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    .goto Elwynn Forest,84.6,69.6
    .target Marshal Haggard
    >>Talk to |cRXP_FRIENDLY_Marshal Haggard|r in the Eastvale Logging Camp
    .turnin 75 >>The Legend of Stalvan
    .accept 78 >>The Legend of Stalvan

-- REDRIDGE MOUNTAINS --
step
    >>|cRXP_WARN_MAIN QUEST - Rethban Ore|r
    .goto Redridge Mountains,32.2,48.6
    .target Foreman Oslow
    >>Talk to |cRXP_FRIENDLY_Foreman Oslow|r in Lakeshire, Redridge Mountains
    .turnin 345 >>Turn in Ink Supplies
step
    >>|cRXP_WARN_MAIN QUEST - Wanted: Lieutenant Fangore|r
    .goto Redridge Mountains,26.7,46.6
    >>Click on the |cRXP_FRIENDLY_Wanted Poster|r outside the Lakeshire Inn, Redridge Mountains
    .accept 180 >>Accept Wanted: Lieutenant Fangore
step
    >>|cRXP_WARN_MAIN QUEST - The Defias Brotherhood|r
    .goto Redridge Mountains,26.6,45.2
    .target Wiley the Black
    >>Talk to |cRXP_FRIENDLY_Wiley the Black|r in Lakeshire
    .turnin 65 >>Turn in The Defias Brotherhood
    >>|cRXP_WARN_DON'T ACCEPT THE FOLLOW-UP QUEST|r
step
    >>|cRXP_WARN_MAIN QUEST - Wanted: Gath'Ilzogg|r
    .goto Redridge Mountains,29.6,46.5
    >>Click on the |cRXP_FRIENDLY_Wanted Poster|r outside the town hall in Lakeshire, Redridge Mountains
    .accept 169 >>Accept Wanted: Gath'Ilzogg
step
    >>|cRXP_WARN_MAIN QUEST - Wanted: Gath'Ilzogg|r
    .goto Redridge Mountains,69.4,55.4
    >>Kill |cRXP_ENEMY_Gath'Ilzogg|r inside Stormwatch Keep, Redridge Mountains for the |cRXP_LOOT_Head of Gath'Ilzogg|r
    .complete 169,1 >>Wanted: Gath'Ilzogg
    .mob Gath'Ilzogg
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_MAIN QUEST - Morganth|r
    .goto Redridge Mountains,84.5,47.1
    >>Click the |cRXP_FRIENDLY_Old Lion Statue|r in East Redridge Mountains
    .turnin 94 >>Turn in A Watchful Eye
    .accept 248 >>Accept Looking Further
step
    >>|cRXP_WARN_MAIN QUEST - Morganth|r
    .goto Redridge Mountains,63.2,49.7
    >>Click |cRXP_FRIENDLY_An Empty Jar|r in the watch tower beside Stonewatch Keep, Redridge Mountains
    .turnin 248 >>Turn in Looking Further
step
    >>|cRXP_WARN_MAIN QUEST - Morganth|r
    .goto Redridge Mountains,84.5,47.1
    >>Click the |cRXP_FRIENDLY_Old Lion Statue|r in East Redridge Mountains
    .accept 249 >>Accept Morganth
step
    >>|cRXP_WARN_MAIN QUEST - Morganth|r
    .goto Redridge Mountains,79.2,47.8
    >>Kill |cRXP_ENEMY_Morganth|r atop the Tower of Ilgalar, Redridge Mountains for the |cRXP_LOOT_Pendant of Shadow|r
    .complete 249,1 >>Morganth
    .mob Morganth
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_MAIN QUEST - Theocritus' Retrieval|r
    .goto Redridge Mountains,78.6,38.6
    >>Kill |cRXP_ENEMY_Shadowhide Gnolls|r in Redridge Mountains for the |cRXP_LOOT_Glowing Shadowhide Pendant|r
    .collect 1962,1
    .mob Shadowhide Warrior
    .mob Shadowhide Slayer
    .mob Shadowhide Brute
    .mob Shadowhide Assassin
    .mob Shadowhide Darkweaver
    >>|cRXP_WARN_SAVE THE ITEM FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_MAIN QUEST - Wanted: Lieutenant Fangore|r
    .goto Redridge Mountains,78.6,38.6
    >>Kill |cRXP_ENEMY_Lieutenant Fangore|r for |cRXP_LOOT_Fangore's Paw|r
    .complete 180,1 >>Wanted: Lieutenant Fangore
    .unitscan Lieutenant Fangore
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_MAIN QUEST - Rethban Ore|r
    .goto Redridge Mountains,20.0,20.6
    >>Kill |cRXP_ENEMY_Redridge Drudgers|r in Redridge for |cRXP_LOOT_Rethban Ore|r
    .collect 2798,5
    .mob Redridge Drudger
    >>|cRXP_WARN_NOTE|r: You can also buy the ore on the AH. Save the ore for Launch day.

-- DUSKWOOD --
step
    >>|cRXP_WARN_MAIN QUEST - Dusky Crab Cakes|r
    .goto Duskwood,73.8,43.6
    .target Chef Grual
    >>Talk to |cRXP_FRIENDLY_Chef Grual|r in Darkshire
    .turnin 5 >>Turn in Jitters' Growling Gut
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,74.0,44.8
    .target Tavernkeep Smitts
    >>Talk to |cRXP_FRIENDLY_Tavernkeep Smitts|r in Darkshire
    .turnin 156 >>Turn in Gather Rot Blossoms
    .accept 159 >>Accept Juice Delivery
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    .goto Duskwood,74.0,44.8
    .target Tavernkeep Smitts
    >>Talk to |cRXP_FRIENDLY_Tavernkeep Smitts|r in Darkshire
    .turnin 78 >>The Legend of Stalvan
    .accept 79 >>The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    >>Talk to |cRXP_FRIENDLY_Commander Althea Ebonlocke|r in Darkshire, Duskwood
    .goto Duskwood,73.6,46.8
    .target Commander Althea Ebonlocke
    .turnin 79 >>Turn in The Legend of Stalvan
    .accept 80 >>Accept The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - Worgen in the Woods|r
    .goto Duskwood,75.6,47.6
    .target Calor
    >>Talk to |cRXP_FRIENDLY_Calor|r in Darkshire
    .turnin 222 >>Turn in Worgen in the Woods
    >>|cRXP_WARN_DON'T ACCEPT THE FOLLOW-UP QUEST|r
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    >>Talk to |cRXP_FRIENDLY_Clerk Daltry|r in Darkshire, Duskwood
    .goto Duskwood,72.6,46.8
    .target Clerk Daltry
    .turnin 80 >>Turn in The Legend of Stalvan
    .accept 97 >>Accept The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    >>Talk to |cRXP_FRIENDLY_Commander Althea Ebonlocke|r in Darkshire, Duskwood
    .goto Duskwood,73.6,46.8
    .turnin 97 >>Turn in The Legend of Stalvan
    .accept 98 >>Accept The Legend of Stalvan
step
    >>|cRXP_WARN_MAIN QUEST - The Legend of Stalvan|r
    .goto Duskwood,77.6,35.8
    >>Kill |cRXP_ENEMY_Stalvan Mistmantle|r in Duskwood for the |cRXP_LOOT_Mistmantle Family Ring|r
    .complete 98,1 >>The Legend of Stalvan
    .mob Stalvan Mistmantle
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_MAIN QUEST - A Noble Brew|r
    .goto Duskwood,78.5,36.0
    >>Loot |cRXP_LOOT_Tear of Tilloa|r from the garden in Duskwood
    .complete 335,1 >>A Noble Brew

-- IRONFORGE --
step
    >>|cRXP_WARN_MAIN QUEST - Knowledge in the Deep|r
    .goto Ironforge,50.6,6.2
    .target Gerrig Bonegrip
    >>Talk to |cRXP_FRIENDLY_Gerrig Bonegrip|r in the Forlorn Cavern in Ironforge
    .accept 78923 >>Accept Knowledge in the Deep

-- WETLANDS --
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Wetlands,10.6,60.6
    .target Glorin Steelbrow
    >>Talk to |cRXP_FRIENDLY_Glorin Steelbrow|r at Menethil Harbor
    .turnin 270 >>Turn in The Doomed Fleet
    .accept 321 >>Accept Lightforge Iron
step
    >>|cRXP_WARN_MAIN QUEST - Blisters on The Land|r
    .goto Wetlands,10.8,59.6
    .target First Mate Fitzsimmons
    >>Talk to |cRXP_FRIENDLY_First Mate Fitzsimmons|r at Menethil Harbor
    .accept 463 >>Accept The Greenwarden
    .accept 288 >>Accept The Third Fleet
step
    >>|cRXP_WARN_MAIN QUEST - Cleansing the Eye|r
    .goto Wetlands,10.6,60.8
    .target Innkeeper Helbrek
    >>Buy a |cRXP_BUY_Flagon of Dwarven Honeymead|r from Innkeeper Helbrek at Menethil Harbor
    .complete 288,1 >>The Third Fleet
step
    >>|cRXP_WARN_MAIN QUEST - Cleansing the Eye|r
    .goto Wetlands,10.8,59.6
    .target First Mate Fitzsimmons
    >>Talk to |cRXP_FRIENDLY_First Mate Fitzsimmons|r at Menethil Harbor
    .turnin 288 >>Turn in The Third Fleet
    .accept 289 >>Accept The Cursed Crew
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Wetlands,12.1,64.1
    >>Click the |cRXP_FRIENDLY_Waterlogged Chest|r aboard The Flying Osprey
    .turnin 321 >>Turn in Lightforge Iron
    .accept 324 >>Accept The Lost Ingots
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Wetlands,8.0,70.2
    >>Kill |cRXP_ENEMY_Bluegill Raiders|r in Menethil Harbor for the |cRXP_LOOT_Lightforge Ingots|r
    .complete 324,1 >>The Lost Ingots
    .mob Bluegill Raider
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Wetlands,10.6,60.6
    .target Glorin Steelbrow
    >>Talk to |cRXP_FRIENDLY_Glorin Steelbrow|r at Menethil Harbor
    .turnin 324 >>Turn in The Lost Ingots
    .accept 322 >>Accept Blessed Arm
step
    >>|cRXP_WARN_MAIN QUEST - Ormer's Revenge|r
    .goto Wetlands,38.0,51.2
    .target Ormer Ironbraid
    >>Talk to |cRXP_FRIENDLY_Ormer Ironbraid|r at Whelgar's Excavation Site in Wetlands
    .accept 294 >>Accept Ormer's Revenge
step
    >>|cRXP_WARN_MAIN QUEST - Ormer's Revenge|r
    .goto Wetlands,26.6,44.8
    >>Kill |cRXP_ENEMY_Raptors|r in the Wetlands
    .complete 294,1 >>Ormer's Revenge
    .complete 294,2
    .mob Mottled Raptor
    .mob Mottled Screecher
step
    >>|cRXP_WARN_MAIN QUEST - Ormer's Revenge|r
    .goto Wetlands,38.0,51.2
    .target Ormer Ironbraid
    >>Talk to |cRXP_FRIENDLY_Ormer Ironbraid|r at Whelgar's Excavation Site in Wetlands
    .turnin 294 >>Turn in Ormer's Revenge
    .accept 295 >>Accept Ormer's Revenge
step
    >>|cRXP_WARN_MAIN QUEST - Ormer's Revenge|r
    .goto Wetlands,34.6,47.2
    >>Kill |cRXP_ENEMY_Raptors|r at Whelgar's Excavation Site in Wetlands
    .complete 295,1 >>Ormer's Revenge
    .complete 295,2
    .mob Mottled Scytheclaw
    .mob Mottled Razormaw
step
    >>|cRXP_WARN_MAIN QUEST - Ormer's Revenge|r
    .goto Wetlands,38.0,51.2
    .target Ormer Ironbraid
    >>Talk to |cRXP_FRIENDLY_Ormer Ironbraid|r at Whelgar's Excavation Site in Wetlands
    .turnin 295 >>Turn in Ormer's Revenge
    .accept 296 >>Accept Ormer's Revenge
step
    >>|cRXP_WARN_MAIN QUEST - Ormer's Revenge|r
    .goto Wetlands,33.0,51.2
    >>Kill |cRXP_ENEMY_Sarltooth|r at Whelgar's Excavation Site in Wetlands for the |cRXP_LOOT_Sarltooth's Talon|r
    .complete 296,1 >>Ormer's Revenge
    .unitscan Sarltooth
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_MAIN QUEST - Blisters on The Land|r
    .goto Wetlands,56.2,40.6
    .target Rethiel the Greenwarden
    >>Talk to |cRXP_FRIENDLY_Rethiel the Greenwarden|r in Wetlands
    .turnin 463 >>Turn in The Greenwarden
    .accept 276 >>Accept Tramping Paws
step
    >>|cRXP_WARN_MAIN QUEST - Blisters on The Land|r
    .goto Wetlands,64.0,63.6
    >>Kill |cRXP_ENEMY_Mosshide mobs|r in Southeast Wetlands
    .complete 276,1 >>Tramping Paws
    .complete 276,2
    .mob Mosshide Gnoll
    .mob Mosshide Mongrel
step
    >>|cRXP_WARN_MAIN QUEST - A Noble Brew|r
    .goto Wetlands,64.7,75.5
    >>Loot |cRXP_LOOT_Musquash Root|r near the waterfall in Wetlands
    .complete 335,2 >>A Noble Brew
step
    >>|cRXP_WARN_MAIN QUEST - Blisters on The Land|r
    .goto Wetlands,56.2,40.6
    .target Rethiel the Greenwarden
    >>Talk to |cRXP_FRIENDLY_Rethiel the Greenwarden|r in Wetlands
    .turnin 276 >>Turn in Tramping Paws
step
    >>|cRXP_WARN_MAIN QUEST - Blisters on The Land|r
    .goto Wetlands,56.2,40.6
    .target Rethiel the Greenwarden
    >>Talk to |cRXP_FRIENDLY_Rethiel the Greenwarden|r in Wetlands
    .accept 277 >>Accept Fire Taboo
step
    >>|cRXP_WARN_MAIN QUEST - Blisters on The Land|r
    .goto Wetlands,27.0,35.2
    >>Kill |cRXP_ENEMY_Mosshide mobs|r in Wetlands for |cRXP_LOOT_Crude Flint|r
    .complete 277,1 >>Fire Taboo
    .mob Mosshide Brute
    .mob Mosshide Trapper
    .mob Mosshide Fenrunner
    .mob Mosshide Mistweaver
    .mob Mosshide Mystic
    .mob Mosshide Alpha
step
    >>|cRXP_WARN_MAIN QUEST - Blisters on The Land|r
    .goto Wetlands,56.2,40.6
    .target Rethiel the Greenwarden
    >>Talk to |cRXP_FRIENDLY_Rethiel the Greenwarden|r in Wetlands
    .turnin 277 >>Turn in Fire Taboo
step
    >>|cRXP_WARN_MAIN QUEST - Blisters on The Land|r
    .goto Wetlands,56.2,40.6
    .target Rethiel the Greenwarden
    >>Talk to |cRXP_FRIENDLY_Rethiel the Greenwarden|r in Wetlands
    .accept 275 >>Accept Blisters on The Land
step
    >>|cRXP_WARN_MAIN QUEST - Blisters on The Land|r
    .goto Wetlands,17.8,27.6
    >>Kill |cRXP_ENEMY_Fen Creepers|r around the ponds in Wetlands
    .complete 275,1 >>Blisters on The Land
    .mob Fen Creeper
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_MAIN QUEST - Cleansing the Eye|r
    .goto Wetlands,14.0,29.8
    >>Kill |cRXP_ENEMY_Cursed mobs|r in Wetlands
    >>Kill |cRXP_ENEMY_First Mate Snelling|r for the |cRXP_LOOT_Snellig's Snuffbox|r
    .complete 289,1 >>The Cursed Crew
    .complete 289,2
    .complete 289,3
    .mob Cursed Sailor
    .mob Cursed Marine
    .mob First Mate Snellig
step
    >>|cRXP_WARN_MAIN QUEST - Cleansing the Eye|r
    .goto Wetlands,10.8,59.6
    .target First Mate Fitzsimmons
    >>Talk to |cRXP_FRIENDLY_First Mate Fitzsimmons|r at Menethil Harbor
    .turnin 289 >>Turn in The Cursed Crew
    .accept 290 >>Accept Lifting the Curse
step
    >>|cRXP_WARN_MAIN QUEST - Cleansing the Eye|r
    .goto Wetlands,15.6,23.4
    >>Kill |cRXP_ENEMY_Captain Halyndor|r in Wetlands for the |cRXP_LOOT_Intrepid Strongbox Key|r
    .complete 290,1 >>Lifting the Curse
    .unitscan Captain Halyndor
step
    >>|cRXP_WARN_MAIN QUEST - Cleansing the Eye|r
    .goto Wetlands,14.5,24.0
    >>Click on the |cRXP_FRIENDLY_Intrepid's Locked Strongbox|r at the bottom of the ship
    .turnin 290 >>Turn in Lifting the Curse
    .accept 292 >>Accept The Eye of Paleth
step
    >>|cRXP_WARN_MAIN QUEST - Cleansing the Eye|r
    .goto Wetlands,10.6,60.6
    .target Glorin Steelbrow
    >>Talk to |cRXP_FRIENDLY_Glorin Steelbrow|r at Menethil Harbor
    .turnin 292 >>Turn in The Eye of Paleth
    >>|cRXP_WARN_DON'T ACCEPT THE FOLLOW-UP QUEST|r
step
    >>|cRXP_WARN_MAIN QUEST - The Fury Runs Deep|r
    .goto Wetlands,49.6,18.2
    .target Motley Garmason
    >>Talk to |cRXP_FRIENDLY_Motley Garmason|r outside Dun Modr, Wetlands
    .accept 303 >>Accept The Dark Iron War
step
    >>|cRXP_WARN_MAIN QUEST - The Fury Runs Deep|r
    .goto Wetlands,46.4,16.4
    >>Kill |cRXP_ENEMY_Dark Iron Dwarfs|r at Dun Modr, Wetlands
    .complete 303,1 >>The Dark Iron War
    .complete 303,2
    .complete 303,3
    .complete 303,4
    .mob Dark Iron Dwarf
    .mob Dark Iron Tunneler
    .mob Dark Iron Saboteur
    .mob Dark Iron Demolitionist
step
    >>|cRXP_WARN_MAIN QUEST - The Fury Runs Deep|r
    .goto Wetlands,49.6,18.2
    .target Motley Garmason
    >>Talk to |cRXP_FRIENDLY_Motley Garmason|r outside Dun Modr, Wetlands
    .turnin 303 >>Turn in The Dark Iron War
step
    >>|cRXP_WARN_MAIN QUEST - The Fury Runs Deep|r
    .goto Wetlands,49.6,18.2
    .target Motley Garmason
    >>Talk to |cRXP_FRIENDLY_Motley Garmason|r outside Dun Modr, Wetlands
    .accept 378 >>Accept The Fury Runs Deep
step
    >>|cRXP_WARN_MAIN QUEST - Sully Balloo's Letter|r
    .goto Arathi Highlands,44.3,92.9
    >>Loot the |cRXP_LOOT_Waterlogged Envelope|r underwater between Wetlands and Arathi Highlands
    .collect 4433,1
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY ACCEPT + TURN-IN|r

-- SOUTHSHORE / ALTERAC MOUNTAINS --
step
    >>|cRXP_WARN_MAIN QUEST - Reassignment|r
    .goto Hillsbrad Foothills,51.4,58.6
    .target Lieutenant Farren Orinelle
    >>Talk to |cRXP_FRIENDLY_Lieutenant Farren Orinelle|r in Southshore
    .accept 536 >>Accept Down the Coast
step
    >>|cRXP_WARN_MAIN QUEST - Reassignment|r
    .goto Hillsbrad Foothills,38.6,68.8
    >>Kill |cRXP_ENEMY_Murlocs|r along the coast of Southshore
    .complete 536,1 >>Down the Coast
    .complete 536,2
    .mob Torn Fin Tidehunter
    .mob Torn Fin Oracle
step
    >>|cRXP_WARN_MAIN QUEST - Reassignment|r
    .goto Hillsbrad Foothills,51.4,58.6
    .target Lieutenant Farren Orinelle
    >>Talk to |cRXP_FRIENDLY_Lieutenant Farren Orinelle|r in Southshore
    .turnin 536 >>Turn in Down the Coast
    .accept 559 >>Accept Farren's Proof
step
    >>|cRXP_WARN_MAIN QUEST - Reassignment|r
    .goto Hillsbrad Foothills,38.6,68.8
    >>Kill |cRXP_ENEMY_Murlocs|r along the coast of Southshore for |cRXP_LOOT_Murloc Heads|r
    .complete 559,1 >>Farren's Proof
    .mob Torn Fin Tidehunter
    .mob Torn Fin Coastrunner
    .mob Torn Fin Muckdweller
    .mob Torn Fin Oracle
step
    >>|cRXP_WARN_MAIN QUEST - Reassignment|r
    .goto Hillsbrad Foothills,51.4,58.6
    .target Lieutenant Farren Orinelle
    >>Talk to |cRXP_FRIENDLY_Lieutenant Farren Orinelle|r in Southshore
    .turnin 559 >>Turn in Farren's Proof
step
    >>|cRXP_WARN_MAIN QUEST - Reassignment|r
    .goto Hillsbrad Foothills,49.6,58.6
    .target Marshal Redpath
    >>Talk to |cRXP_FRIENDLY_Marshal Redpath|r in Southshore
    .turnin 560 >>Turn in Farren's Proof
    .accept 561 >>Accept Farren's Proof
step
    >>|cRXP_WARN_MAIN QUEST - Reassignment|r
    .goto Hillsbrad Foothills,51.4,58.6
    .target Lieutenant Farren Orinelle
    >>Talk to |cRXP_FRIENDLY_Lieutenant Farren Orinelle|r in Southshore
    .turnin 561 >>Turn in Farren's Proof
    .accept 562 >>Accept Stormwind Ho!
step
    >>|cRXP_WARN_MAIN QUEST - Reassignment|r
    .goto Hillsbrad Foothills,58.6,70.0
    >>Kill |cRXP_ENEMY_Nagas|r along the coast of Southshore
    .complete 562,1 >>Stormwind Ho!
    .complete 562,2
    .mob Daggerspine Shorehunter
    .mob Daggerspine Siren
step
    >>|cRXP_WARN_MAIN QUEST - Reassignment|r
    .goto Hillsbrad Foothills,51.4,58.6
    .target Lieutenant Farren Orinelle
    >>Talk to |cRXP_FRIENDLY_Lieutenant Farren Orinelle|r in Southshore
    .turnin 562 >>Turn in Stormwind Ho!
    >>|cRXP_WARN_DON'T ACCEPT THE FOLLOW-UP QUEST|r
step
    >>|cRXP_WARN_MAIN QUEST - Preserving Knowledge|r
    .goto Hillsbrad Foothills,50.6,57.0
    .target Loremaster Dibbs
    >>Talk to |cRXP_FRIENDLY_Loremaster Dibbs|r in Southshore
    .turnin 538 >>Turn in Southshore
    .accept 540 >>Accept Preserving Knowledge
step
    >>|cRXP_WARN_MAIN QUEST - Preserving Knowledge|r
    .goto Alterac Mountains,38.5,46.5
    >>Kill |cRXP_ENEMY_Crushridge Ogres|r in Alterac Mountains for |cRXP_LOOT_Recovered Tomes|r
    .complete 540,1 >>Preserving Knowledge
    .mob Crushridge Ogre
    .mob Crushridge Brute
    >>Loot the |cRXP_LOOT_Worn Leather Book|r from the Weathered Bookcase in the Ruins of Alterac
    .complete 540,2 >>Preserving Knowledge
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- STORMWIND --
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Stormwind City,51.6,12.6
    .target Grimand Elmore
    >>Talk to |cRXP_FRIENDLY_Grimand Elmore|r in the Dwarven District, Stormwind
    .turnin 322 >>Turn in Blessed Arm
    .accept 325 >>Accept Armed and Ready
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Stormwind City,69.2,14.6
    .target Tyrion
    >>Talk to |cRXP_FRIENDLY_Tyrion|r in Stormwind Keep
    .turnin 2746 >>Turn in Items of Some Consequence
    .accept 434 >>Accept The Attack!
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Stormwind City,69.2,14.6
    .mob Lord Gregor Lescovar
    .mob Marzon the Silent Blade
    >>Listen to the conversation of |cRXP_ENEMY_Lescovar and Marzon|r
    >>Then Kill |cRXP_ENEMY_Lescovar and Marzon|r
    .complete 434,1 >>The Attack!
    .complete 434,2
    .complete 434,3
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Stormwind City,60.0,64.4
    .target Elling Trias
    >>Talk to |cRXP_FRIENDLY_Elling Trias|r in the Cheese Shop
    .turnin 434 >>Turn in The Attack!
    .accept 394 >>Accept The Head of the Beast
step
    >>|cRXP_WARN_MAIN QUEST - Brotherhood's End|r
    .goto Stormwind City,75.8,59.8
    .target Master Mathias Shaw
    >>Talk to |cRXP_FRIENDLY_Master Mathias Shaw|r in Old Town
    .turnin 394 >>Turn in The Head of the Beast
    >>|cRXP_WARN_DON'T ACCEPT THE FOLLOW-UP QUEST|r
step
    >>|cRXP_WARN_MAIN QUEST - The Fury Runs Deep|r
    .goto Stormwind City,40.01,54.63
    >>Kill |cRXP_ENEMY_Kam Deepfury|r inside The Stockade for the |cRXP_LOOT_Head of Deepfury|r
    .complete 378,1 >>The Fury Runs Deep
    .mob Kam Deepfury
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    .isOnQuest 335
    >>|cRXP_WARN_MAIN QUEST - A Noble Brew|r
    .goto Stormwind City,26.4,78.4
    .target Zardeth of the Black Claw
    >>Talk to |cRXP_FRIENDLY_Zardeth of the Black Claw|r in the Basement of The Slaughtered Lamb, Stormwind
    +Turn in A Noble Brew -- 335
    >>|cRXP_WARN_SAVE THIS QUEST FOR TURN-IN IF YOUR ARE USING IT AS A BACKUP|r

-- DUSKWOOD --
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Duskwood,7.8,34.0
    .target Sven Yorgen
    >>Talk to |cRXP_FRIENDLY_Sven Yorgen|r at the camp NW of Raven Hill, Duskwood
    .turnin 325 >>Turn in Armed and Ready
    .accept 55 >>Accept Morbent Fel
step
    >>|cRXP_WARN_MAIN QUEST - Morbent Fel|r
    .goto Duskwood,17.6,33.4
    .use 7297
    >>Use Morbent's Bane and
    >>Kill |cRXP_ENEMY_Morbent Fel|r in Duskwood
    .complete 55,1 >>Morbent Fel
    .mob Morbent Fel
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,28.0,31.6
    .target Abercrombie
    >>Talk to |cRXP_FRIENDLY_Abercrombie|r in the shack near Raven Hill cemetery
    .turnin 159 >>Turn in Juice Delivery
    .accept 133 >>Accept Ghoulish Effigy
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,22.2,37
    >>Kill |cRXP_ENEMY_Undead Mobs|r Ghoul Ribs
    .complete 133,1 >>Ghoulish Effigy
    .mob Flesh Eater
    .mob Bone Chewer
    .mob Plague Spreader
    .mob Rotted One
    .mob Brain Eater
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,28.0,31.6
    .target Abercrombie
    >>Talk to |cRXP_FRIENDLY_Abercrombie|r in the shack near Raven Hill cemetery
    .turnin 133 >>Turn in Ghoulish Effigy
    .accept 134 >>Accept Ogre Thieves
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,33.5,76.5
    >>Loot |cRXP_LOOT_Abercrombie's Crate|r from the Crate in the Ogre Mound Area
    .complete 134,1 >>Ogre Thieves
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,28.0,31.6
    .target Abercrombie
    >>Talk to |cRXP_FRIENDLY_Abercrombie|r in the shack near Raven Hill cemetery
    .turnin 134 >>Turn in Ogre Thieves
    .accept 160 >>Accept Note to the Mayor
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,72.0,46.6
    .target Lord Ello Ebonlocke
    >>Talk to |cRXP_FRIENDLY_Lord Ello Ebonlocke|r in Darkshire
    .turnin 160 >>Turn in Note to the Mayor
    .accept 251 >>Accept Translate Abercrombie's Note
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,72.6,47.6
    .target Sirra Von'Indi
    >>Talk to |cRXP_FRIENDLY_Sirra Von'Indi|r in Darkshire
    .turnin 251 >>Turn in Translate Abercrombie's Note
    .accept 401 >>Accept Wait for Sirra to Finish
    .turnin 401 >>Turn in Wait for Sirra to Finish
    .accept 252 >>Accept Translation to Ello
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,72.0,46.6
    .target Lord Ello Ebonlocke
    >>Talk to |cRXP_FRIENDLY_Lord Ello Ebonlocke|r in Darkshire
    .turnin 252 >>Turn in Translation to Ello
    .accept 253 >>Accept Bride of the Embalmer
step
    >>|cRXP_WARN_MAIN QUEST - Dry Times|r
    .goto Duskwood,73.8,44.2
    .target Barkeep Hann
    >>Buy a |cRXP_BUY_Bottle of Moonshine|r from Barkeep Hann in Darkshire
    .complete 116,3 >>Dry Times
step
    >>|cRXP_WARN_MAIN QUEST - Bride of the Embalmer|r
    .goto Duskwood,28.8,31.0
    >>Kill |cRXP_ENEMY_Eliza|r in Raven Hill Cemetery for the |cRXP_LOOT_The Embalmer's Heart|r
    .complete 253,1 >>Bride of the Embalmer
    .mob Eliza
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- DARNASSUS / DARKSHORE --
step
    >>|cRXP_WARN_MAIN QUEST - Twilight Falls|r
    .goto Darnassus,55.2,23.6
    .target Argent Guard Manados
    >>Talk to |cRXP_FRIENDLY_Argent Guard Manados|r in Darnassus
    .accept 78925 >>Accept Twilight Falls
step
    >>|cRXP_WARN_MAIN QUEST - Baron Aquanis|r
    .goto Darkshore,36.8,43.6
    .target Davius Voidstar
    >>Talk to |cRXP_FRIENDLY_Davius Voidstar|r in Auberdine, Darkshore
    .accept 79099 >>Accept Baron Aquanis
step
    >>|cRXP_WARN_MAIN QUEST - The Absent Minded Prospector|r
    .goto Darkshore,37.6,41.8
    .target Archaeologist Hollee
    >>Talk to |cRXP_FRIENDLY_Archaeologist Hollee|r in Auberdine, Darkshore
    .accept 729 >>Accept The Absent Minded Prospector
step
    >>|cRXP_WARN_MAIN QUEST - Researching the Corruption|r
    .goto Darkshore,38.4,43.0
    .target Gershala Nightwhisper
    >>Talk to |cRXP_FRIENDLY_Gershala Nightwhisper|r in Auberdine, Darkshore
    .accept 78926 >>Accept Researching the Corruption
step
    >>|cRXP_WARN_MAIN QUEST - Supplies to Auberdine|r
    .goto Darkshore,39.0,43.4
    .target Sentinel Elissa Starbreeze
    >>Talk to |cRXP_FRIENDLY_Sentinel Elissa Starbreeze|r in Auberdine, Darkshore
    .accept 965 >>Accept The Tower of Althalaxx
step
    >>|cRXP_WARN_MAIN QUEST - Supplies to Auberdine|r
    .goto Darkshore,55.0,24.8
    .target Balthule Shadowstrike
    >>Talk to |cRXP_FRIENDLY_Balthule Shadowstrike|r in Northern Darkshore
    .turnin 965 >>Turn in The Tower of Althalaxx
    .accept 966 >>Accept The Tower of Althalaxx
step
    >>|cRXP_WARN_MAIN QUEST - Supplies to Auberdine|r
    .goto Darkshore,56.0,27.0
    >>Kill |cRXP_ENEMY_Dark Strand Fanatics|r in Northern Darkshore for the |cRXP_LOOT_Worn Parchments|r
    .complete 966,1 >>The Tower of Althalaxx
    .mob Dark Strand Fanatic
step
    >>|cRXP_WARN_MAIN QUEST - Supplies to Auberdine|r
    .goto Darkshore,55.0,24.8
    .target Balthule Shadowstrike
    >>Talk to |cRXP_FRIENDLY_Balthule Shadowstrike|r in Northern Darkshore
    .turnin 966 >>Turn in The Tower of Althalaxx
    .accept 967 >>Accept The Tower of Althalaxx
step
    >>|cRXP_WARN_MAIN QUEST - The Absent Minded Prospector|r
    .goto Darkshore,35.8,83.6
    .target Prospector Remtravel
    >>Talk to |cRXP_FRIENDLY_Prospector Remtravel|r in Darkshore
    .turnin 729 >>Turn in The Absent Minded Prospector
    .accept 731 >>Accept The Absent Minded Prospector
step
    >>|cRXP_WARN_MAIN QUEST - The Absent Minded Prospector|r
    .goto Darkshore,35.8,83.6,0
    >>Escort |cRXP_FRIENDLY_Prospector Remtravel|r while he searches for the mysterious fossil
    .complete 731,1 >>The Absent Minded Prospector
step
    >>|cRXP_WARN_MAIN QUEST - The Powers Below|r
    .goto Darkshore,38.8,87.6
    >>Kill |cRXP_ENEMY_Twilight mobs|r in Darkshore for the |cRXP_LOOT_Book: The Powers Below|r
    .collect 5352,1
    .mob Twilight Disciple
    .mob Twilight Thug
    >>|cRXP_WARN_SAVE THE ITEM FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_MAIN QUEST - The Absent Minded Prospector|r
    .goto Darkshore,37.6,41.8
    .target Archaeologist Hollee
    >>Talk to |cRXP_FRIENDLY_Archaeologist Hollee|r in Auberdine, Darkshore
    .turnin 731 >>Turn in The Absent Minded Prospector
    >>|cRXP_WARN_DON'T ACCEPT THE FOLLOW-UP QUEST|r

-- ASHENVALE --
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,36.6,49.6
    .target Raene Wolfrunner
    >>Talk to |cRXP_FRIENDLY_Raene Wolfrunner|r in Astranaar, Ashenvale
    .accept 991 >>Accept Raene's Cleansing
step
    >>|cRXP_WARN_MAIN QUEST - Insane Druids|r
    .goto Ashenvale,34.6,48.8
    .target Shindrell Swiftfire
    >>Talk to |cRXP_FRIENDLY_Shindrell Swiftfire|r in Astranaar, Ashenvale
    .accept 4581 >>Accept Kayneth Stillwind
step
    >>|cRXP_WARN_MAIN QUEST - Fallen Sky Lake|r
    .goto Ashenvale,26.4,38.6
    .target Orendil Broadleaf
    >>Talk to |cRXP_FRIENDLY_Orendil Broadleaf|r at Maestra's Post, Ashenvale
    .accept 1010 >>Accept Bathran's Hair
step
    >>|cRXP_WARN_MAIN QUEST - Supplies to Auberdine|r
    .goto Ashenvale,26.2,38.6
    .target Delgren the Purifier
    >>Talk to |cRXP_FRIENDLY_Delgren the Purifier|r at Maestra's Post, Ashenvale
    .turnin 967 >>Turn in The Tower of Althalaxx
    .accept 970 >>Accept The Tower of Althalaxx
step
    >>|cRXP_WARN_MAIN QUEST - Supplies to Auberdine|r
    .goto Ashenvale,31.8,30.4
    >>Kill |cRXP_ENEMY_Dark Strand Mobs|r in Ashenvale for the |cRXP_LOOT_Glowing Soul Gem|r
    .complete 970,1 >>The Tower of Althalaxx
    .mob Dark Strand Cultist
    .mob Dark Strand Adept
    .mob Dark Strand Enforcer
    .mob Dark Strand Excavator
step
    >>|cRXP_WARN_MAIN QUEST - Fallen Sky Lake|r
    .goto Ashenvale,31.8,22.9
    >>Click on the |cRXP_PICK_Plant Bundles|r in Ashenvale for |cRXP_LOOT_Bathran's Hair|r
    .complete 1010,1 >>Bathran's Hair
step
    >>|cRXP_WARN_MAIN QUEST - Fallen Sky Lake|r
    .goto Ashenvale,26.4,38.6
    .target Orendil Broadleaf
    >>Talk to |cRXP_FRIENDLY_Orendil Broadleaf|r at Maestra's Post, Ashenvale
    .turnin 1010 >>Turn in Bathran's Hair
    .accept 1020 >>Accept Orendil's Cure
step
    >>|cRXP_WARN_MAIN QUEST - Supplies to Auberdine|r
    .goto Ashenvale,26.2,38.6
    .target Delgren the Purifier
    >>Talk to |cRXP_FRIENDLY_Delgren the Purifier|r at Maestra's Post, Ashenvale
    .turnin 970 >>Turn in The Tower of Althalaxx
    .accept 973 >>Accept The Tower of Althalaxx
step
    >>|cRXP_WARN_MAIN QUEST - Answered Questions|r
    .goto Ashenvale,22.2,52.8
    .target Sentinel Melyria Frostshadow
    >>Talk to |cRXP_FRIENDLY_Sentinel Melyria Frostshadow|r in Ashenvale
    .accept 1022 >>Accept The Howling Vale
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,20.2,42.2
    .target Teronis' Corpse
    >>Click on |cRXP_FRIENDLY_Teronis' Corpse|r in Ashenvale
    .turnin 991 >>Turn in Raene's Cleansing
    .accept 1023 >>Accept Raene's Cleansing
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,19.6,42.6
    >>Kill |cRXP_ENEMY_Saltspittle Murlocs|r in Ashenvale for the |cRXP_LOOT_Glowing Gem|r
    .complete 1023,1 >>Raene's Cleansing
    .mob Saltspittle Warrior
    .mob Saltspittle Puddlejumper
    .mob Saltspittle Oracle
    .mob Saltspittle Muckdweller
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,36.6,49.6
    .target Raene Wolfrunner
    >>Talk to |cRXP_FRIENDLY_Raene Wolfrunner|r in Astranaar, Ashenvale
    .turnin 1023 >>Turn in Raene's Cleansing
    .accept 1024 >>Accept Raene's Cleansing
step
    >>|cRXP_WARN_MAIN QUEST - Fallen Sky Lake|r
    .goto Ashenvale,37.2,51.8
    .target Pelturas Whitemoon
    >>Talk to |cRXP_FRIENDLY_Pelturas Whitemoon|r in Astranaar, Ashenvale
    .turnin 1020 >>Turn in Orendil's Cure
    .accept 1033 >>Accept Elune's Tear
step
    >>|cRXP_WARN_MAIN QUEST - Supplies to Auberdine|r
    .goto Ashenvale,25.2,60.6
    >>Kill |cRXP_ENEMY_Ilkrud Magthrull|r in Ashenvale for the |cRXP_LOOT_Ilkrud Magthrull's Tome|r
    .complete 973,1 >>The Tower of Althalaxx
    .mob Ilkrud Magthrull
step
    >>|cRXP_WARN_MAIN QUEST - Fallen Sky Lake|r
    .goto Ashenvale,33.7,67.3
    >>Loot |cRXP_LOOT_Handful of Stardust|r from the Bushes South of Astranaar, Ashenvale
    .complete 1034,1 >>The Ruins of Stardust
step
    >>|cRXP_WARN_MAIN QUEST - Supplies to Auberdine|r
    .goto Ashenvale,26.2,38.6
    .target Delgren the Purifier
    >>Talk to |cRXP_FRIENDLY_Delgren the Purifier|r at Maestra's Post, Ashenvale
    .turnin 973 >>Turn in The Tower of Althalaxx
step
    >>|cRXP_WARN_MAIN QUEST - Supplies to Auberdine|r
    .goto Ashenvale,26.2,38.8
    .target Feero Ironhand
    >>Talk to |cRXP_FRIENDLY_Feero Ironhand|r at Maestra's Post, Ashenvale
    .accept 976 >>Accept Supplies to Auberdine
    >>Escort and protect him as he travels towards Darkshore
    .complete 976,1 >>Supplies to Auberdine
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,53.4,46.2
    .target Shael'dryn
    >>Talk to |cRXP_FRIENDLY_Shael'dryn|r in Ashenvale
    .turnin 1024 >>Turn in Raene's Cleansing
    .accept 1026 >>Accept Raene's Cleansing
step
    >>|cRXP_WARN_MAIN QUEST - Answered Questions|r
    .goto Ashenvale,50.5,39.1
    >>Study the |cRXP_FRIENDLY_Tome of Mel'Thandris|r in Ashenvale
    .complete 1022,1 >>The Howling Vale
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,54.5,35.4
    >>Kill |cRXP_ENEMY_Ancient Treants|r in Ashenvale for the |cRXP_LOOT_Wooden Key|r
    .mob Withered Ancient
    .mob Crazed Ancient
    >>Loot |cRXP_LOOT_Iron Shaft|r from the Worn Chest
    .complete 1026,1 >>Raene's Cleansing
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,53.4,46.2
    .target Shael'dryn
    >>Talk to |cRXP_FRIENDLY_Shael'dryn|r in Ashenvale
    .turnin 1026 >>Turn in Raene's Cleansing
    .accept 1027 >>Accept Raene's Cleansing
step
    >>|cRXP_WARN_MAIN QUEST - Insane Druids|r
    .goto Ashenvale,85.2,44.6
    .target Kayneth Stillwind
    >>Talk to |cRXP_FRIENDLY_Kayneth Stillwind|r in Northeast Ashenvale
    .turnin 4581 >>Turn in Kayneth Stillwind
step
    >>|cRXP_WARN_MAIN QUEST - Insane Druids|r
    .goto Ashenvale,85.2,44.6
    .target Kayneth Stillwind
    >>Talk to |cRXP_FRIENDLY_Kayneth Stillwind|r in Northeast Ashenvale
    .accept 1011 >>Accept Forsaken Diseases
step
    >>|cRXP_WARN_MAIN QUEST - Insane Druids|r
    .goto Ashenvale,75.3,72.3
    >>Loot |cRXP_LOOT_Bottle of Disease|r by clicking on the Bottle 
    .complete 1011,1 >>Forsaken Diseases
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,71.4,76.8
    >>Kill |cRXP_ENEMY_Rotting Slimes|r in Ashenvale to spawn the |cRXP_PICK_Rusty Chest|r
    >>Click the |cRXP_PICK_Rusty Chest|r to loot the |cRXP_LOOT_Iron Pommel|r
    .complete 1027,1 >>Raene's Cleansing
    .mob Rotting Slime
step
    >>|cRXP_WARN_MAIN QUEST - Insane Druids|r
    .goto Ashenvale,85.2,44.6
    .target Kayneth Stillwind
    >>Talk to |cRXP_FRIENDLY_Kayneth Stillwind|r in Northeast Ashenvale
    .turnin 1011 >>Turn in Forsaken Diseases
step
    >>|cRXP_WARN_MAIN QUEST - Insane Druids|r
    .goto Ashenvale,85.2,44.6
    .target Kayneth Stillwind
    >>Talk to |cRXP_FRIENDLY_Kayneth Stillwind|r in Northeast Ashenvale
    .accept 1012 >>Accept Insane Druids
step
    >>|cRXP_WARN_MAIN QUEST - Insane Druids|r
    .goto Ashenvale,75.85,75.38,5,0
    .goto Ashenvale,78.0,72.8
    >>Kill |cRXP_ENEMY_The Druids|r inside the Dor'Danil Barrow Den, Ashenvale
    .complete 1012,1 >>Insane Druids
    .complete 1012,2
    .complete 1012,3
    .mob Taneel Darkwood
    .mob Uthil Mooncall
    .mob Mavoris Cloudsbreak
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,53.4,46.2
    .target Shael'dryn
    >>Talk to |cRXP_FRIENDLY_Shael'dryn|r in Ashenvale
    .turnin 1027 >>Turn in Raene's Cleansing
    .accept 1028 >>Accept Raene's Cleansing
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,56.4,49.2
    >>Click on the |cRXP_FRIENDLY_Hidden Shrine|r in Ashenvale
    .turnin 1028 >>Turn in Raene's Cleansing
    .accept 1055 >>Accept Raene's Cleansing
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,53.4,46.2
    .target Shael'dryn
    >>Talk to |cRXP_FRIENDLY_Shael'dryn|r in Ashenvale
    .turnin 1055 >>Turn in Raene's Cleansing
    .accept 1029 >>Accept Raene's Cleansing
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,36.6,49.6
    .target Raene Wolfrunner
    >>Talk to |cRXP_FRIENDLY_Raene Wolfrunner|r in Astranaar, Ashenvale
    .turnin 1029 >>Turn in Raene's Cleansing
    .accept 1030 >>Accept Raene's Cleansing
step
    >>|cRXP_WARN_MAIN QUEST - Fallen Sky Lake|r
    .goto Ashenvale,37.2,51.8
    .target Pelturas Whitemoon
    >>Talk to |cRXP_FRIENDLY_Pelturas Whitemoon|r in Astranaar, Ashenvale
    .turnin 1033 >>Turn in Elune's Tear
    .accept 1034 >>Accept The Ruins of Stardust
step
    >>|cRXP_WARN_MAIN QUEST - Fallen Sky Lake|r
    .goto Ashenvale,33.7,67.3
    >>Loot |cRXP_LOOT_Handful of Stardust|r from the Bushes South of Astranaar, Ashenvale
    .complete 1034,1 >>The Ruins of Stardust
step
    >>|cRXP_WARN_MAIN QUEST - Fallen Sky Lake|r
    .goto Ashenvale,37.2,51.8
    .target Pelturas Whitemoon
    >>Talk to |cRXP_FRIENDLY_Pelturas Whitemoon|r in Astranaar, Ashenvale
    .turnin 1034 >>Turn in The Ruins of Stardust
    .accept 1035 >>Accept Fallen Sky Lake
step
    >>|cRXP_WARN_MAIN QUEST - Answered Questions|r
    .goto Ashenvale,22.2,52.8
    .target Sentinel Melyria Frostshadow
    >>Talk to |cRXP_FRIENDLY_Sentinel Melyria Frostshadow|r in Ashenvale
    .turnin 1022 >>Turn in The Howling Vale
    .accept 1037 >>Accept Velinde Starsong
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,50.8,75.0
    >>Use |cRXP_PICK_Dartol's Rod of Transformation|r
    .use 5462
    .target Krolg
    >>To speak with |cRXP_FRIENDLY_Krolg|r in Ashenvale
    .turnin 1030 >>Turn in Raene's Cleansing
    .accept 1045 >>Accept Raene's Cleansing

-- Skull comes from mob but is the turn in for the follow-up quest --
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,54.6,79.6
    >>Kill |cRXP_ENEMY_Furbolg Mobs|r in Ashenvale
    .complete 1045,1 >>Raene's Cleansing
    .complete 1045,2
    .mob Ran Bloodtooth
    .mob Bloodtooth Guard
    >>Loot |cRXP_LOOT_Ran Bloodtooth's Skull|r for the follow-up quest.
    .collect 5388,1
step
    >>|cRXP_WARN_MAIN QUEST - Raene's Cleansing|r
    .goto Ashenvale,50.8,75.0
    >>Use |cRXP_PICK_Dartol's Rod of Transformation|r
    .use 5462
    .target Krolg
    >>To speak with |cRXP_FRIENDLY_Krolg|r in Ashenvale
    .turnin 1045 >>Turn in Raene's Cleansing
    .accept 1046 >>Accept Raene's Cleansing
    >>|cRXP_WARN_DO NOT TURN IN THE FOLLOW-UP QUEST! SAVE IT FOR LAUNCH DAY|r
step
    >>|cRXP_WARN_MAIN QUEST - Fallen Sky Lake|r
    .goto Ashenvale,66.6,82.0
    >>Kill |cRXP_ENEMY_Shadethicket Oracle|r in Ashenvale for the |cRXP_LOOT_Fallen Moonstone|r
    .complete 1035,1 >>Fallen Sky Lake
    .mob Shadethicket Oracle
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_MAIN QUEST - Repelling Invaders|r
    .goto Ashenvale,55.6,55.2
    >>Participate in the Battle for Ashenvale and Kill |cRXP_ENEMY_Warsong mobs|r for the |cRXP_LOOT_Warsong Outrider Mark|r
    .collect 211814,1
    .mob Warsong Raider
    .mob Warsong Grunt
    .mob Warsong Shaman
    >>|cRXP_WARN_SAVE THE ITEM FOR LAUNCH DAY TURN-IN|r

-- DARNASSUS --
step
    >>|cRXP_WARN_MAIN QUEST - Answered Questions|r
    .goto Darnassus,61.8,39.6
    .target Thyn'tel Bladeweaver
    >>Talk to |cRXP_FRIENDLY_Thyn'tel Bladeweaver|r in Darnassus
    .turnin 1037 >>Turn in Velinde Starsong
    .accept 1038 >>Accept Velinde's Effects
step
    >>|cRXP_WARN_MAIN QUEST - Answered Questions|r
    .goto Darnassus,62.5,83.1
    >>Loot |cRXP_LOOT_Velinde's Journal|r from Velinde's Locker in Darnassus
    .complete 1038,1 >>Velinde's Effects
step
    >>|cRXP_WARN_MAIN QUEST - Answered Questions|r
    .goto Darnassus,61.8,39.6
    .target Thyn'tel Bladeweaver
    >>Talk to |cRXP_FRIENDLY_Thyn'tel Bladeweaver|r in Darnassus
    .turnin 1038 >>Turn in Velinde's Effects
    .accept 1039 >>Accept The Barrens Port

-- STONETALON MOUNTAINS / THE BARRENS --
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Stonetalon Mountains,59.8,66.8
    .target Kaela Shadowspear
    >>Talk to |cRXP_FRIENDLY_Kaela Shadowspear|r in Stonetalon Mountains
    .turnin 1070 >>Turn in On Guard in Stonetalon
    .accept 1085 >>Accept On Guard in Stonetalon
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Stonetalon Mountains,59.6,67.0
    .target Gaxim Rustfizzle
    >>Talk to |cRXP_FRIENDLY_Gaxim Rustfizzle|r in Stonetalon Mountains
    .turnin 1085 >>Turn in On Guard in Stonetalon
    .accept 1071 >>Accept A Gnome's Respite
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Stonetalon Mountains,67.6,51.2
    >>Kill |cRXP_ENEMY_Venture Co. Mobs|r around Windshear Crag
    .complete 1071,1 >>A Gnome's Respite
    .complete 1071,2
    .mob Venture Co. Logger
    .mob Venture Co. Deforester
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Stonetalon Mountains,59.6,67.0
    .target Gaxim Rustfizzle
    >>Talk to |cRXP_FRIENDLY_Gaxim Rustfizzle|r in Stonetalon Mountains
    .turnin 1071 >>Turn in A Gnome's Respite
    .accept 1072 >>Accept An Old Colleague
    .accept 1075 >>Accept A Scroll from Mauren
step
    >>|cRXP_WARN_MAIN QUEST - Answered Questions|r
    .goto The Barrens,63.2,38.4
    .target Wharfmaster Dizzywig
    >>Talk to |cRXP_FRIENDLY_Wharfmaster Dizzywig|r in Ratchet
    .turnin 1039 >>Turn in The Barrens Port
    .accept 1040 >>Accept Passage to Booty Bay

-- BOOTY BAY / DUSKWOOD --
step
    >>|cRXP_WARN_MAIN QUEST - Answered Questions|r
    .goto Stranglethorn Vale,27.2,74.0
    .target Caravaneer Ruzzgot
    >>Take the boat and Talk to |cRXP_FRIENDLY_Caravaneer Ruzzgot|r in Booty Bay
    .turnin 1040 >>Turn in Passage to Booty Bay
    .accept 1041 >>Accept The Caravan Road
step
    >>|cRXP_WARN_MAIN QUEST - Answered Questions|r
    .goto Duskwood,72.6,46.8
    .target Clerk Daltry
    >>Talk to |cRXP_FRIENDLY_Clerk Daltry|r in Darkshire
    .turnin 1041 >>Turn in The Caravan Road
    .accept 1042 >>Accept The Carevin Family
step
    >>|cRXP_WARN_MAIN QUEST - Answered Questions|r
    .goto Duskwood,75.2,48.8
    .target Jonathan Carevin
    >>Talk to |cRXP_FRIENDLY_Jonathan Carevin|r in Darkshire
    .turnin 1042 >>Turn in The Carevin Family
    .accept 1043 >>Accept The Scythe of Elune
step
    >>|cRXP_WARN_MAIN QUEST - Answered Questions|r
    .goto Duskwood,73,79
    >>Click the |cRXP_FRIENDLY_Mound of dirt|r inside the cave Roland's Doom
    .complete 1043,1 >>The Scythe of Elune
step
    .isOnQuest 1043
    >>|cRXP_WARN_MAIN QUEST - Answered Questions|r
    .goto Duskwood,75.2,48.8
    .target Jonathan Carevin
    >>Talk to |cRXP_FRIENDLY_Jonathan Carevin|r in Darkshire
    +Turn in The Scythe of Elune -- 1043
    >>|cRXP_WARN_SAVE THIS QUEST FOR TURN-IN IF YOUR ARE USING IT AS A BACKUP|r

-- IRONFORGE --
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    >>Buy |cRXP_BUY_4 Minor Mana Potions|r and |cRXP_BUY_2 Elixirs of Minor Fortitude|r from the Auction House in Ironforge
    .complete 1073,1 >>Reception from Tyrande
    .complete 1073,2
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Ironforge,71.8,52.0
    .target Lomac Gearstrip
    >>Talk to |cRXP_FRIENDLY_Lomac Gearstrip|r in Ironforge
    .turnin 1072 >>Turn in An Old Colleague
    .accept 1073 >>Accept Ineptitude + Chemicals = Fun
    .turnin 1073 >>Turn in Ineptitude + Chemicals = Fun
    .accept 1074 >>Accept Ineptitude + Chemicals = Fun

-- STORMWIND / WESTFALL --
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Stormwind City,43.0,80.2
    .target Collin Mauren
    >>Talk to |cRXP_FRIENDLY_Collin Mauren|r in Stormwind
    .turnin 1075 >>Turn in A Scroll from Mauren
    .accept 1076 >>Accept Devils in Westfall
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    >>Kill |cRXP_ENEMY_Dust Devils|r in Westfall for |cRXP_LOOT_Dust Devil Debris|r
    .complete 1076,1 >>Devils in Westfall
    .mob Dust Devil
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Stormwind City,43.0,80.2
    .target Collin Mauren
    >>Talk to |cRXP_FRIENDLY_Collin Mauren|r in Stormwind
    .turnin 1076 >>Turn in Devils in Westfall
    .accept 1077 >>Accept Special Delivery for Gaxim

-- STONETALON MOUNTAINS 2 --
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Stonetalon Mountains,59.6,67.0
    .target Gaxim Rustfizzle
    >>Talk to |cRXP_FRIENDLY_Gaxim Rustfizzle|r in Stonetalon Mountains
    .turnin 1074 >>Turn in Ineptitude + Chemicals = Fun
    .turnin 1077 >>Turn in Special Delivery for Gaxim
    .accept 1079 >>Accept Covert Ops - Alpha
    .accept 1080 >>Accept Covert Ops - Beta
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Stonetalon Mountains,66.1,51.3
    >>Loot the |cRXP_LOOT_Venture Co. Engineering Plans|r from the Lumber Mill in Windshear Crag
    .complete 1079,1 >>Covert Ops - Alpha
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Stonetalon Mountains,74.5,59.3
    >>Loot |cRXP_LOOT_Venture Co. Letters|r from the Mine in Windshear Crag
    .complete 1080,1 >>Covert Ops - Beta
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Stonetalon Mountains,59.6,67.0
    .target Gaxim Rustfizzle
    >>Talk to |cRXP_FRIENDLY_Gaxim Rustfizzle|r in Stonetalon Mountains
    .turnin 1079 >>Turn in Covert Ops - Alpha
    .turnin 1080 >>Turn in Covert Ops - Beta
    .accept 1091 >>Accept Kaela's Update
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Stonetalon Mountains,59.8,66.8
    .target Kaela Shadowspear
    >>Talk to |cRXP_FRIENDLY_Kaela Shadowspear|r in Stonetalon Mountains
    .turnin 1091 >>Turn in Kaela's Update
    .accept 1083 >>Accept Enraged Spirits
    .accept 1084 >>Accept Wounded Ancients
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Stonetalon Mountains,31.6,67.8
    >>Kill |cRXP_ENEMY_Fire Elementals|r around the Charred Vale for |cRXP_LOOT_Smoldering Embers|r
    .complete 1083,1 >>Enraged Spirits
    .mob Burning Destroyer
    .mob Rogue Flame Spirit
    .mob Burning Ravager
    >>Kill |cRXP_ENEMY_Ancient Treants|r around the Charred Vale for |cRXP_LOOT_Corroded Shrapnel|r
    .complete 1084,1 >>Wounded Ancients
    .mob Blackened Ancient
    .mob Charred Ancient
    .mob Vengeful Ancient
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Stonetalon Mountains,59.8,66.8
    .target Kaela Shadowspear
    >>Talk to |cRXP_FRIENDLY_Kaela Shadowspear|r in Stonetalon Mountains
    .turnin 1083 >>Turn in Enraged Spirits
    .turnin 1084 >>Turn in Wounded Ancients
    .accept 1082 >>Accept Update for Sentinel Thenysil

-- ASHENVALE --
step
    >>|cRXP_WARN_MAIN QUEST - Reception from Tyrande|r
    .goto Ashenvale,34.8,49.8
    .target Sentinel Thenysil
    >>Talk to |cRXP_FRIENDLY_Sentinel Thenysil|r in Astranaar, Ashenvale
    .turnin 1082 >>Turn in Update for Sentinel Thenysil
    >>|cRXP_WARN_DON'T ACCEPT THE FOLLOW-UP QUEST|r

-- BLACKFATHOM DEEPS --
step
    >>|cRXP_WARN_MAIN QUEST - Blackfathom Villainy|r
    .goto Ashenvale,14,14
    .target Argent Guard Thaelrid
    >>Talk to |cRXP_FRIENDLY_Argent Guard Thaelrid|r inside Blackfathom Deeps
    .accept 78921 >>Accept Blackfathom Villainy
step
    >>|cRXP_WARN_MAIN QUEST - Baron Aquanis|r
    .goto Ashenvale,14,14
    >>Kill |cRXP_ENEMY_Baron Aquanis|r inside Blackfathom Deeps for the |cRXP_LOOT_Strange Water Globe|r
    .complete 79099,1 >>Baron Aquanis
    .mob Baron Aquanis
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r
step
    >>|cRXP_WARN_MAIN QUEST - Knowledge in the Deep|r
    >>Loot |cRXP_LOOT_Lorgalis Manuscript|r from the Pitted Iron Chest inside Blackfathom Deeps. The chest is underwater after the turtle boss.
    .complete 78923,1 >>Knowledge in the Deep
step
    >>|cRXP_WARN_MAIN QUEST - Researching the Corruption|r
    .goto Ashenvale,14,14
    >>Kill |cRXP_ENEMY_Fallenroot and Blackfathom mobs|r inside Blackfathom Deeps for |cRXP_LOOT_Corrupted Brain Stems|r
    .complete 78926,1 >>Researching the Corruption
    .mob Fallenroot Rogue
    .mob Fallenroot Satyr
    .mob Blackfathom Elite
    .mob Blackfathom Oracle
    .mob Blackfathom Tide Priestess
    .mob Blackfathom Sea Witch
step
    >>|cRXP_WARN_MAIN QUEST - Twilight Falls|r
    .goto Ashenvale,14,14
    >>Kill |cRXP_ENEMY_Twilight mobs|r inside Blackfathom Deeps for |cRXP_LOOT_Twilight Pendants|r
    .complete 78925,1 >>Twilight Falls
    .mob Twilight Reaver
    .mob Twilight Aquamancer
    .mob Twilight Loreseeker
    .mob Twilight Acolyte
    .mob Twilight Shadowmage
    .mob Twilight Elementalist
step
    >>|cRXP_WARN_MAIN QUEST - Blackfathom Villainy|r
    >>Kill |cRXP_ENEMY_Twilight Lord Kelris|r inside Blackfathom Deeps for the |cRXP_LOOT_Head of Kelris|r
    .complete 78921,1 >>Blackfathom Villainy
    .mob Twilight Lord Kelris
    >>|cRXP_WARN_SAVE THIS QUEST FOR LAUNCH DAY TURN-IN|r

-- RAZORFEN KRAUL --
step
    >>|cRXP_WARN_MAIN QUEST - Mortality Wanes|r
    .goto The Barrens,43,90
    .target Heralath Fallowbrook
    >>Talk to |cRXP_FRIENDLY_Heralath Fallowbrook|r inside Razorfen Kraul behind Willix the Importer
    .accept 1142 >>Accept Mortality Wanes
step
    >>|cRXP_WARN_MAIN QUEST - Mortality Wanes|r
    >>Kill |cRXP_ENEMY_Quilboars|r inside Razorfen Kraul for |cRXP_LOOT_Treshala's Pendant|r
    .complete 1142,1 >>Mortality Wanes
    .mob Razorfen Quilguard
    .mob Razorfen Handler
    .mob Death's Head Seer
    .mob Razorfen Geomancer

-- STORMWIND VENDOR / AUCTION HOUSE --
step
    >>|cRXP_WARN_MAIN QUEST - Dry Times|r
    .goto Stormwind City,52.0,67.8
    .target Roberto Pupellyverbos
    >>Buy a |cRXP_BUY_Cask of Merlot|r from Roberto Pupellyverbos in Stormwind
    .complete 116,2 >>Dry Times
step
    >>|cRXP_WARN_MAIN QUEST - Seasoned Wolf Kabobs|r
    .goto Stormwind City,64.2,60.6
    .target Felicia Gump
    >>Buy |cRXP_BUY_Stormwind Seasoning Herbs|r from Felicia Gump in Stormwind
    .complete 90,2
    >>Buy |cRXP_BUY_10 Lean Wolf Flank|r from the Auction House 
    .complete 90,1 >>Seasoned Wolf Kabobs
    >>|cRXP_WARN_NOTE|r: You're cooking level must be 50 to turn-in this quest.
step
    >>|cRXP_WARN_MAIN QUEST - Look To The Stars|r
    >>Buy a |cRXP_BUY_Bronze Tube|r from the Auction House 
    .complete 174,1 >>Look To The Stars
step
    >>|cRXP_WARN_MAIN QUEST - A Donation of Silk|r
    >>Buy |cRXP_BUY_Silk Cloth|r from the Auction House (60 per available turn-in)
    .complete 7798,1 >>A Donation of Silk
    .complete 7803,1 >>A Donation of Silk
    .complete 7808,1 >>A Donation of Silk
    .complete 7793,1 >>A Donation of Silk
step
    >>|cRXP_WARN_MAIN QUEST - A Donation of Wool|r
    >>Buy |cRXP_BUY_Wool Cloth|r from the Auction House (60 per available turn-in)
    .complete 7792,1 >>A Donation of Wool
    .complete 7802,1 >>A Donation of Wool
    .complete 7807,1 >>A Donation of Wool
    .complete 7791,1 >>A Donation of Wool
step
    >>|cRXP_WARN_MAIN QUEST - Dusky Crab Cakes|r
    >>Buy |cRXP_BUY_6 Gooey Spider Legs|r from the Auction House 
    .complete 93,1 >>Dusky Crab Cakes

-- OUTRO --
step
    >>|cRXP_WARN_BEFORE PHASE 2 LAUNCH|r
    +Set your hearthstone in Astranaar, Ashenvale
    +Complete your Item Checklist in the Google Sheet
    +Get Boon of Blackfathom for 20% Movement Speed, and as many swiftness potions you can carry
    +Get all needed flight paths
    +Logout at Lakeshire Town Hall in Redridge Mountains for P2 launch
]])

RXPGuides.RegisterGuide([[
#classic
#version 3
<< Alliance
#group Custom Quests for RXP
#subgroup SoD Level 25 Quest Stacking
#name 25-3-Launch Day Turn-in Route
#displayname 3-Launch Day Turn-in Route

step
    +|cRXP_WARN_WARNING: ONLY LOAD THIS GUIDE ON LAUNCH DAY, DO NOT ACCIDENTALLY TURN IN YOUR PRE QUESTS|r

-- REDRIDGE MOUNTAINS --
step
    #completewith redridge
    .zone Redridge Mountains >>Head to Lakeshire in Redridge Mountains
step
    .isOnQuest 169
    .goto Redridge Mountains,30.0,44.2
    .target Magistrate Solomon
    .turnin 169 >>Turn in Wanted: Gath'Ilzogg to |cRXP_FRIENDLY_Magistrate Solomon|r in Lakeshire
step
    .isOnQuest 180
    .goto Redridge Mountains,30.0,44.2
    .target Magistrate Solomon
    .turnin 180 >>Turn in Wanted: Lieutenant Fangore to |cRXP_FRIENDLY_Magistrate Solomon|r in Lakeshire
step
    .itemcount 2296,5
    .itemcount 1080,5
    .itemcount 1081,5
    .goto Redridge Mountains,22.6,44.0
    .target Chef Breanna
    >>Talk to |cRXP_FRIENDLY_Chef Breanna|r in Lakeshire
    .accept 92 >>Accept Redridge Goulash
    .turnin 92 >>Turn in Redridge Goulash
step
    .itemcount 1468,8
    .goto Redridge Mountains,27.8,47.2
    .target Dockmaster Baren
    >>Talk to |cRXP_FRIENDLY_Dockmaster Baren|r in Lakeshire
    .accept 150 >>Accept Murloc Poachers
    .turnin 150 >>Turn in Murloc Poachers
step
    .itemcount 1939,1
    .itemcount 1942,1
    .itemcount 1941,1
    .itemcount 1262,1
    .goto Redridge Mountains,26.6,44.0
    .target Barkeep Daniels
    >>Talk to |cRXP_FRIENDLY_Barkeep Daniels|r in Lakeshire
    .accept 116 >>Accept Dry Times
    .turnin 116 >>Turn in Dry Times
step
    .isOnQuest 19
    .goto Redridge Mountains,33.6,48.8
    .target Marshal Marris
    .turnin 19 >>Turn in Tharil'zun to |cRXP_FRIENDLY_Marshal Marris|r in Lakeshire
step
    .isOnQuest 219
    .goto Redridge Mountains,33.6,48.8
    .target Marshal Marris
    .turnin 219 >>Turn in Missing In Action to |cRXP_FRIENDLY_Marshal Marris|r in Lakeshire
step
    .isOnQuest 115
    .goto Redridge Mountains,33.6,48.8
    .target Marshal Marris
    .turnin 115 >>Turn in Shadow Magic to |cRXP_FRIENDLY_Marshal Marris|r in Lakeshire
step
    .isQuestTurnedIn 65
    .goto Redridge Mountains,26.6,45.2
    .target Wiley the Black
    .accept 132 >>Accept The Defias Brotherhood from |cRXP_FRIENDLY_Wiley the Black|r in Lakeshire
step
    #label redridge
    .itemcount 2798,5
    .goto Redridge Mountains,32.2,48.6
    .target Foreman Oslow
    .accept 347 >>Accept Rethban Ore from |cRXP_FRIENDLY_Foreman Oslow|r in Lakeshire
step
    #completewith next
    .fly Darkshire
    .goto Redridge Mountains,30.65,59.38
    .target Ariena Stormfeather

-- DUSKWOOD 1 --
step
    #completewith duskwood1
    .zone Duskwood >>Head to Darkshire in Duskwood
step
    .isOnQuest 101
    .goto Duskwood,75.8,45.2
    .target Madame Eva
    .turnin 101 >>Turn in The Totem of Infliction to |cRXP_FRIENDLY_Madame Eva|r in Darkshire
step
    .isOnQuest 98
    .goto Duskwood,75.8,45.2
    .target Madame Eva
    .turnin 98 >>Turn in The Legend of Stalvan to |cRXP_FRIENDLY_Madame Eva|r in Darkshire
step
    .itemcount 1015,10
    .itemcount 2665,1
    .goto Duskwood,73.8,43.6
    .target Chef Grual
    >>Talk to |cRXP_FRIENDLY_Chef Grual|r in Darkshire
    .accept 90 >>Accept Seasoned Wolf Kabobs
    .turnin 90 >>Turn in Seasoned Wolf Kabobs
step
    .itemcount 2251,6
    .goto Duskwood,73.8,43.6
    .target Chef Grual
    >>Talk to |cRXP_FRIENDLY_Chef Grual|r in Darkshire
    .accept 93 >>Accept Dusky Crab Cakes
    .turnin 93 >>Turn in Dusky Crab Cakes
step
    .isOnQuest 58
    .goto Duskwood,73.6,46.8
    .target Commander Althea Ebonlocke
    .turnin 58 >>Turn in The Night Watch to |cRXP_FRIENDLY_Commander Althea Ebonlocke|r in Darkshire
step
    .isOnQuest 377
    .goto Duskwood,72.0,47.8
    .target Councilman Millstipe
    .turnin 377 >>Turn in Crime and Punishment to |cRXP_FRIENDLY_Councilman Millstipe|r in Darkshire
step
    .isOnQuest 253
    .goto Duskwood,72.0,46.6
    .target Lord Ello Ebonlocke
    .turnin 253 >>Turn in Bride of the Embalmer to |cRXP_FRIENDLY_Lord Ello Ebonlocke|r in Darkshire
step
    .isQuestTurnedIn 222
    .goto Duskwood,75.6,47.6
    .target Calor
    .accept 223 >>Accept Worgen in the Woods from |cRXP_FRIENDLY_Calor|r in Darkshire
step
    .isOnQuest 1043
    .goto Duskwood,75.2,48.8
    .target Jonathan Carevin
    .turnin 1043 >>Turn in The Scythe of Elune to |cRXP_FRIENDLY_Jonathan Carevin|r in Darkshire
step
    .itemcount 4371,1
    .goto Duskwood,79.8,48.0
    .target Viktori Prism'Antras
    >>Talk to |cRXP_FRIENDLY_Viktori Prism'Antras|r in Darkshire
    .accept 174 >>Accept Look to the Stars
    .turnin 174 >>Turn in Look to the Stars
step
    .isQuestTurnedIn 93
    .goto Duskwood,73.8,43.6
    .target Chef Grual
    .accept 240 >>Accept Return to Jitters from |cRXP_FRIENDLY_Chef Grual|r in Darkshire
step
    #label duskwood1
    .isQuestTurnedIn 1043
    .goto Duskwood,75.2,48.8
    .target Jonathan Carevin
    .accept 1044 >>Accept Answered Questions from |cRXP_FRIENDLY_Jonathan Carevin|r in Darkshire
step
    #completewith next
    .fly Sentinel Hill
    .goto Duskwood,77.6,44.4
    .target Felicia Maline

-- WESTFALL --
step
    .zone Westfall >>Head to Sentinel Hill in Westfall
step
    .isOnQuest 132
    .goto Westfall,56.2,47.6
    .target Gryan Stoutmantle
    .turnin 132 >>Turn in The Defias Brotherhood to |cRXP_FRIENDLY_Gryan Stoutmantle|r at Sentinel Hill in Westfall
step
    #label westfall
    .isQuestTurnedIn 132
    .goto Westfall,56.2,47.6
    .target Gryan Stoutmantle
    .accept 135 >>Accept The Defias Brotherhood from |cRXP_FRIENDLY_Gryan Stoutmantle|r at Sentinel Hill in Westfall

-- DUSKWOOD 2 --
step
    #completewith duskwood2
    .zone Duskwood >>Run towards Raven Hill in Duskwood
step
    .isOnQuest 240
    .goto Duskwood,18.4,56.6
    .target Jitters
    .turnin 240 >>Turn in Return to Jitters to |cRXP_FRIENDLY_Jitters|r at Raven Hill in Duskwood
step
    #label duskwood2
    .isOnQuest 55
    .goto Duskwood,7.8,34.0
    .target Sven Yorgen
    .turnin 55 >>Turn in Morbent Fel to |cRXP_FRIENDLY_Sven Yorgen|r at the camp NW of Raven Hill

-- ELWYNN FOREST --
step
    #completewith elwynn
    .zone Elwynn Forest >>Run North into Elwynn Forest
step
    .isOnQuest 347
    .goto Elwynn Forest,49.6,40.4
    .target Brother Paxton
    >>Talk to |cRXP_FRIENDLY_Brother Paxton|r at Northshire Valley, Elwynn Forest
    .turnin 347 >>Turn in Rethban Ore
    .accept 346 >>Accept Return to Kristoff
step
    .isOnQuest 249
    .goto Elwynn Forest,65.2,69.8
    .target Theocritus
    .turnin 249 >>Turn in Morganth to |cRXP_FRIENDLY_Theocritus|r atop the Tower of Azora, Elwynn Forest
step
    .itemcount 1962,1
    .use 1962
    .goto Elwynn Forest,65.2,69.8
    .accept 178 >>Accept Theocritus' Retrieval by clicking the Glowing Shadowhide Pendant
step
    #label elwynn
    .isOnQuest 178
    .goto Elwynn Forest,65.2,69.8
    .target Theocritus
    .turnin 178 >>Turn in Theocritus' Retrieval to |cRXP_FRIENDLY_Theocritus|r atop the Tower of Azora, Elwynn Forest
step
    #completewith next
    .hs >>Hearth to Astranaar, Ashenvale

-- ASHENVALE --
step
    #completewith ashenvale
    .zone Ashenvale >>Head to Astranaar in Ashenvale
step
    .isOnQuest 976
    .goto Ashenvale,26.2,38.6
    .target Delgren the Purifier
    .turnin 976 >>Turn in Supplies to Auberdine to |cRXP_FRIENDLY_Delgren the Purifier|r at Maestra's Post in Ashenvale
step
    -- level 26
    >>|cRXP_WARN_NOTE|r: You must be level 26 to accept this quest
    .goto Ashenvale,21.8,53.2
    .target Illiyana
    .accept 1021 >>Accept Vile Satyr! Dryads in Danger! from |cRXP_FRIENDLY_Illiyana|r at The Shrine of Aessina south of Maestra's Post
step
    .isOnQuest 1046
    .goto Ashenvale,36.6,49.6
    .target Raene Wolfrunner
    .turnin 1046 >>Turn in Raene's Cleansing to |cRXP_FRIENDLY_Raene Wolfrunner|r in Astranaar
step
    .itemcount 211814,1
    >>Use the Warsong Outrider Mark to Accept the quest
    .use 211814
    .accept 79090 >>Accept Repelling Invaders
step
    .isOnQuest 79090
    .goto Ashenvale,36.8,49.8
    .target Felore Moonray
    .turnin 79090 >>Turn in Repelling Invaders to |cRXP_FRIENDLY_Felore Moonray|r in Astranaar
step
    .isOnQuest 1035
    .goto Ashenvale,37.2,51.8
    .target Pelturas Whitemoon
    .turnin 1035 >>Turn in Fallen Sky Lake to |cRXP_FRIENDLY_Pelturas Whitemoon|r in Astranaar
step
    .isQuestTurnedIn 1082
    .goto Ashenvale,34.8,49.8
    .target Sentinel Thenysil
    .accept 1081 >>Accept Reception from Tyrande from |cRXP_FRIENDLY_Sentinel Thenysil|r in Astranaar
step
    .isOnQuest 1017
    .goto Ashenvale,49.8,67.2
    .target Sentinel Velene Starstrike
    .turnin 1017 >>Turn in Mage Summoner to |cRXP_FRIENDLY_Sentinel Velene Starstrike|r at lake southeast of Astranaar
step
    #completewith next
    .fly Talrendis Point
    .goto Ashenvale,34.4,48.0
    .target Daelyshia
step
    .isOnQuest 1012
    .goto Ashenvale,85.2,44.6
    .target Kayneth Stillwind
    .turnin 1012 >>Turn in Insane Druids to |cRXP_FRIENDLY_Kayneth Stillwind|r in Ashenvale east of Satyrnaar
step
    #label ashenvale
    .isOnQuest 1021
    .goto Ashenvale,78.2,44.8
    .use 212160
    .target Anilia
    .turnin 1021 >>Turn in Vile Satyr! Dryads in Danger! to |cRXP_FRIENDLY_Anilia|r at Satyrnaar in Ashenvale
    >>|cRXP_WARN_NOTE|r: This is a difficult quest to turn-in. Boon your buffs in case you die.
step
    #completewith next
    .fly Auberdine
    .goto Ashenvale,34.4,48.0
    .target Daelyshia

-- DARKSHORE1 --
step
    #completewith darkshore1
    .zone Darkshore >>Head to Auberdine in Darkshore
step
    .isOnQuest 79099
    .goto Darkshore,36.8,43.6
    .target Davius Voidstar
    .turnin 79099 >>Turn in Baron Aquanis to |cRXP_FRIENDLY_Davius Voidstar|r in Auberdine
step
    .isOnQuest 78926
    .goto Darkshore,38.4,43.0
    .target Gershala Nightwhisper
    .turnin 78926 >>Turn in Researching the Corruption to |cRXP_FRIENDLY_Gershala Nightwhisper|r in Auberdine
step
    #label darkshore1
    .isQuestTurnedIn 731
    .goto Darkshore,37.6,41.8
    .target Archaeologist Hollee
    .accept 741 >>Accept The Absent Minded Prospector from |cRXP_FRIENDLY_Archaeologist Hollee|r in Auberdine
step
    #completewith next
    .fly Rut'theran Village >>Fly to Darnassus
    .goto Darkshore,36.4,45.6
    .target Caylais Moonfeather

-- DARNASSUS --
step
    #completewith darnassus
    .zone Darnassus >>Head to Darnassus
step
    .isOnQuest 78921
    .goto Darnassus,55.8,24.2
    .target Dawnwatcher Selgorm
    .turnin 78921 >>Turn in Blackfathom Villainy to |cRXP_FRIENDLY_Dawnwatcher Selgorm|r in Darnassus
step
    .isOnQuest 78925
    .goto Darnassus,55.2,23.6
    .target Argent Guard Manados
    .turnin 78925 >>Turn in Twilight Falls to |cRXP_FRIENDLY_Argent Guard Manados|r in Darnassus
step
    >>Talk to |cRXP_FRIENDLY_Raedon Duskstriker|r in Darnassus
    .goto Darnassus,63.8,22.8
    .target Raedon Duskstriker
    .turnin 7792 >>Turn in A Donation of Wool
    .turnin 7798 >>Turn in A Donation of Silk
step
    .isOnQuest 1044
    .goto Darnassus,61.8,39.6
    .target Thyn'tel Bladeweaver
    .turnin 1044 >>Turn in Answered Questions to |cRXP_FRIENDLY_Thyn'tel Bladeweaver|r in Darnassus
step
    .itemcount 20558,3
    .goto Darnassus,58.0,34.6
    .target Alliance Brigadier General
    .turnin 8372 >>Turn in Fight for Warsong Gulch to |cRXP_FRIENDLY_Alliance Brigadier General|r in Darnassus
step
    >>Turn in any Full Shipment boxes
    .goto Darnassus,59.8,56.6
    .target Marcy Baker
    .turnin 79103 >>Turn in A Full Shipment to |cRXP_FRIENDLY_Marcy Baker|r in Darnassus
step
    .isOnQuest 1142
    .goto Darnassus,69.6,67.6
    .target Treshala Fallowbrook
    .turnin 1142 >>Turn in Mortality Wanes to |cRXP_FRIENDLY_Treshala Fallowbrook|r in Darnasus
step
    .isOnQuest 1081
    .goto Darnassus,39.0,81.6
    .target Tyrande Whisperwind
    .turnin 1081 >>Turn in Reception from Tyrande to |cRXP_FRIENDLY_Tyrande Whisperwind|r in Darnasus
step
    .isOnQuest 741
    .goto Darnassus,31.2,84.6
    .target Chief Archaeologist Greywhisker
    >>Talk to |cRXP_FRIENDLY_Chief Archaeologist Greywhisker|r in Darnassus
    .turnin 741 >>Turn in The Absent Minded Prospector
    .accept 942 >>Accept The Absent Minded Prospector
step
    #label darnassus
    .goto Darnassus,40.0,41.8
    .target Lairn
    .bankwithdraw 2656,2592,4306,5352,2944,3349,3712,3713 >>Withdraw any needed items from your bank in Darnassus

step << Mage
    #completewith next
    .zone Ironforge >>Teleport to Ironforge
step << Mage
    #completewith next
    .goto Ironforge,55.501,47.742
    .fly Menethil >>Fly to Menethil
step << !Mage
    #completewith next
    .fly Auberdine
    .goto Teldrassil,58.4,94.0
    .target Vesprystus
step << !Mage
    #completewith next
    .zone Darkshore >>Head to Darkshore
step << !Mage
    .goto Darkshore,32.44,43.71
    .zone Wetlands >>Take the boat to Menethil Harbor, Wetlands

-- WETLANDS --
step
    #completewith wetlands
    .zone Wetlands >>Head to Menethil Harbor, Wetlands
step
    .isOnQuest 942
    .goto Wetlands,10.8,60.4
    .target Archaeologist Flagongut
    .turnin 942 >>Turn in The Absent Minded Prospector to |cRXP_FRIENDLY_Archaeologist Flagongut|r in Menethil Harbor
step
    .isOnQuest 470
    .goto Wetlands,11.8,58.0
    .target Sida
    .turnin 470 >>Turn in Digging Through the Ooze to |cRXP_FRIENDLY_Sida|r in Menethil Harbor
step
    .isOnQuest 474
    .goto Wetlands,9.8,57.4
    .target Captain Stoutfist
    .turnin 474 >>Turn in Defeat Nek'rosh to |cRXP_FRIENDLY_Captain Stoutfist|r in Menethil Harbor
step
    .isQuestTurnedIn 292
    .goto Wetlands,10.6,60.6
    .target Glorin Steelbrow
    .accept 293 >>Accept Clensing the Eye from |cRXP_FRIENDLY_Glorin Steelbrow|r in Menethil Harbor
step
    .goto Wetlands,10.8,55.8
    .target Harlo Barnaby
    .accept 472 >>Accept Fall of Dun Modr from |cRXP_FRIENDLY_Harlo Barnaby|r in Menethil Harbor
step
    .goto Wetlands,11.6,52.2
    .target Tarrel Rockweaver
    .accept 305 >>Accept In Search of the Excavation Team from |cRXP_FRIENDLY_Tarrel Rockweaver|r in Menethil Harbor
step
    .isOnQuest 296
    .goto Wetlands,38.0,51.2
    .target Ormer Ironbraid
    .turnin 296 >>Turn in Ormer's Revenge to |cRXP_FRIENDLY_Ormer Ironbraid|r at Whelgar's Excavation Site in Wetlands
step
    .isOnQuest 299
    .goto Wetlands,38.8,52.2
    .target Prospector Whelgar
    .turnin 299 >>Turn in Uncovering the Past to |cRXP_FRIENDLY_Prospector Whelgar|r at Whelgar's Excavation Site in Wetlands
step
    .isOnQuest 305
    .goto Wetlands,38.8,52.2
    .target Merrin Rockweaver
    .turnin 305 >>Turn in In Search of the Excavation Team to |cRXP_FRIENDLY_Merrin Rockweaver|r at Whelgar's Excavation Site in Wetlands
step
    .isOnQuest 275
    .goto Wetlands,56.2,40.6
    .target Rethiel the Greenwarden
    .turnin 275 >>Turn in Blisters on The Land to |cRXP_FRIENDLY_Rethiel the Greenwarden|r on road south of Dun Modr in Wetlands
step
    .isOnQuest 378
    .goto Wetlands,49.6,18.2
    .target Motley Garmason
    .turnin 378 >>Turn in The Fury Runs Deeps to |cRXP_FRIENDLY_Motley Garmason|r at Dun Modr in Wetlands
step
    #label wetlands
    .isOnQuest 472
    .goto Wetlands,49.8,18.2
    .target Longbraid the Grim
    .turnin 472 >>Turn in Fall of Dun Modr to |cRXP_FRIENDLY_Longbraid the Grim|r at Dun Modr in Wetlands

-- ARATHI / HILLSBRAD --
step
    #completewith next
    .zone Arathi Highlands >>Run to Refuge Point in Arathi Highlands
step
    #completewith next
    .fly Southshore
    .goto Arathi Highlands,45.6,46.0
    .target Cedrik Prose
step
    #completewith hillsbrad
    .zone Hillsbrad Foothills >>Head to Southshore, Hillsbrad Foothills
step
    -- level 28
    .itemcount 3712,10
    >>|cRXP_WARN_NOTE|r: You must be level 28 to accept this quest
    .goto Hillsbrad Foothills,51.8,58.6
    .target Chef Jessen
    >>Talk to |cRXP_FRIENDLY_Chef Jessen|r in Southshore
    .accept 555 >>Accept Soothing Turtle Bisque
    .turnin 555 >>Turn in Soothing Turtle Bisque
step
    .isOnQuest 540
    .goto Hillsbrad Foothills,50.6,57.0
    .target Loremaster Dibbs
    .turnin 540 >>Turn in Preserving Knowledge to |cRXP_FRIENDLY_Loremaster Dibbs|r in Southshore
step
    .isQuestTurnedIn 540
    .goto Hillsbrad Foothills,50.6,57.0
    .target Loremaster Dibbs
    .accept 542 >>Accept Return to Milton from |cRXP_FRIENDLY_Loremaster Dibbs|r in Southshore
step
    #label hillsbrad
    .isQuestTurnedIn 562
    .goto Hillsbrad Foothills,51.4,58.6
    .target Lieutenant Farren Orinelle
    .accept 563 >>Accept Reassignment from |cRXP_FRIENDLY_Lieutenant Farren Orinelle|r in Southshore

step << !Mage
    #completewith next
    .fly Ironforge
    .goto Hillsbrad Foothills,49.4,52.6
    .target Darla Harris

-- IRONFORGE --
step
    #completewith ironforge
    .zone Ironforge >>Head to Ironforge << !Mage
    .zone Ironforge >>Teleport to Ironforge << Mage
step
    .itemcount 4433,1
    >>Use the |cRXP_LOOT_Waterlogged Letter|r to Accept the quest
    .use 4433
    .accept 637 >>Accept Sully Balloo's Letter
step
    .isOnQuest 637
    .goto Ironforge,63.8,67.6
    .target Sara Balloo
    .turnin 637 >>Turn in Sully Balloo's Letter in |cRXP_FRIENDLY_Sara Balloo|r at The Military Ward in Ironforge
step
    .isQuestTurnedIn 637
    .goto Ironforge,63.8,67.6
    .target Sara Balloo
    .accept 683 >>Accept Sara Balloo's Plea from |cRXP_FRIENDLY_Sara Balloo|r at The Military Ward in Ironforge
step
    .isOnQuest 683
    .goto Ironforge,40.0,55.2
    .target King Magni Bronzebeard
    .turnin 683 >>Turn in Sara Balloo's Plea to |cRXP_FRIENDLY_King Magni Bronzebeard|r at The Great Forge in Ironforge
step
    .isQuestTurnedIn 683
    .goto Ironforge,40.0,55.2
    .target King Magni Bronzebeard
    .accept 686 >>Accept A King's Tribute from |cRXP_FRIENDLY_King Magni Bronzebeard|r in Ironforge
step
    >>Talk to |cRXP_FRIENDLY_Mistina Steelshield|r in Ironforge
    .goto Ironforge,43.6,33.2
    .target Mistina Steelshield
    .turnin 7802 >>Turn in A Donation of Wool
    .turnin 7803 >>Turn in A Donation of Silk
step
    .isOnQuest 686
    .goto Ironforge,38.6,87.0
    .target Grand Mason Marblesten
    .turnin 686 >>Turn in A King's Tribute to |cRXP_FRIENDLY_Grand Mason Marblesten|r at The Commons in Ironforge
step
    .itemcount 5352,1
    >>Use the |cRXP_LOOT_Book: The Powers Below|r to Accept the quest
    .use 5352
    .accept 968 >>Accept The Powers Below
step
    .isOnQuest 968
    .goto Ironforge,50.6,5.4
    .target Gerrig Bonegrip
    .turnin 968 >>Turn in The Powers Below to |cRXP_FRIENDLY_Gerrig Bonegrip|r at The Forlorn Cavern in Ironforge
step
    .isOnQuest 78923
    .goto Ironforge,50.6,6.2
    .target Gerrig Bonegrip
    .turnin 78923 >>Turn in Knowledge in the Deeps to |cRXP_FRIENDLY_Gerrig Bonegrip|r in Ironforge
step
    #label ironforge
    >>Talk to |cRXP_FRIENDLY_Bubulo Acerbus|r at Tinker Town in Ironforge
    .goto Ironforge,73.8,47.8
    .target Bubulo Acerbus
    .turnin 7807 >>Turn in A Donation of Wool
    .turnin 7808 >>Turn in A Donation of Silk

-- STORMWIND --
step
    #completewith stormwind
    .zone Stormwind City >> Take the Tram to Stormwind << !Mage
    .zone Stormwind City >> Teleport to Stormwind << Mage
step
    .isOnQuest 388
    .goto Stormwind City,69.6,40.0
    .target Nikova Raskol
    .turnin 388 >>Turn in The Color of Blood to |cRXP_FRIENDLY_Nikova Raskol|r at Old Town in Stormwind City
    >>|cRXP_WARN_NOTE|r: Nikova pats around Old Town
step
    .isOnQuest 135
    .goto Stormwind City,75.8,59.8
    .target Master Mathias Shaw
    .turnin 135 >>Turn in The Defias Brotherhood to |cRXP_FRIENDLY_Master Mathias Shaw|r at Old Town in Stormwind City
step
    .isQuestTurnedIn 394
    .goto Stormwind City,75.8,59.8
    .target Master Mathias Shaw
    .accept 395 >>Accept Brotherhood's End from |cRXP_FRIENDLY_Master Mathias Shaw|r at Old Town in Stormwind City
step
    #label stormwind
    >>Talk to |cRXP_FRIENDLY_Clavicus Knavingham|r at The Mage Quarter in Stormwind City
    .goto Stormwind City,44.2,73.6
    .target Clavicus Knavingham
    .turnin 7791 >>Turn in A Donation of Wool
    .turnin 7793 >>Turn in A Donation of Silk
step
    .isOnQuest 1078
    .goto Stormwind City,43.0,80.2
    .target Collin Mauren
    .turnin 1078 >>Turn in Retrieval for Mauren to |cRXP_FRIENDLY_Collin Mauren|r at The Mage Quarter in Stormwind City
step
    .isOnQuest 335
    .goto Stormwind City,26.4,78.4
    .target Zardeth of the Black Claw
    .turnin 335 >>Turn in A Noble Brew to |cRXP_FRIENDLY_Zardeth of the Black Claw|r in the Basement of The Slaughtered Lamb, Stormwind
step
    .isOnQuest 387
    .goto Stormwind City,41.2,58.0
    .target Warden Thelwater
    .turnin 387 >>Turn in Quell the Uprising to |cRXP_FRIENDLY_Warden Thelwater|r at The Mage Quarter in Stormwind City
step
    .isQuestTurnedIn 335
    .goto Stormwind City,26.4,78.4
    .target Zardeth of the Black Claw
    .accept 336 >>Accept A Noble Brew from |cRXP_FRIENDLY_Zardeth of the Black Claw|r in the Basement of The Slaughtered Lamb, Stormwind
step
    .isOnQuest 346
    .goto Stormwind City,45.8,38.6
    .target Brother Kristoff
    .turnin 346 >>Turn in Return to Kristoff to |cRXP_FRIENDLY_Brother Kristoff|r at Cathedral Square in Stormwind City
step
    .isOnQuest 293
    .goto Stormwind City,39.6,27.6
    .target Archbishop Benedictus
    .turnin 293 >>Turn in Cleansing the Eye to |cRXP_FRIENDLY_Archbishop Benedictus|r at Cathedral Square in Stormwind City
step
    .isOnQuest 395
    .goto Stormwind City,49.0,30.2
    .target Baros Alexston
    .turnin 395 >>Turn in Brotherhood's End to |cRXP_FRIENDLY_Baros Alexston|r at Cathedral Square in Stormwind City
step
    .isQuestTurnedIn 395
    .goto Stormwind City,49.0,30.2
    .target Baros Alexston
    .accept 396 >>Accept An Audience with the King from |cRXP_FRIENDLY_Baros Alexston|r at Cathedral Square in Stormwind City
step
    .isOnQuest 336
    .goto Stormwind City,75.2,31.6
    .target Lord Baurles K. Wishock
    .turnin 336 >>Turn in A Noble Brew to |cRXP_FRIENDLY_Lord Baurles K. Wishock|r at Stormwind Keep in Stormwind City
step
    .isOnQuest 542
    .goto Stormwind City,74.0,7.6
    .target Milton Sheaf
    .turnin 542 >>Turn in Return to Milton to |cRXP_FRIENDLY_Milton Sheaf|r at Stormwind Keep in Stormwind City
step
    .isOnQuest 396
    .goto Stormwind City,78.0,17.8
    .target Lady Katrana Prestor
    .turnin 396 >>Turn in An Audience with the King to |cRXP_FRIENDLY_Lady Katrana Prestor|r at Stormwind Keep in Stormwind City
step
    .isOnQuest 563
    .goto Stormwind City,72.6,16.0
    .target Major Samuelson
    .turnin 563 >>Turn in Reassignment to |cRXP_FRIENDLY_Major Samuelson|r at Stormwind Keep in Stormwind City
step
    +CONGRATULATIONS!!! You have completed this route.
]])