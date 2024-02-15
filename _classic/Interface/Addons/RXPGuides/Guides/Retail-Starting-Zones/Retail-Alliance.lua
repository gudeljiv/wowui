RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Alliance 10-60
#groupweight 9
#displayname Chapter 1 - Elwynn Forest
#name 1A_Elwynn Forest
#next 2A_Redridge Mountains
#fresh 30
#veteran
<< Alliance
step
#veteran
.goto 84,61.11,70.6
+The Darkmoon Faire event is now active, |cRXP_WARN_which guarantees you to gain an additional level for free and a temporary 10% experience boost.|r You'll need to purchase |cRXP_WARN_certain items from the auction house to take full advantage of this.|r If necessary,|cRXP_WARN_you can transfer gold from your other characters to make these purchases.|r However, if you find that you can't afford everything, |cRXP_WARN_It's still worthwhile to visit the Darkmoon Faire for the temporary experience buff and to buy only some of the items.|r
>>|cRXP_WARN_It is recommended to log in with a different character possessing at least 10,000 gold. Use this character to purchase the items and then send them over.|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cRXP_FRIENDLY_Auctioneer Fitch|r
.collect 71715,1
.collect 71638,
.collect 71637,1
.collect 71636,1
.collect 71635,1
.collect 71952,1
.collect 71951,1
.collect 71953,1
.collect 71716,1
.target Auctioneer Fitch
.target Auctioneer Jaxon
.target Auctioneer Chilton
.dmf
step
#fresh
+The Darkmoon Faire event is now active, |cRXP_WARN_which guarantees you to gain an additional level for free and a temporary 10% experience boost.|r
.dmf
step
#veteran
.goto 37,42.14,67.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Remy "Two Times".|r
.accept 40 >>Accept A Fishy Peril
.accept 47 >>Accept Gold Dust Exchange
.target Remy "Two Times"
.isOnQuest 7905
.dmf
step
#veteran
.goto 37,41.95,67.16
.train 2259 >> Train |T4620669:0|tAlchemy from |cFF00FF25Lien Farmer.|r
.skipgossip 47384,2,1,1
.target Lien Farmer
.isOnQuest 7905
.dmf
step
#veteran
.goto 37,41.95,67.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lien Farmer.|r
.train 45357 >> Train |T4620676:0|tInscription
.skipgossip 47384,3,6,2
.target Lien Farmer
.isOnQuest 7905
.dmf
step
#veteran
.goto 37,41.89,67.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Tharynn Bouden|r. Buy the following items from him:
.collect 30817,5,29509,1 
.collect 2320,1,29520,1 
.collect 2604,1,29520,1 
.collect 6260,1,29520,1 
.collect 39354,5,29515,1 
.target Tharynn Bouden
.isOnQuest 7905
.dmf
step
#veteran
.goto 37,42.11,65.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Dughan.|r
.turnin 40 >>Turn in A Fishy Peril
.accept 35 >>Accept Further Concerns
.accept 62 >>Accept The Fargodeep Mine
.accept 26378 >>Accept Hero's Call: Westfall!
.target Marshal Dughan
.isOnQuest 7905
.dmf
step
#veteran
.goto 37,41.71,65.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Smith Argus.|r
.accept 26393 >>Accept A Swift Message << Human
.target Smith Argus
.isOnQuest 7905
.dmf
step
#veteran
.goto 37,41.71,64.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bartlett the Brave.|r
.turnin 26393 >>Turn in A Swift Message << Human
.accept 26394 >>Accept Continue to Stormwind<< Human
.fp Goldshire >> Get the Goldshire Flight Path
.target Bartlett the Brave
.isOnQuest 7905
.dmf
step
#veteran
.goto 37,43.19,65.74,5,0
.goto 37,43.26,66.1,5,0
.goto 37,43.32,65.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25William Pestle.|r
.accept 60 >>Accept Kobold Candles
.target William Pestle
.isOnQuest 7905
.dmf
step
#veteran
#completewith net
.goto 37,43.77,65.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Innkeeper Farley.|r Buy |T132789:0|t[Moonberry Juice] from him.
.home >>Set your Hearthstone to Lion's Pride Inn
.collect 1645,5,29506,1 
.target Innkeeper Farley
.isOnQuest 7905
.dmf
step
#veteran
.goto 37,44.37,65.99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Tomas.|r
.train 2550 >> Train Cooking
.target Tomas
.isOnQuest 7905
.dmf
step
.goto 37,43.10,52.17
>>|cRXP_WARN_Repeated use of /sit or removing your gear increases the damage you take.|r
.deathskip >> Die and respawn at the |cFF00FF25Spirit Healer|r
.isOnQuest 37112
step
.goto 37,41.71,64.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bartlett the Brave.|r
.fp Goldshire >> Get the Goldshire Flight Path
.target Bartlett the Brave
.isOnQuest 37112
step
.goto 37,42.11,65.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Dughan.|r
.turnin 54 >>Turn in Report to Goldshire
.accept 62 >>Accept The Fargodeep Mine
.accept 26378 >>Accept Hero's Call: Westfall!
.target Marshal Dughan
.isQuestTurnedIn 26390
step
.goto 37,41.71,65.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Smith Argus.|r
.accept 26393 >>Accept A Swift Message << Human
.target Smith Argus
.isQuestTurnedIn 26390
step
.goto 37,41.71,64.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bartlett the Brave.|r
.turnin 26393 >>Turn in A Swift Message << Human
.accept 26394 >>Accept Continue to Stormwind<< Human
.target Bartlett the Brave
.isQuestTurnedIn 26390
step
.goto 37,43.19,65.74,5,0
.goto 37,43.26,66.1,5,0
.goto 37,43.32,65.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25William Pestle.|r
.accept 60 >>Accept Kobold Candles
.target William Pestle
.isQuestTurnedIn 26390
step
#veteran
#completewith Cooking
.goto 37,43.77,65.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Innkeeper Farley.|r Buy |T132789:0|t[Moonberry Juice] from him.
.turnin 37112 >>Turn in Rest and Relaxation
.collect 1645,5,29506,1 
.home >>Set your Hearthstone to Lion's Pride Inn
.target Innkeeper Farley
.isQuestTurnedIn 26390
.dmf
step
.goto 37,43.77,65.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Innkeeper Farley.|r
.turnin 37112 >>Turn in Rest and Relaxation
.home >>Set your Hearthstone to Lion's Pride Inn
.target Innkeeper Farley
.isQuestTurnedIn 26390
step
#veteran
#label Cooking
.goto 37,44.37,65.99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Tomas.|r
.train 2550 >> Train Cooking
.target Tomas
.isQuestTurnedIn 26390
.dmf
step
.goto 37,42.14,67.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Remy "Two Times".|r
.accept 40 >>Accept A Fishy Peril
.accept 47 >>Accept Gold Dust Exchange
.target Remy "Two Times"
.isQuestTurnedIn 26390
step
#veteran
.goto 37,41.95,67.16
.train 2259 >> Train |T4620669:0|tAlchemy from |cFF00FF25Lien Farmer.|r
.skipgossip 47384,2,1,1
.target Lien Farmer
.isQuestTurnedIn 26390
.dmf
step
#veteran
.goto 37,41.95,67.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lien Farmer.|r
.train 45357 >> Train |T4620676:0|tInscription
.skipgossip 47384,3,6,2
.target Lien Farmer
.isQuestTurnedIn 26390
.dmf
step
#veteran
.goto 37,41.89,67.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Tharynn Bouden|.r Buy the following items from him:
.collect 2604,1,29520,1 
.collect 6260,1,29520,1 
.collect 2320,1,29520,1 
.collect 30817,5,29509,1 
.collect 39354,5,29515,1 
.target Tharynn Bouden
.isQuestTurnedIn 26390
.dmf
step
.goto 37,41.71,64.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bartlett the Brave.|r
.fp Goldshire >> Get the Goldshire Flight Path
.target Bartlett the Brave
.nodmf
.isQuestAvailable 26390
step
.goto 37,42.11,65.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Dughan.|r
.accept 62 >>Accept The Fargodeep Mine
.accept 26378 >>Accept Hero's Call: Westfall!
.target Marshal Dughan
.nodmf
.isQuestAvailable 26390
step
.goto 37,41.71,65.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Smith Argus.|r
.accept 26393 >>Accept A Swift Message << Human
.target Smith Argus
.nodmf
.isQuestAvailable 26390
step
.goto 37,41.71,64.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bartlett the Brave.|r
.turnin 26393 >>Turn in A Swift Message << Human
.accept 26394 >>Accept Continue to Stormwind<< Human
.target Bartlett the Brave
.nodmf
.isQuestAvailable 26390
step
.goto 37,43.19,65.74,5,0
.goto 37,43.26,66.1,5,0
.goto 37,43.32,65.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25William Pestle.|r
.accept 60 >>Accept Kobold Candles
.target William Pestle
.nodmf
.isQuestAvailable 26390
step
.goto 37,43.77,65.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Innkeeper Farley.|r
.home >>Set your Hearthstone to Lion's Pride Inn
.target Innkeeper Farley
.nodmf
.isQuestAvailable 26390
step
.goto 37,42.14,67.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Remy "Two Times".|r
.accept 40 >>Accept A Fishy Peril
.accept 47 >>Accept Gold Dust Exchange
.target Remy "Two Times"
.nodmf
.isQuestAvailable 26390
step
.goto 37,43.2,65.99,5,0
.goto 37,43.2,65.63,5,0
.goto 37,42.9,65.7,5,0
.goto 37,41.78,69.55
.zone 407 >>Take the |cRXP_PICK_Darkmoon Faire Portal|r |cFFfa9602to the Darkmoon Island.|r
.dmf
step
#completewith next
+|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cRXP_FRIENDLY_Strider.|r |cRXP_WARN_only if you don't have a level 1 mount.|r
.dmf
step
.goto 407,51.57,24.84,10,0
.goto 407,55.83,53.02,15,0
.goto 407,50.44,59.33
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kae Ti|r and buy a |T133734:0|t[Ride Ticket Book] from her.
*|cRXP_WARN_buy the cheaper version |cFFfa9602on the left in the window|r|r
.collect 92788,1,92794,1 
.target Kae Ti
.dmf
step
#completewith next
.goto 407,49.45,57.5
.cast 107829 >> |cRXP_WARN_Open Ride Ticket Book.|r
.dmf
.use 92788
.use 92794
step
#veteran
.goto 407,49.45,57.5
>>|cFFFCDC00Stand on the Carousel and |cRXP_WARN_wait for the Experience Buff to reach 60minutes.|r|r
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the quest items in your bag |cRXP_WARN_and skip the ones you don't have)|

.accept 29464 >>Accept Tools of Divination
.accept 29451 >>Accept The Master Strategist
.accept 29456 >>Accept A Captured Banner
.accept 29457 >>Accept The Enemy's Insignia
.accept 29458 >>Accept The Captured Journal
.accept 29443 >>Accept A Curious Crystal
.accept 29444 >>Accept An Exotic Egg
.accept 29445 >>Accept An Intriguing Grimoire
.accept 29446 >>Accept A Wondrous Weapon
.zoneskip 407,1
.dmf
step
#fresh
.goto 407,49.45,57.5
>>|cFFFCDC00Stand on the Carousel and |cRXP_WARN_wait for the Experience Buff to reach 60minutes.|r|r
.zoneskip 407,1
.dmf
step
#veteran
.goto 407,51.91,60.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Professor Paleo.|r
.turnin -29464 >>Turn in Tools of Divination
.turnin -29451 >>Turn in The Master Strategist
.turnin -29456 >>Turn in A Captured Banner
.turnin -29457 >>Turn in The Enemy's Insignia
.turnin -29458 >>Turn in The Captured Journal
.turnin -29443 >>Turn in A Curious Crystal
.turnin -29446 >>Turn in A Wondrous Weapon
.zoneskip 407,1
.dmf
step
#veteran
.goto 407,47.76,64.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Gelvas Grimegate|r and buy as many |T669449:0|t[Darkmoon Top Hats] from him as you can.
.turnin 7905 >>Turn in The Darkmoon Faire
.collect 171364,1,29506,1 
.target Gelvas Grimegate
.zoneskip 407,1
.dmf
step
#fresh
.goto 407,47.76,64.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Gelvas Grimegate.|r
.turnin 7905 >>Turn in The Darkmoon Faire
.target Gelvas Grimegate
.zoneskip 407,1
.dmf
step
.goto 407,52.89,67.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Stamp Thunderhorn.|r
.accept 29509 >>Accept Putting the Crunch in the Frog
.target Stamp Thunderhorn
.zoneskip 407,1
.dmf
step
.goto 407,52.88,67.96
>>Use the |T133642:0|t[Plump Frogs] to turn them into |T237579:0|t[Breaded Frogs.]
.collect 72056,5,29509,1,-1 
.collect 30817,5,29509,1,-1 
.collect 72057,5,29509,1 
.use 72056 
.zoneskip 407,1
.df
.isOnQuest 29509
step
.goto 407,52.88,67.96
>>Use the |T237579:0|t[Breaded Frogs] near |cFF00FF25Stamp Thunderhorn.|r
.collect 72057,5,29509,1,-1 
.complete 29509,1 
.use 72057 
.zoneskip 407,1
.dmf
.isOnQuest 29509
step
.goto 407,52.88,67.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Stamp Thunderhorn.|r
.turnin 29509 >>Turn in Putting the Crunch in the Frog
.target Stamp Thunderhorn
.zoneskip 407,1
.dmf
step
.goto 407,50.54,69.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sylannia|r and buy |T132792:0|t[Fizzy Faire Drinks] from her.
.accept 29506 >>Accept A Fizzy Fusion
.collect 19299,5,29506,1 
.target Sylannia
.zoneskip 407,1
.dmf
step
.goto 407,50.54,69.56
>>Use the |T132793:0|t[Cocktail Shaker] to make |T463532:0|t[Moonberry Fizz].
.collect 1645,5,29506,1,-1 
.collect 19299,5,29506,1,-1 
.complete 29506,1 
.use 72043 
.zoneskip 407,1
.dmf
step
.goto 407,50.53,69.56
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sylannia.|r
.turnin 29506 >>Turn in A Fizzy Fusion
.target Sylannia
.zoneskip 407,1
.dmf
step
.goto 407,53.23,75.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sayge.|r
.turnin 29445 >>Turn in An Intriguing Grimoire
.accept 29515 >>Accept Writing the Future
.target Sayge
.zoneskip 407,1
.dmf
.isOnQuest 29445
step
.goto 407,53.23,75.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sayge.|r
.accept 29515 >>Accept Writing the Future
.target Sayge
.zoneskip 407,1
.dmf
step
.goto 407,53.23,75.82
>>Use the |T413571:0|t[Bundle of Exotic Herbs] to make |T237061:0|t[Prophetic Ink].
.collect 71972,1,29515,1
.use 71971
.zoneskip 407,1
.dmf
.isOnQuest 29515
step
.goto 407,53.23,75.82
>>Use the |T237061:0|t[Prophetic Ink] to make |T134943:0|t[Fortunes].
.collect 39354,5,29515,1,-1 
.complete 29515,1 
.use 71972
.zoneskip 407,1
.dmf
.isOnQuest 29515
step
.goto 407,53.23,75.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sayge.|r
.turnin 29515 >>Turn in Writing the Future
.target Sayge
.skipgossip
.zoneskip 407,1
.dmf
step
#veteran
.goto 407,51.11,82.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Yebb Neblegear.|r
.turnin 29444 >>Turn in An Exotic Egg
.target Yebb Neblegear
.zoneskip 407,1
.dmf
.isOnQuest 29444
step
.goto 407,50.56,90.80
.zone 37 >>Take the |cRXP_PICK_Darkmoon Faire Portal|r |cFFfa9602to Elwynn Forest.|r
.zoneskip 407,1
.dmf
step
#completewith next
+|cRXP_WARN_Abandon your Professions|r
.link /run AbandonSkill(773); AbandonSkill(171); >> |cRXP_WARN_Click this text to receive a macro that will unlearn your professions.|r



.isOnQuest 60
.dmf
step
>>|cRXP_WARN_Do this once you've unlearned your professions|r
.goto 37,41.95,67.16,5 >> |cRXP_WARN_Walk to the Profession Trainer|r
.dmf
step
.goto 37,41.95,67.16
.train 2366 >> Train |T4620675:0|tHerbalism from |cFF00FF25Lien Farmer.|r
.skipgossip 47384,1,1,1
.target Lien Farmer
.dmf
step
.goto 37,41.95,67.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lien Farmer.|r
.train 2575 >> Train |T4620679:0|tMining
.skipgossip 47384,2,3,2
.target Lien Farmer
.dmf
step
#veteran
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Julia Stevens.|r
>>|cRXP_WARN_Skip this step if you don't have level 25 Pet Battle Pets.|r
.goto 37,41.65,83.67
.accept 31693 >>Accept Julia Stevens
.target Julia Stevens
.isQuestTurnedIn 31903 
step
#veteran
>>Defeat |cFFFF5722Julia Stevens|r in a Pet Battle.
.complete 31693,1 
.target Julia Stevens
.isOnQuest 31693
step
#veteran
.goto 37,41.66,83.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Julia Stevens.|r
.turnin 31693 >>Turn in Julia Stevens
.target Julia Stevens
.isQuestComplete 31693
step
#completewith FargodeepM
>>Kill |cFFFF5722Kobold Tunnelers|r, |cFFFF5722Miners|r and loot them for their |cFF00BCD4Candles|r and |cFF00BCD4Gold Dust.|r
.complete 60,1 
.complete 47,1 
.target Kobold Tunneler
.target Kobold Miner
step
>>|cFFFCDC00Rares and Treasures reward a lot of experience! Be sure to keep an eye out for them|r
.goto 37,38.06,83.31,40 >>Check for |cFFFF5722Narg the Taskmaster|r(Rare) |cFFfa9602outside the mine.|r
.unitscan Narg the Taskmaster
.isOnQuest 60
step
#completewith next
.goto 38,38.93,82.18,15,0
.goto 38,44.60,63.38,15 >> |cFFfa9602Go into the upper entrance of the Fargodeep Mine.|r
step
#label FargodeepM
>>Run |cFFfa9602inside the mine.|r
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
>>Kill |cFFFF5722Kobold Tunnelers|r, |cFFFF5722Miners|r and loot them for their |cFF00BCD4Large Candles|r and |cFF00BCD4Gold Dust.|r
.complete 60,1 
.complete 47,1 
.target Kobold Tunneler
.target Kobold Miner
step
.goto 37,34.66,84.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Ma Stonefield.|r
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
>>Kill |cFFFF5722Princess|r and loot her for |cFF00BCD4Brass Collar.|r
.complete 88,1 
.target Princess
step
.goto 37,34.66,84.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Ma Stonefield.|r
.turnin 88 >>Turn in Princess Must Die!
.target Ma Stonefield
step
.goto 37,33.64,87.76,15 >>Check for the |cFFDB2EEFChest|r |cFFfa9602inside and around the Stables.|r
.isOnQuest 60
step
.goto 37,30.73,64.85,40 >>Check for |cFFFF5722Morgaine the Sly|r (Rare) |cFFfa9602inside the house.|r
.unitscan Morgaine the Sly
.isOnQuest 60
step
.goto 37,27.22,67.51,40 >>Check for the |cFFFF5722Grizzled Ben|r(Rare).
.unitscan Grizzled Ben
.isOnQuest 60
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cFF00FF25Wanted Poster|r and |cFF00FF25Deputy Rainer.|r
.accept 176 >>Accept WANTED: "Hogger"
.goto 37,24.55,74.67
.accept 11 >>Accept Riverpaw Gnoll Bounty
.goto 37,24.23,74.45
.target Deputy Rainer
step
#completewith Armbands
+Check for |cFFFF5722Gruff Swiftbite|r (Rare) and |cFFDB2EEFChests|r in all the camps.
.unitscan Gruff Swiftbite
step
#completewith next
>>Kill |cFFFF5722Riverpaw Runts|r and |cFFFF5722Outrunners|r and loot them for their |cFF00BCD4Painted Gnoll Armbands.|r
.complete 11,1 
.target Riverpaw Runt
.target Riverpaw Outrunner
step
.goto 37,24.97,95.23
>>Kill |cFFFF5722Hogger.|r
>>|cRXP_WARN_DON'T wait out the RP.|r
.complete 176,1 
step
.goto 37,24.78,95.26
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFF00FF25Westfall Deed|r |cFFfa9602on the ground.|r
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
>>Kill |cFFFF5722Riverpaw Runts|r and |cFFFF5722Outrunners|r and loot them for their |cFF00BCD4Painted Gnoll Armbands|r
.complete 11,1 
step
#completewith next
.goto 37,24.36,93.65,30,0
.goto 37,26.10,91.95,30,0
.goto 37,25.30,88.95,30,0
.goto 37,27.80,88.36,30,0
.goto 37,27.67,86.21,30,0
.goto 37,26.32,86.82,40 >>Check for |cFFFF5722Gruff Swiftbite|r(Rare) and |cFFDB2EEFChests|r in all the camps.
.unitscan Gruff Swiftbite
step
.goto 37,24.23,74.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Deputy Rainer.|r
.turnin 11 >>Turn in Riverpaw Gnoll Bounty
.target Deputy Rainer
step
#veteran
.goto 52,60.85,18.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Old MacDonald.|r
>>|cRXP_WARN_Skip this step if you don't have level 25 Pet Battle Pets.|r
.accept 31780 >>Accept Old MacDonald
.target Old MacDonald
.isQuestTurnedIn 31903
step
#veteran
.goto 52,61.04,18.82
>>Defeat |cFFFF5722Old MacDonald|r in a Pet Battle.
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Old MacDonald
.complete 31780,1 
.target Old MacDonald
.skipgossip 65648,1
.isOnQuest 31780
step
#veteran
.goto 52,61.04,18.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Old MacDonald.|r
.turnin 31780 >>Turn in Old MacDonald
.target Old MacDonald
.isQuestComplete 31780
step
.goto 52,60.05,19.28,5,0
.goto 52,60.18,19.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lieutenant Horatio Laine.|r
.turnin 184 >>Turn in Furlbrow's Deed
.turnin 26378 >>Turn in Hero's Call: Westfall!
.accept 26209 >>Accept Murder Was The Case That They Gave Me
.target Lieutenant Horatio Laine
step
.loop 25,52,58.56,16.21,59.18,18.16,58.12,19.58,57.31,18.33,58.56,16.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cFF00FF25Homeless Citizens|r, |cFF00FF25West Plains Drifters|r, and |cFF00FF25Transients|r for |cFF00BCD4Clues|r.
>>|cRXP_WARN_Stay mounted and spam talk to them, ignore them if they turn Hostile|r
.complete 26209,1 
.complete 26209,2 
.complete 26209,3 
.complete 26209,4 
.target Homeless Stormwind Citizen
.target West Plains Drifter
.target Transients
.skipgossip 1
step
.goto 52,60.05,19.28,5,0
.goto 52,60.18,19.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lieutenant Horatio Laine.|r
.turnin 26209 >>Turn in Murder Was The Case That They Gave Me
.accept 26213 >>Accept Hot On the Trail: The Riverpaw Clan
.target Lieutenant Horatio Laine
step
#completewith Horatio
.goto 52,56.46,13.26,30 >>Check for a |cFFDB2EEFChest|r |cFFfa9602in the camp.|r
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
>>Kill |cFFFF5722Gnolls|r and loot them for the |cFF00BCD4Clue.|r
.complete 26213,1 
.target Riverpaw Scout
step
#label Horatio
.goto 52,60.05,19.28,5,0
.goto 52,60.18,19.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lieutenant Horatio Laine.|r
.turnin 26213 >>Turn in Hot On the Trail: The Riverpaw Clan
.target Lieutenant Horatio Laine
step
#completewith next
.hs >>Hearth to Lion's Pride Inn
step
.goto 37,43.32,65.70
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25William Pestle.|r
.turnin 60 >>Turn in Kobold Candles
.target William Pestle
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Remy "Two Times"|r and |cFF00FF25Marshal Dughan.|r
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
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Remy "Two Times"|r and |cFF00FF25Marshal Dughan.|r
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
.goto 37,41.69,65.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Andrew Krighton.|r
.vendor >>Vendor and Repair
.isOnQuest 35
.target Andrew Krighton
step
.goto 37,52.25,62.90,40 >>Check for |cFFFF5722Lamepaw the Whimperer|r(Rare)
.unitscan Lamepaw the Whimperer
.isOnQuest 35
step
.goto 37,57.49,64.61,45 >> |cFFFCDC00Scan the murloc islands with your mouse for a|r |cFFDB2EEFChest|r. Your mouse will become a |TInterface/cursor/crosshair/interact.blp:20|tgear icon if there's a |cFFDB2EEFChest|r. If you find one, kill the |cFFFF5722Murlocs|r protecting it and loot it.
.isOnQuest 35
step
.goto 37,66.51,63.83,40 >> Check for |cFFFF5722Tarantis|r(Rare).
.unitscan Tarantis
.isOnQuest 35
step
.goto 37,64.7,56.73,30 >>Check for the |cFFDB2EEFChest|r |cFFfa9602in the Kobold Camp.|r
.isOnQuest 35
step
.goto 37,61.70,53.83,20 >> Enter the |cFFfa9602Jasperlode Mine.|r
.isOnQuest 35
step
.goto 40,45.11,67.29,20,0
.goto 40,38.43,61.58,20,0
.goto 40,37.01,50.26
>>Keep following |cFFfa9602the middle path inside the mine.|r
.complete 76,1 
step
.goto 40,31.02,37.51,20,0
.goto 40,37.01,50.26,20,0
.goto 40,47.25,36.66,20,0
.goto 40,53.93,30.58,20,0
.goto 40,45.14,21.76,20 >>Check for |cFFFF5722Mother Fang|r(Rare) |cFFfa9602at the back of the cave.|r
.unitscan Mother Fang
.isOnQuest 35
step
.isOnQuest 35
.deathskip >> Die and respawn at the |cFF00FF25Spirit Healer.|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Guard Thomas|r and the |cFF00FF25Bounty Board.|r
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
>>Kill |cFFFF5722Prowlers|r and |cFFFF5722Young Forest Bears.|r
>>|cRXP_WARN_Prioritize the |cFFFF5722Bears|r|r
.complete 52,1 
.complete 52,2 
.target Prowler
.target Young Forest Bear
step
.goto 37,82.95,84.82,40 >> Check for |cFFFF5722Bushtail.|r.
.isOnQuest 52
.unitscan Bushtail
step
#completewith next
>>Kill |cFFFF5722Murlocs|r and loot them for their |cFF00BCD4Fins.|r
.complete 46,1,4 
.target Murloc Lurker
.target Murloc Forager
step
.goto 37,75.71,86.29,30,0
.goto 37,77.55,85.75
.deathskip >> Kill|cFFFF5722Murlocs|r and loot them for their |cFF00BCD4Fins|r |cRXP_WARN_while dying to them|r then respawn at the |cFF00FF25Spirit Healer.|r
.isOnQuest 46
step
.goto 37,83.28,66.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rallic Finn.|r
.vendor 1198 >>Vendor and Repair
.target Rallic Finn
.isOnQuest 52
step
.goto 37,79.46,68.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sara Timberlain.|r
.accept 83 >>Accept Fine Linen Goods
.target Sara Timberlain
step
.goto 37,78.87,67.20,10,0
.goto 37,78.61,67.08
>>Kill |cFFFF5722James|r and loot him for his |cFF00BCD4Head|r and |cFF00BCD4Schedule.|r
.complete 26152,1 
.collect 1307,1,123,1 
.accept 123 >>Accept The Collector
.target James Clark
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Supervisor Raelen|r and |cFF00FF25Marshal Patterson.|r
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
>>Kill |cFFFF5722Prowlers|r and |cFFFF5722Young Forest Bears.|r
>>|cRXP_WARN_Prioritize the |cFFFF5722Bears|r|r
.complete 52,1 
.complete 52,2 
.target Prowler
.target Gray Forest Wolf
.target Young Forest Bear
step
#completewith next
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on |cFFDB2EEFBundles of Wood|r |cFFfa9602on the ground.|r
.complete 5545,1 
step
#label LostGuards
.goto 37,72.65,60.33
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cFF00FF25Carcass|r |cFFfa9602on the ground.|r
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
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on |cFFDB2EEFBundles of Wood|r |cFFfa9602on the ground.|r
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
>>Kill |cFFFF5722Prowlers|r and |cFFFF5722Young Forest Bears.|r
>>|cRXP_WARN_Prioritize the |cFFFF5722Bears|r|r
.complete 52,1 
.complete 52,2 
.target Prowler
.target Gray Forest Wolf
.target Young Forest Bear
step
.goto 37,79.80,55.51
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cFF00FF25Carcass|r located |cFFfa9602on the ground.|r
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
>>Kill |cFFFF5722Murloc Foragers|r and |cFFFF5722Lurkers|r and loot them for their |cFF00BCD4Torn Murloc Fin.|r
.complete 46,1 
.target Murloc Lurker
.target Murloc Forager
step
#completewith next
.goto 37,77.65,57.70
.deathskip >>Die and respawn at the |cFF00FF25Spirit Healer|r.
>>|cRXP_WARN_Skip this if you're not low on health.|r
step
.goto 37,73.97,72.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thomas.|r
.turnin 46,1 >>Turn in Bounty on Murlocs
.turnin 52 >>Turn in Protect the Frontier
.accept 59 >>Accept Cloth and Leather Armor
.turnin 71 >>Turn in Report to Thomas
.target Thomas
step
#completewith Morgan
>>Kill |cFFFF5722Bandits|r and loot them for their |cFF00BCD4Linen Scraps.|r
.complete 83,1 
.target Bandit
step
.goto 37,69.32,79.31,30 >>Check for |cFFFF5722Snoot the Rooter|r(Rare).
.unitscan Snoot the Rooter
.isOnQuest 83
step
#label Morgan
.goto 37,71.01,80.69
>>Kill |cFFFF5722Morgan the Collector|r |cFFfa9602in the house.|r and loot him for |cFF00BCD4The Collector's Ring.|r
>>|cRXP_WARN_Check for a |cFFDB2EEFChest|r |cFFfa9602in|r and |cFFfa9602around the house.|r|r
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
>>Kill |cFFFF5722Bandits|r and loot them for their |cFF00BCD4Linen Scraps.|r
>>|cRXP_WARN_Check for a |cFFDB2EEFChest|r |cFFfa9602in|r and |cFFfa9602around the barn.|r|r
.complete 83,1 
.target Bandit
step
.goto 37,75.71,86.29,30,0
.goto 37,77.55,85.75
.deathskip >> Die and respawn at the |cFF00FF25Spirit Healer.|r
.isOnQuest 83
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rallic Finn.|r
.goto 37,83.28,66.09
.vendor 1198 >>Vendor and Repair
.target Rallic Finn
.isOnQuest 59
step << !DarkIronDwarf !KulTiran !LightforgedDraenei !Mechagnome !VoidElf
.goto 37,81.81,66.49,0,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Goss the Swift.|r
.fp Eastvale Logging Camp >> Get the Eastvale Logging Camp flight path
.target Goss the Swift
.isOnQuest 147
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Patterson|r and |cFF00FF25Supervisor Raelen.|r
.turnin 147 >>Turn in Manhunt
.goto 37,81.86,66.04
.turnin 5545 >>Turn in A Bundle of Trouble
.goto 37,81.38,66.11
.target Marshal Patterson
.target Supervisor Raelen
step
.goto 37,79.46,68.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sara Timberlain.|r
.turnin 59 >>Turn in Cloth and Leather Armor
.turnin 83 >>Turn in Fine Linen Goods
.target Sara Timberlain
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Alliance 10-60
#name 2A_Redridge Mountains
#displayname Chapter 2 - Redridge Mountains
#next 3A_Duskwood
#fresh 30
#veteran
<< Alliance
step
#completewith next
.goto 49,10.12,64.26,60 >>Travel |cFFfa9602to Redridge Mountains.|r
.zoneskip 49
step
.goto 49,16.03,64.63
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFF00FF25Wanted Poster.|r
.accept 26504 >>Accept WANTED: Redridge Gnolls
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Darcy Parker|r and |cFF00FF25Watch Captain Parker.|r
.accept 26506 >>Accept Franks and Beans
.goto 49,15.62,65.33
.accept 26503 >>Accept Still Assessing the Threat
.goto 49,15.42,65.91,8,0
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
>>Kill |cFFFF5722Tarantulas|r and loot them for their |cFF00BCD4Tarantula Eyes.|r
.complete 26506,1 
.target Tarantula
step
#completewith Martie
>>Kill |cFFFF5722Dire Condors|r and loot them for their |cFF00BCD4Giblets.|r
>>Kill |cFFFF5722Great Goretusks|r and loot them for their |cFF00BCD4Kidneys.|r
.complete 26506,2 
.complete 26506,3 
.target Dire Condor
.target Great Goretusk
step
#completewith next
>>Kill |cFFFF5722Gnolls.|r
>>|cRXP_WARN_Don't focus on this at all.|r
.complete 26504,1 
.target Redridge Brute
.target Redridge Thrasher
step
.goto 49,16.20,55.26
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFBattle Plans|r |cFFfa9602on the ground.|r
.complete 26503,1 
step
#label Martie
.goto 49,22.04,42.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Martie Jainrose.|r
.accept 26509 >>Accept An Unwelcome Guest
.target Martie Jainrose
step
.goto 49,17.91,44.87
>>Kill |cFFFF5722Bellygrub|r and loot her for |cFF00BCD4Bellygrub's Tusk.|r
.complete 26509,1 
.target Bellygrub
step
.goto 49,22.04,42.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Martie Jainrose.|r
.turnin 26509 >>Turn in An Unwelcome Guest
.target Martie Jainrose
step
#completewith next
.goto 49,26.06,42.58,10,0
.goto 49,26.34,42.20,10 >>Go |cFFfa9602inside the Inn.|r
step
.goto 49,26.40,41.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Innkeeper Brianna.|r
.home >>Set your Hearthstone to Lakeshire
.target Innkeeper Brianna
step
#completewith next
.goto 49,28.49,42.44,10,0
.goto 49,27.99,41.27,10 >>Go |cFFfa9602inside the Town Hall.|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bailiff Conacher|r and |cFF00FF25Magistrate Solomon.|r
.accept 26511 >>Accept Lake Everstill Clean Up
.accept 26728 >>Accept Hero's Call: Duskwood!
.goto 49,28.67,40.95
.accept 26510 >>Accept We Must Prepare!
.goto 49,28.91,41.12
.target Bailiff Conacher
.target Magistrate Solomon
step
#completewith next
.goto 49,27.99,41.27,10,0
.goto 49,28.49,42.44,10 >>Exit |cFFfa9602the Town Hall.|r
step
.goto 49,28.34,48.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Shawn.|r
.accept 26508 >>Accept Nida's Necklace
.target Shawn
step
.goto 49,27.05,50.96,30,0
.goto 49,29.77,49.32,30,0
.goto 49,32.20,50.23
>>Jump |cFFfa9602into the water|r and look around for a |cFFDB2EEFBig Dirt Puddle|r |cFFfa9602on the Ground.|r It has multiple spawn points. |TInterface/cursor/crosshair/interact.blp:20|tClick it for the |cFFDB2EEFNecklace|r
.complete 26508,1 
.isOnQuest 26508
step
#completewith next
.goto 49,29.42,53.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Ariena Stormfeather.|r
.fp Lakeshire >>Get the Lakeshire Flight Path
.target Ariena Stormfeather
step
#completewith next
>>Kill |cFFFF5722Murlocs.|r
>>Check for |cFFFF5722Squiddic|r(Rare) in front of the |cFFDB2EEFGnomecorder.|r
.complete 26511,1 
.target Murloc Flesheater
.target Murloc Scout
.unitscan Squiddic
step
.goto 49,37.82,42.16
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFGnomecorder|r |cFFfa9602on the ground.|r
.complete 26510,1 
step
.goto 49,38.92,40.88,30,0
.goto 49,38.79,44.56,30,0
.goto 49,37.69,45.53,30,0
.goto 49,40.84,48.84,30,0
>>Kill |cFFFF5722Murlocs.|r
>>Check for |cFFFF5722Squiddic|r(Rare) |cFFfa9602in front of the|r |cFFDB2EEFGnomecorder.|r
.complete 26511,1 
.target Murloc Flesheater
.target Murloc Scout
.unitscan Squiddic
step
.goto 49,28.28,48.88
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Nida.|r
.turnin 26508 >>Turn in Nida's Necklace
.target Nida
.isQuestComplete 26508
step
.abandon 26508 >>Abandon Nida's Necklace
step
#completewith next
.goto 49,28.49,42.44,10,0
.goto 49,27.99,41.27,10 >>Go |cFFfa9602inside the Town Hall.|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bailiff Conacher|r and |cFF00FF25Magistrate Solomon.|r
.turnin 26511 >>Turn in Lake Everstill Clean Up
.goto 49,28.67,40.95
.turnin 26510 >>Turn in We Must Prepare!
.accept 26512 >>Accept Tuning the Gnomecorder
.goto 49,28.91,41.12
.target Bailiff Conacher
.target Magistrate Solomon
step
#completewith Marris
.goto 49,27.99,41.27,10,0
.goto 49,28.49,42.44,10 >>Exit |cFFfa9602the Town Hall.|r
step
.goto 49,28.84,43.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Karen Taylor.|r
.vendor >>Vendor and Repair
.target Karen Taylor
.isOnQuest 76
step << DarkIronDwarf
.zone 84 >>Use the |T1786409:0|t|cFF00FF25Mole Machine|r and |TInterface/cursor/crosshair/interact.blp:20|tinteract with it.
.skipgossip 143925,1,2
.xp <20,1
.pve
.isOnQuest 76
step << Monk
.goto 379,48.96,43.36
.zone 84 >>Use |T775462:0|tZen Pilgrimage and |TInterface/cursor/crosshair/interact.blp:20|tClick the |cRXP_PICK_portal to Stormwind.|r
.xp <20,1
.pve
.isOnQuest 76
step << Monk
.goto 84,49.45,86.60,8,0
.goto 84,49.51,86.67,10 >>Go |cFFfa9602through the portal and exit the Mage Tower.|r
.isOnQuest 76
step << !Monk !DarkIronDwarf
.goto 49,29.42,53.76
.fly Stormwind >>Fly |cFFfa9602to Stormwind.|r
.target Ariena Stormfeather
.xp <20,1
.pve
.isOnQuest 76
step
+|cFFFCDC00Open Up your Talents (Default N) and turn on Warmode to an XP buff and extra talents.
>>|cRXP_WARN_Skip this step if you don't want to turn on Warmode.|r
.pve
.xp <20,1
step
#completewith next
.goto 84,70.94,72.45,-1
.goto 49,29.42,53.76,-1
.fly Goldshire >>Fly |cFFfa9602to Goldshire.|r
.target Dungar Longdrink
.target Ariena Stormfeather
.zoneskip 37
.xp <20,1
step
.goto 37,42.11,65.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Dughan.|r
.turnin 76 >>Turn in The Jasperlode Mine
.target Marshal Dughan
.xp <20,1
step
#completewith next
.goto 37,41.71,64.64
.fly Lakeshire >>Fly |cFFfa9602to Lakeshire.|r
.target Bartlett the Brave
.zoneskip 49
.xp <20,1
step
#label Marris
.goto 49,31.86,44.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Marris.|r
.accept 26513 >>Accept Like a Fart in the Wind
.target Marshal Marris
step
.goto 49,32.32,39.66
>>Run |cFFfa9602into the Lakeshire Graveyard.|r
.complete 26512,1 
step
.goto 49,32.24,40.02
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 26512 >>Turn in Tuning the Gnomecorder
.accept 26514 >>Accept Canyon Romp
step
#completewith Reminder1
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFCrates|r |cFFfa9602on the ground.|r
.complete 26513,1 
step
.goto 49,29.93,37.19,30,0
.goto 49,21.52,34.18,30,0
.goto 49,23.46,26.13
>>Kill |cFFFF5722Gnolls|r and loot them for their |cFF00BCD4Redridge Gnoll Collars|r and |cFF00BCD4Scroll.|r
.complete 26514,1 
.accept 26519 >>Accept He Who Controls the Ettins
.target Redridge Mystic
.target Redridge Basher
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 26514 >>Turn in Canyon Romp
.accept 26544 >>Accept They've Wised Up...
step
#completewith next
.goto 49,20.39,26.60,30 >> Go |cFFfa9602inside the cave.|r
step
#label Reminder1
>>Kill |cFFFF5722Blackrock Overseers|r and loot them for |cFF00BCD4Blackrock Orc Missive.|r
.goto 49,20.37,23.66,40,0
.goto 49,18.80,22.84,40,0
.goto 49,16.91,21.24
.complete 26544,1 
.target Blackrock Overseer
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 26544 >>Turn in They've Wised Up...
.accept 26545 >>Accept Yowler Must Die!
step
#completewith ControlOrb
.goto 49,16.91,21.24,40,0
.goto 49,17.81,17.20,20,0
.goto 49,19.25,16.46,20,0
.goto 49,17.85,18.62,10 >> Run up |cFFfa9602to the Control Orb.|r
step
.goto 49,17.96,18.53
>>Kill |cFFFF5722Ardo Dirtpaw|r |cFFfa9602inside the Cave.|r
>>|cRXP_WARN_Check for a |cFFDB2EEFChest|r near him.|r
.complete 26519,1 
.target Ardo Dirtpaw
step
#label ControlOrb
.goto 49,17.84,18.62
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFF00FF25Control Orb.|r
.turnin 26519 >>Turn in He Who Controls the Ettins
.accept 26520 >>Accept Saving Foreman Oslow
step
#label ExitCave
#completewith Yowler
.goto 49,20.39,26.60,20 >> Exit |cFFfa9602the cave.|r
step
#requires ExitCave
#completewith next
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFCrates|r |cFFfa9602on the ground.|r
.complete 26513,1 
step
#label Yowler
>>Kill |cFFFF5722Yowler|r and loot him for his |cFF00BCD4Blackrock Invasion Plans.|r
.goto 49,26.86,21.97
.complete 26545,1 
.complete 26545,2 
.target Yowler
step
.goto 49,26.54,21.30,10,0
.goto 49,28.54,22.07,15,0
.goto 49,32.64,24.98,15,0
.goto 49,36.32,30.43
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFCrates|r |cFFfa9602on the ground.|r
.complete 26513,1 
step
.line 49,29.92,22.61,30.77,21.80,31.46,23.38,33.10,24.17,33.23,26.12,34.03,27.36,35.38,28.58,36.02,29.48,36.80,29.55,37.17,31.12,36.43,31.89,33.93,35.47,35.73,31.75,34.52,27.78.34.03,27.36.31.56,25.76,29.90,23.07
.goto 49,29.92,22.61,30,0
.goto 49,30.77,21.80,30,0
.goto 49,31.46,23.38,30,0
.goto 49,33.10,24.17,30,0
.goto 49,33.23,26.12,30,0
.goto 49,34.03,27.36,30,0
.goto 49,35.38,28.58,30,0
.goto 49,36.02,29.48,30,0
.goto 49,36.80,29.55,30,0
.goto 49,37.17,31.12,30,0
.goto 49,36.43,31.89,30,0
.goto 49,35.33,33.54,30,0
.goto 49,33.93,35.47,30,0
.goto 49,35.33,33.54,30,0
.goto 49,35.73,31.75,30,0
.goto 49,35.59,29.85,30,0
.goto 49,34.52,27.78,30,0
.goto 49,34.03,27.36,30,0
.goto 49,31.56,25.76,30,0
.goto 49,31.04,23.93,30,0
.goto 49,29.90,23.07,30,0
.goto 49,29.92,22.61
.cast 80704 >>|cFFFCDC00Stand still|r and use the |T332402:0|t[Ettin Control Orb] on a |cRXP_ENEMY_Canyon Ettin|r to mind control it.
.unitscan Canyon Ettin
.use 58895
.isOnQuest 26520
step
#sticky
#label ForemanOslow
>>|cFFFCDC00Use the|r |T332402:0|t[Ettin Control Orb] |cFFFCDC00on the|r |cFF00FF25Canyon Ettin|r |cFFFCDC00again|r
.complete 26520,1 
.target Subdued Canyon Ettin
.use 58895
step
.goto 49,31.86,44.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Marris.|r
.turnin 26513 >>Turn in Like a Fart in the Wind
.target Marshal Marris
step
#requires ForemanOslow
#completewith next
.goto 49,28.84,43.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Karen.|r
.vendor >>|cRXP_WARN_Vendor and Repair.|r
.target Karen
step
#requires ForemanOslow
#completewith next
.goto 49,28.49,42.44,10,0
.goto 49,27.99,41.27,10 >>Go |cFFfa9602inside the Town Hall.|r
step
#requires ForemanOslow
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Magistrate Solomon|r and |cFF00FF25Colonel Troteman.|r
.turnin 26520 >>Turn in Saving Foreman Oslow
.turnin 26545 >>Turn in Yowler Must Die!
.goto 49,28.91,41.12
.accept 26567 >>Accept John J. Keeshan
.goto 49,28.66,40.73
.target Magistrate Solomon
.target Colonel Troteman
step
#completewith next
.goto 49,27.99,41.27,10,0
.goto 49,28.49,42.44,10 >>Exit |cFFfa9602the Town Hall.|r
step
#completewith next
.goto 49,26.06,42.58,10,0
.goto 49,26.34,42.20,10 >>Go |cFFfa9602inside the Inn.|r
step
.goto 49,26.28,40.60,10,0
.goto 49,26.30,40.14
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25John J. Keeshan|r |cFFfa9602in the basement.|r
.turnin 26567 >>Turn in John J. Keeshan
.accept 26568 >>Accept This Ain't My War
.target John J. Keeshan
step
#completewith next
.goto 49,26.34,42.20,10,0
.goto 49,26.06,42.58,10 >>Exit |cFFfa9602the Inn.|r
step
#completewith next
.goto 49,28.49,42.44,10,0
.goto 49,27.99,41.27,10 >>Go |cFFfa9602inside the Town Hall.|r
step
.goto 49,28.66,40.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Colonel Troteman.|r
.turnin 26568 >>Turn in This Ain't My War
.accept 26571 >>Accept Weapons of War
.accept 26586 >>Accept In Search of Bravo Company
.target Colonel Troteman
step
#completewith next
.goto 49,27.99,41.27,10,0
.goto 49,28.49,42.44,10 >>Exit |cFFfa9602the Town Hall.|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Foreman Oslow|r and |cFF00FF25Marshal Marris.|r
.accept 26569 >>Accept Surveying Equipment
.goto 49,29.65,44.54
.accept 26570 >>Accept Render's Army
.goto 49,29.73,44.52
.target Foreman Oslow
.target Marshal Marris
step
.goto 49,37.74,34.14,30 >> Check for |cFFFF5722Chatter|r(Rare).
.unitscan Chatter
.isOnQuest 26570
step
#completewith Giblets
>>Kill |cFFFF5722Blackrock Orcs|r
>>|cRXP_WARN_Don't focus on this quest.|r
.complete 26570,1 
.target Blackrock Scout
.target Blackrock Renegade
step
#completewith next
>>Kill |cFFFF5722Dire Condors|r and loot them for their |cFF00BCD4Condor Giblets.|r
.complete 26506,2 
.target Dire Condor
step
.goto 49,47.53,41.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Messner.|r
.turnin 26586 >>Turn in In Search of Bravo Company
.accept 26587 >>Accept Breaking Out is Hard to Do
.target Messner
step
.goto 49,51.61,41.39
>>Kill |cFFFF5722Murdunk|r and |cFFFF5722Homurk|r and loot them for the |cFF00BCD4Keeshan's Bow|r and |cFF00BCD4Keeshan's Survival Knife.|r
.complete 26571,2 
.complete 26571,1 
.target Murdunk
.target Homurk
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 26571 >>Turn in Weapons of War
.accept 26573 >>Accept His Heart Must Be In It
step
.goto 49,49.24,38.00
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFKey|r |cFFfa9602on the tree stump.|r
>>|cRXP_WARN_|cFFFCDC00Avoid the Blackrock Worg Captain and Worgs|r|r
.complete 26587,1 
.unitscan Blackrock Worg Captain
step
.goto 49,47.53,41.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Messner.|r
.turnin 26587 >>Turn in Breaking Out is Hard to Do
.timer 3,Messner RP
.accept 26560 >>Accept Jorgensen
.target Messner
step
#label Giblets
.goto 49,44.86,34.39,30,0
.goto 49,40.79,30.85
>>Kill |cFFFF5722Dire Condors|r and loot them for their |cFF00BCD4Condor Giblets.|r
.complete 26506,2 
.target Dire Condor
step
#completewith Spyglasses
.goto 49,45.03,27.67,40,0
.goto 49,42.88,21.30,30,0
.goto 49,43.35,18.00,30,0
>>Kill |cFFFF5722Blackrock Orcs|r (primarily |cFFFF5722Trackers|r) and loot the |cFFFF5722Trackers|r for their |cFF00BCD4Blackrock Spyglass.|r
.complete 26570,1 
.complete 26569,1 
.target Blackrock Tracker
.target Blackrock Summoner
step
#completewith next
>>Kill |cFFFF5722Great Goretusks|r and loot them for their |cFF00BCD4Goretusk Kidneys.|r
.complete 26506,3 
.target Great Goretusk
step
.goto 49,43.41,11.26
>>Kill |cFFFF5722Utroka the Keymistress|r and loot her for the |cFF00BCD4Jorgensen's Cage Key.|r
.complete 26560,1 
.target Utroka the Keymistress
step
.goto 49,42.44,18.38,40,0
.goto 49,45.03,27.67
>>Kill |cFFFF5722Great Goretusks|r and loot them for their |cFF00BCD4Goretusk Kidneys|r
.complete 26506,3 
.target Great Goretusk
step
.goto 49,33.54,11.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jorgensen|r |cFFfa9602inside of the Cage.|r
>>Check for |cFFFF5722Kazon|r(Rare) and a |cFFDB2EEFChest|r nearby.
.turnin 26560 >>Turn in Jorgensen
.accept 26561 >>Accept Krakauer
.target Jorgensen
.unitscan Kazon
step
#completewith next
.goto 49,30.81,9.45,15,0
.goto 49,29.82,9.57,15,0
.goto 49,28.32,10.90,15 >>Go |cFFfa9602inside the cave|r toward the Blackrock Coffer.
step
#label BlackrockC
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFBlackrock Coffer|r |cFFfa9602on the ground.|r
>>Kill |cFFFF5722Ritualist Tarak|r.
>>|cRXP_WARN_Check for a |cFFDB2EEFChest|r near him.|r
.complete 26573,1 
.complete 26573,2 
.goto 49,26.58,10.53
.complete 26561,1 
.goto 49,26.04,10.45
.target Ritualist Tarak
step
.goto 49,25.91,10.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Krakauer.|r
.turnin 26561 >>Turn in Krakauer
.target Krakauer

step
.goto 49,26.75,13.61
>>Wait out the RP. Talk to |cFF00FF25Krakauer|r again
>>If you're in combat with |cFFFF5722Ritualist Tarak|r again, run away from him
.accept 26562 >>Accept And Last But Not Least... Danforth
.target Krakauer
step
.goto 49,25.42,14.77,15,0
.goto 49,26.26,16.78,15,0
.goto 49,27.61,18.30
>>Kill |cFFFF5722Overlord Barbarius|r and loot him for the |cFF00BCD4Blackrock Lever Key.|r
>>|cFFFCDC00Make sure your Guardians teleport down when you jump down|r
.complete 26562,1 
.complete 26562,2 
.target Overlord Barbarius
step
#completewith next
.goto 49,27.77,17.93
.cast 80887 >>|cFFFCDC00Click on the |cRXP_PICK_Lever|r |cFFfa9602on the ground.|r
.isOnQuest 26562
step
.goto 49,28.33,17.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Danforth.|r
.turnin 26562 >>Turn in And Last But Not Least... Danforth
.accept 26563 >>Accept Return of the Bravo Company
.target Danforth
step
.goto 49,28.72,17.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Danforth|r. |cFFFCDC00You must be out of combat for him to appear|r
.accept 26563 >>Accept Return of the Bravo Company
.target Danforth
step
#completewith next
.goto 49,30.81,9.45,15 >> |cFFfa9602Exit the cave.|r
step
.goto 49,45.03,27.67,40,0
.goto 49,42.88,21.30,30,0
.goto 49,43.35,18.00
>>Kill |cFFFF5722Blackrock Orcs|r (primarily |cFFFF5722Trackers|r) and loot the |cFFFF5722Trackers|r for their |cFF00BCD4Blackrock Spyglasses|r
.complete 26570,1 
.complete 26569,1 
.target Blackrock Tracker
.target Blackrock Summoner
step
#completewith next
.hs >> Hearth |cFFfa9602to Lakeshire.|r
step
.goto 49,26.45,42.03
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kimberly.|r
.vendor >>Vendor and Repair
.isOnQuest 26573
.target Kimberly
step
#completewith next
.goto 49,28.49,42.44,10,0
.goto 49,27.99,41.27,10 >>Go |cFFfa9602inside the Town Hall.|r
step
.goto 49,28.66,40.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Colonel Troteman.|r
.turnin 26563 >>Turn in Return of the Bravo Company
.turnin 26573 >>Turn in His Heart Must Be In It
.accept 26607 >>Accept They Drew First Blood
.target Colonel Troteman
step
#completewith next
.goto 49,27.99,41.27,10,0
.goto 49,28.49,42.44,10 >>Exit |cFFfa9602the Town Hall.|r
step
#completewith next
.goto 49,26.06,42.58,10,0
.goto 49,26.34,42.20,10 >>Go |cFFfa9602inside the Inn.|r
step
.goto 49,26.28,40.60,10,0
.goto 49,26.33,40.11
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25John|r |cFFfa9602in the basement.|r
.turnin 26607 >>Turn in They Drew First Blood
.accept 26616 >>Accept It's Never Over
.target John J. Keeshan
step
#completewith next
.goto 49,26.34,42.20,10,0
.goto 49,26.06,42.58,10 >>Exit |cFFfa9602the Inn.|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Foreman Oslow|r and |cFF00FF25Marshal Marris.|r
.turnin 26569 >>Turn in Surveying Equipment
.goto 49,29.65,44.54
.turnin 26570 >>Turn in Render's Army
.goto 49,29.73,44.52
.target Foreman Oslow
.target Marshal Marris
step << DarkIronDwarf
#completewith next
.zone 84 >>Use the |T1786409:0|t|cFF00FF25Mole Machine|r and |TInterface/cursor/crosshair/interact.blp:20|tinteract with it.
.skipgossip 143925,1,2
.xp <20,1
.pve
step << Monk
#completewith next
.goto 379,48.96,43.36
.zone 84 >>Use |T775462:0|tZen Pilgrimage and |TInterface/cursor/crosshair/interact.blp:20|tClick the |cRXP_PICK_portal to Stormwind.|r
.xp <20,1
step << Monk
#completewith next
.goto 84,49.45,86.60,8,0
.goto 84,49.51,86.67,10 >>Go through the portal and exit the Mage Tower
step << !Monk !DarkIronDwarf
#completewith next
.goto 49,29.42,53.76
.fly Stormwind >>Fly to Stormwind
.target Ariena Stormfeather
.xp <20,1
step
+|cFFFCDC00Open Up your Talents (Default N) and turn on Warmode to gain a lot of increased XP and extra talents.
>>|cRXP_WARN_Skip this step if you don't want to turn on Warmode|r
.pve
.xp <20,1
step
#completewith next
.goto 84,70.94,72.45,-1
.goto 49,29.42,53.76,-1
.fly Goldshire >>Fly |cFFfa9602to Goldshire.|r
.target Dungar Longdrink
.target Ariena Stormfeather
.zoneskip 37
.xp <20,1
step
.goto 37,42.11,65.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Dughan.|r
.turnin 76 >>Turn in The Jasperlode Mine
.target Marshal Dughan
.xp <20,1
step
#completewith Boat
.hs >> Hearth |cFFfa9602to Lakeshire.|r
.cooldown item,6948,>0
.zoneskip 49
.xp <20,1
step
#completewith next
.goto 37,41.71,64.64
.fly Lakeshire >>Fly |cFFfa9602to Lakeshire.|r
.target Bartlett the Brave
.cooldown item,6948,<0
.zoneskip 49
.xp <20,1
step
#label Boat
.goto 49,34.43,45.91
.vehicle >> Get into the |cFFDB2EEFBoat|r
.timer 43,It's Never Over RP
.isOnQuest 26616
step
.goto 49,52.92,54.63
>>Wait out the RP. Manually leave the boat when the timer completes.
.complete 26616,1 
step
#completewith Muckdwellers
.goto 49,52.92,54.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Arlen.|r
.fp >>Get the Camp Everstill Flight Path
.target Arlen Marsters
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25John|r, |cFF00FF25Krakauer|r, |cFF00FF25Messner|r, and |cFF00FF25Danforth.|r
.turnin 26616 >>Turn in It's Never Over
.accept 26639 >>Accept Point of Contact: Brubaker
.goto 49,52.54,55.41
.accept 26636 >>Accept Bravo Company Field Kit: Camouflage
.goto 49,52.40,55.41
.accept 26637 >>Accept Bravo Company Field Kit: Chloroform
.goto 49,52.43,55.53
.accept 26638 >>Accept Hunting the Hunters
.goto 49,52.53,55.56
.target John J. Keeshan
.target Krakauer
.target Messner
.target Danforth
step
#label Muckdwellers
.goto 49,48.22,55.19,40,0
.goto 49,48.26,58.41,40,0
.goto 49,46.58,58.05,40,0
.goto 49,46.93,56.16,40,0
.goto 49,38.66,60.13,40,0
.goto 49,38.18,52.91,40,0
.goto 49,43.98,52.86,40,0
.goto 49,44.35,49.35
>>Kill |cFFFF5722Muckdwellers|r underwater and loot them for their |cFF00BCD4Glands|r.
>>|cFFFCDC00Avoid Ol' Gummers|r
.complete 26637,1 
.target Muckdweller
.unitscan Ol' Gummers
step
.goto 49,41.18,68.52,40,0
.goto 49,42.56,70.35,40,0
.goto 49,44.39,67.11,40,0
.goto 49,46.65,71.03,40,0
.goto 49,47.14,66.67,40,0
.goto 49,53.50,70.16,40,0
.goto 49,53.53,66.96,40,0
.goto 49,41.18,68.52
>>Kill |cFFFF5722Blackrock Hunters|r. |cFFFCDC00They are stealthed|r
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFPile of Leaves|r and |cFFDB2EEFFox Poop|r |cFFfa9602on the ground.|r
>>Keep an eye out for a |cFFDB2EEFChest|r that may be in the Murloc Camp
.complete 26638,1 
.complete 26636,1 
.complete 26636,2 
.target Blackrock Hunter
step
.goto 49,53.05,67.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brubaker.|r
>>|cRXP_WARN_Keep an eye out for a Chest nearby.|r
.turnin 26639 >>Turn in Point of Contact: Brubaker
.accept 26640 >>Accept Unspeakable Atrocities
.target Brubaker
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Messner|r, |cFF00FF25Krakauer|r, |cFF00FF25Danforth|r, and |cFF00FF25John J. Keeshan.|r
.turnin 26637 >>Turn in Bravo Company Field Kit: Chloroform
.goto 49,52.43,55.53
.turnin 26636 >>Turn in Bravo Company Field Kit: Camouflage
.goto 49,52.40,55.41
.turnin 26638 >>Turn in Hunting the Hunters
.goto 49,52.53,55.56
.turnin 26640 >>Turn in Unspeakable Atrocities
.accept 26646 >>Accept Prisoners of War
.goto 49,52.54,55.41
.target Messner
.target Krakauer
.target Danforth
.target John J. Keeshan
step << DarkIronDwarf
#completewith next
.zone 84 >>Cast |T1786409:0|t|cFF00FF25Mole Machine|r and interact with it
.skipgossip 143925,1,2
.xp <20,1
.pve
step << Monk
#completewith next
.goto 379,48.96,43.36
.zone 84 >>Cast |T775462:0|tZen Pilgrimage. Take the portal to Stormwind
.xp <20,1
step << Monk
#completewith next
.goto 84,49.45,86.60,8,0
.goto 84,49.51,86.67,10 >>Go through the portal. Exit the Mage Tower
step << !Monk !DarkIronDwarf
#completewith next
.goto 49,52.92,54.64
.fly Stormwind >>Fly to Stormwind
.target Arlen Marsters
.xp <20,1
step
+|cFFFCDC00Open Up your Talents (Default N) and turn on Warmode to gain a lot of increased XP and extra talents. Skip this step if you don't want to turn on Warmode|r
.pve
.xp <20,1
step
#completewith next
.goto 84,70.94,72.45,-1
.goto 49,52.92,54.64,-1
.fly Goldshire >>Fly |cFFfa9602to Goldshire.|r
.target Dungar Longdrink
.target Arlen Marsters
.zoneskip 37
.xp <20,1
step
.goto 37,42.11,65.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Dughan.|r
.turnin 76 >>Turn in The Jasperlode Mine
.target Marshal Dughan
.xp <20,1
step
#completewith next
.goto 37,41.71,64.64,-1
.goto 49,52.92,54.64,-1
.fly Lakeshire >>Fly to Lakeshire
.target Arlen Marsters
.target Bartlett the Brave
step
#veteran
.goto 49,33.30,52.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lindsay.|r.
>>|cRXP_WARN_Skip this step if you don't have level 25 Pet Battle Pets.|r
.accept 31781 >>Accept Lindsay
.isQuestTurnedIn 31903
.target Lindsay
step
#veteran
.goto 49,33.30,52.57
>>Defeat |cFFFF5722Lindsay|r in a Pet Battle.
.complete 31781,1 
.skipgossip 65651,1
.isOnQuest 31781
.target Lindsay
step
#veteran
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 31781 >>Turn in Lindsay
.isQuestComplete 31781
step
#completewith GnollOrders2
>>Kill |cFFFF5722Redridge Thrashers|r, |cFFFF5722Brutes|r, and |cFFFF5722Mongrels.|r
.complete 26504,1 
.target Redridge Thrasher
.target Redridge Brute
.target Redridge Mongrel
step
.goto 49,35.45,60.53,30 >>Check for |cFFFF5722Snarlflare|r (Rare) |cFFfa9602on the Mountain.|r
.unitscan Snarlflare
.isOnQuest 26504
step
.goto 49,30.14,61.20,30 >>Check for |cFFFF5722Ribchaser|r (Rare) |cFFfa9602in the camp.|r
.unitscan Ribchaser
.isOnQuest 26504
step
.goto 49,30.56,62.71
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFMap|r |cFFfa9602on the ground.|r
.complete 26503,3 
step
#label GnollOrders2
.goto 49,28.03,74.88
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFGnoll Orders|r on the ground. Check for a |cFFDB2EEFChest|r nearby
.complete 26503,2 
step
.goto 49,32.82,73.67,40,0
.goto 49,33.08,59.41
>>Kill |cFFFF5722Redridge Thrashers|r, |cFFFF5722Brutes|r, and |cFFFF5722Mongrels.|r
.complete 26504,1 
.mob Redridge Thrasher
.mob Redridge Brute
.mob Redridge Mongrel
step
.goto 49,24.37,71.20,40 >>Check for |cFFFF5722Gnollfraster|r(Rare).
.unitscan Gnollfeaster
.isOnQuest 26504
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Darcy|r and |cFF00FF25Parker.|r
.turnin 26506 >>Turn in Franks and Beans
.goto 49,15.62,65.33
.turnin 26503 >>Turn in Still Assessing the Threat
.turnin 26504 >>Turn in WANTED: Redridge Gnolls
.accept 26505 >>Accept in Parker's Report
.goto 49,15.42,65.91,8,0
.goto 49,15.32,64.59
.target Darcy Parker
.target Watch Captain Parker
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Alliance 10-60
#name 3A_Duskwood
#displayname Chapter 3 - Duskwood
#next 4A_Northern Stranglethorn
#fresh 30
#veteran
<<Alliance
step
.goto 47,93.30,12.00
.zone 47 >> Travel |cFFfa9602to Duskwood|r
step
#completewith next
.goto 47,74.23,26.09,40,0
.goto 47,77.32,36.47,15 >>Travel to |cFFfa9602Manor Mistmantle.|r Check for a |cFFDB2EEFChest|r |cFFfa9602in and around the House.|r
step
.goto 47,78.74,44.53,8,0
.goto 47,79.09,44.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Tobias|r |cFFfa9602inside the house.|r
.accept 26666 >>Accept The Legend of Stalvan
.target Tobias Mistmantle
step
.goto 47,87.43,35.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Abercrombie.|r
.accept 26653 >>Accept Supplies from Darkshire
.target Abercrombie
step
#completewith next
.goto 47,87.98,33.16,20,0
.goto 47,88.1,31.33,20,0
.goto 47,90.98,30.53,30 >>Check for the |cFFFF5722Unknown Soldier|r(Rare).
.unitscan Unknown Soldier
step << !DarkIronDwarf !KulTiran !LightforgedDraenei !Mechagnome !VoidElf
#completewith Kabobs
.goto 47,77.48,44.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Felicia Maline|r
.fp Darkshire >>Get the Darkshire Flight Path
.target Felicia Maline
.isQuestTurnedIn 12801 << DK
step
.goto 47,75.56,45.37,8,0
.goto 47,75.83,45.26
>>Talk to |cFF00FF25Madame Eva|r |cFFfa9602inside the house.|r
.turnin 26653 >>Turn in Supplies from Darkshire
.accept 26652 >>Accept Ghost Hair Thread
.target Madame Eva
step
#completewith next
.goto 47,73.82,45.95,8,0
.goto 47,74.07,45.32,8 >>Go |cFFfa9602inside the Inn.|r
step
#completewith Daltry1
.goto 47,73.87,44.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Innkeeper Trelayne.|r
.home >>Set your Hearthstone to Scarlet Raven Tavern
.target Innkeeper Trelayne
step
#label Kabobs
.goto 47,73.74,43.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Chef Grual.|r
.accept 26620 >>Accept Seasoned Wolf Kabobs
.accept 26623 >>Accept Dusky Crab Cakes
.target Chef Grual
step
#completewith Daltry1
.goto 47,74.07,45.32,8,0
.goto 47,73.82,45.95,8>>Exit |cFFfa9602the Inn.|r
step
#label Daltry1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Clerk Daltry|r and |cFF00FF25Commander Althea Ebonlocke.|r
.turnin 26666 >>Turn in The Legend of Stalvan
.accept 26667 >>Accept The Stolen Letters
.goto 47,72.44,46.91
.turnin 26728 >>Turn in Hero's Call: Duskwood!
.accept 26618 >>Accept Wolves at Our Heels
.goto 47,73.53,46.92
.target Clerk Daltry
.target Commander Althea Ebonlocke
.isOnQuest 26728
step
#label Daltry1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Clerk Daltry|r and |cFF00FF25Commander Althea Ebonlocke.|r
.turnin 26666 >>Turn in The Legend of Stalvan
.accept 26667 >>Accept The Stolen Letters
.goto 47,72.44,46.91
.accept 26618 >>Accept Wolves at Our Heels
.goto 47,73.53,46.92
.target Clerk Daltry
.target Commander Althea Ebonlocke
step
.goto 47,75.33,48.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Calor.|r
.accept 26688 >>Accept Worgen in the Woods
.target Calor
step << DarkIronDwarf
#completewith next
.zone 84 >>Use |T1786409:0|t|cFF00FF25Mole Machine|r and |TInterface/cursor/crosshair/interact.blp:20|tinteract with it.
.skipgossip 143925,1,2
.xp <20,1
.pve
step << Monk
#completewith next
.goto 379,48.96,43.36
.zone 84 >>Cast |T775462:0|tZen Pilgrimage and |TInterface/cursor/crosshair/interact.blp:20|tClick |cRXP_PICK_the portal to Stormwind.|r
.xp <20,1
step << Monk
#completewith next
.goto 84,49.45,86.60,8,0
.goto 84,49.51,86.67,10 >>Go through the portal and exit the Mage Tower
step << !Monk !DarkIronDwarf
#completewith next
.goto 49,29.42,53.76
.fly Stormwind >>Fly |cFFfa9602to Stormwind.|r
.target Ariena Stormfeather
.xp <20,1
step
+|cFFFCDC00Open Up your Talents (Default N) and turn on Warmode to gain a lot of increased XP and extra talents. Skip this step if you don't want to turn on Warmode|r
.pve
.xp <20,1
step
#completewith next
.goto 84,70.94,72.45,-1
.goto 47,77.48,44.28,-1
.fly Goldshire >>Fly |cFFfa9602to Goldshire.|r
.target Dungar Longdrink
.target Felicia Maline
.zoneskip 37
.xp <20,1
step
.goto 37,42.11,65.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Dughan.|r
.turnin 76 >>Turn in The Jasperlode Mine
.target Marshal Dughan
.xp <20,1
step
.goto 37,41.71,64.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bartlett the Brave.|r
.fly Darkshire >>Fly |cFFfa9602to Darkshire|r
.target Bartlett the Brave
.zoneskip 47
.xp <20,1
step
#completewith next
>>Kill |cFFFF5722Venom Web Spiders|r and loot them for their |cFF00BCD4Dusky Lumps.|r
.complete 26623,1 
.mob Venom Web Spider
step
#completewith Letters
>>Kill |cFFFF5722Nightbane Worgen.|r
.complete 26688,1 
.mob Nightbane Worgen
step
#completewith next
.goto 47,72.6,45.91,30,0
.goto 47,69.23,44.74,30,0
.goto 47,58.12,30.05,30,0
+Check for |cFFFF5722Fenros|r (Rare) |cFFfa9602in and around the Worgen Camps.|r
.isOnQuest 26623
.unitscan Fenros
step
#label Letters
.goto 47,61.24,40.50
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFBundle of Letters|r |cFFfa9602on the ground.|r
*|cRXP_WARN_Make sure to quickly check for a |cFFDB2EEFChest|r |cFFfa9602in and around the camp.|r|r
.complete 26667,1 
step
.goto 47,64.12,51.62
>>Kill |cFFFF5722Nightbane Worgen|r
.complete 26688,1 
.mob Nightbane Worgen
step
#completewith next
.goto 47,65.54,30.32,40,0
.goto 47,73.29,20.23,40,0
.goto 47,63.90,19.41,40,0
>>Kill |cFFFF5722Dire Wolves|r and loot them for their |cFF00BCD4Wolf Skirt Steaks.|r
>>|cRXP_WARN_Check for |cFFFF5722Lupos|r (Rare), who is patrolling around the |cRXP_ENEMY_Wolves|r and |cRXP_ENEMY_Spiders.|r|r
.complete 26618,1 
.complete 26620,1 
.mob Dire Wolf
.unitscan Lupos
step
.goto 47,68.35,19.48,40,0
.goto 47,60.93,27.34,40,0
.goto 47,65.54,30.32,40,0
.goto 47,73.29,20.23,40,0
.goto 47,63.90,19.41,40,0
.goto 47,68.35,19.48,40,0
.goto 47,60.93,27.34,40,0
.goto 47,65.54,30.32,40,0
.goto 47,73.29,20.23,40,0
.goto 47,63.90,19.41
>>Kill |cFFFF5722Venom Web Spiders|r and loot them for their |cFF00BCD4Dusky Lump.|r
.complete 26623,1 
.mob Venom Web Spider
step
.goto 47,59.00,20.72,40,0
.goto 47,68.35,19.48,40,0
.goto 47,60.93,27.34,40,0
.goto 47,65.54,30.32,40,0
.goto 47,59.00,20.72,40,0
.goto 47,63.90,19.41,40,0
.goto 47,68.35,19.48,40,0
.goto 47,60.93,27.34,40,0
.goto 47,65.54,30.32,40,0
.goto 47,59.00,20.72
>>Kill |cFFFF5722Dire Wolves|r and loot them for their |cFF00BCD4Wolf Skirt Steaks.|r
>>|cRXP_WARN_Check for |cFFFF5722Lupos|r (Rare), who is patrolling around the |cRXP_ENEMY_Wolves|r and |cRXP_ENEMY_Spiders.|r|r
.complete 26618,1 
.complete 26620,1 
.target Dire Wolf
.unitscan Lupos
step
.goto 37,82.95,84.82,40 >>Check for |cFFFF5722Bushtail|r(Rare).
.unitscan Bushtail
.isOnQuest 26620
step
.goto 37,74.42,85.99,40,0
.goto 37,66.52,84.48,40	>>Check for |cFFFF5722Terrapis|r(Rare).
.unitscan Terrapis
.isOnQuest 26620
step
.goto 37,69.32,79.31,30 >>Check for |cFFFF5722Snoot the Rooter|r(Rare).
.unitscan Snoot the Rooter
.isOnQuest 26620
step
#completewith Grual
.hs >> Hearthstone |cFFfa9602to Darkshire.|r
.cooldown item,6948,>0
step
.goto 47,73.75,43.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Chef Grual.|r
.turnin 26620 >>Turn in Seasoned Wolf Kabobs
.turnin 26623 >>Turn in Dusky Crab Cakes
.target Chef Grual
.cooldown item,6948,<0
step
#label Grual
.goto 47,73.75,43.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Chef Grual.|r
.turnin 26620 >>Turn in Seasoned Wolf Kabobs
.turnin 26623 >>Turn in Dusky Crab Cakes
.target Chef Grual
step
#completewith next
.goto 47,74.07,45.32,8,0
.goto 47,73.82,45.95,8>>Exit |cFFfa9602the Inn.|r
step
.goto 47,73.13,44.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Avette Fellwood.|r
.vendor 228 >>Vendor and Repair
.target Avette Fellwood
.isOnQuest 26667
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Clerk Daltry|r and |cFF00FF25Commander Althea Ebonlocke.|r
.turnin 26667 >>Turn in The Stolen Letters
.accept 26669 >>Accept In A Dark Corner
.goto 47,72.44,46.91
.turnin 26618 >>Turn in Wolves at Our Heels
.accept 26645 >>Accept The Night Watch
.goto 47,73.53,46.92
.target Clerk Daltry
.target Commander Althea Ebonlocke
step
.goto 47,75.33,48.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Calor.|r
.turnin 26688 >>Turn in Worgen in the Woods
.accept 26689 >>Accept The Rotting Orchard
.target Calor
step << DarkIronDwarf
#completewith next
.zone 84 >>Use |T1786409:0|t|cFF00FF25Mole Machine|r and |TInterface/cursor/crosshair/interact.blp:20|tinteract with it.
.skipgossip 143925,1,2
.xp <20,1
.pve
step << Monk
#completewith next
.goto 379,48.96,43.36
.zone 84 >>Cast |T775462:0|tZen Pilgrimage and |TInterface/cursor/crosshair/interact.blp:20|tClick the |cRXP_PICK_portal to Stormwind.|r
.xp <20,1
step << Monk
#completewith next
.goto 84,49.45,86.60,8,0
.goto 84,49.51,86.67,10 >>Go through the portal and exit the Mage Tower.
step << !Monk !DarkIronDwarf
#completewith next
.goto 49,29.42,53.76
.fly Stormwind >>Fly |cFFfa9602to Stormwind.|r
.target Ariena Stormfeather
.xp <20,1
step
+|cFFFCDC00Open Up your Talents (Default N) and turn on Warmode to gain a lot of increased XP and extra talents. Skip this step if you don't want to turn on Warmode|r
.pve
.xp <20,1
step
#completewith next
.goto 84,70.94,72.45,-1
.goto 47,77.48,44.28,-1
.fly Goldshire >>Fly |cFFfa9602to Goldshire.|r
.target Dungar Longdrink
.target Felicia Maline
.zoneskip 37
.xp <20,1
step
.goto 37,42.11,65.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Dughan.|r
.turnin 76 >>Turn in The Jasperlode Mine
.target Marshal Dughan
.xp <20,1
step
.goto 37,41.71,64.64
.fly Darkshire >>Fly |cFFfa9602to Darkshire.|r
.target Bartlett the Brave
.zoneskip 47
.xp <20,1
step
.goto 47,79.53,47.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Viktori Prism'Antras.|r
.accept 26683 >>Accept Look To The Stars
.target Viktori Prism'Antras
step
#completewith next
>>Kill |cFFFF5722Rotting Horrors|r
>>|cRXP_WARN_Check for |cFFFF5722Watcher Eva|r(Rare) |cFFfa9602in and around the house.|r|r
.complete 26645,1 
.mob Rotting Horror
.unitscan Watcher Eva
step
.goto 47,81.66,59.16,8,0
.goto 47,81.92,58.98,5,0
.goto 47,82.05,59.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Mary|r |cFFfa9602inside the house.|r
.turnin 26652 >>Turn in Ghost Hair Thread
.accept 26654 >>Accept Return the Comb
.turnin 26683 >>Turn in Turn in Look To The Stars
.accept 26684 >>Accept The Insane Ghoul
.target Blind Mary
step
.loop 30,47,82.30,61.22,82.45,56.25,80.91,56.65,79.48,60.41,82.30,61.22
>>Kill |cFFFF5722Rotting Horrors|r
>>|cRXP_WARN_Check for |cFFFF5722Watcher Eva|r(Rare) |cFFfa9602in and around the house.|r|r
.complete 26645,1 
.mob Rotting Horror
.unitscan Watcher Eva
step
.goto 47,75.56,45.37,8,0
.goto 47,75.83,45.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Madame Eva|r |cFFfa9602inside the house.|r
.turnin 26654 >>Turn in Return the Comb
.accept 26655 >>Accept Deliver the Thread
.target Madame Eva
step
.goto 47,87.43,35.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Abercrombie.|r
.turnin 26655 >>Turn in Deliver the Thread
.accept 26660 >>Accept Zombie Juice
.target Abercrombie
step
#completewith next
.goto 47,87.98,33.16,20,0
.goto 47,88.1,31.33,20,0
.goto 47,90.98,30.53,30 >>|cRXP_WARN_Check for the |cFFFF5722Unknown Soldier|r(Rare).|r
.unitscan Unknown Soldier
step
#completewith next
.goto 47,73.82,45.95,8,0
.goto 47,74.07,45.32,8 >>Go |cFFfa9602inside the Inn.|r
step
.goto 47,74.09,44.71
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Tavernkeep Smitts.|r
.turnin 26660 >>Turn in Zombie Juice
.accept 26661 >>Accept Gather Rot Blossoms
.mob Tavernkeep Smitts
step
#completewith next
.goto 47,74.07,45.32,8,0
.goto 47,73.82,45.95,8 >>Exit |cFFfa9602the Inn.|r
step
.goto 47,73.53,46.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Commander Althea Ebonlocke.|r
.turnin 26645 >>Turn in The Night Watch
.accept 26686 >>Accept Bones That Walk
.target Commander Althea Ebonlocke
step << DarkIronDwarf
#completewith next
.zone 84 >>Cast |T1786409:0|t|cFF00FF25Mole Machine|r. Talk to it
.skipgossip 143925,1,2
.xp <20,1
.pve
step << Monk
#completewith next
.goto 379,48.96,43.36
.zone 84 >>Cast |T775462:0|tZen Pilgrimage. Take the portal to Stormwind
.xp <20,1
step << Monk
#completewith next
.goto 84,49.45,86.60,8,0
.goto 84,49.51,86.67,10 >>Go through the portal. Exit the Mage Tower
step << !Monk !DarkIronDwarf
#completewith next
.goto 49,29.42,53.76
.fly Stormwind >>Fly to Stormwind
.target Ariena Stormfeather
.xp <20,1
step
+|cFFFCDC00Open Up your Talents (Default N) and turn on Warmode to gain a lot of increased XP and extra talents. Skip this step if you don't want to turn on Warmode|r
.pve
.xp <20,1
step
#completewith next
.goto 84,70.94,72.45,-1
.goto 47,77.48,44.28,-1
.fly Goldshire >>Fly |cFFfa9602to Goldshire.|r
.target Dungar Longdrink
.target Felicia Maline
.zoneskip 37
.xp <20,1
step
.goto 37,42.11,65.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Dughan.|r
.turnin 76 >>Turn in The Jasperlode Mine
.target Marshal Dughan
.xp <20,1
step
.goto 37,41.71,64.64
.fly Darkshire >>Fly |cRXP_WARN_to Darkshire.|r
.target Bartlett the Brave
.zoneskip 47
.xp <20,1
step
#completewith next
>>Kill |cFFFF5722Skeletal Warriors|r and |cFFFF5722Skeletal Mages.|r
>>Check for |cFFFF5722Watcher Eva|r (Rare) near the Central/North side of the Cemetary (if you haven't killed him recently)
>>Loot the |cFFDB2EEFRot Blossoms|r on the ground
.complete 26686,1 
.complete 26686,2 
.complete 26661,1 
.target Skeletal Warrior
.target Skeletal Mage
.unitscan Watcher Eva
step
.goto 47,80.31,71.10,15,0
.goto 47,80.88,71.58
>>Kill the |cFFFF5722Insane Ghoul|r |cFFfa9602inside the Cemetery.|r and loot it for the |cFF00BCD4Mary's Looking Glass.|r
.complete 26684,1 
.target Insane Ghoul
step
.loop 40,47,81.85,68.34,78.33,66.13,77.02,69.85,80.89,74.21,81.85,68.34
>>Kill |cFFFF5722Skeletal Warriors|r and |cFFFF5722Skeletal Mages.|r
>>Check for |cFFFF5722Watcher Eva|r (Rare) near the Central/North side of the Cemetary (if you haven't killed him recently)
>>Loot the |cFFDB2EEFRot Blossoms|r on the ground
.complete 26686,1 
.complete 26686,2 
.complete 26661,1 
.target Skeletal Warrior
.target Skeletal Mage
.unitscan Watcher Eva
step
.goto 47,73.53,74.24,20 >>Check for a |cFFDB2EEFChest|r |cFFfa9602in front of the mine.|r
.isOnQuest 26669
step
#completewith Marus
>>Kill |cFFFF5722Nightbane Shadow Weavers|r
.complete 26689,1 
.target Nightbane Shadow Weavers
step
#completewith next
.goto 47,66.03,75.79,8,0
.goto 47,65.98,76.42,8 >> Go inside the barn
step
.goto 47,66.59,76.44
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFTorn Journal|r |cFFfa9602on the ground.|r Keep an eye out for a |cFFDB2EEFChest|r |cFFfa9602inside the barn.|r
.complete 26669,1 
step
#label Marus
.goto 47,65.32,68.08,8,0
.goto 47,64.98,67.48,8,0
.goto 47,65.72,67.12,8 >>Check for |cFFFF5722Marus|r and a |cFFDB2EEFChest|r |cFFfa9602inside the building.|r
.unitscan Marus
.isOnQuest 26689
step
.goto 47,63.50,76.61,40,0
.goto 47,60.88,73.19,40,0
.goto 47,64.19,65.03,40,0
.goto 47,63.50,76.61,40,0
.goto 47,60.88,73.19,40,0
.goto 47,64.19,65.03,40,0
.goto 47,63.50,76.61
>>Kill |cFFFF5722Nightbane Shadow Weavers|r. Kill |cFFFF5722Marus|r if you see him (and you haven't killed him already)
.complete 26689,1 
.target Nightbane Shadow Weavers
.unitscan Marus
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to|cFF00FF25Althea|r and |cFF00FF25Daltry.|r
.turnin 26686 >>Turn in Bones That Walk
.goto 47,73.53,46.92
.turnin 26669 >>Turn in In A Dark Corner
.accept 26670 >>Accept Roland's Doom
.goto 47,72.44,46.91
.target Commander Althea Ebonlocke
.target Clerk Daltry
step
#completewith next
.goto 47,73.82,45.95,8,0
.goto 47,74.07,45.32,8 >>Go |cFFfa9602inside the Inn|r
step
.goto 47,74.09,44.71
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Tavernkeep Smitts|r
.turnin 26661 >>Turn in Gather Rot Blossoms
.accept 26676 >>Accept Juice Delivery
.target Tavernkeep Smitts
step
#completewith next
.goto 47,74.07,45.32,8,0
.goto 47,73.82,45.95,8 >>Exit |cFFfa9602the Inn.|r
step
.goto 47,75.33,48.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Calor|r
.turnin 26689,1 >>Turn in The Rotting Orchard
.accept 26690 >>Accept Vile and Tainted
.target Calor
step << DarkIronDwarf
#completewith next
.zone 84 >>Cast |T1786409:0|t|cFF00FF25Mole Machine|r. Talk to it
.skipgossip 143925,1,2
.xp <20,1
.pve
step << DarkIronDwarf
.goto 84,70.07,47.25,15,0
.goto 84,68.61,51.24,15,0
.goto 84,67.3,57.41,25,0
.goto 84,67.3,57.41,25,0
.goto 84,68.67,62.27,20,0
.goto 84,65.94,64.29,20,0
.goto 84,64.13,66.9,20,0
.goto 84,68.33,75.04,20,0
.goto 84,70.23,73.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bralla|r. Train |T136103:0|tJourneyman Riding
.skill riding,150 >> Learn Journeyman Riding
.target Bralla Cloudwing
.xp <20,1
step << Monk
#completewith next
.goto 379,48.96,43.36
.zone 84 >>Cast |T775462:0|tZen Pilgrimage. Take the portal to Stormwind
.xp <20,1
step << Monk
#completewith next
.goto 84,49.45,86.60,8,0
.goto 84,49.51,86.67,10 >>Go through the portal. Exit the Mage Tower
step << !Monk !DarkIronDwarf
#completewith next
.goto 49,29.42,53.76
.fly Stormwind >>Fly to Stormwind
.target Ariena Stormfeather
.xp <20,1
step
+|cFFFCDC00Open Up your Talents (Default N) and turn on Warmode to gain a lot of increased XP and extra talents. Skip this step if you don't want to turn on Warmode|r
.pve
.xp <20,1
step
#completewith next
.goto 84,70.94,72.45,-1
.goto 47,77.48,44.28,-1
.fly Goldshire >>Fly |cFFfa9602to Goldshire.|r
.target Dungar Longdrink
.target Felicia Maline
.zoneskip 37
.xp <20,1
step
.goto 37,42.11,65.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Dughan.|r
.turnin 76 >>Turn in The Jasperlode Mine
.target Marshal Dughan
.xp <20,1
step
#completewith Insane
.hs >> Hearth |cFFfa9602to Darkshire.|r
.cooldown item,6948,>0
.zoneskip 47
.xp <20,1
step
.goto 37,41.71,64.64
.fly Darkshire >>Fly |cFFfa9602to Darkshire.|r
.target Bartlett the Brave
.cooldown item,6948,<0
.zoneskip 47
.xp <20,1
step
#label Insane
.goto 47,79.53,47.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Viktori Prism'Antras.|r
.turnin 26684 >>Turn in The Insane Ghoul
.accept 26685 >>Accept Classy Glass
.target Viktori Prism'Antras
step
.goto 47,87.43,35.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Abercrombie.|r
.turnin 26676 >>Turn in Juice Delivery
.accept 26680 >>Accept Ogre Thieves
.target Abercrombie
step
.goto 47,87.98,33.16,20,0
.goto 47,88.1,31.33,20,0
.goto 47,90.98,30.53,30 >>Check for the |cFFFF5722Unknown Soldier|r(Rare).
.unitscan Unknown Soldier
.isOnQuest 26670
step
#completewith JPages
>>Kill |cFFFF5722Nightbane Tainted Ones|r and |cFFFF5722Vile Fangs|r
.complete 26690,2 
.complete 26690,1 
step
#completewith next
.goto 47,73.05,75.17,20 >>Check for a |cFFDB2EEFChest|r in front of the mine. Enter the mine
.isOnQuest 26690
step
#label JPages
.goto 47,73.44,76.86,20,0
.goto 47,74.26,77.92,20,0
.goto 47,73.62,79.21
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFPages|r |cFFfa9602on the ground.|r
>>Check for |cFFFF5722Nefaru|r (Rare) and a |cFFDB2EEFChest|r |cFFfa9602inside the Mine.|r
.complete 26670,1 
step
.goto 47,74.84,67.51,40,0
.goto 47,72.13,67.77,40,0
.goto 47,72.03,74.77,40,0
.goto 47,74.25,73.86,40,0
.goto 47,73.46,73.17,40,0
.goto 47,74.84,67.51,40,0
.goto 47,72.13,67.77,40,0
.goto 47,72.03,74.77,40,0
.goto 47,74.25,73.86,40,0
.goto 47,73.46,73.17
>>Kill |cFFFF5722Nightbane Tainted Ones|r and |cFFFF5722Nightbane Vile Fangs|r
.complete 26690,2 
.complete 26690,1 
.mob Nightbane Tainted One
.mob Nightbane Vile Fang
step
#completewith next
.deathskip >> Die and respawn at the |cFF00FF25Spirit Healer|r
step
.goto 47,72.44,46.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Clerk Daltry.|r
.turnin 26670 >>Turn in Roland's Doom
.accept 26671 >>Accept The Fate of Stalvan Mistmantle
.target Clerk Daltry
step
.goto 47,73.13,44.65
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Avette Fellwood.|r
.vendor 228 >>Vendor and Repair
.target Avette Fellwood
.isOnQuest 26671
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Calor|r and |cFF00FF25Jonathan Carevin.|r
.turnin 26690 >>Turn in Vile and Tainted
.accept 26691 >>Accept Worgen in the Woods
.goto 47,75.33,48.02
.turnin 26691 >>Turn in Worgen in the Woods
.goto 47,75.24,48.23,5,0
.goto 47,75.39,49.00
.target Calor
.target Jonathan Carevin
step
.goto 47,78.74,44.53,8,0
.goto 47,79.09,44.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Tobias Mistmantle|r |cFFfa9602inside the house.|r
.turnin 26671 >>Turn in The Fate of Stalvan Mistmantle
.accept 26672 >>Accept Clawing at the Truth
.target Tobias Mistmantle
step << DarkIronDwarf
#completewith next
.zone 84 >>Use |T1786409:0|t|cFF00FF25Mole Machine|r and |TInterface/cursor/crosshair/interact.blp:20|tinteract with it.
.skipgossip 143925,1,2
.xp <20,1
.pve
step << Monk
#completewith next
.goto 379,48.96,43.36
.zone 84 >>Cast |T775462:0|tZen Pilgrimage and |TInterface/cursor/crosshair/interact.blp:20|tClick the |cRXP_PICK_portal to Stormwind.|r
.xp <20,1
step << Monk
#completewith next
.goto 84,49.45,86.60,8,0
.goto 84,49.51,86.67,10 >>Go through the portal and exit |cFFfa9602the Mage Tower.|r
step << !Monk !DarkIronDwarf
#completewith next
.goto 49,29.42,53.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ariena Stormfeather|r
.fly Stormwind >>Fly to Stormwind
.target Ariena Stormfeather
.xp <20,1
step
+|cFFFCDC00Open Up your Talents (Default N) and turn on Warmode to gain a lot of increased XP and extra talents. Skip this step if you don't want to turn on Warmode|r
.pve
.xp <20,1
step
#completewith next
.goto 84,70.94,72.45,-1
.goto 47,77.48,44.28,-1
.fly Goldshire >>Fly |cFFfa9602to Goldshire.|r
.target Dungar Longdrink
.target Felicia Maline
.zoneskip 37
.xp <20,1
step
.goto 37,42.11,65.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Dughan|r
.turnin 76 >>Turn in The Jasperlode Mine
.target Marshal Dughan
.xp <20,1
step
#completewith Clawing
.hs >> Hearth |cFFfa9602to Darkshire|r
.cooldown item,6948,>0
.zoneskip 47
.xp <20,1
step
.goto 37,41.71,64.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Bartlett the Brave|r
.fly Darkshire >>Fly |cFFfa9602to Darkshire|r
.target Bartlett the Brave
.cooldown item,6948,<0
.zoneskip 47
.xp <20,1
step
#label Clawing
.goto 47,75.56,45.37,8,0
.goto 47,75.83,45.26
>>Talk to |cFF00FF25Madame Eva|r |cFFfa9602inside the house.|r
.turnin 26672 >>Turn in Clawing at the Truth
.accept 26674 >>Accept Mistmantle's Revenge
.target Madame Eva
step
.goto 47,77.42,35.85,10,0
.goto 47,77.33,36.18
>>|cFFFCDC00Use the|r |T332402:0|t[Mistmantle Family Ring] |cFFFCDC00inside Stalvan's house. Wait out the RP|r
>>Kill |cFFFF5722Fetid Corpses|r and check for a |cFFDB2EEFChest|r in and around the House while you wait for |cFFFF5722Stalvan|r to become hostile.
>>Kill |cFFFF5722Stalvan|r
.complete 26674,1 
.mob Fetid Corpse
.mob Stalvan Mistmantle
.cast 82029
.timer 33,Mistmantle's Revenge RP
.use 59363
step
.goto 47,78.74,44.53,8,0
.goto 47,79.09,44.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Tobias Mistmantle|r |cFFfa9602inside the house.|r
.turnin 26674 >>Turn in Mistmantle's Revenge
.accept 26785 >>Accept Part of the Pack
.target Tobias Mistmantle
step
#completewith next
.goto 47,69.51,48.83,30 >> Take the path |cFFfa9602behind the Town Hall to Brightwood Grove.|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Watcher Dodds|r and |cFF00FF25Apprentice Fess.|r
.accept 25235 >>Accept Vulgar Vul'Gol
.goto 47,45.12,67.02
.turnin 26785 >>Turn in Part of the Pack
.accept 26707 >>Accept A Deadly Vine
.accept 26717 >>Accept The Yorgen Worgen
.goto 47,44.92,67.43
.target Watcher Dodds
.target Apprentice Fess
step
#completewith next
>>Kill |cFFFF5722Corpseweed|r and loot them for their |cFF00BCD4Corpseweed.|r
>>Check for the |cFFFF5722Carved One|r (Rare).
.complete 26707,1 
.mob Corpseweed
.unitscan Carved One
step
.goto 47,49.86,77.69
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFDirt Pile|r |cFFfa9602on the ground.|r
.complete 26717,1 
step
.goto 47,51.99,73.61,40,0
.goto 47,49.04,70.73,40,0
.goto 47,47.12,73.79,40,0
.goto 47,49.28,76.56,40,0
.goto 47,51.99,73.61,40,0
.goto 47,49.04,70.73,40,0
.goto 47,47.12,73.79,40,0
.goto 47,49.28,76.56
>>Kill |cFFFF5722Corpseweed|r and loot them for their |cFF00BCD4Corpseweed|r
>>Check for the |cFFFF5722Carved One|r(Rare)
.complete 26707,1 
.mob Corpseweed
.unitscan Carved One
step
#completewith Zzarc
>>Kill |cFFFF5722Splinter Fist Ogres|r, |cFFFF5722Firemongers|r, and |cFFFF5722Warriors|r
.complete 25235,1 
.mob Splinter Fist Ogre
.mob Splinter Fist Firemonger
.mob Splinter Fist Warrior
step
.goto 47,33.52,75.33
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFCrate|r |cFFfa9602on the ground.|r
.complete 26680,1 
step
#completewith next
.goto 47,34.20,77.47,15 >>Check for a |cFFDB2EEFChest|r |cFFfa9602at the mine's entrance|r, then go |cFFfa9602inside the mine.|r
step
#completewith next
.goto 47,35.56,80.07,15,0
.goto 47,34.86,81.36,15 >>Check for a |cFFDB2EEFChest|r |cFFfa9602inside the mine.|r
step
#label Zzarc
.goto 47,37.87,84.33
>>Kill |cFFFF5722Zzarc' Vul|r and loot him for his |cFF00BCD4Ogre's Monocle|r
.complete 26685,1 
.target Zzarc' Vul
step
#completewith DeadlyV
.goto 47,34.20,77.47,15 >>Exit |cFFfa9602the mine.|r
.isOnQuest 25235
step
.goto 47,33.32,74.63,40,0
.goto 47,32.82,68.37,40,0
.goto 47,39.06,70.59,40,0
.goto 47,40.66,74.97,40,0
.goto 47,33.32,74.63,40,0
.goto 47,32.82,68.37,40,0
.goto 47,39.06,70.59,40,0
.goto 47,40.66,74.97
>>Kill |cFFFF5722Splinter Fist Ogres|r, |cFFFF5722Splinter Fist Firemonger|r, and |cFFFF5722Splinter Fist Warrior.|r
.complete 25235,1 
.mob Splinter Fist Ogre
.mob Splinter Fist Firemonger
.mob Splinter Fist Warrior
step
#label DeadlyV
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Apprentice Fess|r and |cFF00FF25Watcher Dodds.|r
.turnin 26707 >>Turn in A Deadly Vine
.turnin 26717 >>Turn in The Yorgen Worgen
.accept 26719 >>Accept Delivery to Master Harris
.goto 47,44.92,67.43
.turnin 25235 >>Turn in Vulgar Vul'Gol
.goto 47,45.12,67.02
.target Apprentice Fess
.target Watcher Dodds
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Alliance 10-60
#name 4A_Northern Stranglethorn
#displayname Chapter 4 - Northern Stranglethorn
#next 5A_Duskwood 2
#fresh 30
#veteran
<< Alliance
step
.goto 50,51.86,12.01
.zone 50 >> Travel |cFFfa9602to Northern Stranglethorn.|r
step
#completewith next
.goto 50,47.74,12.69,30,0
.goto 50,47.87,11.86,40 >> Travel |cFFfa9602to the Rebel Camp.|r
step
#completewith next
.goto 50,47.87,11.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25James Stillair.|r
.fp Rebel Camp >>Get the Rebel Camp Flight Path
.target James Stillair
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lieutenant Doren|r, |cFF00FF25Corporal Kaleb|r, and |cFF00FF25Brother Nimetz.|r
.accept 26735 >>Accept The Fate of Kurzen
.goto 50,47.57,10.25
.accept 26740 >>Accept Krazek's Cookery
.goto 50,47.10,10.70
.accept 26732 >>Accept Bad Medicine
.goto 50,47.25,11.10
.target Lieutenant Doren
.target Corporal Kaleb
.target Brother Nimetz
step
#label Nesingwary
#completewith Camp1
.goto 50,49.36,14.78,40,0
.goto 50,44.26,22.26,40 >> Travel |cFFfa9602to Nesingwary's Expedition.|r
step
#sticky
#label Jaq
#requires Nesingwary
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jaquilina Dramet.|r
.goto 50,43.69,23.19,0,0
.vendor 2483 >>|cRXP_WARN_Vendor and Repair.|r
.target Jaquilina Dramet
.isOnQuest 26685
step
#label Camp1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Barnil Stonepot|r, |cFF00FF25Hemet Nesingwary Jr.|r, |cFF00FF25Drizzlik|r, and |cFF00FF25Krazek.|r
.accept 583 >>Accept Welcome to the Jungle
.goto 50,44.25,22.12
.turnin 583 >>Turn in Welcome to the Jungle
.accept 194 >>Accept Raptor Hunting
.goto 50,44.18,22.97,10,0
.goto 50,44.02,23.29
.accept 26343 >>Accept Supply and Demand
.goto 50,43.62,23.40
.turnin 26740 >>Turn in Krazek's Cookery
.accept 26763 >>Accept Venture Company Mining
.goto 50,43.60,23.13
.target Barnil Stonepot
.target Hemet Nesingwary Jr.
.target Drizzlik
.target Krazek
step
#requires Jaq
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sir S. J. Erlgadin|r, |cFF00FF25Barnil Stonepot|r, and |cFF00FF25Ajeck Rouack.|r
.accept 190 >>Accept Panther Hunting
.goto 50,43.72,22.27,10,0
.goto 50,43.96,22.49,10,0
.goto 50,44.18,22.26
.accept 26269 >>Accept The Green Hills of Stranglethorn
.goto 50,44.25,22.12
.accept 185 >>Accept Tiger Hunting
.goto 50,44.50,22.66
.target Sir S. J. Erlgadin
.target Barnil Stonepot
.target Ajeck Rouack
step
>>Kill |cFFFF5722River Crocolisks|r and loot them for their |cFF00BCD4Large River Crocolisk Skin.|r
.complete 26343,1 
.mob River Crocolisk
step
#completewith next
>>Kill |cFFFF5722Young Stranglethorn Tigers.|r
.complete 185,1 
.mob Young Stranglethorn Tiger
step
.goto 50,45.97,20.58,40,0
.goto 50,43.88,18.04,40,0
.goto 50,41.96,17.77,40,0
.goto 50,41.02,19.93,40,0
.goto 50,42.49,21.96,40,0
.goto 50,38.92,18.96,40,0
.goto 50,45.97,20.58,40,0
.goto 50,43.88,18.04,40,0
.goto 50,41.96,17.77,40,0
.goto 50,41.02,19.93,40,0
.goto 50,42.49,21.96,40,0
.goto 50,38.92,18.96
>>Kill |cFFFF5722River Crocolisks|r and loot them for their |cFF00BCD4Large River Crocolisk Skin.|r
.complete 26343,1 
.mob River Crocolisk
step
.goto 50,37.50,19.98,40,0
.goto 50,39.10,22.12,40,0
.goto 50,40.72,24.52,40,0
.goto 50,42.95,28.10,40,0
.goto 50,44.46,26.17,40,0
.goto 50,46.28,23.20,40,0
.goto 50,37.50,19.98,40,0
.goto 50,39.10,22.12,40,0
.goto 50,40.72,24.52,40,0
.goto 50,42.95,28.10,40,0
.goto 50,44.46,26.17,40,0
.goto 50,46.28,23.20
>>Kill |cFFFF5722Young Stranglethorn Tigers.|r
.complete 185,1 
.mob Young Stranglethorn Tiger
step
.goto 50,43.65,23.46
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 185 >>Turn in Tiger Hunting
.accept 186 >>Accept Tiger Stalking
step
.goto 50,43.62,23.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Drizzlik.|r
.turnin 26343 >>Turn in Supply and Demand
.accept 26344 >>Accept Some Assembly Required
.mob Drizzlik
step
#completewith next
.goto 50,46.52,27.94,8,0
.goto 50,46.93,27.81,8,0
>>Kill |cFFFF5722Young Panthers|r. |cFFFCDC00They are stealthed around the trees and bushes|r.
.complete 190,1,5 
.mob Young Panther
step
.goto 50,47.19,31.84,30 >>Check for |cFFFF5722Tsul'Kalu|r(Rare).
.unitscan Tsul'Kalu
.isOnQuest 190
step
.goto 50,48.71,29.33,8,0
.goto 50,49.24,27.9,8,0
.goto 50,48.66,26.77,8,0
.goto 50,48.62,26.9,10,0
>>Kill |cFFFF5722Young Panthers|r. |cFFFCDC00They are stealthed around the trees and bushes.|r
.complete 190,1,5 
.mob Young Panther
step
#completewith next
.goto 50,50.67,29.62,35,0
.goto 50,52.15,28.82,35,0
.goto 50,49.99,33.55,35,0
.goto 50,51.20,36.00,35,0
>>Kill |cFFFF5722Snapjaw Crocolisks|r |cFFFCDC00(even if they're underwater)|r and loot them for their |cFF00BCD4 Snapjaw Crocolisk Skin.|r
.complete 26344,1 
.mob Snapjaw Crocolisk
step
#veteran
.goto 50,46.00,40.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Steven Lisbane.|r
>>|cRXP_WARN_Skip this step if you don't have level 25 Pet Battle Pets|r
.accept 31852 >>Accept Steven Lisbane
.target Steven Lisbane
.isQuestTurnedIn 31903,31889,31891,31902
step
#veteran
.goto 50,46.00,40.45
>>Defeat |cFFFF5722Steven|r in a Pet Battle.
.complete 31852,1 
.target Steven Lisbane
.skipgossip 63194,1
.isOnQuest 31852
step
#veteran
.goto 50,46.00,40.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Steven Lisbane.|r
.turnin 31852 >>Turn in Steven Lisbane
.target Steven Lisbane
.isQuestTurnedIn 31852
step
#veteran
.goto 50,40.88,39.16,40,0
.goto 50,41.64,40.66,40,0
.goto 50,43.33,40.88,40,0
.goto 50,43.16,43.43,40,0
.goto 50,43.78,43.27,30 >>Check for |cFFFF5722Gluggl|r(Rare).
.unitscan Gluggl
.isQuestTurnedIn 31903,31889,31891,31902
step
#label CrocoSkin
#completewith Mahamba
.goto 50,50.13,39.89,35,0
.goto 50,51.70,39.86,35,0
.goto 50,54.32,38.65,35,0
>>Kill |cFFFF5722Snapjaw Crocolisks|r |cFFFCDC00(even if they're underwater)|r and loot them for their |cFF00BCD4Snapjaw Crocolisk Skin.|r
.complete 26344,1 
.mob Snapjaw Crocolisk
.isQuestTurnedIn 31903,31889,31891,31902
step
#label CrocoSkin
#completewith next
.goto 50,50.67,29.62,35,0
.goto 50,52.15,28.82,35,0
.goto 50,49.99,33.55,35,0
.goto 50,51.20,36.00,35,0
.goto 50,50.13,39.89,35,0
.goto 50,51.70,39.86,35,0
.goto 50,54.32,38.65,35,0
>>Kill |cFFFF5722Snapjaw Crocolisks|r |cFFFCDC00(even if they're underwater)|r and loot them for their |cFF00BCD4Snapjaw Crocolisk Skin.|r
.complete 26344,1 
.mob Snapjaw Crocolisk
.isQuestAvailable 31903
step
#label Mahamba
#completewith CrocoSkin
.goto 50,54.29,30.43,30 >>Check for |cFFFF5722Mahamba|r(Rare).
.unitscan Mahamba
.isOnQuest 26344
step
#requires Mahamba
.goto 50,50.67,29.62,35,0
.goto 50,52.15,28.82,35,0
.goto 50,49.99,33.55,35,0
.goto 50,51.20,36.00,35,0
.goto 50,50.13,39.89,35,0
.goto 50,51.70,39.86,35,0
.goto 50,54.32,38.65
>>Kill |cFFFF5722Snapjaw Crocolisks|r |cFFFCDC00(even if they're underwater)|r and loot them for their |cFF00BCD4Snapjaw Crocolisk Skin.|r
.complete 26344,1 
.mob Snapjaw Crocolisk
step
#completewith next
>>Kill |cFFFF5722Venture Co. Geologists|r and |cFFFF5722Venture Co. Shredders|r and loot them for their |cFF00BCD4Tumbled Crystals.|r
>>|cRXP_WARN_Check for the |cFFDB2EEFChests|r that can spawn in the lumberyard and on the oil rig|r
.complete 26763,1 
.mob Venture Co. Geologist
.mob Venture Co. Shredder
step
.goto 50,54.29,30.43,30 >>Check for |cFFFF5722Mahamba|r(Rare).
>>|cFFFCDC00Skip this step if you killed him already|r
.unitscan Mahamba
.isOnQuest 26344
step
#label VentureCo
>>Kill |cFFFF5722Venture Co. Geologists|r and |cFFFF5722Venture Co. Shredders|r and loot them for their |cFF00BCD4Tumbled Crystals|r
>>|cRXP_WARN_Check for the |cFFDB2EEFChests|r that can spawn in the lumberyard and on the oil rig|r
.goto 50,54.08,33.65,15,0
.goto 50,54.48,34.08,15,0
.goto 50,54.43,35.29,10,0
.goto 50,55.35,35.7,15,0
.goto 50,55.87,42.43,40,0
.goto 50,59.59,36.22,40,0
.goto 50,55.29,30.48,40,0
.goto 50,55.87,42.43,40,0
.goto 50,59.59,36.22,40,0
.goto 50,55.29,30.48
.complete 26763,1 
.mob Venture Co. Geologist
.mob Venture Co. Shredder
step
.goto 50,56.39,28.08,40,0
.goto 50,58.47,26.80,40,0
.goto 50,60.65,30.98,40,0
.goto 50,61.80,31.60,40,0
.goto 50,60.96,25.20,40,0
.goto 50,56.39,28.08,40,0
.goto 50,58.47,26.80,40,0
.goto 50,60.65,30.98,40,0
.goto 50,61.80,31.60,40,0
.goto 50,60.96,25.20
>>Kill |cFFFF5722Stranglethorn Tigers.|r
.complete 186,1 
.mob Stranglethorn Tiger
step
.goto 50,57.92,23.65
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 186 >>Turn in Tiger Stalking
.accept 187 >>Accept Tiger Prowess
step
#completewith next
>>Kill |cFFFF5722Kurzen Medicine Men|r and |cFFFF5722Kurzen Jungle Fighters|r and loot them for their |cFF00BCD4Jungle Remedies.|r
.complete 26732,1 
.accept 26738 >>Accept Just Hatched
.mob Kurzen Medicine Man
.mob Kurzen Jungle Fighter
step
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFScrolls|r |cFFfa9602on the ground.|r
.complete 26735,2 
.goto 50,57.92,23.66
.complete 26735,1 
.goto 50,57.89,22.86
step
.goto 50,58.82,23.14,15,0
.goto 50,57.66,21.06,40,0
.goto 50,56.87,20.28,15,0
.goto 50,56.47,20.31,8,0
.goto 50,56.84,20.73,8,0
.goto 50,56.51,20.25,8,0
.goto 50,58.38,18.57,15,0
.goto 50,56.74,22.87,40,0
.goto 50,58.82,23.14,15,0
.goto 50,57.66,21.06,40,0
.goto 50,56.87,20.28,15,0
.goto 50,56.47,20.31,8,0
.goto 50,56.84,20.73,8,0
.goto 50,56.51,20.25,8,0
.goto 50,58.38,18.57,15,0
.goto 50,56.74,22.87
>>Kill |cFFFF5722Kurzen Medicine Men|r and |cFFFF5722Kurzen Jungle Fighters|r. Loot them for their |cFF00BCD4Jungle Remedies.|r
>>|cRXP_WARN_Check for a |cFFDB2EEFChest|r that can be upstairs or downstairs in the house|r
.complete 26732,1 
.mob Kurzen Medicine Man
.mob Kurzen Jungle Fighter
step
.goto 50,52.56,23,00
>>|cRXP_WARN_Select the option to accept the quest from the pop-up in your quest log.|r
.accept 26738 >>Accept Just Hatched
step
.goto 50,55.65,21.57,10,0
.goto 50,54.58,23.24,10,0
.goto 50,55.10,24.59,10,0
.goto 50,54.69,26.78,10,0
.goto 50,53.30,25.50,10,0
.goto 50,52.56,23,00,10,0
.goto 50,55.65,21.57,10,0
.goto 50,54.58,23.24,10,0
.goto 50,55.10,24.59,10,0
.goto 50,54.69,26.78,10,0
.goto 50,53.30,25.50,10,0
.goto 50,52.56,23,00
>>Kill |cFFFF5722Young Panthers|r. |cFFFCDC00They are stealthed around the trees and bushes.|r
.complete 190,1 
.mob Young Panther
step
.goto 50,47.58,10.25
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 190 >>Turn in Panther Hunting
.accept 191 >>Accept Panther Stalking
step
#completewith next
.goto 50,49.44,14.20,30,0
.goto 50,47.74,12.69,30,0
.goto 50,47.57,10.25,40 >> Return |cFFfa9602to the Rebel Camp.|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lieutenant Doren|r, |cFF00FF25Corporal Sethman|r, and |cFF00FF25Brother Nimetz.|r
.turnin 26735 >>Turn in The Fate of Kurzen
.accept 26736 >>Accept Spared from Madness
.goto 50,47.57,10.25
.turnin 26738 >>Turn in Just Hatched
.accept 26739 >>Accept I Think She's Hungry
.goto 50,46.98,10.84
.turnin 26732 >>Turn in Bad Medicine
.accept 26733 >>Accept Control Sample
.goto 50,47.25,11.10
.target Lieutenant Doren
.target Corporal Sethman
.target Brother Nimetz
step
#completewith next
.goto 50,47.74,12.69,30,0
.goto 50,49.44,14.20,30 >> Exit |cFFfa9602the Rebel Camp.|r
step
.goto 50,56.87,20.28,15,0
.goto 50,56.47,20.31,8,0
.goto 50,56.84,20.73,8,0
.goto 50,56.41,20.29
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFCage|r |cFFfa9602upstairs in the house.|r
>>|cRXP_WARN_Check for a |cFFDB2EEFChest|r that can be upstairs or downstairs in the house|r
.complete 26736,1 
.complete 26736,2 
.complete 26736,3 
step
.goto 50,60.48,21.98,40,0
.goto 50,61.73,19.96,40,0
.goto 50,63.63,18.48,40,0
.goto 50,64.67,21.11,40,0
.goto 50,63.17,22.43,40,0
.goto 50,61.43,22.78,40,0
.goto 50,63.44,24.93,40,0
.goto 50,63.65,31.49,40,0
.goto 50,60.48,21.98,40,0
.goto 50,61.73,19.96,40,0
.goto 50,63.63,18.48,40,0
.goto 50,64.67,21.11,40,0
.goto 50,63.17,22.43,40,0
.goto 50,61.43,22.78,40,0
.goto 50,63.44,24.93,40,0
.goto 50,63.65,31.49
>>|cFFFCDC00Use the|r |T132835:0|t[Lashtail Raptor Egg Fragment] |cFFFCDC00to summon a|r |cFF00FF25Hatchling.|r
>>Kill |cFFFF5722Crystal Spine Basilisks|r. Loot them for their |cFF00BCD4Blood|r. Let the |cFF00FF25Hatchling|r eat their corpses for their |cFF00BCD4Basilisk Meat.|r
.complete 26739,1 
.complete 26733,1 
.mob Crystal Spine Basilisk
.use 58165
step
#completewith next
.deathskip >> Die and respawn at the |cFF00FF25Spirit Healer|r
step
#completewith next
.goto 50,49.44,14.20,30,0
.goto 50,47.74,12.69,30,0
.goto 50,47.57,10.25,40 >> Return |cFFfa9602to the Rebel Camp|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brother Nimetz|r, |cFF00FF25Corporal Sethman|r, and |cFF00FF25 Lieutenant Doren.|r
.turnin 26733 >>Turn in Control Sample
.accept 26734 >>Accept The Source of the Madness
.goto 50,47.25,11.10
.turnin 26739 >>Turn in I Think She's Hungry
.accept 26744 >>Accept Deep Roots
.goto 50,46.98,10.84
.turnin 26736 >>Turn in Spared from Madness
.accept 26737 >>Accept Stopping Kurzen's Legacy
.goto 50,47.57,10.25
.target Brother Nimetz
.target Corporal Sethman
.target Lieutenant Doren
step
.goto 50,47.98,12.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Berrin Burnquill.|r
>>|cFFFCDC00If he isn't here, either relog, or zone into Duskwood and come back|r
.accept 26742 >>Accept Bloodscalp Insight
.target Berrin Burnquill
step
#completewith next
.goto 50,47.74,12.69,30,0
.goto 50,49.44,14.20,30 >> Exit |cFFfa9602the Rebel Camp.|r
step
#completewith next
.goto 50,59.53,18.52,40 >> Enter |cFFfa9602the Cave.|r
step
#completewith Esquivel
>>Kill all |cFFFF5722Kurzen|r |cFFfa9602inside the cave|r |cFFFCDC00EXCEPT Commandos|r and loot them for the |cFF00BCD4Blue Stone.|r
.complete 26734,1 
.mob Kurzen Headshrinker
.mob Kurzen Witch Doctor
.mob Kurzen Elite
.mob Kurzen Shadow Hunter
.mob Kurzen Subchief
step
.goto 50,60.48,17.05,20,0
.goto 50,62.42,17.61,20,0
.goto 50,63.22,16.90,20,0
.goto 50,63.75,16.74
>>Kill |cFFFF5722Chief Anders.|r
>>|cFFFCDC00Be careful of the Stealthed Commandos inside the cave as they stun.|r
.complete 26737,1 
.mob Chief Anders
step
.goto 50,63.11,17.66,8,0
.goto 50,62.86,16.66,15,0
.goto 50,62.45,14.07
>>Kill |cFFFF5722Chief Gaulus.|r
.complete 26737,2 
.mob Chief Gaulus
step
.goto 50,64.09,19.02,20,0
.goto 50,65.78,17.13
>>Kill |cFFFF5722Chief Miranda|r
>>|cRXP_WARN_Check for a |cFFDB2EEFChest|r near the barrels and crates.|r
.complete 26737,3 
.mob Chief Miranda
step
#label Esquivel
.goto 50,64.20,13.36,20,0
.goto 50,66.09,11.73
>>Kill |cFFFF5722Chief Esquivel.|r
>>|cRXP_WARN_Check for a |cFFDB2EEFChest|r near the him|r
.complete 26737,4 
.mob Chief Esquivel
step
.goto 50,59.53,18.52,40,0
.goto 50,63.75,16.74,20,0
.goto 50,62.45,14.07,20,0
.goto 50,65.78,17.13,20,0
.goto 50,66.09,11.73,20,0
.goto 50,59.53,18.52,40,0
.goto 50,63.75,16.74,20,0
.goto 50,62.45,14.07,20,0
.goto 50,65.78,17.13,20,0
.goto 50,66.09,11.73
>>Kill all |cFFFF5722Kurzen|r |cFFfa9602inside the cave|r |cFFFCDC00EXCEPT Commandos|r and loot them for the |cFF00BCD4Blue Stone.|r
.complete 26734,1 
.mob Kurzen Headshrinker
.mob Kurzen Witch Doctor
.mob Kurzen Elite
.mob Kurzen Shadow Hunter
.mob Kurzen Subchief
step
.goto 50,60.48,21.98,40,0
.goto 50,61.73,19.96,40,0
.goto 50,63.63,18.48,40,0
.goto 50,64.67,21.11,40,0
.goto 50,63.17,22.43,40,0
.goto 50,61.43,22.78,40,0
.goto 50,63.44,24.93,40,0
.goto 50,63.65,31.49,40,0
.goto 50,60.48,21.98,40,0
.goto 50,61.73,19.96,40,0
.goto 50,63.63,18.48,40,0
.goto 50,64.67,21.11,40,0
.goto 50,63.17,22.43,40,0
.goto 50,61.43,22.78,40,0
.goto 50,63.44,24.93,40,0
.goto 50,63.65,31.49
>>Kill |cFFFF5722Crystal Spine Basilisks|r and loot them for |cFF00BCD4Page 14|r
.complete 26269,1 
.mob Crystal Spine Basilisk
step
#completewith next
.deathskip >> Die and respawn at the |cFF00FF25Spirit Healer.|r
step
#sticky
#label Jaq2
.goto 50,43.69,23.19,0,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jaquilina Dramet.|r
.vendor 2483 >>Vendor and Repair. |cFFFCDC00It is VERY important you repair here|r
.target Jaquilina Dramet
.isOnQuest 26737
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Barnil Stonepot|r, |cFF00FF25Krazek|r, and |cFF00FF25Drizzlik.|r
.turnin 26269 >>Turn in The Green Hills of Stranglethorn
.goto 50,44.25,22.12
.turnin 26763 >>Turn in Venture Company Mining
.accept 26765 >>Accept Return to Corporal Kaleb
.goto 50,43.60,23.13
.turnin 26344 >>Turn in Some Assembly Required
.goto 50,43.62,23.40
.target Barnil Stonepot
.target Krazek
.target Drizzlik
step
#requires Jaq2
#completewith next
>>Kill |cFFFF5722Elder Stranglethorn Tigers.|r
>>|cFFFCDC00DON'T kill Sin'Dall If you see her|r
.complete 187,1 
.mob Elder Stranglethorn Tiger
step
#requires Jaq2
.goto 50,36.24,28.89,30 >>Check for |cFFFF5722Pogeyan|r(Rare).
.unitscan Pogeyan
.isOnQuest 191
step
.goto 50,36.39,32.58,40,0
.goto 50,37.61,33.55,40,0
.goto 50,37.17,36.85,40,0
.goto 50,38.56,36.44,40,0
.goto 50,39.82,32.34,40,0
.goto 50,38.58,28.25,40,0
.goto 50,36.39,32.58,40,0
.goto 50,37.61,33.55,40,0
.goto 50,37.17,36.85,40,0
.goto 50,38.56,36.44,40,0
.goto 50,39.82,32.34,40,0
.goto 50,38.58,28.25
>>Kill |cFFFF5722Elder Stranglethorn Tigers.|r
>>|cFFFCDC00DON'T kill Sin'Dall If you see her|r
.complete 187,1 
.mob Elder Stranglethorn Tiger
step
.goto 50,38.48,32.59
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 187 >>Turn in Tiger Prowess
.accept 188 >>Accept Tiger Mastery
step
.goto 50,40.47,31.78,30,0
.goto 50,38.50,32.47,30,0
.goto 50,37.26,32.81,30,0
.goto 50,37.48,29.60,30,0
.goto 50,40.47,31.78,30,0
.goto 50,38.50,32.47,30,0
.goto 50,37.26,32.81,30,0
.goto 50,37.48,29.60
>>Kill |cFFFF5722Sin'Dall|r and loot her for her |cFF00BCD4Paw of Sin'Dall.|r
>>|cFFFCDC00She respawns instantly east of the hill, then patrols ontop of the hill then either west, north, or east of it|r
.complete 188,1 
.unitscan Sin'Dall
step
.goto 50,36.63,27.97,40,0
.goto 50,36.13,30.34,40,0
.goto 50,32.22,26.43,40,0
.goto 50,33.77,25.57,40,0
.goto 50,36.44,22.90,40,0
.goto 50,33.86,18.86,40,0
.goto 50,31.35,20.62,40,0
.goto 50,36.63,27.97,40,0
.goto 50,36.13,30.34,40,0
.goto 50,32.22,26.43,40,0
.goto 50,33.77,25.57,40,0
.goto 50,36.44,22.90,40,0
.goto 50,33.86,18.86,40,0
.goto 50,31.35,20.62
>>Kill |cFFFF5722Panthers.|r
.complete 191,1 
.mob Panther
step
.goto 50,31.13,30.25
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 191 >>Turn in Panther Stalking
step
.goto 50,31.23,28.02,40,0
.goto 50,30.31,30.27,40,0
.goto 50,31.66,33.19,40,0
.goto 50,32.11,29.87,40,0
.goto 50,28.93,30.25,40,0
.goto 50,25.03,29.71,40,0
.goto 50,31.23,28.02,40,0
.goto 50,30.31,30.27,40,0
.goto 50,31.66,33.19,40,0
.goto 50,32.11,29.87,40,0
.goto 50,28.93,30.25,40,0
.goto 50,25.03,29.71
>>Kill |cFFFF5722Stranglethorn Raptors.|r
.complete 194,1 
.mob Stranglethorn Raptor
step
.goto 50,30.86,29.66
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 194 >>Turn in Raptor Hunting
.accept 195 >>Accept Raptor Stalking
step
#requires Prowess
#label BloodscalpT
#completewith BloodTablet
>>Kill |cFFFF5722Bloodscalp Shamans|r and loot them for their |cFF00BCD4Bloodscalp Totem.|r
.complete 26742,1 
.mob Bloodscalp Shaman
step
#requires BloodscalpT
#completewith next
.goto 50,33.64,36.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cFF00FF25Hatchling|r |cFFfa9602next to you.|r
.accept 26745 >>Accept Favored Skull
.target Lashtail Hatchling
step
#requires Prowess
#label BloodTablet
.goto 50,33.64,36.91
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFTablet|r |cFFfa9602on the ground.|r
>>|cRXP_WARN_Check for a |cFFDB2EEFChest|r nearby in the ruins|r
.complete 26744,1 
step
.goto 50,34.49,35.89,40,0
.goto 50,33.68,33.98,40,0
.goto 50,35.49,31.58,40,0
.goto 50,35.89,37.88,40,0
.goto 50,33.73,38.03,40,0
.goto 50,34.49,35.89,40,0
.goto 50,33.68,33.98,40,0
.goto 50,35.49,31.58,40,0
.goto 50,35.89,37.88,40,0
.goto 50,33.73,38.03
>>Kill |cFFFF5722Bloodscalp Shamans|r and loot them for their |cFF00BCD4Bloodscalp Totem.|r
>>|cRXP_WARN_Check for a |cFFDB2EEFChest|r nearby in the ruins.|r
.complete 26742,1 
.mob Bloodscalp Shaman
step
.goto 50,33.64,36.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cFF00FF25Hatchling|r |cFFfa9602next to you.|r
.accept 26745 >>Accept Favored Skull
.target Lashtail Hatchling
step
#completewith next
>>Kill |cFFFF5722Lashtail Raptors.|r
.complete 195,1 
.mob Lashtail Raptor
step
.goto 50,40.88,39.16,40,0
.goto 50,41.64,40.66,40,0
.goto 50,43.33,40.88,40,0
.goto 50,43.16,43.43,40,0
.goto 50,43.78,43.27,30 >>Check for |cFFFF5722Gluggl|r(Rare).
.unitscan Gluggl
.isOnQuest 26734
step
#completewith next
.goto 50,41.11,45.48,40,0
.goto 50,43.15,47.39,40,0
>>Kill |cFFFF5722Lashtail Raptors.|r
.complete 195,1 
.mob Lashtail Raptor
step
.goto 50,47.33,44.85,40,0
.goto 50,45.79,47.50,40,0
.goto 50,46.05,51.59,40,0
.goto 50,45.23,53.03,40,0
.goto 50,45.55,54.89,30 >>Check for |cFFFF5722Roloch|r(Rare).
.unitscan Roloch
.isOnQuest 26734
step
.goto 50,48.87,46.00,40,0
.goto 50,49.48,39.87,40,0
.goto 50,47.92,36.54,40,0
.goto 50,41.11,45.48,40,0
.goto 50,43.15,47.39,40,0
.goto 50,48.87,46.00,40,0
.goto 50,49.48,39.87,40,0
.goto 50,47.92,36.54,40,0
.goto 50,41.11,45.48,40,0
.goto 50,43.15,47.39
>>Kill |cFFFF5722Lashtail Raptors.|r
.complete 195,1 
.mob Lashtail Raptor
step
.goto 50,47.19,31.84
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 195 >>Turn in Raptor Stalking
.accept 196 >>Accept Raptor Prowess
step
.goto 50,47.19,31.84,40 >>Check for |cFFFF5722Tsul'Kalu|r(Rare).
.unitscan Tsul'Kalu
.isOnQuest 26734
step
#sticky
#label Jaq3
.goto 50,43.69,23.19,0,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jaquilina Dramet.|r
.vendor 2483 >>Vendor and Repair
.target Jaquilina Dramet
.isOnQuest 26685
step
.goto 50,44.50,22.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Ajeck Rouack.|r
.turnin 188 >>Turn in Tiger Mastery
.target Ajeck Rouack
step
#requires Jaq3
#completewith next
.goto 50,49.44,14.20,30,0
.goto 50,47.74,12.69,30,0
.goto 50,47.25,11.10,40 >> Return |cFFfa9602to the Rebel Camp.|r
step
#requires Jaq3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brother Nimetzz|r, |cFF00FF25Corporal Sethman|r, |cFF00FF25Corporal Kaleb|r, |cFF00FF25Osborn Obnoticus|r, |cFF00FF25Lieutenant Doren|r, and |cFF00FF25Berrin Burnquill.|r
.turnin 26734 >>Turn in The Source of the Madness
.goto 50,47.25,11.10
.turnin 26744 >>Turn in Deep Roots
.goto 50,46.98,10.84
.turnin 26765 >>Turn in Return to Corporal Kaleb
.goto 50,47.10,10.70
.turnin 26745 >>Turn in Favored Skull
.goto 50,47.14,10.56
.turnin 26737 >>Turn in Stopping Kurzen's Legacy
.goto 50,47.57,10.25
.turnin 26742 >>Turn in Bloodscalp Insight
.goto 50,47.98,12.01
.target Brother Nimetz
.target Corporal Sethman
.target Corporal Kaleb
.target Osborn Obnoticus
.target Lieutenant Doren
.target Berrin Burnquill
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Alliance 10-60
#name 5A_Duskwood 2
#displayname Chapter 5 - Duskwood [2]
#next 6A_Redridge Mountains 2
#fresh 30
#veteran
<<Alliance
step
#completewith next
.zone 47 >> Take the |cFFfa9602Shortcut to Duskwood (optional)|r
.link https://www.youtube.com/watch?v=PLrBG2G5dKs >> CLICK HERE
.zoneskip 50,1
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sister Elsington|r, |cFF00FF25Jitters|r, and |cFF00FF25Oliver Harris|r
.accept 26777 >>Accept Soothing Spirits
.goto 47,20.03,57.82
.accept 26721 >>Accept The Jitters-Bugs
.goto 47,18.62,58.36
.turnin 26719 >>Turn in Delivery to Master Harris
.accept 26720 >>Accept A Curse We Cannot Lift
.goto 47,18.32,57.67
.target Sister Elsington
.target Jitters
.target Oliver Harris
step
#completewith LurkingW
>>Use the |T134547:0|t[Holy Censer] on |cFF00FF25Forlorn Spirits.|r
.complete 26777,1 
.mob Forlon Spirit
.use 60225
step
#completewith next
.goto 47,21.65,72.34,8,0
.goto 47,21.29,72.73,8 >>Go |cFFfa9602inside the Stable|r
step
#label LurkingW
.goto 47,21.61,73.15
>>|cFFFCDC00Damage the Worgen that spawns to 20% or less health, then use the|r |T134825:0|t[Harris's Ampule] |cFFFCDC00on it.|r
.complete 26720,1 
.mob Lurking Worgen
.use 60206
step
.goto 47,19.20,68.25,40,0
.goto 47,19.95,64.85,40,0
.goto 47,23.23,66.58,40,0
.goto 47,25.13,70.24,40,0
.goto 47,22.85,72.11,40,0
.goto 47,19.20,68.25,40,0
.goto 47,19.95,64.85,40,0
.goto 47,23.23,66.58,40,0
.goto 47,25.13,70.24,40,0
.goto 47,22.85,72.11
>>Use the |T134547:0|t[Holy Censer] on |cFF00FF25Forlorn Spirits.|r
.complete 26777,1 
.mob Forlon Spirit
.use 60225
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Oliver Harris|r and |cFF00FF25Sister Elsington.|r
.turnin 26720 >>Turn in A Curse We Cannot Lift
.accept 26760 >>Accept Cry For The Moon
.timer 58,Cry For The Moon RP
.goto 47,18.32,57.67
.turnin 26777 >>Turn in Soothing Spirits
.goto 47,20.03,57.82
.target Oliver Harris
.target Sister Elsington
step
.goto 47,20.26,58.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Wilkinson.|r
.vendor 44114 >> Vendor Trash
.target Wilkinson
.isOnQuest 26760
step
.goto 47,21.08,56.45
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25John Shelby.|r
.fp Raven Hill >> Get the Raven Hill flight path
.target John Shelby
step
>>|cFFFCDC00Wait out the RP|r
>>|cFFFCDC00If you didn't get credit after the timer expires, abandon "Cry For The Moon" and accept the quest again|r
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Oliver Harris|r, |cFF00FF25Sven Yorgen|r, and |cFF00FF25Sister Elsington|r
.complete 26760,1 
.turnin 26760 >>Turn in Cry For The Moon
.goto 47,18.32,57.67
.accept 26723 >>Accept The Fate of Morbent Fel
.goto 47,18.34,58.06
.accept 26778 >>Accept The Cries of the Dead
.goto 47,20.03,57.82
.target Oliver Harris
.target Sven Yorgen
.target Sister Elsington
step
.goto 47,31.66,50.31,50,0
.goto 47,37.52,25.18,50,0
.goto 47,30.98,31.14,50,0
.goto 47,31.66,50.31,50,0
.goto 47,37.52,25.18,50,0
.goto 47,30.98,31.14
>>Kill |cFFFF5722Black Widows|r and loot them for their |cFF00BCD4Widow Venom Sac.|r
>>|cFFFCDC00They sometimes vanish for 1-2s in combat|r
.complete 26721,1 
.mob Black Widow
step
#completewith EChest
+|cFFFCDC00Avoid Mor'Ladim patrolling nearby|r
.unitscan Mor'Ladim
step
.goto 47,17.72,29.05
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFF00FF25A Weathered Grave.|r
.accept 26793 >>Accept The Weathered Grave
step
#completewith EChest
>>Kill |cFFFF5722Plague Spreaders|r, |cFFFF5722Flesh Eaters|r, |cFFFF5722Rotted Ones|r, and |cFFFF5722Bone Chewers|r. |cFFFCDC00Don't focus on this|r
.complete 26778,1 
.mob Plague Spreader
.mob Flesh Eater
.mob Rotted One
.mob Bone Chewer
step
.goto 47,17.49,33.40,8,0
.goto 47,17.44,34.17,5,0
.goto 47,16.97,33.42
>>|cRXP_WARN_Check for a |cFFDB2EEFChest|r|r and loot the |cFFDB2EEFHat|r on the ground |cFFfa9602inside the house |rfor |cRXP_PICK_Morbent's Remains.|r
.complete 26723,1 
step
#label EChest
.goto 47,19.88,44.53,20 >>Check for a |cFFDB2EEFChest|r behind |cFF00FF25Eric.|r
.isOnQuest 26723
step
#veteran
.goto 47,19.88,44.61
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Eric Davidson.|r
>>|cRXP_WARN_Skip this step if you don't have level 25 Pet Battle Pets|r
.accept 31850 >>Accept Eric Davidson
.target Eric Davidson
.isQuestTurnedIn 31903,31889,31891,31902
step
#veteran
.goto 47,19.88,44.61
>>Defeat |cFFFF5722Eric|r in a Pet Battle.
.complete 31850,1 
.target Eric Davidson
.skipgossip 65655,1
.isOnQuest 31850
step
#veteran
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 31850 >>Turn in Questlog
.isQuestComplete 31850
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sven Yorgen|r, |cFF00FF25Jitters|r, and |cFF00FF25Sister Elsington.|r
.turnin 26723 >>Turn in The Fate of Morbent Fel
.accept 26724 >>Accept The Lurking Lich
.goto 47,18.34,58.06
.turnin 26721 >>Turn in The Jitters-Bugs
.accept 26787 >>Accept Bear In Mind
.goto 47,18.62,58.36
.turnin 26724 >>Turn in The Lurking Lich
.accept 26725 >>Accept Guided by the Light
.turnin 26778 >>Turn in The Cries of the Dead
.goto 47,20.03,57.82
.target Sven Yorgen
.target Jitters
.target Sister Elsington
.isQuestComplete 26778
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sven Yorgen|r, |cFF00FF25Jitters|r, and |cFF00FF25Sister Elsington.|r
.turnin 26723 >>Turn in The Fate of Morbent Fel
.accept 26724 >>Accept The Lurking Lich
.goto 47,18.34,58.06
.turnin 26721 >>Turn in The Jitters-Bugs
.accept 26787 >>Accept Bear In Mind
.goto 47,18.62,58.36
.turnin 26724 >>Turn in The Lurking Lich
.accept 26725 >>Accept Guided by the Light
.goto 47,20.03,57.82
.target Sven Yorgen
.target Jitters
.target Sister Elsington
step
#completewith CatacombsX
>>Kill |cFFFF5722Plague Spreaders|r, |cFFFF5722Flesh Eaters|r, |cFFFF5722Rotted Ones|r, and |cFFFF5722Bone Chewers.|r
.complete 26778,1 
.mob Plague Spreader
.mob Flesh Eater
.mob Rotted One
.mob Bone Chewer
step
.goto 47,23.45,35.41
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFF00FF25Lightforged Rod|r |cFFfa9602on the ground.|r
.turnin 26725 >>Turn in Guided by the Light
.accept 26753 >>Accept The Halls of the Dead
step
#label CatacombsX
#completewith next
.goto 47,23.94,34.80,10,0
.goto 47,25.68,33.76,15,0
.goto 47,25.46,31.50,15,0
.goto 47,23.47,27.99,15,0
.goto 47,20.37,27.46,20 >>Go deep |cFFfa9602inside the Catacombs.|r
step
.goto 47,20.37,27.46
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFF00FF25Lightforged Arch|r |cFFfa9602on the ground.|r
.turnin 26753 >>Turn in The Halls of the Dead
.accept 26722 >>Accept Buried Below
step
#completewith next
.goto 47,20.33,26.81,10,0
.goto 47,19.47,26.81,10,0
.goto 47,18.53,24.94,10,0
.goto 47,18.01,25.37,10 >>Go through the hole in the wall and descend deeper |cFFfa9602into the Catacombs.|r
step
.goto 47,18.01,25.37
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFF00FF25Lightforged Crest|r |cFFfa9602on the ground.|r
.turnin 26722 >>Turn in Buried Below
.accept 26754 >>Accept Morbent's Bane
step
#completewith next
.goto 47,17.33,26.27,10,0
.goto 47,18.16,27.63,10,0
.goto 47,17.63,28.45,10 >>Run deeper |cFFfa9602into the secret part of the Catacombs.|r
step
#completewith next
.goto 47,16.53,31.06
.cast 82130 >>|cFFFCDC00Use|r |T135142:0|t[Morbent's Bane] |cFFFCDC00on|r |cFFFF5722Morbent Fel|r |cFFFCDC00to weaken him.|r
.mob Morbent Fel
.use 60212
step
.goto 47,16.53,31.06
>>Kill |cFFFF5722Morbent Fel.|r
.complete 26754,1 
.mob Morbent Fel
.use 60212
step
#completewith CoalB
.goto 47,16.18,33.19,15,0
.goto 47,15.31,38.48,15,0
.goto 47,16.09,38.78,15 >>Exit the Catacombs |cFFfa9602through the other side.|r
step
.goto 47,20.72,35.33,40,0
.goto 47,22.70,32.95,40,0
.goto 47,16.20,33.17,40,0
.goto 47,14.27,41.46,40,0
.goto 47,20.72,35.33,40,0
.goto 47,22.70,32.95,40,0
.goto 47,16.20,33.17,40,0
.goto 47,14.27,41.46
>>Kill |cFFFF5722Plague Spreaders|r, |cFFFF5722Flesh Eaters|r, |cFFFF5722Rotted Ones|r, and |cFFFF5722Bone Chewers.|r
>>|cFFFCDC00Avoid Mor'Ladim patrolling nearby|r
.complete 26778,1 
.mob Plague Spreader
.mob Flesh Eater
.mob Rotted One
.mob Bone Chewer
.unitscan Mor'Ladim
step
#label CoalB
.goto 47,13.92,34.34,40,0
.goto 47,7.91,33.71,40,0
.goto 47,11.17,60.22,40,0
.goto 47,16.99,76.07,40,0
.goto 47,13.92,34.34,40,0
.goto 47,11.17,60.22,40,0
.goto 47,16.99,76.07
>>Kill |cFFFF5722Coalpelt Bears|r and loot them for their |cFF00BCD4Black Bear Brains.|r
>>|cRXP_WARN_Check for |cFFFF5722Marina|r (Rare).|r
.complete 26787,1 
.mob Coalpelt Bear
.unitscan Marina DeSirrus
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sven Yorgen|r, |cFF00FF25Jitters|r, and |cFF00FF25Sister Elsington.|r
.turnin 26754,1 >>Turn in Morbent's Bane
.goto 47,18.34,58.06
.turnin 26787 >>Turn in Bear In Mind
.goto 47,18.62,58.36
.turnin 26778 >>Turn in The Cries of the Dead
.goto 47,20.03,57.82
.target Sven Yorgen
.target Jitters
.target Sister Elsington
.isOnQuest 26778
step
> >|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sven Yorgen|r and |cFF00FF25Jitters.|r
.turnin 26754 >>Turn in Morbent's Bane
.goto 47,18.34,58.06
.turnin 26787 >>Turn in Bear In Mind
.goto 47,18.62,58.36
.target Sven Yorgen
.target Jitters
step
#completewith next
.hs >> Hearthstone |cFFfa9602to Darkshire.|r
step
#completewith next
.goto 47,74.07,45.32,8,0
.goto 47,73.82,45.95,8,0
.goto 47,72.86,46.82,10,0
.goto 47,72.53,47.21,8 >>Exit |cFFfa9602the Inn, then go into the Town Hall.|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Sirra Von'Indi|r and |cFF00FF25Commander Althea Ebonlocke.|r
.turnin 26793 >>Turn in The Weathered Grave
.accept 26794 >>Accept Morgan Ladimore
.goto 47,72.60,47.76
.turnin 26794 >>Turn in Morgan Ladimore
.goto 47,73.53,46.92
.target Sirra Von'Indi
.target Commander Althea Ebonlocke
step
#sticky
#label Morladim
.destroy 2154 >> |cRXP_WARN_You can delete "The Story of Morgan Ladimore" from your bags, as it's no longer needed.|r
step
.goto 47,79.53,47.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Viktori Prism'Antras.|r
.turnin 26685 >>Turn in Classy Glass
.target Viktori Prism'Antras
step
.goto 47,87.43,35.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Abercrombie.|r
.turnin 26680 >>Turn in Ogre Thieves
.accept 26677 >>Accept Ghoulish Effigy
.target Abercrombie
step
#completewith next
.goto 47,87.98,33.16,20,0
.goto 47,88.1,31.33,20,0
.goto 47,90.98,30.53,30 >>Check for the |cFFFF5722Unknown Soldier|r(Rare).
.unitscan Unknown Soldier
step
.goto 47,77.34,36.27,15,0
.goto 47,75.08,37.23,40,0
.goto 47,76.73,30.50,40,0
.goto 47,81.23,32.15,40,0
.goto 47,79.79,35.41,40,0
.goto 47,75.08,37.23,40,0
.goto 47,76.73,30.50,40,0
.goto 47,81.23,32.15,40,0
.goto 47,79.79,35.41
>>Kill |cFFFF5722Fetid Corpses|r and loot them for their |cFF00BCD4Ghoul Ribs.|r
>>|cRXP_WARN_Check for a |cFFDB2EEFChest|r in and around the House|r
.complete 26677,1 
.mob Fetid Corpse
step
.goto 47,87.43,35.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Abercrombie.|r
.turnin 26677 >>Turn in Ghoulish Effigy
.accept 26681 >>Accept Note to the Mayor
.target Abercrombie
step
#completewith next
.goto 47,72.86,46.82,10,0
.goto 47,72.53,47.21,8,0
.goto 47,72.35,47.75,8 >>Enter |cFFfa9602the Town Hall.|r
step
.goto 47,71.93,46.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lord Ello Ebonlocke.|r
.turnin 26681 >>Turn in Note to the Mayor
.accept 26727 >>Accept The Embalmer's Revenge
.target Lord Ello Ebonlocke
step
#completewith next
.goto 47,72.35,47.75,8,0
.goto 47,72.53,47.21,8,0
.goto 47,72.86,46.82,10 >>Exit |cFFfa9602the Town Hall.|r
step
.goto 47,74.17,46.47
>>Kill |cFFFF5722Stiches.|r
.complete 26727,1 
.mob Stitches
step
#completewith next
.goto 47,72.86,46.82,10,0
.goto 47,72.53,47.21,8,0
.goto 47,72.35,47.75,8 >>Enter |cFFfa9602the Town Hall.|r
step
.goto 47,71.93,46.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lord Ello Ebonlocke.|r
.turnin 26727 >>Turn in The Embalmer's Revenge
.target Lord Ello Ebonlocke
step << DarkIronDwarf
#completewith Believe
.zone 84 >>Use |T1786409:0|t|cFF00FF25Mole Machine|r and |TInterface/cursor/crosshair/interact.blp:20|tinteract with it.
.skipgossip 143925,1,2
.xp <30,1
step << Monk
.goto 379,48.96,43.36
.zone 84 >>Cast |T775462:0|tZen Pilgrimage and |TInterface/cursor/crosshair/interact.blp:20|tClick the |cRXP_PICK_portal to Stormwind.|r
.xp <30,1
step << Monk
#completewith next
.goto 84,49.45,86.60,8,0
.goto 84,49.51,86.67,10 >>Go through the portal and exit the Mage Tower
.xp <30,1
step << !Monk !DarkIronDwarf
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Felicia Maline.|r
.fly Stormwind >>Fly to Stormwind
.goto 47,77.48,44.28
.target Felicia Maline
.zoneskip 84
.xp <30,1
step << !Monk !DarkIronDwarf
.zone 84 >>Travel to Stormwind
.xp <30,1
]])
RXPGuides.RegisterGuide([[
#df
#version
#group RestedXP Alliance 10-60
#displayname Chapter 6 - Redridge Mountains [2]
#name 6A_Redridge Mountains 2
#next 7A_Tirangarde Sound
#fresh 30
#veteran
<<Alliance
step
.next << 30
.goto 47,77.48,44.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Felicia Maline.|r
.fly Camp Everstill >>Fly |cFFfa9602to Camp Everstill|r
.target Felicia Maline
.zoneskip 49
step
#completewith SeaforiumD
+|cFFFCDC00Use the|r |T133878:0|t[Bravo Company Field Kit]. |cFFFCDC00You can mount normally with the Item, but NOT the Disguise|r
>>Use |T136074:0|t[Camouflage](1) to Disguise yourself. |cFFFCDC00This does not work whilst mounted|r
>>Use |T132289:0|t[Distraction](2) to make the |cFFFF5722Blackrock Orcs|r move out of your way
>>Use |T136090:0|t[Chloroform](3) to sleep the |cFFFF5722Blackrock Orcs|r
.isOnQuest 26651
step <<skipfornow
>>Go inside the cave
step
.goto 49,69.51,76.32
>>Check for a |cFFDB2EEFChest|r and loot the |cFFDB2EEFKey|r |cFFfa9602inside.|r
.collect 59261,1,26646,1
.use 60394
step
.goto 49,68.97,60.13
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFCage.|r
.complete 26646,1 
.use 60384
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 26646 >>Turn in Prisoners of War
.accept 26651 >>Accept To Win a War, You Gotta Become War
step
.isOnQuest 26651
.goto 49,66.31,70.79,20 >>Go |cFFfa9602inside the tower.|r
step <<skipfornow
>>Go to the top of the tower
step
.goto 49,66.41,71.61
>>Use |T136173:0|t[Plant Seaforium](4) |cFFfa9602at the Blackrock Tower.|r
.complete 26651,2 
step
.isOnQuest 26651
.goto 49,64.09,69.99,20 >>Go |cFFfa9602inside the hut|r
step
#label SeaforiumD
.goto 49,63.75,70.56
>>Use |T136173:0|t[Plant Seaforium](4) inside the |cFFfa9602Munitions Hut.|r
.complete 26651,1 
step
#completewith next
.goto 49,63.55,65.51,40 >>Check for |cFFFF5722Chitter|r(Rare).
.unitscan Chitter
step
#completewith next
>>|cFFFCDC00Mount up and avoid|r |cFFFF5722Blackrock Orcs|r |cFFFCDC00to get there faster.|r
.goto 49,77.68,65.50,50 >> Travel |cFFfa9602to Shalewind Canyon|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25John J. Keeshan|r and |cFF00FF25Danforth.|r
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic|r
.turnin 26651 >>Turn in To Win a War, You Gotta Become War
.accept 26668 >>Accept Detonation
.turnin 26668 >>Turn in Detonation
.accept 26693 >>Accept The Dark Tower
.goto 49,77.68,65.51
.accept 26692 >>Accept Shadowhide Extinction
.goto 49,77.63,65.34
.target John J. Keeshan
.target Danforth
step
#completewith Shadowhide Gnoll
>>Kill |cFFFF5722Shadowhide Gnolls|r
>>|cFFFF5722Assassins|r |cFFFCDC00are stealthed|r
.complete 26692,1 
.mob Shadowhide Warrior
.mob Shadowhide Darkweaver
.mob Shadowhide Brute
.mob Shadowhide Assassins
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 26692 >>Turn in Shadowhide Extinction
step
#completewith next
.goto 49,70.99,41.63,25,0
.goto 49,68.2,35.53,20 >>Check for |cFFFF5722Rohh|r (Rare) |cFFfa9602in the Gnoll Camps.|r
>>|cFFFCDC00He is stealthed|r
>>Check for a |cFFDB2EEFChest|r nearby
.unitscan Rohh the Silent
step<<skipfornow
>>Go inside the cave
step
.goto 49,67.54,28.91
>>|cFFFF5722Kill Fangore|r and loot him for his |T134243:0|t[|cFF00BCD4Key of Ilgalar.|r
.complete 26693,1 
.mob General Fangore
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 26693 >>Turn in The Dark Tower
.accept 26694 >>Accept The Grand Magus Doane
step
.goto 49,71.93,44.82
.cast 81776 >> Use the |T134243:0|t[|cFF00BCD4Key of Ilgalar|r] on the Ward of Ilgalar |cFFfa9602at the tower's entrance.|r
.isOnQuest 26694
step
#completewith next
.goto 49,71.37,44.74,10 >>Check for a |cFFDB2EEFChest|r |cFFfa9602on the ground floor of the tower.|r
.isOnQuest 26694
step
.goto 49,71.18,45.21
>>Kill |cFFFF5722Grand Magus Doane.|r
.complete 26694,1 
.mob Grand Magus Doane
step
.goto 49,72.81,44.40,40,0
.goto 49,74.24,52.67,40,0
.goto 49,71.63,49.66,40,0
.goto 49,69.03,50.39,40,0
.goto 49,66.90,45.58,40,0
.goto 49,67.64,43.57,40,0
.goto 49,68.21,35.45,40,0
.goto 49,70.56,37.90,40,0
.goto 49,70.99,41.82,40,0
.goto 49,72.81,44.40
>>Kill |cRXP_WARN_Shadowhide Gnoll.|r
>>|cFFFF5722Assassins|r |cFFFCDC00are stealthed|r
.complete 26692,1 
.mob Shadowhide Warrior
.mob Shadowhide Darkweaver
.mob Shadowhide Slayer
.mob Shadowhide Brute
.mob Shadowhide Gnoll
.mob Shadowhide Assassin
.mob Rabid Shadowhide Gnoll
step
.goto 49,77.68,65.50
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 26692 >>Turn in Shadowhide Extinction
step
.goto 49,77.68,65.51
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25John J. Keeshan.|r
.turnin 26694 >>Turn in The Grand Magus Doane
.timer 29,The Grand Magus Doane RP
.target John J. Keeshan

step
#completewith next
+|cRXP_WARN_Wait for the brief roleplay, which will be completed when the timer runs out.|r
step
.goto 49,77.20,65.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Colonel Troteman.|r
.accept 26708 >>Accept AHHHHHHHHHHHH! AHHHHHHHHH!!!
.target Colonel Troteman
step
#completewith next
.vehicle >> Get into the |cFFDB2EEFBravo Company Siege Tank.|r
.target Bravo Company Siege Tank
.isOnQuest 26708
step
.goto 49,75.89,52.64,40,0
.goto 49,63.92,39.92,40,0
.goto 49,75.89,52.64,40,0
.goto 49,63.92,39.92
>>Drive through the |cFFFF5722Blackrock Invaders|r and spam use |T252173:0|t[Ram](1).
.complete 26708,1 
.mob Blackrock Invader
step
.goto 49,60.66,36.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Colonel Troteman.|r
.turnin 26708,1 >>Turn in AHHHHHHHHHHHH! AHHHHHHHHH!!!
.accept 26713 >>Accept Showdown at Stonewatch
.target Colonel Troteman
step
.goto 49,60.27,47.38
>>|cRXP_WARN_Ensure your team is with you before proceeding. They should spawn as you approach |cRXP_ENEMY_Tharil'zun.|r If they don't, please log out and log back in.|r
>>Kill |cFFFF5722Tharil'zun|r
.complete 26713,1 
.mob Tharil'zun
step
.goto 49,57.79,56.26
>>|cRXP_WARN_Ensure your team is with you before proceeding. They should spawn as you approach |cRXP_ENEMY_Tharil'zun.|r If they don't, please log out and log back in.|r
>>Kill |cFFFF5722Gath'Ilzogg|r
.complete 26713,2 
.mob Gath'Ilzogg
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 26713 >>Turn in Showdown at Stonewatch
.accept 26714 >>Accept Darkblaze, Brood of the Worldbreaker

step
#completewith next
+|cRXP_WARN_Wait for the brief roleplay, which will be completed when the timer runs out.|r
step
.goto 49,58.65,55.48
>>Kill |cFFFF5722Darkblaze.|r
.complete 26714,1 
.mob Darkblaze
.target Grand Magus Doan
step
.goto 49,60.66,36.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Colonel Troteman.|r
.turnin 26714 >>Turn in Darkblaze, Brood of the Worldbreaker
.accept 26726 >>Accept Triumphant Return
.target Colonel Troteman
step
.goto 49,37.74,34.14,30 >> Check for |cFFFF5722Chatter|r(Rare).
.unitscan Chatter
.isOnQuest 26726
step
#completewith next
.goto 49,28.49,42.44,10,0
.goto 49,27.99,41.27,10 >>Go |cFFfa9602inside the Town Hall.|r
step
.goto 49,28.91,41.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Magistrate Solomon.|r
.turnin 26726 >>Turn in Triumphant Return
.turnin 26505 >>Turn in Parker's Report
.target Magistrate Solomon
.isQuestComplete 26505
step
.goto 49,28.91,41.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25 Magistrate Solomon.|r
.turnin 26726 >>Turn in Triumphant Return
.target Magistrate Solomon
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Alliance 10-60
#name 7A_Tiragarde Sound
#displayname Chapter 7 - Tiragarde Sound
#next 8A_Tiragarde Sound Part 2
<<Alliance
step << DarkIronDwarf
#completewith Herald
.zone 84 >>Use |T1786409:0|t|cFF00FF25Mole Machine|r and |TInterface/cursor/crosshair/interact.blp:20|tinteract with it.
.skipgossip 143925,1,2
.isQuestAvailable 46727
step << Monk
#completewith Herald
.goto 379,48.96,43.36
.zone 84 >>Cast |T775462:0|tZen Pilgrimage and |TInterface/cursor/crosshair/interact.blp:20|tClick the |cRXP_PICK_portal to Stormwind.|r
.isQuestAvailable 46727
step << !Monk !DarkIronDwarf
#completewith Herald
.goto 47,77.48,44.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Felicia Maline.|r
.fly Stormwind >>Fly |cFFfa9602to Stormwind.|r
.target Felicia Maline
.zoneskip 47,1
.isQuestAvailable 46727
step << !Monk !DarkIronDwarf
#completewith Herald
.goto 49,29.42,53.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Ariena Stormfeather.|r
.fly Stormwind >>Fly |cFFfa9602to Stormwind.|r
.target Ariena Stormfeather
.zoneskip 49,1
.isQuestAvailable 46727
step << !Monk !DarkIronDwarf
.zone 84 >>Travel |cFFfa9602to Stormwind.|r
.isQuestAvailable 46727
step << Monk
.goto 84,60.39,75.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Innkeeper Allison.|r
.home >>Set your Hearthstone |cFFfa9602to Stormwind Trade District|r
.target Innkeeper Allison
step << Monk




#completewith next
>>Consider purchasing |T348525:0|t[Wildercloth Bags] from the Auction House |cRXP_WARN_if you need larger bags.|r However, if you already own larger bags, you can disregard this step. |cRXP_WARN_After purchase, head to the mailbox to collect them and then equip them.|r
.collect 194017,4 
.target Auctioneer Fitch
.target Auctioneer Chilton
.target Auctioneer Jaxon
step
#label Herald
.goto 84,62.82,71.74,-1
.goto 84,62.17,30.14,-1
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cFF00FF25Hero's Herald.|r
.accept 46727 >>Accept Battle for Azeroth: Tides of War
.target Hero's Herald
step << !Monk




#completewith next
>>Consider purchasing |T348525:0|t[Wildercloth Bags] from the Auction House |cRXP_WARN_if you need larger bags.|r However, if you already own larger bags, you can disregard this step. |cRXP_WARN_After purchase, head to the mailbox to collect them and then equip them.|r
.collect 194017,4 
.target Auctioneer Fitch
.target Auctioneer Chilton
.target Auctioneer Jaxon
step << !Monk
.goto 84,60.39,75.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Innkeeper Allison|r
.home >>Set your Hearthstone to Stormwind Trade District
.target Innkeeper Allison
step
#completewith next
.goto 84,80.65,37.82,25,0
.goto 84,80.26,33.12,36 >>Travel |cFFfa9602to Stormwind's Keep|r
.timer 49,Battle for Azeroth: Tides of War RP
step
.goto 84,80.49,33.52
>>|cRXP_WARN_Wait for the brief roleplay, which will be completed when the timer runs out.|r
.complete 46727,1 
step
.goto 84,80.49,33.52
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Portal.|r
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic.|r
.complete 46727,2 
step
.goto 84,80.26,33.12
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Anduin Wrynn|r
.turnin 46727 >>Turn in Battle for Azeroth: Tides of War
.accept 46728 >>Accept The Nation of Kul Tiras
.target Anduin Wrynn
step
.goto 84,81.56,35.59,5,0
.goto 84,80.72,37.73,5,0
.goto 84,56.26,17.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Chromie|r
>>|cFFFCDC00Select "The Cataclysm" Campaign|r
.turnin 62567 >>Turn in Adventurers Wanted: Chromie's Call
.accept 60891 >>Accept Cataclysm: Onward to Adventure in the Eastern Kingdoms
.target Chromie
.skipgossip
.isOnQuest 62567
step
.goto 84,81.56,35.59,5,0
.goto 84,80.72,37.73,5,0
.goto 84,56.26,17.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Chromie|r and select |cFFFCDC00 "The Cataclysm" Campaign.|r
.accept 60891 >>Accept Cataclysm: Onward to Adventure in the Eastern Kingdoms
.target Chromie
.skipgossip
step
.goto 84,63.76,73.60
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk |cFF00FF25Renato Gallina|r
.accept 332 >>Accept Wine Shop Advert
.target Renato Gallina
.isOnQuest 62567
step
.goto 84,62.32,67.96
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk |cFF00FF25Harlan Bagley|r
.accept 333 >>Accept Harlan Needs a Resupply
.target Harlan Bagley
.isOnQuest 62567
step
.goto 84,58.09,67.49
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk |cFF00FF25Rema Schneider|r
.turnin 333 >>Turn in Harlan Needs a Resupply
.accept 334 >>Accept Package for Thurman
.target Rema Schneider
.isOnQuest 62567
step
.goto 84,60.28,76.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk |cFF00FF25Suzetta Gallina|r
.turnin 332 >>Turn in Wine Shop Advert
.target Suzetta Gallina
.isOnQuest 62567
step
.goto 84,52.59,83.40
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk |cFF00FF25Thurman Schneider|r
.turnin 334 >>Turn in Package for Thurman
.target Thurman Schneider
.isOnQuest 62567
step
.goto 84,22.79,24.68
.achievementIncomplete 12582,1
.isOnQuest 46728
.gossipoption 47615 >> Talk to |cFF00FF25 Lady Jaina Proudmoore|r
>>|cRXP_WARN_Wait for the brief roleplay, which will be completed when the timer runs out.|r
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic.|r
.turnin 46728 >>Turn in The Nation of Kul Tiras
.accept 51341 >>Accept Daughter of the Sea
.timer 7,Daughter of the Sea RP
.target Lady Jaina Proudmoore
step
.goto 84,22.79,24.68
.achievementComplete 12582,1
.isOnQuest 46728
.gossipoption 47616 >> Talk to |cFF00FF25Lady Jaina Proudmoore|r and press accept to skip |cRXP_WARN_ "the Kultiras Introduction Quests"|r
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic|r
.target Lady Jaina Proudmoore
step
.goto 84,22.79,24.68
.achievementComplete 12582,1
.isOnQuest 46728
.gossipoption 47616 >> Talk to |cFF00FF25Lady Jaina Proudmoore|r
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic.|r
.target Lady Jaina Proudmoore
step
.goto 1169,47.42,46.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r
.turnin 51341 >>Turn in Daughter of the Sea
.accept 47098 >>Accept Out Like Flynn
.timer 5,Out Like Flynn RP
.target Flynn Fairwind
step
.goto 1169,46.62,45.47
>>|cRXP_WARN_Wait for the brief roleplay, which will be completed when the timer runs out.|r
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cFF00FF25Flynn Fairwind|r to punch him.
.complete 47098,1 
.timer 10,Out Like Flynn RP
.target Flynn Fairwind
.skipgossip
step
.goto 1169,46.66,40.94
>>|cRXP_WARN_Wait for the brief roleplay, which will be completed when the timer runs out.|r
>>Run out the cell and pull the |cFFDB2EEFLever.|r
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic.|r
.complete 47098,2 
step
.goto 1169,46.84,44.71
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFChest|r |cFFfa9602on the ground.|r
.complete 47098,3 
step
.goto 1169,40.25,54.78
>>Kill |cFFFF5722Carmine|r
.complete 47098,4 
.mob Block Warden Carmine
step
.goto 1169,43.58,54.08
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFGunpowder|r |cFFfa9602on the table.|r
.complete 47098,5 
step
.isOnQuest 47098
.goto 1169,42.71,46.78,10,0
.goto 1169,41.17,43.49,10,0
.goto 1169,43.24,36.66,15 >>Run |cFFfa9602to the Cell Block Gate|r
step
.isOnQuest 47098
.goto 1169,43.24,36.66
.cast 271399 >>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFFDB2EEFCell Block Gate|r
.timer 12,Out Like Flynn RP
step
.goto 1169,44.48,35.69,12,0
.goto 1169,45.51,36.76,12,0
.goto 1169,49.31,42.18,12,0
.goto 1169,48.59,42.70,12,0
.goto 1169,46.69,42.80,12,0
.goto 1169,44.19,42.22,12,0
.goto 1169,37.94,53.79
>>Run |cFFfa9602down the hall into the Sewers.|r
.complete 47098,7 
step
.goto 1169,44.48,35.69,12,0
.goto 1169,45.51,36.76,12,0
.goto 1169,49.31,42.18,12,0
.goto 1169,48.59,42.70,12,0
.goto 1169,46.69,42.80,12,0
.goto 1169,44.19,42.22,12,0
.goto 1169,37.94,53.79
>>Run down the hall into the Sewers
.complete 47098,7 
step
.isOnQuest 47098
.goto 1169,42.23,58.92,10,0
.goto 1169,48.87,45.24,10,0
.goto 1169,50.96,47.27,10 >>Run |cRXP_WARN_down the Drain Pipe out to the Shore.|r
step
.isOnQuest 47098
.goto 1169,61.53,47.69,30,0
.goto 1169,64.04,33.31,30,0
.goto 1169,60.59,25.53,20 >>Run to the |cRXP_PICK_Getaway Boat.|r
step
.goto 1169,60.59,25.53
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Getaway Boat.|r
.complete 47098,8 
.timer 36,Out Like Flynn RP
step
#completewith next
+|cRXP_WARN_Wait for the brief roleplay, which will be completed when the timer runs out.|r
*|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic.|r
.isOnQuest 47098
step << KulTiran
.goto 1161,68.16,21.99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Taelia|r
.accept 47189 >>Accept A Nation Divided
.target Taelia
step << KulTiran
.goto 1161,68.38,22.11
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Scouting Map|r
.complete 47189,1 
step << KulTiran
.goto 1161,75.72,23.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Taelia|r
.accept 47960 >>Accept Tiragarde Sound
.turnin 47189 >>Turn in A Nation Divided
.target Taelia
step << KulTiran
.goto 1161,67.60,22.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r
.accept 47181 >>Accept The Smoking Gun
.complete 47181,1 
.target Flynn Fairwind
step << KulTiran
.goto 1161,67.58,22.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r
.turnin 47181 >>Turn in The Smoking Gun
.target Flynn Fairwind
step << KulTiran
.goto 1161,67.97,21.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Cyrus Crestfall|r
.accept 47485 >>Accept The Ashvane Trading Company
.target Cyrus Crestfall
step << !KulTiran
.goto 1161,75.73,23.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Taelia|r
.turnin 47098 >>Turn in Out Like Flynn
.accept 47099 >>Accept Get Your Bearings
.target Taelia
step << !KulTiran
.goto 1161,74.17,24.80,10 >>Go near |cFF00FF25Will Melborne|r
.timer 6.5, Wait at Tradewinds Counting House
.isOnQuest 47099
step << !KulTiran
.goto 1161,75.59,19.51
>>|cRXP_WARN_Wait for the brief roleplay infront of the |cFFfa9602Tradewinds Counting House|r, which will be completed when the timer runs out.|r
>>|cFFd0342cDON'T go inside the |cFFfa9602Tradewinds Counting House|r yet.|r
.complete 47099,1 
.target Will Melborne
step << !KulTiran
.goto 1161,75.47,17.94,5 >>Go inside the |cFFfa9602Tradewinds Counting House.|r
.timer 3.6, bank rp.
.isOnQuest 47099
step << !KulTiran
.goto 1161,75.6,19.15,5,0
.goto 1161,73.53,13.81,5 >> Go inside the |cFFfa9602Snug Harbor Inn.|r
.timer 7.5, Inn RP
.isOnQuest 47099
step << !KulTiran
.goto 1161,74.13,12.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wesley Rockhold|r
.home >>Set your Hearthstone to Boralus
.target Wesley Rockhold
.isOnQuest 47099
step << !KulTiran
.isOnQuest 47099
.goto 1161,73.52,13.8,5,0
.goto 1161,67.02,14.96
>>Follow the Arrow. |cRXP_WARN_then wait for the brief roleplay, which will be completed when the timer runs out.|r
.complete 47099,3 
step << !KulTiran
.isOnQuest 47099
.goto 1161,67.2,15.05,10,0
.goto 1161,68.93,21.13,5,0
.goto 1161,67.45,21.39,5,0
.goto 1161,68.73,18.86,10,0
.goto 1161,68.96,21.15,5,0
.goto 1161,67.55,21,5,0
.goto 1161,67.16,22.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Joan Weber|r to unlock the flightpath |cRXP_WARN_then follow the arrow to continue.|r
.complete 47099,4 

step << !KulTiran
.goto 1161,67.18,22.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Taelia|r |cFFfa9602next to you.|r
.turnin 47099 >>Turn in Get Your Bearings
.accept 46729 >>Accept The Old Knight
.target Taelia
step << !KulTiran
.goto 1161,67.13,23.06
>>Enter the |cFFfa9602Harbormaster's Office.|r
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic|r
.complete 46729,1 
.timer 13,The Old Knight RP
step << !KulTiran
.isOnQuest 46729
.goto 1161,67.99,21.88
>>|cRXP_WARN_Wait for the brief roleplay, which will be completed when the timer runs out.|r
.gossipoption 48242 >>Talk to |cFF00FF25Cyrus Crestfall|r
.timer 83,Cyrus Tale RP
.target Cyrus Crestfall
step
#label WorkersR
.goto 1161,67.08,23.7,5,0
.goto 1161,68.59,25.26,15,0
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Davey Brindle|r and |TInterface/cursor/crosshair/interact.blp:20|tClick on the |cFF00FF25Formal Invitation|r |cFFfa9602on the table|r, as well as |cFF00FF25Wanted Poster|r
.accept 50699 >>Accept Worker's Rights
.goto 895,67.40,24.14
.accept 48070 >>Accept The Norwington Festival
.goto 895,67.14,24.80,-1
.accept 51358 >>Accept WANTED: Gryphon 'Nappers
.goto 895,66.84,24.36,-1
.target Davey Brindle
step
#completewith next
+|cRXP_WARN_Open any |cRXP_PICK_"Small Treasure Chests"|r you come across, as they provide a substantial amount of XP|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Maynard Algerson|r and |cFF00FF25Benjamin Algerson|r
.turnin 50699 >>Turn in Worker's Rights
.accept 49465 >>Accept Maximizing Resources
.accept 49452 >>Accept Inventory Deficit
.goto 895,68.92,20.43,10,0
.goto 895,68.93,20.59
.accept 49451 >>Accept Time Off Requests
.goto 895,68.89,20.44,5,0
.goto 895,68.89,19.84
.target Maynard Algerson
.target Benjamin Algerson
step
#completewith Wood-Adorned Skull
>>Kill |cFFFF5722Timberbough Invaders|r and |cFFFF5722Timberfang Lurkers|r and loot them for their |cFF00BCD4Skulls|r
.complete 49465,1 
.mob Timberbough Invader
.mob Timberfang Lurker
step
.goto 895,68.41,19.7
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Reclaimed Axe|r
.complete 49452,1,1 
step
.goto 895,68.17,18.95
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cFFDB2EEFEntangled Lumberjack.|r
.complete 49451,1,1 
.target Entangled Lumberjack
step
.goto 895,68.06,18.9
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Reclaimed Axe|r
.complete 49452,1,2 
step
.goto 895,67.64,19.38
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cFFDB2EEFEntangled Lumberjack.|r
.complete 49451,1,2 
.target Entangled Lumberjack
step
.goto 895,67.37,19.44
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cFFDB2EEFEntangled Lumberjack.|r
.complete 49451,1,3 
.target Entangled Lumberjack
step
.goto 895,67.4,19.36
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Reclaimed Axe|r
.complete 49452,1,3 
step
.goto 895,67.41,18.84
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Reclaimed Axe|r
.complete 49452,1,4 
step
.goto 895,67.43,18.6
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cFFDB2EEFEntangled Lumberjack.|r
.complete 49451,1,4 
.target Entangled Lumberjack
step
.goto 895,67.53,18.07
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Reclaimed Axe|r
.complete 49452,1,5 
step
.goto 895,67.27,17.9
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cFFDB2EEFEntangled Lumberjack.|r
.complete 49451,1,5 
.target Entangled Lumberjack
step
#label Wood-Adorned Skull
.goto 895,66.62,17.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lyssa Treewarden|r
.accept 49453 >>Accept Give a Dam
.accept 48557 >>Accept Sowing Saplings
.target Lyssa Treewarden
step
#completewith Loamy Soil
>>Kill |cFFFF5722Timberbough Invaders|r and |cFFFF5722Timberfang Lurkers|r and loot them for their |cFF00BCD4Skulls|r
.complete 49465,1 
.mob Timberbough Invader
.mob Timberfang Lurker
step
#completewith Loamy Soil
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cFFDB2EEFWoodchewing Beavers|r
.complete 49453,1 
.target Woodchewing Beaver
step
.goto 895,66.55,16.8
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Loamy Soil |r|cFFfa9602on the ground.|r
.complete 48557,1,1 
step
.goto 895,66.29,16.2
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Loamy Soil |r|cFFfa9602on the ground.|r
.complete 48557,1,2 
step
.goto 895,66.51,15.65
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Loamy Soil |r|cFFfa9602on the ground.|r
.complete 48557,1,3 
step
#label Loamy Soil
.goto 895,66.7,16.61
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Loamy Soil |r|cFFfa9602on the ground.|r
.complete 48557,1,4 
step
#completewith next
>>Kill |cFFFF5722Timberbough Invaders|r and |cFFFF5722Timberfang Lurkers|r and loot them for their |cFF00BCD4Skulls|r
.complete 49465,1 
.mob Timberbough Invader
.mob Timberfang Lurker
step
.goto 895,68.93,20.59
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cFFDB2EEFWoodchewing Beavers|r
.complete 49453,1 
.target Woodchewing Beaver

step
.goto 895,68.93,20.59
>>Kill |cFFFF5722Timberbough Invaders|r and |cFFFF5722Timberfang Lurkers|r and loot them for their |cFF00BCD4Skulls|r
.complete 49465,1 
.mob Timberbough Invader
.mob Timberfang Lurker

step
.goto 895,66.62,17.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lyssa Treewarden|r
.turnin 49453 >>Turn in Give a Dam
.turnin 48557 >>Turn in Sowing Saplings
.target Lyssa Treewarden
step
.goto 895,68.92,20.43,10,0
.goto 895,68.93,20.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Maynard Algerson|r
.turnin 49465 >>Turn in Maximizing Resources
.turnin 49452 >>Turn in Inventory Deficit
.turnin 49451 >>Turn in Time Off Requests
.accept 48369 >>Accept Emergent Strategy
.target Maynard Algerson
step
.goto 895,68.9,20.44,5,0
.goto 895,70.09,18.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Benjamin Algerson|r
.turnin 48369 >>Turn in Emergent Strategy
.accept 49468 >>Accept Required Webinar
.accept 49454 >>Accept Pest Prevention
.accept 49450 >>Accept Incident Reports
.target Benjamin Algerson
step
#completewith Webbed Lumberjack freed
>>Kill |cFFFF5722Enthralled Ashclaws|r, |cFFFF5722Enthralled Mossfangs,|r and |cFFFF5722Mossfang Eggs|r
.complete 49450,1 
.complete 49454,1 
.mob Enthralled Ashclaw
.mob Enthralled Mossfang
.mob Mossfang Egg
step
.goto 895,70.63,18.07
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cFFDB2EEFWebbed Lumberjack|r
.complete 49468,1,1 
.target Webbed Lumberjack
step
.goto 895,71.29,17.98
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cFFDB2EEFWebbed Lumberjack|r
.complete 49468,1,2 
.target Webbed Lumberjack
step
.goto 895,71.84,18.17
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cFFDB2EEFWebbed Lumberjack|r
.complete 49468,1,3 
.target Webbed Lumberjack
step
.goto 895,72.33,17.87
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cFFDB2EEFWebbed Lumberjack|r
.complete 49468,1,4 
.target Webbed Lumberjack
step
.goto 895,72.96,17.55
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Terrence Foster|r
.accept 50058 >>Accept The Witch's Pet
.target Terrence Foster
step
.goto 895,73.49,18.71
>>Kill the |cFFFF5722Mossfang Matriarch|r
>>|cFFFCDC00Avoid her Venom Wave frontal cone|r
.complete 50058,1 
.mob Mossfang Matriarch
step
#label Webbed Lumberjack freed
.goto 895,73.61,19.07
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cFFDB2EEFWebbed Lumberjack|r
.complete 49468,1,5 
.target Webbed Lumberjack
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 50058 >>Turn in The Witch's Pet
step
.goto 895,72.93,17.72,10,0
.goto 895,71.54,17.67,20,0
.goto 895,70.89,18.52,20,0
.goto 895,70.09,18.58
>>Kill |cFFFF5722Enthralled Ashclaws|r, |cFFFF5722Enthralled Mossfangs,|r and |cFFFF5722Mossfang Eggs|r
.complete 49450,1 
.complete 49454,1 
.mob Enthralled Ashclaw
.mob Enthralled Mossfang
.mob Mossfang Egg
step
.goto 895,70.09,18.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Benjamin Algerson|r
.turnin 49468 >>Turn in Required Webinar
.turnin 49454 >>Turn in Pest Prevention
.turnin 49450 >>Turn in Incident Reports
.accept 49467 >>Accept Witch of the Woods
.target Benjamin Algerson
step
.goto 895,70.45,13.75
>>Kill the |cFFFF5722Witch of the Woods|r and loot her for the |cFF00BCD4Locket|r
>>|cFFFCDC00Avoid her Crawling Swarm frontal cone|r
.complete 49467,1 
.mob Witch of the Woods
step
.goto 895,68.85,13.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Maynard Algerson|r
.turnin 49467 >>Turn in Witch of the Woods
.target Maynard Algerson
step
.isOnQuest 51358
.goto 895,67.38,22.07,20 >> Enter the |cFFfa9602Cave|r
step
.goto 895,67.2,21.70
>>Kill |cFFFF5722Boris|r and |cFFFF5722Lindel.|r
>>This quest is challenging. |cRXP_WARN_Skip this step if you are unable to defeat them.|r
.complete 51358,1 
.complete 51358,2 
.mob Lindel the Snatcher
.mob Silent Boris
step
.goto 895,66.93,23.07
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Mariah McKee|r
.fp Hatherford >>Get the Hatherford Flight Path
.target Mariah McKee
step
.isOnQuest 51358
.goto 895,66.42,24.42,10 >> Enter |cFFfa9602the House|r
step
.goto 895,66.27,24.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Dandy Jones|r
.turnin 51358 >>Turn in WANTED: Gryphon 'Nappers
.target Dandy Jones
.isQuestComplete 51358
step
.goto 895,66.32,24.80
.abandon 51358 >>Abandon WANTED: Gryphon 'Nappers
step
#completewith next
.goto 895,66.42,24.42,5 >> Leave the |cFFfa9602the House|r
step
.goto 895,66.32,24.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cFF00FF25Hatherford Guard.|r
.accept 50700 >>Accept Drust in Time
.target Hatherford Guard
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Drogrin Alewhisker|r and |cFF00FF25Recruit Brutis.|r
.turnin 50700 >>Turn in Drust in Time
.accept 49225 >>Accept Chasing the Leader
.accept 49229 >>Accept The Ruins Fought Back
.goto 895,62.73,29.95
.accept 49234 >>Accept A Marine Out of Water
.goto 895,62.95,29.92
.target Drogrin Alewhisker
.target Recruit Brutis
step
#completewith BirchT
>>Kill |cFFFF5722Ancient Protectors|r
.complete 49229,1 
.mob Ancient Protector
step
#completewith next
.goto 1171,44.51,88.32,15,0
.goto 1171,40.22,71.90,15 >>Go |cFFfa9602inside the cave|r
step
#label BirchT
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Birch Tomlin|r and |cFF00FF25Pendi Cranklefuse|r
.accept 49233 >>Accept I'm a Druid, Not a Priest
.goto 1171,50.39,70.36
.accept 49232 >>Accept Salvaging a Disaster
.goto 1171,51.27,70.58
.target Birch Tomlin
.target Pendi Cranklefuse
step
#completewith Ancient Protector
>>Kill |cFFFF5722Ancient Protectors|r
.complete 49229,1 
.mob Ancient Protector
step
#completewith Ancient Protector
>>Use the |T329590:0|t[Repurposed Gilnean Staff] on |cFFFF5722Cursed Raiders|r
.complete 49233,1 
.use 153350
.mob Cursed Raider
step
.goto 1171,57.34,65.78
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Drust Relic|r
.complete 49232,1,1 
step
.goto 1171,64.17,53.31,20,0
.goto 1171,58.63,37.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Hilde Firebreaker|r
.turnin 49225 >>Turn in Chasing the Leader
.accept 49260 >>Accept Backup While I Pack Up
.target Hilde Firebreaker
step
#completewith Ancient Protector
>>You aren't required to defend Firebreaker; you can simply proceed and the quest will complete automatically. |cRXP_WARN_However, be aware that if you die before this quest is completed, you'll have to start it over.|r
.complete 49260,1 
step
.goto 1171,62.59,55.61,10,0
.goto 1171,41.39,50.8
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Drust Relic|r
.complete 49232,1,2 
step
.goto 1172,44.19,69.85
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Drust Relic|r
.complete 49232,1,3 
step
.goto 1172,59.84,18.18
>>Kill |cRXP_ENEMY_Awakened Guardian|r
.complete 49234,1 
.mob Awakened Guardian
step
.goto 1172,59.55,13.12
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Drust Relic|r
.complete 49232,1,4 
step
.goto 1171,46.34,54.89
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Drust Relic|r
.complete 49232,1,5 
step
.goto 1171,44.99,60.75
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Drust Relic|r
.complete 49232,1,6 
step
#label Ancient Protector
.goto 1171,64.17,53.31,15,0
.goto 1171,58.63,37.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Hilde Firebreaker|r
.turnin 49260 >>Turn in Backup While I Pack Up
.target Hilde Firebreaker
.isQuestComplete 49260
step
#completewith next
>>Kill |cFFFF5722Ancient Protectors|r
.complete 49229,1 
.mob Ancient Protector
step
.goto 1171,51.27,70.58
>>Use the |T329590:0|t[Repurposed Gilnean Staff] on |cFFFF5722Cursed Raiders|r
.complete 49233,1 
.use 153350
.mob Cursed Raider
step
.goto 1171,51.27,70.58
>>Kill |cFFFF5722Ancient Protectors|r
.complete 49229,1 
.mob Ancient Protector
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Pendi Cranklefuse|r and |cFF00FF25Birch Tomlin|r
.turnin 49232 >>Turn in Salvaging a Disaster
.goto 1171,51.27,70.58
.turnin 49233 >>Turn in I'm a Druid, Not a Priest
.goto 1171,50.39,70.36
.target Pendi Cranklefuse
.target Birch Tomlin
step
#completewith next
.goto 1171,40.22,71.90,15,0
.goto 1171,44.51,88.32,15 >>Exit |cRXP_WARN_the cave|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Recruit Brutis|r and |cFF00FF25Drogrin Alewhisker|r
.turnin 49234 >>Turn in A Marine Out of Water
.goto 895,62.82,29.88
.turnin 49229 >>Turn in The Ruins Fought Back
.goto 895,62.73,29.95
.target Recruit Brutis
.target Drogrin Alewhisker
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Abbey Watkins|r and |cFF00FF25Harold Beckett|r
.turnin 48070 >>Turn in The Norwington Festival
.accept 48077 >>Accept The Stoat Hunt
.goto 895,55.45,24.67
.accept 48080 >>Accept An Element of Danger
.accept 48616 >>Accept Bolas and Birds
.goto 895,55.52,24.59
.target Abbey Watkins
.target Harold Beckett
step
#completewith Mudbrush
>>Use the |T135553:0|t[Bola Launcher] on |cRXP_ENEMY_Hollowbeak Falcons|r
.use 152643
.complete 48616,1 
.mob Hollowbeak Falcon
step
#completewith Mudbrush
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Stoat Den|r and kill |cRXP_ENEMY_Faintstep Stoat|r loot them for |T1029741:0|t|cRXP_LOOT_[Soft Stoat Pelt]|r
.complete 48077,1 
.mob Faintstep Stoat
step
#completewith Mudbrush
>>Kill |cRXP_ENEMY_Mudbrush Boar|r and loot them for |T133722:0|t|cRXP_LOOT_Rugged Boar Tusk|r
.complete 48080,1 
.mob Mudbrush Boar
step
.goto 895,56.26,23.88,15,0
.goto 895,56.9,23.44,10,0
.goto 895,56.31,25.08,10,0
.goto 895,56.19,26.51,10,0
.goto 895,58.03,27.5,10,0
.goto 895,58.3,25.4
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Caleb Batharen|r
.accept 48965 >>Accept Settle the Score
.target Caleb Batharen
step
.isOnQuest 48965
.goto 895,61.18,22.09 >> Enter the |cFFfa9602Cave|r
step
.goto 895,61.67,22.73
>>Kill |cRXP_ENEMY_Chartusk|r
.complete 48965,1 
step
#label Mudbrush
.goto 895,58.29,25.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Caleb Batharen|r
.turnin 48965 >>Turn in Settle the Score
.target Caleb Batharen
step
#completewith next
>>Use the |T135553:0|t[Bola Launcher] on |cRXP_ENEMY_Hollowbeak Falcons|r
.complete 48616,1 
.mob Hollowbeak Falcon
.use 152643
step
.goto 895,58.03,27.5,10,0
.goto 895,56.19,26.51,10,0
.goto 895,56.31,25.08,10,0
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Stoat Den|r and kill |cRXP_ENEMY_Faintstep Stoat|r loot them for |T1029741:0|t|cRXP_LOOT_[Soft Stoat Pelt]|r
.complete 48077,1 
.mob Faintstep Stoat
step
.goto 895,58.03,27.5,10,0
.goto 895,56.19,26.51,10,0
.goto 895,56.31,25.08,10,0
>>Use the |T135553:0|t[Bola Launcher] on |cRXP_ENEMY_Hollowbeak Falcons|r
.complete 48616,1 
.use 152643
.mob Hollowbeak Falcon
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Harold Beckett|r, |cFF00FF25Abbey Watkins|r and |cFF00FF25Melissa Kenny|r
.turnin 48616 >>Turn in Bolas and Birds
.turnin 48080 >>Turn in An Element of Danger
.goto 895,55.52,24.59
.turnin 48077,1 >>Turn in The Stoat Hunt
.goto 895,55.45,24.66
.accept 48670 >>Accept Runaway Rider
.goto 895,55.59,24.6
.target Harold Beckett
.target Abbey Watkins
.target Melissa Kenny
step
.goto 895,54.47,19.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Melissa Kenny|r
.turnin 48670 >>Turn in Runaway Rider
.accept 48196 >>Accept Following Eddie's Trail
.accept 48195 >>Accept Troublesome Troglodytes
.target Melissa Kenny
step
#completewith Stone Soup
>>Kill |cRXP_ENEMY_Grimestone Bullies|r and |cRXP_ENEMY_Grimestone Thrower|r
.complete 48195,1 
.complete 48195,2 
.mob Grimestone Bully
.mob Grimestone Thrower
step
.goto 895,56.09,17.95
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Hotshot's corpse|r
.complete 48196,1 
step
.goto 895,56.17,17.96
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Recipe Rock|r
>>|cRXP_WARN_Ideally accept this quest before killing the |cRXP_ENEMY_Grimestone Chefs|r|r
.accept 48778 >>Accept Stone Soup
step
#completewith Stone Soup
>>Kill |cRXP_ENEMY_Grimestone Chefs|r and loot them for |T237350:0|t|cRXP_LOOT_[Unidentifiable Meat]|r
.complete 48778,2 
.mob Grimestone Chef
step
.goto 895,56.15,17.99
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Soup Stone|r
.complete 48778,1,1 
step
.goto 895,55.95,17.51
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cFF00FF25Trapped Saurolisk|r
.accept 48597 >>Accept Saurolisk Escape
.target Trapped Saurolisk
step
.goto 895,56.38,17.79
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Post|r to free |cRXP_FRIENDLY_Trapped Saurolisk|r
.complete 48597,1,1 
.target Trapped Saurolisk
step
.goto 895,56.44,16.72
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Soup Stone|r
.complete 48778,1,2 
step
.goto 895,56.47,16.67
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Post|r to free |cRXP_FRIENDLY_Trapped Saurolisk|r
.complete 48597,1,2 
.target Trapped Saurolisk
step
.goto 895,56.22,16.14
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Bag of Horse Treats|r
.complete 48196,2 
step
.goto 895,56.03,15.3
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Soup Stone|r
.complete 48778,1,3 
step
.goto 895,55.88,14.45
>>Kill |cRXP_ENEMY_Boneface the Giant|r and loot him for |T135233:0|t|cRXP_LOOT_Boneface's "Key"|r
.complete 48196,3 
.mob Boneface the Giant
step
.goto 895,55.89,14.47
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Post|r to free |cRXP_FRIENDLY_Trapped Saurolisk|r
.complete 48597,1,3 
.target Trapped Saurolisk
step
.goto 895,55.62,14.58
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Trogg Cage|r to free |cRXP_FRIENDLY_Eddie Norwington|r
.complete 48196,4 
.target Eddie Norwingto
step
.goto 895,55.61,14.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Eddie Norwington|r
.turnin 48196 >>Turn in Following Eddie's Trail
.target Eddie Norwington
step
.goto 895,55.99,15.36,5,0
.goto 895,56.87,15.1
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Soup Stone|r
.complete 48778,1,4 
step
#completewith Stone Soup
>>Kill |cRXP_ENEMY_Grimestone Handlers|r and loot them for |T1526620:0|t|cRXP_LOOT_[Saurolisk Scale]|r
.complete 48778,3 
.mob Grimestone Handlers
step
.goto 895,58.07,14.57
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Stirring Bone|r
.complete 48778,4 
step
.goto 895,58.32,14.43
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Post|r to free |cRXP_FRIENDLY_Trapped Saurolisk|r
.complete 48597,1,4 
.target Trapped Saurolisk
step
.goto 895,58.44,15.27
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Post|r to free |cRXP_FRIENDLY_Trapped Saurolisk|r
.complete 48597,1,5 
.target Trapped Saurolisk
step
#label Stone Soup
.goto 895,58.18,15.63
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Post|r to free |cRXP_FRIENDLY_Trapped Saurolisk|r
.complete 48597,1,6 
.target Trapped Saurolisk
step
#completewith Bullies
>>Kill |cRXP_ENEMY_Grimestone Handlers|r and loot them for |T1526620:0|t|cRXP_LOOT_[Saurolisk Scale]|r
.complete 48778,3 
.mob Grimestone Handler
step
#completewith Bullies
>>Kill |cRXP_ENEMY_Grimestone Chefs|r and loot them for |T237350:0|t|cRXP_LOOT_[Unidentifiable Meat]|r
.complete 48778,2 
.mob Grimestone Chef
step
.goto 895,56.56,15.55
#label Bullies
>>Kill |cRXP_ENEMY_Grimestone Bullies|r and |cRXP_ENEMY_Grimestone Thrower|r
.complete 48195,1 
.complete 48195,2 
.mob Grimestone Bully
.mob Grimestone Thrower
step
#completewith next
>>Kill |cRXP_ENEMY_Grimestone Handlers|r and loot them for |T1526620:0|t|cRXP_LOOT_[Saurolisk Scale]|r
.goto 895,58.07,14.57
.complete 48778,3 
.mob Grimestone Handler
step
.goto 895,56.56,15.55
>>Kill |cRXP_ENEMY_Grimestone Chefs|r and loot them for |T237350:0|t|cRXP_LOOT_[Unidentifiable Meat]|r
.complete 48778,2 
.mob Grimestone Chef
step
.goto 895,56.56,15.55
>>Kill |cRXP_ENEMY_Grimestone Handlers|r and loot them for |T1526620:0|t|cRXP_LOOT_[Saurolisk Scale]|r
.complete 48778,3 
.mob Grimestone Handler
step
.goto 895,56.56,15.55
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Bubbling Cauldron|r
.turnin 48778 >>Turn in Stone Soup
step
.goto 895,54.47,19.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Melissa Kenny|r
.turnin 48195 >>Turn in Troublesome Troglodytes
.turnin 48597 >>Turn in Saurolisk Escape
.accept 48003 >>Accept The Lord's Behest
.target Melissa Kenny
step
.goto 895,51.57,27.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lord Aldrius Norwington|r
.turnin 48003 >>Turn in The Lord's Behest
.accept 48005 >>Accept Be Our Guest
.target Lord Aldrius Norwington
step
.goto 895,51.57,27.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lord Aldrius Norwington|r
.turnin 48003 >>Turn in The Lord's Behest
.accept 48005 >>Accept Be Our Guest
.target Lord Aldrius Norwington
step
.goto 895,51.45,26.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Dolan Northfield|r
.target Dolan Northfield
.complete 48005,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Joma|r and |cFF00FF25Majo|r
.accept 48898 >>Accept Lucky Charm
.accept 48902 >>Accept Monstrous Energy
.goto 895,51.31,25.90
.accept 48899 >>Accept Safety First
.goto 895,51.29,25.87
.target Joma
.target Majo
step
.goto 895,49.74,25.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Arthur Seville|r
.complete 48005,2 
.target Arthur Seville
step
#completewith next
.goto 895,49.74,25.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Arthur Seville|r
.vendor 126600 >> |cRXP_WARN_Empty bags/restock on food and water at Arthur Seville if necessary|r
.target Arthur Seville
step
.goto 895,48.7,28.1
>>Stand on the arrow to make |cRXP_ENEMY_Lucktail|r spawn |cRXP_WARN_and damage it to 60%|r
.complete 48898,1 
.mob Lucktail
step
.goto 895,48.12,25.43
>>Follow the arrow and damage |cRXP_ENEMY_Lucktail|r to 30%
.complete 48898,2 
.mob Lucktail
step
#completewith LucktailWaterfall
>>Kill |cRXP_ENEMY_Venomscale Slitherer|r and loot them for |cRXP_LOOT_Pulsating Extract|r
*|cRXP_WARN_Kill every |cRXP_ENEMY_Venomscale Slitherer|r that you see in close proximity.|r
.complete 48902,1 
.mob Venomscale Slitherer
step
.goto 895,48.56,24.91
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Durable Seashell|r |cFFfa9602on the ground.|r
.complete 48899,1,1 
step
.goto 895,48.58,23.57
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Durable Seashell|r |cFFfa9602on the ground.|r
.complete 48899,1,2 
step
.goto 895,49.1,23.66
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Durable Seashell|r |cFFfa9602on the ground.|r
.complete 48899,1,3 
step
.goto 895,49.51,22.55
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Durable Seashell|r |cFFfa9602on the ground.|r
.complete 48899,1,4 
step
.goto 895,49.42,22.02
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Durable Seashell|r |cFFfa9602on the ground.|r
.complete 48899,1,5 
step
.goto 895,49.67,22.37
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Durable Seashell|r |cFFfa9602on the ground.|r
.complete 48899,1,6 
step
.goto 895,49.67,22.37
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Durable Seashell|r |cFFfa9602on the ground.|r
.complete 48899,1,7 
step
.goto 895,50.18,22.51
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Durable Seashell|r |cFFfa9602on the ground.|r
.complete 48899,1,8 
step
.goto 895,50.7,22.19
#label LucktailWaterfall
>>Kill |cFFFF5722Lucktail|r and loot him for |cFF00BCD4Lucktail's Tail|r
.complete 48898,3 
.mob Lucktail
step
.goto 895,47.63,23.92,15,0
.goto 895,50.7,22.19
>>Kill |cRXP_ENEMY_Venomscale Slitherer|r and loot them for |cRXP_LOOT_Pulsating Extract|r
.complete 48902,1 
.mob Venomscale Slitherer
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Joma|r and |cFF00FF25Majo|r
.turnin 48898 >>Turn in Lucky Charm
.turnin 48902 >>Turn in Monstrous Energy
.goto 895,51.32,25.90
.turnin 48899 >>Turn in Safety First
.accept 48903 >>Accept The Perfect Horse, of Course
.goto 895,51.28,25.87
.timer 27, Majo RP
.target Majo
.target Joma
step
#completewith
>>|cRXP_WARN_Hurry! If you move quickly, you can complete a few objectives before Majo reaches the stable.|r
.complete 48903,1 
.target Majo
step
#completewith next
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Hestia Strongbolt|r
.fp >>Get the Norwington Estate Flight Path
.target Hestia Strongbolt
step
.goto 895,53.10,28.36
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Wanted Posters|r
.accept 48347 >>Accept Anglepoint Wharf
.accept 51367 >>Accept WANTED: Raging Earthguard
step
.goto 895,53.31,28.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Terry Rigglesmith|r |cFFfa9602inside the small house.|r
.complete 48005,4 
.target Terry Rigglesmith
step
.goto 895,53.48,28.75
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25George Mitchell|r |cFFfa9602outside the small house.|r
.complete 48005,3 
.target George Mitchell
step
.goto 895,51.68,25.67
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Goldie|r
.complete 48903,2 
.timer 5, Horse RP
.target Goldie
step
.goto 895,51.79,25.83
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Scout|r
.complete 48903,3 
.timer 5, Horse RP
.target Scout
step
.goto 895,51.87,25.98
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Avalon|r
.complete 48903,4 
.timer 5, Horse RP
.target Avalon
step
.goto 895,51.83,26.31
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Maxwell|r
.complete 48903,5 
.target Maxwell
step
.goto 895,51.81,26.14
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Majo|r
.complete 48903,6 
.target Majo
step
.goto 895,51.81,26.36
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Joma|r
.turnin 48903,1 >>Turn in The Perfect Horse, of Course
.target Joma
step
.goto 895,51.65,26.21
.vehicle >> Interact with |cRXP_FRIENDLY_Cooper|r

.target Cooper
.isOnQuest 48005
step
.goto 895,51.57,27.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lord Aldrius Norwington|r
.turnin 48005 >>Turn in Be Our Guest
.accept 48004 >>Accept Beginner Equitation
.target Lord Aldrius Norwington
step
.goto 895,51.41,26.86
>>Use |T132226:0|t(1)[Rapid Dash] |cRXP_WARN_to sprint|r and |T1661331:0|t(2)[Harpoon Jab] |cRXP_WARN_to jab gnolls.|r|
.complete 48004,2,1 
step
.goto 895,51.1,26.79
>>Use |T132226:0|t(1)[Rapid Dash] |cRXP_WARN_to sprint|r and |T1661331:0|t(2)[Harpoon Jab] |cRXP_WARN_to jab gnolls.|r|
.complete 48004,2,2 
step
.goto 895,50.8,26.66
>>Use |T132226:0|t(1)[Rapid Dash] |cRXP_WARN_to sprint|r and |T1661331:0|t(2)[Harpoon Jab] |cRXP_WARN_to jab gnolls.|r|
.complete 48004,2,3 
step
.goto 895,51.08,26.33
>>Use |T132226:0|t(1)[Rapid Dash] |cRXP_WARN_to sprint|r and |T1661331:0|t(2)[Harpoon Jab] |cRXP_WARN_to jab gnolls.|r|
.complete 48004,2,4 
step
.goto 895,51.41,26.87
>>Use |T132226:0|t(1)[Rapid Dash] |cRXP_WARN_to sprint|r and |T1661331:0|t(2)[Harpoon Jab] |cRXP_WARN_to jab gnolls.|r|
.complete 48004,2,5 
step
.goto 895,51.1,26.79
>>Use |T132226:0|t(1)[Rapid Dash] |cRXP_WARN_to sprint|r and |T1661331:0|t(2)[Harpoon Jab] |cRXP_WARN_to jab gnolls.|r|
.complete 48004,2,6 
step
.loop 15,895,51.6,26.92,50.94,27.92,50.33,27.04,50.99,25.99,51.27,26.44
>>|cRXP_WARN_Target|r |cRXP_FRIENDLY_Paper Zeppelins|r and |cRXP_WARN_throw |T1661331:0|t(3)[Bolas] at them.|r
>>Use |T132226:0|t(1)[Rapid Dash] |cRXP_WARN_to sprint|r
.complete 48004,3 
.target Paper Zeppelin
step
.goto 895,50.9,26.81
>>|cRXP_WARN_You only have to jump near/along the fences, not necessarily OVER the fences.|r
>>Use |T132226:0|t(1)[Rapid Dash] |cRXP_WARN_to sprint|r
.complete 48004,4 
step
.goto 895,51.57,27.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lord Aldrius Norwington|r
.turnin 48004 >>Turn in Beginner Equitation
.accept 48087 >>Accept Equine Retrieval
.accept 48939 >>Accept Show Me What You've Got
.target Lord Aldrius Norwington
step
#completewith next
#title Challenge Explanation
+|cFFFF0000Read before proceeding;|r
+Initially, use |T132226:0|t(1)[Rapid Dash] |cRXP_WARN_to sprint and build stacks via fence jumps. Upon reaching 15 stacks, prioritize destroying Zeppelins with "Bolas" and jabbing Gnolls, while maintaining the buff by renewing it every 5 seconds.|r Keep "Rapid Dash" active for efficiency.
.isOnQuest 48939
step
.goto 895,51.52,27.03,5 >> |cRXP_WARN_Once you arrive at your destination, a timer will start. You'll have just 60 seconds to finish your challenge.|r
.timer 66, Challenge Time
.isOnQuest 48939
step
.loop 10,895,51.61,26.92,50.94,27.9,50.33,27.05,50.99,26.02
>>Initially, use |T132226:0|t(1)[Rapid Dash] |cRXP_WARN_to sprint and build stacks via fence jumps. Upon reaching 15 stacks, prioritize destroying Zeppelins with "Bolas" and jabbing Gnolls, while maintaining the buff by renewing it every 5 seconds.|r Keep "Rapid Dash" active for efficiency.
.complete 48939,2
step
.goto 895,51.57,27.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lord Aldruis Norwington|r
.turnin 48939 >>Turn Show Me What You've Got
.target Lord Aldruis Norwington
step
.goto 895,52.57,28.72
.exitvehicle >> |cRXP_WARN_Dismount Cooper by pressing the |r[Exit] |cRXP_WARN_button on your action bars.|r
*|cRXP_WARN_Alternatively, you can use this macro;|r
.link /leavevehicle>> CLICK HERE FOR MACRO.
*|cRXP_WARN_It's recommended to safe this macro for future use.|r
step
.goto 895,53.16,30.7
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Rose|r
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic.|r
.complete 48087,1 
.target Rose
step
.goto 895,52.54,28.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lord Aldrius Norwington|r
.complete 48087,2 
.target Lord Aldrius Norwington
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lord Aldrius Norwington|r and |cFF00FF25Gora Layton|r
.turnin 48087 >>Turn in Equine Retrieval
.accept 48088 >>Accept No Party Like a Trogg Party
.goto 895,52.54,28.50
.accept 48089 >>Accept Mountain Sounds
.goto 895,52.48,28.55
.target Lord Aldrius Norwington
.target Gora Layton
step
#completewith Grimestone Intruders
>>Kill |cRXP_ENEMY_Grimestone intruders|r
.complete 48088,1 
.mob Grimestone Invader
step
.goto 895,52.5,28.52
>>Use |T134228:0|t[Battlehorn of the Mountain] |cRXP_WARN_near Kul Tirans|r
>>|cRXP_WARN_Don't mount |cRXP_FRIENDLY_Cooper|r as you will be faster without him.|r
.complete 48089,1,3 
.use 153357
step
#label Grimestone Intruders
.goto 895,51.61,29.59,15,0
.goto 895,51.01,28.48,15,0
.goto 895,50.96,27.04,15,0
.goto 895,51.63,25.97,15,0
.goto 895,53.06,28.64
>>Use |T134228:0|t[Battlehorn of the Mountain] to rally nearby Kul Tirans.
>>|cRXP_WARN_Don't mount |cRXP_FRIENDLY_Cooper|r as you will be faster without him.|r
.use 153357
.complete 48089,1 
step
.loop 20,895,51.61,29.59,51.01,28.48,50.96,27.04,51.63,25.97,53.06,28.64
>>Kill |cRXP_ENEMY_Grimestone intruders|r
.complete 48088,1 
.mob Grimestone intruders
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Gora Layton|r and |cFF00FF25Lord Aldrius Norwington.|r
.turnin 48088 >>Turn in No Party Like a Trogg Party
.goto 895,52.54,28.46
.turnin 48089 >>Turn in Mountain Sounds
.goto 895,52.49,28.55
.target Lord Aldrius Norwington
.target Gora Layton
step
.goto 895,51.67,29.66
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Job Flyer|r
.accept 49393 >>Accept The Roughnecks
step
.goto 895,47.26,32.37
>>Kill the |cRXP_ENEMY_Raging Earthguard|r |cRXP_WARN_However, if it proves too challenging, feel free to skip it.|r
.complete 51367,1 
.mob Raging Earthguard
step
.goto 895,49.56,30.20,15,0
.goto 895,49.46,31.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thomas Pinker|r
.accept 50026 >>Accept Save Our Shipmates
step
.goto 895,50.31,37.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Henry Hardwick|r
.turnin 50026 >>Turn in Save Our Shipmates
.accept 47755 >>Accept Captured and Enraptured
.accept 50002 >>Accept A Very Precious Cargo

.target Henry Hardwick
step
#completewith Joe
.use 151135 >>|T133700:0|tUse [Stein of Grog] on |cRXP_ENEMY_Enthralled Sailors.|r
.complete 47755,1 
.mob Enthralled Sailor
step
.goto 895,51.11,35.80
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Earless Joe|r
.accept 50059 >>Accept Can't Hear A Thing
.target Earless Joe
step
#label Anthemusa
.line 895,51.11,35.80,52.07,35.62,52.81,34.62,53.89,33.72,53.64,32.66
.goto 895,53.7,32.8,15,0
.goto 895,52.07,35.62,15,0
.goto 895,52.81,34.62,15,0
.goto 895,53.89,33.72,15,0
.goto 895,53.64,32.66
>>Kill |cRXP_ENEMY_Anthemusa|r
.complete 50059,1 
.mob Anthemusa
.use 151135
step
.goto 895,55.49,35.93
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Penny "Precious" Hardwick|r
.turnin 50002 >>Turn in A Very Precious Cargo
.target Penny "Precious" Hardwick
step
.line 895,55.49,35.94,53.87,35.19,51.59,35.02,51.11,35.8
.goto 895,53.87,35.19,15,0
.goto 895,51.59,35.02,15,0
.goto 895,51.11,35.8
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Earless Joe|r
.turnin 50059 >>Turn in Can't Hear A Thing
.target Earless Joe
step
.goto 895,50.31,37.23
.use 151135 >>|T133700:0|tUse [Stein of Grog] on |cRXP_ENEMY_Enthralled Sailors.|r
.complete 47755,1 
.mob Enthralled Sailor
step <<skip
.loop 15,895,54.77,34.77,53.87,35.19,52.79,35.29,51.49,36.72,51.11,35.8,51.59,35.02,53.95,33.82,54.77,34.77
>>Finish killing Alluring Sirens and Lichenjaw Saurolisks. Click on the Shipwrecked Supplies and Siren Wind Chimes
.complete 50009,1 
step
.goto 895,50.31,37.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Henry Hardwick|r
.turnin 47755 >>Turn in Captured and Enraptured
.target Henry Hardwick
step
.goto 895,51.65,26.21
.vehicle >> Interact with |cRXP_FRIENDLY_Cooper|r
.target Cooper
.isOnQuest 51367
step
.goto 895,51.57,27.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lord Aldrius Norwington|r
.turnin 51367 >>Turn in WANTED: Raging Earthguard
.accept 49036 >>Accept Best In Show
.target Lord Aldrius Norwington
step
#completewith next
#title Challenge Explanation 2
+|cFFFF0000Read before proceeding;It's harder than before.|r
+Initially, use |T132226:0|t(1)[Rapid Dash] |cRXP_WARN_to sprint and build stacks via fence jumps. Upon reaching 15 stacks, prioritize destroying Zeppelins with "Bolas" and jabbing Gnolls, while maintaining the buff by renewing it every 5 seconds.|r Keep "Rapid Dash" active for efficiency.
.isOnQuest 49036
step
.goto 895,51.52,27.03,5 >> |cRXP_WARN_Once you arrive at your destination, a timer will start. You'll have just 60 seconds to finish your challenge.|r
.timer 66, Challenge Time
.isOnQuest 49036
step
.loop 10,895,51.61,26.92,50.94,27.9,50.33,27.05,50.99,26.02
>>Initially, use |T132226:0|t(1)[Rapid Dash] |cRXP_WARN_to sprint and build stacks via fence jumps. Upon reaching 15 stacks, prioritize destroying Zeppelins with "Bolas" and jabbing Gnolls, while maintaining the buff by renewing it every 5 seconds.|r Keep "Rapid Dash" active for efficiency.
.complete 49036,2
step
.goto 895,51.57,27.28
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lord Aldruis Norwington|r
.turnin 49036 >>Turn in Best In Show
.target Lord Aldruis Norwington
step
.goto 895,52.57,28.72
.exitvehicle >> |cRXP_WARN_Dismount Cooper by pressing the |r[Exit] |cRXP_WARN_button on your action bars.|r
*|cRXP_WARN_Alternatively, you can use this macro;|r
.link /leavevehicle>> CLICK HERE FOR MACRO.
*|cRXP_WARN_It's recommended to safe this macro for future use.|r
step
#completewith next
.goto 895,42.48,23.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Dagin|r
.fp >>Get the Roughneck Camp Flight Path
.target Dagin
step
.goto 895,42.16,22.99
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Wanted Poster|r
.accept 51368 >>Accept WANTED: The Hornet
step
#label HelloTagart
.goto 895,42.36,22.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Tagart|r
.turnin 49393 >>Turn in The Roughnecks
.accept 49394 >>Accept Hold Still
.accept 49395 >>Accept The Bears and the Bees
.target Tagart
step
#completewith HelpingHenry
>>Use |T135649:0|t[Goat Shears] on |cRXP_ENEMY_Gentle Goats.|r
>>|cRXP_WARN_Goats may become hostile|r*.
.complete 49394,1 
.use 153596
.target Gentle Goat
step
#completewith HelpingHenry
>>Kill |cRXP_ENEMY_Scruffhide Bears|r
.complete 49395,2 
.mob Scruffhide Bear
step
.goto 895,45.39,20.32
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Sticky Bee Honey|r
.complete 49395,1,1 
step
.goto 895,45.94,20.55
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Sticky Bee Honey|r
.complete 49395,1,2 
step
.goto 895,46.49,19.59
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Sticky Bee Honey|r
.complete 49395,1,3 
step
.goto 895,47.44,19.38
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Sticky Bee Honey|r
.complete 49395,1,4 
step
.goto 895,47.1,18.7
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Sticky Bee Honey|r
.complete 49395,1,5 
step
.goto 895,47.46,18.22,10,0
.goto 895,47.11,18.2
>>Kill the |cRXP_ENEMY_Hornet|r |cFFfa9602inside the cave|r|cRXP_WARN_If this quest can be very difficult; feel free to skip it|r
.complete 51368,1 
.mob The Hornet
step
.goto 895,47.44,18.04
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Sticky Bee Honey|r
.complete 49395,1,6 
step
.goto 895,47.7,17.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25"Helpless" Henry|r
.accept 49412 >>Accept Helping Henry
.target "Helpless" Henry
step
.goto 895,48.18,18.11
>>Kill |cRXP_ENEMY_Brawr|r
.complete -49412,1 
.mob Brawr
step
#label HelpingHenry
.goto 895,47.68,17.68
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25"Helpless" Henry|r
.turnin -49412 >>Turn in Helping Henry
.target "Helpless" Henry
step
#completewith next
>>Use |T135649:0|t[Goat Shears] on |cRXP_ENEMY_Gentle Goats.|r
>>|cRXP_WARN_Goats may become hostile when shearing them|r.
.complete 49394,1 
.use 153596
.target Gentle Goat
step
.goto 895,42.36,22.27
>>Kill |cRXP_ENEMY_Scruffhide Bears|r
.complete 49395,2 
.mob Scruffhide Bear
step
.goto 895,42.36,22.27
>>Use |T135649:0|t[Goat Shears] on |cRXP_ENEMY_Gentle Goats.|r
>>|cRXP_WARN_Goats may become hostile when shearing them|r.
.complete 49394,1 
.use 153596
.target Gentle Goat
step
.goto 895,42.36,22.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jagart|r
.turnin 51368 >>Turn in WANTED: The Hornet
.turnin 49394 >>Turn in Hold Still
.turnin 49395 >>Turn in The Bears and the Bees
.isQuestComplete 51368
.target Jagart
step
.goto 895,42.36,22.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jagart|r
.turnin 49394 >>Turn in Hold Still
.turnin 49395 >>Turn in The Bears and the Bees
.target Jagart
step
#completewith HelloAgainTagart
.abandon 51368 >>Abandon WANTED: The Hornet
.isOnQuest 51368
step
.goto 895,42.49,22.71
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rulf|r
.accept 49735 >>Accept Protect the Nests
.accept 49710 >>Accept An Offering of Eggs
.target Rulf
step
#completewith Spotted Gryphon Egg
>>Kill |cRXP_ENEMY_Hungry Dewscales|r
.complete 49735,1 
.mob Hungry Dewscale
step
.goto 895,44.76,20.21
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_FRIENDLY_Spotted Gryphon Egg|r
.complete 49710,1,1 
step
.goto 895,45.87,18.48
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_FRIENDLY_Spotted Gryphon Egg|r
.complete 49710,1,2 
step
.goto 895,46.38,18.25
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_FRIENDLY_Spotted Gryphon Egg|r
.complete 49710,1,3 
step
#label Spotted Gryphon Egg
.goto 895,46.38,18.25
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_FRIENDLY_Spotted Gryphon Egg|r
.complete 49710,1.4 
step
.goto 895,47.94,16.47
>>Kill |cRXP_ENEMY_Hungry Dewscales|r
.complete 49735,1 
.mob Hungry Dewscales
step
.goto 895,47.94,16.47
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Gryphon Nest|r
.turnin 49710 >>Turn in An Offering of Eggs
step
.goto 895,47.85,16.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Shawn McClinter|r
.turnin 49735 >>Turn in Protect the Nests
.accept 49417 >>Accept Roughneck Riders
.target Shawn McClinter
step
.goto 895,47.91,18.53
>>Use |T1373906:0|t[Tether Shot] on |cRXP_FRIENDLY_Greatfeather|r
>>|cRXP_WARN_Use [1],[2],[3] on cooldown.|r
.complete 49417,1 
.use 153679
.target Greatfeather
step
#label HelloAgainTagart
.goto 895,42.36,22.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25cTagart|r
.turnin 49417,1 >>Turn in Roughneck Riders
.accept 49418 >>Accept Big Boss
.target Tagart
step
.goto 895,41.99,16.76
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Boss Tak|r
.turnin 49418 >>Turn in Big Boss
.accept 49433 >>Accept Wendies
.accept 49435 >>Accept Where'd They Go?
.target Boss Tak
step
.goto 895,42.27,15.49
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Bloodied Boot|r
.complete 49435,1 
step
#completewith next
>>Kill |cRXP_ENEMY_Savage Wendigos|r
.complete 49433,1 
.mob Savage Wendigo
step
.goto 895,43.68,15.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25"Helpless" Henry|r
.accept 49419 >>Accept Frozen
.target "Helpless" Henry
step
.goto 895,43.73,14.66
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Roughneck Supplies|r |cFFfa9602by the Supply Cart|r
.complete 49435,2 
step
.goto 895,44.91,15.50
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Griddon|r
.accept 49431 >>Accept Warm and Cozy
.target Griddon
step
#completewith Prince Rathaw
>>Kill |cFF00BCD4Steam Elementals|r and loot them for |cRXP_LOOT_Steamy Essence|r.
.complete 49431,1 
step
.goto 895,45.72,14.97
.cast 6478 >>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Steam Shards|r
.isOnQuest 49431
step
.goto 895,46.77,15.15
.cast 6478 >>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Steam Shards|r
.isOnQuest 49431
step
.goto 895,46.81,14.72
.cast 6478 >>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Steam Shards|r
.isOnQuest 49431
step
.goto 895,46.81,13.79
.cast 6478 >>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Steam Shards|r
.isOnQuest 49431
step
#label Prince Rathaw
.goto 895,48.67,14.62
>>Kill |cFFFF5722Prince Rathaw|r and loot him for |cFFFF5722Fiery Essence|r
.complete 49419,1 
.mob Prince Rathaw
step
.goto 895,44.91,15.5
>>Kill |cFF00BCD4Steam Elementals|r and loot them for |cRXP_LOOT_Steamy Essence|r.
.complete 49431,1 
step
.goto 895,44.91,15.5
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Griddon|r
.turnin 49431,1 >>Turn in Warm and Cozy
.target Griddon
step
.goto 895,43.68,15.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25"Helpless" Harry|r
.target "Helpless" Harry
.turnin 49419 >>Turn in Frozen
step
#completewith Rucksack
>>Kill |cRXP_ENEMY_Savage Wendigos|r
.complete 49433,1 
.mob Savage Wendigo
step
.goto 895,41.58,13.99
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Roughneck Axe|r
.complete 49435,3 
step
.goto 895,39.68,13.35
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Discarded Rucksack|r
.complete 49435,4 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Boss Tak|r |cFFfa9602next to you.|r
.turnin 49435 >>Turn in Where'd They Go?
.accept 49439 >>Accept Boss' Revenge
.target Boss Tak
step
#label Rucksack
.goto 895,39.33,12.37
>>Kill |cRXP_ENEMY_Whompus|r |cFFfa9602in the Cave.|r
.complete 49439,1 
.mob Whompus
step
.goto 895,42.27,15.49
>>Kill |cRXP_ENEMY_Savage Wendigos|r
.complete 49433,1 
.mob Savage Wendigo
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Boss Tak|r |cFFfa9602next to you.|r
.turnin 49433 >>Turn in Wendies
.turnin 49439 >>Turn in Boss' Revenge
.accept 49719 >>Accept Getting Paid
.target Boss Tak
step
.goto 895,42.37,22.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Tagart|r
.turnin 49719 >>Turn in Getting Paid
.target Tagart
step
.goto 895,43.74,25.38,20,0
.goto 895,43.71,26.64,20,0
.goto 895,42.28,29.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brother Therold|r
.turnin 48347 >>Turn in Anglepoint Wharf
.accept 48540 >>Accept Aiding the Wharf
step
.goto 895,42.28,29.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brother Therold|r
.turnin 48347 >>Turn in Anglepoint Wharf
.accept 48540 >>Accept Aiding the Wharf
.target Brother Therold
step
.goto 895,43.23,29.67
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Bundle of Vellum|r on the barrel.
>>|cRXP_WARN_it's very small.|r
.complete 48540,2 
step
.goto 895,41.93,30.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Hera Copeland|r
.complete 48540,1 
.skipgossip
.target Hera Copeland
step
.goto 895,41.79,30.04
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Jar of Blubber|r
.complete 48540,3 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brother Therold|r and |cFF00FF25Okri Putterwrench|r
.turnin 48540 >>Turn in Aiding the Wharf
.accept 48352 >>Accept A Cure from the Sea
.accept 49268 >>Accept Sharks in the Water
.goto 895,42.28,29.31
.accept 48348 >>Accept Stinging Barbs
.goto 895,42.19,29.32
.target Brother Therold
.target Okri Putterwrench
step
#completewith Intact Venomous Barb
>>Kill |cRXP_ENEMY_Invading Dreadmaw|r
>>|cRXP_WARN_Run on the seafloor for faster movement.|r
.complete 49268,1 
.mob Invading Dreadmaw
step
#completewith Intact Venomous Barb
>>Kill |cRXP_ENEMY_Barbtail Stingray|r and loot them for |T132274:0|t|cRXP_LOOT_[Intact Venomous Barb]|r
.complete 48348,1 
.mob Barbtail Stingray
step
.goto 895,41.7,29.07
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Seaweed|r on the seafloor.
>>|cRXP_WARN_Kill |cRXP_ENEMY_Invading Dreadmaw|r and |cRXP_ENEMY_Barbtail Stingray|r while picking up the |cRXP_PICK_Seaweed|r|r
.complete 48352,1,1 
step
.goto 895,41.47,28.98
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Seaweed|r on the seafloor.
>>|cRXP_WARN_Kill |cRXP_ENEMY_Invading Dreadmaw|r and |cRXP_ENEMY_Barbtail Stingray|r while picking up the |cRXP_PICK_Seaweed|r|r
.complete 48352,1,2 
step
.goto 895,40.93,28.25
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Seaweed|r on the seafloor.
>>|cRXP_WARN_Kill |cRXP_ENEMY_Invading Dreadmaw|r and |cRXP_ENEMY_Barbtail Stingray|r while picking up the |cRXP_PICK_Seaweed|r|r
.complete 48352,1,3 
step
.goto 895,40.12,28.58
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Seaweed|r on the seafloor.
>>|cRXP_WARN_Kill |cRXP_ENEMY_Invading Dreadmaw|r and |cRXP_ENEMY_Barbtail Stingray|r while picking up the |cRXP_PICK_Seaweed|r|r
.complete 48352,1,4 
step
.goto 895,40.24,29.19
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Seaweed|r on the seafloor.
>>|cRXP_WARN_Kill |cRXP_ENEMY_Invading Dreadmaw|r and |cRXP_ENEMY_Barbtail Stingray|r while picking up the |cRXP_PICK_Seaweed|r|r
.complete 48352,1,5 
step
.goto 895,40.26,29.79
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Seaweed|r on the seafloor.
>>|cRXP_WARN_Kill |cRXP_ENEMY_Invading Dreadmaw|r and |cRXP_ENEMY_Barbtail Stingray|r while picking up the |cRXP_PICK_Seaweed|r|r
.complete 48352,1,6 
step
.goto 895,40.86,29.55
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Seaweed|r on the seafloor.
>>|cRXP_WARN_Kill |cRXP_ENEMY_Invading Dreadmaw|r and |cRXP_ENEMY_Barbtail Stingray|r while picking up the |cRXP_PICK_Seaweed|r|r
.complete 48352,1,7 
step
#label Intact Venomous Barb
.goto 895,41.04,29.46
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Seaweed|r on the seafloor.
>>|cRXP_WARN_Kill |cRXP_ENEMY_Invading Dreadmaw|r and |cRXP_ENEMY_Barbtail Stingray|r while picking up the |cRXP_PICK_Seaweed|r|r
.complete 48352,1,8 
.mob Invading Dreadmaw
.mob Barbtail Stingray
step
#completewith next
>>Kill |cRXP_ENEMY_Invading Dreadmaw|r
>>|cRXP_WARN_Run on the seafloor for faster movement.|r
.complete 49268,1 
.mob Invading Dreadmaw
step
.loop 15,895,40.58,30.41,40.09,30.9,41.04,31.54,41.78,31.05
>>Kill |cRXP_ENEMY_Barbtail Stingray|r and loot them for |T132274:0|t|cRXP_LOOT_[Intact Venomous Barb]|r
.complete 48348,1 
.mob Barbtail Stingray
step
.loop 15,895,40.58,30.41,40.09,30.9,41.04,31.54,41.78,31.05
>>Kill |cRXP_ENEMY_Invading Dreadmaw|r
>>|cRXP_WARN_Run on the seafloor for faster movement.|r
.complete 49268,1 
.mob Invading Dreadmaw
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Okri Putterwrench|r and |cFF00FF25Brother Therold|r
.turnin 48348 >>Turn in Stinging Barbs
.goto 895,42.19,29.32
.turnin 48352,2 >>Turn in A Cure from the Sea
.turnin 49268 >>Turn in Sharks in the Water
.accept 49292 >>Accept Algae Shakes
.accept 48353 >>Accept Pulse of the Wharf
.goto 895,42.28,29.31
.target Okri Putterwrench
.target Brother Therold
step
.goto 895,42.61,27.42
>>Interact with |cRXP_FRIENDLY_Nauseated Villager|r to treat him.
>>|cRXP_WARN_Fly away quickly to avoid aggroing the |cRXP_ENEMY_Infectious Gutworm|r after treating |cRXP_FRIENDLY_Nauseated Villager|r |r
.use 153513
.complete 49292,1,1 
.target Nauseated Villager
step
.goto 895,42.30,26.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Julian Nichols|r
.complete 48353,1 
.skipgossip
.target Julian Nichols
step
.goto 895,42.24,27.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Ginger Freelin|r
.complete 48353,2 
.skipgossip
.target Ginger Freelin
step
.goto 895,42.1,27.23
>>Interact with |cRXP_FRIENDLY_Nauseated Villager|r to treat him.
>>|cRXP_WARN_Fly away quickly to avoid aggroing the |cRXP_ENEMY_Infectious Gutworm|r after treating |cRXP_FRIENDLY_Nauseated Villager|r |r
.use 153513
.complete 49292,1,2 
.target Nauseated Villager
step
.goto 895,41.9,27.31
>>Interact with |cRXP_FRIENDLY_Nauseated Villager|r to treat him.
>>|cRXP_WARN_Fly away quickly to avoid aggroing the |cRXP_ENEMY_Infectious Gutworm|r after treating |cRXP_FRIENDLY_Nauseated Villager|r |r
.use 153513
.complete 49292,1,3 
.target Nauseated Villager
step
.isOnQuest 48353
.goto 895,41.68,26.98
.gossipoption 47948 >>Talk to |cFF00FF25Aaron Gutier|r
.timer 9, Time until |cRXP_ENEMY_Aaron Gutier's|r vulnerability.
.target Aaron Gutier
step
.goto 895,41.53,26.5
>>Interact with |cRXP_FRIENDLY_Nauseated Villager|r to treat him.
>>|cRXP_WARN_Fly away quickly to avoid aggroing the |cRXP_ENEMY_Infectious Gutworm|r after treating |cRXP_FRIENDLY_Nauseated Villager|r |r
.use 153513
.complete 49292,1,4 
.target Nauseated Villager
step
.goto 895,41.87,26.68
>>Interact with |cRXP_FRIENDLY_Nauseated Villager|r to treat him.
>>|cRXP_WARN_Fly away quickly to avoid aggroing the |cRXP_ENEMY_Infectious Gutworm|r after treating |cRXP_FRIENDLY_Nauseated Villager|r |r
.use 153513
.complete 49292,1,5 
.target Nauseated Villager
step
.goto 895,41.94,26.81
>>Interact with |cRXP_FRIENDLY_Nauseated Villager|r to treat him.
>>|cRXP_WARN_Fly away quickly to avoid aggroing the |cRXP_ENEMY_Infectious Gutworm|r after treating |cRXP_FRIENDLY_Nauseated Villager|r |r
.use 153513
.complete 49292,1,6 
.target Nauseated Villager
step
.goto 895,41.9,27.3
>>Interact with |cRXP_FRIENDLY_Nauseated Villager|r to treat him.
>>|cRXP_WARN_Fly away quickly to avoid aggroing the |cRXP_ENEMY_Infectious Gutworm|r after treating |cRXP_FRIENDLY_Nauseated Villager|r |r
.use 153513
.complete 49292,1,6 
.target Nauseated Villager
step
.goto 895,41.64,26.96
>>Kill |cRXP_ENEMY_Aaron Gutier|r
.complete 48353,3 
.mob Aaron Gutier
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brother Therold|r
.goto 895,41.29,27.00
.turnin 49292 >>Turn in Algae Shakes
.turnin 48353 >>Turn in Pulse of the Wharf
.accept 48355 >>Accept Evacuate the Premises
.accept 48354 >>Accept Tainted Shipments
.target Brother Therold
step
.goto 895,40.96,26.94
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrels of Fish|r
>>|cRXP_WARN_Kill |cRXP_ENEMY_Infesting Brainworm|r|r
.complete 48354,1,1 
.mob Infesting Brainworm
step
.goto 895,40.73,26.93
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrels of Fish|r
>>|cRXP_WARN_Kill |cRXP_ENEMY_Infesting Brainworm|r|r
.complete 48354,1,2 
.mob Infesting Brainworm
step
.goto 895,40.73,26.93
>>Use your |cRXP_WARN_[Extra Action Button]|r to evacuate |cRXP_FRIENDLY_Anglepoint Fishpacker|r
.complete 48355,1,2 
.target Anglepoint Fishpackers
step
.goto 895,40.39,26.86
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrels of Fish|r
>>|cRXP_WARN_Kill |cRXP_ENEMY_Infesting Brainworm|r|r
.complete 48354,1,3 
.mob Infesting Brainworm
step
.goto 895,40.73,26.93
>>Use your |cRXP_WARN_[Extra Action Button]|r to evacuate |cRXP_FRIENDLY_Anglepoint Fishpacker|r
.complete 48355,1,3 
.target Anglepoint Fishpackers
step
#completewith Barrel of Fish
>>Use your |cRXP_WARN_[Extra Action Button]|r to evacuate |cRXP_WARN_nearby|r |cRXP_FRIENDLY_Anglepoint Fishpacker|r
.complete 48355,1 
.target Anglepoint Fishpackers
step
.goto 895,39.94,27.13
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrels of Fish|r
>>|cRXP_WARN_Kill |cRXP_ENEMY_Infesting Brainworm|r|r
.complete 48354,1,4 
.mob Infesting Brainworm
step
#label Barrel of Fish
.goto 895,40.01,26.91
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrels of Fish|r
>>|cRXP_WARN_Kill |cRXP_ENEMY_Infesting Brainworm|r|r
.complete 48354,1,5 
.mob Infesting Brainworm
step
.goto 895,40.15,26.68,10,0
.goto 895,39.96,26.4,10,0
.goto 895,39.75,26.56
.goto 895,39.49,26.68
>>Use your |cRXP_WARN_[Extra Action Button]|r to evacuate |cRXP_WARN_nearby|r |cRXP_FRIENDLY_Anglepoint Fishpacker|r
.complete 48355,1 
.target Anglepoint Fishpackers
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brother Therold|r and |cFF00FF25Keegan Alby|r
.turnin 48354 >>Turn in Tainted Shipments
.turnin 48355 >>Turn in Evacuate the Premises
.accept 48356 >>Accept Possessive Headgear
.goto 895,39.49,26.68
.accept 48365 >>Accept The Young Lord Stormsong
.accept 48009 >>Accept Betrayal of the Guard
.goto 895,39.52,26.74
.target Keegan Alby
.target Brother Therold
step
#completewith Overseer Bates
>>Kill |cFFFF5722Mind-addled Enforcers|r, |cFFFF5722Possessed Dockworkers|r and |cFFFF5722Parasitic Mindstealers|r.
.complete 48356,1 
.complete 48009,1 
.mob Possessed Dockworkers
.mob Mind-addled Enforcers
.mob Parasitic Mindstealer
step
.goto 895,37.94,29.58,15,0
.goto 895,37.56,29.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Manager Yerold|r inside the building.
.accept 48008 >>Accept Dangerous Cargo
.accept 49299 >>Accept Enemy Within
.target Manager Yerold
step
.goto 895,38.03,29.81
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrels|r to burn |cRXP_PICK_Infested Cargo|r
.complete 48008,1,1 
step
.goto 895,39.49,31.67
>>Kill |cFFFF5722Brother Conway|r
.complete 48365,1 
.mob Brother Conway
step
.goto 895,38.09,30.54
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrels|r to burn |cRXP_PICK_Infested Cargo|r
.complete 48008,1,2 
step
.goto 895,37.62,29.69
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrels|r to burn |cRXP_PICK_Infested Cargo|r
.complete 48008,1,3
step
.goto 895,37.5,29.74
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrels|r to burn |cRXP_PICK_Infested Cargo|r
.complete 48008,1,4 
step
.goto 895,37.27,29.91
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrels|r to burn |cRXP_PICK_Infested Cargo|r
.complete 48008,1,5 
step
#label Overseer Bates
.goto 895,37.25,28.83
>>Kill |cFFFF5722Overseer Bates|r at the top of the stairs.
>>|cRXP_WARN_Sidestep/move away from his Void Swipe|r
.complete 49299,1 
.mob Overseer Bates
step
.loop 30,895,36.84,30.21,37.38,31.11,38.21,31.79,39.23,31.02,38.87,28.98
>>Kill |cFFFF5722Mind-addled Enforcers|r, |cFFFF5722Possessed Dockworkers|r and |cFFFF5722Parasitic Mindstealers|r.
.complete 48356,1 
.complete 48009,1 
.mob Possessed Dockworkers
.mob Mind-addled Enforcers
.mob Parasitic Mindstealer
step
.goto 895,37.57,29.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Manager Yerold|r inside the building.
.turnin 48008 >>Turn in Dangerous Cargo
.turnin 49299,1 >>Turn in Enemy Within
.target Manager Yerold
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brother Therold|r and |cRXP_FRIENDLY_Keegan Alby|r
.turnin 48356 >>Turn in Possessive Headgear
.goto 895,37.98,29.5,8,0
.goto 895,39.50,26.68
.turnin 48009 >>Turn in Betrayal of the Guard
.turnin 48365 >>Turn in The Young Lord Stormsong
.goto 895,39.52,26.74
.target Keegan Alby
.target Brother Therold
step
.goto 895,39.54,26.7
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brannon Stormsong|r
.accept 48366 >>Accept Paddle to Safety
.target Brannon Stormsong
step
.goto 895,39.60,26.96
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Escape Rowboat|r
.complete 48366,1 
.timer 40, Rowboat Time
step
.goto 895,35.20,24.19
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brannon Stormsong|r
.turnin 48366 >>Turn in Paddle to Safety
.accept 48372 >>Accept Eldritch Invocations
.target Brannon Stormsong
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Keegan Alby|r and |cFF00FF25Brother Therold|r
.accept 48370 >>Accept Death in the Depths
.goto 895,35.25,24.17
.accept 48368 >>Accept Deep Sea Defilement
.goto 895,35.24,24.27
.target Keegan Alby
.target Brother Therold
step
.goto 895,34.95,24.21
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rosaline Madison|r
.accept 48367 >>Accept Those Aren't Fish Eggs
.target Rosaline Madison
step
#completewith Western Corrupting Pylon
>>Kill |cRXP_ENEMY_Deepwarden Followers|r and destroy |cRXP_ENEMY_Corrupted Eggs.|r
>>|cRXP_WARN_Run on the Seafloor for increased movement speed.|r
.complete 48367,1 
.complete 48370,1 
.mob Merciless Aberration
.mob K'thir Harbinger
.mob Willing Cultist
.mob Corrupted Egg
step
#completewith next
.isOnQuest 48368
.goto 895,33.86,25.77,15 >> Submerge into the water.
.goto 895,34.99,24.61,10 >> Enter the underwater cave.
step
.goto 895,35.39,24.32
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Pylon|r
.complete 48368,2 
step
#completewith next
.isOnQuest 48368
.goto 895,33.78,25.63,20 >> Leave the underwater cave.
step
#completewith next
.isOnQuest 48368
.isOnQuest 48367
.goto 895,33.9,26.1,15 >> Check for Corrupted Eggs 1
.goto 895,33.17,26.91,15 >> Check for Corrupted Eggs 2
.goto 895,32.25,27.34,15 >> Check for Corrupted Eggs 3
.goto 895,31.87,29.18,15 >> Check for Corrupted Eggs 4
.goto 895,30.84,30.25,20 >> Enter the underwater cave.
step
.goto 895,30.37,31.11
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Pylon|r
.complete 48368,1 
step
#completewith next
.isOnQuest 48367
.isOnQuest 48368
.goto 895,31.35,29.13,20 >> Leave the underwater cave.
.goto 895,32.01,26.68,15 >> Check for Corrupted Eggs 5
.goto 895,32.44,24.65,15 >> Check for Corrupted Eggs 6
.goto 895,32.8,24.01,15 >> Check for Corrupted Eggs 7
.goto 895,32.55,23.52,15 >> Check for Corrupted Eggs 8
.goto 895,31.86,22.69,15 >> Check for Corrupted Eggs 9
.goto 895,31.56,21.88,15 >> Check for Corrupted Eggs 1
.goto 895,30.3,20.17,15 >> Enter the underwater cave.
step
.goto 895,29.99,19.40
>>Kill |cRXP_ENEMY_Director Deepwarden|r
.complete 48372,1 
.mob Director Deepwarden
step
#label Western Corrupting Pylon
.goto 895,30,19.36
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Pylon|r
.complete 48368,3 
.mob Director Deepwarden
step
.loop 20,895,31.56,21.88,31.86,22.69,32.55,23.52,32.8,24.0,32.44,24.65,32.01,26.68,31.87,29.18,32.25,27.34,33.17,26.9,33.9,26.1
>>Kill |cRXP_ENEMY_Deepwarden Followers|r and destroy |cRXP_ENEMY_Corrupted Eggs.|r
>>|cRXP_WARN_Run on the Seafloor for increased movement speed.|r
.complete 48367,1 
.complete 48370,1 
.mob Merciless Aberration
.mob K'thir Harbinger
.mob Willing Cultist
.mob Corrupted Egg
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brother Therold|r, |cFF00FF25Brannon Stormsong|r and |cFF00FF25Rosaline Madison.|r
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic.|r
.turnin 48368 >>Turn in Deep Sea Defilement
.goto 895,31.02,21.91,30,0
.goto 895,35.23,24.27
.turnin 48370 >>Turn in Death in the Depths
.turnin 48372 >>Turn in Eldritch Invocations
.goto 895,35.2,24.19
.turnin 48367 >>Turn in Those Aren't Fish Eggs
.accept 49302 >>Accept The Deadliest Catch
.goto 895,34.95,24.21
.target Brother Therold
.target Brannon Stormsong
.target Rosaline Madison
step
.hs >> Hearthstone |cFFfa9602to Boralus.|r
.isOnQuest 49302
]])
RXPGuides.RegisterGuide([[
#df
#version 4
#group RestedXP Alliance 10-60
#name 8A_Tiragarde Sound Part 2
#displayname Chapter 8 - Tiragarde Sound [2]
#next 9A_Drustvar
<<Alliance
step
.goto 1161,73.52,13.72,5,0
.goto 1161,68.76,21.09,10,0
.goto 1161,67.43,21.39,10,0
.goto 1161,68.16,21.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Taelia|r
.turnin 46729 >>Turn in The Old Knight
.accept 47186 >>Accept Sanctum of the Sages
.target Taelia
step
.goto 1161,67.99,21.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Cyrus Crestfall|r
.accept 52128 >>Accept Ferry Pass
.turnin 52128 >>Turn in Ferry Pass
.target Cyrus Crestfall
step
.goto 1161,67.33,22.75,5,0
.goto 1161,67.48,21.11,5,0
.goto 1161,68.96,21.19,5,0
.goto 1161,70.74,16.24
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cFF00FF257th Legion Magus|r
.complete 47186,1 
.skipgossip
.target 7th Legion Magus
step
.goto 1161,68.76,21.09,10,0
.goto 1161,67.43,21.39,10,0
.goto 1161,68.16,21.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Taelia|r
.turnin 47186 >>Turn in Sanctum of the Sages
.accept 47189 >>Accept A Nation Divided
.target Taelia
step
.goto 1161,68.38,22.10
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Scouting Map|r, then click Tiragarde Sound and accept the quest.
.complete 47189,1 
.accept 47960 >>Accept Tiragarde Sound
step
.goto 1161,68.17,22.00
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Taelia|r
.turnin 47189 >>Turn in A Nation Divided
.turnin 47960 >>Turn in Tiragarde Sound
.target Taelia
step
.goto 1161,68.04,22.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Genn Greymane|r
.accept 52654 >>Accept The War Campaign
.target Genn Greymane
step
.goto 1161,67.58,22.20
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r
.accept 47181 >>Accept The Smoking Gun
.target Flynn Fairwind
step
.goto 1161,67.56,22.25
>>Press your |cRXP_WARN_[Extra Action Button]|r
.complete 47181,1 
step
.goto 1161,67.56,22.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r
.turnin 47181 >>Turn in The Smoking Gun
.target Flynn Fairwind
step
.goto 1161,67.99,21.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cyrus Crestfall|r
.accept 47485 >>Accept The Ashvane Trading Company
.target Cyrus Crestfall
step
.goto 1161,67.09,23.4,10,0
.goto 1161,69.26,26.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford Wyrmbane|r
.turnin 52654 >>Turn in The War Campaign
.accept 52544 >>Accept The War Cache
.accept 51569 >>Accept The Zandalar Campaign
.target Halford Wyrmbane
step
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Zandalar Campaign table|r, then click Zuldazar and accept the quest
>>|TInterface/cursor/crosshair/interact.blp:20|Click on the Quest Complete pop-up in your Quest Tracker
.goto 1161,69.26,26.98
.accept 51570 >>Accept Foothold: Zuldazar
.turnin 51570 >>Turn in Foothold: Zuldazar
step
>>Select |cRXP_PICK_Zuldazar|r on the Map
.goto 1161,69.26,26.98
.complete 51569,1 
step
.goto 1161,69.26,26.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford Wyrmbane|r
.target Halford Wyrmbane
.turnin 51569 >>Turn in The Zandalar Campaign
.accept 51308 >>Accept Zuldazar Foothold
step
.goto 1161,69.27,26.98
.gossipoption 49384 >>Talk to |cFF00FF25Halford Wyrmbane|r
.timer 44, Halford Wyrmbane RP
.target Halford Wyrmbane
.isQuestAvailable 52462
step
#sticky
>>|cRXP_WARN_Hurry! If you move quickly, you can complete a few objectives before the roleplay is finished|r
.complete 51308,1 
step <<skip
#completewith next
.goto 1161,74.13,12.66
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Wesley Rockhold|r
.target Wesley Rockhold
.home >>Set your Hearthstone to Boralus
step << !KulTiran
.goto 1161,77.18,16.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crenzo Sparkshatter|r
.accept 52462 >>Accept A Load of Scrap
.target Crenzo Sparkshatter
step << !KulTiran
.goto 1161,77.18,16.46
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Scrap-O-Matic 1000.|r
>>|T1698808:0|tInsert the Tattered Pants and press scrap
.complete 52462,1 
step << !KulTiran
.goto 1161,77.18,16.46
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Crenzo Sparkshatter|r
.turnin 52462 >>Turn in A Load of Scrap
.target Crenzo Sparkshatter
step
.goto 1161,74.17,24.78
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Will Melborne|r but **DON'T USE THE FERRY!*
.complete 47485,1 
.target Will Melborne
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hawkmaster Lloyd|r and |cRXP_FRIENDLY_Tallis Skyheart|r |cFFfa9602inside the tent.|r
.accept 51226 >>Accept Death from Two Sides
.goto 895,80.63,42.07
.accept 49733 >>Accept Patching Up the Rear
.goto 895,81.10,42.49
.target Hawkmaster Lloyd
.target Tallis Skyheart
step
#completewith Injured Marine
>>Kill |cRXP_ENEMY_Brinefang Saurolisks|r
.complete 51226,1 
.mob Brinefang Saurolisk
step
.goto 895,80.81,41.48
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Injured Marines|r
.complete 49733,1,1 
.target Injured Marine
step
.goto 895,81.17,41.19
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Injured Marines|r
.complete 49733,1,2 
.target Injured Marine
step
.goto 895,81.85,40.54
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Injured Marines|r
.complete 49733,1,3 
.target Injured Marine
step
.goto 895,82.48,43.82
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Injured Marines|r
.complete 49733,1,4 
.target Injured Marine
step
#labelInjured Marine
.goto 895,82.21,44.06
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Injured Marines|r
.complete 49733,1,5 
.target Injured Marine
step
.goto 895,81.09,42.49
>>Kill |cRXP_ENEMY_Brinefang Saurolisks|r
.complete 51226,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Tallis Skyheart|r, |cRXP_FRIENDLY_Officer Jovan|r |cFFfa9602inside the tent.|r and |cRXP_FRIENDLY_Hawkmaster Lloyd|r
.turnin 49733 >>Turn in Patching Up the Rear
.accept 49734 >>Accept Targeting a Turncoat
.accept 49716 >>Accept A Lesson on Trust
.goto 895,81.09,42.49
.turnin 51226 >>Turn in Death from Two Sides
.accept 49720 >>Accept Free Bird
.goto 895,80.62,42.03
.accept 50249 >>Accept A Boralus Triple Threat
.target Hawkmaster Lloyd
.target Tallis Skyheart
.target Officer Jovan
step
#completewith Seahawk freed
>>Kill |cRXP_ENEMY_Hardened Mutineer|r,|cRXP_ENEMY_Mutinous Falconer|r and |cRXP_ENEMY_Mutinous Halberdier|r loot them for |cRXP_LOOT_Marine Identification Badge.|r
.complete 49716,1 
.mob Hardened Mutineer
.mob Mutinous Falconer
.mob Mutinous Halberdier
step
.goto 895,79.95,38.75
>>Kill |cRXP_ENEMY_Fernn the Turncoat.|r
*|cRXP_WARN_Use your Extra Action Button on cooldown.|r
.complete 49734,1 
.mob Fernn the Turncoat
step
.goto 895,80.41,37.63
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Hawk Cage|r
.complete 49720,1,1 
step
.goto 895,80.17,37.13
>>Kill |cRXP_ENEMY_Stablemaster Diana|r
.complete 50249,2 
.mob Stablemaster Diana
step
.goto 895,79.28,36.89
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Hawk Cage|r
.complete 49720,1,2 
step
.goto 895,78.08,36.74
>>Kill |cRXP_PICK_Hayden the Madshot|r
|cRXP_WARN_*Use your Extra Action Button on cooldown.|r
.complete 50249,3 
.mob Hayden the Madshot
step
.goto 895,78.85,38.04
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Hawk Cage|r
.complete 49720,1,3 
step
.goto 895,79.11,37.92
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Hawk Cage|r
.complete 49720,1,4 
step
.goto 895,78.78,38.82
>>Kill |cRXP_ENEMY_Overseer Howling|r
|cRXP_WARN_*Use your Extra Action Button on cooldown.|r
.complete 50249,1 
.mob Overseer Howling
step
#label Seahawk freed
.goto 895,79.49,38.59
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Hawk Cage|r
.complete 49720,1,5 
step
.goto 895,80.17,37.13,10,0
.goto 895,78.08,36.74,10,0
.goto 895,79.49,38.59
>>Kill |cRXP_ENEMY_Hardened Mutineer|r,|cRXP_ENEMY_Mutinous Falconer|r and |cRXP_ENEMY_Mutinous Halberdier|r loot them for |cRXP_LOOT_Marine Identification Badge.|r
.complete 49716,1 
.mob Hardened Mutineer
.mob Mutinous Falconer
.mob Mutinous Halberdier
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Hawkmaster Lloyd|r and |cRXP_FRIENDLY_Tallis Skyheart|r |cFFfa9602inside the tent.|r
.turnin 49720 >>Turn in Free Bird
.goto 895,80.62,42.05
.turnin 49734,2 >>Turn in Targeting a Turncoat
.turnin 49716 >>Turn in A Lesson on Trust
.turnin 50249 >>Turn in A Boralus Triple Threat
.goto 895,81.09,42.46
.target Hawkmaster Lloyd
.target Tallis Skyheart
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cagney|r and |cRXP_FRIENDLY_Olive|r
.turnin 47485 >>Turn in The Ashvane Trading Company
.accept 47486 >>Accept Suspicious Shipments
.accept 47487 >>Accept Labor Dispute
.goto 895,76.83,43.43
.accept 47488 >>Accept Small Haulers
.goto 895,76.82,43.49
.target Cagney
.target Olive
step
#completewith next
>>Kill |cRXP_ENEMY_Ashvane Company guards|r
.complete 47487,1 
.mob Company Enforcer
.mob Company Watchman
.mob Company Fusilier
step
.goto 895,79.02,45.78
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Posted Notice|r |cFFfa9602next to the door of the small house.|r
.accept 50573 >>Accept Message from the Management
step
#completewith Labor Dispute
>>Kill |cRXP_ENEMY_Ashvane Company guards|r
.complete 47487,1 
.mob Company Enforcer
.mob Company Watchman
.mob Company Fusilier
step
.goto 895,79.56,45.67
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Marked Goods|r
.complete 47486,1,1 
step
.goto 895,80.63,46.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urchin Worker|r
.complete 47488,1,1 
.skipgossip
.target Urchin Worker
step
.goto 895,82.14,48.62
>>Kill |cRXP_ENEMY_Forgemaster Farthing|r and loot them for the |T1505961:0|t|cRXP_LOOT_Note.|r
.complete 50573,1 
.mob Forgemaster Farthing
step
.goto 895,82.11,48.54
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Marked Goods|r
.complete 47486,1,2 
step
.goto 895,81.93,48.72
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urchin Worker|r
.complete 47488,1,2 
.skipgossip
.target Urchin Worker
step
.goto 895,81.51,49.11
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Marked Goods|r
.complete 47486,1,3 
step
.goto 895,81.34,49.39
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urchin Worker|r
.complete 47488,1,3 
.skipgossip
.target Urchin Worker
step
.goto 895,81.1,49.33
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Marked Goods|r
.complete 47486,1,4 
step
.goto 895,80.77,49.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urchin Worker|r
.complete 47488,1,4 
.skipgossip
.target Urchin Worker
step
.goto 895,80.46,48.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urchin Worker|r
.complete 47488,1,5 
.skipgossip
.target Urchin Worker
step
.goto 895,80.03,47.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Urchin Worker|r
.complete 47488,1,6 
.skipgossip
.target Urchin Worker
step
.goto 895,80.18,47.27
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Marked Goods|r
.complete 47486,1,5 
step
.goto 895,79.13,46.96
>>Kill |cRXP_ENEMY_Taskmaster Williams|r |cFFfa9602inside the house|r and loot them for the |T1505962:0|t|cRXP_LOOT_Note.|r
.complete 50573,2 
.mob Taskmaster Williams
step
.loop 15,895,79.68,48.71,,80.44,48.89,79.96,50.42,81.21,49.75
>>Kill |cRXP_ENEMY_Ashvane Company guards|r
.complete 47487,1 
.mob Company Enforcer
.mob Company Watchman
.mob Company Fusilier
step
#label Labor Dispute
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Cagney|r and |cFF00FF25Flynn Fairwind|r
.turnin 47487 >>Turn in Labor Dispute
.goto 895,79.22,47.07,5,0
.goto 895,78.10,47.84
.turnin 47486 >>Turn in Suspicious Shipments
.turnin 47488 >>Turn in Small Haulers
.turnin 50573,1 >>Turn in Message from the Management
.accept 50531 >>Accept Under Their Noses
.goto 895,78.11,47.95
.target Cagney
.target Flynn Fairwind
step
.goto 895,75.85,49.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r
.turnin 50531 >>Turn in Under Their Noses
.accept 53041 >>Accept Sampling the Goods
.target Flynn Fairwind
step
.goto 895,74.75,50.13
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_LOOT_Raw Azerite Sample|r
.complete 53041,2 
step
.goto 895,75.17,50.75
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Chemist Notes|r
.complete 53041,1 
.skipgossip
step
.goto 895,75.42,49.81,5,0
#completewith next
.vendor >>|cRXP_WARN_Empty bags/repair gear at|r |cRXP_FRIENDLY_Jen the Fixer|r |cRXP_WARN_if necessary|r
.target Jen the Fixer
step
.goto 895,75.55,49.94
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Wanted Poster.|r
.accept 50544 >>Accept The Hunters of Kennings Lodge
step
.goto 895,75.88,50.64,5,0
#completewith next
.vendor >>|cRXP_WARN_Empty bags/restock food and water at|r |cRXP_FRIENDLY_Lidia Plank|r |cRXP_WARN_if necessary|r
.target Lidia Plank
step
.goto 895,75.7,50.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Junior Miner Joe|r
.accept 50349 >>Accept An Overrun Mine
.target Junior Miner Joe
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Chief Miner Theock|r and |cRXP_FRIENDLY_Head Chemist Walters.|r
.turnin 50349 >>Turn in An Overrun Mine
.accept 50351 >>Accept Miner Operation
.goto 895,78.16,55.94
.accept 50352 >>Accept Pinch of Azerite
.goto 895,78.12,56.01
.target Chief Miner Theock
.target Head Chemist Walters
step
#completewith OrdnancePrim
>>Kill |cRXP_ENEMY_Animated Azerite|r, |cRXP_ENEMY_Bubbling Azerite|r, and |cRXP_ENEMY_Azerite Nibblers|r and loot them for |cRXP_LOOT_Azerite Dust.|r
.complete 50352,1 
.mob Animated Azerite
.mob Bubbling Azerite
.mob Azerite Nibbler
step
.goto 895,76.24,57.21,5 >> Enter the |cFFfa9602House.|r
.isOnQuest 50352
step
.goto 895,76.1,57.43
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on |cRXP_PICK_Walter's Chemistry Kit|r |cFFfa9602next to the wall shelf.|r
.complete 50352,2 
step
.goto 895,76.15,57.62,5 >> Leave the |cFFfa9602House.|r
.isOnQuest 50352
step
.goto 895,76.98,57.78
.gossipoption 48413 >>Talk to |cRXP_FRIENDLY_Civil Technician Alena|r
.isOnQuest 50351
.target Civil Technician Alena
.timer 7, Civil Technician Alena RP
step
#label OrdnancePrim
.goto 895,77.31,60.49
.gossipoption 48300 >>Talk to |cRXP_FRIENDLY_Ordnance Handler Prim|r
.timer 6, Ordnance Handler Prim RP
.target Ordnance Handler Prim
.isOnQuest 50351
step
.goto 895,75.56,59.37
>>Kill |cRXP_ENEMY_Animated Azerite|r, |cRXP_ENEMY_Bubbling Azerite|r, and |cRXP_ENEMY_Azerite Nibblers|r and loot them for |cRXP_LOOT_Azerite Dust.|r
.complete 50352,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ordnance Handler Prim|r and |cRXP_FRIENDLY_Civil Technician Alena.|r
.turnin 50351 >>Turn in Miner Operation
.turnin 50352 >>Turn in Pinch of Azerite
.goto 895,75.56,59.37
.accept 50356 >>Accept Rock Meet Dynamite
.target Ordnance Handler Prim
.target Civil Technician Alena
step
.goto 895,76.11,59.92,5 >> Enter |cFFfa9602the cave.|r
.isOnQuest 50356
step
.goto 895,76.16,60.32,10,0
.goto 895,76.51,60.59,8,0
.goto 895,76.61,59.90,8,0
.goto 895,76.27,59.31,10,0
.goto 895,74.96,59.94
>>Kill |cRXP_ENEMY_Earthshaper Brugaw|r.
>>|cRXP_WARN_Use your Extra Action Button on cooldown|r
.complete 50356,1 
.mob Earthshaper Brugaw
step
.goto 895,76.27,59.31,10,0
.goto 895,76.61,59.90,8,0
.goto 895,76.51,60.59,8,0
.goto 895,76.16,60.32,10,0
.goto 895,76.10,59.74,10 >> Leave |cFFfa9602the cave.|r
.isOnQuest 50356
step
.goto 895,78.14,55.95
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Chief Miner Theock|r
.turnin 50356 >>Turn in Rock Meet Dynamite
.target Chief Miner Theock
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alanna Holton|r and |cRXP_FRIENDLY_Lord Kennings.|r
.turnin 50544 >>Turn in The Hunters of Kennings Lodge
.accept 48874 >>Accept Pardon Our Rust
.goto 895,75.84,65.86
.accept 48873 >>Accept A Grizzly End
.accept 48879 >>Accept A Hunt for Hawk Eggs
.goto 895,75.82,65.79
.target Chief Miner Theock
.target Lord Kennings
step
.goto 895,76.13,65.52
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Weathered Job List|r
.accept 49028 >>Accept A Sweater for Rupert
.accept 49069 >>Accept WANTED: Ol' Frostclaw
step
#completewith Sprung Beartrap 1
>>Kill |cRXP_ENEMY_Guarded Quillrats|r and loot them for |cRXP_LOOT_Sturdy Quills|r
.complete 49028,1 
.mob Guarded Quillrat
step
#completewith Sprung Beartrap 2
>>Kill |cRXP_ENEMY_Monstrous Grizzlies|r and then use your |T463557:0|t[Simple Skinning Knife]
.complete 48873,1 
.use 152800
.mob Monstrous Grizzly
step
.goto 895,77.99,65.58
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Sprung Beartrap|r
.complete 48874,1,1 
step
.goto 895,79.69,65.71,5 >> Enter |cFFfa9602the cave|r
.isOnQuest 49069
step
.goto 895,80.07,65.6
>>Kill |cRXP_ENEMY_Ol' Frostclaw|r
.complete 49069,1 
.mob Old Frostclaw
step
.goto 895,78.14,64.58
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Sprung Beartrap|r
.complete 48874,1,2 
step
#label Sprung Beartrap 1
.goto 895,77.66,64.75
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Sprung Beartrap|r
.complete 48874,1,3 
step
#completewith Sprung Beartrap 2
>>Kill |cRXP_ENEMY_Mountain Raccoons|r,|cRXP_ENEMY_Guarded Quillrats|r and loot them for |cRXP_LOOT_Fuzzy Tails|r,|cRXP_LOOT_Sturdy Quills.|r
.complete 49028,1 
.complete 49028,2 
.mob Mountain Raccoon
.mob Guarded Quillrat
step
#completewith Sprung Beartrap 2
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Hawk Eggs|r
.complete 48879,1 
step
.goto 895,77.85,64.41
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Sprung Beartrap|r
.complete 48874,1,4 
step
#label Sprung Beartrap 2
.goto 895,77.42,62.82
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Sprung Beartrap|r
.complete 48874,1,5 
step
#completewith Sprung Beartrap 3
>>Kill |cRXP_ENEMY_Monstrous Grizzlies|r and then use your |T463557:0|t[Simple Skinning Knife]
.complete 48873,1 
.use 152800
.mob Monstrous Grizzly
step
#completewith Sprung Beartrap 3
>>Kill |cRXP_ENEMY_Mountain Raccoons|r,|cRXP_ENEMY_Guarded Quillrats|r and loot them for |cRXP_LOOT_Fuzzy Tails|r,|cRXP_LOOT_Sturdy Quills.|r
.complete 49028,1 
.complete 49028,2 
.mob Mountain Raccoon
.mob Guarded Quillrat
step
#label Sprung Beartrap 3
.goto 895,77.52,62.83,10,0
.goto 895,76.83,62.42,10,0
.goto 895,76.73,61.82,10,0
.goto 895,76.34,61.02,10,0
.goto 895,75.91,61.08,10,0
.goto 895,75.16,61.11,10,0
.goto 895,74.54,61.1,10,0
.goto 895,75.13,61.95
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Hawk Eggs|r
.complete 48879,1 
step
#completewith next
>>Kill |cRXP_ENEMY_Monstrous Grizzlies|r and then use your |T463557:0|t[Simple Skinning Knife]
.complete 48873,1 
.use 152800
.mob Monstrous Grizzly
step
.goto 895,75.13,61.95,10,0
.goto 895,74.54,61.1,10,0
.goto 895,75.16,61.11,10,0
.goto 895,75.91,61.08,10,0
.goto 895,76.34,61.02,10,0
.goto 895,76.73,61.82,10,0
.goto 895,76.83,62.42,10,0
.goto 895,77.52,62.83
>>Kill |cRXP_ENEMY_Mountain Raccoons|r,|cRXP_ENEMY_Guarded Quillrats|r and loot them for |cRXP_LOOT_Fuzzy Tails|r,|cRXP_LOOT_Sturdy Quills.|r
.complete 49028,1 
.complete 49028,2 
.mob Mountain Raccoon
.mob Guarded Quillrat
step << skip
.cast 6478 >>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Hawk Eggs|r
step
.goto 895,76.68,65.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Kolta|r
.turnin 49028 >>Turn in A Sweater for Rupert
.target Kolta
step
.goto 895,75.84,65.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lord Kennings|r and |cRXP_FRIENDLY_Alanna Holton|r
.turnin 48879 >>Turn in A Hunt for Hawk Eggs
.goto 895,75.82,65.78
.turnin 48873 >>Turn in A Grizzly End
.turnin 48874 >>Turn in Pardon Our Rust
.turnin 49069 >>Turn in WANTED: Ol' Frostclaw
.goto 895,75.85,65.87
.accept 49072 >>Accept Westward Noble
.target Alanna Holton
.target Lord Kennings
step
.goto 895,70.9,61.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lord Kennings.|r
.turnin 49072 >>Turn in Westward Noble
.accept 49039 >>Accept The Start of a Monster Hunt
.target Lord Kennings
step
.goto 895,70.88,61.68
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Smashed Crate.|r
.complete 49039,1 
step
.goto 895,70.81,61.43
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Disturbed Trap.|r
.complete 49039,3 
step
.goto 895,70.68,61.95
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Bloody Trail.|r
.complete 49039,2 
step
#label LordKennings
.goto 895,70.89,61.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lord Kennings|r
.turnin 49039 >>Turn in The Start of a Monster Hunt
.accept 48909 >>Accept Noble Responsibilities
.target Lord Kennings
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lord Kennings|r |cFFfa9602next to you.|r
.accept 49066 >>Accept Encase of Emergency
step
#completewith KuroktheLost
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Ice Block|r and kill |cRXP_ENEMY_Agitated Ice Shardling|r and loot them for |cRXP_LOOT_Pristine Ice Chunks|r
.complete 49066,1 
.mob Agitated Ice Shardling
step
.goto 895,70.32,62.93
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cRXP_PICK_Cold Corpse|r
.complete 48909,1 
.target Cold Corpse
step
.goto 895,69.23,62.42
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cRXP_PICK_Hunter Corpse|r
.complete 48909,2 
.target Hunter Corpse
step
.goto 895,68.89,63.93
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cRXP_PICK_Dead Quillrat.|r
.complete 48909,3 
.target Dead Quillrat
step
.goto 895,68.2,65.13
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with the |cRXP_PICK_Fresh Stag Corpse|r
.complete 48909,4 
.target Fresh Stag Corpse
step
.goto 895,68.21,65.76,5 >> Enter the |cFFfa9602cave.|r
.isOnQuest 48909
step
#label KuroktheLost
.goto 895,68.07,66.50
>>Kill |cRXP_ENEMY_Kurok the Lost.|r
.complete 48909,5 
.mob Kurok the Lost
step
.goto 895,70.88,61.68,10,0
.goto 895,70.81,61.43,10,0
.goto 895,70.68,61.95,10,0
.goto 895,70.68,61.95
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Ice Block|r and kill |cRXP_ENEMY_Agitated Ice Shardling|r and loot them for |cRXP_LOOT_Pristine Ice Chunks|r
.complete 49066,1 
.mob Agitated Ice Shardling
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lord Kennings|r |cFFfa9602next to you|r
.turnin 49066 >>Turn in Encase of Emergency
.target Lord Kennings
step
.goto 895,75.84,65.87
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Alanna Holton|r
.turnin 48909,1 >>Turn in Noble Responsibilities
.target Alanna Holton
step
.goto 895,75.85,49.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r
.turnin 53041 >>Turn in Sampling the Goods
.accept 47489 >>Accept Stow and Go
.target Flynn Fairwind
step
.goto 895,75.84,49.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r
.complete 47489,1 
.skipgossip
.target Flynn Fairwind
step
#completewith next
.goto 895,75.79,48.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jeb Johnson|r
.fp >>Get the Bridgeport Flight Path
.target Jeb Johnson
step
.goto 895,75.5,48.08,5 >>|cFFfa9602Board the Maiden's Virtue.|r

.isOnQuest 47489
step
.goto 895,75.5,48.08
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrel of Fish|r
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic.|r
.complete 47489,3 
step
.goto 895,85.56,83.62
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Beachcomber Bob|r
.turnin 47489 >>Turn in Stow and Go
.accept 49218 >>Accept The Castaways
.accept 48419 >>Accept Lured and Allured
.target Beachcomber Bob
step
.goto 895,85.46,80.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stabby Jane|r
.turnin 49218 >>Turn in The Castaways
.target Stabby Jane
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stabby Jane|r and |cRXP_FRIENDLY_Hungry Sam|r
.complete 48419,1 
.accept 49178 >>Accept My Favorite Things
.accept 49226 >>Accept Silencing the Sisters
.goto 895,85.46,80.81
.complete 49178,1 
.accept 49230 >>Accept Local Flavor
.goto 895,85.47,80.72
.skipgossip 128229,1
.skipgossip 128228,1
.target Stabby Jane
.target Hungry Sam
step
.goto 895,85.27,80.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Friendly Pete|r
.complete 49178,2 
.skipgossip
.target Friendly Pete
step
.goto 895,86.43,81.3
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Handy Bill|r
.complete 49178,3 
.skipgossip
.target Handy Bill
step
#completewith next
.goto 895,86.42,80.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Skinny Tim|r
.fp >>Get the Bridgeport Flight Path
.target Skinny Tim
step
.goto 895,86.35,79.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Captain Keelson|r
.accept 48421 >>Accept Blood in the Tides
.target Captain Keelson
step
#completewith SilencingtheSisters
>>Kill |cRXP_ENEMY_Wailing Sirens.|r
>>Kill |cRXP_ENEMY_Tide Lurkers|r and loot them for |T237328:0|t|cRXP_LOOT_Juicy Lurker Tail.|r
.complete 48421,1 
.complete 49230,1 
.mob Wailing Siren
.mob Tide Lurker
step
.goto 895,88.26,78.14
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Silver Compass|r
.complete 49178,5 
step
.goto 895,90.13,74.38,15 >>|cRXP_WARN_Discover |cRXP_FRIENDLY_Flynn Fairwind|r|r

.target Flynn Fairwind
.isOnQuest 48419
step
.goto 895,90.13,74.38
>>Kill |cRXP_ENEMY_Lugeia|r
.complete 48419,3 
.mob Lugeia
step
.goto 895,88.28,72.92
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Steel Lunchbox|r
.complete 49178,4 
step
.goto 895,86.98,72.56,5 >> Enter |cFFfa9602the cave.|r
.isOnQuest 49178
step
.goto 895,86.51,72.5
>>Kill |cRXP_ENEMY_Nolpe|r and |cRXP_ENEMY_Patheope.|r
.complete 49226,2 
.complete 49226,1 
.mob Nolpe
.mob Patheope
step
.goto 895,87.11,72.64,8,0
.goto 895,87.98,75.01
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Glimmering Seaweed|r
.accept 49181 >>Accept Glimmering Locket
step
#label SilencingtheSisters
.goto 895,87.69,75.12
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Robot|r
.complete 49178,6 
step
.goto 895,85.47,80.82
>>Kill |cRXP_ENEMY_Wailing Sirens.|r
>>Kill |cRXP_ENEMY_Tide Lurkers|r and loot them for |T237328:0|t|cRXP_LOOT_Juicy Lurker Tail.|r
.complete 48421,1 
.complete 49230,1 
.mob Wailing Siren
.mob Tide Lurker
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Stabby Jane|r and |cRXP_FRIENDLY_Hungry Sam|r
.turnin 49178 >>Turn in My Favorite Things
.turnin 49226 >>Turn in Silencing the Sisters
.turnin 49181 >>Turn in Glimmering Locket
.goto 895,85.47,80.82
.turnin 49230 >>Turn in Local Flavor
.goto 895,85.47,80.72
.target Stabby Jane
.target Hungry Sam
step
.goto 895,85.72,76.63
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk |cRXP_FRIENDLY_Captain Keelson|r
.turnin 48421,2 >>Turn in Blood in the Tides
.target Captain Keelson
step
.goto 895,84.91,76.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r
.turnin 48419 >>Turn in Lured and Allured
.accept 48505 >>Accept Lovesick and Lost
.target Flynn Fairwind
step
#completewith ToxicCommunity
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Flynn Fairwind|r
>>|cRXP_WARN_Stay close to him. If you don't, he will stop until you're close.|r
.complete 48505,1 
.timer 8, Flynn RP
.skipgossip
.target Flynn Fairwind
step
.goto 895,82.74,72.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Skinner MacGuff|r
.target Skinner MacGuff
.accept 48516 >>Accept Toxic Community
step
>>Kill |cFF00BCD4Venomspine Saurolisks|r and loot them for |cFF00BCD4Marrowflies|r |cFFfa9602during the escort.|r
.complete 48516,1 
step
#label ToxicCommunity
.goto 895,82.75,72.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Skinner MacGuff|r
.turnin 48516 >>Turn in Toxic Community
step
.goto 895,80.21,75.25
>>|cRXP_WARN_Stay close to him. If you don't, he will stop until you're close.|r
.skipgossip
.complete 48505,1 
.target Flynn Fairwind
step
.goto 895,80.21,75.25
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r
>>|cRXP_WARN_Wait for the brief roleplay, which will be completed when the timer runs out.|r
.turnin 48505 >>Turn in Lovesick and Lost
.accept 48539 >>Accept Freehold
.target Flynn Fairwind
step
.goto 895,80.17,75.3
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Spyglass|r on the rock.
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic.|r
.complete 48539,1 
step
.goto 895,80.19,75.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r
.turnin 48539 >>Turn in Freehold
.accept 48773 >>Accept Papers, Please
.accept 48558 >>Accept The Irontide Crew
.target Flynn Fairwind
step
#completewith Dockmaster's Records
>>Kill |cRXP_ENEMY_Irontide Trickshot|r and loot them for |T133593:0|t|cRXP_LOOT_[Trickshot's Azerite Powder Horn].|r
>>Kill |cRXP_ENEMY_Irontide Cutthroat|r and loot them for |T135325:0|t|cRXP_LOOT_[Azerite Cutlass].|r
.complete 48558,1 
.complete 48558,2 
.mob Irontide Trickshot
.mob Irontide Cutthroat
step
.goto 895,79.19,76.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Geraldine|r
.accept 48774 >>Accept The Beatings Will Continue
.accept 48776 >>Accept Rig Robbing
.target Geraldine
step
#completewith Dockmaster's Records
>>Kill |cRXP_ENEMY_Irontide Overseer|r and |cRXP_ENEMY_Irontide Ruffian|r
.complete 48774,1 
.complete 48774,2 
.mob Irontide Trickshot
.mob Irontide Cutthroat
.mob Irontide Ruffian
step
.isOnQuest 48773
.goto 895,79.13,78.79
>>Kill |cRXP_ENEMY_Dockmaster Marl|r and loot him for |T237379:0|t|cRXP_LOOT_[Dockmaster's Key]|r
.collect 152722,1 
.mob Dockmaster Marl
step
.goto 895,79.13,78.79
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Dockmaster's Strongbox|r
.complete 48773,1 
step
.goto 895,78.6,77.86
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Azerite Cannonball|r
.accept 48606 >>Accept Loaded for Bear
step
.goto 895,78.57,77.82
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Azerite Cannonball|r
.collect 152628,2
.isOnQuest 48606
step
.goto 895,78.41,77.6
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Azerite Cannonball|r
.collect 152628,3
.isOnQuest 48606
step
.goto 895,78.44,77.69
.vehicle >>Click the |cRXP_PICK_Ashvane Cannon|r
.isOnQuest 48606
step
.goto 895,78,78.71
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Ashvane Cannon|r
.complete 48606,1,1 
step
.goto 895,78,78.71
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Ashvane Cannon|r
.complete 48606,1,3 
step
.goto 895,77.83,76.76
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Azerite Cannonball|r
.collect 152628,4
.isOnQuest 48606
step
.goto 895,77.81,76.72
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Azerite Cannonball|r
.collect 152628,5
.isOnQuest 48606
step
.goto 895,78.01,76.52
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Azerite Cannonball|r
.collect 152628,6
.isOnQuest 48606
step
.goto 895,77.73,76.65
.vehicle >>Click the |cRXP_PICK_Ashvane Cannon|r
.isOnQuest 48606
step
.goto 895,77.06,77.25
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cRXP_PICK_Ashvane Cannon|r
.complete 48606,1,6 
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 48606 >>Turn in Loaded for Bear
step
.goto 895,77.04,76.28
#label Dockmaster's Records
.cast 252484 >>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Tangled Rigging.|r|cRXP_WARN_(1)|r
.isOnQuest 48776
step
.goto 895,77.27,75.88,10 >>|cRXP_WARN_Pull the rope away from the water.|r|cRXP_WARN_(1)|r
.isOnQuest 48776
step
.goto 895,77.04,76.28
.cast 252484 >>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Tangled Rigging.|r|cRXP_WARN_(2)|r
.isOnQuest 48776
step
.goto 895,77.27,75.88,9 >>|cRXP_WARN_Pull the rope away from the water.|r|cRXP_WARN_(2)|r
.isOnQuest 48776
step
.goto 895,77.04,76.28
.cast 252484 >>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Tangled Rigging.|r|cRXP_WARN_(3)|r
.isOnQuest 48776
step
.goto 895,77.27,75.88,12 >>|cRXP_WARN_Pull the rope away from the water.|r|cRXP_WARN_(3)|r
.isOnQuest 48776
step
.goto 895,77.04,76.28
.cast 252484 >>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Tangled Rigging.|r|cRXP_WARN_(4)|r
.isOnQuest 48776
step
.goto 895,77.27,75.88,11 >>|cRXP_WARN_Pull the rope away from the water.|r|cRXP_WARN_(4)|r
.isOnQuest 48776
step
.goto 895,77.04,76.28
.cast 252484 >>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Tangled Rigging.|r|cRXP_WARN_(5)|r
.isOnQuest 48776
step
.goto 895,77.27,75.88,12 >>|cRXP_WARN_Pull the rope away from the water.|r|cRXP_WARN_(5)|r
.isOnQuest 48776
step
.goto 895,77.17,76.04
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Bottle|r |cFFfa9602on the ground.|r
.complete 48776,1 
step
#completewith next
>>Kill |cRXP_ENEMY_Irontide Trickshot|r and loot them for |T133593:0|t|cRXP_LOOT_[Trickshot's Azerite Powder Horn].|r
>>Kill |cRXP_ENEMY_Irontide Cutthroat|r and loot them for |T135325:0|t|cRXP_LOOT_[Azerite Cutlass].|r
.complete 48558,1 
.complete 48558,2 
.mob Irontide Trickshot
.mob Irontide Cutthroat
step
.goto 895,79.21,76.34
>>Kill |cRXP_ENEMY_Irontide Overseer|r and |cRXP_ENEMY_Irontide Ruffian|r
.complete 48774,1 
.complete 48774,2 
.mob Irontide Trickshot
.mob Irontide Cutthroat
.mob Irontide Ruffian
step
.goto 895,79.21,76.34
>>Kill |cRXP_ENEMY_Irontide Trickshot|r and loot them for |T133593:0|t|cRXP_LOOT_[Trickshot's Azerite Powder Horn].|r
>>Kill |cRXP_ENEMY_Irontide Cutthroat|r and loot them for |T135325:0|t|cRXP_LOOT_[Azerite Cutlass].|r
.complete 48558,1 
.complete 48558,2 
.mob Irontide Trickshot
.mob Irontide Cutthroat
step
.goto 895,79.21,76.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Geraldine|r
.turnin 48774 >>Turn in The Beatings Will Continue
.turnin 48776 >>Turn in Rig Robbing
.target Geraldine
step
.goto 895,80.35,81.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r
.turnin 48773 >>Turn in Papers, Please
.turnin 48558,2 >>Turn in The Irontide Crew
.accept 49239 >>Accept Dress to Impress
.target Flynn Fairwind
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 48606 >>Turn in Loaded for Bear
step
.goto 895,79.70,81.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Roko|r.
.accept 49290 >>Accept Aged to Perfection
.target Roko
step
.goto 895,79.81,82.37
>>Use your |cRXP_WARN_[Extra Action Button]|r to disguise yourself, then talk to the |cRXP_FRIENDLY_Irontide Recruiter.|r
.complete 49239,1 
.skipgossip
.target Irontide Recruiter
step
.goto 895,77.35,84.18,5,0
.goto 895,77.31,83.96
>>|cFFfa9602Enter the first building past the bridge on the right side.|r
.complete 49239,2 
.timer 23, Dead Man's Tale RP
step
#completewith next
.target Jill McHoonigan
.vendor >>|cRXP_WARN_During the roleplay, empty bags/restock food and water at |cRXP_FRIENDLY_Jill McHoonigan |r if necessary|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r and |cFF00FF25Venrik.|r
>>|cRXP_WARN_Wait for the brief roleplay, which will be completed when the timer runs out.|r
.turnin 49239 >>Turn in Dress to Impress
.accept 49401 >>Accept Rodrigo's Roost
.goto 895,77.33,83.97
.accept 49398 >>Accept Raise a Glass!
.goto 895,77.36,83.92
.target Flynn Fairwind
.target Venrik
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Venrik|r
.complete 49398,1 
.skipgossip 128927,2
.target Venrik
step
>>|cRXP_WARN_Use the |T132815:0|t[Goat Milk]|r
.complete 49398,2 
.use 153600
step
.goto 895,77.36,83.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Venrik|r
.turnin 49398 >>Turn in Raise a Glass!
.target Venrik
step
.goto 895,77.03,82.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rodrigo|r
.accept 49402 >>Accept Flew the Coop
.target Rodrigo
step
#completewith Irontide Recruiting Poster
>>|cRXP_WARN_Use your|r [ExtraActionButton] |cRXP_WARN_on the |cRXP_FRIENDLY_Runaway Macaw|r |cFFfa9602in the sky.|r|r
.complete 49402,1 
.use 154878
step
.goto 895,77.03,82.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rodrigo|r
.complete 49401,1 
.skipgossip 129098,1
.target Rodrigo
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Flynn Fairwind|r and |cFF00FF25Venrik|r
.turnin 49401 >>Turn in Rodrigo's Roost
.accept 49399 >>Accept The Big Job
.goto 895,77.33,83.97
.accept 49400 >>Accept Recruiting Efforts
.goto 895,77.36,83.92
.target Flynn Fairwind
.target Venrik
step
.goto 895,77.34,84.17,5,0
.goto 895,77.19,84.85
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Sternly Worded Letter|r
.accept 49409 >>Accept Missing Treasure!
step
#completewith Irontide Recruiting Poster
>>Kill |cRXP_ENEMY_Bilge Rats|r, |cRXP_ENEMY_Cutwaters|r and |cRXP_ENEMY_Blacktooths|r and loot them for their |T1505940:0|t|cRXP_LOOT_Orders|r
>>|cRXP_WARN_Use your |r[ExtraActionButton] |cRXP_WARN_to disguise yourself and avoid being attacked. If you need to attack enemies, this will undo your disguise. Remember, you can reapply your disguise whenever you need it|r
.complete 49399,1 
.complete 49399,2 
.complete 49399,3 
.mob Cutwater Duelist
.mob Blacktooth Knuckleduster
.mob Blacktooth Scrapper
.mob Vulpera Padfoot
.use 254873
step
.goto 895,77.78,85.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Ned|r
.skipgossip
.complete 49409,1 
.target Ned
step
.goto 895,77.77,85.27,5 >> Leave the |cFFfa9602house.|r
.isOnQuest 49409
step
.goto 895,77.29,85.84
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Irontide Recruiting Poster|r
>>|cRXP_WARN_Use your|r [ExtraActionButton] |cRXP_WARN_to disguise yourself to avoid being attacked.|r
.complete 49400,1,1 
step
.goto 895,76.85,85.8
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Irontide Recruiting Poster|r
>>|cRXP_WARN_Use your|r [ExtraActionButton] |cRXP_WARN_to disguise yourself to avoid being attacked.|r
.complete 49400,1,2 
step
.goto 895,76.75,85.93 >> Enter the |cFFfa9602House|r
.isOnQuest 49400
step
.goto 895,76.90,85.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carentan|r
.turnin 49290 >>Turn in Aged to Perfection
.accept 49407 >>Accept Trixie Business
.target Carentan
step
.goto 895,76.52,84.91
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Irontide Recruiting Poster|r
>>|cRXP_WARN_Use your|r [ExtraActionButton] |cRXP_WARN_to disguise yourself to avoid being attacked.|r
.complete 49400,1,3 
step
.goto 895,76.38,84.32
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nub Nub|r
.skipgossip
.complete 49409,2 
.target Nub Nub
step
.goto 895,76.45,84.25,5,0
.goto 895,76.28,84.24,5,0
.goto 895,76.13,83.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Nance Barmy|r
.skipgossip
.complete 49409,3 
.target Nance Barmy
step
.goto 895,76.47,82.63
.gossipoption 48508 >>Talk to |cRXP_FRIENDLY_First Mate Trixie Tornsail|r, |cRXP_WARN_then continue to follow the guide afterwards.|r
.timer 27, Trixie RP
.isOnQuest 49407
.target First Mate Trixie Tornsail
step
.goto 895,76.28,83.77
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Irontide Recruiting Poster|r
>>|cRXP_WARN_enemies may become hostile|r
.complete 49400,1,4 
step
.goto 895,76.77,82.65
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Irontide Recruiting Poster|r
>>|cRXP_WARN_enemies may become hostile|r
.complete 49400,1,5 
step
.goto 895,77.24,83.49
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Irontide Recruiting Poster|r
.complete 49400,1,6 
step
#completewith next
>>|cRXP_WARN_Follow |cRXP_FRIENDLY_First Mate Trixie Tornsail|r and wait for the brief roleplay, which will be completed when the timer runs out.|r
.isOnQuest 49407
.target First Mate Trixie Tornsail
step
.goto 895,76.47,82.63
>>Kill |cRXP_ENEMY_First Mate Trixie Tornsail|r
.complete 49407,1 
.mob First Mate Trixie Tornsail
step
.goto 895,75.62,80.57
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Sandy Seaweed-covered Chest.|r
.complete 49409,4 
step
.goto 895,76.29,80.77
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Dirty Diamond.|r
.complete 49409,5 
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 49409 >>Turn in Missing Treasure!
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 49409 >>Turn in Missing Treasure!
step
.goto 895,77.04,82.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rodrigo|r
.turnin 49402 >>Turn in Flew the Coop
.accept 49403 >>Accept Rodrigo's Revenge
.target Rodrigo
.isQuestComplete 49402
step
.goto 895,77.06,82.62
.vehicle >>Interact with the |cRXP_FRIENDLY_Riding Macaw|r
.target Riding Macaw
.isOnQuest 49403
step
>>Use |T1500941:0|t[Vile Bombardment] on |cRXP_ENEMY_Pirates|r
.complete 49403,1 
.isOnQuest 49403
.mob Cutwater Duelist
.mob Blacktooth Knuckleduster
.mob Blacktooth Scrapper
.mob Vulpera Padfoot
step
.goto 895,77.36,83.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Venrik|r
.turnin 49399 >>Turn in The Big Job
.accept 49404 >>Accept Fairwind's "Friends"
.turnin 49400,1 >>Turn in Recruiting Efforts
.target Venrik
.isQuestComplete 49402,49400
step
.goto 895,77.04,82.89
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rodrigo|r
.turnin 49403 >>Turn in Rodrigo's Revenge
.target Rodrigo
.isOnQuest 49403
step
.goto 895,76.75,85.93,5 >> Enter the |cFFfa9602House|r
.isOnQuest 49407
step
.goto 895,76.90,85.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Carentan|r
.turnin 49407 >>Turn in Trixie Business
.accept 49522 >>Accept Carentan's Payment
.target Carentan
step
.goto 895,76.81,85.97
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Dusty Crate|r
>>|cRXP_WARN_You'll be stunned after for 10seconds|r
.complete 49522,1 
.timer 10, Stun RP
step
#label Irontide Recruiting Poster
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 49522 >>Turn in Carentan's Payment
.accept 49523 >>Accept A Bad Deal
step
#completewith next
>>|cRXP_WARN_Use your|r [ExtraActionButton] |cRXP_WARN_on the |cRXP_FRIENDLY_Runaway Macaw|r |cFFfa9602in the sky.|r|r
.complete 49402,1 
.use 154878
step
>>Kill |cRXP_ENEMY_Bilge Rats|r, |cRXP_ENEMY_Cutwaters|r and |cRXP_ENEMY_Blacktooths|r and loot them for their |T1505940:0|t|cRXP_LOOT_Orders|r
>>|cRXP_WARN_Use your |r[ExtraActionButton] |cRXP_WARN_to disguise yourself and avoid being attacked. If you need to attack enemies, this will undo your disguise. Remember, you can reapply your disguise whenever you need it|r
.complete 49399,1 
.complete 49399,2 
.complete 49399,3 
.mob Cutwater Duelist
.mob Blacktooth Knuckleduster
.mob Blacktooth Scrapper
.mob Vulpera Padfoot
.use 254873
step
>>|cRXP_WARN_Use your|r [ExtraActionButton] |cRXP_WARN_on the |cRXP_FRIENDLY_Runaway Macaw|r |cFFfa9602in the sky.|r|r
.complete 49402,1 
.use 154878
step
>>Use |T1500941:0|t[Vile Bombardment] on |cRXP_ENEMY_Pirates|r
.complete 49403,1 
.isOnQuest 49403
.mob Cutwater Duelist
.mob Blacktooth Knuckleduster
.mob Blacktooth Scrapper
.mob Vulpera Padfoot
step
.goto 895,77.36,83.92
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Venrik|r
.turnin 49399 >>Turn in The Big Job
.accept 49404 >>Accept Fairwind's "Friends"
.turnin 49400,1 >>Turn in Recruiting Efforts
.target Venrik
.isQuestComplete 49402,49400
step
.goto 895,77.04,82.9
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Rodrigo|r
.turnin 49402 >>Turn in Flew the Coop
.accept 49403 >>Accept Rodrigo's Revenge
.target Rodrigo
.isQuestComplete 49402
step
.goto 895,77.06,82.62
.vehicle >>Interact with the |cRXP_FRIENDLY_Riding Macaw|r
.target Riding Macaw
.isOnQuest 49403
step
.goto 895,73.83,83.44,5 >>Enter |cFFfa9602the Ring of Booty.|r
.isOnQuest 49404
step
.goto 895,73.84,83.44
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Flynn Fairwind|r
.complete 49404,2 
.timer 42, Ring of Booty
.target Flynn Fairwind
step
.goto 895,73.56,83.43
>>|cRXP_WARN_Defend Flynn Fairwind.|r
.complete 49404,3 
.mob Cutwater Duelist
.mob Bristleback Horker
.mob Blacktooth Knuckleduster
.mob Cutwater Reaver
step
.goto 895,77.14,82.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Taelia|r
>>|cRXP_WARN_If you are quick enough you can avoid being picked up by a |cRXP_FRIENDLY_Gryphon|r; it's faster to manually fly to |cRXP_FRIENDLY_Taelia|r then to fly with the |cRXP_FRIENDLY_Gryphon.|r|r
>>|cRXP_WARN_You might have to run first before you are able to fly to get out of combat.|r
.turnin 49404,1 >>Turn in Fairwind's "Friends"
.accept 49405 >>Accept Defenders of Daelin's Gate
.target Taelia
step
.goto 895,77.14,82.9
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Galeheart|r
.complete 49405,1 
.target Galeheart
.timer 62,Flight
step
>>|cRXP_WARN_Wait for the brief flight, which will be completed when the timer runs out.|r
.complete 49405,2 
step
.goto 895,60.92,59.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Vigil Hill Refugee|r
.turnin 49405 >>Turn in Defenders of Daelin's Gate
.accept 52431 >>Accept No-Landing Zone
.target Vigil Hill Refugee
step
.goto 895,61.07,61.43
>>Kill |cRXP_ENEMY_Burnsy the Blade.|r
.complete 52431,1 
.timer 13, Wiley Jaki appears
.mob Burnsy the Blade
step
.goto 895,61.07,61.43
>>Kill |cRXP_ENEMY_Wiley Jaki.|r
.complete 52431,2 
.timer 13, Skullcrusher Cotner appears
.mob Wiley Jaki
step
.goto 895,61.07,61.43
>>Kill |cRXP_ENEMY_Skullcrusher Cotner.|r
.complete 52431,3 
.mob Skullcrusher Cotner
step
.goto 895,60.92,59.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Vigil Hill Refugee.|r
.turnin 52431 >>Turn in No-Landing Zone
.accept 49869 >>Accept A Desperate Defense
.target Vigil Hill Refugee
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Tarenfold|r and |cRXP_FRIENDLY_Taelia.|r
.turnin 49869 >>Turn in A Desperate Defense
.accept 52750 >>Accept Farmers Who Fight
.accept 49737 >>Accept Air Raid
.goto 895,56.67,61.19
.accept 52787 >>Accept Numbing the Pain
.goto 895,56.47,61.72
.target Lieutenant Tarenfold
.target Taelia
step
#completewith Vigil Hill Farmer
>>Kill |cRXP_ENEMY_Irontide Skyrider|r |cFFfa9602most of them are in the sky.|r
.complete 49737,1 
.mob Irontide Skyrider
step
.goto 895,55.98,61.27
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Evermoss Clump.|r
.complete 52787,1,1 
step
.goto 895,55.17,60.73
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Evermoss Clump.|r
.complete 52787,1,2 
step
.goto 895,55.16,60.4
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Evermoss Clump.|r
.complete 52787,1,3 
step
.goto 895,55.4,60.1
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Vigil Hill Farmer.|r
.complete 52750,1,1 
.target Vigil Hill Farmer
step
.goto 895,55.57,59.67
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Vigil Hill Farmer.|r
.complete 52750,1,2 
.target Vigil Hill Farmer
step
.goto 895,55.84,59.37
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Vigil Hill Farmer.|r
.complete 52750,1,3 
.target Vigil Hill Farmer
step
.goto 895,55.97,59.81
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Evermoss Clump|r
.complete 52787,1,4 
step
.goto 895,56.69,59.38
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Vigil Hill Farmer.|r
.complete 52750,1,4 
.target Vigil Hill Farmer
step
.goto 895,56.8,59.28
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Vigil Hill Farmer.|r
.complete 52750,1,5 
.target Vigil Hill Farmer
step
.goto 895,57.13,59.56
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cRXP_PICK_Evermoss Clump.|r
.complete 52787,1,5 
step
#label Vigil Hill Farmer
.goto 895,57.02,59.89
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Vigil Hill Farmer.|r
.complete 52750,1,6 
.target Vigil Hill Farmer
step
.loop 15,895,56.32,59.7,55.72,59.75,55.08,59.78,55.3,60.68
>>Kill |cRXP_ENEMY_Irontide Skyrider.|r
.complete 49737,1 
.mob Irontide Skyrider
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lieutenant Tarenfold|r and |cFF00FF25Taelia.|r
.turnin 52750 >>Turn in Farmers Who Fight
.turnin 49737 >>Turn in Air Raid
.accept 49738 >>Accept Hands Off My Booty!
.goto 895,56.67,61.18
.turnin 52787 >>Turn in Numbing the Pain
.goto 895,56.48,61.73
.target Taelia
.target Lieutenant Tarenfold
step
.goto 895,56.2,64.47
.isOnQuest 49738
.vehicle >>Click the |cRXP_FRIENDLY_Vigil Hill Cannon|r to enter it.
.target Vigil Hill Cannon
step
>>Use |T1035038:0|t(1) to Kill |cRXP_ENEMY_Looters.|r
.complete 49738,1 
.mob Looters
step
.isOnQuest 49738
.exitvehicle >>|cRXP_WARN_Jump off the cannon by pressing the |r[Exit] |cRXP_WARN_button on your action bars.|r
>>|cRXP_WARN_Alternatively, you can use this macro;|r
.link /leavevehicle>> CLICK HERE FOR MACRO.
>>|cRXP_WARN_It's recommended to safe this macro for future use.|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Lieutenant Tarenfold|r and |cFF00FF25Taelia.|r
.turnin 49738,2 >>Turn in Hands Off My Booty!
.accept 49740 >>Accept Cease Fire!
.accept 49736 >>Accept For Kul Tiras!
.goto 895,56.67,61.18
.accept 49741 >>Accept Righteous Retribution
.goto 895,56.48,61.73
.target Lieutenant Tarenfold
.target Taelia
step <<skip
.goto 895,56.83,65.58
>>Use |T967530:0|t[Proudmoore Battle Standard]|r to inspire |cRXP_FRIENDLY_Vigil Hill Militia.|r
.complete 49736,1,2 
.use 156520
.target Vigil Hill Marine
step
.goto 895,57.15,65.94
>>Use |T967530:0|t[Proudmoore Battle Standard]|r to inspire |cRXP_FRIENDLY_Vigil Hill Militia.|r
.complete 49736,1,3 
.use 156520
.target Vigil Hill Marine
step
.goto 895,55.37,67.82
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Crate.|r
.complete 49741,1 
step
.goto 895,55.75,67.48
>>Go |cFFfa9602near the Campfire|r and use your |cRXP_WARN_[Extra Action Button].|r
.complete 49741,2 
step
.goto 895,57.13,67.21
>>Use |T967530:0|t[Proudmoore Battle Standard]|r to inspire |cRXP_FRIENDLY_Vigil Hill Militia.|r
>>|cRXP_WARN_You'll might have to wait for the cd to be back up again.|r
.complete 49736,1,8 
.use 156520
.target Vigil Hill Marine
step
.goto 895,57.68,67.37
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Captured Cannon.|r
.complete 49740,1,1 
.target Captured Cannon
step
.goto 895,58.43,67.08
>>Use |T967530:0|t[Proudmoore Battle Standard]|r to inspire |cRXP_FRIENDLY_Vigil Hill Militia.|r
.complete 49736,1,11 
.use 156520
.target Vigil Hill Marine
step
.isOnQuest 49741
.goto 895,59.09,66.6
.vehicle >>Click on the |cRXP_PICK_Boat.|r
step
>>When the |cRXP_WARN_[Extra Action Button]|r appears, press it.
.complete 49741,4 
step
.isOnQuest 49741
.exitvehicle >>|cRXP_WARN_Jump off the boat by pressing the |r[Exit] |cRXP_WARN_button on your action bars.|r
>>|cRXP_WARN_Alternatively, you can use this macro;|r
.link /leavevehicle>> CLICK HERE FOR MACRO.
>>|cRXP_WARN_It's recommended to safe this macro for future use.|r
step
.goto 895,57.56,71.58
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Gryphon.|r
.complete 49741,5 
.target Gryphon
step
>>Throw |T136173:0|t(1)[Azerite Bomb] on 5 |cRXP_ENEMY_Powder Barrels.|r
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic.|r
.complete 49741,6 
step
.goto 895,57.2,70.09
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Captured Cannon.|r
.complete 49740,1,2 
.target Captured Cannon
step
.goto 895,57.41,69.67
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Captured Cannon.|r
.complete 49740,1,3 
.target Captured Cannon
step
.goto 895,56.75,68.91
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Captured Cannon.|r
.complete 49740,1,4 
.target Captured Cannon
step
.goto 895,57.15,67.21
>>Use |T967530:0|t[Proudmoore Battle Standard]|r to inspire |cRXP_FRIENDLY_Vigil Hill Militia.|r
.complete 49736,1,15 
.use 156520
.target Vigil Hill Marine
step
.goto 895,58.61,61.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Meredith|r
.accept 49757 >>Accept Cat on a Hot Copper Roof
.target Meredith
step
.goto 895,58.86,61.34
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Scratchy|r twice.
.complete 49757,1 
.target Scratchy
step
.goto 895,58.6,61.52
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Meredith|r
.turnin 49757 >>Turn in Cat on a Hot Copper Roof
.target Meredith
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lieutenant Tarenfold|r and |cFF00FF25Taelia.|r
.turnin 49740 >>Turn in Cease Fire!
.turnin 49736,2 >>Turn in For Kul Tiras!
.goto 895,56.67,61.19
.turnin 49741 >>Turn in Righteous Retribution
.accept 50110 >>Accept Bearers of Bad News
.goto 895,56.5,61.27
.target Taelia
.target Lieutenant Tarenfold
step
.goto 895,56.5,61.27
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Gryphon.|r
.complete 50110,1 
.timer 49, Flight Time
.target Gryphon
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 52544 >>Turn in The War Cache
.accept 53332 >>Accept Time of War
step
.goto 1161,49.12,75.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Taelia.|r
.turnin 50110 >>Turn in Bearers of Bad News
.accept 50795 >>Accept Prepare for Trouble
.target Taelia
step
.goto 1161,49.29,76.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cFF00FF25 Proudmoore Guard.|r
.skipgossip
.complete 50795,1,1 
.target Proudmoore Guard
step
.goto 1161,49.16,79.86
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cFF00FF25 Proudmoore Guard.|r
.skipgossip
.complete 50795,1,2 
.target Proudmoore Guard
step
.goto 1161,48.17,81.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cFF00FF25 Proudmoore Guard.|r
.skipgossip
.complete 50795,1,3 
.target Proudmoore Guard
step
.goto 1161,47.42,81.48
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to the |cFF00FF25 Proudmoore Guard.|r
.skipgossip
.complete 50795,1,4 
.target Proudmoore Guard
step
.goto 1161,47.40,81.53
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Taelia|r |cFFfa9602next to you.|r
.turnin 50795 >>Turn in Prepare for Trouble
.accept 50787 >>Accept Make Our Case
.target Taelia
step
.goto 1161,48.57,83.98
>>Follow the Arrow
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic.|r
.complete 50787,1 
step
.goto 1161,50.01,87.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Taelia.|r
.turnin 50795 >>Turn in Prepare for Trouble
.accept 50787 >>Accept Make Our Case
.target Taelia
step
.goto 1161,50.01,87.57
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Taelia.|r
.turnin 50787 >>Turn in Make Our Case
.accept 50788 >>Accept Enemies Within
.accept 50789 >>Accept Clear the Air
.target Taelia
step
#completewith Smoking Payload
>>Kill |cFFFF5722Ashvane Conspirators.|r
.complete 50788,1 
.mob Ashvane Conspirator
step
.goto 1161,49.37,86.93
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrel.|r
.complete 50789,1,1 
step
.goto 1161,49.5,84.7
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrel.|r
.complete 50789,1,2 
step
.goto 1161,48.54,85.5
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrel.|r
.complete 50789,1,3 
step
#label Smoking Payload
.goto 1161,48.2,82.48
>>|TInterface/cursor/crosshair/interact.blp:20|tClick on the |cRXP_PICK_Barrel.|r
.complete 50789,1,4 
step
.loop 10,1161,49.37,86.93,49.5,84.7,48.54,85.5,48.2,82.48
>>Kill |cFFFF5722Ashvane Conspirators.|r
.complete 50788,1 
.mob Ashvane Conspirator
step
.goto 1161,47.76,81.39
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 50789 >>Turn in Clear the Air
.turnin 50788 >>Turn in Enemies Within
.accept 50790 >>Accept Hot Pursuit
step
.goto 1161,47.76,81.39
>>|TInterface/cursor/crosshair/interact.blp:20|tInteract with |cRXP_FRIENDLY_Proudmoore Charger.|r
.complete 50790,1 
.timer 82, Ashvane Pursuit
.target Proudmoore Charger
step
>>Spam |T236171:0|t(1) and |T136103:0|t(2) to sprint and jump over nearby obstacles.
.complete 50790,2 
step
>>|cRXP_WARN_BE QUICK!|r
.exitvehicle >> |cRXP_WARN_Leave the Horse by pressing the |r[Exit] |cRXP_WARN_button on your action bars.|r
*|cRXP_WARN_Alternatively, you can use this macro;|r
.link /leavevehicle>> CLICK HERE FOR MACRO.
*|cRXP_WARN_It's recommended to safe this macro for future use.|r
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Taelia|r and |cFF00FF25Katherine Proudmoore.|r
.turnin 50790 >>Turn in Hot Pursuit
.goto 1161,48.26,80.67
.accept 50972 >>Accept Proudmoore's Parley
.goto 1161,48.42,80.87
.target Taelia
.target Katherine Proudmoore
step
.goto 1161,68.05,22.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Genn Greymane|r |cFFfa9602inside the Harbormaster's Office.|r
.turnin 50972,1 >>Turn in Proudmoore's Parley
.target Genn Greymane
step
.goto 1161,68.42,22.00
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cRXP_PICK_Scouting Map|r
.accept 47961 >>Accept Drustvar
step
.goto 1161,68.16,21.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Taelia|r
.turnin 47961 >>Turn in Drustvar
.accept 48622 >>Accept The Vanishing Lord
.target Taelia
step
.goto 1161,69.27,26.90
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Halford Wyrmbane|r
.turnin 53332 >>Turn in Time for War
.target Halford Wyrmbane
step
.goto 1161,69.72,27.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Falstad Wildhammer|r
.accept 51714 >>Accept Mission from the King
.target Halford Wyrmbane
step
.goto 1161,70.72,27.10
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_FRIENDLY_Master Mathias Shaw|r
.turnin 51714 >>Turn in Mission from the King
]])
RXPGuides.RegisterGuide([[
#df
#version 4
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
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rosaline Madison|r
.accept 49302 >>Accept The Deadliest Catch
step
.goto 895,35.29,24.57
.skipgossip 1
.complete 49302,1 
step
>>Click the |cRXP_PICK_Cannon|r
.goto 895,36.33,29.82
.complete 49302,2 
step
>>Shoot Harpoons at the Purple Bubbles
.complete 49302,3 
step
>>Click the |cRXP_PICK_Gryphon|r
.goto 895,36.77,29.71
.complete 49302,5 
step
.goto 895,42.47,29.35
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brannon Stormsong|r
.turnin 49302,1 >>Turn in The Deadliest Catch
step
.goto 896,62.54,23.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25David Maldus|r
.accept 48677,1 >>Accept Wicker Worship
step
.goto 896,59.45,21.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lord Autumnvale|r
.turnin 48677,1 >>Turn in Wicker Worship
.accept 48678,1 >>Accept Questionable Offerings
step
>>Deliver |cRXP_PICK_Entrails|r to Lord Autumvale
.goto 896,59.88,21.99
.complete 48678,1,1 
step
>>Deliver |cRXP_PICK_Wicker|r to Lord Autumvale
.goto 896,59.88,21.99
.complete 48678,1,2 
step
>>Deliver |cRXP_PICK_Bones|r to Lord Autumvale
.goto 896,59.89,21.96
.complete 48678,1,3 
step
>>Wait for the Roleplay Duration
.complete 48678,2 

step
.goto 896,59.45,21.91
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lord Autumnvale|r
.turnin 48678 >>Turn in Questionable Offerings
.accept 48679 >>Accept Mind the Hives
step
.goto 896,60.65,18.19,10,0 >>Go inside the Cave
.goto 896,60.62,17.77
.complete 48679,1 
step
>>Defend Edwin from the |cRXP_ENEMY_Bee's|r
.goto 896,60.62,17.77
.complete 48679,2 

step
.goto 896,60.65,18.19,10,0 >>Go outside the Cave
.goto 896,59.03,22.37
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Initiate Peony|r
.turnin 48679 >>Turn in Mind the Hives
.accept 48682 >>Accept A Simple Sacrifice
step
>>Kill |cRXP_ENEMY_Lord Autumnvale|r
.goto 896,56.50,24.05
.complete 48682,1 
step
.goto 896,56.49,24.01
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Edwin Maldus|r
.turnin 48682 >>Turn in A Simple Sacrifice
.accept 48683 >>Accept Changing Seasons
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Edwin Maldus|r
.goto 896,59.35,21.98
.complete 48683,1 
step
>>Click the |cRXP_PICK_Wickerman|r
.goto 896,59.35,21.98
.complete 48683,2 
step
.goto 896,59.35,21.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Edwin Maldus|r
.turnin 48683 >>Turn in Changing Seasons
step
.goto 896,63.25,27.05
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thomas Staughton|r
.accept 47946 >>Accept Save Their Bacon
.accept 47947 >>Accept Big Bad Wolves
.accept 47948 >>Accept Pork Chop
step
#sticky
#label bacon
.goto 896,64.07,31.70
>>Kill |cRXP_ENEMY_Beasts|r
.complete 47947,1 
step
>>Click on |cRXP_FRIENDLY_Pig Trevor|r
.goto 896,64.24,28.31
.complete 47946,1 
step
>>Click on |cRXP_FRIENDLY_Pig Travis|r
.goto 896,63.62,29.32
.complete 47946,2 
step
.goto 896,63.35,30.09
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Pig Effigy|r
.accept 47949 >>Accept That's Not My Fetish
step
>>Kill |cRXP_ENEMY_Roland|r
.goto 896,63.61,30.41
.complete 47948,1 
step
>>Click on |cRXP_FRIENDLY_Pig Purke|r
.goto 896,64.05,31.52
.complete 47946,4 
step
>>Click on |cRXP_FRIENDLY_Pig Kyle|r
.goto 896,64.70,30.21
.complete 47946,3 
step
#requires bacon
.goto 896,63.25,27.04
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thomas Staughton|r
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
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thomas Staughton|r
.turnin 47950 >>Turn in Cured Ham
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to Cyril White by talking to Cyril White you skip the Ferry Step
.goto 896,56.14,35.29
.skipgossip 1
.complete 48622,2 
step
>>Click the |cRXP_PICK_Effigy|r
.goto 896,55.87,35.07
.complete 48622,3 
step
.goto 896,55.87,35.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Cursed Effigy|r
.turnin 48622 >>Turn in The Vanishing Lord
step
.goto 896,56.13,35.30
>>Click the |cRXP_PICK_Major's Bulletin|r
.accept 47968 >>Accept Signs and Portents
step
>>Click the |cRXP_PICK_Letter|r
.goto 896,57.95,35.69
.complete 47968,2 
step
>>Click the |cRXP_PICK_Notebook|r
.goto 896,55.21,35.97
.complete 47968,3 
step
>>Click the |cRXP_PICK_Journal|r
.goto 896,55.27,35.48,5,0
.goto 896,53.22,35.13
.complete 47968,1 
step
.goto 896,55.64,35.74
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Fallhaven Ledger|r
.turnin 47968 >>Turn in Signs and Portents
.accept 47978 >>Accept The Wayward Crone
step
.goto 896,60.51,31.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Helena Gentle|r
.turnin 47978 >>Turn in The Wayward Crone
.accept 47979 >>Accept Witch Hunt
step
>>Click the |cRXP_PICK_Chair|r
.goto 896,60.48,31.59
.complete 47979,1 
.timer 13, Helene Gentle RP
step
.goto 896,60.58,31.47
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Gentle's Spellbook|r
.accept 47981 >>Accept Cracking the Curse
step
.goto 896,60.85,30.64
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Fallhaven Villager|r
.accept 47980 >>Accept Furious Familiars
step
#sticky
#completewith Enthralled Wildlife
>>Kill the |cRXP_ENEMY_Wildlife|r in the Area
.complete 47980,1 
.mob Ensorcelled Bonepicker
.mob Bewitched Darkmaw
step
>>Click the |cRXP_PICK_Lesser Effigy|r
.goto 896,59.58,28.32
.complete 47981,1,1 
step
>>Kill |cRXP_ENEMY_Helena|r and Click the |cRXP_PICK_Lesser Effigy|r
.goto 896,57.79,28.14
.mob Helena
.complete 47979,2 
.complete 47981,1,2 
.goto 896,57.66,27.81
step
>>Click the |cRXP_PICK_Lesser Effigy|r
.goto 896,57.54,30.06
.complete 47981,1,3 
step
#label Enthralled Wildlife
>>Click the |cRXP_PICK_Lesser Effigy|r
.goto 896,56.15,29.09
.complete 47981,1,4 
step
.loop 30,896,59.58,28.32,57.79,28.14,57.54,30.06,56.15,29.09
>>Kill the |cRXP_ENEMY_Wildlife|r in the Area
.complete 47980,1 
.mob Ensorcelled Bonepicker
.mob Bewitched Darkmaw
step
>>|cRXP_WARN_Select the option to turn in your quest from the pop-up in your quest log.|r
.turnin 47980 >>Turn in Furious Familiars
.turnin 47979 >>Turn in Witch Hunt
step
.goto 896,55.87,35.06
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Cursed Effigy|r
.turnin 47981 >>Turn in Cracking the Curse
.accept 47982 >>Accept The Final Effigy
step
>>Click the |cRXP_PICK_Cursed Effigy|r
.goto 896,55.87,35.06
.complete 47982,1 
step
>>Kill the |cRXP_ENEMY_Deathcursed Terror|r
.complete 47982,2 
step
.goto 896,55.87,35.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Cyril White|r
.turnin 47982,2 >>Turn in The Final Effigy
.accept 48108 >>Accept The Waycrest Daughter
step
.goto 896,55.74,34.99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Wanted Poster|r
.accept 51547 >>Accept WANTED: Rindlewoe
step
.goto 896,55.16,35.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Maude Rifthold|r
.accept 48948 >>Accept The North Pass Caverns
step
>>Kill |cRXP_ENEMY_Rindlewoe|r
>>|cRXP_WARN_Skip this Quest if it's too difficult|r
.goto 896,52.33,28.94
.complete 51547,1 
step
.goto 896,53.93,26.97
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thaddeus "Gramps" Rifthold|r
.turnin 48948 >>Turn in The North Pass Caverns
step
.goto 896,53.93,26.98
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thaddeus "Gramps" Rifthold|r
.accept 48793 >>Accept The Adventurer's Society
.accept 48792 >>Accept Menace to Society
step
#sticky
#label troggs
>>Kill Troggs
.complete 48792,1 
step
>>Click the |cRXP_PICK_Backpack|r
.goto 896,53.37,25.78
.skipgossip 1
.complete 48793,1 
step
>>Click the |cRXP_PICK_Scroll|r in the Cave
.goto 896,53.52,23.24
.complete 48793,2 
step
>>Click the |cRXP_PICK_Book|r
.goto 896,53.05,22.42
.complete 48793,3 
step
>>Click the |cRXP_PICK_Journal|r
.goto 896,51.81,24.14
.complete 48793,4 
step
.goto 896,51.37,23.27
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marcus Howlingdale|r
.turnin 48793 >>Turn in The Adventurer's Society
.accept 48804 >>Accept Mistakes Were Made
step
.goto 896,51.82,22.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tClick the |cRXP_PICK_Scroll|r
.accept 48805 >>Accept Research Recovery
step
>>Click the |cRXP_PICK_Disk|r
.goto 896,51.59,21.92
.complete 48805,2 
step
>>Interact with |cRXP_FRIENDLY_Amelia|r
.goto 896,51.66,21.46
.complete 48804,2 
step
>>Interact with |cRXP_FRIENDLY_Jonathan|r
.goto 896,52.67,20.97
.complete 48804,1 
step
.goto 896,50.76,20.22
.complete 48805,1 
step
>>Interact with |cRXP_FRIENDLY_Chase|r
.goto 896,50.64,22.09
.complete 48804,3 
step
>>Click the |cRXP_PICK_Shards|r
.goto 896,51.14,22.53
.complete 48805,3 
step
#requires troggs
.goto 896,50.61,24.30
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marcus Howlingdale|r
.turnin 48805 >>Turn in Research Recovery
.turnin 48804 >>Turn in Mistakes Were Made
.turnin 48792 >>Turn in Menace to Society
.accept 48853 >>Accept Terminal Degree
step
.goto 896,49.68,23.52
>>Kill |cRXP_ENEMY_Cragg|r
.complete 48853,1 
step
.goto 896,49.41,23.39
>>Interact with |cRXP_PICK_Nigel|r
.complete 48853,2 
step
.goto 896,50.59,24.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thaddeus "Gramps" Rifthold|r
.turnin 48853 >>Turn in Terminal Degree
step
.goto 896,55.87,35.13
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Cyril White|r
.turnin 51547 >>Turn in WANTED: Rindlewoe
step
.goto 896,54.55,39.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Abby Lewis|r
.accept 47289 >>Accept Teddies and Tea
step
.goto 896,56.29,38.15
>>Click |cRXP_PICK_Plush 1|r
.complete 47289,3 
step
.goto 896,55.61,38.55
>>Click |cRXP_PICK_Plush 2|r
.complete 47289,1 
step
.goto 896,55.39,39.76
>>Click |cRXP_PICK_Plush 3|r
.complete 47289,2 
step
.goto 896,56.29,38.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Abby Lewis|r
.turnin 47289 >>Turn in Teddies and Tea
.accept 47428 >>Accept Kitty?
step
.goto 896,55.60,41.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Smoochums|r
.turnin 47428 >>Turn in Kitty?
step
.goto 896,54.55,39.23
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Abby Lewis|r
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
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Abby Lewis|r
.turnin 47289 >>Turn in Teddies and Tea
.accept 47428 >>Accept Kitty?
step
.goto 896,55.60,41.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Smoochums|r
.turnin 47428 >>Turn in Kitty?
.accept 45079 >>Accept The Village of Glenbrook
step
.goto 896,55.53,45.26
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Samuel|r
.complete 45079,3 
step
.goto 896,57.16,46.42
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Jonathan|r
.complete 45079,2 
step
.goto 896,53.15,44.43
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Mary|r
.complete 45079,1 
step
.goto 896,54.74,49.15
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Annie Warren|r
.turnin 45079 >>Turn in The Village of Glenbrook
.accept 44785 >>Accept Tea Party
step
>>Follow the Waypoint
.goto 896,56.39,49.04
.complete 44785,1 
step
>>Click the |cRXP_PICK_Tea|r
.goto 896,58.19,47.90
.complete 44785,2 
step
>>Click the |cRXP_PICK_Monster|r
.goto 896,58.19,47.90
.complete 44785,3 
step
.goto 896,57.70,47.73
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Annie Warren|r
.turnin 44785 >>Turn in Tea Party
step
.goto 896,70.09,42.94
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Constable Henry Framer|r
.turnin 48108 >>Turn in The Waycrest Daughter
.accept 48283 >>Accept Standing Accused
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lucille Waycrest|r
.goto 896,70.09,42.94
.skipgossip 1
.complete 48283,1 
step
.goto 896,69.67,43.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Everit Reade|r
.turnin 48283 >>Turn in Standing Accused
.accept 48109 >>Accept The Woods Have Eyes
.accept 48110 >>Accept In Case of Ambush
step
#sticky
#completewith Trap
>>Kill |cRXP_ENEMY_Ravens and Wolves|r
.complete 48109,2 
.complete 48109,1 
.mob Darkmaw Prowler
.mob Watchful Raven
step
.goto 896,68.97,44.00
>>Click the |cRXP_PICK_Trap|r
.complete 48110,1,1 
step
.goto 896,68.48,44.83
>>Click the |cRXP_PICK_Trap|r
.complete 48110,1,2 
step
.goto 896,68.03,44.76
>>Click the |cRXP_PICK_Trap|r
.complete 48110,1,3 
step
.goto 896,68.25,44.17
>>Click the |cRXP_PICK_Trap|r
.complete 48110,1,4 
step
.goto 896,67.57,43.01
>>Click the |cRXP_PICK_Trap|r
.complete 48110,1,5 
step
.goto 896,68.43,42.92
#label Trap
>>Click the |cRXP_PICK_Trap|r
.complete 48110,1,6 
step
>>Kill |cRXP_ENEMY_Ravens and Wolves|r
.loop 30,896,68.97,44.00,68.48,44.83,68.03,44.76,68.25,44.17,67.57,43.01,68.43,42.92
.complete 48109,2 
.complete 48109,1 
.mob Darkmaw Prowler
.mob Watchful Raven
step
.goto 896,69.66,43.18
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Marshal Everit Reade|r
.turnin 48109 >>Turn in The Woods Have Eyes
.turnin 48110 >>Turn in In Case of Ambush
step
.goto 896,70.08,42.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lucille Waycrest|r
.accept 48111 >>Accept Trial by Superstition
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Villager 1|r
.goto 896,69.89,42.83
.skipgossip 1
.complete 48111,1,1 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Villager 2|r
.goto 896,69.90,42.91
.skipgossip 1
.complete 48111,1,2 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Villager 3|r
.goto 896,69.98,42.99
.skipgossip 1
.complete 48111,1,3 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Villager 4|r
.goto 896,70.04,43.03
.skipgossip 1
.complete 48111,1,4 
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Villager 5|
.goto 896,70.04,43.14
.skipgossip 1
.complete 48111,1,5 
step
.goto 896,70.08,42.83
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|trTalk to |cFF00FF25Lucille Waycrest|r
.turnin 48111 >>Turn in Trial by Superstition
.accept 48113 >>Accept A Pungent Solution
.accept 48165 >>Accept Harmful If Swallowed
.accept 48170 >>Accept Once Bitten, Twice Shy
step
>>Click the |cRXP_PICK_Jar|r
.goto 896,69.52,43.85
.complete 48170,1 
step
#completewith flies
>>Kill |cFFFF5722Saurolisks|r and Loot them for their |cRXP_LOOT_Glands|r
.complete 48165,1 
step
.goto 896,69.06,41.7
>>Click the |cRXP_PICK_Fly|r
.complete 48170,2,1 
step
.goto 896,68.7,41.33
>>Click the |cRXP_PICK_Fly|r
.complete 48170,2,2 
step
.goto 896,69.23,40.67
>>Click the |cRXP_PICK_Fly|r
.complete 48170,2,3 
step
.goto 896,69.02,40.16
>>Click the |cRXP_PICK_Fly|r
.complete 48170,2,4 
step
.goto 896,68.14,40.39
>>Click the |cRXP_PICK_Fly|r
.complete 48170,2,5 
step
#label flies
.goto 896,67.29,41.23
>>Click the |cRXP_PICK_Fly|r
.complete 48170,2,6 
step
.goto 896,66.91,42.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Adela Hawthorne|r
.accept 49242 >>Accept Quill or Be Quilled
step
#completewith next
>>Kill |cRXP_ENEMY_Quillrats|r
.complete 49242,1 
.mob Invasive Quillrat
step
>>Click the |cRXP_PICK_Onions|r on the Ground until you find the |cRXP_LOOT_Juicy Onion|r
.loop 15,896,66.69,42.05,66.15,42.84,65.58,42.21,66.02,41.55
.complete 48113,1,1 
step
>>Kill |cRXP_ENEMY_Quillrats|r
.loop 15,896,66.69,42.05,66.15,42.84,65.58,42.21,66.02,41.55
.complete 49242,1 
.mob Invasive Quillrat
step
.goto 896,66.93,42.16
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Adela Hawthorne|r
.turnin 49242 >>Turn in Quill or Be Quilled
step
.loop 896,69.06,41.7,68.7,41.33,69.23,40.67,69.02,40.16,68.14,40.39
>>Kill |cFFFF5722Saurolisks|r and Loot them for their |cRXP_LOOT_Glands|r
.complete 48165,1 
step
.goto 896,70.07,42.82
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Lucille Waycrest|r
.turnin 48113 >>Turn in A Pungent Solution
.turnin 48170 >>Turn in Once Bitten, Twice Shy
.turnin 48165 >>Turn in Harmful If Swallowed
step
.goto 896,71.80,50.41
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Art Hughie|r
.accept 48880 >>Accept Mean Gulls
.accept 48904 >>Accept Take the Bait
step
#completewith Guts
>>Kill |cFFFF5722Crabs|r Loot them for their |cFF00BCD4Meat|r
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
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Intact Mudfish|r
.accept 48882 >>Accept I Like Fish Guts and I Cannot Lie
step
#completewith Guts2
>>Kill |cFFFF5722Crabs|r Loot them for their |cFF00BCD4Meat|r
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
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Fishing Rod|r
.accept 48881 >>Accept The Reel Deal
step
#completewith Guts3
>>Kill |cFFFF5722Crabs|r Loot them for their |cFF00BCD4Meat|r
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
>>Kill |cFFFF5722Crabs|r Loot them for their |cFF00BCD4Meat|r
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
>>Kill |cFFFF5722Crabs|r Loot them for their |cFF00BCD4Meat|r
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
>>Kill |cFFFF5722Crabs|r Loot them for their |cFF00BCD4Meat|r
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
>>Kill |cFFFF5722Crabs|r Loot them for their |cFF00BCD4Meat|r
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
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Art Hughie|r
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
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Art Hughie|r
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
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Aaron Cresterly|r
.turnin 48475 >>Turn in Seeing Spirits
.accept 48476 >>Accept Split Party
step
>>Kill Wicker-Bound Hunter
.goto 896,60.32,47.96
.complete 48476,1 
step
.goto 896,59.80,48.94
>>wait for the small roleplay
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Bridget Fairwater|r
.turnin 48476 >>Turn in Split Party
.accept 48477 >>Accept Looking For One More
step
>>Kill Sister Westwood
.goto 896,59.07,50.33
.complete 48477,1 
step
.goto 896,59.50,51.19
>>Wait for the Small Roleplay
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Mercy Fairwater|r
.turnin 48477 >>Turn in Looking For One More
step
.goto 896,64.58,54.81
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Rebecca Hale|r
.accept 52074 >>Accept Deliverance
step
.goto 896,61.91,59.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Ranger Wons|r
.turnin 52074 >>Turn in Deliverance
.accept 48179 >>Accept Rescue Rangers
.accept 52075 >>Accept Boned
step
.goto 896,61.87,59.34
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thornspeaker Birchgrove|r
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
>>Kill |cFFFF5722Elementals|r Loot them for their |cFF00BCD4Cores|r
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
>>Kill |cFFFF5722Elementals|r Loot them for their |cFF00BCD4Cores|r
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
>>Kill |cFFFF5722Elementals|r Loot them for their |cFF00BCD4Cores|r
.complete 48183,1 
step
#label 3
>>Click the Ancient Cairn
.goto 896,59.46,63.74
.complete 48182,1,3 
step
.goto 896,58.45,63.17
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Arthur Tradewind|r
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
>>Kill |cFFFF5722Elementals|r Loot them for their |cFF00BCD4Cores|r
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
>>Kill |cFFFF5722Elementals|r Loot them for their |cFF00BCD4Cores|r
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
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Thornspeaker Birchgrove|r
.turnin 48180 >>Turn in Really Big Problem
.turnin 48182 >>Turn in Total Cairnage
.turnin 48183 >>Turn in The Hills Are Alive
step
.goto 896,61.91,59.29
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Ranger Wons|r
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
#version 4
#group RestedXP Alliance 10-60
#name ZA_WarCampaign
#displayname Final Chapter - Zuldazar War Campaign
<<Alliance
step
#completewith Brigadier Thom
.goto 1161,67.96,26.66
.gossipoption 48168 >>Talk to |cFF00FF25Grand Admiral Jes-Tereth|r
.target Grand Admiral Jes-Tereth
step
#label Brigadier Thom
.goto 862,77.54,54.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brigadier Thom|r
.turnin 51308 >>Turn in Zuldazar Foothold
.accept 51201 >>Accept The Troll's Tale
.target Brigadier Thom
step
.goto 862,77.51,54.6
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cRXP_ENEMY_Captured Zandalari Troll|r
>>|cFFFCDC00Press "Escape" on your keyboard to skip the cinematic.|r
.skipgossip 1
.complete 51201,1 
.target Captured Zandalari Troll
step
.goto 862,77.54,54.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brigadier Thom|r
.turnin 51201 >>Turn in The Troll's Tale
.accept 51190 >>Accept Granting a Reprieve
.accept 51544 >>Accept Disarming the Cannons
.target Brigadier Thom
step
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Medic Feorea|r and |cFF00FF25Degdod|r
.accept 51191 >>Accept Save Them All
.goto 862,77.13,55.54
.accept 51192 >>Accept A Lack of Surplus
.accept 51193 >>Accept That One's Mine
.goto 862,77.13,55.59
.target Degdod
.target Medic Feorea
step
#completewith ZandalariForsakens
>>Kill |cFFFF5722Zandalari|r and |cFFFF5722Forsakens.|r
.complete 51190,2 
.complete 51190,1 
.mob Zandalari Quickblade
.mob Forsaken Deathguard
.mob Zandalari Axe Thrower
.mob Bleak Conjurer
step
.goto 862,78.46,52.01
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFCrate|r on the Ground.
.complete 51192,1,1 
step
.goto 862,78.51,51.95
>>Interact with the |cFF00FF25Injured Sailor|r
.complete 51191,1,1 
.use 160433
.target Injured Shipwrecked Sailor
step
.goto 862,78.55,53.05
>>Interact with the |cFF00FF25Injured Sailor|r
.complete 51191,1,2 
.use 160433
.target Injured Shipwrecked Sailor
step
.goto 862,79.00,53.96
>>Interact with the |cFF00FF25Injured Sailor|r
.complete 51191,1,3 
.use 160433
.target Injured Shipwrecked Sailor
step
.goto 862,79.71,53.63
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFCrate|r on the Ground.
.complete 51192,1,2 
step
.goto 862,79.52,55.02
>>Interact with the |cFF00FF25Injured Sailor|r
.complete 51191,1,4 
.use 160433
.target Injured Shipwrecked Sailor
step
.goto 862,80.14,55.02
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFCrate|r on the Ground.
.complete 51192,1,3 
step
.goto 862,80.19,55.26
>>Interact with the |cFF00FF25Injured Sailor|r
.complete 51191,1,5 
.use 160433
.target Injured Shipwrecked Sailor
step
.goto 862,80.96,54.31
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFCrate|r on the Ground.
.complete 51192,1,4 
step
.goto 862,80.90,53.69
>>Interact with the |cFF00FF25Injured Sailor|r
.complete 51191,1,5 
.use 160433
.target Injured Shipwrecked Sailor
step
.goto 862,80.90,53.69
>>Interact with the |cFF00FF25Injured Sailor|r
.complete 51191,1,6 
.use 160433
.target Injured Shipwrecked Sailor
step
.goto 862,80.81,53.27
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFCrate|r on the Ground.
.complete 51192,1,5 
step
.goto 862,80.93,53.44
>>Interact with the |cFF00FF25Injured Sailor|r
.complete 51191,1,7 
.use 160433
.target Injured Shipwrecked Sailor
step
.goto 862,80.89,53.39
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFCrate|r on the Ground.
.complete 51192,1,6 
step
.goto 862,81.09,53.86
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFCrate|r on the Ground.
.complete 51192,1,7 
step
.goto 862,81.47,53.84
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFCrate|r on the Ground.
.complete 51192,1,8 
step
.goto 862,81.52,53.78
>>Interact with the |cFF00FF25Injured Sailor|r
.complete 51191,1,8 
.use 160433
.target Injured Shipwrecked Sailor
step
.goto 862,83.35,54.73
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cRXP_PICK_Cannon|r
.complete 51544,1,1 
step
.goto 862,83.34,54.4
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cRXP_PICK_Cannon|r
.complete 51544,1,2 
step
.goto 862,83.34,54.21
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cRXP_PICK_Cannon|r
.complete 51544,1,3 
step
#label ZandalariForsakens
.goto 862,81.94,51.43
>>Kill|cFFFF5722 Major Alan Hawkins|r and loot him for his |T133041:0|t|cFF00BCD4Hammer|r
|cFFFCDC00Kill the remaining Zandalari and Forsakens|r
.complete 51193,1 
step
.loop 15,862,80.71,52.64;79.85,53.56,80.82,55.67,82.23,54.63
>>Kill |cFFFF5722Zandalari|r and |cFFFF5722Forsakens.|r
.complete 51190,2 
.complete 51190,1 
.mob Zandalari Quickblade
.mob Forsaken Deathguard
.mob Zandalari Axe Thrower
.mob Bleak Conjurer
step
.goto 862,77.54,54.58
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Brigadier Thom|r
.turnin 51190 >>Turn in Granting a Reprieve
.turnin 51544 >>Turn in Disarming the Cannons
.target Brigadier Thom
step
.goto 862,77.12,55.54
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Medic Feorea|r
.turnin 51191 >>Turn in Save Them All
.target Medic Feorea
step
.goto 862,77.13,55.59
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Degdod|r
.turnin 51192 >>Turn in A Lack of Surplus
.turnin 51193 >>Turn in That One's Mine
.target Degdod
step
.goto 862,77.50,55.22
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kelsey Steelspark|r
.accept 51418 >>Accept Xibala
.target Kelsey Steelspark
step
.goto 862,80.35,55.41
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFF00FF25boat|r
.complete 51418,1 
.timer 128,Travel to Xibala RP
step
.goto 862,40.74,70.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Anvil-Thane Thurgaden|r
.turnin 51418 >>Turn in Xibala
.accept 51331 >>Accept Mole Machinations
.accept 51309 >>Accept Rocks of Ragnaros
.target Anvil-Thane Thurgaden
step
.goto 862,39.56,72.78
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFSlag|r
.complete 51309,1,1 
step
.goto 862,39.62,72.86
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFSlag|r
.complete 51309,1,2 
step
.goto 862,39.57,73.13
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFMole Machine|r
.complete 51331,1,1 
step
.goto 862,39.63,73.45
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFSlag|r
.complete 51309,1,3 
step
.goto 862,39.63,73.52
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFSlag|r
.complete 51309,1,4 
step
.goto 862,39.58,73.61
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFSlag|r
.complete 51309,1,5 
step
.goto 862,39.37,73.7
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFMole Machine|r
.complete 51331,1,2 
step
.goto 862,39.15,73.86
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFSlag|r
.complete 51309,1,6 
step
.goto 862,39.11,73.82
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFSlag|r
.complete 51309,1,7 
step
.goto 862,39.05,73.79
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFSlag|r
.complete 51309,1,8 
step
.goto 862,39.12,73.67
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFSlag|r
.complete 51309,1,9 
step
.goto 862,39.1,72.98
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFMole Machine|r
.complete 51331,1,3 
step
.goto 862,39.03,72.35
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFFDB2EEFMole Machine|r
.complete 51331,1,4 
step
.goto 862,40.74,70.85
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Anvil-Thane Thurgaden|r
.turnin 51331 >>Turn in Mole Machinations
.turnin 51309 >>Turn in Rocks of Ragnaros
.accept 51359 >>Accept Fragment of the Firelands
.target Anvil-Thane Thurgaden
step
.goto 862,40.65,70.88
>>|TInterface/cursor/crosshair/interact.blp:20|tClick the |cFF00FF25Unstable Magma|r
.complete 51359,1 
.use 160058
.target Unstable Magma
step
.goto 862,32.92,69.69
>>To effectively kill the |cRXP_ENEMY_Goblins|r, use |T135808:0|t(2) when it's available and switch to |T525023:0|t(1) when |T135808:0|t(2) is on cooldown.
.complete 51359,2 
step
#completewith next
+Press the ability |T236372:0|tDismiss Magma Elemental
step
.goto 862,40.74,70.84
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Anvil-Thane Thurgaden|r
.turnin 51359 >>Turn in Fragment of the Firelands
.target Anvil-Thane Thurgaden
step
.goto 862,40.77,70.67
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Kelsey Steelspark|r
.turnin 52003 >>Turn in Champion: Kelsey S
.accept 51968 >>Accept Talk to Boralus
.target Kelsey Steelspark
step
.goto 862,40.46,71.02
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Daria|r
.complete 51968,1 
.skipgossip 1
.target Daria Smithson
step
.goto 1161,69.29,26.99
>>|Tinterface/worldmap/chatbubble_64grey.blp:20|tTalk to |cFF00FF25Halford Wyrmbane|r
.turnin 51968 >>Turn in Return to Boralus
.target Halford Wyrmbane
step
.next << 5
]])
