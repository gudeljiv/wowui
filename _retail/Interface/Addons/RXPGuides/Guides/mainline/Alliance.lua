RXPGuides.RegisterGuide([[
#df
#version 1
#group RestedXP Alliance 10-60
#name 9A_Drustvar
#displayname Chapter 9 - Drustvar
#next ZA_WarCampaign
<<Alliance
step
>>Abandon this Quest to get a Teleport to near the next objectives
.abandon 49302
step
.goto 895,35.22,24.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rosaline Madison
.accept 49302 >>Accept The Deadliest Catch
step
.goto 895,35.29,24.57
.skipgossip 1
.complete 49302,1 
step
>>Click the Cannon
.goto 895,36.33,29.82
.complete 49302,2 
step
>>Shoot Harpoons at the Purple Bubbles
.complete 49302,3 
step
>>Click the Gryphon
.goto 895,36.77,29.71
.complete 49302,5 
step
.goto 895,42.47,29.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brannon Stormsong
.turnin 49302,1 >>Turn in The Deadliest Catch
step
.goto 896,62.54,23.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to David Maldus
.accept 48677,1 >>Accept Wicker Worship
step
.goto 896,59.45,21.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Autumnvale
.turnin 48677,1 >>Turn in Wicker Worship
.accept 48678,1 >>Accept Questionable Offerings
step
>>Deliver Entrails to Lord Autumvale
.goto 896,59.88,21.99
.complete 48678,1,1 
step
>>Deliver Wicker to Lord Autumvale
.goto 896,59.88,21.99
.complete 48678,1,2 
step
>>Deliver Bones to Lord Autumvale
.goto 896,59.89,21.96
.complete 48678,1,3 
step
>>Wait for the Roleplay Duration
.complete 48678,2 
step
.goto 896,59.45,21.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Autumnvale
.turnin 48678 >>Turn in Questionable Offerings
.accept 48679 >>Accept Mind the Hives
step
>>Go inside the Cave
.goto 896,60.65,18.19,10,0
.goto 896,60.62,17.77
.complete 48679,1 
step
>>Defend Edwin from the Bee's
.goto 896,60.62,17.77
.complete 48679,2 
step
.goto 896,60.65,18.19,10,0
.goto 896,59.03,22.37
>>Go outside the Cave
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Initiate Peony
.turnin 48679 >>Turn in Mind the Hives
.accept 48682 >>Accept A Simple Sacrifice
step
>>Kill Lord Autumnvale
.goto 896,56.50,24.05
.complete 48682,1 
step
.goto 896,56.49,24.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Edwin Maldus
.turnin 48682 >>Turn in A Simple Sacrifice
.accept 48683 >>Accept Changing Seasons
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Edwin
.goto 896,59.35,21.98
.complete 48683,1 
step
>>Click the Wickerman
.goto 896,59.35,21.98
.complete 48683,2 
step
.goto 896,59.35,21.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Edwin Maldus
.turnin 48683 >>Turn in Changing Seasons
step
.goto 896,63.25,27.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thomas Staughton
.accept 47946 >>Accept Save Their Bacon
.accept 47947 >>Accept Big Bad Wolves
.accept 47948 >>Accept Pork Chop
step
#sticky
#label bacon
.goto 896,64.07,31.70
>>Kill Beasts
.complete 47947,1 
step
>>Click on the Pig called Trevor
.goto 896,64.24,28.31
.complete 47946,1 
step
>>Click on the Pig called Travis
.goto 896,63.62,29.32
.complete 47946,2 
step
.goto 896,63.35,30.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Pig Effigy
.accept 47949 >>Accept That's Not My Fetish
step
>>Kill Roland
.goto 896,63.61,30.41
.complete 47948,1 
step
>>Click on the Pig called Burke
.goto 896,64.05,31.52
.complete 47946,4 
step
>>Click on the Pig called Kyle
.goto 896,64.70,30.21
.complete 47946,3 
step
#requires bacon
.goto 896,63.25,27.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thomas Staughton
.turnin 47946 >>Turn in Save Their Bacon
.turnin 47947 >>Turn in Big Bad Wolves
.turnin 47948,1 >>Turn in Pork Chop
.turnin 47949 >>Turn in That's Not My Fetish
.accept 47950 >>Accept Cured Ham
step
>>Use the Questitem in your Bags and throw the Pig Effigy in the Fire
.complete 47950,1 
.use 153432
step
.goto 896,63.25,27.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thomas Staughton
.turnin 47950 >>Turn in Cured Ham
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Cyril White by talking to Cyril White you skip the Ferry Step
.goto 896,56.14,35.29
.skipgossip 1
.complete 48622,1 
.complete 48622,2 
step
>>Click the Effigy
.goto 896,55.87,35.07
.complete 48622,3 
step
.goto 896,55.87,35.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Cursed Effigy
.turnin 53434 >>Turn in The Vanishing Lord
step
.goto 896,56.13,35.30
>>Click the Major's Bulletin
.accept 47968 >>Accept Signs and Portents
step
>>Click the Letter
.goto 896,57.95,35.69
.complete 47968,2 
step
>>Click the Notebook
.goto 896,55.21,35.97
.complete 47968,3 
step
>>Click the Journal
.goto 896,55.27,35.48,5,0
.goto 896,53.22,35.13
.complete 47968,1 
step
.goto 896,55.64,35.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Fallhaven Ledger
.turnin 47968 >>Turn in Signs and Portents
.accept 47978 >>Accept The Wayward Crone
step
.goto 896,60.51,31.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Helena Gentle
.turnin 47978 >>Turn in The Wayward Crone
.accept 47979 >>Accept Witch Hunt
step
>>Click the Chair
.goto 896,60.48,31.59
.complete 47979,1 
step
.goto 896,60.58,31.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gentle's Spellbook
.accept 47981 >>Accept Cracking the Curse
step
.goto 896,60.85,30.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Fallhaven Villager
.accept 47980 >>Accept Furious Familiars
step
#completewith next
>>Kill the Wildlife in the Area
.complete 47980,1 
step
>>Click the Lesser Effigy
.goto 896,59.58,28.32
.complete 47981,1,1 
step
#completewith next
>>Kill the Wildlife in the Area
.complete 47980,1 
step
>>Kill Helena
.goto 896,57.79,28.14
.complete 47979,2 
step
>>Click the Quest Popup's in your Questlog to turn in the Quest
.turnin 47979 >>Turn in Witch Hunt
step
#completewith next
>>Kill the Wildlife in the Area
.complete 47980,1 
step
>>Click the Lesser Effigy
.goto 896,57.66,27.81
.complete 47981,1,2 
step
#completewith next
>>Kill the Wildlife in the Area
.complete 47980,1 
step
>>Click the Lesser Effigy
.goto 896,57.54,30.06
.complete 47981,1,3 
step
#completewith next
>>Kill the Wildlife in the Area
.complete 47980,1 
step
>>Click the Quest Popup's in your Questlog to turn in the Quest
.turnin -47980 >>Turn in Furious Familiars
step
>>Click the Lesser Effigy
.goto 896,56.15,29.09
.complete 47981,1,4 
step
>>Kill the Wildlife in the Area
.complete 47980,1 
step
>>Click the Quest Popup's in your Questlog to turn in the Quest
.turnin -47980 >>Turn in Furious Familiars
step
.goto 896,55.87,35.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Cursed Effigy
.turnin 47981 >>Turn in Cracking the Curse
.accept 47982 >>Accept The Final Effigy
step
>>Click the Cursed Effigy
.goto 896,55.87,35.06
.complete 47982,1 
step
>>Kill the Deathcursed Terror
.complete 47982,2 
step
.goto 896,55.87,35.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Cyril White
.turnin 47982,2 >>Turn in The Final Effigy
.accept 48108 >>Accept The Waycrest Daughter
step
.goto 896,55.74,34.99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wanted Poster
.accept 51547 >>Accept WANTED: Rindlewoe
step
.goto 896,55.16,35.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Maude Rifthold
.accept 48948 >>Accept The North Pass Caverns
step
>>Kill Rindlewoe (skip if it's too hard)
.goto 896,52.33,28.94
.complete 51547,1 
step
.goto 896,53.93,26.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thaddeus "Gramps" Rifthold
.turnin 48948 >>Turn in The North Pass Caverns
step
.goto 896,53.93,26.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thaddeus "Gramps" Rifthold
.accept 48793 >>Accept The Adventurer's Society
.accept 48792 >>Accept Menace to Society
step
#sticky
#label troggs
>>Kill Troggs
.complete 48792,1 
step
>>Click the Backpack
.goto 896,53.37,25.78
.skipgossip 1
.complete 48793,1 
step
>>Click the Scroll in the Cave
.goto 896,53.52,23.24
.complete 48793,2 
step
>>Click the Book
.goto 896,53.05,22.42
.complete 48793,3 
step
>>Click the Journal
.goto 896,51.81,24.14
.complete 48793,4 
step
.goto 896,51.37,23.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marcus Howlingdale
.turnin 48793 >>Turn in The Adventurer's Society
.accept 48804 >>Accept Mistakes Were Made
step
.goto 896,51.82,22.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tClick the Scroll
.accept 48805 >>Accept Research Recovery
step
>>Click the Disk
.goto 896,51.59,21.92
.complete 48805,2 
step
>>Interact with Amelia
.goto 896,51.66,21.46
.complete 48804,2 
step
>>Interact with Jonathan
.goto 896,52.67,20.97
.complete 48804,1 
step
.goto 896,50.76,20.22
.complete 48805,1 
step
>>Interact with Chase
.goto 896,50.64,22.09
.complete 48804,3 
step
>>Click the Shards
.goto 896,51.14,22.53
.complete 48805,3 
step
#requires troggs
.goto 896,50.61,24.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marcus Howlingdale
.turnin 48805 >>Turn in Research Recovery
.turnin 48804 >>Turn in Mistakes Were Made
.turnin 48792 >>Turn in Menace to Society
.accept 48853 >>Accept Terminal Degree
step
>>Kill Cragg
.goto 896,49.68,23.52
.complete 48853,1 
step
>>Interact with Nigel
.goto 896,49.41,23.39
.complete 48853,2 
step
.goto 896,50.59,24.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thaddeus "Gramps" Rifthold
.turnin 48853 >>Turn in Terminal Degree
step
.goto 896,55.87,35.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Cyril White
.turnin 51547 >>Turn in WANTED: Rindlewoe
step
.goto 896,54.55,39.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Abby Lewis
.accept 47289 >>Accept Teddies and Tea
step
>>Click Plush 1
.goto 896,56.29,38.15
.complete 47289,3 
step
>>Click Plush 2
.goto 896,55.61,38.55
.complete 47289,1 
step
>>Click Plush 3
.goto 896,55.39,39.76
.complete 47289,2 
step
.goto 896,56.29,38.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Abby Lewis
.turnin 47289 >>Turn in Teddies and Tea
.accept 47428 >>Accept Kitty?
step
.goto 896,55.60,41.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Smoochums
.turnin 47428 >>Turn in Kitty?
step
.goto 896,54.55,39.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Abby Lewis
.accept 47289 >>Accept Teddies and Tea
step
.goto 896,55.39,39.76
.complete 47289,2 
step
.goto 896,55.61,38.55
.complete 47289,1 
step
.goto 896,56.29,38.15
.complete 47289,3 
step
.goto 896,56.29,38.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Abby Lewis
.turnin 47289 >>Turn in Teddies and Tea
.accept 47428 >>Accept Kitty?
step
.goto 896,55.60,41.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Smoochums
.turnin 47428 >>Turn in Kitty?
.accept 45079 >>Accept The Village of Glenbrook
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Samujel
.goto 896,55.53,45.26
.complete 45079,3 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jonathan
.goto 896,57.16,46.42
.complete 45079,2 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Mary
.goto 896,53.15,44.43
.complete 45079,1 
step
.goto 896,54.74,49.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Annie Warren
.turnin 45079 >>Turn in The Village of Glenbrook
.accept 44785 >>Accept Tea Party
step
>>Follow the Waypoint
.goto 896,56.39,49.04
.complete 44785,1 
step
>>Click the Tea
.goto 896,58.19,47.90
.complete 44785,2 
step
>>Click the Monster
.goto 896,58.19,47.90
.complete 44785,3 
step
.goto 896,57.70,47.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Annie Warren
.turnin 44785 >>Turn in Tea Party
step
.goto 896,70.09,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Constable Henry Framer
.turnin 48108 >>Turn in The Waycrest Daughter
.accept 48283 >>Accept Standing Accused
step
.goto 896,70.09,42.94
.skipgossip 1
.complete 48283,1 
step
.goto 896,69.67,43.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Everit Reade
.turnin 48283 >>Turn in Standing Accused
.accept 48109 >>Accept The Woods Have Eyes
.accept 48110 >>Accept In Case of Ambush
step
#sticky
#labels traps1
.complete 48110,1 
step
>>Kill Ravens and Wolves
.goto 896,68.57,45.00
.complete 48109,2 
.complete 48109,1 
step
#requires traps1
.goto 896,69.66,43.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Everit Reade
.turnin 48109 >>Turn in The Woods Have Eyes
.turnin 48110 >>Turn in In Case of Ambush
step
.goto 896,70.08,42.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lucille Waycrest
.accept 48111 >>Accept Trial by Superstition
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Villager 1
.goto 896,69.89,42.83
.skipgossip 1
.complete 48111,1,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Villager 2
.goto 896,69.90,42.91
.skipgossip 1
.complete 48111,1,2 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Villager 3
.goto 896,69.98,42.99
.skipgossip 1
.complete 48111,1,3 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Villager 4
.goto 896,70.04,43.03
.skipgossip 1
.complete 48111,1,4 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Villager 5
.goto 896,70.04,43.14
.skipgossip 1
.complete 48111,1,5 
step
.goto 896,70.08,42.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lucille Waycrest
.turnin 48111 >>Turn in Trial by Superstition
.accept 48113 >>Accept A Pungent Solution
.accept 48165 >>Accept Harmful If Swallowed
.accept 48170 >>Accept Once Bitten, Twice Shy
step
>>Click the Jar
.goto 896,69.52,43.85
.complete 48170,1 
step
#sticky
#label flies
>>Click the Flies in the Area
.complete 48170,2 
step
>>Kill and LOOT Saurolisks
.goto 896,68.82,40.64
.complete 48165,1 
step
#requires flies
.goto 896,66.91,42.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Adela Hawthorne
.accept 49242 >>Accept Quill or Be Quilled
step
#sticky
#label quill
.complete 49242,1 
step
>>Click the Herbs on the Ground until you get the Juicy Onion
.goto 896,66.12,41.87
.complete 48113,1 
step
#requires quill
.goto 896,66.93,42.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Adela Hawthorne
.turnin 49242 >>Turn in Quill or Be Quilled
step
.goto 896,70.07,42.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lucille Waycrest
.turnin 48113 >>Turn in A Pungent Solution
.turnin 48170 >>Turn in Once Bitten, Twice Shy
.turnin 48165 >>Turn in Harmful If Swallowed
step
.goto 896,71.80,50.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Art Hughie
.accept 48880 >>Accept Mean Gulls
.accept 48904 >>Accept Take the Bait
step
#completewith Guts
>>Kill and LOOT Crabs
.complete 48904,1 
step
#completewith Guts
>>Kill Gulls
.complete 48880,1 
step
#completewith Guts
>>Click the Objects on the Ground
.complete 48882,1 
step
#label Guts
.goto 896,70.75,50.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Intact Mudfish
.accept 48882 >>Accept I Like Fish Guts and I Cannot Lie
step
#completewith Guts2
>>Kill and LOOT Crabs
.complete 48904,1 
step
#completewith Guts2
>>Kill Gulls
.complete 48880,1 
step
#completewith Guts2
>>Click the Objects on the Ground
.complete 48882,1 
step
#label Guts2
.goto 896,71.14,52.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Fishing Rod
.accept 48881 >>Accept The Reel Deal
step
#completewith Guts3
>>Kill and LOOT Crabs
.complete 48904,1 
step
#completewith Guts3
>>Kill Gulls
.complete 48880,1 
step
#completewith Guts3
>>Click the Objects on the Ground
.complete 48882,1 
step
#label Guts3
>>Click the Rod
.goto 896,71.24,51.68
.complete 48881,1,1 
step
#completewith Guts4
>>Kill and LOOT Crabs
.complete 48904,1 
step
#completewith Guts4
>>Kill Gulls
.complete 48880,1 
step
#completewith Guts4
>>Click the Objects on the Ground
.complete 48882,1 
step
#label Guts4
>>Click the Rod
.goto 896,71.08,52.84
.complete 48881,1,2 
step
#completewith Guts5
>>Kill and LOOT Crabs
.complete 48904,1 
step
#completewith Guts5
>>Kill Gulls
.complete 48880,1 
step
#completewith Guts5
>>Click the Objects on the Ground
.complete 48882,1 
step
#label Guts5
>>Click the Rod
.goto 896,70.83,53.43
.complete 48881,1,3 
step
#completewith Guts6
>>Kill and LOOT Crabs
.complete 48904,1 
step
#completewith Guts6
>>Kill Gulls
.complete 48880,1 
step
#completewith Guts6
>>Click the Objects on the Ground
.complete 48882,1 
step
#label Guts6
>>Click the Rod
.goto 896,70.49,54.14
.complete 48881,1,4 
step
#completewith Guts7
>>Kill and LOOT Crabs
.complete 48904,1 
step
#completewith Guts7
>>Kill Gulls
.complete 48880,1 
step
#completewith Guts7
>>Click the Objects on the Ground
.complete 48882,1 
step
#label Guts7
>>Click the Rod
.goto 896,70.11,55.07
.complete 48881,1,5 
step
.goto 896,69.69,55.52
>>Click the Quest Popup's in your Questlog to turn in the Quest
.turnin 48881 >>Turn in The Reel Deal
step
>>If you haven't finished it yet
.complete 48904,1 
.complete 48880,1 
.complete 48882,1 
step
.goto 896,71.80,50.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Art Hughie
.turnin 48880 >>Turn in Mean Gulls
.turnin 48882 >>Turn in I Like Fish Guts and I Cannot Lie
.turnin 48904 >>Turn in Take the Bait
.accept 48883 >>Accept Big Gulls Won't Die
step
>>Kill Brinebeak
.goto 896,71.46,49.11
.complete 48883,1 
step
.goto 896,71.81,50.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Art Hughie
.turnin 48883 >>Turn in Big Gulls Won't Die
step
.goto 896,62.62,42.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Caretaker Allen
.accept 48475 >>Accept Seeing Spirits
step
>>Click Graveblooms in the Area
.goto 896,60.31,44.88
.complete 48475,1 
step
>>Click the Ritual Urn
.goto 896,59.99,45.86
.complete 48475,2 
step
>>Click Aaron
.goto 896,60.75,46.60
.complete 48475,3 
step
.goto 896,60.75,46.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Aaron Cresterly
.turnin 48475 >>Turn in Seeing Spirits
.accept 48476 >>Accept Split Party
step
>>Kill Wicker-Bound Hunter
.goto 896,60.32,47.96
.complete 48476,1 
step
.goto 896,59.80,48.94
>>wait for the small roleplay
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bridget Fairwater
.turnin 48476 >>Turn in Split Party
.accept 48477 >>Accept Looking For One More
step
>>Kill Sister Westwood
.goto 896,59.07,50.33
.complete 48477,1 
step
.goto 896,59.50,51.19
>>Wait for the Small Roleplay
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Mercy Fairwater
.turnin 48477 >>Turn in Looking For One More
step
.goto 896,64.58,54.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rebecca Hale
.accept 52074 >>Accept Deliverance
step
.goto 896,61.91,59.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ranger Wons
.turnin 52074 >>Turn in Deliverance
.accept 48179 >>Accept Rescue Rangers
.accept 52075 >>Accept Boned
step
.goto 896,61.87,59.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thornspeaker Birchgrove
.accept 48182 >>Accept Total Cairnage
.accept 48183 >>Accept The Hills Are Alive
step
>>Kill the Skeletons
#completewith 1
.complete 52075,1 
step
>>Click the Injured Npcs or Heal the Npcs
#completewith 1
.complete 48179,1 
step
#completewith 1
>>Kill and LOOT Elementals
.complete 48183,1 
step
#label 1
>>Click the Ancient Cairn
.goto 896,60.89,60.96
.complete 48182,1,1 
step
>>Kill Skeletons
#completewith 2
.complete 52075,1 
step
>>Click the Injured Npcs or Heal the Npcs
#completewith 2
.complete 48179,1 
step
#completewith 2
>>Kill and LOOT Elementals
.complete 48183,1 
step
#label 2
>>Click the Ancient Cairn
.goto 896,62.55,64.68
.complete 48182,1,2 
step
>>Kill Skeletons
#completewith 3
.complete 52075,1 
step
>>Click the Injured Npcs or Heal the Npcs
#completewith 3
.complete 48179,1 
step
#completewith 3
>>Kill and LOOT Elementals
.complete 48183,1 
step
#label 3
>>Click the Ancient Cairn
.goto 896,59.46,63.74
.complete 48182,1,3 
step
.goto 896,58.45,63.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Arthur Tradewind
.accept 48180 >>Accept Really Big Problem
step
>>There are Scrolls near the Sentinel to make the fight easier
>>Kill the Ancient Sentinel
.complete 48180,1 
step
>>Kill Skeletons
#completewith 4
.complete 52075,1 
step
>>Click the Injured Npcs or Heal the Npcs
#completewith 4
.complete 48179,1 
step
#completewith 4
>>Kill and LOOT Elementals
.complete 48183,1 
step
#label 4
>>Click the Ancient Cairn
.goto 896,59.34,66.25
.complete 48182,1,4 
step
>>Kill Skeletons
#completewith 5
.complete 52075,1 
step
>>Click the Injured Npcs or Heal the Npcs
#completewith 5
.complete 48179,1 
step
#completewith 5
>>Kill and LOOT Elementals
.complete 48183,1 
step
#label 5
>>Click the Major Ancient Cairn
.goto 896,59.14,67.88
.complete 48182,2
step
>>If you haven't finished it yet
.complete 52075,1 
.complete 48179,1 
.complete 48183,1 
step
.goto 896,61.88,59.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thornspeaker Birchgrove
.turnin 48180 >>Turn in Really Big Problem
.turnin 48182 >>Turn in Total Cairnage
.turnin 48183 >>Turn in The Hills Are Alive
step
.goto 896,61.91,59.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ranger Wons
.turnin 48179,2 >>Turn in Rescue Rangers
.turnin 52075 >>Turn in Boned
step
>>Use Hearthstone
#completewith next
.hs >> Hearthstone to Boralus
step
>>Done
]])
RXPGuides.RegisterGuide([[
#df
#version 1
#group RestedXP Alliance 10-60
#name 3A_Duskwood
#displayname Chapter 3 - Duskwood
#next 4A_Northern Stranglethorn
#fresh 30
#veteran
<<Alliance
step
#sticky
#completewith DuskwoodIntroduction
+Welcome to the Duskwood Guide of RestedXP.
step
#completewith next
.goto 47,80.52,20.87,30,0
.goto 47,74.27,26.00,10,0
.goto 47,77.26,35.77,15,0
+Check for a Chest near/inside the Building
step
#label DuskwoodIntroduction
.goto 47,78.74,44.76,20,0
.goto 47,79.08,44.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tobias Mistmantle inside a small House
.accept 26666 >>Accept The Legend of Stalvan
step
.goto 47,78.74,44.76,5,0
.goto 47,80.51,45.3,10,0
.goto 47,81.75,43.52,10,0
.goto 47,84.39,38.75,10,0
.goto 47,85.42,37.34,20,0
.goto 47,87.44,35.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Abercrombie
.accept 26653 >>Accept Supplies from Darkshire
step
#completewith next
.goto 47,87.98,33.16,15,0
.goto 47,88.1,31.33,10,0
.goto 47,90.94,30.56,50,0
+Check for the Unknown Soldier(Rare)
step <<!DarkIronDwarf !KulTiran !LightforgedDraenei !Mechagnome !VoidElf !DK
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 47,85.9,35.63,15,0
.goto 47,81.4,39.9,15,0
.goto 47,77.48,44.28
.fp >>Get the Darkshire Flight Path
step <<DarkIronDwarf KulTiran LightforgedDraenei Mechagnome VoidElf DK
#completewith next
+Direction to the next Objective
.goto 47,85.9,35.63,15,0
.goto 47,81.4,39.9,15,0
.goto 47,77.48,44.28,15,0
step <<DK
.isQuestTurnedIn 12801
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 47,82.5,36.22,15,0
.goto 47,77.48,44.28
.fp >>Get the Darkshire Flight Path
step
.goto 47,75.00,45.45,10,0
.goto 47,75.83,45.26
>>Jump on the House then fall down and go inside the House then Talk to Madame Eva
.turnin 26653 >>Turn in Supplies from Darkshire
.accept 26652 >>Accept Ghost Hair Thread
step
#completewith next
>>Go inside the Inn and Talk to Innkeeper Trelayne
.goto 47,73.87,46.09,5,0
.goto 47,73.84,45.53,5,0
.goto 47,74.05,45.25,5,0
.goto 47,73.87,44.40
.home >>Set your Hearthstone to Scarlet Raven Tavern
step
.goto 47,73.74,43.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Chef Grual
.accept 26620 >>Accept Seasoned Wolf Kabobs
.accept 26623 >>Accept Dusky Crab Cakes
step
.goto 47,73.9,43.98,7,0
.goto 47,74.02,45.53,7,0
.goto 47,72.45,46.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Clerk Daltry inside the Townhall
.turnin 26666 >>Turn in The Legend of Stalvan
.accept 26667 >>Accept The Stolen Letters
step
.goto 47,73.54,46.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Commander Althea Ebonlocke
.turnin -26728 >>Turn in Hero's Call: Duskwood!
step
.goto 47,73.54,46.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Commander Althea Ebonlocke
.accept 26618 >>Accept Wolves at Our Heels
step
.goto 47,75.33,48.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Calor
.accept 26688 >>Accept Worgen in the Woods
step <<DarkIronDwarf/Monk
#sticky
#completewith warmode1
.xp <20,1
.pve
+It's highly recommended to turn on Warmode when you reach Level 20 as soon as possible it will increase your Leveling Speed by up to 30%!
step <<DarkIronDwarf
.xp <20,1
#completewith next
.zoneskip 84
.pve
+Use your Racial "Mole Machine" Click it and Select (1) Eastern Kingdoms then (2) Stormwind
step <<DarkIronDwarf
.goto 84,70.07,47.25,10,0
.goto 84,68.61,51.24,10,0
.goto 84,67.3,57.41,20,0
.goto 84,67.3,57.41,20,0
.goto 84,68.67,62.27,15,0
.goto 84,65.94,64.29,15,0
.goto 84,64.13,66.9,15,0
.goto 84,68.33,75.04,15,0
.goto 84,70.22,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
.skill riding,150 >> Learn Journeyman Riding
step <<Monk
#completewith next
.xp <20,1
.zoneskip 84
.goto 379,48.96,43.36
.pve
+Use Zen Pilgrimage in your Spellbook then go and take the Stormwind Portal(manually skip this step if it didn't complete when you are in Stormwind)
step <<Monk
.xp <20,1
.goto 84,48.86,87.94,10,0
.goto 84,53.92,85.22,20,0
.goto 84,53.76,79.08,10,0
.goto 84,60.16,71.82,10,0
.goto 84,62.4,73.30,15,0
.goto 84,62.7,70.13,15,0
.goto 84,68.28,74.58,10,0
.goto 84,70.22,73.35
>>Go down the Spiral Staircase
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
>>Open Up your Talents and turn on Warmode
.skill riding,150 >> Learn Journeyman Riding
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 47
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 47,77.48,44.28
.zoneskip 84
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step <<DarkIronDwarf/Monk
#label warmode1
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Darkshire >>Fly to Darkshire
step << !Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felica
.goto 47,77.48,44.28
.fly Stormwind >>Fly to Stormwind
step << !Monk/!DarkIronDwarf
.xp <20,1
.goto 84,70.22,73.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
>>Open Up your Talents and turn on Warmode
.skill riding,150 >> Learn Journeyman Riding
step <<!Monk/!DarkIronDwarf
+Open Up your Talents(Default N) and turn on Warmode
*Skip this Step if you don't want to turn on Warmode(not recommended)
.pve
step << !Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 47
.fly Goldshire >>Fly to Goldshire
step << !Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 47,77.48,44.28
.zoneskip 84
.fly Goldshire >>Fly to Goldshire
step << !Monk/!DarkIronDwarf
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step << !Monk/!DarkIronDwarf
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Stormwind >>Fly to Darkshire
step
#completewith next
>>Kill and LOOT Spiders
#completewith next
.complete 26623,1 
step
#completewith next
+Check for Fenros(Rare) inside/outside of the Worgen Camp
.goto 47,72.6,45.91,10,0
step
#completewith next
+Check for the Chest inside of the Worgen Camp (don't spend too much time looking for it)
step
#label Area1
#sticky
>>Kill Nightbane Worgen in the Area
.complete 26688,1 
step
>>Click the Bundle of Letters
.goto 47,61.26,40.49
.complete 26667,1 
step
#requires Area1
#completewith next
+Check for Terrapis(Rare) across the Water while killing Wolves and Spiders(don't spend too much time looking for it)
step
#requires Area1
#completewith next
+Check for Lupos(Rare) patrolling around the Wolves and Spiders
step
#requires Area1
#sticky
#label Area2
>>Kill and LOOT Spiders
.complete 26623,1 
step
>>Kill and LOOT Wolves
.goto 47,65.68,30.88,20,0
.goto 47,64.95,20.56,20,0
.complete 26618,1 
.complete 26620,1 
step
#requires Area2
#completewith next
#level 20
.hs >> Hearthstone to Darkshire(if it's still on cooldown manually go to the next Waypoint)
step
#requires Area2
.goto 47,73.75,43.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Chef Grual
.turnin 26620 >>Turn in Seasoned Wolf Kabobs
.turnin 26623 >>Turn in Dusky Crab Cakes
step
#sticky
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Mabel Solaj if you need to sell
.goto 47,73.81,44.02,10,0
.vendor 227 >> sell as much as you can
step
.goto 47,74.03,45.44,10,0
.goto 47,73.8,46.08,7,0
.goto 47,72.44,46.91
>>Go Outside the Inn
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Clerk Daltry
.turnin 26667,1 >>Turn in The Stolen Letters
.accept 26669 >>Accept In A Dark Corner
step
.goto 47,73.54,46.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Commander Althea Ebonlocke
.turnin 26618,1 >>Turn in Wolves at Our Heels
.accept 26645 >>Accept The Night Watch
step
.goto 47,75.34,48.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Calor
.turnin 26688 >>Turn in Worgen in the Woods
.accept 26689 >>Accept The Rotting Orchard
step <<DarkIronDwarf/Monk
#sticky
#completewith warmode2
.xp <20,1
.pve
+It's highly recommended to turn on Warmode when you reach Level 20 as soon as possible it will increase your Leveling Speed by up to 30%!
step <<DarkIronDwarf
.xp <20,1
#completewith next
.zoneskip 84
.pve
+Use your Racial "Mole Machine" Click it and Select (1) Eastern Kingdoms then (2) Stormwind
step <<DarkIronDwarf
.goto 84,70.07,47.25,10,0
.goto 84,68.61,51.24,10,0
.goto 84,67.3,57.41,20,0
.goto 84,67.3,57.41,20,0
.goto 84,68.67,62.27,15,0
.goto 84,65.94,64.29,15,0
.goto 84,64.13,66.9,15,0
.goto 84,68.33,75.04,15,0
.goto 84,70.22,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
.skill riding,150 >> Learn Journeyman Riding
step <<Monk
#completewith next
.xp <20,1
.zoneskip 84
.goto 379,48.96,43.36
.pve
+Use Zen Pilgrimage in your Spellbook then go and take the Stormwind Portal(manually skip this step if it didn't complete when you are in Stormwind)
step <<Monk
.xp <20,1
.goto 84,48.86,87.94,10,0
.goto 84,53.92,85.22,20,0
.goto 84,53.76,79.08,10,0
.goto 84,60.16,71.82,10,0
.goto 84,62.4,73.30,15,0
.goto 84,62.7,70.13,15,0
.goto 84,68.28,74.58,10,0
.goto 84,70.22,73.35
>>Go down the Spiral Staircase
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
>>Open Up your Talents and turn on Warmode
.skill riding,150 >> Learn Journeyman Riding
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 47
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 47,77.48,44.28
.zoneskip 84
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step <<DarkIronDwarf/Monk
#label warmode2
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Darkshire >>Fly to Darkshire
step << !Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felica
.goto 47,77.48,44.28
.fly Stormwind >>Fly to Stormwind
step << !Monk/!DarkIronDwarf
.xp <20,1
.goto 84,70.22,73.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
>>Open Up your Talents and turn on Warmode
.skill riding,150 >> Learn Journeyman Riding
step <<!Monk/!DarkIronDwarf
+Open Up your Talents(Default N) and turn on Warmode
*Skip this Step if you don't want to turn on Warmode(not recommended)
.pve
step << !Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 47
.fly Goldshire >>Fly to Goldshire
step << !Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 47,77.48,44.28
.zoneskip 84
.fly Goldshire >>Fly to Goldshire
step << !Monk/!DarkIronDwarf
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step << !Monk/!DarkIronDwarf
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Stormwind >>Fly to Darkshire
step
.goto 47,79.55,47.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Viktori Prism'Antras
.accept 26683 >>Accept Look To The Stars
step
#completewith next
+Check for Watcher Eva(Rare) infront/inside the House
.goto 47,81.29,59.64,0,0
step
#label Area98
#sticky
>>Kill Ghouls
.complete 26645,1 
step
#requires Area98
.goto 47,81.92,58.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Blind Mary
.turnin 26652 >>Turn in Ghost Hair Thread
.accept 26654 >>Accept Return the Comb
.turnin 26683 >>Turn in Turn in Look To The Stars
.accept 26684 >>Accept The Insane Ghoul
step
.goto 47,81.56,59.1,5,0
.goto 47,75.33,45.42,5,0
.goto 47,75.79,45.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Madame Eva in Darkshire
.turnin 26654 >>Turn in Return the Comb
.accept 26655 >>Accept Deliver the Thread
step
.goto 47,87.43,35.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Abercrombie
.turnin 26655,2 >>Turn in Deliver the Thread
.accept 26660 >>Accept Zombie Juice
step
#completewith next
.goto 47,87.98,33.16,15,0
.goto 47,90.94,30.56,15,0
+If you haven't recently killed the Unknown Soldier Check for the Unknown Soldier(Rare)(manually skip this step if you have checked already)
step
.goto 47,85.29,35.92,15,0
.goto 47,80.13,39.56,15,0
.goto 47,76.17,43.13,15,0
.goto 47,76.17,43.13,15,0
.goto 47,74.75,45.96,15,0
.goto 47,73.85,46.07,15,0
.goto 47,73.83,45.5,5,0
.goto 47,74.05,45.29,5,0
.goto 47,74.09,44.71
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tavernkeep Smitts
.turnin 26660 >>Turn in Zombie Juice
.accept 26661 >>Accept Gather Rot Blossoms
step
.goto 47,73.99,45.48,5,0
.goto 47,73.8,46.05,5,0
.goto 47,73.53,46.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Commander Althea Ebonlocke
.turnin 26645 >>Turn in The Night Watch
.accept 26686 >>Accept Bones That Walk
step <<DarkIronDwarf/Monk
#sticky
#completewith warmode3
.xp <20,1
.pve
+It's highly recommended to turn on Warmode when you reach Level 20 as soon as possible it will increase your Leveling Speed by up to 30%!
step <<DarkIronDwarf
.xp <20,1
#completewith next
.zoneskip 84
.pve
+Use your Racial "Mole Machine" Click it and Select (1) Eastern Kingdoms then (2) Stormwind
step <<DarkIronDwarf
.goto 84,70.07,47.25,10,0
.goto 84,68.61,51.24,10,0
.goto 84,67.3,57.41,20,0
.goto 84,67.3,57.41,20,0
.goto 84,68.67,62.27,15,0
.goto 84,65.94,64.29,15,0
.goto 84,64.13,66.9,15,0
.goto 84,68.33,75.04,15,0
.goto 84,70.22,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
.skill riding,150 >> Learn Journeyman Riding
step <<Monk
#completewith next
.xp <20,1
.zoneskip 84
.goto 379,48.96,43.36
.pve
+Use Zen Pilgrimage in your Spellbook then go and take the Stormwind Portal(manually skip this step if it didn't complete when you are in Stormwind)
step <<Monk
.xp <20,1
.goto 84,48.86,87.94,10,0
.goto 84,53.92,85.22,20,0
.goto 84,53.76,79.08,10,0
.goto 84,60.16,71.82,10,0
.goto 84,62.4,73.30,15,0
.goto 84,62.7,70.13,15,0
.goto 84,68.28,74.58,10,0
.goto 84,70.22,73.35
>>Go down the Spiral Staircase
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
>>Open Up your Talents and turn on Warmode
.skill riding,150 >> Learn Journeyman Riding
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 47
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 47,77.48,44.28
.zoneskip 84
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step <<DarkIronDwarf/Monk
#label warmode3
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Darkshire >>Fly to Darkshire
step << !Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felica
.goto 47,77.48,44.28
.fly Stormwind >>Fly to Stormwind
step << !Monk/!DarkIronDwarf
.xp <20,1
.goto 84,70.22,73.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
>>Open Up your Talents and turn on Warmode
.skill riding,150 >> Learn Journeyman Riding
step <<!Monk/!DarkIronDwarf
+Open Up your Talents(Default N) and turn on Warmode
*Skip this Step if you don't want to turn on Warmode(not recommended)
.pve
step << !Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 47
.fly Goldshire >>Fly to Goldshire
step << !Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 47,77.48,44.28
.zoneskip 84
.fly Goldshire >>Fly to Goldshire
step << !Monk/!DarkIronDwarf
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step << !Monk/!DarkIronDwarf
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Stormwind >>Fly to Darkshire
step
#label Area3
#sticky
>>Kill the Skeletals in the Area
.complete 26686,1 
.complete 26686,2 
step
#completewith next
+Check for Watcher Eva(Rare) in the Area(If you haven't recently killed her)
step
#completewith next
>>Click the Blossoms on the Ground in the Area
.complete 26661,1 
step
>>Kill and LOOT the Insane Ghoul
.goto 47,78.76,62.48,50,0
.goto 47,80.73,71.54
.complete 26684,1 
step
>>Click the Blossoms on the Ground in the Area
.goto 47,79.52,70.52
.complete 26661,1 
step
#requires Area3
#completewith next
+Check for the Chest infront of the Mine
.goto 47,73.53,74.24,15,0
step
#requires Area3
#completewith next
+Check for the Chest inside the Building with the Journal
.goto 47,65.93,75.65,15,0
step
#requires Area3
#completewith next
>>Kill Shadow Weavers
.complete 26689,1 
step
#requires Area3
>>Click the Journal
.goto 47,66.55,76.53
.complete 26669,1 
step
#completewith next
+Check for the Chest inside the lost Building
*Check for Marus Rare near the Chest
.goto 47,65.93,76.33,5,0
.goto 47,65.98,75.71,5,0
.goto 47,65.43,67.83,5,0
.goto 47,64.94,67.27,8,0
.goto 47,65.79,66.87,8,0
step
>>Kill Shadow Weavers
.complete 26689,1 
step
.goto 47,72.96,46.79,7,0
.goto 47,72.45,46.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Clerk Daltry
.turnin 26669 >>Turn in In A Dark Corner
.accept 26670 >>Accept Roland's Doom
step
.goto 47,73.53,46.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Commander Althea Ebonlocke
.turnin 26686,1 >>Turn in Bones That Walk
step
.goto 47,73.81,45.56,5,0
.goto 47,74.06,45.29,5,0
.goto 47,73.78,44.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tavernkeep Smitts(might patrol a little)
.turnin 26661 >>Turn in Gather Rot Blossoms
.accept 26676 >>Accept Juice Delivery
step
.goto 47,74.06,45.29,5,0
.goto 47,73.81,45.56,5,0
.goto 47,75.33,48.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Calor outside the Inn
.turnin 26689,1 >>Turn in The Rotting Orchard
.accept 26690 >>Accept Vile and Tainted
step
#completewith defined3
+It's highly recommended to turn on Warmode when you reach Level 20 as soon as possible it will increase your Leveling Speed by up to 30%!
step <<DarkIronDwarf
#level 20
#completewith next
.zoneskip 84
+Use your Racial "Mole Machine" Click it and Select (1) Eastern Kingdoms then (2) Stormwind
step <<DarkIronDwarf
.goto 84,70.07,47.25,10,0
.goto 84,68.61,51.24,10,0
.goto 84,67.3,57.41,20,0
.goto 84,67.3,57.41,20,0
.goto 84,68.67,62.27,15,0
.goto 84,65.94,64.29,15,0
.goto 84,64.13,66.9,15,0
.goto 84,68.33,75.04,15,0
.goto 84,70.22,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
>>Open Up your Talents and turn on Warmode
.skill riding,150 >> Learn Journeyman Riding
step <<Monk
#completewith next
#level 20
.zoneskip 84
.goto 379,48.96,43.36
+Use Zen Pilgrimage in your Spellbook then go and take the Stormwind Portal(manually skip this step if it didn't complete when you are in Stormwind)
step <<Monk
#level 20
.goto 84,48.86,87.94,10,0
.goto 84,53.92,85.22,20,0
.goto 84,53.76,79.08,10,0
.goto 84,60.16,71.82,10,0
.goto 84,62.4,73.30,15,0
.goto 84,62.7,70.13,15,0
.goto 84,68.28,74.58,10,0
.goto 84,70.22,73.35
>>Go down the Spiral Staircase
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
>>Open Up your Talents and turn on Warmode
.skill riding,150 >> Learn Journeyman Riding
step <<DarkIronDwarf/Monk
#completewith next
#level 20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
#level 20
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step <<DarkIronDwarf/Monk
#completewith defined3
#level 20
.isQuestAvailable 76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
>>Use Hearthstone if Ready
>>Manually Skip the other Option
.goto 37,41.72,64.44
.fly Darkshire >>Fly to Darkshire
.hs >> Hearthstone to Darkshire
step << !Monk/!DarkIronDwarf
#completewith next
#level 20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 37,77.48,44.28
.fly Goldshire >>Fly to Goldshire
step << !Monk/!DarkIronDwarf
#level 20
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step << !Monk/!DarkIronDwarf
#completewith next
#level 20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Stormwind >>Fly to Stormwind
step << !Monk/!DarkIronDwarf
#level 20
.goto 84,70.22,73.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
>>Open Up your Talents and turn on Warmode
.skill riding,150 >> Learn Journeyman Riding
step << !Monk/!DarkIronDwarf
#completewith defined3
#level 20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
>>Use Hearthstone if Ready
>>Manually Skip the other Option
.goto 84,70.94,72.45
.isQuestAvailable 76
.fly Darkshire >>Fly to Darkshire
.hs >> Hearthstone to Darkshire
step
#label defined3
.goto 47,79.54,47.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Viktori Prism'Antras inside a House
.turnin 26684 >>Turn in The Insane Ghoul
.accept 26685 >>Accept Classy Glass
step
.goto 47,87.45,35.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Abercrombie
.turnin 26676 >>Turn in Juice Delivery
.accept 26680 >>Accept Ogre Thieves
step
#completewith next
.goto 47,87.98,33.16,15,0
.goto 47,88.1,31.33,10,0
.goto 47,90.94,30.56
+You can test your luck again and check for the Unknown Soldier(Rare)(manually skip this step)
step
#completewith next
+Check for the Chest infront of the Mine again (manually skip this step)
step
#completewith next
+Check for the Chest inside the Mine(manually skip this step)
step
#completewith next
+Check for the Nefaru(Rare)
step
#label Area4
#completewith next
>>Kill the Nightbanes
.complete 26690,2 
.complete 26690,1 
step
>>Click the Journal in the Mine
.goto 47,79.00,47.49,25,0
.goto 47,73.53,74.24,20,0
.goto 47,73.62,79.20
.complete 26670,1 
step
>>Kill the Nightbanes
.goto 47,74.31,77.7,15,0
.goto 47,73.04,74.86,15,0
.complete 26690,2 
.complete 26690,1 
step
>>RXP Guides often use Deathskips to quickly go to the desired Location
>>You can Unequip your Gear or repeatedly spam /sit to die faster
#completewith next
.deathskip >> Pull as many Enemies as you can, Die and Respawn at the Graveyard
step
#requires Area4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Morg
#completewith next
.goto 47,73.97,48.87,10,0
>>Repairing here is important
.vendor 226 >> Repair and Sell as much as you can
step
#requires Area4
.goto 47,72.96,46.79,10,0
.goto 47,72.44,46.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Clerk Daltry
.turnin 26670,1 >>Turn in Roland's Doom
.accept 26671 >>Accept The Fate of Stalvan Mistmantle
step
.goto 47,75.31,48.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Calor
.turnin 26690 >>Turn in Vile and Tainted
.accept 26691 >>Accept Worgen in the Woods
step
.goto 47,75.24,48.23,5,0
.goto 47,75.39,49.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jonathan Carevin
.turnin 26691 >>Turn in Worgen in the Woods
step
.goto 47,75.22,48.25,7,0
.goto 47,79.09,44.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tobias Mistmantle inside the small House
.turnin 26671 >>Turn in The Fate of Stalvan Mistmantle
.accept 26672 >>Accept Clawing at the Truth
step <<DarkIronDwarf/Monk
#sticky
#completewith warmode4
.xp <20,1
.pve
+It's highly recommended to turn on Warmode when you reach Level 20 as soon as possible it will increase your Leveling Speed by up to 30%!
step <<DarkIronDwarf
.xp <20,1
#completewith next
.zoneskip 84
.pve
+Use your Racial "Mole Machine" Click it and Select (1) Eastern Kingdoms then (2) Stormwind
step <<DarkIronDwarf
.goto 84,70.07,47.25,10,0
.goto 84,68.61,51.24,10,0
.goto 84,67.3,57.41,20,0
.goto 84,67.3,57.41,20,0
.goto 84,68.67,62.27,15,0
.goto 84,65.94,64.29,15,0
.goto 84,64.13,66.9,15,0
.goto 84,68.33,75.04,15,0
.goto 84,70.22,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
.skill riding,150 >> Learn Journeyman Riding
step <<Monk
#completewith next
.xp <20,1
.zoneskip 84
.goto 379,48.96,43.36
.pve
+Use Zen Pilgrimage in your Spellbook then go and take the Stormwind Portal(manually skip this step if it didn't complete when you are in Stormwind)
step <<Monk
.xp <20,1
.goto 84,48.86,87.94,10,0
.goto 84,53.92,85.22,20,0
.goto 84,53.76,79.08,10,0
.goto 84,60.16,71.82,10,0
.goto 84,62.4,73.30,15,0
.goto 84,62.7,70.13,15,0
.goto 84,68.28,74.58,10,0
.goto 84,70.22,73.35
>>Go down the Spiral Staircase
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
>>Open Up your Talents and turn on Warmode
.skill riding,150 >> Learn Journeyman Riding
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 47
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 47,77.48,44.28
.zoneskip 84
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step <<DarkIronDwarf/Monk
#label warmode4
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Darkshire >>Fly to Darkshire
step << !Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felica
.goto 47,77.48,44.28
.fly Stormwind >>Fly to Stormwind
step << !Monk/!DarkIronDwarf
.xp <20,1
.goto 84,70.22,73.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
>>Open Up your Talents and turn on Warmode
.skill riding,150 >> Learn Journeyman Riding
step <<!Monk/!DarkIronDwarf
+Open Up your Talents(Default N) and turn on Warmode
*Skip this Step if you don't want to turn on Warmode(not recommended)
.pve
step << !Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 47
.fly Goldshire >>Fly to Goldshire
step << !Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 47,77.48,44.28
.zoneskip 84
.fly Goldshire >>Fly to Goldshire
step << !Monk/!DarkIronDwarf
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step << !Monk/!DarkIronDwarf
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Stormwind >>Fly to Darkshire
step
.goto 47,75.22,45.4,7,0
.goto 47,75.80,45.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Madame Eva inside the House
.turnin 26672 >>Turn in Clawing at the Truth
.accept 26674 >>Accept Mistmantle's Revenge
step
#sticky
#completewith QuestKeybindingsDuskwood
+If you want to make the most of RXP; Press Escape -> Options -> Keybindings -> RestedXP Guides -> Select and Bind Active Button 1,2,3 and 4
*This will allow you to press a Keybind to use a Quest Item rather than to manually have to Click it from the Bags or through a Click on the RXP Button
*In Dragonflight they have added a new Quest Feature that sometimes a Click on he Quest Objective is enough to use your Quest Item!
step
#label QuestKeybindingsDuskwood
>>Use the Item "Mistmantle Family Ring" in your Bags inside Stalvan House and Check for the Chest(don't look too long)
>>Kill Enemies in the Area while you wait
.goto 47,75.41,45.4,8,0
.goto 47,76.98,35.83,8,0
.goto 47,77.44,35.73,5,0
.goto 47,77.30,36.28
.complete 26674,1 
.use 59363
step
.goto 47,77.43,35.68,5,0
.goto 47,77.65,35.62,5,0
.goto 47,78.66,44.73,5,0
.goto 47,79.08,44.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tobias Mistmantle inside the small House
.turnin 26674,1 >>Turn in Mistmantle's Revenge
.accept 26785 >>Accept Part of the Pack
step
.goto 47,69.51,48.83,15,0
.goto 47,45.12,67.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Watcher Dodds
.accept 25235 >>Accept Vulgar Vul'Gol
step
.goto 47,44.91,67.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Apprentice Fess
.turnin 26785 >>Turn in Part of the Pack
.accept 26707 >>Accept A Deadly Vine
.accept 26717 >>Accept The Yorgen Worgen
step
#label Area6
#sticky
>>Kill and LOOT Corpseweed
.complete 26707,1 
step
#completewith next
+Check for Carved One(Rare) on the Field
step
>>Click the Dirt Pile
.goto 47,49.86,77.7
.complete 26717,1 
step
#requires Area6
#completewith next
+Check for the Chest at the Mine Entrance (don't look for too long)
.goto 47,33.53,75.33,10,0
.goto 47,34.2,76.83,10,0
step
#requires Area6
#completewith next
.complete 25235,1 
step
#requires Area6
>>Click the Crate
.goto 47,33.53,75.33,10,0
.complete 26680,1 
step
#completewith next
.complete 25235,1 
step
#completewith next
+Check for the Chest inside the Mine (don't look for too long)
.goto 47,35.6,80.19,10,0
step
>>Kill and LOOT Zzarc inside the Mine
.goto 47,37.85,84.3
.complete 26685,1 
step
>>Kill the remaining Ogre's
.goto 47,44.90,67.44
.complete 25235,1 
step
#requires Area7
.goto 47,44.90,67.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Apprentice Fess
.turnin 26707,1 >>Turn in A Deadly Vine
.turnin 26717 >>Turn in The Yorgen Worgen
.accept 26719 >>Accept Delivery to Master Harris
step
.goto 47,45.14,67.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Watcher Dodds outside the Mine
.turnin 25235 >>Turn in Vulgar Vul'Gol
]])
RXPGuides.RegisterGuide([[
#df
#version 1
#group RestedXP Alliance 10-60
#name 5A_Duskwood 2
#displayname Chapter 5 - Duskwood Part 2
#next 6A_Redridge Mountains 2
#fresh 30
#veteran
<<Alliance
step
#label Duskwood2Introduction
.goto 47,20.01,57.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sister Elsington in Duskwood
.accept 26777 >>Accept Soothing Spirits
step
.goto 47,18.64,58.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jitters
.accept 26721 >>Accept The Jitters-Bugs
step
.goto 47,18.31,57.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Oliver Harris
.turnin 26719 >>Turn in Delivery to Master Harris
.accept 26720 >>Accept A Curse We Cannot Lift
step
#completewith next
>>Use the Item "Holy Censer" in your Bags on Forlorn Spirits. Don't immediately run away from the Spirits after use of the Item
.use 60225
.complete 26777,1 
step
#label worgen1
>>Go inside the Stables to the Waypoint a Worg will attack you Use the Item "Harris's Ampule" in your Bags when he is below 20% health
.use 60206
.goto 47,21.65,72.34,5,0
.goto 47,21.29,72.73,5,0
.goto 47,21.61,73.15
.complete 26720,1 
step
>>Use the Item "Holy Censer" in your Bags on Forlorn Spirits. Don't immediately run away from the Spirits after use of the Item
.use 60225
.goto 47,21.65,72.34
.complete 26777,1 
step
#requires worgen1
.goto 47,18.33,57.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Oliver Harris
.turnin 26720 >>Turn in A Curse We Cannot Lift
.accept 26760 >>Accept Cry For The Moon
step
.goto 47,20.04,57.81
>>Be Quick There is Roleplay going on if you are too slow it might fail
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sister Elsington
.turnin 26777 >>Turn in Soothing Spirits
step
#completewith next
>>Be quick, there is roleplay going on and if you are too slow it might fail
.goto 47,21.07,56.51
.fp >>Get the Raven Hill Flight Path
step
#completewith next
>>You want to do this during the Roleplay
.goto 47,18.74,58.52
.vendor 44115 >> Sell as much as you can
step
.goto 47,18.31,57.68
>>Wait for the roleplay to finish. Ff there is no Roleplay anymore and you didn't get quest credit, abandon and reaccept the quest
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Oliver Harris
.accept 26760 >>Accept Cry For The Moon
.complete 26760,1 
step
.goto 47,18.30,57.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Oliver Harris
.turnin 26760,1 >>Turn in Cry For The Moon
step
.goto 47,18.35,58.08
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sven Yorgen
.accept 26723 >>Accept The Fate of Morbent Fel
step
.goto 47,20.02,57.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sister Elsington
.accept 26778 >>Accept The Cries of the Dead
step
>>Kill and LOOT Spiders(they might vanish for a second when they die)
.goto 47,30.08,48.89
.complete 26721,1 
step
.goto 47,17.68,29.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to A Weathered Grave. Be careful of Morladim patrolling the graveyard.
.accept 26793 >>Accept The Weathered Grave
step
>>Go into the House and Click the Remains. Check for a chest while you're inside.
.goto 47,17.49,33.40,5,0
.goto 47,17.44,34.17,5,0
.goto 47,16.98,33.40
.complete 26723,1 
step
>>Check for a chest here
.goto 47,19.88,44.60,20
step
.isQuestTurnedIn 31903,31889,31891,31902
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Eric Davidson
.goto 47,17.29,34.1,10,0
.goto 47,17.63,33.43,5,0
.goto 47,19.88,44.60
.accept 31850 >>Accept Eric Davidson
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Eric Davidson
>>Take any fast 25 Pets
.isOnQuest 31850
.complete 31850,1 
step
.isQuestComplete 31850
>>Click the Quest Pop-up to turn in the Quest
.turnin 31850 >>Turn in Questlog
step
#completewith next
>>Kill some ghouls while en route, you don't need to finish it here
.complete 26778,1 
step
.goto 47,18.35,58.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sven Yorgen
.turnin 26723 >>Turn in The Fate of Morbent Fel
.accept 26724 >>Accept The Lurking Lich
step
.goto 47,18.61,58.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jitters
.turnin 26721 >>Turn in The Jitters-Bugs
.accept 26787 >>Accept Bear In Mind
step
.goto 47,20.03,57.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sister Elsington
.turnin 26724 >>Turn in The Lurking Lich
.accept 26725 >>Accept Guided by the Light
step
#completewith next
>>Kill more ghouls
.complete 26778,1 
step
.goto 47,23.46,35.44
>>Click the Lightforged Rod
.turnin 26725 >>Turn in Guided by the Light
.accept 26753 >>Accept The Halls of the Dead
step
.goto 47,24.03,34.81,5,0
.goto 47,25.68,34.18,10,0
.goto 47,25.44,31.65,10,0
.goto 47,23.56,27.96,10,0
.goto 47,20.37,27.46
>>Click the Lightforged Arch inside the Catacombs
.turnin 26753 >>Turn in The Halls of the Dead
.accept 26722 >>Accept Buried Below
step
.goto 47,19.98,26.62,10,0
.goto 47,18.97,25.08,10,0
.goto 47,18.01,25.37
>>Enter the hole in the wall then click the Lightforged Crest
.turnin 26722 >>Turn in Buried Below
.accept 26754 >>Accept Morbent's Bane
step
>>Use the Item "Morbent's Bane" in your Bags on Morbent Fel to weaken him.
.use 60212
.goto 47,17.34,28.25,5,0
.goto 47,17.01,31.20
.complete 26754,1 
step
>> Finish killing Ghouls if needed
.goto 47,17.01,31.20
.complete 26778,1 
step
>>Kill and LOOT Bears. Look for Marina DeSirrus (rare) as you quest.
.goto 47,16.21,33.05,10,0
.goto 47,15.28,38.55,20,0
.goto 47,15.98,38.77,10,0
.goto 47,16.09,39.35,10,0
.goto 47,13.79,40.58,10,0
.goto 47,7.87,33.84,35,0
.goto 47,18.35,58.05
.complete 26787,1 
.unitscan Marina DeSirrus
step
.goto 47,18.35,58.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sven Yorgen
.turnin 26754,1 >>Turn in Morbent's Bane
step
.goto 47,18.60,58.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jitters
.turnin 26787 >>Turn in Bear In Mind
step
.goto 47,20.01,57.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sister Elsington
.turnin 26778 >>Turn in The Cries of the Dead
step
#completewith next
.hs >> Heartstone to Darkshire
step
.goto 47,74.08,45.44,5,0
.goto 47,73.82,45.98,5,0
.goto 47,72.53,46.87,5,0
.goto 47,72.60,47.77
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sirra Von'Indi
.turnin 26793 >>Turn in The Weathered Grave
.accept 26794 >>Accept Morgan Ladimore
step
.goto 47,72.52,47.16,5,0
.goto 47,72.85,46.9,5,0
.goto 47,73.53,46.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Commander Althea Ebonlocke
.turnin 26794 >>Turn in Morgan Ladimore
step
.goto 47,79.54,47.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Viktori Prism'Antras
.destroy 2154 >> You can destroy The Story of Morgan Ladimore now.
.turnin 26685,1 >>Turn in Classy Glass
step
.goto 47,87.44,35.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Abercrombie
.turnin 26680 >>Turn in Ogre Thieves
.accept 26677 >>Accept Ghoulish Effigy
step
#completewith next
.goto 47,87.98,33.16,15,0
.goto 47,88.1,31.33,10,0
.goto 47,90.94,30.56,50,0
+Check for the Unknown Soldier(Rare)(if you haven't recently)
step
#completewith next
+Check for a Chest near/inside the Building
step
>>Kill and LOOT Ghouls(check for the chest near/inside the house again)
.goto 47,76.24,35.47
.complete 26677,1 
step
.goto 47,87.43,35.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Abercrombie
.turnin 26677 >>Turn in Ghoulish Effigy
.accept 26681 >>Accept Note to the Mayor
step
.goto 47,72.57,47.05,5,0
.goto 47,72.35,47.73,5,0
.goto 47,71.92,46.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Ello Ebonlocke
.turnin 26681 >>Turn in Note to the Mayor
.accept 26727 >>Accept The Embalmer's Revenge
step
>>Kill Stitches
.goto 47,72.34,47.75,5,0
.goto 47,72.55,47.14,5,0
.goto 47,74.1,46.51
.complete 26727,1 
step
.goto 47,72.53,47.15,5,0
.goto 47,72.35,47.74,5,0
.goto 47,71.93,46.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Ello Ebonlocke
.turnin 26727,2 >>Turn in The Embalmer's Revenge
step <<DarkIronDwarf
#completewith next
.xp <30,1
.zoneskip 84
+Use your Racial "Mole Machine" Click it and Select (1) Eastern Kingdoms then (2) Stormwind
step <<DarkIronDwarf
.xp <30,1
.goto 84,70.07,47.25,10,0
.goto 84,68.61,51.24,10,0
.goto 84,67.3,57.41,20,0
.goto 84,67.3,57.41,20,0
.goto 84,68.67,62.27,15,0
.goto 84,65.94,64.29,15,0
.goto 84,64.13,66.9,15,0
.goto 84,68.33,75.04,15,0
.goto 84,70.22,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Expert Riding
.turnin 32675 >>Turn in I Believe You Can Fly
.skill riding,225 >> Learn Expert Riding(Normal Flying)
step <<Monk
#completewith next
.xp <30,1
.zoneskip 84
.goto 379,48.96,43.36
+Use Zen Pilgrimage in your Spellbook then go and take the Stormwind Portal(manually skip this step if it didn't complete when you are in Stormwind)
step <<Monk
.xp <30,1
.goto 84,48.86,87.94,10,0
.goto 84,53.92,85.22,20,0
.goto 84,53.76,79.08,10,0
.goto 84,60.16,71.82,10,0
.goto 84,62.4,73.30,15,0
.goto 84,62.7,70.13,15,0
.goto 84,68.28,74.58,10,0
.goto 84,70.22,73.35
>>Go down the Spiral Staircase
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Expert Riding
.turnin 32675 >>Turn in I Believe You Can Fly
.skill riding,225 >> Learn Expert Riding(Normal Flying)
step <<Monk/DarkIronDwarf
#completewith next
.xp <30,1
>>Talk to Tannec and buy an Ebon Gryphon
.goto 84,71.4,71.95
.collect 25471,1
step <<!Monk/!DarkIronDwarf
.xp <30,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 37,77.48,44.28
.fly Stormwind >>Fly to Stormwind
step << !Monk/!DarkIronDwarf
.xp <30,1
.goto 84,70.22,73.35
>>Go down the Spiral Staircase
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Expert Riding
.turnin 32675 >>Turn in I Believe You Can Fly
.skill riding,225 >> Learn Expert Riding(Normal Flying)
step <<!Monk/!DarkIronDwarf
.xp <30,1
>>Talk to Tannec and buy an Ebon Gryphon
.goto 84,71.4,71.95
.collect 25471,1
]])
RXPGuides.RegisterGuide([[
#df
#version 1
#group RestedXP Alliance 10-60
#displayname Chapter 1 - Elwynn Forest
#name 1A_Elwynn Forest
#next 2A_Redridge Mountains
#fresh 30
#veteran
<< Alliance
step << Human
#completewith next
.goto 37,43.10,52.17
.deathskip >> Die and respawn at the Spirit Healer
.isOnQuest 37112
.dmf
step << Human
.goto 84,73.36,90.56
.zone 84 >> Travel to Stormwind
.isOnQuest 37112
.dmf
step
.goto 84,63.77,73.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Renato
.accept 332 >>Accept Wine Shop Advert
.target Renato Gallina
.isQuestAvailable 26389 << Human

step << Human
.goto 84,63.77,73.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Renato
.accept 332 >>Accept Wine Shop Advert
.target Renato Gallina
.isQuestTurnedIn 26389
.dmf

step
#completewith StormwindFP
.goto 84,64.52,70.18,20,0
.goto 84,68.67,73.75,15,0
.goto 84,68.41,75.17,15,0
.goto 84,70.23,73.34,20 >>Travel to the Flight Master
.isQuestAvailable 26389 << Human
step
.goto 84,70.23,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla. Train |T136103:0|tApprentice Riding
.skill riding,75 >> Learn |T136103:0|tApprentice Riding
.target Bralla Cloudwing
.isQuestAvailable 26389 << Human
step
#label StormwindFP
.goto 84,70.92,72.45
.fp Stormwind >>Get the Stormwind Flight Path
.isQuestAvailable 26389 << Human
step << Human
#completewith StormwindFPHuman
.goto 84,64.52,70.18,20,0
.goto 84,68.67,73.75,15,0
.goto 84,68.41,75.17,15,0
.goto 84,70.23,73.34,20 >>Travel to the Flight Master
.dmf
.isQuestTurnedIn 26389
step << Human
.goto 84,70.23,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla. Train |T136103:0|tApprentice Riding
.skill riding,75 >> Learn |T136103:0|tApprentice Riding
.target Bralla Cloudwing
.dmf
.isQuestTurnedIn 26389
step << Human
#label StormwindFPHuman
.goto 84,70.92,72.45
.fp Stormwind >>Get the Stormwind Flight Path
.dmf
.isQuestTurnedIn 26389
step
#veteran
.goto 84,61.64,72.41,20,0
.goto 84,61.12,70.62
>>Buy the following items from the auction house or send them to yourself via mail
+Manually skip this step when you're done
.collect 71951,1,29456,1,1
.collect 71635,1,29443,1,1
.collect 71715,1,29451,1,1
.collect 71716,1,29464,1,1
.collect 71952,1,29457,1,1
.collect 71636,1,29444,1,1
.collect 71637,1,29445,1,1
.collect 71638,1,29446,1,1
.target Auctioneer Fitch
.dmf
.isQuestAvailable 26389 << Human

step << Human
#veteran
.goto 84,61.64,72.41,20,0
.goto 84,61.12,70.62
>>Buy the following items from the auction house or send them to yourself via mail
+Manually skip this step when you're done
.collect 71951,1,29456,1,1
.collect 71635,1,29443,1,1
.collect 71715,1,29451,1,1
.collect 71716,1,29464,1,1
.collect 71952,1,29457,1,1
.collect 71636,1,29444,1,1
.collect 71637,1,29445,1,1
.collect 71638,1,29446,1,1
.target Auctioneer Fitch
.dmf
.isQuestTurnedIn 26389

step
#completewith next
.goto 84,60.16,71.68,15,0
.goto 84,57.84,73.23,15,0
.goto 84,59.29,77.37,10 >> Enter the Gallian Winery
.isQuestAvailable 26389 << Human
step
.goto 84,60.28,76.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Suzetta
.turnin 332 >>Turn in Wine Shop Advert
.target Suzetta Gallina
.isQuestAvailable 26389 << Human
step << Human
#completewith next
.goto 84,60.16,71.68,15,0
.goto 84,57.84,73.23,15,0
.goto 84,59.29,77.37,10 >> Enter the Gallian Winery
.dmf
.isQuestTurnedIn 26389
step << Human
.goto 84,60.28,76.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Suzetta
.turnin 332 >>Turn in Wine Shop Advert
.target Suzetta Gallina
.dmf
.isQuestTurnedIn 26389
step
.goto 84,62.25,72.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Darkmoon Faire Mystic Mage
.accept 7905 >>Accept The Darkmoon Faire
.zone 37 >> Teleport to the Darkmoon Faire
.skipgossip 54334,1
.target Darkmoon Faire Mystic Mage
.dmf
.isQuestAvailable 26389 << Human
step << Human
.goto 84,62.25,72.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Darkmoon Faire Mystic Mage
.accept 7905 >>Accept The Darkmoon Faire
.zone 37 >> Teleport to the Darkmoon Faire
.skipgossip 54334,1
.target Darkmoon Faire Mystic Mage
.dmf
.isQuestTurnedIn 26389
step
.goto 37,41.71,64.64
>>Travel to Goldshire
.fp Goldshire >> Get the Goldshire Flight Path
.target Barlett the Brave
.nodmf
step
.goto 37,42.11,65.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dughan
.turnin 54 >>Turn in Report to Goldshire << Human
.accept 62 >>Accept The Fargodeep Mine
.accept 26378 >>Accept Hero's Call: Westfall!
.target Marshal Dughan
.nodmf
step
.goto 37,42.14,67.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Remy
.accept 40 >>Accept A Fishy Peril
.accept 47 >>Accept Gold Dust Exchange
.target Remy "Two Times"
.dmf

step
#completewith next
.goto 37,41.95,67.16
.train 2259 >> Train |T4620669:0|tAlchemy from Lien
.skipgossip 47384,2,1,1
.target Lien Farmer
.dmf
step
.goto 37,41.95,67.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lien
.train 45357 >> Train |T4620676:0|tInscription
.skipgossip 47384,3,6,2
.target Lien Farmer
.dmf
step
.goto 37,41.89,67.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tharynn. Buy the following items from him:
.collect 2604,1,29520,1 
.collect 6260,1,29520,1 
.collect 2320,1,29520,1 
.collect 30817,5,29509,1 
.collect 39354,5,29515,1 
.target Tharynn Bouden
.dmf
step
.goto 37,42.11,65.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dughan
.turnin 40 >>Turn in A Fishy Peril
.turnin 54 >>Turn in Report to Goldshire << Human
.accept 35 >>Accept Further Concerns
.accept 62 >>Accept The Fargodeep Mine
.accept 26378 >>Accept Hero's Call: Westfall!
.target Marshal Dughan
.dmf
step << Human
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Argus
.goto 37,41.71,65.55
.accept 26393 >>Accept A Swift Message
.target Smith Argus
step
.goto 37,41.71,64.64
.fp Goldshire >> Get the Goldshire Flight Path
.turnin 26393 >> Turn in A Swift Message << Human
.target Barlett the Brave
.dmf
step
#completewith next
.goto 37,42.98,65.66,10,0
.goto 37,43.20,66.02,10 >>Go inside the Inn
step
.goto 37,43.32,65.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to William
.accept 60 >>Accept Kobold Candles
.target William Pestle
step << Human
#completewith FargodeepM
.goto 37,43.77,65.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Farley. Buy |T132789:0|t[Moonberry Juice] from him
.home >>Set your Hearthstone to Lion's Pride Inn
.turnin 37112 >>Turn in Rest and Relaxation
.collect 1645,5,29506,1 
.target Innkeeper Farley
.isOnQuest 37112
.dmf
step << Human
#completewith FargodeepM
.goto 37,43.77,65.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Farley
.home >>Set your Hearthstone to Lion's Pride Inn
.turnin 37112 >>Turn in Rest and Relaxation
.target Innkeeper Farley
.isOnQuest 37112
.nodmf
step
#completewith FargodeepM
.goto 37,43.77,65.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Farley. Buy |T132789:0|t[Moonberry Juice] from him
.home >>Set your Hearthstone to Lion's Pride Inn
.collect 1645,5,29506,1 
.target Innkeeper Farley
.isQuestAvailable 26389 << Human
.dmf

step
#completewith FargodeepM
.goto 37,43.77,65.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Farley
.home >>Set your Hearthstone to Lion's Pride Inn
.target Innkeeper Farley
.isQuestAvailable 26389 << Human
.nodmf
step
.goto 37,44.37,65.99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tomas
.train 2550 >> Train Cooking
.target Tomas
.dmf
step
.goto 37,42.14,67.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Remy
.accept 40 >>Accept A Fishy Peril
.accept 47 >>Accept Gold Dust Exchange
.target Remy "Two Times"
.nodmf

step
#label DarkmoonIslandTP
.goto 37,41.78,69.55
.zone 407 >>Take the Darkmoon Faire Portal to the Darkmoon Island
.dmf
step
>>Click the Strider if you don't have an Heirloom Mount << Human
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kae Ti. Buy a |T133734:0|t[Ride Ticket Book] from her
.goto 407,50.44,59.33
.collect 92788 
.target Kae Ti
.dmf



step << skip
#completewith X
.use 92788 
.itemcount 92788,1

step
#veteran
>>Open the Ride Ticket Book
>>Stand on the Carousel and wait for the Experience Buff to reach 60minutes
>>Click the Quest Items in your bag(skip the ones you don't have)
.goto 407,49.45,57.5
.accept 29464 >>Accept Tools of Divination
.accept 29451 >>Accept The Master Strategist
.accept 29456 >>Accept A Captured Banner
.accept 29457 >>Accept The Enemy's Insignia
.accept 29458 >>Accept The Captured Journal
.accept 29443 >>Accept A Curious Crystal
.accept 29444 >>Accept An Exotic Egg
.accept 29445 >>Accept An Intriguing Grimoire
.accept 29446 >>Accept A Wondrous Weapon
.dmf


step
#fresh
.goto 407,49.45,57.5
>>Open the Ride Ticket Book
+Stand on the Carousel and wait for the Experience Buff to reach 60minutes. Click this step when finished
.dmf


step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Professor Paleo
.turnin 29464 >>Turn in Tools of Divination
.target Professor Thaddeus Paleo
.itemcount 71716,1
.dmf
step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Professor Paleo
.turnin 29451 >>Turn in The Master Strategist
.target Professor Thaddeus Paleo
.itemcount 71715,1
.dmf
step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Professor Paleo
.turnin 29456 >>Turn in A Captured Banner
.target Professor Thaddeus Paleo
.itemcount 71951,1
.dmf
step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Professor Paleo
.turnin 29457 >>Turn in The Enemy's Insignia
.target Professor Thaddeus Paleo
.itemcount 71952,1
.dmf
step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Professor Paleo
.turnin 29458 >>Turn in The Captured Journal
.target Professor Thaddeus Paleo
.itemcount 71953,1
.dmf
step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Professor Paleo
.turnin 29443 >>Turn in A Curious Crystal
.target Professor Thaddeus Paleo
.itemcount 71635,1
.dmf
step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Professor Paleo
.turnin 29446 >>Turn in A Wondrous Weapon
.target Professor Thaddeus Paleo
.itemcount 71638,1
.dmf

step
.goto 407,47.76,64.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gelvas. Buy as many |T669449:0|t[Darkmoon Top Hats] from him as you can
.turnin 7905 >>Turn in The Darkmoon Faire
.collect 171364,1,29506,1 
.target Gelvas Grimegate
.dmf

step
.goto 407,52.89,67.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Stamp
.accept 29509 >>Accept Putting the Crunch in the Frog
.target Stamp Thunderhorn
.dmf
step
.goto 407,52.88,67.96
>>Use the |T133642:0|t[Plump Frogs] to turn them into Breaded Frogs
.collect 72056,5,29509,1,-1 
.collect 30817,5,29509,1,-1 
.collect 72057,5,29509,1 
.use 72056 
.dmf
.isOnQuest 29509
step
.goto 407,52.88,67.96
>>Use the |T237579:0|t[Breaded Frogs] to throw them into the cooking pot and turn them into Crunchy Frogs
.collect 72057,5,29509,1,-1 
.complete 29509,1 
.use 72057 
.dmf
.isOnQuest 29509
step
.goto 407,52.88,67.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Stamp
.turnin 29509 >>Turn in Putting the Crunch in the Frog
.target Stamp Thunderhorn
.dmf
step
.goto 407,50.54,69.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sylannia. Buy |T132792:0|t[Fizzy Faire Drinks] from her
.accept 29506 >>Accept A Fizzy Fusion
.collect 19299,5,29506,1 
.target Sylannia
.dmf
step
.goto 407,50.54,69.56
>>Use the |T132793:0|t[Cocktail Shaker] to make Moonberry Fizz
.collect 1645,5,29506,1,-1 
.collect 19299,5,29506,1,-1 
.complete 29506,1 
.use 72043 
.dmf
step
.goto 407,50.53,69.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sylannia
.turnin 29506 >>Turn in A Fizzy Fusion
.target Sylannia
.dmf
step
.goto 407,53.23,75.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sayge
.turnin 29445 >>Turn in An Intriguing Grimoire
.accept 29515 >>Accept Writing the Future
.target Sayge
.dmf
.isOnQuest 29445
step
.goto 407,53.23,75.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sayge
.accept 29515 >>Accept Writing the Future
.target Sayge
.dmf
step
.goto 407,53.23,75.82
>>Use the |T413571:0|t[Bundle of Exotic Herbs] to make Prophetic Ink
.collect 71972,1,29515,1
.use 71971
.dmf
.isOnQuest 29515
step
.goto 407,53.23,75.82
>>Use the |T237061:0|t[Prophetic Ink] to make Fortunes
.collect 39354,5,29515,1,-1 
.complete 29515,1 
.use 71972
.dmf
.isOnQuest 29515
step
.goto 407,53.23,75.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sayge
.turnin 29515 >>Turn in Writing the Future
.target Sayge
.skipgossip
.dmf
step
.goto 407,51.11,82.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Yebb
.turnin 29444 >>Turn in An Exotic Egg
.target Yebb Neblegear
.dmf
.isOnQuest 29444
step
#completewith next
.link /run AbandonSkill(773); AbandonSkill(171); >>|cfff78300Unlearn your professions by copying and pasting the link into chat|r
.skill 773,<0 >>Unlearn Inscription
.skill 171,<0 >>Unlearn Alchemy
.dmf
step
.goto 407,50.56,90.80
.zone 37 >>Take the Darkmoon Faire Portal to Elwynn Forest
.dmf
step
.goto 37,41.96,67.15
.link /run AbandonSkill(773); AbandonSkill(171); >>|cfff78300Unlearn your professions by copying and pasting the link into chat|r
.skill 773,<0 >>Unlearn Inscription
.skill 171,<0 >>Unlearn Alchemy
.dmf
step
#completewith next
.goto 37,41.95,67.16
.train 2366 >> Train |T4620675:0|tHerbalism from Lien
.skipgossip 47384,1,1,1
.target Lien Farmer

step
.goto 37,41.95,67.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lien
.train 2575 >> Train |T4620679:0|tMining
.skipgossip 47384,2,3,2
.target Lien Farmer

step
#completewith FargodeepM
+Herbing and Mining Ores gives Experience. Only do this when the herbs/ores are right next to you
step
#veteran
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Julia. Skip this step if you don't have level 25 Pet Battle Pets
.goto 37,41.65,83.67
.accept 31693 >>Accept Julia Stevens
.target Julia Stevens
.isQuestTurnedIn 31903 
step
#veteran
>>Defeat Julia in a Pet Battle
.complete 31693,1 
.target Julia Stevens
.isOnQuest 31693
step
#veteran
.goto 37,41.66,83.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Julia
.turnin 31693 >>Turn in Julia Stevens
.target Julia Stevens
.isQuestComplete 31693
step << Hunter
#completewith next
>>Drag |T132161:0|tCall Pet and |T132179:0|tPet Utility onto your Action Bars
.goto 37,40.75,70.49,40,0
.goto 37,40.77,78.56,40,0
.goto 37,38.21,73.32,40 >>Cast |T132164:0|tTame Beast on a Stonetusk Boar to tame it
.target Stonetusk Boar
step
#completewith FargodeepM
>>Kill Kobolds. Loot them for their Candles and Gold Dust
.complete 60,1 
.complete 47,1 
.target Kobold Tunneler
.target Kobold Miner

step
.goto 37,38.06,83.31,40 >>Check for Narg the Taskmaster (Rare) outside the mine. Kill him if he's up
>>Rares and Treasures reward a lot of experience! Be sure to keep an eye out for them
.unitscan Narg the Taskmaster
.isOnQuest 60
step
#completewith next
.goto 38,38.93,82.18,15,0
.goto 38,44.60,63.38,15 >>Go into the upper entrance of the Fargodeep Mine
step
#label FargodeepM
>>Run inside the mine
.goto 38,54.35,59.63
.complete 62,1 
step
.goto 37,37.82,86.14,40,0
.goto 37,37.89,81.45,40,0
.goto 39,47.59,68.00,20,0
.goto 39,60.14,82.29,20,0
.goto 39,78.65,28.65,20,0
.goto 39,57.67,25.29,20,0
.goto 38,53.73,72.25,20,0
.goto 37,37.82,86.14,40,0
.goto 37,37.89,81.45,40,0
.goto 39,47.59,68.00,20,0
.goto 39,60.14,82.29,20,0
.goto 39,78.65,28.65,20,0
.goto 39,57.67,25.29,20,0
.goto 38,53.73,72.25
>>Kill Kobolds. Loot them for their Candles and Gold Dust
.complete 60,1 
.complete 47,1 
.target Kobold Tunneler
.target Kobold Miner
step
.goto 37,34.66,84.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ma
.accept 88 >>Accept Princess Must Die!
.target Ma Stonefield
step
.goto 37,32.48,86.81,20,0
.goto 37,33.41,86.16,20,0
.goto 37,33.32,84.95,20,0
.goto 37,32.58,84.26,20,0
.goto 37,32.04,85.20,20,0
.goto 37,32.48,86.81,20,0
.goto 37,33.41,86.16,20,0
.goto 37,33.32,84.95,20,0
.goto 37,32.58,84.26,20,0
.goto 37,32.04,85.20
.line 37,32.48,86.81,33.41,86.16,33.32,84.95,32.58,84.26,32.04,85.20,32.48,86.81
>>Kill Princess. Loot her for her Collar
.complete 88,1 
.target Princess
step
.goto 37,34.66,84.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ma
.turnin 88 >>Turn in Princess Must Die!
.target Ma Stonefield
step
.goto 37,33.64,87.76,15 >>Check for the Chest inside and around the Stables
.isOnQuest 60
step
.goto 37,30.73,64.85,40 >>Check for Morgaine the Sly (Rare) inside the house. Kill her if she's up
.unitscan Morgaine the Sly
.isOnQuest 60
step
.goto 37,27.22,67.51,40 >>Check for the Grizzled Ben (Rare)
.unitscan Grizzled Ben
.isOnQuest 60
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Wanted Poster and Rainer
.accept 176 >>Accept WANTED: "Hogger"
.goto 37,24.55,74.67
.accept 11 >>Accept Riverpaw Gnoll Bounty
.goto 37,24.23,74.45
.target Deputy Rainer
step
#completewith Armbands
+Look for Gruff Swiftbite (Rare) and Chests in ALL the camps
.unitscan Gruff Swiftbite
step
#completewith next
>>Kill Gnolls. Loot them for their Armbands
.complete 11,1 
.target Riverpaw Runt
.target Riverpaw Outrunner
step
.goto 37,24.97,95.23
>>Kill Hogger. DON'T wait out the RP
.complete 176,1 
step
.goto 37,24.78,95.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Westfall Deed on the ground
.accept 184 >>Accept Furlbrow's Deed
step
#label Armbands
.goto 37,24.36,93.65,30,0
.goto 37,26.10,91.95,30,0
.goto 37,25.30,88.95,30,0
.goto 37,27.80,88.36,30,0
.goto 37,27.67,86.21,30,0
.goto 37,26.32,86.82,30,0
.goto 37,24.36,93.65,30,0
.goto 37,26.10,91.95,30,0
.goto 37,25.30,88.95,30,0
.goto 37,27.80,88.36,30,0
.goto 37,27.67,86.21,30,0
.goto 37,26.32,86.82
>>Kill Gnolls. Loot them for their Armbands
.complete 11,1 
step
#completewith next
.goto 37,24.36,93.65,30,0
.goto 37,26.10,91.95,30,0
.goto 37,25.30,88.95,30,0
.goto 37,27.80,88.36,30,0
.goto 37,27.67,86.21,30,0
.goto 37,26.32,86.82,40 >> Look for Gruff Swiftbite (Rare) and Chests in ALL the camps. Kill him if he's up
.unitscan Gruff Swiftbite
step
.goto 37,24.23,74.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rainer
.turnin 11 >>Turn in Riverpaw Gnoll Bounty
.target Deputy Rainer
step
#veteran
.goto 52,60.85,18.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Old MacDonald. Skip this step if you don't have level 25 Pet Battle Pets
.accept 31780 >>Accept Old MacDonald
.target Old MacDonald
.isQuestTurnedIn 31903

step
#veteran
.goto 52,61.04,18.82
>>Defeat Old MacDonald in a Pet Battle
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Old MacDonald
.complete 31780,1 
.target Old MacDonald
.skipgossip 65648,1
.isOnQuest 31780
step
#veteran
.goto 52,61.04,18.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Old MacDonald
.turnin 31780 >>Turn in Old MacDonald
.target Old MacDonald
.isQuestComplete 31780
step
.goto 52,60.05,19.28,5,0
.goto 52,60.18,19.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Horatio
.turnin 184 >>Turn in Furlbrow's Deed
.turnin 26378 >>Turn in Hero's Call: Westfall!
.accept 26209 >>Accept Murder Was The Case That They Gave Me
.target Lieutenant Horatio Laine
step
.loop 25,52,58.56,16.21,59.18,18.16,58.12,19.58,57.31,18.33,58.56,16.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Homeless Citizens and Drifters for Clues. Stay mounted and spam talk to them, ignore them if they turn Hostile
.complete 26209,1 
.complete 26209,2 
.complete 26209,3 
.complete 26209,4 
.target Homeless Stormwind Citizen
.target West Plains Drifter
.skipgossip 1
step
.goto 52,60.05,19.28,5,0
.goto 52,60.18,19.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Horatio
.turnin 26209 >>Turn in Murder Was The Case That They Gave Me
.accept 26213 >>Accept Hot On the Trail: The Riverpaw Clan
.target Lieutenant Horatio Laine
step
#completewith Horatio
.goto 52,56.46,13.26,30 >>Check for a Chest in the camp
step
.goto 52,58.16,10.71,40,0
.goto 52,57.17,15.12,40,0
.goto 52,51.38,15.89,40,0
.goto 52,50.68,14.77,40,0
.goto 52,56.46,13.26,40,0
.goto 52,58.16,10.71,40,0
.goto 52,57.17,15.12,40,0
.goto 52,51.38,15.89,40,0
.goto 52,50.68,14.77,40,0
.goto 52,56.46,13.26
>>Kill Gnolls. Loot them for the Clue
.complete 26213,1 
step
#label Horatio
.goto 52,60.05,19.28,5,0
.goto 52,60.18,19.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Horatio
.turnin 26213 >>Turn in Hot On the Trail: The Riverpaw Clan
step
#completewith next
.hs >>Hearth to Lion's Pride Inn
step
.goto 37,43.32,65.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to William
.turnin 60 >>Turn in Kobold Candles
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Remy and Dughan
.turnin 47 >>Turn in Gold Dust Exchange
.goto 37,42.14,67.25
.turnin 62 >>Turn in The Fargodeep Mine
.turnin 40 >>Turn in A Fishy Peril
.accept 35 >>Accept Further Concerns
.accept 76 >>Accept The Jasperlode Mine
.turnin 176 >>Turn in WANTED: "Hogger"
.goto 37,42.11,65.93
.target Remy "Two Times"
.target Marshal Dughan
.isOnQuest 40
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Remy and Dughan
.turnin 47 >>Turn in Gold Dust Exchange
.goto 37,42.14,67.25
.turnin 62 >>Turn in The Fargodeep Mine
.accept 35 >>Accept Further Concerns
.accept 76 >>Accept The Jasperlode Mine
.turnin 176 >>Turn in WANTED: "Hogger"
.goto 37,42.11,65.93
.target Remy "Two Times"
.target Marshal Dughan
step
#completewith Lamepaw
.goto 37,41.69,65.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Andrew
.vendor >>Vendor and Repair
.target Andrew Krighton
step << Human
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Argus and Barlett
.accept 26393 >>Accept A Swift Message
.goto 37,41.71,65.54
.turnin 26393 >>Turn in A Swift Message
.accept 26394 >>Accept Continue to Stormwind
.goto 37,41.71,64.64
.target Smith Argus
.target Bartlett the Brave
step
#label Lamepaw
.goto 37,52.25,62.90,40 >>Check for Lamepaw the Whimperer (rare). Kill him if he's up
.unitscan Lamepaw the Whimperer
.isOnQuest 76
step
.goto 37,57.49,64.61,45 >> Scan the murloc islands with your mouse for a Chest. Your mouse will become a gear icon if there's a chest. If you find one, kill the murlocs protecting it. Loot it
.isOnQuest 76
step
.goto 37,66.51,63.83,40 >> Check for Tarantis (Rare). Kill her if she's up
.unitscan Tarantis
.isOnQuest 76
step
.goto 37,64.7,56.73,30 >>Check for the Chest in the Kobold Camp
.isOnQuest 76
step
#completewith next
.goto 37,61.70,53.83,20 >> Enter the Jasperlode Mine
step
.goto 40,45.11,67.29,20,0
.goto 40,38.43,61.58,20,0
.goto 40,37.01,50.26
>>Keep following the middle path inside the mine
.complete 76,1 
step
.goto 40,31.02,37.51,20,0
.goto 40,37.01,50.26,20,0
.goto 40,47.25,36.66,20,0
.goto 40,53.93,30.58,20,0
.goto 40,45.14,21.76,20 >>Check for Mother Fang (Rare) at the back of the cave. Kill her if she's up
.unitscan Mother Fang
.isOnQuest 76
step
#completewith next
.deathskip >> Die and respawn at the Spirit Healer
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thomas and the Bounty Board
.turnin 35 >>Turn in Further Concerns
.accept 37 >>Accept Find the Lost Guards
.accept 52 >>Accept Protect the Frontier
.goto 37,73.97,72.18
.accept 46 >>Accept Bounty on Murlocs
.accept 26152 >>Accept WANTED: James Clark
.goto 37,74.03,72.31
.target Guard Thomas
step
#completewith next
>>Kill Prowlers and Bears. Focus on the Bears
.complete 52,1 
.complete 52,2 
.target Prowler
.target Young Forest Bear
step
.goto 37,73.5,84.41,40 >>Check for Bushtail and Terrapis (Rares). Kill them if they're up
.isOnQuest 52
.unitscan Bushtail
step
#completewith next
>>Kill Murloc Foragers and Lurkers. Loot them for their Fins
.complete 46,1,4 
.target Murloc Lurker
.target Murloc Forager
step
#completewith next
.goto 37,75.71,86.29,30,0
.goto 37,77.55,85.75
.deathskip >> Die and respawn at the Spirit Healer whilst Killing and Looting Murlocs for their Fins before dying
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rallic
.goto 37,83.28,66.09
.vendor 1198 >>Vendor and Repair
.target Rallic Finn
.isOnQuest 52
step << Human
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Randal. Train |T136103:0|tApprentice Riding
.skill riding,75 >> Learn |T136103:0|tApprentice Riding
.turnin 32618 >> Turn in Learn To Ride
.goto 37,84.32,64.87
.target Randal Hunter
.xp <10,1

step << Human
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Katie
.goto 37,84.14,65.48
.vendor >>Buy a |T132261:0|tHorse from her
.target Katie Hunter
.skill riding,75
.xp <10,1
step
.goto 37,79.46,68.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sara
.accept 83 >>Accept Fine Linen Goods
.target Sara Timberlain
step
.goto 37,78.87,67.20,10,0
.goto 37,78.61,67.08
>>Kill James. Loot him for his Head and Schedule
.complete 26152,1 
.collect 1307,1,123,1 
.accept 123 >>Accept The Collector
.target James Clark
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Raelen and Patterson
.accept 5545 >>Accept A Bundle of Trouble
.goto 37,81.38,66.11
.turnin 123 >>Turn in The Collector
.accept 147 >>Accept Manhunt
.turnin 26152 >>Turn in WANTED: James Clark
.goto 37,81.86,66.04
.target Supervisor Raelen
.target Marshal Patterson
step
#completewith Bundles
>>Kill Prowlers, Gray Forest Wolves, and Bears. Focus on the Bears
.complete 52,1 
.complete 52,2 
.target Prowler
.target Gray Forest Wolf
.target Young Forest Bear
step
#completewith next
>>Click the Bundles of Wood around the trees
.complete 5545,1 
step
#label LostGuards
>>Talk to the carcass on the ground
.goto 37,72.65,60.33
.turnin 37 >>Turn in Find the Lost Guards
.accept 45 >>Accept Discover Rolf's Fate
step
#label Bundles
.goto 37,75.92,62.36,40,0
.goto 37,77.17,63.04,40,0
.goto 37,78.93,61.10,40,0
.goto 37,81.27,61.58,40,0
.goto 37,85.13,61.12,40,0
.goto 37,83.48,59.18,40,0
.goto 37,79.77,56.70,40,0
.goto 37,80.04,50.42,40,0
.goto 37,75.92,62.36,40,0
.goto 37,77.17,63.04,40,0
.goto 37,78.93,61.10,40,0
.goto 37,81.27,61.58,40,0
.goto 37,85.13,61.12,40,0
.goto 37,83.48,59.18,40,0
.goto 37,79.77,56.70,40,0
.goto 37,80.04,50.42
>>Click the Bundles of Wood around the trees
.complete 5545,1 
step
.goto 37,81.38,58.74,40,0
.goto 37,86.59,63.45,40,0
.goto 37,86.84,64.92,40,0
.goto 37,88.01,65.01,40,0
.goto 37,87.16,70.20,40,0
.goto 37,81.38,58.74,40,0
.goto 37,86.59,63.45,40,0
.goto 37,86.84,64.92,40,0
.goto 37,88.01,65.01,40,0
.goto 37,87.16,70.20
>>Kill Prowlers, Gray Forest Wolves, and Bears. Focus on the Bears
.complete 52,1 
.complete 52,2 
.target Prowler
.target Gray Forest Wolf
.target Young Forest Bear
step
.goto 37,79.80,55.51
>>Talk to the carcass on the ground
.turnin 45 >>Turn in Discover Rolf's Fate
.accept 71 >>Accept Report to Thomas
step
.goto 37,79.26,54.05,30,0
.goto 37,78.74,55.90,30,0
.goto 37,79.31,57.13,30,0
.goto 37,77.65,57.70,30,0
.goto 37,79.26,54.05,30,0
.goto 37,78.74,55.90,30,0
.goto 37,79.31,57.13,30,0
.goto 37,77.65,57.70
>>Kill Murloc Foragers and Lurkers. Loot them for their Fins
.complete 46,1 
.target Murloc Lurker
.target Murloc Forager
step
#completewith next
.goto 37,77.65,57.70
.deathskip >>Die and respawn at the Spirit Healer. Skip this if you're not low on health
step
.goto 37,73.97,72.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thomas
.turnin 46,1 >>Turn in Bounty on Murlocs
.turnin 52 >>Turn in Protect the Frontier
.accept 59 >>Accept Cloth and Leather Armor
.turnin 71 >>Turn in Report to Thomas
step
#completewith Morgan
>>Kill Bandits. Loot them for their Scrap
.complete 83,1 
.target Bandit
step
.goto 37,69.32,79.31,30 >>Snoot the Rooter (Rare). Kill him if he's up
.isOnQuest 83
step
#label Morgan
.goto 37,71.01,80.69
>>Kill Morgan in the house. Check for a Chest in and around the house
.complete 147,1 
.target Morgan the Collector
step
.goto 37,70.96,77.21,10,0
.goto 37,71.25,76.82,10,0
.goto 37,68.12,77.59,30,0
.goto 37,67.96,81.35,30,0
.goto 37,68.42,82.69,30,0
.goto 37,71.02,80.68,30,0
.goto 37,70.80,77.93,30,0
.goto 37,68.12,77.59,30,0
.goto 37,67.96,81.35,30,0
.goto 37,68.42,82.69,30,0
.goto 37,71.02,80.68,30,0
.goto 37,70.80,77.93
>>Kill Bandits. Loot them for their Scrap. Check for a Chest in and around the Barn
.complete 83,1 
.target Bandit
step
.goto 37,69.41,85.05,40,0
.goto 37,73.73,85.98,30 >>Check for Terrapis (Rare). Kill him if he's up. Skip this if you killed him earlier
.target Terrapis
.isOnQuest 83
step
#completewith next
.goto 37,75.71,86.29,30,0
.goto 37,77.55,85.75
.deathskip >> Die and respawn at the Spirit Healer
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rallic
.goto 37,83.28,66.09
.vendor 1198 >>Vendor and Repair
.target Rallic Finn
.isOnQuest 59
step << Human
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Randal. Train |T136103:0|tApprentice Riding
.skill riding,75 >> Learn |T136103:0|tApprentice Riding
.turnin 32618 >> Turn in Learn To Ride
.goto 37,84.32,64.87
.target Randal Hunter
.xp <10,1
step << Human
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Katie
.goto 37,84.14,65.48
.vendor >>Buy a |T132261:0|tHorse from her
.target Katie Hunter
.skill riding,75
.xp <10,1
step << !DarkIronDwarf !KulTiran !LightforgedDraenei !Mechagnome !VoidElf
#sticky
#label EastvaleFP
.goto 37,81.81,66.49,0,0
.fp Eastvale Logging Camp >> Get the Eastvale Logging Camp flight path
.target Goss the Swift
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Patterson and Raelen
.turnin 147 >>Turn in Manhunt
.goto 37,81.86,66.04
.turnin 5545 >>Turn in A Bundle of Trouble
.goto 37,81.38,66.11
.target Marshal Patterson
.target Supervisor Raelen
step
#requires EastvaleFP
.goto 37,79.46,68.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sara
.turnin 59 >>Turn in Cloth and Leather Armor
.turnin 83 >>Turn in Fine Linen Goods
.target Sara Timberlain
]])
RXPGuides.RegisterGuide([[
#df
#version 1
#group RestedXP Alliance 10-60
#name 4A_Northern Stranglethorn
#displayname Chapter 4 - Northern Stranglethorn
#next 5A_Duskwood 2
#fresh 30
#veteran
<<Alliance
step
#sticky
#completewith Northern Stranglethorn Introduction
+Welcome to the Northern Stranglethorn Guide of RestedXP.
step
#label Northern Stranglethorn Introduction
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to James
.goto 50,49.37,13.13,10,0
.goto 50,47.87,11.86
.fp >>Get the Rebel Camp Flight Path
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lieutenant Doren
.goto 50,47.57,10.25
.accept 26735 >>Accept The Fate of Kurzen
step
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Corporal Bluth
.vendor 734 >> Vendor if you need to
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Corporal Kaleb
.goto 50,47.10,10.70
.accept 26740 >>Accept Krazek's Cookery
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brother Nimetz
.goto 50,47.24,11.09
.accept 26732 >>Accept Bad Medicine
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Barnil
.goto 50,49.06,14.2,20,0
.goto 50,48.34,16.2,20,0
.goto 50,46.49,18.75,20,0
.goto 50,44.26,22.26
.accept 583 >>Accept Welcome to the Jungle
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hemet Nesingwary
.goto 50,44.18,22.95
.turnin 583 >>Turn in Welcome to the Jungle
.accept 194 >>Accept Raptor Hunting
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Drizzlik
.goto 50,43.65,23.41
.accept 26343 >>Accept Supply and Demand
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Krazek
.goto 50,43.60,23.12
.turnin 26740 >>Turn in Krazek's Cookery
.accept 26763 >>Accept Venture Company Mining
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Sir S. J. Erigadin(patrolling a little)
.goto 50,43.72,22.27
.accept 190 >>Accept Panther Hunting
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Barnil
.goto 50,44.26,22.26
.accept 26269 >>Accept The Green Hills of Stranglethorn
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ajeck
.goto 50,44.49,22.68
.accept 185 >>Accept Tiger Hunting
step
#completewith next
>>Kill and LOOT the River Crocodiles in the Area
.complete 26343,1 
step
>>Kill Young Tigers in the Area
.goto 50,45.69,21.13,20,0
.goto 50,41.77,20.71,20,0
.goto 50,38.91,20.86,20,0
.goto 50,40.32,22.97,20,0
.goto 50,41.31,24.4
.complete 185,1 
step
>>Kill and LOOT the River Crocodiles in the Area
.goto 50,40.82,20.36
.complete 26343,1 
step
>>Click the Quest Pop to turn in the Tiger Quest
.goto 50,43.65,23.46
.turnin 185 >>Turn in Tiger Hunting
.accept 186 >>Accept Tiger Stalking
step
#requires Area1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Drizzlik
.goto 50,43.65,23.46
.turnin 26343 >>Turn in Supply and Demand
.accept 26344 >>Accept Some Assembly Required
step
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jaquilina Dramet
.goto 50,43.69,23.19
.vendor 2483 >>It's Mandatory to repair here and sell as much as you can
step
>>Check near Tree's/Bushes for Young Panthers. They will come out of stealth and attack you. You only need to kill 5. Check for Tsul'Kalu (rare) while you quest.
.goto 50,46.52,27.94,5,0
.goto 50,46.93,27.81,5,0
.goto 50,47.19,31.84,20,0
.goto 50,48.71,29.33,5,0
.goto 50,49.24,27.9,5,0
.goto 50,48.66,26.77,5,0
.goto 50,48.62,26.9,10,0
.complete 190,1,5 
.unitscan Tsul'Kalu
step
>>Kill and LOOT Snapjaw Crocolisk, even if they're in the water
.goto 50,50.38,29.61,25,0
.goto 50,50.15,32.54,25,0
.goto 50,51.27,35.89
.complete 26344,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Steven Lisbane
.isQuestTurnedIn 31903,31889,31891,31902
.goto 50,46.00,40.46
.accept 31852 >>Accept Steven Lisbane
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Steven Lisbane
>>Take any Fast 25's Pets
.isOnQuest 31852
.goto 50,46.17,40.18
.complete 31852,1 
step
.isQuestTurnedIn 31852
.goto 50,46.01,40.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Steven Lisbane
.turnin 31852 >>Turn in Steven Lisbane
step
#completewith next
+Check for Mahamba (Rare) as you quest
.unitscan Mahamba
step
#label VentureCo
>>Kill and LOOT Venture Co Enemies. Chests can spawn in the lumberyard and on the oil rig.
.goto 50,51.21,35.8,15,0
.goto 50,52.98,29.97,15,0
.goto 50,54.08,33.65,15,0
.goto 50,54.48,34.08,15,0
.goto 50,54.43,35.29,10,0
.goto 50,55.35,35.7,15,0
.goto 50,59.59,36.22
.complete 26763,1 
step
>>Kill Strangtlethorn Tigers in the Area
.goto 50,57.27,29.9,50,0
.goto 50,61.18,29.53
.complete 186,1 
step
>>Click the Quest Pop up to turn in the Quest
.turnin 186 >>Turn in Tiger Stalking
.accept 187 >>Accept Tiger Prowess
step
#completewith House
>>Kill and LOOT Kurzen Enemies in the Area
.complete 26732,1 
.accept 26738 >>Accept Just Hatched
step
>>Click the Scroll on the Ground
.goto 50,57.92,23.65
.complete 26735,2 
step
#label House
>>Click the Scroll on the Ground
.goto 50,57.88,22.86
.complete 26735,1 
step
>> Finish killing and looting Kurzen enemies. Check for a chest in the house, it can spawn downstairs or upstairs.
.goto 50,56.79,20.28,5,0
.goto 50,56.84,20.81,5,0
.goto 50,56.3,20.29
.complete 26732,1 
.accept 26738 >>Accept Just Hatched
step
>>Check near Tree's/Bushes for Young Panthers
.goto 50,55.65,21.57,8,0
.goto 50,54.58,23.24,8,0
.goto 50,55.1,24.59,8,0
.goto 50,54.69,26.78,8,0
.goto 50,53.3,25.5,8,0
.goto 50,52.56,23,0,8,0
.goto 50,52.18,22
.complete 190,1 
step
>>Click the Quest Pop up to turn in the Quest
.goto 50,47.58,10.25
.turnin 190 >>Turn in Panther Hunting
.accept 191 >>Accept Panther Stalking
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lieutenant Doren
.goto 50,49.48,14.74,20,0
.goto 50,47.58,10.25
.turnin 26735 >>Turn in The Fate of Kurzen
.accept 26736 >>Accept Spared from Madness
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Corporal Sethman
.goto 50,46.99,10.83
.turnin 26738 >>Turn in Just Hatched
.accept 26739 >>Accept I Think She's Hungry
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brother Nimetz
.goto 50,47.24,11.09
.turnin 26732 >>Turn in Bad Medicine
.accept 26733 >>Accept Control Sample
step
>>Check in the House for a Chest
.goto 50,56.3,20.29,20
step
>>Click The Cage inside the House
.goto 50,56.50,20.28
.complete 26736,1 
.complete 26736,2 
.complete 26736,3 
step
>>Use the "Lashtail Raptor Egg Fragment" in your Bags then kill and loot Basilisks. Get low health as you get close to completeing this step, we're deathskipping after.
.use 58165
.goto 50,56.72,20.78,30,0
.goto 50,56.98,20.27,20,0
.goto 50,60.31,21.56,30,0
.goto 50,63.26,19.03,30,0
.goto 50,56.72,20.78
.complete 26739,1 
.complete 26733,1 
step
#completewith next
.deathskip >> Die, Release and Respawn at the Graveyard
step
.goto 50,49.49,15.00,20,0
.goto 50,47.25,11.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brother Nimetz
.turnin 26733 >>Turn in Control Sample
.accept 26734 >>Accept The Source of the Madness
step
.goto 50,46.99,10.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Corporal Sethman
.turnin 26739 >>Turn in I Think She's Hungry
.accept 26744 >>Accept Deep Roots
step
.goto 50,47.57,10.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lieutenant Doren
.turnin 26736 >>Turn in Spared from Madness
.accept 26737 >>Accept Stopping Kurzen's Legacy
step
.goto 50,47.97,12.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Berrin Burnquill(if the npc isn't there relog or phase in and out the zone)
.accept 26742 >>Accept Bloodscalp Insight
step
#sticky
#label Area999
>>Kill and LOOT Kunzen Troops
.complete 26734,1 
step
>>Kill Chief Anders (be careful of the stealth enemies)
.goto 50,62.27,17.57,15,0
.goto 50,63.71,16.79
.complete 26737,1 
step
>>Kill Chief Gaulus, he's downstairs
.goto 50,62.89,17.4,10,0
.goto 50,63.2,17.73,8,0
.goto 50,62.42,14.21
.complete 26737,2 
step
>>Kill Chief Miranda. Look for a treasure chest near her.
.goto 50,65.76,17.24
.complete 26737,3 
step
>> Kill Chief Esquivel at the end of the cave. Look for a chest near him.
.goto 50,65.90,11.84
.complete 26737,4 
step
#requires Area999
#completewith next
.deathskip >> Die, Release and Respawn at the Graveyard
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Barnil Stonepot
>>Most likely your Equipment will be broken (red), we'll fix it soon
.goto 50,44.24,22.13
.turnin 26269 >>Turn in The Green Hills of Stranglethorn
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Krazek
.goto 50,43.60,23.14
.turnin 26763,1 >>Turn in Venture Company Mining
.accept 26765 >>Accept Return to Corporal Kaleb
step
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jaquilina Dramet
.vendor 2483 >> It's Mandatory to repair here and sell as much as you can
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Drizzlik
.goto 50,43.62,23.43
.turnin 26344 >>Turn in Some Assembly Required
step
>> Check for Pogeyan (Rare)
.goto 50,36.24,28.89,20
.unitscan Pogeyan
step
#label Elders
>>Don't kill Sin'dall If you see him. Kill Elder Tigers in the area
.goto 50,36.33,32.55
.complete 187,1 
step
>>Click the Quest Pop-up in your Quest log to turn in the Quest
.goto 50,37.48,30.04
.turnin 187 >>Turn in Tiger Prowess
.accept 188 >>Accept Tiger Mastery
step
#label Elders2
>>Kill and LOOT Sin'Dall. She can spawn ontop of the hill or patrolling around it.
.goto 50,37.48,30.04,30,0
.goto 50,38.48,32.59
.complete 188,1 
step
#label Elders3
>>Kill Panthers
.goto 50,33.61,27.11,50,0
.goto 50,32.97,22.34
.complete 191,1 
step
>>Click the Quest Pop-up in your Quest log to turn in the Quest
.goto 50,31.13,30.25
.turnin 191 >>Turn in Panther Stalking
step
>>Kill Stranglethorn Raptors in the Area
.goto 50,31.13,30.25
.complete 194,1 
step
.goto 50,30.86,29.66
>>Click the Quest Pop-up in your Quest log to turn in the Quest
.turnin 194 >>Turn in Raptor Hunting
.accept 195 >>Accept Raptor Stalking
step
>>Click the Tablet. Check for a chest in the area.
.complete 26744,1 
step
#label Area1001
.goto 50,33.67,36.86
>>Kill and LOOT Troll Shamans in the Area
.complete 26742,1 
step
#requires Area1001
.goto 50,33.67,36.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lashtail Hatchling(next to you)
.accept 26745 >>Accept Favored Skull
step
#completewith next
.goto 50,46.57,39.35,25
>>Check for Gluggl (Murloc Rare)
step
>>Kill Lashtail Raptors in the Area. Get low health towards the end, we're deathskipping after.
.goto 50,48.57,35.63
.complete 195,1 
step
>>Click the Quest Pop-up in your Quest log to turn in the Quest
.goto 50,44.50,22.66
.turnin 195 >>Turn in Raptor Stalking
step
#label Elders4
#completewith next
.deathskip >> Die, Release and Respawn at the Graveyard
step
.goto 50,44.50,22.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ajeck Rouack
.turnin 188,1 >>Turn in Tiger Mastery
step
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jaquilina Dramet
.goto 50,43.69,23.19
.vendor 2483 >> It's Mandatory to repair here and sell as much as you can
step
.goto 50,47.33,20.10,20,0
.goto 50,49.29,14.09,20,0
.goto 50,47.24,11.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brother Nimetz
.turnin 26734 >>Turn in The Source of the Madness
step
.goto 50,46.99,10.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Corporal Sethman
.turnin 26744 >>Turn in Deep Roots
step
.goto 50,47.10,10.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Corporal Kaleb
.turnin 26765 >>Turn in Return to Corporal Kaleb
step
.goto 50,47.13,10.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Osborn Obnoticus
.turnin 26745 >>Turn in Favored Skull
step
.goto 50,47.57,10.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lieutenant Doren
.turnin 26737,1 >>Turn in Stopping Kurzen's Legacy
step
.goto 50,47.98,12.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Berrin Burnquill
.turnin 26742 >>Turn in Bloodscalp Insight
]])
RXPGuides.RegisterGuide([[
#df
#version 1
#group RestedXP Alliance 10-60
#name 2A_Redridge Mountains
#displayname Chapter 2 - Redridge Mountains
#next 3A_Duskwood
#fresh 30
#veteran
<<Alliance
step
#completewith next
.goto 49,10.12,64.26,60 >>Travel to Redridge Mountains
.zoneskip 49
step
.goto 49,16.03,64.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Wanted Poster
.accept 26504 >>Accept WANTED: Redridge Gnolls
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Darcy inside and Parker upstairs
.accept 26506 >>Accept Franks and Beans
.goto 49,15.62,65.33
.accept 26503 >>Accept Still Assessing the Threat
.goto 49,15.42,65.91,12,0
.goto 49,15.32,64.59
.target Darcy Parker
.target Watch Captain Parker
step
.goto 49,13.93,67.67,40,0
.goto 49,11.78,70.33,40,0
.goto 49,14.62,76.05,40,0
.goto 49,15.98,72.70,40,0
.goto 49,21.04,59.95,40,0
.goto 49,13.93,67.67,40,0
.goto 49,11.78,70.33,40,0
.goto 49,14.62,76.05,40,0
.goto 49,15.98,72.70,40,0
.goto 49,21.04,59.95
>>Kill Tarantulas. Loot them for their Eyes
.complete 26506,1 
.target Tarantula
step
#completewith Martie
>>Kill Dire Condors. Loot them for their Giblets
>>Kill Goretusks. Loot them for their Kidneys
.complete 26506,2 
.complete 26506,3 
.target Dire Condor
.target Great Goretusk
step
#completewith next
>>Kill Gnolls. Don't focus on this at all
.complete 26504,1 
.target Redridge Brute
.target Redridge Thrasher
step
.goto 49,16.20,55.26
>>Loot the Battle Plans on the ground
.complete 26503,1 
step
#label Martie
.goto 49,22.04,42.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Martie
.accept 26509 >>Accept An Unwelcome Guest
.target Martie Jainrose
step
.goto 49,17.91,44.87
>>Kill Bellygrub. Loot her for her Tusk
.complete 26509,1 
.target Bellygrub
step
.goto 49,22.04,42.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Martie
.turnin 26509 >>Turn in An Unwelcome Guest
step
#completewith next
.goto 49,26.06,42.58,10,0
.goto 49,26.34,42.20,10 >>Go inside the Inn
step
.goto 49,26.40,41.41
.home >>Set your Hearthstone to Lakeshire
.target Innkeeper Brianna
step
#completewith next
.goto 49,28.49,42.44,10,0
.goto 49,27.93,41.52,10 >>Go inside the Town Hall
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Conacher and Solomon
.accept 26511 >>Accept Lake Everstill Clean Up
.accept 26728 >>Accept Hero's Call: Duskwood!
.goto 49,28.67,40.95
.accept 26510 >>Accept We Must Prepare!
.goto 49,28.91,41.12
.target Bailiff Conacher
.target Magistrate Solomon
step
.goto 49,28.34,48.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Shawn
.accept 26508 >>Accept Nida's Necklace
.target Shawn
step
.goto 49,27.05,50.96,30,0
.goto 49,29.77,49.32,30,0
.goto 49,32.20,50.23
>>Jump into the water and look around for a Big Dirt Puddle on the Ground. It has multiple spawn points. Loot it for the Necklace
.complete 26508,1 
.isOnQuest 26508
step
#completewith next
.goto 49,29.42,53.76
.fp Lakeshire >>Get the Lakeshire Flight Path
step
#completewith next
>>Kill Murlocs. Kill Squiddic (rare) if he's up on the island in front of the Gnomecorder
.complete 26511,1 
.target Murloc Flesheater
.target Murloc Scout
.unitscan Squiddic
step
.goto 49,37.82,42.16
>>Loot the Gnomecorder on the ground
.complete 26510,1 
step
.goto 49,38.92,40.88,30,0
.goto 49,38.79,44.56,30,0
.goto 49,37.69,45.53,30,0
.goto 49,40.84,48.84,30,0
>>Kill Murlocs
.complete 26511,1 
.target Murloc Flesheater
.target Murloc Scout
.unitscan Squiddic
step
.goto 49,28.28,48.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nida
.turnin 26508 >>Turn in Nida's Necklace
.target Nida
.isQuestComplete 26508
step
#completewith next
.goto 49,28.49,42.44,10,0
.goto 49,27.93,41.52,10 >>Go inside the Town Hall
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Conacher and Solomon
.turnin 26511 >>Turn in Lake Everstill Clean Up
.goto 49,28.67,40.95
.turnin 26510 >>Turn in We Must Prepare!
.accept 26512 >>Accept Tuning the Gnomecorder
.goto 49,28.91,41.12
step
.goto 49,28.84,43.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Karen
.vendor 790 >> Sell the Trash in your bags
.target Karen Taylor
.xp <20,1
step << DarkIronDwarf/Monk
#sticky
#completewith warmode1
.xp <20,1
.pve
+It's highly recommended to turn on Warmode when you reach Level 20 as soon as possible it will increase your Leveling Speed by up to 30%!
*If you don't want to turn on Warmode we still go back to Stormwind to learn Journeyman Riding!
step << DarkIronDwarf
.xp <20,1
#completewith next
.zoneskip 84
.pve
+Use your Racial "Mole Machine" Click it and Select (1) Eastern Kingdoms then (2) Stormwind
step <<DarkIronDwarf
.xp <20,1
.goto 84,70.07,47.25,10,0
.goto 84,68.61,51.24,10,0
.goto 84,67.3,57.41,20,0
.goto 84,67.3,57.41,20,0
.goto 84,68.67,62.27,15,0
.goto 84,65.94,64.29,15,0
.goto 84,64.13,66.9,15,0
.goto 84,68.33,75.04,15,0
.goto 84,70.22,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
.skill riding,150 >> Learn Journeyman Riding
step <<Monk
#completewith next
.xp <20,1
.zoneskip 84
.goto 379,48.96,43.36
.pve
+Use Zen Pilgrimage in your Spellbook then go and take the Stormwind Portal (manually skip this step if it didn't complete when you are in Stormwind)
step <<Monk
.xp <20,1
.goto 84,48.86,87.94,10,0
.goto 84,53.92,85.22,20,0
.goto 84,53.76,79.08,10,0
.goto 84,60.16,71.82,10,0
.goto 84,62.4,73.30,15,0
.goto 84,62.7,70.13,15,0
.goto 84,68.28,74.58,10,0
.goto 84,70.22,73.35
>>Go down the Spiral Staircase
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
.skill riding,150 >> Learn Journeyman Riding
step <<DarkIronDwarf/Monk
+Open Up your Talents(Default N) and turn on Warmode
*Skip this Step if you don't want to turn on Warmode (not recommended)
.pve
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 49
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ariena
.goto 49,29.42,53.76
.zoneskip 84
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step <<DarkIronDwarf/Monk
#label warmode1
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Lakeshire >>Fly to Lakeshire
step <<!DarkIronDwarf/!Monk
#sticky
#completewith warmode2
#title Warmode Experience Bonus
.xp <20,1
.pve
+It's highly recommended to turn on Warmode when you reach Level 20 as soon as possible it will increase your Leveling Speed by up to 30%!
*If you don't want to turn on Warmode we still go back to Stormwind to learn Journeyman Riding!
step <<!Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ariena
.goto 49,29.42,53.76
.fly Stormwind >>Fly to Stormwind
step <<!Monk/!DarkIronDwarf
.xp <20,1
.goto 84,70.22,73.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
.skill riding,150 >> Learn Journeyman Riding
step <<!Monk/!DarkIronDwarf
+Open Up your Talents(Default N) and turn on Warmode
*Skip this Step if you don't want to turn on Warmode(not recommended)
.pve
step <<!Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 49
.pve
.fly Goldshire >>Fly to Goldshire
step <<!Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ariena
.goto 49,29.42,53.76
.zoneskip 84
.pvp
.fly Goldshire >>Fly to Goldshire
step <<!Monk/!DarkIronDwarf
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step <<!Monk/!DarkIronDwarf
#completewith warmode2
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Lakeshire >>Fly to Lakeshire
step
.goto 49,27.96,41.49,5,0
.goto 49,28.49,42.41,5,0
.goto 49,31.86,44.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Marris outside the Major's Building near the Bridge
.accept 26513 >>Accept Like a Fart in the Wind
step
>>Follow the Arrow
.goto 49,32.24,40.02
.complete 26512,1 
step
.goto 49,32.24,40.02
>>There will be a Quest Turnin Pop-Up in your Questlog Click it to turn it in
.turnin 26512 >>Turn in Tuning the Gnomecorder
.accept 26514 >>Accept Canyon Romp
step
#completewith Reminder1
>>Click the Crates in the Area.
.complete 26513,1 
step
>>Kill and LOOT Gnolls in the Area. Check the camps for a chest.
.goto 49,21.52,34.18
.complete 26514,1 
.accept 26519 >>Accept He Who Controls the Ettins
step
>>Click the Quest Pop-up to turn in and accept the next Quest
.turnin 26514 >>Turn in Canyon Romp
.accept 26544 >>Accept They've Wised Up...
step
#label Reminder1
>>Go inside the Cave, Kill and LOOT Orcs
.goto 49,19.58,24.34
.complete 26544,1 
step
>>Click the Quest Pop-up to turn in and accept the next Quest
.turnin 26544 >>Turn in They've Wised Up...
.accept 26545 >>Accept Yowler Must Die!
step
>>Kill Ardo Dirtpaw inside the Cave. Check for a chest near him.
.goto 49,18.09,22.4,10,0
.goto 49,17.96,18.53
.complete 26519,1 
step
.goto 49,17.85,18.62
>>Click The Ettin Control Orb
.turnin 26519 >>Turn in He Who Controls the Ettins
.accept 26520 >>Accept Saving Foreman Oslow
step
>>Kill and LOOT Yowler. Finish looting crates if you haven't.
.goto 49,18.25,22.54,15,0
.goto 49,21.23,27.5,20,0
.goto 49,26.48,21.50
.complete 26545,1 
.complete 26545,2 
.complete 26513,1 
step
#sticky
#completewith QuestKeybindingsEttin
+If you want to make the most of RXP; Press Escape -> Options -> Keybindings -> RestedXP Guides -> Select and Bind Active Button 1,2,3 and 4
*This will allow you to press a keybind to use a Quest Item rather than manually clicking it
step
#label QuestKeybindingsEttin
>>Target an Ettin in the Area and Use the Item "Ettin Control Orb" in your Bags. Then travel to the Next Waypoint and use the Questitem in your Bags near the Boulder
.goto 49,31.48,44.33
.use 58895
.complete 26520,1 
step
.goto 49,31.87,44.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Marris
.turnin 26513,1 >>Turn in Like a Fart in the Wind
step
#sticky
#completewith next
>>If you need to sell you can talk to Karen
.goto 49,28.83,43.57,10,0
.vendor 790
step
.goto 49,28.51,42.45,5,0
.goto 49,28.15,41.83,5,0
.goto 49,27.91,41.34,5,0
.goto 49,28.91,41.1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Magistrate Solomon inside the Major's Building
.turnin 26520,1 >>Turn in Saving Foreman Oslow
.turnin 26545 >>Turn in Yowler Must Die!
step
.goto 49,28.67,40.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Colonel Troteman
.accept 26567 >>Accept John J. Keeshan
step
.goto 49,27.91,41.82,8,0
.goto 49,28.34,41.85,5,0
.goto 49,28.49,42.62,3,0
.goto 49,26.06,42.83,5,0
.goto 49,26.07,42.13,5,0
.goto 49,26.28,40.5,5,0
.goto 49,25.88,39.43,5,0
.goto 49,26.3,40.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to John J. Keeshan inside the Basement's Inn
.turnin 26567 >>Turn in John J. Keeshan
.accept 26568 >>Accept This Ain't My War
step
.goto 49,25.99,39.53,10,0
.goto 49,26.27,40.75,10,0
.goto 49,26.27,42.24,10,0
.goto 49,26.06,42.85,3,0
.goto 49,28.49,42.51,5,0
.goto 49,27.96,41.59,5,0
.goto 49,28.66,40.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Colonel Troteman inside the Major's Building patrolling a little
.turnin 26568 >>Turn in This Ain't My War
.accept 26571 >>Accept Weapons of War
.accept 26586 >>Accept In Search of Bravo Company
step
.goto 49,27.93,41.47,5,0
.goto 49,28.48,41.97,5,0
.goto 49,28.49,42.55,5,0
.goto 49,29.65,44.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Foreman Oslow outside the Building
.accept 26569 >>Accept Surveying Equipment
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Marris
.goto 49,29.73,44.52
.accept 26570 >>Accept Render's Army
step
>> Check for Chatter (Rare)
.goto 49,37.74,34.14,30
step
#completewith next
>>Kill and LOOT Condors as you quest
.complete 26506,2 
step
.goto 49,47.50,41.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Messner
.turnin 26586 >>Turn in In Search of Bravo Company
.accept 26587 >>Accept Breaking Out is Hard to Do
step
>>Kill and LOOT Murdunk and Homurk. Don't worry about the 25 orc quest right now.
.goto 49,51.68,41.27
.complete 26571,2 
.complete 26571,1 
step
>>Click the Quest Turnin Pop-up to turn in the Quest, alternatively open up your questlog and click on the quest then turn it in. Type /reload if you cannot turn the quest in.
.turnin 26571 >>Turn in Weapons of War
.accept 26573 >>Accept His Heart Must Be In It
step
>>Click the Key on the tree stump in the middle, be careful of the Captain patrolling
.goto 49,49.21,38.00
.complete 26587,1 
step
.goto 49,47.50,41.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Messner
.turnin 26587 >>Turn in Breaking Out is Hard to Do
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Messner next to you
>>If he doesn't show up after 30 seconds, relog.
.accept 26560 >>Accept Jorgensen
step
>>Kill and loot Condors
.goto 49,44.82,32.84
.complete 26506,2 
step
#completewith endoforc
>>Kill Orcs on your way to other objectives. Loot the trackers.
.complete 26570,1 
.complete 26569,1 
step
#completewith next
>>Kill and loot Boars
.complete 26506,3 
step
>>Kill and LOOT Utroka the Keymistress
.goto 49,43.41,11.26
.complete 26560,1 
step
>>Kill and LOOT Boars
.goto 49,43.41,11.26
.complete 26506,3 
step
.goto 49,33.58,11.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jorgensen in the Cage. Check for Kazon (rare) and a chest near Jorgensen.
.turnin 26560 >>Turn in Jorgensen
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jorgensen next to you
.accept 26561 >>Accept Krakauer
step
>>Click the Blackrock Coffer
.goto 49,30.81,9.45,10,0
.goto 49,29.82,9.57,10,0
.goto 49,28.32,10.9,10,0
.goto 49,26.65,10.58
.complete 26573,2 
.complete 26573,1 
step
>>Kill Ritualist Tarak. Check for the chest near them.
.goto 49,26.65,10.58
.complete 26561,1 
step
.goto 49,25.91,10.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Krakauer
.turnin 26561 >>Turn in Krakauer
step
>>Wait for the small roleplay then talk to Krakauer next to you
.accept 26562 >>Accept And Last But Not Least... Danforth
step
>>Kill and LOOT Overlord Barbarius (make sure your npcs are with you)
.goto 49,26.17,11.42,15,0
.goto 49,25.42,14.77,10,0
.goto 49,26.26,16.78,10,0
.goto 49,27.59,17.44
.complete 26562,1 
.complete 26562,2 
step
#label endoforc
.goto 49,27.77,17.95,1,0
.goto 49,28.33,16.98,5,0
>>Click the Lever to free Danforth then Talk to Danforth then wait for the roleplay
>>If you can't turn in any Quest with Danroth after a short while relog
.turnin 26562 >>Turn in And Last But Not Least... Danforth
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Danforth next to you
.accept 26563 >>Accept Return of the Bravo Company
step
>>Finish killing orcs and looting trackers
.goto 49,30.81,9.45,10,0
.goto 49,29.82,9.57,10,0
.goto 49,28.32,10.9,10,0
.goto 49,26.65,10.58
.complete 26570,1 
.complete 26569,1 
step
>>Use Hearthstone
#completewith next
.hs >> Heartstone to Lakeshire
step
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kimberly
.goto 49,26.45,42.03,8,0
>>If you need to sell items
.vendor 789 >> Repair and Sell as much as you can
step
.goto 49,28.66,40.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Colonel Troteman inside the town hall
.turnin 26573 >>Turn in His Heart Must Be In It
.turnin 26563 >>Turn in Return of the Bravo Company
.accept 26607 >>Accept They Drew First Blood
step
.goto 49,27.94,41.48,7,0
.goto 49,28.48,42.25,7,0
.goto 49,26.05,42.77,7,0
.goto 49,26.31,42.21,7,0
.goto 49,26.12,40.25,10,0
.goto 49,25.92,39.5,10,0
.goto 49,26.34,40.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to John J. Keeshan in the Basement
.turnin 26607 >>Turn in They Drew First Blood
.accept 26616 >>Accept It's Never Over
step
.goto 49,25.92,39.48,8,0
.goto 49,26.25,40.56,8,0
.goto 49,26.32,42.42,8,0
.goto 49,26.06,42.96,6,0
.goto 49,29.66,44.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Foreman Oslow outside the Building
.turnin 26569 >>Turn in Surveying Equipment
step
.goto 49,29.73,44.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Marris
.turnin 26570 >>Turn in Render's Army
step <<DarkIronDwarf/Monk
#sticky
#completewith warmode3
#title Warmode Experience Bonus
.xp <20,1
.pve
+It's highly recommended to turn on Warmode when you reach Level 20 as soon as possible it will increase your Leveling Speed by up to 30%!
*If you don't want to turn on Warmode we still go back to Stormwind to learn Journeyman Riding!
step <<DarkIronDwarf
.xp <20,1
#completewith next
.zoneskip 84
.pve
+Use your Racial "Mole Machine" Click it and Select (1) Eastern Kingdoms then (2) Stormwind
step <<DarkIronDwarf
.xp <20,1
.goto 84,70.07,47.25,10,0
.goto 84,68.61,51.24,10,0
.goto 84,67.3,57.41,20,0
.goto 84,67.3,57.41,20,0
.goto 84,68.67,62.27,15,0
.goto 84,65.94,64.29,15,0
.goto 84,64.13,66.9,15,0
.goto 84,68.33,75.04,15,0
.goto 84,70.22,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
.skill riding,150 >> Learn Journeyman Riding
step <<Monk
#completewith next
.xp <20,1
.zoneskip 84
.goto 379,48.96,43.36
.pve
+Use Zen Pilgrimage in your Spellbook then go and take the Stormwind Portal (manually skip this step if it didn't complete when you are in Stormwind)
step <<Monk
.xp <20,1
.goto 84,48.86,87.94,10,0
.goto 84,53.92,85.22,20,0
.goto 84,53.76,79.08,10,0
.goto 84,60.16,71.82,10,0
.goto 84,62.4,73.30,15,0
.goto 84,62.7,70.13,15,0
.goto 84,68.28,74.58,10,0
.goto 84,70.22,73.35
>>Go down the Spiral Staircase
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
.skill riding,150 >> Learn Journeyman Riding
step <<DarkIronDwarf/Monk
+Open Up your Talents(Default N) and turn on Warmode
*Skip this Step if you don't want to turn on Warmode (not recommended)
.pve
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 49
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ariena
.goto 49,29.42,53.76
.zoneskip 84
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step <<DarkIronDwarf/Monk
#label warmode3
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Lakeshire >>Fly to Lakeshire
step <<!DarkIronDwarf/!Monk
#sticky
#completewith warmode4
#title Warmode Experience Bonus
.xp <20,1
.pve
+It's highly recommended to turn on Warmode when you reach Level 20 as soon as possible it will increase your Leveling Speed by up to 30%!
*If you don't want to turn on Warmode we still go back to Stormwind to learn Journeyman Riding!
step <<!Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ariena
.goto 49,29.42,53.76
.fly Stormwind >>Fly to Stormwind
step <<!Monk/!DarkIronDwarf
.xp <20,1
.goto 84,70.22,73.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
.skill riding,150 >> Learn Journeyman Riding
step <<!Monk/!DarkIronDwarf
+Open Up your Talents(Default N) and turn on Warmode
*Skip this Step if you don't want to turn on Warmode(not recommended)
.pve
step <<!Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 49
.pve
.fly Goldshire >>Fly to Goldshire
step <<!Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ariena
.goto 49,29.42,53.76
.zoneskip 84
.pvp
.fly Goldshire >>Fly to Goldshire
step <<!Monk/!DarkIronDwarf
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step <<!Monk/!DarkIronDwarf
#completewith warmode4
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Lakeshire >>Fly to Lakeshire
step
.isOnQuest 26616
>>Click the Boat
.goto 49,34.36,45.82,10
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Arien
.goto 49,52.92,54.63
.fp >>Get the Camp Everstill Flight Path
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to John J. Keeshan
.goto 49,52.55,55.39
.turnin 26616 >>Turn in It's Never Over
.accept 26639 >>Accept Point of Contact: Brubaker
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Krakauer, Messner, and Danforth
.accept 26636 >>Accept Bravo Company Field Kit: Camouflage
.goto 49,52.4,55.42
.accept 26637 >>Accept Bravo Company Field Kit: Chloroform
.goto 49,52.43,55.55
.accept 26638 >>Accept Hunting the Hunters
.goto 49,52.54,55.57
step
>>Go into the water and kill and loot Muckdwellers
.goto 49,42.09,54.06
.complete 26637,1 
step
#completewith next
>>Click Fox Poop and Leaves in the Area. Check for chests in the murloc camp as you quest.
.complete 26636,2 
.complete 26636,1 
step
>>Kill Stealthed Blackrock Hunter in the Area
.goto 49,41.60,69.68
.complete 26638,1 
step
>>Click Fox Poop and Leaves in the Area. Check for chests in the murloc camp as you quest.
.goto 49,41.60,69.68
.complete 26636,2 
.complete 26636,1 
step
.goto 49,53.05,67.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brubaker. Look for a chest nearby.
.turnin 26639 >>Turn in Point of Contact: Brubaker
.accept 26640 >>Accept Unspeakable Atrocities
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Messner, Krakauer, Danforth, and John J.Keeshan
.turnin 26637,1 >>Turn in Bravo Company Field Kit: Chloroform
.goto 49,52.45,55.52
.turnin 26636 >>Turn in Bravo Company Field Kit: Camouflage
.goto 49,52.4,55.4
.turnin 26638 >>Turn in Hunting the Hunters
.goto 49,52.53,55.55
.turnin 26640 >>Turn in Unspeakable Atrocities
.goto 49,52.54,55.42
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Arien Masters
.xp 20.0,1
.goto 49,52.92,54.62
.fly Lakeshire >>Fly to Lakeshire
step
#sticky
#label warmode5
#title Warmode Experience Bonus
.xp <20,1
.pve
+It's highly recommended to turn on Warmode when you reach Level 20 as soon as possible it will increase your Leveling Speed by up to 30%!
*If you don't want to turn on Warmode we still go back to Stormwind to learn Journeyman Riding!
step <<DarkIronDwarf
.xp <20,1
#completewith next
.zoneskip 84
.pve
+Use your Racial "Mole Machine" Click it and Select (1) Eastern Kingdoms then (2) Stormwind
step <<DarkIronDwarf
.xp <20,1
.goto 84,70.07,47.25,10,0
.goto 84,68.61,51.24,10,0
.goto 84,67.3,57.41,20,0
.goto 84,67.3,57.41,20,0
.goto 84,68.67,62.27,15,0
.goto 84,65.94,64.29,15,0
.goto 84,64.13,66.9,15,0
.goto 84,68.33,75.04,15,0
.goto 84,70.22,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
.skill riding,150 >> Learn Journeyman Riding
step <<Monk
#completewith next
.xp <20,1
.zoneskip 84
.goto 379,48.96,43.36
.pve
+Use Zen Pilgrimage in your Spellbook then go and take the Stormwind Portal(manually skip this step if it didn't complete when you are in Stormwind)
step <<Monk
.xp <20,1
.goto 84,48.86,87.94,10,0
.goto 84,53.92,85.22,20,0
.goto 84,53.76,79.08,10,0
.goto 84,60.16,71.82,10,0
.goto 84,62.4,73.30,15,0
.goto 84,62.7,70.13,15,0
.goto 84,68.28,74.58,10,0
.goto 84,70.22,73.35
>>Go down the Spiral Staircase
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
.skill riding,150 >> Learn Journeyman Riding
step <<DarkIronDwarf/Monk
+Open Up your Talents(Default N) and turn on Warmode
*Skip this Step if you don't want to turn on Warmode(not recommended)
.pve
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 49
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Arien Masters
.goto 49,52.92,54.62
.zoneskip 84
.fly Goldshire >>Fly to Goldshire
step <<DarkIronDwarf/Monk
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step <<DarkIronDwarf/Monk
#label warmode5
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Lakeshire >>Fly to Lakeshire
step
#sticky
#label warmode6
#title Warmode Experience Bonus
.xp <20,1
.pve
+It's highly recommended to turn on Warmode when you reach Level 20 as soon as possible it will increase your Leveling Speed by up to 30%!
*If you don't want to turn on Warmode we still go back to Stormwind to learn Journeyman Riding!
step <<!Monk/!DarkIronDwarf
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Arien Masters
.goto 49,52.92,54.62
.pve
.fly Stormwind >>Fly to Stormwind
step <<!Monk/!DarkIronDwarf
.xp <20,1
.goto 84,70.22,73.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Journeyman Riding
.skill riding,150 >> Learn Journeyman Riding
step <<!Monk/!DarkIronDwarf
+Open Up your Talents(Default N) and turn on Warmode
*Skip this Step if you don't want to turn on Warmode(not recommended)
.pve
step <<!Monk/!DarkIronDwarf
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dungar
.goto 84,70.94,72.45
.zoneskip 49
.fly Goldshire >>Fly to Goldshire
step <<!DarkIronDwarf/!Monk
#completewith next
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Arien Masters
.goto 49,52.92,54.62
.zoneskip 84
.fly Goldshire >>Fly to Goldshire
step <<!Monk/!DarkIronDwarf
.xp <20,1
.goto 37,42.11,65.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Marshal Dughan
.turnin 76 >>Turn in The Jasperlode Mine
step <<!Monk/!DarkIronDwarf
.xp <20,1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bartlett
.goto 37,41.72,64.44
.fly Lakeshire >>Fly to Lakeshire
step
.isOnQuest 31781
>>Take any fast 25 Pets
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lindsay
.skipgossip 1
.complete 31781,1 
step
.isQuestComplete 31781
>>Click the Quest Pop-up to turn in the Quest anywhere
.turnin 31781 >>Turn in Questlog
step
.goto 49,34.87,60.2,15
>> Check for Snarlflare(Rare) on the Mountain
step
#completewith gnollyordery
>>Kill Redridge Gnolls
.complete 26504,1 
step
>>Click the Gnoll Strategy Guide. Check for Ripchaser (Rare) in the Gnoll Camp
.goto 49,30.56,62.73
.complete 26503,3 
step
#label gnollyordery
>>Click the Gnoll Orders. Check for a treasure chest in this camp.
.goto 49,28.02,74.9
.complete 26503,2 
step
>>Kill Redridge Gnolls
.goto 49,28.02,74.9
.complete 26504,1 
step
.goto 49,24.24,71.11,30
>>Check for Gnollfeaster (Rare)
step
#requires area999
.goto 49,15.62,65.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Darcy Parker inside the Tower
.turnin 26506 >>Turn in Franks and Beans
step
.goto 49,15.33,64.58
>>Go up the Spiral Staircase and Return to Watch Captain Parker
.turnin 26503,1 >>Turn in Still Assessing the Threat
.turnin 26504 >>Turn in WANTED: Redridge Gnolls
.accept 26505 >>Accept in Parker's Report
]])
RXPGuides.RegisterGuide([[
#df
#version 1
#group RestedXP Alliance 10-60
#displayname Chapter 6 - Redridge Mountains Part 2
#name 6A_Redridge Mountains 2
#next 7A_Tirangarde Sound
#fresh 30
#veteran
<<Alliance
step
.next << 30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 37,77.48,44.28
.fly Camp Everstill >>Fly to Camp Everstill
step
#completewith next
.goto 49,69.51,76.32
+Check for a Chest(don't look for too long)
step
#completewith next
>>Use the Item |T133878:0|t[Bravo Company Field Kit] in your Bags when you are close to the Orcs to disguise yourself with (1) and distract them with (2) Distraction make them go to sleep with (3) Chloroform
>>You can mount normally with the Item
>>Go inside the Cave and collect the Key
.goto 49,69.51,76.32
.use 60394
.collect 59261,1
step
>>Use the Item |T133878:0|t[Bravo Company Field Kit] in your Bags when you are close to the Orcs to disguise yourself with (1) and distract them with (2) Distraction make them go to sleep with (3) Chloroform
>>Click the Cage
.goto 49,68.64,60.35
.complete 26646,1 
.use 60384
step
>>Click the Pop Up in your Questlog and turn in the Quest
.turnin 26646 >>Turn in Prisoners of War
.accept 26651 >>Accept To Win a War, You Gotta Become War
step
>>Use (1) to disguise yourself Use (2) to Distract the Orcs infront of the Tower, Use (3) Cloroform on the Orcs, Continue to distract
>>Plant a (4) Bomb ontop of the Tower inside the small room
.goto 49,66.43,71.40
.complete 26651,2 
step
>>Use (1) to disguise yourself, Use (2) to distract Orcs (4) Plant Bomb inside the Small Building
.goto 49,63.98,70.22
.complete 26651,1 
step
#completewith next
+Check for Chitter(Rare)
.goto 49,63.73,65.76,25,0
step
.goto 49,77.67,65.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to John J. Keeshan
.turnin 26651 >>Turn in To Win a War, You Gotta Become War
.accept 26668 >>Accept Detonation
.turnin 26668 >>Turn in Detonation
.accept 26693 >>Accept The Dark Tower
step
.goto 49,77.63,65.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to John J. Keeshan
.accept 26692 >>Accept Shadowhide Extinction
step
#sticky
>>Kill 20 Shadowhide Gnolls(you have time for it)
.complete 26692,1 
step
#completewith next
+Check for Rohh the Silent(he's an invisible Gnoll)
.goto 49,68.2,35.53
step
>>Kill and LOOT General Fangore inside the Cave
.goto 49,67.59,29.13
.complete 26693,1 
step
>>Click the Pop Up in your Questlog and turn in the Quest
.turnin 26693 >>Turn in The Dark Tower
.accept 26694 >>Accept The Grand Magus Doane
step
#completewith next
.goto 49,70.99,41.63,25,0
+Check for the Chest inside the Gnollcamp(Don't look for too long)
*Check for Rohh the Silent(if you haven't killed him yet don't look for too long)
step
#completewith next
+Check for the Chest inside the Towerif you don't see it when you enter the Tower it's not there
step
>>Click the Barrier and go inside the Tower
>>Go up the Spiral Staircases and Kill Grand Magus Doane
.goto 49,72.01,44.81,10,0
.goto 49,70.56,44.77,15,0
.goto 49,71.18,45.21
.complete 26694,1 
step
.goto 49,77.68,65.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to John J. Keeshan
.turnin 26694 >>Turn in The Grand Magus Doane
step
>>Click the Pop Up in your Questlog and turn in the Quest
.turnin 26692 >>Turn in Shadowhide Extinction
step
.goto 49,77.19,65.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Colonel Troteman
>>Wait for the Roleplay
.accept 26708 >>Accept AHHHHHHHHHHHH! AHHHHHHHHH!!!
step
>>Click on the Bravo Company Siege Tank press 1 to destroy Orcs
.goto 49,60.66,36.66
.complete 26708,1 
step
.goto 49,60.67,36.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Colonel Troteman
.turnin 26708,1 >>Turn in AHHHHHHHHHHHH! AHHHHHHHHH!!!
.accept 26713 >>Accept Showdown at Stonewatch
step
>>Kill Tharil'zun make sure your Team is with you they should spawn near the first Elite Orc
.goto 49,60.07,47.10
.complete 26713,1 
step
>>Kill Gath'Ilzogg make sure your Team is with you
.goto 49,58.81,55.13
.complete 26713,2 
step
.goto 49,58.81,55.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Shiekover
.turnin 26713 >>Turn in Showdown at Stonewatch
.accept 26714 >>Accept Darkblaze, Brood of the Worldbreaker
step
>>Kill Darkblaze make sure your Team is with you
>>When he drops a Horn pick it up
.goto 49,58.65,55.31
.complete 26714,1 
step
.goto 49,60.65,36.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Colonel Troteman
.turnin 26714 >>Turn in Darkblaze, Brood of the Worldbreaker
.accept 26726 >>Accept Triumphant Return
step
#completewith next
+Check for Chatter(Rare)
.goto 49,37.74,34.14,60,0
step
.goto 49,28.5,42.6,5,0
.goto 49,28.24,41.83,5,0
.goto 49,27.93,41.46,5,0
.goto 49,28.92,41.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Magistrate Solomon
.turnin 26726 >>Turn in Triumphant Return
step
.goto 49,28.92,41.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Magistrate Solomon
.turnin -26505 >>Turn in Parker's Report
step <<DarkIronDwarf
#level 30
#completewith next
.zoneskip 84
+Use your Racial "Mole Machine" Click it and Select (1) Eastern Kingdoms then (2) Stormwind
step <<DarkIronDwarf
#level 30
.goto 84,70.07,47.25,10,0
.goto 84,68.61,51.24,10,0
.goto 84,67.3,57.41,20,0
.goto 84,67.3,57.41,20,0
.goto 84,68.67,62.27,15,0
.goto 84,65.94,64.29,15,0
.goto 84,64.13,66.9,15,0
.goto 84,68.33,75.04,15,0
.goto 84,70.22,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Expert Riding
.turnin 32675 >>Turn in I Believe You Can Fly
.skill riding,225 >> Learn Expert Riding(Normal Flying)
step <<Monk
#level 30
#completewith next
.zoneskip 84
.goto 379,48.96,43.36
+Use Zen Pilgrimage in your Spellbook then go and take the Stormwind Portal(manually skip this step if it didn't complete when you are in Stormwind)
step <<Monk
#level 30
.goto 84,48.86,87.94,10,0
.goto 84,53.92,85.22,20,0
.goto 84,53.76,79.08,10,0
.goto 84,60.16,71.82,10,0
.goto 84,62.4,73.30,15,0
.goto 84,62.7,70.13,15,0
.goto 84,68.28,74.58,10,0
.goto 84,70.22,73.35
>>Go down the Spiral Staircase
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Expert Riding
.turnin 32675 >>Turn in I Believe You Can Fly
.skill riding,225 >> Learn Expert Riding(Normal Flying)
step << !Monk/!DarkIronDwarf
#level 30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Felicia
.goto 37,77.48,44.28
.fly Stormwind >>Fly to Stormwind
step << !Monk/!DarkIronDwarf
#level 30
.goto 84,70.22,73.35
>>Go down the Spiral Staircase
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and Learn Expert Riding
.turnin 32675 >>Turn in I Believe You Can Fly
.skill riding,225 >> Learn Expert Riding(Normal Flying)
]])
RXPGuides.RegisterGuide([[
#df
#version 1
#group RestedXP Alliance 10-60
#name 7A_Tirangarde Sound
#displayname Chapter 7 - Tiragarde Sound
#next 8A_Tiragarde Sound Part 2
<<Alliance
step 
.zoneskip 84
.cast 265225 >>Cast "Mole Machine," then take it to Stormwind <<DarkIronDwarf/DarkIronDwarf Monk
.cast 126892 >>Cast "Zen Pilgrimage," then use the Portal to Stormwind <<Monk !DarkIronDwarf
.goto 379,48.64,42.94,5,0 <<Monk !DarkIronDwarf
.goto 379,48.97,43.37,0 <<Monk !DarkIronDwarf
.fly Stormwind >> Fly to Stormwind <<!DarkIronDwarf !Monk
step 
.goto 84,49.07,87.09,10,-1 <<Monk !DarkIronDwarf 
.goto 84,49.74,86.32,10,-1 <<Monk !DarkIronDwarf 
.line 84,49.50,86.71,52.22,86.12,53.89,85.23,54.84,82.56,53.64,78.87,55.64,76.50,55.44,75.38,57.31,73.63,60.16,71.55,60.94,73.59,62.04,73.92,64.46,70.14,65.53,70.23 <<Monk !DarkIronDwarf 
.loop 10,84,49.50,86.71,52.22,86.12,53.89,85.23,54.84,82.56,53.64,78.87,55.64,76.50,55.44,75.38,57.31,73.63,60.16,71.55,60.94,73.59,62.04,73.92,64.46,70.14,65.53,70.23 <<Monk !DarkIronDwarf 
.line 84,63.33,37.46,70.27,47.31,67.97,50.43,69.63,53.25,67.14,57.29,67.38,58.58,69.16,62.05,67.03,64.85,65.98,64.14,64.08,66.88,65.53,70.23 << DarkIronDwarf Monk/DarkIronDwarf 
.loop 10,84,63.33,37.46,70.27,47.31,67.97,50.43,69.63,53.25,67.14,57.29,67.38,58.58,69.16,62.05,67.03,64.85,65.98,64.14,64.08,66.88,65.53,70.23 << DarkIronDwarf Monk/DarkIronDwarf 
.line 10,84,65.53,70.23,68.71,73.47,68.21,74.26,68.48,75.56,70.23,73.34 << DarkIronDwarf/Monk 
.loop 10,84,65.53,70.23,68.71,73.47,68.21,74.26,68.48,75.56,70.23,73.34 << DarkIronDwarf/Monk 
.goto 84,70.23,73.34 <<!DarkIronDwarf !Monk
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing in the Trade District
.target Bralla Cloudwing
.turnin 32675 >>Turn in I Believe You Can Fly
.trainer >>Learn Expert Riding
.skill riding,225
step
#fresh
.goto 84,71.40,71.95
.vendor >>Talk to Tannec Stonebeak. Buy a flying mount if you lack one
.target Tannec Stonebeak
step
.goto 84,62.82,71.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hero's Herald
.target Hero's Herald
.accept 46727 >>Accept Battle for Azeroth: Tides of War
step
.goto 84,60.39,75.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Innkeeper Allison
.target Innkeeper Allison
.home >>Set your Hearthstone to Stormwind Trade District
step
#completewith next
.goto 84,61.12,70.62,5,0
+Buy Shrouded Cloth Bags on the Auction House if you need bags
.target Auctioneer Fitch
.target Auctioneer Chilton
.target Auctioneer Jaxon
step
#veteran
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Chromie
.goto 84,56.26,17.32
.skipgossip 1
.accept 60891 >>Accept Cataclysm: Onward to Adventure in the Eastern Kingdoms
step
>>Fly to Stormwind's Keep
.line 84,-80.71,-37.78,-81.95,-36.31,-80.44,-33.37


.goto 84,80.44,33.37
.complete 46727,1 

step
>>Click the Blue Portal
.goto 84,80.45,33.45
.complete 46727,2 
step
.goto 84,80.26,33.12
#label TiragardeIntroduction
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Anduin Wrynn
.turnin 46727 >>Turn in Battle for Azeroth: Tides of War
.accept 46728 >>Accept The Nation of Kul Tiras
step 
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lady Jaina Proudmoore to skip the introduction if you can. Otherwise, talk to her at Stormwind Harbor
.target Lady Jaina Proudmoore
.goto 84,22.79,24.68,5,0
.goto 1161,65.57,50.74
.turnin 46728 >>Turn in The Nation of Kul Tiras
.accept 51341 >>Accept Daughter of the Sea
.skipgossip
step
>>Talk to Flynn Fairwind
.target Flynn Fairwind
.goto 1169,47.42,46.28
.turnin 51341 >>Turn in Daughter of the Sea
.accept 47098 >>Accept Out Like Flynn
step
>>Beat up Flynn! You may need to hit him multiple times.
.goto 1169,46.63,45.53
.complete 47098,1 
step
>>Follow Flynn, then pull the Cell Block Lever
.goto 1169,46.66,40.94
.complete 47098,2 
step
>>Recover your equipment from the chest
.goto 1169,46.77,44.71
.complete 47098,3 
step
>>Kill Block Warden Carmine
.unitscan Block Warden Carmine
.goto 1169,40.33,54.84
.complete 47098,4 
step
>>Loot the Glittering Gunpowder
.goto 1169,43.57,54.10
.complete 47098,5 
step
>>Click the Cell Block Gate (you don't have to take a step back)
.goto 1169,42.31,45.97,7,0
.goto 1169,43.21,37.07
.complete 47098,6 
step
>>Go through the gate, then down the hall to the Sodden Depths. Enter the sewers
.goto 1169,44.41,34.30,12,0
.goto 1169,49.17,40.90,8,0
.goto 1169,44.02,41.44,10,0
.goto 1169,39.06,51.47,5,0
.complete 47098,7 
step
#completewith next
.deathskip >> Pull everything in the sewer, and die. Accept Resurrection Sickness
>>To die faster, you can unequip your gear and repeatedly spam /sit
step
>>Click the Getaway Boat
.target Taelia
.goto 1169,60.77,25.71
.complete 47098,8 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.goto 1161,75.72,23.58
.turnin 47098 >>Turn in Out Like Flynn
.accept 47099 >>Accept Get Your Bearings

step
.goto 1161,74.17,23.36,5,0
.goto 1161,74.17,24.78
>>Approach Will Melborne
.target Will Melborne
.complete 47099,1
step
>>Go up the stairs and through the doorway straight ahead. Bank your valuables if necessary
.goto 1161,73.74,21.63,5,0
.goto 1161,73.76,22.99,5,0
.goto 1161,75.83,22.97,5,0
.goto 1161,75.57,19.24,5,0
.goto 1161,75.88,17.56,5,0
.target Wixler Brass
.target Joey Cash
.target Miranda Moyer
.complete 47099,2
step << KulTiran 
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.goto 1161,68.16,21.99
.accept 47189 >>Accept A Nation Divided
step << KulTiran 
>>Click with the Scouting Map
.goto 1161,68.38,22.11
.complete 47189,1 
step << KulTiran 
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.goto 1161,75.72,23.58
.accept 47960 >>Accept Tiragarde Sound
.turnin 47189 >>Turn in A Nation Divided
step << KulTiran 
.goto 1161,67.60,22.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind
.accept 47181 >>Accept The Smoking Gun
.complete 47181,1 
step << KulTiran 
.goto 1161,67.58,22.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind
.turnin 47181 >>Turn in The Smoking Gun
step << KulTiran 
.goto 1161,67.97,21.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Cyrus Crestfall
.accept 47485 >>Accept The Ashvane Trading Company
step



.goto 1161,73.55,13.52
>>Exit the bank, then climb the stairs to the north. Turn left and enter the building with lanterns at its door
.complete 47099,3
step


.goto 1161,66.97,15.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Joan Weber
.target Joan Weber
.fp >>Get the Boralus Harbor Flight Path
.complete 47099,4
step
.goto 1161,66.97,15.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.turnin 47099 >>Turn in Get Your Bearings
.accept 46729 >>Accept The Old Knight
step
.goto 1161,68.77,21.08,5,0
.goto 1161,67.39,21.67,5,0
.goto 1161,67.13,23.06
>>Enter the Harbormaster's Office
.complete 46729,1 
step
.goto 1161,67.99,21.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Cyrus Crestfall once he's interactable.
.complete 46729,2 
.target Cyrus Crestfall
.skipgossip
step
#completewith WorkersRights
.line 1161,67.21,22.83,67.54,20.89,69.92,21.86
.goto 1161,67.21,22.83,5,0
.goto 1161,67.54,20.89,5,0
.goto 1161,69.92,21.86,30,0
>>Do not wait for the roleplay. Go upstairs and exit the Harbormaster's Office
.target Cyrus Crestfall
.complete 46729,3 
step << KulTiran 
.goto 1161,72.20,16.06,5,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to "Risky" Liz Seminario
.target "Risky" Liz Seminarioc
.accept 51144 >>Accept A Bundle of Furs
step
#label WorkersRights
.goto 895,67.40,24.14
>>Take Boralus Harbor's northwestern bridge out of town
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Davey Brindle
.target Davey Brindle
.accept 50699 >>Accept Worker's Rights
step
#completewith next
+Open Small Treasure Chests as you adventure to gain a lot of experience
step
.goto 895,67.14,24.8
>>Click the Formal Invitation on the table
.accept 48070 >>Accept The Norwington Festival
step
.goto 895,66.85,24.36
>>Click the Wanted Poster on the mast
.accept 51358 >>Accept WANTED: Gryphon 'Nappers
step
.goto 895,68.92,20.43,10,0
.goto 895,68.93,20.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Maynard Algerson
.target Maynard Algerson
.turnin 50699 >>Turn in Worker's Rights
.accept 49465 >>Accept Maximizing Resources
.accept 49452 >>Accept Inventory Deficit
step
#completewith next
.loop 4,895,68.17,18.94,67.65,19.38,67.37,19.44,67.35,18.92,67.42,18.59,67.77,18.25,68.06,18.03,68.17,18.94
>>Kill and loot Timberbough Invaders and Timberfang Lurkers. Collect Abandoned Axes
.complete 49465,1 
.complete 49452,1 
step
.goto 895,68.89,19.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Benjamin Algerson
.target Benjamin Algerson
.accept 49451 >>Accept Time Off Requests
step
#completewith next
.loop 4,895,68.17,18.94,67.65,19.38,67.37,19.44,67.35,18.92,67.42,18.59,67.77,18.25,68.06,18.03,68.17,18.94
>>Kill and loot Timberbough Invaders and Timberfang Lurkers. Collect Abandoned Axes
.complete 49465,1 
.complete 49452,1 
step
>>Click Entangled Lumberjacks
.target Entangled Lumberjack
.loop 4,895,68.17,18.94,67.65,19.38,67.37,19.44,67.35,18.92,67.42,18.59,67.77,18.25,68.06,18.03,68.17,18.94
.complete 49451,1 
step
#completwith next
.loop 5,895,68.17,18.94,67.65,19.38,67.37,19.44,67.35,18.92,67.42,18.59,67.77,18.25,68.06,18.03,68.17,18.94
>>On your way to Lyssa, kill and loot Timberbough Invaders and Timberfang Lurkers. Collect Abandoned Axes
.complete 49465,1 
.complete 49452,1 
step
#requires Area1
.goto 895,66.62,17.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lyssa Treewarden
.target Lyssa Treewarden
.accept 49453 >>Accept Give a Dam
.accept 48557 >>Accept Sowing Saplings
step
#completewith next
.loop 10,895,66.61,17.28,66.15,16.79,66.14,15.89,66.64,15.38,66.82,16.31,66.61,17.28
>>Finish killing and looting Timberbough Invaders and Timberfang Lurkers.
.complete 49465,1 
step
.loop 10,895,66.61,17.28,66.15,16.79,66.14,15.89,66.64,15.38,66.82,16.31,66.61,17.28
>>Click Woodchewing Beavers and collect Loamy Soil
.complete 49453,1 
.complete 48557,1 
step
.goto 895,66.62,17.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lyssa Treewarden
.target Lyssa Treewarden
.turnin 49453 >>Turn in Give a Dam
.turnin 48557 >>Turn in Sowing Saplings
step
.loop 10,895,66.61,17.28,66.15,16.79,66.14,15.89,66.64,15.38,66.82,16.31,66.61,17.28
>>On your way back to Maynard Algerson, finish collecting Abandoned Axes
.complete 49452,1 
step
.goto 895,68.92,20.43,10,0
.goto 895,68.93,20.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Maynard Algerson
.target Maynard Algerson
.turnin 49465 >>Turn in Maximizing Resources
.turnin 49452 >>Turn in Inventory Deficit
.turnin 49451 >>Turn in Time Off Requests
.accept 48369 >>Accept Emergent Strategy
step
.goto 895,70.09,18.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Benjamin Algerson
.target Benjamin Algerson
.turnin 48369 >>Turn in Emergent Strategy
.accept 49468 >>Accept Required Webinar
.accept 49454 >>Accept Pest Prevention
.accept 49450 >>Accept Incident Reports
step
#completewith next
>>On your way to Terrence Foster, kill Enthralled Beasts and destroy Mossfang Eggs. Free Webbed Lumberjacks by clicking them.
*You can finish this after The Witch's Pet
.complete 49450,1 
.complete 49454,1 
.complete 49468,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Terrence Foster
.target Terrence Foster
.goto 895,72.96,17.55,0
.accept 50058 >>Accept The Witch's Pet
step
.goto 895,73.29,18.3
>>Kill the Mossfang Matriarch
*Sidestep Mossfang Matriarch's Venom Wave
.complete 50058,1 
step
#completewith next
>>Click the Quest Complete pop-up in your Quest Tracker
.turnin 50058 >>Turn in The Witch's Pet
step
.loop 10,895,70.14,18.56,71.01,18.90,71.73,18.37,72.96,17.55,71.90,16.87,70.81,17.34,70.14,18.56
>>On your way back to Benjamin Algerson, finish killing Enthralled Beasts and destroying Mossfang Eggs. Free Webbed Lumberjacks by clicking them
.complete 49450,1 
.complete 49454,1 
.complete 49468,1 
step
>>Click the Quest Complete pop-up in your Quest Tracker
.goto 895,70.09,18.58
.turnin 50058 >>Turn in The Witch's Pet
step
#requires Area99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Benjamin Algerson
.target Benjamin Algerson
.goto 895,70.09,18.58
.turnin 49468 >>Turn in Required Webinar
.turnin 49454 >>Turn in Pest Prevention
.turnin 49450 >>Turn in Incident Reports
.accept 49467 >>Accept Witch of the Woods
step
>>Kill and loot the Witch of the Woods
*Step away from her Crawling Swarm
.unitscan Witch of the Woods

.goto 895,70.45,13.75
.complete 49467,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Maynard Algerson
.target Maynard Algerson
.goto 895,68.85,13.17
.turnin 49467 >>Turn in Witch of the Woods
step
.goto 895,67.2,21.70
>>Enter the cave. Kill Silent Boris and Lindel the Snatcher
*CC one of them if you are able. Skip this step if it's too difficult
.unitscan Silent Boris
.unitscan Lindel the Snatcher
.complete 51358,2 
.complete 51358,1 
step
#completewith RecruitBrutis
.goto 895,66.93,23.08
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Mariah McKee
.target Mariah McKee
.fp >>Get the Hatherford Flight Path
step
.goto 895,66.27,24.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dandy Jones
.target Dandy Jones
.turnin -51358 >>Turn in WANTED: Gryphon 'Nappers
.isQuestComplete 51358
step
#completewith RecruitBrutis
.abandon 51358 >>Abandon WANTED: Gryphon 'Nappers
.isOnQuest 51358
step

.goto 895,66.32,24.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hatherford Guard
.accept 50700 >>Accept Drust in Time
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Drogrin Alewhisker
.target Drogrin Alewhisker
.goto 895,62.72,29.95
.turnin 50700 >>Turn in Drust in Time
.accept 49225 >>Accept Chasing the Leader
.accept 49229 >>Accept The Ruins Fought Back
step
#label RecruitBrutis
.goto 895,62.95,29.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Recruit Brutis
.target Recruit Brutis
.accept 49234 >>Accept A Marine Out of Water
step
#completewith next
>>Kill Ancient Protectors on your way into Gol Thovas
*You can finish this later
.unitscan Ancient Protector
.complete 49229,1 
step
.goto 1171,44.51,88.32,10,0
.goto 1171,40.17,72.08,10,0
.goto 1171,50.46,70.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Birch Tomlin
.target Birch Tomlin
.accept 49233 >>Accept I'm a Druid, Not a Priest
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Pendi Cranklefuse
.target Pendi Cranklefuse
.goto 1171,51.24,70.54
.accept 49232 >>Accept Salvaging a Disaster
step
#completewith next
>>On your way to Hilde Firebreaker, open Packaged Relics, free Cursed Raiders, and kill Ancient Protectors
.use 153350 >>|T329590:0|tUse [Repurposed Gilnean Staff] on Cursed Raiders
.complete 49233,1 
.complete 49232,1 
.complete 49229,1 
step
.goto 1171,62.59,56.02,4,0
.goto 1171,58.73,37.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hilde Firebreaker
.target Hilde Firebreaker
.turnin 49225 >>Turn in Chasing the Leader
.accept 49260 >>Accept Backup While I Pack Up
step
#completewith next
>>On your way to the Awakened Guardian, open Packaged Relics, free Cursed Raiders, and kill Ancient Protectors
.use 153350 >>|T329590:0|tUse [Repurposed Gilnean Staff] on Cursed Raiders
.complete 49233,1 
.complete 49232,1 
.complete 49229,1 
step
#label AwakenedGuardian
.goto 1172,58.65,56.15,20,0
.goto 1172,59.5,19.5
>>During Hilde's roleplay, go up the spiral ramp and kill the Awakened Guardian
*If you die during Hilde's roleplay, you will have to manually abandon and re-accept the quest
.unitscan Awakened Guardian
.complete 49234,1 
step
#completewith DruidNotAPriest
.loop 10,895,61.93,35.46,73.78,40.18,48.37,48.56,46.20,64.73,55.98,65.13,61.93,35.46
>>On your way back to Hilde Firebreaker, finish opening Packaged Relics, freeing Cursed Raiders, and killing Ancient Protectors
.use 153350 >>|T329590:0|tUse [Repurposed Gilnean Staff] on Cursed Raiders
.complete 49233,1 
.complete 49232,1 
.complete 49229,1 
step
.goto 1171,60.23,40.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hilde Firebreaker
*If you die during Hilde's roleplay, you will have to manually abandon and re-accept the quest
.target Hilde Firebreaker
.complete 49260,1 
.turnin 49260 >>Turn in Backup While I Pack Up
step
.goto 1171,62.8,55.65,10,0
.goto 1171,51.2,70.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Pendi Cranklefuse
.target Pendi Cranklefuse
.turnin 49232 >>Turn in Salvaging a Disaster
step
#label DruidNotAPriest
.goto 1171,50.3,70.2
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Birch Tomlin
.target Birch Tomlin
.turnin 49233 >>Turn in I'm a Druid, Not a Priest
step
.goto 1171,62.8,55.65,10,0
.goto 1171,58.7,37.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hilde Firebreaker
*If you die during this quest, you will have to manually abandon and re-accept it
.target Hilde Firebreaker
.complete 49260,1 
.turnin 49260 >>Turn in Backup While I Pack Up
step
.goto 1171,42.93,66.34,10,0
.goto 1171,41.85,80.27,10,0
.goto 895,62.83,29.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Recruit Brutis
.target Recruit Brutis
.turnin 49234,1 >>Turn in A Marine Out of Water
step
.goto 895,62.72,29.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Drogrin Alewhisker
.target Drogrin Alewhisker
.turnin 49229 >>Turn in The Ruins Fought Back
step
.goto 895,55.45,24.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Abbey Watkins
.target Abbey Watkins
.turnin 48070 >>Turn in The Norwington Festival
.accept 48077 >>Accept The Stoat Hunt
step
.goto 895,55.52,24.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Harold Beckett
.target Harold Beckett
.accept 48080 >>Accept An Element of Danger
.accept 48616 >>Accept Bolas and Birds
step
#completewith Chartusk
>>On your way to Caleb Batharen, kill and loot Mudbrush Boars. Click Stoat Dens, then kill and loot stoats
*You can finish this later
.unitscan Hollowbeak Falcon
.use 152643 >>|T135553:0|tUse the [Bola Launcher] on Hollowbeak Falcons
.complete 48616,1 
.complete 48077,1 
.complete 48080,1 
step
.goto 895,58.29,25.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Caleb Batharen
.target Caleb Batharen
.accept 48965 >>Accept Settle the Score
step
#label Chartusk
.goto 895,60.95,21.88,15,0
.goto 895,61.79,22.96
>>Go into the cave and kill Chartusk
.complete 48965,1 
step
#completewith next
>>On your way to Caleb Batharen, kill and loot Mudbrush Boars. Click Stoat Dens, then kill and loot stoats
*You can finish this later
.unitscan Hollowbeak Falcon
.use 152643 >>|T135553:0|tUse the [Bola Launcher] on Hollowbeak Falcons
.complete 48616,1 
.complete 48077,1 
.complete 48080,1 
step
.goto 895,58.29,25.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Caleb Batharen's corpse
.turnin 48965 >>Turn in Settle the Score
step
.loop 20,895,55.69,24.85,56.39,26.22,57.61,26.32,58.15,25.28,57.56,23.71,55.69,24.85
>>On your way to Abbey Watkins and Harold Beckett, finish killing and looting Mudbrush Boars. Click Stoat Dens, then kill and loot stoats
.unitscan Hollowbeak Falcon
.use 152643 >>|T135553:0|tUse the [Bola Launcher] on Hollowbeak Falcons
.complete 48616,1 
.complete 48077,1 
.complete 48080,1 
step
.goto 895,55.52,24.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Harold Beckett
.target Harold Beckett
.turnin 48616 >>Turn in Bolas and Birds
.turnin 48080 >>Turn in An Element of Danger
step
.goto 895,55.45,24.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Abbey Watkins
.target Abbey Watkins
.turnin 48077,1 >>Turn in The Stoat Hunt
step
.goto 895,55.59,24.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Melissa Kenny
.target Melissa Kenny
.accept 48670 >>Accept Runaway Rider
step
.goto 895,54.47,19.39
*Follow Melissa Kenny
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Melissa Kenny
.target Melissa Kenny
.turnin 48670 >>Turn in Runaway Rider
.accept 48196 >>Accept Following Eddie's Trail
.accept 48195 >>Accept Troublesome Troglodytes
step
#completewith StoneSoup
>>As you complete other objectives, kill Grimestone Bullies and Throwers
.complete 48195,1 
.complete 48195,2 
step
.goto 895,56.09, 17.95
>>Click Hotshot's corpse
.complete 48196,1 
step
.goto 895,56.2,18.0
>>Click the Recipe Rock
.accept 48778 >>Accept Stone Soup
step
#completewith Saurolisk
>>As you complete other objectives, click Soup Stones. Kill and loot Grimestone Chefs
.complete 48778,1 
.complete 48778,2 
.isOnQuest 48778
step
.goto 895,55.95,17.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Trapped Saurolisk
.target Trapped Saurolisk
.accept 48597 >>Accept Saurolisk Escape
step
#completewith Saurolisk
.goto 895,56.2,18.0
>>Click the Recipe Rock
.accept 48778 >>Accept Stone Soup
step
#completewith StoneSoup
>>As you complete other objectives, free Trapped Saurolisk by clicking the posts near them
.target Trapped Saurolisk
.complete 48597,1 
step
.goto 895,56.22,16.14
.goto 895,56.22,16.14
>>Click the Bag of Horse Treats
.complete 48196,2 
step
.goto 895,55.88,14.45
>>Kill and loot Boneface the Giant
.unitscan Boneface the Giant
.complete 48196,3 
step
.goto 895,55.61,14.57
>>Click Eddie Norwington's cage near Boneface
.target Eddie Norwington
.complete 48196,4 
.turnin 48196 >>Turn in Following Eddie's Trail
step
>>Kill and loot Grimestone Handlers
.unitscan Grimestone Handler
.goto 895,58.07,14.57
.complete 48778,3 
step
>>Click the Stirring Bone
.goto 895,58.07,14.57
.complete 48778,4 
step
.loop 15,895,56.53,15.44,55.22,16.65,55.52,17.14,56.03,18.86,56.41,17.81,56.49,16.69,56.53,15.44
>>Finish killing Grimestone Bullies and Throwers. Click Soup Stones and loot Grimestone Chefs
.complete 48195,1 
.complete 48195,2 
.complete 48778,1 
.complete 48778,2 
step
#label StoneSoup
>>Click the Bubbling Cauldron
.goto 895,56.56,15.55
.turnin 48778 >>Turn in Stone Soup
step
.loop 15,895,56.53,15.44,55.22,16.65,55.52,17.14,56.03,18.86,56.41,17.81,56.49,16.69,56.53,15.44
>>On your way to Melissa Kenny, finish killing Grimestone Bullies and Throwers. Free Trapped Saurolisk by clicking the posts near them
.target Trapped Saurolisk
.complete 48195,1 
.complete 48195,2 
.complete 48597,1 
step
#requires Area1001
.goto 895,54.47,19.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Melissa Kenny
.target Melissa Kenny
.turnin 48195 >>Turn in Troublesome Troglodytes
.turnin 48597 >>Turn in Saurolisk Escape
.accept 48003 >>Accept The Lord's Behest
step
.goto 895,51.57,27.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Aldrius Norwington
.target Lord Aldrius Norwington
.turnin 48003 >>Turn in The Lord's Behest
.accept 48005 >>Accept Be Our Guest
step
.goto 895,51.45,26.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dolan Northfield
.target Dolan Northfield
.complete 48005,1 
step
.goto 895,51.31,25.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Joma
.target Joma
.accept 48898 >>Accept Lucky Charm
.accept 48902 >>Accept Monstrous Energy
step
.goto 895,51.29,25.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Majo
.target Joma
.accept 48899 >>Accept Safety First
step
.goto 895,49.74,25.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Arthur Seville
.target Arthur Seville
.complete 48005,2 
step
#completewith next
.goto 895,49.74,25.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Arthur Seville
.target Arthur Seville
.vendor 126600 >> Empty bags/restock on food and water at Arthur Seville if necessary
step
.goto 895,48.7,28.1
>>Stand on the arrow to make her spawn. Damage her to 60%
.unitscan Lucktail
.complete 48898,1 
step
.goto 895,48.12,25.43
>>Lucktail damaged to 30%
.unitscan Lucktail
.complete 48898,2 
step
#completewith LucktailWaterfall
.goto 895,50.68,22.20,0
>>On your way to Lucktail, kill and loot Venomscale Slitherers
*You can finish this later
.complete 48902,1 
step
#completewith LucktailWaterfall
.goto 895,50.68,22.20,0
>>On your way to Lucktail, click Durable Seashells
*You can finish this later
.complete 48899,1 
step
#label LucktailWaterfall
.line 895,48.48,23.27,49.46,22.38,50.68,22.20
.goto 895,48.48,23.27,20,0
.goto 895,49.46,22.38,20,0
.goto 895,50.68,22.20
>>Kill and loot Lucktail
.unitscan Lucktail
.complete 48898,3 
step
#completewith next
>>Finish killing and looting Venomscale Slitherer
.complete 48902,1 
step
.loop 20,895,50.68,22.20,49.77,22.97,48.28,24.42,48.14,22.84,49.67,22.06,50.68,22.20
>>Finish clicking Durable Seashells
.complete 48899,1 
step
.loop 20,895,50.68,22.20,49.77,22.97,48.28,24.42,48.14,22.84,49.67,22.06,50.68,22.20
>>Finish killing and looting Venomscale Slitherers
.complete 48902,1 
step
#requires Area96
.goto 895,51.28,25.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Majo
.target Majo
.turnin 48899 >>Turn in Safety First
step
.goto 895,51.32,25.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Joma
.target Joma
.turnin 48898 >>Turn in Lucky Charm
.turnin 48902 >>Turn in Monstrous Energy
step
.goto 895,51.28,25.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Majo
.target Majo
.accept 48903 >>Accept The Perfect Horse, of Course
step
.goto 895,51.68,25.67
>>Wait for Majo to arrive at the stables
.target Majo
.complete 48903,1 
step
.goto 895,51.68,25.67
>>Click Goldie
.target Goldie
.complete 48903,2 
step
.goto 895,51.79,25.83
>>Click Scout
.target Scout
.complete 48903,3 
step
.goto 895,51.87,25.98
>>Click Avalon
.target Avalon
.complete 48903,4 
step
.goto 895,51.83,26.31
>>Click Maxwell
.target Maxwell
.complete 48903,5 
step
.goto 895,51.81,26.14
>>Click Majo
.target Majo
.complete 48903,6 
step
.goto 895,51.81,26.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Joma
.target Joma
.turnin 48903,1 >>Turn in The Perfect Horse, of Course
step
>>Click the Wanted Posters
.goto 895,53.1,28.4
.accept 48347 >>Accept Anglepoint Wharf
.accept 51367 >>Accept WANTED: Raging Earthguard
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Terry Rigglesmith
.target Terry Rigglesmith
.goto 895,53.31,28.29
.complete 48005,4 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to George Mitchell
*The smithy is behind the inn; empty bags/repair gear if necessary
.target George Mitchell
.goto 895,53.48,28.75
.complete 48005,3 
step
.goto 895,51.57,27.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Aldrius Norwington
.target Lord Aldrius Norwington
.turnin 48005 >>Turn in Be Our Guest
.accept 48004 >>Accept Beginner Equitation
step
.goto 895,51.65,26.21
>>Click Cooper
.target Cooper
.complete 48004,1 
step
.goto 895,51.28,26.59,-1
.goto 895,50.91,26.51,-1
.goto 895,50.64,27.24,-1
.goto 895,51.00,27.36,-1
.goto 895,50.95,26.94,-1
>>Enter the grounds, then spam Harpoon Jab near barrels
.complete 48004,2 
step
.goto 895,51.28,26.59,-1
.goto 895,50.91,26.51,-1
.goto 895,50.64,27.24,-1
.goto 895,51.00,27.36,-1
.goto 895,50.95,26.94,-1
>>Target Paper Zeppelins, then use your Bolas
.target Paper Zeppelin
.complete 48004,3 
step
.goto 895,51.28,26.59,-1
.goto 895,50.91,26.51,-1
.goto 895,50.64,27.24,-1
.goto 895,51.00,27.36,-1
.goto 895,50.95,26.94,-1
>>Use Rapid Dash for a speed boost
*You only have to jump near/along the fences, not necessarily OVER the fences
.complete 48004,4 
step
.goto 895,51.57,27.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Aldrius Norwington
.target Lord Aldrius Norwington
.turnin 48004 >>Turn in Beginner Equitation
.accept 48087 >>Accept Equine Retrieval
step
.goto 895,53.16,30.71,20,0
.goto 895,52.57,28.72
>>On your way to Rose, use your horse's Rapid Dash ability.
.target Rose
.complete 48087,1 
step
.goto 895,52.54,28.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Aldrius Norwington
.target Lord Aldrius Norwington
.complete 48087,2 
step
.goto 895,52.54,28.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Aldrius Norwington
.target Lord Aldrius Norwington
.turnin 48087 >>Turn in Equine Retrieval
.accept 48088 >>Accept No Party Like a Trogg Party
step
.goto 895,52.48,28.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gora Layton
.target Gora Layton
.accept 48089 >>Accept Mountain Sounds
step
.goto 895,51.64,26.35,10,0
.loop 15,895,52.49,28.55,52.32,27.96,52.07,27.13,51.33,26.40,51.24,25.99,50.36,26.07,49.78,25.29,50.04,27.03,51.08,28.51,51.27,29.37,52.49,28.55
>>Mount Cooper. While refreshing Rapid Dash (1), kill Troggs by spamming Harpoon Jab (2).
.use 153357 >>|T135553:0|tRally Kul Tirans with [Battlehorn of the Mountain]
.unitscan Grimestone Invader
.unitscan Grimestone Raider
.complete 48089,1 
.complete 48088,1 
step
.goto 895,52.49,28.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Gora Layton
.target Gora Layton
.turnin 48089 >>Turn in Mountain Sounds
step
.goto 895,52.54,28.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Aldrius Norwington
.target Lord Aldrius Norwington
.turnin 48088,2 >>Turn in No Party Like a Trogg Party
step
.goto 895,51.67,29.66
>>Click the Job Flyer
.accept 49393 >>Accept The Roughnecks
step
.goto 895,49.56,30.20,15,0
.goto 895,49.46,31.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Thomas Pinker
.target Thomas Pinker
.accept 50026 >>Accept Save Our Shipmates
step
.goto 895,50.31,37.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Henry Hardwick
.target Henry Hardwick
.turnin 50026 >>Turn in Save Our Shipmates
.accept 50009 >>Accept Shipwreck Recovery Crew
.accept 47755 >>Accept Captured and Enraptured
.accept 50002 >>Accept A Very Precious Cargo
step
#completewith Joe
.use 151135 >>|T133700:0|tUse [Stein of Grog] on Enthralled Sailors
*You can finish this later
.unitscan Enthralled Sailor
.complete 47755,1 
step
#label Joe
.goto 895,51.11,35.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Earless Joe
.accept 50059 >>Accept Can't Hear A Thing
step
#completewith Anthemusa
.use 151135 >>|T133700:0|tOn your way to Anthemusa's cave, use [Stein of Grog] on Enthralled Sailors
*You can finish this later
.unitscan Enthralled Sailor
.complete 47755,1 
step
#label Anthemusa
>>Head east to Anthemusa's cave, then kill her
*She can be CC'd; her minions give up at half-health
.unitscan Anthemusa
.line 895,51.11,35.80,52.07,35.62,52.81,34.62,53.89,33.72,53.64,32.66
.goto 895,53.7,32.8,15,0
.goto 895,52.07,35.62,15,0
.goto 895,52.81,34.62,15,0
.goto 895,53.89,33.72,15,0
.goto 895,53.64,32.66
.complete 50059,1 
.use 151135
step
#completewith PreciousCargo
.use 151135 >>|T133700:0|tOn your way to Penny, use [Stein of Grog] on Enthralled Sailors
*You can finish this later
.unitscan Enthralled Sailor
.complete 47755,1 
step
#label PreciousCargo
.line 895,53.64,32.66,53.89,33.72,55.49,35.93
.goto 895,53.64,32.66,15,0
.goto 895,53.89,33.72,15,0
.goto 895,55.49,35.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Penny "Precious" Hardwick
.target Penny "Precious" Hardwick
.turnin 50002 >>Turn in A Very Precious Cargo
step
#completewith JoeJoe
.use 151135 >>|T133700:0|tOn your way to Earless Joe, finish freeing Enthralled Sailors with [Stein of Grog]
.unitscan Enthralled Sailor
.complete 47755,1 
step
#label JoeJoe
.line 895,55.49,35.94,53.87,35.19,51.59,35.02,51.11,35.8
.goto 895,53.87,35.19,15,0
.goto 895,51.59,35.02,15,0
.goto 895,51.11,35.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Earless Joe
.turnin 50059 >>Turn in Can't Hear A Thing
step
#completewith next
.use 151135 >>|T133700:0|tFinish freeing Enthralled Sailors with [Stein of Grog]
.unitscan Enthralled Sailor
.complete 47755,1 
step
.loop 15,895,54.77,34.77,53.87,35.19,52.79,35.29,51.49,36.72,51.11,35.8,51.59,35.02,53.95,33.82,54.77,34.77
>>Finish killing Alluring Sirens and Lichenjaw Saurolisks. Click Shipwrecked Supplies and Siren Wind Chimes
.complete 50009,1 
step
.loop 15,895,55.49,35.94,53.87,35.19,52.79,35.29,51.49,36.72,51.11,35.8,51.59,35.02,53.95,33.82,55.49,35.94
.use 151135 >>|T133700:0|tFinish freeing Enthralled Sailors with [Stein of Grog]
.unitscan Enthralled Sailor
.complete 47755,1 
step
.goto 895,50.31,37.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Henry Hardwick
.target Henry Hardwick
.turnin 47755 >>Turn in Captured and Enraptured
step
>>Kill the Raging Earthguard. Skip this if it is too difficult
.unitscan Raging Earthguard
.goto 895,49.81,34.43,20,0
.goto 895,47.26,32.37
.complete 51367,1 
step
.goto 895,51.57,27.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Aldrius Norwington
.target Lord Aldrius Norwington
.turnin 51367 >>Turn in WANTED: Raging Earthguard
.accept 48939 >>Accept Show Me What You've Got
.accept 49036 >>Accept Best In Show
step
>>Mount Cooper
.goto 895,51.64,26.2
.complete 49036,1 
step
>>Focus on jumping fences to stack and refresh your score bonus buff (5 second duration). Try to maintain at least 15 stacks. Jab Gnolls and Bola Zepplins
*A timer starts as soon as you cross into the arena. If you're having a hard time getting 300 points, just go for 150 and abandon Best in Show
.goto 895,51.28,26.59,-1
.goto 895,50.91,26.51,-1
.goto 895,50.64,27.24,-1
.goto 895,51.00,27.36,-1
.goto 895,50.95,26.94,-1
.complete 49036,2
.complete 48939,2
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Aldruis Norwington
.goto 895,51.57,27.28
.turnin 49036 >>Turn in Best In Show
.turnin 48939 >>Turn Show Me What You've Got
step
#completewith HelloTagart
.abandon 49036 >>Abandon Best In Show
.isOnQuest 49036
step
#completewith HelloTagart
.abandon 48939 >>Abandon Show Me What You've Got
.isOnQuest 48939
step
#completewith next





.goto 895,42.48,23.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Dagin
.fp >>Get the Roughneck Camp Flight Path
step
.goto 895,42.16,22.99
>>Click the Wanted Poster
.accept 51368 >>Accept WANTED: The Hornet
step
#label HelloTagart
.goto 895,42.36,22.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tagart
.turnin 49393 >>Turn in The Roughnecks
.accept 49395 >>Accept The Bears and the Bees
.accept 49394 >>Accept Hold Still
step
#completewith HelpingHenry
.use 153596 >>|T135649:0|tOn your way to The Hornet, use "Goat Shears" on Gentle Goats.
*Goats may become hostile. You can finish this later
.target Gentle Goat
.complete 49394,1 
step
#completewith HelpingHenry
>>On your way to The Hornet, kill Scruffhide Bears and click Sticky Bee Honey
*You can finish this later
.complete 49395,1 
.complete 49395,2 
step
>>Enter the cave and kill The Hornet
*This quest can be very difficult; feel free to skip it
.goto 895,47.06,18.21,10,0
.line 895,42.36,22.26,43.49,22.04,45.45,20.52,46.61,19.32,47.48,18.18,47.06,18.21
.goto 895,43.49,22.04,15,0
.goto 895,45.45,20.52,15,0
.goto 895,46.61,19.32,15,0
.goto 895,47.48,18.18,15,0
.unitscan The Hornet
.complete 51368,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to "Helpless" Henry
.target "Helpless" Henry
.goto 895,47.7,17.63
.accept 49412 >>Accept Helping Henry
step
.goto 895,48.18,18.11
>>Kill Brawr
*Brawr continuously spawns adds and does an aoe; if you are melee, be careful that the adds do not daze you
.unitscan Brawr
.complete -49412,1 
step
#label HelpingHenry
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to "Helpless" Henry
.goto 895,47.68,17.68
.target "Helpless" Henry
.turnin -49412 >>Turn in Helping Henry
step
#completewith next
>>On your way back to the Roughneck Camp, finish killing Scruffhide Bears and collecting Sticky Bee Honey
.goto 895,47.1,18.7
.complete 49395,1 
.complete 49395,2 
step
.loop 20,895,48.58,17.81,48.26,19.01,46.60,20.33,46.12,22.44,45.66,19.76,47.75,17.68,48.58,17.81
.use 153596 >>|T135649:0|tOn your way back to the Roughneck Camp, finish using "Goat Shears" on Gentle Goats.
*Goats may become hostile
.target Gentle Goat
.complete 49394,1 
step
.loop 20,895,47.75,17.68,48.58,17.81,48.26,19.01,46.60,20.33,46.12,22.44,45.66,19.76,47.75,17.68
>>On your way back to the Roughneck Camp, finish killing Scruffhide Bears and collecting Sticky Bee Honey
.goto 895,47.1,18.7
.complete 49395,1 
.complete 49395,2 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jagart
.goto 895,42.36,22.27
.turnin 49394 >>Turn in Hold Still
.turnin 51368 >>Turn in WANTED: The Hornet
.turnin 49395 >>Turn in The Bears and the Bees
.isQuestComplete 51368
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jagart
.goto 895,42.36,22.27
.turnin 49394 >>Turn in Hold Still
.turnin 49395 >>Turn in The Bears and the Bees
step
#completewith HelloAgainTagart
.abandon 51368 >>Abandon WANTED: The Hornet
.isOnQuest 51368
step
.goto 895,42.49,22.71
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rulf
.target Rulf
.accept 49735 >>Accept Protect the Nests
.accept 49710 >>Accept An Offering of Eggs
step
.loop 15,895,44.19,19.63,43.74,17.38,45.92,17.45,46.03,18.37,44.55,18.03,44.52,20.21,44.19,19.63
>>Click Spotted Gryphon Eggs and kill Hungry Dewscales
.complete 49735,1 
.complete 49710,1 
step
.goto 895,47.94,16.47
>>Click the Gryphon Nest
.turnin 49710 >>Turn in An Offering of Eggs
step
.goto 895,47.85,16.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Shawn McClinter
.target Shawn McClinter
.turnin 49735 >>Turn in Protect the Nests
.accept 49417 >>Accept Roughneck Riders
step
.goto 895,47.85,16.39
.use 153679 >>|T1373906:0|tUse "Tether Shot" on Greatfeather
>>Use Hard Kick (2) and Renew Stamina (3) on cooldown. Spam Kick Gryphon (1)
.target Greatfeather
.complete 49417,1 
step
#label HelloAgainTagart
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tagart
.goto 895,42.36,22.27
.turnin 49417,1 >>Turn in Roughneck Riders
.accept 49418 >>Accept Big Boss
step


.goto 895,41.99,16.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Boss Tak
.target Boss Tak
.turnin 49418 >>Turn in Big Boss
.accept 49433 >>Accept Wendies
.accept 49435 >>Accept Where'd They Go?
step
.goto 895,42.27,15.49
>>Click the Bloodied Boot
.complete 49435,1 
step
#completewith next
>>On your way to "Helpless" Henry, kill Glacial and Savage Wendigos
*You can complete this later
.complete 49433,1 
step
.goto 895,43.68,15.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to "Helpless" Henry
.target "Helpless" Henry
.accept 49419 >>Accept Frozen
step
.goto 895,43.73,14.66
>>Click the Roughneck Supplies by the Supply Cart
.complete 49435,2 
step
.goto 895,44.91,15.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Griddon
.target Griddon
.accept 49431 >>Accept Warm and Cozy
step
#completewith next
>>On your way to Prince Rathaw, kill and loot Steam Elementals. Click Steam Shards
*You can finish this after killing Prince Rathaw
.complete 49431,1 
step
.goto 895,46.99,14.08,30,0
.goto 895,48.67,14.62
>>Kill and loot Prince Rathaw
.unitscan Prince Rathaw
.complete 49419,1 
step
.goto 895,48.33,13.20,20,0
.goto 895,44.91,15.50
>>On your way back to Griddon, kill and loot Steam Elementals. Click Steam Shards
.complete 49431,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Griddon
.target Griddon
.goto 895,44.91,15.5
.turnin 49431,1 >>Turn in Warm and Cozy
step
.goto 895,43.68,15.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to "Helpless" Harry
.target "Helpless" Harry
.turnin 49419 >>Turn in Frozen
step
#completewith Rucksack
>>As you do other objectives, kill Glacial and Savage Wendigos
*You can finish this later
.complete 49433,1 
step
>>Click the Roughneck Axe
.goto 895,42.94,13.73,30,0
.goto 895,41.33,13.61,20,0
.goto 895,41.58,13.99
.complete 49435,3 
step
#label Rucksack
>>Click the Discarded Rucksack
.goto 895,39.68,13.35
.complete 49435,4 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Boss Tak
.target Boss Tak
.turnin 49435 >>Turn in Where'd They Go?
.accept 49439 >>Accept Boss' Revenge
step
>>Kill Whompus in the Cave
.unitscan Whompus
.goto 895,39.33,12.37
.complete 49439,1 
step
.goto 895,42.05,16.71
>>Start heading back towards Roughneck Camp, but finish killing Glacial and Savage Wendigos before you leave the area
.complete 49433,1 
step
#requires Area3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Boss Tak
.target Boss Tak
.turnin 49433 >>Turn in Wendies
.turnin 49439 >>Turn in Boss' Revenge
.accept 49719 >>Accept Getting Paid
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tagart
.goto 895,42.37,22.26
.turnin 49719 >>Turn in Getting Paid
step
.goto 895,43.74,25.38,20,0
.goto 895,43.71,26.64,20,0
.goto 895,42.28,29.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brother Therold
.target Brother Therold
.turnin 48347 >>Turn in Anglepoint Wharf
.accept 48540 >>Accept Aiding the Wharf
step
.goto 895,43.23,29.67
>>Click the Bundle of Vellum on the barrel
*It is very small!
.complete 48540,2 
step
.goto 895,41.93,30.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hera Copeland
.target Hera Copeland
.complete 48540,1 
.skipgossip
step
.goto 895,41.79,5,0
.goto 895,41.79,30.04
>>Click the Jar of Blubber
.complete 48540,3 
step
.goto 895,42.28,29.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brother Therold
.target Brother Therold
.turnin 48540 >>Turn in Aiding the Wharf
.accept 49268 >>Accept Sharks in the Water
.accept 48352 >>Accept A Cure from the Sea
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Okri Putterwrench
.target Okri Putterwrench
.goto 895,42.19,29.32
.accept 48348 >>Accept Stinging Barbs
step
#completewith next
>>Kill Invading Dreadmaw and click Harbor Seaweed
*Run on the seafloor for faster movement
.complete 49268,1 
.complete 48352,1 
step
.loop 20,895,41.79,28.13,40.24,28.77,39.68,30.43,40.69,31.19,41.19,29.75,41.79,28.13
>>Kill and loot Barbtail Stingrays
.unitscan Barbtail Stingray
.complete 48348,1 
step
.loop 20,895,41.79,28.13,40.24,28.77,39.68,30.43,40.69,31.19,41.19,29.75,41.79,28.13
>>Kill Invading Dreadmaw and click Harbor Seaweed
*Run on the seafloor for faster movement speed
.complete 49268,1 
.complete 48352,1 
step
.goto 895,42.19,29.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Okri Putterwrench
.target Okri Putterwrench
.turnin 48348 >>Turn in Stinging Barbs
step
.goto 895,42.28,29.31
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brother Therold
.target Brother Therold
.turnin 48352,1 >>Turn in A Cure from the Sea
.turnin 49268 >>Turn in Sharks in the Water
.accept 49292 >>Accept Algae Shakes
.accept 48353 >>Accept Pulse of the Wharf
step
#completewith next
.use 153513 >>|T461805:0|tOn your way to Julian Nichols, use "Cleansing Tonic" on Nauseated Villagers
.complete 49292,1,2 
step
.goto 895,42.79,28.67,20,0
.goto 895,42.61,27.41,4,0
.goto 895,42.68,26.85,4,0
.goto 895,42.30,26.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Julian Nichols
.target Julian Nichols
.complete 48353,1 
.skipgossip
step
#completewith next
>>On your way to Ginger Freelin, click the WANTED: Quartermaster Ssylis Poster
.accept 51384 >>Accept WANTED: Quartermaster Ssylis
step
.goto 895,42.24,27.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ginger Freelin
.target Ginger Freelin
.complete 48353,2 
.skipgossip
step
.goto 895,42.28,27.22
>>Click the WANTED: Quartermaster Ssylis Poster
.accept 51384 >>Accept WANTED: Quartermaster Ssylis
step
#completewith next
.use 153513 >>|T461805:0|tOn your way to Aaron Gutier, use "Cleansing Tonic" on Nauseated Villagers
.complete 49292,1 
step
.goto 895,42.09,27.22,4,0
.goto 895,41.89,27.30,4,0
.goto 895,41.92,26.81,4,0
.goto 895,41.87,26.66,4,0
.goto 895,41.68,26.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Aaron Gutier
.target Aaron Gutier
.complete 48353,3 
.skipgossip
step
.goto 895,41.05,27.16,4,0
.goto 895,41.53,26.50,4,0
.goto 895,41.29,27.00
.use 153513 >>|T461805:0|tFinish using "Cleansing Tonic" on nearby Nauseated Villagers
.target Brother Therold
.complete 49292,1 
step
#requires Area4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brother Therold
.goto 895,41.29,27.00
.turnin 49292 >>Turn in Algae Shakes
.turnin 48353 >>Turn in Pulse of the Wharf
.accept 48355 >>Accept Evacuate the Premises
.accept 48354 >>Accept Tainted Shipments
step
#completewith next
>>On your way to Barrels of Fish, use your Extra Ability near Anglepoint Fishpackers
.target Anglepoint Fishpackers
.complete 48355,1 
step
.goto 895,40.95,26.94,4,0
.goto 895,40.73,26.92,4,0
.goto 895,40.43,27.34,4,0
.goto 895,39.94,27.13,4,0
.goto 895,40.01,26.90,4,0
>>Click Barrels of Fish. Kill any enemies that spawn
.complete 48354,1 
step
.goto 895,40.57,26.64,15,0
.goto 895,40.33,27.23,15,0
.goto 895,40.18,26.36
>>Finish using your Extra Ability near Anglepoint Fishpackers
.target Anglepoint Fishpackers
.complete 48355,1 
step
.goto 895,39.49,26.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brother Therold
.target Brother Therold
.turnin 48354 >>Turn in Tainted Shipments
.turnin 48355 >>Turn in Evacuate the Premises
.accept 48356 >>Accept Possessive Headgear
step
.goto 895,39.52,26.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Keegan Alby
.target Keegan Alby
.accept 48365 >>Accept The Young Lord Stormsong
.accept 48009 >>Accept Betrayal of the Guard
step
#completewith next
>>On your way to Manager Yerold, kill Mind-addled Enforcers, Possessed Dockworkers, and Parasitic Mindstealers
*You can finish this later
.complete 48356,1 
.complete 48009,1 
step
.goto 895,38.33,28.23,30,0
.goto 895,37.94,29.58,15,0
.goto 895,37.56,29.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Manager Yerold inside the building
.accept 48008 >>Accept Dangerous Cargo
.accept 49299 >>Accept Enemy Within
step
#completewith BrotherConway
>>As you work on other objectives, click Infested Cargo
*You can finish this later
.complete 48008,1 
step
#completewith BrotherConway
>>On your way to Overseer Bates, kill Mind-addled Enforcers, Possessed Dockworkers, and Parasitic Mindstealers
*You can finish this later
.complete 48356,1 
.complete 48009,1 
step
.goto 895,37.72,29.78,5,0
.goto 895,37.44,29.86,10,0
.goto 895,37.25,28.83
>>Kill Overseer Bates at the top of the stairs
*Sidestep/move away from his Void Swipe
.unitscan Overseer Bates
.complete 49299,1 
step
#label BrotherConway
.goto 895,39.49,31.67
>>Kill Brother Conway
*He has two phases. In his second phase, interrupt his Nether Storm as best you can
.unitscan Brother Conway
.complete 48365,1 
step
#completewith InfectedCargo
>>On your way to Manager Yerold, kill Mind-addled Enforcers, Possessed Dockworkers, and Parasitic Mindstealers
*You can finish this later
.complete 48356,1 
.complete 48009,1 
step
.goto 895,37.57,29.54
>>On your way to Manager Yerold, finish burning Infested Cargo
.complete 48008,1 
step
#label InfectedCargo
.goto 895,37.57,29.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Manager Yerold
.target Manager Yerold
.turnin 49299,1 >>Turn in Enemy Within
.turnin 48008 >>Turn in Dangerous Cargo
step
.goto 895,37.94,29.58,15,0
.goto 895,38.33,28.23,30,0
.goto 895,39.50,26.68
>>On your way back to Brother Therold, finish killing Mind-addled Enforcers, Possessed Dockworkers, and Parasitic Mindstealers
.complete 48356,1 
.complete 48009,1 
step
.goto 895,39.50,26.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brother Therold
.target Brother Therold
.turnin 48356 >>Turn in Possessive Headgear
step
.goto 895,39.52,26.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Keegan Alby
.target Keegan Alby
.turnin 48009 >>Turn in Betrayal of the Guard
.turnin 48365 >>Turn in The Young Lord Stormsong
step
.goto 895,39.54,26.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brannon Stormsong
.target Brannon Stormsong
.accept 48366 >>Accept Paddle to Safety
step
.goto 895,39.60,26.96
>>Click the Escape Rowboat
.complete 48366,1 
step
.goto 895,35.20,24.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brannon Stormsong
.target Brannon Stormsong
.turnin 48366 >>Turn in Paddle to Safety
.accept 49300 >>Accept Creature Corruption
.accept 48372 >>Accept Eldritch Invocations
step
.goto 895,35.25,24.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Keegan Alby
.target Keegan Alby
.accept 48370 >>Accept Death in the Depths
step
.goto 895,35.24,24.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brother Therold
.target Brother Therold
.accept 48368 >>Accept Deep Sea Defilement
step
.goto 895,34.95,24.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rosaline Madison
.target Rosaline Madison
.accept 48367 >>Accept Those Aren't Fish Eggs
step
#completewith KillSsylis
>While moving between caves, prioritize killing corrupted sea creatures near Corrupted Eggs. Destroy the Eggs
.maxlevel 50
.complete 49300,1 
step
#completewith KillSsylis
*Run on the seafloor for faster movement speed
>>While moving between caves, prioritize killing corrupted sea creatures near Corrupted Eggs. Destroy the Eggs
.complete 48367,1 
.complete 48370,1 
step
>>Go into the underwater cave that leads beneath Outrigger Post
.goto 895,33.34,26.90,30,0
.goto 895,34.97,24.65
.complete 48368,2 
step
>>Go into the underwater cave beneath the opposing shore
>>Click the Pylon
.goto 895,31.08,29.7,10,0
.goto 895,30.37,31.11
.complete 48368,1 
step
>>Go into the underwater cave that's next to a sunken shipwreck
*Director Deepwarden is a Humanoid, despite looking like an Aberration
.unitscan Director Deepwarden
.goto 895,29.99,19.40
.complete 48372,1 
.complete 48368,3 
step
#label KillSsylis
>>Swim to the surface, then follow the coastline north until you reach a cave. Quartermaster Ssylis is inside
*If this quest is too difficult, feel free to skip it
.unitscan Quartermaster Ssylis
.goto 895,31.18,21.95,40,0
.goto 895,31.50,19.18,50,0
.goto 895,30.29,17.84
.complete 51384,1 
.isOnQuest 51384
step
#label Corruption1
#sticky
>While moving between caves, prioritize killing corrupted sea creatures near Corrupted Eggs. Destroy the Eggs
.maxlevel 50
.complete 49300,1 
step
.loop 30,895,32.12,22.48,33.59,23.90,32.33,24.65,32.69,27.30,34.31,26.83,33.25,25.73,33.59,23.90
*Run on the seafloor for faster movement speed
>>On your way back to Outrigger Post, finish killing corrupted sea creatures near Corrupted Eggs. Destroy the Eggs
.complete 48367,1 
.complete 48370,1 
step
#requires Corruption1
.goto 895,35.25,24.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Keegan Alby
.target Keegan Alby
.turnin 51384 >>Turn in WANTED: Quartermaster Ssylis
.isQuestComplete 51384
step
#completewith MasterRiding
.abandon 51384 >>Abandon WANTED: Quartermaster Ssylis
.isOnQuest 51384
step
.goto 895,35.23,24.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brother Therold
.target Brother Therold
.turnin 48368 >>Turn in Deep Sea Defilement
step
.goto 895,35.2,24.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brannon Stormsong
.target Brannon Stormsong
.turnin 48370 >>Turn in Death in the Depths
.turnin 48372 >>Turn in Eldritch Invocations
step
.goto 895,34.95,24.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rosaline Madison
.target Rosaline Madison
.turnin 48367 >>Turn in Those Aren't Fish Eggs
.accept 49302 >>Accept The Deadliest Catch
step
#completeswith next
.skill riding,300 >>Mail 5,000 gold from an alt and train Master Riding after hearthing to Stormwind
.money >5000.00
step
.hs >> Hearthstone to Stormwind
.zoneskip 84
step
#label MasterRiding
.goto 84,70.22,73.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Bralla Cloudwing and train Master Riding
.target Bralla Cloudwing
.money <4900.00
.skill riding,300 >> Learn Master Riding
step
#veteran
.goto 84,63.76,73.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk Renato Gallina
.accept 332 >>Accept Wine Shop Advert
step
#veteran
.goto 84,62.32,67.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk Harlan Bagley
.accept 333 >>Accept Harlan Needs a Resupply
step
#veteran
.goto 84,58.09,67.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk Rema Schneider
.turnin 333 >>Turn in Harlan Needs a Resupply
.accept 334 >>Accept Package for Thurman
step
#veteran
.goto 84,60.28,76.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk Suzetta Gallina
.turnin 332 >>Turn in Wine Shop Advert
step
#veteran
.goto 84,52.59,83.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk Thurman Schneider
.turnin 334 >>Turn in Package for Thurman
]])
RXPGuides.RegisterGuide([[
#df
#version 1
#group RestedXP Alliance 10-60
#name 8A_Tiragarde Sound Part 2
#displayname Chapter 8 - Tiragarde Sound Part 2
#next 9A_Drustvar
<<Alliance
step
.goto 84,48.92,87.86,20,0
.goto 84,48.71,95.12
+Enter the Wizard's Sanctum, follow the spiral ramp up through the portal, and click on the Portal to Boralus
.zoneskip 1161
step
.goto 1161,68.76,21.09,10,0
.goto 1161,67.43,21.39,10,0
.goto 1161,68.16,21.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.turnin 46729 >>Turn in The Old Knight
.accept 47186 >>Accept Sanctum of the Sages
step
.goto 1161,67.99,21.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Cyrus Crestfall
.target Cyrus Crestfall
.accept 52128 >>Accept Ferry Pass
.turnin 52128 >>Turn in Ferry Pass
step
.goto 1161,68.59,21.02,10,0
.goto 1161,67.49,21.14,10,0
.goto 1161,68.86,21.16,10,0
.goto 1161,70.74,16.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the 7th Legion Magus
.complete 47186,1 
.skipgossip
step
.goto 1161,68.76,21.09,10,0
.goto 1161,67.43,21.39,10,0
.goto 1161,68.16,21.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.turnin 47186 >>Turn in Sanctum of the Sages
.accept 47189 >>Accept A Nation Divided
step
.goto 1161,68.38,22.10
>>Click the Scouting Map, then click Tiragarde Sound and accept the quest
.complete 47189,1 
.accept 47960 >>Accept Tiragarde Sound
step
.goto 1161,68.17,22.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.turnin 47960 >>Turn in Tiragarde Sound
.turnin 47189 >>Turn in A Nation Divided
step
.goto 1161,68.04,22.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Genn Greymane
.target Genn Greymane
.accept 52654 >>Accept The War Campaign
step
.goto 1161,67.58,22.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind
.target Flynn Fairwind
.accept 47181 >>Accept The Smoking Gun
step
.goto 1161,67.56,22.25
>>Press your Extra Action Button
.complete 47181,1 
step
.goto 1161,67.56,22.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind
.target Flynn Fairwind
.turnin 47181 >>Turn in The Smoking Gun

step
.goto 1161,67.99,21.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Cyrus Crestfall
.target Cyrus Crestfall
.accept 47485 >>Accept The Ashvane Trading Company
step
.goto 1161,67.09,23.4,10,0
.goto 1161,69.26,26.98
>>Board the Alliance frigate
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Halford Wyrmbane
.target Halford Wyrmbane
.turnin 52654 >>Turn in The War Campaign
.accept 52544 >>Accept The War Cache
.accept 51569 >>Accept The Zandalar Campaign
step
>>Click the Zandalar Campaign table, then click Zuldazar and accept the quest
>>Click the Quest Complete pop-up in your Quest Tracker
.goto 1161,69.26,26.98
.accept 51570 >>Accept Foothold: Zuldazar
.turnin 51570 >>Turn in Foothold: Zuldazar
step
>>Select Zuldazar on the Map
.goto 1161,69.26,26.98
.complete 51569,1 
step
.goto 1161,69.26,26.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Halford Wyrmbane
.target Halford Wyrmbane
.turnin 51569 >>Turn in The Zandalar Campaign
.accept 51308 >>Accept Zuldazar Foothold
step
.goto 1161,69.26,26.99
>>Wait for the roleplay
.complete 51308,1 
.skipgossip 1

step
#completewith next
.goto 1161,74.13,12.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Wesley Rockhold
.target Wesley Rockhold
.home >>Set your Hearthstone to Boralus
step << !KulTiran
.goto 1161,77.18,16.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Crenzo Sparkshatter
.target Crenzo Sparkshatter
.accept 52462 >>Accept A Load of Scrap
step << !KulTiran
.goto 1161,77.18,16.46
>>Click the Scrap-O-Matic 1000.
>>|T1698808:0|tInsert the Tattered Pants and press scrap
.complete 52462,1 
step << !KulTiran
.goto 1161,77.18,16.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Crenzo Sparkshatter
.turnin 52462 >>Turn in A Load of Scrap






step
.noflyable 1161
.goto 1161,74.17,24.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Will Melborne and use the ferry
.target Will Melborne
.complete 47485,1 

step
.goto 895,80.63,42.07
>>Fly to Hawkmaster Lloyd
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hawkmaster Lloyd. If he is not here complete the World Quest or skip this step.
.target Hawkmaster Lloyd
.accept 51226 >>Accept Death from Two Sides
step
.goto 895,81.10,42.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tallis Skyheart inside the tent
.target Tallis Skyheart
.accept 49733 >>Accept Patching Up the Rear
step
#completewith next
.isOnQuest 51226
>>On your way to Injured Marines, kill Brinefang Saurolisks
.complete 51226,1 
step
.isOnQuest 49733
.loop 5,895,80.81,41.49,81.16,41.18,81.86,40.52,82.35,43.89,80.81,41.49
>>Click Injured Marines
.target Injured Marine
.complete 49733,1 
step
.isOnQuest 51226
.loop 3,895,80.81,41.49,81.16,41.18,81.86,40.52,82.35,43.89,80.81,41.49
>>On your way back to Hawkmaster Lloyd, finish killing Brinefang Saurolisks
.unitscan Brinefang Saurolisk
.complete 51226,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hawkmaster Lloyd
.target Hawkmaster Lloyd
.goto 895,80.62,42.03
.turnin 51226 >>Turn in Death from Two Sides
.accept 49720 >>Accept Free Bird
step
.goto 895,81.09,42.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tallis Skyheart
.target Tallis Skyheart
.turnin 49733 >>Turn in Patching Up the Rear
.accept 49716 >>Accept A Lesson on Trust
.accept 49734 >>Accept Targeting a Turncoat
step
.goto 895,81.11,42.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Officer Jovan
.target Officer Jovan
.accept 50249 >>Accept A Boralus Triple Threat
step 
.goto 895,79.95,38.75
>>Kill Fernn the Turncoat
*Use your Extra Action Button on cooldown
.unitscan Fernn the Turncoat
.complete 49734,1 
step
#completewith OverseerHowling
>>As you complete other objectives, click Hawk Cages and kill/loot Hardened Mutineers, Mutinous Falconers and Mutinous Halberdiers
*Use your Extra Action Button on cooldown. You can finish this later
.complete 49720,1 
.complete 49716,1 
step
.goto 895,80.17,37.13
>>Kill Stablemaster Diana
.unitscan Stablemaster Diana
*Face her away from mobs, and sidestep her Trampling Charge. Use your Extra Action Button on cooldown
.complete 50249,2 
step
.goto 895,78.08,36.74
>>Kill Hayden the Madshot
*Use your Extra Action Button on cooldown
.unitscan Hayden the Madshot
.complete 50249,3 
step
#label Overseer Howling
.goto 895,78.78,38.82
>>Kill Overseer Howling
*Use your Extra Action Button on cooldown
.unitscan Overseer Howling
.complete 50249,1
step
#completewith next
.loop 20,895,80.12,37.92,80.22,36.99,79.11,37.69,79.42,39.08,80.12,37.92
>>On your way to Hawk Cages, finish killing and looting Hardened Mutineers, Mutinous Falconers and Mutinous Halberdiers
*Use your Extra Action Button on cooldown
.complete 49716,1 
step
.loop 20,895,80.12,37.92,80.22,36.99,79.11,37.69,79.42,39.08,80.12,37.92
>>On your way out of Greystone Keep, finish clicking Hawk Cages
*Use your Extra Action Button on cooldown
.complete 49720,1 
step
.loop 20,895,80.12,37.92,80.22,36.99,79.11,37.69,79.42,39.08,80.12,37.92
>>On your way out of Greystone Keep, finish killing and looting Hardened Mutineers, Mutinous Falconers and Mutinous Halberdiers
*Use your Extra Action Button on cooldown
.complete 49716,1 
step
.goto 895,80.62,42.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hawkmaster Lloyd
.target Hawkmaster Lloyd
.turnin 49720 >>Turn in Free Bird
step
.goto 895,81.09,42.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Tallis Skyheart
.target Tallis Skyheart
.turnin 49734,2 >>Turn in Targeting a Turncoat
.turnin 49716 >>Turn in A Lesson on Trust
.turnin 50249 >>Turn in A Boralus Triple Threat
step
.goto 895,76.83,43.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Cagney
.target Cagney
.turnin 47485 >>Turn in The Ashvane Trading Company
.accept 47486 >>Accept Suspicious Shipments
.accept 47487 >>Accept Labor Dispute
step
.goto 895,76.82,43.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Olive
.target Olive
.accept 47488 >>Accept Small Haulers
step
#completewith next
>>As you do other objectives, click Urchin Workers and Marked Goods. Kill Company Enforcers, Fusiliers, and Watchmen
.target Urchin Worker
.complete 47488,1 
.complete 47486,1 
.complete 47487,1 
.skipgossip
step
.line 895,79.01,45.77,80.12,46.90,79.48,48.90,80.53,49.40
.goto 895,79.01,45.77,5,0
.goto 895,80.12,46.90,5,0
.goto 895,79.48,48.90,5,0
.goto 895,80.53,49.40,5,0
>>Click a Posted Notice
*Open your map and zoom in to see a line connecting the Ashvane's Foundry Posted Notices
.accept 50573 >>Accept Message from the Management
step
#completewith TaskmasterWilliams
.line 895,895,79.53,48.32,79.46,49.12,80.41,49.97,80.81,48.96,82.05,48.86,82.08,48.36,79.49,47.02,79.53,48.32 
>>As you do other objectives, click Urchin Workers and Marked Goods. Kill Company Enforcers, Fusiliers, and Watchmen
*Open your map and zoom in to see a line connecting Azerite-Dusted Blade spawn points
.target Urchin Worker
.complete 47488,1 
.complete 47486,1 
.complete 47487,1 
.skipgossip
step
.goto 895,82.14,48.62
>>Kill and loot Forgemaster Farthing
.unitscan Forgemaster Farthing
.complete -50573,1 
step
.goto 895,79.13,46.96
#label TaskmasterWilliams
>>Kill and loot Taskmaster Williams
.unitscan Taskmaster Williams
.complete -50573,2 
step
#completewith next
.goto 895,79.75,47.19
>>As you finish killing Company Guards, click Urchin Workers and Marked Goods
.target Urchin Worker
.complete 47488,1 
.complete 47486,1 
.skipgossip
step
.loop 10,895,79.53,48.32,79.46,49.12,80.41,49.97,80.81,48.96,82.05,48.86,82.08,48.36,79.49,47.02,79.53,48.32 
>>Finish killing Company Enforcers, Fusiliers, and Watchmen
*Open your map and zoom in to see a loop between Azerite-Dusted Blade spawn points
.complete 47487,1 
step
#completewith next
>>Finish clicking Urchin Workers
.complete 47488,1 
.target Urchin Worker
.skipgossip
step
.loop 10,895,79.53,48.32,79.46,49.12,80.41,49.97,80.81,48.96,82.05,48.86,82.08,48.36,79.49,47.02,79.53,48.32 
>>Finish clicking Marked Goods
*Open your map and zoom in to see a loop between Azerite-Dusted Blade spawn points
.complete 47486,1 
.skipgossip
step
.loop 10,895,79.53,48.32,79.46,49.12,80.41,49.97,80.81,48.96,82.05,48.86,82.08,48.36,79.49,47.02,79.53,48.32 
>>Finish clicking Urchin Workers
*Open your map and zoom in to see a loop between Azerite-Dusted Blade spawn points
.complete 47488,1 
.target Urchin Worker
.skipgossip
step
.line 895,79.01,45.77,80.12,46.90,79.48,48.90,80.53,49.40
.goto 895,79.01,45.77,5,0
.goto 895,80.12,46.90,5,0
.goto 895,79.48,48.90,5,0
.goto 895,80.53,49.40,5,0
>>Before leaving the area, click a Posted Notice
*Open your map and zoom in to see a line connecting the Ashvane's Foundry Posted Notices
.accept 50573 >>Accept Message from the Management
.isQuestAvailable 50573
step
.goto 895,82.14,48.62
>>Kill and loot Forgemaster Farthing
.unitscan Forgemaster Farthing
.complete -50573,1 
step
.goto 895,79.13,46.96
>>Kill and loot Taskmaster Williams
*Interrupt his War Cry ability
.unitscan Taskmaster Williams
.complete -50573,2 
step
.goto 895,78.10,47.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Cagney
.turnin 47487 >>Turn in Labor Dispute
step
.goto 895,78.11,47.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind
.target Flynn Fairwind
.turnin 47488 >>Turn in Small Haulers
.turnin 47486 >>Turn in Suspicious Shipments
.turnin 50573,1 >>Turn in Message from the Management
.accept 50531 >>Accept Under Their Noses
step
.goto 895,75.84,49.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind
.target Flynn Fairwind
.turnin 50531 >>Turn in Under Their Noses
.accept 53041 >>Accept Sampling the Goods
step
>>Click and loot the Raw Azerite Sample
.goto 895,74.75,50.13
.complete 53041,2 
step
.goto 895,75.17,50.75
>>Click the Chemist Notes
.skipgossip
.complete 53041,1 
step
.goto 895,75.42,49.81,5,0
#completewith next
.vendor >>Empty bags/repair gear at Jen the Fixer if necessary
.target Jen the Fixer
step
.goto 895,75.55,49.94
>>Click the Help Wanted Poster
.accept 50544 >>Accept The Hunters of Kennings Lodge
step
.goto 895,75.88,50.64,5,0
#completewith next
.vendor >>Empty bags/restock food and water at Lidia Plank if necessary
.target Lidia Plank
step
.goto 895,75.7,50.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Junior Miner Joe
.target Junior Miner Joe
.accept 50349 >>Accept An Overrun Mine
step
.goto 895,78.15,55.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Chief Miner Theock
.target Chief Miner Theock
.turnin 50349 >>Turn in An Overrun Mine
.accept 50351 >>Accept Miner Operation
step
.goto 895,78.12,56.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Head Chemist Walters
.target Head Chemist Walters
.accept 50352 >>Accept Pinch of Azerite
step
#completewith OrdnancePrim
>>As you do other objectives, kill/loot Animated Azerite, Bubbling Azerite, and Azerite Nibblers
.complete 50352,1 
step
.goto 895,76.1,57.43
>>Enter the small house by the river. Loot Walter's Chemistry Kit, next to the wall shelf
.complete 50352,2 
step
.goto 895,76.98,57.78
*Climb the staircases leading up to the platform
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Civil Technician Alena
.target Civil Technician Alena
.complete 50351,1 
.skipgossip
step
#label OrdnancePrim
.goto 895,77.33,59.54,20,0
.goto 895,77.31,60.49
*Climb the slope by the waterfall, or pass through the large house
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ordnance Handler Prim
.target Ordnance Handler Prim
.complete 50351,2 
.skipgossip
step
.loop 30,895,76.65,57.64,75.53,58.52,76.56,59.43,77.17,58.52,76.65,57.64
>>Finish killing/looting Animated Azerite, Bubbling Azerite, and Azerite Nibblers
.complete 50352,1 
step
.goto 895,75.56,59.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ordnance Handler Prim
.target Ordnance Handler Prim
.turnin 50352 >>Turn in Pinch of Azerite
.turnin 50351 >>Turn in Miner Operation
step
.goto 895,75.53,59.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Civil Technician Alena
.target Civil Technician Alena
.accept 50356 >>Accept Rock Meet Dynamite
step
.goto 895,76.10,59.74,10,0
.goto 895,76.16,60.32,10,0
.goto 895,76.51,60.59,8,0
.goto 895,76.61,59.90,8,0
.goto 895,76.27,59.31,10,0
.goto 895,74.96,59.94
>>On your way through Winterdeep Mine, round up packs of Enraged Nibblers and use your Extra Action Button
>>Kill Earthshaper Brugaw. Use your Extra Action Button on cooldown
.unitscan Earthshaper Brugaw
.complete 50356,1 
step
.goto 895,78.14,55.95
>>On your way out of Winterdeep Mine, round up packs of Enraged Nibblers and use your Extra Action Button
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Chief Miner Theock
.target Chief Miner Theock
.turnin 50356 >>Turn in Rock Meet Dynamite
step
.goto 895,75.84,65.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Alanna Holton
.target Alanna Holton
.turnin 50544 >>Turn in The Hunters of Kennings Lodge
.accept 48874 >>Accept Pardon Our Rust
step
.goto 895,75.82,65.79
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Kennings
.target Lord Kennings
.accept 48873 >>Accept A Grizzly End
.accept 48879 >>Accept A Hunt for Hawk Eggs
step
.goto 895,76.13,65.52
>>Click the Weathered Job List
*It's northeast of Alanna Holton, affixed to a lantern post by the curing skins
.accept 49028 >>Accept A Sweater for Rupert
.accept 49069 >>Accept WANTED: Ol' Frostclaw
step
#completewith next
>>On your way to Ol' Frostclaw's cave, click Sprung Beartraps and kill/loot Guarded Quillrats
.use 152800 >>|T463557:0|tKill Monstrous Grizzlies, then use your Simple Skinning Knife
.unitscan Guarded Quillrat
.complete 48874,1 
.complete 49028,1 
.complete 48873,1 
step
>>Enter Ol' Frostclaw's cave and kill any bears that are awake, then kill Ol' Frostclaw
*Ol' Frostclaw has a frontal cone knockback (Icy Claws) and a 4-second fear (Chilling Roar).
.goto 895,79.69,65.71
.complete 49069,1 
step
#completewith next
.use 152800 >>|T463557:0|tOn your way northwest, finish killing Monstrous Grizzlies and using your Simple Skinning Knife
.complete 48873,1 
step
.loop 10,895,76.82,62.43,76.72,61.82,76.33,61.01,75.90,61.07,74.74,60.65,75.13,61.94,76.00,61.81,76.52,63.00,76.82,62.43
>>On your way northwest, kill/loot Guarded Quillrats and Mountain Raccoons. Click Hawk Nests and Sprung Beartraps
*Open your map and zoom in to see a loop of Hawk Nest spawns
.complete 49028,1 
.complete 49028,2 
.complete 48879,1 
.complete 48874,1 
step
.loop 10,895,76.82,62.43,76.72,61.82,76.33,61.01,75.90,61.07,74.74,60.65,75.13,61.94,76.00,61.81,76.52,63.00,76.82,62.43
.use 152800 >>|T463557:0|tFinish killing Monstrous Grizzlies and using your Simple Skinning Knife
.complete 48873,1 
step
.goto 895,76.68,65.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kolta
.target Kolta
.turnin 49028 >>Turn in A Sweater for Rupert
step
.goto 895,75.82,65.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Kennings
.target Lord Kennings
.turnin 48879 >>Turn in A Hunt for Hawk Eggs
step
.goto 895,75.84,65.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Alanna Holton
.target Alanna Holton
.turnin 48873 >>Turn in A Grizzly End
.turnin 48874 >>Turn in Pardon Our Rust
.turnin 49069 >>Turn in WANTED: Ol' Frostclaw
.accept 49072 >>Accept Westward Noble
.isQuestComplete 49069
step
.goto 895,75.84,65.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Alanna Holton
.target Alanna Holton
.turnin 48873 >>Turn in A Grizzly End
.turnin 48874 >>Turn in Pardon Our Rust
.accept 49072 >>Accept Westward Noble
step
#completewith LordKennings
.abandon 49069 >>Abandon WANTED: Ol' Frostclaw
.isOnQuest 49069
step
.goto 895,70.89,61.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Kennings
.target Lord Kennings
.turnin 49072 >>Turn in Westward Noble
.accept 49039 >>Accept The Start of a Monster Hunt
step
.goto 895,70.88,61.68
>>Click the Smashed Crate
.complete 49039,1 
step
.goto 895,70.81,61.43
>>Click the Disturbed Trap
.complete 49039,3 
step
.goto 895,70.68,61.95
>>Click the Bloody Trail
.complete 49039,2 
step
#label LordKennings
.goto 895,70.89,61.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Kennings
.target Lord Kennings
.turnin 49039 >>Turn in The Start of a Monster Hunt
.accept 48909 >>Accept Noble Responsibilities
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Kennings next to you
.accept 49066 >>Accept Encase of Emergency
step
#completewith KuroktheLost
.line 895,69.04,64.53,69.52,64.39,70.18,64.29,70.31,63.32,69.64,62.24,69.29,63.03,67.99,65.03,69.04,64.53
>>On your way into the glacier, click the Humming Ice blocks and kill any Agitated Ice Shardlings that spawn
*You can finish this later
.complete 49066,1 
step
.goto 895,70.32,62.93
>>Click the Cold Corpse
.complete 48909,1 
step
.goto 895,69.23,62.42
>>Click the Hunter Corpse
.complete 48909,2 
step
.goto 895,68.89,63.93
>>Click the Dead Quillrat
.complete 48909,3 
step
>>Click the Fresh Stag Corpse
.goto 895,68.2,65.13
.complete 48909,4 
step
#label KuroktheLost
.goto 895,68.07,66.50
>>Kill Kurok the Lost
*Run away when Kurok starts casting Shred, and interrupt Avalanche
.unitscan Kurok the Lost
.complete 48909,5 
step
.loop 10,895,69.04,64.53,69.52,64.39,70.18,64.29,70.31,63.32,69.64,62.24,69.29,63.03,67.99,65.03,69.04,64.53
>>Click the Humming Ice blocks and kill any Agitated Ice Shardlings that spawn
*Open your map and zoom in to see a loop of Humming Ice spawns
.complete 49066,1 
step
#requires Area10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lord Kennings
.target Lord Kennings
.turnin 49066 >>Turn in Encase of Emergency
step
.goto 895,75.84,65.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Alanna Holton
.target Alanna Holton
.turnin 48909,1 >>Turn in Noble Responsibilities
step 
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind
.goto 895,75.85,49.12
.target Flynn Fairwind
.turnin 53041 >>Turn in Sampling the Goods
.accept 47489 >>Accept Stow and Go
step
.goto 895,75.84,49.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind
.complete 47489,1 
.skipgossip
step
.goto 895,75.5,48.08
>>Board the Maiden's Virtue
.complete 47489,2 
step
.goto 895,75.5,48.08
>>Click the Barrel of Fish
.complete 47489,3 
step
.goto 895,85.56,83.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Beachcomber Bob
.target Beachcomber Bob
.turnin 47489 >>Turn in Stow and Go
.accept 49218 >>Accept The Castaways
.accept 48419 >>Accept Lured and Allured
step
.goto 895,85.46,80.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Stabby Jane
.target Stabby Jane
.turnin 49218 >>Turn in The Castaways
step
.goto 895,85.46,80.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Stabby Jane again
.target Stabby Jane
.accept 49178 >>Accept My Favorite Things
.accept 49226 >>Accept Silencing the Sisters
.complete 48419,1 
.skipgossip 128229,1
step
.goto 895,85.47,80.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hungry Sam
.target Hungry Sam
.complete 49178,1 
.accept 49230 >>Accept Local Flavor
.skipgossip 128228,1
.skipgossip
step
.goto 895,85.27,80.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Friendly Pete
.target Friendly Pete
.complete 49178,2 
.skipgossip
step
.goto 895,86.43,81.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Handy Bill
.target Handy Bill
.complete 49178,3 
.skipgossip
step
#completewith next
.goto 895,86.43,81.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Handy Bill
.target Handy Bill
.vendor 128227 >> Empty bags/repair gear at Handy Bill if necessary
step
.goto 895,86.35,79.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Captain Keelson
.target Captain Keelson
.accept 48421 >>Accept Blood in the Tides
step
#completewith SilencingtheSisters
.line 895,86.35,79.74,88.26,78.14,87.69,75.12,87.98,75.01,90.13,74.38,88.28,72.92,86.51,72.5
>>As you do other objectives, kill Wailing Sirens and kill/loot Tide Lurkers
.complete 48421,1 
.complete 49230,1 
step
.goto 895,88.26,78.14
>>Loot the Silver Compass
.complete 49178,5 
step
.goto 895,87.69,75.12
>>Loot the Robot
.complete 49178,6 
step
.goto 895,87.98,75.01
>>Click the Glimmering Seaweed
.accept 49181 >>Accept Glimmering Locket
step
.goto 895,90.13,74.38
>>Find Flynn Fairwind
.target Flynn Fairwind
.complete 48419,2 
step
.goto 895,90.13,74.38
>>Kill Lugeia
*Interrupt her Rupturing Note ability
.unitscan Lugeia
.complete 48419,3 
step
.goto 895,88.28,72.92
>>Click Steel Lunchbox
.complete 49178,4 
step
#label SilencingtheSisters
.goto 895,86.51,72.5
>>Enter the cave, then kill Nolpe and Patheope
*Interrupt their Shattering Scream ability
.complete 49226,2 
.complete 49226,1 
step
.loop 20,895,87.67,74.23,87.68,75.69,87.20,77.07,89.57,77.97,87.76,72.82,87.67,74.23
>>On your way back to Stabby Jane, finish killing Wailing Sirens and killing/looting Tide Lurkers
.complete 48421,1 
.complete 49230,1 
step
.goto 895,85.47,80.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Stabby Jane
.target Stabby Jane
.turnin 49178 >>Turn in My Favorite Things
.turnin 49226 >>Turn in Silencing the Sisters
.turnin 49181 >>Turn in Glimmering Locket
step
.goto 895,85.47,80.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Hungry Sam
.target Hungry Sam
.turnin 49230 >>Turn in Local Flavor
step
.goto 895,85.72,76.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk Captain Keelson
.target Captain Keelson
.turnin 48421,1 >>Turn in Blood in the Tides
step
.goto 895,84.91,76.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind
.target Flynn Fairwind
.turnin 48419 >>Turn in Lured and Allured
.accept 48505 >>Accept Lovesick and Lost
step
#completewith ToxicCommunity
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind to start his escort
*Stay close to him. If you don't, he will stop until you're close
.target Flynn Fairwind
.skipgossip
.complete 48505,1 
step
.goto 895,82.74,72.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Skinner MacGuff
.target Skinner MacGuff
.accept 48516 >>Accept Toxic Community
step
>>Kill and loot Venomspine Saurolisks and Marrowflies during the escort
.complete 48516,1 
step
#label ToxicCommunity
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Skinner MacGuff
.goto 895,82.75,72.81
.turnin 48516 >>Turn in Toxic Community
step
.goto 895,84.91,76.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFollow Flynn Fairwind
*Stay close to him. If you don't, he will stop until you're close
.target Flynn Fairwind
.skipgossip
.complete 48505,1 
step
.goto 895,80.21,75.25
*Wait for his roleplay
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind
.target Flynn Fairwind
.turnin 48505 >>Turn in Lovesick and Lost
.accept 48539 >>Accept Freehold
step
.goto 895,80.17,75.3
>>Click the Spyglass in front of Flynn
.complete 48539,1 
step
.goto 895,80.19,75.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind
.turnin 48539 >>Turn in Freehold
.accept 48773 >>Accept Papers, Please
.accept 48558 >>Accept The Irontide Crew
step
#completewith next
>>On your way to Geraldine, kill and loot Irontide Trickshots, Overseers, and Ruffians
.complete 48558,2 
.complete 48774,2 
.complete 48774,1 
step
.goto 895,79.19,76.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Geraldine
.target Geraldine
.accept 48774 >>Accept The Beatings Will Continue
.accept 48776 >>Accept Rig Robbing
step
#completewith next
>>On your way to Dockmaster Marl, kill and loot Irontide Trickshots, Overseers, Cutthroats, and Ruffians
.complete 48558,1 
.complete 48558,2 
.complete 48774,2 
.complete 48774,1 
step
.goto 895,79.13,78.79
>>Kill and loot Dockmaster Marl
.unitscan Dockmaster Marl
.collect 152722,1 
step
.goto 895,79.13,78.79
>>Click the Dockmaster's Strongbox
.complete 48773,1 
step
.goto 895,79.09,77.87,10,0
.goto 895,78.6,77.86
>>Climb the stairs up to the platform and click the Azerite Cannonball
.accept 48606 >>Accept Loaded for Bear
step
.line 895,78.57,77.82,78.58,77.32,78.40,77.59
.goto 895,78.57,77.82,3,0
.goto 895,78.58,77.32,3,0
.goto 895,78.40,77.59
>>Click the 3 Azerite Cannonballs on this platform
.collect 152628,3
step
.goto 895,78.72,76.65
>>Click the Ashvane Cannon on this platform. Destroy 3 crates on the boat ahead
.complete 48606,1,3 
step
.line 895,78.00,76.50,77.81,76.72,77.79,76.17,77.61,76.35
.goto 895,78.00,76.50,3,0
.goto 895,77.81,76.72,3,0
.goto 895,77.79,76.17,3,0
.goto 895,77.61,76.35
>>Cross over to the next platform and collect 3 Azerite Cannonballs
*If you missed any shots with the other cannon, collect extra cannonballs
.collect 152628,3
step
.goto 895,78.43,77.69
>>Click an Ashvane Cannon and destroy any remaining crates on the boat ahead
.complete 48606,1 
step
#completewith PapersPlease
>>Click the Quest Complete pop-up in your Quest Tracker
.turnin 48606 >>Turn in Loaded for Bear
step
.goto 895,77.04,76.28
>>Click the Tangled Rigging. When the cast completes, run away from the water until a barrel flies out. Repeat this until the "Sea Dog" Grog spawns
.complete 48776,1 
step
>>Kill and loot Irontide Trickshots, Overseers, Cutthroats, and Ruffians
.goto 895,78.57,77.82,30,0
.goto 895,78.58,77.32,30,0
.goto 895,78.40,77.59
.complete 48558,1 
.complete 48558,2 
.complete 48774,2 
.complete 48774,1 
step
.goto 895,79.21,76.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Geraldine
.target Geraldine
.turnin 48776 >>Turn in Rig Robbing
.turnin 48774 >>Turn in The Beatings Will Continue
step
#label PapersPlease
.goto 895,80.35,81.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind
.target Flynn Fairwind
.turnin 48773 >>Turn in Papers, Please
.turnin 48558,1 >>Turn in The Irontide Crew
.accept 49239 >>Accept Dress to Impress
step
>>Click the Quest Complete pop-up in your Quest Tracker
.turnin 48606 >>Turn in Loaded for Bear
step
.goto 895,79.70,81.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Roko. He patrols around town.
.target Roko
.accept 49290 >>Accept Aged to Perfection
step
.goto 895,79.81,82.37
>>Use your ExtraActionButton to disguise yourself, then talk to the Irontide Recruiter
.target Irontide Recruiter
.complete 49239,1 
.skipgossip
step
.goto 895,77.31,83.96
>>Enter the Dead Man's Tale, the first building past the bridge on the right side
.complete 49239,2 
step
#completewith next
.target Jill McHoonigan
.vendor >>During the roleplay, empty bags/restock food and water at Jill McHoonigan if necessary
step
.goto 895,77.33,83.97
>>Wait for the roleplay then talk to Flynn Fairwind
.target Flynn Fairwind
.turnin 49239 >>Turn in Dress to Impress
.accept 49401 >>Accept Rodrigo's Roost
.timer 20,Roleplay Duration
step
.goto 895,77.36,83.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Venrik
.target Venrik
.accept 49398 >>Accept Raise a Glass!
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Venrik
.target Venrik
.complete 49398,1 
.skipgossip 128927,2
step
.use 153600 >>|T132815:0|tBottoms up! Have a drink
.complete 49398,2 
step
.goto 895,77.36,83.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Venrik
.target Venrik
.turnin 49398 >>Turn in Raise a Glass!
step
.goto 895,77.03,82.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rodrigo
.accept 49402 >>Accept Flew the Coop
step
.goto 895,77.03,82.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rodrigo again
.target Rodrigo
.complete 49401,1 
.skipgossip 129098,1
step
#completewith next
>>Use your [ExtraActionButton] on Flying Macaw's in the Area
.use 154878
.complete 49402,1 
step
.goto 895,77.33,83.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Flynn Fairwind
.target Flynn Fairwind
.turnin 49401 >>Turn in Rodrigo's Roost
.accept 49399 >>Accept The Big Job
step
.goto 895,77.36,83.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Venrik
.target Venrik
.accept 49400 >>Accept Recruiting Efforts
step
#completewith next
.use 154878 >>|T134372:0|tUse Rodrigo's Birdseed Biscuit to feed Runaway Macaws
.target Runaway Macaw
.complete 49402,1 
step
.goto 895,77.19,84.85
>>Click the Sternly Worded Letter
.accept 49409 >>Accept Missing Treasure!
step
#completewith next
.use 154878 >>|T134372:0|tOn your way to Ned, use Rodrigo's Birdseed Biscuit to feed Runaway Macaws
>>Kill/loot Blacktooth pirates and tear down Irontide Recruiting Posters
*You can finish this later
.target Runaway Macaw
.complete 49402,1 
.complete 49399,3 
.complete 49400,1 
step
.goto 895,77.77,85.28,5,0
.goto 895,77.78,85.01
>>Climb the stairs, then enter the building
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Ned
.target Ned
.complete 49409,1 
.skipgossip
step
#completewith next
.use 154878 >>|T134372:0|tOn your way up to Carentan, use Rodrigo's Birdseed Biscuit to feed Runaway Macaws
>>Tear down Irontide Recruiting Posters
*You can finish this later
.target Runaway Macaw
.complete 49402,1 
.complete 49400,1 
step
.goto 895,76.98,86.06,10,0
.goto 895,76.90,85.98
>>Enter the small building on top of the wooden platform
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Carentan
.target Carentan
.turnin 49290 >>Turn in Aged to Perfection
.accept 49407 >>Accept Trixie Business
step
#completewith next
.use 154878 >>|T134372:0|tOn your way to Nub Nub, use Rodrigo's Birdseed Biscuit to feed Runaway Macaws
>>Kill/loot Bilge Rat pirates and tear down Irontide Recruiting Posters
.target Runaway Macaw
.complete 49402,1 
.complete 49400,1 
.complete 49399,1 
step
.goto 895,76.38,84.32
>>Enter the small building
*There are often two Freehold Colts in front of the building
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nub Nub
.target Nub Nub
.complete 49409,2 
.skipgossip
step
#completewith next
>>On your way to Nance Barmy, kill/loot Cutwater, Blacktooth and Bilge Rat pirates. Tear down Irontide Recruiting Posters
.use 154878 >>|T134372:0|tUse Rodrigo's Birdseed Biscuit to feed Runaway Macaws
.complete 49399,2 
.complete 49399,3 
.complete 49399,1 
.complete 49402,1 
.complete 49400,1 
step
.goto 895,76.13,83.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Nance Barmy
.target Nance Barmy
.complete 49409,3 
.skipgossip
step
.goto 895,76.47,82.63
>>You can skip the roleplay and kill Trixie by removing your disguise and pulling her to the middle of the area. She will pull with two or more mobs.
>>If you start her roleplay, feed Runaway Macaws and tear down Irontide Recruiting Posters as it progresses.
.target First Mate Trixie Tornsail
.complete 49407,1 
.skipgossip
step
>>Click the Sandy Seaweed-covered Chest
.goto 895,75.62,80.57
.complete 49409,4 
step
#label DirtyDiamond
>>Click the Dirty Diamond
.goto 895,76.29,80.77
.complete 49409,5 
step
.goto 895,77.36,83.92
>>On your way back up to Venrik, finish killing/looting Cutwater, Blacktooth and Bilge Rat pirates. Tear down remaining Irontide Recruiting Posters
.use 154878 >>|T134372:0|tUse Rodrigo's Birdseed Biscuit to feed Runaway Macaws
.complete 49399,2 
.complete 49399,3 
.complete 49399,1 
.complete 49402,1 
.complete 49400,1 
step
#completewith TheBigJob
>>Click the Quest Complete pop-up in your Quest Tracker
.turnin 49409 >>Turn in Missing Treasure!
step
#label TheBigJob
.goto 895,77.36,83.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Venrik
.target Venrik
.turnin 49399 >>Turn in The Big Job
.accept 49404 >>Accept Fairwind's "Friends"
.turnin 49400,1 >>Turn in Recruiting Efforts
step
>>On your way to Carentan, click the Quest Complete pop-up in your Quest Tracker
.turnin 49409 >>Turn in Missing Treasure!
step
.goto 895,76.90,85.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Carentan
.target Carentan
.turnin 49407 >>Turn in Trixie Business
.accept 49522 >>Accept Carentan's Payment
step
.goto 895,76.81,85.97
>>Click the Dusty Crate behind Carentan
.complete 49522,1 
step
>>Click the Quest Complete pop-up in your Quest Tracker
.turnin 49522 >>Turn in Carentan's Payment
.accept 49523 >>Accept A Bad Deal
step
.goto 895,77.04,82.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rodrigo
.target Rodrigo
.turnin 49402 >>Turn in Flew the Coop
.accept 49403 >>Accept Rodrigo's Revenge
step
.goto 895,77.06,82.62
>>Click the Riding Macaw. Bomb all of the pirates
.target Riding Macaw
.complete 49403,1 
step
.goto 895,77.04,82.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Rodrigo
.turnin 49403 >>Turn in Rodrigo's Revenge
step
.goto 895,73.83,83.44
>>Fly into to the Ring of Booty
.complete 49404,1 
step
.goto 895,73.84,83.44
>>Click Flynn Fairwind
.target Flynn Fairwind
.complete 49404,2 
step
>>Fight off Harlan's minions until quest completion
.goto 895,73.56,83.43
.complete 49404,3 
step
.goto 895,73.84,83.44
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tFly back to Taelia
.target Taelia
.turnin 49404,1 >>Turn in Fairwind's "Friends"
.accept 49405 >>Accept Defenders of Daelin's Gate
step
.goto 895,77.14,82.9
>>Mount Galeheart
.target Galeheart
.complete 49405,1 
step
>>Wait for the flight
.complete 49405,2 
step
.goto 895,60.92,59.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Vigil Hill Refugee
.target Vigil Hill Refugee
.turnin 49405 >>Turn in Defenders of Daelin's Gate
.accept 52431 >>Accept No-Landing Zone
step
.goto 895,61.07,61.43
>>Kill a commander, then stay in the area and wait for the other commanders
*You can eat/drink between waves if you pull the commanders back from the water
.unitscan Wiley Jaki
.unitscan Skullcrusher Cotner
.unitscan Burnsy the Blade
.complete 52431,2 
.complete 52431,3 
.complete 52431,1 
step
.goto 895,60.92,59.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Vigil Hill Refugee
.target Vigil Hill Refugee
.turnin 52431 >>Turn in No-Landing Zone
.accept 49869 >>Accept A Desperate Defense
step
.goto 895,56.67,61.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lieutenant Tarenfold
.target Lieutenant Tarenfold
.turnin 49869 >>Turn in A Desperate Defense
.accept 52750 >>Accept Farmers Who Fight
.accept 49737 >>Accept Air Raid
step
.goto 895,56.47,61.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.accept 52787 >>Accept Numbing the Pain
step
#completewith next
>>As you collect Evermoss Clumps and free farmers, prioritize killing Irontide Skyriders
.unitscan Irontide Skyrider
.complete 49737,1 
step
.line 895,56.47,61.68,57.02,59.87,57.13,59.55,56.79,59.28,56.61,58.75,56.26,58.50,55.82,59.38,55.34,59.49,55.56,59.68,55.39,60.11,55.17,60.39,55.98,61.27,56.47,61.68
.goto 895,57.02,59.87,4,0
.goto 895,57.13,59.55,4,0
.goto 895,56.79,59.28,4,0
.goto 895,56.61,58.75,4,0
.goto 895,56.26,58.50,6,0
.goto 895,55.82,59.38,4,0
.goto 895,55.34,59.49,4,0
.goto 895,55.56,59.68,4,0
.goto 895,55.39,60.11,4,0
.goto 895,55.17,60.39,4,0
.goto 895,55.98,61.27
>>While collecting Evermoss Clumps from tree trunks, click Vigil Hill Farmers
*Follow your waypoint arrow for an exact route
.complete 52787,1 
.complete 52750,1 
step
.goto 895,55.56,60.01,25,-1
.goto 895,56.94,59.61,25,-1
>>On your way back to Lieutenant Tarenfold, finish killing Irontide Skyriders
.unitscan Irontide Skyrider
.complete 49737,1 
step
.goto 895,56.67,61.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lieutenant Tarenfold
.target Lieutenant Tarenfold
.turnin 52750 >>Turn in Farmers Who Fight
.turnin 49737 >>Turn in Air Raid
.accept 49738 >>Accept Hands Off My Booty!
step
.goto 895,56.48,61.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.turnin 52787 >>Turn in Numbing the Pain
step
.goto 895,56.2,64.47
.target Vigil Hill Cannon
>>Click the Cannon and shoot Looters
.complete 49738,1 
step
.goto 895,56.67,61.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lieutenant Tarenfold
.target Lieutenant Tarenfold
.turnin 49738,1 >>Turn in Hands Off My Booty!
.accept 49736 >>Accept For Kul Tiras!
.accept 49740 >>Accept Cease Fire!
step
.goto 895,56.48,61.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.accept 49741 >>Accept Righteous Retribution
step
.goto 895,58.61,61.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Meredith
.target Meredith
.accept 49757 >>Accept Cat on a Hot Copper Roof
step
.goto 895,58.78,61.28,6,0
.goto 895,58.86,61.34
>>Jump to reach the first ring, then click rings to Scratchy. Click Scratchy twice
.target Scratchy
.complete 49757,1 
step
.goto 895,58.6,61.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Meredith
.target Meredith
.turnin 49757 >>Turn in Cat on a Hot Copper Roof
step
#completewith CannonFour
.use 156520 >>|T604449:0|tAs you do other objectives, rally Vigil Hill Defenders with the Proudmoore Battle Standard
.target Vigil Hill Marine
.complete 49736,1 
step
>>Go on the Ship and Click the Crate with Bombs
.goto 895,55.37,67.82
.complete 49741,1 
step
>>Go Near the Open Fire and use your ExtraActionButton
.goto 895,55.75,67.48
.complete 49741,2 
step
.goto 895,56.49,68.96,15,0
.goto 895,56.55,69.16
>>Click the Captured Cannon
.complete 49740,1,1 
step
.goto 895,56.74,68.9
>>Click the Captured Cannon
.complete 49740,1,2 
step
.goto 895,56.95,70.77,15,0
.goto 895,57.19,70.03
>>Click the Captured Cannon
.complete 49740,1,3 
step
#label CannonFour
.goto 895,57.39,69.63
>>Click the Captured Cannon
.complete 49740,1,4 
step
.loop 15,895,57.13,67.18,57.15,65.97,57.64,65.65,58.53,65.30,58.45,67.11,57.13,67.18
.use 156520 >>|T604449:0|tFinish rallying Vigil Hill Defenders with the Proudmoore Battle Standard
.target Vigil Hill Marine
.complete 49736,1 
step
.goto 895,59.09,66.6
>>Click the Boat
.complete 49741,3 
step
>>When the ExtraActionButton appears, press it
.complete 49741,4 
step 
>>Click the Gryphon
.link /leavevehicle >>Jump off the Gryphon(Copy Paste macro in chat)
.goto 895,57.56,71.58
.complete 49741,5 
step
>>Destroy 5 Powder Barrels with your new Ability
.complete 49741,6 
step 
.goto 895,56.67,61.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Lieutenant Tarenfold
.target Lieutenant Tarenfold
.turnin 49736,1 >>Turn in For Kul Tiras!
.turnin 49740 >>Turn in Cease Fire!
step
.goto 895,56.67,61.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.turnin 49741 >>Turn in Righteous Retribution
.accept 50110 >>Accept Bearers of Bad News
step
.goto 895,56.5,61.25
>>Click Galeheart
.target Galeheart
.complete 50110,1 
step
>>If this isn't finished, manually skip this step
.complete 52544,1 
step
>>Click the Quest Complete pop-up in your Quest Tracker
.turnin 52544 >>Turn in The War Cache
.accept 53332 >>Accept Time of War
step
.goto 1161,49.12,75.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.turnin 50110 >>Turn in Bearers of Bad News
.accept 50795 >>Accept Prepare for Trouble
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Guard
.goto 1161,49.29,76.53,4,0
.goto 1161,49.16,79.85,4,0
.goto 1161,48.17,81.13,4,0
.goto 1161,47.40,81.53
.complete 50795,1 
.skipgossip
step
.goto 1161,47.40,81.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.turnin 50795 >>Turn in Prepare for Trouble
.accept 50787 >>Accept Make Our Case
step
.goto 1161,48.57,83.98
>>Follow the Waypoint
.complete 50787,1 
step
.goto 1161,50.01,87.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.turnin 50795 >>Turn in Prepare for Trouble
.accept 50787 >>Accept Make Our Case
step
.goto 1161,50.01,87.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.turnin 50787 >>Turn in Make Our Case
.accept 50788 >>Accept Enemies Within
.accept 50789 >>Accept Clear the Air
step
#completewith next
>>As you destroy Smoking Payload barrels, kill Ashvane Conspirators
.complete 50788,1 
step
>>Click the Smoking Payload barrels
.goto 1161,49.41,87.00,4,0
.goto 1161,48.58,85.47,4,0
.goto 1161,49.55,84.71,4,0
.goto 1161,48.18,82.53
.complete 50789,1 
step
.goto 1161,49.41,87.00,4,0
.goto 1161,48.58,85.47,4,0
.goto 1161,49.55,84.71,4,0
.goto 1161,48.18,82.53
>>Finish killing Ashvane Conspirators
.unitscan Ashvane Conspirators
.complete 50788,1 
step
>>Click the Quest Complete pop-up in your Quest Tracker
.turnin 50789 >>Turn in Clear the Air
.turnin 50788 >>Turn in Enemies Within
.accept 50790 >>Accept Hot Pursuit
step
.goto 1161,47.76,81.39
>>Click the Proudmoore Charger
.target Proudmoore Charger
.complete 50790,1 
step
>>Spam your 2 ability, and press 1 whenever you encounter obstacles.
.complete 50790,2 
step
.goto 1161,48.26,80.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.turnin 50790 >>Turn in Hot Pursuit
step
.goto 1161,48.42,80.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Katherine Proudmoore
.target Katherine Proudmoore
.accept 50972 >>Accept Proudmoore's Parley
step
.goto 1161,73.38,11.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Roko
.target Roko
.turnin 49523 >>Turn in A Bad Deal
step
.goto 1161,68.77,21.08,5,0
.goto 1161,67.39,21.67,5,0
.goto 1161,67.13,23.06
>>Enter the Harbormaster's Office
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Genn Greymane
.target Genn Greymane
.turnin 50972,1 >>Turn in Proudmoore's Parley
step
.goto 1161,68.42,22.00
>>Click the Scouting Map
.accept 47961 >>Accept Drustvar
step
.goto 1161,68.16,21.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Taelia
.target Taelia
.turnin 47961 >>Turn in Drustvar
.accept 48622 >>Accept The Vanishing Lord
step
.goto 1161,69.27,26.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Halford Wyrmbane
.target Halford Wyrmbane
.turnin 53332 >>Turn in Time for War
step
.goto 1161,69.72,27.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Falstad Wildhammer
.target Falstad Wildhammer
.accept 51714 >>Accept Mission from the King
step
.goto 1161,70.72,27.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Master Mathias Shaw
.target Master Mathias Shaw
.turnin 51714 >>Turn in Mission from the King
]])
RXPGuides.RegisterGuide([[
#df
#version 1
#group RestedXP Alliance 10-60
#name ZA_WarCampaign
#displayname Final Chapter - Zuldazar War Campaign
<<Alliance
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Jes-Tereth
.goto 1161,67.96,26.66
.skipgossip 1
.complete 51308,2 
step
.goto 862,77.54,54.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brigadier Thom
.turnin 51308 >>Turn in Zuldazar Foothold
.accept 51201 >>Accept The Troll's Tale
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the Captured Zandalari Troll
.goto 862,77.51,54.6
.skipgossip 1
.complete 51201,1 
step
.goto 862,77.54,54.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brigadier Thom
.turnin 51201 >>Turn in The Troll's Tale
.accept 51190 >>Accept Granting a Reprieve
.accept 51544 >>Accept Disarming the Cannons
step
.goto 862,77.13,55.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Medic Feorea
.accept 51191 >>Accept Save Them All
step
.goto 862,77.13,55.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Degdod
.accept 51192 >>Accept A Lack of Surplus
.accept 51193 >>Accept That One's Mine
step
#completewith next
.goto 862,77.13,55.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Degdod
.skipgossip 136192,1
.vendor 136192 >>Sell and repair as much as you can if you need to
step
>>Primarily focus on the Other Objectives
#completewith 1
.complete 51190,2 
.complete 51190,1 
step
>>Click the Cannons
#completewith 1
.complete 51192,1 
step
>>Click or heal the Injured Sailors
#completewith 1
.complete 51191,1 
step
>>Click the Cannons
.goto 862,83.37,54.71
.complete 51544,1,1 
step
>>Click the Cannons
.goto 862,83.34,54.4
.complete 51544,1,2 
step
>>Click the Cannons
.goto 862,83.34,54.21
.complete 51544,1,3 
step
#label 1
>>Kill and LOOT Major Alan Hawkins
.goto 862,81.94,51.43
.complete 51193,1 
step
#sticky
#label 2
>>Kill the Zandalari and Forsakens in the Area
.complete 51190,2 
.complete 51190,1 
step
>>Click the Injured Sailors or heal in the Area
.complete 51191,1 
>>Click the Crates in the Area
.complete 51192,1 
step
#requires 2
.goto 862,77.54,54.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Brigadier Thom
.turnin 51190 >>Turn in Granting a Reprieve
.turnin 51544 >>Turn in Disarming the Cannons
step
.goto 862,77.12,55.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Medic Feorea
.turnin 51191 >>Turn in Save Them All
step
.goto 862,77.13,55.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Degdod
.turnin 51192 >>Turn in A Lack of Surplus
.turnin 51193 >>Turn in That One's Mine
step
.next << 59
step
.goto 862,77.50,55.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kelsey Steelspark
.accept 51418 >>Accept Xibala
Step
>>Click the Boat
.complete 51418,1 
step
.goto 862,40.74,70.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Anvil-Thane Thurgaden
.turnin 51418 >>Turn in Xibala
.accept 51331 >>Accept Mole Machinations
.accept 51309 >>Accept Rocks of Ragnaros
step
#sticky
#label notused5
.goto 862,39.59,72.83
.complete 51309,1 
step
.goto 862,38.90,72.36
.complete 51331,1 
step
.goto 862,38.90,72.36
.complete 51331,1 
step
.goto 862,38.90,72.36
.complete 51331,1 
step
.goto 862,38.90,72.36
.complete 51331,1 
step
#requires notused5
.goto 862,40.74,70.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Anvil-Thane Thurgaden
.turnin 51331 >>Turn in Mole Machinations
.turnin 51309 >>Turn in Rocks of Ragnaros
.accept 51359 >>Accept Fragment of the Firelands
.complete 51359,1 
step
>>Use the Abilties (1) and (2) to destroy the Goblins
.goto 862,32.92,69.69
.complete 51359,2 
step
.goto 862,40.74,70.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Anvil-Thane Thurgaden
.turnin 51359 >>Turn in Fragment of the Firelands
step
.next << 59
step
.goto 862,40.77,70.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Kelsey Steelspark
.turnin 52003 >>Turn in
.accept 51968 >>Accept Return to Boralus
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Daria
.goto 876,61.40,51.10
.complete 51968,1 
step
.goto 1161,69.29,26.99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Halford Wyrmbane
.turnin 51968 >>Turn in Return to Boralus
.accept 51961 >>Accept The Ongoing Campaign
.accept 51571 >>Accept Foothold: Nazmir
.turnin 51571 >>Turn in Foothold: Nazmir
.complete 51961,1 
step
.goto 1161,69.29,26.99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Halford Wyrmbane
.turnin 51961 >>Turn in The Ongoing Campaign
]])